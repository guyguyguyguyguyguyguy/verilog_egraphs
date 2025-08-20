import re
import z3
import igraph as ig

import multiprocessing as mp
import os
import matplotlib.pyplot as plt
import numpy as np
import gc
import traceback

from itertools import combinations, chain
from collections import defaultdict
import random

def_pat = re.compile(r'.*define-fun.*')
func_pat = re.compile(r'(?:Bool|\(_\s+BitVec\s+\d+\))\s+(.*)\)')
var_pat = re.compile(r'\((\w+)\s+(?:(Bool)|\(_\s+(BitVec)\s+(\d+)\))\)')


import z3
from itertools import combinations

class PowerLattice:
    def __init__(self, funs):
        self.decls = {}
        defined_funs, base = funs
        self.base = list(base)
        self.generate_vars(defined_funs)

        self._base = frozenset(range(len(self.base)))
        self.curr_best = (self._base, len(self.base))
        self.tried = set()
        self.l = len(self.base)
        self.rel_lattice = self.generate_rel_lattice(self._base, self.l)

        self.base_refs = [z3.parse_smt2_string(f"(assert {b})", decls=self.decls)[0]
                        for b in self.base]
        self.neg_refs = [z3.Not(r) for r in self.base_refs]
        self.s = z3.Solver()

    def generate_vars(self, exprs):
        for expr in exprs:
            for m in var_pat.findall(expr):
                match m:
                    case [n, '', _, w]:
                        self.decls[n] = z3.BitVec(n, int(w))
                    case [n, _, '', '']:
                        self.decls[n] = z3.Bool(n)

    def generate_rel_lattice(self, A, l):
        for t in combinations(A, l - 1):
            yield frozenset(t)

    def _minimise(self):
        while True:
            curr_best, l = self.curr_best
            print("Current best: ", l)
            level = l - 1
            if level != self.l:
                self.rel_lattice = self.generate_rel_lattice(curr_best, l)
                self.l = level

            next_can = None
            for r in self.rel_lattice:
                if r not in self.tried:
                    next_can = r
                    break
            if next_can is None:
                return

            next_can_ass_idx = next_can                    # frozenset indices
            rst_idx = self._base - next_can                # indices of the rest

            if self.test_can_refs(next_can_ass_idx, rst_idx):
                self.curr_best = (next_can, level)
            else:
                self.mark_children(next_can, level - 1)

            self.tried.add(next_can)

    def ensure_equal(self):
        best_idx = self.curr_best[0]
        best_refs = [self.base_refs[i] for i in best_idx]
        self.s.push()
        self.s.add(z3.And(self.base_refs) == z3.And(best_refs))
        assert self.s.check() == z3.sat
        self.s.pop()

    def minimise(self):
        self._minimise()
        self.ensure_equal()
        return [self.base[i] for i in self.curr_best[0]]

    def mark_children(self, can, l):
        if l < 1:
            return
        for t in combinations(can, l):
            self.tried.add(frozenset(t))

    def test_can_refs(self, A_idx, B_idx):
        # A_idx, B_idx are iterables of indices (e.g., frozenset[int])
        A_list   = [self.base_refs[i] for i in A_idx]
        notBlist = [self.neg_refs[i]  for i in B_idx]

        self.s.push()
        if A_list:
            self.s.add(z3.And(A_list))           # And(A)
        if notBlist:
            self.s.add(z3.Or(notBlist))          # ¬And(B) == Or(¬b_i for i in B)
        else:
            # B empty ⇒ implication holds
            self.s.pop()
            return True

        r = self.s.check()
        self.s.pop()
        return r == z3.unsat   # UNSAT ⇒ And(A) ∧ ¬And(B) is impossible ⇒ A ⇒ B


def get_defined_funs(file):
    with open(file, 'r') as f:
        content = f.read()
        matches = def_pat.findall(content)
    return set(matches)

def get_unique_funs(defined_funs):
    pair = ([], [])

    for df in defined_funs:
        func = func_pat.search(df).group(1)
        if func not in set(pair[1]):
            pair[0].append(df)
            pair[1].append(func)
    return pair

def minimise(defined_funs, partition_size):
    from more_itertools import chunked

    partition_size = partition_size or len(defined_funs[0])

    min_core = []
    for p in chunked(zip(*defined_funs), partition_size):
        pl = PowerLattice(zip(*p))
        sub_min_core = pl.minimise()
        print(f"sub before: {partition_size}, after: {len(sub_min_core)}")
        min_core.extend(sub_min_core)
        del pl
    return min_core

def run_minimisation(in_file, out_file, partition_size=None):
    defined_funs = get_defined_funs(in_file)
    unique_funs = get_unique_funs(defined_funs)

    print('start size: ', len(unique_funs[0]))
    min_core = minimise(unique_funs, partition_size)
    print('final size: ', len(min_core))

    with open(out_file, 'w') as f:
        f.write("\n".join(min_core))


if __name__ == '__main__':
    import sys
    file = sys.argv[1]
    out_file = sys.argv[2] or 'tmp'
    partition_size = None
    if len(sys.argv) == 4:
        partition_size = int(sys.argv[3]) or None
    run_minimisation(file, out_file, partition_size)

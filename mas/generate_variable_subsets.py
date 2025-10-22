import random

from minimal_satisfiable_assignment import run_get_mas


def generate_variable_subsets(n, k):
    underspecified = sorted(run_get_mas())

    for i in range(n):
        variable_set = random.sample(underspecified, k)
        with open(f"variable_set_{i}", 'w') as f:
           f.write('\n'.join(variable_set))

generate_variable_subsets(5, 4)

import random

from maximal_universal_subset import run_get_mus


# bench is a str representing the benchmark name (without text extention)
def generate_variable_subsets(bench, n, k):
   underspecified = sorted(run_get_mus(bench))

   for i in range(n):
       variable_set = random.sample(underspecified, k)
       with open(f"variable_set_{i}", 'w') as f:
           f.write('\n'.join(variable_set))


generate_variable_subsets('c17', 2, 2)
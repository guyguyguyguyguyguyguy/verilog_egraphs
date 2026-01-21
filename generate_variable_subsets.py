import random
import json

from minimal_satisfiable_assignment import get_mus


def generate_variable_subsets(n, k, timeout, jobs=1):
    underspecified, model = get_mus("variables.txt", "SygusResult.sl", timeout)

    for i in range(n):
        variable_set = random.sample(sorted(underspecified), k)
        with open(f"variable_set_{i}", 'w') as f:
           f.write('\n'.join(variable_set))
    with open('model.json', 'w') as f:
        json.dump(model, f)


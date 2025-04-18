with open('bv_and.out', 'r') as f:
    lines = f.readlines()

f_lines = [f"(\n{x.strip()}\n)" for x in lines]

with open('bv_and_2.out', 'w') as f:
    f.write('\n'.join(f_lines))

def run(out_file):
    with open('tmp.out', 'r') as f:
        lines = f.readlines()

    f_lines = [f"(\n{line.strip()}\n)" for line in lines if line.strip()]

    with open(out_file, 'w') as f:
        f.write('\n'.join(f_lines))

import os
import sys

print("============= TEMA LFA =============")
inputs = []
refs = []

os.chdir("inputs")
input_files = os.listdir()
input_files = list(filter(lambda s: "intrare-" in s, input_files))
input_files.sort()
for input_file in input_files:
    f = open(input_file, 'r')
    inputs.append(f.read())

os.chdir("../refs")
ref_files = os.listdir()
ref_files.sort()
for ref_file in ref_files:
    f = open(ref_file)
    refs.append(f.read())

os.chdir("..")
tests = len(inputs)
if 'Makefile' not in os.listdir():
   print('ERROR: Makefile not found')
   print(f'Final score: 0/{tests}')
   sys.exit()
build_status = os.WEXITSTATUS(os.system("make"))
if build_status != 0:
    print('ERROR: Build failed, compilation errors found')
    print(f'Final score: 0/{tests}')
    sys.exit()
score = 0
test = 1
for i in range(tests):
    current_input = inputs[i]
    f = open('in.txt', 'w')
    f.write(current_input)
    f.close()
    os.system('./tema in.txt > out.txt')
    f = open('out.txt', 'r')
    current_output = f.read()
    f.close()
    result = 'FAIL'
    if current_output == refs[i]:
        result = 'OK'
        score += 1
    print(f"Test {test}: {result}")
    test += 1
print(f"Final Score: {score}/{tests}")
os.remove('in.txt')
os.remove('out.txt')
os.system('make clean')
from __future__ import print_function

import os
import re
import sys

def find_results(code_output):
	array = []

	with open(code_output, 'r') as cout :
		content = cout.readlines()
		count_index = 0
		#print(len(content))
		temp = re.split(r'[, |: |\*|\n]+', content[len(content)/2].rstrip())
		for idx, token in enumerate(temp):
			if token.isdigit():
				count_index= -1 if (idx != 0 ) else 0

		for ent in content :
			array.append(int(re.split(r'[, |: |\*|\n]+', ent.rstrip())[count_index]))

	return sorted(array, reverse=True)


if __name__ == "__main__":

	if len(sys.argv) < 6 :
		sys.exit('Usage: ...')
	else:
		input_file  = sys.argv[1]
		code_output = sys.argv[2]
		bash_output = sys.argv[3]
		max_idx = int(sys.argv[4])
		thresh = int(sys.argv[5])

	score = '0'

	if not os.path.isfile(code_output) and not os.path.isfile(bash_output) :
		print(score)	
		sys.exit(1) 
	
	if os.stat(code_output).st_size == 0 and os.stat(bash_output).st_size == 0 :
		print(score)	
		sys.exit(1)
	
	code_array = []
	bash_array = []
	
	code_array = find_results(code_output)[:max_idx]
	bash_array = find_results(bash_output)[:max_idx]
	sol_array = []
	
	temp_score = 0
	for x in range(0,max_idx):
		if abs(code_array[x] - bash_array[x]) <= (thresh*max(code_array[x], bash_array[x]/100)) :
			print (code_array[x], bash_array[x])
			temp_score = temp_score + 100/max_idx

	score = temp_score

	print(score)

from __future__ import print_function

import os
import sys

if __name__ == "__main__":

	if len(sys.argv) < 4 :
		sys.exit('Usage: ...')
	else:
		input_file  = sys.argv[1]
		code_output = sys.argv[2]
		bash_output = sys.argv[3]

	score = 0

	if not os.path.isfile(code_output) and not os.path.isfile(bash_output) :
		print(score)	
		sys.exit(1) 
	
	if os.stat(code_output).st_size==0 and os.stat(bash_output).st_size==0 :
		print(score)	
		sys.exit(1)
	
	with 

	score=10
	print(score)

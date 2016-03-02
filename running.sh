#!/bin/bash

CODES_FOLDER=$1
INPUT_NAME=$(basename $2)
INPUT_PATH=$(readlink -e $2)

OUTPUT_NAME="output"
TIMEF_NAME="time"

PYTHON=python-2.7.10
GRADER=$(pwd)"/grader.py"


BASH_OUT=$INPUT_NAME"_bash.out"
BASH_TIME=$INPUT_NAME"_bash.time"
BASH_ERR=$INPUT_NAME"_bash.err"
CODE_OUT=$INPUT_NAME"_code.out"
CODE_TIME=$INPUT_NAME"_code.time"
CODE_ERR=$INPUT_NAME"_code.err"


for std_path in ${CODES_FOLDER}/*/
do
  std_has_make=false                                                                                                  
	std_has_bash=false
	std_has_readme=false
	std_bash_status=0
	std_code_status=0
	std_score=0

	std_temp=$(basename "$std_path")
  std_name=$(echo $std_temp | tr "()" "\n" | sed -n 2p)
  
	echo $std_name >&2
  #echo $std_path
 
	cd "$std_path"
  
	if [ -f "wordc.sh" ]; then
		std_has_bash=true
		chmod +x wordc.sh
		./wordc.sh $INPUT_PATH $BASH_OUT $BASH_TIME > $BASH_ERR 2>&1
		ret_val=$?
		if [ $ret_val != 0 ]; then
			std_bash_status=-1
		fi
	fi

	make > /dev/null 2>&1
  ret_val=$?
  if [ $ret_val != 0 ]; then
    std_code_status=-1
  else
    ./wordc $INPUT_PATH $CODE_OUT $CODE_TIME > $CODE_ERR 2>&1
		if [ $ret_val != 0 ]; then
			std_code_status=-1
		fi
  fi

	#if [ $std_bash_status = 0 ] && [ $std_code_status = 0 ]; then

	#std_score=$($PYTHON $GRADER $INPUT_PATH $CODE_OUT $BASH_OUT)
	std_score=0

  echo $std_name, $std_has_bash, $std_score
	cd ..

done

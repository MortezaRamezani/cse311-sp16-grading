#!/bin/bash

CODE_PATH=$1
INPUT_FILE1="../../scripts/input1"
OUTPUT_NAME="output.txt"
TIMEF_NAME="time.txt"

for std_path in ${CODE_PATH}/*/
do
  std_temp=$(basename "$std_path")
  std_name=$(echo $std_temp | tr "()" "\n" | sed -n 2p)
  echo $std_name >&2
  #echo $std_path
  cd "$std_path"
  make > /dev/null 2>&1
  ret_val=$?
  if [ $ret_val != 0 ]; then
    echo "ERROR"
  else
    echo "OK"
    ./wordc $INPUT_FILE1 $OUTPUT_NAME $TIMEF_NAME
    ./wordc.sh $INPUT_FILE1 $OUTPUT_NAME_SH $TIMEF_NAME_SH
    python $GRADER
    head -n 5 $OUTPUT_NAME
    cat $TIMEF_NAME
  fi
  echo '----------------------------------------'
  cd ..
done

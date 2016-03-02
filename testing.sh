#!/bin/bash

CODE_PATH=$1
OUTPUT_CSV="status.csv"

echo "stdid, makefile, bashscript, readme" > $OUTPUT_CSV

for std_path in ${CODE_PATH}/*/
do
  std_has_make=false
  std_has_bash=false
  std_has_readme=false

  std_temp=$(basename "$std_path")
  std_name=$(echo $std_temp | tr "()" "\n" | sed -n 2p)

  echo $std_name
  echo -n $std_name", " >> $OUTPUT_CSV

  cd "$std_path"

  make > /dev/null 2>&1
  ret_val=$?

  if [ $ret_val != 0 ]; then
    echo "ERROR"
    echo -e 0", " >> $OUTPUT_CSV
  else
    echo "OK"
    echo -e 1", " >> $OUTPUT_CSV
  fi

  echo '----------------------------------------'
  cd ..
done

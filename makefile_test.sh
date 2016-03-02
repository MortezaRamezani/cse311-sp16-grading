#!/bin/bash

CODE_PATH=$1
OUTPUT_CSV=$(pwd)"/status.csv"

echo "stdid, makefile, bashscript, readme" > $OUTPUT_CSV

for std_path in ${CODE_PATH}/*/
do
  std_has_make=false
  std_has_bash=false
  std_has_readme=false

  std_temp=$(basename "$std_path")
  std_name=$(echo $std_temp | tr "()" "\n" | sed -n 2p)

	#cd "$CODE_PATH"
	#mv "$std_temp" "$std_name"
	#cd "$std_name"
	cd "$std_path"
  
	#echo -n $std_name", "
	
	if [ -f "makefile" ] || [ -f "Makefile" ] || [ -f "MAKEFILE" ]; then
		#echo "yes"
		std_has_make=true
	else
		echo $std_name", no"
	fi

  cd ..

done

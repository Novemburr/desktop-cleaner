#!/bin/bash

if [ -f $FILE ];
then
	source ./config.sh;
else
	echo "Configuration file not found.";
	echo "Would you like to create one? (y/n)";
	read response;
	if [ $response == "y" ];
	then
		#do stuff;
		touch ./config.sh;
		chmod 755 ./config.sh;
		cat <<EOT >> ./config.sh;
		#Directory to Clean:
		Dir2Cln="~/Desktop/";
		#Directory for storing zipped files:
		Dir2Str="~/Desktop_cleanings";
		#Age of files to zip in days:
		FileAge="5";
		#ignore list file
		skip_files="./skip_files.txt";


		#likely not going to use this
		#File types to ignore(comma delimited):
		#ignoreFiles=".exe, .app, .sh";
		#Folders to ignore(comma delimited):
		#ignoreFolders="~/Desktop/music/";
			
		EOT
	elif [ $response == "n" ];
		#probably error;
	else
		#probably error;
	fi
	
fi

#begin cleaning
FileDate=`date +'%m/%d/%Y'`;
#ignoreList=`ignoreListParse()`;
find $Dir2Cln $(printf "! -name %s " $(cat skip_files)) -mtime +$FileAge -exec tar -czvf $Dir2Str/$FileDate.tar.gz \;




function ignoreListParser() {

	#ignore files
	while IFS=',' read -ra ADDR; do
		for i in "${ADDR[@]}"; do
			# process "$i"
			listIgnoreFiles+=" ! -name '$i'";
		done
	done <<< "$ignoreFiles"
	#ignore dirs
	while IFS=',' read -ra ADDR; do
		for i in "${ADDR[@]}"; do
			# process "$i"
			listIgnoreFolders+=" ! -name '$i'";
		done
	done <<< "$ignoreFolders"
	echo $ignoreFiles $ignoreFolders;

}

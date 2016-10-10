#!/bin/bash

#hopefully the only thing you might ever need to change in this file:
config_file="./.desktop-cleaner/config.sh";

if [ -f $config_file ];
then
	source ~/.desktop-cleaner/config.sh;
else
	echo "Configuration file not found.";
	echo "Would you like to create one? (y/n)";
	read response;
	if [ $response == "y" ];
	then
		#do stuff;
		if [ -d ~/.desktop-cleaner ]; then
			echo 'directory already exists, either there is an existing setup or an unfortunate naming coincidence';
			echo 'this will need to be corrected before continuing';
			exit 1;
		else
			mkdir ~/.desktop-cleaner;
		fi
		touch ~/.desktop-cleaner/config.sh;
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

			
		EOT
		
	elif [ $response == "n" ];
		#probably error;
	else
		#probably error;
	fi
	
fi

#begin cleaning
FileDate=`date +'%m/%d/%Y'`;
if [ -d "$Dir2Cln" ]; then
	find $Dir2Cln $(printf "! -name %s " $(cat skip_files)) -mtime +$FileAge -exec tar -czvf $Dir2Str/$FileDate.tar.gz \;
else
	echo "The directory to clean($Dir2Cln) does not seem to be present";
fi

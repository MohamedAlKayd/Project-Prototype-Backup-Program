#!/bin/bash

# Mohamed Yasser Anwar Mahmoud AlKayd
# Project Prototype & Backup Program

# - Start of the Program -

# - Make the Prototype for the Project -

function makeproject
{
	if [[ -d $1 ]]; then
		echo "Directory name already exists"
		exit 1
	else
		mkdir $1
		mkdir $1/assets
		mkdir $1/archive
		mkdir $1/backups
		mkdir $1/docs
		mkdir $1/docs/html
		mkdir $1/docs/txt
		mkdir $1/database
		mkdir $1/src
		mkdir $1/src/sh
		mkdir $1/src/c
	fi
}

# - Make the backup for the Project -

function makebackup
{
	cd $1/backups

	echo "#!/bin/bash" > mkbackup.sh
	echo "# Case 1: simple arguments" >> mkbackup.sh
	echo "if [[ \$# -eq 0 ]]; then cd ../src; cp *.* ../backups; cd ../backups; fi" >> mkbackup.sh
	echo "if [[ \$# -eq 1 ]]; then cd ../src; cp *.\$1 ../backups; cd ../backups; fi" >> mkbackup.sh
	echo "# Case 2: simple switches" >> mkbackup.sh
	echo "if [[ \$# -eq 2 ]]; then" >> mkbackup.sh
	echo "   if [[ \$1 = \"-x\" ]]; then cd ../src; tar -cvf ../backups/\$2 *.*; cd ../backups; fi" >> mkbackup.sh
	echo "   if [[ \$1 = \"-z\" ]]; then cd ../src; tar -zcvf ../backups/\$2 *.*; cd ../backups; fi" >> mkbackup.sh
	echo "fi" >> mkbackup.sh
	echo "# case 3: switches with selected files" >> mkbackup.sh
	echo "if [[ \$# -gt 2 ]]; then" >> mkbackup.sh
	echo "   cd ../src; tar -zcvf ../backups/\$2 *.\$3; cd ../backups" >> mkbackup.sh
	echo "fi" >> mkbackup.sh

	chmod +x mkbackup.sh
	cd ../..
}

# - Main -

if [[ $# -eq 0 ]]; then
	makeproject myproject
	makebackup myproject
	exit 0
fi

if [[ $# -eq 1 ]]; then
	makeproject $1
	makebackup $1
	exit 0
fi

if [[ $# -gt 2 ]]; then
	destination=$1
	makeproject $destination
	shift
	cp $* $destination/src
	makebackup $destination
	exit 0
fi

# - End of the Program -


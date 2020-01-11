#!/bin/bash

# gat script dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

DIR="$DIR/.."

echo $DIR

if [[ "$1" == "SLURM" || "$1" == "slurm" ]]; then
	submissionScriptName="sub-all-SLURM.sh"
fi

if [[ "$1" == "PBS" || "$1" == "pbd"  || "$1" == "qsub" ]]; then
    submissionScriptName="sub-all-PBS.sh"
fi

if [ -n "$submissionScriptName" ]; then
	if [ -f $DIR/algosName.config.bk ]; then
		cp $DIR/algosName.config.bk $DIR/algosName.config
	fi
	mv $DIR/algosName.config $DIR/algosName.config.bk
	cat $DIR/algosName.config.bk | sed 's/.\//.\/sub-/g' | sed 's/	/.sh	/2' >> $DIR/algosName.config
fi


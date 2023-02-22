#!/bin/bash
# Author: Michael Pedrotti
# Summary: Compares each file from two directories from same project in diferent branches
# Requires: bash-5.1.16(1)-release
# Usage: ./compare.sh '/projects/myapp/1.0' '/projects/myapp/2.x'

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

if [ $# -eq 0 ] ; then
     echo "No arguments supplied"
else

    pathsrc=$1; 
    pathdst=$2;

    #filepaths=$(find ${pathsrc} -type f -name "*.py");
    filepaths=$(find ${pathsrc} -type f);

    for filepathsrc in $filepaths; do

        filepathdst=$(echo $filepathsrc | sed "s|$pathsrc|$pathdst|g")
        
        if [ -f $filepathdst ]; then

            hashsrc=$(md5sum $filepathsrc  | awk '{ print $1 }');
            hashdst=$(md5sum $filepathdst  | awk '{ print $1 }');
            
            if [ "${hashsrc}" ==  "${hashdst}" ]; then

                printf "${GREEN}${filepathsrc} is same${NC}\n"

            else
                echo ${hashsrc} ${hashdst}
                printf "${RED}meld ${filepathsrc} ${filepathdst}${NC}\n"
             fi

        else
            printf "${YELLOW}${filepathsrc} are the only one${NC}\n"
        fi

    done
fi



#!/bin/bash

# Folder with tests and reference civic files
testDir='.'

# Folder with students civic files.
srcDir='..'

srcFiles="${srcDir}/core.cvc ${srcDir}/coreio.cvc ${srcDir}/array.cvc"
checkFiles="${testDir}/core.cvc ${testDir}/coreio.cvc ${testDir}/array.cvc"

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"

check_dir(){

    if [ ! -d "$1" ]; then
        printf "$1 no such directory\n"
        return
    fi

    printf "Testing $1\n"
    for test in "$testDir"/${1}/test_*; do

        if [ "${test##*.}" != "cvc" ]; then
            continue
        fi

        printf "Test file: ${test##*/}   \t\t"

        inFile="${test%.*}.in"
        if [ ! -f $inFile ]; then
            ref=$(./runCivic.sh ${test} ${checkFiles})
            out=$(./runCivic.sh ${test} ${srcFiles})
        else
            ref=$(./runCivic.sh ${test} ${checkFiles} < $inFile 2>&1)
            out=$(./runCivic.sh ${test} ${srcFiles}   < $inFile 2>&1)
        fi

        DIFF=$(diff -y -w -B --width=70 <(printf "$out" | tr -d ' \n') <(printf "$ref" | tr -d ' \n'))

        if [ $? -ne 0 ]; then
            printf "\e[31m FAIL \e[0m\n"
            printf "Diff result:\nStudent output \t\t\t  | Expected output\n"
            diff -y -w -B --width=70 <(printf "$out") <(printf "$ref")
            printf "\n"
        else
            printf "\e[32m OK \e[0m\n"
        fi

    done

    printf "\n"
}

for file in ${srcFiles} ${checkFiles}; do
    if [ ! -f "$file" ]; then
        printf "file: ${file} not found\n"
        exit 1
    fi
done

check_dir "${testDir}/checks_1_1"
check_dir "${testDir}/checks_1_2"
check_dir "${testDir}/checks_1_3"

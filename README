Compiler Construction 2019
Jelle van Dijk

### runCivic.sh
usage: runCivic.sh [civic_files]*

runCivic.sh runs all provided files through the civic toolchain.

All assembly and output files are generated using ${bin}civcc and ${bin}civas.

Out files are given to ${bin}civvm. Results are printed to stdout.

bin variable can be set in script.


### checkCivic.sh
CheckCivic will run all tests in ${srcDir}/checks.

Each test is compared to the functions in ${testDir}.

If there is a diff between the two versions it is shown in the output.

${srcDir} and ${testDir} values can be set in script.

Tests in other folders can be checked by calling "check_dir path/to/tests" in the script.


### Tests
Test must be named "test_[name of test].cvc".

Input files to test can be provided by being placed in the same folder.
Input files must be named test_[name of test].in.


### Cvc files.
The cvc files in the root folder are the reference implementation.

They are not provided in the public version, for plagiarism reasons.

Functions provided in these files are compared to the student submitted files.

#! /usr/bin/env bash
# 
# Author: Austin Glaser <austin.glaser@colorado.edu>
# 
# This is almost certainly not the most efficient way to do this; however, my
# goals were generality and readability

# Write to stderr
# Adapted from http://stackoverflow.com/a/23550347/4138486
errcho() {
    >&2 echo $1
}

# Usage info
usage() {
    errcho ""
    errcho "Usage: $0 <data_file>"
    errcho "Data file should be composed only of lines of the form:"
    errcho ""
    errcho "<student number> <first name> <last name> <test_score>[ <test_score>]*"
    errcho ""
    errcho "that is; an integer, two strings, and at least one following integer"
    errcho ""
}

# quicksorts positional arguments
# return is in array qsort_ret
# Note: iterative, NOT recursive! :)
# First argument is a function name that takes two arguments and compares them
qsort() {
   (($#<=1)) && return 0
   local compare_fun=$1
   shift
   local stack=( 0 $(($#-1)) ) beg end i pivot smaller larger
   qsort_ret=("$@")
   while ((${#stack[@]})); do
      beg=${stack[0]}
      end=${stack[1]}
      stack=( "${stack[@]:2}" )
      smaller=() larger=()
      pivot=${qsort_ret[beg]}
      for ((i=beg+1;i<=end;++i)); do
         if "$compare_fun" "${qsort_ret[i]}" "$pivot"; then
            smaller+=( "${qsort_ret[i]}" )
         else
            larger+=( "${qsort_ret[i]}" )
         fi
      done
      qsort_ret=( "${qsort_ret[@]:0:beg}" "${smaller[@]}" "$pivot" "${larger[@]}" "${qsort_ret[@]:end+1}" )
      if ((${#smaller[@]}>=2)); then stack+=( "$beg" "$((beg+${#smaller[@]}-1))" ); fi
      if ((${#larger[@]}>=2)); then stack+=( "$((end-${#larger[@]}+1))" "$end" ); fi
   done
}

# Compares two students, and sorts based on their last name (sorts based on
# first name if last is the same)
student_compare_lname() {
    if [ ${1[lname]} != ${2[lname]} ]; then
        [[ ${1[lname]} -nt ${2[lname]} ]]
    else
        [[ ${1[fname]} -nt ${2[fname]} ]]
    fi
}

# Check command-line arguments
if [ $# -ne 1 ]; then
    usage
    exit -1
fi

# Filename in first command line argument
filename=$1
if [ ! -f $filename ]; then
    errcho ""
    errcho "$filename: no such file"
    usage
    exit -1
fi

# String index of various fields
snumber_location=0
sfname_location=1
slname_location=2
stests_start=3

# Read into data structure
students=()
n=$(expr 0)
while read l; do
    # Convert to an array
    larr=($l)

    # Extract student number and name info
    student_name=student_$n
    declare -A ${student_name}
    ${student_name}[fname]=${larr[$sfname_location]}
    ${student_name}[lname]=${larr[$slname_location]}
    ${student_name}[number]=${larr[$snumber_location]}

    # Calculate average test score
    larr_len=${#larr[@]}
    stests_n=$(expr $larr_len - $stests_start)
    if [ $stests_n -eq 0 ]; then
        errcho ""
        errcho "invalid input format"
        usage
        exit 1
    fi
    stest_sum=$(expr 0)
    for (( i=$stests_start; i<$larr_len; i++ )); do
        stest_sum=$(expr $stest_sum + ${larr[$i]})
    done
    student[test_avg]=$(expr $stest_sum / $stests_n)

    # Put in student array
    students[$n]=$student_name
    n=$(expr $n + 1)

done <$filename

for (( i=0; i<${#students[@]}; i++ )); do
    test=${students[$i]}
    echo ${students[$i]}
done

qsort student_compare_lname 


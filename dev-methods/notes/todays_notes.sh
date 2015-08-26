#! /bin/sh

date_str="$(date +%Y-%m-%d)"
filename="md/$date_str.md"
header="$date_str - TOPIC"
header_len=${#header}

if [ ! -f $filename ] ; then
    echo $header > $filename
    for i in $(seq 1 $header_len) ; do
        echo -n "=" >> $filename
    done
    echo "" >> $filename
    echo "" >> $filename
    echo "# Assignments" >> $filename
fi

vim $filename

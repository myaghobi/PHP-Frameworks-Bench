#!/bin/sh

if [ ! `which composer` ]; then
    echo "composer not found."
    exit 1;
fi

if [ ! `which wrk` ]; then
    echo "wrk not found."
    exit 1;
fi

if [ ! `which curl` ]; then
    echo "curl not found."
    exit 1;
fi

if [ $# -eq 0 ]; then
    # include frameworks list
    . ./list.sh
    targets="$list"
else
    targets="${@%/}"
fi

for fw in $targets
do
    if [ -d "$fw" ]; then
        echo "/------- $fw: setting up -------/"
        cd "$fw"
        . "_benchmark/setup.sh"
        cd ..
    fi
done

find . -name ".htaccess" -exec rm -rf {} \;

#!/usr/bin/env bash

function solc-err-only {
    solc "$@" 2>&1 | grep -A 2 -i "Error"
}

solc-err-only --overwrite --optimize --bin --abi ./contracts/MapMess.sol -o ./build/
cd ./build
wc -c MapMess.bin | awk '{print "MapMess: " $1}'

#!/usr/bin/env bash

function solc-err-only {
    solc "$@" 2>&1 | grep -A 2 -i "Error"
}

solc-err-only --overwrite --optimize --bin --abi ./contracts/MapMess.sol -o ./build/

#local 0x1c0616e7b6d742add1cd3063ece0996edad3f32a
#solc --link --libraries ./contracts/MapMess.sol:SafeMath:0x1c0616e7b6d742add1cd3063ece0996edad3f32a ./build/MapMess.bin

#Rinkeby 0x296585e8f9f1b15916ee16a25b9931b9132049d5
solc --link --libraries ./contracts/MapMess.sol:SafeMath:0x296585e8f9f1b15916ee16a25b9931b9132049d5 ./build/MapMess.bin

#Mainnet
#solc --link --libraries ./contracts/MapMess.sol:SafeMath:0x1c0616e7b6d742add1cd3063ece0996edad3f32a ./build/MapMess.bin

cd ./build
wc -c MapMess.bin | awk '{print "MapMess: " $1}'

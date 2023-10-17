#!/bin/bash

name=${1%.*c} # detatch .c from c file name
clang-10 -O2 -Xclang -emit-llvm -c $name.c # convert source code(.c) to bit code(.bc)
llvm-dis-10 $name.bc -o $name.ll # generate llvm ir(.ll) from bit code(.bc) obtained above without any optimization
#!/bin/bash

name=${1%.*c} # detatch .c from c file name
clang-10 -O2 -Xclang -emit-llvm -c $name.c # convert source code(.c) to bit code(.bc)
llvm-dis-10 $name.bc -o $name.ll # generate llvm ir(.ll) from bit code(.bc) obtained above without any optimization

opt-10 -mem2reg $name.bc -o $name.mem2reg.bc # optimize bit code using `mem2reg` optimization pass before generating llvm ir
llvm-dis-10 $name.mem2reg.bc -o $name.mem2reg.ll # generate llvm ir(.ll) from optimized bit code(.bc)
#!/usr/bin/env bash

# linearscan-1.0.0 requires a bugfix to compile with ghc-8.2.x, due to Coq
# extraction emitting incompatible code

rm -rf linearscan-*
cabal get linearscan
cd linearscan-* && \
   git init && git add . && \
   for x in $(ls LinearScan/*.hs); do \
     sed -i 's/GHC\.Prim\.Any/GHC\.Base\.Any/' "$x"; \
   done && \
   cd ..

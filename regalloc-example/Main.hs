module Main
  ( main
  ) where

import RegAlloc.IR         ()
import RegAlloc.Impl.LinearScan ()
import RegAlloc.Impl.GraphColor ()

main :: IO ()
main = return ()

module RegAlloc.Types
  ( VarId
  , PhysReg

  , OpKind(..)
  , VarKind(..)
  , VarInfo(..)
  ) where

type VarId = Int
type PhysReg = Int

data OpKind
  = IsNormal
  | IsCall
  | IsBranch

data VarKind
  = Input
  | Output
  | InputOutput
  | Temporary

data VarInfo
  = VarInfo { varId       :: Either PhysReg VarId
            , varKind     :: VarKind
            , regRequired :: Bool
            }

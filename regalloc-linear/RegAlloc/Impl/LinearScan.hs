module RegAlloc.Impl.LinearScan
  ( allocate
  ) where

import qualified RegAlloc.Types    as T
import qualified RegAlloc.IR       as IR

import qualified LinearScan        as LS

--------------------------------------------------------------------------------

allocate
  :: Monad m
  => Int
  -> [IR.Block]
  -> m (String, Either [String] [IR.Block])
allocate numRegs
  = LS.allocate numRegs blockInfo opInfo verify

  where
    verify = LS.VerifyEnabledStrict

    blockInfo = LS.BlockInfo
      { LS.blockId           = IR.ident
      , LS.blockSuccessors   = IR.successors
      , LS.splitCriticalEdge = IR.splitEdge
      , LS.blockOps          = IR.operations
      , LS.setBlockOps       = IR.setOperations
      }

    opInfo = LS.OpInfo
      { LS.opKind            = toOpKind . IR.kind
      , LS.opRefs            = map toVarInfo . IR.refs
      , LS.moveOp            = IR.move
      , LS.saveOp            = IR.save
      , LS.restoreOp         = IR.restore
      , LS.applyAllocs       = \op a -> IR.allocate op (changeAlloc a)
      , LS.showOp1           = IR.show
      }

--------------------------------------------------------------------------------

toOpKind :: T.OpKind -> LS.OpKind
toOpKind T.IsNormal = LS.IsNormal
toOpKind T.IsCall   = LS.IsCall
toOpKind T.IsBranch = LS.IsBranch

toVarInfo :: T.VarInfo -> LS.VarInfo
toVarInfo (T.VarInfo vid vk req)
  = LS.VarInfo vid (toVarKind vk) req

toVarKind :: T.VarKind -> LS.VarKind
toVarKind T.Input       = LS.Input
toVarKind T.InputOutput = LS.InputOutput
toVarKind T.Temporary   = LS.Temp
toVarKind T.Output      = LS.Output

fromVarKind :: LS.VarKind -> T.VarKind
fromVarKind LS.Input       = T.Input
fromVarKind LS.InputOutput = T.InputOutput
fromVarKind LS.Temp        = T.Temporary
fromVarKind LS.Output      = T.Output

changeAlloc
  :: [((LS.VarId, LS.VarKind), LS.PhysReg)]
  -> [((T.VarId,  T.VarKind),  T.PhysReg)]
changeAlloc = map k where
  k ((x, y), z) = ((x, fromVarKind y), z)

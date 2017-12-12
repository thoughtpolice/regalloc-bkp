module IR
  ( Op(..)
  , Block(..)

  , kind, refs, move, save, restore, allocate, show
  , ident, successors, splitEdge, operations, setOperations
  ) where

import           Prelude hiding (Show(..))

import qualified RegAlloc.Types as T

--------------------------------------------------------------------------------

type Arg = Either T.PhysReg T.VarId

-- | The type of an operation -- the entries in some @'Block'@ -- for some given
-- intermediate representation.
data Op
  = Label Int
  | Add
  | Nop
  | Call Int
  | Jump Int

-- | The type of a basic block for some given intermediate representation.
data Block = Block [Op]

--------------------------------------------------------------------------------

kind
  :: Op
  -> T.OpKind
kind = undefined

refs
  :: Op
  -> [T.VarInfo]
refs = undefined

move
  :: Monad m
  => T.PhysReg
  -> T.VarId
  -> T.PhysReg
  -> m [Op]
move = undefined

save
  :: Monad m
  => T.PhysReg
  -> T.VarId
  -> m [Op]
save = undefined

restore
  :: Monad m
  => T.VarId
  -> T.PhysReg
  -> m [Op]
restore = undefined

allocate
  :: Monad m
  => Op
  -> [((T.VarId, T.VarKind), T.PhysReg)]
  -> m [Op]
allocate = undefined

show
  :: Op
  -> String
show = undefined

--------------------------------------------------------------------------------

-- | Return the unique identifier for a given @'Block'@. The semantics are not
-- important, only that this basic block ID is unique among all the input
-- blocks.
ident
  :: Block
  -> Int
ident = undefined

-- | Give a list of immediate successors in the DAG for the input @'Block'@.
successors
  :: Block
  -> [Int]
successors = undefined

splitEdge
  :: Monad m
  => Block
  -> Block
  -> m (Block, Block)
splitEdge = undefined

-- | Split a @'Block'@ into its operations -- the entry point, body, and exit
-- point.
operations
  :: Block
  -> ( [Op]
     , [Op]
     , [Op]
     )
operations (Block (f:ops)) = ( [f], init ops, [last ops] )

-- | Replace a set of operations in a block with a set of allocated operations.
setOperations
  :: Block
  -> [Op]
  -> [Op]
  -> [Op]
  -> Block
setOperations = undefined

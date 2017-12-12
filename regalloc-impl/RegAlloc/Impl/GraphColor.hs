module RegAlloc.Impl.GraphColor
  ( allocate
  ) where

import qualified RegAlloc.Types    as T
import qualified RegAlloc.IR       as IR

--------------------------------------------------------------------------------

allocate
  :: Monad m
  => Int
  -> [IR.Block]
  -> m (String, Either [String] [IR.Block])
allocate
  = undefined

{-# LANGUAGE Rank2Types, TypeOperators, FlexibleInstances, ScopedTypeVariables, GADTs, MultiParamTypeClasses, UndecidableInstances, IncoherentInstances #-}

--------------------------------------------------------------------------------
-- |
-- Module      :  Data.Comp.Multi.HTraversable
-- Copyright   :  (c) 2011 Patrick Bahr
-- License     :  BSD3
-- Maintainer  :  Patrick Bahr <paba@diku.dk>
-- Stability   :  experimental
-- Portability :  non-portable (GHC Extensions)
--
-- This module defines higher-order traversable functors.
--
--------------------------------------------------------------------------------

module Data.Comp.Multi.HTraversable
    (
     HTraversable (..)
    ) where

import Data.Comp.Multi.HFunctor
import Data.Comp.Multi.HFoldable
import Control.Applicative

class HFoldable t => HTraversable t where

    -- | Map each element of a structure to a monadic action, evaluate
    -- these actions from left to right, and collect the results.
    --
    -- Alternative type in terms of natural transformations using
    -- functor composition @:.:@:
    --
    -- @hmapM :: Monad m => (a :-> m :.: b) -> t a :-> m :.: (t b)@
    hmapM :: (Monad m) => NatM m a b -> NatM m (t a) (t b)

    htraverse :: (Applicative f) => NatM f a b -> NatM f (t a) (t b)
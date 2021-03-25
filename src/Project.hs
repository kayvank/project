{-# LANGUAGE GeneralizedNewtypeDeriving #-}
-- implicitly from taraversble {-# LANGUAGE DeriveFunctor #-}
-- implicitly from traversable {-# LANGUAGE DeriveFoldable #-}
{-# LANGUAGE DeriveTraversable #-}
-- |

module Project where
import           Data.Text
import Data.Decimal (Decimal)

newtype Money = Money {
  unMoney :: Decimal
  } deriving (Show, Eq, Num)

newtype ProjectId = ProjectId {
  unProjectId :: Int
  } deriving (Show, Eq, Num)

data Project a =
  Project Text a
  |  ProjectGroup Text [Project a]
  deriving (Show, Eq, Functor, Foldable, Traversable)

data Budget = Budget
  { budgetIncome      :: Money
  , budgetExpenditure :: Money
  } deriving (Show, Eq)

data Transaction =
  Sale Money
  | Purchase Money
  deriving (Show, Eq)

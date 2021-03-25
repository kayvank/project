{-# LANGUAGE OverloadedStrings #-}
-- |

module PrettyPrint where

import qualified Data.Text   as Text
import           Data.Tree
import           Text.Printf
import Data.Decimal (roundTo)

import           Project
import           Reporting

asTree :: (a -> String) -> Project a  -> Tree String
asTree prettyValue project = case project of
 Project  name x ->   Node (printf "%s: %s" name (prettyValue x) ) []
 ProjectGroup name projects     ->
   Node (Text.unpack name) (map (asTree prettyValue) projects)

prettyProject :: (a -> String) -> Project a -> String
prettyProject  prettyValue =  drawTree . asTree prettyValue

prettyReport :: Report -> String
prettyReport  report = printf
  "Budget: %s, Net: %s, difference: %s"
    ( (prettyMoney . budgetProfit) report)
    (prettyMoney ( netProfit report))
    (prettyMoney ( difference report))

prettyMoney :: Money -> String
prettyMoney (Money d) = sign ++ show (roundTo 2 d)
  where
    sign =
      if d > 0 then "+"
      else ""

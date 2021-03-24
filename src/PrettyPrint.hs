{-# LANGUAGE OverloadedStrings #-}
-- |

module PrettyPrint where

import qualified Data.Text   as Text
import           Data.Tree
import           Text.Printf

import           Project
import           Reporting

asTree, asTree' :: Project -> Tree String
asTree' (Project (ProjectId pid) name) =  Node (printf "%s (%d)" name pid) []
asTree' (ProjectGroup name projects) = Node (Text.unpack name) ( map asTree projects )
asTree project = case project of
 Project ( ProjectId pid ) name ->   Node (printf "%s (%d)" name pid) []
 ProjectGroup name projects     ->  Node (Text.unpack name) (asTree <$> projects)

prettyProject :: Project -> String
prettyProject  =  drawTree . asTree

prettyReport :: Report -> String
prettyReport  report = printf
  "budgetProfit: %.2f, netProfit: %.2f, difference: %.2f"
    ( (unMoney . budgetProfit) report)
    (unMoney ( netProfit report))
    (unMoney ( difference report))

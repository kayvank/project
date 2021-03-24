{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# LANGUAGE OverloadedStrings #-}
-- |

module Demo where
import           Project
import           Reporting

someProject :: Project ProjectId
someProject = ProjectGroup "Sweden" [stockholm, gothenburg, malmo]
  where
    stockholm = Project  "Stockholm" 1
    gothenburg = Project  "Gothenburg" 2
    malmo = ProjectGroup "Malmo" [city, limhamn]
    city = Project  "Malmo City" 3
    limhamn = Project  "Limhamn"4

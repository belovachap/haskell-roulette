-- {-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Random where

import Import
import System.Random
import System.Random.Shuffle

getRandomR :: Handler Html
getRandomR = do
    randomGenerator <- newStdGen
    packages <- runDB $ (selectList [] [] :: DB [Entity HaskellPackage])
    let randomPackage = Prelude.head $ shuffle' packages (Prelude.length packages) randomGenerator
    redirect $ PackageR (haskellPackageName $ entityVal randomPackage)

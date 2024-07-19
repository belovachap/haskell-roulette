{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import

getHomeR :: Handler Html
getHomeR = do
    allHaskellPackages <- runDB $ selectList [] [Asc HaskellPackageName]

    defaultLayout $ do
        setTitle "Haskell Roulette"
        $(widgetFile "homepage")

{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Package where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Text.Julius (RawJS (..))

getPackageR :: HaskellPackageId -> Handler Html
getPackageR name = do
    package <- runDB $ get404 name

    defaultLayout $ do
        setTitle "Welcome To Package!"
        $(widgetFile "package")

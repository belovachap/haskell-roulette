{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Package where

import Import
import Text.Blaze.Html (preEscapedToHtml)

getPackageR :: HaskellPackageId -> Handler Html
getPackageR name = do
    package <- runDB $ get404 name

    defaultLayout $ do
        setTitle "Welcome To Package!"
        $(widgetFile "package")

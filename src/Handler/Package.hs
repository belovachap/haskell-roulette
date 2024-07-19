{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Package where

import Import
import Text.Blaze.Html (preEscapedToHtml)

getPackageR :: Text -> Handler Html
getPackageR name = do
    entity <- runDB $ getBy404 (UniqueName name)
    let package = entityVal entity

    defaultLayout $ do
        setTitle (toHtml (haskellPackageName package))
        $(widgetFile "package")

{-# LANGUAGE OverloadedStrings #-}

import CMark (commonmarkToHtml)
import Data.Text (pack)
import Database.SQLite.Simple (NamedParam ((:=)), close, executeNamed, open)
import System.Directory (listDirectory)
import System.FilePath.Posix (takeBaseName, (</>))

main = do
  conn <- open "haskell-roulette.sqlite3"
  markdownFiles <- listDirectory "markdown"
  mapM_
    ( \x -> do
        md <- readFile $ "markdown" </> x
        let html = commonmarkToHtml [] (pack md)
        executeNamed conn "UPDATE haskell_package SET notes = :notes WHERE name = :name" [":notes" := html, ":name" := (takeBaseName x)]
    )
    markdownFiles
  close conn

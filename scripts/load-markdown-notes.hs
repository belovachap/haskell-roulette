{-#  LANGUAGE OverloadedStrings #-}

import System.Directory (listDirectory)
import Database.SQLite.Simple (open, close, executeNamed, NamedParam( (:=) ))
import System.FilePath.Posix (takeBaseName, (</>))
import CMark (commonmarkToHtml)
import Data.Text (pack)

main = do 
    conn <- open "haskell-roulette.sqlite3"
    markdownFiles <- listDirectory "markdown"
    mapM_
        (\x -> do
            md <- readFile $ "markdown" </> x
            let html = commonmarkToHtml [] (pack md)
            executeNamed conn "UPDATE haskell_package SET notes = :notes WHERE name = :name" [":notes" := html, ":name" := (takeBaseName x)]
        )
        markdownFiles
    close conn
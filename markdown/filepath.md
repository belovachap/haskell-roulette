# Overview

> Library for manipulating FilePaths in a cross platform way.

# Installation

`filepath` comes with [Stack](https://www.stackage.org/package/filepath). You can add it to your project's `package.yaml`.

# Snippets

## `(</>)`

For example: `"/directory" </> "file.ext"` -> `"/directory/file.ext`.

## `takeBaseName`

For example: `takeBaseName "/directory/file.ext"` -> `file`. Here it's used in a script to extract the base name of a markdown file and use it to update a corresponding database record:

```
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
```

## `takeFileName`

For example: `takeFileName "/directory/file.ext"` -> `file.ext`. Here it's used in a function to copy a random sampling of files from one directory to another:

```
module Lib
    ( copyRandomFiles
    ) where

import System.Directory
import System.Directory.Extra
import System.FilePath
import System.Random
import System.Random.Shuffle

copyRandomFiles :: Int -> FilePath -> FilePath -> IO ()
copyRandomFiles numFiles source destination = do randomGenerator <- getStdGen
                                                 sourceFiles <- listFilesRecursive source
                                                 let copyFiles = take numFiles $ shuffle' sourceFiles (length sourceFiles) randomGenerator
                                                 mapM_ (\file -> copyFile file (destination ++ (takeFileName file) )) copyFiles
```

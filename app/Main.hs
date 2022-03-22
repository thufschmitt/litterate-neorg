{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Data.Text (Text)
import Effect.Logging (Logging, stdErrorLogging, logError)
import Neorg.Document
import Neorg.Document.Tag (TagHandler, handleTag, handleSomeTag)
import Optics.Core ((^.))
import System.Environment (getArgs)
import qualified Cleff
import qualified Data.Text
import qualified Data.Text.IO
import qualified Neorg.Parser.Main as NeorgParser
import qualified Type.Set

type Convert = Cleff.Eff '[Logging, Cleff.IOE]

type CodeTags = Type.Set.FromList '["code"]

main :: IO ()
main = Cleff.runIOE . stdErrorLogging $ do
  args <- Cleff.liftIO getArgs
  languageName <- case args of
    [l] -> pure (Data.Text.pack l)
    _ -> Cleff.liftIO $ fail "Supply one language name as argument" 
  content <- Cleff.liftIO Data.Text.IO.getContents
  parsedDocument <- NeorgParser.parse "stdin" content
  case parsedDocument of
    Left err -> logError err
    Right (doc :: Document CodeTags) ->
      Cleff.liftIO $ Data.Text.IO.putStrLn (collectCodeTags languageName doc)

collectCodeTags :: Text -> Document CodeTags -> Text
collectCodeTags tagName doc =
  let blocks = doc ^. documentBlocks in
  Data.Text.intercalate "\n" $ concatMap
    (\block -> case block of
      PureBlock (Tag t) -> handleSomeTag (handleCodeTag tagName) t
      _ -> []
    ) blocks

handleCodeTag :: Text -> TagHandler CodeTags [Text]
handleCodeTag tagName =
  handleTag @"code" $ \language text -> if language /= Just tagName then [] else [text]

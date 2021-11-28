{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module Main where
import Web.Scotty

import Data.Monoid (mconcat)
import Control.Monad (join)
import Control.Monad.IO.Class
import System.Environment (lookupEnv)
import Data.Maybe (fromMaybe)
import Text.Read (readMaybe)
import Application.Api.FindBookAction (findBook)
import Database.MongoDB (Action, Document, Document, Value, access,
                         close, connect, delete, exclude, find,
                         host, insertMany, master, project, rest,
                         select, sort, (=:), auth)

main :: IO ()
main = do
  pipe <- connect (host "localhost")
  auth "user" "pass"
  port <- fromMaybe 3000 . join . fmap readMaybe <$> lookupEnv "PORT"
  scotty port $ do
    get "/" $ do
      html "nothing"
    get "/:word" $ do
      beam <- param "word"
      html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
    get "/api/find" (findBook pipe)
  close pipe
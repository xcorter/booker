{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Application.Api.FindBookAction (findBook) where

import Web.Scotty (ActionM, get, html, json, param, rescue, status)
import Network.HTTP.Types (status400)
import qualified Data.Text as T

import Database.MongoDB

-- throw404 :: ActionM ()
-- throw404 msg = do
--   status 404
--   return "Query not found"

findBook :: Pipe -> ActionM ()
findBook pipe = do
  queryName <- param "name" `rescue` (\msg -> do
    return "")
  html $ mconcat ["lol",  queryName]

allBooks :: Action IO [Document]
allBooks = rest =<< find (select [] "books") {sort=[]}
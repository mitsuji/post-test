{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.String (fromString)
import System.Environment (getArgs)
import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.Wai as Wai
import qualified Network.HTTP.Types as H
import Data.ByteString.Lazy.Char8 as LBS


main :: IO ()
main = do
  host:port:_ <- getArgs
  Warp.runSettings (
    Warp.setHost (fromString host) $
    Warp.setPort (read port) $
    Warp.defaultSettings
    ) $ mainApp


mainApp :: Wai.Application
mainApp req respond = do
  body <- Wai.strictRequestBody req
  mapM_ print $ Wai.requestHeaders req
  LBS.putStrLn body
  respond $ Wai.responseLBS H.status200 [] ""


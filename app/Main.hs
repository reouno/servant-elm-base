module Main where

import           Network.Wai.Handler.Warp ( run )

import           App.Server               ( mkApp )

main :: IO ()
main = do
  let port = 8080
  print $ "Listening at " ++ show port ++ "..."
  run port =<< mkApp

module Main where

import           Network.Wai.Handler.Warp ( run )

import           App.Server               ( mkApp )

main :: IO ()
main = run 8080 =<< mkApp

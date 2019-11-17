module Main where

import           Network.Wai.Handler.Warp          ( run )

import           InterfaceAdapter.Presenter.Server ( app )

main :: IO ()
main = run 8080 app

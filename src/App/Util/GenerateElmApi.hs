{-
- ### EXPERIMENTAL ###
- Cannot generate nice codes from datatypes defined with extensible record
-}
{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module App.Util.GenerateElmApi where

import           Servant.Elm                    ( DefineElm(DefineElm)
                                                , Proxy(Proxy)
                                                , defElmImports
                                                , defElmOptions
                                                , generateElmModuleWith
                                                )

import           InterfaceAdapter.Presenter.Api ( Api )

main :: IO ()
main = generateElmModuleWith defElmOptions
                             ["ApricotApi"]
                             defElmImports
                             "elm-dir"
                             []
                             (Proxy :: Proxy Api)

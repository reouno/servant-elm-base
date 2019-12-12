{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeOperators         #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Util.GenerateApiDocs where

import           Data.ByteString.Lazy           ( ByteString )
import           Data.Proxy
import           Data.Text.Lazy                 ( pack )
import           Data.Text.Lazy.Encoding        ( encodeUtf8 )
import           Network.HTTP.Types
import           Network.Wai
import           Servant.API
import           Servant.Docs
import           Servant.Server
import           System.Environment             ( getArgs )
import           Web.FormUrlEncoded             ( FromForm (..), ToForm (..) )

import           App.Server
import           Entity.Entity                  ( Diary (..), User (..), UserId, UserUniqueKey,
                                                  diary1, user1, user1Id )
import           InterfaceAdapter.Presenter.Api ( Api, api )

main :: IO ()
main = do
  args <- getArgs
  let filePath =
        if not (null args)
          then head args
          else "docs/api.md"
  writeFile filePath $ markdown apiDocs

instance ToCapture (Capture "id" Int) where
  toCapture _ =
    DocCapture
      "id" -- name
      "(integer) ID of entity" -- description

instance ToSample User where
  toSamples _ = singleSample user1

instance ToSample UserId where
  toSamples _ = singleSample user1Id

instance ToSample UserUniqueKey where
  toSamples _ = singleSample "neo@matrix.mov"

instance ToSample Diary where
  toSamples _ = singleSample diary1

apiDocs :: API
apiDocs = docs api

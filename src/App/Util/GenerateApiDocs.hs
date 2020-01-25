{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeOperators         #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module App.Util.GenerateApiDocs
  ( generateDocs
  ) where

import           Data.ByteString.Lazy           ( ByteString )
import           Data.Proxy
import           Data.Text.Lazy                 ( pack )
import           Data.Text.Lazy.Encoding        ( encodeUtf8 )
import           Network.HTTP.Types
import           Network.Wai
import           Servant.API                    hiding ( Post )
import           Servant.Docs
import           Servant.Server
import           ServantUtil                    ( EntityRecord (..) )
import           System.Environment             ( getArgs )
import           Web.FormUrlEncoded             ( FromForm (..), ToForm (..) )

import           App.Server
import           App.Util.Seeds                 ( like1, post1, user1 )
import           Entity.Entity                  ( Like (..), LikeId, Post (..), PostId, User (..),
                                                  UserId, UserUniqueKey )
import           InterfaceAdapter.Presenter.Api ( Api, api )

main :: IO ()
main = generateDocs

generateDocs :: IO ()
generateDocs = do
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

instance ToSample (EntityRecord UserId User) where
  toSamples _ = singleSample (EntityRecord user1Id user1)

instance ToSample UserUniqueKey where
  toSamples _ = singleSample "neo@matrix.mov"

instance ToSample Post where
  toSamples _ = singleSample post1

instance ToSample (EntityRecord PostId Post) where
  toSamples _ = singleSample (EntityRecord post1Id post1)

instance ToSample Like where
  toSamples _ = singleSample like1

instance ToSample (EntityRecord LikeId Like) where
  toSamples _ = singleSample (EntityRecord like1Id like1)

apiDocs :: API
apiDocs = docs api

user1Id :: UserId
user1Id = 1

post1Id :: PostId
post1Id = 1

like1Id :: LikeId
like1Id = 1

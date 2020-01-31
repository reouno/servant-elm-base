{-# LANGUAGE DeriveGeneric #-}

module InterfaceAdapter.Presenter.Post.Types where

import           Data.Aeson    ( FromJSON, ToJSON )
import           GHC.Generics  ( Generic )

import           Entity.Entity ( UserId )

data PostWithoutTS =
  PostWithoutTS
    { title         :: String
    , content       :: String
    , imageUrls     :: [String]
    , allowAutoEdit :: Bool
    , userId        :: UserId
    }
  deriving (Eq, Show, Ord, Generic)

instance FromJSON PostWithoutTS

instance ToJSON PostWithoutTS

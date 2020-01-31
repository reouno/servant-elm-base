module InterfaceAdapter.Presenter.Post.Types where

import           Entity.Entity                  ( UserId )

data PostWithoutTS = PostWithoutTS
  { title         :: String
  , content       :: String
  , imageUrls     :: [String]
  , allowAutoEdit :: Bool
  , userId        :: UserId
  }
  deriving (Eq, Show, Ord)



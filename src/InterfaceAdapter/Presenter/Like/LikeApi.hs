{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.Like.LikeApi where

import           Servant

import           Entity.Entity ( Like (..), LikeId, LikeRecord )

type LikeApi
   = Get '[ JSON] [LikeRecord] -- list
      :<|> ReqBody '[ JSON] Like :> PostNoContent '[ JSON] NoContent -- new
      :<|> Capture "id" LikeId :> (Get '[ JSON] (Maybe Like) -- get
                                    :<|> DeleteNoContent '[ JSON] NoContent -- delete
                                   )

userApi :: Proxy LikeApi
userApi = Proxy

{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.Post.PostApi where

import           Servant                               hiding ( Post )
import           ServantUtil                           ( EntityRecord (..) )

import           Entity.Entity                         ( Post (..), PostId )
import           InterfaceAdapter.Presenter.Post.Types ( PostWithoutTS )

-- type PostApi = BaseCrudApi Post PostId
type PostApi
   = Get '[ JSON] [EntityRecord PostId Post] -- list
      :<|> ReqBody '[ JSON] PostWithoutTS :> PostNoContent '[ JSON] NoContent -- new
      :<|> Capture "id" PostId :> (Get '[ JSON] (Maybe Post) -- get
                                    :<|> ReqBody '[ JSON] PostWithoutTS :> Put '[ JSON] NoContent -- update
                                    :<|> DeleteNoContent '[ JSON] NoContent -- delete
                                   )

userApi :: Proxy PostApi
userApi = Proxy

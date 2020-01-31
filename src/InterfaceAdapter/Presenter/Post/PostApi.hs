{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module InterfaceAdapter.Presenter.Post.PostApi where

import           Servant   hiding ( Post )
import           ServantUtil                    ( EntityRecord(..) )

import           Entity.Entity                  ( Post(..)
                                                , PostId
                                                )

-- type PostApi = BaseCrudApi Post PostId
type PostApi = Get '[JSON] [EntityRecord PostId Post]
                   :<|> ReqBody '[JSON] PostWithoutTS :> PostNoContent '[JSON] NoContent
                   :<|> Capture "id" PostId :> (Get '[JSON] (Maybe Post)
                                             :<|> ReqBody '[JSON] PostWithoutTS :> Put '[JSON] NoContent
                                             :<|> DeleteNoContent '[JSON] NoContent)

userApi :: Proxy PostApi
userApi = Proxy

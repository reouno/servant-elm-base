module ApricotApi exposing(..)

import Json.Decode
import Json.Encode exposing (Value)
-- The following module comes from bartavelle/json-helpers
import Json.Helpers exposing (..)
import Dict exposing (Dict)
import Set
import Http
import String
import Url.Builder

maybeBoolToIntStr : Maybe Bool -> String
maybeBoolToIntStr mx =
  case mx of
    Nothing -> ""
    Just True -> "1"
    Just False -> "0"


getUsers : (Result Http.Error  ((List (Int, (:& (': (':> "name" String) (': (':> "email" String) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity)))))  -> msg) -> Cmd msg
getUsers toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "GET"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "users"
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg (Json.Decode.list (jsonDec(Int, (:& (': (':> "name" Text) (': (':> "email" Text) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity)))))
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

postUsers : (:& (': (':> "name" String) (': (':> "email" String) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity)) -> (Result Http.Error  (NoContent)  -> msg) -> Cmd msg
postUsers body toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "POST"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "users"
                    ]
                    params
            , body =
                Http.jsonBody ((jsonEnc:& ((jsonEnc': ((jsonEnc':> (jsonEnc"name") (Json.Encode.string))) ((jsonEnc': ((jsonEnc':> (jsonEnc"email") (Json.Encode.string))) ((jsonEnc': ((jsonEnc':> (jsonEnc"createdAt") (jsonEncNominalDiffTime))) (jsonEnc'[]))))))) ((jsonEncField (jsonEncIdentity)))) body)
            , expect =
                Http.expectJson toMsg jsonDecNoContent
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

getUsersById : Int -> (Result Http.Error  ((Maybe (:& (': (':> "name" String) (': (':> "email" String) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity))))  -> msg) -> Cmd msg
getUsersById capture_id toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "GET"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "users"
                    , capture_id |> String.fromInt
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg (Json.Decode.maybe (jsonDec(:& (': (':> "name" Text) (': (':> "email" Text) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity))))
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

putUsersById : Int -> (:& (': (':> "name" String) (': (':> "email" String) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity)) -> (Result Http.Error  (NoContent)  -> msg) -> Cmd msg
putUsersById capture_id body toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "PUT"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "users"
                    , capture_id |> String.fromInt
                    ]
                    params
            , body =
                Http.jsonBody ((jsonEnc:& ((jsonEnc': ((jsonEnc':> (jsonEnc"name") (Json.Encode.string))) ((jsonEnc': ((jsonEnc':> (jsonEnc"email") (Json.Encode.string))) ((jsonEnc': ((jsonEnc':> (jsonEnc"createdAt") (jsonEncNominalDiffTime))) (jsonEnc'[]))))))) ((jsonEncField (jsonEncIdentity)))) body)
            , expect =
                Http.expectJson toMsg jsonDecNoContent
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

deleteUsersById : Int -> (Result Http.Error  (NoContent)  -> msg) -> Cmd msg
deleteUsersById capture_id toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "DELETE"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "users"
                    , capture_id |> String.fromInt
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg jsonDecNoContent
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

postUsersUser : String -> (Result Http.Error  ((Maybe (Int, (:& (': (':> "name" String) (': (':> "email" String) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity)))))  -> msg) -> Cmd msg
postUsersUser body toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "POST"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "users"
                    , "user"
                    ]
                    params
            , body =
                Http.jsonBody (Json.Encode.string body)
            , expect =
                Http.expectJson toMsg (Json.Decode.maybe (jsonDec(Int, (:& (': (':> "name" Text) (': (':> "email" Text) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity)))))
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

getPosts : (Result Http.Error  ((List (Int, (:& (': (':> "title" String) (': (':> "content" String) (': (':> "imageUrls" (List String)) (': (':> "allowAutoEdit" Bool) (': (':> "createdAt" NominalDiffTime) (': (':> "updatedAt" NominalDiffTime) (': (':> "userId" Int) '[]))))))) (Field Identity)))))  -> msg) -> Cmd msg
getPosts toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "GET"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "posts"
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg (Json.Decode.list (jsonDec(Int, (:& (': (':> "title" Text) (': (':> "content" Text) (': (':> "imageUrls" (List Text)) (': (':> "allowAutoEdit" Bool) (': (':> "createdAt" NominalDiffTime) (': (':> "updatedAt" NominalDiffTime) (': (':> "userId" Int) '[]))))))) (Field Identity)))))
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

postPosts : (:& (': (':> "title" String) (': (':> "content" String) (': (':> "imageUrls" (List String)) (': (':> "allowAutoEdit" Bool) (': (':> "createdAt" NominalDiffTime) (': (':> "updatedAt" NominalDiffTime) (': (':> "userId" Int) '[]))))))) (Field Identity)) -> (Result Http.Error  (NoContent)  -> msg) -> Cmd msg
postPosts body toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "POST"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "posts"
                    ]
                    params
            , body =
                Http.jsonBody ((jsonEnc:& ((jsonEnc': ((jsonEnc':> (jsonEnc"title") (Json.Encode.string))) ((jsonEnc': ((jsonEnc':> (jsonEnc"content") (Json.Encode.string))) ((jsonEnc': ((jsonEnc':> (jsonEnc"imageUrls") ((Json.Encode.list Json.Encode.string)))) ((jsonEnc': ((jsonEnc':> (jsonEnc"allowAutoEdit") (Json.Encode.bool))) ((jsonEnc': ((jsonEnc':> (jsonEnc"createdAt") (jsonEncNominalDiffTime))) ((jsonEnc': ((jsonEnc':> (jsonEnc"updatedAt") (jsonEncNominalDiffTime))) ((jsonEnc': ((jsonEnc':> (jsonEnc"userId") (Json.Encode.int))) (jsonEnc'[]))))))))))))))) ((jsonEncField (jsonEncIdentity)))) body)
            , expect =
                Http.expectJson toMsg jsonDecNoContent
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

getPostsById : Int -> (Result Http.Error  ((Maybe (:& (': (':> "title" String) (': (':> "content" String) (': (':> "imageUrls" (List String)) (': (':> "allowAutoEdit" Bool) (': (':> "createdAt" NominalDiffTime) (': (':> "updatedAt" NominalDiffTime) (': (':> "userId" Int) '[]))))))) (Field Identity))))  -> msg) -> Cmd msg
getPostsById capture_id toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "GET"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "posts"
                    , capture_id |> String.fromInt
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg (Json.Decode.maybe (jsonDec(:& (': (':> "title" Text) (': (':> "content" Text) (': (':> "imageUrls" (List Text)) (': (':> "allowAutoEdit" Bool) (': (':> "createdAt" NominalDiffTime) (': (':> "updatedAt" NominalDiffTime) (': (':> "userId" Int) '[]))))))) (Field Identity))))
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

putPostsById : Int -> (:& (': (':> "title" String) (': (':> "content" String) (': (':> "imageUrls" (List String)) (': (':> "allowAutoEdit" Bool) (': (':> "createdAt" NominalDiffTime) (': (':> "updatedAt" NominalDiffTime) (': (':> "userId" Int) '[]))))))) (Field Identity)) -> (Result Http.Error  (NoContent)  -> msg) -> Cmd msg
putPostsById capture_id body toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "PUT"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "posts"
                    , capture_id |> String.fromInt
                    ]
                    params
            , body =
                Http.jsonBody ((jsonEnc:& ((jsonEnc': ((jsonEnc':> (jsonEnc"title") (Json.Encode.string))) ((jsonEnc': ((jsonEnc':> (jsonEnc"content") (Json.Encode.string))) ((jsonEnc': ((jsonEnc':> (jsonEnc"imageUrls") ((Json.Encode.list Json.Encode.string)))) ((jsonEnc': ((jsonEnc':> (jsonEnc"allowAutoEdit") (Json.Encode.bool))) ((jsonEnc': ((jsonEnc':> (jsonEnc"createdAt") (jsonEncNominalDiffTime))) ((jsonEnc': ((jsonEnc':> (jsonEnc"updatedAt") (jsonEncNominalDiffTime))) ((jsonEnc': ((jsonEnc':> (jsonEnc"userId") (Json.Encode.int))) (jsonEnc'[]))))))))))))))) ((jsonEncField (jsonEncIdentity)))) body)
            , expect =
                Http.expectJson toMsg jsonDecNoContent
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

deletePostsById : Int -> (Result Http.Error  (NoContent)  -> msg) -> Cmd msg
deletePostsById capture_id toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "DELETE"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "posts"
                    , capture_id |> String.fromInt
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg jsonDecNoContent
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

getLikes : (Result Http.Error  ((List (Int, (:& (': (':> "postId" Int) (': (':> "userId" Int) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity)))))  -> msg) -> Cmd msg
getLikes toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "GET"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "likes"
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg (Json.Decode.list (jsonDec(Int, (:& (': (':> "postId" Int) (': (':> "userId" Int) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity)))))
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

postLikes : (:& (': (':> "postId" Int) (': (':> "userId" Int) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity)) -> (Result Http.Error  (NoContent)  -> msg) -> Cmd msg
postLikes body toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "POST"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "likes"
                    ]
                    params
            , body =
                Http.jsonBody ((jsonEnc:& ((jsonEnc': ((jsonEnc':> (jsonEnc"postId") (Json.Encode.int))) ((jsonEnc': ((jsonEnc':> (jsonEnc"userId") (Json.Encode.int))) ((jsonEnc': ((jsonEnc':> (jsonEnc"createdAt") (jsonEncNominalDiffTime))) (jsonEnc'[]))))))) ((jsonEncField (jsonEncIdentity)))) body)
            , expect =
                Http.expectJson toMsg jsonDecNoContent
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

getLikesById : Int -> (Result Http.Error  ((Maybe (:& (': (':> "postId" Int) (': (':> "userId" Int) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity))))  -> msg) -> Cmd msg
getLikesById capture_id toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "GET"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "likes"
                    , capture_id |> String.fromInt
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg (Json.Decode.maybe (jsonDec(:& (': (':> "postId" Int) (': (':> "userId" Int) (': (':> "createdAt" NominalDiffTime) '[]))) (Field Identity))))
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

deleteLikesById : Int -> (Result Http.Error  (NoContent)  -> msg) -> Cmd msg
deleteLikesById capture_id toMsg =
    let
        params =
            List.filterMap identity
            (List.concat
                [])
    in
        Http.request
            { method =
                "DELETE"
            , headers =
                []
            , url =
                Url.Builder.crossOrigin ""
                    [ "likes"
                    , capture_id |> String.fromInt
                    ]
                    params
            , body =
                Http.emptyBody
            , expect =
                Http.expectJson toMsg jsonDecNoContent
            , timeout =
                Nothing
            , tracker =
                Nothing
            }

module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Element exposing (Element, el, row, text)
import Html exposing (Html)
import Html.Events exposing (onClick)
import Http
import RemoteData exposing (RemoteData(..), WebData)
import Time
import Url



{-
   - POST data
-}


type alias Post =
    { userId : Int
    , title : String
    , content : String
    , imageUrls : List String
    , allowAutoEdit : Bool
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    }


fetchPosts : Cmd Msg
fetchPosts =
    Http.get { url = "http://127.0.0.1:8080/posts", expect = Http.expectJson (RemoteData.fromResult >> GotPosts) decodePosts }


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , posts : WebData (List Post)
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotPosts (WebData (List Post))


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url NotAsked, fetchPosts )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "Simple Post", body = elements model }


elements : Model -> List (Html Msg)
elements model =
    [ Element.layout [] (mainView model) ]


mainView : Model -> Element Msg
mainView model =
    row []
        [ helloMessage
        ]


helloMessage : Element Msg
helloMessage =
    text "Hello, world."


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }

module Multipage exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Browser.Navigation as Nav

-- main =
--     text "hello"

main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , subscriptions = subscriptions
        , update = update
        , view = view
        }

-- Model

type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


-- Update
type Msg
    = LinkClicked Browser.UrlRequest
      | UrlChanged Url.Url

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        -- UrlChanged url
    -- UrlChanged : Url.Url -> msg
    UrlChanged url ->
        ( { model | url = url }
        ,Cmd.none
        )

    -- onUrlRequest : Browser.UrlRequest -> msg
    -- onUrlRequest : Browser.UrlRequest -> msg
    LinkClicked urlRequest ->
        case urlRequest of
            Browser.Internal url ->
                ( model, Nav.pushUrl model.key (Url.toString url) )
            Browser.External href ->
                ( model, Nav.load href )


-- View
view : Model -> Browser.Document Msg
view model =
      { title = "URL Interceptor"
      , body =
          [ text "The current URL is: "
          , b [] [ text (Url.toString model.url) ]
          , ul []
              [ viewLink "/home"
              , viewLink "/profile"
              , viewLink "/reviews/the-century-of-the-self"
              , viewLink "/reviews/public-opinion"
              , viewLink "/reviews/shah-of-shahs"
              ]
          ]
      }


viewLink : String -> Html msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]

-- for Main

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd msg )
init flags url key =
       (Model key url, Cmd.none)



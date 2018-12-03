module Garudabuy.Page.Admin exposing (..)

import Garudabuy.Session exposing (Session)

import Html exposing (Html, div, text, p)

type Msg =
    ApproveUser String

type alias Model =
    { session : Session
    }


init : Session -> (Model, Cmd Msg)
init session =
    ({ session = session
    },
         Cmd.batch []
    )


toSession : Model -> Session
toSession model =
    model.session

view: Model -> { title: String, content: Html msg }
view model =
    { title = "Admin page"
    , content =
        div
        [][ text "I am Admin page" ]
    }


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ApproveUser username ->
            (model, Cmd.none)

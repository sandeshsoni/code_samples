module Garudabuy.Page.Home exposing (..)
import Garudabuy.Session exposing (Session)

import Html exposing (Html, div, text)

type Msg =
    ChangeTitle String


type alias Model =
    { session: Session
    , title: String
    }

init : Session -> (Model, Cmd Msg)
init session =
    ({ session = session
     , title = "Initial title"
     }
    , Cmd.batch []
    )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ChangeTitle toTitle ->
            ({ model | title = toTitle}, Cmd.none)


view : Model -> { title: String, content: Html Msg }
view model =
    { title = "Home Page title"
    , content = div [][ text "Home body"]
    }


toSession : Model -> Session
toSession model =
    model.session

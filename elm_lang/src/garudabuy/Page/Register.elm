module Garudabuy.Page.Register exposing (..)

import Html exposing (Html, div, text, p)
import Garudabuy.Session as Session exposing (Session)

type Msg
    = EnteredEmail String
    | EnteredName String
    | SubmittedForm


type Field
    = Email
    | Name
    | Location

type Problem
    = ValidationField Field
    | ServerError String

type alias Model =
    { session : Session
    , form : Form
    , problems : List Problem
    }

type alias Form =
    { name: String
    , email: String
    , location : String
    }

initForm =
    { name = ""
    , email = ""
    , location = ""
    }

init : Session -> (Model, Cmd Msg)
init session =
        ({ session = session
        , form = initForm
        , problems = []
        }
             , Cmd.none
        )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        EnteredName name ->
            updateForm(\form -> { form | name = name }) model
        -- TODO add other update
        _ ->
            (model, Cmd.none)


updateForm : (Form -> Form) -> Model -> (Model, Cmd msg)
updateForm transformForm model =
    ({model | form = transformForm model.form }, Cmd.none)

view : Model -> {title: String, content: Html msg}
view model =
    { title = "Register as a new User"
    , content = div[][ text "Register form" ]
    }


toSession : Model -> Session
toSession model =
    model.session

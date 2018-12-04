module Garudabuy.Page.Login exposing (..)

import Html exposing (Html, div, p, input, form, text)

import Garudabuy.Session exposing (Session)

type Msg
    = EnteredEmail String
    | EnteredPassword String


type alias Form =
    { email : String
    , password : String
    }

initialForm : Form
initialForm =
    { email = ""
    , password = ""
    }

type Problem
    = InternalProblem String
    | ServerProblem String

type alias Model =
    { session : Session
    , form : Form
    , problems : List Problem
    }


init : Session -> (Model, Cmd Msg)
init session =
    ({ session = session
     , form = initialForm
     , problems = []
     }
    , Cmd.none
    )

update : Msg -> Model -> (Model, Cmd msg)
update msg model =
    case msg of
        EnteredEmail email ->
            updateForm(\form -> { form | email = email }) model
        EnteredPassword password ->
            updateForm(\form -> { form | password = password }) model

updateForm : (Form -> Form) -> Model -> (Model, Cmd msg)
updateForm transform model =
    ({ model | form = transform model.form }, Cmd.none)

view : Model -> { title: String, content: Html Msg }
view model =
    { title = "Login"
    , content = div[][text "login form"]
    }


toSession : Model -> Session
toSession model =
    model.session

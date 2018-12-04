module Garudabuy.Page.Login exposing (..)

import Html exposing (Html, div, p, input, form, text, fieldset)
import Html.Attributes exposing (placeholder, class, value)
import Html.Events exposing (..)

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
    , content = div[][ viewForm model.form
                     , div [][text "email is"]
                     , div [][text model.form.email]
                     ]
    }


viewForm : Form -> Html Msg
viewForm form =
    Html.form []
        [ fieldset [ class "form-group" ]
              [ input
                    [ placeholder "Email"
                    , value form.email
                    , onInput EnteredEmail
                    ]
                    []
              ]
        , fieldset [ class "form-group" ]
              [ input
                    [ placeholder "password"
                    , value form.password
                    ]
                    []
              ]

        ]



toSession : Model -> Session
toSession model =
    model.session

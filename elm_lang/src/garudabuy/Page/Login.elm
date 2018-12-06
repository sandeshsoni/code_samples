module Garudabuy.Page.Login exposing (..)

import Html exposing (Html, div, p, input, form, text, fieldset)
import Html.Attributes exposing (placeholder, class, value)
import Html.Events exposing (..)

import Garudabuy.Session exposing (Session)

type Msg
    = EnteredEmail String
    | EnteredPassword String
    | GotSession Session


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
    Debug.log("Login.elm -> init")
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
            Debug.log("Login.elm -> update - Entered email")
            updateForm(\form -> { form | email = email }) model
        EnteredPassword password ->
            Debug.log("Login.elm -> update - Entered passwd")
            updateForm(\form -> { form | password = password }) model
        GotSession session ->
            Debug.log("Home.elm -> update -> GotSessoin")
            ({ model | session = session }, Cmd.none)

updateForm : (Form -> Form) -> Model -> (Model, Cmd msg)
updateForm transform model =
    Debug.log("Login.elm -> upd8 form")
    ({ model | form = transform model.form }, Cmd.none)

view : Model -> { title: String, content: Html Msg }
view model =
    Debug.log("Login.e view")
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
    Debug.log("Login.e toSession")
    model.session

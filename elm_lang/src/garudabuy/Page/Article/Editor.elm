module Garudabuy.Page.Article.Editor exposing (..)

-- import Html exposing (Html, Form, div, text, fieldset, input)
import Html exposing (..)
import Html.Attributes exposing (class, placeholder, value )
import Html.Events exposing (onInput, onSubmit)

import Garudabuy.Session as Session exposing (Session)
import Garudabuy.Api exposing (Cred)


-- Article form
-- maybe tags should be List Tag, in advanced app
type alias Form =
    { title: String
    , body: String
    , description: String
    , tags: String
    }


type Field
    = Title
    | Body
    | Desctiption
    | Tags

type Problem
    = ValidationProblem Field
    | ServerProblem String

-- As we fetch from server
-- a = anything
type Status
    = Loading
    | Loaded
    | Failed
    | EditingNew (List Problem) Form

-- Articles are stored inside Status
type alias Model =
    { session : Session
    , status : Status
    }

initNew : Session -> (Model, Cmd msg)
initNew session =
    ({ session = session
     , status = EditingNew [] { title = ""
                              , body = ""
                              , description = ""
                              , tags = ""
                              }
     }
    , Cmd.none
    )

-- initEdit : session -> (Model, Cmd msg)
-- Load from Server

type Msg
    = ClickedSave
    -- | ClickedReset
    | EnteredTitle String
    | EnteredDescription String

-- Cmd Msg can be ... make Api call
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        EnteredTitle title ->
            updateForm(\form -> { form | title = title }) model
        EnteredDescription description ->
            updateForm(\form -> { form | description = description }) model
        ClickedSave ->
            (model, Cmd.none)


-- case statement for status.
updateForm : (Form -> Form) -> Model -> (Model, Cmd msg)
updateForm transformForm model =
    let newModel =
            case model.status of
                EditingNew errors form ->
                    { model | status = EditingNew errors (transformForm form) }
                _ ->
                    model
    in
        (newModel, Cmd.none)



-- view for Article New, Editing, show.

view : Model -> {title: String, content: Html Msg}
view model =
    { title = "New / Editing Article - slug"
          -- model.status. Loaded Article . title
    , content = div [][ text "Article Body. New/Edit"
                      -- , viewAuthenticated (Cred "hola") model
                      , viewAuthenticated  model
                      ]
    }

-- view helper

-- viewAuthenticated : Cred -> Model -> Html Msg
-- viewAuthenticated cred model =
viewAuthenticated : Model -> Html Msg
viewAuthenticated  model =
    let
        formHtml =
            case model.status of
                EditingNew problems form ->
                    [ viewProblems problems
                    -- -- , viewForm cred form (div[][text "save Btn"])
                    , viewForm form (div[][text "save Btn"])
                    ]
                _ ->
                    [ div[][text "something other than new"] ]
    in
        div [] formHtml

-- viewForm : Cred -> Form -> Html Msg -> Html Msg
-- viewForm cred fields saveButton =
viewForm : Form -> Html Msg -> Html Msg
viewForm fields saveButton =
    Html.form []
        [ fieldset []
              [fieldset [class "form-group"]
                   [ input
                         [ class ""
                         , placeholder "title"
                         , onInput EnteredTitle
                         , value fields.title
                         ]
                         []
                   ]
              , fieldset [class "form-group"]
                  [ input
                        [ class ""
                        , placeholder "description"
                        , onInput EnteredDescription
                        , value fields.description
                        ]
                        []
                  ]
              , saveButton
              ]
        ]


viewProblems : (List Problem) -> Html Msg
viewProblems problems =
    div [] [ text ""]

-- helper

toSession : Model -> Session
toSession model =
    model.session

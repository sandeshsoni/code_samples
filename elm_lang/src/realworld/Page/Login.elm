module RealWorld.Page.Login exposing(..)

import Http
import Html exposing(..)
import Html.Events exposing(..)
import Html.Attributes exposing(..)
import Json.Encode as Encode
import RealWorld.Api exposing (..)
import Json.Decode exposing (Decoder, field, string)

-- alias Model
-- create Form
-- initial Form
-- type msg
-- Update msg
-- update
-- case in update. for on field enter.
-- write updateForm
-- case in update. on formSubmit. check validations.
-- write validate form
-- write validate fields
-- create type TrimmedForm
-- create type
-- function trimFields call from Case
-- create trimFields(form) function
-- Api Login.
-- Endpoint for Api
-- Viewer
-- http Login
-- import JSON Encode object
-- update -> Completed Login
-- https://package.elm-lang.org/packages/elm-lang/core/latest/Result
-- Result - A great way to manage errors in ELM. => type Result error value

type alias Model =
    { form: Form
    , problems: List Problem
    }

type alias Form =
    { email: String
    , password: String
    }

type Problem = InvalidEntry ValidatedField String
    | ServerError String

initialForm : Form
initialForm =
    { email = ""
    , password = ""
    }

type Msg
    = EnteredEmail String
    | EnteredPassword String
    -- | FormSubmitted
    -- | FormValidationFail
    | SubmittedForm
    | CompletedLogin (Result Http.Error String)

-- UPDATE

-- Question.
-- why \form over form?
-- discuss

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SubmittedForm ->
            case validate model.form of
                Ok validForm ->
                    ({ model | problems = [] }
                    , Http.send CompletedLogin (login validForm)
                    )
                Err problems ->
                    ({ model | problems = problems}, Cmd.none)
        EnteredEmail email ->
            updateForm(\form -> { form |  email = email }) model
        EnteredPassword password ->
            updateForm(\form -> { form | password = password }) model
        CompletedLogin (Ok viewer) ->
            ( model, Cmd.none
            -- , Viewer.store viewer
            )
        CompletedLogin(Err error) ->
            ( model, Cmd.none )

-- UpdateForm helper method
updateForm : (Form -> Form) -> Model -> (Model, Cmd Msg)
updateForm transform model =
    ({ model | form = transform model.form }, Cmd.none)


-- Not clear. whats difference between TrimmedForm and Trimmed Form?
-- TRIMMED FORM
type TrimmedForm
    = Trimmed Form

type ValidatedField
    = Email
    | Password

fieldsToValidate : List ValidatedField
fieldsToValidate =
    [ Email
    , Password
    ]

-- validate each field
validate : Form -> Result (List Problem) TrimmedForm
validate form =
    let
        trimmedForm =
            trimFields form
    in
        case List.concatMap (validateField trimmedForm) fieldsToValidate of
            [] ->
                Ok trimmedForm
            problems ->
                Err problems


validateField : TrimmedForm -> ValidatedField -> List Problem
validateField (Trimmed form ) field =
    List.map (InvalidEntry field) <|
        case field of
            Email ->
                if String.isEmpty form.email then
                    [ "email can't be blank." ]

                else
                    []

            Password ->
                if String.isEmpty form.password then
                    [ "Password can't be blank." ]

                else
                    []


-- trimFields
trimFields : Form -> TrimmedForm
trimFields form =
    Trimmed
        { email = String.trim form.email
        , password = String.trim form.password
        }



-- VIEW

view : Model -> { title: String, content: Html Msg }
view model =
    { title = "Login"
    , content =
        div [ class "cred-page" ]
            [ text "Need an Account"
            , viewForm model.form
            ]
    }


viewForm : Form -> Html Msg
viewForm form =
    Html.form [ onSubmit SubmittedForm ]
        []


-- Http

login : TrimmedForm -> Http.Request String
login (Trimmed form) =
    let
        user =
            Encode.object
                [ ( "email", Encode.string form.email )
                , ("password", Encode.string form.password)
                ]

        body =
            Encode.object [ ("user", user) ]
                |> Http.jsonBody
    in
        RealWorld.Api.login body (field "image_url" string)



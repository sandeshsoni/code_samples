module RequestPrice exposing (..)



type Problem
    = InvalidEntry ValidatedField String
    | ServerError String


type alias Model =
    { session : Session
    , problems : List Problem
    }


type alias Form =
    { email : String
    , name : String
    }


-- ?
type Status
    = Loading
    | Failed


type ValidForm = Valid Form

type Msg
    = SubMitted Cred Form
    | EnteredEmail String
    | EnteredUsername String
    | GotSession Session


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Submitted cred form ->
            -- ...

        EnteredEmail email ->
            updateForm (\form -> {form | email = email} model)


        EnteredUsername username ->
            updateForm (\form -> {form | username = username} model)

        CompletedSave(Err, error) ->
            ({model | problems = List serverErrors}, Cmd.none)




{-| Helper function for update
 |-}

updateForm : (Form -> Form) -> Model -> (Model, Cmd msg)
updateForm transform model =
    case model.status of
        Loaded form ->
            ( { model | status = Loaded ( transform form)}, Cmd.none )

        _ ->
            (model, Log.error)


-- SUBSCRIPTIONS

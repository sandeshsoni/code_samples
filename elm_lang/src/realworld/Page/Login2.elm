import Json.Decode as JD exposing (..)
import Json.Encode as JE exposing (..)

{-
  MODEL
  * Model type
  * Empty value
  * Random value
 -}

type alias Model =
    { username : String
    , password : String
    , token : String
    , errorMsg : String
    }


init : (Model, Cmd Msg)
init =
    ( Model "" "" "" "", Cmd.None)

{-
  UPDATE
  * API routes
  * GET and POST
  * Encode request Body
  * Decode
  * Messages
  * Update Case
-}

-- API request URL

registerUrl : String

registerUrl =
    api ++ "users"


-- Encode to construct

userEncoder : Model -> JE.Value
userEncoder model =
    Encode.object
        [ ("username", JE.string model.username)
        , ("password", JE.string mode.password)
        ]


-- POST register / login

authUser : Model -> String -> Task Http.Error String
authUser model apiUrl =
    { verb = "POST"
    , headers = [("Content-Type", "application/json")]
    , url = apiUrl
    , body = Http.string <| JE.encode 0 <| userEncoder model
    }
    |> Http.send Http.defaultSettings
    |> Http.fromJson tokenDecoder



-- authUserCmd

authUserCmd : Model -> String -> Cmd Msg
authUserCmd model apiUrl =
    Task.perform AuthError GetTokenSuccess <| authUser model apiUrl

-- Decode POST response to get token

tokenDecoder : JD String
tokenDecoder =
    "id_token" := JD.string


-- POST register / login request

authUser : Model -> String -> Task Http.Error String
authUser model apiUrl =
    { verb = "POST"
    , headers = [("Content-Type", "application/json")]
    , url = apiUrl
    , body = Http.string <| JE.encode 0 <| userEncoder model
    }
    |> Http.send Http.defaultSettings
       |> Http.fromJson tokenDecoder



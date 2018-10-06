module RealWorld.Api exposing (..)

import Html exposing (..)
import RealWorld.Api.Endpoint as Endpoint exposing (Endpoint)
import Http exposing (Body, Expect)
import Url

import Json.Decode as Decode exposing (Decoder, Value, decodeString, field, string)
import Json.Decode.Pipeline as Pipeline exposing (optional, required)

-- import JSON decoder
-- Http.post
-- Http.request
-- Cred Decoder
-- import NoRedInk / elm-Json-decode-pipeline pipeline optional and required

type Cred
    = Cred String

credDecoder : Decoder Cred
credDecoder =
    Decode.succeed Cred
        -- |> required "username" Username.decoder
        |> required "token" Decode.string


-- login

login : Http.Body -> Decoder( a) -> Http.Request a
login body decoder =
    post Endpoint.login Nothing body (Decode.field "user" (decoder))

-- repl Http.post

-- post : String -> Http.Body -> Json.Decode.Decoder a -> Http.Request a
-- post : Endpoint -> Http.Body -> Json.Decode.Decoder a -> Http.Request a
-- post : Endpoint -> Maybe Cred -> Body -> Decoder a -> Http.Request a
post : Endpoint -> Maybe Cred -> Body -> Decoder a -> Http.Request a
post url maybeCred body decoder =
    Endpoint.request { body = body
                     , expect = Http.expectJson decoder
                     , headers =
                         case maybeCred of
                             Just cred ->
                                 []
                             Nothing ->
                                 []
                     , method = "POST"
                     , timeout = Nothing
                     , url = url
                     , withCredentials = False
        }


decoderFromCred : Decoder (Cred -> a) -> Decoder a
decoderFromCred decoder =
    Decode.map2 (\fromCred cred -> fromCred cred)
        decoder
        credDecoder

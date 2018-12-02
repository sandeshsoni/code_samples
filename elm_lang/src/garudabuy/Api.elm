module Garudabuy.Api exposing (..)

import Garudabuy.Username exposing (..)
-- import Garudabuy.Viewer as Viewer

import Browser
import Browser.Navigation as Nav

import Json.Decode as Decode exposing (Decoder, Value, decodeValue)
import Json.Decode.Pipeline as Pipeline exposing (required, optional)
import Url exposing (Url)

import Garudabuy.Username as Username exposing (Username)

type Cred
    = Cred Username String


-- why MaybeViewer?
-- why small viewer not Viewer??

application :
    Decoder(Cred -> viewer)
        ->
          { init : Maybe viewer -> Url -> Nav.Key -> (model, Cmd msg)
          , onUrlChange : Url -> msg
          , onUrlRequest : Browser.UrlRequest -> msg
          , subscriptions : model -> Sub msg
          , update : msg -> model -> (model, Cmd msg)
          , view : model -> Browser.Document msg
          }
          -> Program Value model msg
application viewerDecoder config =
    let
        init flags url navKey =
            let
                maybeViewer =
                    Decode.decodeValue Decode.string flags
                        |> Result.andThen (Decode.decodeString (storageDecoder viewerDecoder))
                           |> Result.toMaybe
            in
            config.init maybeViewer url navKey
    in
        Browser.application
            { init = init
            , onUrlChange = config.onUrlChange
            , onUrlRequest = config.onUrlRequest
            , subscriptions = config.subscriptions
            , update  = config.update
            , view  = config.view
            }



storageDecoder : Decoder(Cred -> viewer) -> Decoder viewer
storageDecoder viewerDecoder =
    Decode.field "user" (decoderFromCred viewerDecoder)

decoderFromCred : Decoder ( Cred -> a) -> Decoder a
decoderFromCred decoder =
    Decode.map2(\fromCred cred -> fromCred cred)
    decoder
    credDecoder

credDecoder : Decoder Cred
credDecoder =
    Decode.succeed Cred
        |> required "username" Username.decoder
        |> required "token" Decode.string


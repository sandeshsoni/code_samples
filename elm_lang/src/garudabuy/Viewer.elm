module Garudabuy.Viewer exposing (..)

import Garudabuy.Avatar as Avatar exposing (..)
import Garudabuy.Api exposing (Cred)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (custom)


-- - TYPES

type Viewer =
    Viewer Avatar Cred


-- getter setter

cred : Viewer -> Cred
cred (Viewer _ val) =
    Debug.log("V -> cred")
    val




avatar : Viewer -> Avatar
avatar (Viewer val _) =
    val

decoder : Decoder (Cred -> Viewer)
decoder =
    Debug.log("V -> decoder")
    Decode.succeed Viewer
        |> custom (Decode.field "image" Avatar.decoder)

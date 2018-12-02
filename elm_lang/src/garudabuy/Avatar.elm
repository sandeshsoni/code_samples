module Garudabuy.Avatar exposing (..)

import Json.Decode as Decode exposing (Decoder, string)

type Avatar
    = Avatar (Maybe String)


decoder : Decoder Avatar
decoder =
    Decode.map Avatar (Decode.nullable Decode.string)

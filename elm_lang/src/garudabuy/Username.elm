module Garudabuy.Username exposing (..)

import Json.Decode as Decode exposing (Decoder)

type Username
    = Username String

toString : Username -> String
toString (Username val)
    = val


decoder : Decoder Username
decoder =
    Decode.map Username Decode.string

module RealWorld.Api.Endpoint exposing(Endpoint, request, url, login)

import Http

import Url.Builder exposing (QueryParameter)


-- Endpoint.Elm
-- QueryParameter builder from import.
-- type Endpoint
-- function : url
-- in elm repl, get fn defn of Http.request
-- function : request. accepting config.
-- Html.Request a. create request function
-- JSON.decode decoder.


type Endpoint
    = Endpoint String

unwrap : Endpoint -> String
unwrap (Endpoint str) =
    str

url : List String -> List QueryParameter -> Endpoint
url paths queryParams =
    Url.Builder.crossOrigin "https://localhost:4000"
        ("api" :: paths)
        queryParams
        |> Endpoint


request :
    { body : Http.Body
    , expect : Http.Expect a
    , headers : List Http.Header
    , method : String
    , timeout : Maybe Float
    , url : Endpoint
    , withCredentials : Bool
    }
    -> Http.Request a

request config =
    Http.request
        { body = config.body
        , expect = config.expect
        , headers = config.headers
        , method = config.method
        , timeout = config.timeout
        , url = unwrap config.url
        , withCredentials = config.withCredentials
        }

-- Endpoints

-- Login

login =
    url ["users","login"] []

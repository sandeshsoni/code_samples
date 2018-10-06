module Cart.State exposing (init, update, subscriptions)

import Cart.Types exposing (..)

availableProducts : List Product
availableProducts =
    [ Product
          "1"
          "One"
          "Free Delivery"
          123.45
          True
          (Just "https://picsum.photos/200/300?image=910")
          "product A"
    , Product
          "2"
          "two"
          "Free Delivery"
          234.56
          True
          (Just "https://picsum.photos/200/300?image=810")
          "product B"
    ]


-- init

init : () -> ( Model, Cmd Msg )
init _ =
    let
        model =
            Model (Cart []) availableProducts ProductList Nothing
        command =
            (Cmd.none)
    in
        (model, command)



-- methods

addToCart : Cart -> Product -> Cart
addToCart cart product =
    let quanity =
            1

        updatedItems =
            List.append cart.items [ Item product quanity ]
    in
        { cart | items = updatedItems }



-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- update

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        AddToCart product ->
            let model2 = { model | cart = (addToCart model.cart product) }
            in
                (model2, Cmd.none)

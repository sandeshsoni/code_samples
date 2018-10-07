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
          (Just "https://picsum.photos/150/100?image=50")
          "product A"
    , Product
          "2"
          "two"
          "Free Delivery"
          234.56
          False
          (Just "https://picsum.photos/150/100?image=2")
          "product B"
    , Product
          "3"
          "Product three"
          "Free Delivery"
          550.00
          True
          (Just "https://picsum.photos/150/100?image=24")
          "product C, set of 3pieces"
    ]

categories : List Category
categories =
    [ Category
          "1"
          "Safety Shoes"
          ""
          [ SubCategory
                "1"
                "Helmets"
          , SubCategory
                "2"
                "Eye Protection"
          , SubCategory
                "3"
                "Face Protection"
          , SubCategory
                "4"
                "Hand Protection"
          ]
    , Category
          "2"
          "Hand Tools"
          "hand tools lorel ipsum"
          []
    , Category
          "3"
          "Testing and measuring Equipments"
          ""
          [ SubCategory
                "31"
                "Measurement Tape"
          , SubCategory
                "32"
                "Thermometer"
          ]
    , Category
          "4"
          "Tooling and cutting"
          ""
          []
    , Category
          "5"
          "Corporate Gifting"
          ""
          []
    ]


-- init

init : () -> ( Model, Cmd Msg )
init _ =
    let
        model =
            Model (Cart []) availableProducts categories ProductList Nothing
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

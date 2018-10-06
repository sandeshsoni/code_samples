module Cart.View exposing (view)

import Cart.Types exposing (..)
import Html exposing (div, h1, ul, li, text, img, a, header)
import Html.Attributes exposing(class, src, href)
import Numeral as Numeral

defaultProductPictureURL = "http://www.abc.com"

getProductPictureURL : Product -> String
getProductPictureURL product =
    case product.pictureURL of
        Just url ->
            url
        Nothing ->
            defaultProductPictureURL

formatCurrency : Float -> String
formatCurrency amount =
    (Numeral.format "0,00.00" amount) ++ " $"

productDescriptionView : Product -> Html.Html Msg
productDescriptionView product =
    div [ class "elm-cart-product-detail-description" ]
        [ text product.description ]

page : Model -> Html.Html Msg
page model =
    div [ class "elm-cart-page container-fluid" ]
        [ case model.page of
              ProductList ->
                  productListView model
              ProductDetail ->
                  productDetailView model
              -- Checkout ->
              --     checkOutView
        ]

productViewInStock : Product -> Html.Html Msg
productViewInStock product =
    li [ class "elm-cart-product" ]
        [ div []
              [div [ class "elm-cart-product-image" ]
                  [ img [ src (getProductPictureURL product) ] []
                  ]
              , div [ class "elm-cart-product-name" ][ text product.name ]
              , div [ class "elm-cart-product-price elm-cart-button" ][ text ( formatCurrency product.price) ]
              ]
        ]

productViewOutOfStock : Product -> Html.Html Msg
productViewOutOfStock product =
    li [ class "elm-cart-product" ]
        [ div []
              [div [ class "elm-cart-product-image" ]
                  [ img [ src (getProductPictureURL product) ] []
                  ]
              , div [ class "elm-cart-product-name" ] [ text product.name ]
              , div [ class "elm-cart-product-price elm-cart-button" ] [text ("OUT OF STOCK")]
              ]
        ]

productDetailView : Model -> Html.Html Msg
productDetailView model =
    case model.currentProduct of
        Just product ->
            div [ class "elm-cart-product-detail" ]
                [ div [ class "elm-cart-product-detail-name" ][ text product.name ]
                , img
                    [ class "elm-cart-product-detail-image"
                    , src (getProductPictureURL product)
                    ]
                    []
                , div [ class "elm-cart-product-detail-price" ] [ text (formatCurrency product.price) ]
                , productDescriptionView product
                ]
        Nothing ->
            div [] [text "There is no product"]


productView : Product -> Html.Html Msg
productView product =
    if product.isInStock then
        (productViewInStock product)
    else
        (productViewOutOfStock product)


productsView : List Product -> Html.Html Msg
productsView products =
    div []
        [ ul [class "elm-cart-products row"] (List.map productView products)
        ]


productListView : Model -> Html.Html Msg
productListView model =
    div []
        [ productsView model.availableProducts
        ]

headerView : Model -> Html.Html Msg
headerView model =
    header [ class "elm-cart-header row" ]
        [ a
          [ class "home"
          , (href "#")
          ]
  [ text "Home" ]
        , a
  [ class "elm-cart-header-checkout cart"
  ]
  [ text "" ]
        ]


footerView : Model -> Html.Html Msg
footerView model =
    div [ class "elm-footer" ]
        [ text "foo bar"
        , Html.br [] []
        ]


view : Model -> Html.Html Msg
view model =
    div
        []
        [ headerView model
        , page model
        , footerView model
        ]

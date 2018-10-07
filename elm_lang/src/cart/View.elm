module Cart.View exposing (view)

import Cart.Types exposing (..)
import Html exposing (div, h1
                     , ul, li
                     , text, strong, b
                     , img
                     , a,p, header)
import Html.Attributes exposing(class, src, href, style)
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
    div [ class "elm-cart-page container-fluid"
        , style "display" "flex"
        , style "flex" "1"
        , style "flex-direction" "row"
        ]
        [ div [ style "flex" "1" ] [ categoriesView model.availableCategories ]
        , div [ style "flex" "4"
              , style "flex-direction" "row"
              ] [ case model.page of
                                         ProductList ->
                                             productListView model
                                         ProductDetail ->
                                             productDetailView model
                                   ]
        -- Checkout ->
        --     checkOutView
        ]

productViewInStock : Product -> Html.Html Msg
productViewInStock product =
    li [ class "elm-cart-product"
       , style "display" "flex"
       ]
        [ div []
              [div [ class "elm-cart-product-image" ]
                  [ img [ src (getProductPictureURL product) ] []
                  ]
              , div [ class "elm-cart-product-name" ][ text product.name ]
              , div [ class "elm-cart-product-price elm-cart-button" ][ text ( formatCurrency product.price) ]
              , productDescriptionView product
              ]
        ]

productViewOutOfStock : Product -> Html.Html Msg
productViewOutOfStock product =
    li [ class "elm-cart-product"
       , style "display" "flex"
       ]
        [ div []
              [div [ class "elm-cart-product-image" ]
                  [ img [ src (getProductPictureURL product) ] []
                  ]
              , div [ class "elm-cart-product-name" ] [ text product.name ]
              , div [ class "elm-cart-product-price elm-cart-button" ] [text ("OUT OF STOCK, Lead Time: 10days")]
              , productDescriptionView product
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


-- Product List

productView : Product -> Html.Html Msg
productView product =
    if product.isInStock then
        (productViewInStock product)
    else
        (productViewOutOfStock product)


productsView : List Product -> Html.Html Msg
productsView products =
    div []
        [ p [ style "background-color" "pink" ] [text "filters"]
        , ul [ class "elm-cart-products row"
             , style "display" "flex"
             , style "align-items" "flex-start"
             , style "flex-wrap" "wrap"
             ] (List.map productView products)
        ]


productListView : Model -> Html.Html Msg
productListView model =
    div []
        [ productsView model.availableProducts
        ]

-- Category and SubCategory list

subCategoryView : SubCategory -> Html.Html Msg
subCategoryView subCategory =
    li [][ text subCategory.name ]

categoryView : Category -> Html.Html Msg
categoryView category =
    li [][ b [][ text category.name ]
         , ul [ style "list-style-type" "none"]
             (List.map subCategoryView category.subCategories)
         ]


categoriesView : List Category -> Html.Html Msg
categoriesView categories =
    div []
        [ ul [ class "elm-cart-categories row"
             , style "list-style-type" "none"
             ] (List.map categoryView categories)
        ]

-- leftSide : List (String, String)
-- leftSide = [("background", "red")]

-- background : List (String, String)
-- background =
--     [ ("background-color", "rgb(245, 245, 245)")
--     ]

--

headerView : Model -> Html.Html Msg
headerView model =
    header [ class "elm-cart-header row"
           , style "background-color" "grey"
           , style "padding" "20px"
           , style "display" "flex"
           ]
        [ a [ class "logo"] [ text "Procurlae " ]
        , a [ class "home" , (href "#")] [ text "Home" ]
        , a [ class "elm-cart-header-checkout cart"] [ text "" ]
        , a [ class ""] [ text "Login" ]
        , a [ class ""] [ text "Premium Member" ]
        ]


footerView : Model -> Html.Html Msg
footerView model =
    div [ class "elm-footer" ]
        [ text "foo bar footer, 2018. formulae"
        , Html.br [] []
        ]


view : Model -> Html.Html Msg
view model =
    div
        [ style "display" "flex"
        , style "flex" "1"
        , style "flex-direction" "column"
        ]
        [ headerView model
        , page model
        , footerView model
        ]

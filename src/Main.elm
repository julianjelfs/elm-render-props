module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import ColourClicker as C
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



---- MODEL ----


type alias Model =
    { colourClicker : C.Model }


init : ( Model, Cmd Msg )
init =
    ( { colourClicker = C.init }, Cmd.none )



---- UPDATE ----


type Msg
    = ColourClickerMsg (C.Msg Msg)
    | ButtonClicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ColourClickerMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    C.update subMsg model.colourClicker
            in
            ( { model | colourClicker = subModel }, subCmd )

        ButtonClicked ->
            let
                _ =
                    Debug.log "Button Clicked!" ()
            in
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "demo" ]
        [ h1 [] [ text "Demo of render props technique for Elm" ]
        , Html.map ColourClickerMsg <|
            C.view model.colourClicker
                [ div []
                    [ text "Now we need to add a button"
                    , button [ onClick ButtonClicked ] [ text "Click me!" ]
                    ]
                ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }

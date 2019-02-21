module ColourClicker exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { colour : String }


type Msg
    = ToggleColour


init : Model
init =
    { colour = "blue" }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleColour ->
            toggleColour model


toggleColour : Model -> Model
toggleColour model =
    case model.colour of
        "blue" ->
            { model | colour = "red" }

        _ ->
            { model | colour = "blue" }


view : Model -> List (Html Msg) -> Html Msg
view model content =
    div
        [ class "colour-clicker" ]
        [ h1
            [ onClick ToggleColour
            , style "background" model.colour
            ]
            [ text "This is the magical header" ]
        , div []
            content
        ]

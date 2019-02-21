module ColourClicker exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task


type alias Model =
    { colour : String }


type Msg parent
    = ToggleColour
    | Parent parent


init : Model
init =
    { colour = "blue" }


update : Msg parent -> Model -> ( Model, Cmd parent )
update msg model =
    case msg of
        ToggleColour ->
            ( toggleColour model, Cmd.none )

        Parent p ->
            ( model, Task.perform identity (Task.succeed p) )


toggleColour : Model -> Model
toggleColour model =
    case model.colour of
        "blue" ->
            { model | colour = "red" }

        _ ->
            { model | colour = "blue" }


wrap : Html parent -> Html (Msg parent)
wrap =
    Html.map Parent


view : Model -> List (Html parent) -> Html (Msg parent)
view model content =
    div
        [ class "colour-clicker" ]
        [ h1
            [ onClick ToggleColour
            , style "background" model.colour
            ]
            [ text "This is the magical header" ]
        , div []
            (List.map wrap content)
        ]

module Main exposing (main)

import Browser
import Html.Styled exposing (Html, button, div, text)
import Html.Styled.Events exposing (onClick)



-- MAIN


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { counter : Int, textList : List String }


init : flags -> ( Model, Cmd Msg )
init _ =
    ( 0, Cmd.none )



-- UPDATE


type Msg
    = Increment
    | Decrement
    | AddInputText String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | counter = counter + 1 }, Cmd.none )

        Decrement ->
            ( { model | counter = counter - 1 }, Cmd.none )

        AddInputText value ->
            ( { model | textList = value }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


inputItem inputText =
    [ input [ onInput (AddInputText model.newPost), placeholder "Title" ] [] ]


view : Model -> Browser.Document Msg
view model =
    let
        body =
            div []
                [ div []
                    [ button [ onClick Decrement ] [ text "-" ]
                    , div [] [ text (String.fromInt model.counter) ]
                    , button [ onClick Increment ] [ text "+" ]
                    ]
                , div
                    []
                    [ button [ onClick AddField ] [ text "Add" ] ]
                ]
    in
    { body = [ Html.Styled.toUnstyled body ]
    , title = "sigrid title"
    }

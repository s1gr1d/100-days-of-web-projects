module Main exposing (main)

import Browser
import Css exposing (..)
import Html.Styled exposing (Html, button, div, h1, input, li, section, text, ul)
import Html.Styled.Attributes exposing (css, placeholder, value)
import Html.Styled.Events exposing (onClick, onInput)



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
    { counter : Int, gratitudeText : String, gratitudeElements : List String }


init : flags -> ( Model, Cmd Msg )
init _ =
    ( { counter = 0, gratitudeText = "", gratitudeElements = [] }, Cmd.none )



-- UPDATE


type Msg
    = EditGratitudeElement Int
    | AddGratitudeElement String
    | EnteredGratitudeText String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EditGratitudeElement index ->
            ( { model | gratitudeElements = "" :: model.gratitudeElements }, Cmd.none )

        AddGratitudeElement value ->
            ( { model | gratitudeElements = value :: model.gratitudeElements }, Cmd.none )

        EnteredGratitudeText value ->
            ( { model | gratitudeText = value }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


gratitudeList : List String -> Html Msg
gratitudeList list =
    ul
        [ css
            [ displayFlex
            , justifyContent center
            , alignItems center
            , flexDirection column
            ]
        ]
        (List.indexedMap (\idx itemText -> gratitudeElement idx itemText) list)


gratitudeElement : Int -> String -> Html Msg
gratitudeElement index elementText =
    li
        [ css
            [ fontFamilies [ "Lucida Sans Unicode", "sans-serif" ]
            ]
        ]
        [ text elementText

        {--, button [ onClick (EditGratitudeElement index) ] [ text "edit" ] --}
        ]


view : Model -> Browser.Document Msg
view model =
    let
        body =
            section
                [ css
                    [ displayFlex
                    , justifyContent center
                    , alignItems center
                    , marginTop (vh 10)
                    , fontFamilies [ "Palatino Linotype", "Georgia", "serif" ]
                    ]
                ]
                [ div []
                    [ h1
                        [ css
                            [ fontFamilies [ "Courier New", "monospace" ]
                            ]
                        ]
                        [ text "My gratitude list" ]
                    , div
                        [ css
                            [ displayFlex
                            , justifyContent center
                            , alignItems center
                            ]
                        ]
                        [ input [ onInput EnteredGratitudeText, value model.gratitudeText, placeholder "What are you grateful for?" ] []
                        , button
                            [ css
                                [ displayFlex
                                , justifyContent center
                                , alignItems center
                                , margin (px 10)
                                , padding2 (px 5) (px 10)
                                ]
                            , onClick (AddGratitudeElement model.gratitudeText)
                            ]
                            [ text "Add" ]
                        ]
                    , gratitudeList model.gratitudeElements
                    ]
                ]
    in
    { body = [ Html.Styled.toUnstyled body ]
    , title = "sigrid title"
    }

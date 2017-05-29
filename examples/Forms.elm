import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- Model

type alias Model =
  {
    name : String,
    password : String,
    passwordAgain : String
  }

model : Model
model =
  Model "" "" ""

-- Update
type Msg
  = Name String
  | Password String
  | PasswordAgain String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    Password password ->
      { model | password = password }
    PasswordAgain passwordAgain ->
      { model | passwordAgain = passwordAgain }

-- View
view : Model -> Html Msg
view model =
  div []
  [ input [ type_ "text", placeholder "Enter name", onInput Name ] []
  , input [ type_ "password", placeholder "Enter password", onInput Password ] []
  , input [ type_ "password", placeholder "Enter password again", onInput PasswordAgain ] []
  , viewValidation model
  ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password == model.passwordAgain then
        ("green", "OK")
      else
        ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text message ]

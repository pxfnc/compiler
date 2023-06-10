module MainTest exposing (suite)

import Expect
import Fuzz exposing (int, list)
import Main exposing (makeLazy, tcoMakeLazy)
import Test exposing (..)


suite : Test
suite =
    describe "Main"
        [ fuzz (list int) "makeLazy" <|
            \sample ->
                List.map (\f -> f ()) (makeLazy sample [])
                    |> Expect.equal sample
        , fuzz (list int) "tcoMakeLazy" <|
            \sample ->
                List.map (\f -> f ()) (tcoMakeLazy sample [])
                    |> Expect.equal sample
        ]

module Main exposing (main, makeLazy, tcoMakeLazy)

import Benchmark exposing (benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram, program)


makeLazy : List a -> List (() -> a) -> List (() -> a)
makeLazy list accum =
    case list of
        item :: items ->
            makeLazy items <| ((\_ -> item) :: accum)

        _ ->
            List.reverse accum


tcoMakeLazy : List a -> List (() -> a) -> List (() -> a)
tcoMakeLazy list accum =
    case list of
        item :: items ->
            tcoMakeLazy items ((\_ -> item) :: accum)

        _ ->
            List.reverse accum


main : BenchmarkProgram
main =
    program <|
        describe "Main"
            [ describe "tco"
                [ benchmark "goodOutput"
                    (\_ -> makeLazy [ 1, 2, 3 ] [] |> List.map (\f -> f ()))
                , benchmark "badOutput"
                    (\_ -> tcoMakeLazy [ 1, 2, 3 ] [] |> List.map (\f -> f ()))
                ]
            , benchmark "List.foldl (+) 0 (List.range 0 10000)"
                (\_ -> List.foldl (+) 0 (List.range 0 10000))
            ]

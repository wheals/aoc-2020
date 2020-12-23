import System.IO

data Operator = Multiply | Add deriving (Show)

data Form =
    Do Operator Form Form
  | Value Int
  deriving (Show)

parse :: String -> [Form] -> [Operator] -> (Form, String)
parse str (a:b:fs) (Add:xstack) = parse str (Do Add a b:fs) xstack

parse ('+':xs) f stack = parse xs f (Add:stack)
parse ('*':xs) (f:fs) stack = let (result, cont) = parse xs fs stack
                              in (Do Multiply f result, cont)

parse ('(':xs) f stack = let (result, cont) = parse xs [] []
                         in parse cont (result:f) stack
parse (')':xs) (f:[]) stack = (f, xs)
parse (' ':xs) f stack = parse xs f stack
parse [] (f:[]) stack = (f, [])

parse (num:xs) fs stack = parse xs ((Value (read [num])):fs) stack

parseWrapper :: String -> Form
parseWrapper text = fst (parse text [] [])

calc :: Form -> Int
calc (Do Add l r) = (calc l) + (calc r)
calc (Do Multiply l r) = (calc l) * (calc r)
calc (Value x) = x

main = do
    contents <- readFile "input.txt"
    let input = lines contents
    let answer = sum . map (calc . parseWrapper) $ input
    print answer
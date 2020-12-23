import System.IO

data Form =
    Add Form Form
  | Multiply Form Form
  | Value Int
  deriving (Show)

-- read backwards because left-associative.
-- this means that the meaning of parens is flipped too
parse :: String -> Maybe Form -> (Form, String)
parse (num:xs) Nothing | num `elem` ['0'..'9']
    = parse xs (Just (Value (read [num])))
parse ('+':xs) (Just f) = let (result, cont) = parse xs Nothing
                          in (Add f result, cont)
parse ('*':xs) (Just f) = let (result, cont) = parse xs Nothing
                          in (Multiply f result, cont)
parse (')':xs) Nothing = let (result, cont) = parse xs Nothing
                         in parse cont (Just result)
parse ('(':xs) (Just f) = (f, xs)
parse (' ':xs) f = parse xs f
parse [] (Just f) = (f, [])

parseWrapper :: String -> Form
parseWrapper text = fst (parse (reverse text) Nothing)

calc :: Form -> Int
calc (Add l r) = (calc l) + (calc r)
calc (Multiply l r) = (calc l) * (calc r)
calc (Value x) = x

main = do
    contents <- readFile "input.txt"
    let input = lines contents
    let answer = sum . map (calc . parseWrapper) $ input
    print answer
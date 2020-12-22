module IntQuartets =
struct
    type t = int * int * int * int
    let compare (x0,y0,z0,w0) (x1,y1,z1,w1) =
    match compare z0 z1 with
        0 -> (match compare x0 x1 with
              0 -> (match compare y0 y1 with
                    0 -> compare w0 w1
                    | c -> c)
              | c -> c)
        | c -> c
end

module Hyperspace = Set.Make(IntQuartets)
let input = open_in "input.txt" 
let rec read row data =
    try
        read (row + 1) (data |> Hyperspace.add_seq
                        (input_line input |> String.to_seqi |> Seq.filter_map (fun (index, c) -> if c = '#' then Some (index, row, 0, 0) else None)))
    with
        End_of_file
    -> data
let data = read 0 Hyperspace.empty

let dim = [-1; 0; 1]
let neighbors = List.init 81 (fun n -> (n mod 3 |> List.nth dim,
                                        n / 3 mod 3 |> List.nth dim,
                                        n / 9 mod 3 |> List.nth dim,
                                        n / 27 mod 3 |> List.nth dim))
                |> List.filter (function
                                | (0, 0, 0, 0) -> false
                                | _ -> true)
let adj (x, y, z, w) = neighbors |> List.map (fun (dx, dy, dz, dw) -> (x + dx, y + dy, z + dz, w + dw))
                    
let inactiveAdj pos data = adj pos |> List.filter (fun element -> Hyperspace.mem element data |> not)
let numActiveAdj pos data = adj pos |> List.filter (fun element -> Hyperspace.mem element data) |> List.length
let rec tick iter data =
    let becameActives = data |> Hyperspace.to_seq |> Seq.flat_map (fun e -> inactiveAdj e data |> List.to_seq) |> Hyperspace.of_seq |> Hyperspace.filter (fun e -> (numActiveAdj e data) = 3) in
    let remainActives = data |> Hyperspace.filter (fun e -> (numActiveAdj e data) = 2 || (numActiveAdj e data) = 3) in
    let newData = Hyperspace.union becameActives remainActives in
    match iter - 1 with
    | 0 -> newData
    | n -> tick n newData
    
let newData = data |> tick 6
let _ = Printf.printf "%d\n" (Hyperspace.cardinal newData)

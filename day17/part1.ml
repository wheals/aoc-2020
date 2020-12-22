module IntTriplets =
struct
    type t = int * int * int
    let compare (x0,y0,z0) (x1,y1,z1) =
    match compare z0 z1 with
        0 -> (match compare x0 x1 with
              0 -> compare y0 y1
              | c -> c)
        | c -> c
end

module Space = Set.Make(IntTriplets)
let input = open_in "input.txt" 
let rec read row data =
    try
        read (row + 1) (data |> Space.add_seq
                        (input_line input |> String.to_seqi |> Seq.filter_map (fun (index, c) -> if c = '#' then Some (index, row, 0) else None)))
    with
        End_of_file
    -> data
let data = read 0 Space.empty

let dim = [-1; 0; 1]
let neighbors = List.init 27 (fun n -> (n mod 3 |> List.nth dim,
                                        n / 3 mod 3 |> List.nth dim,
                                        n / 9 mod 3 |> List.nth dim))
                |> List.filter (function
                                | (0, 0, 0) -> false
                                | _ -> true)
let adj (x, y, z) = neighbors |> List.map (fun (dx, dy, dz) -> (x + dx, y + dy, z + dz))
                    
let inactiveAdj (x, y, z) data = adj (x, y, z) |> List.filter (fun element -> Space.mem element data |> not)
let numActiveAdj (x, y, z) data = adj (x, y, z) |> List.filter (fun element -> Space.mem element data) |> List.length

let rec tick iter data =
    let becameActives = data |> Space.to_seq |> Seq.flat_map (fun e -> inactiveAdj e data |> List.to_seq) |> Space.of_seq |> Space.filter (fun e -> (numActiveAdj e data) = 3) in
    let remainActives = data |> Space.filter (fun e -> (numActiveAdj e data) = 2 || (numActiveAdj e data) = 3) in
    let newData = Space.union becameActives remainActives in
    match iter - 1 with
    | 0 -> newData
    | n -> tick n newData
    
let newData = data |> tick 6
let _ = Printf.printf "%d\n" (Space.cardinal newData)


(* fold left *)
let rec myFoldl op acc lst =
  match lst with
  | [] -> acc
  | h :: t -> myFoldl op (op acc h) t



(* fold right *)
let rec myFoldr op acc lst =
  match lst with
  | [] -> acc
  | h :: t -> op h (myFoldr op acc t)



(* reverse (recursive version) *)
let rec myReverse acc lst =
  match lst with
  | [] -> acc
  | h :: t -> myReverse (h :: acc) t


(* reverse using fold *)
let myReverseFold lst =
  myFoldl (fun acc x -> x :: acc) [] lst


(* map (recursive version) *)
let rec myMap op lst =
  match lst with
  | [] -> []
  | h :: t -> (op h) :: myMap op t


(* map using fold *)
let myMapFold op lst =
  myFoldr (fun x acc -> (op x) :: acc) [] lst


(* filter (recursive version) *)
let rec myFilter guard lst =
  match lst with
  | [] -> []
  | h :: t ->
      if guard h then
        h :: myFilter guard t
      else
        myFilter guard t


(* filter using fold *)
let myFilterFold guard lst =
  myFoldr
    (fun x acc ->
      if guard x then x :: acc
      else acc)
    [] lst

type 'a linetree =
| Empty                      
| Covered                    
| LineTree of {              
    p: float;                
    left: 'a linetree;       
    right: 'a linetree;      
}

let shuffle lst =
  let nd = List.map (fun c -> (Random.bits (), c)) lst in
  let sond = List.sort compare nd in
  List.map snd sond

let rec insertLine tree (l, r) =
  (* ignore invalid or zero-length lines *)
  if l >= r then tree
  else
  match tree with
  | Covered ->
      (* already covered *)
      Covered

  | Empty ->
    
      LineTree {
        p = l;
        left = Empty;
        right = insertLine Empty (l, r);
      }

  | LineTree {p; left; right} ->
      (* if line lies completely left of pivot *)
      if r <= p then
        LineTree { p; left = insertLine left (l, r); right }

      (* if line lies completely right of pivot *)
      else if l >= p then
        LineTree { p; left; right = insertLine right (l, r) }

      (* if the line crosses the pivot, split it into two parts *)
      else
        LineTree {
          p;
          left = insertLine left (l, p);
          right = insertLine right (p, r);
        }

let rec sumLineTree ?(s=neg_infinity) ?(e=infinity) tree =
  match tree with
  | Empty ->
      (* no coverage in this region *)
      0.

  | Covered ->
      (* entire region is covered *)
      e -. s

  | LineTree {p; left; right} ->
      (* split interval at pivot and recursively sum *)
      let leftSum = sumLineTree ~s:s ~e:p left in
      let rightSum = sumLineTree ~s:p ~e:e right in
      leftSum +. rightSum

let lineCoverage lines =
  (* shuffle input for better performance *)
  let shuffled = shuffle lines in

  (* build tree by inserting each line *)
  let tree =
    List.fold_left insertLine Empty shuffled
  in
  (* compute total coverage *)
  sumLineTree tree
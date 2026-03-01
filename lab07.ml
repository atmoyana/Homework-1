let rec fib n =
  if n < 0 then
    raise (Invalid_argument "n must be non-negative")
  else if n = 0 then
    0
  else if n = 1 then
    1
  else
    fib (n - 1) + fib (n - 2)

(*fibonocci tail*)
let rec fibTail ?(a=0) ?(b=1) n =
  if n < 0 then
    raise (Invalid_argument "n must be non-negative")
  else if n = 0 then
    a
  else
    fibTail ~a:b ~b:(a + b) (n - 1)
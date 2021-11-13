
(def no-f $(map size@car@cdr)@keys)
(def n (drop 2 (scanl1' + (iota 20000))))
(println@nth (first-idx $(<= 500) (map $(foldl1' *)@$(map succ)@no-f@p-factors n)) n)

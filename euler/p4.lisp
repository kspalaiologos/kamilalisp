
(def n (map $(+ 100) (iota 900)))
(def tab (map to-string [* outer-prod n n]))
(def is-p? #(= #0 reverse))
(println@foldl1' max (map parse-num (filter is-p? tab)))

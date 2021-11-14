
(def n (:$(+ 100)@iota 900))
(def tab (:to-string@outer-prod * n n))
(def is-p? #(= #0 reverse))
(println@foldl1' max (:parse-num@filter is-p? tab))

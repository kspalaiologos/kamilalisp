
(def is-c? #(= #0 sum@$(map !)@$(encode 10)))
(println@sum@filter is-c? (range 3 45000))

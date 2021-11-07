(def divides $(= 0)@%)
(sum@filter #(| $(commute divides 5) $(commute divides 3)) (iota 1000))

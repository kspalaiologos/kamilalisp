(def divides #($(= 0) %))
(sum@filter (lambda (x) (| (divides x 5) (divides x 3))) (iota 1000))


(def is-p? #(= #0 reverse))
(defun cr (x) is-p?@$(encode x))
(filter #(& (cr 10) (cr 2)) (:odd-f@range 0 500000))


(def c (foldl1' + (:to-string@range 1 100000)))
(foldl1' * (index '(1000000 100000 10000 1000 100 10 1) c))


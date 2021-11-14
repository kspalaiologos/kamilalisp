
(def is-p? #(= #0 reverse))
(defun cr (x) is-p?@$(encode x))
(filter #(& (cr 10) (cr 2)) (:odd-f@range 0 500000))


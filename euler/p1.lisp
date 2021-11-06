(defun divides (x y) (0 = (% x y)))
(sum (map (lambda (x) (if (| (divides x 5) (divides x 3)) x 0)) (iota 1000)))


;; TODO: When the symbolic computation support is added, refactor.
;; Also, there's a problem with floating point accurancy if we move the `/ 6` somewhere else.
;; This needs fixing.

(defun sum-of-squares (k) [[[k * [k + 1]] * [[2 * k] + 1]] / 6])
(defun square-of-sum (k) [[[k * [k + 1]] / 2] ** 2])
(def diff #(- square-of-sum sum-of-squares))
(println (diff 100))

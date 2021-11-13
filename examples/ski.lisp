
;; SKI calculus implementation using KamilaLisp macros
(defmacro ski (x) (match x
    ((a b c) (S a b c) [(tie a c b c) / 2])
    ((a b)   (K a b)   a)
    ((a)     (I a)     a)
    ((a b)   (a b)     (tie (ski a) (ski b)))
    (x)
))

;; iterate /=  =>  fixed point
(def ski-red $(iterate /= ski))

;; an example expression
(println@ski-red '(S I I K))

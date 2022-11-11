
(def f (memo (lambda x (cond
    ((= x 1) 1)
    ((= 1 \mod x 2) (+ 1 \f \+ 1 \* 3 x))
    ((= 0 \mod x 2) (+ 1 \f \/ x 2))
))))

(def a \$:f \range 100000 1000000)

(= 837799 \+ 100000 \index-of (foldl1 max a) a)

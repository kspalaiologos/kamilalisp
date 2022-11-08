
(def m1 \ foldl + 0 \ filter (lambda (x) (or (= 0 \ mod x 5) (= 0 \ mod x 3))) (range 1 1000))
(def m2 \ foldl1 + \ ⍭ (λ (x) (∨ (= 0 \ mod x 5) (= 0 \ mod x 3))) (⍳ 1 1000))
(and (= 233168 m1) (= 233168 m2))


(def m1 \ foldl + 0 \ filter (lambda (x) (or (= 0 \ mod x 5) (= 0 \ mod x 3))) (range 1 1000))
(def m2 \ foldl1 + \ ⍭ (λ (x) (∨ (= 0 \ mod x 5) (= 0 \ mod x 3))) (⍳ 1 1000))
(def m3 \ foldl1 + \ ⍭ (λ x \ lift or \= 0 \^mod '(3 5) x) \⍳ 1 1000)
(def m4 \foldl1 + \⍭ [$(lift or) \= 0 \^mod '(3 5) #0] \⍳ 1 1000)
(lift and \= 233168 \tie m1 m2 m3 m4)

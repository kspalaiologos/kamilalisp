
(def data \regex-split (ucs '(10)) \file-get "aoc2021/3-1.in")
(def dl (size@car data))

(defun mcb (l b) (
    >= (* 2 \count (monad \= "1" \nth b x) l) \size l
))

(defun e2 (ibit lines fn) (
    if  (| (<= (size lines) 1) (> ibit dl))
        (poly 2 \:parse-num@str-explode@car lines)
        (e2 (succ ibit)
            (filter (monad \/= (nth ibit x) \to-string@fn lines ibit) lines)
            fn)))

(println \*^$(e2 0 data) mcb ~@mcb)

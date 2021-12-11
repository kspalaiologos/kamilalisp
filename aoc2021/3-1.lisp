
(defun l-t (list) (:(monad \:$(nth x) list) \iota@size@car list))

(def data \:str-explode \regex-split (ucs '(10)) \file-get "aoc2021/3-1.in")
(def avgs (map $(<= 0.5)@avg@:parse-num \l-t data))
(println@#(*^$(poly 2) #0 :~) avgs)
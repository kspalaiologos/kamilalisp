
(def data \regex-split (ucs '(10)) \file-get "aoc2021/2-1.in")
(def x \map parse-num@car@str-explode@reverse data)
(def dir \index-of (str-join@:car@:str-explode data) "ufd")
(def aim \scanl1' + \:* x \:pred dir)
(def fwd \:$(= 1) dir)
(println@*^$(sum@:* fwd) x \:* aim x)

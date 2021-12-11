
(def data (regex-split (ucs '(10)) \file-get "aoc2021/2-1.in"))

(def dirs (index (index-of (str-join@:car@:str-explode data) "fdu") '(1 0J1 0J-1)))
(def mag (map parse-num@car@str-explode@reverse data))
(println@prod@:#(tie re im) [+ inner-prod * mag dirs])


(def data (regex-match "[0-9]+" (file-get "aoc2021/1-1.in") #(parse-num@car #2)))
(println@sum@n-foldl1' 2 < data)

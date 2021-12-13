
(def data \regex-split (ucs '(10)) \file-get "aoc2021/4-1.in")

;; Guesses and boards
(def d1 \:parse-num@str-split (car data) ",")
(def d2 \::(#0 :parse-num@$(str-split _ " +")@str-trim) \#(:cdr@partition :$(= "") #0) data)

;; List transposition, check if a board is winning, mark numbers on a board.
(defun l-t (list) \:(monad \:$(nth x) list) \iota@size@car list)
(defun f-s (board) \any@flatten@#(tie^:$(= \take (size board) 1) #0 l-t) board)
(defun m-n (board nums) \/ (:$(/= -1)@index-of (flatten board) nums) (size board))

(let-seq
    ;; Find all solutions, identify the winning index, compute the score.
    (def solutions \:(monad \first $(f-s@m-n x) \prefixes d1) d2)
    (def wi \#(car@index-of tie@$(foldl1 max) #0) \:size solutions)
    (def ws \nth wi solutions) (def wb \nth wi d2)
    \println@* (sum@flatten@:replicate (::~@m-n wb ws) wb) \car@reverse ws
)



;; A bunch of utility functions implemented in KamilaLisp itself.
;; They're easier to the eyes than Java code.

;; Abbreviations for some folding functions
(def sum (bind foldl' + 0))
(def cumsum (bind scanl' + 0))
(def prod (bind foldl' * 1))
(def cumprod (bind scanl' * 1))
(def maxl (bind foldl' max -1E100))
(def minl (bind foldl' min 1E100))
(def cummax (bind scanl1' max))
(def cummin (bind scanl1' min))

;; General utilities.
(def succ $(+ 1))
(def pred $(- _ 1))
(def bounds #(tie minl maxl))
(def hypot sqrt@sum@:$(** _ 2)@tie)

;; Sequence generators.
(defun aseq (a0 r) \lambda (n) \+ a0 \* r n)
(defun gseq (a0 q) \lambda (n) \* a0 \** q n)

;; Euler's totient.
(defun totient (x) (let ((y (p-factors x))) (prod (map - y (unique-mask y)))))

;; Most frequent value in array.
(def mode cadr@car@reverse@sort@:$(lift #(tie size@#1 #0))@keys)

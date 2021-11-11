
(def fib (memo (monad (seq (
    if [x < 2]
        x
        [(fib [x - 1]) + (fib [x - 2])])))))

; Alternative iterative solution if consecutive fibonacci numbers
; weren't desired:

; (defun fib4 (n) (nth 0 (
;     iterate n (lambda (x) (
;         tie (nth 1 x) [(nth 0 x) + (nth 1 x)])) '(0 1))))

(println@sum@filter #(& ~@$(% _ 2) $(> 4000000)) (map fib (iota 40)))

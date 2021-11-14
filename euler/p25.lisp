
(def fib (memo (monad (seq (
    if [x < 2]
        x
        [(fib [x - 1]) + (fib [x - 2])])))))

(def fm [10 ** 999])
(println@first-idx $(< fm) ($(map fib)@iota 10000))

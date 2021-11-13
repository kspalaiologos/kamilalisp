
(def f (memo (monad (cond
    ([x = 1] 1)
    ([1 = [x % 2]] (succ@f [[3 * x] + 1]))
    ([0 = [x % 2]] (succ@f [x / 2]))
))))

(def a (map f (range 1 999999)))
(println@$(map succ)@index-of (tie@foldl1' max a) a)

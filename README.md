
<p align="center">
  <img src="https://github.com/kspalaiologos/kamilalisp/raw/main/doc/logo.png">
</p>


# KamilaLisp

A lazily evaluated, functional, flexible and concise Lisp modelled after Haskell and APL, among others.

```lisp
;; Hello, world!
(println "Hello, world!")

;; ProjectEuler, problem 4.
(def n (:$(+ 100)@iota 900))
(def tab (:to-string@outer-prod * n n))
(def is-p? #(= #0 reverse))
(println@foldl1' max (:parse-num@filter is-p? tab))

;; ProjectEuler, problem 2.
(println@sum@filter #(& ~@$(% _ 2) $(> 4000000)) (:fib@iota 40))


;; SKI calculus implementation using KamilaLisp macros and pattern matching.
(defmacro ski (x) (match x
    ((a b c) (S a b c) [(tie a c b c) / 2])
    ((a b)   (K a b)   a)
    ((a)     (I a)     a)
    ((a b)   (a b)     (tie (ski a) (ski b)))
    (x)
))

(def ski-red $(iterate /= ski))

;; an example expression
(println@ski-red '(S I I K))
```

Useful links:

- **[Learn me!](doc)**
- **[Channel on the /r/PL Discord server](https://discord.gg/xr5VapADw7)**
- **[My Discord server](https://discord.gg/m4Wcenn)**

## Setup

```
git clone https://github.com/kspalaiologos/kamilalisp
cd kamilalisp && make CXX=clang++ target=release -j4 all
```

Alternatively, use `CXX=g++`, `target=debug` or omit the target field altogether. Adjust the amount of `make` workers to the amount of logical cores you system has, for optimal build times.

## Dependencies

KamilaLisp is written in C++ and it depends on the following libraries:

* libreadline
* boost
* mpfr
* gmp
* re/flex (fetched automatically by `make get-deps`)

## License

KamilaLisp is distributed under the GNU General Public License v3. See [LICENSE](https://github.com/kspalaiologos/kamilalisp/blob/main/LICENSE) for details.

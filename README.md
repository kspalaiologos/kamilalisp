
# KamilaLisp

A lazily evaluated, functional, flexible and concise Lisp modelled after Haskell and APL, among others.

```lisp
;; Hello, world!
(println "Hello, world!")

;; ProjectEuler, problem 4.
(def n (map $(+ 100) (iota 900)))
(def tab (map to-string [* outer-prod n n]))
(def is-p? #(= #0 reverse))
(println@foldl1' max (map parse-num (filter is-p? tab)))

;; ProjectEuler, problem 2.
(def fib (memo (monad (seq (
    if [x < 2]
        x
        [(fib [x - 1]) + (fib [x - 2])])))))

(println@sum@filter #(& ~@$(% _ 2) $(> 4000000)) (map fib (iota 40)))
```

**[Learn me!](doc)**

## Setup

```
git clone https://github.com/kspalaiologos/kamilalisp
```

Load the `kamilalisp.iml` project into IntelliJ IDEA. Building the project should also rebuild the artifacts, meaning that the jar file will be placed in `out/artifacts/kamilalisp_jar/`.

## Dependencies

KamilaLisp runs on the Java virtual machine and doesn't have native dependencies. It depends on the following major Java libraries:

* Google Guava
* ANTLR4 runtime
* JLine

## License

KamilaLisp is distributed under the GNU General Public License v3. See [LICENSE](https://github.com/kspalaiologos/kamilalisp/blob/main/LICENSE) for details.

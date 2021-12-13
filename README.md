
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
```

Load the `kamilalisp.iml` project into IntelliJ IDEA. Building the project should also rebuild the artifacts, meaning that the jar file will be placed in `out/artifacts/kamilalisp_jar/`.

## Dependencies

KamilaLisp runs on the Java virtual machine and doesn't have native dependencies. It depends on the following major Java libraries:

* Google Guava
* ANTLR4 runtime
* JLine

## License

KamilaLisp is distributed under the GNU General Public License v3. See [LICENSE](https://github.com/kspalaiologos/kamilalisp/blob/main/LICENSE) for details.

## Reviews

> kamilalisp is literally apl but like it if the →→→ where multiple

---

> when the lisp eeemmmhh
>
> mhhmm when, the
> 
> when the m

---

> when you are lisp coding but girl and girl

---

> o the logo is nice

---

> kmalia is a cool name

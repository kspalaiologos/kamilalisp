
<p align="center">
  <img src="https://github.com/kspalaiologos/kamilalisp/raw/v0.2/logo.png">
</p>


# KamilaLisp Two: Electric Boogaloo

[![codecov](https://codecov.io/gh/kspalaiologos/kamilalisp/branch/v0.2/graph/badge.svg?token=V9D86RYQO8)](https://codecov.io/gh/kspalaiologos/kamilalisp) [![Java CI with Maven](https://github.com/kspalaiologos/kamilalisp/actions/workflows/maven.yml/badge.svg)](https://github.com/kspalaiologos/kamilalisp/actions/workflows/maven.yml)

A functional, flexible and concise Lisp inspired by Haskell and APL, among others. A ground-up rewrite.

Useful links:

- A public read-only channel to track the development of KamilaLisp: `#kamilalisp:coven.palaiologos.rocks`

## Setup

You need Java17 JDK installed to build KamilaLisp yourself. Alternatively, you could download a JAR file from the Github Actions artifacts tab.

```
git clone https://github.com/kspalaiologos/kamilalisp
cd kamilalisp
mvn package
```

## Examples

SKI calculus:
```lisp
; SKI calculus
(defun SKI x
   (match x
      ((((S 'x) 'y) 'z) (tie (tie x z) (tie y z)))
      (((K 'x) 'y) x)
      ((I 'x) x)
      (('x 'y) (tie (SKI x) (SKI y)))
      ('x x)))

converge SKI '(((S I) I) K)
```

List operations and point-free programming:
```lisp
; Take numbers from 0 to 9999, sum the resulting list and its reverse,
; then take the amount of unique items, and verify if it equals one.
= 1 \⍴∘⊙∘[+ #0 ⌽] \⍳ 10000

; In Haskell:
; (==1) . length . nub $ zipWith (+) <$> id <*> reverse $ [0..10000]

; In APL:
; 1=⍴∪(⊢+⌽)⍳10000
```

Command-line tools:
```
% cat script.lisp
(def a \io:get-file-buffer \car args)
(if (= (tally a) 0)
    (let-seq
        (io:writeln \str:format "Shannon Entropy: 0")
        (exit 0))
    '())
(def b
    \:[tie car $(+ 1)@tally@car@cdr]
        \list:group a)
(def b b$[grade-up \car%[1] b])
(def c \ln \foldl1 max \:car@:cdr b)
(def b \:car@:cdr
    \:(lambda x
        (tie (car x) (floor \* 30 \ / (ln \car \cdr x) c))) b)
(def d \filter $(foldl or 0)
    \reverse@matrix:transpose
        \:(lambda x (take 30 \cycle x '(1))) b)
(:io:writeln@:(lambda x " ⎕"$[#0 x]) d)
(io:writeln \str:format "Shannon Entropy: {shannon-entropy a}")
% java -jar target/kamilalisp-0.2.jar script.lisp LICENSE
[ histogram omitted ... ]
Shannon Entropy: 4.57328272673034
```

## License

KamilaLisp is distributed under the GNU General Public License v3. See [LICENSE](https://github.com/kspalaiologos/kamilalisp/v0.2/main/LICENSE) for details.

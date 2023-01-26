
<p align="center">
  <img src="https://github.com/kspalaiologos/kamilalisp/raw/v0.2/doc/logo.png">
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

## License

KamilaLisp is distributed under the GNU General Public License v3. See [LICENSE](https://github.com/kspalaiologos/kamilalisp/v0.2/main/LICENSE) for details.

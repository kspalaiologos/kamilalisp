
<p align="center">
  <img src="https://github.com/kspalaiologos/kamilalisp/raw/v0.2/logo.png">
</p>


# KamilaLisp Two: Electric Boogaloo

[![codecov](https://codecov.io/gh/kspalaiologos/kamilalisp/branch/v0.2/graph/badge.svg?token=V9D86RYQO8)](https://codecov.io/gh/kspalaiologos/kamilalisp) [![Java CI with Maven](https://github.com/kspalaiologos/kamilalisp/actions/workflows/maven.yml/badge.svg)](https://github.com/kspalaiologos/kamilalisp/actions/workflows/maven.yml)
![WakaTime](https://wakatime.com/badge/user/c3a8c589-783c-4ab2-be05-93fa48bc9a94/project/1c00d725-551f-46d2-a691-1408603a8707.svg)
![GitHub](https://img.shields.io/github/license/kspalaiologos/kamilalisp)
<span class="badge-patreon"><a href="https://patreon.com/kspalaiologos" title="Donate to this project using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a></span>

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

## Features

KamilaLisp allows for actor programming, concurrent programming, imperative programming, functional programming, array programming, pure functional programming, object-oriented programming, rudimentary logic programming, mathematical programming, backend development, numerical computation, system administration, symbolic computation (real and complex analysis) and event-driven programming. In more detail:

- Arbitrary precision complex, integer and decimal arithmetic.
- A fully-featured, remote IDE capable of communicating with KamilaLisp instances over the network. Supports multiple workspaces, contains an implementation of a hybrid tiling/floating window manager and editors.
- Many mathematical functions (bernoulli, gamma, trigonometry, arcus functions, hyperbolic functions, inverse hyperbolic functions, FFT, IFFT)
- Bit operations
- Number theoretic, combinatoric and linear algebraic functions (permutations, Levi-Civita, etc...)
- Functional higher order functions (fold, scan, all, none, some, converge, takewhile, dropwhile)
- Functional parallelism (parallel map and filter)
- Mu-recursive functions (SML projections, mu-recursive substitution operator).
- Prototype-based object orientation.
- No memory side effects, all collections are persistent.
- Possibilities of writing code in pure functional paradigm.
- Suffix array and Burrows-Wheeler transform construction.
- APL-style array processing (grade-up, grade-down, find, range, where, encode, decode, replicate, etc...).
- APL-style symbols for common operations.
- Set operations.
- Read/write support for JSON, CSV, XML, Base64, XZ, gzip, lz4, bzip2, tar and zip.
- Date and time manipulations.
- Persistent hashmaps, reactive hashmap literals.
- PNG, BMP, JPG and JPEG image I/O.
- File I/O (read, write, append).
- Basic matrix operations (LU decomposition, transpose, trace, matrix multiplication easily implemented as `$(foldl + 0)%[1] \outer-product * A \matrix:transpose A`.
- Performance benchmarks to measure GC time, average, median and standard deviation between runs of various expressions.
- Module system.
- Pattern matching.
- Memoization.
- Imperative programming support.
- Networking (`net:fetch`, `net:wget`).
- Sockets (`net:client`, `net:server` and their SSL counterparts).
- Parallel processing using the actor model (daemon threads, task threads, message passing paradigm).
- Regular expressions.
- KamilaLisp as a shell (implementations of `sh:ls`, `sh:glob`, `sh:mv`, `sh:basename`, etc... - all usable from the REPL and from code, as they return plain data structures).
- String functions (Shannon entropy, unicode handling, byte buffers, levenshtein distance, string interpolation/formatting)
- On-The-Fly Lexical scanner generation.
- Function compositions, partial application, variadic functions, static scoping.
- Tail call optimisation.
- Limits, complex limits.
- Indefinite integrals.
- Differentiation
- Polynomial factoring.
- Laurent, Taylor, MacLaurin and Puiseux series expansion.
- Functional de Bruijn indices.
- Possibility to write standalone non-interactive scripts.
- Machine word operations (flt64:...) - Bessel functions, Hurwitz Zeta, Riemann Zeta, Upper/Lower Incomplete Gamma, Gamma, LogGamma, Pochhammer symbol, erf, erfc, Inverse erf, Inverse erfc, Digamma, Trigamma, Polygamma, Airy Ai, Bessel I, J, K and Y functions, Lerch Phi, Spence's function and Polylogarithm.
- Prompt styling.
- Portable.

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

## Lisp Roadmap

- MalbolgeLISP v1.0-v1.2 - initial prototypes.
- KamilaLisp v0.1 - initial Java prototype, concept exploration.
- KamilaLisp v0.2 - design solidifying, API documentation.
- KamilaLisp v0.3 - a compiler and bytecode virtual machine.

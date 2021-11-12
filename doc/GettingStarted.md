
## Tutorial - Getting started

After downloading and building KamilaLisp, running the jar file (`java -jar kamilalisp.jar`) without any arguments will start it in an interactive mode.

```
KamilaLisp v 0.1 - Copyright (C) Kamila Szewczyk, 2021.
Interactive mode.

-->
```

You can try out some example expressions:

```
(+ 2 2)
(* 3 2)
(/ 1 3)  ; What is the precision :)?
```

KamilaLisp introduces a new bracket style - `[a f b c]` is equivalent to `(f a b c)`, so the above examples could be rewritten as:

```
[2 + 2]
[3 * 2]
[1 / 3]
```

## Interactive programs

Basic interaction with the user can be accomplished using a few functions, as demonstrated below:

```
--> (println ["Hello, " + (prompt-str "What's your name? ")])
What's your name? Kamila
Hello, Kamila

--> (println ["a + b = " + [(prompt "a = ") + (prompt "b = ")]])
a = 3J4
b = 1J-5
a + b = 4J-1
```

Note: `J` denotes complex numbers. For example, `5J5` is `5 + 5i`, while `2.5J-1` is `2.5 - i`.

## Functions and variables

Generally, names in KamilaLisp are bound using `def`, `defun`, `defmacro` or `let`. Because the REPL evaluates everything to display the result, it might not be desired. For this reason, `(discard (def x ...))` is a somewhat commonly used idiom.

```
--> (def a 5)
5
--> (discard (def b 6))
()
--> (+ a b)
11
--> (defun square (x) [x * x])
(λ x . (* x x))
--> (square 5)
25
--> ; defun is equivalent to...
--> (def square (lambda (x) [x * x]))
(λ x . (* x x))
--> (square 6)
36
--> ; the same function could also be written with neither!
--> (def square #(* #0 #0))
callable/syn
--> (square 5)
25
```

## Function composition and partial application

The current topic is the cream of the crop of functional programming. Let's see how to do it in KamilaLisp.

```
--> (defun f (x) [x + 5])
(λ x . (+ x 5))
--> (defun g (x) [3 * x])
(λ x . (* 3 x))
--> (f (g 5))
20
--> (g (f 5))
30
```

We can define function composition as two-element forks:

```
--> (def f-over-g #(f g))
callable/syn
--> (def g-over-f #(g f))
callable/syn
--> (f-over-g 5)
20
--> (g-over-f 5)
30
```

The question arises - how do more than two-element forks work? Let's unpack these two examples:

```
--> (def is-p? #(= #0 reverse))
callable/syn
--> (is-p? "kajak")
1
--> (is-p? "anne")
0
--> (def avg #(/ sum size))
callable/syn
--> (avg '(1 2 3 4))
2.5
```

For a fork `#(f g h)`, the arguments to it are preprocessed by `g` and `h` before calling the `f` functions on the results this yields. Consequently, `f` must be a dyadic function in this case (the arity is `n-1` where `n` is the amount of members of a fork), while `g` and `h`'s varity depends passed on the arguments to the fork. Simply put, `(#(f g h) ...)` is equivelent to `(f (g ...) (h ...))`.

There is a different, much nicer option - using `@`:

```
--> (def f-over-g f@g)
callable/syn
--> (f-over-g 5)
20
--> (g@f 5)
30
```

`@` lets you stack arbitrary amounts of arbitrary functions, what will be demonstrated later on.

Let's think of a different but related concept - partial application:

```
--> (def add5 $(+ 5))
callable/syn
--> (add5 5)
10
```

Generally speaking, `$(f ...)` is an abbreviation / syntactic sugar over `(bind f ...)`.

A function that takes the reciprocal of and negates it's input, and then adds 5 to it would be defined as follows:

```
--> (def f $(+ 5)@-@/)
callable/syn
--> (f 6)
4.8333333333333333333333333333333333
```

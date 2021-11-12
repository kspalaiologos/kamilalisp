
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

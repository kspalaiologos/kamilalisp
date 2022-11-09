
# KamilaLisp Syntax Reference

## S-expressions

KamilaLisp implements two kinds of S-expressions:

```lisp
(a b c d ...)
```

and

```lisp
[a b c d ...]
```

The first kind of S-expression (enclosed in parentheses) is the standard Lisp S-expression - a function application.
The KamilaLisp REPL automatically adds parentheses around the code that you enter in the REPL. This behaviour can be disabled by prepending a `?` to your expression (usually used to query for the value of a particular variable).
A few example function applications:

```
--> range 1 10
(1 2 3 4 5 6 7 8 9)

--> reverse (range 1 10)
(9 8 7 6 5 4 3 2 1)
```

Notice that the nesting of parentheses with usual S-expressions tends to be rather deep in complicated expressions. Define a function `f(x) = 2 * (x + 3)`:

```
--> def f (lambda x (* 2 (+ x 3)))
(λ x . (* 2 (+ x 3)))
```

Using the backslash syntax, we can partition the list and omit the parentheses.

```
--> def f \lambda x \* 2 \+ x 3
(λ x . (* 2 (+ x 3)))
```

The backslash opens a new parenthesis implicitly, and closes it when it stumbles upon the next closing parenthesis. For example:

```
(a b \ c d \ e f) = (a b (c d (e f)))
```

You might know a similar mechanism from TI-BASIC, which automatically closed parenthesis for the user as a convenience feature. The backslash syntax is a _generalisation_ of this concept.

The other kind of S-expression mentioned is denoted using brackets - e.g. `[a b c]`. In APL, this construction would be called something similar to a so-called _tacit fork_, however, in KamilaLisp this kind of construction is a multivariate generalisation of this concept. Let's look at a worked example.

When taking measurements, it's common to specify an error margin, for example `23cm +/- 5cm`. Let's write a function that returns the range in which the value must lie accounting for the error.

```
--> [tie - +] 23 5
(18 28)
```

In this specific example, `[a b c] x... = (a (b x...) (c x...))`, so `[tie - +] 23 5 = (tie (- 23 5) (+ 23 5))`. The partitioning rules also apply to the bracket S-expressions. Additionally, a bracket S-expression may contain more than three elements - `[a b c d] x... = (a (b x...) (c x...) (d x...))`.

## Tacks

Tacks are particularly useful when implementing point-free functions. They're an analogue of the mu-recursive choose function.

```lisp
--> #0 1 2 3
1
--> #1 1 2 3
2
```

A tack (`#N`) returns the N-th element of its argument list. A tack can also be represented by a range:

```lisp
--> 2#4 0 9 0 7 2 0 0 4
(0 7)
```

## Over

Over is a syntactic feature that reverses the order of an arbitrart amount of arguments to a function. For example:

```
--> - 1 2
-1
--> ^- 1 2
1
```

## Quoting

If you wanted to add two lists, for example `(1 2 3)` and `(4 5 6)`, you might stumble upon this problem:

```
--> + (1 2 3) (4 5 6)
TypeError thrown in thread 79ad8b2f: Cannot call non-callable atom
    at entity +  1:1
    at entity 1  1:4
```

The error clearly tells us that the interpreter tries to call `1`, which isn't even a function. No good. This can be prevented using quoting, that can "resist" a layer of evaluation:

```
--> + '(1 2 3) '(4 5 6)
(5 7 9)
```

## Function composition

To Be Documented

## Partial application

To Be Documented

## Mapping

To Be Documented

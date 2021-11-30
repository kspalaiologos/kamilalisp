
## Language Reference - Outline of syntax and semantics

KamilaLisp syntax generally mimics Lisp, although some syntactic sugar has been sprinkled on top of it to make programming a bit more convenient and the code more readable.

Simply put, everything is an atom. An atom can be a:
* Matrix
* List
* Decimal or complex number
* String
* Identifier (bound / unbound)
* Closure
* Macro

During the parsing phase, syntactic sugar is expanded to it's proper list forms. For example, `#(a b c)` becomes `(fork a b c)`.

It is not possible to define matrix constants directly in KamilaLisp - this has to be done using nested lists and `mat-mix`, or a flat list combined with `reshape`. Lists are defined using `(...)` or `[...]`. The `[...]` syntax maps to the `(...)` syntax during the parse time like so:

```
[a] => (a)
[a b] => (b a)
[a b c] => (b a c)
[a b c d] => (b a c d)
...
```

Additionally, `nil` is a shorthand for an empty list - `'()`.

Decimal numbers use a dot to signify the fractional part (`.`) and support the scientific notation. Complex numbers use `J` as the real/imaginary separator. For example:

```
0J0     =>  0
1J0     =>  1
0J1     =>  i
-3J2    =>  -3 + 2i
5J-1    =>  5 - i
3.5J-2  =>  3.5 - 2i
```

Strings are denoted by double quotes. A double quote character can be escaped to allow it inside strings, but no other escape sequences are recognised. Closures are introduced using `lambda`, while macros are introduced using `macro`. They aren't bound to a name by default, hence they're often coupled with `def` or `defmacro`/`defun`.

Closures and macros can take optional arguments, which names are prepended with `?`.

## Syntactic sugar

The following conversions are performed:
- `$(...)` - partial application; `(bind ...)`
- `a@b@...` - ad-hoc function composition; `(atop a b ...)`
- `#(...)` - forks; `(fork ...)`
- `:a` - map; `$(map a)` = `(bind map a)`

`:a` is recognised before `a@b@...`. To map a composite function, use `:(id a@b@...)`. For example:

```
--> (:(id id@iota) '(1 2 3))
((0) (0 1) (0 1 2))
```

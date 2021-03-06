
## Language Reference - Built-in functions

### `(odd-f x)`

Returns an odd number associated with x. Equivalent to `succ@$(* 2)`.

### `(even-f x)`

Returns an even number associated with x. Equivalent to `$(* 2)`.

### `(pi ?x)`

Returns `pi` computed to a given precision. If not specified, the precision of `fr` is assumed.

### `(e ?x)`

Returns `e` (the Euler's constant) computed to a given precision. If not specified, the precision of `fr` is assumed.

### `fr`

A constant representing the current floating point representation (a.k.a. precision). Can be altered using `let` or `def` so that computations are performed more or less precisely (a tradeoff between precision and speed).

### `(p-no x)`

Returns `x` first prime numbers. `#(= size@p-no #0)` is always true.

### `(prod x)`

Returns the product of list `x`. The product of an empty list is 1. Equivalent to `(foldl' * 1 x)`.

### `(sum x)`

Returns the sum of list `x`. The product of an empty list is 0. Equivalent to `(foldl' + 0 x)`.

### `(p-factors x)`

Returns the list of prime factors of `x`. Uses the Pollard Rho algorithm. For example:

```
--> (def a (:succ@rng-deal 10 10))
(6 2 5 8 7 4 6 4 1 3)
--> (prod a)
967680
--> (p-factors@prod a)
(2 2 2 2 2 2 2 2 2 2 7 3 3 3 5)
```

### `(succ x)`

Returns the successor of x. Equivalent to `(+ x 1)`.

### `(pred x)`

Returns the predecessor of x. Equivalent to `(- x 1)`.

### `(totient x)`

Return the Euler's totient value for x.

For a prime number `p`, returns `p - 1`. For a composite number, returns the product of the predecessors of its prime factors.

The algorithm KamilaLisp implements is different and equivalent to the following:

```lisp
(defun totient (x) (let (\y \p-factors x) (prod \map - y \unique-mask y)))
```

### `(digamma z)`

Return the value of `digamma(z)` for any given `z`. Approximation for smaller numbers (`z < 100`) is performed using the following formula:

![\ln(z) - \frac{1}{2z}](digamma-f1.png)

For `z > 100`, the Euler-MacLaurin formula is used to ease out the difference between the Dirchlet integral form and a closely related to it sum. From:

![\sum_{n=1}^{\infty} \frac{1}{n} - \frac{1}{z+n}](digamma-f2.png)

we can derive that the final formula is:

![\varphi(z) = \ln(z) - \frac{1}{2z} + \sum_{n=1}^{\infty} \frac{\zeta(1-2n)}{z^{2n}} = \ln(z) - \frac{1}{2z} - \sum_{n=1}^{\infty} \frac{B_{2n}}{2nz^{2n}}](digamma-f3.png)

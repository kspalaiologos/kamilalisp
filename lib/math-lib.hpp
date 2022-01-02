
#ifndef _MATH_LIB_HPP
#define _MATH_LIB_HPP

#include "../atom.hpp"
#include "../env.hpp"
#include "../list.hpp"

namespace mathlib {

define_callable(add);
define_callable(subtract);
define_callable(multiply);
define_callable(divide);
define_callable(divide_int);
define_callable(modulus);
define_callable(sqrt);
define_callable(power);
define_callable(nthroot);
define_callable(iota);

define_callable(equals);
define_callable(not_equals);

define_callable(less_than);
define_callable(greater_than);
define_callable(less_equal);
define_callable(greater_equal);

define_callable(kl_or);
define_callable(kl_and);
define_callable(kl_xor);

define_callable(kl_floor);
define_callable(kl_ceil);

define_callable(kl_gcd);
define_callable(kl_lcm);

define_callable(kl_bernoulli);
define_callable(kl_digamma);
define_callable(kl_lambert0);

define_callable(kl_pi);
define_callable(kl_e);

}

#endif


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

define_callable(kl_sin);
define_callable(kl_cos);
define_callable(kl_tan);
define_callable(kl_cot);
define_callable(kl_sec);
define_callable(kl_csc);

define_callable(kl_arcsin);
define_callable(kl_arccos);
define_callable(kl_arctan);
define_callable(kl_arccot);
define_callable(kl_arcsec);
define_callable(kl_arccsc);

define_callable(kl_sinh);
define_callable(kl_cosh);
define_callable(kl_tanh);
define_callable(kl_coth);
define_callable(kl_sech);
define_callable(kl_csch);

define_callable(kl_arcsinh);
define_callable(kl_arccosh);
define_callable(kl_arctanh);
define_callable(kl_arccoth);
define_callable(kl_arcsech);
define_callable(kl_arccsch);

}

#endif

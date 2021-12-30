
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
define_callable(modulus);
define_callable(sqrt);
define_callable(power);
define_callable(nthroot);
define_callable(iota);

define_callable(equals);
define_callable(not_equals);

define_callable(less_than);

}

#endif

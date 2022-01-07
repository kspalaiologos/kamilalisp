
#ifndef _COMBINATORICS_LIB_HPP
#define _COMBINATORICS_LIB_HPP

#include "../atom.hpp"
#include "../env.hpp"
#include "../list.hpp"

namespace combinatoricslib {

define_callable(factorial);
define_callable(gamma);

define_callable(pmat);
define_callable(cmat);
define_callable(binomial);

define_callable(pochhammer_plus);
define_callable(pochhammer_minus);

}

#endif

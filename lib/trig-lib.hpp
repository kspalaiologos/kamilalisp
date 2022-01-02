
#ifndef _TRIG_LIB_HPP
#define _TRIG_LIB_HPP

#include "../atom.hpp"
#include "../env.hpp"
#include "../list.hpp"

namespace triglib {

define_callable(kl_pi);
define_callable(kl_e);
define_callable(euler_gamma);
define_callable(catalan);

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


#ifndef __CORE_LIB_HPP
#define __CORE_LIB_HPP

#include "../atom.hpp"
#include "../env.hpp"
#include "../list.hpp"

namespace corelib {

define_callable(quote);
define_callable(define);
define_callable(lambda);
define_callable(macro);

}

#endif

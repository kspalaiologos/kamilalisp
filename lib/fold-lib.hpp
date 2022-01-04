
#ifndef _FOLD_LIB_HPP
#define _FOLD_LIB_HPP

#include "../atom.hpp"
#include "../env.hpp"
#include "../list.hpp"

namespace foldlib {

define_callable(foldl);
define_callable(foldr);
define_callable(foldl1);
define_callable(foldr1);

define_callable(scanl);
define_callable(scanr);
define_callable(scanl1);
define_callable(scanr1);

}

#endif

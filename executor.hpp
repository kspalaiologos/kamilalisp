
#ifndef _EXECUTOR_HPP
#define _EXECUTOR_HPP

#include "env.hpp"
#include "atom.hpp"

#include <string>

atom evaluate(atom, std::shared_ptr<environment>);

#endif

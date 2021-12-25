
#ifndef __ERROR_HPP
#define __ERROR_HPP

#include <exception>

#define __stringify(msg) #msg
#define __stringify_cpp_sucks(msg) __stringify(msg)
#define location \
    std::string(__FILE__ ":" __stringify_cpp_sucks(__LINE__) " - ")
#define kl_error(msg) \
    throw std::runtime_error(location + (msg))
#define kl_recoverable_error(msg) \
    throw std::domain_error(location + (msg))

#endif

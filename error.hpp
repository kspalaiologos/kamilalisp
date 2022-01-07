
#ifndef __ERROR_HPP
#define __ERROR_HPP

#include <exception>
#include <string>
#include <stdexcept>

// Not using std::source_location because it's not available on all
// reasonably modern compilers.

#define __stringify(msg) #msg
#define __stringify_cpp_sucks(msg) __stringify(msg)
#define src_location \
    std::string(__FILE__ ":" __stringify_cpp_sucks(__LINE__) " - ")

#define kl_error(msg) \
    throw std::runtime_error(src_location + (msg))
#define kl_recoverable_error(msg) \
    throw std::domain_error(src_location + (msg))

#endif

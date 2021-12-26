
#ifndef __ERROR_HPP
#define __ERROR_HPP

#include <exception>
#include <string>
#include <stdexcept>

#include <boost/stacktrace.hpp>
#include <boost/exception/all.hpp>

typedef boost::error_info<struct tag_stacktrace, boost::stacktrace::stacktrace> traced;

template <class E>
[[noreturn]] static inline void throw_with_trace(const E & e) {
    throw boost::enable_error_info(e)
        << traced(boost::stacktrace::stacktrace());
}

// Not using std::source_location because it's not available on all
// reasonably modern compilers.

#define __stringify(msg) #msg
#define __stringify_cpp_sucks(msg) __stringify(msg)
#define location \
    std::string(__FILE__ ":" __stringify_cpp_sucks(__LINE__) " - ")

#define kl_error(msg) \
    throw_with_trace(std::runtime_error(location + (msg)))
#define kl_recoverable_error(msg) \
    throw_with_trace(std::domain_error(location + (msg)))

#endif

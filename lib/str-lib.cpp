
#include "str-lib.hpp"
#include "lib-detail.hpp"
#include <fstream>
#include <boost/algorithm/string.hpp>

namespace bmp = boost::multiprecision;

namespace strlib {

[[gnu::flatten]] atom str_trim::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "str-trim", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [l] = detail::get_args<0, 1>(args, env, eval_args);
        if(l->get_type() != atom_type::T_STR)
            detail::unsupported_args(src_location, "str-trim", args);
        std::wstring copy = std::wstring(l->get_string());
        boost::algorithm::trim(copy);
        return copy;
    }));
}

define_repr(str_trim, return L"built-in function `str-trim'")

unsigned count_substrings(const std::wstring & str, const std::wstring & sub) {
    if (sub.length() == 0)
        return 0;
    unsigned count = 0;
    for (size_t offset = str.find(sub); offset != std::string::npos; offset = str.find(sub, offset + sub.length()))
        ++count;
    return count;
}

[[gnu::flatten]] atom str_count::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "str-count", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(a->get_type() != atom_type::T_STR || b->get_type() != atom_type::T_STR)
            detail::unsupported_args(src_location, "str-count", args);
        return bmp::mpz_int(count_substrings(a->get_string(), b->get_string()));
    }));
}

define_repr(str_count, return L"built-in function `str-count'")

}

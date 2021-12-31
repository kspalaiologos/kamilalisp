
#include "str-lib.hpp"
#include "lib-detail.hpp"
#include <fstream>
#include <boost/algorithm/string.hpp>

namespace bmp = boost::multiprecision;

namespace strlib {

[[gnu::flatten]] atom str_trim::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(location, "str-tim", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [l] = detail::get_args<0, 1>(args, env, eval_args);
        if(l->get_type() != atom_type::T_STR)
            detail::unsupported_args(location, "str-trim", args);
        std::wstring copy = std::wstring(l->get_string());
        boost::algorithm::trim(copy);
        return copy;
    }));
}

define_repr(str_trim, return L"built-in function `str-trim'")

}

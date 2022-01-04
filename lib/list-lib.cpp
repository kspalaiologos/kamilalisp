
#include "list-lib.hpp"
#include "lib-detail.hpp"
#include <boost/multiprecision/miller_rabin.hpp>

namespace bmp = boost::multiprecision;

namespace listlib {

[[gnu::flatten]] atom car::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "car", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_LIST)
            return a->thunk_forward();
        return a->get_list().car()->thunk_forward();
    }));
}

define_repr(car, return L"built-in function `car'");

[[gnu::flatten]] atom cdr::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "cdr", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_LIST)
            detail::unsupported_args(src_location, "cdr", args);
        if(a->get_list().is_empty())
            return null_atom->thunk_forward();
        return a->get_list().cdr();
    }));
}

define_repr(cdr, return L"built-in function `cdr'");

}

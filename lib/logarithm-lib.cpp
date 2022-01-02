
#include "logarithm-lib.hpp"
#include "lib-detail.hpp"

namespace bmp = boost::multiprecision;

namespace logarithmlib {

[[gnu::flatten]] atom log10::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "log10", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        bmp::mpc_complex c;
        if(a->get_type() == atom_type::T_INT) {
            c = a->get_integer();
        } else if(a->get_type() == atom_type::T_REAL) {
            c = a->get_real();
        } else if(a->get_type() == atom_type::T_CMPLX) {
            c = a->get_complex();
        } else {
            detail::unsupported_args(src_location, "log10", args);
        }
        
        bmp::mpc_complex z = bmp::log10(c);

        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(log10, return L"built-in function `log10'");

[[gnu::flatten]] atom log2::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "log2", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        bmp::mpc_complex c;
        if(a->get_type() == atom_type::T_INT) {
            return bmp::log2(a->get_integer().convert_to<bmp::mpf_float>());
        } else if(a->get_type() == atom_type::T_REAL) {
            return bmp::log2(a->get_real());
        } else if(a->get_type() == atom_type::T_CMPLX) {
            return bmp::log10(a->get_complex()) / bmp::log10(bmp::mpf_float(2));
        } else {
            detail::unsupported_args(src_location, "log2", args);
        }
    }));
}

define_repr(log2, return L"built-in function `log2'");

[[gnu::flatten]] atom ln::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "ln", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        bmp::mpc_complex c;
        if(a->get_type() == atom_type::T_INT) {
            c = a->get_integer();
        } else if(a->get_type() == atom_type::T_REAL) {
            c = a->get_real();
        } else if(a->get_type() == atom_type::T_CMPLX) {
            c = a->get_complex();
        } else {
            detail::unsupported_args(src_location, "ln", args);
        }
        
        bmp::mpc_complex z = bmp::log(c);

        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(ln, return L"built-in function `ln'");

[[gnu::flatten]] atom log1p::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "log1p", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        bmp::mpc_complex c;
        if(a->get_type() == atom_type::T_INT) {
            c = a->get_integer();
        } else if(a->get_type() == atom_type::T_REAL) {
            c = a->get_real();
        } else if(a->get_type() == atom_type::T_CMPLX) {
            c = a->get_complex();
        } else {
            detail::unsupported_args(src_location, "log1p", args);
        }
        
        bmp::mpc_complex z = bmp::log1p(c);

        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(log1p, return L"built-in function `log1p'");

}

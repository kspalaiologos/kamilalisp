
#include "math-lib.hpp"

namespace mathlib {

[[gnu::flatten]] atom add::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_either<1, 2>(location, "+", args);
    if(args.size() == 2) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a, b] = detail::get_args<2>(args, env);
            if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_integer() + b->get_integer());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_real() + b->get_integer());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_integer() + b->get_real());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_real() + b->get_real());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_complex() + b->get_complex());
            } else if(a->get_type() == atom_type::T_STR && b->get_type() == atom_type::T_STR) {
                return thunk_type(a->get_string() + b->get_string());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_complex() + b->get_integer());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_complex() + b->get_real());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_integer() + b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_real() + b->get_complex());
            } else if(a->get_type() == atom_type::T_STR && b->is_numeric()) {
                return thunk_type(a->get_string() + std::to_wstring(b));
            } else if(a->is_numeric() && b->get_type() == atom_type::T_STR) {
                return thunk_type(std::to_wstring(a) + b->get_string());
            } else {
                detail::unsupported_args(location, "+", args);
            }
        }));
    } else if(args.size() == 1) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a] = detail::get_args<1>(args, env);
            if(a->get_type() == atom_type::T_CMPLX)
                return thunk_type(boost::multiprecision::mpc_complex(a->get_complex().real(), -(a->get_complex().imag())));
            else
                return a->thunk_forward();
        }));
    }

    __builtin_unreachable();
}

[[gnu::flatten]] atom subtract::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_either<1, 2>(location, "-", args);
    if(args.size() == 2) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a, b] = detail::get_args<2>(args, env);
            if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_integer() - b->get_integer());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_real() - b->get_integer());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_integer() - b->get_real());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_real() - b->get_real());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_complex() - b->get_complex());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_complex() - b->get_integer());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_complex() - b->get_real());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_integer() - b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_real() - b->get_complex());
            } else {
                detail::unsupported_args(location, "-", args);
            }
        }));
    } else if(args.size() == 1) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a] = detail::get_args<1>(args, env);
            if(a->get_type() == atom_type::T_INT) {
                return thunk_type(-(a->get_integer()));
            } else if(a->get_type() == atom_type::T_REAL) {
                return thunk_type(-(a->get_real()));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                return thunk_type(-(a->get_complex()));
            } else {
                detail::unsupported_args(location, "-", args);
            }
        }));
    }

    __builtin_unreachable();
}

[[gnu::flatten]] atom multiply::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_either<1, 2>(location, "*", args);
    if(args.size() == 2) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a, b] = detail::get_args<2>(args, env);
            if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_integer() * b->get_integer());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_real() * b->get_integer());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_integer() * b->get_real());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_real() * b->get_real());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_complex() * b->get_complex());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_complex() * b->get_integer());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_complex() * b->get_real());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_integer() * b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_real() * b->get_complex());
            } else {
                detail::unsupported_args(location, "*", args);
            }
        }));
    } else if(args.size() == 1) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a] = detail::get_args<1>(args, env);
            if(a->get_type() == atom_type::T_INT) {
                if(a->get_integer() < 0)
                    return thunk_type(boost::multiprecision::mpz_int(-1));
                else if(a->get_integer() > 0)
                    return thunk_type(boost::multiprecision::mpz_int(1));
                else
                    return thunk_type(boost::multiprecision::mpz_int(0));
            } else if(a->get_type() == atom_type::T_REAL) {
                if(a->get_real() < 0)
                    return thunk_type(boost::multiprecision::mpz_int(-1));
                else if(a->get_real() > 0)
                    return thunk_type(boost::multiprecision::mpz_int(1));
                else
                    return thunk_type(boost::multiprecision::mpz_int(0));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                // sgn(z) = z / norm(z)
                return thunk_type(a->get_complex() /
                    boost::multiprecision::sqrt(boost::multiprecision::pow(a->get_complex().real(), 2)
                        + boost::multiprecision::pow(a->get_complex().imag(), 2)));
            } else {
                detail::unsupported_args(location, "-", args);
            }
        }));
    }

    __builtin_unreachable();
}

[[gnu::flatten]] atom define::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_exact<2>(location, "def", args);
    return make_atom(thunk([args, env]() mutable -> thunk_type {
        auto [a, b] = detail::get_args<2>(args);
        b = evaluate(b, env);
        if(a->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "def", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        env->set(a->get_identifier(), b);
        detail::fix_precision(env);
        return b->thunk_forward();
    }));
}

}

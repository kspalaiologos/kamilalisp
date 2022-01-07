
#include "trig-lib.hpp"
#include "lib-detail.hpp"

#include <unordered_set>
#include <numeric>
#include <boost/range/join.hpp>
#include <boost/multiprecision/miller_rabin.hpp>

namespace bmp = boost::multiprecision;

namespace triglib {

// If you hate the C++ preprocessor, turn back.

#define LSTR(x) L ## x
#define trigonometric_stub(f) \
    [[gnu::flatten]] atom kl_ ## f::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) { \
        detail::argno_exact<1>(src_location, (#f), args); \
        std::wstring repr = this->repr(); \
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type { \
            stacktrace_guard g{ repr }; \
            auto [a] = detail::get_args<0, 1>(args, env, eval_args); \
            bmp::mpc_complex c; \
            if(a->get_type() == atom_type::T_INT) { \
                c = a->get_integer(); \
            } else if(a->get_type() == atom_type::T_REAL) { \
                c = a->get_real(); \
            } else if(a->get_type() == atom_type::T_CMPLX) { \
                c = a->get_complex(); \
            } else { \
                detail::unsupported_args(src_location, #f, args); \
            } \
            bmp::mpc_complex z = bmp::f(c); \
            if(!z.imag().is_zero()) \
                return z; \
            return bmp::mpf_float(z.real()); \
        })); \
    } \
    \
    define_repr(kl_ ## f, return L"built-in function `" LSTR(#f) L"'");

trigonometric_stub(sin);
trigonometric_stub(cos);
trigonometric_stub(tan);

trigonometric_stub(sinh);
trigonometric_stub(cosh);
trigonometric_stub(tanh);

[[gnu::flatten]] atom kl_cot::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "cot", args);
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
            detail::unsupported_args(src_location, "cot", args);
        }
        bmp::mpc_complex z = bmp::mpc_complex(1) / bmp::tan(c);
        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_cot, return L"built-in function `cot'");

[[gnu::flatten]] atom kl_coth::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "coth", args);
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
            detail::unsupported_args(src_location, "coth", args);
        }
        bmp::mpc_complex z = bmp::mpc_complex(1) / bmp::tanh(c);
        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_coth, return L"built-in function `coth'");

[[gnu::flatten]] atom kl_sec::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "sec", args);
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
            detail::unsupported_args(src_location, "sec", args);
        }
        bmp::mpc_complex z = bmp::mpc_complex(1) / bmp::cos(c);
        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_sec, return L"built-in function `sec'");

[[gnu::flatten]] atom kl_sech::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "sech", args);
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
            detail::unsupported_args(src_location, "sech", args);
        }
        bmp::mpc_complex z = bmp::mpc_complex(1) / bmp::cosh(c);
        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_sech, return L"built-in function `sech'");

[[gnu::flatten]] atom kl_csc::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "csc", args);
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
            detail::unsupported_args(src_location, "csc", args);
        }
        bmp::mpc_complex z = bmp::mpc_complex(1) / bmp::sin(c);
        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_csc, return L"built-in function `csc'");

[[gnu::flatten]] atom kl_csch::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "csch", args);
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
            detail::unsupported_args(src_location, "csch", args);
        }
        bmp::mpc_complex z = bmp::mpc_complex(1) / bmp::sinh(c);
        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_csch, return L"built-in function `csch'");

[[gnu::flatten]] atom kl_pi::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<0, 1>(src_location, "pi", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 1) {
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            bmp::mpc_complex c;
            if(a->get_type() == atom_type::T_INT) {
                c = a->get_integer();
            } else if(a->get_type() == atom_type::T_REAL) {
                c = a->get_real();
            } else if(a->get_type() == atom_type::T_CMPLX) {
                c = a->get_complex();
            } else {
                detail::unsupported_args(src_location, "pi", args);
            }
            bmp::mpc_complex z = c * boost::math::constants::pi<bmp::mpf_float>();
            if(!z.imag().is_zero())
                return z;
            return bmp::mpf_float(z.real());
        } else {
            return boost::math::constants::pi<bmp::mpf_float>();
        }
    }));
}

define_repr(kl_pi, return L"built-in function `pi'");

[[gnu::flatten]] atom euler_gamma::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<0, 1>(src_location, "euler-gamma", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 1) {
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            bmp::mpc_complex c;
            if(a->get_type() == atom_type::T_INT) {
                c = a->get_integer();
            } else if(a->get_type() == atom_type::T_REAL) {
                c = a->get_real();
            } else if(a->get_type() == atom_type::T_CMPLX) {
                c = a->get_complex();
            } else {
                detail::unsupported_args(src_location, "euler-gamma", args);
            }
            bmp::mpc_complex z = c * boost::math::constants::euler<bmp::mpf_float>();
            if(!z.imag().is_zero())
                return z;
            return bmp::mpf_float(z.real());
        } else {
            return boost::math::constants::euler<bmp::mpf_float>();
        }
    }));
}

define_repr(euler_gamma, return L"built-in function `euler-gamma'");

[[gnu::flatten]] atom catalan::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<0, 1>(src_location, "catalan", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 1) {
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            bmp::mpc_complex c;
            if(a->get_type() == atom_type::T_INT) {
                c = a->get_integer();
            } else if(a->get_type() == atom_type::T_REAL) {
                c = a->get_real();
            } else if(a->get_type() == atom_type::T_CMPLX) {
                c = a->get_complex();
            } else {
                detail::unsupported_args(src_location, "catalan", args);
            }
            bmp::mpc_complex z = c * boost::math::constants::catalan<bmp::mpf_float>();
            if(!z.imag().is_zero())
                return z;
            return bmp::mpf_float(z.real());
        } else {
            return boost::math::constants::catalan<bmp::mpf_float>();
        }
    }));
}

define_repr(catalan, return L"built-in function `catalan'");

[[gnu::flatten]] atom kl_e::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<0, 1>(src_location, "e", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 1) {
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            bmp::mpc_complex c;
            if(a->get_type() == atom_type::T_INT) {
                c = a->get_integer();
            } else if(a->get_type() == atom_type::T_REAL) {
                c = a->get_real();
            } else if(a->get_type() == atom_type::T_CMPLX) {
                c = a->get_complex();
            } else {
                detail::unsupported_args(src_location, "pe", args);
            }
            bmp::mpc_complex z = c * boost::math::constants::e<bmp::mpf_float>();
            if(!z.imag().is_zero())
                return z;
            return bmp::mpf_float(z.real());
        } else {
            return boost::math::constants::e<bmp::mpf_float>();
        }
    }));
}

define_repr(kl_e, return L"built-in function `e'");

#define arcus_stub(f) \
    [[gnu::flatten]] atom kl_arc ## f::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) { \
        detail::argno_exact<1>(src_location, "arc" #f, args); \
        std::wstring repr = this->repr(); \
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type { \
            stacktrace_guard g{ repr }; \
            auto [a] = detail::get_args<0, 1>(args, env, eval_args); \
            bmp::mpc_complex c; \
            if(a->get_type() == atom_type::T_INT) { \
                c = a->get_integer(); \
            } else if(a->get_type() == atom_type::T_REAL) { \
                c = a->get_real(); \
            } else if(a->get_type() == atom_type::T_CMPLX) { \
                c = a->get_complex(); \
            } else { \
                detail::unsupported_args(src_location, "arc" #f, args); \
            } \
            bmp::mpc_complex z = bmp::a ## f(c); \
            if(!z.imag().is_zero()) \
                return z; \
            return bmp::mpf_float(z.real()); \
        })); \
    } \
    \
    define_repr(kl_arc ## f, return L"built-in function `arc" LSTR(#f) L"'");

arcus_stub(sin);
arcus_stub(cos);
arcus_stub(tan);

arcus_stub(sinh);
arcus_stub(cosh);
arcus_stub(tanh);

[[gnu::flatten]] atom kl_arccot::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "arccot", args);
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
            detail::unsupported_args(src_location, "arccot", args);
        }
        
        // arccot(x) = arccos(x / sqrt(1 + x^2))
        bmp::mpc_complex z = bmp::acos(c / bmp::sqrt(1 + c * c));

        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_arccot, return L"built-in function `arccot'");

[[gnu::flatten]] atom kl_arccoth::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "arccoth", args);
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
            detail::unsupported_args(src_location, "arccoth", args);
        }
        
        // arccoth(x) = arctanh(1/x)
        bmp::mpc_complex z = bmp::atanh(1 / c);

        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_arccoth, return L"built-in function `arccoth'");

[[gnu::flatten]] atom kl_arcsec::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "arcsec", args);
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
            detail::unsupported_args(src_location, "arcsec", args);
        }
        
        // arcsec(x) = arccos(1/x)
        bmp::mpc_complex z = bmp::acos(1 / c);

        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_arcsec, return L"built-in function `arcsec'");

[[gnu::flatten]] atom kl_arcsech::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "arcsech", args);
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
            detail::unsupported_args(src_location, "arcsech", args);
        }
        
        // arcsech(x) = arccos(1/x)
        bmp::mpc_complex z = bmp::acosh(1 / c);

        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_arcsech, return L"built-in function `arcsech'");

[[gnu::flatten]] atom kl_arccsc::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "arccsc", args);
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
            detail::unsupported_args(src_location, "arccsc", args);
        }
        
        // arccsc(x) = arcsin(1/x)
        bmp::mpc_complex z = bmp::asin(1 / c);

        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_arccsc, return L"built-in function `arccsc'");

[[gnu::flatten]] atom kl_arccsch::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "arccsch", args);
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
            detail::unsupported_args(src_location, "arccsch", args);
        }
        
        // arccsch(x) = arcsin(1/x)
        bmp::mpc_complex z = bmp::asinh(1 / c);

        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_arccsch, return L"built-in function `arccsch'");

}


#include "math-lib.hpp"
#include "lib-detail.hpp"

#include <unordered_set>
#include <numeric>
#include <boost/range/join.hpp>

namespace bmp = boost::multiprecision;

template <typename A>
static A abs_f(A && v) {
    if(v < 0)
        return -v;
    else
        return v;
}

namespace mathlib {

[[gnu::flatten]] atom add::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, "+", args);
    if(args.size() == 2) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
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
                return thunk_type(bmp::mpc_complex(a->get_integer()) + b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::mpc_complex(a->get_real()) + b->get_complex());
            } else if(a->get_type() == atom_type::T_STR && b->is_numeric()) {
                return thunk_type(a->get_string() + std::to_wstring(b));
            } else if(a->is_numeric() && b->get_type() == atom_type::T_STR) {
                return thunk_type(std::to_wstring(a) + b->get_string());
            } else {
                detail::unsupported_args(location, "+", args);
            }
        }));
    } else if(args.size() == 1) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_CMPLX)
                return thunk_type(conj(a->get_complex()));
            else
                return a->thunk_forward();
        }));
    }

    __builtin_unreachable();
}

define_repr(add, return L"built-in function `+'")

[[gnu::flatten]] atom subtract::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, "-", args);
    if(args.size() == 2) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
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
                return thunk_type(bmp::mpc_complex(a->get_integer()) - b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::mpc_complex(a->get_real()) - b->get_complex());
            } else {
                detail::unsupported_args(location, "-", args);
            }
        }));
    } else if(args.size() == 1) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
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

define_repr(subtract, return L"built-in function `-'")

[[gnu::flatten]] atom multiply::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, "*", args);
    if(args.size() == 2) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
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
                return thunk_type(bmp::mpc_complex(a->get_integer()) * b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::mpc_complex(a->get_real()) * b->get_complex());
            } else {
                detail::unsupported_args(location, "*", args);
            }
        }));
    } else if(args.size() == 1) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT) {
                if(a->get_integer() < 0)
                    return thunk_type(bmp::mpz_int(-1));
                else if(a->get_integer() > 0)
                    return thunk_type(bmp::mpz_int(1));
                else
                    return thunk_type(bmp::mpz_int(0));
            } else if(a->get_type() == atom_type::T_REAL) {
                if(a->get_real() < 0)
                    return thunk_type(bmp::mpz_int(-1));
                else if(a->get_real() > 0)
                    return thunk_type(bmp::mpz_int(1));
                else
                    return thunk_type(bmp::mpz_int(0));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                // sgn(z) = z / norm(z)
                return thunk_type(a->get_complex() /
                    bmp::sqrt(bmp::pow(a->get_complex().real(), 2)
                        + bmp::pow(a->get_complex().imag(), 2)));
            } else {
                detail::unsupported_args(location, "-", args);
            }
        }));
    }

    __builtin_unreachable();
}

define_repr(multiply, return L"built-in function `*'")

[[gnu::flatten]] atom divide::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, "/", args);
    if(args.size() == 2) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_integer().convert_to<bmp::mpf_float>() / b->get_integer().convert_to<bmp::mpf_float>());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_real() / b->get_integer());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_integer() / b->get_real());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_real() / b->get_real());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_complex() / b->get_complex());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_complex() / b->get_integer());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_complex() / b->get_real());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::mpc_complex(a->get_integer()) / b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::mpc_complex(a->get_real()) / b->get_complex());
            } else {
                detail::unsupported_args(location, "/", args);
            }
        }));
    } else if(args.size() == 1) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT) {
                return thunk_type(1 / bmp::mpf_float(a->get_integer()));
            } else if(a->get_type() == atom_type::T_REAL) {
                return thunk_type(1 / bmp::mpf_float(a->get_real()));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                // 1/z = conjugate(z) / norm^2(z)
                return thunk_type(conj(a->get_complex()) /
                    abs_f(bmp::pow(a->get_complex().real(), 2)
                        + bmp::pow(a->get_complex().imag(), 2)));
            } else {
                detail::unsupported_args(location, "/", args);
            }
        }));
    }

    __builtin_unreachable();
}

define_repr(divide, return L"built-in function `/'")

[[gnu::flatten]] atom divide_int::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, "//", args);
    if(args.size() == 2) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_integer() / b->get_integer());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_real() / b->get_integer());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_integer() / b->get_real());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_real() / b->get_real());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(a->get_complex() / b->get_complex());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_INT) {
                return thunk_type(a->get_complex() / b->get_integer());
            } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_REAL) {
                return thunk_type(a->get_complex() / b->get_real());
            } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::mpc_complex(a->get_integer()) / b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::mpc_complex(a->get_real()) / b->get_complex());
            } else {
                detail::unsupported_args(location, "//", args);
            }
        }));
    } else if(args.size() == 1) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT) {
                return thunk_type(1 / bmp::mpf_float(a->get_integer()));
            } else if(a->get_type() == atom_type::T_REAL) {
                return thunk_type(1 / bmp::mpf_float(a->get_real()));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                // 1/z = conjugate(z) / norm^2(z)
                return thunk_type(conj(a->get_complex()) /
                    abs_f(bmp::pow(a->get_complex().real(), 2)
                        + bmp::pow(a->get_complex().imag(), 2)));
            } else {
                detail::unsupported_args(location, "//", args);
            }
        }));
    }

    __builtin_unreachable();
}

define_repr(divide_int, return L"built-in function `//'")

[[gnu::flatten]] atom modulus::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, "%", args);
    if(args.size() == 2) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
            if(a->get_type() != atom_type::T_INT || b->get_type() != atom_type::T_INT)
                detail::unsupported_args(location, "%", args);
            return thunk_type(a->get_integer() % b->get_integer());
        }));
    } else if(args.size() == 1) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT) {
                return thunk_type(abs_f(a->get_integer()));
            } else if(a->get_type() == atom_type::T_REAL) {
                return thunk_type(abs_f(a->get_real()));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::sqrt(norm(a->get_complex())));
            } else {
                detail::unsupported_args(location, "%", args);
            }
        }));
    }

    __builtin_unreachable();
}

define_repr(modulus, return L"built-in function `%'")

[[gnu::flatten]] atom sqrt::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(location, "sqrt", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() == atom_type::T_INT) {
            return thunk_type(bmp::sqrt(a->get_integer()));
        } else if(a->get_type() == atom_type::T_REAL) {
            return thunk_type(bmp::sqrt(a->get_real()));
        } else if(a->get_type() == atom_type::T_CMPLX) {
            auto z = a->get_complex();
            if(z.imag() == 0 && z.real() < 0)
                kl_error("sqrt when im=0 re<0 doesn't exist.");
            auto n = bmp::sqrt(norm(z));
            auto q = z + n;
            auto m = q / bmp::sqrt(norm(q));
            return thunk_type(m * bmp::sqrt(n));
        } else {
            detail::unsupported_args(location, "sqrt", args);
        }
    }));
}

define_repr(sqrt, return L"built-in function `sqrt'")

[[gnu::flatten]] atom nthroot::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "nth-root", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(b->get_type() != atom_type::T_INT && b->get_type() != atom_type::T_REAL)
            detail::unsupported_args(location, "nth-root", args);
        bmp::mpf_float exponent;
        if(b->get_type() == atom_type::T_INT) {
            exponent = 1 / bmp::mpf_float(b->get_integer());
        } else {
            exponent = 1 / b->get_real();
        }
        if(a->get_type() == atom_type::T_INT) {
            return thunk_type(bmp::pow(a->get_integer(), exponent).convert_to<bmp::mpz_int>());
        } else if(a->get_type() == atom_type::T_REAL) {
            return thunk_type(bmp::pow(a->get_real(), exponent));
        } else if(a->get_type() == atom_type::T_CMPLX) {
            return thunk_type(bmp::pow(a->get_complex(), exponent));
        } else {
            detail::unsupported_args(location, "sqrt", args);
        }
    }));
}

define_repr(nthroot, return L"built-in function `nth-root'")

[[gnu::flatten]] atom power::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "**", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(b->get_type() == atom_type::T_INT) {
            if(a->get_type() == atom_type::T_INT) {
                return thunk_type(bmp::pow(a->get_integer(), b->get_integer().convert_to<long>()).convert_to<bmp::mpz_int>());
            } else if(a->get_type() == atom_type::T_REAL) {
                return thunk_type(bmp::pow(a->get_real(), b->get_integer().convert_to<long>()));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::pow(a->get_complex(), b->get_integer().convert_to<long>()));
            } else {
                detail::unsupported_args(location, "sqrt", args);
            }
        } else if(b->get_type() == atom_type::T_REAL) {
            if(a->get_type() == atom_type::T_INT) {
                return thunk_type(bmp::pow(a->get_integer(), b->get_real()).convert_to<bmp::mpf_float>());
            } else if(a->get_type() == atom_type::T_REAL) {
                return thunk_type(bmp::pow(a->get_real(), b->get_real()));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::pow(a->get_complex(), b->get_real()));
            } else {
                detail::unsupported_args(location, "sqrt", args);
            }
        } else {
            detail::unsupported_args(location, "sqrt", args);
        }
    }));
}

define_repr(power, return L"built-in function `**'")

[[gnu::flatten]] atom iota::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2, 3>(location, "iota", args);
    if(args.size() == 3) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a, b, c] = detail::get_args<0, 3>(args, env, eval_args);
            if(a->get_type() != atom_type::T_INT || b->get_type() != atom_type::T_INT || (c->get_type() != atom_type::T_REAL && c->get_type() != atom_type::T_INT))
                detail::unsupported_args(location, "iota", args);
            if(c->get_type() == atom_type::T_INT) {
                long start = a->get_integer().convert_to<long>(), end = b->get_integer().convert_to<long>();
                if(start == end)
                    return thunk_type(atom_list::from(a));
                else if(start > end) {
                    // count down from start to end
                    atom_list r { };
                    for(long i = start; i >= end; i -= c->get_integer().convert_to<long>())
                        r = r.unsafe_append(make_atom(bmp::mpz_int(i)));
                    return thunk_type(r);
                } else if(start < end) {
                    // count up from start to end
                    atom_list r { };
                    for(long i = start; i <= end; i += c->get_integer().convert_to<long>())
                        r = r.unsafe_append(make_atom(bmp::mpz_int(i)));
                    return thunk_type(r);
                }
                __builtin_unreachable();
            } else if(c->get_type() == atom_type::T_REAL) {
                bmp::mpf_float start = a->get_integer(), end = b->get_integer();
                if(start == end)
                    return thunk_type(atom_list::from(a));
                else if(start > end) {
                    // count down from start to end
                    atom_list r { };
                    for(bmp::mpf_float i = start; i >= end; i -= c->get_real())
                        r = r.unsafe_append(make_atom(i));
                    return thunk_type(r);
                } else if(start < end) {
                    // count up from start to end
                    atom_list r { };
                    for(bmp::mpf_float i = start; i <= end; i += c->get_real())
                        r = r.unsafe_append(make_atom(i));
                    return thunk_type(r);
                }
                __builtin_unreachable();
            } else {
                __builtin_unreachable();
            }
        }));
    } else if(args.size() == 2) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            // Note: Dyadic iota (range) is inclusive on both ends.
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
            if(a->get_type() != atom_type::T_INT || b->get_type() != atom_type::T_INT)
                detail::unsupported_args(location, "iota", args);
            long start = a->get_integer().convert_to<long>(), end = b->get_integer().convert_to<long>();
            if(start == end)
                return thunk_type(atom_list::from(a));
            else if(start > end) {
                // count down from start to end
                atom_list r { };
                for(long i = start; i >= end; --i)
                    r = r.unsafe_append(make_atom(bmp::mpz_int(i)));
                return thunk_type(r);
            } else if(start < end) {
                // count up from start to end
                atom_list r { };
                for(long i = start; i <= end; ++i)
                    r = r.unsafe_append(make_atom(bmp::mpz_int(i)));
                return thunk_type(r);
            }
            __builtin_unreachable();
        }));
    } else if(args.size() == 1) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT) {
                if(a->get_integer() >= 0) {
                    atom_list l { };
                    for(unsigned long i = 0; i < a->get_integer(); ++i)
                        l = l.unsafe_append(make_atom(bmp::mpz_int(i)));
                    return thunk_type(l);
                } else {
                    atom_list l { };
                    for(long i = a->get_integer().convert_to<long>() + 1; i <= 0; ++i)
                        l = l.unsafe_append(make_atom(bmp::mpz_int(i)));
                    return thunk_type(l);
                }
            } else if(a->get_type() == atom_type::T_LIST) {
                std::vector<std::vector<atom>> data;
                for(auto x : a->get_list()) {
                    if(x->get_type() != atom_type::T_INT)
                        detail::unsupported_args(location, "iota list", args);
                    if(x->get_integer() >= 0) {
                        std::vector<atom> l { };
                        for(unsigned long i = 0; i < x->get_integer(); ++i)
                            l.push_back(make_atom(bmp::mpz_int(i)));
                        data.push_back(std::move(l));
                    } else {
                        std::vector<atom> l { };
                        for(long i = x->get_integer().convert_to<long>() + 1; i <= 0; ++i)
                            l.push_back(make_atom(bmp::mpz_int(i)));
                        data.push_back(std::move(l));
                    }
                }
                unsigned int it = 0;
                thunk_type res = thunk_type(std::accumulate(data.rbegin(), data.rend(), atom_list { }, [&it](atom_list && a, const std::vector<atom> & b) {
                    // Cartesian product between `a` and `b`.
                    if(a.size() == 0) {
                        ++it;
                        return atom_list::from(b.rbegin(), b.rend());
                    } else {
                        atom_list result { };
                        // 1st iteration => didn't form lists yet.
                        // any other iteration => lists already formed, cons instead of making a new list.
                        if(it == 1)
                            for(auto & x : b)
                                for(auto & y : a)
                                    result = result.unsafe_append(make_atom(atom_list::from(y).cons(x)));
                        else
                            for(auto & x : a)
                                for(auto & y : b)
                                    result = result.unsafe_append(make_atom(x->get_list().cons(y)));
                        ++it;
                        return result;
                    }
                }));
                return res;
            } else {
                detail::unsupported_args(location, "iota", args);
            }
        }));
    }
    __builtin_unreachable();
}

define_repr(iota, return L"built-in function `iota'")

[[gnu::flatten]] atom equals::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "=", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        return a->operator==(b) ? atom_true->thunk_forward() : atom_false->thunk_forward();
    }));
}

define_repr(equals, return L"built-in function `='")

[[gnu::flatten]] atom not_equals::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "/=", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        return a->operator==(b) ? atom_false->thunk_forward() : atom_true->thunk_forward();
    }));
}

define_repr(not_equals, return L"built-in function `/='")

[[gnu::flatten]] atom less_than::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, "<", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 2) {
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
            return (a->operator<=>(b) == std::weak_ordering::less) ? atom_true->thunk_forward() : atom_false->thunk_forward();
        } else {
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT) {
                return a->get_integer() - 1;
            } else if(a->get_type() == atom_type::T_REAL) {
                return a->get_real() - 1;
            } else if(a->get_type() == atom_type::T_CMPLX) {
                return a->get_complex() - 1;
            } else if(a->get_type() == atom_type::T_STR) {
                std::wstring str = std::wstring(a->get_string());
                // find the predecessor of str.
                const std::wstring letters = L"abcdefghijklmnopqrstuvwxyz";
                const std::wstring numbers = L"0123456789";
                std::wstring result = L"";
                bool carry = false;
                int i = str.size();
                while(i--) {
                    wchar_t c = str[i];
                    int letterPos = letters.find(std::towlower(c));
                    if(letterPos > 0) {
                        wchar_t pred = letters[letterPos - 1];
                        bool isUpper = std::iswupper(c);
                        result = (isUpper ? std::wstring(1, std::towupper(pred)) : std::wstring(1, pred)) + result;
                        carry = false;
                        break;
                    }
                    if(letterPos == 0) {
                        wchar_t pred = letters[letters.size() - 1];
                        bool isUpper = std::iswupper(c);
                        result = (isUpper ? std::wstring(1, std::towupper(pred)) : std::wstring(1, pred)) + result;
                        carry = true;
                        continue;
                    }
                    int numberPos = numbers.find(c);
                    if(numberPos > 0) {
                        wchar_t pred = numbers[numberPos - 1];
                        result = pred + result;
                        carry = false;
                        break;
                    }
                    if(numberPos == 0) {
                        wchar_t pred = numbers[numbers.size() - 1];
                        result = pred + result;
                        carry = true;
                        continue;
                    }
                    result = c + result;
                }
                result = i == -1 ? result : str.substr(0, i) + result;
                if(carry && letters.find(std::towlower(result[0])) != std::wstring::npos)
                    return result.substr(1);
                return result;
            } else {
                detail::unsupported_args(location, "<", args);
            }
        }
    }));
}

define_repr(less_than, return L"built-in function `<'")

[[gnu::flatten]] atom greater_than::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, ">", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 2) {
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
            return (a->operator<=>(b) == std::weak_ordering::greater) ? atom_true->thunk_forward() : atom_false->thunk_forward();
        } else {
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT) {
                return a->get_integer() + 1;
            } else if(a->get_type() == atom_type::T_REAL) {
                return a->get_real() + 1;
            } else if(a->get_type() == atom_type::T_CMPLX) {
                return a->get_complex() + 1;
            } else if(a->get_type() == atom_type::T_STR) {
                std::wstring str = std::wstring(a->get_string());
                // find the successor of str.
                // If the rightmost character is a-zA-Z0-9, it is incremented within its case or digits.
                // If it generates a carry, the process is repeated with the one to its immediate left. 
                auto it = str.rbegin();
                int prep_mode = 0;
                for(; it != str.rend(); ++it) {
                    if(std::iswalpha(*it)) {
                        if(std::iswlower(*it))
                            prep_mode = 1;
                        else
                            prep_mode = 2;
                        
                        if(*it == L'z') {
                            *it = L'a';
                        } else if(*it == L'Z') {
                            *it = L'A';
                        } else {
                            ++*it;
                            break;
                        }
                    } else if(std::iswdigit(*it)) {
                        prep_mode = 0;
                        if(*it == L'9') {
                            *it = L'0';
                        } else {
                            ++*it;
                            break;
                        }
                    }
                }
                return it == str.rend() ? (prep_mode == 0 ? L"0" : prep_mode == 1 ? L"a" : L"A") + str : str;
            } else {
                detail::unsupported_args(location, ">", args);
            }
        }
    }));
}

define_repr(greater_than, return L"built-in function `>'")

[[gnu::flatten]] atom less_equal::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "<=", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        return (a->operator<=>(b) == std::weak_ordering::less || a->operator==(b))
            ? atom_true->thunk_forward() : atom_false->thunk_forward();
    }));
}

define_repr(less_equal, return L"built-in function `<='")

[[gnu::flatten]] atom greater_equal::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, ">=", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        return (a->operator<=>(b) == std::weak_ordering::greater || a->operator==(b))
            ? atom_true->thunk_forward() : atom_false->thunk_forward();
    }));
}

define_repr(greater_equal, return L"built-in function `>='")

[[gnu::flatten]] atom kl_ceil::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, "ceil", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 1) {
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT) {
                return a->get_integer();
            } else if(a->get_type() == atom_type::T_REAL) {
                return bmp::ceil(a->get_real());
            } else if(a->get_type() == atom_type::T_CMPLX) {
                return bmp::mpc_complex {bmp::ceil(a->get_complex().real()), bmp::ceil(a->get_complex().imag())};
            } else {
                detail::unsupported_args(location, "ceil", args);
            }
        } else {
            auto [a, b_atom] = detail::get_args<0, 2>(args, env, eval_args);
            if(b_atom->get_type() != atom_type::T_INT)
                detail::unsupported_args(location, "ceil", args);
            bmp::mpz_int b = b_atom->get_integer();
            // a = 23.1415
            // if b = 0: ceil(a) = 23
            // if b = 1: ceil(a) = 23.1
            // if b = 2: ceil(a) = 23.14
            // if b = -1: ceil(a) = 20
            // if b = -2: cail(a) = 100
            if(b == 0) {
                // plain old boring ceil
                if(a->get_type() == atom_type::T_INT) {
                    return a->get_integer();
                } else if(a->get_type() == atom_type::T_REAL) {
                    return bmp::ceil(a->get_real());
                } else if(a->get_type() == atom_type::T_CMPLX) {
                    return bmp::mpc_complex {bmp::ceil(a->get_complex().real()), bmp::ceil(a->get_complex().imag())};
                } else {
                    detail::unsupported_args(location, "ceil", args);
                }
            } else if(b > 0) {
                // ceil(a * 10^b) / 10^b
                bmp::mpz_int p = bmp::pow(bmp::mpz_int(10), b.convert_to<unsigned>());
                if(a->get_type() == atom_type::T_INT) {
                    bmp::mpf_float n = bmp::mpf_float(a->get_integer()) * p;
                    return bmp::mpf_float(bmp::ceil(n) / p);
                } else if(a->get_type() == atom_type::T_REAL) {
                    return bmp::ceil(a->get_real() * p) / p;
                } else if(a->get_type() == atom_type::T_CMPLX) {
                    return bmp::mpc_complex {bmp::ceil(a->get_complex().real() * p) / p, bmp::ceil(a->get_complex().imag() * p) / p};
                } else {
                    detail::unsupported_args(location, "ceil", args);
                }
            } else if(b < 0) {
                // ceil(a / 10^b) * 10^b
                bmp::mpz_int p = bmp::pow(bmp::mpz_int(10), b.convert_to<unsigned>());
                if(a->get_type() == atom_type::T_INT) {
                    bmp::mpf_float n = bmp::mpf_float(a->get_integer()) / p;
                    return bmp::mpf_float(bmp::ceil(n) * p);
                } else if(a->get_type() == atom_type::T_REAL) {
                    return bmp::ceil(a->get_real() / p) * p;
                } else if(a->get_type() == atom_type::T_CMPLX) {
                    return bmp::mpc_complex {bmp::ceil(a->get_complex().real() / p) * p, bmp::ceil(a->get_complex().imag() / p) * p};
                } else {
                    detail::unsupported_args(location, "ceil", args);
                }
            }

            __builtin_unreachable();
        }
    }));
}

define_repr(kl_ceil, return L"built-in function `ceil'");

[[gnu::flatten]] atom kl_floor::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(location, "floor", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 1) {
            auto [a] = detail::get_args<0, 1>(args, env, eval_args);
            if(a->get_type() == atom_type::T_INT) {
                return a->get_integer();
            } else if(a->get_type() == atom_type::T_REAL) {
                return bmp::floor(a->get_real());
            } else if(a->get_type() == atom_type::T_CMPLX) {
                return bmp::mpc_complex {bmp::floor(a->get_complex().real()), bmp::floor(a->get_complex().imag())};
            } else {
                detail::unsupported_args(location, "floor", args);
            }
        } else {
            auto [a, b_atom] = detail::get_args<0, 2>(args, env, eval_args);
            if(b_atom->get_type() != atom_type::T_INT)
                detail::unsupported_args(location, "floor", args);
            bmp::mpz_int b = b_atom->get_integer();
            if(b == 0) {
                // plain old boring floor
                if(a->get_type() == atom_type::T_INT) {
                    return a->get_integer();
                } else if(a->get_type() == atom_type::T_REAL) {
                    return bmp::floor(a->get_real());
                } else if(a->get_type() == atom_type::T_CMPLX) {
                    return bmp::mpc_complex {bmp::floor(a->get_complex().real()), bmp::floor(a->get_complex().imag())};
                } else {
                    detail::unsupported_args(location, "floor", args);
                }
            } else if(b > 0) {
                // floor(a * 10^b) / 10^b
                bmp::mpz_int p = bmp::pow(bmp::mpz_int(10), b.convert_to<unsigned>());
                if(a->get_type() == atom_type::T_INT) {
                    bmp::mpf_float n = bmp::mpf_float(a->get_integer()) * p;
                    return bmp::mpf_float(bmp::floor(n) / p);
                } else if(a->get_type() == atom_type::T_REAL) {
                    return bmp::floor(a->get_real() * p) / p;
                } else if(a->get_type() == atom_type::T_CMPLX) {
                    return bmp::mpc_complex {bmp::floor(a->get_complex().real() * p) / p, bmp::floor(a->get_complex().imag() * p) / p};
                } else {
                    detail::unsupported_args(location, "floor", args);
                }
            } else if(b < 0) {
                // floor(a / 10^b) * 10^b
                bmp::mpz_int p = bmp::pow(bmp::mpz_int(10), b.convert_to<unsigned>());
                if(a->get_type() == atom_type::T_INT) {
                    bmp::mpf_float n = bmp::mpf_float(a->get_integer()) / p;
                    return bmp::mpf_float(bmp::floor(n) * p);
                } else if(a->get_type() == atom_type::T_REAL) {
                    return bmp::floor(a->get_real() / p) * p;
                } else if(a->get_type() == atom_type::T_CMPLX) {
                    return bmp::mpc_complex {bmp::floor(a->get_complex().real() / p) * p, bmp::floor(a->get_complex().imag() / p) * p};
                } else {
                    detail::unsupported_args(location, "floor", args);
                }
            }

            __builtin_unreachable();
        }
    }));
}

define_repr(kl_floor, return L"built-in function `floor'");

[[gnu::flatten]] atom kl_or::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "or", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(a->get_type() == atom_type::T_LIST && a->get_type() == atom_type::T_LIST) {
            // XXX: Do it more efficiently, without a copy?
            atom_list result { };
            std::unordered_set<atom, std::hash<atom>, atom_equality_trait> seen { a->get_list().begin(), a->get_list().end() };
            seen.insert(b->get_list().begin(), b->get_list().end());
            for(auto& i : seen)
                result.push_back(i);
            return result;
        } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
            return a->get_integer() | b->get_integer();
        } else {
            detail::unsupported_args(location, "or", args);
        }
    }));
}

define_repr(kl_or, return L"built-in function `or'");

[[gnu::flatten]] atom kl_xor::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "xor", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(a->get_type() == atom_type::T_LIST && a->get_type() == atom_type::T_LIST) {
            // XXX: Do it more efficiently, without a copy?
            atom_list result { };
            {
                using atom_set = std::unordered_set<atom, std::hash<atom>, atom_equality_trait>;
                atom_set intersection { };
                atom_set s1 { a->get_list().begin(), a->get_list().end() };
                // Find the intersection and union.
                {
                    atom_set s2 { b->get_list().begin(), b->get_list().end() };
                    for(auto e : s1)
                        if(s2.find(e) != s2.end())
                            intersection.insert(e);
                    s1.insert(s2.begin(), s2.end());
                }
                // intersection => intersection of two sets
                // s1 => union of two sets.
                // Take the difference:
                for(auto e : intersection)
                    s1.erase(e);
                // Turn into a linked list:
                atom_list result { };
                for(auto & i : s1)
                    result.push_back(i);
                return result;
            }
            return result;
        } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
            return a->get_integer() ^ b->get_integer();
        } else {
            detail::unsupported_args(location, "xor", args);
        }
    }));
}

define_repr(kl_xor, return L"built-in function `xor'");

[[gnu::flatten]] atom kl_and::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "and", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(a->get_type() == atom_type::T_LIST && a->get_type() == atom_type::T_LIST) {
            // XXX: Do it more efficiently, without a copy?
            atom_list result { };
            {
                using atom_set = std::unordered_set<atom, std::hash<atom>, atom_equality_trait>;
                atom_set intersection { };
                // Find the intersection.
                {
                    atom_set s1 { a->get_list().begin(), a->get_list().end() };
                    atom_set s2 { b->get_list().begin(), b->get_list().end() };
                    for(auto e : s1)
                        if(s2.find(e) != s2.end())
                            intersection.insert(e);
                }
                // Turn into a linked list:
                atom_list result { };
                for(auto & i : intersection)
                    result.push_back(i);
                return result;
            }
            return result;
        } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
            return a->get_integer() & b->get_integer();
        } else {
            detail::unsupported_args(location, "and", args);
        }
    }));
}

define_repr(kl_and, return L"built-in function `and'");

}

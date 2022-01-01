
#include "math-lib.hpp"
#include "lib-detail.hpp"

#include <unordered_set>
#include <numeric>
#include <boost/range/join.hpp>
#include <boost/multiprecision/miller_rabin.hpp>

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
    detail::argno_either<1, 2>(src_location, "+", args);
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
                detail::unsupported_args(src_location, "+", args);
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
    detail::argno_either<1, 2>(src_location, "-", args);
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
                detail::unsupported_args(src_location, "-", args);
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
                detail::unsupported_args(src_location, "-", args);
            }
        }));
    }

    __builtin_unreachable();
}

define_repr(subtract, return L"built-in function `-'")

[[gnu::flatten]] atom multiply::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(src_location, "*", args);
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
                detail::unsupported_args(src_location, "*", args);
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
                detail::unsupported_args(src_location, "-", args);
            }
        }));
    }

    __builtin_unreachable();
}

define_repr(multiply, return L"built-in function `*'")

[[gnu::flatten]] atom divide::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(src_location, "/", args);
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
                detail::unsupported_args(src_location, "/", args);
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
                detail::unsupported_args(src_location, "/", args);
            }
        }));
    }

    __builtin_unreachable();
}

define_repr(divide, return L"built-in function `/'")

[[gnu::flatten]] atom divide_int::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(src_location, "//", args);
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
                detail::unsupported_args(src_location, "//", args);
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
                detail::unsupported_args(src_location, "//", args);
            }
        }));
    }

    __builtin_unreachable();
}

define_repr(divide_int, return L"built-in function `//'")

[[gnu::flatten]] atom modulus::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(src_location, "%", args);
    if(args.size() == 2) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
            if(a->get_type() != atom_type::T_INT || b->get_type() != atom_type::T_INT)
                detail::unsupported_args(src_location, "%", args);
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
                detail::unsupported_args(src_location, "%", args);
            }
        }));
    }

    __builtin_unreachable();
}

define_repr(modulus, return L"built-in function `%'")

[[gnu::flatten]] atom sqrt::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "sqrt", args);
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
            detail::unsupported_args(src_location, "sqrt", args);
        }
    }));
}

define_repr(sqrt, return L"built-in function `sqrt'")

[[gnu::flatten]] atom nthroot::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "nth-root", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(b->get_type() != atom_type::T_INT && b->get_type() != atom_type::T_REAL)
            detail::unsupported_args(src_location, "nth-root", args);
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
            detail::unsupported_args(src_location, "sqrt", args);
        }
    }));
}

define_repr(nthroot, return L"built-in function `nth-root'")

[[gnu::flatten]] atom power::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "**", args);
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
                detail::unsupported_args(src_location, "sqrt", args);
            }
        } else if(b->get_type() == atom_type::T_REAL) {
            if(a->get_type() == atom_type::T_INT) {
                return thunk_type(bmp::pow(a->get_integer(), b->get_real()).convert_to<bmp::mpf_float>());
            } else if(a->get_type() == atom_type::T_REAL) {
                return thunk_type(bmp::pow(a->get_real(), b->get_real()));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                return thunk_type(bmp::pow(a->get_complex(), b->get_real()));
            } else {
                detail::unsupported_args(src_location, "sqrt", args);
            }
        } else {
            detail::unsupported_args(src_location, "sqrt", args);
        }
    }));
}

define_repr(power, return L"built-in function `**'")

[[gnu::flatten]] atom iota::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2, 3>(src_location, "iota", args);
    if(args.size() == 3) {
        std::wstring repr = this->repr();
        return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
            stacktrace_guard g{ repr };
            auto [a, b, c] = detail::get_args<0, 3>(args, env, eval_args);
            if(a->get_type() != atom_type::T_INT || b->get_type() != atom_type::T_INT || (c->get_type() != atom_type::T_REAL && c->get_type() != atom_type::T_INT))
                detail::unsupported_args(src_location, "iota", args);
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
                detail::unsupported_args(src_location, "iota", args);
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
                        detail::unsupported_args(src_location, "iota list", args);
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
                detail::unsupported_args(src_location, "iota", args);
            }
        }));
    }
    __builtin_unreachable();
}

define_repr(iota, return L"built-in function `iota'")

[[gnu::flatten]] atom equals::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "=", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        return a->operator==(b) ? atom_true->thunk_forward() : atom_false->thunk_forward();
    }));
}

define_repr(equals, return L"built-in function `='")

[[gnu::flatten]] atom not_equals::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "/=", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        return a->operator==(b) ? atom_false->thunk_forward() : atom_true->thunk_forward();
    }));
}

define_repr(not_equals, return L"built-in function `/='")

[[gnu::flatten]] atom less_than::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(src_location, "<", args);
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
                detail::unsupported_args(src_location, "<", args);
            }
        }
    }));
}

define_repr(less_than, return L"built-in function `<'")

[[gnu::flatten]] atom greater_than::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(src_location, ">", args);
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
                detail::unsupported_args(src_location, ">", args);
            }
        }
    }));
}

define_repr(greater_than, return L"built-in function `>'")

[[gnu::flatten]] atom less_equal::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "<=", args);
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
    detail::argno_exact<2>(src_location, ">=", args);
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
    detail::argno_either<1, 2>(src_location, "ceil", args);
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
                detail::unsupported_args(src_location, "ceil", args);
            }
        } else {
            auto [a, b_atom] = detail::get_args<0, 2>(args, env, eval_args);
            if(b_atom->get_type() != atom_type::T_INT)
                detail::unsupported_args(src_location, "ceil", args);
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
                    detail::unsupported_args(src_location, "ceil", args);
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
                    detail::unsupported_args(src_location, "ceil", args);
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
                    detail::unsupported_args(src_location, "ceil", args);
                }
            }

            __builtin_unreachable();
        }
    }));
}

define_repr(kl_ceil, return L"built-in function `ceil'");

[[gnu::flatten]] atom kl_floor::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<1, 2>(src_location, "floor", args);
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
                detail::unsupported_args(src_location, "floor", args);
            }
        } else {
            auto [a, b_atom] = detail::get_args<0, 2>(args, env, eval_args);
            if(b_atom->get_type() != atom_type::T_INT)
                detail::unsupported_args(src_location, "floor", args);
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
                    detail::unsupported_args(src_location, "floor", args);
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
                    detail::unsupported_args(src_location, "floor", args);
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
                    detail::unsupported_args(src_location, "floor", args);
                }
            }

            __builtin_unreachable();
        }
    }));
}

define_repr(kl_floor, return L"built-in function `floor'");

[[gnu::flatten]] atom kl_or::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "or", args);
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
            detail::unsupported_args(src_location, "or", args);
        }
    }));
}

define_repr(kl_or, return L"built-in function `or'");

[[gnu::flatten]] atom kl_xor::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "xor", args);
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
            detail::unsupported_args(src_location, "xor", args);
        }
    }));
}

define_repr(kl_xor, return L"built-in function `xor'");

[[gnu::flatten]] atom kl_and::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "and", args);
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
            detail::unsupported_args(src_location, "and", args);
        }
    }));
}

define_repr(kl_and, return L"built-in function `and'");

using mpz_rat = std::tuple<bmp::mpz_int, bmp::mpz_int>;

mpz_rat to_rat(const std::vector<bmp::mpz_int> & series) {
    mpz_rat rat = std::make_tuple(bmp::mpz_int(1), bmp::mpz_int(0));
    for(auto x = series.rbegin(); x != series.rend(); x++) {
        std::swap(std::get<0>(rat), std::get<1>(rat));
        std::get<0>(rat) += *x * std::get<1>(rat);
    }
    return rat;
}

bmp::mpf_float float_from_rat(const mpz_rat & r) {
    return bmp::mpf_float(std::get<0>(r)) / bmp::mpf_float(std::get<1>(r));
}

mpz_rat ratio(bmp::mpf_float & f, unsigned precision) {
    std::vector<bmp::mpz_int> series;
    bmp::mpf_float orig = f;
    const bmp::mpf_float ONE = bmp::mpf_float(1);
    const bmp::mpf_float ZERO = bmp::mpf_float(0);
    mpz_rat old = std::make_tuple(bmp::mpz_int(1), bmp::mpz_int(1));

    // NOTE: Approximating rationals, especially for small values, needs to be done with reduced precision.

    // 1: Find the continued fraction up to a given precision.
    for(unsigned i = 0; i < precision; i++) {
        bmp::mpz_int x = f.convert_to<bmp::mpz_int>();
        series.push_back(x);
        mpz_rat R = to_rat(series);
        if(bmp::abs(float_from_rat(old) - orig) > bmp::abs(float_from_rat(R) - orig))
            old = R;
        bmp::mpf_float f_next = f - x;
        if(f_next == ZERO)
            break;
        f = ONE / f_next;
    }

    if(std::get<1>(old) == ZERO)
        kl_error("can't approximate as a rational: " + f.str());

    return old;
}

static inline bmp::mpc_complex gaussian_rem(const bmp::mpc_complex & a, const bmp::mpc_complex & b) {
    bmp::mpc_complex prod = a * bmp::conj(b);
    bmp::mpfr_float p = prod.real() / (b.real() * b.real() + b.imag() * b.imag());
    bmp::mpfr_float q = prod.imag() / (b.real() * b.real() + b.imag() * b.imag());
    bmp::mpc_complex gamma = bmp::mpc_complex(bmp::trunc(p), bmp::trunc(q));
    bmp::mpc_complex rho = a - gamma * b;
    return rho;
}

static inline bmp::mpc_complex gcd_complex(const bmp::mpc_complex & alpha, const bmp::mpc_complex & beta) {
    static bmp::mpc_complex ZERO = bmp::mpc_complex(0, 0);
    if(gaussian_rem(alpha, beta) == ZERO)
        return beta;
    return gcd_complex(beta, gaussian_rem(alpha, beta));
}

[[gnu::flatten]] atom kl_gcd::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "gcd", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
            return bmp::gcd(a->get_integer(), b->get_integer());
        } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_REAL) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            bmp::mpf_float n1 = a->get_real();
            bmp::mpf_float n2 = b->get_real();
            // gcd(a/b, c/d) = gcd(a, c) / lcm(b, d)
            auto [A, B] = ratio(n1, precision);
            auto [C, D] = ratio(n2, precision);
            // compute the resulting fraction's numerator and denumerator
            bmp::mpz_int top = bmp::gcd(A, C);
            bmp::mpz_int bot = bmp::lcm(B, D);
            // return the fraction
            return bmp::mpf_float(top) / bot;
        } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_REAL) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            bmp::mpf_float n1 = a->get_integer();
            bmp::mpf_float n2 = b->get_real();
            // gcd(a/b, c/d) = gcd(a, c) / lcm(b, d)
            auto [A, B] = ratio(n1, precision);
            auto [C, D] = ratio(n2, precision);
            // compute the resulting fraction's numerator and denumerator
            bmp::mpz_int top = bmp::gcd(A, C);
            bmp::mpz_int bot = bmp::lcm(B, D);
            // return the fraction
            return bmp::mpf_float(top) / bot;
        } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_INT) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            bmp::mpf_float n1 = a->get_real();
            bmp::mpf_float n2 = b->get_integer();
            // gcd(a/b, c/d) = gcd(a, c) / lcm(b, d)
            auto [A, B] = ratio(n1, precision);
            auto [C, D] = ratio(n2, precision);
            // compute the resulting fraction's numerator and denumerator
            bmp::mpz_int top = bmp::gcd(A, C);
            bmp::mpz_int bot = bmp::lcm(B, D);
            // return the fraction
            return bmp::mpf_float(top) / bot;
        } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_INT) {
            bmp::mpc_complex n1 = a->get_complex();
            bmp::mpc_complex n2 = b->get_integer();
            return gcd_complex(n1, n2);
        } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_CMPLX) {
            bmp::mpc_complex n1 = a->get_complex();
            bmp::mpc_complex n2 = b->get_complex();
            return gcd_complex(n1, n2);
        } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
            bmp::mpc_complex n1 = a->get_integer();
            bmp::mpc_complex n2 = b->get_complex();
            return gcd_complex(n1, n2);
        } else {
            detail::unsupported_args(src_location, "gcd", args);
        }
    }));
}

define_repr(kl_gcd, return L"built-in function `gcd'");

[[gnu::flatten]] atom kl_lcm::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "lcm", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
            return bmp::lcm(a->get_integer(), b->get_integer());
        } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_REAL) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            bmp::mpf_float n1 = a->get_real();
            bmp::mpf_float n2 = b->get_real();
            // gcd(a/b, c/d) = gcd(a, c) / lcm(b, d)
            auto [A, B] = ratio(n1, precision);
            auto [C, D] = ratio(n2, precision);
            // compute the resulting fraction's numerator and denumerator
            bmp::mpz_int top = bmp::lcm(A, C);
            bmp::mpz_int bot = bmp::gcd(B, D);
            // return the fraction
            return bmp::mpf_float(top) / bot;
        } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_REAL) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            bmp::mpf_float n1 = a->get_integer();
            bmp::mpf_float n2 = b->get_real();
            // gcd(a/b, c/d) = gcd(a, c) / lcm(b, d)
            auto [A, B] = ratio(n1, precision);
            auto [C, D] = ratio(n2, precision);
            // compute the resulting fraction's numerator and denumerator
            bmp::mpz_int top = bmp::lcm(A, C);
            bmp::mpz_int bot = bmp::gcd(B, D);
            // return the fraction
            return bmp::mpf_float(top) / bot;
        } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_INT) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            bmp::mpf_float n1 = a->get_real();
            bmp::mpf_float n2 = b->get_integer();
            // gcd(a/b, c/d) = gcd(a, c) / lcm(b, d)
            auto [A, B] = ratio(n1, precision);
            auto [C, D] = ratio(n2, precision);
            // compute the resulting fraction's numerator and denumerator
            bmp::mpz_int top = bmp::lcm(A, C);
            bmp::mpz_int bot = bmp::gcd(B, D);
            // return the fraction
            return bmp::mpf_float(top) / bot;
        } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_INT) {
            bmp::mpc_complex n1 = a->get_complex();
            bmp::mpc_complex n2 = b->get_integer();
            return (n1 * n2) / gcd_complex(n1, n2);
        } else if(a->get_type() == atom_type::T_CMPLX && b->get_type() == atom_type::T_CMPLX) {
            bmp::mpc_complex n1 = a->get_complex();
            bmp::mpc_complex n2 = b->get_complex();
            return (n1 * n2) / gcd_complex(n1, n2);
        } else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
            bmp::mpc_complex n1 = a->get_integer();
            bmp::mpc_complex n2 = b->get_complex();
            return (n1 * n2) / gcd_complex(n1, n2);
        } else {
            detail::unsupported_args(src_location, "lcm", args);
        }
    }));
}

define_repr(kl_lcm, return L"built-in function `lcm'");

static std::unordered_map<int, mpz_rat> bernoulli_cache;
static std::mutex bernoulli_lock;

atom_list rat_to_list(const mpz_rat & r) {
    atom_list result;
    auto [num, den] = r;
    result.push_back(make_atom(num));
    result.push_back(make_atom(den));
    return result;
}

[[gnu::flatten]] atom kl_bernoulli::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "bernoulli", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_INT)
            detail::unsupported_args(src_location, "bernoulli", args);
        int n = a->get_integer().convert_to<int>();

        std::lock_guard<std::mutex> guard(bernoulli_lock);
        if(bernoulli_cache.find(n) != bernoulli_cache.end())
            return rat_to_list(bernoulli_cache[n]);
        auto out = std::vector<bmp::mpq_rational>();
        for (int m = 0; m <= n; m++) {
            out.emplace_back(1, (m + 1));
            for (size_t j = m; j >= 1; j--) {
                out[j - 1] = bmp::mpq_rational(j) * (out[j - 1] - out[j]);
            }
        }
        mpz_rat result = std::make_tuple(bmp::numerator(out[0]), bmp::denominator(out[0]));
        bernoulli_cache.emplace(n, result);
        return rat_to_list(result);
    }));
}

define_repr(kl_bernoulli, return L"built-in function `bernoulli'");

[[gnu::flatten]] atom kl_digamma::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "digamma", args);
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
            detail::unsupported_args(src_location, "digamma", args);
        }
        // Use the boring phi(z) = ln(z) - 1/2z approximation.
        bmp::mpc_complex z = bmp::log(c) - 1.0 / (2 * c);
        if(!z.imag().is_zero())
            return z;
        return bmp::mpf_float(z.real());
    }));
}

define_repr(kl_digamma, return L"built-in function `digamma'");

[[gnu::flatten]] atom kl_lambert0::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "lambert-w0", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        bmp::mpf_float c;
        if(a->get_type() == atom_type::T_INT) {
            c = a->get_integer();
        } else if(a->get_type() == atom_type::T_REAL) {
            c = a->get_real();
        } else {
            detail::unsupported_args(src_location, "lambert-w0", args);
        }
        return boost::math::lambert_w0(c);
    }));
}

define_repr(kl_lambert0, return L"built-in function `lambert-w0'");

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

[[gnu::flatten]] atom prime::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "prime", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_INT)
            detail::unsupported_args(src_location, "prime", args);
        bmp::mpz_int n = a->get_integer();
        if(n < 2)
            return atom_false->thunk_forward();
        if(n == 2)
            return atom_true->thunk_forward();
        if((n & 1) == 0)
            return atom_false->thunk_forward();
        std::wcout << L"testing the primality using miller rabin..." << std::endl;
        return bmp::miller_rabin_test(n, 10 * env->get(L"fr")->get_integer().convert_to<unsigned>())
            ? atom_true->thunk_forward() : atom_false->thunk_forward();
    }));
}

define_repr(prime, return L"built-in function `prime'");

}

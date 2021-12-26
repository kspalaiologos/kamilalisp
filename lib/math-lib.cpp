
#include "math-lib.hpp"
#include "lib-detail.hpp"

#include <numeric>

namespace bmp = boost::multiprecision;

static kl_complex conjugate(kl_complex && v) {
    return kl_complex(v.re, -(v.im));
}

template <typename T>
static T abs(T && v) {
    if(v < 0)
        return -v;
    else
        return v;
}

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
                return thunk_type(kl_complex(a->get_integer()) + b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(kl_complex(a->get_real()) + b->get_complex());
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
                return thunk_type(conjugate(a->get_complex()));
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
                return thunk_type(kl_complex(a->get_integer()) - b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(kl_complex(a->get_real()) - b->get_complex());
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
                return thunk_type(kl_complex(a->get_integer()) * b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(kl_complex(a->get_real()) * b->get_complex());
            } else {
                detail::unsupported_args(location, "*", args);
            }
        }));
    } else if(args.size() == 1) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a] = detail::get_args<1>(args, env);
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
                    bmp::sqrt(bmp::pow(a->get_complex().re, 2)
                        + bmp::pow(a->get_complex().im, 2)));
            } else {
                detail::unsupported_args(location, "-", args);
            }
        }));
    }

    __builtin_unreachable();
}

[[gnu::flatten]] atom divide::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_either<1, 2>(location, "/", args);
    if(args.size() == 2) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a, b] = detail::get_args<2>(args, env);
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
                return thunk_type(kl_complex(a->get_integer()) / b->get_complex());
            } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_CMPLX) {
                return thunk_type(kl_complex(a->get_real()) / b->get_complex());
            } else {
                detail::unsupported_args(location, "/", args);
            }
        }));
    } else if(args.size() == 1) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a] = detail::get_args<1>(args, env);
            if(a->get_type() == atom_type::T_INT) {
                return thunk_type(1 / bmp::mpf_float(a->get_integer()));
            } else if(a->get_type() == atom_type::T_REAL) {
                return thunk_type(1 / bmp::mpf_float(a->get_real()));
            } else if(a->get_type() == atom_type::T_CMPLX) {
                // 1/z = conjugate(z) / norm^2(z)
                return thunk_type(conjugate(a->get_complex()) /
                    abs(bmp::pow(a->get_complex().re, 2)
                        + bmp::pow(a->get_complex().im, 2)));
            } else {
                detail::unsupported_args(location, "/", args);
            }
        }));
    }

    __builtin_unreachable();
}

[[gnu::flatten]] atom iota::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_either<1, 2, 3>(location, "iota", args);
    if(args.size() == 3) {
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a, b, c] = detail::get_args<3>(args);
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
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            // Note: Dyadic iota (range) is inclusive on both ends.
            auto [a, b] = detail::get_args<2>(args, env);
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
        return make_atom(thunk([args, env]() mutable -> thunk_type {
            auto [a] = detail::get_args<1>(args, env);
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

[[gnu::flatten]] atom equals::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_exact<2>(location, "=", args);
    return make_atom(thunk([args, env]() mutable -> thunk_type {
        auto [a, b] = detail::get_args<2>(args, env);
        return a->operator==(b) ? atom_true->thunk_forward() : atom_false->thunk_forward();
    }));
}

[[gnu::flatten]] atom not_equals::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_exact<2>(location, "/=", args);
    return make_atom(thunk([args, env]() mutable -> thunk_type {
        auto [a, b] = detail::get_args<2>(args, env);
        return a->operator==(b) ? atom_false->thunk_forward() : atom_true->thunk_forward();
    }));
}

}

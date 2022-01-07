
#include "combinatorics-lib.hpp"
#include "combinatorics-detail.hpp"
#include "lib-detail.hpp"

#include <boost/range/algorithm.hpp>

namespace bmp = boost::multiprecision;

#include <vector>

namespace combinatoricslib {

[[gnu::flatten]] atom pmat::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    ::detail::argno_exact<1>(src_location, "pmat", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [n] = ::detail::get_args<0, 1>(args, env, eval_args);
        if(n->get_type() != atom_type::T_INT || n->get_integer() < 0)
            ::detail::unsupported_args(src_location, "pmat", args);
        unsigned x = n->get_integer().convert_to<unsigned>();
        if(x == 0) return atom_list { };
        if(x == 1) {
            atom one = make_atom(bmp::mpz_int(1));
            atom x = make_atom(atom_list::from(one));
            return atom_list::from(x);
        }
        atom_list r { };
        std::vector<unsigned> indices((std::size_t) x);
        std::iota(indices.begin(), indices.end(), 0);
        do {
            atom_list l { };
            for(auto & i : indices)
                l.push_back(make_atom(bmp::mpz_int(i)));
            r.push_back(make_atom(l));
        } while(boost::range::next_permutation(indices));
        return r;
    }));
}

define_repr(pmat, return L"built-in function `pmat'");

[[gnu::flatten]] atom cmat::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    ::detail::argno_exact<2>(src_location, "cmat", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        // choose k from n
        auto [n, k] = ::detail::get_args<0, 2>(args, env, eval_args);
        if(n->get_type() != atom_type::T_INT || n->get_integer() < 0 || k->get_type() != atom_type::T_INT || k->get_integer() < 0)
            ::detail::unsupported_args(src_location, "pmat", args);
        unsigned x = n->get_integer().convert_to<unsigned>();
        unsigned y = k->get_integer().convert_to<unsigned>();
        if(x == 0) return atom_list { };
        if(x == 1) {
            atom one = make_atom(bmp::mpz_int(1));
            atom x = make_atom(atom_list::from(one));
            return atom_list::from(x);
        }
        std::vector<bmp::mpz_int> indices((std::size_t) x);
        std::iota(indices.begin(), indices.end(), 0);
        return detail::comb_impl(indices, y);
    }));
}

define_repr(cmat, return L"built-in function `cmat'");

[[gnu::flatten]] atom binomial::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    ::detail::argno_exact<2>(src_location, "binomial", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        // choose k from n
        auto [n, k] = ::detail::get_args<0, 2>(args, env, eval_args);
        if(n->get_type() != atom_type::T_INT || n->get_integer() < 0 || k->get_type() != atom_type::T_INT || k->get_integer() < 0)
            ::detail::unsupported_args(src_location, "binomial", args);
        bmp::mpz_int x = n->get_integer();
        bmp::mpz_int y = k->get_integer();
        // (n k) = n! / (n-k)! k!
        return detail::int_factorial(x) / (detail::int_factorial(x - y) * detail::int_factorial(y));
    }));
}

define_repr(binomial, return L"built-in function `binomial'");

[[gnu::flatten]] atom pochhammer_plus::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    ::detail::argno_exact<2>(src_location, "pochhammer+", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [n, k] = ::detail::get_args<0, 2>(args, env, eval_args);
        if(n->get_type() != atom_type::T_INT || n->get_integer() < 0 || k->get_type() != atom_type::T_INT || k->get_integer() < 0)
            ::detail::unsupported_args(src_location, "pochhammer+", args);
        bmp::mpz_int x = n->get_integer();
        bmp::mpz_int y = k->get_integer();
        if(y == 0) return bmp::mpz_int(1);
        if(y == 1) return x;
        bmp::mpz_int r = x;
        for(bmp::mpz_int i = x + 1; i <= x + y; i++)
            r *= i;
        return r;
    }));
}

define_repr(pochhammer_plus, return L"built-in function `pochhammer+'");

[[gnu::flatten]] atom pochhammer_minus::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    ::detail::argno_exact<2>(src_location, "pochhammer-", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [n, k] = ::detail::get_args<0, 2>(args, env, eval_args);
        if(n->get_type() != atom_type::T_INT || n->get_integer() < 0 || k->get_type() != atom_type::T_INT || k->get_integer() < 0)
            ::detail::unsupported_args(src_location, "pochhammer-", args);
        bmp::mpz_int x = n->get_integer();
        bmp::mpz_int y = k->get_integer();
        if(y == 0) return bmp::mpz_int(1);
        if(y == 1) return x;
        bmp::mpz_int r = x;
        for(bmp::mpz_int i = x - 1; i + y >= x; i--)
            r *= i;
        return r;
    }));
}

define_repr(pochhammer_minus, return L"built-in function `pochhammer-'");

[[gnu::flatten]] atom factorial::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    ::detail::argno_exact<1>(src_location, "!", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = ::detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() == atom_type::T_INT) {
            return detail::int_factorial(a->get_integer());
        } else if(a->get_type() == atom_type::T_REAL) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            std::lock_guard<std::mutex> lock(detail::spouge_lock);
            if(detail::spouge_coefficient_cache.find(precision) == detail::spouge_coefficient_cache.end())
                detail::spouge_coefficient_cache[precision]
                    = detail::spouge_coeffs<bmp::mpf_float>(precision);
            return detail::gamma_impl(detail::spouge_coefficient_cache[precision], a->get_real() + 1);
        } else if(a->get_type() == atom_type::T_CMPLX) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            std::lock_guard<std::mutex> lock(detail::spouge_lock);
            if(detail::spouge_coefficient_cache.find(precision) == detail::spouge_coefficient_cache.end())
                detail::spouge_coefficient_cache[precision]
                    = detail::spouge_coeffs<bmp::mpf_float>(precision);
            return detail::gamma_impl(detail::spouge_coefficient_cache[precision], a->get_complex() + 1);
        } else {
            ::detail::unsupported_args(src_location, "!", args);
        }
    }));
}

define_repr(factorial, return L"built-in function `!'");

[[gnu::flatten]] atom gamma::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    ::detail::argno_exact<1>(src_location, "gamma", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = ::detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() == atom_type::T_INT) {
            return detail::int_factorial(a->get_integer() + 1);
        } else if(a->get_type() == atom_type::T_REAL) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            std::lock_guard<std::mutex> lock(detail::spouge_lock);
            if(detail::spouge_coefficient_cache.find(precision) == detail::spouge_coefficient_cache.end())
                detail::spouge_coefficient_cache[precision]
                    = detail::spouge_coeffs<bmp::mpf_float>(precision);
            return detail::gamma_impl(detail::spouge_coefficient_cache[precision], a->get_real());
        } else if(a->get_type() == atom_type::T_CMPLX) {
            unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
            std::lock_guard<std::mutex> lock(detail::spouge_lock);
            if(detail::spouge_coefficient_cache.find(precision) == detail::spouge_coefficient_cache.end())
                detail::spouge_coefficient_cache[precision]
                    = detail::spouge_coeffs<bmp::mpf_float>(precision);
            return detail::gamma_impl(detail::spouge_coefficient_cache[precision], a->get_complex());
        } else {
            ::detail::unsupported_args(src_location, "gamma", args);
        }
    }));
}

define_repr(gamma, return L"built-in function `gamma'");

}

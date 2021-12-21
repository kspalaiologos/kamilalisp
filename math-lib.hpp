
#ifndef _MATH_LIB_HPP
#define _MATH_LIB_HPP

#include "atom.hpp"
#include "env.hpp"
#include "list.hpp"
#include "error.hpp"
#include "executor.hpp"

#include <boost/algorithm/string/join.hpp>

namespace detail {
    template <std::size_t... sizes>
    inline void argno_either(const std::string & loc, const std::string & cause, atom_list & l) {
        const int x[] = { sizes... };
        for(std::size_t i : x)
            if(l.size() == i)
                return;
        const std::string s[] = { std::to_string(sizes)... };
        throw std::runtime_error(
            loc + "invalid invocation to " + cause + " expected either "
          + boost::algorithm::join(s, ", ")
          + " arguments, got " + std::to_string(l.size()));
    }

    template <std::size_t size>
    inline void argno_more(const std::string & loc, const std::string & cause, atom_list & l) {
        if(l.size() <= size)
            throw std::runtime_error(
                loc + "invalid invocation to " + cause + " expected at least "
              + std::to_string(size) + " arguments, got " + std::to_string(l.size()));
    }

    template <std::size_t size>
    inline void argno_less(const std::string & loc, const std::string & cause, atom_list & l) {
        if(l.size() >= size)
            throw std::runtime_error(
                loc + "invalid invocation to " + cause + " expected at most "
              + std::to_string(size) + " arguments, got " + std::to_string(l.size()));
    }

    template <std::size_t lb, std::size_t hb>
    inline void argno_between(const std::string & loc, const std::string & cause, atom_list & l) {
        if(l.size() < lb || l.size() > hb)
            throw std::runtime_error(
                loc + "invalid invocation to " + cause + " expected between "
              + std::to_string(lb) + " and " + std::to_string(hb) + " arguments, got "
              + std::to_string(l.size()));
    }

    template <std::size_t N>
    inline std::array<atom, N> get_args(atom_list data, std::shared_ptr<environment> env) {
        std::array<atom, N> r;
        for(std::size_t i = 0; i < N; i++)
            { r[i] = evaluate(data.car(), env); data = data.cdr(); }
        return r;
    }

    template <std::size_t N>
    inline std::array<atom, N> get_args(atom_list data) {
        std::array<atom, N> r;
        for(std::size_t i = 0; i < N; i++)
            { r[i] = data.car(); data = data.cdr(); }
        return r;
    }

    inline void unsupported_args(const std::string & loc, const std::string & cause, atom_list l) {
        std::vector<std::string> names;
        for(auto & a : l)
            names.push_back(a->type_name());
        throw std::runtime_error(
                loc + "invalid invocation to " + cause + ", arguments of types " + boost::algorithm::join(names, ", ") + " are outside of the domain.");
    }

    inline void fix_precision(std::shared_ptr<environment> env, atom a) {
        unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
        if(a->get_type() == atom_type::T_CMPLX) {
            a->get_complex().precision(precision);
        } else if(a->get_type() == atom_type::T_REAL) {
            a->get_real().precision(precision);
        }
    }
}

namespace mathlib {

class add : public callable {
    public:
        ~add() { }

        atom call(std::shared_ptr<environment> env, atom_list args) override {
            detail::argno_either<1, 2>(location, "+", args);
            return make_atom(thunk([args, env]() mutable -> thunk_type {
                auto [a, b] = detail::get_args<2>(args, env);
                detail::fix_precision(env, a);
                detail::fix_precision(env, b);
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
        }
};

class subtract : public callable {
    public:
        ~subtract() { }

        atom call(std::shared_ptr<environment> env, atom_list args) override {
            detail::argno_either<1, 2>(location, "-", args);
            return make_atom(thunk([args, env]() mutable -> thunk_type {
                auto [a, b] = detail::get_args<2>(args, env);
                if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_INT) {
                    return thunk_type(a->get_integer() - b->get_integer());
                } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_INT) {
                    return thunk_type(a->get_real() - b->get_integer());
                }  else if(a->get_type() == atom_type::T_INT && b->get_type() == atom_type::T_REAL) {
                    return thunk_type(a->get_integer() - b->get_real());
                } else if(a->get_type() == atom_type::T_REAL && b->get_type() == atom_type::T_REAL) {
                    return thunk_type(a->get_real() - b->get_real());
                }
            }));
        }
};

}

#endif

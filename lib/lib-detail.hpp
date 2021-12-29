
#ifndef __LIB_DETAIL_HPP
#define __LIB_DETAIL_HPP

#include "../atom.hpp"
#include "../env.hpp"
#include "../list.hpp"
#include "../error.hpp"
#include "../executor.hpp"

#include <boost/math/special_functions.hpp>
#include <boost/algorithm/string/join.hpp>

#define define_repr(f, a...) [[gnu::flatten]] std::wstring f::repr() { a; }

namespace detail {
    template <std::size_t... sizes>
    inline void argno_either(const std::string & loc, const std::string & cause, atom_list & l) {
        const int x[] = { sizes... };
        for(std::size_t i : x)
            if(l.size() == i)
                return;
        const std::string s[] = { std::to_string(sizes)... };
        kl_error(
            loc + "invalid invocation to " + cause + " expected either "
          + boost::algorithm::join(s, ", ")
          + " arguments, got " + std::to_string(l.size()));
    }

    template <std::size_t size>
    inline void argno_more(const std::string & loc, const std::string & cause, atom_list & l) {
        if(l.size() <= size)
            kl_error(
                loc + "invalid invocation to " + cause + " expected at least "
              + std::to_string(size) + " arguments, got " + std::to_string(l.size()));
    }

    template <std::size_t size>
    inline void argno_exact(const std::string & loc, const std::string & cause, atom_list & l) {
        if(l.size() != size)
            kl_error(
                loc + "invalid invocation to " + cause + " expected "
              + std::to_string(size) + " arguments, got " + std::to_string(l.size()));
    }

    template <std::size_t size>
    inline void argno_less(const std::string & loc, const std::string & cause, atom_list & l) {
        if(l.size() >= size)
            kl_error(
                loc + "invalid invocation to " + cause + " expected at most "
              + std::to_string(size) + " arguments, got " + std::to_string(l.size()));
    }

    template <std::size_t lb, std::size_t hb>
    inline void argno_between(const std::string & loc, const std::string & cause, atom_list & l) {
        if(l.size() < lb || l.size() > hb)
            kl_error(
                loc + "invalid invocation to " + cause + " expected between "
              + std::to_string(lb) + " and " + std::to_string(hb) + " arguments, got "
              + std::to_string(l.size()));
    }

    template <std::size_t N, std::size_t M>
    inline std::array<atom, M - N> get_args(atom_list data, std::shared_ptr<environment> env, bool eval_args) {
        std::array<atom, M - N> r;
        if(eval_args) {
            for(std::size_t i = N; i < M; i++)
                { r[i] = evaluate(data.car(), env); data = data.cdr(); }
        } else {
            for(std::size_t i = N; i < M; i++)
                { r[i] = data.car(); data = data.cdr(); }
        }
        return r;
    }

    template <std::size_t N, std::size_t M>
    inline std::array<atom, M - N> get_args(atom_list data) {
        std::array<atom, M - N> r;
        for(std::size_t i = N; i < M; i++)
            { r[i] = data.car(); data = data.cdr(); }
        return r;
    }

    inline atom_list get_args(atom_list data, std::shared_ptr<environment> env, bool eval_args) {
        if(eval_args) {
            atom_list r { };
            for(; !data.is_empty(); data = data.cdr())
                r = r.unsafe_append(evaluate(data.car(), env));
            return r;
        } else {
            return data;
        }
    }

    [[noreturn]] inline void unsupported_args(const std::string & loc, const std::string & cause, atom_list l) {
        std::vector<std::string> names;
        for(auto & a : l)
            names.push_back(a->type_name());
        kl_error(loc + "invalid invocation to " + cause + ", arguments of types " + boost::algorithm::join(names, ", ") + " are outside of the domain.");
    }

    inline void fix_precision(std::shared_ptr<environment> env) {
        unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
        boost::multiprecision::mpf_float::default_precision(precision);
    }
}

#endif
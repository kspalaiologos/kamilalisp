
#ifndef _MATH_LIB_HPP
#define _MATH_LIB_HPP

#include "atom.hpp"
#include "env.hpp"
#include "list.hpp"
#include "error.hpp"
#include "executor.hpp"

#include <boost/math/special_functions.hpp>
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
    inline void argno_exact(const std::string & loc, const std::string & cause, atom_list & l) {
        if(l.size() != size)
            throw std::runtime_error(
                loc + "invalid invocation to " + cause + " expected "
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

    [[noreturn]] inline void unsupported_args(const std::string & loc, const std::string & cause, atom_list l) {
        std::vector<std::string> names;
        for(auto & a : l)
            names.push_back(a->type_name());
        throw std::runtime_error(
                loc + "invalid invocation to " + cause + ", arguments of types " + boost::algorithm::join(names, ", ") + " are outside of the domain.");
    }

    inline void fix_precision(std::shared_ptr<environment> env) {
        unsigned precision = env->get(L"fr")->get_integer().convert_to<unsigned>();
        boost::multiprecision::mpf_float::default_precision(precision);
    }
}

namespace mathlib {

class add : public callable {
    public:
        ~add() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class subtract : public callable {
    public:
        ~subtract() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class multiply : public callable {
    public:
        ~multiply() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class divide : public callable {
    public:
        ~divide() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class iota : public callable {
    public:
        ~iota() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class quote : public callable {
    public:
        ~quote() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class define : public callable {
    public:
        ~define() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class lambda : public callable {
    public:
        ~lambda() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

}

#endif

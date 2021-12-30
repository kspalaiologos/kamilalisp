
#ifndef _ATOM_HPP
#define _ATOM_HPP

#include <numeric>
#include <variant>
#include <string>
#include <memory>
#include <compare>
#include <functional>
#include <boost/multiprecision/gmp.hpp>
#include <boost/multiprecision/mpc.hpp>

#include "error.hpp"
#include "list.hpp"

class identifier {
    public:
        std::wstring value;
    public:
        identifier(std::wstring value) : value(value) { }

        operator std::wstring() {
            return std::wstring(value);
        }

        std::strong_ordering operator<=>(const identifier& other) const {
            return value <=> other.value;
        }

        bool operator==(const identifier& other) const {
            return value == other.value;
        }
};

class environment;
class atom_;

using atom = std::shared_ptr<atom_>;
using atom_list = list<atom>;

class callable : public std::enable_shared_from_this<callable> {
    public:
        virtual atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args = false) = 0;
        virtual std::wstring repr() {
            return L"callable/syn";
        }

        virtual std::tuple<atom_list, atom_list> requote() {
            kl_error("Can't requote.");
        }

        virtual ~callable() = 0;
};

enum class atom_type {
    T_INT, T_REAL, T_CMPLX, T_STR, T_LIST, T_CALLABLE, T_ID
};

/* Variant conversion proxy which casts a variant subset into a variant superset. */
template <class... Args>
struct variant_cast_proxy {
    std::variant<Args...> v;

    template <class... ToArgs>
    operator std::variant<ToArgs...>() const {
        return std::visit([](auto && arg) -> std::variant<ToArgs...> { return arg; }, v);
    }
};

template <class... Args>
auto variant_cast(const std::variant<Args...> & v) -> variant_cast_proxy<Args...> {
    return { v };
}

using thunk_type = std::variant<
        boost::multiprecision::mpz_int,
        boost::multiprecision::mpf_float,
        boost::multiprecision::mpc_complex,
        std::wstring,
        atom_list,
        std::shared_ptr<callable>,
        identifier>;

using thunk =
    std::function<thunk_type()>;

class atom_ {
    using data_type = std::variant<thunk,
        boost::multiprecision::mpz_int,
        boost::multiprecision::mpf_float,
        boost::multiprecision::mpc_complex,
        std::wstring,
        atom_list,
        std::shared_ptr<callable>,
        identifier>;

    private:
        mutable data_type value;

    public:
        /* Constructors */
        atom_(boost::multiprecision::mpz_int &);
        atom_(boost::multiprecision::mpf_float &);
        atom_(boost::multiprecision::mpc_complex &);
        atom_(boost::multiprecision::mpz_int &&);
        atom_(boost::multiprecision::mpf_float &&);
        atom_(boost::multiprecision::mpc_complex &&);
        atom_(std::wstring &);
        atom_(std::wstring &&);
        atom_(atom_list &);
        atom_(atom_list &&);
        atom_(identifier &);
        atom_(identifier &&);
        atom_(thunk &);
        atom_(thunk &&);
        atom_(std::shared_ptr<callable>);

        /* Accessors */
        boost::multiprecision::mpz_int get_integer() const;
        boost::multiprecision::mpf_float get_real() const;
        boost::multiprecision::mpc_complex get_complex() const;
        std::wstring get_string() const;
        atom_list get_list() const;
        identifier get_identifier() const;
        std::shared_ptr<callable> get_callable() const;

        /* Utility methods. */
        void force() const;
        std::wstring stringify() const;
        std::wstring stringify(unsigned) const;

        /* Casting to boolean. */
        bool coerce_bool() const;

        /* Type heuristics. */
        bool is_numeric() const;

        /* Total ordering. */
        bool operator==(const atom &) const;
        bool operator!=(const atom &) const;
        std::weak_ordering operator<=>(const atom &) const;

        /* Atom type. */
        atom_type get_type() const;
        std::string type_name() const;

        /* Converting to a thunk type. */
        thunk_type thunk_forward() const;
};

static atom null_atom = std::make_shared<atom_>(atom_list());
static atom atom_true = std::make_shared<atom_>(boost::multiprecision::mpz_int(1));
static atom atom_false = std::make_shared<atom_>(boost::multiprecision::mpz_int(0));

namespace std {
    std::wstring to_wstring(atom);

    template<>
    struct hash<atom> {
        size_t operator()(const atom & s) const {
            s->force();
            switch(s->get_type()) {
                case atom_type::T_INT:
                    return std::hash<boost::multiprecision::mpz_int>()(s->get_integer());
                case atom_type::T_REAL:
                    return std::hash<boost::multiprecision::mpf_float>()(s->get_real());
                case atom_type::T_CMPLX:
                    return std::hash<boost::multiprecision::mpfr_float>()(s->get_complex().real()) + std::hash<boost::multiprecision::mpfr_float>()(s->get_complex().imag());
                case atom_type::T_STR:
                    return std::hash<std::wstring>()(s->get_string());
                case atom_type::T_LIST: {
                    atom_list l = s->get_list();
                    return std::accumulate(l.begin(), l.end(), std::size_t(0),
                            [](std::size_t acc, atom a) {
                        return acc ^ std::hash<atom>()(a);
                    });
                }
                case atom_type::T_CALLABLE:
                    return (size_t) s->get_callable().get();
                case atom_type::T_ID:
                    return std::hash<std::wstring>()(s->get_identifier());
            }
        }
    };
}

#define make_atom std::make_shared<atom_>

// A macro for abbreviating plain callable definitions.
#define define_callable(name, ...) \
    class name : public callable { \
        public: \
            ~name() { } \
            atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args = false) override; \
            std::wstring repr() override; \
    };

#endif


#ifndef _ATOM_HPP
#define _ATOM_HPP

#include <variant>
#include <string>
#include <memory>
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

class callable {
    public:
        virtual atom call(std::shared_ptr<environment> env, atom_list args) = 0;
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
        data_type value;

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
        boost::multiprecision::mpz_int get_integer();
        boost::multiprecision::mpf_float get_real();
        boost::multiprecision::mpc_complex get_complex();
        std::wstring get_string();
        atom_list get_list();
        identifier get_identifier();
        std::shared_ptr<callable> get_callable();

        /* Utility methods. */
        void force();
        std::wstring stringify();
        std::wstring stringify(unsigned);

        /* Casting to boolean. */
        operator bool();

        /* Type heuristics. */
        bool is_numeric();

        /* Total ordering. */
        bool operator==(atom &);
        std::weak_ordering operator<=>(atom &);

        /* Atom type. */
        atom_type get_type();
        std::string type_name();

        /* Converting to a thunk type. */
        thunk_type thunk_forward();
};

static atom null_atom = std::make_shared<atom_>(atom_list());

namespace std {
    std::wstring to_wstring(atom);
}

#define make_atom std::make_shared<atom_>

#endif


#include <numeric>
#include <algorithm>
#include <type_traits>
#include "error.hpp"
#include "atom.hpp"

atom_::atom_(boost::multiprecision::mpz_int & n) {
    value = n;
}

atom_::atom_(boost::multiprecision::mpfr_float & n) {
    value = n;
}

atom_::atom_(boost::multiprecision::mpc_complex & n) {
    value = n;
}

atom_::atom_(boost::multiprecision::mpz_int && n) {
    value = n;
}

atom_::atom_(boost::multiprecision::mpfr_float && n) {
    value = n;
}

atom_::atom_(boost::multiprecision::mpc_complex && n) {
    value = n;
}

atom_::atom_(std::wstring & s) {
    value = s;
}

atom_::atom_(std::wstring && s) {
    value = s;
}

atom_::atom_(atom_list & l) {
    value = l;
}

atom_::atom_(atom_list && l) {
    value = l;
}

atom_::atom_(identifier & i) {
    value = i;
}

atom_::atom_(identifier && i) {
    value = i;
}

atom_::atom_(thunk & f) {
    value = f;
}

atom_::atom_(thunk && f) {
    value = f;
}

atom_::atom_(std::shared_ptr<callable> m) {
    value = m;
}

boost::multiprecision::mpz_int atom_::get_integer() {
    if(std::holds_alternative<boost::multiprecision::mpz_int>(value)) {
        return std::get<boost::multiprecision::mpz_int>(value);
    } else {
        kl_error("Not an integer");
    }
}

boost::multiprecision::mpfr_float atom_::get_real() {
    if(std::holds_alternative<boost::multiprecision::mpfr_float>(value)) {
        return std::get<boost::multiprecision::mpfr_float>(value);
    } else {
        kl_error("Not a real");
    }
}

boost::multiprecision::mpc_complex atom_::get_complex() {
    if(std::holds_alternative<boost::multiprecision::mpc_complex>(value)) {
        return std::get<boost::multiprecision::mpc_complex>(value);
    } else {
        kl_error("Not a real");
    }
}

std::wstring atom_::get_string() {
    if(std::holds_alternative<std::wstring>(value)) {
        return std::get<std::wstring>(value);
    } else {
        kl_error("Not a string");
    }
}

atom_list atom_::get_list() {
    if(std::holds_alternative<atom_list>(value)) {
        return std::get<atom_list>(value);
    } else {
        kl_error("Not a list");
    }
}

identifier atom_::get_identifier() {
    if(std::holds_alternative<identifier>(value)) {
        return std::get<identifier>(value);
    } else {
        kl_error("Not an identifier");
    }
}

std::shared_ptr<callable> atom_::get_callable() {
    if(std::holds_alternative<std::shared_ptr<callable>>(value)) {
        return std::get<std::shared_ptr<callable>>(value);
    } else {
        kl_error("Not a callable.");
    }
}

void atom_::force() {
    /* Note: The conversion between a normal data variant and a thunk result isn't
                possible implicitly, since a thunk can never return a thunk by design.
                A variant casting proxy that casts a subset of a variant to it's
                superset is used. */
    if (std::holds_alternative<thunk>(value))
        value = variant_cast(std::get<thunk>(value)());
}

atom_::operator bool() {
    force();
    return
        (std::holds_alternative<boost::multiprecision::mpz_int>(value) && std::get<boost::multiprecision::mpz_int>(value) != 0)
    ||  (std::holds_alternative<boost::multiprecision::mpfr_float>(value) && std::get<boost::multiprecision::mpfr_float>(value) != 0)
    ||  (std::holds_alternative<boost::multiprecision::mpc_complex>(value) && std::get<boost::multiprecision::mpc_complex>(value) != 0)
    ||  (std::holds_alternative<atom_list>(value) && !std::get<atom_list>(value).is_empty());
}

bool atom_::is_numeric() {
    force();
    return
        std::holds_alternative<boost::multiprecision::mpz_int>(value)
    ||  std::holds_alternative<boost::multiprecision::mpfr_float>(value)
    ||  std::holds_alternative<boost::multiprecision::mpc_complex>(value);
}

namespace std {
    std::wstring to_wstring(atom a) {
        return a->stringify();
    }
}

std::wstring to_wstring(std::string && s) {
    return std::wstring(s.begin(), s.end());
}

template<class> inline constexpr bool always_false_v = false;

std::wstring atom_::stringify() {
    force();
    switch(get_type()) {
        case atom_type::T_INT:
            return to_wstring(get_integer().str());
        case atom_type::T_REAL:
            return to_wstring(get_real().str());
        case atom_type::T_CMPLX: {
            auto c = get_complex();
            return to_wstring(c.real().str()) + L"J" + to_wstring(c.imag().str());
        } case atom_type::T_STR:
            return L"\"" + get_string() + L"\"";
        case atom_type::T_ID:
            return get_identifier();
        case atom_type::T_LIST: {
            std::wstring result = L"(";
            atom_list l = get_list();
            for(atom a : l) {
                result += a->stringify() + L" ";
            }
            if(result.size() != 1)
                result.pop_back();
            return result + L")";
        }
        case atom_type::T_CALLABLE:
            return get_callable()->repr();
        default:
            return L"??";
    }
}

bool atom_::operator==(atom & other) {
    force(); other->force();

    if(value.index() != other->value.index())
        return false;
    switch(get_type()) {
        case atom_type::T_INT:
            return std::get<boost::multiprecision::mpz_int>(value) == std::get<boost::multiprecision::mpz_int>(other->value);
        case atom_type::T_REAL:
            return std::get<boost::multiprecision::mpfr_float>(value) == std::get<boost::multiprecision::mpfr_float>(other->value);
        case atom_type::T_CMPLX:
            return std::get<boost::multiprecision::mpc_complex>(value) == std::get<boost::multiprecision::mpc_complex>(other->value);
        case atom_type::T_STR:
            return std::get<std::wstring>(value) == std::get<std::wstring>(other->value);
        case atom_type::T_LIST:
            return std::get<atom_list>(value) == std::get<atom_list>(other->value);
        case atom_type::T_CALLABLE:
            return false;
        case atom_type::T_ID:
            return std::get<identifier>(value) == std::get<identifier>(other->value);
    }

    return false;
}

std::weak_ordering atom_::operator<=>(atom & other) {
    force(); other->force();
    if(value.index() != other->value.index())
        return value.index() <=> other->value.index();
    switch(get_type()) {
        case atom_type::T_INT: {
            boost::multiprecision::mpz_int a = std::get<boost::multiprecision::mpz_int>(value);
            boost::multiprecision::mpz_int b = std::get<boost::multiprecision::mpz_int>(other->value);
            if(a < b) return std::weak_ordering::less;
            else if(a > b) return std::weak_ordering::greater;
            else return std::weak_ordering::equivalent;
        }
        case atom_type::T_REAL: {
            boost::multiprecision::mpfr_float a = std::get<boost::multiprecision::mpfr_float>(value);
            boost::multiprecision::mpfr_float b = std::get<boost::multiprecision::mpfr_float>(other->value);
            if(a < b) return std::weak_ordering::less;
            else if(a > b) return std::weak_ordering::greater;
            else return std::weak_ordering::equivalent;
        }
        case atom_type::T_CMPLX: {
            boost::multiprecision::mpc_complex a = std::get<boost::multiprecision::mpc_complex>(value);
            boost::multiprecision::mpc_complex b = std::get<boost::multiprecision::mpc_complex>(other->value);
            if(norm(a) < norm(b)) return std::weak_ordering::less;
            else if(norm(a) > norm(b)) return std::weak_ordering::greater;
            else return std::weak_ordering::equivalent;
        }
        case atom_type::T_STR:
            return std::get<std::wstring>(value) <=> std::get<std::wstring>(other->value);
        case atom_type::T_LIST: {
            atom_list a = std::get<atom_list>(value);
            atom_list b = std::get<atom_list>(other->value);
            if(a.size() < b.size()) return std::weak_ordering::less;
            else if(a.size() > b.size()) return std::weak_ordering::greater;
            else {
                atom_list::iterator begin = a.begin();
                atom_list::iterator begin2 = b.begin();
                while(begin != a.end() && begin2 != b.end()) {
                    std::weak_ordering o = (*begin) <=> (*begin2);
                    if(o != std::weak_ordering::equivalent)
                        return o;
                    ++begin; ++begin2;
                }
                return std::weak_ordering::equivalent;
            }
        }
        case atom_type::T_CALLABLE:
            return std::strong_ordering::equivalent;
        case atom_type::T_ID:
            return std::get<identifier>(value) <=> std::get<identifier>(other->value);
    }

    return std::strong_ordering::equivalent;
}

atom_type atom_::get_type() {
    force();
    switch(value.index()) {
        case 1: return atom_type::T_INT;
        case 2: return atom_type::T_REAL;
        case 3: return atom_type::T_CMPLX;
        case 4: return atom_type::T_STR;
        case 5: return atom_type::T_LIST;
        case 6: return atom_type::T_CALLABLE;
        case 7: return atom_type::T_ID;
    }
    kl_error("Unknown data type.");
}

namespace std {
    template<>
    struct hash<atom> {
        std::size_t operator()(atom & s) {
            s->force();
            switch(s->get_type()) {
                case atom_type::T_INT:
                    return std::hash<boost::multiprecision::mpz_int>()(s->get_integer());
                case atom_type::T_REAL:
                    return std::hash<boost::multiprecision::mpfr_float>()(s->get_real());
                case atom_type::T_CMPLX:
                    return std::hash<boost::multiprecision::mpc_complex>()(s->get_complex());
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

std::string atom_::type_name() {
    force(); switch(get_type()) {
        case atom_type::T_CALLABLE: return "callable";
        case atom_type::T_CMPLX: return "complex";
        case atom_type::T_INT: return "integer";
        case atom_type::T_LIST: return "list";
        case atom_type::T_REAL: return "real";
        case atom_type::T_STR: return "string";
        case atom_type::T_ID: return "identifier";
    }
    
    return "??";
}

callable::~callable() { }

thunk_type atom_::thunk_forward() {
    force();
    switch(get_type()) {
        case atom_type::T_INT: return get_integer();
        case atom_type::T_REAL: return get_real();
        case atom_type::T_CMPLX: return get_complex();
        case atom_type::T_STR: return get_string();
        case atom_type::T_LIST: return get_list();
        case atom_type::T_CALLABLE: return get_callable();
        case atom_type::T_ID: return get_identifier();
    }
}

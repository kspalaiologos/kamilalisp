
#include "list-lib.hpp"
#include "lib-detail.hpp"
#include <boost/multiprecision/miller_rabin.hpp>

namespace bmp = boost::multiprecision;

namespace listlib {

[[gnu::flatten]] atom car::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "car", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_LIST)
            return a->thunk_forward();
        return a->get_list().car()->thunk_forward();
    }));
}

define_repr(car, return L"built-in function `car'");

[[gnu::flatten]] atom cdr::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "cdr", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_LIST)
            detail::unsupported_args(src_location, "cdr", args);
        if(a->get_list().is_empty())
            return null_atom->thunk_forward();
        return a->get_list().cdr();
    }));
}

define_repr(cdr, return L"built-in function `cdr'");

[[gnu::flatten]] atom middle::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "middle", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
        if(a->get_type() != atom_type::T_INT && b->get_type() != atom_type::T_LIST)
            detail::unsupported_args(src_location, "middle", args);
        
        long n = a->get_integer().convert_to<long>();
        if(n == 0)
            return null_atom->thunk_forward();
        else if(n < 0) {
            // Pick elements from the outer sides.
            atom_list l = b->get_list();
            if(l.size() < (std::size_t) -n)
                return null_atom->thunk_forward();
            // take first -n elements, take last -n elements.
            atom_list r { };
            for(long i = 0; i < -n; ++i) {
                r.push_back(l.car());
                l = l.cdr();
            }
            // skip a few elements so that the length of the list is n.
            while(l.size() > (std::size_t) -n)
                l = l.cdr();
            // take the rest.
            r = r.unsafe_append(l);
            return r;
        } else if(n > 0) {
            // Pick elements from the middle.
            // ~~ Examples ~~
            // Even n, even size  -  2, '(0 1 2 3 4 5) => (1 2 3 4)
            // Even n, odd size   -  2, '(0 1 2 3 4 5 6) => (2 3 4)
            // Odd n, even size   -  1, '(0 1 2 3 4 5) => (2 3)
            // Odd n, odd size    -  1, '(0 1 2 3 4 5 6) => (3)
            // ~~~~
            // The parity of n is insignificant and was provided for
            // demonstrational purposes.
            atom_list l = b->get_list();
            unsigned len = l.size();
            bool even_size = len % 2 == 0;
            if(even_size) {
                // Extract 2n numbers from the middle.
                if(len < 2 * n)
                    return null_atom->thunk_forward();
                atom_list r { };
                for(unsigned i = 0; i < (len - 2 * n) / 2; i++)
                    l = l.cdr();
                for(unsigned i = 0; i < 2 * n; i++) {
                    r.push_back(l.car());
                    l = l.cdr();
                }
                return r;
            } else {
                // Extract 2n-1 numbers from the middle.
                if(len < 2 * n - 1)
                    return null_atom->thunk_forward();
                atom_list r { };
                for(unsigned i = 0; i < (len - 2 * n + 1) / 2; i++)
                    l = l.cdr();
                for(unsigned i = 0; i < 2 * n - 1; i++) {
                    r.push_back(l.car());
                    l = l.cdr();
                }
                return r;
            }
        }

        __builtin_unreachable();
    }));
}

define_repr(middle, return L"built-in function `middle'");

}

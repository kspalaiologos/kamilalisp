
#include "fold-lib.hpp"
#include "lib-detail.hpp"

#include <boost/range/algorithm.hpp>

namespace bmp = boost::multiprecision;

#include <vector>

namespace foldlib {

[[gnu::flatten]] atom foldl::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<2, 3>(src_location, "foldl", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 3) {
            // foldl
            auto [a_f, id, a_l] = detail::get_args<0, 3>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "foldl", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list();

            if(l.is_empty())
                return id->thunk_forward();
            else if(l.size() == 1)
                return apply(f, env, atom_list::from({ id, l.car() }))->thunk_forward();
            else {
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ id, l.car() }));
                    l = l.cdr();
                }
                return id->thunk_forward();
            }
        } else if(args.size() == 2) {
            // foldl1
            auto [a_f, a_l] = detail::get_args<0, 2>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "foldl", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list();

            if(l.is_empty())
                kl_error("foldl: empty list and no identity element.");
            else if(l.size() == 1)
                return l.car()->thunk_forward();
            else {
                atom id = l.car();
                l = l.cdr();
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ id, l.car() }));
                    l = l.cdr();
                }
                return id->thunk_forward();
            }
        }

        __builtin_unreachable();
    }));
}

define_repr(foldl, return L"built-in function `foldl'")

[[gnu::flatten]] atom foldr::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<2, 3>(src_location, "foldr", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 3) {
            // foldr
            auto [a_f, id, a_l] = detail::get_args<0, 3>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "foldr", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list().reverse();

            if(l.is_empty())
                return id->thunk_forward();
            else if(l.size() == 1)
                return apply(f, env, atom_list::from({ l.car(), id }))->thunk_forward();
            else {
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ l.car(), id }));
                    l = l.cdr();
                }
                return id->thunk_forward();
            }
        } else if(args.size() == 2) {
            // foldr1
            auto [a_f, a_l] = detail::get_args<0, 2>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "foldr", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list().reverse();

            if(l.is_empty())
                kl_error("foldr: empty list and no identity element.");
            else if(l.size() == 1)
                return l.car()->thunk_forward();
            else {
                atom id = l.car();
                l = l.cdr();
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ l.car(), id }));
                    l = l.cdr();
                }
                return id->thunk_forward();
            }
        }

        __builtin_unreachable();
    }));
}

define_repr(foldr, return L"built-in function `foldr'")

[[gnu::flatten]] atom foldl1::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<2, 3>(src_location, "foldl1", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 3) {
            // foldl1
            auto [a_f, id, a_l] = detail::get_args<0, 3>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "foldl1", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list();

            if(l.is_empty())
                return id->thunk_forward();
            else if(l.size() == 1)
                return apply(f, env, atom_list::from({ id, l.car() }))->thunk_forward();
            else {
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ id, l.car() }));
                    id->force();
                    l = l.cdr();
                }
                return id->thunk_forward();
            }
        } else if(args.size() == 2) {
            // foldl11
            auto [a_f, a_l] = detail::get_args<0, 2>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "foldl1", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list();

            if(l.is_empty())
                kl_error("foldl1: empty list and no identity element.");
            else if(l.size() == 1)
                return l.car()->thunk_forward();
            else {
                atom id = l.car();
                l = l.cdr();
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ id, l.car() }));
                    id->force();
                    l = l.cdr();
                }
                return id->thunk_forward();
            }
        }

        __builtin_unreachable();
    }));
}

define_repr(foldl1, return L"built-in function `foldl1'")

[[gnu::flatten]] atom foldr1::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<2, 3>(src_location, "foldr1", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 3) {
            // foldr1
            auto [a_f, id, a_l] = detail::get_args<0, 3>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "foldr1", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list().reverse();

            if(l.is_empty())
                return id->thunk_forward();
            else if(l.size() == 1)
                return apply(f, env, atom_list::from({ l.car(), id }))->thunk_forward();
            else {
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ l.car(), id }));
                    id->force();
                    l = l.cdr();
                }
                return id->thunk_forward();
            }
        } else if(args.size() == 2) {
            // foldr11
            auto [a_f, a_l] = detail::get_args<0, 2>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "foldr1", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list().reverse();

            if(l.is_empty())
                kl_error("foldr1: empty list and no identity element.");
            else if(l.size() == 1)
                return l.car()->thunk_forward();
            else {
                atom id = l.car();
                l = l.cdr();
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ l.car(), id }));
                    id->force();
                    l = l.cdr();
                }
                return id->thunk_forward();
            }
        }

        __builtin_unreachable();
    }));
}

define_repr(foldr1, return L"built-in function `foldr1'")

[[gnu::flatten]] atom scanl::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<2, 3>(src_location, "scanl", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 3) {
            // scanl
            auto [a_f, id, a_l] = detail::get_args<0, 3>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "scanl", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list();

            if(l.is_empty())
                return atom_list::from({ id });
            else if(l.size() == 1)
                return atom_list::from({ apply(f, env, atom_list::from({ id, l.car() })) });
            else {
                atom_list r { };
                r.push_back(id);
                while(!l.is_empty()) {
                    r.push_back(id = apply(f, env, atom_list::from({ id, l.car() })));
                    l = l.cdr();
                }
                return r;
            }
        } else if(args.size() == 2) {
            // scanl1
            auto [a_f, a_l] = detail::get_args<0, 2>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "scanl", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list();

            if(l.is_empty())
                kl_error("scanl: empty list and no identity element.");
            else if(l.size() == 1)
                return atom_list::from({ l.car() });
            else {
                atom_list r { };
                atom id = l.car();
                r.push_back(id);
                l = l.cdr();
                while(!l.is_empty()) {
                    r.push_back(id = apply(f, env, atom_list::from({ id, l.car() })));
                    l = l.cdr();
                }
                return r;
            }
        }

        __builtin_unreachable();
    }));
}

define_repr(scanl, return L"built-in function `scanl'")

[[gnu::flatten]] atom scanr::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<2, 3>(src_location, "scanr", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 3) {
            // scanr
            auto [a_f, id, a_l] = detail::get_args<0, 3>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "scanr", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list().reverse();

            if(l.is_empty())
                return atom_list::from({ id });
            else if(l.size() == 1)
                return atom_list::from({ apply(f, env, atom_list::from({ l.car(), id })) });
            else {
                atom_list r { };
                r.push_back(id);
                while(!l.is_empty()) {
                    r.push_back(id = apply(f, env, atom_list::from({ l.car(), id })));
                    l = l.cdr();
                }
                return r;
            }
        } else if(args.size() == 2) {
            // scanr1
            auto [a_f, a_l] = detail::get_args<0, 2>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "scanr", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list().reverse();

            if(l.is_empty())
                kl_error("scanr: empty list and no identity element.");
            else if(l.size() == 1)
                return atom_list::from({ l.car() });
            else {
                atom_list r { };
                atom id = l.car();
                r.push_back(id);
                l = l.cdr();
                while(!l.is_empty()) {
                    r.push_back(id = apply(f, env, atom_list::from({ l.car(), id })));
                    l = l.cdr();
                }
                return r;
            }
        }

        __builtin_unreachable();
    }));
}

define_repr(scanr, return L"built-in function `scanr'")

[[gnu::flatten]] atom scanl1::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<2, 3>(src_location, "scanl1", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 3) {
            // scanl1
            auto [a_f, id, a_l] = detail::get_args<0, 3>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "scanl1", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list();

            if(l.is_empty())
                return atom_list::from({ id });
            else if(l.size() == 1)
                return atom_list::from({ apply(f, env, atom_list::from({ id, l.car() })) });
            else {
                atom_list r { };
                r.push_back(id);
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ id, l.car() }));
                    id->force();
                    r.push_back(id);
                    l = l.cdr();
                }
                return r;
            }
        } else if(args.size() == 2) {
            // scanl11
            auto [a_f, a_l] = detail::get_args<0, 2>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "scanl1", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list();

            if(l.is_empty())
                kl_error("scanl1: empty list and no identity element.");
            else if(l.size() == 1)
                return atom_list::from({ l.car() });
            else {
                atom id = l.car();
                atom_list r { };
                r.push_back(id);
                l = l.cdr();
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ id, l.car() }));
                    id->force();
                    r.push_back(id);
                    l = l.cdr();
                }
                return r;
            }
        }

        __builtin_unreachable();
    }));
}

define_repr(scanl1, return L"built-in function `scanl1'")

[[gnu::flatten]] atom scanr1::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_either<2, 3>(src_location, "scanr1", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        if(args.size() == 3) {
            // scanr1
            auto [a_f, id, a_l] = detail::get_args<0, 3>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "scanr1", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list().reverse();

            if(l.is_empty())
                return atom_list::from({ id });
            else if(l.size() == 1)
                return atom_list::from({ apply(f, env, atom_list::from({ l.car(), id })) });
            else {
                atom_list r { };
                r.push_back(id);
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ l.car(), id }));
                    id->force();
                    r.push_back(id);
                    l = l.cdr();
                }
                return r;
            }
        } else if(args.size() == 2) {
            // scanr11
            auto [a_f, a_l] = detail::get_args<0, 2>(args, env, eval_args);
            if(a_f->get_type() != atom_type::T_CALLABLE || a_l->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "scanr1", args);
            
            std::shared_ptr<callable> f = a_f->get_callable();
            atom_list l = a_l->get_list().reverse();

            if(l.is_empty())
                kl_error("scanr1: empty list and no identity element.");
            else if(l.size() == 1)
                return atom_list::from({ l.car() });
            else {
                atom id = l.car();
                atom_list r { };
                r.push_back(id);
                l = l.cdr();
                while(!l.is_empty()) {
                    id = apply(f, env, atom_list::from({ l.car(), id }));
                    id->force();
                    r.push_back(id);
                    l = l.cdr();
                }
                return r;
            }
        }

        __builtin_unreachable();
    }));
}

define_repr(scanr1, return L"built-in function `scanr1'")

}

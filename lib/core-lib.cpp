
#include "core-lib.hpp"
#include "lib-detail.hpp"
#include <fstream>
#include <unordered_map>
#include "../reader/parser.hpp"
#include "../atom.hpp"
#include <chrono>
#include <iostream>
#include <iomanip>

namespace bmp = boost::multiprecision;

namespace corelib {

[[gnu::flatten]] atom lambda::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args; // Unused: invoking a macro.
    detail::argno_exact<2>(src_location, "lambda", args);
    auto [a, code_arg] = detail::get_args<0, 2>(args);
    if(a->get_type() != atom_type::T_LIST)
        detail::unsupported_args(src_location, "lambda", args);
    atom_list params = a->get_list();
    for(auto & x : params)
        if(x->get_type() != atom_type::T_ID)
            detail::unsupported_args(src_location, "lambda parameter list", args);
    auto code = code_arg;
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, params, code, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        atom_list l = params.reverse(); atom_list l_view = l; std::size_t n = 0;
        while(!l.is_empty() && l.car()->get_identifier().value.starts_with(L"?"))
            l = l.cdr(), n++;
        // Check if there are any misplaced optional arguments.
        std::size_t m = 0;
        for(auto & x : l_view)
            if(x->get_identifier().value.starts_with(L"?"))
                m++;
        if(m != n)
            kl_error("misplaced optional lambda argument in parameter list");

        class this_lambda : public callable {
            private:
                atom_list params;
                atom code;
                std::weak_ptr<environment> e;
                std::size_t n;
                atom_list l_view;
                std::optional<std::wstring> cached_repr;

            public:
                this_lambda(atom_list params, atom code, std::weak_ptr<environment> e, std::size_t n, atom_list l_view)
                    : params(params), code(code), e(e), n(n), l_view(l_view) { }
                ~this_lambda() { }

                std::tuple<atom, atom> requote() override {
                    return std::make_tuple(make_atom(params), code);
                }

                std::wstring repr() override {
                    if(cached_repr.has_value())
                        return *cached_repr;
                    std::wstring s_params = L"";
                    for(auto & x : params)
                        s_params += x->get_identifier().value + L" ";
                    if(s_params.size() > 0) { s_params.pop_back(); }
                    else { s_params = L"()"; }
                    cached_repr = L"(λ " + s_params + L" . " + std::to_wstring(code) + L")";
                    return *cached_repr;
                }

                atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args) override {
                    stacktrace_guard{ repr() };
                    (void) env; // The caller's environment is unnecessary.
                    std::shared_ptr<environment> descEnv = std::make_shared<environment>(e.lock(), shared_from_this());
                    args = detail::get_args(args, env, eval_args);
                    // Process normal arguments.
                    if(args.size() > params.size() || args.size() < params.size() - n)
                        kl_error("Invalid invocation to a lambda expression. Unexpected amount of arguments.");
                    if(args.size() > n) {
                        atom_list params_view = params, args_view = args;
                        for(std::size_t i = 0; i < args.size() - n; i++) {
                            descEnv->set(params_view.car()->get_identifier().value, args_view.car());
                            params_view = params_view.cdr();
                            args_view = args_view.cdr();
                        }
                    }
                    // Process optional arguments.
                    // We have to iterate from the back.
                    atom_list arg = args.reverse();
                    for(std::size_t i = 0; i < n; i++) {
                        std::wstring name = l_view.car()->get_identifier().value.substr(1);
                        l_view = l_view.cdr();
                        if(i + params.size() - n < args.size()) {
                            descEnv->set(name, arg.car());
                            arg = arg.cdr();
                        } else {
                            descEnv->set(name, null_atom);
                        }
                    }
                    return evaluate(code, descEnv);
                }
        };

        return std::make_shared<this_lambda>(params, code, env, n, l_view);
    }));
}

define_repr(lambda, return L"built-in function `lambda'")

[[gnu::flatten]] atom macro::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args; // Unused: invoking a macro.
    std::wstring repr = this->repr();
    detail::argno_exact<2>(src_location, "macro", args);
    auto [a, code_arg] = detail::get_args<0, 2>(args);
    if(a->get_type() != atom_type::T_LIST)
        detail::unsupported_args(src_location, "macro", args);
    atom_list params = a->get_list();
    for(auto & x : params)
        if(x->get_type() != atom_type::T_ID)
            detail::unsupported_args(src_location, "macro parameter list", args);
    auto code = code_arg;
    return make_atom(thunk([repr, params, code, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        // Process optional arguments.
        atom_list l = params.reverse(); atom_list l_view = l; std::size_t n = 0;
        while(!l.is_empty() && l.car()->get_identifier().value.starts_with(L"?"))
            l = l.cdr(), n++;
        // Check if there are any misplaced optional arguments.
        std::size_t m = 0;
        for(auto & x : l_view)
            if(x->get_identifier().value.starts_with(L"?"))
                m++;
        if(m != n)
            kl_error("misplaced optional macro argument in parameter list");

        class this_macro : public callable {
            private:
                atom_list params;
                atom code;
                std::weak_ptr<environment> e;
                std::size_t n;
                atom_list l_view;
                std::optional<std::wstring> cached_repr;

            public:
                this_macro(atom_list params, atom code, std::weak_ptr<environment> e, std::size_t n, atom_list l_view)
                    : params(params), code(code), e(e), n(n), l_view(l_view) { }
                ~this_macro() { }

                std::tuple<atom, atom> requote() override {
                    return std::make_tuple(make_atom(params), code);
                }

                std::wstring repr() override {
                    if(cached_repr.has_value())
                        return *cached_repr;
                    std::wstring s_params = L"";
                    for(auto & x : params)
                        s_params += x->get_identifier().value + L" ";
                    if(s_params.size() > 0) { s_params.pop_back(); }
                    else { s_params = L"()"; }
                    cached_repr = L"(μ " + s_params + L" . " + std::to_wstring(code) + L")";
                    return *cached_repr;
                }

                atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args) override {
                    stacktrace_guard{ repr() };
                    (void) env; // The caller's environment is unnecessary.
                    (void) eval_args; // Unused: invoking a macro.
                    std::shared_ptr<environment> descEnv = std::make_shared<environment>(e.lock(), shared_from_this());
                    // Process normal arguments.
                    if(args.size() > params.size() || args.size() < params.size() - n)
                        kl_error("Invalid invocation to a macro. Unexpected amount of arguments.");
                    atom_list params_view = params, args_view = args;
                    if(args.size() > n) {
                        for(std::size_t i = 0; i < args.size() - n; i++) {
                            descEnv->set(params_view.car()->get_identifier().value, args_view.car());
                            params_view = params_view.cdr();
                            args_view = args_view.cdr();
                        }
                    }
                    // Process optional arguments.
                    // We have to iterate from the back.
                    atom_list arg = args.reverse();
                    for(std::size_t i = 0; i < n; i++) {
                        std::wstring name = l_view.car()->get_identifier().value.substr(1);
                        if(i + params.size() - n < args.size()) {
                            descEnv->set(name, arg.car());
                            arg = arg.cdr();
                        } else {
                            descEnv->set(name, null_atom);
                        }
                    }
                    return evaluate(code, descEnv);
                }
        };

        return std::make_shared<this_macro>(params, code, env, n, l_view);
    }));
}

define_repr(macro, return L"built-in function `macro'")

[[gnu::flatten]] atom define::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    detail::argno_exact<2>(src_location, "def", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a, b] = detail::get_args<0, 2>(args);
        b = evaluate(b, env);
        if(a->get_type() != atom_type::T_ID)
            detail::unsupported_args(src_location, "def", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        env->set(a->get_identifier(), b);
        detail::fix_precision(env);
        return b->thunk_forward();
    }));
}

define_repr(define, return L"built-in function `def'")

[[gnu::flatten]] atom atop::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_more<1>(src_location, "atop", args);

    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        atom_list e_args = detail::get_args(args, env, eval_args);
        std::wstring repr = L"";
        for(auto & x : args)
            repr += std::to_wstring(x) + L"@";
        if(repr.size() > 0) { repr.pop_back(); }

        class this_atop : public callable {
            private:
                atom_list args;
                std::wstring repr_string;

            public:
                this_atop(atom_list args, std::wstring && repr_string)
                    : args(args), repr_string(std::move(repr_string)) { }
                ~this_atop() { }

                std::wstring repr() override {
                    return repr_string;
                }

                atom call(std::shared_ptr<environment> innerEnv, atom_list innerArgs, bool eval_args) override {
                    atom_list components = this->args;
                    std::wstring repr = this->repr();
                    return make_atom(thunk([repr, innerEnv, innerArgs, components, eval_args]() mutable -> thunk_type {
                        stacktrace_guard g{ repr };
                        auto x = apply(components.car()->get_callable(), innerEnv, detail::get_args(innerArgs, innerEnv, eval_args));
                        components = components.cdr();
                        while(!components.is_empty()) {
                            x = apply(components.car()->get_callable(), innerEnv, atom_list::from(x));
                            components = components.cdr();
                        }
                        return x->thunk_forward();
                    }));
                }
        };

        return std::make_shared<this_atop>(e_args, std::move(repr));
    }));
}

define_repr(atop, return L"@-combinator: built-in function `atop'")

[[gnu::flatten]] atom fork::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_more<1>(src_location, "fork", args);

    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        atom_list e_args = detail::get_args(args, env, eval_args);
        std::wstring repr = L"";
        for(auto & x : args)
            repr += std::to_wstring(x) + L" ";
        if(repr.size() > 0) { repr.pop_back(); }
        
        class this_fork : public callable {
            private:
                atom_list args;
                std::wstring repr_string;

            public:
                this_fork(atom_list args, std::wstring && repr_string)
                    : args(args), repr_string(std::move(repr_string)) { }
                ~this_fork() { }

                std::wstring repr() override {
                    return repr_string;
                }

                atom call(std::shared_ptr<environment> innerEnv, atom_list innerArgs, bool eval_args) override {
                    atom_list components = this->args;
                    std::wstring repr = this->repr();
                    return make_atom(thunk([repr, innerEnv, innerArgs, components, eval_args]() mutable -> thunk_type {
                        stacktrace_guard g{ repr };
                        // #(f g h) <=> (f (g ...) (h ...))
                        // #(f g) <=> (f (g ...))
                        atom first = components.car();
                        atom_list e_args = detail::get_args(innerArgs, innerEnv, eval_args);
                        atom_list args { };
                        for(atom_list rest = components.cdr(); !rest.is_empty(); rest = rest.cdr())
                            args = args.unsafe_append(apply(rest.car()->get_callable(), innerEnv, e_args));
                        return apply(first->get_callable(), innerEnv, args)->thunk_forward();
                    }));
                }
        };

        return std::make_shared<this_fork>(e_args, L"#(" + repr + L")");
    }));
}

define_repr(fork, return L"#-combinator: built-in function `fork'")

[[gnu::flatten]] atom bind::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_more<1>(src_location, "bind", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        std::wstring repr = L"";
        for(auto & x : args)
            repr += std::to_wstring(x) + L" ";
        if(repr.size() > 0) { repr.pop_back(); }

        auto [f] = detail::get_args<0, 1>(args, env, eval_args);
        args = args.cdr();

        if(f->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(src_location, "bind", args);
        
        atom_list e_args { };
        for(auto & x : args)
            if((x->get_type() == atom_type::T_ID && x->get_identifier() == identifier(L"_")) || eval_args == false)
                e_args = e_args.unsafe_append(x);
            else
                e_args = e_args.unsafe_append(evaluate(x, env));

        class this_bind : public callable {
            private:
                atom_list args;
                std::shared_ptr<callable> f;
                std::weak_ptr<environment> parent_env;
                std::wstring repr_string;

            public:
                this_bind(atom_list args, std::shared_ptr<callable> f, std::weak_ptr<environment> parent_env, std::wstring && repr_string)
                    : args(args), f(f), parent_env(parent_env), repr_string(std::move(repr_string)) { }
                ~this_bind() { }

                std::wstring repr() override {
                    return repr_string;
                }

                atom call(std::shared_ptr<environment> innerEnv, atom_list innerArgs, bool eval_args) override {
                    atom_list components = this->args;
                    (void) innerEnv;
                    std::shared_ptr<callable> f = this->f;
                    std::weak_ptr<environment> parent_env = this->parent_env;
                    return make_atom(thunk([innerArgs, components, parent_env, f, eval_args]() mutable -> thunk_type {
                        unsigned consumed = 0;
                        atom_list newArgs { };
                        for(atom_list rest = components; !rest.is_empty(); rest = rest.cdr()) {
                            atom a = rest.car();
                            if(a->get_type() == atom_type::T_ID && a->get_identifier() == identifier(L"_")) {
                                consumed++;
                                newArgs = newArgs.unsafe_append(innerArgs.car());
                                innerArgs = innerArgs.cdr();
                            } else {
                                newArgs = newArgs.unsafe_append(a);
                            }
                        }
                        newArgs = newArgs.unsafe_append(innerArgs);
                        return apply(f, parent_env.lock(), newArgs, eval_args)->thunk_forward();
                    }));
                }
        };

        return std::make_shared<this_bind>(e_args, f->get_callable(), env, L"$(" + repr + L")");
    }));
}

define_repr(bind, return L"$-combinator: built-in function `bind'")

[[gnu::flatten]] atom tie::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        atom_list r = detail::get_args(args, env, eval_args);
        return r;
    }));
}

define_repr(tie, return L"built-in function `tie'")

[[gnu::flatten]] atom defun::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    auto generator = this->gen;
    detail::argno_exact<3>(src_location, "defun", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, generator, args, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [name, params, code] = detail::get_args<0, 3>(args);
        if(name->get_type() != atom_type::T_ID)
            detail::unsupported_args(src_location, "defun", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        auto fn = apply(generator, env, atom_list::from(code).cons(params));
        env->set(name->get_identifier(), fn);
        return fn->thunk_forward();
    }));
}

define_repr(defun, return L"built-in function `defun'")

[[gnu::flatten]] atom monad::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    stacktrace_guard{ repr() };
    auto generator = this->gen;
    detail::argno_exact<1>(src_location, "monad", args);
    auto [code] = detail::get_args<0, 1>(args);
    auto fn = apply(generator, env, atom_list::from(code).cons(make_atom(atom_list::from(make_atom(identifier(L"x"))))));
    return fn;
}

define_repr(monad, return L"built-in function `monad'")

[[gnu::flatten]] atom dyad::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    stacktrace_guard{ repr() };
    auto generator = this->gen;
    detail::argno_exact<1>(src_location, "dyad", args);
    auto [code] = detail::get_args<0, 1>(args);
    auto fn = apply(generator, env, atom_list::from(code).cons(make_atom(atom_list::from(make_atom(identifier(L"y"))).cons(make_atom(identifier(L"x"))))));
    return fn;
}

define_repr(dyad, return L"built-in function `dyad'")

[[gnu::flatten]] atom defm::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    auto generator = this->gen;
    detail::argno_exact<3>(src_location, "defm", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, generator, args, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [name, params, code] = detail::get_args<0, 3>(args);
        if(name->get_type() != atom_type::T_ID)
            detail::unsupported_args(src_location, "defm", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        auto fn = apply(generator, env, atom_list::from(code).cons(params));
        env->set(name->get_identifier(), fn);
        return fn->thunk_forward();
    }));
}

define_repr(defm, return L"built-in function `defm'")

[[gnu::flatten]] atom quote::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    stacktrace_guard{ repr() };
    (void) env; // The caller's environment is unnecessary.
    (void) eval_args;
    detail::argno_exact<1>(src_location, "quote", args);
    return args.car();
}

define_repr(quote, return L"'-combinator: built-in function `quote'")

[[gnu::flatten]] atom bruijn::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    stacktrace_guard{ repr() };
    detail::argno_exact<1>(src_location, "bruijn", args);
    auto [a] = detail::get_args<0, 1>(args, env, eval_args);
    if(a->get_type() != atom_type::T_INT)
        detail::unsupported_args(src_location, "bruijn", args);
    unsigned depth = a->get_integer().convert_to<unsigned>();
    for(unsigned i = 0; i < depth; i++) {
        if(env->ancestor == nullptr)
            kl_error("de Bruijn index out of bounds");
        if(env->owner == nullptr)
            i--;
        env = env->ancestor;
    }
    if(env->owner == nullptr)
        kl_error("de Bruijn index does not point to an environment with an owner");
    return make_atom(env->owner);
}

define_repr(bruijn, return L"built-in function `bruijn'")

[[gnu::flatten]] atom kl_if::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    detail::argno_exact<3>(src_location, "if", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [c, t, f] = detail::get_args<0, 3>(args);
        c = evaluate(c, env);
        if(c->coerce_bool())
            return evaluate(t, env)->thunk_forward();
        else
            return evaluate(f, env)->thunk_forward();
    }));
}

define_repr(kl_if, return L"built-in function `if'")

[[gnu::flatten]] atom cond::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    detail::argno_more<1>(src_location, "cond", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        for(auto & a : args) {
            if(a->get_type() != atom_type::T_LIST)
                a = evaluate(a, env);
            if(a->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "cond", args);
            atom_list l = a->get_list();
            if(l.size() != 1 && l.size() != 2)
                detail::unsupported_args(src_location, "cond binding list", args);
            if(l.size() == 1)
                return evaluate(l.car(), env)->thunk_forward();
            if(evaluate(l.car(), env)->coerce_bool())
                return evaluate(l.cdr().car(), env)->thunk_forward();
        }
        kl_error("unexhaustive cond.");
    }));
}

define_repr(cond, return L"built-in function `cond'")

[[gnu::flatten]] atom map::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_more<1>(src_location, "map", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto c = eval_args ? evaluate(args.car(), env) : args.car(); args = args.cdr();
        if(c->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(src_location, "map", args);
        auto fn = c->get_callable();
        if(args.size() == 1) {
            auto arg = eval_args ? evaluate(args.car(), env) : args.car();
            if(arg->get_type() == atom_type::T_LIST) {
                atom_list r { };
                for(auto & a : arg->get_list())
                    r = r.unsafe_append(apply(fn, env, atom_list::from(a)));
                return r;
            } else {
                return apply(fn, env, atom_list::from(arg))->thunk_forward();
            }
        } else {
            unsigned min_width = 0;
            atom_list r { };
            for(auto & a : args) {
                auto arg = eval_args ? evaluate(a, env) : a;
                r = r.unsafe_append(arg);
                if(arg->get_type() != atom_type::T_LIST)
                    detail::unsupported_args(src_location, "map", args);
                if(min_width == 0)
                    min_width = arg->get_list().size();
                else if(arg->get_list().size() < min_width)
                    min_width = arg->get_list().size();
            }
            atom_list transposed { };
            for(unsigned i = 0; i < min_width; i++) {
                atom_list row { };
                for(auto & a : r) {
                    row = row.unsafe_append(a->get_list().car());
                    a->get_list() = a->get_list().cdr();
                }
                transposed = transposed.unsafe_append(apply(fn, env, row));
            }
            return transposed;
        }
    }));
}

define_repr(map, return L":-combinator: built-in function `map'")

[[gnu::flatten]] atom flatmap::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "flat-map", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto c = eval_args ? evaluate(args.car(), env) : args.car(); args = args.cdr();
        if(c->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(src_location, "flat-map", args);
        auto fn = c->get_callable();
        auto arg = eval_args ? evaluate(args.car(), env) : args.car();
        if(arg->get_type() == atom_type::T_LIST) {
            atom_list r { };
            for(auto & a : arg->get_list()) {
                atom q = apply(fn, env, atom_list::from(a));
                if(q->get_type() == atom_type::T_LIST) {
                    // Automatically move a list if it's not used anywhere else...
                    // "Premature optimization."
                    if(q.use_count() == 1)
                        r = r.unsafe_append(q->get_list());
                    else
                        r = r.unsafe_append(q->get_list().clone());
                } else {
                    r = r.unsafe_append(q);
                }
            }
            return r;
        } else {
            return apply(fn, env, atom_list::from(arg))->thunk_forward();
        }
    }));
}

define_repr(flatmap, return L"built-in function `flat-map'")

[[gnu::flatten]] atom flatten::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "flat-map", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [l] = detail::get_args<0, 1>(args, env, eval_args);
        if(l->get_type() != atom_type::T_LIST)
            detail::unsupported_args(src_location, "flat-map", args);
        atom_list r { };
        atom_list s = l->get_list();
        for(auto & a : s) {
            if(a->get_type() == atom_type::T_LIST) {
                if(a.use_count() == 1)
                    r = r.unsafe_append(a->get_list());
                else
                    r = r.unsafe_append(a->get_list().clone());
            } else {
                r = r.unsafe_append(atom_list::from(a));
            }
        }
        return r;
    }));
}

define_repr(flatten, return L"built-in function `flatten'")

[[gnu::flatten]] atom discard::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args; (void) env; (void) args;
    return make_atom(thunk([]() mutable -> thunk_type {
        return null_atom->thunk_forward();
    }));
}

define_repr(discard, return L"built-in function `discard'")

[[gnu::flatten]] atom seq::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "seq", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        return a->thunk_forward();
    }));
}

define_repr(seq, return L"built-in function `seq'")

[[gnu::flatten]] atom lift::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "lift", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        auto [f, l] = detail::get_args<0, 2>(args, env, eval_args);
        if(f->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(src_location, "lift", args);
        auto fn = f->get_callable();
        if(l->get_type() != atom_type::T_LIST)
            detail::unsupported_args(src_location, "lift", args);
        atom_list list = l->get_list();
        return apply(fn, env, list)->thunk_forward();
    }));
}

define_repr(lift, return L"built-in function `lift'")

[[gnu::flatten]] atom iterate::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<3>(src_location, "iterate", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        auto [f, cond, var] = detail::get_args<0, 3>(args, env, eval_args);
        if(f->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(src_location, "iterate", args);
        auto fn = f->get_callable();
        if(cond->get_type() != atom_type::T_CALLABLE && cond->get_type() != atom_type::T_INT)
            detail::unsupported_args(src_location, "iterate", args);
        if(cond->get_type() == atom_type::T_CALLABLE) {
            auto cf = cond->get_callable();
            auto prev = var;
            while(apply(cf, env, atom_list::from(var))->coerce_bool())
                var = apply(fn, env, atom_list::from(prev = var));
            return var->thunk_forward();
        } else {
            auto n = cond->get_integer();
            if(n < 0)
                detail::unsupported_args(src_location, "numeric argument to iterate", args);
            for(bmp::mpz_int i = 0; i < n; i++)
                var = apply(fn, env, atom_list::from(var));
            return var->thunk_forward();
        }
    }));
}

define_repr(iterate, return L"built-in function `iterate'")

[[gnu::flatten]] atom scanterate::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<3>(src_location, "scanterate", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        auto [f, cond, var] = detail::get_args<0, 3>(args, env, eval_args);
        if(f->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(src_location, "scanterate", args);
        auto fn = f->get_callable();
        if(cond->get_type() != atom_type::T_CALLABLE && cond->get_type() != atom_type::T_INT)
            detail::unsupported_args(src_location, "scanterate", args);
        if(cond->get_type() == atom_type::T_CALLABLE) {
            auto cf = cond->get_callable();
            auto prev = var;
            atom_list r { };
            while(apply(cf, env, atom_list::from(var))->coerce_bool())
                r = r.unsafe_append(var = apply(fn, env, atom_list::from(prev = var)));
            return r;
        } else {
            auto n = cond->get_integer();
            if(n < 0)
                detail::unsupported_args(src_location, "numeric argument to scanterate", args);
            atom_list r { };
            for(bmp::mpz_int i = 0; i < n; i++)
                r = r.unsafe_append(var = apply(fn, env, atom_list::from(var)));
            return r;
        }
    }));
}

define_repr(scanterate, return L"built-in function `scanterate'")

[[gnu::flatten]] atom filter::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "filter", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [fn, l] = detail::get_args<0, 2>(args, env, eval_args);
        if(l->get_type() != atom_type::T_LIST)
            detail::unsupported_args(src_location, "filter", args);
        if(fn->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(src_location, "filter", args);
        auto f = fn->get_callable();
        atom_list r { };
        for(auto & a : l->get_list()) {
            if(apply(f, env, atom_list::from(a))->coerce_bool())
                r = r.unsafe_append(a);
        }
        return r;
    }));
}

define_repr(filter, return L"built-in function `filter'")

[[gnu::flatten]] atom count::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(src_location, "count", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [fn, l] = detail::get_args<0, 2>(args, env, eval_args);
        if(l->get_type() != atom_type::T_LIST)
            detail::unsupported_args(src_location, "count", args);
        if(fn->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(src_location, "count", args);
        auto f = fn->get_callable();
        bmp::mpz_int m = 0;
        for(auto & a : l->get_list())
            if(apply(f, env, atom_list::from(a))->coerce_bool())
                m++;
        return m;
    }));
}

define_repr(count, return L"built-in function `count'")

[[gnu::flatten]] atom type::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "type", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        std::string tn = a->type_name();
        return std::wstring(tn.begin(), tn.end());
    }));
}

define_repr(type, return L"built-in function `type'")

[[gnu::flatten]] atom tostring::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "to-string", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        return a->stringify();
    }));
}

define_repr(tostring, return L"built-in function `to-string'")

[[gnu::flatten]] atom parsenum::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "parse-num", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_STR)
            detail::unsupported_args(src_location, "parse-num", args);
        std::wstring content = a->get_string();
        std::vector<token> data = lex_greedy(content);
        if(data.size() != 1)
            detail::unsupported_args(src_location, "parse-num input", args);
        switch(data[0].type) {
            case token_type::TOKEN_COMPLEX: {
                std::string num = std::get<std::string>(*data[0].content);
                std::size_t n = num.find('J');
                std::string re = num.substr(0, n);
                std::string im = num.substr(n + 1);
                boost::multiprecision::mpc_complex res{boost::multiprecision::mpf_float{im}, boost::multiprecision::mpf_float{re}};
                return res;
            }
            case token_type::TOKEN_INT:
            case token_type::TOKEN_BIN:
            case token_type::TOKEN_HEX:
                return bmp::mpz_int(std::get<std::string>(*data[0].content));
            case token_type::TOKEN_FPU:
                return bmp::mpf_float(std::get<std::string>(*data[0].content));
            default:
                detail::unsupported_args(src_location, "parse-num input", args);
        }
    }));
}

define_repr(parsenum, return L"built-in function `parsenum'")

[[gnu::flatten]] atom eval::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "eval", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        return evaluate(a, env)->thunk_forward();
    }));
}

define_repr(eval, return L"built-in function `eval'")

[[gnu::flatten]] atom memo::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "memo", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(src_location, "memo", args);
        class this_memo : public callable {
            struct list_hasher {
                std::size_t operator()(const atom_list & l) const {
                    std::size_t h = 0;
                    for(const auto & a : l)
                        h = h * 31 + std::hash<atom>()(a);
                    return h;
                }
            };

            std::shared_ptr<callable> c;
            std::unordered_map<atom_list, atom, list_hasher> cache;

            public:
                this_memo(std::shared_ptr<callable> c) : c(c) { }
                ~this_memo() {  }

                atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args) override {
                    args = detail::get_args(args, env, eval_args);
                    if(cache.find(args) == cache.end())
                        return cache[args] = c->call(env, args, eval_args);
                    return cache[args];
                }

                std::wstring repr() override {
                    return c->repr();
                }
        };
        return std::make_shared<this_memo>(a->get_callable());
    }));
}

define_repr(memo, return L"built-in function `memo'")

[[gnu::flatten]] atom kl_parse::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "parse", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_STR)
            detail::unsupported_args(src_location, "parse", args);
        atom_list l = parse(a->get_string());
        if(l.size() == 1)
            return l.car()->thunk_forward();
        else
            return l;
    }));
}

define_repr(kl_parse, return L"built-in function `parse'")

[[gnu::flatten]] atom list_env::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    detail::argno_exact<0>(src_location, "list-env", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        atom_list r { };
        while(env != nullptr) {
            atom_list q { };
            env->for_each([&q](const std::wstring & k, const atom & v) mutable {
                (void) v; // The value is unused.
                q = q.unsafe_append(make_atom(k));
            });
            r = r.unsafe_append(make_atom(q));
            env = env->ancestor;
        }
        return r;
    }));
}

define_repr(list_env, return L"built-in function `list-env'")

[[gnu::flatten]] atom let::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    detail::argno_exact<2>(src_location, "let", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [r, f] = detail::get_args<0, 2>(args);
        if(r->get_type() != atom_type::T_LIST)
            detail::unsupported_args(src_location, "let", args);
        atom_list l = r->get_list();
        std::shared_ptr<environment> descEnv = std::make_shared<environment>(env, nullptr);
        while(!l.is_empty()) {
            atom a = l.car();
            if(a->get_type() != atom_type::T_LIST)
                detail::unsupported_args(src_location, "let inner list", args);
            auto [name, value] = detail::get_args<0, 2>(a->get_list());
            if(name->get_type() != atom_type::T_ID)
                detail::unsupported_args(src_location, "let name", args);
            descEnv->set(name->get_identifier(), evaluate(value, env));
            l = l.cdr();
        }
        return evaluate(f, descEnv)->thunk_forward();
    }));
}

define_repr(let, return L"built-in function `let'")

[[gnu::flatten]] atom import::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    stacktrace_guard{ repr() };
    detail::argno_exact<1>(src_location, "import", args);
    auto [a] = detail::get_args<0, 1>(args);
    if(a->get_type() != atom_type::T_STR)
        detail::unsupported_args(src_location, "import", args);
    std::wstring filename = a->get_string();
    std::wifstream ifs(std::string(filename.begin(), filename.end()));
    if(!ifs.good())
        kl_error("Couldn't import " + std::string(filename.begin(), filename.end()));
    std::wstring data{std::istreambuf_iterator<wchar_t>(ifs), std::istreambuf_iterator<wchar_t>()};
    atom_list res = parse(std::move(data));
    for(atom & at : res)
        evaluate(at, env).get()->force();
    return null_atom;
}

define_repr(import, return L"built-in function `import'")

[[gnu::flatten]] atom size::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "size", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() == atom_type::T_STR) {
            return bmp::mpz_int(a->get_string().size());
        } else if(a->get_type() == atom_type::T_LIST) {
            return bmp::mpz_int(a->get_list().size());
        } else {
            detail::unsupported_args(src_location, "size", args);
        }
    }));
}

define_repr(size, return L"built-in function `size'")

[[gnu::flatten]] atom empty::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "empty?", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() == atom_type::T_STR) {
            return bmp::mpz_int(a->get_string().empty());
        } else if(a->get_type() == atom_type::T_LIST) {
            return bmp::mpz_int(a->get_list().is_empty());
        } else {
            detail::unsupported_args(src_location, "empty?", args);
        }
    }));
}

define_repr(empty, return L"built-in function `empty?'")

[[gnu::flatten]] atom requote::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "requote", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() == atom_type::T_CALLABLE) {
            auto t = a->get_callable()->requote();
            return atom_list::from(std::get<1>(t)).cons(std::get<0>(t));
        } else {
            detail::unsupported_args(src_location, "requote", args);
        }
    }));
}

define_repr(requote, return L"built-in function `requote'")

std::wstring convert_ns(uint64_t n) {
    if(n < 10000) {
        return std::to_wstring(n) + L"ns";
    }
    double ms = n / 1000000.0;
    if(ms < 1000) {
        return std::to_wstring(ms) + L"ms";
    }
    double s = ms / 1000.0;
    return std::to_wstring(s) + L"s";
}

[[gnu::flatten]] atom cmpex::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    detail::argno_more<0>(src_location, "cmp-ex", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        // ~~ THE ALGORITHM ~~
        // 1. Measure how long does each expression take to execute by executing it 100 times
        //    and taking the average of it.
        // 2. Draw a bar chart of the results.
        // 3. Measure percentage relative to the first expression
        // 4. Every expression that returns results other than the first expression is marked with a star.
        // ~~~~
        // Example invocation:
        // --> (cmp-ex (! 50) (foldl1 * \iota 50) (!5))
        //   #0 -> 2.5e-7 |   0% ======================================>
        //   #1 -> 1.2e-7 | -53% ===================>
        // * #2 -> 1.2e-9 | -99% >
        std::vector<uint64_t> avgs;
        for(auto & e : args) {
            std::vector<uint64_t> nanos(50, 0);
            auto start = std::chrono::high_resolution_clock::now();
            atom prev = evaluate(e, env); prev->force();
            auto finish = std::chrono::high_resolution_clock::now();
            nanos.push_back(std::chrono::duration_cast<std::chrono::nanoseconds>(finish - start).count());
            for(int i = 0; i < 49; i++) {
                start = std::chrono::high_resolution_clock::now();
                atom result = evaluate(e, env); result->force();
                finish = std::chrono::high_resolution_clock::now();
                nanos.push_back(std::chrono::duration_cast<std::chrono::nanoseconds>(finish - start).count());
            }
            avgs.push_back(std::accumulate(nanos.begin(), nanos.end(), 0ull) / nanos.size());
        }
        // Drawing the bar chart and presenting the results.
        // Take care of a single expression being present...
        if(args.size() == 1) {
            std::wcout << avgs[0] << std::endl;
            return null_atom->thunk_forward();
        }
        std::vector<int32_t> relative_percentage;
        std::vector<uint8_t> bar_sizes;
        relative_percentage.push_back(0);
        uint64_t base = avgs[0];
        for(std::size_t i = 1; i < args.size(); i++) {
            uint64_t cur = avgs[i];
            if(cur > base)
                relative_percentage.push_back(100 * (cur - base) / base);
            else
                relative_percentage.push_back(-(100 * (base - cur) / cur));
        }
        uint64_t max = *std::max_element(avgs.begin(), avgs.end());
        uint64_t min = *std::min_element(avgs.begin(), avgs.end());
        uint64_t one_point = 1;
        if(max - min > 40)
            one_point = std::ceil((max - min) / 40.0);
        else if(max - min != 0)
            one_point = std::ceil(40.0 / (max - min));
        for(std::size_t i = 0; i < avgs.size(); i++) {
            uint64_t p = avgs[i] - min;
            bar_sizes.push_back(p / one_point);
        }
        for(std::size_t i = 0; i < relative_percentage.size(); i++) {
            std::wcout << L"#" << i << L" -> " << std::setw(8) << convert_ns(avgs[i]) << L" | ";
            std::wcout << std::setw(4) << relative_percentage[i] << L"% ";
            for(int j = 0; j < bar_sizes[i] - 1; j++)
                std::wcout << L"=";
            std::wcout << L">\n";
        }
        std::wcout << std::flush;
        return null_atom->thunk_forward();
    }));
}

define_repr(cmpex, return L"built-in function `cmp-ex'")

[[gnu::flatten]] atom let_seq::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) eval_args;
    std::wstring repr = this->repr();
    std::shared_ptr<lambda> gen_lambda = this->gen_lambda;
    std::shared_ptr<macro> gen_mu = this->gen_mu;
    return make_atom(thunk([repr, args, env, gen_lambda, gen_mu]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        std::shared_ptr<environment> descEnv = std::make_shared<environment>(env, nullptr);
        
        for(atom & a : args) {
            if(a->get_type() == atom_type::T_LIST) {
                atom_list l = a->get_list();
                if(!l.is_empty() && l.car()->get_type() == atom_type::T_ID) {
                    std::wstring name = l.car()->get_identifier();
                    if(name == L"def") {
                        if(l.size() != 3 || l.cdr().car()->get_type() != atom_type::T_ID)
                            detail::unsupported_args(src_location, "let-seq def", args);
                        name = l.cdr().car()->get_identifier();
                        atom value = evaluate(l.cdr().cdr().car(), descEnv);
                        descEnv->set(name, value);
                        continue;
                    } else if(name == L"defun") {
                        if(l.size() != 4 || l.cdr().car()->get_type() != atom_type::T_ID || l.cdr().cdr().car()->get_type() != atom_type::T_LIST)
                            detail::unsupported_args(src_location, "let-seq defun", args);
                        name = l.cdr().car()->get_identifier();
                        descEnv->set(name, gen_lambda->call(descEnv, l.cdr().cdr()));
                        continue;
                    } else if(name == L"defm") {
                        if(l.size() != 4)
                            detail::unsupported_args(src_location, "let-seq defm", args);
                        name = l.cdr().car()->get_identifier();
                        descEnv->set(name, gen_mu->call(descEnv, l.cdr().cdr()));
                        continue;
                    }
                }
            }
            
            return evaluate(a, descEnv)->thunk_forward();
        }

        return null_atom->thunk_forward();
    }));
}

define_repr(let_seq, return L"built-in function `let-seq'")

}

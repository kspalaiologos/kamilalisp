
#include "core-lib.hpp"
#include "lib-detail.hpp"
#include <fstream>
#include "../reader/parser.hpp"
#include "../atom.hpp"

namespace bmp = boost::multiprecision;

namespace corelib {

[[gnu::flatten]] atom lambda::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "lambda", args);
    auto [a, code_arg] = detail::get_args<0, 2>(args);
    if(a->get_type() != atom_type::T_LIST)
        detail::unsupported_args(location, "lambda", args);
    atom_list params = a->get_list();
    for(auto & x : params)
        if(x->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "lambda parameter list", args);
    auto code = code_arg;
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, params, code, env]() mutable -> thunk_type {
        stacktrace_guard{ repr };
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
                    args = detail::get_args(args, e.lock(), eval_args);
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
    std::wstring repr = this->repr();
    detail::argno_exact<2>(location, "macro", args);
    auto [a, code_arg] = detail::get_args<0, 2>(args);
    if(a->get_type() != atom_type::T_LIST)
        detail::unsupported_args(location, "macro", args);
    atom_list params = a->get_list();
    for(auto & x : params)
        if(x->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "macro parameter list", args);
    auto code = code_arg;
    return make_atom(thunk([repr, params, code, env]() mutable -> thunk_type {
        stacktrace_guard{ repr };
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
                    std::shared_ptr<environment> descEnv = std::make_shared<environment>(e.lock(), shared_from_this());
                    // Process normal arguments.
                    if(args.size() > params.size() || args.size() < params.size() - n)
                        kl_error("Invalid invocation to a lambda expression. Unexpected amount of arguments.");
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
    detail::argno_exact<2>(location, "def", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [a, b] = detail::get_args<0, 2>(args);
        b = evaluate(b, env);
        if(a->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "def", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        env->set(a->get_identifier(), b);
        detail::fix_precision(env);
        return b->thunk_forward();
    }));
}

define_repr(define, return L"built-in function `def'")

[[gnu::flatten]] atom atop::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_more<1>(location, "atop", args);

    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
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
                        stacktrace_guard{ repr };
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
    detail::argno_more<1>(location, "fork", args);

    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
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
                        stacktrace_guard{ repr };
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
    detail::argno_more<1>(location, "bind", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        std::wstring repr = L"";
        for(auto & x : args)
            repr += std::to_wstring(x) + L" ";
        if(repr.size() > 0) { repr.pop_back(); }

        auto [f] = detail::get_args<0, 1>(args, env, eval_args);
        args = args.cdr();

        if(f->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(location, "bind", args);
        
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
                    std::shared_ptr<callable> f = this->f;
                    std::weak_ptr<environment> parent_env = this->parent_env;
                    return make_atom(thunk([innerEnv, innerArgs, components, parent_env, f, eval_args]() mutable -> thunk_type {
                        unsigned consumed = 0;
                        atom_list newArgs { };
                        if(eval_args) {
                            for(atom_list rest = components; !rest.is_empty(); rest = rest.cdr()) {
                                atom a = rest.car();
                                if(a->get_type() == atom_type::T_ID && a->get_identifier() == identifier(L"_")) {
                                    consumed++;
                                    newArgs = newArgs.unsafe_append(evaluate(innerArgs.car(), innerEnv));
                                    innerArgs = innerArgs.cdr();
                                } else {
                                    newArgs = newArgs.unsafe_append(a);
                                }
                            }
                        } else {
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
                        }
                        newArgs = newArgs.unsafe_append(innerArgs);
                        return apply(f, innerEnv, newArgs)->thunk_forward();
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
        stacktrace_guard{ repr };
        atom_list r = detail::get_args(args, env, eval_args);
        return r;
    }));
}

define_repr(tie, return L"built-in function `tie'")

[[gnu::flatten]] atom defun::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    auto generator = this->gen;
    detail::argno_exact<3>(location, "defun", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, generator, args, env]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [name, params, code] = detail::get_args<0, 3>(args);
        if(name->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "defun", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        auto fn = apply(generator, env, atom_list::from(code).cons(params));
        env->set(name->get_identifier(), fn);
        return fn->thunk_forward();
    }));
}

define_repr(defun, return L"built-in function `defun'")

[[gnu::flatten]] atom monad::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    stacktrace_guard{ repr() };
    auto generator = this->gen;
    detail::argno_exact<1>(location, "monad", args);
    auto [code] = detail::get_args<0, 1>(args);
    auto fn = apply(generator, env, atom_list::from(code).cons(make_atom(atom_list::from(make_atom(identifier(L"x"))))));
    return fn;
}

define_repr(monad, return L"built-in function `monad'")

[[gnu::flatten]] atom dyad::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    stacktrace_guard{ repr() };
    auto generator = this->gen;
    detail::argno_exact<1>(location, "dyad", args);
    auto [code] = detail::get_args<0, 1>(args);
    auto fn = apply(generator, env, atom_list::from(code).cons(make_atom(atom_list::from(make_atom(identifier(L"y"))).cons(make_atom(identifier(L"x"))))));
    return fn;
}

define_repr(dyad, return L"built-in function `dyad'")

[[gnu::flatten]] atom defm::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    auto generator = this->gen;
    detail::argno_exact<3>(location, "defm", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, generator, args, env]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [name, params, code] = detail::get_args<0, 3>(args);
        if(name->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "defm", args);
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
    detail::argno_exact<1>(location, "quote", args);
    return args.car();
}

define_repr(quote, return L"'-combinator: built-in function `quote'")

[[gnu::flatten]] atom bruijn::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    stacktrace_guard{ repr() };
    detail::argno_exact<1>(location, "bruijn", args);
    auto [a] = detail::get_args<0, 1>(args, env, eval_args);
    if(a->get_type() != atom_type::T_INT)
        detail::unsupported_args(location, "bruijn", args);
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
    detail::argno_exact<3>(location, "if", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env]() mutable -> thunk_type {
        stacktrace_guard{ repr };
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
    detail::argno_more<1>(location, "cond", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        for(auto & a : args) {
            if(a->get_type() != atom_type::T_LIST)
                a = evaluate(a, env);
            if(a->get_type() != atom_type::T_LIST)
                detail::unsupported_args(location, "cond", args);
            atom_list l = a->get_list();
            if(l.size() != 1 && l.size() != 2)
                detail::unsupported_args(location, "cond binding list", args);
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
    detail::argno_more<1>(location, "map", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto c = eval_args ? evaluate(args.car(), env) : args.car(); args = args.cdr();
        if(c->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(location, "map", args);
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
                    detail::unsupported_args(location, "map", args);
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
    detail::argno_exact<2>(location, "flat-map", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto c = eval_args ? evaluate(args.car(), env) : args.car(); args = args.cdr();
        if(c->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(location, "flat-map", args);
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
    detail::argno_exact<1>(location, "flat-map", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [l] = detail::get_args<0, 1>(args, env, eval_args);
        if(l->get_type() != atom_type::T_LIST)
            detail::unsupported_args(location, "flat-map", args);
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

[[gnu::flatten]] atom filter::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "filter", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [fn, l] = detail::get_args<0, 2>(args, env, eval_args);
        if(l->get_type() != atom_type::T_LIST)
            detail::unsupported_args(location, "filter", args);
        if(fn->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(location, "filter", args);
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
    detail::argno_exact<2>(location, "count", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [fn, l] = detail::get_args<0, 2>(args, env, eval_args);
        if(l->get_type() != atom_type::T_LIST)
            detail::unsupported_args(location, "count", args);
        if(fn->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(location, "count", args);
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
    detail::argno_exact<1>(location, "type", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        std::string tn = a->type_name();
        return std::wstring(tn.begin(), tn.end());
    }));
}

define_repr(type, return L"built-in function `type'")

[[gnu::flatten]] atom eval::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(location, "eval", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        return evaluate(a, env)->thunk_forward();
    }));
}

define_repr(eval, return L"built-in function `eval'")

[[gnu::flatten]] atom kl_parse::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(location, "parse", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_STR)
            detail::unsupported_args(location, "parse", args);
        atom_list l = parse(a->get_string());
        if(l.size() == 1)
            return l.car()->thunk_forward();
        else
            return l;
    }));
}

define_repr(kl_parse, return L"built-in function `parse'")

[[gnu::flatten]] atom let::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "let", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env]() mutable -> thunk_type {
        stacktrace_guard{ repr };
        auto [r, f] = detail::get_args<0, 2>(args);
        if(r->get_type() != atom_type::T_LIST)
            detail::unsupported_args(location, "let", args);
        atom_list l = r->get_list();
        std::shared_ptr<environment> descEnv = std::make_shared<environment>(env, nullptr);
        while(!l.is_empty()) {
            atom a = l.car();
            if(a->get_type() != atom_type::T_LIST)
                detail::unsupported_args(location, "let inner list", args);
            auto [name, value] = detail::get_args<0, 2>(a->get_list());
            if(name->get_type() != atom_type::T_ID)
                detail::unsupported_args(location, "let name", args);
            descEnv->set(name->get_identifier(), evaluate(value, env));
            l = l.cdr();
        }
        return evaluate(f, descEnv)->thunk_forward();
    }));
}

define_repr(let, return L"built-in function `let'")

[[gnu::flatten]] atom import::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    stacktrace_guard{ repr() };
    detail::argno_exact<1>(location, "import", args);
    auto [a] = detail::get_args<0, 1>(args);
    if(a->get_type() != atom_type::T_STR)
        detail::unsupported_args(location, "import", args);
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

}

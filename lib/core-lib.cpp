
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
    return make_atom(thunk([params, code, env]() mutable -> thunk_type {
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

            public:
                this_lambda(atom_list params, atom code, std::weak_ptr<environment> e, std::size_t n, atom_list l_view)
                    : params(params), code(code), e(e), n(n), l_view(l_view) { }
                ~this_lambda() { }

                atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args) override {
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

[[gnu::flatten]] atom macro::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "macro", args);
    auto [a, code_arg] = detail::get_args<0, 2>(args);
    if(a->get_type() != atom_type::T_LIST)
        detail::unsupported_args(location, "macro", args);
    atom_list params = a->get_list();
    for(auto & x : params)
        if(x->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "macro parameter list", args);
    auto code = code_arg;
    return make_atom(thunk([params, code, env]() mutable -> thunk_type {
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

            public:
                this_macro(atom_list params, atom code, std::weak_ptr<environment> e, std::size_t n, atom_list l_view)
                    : params(params), code(code), e(e), n(n), l_view(l_view) { }
                ~this_macro() { }

                atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args) override {
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

[[gnu::flatten]] atom define::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "def", args);
    return make_atom(thunk([args, env]() mutable -> thunk_type {
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

[[gnu::flatten]] atom atop::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_more<1>(location, "atop", args);

    return make_atom(thunk([args, env, eval_args]() mutable -> thunk_type {
        atom_list e_args = detail::get_args(args, env, eval_args);

        class this_atop : public callable {
            private:
                atom_list args;

            public:
                this_atop(atom_list args)
                    : args(args) { }
                ~this_atop() { }

                atom call(std::shared_ptr<environment> innerEnv, atom_list innerArgs, bool eval_args) override {
                    atom_list components = this->args;
                    return make_atom(thunk([innerEnv, innerArgs, components, eval_args]() mutable -> thunk_type {
                        auto x = components.car()->get_callable()->call(innerEnv, detail::get_args(innerArgs, innerEnv, eval_args));
                        components = components.cdr();
                        while(!components.is_empty()) {
                            x = components.car()->get_callable()->call(innerEnv, atom_list::from(x));
                            components = components.cdr();
                        }
                        return x->thunk_forward();
                    }));
                }
        };

        return std::make_shared<this_atop>(e_args);
    }));
}

[[gnu::flatten]] atom fork::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_more<1>(location, "fork", args);

    return make_atom(thunk([args, env, eval_args]() mutable -> thunk_type {
        atom_list e_args = detail::get_args(args, env, eval_args);
        
        class this_fork : public callable {
            private:
                atom_list args;

            public:
                this_fork(atom_list args)
                    : args(args) { }
                ~this_fork() { }

                atom call(std::shared_ptr<environment> innerEnv, atom_list innerArgs, bool eval_args) override {
                    atom_list components = this->args;
                    return make_atom(thunk([innerEnv, innerArgs, components, eval_args]() mutable -> thunk_type {
                        // #(f g h) <=> (f (g ...) (h ...))
                        // #(f g) <=> (f (g ...))
                        atom first = components.car();
                        atom_list e_args = detail::get_args(innerArgs, innerEnv, eval_args);
                        atom_list args { };
                        for(atom_list rest = components.cdr(); !rest.is_empty(); rest = rest.cdr())
                            args = args.unsafe_append(rest.car()->get_callable()->call(innerEnv, e_args));
                        return first->get_callable()->call(innerEnv, args)->thunk_forward();
                    }));
                }
        };

        return std::make_shared<this_fork>(e_args);
    }));
}

[[gnu::flatten]] atom bind::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_more<1>(location, "bind", args);
    return make_atom(thunk([args, env, eval_args]() mutable -> thunk_type {
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

            public:
                this_bind(atom_list args, std::shared_ptr<callable> f, std::weak_ptr<environment> parent_env)
                    : args(args), f(f), parent_env(parent_env) { }
                ~this_bind() { }

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
                        return f->call(innerEnv, newArgs)->thunk_forward();
                    }));
                }
        };

        return std::make_shared<this_bind>(e_args, f->get_callable(), env);
    }));
}

[[gnu::flatten]] atom tie::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    return make_atom(thunk([args, env, eval_args]() mutable -> thunk_type {
        atom_list r = detail::get_args(args, env, eval_args);
        return r;
    }));
}

[[gnu::flatten]] atom defun::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    auto generator = this->gen;
    detail::argno_exact<3>(location, "defun", args);
    return make_atom(thunk([generator, args, env]() mutable -> thunk_type {
        auto [name, params, code] = detail::get_args<0, 3>(args);
        if(name->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "defun", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        auto fn = generator->call(env, atom_list::from(code).cons(params));
        env->set(name->get_identifier(), fn);
        return fn->thunk_forward();
    }));
}

[[gnu::flatten]] atom monad::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    auto generator = this->gen;
    detail::argno_exact<1>(location, "monad", args);
    auto [code] = detail::get_args<0, 1>(args);
    auto fn = generator->call(env, atom_list::from(code).cons(make_atom(atom_list::from(make_atom(identifier(L"x"))))));
    return fn;
}

[[gnu::flatten]] atom dyad::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    auto generator = this->gen;
    detail::argno_exact<1>(location, "dyad", args);
    auto [code] = detail::get_args<0, 1>(args);
    auto fn = generator->call(env, atom_list::from(code).cons(make_atom(atom_list::from(make_atom(identifier(L"y"))).cons(make_atom(identifier(L"x"))))));
    return fn;
}

[[gnu::flatten]] atom defm::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    auto generator = this->gen;
    detail::argno_exact<3>(location, "defm", args);
    return make_atom(thunk([generator, args, env]() mutable -> thunk_type {
        auto [name, params, code] = detail::get_args<0, 3>(args);
        if(name->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "defm", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        auto fn = generator->call(env, atom_list::from(code).cons(params));
        env->set(name->get_identifier(), fn);
        return fn->thunk_forward();
    }));
}

[[gnu::flatten]] atom quote::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    (void) env; // The caller's environment is unnecessary.
    detail::argno_exact<1>(location, "quote", args);
    return args.car();
}

[[gnu::flatten]] atom bruijn::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(location, "bruijn", args);
    auto [a] = detail::get_args<0, 1>(args, env, eval_args);
    if(a->get_type() != atom_type::T_INT)
        detail::unsupported_args(location, "bruijn", args);
    unsigned depth = a->get_integer().convert_to<unsigned>();
    for(unsigned i = 0; i < depth; i++) {
        if(env->ancestor == nullptr)
            kl_error("de Bruijn index out of bounds");
        env = env->ancestor;
    }
    if(env->owner == nullptr)
        kl_error("de Bruijn index does not point to an environment with an owner");
    return make_atom(env->owner);
}

[[gnu::flatten]] atom kl_if::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<3>(location, "if", args);
    return make_atom(thunk([args, env]() mutable -> thunk_type {
        auto [c, t, f] = detail::get_args<0, 3>(args);
        c = evaluate(c, env);
        if(c->coerce_bool())
            return evaluate(t, env)->thunk_forward();
        else
            return evaluate(f, env)->thunk_forward();
    }));
}

[[gnu::flatten]] atom map::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_more<1>(location, "map", args);
    return make_atom(thunk([args, env, eval_args]() mutable -> thunk_type {
        auto c = eval_args ? evaluate(args.car(), env) : args.car(); args = args.cdr();
        if(c->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(location, "map", args);
        auto fn = c->get_callable();
        if(args.size() == 1) {
            auto arg = eval_args ? evaluate(args.car(), env) : args.car();
            if(arg->get_type() == atom_type::T_LIST) {
                atom_list r { };
                for(auto & a : arg->get_list())
                    r = r.unsafe_append(fn->call(env, atom_list::from(a)));
                return r;
            } else {
                return fn->call(env, atom_list::from(arg))->thunk_forward();
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
                transposed = transposed.unsafe_append(fn->call(env, row));
            }
            return transposed;
        }
    }));
}

[[gnu::flatten]] atom filter::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "filter", args);
    return make_atom(thunk([args, env, eval_args]() mutable -> thunk_type {
        auto [fn, l] = detail::get_args<0, 2>(args, env, eval_args);
        if(l->get_type() != atom_type::T_LIST)
            detail::unsupported_args(location, "filter", args);
        if(fn->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(location, "filter", args);
        auto f = fn->get_callable();
        atom_list r { };
        for(auto & a : l->get_list()) {
            if(f->call(env, atom_list::from(a))->coerce_bool())
                r = r.unsafe_append(a);
        }
        return r;
    }));
}

[[gnu::flatten]] atom count::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<2>(location, "count", args);
    return make_atom(thunk([args, env, eval_args]() mutable -> thunk_type {
        auto [fn, l] = detail::get_args<0, 2>(args, env, eval_args);
        if(l->get_type() != atom_type::T_LIST)
            detail::unsupported_args(location, "count", args);
        if(fn->get_type() != atom_type::T_CALLABLE)
            detail::unsupported_args(location, "count", args);
        auto f = fn->get_callable();
        bmp::mpz_int m = 0;
        for(auto & a : l->get_list())
            if(f->call(env, atom_list::from(a))->coerce_bool())
                m++;
        return m;
    }));
}

[[gnu::flatten]] atom type::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(location, "type", args);
    return make_atom(thunk([args, env, eval_args]() mutable -> thunk_type {
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        std::string tn = a->type_name();
        return std::wstring(tn.begin(), tn.end());
    }));
}

[[gnu::flatten]] atom import::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(location, "import", args);
    auto [a] = detail::get_args<0, 1>(args);
    if(a->get_type() != atom_type::T_STR)
        detail::unsupported_args(location, "import", args);
    std::wstring filename = a->get_string();
    std::wifstream ifs(std::string(filename.begin(), filename.end()));
    if(!ifs.good())
        kl_error("Couldn't import " + std::string(filename.begin(), filename.end()));
    std::wstring data{std::istreambuf_iterator<wchar_t>(ifs), std::istreambuf_iterator<wchar_t>()};
    atom_list res = parse(data);
    for(atom & at : res)
        evaluate(at, env).get()->force();
    return null_atom;
}

}

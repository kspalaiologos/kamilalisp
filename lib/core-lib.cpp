
#include "core-lib.hpp"
#include "lib-detail.hpp"

namespace bmp = boost::multiprecision;

namespace corelib {

[[gnu::flatten]] atom lambda::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_exact<2>(location, "lambda", args);
    auto [a, code] = detail::get_args<2>(args);
    if(a->get_type() != atom_type::T_LIST)
        detail::unsupported_args(location, "lambda", args);
    atom_list params = a->get_list();
    for(auto & x : params)
        if(x->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "lambda parameter list", args);
    class this_lambda : public callable {
        private:
            atom_list params;
            atom code;
            std::shared_ptr<environment> e;
            std::shared_ptr<callable> owner;

        public:
            this_lambda(atom_list params, atom code, std::shared_ptr<environment> e, std::shared_ptr<callable> owner) : params(params), code(code), e(e), owner(owner) { }
            ~this_lambda() { }

            atom call(std::shared_ptr<environment> env, atom_list args) override {
                (void) env; // The caller's environment is unnecessary.
                std::shared_ptr<environment> descEnv = std::make_shared<environment>(e, owner);
                // Process optional arguments.
                atom_list l = params.reverse(); atom_list l_view = l; long n = 0;
                while(!l.is_empty() && l.car()->get_identifier().value.starts_with(L"?"))
                    l = l.cdr(), n++;
                // Check if there are any misplaced optional arguments.
                long m = 0;
                for(auto & x : l_view)
                    if(x->get_identifier().value.starts_with(L"?"))
                        m++;
                if(m != n)
                    kl_error("misplaced optional lambda argument in parameter list");
                // Process normal arguments.
                if(args.size() > params.size() || args.size() < params.size() - n)
                    kl_error("Invalid invocation to a lambda expression. Unexpected amount of arguments.");
                atom_list params_view = params, args_view = args;
                for(std::size_t i = 0; i < args.size() - n; i++) {
                    descEnv->set(params_view.car()->get_identifier().value, args_view.car());
                    params_view = params_view.cdr();
                    args_view = args_view.cdr();
                }
                // Process optional arguments.
                // We have to iterate from the back.
                atom_list arg = args.reverse();
                for(long i = 0; i < n; i++) {
                    std::wstring name = l_view.car()->get_identifier().value.substr(1);
                    if(i + params.size() - n < args.size()) {
                        descEnv->set(name, evaluate(arg.car(), e));
                        arg = arg.cdr();
                    } else {
                        descEnv->set(name, null_atom);
                    }
                }
                return evaluate(code, descEnv);
            }
    };

    return make_atom(std::make_shared<this_lambda>(params, code, env, shared_from_this()));
}

[[gnu::flatten]] atom macro::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_exact<2>(location, "macro", args);
    auto [a, code] = detail::get_args<2>(args);
    if(a->get_type() != atom_type::T_LIST)
        detail::unsupported_args(location, "macro", args);
    atom_list params = a->get_list();
    for(auto & x : params)
        if(x->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "macro parameter list", args);
    class this_macro : public callable {
        private:
            atom_list params;
            atom code;
            std::shared_ptr<environment> e;
            std::shared_ptr<callable> owner;

        public:
            this_macro(atom_list params, atom code, std::shared_ptr<environment> e, std::shared_ptr<callable> owner) : params(params), code(code), e(e), owner(owner) { }
            ~this_macro() { }

            atom call(std::shared_ptr<environment> env, atom_list args) override {
                (void) env; // The caller's environment is unnecessary.
                std::shared_ptr<environment> descEnv = std::make_shared<environment>(e, owner);
                // Process optional arguments.
                atom_list l = params.reverse(); atom_list l_view = l; long n = 0;
                while(!l.is_empty() && l.car()->get_identifier().value.starts_with(L"?"))
                    l = l.cdr(), n++;
                // Check if there are any misplaced optional arguments.
                long m = 0;
                for(auto & x : l_view)
                    if(x->get_identifier().value.starts_with(L"?"))
                        m++;
                if(m != n)
                    kl_error("misplaced optional macro argument in parameter list");
                // Process normal arguments.
                if(args.size() > params.size() || args.size() < params.size() - n)
                    kl_error("Invalid invocation to a lambda expression. Unexpected amount of arguments.");
                atom_list params_view = params, args_view = args;
                for(std::size_t i = 0; i < args.size() - n; i++) {
                    descEnv->set(params_view.car()->get_identifier().value, args_view.car());
                    params_view = params_view.cdr();
                    args_view = args_view.cdr();
                }
                // Process optional arguments.
                // We have to iterate from the back.
                atom_list arg = args.reverse();
                for(long i = 0; i < n; i++) {
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

    return make_atom(std::make_shared<this_macro>(params, code, env, shared_from_this()));
}

[[gnu::flatten]] atom define::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_exact<2>(location, "def", args);
    return make_atom(thunk([args, env]() mutable -> thunk_type {
        auto [a, b] = detail::get_args<2>(args);
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

[[gnu::flatten]] atom defun::call(std::shared_ptr<environment> env, atom_list args) {
    auto generator = this->gen;
    detail::argno_exact<3>(location, "defun", args);
    return make_atom(thunk([generator, args, env]() mutable -> thunk_type {
        auto [name, params, code] = detail::get_args<3>(args);
        if(name->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "defun", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        auto fn = generator->call(env, atom_list::from(code).cons(params));
        env->set(name->get_identifier(), fn);
        return fn->thunk_forward();
    }));
}

[[gnu::flatten]] atom defm::call(std::shared_ptr<environment> env, atom_list args) {
    auto generator = this->gen;
    detail::argno_exact<3>(location, "defm", args);
    return make_atom(thunk([generator, args, env]() mutable -> thunk_type {
        auto [name, params, code] = detail::get_args<3>(args);
        if(name->get_type() != atom_type::T_ID)
            detail::unsupported_args(location, "defm", args);
        if(env->ancestor != nullptr)
            kl_error("Binding a global name in a local environment is not supported");
        auto fn = generator->call(env, atom_list::from(code).cons(params));
        env->set(name->get_identifier(), fn);
        return fn->thunk_forward();
    }));
}

[[gnu::flatten]] atom quote::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_exact<1>(location, "quote", args);
    return make_atom(thunk([args, env]() mutable -> thunk_type {
        auto [a] = detail::get_args<1>(args);
        return a->thunk_forward();
    }));
}

[[gnu::flatten]] atom bruijn::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_exact<1>(location, "bruijn", args);
    return make_atom(thunk([args, env]() mutable -> thunk_type {
        auto [a] = detail::get_args<1>(args, env);
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
        return env->owner;
    }));
}

}

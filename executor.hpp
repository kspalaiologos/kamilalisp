
#ifndef _EXECUTOR_HPP
#define _EXECUTOR_HPP

#include "env.hpp"
#include "atom.hpp"
#include "error.hpp"
#include "stacktrace.hpp"

#include <string>
#include <codecvt>

static inline atom evaluate(atom expr, std::shared_ptr<environment> env) {
    if(expr->get_type() != atom_type::T_LIST && expr->get_type() != atom_type::T_ID)
        return expr;
    if(expr->get_type() == atom_type::T_ID) {
        identifier key = expr->get_identifier();
        if(env->has(key))
            return env->get(key);
        else
            return expr;
    }
    atom_list l = expr->get_list();
    if(l.is_empty())
        kl_error("Attempted to evaluate an empty list.");
    atom head = evaluate(l.car(), env);
    if(head->get_type() != atom_type::T_CALLABLE) {
        std::wstring_convert<std::codecvt_utf8<wchar_t>, wchar_t> cvt;
        kl_error("Attempted to evaluate a non-callable, got " + head->type_name() + " - `" + cvt.to_bytes(std::to_wstring(head).c_str()) + "`");
    }
    stacktrace.push_back(head->get_callable()->repr());
    return head->get_callable()->call(env, l.cdr(), true);
    stacktrace.pop_back();
}

static inline atom apply(std::shared_ptr<callable> callable, std::shared_ptr<environment> env, atom_list args, bool eval_args = false) {
    stacktrace.push_back(callable->repr());
    atom r = callable->call(env, args, eval_args);
    stacktrace.pop_back();
    return r;
}

#endif

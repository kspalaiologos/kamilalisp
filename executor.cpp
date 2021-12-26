
#include "error.hpp"
#include "executor.hpp"

#include <codecvt>

atom evaluate(atom expr, std::shared_ptr<environment> env) {
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
    return head->get_callable()->call(env, l.cdr());
}

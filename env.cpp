
#include <memory>
#include "env.hpp"

atom environment::get(std::wstring key) {
    auto it = data.find(key);
    if (it != data.end()) {
        return it->second;
    } else if (ancestor != nullptr) {
        return ancestor->get(key);
    } else {
        return null_atom;
    }
}

void environment::set(std::wstring key, atom value) {
    data[key] = value;
}

void environment::remove(std::wstring key) {
    data.erase(key);
}

bool environment::has(std::wstring key) {
    if(data.find(key) != data.end())
        return true;
    while(ancestor != nullptr) {
        auto it = ancestor->data.find(key);
        if(it != ancestor->data.end())
            return true;
        ancestor = ancestor->ancestor;
    }
    return false;
}

std::shared_ptr<environment> environment::get_topmost_ancestor() {
    if (ancestor->ancestor == nullptr)
        return ancestor;
    else
        return ancestor->get_topmost_ancestor();
}

#include "lib/core-lib.hpp"
#include "lib/math-lib.hpp"

std::shared_ptr<environment> environment::create_default_env() {
    auto lambda = std::make_shared<corelib::lambda>();
    auto macro = std::make_shared<corelib::macro>();
    std::shared_ptr<environment> env = std::make_shared<environment>();
    env->set(L"fr", make_atom(boost::multiprecision::mpz_int(20)));
    env->set(L"+", make_atom(std::make_shared<mathlib::add>()));
    env->set(L"-", make_atom(std::make_shared<mathlib::subtract>()));
    env->set(L"*", make_atom(std::make_shared<mathlib::multiply>()));
    env->set(L"/", make_atom(std::make_shared<mathlib::divide>()));
    env->set(L"def", make_atom(std::make_shared<corelib::define>()));
    env->set(L"iota", make_atom(std::make_shared<mathlib::iota>()));
    env->set(L"lambda", make_atom(lambda));
    env->set(L"macro", make_atom(macro));
    env->set(L"defun", make_atom(std::make_shared<corelib::defun>(lambda)));
    env->set(L"monad", make_atom(std::make_shared<corelib::monad>(lambda)));
    env->set(L"dyad", make_atom(std::make_shared<corelib::dyad>(lambda)));
    env->set(L"defm", make_atom(std::make_shared<corelib::defm>(macro)));
    env->set(L"quote", make_atom(std::make_shared<corelib::quote>()));
    env->set(L"bruijn", make_atom(std::make_shared<corelib::bruijn>()));
    env->set(L"if", make_atom(std::make_shared<corelib::kl_if>()));
    return env;
}

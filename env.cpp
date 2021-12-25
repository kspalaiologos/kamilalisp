
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

#include "math-lib.hpp"

std::shared_ptr<environment> environment::create_default_env() {
    std::shared_ptr<environment> env = std::make_shared<environment>();
    env->set(L"fr", make_atom(boost::multiprecision::mpz_int(50)));
    env->set(L"+", make_atom(std::make_shared<mathlib::add>()));
    env->set(L"-", make_atom(std::make_shared<mathlib::subtract>()));
    env->set(L"*", make_atom(std::make_shared<mathlib::multiply>()));
    env->set(L"/", make_atom(std::make_shared<mathlib::divide>()));
    env->set(L"def", make_atom(std::make_shared<mathlib::define>()));
    return env;
}

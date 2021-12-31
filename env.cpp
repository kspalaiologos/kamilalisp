
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
#include "lib/io-lib.hpp"
#include "lib/str-lib.hpp"
#include "lib/random-lib.hpp"

std::shared_ptr<environment> environment::create_default_env() {
    auto lambda = std::make_shared<corelib::lambda>();
    auto macro = std::make_shared<corelib::macro>();
    std::shared_ptr<environment> env = std::make_shared<environment>();
    env->set(L"fr", make_atom(boost::multiprecision::mpz_int(20)));
    env->set(L"+", make_atom(std::make_shared<mathlib::add>()));
    env->set(L"-", make_atom(std::make_shared<mathlib::subtract>()));
    env->set(L"*", make_atom(std::make_shared<mathlib::multiply>()));
    env->set(L"/", make_atom(std::make_shared<mathlib::divide>()));
    env->set(L"%", make_atom(std::make_shared<mathlib::modulus>()));
    env->set(L"sqrt", make_atom(std::make_shared<mathlib::sqrt>()));
    env->set(L"**", make_atom(std::make_shared<mathlib::power>()));
    env->set(L"nth-root", make_atom(std::make_shared<mathlib::nthroot>()));
    env->set(L"=", make_atom(std::make_shared<mathlib::equals>()));
    env->set(L"/=", make_atom(std::make_shared<mathlib::not_equals>()));
    env->set(L"<", make_atom(std::make_shared<mathlib::less_than>()));
    env->set(L">", make_atom(std::make_shared<mathlib::greater_than>()));
    env->set(L"def", make_atom(std::make_shared<corelib::define>()));
    env->set(L"iota", make_atom(std::make_shared<mathlib::iota>()));
    env->set(L"atop", make_atom(std::make_shared<corelib::atop>()));
    env->set(L"fork", make_atom(std::make_shared<corelib::fork>()));
    env->set(L"tie", make_atom(std::make_shared<corelib::tie>()));
    env->set(L"import", make_atom(std::make_shared<corelib::import>()));
    env->set(L"lambda", make_atom(lambda));
    env->set(L"macro", make_atom(macro));
    env->set(L"defun", make_atom(std::make_shared<corelib::defun>(lambda)));
    env->set(L"monad", make_atom(std::make_shared<corelib::monad>(lambda)));
    env->set(L"dyad", make_atom(std::make_shared<corelib::dyad>(lambda)));
    env->set(L"defm", make_atom(std::make_shared<corelib::defm>(macro)));
    env->set(L"quote", make_atom(std::make_shared<corelib::quote>()));
    env->set(L"bruijn", make_atom(std::make_shared<corelib::bruijn>()));
    env->set(L"if", make_atom(std::make_shared<corelib::kl_if>()));
    env->set(L"map", make_atom(std::make_shared<corelib::map>()));
    env->set(L"filter", make_atom(std::make_shared<corelib::filter>()));
    env->set(L"bind", make_atom(std::make_shared<corelib::bind>()));
    env->set(L"count", make_atom(std::make_shared<corelib::count>()));
    env->set(L"type", make_atom(std::make_shared<corelib::type>()));
    env->set(L"eval", make_atom(std::make_shared<corelib::eval>()));
    env->set(L"let", make_atom(std::make_shared<corelib::let>()));
    env->set(L"parse", make_atom(std::make_shared<corelib::kl_parse>()));
    env->set(L"flat-map", make_atom(std::make_shared<corelib::flatmap>()));
    env->set(L"flatten", make_atom(std::make_shared<corelib::flatten>()));
    env->set(L"seq", make_atom(std::make_shared<corelib::seq>()));
    env->set(L"discard", make_atom(std::make_shared<corelib::discard>()));
    env->set(L"lift", make_atom(std::make_shared<corelib::lift>()));
    env->set(L"iterate", make_atom(std::make_shared<corelib::iterate>()));
    env->set(L"list-env", make_atom(std::make_shared<corelib::list_env>()));
    env->set(L"scanterate", make_atom(std::make_shared<corelib::scanterate>()));
    env->set(L"to-string", make_atom(std::make_shared<corelib::tostring>()));
    env->set(L"parse-num", make_atom(std::make_shared<corelib::parsenum>()));
    env->set(L"cond", make_atom(std::make_shared<corelib::cond>()));
    env->set(L"memo", make_atom(std::make_shared<corelib::memo>()));
    env->set(L"println", make_atom(std::make_shared<iolib::println>()));

    env->set(L"rng-deal", make_atom(std::make_shared<
        rndlib::rng_deal<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::default_random_engine>
    >()));
    env->set(L"rng-roll", make_atom(std::make_shared<
        rndlib::rng_roll<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::default_random_engine>
    >()));
    env->set(L"rng-real", make_atom(std::make_shared<
        rndlib::rng_real<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::default_random_engine>
    >()));

    env->set(L"rng-mt19937-deal", make_atom(std::make_shared<
        rndlib::rng_deal<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::mt19937>
    >()));
    env->set(L"rng-mt19937-roll", make_atom(std::make_shared<
        rndlib::rng_roll<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::mt19937>
    >()));
    env->set(L"rng-mt19937-real", make_atom(std::make_shared<
        rndlib::rng_real<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::mt19937>
    >()));

    env->set(L"rng-lcg-deal", make_atom(std::make_shared<
        rndlib::rng_deal<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::minstd_rand>
    >()));
    env->set(L"rng-lcg-roll", make_atom(std::make_shared<
        rndlib::rng_roll<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::minstd_rand>
    >()));
    env->set(L"rng-lcg-real", make_atom(std::make_shared<
        rndlib::rng_real<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::minstd_rand>
    >()));

    env->set(L"rng-ranlux-deal", make_atom(std::make_shared<
        rndlib::rng_deal<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::ranlux48>
    >()));
    env->set(L"rng-ranlux-roll", make_atom(std::make_shared<
        rndlib::rng_roll<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::ranlux48>
    >()));
    env->set(L"rng-ranlux-real", make_atom(std::make_shared<
        rndlib::rng_real<std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::ranlux48>
    >()));

    env->set(L"str-trim", make_atom(std::make_shared<strlib::str_trim>()));
    env->set(L"str-count", make_atom(std::make_shared<strlib::str_count>()));
    env->set(L"size", make_atom(std::make_shared<corelib::size>()));
    env->set(L"requote", make_atom(std::make_shared<corelib::requote>()));
    env->set(L"empty?", make_atom(std::make_shared<corelib::empty>()));
    env->set(L"let-seq", make_atom(std::make_shared<corelib::let_seq>(lambda, macro)));

    env->set(L"or", make_atom(std::make_shared<mathlib::kl_or>()));
    env->set(L"xor", make_atom(std::make_shared<mathlib::kl_xor>()));
    env->set(L"and", make_atom(std::make_shared<mathlib::kl_and>()));

    env->set(L"floor", make_atom(std::make_shared<mathlib::kl_floor>()));
    env->set(L"ceil", make_atom(std::make_shared<mathlib::kl_ceil>()));

    return env;
}

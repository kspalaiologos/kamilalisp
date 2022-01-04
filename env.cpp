
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
#include "lib/prime-lib.hpp"
#include "lib/str-lib.hpp"
#include "lib/trig-lib.hpp"
#include "lib/random-lib.hpp"
#include "lib/logarithm-lib.hpp"
#include "lib/combinatorics-lib.hpp"
#include "lib/fold-lib.hpp"
#include "lib/list-lib.hpp"

std::shared_ptr<environment> environment::create_default_env() {
    auto lambda = std::make_shared<corelib::lambda>();
    auto macro = std::make_shared<corelib::macro>();
    std::shared_ptr<environment> env = std::make_shared<environment>();
    env->set(L"fr", make_atom(boost::multiprecision::mpz_int(20)));
    env->set(L"+", make_atom(std::make_shared<mathlib::add>()));
    env->set(L"-", make_atom(std::make_shared<mathlib::subtract>()));
    env->set(L"*", make_atom(std::make_shared<mathlib::multiply>()));
    env->set(L"/", make_atom(std::make_shared<mathlib::divide>()));
    env->set(L"//", make_atom(std::make_shared<mathlib::divide_int>()));
    env->set(L"%", make_atom(std::make_shared<mathlib::modulus>()));
    env->set(L"sqrt", make_atom(std::make_shared<mathlib::sqrt>()));
    env->set(L"**", make_atom(std::make_shared<mathlib::power>()));
    env->set(L"nth-root", make_atom(std::make_shared<mathlib::nthroot>()));
    env->set(L"=", make_atom(std::make_shared<mathlib::equals>()));
    env->set(L"/=", make_atom(std::make_shared<mathlib::not_equals>()));
    env->set(L"<", make_atom(std::make_shared<mathlib::less_than>()));
    env->set(L">", make_atom(std::make_shared<mathlib::greater_than>()));
    env->set(L"exp", make_atom(std::make_shared<mathlib::exp>()));
    env->set(L"!", make_atom(std::make_shared<combinatoricslib::factorial>()));
    env->set(L"gamma", make_atom(std::make_shared<combinatoricslib::gamma>()));
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

    env->set(L"lcm", make_atom(std::make_shared<mathlib::kl_lcm>()));
    env->set(L"gcd", make_atom(std::make_shared<mathlib::kl_gcd>()));

    env->set(L"bernoulli", make_atom(std::make_shared<mathlib::kl_bernoulli>()));
    env->set(L"digamma", make_atom(std::make_shared<mathlib::kl_digamma>()));
    env->set(L"lambert-w0", make_atom(std::make_shared<mathlib::kl_lambert0>()));
    env->set(L"jacobi-sym", make_atom(std::make_shared<mathlib::jacobi>()));

    env->set(L"sin", make_atom(std::make_shared<triglib::kl_sin>()));
    env->set(L"cos", make_atom(std::make_shared<triglib::kl_cos>()));
    env->set(L"tan", make_atom(std::make_shared<triglib::kl_tan>()));
    env->set(L"ctg", make_atom(std::make_shared<triglib::kl_cot>()));
    env->set(L"sec", make_atom(std::make_shared<triglib::kl_sec>()));
    env->set(L"csc", make_atom(std::make_shared<triglib::kl_csc>()));
    env->set(L"arcsin", make_atom(std::make_shared<triglib::kl_arcsin>()));
    env->set(L"arccos", make_atom(std::make_shared<triglib::kl_arccos>()));
    env->set(L"arctan", make_atom(std::make_shared<triglib::kl_arctan>()));
    env->set(L"arccot", make_atom(std::make_shared<triglib::kl_arccot>()));
    env->set(L"arcsec", make_atom(std::make_shared<triglib::kl_arcsec>()));
    env->set(L"arccsc", make_atom(std::make_shared<triglib::kl_arccsc>()));

    env->set(L"sinh", make_atom(std::make_shared<triglib::kl_sinh>()));
    env->set(L"cosh", make_atom(std::make_shared<triglib::kl_cosh>()));
    env->set(L"tanh", make_atom(std::make_shared<triglib::kl_tanh>()));
    env->set(L"ctgh", make_atom(std::make_shared<triglib::kl_coth>()));
    env->set(L"sech", make_atom(std::make_shared<triglib::kl_sech>()));
    env->set(L"csch", make_atom(std::make_shared<triglib::kl_csch>()));
    env->set(L"arcsinh", make_atom(std::make_shared<triglib::kl_arcsinh>()));
    env->set(L"arccosh", make_atom(std::make_shared<triglib::kl_arccosh>()));
    env->set(L"arctanh", make_atom(std::make_shared<triglib::kl_arctanh>()));
    env->set(L"arccoth", make_atom(std::make_shared<triglib::kl_arccoth>()));
    env->set(L"arcsech", make_atom(std::make_shared<triglib::kl_arcsech>()));
    env->set(L"arccsch", make_atom(std::make_shared<triglib::kl_arccsch>()));

    env->set(L"pi", make_atom(std::make_shared<triglib::kl_pi>()));
    env->set(L"e", make_atom(std::make_shared<triglib::kl_e>()));
    env->set(L"catalan", make_atom(std::make_shared<triglib::catalan>()));
    env->set(L"euler-gamma", make_atom(std::make_shared<triglib::euler_gamma>()));

    env->set(L"prime?", make_atom(std::make_shared<primelib::prime>()));
    env->set(L"p-factors", make_atom(std::make_shared<primelib::p_factors>()));
    env->set(L"p-ufactors", make_atom(std::make_shared<primelib::p_ufactors>()));
    env->set(L"divisors", make_atom(std::make_shared<primelib::divisors>()));
    env->set(L"mobius-mu", make_atom(std::make_shared<primelib::mobius_mu>()));

    env->set(L"ln", make_atom(std::make_shared<logarithmlib::ln>()));
    env->set(L"log2", make_atom(std::make_shared<logarithmlib::log2>()));
    env->set(L"log1p", make_atom(std::make_shared<logarithmlib::log1p>()));
    env->set(L"log10", make_atom(std::make_shared<logarithmlib::log10>()));
    env->set(L"log", make_atom(std::make_shared<logarithmlib::log>()));

    env->set(L"odd-f", make_atom(std::make_shared<mathlib::odd_f>()));
    env->set(L"even-f", make_atom(std::make_shared<mathlib::even_f>()));

    env->set(L"odd?", make_atom(std::make_shared<mathlib::odd>()));
    env->set(L"even?", make_atom(std::make_shared<mathlib::even>()));

    env->set(L"max", make_atom(std::make_shared<mathlib::max>()));
    env->set(L"min", make_atom(std::make_shared<mathlib::min>()));

    env->set(L"pmat", make_atom(std::make_shared<combinatoricslib::pmat>()));
    env->set(L"cmat", make_atom(std::make_shared<combinatoricslib::cmat>()));

    env->set(L"binomial", make_atom(std::make_shared<combinatoricslib::binomial>()));

    env->set(L"pochhammer+", make_atom(std::make_shared<combinatoricslib::pochhammer_plus>()));
    env->set(L"pochhammer-", make_atom(std::make_shared<combinatoricslib::pochhammer_minus>()));

    env->set(L"hamming-weight", make_atom(std::make_shared<mathlib::hamming_weight>()));

    env->set(L"p-until", make_atom(std::make_shared<primelib::p_until>()));
    env->set(L"p-no", make_atom(std::make_shared<primelib::p_no>()));
    env->set(L"p-count", make_atom(std::make_shared<primelib::p_count>()));

    env->set(L"re", make_atom(std::make_shared<mathlib::re>()));
    env->set(L"im", make_atom(std::make_shared<mathlib::im>()));

    env->set(L"phasor", make_atom(std::make_shared<mathlib::phasor>()));
    env->set(L"as-complex", make_atom(std::make_shared<mathlib::as_complex>()));
    env->set(L"as-real", make_atom(std::make_shared<mathlib::as_real>()));

    env->set(L"foldl", make_atom(std::make_shared<foldlib::foldl>()));
    env->set(L"foldr", make_atom(std::make_shared<foldlib::foldr>()));
    env->set(L"foldl1", make_atom(std::make_shared<foldlib::foldl1>()));
    env->set(L"foldr1", make_atom(std::make_shared<foldlib::foldr1>()));

    env->set(L"scanl", make_atom(std::make_shared<foldlib::scanl>()));
    env->set(L"scanr", make_atom(std::make_shared<foldlib::scanr>()));
    env->set(L"scanl1", make_atom(std::make_shared<foldlib::scanl1>()));
    env->set(L"scanr1", make_atom(std::make_shared<foldlib::scanr1>()));

    env->set(L"cdr", make_atom(std::make_shared<listlib::cdr>()));
    env->set(L"car", make_atom(std::make_shared<listlib::car>()));

    evaluate_code(L"(def sum $(foldl1 +))", env)->force();
    evaluate_code(L"(def avg #(/ sum size))", env)->force();

    return env;
}

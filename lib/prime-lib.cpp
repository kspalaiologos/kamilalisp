
#include "prime-lib.hpp"
#include "lib-detail.hpp"
#include <boost/multiprecision/miller_rabin.hpp>

namespace bmp = boost::multiprecision;

#include "rnd-detail.hpp"

#include <random>
#include <vector>

class PollardRho {
    private:
        static bmp::mpz_int rho(const bmp::mpz_int & n) {
            // XXX: Thread-local?
            static std::random_device r;
            static std::mt19937 e1 { r() };

            bmp::mpz_int divisor;
            bmp::mpz_int c = rnd_detail::gensize
                <std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::mt19937>
                (e1, bmp::trunc(bmp::log2(n.convert_to<bmp::mpf_float>())).convert_to<unsigned>());
            bmp::mpz_int x = rnd_detail::gensize
                <std::uniform_int_distribution<unsigned long>, std::uniform_int_distribution<>, std::mt19937>
                (e1, bmp::trunc(bmp::log2(n.convert_to<bmp::mpf_float>())).convert_to<unsigned>());
            bmp::mpz_int xx = x;

            if((n & 1) == 0)
                return 2;
            do {
                x = ((x * x) % n + c) % n;
                xx = ((xx * xx) % n + c) % n;
                xx = ((xx * xx) % n + c) % n;
                divisor = bmp::gcd(x - xx, n);
            } while(divisor == 1);

            return divisor;
        }
    public:
        std::vector<bmp::mpz_int> factors;

        void factor(const bmp::mpz_int & n, unsigned trials) {
            if(n == 1)
                return;
            if(bmp::miller_rabin_test(n, trials)) {
                factors.push_back(n);
                return;
            }
            bmp::mpz_int divisor = rho(n);
            factor(divisor, trials);
            factor(n / divisor, trials);
        }

};

namespace primelib {

[[gnu::flatten]] atom prime::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "prime", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_INT)
            detail::unsupported_args(src_location, "prime", args);
        bmp::mpz_int n = a->get_integer();
        if(n < 2)
            return atom_false->thunk_forward();
        if(n == 2)
            return atom_true->thunk_forward();
        if((n & 1) == 0)
            return atom_false->thunk_forward();
        return bmp::miller_rabin_test(n, 10 * env->get(L"fr")->get_integer().convert_to<unsigned>())
            ? atom_true->thunk_forward() : atom_false->thunk_forward();
    }));
}

define_repr(prime, return L"built-in function `prime'");

[[gnu::flatten]] atom p_factors::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "p-factors", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_INT)
            detail::unsupported_args(src_location, "p-factors", args);
        bmp::mpz_int n = a->get_integer();
        if(n <= 0)
            kl_error("p-factors: argument must be positive");
        PollardRho r;
        r.factor(n, 10 * env->get(L"fr")->get_integer().convert_to<unsigned>());
        atom_list res { };
        for(auto & i : r.factors)
            res.push_back(make_atom(i));
        return res;
    }));
}

define_repr(p_factors, return L"built-in function `p-factors'");

[[gnu::flatten]] atom mobius_mu::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "mobius-mu", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_INT)
            detail::unsupported_args(src_location, "mobius-mu", args);
        bmp::mpz_int n = a->get_integer();
        // preliminary checks for small squares.
        if(n == 1)
            return bmp::mpz_int(1);
        else if(n < 1)
            return bmp::mpz_int(0);
        else if(n >= 49 && (n % 4 != 0 || n % 9 != 0 || n % 25 != 0 || n % 49 != 0))
            return bmp::mpz_int(0);
        PollardRho r;
        r.factor(n, 10 * env->get(L"fr")->get_integer().convert_to<unsigned>());
        // check if the factors are unique
        std::unordered_map<bmp::mpz_int, unsigned> table;
        for(auto & i : r.factors)
            table[i]++;
        for(auto & i : table)
            if(i.second > 1)
                return bmp::mpz_int(0);
        // check if the amount of factors is even
        return r.factors.size() % 2 == 0 ? bmp::mpz_int(1) : bmp::mpz_int(-1);
    }));
}

define_repr(mobius_mu, return L"built-in function `mobius-mu'");

[[gnu::flatten]] atom p_ufactors::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "p-ufactors", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_INT)
            detail::unsupported_args(src_location, "p-ufactors", args);
        bmp::mpz_int n = a->get_integer();
        if(n <= 0)
            kl_error("p-factors: argument must be positive");
        PollardRho r;
        r.factor(n, 10 * env->get(L"fr")->get_integer().convert_to<unsigned>());
        std::unordered_map<bmp::mpz_int, unsigned> table;
        for(auto & i : r.factors)
            table[i]++;
        atom_list res { };
        for(auto & i : table) {
            bmp::mpz_int aaa = i.first;
            res.push_back(make_atom(atom_list::from({ make_atom(aaa), make_atom(bmp::mpz_int(i.second)) })));
        }
        return res;
    }));
}

define_repr(p_ufactors, return L"built-in function `p-ufactors'");

void gen_divisors(std::size_t curIndex, const bmp::mpz_int & curDivisor, std::map<bmp::mpz_int, unsigned> & map, atom_list & factors) {
    bmp::mpz_int c = curDivisor;
    if(curIndex == map.size()) {
        factors.push_back(make_atom(std::move(c)));
        return;
    }
    for(unsigned i = 0; i <= map.at(([map, curIndex]() {
        auto it = map.begin();
        std::advance(it, curIndex);
        return it->first;
    })()); i++) {
        gen_divisors(curIndex + 1, c, map, factors);
        c *= ([map, curIndex]() {
            auto it = map.begin();
            std::advance(it, curIndex);
            return it->first;
        })();
    }
}

[[gnu::flatten]] atom divisors::call(std::shared_ptr<environment> env, atom_list args, bool eval_args) {
    detail::argno_exact<1>(src_location, "divisors", args);
    std::wstring repr = this->repr();
    return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
        stacktrace_guard g{ repr };
        auto [a] = detail::get_args<0, 1>(args, env, eval_args);
        if(a->get_type() != atom_type::T_INT)
            detail::unsupported_args(src_location, "divisors", args);
        bmp::mpz_int n = a->get_integer();
        if(n <= 0)
            kl_error("divisors: argument must be positive");
        PollardRho r;
        r.factor(n, 10 * env->get(L"fr")->get_integer().convert_to<unsigned>());
        std::map<bmp::mpz_int, unsigned> table;
        for(auto & i : r.factors)
            table[i]++;
        atom_list res { };
        gen_divisors(0, bmp::mpz_int(1), table, res);
        bool found = false;
        for(auto & i : res)
            if(i->get_integer() == n)
                { found = true; break; }
        if(!found)
            res.push_back(make_atom(n));
        return res;
    }));
}

define_repr(divisors, return L"built-in function `divisors'");

}

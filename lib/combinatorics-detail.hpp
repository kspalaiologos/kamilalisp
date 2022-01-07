
#ifndef _COMBINATORICS_DETAIL_HPP
#define _COMBINATORICS_DETAIL_HPP

#include <array>
#include <vector>
#include <mutex>
#include <unordered_map>
#include "../atom.hpp"

namespace combinatoricslib {

namespace detail {

namespace bmp = boost::multiprecision;

template <std::size_t N>
static constexpr std::array<bmp::mpz_int, N> get_factorial_cache() {
    std::array<bmp::mpz_int, N> r;
    r[0] = bmp::mpz_int(1);
    for (std::size_t i = 1; i < N; i++)
        r[i] = r[i - 1] * bmp::mpz_int(i + 1);
    return r;
}

const static std::array<bmp::mpz_int, 100> factorial_cache = get_factorial_cache<100>();

// Spouge's approximation.
template <typename T>
std::vector<T> spouge_coeffs(const T & nc) {
    std::vector<T> c((unsigned) nc);
    T k1_factrl = 1;
    c[0] = bmp::sqrt(2 * boost::math::constants::pi<T>());
    for(std::size_t k = 1; k < nc; k++) {
        c[k] = bmp::exp(nc - k) * bmp::pow(nc - k, k - 0.5) / k1_factrl;
        k1_factrl *= -bmp::mpf_float(k);
    }
    return c;
}

template <typename T, typename C>
T gamma_impl(const std::vector<C> & coeffs, T x) {
    const std::size_t nc = coeffs.size();
    T acc = coeffs[0];
    for(size_t k=1; k < nc; k++) {
        acc += coeffs[k] / (x + k);
    }
    acc *= bmp::exp(-(x + nc)) * bmp::pow(x + nc, x + 0.5);
    return acc / x;
}

static std::unordered_map<unsigned, std::vector<bmp::mpf_float>> spouge_coefficient_cache;
static std::mutex spouge_lock;

bmp::mpz_int int_factorial(const bmp::mpz_int & n) {
    if(n == 0)
        return bmp::mpz_int(1);
    if(n < 0)
        kl_error("!n undefined for n<0");
    if(n <= 100)
        return factorial_cache[n.convert_to<unsigned>() - 1];
    else {
        bmp::mpz_int factorial_100 = factorial_cache.back();
        for(bmp::mpz_int arg = 101; arg < n; arg++)
            factorial_100 *= arg;
        return factorial_100;
    }
}

atom_list comb_list(const std::vector<bmp::mpz_int> & c, std::size_t combo) {
    atom_list r { };
    for(std::size_t i = 0; i < c.size(); i++)
        if((combo >> i) & 1) {
            bmp::mpz_int val = c[i];
            r.push_back(make_atom(val));
        }
    return r;
}

atom_list comb_impl(const std::vector<bmp::mpz_int> & c, std::size_t k) {
    std::size_t n = c.size();
    std::size_t combo = (1 << k) - 1;
    atom_list l { };
    while (combo < (1 << n)) {
        l.push_back(make_atom(comb_list(c, combo)));
        std::size_t x = combo & -combo;
        std::size_t y = combo + x;
        combo = (((combo & ~y) / x) >> 1) | y;
    }
    return l;
}

}

}

#endif

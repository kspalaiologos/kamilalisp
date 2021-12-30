
#ifndef _RND_LIB_HPP
#define _RND_LIB_HPP

#include "../atom.hpp"
#include "../env.hpp"
#include "../list.hpp"
#include "lib-detail.hpp"

#include <random>
#include <numeric>

namespace rndlib {

namespace bmp = boost::multiprecision;

namespace rnd_detail {
    template <typename BitDistribution, typename Generator>
    static bmp::mpz_int genbits(Generator & gen, unsigned log2) {
        BitDistribution dis(0, 1);
        bmp::mpz_int result;
        for (unsigned i = 0; i < log2; i++) {
            result <<= 1;
            result += dis(gen);
        }
        return result;
    }

    template <typename Distribution, typename BitDistribution, typename Generator>
    static bmp::mpz_int gensize(Generator & gen, const bmp::mpz_int & n) {
        if(n > ULONG_MAX - 1) {
            unsigned boundary = bmp::ceil(bmp::log2(n.convert_to<bmp::mpf_float>())).convert_to<unsigned>();
            bmp::mpz_int r;
            while((r = genbits<BitDistribution, Generator>(gen, boundary)) > n)
                ;
            return r;
        } else {
            unsigned long max = n.convert_to<unsigned long>();
            Distribution dis(0, max);
            return bmp::mpz_int(dis(gen));
        }
    }
}

template <typename Distribution, typename BitDistribution, typename Generator>
class rng_deal : public callable {
    public:
        ~rng_deal() { }
        [[gnu::flatten]] atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args = false) override {
            detail::argno_either<0, 1>(location, "rng-roll", args);
            std::wstring repr = this->repr();
            return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
                stacktrace_guard g{ repr };
                // XXX: Might not be the best idea to keep them here.
                std::random_device r;
                Generator e1(r());
                if(args.size() == 0) {
                    Distribution uniform_dist(1, ULONG_MAX);
                    return bmp::mpz_int(uniform_dist(e1));
                } else {
                    auto [a] = detail::get_args<0, 1>(args, env, eval_args);
                    if(a->get_type() == atom_type::T_INT) {
                        return rnd_detail::gensize<Distribution, BitDistribution, Generator>(e1, a->get_integer());
                    } else {
                        atom_list l { };
                        for(auto & e : a->get_list()) {
                            if(e->get_type() != atom_type::T_INT)
                                detail::unsupported_args(location, "rng-roll argument list", args);
                            l = l.unsafe_append(make_atom(rnd_detail::gensize<Distribution, BitDistribution, Generator>(e1, a->get_integer())));
                        }
                        return l;
                    }
                }
            }));
        }
        std::wstring repr() override { return L"built-in function `rng-deal'"; }
};

template <typename Distribution, typename BitDistribution, typename Generator>
class rng_roll : public callable {
    public:
        ~rng_roll() { }
        [[gnu::flatten]] atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args = false) override {
            detail::argno_exact<2>(location, "rng-roll", args);
            std::wstring repr = this->repr();
            return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
                stacktrace_guard g{ repr };
                // XXX: Might not be the best idea to keep them here.
                std::random_device r;
                Generator e1(r());
                auto [a, b] = detail::get_args<0, 2>(args, env, eval_args);
                if(a->get_type() != atom_type::T_INT || b->get_type() != atom_type::T_INT)
                    detail::unsupported_args(location, "rng-roll argument", args);
                atom_list res { };
                for(bmp::mpz_int n = 0; n < b->get_integer(); n++)
                    res = res.unsafe_append(make_atom(rnd_detail::gensize<Distribution, BitDistribution, Generator>(e1, a->get_integer())));
                return res;
            }));
        }
        std::wstring repr() override { return L"built-in function `rng-roll'"; }
};

template <typename Distribution, typename BitDistribution, typename Generator>
class rng_real : public callable {
    public:
        ~rng_real() { }
        [[gnu::flatten]] atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args = false) override {
            detail::argno_either<0, 1>(location, "rng-real", args);
            std::wstring repr = this->repr();
            return make_atom(thunk([repr, args, env, eval_args]() mutable -> thunk_type {
                stacktrace_guard g{ repr };
                // XXX: Might not be the best idea to keep them here.
                std::random_device r;
                Generator e1(r());
                bmp::mpz_int gen_max = bmp::pow(bmp::mpz_int(10), env->get(L"fr")->get_integer().convert_to<unsigned long>()).convert_to<bmp::mpz_int>();
                if(args.size() == 0) {
                    bmp::mpz_int a = rnd_detail::gensize<Distribution, BitDistribution, Generator>(e1, gen_max);
                    bmp::mpz_int b = rnd_detail::gensize<Distribution, BitDistribution, Generator>(e1, gen_max);
                    while(b == 0)
                        b = rnd_detail::gensize<Distribution, BitDistribution, Generator>(e1, gen_max);
                    if(a < b)
                        return bmp::mpf_float(a.convert_to<bmp::mpf_float>() / b.convert_to<bmp::mpf_float>());
                    else
                        return bmp::mpf_float(b.convert_to<bmp::mpf_float>() / a.convert_to<bmp::mpf_float>());
                } else {
                    auto [a] = detail::get_args<0, 1>(args, env, eval_args);
                    if(a->get_type() != atom_type::T_INT)
                        detail::unsupported_args(location, "rng-real argument", args);
                    atom_list res { };
                    for(bmp::mpz_int n = 0; n < a->get_integer(); n++) {
                        bmp::mpz_int a = rnd_detail::gensize<Distribution, BitDistribution, Generator>(e1, gen_max);
                        bmp::mpz_int b = rnd_detail::gensize<Distribution, BitDistribution, Generator>(e1, gen_max);
                        while(b == 0)
                            b = rnd_detail::gensize<Distribution, BitDistribution, Generator>(e1, gen_max);
                        if(a < b)
                            res = res.unsafe_append(make_atom(bmp::mpf_float(a.convert_to<bmp::mpf_float>() / b.convert_to<bmp::mpf_float>())));
                        else
                            res = res.unsafe_append(make_atom(bmp::mpf_float(b.convert_to<bmp::mpf_float>() / a.convert_to<bmp::mpf_float>())));
                    }
                    return res;
                }
            }));
        }
        std::wstring repr() override { return L"built-in function `rng-real'"; }
};

}

#endif

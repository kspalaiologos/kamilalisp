
#ifndef _RND_DETAIL_HPP
#define _RND_DETAIL_HPP

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

#endif

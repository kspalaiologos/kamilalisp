
#include <boost/multiprecision/gmp.hpp>
#include <boost/multiprecision/mpc.hpp>
#include <string>
#include <iostream>

int main(void) {
    boost::multiprecision::mpf_float f("0.1");
    boost::multiprecision::mpf_float g("0.2");
    std::cout << boost::multiprecision::mpf_float(f + g) << std::endl;
}

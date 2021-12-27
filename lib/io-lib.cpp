
#include "io-lib.hpp"
#include "lib-detail.hpp"
#include <fstream>

namespace bmp = boost::multiprecision;

namespace iolib {

[[gnu::flatten]] atom println::call(std::shared_ptr<environment> env, atom_list args) {
    detail::argno_exact<1>(location, "println", args);
    auto [message] = detail::get_args<1>(args, env);
    if(message->get_type() == atom_type::T_STR) {
        std::wcout << message->get_string() << std::endl;
    } else {
        std::wcout << std::to_wstring(message) << std::endl;
    }
    return message;
}

}

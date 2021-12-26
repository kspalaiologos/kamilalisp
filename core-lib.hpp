
#ifndef __CORE_LIB_HPP
#define __CORE_LIB_HPP

#include "atom.hpp"
#include "env.hpp"
#include "list.hpp"

namespace corelib {

class quote : public callable {
    public:
        ~quote() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class define : public callable {
    public:
        ~define() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class lambda : public callable {
    public:
        ~lambda() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

}

#endif

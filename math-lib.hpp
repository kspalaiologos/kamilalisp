
#ifndef _MATH_LIB_HPP
#define _MATH_LIB_HPP

#include "atom.hpp"
#include "env.hpp"
#include "list.hpp"

namespace mathlib {

class add : public callable {
    public:
        ~add() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class subtract : public callable {
    public:
        ~subtract() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class multiply : public callable {
    public:
        ~multiply() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class divide : public callable {
    public:
        ~divide() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

class iota : public callable {
    public:
        ~iota() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
};

}

#endif

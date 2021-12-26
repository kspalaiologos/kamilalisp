
#ifndef __CORE_LIB_HPP
#define __CORE_LIB_HPP

#include "../atom.hpp"
#include "../env.hpp"
#include "../list.hpp"

namespace corelib {

define_callable(quote);
define_callable(define);
define_callable(lambda);
define_callable(macro);

class defun : public callable {
    public:
        defun(std::shared_ptr<lambda> gen) : gen(gen) { }
        ~defun() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
    private:
        std::shared_ptr<lambda> gen;
};

class defm : public callable {
    public:
        defm(std::shared_ptr<macro> gen) : gen(gen) { }
        ~defm() { }
        atom call(std::shared_ptr<environment> env, atom_list args) override;
    private:
        std::shared_ptr<macro> gen;
};

}

#endif


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
        atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args = false) override;
    private:
        std::shared_ptr<lambda> gen;
};

class defm : public callable {
    public:
        defm(std::shared_ptr<macro> gen) : gen(gen) { }
        ~defm() { }
        atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args = false) override;
    private:
        std::shared_ptr<macro> gen;
};

class monad : public callable {
    public:
        monad(std::shared_ptr<lambda> gen) : gen(gen) { }
        ~monad() { }
        atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args = false) override;
    private:
        std::shared_ptr<lambda> gen;
};

class dyad : public callable {
    public:
        dyad(std::shared_ptr<lambda> gen) : gen(gen) { }
        ~dyad() { }
        atom call(std::shared_ptr<environment> env, atom_list args, bool eval_args = false) override;
    private:
        std::shared_ptr<lambda> gen;
};

define_callable(bruijn);
define_callable(kl_if);
define_callable(atop);
define_callable(fork);
define_callable(tie);
define_callable(import);
define_callable(map);
define_callable(filter);
define_callable(bind);
define_callable(count);
define_callable(type);

}

#endif

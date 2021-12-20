
#ifndef _MATH_LIB_HPP
#define _MATH_LIB_HPP

namespace mathlib {

class add : public callable {
    public:
        ~add() { }

        atom call(std::shared_ptr<environment> env, atom_list args) override {
            if(args.size() != 2)
                throw std::runtime_error("Wrong number of arguments to +, got " + std::to_string(args.size()));
            thunk t = [args]() mutable {
                return args.car()->get_integer() + args.cdr().car()->get_integer();
            };
            return make_atom(t);
        }
};

}

#endif

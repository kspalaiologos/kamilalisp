
#include "env.hpp"
#include "executor.hpp"
#include "reader/parser.hpp"

class add : public callable {
    public:
        atom call(std::shared_ptr<environment> env, atom_list args) {
            if(args.size() != 2)
                throw L"Wrong number of arguments to +.";
            thunk t = [args]() mutable {
                return args.car()->get_integer() + args.cdr().car()->get_integer();
            };
            return make_atom(t);
        }
};

int main() {
    std::shared_ptr<environment> env = std::make_shared<environment>();
    env->set(L"+", make_atom(std::make_shared<add>()));
    atom result = evaluate(parse(L"(+ 2 2)").car(), env);
    std::wcout << std::to_wstring(result) << std::endl;
}

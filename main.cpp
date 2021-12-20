
#include "env.hpp"
#include "executor.hpp"
#include "reader/parser.hpp"

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

int main() {
    std::shared_ptr<environment> env = std::make_shared<environment>();
    env->set(L"+", make_atom(std::make_shared<add>()));
    atom a = parse(L"[2 + 2]").car();
    std::wcout << std::quoted(std::to_wstring(a)) << std::endl;
    atom result = evaluate(a, env);
    std::wcout << std::to_wstring(result) << std::endl;
}

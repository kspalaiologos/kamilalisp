
#include "env.hpp"
#include "executor.hpp"
#include "reader/parser.hpp"
#include "replxx/replxx.hxx"

#include <boost/algorithm/string.hpp>

#include <locale>
#include <codecvt>

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

int main(int argc, char * argv[]) {
    std::ios_base::sync_with_stdio(false);

    std::locale locale("en_US.utf8");

    std::wcin.imbue(locale);
    std::wcerr.imbue(locale);
    std::wcout.imbue(locale);

    std::shared_ptr<environment> env = environment::create_default_env();

    replxx::Replxx repl;

    if(argc == 1) {
        std::wstring_convert<std::codecvt_utf8<wchar_t>, wchar_t> cvt;

        std::wcout
            << "KamilaLisp v0.2 - Interactive Mode." << std::endl
            << "Copyright (C) 2021-2022 Kamila Szewczyk" << std::endl;

        while(true) {
            const char * in = repl.input("--> ");
            if(in == nullptr) {
                std::wcout << "\nBye." << std::endl;
                return 0;
            }
            repl.history_add(in);
            std::wstring data = cvt.from_bytes(in);
            boost::trim(data);
            if(data.size() == 0 || data[0] == ';')
                continue;
            atom_list a = parse(data);
            for(atom & at : a) {
                atom result = evaluate(at, env);
                std::wcout << std::to_wstring(result) << std::endl;
            }
        }
    }
}


#include "env.hpp"
#include "executor.hpp"
#include "reader/parser.hpp"
#include "replxx/replxx.hxx"
#include "error.hpp"

#include <sstream>
#include <boost/stacktrace.hpp>

#include <fstream>
#include <locale>
#include <codecvt>

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
            atom_list a;
            try {
                a = parse(data);
            } catch(std::runtime_error const & e) {
                std::wcerr << e.what() << std::endl;
                std::ostringstream buf;
                buf << boost::stacktrace::stacktrace();
                std::wcerr << buf.str().c_str() << std::endl;
            }
            try {
                for(atom & at : a) {
                    atom result = evaluate(at, env);
                    std::wcout << std::to_wstring(result) << std::endl;
                }
            } catch(std::runtime_error const & e) {
                std::wcerr << e.what() << std::endl;
                std::ostringstream buf;
                buf << boost::stacktrace::stacktrace();
                std::wcerr << buf.str().c_str() << std::endl;
            }
        }
    } else {
        std::wifstream ifs(argv[1]);
        if(!ifs.good())
            kl_error("Couldn't open file " + std::string(argv[1]));
        std::wstring data{std::istreambuf_iterator<wchar_t>(ifs),
                          std::istreambuf_iterator<wchar_t>()};
        atom_list a = parse(data);
        for(atom & at : a)
            evaluate(at, env).get()->force();
    }
}

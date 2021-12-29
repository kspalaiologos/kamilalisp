
#include "env.hpp"
#include "executor.hpp"
#include "reader/parser.hpp"
#include "replxx/replxx.hxx"
#include "replxx/replxx_impl.hxx"
#include "error.hpp"

#include <sstream>
#include <boost/stacktrace.hpp>

#include <fstream>
#include <locale>
#include <codecvt>

void highlighter(std::string const & input, replxx::Replxx::colors_t & c) {
    static std::wstring_convert<std::codecvt_utf8<wchar_t>, wchar_t> cvt;
    const static std::shared_ptr<environment> env = environment::create_default_env();
    std::wstring data = cvt.from_bytes(input.c_str());
    std::vector<token> lexemes = lex_greedy(data);
    try {
        for (auto & lexeme : lexemes) {
            switch (lexeme.type) {
                case token_type::TOKEN_ID: {
                    std::wstring s = std::get<std::wstring>(*lexeme.content);
                    if(env->has(s)) {
                        for(std::size_t i = 0; i < s.size(); i++)
                            c.at(i + lexeme.loc) = replxx::Replxx::Color::MAGENTA;
                    }
                    break;
                }
                case token_type::TOKEN_HEX:
                case token_type::TOKEN_FPU:
                case token_type::TOKEN_COMPLEX:
                case token_type::TOKEN_INT:
                case token_type::TOKEN_BIN: {
                    std::string s = std::get<std::string>(*lexeme.content);
                    for(std::size_t i = 0; i < s.size(); i++)
                        c.at(i + lexeme.loc) = replxx::Replxx::Color::YELLOW;
                    break;
                }
                case token_type::TOKEN_STR: {
                    std::wstring s = std::get<std::wstring>(*lexeme.content);
                    for(std::size_t i = 0; i < s.size() + 2; i++)
                        c.at(i + lexeme.loc) = replxx::Replxx::Color::GREEN;
                    break;
                }
                case token_type::TOKEN_NIL: {
                    for(std::size_t i = 0; i < 3; i++)
                        c.at(lexeme.loc + i) = replxx::Replxx::Color::RED;
                    break;
                }
                case token_type::TOKEN_TACK: {
                    std::string s = std::get<std::string>(*lexeme.content);
                    for(std::size_t i = 0; i < s.size() + 1; i++)
                        c.at(i + lexeme.loc) = replxx::Replxx::Color::BROWN;
                    break;
                }
                case token_type::TOKEN_LBRA:
                case token_type::TOKEN_RBRA:
                case token_type::TOKEN_LPAR:
                case token_type::TOKEN_RPAR: {
                    c.at(lexeme.loc) = replxx::Replxx::Color::BLUE;
                    break;
                }
                case token_type::TOKEN_ATOP:
                case token_type::TOKEN_BIND:
                case token_type::TOKEN_FORK:
                case token_type::TOKEN_QUOT:
                case token_type::TOKEN_SLASH:
                case token_type::TOKEN_OVER:
                case token_type::TOKEN_MAP: {
                    c.at(lexeme.loc) = replxx::Replxx::Color::RED;
                    break;
                }
                case token_type::TOKEN_EMPTY:
                    // Ignore.
                    break;
            }
        }
    } catch(std::exception const& e) {
        std::wcerr << "Exception thrown." << e.what() << std::endl;
        print_stack_trace();
        stacktrace.clear();
    }
}

auto res(replxx::Replxx & instance) {
    return [&instance](char32_t c) -> replxx::Replxx::ACTION_RESULT {
        (void) c;
        static std::wstring_convert<std::codecvt_utf8<wchar_t>, wchar_t> cvt;
        const char * text = instance.get_state().text();
        std::wstring data = cvt.from_bytes(text);
        try { parse(data); } catch(std::domain_error const&) {
            instance.invoke(replxx::Replxx::ACTION::NEW_LINE, '\n');
            return replxx::Replxx::ACTION_RESULT::CONTINUE;
        } catch(...) { }
        return replxx::Replxx::ACTION_RESULT::RETURN;
    };
}

int main(int argc, char * argv[]) {
    std::ios_base::sync_with_stdio(false);

    std::locale locale("en_US.utf8");

    std::wcin.imbue(locale);
    std::wcerr.imbue(locale);
    std::wcout.imbue(locale);

    std::shared_ptr<environment> env = environment::create_default_env();

    boost::multiprecision::mpf_float::default_precision(25);

    if(argc == 1) {
        replxx::Replxx repl;
        std::wstring_convert<std::codecvt_utf8<wchar_t>, wchar_t> cvt;

        std::wcout
            << "KamilaLisp v0.2 - Interactive Mode." << std::endl
            << "Copyright (C) 2021-2022 Kamila Szewczyk" << std::endl;
        
        // Bug workaround.
        // https://github.com/AmokHuginnsson/replxx/issues/137
        repl.history_add("");
        repl.install_window_change_handler();
        repl.set_highlighter_callback(highlighter);
        repl.set_indent_multiline(true);

        repl.bind_key(replxx::Replxx::KEY::ENTER + 0, res(repl));

        while(true) {
            const char * in = repl.input("--> ");
            if(in == nullptr) {
                std::wcout << "\nBye." << std::endl;
                return 0;
            }
            repl.history_add(std::string(in));
            try {
                std::wstring data = cvt.from_bytes(in);
                atom_list a = parse(data);
                for(atom & at : a) {
                    atom result = evaluate(at, env);
                    std::wcout << std::to_wstring(result) << std::endl;
                }
            } catch(std::exception const & e) {
                std::wcerr << e.what() << std::endl;
                print_stack_trace();
                stacktrace.clear();
            }
        }
    } else {
        std::wifstream ifs(argv[1]);
        if(!ifs.good())
            kl_error("Couldn't open file " + std::string(argv[1]));
        std::wstring data{std::istreambuf_iterator<wchar_t>(ifs),
                          std::istreambuf_iterator<wchar_t>()};
        try {
            atom_list a = parse(data);
            for(atom & at : a)
                evaluate(at, env).get()->force();
        } catch(std::exception const & e) {
            std::wcerr << e.what() << std::endl;
            print_stack_trace();
            stacktrace.clear();
        }
    }
}

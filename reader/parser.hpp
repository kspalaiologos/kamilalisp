
#ifndef __PARSER_HPP
#define __PARSER_HPP

#include "lexer.hpp"
#include "token.hpp"
#include "../atom.hpp"
#include <vector>

template <typename Source>
std::vector<token> lex_all(Source & in) {
    std::vector<token> tokens;
    std::ostream bitBucket(0);
    Lexer l = Lexer(in, bitBucket);
    while (true) {
        token t = l.lex();
        if (t.type == token_type::TOKEN_EMPTY)
            break;
        else if (t.type == token_type::TOKEN_TRASH)
                continue;
        tokens.push_back(t);
    }
    return tokens;
}

template <typename Source>
std::vector<token> lex_greedy(Source & in) {
    std::vector<token> tokens;
    std::ostream bitBucket(0);
    Lexer l = Lexer(in, bitBucket);
    // Ignore errors, lex as much as possible.
    try {
        while (true) {
            token t = l.lex();
            if (t.type == token_type::TOKEN_EMPTY)
                break;
            else if (t.type == token_type::TOKEN_TRASH)
                continue;
            tokens.push_back(t);
        }
    } catch(...) { }
    return tokens;
}

template <typename Source>
std::vector<token> lex_hl(const Source & in) {
    std::vector<token> tokens;
    std::ostream bitBucket(0);
    Lexer l = Lexer(in, bitBucket);
    // Ignore errors, lex as much as possible.
    try {
        while (true) {
            token t = l.lex();
            if (t.type == token_type::TOKEN_EMPTY)
                break;
            tokens.push_back(t);
        }
    } catch(...) { }
    return tokens;
}

template <typename Source>
atom_list parse(const Source & in) {
    return parse_all(lex_all(in));
}

template <typename Source>
atom_list parse(Source && in) {
    return parse_all(lex_all(in));
}

atom_list parse_all(const std::vector<token> &);

#endif

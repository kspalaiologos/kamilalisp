
#ifndef __PARSER_HPP
#define __PARSER_HPP

#include "lexer.hpp"
#include "token.hpp"
#include "../atom.hpp"
#include <vector>

template <typename Source>
std::vector<token> lex_all(Source & in) {
    std::vector<token> tokens;
    Lexer l = Lexer(in);
    while (true) {
        token t = l.lex();
        if (t.type == token_type::TOKEN_EMPTY)
            break;
        tokens.push_back(t);
    }
    return tokens;
}

template <typename Source>
atom_list parse(Source & in) {
    return parse_all(lex_all(in));
}

atom_list parse_all(const std::vector<token> &);

#endif

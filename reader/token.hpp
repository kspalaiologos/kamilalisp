
#ifndef _TOKEN_HPP
#define _TOKEN_HPP

#include <string>
#include <optional>

enum class token_type {
    TOKEN_ID, TOKEN_NIL, TOKEN_COMPLEX, TOKEN_FPU,
    TOKEN_BIN, TOKEN_HEX, TOKEN_INT, TOKEN_STR,
    TOKEN_LBRA, TOKEN_RBRA, TOKEN_OVER, TOKEN_SLASH,
    TOKEN_ATOP, TOKEN_MAP, TOKEN_TACK, TOKEN_FORK,
    TOKEN_BIND, TOKEN_LPAR, TOKEN_RPAR, TOKEN_EMPTY
};

class token {
    public:
        std::optional<std::wstring> content;
        token_type type;

        token(std::wstring content, token_type type)
            : content(content), type(type) { }
        
        token(token_type type)
            : content(std::nullopt), type(type) { }
        
        token()
            : content(std::nullopt), type(token_type::TOKEN_EMPTY) { }
};

#endif

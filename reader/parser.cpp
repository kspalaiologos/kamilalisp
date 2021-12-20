
#include <charconv>
#include <string_view>
#include "parser.hpp"

struct token_queue {
    private:
        const std::vector<token> & tokens;
        size_t pos;
    public:
        token_queue(const std::vector<token> & tokens)
            : tokens(tokens), pos(0) { }
        
        token next() {
            if (pos >= tokens.size())
                return token();
            return tokens[pos++];
        }

        bool empty() const {
            return pos >= tokens.size();
        }

        void reset() {
            pos = 0;
        }

        token peek() const {
            if (pos >= tokens.size())
                return token();
            return tokens[pos];
        }
};

atom parse_tack(token & t) {
    std::string content = std::get<std::string>(*t.content);
    int tack_no;
    auto [ptr, ec] {
        std::from_chars(content.data() + 1, content.data() + content.size(), tack_no)
    };

    class tack : public callable {
        int tack_no;

        public:
            tack(int tack_no) : tack_no(tack_no) { }

            atom call(std::shared_ptr<environment> env, atom_list args) {
                return args.at(tack_no);
            }
    };

    return make_atom(tack(tack_no));
}

atom parse_map(token_queue & q){
    atom form = parse_form_rem(q);
    atom_list l = atom_list::from(
        make_atom(identifier(L"bind")),
        make_atom(identifier(L"map")),
        form
    );
    return make_atom(l);
}

atom parse_partition(token & t) {
    return make_atom(identifier(L"\\"));
}

atom parse_quote(token_queue & q) {
    atom form = parse_form(q);
    return atom_list::from(
        make_atom(identifier(L"quote")),
        form
    );
}

atom parse_list(token_queue & q) {
    atom_list l{};
    while(q.peek().type != token_type::TOKEN_RPAR)
        l = l.unsafe_append(parse_form(q));
    return make_atom(l);
}

atom parse_sqlist(token_queue & q) {
    atom_list l{};
    while(q.peek().type != token_type::TOKEN_RBRA)
        l = l.unsafe_append(parse_form(q));
    if(l.size() > 2) {
        atom begin = l.car();
        l.car() = l.cdr().car();
        l.cdr().car() = begin;
    }
    return make_atom(l);
}

atom parse_bind(token_queue & q) {
    token paren = q.next();
    atom l;
    
    if(paren.type == token_type::TOKEN_LPAR) {
        l = parse_list(q);
    } else if(paren.type == token_type::TOKEN_LBRA) {
        l = parse_sqlist(q);
    } else {
        throw new std::runtime_error("Expected ( or [ after $.");
    }

    return make_atom(l->get_list().cons(make_atom(identifier(L"bind"))));
}

atom parse_fork(token_queue & q) {
    token paren = q.next();
    atom l;
    
    if(paren.type == token_type::TOKEN_LPAR) {
        l = parse_list(q);
    } else if(paren.type == token_type::TOKEN_LBRA) {
        l = parse_sqlist(q);
    } else {
        throw new std::runtime_error("Expected ( or [ after #.");
    }

    return make_atom(l->get_list().cons(make_atom(identifier(L"fork"))));
}

atom parse_literal(token & t) {
    switch(t.type) {
        case token_type::TOKEN_STR:
            return make_atom(std::get<std::wstring>(*t.content));
        case token_type::TOKEN_NIL:
            return null_atom;
        case token_type::TOKEN_ID:
            return make_atom(identifier(std::get<std::wstring>(*t.content)));
        case token_type::TOKEN_COMPLEX: {
            std::string num = std::get<std::string>(*t.content);
            std::size_t n = num.find('J');
            std::string re = num.substr(0, n);
            std::string im = num.substr(n + 1);
            boost::multiprecision::mpc_complex res{};
            res.imag(boost::multiprecision::mpfr_float{im});
            res.real(boost::multiprecision::mpfr_float{re});
            return make_atom(res);
        }
        case token_type::TOKEN_HEX:
        case token_type::TOKEN_FPU:
        case token_type::TOKEN_INT:
        case token_type::TOKEN_BIN: {
            std::string s = std::get<std::string>(*t.content);
            return make_atom(boost::multiprecision::mpz_int(s));
        }
    }
}

atom parse_form_rem(token_queue & q) {
    // form_rem :=
    //  decorator :=
    //    ' form
    //    # number
    //  fork :=
    //    # any_list
    //  bind :=
    //    $ any_list
    //  any_list
    //  literal
    //  map :=
    //    : form_rem
    //  partition :=
    //    (backslash)

    // therefore, we decide on the type of this
    // tree based on the token we get.
    // '             - quote
    // # and integer - tack
    // #             - fork
    // $             - bind
    // :             - map
    // \             - partition
    // ( or [        - list
    // otherwise     - literal

    token t = q.next();
    switch(t.type) {
        case token_type::TOKEN_QUOT:
            return parse_quote(q);
        case token_type::TOKEN_FORK:
            return parse_fork(q);
        case token_type::TOKEN_BIND:
            return parse_bind(q);
        case token_type::TOKEN_MAP:
            return parse_map(q);
        case token_type::TOKEN_SLASH:
            return parse_partition(t);
        case token_type::TOKEN_TACK:
            return parse_tack(t);
        case token_type::TOKEN_LBRA:
            return parse_sqlist(q);
        case token_type::TOKEN_LPAR:
            return parse_list(q);
        default:
            return parse_literal(t);
    }
}

atom parse_form(token_queue & q) {
    // form := form_rem (@ form_rem)*
    std::vector<atom> rems;
    atom first_form = parse_form_rem(q);
    rems.push_back(first_form);
    while(q.peek().type == token_type::TOKEN_ATOP) {
        q.next();
        rems.push_back(parse_form_rem(q));
    }
    if(rems.size() != 1) {
        atom_list l = atom_list::from(make_atom(identifier(L"atop")));
        for (auto it = rems.rbegin(); it != rems.rend(); ++it)
            l = l.cons(*it);
        return make_atom(l);
    } else
        return first_form;
}

atom_list parse_all(const std::vector<token> & t) {
    token_queue q = token_queue(t);
    atom_list result{};
    while(!q.empty())
        result = result.unsafe_append(parse_form(q));
    return result;
}

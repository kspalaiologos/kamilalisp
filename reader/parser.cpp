
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

atom parse_tack(token t) {
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
            return parse_partition(q);
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

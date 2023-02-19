
// ! % &

grammar Grammar;

@header {
    package palaiologos.kamilalisp.parsers;
}

file_: form * EOF;

form: form_rem (BIND form_rem)*
    ;

form_rem: literal
        | obj
        | form_rem DOLLAR sqlist
        | form_rem PERCENT sqlist
        | form_rem DOT (number | symbol)
        | bind
        | any_list
        | reader_macro
        | map
        | parallel_map
        ;

list_form
        : form
        | LISTPART
        ;

any_list: list_ | sqlist ;

list_: '(' list_form* ')' ;
sqlist: '[' list_form* ']' ;

obj : '%{' pair (',' pair)* '}'
    | '%{' '}'
    ;
pair : form ARROW form ;

reader_macro
    : quote
    | tack
    | over
    | self
    ;

self
    : SELF LONG
    ;

quote
    : QUOTE form
    ;

map
    : MAPSYM form_rem
    ;

parallel_map
    : DOLLAR MAPSYM form_rem
    ;

over
    : SWIZZLE form_rem
    ;

tack
    : LONG TACKTACK LONG
    | TACK LONG
    ;

bind
    : DOLLAR list_
    ;

literal
    : number
    | string_
    | nil_
    | symbol
    ;

string_: STRING;
hex_: DOLLAR? HEX ;
bin_: DOLLAR? BIN ;
long_: DOLLAR? LONG ;
number
    : COMPLEX
    | hex_
    | bin_
    | FLOAT
    | long_
    ;

nil_: NIL;

symbol: NAME | ARROW;

// Lexers
//--------------------------------------------------------------------

STRING : '"' ( ~'"' | '\\' '"' )* '"' ;

COMPLEX: (FLOAT | LONG) 'J' (FLOAT | LONG);

FLOAT
    : '-'? [0-9]+ FLOAT_TAIL
    ;

fragment
FLOAT_TAIL
    : FLOAT_DECIMAL FLOAT_EXP
    | FLOAT_DECIMAL
    | FLOAT_EXP
    ;

fragment
FLOAT_DECIMAL
    : '.' [0-9]+
    ;

fragment
FLOAT_EXP
    : [eE] '-'? [0-9]+
    ;
fragment
HEXD: [0-9a-fA-F] ;

ARROW: '=>' ;

HEX: '0' [xX] HEXD+ ;
BIN: '0' [bB] [10]+ ;
LONG: '-'? [0-9]+;

NIL : 'nil' | '⍬';

// Note: This all is required only because ANTLR is garbage
// and can't inline rules on it's own.
// Normally I'd have made a rule with NOTID and inverted it in a set.

SELF: '&';
BIND: '@'|'∘';
QUOTE: '\'';
LISTPART: '\\';
MAPSYM: ':';
DOLLAR: '$' ;
PERCENT: '%' ;
SWIZZLE: '^';
DOT: '.' ;
TACKTACK: '##';
TACK: '#';

fragment
NOTID: ~('∘' | '⍬' | '⍨' | '.' | '@' | '$' | '%' | '^' | '\r' | '\n' | ' ' | '(' | ')' | '[' | ']' | ',' | '{' | '}' | ';' | '&') ;

fragment
NOTID_START: ~('∘' | '.' | '⍬' | '⍨' | '#' | '^' | '%' |'$' | '\\' | '\'' | '@' | '\r' | '\n' | ' ' | ',' | '(' | ')' | '{' | '}' | '[' | ']' | ';' | ':' | '&' | '0'..'9') ;

NAME: '...'? NOTID_START NOTID* ;

// Discard
//--------------------------------------------------------------------

WS : [ \t\r\n]+ -> skip ;
COMMENT: ';' ~[\r\n]* -> skip ;



// ! % &

grammar Grammar;

@header {
    package palaiologos.kamilalisp.parser;
}

file_: form * EOF;

form: form_rem (('@'|'∘') form_rem)*
    ;

form_rem: literal
        | form_rem DOLLAR sqlist
        | form_rem PERCENT sqlist
        | bind
        | any_list
        | reader_macro
        | map
        | parallel_map
        ;

list_form
        : form
        | '\\'
        ;

any_list: list_ | sqlist ;

list_: '(' list_form* ')' ;
sqlist: '[' list_form* ']' ;

reader_macro
    : quote
    | tack
    | over
    | self
    ;

self
    : '&' LONG
    ;

quote
    : '\'' form
    ;

map
    : ':' form_rem
    ;

parallel_map
    : DOLLAR ':' form_rem
    ;

over
    : '^' form_rem
    ;

tack
    : LONG '##' LONG
    | '#' LONG
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

symbol: NAME;

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

HEX: '0' [xX] HEXD+ ;
BIN: '0' [bB] [10]+ ;
LONG: '-'? [0-9]+;

NIL : 'nil' | '⍬';

// Note: This all is required only because ANTLR is garbage
// and can't inline rules on it's own.
// Normally I'd have made a rule with NOTID and inverted it in a set.

DOLLAR: '$' ;
PERCENT: '%' ;

fragment
NOTID: ~('∘' | '⍬' | '⍨' | '@' | '$' | '%' | '^' | '\r' | '\n' | ' ' | '(' | ')' | '[' | ']' | ';' | '&') ;

fragment
NOTID_START: ~('∘' | '⍬' | '⍨' | '#' | '^' | '%' |'$' | '\\' | '\'' | '@' | '\r' | '\n' | ' ' | '(' | ')' | '[' | ']' | ';' | ':' | '&' | '0'..'9') ;

NAME: NOTID_START NOTID* ;

// Discard
//--------------------------------------------------------------------

fragment
WS : [ \t\r\n]+ ;

fragment
COMMENT: ';' ~[\r\n]* ;

TRASH
    : ( WS | COMMENT ) -> channel(HIDDEN)
    ;

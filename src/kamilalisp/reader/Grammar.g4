grammar Grammar;

file_: form * EOF;

form: form_at ('^' form_at)*
    ;

form_at: form_rem ('@' form_rem)*
    ;

form_rem: reader_macro
        | fork
        | bind
        | any_list
        | literal
        | map
        | partition
        ;

forms: form* ;

any_list: list_ | sqlist ;

list_: '(' forms ')' ;
sqlist: '[' forms ']' ;

reader_macro
    : quote
    | tack
    ;

partition
    : '\\'
    ;

quote
    : '\'' form
    ;

map
    : ':' form_rem
    ;

fork
    : '#' any_list
    ;

tack
    : '#' number
    ;

bind
    : '$' any_list
    ;

literal
    : number
    | string_
    | nil_
    | symbol
    ;

string_: STRING;
hex_: HEX;
bin_: BIN;
number
    : COMPLEX
    | hex_
    | bin_
    | FLOAT
    | LONG
    ;

nil_: NIL;

symbol: NAME;

// Lexers
//--------------------------------------------------------------------

STRING : '"' ( ~'"' | '\\' '"' )* '"' ;

COMPLEX: (FLOAT | LONG) 'J' (FLOAT | LONG);

FLOAT
    : '-'? [0-9]+ FLOAT_TAIL
    | '-'? 'Infinity'
    | '-'? 'NaN'
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

NIL : 'nil';

// Note: This all is required only because ANTLR is garbage
// and can't inline rules on it's own.
// Normally I'd have made a rule with NOTID and inverted it in a set.

fragment
NOTID: ~('@' | '^' | '\r' | '\n' | ' ' | '(' | ')' | '[' | ']' | ';') ;

fragment
NOTID_START: ~('#' | '^' | '$' | '\\' | '\'' | '@' | '\r' | '\n' | ' ' | '(' | ')' | '[' | ']' | ';' | ':');

NAME: NOTID_START NOTID* ;

// Discard
//--------------------------------------------------------------------

fragment
WS : [ \n\r\t,] ;

fragment
COMMENT: ';' ~[\r\n]* ;

TRASH
    : ( WS | COMMENT ) -> channel(HIDDEN)
    ;
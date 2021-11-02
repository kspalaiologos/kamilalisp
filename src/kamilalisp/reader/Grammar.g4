grammar Grammar;

file_: form * EOF;

form: literal
    | list_
    | sqlist
    | reader_macro
    ;

forms: form* ;

list_: '(' forms ')' ;
sqlist: '[' forms ']' ;

reader_macro
    : quote
    | tack
    ;

quote
    : '\'' form
    ;

tack
    : '#' number
    ;

literal
    : string_
    | number
    | nil_
    | symbol
    ;

string_: STRING;
hex_: HEX;
bin_: BIN;
number
    : FLOAT
    | hex_
    | bin_
    | LONG
    ;

nil_: NIL;

symbol: SYMBOL;

// Lexers
//--------------------------------------------------------------------

STRING : '"' ( ~'"' | '\\' '"' )* '"' ;

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

SYMBOL
    : '.'
    | '/'
    | NAME
    ;

// Fragments
//--------------------------------------------------------------------

fragment
NAME: [^[\]();]+ ;

// Discard
//--------------------------------------------------------------------

fragment
WS : [ \n\r\t,] ;

fragment
COMMENT: ';' ~[\r\n]* ;

TRASH
    : ( WS | COMMENT ) -> channel(HIDDEN)
    ;
grammar FortranFormula;

@header {
    package palaiologos.kamilalisp.parsers;
}

main : toplevel_rule* EOF ;
toplevel_rule
    : ID '=' ID '=' expr
    | ID '=' expr
    | ID '(' NUMBER ')' '=' expr
    | ID '(' NUMBER ')' '=' ID '=' expr
    ;
expr
    : '(' expr ',' expr ')'
    | '(' expr ')'
    | ID '(' expr (',' expr)* ')'
    | expr '**' expr
    | expr '/' expr
    | expr '*' expr
    | expr '+' expr
    | expr '-' expr
    | CON
    | FAILED ;

ID : [A-Za-z_][A-Za-z0-9_]* ;

FAILED : '"failed"' ;

fragment SIGN : ('+' | '-') ;
fragment EXP : ('e' | 'E' | 'd' | 'D') SIGN? INUM+ ;
fragment INUM : ('0' .. '9') ;
NUMBER : SIGN? INUM+ ('.' INUM* EXP?) ;

CON : 'pi' | 'e' | 'i' | 'infinity' ;
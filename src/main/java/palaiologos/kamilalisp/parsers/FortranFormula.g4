grammar FortranFormula;

@header {
    package palaiologos.kamilalisp.parsers;
}

main : toplevel_rule* EOF ;
toplevel_rule
    : ID '=' expr # AssignExpr
    | ID '=' toplevel_rule # AssignRule
    | ID '(' NUMBER ')' '=' expr # AssignExprWithIndex
    | ID '(' NUMBER ')' '=' toplevel_rule # AssignRuleWithIndex
    ;
expr
    : expr '**' expr # Exponent
    | expr '/' expr # Division
    | expr '*' expr # Multiplication
    | expr '+' expr # Addition
    | expr '-' expr # Subtraction
    | '+' expr # UnaryPlus
    | '-' expr # UnaryMinus
    | '(' expr ',' expr ')' # ComplexConstant
    | '(' expr ')' # Parenthesis
    | ID '(' expr (',' expr)* ')' # FunctionCall
    | 'infinity' # Infinity
    | '-infinity' # NegativeInfinity
    | FAILED # Failed
    | ID # Constant
    | NUMBER # Number
    ;

ID : [A-Za-z_%][A-Za-z0-9_]* ;

FAILED : '"failed"' | '"potentialPole"' ;

fragment SIGN : ('+' | '-') ;
fragment EXP : ('e' | 'E' | 'd' | 'D') SIGN? INUM+ ;
fragment INUM : ('0' .. '9') ;
NUMBER : INUM+ ('.' INUM* EXP?)? ;

TRASH : [ \t\r\n]+ -> channel(HIDDEN) ;
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
    : ID # Constant
    | NUMBER # Number
    | FAILED # Failed
    | '(' expr ',' expr ')' # ComplexConstant
    | '(' expr ')' # Parenthesis
    | ID '(' expr (',' expr)* ')' # FunctionCall
    | expr '**' expr # Exponent
    | expr '/' expr # Division
    | expr '*' expr # Multiplication
    | expr '+' expr # Addition
    | expr '-' expr # Subtraction
    ;

ID : [A-Za-z_][A-Za-z0-9_]* ;

FAILED : '"failed"' | '"potentialPole"' ;

fragment SIGN : ('+' | '-') ;
fragment EXP : ('e' | 'E' | 'd' | 'D') SIGN? INUM+ ;
fragment INUM : ('0' .. '9') ;
NUMBER : SIGN? INUM+ ('.' INUM* EXP?)? ;

TRASH : [ \t\r\n]+ -> channel(HIDDEN) ;

; )package "BOOT"

(IN-PACKAGE "BOOT")

; init_output_properties() ==
;     for sv in [ _
;       ["LET", '" := "], ["/", '"/"], ["*", '"*"], ["TENSOR", '" # "], _
;       ["**", '"**"], ["^", '"^"], [":", '":"], ["::", '"::"], _
;       ["@", '"@"], ["SEL", '"."], ["exquo", '" exquo "], ["div", '" div "], _
;       ["quo", '" quo "], ["rem", '" rem "], ["case", '" case "], _
;       ["and", '" and "], ["or", '" or "], ["TAG", '" -> "], _
;       ["+->", '" +-> "], ["SEGMENT", '".."], ["in", '" in "], _
;       ["~=", '"~="], ["JOIN", '" JOIN "], ["EQUATNUM", '"  "], _
;       ["=", '" = "], ["==", '" == "], [">=", '" >= "], [">", '" > "], _
;       ["<=", '" <= "], ["<", '" < "], ["|", '" | "], ["+", " + "], _
;       ["-", '" - "], ["WHERE", '" WHERE "], ["MAX", '" MAX "], _
;       ["MIN", '" MIN "]] repeat
;         MAKEPROP(first(sv), 'INFIXOP, first(rest(sv)))
;
;     for sv in [ _
;       ["=", '"="], [":", '":"], ["not", '"~ "], ["|", '" | "], _
;       ["SEGMENT", '".."]] repeat
;         MAKEPROP(first(sv), 'PREFIXOP, first(rest(sv)))
;
;     for spv in [ _
;       ["-", "APP", "appneg"], ["-", "WIDTH", "minusWidth"], _
;       ["/", "APP", "appfrac"], ["/", "SUBSPAN", "fracsub"], _
;       ["/", "SUPERSPAN", "fracsuper"], ["/", "WIDTH", "fracwidth"], _
;       ["AGGSET", "APP", "argsapp"], ["AGGSET", "SUBSPAN", "agggsub"], _
;       ["AGGSET", "SUPERSPAN", "agggsuper"], ["AGGSET", "WIDTH", "agggwidth"], _
;       ["binom", "APP", "binomApp"], ["binom", "SUBSPAN", "binomSub"], _
;       ["binom", "SUPERSPAN", "binomSuper"], ["binom", "WIDTH", "binomWidth"], _
;       ["ALTSUPERSUB", "APP", "altSuperSubApp"], _
;       ["ALTSUPERSUB", "SUBSPAN", "altSuperSubSub"], _
;       ["ALTSUPERSUB", "SUPERSPAN", "altSuperSubSuper"], _
;       ["ALTSUPERSUB", "WIDTH", "altSuperSubWidth"], _
;       ["BOX", "APP", "boxApp"], ["BOX", "SUBSPAN", "boxSub"], _
;       ["BOX", "SUPERSPAN", "boxSuper"], ["BOX", "WIDTH", "boxWidth"], _
;       ["BRACKET", "SUBSPAN", "qTSub"], ["BRACKET", "SUPERSPAN", "qTSuper"], _
;       ["BRACKET", "WIDTH", "qTWidth"], _
;       ["CENTER", "APP", "centerApp"], _
;       ["EXT", "APP", "appext"], ["EXT", "SUBSPAN", "extsub"], _
;       ["EXT", "SUPERSPAN", "extsuper"], ["EXT", "WIDTH", "extwidth"], _
;       ["MATRIX", "APP", "appmat"], ["MATRIX", "SUBSPAN", "matSub"], _
;       ["MATRIX", "SUPERSPAN", "matSuper"], ["MATRIX", "WIDTH", "matWidth"], _
;       ["NOTHING", "APP", "nothingApp"], _
;       ["NOTHING", "SUBSPAN", "nothingSub"], _
;       ["NOTHING", "SUPERSPAN", "nothingSuper"], _
;       ["NOTHING", "WIDTH", "nothingWidth"], _
;       ["OVER", "APP", "appfrac"], ["OVER", "SUBSPAN", "fracsub"], _
;       ["OVER", "SUPERSPAN", "fracsuper"], ["OVER", "WIDTH", "fracwidth"], _
;       ["OVERLABEL", "APP", "overlabelApp"], _
;       ["OVERLABEL", "SUPERSPAN", "overlabelSuper"], _
;       ["OVERLABEL", "WIDTH", "overlabelWidth"], _
;       ["OVERBAR", "APP", "overbarApp"], _
;       ["OVERBAR", "SUPERSPAN", "overbarSuper"], _
;       ["OVERBAR", "WIDTH", "overbarWidth"], _
;       ["PAREN", "APP", "appparu1"], ["PAREN", "SUBSPAN", "qTSub"], _
;       ["PAREN", "SUPERSPAN", "qTSuper"], ["PAREN", "WIDTH", "qTWidth"], _
;       ["PRIME", "APP", "primeApp"], ["PRIME", "SUBSPAN", "primeSub"], _
;       ["PRIME", "SUPERSPAN", "primeSuper"], ["PRIME", "WIDTH", "primeWidth"], _
;       ["ROOT", "APP", "rootApp"], ["ROOT", "SUBSPAN", "rootSub"], _
;       ["ROOT", "SUPERSPAN", "rootSuper"], ["ROOT", "WIDTH", "rootWidth"], _
;       ["ROW", "WIDTH", "eq0"], _
;       ["SC", "APP", "appsc"], ["SC", "SUBSPAN", "agggsub"], _
;       ["SC", "SUPERSPAN", "agggsuper"], ["SC", "WIDTH", "widthSC"], _
;       ["SETQ", "APP", "appsetq"], ["SETQ", "WIDTH", "letWidth"], _
;       ["SLASH", "APP", "slashApp"], ["SLASH", "SUBSPAN", "slashSub"], _
;       ["SLASH", "SUPERSPAN", "slashSuper"], ["SLASH", "WIDTH", "slashWidth"], _
;       ["SUB", "APP", "appsub"], ["SUB", "SUBSPAN", "subSub"], _
;       ["SUB", "SUPERSPAN", "subSuper"], ["SUB", "WIDTH", "suScWidth"], _
;       ["SUPERSUB", "APP", "superSubApp"], _
;       ["SUPERSUB", "SUBSPAN", "superSubSub"], _
;       ["SUPERSUB", "SUPERSPAN", "superSubSuper"], _
;       ["SUPERSUB", "WIDTH", "superSubWidth"], _
;       ["VCONCAT", "APP", "vconcatapp"], _
;       ["VCONCAT", "SUBSPAN", "vConcatSub"], _
;       ["VCONCAT", "SUPERSPAN", "vConcatSuper"], _
;       ["VCONCAT", "WIDTH", "vConcatWidth"], _
;       ["BINOMIAL", "APP", "binomialApp"], _
;       ["BINOMIAL", "SUBSPAN", "binomialSub"], _
;       ["BINOMIAL", "SUPERSPAN", "binomialSuper"], _
;       ["BINOMIAL", "WIDTH", "binomialWidth"], _
;       ["ZAG", "APP", "zagApp"], ["ZAG", "SUBSPAN", "zagSub"], _
;       ["ZAG", "SUPERSPAN", "zagSuper"], ["ZAG", "WIDTH", "zagWidth"], _
;       ["+", "APP", "plusApp"], ["+", "WIDTH", "sumWidth"], _
;       ["*", "APP", "timesApp"], ["*", "WIDTH", "timesWidth"], _
;       ["TENSOR", "APP", "tensorApp"], ["TENSOR", "WIDTH", "tensorWidth"], _
;       ["^", "APP", "exptApp"], ["^", "SUBSPAN", "exptSub"], _
;       ["^", "SUPERSPAN", "exptSuper"], ["^", "WIDTH", "exptWidth"], _
;       ["STEP", "APP", "stepApp"], ["STEP", "SUBSPAN", "stepSub"], _
;       ["STEP", "SUPERSPAN", "stepSuper"], ["STEP", "WIDTH", "stepWidth"], _
;       ["IN", "APP", "inApp"], ["IN", "SUBSPAN", "inSub"], _
;       ["IN", "SUPERSPAN", "inSuper"], ["IN", "WIDTH", "inWidth"], _
;       ["AGGLST", "APP", "aggApp"], ["AGGLST", "SUBSPAN", "aggSub"], _
;       ["AGGLST", "SUPERSPAN", "aggSuper"], _
;       ["CONCATB", "APP", "concatbApp"], _
;       ["CONCATB", "SUBSPAN", "concatSub"], _
;       ["CONCATB", "SUPERSPAN", "concatSuper"], _
;       ["CONCATB", "WIDTH", "concatbWidth"], _
;       ["CONCAT", "APP", "concatApp"], _
;       ["CONCAT", "SUBSPAN", "concatSub"], _
;       ["CONCAT", "SUPERSPAN", "concatSuper"], _
;       ["CONCAT", "WIDTH", "concatWidth"], _
;       ["QUOTE", "APP", "quoteApp"], _
;       ["QUOTE", "SUBSPAN", "quoteSub"], _
;       ["QUOTE", "SUPERSPAN", "quoteSub"], _
;       ["QUOTE", "WIDTH", "quoteWidth"], _
;       ["STRING", "APP", "stringApp"], _
;       ["STRING", "SUBSPAN", "eq0"], _
;       ["STRING", "SUPERSPAN", "eq0"], _
;       ["STRING", "WIDTH", "stringWidth"], _
;       ["SIGMA", "APP", "sigmaApp"], _
;       ["SIGMA", "SUBSPAN", "sigmaSub"], _
;       ["SIGMA", "SUPERSPAN", "sigmaSup"], _
;       ["SIGMA", "WIDTH", "sigmaWidth"], _
;       ["SIGMA2", "APP", "sigma2App"], _
;       ["SIGMA2", "SUBSPAN", "sigma2Sub"], _
;       ["SIGMA2", "SUPERSPAN", "sigma2Sup"], _
;       ["SIGMA2", "WIDTH", "sigma2Width"], _
;       ["SIGMA2", "SUBSPAN", "sigma2Sub"], _
;       ["SIGMA2", "SUPERSPAN", "sigma2Sup"], _
;       ["INTSIGN", "APP", "intApp"], _
;       ["INTSIGN", "SUBSPAN", "intSub"], _
;       ["INTSIGN", "SUPERSPAN", "intSup"], _
;       ["INTSIGN", "WIDTH", "intWidth"], _
;       ["PI", "APP", "piApp"], _
;       ["PI", "SUBSPAN", "piSub"], _
;       ["PI", "SUPERSPAN", "piSup"], _
;       ["PI", "WIDTH", "piWidth"], _
;       ["PI2", "APP", "pi2App"], _
;       ["PI2", "SUBSPAN", "pi2Sub"], _
;       ["PI2", "SUPERSPAN", "pi2Sup"], _
;       ["PI2", "WIDTH", "pi2Width"], _
;       ["AGGLST", "WIDTH", "aggWidth"], _
;       ["BRACKET", "APP", "bracketApp"], _
;       ["BRACE", "APP", "braceApp"], _
;       ["BRACE", "WIDTH", "qTWidth"]] repeat
;         MAKEPROP(first(spv), first(rest(spv)), first(rest(rest(spv))))

(DEFUN |init_output_properties| ()
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#1| |sv|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |sv| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           (#1='T (MAKEPROP (CAR |sv|) 'INFIXOP (CAR (CDR |sv|)))))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       (LIST (LIST 'LET " := ") (LIST '/ "/") (LIST '* "*")
             (LIST 'TENSOR " # ") (LIST '** "**") (LIST '^ "^") (LIST '|:| ":")
             (LIST '|::| "::") (LIST '@ "@") (LIST 'SEL ".")
             (LIST '|exquo| " exquo ") (LIST '|div| " div ")
             (LIST '|quo| " quo ") (LIST '|rem| " rem ")
             (LIST '|case| " case ") (LIST '|and| " and ") (LIST '|or| " or ")
             (LIST 'TAG " -> ") (LIST '+-> " +-> ") (LIST 'SEGMENT "..")
             (LIST '|in| " in ") (LIST '~= "~=") (LIST 'JOIN " JOIN ")
             (LIST 'EQUATNUM "  ") (LIST '= " = ") (LIST '== " == ")
             (LIST '>= " >= ") (LIST '> " > ") (LIST '<= " <= ")
             (LIST '< " < ") (LIST '|\|| " | ") (LIST '+ '| + |)
             (LIST '- " - ") (LIST 'WHERE " WHERE ") (LIST 'MAX " MAX ")
             (LIST 'MIN " MIN "))
       NIL)
      ((LAMBDA (|bfVar#2| |sv|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#2|) (PROGN (SETQ |sv| (CAR |bfVar#2|)) NIL))
            (RETURN NIL))
           (#1# (MAKEPROP (CAR |sv|) 'PREFIXOP (CAR (CDR |sv|)))))
          (SETQ |bfVar#2| (CDR |bfVar#2|))))
       (LIST (LIST '= "=") (LIST '|:| ":") (LIST '|not| "~ ")
             (LIST '|\|| " | ") (LIST 'SEGMENT ".."))
       NIL)
      ((LAMBDA (|bfVar#3| |spv|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#3|) (PROGN (SETQ |spv| (CAR |bfVar#3|)) NIL))
            (RETURN NIL))
           (#1#
            (MAKEPROP (CAR |spv|) (CAR (CDR |spv|)) (CAR (CDR (CDR |spv|))))))
          (SETQ |bfVar#3| (CDR |bfVar#3|))))
       (LIST (LIST '- 'APP '|appneg|) (LIST '- 'WIDTH '|minusWidth|)
             (LIST '/ 'APP '|appfrac|) (LIST '/ 'SUBSPAN '|fracsub|)
             (LIST '/ 'SUPERSPAN '|fracsuper|) (LIST '/ 'WIDTH '|fracwidth|)
             (LIST 'AGGSET 'APP '|argsapp|) (LIST 'AGGSET 'SUBSPAN '|agggsub|)
             (LIST 'AGGSET 'SUPERSPAN '|agggsuper|)
             (LIST 'AGGSET 'WIDTH '|agggwidth|)
             (LIST '|binom| 'APP '|binomApp|)
             (LIST '|binom| 'SUBSPAN '|binomSub|)
             (LIST '|binom| 'SUPERSPAN '|binomSuper|)
             (LIST '|binom| 'WIDTH '|binomWidth|)
             (LIST 'ALTSUPERSUB 'APP '|altSuperSubApp|)
             (LIST 'ALTSUPERSUB 'SUBSPAN '|altSuperSubSub|)
             (LIST 'ALTSUPERSUB 'SUPERSPAN '|altSuperSubSuper|)
             (LIST 'ALTSUPERSUB 'WIDTH '|altSuperSubWidth|)
             (LIST 'BOX 'APP '|boxApp|) (LIST 'BOX 'SUBSPAN '|boxSub|)
             (LIST 'BOX 'SUPERSPAN '|boxSuper|) (LIST 'BOX 'WIDTH '|boxWidth|)
             (LIST 'BRACKET 'SUBSPAN '|qTSub|)
             (LIST 'BRACKET 'SUPERSPAN '|qTSuper|)
             (LIST 'BRACKET 'WIDTH '|qTWidth|) (LIST 'CENTER 'APP '|centerApp|)
             (LIST 'EXT 'APP '|appext|) (LIST 'EXT 'SUBSPAN '|extsub|)
             (LIST 'EXT 'SUPERSPAN '|extsuper|) (LIST 'EXT 'WIDTH '|extwidth|)
             (LIST 'MATRIX 'APP '|appmat|) (LIST 'MATRIX 'SUBSPAN '|matSub|)
             (LIST 'MATRIX 'SUPERSPAN '|matSuper|)
             (LIST 'MATRIX 'WIDTH '|matWidth|)
             (LIST 'NOTHING 'APP '|nothingApp|)
             (LIST 'NOTHING 'SUBSPAN '|nothingSub|)
             (LIST 'NOTHING 'SUPERSPAN '|nothingSuper|)
             (LIST 'NOTHING 'WIDTH '|nothingWidth|)
             (LIST 'OVER 'APP '|appfrac|) (LIST 'OVER 'SUBSPAN '|fracsub|)
             (LIST 'OVER 'SUPERSPAN '|fracsuper|)
             (LIST 'OVER 'WIDTH '|fracwidth|)
             (LIST 'OVERLABEL 'APP '|overlabelApp|)
             (LIST 'OVERLABEL 'SUPERSPAN '|overlabelSuper|)
             (LIST 'OVERLABEL 'WIDTH '|overlabelWidth|)
             (LIST 'OVERBAR 'APP '|overbarApp|)
             (LIST 'OVERBAR 'SUPERSPAN '|overbarSuper|)
             (LIST 'OVERBAR 'WIDTH '|overbarWidth|)
             (LIST 'PAREN 'APP '|appparu1|) (LIST 'PAREN 'SUBSPAN '|qTSub|)
             (LIST 'PAREN 'SUPERSPAN '|qTSuper|)
             (LIST 'PAREN 'WIDTH '|qTWidth|) (LIST 'PRIME 'APP '|primeApp|)
             (LIST 'PRIME 'SUBSPAN '|primeSub|)
             (LIST 'PRIME 'SUPERSPAN '|primeSuper|)
             (LIST 'PRIME 'WIDTH '|primeWidth|) (LIST 'ROOT 'APP '|rootApp|)
             (LIST 'ROOT 'SUBSPAN '|rootSub|)
             (LIST 'ROOT 'SUPERSPAN '|rootSuper|)
             (LIST 'ROOT 'WIDTH '|rootWidth|) (LIST 'ROW 'WIDTH '|eq0|)
             (LIST 'SC 'APP '|appsc|) (LIST 'SC 'SUBSPAN '|agggsub|)
             (LIST 'SC 'SUPERSPAN '|agggsuper|) (LIST 'SC 'WIDTH '|widthSC|)
             (LIST 'SETQ 'APP '|appsetq|) (LIST 'SETQ 'WIDTH '|letWidth|)
             (LIST 'SLASH 'APP '|slashApp|) (LIST 'SLASH 'SUBSPAN '|slashSub|)
             (LIST 'SLASH 'SUPERSPAN '|slashSuper|)
             (LIST 'SLASH 'WIDTH '|slashWidth|) (LIST 'SUB 'APP '|appsub|)
             (LIST 'SUB 'SUBSPAN '|subSub|) (LIST 'SUB 'SUPERSPAN '|subSuper|)
             (LIST 'SUB 'WIDTH '|suScWidth|)
             (LIST 'SUPERSUB 'APP '|superSubApp|)
             (LIST 'SUPERSUB 'SUBSPAN '|superSubSub|)
             (LIST 'SUPERSUB 'SUPERSPAN '|superSubSuper|)
             (LIST 'SUPERSUB 'WIDTH '|superSubWidth|)
             (LIST 'VCONCAT 'APP '|vconcatapp|)
             (LIST 'VCONCAT 'SUBSPAN '|vConcatSub|)
             (LIST 'VCONCAT 'SUPERSPAN '|vConcatSuper|)
             (LIST 'VCONCAT 'WIDTH '|vConcatWidth|)
             (LIST 'BINOMIAL 'APP '|binomialApp|)
             (LIST 'BINOMIAL 'SUBSPAN '|binomialSub|)
             (LIST 'BINOMIAL 'SUPERSPAN '|binomialSuper|)
             (LIST 'BINOMIAL 'WIDTH '|binomialWidth|)
             (LIST 'ZAG 'APP '|zagApp|) (LIST 'ZAG 'SUBSPAN '|zagSub|)
             (LIST 'ZAG 'SUPERSPAN '|zagSuper|) (LIST 'ZAG 'WIDTH '|zagWidth|)
             (LIST '+ 'APP '|plusApp|) (LIST '+ 'WIDTH '|sumWidth|)
             (LIST '* 'APP '|timesApp|) (LIST '* 'WIDTH '|timesWidth|)
             (LIST 'TENSOR 'APP '|tensorApp|)
             (LIST 'TENSOR 'WIDTH '|tensorWidth|) (LIST '^ 'APP '|exptApp|)
             (LIST '^ 'SUBSPAN '|exptSub|) (LIST '^ 'SUPERSPAN '|exptSuper|)
             (LIST '^ 'WIDTH '|exptWidth|) (LIST 'STEP 'APP '|stepApp|)
             (LIST 'STEP 'SUBSPAN '|stepSub|)
             (LIST 'STEP 'SUPERSPAN '|stepSuper|)
             (LIST 'STEP 'WIDTH '|stepWidth|) (LIST 'IN 'APP '|inApp|)
             (LIST 'IN 'SUBSPAN '|inSub|) (LIST 'IN 'SUPERSPAN '|inSuper|)
             (LIST 'IN 'WIDTH '|inWidth|) (LIST 'AGGLST 'APP '|aggApp|)
             (LIST 'AGGLST 'SUBSPAN '|aggSub|)
             (LIST 'AGGLST 'SUPERSPAN '|aggSuper|)
             (LIST 'CONCATB 'APP '|concatbApp|)
             (LIST 'CONCATB 'SUBSPAN '|concatSub|)
             (LIST 'CONCATB 'SUPERSPAN '|concatSuper|)
             (LIST 'CONCATB 'WIDTH '|concatbWidth|)
             (LIST 'CONCAT 'APP '|concatApp|)
             (LIST 'CONCAT 'SUBSPAN '|concatSub|)
             (LIST 'CONCAT 'SUPERSPAN '|concatSuper|)
             (LIST 'CONCAT 'WIDTH '|concatWidth|)
             (LIST 'QUOTE 'APP '|quoteApp|) (LIST 'QUOTE 'SUBSPAN '|quoteSub|)
             (LIST 'QUOTE 'SUPERSPAN '|quoteSub|)
             (LIST 'QUOTE 'WIDTH '|quoteWidth|)
             (LIST 'STRING 'APP '|stringApp|) (LIST 'STRING 'SUBSPAN '|eq0|)
             (LIST 'STRING 'SUPERSPAN '|eq0|)
             (LIST 'STRING 'WIDTH '|stringWidth|)
             (LIST 'SIGMA 'APP '|sigmaApp|) (LIST 'SIGMA 'SUBSPAN '|sigmaSub|)
             (LIST 'SIGMA 'SUPERSPAN '|sigmaSup|)
             (LIST 'SIGMA 'WIDTH '|sigmaWidth|)
             (LIST 'SIGMA2 'APP '|sigma2App|)
             (LIST 'SIGMA2 'SUBSPAN '|sigma2Sub|)
             (LIST 'SIGMA2 'SUPERSPAN '|sigma2Sup|)
             (LIST 'SIGMA2 'WIDTH '|sigma2Width|)
             (LIST 'SIGMA2 'SUBSPAN '|sigma2Sub|)
             (LIST 'SIGMA2 'SUPERSPAN '|sigma2Sup|)
             (LIST 'INTSIGN 'APP '|intApp|) (LIST 'INTSIGN 'SUBSPAN '|intSub|)
             (LIST 'INTSIGN 'SUPERSPAN '|intSup|)
             (LIST 'INTSIGN 'WIDTH '|intWidth|) (LIST 'PI 'APP '|piApp|)
             (LIST 'PI 'SUBSPAN '|piSub|) (LIST 'PI 'SUPERSPAN '|piSup|)
             (LIST 'PI 'WIDTH '|piWidth|) (LIST 'PI2 'APP '|pi2App|)
             (LIST 'PI2 'SUBSPAN '|pi2Sub|) (LIST 'PI2 'SUPERSPAN '|pi2Sup|)
             (LIST 'PI2 'WIDTH '|pi2Width|) (LIST 'AGGLST 'WIDTH '|aggWidth|)
             (LIST 'BRACKET 'APP '|bracketApp|) (LIST 'BRACE 'APP '|braceApp|)
             (LIST 'BRACE 'WIDTH '|qTWidth|))
       NIL)))))

; init_output_properties()

(EVAL-WHEN (EVAL LOAD) (PROG () (RETURN (|init_output_properties|))))

; DEFPARAMETER($plainRTspecialCharacters, [
;     '_+,      -- upper left corner   (+)
;     '_+,      -- upper right corner  (+)
;     '_+,      -- lower left corner   (+)
;     '_+,      -- lower right corner  (+)
;     '_|,      -- vertical bar
;     '_-,      -- horizontal bar      (-)
;     '_?,      -- APL quad            (?)
;     '_[,      -- left bracket
;     '_],      -- right bracket
;     '_{,      -- left brace
;     '_},      -- right brace
;     '_+,      -- top    box tee      (+)
;     '_+,      -- bottom box tee      (+)
;     '_+,      -- right  box tee      (+)
;     '_+,      -- left   box tee      (+)
;     '_+,      -- center box tee      (+)
;     '_\       -- back slash
;      ])

(DEFPARAMETER |$plainRTspecialCharacters|
  (LIST '+ '+ '+ '+ '|\|| '- '? '[ '] '{ '} '+ '+ '+ '+ '+ '|\\|))

; DEFPARAMETER($tallPar, false)

(DEFPARAMETER |$tallPar| NIL)

; DEFCONST(MATBORCH, '"*")

(EVAL-WHEN (EVAL LOAD) (PROG () (RETURN (DEFCONST MATBORCH "*"))))

; DEFCONST($EmptyString, '"")

(EVAL-WHEN (EVAL LOAD) (PROG () (RETURN (DEFCONST |$EmptyString| ""))))

; DEFCONST($DoubleQuote, '"_"")

(EVAL-WHEN (EVAL LOAD) (PROG () (RETURN (DEFCONST |$DoubleQuote| "\""))))

; DEFVAR($algebraFormat, true) -- produce 2-d algebra output

(DEFVAR |$algebraFormat| T)

; DEFVAR($fortranFormat, false) -- if true produce fortran output

(DEFVAR |$fortranFormat| NIL)

; DEFVAR($htmlFormat, false) -- if true produce HTML output

(DEFVAR |$htmlFormat| NIL)

; DEFVAR($mathmlFormat, false) -- if true produce Math ML output

(DEFVAR |$mathmlFormat| NIL)

; DEFVAR($texFormat, false) -- if true produce tex output

(DEFVAR |$texFormat| NIL)

; DEFVAR($texmacsFormat, false) -- if true produce Texmacs output

(DEFVAR |$texmacsFormat| NIL)

; DEFVAR($formattedFormat, false) -- if true produce formatted output

(DEFVAR |$formattedFormat| NIL)

; makeCharacter n == INTERN(NUM2USTR(n))

(DEFUN |makeCharacter| (|n|) (PROG () (RETURN (INTERN (NUM2USTR |n|)))))

; DEFPARAMETER($RTspecialCharacters, [
;     makeCharacter 9484,     -- upper left corner   (+)
;     makeCharacter 9488,     -- upper right corner  (+)
;     makeCharacter 9492,     -- lower left corner   (+)
;     makeCharacter 9496,     -- lower right corner  (+)
;     makeCharacter 9474,     -- vertical bar
;     makeCharacter 9472,     -- horizontal bar      (-)
;     -- $quadSymbol,      -- APL quad            (?)
;     '_?,  -- APL quad
;     '_[,      -- left bracket
;     '_],      -- right bracket
;     '_{,      -- left brace
;     '_},      -- right brace
;     makeCharacter 9516,     -- top    box tee      (+)
;     makeCharacter 9524,     -- bottom box tee      (+)
;     makeCharacter 9508,     -- right  box tee      (+)
;     makeCharacter 9500,     -- left   box tee      (+)
;     makeCharacter 9532,     -- center box tee      (+)
;     '_\       -- back slash
;      ])

(DEFPARAMETER |$RTspecialCharacters|
  (LIST (|makeCharacter| 9484) (|makeCharacter| 9488) (|makeCharacter| 9492)
        (|makeCharacter| 9496) (|makeCharacter| 9474) (|makeCharacter| 9472) '?
        '[ '] '{ '} (|makeCharacter| 9516) (|makeCharacter| 9524)
        (|makeCharacter| 9508) (|makeCharacter| 9500) (|makeCharacter| 9532)
        '|\\|))

; DEFPARAMETER($specialCharacters, $plainRTspecialCharacters)

(DEFPARAMETER |$specialCharacters| |$plainRTspecialCharacters|)

; DEFPARAMETER($specialCharacterAlist, '(
;   (ulc  .  0)_
;   (urc  .  1)_
;   (llc  .  2)_
;   (lrc  .  3)_
;   (vbar .  4)_
;   (hbar .  5)_
;   (quad .  6)_
;   (lbrk .  7)_
;   (rbrk .  8)_
;   (lbrc .  9)_
;   (rbrc . 10)_
;   (ttee . 11)_
;   (btee . 12)_
;   (rtee . 13)_
;   (ltee . 14)_
;   (ctee . 15)_
;   (bslash . 16)_
;   ))

(DEFPARAMETER |$specialCharacterAlist|
  '((|ulc| . 0) (|urc| . 1) (|llc| . 2) (|lrc| . 3) (|vbar| . 4) (|hbar| . 5)
    (|quad| . 6) (|lbrk| . 7) (|rbrk| . 8) (|lbrc| . 9) (|rbrc| . 10)
    (|ttee| . 11) (|btee| . 12) (|rtee| . 13) (|ltee| . 14) (|ctee| . 15)
    (|bslash| . 16)))

; $collectOutput := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$collectOutput| NIL))

; get_lisp_stream(fs) == REST(fs)

(DEFUN |get_lisp_stream| (|fs|) (PROG () (RETURN (REST |fs|))))

; get_algebra_stream() == get_lisp_stream($algebraOutputStream)

(DEFUN |get_algebra_stream| ()
  (PROG () (RETURN (|get_lisp_stream| |$algebraOutputStream|))))

; get_fortran_stream() == get_lisp_stream($fortranOutputStream)

(DEFUN |get_fortran_stream| ()
  (PROG () (RETURN (|get_lisp_stream| |$fortranOutputStream|))))

; get_mathml_stream() == get_lisp_stream($mathmlOutputStream)

(DEFUN |get_mathml_stream| ()
  (PROG () (RETURN (|get_lisp_stream| |$mathmlOutputStream|))))

; get_texmacs_stream() == get_lisp_stream($texmacsOutputStream)

(DEFUN |get_texmacs_stream| ()
  (PROG () (RETURN (|get_lisp_stream| |$texmacsOutputStream|))))

; get_html_stream() == get_lisp_stream($htmlOutputStream)

(DEFUN |get_html_stream| ()
  (PROG () (RETURN (|get_lisp_stream| |$htmlOutputStream|))))

; get_tex_stream() == get_lisp_stream($texOutputStream)

(DEFUN |get_tex_stream| ()
  (PROG () (RETURN (|get_lisp_stream| |$texOutputStream|))))

; get_formatted_stream() == get_lisp_stream($formattedOutputStream)

(DEFUN |get_formatted_stream| ()
  (PROG () (RETURN (|get_lisp_stream| |$formattedOutputStream|))))

; specialChar(symbol) ==
;   -- looks up symbol in $specialCharacterAlist, gets the index
;   -- into the EBCDIC table, and returns the appropriate character
;   null (code := IFCDR ASSQ(symbol,$specialCharacterAlist)) => '"?"
;   ELT($specialCharacters,code)

(DEFUN |specialChar| (|symbol|)
  (PROG (|code|)
    (RETURN
     (COND
      ((NULL (SETQ |code| (IFCDR (ASSQ |symbol| |$specialCharacterAlist|))))
       "?")
      ('T (ELT |$specialCharacters| |code|))))))

; rbrkSch() == PNAME specialChar 'rbrk

(DEFUN |rbrkSch| () (PROG () (RETURN (PNAME (|specialChar| '|rbrk|)))))

; lbrkSch() == PNAME specialChar 'lbrk

(DEFUN |lbrkSch| () (PROG () (RETURN (PNAME (|specialChar| '|lbrk|)))))

; quadSch() == PNAME specialChar 'quad

(DEFUN |quadSch| () (PROG () (RETURN (PNAME (|specialChar| '|quad|)))))

; isBinaryInfix x ==
;     x in '(_= _+ _- _* _/ _*_* _^ "=" "+" "-" "*" "/" "**" "^")

(DEFUN |isBinaryInfix| (|x|)
  (PROG ()
    (RETURN (|member| |x| '(= + - * / ** ^ "=" "+" "-" "*" "/" "**" "^")))))

; stringApp([.,u],x,y,d) ==
;   appChar(STRCONC($DoubleQuote,atom2String u,$DoubleQuote),x,y,d)

(DEFUN |stringApp| (|bfVar#4| |x| |y| |d|)
  (PROG (|u|)
    (RETURN
     (PROGN
      (SETQ |u| (CADR |bfVar#4|))
      (|appChar| (STRCONC |$DoubleQuote| (|atom2String| |u|) |$DoubleQuote|)
       |x| |y| |d|)))))

; stringWidth u ==
;   u is [.,u] or THROW('outputFailure,'outputFailure)
;   2+#u

(DEFUN |stringWidth| (|u|)
  (PROG (|ISTMP#1|)
    (RETURN
     (PROGN
      (OR
       (AND (CONSP |u|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |u| (CAR |ISTMP#1|)) 'T))))
       (THROW '|outputFailure| '|outputFailure|))
      (+ 2 (LENGTH |u|))))))

; obj2String o ==
;   atom o =>
;     STRINGP o => o
;     o = " " => '" "
;     o = ")" => '")"
;     o = "(" => '"("
;     STRINGIMAGE o
;   concatenateStringList([obj2String o' for o' in o])

(DEFUN |obj2String| (|o|)
  (PROG ()
    (RETURN
     (COND
      ((ATOM |o|)
       (COND ((STRINGP |o|) |o|) ((EQ |o| '| |) " ") ((EQ |o| '|)|) ")")
             ((EQ |o| '|(|) "(") (#1='T (STRINGIMAGE |o|))))
      (#1#
       (|concatenateStringList|
        ((LAMBDA (|bfVar#6| |bfVar#5| |o'|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#5|) (PROGN (SETQ |o'| (CAR |bfVar#5|)) NIL))
              (RETURN (NREVERSE |bfVar#6|)))
             (#1# (SETQ |bfVar#6| (CONS (|obj2String| |o'|) |bfVar#6|))))
            (SETQ |bfVar#5| (CDR |bfVar#5|))))
         NIL |o| NIL)))))))

; APP(u,x,y,d) ==
;   atom u => appChar(atom2String u,x,y,d)
;   u is [[op,:.],a] and (s:= GETL(op,'PREFIXOP)) =>
;     GETL(op,'isSuffix) => appChar(s,x+WIDTH a,y,APP(a,x,y,d))
;     APP(a,x+#s,y,appChar(s,x,y,d))
;   u is [[id,:.],:.] =>
;     fn := GETL(id,'APP) => FUNCALL(fn,u,x,y,d)
;     not NUMBERP id and (d':= appInfix(u,x,y,d))=> d'
;     appelse(u,x,y,d)
;   appelse(u,x,y,d)

(DEFUN APP (|u| |x| |y| |d|)
  (PROG (|ISTMP#1| |op| |ISTMP#2| |a| |s| |id| |fn| |d'|)
    (RETURN
     (COND ((ATOM |u|) (|appChar| (|atom2String| |u|) |x| |y| |d|))
           ((AND (CONSP |u|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |u|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |op| (CAR |ISTMP#1|)) #1='T)))
                 (PROGN
                  (SETQ |ISTMP#2| (CDR |u|))
                  (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                       (PROGN (SETQ |a| (CAR |ISTMP#2|)) #1#)))
                 (SETQ |s| (GETL |op| 'PREFIXOP)))
            (COND
             ((GETL |op| '|isSuffix|)
              (|appChar| |s| (+ |x| (WIDTH |a|)) |y| (APP |a| |x| |y| |d|)))
             (#1#
              (APP |a| (+ |x| (LENGTH |s|)) |y| (|appChar| |s| |x| |y| |d|)))))
           ((AND (CONSP |u|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |u|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |id| (CAR |ISTMP#1|)) #1#))))
            (COND ((SETQ |fn| (GETL |id| 'APP)) (FUNCALL |fn| |u| |x| |y| |d|))
                  ((AND (NULL (NUMBERP |id|))
                        (SETQ |d'| (|appInfix| |u| |x| |y| |d|)))
                   |d'|)
                  (#1# (|appelse| |u| |x| |y| |d|))))
           (#1# (|appelse| |u| |x| |y| |d|))))))

; atom2String x ==
;   IDENTP x => PNAME x
;   STRINGP x => x
;   stringer x

(DEFUN |atom2String| (|x|)
  (PROG ()
    (RETURN
     (COND ((IDENTP |x|) (PNAME |x|)) ((STRINGP |x|) |x|)
           ('T (|stringer| |x|))))))

; appChar(string,x,y,d) ==
;   if CHARP string then string := PNAME string
;   line:= LASSOC(y,d) =>
;         RPLACSTR(line, x, n := #string, string, 0, n)
;         d
;   appChar(string, x, y, nconc(d,
;             [[y, :make_full_CVEC(10 + $LINELENGTH + $MARGIN)]]))

(DEFUN |appChar| (|string| |x| |y| |d|)
  (PROG (|line| |n|)
    (RETURN
     (PROGN
      (COND ((CHARP |string|) (SETQ |string| (PNAME |string|))))
      (COND
       ((SETQ |line| (LASSOC |y| |d|))
        (PROGN
         (RPLACSTR |line| |x| (SETQ |n| (LENGTH |string|)) |string| 0 |n|)
         |d|))
       ('T
        (|appChar| |string| |x| |y|
         (NCONC |d|
                (LIST
                 (CONS |y|
                       (|make_full_CVEC|
                        (+ (+ 10 $LINELENGTH) $MARGIN))))))))))))

; mathprintWithNumber x ==
;   ioHook("startAlgebraOutput")
;   x:= outputTran2 x
;   maprin
;     $IOindex => ['EQUATNUM,$IOindex,x]
;     x
;   ioHook("endOfAlgebraOutput")

(DEFUN |mathprintWithNumber| (|x|)
  (PROG ()
    (RETURN
     (PROGN
      (|ioHook| '|startAlgebraOutput|)
      (SETQ |x| (|outputTran2| |x|))
      (|maprin| (COND (|$IOindex| (LIST 'EQUATNUM |$IOindex| |x|)) ('T |x|)))
      (|ioHook| '|endOfAlgebraOutput|)))))

; mathprint x ==
;    x := outputTran2 x
;    maprin x

(DEFUN |mathprint| (|x|)
  (PROG () (RETURN (PROGN (SETQ |x| (|outputTran2| |x|)) (|maprin| |x|)))))

; sayMath u ==
;   for x in u repeat acc:= concat(acc,linearFormatName x)
;   sayALGEBRA acc

(DEFUN |sayMath| (|u|)
  (PROG (|acc|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#7| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#7|) (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
            (RETURN NIL))
           ('T (SETQ |acc| (|concat| |acc| (|linearFormatName| |x|)))))
          (SETQ |bfVar#7| (CDR |bfVar#7|))))
       |u| NIL)
      (|sayALGEBRA| |acc|)))))

; outputTran2 x ==
;     ot2_fun := getFunctionFromDomain1("precondition", '(OutputFormTools),
;                                       $OutputForm, [$OutputForm])
;     SPADCALL(x, ot2_fun)

(DEFUN |outputTran2| (|x|)
  (PROG (|ot2_fun|)
    (RETURN
     (PROGN
      (SETQ |ot2_fun|
              (|getFunctionFromDomain1| '|precondition| '(|OutputFormTools|)
               |$OutputForm| (LIST |$OutputForm|)))
      (SPADCALL |x| |ot2_fun|)))))

; outputTran x ==
;   atom x => x
;   x is [c,var,mode] and c in '(_pretend _: _:_: _@) =>
;     var := outputTran var
;     if PAIRP var then var := ['PAREN,var]
;     ['CONCATB,var,c,obj2String prefix2String mode]
;   x is ['ADEF,vars,.,.,body] =>
;     vars :=
;         vars is [x] => x
;         ['Tuple,:vars]
;     outputTran ["+->", vars, body]
;   x is ['matrix,['construct,c]] and
;     c is ['COLLECT,:m,d] and d is ['construct,e] and e is ['COLLECT,:.] =>
;       outputTran ['COLLECT,:m,e]
;   x is ['LIST,:l] => outputTran ['BRACKET,['AGGLST,:l]]
;   x is ['SPADMAP, :l] => BREAK()
;   x is ['brace, :l]    =>
;     ['BRACE,  ['AGGLST,:[outputTran y for y in l]]]
;   x is ["return", l] => ["return", outputTran l]
;
;   x is [["$elt",domain,"float"], x, y, z] and (domain = $DoubleFloat or
;     domain is ['Float]) and INTEGERP x and INTEGERP y and INTEGERP z and
;         z > 0  and (float := getFunctionFromDomain("float",domain,[$Integer,$Integer,$PositiveInteger])) =>
;             f := SPADCALL(x,y,z,float)
;             o := coerceInteractive(mkObjWrap(f, domain), '(OutputForm))
;             objValUnwrap o
;   [op, :l] := x
;   x is ['break,:.] => 'break
;
;   op is ["$elt",targ,fun] or not $InteractiveMode and op is ["elt",targ,fun] =>
;     -- l has the args
;     targ' := obj2String prefix2String targ
;     if 2 = #targ then targ' := ['PAREN,targ']
;     ['CONCAT,outputTran [fun,:l],'"$",targ']
;   x is ["$elt",targ,c] or not $InteractiveMode and x is ["elt",targ,c] =>
;     targ' := obj2String prefix2String targ
;     if 2 = #targ then targ' := ['PAREN,targ']
;     ['CONCAT,outputTran c,'"$",targ']
;
;   op = 'IF       => outputTranIf x
;   op = 'COLLECT  => outputTranCollect x
;   op = 'REDUCE   => outputTranReduce x
;   op = 'REPEAT   => outputTranRepeat x
;   op = 'SEQ      => outputTranSEQ x
;   op in '(cons nconc) => outputConstructTran x
;   l:= [outputTran y for y in l]
;   op="|" and l is [["Tuple",:u],pred] =>
;     ['PAREN,["|",['AGGLST,:l],pred]]
;   op='Tuple  => ['PAREN,['AGGLST,:l]]
;   op='LISTOF => ['AGGLST,:l]
;   [outputTran op,:l]

(DEFUN |outputTran| (|x|)
  (PROG (|c| |ISTMP#1| |var| |ISTMP#2| |mode| |vars| |ISTMP#3| |ISTMP#4| |body|
         |d| |m| |e| |l| |domain| |ISTMP#5| |y| |ISTMP#6| |z| |float| |f| |o|
         |op| |targ| |fun| |targ'| |u| |pred|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((AND (CONSP |x|)
                 (PROGN
                  (SETQ |c| (CAR |x|))
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |var| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |mode| (CAR |ISTMP#2|)) #1='T)))))
                 (|member| |c| '(|pretend| |:| |::| @)))
            (PROGN
             (SETQ |var| (|outputTran| |var|))
             (COND ((CONSP |var|) (SETQ |var| (LIST 'PAREN |var|))))
             (LIST 'CONCATB |var| |c|
                   (|obj2String| (|prefix2String| |mode|)))))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'ADEF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |vars| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|)
                                   (PROGN
                                    (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                    (AND (CONSP |ISTMP#4|)
                                         (EQ (CDR |ISTMP#4|) NIL)
                                         (PROGN
                                          (SETQ |body| (CAR |ISTMP#4|))
                                          #1#))))))))))
            (PROGN
             (SETQ |vars|
                     (COND
                      ((AND (CONSP |vars|) (EQ (CDR |vars|) NIL)
                            (PROGN (SETQ |x| (CAR |vars|)) #1#))
                       |x|)
                      (#1# (CONS '|Tuple| |vars|))))
             (|outputTran| (LIST '+-> |vars| |body|))))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|matrix|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN
                        (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (EQ (CAR |ISTMP#2|) '|construct|)
                             (PROGN
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN (SETQ |c| (CAR |ISTMP#3|)) #1#)))))))
                 (CONSP |c|) (EQ (CAR |c|) 'COLLECT)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |c|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1#)
                       (CONSP |ISTMP#2|)
                       (PROGN
                        (SETQ |d| (CAR |ISTMP#2|))
                        (SETQ |m| (CDR |ISTMP#2|))
                        #1#)
                       (PROGN (SETQ |m| (NREVERSE |m|)) #1#)))
                 (CONSP |d|) (EQ (CAR |d|) '|construct|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |d|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |e| (CAR |ISTMP#1|)) #1#)))
                 (CONSP |e|) (EQ (CAR |e|) 'COLLECT))
            (|outputTran| (CONS 'COLLECT (APPEND |m| (CONS |e| NIL)))))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'LIST)
                 (PROGN (SETQ |l| (CDR |x|)) #1#))
            (|outputTran| (LIST 'BRACKET (CONS 'AGGLST |l|))))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'SPADMAP)
                 (PROGN (SETQ |l| (CDR |x|)) #1#))
            (BREAK))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|brace|)
                 (PROGN (SETQ |l| (CDR |x|)) #1#))
            (LIST 'BRACE
                  (CONS 'AGGLST
                        ((LAMBDA (|bfVar#9| |bfVar#8| |y|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#8|)
                                  (PROGN (SETQ |y| (CAR |bfVar#8|)) NIL))
                              (RETURN (NREVERSE |bfVar#9|)))
                             (#1#
                              (SETQ |bfVar#9|
                                      (CONS (|outputTran| |y|) |bfVar#9|))))
                            (SETQ |bfVar#8| (CDR |bfVar#8|))))
                         NIL |l| NIL))))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|return|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |l| (CAR |ISTMP#1|)) #1#))))
            (LIST '|return| (|outputTran| |l|)))
           ((AND (CONSP |x|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |x|))
                  (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|$elt|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |domain| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (EQ (CAR |ISTMP#3|) '|float|)))))))
                 (PROGN
                  (SETQ |ISTMP#4| (CDR |x|))
                  (AND (CONSP |ISTMP#4|)
                       (PROGN
                        (SETQ |x| (CAR |ISTMP#4|))
                        (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                        (AND (CONSP |ISTMP#5|)
                             (PROGN
                              (SETQ |y| (CAR |ISTMP#5|))
                              (SETQ |ISTMP#6| (CDR |ISTMP#5|))
                              (AND (CONSP |ISTMP#6|) (EQ (CDR |ISTMP#6|) NIL)
                                   (PROGN (SETQ |z| (CAR |ISTMP#6|)) #1#)))))))
                 (OR (EQUAL |domain| |$DoubleFloat|)
                     (AND (CONSP |domain|) (EQ (CDR |domain|) NIL)
                          (EQ (CAR |domain|) '|Float|)))
                 (INTEGERP |x|) (INTEGERP |y|) (INTEGERP |z|) (< 0 |z|)
                 (SETQ |float|
                         (|getFunctionFromDomain| '|float| |domain|
                          (LIST |$Integer| |$Integer| |$PositiveInteger|))))
            (PROGN
             (SETQ |f| (SPADCALL |x| |y| |z| |float|))
             (SETQ |o|
                     (|coerceInteractive| (|mkObjWrap| |f| |domain|)
                      '(|OutputForm|)))
             (|objValUnwrap| |o|)))
           (#1#
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |l| (CDR |x|))
             (COND ((AND (CONSP |x|) (EQ (CAR |x|) '|break|)) '|break|)
                   ((OR
                     (AND (CONSP |op|) (EQ (CAR |op|) '|$elt|)
                          (PROGN
                           (SETQ |ISTMP#1| (CDR |op|))
                           (AND (CONSP |ISTMP#1|)
                                (PROGN
                                 (SETQ |targ| (CAR |ISTMP#1|))
                                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                 (AND (CONSP |ISTMP#2|)
                                      (EQ (CDR |ISTMP#2|) NIL)
                                      (PROGN
                                       (SETQ |fun| (CAR |ISTMP#2|))
                                       #1#))))))
                     (AND (NULL |$InteractiveMode|) (CONSP |op|)
                          (EQ (CAR |op|) '|elt|)
                          (PROGN
                           (SETQ |ISTMP#1| (CDR |op|))
                           (AND (CONSP |ISTMP#1|)
                                (PROGN
                                 (SETQ |targ| (CAR |ISTMP#1|))
                                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                 (AND (CONSP |ISTMP#2|)
                                      (EQ (CDR |ISTMP#2|) NIL)
                                      (PROGN
                                       (SETQ |fun| (CAR |ISTMP#2|))
                                       #1#)))))))
                    (PROGN
                     (SETQ |targ'| (|obj2String| (|prefix2String| |targ|)))
                     (COND
                      ((EQL 2 (LENGTH |targ|))
                       (SETQ |targ'| (LIST 'PAREN |targ'|))))
                     (LIST 'CONCAT (|outputTran| (CONS |fun| |l|)) "$"
                           |targ'|)))
                   ((OR
                     (AND (CONSP |x|) (EQ (CAR |x|) '|$elt|)
                          (PROGN
                           (SETQ |ISTMP#1| (CDR |x|))
                           (AND (CONSP |ISTMP#1|)
                                (PROGN
                                 (SETQ |targ| (CAR |ISTMP#1|))
                                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                 (AND (CONSP |ISTMP#2|)
                                      (EQ (CDR |ISTMP#2|) NIL)
                                      (PROGN
                                       (SETQ |c| (CAR |ISTMP#2|))
                                       #1#))))))
                     (AND (NULL |$InteractiveMode|) (CONSP |x|)
                          (EQ (CAR |x|) '|elt|)
                          (PROGN
                           (SETQ |ISTMP#1| (CDR |x|))
                           (AND (CONSP |ISTMP#1|)
                                (PROGN
                                 (SETQ |targ| (CAR |ISTMP#1|))
                                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                 (AND (CONSP |ISTMP#2|)
                                      (EQ (CDR |ISTMP#2|) NIL)
                                      (PROGN
                                       (SETQ |c| (CAR |ISTMP#2|))
                                       #1#)))))))
                    (PROGN
                     (SETQ |targ'| (|obj2String| (|prefix2String| |targ|)))
                     (COND
                      ((EQL 2 (LENGTH |targ|))
                       (SETQ |targ'| (LIST 'PAREN |targ'|))))
                     (LIST 'CONCAT (|outputTran| |c|) "$" |targ'|)))
                   ((EQ |op| 'IF) (|outputTranIf| |x|))
                   ((EQ |op| 'COLLECT) (|outputTranCollect| |x|))
                   ((EQ |op| 'REDUCE) (|outputTranReduce| |x|))
                   ((EQ |op| 'REPEAT) (|outputTranRepeat| |x|))
                   ((EQ |op| 'SEQ) (|outputTranSEQ| |x|))
                   ((|member| |op| '(|cons| |nconc|))
                    (|outputConstructTran| |x|))
                   (#1#
                    (PROGN
                     (SETQ |l|
                             ((LAMBDA (|bfVar#11| |bfVar#10| |y|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#10|)
                                       (PROGN (SETQ |y| (CAR |bfVar#10|)) NIL))
                                   (RETURN (NREVERSE |bfVar#11|)))
                                  (#1#
                                   (SETQ |bfVar#11|
                                           (CONS (|outputTran| |y|)
                                                 |bfVar#11|))))
                                 (SETQ |bfVar#10| (CDR |bfVar#10|))))
                              NIL |l| NIL))
                     (COND
                      ((AND (EQ |op| '|\||) (CONSP |l|)
                            (PROGN
                             (SETQ |ISTMP#1| (CAR |l|))
                             (AND (CONSP |ISTMP#1|)
                                  (EQ (CAR |ISTMP#1|) '|Tuple|)
                                  (PROGN (SETQ |u| (CDR |ISTMP#1|)) #1#)))
                            (PROGN
                             (SETQ |ISTMP#2| (CDR |l|))
                             (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                  (PROGN (SETQ |pred| (CAR |ISTMP#2|)) #1#))))
                       (LIST 'PAREN (LIST '|\|| (CONS 'AGGLST |l|) |pred|)))
                      ((EQ |op| '|Tuple|) (LIST 'PAREN (CONS 'AGGLST |l|)))
                      ((EQ |op| 'LISTOF) (CONS 'AGGLST |l|))
                      (#1# (CONS (|outputTran| |op|) |l|))))))))))))

; outputTranSEQ ['SEQ,:l,exitform] ==
;   if exitform is ['exit,.,a] then exitform := a
;   ['SC,:[outputTran x for x in l],outputTran exitform]

(DEFUN |outputTranSEQ| (|bfVar#14|)
  (PROG (|LETTMP#1| |exitform| |l| |ISTMP#1| |ISTMP#2| |a|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE (CDR |bfVar#14|)))
      (SETQ |exitform| (CAR |LETTMP#1|))
      (SETQ |l| (NREVERSE (CDR |LETTMP#1|)))
      (COND
       ((AND (CONSP |exitform|) (EQ (CAR |exitform|) '|exit|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |exitform|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |a| (CAR |ISTMP#2|)) #1='T))))))
        (SETQ |exitform| |a|)))
      (CONS 'SC
            (APPEND
             ((LAMBDA (|bfVar#13| |bfVar#12| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#12|)
                       (PROGN (SETQ |x| (CAR |bfVar#12|)) NIL))
                   (RETURN (NREVERSE |bfVar#13|)))
                  (#1# (SETQ |bfVar#13| (CONS (|outputTran| |x|) |bfVar#13|))))
                 (SETQ |bfVar#12| (CDR |bfVar#12|))))
              NIL |l| NIL)
             (CONS (|outputTran| |exitform|) NIL)))))))

; outputTranIf ['IF,x,y,z] ==
;   y = 'noBranch =>
;     ["CONCATB", "if", ["CONCATB", "not", outputTran x], "then", outputTran z]
;   z = 'noBranch =>
;     ["CONCATB", "if", outputTran x, "then", outputTran y]
;   y' := outputTran y
;   z' := outputTran z
;   ['CONCATB, "if", outputTran x,
;     ['SC,['CONCATB, "then", y'], ['CONCATB, "else", z']]]

(DEFUN |outputTranIf| (|bfVar#15|)
  (PROG (|x| |y| |z| |y'| |z'|)
    (RETURN
     (PROGN
      (SETQ |x| (CADR . #1=(|bfVar#15|)))
      (SETQ |y| (CADDR . #1#))
      (SETQ |z| (CADDDR . #1#))
      (COND
       ((EQ |y| '|noBranch|)
        (LIST 'CONCATB '|if| (LIST 'CONCATB '|not| (|outputTran| |x|)) '|then|
              (|outputTran| |z|)))
       ((EQ |z| '|noBranch|)
        (LIST 'CONCATB '|if| (|outputTran| |x|) '|then| (|outputTran| |y|)))
       ('T
        (PROGN
         (SETQ |y'| (|outputTran| |y|))
         (SETQ |z'| (|outputTran| |z|))
         (LIST 'CONCATB '|if| (|outputTran| |x|)
               (LIST 'SC (LIST 'CONCATB '|then| |y'|)
                     (LIST 'CONCATB '|else| |z'|))))))))))

; outputTranAnon(x) ==
;     not(x is ["+->", vars, body]) => BREAK()
;     outputTran(x)

(DEFUN |outputTranAnon| (|x|)
  (PROG (|ISTMP#1| |vars| |ISTMP#2| |body|)
    (RETURN
     (COND
      ((NULL
        (AND (CONSP |x|) (EQ (CAR |x|) '+->)
             (PROGN
              (SETQ |ISTMP#1| (CDR |x|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |vars| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |body| (CAR |ISTMP#2|)) #1='T)))))))
       (BREAK))
      (#1# (|outputTran| |x|))))))

; outputMapTran(op, x) ==
;   not(x is ['SPADMAP, :l]) => BREAK()
;   null l => NIL         -- should not happen
;
;   -- display subscripts linearly
;   $linearFormatScripts : local := true
;
;   -- get the real names of the parameters
;   alias := get(op, 'alias, $InteractiveFrame)
;
;   rest l =>             -- if multiple forms, call repeatedly
;       ['SC, :[outputMapTran0(op, ll, alias) for ll in l]]
;   outputMapTran0(op, first l, alias)

(DEFUN |outputMapTran| (|op| |x|)
  (PROG (|$linearFormatScripts| |alias| |l|)
    (DECLARE (SPECIAL |$linearFormatScripts|))
    (RETURN
     (COND
      ((NULL
        (AND (CONSP |x|) (EQ (CAR |x|) 'SPADMAP)
             (PROGN (SETQ |l| (CDR |x|)) #1='T)))
       (BREAK))
      ((NULL |l|) NIL)
      (#1#
       (PROGN
        (SETQ |$linearFormatScripts| T)
        (SETQ |alias| (|get| |op| '|alias| |$InteractiveFrame|))
        (COND
         ((CDR |l|)
          (CONS 'SC
                ((LAMBDA (|bfVar#17| |bfVar#16| |ll|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#16|)
                          (PROGN (SETQ |ll| (CAR |bfVar#16|)) NIL))
                      (RETURN (NREVERSE |bfVar#17|)))
                     (#1#
                      (SETQ |bfVar#17|
                              (CONS (|outputMapTran0| |op| |ll| |alias|)
                                    |bfVar#17|))))
                    (SETQ |bfVar#16| (CDR |bfVar#16|))))
                 NIL |l| NIL)))
         (#1# (|outputMapTran0| |op| (CAR |l|) |alias|)))))))))

; outputMapTran0(op, argDef, alias) ==
;   arg := first argDef
;   def := rest  argDef
;   [arg',:def'] := simplifyMapPattern(argDef,alias)
;   arg' := outputTran arg'
;   if null arg' then arg' := '"()"
;   ['CONCATB, op, outputTran arg', "==", outputTran def']

(DEFUN |outputMapTran0| (|op| |argDef| |alias|)
  (PROG (|arg| |def| |LETTMP#1| |arg'| |def'|)
    (RETURN
     (PROGN
      (SETQ |arg| (CAR |argDef|))
      (SETQ |def| (CDR |argDef|))
      (SETQ |LETTMP#1| (|simplifyMapPattern| |argDef| |alias|))
      (SETQ |arg'| (CAR |LETTMP#1|))
      (SETQ |def'| (CDR |LETTMP#1|))
      (SETQ |arg'| (|outputTran| |arg'|))
      (COND ((NULL |arg'|) (SETQ |arg'| "()")))
      (LIST 'CONCATB |op| (|outputTran| |arg'|) '== (|outputTran| |def'|))))))

; outputTranReduce ['REDUCE,op,.,body] ==
;   ['CONCAT,op,"/",outputTran body]

(DEFUN |outputTranReduce| (|bfVar#18|)
  (PROG (|op| |body|)
    (RETURN
     (PROGN
      (SETQ |op| (CADR . #1=(|bfVar#18|)))
      (SETQ |body| (CADDDR . #1#))
      (LIST 'CONCAT |op| '/ (|outputTran| |body|))))))

; outputTranRepeat ["REPEAT",:itl,body] ==
;   body' := outputTran body
;   itl =>
;     itlist:= outputTranIteration itl
;     ['CONCATB,itlist,'repeat,body']
;   ['CONCATB,'repeat,body']

(DEFUN |outputTranRepeat| (|bfVar#19|)
  (PROG (|LETTMP#1| |body| |itl| |body'| |itlist|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE (CDR |bfVar#19|)))
      (SETQ |body| (CAR |LETTMP#1|))
      (SETQ |itl| (NREVERSE (CDR |LETTMP#1|)))
      (SETQ |body'| (|outputTran| |body|))
      (COND
       (|itl|
        (PROGN
         (SETQ |itlist| (|outputTranIteration| |itl|))
         (LIST 'CONCATB |itlist| 'REPEAT |body'|)))
       ('T (LIST 'CONCATB 'REPEAT |body'|)))))))

; outputTranCollect [.,:itl,body] ==
;   itlist:= outputTranIteration itl
;   ['BRACKET,['CONCATB,outputTran body,itlist]]

(DEFUN |outputTranCollect| (|bfVar#20|)
  (PROG (|LETTMP#1| |body| |itl| |itlist|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE (CDR |bfVar#20|)))
      (SETQ |body| (CAR |LETTMP#1|))
      (SETQ |itl| (NREVERSE (CDR |LETTMP#1|)))
      (SETQ |itlist| (|outputTranIteration| |itl|))
      (LIST 'BRACKET (LIST 'CONCATB (|outputTran| |body|) |itlist|))))))

; outputTranIteration itl ==
;   null rest itl => outputTranIterate first itl
;   ['CONCATB,outputTranIterate first itl,outputTranIteration rest itl]

(DEFUN |outputTranIteration| (|itl|)
  (PROG ()
    (RETURN
     (COND ((NULL (CDR |itl|)) (|outputTranIterate| (CAR |itl|)))
           ('T
            (LIST 'CONCATB (|outputTranIterate| (CAR |itl|))
                  (|outputTranIteration| (CDR |itl|))))))))

; outputTranIterate x ==
;   x is ['STEP,n,init,step,:final] =>
;     init' := outputTran init
;     if LISTP init then init' := ['PAREN,init']
;     final' :=
;       final =>
;         LISTP first final => [['PAREN,outputTran first final]]
;         [outputTran first final]
;       NIL
;     ['STEP,outputTran n,init',outputTran step,:final']
;   x is ["IN",n,s] => ["IN",outputTran n,outputTran s]
;   x is [op,p] and op in '(_| UNTIL WHILE) =>
;     op:= DOWNCASE op
;     ['CONCATB,op,outputTran p]
;   throwKeyedMsg("S2IX0008",['outputTranIterate,['"illegal iterate: ",x]])

(DEFUN |outputTranIterate| (|x|)
  (PROG (|ISTMP#1| |n| |ISTMP#2| |init| |ISTMP#3| |step| |final| |init'|
         |final'| |s| |op| |p|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'STEP)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |n| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |init| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|)
                              (PROGN
                               (SETQ |step| (CAR |ISTMP#3|))
                               (SETQ |final| (CDR |ISTMP#3|))
                               #1='T))))))))
       (PROGN
        (SETQ |init'| (|outputTran| |init|))
        (COND ((LISTP |init|) (SETQ |init'| (LIST 'PAREN |init'|))))
        (SETQ |final'|
                (COND
                 (|final|
                  (COND
                   ((LISTP (CAR |final|))
                    (LIST (LIST 'PAREN (|outputTran| (CAR |final|)))))
                   (#1# (LIST (|outputTran| (CAR |final|))))))
                 (#1# NIL)))
        (CONS 'STEP
              (CONS (|outputTran| |n|)
                    (CONS |init'| (CONS (|outputTran| |step|) |final'|))))))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'IN)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |n| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |s| (CAR |ISTMP#2|)) #1#))))))
       (LIST 'IN (|outputTran| |n|) (|outputTran| |s|)))
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |p| (CAR |ISTMP#1|)) #1#)))
            (|member| |op| '(|\|| UNTIL WHILE)))
       (PROGN
        (SETQ |op| (DOWNCASE |op|))
        (LIST 'CONCATB |op| (|outputTran| |p|))))
      (#1#
       (|throwKeyedMsg| 'S2IX0008
        (LIST '|outputTranIterate| (LIST "illegal iterate: " |x|))))))))

; outputConstructTran x ==
;   x is [op,a,b] =>
;     a:= outputTran a
;     b:= outputTran b
;     op="cons" =>
;       b is ['construct,:l] => ['construct,a,:l]
;       ['BRACKET,['AGGLST,:[a,[":",b]]]]
;     op="nconc" =>
;       aPart :=
;         a is ['construct,c] and c is ['SEGMENT,:.] => c
;         [":",a]
;       b is ['construct,:l] => ['construct,aPart,:l]
;       ['BRACKET,['AGGLST,aPart,[":",b]]]
;     [op,a,b]
;   atom x => x
;   [outputTran first x,:outputConstructTran rest x]

(DEFUN |outputConstructTran| (|x|)
  (PROG (|op| |ISTMP#1| |a| |ISTMP#2| |b| |l| |c| |aPart|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
       (PROGN
        (SETQ |a| (|outputTran| |a|))
        (SETQ |b| (|outputTran| |b|))
        (COND
         ((EQ |op| '|cons|)
          (COND
           ((AND (CONSP |b|) (EQ (CAR |b|) '|construct|)
                 (PROGN (SETQ |l| (CDR |b|)) #1#))
            (CONS '|construct| (CONS |a| |l|)))
           (#1# (LIST 'BRACKET (CONS 'AGGLST (LIST |a| (LIST '|:| |b|)))))))
         ((EQ |op| '|nconc|)
          (PROGN
           (SETQ |aPart|
                   (COND
                    ((AND (CONSP |a|) (EQ (CAR |a|) '|construct|)
                          (PROGN
                           (SETQ |ISTMP#1| (CDR |a|))
                           (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                (PROGN (SETQ |c| (CAR |ISTMP#1|)) #1#)))
                          (CONSP |c|) (EQ (CAR |c|) 'SEGMENT))
                     |c|)
                    (#1# (LIST '|:| |a|))))
           (COND
            ((AND (CONSP |b|) (EQ (CAR |b|) '|construct|)
                  (PROGN (SETQ |l| (CDR |b|)) #1#))
             (CONS '|construct| (CONS |aPart| |l|)))
            (#1# (LIST 'BRACKET (LIST 'AGGLST |aPart| (LIST '|:| |b|)))))))
         (#1# (LIST |op| |a| |b|)))))
      ((ATOM |x|) |x|)
      (#1#
       (CONS (|outputTran| (CAR |x|)) (|outputConstructTran| (CDR |x|))))))))

; tensorApp(u,x,y,d) ==
;   rightPrec:= getOpBindingPower("*","Led","right")
;   firstTime:= true
;   for arg in rest u repeat
;     op:= keyp arg
;     if not firstTime then
;       opString:= GETL('TENSOR,"INFIXOP") or '"#"
;       d:= APP(opString,x,y,d)
;       x:= x + #opString
;     [d,x]:= appInfixArg(arg,x,y,d,rightPrec,"left",nil) --app in a right arg
;     firstTime:= nil
;   d

(DEFUN |tensorApp| (|u| |x| |y| |d|)
  (PROG (|rightPrec| |firstTime| |op| |opString| |LETTMP#1|)
    (RETURN
     (PROGN
      (SETQ |rightPrec| (|getOpBindingPower| '* '|Led| '|right|))
      (SETQ |firstTime| T)
      ((LAMBDA (|bfVar#21| |arg|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#21|) (PROGN (SETQ |arg| (CAR |bfVar#21|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |op| (|keyp| |arg|))
             (COND
              ((NULL |firstTime|)
               (SETQ |opString| (OR (GETL 'TENSOR 'INFIXOP) "#"))
               (SETQ |d| (APP |opString| |x| |y| |d|))
               (SETQ |x| (+ |x| (LENGTH |opString|)))))
             (SETQ |LETTMP#1|
                     (|appInfixArg| |arg| |x| |y| |d| |rightPrec| '|left| NIL))
             (SETQ |d| (CAR |LETTMP#1|))
             (SETQ |x| (CADR |LETTMP#1|))
             (SETQ |firstTime| NIL))))
          (SETQ |bfVar#21| (CDR |bfVar#21|))))
       (CDR |u|) NIL)
      |d|))))

; tensorWidth u ==
;   rightPrec:= getOpBindingPower("*","Led","right")
;   firstTime:= true
;   w:= 0
;   for arg in rest u repeat
;     op:= keyp arg
;     if not firstTime then
;       opString:= GETL('TENSOR,"INFIXOP") or '"#"
;       w:= w + #opString
;     if infixArgNeedsParens(arg, rightPrec, "left") then w:= w+2
;     w:= w+WIDTH arg
;     firstTime:= nil
;   w

(DEFUN |tensorWidth| (|u|)
  (PROG (|rightPrec| |firstTime| |w| |op| |opString|)
    (RETURN
     (PROGN
      (SETQ |rightPrec| (|getOpBindingPower| '* '|Led| '|right|))
      (SETQ |firstTime| T)
      (SETQ |w| 0)
      ((LAMBDA (|bfVar#22| |arg|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#22|) (PROGN (SETQ |arg| (CAR |bfVar#22|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |op| (|keyp| |arg|))
             (COND
              ((NULL |firstTime|)
               (SETQ |opString| (OR (GETL 'TENSOR 'INFIXOP) "#"))
               (SETQ |w| (+ |w| (LENGTH |opString|)))))
             (COND
              ((|infixArgNeedsParens| |arg| |rightPrec| '|left|)
               (SETQ |w| (+ |w| 2))))
             (SETQ |w| (+ |w| (WIDTH |arg|)))
             (SETQ |firstTime| NIL))))
          (SETQ |bfVar#22| (CDR |bfVar#22|))))
       (CDR |u|) NIL)
      |w|))))

; timesApp(u,x,y,d) ==
;   rightPrec:= getOpBindingPower("*","Led","right")
;   firstTime:= true
;   for arg in rest u repeat
;     op:= keyp arg
;     if not firstTime and (needBlankForRoot(lastOp,op,arg) or
;        needStar(wasSimple,wasQuotient,wasNumber,arg,op) or
;         wasNumber and op = 'ROOT and subspan arg = 1) then
;       d:= APP(BLANK,x,y,d)
;       x:= x+1
;     [d,x]:= appInfixArg(arg,x,y,d,rightPrec,"left",nil) --app in a right arg
;     wasSimple := atom arg and not NUMBERP arg or keyp arg = "OVERBAR"
;     wasQuotient:= isQuotient op
;     wasNumber:= NUMBERP arg
;     lastOp := op
;     firstTime:= nil
;   d

(DEFUN |timesApp| (|u| |x| |y| |d|)
  (PROG (|rightPrec| |firstTime| |op| |LETTMP#1| |wasSimple| |wasQuotient|
         |wasNumber| |lastOp|)
    (RETURN
     (PROGN
      (SETQ |rightPrec| (|getOpBindingPower| '* '|Led| '|right|))
      (SETQ |firstTime| T)
      ((LAMBDA (|bfVar#23| |arg|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#23|) (PROGN (SETQ |arg| (CAR |bfVar#23|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |op| (|keyp| |arg|))
             (COND
              ((AND (NULL |firstTime|)
                    (OR (|needBlankForRoot| |lastOp| |op| |arg|)
                        (|needStar| |wasSimple| |wasQuotient| |wasNumber| |arg|
                         |op|)
                        (AND |wasNumber| (EQ |op| 'ROOT)
                             (EQL (|subspan| |arg|) 1))))
               (SETQ |d| (APP BLANK |x| |y| |d|)) (SETQ |x| (+ |x| 1))))
             (SETQ |LETTMP#1|
                     (|appInfixArg| |arg| |x| |y| |d| |rightPrec| '|left| NIL))
             (SETQ |d| (CAR |LETTMP#1|))
             (SETQ |x| (CADR |LETTMP#1|))
             (SETQ |wasSimple|
                     (OR (AND (ATOM |arg|) (NULL (NUMBERP |arg|)))
                         (EQ (|keyp| |arg|) 'OVERBAR)))
             (SETQ |wasQuotient| (|isQuotient| |op|))
             (SETQ |wasNumber| (NUMBERP |arg|))
             (SETQ |lastOp| |op|)
             (SETQ |firstTime| NIL))))
          (SETQ |bfVar#23| (CDR |bfVar#23|))))
       (CDR |u|) NIL)
      |d|))))

; needBlankForRoot(lastOp,op,arg) ==
;   lastOp ~= "^" and lastOp ~= "**" and not(subspan(arg)>0) => false
;   op = "**" and keyp CADR arg = 'ROOT => true
;   op = "^" and keyp CADR arg = 'ROOT => true
;   op = 'ROOT and CDDR arg => true
;   false

(DEFUN |needBlankForRoot| (|lastOp| |op| |arg|)
  (PROG ()
    (RETURN
     (COND
      ((AND (NOT (EQ |lastOp| '^)) (NOT (EQ |lastOp| '**))
            (NULL (< 0 (|subspan| |arg|))))
       NIL)
      ((AND (EQ |op| '**) (EQ (|keyp| (CADR |arg|)) 'ROOT)) T)
      ((AND (EQ |op| '^) (EQ (|keyp| (CADR |arg|)) 'ROOT)) T)
      ((AND (EQ |op| 'ROOT) (CDDR |arg|)) T) ('T NIL)))))

; stepApp([.,a,init,one,:optFinal],x,y,d) ==
;   d:= appChar('"for ",x,y,d)
;   d:= APP(a,w:=x+4,y,d)
;   d:= appChar('" in ",w:=w+WIDTH a,y,d)
;   d:= APP(init,w:=w+4,y,d)
;   d:= APP('"..",w:=w+WIDTH init,y,d)
;   if optFinal then d:= APP(first optFinal,w+2,y,d)
;   d

(DEFUN |stepApp| (|bfVar#24| |x| |y| |d|)
  (PROG (|a| |init| |one| |optFinal| |w|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#24|)))
      (SETQ |init| (CADDR . #1#))
      (SETQ |one| (CADDDR . #1#))
      (SETQ |optFinal| (CDDDDR . #1#))
      (SETQ |d| (|appChar| "for " |x| |y| |d|))
      (SETQ |d| (APP |a| (SETQ |w| (+ |x| 4)) |y| |d|))
      (SETQ |d| (|appChar| " in " (SETQ |w| (+ |w| (WIDTH |a|))) |y| |d|))
      (SETQ |d| (APP |init| (SETQ |w| (+ |w| 4)) |y| |d|))
      (SETQ |d| (APP ".." (SETQ |w| (+ |w| (WIDTH |init|))) |y| |d|))
      (COND (|optFinal| (SETQ |d| (APP (CAR |optFinal|) (+ |w| 2) |y| |d|))))
      |d|))))

; stepSub [.,a,init,one,:optFinal] ==
;   m:= MAX(subspan a,subspan init)
;   optFinal => MAX(m,subspan first optFinal)
;   m

(DEFUN |stepSub| (|bfVar#25|)
  (PROG (|a| |init| |one| |optFinal| |m|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#25|)))
      (SETQ |init| (CADDR . #1#))
      (SETQ |one| (CADDDR . #1#))
      (SETQ |optFinal| (CDDDDR . #1#))
      (SETQ |m| (MAX (|subspan| |a|) (|subspan| |init|)))
      (COND (|optFinal| (MAX |m| (|subspan| (CAR |optFinal|)))) ('T |m|))))))

; stepSuper [.,a,init,one,:optFinal] ==
;   m:= MAX(superspan a,superspan init)
;   optFinal => MAX(m,superspan first optFinal)
;   m

(DEFUN |stepSuper| (|bfVar#26|)
  (PROG (|a| |init| |one| |optFinal| |m|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#26|)))
      (SETQ |init| (CADDR . #1#))
      (SETQ |one| (CADDDR . #1#))
      (SETQ |optFinal| (CDDDDR . #1#))
      (SETQ |m| (MAX (|superspan| |a|) (|superspan| |init|)))
      (COND (|optFinal| (MAX |m| (|superspan| (CAR |optFinal|)))) ('T |m|))))))

; stepWidth [.,a,init,one,:optFinal] ==
;    10+WIDTH a+WIDTH init+(optFinal => WIDTH first optFinal; 0)

(DEFUN |stepWidth| (|bfVar#27|)
  (PROG (|a| |init| |one| |optFinal|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#27|)))
      (SETQ |init| (CADDR . #1#))
      (SETQ |one| (CADDDR . #1#))
      (SETQ |optFinal| (CDDDDR . #1#))
      (+ (+ (+ 10 (WIDTH |a|)) (WIDTH |init|))
         (COND (|optFinal| (WIDTH (CAR |optFinal|))) ('T 0)))))))

; inApp([.,a,s],x,y,d) ==  --for [IN,a,s]
;   d:= appChar('"for ",x,y,d)
;   d:= APP(a,x+4,y,d)
;   d:= appChar('" in ",x+WIDTH a+4,y,d)
;   APP(s,x+WIDTH a+8,y,d)

(DEFUN |inApp| (|bfVar#28| |x| |y| |d|)
  (PROG (|a| |s|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#28|)))
      (SETQ |s| (CADDR . #1#))
      (SETQ |d| (|appChar| "for " |x| |y| |d|))
      (SETQ |d| (APP |a| (+ |x| 4) |y| |d|))
      (SETQ |d| (|appChar| " in " (+ (+ |x| (WIDTH |a|)) 4) |y| |d|))
      (APP |s| (+ (+ |x| (WIDTH |a|)) 8) |y| |d|)))))

; inSub [.,a,s] == MAX(subspan a,subspan s)

(DEFUN |inSub| (|bfVar#29|)
  (PROG (|a| |s|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#29|)))
      (SETQ |s| (CADDR . #1#))
      (MAX (|subspan| |a|) (|subspan| |s|))))))

; inSuper [.,a,s] == MAX(superspan a,superspan s)

(DEFUN |inSuper| (|bfVar#30|)
  (PROG (|a| |s|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#30|)))
      (SETQ |s| (CADDR . #1#))
      (MAX (|superspan| |a|) (|superspan| |s|))))))

; inWidth [.,a,s] == 8+WIDTH a+WIDTH s

(DEFUN |inWidth| (|bfVar#31|)
  (PROG (|a| |s|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#31|)))
      (SETQ |s| (CADDR . #1#))
      (+ (+ 8 (WIDTH |a|)) (WIDTH |s|))))))

; centerApp([.,u],x,y,d) ==
;   d := APP(u,x,y,d)

(DEFUN |centerApp| (|bfVar#32| |x| |y| |d|)
  (PROG (|u|)
    (RETURN
     (PROGN (SETQ |u| (CADR |bfVar#32|)) (SETQ |d| (APP |u| |x| |y| |d|))))))

; concatApp([.,:l],x,y,d) == concatApp1(l,x,y,d,0)

(DEFUN |concatApp| (|bfVar#33| |x| |y| |d|)
  (PROG (|l|)
    (RETURN
     (PROGN (SETQ |l| (CDR |bfVar#33|)) (|concatApp1| |l| |x| |y| |d| 0)))))

; concatbApp([.,:l],x,y,d) == concatApp1(l,x,y,d,1)

(DEFUN |concatbApp| (|bfVar#34| |x| |y| |d|)
  (PROG (|l|)
    (RETURN
     (PROGN (SETQ |l| (CDR |bfVar#34|)) (|concatApp1| |l| |x| |y| |d| 1)))))

; concatApp1(l,x,y,d,n) ==
;   for u in l repeat
;     d:= APP(u,x,y,d)
;     x:=x+WIDTH u+n
;   d

(DEFUN |concatApp1| (|l| |x| |y| |d| |n|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#35| |u|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#35|) (PROGN (SETQ |u| (CAR |bfVar#35|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |d| (APP |u| |x| |y| |d|))
             (SETQ |x| (+ (+ |x| (WIDTH |u|)) |n|)))))
          (SETQ |bfVar#35| (CDR |bfVar#35|))))
       |l| NIL)
      |d|))))

; concatSub [.,:l] == "MAX"/[subspan x for x in l]

(DEFUN |concatSub| (|bfVar#38|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l| (CDR |bfVar#38|))
      ((LAMBDA (|bfVar#37| |bfVar#36| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#36|) (PROGN (SETQ |x| (CAR |bfVar#36|)) NIL))
            (RETURN |bfVar#37|))
           ('T (SETQ |bfVar#37| (MAX |bfVar#37| (|subspan| |x|)))))
          (SETQ |bfVar#36| (CDR |bfVar#36|))))
       -999999 |l| NIL)))))

; concatSuper [.,:l] == "MAX"/[superspan x for x in l]

(DEFUN |concatSuper| (|bfVar#41|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l| (CDR |bfVar#41|))
      ((LAMBDA (|bfVar#40| |bfVar#39| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#39|) (PROGN (SETQ |x| (CAR |bfVar#39|)) NIL))
            (RETURN |bfVar#40|))
           ('T (SETQ |bfVar#40| (MAX |bfVar#40| (|superspan| |x|)))))
          (SETQ |bfVar#39| (CDR |bfVar#39|))))
       -999999 |l| NIL)))))

; concatWidth [.,:l] == +/[WIDTH x for x in l]

(DEFUN |concatWidth| (|bfVar#44|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l| (CDR |bfVar#44|))
      ((LAMBDA (|bfVar#43| |bfVar#42| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#42|) (PROGN (SETQ |x| (CAR |bfVar#42|)) NIL))
            (RETURN |bfVar#43|))
           ('T (SETQ |bfVar#43| (+ |bfVar#43| (WIDTH |x|)))))
          (SETQ |bfVar#42| (CDR |bfVar#42|))))
       0 |l| NIL)))))

; concatbWidth [.,:l] ==
;     null l => 0
;     +/[1+WIDTH x for x in l]-1

(DEFUN |concatbWidth| (|bfVar#47|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l| (CDR |bfVar#47|))
      (COND ((NULL |l|) 0)
            (#1='T
             (-
              ((LAMBDA (|bfVar#46| |bfVar#45| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#45|)
                        (PROGN (SETQ |x| (CAR |bfVar#45|)) NIL))
                    (RETURN |bfVar#46|))
                   (#1# (SETQ |bfVar#46| (+ |bfVar#46| (+ 1 (WIDTH |x|))))))
                  (SETQ |bfVar#45| (CDR |bfVar#45|))))
               0 |l| NIL)
              1)))))))

; exptApp([.,a,b],x,y,d) ==
;   pren:= exptNeedsPren a
;   d:=
;     pren => appparu(a,x,y,d)
;     APP(a,x,y,d)
;   x':= x+WIDTH a+(pren => 2;0)
;   y':= 1+y+superspan a+subspan b + (0=superspan a => 0; -1)
;   APP(b,x',y',d)

(DEFUN |exptApp| (|bfVar#48| |x| |y| |d|)
  (PROG (|a| |b| |pren| |x'| |y'|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#48|)))
      (SETQ |b| (CADDR . #1#))
      (SETQ |pren| (|exptNeedsPren| |a|))
      (SETQ |d|
              (COND (|pren| (|appparu| |a| |x| |y| |d|))
                    (#2='T (APP |a| |x| |y| |d|))))
      (SETQ |x'| (+ (+ |x| (WIDTH |a|)) (COND (|pren| 2) (#2# 0))))
      (SETQ |y'|
              (+ (+ (+ (+ 1 |y|) (|superspan| |a|)) (|subspan| |b|))
                 (COND ((EQL 0 (|superspan| |a|)) 0) (#2# (- 1)))))
      (APP |b| |x'| |y'| |d|)))))

; exptNeedsPren a ==
;   atom a and null (INTEGERP a and a < 0)  => false
;   key:= keyp a
;   key = "OVER" or key = "SIGMA" or key = "SIGMA2" or key = "PI"
;     or key = "PI2" => true
;   (key="SUB") or (null GETL(key,"Nud") and null GETL(key,"Led")) => false
;   true

(DEFUN |exptNeedsPren| (|a|)
  (PROG (|key|)
    (RETURN
     (COND ((AND (ATOM |a|) (NULL (AND (INTEGERP |a|) (MINUSP |a|)))) NIL)
           (#1='T
            (PROGN
             (SETQ |key| (|keyp| |a|))
             (COND
              ((OR (EQ |key| 'OVER) (EQ |key| 'SIGMA) (EQ |key| 'SIGMA2)
                   (EQ |key| 'PI) (EQ |key| 'PI2))
               T)
              ((OR (EQ |key| 'SUB)
                   (AND (NULL (GETL |key| '|Nud|)) (NULL (GETL |key| '|Led|))))
               NIL)
              (#1# T))))))))

; exptSub u == subspan CADR u

(DEFUN |exptSub| (|u|) (PROG () (RETURN (|subspan| (CADR |u|)))))

; exptSuper [.,a,b] == superspan a+height b+(superspan a=0 => 0;-1)

(DEFUN |exptSuper| (|bfVar#49|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#49|)))
      (SETQ |b| (CADDR . #1#))
      (+ (+ (|superspan| |a|) (|height| |b|))
         (COND ((EQL (|superspan| |a|) 0) 0) ('T (- 1))))))))

; exptWidth [.,a,b] == WIDTH a+WIDTH b+(exptNeedsPren a => 2;0)

(DEFUN |exptWidth| (|bfVar#50|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#50|)))
      (SETQ |b| (CADDR . #1#))
      (+ (+ (WIDTH |a|) (WIDTH |b|))
         (COND ((|exptNeedsPren| |a|) 2) ('T 0)))))))

; needStar(wasSimple,wasQuotient,wasNumber,cur,op) ==
;   wasNumber or wasQuotient or isQuotient op => true
;   wasSimple =>
;     atom cur or keyp cur="SUB" or keyp cur = "OVERBAR" or op="**" or
;       op = "^" or (atom op and not NUMBERP op and not GETL(op,"APP"))
;         -- deal with cases like "x*f'(x)"
;         or (keyp op = "PRIME" or keyp op = "SUB")

(DEFUN |needStar| (|wasSimple| |wasQuotient| |wasNumber| |cur| |op|)
  (PROG ()
    (RETURN
     (COND ((OR |wasNumber| |wasQuotient| (|isQuotient| |op|)) T)
           (|wasSimple|
            (OR (ATOM |cur|) (EQ (|keyp| |cur|) 'SUB)
                (EQ (|keyp| |cur|) 'OVERBAR) (EQ |op| '**) (EQ |op| '^)
                (AND (ATOM |op|) (NULL (NUMBERP |op|)) (NULL (GETL |op| 'APP)))
                (EQ (|keyp| |op|) 'PRIME) (EQ (|keyp| |op|) 'SUB)))))))

; isQuotient op ==
;   op="/" or op="OVER"

(DEFUN |isQuotient| (|op|) (PROG () (RETURN (OR (EQ |op| '/) (EQ |op| 'OVER)))))

; timesWidth u ==
;   rightPrec:= getOpBindingPower("*","Led","right")
;   firstTime:= true
;   w:= 0
;   for arg in rest u repeat
;     op:= keyp arg
;     if not firstTime and (needBlankForRoot(lastOp,op,arg) or
;        needStar(wasSimple,wasQuotient,wasNumber,arg,op) or
;         (wasNumber and op = 'ROOT and subspan arg = 1)) then
;       w:= w+1
;     if infixArgNeedsParens(arg, rightPrec, "left") then w:= w+2
;     w:= w+WIDTH arg
;     wasSimple := atom arg and not NUMBERP arg or keyp arg = "OVERBAR"
;     wasQuotient:= isQuotient op
;     wasNumber:= NUMBERP arg
;     lastOp := op
;     firstTime:= nil
;   w

(DEFUN |timesWidth| (|u|)
  (PROG (|rightPrec| |firstTime| |w| |op| |wasSimple| |wasQuotient| |wasNumber|
         |lastOp|)
    (RETURN
     (PROGN
      (SETQ |rightPrec| (|getOpBindingPower| '* '|Led| '|right|))
      (SETQ |firstTime| T)
      (SETQ |w| 0)
      ((LAMBDA (|bfVar#51| |arg|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#51|) (PROGN (SETQ |arg| (CAR |bfVar#51|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |op| (|keyp| |arg|))
             (COND
              ((AND (NULL |firstTime|)
                    (OR (|needBlankForRoot| |lastOp| |op| |arg|)
                        (|needStar| |wasSimple| |wasQuotient| |wasNumber| |arg|
                         |op|)
                        (AND |wasNumber| (EQ |op| 'ROOT)
                             (EQL (|subspan| |arg|) 1))))
               (SETQ |w| (+ |w| 1))))
             (COND
              ((|infixArgNeedsParens| |arg| |rightPrec| '|left|)
               (SETQ |w| (+ |w| 2))))
             (SETQ |w| (+ |w| (WIDTH |arg|)))
             (SETQ |wasSimple|
                     (OR (AND (ATOM |arg|) (NULL (NUMBERP |arg|)))
                         (EQ (|keyp| |arg|) 'OVERBAR)))
             (SETQ |wasQuotient| (|isQuotient| |op|))
             (SETQ |wasNumber| (NUMBERP |arg|))
             (SETQ |lastOp| |op|)
             (SETQ |firstTime| NIL))))
          (SETQ |bfVar#51| (CDR |bfVar#51|))))
       (CDR |u|) NIL)
      |w|))))

; plusApp([.,frst,:rst],x,y,d) ==
;   appSum(rst,x+WIDTH frst,y,APP(frst,x,y,d))

(DEFUN |plusApp| (|bfVar#52| |x| |y| |d|)
  (PROG (|frst| |rst|)
    (RETURN
     (PROGN
      (SETQ |frst| (CADR . #1=(|bfVar#52|)))
      (SETQ |rst| (CDDR . #1#))
      (|appSum| |rst| (+ |x| (WIDTH |frst|)) |y| (APP |frst| |x| |y| |d|))))))

; appSum(u,x,y,d) ==
;   for arg in u repeat
;     infixOp:=
;       syminusp arg => "-"
;       "+"
;     opString:= GETL(infixOp,"INFIXOP") or '","
;     d:= APP(opString,x,y,d)
;     x:= x+WIDTH opString
;     arg:= absym arg --negate a neg. number or remove leading "-"
;     rightPrec:= getOpBindingPower(infixOp,"Led","right")
;     if infixOp = "-" then rightPrec:=rightPrec  +1
;     -- that +1 added JHD 2 Aug 89 to prevent x-(y+z) printing as x-y+z
;     -- Sutor found the example:
;     -- )cl all
;     -- p : P[x] P I := x - y - z
;     -- p :: P[x] FR P I
;     -- trailingCoef %
;     [d,x]:= appInfixArg(arg,x,y,d,rightPrec,"left",nil) --app in a right arg
;   d

(DEFUN |appSum| (|u| |x| |y| |d|)
  (PROG (|infixOp| |opString| |rightPrec| |LETTMP#1|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#53| |arg|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#53|) (PROGN (SETQ |arg| (CAR |bfVar#53|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |infixOp| (COND ((|syminusp| |arg|) '-) (#1# '+)))
             (SETQ |opString| (OR (GETL |infixOp| 'INFIXOP) ","))
             (SETQ |d| (APP |opString| |x| |y| |d|))
             (SETQ |x| (+ |x| (WIDTH |opString|)))
             (SETQ |arg| (|absym| |arg|))
             (SETQ |rightPrec| (|getOpBindingPower| |infixOp| '|Led| '|right|))
             (COND ((EQ |infixOp| '-) (SETQ |rightPrec| (+ |rightPrec| 1))))
             (SETQ |LETTMP#1|
                     (|appInfixArg| |arg| |x| |y| |d| |rightPrec| '|left| NIL))
             (SETQ |d| (CAR |LETTMP#1|))
             (SETQ |x| (CADR |LETTMP#1|))
             |LETTMP#1|)))
          (SETQ |bfVar#53| (CDR |bfVar#53|))))
       |u| NIL)
      |d|))))

; appInfix(e,x,y,d) ==
;   op := keyp e
;   leftPrec:= getOpBindingPower(op,"Led","left")
;   leftPrec = 1000 => return nil --no infix operator is allowed default value
;   rightPrec:= getOpBindingPower(op,"Led","right")
;   #e < 2 => throwKeyedMsg("S2IX0008",['appInfix,
;       '"fewer than 2 arguments to an infix function"])
;   opString:= GETL(op,"INFIXOP") or '","
;   opWidth:= WIDTH opString
;   [.,frst,:rst]:= e
;   null rst =>
;     GETL(op,"isSuffix") =>
;       [d,x]:= appInfixArg(frst,x,y,d,leftPrec,"right",opString)
;       d:= appChar(opString,x,y,d)
;     THROW('outputFailure,'outputFailure)
;   [d,x]:= appInfixArg(frst,x,y,d,leftPrec,"right",opString) --app in left arg
;   for arg in rst repeat
;     d:= appChar(opString,x,y,d) --app in the infix operator
;     x:= x+opWidth
;     [d,x]:= appInfixArg(arg,x,y,d,rightPrec,"left",opString) --app in right arg
;   d

(DEFUN |appInfix| (|e| |x| |y| |d|)
  (PROG (|op| |leftPrec| |rightPrec| |opString| |opWidth| |frst| |rst|
         |LETTMP#1|)
    (RETURN
     (PROGN
      (SETQ |op| (|keyp| |e|))
      (SETQ |leftPrec| (|getOpBindingPower| |op| '|Led| '|left|))
      (COND ((EQL |leftPrec| 1000) (RETURN NIL))
            (#1='T
             (PROGN
              (SETQ |rightPrec| (|getOpBindingPower| |op| '|Led| '|right|))
              (COND
               ((< (LENGTH |e|) 2)
                (|throwKeyedMsg| 'S2IX0008
                 (LIST '|appInfix|
                       "fewer than 2 arguments to an infix function")))
               (#1#
                (PROGN
                 (SETQ |opString| (OR (GETL |op| 'INFIXOP) ","))
                 (SETQ |opWidth| (WIDTH |opString|))
                 (SETQ |frst| (CADR . #2=(|e|)))
                 (SETQ |rst| (CDDR . #2#))
                 (COND
                  ((NULL |rst|)
                   (COND
                    ((GETL |op| '|isSuffix|)
                     (PROGN
                      (SETQ |LETTMP#1|
                              (|appInfixArg| |frst| |x| |y| |d| |leftPrec|
                               '|right| |opString|))
                      (SETQ |d| (CAR |LETTMP#1|))
                      (SETQ |x| (CADR |LETTMP#1|))
                      (SETQ |d| (|appChar| |opString| |x| |y| |d|))))
                    (#1# (THROW '|outputFailure| '|outputFailure|))))
                  (#1#
                   (PROGN
                    (SETQ |LETTMP#1|
                            (|appInfixArg| |frst| |x| |y| |d| |leftPrec|
                             '|right| |opString|))
                    (SETQ |d| (CAR |LETTMP#1|))
                    (SETQ |x| (CADR |LETTMP#1|))
                    ((LAMBDA (|bfVar#54| |arg|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#54|)
                              (PROGN (SETQ |arg| (CAR |bfVar#54|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (PROGN
                           (SETQ |d| (|appChar| |opString| |x| |y| |d|))
                           (SETQ |x| (+ |x| |opWidth|))
                           (SETQ |LETTMP#1|
                                   (|appInfixArg| |arg| |x| |y| |d| |rightPrec|
                                    '|left| |opString|))
                           (SETQ |d| (CAR |LETTMP#1|))
                           (SETQ |x| (CADR |LETTMP#1|))
                           |LETTMP#1|)))
                        (SETQ |bfVar#54| (CDR |bfVar#54|))))
                     |rst| NIL)
                    |d|)))))))))))))

; appconc(d,x,y,w) == NCONC(d,[[[x,:y],:w]])

(DEFUN |appconc| (|d| |x| |y| |w|)
  (PROG () (RETURN (NCONC |d| (LIST (CONS (CONS |x| |y|) |w|))))))

; infixArgNeedsParens(arg, prec, leftOrRight) ==
;   prec > getBindingPowerOf(leftOrRight, arg) + 1

(DEFUN |infixArgNeedsParens| (|arg| |prec| |leftOrRight|)
  (PROG () (RETURN (< (+ (|getBindingPowerOf| |leftOrRight| |arg|) 1) |prec|))))

; appInfixArg(u,x,y,d,prec,leftOrRight,string) ==
;   insertPrensIfTrue:= infixArgNeedsParens(u,prec,leftOrRight)
;   d:=
;     insertPrensIfTrue => appparu(u,x,y,d)
;     APP(u,x,y,d)
;   x:= x+WIDTH u
;   if string then d:= appconc(d,x,y,string)
;   [d,(insertPrensIfTrue => x+2; x)]

(DEFUN |appInfixArg| (|u| |x| |y| |d| |prec| |leftOrRight| |string|)
  (PROG (|insertPrensIfTrue|)
    (RETURN
     (PROGN
      (SETQ |insertPrensIfTrue|
              (|infixArgNeedsParens| |u| |prec| |leftOrRight|))
      (SETQ |d|
              (COND (|insertPrensIfTrue| (|appparu| |u| |x| |y| |d|))
                    (#1='T (APP |u| |x| |y| |d|))))
      (SETQ |x| (+ |x| (WIDTH |u|)))
      (COND (|string| (SETQ |d| (|appconc| |d| |x| |y| |string|))))
      (LIST |d| (COND (|insertPrensIfTrue| (+ |x| 2)) (#1# |x|)))))))

; getBindingPowerOf(key,x) ==
;   --binding powers can be found in file NEWAUX LISP
;   x is ['REDUCE,:.] => (key='left => 130; key='right => 0)
;   x is ["REPEAT",:.] => (key="left" => 130; key="right" => 0)
;   x is ["COND",:.] => (key="left" => 130; key="right" => 0)
;   x is [op,:argl] =>
;     if op is [a,:.] then op:= a
;     op = 'SLASH => getBindingPowerOf(key,["/",:argl]) - 1
;     op = 'OVER  => getBindingPowerOf(key,["/",:argl])
;     (n:= #argl)=1 =>
;       key="left" and (m:= getOpBindingPower(op,"Nud","left")) => m
;       key="right" and (m:= getOpBindingPower(op,"Nud","right")) => m
;       1000
;     n>1 =>
;       key="left" and (m:= getOpBindingPower(op,"Led","left")) => m
;       key="right" and (m:= getOpBindingPower(op,"Led","right")) => m
;       op="ELT" => 1002
;       1000
;     1000
;   1002

(DEFUN |getBindingPowerOf| (|key| |x|)
  (PROG (|op| |argl| |a| |n| |m|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'REDUCE))
       (COND ((EQ |key| '|left|) 130) ((EQ |key| '|right|) 0)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'REPEAT))
       (COND ((EQ |key| '|left|) 130) ((EQ |key| '|right|) 0)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'COND))
       (COND ((EQ |key| '|left|) 130) ((EQ |key| '|right|) 0)))
      ((AND (CONSP |x|)
            (PROGN (SETQ |op| (CAR |x|)) (SETQ |argl| (CDR |x|)) #1='T))
       (PROGN
        (COND
         ((AND (CONSP |op|) (PROGN (SETQ |a| (CAR |op|)) #1#))
          (SETQ |op| |a|)))
        (COND
         ((EQ |op| 'SLASH) (- (|getBindingPowerOf| |key| (CONS '/ |argl|)) 1))
         ((EQ |op| 'OVER) (|getBindingPowerOf| |key| (CONS '/ |argl|)))
         ((EQL (SETQ |n| (LENGTH |argl|)) 1)
          (COND
           ((AND (EQ |key| '|left|)
                 (SETQ |m| (|getOpBindingPower| |op| '|Nud| '|left|)))
            |m|)
           ((AND (EQ |key| '|right|)
                 (SETQ |m| (|getOpBindingPower| |op| '|Nud| '|right|)))
            |m|)
           (#1# 1000)))
         ((< 1 |n|)
          (COND
           ((AND (EQ |key| '|left|)
                 (SETQ |m| (|getOpBindingPower| |op| '|Led| '|left|)))
            |m|)
           ((AND (EQ |key| '|right|)
                 (SETQ |m| (|getOpBindingPower| |op| '|Led| '|right|)))
            |m|)
           ((EQ |op| 'ELT) 1002) (#1# 1000)))
         (#1# 1000))))
      (#1# 1002)))))

; getOpBindingPower(op,LedOrNud,leftOrRight) ==
;   if op in '(SLASH OVER) then op := "/"
;   not(SYMBOLP(op)) => 1000
;   exception:=
;     leftOrRight="left" => 0
;     105
;   bp:=
;     leftOrRight="left" => leftBindingPowerOf(op,LedOrNud)
;     rightBindingPowerOf(op,LedOrNud)
;   bp~=exception => bp
;   1000

(DEFUN |getOpBindingPower| (|op| |LedOrNud| |leftOrRight|)
  (PROG (|exception| |bp|)
    (RETURN
     (PROGN
      (COND ((|member| |op| '(SLASH OVER)) (SETQ |op| '/)))
      (COND ((NULL (SYMBOLP |op|)) 1000)
            (#1='T
             (PROGN
              (SETQ |exception|
                      (COND ((EQ |leftOrRight| '|left|) 0) (#1# 105)))
              (SETQ |bp|
                      (COND
                       ((EQ |leftOrRight| '|left|)
                        (|leftBindingPowerOf| |op| |LedOrNud|))
                       (#1# (|rightBindingPowerOf| |op| |LedOrNud|))))
              (COND ((NOT (EQUAL |bp| |exception|)) |bp|) (#1# 1000)))))))))

; bracketApp(u,x,y,d) ==
;   u is [.,u] or THROW('outputFailure,'outputFailure)
;   d:= appChar(specialChar 'lbrk,x,y,d)
;   d:=APP(u,x+1,y,d)
;   appChar(specialChar 'rbrk,x+1+WIDTH u,y,d)

(DEFUN |bracketApp| (|u| |x| |y| |d|)
  (PROG (|ISTMP#1|)
    (RETURN
     (PROGN
      (OR
       (AND (CONSP |u|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |u| (CAR |ISTMP#1|)) 'T))))
       (THROW '|outputFailure| '|outputFailure|))
      (SETQ |d| (|appChar| (|specialChar| '|lbrk|) |x| |y| |d|))
      (SETQ |d| (APP |u| (+ |x| 1) |y| |d|))
      (|appChar| (|specialChar| '|rbrk|) (+ (+ |x| 1) (WIDTH |u|)) |y| |d|)))))

; braceApp(u,x,y,d) ==
;   u is [.,u] or THROW('outputFailure,'outputFailure)
;   d:= appChar(specialChar 'lbrc,x,y,d)
;   d:=APP(u,x+1,y,d)
;   appChar(specialChar 'rbrc,x+1+WIDTH u,y,d)

(DEFUN |braceApp| (|u| |x| |y| |d|)
  (PROG (|ISTMP#1|)
    (RETURN
     (PROGN
      (OR
       (AND (CONSP |u|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |u| (CAR |ISTMP#1|)) 'T))))
       (THROW '|outputFailure| '|outputFailure|))
      (SETQ |d| (|appChar| (|specialChar| '|lbrc|) |x| |y| |d|))
      (SETQ |d| (APP |u| (+ |x| 1) |y| |d|))
      (|appChar| (|specialChar| '|rbrc|) (+ (+ |x| 1) (WIDTH |u|)) |y| |d|)))))

; aggWidth u ==
;   rest u is [a,:l] => WIDTH a + +/[2+WIDTH x for x in l]
;   0

(DEFUN |aggWidth| (|u|)
  (PROG (|ISTMP#1| |a| |l|)
    (RETURN
     (COND
      ((PROGN
        (SETQ |ISTMP#1| (CDR |u|))
        (AND (CONSP |ISTMP#1|)
             (PROGN
              (SETQ |a| (CAR |ISTMP#1|))
              (SETQ |l| (CDR |ISTMP#1|))
              #1='T)))
       (+ (WIDTH |a|)
          ((LAMBDA (|bfVar#56| |bfVar#55| |x|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#55|) (PROGN (SETQ |x| (CAR |bfVar#55|)) NIL))
                (RETURN |bfVar#56|))
               (#1# (SETQ |bfVar#56| (+ |bfVar#56| (+ 2 (WIDTH |x|))))))
              (SETQ |bfVar#55| (CDR |bfVar#55|))))
           0 |l| NIL)))
      (#1# 0)))))

; aggSub u == subspan rest u

(DEFUN |aggSub| (|u|) (PROG () (RETURN (|subspan| (CDR |u|)))))

; aggSuper u == superspan rest u

(DEFUN |aggSuper| (|u|) (PROG () (RETURN (|superspan| (CDR |u|)))))

; aggApp(u,x,y,d) == aggregateApp(rest u,x,y,d,", ")

(DEFUN |aggApp| (|u| |x| |y| |d|)
  (PROG () (RETURN (|aggregateApp| (CDR |u|) |x| |y| |d| '|, |))))

; aggregateApp(u, x, y, d, s) == agg_app(u, x, y, d, s, WIDTH(s))

(DEFUN |aggregateApp| (|u| |x| |y| |d| |s|)
  (PROG () (RETURN (|agg_app| |u| |x| |y| |d| |s| (WIDTH |s|)))))

; agg_app(u, x, y, d, s, width_s) ==
;   if u is [a,:l] then
;     d:= APP(a,x,y,d)
;     x:= x+WIDTH a
;     for b in l repeat
;         d := APP(s, x, y, d)
;         d := APP(b, x + width_s, y, d)
;         x := x + width_s + WIDTH(b)
;   d

(DEFUN |agg_app| (|u| |x| |y| |d| |s| |width_s|)
  (PROG (|a| |l|)
    (RETURN
     (PROGN
      (COND
       ((AND (CONSP |u|)
             (PROGN (SETQ |a| (CAR |u|)) (SETQ |l| (CDR |u|)) #1='T))
        (SETQ |d| (APP |a| |x| |y| |d|)) (SETQ |x| (+ |x| (WIDTH |a|)))
        ((LAMBDA (|bfVar#57| |b|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#57|) (PROGN (SETQ |b| (CAR |bfVar#57|)) NIL))
              (RETURN NIL))
             (#1#
              (PROGN
               (SETQ |d| (APP |s| |x| |y| |d|))
               (SETQ |d| (APP |b| (+ |x| |width_s|) |y| |d|))
               (SETQ |x| (+ (+ |x| |width_s|) (WIDTH |b|))))))
            (SETQ |bfVar#57| (CDR |bfVar#57|))))
         |l| NIL)))
      |d|))))

; outformWidth u ==  --WIDTH as called from OUTFORM to do a COPY
;   STRINGP u => #u
;   atom u => # atom2String u
;   WIDTH COPY u

(DEFUN |outformWidth| (|u|)
  (PROG ()
    (RETURN
     (COND ((STRINGP |u|) (LENGTH |u|))
           ((ATOM |u|) (LENGTH (|atom2String| |u|))) ('T (WIDTH (COPY |u|)))))))

; WIDTH u ==
;   STRINGP u => #u
;   INTEGERP u =>
;     if (u < 0) then
;       negative := 1
;       u := -u
;     else
;       negative := 0
;
;     -- Try and be fairly exact for smallish integers:
;     u < 100000000 =>
;         l :=
;               u < 10 =>       1
;               u < 100 =>      2
;               u < 1000 =>     3
;               u < 10000 =>    4
;               u < 100000 =>   5
;               u < 1000000 =>  6
;               u < 10000000 => 7
;               8
;         l + negative
;     k := INTEGER_-LENGTH(u)
;     k > MOST_-POSITIVE_-DOUBLE_-FLOAT =>
;         SAY("Number too big")
;         THROW('outputFailure,'outputFailure)
;
;     if (k < 61) then
;         l10 := LOG10 (FLOAT (u, 1.0))
;     else
;         su := ASH(u, - (k - 54))
;         l10 := LOG10 (FLOAT (su, 1.0))
;               -- we want full double precision here because the second
;               -- term may be much bigger than the first one, so we use
;               -- very precise estimate of log(2)/log(10)
;               + 0.301029995663981195213738894724 * FLOAT ((k - 54), 1.0)
;     -- Add bias to l10 to have only one-sided error
;     l10i := FLOOR(l10 + 1.0e-9)
;
;     l10i < 10000 =>
;        -- Check if sure
;        l10 - 1.0e-9 > l10i => 1 + negative + l10i
;        u < EXPT(10, l10i) => negative + l10i
;        1 + negative + l10i
;
;     -- width is very large, it would be expensive to compute it
;     -- accurately, so we just make sure that we overestimate.
;     -- l10 should have about 14 digits of accuracy
;     1 + negative + FLOOR(l10 * (1.0 + 1.0e-12))
;
;   atom u => # atom2String u
;   putWidth u is [[.,:n],:.] => n
;   THROW('outputFailure,'outputFailure)

(DEFUN WIDTH (|u|)
  (PROG (|negative| |l| |k| |l10| |su| |l10i| |ISTMP#1| |ISTMP#2| |n|)
    (RETURN
     (COND ((STRINGP |u|) (LENGTH |u|))
           ((INTEGERP |u|)
            (PROGN
             (COND ((MINUSP |u|) (SETQ |negative| 1) (SETQ |u| (- |u|)))
                   (#1='T (SETQ |negative| 0)))
             (COND
              ((< |u| 100000000)
               (PROGN
                (SETQ |l|
                        (COND ((< |u| 10) 1) ((< |u| 100) 2) ((< |u| 1000) 3)
                              ((< |u| 10000) 4) ((< |u| 100000) 5)
                              ((< |u| 1000000) 6) ((< |u| 10000000) 7)
                              (#1# 8)))
                (+ |l| |negative|)))
              (#1#
               (PROGN
                (SETQ |k| (INTEGER-LENGTH |u|))
                (COND
                 ((< MOST-POSITIVE-DOUBLE-FLOAT |k|)
                  (PROGN
                   (SAY '|Number too big|)
                   (THROW '|outputFailure| '|outputFailure|)))
                 (#1#
                  (PROGN
                   (COND ((< |k| 61) (SETQ |l10| (LOG10 (FLOAT |u| 1.0))))
                         (#1# (SETQ |su| (ASH |u| (- (- |k| 54))))
                          (SETQ |l10|
                                  (+ (LOG10 (FLOAT |su| 1.0))
                                     (* 0.30102999566398125
                                        (FLOAT (- |k| 54) 1.0))))))
                   (SETQ |l10i| (FLOOR (+ |l10| 1.0e-9)))
                   (COND
                    ((< |l10i| 10000)
                     (COND
                      ((< |l10i| (- |l10| 1.0e-9)) (+ (+ 1 |negative|) |l10i|))
                      ((< |u| (EXPT 10 |l10i|)) (+ |negative| |l10i|))
                      (#1# (+ (+ 1 |negative|) |l10i|))))
                    (#1#
                     (+ (+ 1 |negative|)
                        (FLOOR (* |l10| (+ 1.0 1.0e-12))))))))))))))
           ((ATOM |u|) (LENGTH (|atom2String| |u|)))
           ((PROGN
             (SETQ |ISTMP#1| (|putWidth| |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN (SETQ |n| (CDR |ISTMP#2|)) #1#)))))
            |n|)
           (#1# (THROW '|outputFailure| '|outputFailure|))))))

; putWidth u ==
;   atom u or u is [[.,:n],:.] and NUMBERP n => u
;   op:= keyp u
; --NUMBERP op => nil
;   leftPrec:= getBindingPowerOf("left",u)
;   rightPrec:= getBindingPowerOf("right",u)
;   [firstEl,:l] := u
;   interSpace:=
;     GETL(firstEl,"INFIXOP") => 0
;     1
;   argsWidth:=
;     l is [firstArg,:restArg] =>
;       RPLACA(rest u,putWidth firstArg)
;       for y in tails restArg repeat RPLACA(y,putWidth first y)
;       widthFirstArg:=
;         0=interSpace and infixArgNeedsParens(firstArg,leftPrec,"right")=>
;           2+WIDTH firstArg
;         WIDTH firstArg
;       widthFirstArg + +/[interSpace+w for x in restArg] where w ==
;         0=interSpace and infixArgNeedsParens(x, rightPrec, "left") =>
;           2+WIDTH x
;         WIDTH x
;     0
;   newFirst:=
;     atom (oldFirst:= first u) =>
;       fn:= GETL(oldFirst,"WIDTH") =>
;         [oldFirst,:FUNCALL(fn,[oldFirst,:l])]
;       if l then ll := rest l else ll := nil
;       [oldFirst,:opWidth(oldFirst,ll)+argsWidth]
;     [putWidth oldFirst,:2+WIDTH oldFirst+argsWidth]
;   RPLACA(u,newFirst)
;   u

(DEFUN |putWidth| (|u|)
  (PROG (|ISTMP#1| |n| |op| |leftPrec| |rightPrec| |firstEl| |l| |interSpace|
         |firstArg| |restArg| |widthFirstArg| |argsWidth| |oldFirst| |fn| |ll|
         |newFirst|)
    (RETURN
     (COND
      ((OR (ATOM |u|)
           (AND (CONSP |u|)
                (PROGN
                 (SETQ |ISTMP#1| (CAR |u|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN (SETQ |n| (CDR |ISTMP#1|)) #1='T)))
                (NUMBERP |n|)))
       |u|)
      (#1#
       (PROGN
        (SETQ |op| (|keyp| |u|))
        (SETQ |leftPrec| (|getBindingPowerOf| '|left| |u|))
        (SETQ |rightPrec| (|getBindingPowerOf| '|right| |u|))
        (SETQ |firstEl| (CAR |u|))
        (SETQ |l| (CDR |u|))
        (SETQ |interSpace| (COND ((GETL |firstEl| 'INFIXOP) 0) (#1# 1)))
        (SETQ |argsWidth|
                (COND
                 ((AND (CONSP |l|)
                       (PROGN
                        (SETQ |firstArg| (CAR |l|))
                        (SETQ |restArg| (CDR |l|))
                        #1#))
                  (PROGN
                   (RPLACA (CDR |u|) (|putWidth| |firstArg|))
                   ((LAMBDA (|y|)
                      (LOOP
                       (COND ((ATOM |y|) (RETURN NIL))
                             (#1# (RPLACA |y| (|putWidth| (CAR |y|)))))
                       (SETQ |y| (CDR |y|))))
                    |restArg|)
                   (SETQ |widthFirstArg|
                           (COND
                            ((AND (EQL 0 |interSpace|)
                                  (|infixArgNeedsParens| |firstArg| |leftPrec|
                                   '|right|))
                             (+ 2 (WIDTH |firstArg|)))
                            (#1# (WIDTH |firstArg|))))
                   (+ |widthFirstArg|
                      ((LAMBDA (|bfVar#59| |bfVar#58| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#58|)
                                (PROGN (SETQ |x| (CAR |bfVar#58|)) NIL))
                            (RETURN |bfVar#59|))
                           (#1#
                            (SETQ |bfVar#59|
                                    (+ |bfVar#59|
                                       (+ |interSpace|
                                          (COND
                                           ((AND (EQL 0 |interSpace|)
                                                 (|infixArgNeedsParens| |x|
                                                  |rightPrec| '|left|))
                                            (+ 2 (WIDTH |x|)))
                                           (#1# (WIDTH |x|))))))))
                          (SETQ |bfVar#58| (CDR |bfVar#58|))))
                       0 |restArg| NIL))))
                 (#1# 0)))
        (SETQ |newFirst|
                (COND
                 ((ATOM (SETQ |oldFirst| (CAR |u|)))
                  (COND
                   ((SETQ |fn| (GETL |oldFirst| 'WIDTH))
                    (CONS |oldFirst| (FUNCALL |fn| (CONS |oldFirst| |l|))))
                   (#1#
                    (PROGN
                     (COND (|l| (SETQ |ll| (CDR |l|))) (#1# (SETQ |ll| NIL)))
                     (CONS |oldFirst|
                           (+ (|opWidth| |oldFirst| |ll|) |argsWidth|))))))
                 (#1#
                  (CONS (|putWidth| |oldFirst|)
                        (+ (+ 2 (WIDTH |oldFirst|)) |argsWidth|)))))
        (RPLACA |u| |newFirst|)
        |u|))))))

; opWidth(op,has2Arguments) ==
;   op = "EQUATNUM" => 4
;   NUMBERP op => 2+SIZE STRINGIMAGE op
;   if null has2Arguments then
;     a := GETL(op, "PREFIXOP") => return SIZE a
;   else
;     a := GETL(op, "INFIXOP") => return SIZE a
;   STRINGP op => 2 + # op
;   2+SIZE PNAME op

(DEFUN |opWidth| (|op| |has2Arguments|)
  (PROG (|a|)
    (RETURN
     (COND ((EQ |op| 'EQUATNUM) 4)
           ((NUMBERP |op|) (+ 2 (SIZE (STRINGIMAGE |op|))))
           (#1='T
            (PROGN
             (COND
              ((NULL |has2Arguments|)
               (COND
                ((SETQ |a| (GETL |op| 'PREFIXOP))
                 (IDENTITY (RETURN (SIZE |a|))))))
              ((SETQ |a| (GETL |op| 'INFIXOP)) (IDENTITY (RETURN (SIZE |a|)))))
             (COND ((STRINGP |op|) (+ 2 (LENGTH |op|)))
                   (#1# (+ 2 (SIZE (PNAME |op|)))))))))))

; matrixBorder(x,y1,y2,d,leftOrRight) ==
;   y1 = y2 =>
;     c :=
;       leftOrRight = 'left => specialChar('lbrk)
;       specialChar('rbrk)
;     APP(c,x,y1,d)
;   for y in y1..y2 repeat
;     c :=
;       y = y1 =>
;         leftOrRight = 'left => specialChar('llc)
;         specialChar('lrc)
;       y = y2 =>
;         leftOrRight = 'left => specialChar('ulc)
;         specialChar('urc)
;       specialChar('vbar)
;     d := APP(c,x,y,d)
;   d

(DEFUN |matrixBorder| (|x| |y1| |y2| |d| |leftOrRight|)
  (PROG (|c|)
    (RETURN
     (COND
      ((EQUAL |y1| |y2|)
       (PROGN
        (SETQ |c|
                (COND ((EQ |leftOrRight| '|left|) (|specialChar| '|lbrk|))
                      (#1='T (|specialChar| '|rbrk|))))
        (APP |c| |x| |y1| |d|)))
      (#1#
       (PROGN
        ((LAMBDA (|y|)
           (LOOP
            (COND ((> |y| |y2|) (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |c|
                            (COND
                             ((EQUAL |y| |y1|)
                              (COND
                               ((EQ |leftOrRight| '|left|)
                                (|specialChar| '|llc|))
                               (#1# (|specialChar| '|lrc|))))
                             ((EQUAL |y| |y2|)
                              (COND
                               ((EQ |leftOrRight| '|left|)
                                (|specialChar| '|ulc|))
                               (#1# (|specialChar| '|urc|))))
                             (#1# (|specialChar| '|vbar|))))
                    (SETQ |d| (APP |c| |x| |y| |d|)))))
            (SETQ |y| (+ |y| 1))))
         |y1|)
        |d|))))))

; widthSC u == 10000

(DEFUN |widthSC| (|u|) (PROG () (RETURN 10000)))

; maprinSpecial(x,$MARGIN,$LINELENGTH) == maprin0 x

(DEFUN |maprinSpecial| (|x| $MARGIN $LINELENGTH)
  (DECLARE (SPECIAL $MARGIN $LINELENGTH))
  (PROG () (RETURN (|maprin0| |x|))))

; maprin x ==
;   CATCH('output,maprin0 x)
;   nil

(DEFUN |maprin| (|x|)
  (PROG () (RETURN (PROGN (CATCH '|output| (|maprin0| |x|)) NIL))))

; maprin0 x ==
;   $MatrixCount:local :=0
;   $MatrixList:local :=nil
;   maprinChk x
;   if $MatrixList then maprinRows $MatrixList

(DEFUN |maprin0| (|x|)
  (PROG (|$MatrixList| |$MatrixCount|)
    (DECLARE (SPECIAL |$MatrixList| |$MatrixCount|))
    (RETURN
     (PROGN
      (SETQ |$MatrixCount| 0)
      (SETQ |$MatrixList| NIL)
      (|maprinChk| |x|)
      (COND (|$MatrixList| (|maprinRows| |$MatrixList|)))))))

; maprinChk x ==
;   null $MatrixList => maPrin x
;   ATOM x and (u:= assoc(x,$MatrixList)) =>
;     $MatrixList := delete(u,$MatrixList)
;     maPrin deMatrix CDR u
;   x is ["=",arg,y]  =>     --case for tracing with )math and printing matrices
;     u:= assoc(y,$MatrixList) =>
;       -- we don't want to print matrix1 = matrix2 ...
;       $MatrixList := delete(u,$MatrixList)
;       maPrin ["=",arg, deMatrix CDR u]
;     maPrin x
;   x is ['EQUATNUM,n,y] =>
;     $MatrixList is [[name,:value]] and y=name =>
;       $MatrixList:=[]   -- we are pulling this one off
;       maPrin ['EQUATNUM,n, deMatrix value]
;     IDENTP y => --------this part is never called
;       -- Not true: JHD 28/2/93
;       -- m:=[[1,2,3],[4,5,6],[7,8,9]]
;       -- mm:=[[m,1,0],[0,m,1],[0,1,m]]
;       -- and try to print mm**5
;       u := assoc(y,$MatrixList)
;       $MatrixList := delete(u,$MatrixList)
;       maPrin ['EQUATNUM,n,rest u]
;       if not $collectOutput then TERPRI(get_algebra_stream())
;     maPrin x
;   maPrin x

(DEFUN |maprinChk| (|x|)
  (PROG (|u| |ISTMP#1| |arg| |ISTMP#2| |y| |n| |name| |value|)
    (RETURN
     (COND ((NULL |$MatrixList|) (|maPrin| |x|))
           ((AND (ATOM |x|) (SETQ |u| (|assoc| |x| |$MatrixList|)))
            (PROGN
             (SETQ |$MatrixList| (|delete| |u| |$MatrixList|))
             (|maPrin| (|deMatrix| (CDR |u|)))))
           ((AND (CONSP |x|) (EQ (CAR |x|) '=)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |arg| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1='T))))))
            (COND
             ((SETQ |u| (|assoc| |y| |$MatrixList|))
              (PROGN
               (SETQ |$MatrixList| (|delete| |u| |$MatrixList|))
               (|maPrin| (LIST '= |arg| (|deMatrix| (CDR |u|))))))
             (#1# (|maPrin| |x|))))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'EQUATNUM)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |n| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1#))))))
            (COND
             ((AND (CONSP |$MatrixList|) (EQ (CDR |$MatrixList|) NIL)
                   (PROGN
                    (SETQ |ISTMP#1| (CAR |$MatrixList|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |name| (CAR |ISTMP#1|))
                          (SETQ |value| (CDR |ISTMP#1|))
                          #1#)))
                   (EQUAL |y| |name|))
              (PROGN
               (SETQ |$MatrixList| NIL)
               (|maPrin| (LIST 'EQUATNUM |n| (|deMatrix| |value|)))))
             ((IDENTP |y|)
              (PROGN
               (SETQ |u| (|assoc| |y| |$MatrixList|))
               (SETQ |$MatrixList| (|delete| |u| |$MatrixList|))
               (|maPrin| (LIST 'EQUATNUM |n| (CDR |u|)))
               (COND
                ((NULL |$collectOutput|) (TERPRI (|get_algebra_stream|))))))
             (#1# (|maPrin| |x|))))
           (#1# (|maPrin| |x|))))))

; maprinRows matrixList ==
;     if not $collectOutput then TERPRI(get_algebra_stream())
;     y:=NREVERSE matrixList
;     --Makes the matrices come out in order, since CONSed on backwards
;     matrixList:=nil
;     firstName := first first y
;     for [name,:m] in y for n in 0.. repeat
;       if not $collectOutput then TERPRI(get_algebra_stream())
;       andWhere := (name = firstName => '"where "; '"and ")
;       line := STRCONC(andWhere, PNAME name)
;       maprinChk ["=",line,m]

(DEFUN |maprinRows| (|matrixList|)
  (PROG (|y| |firstName| |name| |m| |andWhere| |line|)
    (RETURN
     (PROGN
      (COND ((NULL |$collectOutput|) (TERPRI (|get_algebra_stream|))))
      (SETQ |y| (NREVERSE |matrixList|))
      (SETQ |matrixList| NIL)
      (SETQ |firstName| (CAR (CAR |y|)))
      ((LAMBDA (|bfVar#61| |bfVar#60| |n|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#61|)
                (PROGN (SETQ |bfVar#60| (CAR |bfVar#61|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#60|)
                 (PROGN
                  (SETQ |name| (CAR |bfVar#60|))
                  (SETQ |m| (CDR |bfVar#60|))
                  #1#)
                 (PROGN
                  (COND
                   ((NULL |$collectOutput|) (TERPRI (|get_algebra_stream|))))
                  (SETQ |andWhere|
                          (COND ((EQUAL |name| |firstName|) "where ")
                                (#1# "and ")))
                  (SETQ |line| (STRCONC |andWhere| (PNAME |name|)))
                  (|maprinChk| (LIST '= |line| |m|))))))
          (SETQ |bfVar#61| (CDR |bfVar#61|))
          (SETQ |n| (+ |n| 1))))
       |y| NIL 0)))))

; deMatrix m ==
;     ['BRACKET,['AGGLST,
;         :[['BRACKET,['AGGLST,:rest row]] for row in CDDR m]]]

(DEFUN |deMatrix| (|m|)
  (PROG ()
    (RETURN
     (LIST 'BRACKET
           (CONS 'AGGLST
                 ((LAMBDA (|bfVar#63| |bfVar#62| |row|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#62|)
                           (PROGN (SETQ |row| (CAR |bfVar#62|)) NIL))
                       (RETURN (NREVERSE |bfVar#63|)))
                      ('T
                       (SETQ |bfVar#63|
                               (CONS (LIST 'BRACKET (CONS 'AGGLST (CDR |row|)))
                                     |bfVar#63|))))
                     (SETQ |bfVar#62| (CDR |bfVar#62|))))
                  NIL (CDDR |m|) NIL))))))

; LargeMatrixp(u,width, dist) ==
;   --  sees if there is a matrix wider than 'width' in the next 'dist'
;   --  part of u, a sized charybdis structure.
;   --  NIL if not, first such matrix if there is one
;   ATOM u => nil
;   CDAR u <= width => nil
;        --CDAR is the width of a charybdis structure
;   op:=CAAR u
;   op = 'MATRIX => true
;          --We already know the structure is more than 'width' wide
;   MEMQ(op,'(LET SEGMENT _- CONCAT CONCATB PAREN BRACKET BRACE)) =>
;       --Each of these prints the arguments in a width 3 smaller
;     dist:=dist-3
;     width:=width-3
;     ans:=
;       for v in rest u repeat
;         (ans:=LargeMatrixp(v,width,dist)) => return ans
;         dist:=dist - WIDTH v
;         dist<0 => return nil
;     ans
;       --Relying that falling out of a loop gives nil
;   MEMQ(op,'(_+ _* )) =>
;       --Each of these prints the first argument in a width 3 smaller
;     (ans:=LargeMatrixp(CADR u,width-3,dist)) =>  ans
;     n:=3+WIDTH CADR u
;     dist:=dist-n
;     ans:=
;       for v in CDDR u repeat
;         (ans:=LargeMatrixp(v,width,dist)) => return ans
;         dist:=dist - WIDTH v
;         dist<0 => return nil
;     ans
;       --Relying that falling out of a loop gives nil
;   ans:=
;     for v in rest u repeat
;       (ans:=LargeMatrixp(v,width,dist)) => return ans
;       dist:=dist - WIDTH v
;       dist<0 => return nil
;   ans

(DEFUN |LargeMatrixp| (|u| |width| |dist|)
  (PROG (|op| |ans| |n|)
    (RETURN
     (COND ((ATOM |u|) NIL) ((NOT (< |width| (CDAR |u|))) NIL)
           (#1='T
            (PROGN
             (SETQ |op| (CAAR |u|))
             (COND ((EQ |op| 'MATRIX) T)
                   ((MEMQ |op|
                          '(LET SEGMENT
                             -
                             CONCAT
                             CONCATB
                             PAREN
                             BRACKET
                             BRACE))
                    (PROGN
                     (SETQ |dist| (- |dist| 3))
                     (SETQ |width| (- |width| 3))
                     (SETQ |ans|
                             ((LAMBDA (|bfVar#64| |v|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#64|)
                                       (PROGN (SETQ |v| (CAR |bfVar#64|)) NIL))
                                   (RETURN NIL))
                                  (#1#
                                   (COND
                                    ((SETQ |ans|
                                             (|LargeMatrixp| |v| |width|
                                              |dist|))
                                     (RETURN |ans|))
                                    (#1#
                                     (PROGN
                                      (SETQ |dist| (- |dist| (WIDTH |v|)))
                                      (COND
                                       ((MINUSP |dist|) (RETURN NIL))))))))
                                 (SETQ |bfVar#64| (CDR |bfVar#64|))))
                              (CDR |u|) NIL))
                     |ans|))
                   ((MEMQ |op| '(+ *))
                    (COND
                     ((SETQ |ans|
                              (|LargeMatrixp| (CADR |u|) (- |width| 3) |dist|))
                      |ans|)
                     (#1#
                      (PROGN
                       (SETQ |n| (+ 3 (WIDTH (CADR |u|))))
                       (SETQ |dist| (- |dist| |n|))
                       (SETQ |ans|
                               ((LAMBDA (|bfVar#65| |v|)
                                  (LOOP
                                   (COND
                                    ((OR (ATOM |bfVar#65|)
                                         (PROGN
                                          (SETQ |v| (CAR |bfVar#65|))
                                          NIL))
                                     (RETURN NIL))
                                    (#1#
                                     (COND
                                      ((SETQ |ans|
                                               (|LargeMatrixp| |v| |width|
                                                |dist|))
                                       (RETURN |ans|))
                                      (#1#
                                       (PROGN
                                        (SETQ |dist| (- |dist| (WIDTH |v|)))
                                        (COND
                                         ((MINUSP |dist|) (RETURN NIL))))))))
                                   (SETQ |bfVar#65| (CDR |bfVar#65|))))
                                (CDDR |u|) NIL))
                       |ans|))))
                   (#1#
                    (PROGN
                     (SETQ |ans|
                             ((LAMBDA (|bfVar#66| |v|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#66|)
                                       (PROGN (SETQ |v| (CAR |bfVar#66|)) NIL))
                                   (RETURN NIL))
                                  (#1#
                                   (COND
                                    ((SETQ |ans|
                                             (|LargeMatrixp| |v| |width|
                                              |dist|))
                                     (RETURN |ans|))
                                    (#1#
                                     (PROGN
                                      (SETQ |dist| (- |dist| (WIDTH |v|)))
                                      (COND
                                       ((MINUSP |dist|) (RETURN NIL))))))))
                                 (SETQ |bfVar#66| (CDR |bfVar#66|))))
                              (CDR |u|) NIL))
                     |ans|)))))))))

; PushMatrix m ==
;     --Adds the matrix to the look-aside list, and returns a name for it
;   name:=
;     for v in $MatrixList repeat
;         EQUAL(m, CDR v) => return first v
;   name => name
;   name := INTERNL1('"matrix", STRINGIMAGE($MatrixCount := $MatrixCount + 1))
;   $MatrixList:=[[name,:m],:$MatrixList]
;   name

(DEFUN |PushMatrix| (|m|)
  (PROG (|name|)
    (RETURN
     (PROGN
      (SETQ |name|
              ((LAMBDA (|bfVar#67| |v|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#67|)
                        (PROGN (SETQ |v| (CAR |bfVar#67|)) NIL))
                    (RETURN NIL))
                   (#1='T
                    (COND
                     ((EQUAL |m| (CDR |v|)) (IDENTITY (RETURN (CAR |v|)))))))
                  (SETQ |bfVar#67| (CDR |bfVar#67|))))
               |$MatrixList| NIL))
      (COND (|name| |name|)
            (#1#
             (PROGN
              (SETQ |name|
                      (INTERNL1 "matrix"
                       (STRINGIMAGE
                        (SETQ |$MatrixCount| (+ |$MatrixCount| 1)))))
              (SETQ |$MatrixList| (CONS (CONS |name| |m|) |$MatrixList|))
              |name|)))))))

; quoteApp([.,a],x,y,d) == APP(a,x+1,y,appChar(PNAME "'",x,y,d))

(DEFUN |quoteApp| (|bfVar#68| |x| |y| |d|)
  (PROG (|a|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR |bfVar#68|))
      (APP |a| (+ |x| 1) |y| (|appChar| (PNAME '|'|) |x| |y| |d|))))))

; quoteSub [.,a] == subspan a

(DEFUN |quoteSub| (|bfVar#69|)
  (PROG (|a|) (RETURN (PROGN (SETQ |a| (CADR |bfVar#69|)) (|subspan| |a|)))))

; quoteSuper [.,a] == superspan a

(DEFUN |quoteSuper| (|bfVar#70|)
  (PROG (|a|) (RETURN (PROGN (SETQ |a| (CADR |bfVar#70|)) (|superspan| |a|)))))

; quoteWidth [.,a] == 1 + WIDTH a

(DEFUN |quoteWidth| (|bfVar#71|)
  (PROG (|a|) (RETURN (PROGN (SETQ |a| (CADR |bfVar#71|)) (+ 1 (WIDTH |a|))))))

; SubstWhileDesizing(u) ==
;     --Replaces all occurrences of matrix by name in u
;     --Taking out any outdated size information as it goes
;   ATOM u => u
;   [[op,:n],:l]:=u
;   op = 'MATRIX =>
;     l' := SubstWhileDesizingList(rest l)
;     u :=
;       [op,nil,:l']
;     PushMatrix u
;   l':=SubstWhileDesizingList(l)
;   ATOM op => [op,:l']
;   [SubstWhileDesizing(op),:l']

(DEFUN |SubstWhileDesizing| (|u|)
  (PROG (|op| |n| |l| |l'|)
    (RETURN
     (COND ((ATOM |u|) |u|)
           (#1='T
            (PROGN
             (SETQ |op| (CAAR . #2=(|u|)))
             (SETQ |n| (CDAR . #2#))
             (SETQ |l| (CDR |u|))
             (COND
              ((EQ |op| 'MATRIX)
               (PROGN
                (SETQ |l'| (|SubstWhileDesizingList| (CDR |l|)))
                (SETQ |u| (CONS |op| (CONS NIL |l'|)))
                (|PushMatrix| |u|)))
              (#1#
               (PROGN
                (SETQ |l'| (|SubstWhileDesizingList| |l|))
                (COND ((ATOM |op|) (CONS |op| |l'|))
                      (#1# (CONS (|SubstWhileDesizing| |op|) |l'|))))))))))))

; SubstWhileDesizingList(u) ==
;     [SubstWhileDesizing(i) for i in u]

(DEFUN |SubstWhileDesizingList| (|u|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#73| |bfVar#72| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#72|) (PROGN (SETQ |i| (CAR |bfVar#72|)) NIL))
           (RETURN (NREVERSE |bfVar#73|)))
          ('T (SETQ |bfVar#73| (CONS (|SubstWhileDesizing| |i|) |bfVar#73|))))
         (SETQ |bfVar#72| (CDR |bfVar#72|))))
      NIL |u| NIL))))

; sigmaSub u ==
;        --The depth function for sigmas with lower limit only
;   MAX(1 + height CADR u, subspan CADDR u)

(DEFUN |sigmaSub| (|u|)
  (PROG () (RETURN (MAX (+ 1 (|height| (CADR |u|))) (|subspan| (CADDR |u|))))))

; sigmaSup u ==
;        --The height function for sigmas with lower limit only
;   MAX(1, superspan CADDR u)

(DEFUN |sigmaSup| (|u|) (PROG () (RETURN (MAX 1 (|superspan| (CADDR |u|))))))

; sigmaApp(u,x,y,d) ==
;   u is [.,bot,arg] or THROW('outputFailure,'outputFailure)
;   bigopAppAux(bot,nil,arg,x,y,d,'sigma)

(DEFUN |sigmaApp| (|u| |x| |y| |d|)
  (PROG (|ISTMP#1| |bot| |ISTMP#2| |arg|)
    (RETURN
     (PROGN
      (OR
       (AND (CONSP |u|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |bot| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |arg| (CAR |ISTMP#2|)) 'T))))))
       (THROW '|outputFailure| '|outputFailure|))
      (|bigopAppAux| |bot| NIL |arg| |x| |y| |d| '|sigma|)))))

; sigma2App(u,x,y,d) ==
;   [.,bot,top,arg]:=u
;   bigopAppAux(bot,top,arg,x,y,d,'sigma)

(DEFUN |sigma2App| (|u| |x| |y| |d|)
  (PROG (|bot| |top| |arg|)
    (RETURN
     (PROGN
      (SETQ |bot| (CADR . #1=(|u|)))
      (SETQ |top| (CADDR . #1#))
      (SETQ |arg| (CADDDR . #1#))
      (|bigopAppAux| |bot| |top| |arg| |x| |y| |d| '|sigma|)))))

; bigopWidth(bot,top,arg,kind) ==
;   kindWidth := (kind = 'pi => 5; 3)
;   MAX(kindWidth,WIDTH bot,(top => WIDTH top; 0)) + 2 + WIDTH arg

(DEFUN |bigopWidth| (|bot| |top| |arg| |kind|)
  (PROG (|kindWidth|)
    (RETURN
     (PROGN
      (SETQ |kindWidth| (COND ((EQ |kind| '|pi|) 5) (#1='T 3)))
      (+
       (+ (MAX |kindWidth| (WIDTH |bot|) (COND (|top| (WIDTH |top|)) (#1# 0)))
          2)
       (WIDTH |arg|))))))

; bigopAppAux(bot,top,arg,x,y,d,kind) ==
;   botWidth := (bot => WIDTH bot; 0)
;   topWidth := WIDTH top
;   opWidth :=
;     kind = 'pi => 5
;     3
;   maxWidth := MAX(opWidth,botWidth,topWidth)
;   xCenter := QUOTIENT(maxWidth - 1, 2) + x
;   d:=APP(arg,x+2+maxWidth,y,d)
;   d:=
;       atom bot and SIZE atom2String bot = 1 => APP(bot,xCenter,y-2,d)
;       APP(bot, x + QUOTIENT(maxWidth - botWidth, 2), y-2-superspan bot, d)
;   if top then
;     d:=
;       atom top and SIZE atom2String top = 1 => APP(top,xCenter,y+2,d)
;       APP(top, x + QUOTIENT(maxWidth - topWidth, 2), y+2+subspan top, d)
;   delta := (kind = 'pi => 2; 1)
;   opCode :=
;     kind = 'sigma =>
;       [['(0 .  0),:'">"],_
;        ['(0 .  1),:specialChar('hbar)],_
;        ['(0 . -1),:specialChar('hbar)],_
;        ['(1 .  1),:specialChar('hbar)],_
;        ['(1 . -1),:specialChar('hbar)],_
;        ['(2 .  1),:specialChar('urc )],_
;        ['(2 . -1),:specialChar('lrc )]]
;     kind = 'pi =>
;       [['(0 .  1),:specialChar('ulc )],_
;        ['(1 .  0),:specialChar('vbar)],_
;        ['(1 .  1),:specialChar('ttee)],_
;        ['(1 . -1),:specialChar('vbar)],_
;        ['(2 .  1),:specialChar('hbar)],_
;        ['(3 .  0),:specialChar('vbar)],_
;        ['(3 .  1),:specialChar('ttee)],_
;        ['(3 . -1),:specialChar('vbar)],_
;        ['(4 .  1),:specialChar('urc )]]
;     THROW('outputFailure,'outputFailure)
;   xLate(opCode,xCenter - delta,y,d)

(DEFUN |bigopAppAux| (|bot| |top| |arg| |x| |y| |d| |kind|)
  (PROG (|botWidth| |topWidth| |opWidth| |maxWidth| |xCenter| |delta| |opCode|)
    (RETURN
     (PROGN
      (SETQ |botWidth| (COND (|bot| (WIDTH |bot|)) (#1='T 0)))
      (SETQ |topWidth| (WIDTH |top|))
      (SETQ |opWidth| (COND ((EQ |kind| '|pi|) 5) (#1# 3)))
      (SETQ |maxWidth| (MAX |opWidth| |botWidth| |topWidth|))
      (SETQ |xCenter| (+ (QUOTIENT (- |maxWidth| 1) 2) |x|))
      (SETQ |d| (APP |arg| (+ (+ |x| 2) |maxWidth|) |y| |d|))
      (SETQ |d|
              (COND
               ((AND (ATOM |bot|) (EQL (SIZE (|atom2String| |bot|)) 1))
                (APP |bot| |xCenter| (- |y| 2) |d|))
               (#1#
                (APP |bot| (+ |x| (QUOTIENT (- |maxWidth| |botWidth|) 2))
                 (- (- |y| 2) (|superspan| |bot|)) |d|))))
      (COND
       (|top|
        (SETQ |d|
                (COND
                 ((AND (ATOM |top|) (EQL (SIZE (|atom2String| |top|)) 1))
                  (APP |top| |xCenter| (+ |y| 2) |d|))
                 (#1#
                  (APP |top| (+ |x| (QUOTIENT (- |maxWidth| |topWidth|) 2))
                   (+ (+ |y| 2) (|subspan| |top|)) |d|))))))
      (SETQ |delta| (COND ((EQ |kind| '|pi|) 2) (#1# 1)))
      (SETQ |opCode|
              (COND
               ((EQ |kind| '|sigma|)
                (LIST (CONS '(0 . 0) ">")
                      (CONS '(0 . 1) (|specialChar| '|hbar|))
                      (CONS '(0 . -1) (|specialChar| '|hbar|))
                      (CONS '(1 . 1) (|specialChar| '|hbar|))
                      (CONS '(1 . -1) (|specialChar| '|hbar|))
                      (CONS '(2 . 1) (|specialChar| '|urc|))
                      (CONS '(2 . -1) (|specialChar| '|lrc|))))
               ((EQ |kind| '|pi|)
                (LIST (CONS '(0 . 1) (|specialChar| '|ulc|))
                      (CONS '(1 . 0) (|specialChar| '|vbar|))
                      (CONS '(1 . 1) (|specialChar| '|ttee|))
                      (CONS '(1 . -1) (|specialChar| '|vbar|))
                      (CONS '(2 . 1) (|specialChar| '|hbar|))
                      (CONS '(3 . 0) (|specialChar| '|vbar|))
                      (CONS '(3 . 1) (|specialChar| '|ttee|))
                      (CONS '(3 . -1) (|specialChar| '|vbar|))
                      (CONS '(4 . 1) (|specialChar| '|urc|))))
               (#1# (THROW '|outputFailure| '|outputFailure|))))
      (|xLate| |opCode| (- |xCenter| |delta|) |y| |d|)))))

; sigmaWidth [.,bot,arg] == bigopWidth(bot,nil,arg,'sigma)

(DEFUN |sigmaWidth| (|bfVar#74|)
  (PROG (|bot| |arg|)
    (RETURN
     (PROGN
      (SETQ |bot| (CADR . #1=(|bfVar#74|)))
      (SETQ |arg| (CADDR . #1#))
      (|bigopWidth| |bot| NIL |arg| '|sigma|)))))

; sigma2Width [.,bot,top,arg] == bigopWidth(bot,top,arg,'sigma)

(DEFUN |sigma2Width| (|bfVar#75|)
  (PROG (|bot| |top| |arg|)
    (RETURN
     (PROGN
      (SETQ |bot| (CADR . #1=(|bfVar#75|)))
      (SETQ |top| (CADDR . #1#))
      (SETQ |arg| (CADDDR . #1#))
      (|bigopWidth| |bot| |top| |arg| '|sigma|)))))

; sigma2Sub u ==
;        --The depth function for sigmas with 2 limits
;   MAX(1 + height CADR u, subspan CADDDR u)

(DEFUN |sigma2Sub| (|u|)
  (PROG () (RETURN (MAX (+ 1 (|height| (CADR |u|))) (|subspan| (CADDDR |u|))))))

; sigma2Sup u ==
;        --The depth function for sigmas with 2 limits
;   MAX(1 + height CADDR u, superspan CADDDR u)

(DEFUN |sigma2Sup| (|u|)
  (PROG ()
    (RETURN (MAX (+ 1 (|height| (CADDR |u|))) (|superspan| (CADDDR |u|))))))

; piSub u ==
;        --The depth function for pi's (products)
;   MAX(1 + height CADR u, subspan CADDR u)

(DEFUN |piSub| (|u|)
  (PROG () (RETURN (MAX (+ 1 (|height| (CADR |u|))) (|subspan| (CADDR |u|))))))

; piSup u ==
;        --The height function for pi's (products)
;   MAX(1, superspan CADDR u)

(DEFUN |piSup| (|u|) (PROG () (RETURN (MAX 1 (|superspan| (CADDR |u|))))))

; piApp(u,x,y,d) ==
;   u is [.,bot,arg] or THROW('outputFailure,'outputFailure)
;   bigopAppAux(bot,nil,arg,x,y,d,'pi)

(DEFUN |piApp| (|u| |x| |y| |d|)
  (PROG (|ISTMP#1| |bot| |ISTMP#2| |arg|)
    (RETURN
     (PROGN
      (OR
       (AND (CONSP |u|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |bot| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |arg| (CAR |ISTMP#2|)) 'T))))))
       (THROW '|outputFailure| '|outputFailure|))
      (|bigopAppAux| |bot| NIL |arg| |x| |y| |d| '|pi|)))))

; piWidth [.,bot,arg] == bigopWidth(bot,nil,arg,'pi)

(DEFUN |piWidth| (|bfVar#76|)
  (PROG (|bot| |arg|)
    (RETURN
     (PROGN
      (SETQ |bot| (CADR . #1=(|bfVar#76|)))
      (SETQ |arg| (CADDR . #1#))
      (|bigopWidth| |bot| NIL |arg| '|pi|)))))

; pi2Width [.,bot,top,arg] == bigopWidth(bot,top,arg,'pi)

(DEFUN |pi2Width| (|bfVar#77|)
  (PROG (|bot| |top| |arg|)
    (RETURN
     (PROGN
      (SETQ |bot| (CADR . #1=(|bfVar#77|)))
      (SETQ |top| (CADDR . #1#))
      (SETQ |arg| (CADDDR . #1#))
      (|bigopWidth| |bot| |top| |arg| '|pi|)))))

; pi2Sub u ==
;        --The depth function for pi's with 2 limits
;   MAX(1 + height CADR u, subspan CADDDR u)

(DEFUN |pi2Sub| (|u|)
  (PROG () (RETURN (MAX (+ 1 (|height| (CADR |u|))) (|subspan| (CADDDR |u|))))))

; pi2Sup u ==
;        --The depth function for pi's with 2 limits
;   MAX(1 + height CADDR u, superspan CADDDR u)

(DEFUN |pi2Sup| (|u|)
  (PROG ()
    (RETURN (MAX (+ 1 (|height| (CADDR |u|))) (|superspan| (CADDDR |u|))))))

; pi2App(u,x,y,d) ==
;   [.,bot,top,arg]:=u
;   bigopAppAux(bot,top,arg,x,y,d,'pi)

(DEFUN |pi2App| (|u| |x| |y| |d|)
  (PROG (|bot| |top| |arg|)
    (RETURN
     (PROGN
      (SETQ |bot| (CADR . #1=(|u|)))
      (SETQ |top| (CADDR . #1#))
      (SETQ |arg| (CADDDR . #1#))
      (|bigopAppAux| |bot| |top| |arg| |x| |y| |d| '|pi|)))))

; overlabelSuper [.,a,b] == 1 + height a + superspan b

(DEFUN |overlabelSuper| (|bfVar#78|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#78|)))
      (SETQ |b| (CADDR . #1#))
      (+ (+ 1 (|height| |a|)) (|superspan| |b|))))))

; overlabelWidth [.,a,b] == WIDTH b

(DEFUN |overlabelWidth| (|bfVar#79|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#79|)))
      (SETQ |b| (CADDR . #1#))
      (WIDTH |b|)))))

; overlabelApp([.,a,b], x, y, d) ==
;   d := APP(b, x, y, d) -- the part that is under the label
;   -- if b is empty, we set the width to 1 to prevent overflow
;   wb := MAX(WIDTH b, 1)
;   endPoint := x + wb - 1
;   middle := QUOTIENT(x + endPoint,2)
;   h := y + superspan b + 1
;   d := APP(a,middle,h + 1,d)
;   apphor(x, endPoint, y+superspan b+1,d,"|")

(DEFUN |overlabelApp| (|bfVar#80| |x| |y| |d|)
  (PROG (|a| |b| |wb| |endPoint| |middle| |h|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#80|)))
      (SETQ |b| (CADDR . #1#))
      (SETQ |d| (APP |b| |x| |y| |d|))
      (SETQ |wb| (MAX (WIDTH |b|) 1))
      (SETQ |endPoint| (- (+ |x| |wb|) 1))
      (SETQ |middle| (QUOTIENT (+ |x| |endPoint|) 2))
      (SETQ |h| (+ (+ |y| (|superspan| |b|)) 1))
      (SETQ |d| (APP |a| |middle| (+ |h| 1) |d|))
      (|apphor| |x| |endPoint| (+ (+ |y| (|superspan| |b|)) 1) |d| '|\||)))))

; overbarSuper u == 1 + superspan u.1

(DEFUN |overbarSuper| (|u|) (PROG () (RETURN (+ 1 (|superspan| (ELT |u| 1))))))

; overbarWidth u == WIDTH u.1

(DEFUN |overbarWidth| (|u|) (PROG () (RETURN (WIDTH (ELT |u| 1)))))

; overbarApp(u,x,y,d) ==
;   d := APP(u.1, x, y, d) -- the part that is under the bar
;   apphor(x,x+WIDTH u.1-1,y+superspan u.1+1,d,UNDERBAR)

(DEFUN |overbarApp| (|u| |x| |y| |d|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |d| (APP (ELT |u| 1) |x| |y| |d|))
      (|apphor| |x| (- (+ |x| (WIDTH (ELT |u| 1))) 1)
       (+ (+ |y| (|superspan| (ELT |u| 1))) 1) |d| UNDERBAR)))))

; intSub u ==
;    MAX(1 + height u.1, subspan u.3)

(DEFUN |intSub| (|u|)
  (PROG () (RETURN (MAX (+ 1 (|height| (ELT |u| 1))) (|subspan| (ELT |u| 3))))))

; intSup u ==
;    MAX(1 + height u.2, superspan u.3)

(DEFUN |intSup| (|u|)
  (PROG ()
    (RETURN (MAX (+ 1 (|height| (ELT |u| 2))) (|superspan| (ELT |u| 3))))))

; intApp(u,x,y,d) ==
;   [.,bot,top,arg]:=u
;   d:=APP(arg,x+4+MAX(-4 + WIDTH bot, WIDTH top),y,d)
;   d:=APP(bot,x,y-2-superspan bot,d)
;   d:=APP(top,x+3,y+2+subspan top,d)
;   xLate( [['(0 . -1),:specialChar('llc) ],_
;           ['(1 . -1),:specialChar('lrc) ],_
;           ['(1 .  0),:specialChar('vbar)],_
;           ['(1 .  1),:specialChar('ulc) ],_
;           ['(2 .  1),:specialChar('urc) ]], x,y,d)

(DEFUN |intApp| (|u| |x| |y| |d|)
  (PROG (|bot| |top| |arg|)
    (RETURN
     (PROGN
      (SETQ |bot| (CADR . #1=(|u|)))
      (SETQ |top| (CADDR . #1#))
      (SETQ |arg| (CADDDR . #1#))
      (SETQ |d|
              (APP |arg|
               (+ (+ |x| 4) (MAX (+ (- 4) (WIDTH |bot|)) (WIDTH |top|))) |y|
               |d|))
      (SETQ |d| (APP |bot| |x| (- (- |y| 2) (|superspan| |bot|)) |d|))
      (SETQ |d| (APP |top| (+ |x| 3) (+ (+ |y| 2) (|subspan| |top|)) |d|))
      (|xLate|
       (LIST (CONS '(0 . -1) (|specialChar| '|llc|))
             (CONS '(1 . -1) (|specialChar| '|lrc|))
             (CONS '(1 . 0) (|specialChar| '|vbar|))
             (CONS '(1 . 1) (|specialChar| '|ulc|))
             (CONS '(2 . 1) (|specialChar| '|urc|)))
       |x| |y| |d|)))))

; intWidth u ==
;   # u < 4 => THROW('outputFailure,'outputFailure)
;   MAX(-4 + WIDTH u.1, WIDTH u.2) + WIDTH u.3 + 5

(DEFUN |intWidth| (|u|)
  (PROG ()
    (RETURN
     (COND ((< (LENGTH |u|) 4) (THROW '|outputFailure| '|outputFailure|))
           ('T
            (+
             (+ (MAX (+ (- 4) (WIDTH (ELT |u| 1))) (WIDTH (ELT |u| 2)))
                (WIDTH (ELT |u| 3)))
             5))))))

; xLate(l,x,y,d) ==
;   for [[a,:b],:c] in l repeat
;     d:= appChar(c,x+a,y+b,d)
;   d

(DEFUN |xLate| (|l| |x| |y| |d|)
  (PROG (|ISTMP#1| |a| |b| |c|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#82| |bfVar#81|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#82|)
                (PROGN (SETQ |bfVar#81| (CAR |bfVar#82|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#81|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |bfVar#81|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |b| (CDR |ISTMP#1|))
                        #1#)))
                 (PROGN (SETQ |c| (CDR |bfVar#81|)) #1#)
                 (SETQ |d| (|appChar| |c| (+ |x| |a|) (+ |y| |b|) |d|)))))
          (SETQ |bfVar#82| (CDR |bfVar#82|))))
       |l| NIL)
      |d|))))

; concatTrouble(u, d, start, lineLength, addBlankIfTrue) ==
;   [x,:l] := splitConcat(u, lineLength, true, addBlankIfTrue)
;   null l =>
;     sayALGEBRA ['%l,'%b,'"  Too wide to Print",'%d]
;     THROW('output,nil)
;   charybdis(fixUp(x, addBlankIfTrue), start, lineLength)
;   for y in l repeat
;     if d then prnd(start,d)
;     y := fixUp(y, addBlankIfTrue)
;     if lineLength > 2 then
;        charybdis(y, start + 2, lineLength - 2) -- JHD needs this to avoid lunacy
;       else charybdis(y, start, 1) -- JHD needs this to avoid lunacy
;   BLANK
;  where
;   fixUp(x, addBlankIfTrue) ==
;     rest x =>
;       addBlankIfTrue => ['CONCATB,:x]
;       ["CONCAT",:x]
;     first x

(DEFUN |concatTrouble| (|u| |d| |start| |lineLength| |addBlankIfTrue|)
  (PROG (|LETTMP#1| |x| |l|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|splitConcat| |u| |lineLength| T |addBlankIfTrue|))
      (SETQ |x| (CAR |LETTMP#1|))
      (SETQ |l| (CDR |LETTMP#1|))
      (COND
       ((NULL |l|)
        (PROGN
         (|sayALGEBRA| (LIST '|%l| '|%b| "  Too wide to Print" '|%d|))
         (THROW '|output| NIL)))
       (#1='T
        (PROGN
         (|charybdis| (|concatTrouble,fixUp| |x| |addBlankIfTrue|) |start|
          |lineLength|)
         ((LAMBDA (|bfVar#83| |y|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#83|) (PROGN (SETQ |y| (CAR |bfVar#83|)) NIL))
               (RETURN NIL))
              (#1#
               (PROGN
                (COND (|d| (|prnd| |start| |d|)))
                (SETQ |y| (|concatTrouble,fixUp| |y| |addBlankIfTrue|))
                (COND
                 ((< 2 |lineLength|)
                  (|charybdis| |y| (+ |start| 2) (- |lineLength| 2)))
                 (#1# (|charybdis| |y| |start| 1))))))
             (SETQ |bfVar#83| (CDR |bfVar#83|))))
          |l| NIL)
         BLANK)))))))
(DEFUN |concatTrouble,fixUp| (|x| |addBlankIfTrue|)
  (PROG ()
    (RETURN
     (COND
      ((CDR |x|)
       (COND (|addBlankIfTrue| (CONS 'CONCATB |x|))
             (#1='T (CONS 'CONCAT |x|))))
      (#1# (CAR |x|))))))

; splitConcat(list, maxWidth, firstTimeIfTrue, addBlankIfTrue) ==
;   null list => nil
;   -- split list l into a list of n lists, each of which
;   -- has width < maxWidth
;   totalWidth:= 0
;   oneOrZero := (addBlankIfTrue => 1; 0)
;   l := list
;   maxW:= (firstTimeIfTrue => maxWidth; maxWidth-2)
;   maxW < 1 => [[x] for x in l] -- JHD 22.8.95, otherwise things can break
;   for x in tails l
;     while (width := oneOrZero + WIDTH first x + totalWidth) < maxW repeat
;       l:= x
;       totalWidth:= width
;   x:= rest l
;   rplac(rest l, nil)
;   [list, :splitConcat(x, maxWidth, nil, addBlankIfTrue)]

(DEFUN |splitConcat| (LIST |maxWidth| |firstTimeIfTrue| |addBlankIfTrue|)
  (PROG (|totalWidth| |oneOrZero| |l| |maxW| |width| |x|)
    (RETURN
     (COND ((NULL LIST) NIL)
           (#1='T
            (PROGN
             (SETQ |totalWidth| 0)
             (SETQ |oneOrZero| (COND (|addBlankIfTrue| 1) (#1# 0)))
             (SETQ |l| LIST)
             (SETQ |maxW|
                     (COND (|firstTimeIfTrue| |maxWidth|)
                           (#1# (- |maxWidth| 2))))
             (COND
              ((< |maxW| 1)
               ((LAMBDA (|bfVar#85| |bfVar#84| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#84|)
                         (PROGN (SETQ |x| (CAR |bfVar#84|)) NIL))
                     (RETURN (NREVERSE |bfVar#85|)))
                    (#1# (SETQ |bfVar#85| (CONS (LIST |x|) |bfVar#85|))))
                   (SETQ |bfVar#84| (CDR |bfVar#84|))))
                NIL |l| NIL))
              (#1#
               (PROGN
                ((LAMBDA (|x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |x|)
                          (NOT
                           (<
                            (SETQ |width|
                                    (+ (+ |oneOrZero| (WIDTH (CAR |x|)))
                                       |totalWidth|))
                            |maxW|)))
                      (RETURN NIL))
                     (#1# (PROGN (SETQ |l| |x|) (SETQ |totalWidth| |width|))))
                    (SETQ |x| (CDR |x|))))
                 |l|)
                (SETQ |x| (CDR |l|))
                (|rplac| (CDR |l|) NIL)
                (CONS LIST
                      (|splitConcat| |x| |maxWidth| NIL
                       |addBlankIfTrue|)))))))))))

; spadPrint(x,m) ==
;   m = $NoValueMode => x
;   if not $collectOutput then TERPRI(get_algebra_stream())
;   output(x,m)
;   if not $collectOutput then TERPRI(get_algebra_stream())

(DEFUN |spadPrint| (|x| |m|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |m| |$NoValueMode|) |x|)
           ('T
            (PROGN
             (COND ((NULL |$collectOutput|) (TERPRI (|get_algebra_stream|))))
             (|output| |x| |m|)
             (COND
              ((NULL |$collectOutput|) (TERPRI (|get_algebra_stream|))))))))))

; fortranFormat expr ==
;     ff := '(FortranFormat)
;     formatFn :=
;         getFunctionFromDomain("convert", ff, [$OutputForm, $Integer])
;     displayFn := getFunctionFromDomain("display", ff, [ff])
;     SPADCALL(SPADCALL(expr, $IOindex, formatFn), displayFn)
;     if not $collectOutput then TERPRI(get_fortran_stream())
;     FORCE_-OUTPUT(get_fortran_stream())

(DEFUN |fortranFormat| (|expr|)
  (PROG (|ff| |formatFn| |displayFn|)
    (RETURN
     (PROGN
      (SETQ |ff| '(|FortranFormat|))
      (SETQ |formatFn|
              (|getFunctionFromDomain| '|convert| |ff|
               (LIST |$OutputForm| |$Integer|)))
      (SETQ |displayFn| (|getFunctionFromDomain| '|display| |ff| (LIST |ff|)))
      (SPADCALL (SPADCALL |expr| |$IOindex| |formatFn|) |displayFn|)
      (COND ((NULL |$collectOutput|) (TERPRI (|get_fortran_stream|))))
      (FORCE-OUTPUT (|get_fortran_stream|))))))

; texFormat expr ==
;   ioHook("startTeXOutput")
;   tf := '(TexFormat)
;   formatFn :=
;     getFunctionFromDomain("convert",tf,[$OutputForm,$Integer])
;   displayFn := getFunctionFromDomain("display",tf,[tf])
;   SPADCALL(SPADCALL(expr,$IOindex,formatFn),displayFn)
;   TERPRI(get_tex_stream())
;   FORCE_-OUTPUT(get_tex_stream())
;   ioHook("endOfTeXOutput")
;   NIL

(DEFUN |texFormat| (|expr|)
  (PROG (|tf| |formatFn| |displayFn|)
    (RETURN
     (PROGN
      (|ioHook| '|startTeXOutput|)
      (SETQ |tf| '(|TexFormat|))
      (SETQ |formatFn|
              (|getFunctionFromDomain| '|convert| |tf|
               (LIST |$OutputForm| |$Integer|)))
      (SETQ |displayFn| (|getFunctionFromDomain| '|display| |tf| (LIST |tf|)))
      (SPADCALL (SPADCALL |expr| |$IOindex| |formatFn|) |displayFn|)
      (TERPRI (|get_tex_stream|))
      (FORCE-OUTPUT (|get_tex_stream|))
      (|ioHook| '|endOfTeXOutput|)
      NIL))))

; texFormat1 expr ==
;   tf := '(TexFormat)
;   formatFn := getFunctionFromDomain("coerce",tf, [$OutputForm])
;   displayFn := getFunctionFromDomain("display",tf,[tf])
;   SPADCALL(SPADCALL(expr,formatFn),displayFn)
;   TERPRI(get_tex_stream())
;   FORCE_-OUTPUT(get_tex_stream())
;   NIL

(DEFUN |texFormat1| (|expr|)
  (PROG (|tf| |formatFn| |displayFn|)
    (RETURN
     (PROGN
      (SETQ |tf| '(|TexFormat|))
      (SETQ |formatFn|
              (|getFunctionFromDomain| '|coerce| |tf| (LIST |$OutputForm|)))
      (SETQ |displayFn| (|getFunctionFromDomain| '|display| |tf| (LIST |tf|)))
      (SPADCALL (SPADCALL |expr| |formatFn|) |displayFn|)
      (TERPRI (|get_tex_stream|))
      (FORCE-OUTPUT (|get_tex_stream|))
      NIL))))

; mathmlFormat expr ==
;   mml := '(MathMLFormat)
;   mmlrep := '(String)
;   formatFn := getFunctionFromDomain("coerce",mml,[$OutputForm])
;   displayFn := getFunctionFromDomain("display",mml,[mmlrep])
;   SPADCALL(SPADCALL(expr,formatFn),displayFn)
;   TERPRI(get_mathml_stream())
;   FORCE_-OUTPUT(get_mathml_stream())
;   NIL

(DEFUN |mathmlFormat| (|expr|)
  (PROG (|mml| |mmlrep| |formatFn| |displayFn|)
    (RETURN
     (PROGN
      (SETQ |mml| '(|MathMLFormat|))
      (SETQ |mmlrep| '(|String|))
      (SETQ |formatFn|
              (|getFunctionFromDomain| '|coerce| |mml| (LIST |$OutputForm|)))
      (SETQ |displayFn|
              (|getFunctionFromDomain| '|display| |mml| (LIST |mmlrep|)))
      (SPADCALL (SPADCALL |expr| |formatFn|) |displayFn|)
      (TERPRI (|get_mathml_stream|))
      (FORCE-OUTPUT (|get_mathml_stream|))
      NIL))))

; texmacsFormat expr ==
;   ioHook("startTeXmacsOutput")
;   mml := '(TexmacsFormat)
;   mmlrep := '(String)
;   formatFn := getFunctionFromDomain("coerce",mml,[$OutputForm])
;   displayFn := getFunctionFromDomain("display",mml,[mmlrep])
;   SPADCALL(SPADCALL(expr,formatFn),displayFn)
;   TERPRI(get_texmacs_stream())
;   FORCE_-OUTPUT(get_texmacs_stream())
;   ioHook("endOfTeXmacsOutput")
;   NIL

(DEFUN |texmacsFormat| (|expr|)
  (PROG (|mml| |mmlrep| |formatFn| |displayFn|)
    (RETURN
     (PROGN
      (|ioHook| '|startTeXmacsOutput|)
      (SETQ |mml| '(|TexmacsFormat|))
      (SETQ |mmlrep| '(|String|))
      (SETQ |formatFn|
              (|getFunctionFromDomain| '|coerce| |mml| (LIST |$OutputForm|)))
      (SETQ |displayFn|
              (|getFunctionFromDomain| '|display| |mml| (LIST |mmlrep|)))
      (SPADCALL (SPADCALL |expr| |formatFn|) |displayFn|)
      (TERPRI (|get_texmacs_stream|))
      (FORCE-OUTPUT (|get_texmacs_stream|))
      (|ioHook| '|endOfTeXmacsOutput|)
      NIL))))

; htmlFormat expr ==
;   htf := '(HTMLFormat)
;   htrep := '(String)
;   formatFn := getFunctionFromDomain("coerce", htf, [$OutputForm])
;   displayFn := getFunctionFromDomain("display", htf, [htrep])
;   SPADCALL(SPADCALL(expr,formatFn),displayFn)
;   TERPRI(get_html_stream())
;   FORCE_-OUTPUT(get_html_stream())
;   NIL

(DEFUN |htmlFormat| (|expr|)
  (PROG (|htf| |htrep| |formatFn| |displayFn|)
    (RETURN
     (PROGN
      (SETQ |htf| '(|HTMLFormat|))
      (SETQ |htrep| '(|String|))
      (SETQ |formatFn|
              (|getFunctionFromDomain| '|coerce| |htf| (LIST |$OutputForm|)))
      (SETQ |displayFn|
              (|getFunctionFromDomain| '|display| |htf| (LIST |htrep|)))
      (SPADCALL (SPADCALL |expr| |formatFn|) |displayFn|)
      (TERPRI (|get_html_stream|))
      (FORCE-OUTPUT (|get_html_stream|))
      NIL))))

; formattedFormat expr ==
;   ty := '(FormattedOutput)
;   formatFn := getFunctionFromDomain("convert", ty, [$OutputForm, $Integer])
;   displayFn := getFunctionFromDomain("display", ty , [ty])
;   SPADCALL(SPADCALL(expr,$IOindex,formatFn),displayFn)
;   say_new_line(get_formatted_stream())
;   FORCE_-OUTPUT(get_formatted_stream())
;   NIL

(DEFUN |formattedFormat| (|expr|)
  (PROG (|ty| |formatFn| |displayFn|)
    (RETURN
     (PROGN
      (SETQ |ty| '(|FormattedOutput|))
      (SETQ |formatFn|
              (|getFunctionFromDomain| '|convert| |ty|
               (LIST |$OutputForm| |$Integer|)))
      (SETQ |displayFn| (|getFunctionFromDomain| '|display| |ty| (LIST |ty|)))
      (SPADCALL (SPADCALL |expr| |$IOindex| |formatFn|) |displayFn|)
      (|say_new_line| (|get_formatted_stream|))
      (FORCE-OUTPUT (|get_formatted_stream|))
      NIL))))

; output(expr,domain) ==
;   $resolve_level : local := 0
;   if isWrapped expr then expr := unwrap expr
;   isMapExpr expr and not(domain is ["FunctionCalled", .]) => BREAK()
;   categoryForm? domain or domain = ["Mode"] =>
;     if $algebraFormat then
;       mathprintWithNumber outputDomainConstructor expr
;     if $texFormat     then
;       texFormat outputDomainConstructor expr
;   T := coerceInteractive(objNewWrap(expr,domain),$OutputForm) =>
;     x := objValUnwrap T
;     if $fortranFormat then fortranFormat x
;     if $algebraFormat then
;       mathprintWithNumber x
;     if $texFormat     then texFormat x
;     if $mathmlFormat  then mathmlFormat x
;     if $texmacsFormat then texmacsFormat x
;     if $htmlFormat    then htmlFormat x
;     if $formattedFormat then formattedFormat x
;   (FUNCTIONP(opOf domain)) and (not(SYMBOLP(opOf domain))) and
;     (printfun := compiledLookup("<<",'(TextWriter TextWriter $), evalDomain domain))
;        and (textwrit := compiledLookup("print", '($), TextWriter())) =>
;      sayMSGNT [:bright '"Aldor",'"output:   "]
;      SPADCALL(SPADCALL textwrit, expr, printfun)
;      sayMSGNT '%l
;
;   -- big hack for tuples for new compiler
;   domain is ['Tuple, S] => output(asTupleAsList expr, ['List, S])
;
;   sayALGEBRA [:bright '"LISP",'"output:",'%l,expr or '"NIL"]

(DEFUN |output| (|expr| |domain|)
  (PROG (|$resolve_level| S |textwrit| |printfun| |x| T$ |ISTMP#1|)
    (DECLARE (SPECIAL |$resolve_level|))
    (RETURN
     (PROGN
      (SETQ |$resolve_level| 0)
      (COND ((|isWrapped| |expr|) (SETQ |expr| (|unwrap| |expr|))))
      (COND
       ((AND (|isMapExpr| |expr|)
             (NULL
              (AND (CONSP |domain|) (EQ (CAR |domain|) '|FunctionCalled|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |domain|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))))
        (BREAK))
       ((OR (|categoryForm?| |domain|) (EQUAL |domain| (LIST '|Mode|)))
        (PROGN
         (COND
          (|$algebraFormat|
           (|mathprintWithNumber| (|outputDomainConstructor| |expr|))))
         (COND
          (|$texFormat| (|texFormat| (|outputDomainConstructor| |expr|))))))
       ((SETQ T$
                (|coerceInteractive| (|objNewWrap| |expr| |domain|)
                 |$OutputForm|))
        (PROGN
         (SETQ |x| (|objValUnwrap| T$))
         (COND (|$fortranFormat| (|fortranFormat| |x|)))
         (COND (|$algebraFormat| (|mathprintWithNumber| |x|)))
         (COND (|$texFormat| (|texFormat| |x|)))
         (COND (|$mathmlFormat| (|mathmlFormat| |x|)))
         (COND (|$texmacsFormat| (|texmacsFormat| |x|)))
         (COND (|$htmlFormat| (|htmlFormat| |x|)))
         (COND (|$formattedFormat| (|formattedFormat| |x|)))))
       ((AND (FUNCTIONP (|opOf| |domain|)) (NULL (SYMBOLP (|opOf| |domain|)))
             (SETQ |printfun|
                     (|compiledLookup| '<< '(|TextWriter| |TextWriter| $)
                      (|evalDomain| |domain|)))
             (SETQ |textwrit| (|compiledLookup| '|print| '($) (|TextWriter|))))
        (PROGN
         (|sayMSGNT| (APPEND (|bright| "Aldor") (CONS "output:   " NIL)))
         (SPADCALL (SPADCALL |textwrit|) |expr| |printfun|)
         (|sayMSGNT| '|%l|)))
       ((AND (CONSP |domain|) (EQ (CAR |domain|) '|Tuple|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |domain|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ S (CAR |ISTMP#1|)) #1='T))))
        (|output| (|asTupleAsList| |expr|) (LIST '|List| S)))
       (#1#
        (|sayALGEBRA|
         (APPEND (|bright| "LISP")
                 (CONS "output:"
                       (CONS '|%l| (CONS (OR |expr| "NIL") NIL)))))))))))

; outputNumber(start,linelength,num) ==
;   if start > 1 then blnks := fillerSpaces(start-1,'" ")
;   else blnks := '""
;   under:='"__"
;   firsttime:=(linelength>3)
;   if linelength>2 then
;      linelength:=linelength-1
;   while SIZE(num) > linelength repeat
;     if $collectOutput then
;        $outputLines := [CONCAT(blnks, SUBSTRING(num,0,linelength),under),
;                         :$outputLines]
;     else
;       sayALGEBRA [blnks,
;                   SUBSTRING(num,0,linelength),under]
;     num := SUBSTRING(num,linelength,NIL)
;     if firsttime then
;          blnks:=CONCAT(blnks,'" ")
;          linelength:=linelength-1
;          firsttime:=NIL
;   if $collectOutput then
;     $outputLines := [CONCAT(blnks, num), :$outputLines]
;   else
;     sayALGEBRA [blnks, num]

(DEFUN |outputNumber| (|start| |linelength| |num|)
  (PROG (|blnks| |under| |firsttime|)
    (RETURN
     (PROGN
      (COND ((< 1 |start|) (SETQ |blnks| (|fillerSpaces| (- |start| 1) " ")))
            (#1='T (SETQ |blnks| "")))
      (SETQ |under| "_")
      (SETQ |firsttime| (< 3 |linelength|))
      (COND ((< 2 |linelength|) (SETQ |linelength| (- |linelength| 1))))
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (< |linelength| (SIZE |num|))) (RETURN NIL))
                (#1#
                 (PROGN
                  (COND
                   (|$collectOutput|
                    (SETQ |$outputLines|
                            (CONS
                             (CONCAT |blnks| (SUBSTRING |num| 0 |linelength|)
                                     |under|)
                             |$outputLines|)))
                   (#1#
                    (|sayALGEBRA|
                     (LIST |blnks| (SUBSTRING |num| 0 |linelength|) |under|))))
                  (SETQ |num| (SUBSTRING |num| |linelength| NIL))
                  (COND
                   (|firsttime| (SETQ |blnks| (CONCAT |blnks| " "))
                    (SETQ |linelength| (- |linelength| 1))
                    (SETQ |firsttime| NIL)))))))))
      (COND
       (|$collectOutput|
        (SETQ |$outputLines| (CONS (CONCAT |blnks| |num|) |$outputLines|)))
       (#1# (|sayALGEBRA| (LIST |blnks| |num|))))))))

; outputString(start,linelength,str) ==
;   if start > 1 then blnks := fillerSpaces(start-1,'" ")
;   else blnks := '""
;   while SIZE(str) > linelength repeat
;     if $collectOutput then
;        $outputLines := [CONCAT(blnks, SUBSTRING(str,0,linelength)),
;                         :$outputLines]
;     else
;       sayALGEBRA [blnks, SUBSTRING(str,0,linelength)]
;     str := SUBSTRING(str,linelength,NIL)
;   if $collectOutput then
;     $outputLines := [CONCAT(blnks, str), :$outputLines]
;   else
;     sayALGEBRA [blnks, str]

(DEFUN |outputString| (|start| |linelength| |str|)
  (PROG (|blnks|)
    (RETURN
     (PROGN
      (COND ((< 1 |start|) (SETQ |blnks| (|fillerSpaces| (- |start| 1) " ")))
            (#1='T (SETQ |blnks| "")))
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (< |linelength| (SIZE |str|))) (RETURN NIL))
                (#1#
                 (PROGN
                  (COND
                   (|$collectOutput|
                    (SETQ |$outputLines|
                            (CONS
                             (CONCAT |blnks| (SUBSTRING |str| 0 |linelength|))
                             |$outputLines|)))
                   (#1#
                    (|sayALGEBRA|
                     (LIST |blnks| (SUBSTRING |str| 0 |linelength|)))))
                  (SETQ |str| (SUBSTRING |str| |linelength| NIL))))))))
      (COND
       (|$collectOutput|
        (SETQ |$outputLines| (CONS (CONCAT |blnks| |str|) |$outputLines|)))
       (#1# (|sayALGEBRA| (LIST |blnks| |str|))))))))

; outputDomainConstructor form ==
;   if VECTORP form then form := devaluate form
;   atom (u:= prefix2String form) => u
;   concatenateStringList([object2String(x) for x in u])

(DEFUN |outputDomainConstructor| (|form|)
  (PROG (|u|)
    (RETURN
     (PROGN
      (COND ((VECTORP |form|) (SETQ |form| (|devaluate| |form|))))
      (COND ((ATOM (SETQ |u| (|prefix2String| |form|))) |u|)
            (#1='T
             (|concatenateStringList|
              ((LAMBDA (|bfVar#87| |bfVar#86| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#86|)
                        (PROGN (SETQ |x| (CAR |bfVar#86|)) NIL))
                    (RETURN (NREVERSE |bfVar#87|)))
                   (#1#
                    (SETQ |bfVar#87| (CONS (|object2String| |x|) |bfVar#87|))))
                  (SETQ |bfVar#86| (CDR |bfVar#86|))))
               NIL |u| NIL))))))))

; charybdis(u,start,linelength) ==
;   EQ(keyp u,'EQUATNUM) and not (CDDR u) =>
;     charybdis(['PAREN,u.1],start,linelength)
;   charyTop(u,start,linelength)

(DEFUN |charybdis| (|u| |start| |linelength|)
  (PROG ()
    (RETURN
     (COND
      ((AND (EQ (|keyp| |u|) 'EQUATNUM) (NULL (CDDR |u|)))
       (|charybdis| (LIST 'PAREN (ELT |u| 1)) |start| |linelength|))
      ('T (|charyTop| |u| |start| |linelength|))))))

; charyTop(u,start,linelength) ==
;   linelength < 1 =>
;       sayALGEBRA ['%l,'%b,'"  Too wide to Print",'%d]
;       THROW('output,nil)
;   u is ['SC,:l] or u is [['SC,:.],:l] =>
;     for a in l repeat charyTop(a,start,linelength)
;   u is [['CONCATB,:.],:m,[['SC,:.],:l]] =>
;     charyTop(['CONCATB,:m],start,linelength)
;     charyTop(['SC,:l],start+2,linelength-2)
;   u is ['CENTER,a] =>
;     b := charyTopWidth a
;     (w := WIDTH(b)) > linelength-start => charyTop(a,start,linelength)
;     charyTop(b, QUOTIENT(linelength-start-w, 2), linelength)
;   v := charyTopWidth u
;   EQ(keyp u,'ELSE) => charyElse(u,v,start,linelength)
;   WIDTH(v) > linelength => charyTrouble(u,v,start,linelength)
;   d := APP(v,start,0,nil)
;   n := superspan v
;   m := - subspan v
;   -- FIXME: should we collect output here?
;   until n < m repeat
;     scylla(n,d)
;     n := n - 1

(DEFUN |charyTop| (|u| |start| |linelength|)
  (PROG (|l| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4| |ISTMP#5| |m| |a| |b| |w|
         |v| |d| |n|)
    (RETURN
     (COND
      ((< |linelength| 1)
       (PROGN
        (|sayALGEBRA| (LIST '|%l| '|%b| "  Too wide to Print" '|%d|))
        (THROW '|output| NIL)))
      ((OR
        (AND (CONSP |u|) (EQ (CAR |u|) 'SC) (PROGN (SETQ |l| (CDR |u|)) #1='T))
        (AND (CONSP |u|)
             (PROGN
              (SETQ |ISTMP#1| (CAR |u|))
              (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SC)))
             (PROGN (SETQ |l| (CDR |u|)) #1#)))
       ((LAMBDA (|bfVar#88| |a|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#88|) (PROGN (SETQ |a| (CAR |bfVar#88|)) NIL))
             (RETURN NIL))
            (#1# (|charyTop| |a| |start| |linelength|)))
           (SETQ |bfVar#88| (CDR |bfVar#88|))))
        |l| NIL))
      ((AND (CONSP |u|)
            (PROGN
             (SETQ |ISTMP#1| (CAR |u|))
             (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'CONCATB)))
            (PROGN
             (SETQ |ISTMP#2| (CDR |u|))
             (AND (CONSP |ISTMP#2|)
                  (PROGN (SETQ |ISTMP#3| (REVERSE |ISTMP#2|)) #1#)
                  (CONSP |ISTMP#3|)
                  (PROGN
                   (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                   (AND (CONSP |ISTMP#4|)
                        (PROGN
                         (SETQ |ISTMP#5| (CAR |ISTMP#4|))
                         (AND (CONSP |ISTMP#5|) (EQ (CAR |ISTMP#5|) 'SC)))
                        (PROGN (SETQ |l| (CDR |ISTMP#4|)) #1#)))
                  (PROGN (SETQ |m| (CDR |ISTMP#3|)) #1#)
                  (PROGN (SETQ |m| (NREVERSE |m|)) #1#))))
       (PROGN
        (|charyTop| (CONS 'CONCATB |m|) |start| |linelength|)
        (|charyTop| (CONS 'SC |l|) (+ |start| 2) (- |linelength| 2))))
      ((AND (CONSP |u|) (EQ (CAR |u|) 'CENTER)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#))))
       (PROGN
        (SETQ |b| (|charyTopWidth| |a|))
        (COND
         ((< (- |linelength| |start|) (SETQ |w| (WIDTH |b|)))
          (|charyTop| |a| |start| |linelength|))
         (#1#
          (|charyTop| |b| (QUOTIENT (- (- |linelength| |start|) |w|) 2)
           |linelength|)))))
      (#1#
       (PROGN
        (SETQ |v| (|charyTopWidth| |u|))
        (COND
         ((EQ (|keyp| |u|) 'ELSE) (|charyElse| |u| |v| |start| |linelength|))
         ((< |linelength| (WIDTH |v|))
          (|charyTrouble| |u| |v| |start| |linelength|))
         (#1#
          (PROGN
           (SETQ |d| (APP |v| |start| 0 NIL))
           (SETQ |n| (|superspan| |v|))
           (SETQ |m| (- (|subspan| |v|)))
           ((LAMBDA (|bfVar#89|)
              (LOOP
               (COND (|bfVar#89| (RETURN NIL))
                     (#1# (PROGN (|scylla| |n| |d|) (SETQ |n| (- |n| 1)))))
               (SETQ |bfVar#89| (< |n| |m|))))
            NIL))))))))))

; charyTopWidth u ==
;     atom u => u
;     atom first u => putWidth u
;     NUMBERP CDAR u => u
;     putWidth u

(DEFUN |charyTopWidth| (|u|)
  (PROG ()
    (RETURN
     (COND ((ATOM |u|) |u|) ((ATOM (CAR |u|)) (|putWidth| |u|))
           ((NUMBERP (CDAR |u|)) |u|) ('T (|putWidth| |u|))))))

; charyTrouble(u,v,start,linelength) ==
;   LargeMatrixp(u,linelength,2*linelength) =>
;     u := SubstWhileDesizing(u)
;     maprinChk u
;   charyTrouble1(u,v,start,linelength)

(DEFUN |charyTrouble| (|u| |v| |start| |linelength|)
  (PROG ()
    (RETURN
     (COND
      ((|LargeMatrixp| |u| |linelength| (* 2 |linelength|))
       (PROGN (SETQ |u| (|SubstWhileDesizing| |u|)) (|maprinChk| |u|)))
      ('T (|charyTrouble1| |u| |v| |start| |linelength|))))))

; charyTrouble1(u,v,start,linelength) ==
;   NUMBERP u => outputNumber(start,linelength,atom2String u)
;   atom u => outputString(start,linelength,atom2String u)
;   EQ(x:= keyp u,'_-) => charyMinus(u,v,start,linelength)
;   MEMQ(x,'(_+ _* AGGLST)) => charySplit(u,v,start,linelength)
;   EQ(x,'EQUATNUM) => charyEquatnum(u,v,start,linelength)
;   d := GETL(x,'INFIXOP) => charyBinary(d,u,v,start,linelength)
;   x = 'OVER  =>
;     charyBinary(GETL("/",'INFIXOP),u,v,start,linelength)
;   EQ(3,LENGTH u) and GETL(x,'Led) =>
;     d:= PNAME first GETL(x,'Led)
;     charyBinary(d,u,v,start,linelength)
;   EQ(x,'CONCAT) =>
;     concatTrouble(rest v,d,start,linelength,nil)
;   EQ(x,'CONCATB) =>
;     (rest v) is [loop, 'repeat, body] =>
;       charyTop(['CONCATB,loop,'repeat],start,linelength)
;       charyTop(body,start+2,linelength-2)
;     (rest v) is [wu, loop, 'repeat, body] and
;       (keyp wu) is ['CONCATB,wu',.] and wu' in '(while until) =>
;         charyTop(['CONCATB,wu,loop,'repeat],start,linelength)
;         charyTop(body,start+2,linelength-2)
;     concatTrouble(rest v,d,start,linelength,true)
;   GETL(x,'INFIXOP) => charySplit(u,v,start,linelength)
;   EQ(x,'PAREN) and
;     (EQ(keyp u.1,'AGGLST) and (v:= ",") or EQ(keyp u.1,'AGGSET) and
;       (v:= ";")) => bracketagglist(rest u.1,start,linelength,v,"_(","_)")
;   EQ(x,'PAREN) and EQ(keyp u.1,'CONCATB) =>
;     bracketagglist(rest u.1,start,linelength," ","_(","_)")
;   EQ(x,'BRACKET) and (EQ(keyp u.1,'AGGLST) and (v:= ",")) =>
;     bracketagglist(rest u.1,start,linelength,v,
;                    specialChar 'lbrk, specialChar 'rbrk)
;   EQ(x,'BRACE) and (EQ(keyp u.1,'AGGLST) and (v:= ",")) =>
;     bracketagglist(rest u.1,start,linelength,v,
;                    specialChar 'lbrc, specialChar 'rbrc)
;   EQ(x,'EXT) => longext(u,start,linelength)
;   EQ(x,'MATRIX) => BREAK()
;   EQ(x,'ELSE) => charyElse(u,v,start,linelength)
;   EQ(x,'SC) => charySemiColon(u,v,start,linelength)
;   charybdis(x,start,linelength)
;   if rest u then charybdis(['ELSE,:rest u],start,linelength)

(DEFUN |charyTrouble1| (|u| |v| |start| |linelength|)
  (PROG (|x| |d| |ISTMP#1| |loop| |ISTMP#2| |ISTMP#3| |body| |wu| |ISTMP#4|
         |wu'|)
    (RETURN
     (COND
      ((NUMBERP |u|) (|outputNumber| |start| |linelength| (|atom2String| |u|)))
      ((ATOM |u|) (|outputString| |start| |linelength| (|atom2String| |u|)))
      ((EQ (SETQ |x| (|keyp| |u|)) '-)
       (|charyMinus| |u| |v| |start| |linelength|))
      ((MEMQ |x| '(+ * AGGLST)) (|charySplit| |u| |v| |start| |linelength|))
      ((EQ |x| 'EQUATNUM) (|charyEquatnum| |u| |v| |start| |linelength|))
      ((SETQ |d| (GETL |x| 'INFIXOP))
       (|charyBinary| |d| |u| |v| |start| |linelength|))
      ((EQ |x| 'OVER)
       (|charyBinary| (GETL '/ 'INFIXOP) |u| |v| |start| |linelength|))
      ((AND (EQ 3 (LENGTH |u|)) (GETL |x| '|Led|))
       (PROGN
        (SETQ |d| (PNAME (CAR (GETL |x| '|Led|))))
        (|charyBinary| |d| |u| |v| |start| |linelength|)))
      ((EQ |x| 'CONCAT)
       (|concatTrouble| (CDR |v|) |d| |start| |linelength| NIL))
      ((EQ |x| 'CONCATB)
       (COND
        ((PROGN
          (SETQ |ISTMP#1| (CDR |v|))
          (AND (CONSP |ISTMP#1|)
               (PROGN
                (SETQ |loop| (CAR |ISTMP#1|))
                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) 'REPEAT)
                     (PROGN
                      (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                      (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                           (PROGN (SETQ |body| (CAR |ISTMP#3|)) #1='T)))))))
         (PROGN
          (|charyTop| (LIST 'CONCATB |loop| 'REPEAT) |start| |linelength|)
          (|charyTop| |body| (+ |start| 2) (- |linelength| 2))))
        ((AND
          (PROGN
           (SETQ |ISTMP#1| (CDR |v|))
           (AND (CONSP |ISTMP#1|)
                (PROGN
                 (SETQ |wu| (CAR |ISTMP#1|))
                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                 (AND (CONSP |ISTMP#2|)
                      (PROGN
                       (SETQ |loop| (CAR |ISTMP#2|))
                       (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                       (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) 'REPEAT)
                            (PROGN
                             (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                             (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                  (PROGN
                                   (SETQ |body| (CAR |ISTMP#4|))
                                   #1#)))))))))
          (PROGN
           (SETQ |ISTMP#1| (|keyp| |wu|))
           (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'CONCATB)
                (PROGN
                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                 (AND (CONSP |ISTMP#2|)
                      (PROGN
                       (SETQ |wu'| (CAR |ISTMP#2|))
                       (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                       (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)))))))
          (|member| |wu'| '(WHILE UNTIL)))
         (PROGN
          (|charyTop| (LIST 'CONCATB |wu| |loop| 'REPEAT) |start| |linelength|)
          (|charyTop| |body| (+ |start| 2) (- |linelength| 2))))
        (#1# (|concatTrouble| (CDR |v|) |d| |start| |linelength| T))))
      ((GETL |x| 'INFIXOP) (|charySplit| |u| |v| |start| |linelength|))
      ((AND (EQ |x| 'PAREN)
            (OR (AND (EQ (|keyp| (ELT |u| 1)) 'AGGLST) (SETQ |v| '|,|))
                (AND (EQ (|keyp| (ELT |u| 1)) 'AGGSET) (SETQ |v| '|;|))))
       (|bracketagglist| (CDR (ELT |u| 1)) |start| |linelength| |v| '|(| '|)|))
      ((AND (EQ |x| 'PAREN) (EQ (|keyp| (ELT |u| 1)) 'CONCATB))
       (|bracketagglist| (CDR (ELT |u| 1)) |start| |linelength| '| | '|(|
        '|)|))
      ((AND (EQ |x| 'BRACKET) (EQ (|keyp| (ELT |u| 1)) 'AGGLST)
            (SETQ |v| '|,|))
       (|bracketagglist| (CDR (ELT |u| 1)) |start| |linelength| |v|
        (|specialChar| '|lbrk|) (|specialChar| '|rbrk|)))
      ((AND (EQ |x| 'BRACE) (EQ (|keyp| (ELT |u| 1)) 'AGGLST) (SETQ |v| '|,|))
       (|bracketagglist| (CDR (ELT |u| 1)) |start| |linelength| |v|
        (|specialChar| '|lbrc|) (|specialChar| '|rbrc|)))
      ((EQ |x| 'EXT) (|longext| |u| |start| |linelength|))
      ((EQ |x| 'MATRIX) (BREAK))
      ((EQ |x| 'ELSE) (|charyElse| |u| |v| |start| |linelength|))
      ((EQ |x| 'SC) (|charySemiColon| |u| |v| |start| |linelength|))
      (#1#
       (PROGN
        (|charybdis| |x| |start| |linelength|)
        (COND
         ((CDR |u|)
          (|charybdis| (CONS 'ELSE (CDR |u|)) |start| |linelength|)))))))))

; charySemiColon(u,v,start,linelength) ==
;   for a in rest u repeat
;     charyTop(a,start,linelength)
;   nil

(DEFUN |charySemiColon| (|u| |v| |start| |linelength|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#90| |a|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#90|) (PROGN (SETQ |a| (CAR |bfVar#90|)) NIL))
            (RETURN NIL))
           ('T (|charyTop| |a| |start| |linelength|)))
          (SETQ |bfVar#90| (CDR |bfVar#90|))))
       (CDR |u|) NIL)
      NIL))))

; charyMinus(u,v,start,linelength) ==
;   charybdis('"-",start,linelength)
;   charybdis(v.1,start+3,linelength-3)

(DEFUN |charyMinus| (|u| |v| |start| |linelength|)
  (PROG ()
    (RETURN
     (PROGN
      (|charybdis| "-" |start| |linelength|)
      (|charybdis| (ELT |v| 1) (+ |start| 3) (- |linelength| 3))))))

; charyBinary(d,u,v,start,linelength) ==
;   d in '(" := " "= ") =>
;     charybdis(['CONCATB,v.1,d],start,linelength)
;     charybdis(v.2,start+2,linelength-2)
;   charybdis(v.1,start+2,linelength-2)
;   if d then prnd(start,d)
;   charybdis(v.2,start+2,linelength-2)

(DEFUN |charyBinary| (|d| |u| |v| |start| |linelength|)
  (PROG ()
    (RETURN
     (COND
      ((|member| |d| '(" := " "= "))
       (PROGN
        (|charybdis| (LIST 'CONCATB (ELT |v| 1) |d|) |start| |linelength|)
        (|charybdis| (ELT |v| 2) (+ |start| 2) (- |linelength| 2))))
      ('T
       (PROGN
        (|charybdis| (ELT |v| 1) (+ |start| 2) (- |linelength| 2))
        (COND (|d| (|prnd| |start| |d|)))
        (|charybdis| (ELT |v| 2) (+ |start| 2) (- |linelength| 2))))))))

; charyEquatnum(u,v,start,linelength) ==
;   charybdis(['PAREN,u.1],start,linelength)
;   charybdis(u.2,start,linelength)

(DEFUN |charyEquatnum| (|u| |v| |start| |linelength|)
  (PROG ()
    (RETURN
     (PROGN
      (|charybdis| (LIST 'PAREN (ELT |u| 1)) |start| |linelength|)
      (|charybdis| (ELT |u| 2) |start| |linelength|)))))

; charySplit(u,v,start,linelength) ==
;   v:= [first v.0,:rest v]
;   m:= rest v
;   WIDTH v.1 > linelength-2 =>
;     charybdis(v.1,start+2,linelength-2)
;     not (CDDR v) => '" "
;     dm:= CDDR v
;     ddm:= rest dm
;     split2(u,dm,ddm,start,linelength)
;   for i in 0.. repeat
;     dm := rest m
;     ddm := rest dm
;     RPLACD(dm,nil)
;     WIDTH v > linelength - 2 => return nil
;     rplac(first v, first v.0)
;     RPLACD(dm,ddm)
;     m := rest m
;   rplac(first v, first v.0)
;   RPLACD(m,nil)
;   charybdis(v,start + 2,linelength - 2)
;   split2(u,dm,ddm,start,linelength)

(DEFUN |charySplit| (|u| |v| |start| |linelength|)
  (PROG (|m| |dm| |ddm|)
    (RETURN
     (PROGN
      (SETQ |v| (CONS (CAR (ELT |v| 0)) (CDR |v|)))
      (SETQ |m| (CDR |v|))
      (COND
       ((< (- |linelength| 2) (WIDTH (ELT |v| 1)))
        (PROGN
         (|charybdis| (ELT |v| 1) (+ |start| 2) (- |linelength| 2))
         (COND ((NULL (CDDR |v|)) " ")
               (#1='T
                (PROGN
                 (SETQ |dm| (CDDR |v|))
                 (SETQ |ddm| (CDR |dm|))
                 (|split2| |u| |dm| |ddm| |start| |linelength|))))))
       (#1#
        (PROGN
         ((LAMBDA (|i|)
            (LOOP
             (COND (NIL (RETURN NIL))
                   (#1#
                    (PROGN
                     (SETQ |dm| (CDR |m|))
                     (SETQ |ddm| (CDR |dm|))
                     (RPLACD |dm| NIL)
                     (COND ((< (- |linelength| 2) (WIDTH |v|)) (RETURN NIL))
                           (#1#
                            (PROGN
                             (|rplac| (CAR |v|) (CAR (ELT |v| 0)))
                             (RPLACD |dm| |ddm|)
                             (SETQ |m| (CDR |m|))))))))
             (SETQ |i| (+ |i| 1))))
          0)
         (|rplac| (CAR |v|) (CAR (ELT |v| 0)))
         (RPLACD |m| NIL)
         (|charybdis| |v| (+ |start| 2) (- |linelength| 2))
         (|split2| |u| |dm| |ddm| |start| |linelength|))))))))

; split2(u,dm,ddm,start,linelength) ==
;   prnd(start,(d:= GETL(keyp u,'INFIXOP) => d; '","))
;   RPLACD(dm,ddm)
;   m:= WIDTH [keyp u,:dm]<linelength-2
;   charybdis([keyp u,:dm],(m => start+2; start),(m => linelength-2; linelength))

(DEFUN |split2| (|u| |dm| |ddm| |start| |linelength|)
  (PROG (|d| |m|)
    (RETURN
     (PROGN
      (|prnd| |start|
       (COND ((SETQ |d| (GETL (|keyp| |u|) 'INFIXOP)) |d|) (#1='T ",")))
      (RPLACD |dm| |ddm|)
      (SETQ |m| (< (WIDTH (CONS (|keyp| |u|) |dm|)) (- |linelength| 2)))
      (|charybdis| (CONS (|keyp| |u|) |dm|)
       (COND (|m| (+ |start| 2)) (#1# |start|))
       (COND (|m| (- |linelength| 2)) (#1# |linelength|)))))))

; charyElse(u,v,start,linelength) ==
;   charybdis(v.1,start+3,linelength-3)
;   not (CDDR u) => '" "
;   prnd(start,'",")
;   charybdis(['ELSE,:CDDR v],start,linelength)

(DEFUN |charyElse| (|u| |v| |start| |linelength|)
  (PROG ()
    (RETURN
     (PROGN
      (|charybdis| (ELT |v| 1) (+ |start| 3) (- |linelength| 3))
      (COND ((NULL (CDDR |u|)) " ")
            ('T
             (PROGN
              (|prnd| |start| ",")
              (|charybdis| (CONS 'ELSE (CDDR |v|)) |start| |linelength|))))))))

; scylla(n,v) ==
;   y := LASSOC(n,v)
;   null y => nil
;   if STRINGP(y) then y := DROPTRAILINGBLANKS COPY y
;   if $collectOutput then
;     $outputLines := [y, :$outputLines]
;   else
;     PRINTEXP(y, get_algebra_stream())
;     TERPRI(get_algebra_stream())
;   nil

(DEFUN |scylla| (|n| |v|)
  (PROG (|y|)
    (RETURN
     (PROGN
      (SETQ |y| (LASSOC |n| |v|))
      (COND ((NULL |y|) NIL)
            (#1='T
             (PROGN
              (COND ((STRINGP |y|) (SETQ |y| (DROPTRAILINGBLANKS (COPY |y|)))))
              (COND
               (|$collectOutput|
                (SETQ |$outputLines| (CONS |y| |$outputLines|)))
               (#1# (PRINTEXP |y| (|get_algebra_stream|))
                (TERPRI (|get_algebra_stream|))))
              NIL)))))))

; keyp(u) ==
;   atom u => nil
;   atom first u => first u
;   CAAR u

(DEFUN |keyp| (|u|)
  (PROG ()
    (RETURN
     (COND ((ATOM |u|) NIL) ((ATOM (CAR |u|)) (CAR |u|)) ('T (CAAR |u|))))))

; absym x ==
;   (NUMBERP x) and (MINUSP x) => -x
;   not (atom x) and (keyp(x) = '_-) => CADR x
;   x

(DEFUN |absym| (|x|)
  (PROG ()
    (RETURN
     (COND ((AND (NUMBERP |x|) (MINUSP |x|)) (- |x|))
           ((AND (NULL (ATOM |x|)) (EQ (|keyp| |x|) '-)) (CADR |x|))
           ('T |x|)))))

; agg(n,u) ==
;   (n = 1) => CADR u
;   agg(n - 1, rest u)

(DEFUN |agg| (|n| |u|)
  (PROG ()
    (RETURN (COND ((EQL |n| 1) (CADR |u|)) ('T (|agg| (- |n| 1) (CDR |u|)))))))

; aggwidth u ==
;   null u => 0
;   null rest u => WIDTH first u
;   1 + (WIDTH first u) + (aggwidth rest u)

(DEFUN |aggwidth| (|u|)
  (PROG ()
    (RETURN
     (COND ((NULL |u|) 0) ((NULL (CDR |u|)) (WIDTH (CAR |u|)))
           ('T (+ (+ 1 (WIDTH (CAR |u|))) (|aggwidth| (CDR |u|))))))))

; argsapp(u,x,y,d) == appargs(rest u,x,y,d)

(DEFUN |argsapp| (|u| |x| |y| |d|)
  (PROG () (RETURN (|appargs| (CDR |u|) |x| |y| |d|))))

; subspan u ==
;   atom u => 0
;   NUMBERP rest u => subspan first u
;   (not atom first u             and_
;    atom CAAR u           and_
;    not NUMBERP CAAR u    and_
;    GETL(CAAR u, 'SUBSPAN)    )    =>
;    APPLY(GETL(CAAR u, 'SUBSPAN), LIST u)
;   MAX(subspan first u, subspan rest u)

(DEFUN |subspan| (|u|)
  (PROG ()
    (RETURN
     (COND ((ATOM |u|) 0) ((NUMBERP (CDR |u|)) (|subspan| (CAR |u|)))
           ((AND (NULL (ATOM (CAR |u|))) (ATOM (CAAR |u|))
                 (NULL (NUMBERP (CAAR |u|))) (GETL (CAAR |u|) 'SUBSPAN))
            (APPLY (GETL (CAAR |u|) 'SUBSPAN) (LIST |u|)))
           ('T (MAX (|subspan| (CAR |u|)) (|subspan| (CDR |u|))))))))

; agggsub u == subspan rest u

(DEFUN |agggsub| (|u|) (PROG () (RETURN (|subspan| (CDR |u|)))))

; superspan u ==
;   atom u => 0
;   NUMBERP rest u => superspan first u
;   (not atom first u               and_
;    atom CAAR u             and_
;    not NUMBERP CAAR u      and_
;    GETL(CAAR u, 'SUPERSPAN)    )    =>
;    APPLY(GETL(CAAR u, 'SUPERSPAN), LIST u)
;   MAX(superspan first u, superspan rest u)

(DEFUN |superspan| (|u|)
  (PROG ()
    (RETURN
     (COND ((ATOM |u|) 0) ((NUMBERP (CDR |u|)) (|superspan| (CAR |u|)))
           ((AND (NULL (ATOM (CAR |u|))) (ATOM (CAAR |u|))
                 (NULL (NUMBERP (CAAR |u|))) (GETL (CAAR |u|) 'SUPERSPAN))
            (APPLY (GETL (CAAR |u|) 'SUPERSPAN) (LIST |u|)))
           ('T (MAX (|superspan| (CAR |u|)) (|superspan| (CDR |u|))))))))

; agggsuper u == superspan rest u

(DEFUN |agggsuper| (|u|) (PROG () (RETURN (|superspan| (CDR |u|)))))

; agggwidth u == aggwidth rest u

(DEFUN |agggwidth| (|u|) (PROG () (RETURN (|aggwidth| (CDR |u|)))))

; appagg(u,x,y,d) == agg_app(u, x, y, d, '",", 1)

(DEFUN |appagg| (|u| |x| |y| |d|)
  (PROG () (RETURN (|agg_app| |u| |x| |y| |d| "," 1))))

; appargs(u, x, y, d) == agg_app(u, x, y, d, '";", 1)

(DEFUN |appargs| (|u| |x| |y| |d|)
  (PROG () (RETURN (|agg_app| |u| |x| |y| |d| ";" 1))))

; apprpar(x, y, y1, y2, d) ==
;   (not ($tallPar) or (y2 - y1 < 2)) => APP('")", x, y, d)
;   true => APP('")", x, y2, apprpar1(x, y, y1, y2 - 1, d))

(DEFUN |apprpar| (|x| |y| |y1| |y2| |d|)
  (PROG ()
    (RETURN
     (COND ((OR (NULL |$tallPar|) (< (- |y2| |y1|) 2)) (APP ")" |x| |y| |d|))
           (T (APP ")" |x| |y2| (|apprpar1| |x| |y| |y1| (- |y2| 1) |d|)))))))

; apprpar1(x, y, y1, y2, d) ==
;   (y1 = y2) => APP('")", x, y2, d)
;   true => APP('")", x, y2, apprpar1(x, y, y1, y2 - 1, d))

(DEFUN |apprpar1| (|x| |y| |y1| |y2| |d|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |y1| |y2|) (APP ")" |x| |y2| |d|))
           (T (APP ")" |x| |y2| (|apprpar1| |x| |y| |y1| (- |y2| 1) |d|)))))))

; applpar(x, y, y1, y2, d) ==
;   (not ($tallPar) or (y2 - y1 < 2)) => APP('"(", x, y, d)
;   true => APP('"(", x, y2, applpar1(x, y, y1, y2 - 1, d))

(DEFUN |applpar| (|x| |y| |y1| |y2| |d|)
  (PROG ()
    (RETURN
     (COND ((OR (NULL |$tallPar|) (< (- |y2| |y1|) 2)) (APP "(" |x| |y| |d|))
           (T (APP "(" |x| |y2| (|applpar1| |x| |y| |y1| (- |y2| 1) |d|)))))))

; applpar1(x, y, y1, y2, d) ==
;   (y1 = y2) => APP('"(", x, y2, d)
;   true => APP('"(", x, y2, applpar1(x, y, y1, y2 - 1, d))

(DEFUN |applpar1| (|x| |y| |y1| |y2| |d|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |y1| |y2|) (APP "(" |x| |y2| |d|))
           (T (APP "(" |x| |y2| (|applpar1| |x| |y| |y1| (- |y2| 1) |d|)))))))

; appelse(u,x,y,d) ==
;   w := WIDTH CAAR u
;   b := y - subspan rest u
;   p := y + superspan rest u
;   temparg1 := APP(keyp u, x, y, d)
;   temparg2 := applpar(x + w, y, b, p, temparg1)
;   temparg3 := appagg(rest u, x + 1 + w, y, temparg2)
;   apprpar(x + 1 + w + aggwidth rest u, y, b, p, temparg3)

(DEFUN |appelse| (|u| |x| |y| |d|)
  (PROG (|w| |b| |p| |temparg1| |temparg2| |temparg3|)
    (RETURN
     (PROGN
      (SETQ |w| (WIDTH (CAAR |u|)))
      (SETQ |b| (- |y| (|subspan| (CDR |u|))))
      (SETQ |p| (+ |y| (|superspan| (CDR |u|))))
      (SETQ |temparg1| (APP (|keyp| |u|) |x| |y| |d|))
      (SETQ |temparg2| (|applpar| (+ |x| |w|) |y| |b| |p| |temparg1|))
      (SETQ |temparg3| (|appagg| (CDR |u|) (+ (+ |x| 1) |w|) |y| |temparg2|))
      (|apprpar| (+ (+ (+ |x| 1) |w|) (|aggwidth| (CDR |u|))) |y| |b| |p|
       |temparg3|)))))

; appext(u,x,y,d) ==
;   xptr := x
;   yptr := y - (subspan CADR u + superspan agg(3,u) + 1)
;   d := APP(CADR u,x,y,d)
;   d := APP(agg(2,u),xptr,yptr,d)
;   xptr := xptr + WIDTH agg(2,u)
;   d := APP('"=", xptr, yptr,d)
;   d := APP(agg(3,u), 1 + xptr, yptr, d)
;   yptr := y + 1 + superspan CADR u + SUBSPAD agg(4,u)
;   d := APP(agg(4,u), x, yptr, d)
;   temp := 1 + WIDTH agg(2,u) +  WIDTH agg(3,u)
;   n := MAX(WIDTH CADR u, WIDTH agg(4,u), temp)
;   if EQCAR(first(z := agg(5,u)), 'EXT) and
;    (EQ(n,3) or (n > 3 and not (atom z)) ) then
;      n := 1 + n
;   d := APP(z, x + n, y, d)

(DEFUN |appext| (|u| |x| |y| |d|)
  (PROG (|xptr| |yptr| |temp| |n| |z|)
    (RETURN
     (PROGN
      (SETQ |xptr| |x|)
      (SETQ |yptr|
              (- |y|
                 (+ (+ (|subspan| (CADR |u|)) (|superspan| (|agg| 3 |u|))) 1)))
      (SETQ |d| (APP (CADR |u|) |x| |y| |d|))
      (SETQ |d| (APP (|agg| 2 |u|) |xptr| |yptr| |d|))
      (SETQ |xptr| (+ |xptr| (WIDTH (|agg| 2 |u|))))
      (SETQ |d| (APP "=" |xptr| |yptr| |d|))
      (SETQ |d| (APP (|agg| 3 |u|) (+ 1 |xptr|) |yptr| |d|))
      (SETQ |yptr|
              (+ (+ (+ |y| 1) (|superspan| (CADR |u|)))
                 (SUBSPAD (|agg| 4 |u|))))
      (SETQ |d| (APP (|agg| 4 |u|) |x| |yptr| |d|))
      (SETQ |temp| (+ (+ 1 (WIDTH (|agg| 2 |u|))) (WIDTH (|agg| 3 |u|))))
      (SETQ |n| (MAX (WIDTH (CADR |u|)) (WIDTH (|agg| 4 |u|)) |temp|))
      (COND
       ((AND (EQCAR (CAR (SETQ |z| (|agg| 5 |u|))) 'EXT)
             (OR (EQ |n| 3) (AND (< 3 |n|) (NULL (ATOM |z|)))))
        (SETQ |n| (+ 1 |n|))))
      (SETQ |d| (APP |z| (+ |x| |n|) |y| |d|))))))

; apphor(x1,x2,y,d,char) ==
;   temp := (x1 = x2 => d; apphor(x1, x2 - 1, y, d,char))
;   APP(char, x2, y, temp)

(DEFUN |apphor| (|x1| |x2| |y| |d| |char|)
  (PROG (|temp|)
    (RETURN
     (PROGN
      (SETQ |temp|
              (COND ((EQUAL |x1| |x2|) |d|)
                    ('T (|apphor| |x1| (- |x2| 1) |y| |d| |char|))))
      (APP |char| |x2| |y| |temp|)))))

; syminusp x ==
;   NUMBERP x => MINUSP x
;   not (atom x) and EQ(keyp x,'_-)

(DEFUN |syminusp| (|x|)
  (PROG ()
    (RETURN
     (COND ((NUMBERP |x|) (MINUSP |x|))
           ('T (AND (NULL (ATOM |x|)) (EQ (|keyp| |x|) '-)))))))

; appsum(u, x, y, d) ==
;   null u => d
;   ac := absym first u
;   sc :=
;     syminusp first u => '"-"
;     true => '"+"
;   dp := member(keyp ac, '(_+ _-))
;   tempx := x + WIDTH ac + (dp => 5; true => 3)
;   tempdblock :=
;     temparg1 := APP(sc, x + 1, y, d)
;     dp =>
;       bot := y - subspan ac
;       top := y + superspan ac
;       temparg2 := applpar(x + 3, y, bot, top, temparg1)
;       temparg3 := APP(ac, x + 4, y, temparg2)
;       apprpar(x + 4 + WIDTH ac, y, bot, top, temparg3)
;     true => APP(ac, x + 3, y, temparg1)
;   appsum(rest u, tempx, y, tempdblock)

(DEFUN |appsum| (|u| |x| |y| |d|)
  (PROG (|ac| |sc| |dp| |tempx| |temparg1| |bot| |top| |temparg2| |temparg3|
         |tempdblock|)
    (RETURN
     (COND ((NULL |u|) |d|)
           ('T
            (PROGN
             (SETQ |ac| (|absym| (CAR |u|)))
             (SETQ |sc| (COND ((|syminusp| (CAR |u|)) "-") (T "+")))
             (SETQ |dp| (|member| (|keyp| |ac|) '(+ -)))
             (SETQ |tempx| (+ (+ |x| (WIDTH |ac|)) (COND (|dp| 5) (T 3))))
             (SETQ |tempdblock|
                     (PROGN
                      (SETQ |temparg1| (APP |sc| (+ |x| 1) |y| |d|))
                      (COND
                       (|dp|
                        (PROGN
                         (SETQ |bot| (- |y| (|subspan| |ac|)))
                         (SETQ |top| (+ |y| (|superspan| |ac|)))
                         (SETQ |temparg2|
                                 (|applpar| (+ |x| 3) |y| |bot| |top|
                                  |temparg1|))
                         (SETQ |temparg3| (APP |ac| (+ |x| 4) |y| |temparg2|))
                         (|apprpar| (+ (+ |x| 4) (WIDTH |ac|)) |y| |bot| |top|
                          |temparg3|)))
                       (T (APP |ac| (+ |x| 3) |y| |temparg1|)))))
             (|appsum| (CDR |u|) |tempx| |y| |tempdblock|)))))))

; appneg(u, x, y, d) ==
;   appsum(LIST u, x - 1, y, d)

(DEFUN |appneg| (|u| |x| |y| |d|)
  (PROG () (RETURN (|appsum| (LIST |u|) (- |x| 1) |y| |d|))))

; appparu(u, x, y, d) ==
;   bot := y - subspan u
;   top := y + superspan u
;   temparg1 := applpar(x, y, bot, top, d)
;   temparg2 := APP(u, x + 1, y, temparg1)
;   apprpar(x + 1 + WIDTH u, y, bot, top, temparg2)

(DEFUN |appparu| (|u| |x| |y| |d|)
  (PROG (|bot| |top| |temparg1| |temparg2|)
    (RETURN
     (PROGN
      (SETQ |bot| (- |y| (|subspan| |u|)))
      (SETQ |top| (+ |y| (|superspan| |u|)))
      (SETQ |temparg1| (|applpar| |x| |y| |bot| |top| |d|))
      (SETQ |temparg2| (APP |u| (+ |x| 1) |y| |temparg1|))
      (|apprpar| (+ (+ |x| 1) (WIDTH |u|)) |y| |bot| |top| |temparg2|)))))

; appparu1(u, x, y, d) ==
;   appparu(CADR u, x, y, d)

(DEFUN |appparu1| (|u| |x| |y| |d|)
  (PROG () (RETURN (|appparu| (CADR |u|) |x| |y| |d|))))

; appsc(u, x, y, d) ==
;   appagg1(rest u, x, y, d, '";")

(DEFUN |appsc| (|u| |x| |y| |d|)
  (PROG () (RETURN (|appagg1| (CDR |u|) |x| |y| |d| ";"))))

; appsetq(u, x, y, d) ==
;   w := WIDTH first u
;   temparg1 := APP(CADR u, x, y, d)
;   temparg2 := APP('":", x + w, y, temparg1)
;   APP(CADR rest u, x + 2 + w, y, temparg2)

(DEFUN |appsetq| (|u| |x| |y| |d|)
  (PROG (|w| |temparg1| |temparg2|)
    (RETURN
     (PROGN
      (SETQ |w| (WIDTH (CAR |u|)))
      (SETQ |temparg1| (APP (CADR |u|) |x| |y| |d|))
      (SETQ |temparg2| (APP ":" (+ |x| |w|) |y| |temparg1|))
      (APP (CADR (CDR |u|)) (+ (+ |x| 2) |w|) |y| |temparg2|)))))

; appsub(u, x, y, d) ==
;   temparg1 := x + WIDTH CADR u
;   temparg2 := y - 1 - superspan CDDR u
;   temparg3 := APP(CADR u, x, y, d)
;   appagg(CDDR u, temparg1, temparg2, temparg3)

(DEFUN |appsub| (|u| |x| |y| |d|)
  (PROG (|temparg1| |temparg2| |temparg3|)
    (RETURN
     (PROGN
      (SETQ |temparg1| (+ |x| (WIDTH (CADR |u|))))
      (SETQ |temparg2| (- (- |y| 1) (|superspan| (CDDR |u|))))
      (SETQ |temparg3| (APP (CADR |u|) |x| |y| |d|))
      (|appagg| (CDDR |u|) |temparg1| |temparg2| |temparg3|)))))

; eq0(u) == 0

(DEFUN |eq0| (|u|) (PROG () (RETURN 0)))

; height(u) ==
;   superspan(u) + 1 + subspan(u)

(DEFUN |height| (|u|)
  (PROG () (RETURN (+ (+ (|superspan| |u|) 1) (|subspan| |u|)))))

; extsub(u) ==
;   MAX(subspan agg(5, u), height(agg(3, u)), subspan CADR u  )

(DEFUN |extsub| (|u|)
  (PROG ()
    (RETURN
     (MAX (|subspan| (|agg| 5 |u|)) (|height| (|agg| 3 |u|))
          (|subspan| (CADR |u|))))))

; extsuper(u) ==
;   MAX(superspan CADR u + height agg(4, u), superspan agg(5, u) )

(DEFUN |extsuper| (|u|)
  (PROG ()
    (RETURN
     (MAX (+ (|superspan| (CADR |u|)) (|height| (|agg| 4 |u|)))
          (|superspan| (|agg| 5 |u|))))))

; extwidth(u) ==
;   n := MAX(WIDTH CADR u,
;            WIDTH agg(4, u),
;            1 + WIDTH agg(2, u) + WIDTH agg(3, u) )
;   nil or
;          (EQCAR(first(z := agg(5, u)), 'EXT) and _
;           (EQ(n, 3) or ((n > 3) and null atom z) )  =>
;           n := 1 + n)
;   true => n + WIDTH agg(5, u)

(DEFUN |extwidth| (|u|)
  (PROG (|n| |z|)
    (RETURN
     (PROGN
      (SETQ |n|
              (MAX (WIDTH (CADR |u|)) (WIDTH (|agg| 4 |u|))
                   (+ (+ 1 (WIDTH (|agg| 2 |u|))) (WIDTH (|agg| 3 |u|)))))
      (OR NIL
          (COND
           ((AND (EQCAR (CAR (SETQ |z| (|agg| 5 |u|))) 'EXT)
                 (OR (EQ |n| 3) (AND (< 3 |n|) (NULL (ATOM |z|)))))
            (IDENTITY (SETQ |n| (+ 1 |n|))))))
      (COND (T (+ |n| (WIDTH (|agg| 5 |u|)))))))))

; appfrac(u, x, y, d) ==
;   -- Added "1+" to both QUOTIENT statements so that when exact centering is
;   -- not possible, expressions are offset to the right rather than left.
;   -- MCD 16-8-95
;   w := WIDTH u
;   tempx := x + QUOTIENT(1+w - WIDTH CADR rest u, 2)
;   tempy := y - superspan CADR rest u - 1
;   temparg3 := APP(CADR rest u, tempx, tempy, d)
;   temparg4 := apphor(x, x + w - 1, y, temparg3,specialChar('hbar))
;   APP(CADR u,
;         x + QUOTIENT(1+w - WIDTH CADR u, 2),
;           y + 1 + subspan CADR u,
;             temparg4)

(DEFUN |appfrac| (|u| |x| |y| |d|)
  (PROG (|w| |tempx| |tempy| |temparg3| |temparg4|)
    (RETURN
     (PROGN
      (SETQ |w| (WIDTH |u|))
      (SETQ |tempx|
              (+ |x| (QUOTIENT (- (+ 1 |w|) (WIDTH (CADR (CDR |u|)))) 2)))
      (SETQ |tempy| (- (- |y| (|superspan| (CADR (CDR |u|)))) 1))
      (SETQ |temparg3| (APP (CADR (CDR |u|)) |tempx| |tempy| |d|))
      (SETQ |temparg4|
              (|apphor| |x| (- (+ |x| |w|) 1) |y| |temparg3|
               (|specialChar| '|hbar|)))
      (APP (CADR |u|) (+ |x| (QUOTIENT (- (+ 1 |w|) (WIDTH (CADR |u|))) 2))
       (+ (+ |y| 1) (|subspan| (CADR |u|))) |temparg4|)))))

; fracsub(u) == height CADR rest u

(DEFUN |fracsub| (|u|) (PROG () (RETURN (|height| (CADR (CDR |u|))))))

; fracsuper(u) == height CADR u

(DEFUN |fracsuper| (|u|) (PROG () (RETURN (|height| (CADR |u|)))))

; fracwidth(u) ==
;   numw := WIDTH (num := CADR u)
;   denw := WIDTH (den := CADDR u)
;   if num is [[op,:.],:.] and op = 'OVER then numw := numw + 2
;   if den is [[op,:.],:.] and op = 'OVER then denw := denw + 2
;   MAX(numw,denw)

(DEFUN |fracwidth| (|u|)
  (PROG (|num| |numw| |den| |denw| |ISTMP#1| |op|)
    (RETURN
     (PROGN
      (SETQ |numw| (WIDTH (SETQ |num| (CADR |u|))))
      (SETQ |denw| (WIDTH (SETQ |den| (CADDR |u|))))
      (COND
       ((AND (CONSP |num|)
             (PROGN
              (SETQ |ISTMP#1| (CAR |num|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN (SETQ |op| (CAR |ISTMP#1|)) #1='T)))
             (EQ |op| 'OVER))
        (SETQ |numw| (+ |numw| 2))))
      (COND
       ((AND (CONSP |den|)
             (PROGN
              (SETQ |ISTMP#1| (CAR |den|))
              (AND (CONSP |ISTMP#1|) (PROGN (SETQ |op| (CAR |ISTMP#1|)) #1#)))
             (EQ |op| 'OVER))
        (SETQ |denw| (+ |denw| 2))))
      (MAX |numw| |denw|)))))

; slashSub u ==
;   MAX(1,subspan(CADR u),subspan(CADR rest u))

(DEFUN |slashSub| (|u|)
  (PROG ()
    (RETURN (MAX 1 (|subspan| (CADR |u|)) (|subspan| (CADR (CDR |u|)))))))

; slashSuper u ==
;   MAX(1,superspan(CADR u),superspan(CADR rest u))

(DEFUN |slashSuper| (|u|)
  (PROG ()
    (RETURN (MAX 1 (|superspan| (CADR |u|)) (|superspan| (CADR (CDR |u|)))))))

; slashApp(u, x, y, d) ==
;   -- to print things as a/b as opposed to
;   --      a
;   --      -
;   --      b
;   temparg1 := APP(CADR u, x, y, d)
;   temparg2 := APP('"/", x + WIDTH CADR u, y, temparg1)
;   APP(CADR rest u,
;      x + 1 + WIDTH CADR u, y, temparg2)

(DEFUN |slashApp| (|u| |x| |y| |d|)
  (PROG (|temparg1| |temparg2|)
    (RETURN
     (PROGN
      (SETQ |temparg1| (APP (CADR |u|) |x| |y| |d|))
      (SETQ |temparg2| (APP "/" (+ |x| (WIDTH (CADR |u|))) |y| |temparg1|))
      (APP (CADR (CDR |u|)) (+ (+ |x| 1) (WIDTH (CADR |u|))) |y| |temparg2|)))))

; slashWidth(u) ==
;   -- to print things as a/b as opposed to
;   --      a
;   --      -
;   --      b
;   1 + WIDTH CADR u + WIDTH CADR rest u

(DEFUN |slashWidth| (|u|)
  (PROG () (RETURN (+ (+ 1 (WIDTH (CADR |u|))) (WIDTH (CADR (CDR |u|)))))))

; longext(u, i, n) ==
;   x := REVERSE u
;   y := first x
;   u := remWidth(REVERSEWOC(CONS('" ", rest x)))
;   charybdis(u, i, n)
;   if not $collectOutput then TERPRI(get_algebra_stream())
;   charybdis(CONS('ELSE, LIST y), i, n)
;   '" "

(DEFUN |longext| (|u| |i| |n|)
  (PROG (|x| |y|)
    (RETURN
     (PROGN
      (SETQ |x| (REVERSE |u|))
      (SETQ |y| (CAR |x|))
      (SETQ |u| (|remWidth| (REVERSEWOC (CONS " " (CDR |x|)))))
      (|charybdis| |u| |i| |n|)
      (COND ((NULL |$collectOutput|) (TERPRI (|get_algebra_stream|))))
      (|charybdis| (CONS 'ELSE (LIST |y|)) |i| |n|)
      " "))))

; appvertline(char, x, yl, yu, d) ==
;   yu < yl => d
;   temparg :=  appvertline(char, x, yl, yu - 1, d)
;   true => APP(char, x, yu, temparg)

(DEFUN |appvertline| (|char| |x| |yl| |yu| |d|)
  (PROG (|temparg|)
    (RETURN
     (COND ((< |yu| |yl|) |d|)
           ('T
            (PROGN
             (SETQ |temparg| (|appvertline| |char| |x| |yl| (- |yu| 1) |d|))
             (COND (T (APP |char| |x| |yu| |temparg|)))))))))

; appHorizLine(xl, xu, y, d) ==
;   xu < xl => d
;   temparg :=  appHorizLine(xl, xu - 1, y, d)
;   true => APP(MATBORCH, xu, y, temparg)

(DEFUN |appHorizLine| (|xl| |xu| |y| |d|)
  (PROG (|temparg|)
    (RETURN
     (COND ((< |xu| |xl|) |d|)
           ('T
            (PROGN
             (SETQ |temparg| (|appHorizLine| |xl| (- |xu| 1) |y| |d|))
             (COND (T (APP MATBORCH |xu| |y| |temparg|)))))))))

; rootApp(u, x, y, d) ==
;   widB := WIDTH u.1
;   supB := superspan u.1
;   subB := subspan u.1
;   if #u > 2 then
;     widR := WIDTH u.2
;     subR := subspan u.2
;     d    := APP(u.2,  x, y - subB + 1 + subR, d)
;   else
;     widR := 1
;   d := APP(u.1, x + widR + 1, y, d)
;   d := apphor(x+widR+1, x+widR+widB, y+supB+1, d, specialChar('hbar))
;   d := appvertline(specialChar('vbar), x+widR, y - subB, y + supB, d)
;   d := APP(specialChar('ulc), x+widR, y + supB+1, d)
;   d := APP(specialChar('urc), x + widR + widB + 1, y + supB+1, d)
;   d := APP(specialChar('bslash), x + widR - 1, y - subB, d)

(DEFUN |rootApp| (|u| |x| |y| |d|)
  (PROG (|widB| |supB| |subB| |widR| |subR|)
    (RETURN
     (PROGN
      (SETQ |widB| (WIDTH (ELT |u| 1)))
      (SETQ |supB| (|superspan| (ELT |u| 1)))
      (SETQ |subB| (|subspan| (ELT |u| 1)))
      (COND
       ((< 2 (LENGTH |u|)) (SETQ |widR| (WIDTH (ELT |u| 2)))
        (SETQ |subR| (|subspan| (ELT |u| 2)))
        (SETQ |d| (APP (ELT |u| 2) |x| (+ (+ (- |y| |subB|) 1) |subR|) |d|)))
       ('T (SETQ |widR| 1)))
      (SETQ |d| (APP (ELT |u| 1) (+ (+ |x| |widR|) 1) |y| |d|))
      (SETQ |d|
              (|apphor| (+ (+ |x| |widR|) 1) (+ (+ |x| |widR|) |widB|)
               (+ (+ |y| |supB|) 1) |d| (|specialChar| '|hbar|)))
      (SETQ |d|
              (|appvertline| (|specialChar| '|vbar|) (+ |x| |widR|)
               (- |y| |subB|) (+ |y| |supB|) |d|))
      (SETQ |d|
              (APP (|specialChar| '|ulc|) (+ |x| |widR|) (+ (+ |y| |supB|) 1)
               |d|))
      (SETQ |d|
              (APP (|specialChar| '|urc|) (+ (+ (+ |x| |widR|) |widB|) 1)
               (+ (+ |y| |supB|) 1) |d|))
      (SETQ |d|
              (APP (|specialChar| '|bslash|) (- (+ |x| |widR|) 1)
               (- |y| |subB|) |d|))))))

; boxApp(u, x, y, d) ==
;   CDDR u => boxLApp(u, x, y, d)
;   a := 1 + superspan u.1
;   b := 1 + subspan u.1
;   w := 2 + WIDTH u.1
;   d := appvertline(specialChar('vbar), x,y - b + 1, y + a - 1, d)
;   d := appvertline(specialChar('vbar), x + w + 1, y - b,y + a,d)
;   d := apphor(x + 1, x + w, y - b, d, specialChar('hbar))
;   d := apphor(x + 1, x + w, y + a, d, specialChar('hbar))
;   d := APP(specialChar('ulc), x,         y + a, d)
;   d := APP(specialChar('urc), x + w + 1, y + a, d)
;   d := APP(specialChar('llc), x,         y - b, d)
;   d := APP(specialChar('lrc), x + w + 1, y - b, d)
;   d := APP(u.1, 2 + x, y, d)

(DEFUN |boxApp| (|u| |x| |y| |d|)
  (PROG (|a| |b| |w|)
    (RETURN
     (COND ((CDDR |u|) (|boxLApp| |u| |x| |y| |d|))
           ('T
            (PROGN
             (SETQ |a| (+ 1 (|superspan| (ELT |u| 1))))
             (SETQ |b| (+ 1 (|subspan| (ELT |u| 1))))
             (SETQ |w| (+ 2 (WIDTH (ELT |u| 1))))
             (SETQ |d|
                     (|appvertline| (|specialChar| '|vbar|) |x|
                      (+ (- |y| |b|) 1) (- (+ |y| |a|) 1) |d|))
             (SETQ |d|
                     (|appvertline| (|specialChar| '|vbar|) (+ (+ |x| |w|) 1)
                      (- |y| |b|) (+ |y| |a|) |d|))
             (SETQ |d|
                     (|apphor| (+ |x| 1) (+ |x| |w|) (- |y| |b|) |d|
                      (|specialChar| '|hbar|)))
             (SETQ |d|
                     (|apphor| (+ |x| 1) (+ |x| |w|) (+ |y| |a|) |d|
                      (|specialChar| '|hbar|)))
             (SETQ |d| (APP (|specialChar| '|ulc|) |x| (+ |y| |a|) |d|))
             (SETQ |d|
                     (APP (|specialChar| '|urc|) (+ (+ |x| |w|) 1) (+ |y| |a|)
                      |d|))
             (SETQ |d| (APP (|specialChar| '|llc|) |x| (- |y| |b|) |d|))
             (SETQ |d|
                     (APP (|specialChar| '|lrc|) (+ (+ |x| |w|) 1) (- |y| |b|)
                      |d|))
             (SETQ |d| (APP (ELT |u| 1) (+ 2 |x|) |y| |d|))))))))

; boxLApp(u, x, y, d) ==
;   la := superspan u.2
;   lb := subspan u.2
;   lw := 2 + WIDTH u.2
;   lh := 2 + la + lb
;   a := superspan u.1+1
;   b := subspan u.1+1
;   w := MAX(lw, 2 + WIDTH u.1)
;   -- next line used to have h instead of lh
;   top := y + a + lh
;   d := appvertline(MATBORCH, x, y - b, top, d)
;   d := appHorizLine(x + 1, x + w, top, d)
;   d := APP(u.2, 2 + x, y + a + lb + 1, d)
;   d := appHorizLine(x + 1, x + lw, y + a, d)
;   nil or
;      lw < w => d := appvertline(MATBORCH, x + lw + 1, y + a, top - 1, d)
;   d := APP(u.1, 2 + x, y, d)
;   d := appHorizLine(x + 1, x + w, y - b, d)
;   d := appvertline(MATBORCH, x + w + 1, y - b, top, d)

(DEFUN |boxLApp| (|u| |x| |y| |d|)
  (PROG (|la| |lb| |lw| |lh| |a| |b| |w| |top|)
    (RETURN
     (PROGN
      (SETQ |la| (|superspan| (ELT |u| 2)))
      (SETQ |lb| (|subspan| (ELT |u| 2)))
      (SETQ |lw| (+ 2 (WIDTH (ELT |u| 2))))
      (SETQ |lh| (+ (+ 2 |la|) |lb|))
      (SETQ |a| (+ (|superspan| (ELT |u| 1)) 1))
      (SETQ |b| (+ (|subspan| (ELT |u| 1)) 1))
      (SETQ |w| (MAX |lw| (+ 2 (WIDTH (ELT |u| 1)))))
      (SETQ |top| (+ (+ |y| |a|) |lh|))
      (SETQ |d| (|appvertline| MATBORCH |x| (- |y| |b|) |top| |d|))
      (SETQ |d| (|appHorizLine| (+ |x| 1) (+ |x| |w|) |top| |d|))
      (SETQ |d| (APP (ELT |u| 2) (+ 2 |x|) (+ (+ (+ |y| |a|) |lb|) 1) |d|))
      (SETQ |d| (|appHorizLine| (+ |x| 1) (+ |x| |lw|) (+ |y| |a|) |d|))
      (COND
       ((OR NIL (< |lw| |w|))
        (SETQ |d|
                (|appvertline| MATBORCH (+ (+ |x| |lw|) 1) (+ |y| |a|)
                 (- |top| 1) |d|)))
       ('T
        (PROGN
         (SETQ |d| (APP (ELT |u| 1) (+ 2 |x|) |y| |d|))
         (SETQ |d| (|appHorizLine| (+ |x| 1) (+ |x| |w|) (- |y| |b|) |d|))
         (SETQ |d|
                 (|appvertline| MATBORCH (+ (+ |x| |w|) 1) (- |y| |b|) |top|
                  |d|)))))))))

; boxSub(x) ==
;   subspan x.1+1

(DEFUN |boxSub| (|x|) (PROG () (RETURN (+ (|subspan| (ELT |x| 1)) 1))))

; boxSuper(x) ==
;   null rest x => 0
;   hl :=
;     null CDDR x => 0
;     true => 2 + subspan x.2 + superspan x.2
;   true => hl+1 + superspan x.1

(DEFUN |boxSuper| (|x|)
  (PROG (|hl|)
    (RETURN
     (COND ((NULL (CDR |x|)) 0)
           ('T
            (PROGN
             (SETQ |hl|
                     (COND ((NULL (CDDR |x|)) 0)
                           (T
                            (+ (+ 2 (|subspan| (ELT |x| 2)))
                               (|superspan| (ELT |x| 2))))))
             (COND (T (+ (+ |hl| 1) (|superspan| (ELT |x| 1)))))))))))

; boxWidth(x) ==
;   null rest x => 0
;   wl :=
;     null CDDR x => 0
;     true => WIDTH x.2
;   true => 4 + MAX(wl, WIDTH x.1)

(DEFUN |boxWidth| (|x|)
  (PROG (|wl|)
    (RETURN
     (COND ((NULL (CDR |x|)) 0)
           ('T
            (PROGN
             (SETQ |wl| (COND ((NULL (CDDR |x|)) 0) (T (WIDTH (ELT |x| 2)))))
             (COND (T (+ 4 (MAX |wl| (WIDTH (ELT |x| 1))))))))))))

; nothingWidth x ==
;     0

(DEFUN |nothingWidth| (|x|) (PROG () (RETURN 0)))

; nothingSuper x ==
;     0

(DEFUN |nothingSuper| (|x|) (PROG () (RETURN 0)))

; nothingSub x ==
;     0

(DEFUN |nothingSub| (|x|) (PROG () (RETURN 0)))

; nothingApp(u, x, y, d) ==
;     d

(DEFUN |nothingApp| (|u| |x| |y| |d|) (PROG () (RETURN |d|)))

; zagApp(u, x, y, d) ==
;     w := WIDTH u
;     denx := x + QUOTIENT(w - WIDTH CADR rest u, 2)
;     deny := y - superspan CADR rest u - 1
;     d    := APP(CADR rest u, denx, deny, d)
;     numx := x + QUOTIENT(w - WIDTH CADR u, 2)
;     numy := y+1 + subspan CADR u
;     d    := APP(CADR u, numx, numy, d)
;     a := 1 + zagSuper u
;     b := 1 + zagSub u
;     d := appvertline(specialChar('vbar), x,         y - b, y - 1, d)
;     d := appvertline(specialChar('vbar), x + w - 1, y + 1, y + a, d)
;     d := apphor(x, x + w - 2, y, d, specialChar('hbar))
;     d := APP(specialChar('ulc), x, y, d)
;     d := APP(specialChar('lrc), x + w - 1, y, d)

(DEFUN |zagApp| (|u| |x| |y| |d|)
  (PROG (|w| |denx| |deny| |numx| |numy| |a| |b|)
    (RETURN
     (PROGN
      (SETQ |w| (WIDTH |u|))
      (SETQ |denx| (+ |x| (QUOTIENT (- |w| (WIDTH (CADR (CDR |u|)))) 2)))
      (SETQ |deny| (- (- |y| (|superspan| (CADR (CDR |u|)))) 1))
      (SETQ |d| (APP (CADR (CDR |u|)) |denx| |deny| |d|))
      (SETQ |numx| (+ |x| (QUOTIENT (- |w| (WIDTH (CADR |u|))) 2)))
      (SETQ |numy| (+ (+ |y| 1) (|subspan| (CADR |u|))))
      (SETQ |d| (APP (CADR |u|) |numx| |numy| |d|))
      (SETQ |a| (+ 1 (|zagSuper| |u|)))
      (SETQ |b| (+ 1 (|zagSub| |u|)))
      (SETQ |d|
              (|appvertline| (|specialChar| '|vbar|) |x| (- |y| |b|) (- |y| 1)
               |d|))
      (SETQ |d|
              (|appvertline| (|specialChar| '|vbar|) (- (+ |x| |w|) 1)
               (+ |y| 1) (+ |y| |a|) |d|))
      (SETQ |d|
              (|apphor| |x| (- (+ |x| |w|) 2) |y| |d| (|specialChar| '|hbar|)))
      (SETQ |d| (APP (|specialChar| '|ulc|) |x| |y| |d|))
      (SETQ |d| (APP (|specialChar| '|lrc|) (- (+ |x| |w|) 1) |y| |d|))))))

; zagSub(u) ==
;     height CADR rest u

(DEFUN |zagSub| (|u|) (PROG () (RETURN (|height| (CADR (CDR |u|))))))

; zagSuper(u) ==
;     height CADR u

(DEFUN |zagSuper| (|u|) (PROG () (RETURN (|height| (CADR |u|)))))

; zagWidth(x) ==
;    #x = 1 => 0
;    #x = 2 => 4 + WIDTH x.1
;    4 + MAX(WIDTH x.1, WIDTH x.2)

(DEFUN |zagWidth| (|x|)
  (PROG ()
    (RETURN
     (COND ((EQL (LENGTH |x|) 1) 0)
           ((EQL (LENGTH |x|) 2) (+ 4 (WIDTH (ELT |x| 1))))
           ('T (+ 4 (MAX (WIDTH (ELT |x| 1)) (WIDTH (ELT |x| 2)))))))))

; rootWidth(x) ==
;    #x <= 2 => 3 + WIDTH x.1
;    2 + WIDTH x.1 + WIDTH x.2

(DEFUN |rootWidth| (|x|)
  (PROG ()
    (RETURN
     (COND ((NOT (< 2 (LENGTH |x|))) (+ 3 (WIDTH (ELT |x| 1))))
           ('T (+ (+ 2 (WIDTH (ELT |x| 1))) (WIDTH (ELT |x| 2))))))))

; rootSub(x) ==
;    subspan x.1

(DEFUN |rootSub| (|x|) (PROG () (RETURN (|subspan| (ELT |x| 1)))))

; rootSuper(x) ==
;    normal := 1 + superspan x.1
;    #x <= 2 => normal
;    (radOver := height x.2 - height x.1) < 0 => normal
;    normal + radOver

(DEFUN |rootSuper| (|x|)
  (PROG (|normal| |radOver|)
    (RETURN
     (PROGN
      (SETQ |normal| (+ 1 (|superspan| (ELT |x| 1))))
      (COND ((NOT (< 2 (LENGTH |x|))) |normal|)
            ((MINUSP
              (SETQ |radOver|
                      (- (|height| (ELT |x| 2)) (|height| (ELT |x| 1)))))
             |normal|)
            ('T (+ |normal| |radOver|)))))))

; appmat(u, x, y, d) ==
;    rows := CDDR u
;    p := matSuper u
;    q := matSub u
;    d := matrixBorder(x, y - q, y + p, d, 'left)
;    x := 1 + x
;    yc := 1 + y + p
;    w := CADR u
;    wl := CDAR w
;    subl := rest CADR w
;    superl := rest CADR rest w
;    repeat
;       null rows =>
;           wu := MAX(0, WIDTH u - 2)
;           return(matrixBorder(x + wu, y - q, y + p, d, 'right))
;       xc := x
;       yc := yc - 1 - first superl
;       w := wl
;       row := CDAR rows
;       repeat
;             if flag = '"ON" then
;                flag := '"OFF"
;                return(nil)
;             null row =>
;                   repeat
;                      yc := yc - 1 - first subl
;                      subl := rest subl
;                      superl := rest superl
;                      rows := rest rows
;                      return(flag  := '"ON"; nil)
;             d := APP(first row,
;                      xc + QUOTIENT(first w - WIDTH first row, 2),
;                      yc,
;                      d)
;             xc := xc + 2 + first w
;             row := rest row
;             w := rest w

(DEFUN |appmat| (|u| |x| |y| |d|)
  (PROG (|rows| |p| |q| |yc| |w| |wl| |subl| |superl| |wu| |xc| |row| |flag|)
    (RETURN
     (PROGN
      (SETQ |rows| (CDDR |u|))
      (SETQ |p| (|matSuper| |u|))
      (SETQ |q| (|matSub| |u|))
      (SETQ |d| (|matrixBorder| |x| (- |y| |q|) (+ |y| |p|) |d| '|left|))
      (SETQ |x| (+ 1 |x|))
      (SETQ |yc| (+ (+ 1 |y|) |p|))
      (SETQ |w| (CADR |u|))
      (SETQ |wl| (CDAR |w|))
      (SETQ |subl| (CDR (CADR |w|)))
      (SETQ |superl| (CDR (CADR (CDR |w|))))
      ((LAMBDA ()
         (LOOP
          (COND (NIL (RETURN NIL))
                (#1='T
                 (COND
                  ((NULL |rows|)
                   (PROGN
                    (SETQ |wu| (MAX 0 (- (WIDTH |u|) 2)))
                    (RETURN
                     (|matrixBorder| (+ |x| |wu|) (- |y| |q|) (+ |y| |p|) |d|
                      '|right|))))
                  (#1#
                   (PROGN
                    (SETQ |xc| |x|)
                    (SETQ |yc| (- (- |yc| 1) (CAR |superl|)))
                    (SETQ |w| |wl|)
                    (SETQ |row| (CDAR |rows|))
                    ((LAMBDA ()
                       (LOOP
                        (COND (NIL (RETURN NIL))
                              (#1#
                               (PROGN
                                (COND
                                 ((EQUAL |flag| "ON") (SETQ |flag| "OFF")
                                  (RETURN NIL)))
                                (COND
                                 ((NULL |row|)
                                  ((LAMBDA ()
                                     (LOOP
                                      (COND (NIL (RETURN NIL))
                                            (#1#
                                             (PROGN
                                              (SETQ |yc|
                                                      (- (- |yc| 1)
                                                         (CAR |subl|)))
                                              (SETQ |subl| (CDR |subl|))
                                              (SETQ |superl| (CDR |superl|))
                                              (SETQ |rows| (CDR |rows|))
                                              (RETURN
                                               (PROGN
                                                (SETQ |flag| "ON")
                                                NIL)))))))))
                                 (#1#
                                  (PROGN
                                   (SETQ |d|
                                           (APP (CAR |row|)
                                            (+ |xc|
                                               (QUOTIENT
                                                (- (CAR |w|)
                                                   (WIDTH (CAR |row|)))
                                                2))
                                            |yc| |d|))
                                   (SETQ |xc| (+ (+ |xc| 2) (CAR |w|)))
                                   (SETQ |row| (CDR |row|))
                                   (SETQ |w| (CDR |w|)))))))))))))))))))))))

; matSuper(x) ==
;   (x := x.1) => -1 + QUOTIENT(first x.1 + first x.2, 2)
;   true => ERROR('MAT)

(DEFUN |matSuper| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((SETQ |x| (ELT |x| 1))
       (+ (- 1) (QUOTIENT (+ (CAR (ELT |x| 1)) (CAR (ELT |x| 2))) 2)))
      (T (ERROR 'MAT))))))

; matSub(x) ==
;   (x := x.1) => QUOTIENT(-1 + first x.1 + first x.2, 2)
;   true => ERROR('MAT)

(DEFUN |matSub| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((SETQ |x| (ELT |x| 1))
       (QUOTIENT (+ (+ (- 1) (CAR (ELT |x| 1))) (CAR (ELT |x| 2))) 2))
      (T (ERROR 'MAT))))))

; matWidth(x) ==
;   y := CDDR x  -- list of rows, each of form ((ROW . w) element element ...)
;   numOfColumns := LENGTH CDAR y
;   widthList := matLSum2 matWList(y, [0 for j in 1..numOfColumns])
;     --returns ["max width of entries in column i" for i in 1..numberOfRows]
;   subspanList := matLSum matSubList y
;   superspanList := matLSum matSuperList y
;   rplac(x.1, [widthList, subspanList, superspanList])
;   CAAR x.1

(DEFUN |matWidth| (|x|)
  (PROG (|y| |numOfColumns| |widthList| |subspanList| |superspanList|)
    (RETURN
     (PROGN
      (SETQ |y| (CDDR |x|))
      (SETQ |numOfColumns| (LENGTH (CDAR |y|)))
      (SETQ |widthList|
              (|matLSum2|
               (|matWList| |y|
                ((LAMBDA (|bfVar#91| |j|)
                   (LOOP
                    (COND
                     ((> |j| |numOfColumns|) (RETURN (NREVERSE |bfVar#91|)))
                     ('T (SETQ |bfVar#91| (CONS 0 |bfVar#91|))))
                    (SETQ |j| (+ |j| 1))))
                 NIL 1))))
      (SETQ |subspanList| (|matLSum| (|matSubList| |y|)))
      (SETQ |superspanList| (|matLSum| (|matSuperList| |y|)))
      (|rplac| (ELT |x| 1) (LIST |widthList| |subspanList| |superspanList|))
      (CAAR (ELT |x| 1))))))

; matLSum(x) ==
;   CONS(sumoverlist x + LENGTH x, x)

(DEFUN |matLSum| (|x|)
  (PROG () (RETURN (CONS (+ (|sumoverlist| |x|) (LENGTH |x|)) |x|))))

; matLSum2(x) ==
;   null x => [2]
;   CONS(sumoverlist x + 2*(LENGTH x), x)

(DEFUN |matLSum2| (|x|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) (LIST 2))
           ('T (CONS (+ (|sumoverlist| |x|) (* 2 (LENGTH |x|))) |x|))))))

; matWList(x, y) ==
;   null x => y
;   true => matWList(rest x, matWList1(CDAR x, y) )

(DEFUN |matWList| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) |y|)
           (T (|matWList| (CDR |x|) (|matWList1| (CDAR |x|) |y|)))))))

; matWList1(x, y) ==
;   null x => nil
;   true => CONS(MAX(WIDTH first x, first y), matWList1(rest x, rest y) )

(DEFUN |matWList1| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) NIL)
           (T
            (CONS (MAX (WIDTH (CAR |x|)) (CAR |y|))
                  (|matWList1| (CDR |x|) (CDR |y|))))))))

; matSubList(x) ==  --computes the max/[subspan(e) for e in "row named x"]
;   null x => nil
;   true => CONS(matSubList1(CDAR x, 0), matSubList(rest x) )

(DEFUN |matSubList| (|x|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) NIL)
           (T (CONS (|matSubList1| (CDAR |x|) 0) (|matSubList| (CDR |x|))))))))

; matSubList1(x, y) ==
;   null x => y
;   true => matSubList1(rest x, MAX(y, subspan first x) )

(DEFUN |matSubList1| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) |y|)
           (T (|matSubList1| (CDR |x|) (MAX |y| (|subspan| (CAR |x|)))))))))

; matSuperList(x) ==  --computes the max/[superspan(e) for e in "row named x"]
;   null x => nil
;   true => CONS(matSuperList1(CDAR x, 0), matSuperList(rest x) )

(DEFUN |matSuperList| (|x|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) NIL)
           (T
            (CONS (|matSuperList1| (CDAR |x|) 0)
                  (|matSuperList| (CDR |x|))))))))

; matSuperList1(x, y) ==
;   null x => y
;   true => matSuperList1(rest x, MAX(y, superspan first x) )

(DEFUN |matSuperList1| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) |y|)
           (T (|matSuperList1| (CDR |x|) (MAX |y| (|superspan| (CAR |x|)))))))))

; minusWidth(u) ==
;   -1 + sumWidthA rest u

(DEFUN |minusWidth| (|u|) (PROG () (RETURN (+ (- 1) (|sumWidthA| (CDR |u|))))))

; bracketagglist(u, start, linelength, tchr, open, close) ==
;   u := CONS(LIST('CONCAT, open, first u),
;             [LIST('CONCAT, '" ", y) for y in rest u] )
;   repeat
;     s := 0
;     for x in tails u repeat
;              lastx := x
;              ((s := s + WIDTH first x + 1) >= linelength) => return(s)
;              null rest x => return(s := -1)
;     nil or
;        EQ(s, -1) => (nextu := nil)
;        EQ(lastx, u) => ((nextu := rest u); RPLACD(u, nil) )
;        true => ((nextu := lastx); RPLACD(PREDECESSOR(lastx, u), nil))
;     for x in tails u repeat
;            RPLACA(x, LIST('CONCAT, first x, tchr))
;     if null nextu then RPLACA(CDDR last u, close)
;     charybdis(ASSOCIATER('CONCAT, u), start, linelength)
;     if $collectOutput then TERPRI(get_algebra_stream())
;     u := nextu
;     null u => return(nil)

(DEFUN |bracketagglist| (|u| |start| |linelength| |tchr| |open| |close|)
  (PROG (|s| |lastx| |nextu|)
    (RETURN
     (PROGN
      (SETQ |u|
              (CONS (LIST 'CONCAT |open| (CAR |u|))
                    ((LAMBDA (|bfVar#93| |bfVar#92| |y|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#92|)
                              (PROGN (SETQ |y| (CAR |bfVar#92|)) NIL))
                          (RETURN (NREVERSE |bfVar#93|)))
                         (#1='T
                          (SETQ |bfVar#93|
                                  (CONS (LIST 'CONCAT " " |y|) |bfVar#93|))))
                        (SETQ |bfVar#92| (CDR |bfVar#92|))))
                     NIL (CDR |u|) NIL)))
      ((LAMBDA ()
         (LOOP
          (COND (NIL (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |s| 0)
                  ((LAMBDA (|x|)
                     (LOOP
                      (COND ((ATOM |x|) (RETURN NIL))
                            (#1#
                             (PROGN
                              (SETQ |lastx| |x|)
                              (COND
                               ((NOT
                                 (< (SETQ |s| (+ (+ |s| (WIDTH (CAR |x|))) 1))
                                    |linelength|))
                                (RETURN |s|))
                               ((NULL (CDR |x|)) (RETURN (SETQ |s| (- 1))))))))
                      (SETQ |x| (CDR |x|))))
                   |u|)
                  (OR NIL
                      (COND ((EQ |s| (- 1)) (SETQ |nextu| NIL))
                            ((EQ |lastx| |u|)
                             (PROGN (SETQ |nextu| (CDR |u|)) (RPLACD |u| NIL)))
                            (T
                             (PROGN
                              (SETQ |nextu| |lastx|)
                              (RPLACD (PREDECESSOR |lastx| |u|) NIL)))))
                  ((LAMBDA (|x|)
                     (LOOP
                      (COND ((ATOM |x|) (RETURN NIL))
                            (#1# (RPLACA |x| (LIST 'CONCAT (CAR |x|) |tchr|))))
                      (SETQ |x| (CDR |x|))))
                   |u|)
                  (COND ((NULL |nextu|) (RPLACA (CDDR (|last| |u|)) |close|)))
                  (|charybdis| (ASSOCIATER 'CONCAT |u|) |start| |linelength|)
                  (COND (|$collectOutput| (TERPRI (|get_algebra_stream|))))
                  (SETQ |u| |nextu|)
                  (COND ((NULL |u|) (RETURN NIL)))))))))))))

; prnd(start, op) ==
;   spcs := fillerSpaces(MAX(0,start - 1), '" ")
;   $collectOutput =>
;     string := STRCONC(spcs, op)
;     $outputLines := [string, :$outputLines]
;   PRINTEXP(spcs, get_algebra_stream())
;   PRINTEXP(op, get_algebra_stream())
;   TERPRI(get_algebra_stream())

(DEFUN |prnd| (|start| |op|)
  (PROG (|spcs| |string|)
    (RETURN
     (PROGN
      (SETQ |spcs| (|fillerSpaces| (MAX 0 (- |start| 1)) " "))
      (COND
       (|$collectOutput|
        (PROGN
         (SETQ |string| (STRCONC |spcs| |op|))
         (SETQ |$outputLines| (CONS |string| |$outputLines|))))
       ('T
        (PROGN
         (PRINTEXP |spcs| (|get_algebra_stream|))
         (PRINTEXP |op| (|get_algebra_stream|))
         (TERPRI (|get_algebra_stream|)))))))))

; qTSub(u) ==
;   subspan CADR u

(DEFUN |qTSub| (|u|) (PROG () (RETURN (|subspan| (CADR |u|)))))

; qTSuper(u) ==
;   superspan CADR u

(DEFUN |qTSuper| (|u|) (PROG () (RETURN (|superspan| (CADR |u|)))))

; qTWidth(u) ==
;   2 + WIDTH CADR u

(DEFUN |qTWidth| (|u|) (PROG () (RETURN (+ 2 (WIDTH (CADR |u|))))))

; remWidth(x) ==
;   atom x => x
;   true => CONS( (atom first x => first x; true => CAAR x),
;                 MMAPCAR(remWidth, rest x) )

(DEFUN |remWidth| (|x|)
  (PROG ()
    (RETURN
     (COND ((ATOM |x|) |x|)
           (T
            (CONS (COND ((ATOM (CAR |x|)) (CAR |x|)) (T (CAAR |x|)))
                  (MMAPCAR |remWidth| (CDR |x|))))))))

; subSub(u) ==
;   height CDDR u

(DEFUN |subSub| (|u|) (PROG () (RETURN (|height| (CDDR |u|)))))

; subSuper u ==
;   superspan u.1

(DEFUN |subSuper| (|u|) (PROG () (RETURN (|superspan| (ELT |u| 1)))))

; letWidth u ==
;   5 + WIDTH u.1 + WIDTH u.2

(DEFUN |letWidth| (|u|)
  (PROG () (RETURN (+ (+ 5 (WIDTH (ELT |u| 1))) (WIDTH (ELT |u| 2))))))

; sumoverlist(u) == +/[x for x in u]

(DEFUN |sumoverlist| (|u|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#95| |bfVar#94| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#94|) (PROGN (SETQ |x| (CAR |bfVar#94|)) NIL))
           (RETURN |bfVar#95|))
          ('T (SETQ |bfVar#95| (+ |bfVar#95| |x|))))
         (SETQ |bfVar#94| (CDR |bfVar#94|))))
      0 |u| NIL))))

; sumWidth u ==
;   WIDTH u.1 + sumWidthA CDDR u

(DEFUN |sumWidth| (|u|)
  (PROG () (RETURN (+ (WIDTH (ELT |u| 1)) (|sumWidthA| (CDDR |u|))))))

; sumWidthA u ==
;   sum := 0
;   for item in u repeat
;     sum := sum + (if member(keyp absym item, '(_+ _-)) then 5 else 3)
;     sum := sum + WIDTH absym item
;   sum

(DEFUN |sumWidthA| (|u|)
  (PROG (|sum|)
    (RETURN
     (PROGN
      (SETQ |sum| 0)
      ((LAMBDA (|bfVar#96| |item|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#96|) (PROGN (SETQ |item| (CAR |bfVar#96|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |sum|
                     (+ |sum|
                        (COND ((|member| (|keyp| (|absym| |item|)) '(+ -)) 5)
                              (#1# 3))))
             (SETQ |sum| (+ |sum| (WIDTH (|absym| |item|)))))))
          (SETQ |bfVar#96| (CDR |bfVar#96|))))
       |u| NIL)
      |sum|))))

; superSubApp(u, x, y, di) ==
;   a := first (u := rest u)
;   b := first (u := rest u)
;   c := first (u := IFCDR u) or '((NOTHING . 0))
;   d := IFCAR   (u := IFCDR u) or '((NOTHING . 0))
;   e := IFCAR(IFCDR(u)) or '((NOTHING . 0))
;   aox := MAX(wd := WIDTH d, we := WIDTH e)
;   ar := superspan a
;   ab := subspan a
;   aw := WIDTH a
;   di := APP(d, x + (aox - wd), 1 + ar + y + subspan d, di)
;   di := APP(a, x + aox, y, di)
;   di := APP(c, aox + aw + x, 1 + y + ar + subspan c, di)
;   di := APP(e, x + (aox - we), y - 1 - MAX(superspan e, ab), di)
;   di := APP(b, aox + aw + x, y - 1 - MAX(ab, superspan b), di)
;   return di

(DEFUN |superSubApp| (|u| |x| |y| |di|)
  (PROG (|a| |b| |c| |d| |e| |wd| |we| |aox| |ar| |ab| |aw|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR (SETQ |u| (CDR |u|))))
      (SETQ |b| (CAR (SETQ |u| (CDR |u|))))
      (SETQ |c| (OR (CAR (SETQ |u| (IFCDR |u|))) '((NOTHING . 0))))
      (SETQ |d| (OR (IFCAR (SETQ |u| (IFCDR |u|))) '((NOTHING . 0))))
      (SETQ |e| (OR (IFCAR (IFCDR |u|)) '((NOTHING . 0))))
      (SETQ |aox| (MAX (SETQ |wd| (WIDTH |d|)) (SETQ |we| (WIDTH |e|))))
      (SETQ |ar| (|superspan| |a|))
      (SETQ |ab| (|subspan| |a|))
      (SETQ |aw| (WIDTH |a|))
      (SETQ |di|
              (APP |d| (+ |x| (- |aox| |wd|))
               (+ (+ (+ 1 |ar|) |y|) (|subspan| |d|)) |di|))
      (SETQ |di| (APP |a| (+ |x| |aox|) |y| |di|))
      (SETQ |di|
              (APP |c| (+ (+ |aox| |aw|) |x|)
               (+ (+ (+ 1 |y|) |ar|) (|subspan| |c|)) |di|))
      (SETQ |di|
              (APP |e| (+ |x| (- |aox| |we|))
               (- (- |y| 1) (MAX (|superspan| |e|) |ab|)) |di|))
      (SETQ |di|
              (APP |b| (+ (+ |aox| |aw|) |x|)
               (- (- |y| 1) (MAX |ab| (|superspan| |b|))) |di|))
      (RETURN |di|)))))

; stringer x ==
;   STRINGP x => x
;   EQ('_|, FETCHCHAR(s:= STRINGIMAGE x, 0)) =>
;     RPLACSTR(s, 0, 1, "", nil, nil)
;   s

(DEFUN |stringer| (|x|)
  (PROG (|s|)
    (RETURN
     (COND ((STRINGP |x|) |x|)
           ((EQ '|\|| (FETCHCHAR (SETQ |s| (STRINGIMAGE |x|)) 0))
            (RPLACSTR |s| 0 1 '|| NIL NIL))
           ('T |s|)))))

; superSubSub u ==
;   a:= first (u:= rest u)
;   b := IFCAR (u := IFCDR u)
;   e := IFCAR IFCDR IFCDR IFCDR u
;   return subspan a + MAX(height b, height e)

(DEFUN |superSubSub| (|u|)
  (PROG (|a| |b| |e|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR (SETQ |u| (CDR |u|))))
      (SETQ |b| (IFCAR (SETQ |u| (IFCDR |u|))))
      (SETQ |e| (IFCAR (IFCDR (IFCDR (IFCDR |u|)))))
      (RETURN (+ (|subspan| |a|) (MAX (|height| |b|) (|height| |e|))))))))

; binomApp(u,x,y,d) ==
;   [num,den] := rest u
;   ysub := y - 1 - superspan den
;   ysup := y + 1 + subspan num
;   wden := WIDTH den
;   wnum := WIDTH num
;   w := MAX(wden,wnum)
;   d := APP(den, x + 1 + QUOTIENT(w - wden, 2), ysub, d)
;   d := APP(num, x + 1 + QUOTIENT(w - wnum, 2), ysup, d)
;   hnum := height num
;   hden := height den
;   w := 1 + w
;   for j in 0..(hnum - 1) repeat
;     d := appChar(specialChar 'vbar,x,y + j,d)
;     d := appChar(specialChar 'vbar,x + w,y + j,d)
;   for j in 1..(hden - 1) repeat
;     d := appChar(specialChar 'vbar,x,y - j,d)
;     d := appChar(specialChar 'vbar,x + w,y - j,d)
;   d := appChar(specialChar 'ulc,x,y + hnum,d)
;   d := appChar(specialChar 'urc,x + w,y + hnum,d)
;   d := appChar(specialChar 'llc,x,y - hden,d)
;   d := appChar(specialChar 'lrc,x + w,y - hden,d)

(DEFUN |binomApp| (|u| |x| |y| |d|)
  (PROG (|LETTMP#1| |num| |den| |ysub| |ysup| |wden| |wnum| |w| |hnum| |hden|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (CDR |u|))
      (SETQ |num| (CAR |LETTMP#1|))
      (SETQ |den| (CADR |LETTMP#1|))
      (SETQ |ysub| (- (- |y| 1) (|superspan| |den|)))
      (SETQ |ysup| (+ (+ |y| 1) (|subspan| |num|)))
      (SETQ |wden| (WIDTH |den|))
      (SETQ |wnum| (WIDTH |num|))
      (SETQ |w| (MAX |wden| |wnum|))
      (SETQ |d|
              (APP |den| (+ (+ |x| 1) (QUOTIENT (- |w| |wden|) 2)) |ysub| |d|))
      (SETQ |d|
              (APP |num| (+ (+ |x| 1) (QUOTIENT (- |w| |wnum|) 2)) |ysup| |d|))
      (SETQ |hnum| (|height| |num|))
      (SETQ |hden| (|height| |den|))
      (SETQ |w| (+ 1 |w|))
      ((LAMBDA (|bfVar#97| |j|)
         (LOOP
          (COND ((> |j| |bfVar#97|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |d|
                          (|appChar| (|specialChar| '|vbar|) |x| (+ |y| |j|)
                           |d|))
                  (SETQ |d|
                          (|appChar| (|specialChar| '|vbar|) (+ |x| |w|)
                           (+ |y| |j|) |d|)))))
          (SETQ |j| (+ |j| 1))))
       (- |hnum| 1) 0)
      ((LAMBDA (|bfVar#98| |j|)
         (LOOP
          (COND ((> |j| |bfVar#98|) (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |d|
                          (|appChar| (|specialChar| '|vbar|) |x| (- |y| |j|)
                           |d|))
                  (SETQ |d|
                          (|appChar| (|specialChar| '|vbar|) (+ |x| |w|)
                           (- |y| |j|) |d|)))))
          (SETQ |j| (+ |j| 1))))
       (- |hden| 1) 1)
      (SETQ |d| (|appChar| (|specialChar| '|ulc|) |x| (+ |y| |hnum|) |d|))
      (SETQ |d|
              (|appChar| (|specialChar| '|urc|) (+ |x| |w|) (+ |y| |hnum|)
               |d|))
      (SETQ |d| (|appChar| (|specialChar| '|llc|) |x| (- |y| |hden|) |d|))
      (SETQ |d|
              (|appChar| (|specialChar| '|lrc|) (+ |x| |w|) (- |y| |hden|)
               |d|))))))

; binomSub u == height CADDR u

(DEFUN |binomSub| (|u|) (PROG () (RETURN (|height| (CADDR |u|)))))

; binomSuper u == height CADR u

(DEFUN |binomSuper| (|u|) (PROG () (RETURN (|height| (CADR |u|)))))

; binomWidth u == 2 + MAX(WIDTH CADR u, WIDTH CADDR u)

(DEFUN |binomWidth| (|u|)
  (PROG () (RETURN (+ 2 (MAX (WIDTH (CADR |u|)) (WIDTH (CADDR |u|)))))))

; altSuperSubApp(u, x, y, di) ==
;   a  := first (u := rest u)
;   ar := superspan a
;   ab := subspan a
;   aw := WIDTH a
;   di := APP(a, x, y, di)
;   x  := x + aw
;
;   sublist := everyNth(u := rest u, 2)
;   suplist := everyNth(IFCDR u, 2)
;
;   ysub := y - 1 - APPLY('MAX, [ab, :[superspan s for s in sublist]])
;   ysup := y + 1 + APPLY('MAX, [ar, :[subspan   s for s in sublist]])
;   for sub in sublist for sup in suplist repeat
;       wsub := WIDTH sub
;       wsup := WIDTH sup
;       di := APP(sub, x, ysub, di)
;       di := APP(sup, x, ysup, di)
;       x := x + 1 + MAX(wsub, wsup)
;   di

(DEFUN |altSuperSubApp| (|u| |x| |y| |di|)
  (PROG (|a| |ar| |ab| |aw| |sublist| |suplist| |ysub| |ysup| |wsub| |wsup|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR (SETQ |u| (CDR |u|))))
      (SETQ |ar| (|superspan| |a|))
      (SETQ |ab| (|subspan| |a|))
      (SETQ |aw| (WIDTH |a|))
      (SETQ |di| (APP |a| |x| |y| |di|))
      (SETQ |x| (+ |x| |aw|))
      (SETQ |sublist| (|everyNth| (SETQ |u| (CDR |u|)) 2))
      (SETQ |suplist| (|everyNth| (IFCDR |u|) 2))
      (SETQ |ysub|
              (- (- |y| 1)
                 (APPLY 'MAX
                        (CONS |ab|
                              ((LAMBDA (|bfVar#100| |bfVar#99| |s|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#99|)
                                        (PROGN
                                         (SETQ |s| (CAR |bfVar#99|))
                                         NIL))
                                    (RETURN (NREVERSE |bfVar#100|)))
                                   (#1='T
                                    (SETQ |bfVar#100|
                                            (CONS (|superspan| |s|)
                                                  |bfVar#100|))))
                                  (SETQ |bfVar#99| (CDR |bfVar#99|))))
                               NIL |sublist| NIL)))))
      (SETQ |ysup|
              (+ (+ |y| 1)
                 (APPLY 'MAX
                        (CONS |ar|
                              ((LAMBDA (|bfVar#102| |bfVar#101| |s|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#101|)
                                        (PROGN
                                         (SETQ |s| (CAR |bfVar#101|))
                                         NIL))
                                    (RETURN (NREVERSE |bfVar#102|)))
                                   (#1#
                                    (SETQ |bfVar#102|
                                            (CONS (|subspan| |s|)
                                                  |bfVar#102|))))
                                  (SETQ |bfVar#101| (CDR |bfVar#101|))))
                               NIL |sublist| NIL)))))
      ((LAMBDA (|bfVar#103| |sub| |bfVar#104| |sup|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#103|) (PROGN (SETQ |sub| (CAR |bfVar#103|)) NIL)
                (ATOM |bfVar#104|) (PROGN (SETQ |sup| (CAR |bfVar#104|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |wsub| (WIDTH |sub|))
             (SETQ |wsup| (WIDTH |sup|))
             (SETQ |di| (APP |sub| |x| |ysub| |di|))
             (SETQ |di| (APP |sup| |x| |ysup| |di|))
             (SETQ |x| (+ (+ |x| 1) (MAX |wsub| |wsup|))))))
          (SETQ |bfVar#103| (CDR |bfVar#103|))
          (SETQ |bfVar#104| (CDR |bfVar#104|))))
       |sublist| NIL |suplist| NIL)
      |di|))))

; everyNth(l, n) ==
;     [(e := l.0; for i in 1..n while l repeat l := rest l; e) while l]

(DEFUN |everyNth| (|l| |n|)
  (PROG (|e|)
    (RETURN
     ((LAMBDA (|bfVar#105|)
        (LOOP
         (COND ((NOT |l|) (RETURN (NREVERSE |bfVar#105|)))
               (#1='T
                (SETQ |bfVar#105|
                        (CONS
                         (PROGN
                          (SETQ |e| (ELT |l| 0))
                          ((LAMBDA (|i|)
                             (LOOP
                              (COND ((OR (> |i| |n|) (NOT |l|)) (RETURN NIL))
                                    (#1# (SETQ |l| (CDR |l|))))
                              (SETQ |i| (+ |i| 1))))
                           1)
                          |e|)
                         |bfVar#105|))))))
      NIL))))

; altSuperSubSub u ==
;   span := subspan CADR u
;   sublist := everyNth(CDDR u, 2)
;   for sub in sublist repeat
;       h := height sub
;       if h > span then span := h
;   span

(DEFUN |altSuperSubSub| (|u|)
  (PROG (|span| |sublist| |h|)
    (RETURN
     (PROGN
      (SETQ |span| (|subspan| (CADR |u|)))
      (SETQ |sublist| (|everyNth| (CDDR |u|) 2))
      ((LAMBDA (|bfVar#106| |sub|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#106|) (PROGN (SETQ |sub| (CAR |bfVar#106|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |h| (|height| |sub|))
             (COND ((< |span| |h|) (SETQ |span| |h|))))))
          (SETQ |bfVar#106| (CDR |bfVar#106|))))
       |sublist| NIL)
      |span|))))

; altSuperSubSuper u ==
;   span := superspan CADR u
;   suplist := everyNth(IFCDR CDDR u, 2)
;   for sup in suplist repeat
;       h := height sup
;       if h > span then span := h
;   span

(DEFUN |altSuperSubSuper| (|u|)
  (PROG (|span| |suplist| |h|)
    (RETURN
     (PROGN
      (SETQ |span| (|superspan| (CADR |u|)))
      (SETQ |suplist| (|everyNth| (IFCDR (CDDR |u|)) 2))
      ((LAMBDA (|bfVar#107| |sup|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#107|) (PROGN (SETQ |sup| (CAR |bfVar#107|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |h| (|height| |sup|))
             (COND ((< |span| |h|) (SETQ |span| |h|))))))
          (SETQ |bfVar#107| (CDR |bfVar#107|))))
       |suplist| NIL)
      |span|))))

; altSuperSubWidth u ==
;   w := WIDTH CADR u
;   suplist := everyNth(IFCDR CDDR u, 2)
;   sublist := everyNth(CDDR u, 2)
;   for sup in suplist for sub in sublist repeat
;       wsup := WIDTH sup
;       wsub := WIDTH sub
;       w := w + 1 + MAX(wsup, wsub)
;   w

(DEFUN |altSuperSubWidth| (|u|)
  (PROG (|w| |suplist| |sublist| |wsup| |wsub|)
    (RETURN
     (PROGN
      (SETQ |w| (WIDTH (CADR |u|)))
      (SETQ |suplist| (|everyNth| (IFCDR (CDDR |u|)) 2))
      (SETQ |sublist| (|everyNth| (CDDR |u|) 2))
      ((LAMBDA (|bfVar#108| |sup| |bfVar#109| |sub|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#108|) (PROGN (SETQ |sup| (CAR |bfVar#108|)) NIL)
                (ATOM |bfVar#109|) (PROGN (SETQ |sub| (CAR |bfVar#109|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |wsup| (WIDTH |sup|))
             (SETQ |wsub| (WIDTH |sub|))
             (SETQ |w| (+ (+ |w| 1) (MAX |wsup| |wsub|))))))
          (SETQ |bfVar#108| (CDR |bfVar#108|))
          (SETQ |bfVar#109| (CDR |bfVar#109|))))
       |suplist| NIL |sublist| NIL)
      |w|))))

; superSubWidth u ==
;   a := first (u := rest u)
;   b := first (u := rest u)
;   c := first (u := IFCDR u) or '((NOTHING . 0))
;   d := IFCAR   (u := IFCDR u) or '((NOTHING . 0))
;   e := IFCAR(IFCDR(u)) or '((NOTHING . 0))
;   return MAX(WIDTH d, WIDTH e) + MAX(WIDTH b, WIDTH c) + WIDTH a

(DEFUN |superSubWidth| (|u|)
  (PROG (|a| |b| |c| |d| |e|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR (SETQ |u| (CDR |u|))))
      (SETQ |b| (CAR (SETQ |u| (CDR |u|))))
      (SETQ |c| (OR (CAR (SETQ |u| (IFCDR |u|))) '((NOTHING . 0))))
      (SETQ |d| (OR (IFCAR (SETQ |u| (IFCDR |u|))) '((NOTHING . 0))))
      (SETQ |e| (OR (IFCAR (IFCDR |u|)) '((NOTHING . 0))))
      (RETURN
       (+ (+ (MAX (WIDTH |d|) (WIDTH |e|)) (MAX (WIDTH |b|) (WIDTH |c|)))
          (WIDTH |a|)))))))

; superSubSuper u ==
;   a:= first (u := rest u)
;   c := IFCAR (u := IFCDR IFCDR u)
;   d := IFCAR(IFCDR(u))
;   return superspan a + MAX(height c, height d)

(DEFUN |superSubSuper| (|u|)
  (PROG (|a| |c| |d|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR (SETQ |u| (CDR |u|))))
      (SETQ |c| (IFCAR (SETQ |u| (IFCDR (IFCDR |u|)))))
      (SETQ |d| (IFCAR (IFCDR |u|)))
      (RETURN (+ (|superspan| |a|) (MAX (|height| |c|) (|height| |d|))))))))

; suScWidth u ==
;   WIDTH u.1 + aggwidth CDDR u

(DEFUN |suScWidth| (|u|)
  (PROG () (RETURN (+ (WIDTH (ELT |u| 1)) (|aggwidth| (CDDR |u|))))))

; vconcatapp(u, x, y, d) ==
;   null rest u => d
;   w := vConcatWidth u
;   y := y + superspan u.1 + 1
;   for a in rest u repeat
;       y := y - superspan a - 1
;       xoff := QUOTIENT(w - WIDTH a, 2)
;       d := APP(a, x + xoff, y, d)
;       y := y - subspan a
;   d

(DEFUN |vconcatapp| (|u| |x| |y| |d|)
  (PROG (|w| |xoff|)
    (RETURN
     (COND ((NULL (CDR |u|)) |d|)
           (#1='T
            (PROGN
             (SETQ |w| (|vConcatWidth| |u|))
             (SETQ |y| (+ (+ |y| (|superspan| (ELT |u| 1))) 1))
             ((LAMBDA (|bfVar#110| |a|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#110|)
                       (PROGN (SETQ |a| (CAR |bfVar#110|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |y| (- (- |y| (|superspan| |a|)) 1))
                    (SETQ |xoff| (QUOTIENT (- |w| (WIDTH |a|)) 2))
                    (SETQ |d| (APP |a| (+ |x| |xoff|) |y| |d|))
                    (SETQ |y| (- |y| (|subspan| |a|))))))
                 (SETQ |bfVar#110| (CDR |bfVar#110|))))
              (CDR |u|) NIL)
             |d|))))))

; binomialApp(u, x, y, d) ==
;   [.,b,a] := u
;   w := vConcatWidth u
;   d := APP('"(",x,y,d)
;   x := x + 1
;   y1 := y - height a
;   xoff := QUOTIENT(w - WIDTH a, 2)
;   d := APP(a, x + xoff, y1, d)
;   y2 := y + height b
;   xoff := QUOTIENT(w - WIDTH b, 2)
;   d := APP(b, x + xoff, y2, d)
;   x := x + w
;   APP('")",x,y,d)

(DEFUN |binomialApp| (|u| |x| |y| |d|)
  (PROG (|b| |a| |w| |y1| |xoff| |y2|)
    (RETURN
     (PROGN
      (SETQ |b| (CADR . #1=(|u|)))
      (SETQ |a| (CADDR . #1#))
      (SETQ |w| (|vConcatWidth| |u|))
      (SETQ |d| (APP "(" |x| |y| |d|))
      (SETQ |x| (+ |x| 1))
      (SETQ |y1| (- |y| (|height| |a|)))
      (SETQ |xoff| (QUOTIENT (- |w| (WIDTH |a|)) 2))
      (SETQ |d| (APP |a| (+ |x| |xoff|) |y1| |d|))
      (SETQ |y2| (+ |y| (|height| |b|)))
      (SETQ |xoff| (QUOTIENT (- |w| (WIDTH |b|)) 2))
      (SETQ |d| (APP |b| (+ |x| |xoff|) |y2| |d|))
      (SETQ |x| (+ |x| |w|))
      (APP ")" |x| |y| |d|)))))

; vConcatSub u ==
;   null rest u => 0
;   subspan u.1 + +/[height a for a in CDDR u]

(DEFUN |vConcatSub| (|u|)
  (PROG ()
    (RETURN
     (COND ((NULL (CDR |u|)) 0)
           (#1='T
            (+ (|subspan| (ELT |u| 1))
               ((LAMBDA (|bfVar#112| |bfVar#111| |a|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#111|)
                         (PROGN (SETQ |a| (CAR |bfVar#111|)) NIL))
                     (RETURN |bfVar#112|))
                    (#1# (SETQ |bfVar#112| (+ |bfVar#112| (|height| |a|)))))
                   (SETQ |bfVar#111| (CDR |bfVar#111|))))
                0 (CDDR |u|) NIL)))))))

; vConcatSuper u ==
;   null rest u => 0
;   superspan u.1

(DEFUN |vConcatSuper| (|u|)
  (PROG () (RETURN (COND ((NULL (CDR |u|)) 0) ('T (|superspan| (ELT |u| 1)))))))

; vConcatWidth u ==
;   w := 0
;   for a in rest u repeat if (wa := WIDTH a) > w then w := wa
;   w

(DEFUN |vConcatWidth| (|u|)
  (PROG (|w| |wa|)
    (RETURN
     (PROGN
      (SETQ |w| 0)
      ((LAMBDA (|bfVar#113| |a|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#113|) (PROGN (SETQ |a| (CAR |bfVar#113|)) NIL))
            (RETURN NIL))
           ('T (COND ((< |w| (SETQ |wa| (WIDTH |a|))) (SETQ |w| |wa|)))))
          (SETQ |bfVar#113| (CDR |bfVar#113|))))
       (CDR |u|) NIL)
      |w|))))

; binomialSub u ==  height u.2 + 1

(DEFUN |binomialSub| (|u|) (PROG () (RETURN (+ (|height| (ELT |u| 2)) 1))))

; binomialSuper u == height u.1 + 1

(DEFUN |binomialSuper| (|u|) (PROG () (RETURN (+ (|height| (ELT |u| 1)) 1))))

; binomialWidth u == 2 + MAX(WIDTH u.1, WIDTH u.2)

(DEFUN |binomialWidth| (|u|)
  (PROG () (RETURN (+ 2 (MAX (WIDTH (ELT |u| 1)) (WIDTH (ELT |u| 2)))))))

; primeApp(u, x, y, di) ==
;     ["PRIME", a, b] := u
;     superSubApp(["SUPERSUB", a, '" ", b], x, y, di)

(DEFUN |primeApp| (|u| |x| |y| |di|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|u|)))
      (SETQ |b| (CADDR . #1#))
      (|superSubApp| (LIST 'SUPERSUB |a| " " |b|) |x| |y| |di|)))))

; primeSub(u) ==
;     ["PRIME", a, b] := u
;     superSubSub(["SUPERSUB", a, '" ", b])

(DEFUN |primeSub| (|u|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|u|)))
      (SETQ |b| (CADDR . #1#))
      (|superSubSub| (LIST 'SUPERSUB |a| " " |b|))))))

; primeSuper(u) ==
;     ["PRIME", a, b] := u
;     superSubSuper(["SUPERSUB", a, '" ", b])

(DEFUN |primeSuper| (|u|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|u|)))
      (SETQ |b| (CADDR . #1#))
      (|superSubSuper| (LIST 'SUPERSUB |a| " " |b|))))))

; primeWidth(u) ==
;     ["PRIME", a, b] := u
;     superSubWidth(["SUPERSUB", a, '" ", b])

(DEFUN |primeWidth| (|u|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|u|)))
      (SETQ |b| (CADDR . #1#))
      (|superSubWidth| (LIST 'SUPERSUB |a| " " |b|))))))

; mathPrint u ==
;   if not $collectOutput then TERPRI(get_algebra_stream())
;   (u := STRINGP mathPrint1(mathPrintTran u, nil) =>
;    PSTRING u; nil)

(DEFUN |mathPrint| (|u|)
  (PROG ()
    (RETURN
     (PROGN
      (COND ((NULL |$collectOutput|) (TERPRI (|get_algebra_stream|))))
      (COND
       ((SETQ |u| (STRINGP (|mathPrint1| (|mathPrintTran| |u|) NIL)))
        (PSTRING |u|))
       ('T NIL))))))

; mathPrintTran u ==
;   atom u => u
;   for x in tails u repeat
;       rplac(first x, mathPrintTran first x)
;   u

(DEFUN |mathPrintTran| (|u|)
  (PROG ()
    (RETURN
     (COND ((ATOM |u|) |u|)
           (#1='T
            (PROGN
             ((LAMBDA (|x|)
                (LOOP
                 (COND ((ATOM |x|) (RETURN NIL))
                       (#1# (|rplac| (CAR |x|) (|mathPrintTran| (CAR |x|)))))
                 (SETQ |x| (CDR |x|))))
              |u|)
             |u|))))))

; mathPrint1(x,fg) ==
;   if fg and not $collectOutput then TERPRI(get_algebra_stream())
;   maPrin x
;   if fg and not $collectOutput then TERPRI(get_algebra_stream())

(DEFUN |mathPrint1| (|x| |fg|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((AND |fg| (NULL |$collectOutput|)) (TERPRI (|get_algebra_stream|))))
      (|maPrin| |x|)
      (COND
       ((AND |fg| (NULL |$collectOutput|)) (TERPRI (|get_algebra_stream|))))))))

; maPrin u ==
;   null u => nil
;   $highlightDelta := 0
;   c := CATCH('outputFailure,charybdis(u, $MARGIN, $LINELENGTH))
;   c ~= 'outputFailure => c
;   sayKeyedMsg("S2IX0009",NIL)
;   u is ['EQUATNUM,num,form] or u is [['EQUATNUM,:.],num,form] =>
;     charybdis(['EQUATNUM,num], $MARGIN, $LINELENGTH)
;     if not $collectOutput then
;       TERPRI(get_algebra_stream())
;       PRETTYPRINT(form, get_algebra_stream())
;     form
;   if not $collectOutput then PRETTYPRINT(u, get_algebra_stream())
;   nil

(DEFUN |maPrin| (|u|)
  (PROG (|c| |ISTMP#1| |num| |ISTMP#2| |form| |ISTMP#3|)
    (RETURN
     (COND ((NULL |u|) NIL)
           (#1='T
            (PROGN
             (SETQ |$highlightDelta| 0)
             (SETQ |c|
                     (CATCH '|outputFailure|
                       (|charybdis| |u| $MARGIN $LINELENGTH)))
             (COND ((NOT (EQ |c| '|outputFailure|)) |c|)
                   (#1#
                    (PROGN
                     (|sayKeyedMsg| 'S2IX0009 NIL)
                     (COND
                      ((OR
                        (AND (CONSP |u|) (EQ (CAR |u|) 'EQUATNUM)
                             (PROGN
                              (SETQ |ISTMP#1| (CDR |u|))
                              (AND (CONSP |ISTMP#1|)
                                   (PROGN
                                    (SETQ |num| (CAR |ISTMP#1|))
                                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                    (AND (CONSP |ISTMP#2|)
                                         (EQ (CDR |ISTMP#2|) NIL)
                                         (PROGN
                                          (SETQ |form| (CAR |ISTMP#2|))
                                          #1#))))))
                        (AND (CONSP |u|)
                             (PROGN
                              (SETQ |ISTMP#1| (CAR |u|))
                              (AND (CONSP |ISTMP#1|)
                                   (EQ (CAR |ISTMP#1|) 'EQUATNUM)))
                             (PROGN
                              (SETQ |ISTMP#2| (CDR |u|))
                              (AND (CONSP |ISTMP#2|)
                                   (PROGN
                                    (SETQ |num| (CAR |ISTMP#2|))
                                    (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                    (AND (CONSP |ISTMP#3|)
                                         (EQ (CDR |ISTMP#3|) NIL)
                                         (PROGN
                                          (SETQ |form| (CAR |ISTMP#3|))
                                          #1#)))))))
                       (PROGN
                        (|charybdis| (LIST 'EQUATNUM |num|) $MARGIN
                         $LINELENGTH)
                        (COND
                         ((NULL |$collectOutput|)
                          (TERPRI (|get_algebra_stream|))
                          (PRETTYPRINT |form| (|get_algebra_stream|))))
                        |form|))
                      (#1#
                       (PROGN
                        (COND
                         ((NULL |$collectOutput|)
                          (PRETTYPRINT |u| (|get_algebra_stream|))))
                        NIL))))))))))))

; clear_highlight() ==
;     $displaySetValue : local := nil
;     $saveHighlight := $highlightAllowed
;     $highlightAllowed := false
;     $saveSpecialchars := $specialCharacters
;     setOutputCharacters(["plain"])

(DEFUN |clear_highlight| ()
  (PROG (|$displaySetValue|)
    (DECLARE (SPECIAL |$displaySetValue|))
    (RETURN
     (PROGN
      (SETQ |$displaySetValue| NIL)
      (SETQ |$saveHighlight| |$highlightAllowed|)
      (SETQ |$highlightAllowed| NIL)
      (SETQ |$saveSpecialchars| |$specialCharacters|)
      (|setOutputCharacters| (LIST '|plain|))))))

; reset_highlight() ==
;     $highlightAllowed := $saveHighlight
;     $specialCharacters := $saveSpecialchars

(DEFUN |reset_highlight| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$highlightAllowed| |$saveHighlight|)
      (SETQ |$specialCharacters| |$saveSpecialchars|)))))

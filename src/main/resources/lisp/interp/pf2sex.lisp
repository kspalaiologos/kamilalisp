
; )package "BOOT"

(IN-PACKAGE "BOOT")

; $dotdot := INTERN('"..", '"BOOT")

(EVAL-WHEN (EVAL LOAD) (SETQ |$dotdot| (INTERN ".." "BOOT")))

; pf2Sex pf ==
;   intUnsetQuiet()
;   $insideRule:local := false
;   $insideApplication: local := false
;   $insideSEQ: local := false
;   pf2Sex1 pf

(DEFUN |pf2Sex| (|pf|)
  (PROG (|$insideSEQ| |$insideApplication| |$insideRule|)
    (DECLARE (SPECIAL |$insideSEQ| |$insideApplication| |$insideRule|))
    (RETURN
     (PROGN
      (|intUnsetQuiet|)
      (SETQ |$insideRule| NIL)
      (SETQ |$insideApplication| NIL)
      (SETQ |$insideSEQ| NIL)
      (|pf2Sex1| |pf|)))))

; pf2Sex1 pf ==
;   pfNothing? pf =>
;     "noBranch"
;   pfSymbol? pf =>
;     $insideRule = 'left =>
;       s := pfSymbolSymbol pf
;       ["constant", ["QUOTE", s]]
;     ["QUOTE", pfSymbolSymbol pf]
;   pfLiteral? pf =>
;     pfLiteral2Sex pf
;   pfId? pf =>
;     $insideRule =>
;       s := pfIdSymbol pf
;       SymMemQ(s, '(%pi %e %i)) => s
;       ["QUOTE", s]
;     pfIdSymbol pf
;   pfApplication? pf =>
;     pfApplication2Sex pf
;   pfTuple? pf =>
;     ["Tuple", :[pf2Sex1 x for x in pf0TupleParts pf]]
;   pfIf? pf =>
;     ['IF, pf2Sex1 pfIfCond pf, pf2Sex1 pfIfThen pf, pf2Sex1 pfIfElse pf]
;   pfTagged? pf =>
;     tag := pfTaggedTag pf
;     tagPart :=
;       pfTuple? tag =>
;         ['Tuple, :[pf2Sex1 arg for arg in pf0TupleParts tag]]
;       pf2Sex1 tag
;     [":", tagPart, pf2Sex1 pfTaggedExpr pf]
;   pfCoerceto? pf =>
;     ["::", pf2Sex1 pfCoercetoExpr pf, pf2Sex1 pfCoercetoType pf]
;   pfPretend? pf =>
;     ["pretend", pf2Sex1 pfPretendExpr pf, pf2Sex1 pfPretendType pf]
;   pfFromdom? pf =>
;     op := opTran  pf2Sex1 pfFromdomWhat pf
; --  if op = "braceFromCurly" then op := "brace"
;     if op = "braceFromCurly" then op := "SEQ"
;     ["$elt", pf2Sex1 pfFromdomDomain pf, op]
;   pfSequence? pf =>
;     pfSequence2Sex pf
;   pfExit? pf =>
;     $insideSEQ => ["exit", pf2Sex1 pfExitCond pf, pf2Sex1 pfExitExpr pf]
;     ["IF", pf2Sex1 pfExitCond pf, pf2Sex1 pfExitExpr pf, "noBranch"]
;   pfLoop? pf =>
;     ["REPEAT", :loopIters2Sex  pf0LoopIterators pf]
;   pfCollect? pf =>
;     pfCollect2Sex pf
;   pfForin? pf =>
;     ["IN", :[pf2Sex1 x for x in pf0ForinLhs pf], pf2Sex1 pfForinWhole pf]
;   pfWhile? pf =>
;     ["WHILE", pf2Sex1 pfWhileCond pf]
;   pfSuchthat? pf =>
;     $insideRule = 'left =>
;       keyedSystemError("S2GE0017", ['"pf2Sex1: pfSuchThat"])
;     ["|", pf2Sex1 pfSuchthatCond pf]
;   pfDo? pf =>
;     pf2Sex1 pfDoBody pf
;   pfTyped? pf =>
;     type := pfTypedType pf
;     pfNothing? type => pf2Sex1 pfTypedId pf
;     [":", pf2Sex1 pfTypedId pf, pf2Sex1 pfTypedType pf]
;   pfAssign? pf =>
;     idList := [pf2Sex1 x for x in pf0AssignLhsItems pf]
;     if #idList ~= 1 then idList := ['Tuple, :idList]
;     else idList := first idList
;     ["LET", idList, pf2Sex1 pfAssignRhs pf]
;   pfDefinition? pf =>
;     pfDefinition2Sex pf
;   pfLambda? pf =>
;     pfLambda2Sex pf
;   pfMLambda? pf =>
;     "/throwAway"
;   pfRestrict? pf =>
;     ["@", pf2Sex1 pfRestrictExpr pf, pf2Sex1 pfRestrictType pf]
;   pfFree? pf =>
;     ['free, :[pf2Sex1 item for item in pf0FreeItems pf]]
;   pfLocal? pf =>
;     ['local, :[pf2Sex1 item for item in pf0LocalItems pf]]
;   pfWrong? pf =>
;    spadThrow()
;   pfAnd? pf =>
;     ["and", pf2Sex1 pfAndLeft pf, pf2Sex1 pfAndRight pf]
;   pfOr? pf =>
;     ["or", pf2Sex1 pfOrLeft pf, pf2Sex1 pfOrRight pf]
;   pfNot? pf =>
;     ["not", pf2Sex1 pfNotArg pf]
;   pfNovalue? pf =>
;     intSetQuiet()
;     ["SEQ", pf2Sex1 pfNovalueExpr pf]
;   pfRule? pf =>
;     pfRule2Sex pf
;   pfBreak? pf =>
;     ["break", pfBreakFrom pf]
;   pfMacro? pf =>
;     "/throwAway"
;   pfReturn? pf =>
;     ["return", pf2Sex1 pfReturnExpr pf]
;   pfIterate? pf =>
;     ["iterate"]
;   pfWhere? pf =>
;     args := [pf2Sex1 p for p in pf0WhereContext pf]
;     #args = 1 =>
;       ["where", pf2Sex1 pfWhereExpr pf, :args]
;     ["where", pf2Sex1 pfWhereExpr pf, ["SEQ", :args]]
;
;   -- under strange circumstances/piling, system commands can wind
;   -- up in expressions. This just passes it through as a string for
;   -- the user to figure out what happened.
;   pfAbSynOp(pf) = "command" => tokPart(pf)
;
;   keyedSystemError("S2GE0017", ['"pf2Sex1"])

(DEFUN |pf2Sex1| (|pf|)
  (PROG (|s| |tag| |tagPart| |op| |type| |idList| |args|)
    (RETURN
     (COND ((|pfNothing?| |pf|) '|noBranch|)
           ((|pfSymbol?| |pf|)
            (COND
             ((EQ |$insideRule| '|left|)
              (PROGN
               (SETQ |s| (|pfSymbolSymbol| |pf|))
               (LIST '|constant| (LIST 'QUOTE |s|))))
             (#1='T (LIST 'QUOTE (|pfSymbolSymbol| |pf|)))))
           ((|pfLiteral?| |pf|) (|pfLiteral2Sex| |pf|))
           ((|pfId?| |pf|)
            (COND
             (|$insideRule|
              (PROGN
               (SETQ |s| (|pfIdSymbol| |pf|))
               (COND ((|SymMemQ| |s| '(|%pi| |%e| |%i|)) |s|)
                     (#1# (LIST 'QUOTE |s|)))))
             (#1# (|pfIdSymbol| |pf|))))
           ((|pfApplication?| |pf|) (|pfApplication2Sex| |pf|))
           ((|pfTuple?| |pf|)
            (CONS '|Tuple|
                  ((LAMBDA (|bfVar#2| |bfVar#1| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#1|)
                            (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
                        (RETURN (NREVERSE |bfVar#2|)))
                       (#1# (SETQ |bfVar#2| (CONS (|pf2Sex1| |x|) |bfVar#2|))))
                      (SETQ |bfVar#1| (CDR |bfVar#1|))))
                   NIL (|pf0TupleParts| |pf|) NIL)))
           ((|pfIf?| |pf|)
            (LIST 'IF (|pf2Sex1| (|pfIfCond| |pf|))
                  (|pf2Sex1| (|pfIfThen| |pf|)) (|pf2Sex1| (|pfIfElse| |pf|))))
           ((|pfTagged?| |pf|)
            (PROGN
             (SETQ |tag| (|pfTaggedTag| |pf|))
             (SETQ |tagPart|
                     (COND
                      ((|pfTuple?| |tag|)
                       (CONS '|Tuple|
                             ((LAMBDA (|bfVar#4| |bfVar#3| |arg|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#3|)
                                       (PROGN
                                        (SETQ |arg| (CAR |bfVar#3|))
                                        NIL))
                                   (RETURN (NREVERSE |bfVar#4|)))
                                  (#1#
                                   (SETQ |bfVar#4|
                                           (CONS (|pf2Sex1| |arg|)
                                                 |bfVar#4|))))
                                 (SETQ |bfVar#3| (CDR |bfVar#3|))))
                              NIL (|pf0TupleParts| |tag|) NIL)))
                      (#1# (|pf2Sex1| |tag|))))
             (LIST '|:| |tagPart| (|pf2Sex1| (|pfTaggedExpr| |pf|)))))
           ((|pfCoerceto?| |pf|)
            (LIST '|::| (|pf2Sex1| (|pfCoercetoExpr| |pf|))
                  (|pf2Sex1| (|pfCoercetoType| |pf|))))
           ((|pfPretend?| |pf|)
            (LIST '|pretend| (|pf2Sex1| (|pfPretendExpr| |pf|))
                  (|pf2Sex1| (|pfPretendType| |pf|))))
           ((|pfFromdom?| |pf|)
            (PROGN
             (SETQ |op| (|opTran| (|pf2Sex1| (|pfFromdomWhat| |pf|))))
             (COND ((EQ |op| '|braceFromCurly|) (SETQ |op| 'SEQ)))
             (LIST '|$elt| (|pf2Sex1| (|pfFromdomDomain| |pf|)) |op|)))
           ((|pfSequence?| |pf|) (|pfSequence2Sex| |pf|))
           ((|pfExit?| |pf|)
            (COND
             (|$insideSEQ|
              (LIST '|exit| (|pf2Sex1| (|pfExitCond| |pf|))
                    (|pf2Sex1| (|pfExitExpr| |pf|))))
             (#1#
              (LIST 'IF (|pf2Sex1| (|pfExitCond| |pf|))
                    (|pf2Sex1| (|pfExitExpr| |pf|)) '|noBranch|))))
           ((|pfLoop?| |pf|)
            (CONS 'REPEAT (|loopIters2Sex| (|pf0LoopIterators| |pf|))))
           ((|pfCollect?| |pf|) (|pfCollect2Sex| |pf|))
           ((|pfForin?| |pf|)
            (CONS 'IN
                  (APPEND
                   ((LAMBDA (|bfVar#6| |bfVar#5| |x|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#5|)
                             (PROGN (SETQ |x| (CAR |bfVar#5|)) NIL))
                         (RETURN (NREVERSE |bfVar#6|)))
                        (#1#
                         (SETQ |bfVar#6| (CONS (|pf2Sex1| |x|) |bfVar#6|))))
                       (SETQ |bfVar#5| (CDR |bfVar#5|))))
                    NIL (|pf0ForinLhs| |pf|) NIL)
                   (CONS (|pf2Sex1| (|pfForinWhole| |pf|)) NIL))))
           ((|pfWhile?| |pf|) (LIST 'WHILE (|pf2Sex1| (|pfWhileCond| |pf|))))
           ((|pfSuchthat?| |pf|)
            (COND
             ((EQ |$insideRule| '|left|)
              (|keyedSystemError| 'S2GE0017 (LIST "pf2Sex1: pfSuchThat")))
             (#1# (LIST '|\|| (|pf2Sex1| (|pfSuchthatCond| |pf|))))))
           ((|pfDo?| |pf|) (|pf2Sex1| (|pfDoBody| |pf|)))
           ((|pfTyped?| |pf|)
            (PROGN
             (SETQ |type| (|pfTypedType| |pf|))
             (COND ((|pfNothing?| |type|) (|pf2Sex1| (|pfTypedId| |pf|)))
                   (#1#
                    (LIST '|:| (|pf2Sex1| (|pfTypedId| |pf|))
                          (|pf2Sex1| (|pfTypedType| |pf|)))))))
           ((|pfAssign?| |pf|)
            (PROGN
             (SETQ |idList|
                     ((LAMBDA (|bfVar#8| |bfVar#7| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#7|)
                               (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                           (RETURN (NREVERSE |bfVar#8|)))
                          (#1#
                           (SETQ |bfVar#8| (CONS (|pf2Sex1| |x|) |bfVar#8|))))
                         (SETQ |bfVar#7| (CDR |bfVar#7|))))
                      NIL (|pf0AssignLhsItems| |pf|) NIL))
             (COND
              ((NOT (EQL (LENGTH |idList|) 1))
               (SETQ |idList| (CONS '|Tuple| |idList|)))
              (#1# (SETQ |idList| (CAR |idList|))))
             (LIST 'LET |idList| (|pf2Sex1| (|pfAssignRhs| |pf|)))))
           ((|pfDefinition?| |pf|) (|pfDefinition2Sex| |pf|))
           ((|pfLambda?| |pf|) (|pfLambda2Sex| |pf|))
           ((|pfMLambda?| |pf|) '|/throwAway|)
           ((|pfRestrict?| |pf|)
            (LIST '@ (|pf2Sex1| (|pfRestrictExpr| |pf|))
                  (|pf2Sex1| (|pfRestrictType| |pf|))))
           ((|pfFree?| |pf|)
            (CONS '|free|
                  ((LAMBDA (|bfVar#10| |bfVar#9| |item|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#9|)
                            (PROGN (SETQ |item| (CAR |bfVar#9|)) NIL))
                        (RETURN (NREVERSE |bfVar#10|)))
                       (#1#
                        (SETQ |bfVar#10|
                                (CONS (|pf2Sex1| |item|) |bfVar#10|))))
                      (SETQ |bfVar#9| (CDR |bfVar#9|))))
                   NIL (|pf0FreeItems| |pf|) NIL)))
           ((|pfLocal?| |pf|)
            (CONS '|local|
                  ((LAMBDA (|bfVar#12| |bfVar#11| |item|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#11|)
                            (PROGN (SETQ |item| (CAR |bfVar#11|)) NIL))
                        (RETURN (NREVERSE |bfVar#12|)))
                       (#1#
                        (SETQ |bfVar#12|
                                (CONS (|pf2Sex1| |item|) |bfVar#12|))))
                      (SETQ |bfVar#11| (CDR |bfVar#11|))))
                   NIL (|pf0LocalItems| |pf|) NIL)))
           ((|pfWrong?| |pf|) (|spadThrow|))
           ((|pfAnd?| |pf|)
            (LIST '|and| (|pf2Sex1| (|pfAndLeft| |pf|))
                  (|pf2Sex1| (|pfAndRight| |pf|))))
           ((|pfOr?| |pf|)
            (LIST '|or| (|pf2Sex1| (|pfOrLeft| |pf|))
                  (|pf2Sex1| (|pfOrRight| |pf|))))
           ((|pfNot?| |pf|) (LIST '|not| (|pf2Sex1| (|pfNotArg| |pf|))))
           ((|pfNovalue?| |pf|)
            (PROGN
             (|intSetQuiet|)
             (LIST 'SEQ (|pf2Sex1| (|pfNovalueExpr| |pf|)))))
           ((|pfRule?| |pf|) (|pfRule2Sex| |pf|))
           ((|pfBreak?| |pf|) (LIST '|break| (|pfBreakFrom| |pf|)))
           ((|pfMacro?| |pf|) '|/throwAway|)
           ((|pfReturn?| |pf|)
            (LIST '|return| (|pf2Sex1| (|pfReturnExpr| |pf|))))
           ((|pfIterate?| |pf|) (LIST '|iterate|))
           ((|pfWhere?| |pf|)
            (PROGN
             (SETQ |args|
                     ((LAMBDA (|bfVar#14| |bfVar#13| |p|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#13|)
                               (PROGN (SETQ |p| (CAR |bfVar#13|)) NIL))
                           (RETURN (NREVERSE |bfVar#14|)))
                          (#1#
                           (SETQ |bfVar#14|
                                   (CONS (|pf2Sex1| |p|) |bfVar#14|))))
                         (SETQ |bfVar#13| (CDR |bfVar#13|))))
                      NIL (|pf0WhereContext| |pf|) NIL))
             (COND
              ((EQL (LENGTH |args|) 1)
               (CONS '|where| (CONS (|pf2Sex1| (|pfWhereExpr| |pf|)) |args|)))
              (#1#
               (LIST '|where| (|pf2Sex1| (|pfWhereExpr| |pf|))
                     (CONS 'SEQ |args|))))))
           ((EQ (|pfAbSynOp| |pf|) '|command|) (|tokPart| |pf|))
           (#1# (|keyedSystemError| 'S2GE0017 (LIST "pf2Sex1")))))))

; pfLiteral2Sex pf ==
;   type := pfLiteralClass pf
;   type = 'integer =>
;     READ_-FROM_-STRING pfLiteralString pf
;   type = 'string or type = 'char =>
;     pfLiteralString pf
;   type = 'float =>
;     float2Sex pfLiteralString pf
;   type = 'symbol =>
;     $insideRule =>
;       s := pfSymbolSymbol pf
;       ["QUOTE", s]
;     pfSymbolSymbol pf
;   type = 'expression =>
;       ["QUOTE", pfLeafToken pf]
;   keyedSystemError("S2GE0017", ['"pfLiteral2Sex: unexpected form"])

(DEFUN |pfLiteral2Sex| (|pf|)
  (PROG (|type| |s|)
    (RETURN
     (PROGN
      (SETQ |type| (|pfLiteralClass| |pf|))
      (COND
       ((EQ |type| '|integer|) (READ-FROM-STRING (|pfLiteralString| |pf|)))
       ((OR (EQ |type| '|string|) (EQ |type| '|char|))
        (|pfLiteralString| |pf|))
       ((EQ |type| '|float|) (|float2Sex| (|pfLiteralString| |pf|)))
       ((EQ |type| '|symbol|)
        (COND
         (|$insideRule|
          (PROGN (SETQ |s| (|pfSymbolSymbol| |pf|)) (LIST 'QUOTE |s|)))
         (#1='T (|pfSymbolSymbol| |pf|))))
       ((EQ |type| '|expression|) (LIST 'QUOTE (|pfLeafToken| |pf|)))
       (#1#
        (|keyedSystemError| 'S2GE0017
         (LIST "pfLiteral2Sex: unexpected form"))))))))

; symEqual(sym, sym2) == EQ(sym, sym2)

(DEFUN |symEqual| (|sym| |sym2|) (PROG () (RETURN (EQ |sym| |sym2|))))

; SymMemQ(sy, l) == MEMQ(sy, l)

(DEFUN |SymMemQ| (|sy| |l|) (PROG () (RETURN (MEMQ |sy| |l|))))

; pfOp2Sex pf ==
;   op := pf2Sex1 pf
;   op is ["QUOTE", realOp] =>
;     $insideRule = 'left => realOp
;     $insideRule = 'right => realOp
;     symEqual(realOp, "|") => realOp
;     symEqual(realOp, ":") => realOp
;     symEqual(realOp, "?") => realOp
;     op
;   op

(DEFUN |pfOp2Sex| (|pf|)
  (PROG (|op| |ISTMP#1| |realOp|)
    (RETURN
     (PROGN
      (SETQ |op| (|pf2Sex1| |pf|))
      (COND
       ((AND (CONSP |op|) (EQ (CAR |op|) 'QUOTE)
             (PROGN
              (SETQ |ISTMP#1| (CDR |op|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |realOp| (CAR |ISTMP#1|)) #1='T))))
        (COND ((EQ |$insideRule| '|left|) |realOp|)
              ((EQ |$insideRule| '|right|) |realOp|)
              ((|symEqual| |realOp| '|\||) |realOp|)
              ((|symEqual| |realOp| '|:|) |realOp|)
              ((|symEqual| |realOp| '?) |realOp|) (#1# |op|)))
       (#1# |op|))))))

; pfApplication2Sex pf ==
;   $insideApplication: local := true
;   op := pfOp2Sex pfApplicationOp pf
;   op := opTran op
;   op = "->" =>
;     args := pf0TupleParts pfApplicationArg pf
;     if pfTuple? first args then
;       typeList := [pf2Sex1 arg for arg in pf0TupleParts first args]
;     else
;       typeList := [pf2Sex1 first args]
;     args := [pf2Sex1 CADR args, :typeList]
;     ["Mapping", :args]
;   symEqual(op, ":") and $insideRule = 'left =>
;     ["multiple", pf2Sex pfApplicationArg pf]
;   symEqual(op, "?") and $insideRule = 'left =>
;     ["optional", pf2Sex pfApplicationArg pf]
;   args := pfApplicationArg pf
;   pfTuple? args =>
;     symEqual(op, "|") and $insideRule = 'left =>
;       pfSuchThat2Sex args
;     argSex := rest pf2Sex1 args
;     symEqual(op, "AND") =>
;       ["and", first argSex, CADR argSex]
;     symEqual(op, "OR") =>
;       ["or", first argSex, CADR argSex]
;     symEqual(op, "Iterate") =>
;       ["iterate"]
;     symEqual(op, "by") =>
;       ["BY", :argSex]
;     symEqual(op, "braceFromCurly") =>
; --    ["brace", ["construct", :argSex]]
;       argSex is ["SEQ",:.] => argSex
;       ["SEQ", :argSex]
;     op is [qt, realOp] and symEqual(qt, "QUOTE") =>
;        ["applyQuote", op, :argSex]
;     val := hasOptArgs? argSex => [op, :val]
;     [op, :argSex]
;   op is [qt, realOp] and symEqual(qt, "QUOTE") =>
;      ["applyQuote", op, pf2Sex1 args]
;   symEqual(op, "braceFromCurly") =>
; --  ["brace", ["construct", pf2Sex1 args]]
;     x := pf2Sex1 args
;     x is ["SEQ", :.] => x
;     ["SEQ", x]
;   symEqual(op, "by") =>
;       ["BY", pf2Sex1 args]
;   [op, pf2Sex1 args]

(DEFUN |pfApplication2Sex| (|pf|)
  (PROG (|$insideApplication| |x| |val| |realOp| |ISTMP#1| |qt| |argSex|
         |typeList| |args| |op|)
    (DECLARE (SPECIAL |$insideApplication|))
    (RETURN
     (PROGN
      (SETQ |$insideApplication| T)
      (SETQ |op| (|pfOp2Sex| (|pfApplicationOp| |pf|)))
      (SETQ |op| (|opTran| |op|))
      (COND
       ((EQ |op| '->)
        (PROGN
         (SETQ |args| (|pf0TupleParts| (|pfApplicationArg| |pf|)))
         (COND
          ((|pfTuple?| (CAR |args|))
           (SETQ |typeList|
                   ((LAMBDA (|bfVar#16| |bfVar#15| |arg|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#15|)
                             (PROGN (SETQ |arg| (CAR |bfVar#15|)) NIL))
                         (RETURN (NREVERSE |bfVar#16|)))
                        (#1='T
                         (SETQ |bfVar#16|
                                 (CONS (|pf2Sex1| |arg|) |bfVar#16|))))
                       (SETQ |bfVar#15| (CDR |bfVar#15|))))
                    NIL (|pf0TupleParts| (CAR |args|)) NIL)))
          (#1# (SETQ |typeList| (LIST (|pf2Sex1| (CAR |args|))))))
         (SETQ |args| (CONS (|pf2Sex1| (CADR |args|)) |typeList|))
         (CONS '|Mapping| |args|)))
       ((AND (|symEqual| |op| '|:|) (EQ |$insideRule| '|left|))
        (LIST '|multiple| (|pf2Sex| (|pfApplicationArg| |pf|))))
       ((AND (|symEqual| |op| '?) (EQ |$insideRule| '|left|))
        (LIST '|optional| (|pf2Sex| (|pfApplicationArg| |pf|))))
       (#1#
        (PROGN
         (SETQ |args| (|pfApplicationArg| |pf|))
         (COND
          ((|pfTuple?| |args|)
           (COND
            ((AND (|symEqual| |op| '|\||) (EQ |$insideRule| '|left|))
             (|pfSuchThat2Sex| |args|))
            (#1#
             (PROGN
              (SETQ |argSex| (CDR (|pf2Sex1| |args|)))
              (COND
               ((|symEqual| |op| 'AND)
                (LIST '|and| (CAR |argSex|) (CADR |argSex|)))
               ((|symEqual| |op| 'OR)
                (LIST '|or| (CAR |argSex|) (CADR |argSex|)))
               ((|symEqual| |op| '|Iterate|) (LIST '|iterate|))
               ((|symEqual| |op| '|by|) (CONS 'BY |argSex|))
               ((|symEqual| |op| '|braceFromCurly|)
                (COND
                 ((AND (CONSP |argSex|) (EQ (CAR |argSex|) 'SEQ)) |argSex|)
                 (#1# (CONS 'SEQ |argSex|))))
               ((AND (CONSP |op|)
                     (PROGN
                      (SETQ |qt| (CAR |op|))
                      (SETQ |ISTMP#1| (CDR |op|))
                      (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                           (PROGN (SETQ |realOp| (CAR |ISTMP#1|)) #1#)))
                     (|symEqual| |qt| 'QUOTE))
                (CONS '|applyQuote| (CONS |op| |argSex|)))
               ((SETQ |val| (|hasOptArgs?| |argSex|)) (CONS |op| |val|))
               (#1# (CONS |op| |argSex|)))))))
          ((AND (CONSP |op|)
                (PROGN
                 (SETQ |qt| (CAR |op|))
                 (SETQ |ISTMP#1| (CDR |op|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |realOp| (CAR |ISTMP#1|)) #1#)))
                (|symEqual| |qt| 'QUOTE))
           (LIST '|applyQuote| |op| (|pf2Sex1| |args|)))
          ((|symEqual| |op| '|braceFromCurly|)
           (PROGN
            (SETQ |x| (|pf2Sex1| |args|))
            (COND ((AND (CONSP |x|) (EQ (CAR |x|) 'SEQ)) |x|)
                  (#1# (LIST 'SEQ |x|)))))
          ((|symEqual| |op| '|by|) (LIST 'BY (|pf2Sex1| |args|)))
          (#1# (LIST |op| (|pf2Sex1| |args|)))))))))))

; hasOptArgs? argSex ==
;   nonOpt := nil
;   opt := nil
;   for arg in argSex repeat
;     arg is ["OPTARG", lhs, rhs] =>
;       opt := [[lhs, rhs], :opt]
;     nonOpt := [arg, :nonOpt]
;   null opt => nil
;   NCONC (nreverse nonOpt, [["construct", :nreverse opt]])

(DEFUN |hasOptArgs?| (|argSex|)
  (PROG (|nonOpt| |opt| |ISTMP#1| |lhs| |ISTMP#2| |rhs|)
    (RETURN
     (PROGN
      (SETQ |nonOpt| NIL)
      (SETQ |opt| NIL)
      ((LAMBDA (|bfVar#17| |arg|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#17|) (PROGN (SETQ |arg| (CAR |bfVar#17|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((AND (CONSP |arg|) (EQ (CAR |arg|) 'OPTARG)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |arg|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |lhs| (CAR |ISTMP#1|))
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ |rhs| (CAR |ISTMP#2|)) #1#))))))
              (SETQ |opt| (CONS (LIST |lhs| |rhs|) |opt|)))
             (#1# (SETQ |nonOpt| (CONS |arg| |nonOpt|))))))
          (SETQ |bfVar#17| (CDR |bfVar#17|))))
       |argSex| NIL)
      (COND ((NULL |opt|) NIL)
            (#1#
             (NCONC (NREVERSE |nonOpt|)
                    (LIST (CONS '|construct| (NREVERSE |opt|))))))))))

; pfDefinition2Sex pf ==
;   $insideApplication =>
;     ["OPTARG", pf2Sex1 first pf0DefinitionLhsItems pf,
;      pf2Sex1 pfDefinitionRhs pf]
;   idList := [pf2Sex1 x for x in pf0DefinitionLhsItems pf]
;   #idList ~= 1 =>
;     systemError '"lhs of definition must be a single item in the interpreter"
;   id := first idList
;   rhs := pfDefinitionRhs pf
;   [argList, :body] := pfLambdaTran rhs
;   ["DEF", (argList = 'id => id; [id, :argList]), :body]

(DEFUN |pfDefinition2Sex| (|pf|)
  (PROG (|idList| |id| |rhs| |LETTMP#1| |argList| |body|)
    (RETURN
     (COND
      (|$insideApplication|
       (LIST 'OPTARG (|pf2Sex1| (CAR (|pf0DefinitionLhsItems| |pf|)))
             (|pf2Sex1| (|pfDefinitionRhs| |pf|))))
      (#1='T
       (PROGN
        (SETQ |idList|
                ((LAMBDA (|bfVar#19| |bfVar#18| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#18|)
                          (PROGN (SETQ |x| (CAR |bfVar#18|)) NIL))
                      (RETURN (NREVERSE |bfVar#19|)))
                     (#1# (SETQ |bfVar#19| (CONS (|pf2Sex1| |x|) |bfVar#19|))))
                    (SETQ |bfVar#18| (CDR |bfVar#18|))))
                 NIL (|pf0DefinitionLhsItems| |pf|) NIL))
        (COND
         ((NOT (EQL (LENGTH |idList|) 1))
          (|systemError|
           "lhs of definition must be a single item in the interpreter"))
         (#1#
          (PROGN
           (SETQ |id| (CAR |idList|))
           (SETQ |rhs| (|pfDefinitionRhs| |pf|))
           (SETQ |LETTMP#1| (|pfLambdaTran| |rhs|))
           (SETQ |argList| (CAR |LETTMP#1|))
           (SETQ |body| (CDR |LETTMP#1|))
           (CONS 'DEF
                 (CONS
                  (COND ((EQ |argList| '|id|) |id|)
                        (#1# (CONS |id| |argList|)))
                  |body|)))))))))))

; pfLambdaTran pf ==
;   pfLambda? pf =>
;     argTypeList := nil
;     argList := nil
;     for arg in pf0LambdaArgs pf repeat
;       pfTyped? arg =>
;         argList := [pfCollectArgTran pfTypedId arg, :argList]
;         pfNothing? pfTypedType arg =>
;           argTypeList := [nil, :argTypeList]
;         argTypeList := [pf2Sex1 pfTypedType arg, :argTypeList]
;       systemError '"definition args should be typed"
;     argList := nreverse argList
;     retType :=
;       pfNothing? pfLambdaRets pf => nil
;       pf2Sex1 pfLambdaRets pf
;     argTypeList := [retType, :nreverse argTypeList]
;     [argList, :[argTypeList, [nil for arg in argTypeList],
;       pf2Sex1 pfLambdaBody pf]]
;   ['id, :['(()), '(()), pf2Sex1 pf]]

(DEFUN |pfLambdaTran| (|pf|)
  (PROG (|argTypeList| |argList| |retType|)
    (RETURN
     (COND
      ((|pfLambda?| |pf|)
       (PROGN
        (SETQ |argTypeList| NIL)
        (SETQ |argList| NIL)
        ((LAMBDA (|bfVar#20| |arg|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#20|) (PROGN (SETQ |arg| (CAR |bfVar#20|)) NIL))
              (RETURN NIL))
             (#1='T
              (COND
               ((|pfTyped?| |arg|)
                (PROGN
                 (SETQ |argList|
                         (CONS (|pfCollectArgTran| (|pfTypedId| |arg|))
                               |argList|))
                 (COND
                  ((|pfNothing?| (|pfTypedType| |arg|))
                   (SETQ |argTypeList| (CONS NIL |argTypeList|)))
                  (#1#
                   (SETQ |argTypeList|
                           (CONS (|pf2Sex1| (|pfTypedType| |arg|))
                                 |argTypeList|))))))
               (#1# (|systemError| "definition args should be typed")))))
            (SETQ |bfVar#20| (CDR |bfVar#20|))))
         (|pf0LambdaArgs| |pf|) NIL)
        (SETQ |argList| (NREVERSE |argList|))
        (SETQ |retType|
                (COND ((|pfNothing?| (|pfLambdaRets| |pf|)) NIL)
                      (#1# (|pf2Sex1| (|pfLambdaRets| |pf|)))))
        (SETQ |argTypeList| (CONS |retType| (NREVERSE |argTypeList|)))
        (CONS |argList|
              (LIST |argTypeList|
                    ((LAMBDA (|bfVar#22| |bfVar#21| |arg|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#21|)
                              (PROGN (SETQ |arg| (CAR |bfVar#21|)) NIL))
                          (RETURN (NREVERSE |bfVar#22|)))
                         (#1# (SETQ |bfVar#22| (CONS NIL |bfVar#22|))))
                        (SETQ |bfVar#21| (CDR |bfVar#21|))))
                     NIL |argTypeList| NIL)
                    (|pf2Sex1| (|pfLambdaBody| |pf|))))))
      (#1# (CONS '|id| (LIST '(NIL) '(NIL) (|pf2Sex1| |pf|))))))))

; pfLambda2Sex pf ==
;   [argList, :body] := pfLambdaTran pf
;   ["ADEF", argList, :body]

(DEFUN |pfLambda2Sex| (|pf|)
  (PROG (|LETTMP#1| |argList| |body|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|pfLambdaTran| |pf|))
      (SETQ |argList| (CAR |LETTMP#1|))
      (SETQ |body| (CDR |LETTMP#1|))
      (CONS 'ADEF (CONS |argList| |body|))))))

; pfCollectArgTran pf ==
;   pfCollect? pf =>
;     conds := [pf2Sex1 x for x in pfParts pfCollectIterators pf]
;     id := pf2Sex1 pfCollectBody pf
;     conds is [["|", cond]] =>
;       ["|", id, cond]
;     [id, :conds]
;   pf2Sex1 pf

(DEFUN |pfCollectArgTran| (|pf|)
  (PROG (|conds| |id| |ISTMP#1| |ISTMP#2| |cond|)
    (RETURN
     (COND
      ((|pfCollect?| |pf|)
       (PROGN
        (SETQ |conds|
                ((LAMBDA (|bfVar#24| |bfVar#23| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#23|)
                          (PROGN (SETQ |x| (CAR |bfVar#23|)) NIL))
                      (RETURN (NREVERSE |bfVar#24|)))
                     (#1='T
                      (SETQ |bfVar#24| (CONS (|pf2Sex1| |x|) |bfVar#24|))))
                    (SETQ |bfVar#23| (CDR |bfVar#23|))))
                 NIL (|pfParts| (|pfCollectIterators| |pf|)) NIL))
        (SETQ |id| (|pf2Sex1| (|pfCollectBody| |pf|)))
        (COND
         ((AND (CONSP |conds|) (EQ (CDR |conds|) NIL)
               (PROGN
                (SETQ |ISTMP#1| (CAR |conds|))
                (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|\||)
                     (PROGN
                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                      (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                           (PROGN (SETQ |cond| (CAR |ISTMP#2|)) #1#))))))
          (LIST '|\|| |id| |cond|))
         (#1# (CONS |id| |conds|)))))
      (#1# (|pf2Sex1| |pf|))))))

; opTran op ==
;   op = $dotdot => "SEGMENT"
;   op = "[]" => "construct"
;   op = "{}" => "braceFromCurly"
;   op = "IS" => "is"
;   op

(DEFUN |opTran| (|op|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |op| |$dotdot|) 'SEGMENT) ((EQ |op| '[]) '|construct|)
           ((EQ |op| '{}) '|braceFromCurly|) ((EQ |op| 'IS) '|is|) ('T |op|)))))

; pfSequence2Sex pf ==
;   $insideSEQ:local := true
;   seq := pfSequence2Sex0 [pf2Sex1 x for x in pf0SequenceArgs pf]
;   seq is ["SEQ", :ruleList] and ruleList is [["rule", :.], :.] =>
;     ["ruleset", ["construct", :ruleList]]
;   seq

(DEFUN |pfSequence2Sex| (|pf|)
  (PROG (|$insideSEQ| |ISTMP#1| |ruleList| |seq|)
    (DECLARE (SPECIAL |$insideSEQ|))
    (RETURN
     (PROGN
      (SETQ |$insideSEQ| T)
      (SETQ |seq|
              (|pfSequence2Sex0|
               ((LAMBDA (|bfVar#26| |bfVar#25| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#25|)
                         (PROGN (SETQ |x| (CAR |bfVar#25|)) NIL))
                     (RETURN (NREVERSE |bfVar#26|)))
                    (#1='T
                     (SETQ |bfVar#26| (CONS (|pf2Sex1| |x|) |bfVar#26|))))
                   (SETQ |bfVar#25| (CDR |bfVar#25|))))
                NIL (|pf0SequenceArgs| |pf|) NIL)))
      (COND
       ((AND (CONSP |seq|) (EQ (CAR |seq|) 'SEQ)
             (PROGN (SETQ |ruleList| (CDR |seq|)) #1#) (CONSP |ruleList|)
             (PROGN
              (SETQ |ISTMP#1| (CAR |ruleList|))
              (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|rule|))))
        (LIST '|ruleset| (CONS '|construct| |ruleList|)))
       (#1# |seq|))))))

; pfSequence2Sex0 seqList ==
;   null seqList => "noBranch"
;   seqTranList := []
;   while seqList ~= nil repeat
;     item := first seqList
;     item is ["exit", cond, value] =>
;       item := ["IF", cond, value, pfSequence2Sex0 rest seqList]
;       seqTranList := [item, :seqTranList]
;       seqList := nil
;     seqTranList := [item ,:seqTranList]
;     seqList := rest seqList
;   #seqTranList = 1 => first seqTranList
;   ["SEQ", :nreverse seqTranList]

(DEFUN |pfSequence2Sex0| (|seqList|)
  (PROG (|seqTranList| |item| |ISTMP#1| |cond| |ISTMP#2| |value|)
    (RETURN
     (COND ((NULL |seqList|) '|noBranch|)
           (#1='T
            (PROGN
             (SETQ |seqTranList| NIL)
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT |seqList|) (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |item| (CAR |seqList|))
                         (COND
                          ((AND (CONSP |item|) (EQ (CAR |item|) '|exit|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |item|))
                                 (AND (CONSP |ISTMP#1|)
                                      (PROGN
                                       (SETQ |cond| (CAR |ISTMP#1|))
                                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                       (AND (CONSP |ISTMP#2|)
                                            (EQ (CDR |ISTMP#2|) NIL)
                                            (PROGN
                                             (SETQ |value| (CAR |ISTMP#2|))
                                             #1#))))))
                           (PROGN
                            (SETQ |item|
                                    (LIST 'IF |cond| |value|
                                          (|pfSequence2Sex0| (CDR |seqList|))))
                            (SETQ |seqTranList| (CONS |item| |seqTranList|))
                            (SETQ |seqList| NIL)))
                          (#1#
                           (PROGN
                            (SETQ |seqTranList| (CONS |item| |seqTranList|))
                            (SETQ |seqList| (CDR |seqList|)))))))))))
             (COND ((EQL (LENGTH |seqTranList|) 1) (CAR |seqTranList|))
                   (#1# (CONS 'SEQ (NREVERSE |seqTranList|))))))))))

; intNewFloat() == ["Float"]

(DEFUN |intNewFloat| () (PROG () (RETURN (LIST '|Float|))))

; string_to_int(s) ==  READ_-FROM_-STRING(s)

(DEFUN |string_to_int| (|s|) (PROG () (RETURN (READ-FROM-STRING |s|))))

; float2Sex [i_str, fr_str, e_str] ==
;   int_part := string_to_int(i_str)
;   exp_part := string_to_int(e_str)
;   bfForm := make_float(int_part, string_to_int(fr_str),
;     LENGTH fr_str, exp_part)
;   [., frac, exp] := bfForm
;   [["$elt", intNewFloat(), 'float], frac, exp, 10]

(DEFUN |float2Sex| (|bfVar#27|)
  (PROG (|i_str| |fr_str| |e_str| |int_part| |exp_part| |bfForm| |frac| |exp|)
    (RETURN
     (PROGN
      (SETQ |i_str| (CAR |bfVar#27|))
      (SETQ |fr_str| (CADR . #1=(|bfVar#27|)))
      (SETQ |e_str| (CADDR . #1#))
      (SETQ |int_part| (|string_to_int| |i_str|))
      (SETQ |exp_part| (|string_to_int| |e_str|))
      (SETQ |bfForm|
              (|make_float| |int_part| (|string_to_int| |fr_str|)
               (LENGTH |fr_str|) |exp_part|))
      (SETQ |frac| (CADR . #2=(|bfForm|)))
      (SETQ |exp| (CADDR . #2#))
      (LIST (LIST '|$elt| (|intNewFloat|) '|float|) |frac| |exp| 10)))))

; loopIters2Sex iterList ==
;   result := nil
;   for iter in iterList repeat
;     sex := pf2Sex1 iter
;     sex is ['IN, var, ['SEGMENT, i, ["BY", incr]]] =>
;       result := [['STEP, var, i, incr], :result]
;     sex is ['IN, var, ["BY", ['SEGMENT, i, j], incr]] =>
;       result := [['STEP, var, i, incr, j], :result]
;     sex is ['IN, var, ['SEGMENT, i, j]] =>
;       result := [['STEP, var, i, 1, j], :result]
;     result := [sex, :result]
;   nreverse result

(DEFUN |loopIters2Sex| (|iterList|)
  (PROG (|result| |sex| |ISTMP#1| |var| |ISTMP#2| |ISTMP#3| |ISTMP#4| |i|
         |ISTMP#5| |ISTMP#6| |ISTMP#7| |incr| |j| |ISTMP#8|)
    (RETURN
     (PROGN
      (SETQ |result| NIL)
      ((LAMBDA (|bfVar#28| |iter|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#28|) (PROGN (SETQ |iter| (CAR |bfVar#28|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |sex| (|pf2Sex1| |iter|))
             (COND
              ((AND (CONSP |sex|) (EQ (CAR |sex|) 'IN)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |sex|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |var| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN
                                 (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CAR |ISTMP#3|) 'SEGMENT)
                                      (PROGN
                                       (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                       (AND (CONSP |ISTMP#4|)
                                            (PROGN
                                             (SETQ |i| (CAR |ISTMP#4|))
                                             (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                             (AND (CONSP |ISTMP#5|)
                                                  (EQ (CDR |ISTMP#5|) NIL)
                                                  (PROGN
                                                   (SETQ |ISTMP#6|
                                                           (CAR |ISTMP#5|))
                                                   (AND (CONSP |ISTMP#6|)
                                                        (EQ (CAR |ISTMP#6|)
                                                            'BY)
                                                        (PROGN
                                                         (SETQ |ISTMP#7|
                                                                 (CDR
                                                                  |ISTMP#6|))
                                                         (AND (CONSP |ISTMP#7|)
                                                              (EQ
                                                               (CDR |ISTMP#7|)
                                                               NIL)
                                                              (PROGN
                                                               (SETQ |incr|
                                                                       (CAR
                                                                        |ISTMP#7|))
                                                               #1#))))))))))))))))
               (SETQ |result| (CONS (LIST 'STEP |var| |i| |incr|) |result|)))
              ((AND (CONSP |sex|) (EQ (CAR |sex|) 'IN)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |sex|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |var| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN
                                 (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CAR |ISTMP#3|) 'BY)
                                      (PROGN
                                       (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                       (AND (CONSP |ISTMP#4|)
                                            (PROGN
                                             (SETQ |ISTMP#5| (CAR |ISTMP#4|))
                                             (AND (CONSP |ISTMP#5|)
                                                  (EQ (CAR |ISTMP#5|) 'SEGMENT)
                                                  (PROGN
                                                   (SETQ |ISTMP#6|
                                                           (CDR |ISTMP#5|))
                                                   (AND (CONSP |ISTMP#6|)
                                                        (PROGN
                                                         (SETQ |i|
                                                                 (CAR
                                                                  |ISTMP#6|))
                                                         (SETQ |ISTMP#7|
                                                                 (CDR
                                                                  |ISTMP#6|))
                                                         (AND (CONSP |ISTMP#7|)
                                                              (EQ
                                                               (CDR |ISTMP#7|)
                                                               NIL)
                                                              (PROGN
                                                               (SETQ |j|
                                                                       (CAR
                                                                        |ISTMP#7|))
                                                               #1#)))))))
                                            (PROGN
                                             (SETQ |ISTMP#8| (CDR |ISTMP#4|))
                                             (AND (CONSP |ISTMP#8|)
                                                  (EQ (CDR |ISTMP#8|) NIL)
                                                  (PROGN
                                                   (SETQ |incr|
                                                           (CAR |ISTMP#8|))
                                                   #1#))))))))))))
               (SETQ |result|
                       (CONS (LIST 'STEP |var| |i| |incr| |j|) |result|)))
              ((AND (CONSP |sex|) (EQ (CAR |sex|) 'IN)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |sex|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |var| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN
                                 (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CAR |ISTMP#3|) 'SEGMENT)
                                      (PROGN
                                       (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                       (AND (CONSP |ISTMP#4|)
                                            (PROGN
                                             (SETQ |i| (CAR |ISTMP#4|))
                                             (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                             (AND (CONSP |ISTMP#5|)
                                                  (EQ (CDR |ISTMP#5|) NIL)
                                                  (PROGN
                                                   (SETQ |j| (CAR |ISTMP#5|))
                                                   #1#))))))))))))
               (SETQ |result| (CONS (LIST 'STEP |var| |i| 1 |j|) |result|)))
              (#1# (SETQ |result| (CONS |sex| |result|)))))))
          (SETQ |bfVar#28| (CDR |bfVar#28|))))
       |iterList| NIL)
      (NREVERSE |result|)))))

; pfCollect2Sex pf ==
;   sex := ["COLLECT", :loopIters2Sex pfParts pfCollectIterators pf,
;     pf2Sex1 pfCollectBody pf]
;   sex is ["COLLECT", ["|", cond], var] and SYMBOLP var =>
;     ["|", var, cond]
;   sex

(DEFUN |pfCollect2Sex| (|pf|)
  (PROG (|sex| |ISTMP#1| |ISTMP#2| |ISTMP#3| |cond| |ISTMP#4| |var|)
    (RETURN
     (PROGN
      (SETQ |sex|
              (CONS 'COLLECT
                    (APPEND
                     (|loopIters2Sex| (|pfParts| (|pfCollectIterators| |pf|)))
                     (CONS (|pf2Sex1| (|pfCollectBody| |pf|)) NIL))))
      (COND
       ((AND (CONSP |sex|) (EQ (CAR |sex|) 'COLLECT)
             (PROGN
              (SETQ |ISTMP#1| (CDR |sex|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|\||)
                         (PROGN
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                               (PROGN (SETQ |cond| (CAR |ISTMP#3|)) #1='T)))))
                   (PROGN
                    (SETQ |ISTMP#4| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                         (PROGN (SETQ |var| (CAR |ISTMP#4|)) #1#)))))
             (SYMBOLP |var|))
        (LIST '|\|| |var| |cond|))
       (#1# |sex|))))))

; pfRule2Sex pf ==
;   $quotedOpList:local := nil
;   $predicateList:local := nil
;   $multiVarPredicateList:local := nil
;   lhs := pfLhsRule2Sex pfRuleLhsItems pf
;   rhs := pfRhsRule2Sex pfRuleRhs pf
;   lhs := ruleLhsTran lhs
;   rulePredicateTran
;     $quotedOpList => ["rule", lhs, rhs, ["construct", :$quotedOpList]]
;     ["rule", lhs, rhs]

(DEFUN |pfRule2Sex| (|pf|)
  (PROG (|$multiVarPredicateList| |$predicateList| |$quotedOpList| |rhs| |lhs|)
    (DECLARE
     (SPECIAL |$multiVarPredicateList| |$predicateList| |$quotedOpList|))
    (RETURN
     (PROGN
      (SETQ |$quotedOpList| NIL)
      (SETQ |$predicateList| NIL)
      (SETQ |$multiVarPredicateList| NIL)
      (SETQ |lhs| (|pfLhsRule2Sex| (|pfRuleLhsItems| |pf|)))
      (SETQ |rhs| (|pfRhsRule2Sex| (|pfRuleRhs| |pf|)))
      (SETQ |lhs| (|ruleLhsTran| |lhs|))
      (|rulePredicateTran|
       (COND
        (|$quotedOpList|
         (LIST '|rule| |lhs| |rhs| (CONS '|construct| |$quotedOpList|)))
        ('T (LIST '|rule| |lhs| |rhs|))))))))

; ruleLhsTran ruleLhs ==
;   for pred in $predicateList repeat
;     [name, predLhs, :predRhs] := pred
;     vars := patternVarsOf predRhs
;     rest(vars) =>  -- if there is more than one patternVariable
;       ruleLhs := NSUBST(predLhs, name, ruleLhs)
;       $multiVarPredicateList := [pred, :$multiVarPredicateList]
;     predicate :=
;       [., var] := predLhs
;       ["suchThat", predLhs, ["ADEF", [var],
;         '((Boolean) (Expression (Integer))), '(() ()), predRhs]]
;     ruleLhs := NSUBST(predicate, name, ruleLhs)
;   ruleLhs

(DEFUN |ruleLhsTran| (|ruleLhs|)
  (PROG (|name| |predLhs| |predRhs| |vars| |var| |predicate|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#29| |pred|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#29|) (PROGN (SETQ |pred| (CAR |bfVar#29|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |name| (CAR |pred|))
             (SETQ |predLhs| (CADR . #2=(|pred|)))
             (SETQ |predRhs| (CDDR . #2#))
             (SETQ |vars| (|patternVarsOf| |predRhs|))
             (COND
              ((CDR |vars|)
               (PROGN
                (SETQ |ruleLhs| (NSUBST |predLhs| |name| |ruleLhs|))
                (SETQ |$multiVarPredicateList|
                        (CONS |pred| |$multiVarPredicateList|))))
              (#1#
               (PROGN
                (SETQ |predicate|
                        (PROGN
                         (SETQ |var| (CADR |predLhs|))
                         (LIST '|suchThat| |predLhs|
                               (LIST 'ADEF (LIST |var|)
                                     '((|Boolean|) (|Expression| (|Integer|)))
                                     '(NIL NIL) |predRhs|))))
                (SETQ |ruleLhs| (NSUBST |predicate| |name| |ruleLhs|))))))))
          (SETQ |bfVar#29| (CDR |bfVar#29|))))
       |$predicateList| NIL)
      |ruleLhs|))))

; rulePredicateTran rule ==
;   null $multiVarPredicateList => rule
;   varList := patternVarsOf [rhs for [.,.,:rhs] in $multiVarPredicateList]
;   predBody :=
;     rest $multiVarPredicateList =>
;       ['AND, :[:pvarPredTran(rhs, varList) for [.,.,:rhs] in
;         $multiVarPredicateList]]
;     [[.,.,:rhs],:.] := $multiVarPredicateList
;     pvarPredTran(rhs, varList)
;   ['suchThat, rule,
;    ['construct, :[["QUOTE", var] for var in varList]],
;     ['ADEF, '(predicateVariable),
;      '((Boolean) (List (Expression (Integer)))), '(() ()),
;       predBody]]

(DEFUN |rulePredicateTran| (|rule|)
  (PROG (|ISTMP#1| |rhs| |varList| |predBody|)
    (RETURN
     (COND ((NULL |$multiVarPredicateList|) |rule|)
           (#1='T
            (PROGN
             (SETQ |varList|
                     (|patternVarsOf|
                      ((LAMBDA (|bfVar#32| |bfVar#31| |bfVar#30|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#31|)
                                (PROGN (SETQ |bfVar#30| (CAR |bfVar#31|)) NIL))
                            (RETURN (NREVERSE |bfVar#32|)))
                           (#1#
                            (AND (CONSP |bfVar#30|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |bfVar#30|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |rhs| (CDR |ISTMP#1|))
                                        #1#)))
                                 (SETQ |bfVar#32| (CONS |rhs| |bfVar#32|)))))
                          (SETQ |bfVar#31| (CDR |bfVar#31|))))
                       NIL |$multiVarPredicateList| NIL)))
             (SETQ |predBody|
                     (COND
                      ((CDR |$multiVarPredicateList|)
                       (CONS 'AND
                             ((LAMBDA (|bfVar#35| |bfVar#34| |bfVar#33|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#34|)
                                       (PROGN
                                        (SETQ |bfVar#33| (CAR |bfVar#34|))
                                        NIL))
                                   (RETURN (NREVERSE |bfVar#35|)))
                                  (#1#
                                   (AND (CONSP |bfVar#33|)
                                        (PROGN
                                         (SETQ |ISTMP#1| (CDR |bfVar#33|))
                                         (AND (CONSP |ISTMP#1|)
                                              (PROGN
                                               (SETQ |rhs| (CDR |ISTMP#1|))
                                               #1#)))
                                        (SETQ |bfVar#35|
                                                (APPEND
                                                 (REVERSE
                                                  (|pvarPredTran| |rhs|
                                                   |varList|))
                                                 |bfVar#35|)))))
                                 (SETQ |bfVar#34| (CDR |bfVar#34|))))
                              NIL |$multiVarPredicateList| NIL)))
                      (#1#
                       (PROGN
                        (SETQ |rhs| (CDDAR |$multiVarPredicateList|))
                        (|pvarPredTran| |rhs| |varList|)))))
             (LIST '|suchThat| |rule|
                   (CONS '|construct|
                         ((LAMBDA (|bfVar#37| |bfVar#36| |var|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#36|)
                                   (PROGN (SETQ |var| (CAR |bfVar#36|)) NIL))
                               (RETURN (NREVERSE |bfVar#37|)))
                              (#1#
                               (SETQ |bfVar#37|
                                       (CONS (LIST 'QUOTE |var|) |bfVar#37|))))
                             (SETQ |bfVar#36| (CDR |bfVar#36|))))
                          NIL |varList| NIL))
                   (LIST 'ADEF '(|predicateVariable|)
                         '((|Boolean|) (|List| (|Expression| (|Integer|))))
                         '(NIL NIL) |predBody|))))))))

; pvarPredTran(rhs, varList) ==
;   for var in varList for i in 1.. repeat
;     rhs := NSUBST(['elt, 'predicateVariable, i], var, rhs)
;   rhs

(DEFUN |pvarPredTran| (|rhs| |varList|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#38| |var| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#38|) (PROGN (SETQ |var| (CAR |bfVar#38|)) NIL))
            (RETURN NIL))
           ('T
            (SETQ |rhs|
                    (NSUBST (LIST '|elt| '|predicateVariable| |i|) |var|
                            |rhs|))))
          (SETQ |bfVar#38| (CDR |bfVar#38|))
          (SETQ |i| (+ |i| 1))))
       |varList| NIL 1)
      |rhs|))))

; patternVarsOf expr ==
;   patternVarsOf1(expr, nil)

(DEFUN |patternVarsOf| (|expr|)
  (PROG () (RETURN (|patternVarsOf1| |expr| NIL))))

; patternVarsOf1(expr, varList) ==
;   NULL expr => varList
;   ATOM expr =>
;     null SYMBOLP expr => varList
;     SymMemQ(expr, varList) => varList
;     [expr, :varList]
;   expr is [op, :argl] =>
;     for arg in argl repeat
;       varList := patternVarsOf1(arg, varList)
;     varList
;   varList

(DEFUN |patternVarsOf1| (|expr| |varList|)
  (PROG (|op| |argl|)
    (RETURN
     (COND ((NULL |expr|) |varList|)
           ((ATOM |expr|)
            (COND ((NULL (SYMBOLP |expr|)) |varList|)
                  ((|SymMemQ| |expr| |varList|) |varList|)
                  (#1='T (CONS |expr| |varList|))))
           ((AND (CONSP |expr|)
                 (PROGN
                  (SETQ |op| (CAR |expr|))
                  (SETQ |argl| (CDR |expr|))
                  #1#))
            (PROGN
             ((LAMBDA (|bfVar#39| |arg|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#39|)
                       (PROGN (SETQ |arg| (CAR |bfVar#39|)) NIL))
                   (RETURN NIL))
                  (#1# (SETQ |varList| (|patternVarsOf1| |arg| |varList|))))
                 (SETQ |bfVar#39| (CDR |bfVar#39|))))
              |argl| NIL)
             |varList|))
           (#1# |varList|)))))

; pfLhsRule2Sex lhs ==
;   $insideRule: local := 'left
;   pf2Sex1 lhs

(DEFUN |pfLhsRule2Sex| (|lhs|)
  (PROG (|$insideRule|)
    (DECLARE (SPECIAL |$insideRule|))
    (RETURN (PROGN (SETQ |$insideRule| '|left|) (|pf2Sex1| |lhs|)))))

; pfRhsRule2Sex rhs ==
;   $insideRule: local := 'right
;   pf2Sex1 rhs

(DEFUN |pfRhsRule2Sex| (|rhs|)
  (PROG (|$insideRule|)
    (DECLARE (SPECIAL |$insideRule|))
    (RETURN (PROGN (SETQ |$insideRule| '|right|) (|pf2Sex1| |rhs|)))))

; pfSuchThat2Sex args ==
;   name := GENTEMP()
;   argList := pf0TupleParts args
;   lhsSex := pf2Sex1 first argList
;   rhsSex := pf2Sex CADR argList
;   $predicateList := [[name, lhsSex, :rhsSex], :$predicateList]
;   name

(DEFUN |pfSuchThat2Sex| (|args|)
  (PROG (|name| |argList| |lhsSex| |rhsSex|)
    (RETURN
     (PROGN
      (SETQ |name| (GENTEMP))
      (SETQ |argList| (|pf0TupleParts| |args|))
      (SETQ |lhsSex| (|pf2Sex1| (CAR |argList|)))
      (SETQ |rhsSex| (|pf2Sex| (CADR |argList|)))
      (SETQ |$predicateList|
              (CONS (CONS |name| (CONS |lhsSex| |rhsSex|)) |$predicateList|))
      |name|))))

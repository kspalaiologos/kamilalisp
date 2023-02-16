
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($specialOps, [ _
;   "ADEF", "AlgExtension", "and", "case", "COERCE", "COLLECT", "construct", "Declare", "DEF", "Dollar", _
;      "equation", "error", "free", "has", "IF", "is", "isnt", "iterate", "break", "LET", "local", "MDEF", "or", _
;        "pretend", "QUOTE", "REDUCE", "REPEAT", "return", "SEQ", "TARGET", "Tuple", "typeOf", "where" ])

(DEFPARAMETER |$specialOps|
  (LIST 'ADEF '|AlgExtension| '|and| '|case| 'COERCE 'COLLECT '|construct|
        '|Declare| 'DEF '|Dollar| '|equation| '|error| '|free| '|has| 'IF '|is|
        '|isnt| '|iterate| '|break| 'LET '|local| 'MDEF '|or| '|pretend| 'QUOTE
        'REDUCE 'REPEAT '|return| 'SEQ 'TARGET '|Tuple| '|typeOf| '|where|))

; upDEF t ==
;   -- performs map definitions.  value is thrown away
;   t isnt [op,def,pred,.] => nil
;   v:=addDefMap(['DEF,:def],pred)
;   null(LISTP(def)) or null(def) =>
;     keyedSystemError("S2GE0016",['"upDEF",'"bad map definition"])
;   mapOp := first def
;   if LISTP(mapOp) then
;     null mapOp =>
;       keyedSystemError("S2GE0016",['"upDEF",'"bad map definition"])
;     mapOp := first mapOp
;   put(mapOp,'value,v,$e)
;   putValue(op,objNew(voidValue(), $Void))
;   putModeSet(op,[$Void])

(DEFUN |upDEF| (|t|)
  (PROG (|op| |ISTMP#1| |def| |ISTMP#2| |pred| |ISTMP#3| |v| |mapOp|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |def| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |pred| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|)
                               (EQ (CDR |ISTMP#3|) NIL)))))))))
       NIL)
      (#1='T
       (PROGN
        (SETQ |v| (|addDefMap| (CONS 'DEF |def|) |pred|))
        (COND
         ((OR (NULL (LISTP |def|)) (NULL |def|))
          (|keyedSystemError| 'S2GE0016 (LIST "upDEF" "bad map definition")))
         (#1#
          (PROGN
           (SETQ |mapOp| (CAR |def|))
           (COND
            ((LISTP |mapOp|)
             (COND
              ((NULL |mapOp|)
               (|keyedSystemError| 'S2GE0016
                (LIST "upDEF" "bad map definition")))
              (#1# (SETQ |mapOp| (CAR |mapOp|))))))
           (|put| |mapOp| '|value| |v| |$e|)
           (|putValue| |op| (|objNew| (|voidValue|) |$Void|))
           (|putModeSet| |op| (LIST |$Void|)))))))))))

; upDollar t ==
;   -- Puts "dollar" property in atree node, and calls bottom up
;   t isnt [op,D,form] => nil
;   t2 := t
;   (not $genValue) and or/[CONTAINED(var,D) for var in $localVars] =>
;     keyedMsgCompFailure("S2IS0032",NIL)
;   EQ(D,'Lisp) => upLispCall(op,form)
;   if VECP D and (SIZE(D) > 0) then D := D.0
;   t := evaluateType unabbrev D
;   categoryForm? t =>
;     throwKeyedMsg("S2IE0012", [t])
;   f := getUnname form
;   if f = $immediateDataSymbol then
;     f := objValUnwrap coerceInteractive(getValue form,$OutputForm)
;     if f = '(construct) then f := "nil"
;   ATOM(form) and (f ~= $immediateDataSymbol) and
;     (u := findUniqueOpInDomain(op,f,t)) => u
;   f in '(One Zero true false nil) and constantInDomain?([f],t) =>
;     isPartialMode t => throwKeyedMsg("S2IS0020",NIL)
;     if $genValue then
;       val := wrap getConstantFromDomain([f],t)
;     else val := ['getConstantFromDomain,['LIST,MKQ f],MKQ t]
;     putValue(op,objNew(val,t))
;     putModeSet(op,[t])
;
;   nargs := #rest form
;
;   (ms := upDollarTuple(op, f, t, t2, rest form, nargs)) => ms
;
;   f ~= 'construct and null isOpInDomain(f,t,nargs) =>
;     throwKeyedMsg("S2IS0023",[f,t])
;   if (sig := findCommonSigInDomain(f,t,nargs)) then
;     for x in sig for y in form repeat
;       if x then putTarget(y,x)
;   putAtree(first form,'dollar,t)
;   ms := bottomUp form
;   f in '(One Zero) and PAIRP(ms) and first(ms) = $OutputForm =>
;     throwKeyedMsg("S2IS0021",[f,t])
;   putValue(op,getValue first form)
;   putModeSet(op,ms)

(DEFUN |upDollar| (|t|)
  (PROG (|op| |ISTMP#1| D |ISTMP#2| |form| |t2| |f| |u| |val| |nargs| |ms|
         |sig|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ D (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |form| (CAR |ISTMP#2|)) #1='T)))))))
       NIL)
      (#1#
       (PROGN
        (SETQ |t2| |t|)
        (COND
         ((AND (NULL |$genValue|)
               ((LAMBDA (|bfVar#2| |bfVar#1| |var|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#1|)
                         (PROGN (SETQ |var| (CAR |bfVar#1|)) NIL))
                     (RETURN |bfVar#2|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#2| (CONTAINED |var| D))
                      (COND (|bfVar#2| (RETURN |bfVar#2|))))))
                   (SETQ |bfVar#1| (CDR |bfVar#1|))))
                NIL |$localVars| NIL))
          (|keyedMsgCompFailure| 'S2IS0032 NIL))
         ((EQ D '|Lisp|) (|upLispCall| |op| |form|))
         (#1#
          (PROGN
           (COND ((AND (VECP D) (< 0 (SIZE D))) (SETQ D (ELT D 0))))
           (SETQ |t| (|evaluateType| (|unabbrev| D)))
           (COND ((|categoryForm?| |t|) (|throwKeyedMsg| 'S2IE0012 (LIST |t|)))
                 (#1#
                  (PROGN
                   (SETQ |f| (|getUnname| |form|))
                   (COND
                    ((EQUAL |f| |$immediateDataSymbol|)
                     (SETQ |f|
                             (|objValUnwrap|
                              (|coerceInteractive| (|getValue| |form|)
                               |$OutputForm|)))
                     (COND ((EQUAL |f| '(|construct|)) (SETQ |f| '|nil|)))))
                   (COND
                    ((AND (ATOM |form|)
                          (NOT (EQUAL |f| |$immediateDataSymbol|))
                          (SETQ |u| (|findUniqueOpInDomain| |op| |f| |t|)))
                     |u|)
                    ((AND (|member| |f| '(|One| |Zero| |true| |false| |nil|))
                          (|constantInDomain?| (LIST |f|) |t|))
                     (COND
                      ((|isPartialMode| |t|) (|throwKeyedMsg| 'S2IS0020 NIL))
                      (#1#
                       (PROGN
                        (COND
                         (|$genValue|
                          (SETQ |val|
                                  (|wrap|
                                   (|getConstantFromDomain| (LIST |f|) |t|))))
                         (#1#
                          (SETQ |val|
                                  (LIST '|getConstantFromDomain|
                                        (LIST 'LIST (MKQ |f|)) (MKQ |t|)))))
                        (|putValue| |op| (|objNew| |val| |t|))
                        (|putModeSet| |op| (LIST |t|))))))
                    (#1#
                     (PROGN
                      (SETQ |nargs| (LENGTH (CDR |form|)))
                      (COND
                       ((SETQ |ms|
                                (|upDollarTuple| |op| |f| |t| |t2| (CDR |form|)
                                 |nargs|))
                        |ms|)
                       ((AND (NOT (EQ |f| '|construct|))
                             (NULL (|isOpInDomain| |f| |t| |nargs|)))
                        (|throwKeyedMsg| 'S2IS0023 (LIST |f| |t|)))
                       (#1#
                        (PROGN
                         (COND
                          ((SETQ |sig|
                                   (|findCommonSigInDomain| |f| |t| |nargs|))
                           ((LAMBDA (|bfVar#3| |x| |bfVar#4| |y|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#3|)
                                     (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL)
                                     (ATOM |bfVar#4|)
                                     (PROGN (SETQ |y| (CAR |bfVar#4|)) NIL))
                                 (RETURN NIL))
                                (#1# (COND (|x| (|putTarget| |y| |x|)))))
                               (SETQ |bfVar#3| (CDR |bfVar#3|))
                               (SETQ |bfVar#4| (CDR |bfVar#4|))))
                            |sig| NIL |form| NIL)))
                         (|putAtree| (CAR |form|) '|dollar| |t|)
                         (SETQ |ms| (|bottomUp| |form|))
                         (COND
                          ((AND (|member| |f| '(|One| |Zero|)) (CONSP |ms|)
                                (EQUAL (CAR |ms|) |$OutputForm|))
                           (|throwKeyedMsg| 'S2IS0021 (LIST |f| |t|)))
                          (#1#
                           (PROGN
                            (|putValue| |op| (|getValue| (CAR |form|)))
                            (|putModeSet| |op| |ms|))))))))))))))))))))))

; upDollarTuple(op, f, t, t2, args, nargs) ==
;   -- this function tries to find a tuple function to use
;   nargs = 1 and getUnname first args = "Tuple" => NIL
;   nargs = 1 and (ms := bottomUp first args) and ms is [["Tuple",.]] => NIL
;   null (singles := isOpInDomain(f,t,1)) => NIL
;   tuple := NIL
;   for [[.,arg], :.] in singles while null tuple repeat
;     if arg is ['Tuple,.] then tuple := arg
;   null tuple => NIL
;   [.,D,form] := t2
;   newArg := [mkAtreeNode "Tuple",:args]
;   putTarget(newArg, tuple)
;   ms := bottomUp newArg
;   first ms ~= tuple => NIL
;   form := [first form, newArg]
;   putAtree(first form,'dollar,t)
;   ms := bottomUp form
;   putValue(op,getValue first form)
;   putModeSet(op,ms)

(DEFUN |upDollarTuple| (|op| |f| |t| |t2| |args| |nargs|)
  (PROG (|ms| |ISTMP#1| |ISTMP#2| |singles| |tuple| |arg| D |form| |newArg|)
    (RETURN
     (COND ((AND (EQL |nargs| 1) (EQ (|getUnname| (CAR |args|)) '|Tuple|)) NIL)
           ((AND (EQL |nargs| 1) (SETQ |ms| (|bottomUp| (CAR |args|)))
                 (CONSP |ms|) (EQ (CDR |ms|) NIL)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |ms|))
                  (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Tuple|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL))))))
            NIL)
           ((NULL (SETQ |singles| (|isOpInDomain| |f| |t| 1))) NIL)
           (#1='T
            (PROGN
             (SETQ |tuple| NIL)
             ((LAMBDA (|bfVar#6| |bfVar#5|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#6|)
                       (PROGN (SETQ |bfVar#5| (CAR |bfVar#6|)) NIL) |tuple|)
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |bfVar#5|)
                        (PROGN
                         (SETQ |ISTMP#1| (CAR |bfVar#5|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                    (PROGN
                                     (SETQ |arg| (CAR |ISTMP#2|))
                                     #1#)))))
                        (COND
                         ((AND (CONSP |arg|) (EQ (CAR |arg|) '|Tuple|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |arg|))
                                (AND (CONSP |ISTMP#1|)
                                     (EQ (CDR |ISTMP#1|) NIL))))
                          (SETQ |tuple| |arg|))))))
                 (SETQ |bfVar#6| (CDR |bfVar#6|))))
              |singles| NIL)
             (COND ((NULL |tuple|) NIL)
                   (#1#
                    (PROGN
                     (SETQ D (CADR . #2=(|t2|)))
                     (SETQ |form| (CADDR . #2#))
                     (SETQ |newArg| (CONS (|mkAtreeNode| '|Tuple|) |args|))
                     (|putTarget| |newArg| |tuple|)
                     (SETQ |ms| (|bottomUp| |newArg|))
                     (COND ((NOT (EQUAL (CAR |ms|) |tuple|)) NIL)
                           (#1#
                            (PROGN
                             (SETQ |form| (LIST (CAR |form|) |newArg|))
                             (|putAtree| (CAR |form|) '|dollar| |t|)
                             (SETQ |ms| (|bottomUp| |form|))
                             (|putValue| |op| (|getValue| (CAR |form|)))
                             (|putModeSet| |op| |ms|)))))))))))))

; upLispCall(op,t) ==
;   -- process $Lisp calls
;   if atom t then code:=getUnname t else
;     [lispOp,:argl]:= t
;     not(functionp(lispOp.0) or macrop(lispOp.0)) =>
;       throwKeyedMsg("S2IS0024",[lispOp.0])
;     for arg in argl repeat bottomUp arg
;     code:=[getUnname lispOp,
;       :[getArgValue(arg,computedMode arg) for arg in argl]]
;   code :=
;     $genValue => wrap timedEVALFUN code
;     code
;   rt := '(SExpression)
;   putValue(op,objNew(code,rt))
;   putModeSet(op,[rt])

(DEFUN |upLispCall| (|op| |t|)
  (PROG (|code| |lispOp| |argl| |rt|)
    (RETURN
     (PROGN
      (COND ((ATOM |t|) (SETQ |code| (|getUnname| |t|)))
            (#1='T (SETQ |lispOp| (CAR |t|)) (SETQ |argl| (CDR |t|))
             (COND
              ((NULL
                (OR (|functionp| (ELT |lispOp| 0))
                    (|macrop| (ELT |lispOp| 0))))
               (|throwKeyedMsg| 'S2IS0024 (LIST (ELT |lispOp| 0))))
              (#1#
               (PROGN
                ((LAMBDA (|bfVar#7| |arg|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#7|)
                          (PROGN (SETQ |arg| (CAR |bfVar#7|)) NIL))
                      (RETURN NIL))
                     (#1# (|bottomUp| |arg|)))
                    (SETQ |bfVar#7| (CDR |bfVar#7|))))
                 |argl| NIL)
                (SETQ |code|
                        (CONS (|getUnname| |lispOp|)
                              ((LAMBDA (|bfVar#9| |bfVar#8| |arg|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#8|)
                                        (PROGN
                                         (SETQ |arg| (CAR |bfVar#8|))
                                         NIL))
                                    (RETURN (NREVERSE |bfVar#9|)))
                                   (#1#
                                    (SETQ |bfVar#9|
                                            (CONS
                                             (|getArgValue| |arg|
                                              (|computedMode| |arg|))
                                             |bfVar#9|))))
                                  (SETQ |bfVar#8| (CDR |bfVar#8|))))
                               NIL |argl| NIL))))))))
      (SETQ |code|
              (COND (|$genValue| (|wrap| (|timedEVALFUN| |code|)))
                    (#1# |code|)))
      (SETQ |rt| '(|SExpression|))
      (|putValue| |op| (|objNew| |code| |rt|))
      (|putModeSet| |op| (LIST |rt|))))))

; upequation tree ==
;   -- only handle this if there is a target of Boolean
;   -- this should speed things up a bit
;   tree isnt [op,lhs,rhs] => NIL
;   $Boolean ~= getTarget(op) => NIL
;   null VECP op => NIL
;   -- change equation into '='
;   op.0 := "="
;   bottomUp tree

(DEFUN |upequation| (|tree|)
  (PROG (|op| |ISTMP#1| |lhs| |ISTMP#2| |rhs|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |tree|)
             (PROGN
              (SETQ |op| (CAR |tree|))
              (SETQ |ISTMP#1| (CDR |tree|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |lhs| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |rhs| (CAR |ISTMP#2|)) #1='T)))))))
       NIL)
      ((NOT (EQUAL |$Boolean| (|getTarget| |op|))) NIL)
      ((NULL (VECP |op|)) NIL)
      (#1# (PROGN (SETF (ELT |op| 0) '=) (|bottomUp| |tree|)))))))

; uperror t ==
;   -- when compiling a function, this merely inserts another argument
;   -- which is the name of the function.
;   not $compilingMap => NIL
;   t isnt [op,msg] => NIL
;   msgMs := bottomUp msg
;   msgMs isnt [=$String] => NIL
;   RPLACD(t,[mkAtree object2String $mapName,msg])
;   bottomUp t

(DEFUN |uperror| (|t|)
  (PROG (|op| |ISTMP#1| |msg| |msgMs|)
    (RETURN
     (COND ((NULL |$compilingMap|) NIL)
           ((NOT
             (AND (CONSP |t|)
                  (PROGN
                   (SETQ |op| (CAR |t|))
                   (SETQ |ISTMP#1| (CDR |t|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ |msg| (CAR |ISTMP#1|)) #1='T)))))
            NIL)
           (#1#
            (PROGN
             (SETQ |msgMs| (|bottomUp| |msg|))
             (COND
              ((NOT
                (AND (CONSP |msgMs|) (EQ (CDR |msgMs|) NIL)
                     (EQUAL (CAR |msgMs|) |$String|)))
               NIL)
              (#1#
               (PROGN
                (RPLACD |t|
                        (LIST (|mkAtree| (|object2String| |$mapName|)) |msg|))
                (|bottomUp| |t|))))))))))

; upfree t ==
;   putValue(t,objNew('(voidValue),$Void))
;   putModeSet(t,[$Void])

(DEFUN |upfree| (|t|)
  (PROG ()
    (RETURN
     (PROGN
      (|putValue| |t| (|objNew| '(|voidValue|) |$Void|))
      (|putModeSet| |t| (LIST |$Void|))))))

; uplocal t ==
;   putValue(t,objNew('(voidValue),$Void))
;   putModeSet(t,[$Void])

(DEFUN |uplocal| (|t|)
  (PROG ()
    (RETURN
     (PROGN
      (|putValue| |t| (|objNew| '(|voidValue|) |$Void|))
      (|putModeSet| |t| (LIST |$Void|))))))

; upfreeWithType(var,type) ==
;   sayKeyedMsg("S2IS0055",['"free",var])
;   var

(DEFUN |upfreeWithType| (|var| |type|)
  (PROG ()
    (RETURN (PROGN (|sayKeyedMsg| 'S2IS0055 (LIST "free" |var|)) |var|))))

; uplocalWithType(var,type) ==
;   sayKeyedMsg("S2IS0055",['"local",var])
;   var

(DEFUN |uplocalWithType| (|var| |type|)
  (PROG ()
    (RETURN (PROGN (|sayKeyedMsg| 'S2IS0055 (LIST "local" |var|)) |var|))))

; uphas t ==
;   t isnt [op,type,prop] => nil
;   -- handler for category and attribute queries
;   type :=
;     isLocalVar(type) => ['unabbrev, type]
;     MKQ unabbrev type
;   catCode :=
;     prop := unabbrev SUBST('$, '%, prop)
;     prop is [":", :.] => MKQ prop
;     ['evaluateType, MKQ prop]
;   code:=['newHasTest,['evaluateType, type], catCode]
;   if $genValue then code := wrap timedEVALFUN code
;   putValue(op,objNew(code,$Boolean))
;   putModeSet(op,[$Boolean])

(DEFUN |uphas| (|t|)
  (PROG (|op| |ISTMP#1| |type| |ISTMP#2| |prop| |catCode| |code|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |type| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |prop| (CAR |ISTMP#2|)) #1='T)))))))
       NIL)
      (#1#
       (PROGN
        (SETQ |type|
                (COND ((|isLocalVar| |type|) (LIST '|unabbrev| |type|))
                      (#1# (MKQ (|unabbrev| |type|)))))
        (SETQ |catCode|
                (PROGN
                 (SETQ |prop| (|unabbrev| (SUBST '$ '% |prop|)))
                 (COND
                  ((AND (CONSP |prop|) (EQ (CAR |prop|) '|:|)) (MKQ |prop|))
                  (#1# (LIST '|evaluateType| (MKQ |prop|))))))
        (SETQ |code|
                (LIST '|newHasTest| (LIST '|evaluateType| |type|) |catCode|))
        (COND (|$genValue| (SETQ |code| (|wrap| (|timedEVALFUN| |code|)))))
        (|putValue| |op| (|objNew| |code| |$Boolean|))
        (|putModeSet| |op| (LIST |$Boolean|))))))))

; upIF t ==
;   t isnt [op,cond,a,b] => nil
;   bottomUpPredicate(cond,'"if/when")
;   $genValue => interpIF(op,cond,a,b)
;   compileIF(op,cond,a,b,t)

(DEFUN |upIF| (|t|)
  (PROG (|op| |ISTMP#1| |cond| |ISTMP#2| |a| |ISTMP#3| |b|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |cond| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |a| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                               (PROGN (SETQ |b| (CAR |ISTMP#3|)) #1='T)))))))))
       NIL)
      (#1#
       (PROGN
        (|bottomUpPredicate| |cond| "if/when")
        (COND (|$genValue| (|interpIF| |op| |cond| |a| |b|))
              (#1# (|compileIF| |op| |cond| |a| |b| |t|)))))))))

; compileIF(op,cond,a,b,t) ==
;   -- type analyzer for compiled case where types of both branches of
;   --  IF are resolved.
;   ms1 := bottomUp a
;   [m1] := ms1
;   b = 'noBranch =>
;     evalIF(op,rest t,$Void)
;     putModeSet(op,[$Void])
;   b = 'noMapVal =>
;     -- if this was a return statement, we take the mode to be that
;     -- of what is being returned.
;     if getUnname a = "return" then
;       ms1 := bottomUp CADR a
;       [m1] := ms1
;     evalIF(op,rest t,m1)
;     putModeSet(op,ms1)
;   ms2 := bottomUp b
;   [m2] := ms2
;   m:=
;     m2=m1 => m1
;     m2 = $Exit => m1
;     m1 = $Exit => m2
;     if EQCAR(m1,'Symbol) then
;       m1:=getMinimalVarMode(getUnname a,$declaredMode)
;     if EQCAR(m2,'Symbol) then
;       m2:=getMinimalVarMode(getUnname b,$declaredMode)
;     (r := resolveTTAny(m2,m1)) => r
;     rempropI($mapName,'localModemap)
;     rempropI($mapName,'localVars)
;     rempropI($mapName,'mapBody)
;     throwKeyedMsg("S2IS0026",[m2,m1])
;   evalIF(op,rest t,m)
;   putModeSet(op,[m])

(DEFUN |compileIF| (|op| |cond| |a| |b| |t|)
  (PROG (|ms1| |m1| |ms2| |m2| |r| |m|)
    (RETURN
     (PROGN
      (SETQ |ms1| (|bottomUp| |a|))
      (SETQ |m1| (CAR |ms1|))
      (COND
       ((EQ |b| '|noBranch|)
        (PROGN
         (|evalIF| |op| (CDR |t|) |$Void|)
         (|putModeSet| |op| (LIST |$Void|))))
       ((EQ |b| '|noMapVal|)
        (PROGN
         (COND
          ((EQ (|getUnname| |a|) '|return|)
           (SETQ |ms1| (|bottomUp| (CADR |a|))) (SETQ |m1| (CAR |ms1|)) |ms1|))
         (|evalIF| |op| (CDR |t|) |m1|)
         (|putModeSet| |op| |ms1|)))
       (#1='T
        (PROGN
         (SETQ |ms2| (|bottomUp| |b|))
         (SETQ |m2| (CAR |ms2|))
         (SETQ |m|
                 (COND ((EQUAL |m2| |m1|) |m1|) ((EQUAL |m2| |$Exit|) |m1|)
                       ((EQUAL |m1| |$Exit|) |m2|)
                       (#1#
                        (PROGN
                         (COND
                          ((EQCAR |m1| '|Symbol|)
                           (SETQ |m1|
                                   (|getMinimalVarMode| (|getUnname| |a|)
                                    |$declaredMode|))))
                         (COND
                          ((EQCAR |m2| '|Symbol|)
                           (SETQ |m2|
                                   (|getMinimalVarMode| (|getUnname| |b|)
                                    |$declaredMode|))))
                         (COND ((SETQ |r| (|resolveTTAny| |m2| |m1|)) |r|)
                               (#1#
                                (PROGN
                                 (|rempropI| |$mapName| '|localModemap|)
                                 (|rempropI| |$mapName| '|localVars|)
                                 (|rempropI| |$mapName| '|mapBody|)
                                 (|throwKeyedMsg| 'S2IS0026
                                  (LIST |m2| |m1|)))))))))
         (|evalIF| |op| (CDR |t|) |m|)
         (|putModeSet| |op| (LIST |m|)))))))))

; evalIF(op,[cond,a,b],m) ==
;   -- generate code form compiled IF
;   elseCode:=
;     b='noMapVal =>
;       [[MKQ true, ['throwKeyedMsg,MKQ "S2IM0018",
;         ['CONS,MKQ object2Identifier $mapName,NIL]]]]
;     b = 'noBranch => [[MKQ true, ['voidValue]]]
;     [[MKQ true,genIFvalCode(b,m)]]
;   code:=['COND,[getArgValue(cond,$Boolean),
;     genIFvalCode(a,m)],:elseCode]
;   triple:= objNew(code,m)
;   putValue(op,triple)

(DEFUN |evalIF| (|op| |bfVar#10| |m|)
  (PROG (|cond| |a| |b| |elseCode| |code| |triple|)
    (RETURN
     (PROGN
      (SETQ |cond| (CAR |bfVar#10|))
      (SETQ |a| (CADR . #1=(|bfVar#10|)))
      (SETQ |b| (CADDR . #1#))
      (SETQ |elseCode|
              (COND
               ((EQ |b| '|noMapVal|)
                (LIST
                 (LIST (MKQ T)
                       (LIST '|throwKeyedMsg| (MKQ 'S2IM0018)
                             (LIST 'CONS (MKQ (|object2Identifier| |$mapName|))
                                   NIL)))))
               ((EQ |b| '|noBranch|) (LIST (LIST (MKQ T) (LIST '|voidValue|))))
               ('T (LIST (LIST (MKQ T) (|genIFvalCode| |b| |m|))))))
      (SETQ |code|
              (CONS 'COND
                    (CONS
                     (LIST (|getArgValue| |cond| |$Boolean|)
                           (|genIFvalCode| |a| |m|))
                     |elseCode|)))
      (SETQ |triple| (|objNew| |code| |m|))
      (|putValue| |op| |triple|)))))

; genIFvalCode(t,m) ==
;   -- passes type information down braches of IF statement
;   --  So that coercions can be performed on data at branches of IF.
;   m1 := computedMode t
;   m1=m => getArgValue(t,m)
;   code:=objVal getValue t
;   IFcodeTran(code,m,m1)

(DEFUN |genIFvalCode| (|t| |m|)
  (PROG (|m1| |code|)
    (RETURN
     (PROGN
      (SETQ |m1| (|computedMode| |t|))
      (COND ((EQUAL |m1| |m|) (|getArgValue| |t| |m|))
            ('T
             (PROGN
              (SETQ |code| (|objVal| (|getValue| |t|)))
              (|IFcodeTran| |code| |m| |m1|))))))))

; IFcodeTran(code,m,m1) ==
;   -- coerces values at branches of IF
;   null code => code
;   code is ['spadThrowBrightly,:.] => code
;   m1 = $Exit => code
;   code isnt ['COND,[p1,a1],[''T,a2]] =>
;     m = $Void => code
;     code' := coerceInteractive(objNew(quote2Wrapped code,m1),m) =>
;       wrapped2Quote objVal code'
;     throwKeyedMsgCannotCoerceWithValue(quote2Wrapped code,m1,m)
;   a1:=IFcodeTran(a1,m,m1)
;   a2:=IFcodeTran(a2,m,m1)
;   ['COND,[p1,a1],[''T,a2]]

(DEFUN |IFcodeTran| (|code| |m| |m1|)
  (PROG (|ISTMP#1| |ISTMP#2| |p1| |ISTMP#3| |a1| |ISTMP#4| |ISTMP#5| |ISTMP#6|
         |a2| |code'|)
    (RETURN
     (COND ((NULL |code|) |code|)
           ((AND (CONSP |code|) (EQ (CAR |code|) '|spadThrowBrightly|)) |code|)
           ((EQUAL |m1| |$Exit|) |code|)
           ((NOT
             (AND (CONSP |code|) (EQ (CAR |code|) 'COND)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |code|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN
                               (SETQ |p1| (CAR |ISTMP#2|))
                               (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                               (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                    (PROGN
                                     (SETQ |a1| (CAR |ISTMP#3|))
                                     #1='T)))))
                        (PROGN
                         (SETQ |ISTMP#4| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                              (PROGN
                               (SETQ |ISTMP#5| (CAR |ISTMP#4|))
                               (AND (CONSP |ISTMP#5|)
                                    (EQUAL (CAR |ISTMP#5|) ''T)
                                    (PROGN
                                     (SETQ |ISTMP#6| (CDR |ISTMP#5|))
                                     (AND (CONSP |ISTMP#6|)
                                          (EQ (CDR |ISTMP#6|) NIL)
                                          (PROGN
                                           (SETQ |a2| (CAR |ISTMP#6|))
                                           #1#)))))))))))
            (COND ((EQUAL |m| |$Void|) |code|)
                  ((SETQ |code'|
                           (|coerceInteractive|
                            (|objNew| (|quote2Wrapped| |code|) |m1|) |m|))
                   (|wrapped2Quote| (|objVal| |code'|)))
                  (#1#
                   (|throwKeyedMsgCannotCoerceWithValue|
                    (|quote2Wrapped| |code|) |m1| |m|))))
           (#1#
            (PROGN
             (SETQ |a1| (|IFcodeTran| |a1| |m| |m1|))
             (SETQ |a2| (|IFcodeTran| |a2| |m| |m1|))
             (LIST 'COND (LIST |p1| |a1|) (LIST ''T |a2|))))))))

; interpIF(op,cond,a,b) ==
;   -- non-compiled version of IF type analyzer.  Doesn't resolve across
;   --  branches of the IF.
;   val:= getValue cond
;   val:= coerceInteractive(val,$Boolean) =>
;     objValUnwrap(val) => upIFgenValue(op,a)
;     EQ(b,'noBranch) =>
;       putValue(op,objNew(voidValue(), $Void))
;       putModeSet(op,[$Void])
;     upIFgenValue(op,b)
;   throwKeyedMsg("S2IS0031",NIL)

(DEFUN |interpIF| (|op| |cond| |a| |b|)
  (PROG (|val|)
    (RETURN
     (PROGN
      (SETQ |val| (|getValue| |cond|))
      (COND
       ((SETQ |val| (|coerceInteractive| |val| |$Boolean|))
        (COND ((|objValUnwrap| |val|) (|upIFgenValue| |op| |a|))
              ((EQ |b| '|noBranch|)
               (PROGN
                (|putValue| |op| (|objNew| (|voidValue|) |$Void|))
                (|putModeSet| |op| (LIST |$Void|))))
              (#1='T (|upIFgenValue| |op| |b|))))
       (#1# (|throwKeyedMsg| 'S2IS0031 NIL)))))))

; upIFgenValue(op,tree) ==
;   -- evaluates tree and transfers the results to op
;   ms:=bottomUp tree
;   val:= getValue tree
;   putValue(op,val)
;   putModeSet(op,ms)

(DEFUN |upIFgenValue| (|op| |tree|)
  (PROG (|ms| |val|)
    (RETURN
     (PROGN
      (SETQ |ms| (|bottomUp| |tree|))
      (SETQ |val| (|getValue| |tree|))
      (|putValue| |op| |val|)
      (|putModeSet| |op| |ms|)))))

; upis t ==
;   t isnt [op,a,pattern] => nil
;   $opIsIs : local := true
;   upisAndIsnt t

(DEFUN |upis| (|t|)
  (PROG (|$opIsIs| |pattern| |ISTMP#2| |a| |ISTMP#1| |op|)
    (DECLARE (SPECIAL |$opIsIs|))
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |a| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |pattern| (CAR |ISTMP#2|)) #1='T)))))))
       NIL)
      (#1# (PROGN (SETQ |$opIsIs| T) (|upisAndIsnt| |t|)))))))

; upisnt t ==
;   t isnt [op,a,pattern] => nil
;   $opIsIs : local := nil
;   upisAndIsnt t

(DEFUN |upisnt| (|t|)
  (PROG (|$opIsIs| |pattern| |ISTMP#2| |a| |ISTMP#1| |op|)
    (DECLARE (SPECIAL |$opIsIs|))
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |a| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |pattern| (CAR |ISTMP#2|)) #1='T)))))))
       NIL)
      (#1# (PROGN (SETQ |$opIsIs| NIL) (|upisAndIsnt| |t|)))))))

; upisAndIsnt(t:=[op,a,pattern]) ==
;   -- handler for "is" pattern matching
;   mS:= bottomUp a
;   mS isnt [m] =>
;     keyedSystemError("S2GE0016",['"upisAndIsnt",'"non-unique modeset"])
;   putPvarModes(removeConstruct pattern,m)
;   evalis(op,rest t,m)
;   putModeSet(op,[$Boolean])

(DEFUN |upisAndIsnt| (|t|)
  (PROG (|op| |a| |pattern| |mS| |m|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |t|))
      (SETQ |a| (CADR . #1=(|t|)))
      (SETQ |pattern| (CADDR . #1#))
      (SETQ |mS| (|bottomUp| |a|))
      (COND
       ((NOT
         (AND (CONSP |mS|) (EQ (CDR |mS|) NIL)
              (PROGN (SETQ |m| (CAR |mS|)) #2='T)))
        (|keyedSystemError| 'S2GE0016
         (LIST "upisAndIsnt" "non-unique modeset")))
       (#2#
        (PROGN
         (|putPvarModes| (|removeConstruct| |pattern|) |m|)
         (|evalis| |op| (CDR |t|) |m|)
         (|putModeSet| |op| (LIST |$Boolean|)))))))))

; putPvarModes(pattern,m) ==
;   -- Puts the modes for the pattern variables into $env
;   m isnt ['List,um] => throwKeyedMsg("S2IS0030",NIL)
;   for pvar in pattern repeat
;       IDENTP pvar => put(pvar, 'mode, um, $env)
;       pvar is ['_:, var] => put(var, 'mode, m, $env)
;       pvar is ['_=, var] => put(var, 'mode, um, $env)
;       putPvarModes(pvar, um)

(DEFUN |putPvarModes| (|pattern| |m|)
  (PROG (|ISTMP#1| |um| |var|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |m|) (EQ (CAR |m|) '|List|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |m|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |um| (CAR |ISTMP#1|)) #1='T)))))
       (|throwKeyedMsg| 'S2IS0030 NIL))
      (#1#
       ((LAMBDA (|bfVar#11| |pvar|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#11|) (PROGN (SETQ |pvar| (CAR |bfVar#11|)) NIL))
             (RETURN NIL))
            (#1#
             (COND ((IDENTP |pvar|) (|put| |pvar| '|mode| |um| |$env|))
                   ((AND (CONSP |pvar|) (EQ (CAR |pvar|) '|:|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |pvar|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                               (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#))))
                    (|put| |var| '|mode| |m| |$env|))
                   ((AND (CONSP |pvar|) (EQ (CAR |pvar|) '=)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |pvar|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                               (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#))))
                    (|put| |var| '|mode| |um| |$env|))
                   (#1# (|putPvarModes| |pvar| |um|)))))
           (SETQ |bfVar#11| (CDR |bfVar#11|))))
        |pattern| NIL))))))

; evalis(op,[a,pattern],mode) ==
;   -- actually handles is and isnt
;   if $opIsIs
;     then fun := 'evalIsPredicate
;     else fun := 'evalIsntPredicate
;   if isLocalPred pattern then
;     code:= compileIs(a,pattern)
;   else code:=[fun,getArgValue(a,mode),
;     MKQ pattern,MKQ mode]
;   triple:=
;     $genValue => objNewWrap(timedEVALFUN code,$Boolean)
;     objNew(code,$Boolean)
;   putValue(op,triple)

(DEFUN |evalis| (|op| |bfVar#12| |mode|)
  (PROG (|a| |pattern| |fun| |code| |triple|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR |bfVar#12|))
      (SETQ |pattern| (CADR |bfVar#12|))
      (COND (|$opIsIs| (SETQ |fun| '|evalIsPredicate|))
            (#1='T (SETQ |fun| '|evalIsntPredicate|)))
      (COND
       ((|isLocalPred| |pattern|) (SETQ |code| (|compileIs| |a| |pattern|)))
       (#1#
        (SETQ |code|
                (LIST |fun| (|getArgValue| |a| |mode|) (MKQ |pattern|)
                      (MKQ |mode|)))))
      (SETQ |triple|
              (COND
               (|$genValue| (|objNewWrap| (|timedEVALFUN| |code|) |$Boolean|))
               (#1# (|objNew| |code| |$Boolean|))))
      (|putValue| |op| |triple|)))))

; isLocalPred pattern ==
;   -- returns true if the is predicate is to be compiled
;   for pat in pattern repeat
;     IDENTP pat and isLocalVar(pat) => return true
;     pat is ['_:,var] and isLocalVar(var) => return true
;     pat is ['_=,var] and isLocalVar(var) => return true

(DEFUN |isLocalPred| (|pattern|)
  (PROG (|ISTMP#1| |var|)
    (RETURN
     ((LAMBDA (|bfVar#13| |pat|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#13|) (PROGN (SETQ |pat| (CAR |bfVar#13|)) NIL))
           (RETURN NIL))
          (#1='T
           (COND ((AND (IDENTP |pat|) (|isLocalVar| |pat|)) (RETURN T))
                 ((AND (CONSP |pat|) (EQ (CAR |pat|) '|:|)
                       (PROGN
                        (SETQ |ISTMP#1| (CDR |pat|))
                        (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                             (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#)))
                       (|isLocalVar| |var|))
                  (RETURN T))
                 ((AND (CONSP |pat|) (EQ (CAR |pat|) '=)
                       (PROGN
                        (SETQ |ISTMP#1| (CDR |pat|))
                        (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                             (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#)))
                       (|isLocalVar| |var|))
                  (RETURN T)))))
         (SETQ |bfVar#13| (CDR |bfVar#13|))))
      |pattern| NIL))))

; compileIs(val,pattern) ==
;   -- produce code for compiled "is" predicate.  makes pattern variables
;   --  into local variables of the function
;   vars:= NIL
;   for pat in rest pattern repeat
;     IDENTP(pat) and isLocalVar(pat) => vars:=[pat,:vars]
;     pat is ['_:,var] => vars:= [var,:vars]
;     pat is ['_=,var] => vars:= [var,:vars]
;   predCode:=['LET,g:=GENSYM(),['isPatternMatch,
;     getArgValue(val,computedMode val),MKQ removeConstruct pattern]]
;   for var in REMDUP vars repeat
;     assignCode:=[['LET,var,['CDR,['ASSQ,MKQ var,g]]],:assignCode]
;   null $opIsIs =>
;     ['COND,[['EQ,predCode,MKQ 'failed],['SEQ,:assignCode,MKQ 'T]]]
;   ['COND,[['NOT,['EQ,predCode,MKQ 'failed]],['SEQ,:assignCode,MKQ 'T]]]

(DEFUN |compileIs| (|val| |pattern|)
  (PROG (|vars| |ISTMP#1| |var| |g| |predCode| |assignCode|)
    (RETURN
     (PROGN
      (SETQ |vars| NIL)
      ((LAMBDA (|bfVar#14| |pat|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#14|) (PROGN (SETQ |pat| (CAR |bfVar#14|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((AND (IDENTP |pat|) (|isLocalVar| |pat|))
              (SETQ |vars| (CONS |pat| |vars|)))
             ((AND (CONSP |pat|) (EQ (CAR |pat|) '|:|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |pat|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#))))
              (SETQ |vars| (CONS |var| |vars|)))
             ((AND (CONSP |pat|) (EQ (CAR |pat|) '=)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |pat|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#))))
              (SETQ |vars| (CONS |var| |vars|))))))
          (SETQ |bfVar#14| (CDR |bfVar#14|))))
       (CDR |pattern|) NIL)
      (SETQ |predCode|
              (LIST 'LET (SETQ |g| (GENSYM))
                    (LIST '|isPatternMatch|
                          (|getArgValue| |val| (|computedMode| |val|))
                          (MKQ (|removeConstruct| |pattern|)))))
      ((LAMBDA (|bfVar#15| |var|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#15|) (PROGN (SETQ |var| (CAR |bfVar#15|)) NIL))
            (RETURN NIL))
           (#1#
            (SETQ |assignCode|
                    (CONS
                     (LIST 'LET |var| (LIST 'CDR (LIST 'ASSQ (MKQ |var|) |g|)))
                     |assignCode|))))
          (SETQ |bfVar#15| (CDR |bfVar#15|))))
       (REMDUP |vars|) NIL)
      (COND
       ((NULL |$opIsIs|)
        (LIST 'COND
              (LIST (LIST 'EQ |predCode| (MKQ '|failed|))
                    (CONS 'SEQ (APPEND |assignCode| (CONS (MKQ 'T) NIL))))))
       (#1#
        (LIST 'COND
              (LIST (LIST 'NOT (LIST 'EQ |predCode| (MKQ '|failed|)))
                    (CONS 'SEQ
                          (APPEND |assignCode| (CONS (MKQ 'T) NIL)))))))))))

; evalIsPredicate(value,pattern,mode) ==
;   --This function pattern matches value to pattern, and returns
;   --true if it matches, and false otherwise.  As a side effect
;   --if the pattern matches then the bindings given in the pattern
;   --are made
;   pattern:= removeConstruct pattern
;   not ((valueAlist:=isPatternMatch(value,pattern))='failed) =>
;     for [id,:value] in valueAlist repeat
;       evalLETchangeValue(id,objNewWrap(value,get(id,'mode,$env)))
;     true
;   false

(DEFUN |evalIsPredicate| (|value| |pattern| |mode|)
  (PROG (|valueAlist| |id|)
    (RETURN
     (PROGN
      (SETQ |pattern| (|removeConstruct| |pattern|))
      (COND
       ((NULL
         (EQ (SETQ |valueAlist| (|isPatternMatch| |value| |pattern|))
             '|failed|))
        (PROGN
         ((LAMBDA (|bfVar#17| |bfVar#16|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#17|)
                   (PROGN (SETQ |bfVar#16| (CAR |bfVar#17|)) NIL))
               (RETURN NIL))
              (#1='T
               (AND (CONSP |bfVar#16|)
                    (PROGN
                     (SETQ |id| (CAR |bfVar#16|))
                     (SETQ |value| (CDR |bfVar#16|))
                     #1#)
                    (|evalLETchangeValue| |id|
                     (|objNewWrap| |value| (|get| |id| '|mode| |$env|))))))
             (SETQ |bfVar#17| (CDR |bfVar#17|))))
          |valueAlist| NIL)
         T))
       (#1# NIL))))))

; evalIsntPredicate(value,pattern,mode) ==
;     not(evalIsPredicate(value,pattern,mode))

(DEFUN |evalIsntPredicate| (|value| |pattern| |mode|)
  (PROG () (RETURN (NULL (|evalIsPredicate| |value| |pattern| |mode|)))))

; removeConstruct pat ==
;   -- removes the "construct" from the beginning of patterns
;   if pat is ['construct,:p] then pat:=p
;   if pat is ['cons, a, b] then pat := [a, ['_:, b]]
;   atom pat => pat
;   RPLACA(pat, removeConstruct first pat)
;   RPLACD(pat, removeConstruct rest pat)
;   pat

(DEFUN |removeConstruct| (|pat|)
  (PROG (|p| |ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (PROGN
      (COND
       ((AND (CONSP |pat|) (EQ (CAR |pat|) '|construct|)
             (PROGN (SETQ |p| (CDR |pat|)) #1='T))
        (SETQ |pat| |p|)))
      (COND
       ((AND (CONSP |pat|) (EQ (CAR |pat|) '|cons|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |pat|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |a| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
        (SETQ |pat| (LIST |a| (LIST '|:| |b|)))))
      (COND ((ATOM |pat|) |pat|)
            (#1#
             (PROGN
              (RPLACA |pat| (|removeConstruct| (CAR |pat|)))
              (RPLACD |pat| (|removeConstruct| (CDR |pat|)))
              |pat|)))))))

; isPatternMatch(l,pats) ==
;   -- perform the actual pattern match
;   $subs: local := NIL
;   isPatMatch(l,pats)
;   $subs

(DEFUN |isPatternMatch| (|l| |pats|)
  (PROG (|$subs|)
    (DECLARE (SPECIAL |$subs|))
    (RETURN (PROGN (SETQ |$subs| NIL) (|isPatMatch| |l| |pats|) |$subs|))))

; isPatMatch(l,pats) ==
;   null pats =>
;     null l => $subs
;     $subs:='failed
;   null l =>
;     null pats => $subs
;     pats is [['_:,var]] =>
;       $subs := [[var],:$subs]
;     $subs:='failed
;   pats is [pat,:restPats] =>
;     IDENTP pat =>
;       $subs:=[[pat,:first l],:$subs]
;       isPatMatch(rest l,restPats)
;     pat is ['_=,var] =>
;       p:=ASSQ(var,$subs) =>
;         first l = rest p => isPatMatch(rest l, restPats)
;         $subs:='failed
;       $subs:='failed
;     pat is ['_:,var] =>
;       n:=#restPats
;       m:=#l-n
;       m<0 => $subs:='failed
;       ZEROP n => $subs:=[[var,:l],:$subs]
;       $subs:=[[var,:[x for x in l for i in 1..m]],:$subs]
;       isPatMatch(DROP(m,l),restPats)
;     isPatMatch(first l,pat) = 'failed => 'failed
;     isPatMatch(rest l,restPats)
;   keyedSystemError("S2GE0016",['"isPatMatch",
;      '"unknown form of is predicate"])

(DEFUN |isPatMatch| (|l| |pats|)
  (PROG (|ISTMP#1| |ISTMP#2| |var| |pat| |restPats| |p| |n| |m|)
    (RETURN
     (COND
      ((NULL |pats|)
       (COND ((NULL |l|) |$subs|) (#1='T (SETQ |$subs| '|failed|))))
      ((NULL |l|)
       (COND ((NULL |pats|) |$subs|)
             ((AND (CONSP |pats|) (EQ (CDR |pats|) NIL)
                   (PROGN
                    (SETQ |ISTMP#1| (CAR |pats|))
                    (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|)
                         (PROGN
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ |var| (CAR |ISTMP#2|)) #1#))))))
              (SETQ |$subs| (CONS (LIST |var|) |$subs|)))
             (#1# (SETQ |$subs| '|failed|))))
      ((AND (CONSP |pats|)
            (PROGN
             (SETQ |pat| (CAR |pats|))
             (SETQ |restPats| (CDR |pats|))
             #1#))
       (COND
        ((IDENTP |pat|)
         (PROGN
          (SETQ |$subs| (CONS (CONS |pat| (CAR |l|)) |$subs|))
          (|isPatMatch| (CDR |l|) |restPats|)))
        ((AND (CONSP |pat|) (EQ (CAR |pat|) '=)
              (PROGN
               (SETQ |ISTMP#1| (CDR |pat|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                    (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#))))
         (COND
          ((SETQ |p| (ASSQ |var| |$subs|))
           (COND
            ((EQUAL (CAR |l|) (CDR |p|)) (|isPatMatch| (CDR |l|) |restPats|))
            (#1# (SETQ |$subs| '|failed|))))
          (#1# (SETQ |$subs| '|failed|))))
        ((AND (CONSP |pat|) (EQ (CAR |pat|) '|:|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |pat|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                    (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#))))
         (PROGN
          (SETQ |n| (LENGTH |restPats|))
          (SETQ |m| (- (LENGTH |l|) |n|))
          (COND ((MINUSP |m|) (SETQ |$subs| '|failed|))
                ((ZEROP |n|) (SETQ |$subs| (CONS (CONS |var| |l|) |$subs|)))
                (#1#
                 (PROGN
                  (SETQ |$subs|
                          (CONS
                           (CONS |var|
                                 ((LAMBDA (|bfVar#19| |bfVar#18| |x| |i|)
                                    (LOOP
                                     (COND
                                      ((OR (ATOM |bfVar#18|)
                                           (PROGN
                                            (SETQ |x| (CAR |bfVar#18|))
                                            NIL)
                                           (> |i| |m|))
                                       (RETURN (NREVERSE |bfVar#19|)))
                                      (#1#
                                       (SETQ |bfVar#19|
                                               (CONS |x| |bfVar#19|))))
                                     (SETQ |bfVar#18| (CDR |bfVar#18|))
                                     (SETQ |i| (+ |i| 1))))
                                  NIL |l| NIL 1))
                           |$subs|))
                  (|isPatMatch| (DROP |m| |l|) |restPats|))))))
        ((EQ (|isPatMatch| (CAR |l|) |pat|) '|failed|) '|failed|)
        (#1# (|isPatMatch| (CDR |l|) |restPats|))))
      (#1#
       (|keyedSystemError| 'S2GE0016
        (LIST "isPatMatch" "unknown form of is predicate")))))))

; upiterate t ==
;   null $repeatBodyLabel => throwKeyedMsg("S2IS0029",['"iterate"])
;   $iterateCount := $iterateCount + 1
;   code := ['THROW,$repeatBodyLabel,'(voidValue)]
;   $genValue => THROW(eval $repeatBodyLabel,voidValue())
;   putValue(t,objNew(code,$Void))
;   putModeSet(t,[$Void])

(DEFUN |upiterate| (|t|)
  (PROG (|code|)
    (RETURN
     (COND
      ((NULL |$repeatBodyLabel|) (|throwKeyedMsg| 'S2IS0029 (LIST "iterate")))
      (#1='T
       (PROGN
        (SETQ |$iterateCount| (+ |$iterateCount| 1))
        (SETQ |code| (LIST 'THROW |$repeatBodyLabel| '(|voidValue|)))
        (COND (|$genValue| (THROW (|eval| |$repeatBodyLabel|) (|voidValue|)))
              (#1#
               (PROGN
                (|putValue| |t| (|objNew| |code| |$Void|))
                (|putModeSet| |t| (LIST |$Void|)))))))))))

; upbreak t ==
;   t isnt [op,.] => nil
;   null $repeatLabel => throwKeyedMsg("S2IS0029",['"break"])
;   $breakCount := $breakCount + 1
;   code := ['THROW,$repeatLabel,'(voidValue)]
;   $genValue => THROW(eval $repeatLabel,voidValue())
;   putValue(op,objNew(code,$Void))
;   putModeSet(op,[$Void])

(DEFUN |upbreak| (|t|)
  (PROG (|op| |ISTMP#1| |code|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)))))
       NIL)
      ((NULL |$repeatLabel|) (|throwKeyedMsg| 'S2IS0029 (LIST "break")))
      (#1='T
       (PROGN
        (SETQ |$breakCount| (+ |$breakCount| 1))
        (SETQ |code| (LIST 'THROW |$repeatLabel| '(|voidValue|)))
        (COND (|$genValue| (THROW (|eval| |$repeatLabel|) (|voidValue|)))
              (#1#
               (PROGN
                (|putValue| |op| (|objNew| |code| |$Void|))
                (|putModeSet| |op| (LIST |$Void|)))))))))))

; upLET t ==
;   -- analyzes and evaluates the righthand side, and does the variable
;   -- binding
;   t isnt [op,lhs,rhs] => nil
;   $declaredMode: local := NIL
;   PAIRP lhs =>
;     var:= getUnname first lhs
;     var = 'construct => upLETWithPatternOnLhs t
;     var = 'QUOTE => throwKeyedMsg("S2IS0027",['"A quoted form"])
;     upLETWithFormOnLhs(op,lhs,rhs)
;   var:= getUnname lhs
;   var = $immediateDataSymbol =>
;     -- following will be immediate data, so probably ok to not
;     -- specially format it
;     obj := objValUnwrap coerceInteractive(getValue lhs,$OutputForm)
;     throwKeyedMsg("S2IS0027",[obj])
;   var in '(% %%) =>               -- for history
;     throwKeyedMsg("S2IS0027",[var])
;   (IDENTP var) and not (var in '(true false elt QUOTE)) =>
;     var ~= (var' := unabbrev(var)) =>  -- constructor abbreviation
;       throwKeyedMsg("S2IS0028",[var,var'])
;     if get(var,'isInterpreterFunction,$e) then
;       putHist(var,'isInterpreterFunction,false,$e)
;       sayKeyedMsg("S2IS0049",['"Function",var])
;     else if get(var,'isInterpreterRule,$e) then
;       putHist(var,'isInterpreterRule,false,$e)
;       sayKeyedMsg("S2IS0049",['"Rule",var])
;     not isTupleForm(rhs) and (m := isType rhs) => upLETtype(op,lhs,m)
;     transferPropsToNode(var,lhs)
;     if ( m:= getMode(lhs) ) then
;       $declaredMode := m
;       putTarget(rhs,m)
;     if (val := getValue lhs) and (objMode val = $Boolean) and
;       getUnname(rhs) = 'equation then putTarget(rhs,$Boolean)
;     (rhsMs:= bottomUp rhs) = [$Void] =>
;       throwKeyedMsg("S2IS0034",[var])
;     val:=evalLET(lhs,rhs)
;     putValue(op,val)
;     putModeSet(op,[objMode(val)])
;   throwKeyedMsg("S2IS0027",[var])

(DEFUN |upLET| (|t|)
  (PROG (|$declaredMode| |rhsMs| |val| |m| |var'| |obj| |var| |rhs| |ISTMP#2|
         |lhs| |ISTMP#1| |op|)
    (DECLARE (SPECIAL |$declaredMode|))
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |lhs| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |rhs| (CAR |ISTMP#2|)) #1='T)))))))
       NIL)
      (#1#
       (PROGN
        (SETQ |$declaredMode| NIL)
        (COND
         ((CONSP |lhs|)
          (PROGN
           (SETQ |var| (|getUnname| (CAR |lhs|)))
           (COND ((EQ |var| '|construct|) (|upLETWithPatternOnLhs| |t|))
                 ((EQ |var| 'QUOTE)
                  (|throwKeyedMsg| 'S2IS0027 (LIST "A quoted form")))
                 (#1# (|upLETWithFormOnLhs| |op| |lhs| |rhs|)))))
         (#1#
          (PROGN
           (SETQ |var| (|getUnname| |lhs|))
           (COND
            ((EQUAL |var| |$immediateDataSymbol|)
             (PROGN
              (SETQ |obj|
                      (|objValUnwrap|
                       (|coerceInteractive| (|getValue| |lhs|) |$OutputForm|)))
              (|throwKeyedMsg| 'S2IS0027 (LIST |obj|))))
            ((|member| |var| '(% %%)) (|throwKeyedMsg| 'S2IS0027 (LIST |var|)))
            ((AND (IDENTP |var|)
                  (NULL (|member| |var| '(|true| |false| |elt| QUOTE))))
             (COND
              ((NOT (EQUAL |var| (SETQ |var'| (|unabbrev| |var|))))
               (|throwKeyedMsg| 'S2IS0028 (LIST |var| |var'|)))
              (#1#
               (PROGN
                (COND
                 ((|get| |var| '|isInterpreterFunction| |$e|)
                  (|putHist| |var| '|isInterpreterFunction| NIL |$e|)
                  (|sayKeyedMsg| 'S2IS0049 (LIST "Function" |var|)))
                 ((|get| |var| '|isInterpreterRule| |$e|)
                  (|putHist| |var| '|isInterpreterRule| NIL |$e|)
                  (|sayKeyedMsg| 'S2IS0049 (LIST "Rule" |var|))))
                (COND
                 ((AND (NULL (|isTupleForm| |rhs|))
                       (SETQ |m| (|isType| |rhs|)))
                  (|upLETtype| |op| |lhs| |m|))
                 (#1#
                  (PROGN
                   (|transferPropsToNode| |var| |lhs|)
                   (COND
                    ((SETQ |m| (|getMode| |lhs|)) (SETQ |$declaredMode| |m|)
                     (|putTarget| |rhs| |m|)))
                   (COND
                    ((AND (SETQ |val| (|getValue| |lhs|))
                          (EQUAL (|objMode| |val|) |$Boolean|)
                          (EQ (|getUnname| |rhs|) '|equation|))
                     (|putTarget| |rhs| |$Boolean|)))
                   (COND
                    ((EQUAL (SETQ |rhsMs| (|bottomUp| |rhs|)) (LIST |$Void|))
                     (|throwKeyedMsg| 'S2IS0034 (LIST |var|)))
                    (#1#
                     (PROGN
                      (SETQ |val| (|evalLET| |lhs| |rhs|))
                      (|putValue| |op| |val|)
                      (|putModeSet| |op| (LIST (|objMode| |val|)))))))))))))
            (#1# (|throwKeyedMsg| 'S2IS0027 (LIST |var|)))))))))))))

; isTupleForm f ==
;     -- have to do following since "Tuple" is an internal form name
;     getUnname f ~= "Tuple" => false
;     f is [op,:args] and VECP(op) and getUnname(op) = "Tuple" =>
;         #args ~= 1 => true
;         isTupleForm first args => true
;         isType first args => false
;         true
;     false

(DEFUN |isTupleForm| (|f|)
  (PROG (|op| |args|)
    (RETURN
     (COND ((NOT (EQ (|getUnname| |f|) '|Tuple|)) NIL)
           ((AND (CONSP |f|)
                 (PROGN (SETQ |op| (CAR |f|)) (SETQ |args| (CDR |f|)) #1='T)
                 (VECP |op|) (EQ (|getUnname| |op|) '|Tuple|))
            (COND ((NOT (EQL (LENGTH |args|) 1)) T)
                  ((|isTupleForm| (CAR |args|)) T)
                  ((|isType| (CAR |args|)) NIL) (#1# T)))
           (#1# NIL)))))

; evalLET(lhs,rhs) ==
;   -- lhs is a vector for a variable, and rhs is the evaluated atree
;   --  for the value which is coerced to the mode of lhs
;   $useConvertForCoercions: local := true
;   v' := (v:= getValue rhs)
;   ((not getMode lhs) and (getModeSet rhs is [.])) or
;     get(getUnname lhs,'autoDeclare,$env) =>
;       v:=
;         $genValue => v
;         objNew(wrapped2Quote objVal v,objMode v)
;       evalLETput(lhs,v)
;   t1:= objMode v
;   t2' := (t2 := getMode lhs)
;   value:=
;     t1 = t2 =>
;       $genValue => v
;       objNew(wrapped2Quote objVal v,objMode v)
;     if isPartialMode t2 then
;       if EQCAR(t1,'Symbol) and $declaredMode then
;         t1:= getMinimalVarMode(objValUnwrap v,$declaredMode)
;       t' := t2
;       null (t2 := resolveTM(t1,t2)) =>
;         if not t2 then t2 := t'
;         throwKeyedMsg("S2IS0035",[t1,t2])
;     null (v := getArgValue(rhs,t2)) =>
;       isWrapped(objVal v') and (v2:=coerceInteractive(v',$OutputForm)) =>
;         throwKeyedMsg("S2IS0036",[objValUnwrap v2,t2])
;       throwKeyedMsg("S2IS0037",[t2])
;     t2 and objNew(($genValue => wrap timedEVALFUN v ; v),t2)
;   value => evalLETput(lhs,value)
;   throwKeyedMsgCannotCoerceWithValue(objVal v,t1,getMode lhs)

(DEFUN |evalLET| (|lhs| |rhs|)
  (PROG (|$useConvertForCoercions| |value| |v2| |t'| |t2'| |t2| |t1| |ISTMP#1|
         |v'| |v|)
    (DECLARE (SPECIAL |$useConvertForCoercions|))
    (RETURN
     (PROGN
      (SETQ |$useConvertForCoercions| T)
      (SETQ |v'| (SETQ |v| (|getValue| |rhs|)))
      (COND
       ((OR
         (AND (NULL (|getMode| |lhs|))
              (PROGN
               (SETQ |ISTMP#1| (|getModeSet| |rhs|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
         (|get| (|getUnname| |lhs|) '|autoDeclare| |$env|))
        (PROGN
         (SETQ |v|
                 (COND (|$genValue| |v|)
                       (#1='T
                        (|objNew| (|wrapped2Quote| (|objVal| |v|))
                         (|objMode| |v|)))))
         (|evalLETput| |lhs| |v|)))
       (#1#
        (PROGN
         (SETQ |t1| (|objMode| |v|))
         (SETQ |t2'| (SETQ |t2| (|getMode| |lhs|)))
         (SETQ |value|
                 (COND
                  ((EQUAL |t1| |t2|)
                   (COND (|$genValue| |v|)
                         (#1#
                          (|objNew| (|wrapped2Quote| (|objVal| |v|))
                           (|objMode| |v|)))))
                  (#1#
                   (PROGN
                    (COND
                     ((|isPartialMode| |t2|)
                      (COND
                       ((AND (EQCAR |t1| '|Symbol|) |$declaredMode|)
                        (SETQ |t1|
                                (|getMinimalVarMode| (|objValUnwrap| |v|)
                                 |$declaredMode|))))
                      (SETQ |t'| |t2|)
                      (COND
                       ((NULL (SETQ |t2| (|resolveTM| |t1| |t2|)))
                        (PROGN
                         (COND ((NULL |t2|) (SETQ |t2| |t'|)))
                         (|throwKeyedMsg| 'S2IS0035 (LIST |t1| |t2|)))))))
                    (COND
                     ((NULL (SETQ |v| (|getArgValue| |rhs| |t2|)))
                      (COND
                       ((AND (|isWrapped| (|objVal| |v'|))
                             (SETQ |v2|
                                     (|coerceInteractive| |v'| |$OutputForm|)))
                        (|throwKeyedMsg| 'S2IS0036
                         (LIST (|objValUnwrap| |v2|) |t2|)))
                       (#1# (|throwKeyedMsg| 'S2IS0037 (LIST |t2|)))))
                     (#1#
                      (AND |t2|
                           (|objNew|
                            (COND (|$genValue| (|wrap| (|timedEVALFUN| |v|)))
                                  (#1# |v|))
                            |t2|))))))))
         (COND (|value| (|evalLETput| |lhs| |value|))
               (#1#
                (|throwKeyedMsgCannotCoerceWithValue| (|objVal| |v|) |t1|
                 (|getMode| |lhs|)))))))))))

; evalLETput(lhs,value) ==
;   -- put value into the cell for lhs
;   name:= getUnname lhs
;   if not $genValue then
;     code:=
;       isLocalVar(name) =>
;         om := objMode(value)
;         dm := get(name,'mode,$env)
;         dm and not ((om = dm) or isSubDomain(om,dm) or
;           isSubDomain(dm,om)) =>
;             compFailure ['"   The type of the local variable",
;               :bright name,'"has changed in the computation."]
;         if dm and isSubDomain(dm,om) then put(name,'mode,om,$env)
;         ['LET,name,objVal value,$mapName]
;                -- $mapName is set in analyzeMap
;       om := objMode value
;       dm := get(name, 'mode, $env) or objMode(get(name, 'value, $e))
;       dm and (null $compilingMap) and not(om = dm) and not(isSubDomain(om, dm)) =>
;         THROW('loopCompiler,'tryInterpOnly)
;       ['unwrap,['evalLETchangeValue,MKQ name,
;         objNewCode(['wrap,objVal value],objMode value)]]
;     value:= objNew(code,objMode value)
;     isLocalVar(name) =>
;       if not get(name,'mode,$env) then put(name,'autoDeclare,'T,$env)
;       put(name,'mode,objMode(value),$env)
;     put(name,'automode,objMode(value),$env)
;   $genValue and evalLETchangeValue(name,value)
;   putValue(lhs,value)

(DEFUN |evalLETput| (|lhs| |value|)
  (PROG (|name| |om| |dm| |code|)
    (RETURN
     (PROGN
      (SETQ |name| (|getUnname| |lhs|))
      (COND
       ((NULL |$genValue|)
        (SETQ |code|
                (COND
                 ((|isLocalVar| |name|)
                  (PROGN
                   (SETQ |om| (|objMode| |value|))
                   (SETQ |dm| (|get| |name| '|mode| |$env|))
                   (COND
                    ((AND |dm|
                          (NULL
                           (OR (EQUAL |om| |dm|) (|isSubDomain| |om| |dm|)
                               (|isSubDomain| |dm| |om|))))
                     (|compFailure|
                      (CONS "   The type of the local variable"
                            (APPEND (|bright| |name|)
                                    (CONS "has changed in the computation."
                                          NIL)))))
                    (#1='T
                     (PROGN
                      (COND
                       ((AND |dm| (|isSubDomain| |dm| |om|))
                        (|put| |name| '|mode| |om| |$env|)))
                      (LIST 'LET |name| (|objVal| |value|) |$mapName|))))))
                 (#1#
                  (PROGN
                   (SETQ |om| (|objMode| |value|))
                   (SETQ |dm|
                           (OR (|get| |name| '|mode| |$env|)
                               (|objMode| (|get| |name| '|value| |$e|))))
                   (COND
                    ((AND |dm| (NULL |$compilingMap|) (NULL (EQUAL |om| |dm|))
                          (NULL (|isSubDomain| |om| |dm|)))
                     (THROW '|loopCompiler| '|tryInterpOnly|))
                    (#1#
                     (LIST '|unwrap|
                           (LIST '|evalLETchangeValue| (MKQ |name|)
                                 (|objNewCode|
                                  (LIST '|wrap| (|objVal| |value|))
                                  (|objMode| |value|))))))))))
        (SETQ |value| (|objNew| |code| (|objMode| |value|)))
        (COND
         ((|isLocalVar| |name|)
          (PROGN
           (COND
            ((NULL (|get| |name| '|mode| |$env|))
             (|put| |name| '|autoDeclare| 'T |$env|)))
           (|put| |name| '|mode| (|objMode| |value|) |$env|)))
         (#1# (|put| |name| '|automode| (|objMode| |value|) |$env|)))))
      (AND |$genValue| (|evalLETchangeValue| |name| |value|))
      (|putValue| |lhs| |value|)))))

; upLETWithPatternOnLhs(t := [op,pattern,a]) ==
;   $opIsIs : local := true
;   [m] := bottomUp a
;   putPvarModes(pattern,m)
;   object := evalis(op,[a,pattern],m)
;   -- have to change code to return value of a
;   failCode :=
;     ['spadThrowBrightly,['concat,
;       '"   Pattern",['QUOTE,bright form2String pattern],
;         '"is not matched in assignment to right-hand side."]]
;   if $genValue
;     then
;       null objValUnwrap object => eval failCode
;       putValue(op,getValue a)
;     else
;       code := ['COND,[objVal object,objVal getValue a],[''T,failCode]]
;       putValue(op,objNew(code,m))
;   putModeSet(op,[m])

(DEFUN |upLETWithPatternOnLhs| (|t|)
  (PROG (|$opIsIs| |code| |failCode| |object| |m| |LETTMP#1| |a| |pattern|
         |op|)
    (DECLARE (SPECIAL |$opIsIs|))
    (RETURN
     (PROGN
      (SETQ |op| (CAR |t|))
      (SETQ |pattern| (CADR . #1=(|t|)))
      (SETQ |a| (CADDR . #1#))
      (SETQ |$opIsIs| T)
      (SETQ |LETTMP#1| (|bottomUp| |a|))
      (SETQ |m| (CAR |LETTMP#1|))
      (|putPvarModes| |pattern| |m|)
      (SETQ |object| (|evalis| |op| (LIST |a| |pattern|) |m|))
      (SETQ |failCode|
              (LIST '|spadThrowBrightly|
                    (LIST '|concat| "   Pattern"
                          (LIST 'QUOTE (|bright| (|form2String| |pattern|)))
                          "is not matched in assignment to right-hand side.")))
      (COND
       (|$genValue|
        (COND ((NULL (|objValUnwrap| |object|)) (|eval| |failCode|))
              (#2='T (|putValue| |op| (|getValue| |a|)))))
       (#2#
        (SETQ |code|
                (LIST 'COND
                      (LIST (|objVal| |object|) (|objVal| (|getValue| |a|)))
                      (LIST ''T |failCode|)))
        (|putValue| |op| (|objNew| |code| |m|))))
      (|putModeSet| |op| (LIST |m|))))))

; evalLETchangeValue(name,value) ==
;   -- write the value of name into the environment, clearing dependent
;   --  maps if its type changes from its last value
;   localEnv := PAIRP $env
;   clearCompilationsFlag :=
;     val:= (localEnv and get(name,'value,$env)) or get(name,'value,$e)
;     null val =>
;       not ((localEnv and get(name,'mode,$env)) or get(name,'mode,$e))
;     objMode val ~= objMode(value)
;   if clearCompilationsFlag then
;     clearDependencies(name)
;   if localEnv and isLocalVar(name)
;     then $env:= putHist(name,'value,value,$env)
;     else putIntSymTab(name,'value,value,$e)
;   objVal value

(DEFUN |evalLETchangeValue| (|name| |value|)
  (PROG (|localEnv| |val| |clearCompilationsFlag|)
    (RETURN
     (PROGN
      (SETQ |localEnv| (CONSP |$env|))
      (SETQ |clearCompilationsFlag|
              (PROGN
               (SETQ |val|
                       (OR (AND |localEnv| (|get| |name| '|value| |$env|))
                           (|get| |name| '|value| |$e|)))
               (COND
                ((NULL |val|)
                 (NULL
                  (OR (AND |localEnv| (|get| |name| '|mode| |$env|))
                      (|get| |name| '|mode| |$e|))))
                (#1='T (NOT (EQUAL (|objMode| |val|) (|objMode| |value|)))))))
      (COND (|clearCompilationsFlag| (|clearDependencies| |name|)))
      (COND
       ((AND |localEnv| (|isLocalVar| |name|))
        (SETQ |$env| (|putHist| |name| '|value| |value| |$env|)))
       (#1# (|putIntSymTab| |name| '|value| |value| |$e|)))
      (|objVal| |value|)))))

; upLETWithFormOnLhs(op,lhs,rhs) ==
;   -- bottomUp for assignment to forms (setelt, table or tuple)
;   lhs' := getUnnameIfCan lhs
;   rhs' := getUnnameIfCan rhs
;   lhs' = 'Tuple =>
;     rhs' ~= 'Tuple => throwKeyedMsg("S2IS0039",NIL)
;     #(lhs) ~= #(rhs) => throwKeyedMsg("S2IS0038",NIL)
;     -- generate a sequence of assignments, using local variables
;     -- to first hold the assignments so that things like
;     -- (t1,t2) := (t2,t1) will work.
;     seq := []
;     temps := [GENSYM() for l in rest lhs]
;     for lvar in temps repeat mkLocalVar($mapName,lvar)
;     for l in reverse rest lhs for t in temps repeat
;       transferPropsToNode(getUnname l,l)
;       let := mkAtreeNode 'LET
;       t'  := mkAtreeNode t
;       if m := getMode(l) then putMode(t',m)
;       seq := cons([let,l,t'],seq)
;     for t in temps for r in reverse rest rhs
;       for l in reverse rest lhs repeat
;         let := mkAtreeNode 'LET
;         t'  := mkAtreeNode t
;         if m := getMode(l) then putMode(t',m)
;         seq := cons([let,t',r],seq)
;     seq := cons(mkAtreeNode 'SEQ,seq)
;     ms := bottomUp seq
;     putValue(op,getValue seq)
;     putModeSet(op,ms)
;   rhs' = 'Tuple => throwKeyedMsg("S2IS0039",NIL)
;   tree:= seteltable(lhs,rhs) => upSetelt(op,lhs,tree)
;   throwKeyedMsg("S2IS0060", NIL)

(DEFUN |upLETWithFormOnLhs| (|op| |lhs| |rhs|)
  (PROG (|lhs'| |rhs'| |seq| |temps| |let| |t'| |m| |ms| |tree|)
    (RETURN
     (PROGN
      (SETQ |lhs'| (|getUnnameIfCan| |lhs|))
      (SETQ |rhs'| (|getUnnameIfCan| |rhs|))
      (COND
       ((EQ |lhs'| '|Tuple|)
        (COND ((NOT (EQ |rhs'| '|Tuple|)) (|throwKeyedMsg| 'S2IS0039 NIL))
              ((NOT (EQL (LENGTH |lhs|) (LENGTH |rhs|)))
               (|throwKeyedMsg| 'S2IS0038 NIL))
              (#1='T
               (PROGN
                (SETQ |seq| NIL)
                (SETQ |temps|
                        ((LAMBDA (|bfVar#21| |bfVar#20| |l|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#20|)
                                  (PROGN (SETQ |l| (CAR |bfVar#20|)) NIL))
                              (RETURN (NREVERSE |bfVar#21|)))
                             (#1#
                              (SETQ |bfVar#21| (CONS (GENSYM) |bfVar#21|))))
                            (SETQ |bfVar#20| (CDR |bfVar#20|))))
                         NIL (CDR |lhs|) NIL))
                ((LAMBDA (|bfVar#22| |lvar|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#22|)
                          (PROGN (SETQ |lvar| (CAR |bfVar#22|)) NIL))
                      (RETURN NIL))
                     (#1# (|mkLocalVar| |$mapName| |lvar|)))
                    (SETQ |bfVar#22| (CDR |bfVar#22|))))
                 |temps| NIL)
                ((LAMBDA (|bfVar#23| |l| |bfVar#24| |t|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#23|)
                          (PROGN (SETQ |l| (CAR |bfVar#23|)) NIL)
                          (ATOM |bfVar#24|)
                          (PROGN (SETQ |t| (CAR |bfVar#24|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (PROGN
                       (|transferPropsToNode| (|getUnname| |l|) |l|)
                       (SETQ |let| (|mkAtreeNode| 'LET))
                       (SETQ |t'| (|mkAtreeNode| |t|))
                       (COND ((SETQ |m| (|getMode| |l|)) (|putMode| |t'| |m|)))
                       (SETQ |seq| (CONS (LIST |let| |l| |t'|) |seq|)))))
                    (SETQ |bfVar#23| (CDR |bfVar#23|))
                    (SETQ |bfVar#24| (CDR |bfVar#24|))))
                 (REVERSE (CDR |lhs|)) NIL |temps| NIL)
                ((LAMBDA (|bfVar#25| |t| |bfVar#26| |r| |bfVar#27| |l|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#25|)
                          (PROGN (SETQ |t| (CAR |bfVar#25|)) NIL)
                          (ATOM |bfVar#26|)
                          (PROGN (SETQ |r| (CAR |bfVar#26|)) NIL)
                          (ATOM |bfVar#27|)
                          (PROGN (SETQ |l| (CAR |bfVar#27|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (PROGN
                       (SETQ |let| (|mkAtreeNode| 'LET))
                       (SETQ |t'| (|mkAtreeNode| |t|))
                       (COND ((SETQ |m| (|getMode| |l|)) (|putMode| |t'| |m|)))
                       (SETQ |seq| (CONS (LIST |let| |t'| |r|) |seq|)))))
                    (SETQ |bfVar#25| (CDR |bfVar#25|))
                    (SETQ |bfVar#26| (CDR |bfVar#26|))
                    (SETQ |bfVar#27| (CDR |bfVar#27|))))
                 |temps| NIL (REVERSE (CDR |rhs|)) NIL (REVERSE (CDR |lhs|))
                 NIL)
                (SETQ |seq| (CONS (|mkAtreeNode| 'SEQ) |seq|))
                (SETQ |ms| (|bottomUp| |seq|))
                (|putValue| |op| (|getValue| |seq|))
                (|putModeSet| |op| |ms|)))))
       ((EQ |rhs'| '|Tuple|) (|throwKeyedMsg| 'S2IS0039 NIL))
       ((SETQ |tree| (|seteltable| |lhs| |rhs|))
        (|upSetelt| |op| |lhs| |tree|))
       (#1# (|throwKeyedMsg| 'S2IS0060 NIL)))))))

; get_opname_if_can(f) ==
;     VECP(f) => f.0
;     nil

(DEFUN |get_opname_if_can| (|f|)
  (PROG () (RETURN (COND ((VECP |f|) (ELT |f| 0)) ('T NIL)))))

; seteltable(lhs is [f,:argl],rhs) ==
;   -- produces the setelt form for trees such as "l.2:= 3"
;   g := get_opname_if_can f
;   EQ(g,'elt) => altSeteltable [:argl, rhs]
;   altSeteltable [:lhs,rhs]

(DEFUN |seteltable| (|lhs| |rhs|)
  (PROG (|f| |argl| |g|)
    (RETURN
     (PROGN
      (SETQ |f| (CAR |lhs|))
      (SETQ |argl| (CDR |lhs|))
      (SETQ |g| (|get_opname_if_can| |f|))
      (COND
       ((EQ |g| '|elt|) (|altSeteltable| (APPEND |argl| (CONS |rhs| NIL))))
       ('T (|altSeteltable| (APPEND |lhs| (CONS |rhs| NIL)))))))))

; altSeteltable args ==
;     for x in args repeat bottomUp x
;     newOps := [mkAtreeNode "setelt!", mkAtreeNode "set!"]
;     form := NIL
;
;     -- first look for exact matches for any of the possibilities
;     while not form for newOp in newOps  repeat
;         if selectMms(newOp, args, NIL) then form := [newOp, :args]
;
;     -- now try retracting arguments after the first
;     while not form and ( "and"/[retractAtree(a) for a in rest args] ) repeat
;         while not form for newOp in newOps  repeat
;             if selectMms(newOp, args, NIL) then form := [newOp, :args]
;
;     form

(DEFUN |altSeteltable| (|args|)
  (PROG (|newOps| |form|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#28| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#28|) (PROGN (SETQ |x| (CAR |bfVar#28|)) NIL))
            (RETURN NIL))
           (#1='T (|bottomUp| |x|)))
          (SETQ |bfVar#28| (CDR |bfVar#28|))))
       |args| NIL)
      (SETQ |newOps| (LIST (|mkAtreeNode| '|setelt!|) (|mkAtreeNode| '|set!|)))
      (SETQ |form| NIL)
      ((LAMBDA (|bfVar#29| |newOp|)
         (LOOP
          (COND
           ((OR |form| (ATOM |bfVar#29|)
                (PROGN (SETQ |newOp| (CAR |bfVar#29|)) NIL))
            (RETURN NIL))
           (#1#
            (COND
             ((|selectMms| |newOp| |args| NIL)
              (SETQ |form| (CONS |newOp| |args|))))))
          (SETQ |bfVar#29| (CDR |bfVar#29|))))
       |newOps| NIL)
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT
             (AND (NULL |form|)
                  ((LAMBDA (|bfVar#31| |bfVar#30| |a|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#30|)
                            (PROGN (SETQ |a| (CAR |bfVar#30|)) NIL))
                        (RETURN |bfVar#31|))
                       (#1#
                        (PROGN
                         (SETQ |bfVar#31| (|retractAtree| |a|))
                         (COND ((NOT |bfVar#31|) (RETURN NIL))))))
                      (SETQ |bfVar#30| (CDR |bfVar#30|))))
                   T (CDR |args|) NIL)))
            (RETURN NIL))
           (#1#
            ((LAMBDA (|bfVar#32| |newOp|)
               (LOOP
                (COND
                 ((OR |form| (ATOM |bfVar#32|)
                      (PROGN (SETQ |newOp| (CAR |bfVar#32|)) NIL))
                  (RETURN NIL))
                 (#1#
                  (COND
                   ((|selectMms| |newOp| |args| NIL)
                    (SETQ |form| (CONS |newOp| |args|))))))
                (SETQ |bfVar#32| (CDR |bfVar#32|))))
             |newOps| NIL))))))
      |form|))))

; upSetelt(op,lhs,tree) ==
;   -- type analyzes implicit setelt forms
;   var:=opOf lhs
;   transferPropsToNode(getUnname var,var)
;   if (m1:=getMode var) then $declaredMode:= m1
;   if m1 or ((v1 := getValue var) and (m1 := objMode v1)) then
;     putModeSet(var,[m1])
;   ms := bottomUp tree
;   putValue(op,getValue tree)
;   putModeSet(op,ms)

(DEFUN |upSetelt| (|op| |lhs| |tree|)
  (PROG (|var| |m1| |v1| |ms|)
    (RETURN
     (PROGN
      (SETQ |var| (|opOf| |lhs|))
      (|transferPropsToNode| (|getUnname| |var|) |var|)
      (COND ((SETQ |m1| (|getMode| |var|)) (SETQ |$declaredMode| |m1|)))
      (COND
       ((OR |m1|
            (AND (SETQ |v1| (|getValue| |var|)) (SETQ |m1| (|objMode| |v1|))))
        (|putModeSet| |var| (LIST |m1|))))
      (SETQ |ms| (|bottomUp| |tree|))
      (|putValue| |op| (|getValue| |tree|))
      (|putModeSet| |op| |ms|)))))

; upTableSetelt(op,lhs is [htOp,:args],rhs) ==
;   -- called only for undeclared, uninitialized table setelts
;   ("*" = (PNAME getUnname htOp).0) and (1 ~= # args) =>
;     throwKeyedMsg("S2IS0040",NIL)
;   # args ~= 1 =>
;     throwKeyedMsg("S2IS0041",[[getUnname htOp,'".[",
;       getUnname first args,
;         ['",",getUnname arg for arg in rest args],'"]"]])
;   keyMode := '(Any)
;   putMode (htOp,['Table,keyMode,'(Any)])
;   -- if we are to use a new table, we must call the "table"
;   -- function to give it an initial value.
;   bottomUp [mkAtreeNode 'LET,htOp,[mkAtreeNode 'table]]
;   tableCode := objVal getValue htOp
;   r := upSetelt(op, lhs, [mkAtreeNode "setelt!", :lhs, rhs])
;   $genValue => r
;   -- construct code
;   t := getValue op
;   putValue(op,objNew(['PROGN,tableCode,objVal t],objMode t))
;   r

(DEFUN |upTableSetelt| (|op| |lhs| |rhs|)
  (PROG (|htOp| |args| |keyMode| |tableCode| |r| |t|)
    (RETURN
     (PROGN
      (SETQ |htOp| (CAR |lhs|))
      (SETQ |args| (CDR |lhs|))
      (COND
       ((AND (EQ '* (ELT (PNAME (|getUnname| |htOp|)) 0))
             (NOT (EQL 1 (LENGTH |args|))))
        (|throwKeyedMsg| 'S2IS0040 NIL))
       ((NOT (EQL (LENGTH |args|) 1))
        (|throwKeyedMsg| 'S2IS0041
         (LIST
          (LIST (|getUnname| |htOp|) ".[" (|getUnname| (CAR |args|))
                ((LAMBDA (|bfVar#34| |bfVar#33| |arg|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#33|)
                          (PROGN (SETQ |arg| (CAR |bfVar#33|)) NIL))
                      (RETURN (NREVERSE |bfVar#34|)))
                     (#1='T
                      (SETQ |bfVar#34|
                              (APPEND
                               (REVERSE
                                (CONS "," (CONS (|getUnname| |arg|) NIL)))
                               |bfVar#34|))))
                    (SETQ |bfVar#33| (CDR |bfVar#33|))))
                 NIL (CDR |args|) NIL)
                "]"))))
       (#1#
        (PROGN
         (SETQ |keyMode| '(|Any|))
         (|putMode| |htOp| (LIST '|Table| |keyMode| '(|Any|)))
         (|bottomUp|
          (LIST (|mkAtreeNode| 'LET) |htOp| (LIST (|mkAtreeNode| '|table|))))
         (SETQ |tableCode| (|objVal| (|getValue| |htOp|)))
         (SETQ |r|
                 (|upSetelt| |op| |lhs|
                  (CONS (|mkAtreeNode| '|setelt!|)
                        (APPEND |lhs| (CONS |rhs| NIL)))))
         (COND (|$genValue| |r|)
               (#1#
                (PROGN
                 (SETQ |t| (|getValue| |op|))
                 (|putValue| |op|
                  (|objNew| (LIST 'PROGN |tableCode| (|objVal| |t|))
                   (|objMode| |t|)))
                 |r|))))))))))

; isType t ==
;   -- Returns the evaluated type if t is a tree representing a type,
;   -- and NIL otherwise
;    op:=opOf t
;    VECP op =>
;      isMap(op:= getUnname op) => NIL
;      op = 'Mapping =>
;        argTypes := [isType type for type in rest t]
;        "or"/[null type for type in argTypes] => nil
;        ['Mapping, :argTypes]
;      isLocalVar(op) => NIL
;      d := isDomainValuedVariable op => d
;      type:=
;        -- next line handles subscripted vars
;          (abbreviation?(op) or (op = 'typeOf) or
;            constructor?(op) or (op in '(Record Union Enumeration))) and
;              unabbrev unVectorize t
;      type and evaluateType type
;    d := isDomainValuedVariable op => d
;    NIL

(DEFUN |isType| (|t|)
  (PROG (|op| |argTypes| |d| |type|)
    (RETURN
     (PROGN
      (SETQ |op| (|opOf| |t|))
      (COND
       ((VECP |op|)
        (COND ((|isMap| (SETQ |op| (|getUnname| |op|))) NIL)
              ((EQ |op| '|Mapping|)
               (PROGN
                (SETQ |argTypes|
                        ((LAMBDA (|bfVar#36| |bfVar#35| |type|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#35|)
                                  (PROGN (SETQ |type| (CAR |bfVar#35|)) NIL))
                              (RETURN (NREVERSE |bfVar#36|)))
                             (#1='T
                              (SETQ |bfVar#36|
                                      (CONS (|isType| |type|) |bfVar#36|))))
                            (SETQ |bfVar#35| (CDR |bfVar#35|))))
                         NIL (CDR |t|) NIL))
                (COND
                 (((LAMBDA (|bfVar#38| |bfVar#37| |type|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#37|)
                            (PROGN (SETQ |type| (CAR |bfVar#37|)) NIL))
                        (RETURN |bfVar#38|))
                       (#1#
                        (PROGN
                         (SETQ |bfVar#38| (NULL |type|))
                         (COND (|bfVar#38| (RETURN |bfVar#38|))))))
                      (SETQ |bfVar#37| (CDR |bfVar#37|))))
                   NIL |argTypes| NIL)
                  NIL)
                 (#1# (CONS '|Mapping| |argTypes|)))))
              ((|isLocalVar| |op|) NIL)
              ((SETQ |d| (|isDomainValuedVariable| |op|)) |d|)
              (#1#
               (PROGN
                (SETQ |type|
                        (AND
                         (OR (|abbreviation?| |op|) (EQ |op| '|typeOf|)
                             (|constructor?| |op|)
                             (|member| |op| '(|Record| |Union| |Enumeration|)))
                         (|unabbrev| (|unVectorize| |t|))))
                (AND |type| (|evaluateType| |type|))))))
       ((SETQ |d| (|isDomainValuedVariable| |op|)) |d|) (#1# NIL))))))

; upLETtype(op,lhs,type) ==
;   -- performs type assignment
;   opName:= getUnname lhs
;   (not $genValue) and or/[CONTAINED(var,type) for var in $localVars] =>
;     compFailure ['"   Cannot compile type assignment to",:bright opName]
;   mode :=
;     if isPartialMode type then '(Mode)
;     else if categoryForm?(type) then '(Category)
;          else '(Type)
;   val:= objNew(type,mode)
;   if isLocalVar(opName) then put(opName,'value,val,$env)
;   else putHist(opName,'value,val,$e)
;   putValue(op,val)
;   -- have to fix the following
;   putModeSet(op,[mode])

(DEFUN |upLETtype| (|op| |lhs| |type|)
  (PROG (|opName| |mode| |val|)
    (RETURN
     (PROGN
      (SETQ |opName| (|getUnname| |lhs|))
      (COND
       ((AND (NULL |$genValue|)
             ((LAMBDA (|bfVar#40| |bfVar#39| |var|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#39|)
                       (PROGN (SETQ |var| (CAR |bfVar#39|)) NIL))
                   (RETURN |bfVar#40|))
                  (#1='T
                   (PROGN
                    (SETQ |bfVar#40| (CONTAINED |var| |type|))
                    (COND (|bfVar#40| (RETURN |bfVar#40|))))))
                 (SETQ |bfVar#39| (CDR |bfVar#39|))))
              NIL |$localVars| NIL))
        (|compFailure|
         (CONS "   Cannot compile type assignment to" (|bright| |opName|))))
       (#1#
        (PROGN
         (SETQ |mode|
                 (COND ((|isPartialMode| |type|) '(|Mode|))
                       ((|categoryForm?| |type|) '(|Category|))
                       (#1# '(|Type|))))
         (SETQ |val| (|objNew| |type| |mode|))
         (COND ((|isLocalVar| |opName|) (|put| |opName| '|value| |val| |$env|))
               (#1# (|putHist| |opName| '|value| |val| |$e|)))
         (|putValue| |op| |val|)
         (|putModeSet| |op| (LIST |mode|)))))))))

; assignSymbol(symbol, value, domain) ==
; -- Special function for binding an interpreter variable from within algebra
; -- code.  Does not do the assignment and returns nil, if the variable is
; -- already assigned
;   val := get(symbol, 'value, $e) => nil
;   obj := objNew(wrap value, devaluate domain)
;   put(symbol, 'value, obj, $e)
;   true

(DEFUN |assignSymbol| (|symbol| |value| |domain|)
  (PROG (|val| |obj|)
    (RETURN
     (COND ((SETQ |val| (|get| |symbol| '|value| |$e|)) NIL)
           ('T
            (PROGN
             (SETQ |obj| (|objNew| (|wrap| |value|) (|devaluate| |domain|)))
             (|put| |symbol| '|value| |obj| |$e|)
             T))))))

; getInterpMacroNames() ==
;   names := [n for [n,:.] in $InterpreterMacroAlist]
;   if (e := CAAR $InteractiveFrame) and (m := assoc("--macros--",e)) then
;     names := append(names, [n for [n, :.] in rest m])
;   MSORT names

(DEFUN |getInterpMacroNames| ()
  (PROG (|m| |e| |names| |n|)
    (RETURN
     (PROGN
      (SETQ |names|
              ((LAMBDA (|bfVar#43| |bfVar#42| |bfVar#41|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#42|)
                        (PROGN (SETQ |bfVar#41| (CAR |bfVar#42|)) NIL))
                    (RETURN (NREVERSE |bfVar#43|)))
                   (#1='T
                    (AND (CONSP |bfVar#41|)
                         (PROGN (SETQ |n| (CAR |bfVar#41|)) #1#)
                         (SETQ |bfVar#43| (CONS |n| |bfVar#43|)))))
                  (SETQ |bfVar#42| (CDR |bfVar#42|))))
               NIL |$InterpreterMacroAlist| NIL))
      (COND
       ((AND (SETQ |e| (CAAR |$InteractiveFrame|))
             (SETQ |m| (|assoc| '|--macros--| |e|)))
        (SETQ |names|
                (APPEND |names|
                        ((LAMBDA (|bfVar#46| |bfVar#45| |bfVar#44|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#45|)
                                  (PROGN
                                   (SETQ |bfVar#44| (CAR |bfVar#45|))
                                   NIL))
                              (RETURN (NREVERSE |bfVar#46|)))
                             (#1#
                              (AND (CONSP |bfVar#44|)
                                   (PROGN (SETQ |n| (CAR |bfVar#44|)) #1#)
                                   (SETQ |bfVar#46| (CONS |n| |bfVar#46|)))))
                            (SETQ |bfVar#45| (CDR |bfVar#45|))))
                         NIL (CDR |m|) NIL)))))
      (MSORT |names|)))))

; isInterpMacro name ==
;   -- look in local and then global environment for a macro
;   null IDENTP name => NIL
;   name in $specialOps => NIL
;   (m := get("--macros--",name,$env)) => m
;   (m := get("--macros--",name,$e))   => m
;   (m := get("--macros--",name,$InteractiveFrame))   => m
;   -- $InterpreterMacroAlist will probably be phased out soon
;   (sv := assoc(name, $InterpreterMacroAlist)) => CONS(NIL, rest sv)
;   NIL

(DEFUN |isInterpMacro| (|name|)
  (PROG (|m| |sv|)
    (RETURN
     (COND ((NULL (IDENTP |name|)) NIL) ((|member| |name| |$specialOps|) NIL)
           ((SETQ |m| (|get| '|--macros--| |name| |$env|)) |m|)
           ((SETQ |m| (|get| '|--macros--| |name| |$e|)) |m|)
           ((SETQ |m| (|get| '|--macros--| |name| |$InteractiveFrame|)) |m|)
           ((SETQ |sv| (|assoc| |name| |$InterpreterMacroAlist|))
            (CONS NIL (CDR |sv|)))
           ('T NIL)))))

; upQUOTE t ==
;   t isnt [op,expr] => NIL
;   ms:= list
;     m:= getBasicMode expr => m
;     IDENTP expr =>
; --    $useSymbolNotVariable => $Symbol
;       ['Variable,expr]
;     $OutputForm
;   evalQUOTE(op,[expr],ms)
;   putModeSet(op,ms)

(DEFUN |upQUOTE| (|t|)
  (PROG (|op| |ISTMP#1| |expr| |m| |ms|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |expr| (CAR |ISTMP#1|)) #1='T)))))
       NIL)
      (#1#
       (PROGN
        (SETQ |ms|
                (LIST
                 (COND ((SETQ |m| (|getBasicMode| |expr|)) |m|)
                       ((IDENTP |expr|) (LIST '|Variable| |expr|))
                       (#1# |$OutputForm|))))
        (|evalQUOTE| |op| (LIST |expr|) |ms|)
        (|putModeSet| |op| |ms|)))))))

; evalQUOTE(op,[expr],[m]) ==
;   triple:=
;     $genValue => objNewWrap(expr,m)
;     objNew(['QUOTE,expr],m)
;   putValue(op,triple)

(DEFUN |evalQUOTE| (|op| |bfVar#47| |bfVar#48|)
  (PROG (|m| |expr| |triple|)
    (RETURN
     (PROGN
      (SETQ |m| (CAR |bfVar#48|))
      (SETQ |expr| (CAR |bfVar#47|))
      (SETQ |triple|
              (COND (|$genValue| (|objNewWrap| |expr| |m|))
                    ('T (|objNew| (LIST 'QUOTE |expr|) |m|))))
      (|putValue| |op| |triple|)))))

; uppretend t ==
;   t isnt [op,expr,type] => NIL
;   mode := evaluateType unabbrev type
;   not isValidType(mode) => throwKeyedMsg("S2IE0004",[mode])
;   bottomUp expr
;   putValue(op,objNew(objVal getValue expr,mode))
;   putModeSet(op,[mode])

(DEFUN |uppretend| (|t|)
  (PROG (|op| |ISTMP#1| |expr| |ISTMP#2| |type| |mode|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |expr| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |type| (CAR |ISTMP#2|)) #1='T)))))))
       NIL)
      (#1#
       (PROGN
        (SETQ |mode| (|evaluateType| (|unabbrev| |type|)))
        (COND
         ((NULL (|isValidType| |mode|))
          (|throwKeyedMsg| 'S2IE0004 (LIST |mode|)))
         (#1#
          (PROGN
           (|bottomUp| |expr|)
           (|putValue| |op| (|objNew| (|objVal| (|getValue| |expr|)) |mode|))
           (|putModeSet| |op| (LIST |mode|)))))))))))

; getReduceFunction(op,type,result, locale) ==
;   -- return the function cell for operation with the signature
;   --  (type,type) -> type, possible from locale
;   if type is ['Variable,var] then
;     args := [arg := mkAtreeNode var,arg]
;     putValue(arg,objNewWrap(var,type))
;   else
;     args := [arg := mkAtreeNode "%1",arg]
;     if type=$Symbol then putValue(arg,objNewWrap("%1",$Symbol))
;   putModeSet(arg,[type])
;   vecOp:=mkAtreeNode op
;   transferPropsToNode(op,vecOp)
;   if locale then putAtree(vecOp,'dollar,locale)
;   mmS:= selectMms(vecOp,args,result)
;   mm:= or/[mm for (mm:=[[.,:sig],fun,cond]) in mmS |
;     (isHomogeneousArgs sig) and and/[null c for c in cond]]
;   null mm => 'failed
;   [[dc,:sig],fun,:.]:=mm
;   dc = 'local => [MKQ [fun, :'local], :first sig]
;   dcVector := evalDomain dc
;   $compilingMap =>
;     k := NRTgetMinivectorIndex(
;       NRTcompiledLookup(op,sig,dcVector),op,sig,dcVector)
;     ['ELT,"$$$",k]  --$$$ denotes minivector
;   env:=
;     NRTcompiledLookup(op,sig,dcVector)
;   MKQ env

(DEFUN |getReduceFunction| (|op| |type| |result| |locale|)
  (PROG (|ISTMP#1| |var| |arg| |args| |vecOp| |mmS| |sig| |ISTMP#2| |fun|
         |ISTMP#3| |cond| |mm| |dc| |dcVector| |k| |env|)
    (RETURN
     (PROGN
      (COND
       ((AND (CONSP |type|) (EQ (CAR |type|) '|Variable|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |type|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1='T))))
        (SETQ |args| (LIST (SETQ |arg| (|mkAtreeNode| |var|)) |arg|))
        (|putValue| |arg| (|objNewWrap| |var| |type|)))
       (#1# (SETQ |args| (LIST (SETQ |arg| (|mkAtreeNode| '%1)) |arg|))
        (COND
         ((EQUAL |type| |$Symbol|)
          (|putValue| |arg| (|objNewWrap| '%1 |$Symbol|))))))
      (|putModeSet| |arg| (LIST |type|))
      (SETQ |vecOp| (|mkAtreeNode| |op|))
      (|transferPropsToNode| |op| |vecOp|)
      (COND (|locale| (|putAtree| |vecOp| '|dollar| |locale|)))
      (SETQ |mmS| (|selectMms| |vecOp| |args| |result|))
      (SETQ |mm|
              ((LAMBDA (|bfVar#52| |bfVar#49| |mm|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#49|)
                        (PROGN (SETQ |mm| (CAR |bfVar#49|)) NIL))
                    (RETURN |bfVar#52|))
                   (#1#
                    (AND (CONSP |mm|)
                         (PROGN
                          (SETQ |ISTMP#1| (CAR |mm|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN (SETQ |sig| (CDR |ISTMP#1|)) #1#)))
                         (PROGN
                          (SETQ |ISTMP#2| (CDR |mm|))
                          (AND (CONSP |ISTMP#2|)
                               (PROGN
                                (SETQ |fun| (CAR |ISTMP#2|))
                                (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                     (PROGN
                                      (SETQ |cond| (CAR |ISTMP#3|))
                                      #1#)))))
                         (|isHomogeneousArgs| |sig|)
                         ((LAMBDA (|bfVar#51| |bfVar#50| |c|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#50|)
                                   (PROGN (SETQ |c| (CAR |bfVar#50|)) NIL))
                               (RETURN |bfVar#51|))
                              (#1#
                               (PROGN
                                (SETQ |bfVar#51| (NULL |c|))
                                (COND ((NOT |bfVar#51|) (RETURN NIL))))))
                             (SETQ |bfVar#50| (CDR |bfVar#50|))))
                          T |cond| NIL)
                         (PROGN
                          (SETQ |bfVar#52| |mm|)
                          (COND (|bfVar#52| (RETURN |bfVar#52|)))))))
                  (SETQ |bfVar#49| (CDR |bfVar#49|))))
               NIL |mmS| NIL))
      (COND ((NULL |mm|) '|failed|)
            (#1#
             (PROGN
              (SETQ |dc| (CAAR . #2=(|mm|)))
              (SETQ |sig| (CDAR . #2#))
              (SETQ |fun| (CADR |mm|))
              (COND
               ((EQ |dc| '|local|)
                (CONS (MKQ (CONS |fun| '|local|)) (CAR |sig|)))
               (#1#
                (PROGN
                 (SETQ |dcVector| (|evalDomain| |dc|))
                 (COND
                  (|$compilingMap|
                   (PROGN
                    (SETQ |k|
                            (|NRTgetMinivectorIndex|
                             (|NRTcompiledLookup| |op| |sig| |dcVector|) |op|
                             |sig| |dcVector|))
                    (LIST 'ELT '$$$ |k|)))
                  (#1#
                   (PROGN
                    (SETQ |env| (|NRTcompiledLookup| |op| |sig| |dcVector|))
                    (MKQ |env|))))))))))))))

; isHomogeneous sig ==
;   --return true if sig describes a homogeneous binary operation
;   sig.0=sig.1 and sig.1=sig.2

(DEFUN |isHomogeneous| (|sig|)
  (PROG ()
    (RETURN
     (AND (EQUAL (ELT |sig| 0) (ELT |sig| 1))
          (EQUAL (ELT |sig| 1) (ELT |sig| 2))))))

; isHomogeneousArgs sig ==
;   --return true if sig describes a homogeneous binary operation
;   sig.1=sig.2

(DEFUN |isHomogeneousArgs| (|sig|)
  (PROG () (RETURN (EQUAL (ELT |sig| 1) (ELT |sig| 2)))))

; transformREPEAT [:itrl,body] ==
;   -- syntactic transformation of repeat iterators, called from mkAtree2
;   iterList:=[:iterTran1 for it in itrl] where iterTran1 ==
;     it is ['STEP,index,lower,step,:upperList] =>
;       [['STEP,index,mkAtree1 lower,mkAtree1 step,:[mkAtree1 upper
;         for upper in upperList]]]
;     it is ['IN,index,s] =>
;       [['IN,index,mkAtree1 s]]
;     it is ['ON,index,s] =>
;       [['IN,index,mkAtree1 ['tails,s]]]
;     it is ['WHILE,b] =>
;       [['WHILE,mkAtree1 b]]
;     it is ['_|,pred] =>
;       [['SUCHTHAT,mkAtree1 pred]]
;     it is [op,:.] and (op in '(VALUE UNTIL)) => nil
;   bodyTree:=mkAtree1 body
;   iterList:=NCONC(iterList,[:iterTran2 for it in itrl]) where iterTran2 ==
;     it is ['STEP,:.] => nil
;     it is ['IN,:.] => nil
;     it is ['ON,:.] => nil
;     it is ['WHILE,:.] => nil
;     it is [op,b] and (op in '(UNTIL VALUE)) =>
;       [[op,mkAtree1 b]]
;     it is ['_|,pred] => nil
;     keyedSystemError("S2GE0016",
;       ['"transformREPEAT",'"Unknown type of iterator"])
;   [:iterList,bodyTree]

(DEFUN |transformREPEAT| (|bfVar#59|)
  (PROG (|LETTMP#1| |body| |itrl| |ISTMP#1| |index| |ISTMP#2| |lower| |ISTMP#3|
         |step| |upperList| |s| |b| |pred| |op| |iterList| |bodyTree|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE |bfVar#59|))
      (SETQ |body| (CAR |LETTMP#1|))
      (SETQ |itrl| (NREVERSE (CDR |LETTMP#1|)))
      (SETQ |iterList|
              ((LAMBDA (|bfVar#54| |bfVar#53| |it|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#53|)
                        (PROGN (SETQ |it| (CAR |bfVar#53|)) NIL))
                    (RETURN (NREVERSE |bfVar#54|)))
                   (#1='T
                    (SETQ |bfVar#54|
                            (APPEND
                             (REVERSE
                              (COND
                               ((AND (CONSP |it|) (EQ (CAR |it|) 'STEP)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |it|))
                                      (AND (CONSP |ISTMP#1|)
                                           (PROGN
                                            (SETQ |index| (CAR |ISTMP#1|))
                                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                            (AND (CONSP |ISTMP#2|)
                                                 (PROGN
                                                  (SETQ |lower|
                                                          (CAR |ISTMP#2|))
                                                  (SETQ |ISTMP#3|
                                                          (CDR |ISTMP#2|))
                                                  (AND (CONSP |ISTMP#3|)
                                                       (PROGN
                                                        (SETQ |step|
                                                                (CAR
                                                                 |ISTMP#3|))
                                                        (SETQ |upperList|
                                                                (CDR
                                                                 |ISTMP#3|))
                                                        #1#))))))))
                                (LIST
                                 (CONS 'STEP
                                       (CONS |index|
                                             (CONS (|mkAtree1| |lower|)
                                                   (CONS (|mkAtree1| |step|)
                                                         ((LAMBDA
                                                              (|bfVar#56|
                                                               |bfVar#55|
                                                               |upper|)
                                                            (LOOP
                                                             (COND
                                                              ((OR
                                                                (ATOM
                                                                 |bfVar#55|)
                                                                (PROGN
                                                                 (SETQ |upper|
                                                                         (CAR
                                                                          |bfVar#55|))
                                                                 NIL))
                                                               (RETURN
                                                                (NREVERSE
                                                                 |bfVar#56|)))
                                                              (#1#
                                                               (SETQ |bfVar#56|
                                                                       (CONS
                                                                        (|mkAtree1|
                                                                         |upper|)
                                                                        |bfVar#56|))))
                                                             (SETQ |bfVar#55|
                                                                     (CDR
                                                                      |bfVar#55|))))
                                                          NIL |upperList|
                                                          NIL)))))))
                               ((AND (CONSP |it|) (EQ (CAR |it|) 'IN)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |it|))
                                      (AND (CONSP |ISTMP#1|)
                                           (PROGN
                                            (SETQ |index| (CAR |ISTMP#1|))
                                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                            (AND (CONSP |ISTMP#2|)
                                                 (EQ (CDR |ISTMP#2|) NIL)
                                                 (PROGN
                                                  (SETQ |s| (CAR |ISTMP#2|))
                                                  #1#))))))
                                (LIST (LIST 'IN |index| (|mkAtree1| |s|))))
                               ((AND (CONSP |it|) (EQ (CAR |it|) 'ON)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |it|))
                                      (AND (CONSP |ISTMP#1|)
                                           (PROGN
                                            (SETQ |index| (CAR |ISTMP#1|))
                                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                            (AND (CONSP |ISTMP#2|)
                                                 (EQ (CDR |ISTMP#2|) NIL)
                                                 (PROGN
                                                  (SETQ |s| (CAR |ISTMP#2|))
                                                  #1#))))))
                                (LIST
                                 (LIST 'IN |index|
                                       (|mkAtree1| (LIST '|tails| |s|)))))
                               ((AND (CONSP |it|) (EQ (CAR |it|) 'WHILE)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |it|))
                                      (AND (CONSP |ISTMP#1|)
                                           (EQ (CDR |ISTMP#1|) NIL)
                                           (PROGN
                                            (SETQ |b| (CAR |ISTMP#1|))
                                            #1#))))
                                (LIST (LIST 'WHILE (|mkAtree1| |b|))))
                               ((AND (CONSP |it|) (EQ (CAR |it|) '|\||)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |it|))
                                      (AND (CONSP |ISTMP#1|)
                                           (EQ (CDR |ISTMP#1|) NIL)
                                           (PROGN
                                            (SETQ |pred| (CAR |ISTMP#1|))
                                            #1#))))
                                (LIST (LIST 'SUCHTHAT (|mkAtree1| |pred|))))
                               ((AND (CONSP |it|)
                                     (PROGN (SETQ |op| (CAR |it|)) #1#)
                                     (|member| |op| '(VALUE UNTIL)))
                                NIL)))
                             |bfVar#54|))))
                  (SETQ |bfVar#53| (CDR |bfVar#53|))))
               NIL |itrl| NIL))
      (SETQ |bodyTree| (|mkAtree1| |body|))
      (SETQ |iterList|
              (NCONC |iterList|
                     ((LAMBDA (|bfVar#58| |bfVar#57| |it|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#57|)
                               (PROGN (SETQ |it| (CAR |bfVar#57|)) NIL))
                           (RETURN (NREVERSE |bfVar#58|)))
                          (#1#
                           (SETQ |bfVar#58|
                                   (APPEND
                                    (REVERSE
                                     (COND
                                      ((AND (CONSP |it|) (EQ (CAR |it|) 'STEP))
                                       NIL)
                                      ((AND (CONSP |it|) (EQ (CAR |it|) 'IN))
                                       NIL)
                                      ((AND (CONSP |it|) (EQ (CAR |it|) 'ON))
                                       NIL)
                                      ((AND (CONSP |it|)
                                            (EQ (CAR |it|) 'WHILE))
                                       NIL)
                                      ((AND (CONSP |it|)
                                            (PROGN
                                             (SETQ |op| (CAR |it|))
                                             (SETQ |ISTMP#1| (CDR |it|))
                                             (AND (CONSP |ISTMP#1|)
                                                  (EQ (CDR |ISTMP#1|) NIL)
                                                  (PROGN
                                                   (SETQ |b| (CAR |ISTMP#1|))
                                                   #1#)))
                                            (|member| |op| '(UNTIL VALUE)))
                                       (LIST (LIST |op| (|mkAtree1| |b|))))
                                      ((AND (CONSP |it|) (EQ (CAR |it|) '|\||)
                                            (PROGN
                                             (SETQ |ISTMP#1| (CDR |it|))
                                             (AND (CONSP |ISTMP#1|)
                                                  (EQ (CDR |ISTMP#1|) NIL)
                                                  (PROGN
                                                   (SETQ |pred|
                                                           (CAR |ISTMP#1|))
                                                   #1#))))
                                       NIL)
                                      (#1#
                                       (|keyedSystemError| 'S2GE0016
                                        (LIST "transformREPEAT"
                                              "Unknown type of iterator")))))
                                    |bfVar#58|))))
                         (SETQ |bfVar#57| (CDR |bfVar#57|))))
                      NIL |itrl| NIL)))
      (APPEND |iterList| (CONS |bodyTree| NIL))))))

; upREPEAT t ==
;   -- REPEATS always return void() of Void
;   -- assures throw to interpret-code mode goes to outermost loop
;   $repeatLabel : local := MKQ GENSYM()
;   $breakCount  : local := 0
;   $repeatBodyLabel : local := MKQ GENSYM()
;   $iterateCount    : local := 0
;   $compilingLoop => upREPEAT1 t
;   upREPEAT0 t

(DEFUN |upREPEAT| (|t|)
  (PROG (|$iterateCount| |$repeatBodyLabel| |$breakCount| |$repeatLabel|)
    (DECLARE
     (SPECIAL |$iterateCount| |$repeatBodyLabel| |$breakCount| |$repeatLabel|))
    (RETURN
     (PROGN
      (SETQ |$repeatLabel| (MKQ (GENSYM)))
      (SETQ |$breakCount| 0)
      (SETQ |$repeatBodyLabel| (MKQ (GENSYM)))
      (SETQ |$iterateCount| 0)
      (COND (|$compilingLoop| (|upREPEAT1| |t|)) ('T (|upREPEAT0| |t|)))))))

; upREPEAT0 t ==
;   -- sets up catch point for interp-only mode
;   $compilingLoop: local := true
;   ms := CATCH('loopCompiler,upREPEAT1 t)
;   ms = 'tryInterpOnly => interpOnlyREPEAT t
;   ms

(DEFUN |upREPEAT0| (|t|)
  (PROG (|$compilingLoop| |ms|)
    (DECLARE (SPECIAL |$compilingLoop|))
    (RETURN
     (PROGN
      (SETQ |$compilingLoop| T)
      (SETQ |ms| (CATCH '|loopCompiler| (|upREPEAT1| |t|)))
      (COND ((EQ |ms| '|tryInterpOnly|) (|interpOnlyREPEAT| |t|)) ('T |ms|))))))

; upREPEAT1 t ==
;   -- repeat loop handler with compiled body
;   -- see if it has the expected form
;   t isnt [op,:itrl,body] => NIL
;   -- determine the mode of the repeat loop. At the moment, if there
;   -- there are no iterators and there are no "break" statements, then
;   -- the return type is Exit, otherwise Void.
;   repeatMode :=
;     null(itrl) and ($breakCount=0) => $Void
;     $Void
;
;   -- if interpreting, go do that
;   $interpOnly => interpREPEAT(op,itrl,body,repeatMode)
;
;   -- analyze iterators and loop body
;   upLoopIters itrl
;   bottomUpCompile body
;
;   -- now that the body is analyzed, we should know everything that
;   -- is in the UNTIL clause
;   for itr in itrl repeat
;     itr is ['UNTIL, pred] => bottomUpCompilePredicate(pred,'"until")
;
;   -- now go do it
;   evalREPEAT(op,rest t,repeatMode)
;   putModeSet(op,[repeatMode])

(DEFUN |upREPEAT1| (|t|)
  (PROG (|op| |ISTMP#1| |ISTMP#2| |body| |itrl| |repeatMode| |pred|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1='T)
                   (CONSP |ISTMP#2|)
                   (PROGN
                    (SETQ |body| (CAR |ISTMP#2|))
                    (SETQ |itrl| (CDR |ISTMP#2|))
                    #1#)
                   (PROGN (SETQ |itrl| (NREVERSE |itrl|)) #1#)))))
       NIL)
      (#1#
       (PROGN
        (SETQ |repeatMode|
                (COND ((AND (NULL |itrl|) (EQL |$breakCount| 0)) |$Void|)
                      (#1# |$Void|)))
        (COND (|$interpOnly| (|interpREPEAT| |op| |itrl| |body| |repeatMode|))
              (#1#
               (PROGN
                (|upLoopIters| |itrl|)
                (|bottomUpCompile| |body|)
                ((LAMBDA (|bfVar#60| |itr|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#60|)
                          (PROGN (SETQ |itr| (CAR |bfVar#60|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (COND
                       ((AND (CONSP |itr|) (EQ (CAR |itr|) 'UNTIL)
                             (PROGN
                              (SETQ |ISTMP#1| (CDR |itr|))
                              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                   (PROGN (SETQ |pred| (CAR |ISTMP#1|)) #1#))))
                        (IDENTITY
                         (|bottomUpCompilePredicate| |pred| "until"))))))
                    (SETQ |bfVar#60| (CDR |bfVar#60|))))
                 |itrl| NIL)
                (|evalREPEAT| |op| (CDR |t|) |repeatMode|)
                (|putModeSet| |op| (LIST |repeatMode|)))))))))))

; evalREPEAT(op,[:itrl,body],repeatMode) ==
;   -- generate code for loop
;   bodyMode := computedMode body
;   bodyCode := getArgValue(body,bodyMode)
;   if $iterateCount > 0 then
;     bodyCode := ['CATCH,$repeatBodyLabel,bodyCode]
;   code := ['REPEAT,:[evalLoopIter itr for itr in itrl], bodyCode]
;   if repeatMode = $Void then code := ['OR,code,'(voidValue)]
;   code := timedOptimization code
;   if $breakCount > 0 then code := ['CATCH,$repeatLabel,code]
;   val:=
;     $genValue =>
;       timedEVALFUN code
;       objNewWrap(voidValue(),repeatMode)
;     objNew(code,repeatMode)
;   putValue(op,val)

(DEFUN |evalREPEAT| (|op| |bfVar#63| |repeatMode|)
  (PROG (|LETTMP#1| |body| |itrl| |bodyMode| |bodyCode| |code| |val|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE |bfVar#63|))
      (SETQ |body| (CAR |LETTMP#1|))
      (SETQ |itrl| (NREVERSE (CDR |LETTMP#1|)))
      (SETQ |bodyMode| (|computedMode| |body|))
      (SETQ |bodyCode| (|getArgValue| |body| |bodyMode|))
      (COND
       ((< 0 |$iterateCount|)
        (SETQ |bodyCode| (LIST 'CATCH |$repeatBodyLabel| |bodyCode|))))
      (SETQ |code|
              (CONS 'REPEAT
                    (APPEND
                     ((LAMBDA (|bfVar#62| |bfVar#61| |itr|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#61|)
                               (PROGN (SETQ |itr| (CAR |bfVar#61|)) NIL))
                           (RETURN (NREVERSE |bfVar#62|)))
                          (#1='T
                           (SETQ |bfVar#62|
                                   (CONS (|evalLoopIter| |itr|) |bfVar#62|))))
                         (SETQ |bfVar#61| (CDR |bfVar#61|))))
                      NIL |itrl| NIL)
                     (CONS |bodyCode| NIL))))
      (COND
       ((EQUAL |repeatMode| |$Void|)
        (SETQ |code| (LIST 'OR |code| '(|voidValue|)))))
      (SETQ |code| (|timedOptimization| |code|))
      (COND
       ((< 0 |$breakCount|) (SETQ |code| (LIST 'CATCH |$repeatLabel| |code|))))
      (SETQ |val|
              (COND
               (|$genValue|
                (PROGN
                 (|timedEVALFUN| |code|)
                 (|objNewWrap| (|voidValue|) |repeatMode|)))
               (#1# (|objNew| |code| |repeatMode|))))
      (|putValue| |op| |val|)))))

; interpOnlyREPEAT t ==
;   -- interpret-code mode call to upREPEAT
;   $genValue: local := true
;   $interpOnly: local := true
;   upREPEAT1 t

(DEFUN |interpOnlyREPEAT| (|t|)
  (PROG (|$interpOnly| |$genValue|)
    (DECLARE (SPECIAL |$interpOnly| |$genValue|))
    (RETURN
     (PROGN (SETQ |$genValue| T) (SETQ |$interpOnly| T) (|upREPEAT1| |t|)))))

; interpREPEAT(op,itrl,body,repeatMode) ==
;   -- performs interpret-code repeat
;   $indexVars: local := NIL
;   $indexTypes: local := NIL
;   code :=
;       -- we must insert a CATCH for the iterate clause
;       ['REPEAT,:[interpIter itr for itr in itrl],
;         ['CATCH,$repeatBodyLabel,interpLoop(body,$indexVars,
;           $indexTypes,nil)]]
;   CATCH($repeatLabel,timedEVALFUN code)
;   val:= objNewWrap(voidValue(),repeatMode)
;   putValue(op,val)
;   putModeSet(op,[repeatMode])

(DEFUN |interpREPEAT| (|op| |itrl| |body| |repeatMode|)
  (PROG (|$indexTypes| |$indexVars| |val| |code|)
    (DECLARE (SPECIAL |$indexTypes| |$indexVars|))
    (RETURN
     (PROGN
      (SETQ |$indexVars| NIL)
      (SETQ |$indexTypes| NIL)
      (SETQ |code|
              (CONS 'REPEAT
                    (APPEND
                     ((LAMBDA (|bfVar#65| |bfVar#64| |itr|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#64|)
                               (PROGN (SETQ |itr| (CAR |bfVar#64|)) NIL))
                           (RETURN (NREVERSE |bfVar#65|)))
                          ('T
                           (SETQ |bfVar#65|
                                   (CONS (|interpIter| |itr|) |bfVar#65|))))
                         (SETQ |bfVar#64| (CDR |bfVar#64|))))
                      NIL |itrl| NIL)
                     (CONS
                      (LIST 'CATCH |$repeatBodyLabel|
                            (|interpLoop| |body| |$indexVars| |$indexTypes|
                             NIL))
                      NIL))))
      (CATCH |$repeatLabel| (|timedEVALFUN| |code|))
      (SETQ |val| (|objNewWrap| (|voidValue|) |repeatMode|))
      (|putValue| |op| |val|)
      (|putModeSet| |op| (LIST |repeatMode|))))))

; interpLoop(expr,indexList,indexTypes,requiredType) ==
;   -- generates code for interp-only repeat body
;   ['interpLoopIter,MKQ expr,MKQ indexList,['LIST,:indexList],
;     MKQ indexTypes, MKQ requiredType]

(DEFUN |interpLoop| (|expr| |indexList| |indexTypes| |requiredType|)
  (PROG ()
    (RETURN
     (LIST '|interpLoopIter| (MKQ |expr|) (MKQ |indexList|)
           (CONS 'LIST |indexList|) (MKQ |indexTypes|) (MKQ |requiredType|)))))

; interpLoopIter(exp,indexList,indexVals,indexTypes,requiredType) ==
;   -- call interpreter on exp with loop vars in indexList with given
;   --  values and types, requiredType is used from interpCOLLECT
;   --  to indicate the required type of the result
;   emptyAtree exp
;   for i in indexList for val in indexVals for type in indexTypes repeat
;     put(i,'value,objNewWrap(val,type),$env)
;   bottomUp exp
;   v:= getValue exp
;   val :=
;     null requiredType => v
;     coerceInteractive(v,requiredType)
;   null val =>
;     throwKeyedMsgCannotCoerceWithValue(objVal v,objMode v,requiredType)
;   objValUnwrap val

(DEFUN |interpLoopIter|
       (|exp| |indexList| |indexVals| |indexTypes| |requiredType|)
  (PROG (|v| |val|)
    (RETURN
     (PROGN
      (|emptyAtree| |exp|)
      ((LAMBDA (|bfVar#66| |i| |bfVar#67| |val| |bfVar#68| |type|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#66|) (PROGN (SETQ |i| (CAR |bfVar#66|)) NIL)
                (ATOM |bfVar#67|) (PROGN (SETQ |val| (CAR |bfVar#67|)) NIL)
                (ATOM |bfVar#68|) (PROGN (SETQ |type| (CAR |bfVar#68|)) NIL))
            (RETURN NIL))
           (#1='T (|put| |i| '|value| (|objNewWrap| |val| |type|) |$env|)))
          (SETQ |bfVar#66| (CDR |bfVar#66|))
          (SETQ |bfVar#67| (CDR |bfVar#67|))
          (SETQ |bfVar#68| (CDR |bfVar#68|))))
       |indexList| NIL |indexVals| NIL |indexTypes| NIL)
      (|bottomUp| |exp|)
      (SETQ |v| (|getValue| |exp|))
      (SETQ |val|
              (COND ((NULL |requiredType|) |v|)
                    (#1# (|coerceInteractive| |v| |requiredType|))))
      (COND
       ((NULL |val|)
        (|throwKeyedMsgCannotCoerceWithValue| (|objVal| |v|) (|objMode| |v|)
         |requiredType|))
       (#1# (|objValUnwrap| |val|)))))))

; upreturn t ==
;   -- make sure we are in a user function
;   t isnt [op,val] => NIL
;   (null $compilingMap) and (null $interpOnly) =>
;     throwKeyedMsg("S2IS0047",NIL)
;   if $mapTarget then putTarget(val,$mapTarget)
;   bottomUp val
;   if $mapTarget
;     then
;       val' := getArgValue(val, $mapTarget)
;       m := $mapTarget
;     else
;       val' := wrapped2Quote objVal getValue val
;       m := computedMode val
;   cn := mapCatchName $mapName
;   $mapReturnTypes := insert(m, $mapReturnTypes)
;   $mapThrowCount := $mapThrowCount + 1
;   -- if $genValue then we are interpreting the map
;   $genValue => THROW(cn,objNewWrap(removeQuote val',m))
;   putValue(op,objNew(['THROW,MKQ cn,val'],m))
;   putModeSet(op,[$Exit])

(DEFUN |upreturn| (|t|)
  (PROG (|op| |ISTMP#1| |val| |val'| |m| |cn|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |val| (CAR |ISTMP#1|)) #1='T)))))
       NIL)
      ((AND (NULL |$compilingMap|) (NULL |$interpOnly|))
       (|throwKeyedMsg| 'S2IS0047 NIL))
      (#1#
       (PROGN
        (COND (|$mapTarget| (|putTarget| |val| |$mapTarget|)))
        (|bottomUp| |val|)
        (COND
         (|$mapTarget| (SETQ |val'| (|getArgValue| |val| |$mapTarget|))
          (SETQ |m| |$mapTarget|))
         (#1# (SETQ |val'| (|wrapped2Quote| (|objVal| (|getValue| |val|))))
          (SETQ |m| (|computedMode| |val|))))
        (SETQ |cn| (|mapCatchName| |$mapName|))
        (SETQ |$mapReturnTypes| (|insert| |m| |$mapReturnTypes|))
        (SETQ |$mapThrowCount| (+ |$mapThrowCount| 1))
        (COND
         (|$genValue| (THROW |cn| (|objNewWrap| (|removeQuote| |val'|) |m|)))
         (#1#
          (PROGN
           (|putValue| |op| (|objNew| (LIST 'THROW (MKQ |cn|) |val'|) |m|))
           (|putModeSet| |op| (LIST |$Exit|)))))))))))

; upSEQ u ==
;   -- assumes that exits were translated into if-then-elses
;   -- handles flat SEQs and embedded returns
;   u isnt [op,:args] => NIL
;   if (target := getTarget(op)) then putTarget(last args, target)
;   for x in args repeat bottomUp x
;   null (m := computedMode last args) =>
;     keyedSystemError("S2GE0016",['"upSEQ",
;       '"last line of SEQ has no mode"])
;   evalSEQ(op,args,m)
;   putModeSet(op,[m])

(DEFUN |upSEQ| (|u|)
  (PROG (|op| |args| |target| |m|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |u|)
             (PROGN (SETQ |op| (CAR |u|)) (SETQ |args| (CDR |u|)) #1='T)))
       NIL)
      (#1#
       (PROGN
        (COND
         ((SETQ |target| (|getTarget| |op|))
          (|putTarget| (|last| |args|) |target|)))
        ((LAMBDA (|bfVar#69| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#69|) (PROGN (SETQ |x| (CAR |bfVar#69|)) NIL))
              (RETURN NIL))
             (#1# (|bottomUp| |x|)))
            (SETQ |bfVar#69| (CDR |bfVar#69|))))
         |args| NIL)
        (COND
         ((NULL (SETQ |m| (|computedMode| (|last| |args|))))
          (|keyedSystemError| 'S2GE0016
           (LIST "upSEQ" "last line of SEQ has no mode")))
         (#1#
          (PROGN
           (|evalSEQ| |op| |args| |m|)
           (|putModeSet| |op| (LIST |m|)))))))))))

; evalSEQ(op,args,m) ==
;   -- generate code for SEQ
;   [:argl,last] := args
;   val:=
;     $genValue => getValue last
;     bodyCode := nil
;     for x in args repeat
;       (m1 := computedMode x) =>
;         (av := getArgValue(x,m1)) ~= voidValue() =>
;           bodyCode := [av,:bodyCode]
;     code:=
;       bodyCode is [c] => c
;       ['PROGN,:reverse bodyCode]
;     objNew(code,m)
;   putValue(op,val)

(DEFUN |evalSEQ| (|op| |args| |m|)
  (PROG (|LETTMP#1| |last| |argl| |bodyCode| |m1| |av| |c| |code| |val|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE |args|))
      (SETQ |last| (CAR |LETTMP#1|))
      (SETQ |argl| (NREVERSE (CDR |LETTMP#1|)))
      (SETQ |val|
              (COND (|$genValue| (|getValue| |last|))
                    (#1='T
                     (PROGN
                      (SETQ |bodyCode| NIL)
                      ((LAMBDA (|bfVar#70| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#70|)
                                (PROGN (SETQ |x| (CAR |bfVar#70|)) NIL))
                            (RETURN NIL))
                           (#1#
                            (COND
                             ((SETQ |m1| (|computedMode| |x|))
                              (IDENTITY
                               (COND
                                ((NOT
                                  (EQUAL (SETQ |av| (|getArgValue| |x| |m1|))
                                         (|voidValue|)))
                                 (IDENTITY
                                  (SETQ |bodyCode|
                                          (CONS |av| |bodyCode|))))))))))
                          (SETQ |bfVar#70| (CDR |bfVar#70|))))
                       |args| NIL)
                      (SETQ |code|
                              (COND
                               ((AND (CONSP |bodyCode|)
                                     (EQ (CDR |bodyCode|) NIL)
                                     (PROGN (SETQ |c| (CAR |bodyCode|)) #1#))
                                |c|)
                               (#1# (CONS 'PROGN (REVERSE |bodyCode|)))))
                      (|objNew| |code| |m|)))))
      (|putValue| |op| |val|)))))

; upTuple t ==
;   --Computes the common mode set of the construct by resolving across
;   --the argument list, and evaluating
;   t isnt [op,:l] => nil
;   dol := getAtree(op,'dollar)
;   tar := getTarget(op) or dol
;   null l => upNullTuple(op,l,tar)
;   isTaggedUnion tar => upTaggedUnionConstruct(op,l,tar)
;   aggs := '(List)
;   if tar and PAIRP(tar) and not isPartialMode(tar) then
;     first(tar) in aggs =>
;       ud := CADR tar
;       for x in l repeat if not getTarget(x) then putTarget(x,ud)
;     first(tar) in '(Matrix SquareMatrix RectangularMatrix) =>
;       vec := ['List,underDomainOf tar]
;       for x in l repeat if not getTarget(x) then putTarget(x,vec)
;   argModeSetList:= [bottomUp x for x in l]
;   eltTypes := replaceSymbols([first x for x in argModeSetList],l)
;   if not isPartialMode(tar) and tar is ['Tuple,ud] then
;     mode := ['Tuple, resolveTypeListAny cons(ud,eltTypes)]
;   else mode := ['Tuple, resolveTypeListAny eltTypes]
;   if isPartialMode tar then tar:=resolveTM(mode,tar)
;   evalTuple(op,l,mode,tar)

(DEFUN |upTuple| (|t|)
  (PROG (|op| |l| |dol| |tar| |aggs| |ud| |vec| |argModeSetList| |eltTypes|
         |ISTMP#1| |mode|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN (SETQ |op| (CAR |t|)) (SETQ |l| (CDR |t|)) #1='T)))
       NIL)
      (#1#
       (PROGN
        (SETQ |dol| (|getAtree| |op| '|dollar|))
        (SETQ |tar| (OR (|getTarget| |op|) |dol|))
        (COND ((NULL |l|) (|upNullTuple| |op| |l| |tar|))
              ((|isTaggedUnion| |tar|)
               (|upTaggedUnionConstruct| |op| |l| |tar|))
              (#1#
               (PROGN
                (SETQ |aggs| '(|List|))
                (COND
                 ((AND |tar| (CONSP |tar|) (NULL (|isPartialMode| |tar|)))
                  (COND
                   ((|member| (CAR |tar|) |aggs|)
                    (PROGN
                     (SETQ |ud| (CADR |tar|))
                     ((LAMBDA (|bfVar#71| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#71|)
                               (PROGN (SETQ |x| (CAR |bfVar#71|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (COND
                            ((NULL (|getTarget| |x|))
                             (|putTarget| |x| |ud|)))))
                         (SETQ |bfVar#71| (CDR |bfVar#71|))))
                      |l| NIL)))
                   ((|member| (CAR |tar|)
                     '(|Matrix| |SquareMatrix| |RectangularMatrix|))
                    (PROGN
                     (SETQ |vec| (LIST '|List| (|underDomainOf| |tar|)))
                     ((LAMBDA (|bfVar#72| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#72|)
                               (PROGN (SETQ |x| (CAR |bfVar#72|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (COND
                            ((NULL (|getTarget| |x|))
                             (|putTarget| |x| |vec|)))))
                         (SETQ |bfVar#72| (CDR |bfVar#72|))))
                      |l| NIL))))))
                (SETQ |argModeSetList|
                        ((LAMBDA (|bfVar#74| |bfVar#73| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#73|)
                                  (PROGN (SETQ |x| (CAR |bfVar#73|)) NIL))
                              (RETURN (NREVERSE |bfVar#74|)))
                             (#1#
                              (SETQ |bfVar#74|
                                      (CONS (|bottomUp| |x|) |bfVar#74|))))
                            (SETQ |bfVar#73| (CDR |bfVar#73|))))
                         NIL |l| NIL))
                (SETQ |eltTypes|
                        (|replaceSymbols|
                         ((LAMBDA (|bfVar#76| |bfVar#75| |x|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#75|)
                                   (PROGN (SETQ |x| (CAR |bfVar#75|)) NIL))
                               (RETURN (NREVERSE |bfVar#76|)))
                              (#1#
                               (SETQ |bfVar#76| (CONS (CAR |x|) |bfVar#76|))))
                             (SETQ |bfVar#75| (CDR |bfVar#75|))))
                          NIL |argModeSetList| NIL)
                         |l|))
                (COND
                 ((AND (NULL (|isPartialMode| |tar|)) (CONSP |tar|)
                       (EQ (CAR |tar|) '|Tuple|)
                       (PROGN
                        (SETQ |ISTMP#1| (CDR |tar|))
                        (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                             (PROGN (SETQ |ud| (CAR |ISTMP#1|)) #1#))))
                  (SETQ |mode|
                          (LIST '|Tuple|
                                (|resolveTypeListAny|
                                 (CONS |ud| |eltTypes|)))))
                 (#1#
                  (SETQ |mode|
                          (LIST '|Tuple| (|resolveTypeListAny| |eltTypes|)))))
                (COND
                 ((|isPartialMode| |tar|)
                  (SETQ |tar| (|resolveTM| |mode| |tar|))))
                (|evalTuple| |op| |l| |mode| |tar|))))))))))

; evalTuple(op,l,m,tar) ==
;   [agg,:.,underMode]:= m
;   code := asTupleNewCode(#l,
;     [(getArgValue(x,underMode) or throwKeyedMsg("S2IC0007",[underMode])) for x in l])
;   val :=
;     $genValue => objNewWrap(timedEVALFUN code,m)
;     objNew(code,m)
;   if tar then val1 := coerceInteractive(val,tar) else val1 := val
;
;   val1 =>
;     putValue(op,val1)
;     putModeSet(op,[tar or m])
;   putValue(op,val)
;   putModeSet(op,[m])

(DEFUN |evalTuple| (|op| |l| |m| |tar|)
  (PROG (|agg| |LETTMP#1| |underMode| |code| |val| |val1|)
    (RETURN
     (PROGN
      (SETQ |agg| (CAR |m|))
      (SETQ |LETTMP#1| (REVERSE (CDR |m|)))
      (SETQ |underMode| (CAR |LETTMP#1|))
      (SETQ |code|
              (|asTupleNewCode| (LENGTH |l|)
               ((LAMBDA (|bfVar#78| |bfVar#77| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#77|)
                         (PROGN (SETQ |x| (CAR |bfVar#77|)) NIL))
                     (RETURN (NREVERSE |bfVar#78|)))
                    (#1='T
                     (SETQ |bfVar#78|
                             (CONS
                              (OR (|getArgValue| |x| |underMode|)
                                  (|throwKeyedMsg| 'S2IC0007
                                   (LIST |underMode|)))
                              |bfVar#78|))))
                   (SETQ |bfVar#77| (CDR |bfVar#77|))))
                NIL |l| NIL)))
      (SETQ |val|
              (COND (|$genValue| (|objNewWrap| (|timedEVALFUN| |code|) |m|))
                    (#1# (|objNew| |code| |m|))))
      (COND (|tar| (SETQ |val1| (|coerceInteractive| |val| |tar|)))
            (#1# (SETQ |val1| |val|)))
      (COND
       (|val1|
        (PROGN
         (|putValue| |op| |val1|)
         (|putModeSet| |op| (LIST (OR |tar| |m|)))))
       (#1# (PROGN (|putValue| |op| |val|) (|putModeSet| |op| (LIST |m|)))))))))

; upNullTuple(op,l,tar) ==
;   -- handler for the empty tuple
;   defMode :=
;     tar and tar is [a,b] and (a in '(Stream Vector List)) and
;       not isPartialMode(b) => ['Tuple,b]
;     '(Tuple (None))
;   val := objNewWrap(asTupleNew(0,NIL), defMode)
;   tar and not isPartialMode(tar) =>
;     null (val' := coerceInteractive(val,tar)) =>
;       throwKeyedMsg("S2IS0013",[tar])
;     putValue(op,val')
;     putModeSet(op,[tar])
;   putValue(op,val)
;   putModeSet(op,[defMode])

(DEFUN |upNullTuple| (|op| |l| |tar|)
  (PROG (|a| |ISTMP#1| |b| |defMode| |val| |val'|)
    (RETURN
     (PROGN
      (SETQ |defMode|
              (COND
               ((AND |tar| (CONSP |tar|)
                     (PROGN
                      (SETQ |a| (CAR |tar|))
                      (SETQ |ISTMP#1| (CDR |tar|))
                      (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                           (PROGN (SETQ |b| (CAR |ISTMP#1|)) #1='T)))
                     (|member| |a| '(|Stream| |Vector| |List|))
                     (NULL (|isPartialMode| |b|)))
                (LIST '|Tuple| |b|))
               (#1# '(|Tuple| (|None|)))))
      (SETQ |val| (|objNewWrap| (|asTupleNew| 0 NIL) |defMode|))
      (COND
       ((AND |tar| (NULL (|isPartialMode| |tar|)))
        (COND
         ((NULL (SETQ |val'| (|coerceInteractive| |val| |tar|)))
          (|throwKeyedMsg| 'S2IS0013 (LIST |tar|)))
         (#1#
          (PROGN (|putValue| |op| |val'|) (|putModeSet| |op| (LIST |tar|))))))
       (#1#
        (PROGN
         (|putValue| |op| |val|)
         (|putModeSet| |op| (LIST |defMode|)))))))))

; uptypeOf form ==
;   form isnt [op, arg] => NIL
;   if VECP arg then transferPropsToNode(getUnname arg,arg)
;   if m := isType(arg) then
;     m :=
;       categoryForm?(m) => '(Category)
;       isPartialMode m  => '(Mode)
;       '(Type)
;   else if not (m := getMode arg) then [m] := bottomUp arg
;   t := typeOfType m
;   putValue(op, objNew(m,t))
;   putModeSet(op,[t])

(DEFUN |uptypeOf| (|form|)
  (PROG (|op| |ISTMP#1| |arg| |m| |LETTMP#1| |t|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |form|)
             (PROGN
              (SETQ |op| (CAR |form|))
              (SETQ |ISTMP#1| (CDR |form|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |arg| (CAR |ISTMP#1|)) #1='T)))))
       NIL)
      (#1#
       (PROGN
        (COND ((VECP |arg|) (|transferPropsToNode| (|getUnname| |arg|) |arg|)))
        (COND
         ((SETQ |m| (|isType| |arg|))
          (SETQ |m|
                  (COND ((|categoryForm?| |m|) '(|Category|))
                        ((|isPartialMode| |m|) '(|Mode|)) (#1# '(|Type|)))))
         ((NULL (SETQ |m| (|getMode| |arg|)))
          (SETQ |LETTMP#1| (|bottomUp| |arg|)) (SETQ |m| (CAR |LETTMP#1|))
          |LETTMP#1|))
        (SETQ |t| (|typeOfType| |m|))
        (|putValue| |op| (|objNew| |m| |t|))
        (|putModeSet| |op| (LIST |t|))))))))

; typeOfType type ==
;   type in '((Mode) (Type)) => '(Category)
;   '(Type)

(DEFUN |typeOfType| (|type|)
  (PROG ()
    (RETURN
     (COND ((|member| |type| '((|Mode|) (|Type|))) '(|Category|))
           ('T '(|Type|))))))

; upwhere t ==
;   -- upwhere does the puts in where into a local environment
;   t isnt [op,tree,clause] => NIL
;   -- since the "clause" might be a local macro, we now call mkAtree
;   -- on the "tree" part (it is not yet a vat)
;   not $genValue =>
;     compFailure [:bright '"  where",
;       '"for compiled code is not yet implemented."]
;   $whereCacheList : local := nil
;   [env,:e] := upwhereClause(clause,$env,$e)
;   tree := upwhereMkAtree(tree,env,e)
;   if x := getAtree(op,'dollar) then
;     atom tree => throwKeyedMsg("S2IS0048",NIL)
;     putAtree(first tree, 'dollar, x)
;   upwhereMain(tree,env,e)
;   val := getValue tree
;   putValue(op,val)
;   result := putModeSet(op,getModeSet tree)
;   wcl := [op for op in $whereCacheList]
;   for op in wcl repeat clearDependencies(op)
;   result

(DEFUN |upwhere| (|t|)
  (PROG (|$whereCacheList| |wcl| |result| |val| |x| |e| |env| |LETTMP#1|
         |clause| |ISTMP#2| |tree| |ISTMP#1| |op|)
    (DECLARE (SPECIAL |$whereCacheList|))
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN
              (SETQ |op| (CAR |t|))
              (SETQ |ISTMP#1| (CDR |t|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |tree| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |clause| (CAR |ISTMP#2|)) #1='T)))))))
       NIL)
      ((NULL |$genValue|)
       (|compFailure|
        (APPEND (|bright| "  where")
                (CONS "for compiled code is not yet implemented." NIL))))
      (#1#
       (PROGN
        (SETQ |$whereCacheList| NIL)
        (SETQ |LETTMP#1| (|upwhereClause| |clause| |$env| |$e|))
        (SETQ |env| (CAR |LETTMP#1|))
        (SETQ |e| (CDR |LETTMP#1|))
        (SETQ |tree| (|upwhereMkAtree| |tree| |env| |e|))
        (COND
         ((SETQ |x| (|getAtree| |op| '|dollar|))
          (COND ((ATOM |tree|) (|throwKeyedMsg| 'S2IS0048 NIL))
                (#1# (|putAtree| (CAR |tree|) '|dollar| |x|)))))
        (|upwhereMain| |tree| |env| |e|)
        (SETQ |val| (|getValue| |tree|))
        (|putValue| |op| |val|)
        (SETQ |result| (|putModeSet| |op| (|getModeSet| |tree|)))
        (SETQ |wcl|
                ((LAMBDA (|bfVar#80| |bfVar#79| |op|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#79|)
                          (PROGN (SETQ |op| (CAR |bfVar#79|)) NIL))
                      (RETURN (NREVERSE |bfVar#80|)))
                     (#1# (SETQ |bfVar#80| (CONS |op| |bfVar#80|))))
                    (SETQ |bfVar#79| (CDR |bfVar#79|))))
                 NIL |$whereCacheList| NIL))
        ((LAMBDA (|bfVar#81| |op|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#81|) (PROGN (SETQ |op| (CAR |bfVar#81|)) NIL))
              (RETURN NIL))
             (#1# (|clearDependencies| |op|)))
            (SETQ |bfVar#81| (CDR |bfVar#81|))))
         |wcl| NIL)
        |result|))))))

; upwhereClause(tree,env,e) ==
;   -- uses the variable bindings from env and e and returns an environment
;   -- of its own bindings
;   $env: local := copyHack env
;   $e: local := copyHack e
;   bottomUp tree
;   [$env,:$e]

(DEFUN |upwhereClause| (|tree| |env| |e|)
  (PROG (|$e| |$env|)
    (DECLARE (SPECIAL |$e| |$env|))
    (RETURN
     (PROGN
      (SETQ |$env| (|copyHack| |env|))
      (SETQ |$e| (|copyHack| |e|))
      (|bottomUp| |tree|)
      (CONS |$env| |$e|)))))

; upwhereMkAtree(tree,$env,$e) == mkAtree tree

(DEFUN |upwhereMkAtree| (|tree| |$env| |$e|)
  (DECLARE (SPECIAL |$env| |$e|))
  (PROG () (RETURN (|mkAtree| |tree|))))

; upwhereMain(tree,$env,$e) ==
;   -- uses local copies of $env and $e while evaluating tree
;   bottomUp tree

(DEFUN |upwhereMain| (|tree| |$env| |$e|)
  (DECLARE (SPECIAL |$env| |$e|))
  (PROG () (RETURN (|bottomUp| |tree|))))

; copyHack(env) ==
;   -- makes a copy of an environment with the exception of pairs
;   -- (localModemap . something)
;   c:= CAAR env
;   d:= [fn p for p in c] where fn(p) ==
;     CONS(first p, [(EQCAR(q, 'localModemap) => q; copy q) for q in rest p])
;   [[d]]

(DEFUN |copyHack| (|env|)
  (PROG (|c| |d|)
    (RETURN
     (PROGN
      (SETQ |c| (CAAR |env|))
      (SETQ |d|
              ((LAMBDA (|bfVar#83| |bfVar#82| |p|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#82|)
                        (PROGN (SETQ |p| (CAR |bfVar#82|)) NIL))
                    (RETURN (NREVERSE |bfVar#83|)))
                   ('T
                    (SETQ |bfVar#83| (CONS (|copyHack,fn| |p|) |bfVar#83|))))
                  (SETQ |bfVar#82| (CDR |bfVar#82|))))
               NIL |c| NIL))
      (LIST (LIST |d|))))))
(DEFUN |copyHack,fn| (|p|)
  (PROG ()
    (RETURN
     (CONS (CAR |p|)
           ((LAMBDA (|bfVar#85| |bfVar#84| |q|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#84|) (PROGN (SETQ |q| (CAR |bfVar#84|)) NIL))
                 (RETURN (NREVERSE |bfVar#85|)))
                (#1='T
                 (SETQ |bfVar#85|
                         (CONS
                          (COND ((EQCAR |q| '|localModemap|) |q|)
                                (#1# (COPY |q|)))
                          |bfVar#85|))))
               (SETQ |bfVar#84| (CDR |bfVar#84|))))
            NIL (CDR |p|) NIL)))))

; for name in $specialOps repeat
;     (
;       functionName := INTERNL1('up, name) ;
;       MAKEPROP(name,'up,functionName) ;
;       functionName
;      )

(EVAL-WHEN (EVAL LOAD)
  (PROG (|functionName|)
    (RETURN
     ((LAMBDA (|bfVar#86| |name|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#86|) (PROGN (SETQ |name| (CAR |bfVar#86|)) NIL))
           (RETURN NIL))
          ('T
           (PROGN
            (SETQ |functionName| (INTERNL1 '|up| |name|))
            (MAKEPROP |name| '|up| |functionName|)
            |functionName|)))
         (SETQ |bfVar#86| (CDR |bfVar#86|))))
      |$specialOps| NIL))))

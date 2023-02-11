
; )package "BOOT"

(IN-PACKAGE "BOOT")

; sayFunctionSelection(op,args,target,dc,func) ==
;   $abbreviateTypes : local := true
;   startTimingProcess 'debug
;   fsig := formatSignatureArgs args
;   if not LISTP fsig then fsig := LIST fsig
;   if func then func := bright ['"by ",func]
;   sayMSG concat ['%l,:bright '"Function Selection for",op,:func,'%l,
;     '"      Arguments:",:bright fsig]
;   if target then sayMSG concat ['"      Target type:",
;     :bright prefix2String target]
;   if dc  then sayMSG concat ['"      From:     ",
;     :bright prefix2String dc]
;   stopTimingProcess 'debug

(DEFUN |sayFunctionSelection| (|op| |args| |target| |dc| |func|)
  (PROG (|$abbreviateTypes| |fsig|)
    (DECLARE (SPECIAL |$abbreviateTypes|))
    (RETURN
     (PROGN
      (SETQ |$abbreviateTypes| T)
      (|startTimingProcess| '|debug|)
      (SETQ |fsig| (|formatSignatureArgs| |args|))
      (COND ((NULL (LISTP |fsig|)) (SETQ |fsig| (LIST |fsig|))))
      (COND (|func| (SETQ |func| (|bright| (LIST "by " |func|)))))
      (|sayMSG|
       (|concat|
        (CONS '|%l|
              (APPEND (|bright| "Function Selection for")
                      (CONS |op|
                            (APPEND |func|
                                    (CONS '|%l|
                                          (CONS "      Arguments:"
                                                (|bright| |fsig|)))))))))
      (COND
       (|target|
        (|sayMSG|
         (|concat|
          (CONS "      Target type:" (|bright| (|prefix2String| |target|)))))))
      (COND
       (|dc|
        (|sayMSG|
         (|concat|
          (CONS "      From:     " (|bright| (|prefix2String| |dc|)))))))
      (|stopTimingProcess| '|debug|)))))

; sayFunctionSelectionResult(op,args,mmS) ==
;   $abbreviateTypes : local := true
;   startTimingProcess 'debug
;   if mmS then printMms mmS
;   else sayMSG concat ['"   -> no function",:bright op,
;     '"found for arguments",:bright formatSignatureArgs args]
;   stopTimingProcess 'debug

(DEFUN |sayFunctionSelectionResult| (|op| |args| |mmS|)
  (PROG (|$abbreviateTypes|)
    (DECLARE (SPECIAL |$abbreviateTypes|))
    (RETURN
     (PROGN
      (SETQ |$abbreviateTypes| T)
      (|startTimingProcess| '|debug|)
      (COND (|mmS| (|printMms| |mmS|))
            ('T
             (|sayMSG|
              (|concat|
               (CONS "   -> no function"
                     (APPEND (|bright| |op|)
                             (CONS "found for arguments"
                                   (|bright|
                                    (|formatSignatureArgs| |args|)))))))))
      (|stopTimingProcess| '|debug|)))))

; selectMms(op,args,$declaredMode) ==
;   -- selects applicable modemaps for node op and arguments args
;   -- if there is no local modemap, and it is not a package call, then
;   --   the cached function selectMms1 is called
;   startTimingProcess 'modemaps
;   n:= getUnname op
;   val := getValue op
;   opMode := objMode val
;
;   -- see if we have a functional parameter
;   ((isSharpVarWithNum(n) and opMode) or (val and opMode)) and
;       opMode is ['Mapping,:ta] =>
;         imp :=
;           val => wrapped2Quote objVal val
;           n
;         [[['local,:ta], imp , NIL]]
;
;   ((isSharpVarWithNum(n) and opMode) or (val and opMode)) and
;       opMode is ['Variable,f] =>
;          emptyAtree op
;          op.0 := f
;          selectMms(op,args,$declaredMode)
;
;   isSharpVarWithNum(n) and opMode is ['FunctionCalled,f] =>
;          op.0 := f
;          selectMms(op,args,$declaredMode)
;
;   types1 := getOpArgTypes(n,args)
;   numArgs := #args
;   member($EmptyMode,types1) => NIL
;
;   tar := getTarget op
;   dc  := getAtree(op,'dollar)
;
;   null dc and val and objMode(val) = $AnonymousFunction =>
;       tree := mkAtree objValUnwrap getValue op
;       putTarget(tree,['Mapping,tar,:types1])
;       bottomUp tree
;       val := getValue tree
;       [[['local,:rest objMode val], wrapped2Quote objVal val, NIL]]
;
;   if (n = 'map) and (first types1 = $AnonymousFunction)
;     then
;       tree := mkAtree objValUnwrap getValue first args
;       ut :=
;         tar => underDomainOf tar
;         NIL
;       ua := [underDomainOf x for x in rest types1]
;       member(NIL,ua) => NIL
;       putTarget(tree,['Mapping,ut,:ua])
;       bottomUp tree
;       val := getValue tree
;       types1 := [objMode val,:rest types1]
;       RPLACA(args,tree)
;
;   if numArgs = 1 and (n = "numer" or n = "denom") and
;     isEqualOrSubDomain(first types1,$Integer) and null dc then
;       dc := ['Fraction, $Integer]
;       putAtree(op, 'dollar, dc)
;
;
;   if $reportBottomUpFlag then sayFunctionSelection(n,types1,tar,dc,NIL)
;
;   identType := 'Variable
;   for x in types1 while not $declaredMode repeat
;       not EQCAR(x,identType) => $declaredMode:= x
;   types2 := [altTypeOf(x,y,$declaredMode) for x in types1 for y in args]
;
;   mmS:=
;     dc => selectDollarMms(dc,n,types1,types2)
;
;     if n = "/" and tar = $Integer then
;       tar := $RationalNumber
;       putTarget(op,tar)
;
;     -- now to speed up some standard selections
;     if not tar then
;       tar := defaultTarget(op,n,#types1,types1)
;       if tar and $reportBottomUpFlag then
;         sayMSG concat ['"      Default target type:",
;           :bright prefix2String tar]
;
;     selectLocalMms(op,n,types1,tar) or
;       (VECTORP op and selectMms1(n,tar,types1,types2,'T))
;   if $reportBottomUpFlag then sayFunctionSelectionResult(n,types1,mmS)
;   stopTimingProcess 'modemaps
;   mmS

(DEFUN |selectMms| (|op| |args| |$declaredMode|)
  (DECLARE (SPECIAL |$declaredMode|))
  (PROG (|n| |val| |opMode| |ta| |imp| |ISTMP#1| |f| |types1| |numArgs| |tar|
         |dc| |tree| |ut| |ua| |identType| |types2| |mmS|)
    (RETURN
     (PROGN
      (|startTimingProcess| '|modemaps|)
      (SETQ |n| (|getUnname| |op|))
      (SETQ |val| (|getValue| |op|))
      (SETQ |opMode| (|objMode| |val|))
      (COND
       ((AND (OR (AND (|isSharpVarWithNum| |n|) |opMode|) (AND |val| |opMode|))
             (CONSP |opMode|) (EQ (CAR |opMode|) '|Mapping|)
             (PROGN (SETQ |ta| (CDR |opMode|)) #1='T))
        (PROGN
         (SETQ |imp|
                 (COND (|val| (|wrapped2Quote| (|objVal| |val|))) (#1# |n|)))
         (LIST (LIST (CONS '|local| |ta|) |imp| NIL))))
       ((AND (OR (AND (|isSharpVarWithNum| |n|) |opMode|) (AND |val| |opMode|))
             (CONSP |opMode|) (EQ (CAR |opMode|) '|Variable|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |opMode|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |f| (CAR |ISTMP#1|)) #1#))))
        (PROGN
         (|emptyAtree| |op|)
         (SETF (ELT |op| 0) |f|)
         (|selectMms| |op| |args| |$declaredMode|)))
       ((AND (|isSharpVarWithNum| |n|) (CONSP |opMode|)
             (EQ (CAR |opMode|) '|FunctionCalled|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |opMode|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |f| (CAR |ISTMP#1|)) #1#))))
        (PROGN
         (SETF (ELT |op| 0) |f|)
         (|selectMms| |op| |args| |$declaredMode|)))
       (#1#
        (PROGN
         (SETQ |types1| (|getOpArgTypes| |n| |args|))
         (SETQ |numArgs| (LENGTH |args|))
         (COND ((|member| |$EmptyMode| |types1|) NIL)
               (#1#
                (PROGN
                 (SETQ |tar| (|getTarget| |op|))
                 (SETQ |dc| (|getAtree| |op| '|dollar|))
                 (COND
                  ((AND (NULL |dc|) |val|
                        (EQUAL (|objMode| |val|) |$AnonymousFunction|))
                   (PROGN
                    (SETQ |tree|
                            (|mkAtree| (|objValUnwrap| (|getValue| |op|))))
                    (|putTarget| |tree|
                     (CONS '|Mapping| (CONS |tar| |types1|)))
                    (|bottomUp| |tree|)
                    (SETQ |val| (|getValue| |tree|))
                    (LIST
                     (LIST (CONS '|local| (CDR (|objMode| |val|)))
                           (|wrapped2Quote| (|objVal| |val|)) NIL))))
                  (#1#
                   (PROGN
                    (COND
                     ((AND (EQ |n| '|map|)
                           (EQUAL (CAR |types1|) |$AnonymousFunction|))
                      (SETQ |tree|
                              (|mkAtree|
                               (|objValUnwrap| (|getValue| (CAR |args|)))))
                      (SETQ |ut|
                              (COND (|tar| (|underDomainOf| |tar|)) (#1# NIL)))
                      (SETQ |ua|
                              ((LAMBDA (|bfVar#2| |bfVar#1| |x|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#1|)
                                        (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
                                    (RETURN (NREVERSE |bfVar#2|)))
                                   (#1#
                                    (SETQ |bfVar#2|
                                            (CONS (|underDomainOf| |x|)
                                                  |bfVar#2|))))
                                  (SETQ |bfVar#1| (CDR |bfVar#1|))))
                               NIL (CDR |types1|) NIL))
                      (COND ((|member| NIL |ua|) NIL)
                            (#1#
                             (PROGN
                              (|putTarget| |tree|
                               (CONS '|Mapping| (CONS |ut| |ua|)))
                              (|bottomUp| |tree|)
                              (SETQ |val| (|getValue| |tree|))
                              (SETQ |types1|
                                      (CONS (|objMode| |val|) (CDR |types1|)))
                              (RPLACA |args| |tree|))))))
                    (COND
                     ((AND (EQL |numArgs| 1)
                           (OR (EQ |n| '|numer|) (EQ |n| '|denom|))
                           (|isEqualOrSubDomain| (CAR |types1|) |$Integer|)
                           (NULL |dc|))
                      (SETQ |dc| (LIST '|Fraction| |$Integer|))
                      (|putAtree| |op| '|dollar| |dc|)))
                    (COND
                     (|$reportBottomUpFlag|
                      (|sayFunctionSelection| |n| |types1| |tar| |dc| NIL)))
                    (SETQ |identType| '|Variable|)
                    ((LAMBDA (|bfVar#3| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#3|)
                              (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL)
                              |$declaredMode|)
                          (RETURN NIL))
                         (#1#
                          (COND
                           ((NULL (EQCAR |x| |identType|))
                            (IDENTITY (SETQ |$declaredMode| |x|))))))
                        (SETQ |bfVar#3| (CDR |bfVar#3|))))
                     |types1| NIL)
                    (SETQ |types2|
                            ((LAMBDA (|bfVar#6| |bfVar#4| |x| |bfVar#5| |y|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#4|)
                                      (PROGN (SETQ |x| (CAR |bfVar#4|)) NIL)
                                      (ATOM |bfVar#5|)
                                      (PROGN (SETQ |y| (CAR |bfVar#5|)) NIL))
                                  (RETURN (NREVERSE |bfVar#6|)))
                                 (#1#
                                  (SETQ |bfVar#6|
                                          (CONS
                                           (|altTypeOf| |x| |y|
                                            |$declaredMode|)
                                           |bfVar#6|))))
                                (SETQ |bfVar#4| (CDR |bfVar#4|))
                                (SETQ |bfVar#5| (CDR |bfVar#5|))))
                             NIL |types1| NIL |args| NIL))
                    (SETQ |mmS|
                            (COND
                             (|dc|
                              (|selectDollarMms| |dc| |n| |types1| |types2|))
                             (#1#
                              (PROGN
                               (COND
                                ((AND (EQ |n| '/) (EQUAL |tar| |$Integer|))
                                 (SETQ |tar| |$RationalNumber|)
                                 (|putTarget| |op| |tar|)))
                               (COND
                                ((NULL |tar|)
                                 (SETQ |tar|
                                         (|defaultTarget| |op| |n|
                                          (LENGTH |types1|) |types1|))
                                 (COND
                                  ((AND |tar| |$reportBottomUpFlag|)
                                   (|sayMSG|
                                    (|concat|
                                     (CONS "      Default target type:"
                                           (|bright|
                                            (|prefix2String| |tar|)))))))))
                               (OR (|selectLocalMms| |op| |n| |types1| |tar|)
                                   (AND (VECTORP |op|)
                                        (|selectMms1| |n| |tar| |types1|
                                         |types2| 'T)))))))
                    (COND
                     (|$reportBottomUpFlag|
                      (|sayFunctionSelectionResult| |n| |types1| |mmS|)))
                    (|stopTimingProcess| '|modemaps|)
                    |mmS|)))))))))))))

; selectMms2(op,tar,args1,args2,$Coerce) ==
;   -- decides whether to find functions from a domain or package
;   --   or by general modemap evaluation
;   if tar = $EmptyMode then tar := NIL
;   nargs := #args1
;   mmS := NIL
;   mmS :=
;     -- special case map for the time being
;     $Coerce and (op = 'map) and (2 = nargs) and
;       (first(args1) is ['Variable,fun]) =>
;         null (ud := underDomainOf CADR args1) => NIL
;         if tar then ut := underDomainOf(tar)
;         else ut := nil
;         null (mapMms := selectMms1(fun,ut,[ud],[NIL],true)) => NIL
;         mapMm := CDAAR mapMms
;         selectMms1(op,tar,[['Mapping,:mapMm],CADR args1],
;           [NIL,CADR args2],$Coerce)
;
;     $Coerce and (op = 'map) and (2 = nargs) and
;       (first(args1) is ['FunctionCalled,fun]) =>
;         null (ud := underDomainOf CADR args1) => NIL
;         if tar then ut := underDomainOf(tar)
;         else ut := nil
;         funNode := mkAtreeNode fun
;         transferPropsToNode(fun,funNode)
;         null (mapMms := selectLocalMms(funNode,fun,[ud],NIL)) => NIL
;         mapMm := CDAAR mapMms
;         selectMms1(op,tar,[['Mapping,:mapMm],CADR args1],
;           [NIL,CADR args2],$Coerce)
;
;     -- get the argument domains and the target
;     a := nil
;     for x in args1 repeat if x then a := cons(x,a)
;     for x in args2 repeat if x then a := cons(x,a)
;     if tar and not isPartialMode tar then a := cons(tar,a)
;
;     -- for typically homogeneous functions, throw in resolve too
;     if op in '(_= _+ _* _- ) then
;       r := resolveTypeList a
;       if r ~= nil then a := cons(r,a)
;
;     if tar and not isPartialMode tar then
;       if xx := underDomainOf(tar) then a := cons(xx,a)
;     for x in args1 repeat
;       PAIRP(x) and first(x) in '(List Vector Stream FiniteSet Array) =>
;         xx := underDomainOf(x) => a := cons(xx,a)
;
;     -- now extend this list with those from the arguments to
;     -- any Unions, Mapping or Records
;
;     a' := nil
;     a := nreverse REMDUP a
;     for x in a repeat
;       null x => 'iterate
;       x is ['Union,:l] =>
;         -- check if we have a tagged union
;         l and first l is [":",:.] =>
;           for [.,.,t] in l repeat
;             a' := cons(t,a')
;         a' := append(reverse l,a')
;       x is ['Mapping,:l] => a' := append(reverse l,a')
;       x is ['Record,:l] =>
;         a' := append(reverse [CADDR s for s in l],a')
;       x is ['FunctionCalled,name] =>
;         (xm := get(name,'mode,$e)) and not isPartialMode xm =>
;           a' := cons(xm,a')
;     a := append(a,REMDUP a')
;     a := [x for x in a | PAIRP(x)]
;
;     -- step 1. see if we have one without coercing
;     a' := a
;     while a repeat
;       x := first a
;       a := rest a
;       ATOM x => 'iterate
;       mmS := append(mmS, findFunctionInDomain(op,x,tar,args1,args2,NIL,NIL))
;
;     -- step 2. if we didn't get one, trying coercing (if we are
;     --         suppose to)
;
;     if null(mmS) and $Coerce then
;       a := a'
;       while a repeat
;         x := first a
;         a := rest a
;         ATOM x => 'iterate
;         mmS := append(mmS,
;           findFunctionInDomain(op,x,tar,args1,args2,$Coerce,NIL))
;
;     mmS or selectMmsGen(op,tar,args1,args2)
;   mmS and orderMms(op, mmS,args1,args2,tar)

(DEFUN |selectMms2| (|op| |tar| |args1| |args2| |$Coerce|)
  (DECLARE (SPECIAL |$Coerce|))
  (PROG (|nargs| |mmS| |ISTMP#1| |ISTMP#2| |fun| |ud| |ut| |mapMms| |mapMm|
         |funNode| |a| |r| |xx| |a'| |l| |t| |name| |xm| |x|)
    (RETURN
     (PROGN
      (COND ((EQUAL |tar| |$EmptyMode|) (SETQ |tar| NIL)))
      (SETQ |nargs| (LENGTH |args1|))
      (SETQ |mmS| NIL)
      (SETQ |mmS|
              (COND
               ((AND |$Coerce| (EQ |op| '|map|) (EQL 2 |nargs|)
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |args1|))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Variable|)
                           (PROGN
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN
                                  (SETQ |fun| (CAR |ISTMP#2|))
                                  #1='T))))))
                (COND ((NULL (SETQ |ud| (|underDomainOf| (CADR |args1|)))) NIL)
                      (#1#
                       (PROGN
                        (COND (|tar| (SETQ |ut| (|underDomainOf| |tar|)))
                              (#1# (SETQ |ut| NIL)))
                        (COND
                         ((NULL
                           (SETQ |mapMms|
                                   (|selectMms1| |fun| |ut| (LIST |ud|)
                                    (LIST NIL) T)))
                          NIL)
                         (#1#
                          (PROGN
                           (SETQ |mapMm| (CDAAR |mapMms|))
                           (|selectMms1| |op| |tar|
                            (LIST (CONS '|Mapping| |mapMm|) (CADR |args1|))
                            (LIST NIL (CADR |args2|)) |$Coerce|))))))))
               ((AND |$Coerce| (EQ |op| '|map|) (EQL 2 |nargs|)
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |args1|))
                      (AND (CONSP |ISTMP#1|)
                           (EQ (CAR |ISTMP#1|) '|FunctionCalled|)
                           (PROGN
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN (SETQ |fun| (CAR |ISTMP#2|)) #1#))))))
                (COND ((NULL (SETQ |ud| (|underDomainOf| (CADR |args1|)))) NIL)
                      (#1#
                       (PROGN
                        (COND (|tar| (SETQ |ut| (|underDomainOf| |tar|)))
                              (#1# (SETQ |ut| NIL)))
                        (SETQ |funNode| (|mkAtreeNode| |fun|))
                        (|transferPropsToNode| |fun| |funNode|)
                        (COND
                         ((NULL
                           (SETQ |mapMms|
                                   (|selectLocalMms| |funNode| |fun|
                                    (LIST |ud|) NIL)))
                          NIL)
                         (#1#
                          (PROGN
                           (SETQ |mapMm| (CDAAR |mapMms|))
                           (|selectMms1| |op| |tar|
                            (LIST (CONS '|Mapping| |mapMm|) (CADR |args1|))
                            (LIST NIL (CADR |args2|)) |$Coerce|))))))))
               (#1#
                (PROGN
                 (SETQ |a| NIL)
                 ((LAMBDA (|bfVar#7| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#7|)
                           (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                       (RETURN NIL))
                      (#1# (COND (|x| (SETQ |a| (CONS |x| |a|))))))
                     (SETQ |bfVar#7| (CDR |bfVar#7|))))
                  |args1| NIL)
                 ((LAMBDA (|bfVar#8| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#8|)
                           (PROGN (SETQ |x| (CAR |bfVar#8|)) NIL))
                       (RETURN NIL))
                      (#1# (COND (|x| (SETQ |a| (CONS |x| |a|))))))
                     (SETQ |bfVar#8| (CDR |bfVar#8|))))
                  |args2| NIL)
                 (COND
                  ((AND |tar| (NULL (|isPartialMode| |tar|)))
                   (SETQ |a| (CONS |tar| |a|))))
                 (COND
                  ((|member| |op| '(= + * -))
                   (SETQ |r| (|resolveTypeList| |a|))
                   (COND (|r| (SETQ |a| (CONS |r| |a|))))))
                 (COND
                  ((AND |tar| (NULL (|isPartialMode| |tar|)))
                   (COND
                    ((SETQ |xx| (|underDomainOf| |tar|))
                     (SETQ |a| (CONS |xx| |a|))))))
                 ((LAMBDA (|bfVar#9| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#9|)
                           (PROGN (SETQ |x| (CAR |bfVar#9|)) NIL))
                       (RETURN NIL))
                      (#1#
                       (COND
                        ((AND (CONSP |x|)
                              (|member| (CAR |x|)
                               '(|List| |Vector| |Stream| |FiniteSet|
                                 |Array|)))
                         (IDENTITY
                          (COND
                           ((SETQ |xx| (|underDomainOf| |x|))
                            (IDENTITY (SETQ |a| (CONS |xx| |a|))))))))))
                     (SETQ |bfVar#9| (CDR |bfVar#9|))))
                  |args1| NIL)
                 (SETQ |a'| NIL)
                 (SETQ |a| (NREVERSE (REMDUP |a|)))
                 ((LAMBDA (|bfVar#10| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#10|)
                           (PROGN (SETQ |x| (CAR |bfVar#10|)) NIL))
                       (RETURN NIL))
                      (#1#
                       (COND ((NULL |x|) '|iterate|)
                             ((AND (CONSP |x|) (EQ (CAR |x|) '|Union|)
                                   (PROGN (SETQ |l| (CDR |x|)) #1#))
                              (COND
                               ((AND |l|
                                     (PROGN
                                      (SETQ |ISTMP#1| (CAR |l|))
                                      (AND (CONSP |ISTMP#1|)
                                           (EQ (CAR |ISTMP#1|) '|:|))))
                                ((LAMBDA (|bfVar#12| |bfVar#11|)
                                   (LOOP
                                    (COND
                                     ((OR (ATOM |bfVar#12|)
                                          (PROGN
                                           (SETQ |bfVar#11| (CAR |bfVar#12|))
                                           NIL))
                                      (RETURN NIL))
                                     (#1#
                                      (AND (CONSP |bfVar#11|)
                                           (PROGN
                                            (SETQ |ISTMP#1| (CDR |bfVar#11|))
                                            (AND (CONSP |ISTMP#1|)
                                                 (PROGN
                                                  (SETQ |ISTMP#2|
                                                          (CDR |ISTMP#1|))
                                                  (AND (CONSP |ISTMP#2|)
                                                       (EQ (CDR |ISTMP#2|) NIL)
                                                       (PROGN
                                                        (SETQ |t|
                                                                (CAR
                                                                 |ISTMP#2|))
                                                        #1#)))))
                                           (SETQ |a'| (CONS |t| |a'|)))))
                                    (SETQ |bfVar#12| (CDR |bfVar#12|))))
                                 |l| NIL))
                               (#1# (SETQ |a'| (APPEND (REVERSE |l|) |a'|)))))
                             ((AND (CONSP |x|) (EQ (CAR |x|) '|Mapping|)
                                   (PROGN (SETQ |l| (CDR |x|)) #1#))
                              (SETQ |a'| (APPEND (REVERSE |l|) |a'|)))
                             ((AND (CONSP |x|) (EQ (CAR |x|) '|Record|)
                                   (PROGN (SETQ |l| (CDR |x|)) #1#))
                              (SETQ |a'|
                                      (APPEND
                                       (REVERSE
                                        ((LAMBDA (|bfVar#14| |bfVar#13| |s|)
                                           (LOOP
                                            (COND
                                             ((OR (ATOM |bfVar#13|)
                                                  (PROGN
                                                   (SETQ |s| (CAR |bfVar#13|))
                                                   NIL))
                                              (RETURN (NREVERSE |bfVar#14|)))
                                             (#1#
                                              (SETQ |bfVar#14|
                                                      (CONS (CADDR |s|)
                                                            |bfVar#14|))))
                                            (SETQ |bfVar#13|
                                                    (CDR |bfVar#13|))))
                                         NIL |l| NIL))
                                       |a'|)))
                             ((AND (CONSP |x|) (EQ (CAR |x|) '|FunctionCalled|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |x|))
                                    (AND (CONSP |ISTMP#1|)
                                         (EQ (CDR |ISTMP#1|) NIL)
                                         (PROGN
                                          (SETQ |name| (CAR |ISTMP#1|))
                                          #1#))))
                              (COND
                               ((AND (SETQ |xm| (|get| |name| '|mode| |$e|))
                                     (NULL (|isPartialMode| |xm|)))
                                (IDENTITY (SETQ |a'| (CONS |xm| |a'|)))))))))
                     (SETQ |bfVar#10| (CDR |bfVar#10|))))
                  |a| NIL)
                 (SETQ |a| (APPEND |a| (REMDUP |a'|)))
                 (SETQ |a|
                         ((LAMBDA (|bfVar#16| |bfVar#15| |x|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#15|)
                                   (PROGN (SETQ |x| (CAR |bfVar#15|)) NIL))
                               (RETURN (NREVERSE |bfVar#16|)))
                              (#1#
                               (AND (CONSP |x|)
                                    (SETQ |bfVar#16| (CONS |x| |bfVar#16|)))))
                             (SETQ |bfVar#15| (CDR |bfVar#15|))))
                          NIL |a| NIL))
                 (SETQ |a'| |a|)
                 ((LAMBDA ()
                    (LOOP
                     (COND ((NOT |a|) (RETURN NIL))
                           (#1#
                            (PROGN
                             (SETQ |x| (CAR |a|))
                             (SETQ |a| (CDR |a|))
                             (COND ((ATOM |x|) '|iterate|)
                                   (#1#
                                    (SETQ |mmS|
                                            (APPEND |mmS|
                                                    (|findFunctionInDomain|
                                                     |op| |x| |tar| |args1|
                                                     |args2| NIL NIL)))))))))))
                 (COND
                  ((AND (NULL |mmS|) |$Coerce|) (SETQ |a| |a'|)
                   ((LAMBDA ()
                      (LOOP
                       (COND ((NOT |a|) (RETURN NIL))
                             (#1#
                              (PROGN
                               (SETQ |x| (CAR |a|))
                               (SETQ |a| (CDR |a|))
                               (COND ((ATOM |x|) '|iterate|)
                                     (#1#
                                      (SETQ |mmS|
                                              (APPEND |mmS|
                                                      (|findFunctionInDomain|
                                                       |op| |x| |tar| |args1|
                                                       |args2| |$Coerce|
                                                       NIL)))))))))))))
                 (OR |mmS| (|selectMmsGen| |op| |tar| |args1| |args2|))))))
      (AND |mmS| (|orderMms| |op| |mmS| |args1| |args2| |tar|))))))

; isAVariableType t ==
;     t is ['Variable,.] or t = $Symbol or t is ['OrderedVariableList,.]

(DEFUN |isAVariableType| (|t|)
  (PROG (|ISTMP#1|)
    (RETURN
     (OR
      (AND (CONSP |t|) (EQ (CAR |t|) '|Variable|)
           (PROGN
            (SETQ |ISTMP#1| (CDR |t|))
            (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
      (EQUAL |t| |$Symbol|)
      (AND (CONSP |t|) (EQ (CAR |t|) '|OrderedVariableList|)
           (PROGN
            (SETQ |ISTMP#1| (CDR |t|))
            (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))))))

; defaultTarget(opNode,op,nargs,args) ==
;   -- this is for efficiency. Chooses standard targets for operations
;   -- when no target exists.
;
;   target := nil
;
;   nargs = 0 =>
;     op = 'nil =>
;       putTarget(opNode, target := '(List (None)))
;       target
;     op = 'true  or op = 'false =>
;       putTarget(opNode, target := $Boolean)
;       target
;     op = 'pi =>
;       putTarget(opNode, target := ['Pi])
;       target
;     op = 'infinity =>
;       putTarget(opNode, target := ['OnePointCompletion, $Integer])
;       target
;     member(op, '(plusInfinity minusInfinity)) =>
;       putTarget(opNode, target := ['OrderedCompletion, $Integer])
;       target
;     target
;
;   a1 := first args
;   ATOM a1 => target
;   a1f := QCAR a1
;
;   nargs = 1 =>
;     op = 'kernel =>
;       putTarget(opNode, target := ['Kernel, ['Expression, $Integer]])
;       target
;     op = 'list =>
;       putTarget(opNode, target := ['List, a1])
;       target
;     target
;
;   a2 := CADR args
;
;   nargs >= 2 and op = "draw" and a1 is ['FunctionCalled,sym] and a2 is ['Segment,.] =>
;
;     -- this clears up some confusion over 2D and 3D graphics
;
;     symNode := mkAtreeNode sym
;     transferPropsToNode(sym,symNode)
;
;     nargs >= 3 and CADDR args is ['Segment,.] =>
;       selectLocalMms(symNode,sym,[$DoubleFloat, $DoubleFloat],NIL)
;       putTarget(opNode, target := '(ThreeDimensionalViewport))
;       target
;
;     (mms := selectLocalMms(symNode,sym,[$DoubleFloat],NIL)) =>
;       [.,targ,:.] := CAAR mms
;       targ = $DoubleFloat =>
;           putTarget(opNode, target := '(TwoDimensionalViewport))
;           target
;       targ = ['Point, $DoubleFloat] =>
;           putTarget(opNode, target := '(ThreeDimensionalViewport))
;           target
;       target
;
;     target
;
;   nargs >= 2 and op = "makeObject" and a1 is ['FunctionCalled,sym] and a2 is ['Segment,.] =>
;     -- we won't actually bother to put a target on makeObject
;     -- this is just to figure out what the first arg is
;     symNode := mkAtreeNode sym
;     transferPropsToNode(sym,symNode)
;
;     nargs >= 3 and CADDR args is ['Segment,.] =>
;       selectLocalMms(symNode,sym,[$DoubleFloat, $DoubleFloat],NIL)
;       target
;
;     selectLocalMms(symNode,sym,[$DoubleFloat],NIL)
;     target
;
;   nargs = 2 =>
;     op = "elt" =>
;         a1 = '(BasicOperator) and a2 is ['List, ['OrderedVariableList, .]] =>
;            ['Expression, $Integer]
;         target
;
;     op = "eval" =>
;         a1 is ['Expression,b1] and a2 is ['Equation, ['Polynomial,b2]] =>
;             target :=
;               canCoerce(b2, a1) => a1
;               t := resolveTT(b1, b2)
;               (not t) or (t = $Any) => nil
;               resolveTT(a1, t)
;             if target then putTarget(opNode, target)
;             target
;         a1 is ['Equation, .] and a2 is ['Equation, .] =>
;             target := resolveTT(a1, a2)
;             if target and not (target = $Any) then putTarget(opNode,target)
;             else target := nil
;             target
;         a1 is ['Equation, .] and a2 is ['List, a2e] and a2e is ['Equation, .] =>
;             target := resolveTT(a1, a2e)
;             if target and not (target = $Any) then putTarget(opNode,target)
;             else target := nil
;             target
;         a2 is ['Equation, a2e] or a2 is ['List, ['Equation, a2e]] =>
;             target := resolveTT(a1, a2e)
;             if target and not (target = $Any) then putTarget(opNode,target)
;             else target := nil
;             target
;
;     op = "**" or op = "^" =>
;       a2 = $Integer =>
;         if (target := resolveTCat(a1,'(Field))) then
;           putTarget(opNode,target)
;         target
;       a1 = '(AlgebraicNumber) and (a2 = $Float or a2 = $DoubleFloat) =>
;           target := ['Expression, a2]
;           putTarget(opNode,target)
;           target
;       a1 = '(AlgebraicNumber) and a2 is ['Complex, a3] and (a3 = $Float or a3 = $DoubleFloat) =>
;           target := ['Expression, a3]
;           putTarget(opNode,target)
;           target
;       ((a2 = $RationalNumber) and
;         (typeIsASmallInteger(a1) or isEqualOrSubDomain(a1,$Integer))) =>
;             putTarget(opNode, target := '(AlgebraicNumber))
;             target
;       ((a2 = $RationalNumber) and (isAVariableType(a1)
;           or a1 is ['Polynomial, .])) =>
;             putTarget(opNode, target := defaultTargetFE a1)
;             target
;       isAVariableType(a1) and (a2 = $PositiveInteger or a2 = $NonNegativeInteger) =>
;           putTarget(opNode, target := '(Polynomial (Integer)))
;           target
;       isAVariableType(a2) =>
;         putTarget(opNode, target := defaultTargetFE a1)
;         target
;       a2 is ['Polynomial, D] =>
;         (a1 = a2) or isAVariableType(a1)
;          or (a1 = D)
;           or ((a1 is [=$QuotientField, D1]) and (D1 = a1)) =>
;             putTarget(opNode, target := defaultTargetFE a2)
;             target
;         target
;       target
;
;     op = '_/ =>
;       isEqualOrSubDomain(a1, $Integer) and isEqualOrSubDomain(a2, $Integer) =>
;         putTarget(opNode, target := $RationalNumber)
;         target
;       a1 = a2 =>
;         if (target := resolveTCat(first args, '(Field))) then
;           putTarget(opNode,target)
;         target
;       a1 is ['Variable,.] and a2 is ['Variable,.] =>
;         putTarget(opNode,target := mkRationalFunction  '(Integer))
;         target
;       isEqualOrSubDomain(a1,$Integer) and a2 is ['Variable,.] =>
;         putTarget(opNode,target := mkRationalFunction '(Integer))
;         target
;       a1 is ['Variable,.] and
;         a2 is ['Polynomial,D] =>
;           putTarget(opNode,target := mkRationalFunction D)
;           target
;         target
;       a2 is ['Variable,.] and
;         a1 is ['Polynomial,D] =>
;           putTarget(opNode,target := mkRationalFunction D)
;           target
;         target
;       a2 is ['Polynomial,D] and (a1 = D) =>
;         putTarget(opNode,target := mkRationalFunction D)
;         target
;       target
;
;   a3 := CADDR args
;   nargs = 3 =>
;     op = "eval" =>
;         a3 is ['List, a3e] =>
;             target := resolveTT(a1, a3e)
;             if not (target = $Any) then putTarget(opNode,target)
;             else target := nil
;             target
;
;         target := resolveTT(a1, a3)
;         if not (target = $Any) then putTarget(opNode,target)
;         else target := nil
;         target
;   target

(DEFUN |defaultTarget| (|opNode| |op| |nargs| |args|)
  (PROG (|target| |a1| |a1f| |a2| |ISTMP#1| |sym| |symNode| |ISTMP#2| |mms|
         |LETTMP#1| |targ| |ISTMP#3| |b1| |b2| |t| |a2e| |a3| D D1 |a3e|)
    (RETURN
     (PROGN
      (SETQ |target| NIL)
      (COND
       ((EQL |nargs| 0)
        (COND
         ((EQ |op| '|nil|)
          (PROGN
           (|putTarget| |opNode| (SETQ |target| '(|List| (|None|))))
           |target|))
         ((OR (EQ |op| '|true|) (EQ |op| '|false|))
          (PROGN (|putTarget| |opNode| (SETQ |target| |$Boolean|)) |target|))
         ((EQ |op| '|pi|)
          (PROGN (|putTarget| |opNode| (SETQ |target| (LIST '|Pi|))) |target|))
         ((EQ |op| '|infinity|)
          (PROGN
           (|putTarget| |opNode|
            (SETQ |target| (LIST '|OnePointCompletion| |$Integer|)))
           |target|))
         ((|member| |op| '(|plusInfinity| |minusInfinity|))
          (PROGN
           (|putTarget| |opNode|
            (SETQ |target| (LIST '|OrderedCompletion| |$Integer|)))
           |target|))
         (#1='T |target|)))
       (#1#
        (PROGN
         (SETQ |a1| (CAR |args|))
         (COND ((ATOM |a1|) |target|)
               (#1#
                (PROGN
                 (SETQ |a1f| (QCAR |a1|))
                 (COND
                  ((EQL |nargs| 1)
                   (COND
                    ((EQ |op| '|kernel|)
                     (PROGN
                      (|putTarget| |opNode|
                       (SETQ |target|
                               (LIST '|Kernel|
                                     (LIST '|Expression| |$Integer|))))
                      |target|))
                    ((EQ |op| '|list|)
                     (PROGN
                      (|putTarget| |opNode|
                       (SETQ |target| (LIST '|List| |a1|)))
                      |target|))
                    (#1# |target|)))
                  (#1#
                   (PROGN
                    (SETQ |a2| (CADR |args|))
                    (COND
                     ((AND (NOT (< |nargs| 2)) (EQ |op| '|draw|) (CONSP |a1|)
                           (EQ (CAR |a1|) '|FunctionCalled|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |a1|))
                            (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                 (PROGN (SETQ |sym| (CAR |ISTMP#1|)) #1#)))
                           (CONSP |a2|) (EQ (CAR |a2|) '|Segment|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |a2|))
                            (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
                      (PROGN
                       (SETQ |symNode| (|mkAtreeNode| |sym|))
                       (|transferPropsToNode| |sym| |symNode|)
                       (COND
                        ((AND (NOT (< |nargs| 3))
                              (PROGN
                               (SETQ |ISTMP#1| (CADDR |args|))
                               (AND (CONSP |ISTMP#1|)
                                    (EQ (CAR |ISTMP#1|) '|Segment|)
                                    (PROGN
                                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                     (AND (CONSP |ISTMP#2|)
                                          (EQ (CDR |ISTMP#2|) NIL))))))
                         (PROGN
                          (|selectLocalMms| |symNode| |sym|
                           (LIST |$DoubleFloat| |$DoubleFloat|) NIL)
                          (|putTarget| |opNode|
                           (SETQ |target| '(|ThreeDimensionalViewport|)))
                          |target|))
                        ((SETQ |mms|
                                 (|selectLocalMms| |symNode| |sym|
                                  (LIST |$DoubleFloat|) NIL))
                         (PROGN
                          (SETQ |LETTMP#1| (CAAR |mms|))
                          (SETQ |targ| (CADR |LETTMP#1|))
                          (COND
                           ((EQUAL |targ| |$DoubleFloat|)
                            (PROGN
                             (|putTarget| |opNode|
                              (SETQ |target| '(|TwoDimensionalViewport|)))
                             |target|))
                           ((EQUAL |targ| (LIST '|Point| |$DoubleFloat|))
                            (PROGN
                             (|putTarget| |opNode|
                              (SETQ |target| '(|ThreeDimensionalViewport|)))
                             |target|))
                           (#1# |target|))))
                        (#1# |target|))))
                     ((AND (NOT (< |nargs| 2)) (EQ |op| '|makeObject|)
                           (CONSP |a1|) (EQ (CAR |a1|) '|FunctionCalled|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |a1|))
                            (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                 (PROGN (SETQ |sym| (CAR |ISTMP#1|)) #1#)))
                           (CONSP |a2|) (EQ (CAR |a2|) '|Segment|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |a2|))
                            (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
                      (PROGN
                       (SETQ |symNode| (|mkAtreeNode| |sym|))
                       (|transferPropsToNode| |sym| |symNode|)
                       (COND
                        ((AND (NOT (< |nargs| 3))
                              (PROGN
                               (SETQ |ISTMP#1| (CADDR |args|))
                               (AND (CONSP |ISTMP#1|)
                                    (EQ (CAR |ISTMP#1|) '|Segment|)
                                    (PROGN
                                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                     (AND (CONSP |ISTMP#2|)
                                          (EQ (CDR |ISTMP#2|) NIL))))))
                         (PROGN
                          (|selectLocalMms| |symNode| |sym|
                           (LIST |$DoubleFloat| |$DoubleFloat|) NIL)
                          |target|))
                        (#1#
                         (PROGN
                          (|selectLocalMms| |symNode| |sym|
                           (LIST |$DoubleFloat|) NIL)
                          |target|)))))
                     ((EQL |nargs| 2)
                      (COND
                       ((EQ |op| '|elt|)
                        (COND
                         ((AND (EQUAL |a1| '(|BasicOperator|)) (CONSP |a2|)
                               (EQ (CAR |a2|) '|List|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a2|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                      (AND (CONSP |ISTMP#2|)
                                           (EQ (CAR |ISTMP#2|)
                                               '|OrderedVariableList|)
                                           (PROGN
                                            (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                            (AND (CONSP |ISTMP#3|)
                                                 (EQ (CDR |ISTMP#3|)
                                                     NIL))))))))
                          (LIST '|Expression| |$Integer|))
                         (#1# |target|)))
                       ((EQ |op| '|eval|)
                        (COND
                         ((AND (CONSP |a1|) (EQ (CAR |a1|) '|Expression|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a1|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN (SETQ |b1| (CAR |ISTMP#1|)) #1#)))
                               (CONSP |a2|) (EQ (CAR |a2|) '|Equation|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a2|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                      (AND (CONSP |ISTMP#2|)
                                           (EQ (CAR |ISTMP#2|) '|Polynomial|)
                                           (PROGN
                                            (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                            (AND (CONSP |ISTMP#3|)
                                                 (EQ (CDR |ISTMP#3|) NIL)
                                                 (PROGN
                                                  (SETQ |b2| (CAR |ISTMP#3|))
                                                  #1#))))))))
                          (PROGN
                           (SETQ |target|
                                   (COND ((|canCoerce| |b2| |a1|) |a1|)
                                         (#1#
                                          (PROGN
                                           (SETQ |t| (|resolveTT| |b1| |b2|))
                                           (COND
                                            ((OR (NULL |t|) (EQUAL |t| |$Any|))
                                             NIL)
                                            (#1# (|resolveTT| |a1| |t|)))))))
                           (COND (|target| (|putTarget| |opNode| |target|)))
                           |target|))
                         ((AND (CONSP |a1|) (EQ (CAR |a1|) '|Equation|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a1|))
                                (AND (CONSP |ISTMP#1|)
                                     (EQ (CDR |ISTMP#1|) NIL)))
                               (CONSP |a2|) (EQ (CAR |a2|) '|Equation|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a2|))
                                (AND (CONSP |ISTMP#1|)
                                     (EQ (CDR |ISTMP#1|) NIL))))
                          (PROGN
                           (SETQ |target| (|resolveTT| |a1| |a2|))
                           (COND
                            ((AND |target| (NULL (EQUAL |target| |$Any|)))
                             (|putTarget| |opNode| |target|))
                            (#1# (SETQ |target| NIL)))
                           |target|))
                         ((AND (CONSP |a1|) (EQ (CAR |a1|) '|Equation|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a1|))
                                (AND (CONSP |ISTMP#1|)
                                     (EQ (CDR |ISTMP#1|) NIL)))
                               (CONSP |a2|) (EQ (CAR |a2|) '|List|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a2|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN (SETQ |a2e| (CAR |ISTMP#1|)) #1#)))
                               (CONSP |a2e|) (EQ (CAR |a2e|) '|Equation|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a2e|))
                                (AND (CONSP |ISTMP#1|)
                                     (EQ (CDR |ISTMP#1|) NIL))))
                          (PROGN
                           (SETQ |target| (|resolveTT| |a1| |a2e|))
                           (COND
                            ((AND |target| (NULL (EQUAL |target| |$Any|)))
                             (|putTarget| |opNode| |target|))
                            (#1# (SETQ |target| NIL)))
                           |target|))
                         ((OR
                           (AND (CONSP |a2|) (EQ (CAR |a2|) '|Equation|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |a2|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)
                                      (PROGN
                                       (SETQ |a2e| (CAR |ISTMP#1|))
                                       #1#))))
                           (AND (CONSP |a2|) (EQ (CAR |a2|) '|List|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |a2|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)
                                      (PROGN
                                       (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                       (AND (CONSP |ISTMP#2|)
                                            (EQ (CAR |ISTMP#2|) '|Equation|)
                                            (PROGN
                                             (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                             (AND (CONSP |ISTMP#3|)
                                                  (EQ (CDR |ISTMP#3|) NIL)
                                                  (PROGN
                                                   (SETQ |a2e| (CAR |ISTMP#3|))
                                                   #1#)))))))))
                          (PROGN
                           (SETQ |target| (|resolveTT| |a1| |a2e|))
                           (COND
                            ((AND |target| (NULL (EQUAL |target| |$Any|)))
                             (|putTarget| |opNode| |target|))
                            (#1# (SETQ |target| NIL)))
                           |target|))))
                       ((OR (EQ |op| '**) (EQ |op| '^))
                        (COND
                         ((EQUAL |a2| |$Integer|)
                          (PROGN
                           (COND
                            ((SETQ |target| (|resolveTCat| |a1| '(|Field|)))
                             (|putTarget| |opNode| |target|)))
                           |target|))
                         ((AND (EQUAL |a1| '(|AlgebraicNumber|))
                               (OR (EQUAL |a2| |$Float|)
                                   (EQUAL |a2| |$DoubleFloat|)))
                          (PROGN
                           (SETQ |target| (LIST '|Expression| |a2|))
                           (|putTarget| |opNode| |target|)
                           |target|))
                         ((AND (EQUAL |a1| '(|AlgebraicNumber|)) (CONSP |a2|)
                               (EQ (CAR |a2|) '|Complex|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a2|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN (SETQ |a3| (CAR |ISTMP#1|)) #1#)))
                               (OR (EQUAL |a3| |$Float|)
                                   (EQUAL |a3| |$DoubleFloat|)))
                          (PROGN
                           (SETQ |target| (LIST '|Expression| |a3|))
                           (|putTarget| |opNode| |target|)
                           |target|))
                         ((AND (EQUAL |a2| |$RationalNumber|)
                               (OR (|typeIsASmallInteger| |a1|)
                                   (|isEqualOrSubDomain| |a1| |$Integer|)))
                          (PROGN
                           (|putTarget| |opNode|
                            (SETQ |target| '(|AlgebraicNumber|)))
                           |target|))
                         ((AND (EQUAL |a2| |$RationalNumber|)
                               (OR (|isAVariableType| |a1|)
                                   (AND (CONSP |a1|)
                                        (EQ (CAR |a1|) '|Polynomial|)
                                        (PROGN
                                         (SETQ |ISTMP#1| (CDR |a1|))
                                         (AND (CONSP |ISTMP#1|)
                                              (EQ (CDR |ISTMP#1|) NIL))))))
                          (PROGN
                           (|putTarget| |opNode|
                            (SETQ |target| (|defaultTargetFE| |a1|)))
                           |target|))
                         ((AND (|isAVariableType| |a1|)
                               (OR (EQUAL |a2| |$PositiveInteger|)
                                   (EQUAL |a2| |$NonNegativeInteger|)))
                          (PROGN
                           (|putTarget| |opNode|
                            (SETQ |target| '(|Polynomial| (|Integer|))))
                           |target|))
                         ((|isAVariableType| |a2|)
                          (PROGN
                           (|putTarget| |opNode|
                            (SETQ |target| (|defaultTargetFE| |a1|)))
                           |target|))
                         ((AND (CONSP |a2|) (EQ (CAR |a2|) '|Polynomial|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a2|))
                                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                     (PROGN (SETQ D (CAR |ISTMP#1|)) #1#))))
                          (COND
                           ((OR (EQUAL |a1| |a2|) (|isAVariableType| |a1|)
                                (EQUAL |a1| D)
                                (AND (CONSP |a1|)
                                     (EQUAL (CAR |a1|) |$QuotientField|)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |a1|))
                                      (AND (CONSP |ISTMP#1|)
                                           (EQ (CDR |ISTMP#1|) NIL)
                                           (PROGN
                                            (SETQ D1 (CAR |ISTMP#1|))
                                            #1#)))
                                     (EQUAL D1 |a1|)))
                            (PROGN
                             (|putTarget| |opNode|
                              (SETQ |target| (|defaultTargetFE| |a2|)))
                             |target|))
                           (#1# |target|)))
                         (#1# |target|)))
                       ((EQ |op| '/)
                        (COND
                         ((AND (|isEqualOrSubDomain| |a1| |$Integer|)
                               (|isEqualOrSubDomain| |a2| |$Integer|))
                          (PROGN
                           (|putTarget| |opNode|
                            (SETQ |target| |$RationalNumber|))
                           |target|))
                         ((EQUAL |a1| |a2|)
                          (PROGN
                           (COND
                            ((SETQ |target|
                                     (|resolveTCat| (CAR |args|) '(|Field|)))
                             (|putTarget| |opNode| |target|)))
                           |target|))
                         ((AND (CONSP |a1|) (EQ (CAR |a1|) '|Variable|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a1|))
                                (AND (CONSP |ISTMP#1|)
                                     (EQ (CDR |ISTMP#1|) NIL)))
                               (CONSP |a2|) (EQ (CAR |a2|) '|Variable|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a2|))
                                (AND (CONSP |ISTMP#1|)
                                     (EQ (CDR |ISTMP#1|) NIL))))
                          (PROGN
                           (|putTarget| |opNode|
                            (SETQ |target|
                                    (|mkRationalFunction| '(|Integer|))))
                           |target|))
                         ((AND (|isEqualOrSubDomain| |a1| |$Integer|)
                               (CONSP |a2|) (EQ (CAR |a2|) '|Variable|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |a2|))
                                (AND (CONSP |ISTMP#1|)
                                     (EQ (CDR |ISTMP#1|) NIL))))
                          (PROGN
                           (|putTarget| |opNode|
                            (SETQ |target|
                                    (|mkRationalFunction| '(|Integer|))))
                           |target|))
                         (#1#
                          (PROGN
                           (AND (CONSP |a1|) (EQ (CAR |a1|) '|Variable|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |a1|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)))
                                (COND
                                 ((AND (CONSP |a2|)
                                       (EQ (CAR |a2|) '|Polynomial|)
                                       (PROGN
                                        (SETQ |ISTMP#1| (CDR |a2|))
                                        (AND (CONSP |ISTMP#1|)
                                             (EQ (CDR |ISTMP#1|) NIL)
                                             (PROGN
                                              (SETQ D (CAR |ISTMP#1|))
                                              #1#))))
                                  (PROGN
                                   (|putTarget| |opNode|
                                    (SETQ |target| (|mkRationalFunction| D)))
                                   |target|))
                                 (#1# |target|)))
                           (AND (CONSP |a2|) (EQ (CAR |a2|) '|Variable|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |a2|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)))
                                (COND
                                 ((AND (CONSP |a1|)
                                       (EQ (CAR |a1|) '|Polynomial|)
                                       (PROGN
                                        (SETQ |ISTMP#1| (CDR |a1|))
                                        (AND (CONSP |ISTMP#1|)
                                             (EQ (CDR |ISTMP#1|) NIL)
                                             (PROGN
                                              (SETQ D (CAR |ISTMP#1|))
                                              #1#))))
                                  (PROGN
                                   (|putTarget| |opNode|
                                    (SETQ |target| (|mkRationalFunction| D)))
                                   |target|))
                                 (#1# |target|)))
                           (COND
                            ((AND (CONSP |a2|) (EQ (CAR |a2|) '|Polynomial|)
                                  (PROGN
                                   (SETQ |ISTMP#1| (CDR |a2|))
                                   (AND (CONSP |ISTMP#1|)
                                        (EQ (CDR |ISTMP#1|) NIL)
                                        (PROGN (SETQ D (CAR |ISTMP#1|)) #1#)))
                                  (EQUAL |a1| D))
                             (PROGN
                              (|putTarget| |opNode|
                               (SETQ |target| (|mkRationalFunction| D)))
                              |target|))
                            (#1# |target|))))))))
                     (#1#
                      (PROGN
                       (SETQ |a3| (CADDR |args|))
                       (COND
                        ((EQL |nargs| 3)
                         (COND
                          ((EQ |op| '|eval|)
                           (IDENTITY
                            (COND
                             ((AND (CONSP |a3|) (EQ (CAR |a3|) '|List|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |a3|))
                                    (AND (CONSP |ISTMP#1|)
                                         (EQ (CDR |ISTMP#1|) NIL)
                                         (PROGN
                                          (SETQ |a3e| (CAR |ISTMP#1|))
                                          #1#))))
                              (PROGN
                               (SETQ |target| (|resolveTT| |a1| |a3e|))
                               (COND
                                ((NULL (EQUAL |target| |$Any|))
                                 (|putTarget| |opNode| |target|))
                                (#1# (SETQ |target| NIL)))
                               |target|))
                             (#1#
                              (PROGN
                               (SETQ |target| (|resolveTT| |a1| |a3|))
                               (COND
                                ((NULL (EQUAL |target| |$Any|))
                                 (|putTarget| |opNode| |target|))
                                (#1# (SETQ |target| NIL)))
                               |target|)))))))
                        (#1# |target|))))))))))))))))))

; mkRationalFunction D ==  ['Fraction, ['Polynomial, D]]

(DEFUN |mkRationalFunction| (D)
  (PROG () (RETURN (LIST '|Fraction| (LIST '|Polynomial| D)))))

; defaultTargetFE(a,:options) ==
;   a is ['Variable,.] or a = $RationalNumber or MEMQ(QCAR a,
;     [QCAR $Symbol,
;      'Pi]) or typeIsASmallInteger(a) or isEqualOrSubDomain(a, $Integer) or
;        a = '(AlgebraicNumber) =>
;           IFCAR options => [$FunctionalExpression, ['Complex, $Integer]]
;           [$FunctionalExpression, $Integer]
;   a is ['Complex,uD] => defaultTargetFE(uD, true)
;   a is [D, uD] and MEMQ(D, '(Polynomial Fraction)) =>
;      defaultTargetFE(uD, IFCAR options)
;   a is [=$FunctionalExpression,.] => a
;   IFCAR options => [$FunctionalExpression, ['Complex, a]]
;   [$FunctionalExpression, a]

(DEFUN |defaultTargetFE| (|a| &REST |options|)
  (PROG (|ISTMP#1| |uD| D)
    (RETURN
     (COND
      ((OR
        (AND (CONSP |a|) (EQ (CAR |a|) '|Variable|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |a|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
        (EQUAL |a| |$RationalNumber|)
        (MEMQ (QCAR |a|) (LIST (QCAR |$Symbol|) '|Pi|))
        (|typeIsASmallInteger| |a|) (|isEqualOrSubDomain| |a| |$Integer|)
        (EQUAL |a| '(|AlgebraicNumber|)))
       (COND
        ((IFCAR |options|)
         (LIST |$FunctionalExpression| (LIST '|Complex| |$Integer|)))
        (#1='T (LIST |$FunctionalExpression| |$Integer|))))
      ((AND (CONSP |a|) (EQ (CAR |a|) '|Complex|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |a|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |uD| (CAR |ISTMP#1|)) #1#))))
       (|defaultTargetFE| |uD| T))
      ((AND (CONSP |a|)
            (PROGN
             (SETQ D (CAR |a|))
             (SETQ |ISTMP#1| (CDR |a|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |uD| (CAR |ISTMP#1|)) #1#)))
            (MEMQ D '(|Polynomial| |Fraction|)))
       (|defaultTargetFE| |uD| (IFCAR |options|)))
      ((AND (CONSP |a|) (EQUAL (CAR |a|) |$FunctionalExpression|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |a|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
       |a|)
      ((IFCAR |options|) (LIST |$FunctionalExpression| (LIST '|Complex| |a|)))
      (#1# (LIST |$FunctionalExpression| |a|))))))

; altTypeOf(type,val,$declaredMode) ==
;   (EQCAR(type,'Symbol) or EQCAR(type,'Variable)) and
;     (a := getMinimalVarMode(objValUnwrap getValue(val),$declaredMode)) =>
;       a
;   type is ['OrderedVariableList,vl] and
;     INTEGERP(val1 := objValUnwrap getValue(val)) and
;       (a := getMinimalVarMode(vl.(val1 - 1),$declaredMode)) =>
;         a
;   type = $PositiveInteger    => $Integer
;   type = $NonNegativeInteger => $Integer
;   type = '(List (PositiveInteger)) => '(List (Integer))
;   NIL

(DEFUN |altTypeOf| (|type| |val| |$declaredMode|)
  (DECLARE (SPECIAL |$declaredMode|))
  (PROG (|a| |ISTMP#1| |vl| |val1|)
    (RETURN
     (COND
      ((AND (OR (EQCAR |type| '|Symbol|) (EQCAR |type| '|Variable|))
            (SETQ |a|
                    (|getMinimalVarMode| (|objValUnwrap| (|getValue| |val|))
                     |$declaredMode|)))
       |a|)
      ((AND (CONSP |type|) (EQ (CAR |type|) '|OrderedVariableList|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |type|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |vl| (CAR |ISTMP#1|)) #1='T)))
            (INTEGERP (SETQ |val1| (|objValUnwrap| (|getValue| |val|))))
            (SETQ |a|
                    (|getMinimalVarMode| (ELT |vl| (- |val1| 1))
                     |$declaredMode|)))
       |a|)
      ((EQUAL |type| |$PositiveInteger|) |$Integer|)
      ((EQUAL |type| |$NonNegativeInteger|) |$Integer|)
      ((EQUAL |type| '(|List| (|PositiveInteger|))) '(|List| (|Integer|)))
      (#1# NIL)))))

; getOpArgTypes(opname, args) ==
;   l := getOpArgTypes1(opname, args)
;   [f(a,opname) for a in l] where
;     f(x,op) ==
;       x is ['FunctionCalled,g] and op ~= 'name =>
;         m := get(g,'mode,$e) =>
;           m is ['Mapping,:.] => m
;           x
;         x
;       x

(DEFUN |getOpArgTypes| (|opname| |args|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l| (|getOpArgTypes1| |opname| |args|))
      ((LAMBDA (|bfVar#18| |bfVar#17| |a|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#17|) (PROGN (SETQ |a| (CAR |bfVar#17|)) NIL))
            (RETURN (NREVERSE |bfVar#18|)))
           ('T
            (SETQ |bfVar#18|
                    (CONS (|getOpArgTypes,f| |a| |opname|) |bfVar#18|))))
          (SETQ |bfVar#17| (CDR |bfVar#17|))))
       NIL |l| NIL)))))
(DEFUN |getOpArgTypes,f| (|x| |op|)
  (PROG (|ISTMP#1| |g| |m|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) '|FunctionCalled|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |g| (CAR |ISTMP#1|)) #1='T)))
            (NOT (EQ |op| '|name|)))
       (COND
        ((SETQ |m| (|get| |g| '|mode| |$e|))
         (COND ((AND (CONSP |m|) (EQ (CAR |m|) '|Mapping|)) |m|) (#1# |x|)))
        (#1# |x|)))
      (#1# |x|)))))

; getOpArgTypes1(opname, args) ==
;   null args => NIL
;   -- special cases first
;   opname = 'coef and args is [b,n] =>
;     [first getModeSet b, first getModeSetUseSubdomain n]
;   opname = 'monom and args is [d,c] =>
;     [first getModeSetUseSubdomain d, first getModeSet c]
;   opname = 'monom and args is [v,d,c] =>
;     [first getModeSet v, first getModeSetUseSubdomain d, first getModeSet c]
;   (opname = 'cons) and (2 = #args) and (CADR(args) = 'nil) =>
;     ms := [first getModeSet x for x in args]
;     if CADR(ms) = '(List (None)) then
;       ms := [first ms,['List,first ms]]
;     ms
;   nargs := #args
;   v := argCouldBelongToSubdomain(opname,nargs)
;   mss := NIL
;   for i in 0..(nargs-1) for x in args repeat
;     ms :=
;         v.i = 0 => first getModeSet x
;         first getModeSetUseSubdomain x
;     mss := [ms,:mss]
;   nreverse mss

(DEFUN |getOpArgTypes1| (|opname| |args|)
  (PROG (|b| |ISTMP#1| |n| |d| |c| |v| |ISTMP#2| |ms| |nargs| |mss|)
    (RETURN
     (COND ((NULL |args|) NIL)
           ((AND (EQ |opname| '|coef|) (CONSP |args|)
                 (PROGN
                  (SETQ |b| (CAR |args|))
                  (SETQ |ISTMP#1| (CDR |args|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |n| (CAR |ISTMP#1|)) #1='T))))
            (LIST (CAR (|getModeSet| |b|))
                  (CAR (|getModeSetUseSubdomain| |n|))))
           ((AND (EQ |opname| '|monom|) (CONSP |args|)
                 (PROGN
                  (SETQ |d| (CAR |args|))
                  (SETQ |ISTMP#1| (CDR |args|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |c| (CAR |ISTMP#1|)) #1#))))
            (LIST (CAR (|getModeSetUseSubdomain| |d|))
                  (CAR (|getModeSet| |c|))))
           ((AND (EQ |opname| '|monom|) (CONSP |args|)
                 (PROGN
                  (SETQ |v| (CAR |args|))
                  (SETQ |ISTMP#1| (CDR |args|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |d| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |c| (CAR |ISTMP#2|)) #1#))))))
            (LIST (CAR (|getModeSet| |v|)) (CAR (|getModeSetUseSubdomain| |d|))
                  (CAR (|getModeSet| |c|))))
           ((AND (EQ |opname| '|cons|) (EQL 2 (LENGTH |args|))
                 (EQ (CADR |args|) '|nil|))
            (PROGN
             (SETQ |ms|
                     ((LAMBDA (|bfVar#20| |bfVar#19| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#19|)
                               (PROGN (SETQ |x| (CAR |bfVar#19|)) NIL))
                           (RETURN (NREVERSE |bfVar#20|)))
                          (#1#
                           (SETQ |bfVar#20|
                                   (CONS (CAR (|getModeSet| |x|))
                                         |bfVar#20|))))
                         (SETQ |bfVar#19| (CDR |bfVar#19|))))
                      NIL |args| NIL))
             (COND
              ((EQUAL (CADR |ms|) '(|List| (|None|)))
               (SETQ |ms| (LIST (CAR |ms|) (LIST '|List| (CAR |ms|))))))
             |ms|))
           (#1#
            (PROGN
             (SETQ |nargs| (LENGTH |args|))
             (SETQ |v| (|argCouldBelongToSubdomain| |opname| |nargs|))
             (SETQ |mss| NIL)
             ((LAMBDA (|bfVar#21| |i| |bfVar#22| |x|)
                (LOOP
                 (COND
                  ((OR (> |i| |bfVar#21|) (ATOM |bfVar#22|)
                       (PROGN (SETQ |x| (CAR |bfVar#22|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |ms|
                            (COND
                             ((EQL (ELT |v| |i|) 0) (CAR (|getModeSet| |x|)))
                             (#1# (CAR (|getModeSetUseSubdomain| |x|)))))
                    (SETQ |mss| (CONS |ms| |mss|)))))
                 (SETQ |i| (+ |i| 1))
                 (SETQ |bfVar#22| (CDR |bfVar#22|))))
              (- |nargs| 1) 0 |args| NIL)
             (NREVERSE |mss|)))))))

; argCouldBelongToSubdomain(op, nargs) ==
;   -- this returns a vector containing 0 or ^0 for each argument.
;   -- if ^0, this indicates that there exists a modemap for the
;   -- op that needs a subdomain in that position
;   nargs = 0 => NIL
;   v := GETZEROVEC nargs
;   isMap(op) => v
;   mms := getModemapsFromDatabase(op,nargs)
;   null mms => v
;   nargs:=nargs-1
;   -- each signature has form
;   -- [domain of implementation, target, arg1, arg2, ...]
;   for [sig,cond,:.] in mms repeat
;     for t in CDDR sig for i in 0..(nargs) repeat
;       CONTAINEDisDomain(t,cond) =>
;           v.i := 1 + v.i
;   v

(DEFUN |argCouldBelongToSubdomain| (|op| |nargs|)
  (PROG (|v| |mms| |sig| |ISTMP#1| |cond|)
    (RETURN
     (COND ((EQL |nargs| 0) NIL)
           (#1='T
            (PROGN
             (SETQ |v| (GETZEROVEC |nargs|))
             (COND ((|isMap| |op|) |v|)
                   (#1#
                    (PROGN
                     (SETQ |mms| (|getModemapsFromDatabase| |op| |nargs|))
                     (COND ((NULL |mms|) |v|)
                           (#1#
                            (PROGN
                             (SETQ |nargs| (- |nargs| 1))
                             ((LAMBDA (|bfVar#24| |bfVar#23|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#24|)
                                       (PROGN
                                        (SETQ |bfVar#23| (CAR |bfVar#24|))
                                        NIL))
                                   (RETURN NIL))
                                  (#1#
                                   (AND (CONSP |bfVar#23|)
                                        (PROGN
                                         (SETQ |sig| (CAR |bfVar#23|))
                                         (SETQ |ISTMP#1| (CDR |bfVar#23|))
                                         (AND (CONSP |ISTMP#1|)
                                              (PROGN
                                               (SETQ |cond| (CAR |ISTMP#1|))
                                               #1#)))
                                        ((LAMBDA (|bfVar#25| |t| |i|)
                                           (LOOP
                                            (COND
                                             ((OR (ATOM |bfVar#25|)
                                                  (PROGN
                                                   (SETQ |t| (CAR |bfVar#25|))
                                                   NIL)
                                                  (> |i| |nargs|))
                                              (RETURN NIL))
                                             (#1#
                                              (COND
                                               ((|CONTAINEDisDomain| |t|
                                                 |cond|)
                                                (IDENTITY
                                                 (SETF (ELT |v| |i|)
                                                         (+ 1
                                                            (ELT |v|
                                                                 |i|))))))))
                                            (SETQ |bfVar#25| (CDR |bfVar#25|))
                                            (SETQ |i| (+ |i| 1))))
                                         (CDDR |sig|) NIL 0))))
                                 (SETQ |bfVar#24| (CDR |bfVar#24|))))
                              |mms| NIL)
                             |v|))))))))))))

; CONTAINEDisDomain(symbol,cond) ==
; -- looks for [isSubDomain,symbol,[domain]] in cond: returning T or NIL
; -- with domain being one of PositiveInteger and NonNegativeInteger
;    ATOM cond => false
;    MEMQ(QCAR cond,'(AND OR and or)) =>
;        or/[CONTAINEDisDomain(symbol, u) for u in QCDR cond]
;    EQ(QCAR cond,'isDomain) =>
;        EQ(symbol,CADR cond) and PAIRP(dom:=CADDR cond) and
;          MEMQ(dom,'(PositiveInteger NonNegativeInteger))
;    false

(DEFUN |CONTAINEDisDomain| (|symbol| |cond|)
  (PROG (|dom|)
    (RETURN
     (COND ((ATOM |cond|) NIL)
           ((MEMQ (QCAR |cond|) '(AND OR |and| |or|))
            ((LAMBDA (|bfVar#27| |bfVar#26| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#26|)
                      (PROGN (SETQ |u| (CAR |bfVar#26|)) NIL))
                  (RETURN |bfVar#27|))
                 (#1='T
                  (PROGN
                   (SETQ |bfVar#27| (|CONTAINEDisDomain| |symbol| |u|))
                   (COND (|bfVar#27| (RETURN |bfVar#27|))))))
                (SETQ |bfVar#26| (CDR |bfVar#26|))))
             NIL (QCDR |cond|) NIL))
           ((EQ (QCAR |cond|) '|isDomain|)
            (AND (EQ |symbol| (CADR |cond|))
                 (CONSP (SETQ |dom| (CADDR |cond|)))
                 (MEMQ |dom| '(|PositiveInteger| |NonNegativeInteger|))))
           (#1# NIL)))))

; selectDollarMms(dc,name,types1,types2) ==
;   -- finds functions for name in domain dc
;   isPartialMode dc => throwKeyedMsg("S2IF0001",NIL)
;   mmS := findFunctionInDomain(name,dc,NIL,types1,types2,'T,'T) =>
;     orderMms(name, mmS,types1,types2,NIL)
;   if $reportBottomUpFlag then sayMSG
;     ["%b",'"          function not found in ",prefix2String dc,"%d","%l"]
;   NIL

(DEFUN |selectDollarMms| (|dc| |name| |types1| |types2|)
  (PROG (|mmS|)
    (RETURN
     (COND ((|isPartialMode| |dc|) (|throwKeyedMsg| 'S2IF0001 NIL))
           ((SETQ |mmS|
                    (|findFunctionInDomain| |name| |dc| NIL |types1| |types2|
                     'T 'T))
            (|orderMms| |name| |mmS| |types1| |types2| NIL))
           ('T
            (PROGN
             (COND
              (|$reportBottomUpFlag|
               (|sayMSG|
                (LIST '|%b| "          function not found in "
                      (|prefix2String| |dc|) '|%d| '|%l|))))
             NIL))))))

; selectLocalMms(op,name,types,tar) ==
;   -- partial rewrite, looks now for exact local modemap
;   mmS:= getLocalMms(name,types,tar) => mmS
;   obj := getValue op
;   obj and (objVal obj is ['SPADMAP, :mapDef]) and
;     analyzeMap(op,types,mapDef,tar) and getLocalMms(name,types,tar)

(DEFUN |selectLocalMms| (|op| |name| |types| |tar|)
  (PROG (|mmS| |obj| |ISTMP#1| |mapDef|)
    (RETURN
     (COND ((SETQ |mmS| (|getLocalMms| |name| |types| |tar|)) |mmS|)
           (#1='T
            (PROGN
             (SETQ |obj| (|getValue| |op|))
             (AND |obj|
                  (PROGN
                   (SETQ |ISTMP#1| (|objVal| |obj|))
                   (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADMAP)
                        (PROGN (SETQ |mapDef| (CDR |ISTMP#1|)) #1#)))
                  (|analyzeMap| |op| |types| |mapDef| |tar|)
                  (|getLocalMms| |name| |types| |tar|))))))))

; getLocalMms(name,types,tar) ==
;   -- looks for exact or subsumed local modemap in $e
;   mmS := NIL
;   for  (mm:=[dcSig,:.]) in get(name,'localModemap,$e) repeat
;     -- check format and destructure
;     dcSig isnt [dc,result,:args] => NIL
;     -- make number of args is correct
;     #types ~= #args => NIL
;     -- check for equal or subsumed arguments
;     subsume := (not $useIntegerSubdomain) or (tar = result) or
;       get(name,'recursive,$e)
;     acceptableArgs :=
;       and/[f(b,a,subsume) for a in args for b in types] where
;         f(x,y,subsume) ==
;           if subsume
;             then isEqualOrSubDomain(x,y)
;             else x = y
;     not acceptableArgs =>
;       -- interpreted maps are ok
;       dc = 'interpOnly and not($Coerce)=> mmS := [mm,:mmS]
;       NIL
;     mmS := [mm,:mmS]
;   nreverse mmS

(DEFUN |getLocalMms| (|name| |types| |tar|)
  (PROG (|mmS| |dcSig| |dc| |ISTMP#1| |result| |args| |subsume|
         |acceptableArgs|)
    (RETURN
     (PROGN
      (SETQ |mmS| NIL)
      ((LAMBDA (|bfVar#28| |mm|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#28|) (PROGN (SETQ |mm| (CAR |bfVar#28|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |mm|) (PROGN (SETQ |dcSig| (CAR |mm|)) #1#)
                 (COND
                  ((NOT
                    (AND (CONSP |dcSig|)
                         (PROGN
                          (SETQ |dc| (CAR |dcSig|))
                          (SETQ |ISTMP#1| (CDR |dcSig|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |result| (CAR |ISTMP#1|))
                                (SETQ |args| (CDR |ISTMP#1|))
                                #1#)))))
                   NIL)
                  ((NOT (EQL (LENGTH |types|) (LENGTH |args|))) NIL)
                  (#1#
                   (PROGN
                    (SETQ |subsume|
                            (OR (NULL |$useIntegerSubdomain|)
                                (EQUAL |tar| |result|)
                                (|get| |name| '|recursive| |$e|)))
                    (SETQ |acceptableArgs|
                            ((LAMBDA (|bfVar#31| |bfVar#29| |a| |bfVar#30| |b|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#29|)
                                      (PROGN (SETQ |a| (CAR |bfVar#29|)) NIL)
                                      (ATOM |bfVar#30|)
                                      (PROGN (SETQ |b| (CAR |bfVar#30|)) NIL))
                                  (RETURN |bfVar#31|))
                                 (#1#
                                  (PROGN
                                   (SETQ |bfVar#31|
                                           (|getLocalMms,f| |b| |a| |subsume|))
                                   (COND ((NOT |bfVar#31|) (RETURN NIL))))))
                                (SETQ |bfVar#29| (CDR |bfVar#29|))
                                (SETQ |bfVar#30| (CDR |bfVar#30|))))
                             T |args| NIL |types| NIL))
                    (COND
                     ((NULL |acceptableArgs|)
                      (COND
                       ((AND (EQ |dc| '|interpOnly|) (NULL |$Coerce|))
                        (SETQ |mmS| (CONS |mm| |mmS|)))
                       (#1# NIL)))
                     (#1# (SETQ |mmS| (CONS |mm| |mmS|))))))))))
          (SETQ |bfVar#28| (CDR |bfVar#28|))))
       (|get| |name| '|localModemap| |$e|) NIL)
      (NREVERSE |mmS|)))))
(DEFUN |getLocalMms,f| (|x| |y| |subsume|)
  (PROG ()
    (RETURN
     (COND (|subsume| (|isEqualOrSubDomain| |x| |y|)) ('T (EQUAL |x| |y|))))))

; isApproximate(t) ==
;     op := first(t)
;     member(op, ["Float", "DoubleFloat"]) => true
;     member(op, ["Complex", "Expression", "List", "Polynomial",
;                 "Matrix", "Vector"]) => isApproximate(first(rest(t)))
;     false

(DEFUN |isApproximate| (|t|)
  (PROG (|op|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |t|))
      (COND ((|member| |op| (LIST '|Float| '|DoubleFloat|)) T)
            ((|member| |op|
              (LIST '|Complex| '|Expression| '|List| '|Polynomial| '|Matrix|
                    '|Vector|))
             (|isApproximate| (CAR (CDR |t|))))
            ('T NIL))))))

; mmCost(sig, cond, tar, args1, args2) ==
;   cost := mmCost0(sig, cond, tar, args1, args2)
;   res := CADR sig
;   res = $PositiveInteger => cost - 2
;   res = $NonNegativeInteger => cost - 1
;   res = $DoubleFloat => cost + 1
;   cost

(DEFUN |mmCost| (|sig| |cond| |tar| |args1| |args2|)
  (PROG (|cost| |res|)
    (RETURN
     (PROGN
      (SETQ |cost| (|mmCost0| |sig| |cond| |tar| |args1| |args2|))
      (SETQ |res| (CADR |sig|))
      (COND ((EQUAL |res| |$PositiveInteger|) (- |cost| 2))
            ((EQUAL |res| |$NonNegativeInteger|) (- |cost| 1))
            ((EQUAL |res| |$DoubleFloat|) (+ |cost| 1)) ('T |cost|))))))

; mmCost0(sig, cond, tar, args1, args2) ==
;   sigArgs := CDDR sig
;   n:=
;     null cond => 1
;     not (or/cond) => 1
;     0
;
;   -- because of obscure problem in evalMm, sometimes we will have extra
;   -- modemaps with the wrong number of arguments if we want to the one
;   -- with no arguments and the name is overloaded. Thus check for this.
;
;   nargs := #args1
;
;   if args1 then
;     for x1 in args1 for x2 in args2 for x3 in sigArgs repeat
;       n := n +
;         isEqualOrSubDomain(x1,x3) => 0
;         topcon := first deconstructT x1
;         topcon2 := first deconstructT x3
;         topcon = topcon2 => 3
;         first topcon2 = 'Mapping => 2
;         4
;       if isApproximate(x1) ~= isApproximate(x3) then
;           n := n + 10*nargs
;   else if sigArgs then n := n + 100000000000
;
;   res := CADR sig
;   res=tar => 10000*n
;   10000*n + 1000*domainDepth(res) + hitListOfTarget(res)

(DEFUN |mmCost0| (|sig| |cond| |tar| |args1| |args2|)
  (PROG (|sigArgs| |n| |nargs| |topcon| |topcon2| |res|)
    (RETURN
     (PROGN
      (SETQ |sigArgs| (CDDR |sig|))
      (SETQ |n|
              (COND ((NULL |cond|) 1)
                    ((NULL
                      ((LAMBDA (|bfVar#32| |bfVar#34| |bfVar#33|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#34|)
                                (PROGN (SETQ |bfVar#33| (CAR |bfVar#34|)) NIL))
                            (RETURN |bfVar#32|))
                           (#1='T
                            (SETQ |bfVar#32| (OR |bfVar#32| |bfVar#33|))))
                          (SETQ |bfVar#34| (CDR |bfVar#34|))))
                       NIL |cond| NIL))
                     1)
                    (#1# 0)))
      (SETQ |nargs| (LENGTH |args1|))
      (COND
       (|args1|
        ((LAMBDA (|bfVar#35| |x1| |bfVar#36| |x2| |bfVar#37| |x3|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#35|) (PROGN (SETQ |x1| (CAR |bfVar#35|)) NIL)
                  (ATOM |bfVar#36|) (PROGN (SETQ |x2| (CAR |bfVar#36|)) NIL)
                  (ATOM |bfVar#37|) (PROGN (SETQ |x3| (CAR |bfVar#37|)) NIL))
              (RETURN NIL))
             (#1#
              (PROGN
               (SETQ |n|
                       (+ |n|
                          (COND ((|isEqualOrSubDomain| |x1| |x3|) 0)
                                (#1#
                                 (PROGN
                                  (SETQ |topcon| (CAR (|deconstructT| |x1|)))
                                  (SETQ |topcon2| (CAR (|deconstructT| |x3|)))
                                  (COND ((EQUAL |topcon| |topcon2|) 3)
                                        ((EQ (CAR |topcon2|) '|Mapping|) 2)
                                        (#1# 4)))))))
               (COND
                ((NOT (EQUAL (|isApproximate| |x1|) (|isApproximate| |x3|)))
                 (SETQ |n| (+ |n| (* 10 |nargs|))))))))
            (SETQ |bfVar#35| (CDR |bfVar#35|))
            (SETQ |bfVar#36| (CDR |bfVar#36|))
            (SETQ |bfVar#37| (CDR |bfVar#37|))))
         |args1| NIL |args2| NIL |sigArgs| NIL))
       (|sigArgs| (SETQ |n| (+ |n| 100000000000))))
      (SETQ |res| (CADR |sig|))
      (COND ((EQUAL |res| |tar|) (* 10000 |n|))
            (#1#
             (+ (+ (* 10000 |n|) (* 1000 (|domainDepth| |res|)))
                (|hitListOfTarget| |res|))))))))

; orderMms(name, mmS,args1,args2,tar) ==
;   -- it counts the number of necessary coercions of the argument types
;   -- if this isn't enough, it compares the target types
;   mmS and null rest mmS => mmS
;   mS:= NIL
;   N:= NIL
;   for mm in MSORT mmS repeat
;     [sig,.,cond]:= mm
;     b:= 'T
;     p:= CONS(m := mmCost(sig, cond, tar, args1, args2), mm)
;     mS:=
;       null mS => list p
;       m < CAAR mS => CONS(p,mS)
;       S:= mS
;       until b repeat
;         b := null rest S or m < CAADR S =>
;           RPLACD(S, CONS(p, rest S))
;         S := rest S
;       mS
;   mmS and [rest p for p in mS]

(DEFUN |orderMms| (|name| |mmS| |args1| |args2| |tar|)
  (PROG (|mS| N |sig| |cond| |b| |m| |p| S)
    (RETURN
     (COND ((AND |mmS| (NULL (CDR |mmS|))) |mmS|)
           (#1='T
            (PROGN
             (SETQ |mS| NIL)
             (SETQ N NIL)
             ((LAMBDA (|bfVar#38| |mm|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#38|)
                       (PROGN (SETQ |mm| (CAR |bfVar#38|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |sig| (CAR |mm|))
                    (SETQ |cond| (CADDR |mm|))
                    (SETQ |b| 'T)
                    (SETQ |p|
                            (CONS
                             (SETQ |m|
                                     (|mmCost| |sig| |cond| |tar| |args1|
                                      |args2|))
                             |mm|))
                    (SETQ |mS|
                            (COND ((NULL |mS|) (LIST |p|))
                                  ((< |m| (CAAR |mS|)) (CONS |p| |mS|))
                                  (#1#
                                   (PROGN
                                    (SETQ S |mS|)
                                    ((LAMBDA (|bfVar#39|)
                                       (LOOP
                                        (COND (|bfVar#39| (RETURN NIL))
                                              (#1#
                                               (COND
                                                ((SETQ |b|
                                                         (OR (NULL (CDR S))
                                                             (< |m|
                                                                (CAADR S))))
                                                 (RPLACD S (CONS |p| (CDR S))))
                                                (#1# (SETQ S (CDR S))))))
                                        (SETQ |bfVar#39| |b|)))
                                     NIL)
                                    |mS|)))))))
                 (SETQ |bfVar#38| (CDR |bfVar#38|))))
              (MSORT |mmS|) NIL)
             (AND |mmS|
                  ((LAMBDA (|bfVar#41| |bfVar#40| |p|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#40|)
                            (PROGN (SETQ |p| (CAR |bfVar#40|)) NIL))
                        (RETURN (NREVERSE |bfVar#41|)))
                       (#1# (SETQ |bfVar#41| (CONS (CDR |p|) |bfVar#41|))))
                      (SETQ |bfVar#40| (CDR |bfVar#40|))))
                   NIL |mS| NIL))))))))

; domainDepth(d) ==
;   -- computes the depth of lisp structure d
;   atom d => 0
;   MAX(domainDepth(first d) + 1, domainDepth(rest d))

(DEFUN |domainDepth| (|d|)
  (PROG ()
    (RETURN
     (COND ((ATOM |d|) 0)
           ('T
            (MAX (+ (|domainDepth| (CAR |d|)) 1) (|domainDepth| (CDR |d|))))))))

; hitListOfTarget(t) ==
;   -- assigns a number between 1 and 998 to a type t
;
;   -- want to make it hard to go to Polynomial Pi
;
;   t = '(Polynomial (Pi)) => 90000
;
;   EQ(first t, 'Polynomial) => 300
;   EQ(first t, 'List) => 400
;   EQ(first t, 'Matrix) => 910
;   EQ(first t, 'UniversalSegment) => 501
;   EQ(first t, 'Union) => 999
;   EQ(first t, 'Expression) => 1600
;   500

(DEFUN |hitListOfTarget| (|t|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |t| '(|Polynomial| (|Pi|))) 90000)
           ((EQ (CAR |t|) '|Polynomial|) 300) ((EQ (CAR |t|) '|List|) 400)
           ((EQ (CAR |t|) '|Matrix|) 910)
           ((EQ (CAR |t|) '|UniversalSegment|) 501)
           ((EQ (CAR |t|) '|Union|) 999) ((EQ (CAR |t|) '|Expression|) 1600)
           ('T 500)))))

; isOpInDomain(opName,dom,nargs) ==
;   -- returns true only if there is an op in the given domain with
;   -- the given number of arguments
;   mmList := ASSQ(opName, getOperationAlistFromLisplib first dom)
;   mmList := subCopy(mmList,constructSubst dom)
;   null mmList => NIL
;   gotOne := NIL
;   nargs := nargs + 1
;   for mm in rest mmList while not gotOne repeat
;     nargs = #first mm => gotOne := [mm, :gotOne]
;   gotOne

(DEFUN |isOpInDomain| (|opName| |dom| |nargs|)
  (PROG (|mmList| |gotOne|)
    (RETURN
     (PROGN
      (SETQ |mmList|
              (ASSQ |opName| (|getOperationAlistFromLisplib| (CAR |dom|))))
      (SETQ |mmList| (|subCopy| |mmList| (|constructSubst| |dom|)))
      (COND ((NULL |mmList|) NIL)
            (#1='T
             (PROGN
              (SETQ |gotOne| NIL)
              (SETQ |nargs| (+ |nargs| 1))
              ((LAMBDA (|bfVar#42| |mm|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#42|)
                        (PROGN (SETQ |mm| (CAR |bfVar#42|)) NIL) |gotOne|)
                    (RETURN NIL))
                   (#1#
                    (COND
                     ((EQL |nargs| (LENGTH (CAR |mm|)))
                      (IDENTITY (SETQ |gotOne| (CONS |mm| |gotOne|)))))))
                  (SETQ |bfVar#42| (CDR |bfVar#42|))))
               (CDR |mmList|) NIL)
              |gotOne|)))))))

; findCommonSigInDomain(opName,dom,nargs) ==
;   -- this looks at all signatures in dom with given opName and nargs
;   -- number of arguments. If no matches, returns NIL. Otherwise returns
;   -- a "signature" where a type position is non-NIL only if all
;   -- signatures shares that type .
;   first(dom) in '(Union Record Mapping) => NIL
;   mmList := ASSQ(opName, getOperationAlistFromLisplib first dom)
;   mmList := subCopy(mmList,constructSubst dom)
;   null mmList => NIL
;   gotOne := NIL
;   nargs := nargs + 1
;   vec := NIL
;   for mm in rest mmList repeat
;     nargs = #first mm =>
;       null vec  => vec := LIST2VEC first mm
;       for i in 0.. for x in first mm repeat
;         if vec.i and vec.i ~= x then vec.i := NIL
;   VEC2LIST vec

(DEFUN |findCommonSigInDomain| (|opName| |dom| |nargs|)
  (PROG (|mmList| |gotOne| |vec|)
    (RETURN
     (COND ((|member| (CAR |dom|) '(|Union| |Record| |Mapping|)) NIL)
           (#1='T
            (PROGN
             (SETQ |mmList|
                     (ASSQ |opName|
                      (|getOperationAlistFromLisplib| (CAR |dom|))))
             (SETQ |mmList| (|subCopy| |mmList| (|constructSubst| |dom|)))
             (COND ((NULL |mmList|) NIL)
                   (#1#
                    (PROGN
                     (SETQ |gotOne| NIL)
                     (SETQ |nargs| (+ |nargs| 1))
                     (SETQ |vec| NIL)
                     ((LAMBDA (|bfVar#43| |mm|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#43|)
                               (PROGN (SETQ |mm| (CAR |bfVar#43|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (COND
                            ((EQL |nargs| (LENGTH (CAR |mm|)))
                             (IDENTITY
                              (COND
                               ((NULL |vec|)
                                (SETQ |vec| (LIST2VEC (CAR |mm|))))
                               (#1#
                                ((LAMBDA (|i| |bfVar#44| |x|)
                                   (LOOP
                                    (COND
                                     ((OR (ATOM |bfVar#44|)
                                          (PROGN
                                           (SETQ |x| (CAR |bfVar#44|))
                                           NIL))
                                      (RETURN NIL))
                                     (#1#
                                      (COND
                                       ((AND (ELT |vec| |i|)
                                             (NOT (EQUAL (ELT |vec| |i|) |x|)))
                                        (SETF (ELT |vec| |i|) NIL)))))
                                    (SETQ |i| (+ |i| 1))
                                    (SETQ |bfVar#44| (CDR |bfVar#44|))))
                                 0 (CAR |mm|) NIL))))))))
                         (SETQ |bfVar#43| (CDR |bfVar#43|))))
                      (CDR |mmList|) NIL)
                     (VEC2LIST |vec|))))))))))

; findUniqueOpInDomain(op,opName,dom) ==
;   -- return function named op in domain dom if unique, choose one if not
;   mmList := ASSQ(opName, getOperationAlistFromLisplib first dom)
;   mmList := subCopy(mmList,constructSubst dom)
;   null mmList =>
;     throwKeyedMsg("S2IS0021",[opName,dom])
;   mmList := rest mmList   -- ignore the operator name
;   -- use evaluation type context to narrow down the candidate set
;   if target := getTarget op then
;       mmList := [mm for mm in mmList | mm is [=rest target,:.]]
;       null mmList => throwKeyedMsg("S2IS0061",[opName,target,dom])
;   if #mmList > 1 then
;     mm := selectMostGeneralMm mmList
;     sayKeyedMsg("S2IS0022", [opName, dom, ['Mapping, :first mm]])
;   else mm := first mmList
;   [sig,slot,:.] := mm
;   fun :=
; --+
;       $genValue =>
;          compiledLookupCheck(opName,sig,evalDomain dom)
;       NRTcompileEvalForm(opName, sig, evalDomain dom)
;   NULL(fun) or NULL(PAIRP(fun)) => NIL
;   first fun = function(Undef) => throwKeyedMsg("S2IS0023", [opName, dom])
;   binVal :=
;     $genValue => wrap fun
;     fun
;   putValue(op,objNew(binVal,m:=['Mapping,:sig]))
;   putModeSet(op,[m])

(DEFUN |findUniqueOpInDomain| (|op| |opName| |dom|)
  (PROG (|mmList| |target| |mm| |sig| |slot| |fun| |binVal| |m|)
    (RETURN
     (PROGN
      (SETQ |mmList|
              (ASSQ |opName| (|getOperationAlistFromLisplib| (CAR |dom|))))
      (SETQ |mmList| (|subCopy| |mmList| (|constructSubst| |dom|)))
      (COND ((NULL |mmList|) (|throwKeyedMsg| 'S2IS0021 (LIST |opName| |dom|)))
            (#1='T
             (PROGN
              (SETQ |mmList| (CDR |mmList|))
              (COND
               ((SETQ |target| (|getTarget| |op|))
                (SETQ |mmList|
                        ((LAMBDA (|bfVar#46| |bfVar#45| |mm|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#45|)
                                  (PROGN (SETQ |mm| (CAR |bfVar#45|)) NIL))
                              (RETURN (NREVERSE |bfVar#46|)))
                             (#1#
                              (AND (CONSP |mm|)
                                   (EQUAL (CAR |mm|) (CDR |target|))
                                   (SETQ |bfVar#46| (CONS |mm| |bfVar#46|)))))
                            (SETQ |bfVar#45| (CDR |bfVar#45|))))
                         NIL |mmList| NIL))
                (COND
                 ((NULL |mmList|)
                  (|throwKeyedMsg| 'S2IS0061
                   (LIST |opName| |target| |dom|))))))
              (COND
               ((< 1 (LENGTH |mmList|))
                (SETQ |mm| (|selectMostGeneralMm| |mmList|))
                (|sayKeyedMsg| 'S2IS0022
                 (LIST |opName| |dom| (CONS '|Mapping| (CAR |mm|)))))
               (#1# (SETQ |mm| (CAR |mmList|))))
              (SETQ |sig| (CAR |mm|))
              (SETQ |slot| (CADR |mm|))
              (SETQ |fun|
                      (COND
                       (|$genValue|
                        (|compiledLookupCheck| |opName| |sig|
                         (|evalDomain| |dom|)))
                       (#1#
                        (|NRTcompileEvalForm| |opName| |sig|
                         (|evalDomain| |dom|)))))
              (COND ((OR (NULL |fun|) (NULL (CONSP |fun|))) NIL)
                    ((EQUAL (CAR |fun|) #'|Undef|)
                     (|throwKeyedMsg| 'S2IS0023 (LIST |opName| |dom|)))
                    (#1#
                     (PROGN
                      (SETQ |binVal|
                              (COND (|$genValue| (|wrap| |fun|)) (#1# |fun|)))
                      (|putValue| |op|
                       (|objNew| |binVal| (SETQ |m| (CONS '|Mapping| |sig|))))
                      (|putModeSet| |op| (LIST |m|))))))))))))

; selectMostGeneralMm mmList ==
;   -- selects the modemap in mmList with arguments all the other
;   -- argument types can be coerced to
;   -- also selects function with #args closest to 2
;   min := 100
;   mml := mmList
;   while mml repeat
;     [mm,:mml] := mml
;     sz := #first mm
;     if (met := ABS(sz - 3)) < min then
;       min := met
;       fsz := sz
;   mmList := [mm for mm in mmList | (#first mm) = fsz]
;   mml := rest mmList
;   genMm := first mmList
;   while mml repeat
;     [mm,:mml] := mml
;     and/[canCoerceFrom(genMmArg,mmArg) for mmArg in CDAR mm
;       for genMmArg in CDAR genMm] => genMm := mm
;   genMm

(DEFUN |selectMostGeneralMm| (|mmList|)
  (PROG (|min| |mml| |LETTMP#1| |mm| |sz| |met| |fsz| |genMm|)
    (RETURN
     (PROGN
      (SETQ |min| 100)
      (SETQ |mml| |mmList|)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |mml|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |LETTMP#1| |mml|)
                  (SETQ |mm| (CAR |LETTMP#1|))
                  (SETQ |mml| (CDR |LETTMP#1|))
                  (SETQ |sz| (LENGTH (CAR |mm|)))
                  (COND
                   ((< (SETQ |met| (ABS (- |sz| 3))) |min|) (SETQ |min| |met|)
                    (SETQ |fsz| |sz|)))))))))
      (SETQ |mmList|
              ((LAMBDA (|bfVar#48| |bfVar#47| |mm|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#47|)
                        (PROGN (SETQ |mm| (CAR |bfVar#47|)) NIL))
                    (RETURN (NREVERSE |bfVar#48|)))
                   (#1#
                    (AND (EQL (LENGTH (CAR |mm|)) |fsz|)
                         (SETQ |bfVar#48| (CONS |mm| |bfVar#48|)))))
                  (SETQ |bfVar#47| (CDR |bfVar#47|))))
               NIL |mmList| NIL))
      (SETQ |mml| (CDR |mmList|))
      (SETQ |genMm| (CAR |mmList|))
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |mml|) (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |LETTMP#1| |mml|)
                  (SETQ |mm| (CAR |LETTMP#1|))
                  (SETQ |mml| (CDR |LETTMP#1|))
                  (COND
                   (((LAMBDA
                         (|bfVar#51| |bfVar#49| |mmArg| |bfVar#50| |genMmArg|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#49|)
                              (PROGN (SETQ |mmArg| (CAR |bfVar#49|)) NIL)
                              (ATOM |bfVar#50|)
                              (PROGN (SETQ |genMmArg| (CAR |bfVar#50|)) NIL))
                          (RETURN |bfVar#51|))
                         (#1#
                          (PROGN
                           (SETQ |bfVar#51|
                                   (|canCoerceFrom| |genMmArg| |mmArg|))
                           (COND ((NOT |bfVar#51|) (RETURN NIL))))))
                        (SETQ |bfVar#49| (CDR |bfVar#49|))
                        (SETQ |bfVar#50| (CDR |bfVar#50|))))
                     T (CDAR |mm|) NIL (CDAR |genMm|) NIL)
                    (SETQ |genMm| |mm|)))))))))
      |genMm|))))

; findFunctionInDomain(op,dc,tar,args1,args2,$Coerce,$SubDom) ==
;   -- looks for a modemap for op with signature  args1 -> tar
;   --   in the domain of computation dc
;   -- tar may be NIL (= unknown)
;   null isLegitimateMode(tar, nil, nil) => nil
;   dcName := first dc
;   member(dcName,'(Union Record Mapping Enumeration)) =>
;     -- First cut code that ignores args2, $Coerce and $SubDom
;     -- When domains no longer have to have Set, the hard coded 6 and 7
;     -- should go.
;     op = '_= =>
;         #args1 ~= 2 or args1.0 ~= dc or args1.1 ~= dc => NIL
;         tar and tar ~= '(Boolean) => NIL
;         [[[dc, '(Boolean), dc, dc], ['(Boolean),'$,'$], [NIL, NIL]]]
;     op = 'coerce =>
;         dcName='Enumeration and (args1.0=$Symbol or tar=dc)=>
;            [[[dc, dc, $Symbol], ['$,$Symbol], [NIL, NIL]]]
;         args1.0 ~= dc => NIL
;         tar and tar ~= $OutputForm => NIL
;         [[[dc, $OutputForm, dc], [$OutputForm, '$], [NIL, NIL]]]
;     member(dcName,'(Record Union)) =>
;       findFunctionInCategory(op,dc,tar,args1,args2,$Coerce,$SubDom)
;     NIL
;   fun:= NIL
;   ( p := ASSQ(op,getOperationAlistFromLisplib dcName) ) and
;     SL := constructSubst dc
;     -- if the arglist is homogeneous, first look for homogeneous
;     -- functions. If we don't find any, look at remaining ones
;     if isHomogeneousList args1 then
;       q := NIL
;       r := NIL
;       for mm in rest p repeat
;         -- CDAR of mm is the signature argument list
;         if isHomogeneousList CDAR mm then q := [mm,:q]
;         else r := [mm,:r]
;       q := allOrMatchingMms(q,args1,tar,dc)
;       for mm in q repeat
;         fun := nconc(fun, findFunctionInDomain1(mm, tar, args1, args2, SL))
;       r := reverse r
;     else r := rest p
;     r := allOrMatchingMms(r,args1,tar,dc)
;     if not fun then    -- consider remaining modemaps
;       for mm in r repeat
;         fun := nconc(fun, findFunctionInDomain1(mm, tar, args1, args2, SL))
;   if not fun and $reportBottomUpFlag then
;     sayMSG concat
;       ['"   -> no appropriate",:bright op,'"found in",
;         :bright prefix2String dc]
;   fun

(DEFUN |findFunctionInDomain|
       (|op| |dc| |tar| |args1| |args2| |$Coerce| |$SubDom|)
  (DECLARE (SPECIAL |$Coerce| |$SubDom|))
  (PROG (|dcName| |fun| |p| SL |q| |r|)
    (RETURN
     (COND ((NULL (|isLegitimateMode| |tar| NIL NIL)) NIL)
           (#1='T
            (PROGN
             (SETQ |dcName| (CAR |dc|))
             (COND
              ((|member| |dcName| '(|Union| |Record| |Mapping| |Enumeration|))
               (COND
                ((EQ |op| '=)
                 (COND
                  ((OR (NOT (EQL (LENGTH |args1|) 2))
                       (NOT (EQUAL (ELT |args1| 0) |dc|))
                       (NOT (EQUAL (ELT |args1| 1) |dc|)))
                   NIL)
                  ((AND |tar| (NOT (EQUAL |tar| '(|Boolean|)))) NIL)
                  (#1#
                   (LIST
                    (LIST (LIST |dc| '(|Boolean|) |dc| |dc|)
                          (LIST '(|Boolean|) '$ '$) (LIST NIL NIL))))))
                ((EQ |op| '|coerce|)
                 (COND
                  ((AND (EQ |dcName| '|Enumeration|)
                        (OR (EQUAL (ELT |args1| 0) |$Symbol|)
                            (EQUAL |tar| |dc|)))
                   (LIST
                    (LIST (LIST |dc| |dc| |$Symbol|) (LIST '$ |$Symbol|)
                          (LIST NIL NIL))))
                  ((NOT (EQUAL (ELT |args1| 0) |dc|)) NIL)
                  ((AND |tar| (NOT (EQUAL |tar| |$OutputForm|))) NIL)
                  (#1#
                   (LIST
                    (LIST (LIST |dc| |$OutputForm| |dc|)
                          (LIST |$OutputForm| '$) (LIST NIL NIL))))))
                ((|member| |dcName| '(|Record| |Union|))
                 (|findFunctionInCategory| |op| |dc| |tar| |args1| |args2|
                  |$Coerce| |$SubDom|))
                (#1# NIL)))
              (#1#
               (PROGN
                (SETQ |fun| NIL)
                (AND
                 (SETQ |p|
                         (ASSQ |op| (|getOperationAlistFromLisplib| |dcName|)))
                 (PROGN
                  (SETQ SL (|constructSubst| |dc|))
                  (COND
                   ((|isHomogeneousList| |args1|) (SETQ |q| NIL) (SETQ |r| NIL)
                    ((LAMBDA (|bfVar#52| |mm|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#52|)
                              (PROGN (SETQ |mm| (CAR |bfVar#52|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (COND
                           ((|isHomogeneousList| (CDAR |mm|))
                            (SETQ |q| (CONS |mm| |q|)))
                           (#1# (SETQ |r| (CONS |mm| |r|))))))
                        (SETQ |bfVar#52| (CDR |bfVar#52|))))
                     (CDR |p|) NIL)
                    (SETQ |q| (|allOrMatchingMms| |q| |args1| |tar| |dc|))
                    ((LAMBDA (|bfVar#53| |mm|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#53|)
                              (PROGN (SETQ |mm| (CAR |bfVar#53|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (SETQ |fun|
                                  (NCONC |fun|
                                         (|findFunctionInDomain1| |mm| |tar|
                                          |args1| |args2| SL)))))
                        (SETQ |bfVar#53| (CDR |bfVar#53|))))
                     |q| NIL)
                    (SETQ |r| (REVERSE |r|)))
                   (#1# (SETQ |r| (CDR |p|))))
                  (SETQ |r| (|allOrMatchingMms| |r| |args1| |tar| |dc|))
                  (COND
                   ((NULL |fun|)
                    ((LAMBDA (|bfVar#54| |mm|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#54|)
                              (PROGN (SETQ |mm| (CAR |bfVar#54|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (SETQ |fun|
                                  (NCONC |fun|
                                         (|findFunctionInDomain1| |mm| |tar|
                                          |args1| |args2| SL)))))
                        (SETQ |bfVar#54| (CDR |bfVar#54|))))
                     |r| NIL)))))
                (COND
                 ((AND (NULL |fun|) |$reportBottomUpFlag|)
                  (|sayMSG|
                   (|concat|
                    (CONS "   -> no appropriate"
                          (APPEND (|bright| |op|)
                                  (CONS "found in"
                                        (|bright|
                                         (|prefix2String| |dc|)))))))))
                |fun|)))))))))

; allOrMatchingMms(mms,args1,tar,dc) ==
;   -- if there are exact matches on the arg types, return them
;   -- otherwise return the original list
;   null mms or null rest mms => mms
;   x := NIL
;   for mm in mms repeat
;     [sig,:.] := mm
;     [res,:args] := MSUBSTQ(dc,"$",sig)
;     args ~= args1 => nil
;     x := CONS(mm,x)
;   if x then x
;   else mms

(DEFUN |allOrMatchingMms| (|mms| |args1| |tar| |dc|)
  (PROG (|x| |sig| |LETTMP#1| |res| |args|)
    (RETURN
     (COND ((OR (NULL |mms|) (NULL (CDR |mms|))) |mms|)
           (#1='T
            (PROGN
             (SETQ |x| NIL)
             ((LAMBDA (|bfVar#55| |mm|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#55|)
                       (PROGN (SETQ |mm| (CAR |bfVar#55|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |sig| (CAR |mm|))
                    (SETQ |LETTMP#1| (MSUBSTQ |dc| '$ |sig|))
                    (SETQ |res| (CAR |LETTMP#1|))
                    (SETQ |args| (CDR |LETTMP#1|))
                    (COND ((NOT (EQUAL |args| |args1|)) NIL)
                          (#1# (SETQ |x| (CONS |mm| |x|)))))))
                 (SETQ |bfVar#55| (CDR |bfVar#55|))))
              |mms| NIL)
             (COND (|x| |x|) (#1# |mms|))))))))

; isHomogeneousList y ==
;   y is [x] => true
;   y and rest y =>
;     z := first y
;     "and"/[x = z for x in rest y]
;   NIL

(DEFUN |isHomogeneousList| (|y|)
  (PROG (|x| |z|)
    (RETURN
     (COND
      ((AND (CONSP |y|) (EQ (CDR |y|) NIL) (PROGN (SETQ |x| (CAR |y|)) #1='T))
       T)
      ((AND |y| (CDR |y|))
       (PROGN
        (SETQ |z| (CAR |y|))
        ((LAMBDA (|bfVar#57| |bfVar#56| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#56|) (PROGN (SETQ |x| (CAR |bfVar#56|)) NIL))
              (RETURN |bfVar#57|))
             (#1#
              (PROGN
               (SETQ |bfVar#57| (EQUAL |x| |z|))
               (COND ((NOT |bfVar#57|) (RETURN NIL))))))
            (SETQ |bfVar#56| (CDR |bfVar#56|))))
         T (CDR |y|) NIL)))
      (#1# NIL)))))

; findFunctionInDomain1(omm, tar, args1, args2, SL) ==
;   dc := rest (dollarPair := ASSQ('$, SL))
;   -- need to drop '$ from SL
;   mm:= subCopy(omm, SL)
;   -- tests whether modemap mm is appropriate for the function
;   -- defined by op, target type tar and argument types args
;
;   [sig,slot,cond,y] := mm
;   [osig,:.]  := omm
;   osig := subCopy(osig, SUBSTQ(CONS('$,'$), dollarPair, SL))
;   if CONTAINED('_#, sig) or CONTAINED('construct, sig) then
;     sig := [replaceSharpCalls t for t in sig]
;   rtcp := [[]]
;   matchMmCond cond and matchMmSig(mm,tar,args1,args2, rtcp) and
;     -- RTC is a list of run-time checks to be performed
;     RTC := nreverse CAR(rtcp)
;     EQ(y, 'ELT) => [[CONS(dc, sig), osig, RTC]]
;     EQ(y, 'CONST) => [[CONS(dc,sig),osig, RTC]]
;     EQ(y, 'ASCONST) => [[CONS(dc, sig), osig, RTC]]
;     y is ['XLAM, :.] => [[CONS(dc,sig), y, RTC]]
;     sayKeyedMsg("S2IF0006",[y])
;     NIL

(DEFUN |findFunctionInDomain1| (|omm| |tar| |args1| |args2| SL)
  (PROG (|dollarPair| |dc| |mm| |sig| |slot| |cond| |y| |osig| |rtcp| RTC)
    (RETURN
     (PROGN
      (SETQ |dc| (CDR (SETQ |dollarPair| (ASSQ '$ SL))))
      (SETQ |mm| (|subCopy| |omm| SL))
      (SETQ |sig| (CAR |mm|))
      (SETQ |slot| (CADR . #1=(|mm|)))
      (SETQ |cond| (CADDR . #1#))
      (SETQ |y| (CADDDR . #1#))
      (SETQ |osig| (CAR |omm|))
      (SETQ |osig| (|subCopy| |osig| (SUBSTQ (CONS '$ '$) |dollarPair| SL)))
      (COND
       ((OR (CONTAINED '|#| |sig|) (CONTAINED '|construct| |sig|))
        (SETQ |sig|
                ((LAMBDA (|bfVar#59| |bfVar#58| |t|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#58|)
                          (PROGN (SETQ |t| (CAR |bfVar#58|)) NIL))
                      (RETURN (NREVERSE |bfVar#59|)))
                     (#2='T
                      (SETQ |bfVar#59|
                              (CONS (|replaceSharpCalls| |t|) |bfVar#59|))))
                    (SETQ |bfVar#58| (CDR |bfVar#58|))))
                 NIL |sig| NIL))))
      (SETQ |rtcp| (LIST NIL))
      (AND (|matchMmCond| |cond|)
           (|matchMmSig| |mm| |tar| |args1| |args2| |rtcp|)
           (PROGN
            (SETQ RTC (NREVERSE (CAR |rtcp|)))
            (COND ((EQ |y| 'ELT) (LIST (LIST (CONS |dc| |sig|) |osig| RTC)))
                  ((EQ |y| 'CONST) (LIST (LIST (CONS |dc| |sig|) |osig| RTC)))
                  ((EQ |y| 'ASCONST)
                   (LIST (LIST (CONS |dc| |sig|) |osig| RTC)))
                  ((AND (CONSP |y|) (EQ (CAR |y|) 'XLAM))
                   (LIST (LIST (CONS |dc| |sig|) |y| RTC)))
                  (#2# (PROGN (|sayKeyedMsg| 'S2IF0006 (LIST |y|)) NIL)))))))))

; findFunctionInCategory(op,dc,tar,args1,args2,$Coerce,$SubDom) ==
;   -- looks for a modemap for op with signature  args1 -> tar
;   --   in the domain of computation dc
;   -- tar may be NIL (= unknown)
;   dcName := first dc
;   not MEMQ(dcName,'(Record Union Enumeration)) => NIL
;   fun:= NIL
;  --  cat := constructorCategory dc
;   makeFunc := get_oplist_maker(dcName) or
;       systemErrorHere '"findFunctionInCategory"
;   [funlist,.] := FUNCALL(makeFunc,"$",dc,$CategoryFrame)
;   -- get list of implementations and remove sharps
;   maxargs := -1
;   impls := nil
;   for [a,b,d] in funlist repeat
;     not EQ(a,op) => nil
;     d is ['XLAM,xargs,:.] =>
;       if PAIRP(xargs) then maxargs := MAX(maxargs,#xargs)
;       else maxargs := MAX(maxargs,1)
;       impls := cons([b,nil,true,d],impls)
;     impls := cons([b,d,true,d],impls)
;   impls := NREVERSE impls
;   if maxargs ~= -1 then
;     SL:= NIL
;     for i in 1..maxargs repeat
;         impls := SUBSTQ(GENSYM(), INTERNL1('"#", STRINGIMAGE i), impls)
;   impls and
;     SL:= constructSubst dc
;     for mm in impls repeat
;       fun := nconc(fun, findFunctionInDomain1(mm, tar, args1, args2, SL))
;   if not fun and $reportBottomUpFlag then
;     sayMSG concat
;       ['"   -> no appropriate",:bright op,'"found in",
;         :bright prefix2String dc]
;   fun

(DEFUN |findFunctionInCategory|
       (|op| |dc| |tar| |args1| |args2| |$Coerce| |$SubDom|)
  (DECLARE (SPECIAL |$Coerce| |$SubDom|))
  (PROG (|dcName| |fun| |makeFunc| |LETTMP#1| |funlist| |maxargs| |impls| |a|
         |ISTMP#1| |b| |ISTMP#2| |d| |xargs| SL)
    (RETURN
     (PROGN
      (SETQ |dcName| (CAR |dc|))
      (COND ((NULL (MEMQ |dcName| '(|Record| |Union| |Enumeration|))) NIL)
            (#1='T
             (PROGN
              (SETQ |fun| NIL)
              (SETQ |makeFunc|
                      (OR (|get_oplist_maker| |dcName|)
                          (|systemErrorHere| "findFunctionInCategory")))
              (SETQ |LETTMP#1| (FUNCALL |makeFunc| '$ |dc| |$CategoryFrame|))
              (SETQ |funlist| (CAR |LETTMP#1|))
              (SETQ |maxargs| (- 1))
              (SETQ |impls| NIL)
              ((LAMBDA (|bfVar#61| |bfVar#60|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#61|)
                        (PROGN (SETQ |bfVar#60| (CAR |bfVar#61|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (AND (CONSP |bfVar#60|)
                         (PROGN
                          (SETQ |a| (CAR |bfVar#60|))
                          (SETQ |ISTMP#1| (CDR |bfVar#60|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |b| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN (SETQ |d| (CAR |ISTMP#2|)) #1#)))))
                         (COND ((NULL (EQ |a| |op|)) NIL)
                               ((AND (CONSP |d|) (EQ (CAR |d|) 'XLAM)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |d|))
                                      (AND (CONSP |ISTMP#1|)
                                           (PROGN
                                            (SETQ |xargs| (CAR |ISTMP#1|))
                                            #1#))))
                                (PROGN
                                 (COND
                                  ((CONSP |xargs|)
                                   (SETQ |maxargs|
                                           (MAX |maxargs| (LENGTH |xargs|))))
                                  (#1# (SETQ |maxargs| (MAX |maxargs| 1))))
                                 (SETQ |impls|
                                         (CONS (LIST |b| NIL T |d|) |impls|))))
                               (#1#
                                (SETQ |impls|
                                        (CONS (LIST |b| |d| T |d|)
                                              |impls|)))))))
                  (SETQ |bfVar#61| (CDR |bfVar#61|))))
               |funlist| NIL)
              (SETQ |impls| (NREVERSE |impls|))
              (COND
               ((NOT (EQUAL |maxargs| (- 1))) (SETQ SL NIL)
                ((LAMBDA (|i|)
                   (LOOP
                    (COND ((> |i| |maxargs|) (RETURN NIL))
                          (#1#
                           (SETQ |impls|
                                   (SUBSTQ (GENSYM)
                                    (INTERNL1 "#" (STRINGIMAGE |i|))
                                    |impls|))))
                    (SETQ |i| (+ |i| 1))))
                 1)))
              (AND |impls|
                   (PROGN
                    (SETQ SL (|constructSubst| |dc|))
                    ((LAMBDA (|bfVar#62| |mm|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#62|)
                              (PROGN (SETQ |mm| (CAR |bfVar#62|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (SETQ |fun|
                                  (NCONC |fun|
                                         (|findFunctionInDomain1| |mm| |tar|
                                          |args1| |args2| SL)))))
                        (SETQ |bfVar#62| (CDR |bfVar#62|))))
                     |impls| NIL)))
              (COND
               ((AND (NULL |fun|) |$reportBottomUpFlag|)
                (|sayMSG|
                 (|concat|
                  (CONS "   -> no appropriate"
                        (APPEND (|bright| |op|)
                                (CONS "found in"
                                      (|bright| (|prefix2String| |dc|)))))))))
              |fun|)))))))

; matchMmCond(cond) ==
;   -- tests the condition, which comes with a modemap
;   -- cond is 'T or a list, but I hate to test for 'T (ALBI)
;   $domPvar: local := nil
;   atom cond or
;     cond is ['AND,:conds] or cond is ['and,:conds] =>
;       and/[matchMmCond c for c in conds]
;     cond is ['OR,:conds] or cond is ['or,:conds] =>
;       or/[matchMmCond c for c in conds]
;     cond is ['has,dom,x] =>
;       hasCaty(dom,x,NIL) ~= 'failed
;     cond is ['not,cond1] => not matchMmCond cond1
;     keyedSystemError("S2GE0016",
;       ['"matchMmCond",'"unknown form of condition"])

(DEFUN |matchMmCond| (|cond|)
  (PROG (|$domPvar| |cond1| |x| |ISTMP#2| |dom| |ISTMP#1| |conds|)
    (DECLARE (SPECIAL |$domPvar|))
    (RETURN
     (PROGN
      (SETQ |$domPvar| NIL)
      (OR (ATOM |cond|)
          (COND
           ((OR
             (AND (CONSP |cond|) (EQ (CAR |cond|) 'AND)
                  (PROGN (SETQ |conds| (CDR |cond|)) #1='T))
             (AND (CONSP |cond|) (EQ (CAR |cond|) '|and|)
                  (PROGN (SETQ |conds| (CDR |cond|)) #1#)))
            ((LAMBDA (|bfVar#64| |bfVar#63| |c|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#63|)
                      (PROGN (SETQ |c| (CAR |bfVar#63|)) NIL))
                  (RETURN |bfVar#64|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#64| (|matchMmCond| |c|))
                   (COND ((NOT |bfVar#64|) (RETURN NIL))))))
                (SETQ |bfVar#63| (CDR |bfVar#63|))))
             T |conds| NIL))
           ((OR
             (AND (CONSP |cond|) (EQ (CAR |cond|) 'OR)
                  (PROGN (SETQ |conds| (CDR |cond|)) #1#))
             (AND (CONSP |cond|) (EQ (CAR |cond|) '|or|)
                  (PROGN (SETQ |conds| (CDR |cond|)) #1#)))
            ((LAMBDA (|bfVar#66| |bfVar#65| |c|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#65|)
                      (PROGN (SETQ |c| (CAR |bfVar#65|)) NIL))
                  (RETURN |bfVar#66|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#66| (|matchMmCond| |c|))
                   (COND (|bfVar#66| (RETURN |bfVar#66|))))))
                (SETQ |bfVar#65| (CDR |bfVar#65|))))
             NIL |conds| NIL))
           ((AND (CONSP |cond|) (EQ (CAR |cond|) '|has|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |cond|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |dom| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |x| (CAR |ISTMP#2|)) #1#))))))
            (NOT (EQ (|hasCaty| |dom| |x| NIL) '|failed|)))
           ((AND (CONSP |cond|) (EQ (CAR |cond|) '|not|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |cond|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |cond1| (CAR |ISTMP#1|)) #1#))))
            (NULL (|matchMmCond| |cond1|)))
           (#1#
            (|keyedSystemError| 'S2GE0016
             (LIST "matchMmCond" "unknown form of condition")))))))))

; matchMmSig(mm, tar, args1, args2, rtcp) ==
;   -- matches the modemap signature against  args1 -> tar
;   -- if necessary, runtime checks are created for subdomains
;   -- then the modemap condition is evaluated
;   [sig,:.]:= mm
;   if CONTAINED('_#, sig) then
;     sig := [replaceSharpCalls COPY t for t in sig]
;   null args1 => matchMmSigTar(tar, first sig)
;   a := rest sig
;   arg:= NIL
;   for i in 1.. while args1 and args2 and a until not b repeat
;     x1 := first args1
;     args1 := rest args1
;     x2 := first args2
;     args2 := rest args2
;     x := first a
;     a := rest a
;     rtc:= NIL
;     if x is ['SubDomain,y,:.] then x:= y
;     b := isEqualOrSubDomain(x1,x) or
;       (STRINGP(x) and (x1 is ['Variable,v]) and (x = PNAME v)) or
;         $SubDom and isSubDomain(x,x1) => rtc:= 'T
;         $Coerce => x2=x or canCoerceFrom(x1,x)
;         x1 is ['Variable,:.] and x = '(Symbol)
;     RPLACA(rtcp, CONS(rtc, CAR(rtcp)))
;   null args1 and null a and b and matchMmSigTar(tar, first sig)

(DEFUN |matchMmSig| (|mm| |tar| |args1| |args2| |rtcp|)
  (PROG (|sig| |a| |arg| |x1| |x2| |x| |rtc| |ISTMP#1| |y| |v| |b|)
    (RETURN
     (PROGN
      (SETQ |sig| (CAR |mm|))
      (COND
       ((CONTAINED '|#| |sig|)
        (SETQ |sig|
                ((LAMBDA (|bfVar#68| |bfVar#67| |t|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#67|)
                          (PROGN (SETQ |t| (CAR |bfVar#67|)) NIL))
                      (RETURN (NREVERSE |bfVar#68|)))
                     (#1='T
                      (SETQ |bfVar#68|
                              (CONS (|replaceSharpCalls| (COPY |t|))
                                    |bfVar#68|))))
                    (SETQ |bfVar#67| (CDR |bfVar#67|))))
                 NIL |sig| NIL))))
      (COND ((NULL |args1|) (|matchMmSigTar| |tar| (CAR |sig|)))
            (#1#
             (PROGN
              (SETQ |a| (CDR |sig|))
              (SETQ |arg| NIL)
              ((LAMBDA (|i| |bfVar#69|)
                 (LOOP
                  (COND
                   ((OR (NOT (AND |args1| |args2| |a|)) |bfVar#69|)
                    (RETURN NIL))
                   (#1#
                    (PROGN
                     (SETQ |x1| (CAR |args1|))
                     (SETQ |args1| (CDR |args1|))
                     (SETQ |x2| (CAR |args2|))
                     (SETQ |args2| (CDR |args2|))
                     (SETQ |x| (CAR |a|))
                     (SETQ |a| (CDR |a|))
                     (SETQ |rtc| NIL)
                     (COND
                      ((AND (CONSP |x|) (EQ (CAR |x|) '|SubDomain|)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |x|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
                       (SETQ |x| |y|)))
                     (SETQ |b|
                             (OR (|isEqualOrSubDomain| |x1| |x|)
                                 (AND (STRINGP |x|) (CONSP |x1|)
                                      (EQ (CAR |x1|) '|Variable|)
                                      (PROGN
                                       (SETQ |ISTMP#1| (CDR |x1|))
                                       (AND (CONSP |ISTMP#1|)
                                            (EQ (CDR |ISTMP#1|) NIL)
                                            (PROGN
                                             (SETQ |v| (CAR |ISTMP#1|))
                                             #1#)))
                                      (EQUAL |x| (PNAME |v|)))
                                 (COND
                                  ((AND |$SubDom| (|isSubDomain| |x| |x1|))
                                   (SETQ |rtc| 'T))
                                  (|$Coerce|
                                   (OR (EQUAL |x2| |x|)
                                       (|canCoerceFrom| |x1| |x|)))
                                  (#1#
                                   (AND (CONSP |x1|)
                                        (EQ (CAR |x1|) '|Variable|)
                                        (EQUAL |x| '(|Symbol|)))))))
                     (RPLACA |rtcp| (CONS |rtc| (CAR |rtcp|))))))
                  (SETQ |i| (+ |i| 1))
                  (SETQ |bfVar#69| (NULL |b|))))
               1 NIL)
              (AND (NULL |args1|) (NULL |a|) |b|
                   (|matchMmSigTar| |tar| (CAR |sig|))))))))))

; matchMmSigTar(t1,t2) ==
;   -- t1 is a target type specified by :: or by a declared variable
;   -- t2 is the target of a modemap signature
;   null t1 or
;     isEqualOrSubDomain(t2,t1) => true
;     if t2 is ['Union,a,b] then
;       if a='"failed" then return matchMmSigTar(t1, b)
;       if b='"failed" then return matchMmSigTar(t1, a)
;     $Coerce and
;       isPartialMode t1 => resolveTM(t2,t1)
; -- I think this should be true  -SCM
; --    true
;       canCoerceFrom(t2,t1)

(DEFUN |matchMmSigTar| (|t1| |t2|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (OR (NULL |t1|)
         (COND ((|isEqualOrSubDomain| |t2| |t1|) T)
               (#1='T
                (PROGN
                 (COND
                  ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Union|)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |t2|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |a| (CAR |ISTMP#1|))
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                    (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
                   (COND
                    ((EQUAL |a| "failed") (RETURN (|matchMmSigTar| |t1| |b|))))
                   (COND
                    ((EQUAL |b| "failed")
                     (RETURN (|matchMmSigTar| |t1| |a|))))))
                 (AND |$Coerce|
                      (COND ((|isPartialMode| |t1|) (|resolveTM| |t2| |t1|))
                            (#1# (|canCoerceFrom| |t2| |t1|)))))))))))

; constructSubst(d) ==
;   -- constructs a substitution which substitutes d for $
;   -- and the arguments of d for #1, #2 ..
;   SL:= list CONS('$,d)
;   for x in rest d for v in $FormalMapVariableList repeat
;     SL:= CONS(CONS(v,x),SL)
;   SL

(DEFUN |constructSubst| (|d|)
  (PROG (SL)
    (RETURN
     (PROGN
      (SETQ SL (LIST (CONS '$ |d|)))
      ((LAMBDA (|bfVar#70| |x| |bfVar#71| |v|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#70|) (PROGN (SETQ |x| (CAR |bfVar#70|)) NIL)
                (ATOM |bfVar#71|) (PROGN (SETQ |v| (CAR |bfVar#71|)) NIL))
            (RETURN NIL))
           ('T (SETQ SL (CONS (CONS |v| |x|) SL))))
          (SETQ |bfVar#70| (CDR |bfVar#70|))
          (SETQ |bfVar#71| (CDR |bfVar#71|))))
       (CDR |d|) NIL |$FormalMapVariableList| NIL)
      SL))))

; filterModemapsFromPackages(mms, names, op) ==
;   -- mms is a list of modemaps
;   -- names is a list of domain constructors
;   -- this returns a 2-list containing those modemaps that have one
;   -- of the names in the package source of the modemap and all the
;   -- rest of the modemaps in the second element.
;   good := NIL
;   bad  := NIL
;   for mm in mms repeat
;     isFreeFunctionFromMm(mm) => bad := cons(mm, bad)
;     type := getDomainFromMm mm
;     null type => bad := cons(mm,bad)
;     if PAIRP type then type := first type
;     GETDATABASE(type,'CONSTRUCTORKIND) = 'category => bad := cons(mm,bad)
;     name := object2String type
;     found := nil
;     for n in names while not found repeat
;       STRPOS(n,name,0,NIL) => found := true
;     if found
;       then good := cons(mm, good)
;       else bad := cons(mm,bad)
;   [good,bad]

(DEFUN |filterModemapsFromPackages| (|mms| |names| |op|)
  (PROG (|good| |bad| |type| |name| |found|)
    (RETURN
     (PROGN
      (SETQ |good| NIL)
      (SETQ |bad| NIL)
      ((LAMBDA (|bfVar#72| |mm|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#72|) (PROGN (SETQ |mm| (CAR |bfVar#72|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((|isFreeFunctionFromMm| |mm|) (SETQ |bad| (CONS |mm| |bad|)))
             (#1#
              (PROGN
               (SETQ |type| (|getDomainFromMm| |mm|))
               (COND ((NULL |type|) (SETQ |bad| (CONS |mm| |bad|)))
                     (#1#
                      (PROGN
                       (COND ((CONSP |type|) (SETQ |type| (CAR |type|))))
                       (COND
                        ((EQ (GETDATABASE |type| 'CONSTRUCTORKIND) '|category|)
                         (SETQ |bad| (CONS |mm| |bad|)))
                        (#1#
                         (PROGN
                          (SETQ |name| (|object2String| |type|))
                          (SETQ |found| NIL)
                          ((LAMBDA (|bfVar#73| |n|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#73|)
                                    (PROGN (SETQ |n| (CAR |bfVar#73|)) NIL)
                                    |found|)
                                (RETURN NIL))
                               (#1#
                                (COND
                                 ((STRPOS |n| |name| 0 NIL)
                                  (IDENTITY (SETQ |found| T))))))
                              (SETQ |bfVar#73| (CDR |bfVar#73|))))
                           |names| NIL)
                          (COND (|found| (SETQ |good| (CONS |mm| |good|)))
                                (#1#
                                 (SETQ |bad| (CONS |mm| |bad|)))))))))))))))
          (SETQ |bfVar#72| (CDR |bfVar#72|))))
       |mms| NIL)
      (LIST |good| |bad|)))))

; isTowerWithSubdomain(towerType,elem) ==
;   not PAIRP towerType => NIL
;   dt := deconstructT towerType
;   2 ~= #dt => NIL
;   s := underDomainOf(towerType)
;   s = elem => towerType
;   isEqualOrSubDomain(s,elem) and constructM(first dt,[elem])

(DEFUN |isTowerWithSubdomain| (|towerType| |elem|)
  (PROG (|dt| |s|)
    (RETURN
     (COND ((NULL (CONSP |towerType|)) NIL)
           (#1='T
            (PROGN
             (SETQ |dt| (|deconstructT| |towerType|))
             (COND ((NOT (EQL 2 (LENGTH |dt|))) NIL)
                   (#1#
                    (PROGN
                     (SETQ |s| (|underDomainOf| |towerType|))
                     (COND ((EQUAL |s| |elem|) |towerType|)
                           (#1#
                            (AND (|isEqualOrSubDomain| |s| |elem|)
                                 (|constructM| (CAR |dt|)
                                  (LIST |elem|))))))))))))))

; exact?(mmS, tar, args) ==
;     ex := inex := NIL
;     for (mm := [sig, [mmC, :.], :.]) in mmS repeat
;         [c, t, :a] := sig
;         ok := true
;         for pat in a for arg in args while ok repeat
;             not CONTAINED(['isDomain, pat, arg], mmC) => ok := NIL
;         ok => ex := CONS(mm, ex)
;         inex := CONS(mm, inex)
;     [ex, inex]

(DEFUN |exact?| (|mmS| |tar| |args|)
  (PROG (|inex| |ex| |sig| |ISTMP#1| |ISTMP#2| |mmC| |c| |t| |a| |ok|)
    (RETURN
     (PROGN
      (SETQ |ex| (SETQ |inex| NIL))
      ((LAMBDA (|bfVar#74| |mm|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#74|) (PROGN (SETQ |mm| (CAR |bfVar#74|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |mm|)
                 (PROGN
                  (SETQ |sig| (CAR |mm|))
                  (SETQ |ISTMP#1| (CDR |mm|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN (SETQ |mmC| (CAR |ISTMP#2|)) #1#)))))
                 (PROGN
                  (SETQ |c| (CAR |sig|))
                  (SETQ |t| (CADR . #2=(|sig|)))
                  (SETQ |a| (CDDR . #2#))
                  (SETQ |ok| T)
                  ((LAMBDA (|bfVar#75| |pat| |bfVar#76| |arg|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#75|)
                            (PROGN (SETQ |pat| (CAR |bfVar#75|)) NIL)
                            (ATOM |bfVar#76|)
                            (PROGN (SETQ |arg| (CAR |bfVar#76|)) NIL)
                            (NOT |ok|))
                        (RETURN NIL))
                       (#1#
                        (COND
                         ((NULL
                           (CONTAINED (LIST '|isDomain| |pat| |arg|) |mmC|))
                          (IDENTITY (SETQ |ok| NIL))))))
                      (SETQ |bfVar#75| (CDR |bfVar#75|))
                      (SETQ |bfVar#76| (CDR |bfVar#76|))))
                   |a| NIL |args| NIL)
                  (COND (|ok| (SETQ |ex| (CONS |mm| |ex|)))
                        (#1# (SETQ |inex| (CONS |mm| |inex|))))))))
          (SETQ |bfVar#74| (CDR |bfVar#74|))))
       |mmS| NIL)
      (LIST |ex| |inex|)))))

; matchMms(mmaps, op, tar, args1, args2) ==
;     mmS := NIL
;     for [sig, mmC] in mmaps repeat
;         -- sig is [dc, result, :args]
;         [c, t, :a] := sig
;         $Subst :=
;             tar and not isPartialMode tar =>
;                 -- throw in the target if it is not the same as one
;                 -- of the arguments
;                 member(t, a) => NIL
;                 [[t, :tar]]
;             NIL
;         if a then matchTypes(a, args1, args2)
;         not EQ($Subst, 'failed) =>
;             mmS := nconc(evalMm(op, tar, sig, mmC), mmS)
;     mmS

(DEFUN |matchMms| (|mmaps| |op| |tar| |args1| |args2|)
  (PROG (|mmS| |sig| |ISTMP#1| |mmC| |c| |t| |a|)
    (RETURN
     (PROGN
      (SETQ |mmS| NIL)
      ((LAMBDA (|bfVar#78| |bfVar#77|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#78|)
                (PROGN (SETQ |bfVar#77| (CAR |bfVar#78|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#77|)
                 (PROGN
                  (SETQ |sig| (CAR |bfVar#77|))
                  (SETQ |ISTMP#1| (CDR |bfVar#77|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |mmC| (CAR |ISTMP#1|)) #1#)))
                 (PROGN
                  (SETQ |c| (CAR |sig|))
                  (SETQ |t| (CADR . #2=(|sig|)))
                  (SETQ |a| (CDDR . #2#))
                  (SETQ |$Subst|
                          (COND
                           ((AND |tar| (NULL (|isPartialMode| |tar|)))
                            (COND ((|member| |t| |a|) NIL)
                                  (#1# (LIST (CONS |t| |tar|)))))
                           (#1# NIL)))
                  (COND (|a| (|matchTypes| |a| |args1| |args2|)))
                  (COND
                   ((NULL (EQ |$Subst| '|failed|))
                    (SETQ |mmS|
                            (NCONC (|evalMm| |op| |tar| |sig| |mmC|)
                                   |mmS|))))))))
          (SETQ |bfVar#78| (CDR |bfVar#78|))))
       |mmaps| NIL)
      |mmS|))))

; selectMmsGen(op,tar,args1,args2) ==
;   -- general modemap evaluation of op with argument types args1
;   -- evaluates the condition and looks for the slot number
;   -- returns all functions which are applicable
;   -- args2 is a list of polynomial types for symbols
;   $Subst: local := NIL
;   $SymbolType: local := NIL
;
;   null (S := getModemapsFromDatabase(op, LENGTH args1)) => NIL
;
;   if (op = 'map) and (2 = #args1) and
;     (first(args1) is ['Mapping, ., elem]) and
;       (a := isTowerWithSubdomain(CADR args1,elem))
;         then args1 := [first args1, a]
;
;   -- we first split the modemaps into two groups:
;   --   haves:    these are from packages that have one of the top level
;   --             constructor names in the package name
;   --   havenots: everything else
;
;   -- get top level constructor names for constructors with parameters
;   conNames := nil
;   if op = 'reshape then args := APPEND(rest args1, rest args2)
;   else args := APPEND(args1,args2)
;   if tar then args := [tar,:args]
;   -- for common aggregates, use under domain also
;   for a in REMDUP args repeat
;     a =>
;       atom a => nil
;       fa := QCAR a
;       fa in '(Record Union) => NIL
;       conNames := insert(STRINGIMAGE fa, conNames)
;
;   if conNames
;     then [haves,havenots] := filterModemapsFromPackages(S,conNames,op)
;     else
;       haves := NIL
;       havenots := S
;
;   mmS := NIL
;
;   if $reportBottomUpFlag then
;     sayMSG ['%l,:bright '"Modemaps from Associated Packages"]
;
;   if haves then
;     [havesExact, havesInexact] := exact?(haves, tar, args1)
;     if $reportBottomUpFlag then
;       for mm in APPEND(havesExact,havesInexact) for i in 1.. repeat
;         sayModemapWithNumber(mm,i)
;     if havesExact then
;       mmS := matchMms(havesExact, op, tar, args1, args2)
;       if mmS then
;         if $reportBottomUpFlag then
;           sayMSG '"   found an exact match!"
;         return mmS
;     mmS := matchMms(havesInexact,op,tar,args1,args2)
;   else if $reportBottomUpFlag then sayMSG '"   no modemaps"
;   mmS => mmS
;
;   if $reportBottomUpFlag then
;     sayMSG ['%l,:bright '"Remaining General Modemaps"]
;   --  for mm in havenots for i in 1.. repeat sayModemapWithNumber(mm,i)
;
;   if havenots then
;     [havesNExact,havesNInexact] := exact?(havenots,tar,args1)
;     if $reportBottomUpFlag then
;       for mm in APPEND(havesNExact,havesNInexact) for i in 1.. repeat
;         sayModemapWithNumber(mm,i)
;     if havesNExact then
;       mmS := matchMms(havesNExact,op,tar,args1,args2)
;       if mmS then
;         if $reportBottomUpFlag then
;           sayMSG '"   found an exact match!"
;         return mmS
;     mmS := matchMms(havesNInexact,op,tar,args1,args2)
;   else if $reportBottomUpFlag then sayMSG '"   no modemaps"
;   mmS

(DEFUN |selectMmsGen| (|op| |tar| |args1| |args2|)
  (PROG (|$SymbolType| |$Subst| |havesNInexact| |havesNExact| |havesInexact|
         |havesExact| |mmS| |havenots| |haves| |LETTMP#1| |fa| |args|
         |conNames| |a| |elem| |ISTMP#3| |ISTMP#2| |ISTMP#1| S)
    (DECLARE (SPECIAL |$SymbolType| |$Subst|))
    (RETURN
     (PROGN
      (SETQ |$Subst| NIL)
      (SETQ |$SymbolType| NIL)
      (COND
       ((NULL (SETQ S (|getModemapsFromDatabase| |op| (LENGTH |args1|)))) NIL)
       (#1='T
        (PROGN
         (COND
          ((AND (EQ |op| '|map|) (EQL 2 (LENGTH |args1|))
                (PROGN
                 (SETQ |ISTMP#1| (CAR |args1|))
                 (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
                      (PROGN
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|)
                            (PROGN
                             (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                             (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                  (PROGN
                                   (SETQ |elem| (CAR |ISTMP#3|))
                                   #1#)))))))
                (SETQ |a| (|isTowerWithSubdomain| (CADR |args1|) |elem|)))
           (SETQ |args1| (LIST (CAR |args1|) |a|))))
         (SETQ |conNames| NIL)
         (COND
          ((EQ |op| '|reshape|)
           (SETQ |args| (APPEND (CDR |args1|) (CDR |args2|))))
          (#1# (SETQ |args| (APPEND |args1| |args2|))))
         (COND (|tar| (SETQ |args| (CONS |tar| |args|))))
         ((LAMBDA (|bfVar#79| |a|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#79|) (PROGN (SETQ |a| (CAR |bfVar#79|)) NIL))
               (RETURN NIL))
              (#1#
               (COND
                (|a|
                 (IDENTITY
                  (COND ((ATOM |a|) NIL)
                        (#1#
                         (PROGN
                          (SETQ |fa| (QCAR |a|))
                          (COND ((|member| |fa| '(|Record| |Union|)) NIL)
                                (#1#
                                 (SETQ |conNames|
                                         (|insert| (STRINGIMAGE |fa|)
                                          |conNames|))))))))))))
             (SETQ |bfVar#79| (CDR |bfVar#79|))))
          (REMDUP |args|) NIL)
         (COND
          (|conNames|
           (SETQ |LETTMP#1| (|filterModemapsFromPackages| S |conNames| |op|))
           (SETQ |haves| (CAR |LETTMP#1|)) (SETQ |havenots| (CADR |LETTMP#1|))
           |LETTMP#1|)
          (#1# (SETQ |haves| NIL) (SETQ |havenots| S)))
         (SETQ |mmS| NIL)
         (COND
          (|$reportBottomUpFlag|
           (|sayMSG|
            (CONS '|%l| (|bright| "Modemaps from Associated Packages")))))
         (COND
          (|haves| (SETQ |LETTMP#1| (|exact?| |haves| |tar| |args1|))
           (SETQ |havesExact| (CAR |LETTMP#1|))
           (SETQ |havesInexact| (CADR |LETTMP#1|))
           (COND
            (|$reportBottomUpFlag|
             ((LAMBDA (|bfVar#80| |mm| |i|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#80|)
                       (PROGN (SETQ |mm| (CAR |bfVar#80|)) NIL))
                   (RETURN NIL))
                  (#1# (|sayModemapWithNumber| |mm| |i|)))
                 (SETQ |bfVar#80| (CDR |bfVar#80|))
                 (SETQ |i| (+ |i| 1))))
              (APPEND |havesExact| |havesInexact|) NIL 1)))
           (COND
            (|havesExact|
             (SETQ |mmS| (|matchMms| |havesExact| |op| |tar| |args1| |args2|))
             (COND
              (|mmS|
               (COND
                (|$reportBottomUpFlag| (|sayMSG| "   found an exact match!")))
               (RETURN |mmS|)))))
           (SETQ |mmS| (|matchMms| |havesInexact| |op| |tar| |args1| |args2|)))
          (|$reportBottomUpFlag| (|sayMSG| "   no modemaps")))
         (COND (|mmS| |mmS|)
               (#1#
                (PROGN
                 (COND
                  (|$reportBottomUpFlag|
                   (|sayMSG|
                    (CONS '|%l| (|bright| "Remaining General Modemaps")))))
                 (COND
                  (|havenots|
                   (SETQ |LETTMP#1| (|exact?| |havenots| |tar| |args1|))
                   (SETQ |havesNExact| (CAR |LETTMP#1|))
                   (SETQ |havesNInexact| (CADR |LETTMP#1|))
                   (COND
                    (|$reportBottomUpFlag|
                     ((LAMBDA (|bfVar#81| |mm| |i|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#81|)
                               (PROGN (SETQ |mm| (CAR |bfVar#81|)) NIL))
                           (RETURN NIL))
                          (#1# (|sayModemapWithNumber| |mm| |i|)))
                         (SETQ |bfVar#81| (CDR |bfVar#81|))
                         (SETQ |i| (+ |i| 1))))
                      (APPEND |havesNExact| |havesNInexact|) NIL 1)))
                   (COND
                    (|havesNExact|
                     (SETQ |mmS|
                             (|matchMms| |havesNExact| |op| |tar| |args1|
                              |args2|))
                     (COND
                      (|mmS|
                       (COND
                        (|$reportBottomUpFlag|
                         (|sayMSG| "   found an exact match!")))
                       (RETURN |mmS|)))))
                   (SETQ |mmS|
                           (|matchMms| |havesNInexact| |op| |tar| |args1|
                            |args2|)))
                  (|$reportBottomUpFlag| (|sayMSG| "   no modemaps")))
                 |mmS|))))))))))

; matchTypes(pm,args1,args2) ==
;   -- pm is a list of pattern variables, args1 a list of argument types,
;   --   args2 a list of polynomial types for symbols
;   -- the result is a match from pm to args, if one exists
;   for v in pm for t1 in args1 for t2 in args2 until $Subst='failed repeat
;     p:= ASSQ(v,$Subst) =>
;       t := rest p
;       t=t1 => $Coerce and EQCAR(t1,'Symbol) and
;         (q := ASSQ(v,$SymbolType)) and t2 and
;           (t3 := resolveTT(rest q, t2)) and
;             RPLACD(q, t3)
;       $Coerce =>
;         if EQCAR(t,'Symbol) and (q := ASSQ(v,$SymbolType)) then
;           t := rest q
;         if EQCAR(t1,'Symbol) and t2 then t1:= t2
;         t0 := resolveTT(t,t1) => RPLACD(p,t0)
;         $Subst:= 'failed
;       $Subst:= 'failed
;     $Subst:= CONS(CONS(v,t1),$Subst)
;     if EQCAR(t1,'Symbol) and t2 then $SymbolType:= CONS(CONS(v,t2),$SymbolType)

(DEFUN |matchTypes| (|pm| |args1| |args2|)
  (PROG (|p| |t| |q| |t3| |t0|)
    (RETURN
     ((LAMBDA (|bfVar#82| |v| |bfVar#83| |t1| |bfVar#84| |t2| |bfVar#85|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#82|) (PROGN (SETQ |v| (CAR |bfVar#82|)) NIL)
               (ATOM |bfVar#83|) (PROGN (SETQ |t1| (CAR |bfVar#83|)) NIL)
               (ATOM |bfVar#84|) (PROGN (SETQ |t2| (CAR |bfVar#84|)) NIL)
               |bfVar#85|)
           (RETURN NIL))
          (#1='T
           (COND
            ((SETQ |p| (ASSQ |v| |$Subst|))
             (PROGN
              (SETQ |t| (CDR |p|))
              (COND
               ((EQUAL |t| |t1|)
                (AND |$Coerce| (EQCAR |t1| '|Symbol|)
                     (SETQ |q| (ASSQ |v| |$SymbolType|)) |t2|
                     (SETQ |t3| (|resolveTT| (CDR |q|) |t2|))
                     (RPLACD |q| |t3|)))
               (|$Coerce|
                (PROGN
                 (COND
                  ((AND (EQCAR |t| '|Symbol|)
                        (SETQ |q| (ASSQ |v| |$SymbolType|)))
                   (SETQ |t| (CDR |q|))))
                 (COND ((AND (EQCAR |t1| '|Symbol|) |t2|) (SETQ |t1| |t2|)))
                 (COND ((SETQ |t0| (|resolveTT| |t| |t1|)) (RPLACD |p| |t0|))
                       (#1# (SETQ |$Subst| '|failed|)))))
               (#1# (SETQ |$Subst| '|failed|)))))
            (#1#
             (PROGN
              (SETQ |$Subst| (CONS (CONS |v| |t1|) |$Subst|))
              (COND
               ((AND (EQCAR |t1| '|Symbol|) |t2|)
                (SETQ |$SymbolType|
                        (CONS (CONS |v| |t2|) |$SymbolType|)))))))))
         (SETQ |bfVar#82| (CDR |bfVar#82|))
         (SETQ |bfVar#83| (CDR |bfVar#83|))
         (SETQ |bfVar#84| (CDR |bfVar#84|))
         (SETQ |bfVar#85| (EQ |$Subst| '|failed|))))
      |pm| NIL |args1| NIL |args2| NIL NIL))))

; evalMm(op,tar,sig,mmC) ==
;   -- evaluates a modemap with signature sig and condition mmC
;   -- the result is a list of lists [sig,slot,cond] or NIL
;   --if $Coerce is NIL, tar has to be the same as the computed target type
;   mS:= NIL
;   for st in evalMmStack mmC repeat
;     SL:= evalMmCond(op,sig,st)
;     not EQ(SL,'failed) =>
;       SL := fixUpTypeArgs SL
;       sig:= [subCopy(deepSubCopy(x,SL),$Subst) for x in sig]
;       not containsVars sig =>
;         isFreeFunctionFromMmCond mmC and (m := evalMmFreeFunction(op,tar,sig,mmC)) =>
;            mS:= nconc(m,mS)
;         "or"/[not isValidType(arg) for arg in sig] => nil
;         [dc,t,:args]:= sig
;         $Coerce or null tar or tar=t =>
;           mS:= nconc(findFunctionInDomain(op,dc,t,args,args,NIL,'T),mS)
;   mS

(DEFUN |evalMm| (|op| |tar| |sig| |mmC|)
  (PROG (|mS| SL |m| |dc| |t| |args|)
    (RETURN
     (PROGN
      (SETQ |mS| NIL)
      ((LAMBDA (|bfVar#86| |st|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#86|) (PROGN (SETQ |st| (CAR |bfVar#86|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ SL (|evalMmCond| |op| |sig| |st|))
             (COND
              ((NULL (EQ SL '|failed|))
               (PROGN
                (SETQ SL (|fixUpTypeArgs| SL))
                (SETQ |sig|
                        ((LAMBDA (|bfVar#88| |bfVar#87| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#87|)
                                  (PROGN (SETQ |x| (CAR |bfVar#87|)) NIL))
                              (RETURN (NREVERSE |bfVar#88|)))
                             (#1#
                              (SETQ |bfVar#88|
                                      (CONS
                                       (|subCopy| (|deepSubCopy| |x| SL)
                                        |$Subst|)
                                       |bfVar#88|))))
                            (SETQ |bfVar#87| (CDR |bfVar#87|))))
                         NIL |sig| NIL))
                (COND
                 ((NULL (|containsVars| |sig|))
                  (COND
                   ((AND (|isFreeFunctionFromMmCond| |mmC|)
                         (SETQ |m|
                                 (|evalMmFreeFunction| |op| |tar| |sig|
                                  |mmC|)))
                    (SETQ |mS| (NCONC |m| |mS|)))
                   (((LAMBDA (|bfVar#90| |bfVar#89| |arg|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#89|)
                              (PROGN (SETQ |arg| (CAR |bfVar#89|)) NIL))
                          (RETURN |bfVar#90|))
                         (#1#
                          (PROGN
                           (SETQ |bfVar#90| (NULL (|isValidType| |arg|)))
                           (COND (|bfVar#90| (RETURN |bfVar#90|))))))
                        (SETQ |bfVar#89| (CDR |bfVar#89|))))
                     NIL |sig| NIL)
                    NIL)
                   (#1#
                    (PROGN
                     (SETQ |dc| (CAR |sig|))
                     (SETQ |t| (CADR . #2=(|sig|)))
                     (SETQ |args| (CDDR . #2#))
                     (COND
                      ((OR |$Coerce| (NULL |tar|) (EQUAL |tar| |t|))
                       (SETQ |mS|
                               (NCONC
                                (|findFunctionInDomain| |op| |dc| |t| |args|
                                 |args| NIL 'T)
                                |mS|)))))))))))))))
          (SETQ |bfVar#86| (CDR |bfVar#86|))))
       (|evalMmStack| |mmC|) NIL)
      |mS|))))

; evalMmFreeFunction(op,tar,sig,mmC) ==
;   [dc,t,:args]:= sig
;   $Coerce or null tar or tar=t =>
;      nilArgs := nil
;      for a in args repeat nilArgs := [NIL,:nilArgs]
;      [[[["__FreeFunction__",:dc],t,:args], [t, :args], nilArgs]]
;   nil

(DEFUN |evalMmFreeFunction| (|op| |tar| |sig| |mmC|)
  (PROG (|dc| |t| |args| |nilArgs|)
    (RETURN
     (PROGN
      (SETQ |dc| (CAR |sig|))
      (SETQ |t| (CADR . #1=(|sig|)))
      (SETQ |args| (CDDR . #1#))
      (COND
       ((OR |$Coerce| (NULL |tar|) (EQUAL |tar| |t|))
        (PROGN
         (SETQ |nilArgs| NIL)
         ((LAMBDA (|bfVar#91| |a|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#91|) (PROGN (SETQ |a| (CAR |bfVar#91|)) NIL))
               (RETURN NIL))
              (#2='T (SETQ |nilArgs| (CONS NIL |nilArgs|))))
             (SETQ |bfVar#91| (CDR |bfVar#91|))))
          |args| NIL)
         (LIST
          (LIST (CONS (CONS '|_FreeFunction_| |dc|) (CONS |t| |args|))
                (CONS |t| |args|) |nilArgs|))))
       (#2# NIL))))))

; evalMmStack(mmC) ==
;   -- translates the modemap condition mmC into a list of stacks
;   mmC is ['AND,:a] =>
;     ["NCONC"/[evalMmStackInner cond for cond in a]]
;   mmC is ['OR,:args] => [:evalMmStack a for a in args]
;   mmC is ['partial,:mmD] => evalMmStack mmD
;   mmC is ['ofCategory,pvar,cat] and cat is ['Join,:args] =>
;     evalMmStack CONS('AND,[['ofCategory,pvar,c] for c in args])
;   mmC is ['ofType,:.] => [NIL]
;   mmC is ['has,pat,x] =>
;     x = 'ATTRIBUTE => BREAK()
;     x = 'SIGNATURE =>
;       [[['ofCategory,pat,['CATEGORY,'unknown,x]]]]
;     [['ofCategory,pat,x]]
;   [[mmC]]

(DEFUN |evalMmStack| (|mmC|)
  (PROG (|a| |args| |mmD| |ISTMP#1| |pvar| |ISTMP#2| |cat| |pat| |x|)
    (RETURN
     (COND
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) 'AND)
            (PROGN (SETQ |a| (CDR |mmC|)) #1='T))
       (LIST
        ((LAMBDA (|bfVar#93| |bfVar#92| |cond|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#92|) (PROGN (SETQ |cond| (CAR |bfVar#92|)) NIL))
              (RETURN |bfVar#93|))
             (#1#
              (SETQ |bfVar#93|
                      (NCONC |bfVar#93| (|evalMmStackInner| |cond|)))))
            (SETQ |bfVar#92| (CDR |bfVar#92|))))
         NIL |a| NIL)))
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) 'OR)
            (PROGN (SETQ |args| (CDR |mmC|)) #1#))
       ((LAMBDA (|bfVar#95| |bfVar#94| |a|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#94|) (PROGN (SETQ |a| (CAR |bfVar#94|)) NIL))
             (RETURN (NREVERSE |bfVar#95|)))
            (#1#
             (SETQ |bfVar#95|
                     (APPEND (REVERSE (|evalMmStack| |a|)) |bfVar#95|))))
           (SETQ |bfVar#94| (CDR |bfVar#94|))))
        NIL |args| NIL))
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|partial|)
            (PROGN (SETQ |mmD| (CDR |mmC|)) #1#))
       (|evalMmStack| |mmD|))
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|ofCategory|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |mmC|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |pvar| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |cat| (CAR |ISTMP#2|)) #1#)))))
            (CONSP |cat|) (EQ (CAR |cat|) '|Join|)
            (PROGN (SETQ |args| (CDR |cat|)) #1#))
       (|evalMmStack|
        (CONS 'AND
              ((LAMBDA (|bfVar#97| |bfVar#96| |c|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#96|)
                        (PROGN (SETQ |c| (CAR |bfVar#96|)) NIL))
                    (RETURN (NREVERSE |bfVar#97|)))
                   (#1#
                    (SETQ |bfVar#97|
                            (CONS (LIST '|ofCategory| |pvar| |c|)
                                  |bfVar#97|))))
                  (SETQ |bfVar#96| (CDR |bfVar#96|))))
               NIL |args| NIL))))
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|ofType|)) (LIST NIL))
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|has|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |mmC|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |pat| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |x| (CAR |ISTMP#2|)) #1#))))))
       (COND ((EQ |x| 'ATTRIBUTE) (BREAK))
             ((EQ |x| 'SIGNATURE)
              (LIST
               (LIST
                (LIST '|ofCategory| |pat| (LIST 'CATEGORY '|unknown| |x|)))))
             (#1# (LIST (LIST '|ofCategory| |pat| |x|)))))
      (#1# (LIST (LIST |mmC|)))))))

; evalMmStackInner(mmC) ==
;   mmC is ['OR,:args] =>
;     keyedSystemError("S2GE0016",
;       ['"evalMmStackInner",'"OR condition nested inside an AND"])
;   mmC is ['partial,:mmD] => evalMmStackInner mmD
;   mmC is ['ofCategory,pvar,cat] and cat is ['Join,:args] =>
;     [['ofCategory, pvar, c] for c in args]
;   mmC is ['ofType,:.] => NIL
;   mmC is ['isAsConstant] => NIL
;   mmC is ['has,pat,x] =>
;     x = 'ATTRIBUTE => BREAK()
;     x = 'SIGNATURE =>
;       [['ofCategory,pat,['CATEGORY,'unknown,x]]]
;     [['ofCategory,pat,x]]
;   [mmC]

(DEFUN |evalMmStackInner| (|mmC|)
  (PROG (|args| |mmD| |ISTMP#1| |pvar| |ISTMP#2| |cat| |pat| |x|)
    (RETURN
     (COND
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) 'OR)
            (PROGN (SETQ |args| (CDR |mmC|)) #1='T))
       (|keyedSystemError| 'S2GE0016
        (LIST "evalMmStackInner" "OR condition nested inside an AND")))
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|partial|)
            (PROGN (SETQ |mmD| (CDR |mmC|)) #1#))
       (|evalMmStackInner| |mmD|))
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|ofCategory|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |mmC|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |pvar| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |cat| (CAR |ISTMP#2|)) #1#)))))
            (CONSP |cat|) (EQ (CAR |cat|) '|Join|)
            (PROGN (SETQ |args| (CDR |cat|)) #1#))
       ((LAMBDA (|bfVar#99| |bfVar#98| |c|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#98|) (PROGN (SETQ |c| (CAR |bfVar#98|)) NIL))
             (RETURN (NREVERSE |bfVar#99|)))
            (#1#
             (SETQ |bfVar#99|
                     (CONS (LIST '|ofCategory| |pvar| |c|) |bfVar#99|))))
           (SETQ |bfVar#98| (CDR |bfVar#98|))))
        NIL |args| NIL))
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|ofType|)) NIL)
      ((AND (CONSP |mmC|) (EQ (CDR |mmC|) NIL)
            (EQ (CAR |mmC|) '|isAsConstant|))
       NIL)
      ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|has|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |mmC|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |pat| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |x| (CAR |ISTMP#2|)) #1#))))))
       (COND ((EQ |x| 'ATTRIBUTE) (BREAK))
             ((EQ |x| 'SIGNATURE)
              (LIST
               (LIST '|ofCategory| |pat| (LIST 'CATEGORY '|unknown| |x|))))
             (#1# (LIST (LIST '|ofCategory| |pat| |x|)))))
      (#1# (LIST |mmC|))))))

; evalMmCond(op,sig,st) ==
;   $insideEvalMmCondIfTrue : local := true
;   evalMmCond0(op,sig,st)

(DEFUN |evalMmCond| (|op| |sig| |st|)
  (PROG (|$insideEvalMmCondIfTrue|)
    (DECLARE (SPECIAL |$insideEvalMmCondIfTrue|))
    (RETURN
     (PROGN
      (SETQ |$insideEvalMmCondIfTrue| T)
      (|evalMmCond0| |op| |sig| |st|)))))

; evalMmCond0(op,sig,st) ==
;   -- evaluates the nonempty list of modemap conditions st
;   -- the result is either 'failed or a substitution list
;   SL:= evalMmDom st
;   SL='failed => 'failed
;   for p in SL until p1 and not b repeat b:=
;     p1 := ASSQ(first p, $Subst)
;     p1 and
;       t1 := rest p1
;       t := rest p
;       t=t1 or
;         containsVars t =>
;           if $Coerce and EQCAR(t1, 'Symbol) then t1 := getSymbolType first p
;           resolveTM1(t1,t)
;         $Coerce and
;           -- if we are looking at the result of a function, the coerce
;           -- goes the opposite direction
;           (t1 = $AnonymousFunction and t is ['Mapping, :.]) => t
;           first p = CADR sig and not member(first p, CDDR sig) =>
;             canCoerceFrom(t,t1) => 'T
;             NIL
;           canCoerceFrom(t1,t) => 'T
;           isSubDomain(t,t1) => RPLACD(p,t1)
;           EQCAR(t1, 'Symbol) and canCoerceFrom(getSymbolType first p, t)
;   ( SL and p1 and not b and 'failed ) or evalMmCat(op,sig,st,SL)

(DEFUN |evalMmCond0| (|op| |sig| |st|)
  (PROG (SL |p1| |t1| |t| |b|)
    (RETURN
     (PROGN
      (SETQ SL (|evalMmDom| |st|))
      (COND ((EQ SL '|failed|) '|failed|)
            (#1='T
             (PROGN
              ((LAMBDA (|bfVar#100| |p| |bfVar#101|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#100|)
                        (PROGN (SETQ |p| (CAR |bfVar#100|)) NIL) |bfVar#101|)
                    (RETURN NIL))
                   (#1#
                    (SETQ |b|
                            (PROGN
                             (SETQ |p1| (ASSQ (CAR |p|) |$Subst|))
                             (AND |p1|
                                  (PROGN
                                   (SETQ |t1| (CDR |p1|))
                                   (SETQ |t| (CDR |p|))
                                   (OR (EQUAL |t| |t1|)
                                       (COND
                                        ((|containsVars| |t|)
                                         (PROGN
                                          (COND
                                           ((AND |$Coerce|
                                                 (EQCAR |t1| '|Symbol|))
                                            (SETQ |t1|
                                                    (|getSymbolType|
                                                     (CAR |p|)))))
                                          (|resolveTM1| |t1| |t|)))
                                        (#1#
                                         (AND |$Coerce|
                                              (COND
                                               ((AND
                                                 (EQUAL |t1|
                                                        |$AnonymousFunction|)
                                                 (CONSP |t|)
                                                 (EQ (CAR |t|) '|Mapping|))
                                                |t|)
                                               ((AND
                                                 (EQUAL (CAR |p|) (CADR |sig|))
                                                 (NULL
                                                  (|member| (CAR |p|)
                                                   (CDDR |sig|))))
                                                (COND
                                                 ((|canCoerceFrom| |t| |t1|)
                                                  'T)
                                                 (#1# NIL)))
                                               ((|canCoerceFrom| |t1| |t|) 'T)
                                               ((|isSubDomain| |t| |t1|)
                                                (RPLACD |p| |t1|))
                                               (#1#
                                                (AND (EQCAR |t1| '|Symbol|)
                                                     (|canCoerceFrom|
                                                      (|getSymbolType|
                                                       (CAR |p|))
                                                      |t|))))))))))))))
                  (SETQ |bfVar#100| (CDR |bfVar#100|))
                  (SETQ |bfVar#101| (AND |p1| (NULL |b|)))))
               SL NIL NIL)
              (OR (AND SL |p1| (NULL |b|) '|failed|)
                  (|evalMmCat| |op| |sig| |st| SL)))))))))

; fixUpTypeArgs SL ==
;   for (p := [v, :t2]) in SL repeat
;     t1 := LASSOC(v, $Subst)
;     null t1 => RPLACD(p,replaceSharpCalls t2)
;     RPLACD(p, coerceTypeArgs(t1, t2, SL))
;   SL

(DEFUN |fixUpTypeArgs| (SL)
  (PROG (|v| |t2| |t1|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#102| |p|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#102|) (PROGN (SETQ |p| (CAR |bfVar#102|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |p|)
                 (PROGN (SETQ |v| (CAR |p|)) (SETQ |t2| (CDR |p|)) #1#)
                 (PROGN
                  (SETQ |t1| (LASSOC |v| |$Subst|))
                  (COND ((NULL |t1|) (RPLACD |p| (|replaceSharpCalls| |t2|)))
                        (#1# (RPLACD |p| (|coerceTypeArgs| |t1| |t2| SL))))))))
          (SETQ |bfVar#102| (CDR |bfVar#102|))))
       SL NIL)
      SL))))

; replaceSharpCalls t ==
;   noSharpCallsHere t => t
;   doReplaceSharpCalls t

(DEFUN |replaceSharpCalls| (|t|)
  (PROG ()
    (RETURN
     (COND ((|noSharpCallsHere| |t|) |t|) ('T (|doReplaceSharpCalls| |t|))))))

; doReplaceSharpCalls t ==
;   ATOM t => t
;   t is ['_#, l] => #l
;   t is ['construct,: l] => EVAL ['LIST,:l]
;   [first t, :[doReplaceSharpCalls u for u in rest t]]

(DEFUN |doReplaceSharpCalls| (|t|)
  (PROG (|ISTMP#1| |l|)
    (RETURN
     (COND ((ATOM |t|) |t|)
           ((AND (CONSP |t|) (EQ (CAR |t|) '|#|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |l| (CAR |ISTMP#1|)) #1='T))))
            (LENGTH |l|))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|construct|)
                 (PROGN (SETQ |l| (CDR |t|)) #1#))
            (EVAL (CONS 'LIST |l|)))
           (#1#
            (CONS (CAR |t|)
                  ((LAMBDA (|bfVar#104| |bfVar#103| |u|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#103|)
                            (PROGN (SETQ |u| (CAR |bfVar#103|)) NIL))
                        (RETURN (NREVERSE |bfVar#104|)))
                       (#1#
                        (SETQ |bfVar#104|
                                (CONS (|doReplaceSharpCalls| |u|)
                                      |bfVar#104|))))
                      (SETQ |bfVar#103| (CDR |bfVar#103|))))
                   NIL (CDR |t|) NIL)))))))

; noSharpCallsHere t ==
;   t isnt [con, :args] => true
;   MEMQ(con,'(construct _#)) => NIL
;   and/[noSharpCallsHere u for u in args]

(DEFUN |noSharpCallsHere| (|t|)
  (PROG (|con| |args|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |t|)
             (PROGN (SETQ |con| (CAR |t|)) (SETQ |args| (CDR |t|)) #1='T)))
       T)
      ((MEMQ |con| '(|construct| |#|)) NIL)
      (#1#
       ((LAMBDA (|bfVar#106| |bfVar#105| |u|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#105|) (PROGN (SETQ |u| (CAR |bfVar#105|)) NIL))
             (RETURN |bfVar#106|))
            (#1#
             (PROGN
              (SETQ |bfVar#106| (|noSharpCallsHere| |u|))
              (COND ((NOT |bfVar#106|) (RETURN NIL))))))
           (SETQ |bfVar#105| (CDR |bfVar#105|))))
        T |args| NIL))))))

; coerceTypeArgs(t1, t2, SL) ==
;   -- if the type t has type-valued arguments, coerce them to the new types,
;   -- if needed.
;   t1 isnt [con1, :args1] or t2 isnt [con2, :args2] => t2
;   con1 ~= con2 => t2
;   coSig := rest GETDATABASE(first t1, 'COSIG)
;   and/coSig => t2
;   csub1 := constructSubst t1
;   csub2 := constructSubst t2
;   cs1 := rest getConstructorSignature con1
;   cs2 := rest getConstructorSignature con2
;   [con1, :
;     [makeConstrArg(arg1, arg2, constrArg(c1,csub1,SL),
;       constrArg(c2,csub2,SL), cs)
;        for arg1 in args1 for arg2 in args2 for c1 in cs1 for c2 in cs2
;          for cs in coSig]]

(DEFUN |coerceTypeArgs| (|t1| |t2| SL)
  (PROG (|con1| |args1| |con2| |args2| |coSig| |csub1| |csub2| |cs1| |cs2|)
    (RETURN
     (COND
      ((OR
        (NOT
         (AND (CONSP |t1|)
              (PROGN
               (SETQ |con1| (CAR |t1|))
               (SETQ |args1| (CDR |t1|))
               #1='T)))
        (NOT
         (AND (CONSP |t2|)
              (PROGN (SETQ |con2| (CAR |t2|)) (SETQ |args2| (CDR |t2|)) #1#))))
       |t2|)
      ((NOT (EQUAL |con1| |con2|)) |t2|)
      (#1#
       (PROGN
        (SETQ |coSig| (CDR (GETDATABASE (CAR |t1|) 'COSIG)))
        (COND
         (((LAMBDA (|bfVar#107| |bfVar#109| |bfVar#108|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#109|)
                    (PROGN (SETQ |bfVar#108| (CAR |bfVar#109|)) NIL))
                (RETURN |bfVar#107|))
               (#1# (SETQ |bfVar#107| (AND |bfVar#107| |bfVar#108|))))
              (SETQ |bfVar#109| (CDR |bfVar#109|))))
           T |coSig| NIL)
          |t2|)
         (#1#
          (PROGN
           (SETQ |csub1| (|constructSubst| |t1|))
           (SETQ |csub2| (|constructSubst| |t2|))
           (SETQ |cs1| (CDR (|getConstructorSignature| |con1|)))
           (SETQ |cs2| (CDR (|getConstructorSignature| |con2|)))
           (CONS |con1|
                 ((LAMBDA
                      (|bfVar#115| |bfVar#110| |arg1| |bfVar#111| |arg2|
                       |bfVar#112| |c1| |bfVar#113| |c2| |bfVar#114| |cs|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#110|)
                           (PROGN (SETQ |arg1| (CAR |bfVar#110|)) NIL)
                           (ATOM |bfVar#111|)
                           (PROGN (SETQ |arg2| (CAR |bfVar#111|)) NIL)
                           (ATOM |bfVar#112|)
                           (PROGN (SETQ |c1| (CAR |bfVar#112|)) NIL)
                           (ATOM |bfVar#113|)
                           (PROGN (SETQ |c2| (CAR |bfVar#113|)) NIL)
                           (ATOM |bfVar#114|)
                           (PROGN (SETQ |cs| (CAR |bfVar#114|)) NIL))
                       (RETURN (NREVERSE |bfVar#115|)))
                      (#1#
                       (SETQ |bfVar#115|
                               (CONS
                                (|makeConstrArg| |arg1| |arg2|
                                 (|constrArg| |c1| |csub1| SL)
                                 (|constrArg| |c2| |csub2| SL) |cs|)
                                |bfVar#115|))))
                     (SETQ |bfVar#110| (CDR |bfVar#110|))
                     (SETQ |bfVar#111| (CDR |bfVar#111|))
                     (SETQ |bfVar#112| (CDR |bfVar#112|))
                     (SETQ |bfVar#113| (CDR |bfVar#113|))
                     (SETQ |bfVar#114| (CDR |bfVar#114|))))
                  NIL |args1| NIL |args2| NIL |cs1| NIL |cs2| NIL |coSig|
                  NIL)))))))))))

; constrArg(v,sl,SL) ==
;   x := LASSOC(v,sl) =>
;     y := LASSOC(x,SL) => y
;     y := LASSOC(x, $Subst) => y
;     x
;   y := LASSOC(x, $Subst) => y
;   v

(DEFUN |constrArg| (|v| |sl| SL)
  (PROG (|x| |y|)
    (RETURN
     (COND
      ((SETQ |x| (LASSOC |v| |sl|))
       (COND ((SETQ |y| (LASSOC |x| SL)) |y|)
             ((SETQ |y| (LASSOC |x| |$Subst|)) |y|) (#1='T |x|)))
      ((SETQ |y| (LASSOC |x| |$Subst|)) |y|) (#1# |v|)))))

; makeConstrArg(arg1, arg2, t1, t2, cs) ==
;   if arg1 is ['_#, l] then arg1 := # l
;   if arg2 is ['_#, l] then arg2 := # l
;   cs => arg2
;   t1 = t2 => arg2
;   obj1 := objNewWrap(arg1, t1)
;   obj2 := coerceInt(obj1, t2)
;   null obj2 => throwKeyedMsgCannotCoerceWithValue(wrap arg1,t1,t2)
;   objValUnwrap obj2

(DEFUN |makeConstrArg| (|arg1| |arg2| |t1| |t2| |cs|)
  (PROG (|ISTMP#1| |l| |obj1| |obj2|)
    (RETURN
     (PROGN
      (COND
       ((AND (CONSP |arg1|) (EQ (CAR |arg1|) '|#|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |arg1|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |l| (CAR |ISTMP#1|)) #1='T))))
        (SETQ |arg1| (LENGTH |l|))))
      (COND
       ((AND (CONSP |arg2|) (EQ (CAR |arg2|) '|#|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |arg2|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |l| (CAR |ISTMP#1|)) #1#))))
        (SETQ |arg2| (LENGTH |l|))))
      (COND (|cs| |arg2|) ((EQUAL |t1| |t2|) |arg2|)
            (#1#
             (PROGN
              (SETQ |obj1| (|objNewWrap| |arg1| |t1|))
              (SETQ |obj2| (|coerceInt| |obj1| |t2|))
              (COND
               ((NULL |obj2|)
                (|throwKeyedMsgCannotCoerceWithValue| (|wrap| |arg1|) |t1|
                 |t2|))
               (#1# (|objValUnwrap| |obj2|))))))))))

; evalMmDom(st) ==
;   -- evals all isDomain(v,d) of st
;   SL:= NIL
;   for mmC in st until SL='failed repeat
;     mmC is ['isDomain,v,d] =>
;       STRINGP d => SL:= 'failed
;       p := ASSQ(v, SL) and not (d = rest p) => SL := 'failed
;       d1:= subCopy(d,SL)
;       CONSP(d1) and MEMQ(v,d1) => SL:= 'failed
;       SL:= augmentSub(v,d1,SL)
;     mmC is ['isFreeFunction,v,fun] =>
;       SL:= augmentSub(v,subCopy(fun,SL),SL)
;   SL

(DEFUN |evalMmDom| (|st|)
  (PROG (SL |ISTMP#1| |v| |ISTMP#2| |d| |p| |d1| |fun|)
    (RETURN
     (PROGN
      (SETQ SL NIL)
      ((LAMBDA (|bfVar#116| |mmC| |bfVar#117|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#116|) (PROGN (SETQ |mmC| (CAR |bfVar#116|)) NIL)
                |bfVar#117|)
            (RETURN NIL))
           (#1='T
            (COND
             ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|isDomain|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |mmC|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |v| (CAR |ISTMP#1|))
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ |d| (CAR |ISTMP#2|)) #1#))))))
              (COND ((STRINGP |d|) (SETQ SL '|failed|))
                    ((SETQ |p|
                             (AND (ASSQ |v| SL) (NULL (EQUAL |d| (CDR |p|)))))
                     (SETQ SL '|failed|))
                    (#1#
                     (PROGN
                      (SETQ |d1| (|subCopy| |d| SL))
                      (COND
                       ((AND (CONSP |d1|) (MEMQ |v| |d1|)) (SETQ SL '|failed|))
                       (#1# (SETQ SL (|augmentSub| |v| |d1| SL))))))))
             ((AND (CONSP |mmC|) (EQ (CAR |mmC|) '|isFreeFunction|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |mmC|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |v| (CAR |ISTMP#1|))
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ |fun| (CAR |ISTMP#2|)) #1#))))))
              (SETQ SL (|augmentSub| |v| (|subCopy| |fun| SL) SL))))))
          (SETQ |bfVar#116| (CDR |bfVar#116|))
          (SETQ |bfVar#117| (EQ SL '|failed|))))
       |st| NIL NIL)
      SL))))

; orderMmCatStack st ==
;   -- tries to reorder stack so that free pattern variables appear
;   -- as parameters first
;   null(st) or null rest(st) => st
;   vars := DELETE_-DUPLICATES [CADR(s) for s in st | isPatternVar(CADR(s))]
;   null vars => st
;   havevars := nil
;   haventvars := nil
;   for s in st repeat
;     cat := CADDR s
;     mem := nil
;     for v in vars while not mem repeat
;       if MEMQ(v,cat) then
;         mem := true
;         havevars := cons(s,havevars)
;     if not mem then haventvars := cons(s,haventvars)
;   null havevars => st
;   st := nreverse nconc(haventvars,havevars)
;   SORT(st, function mmCatComp)

(DEFUN |orderMmCatStack| (|st|)
  (PROG (|vars| |havevars| |haventvars| |cat| |mem|)
    (RETURN
     (COND ((OR (NULL |st|) (NULL (CDR |st|))) |st|)
           (#1='T
            (PROGN
             (SETQ |vars|
                     (DELETE-DUPLICATES
                      ((LAMBDA (|bfVar#119| |bfVar#118| |s|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#118|)
                                (PROGN (SETQ |s| (CAR |bfVar#118|)) NIL))
                            (RETURN (NREVERSE |bfVar#119|)))
                           (#1#
                            (AND (|isPatternVar| (CADR |s|))
                                 (SETQ |bfVar#119|
                                         (CONS (CADR |s|) |bfVar#119|)))))
                          (SETQ |bfVar#118| (CDR |bfVar#118|))))
                       NIL |st| NIL)))
             (COND ((NULL |vars|) |st|)
                   (#1#
                    (PROGN
                     (SETQ |havevars| NIL)
                     (SETQ |haventvars| NIL)
                     ((LAMBDA (|bfVar#120| |s|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#120|)
                               (PROGN (SETQ |s| (CAR |bfVar#120|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (PROGN
                            (SETQ |cat| (CADDR |s|))
                            (SETQ |mem| NIL)
                            ((LAMBDA (|bfVar#121| |v|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#121|)
                                      (PROGN (SETQ |v| (CAR |bfVar#121|)) NIL)
                                      |mem|)
                                  (RETURN NIL))
                                 (#1#
                                  (COND
                                   ((MEMQ |v| |cat|) (SETQ |mem| T)
                                    (SETQ |havevars| (CONS |s| |havevars|))))))
                                (SETQ |bfVar#121| (CDR |bfVar#121|))))
                             |vars| NIL)
                            (COND
                             ((NULL |mem|)
                              (SETQ |haventvars| (CONS |s| |haventvars|)))))))
                         (SETQ |bfVar#120| (CDR |bfVar#120|))))
                      |st| NIL)
                     (COND ((NULL |havevars|) |st|)
                           (#1#
                            (PROGN
                             (SETQ |st|
                                     (NREVERSE
                                      (NCONC |haventvars| |havevars|)))
                             (SORT |st| #'|mmCatComp|)))))))))))))

; mmCatComp(c1, c2) ==
;   b1 := ASSQ(CADR c1, $Subst)
;   b2 := ASSQ(CADR c2, $Subst)
;   b1 and null(b2) => true
;   false

(DEFUN |mmCatComp| (|c1| |c2|)
  (PROG (|b1| |b2|)
    (RETURN
     (PROGN
      (SETQ |b1| (ASSQ (CADR |c1|) |$Subst|))
      (SETQ |b2| (ASSQ (CADR |c2|) |$Subst|))
      (COND ((AND |b1| (NULL |b2|)) T) ('T NIL))))))

; evalMmCat(op,sig,stack,SL) ==
;   -- evaluates all ofCategory's of stack as soon as possible
;   $hope:local:= NIL
;   stack:= orderMmCatStack [mmC for mmC in stack | EQCAR(mmC,'ofCategory)]
;   while stack until not makingProgress repeat
;     st := stack
;     stack := NIL
;     makingProgress := NIL
;     for mmC in st repeat
;       S:= evalMmCat1(mmC,op, SL)
;       S='failed and $hope =>
;         stack:= CONS(mmC,stack)
;       S = 'failed => return S
;       not atom S =>
;         makingProgress:= 'T
;         SL:= mergeSubs(S,SL)
;   if stack or S='failed then 'failed else SL

(DEFUN |evalMmCat| (|op| |sig| |stack| SL)
  (PROG (|$hope| S |makingProgress| |st|)
    (DECLARE (SPECIAL |$hope|))
    (RETURN
     (PROGN
      (SETQ |$hope| NIL)
      (SETQ |stack|
              (|orderMmCatStack|
               ((LAMBDA (|bfVar#123| |bfVar#122| |mmC|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#122|)
                         (PROGN (SETQ |mmC| (CAR |bfVar#122|)) NIL))
                     (RETURN (NREVERSE |bfVar#123|)))
                    (#1='T
                     (AND (EQCAR |mmC| '|ofCategory|)
                          (SETQ |bfVar#123| (CONS |mmC| |bfVar#123|)))))
                   (SETQ |bfVar#122| (CDR |bfVar#122|))))
                NIL |stack| NIL)))
      ((LAMBDA (|bfVar#124|)
         (LOOP
          (COND ((OR (NOT |stack|) |bfVar#124|) (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |st| |stack|)
                  (SETQ |stack| NIL)
                  (SETQ |makingProgress| NIL)
                  ((LAMBDA (|bfVar#125| |mmC|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#125|)
                            (PROGN (SETQ |mmC| (CAR |bfVar#125|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ S (|evalMmCat1| |mmC| |op| SL))
                         (COND
                          ((AND (EQ S '|failed|) |$hope|)
                           (SETQ |stack| (CONS |mmC| |stack|)))
                          ((EQ S '|failed|) (RETURN S))
                          ((NULL (ATOM S))
                           (PROGN
                            (SETQ |makingProgress| 'T)
                            (SETQ SL (|mergeSubs| S SL))))))))
                      (SETQ |bfVar#125| (CDR |bfVar#125|))))
                   |st| NIL))))
          (SETQ |bfVar#124| (NULL |makingProgress|))))
       NIL)
      (COND ((OR |stack| (EQ S '|failed|)) '|failed|) (#1# SL))))))

; evalMmCat1(mmC is ['ofCategory,d,c],op, SL) ==
;   -- evaluates mmC using information from the lisplib
;   -- d may contain variables, and the substitution list $Subst is used
;   -- the result is a substitution or failed
;   $domPvar: local := NIL
;   $hope:= NIL
;   NSL:= hasCate(d,c,SL)
;   NSL='failed and isPatternVar d and $Coerce and ( p:= ASSQ(d,$Subst) )
;     and (EQCAR(rest p, 'Variable) or EQCAR(rest p, 'Symbol)) =>
;       RPLACD(p,getSymbolType d)
;       hasCate(d,c,SL)
;   NSL='failed and isPatternVar d =>
;     -- following is hack to take care of the case where we have a
;     -- free substitution variable with a category condition on it.
;     -- This would arise, for example, where a package has an argument
;     -- that is not in a needed modemap.  After making the following
;     -- dummy substitutions, the package can be instantiated and the
;     -- modemap used.       RSS 12-22-85
;     -- If c is not Set, Ring or Field then the more general mechanism
;     dom := defaultTypeForCategory(c, SL)
;     null dom =>
;       op ~= 'coerce => 'failed -- evalMmCatLastChance(d,c,SL)
;     null (p := ASSQ(d,$Subst)) =>
;       dom =>
;         NSL := [CONS(d,dom)]
;       op ~= 'coerce => 'failed -- evalMmCatLastChance(d,c,SL)
;     if containsVars dom then dom := resolveTM(rest p, dom)
;     $Coerce and canCoerce(rest p, dom) =>
;       NSL := [CONS(d,dom)]
;     op ~= 'coerce => 'failed -- evalMmCatLastChance(d,c,SL)
;   NSL

(DEFUN |evalMmCat1| (|mmC| |op| SL)
  (PROG (|$domPvar| |dom| |p| NSL |c| |d|)
    (DECLARE (SPECIAL |$domPvar|))
    (RETURN
     (PROGN
      (SETQ |d| (CADR . #1=(|mmC|)))
      (SETQ |c| (CADDR . #1#))
      (SETQ |$domPvar| NIL)
      (SETQ |$hope| NIL)
      (SETQ NSL (|hasCate| |d| |c| SL))
      (COND
       ((AND (EQ NSL '|failed|) (|isPatternVar| |d|) |$Coerce|
             (SETQ |p| (ASSQ |d| |$Subst|))
             (OR (EQCAR (CDR |p|) '|Variable|) (EQCAR (CDR |p|) '|Symbol|)))
        (PROGN (RPLACD |p| (|getSymbolType| |d|)) (|hasCate| |d| |c| SL)))
       ((AND (EQ NSL '|failed|) (|isPatternVar| |d|))
        (PROGN
         (SETQ |dom| (|defaultTypeForCategory| |c| SL))
         (COND
          ((NULL |dom|)
           (COND ((NOT (EQ |op| '|coerce|)) (IDENTITY '|failed|))))
          ((NULL (SETQ |p| (ASSQ |d| |$Subst|)))
           (COND (|dom| (SETQ NSL (LIST (CONS |d| |dom|))))
                 ((NOT (EQ |op| '|coerce|)) '|failed|)))
          (#2='T
           (PROGN
            (COND
             ((|containsVars| |dom|)
              (SETQ |dom| (|resolveTM| (CDR |p|) |dom|))))
            (COND
             ((AND |$Coerce| (|canCoerce| (CDR |p|) |dom|))
              (SETQ NSL (LIST (CONS |d| |dom|))))
             ((NOT (EQ |op| '|coerce|)) '|failed|)))))))
       (#2# NSL))))))

; hasCate(dom,cat,SL) ==
;   -- asks whether dom has cat under SL
;   -- augments substitution SL or returns 'failed
;   dom = $EmptyMode => NIL
;   isPatternVar dom =>
;     (p := ASSQ(dom, SL)) and ((NSL := hasCate(rest p, cat, SL)) ~= 'failed) =>
;        NSL
;     (p:= ASSQ(dom,$Subst)) or (p := ASSQ(dom, SL)) =>
; --      S := hasCate(rest p, cat, augmentSub(first p, rest p, copy SL))
;       S := hasCate1(rest p, cat, SL, dom)
;       not (S='failed) => S
;       hasCateSpecial(dom, rest p, cat, SL)
;     if SL ~= 'failed then $hope:= 'T
;     'failed
;   SL1 := [[v,:d] for [v,:d] in SL | not containsVariables d]
;   if SL1 then cat := subCopy(cat, SL1)
;   hasCaty(dom,cat,SL)

(DEFUN |hasCate| (|dom| |cat| SL)
  (PROG (|p| NSL S |v| |d| SL1)
    (RETURN
     (COND ((EQUAL |dom| |$EmptyMode|) NIL)
           ((|isPatternVar| |dom|)
            (COND
             ((AND (SETQ |p| (ASSQ |dom| SL))
                   (NOT
                    (EQ (SETQ NSL (|hasCate| (CDR |p|) |cat| SL)) '|failed|)))
              NSL)
             ((OR (SETQ |p| (ASSQ |dom| |$Subst|)) (SETQ |p| (ASSQ |dom| SL)))
              (PROGN
               (SETQ S (|hasCate1| (CDR |p|) |cat| SL |dom|))
               (COND ((NULL (EQ S '|failed|)) S)
                     (#1='T (|hasCateSpecial| |dom| (CDR |p|) |cat| SL)))))
             (#1#
              (PROGN
               (COND ((NOT (EQ SL '|failed|)) (SETQ |$hope| 'T)))
               '|failed|))))
           (#1#
            (PROGN
             (SETQ SL1
                     ((LAMBDA (|bfVar#128| |bfVar#127| |bfVar#126|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#127|)
                               (PROGN
                                (SETQ |bfVar#126| (CAR |bfVar#127|))
                                NIL))
                           (RETURN (NREVERSE |bfVar#128|)))
                          (#1#
                           (AND (CONSP |bfVar#126|)
                                (PROGN
                                 (SETQ |v| (CAR |bfVar#126|))
                                 (SETQ |d| (CDR |bfVar#126|))
                                 #1#)
                                (NULL (|containsVariables| |d|))
                                (SETQ |bfVar#128|
                                        (CONS (CONS |v| |d|) |bfVar#128|)))))
                         (SETQ |bfVar#127| (CDR |bfVar#127|))))
                      NIL SL NIL))
             (COND (SL1 (SETQ |cat| (|subCopy| |cat| SL1))))
             (|hasCaty| |dom| |cat| SL)))))))

; hasCate1(dom, cat, SL, domPvar) ==
;   $domPvar:local := domPvar
;   hasCate(dom, cat, SL)

(DEFUN |hasCate1| (|dom| |cat| SL |domPvar|)
  (PROG (|$domPvar|)
    (DECLARE (SPECIAL |$domPvar|))
    (RETURN (PROGN (SETQ |$domPvar| |domPvar|) (|hasCate| |dom| |cat| SL)))))

; hasCateSpecial(v,dom,cat,SL) ==
;   -- v is a pattern variable, dom it's binding under $Subst
;   -- tries to change dom, so that it has category cat under SL
;   -- the result is a substitution list or 'failed
;   EQCAR(cat,'Field) or EQCAR(cat, 'DivisionRing) =>
;     if isSubDomain(dom,$Integer) then dom := $Integer
;     d:= [$QuotientField, dom]
;     hasCaty(dom,'(IntegralDomain),augmentSub(v,d,SL))
;   cat is ['PolynomialCategory, d, :.] =>
;     dom' := ['Polynomial, d]
;     (containsVars d or canCoerceFrom(dom, dom'))
;        and hasCaty(dom', cat, augmentSub(v,dom',SL))
;   isSubDomain(dom,$Integer) =>
;     NSL:= hasCate($Integer,cat,augmentSub(v,$Integer,SL))
;     NSL = 'failed =>
;       hasCateSpecialNew(v, dom, cat, SL)
;     hasCaty($Integer,cat,NSL)
;   hasCateSpecialNew(v, dom, cat, SL)

(DEFUN |hasCateSpecial| (|v| |dom| |cat| SL)
  (PROG (|d| |ISTMP#1| |dom'| NSL)
    (RETURN
     (COND
      ((OR (EQCAR |cat| '|Field|) (EQCAR |cat| '|DivisionRing|))
       (PROGN
        (COND ((|isSubDomain| |dom| |$Integer|) (SETQ |dom| |$Integer|)))
        (SETQ |d| (LIST |$QuotientField| |dom|))
        (|hasCaty| |dom| '(|IntegralDomain|) (|augmentSub| |v| |d| SL))))
      ((AND (CONSP |cat|) (EQ (CAR |cat|) '|PolynomialCategory|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |cat|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |d| (CAR |ISTMP#1|)) #1='T))))
       (PROGN
        (SETQ |dom'| (LIST '|Polynomial| |d|))
        (AND (OR (|containsVars| |d|) (|canCoerceFrom| |dom| |dom'|))
             (|hasCaty| |dom'| |cat| (|augmentSub| |v| |dom'| SL)))))
      ((|isSubDomain| |dom| |$Integer|)
       (PROGN
        (SETQ NSL
                (|hasCate| |$Integer| |cat| (|augmentSub| |v| |$Integer| SL)))
        (COND ((EQ NSL '|failed|) (|hasCateSpecialNew| |v| |dom| |cat| SL))
              (#1# (|hasCaty| |$Integer| |cat| NSL)))))
      (#1# (|hasCateSpecialNew| |v| |dom| |cat| SL))))))

; hasCateSpecialNew(v,dom,cat,SL) ==
;   fe := member(QCAR cat, '(ElementaryFunctionCategory
;        TrigonometricFunctionCategory ArcTrigonometricFunctionCategory
;         HyperbolicFunctionCategory ArcHyperbolicFunctionCategory
;          PrimitiveFunctionCategory SpecialFunctionCategory Evalable
;           CombinatorialOpsCategory TranscendentalFunctionCategory
;            AlgebraicallyClosedFunctionSpace ExpressionSpace
;              LiouvillianFunctionCategory FunctionSpace))
;   alg := member(QCAR cat, '(RadicalCategory AlgebraicallyClosedField))
;   fefull := fe or alg or EQCAR(cat, 'CombinatorialFunctionCategory)
;   partialResult :=
;     EQCAR(dom, 'Variable) or EQCAR(dom, 'Symbol) =>
;       first(cat) in '(Magma AbelianSemiGroup AbelianGroup) =>
;                 d := ['Polynomial, $Integer]
;                 augmentSub(v, d, SL)
;       EQCAR(cat, 'Group) =>
;         d := ['Fraction, ['Polynomial, $Integer]]
;         augmentSub(v, d, SL)
;       fefull =>
;         d := defaultTargetFE dom
;         augmentSub(v, d, SL)
;       'failed
;     isEqualOrSubDomain(dom, $Integer) =>
;       fe =>
;         d := defaultTargetFE $Integer
;         augmentSub(v, d, SL)
;       alg =>
;         d := '(AlgebraicNumber)
;         --d := defaultTargetFE $Integer
;         augmentSub(v, d, SL)
;       'failed
;     underDomainOf dom = $ComplexInteger =>
;       d := defaultTargetFE $ComplexInteger
;       hasCaty(d,cat,augmentSub(v, d, SL))
;     (dom = $RationalNumber) and alg =>
;       d := '(AlgebraicNumber)
;       --d := defaultTargetFE $Integer
;       augmentSub(v, d, SL)
;     fefull =>
;       d := defaultTargetFE dom
;       augmentSub(v, d, SL)
;     'failed
;   partialResult = 'failed => 'failed
;   hasCaty(d, cat, partialResult)

(DEFUN |hasCateSpecialNew| (|v| |dom| |cat| SL)
  (PROG (|fe| |alg| |fefull| |d| |partialResult|)
    (RETURN
     (PROGN
      (SETQ |fe|
              (|member| (QCAR |cat|)
               '(|ElementaryFunctionCategory| |TrigonometricFunctionCategory|
                 |ArcTrigonometricFunctionCategory|
                 |HyperbolicFunctionCategory| |ArcHyperbolicFunctionCategory|
                 |PrimitiveFunctionCategory| |SpecialFunctionCategory|
                 |Evalable| |CombinatorialOpsCategory|
                 |TranscendentalFunctionCategory|
                 |AlgebraicallyClosedFunctionSpace| |ExpressionSpace|
                 |LiouvillianFunctionCategory| |FunctionSpace|)))
      (SETQ |alg|
              (|member| (QCAR |cat|)
               '(|RadicalCategory| |AlgebraicallyClosedField|)))
      (SETQ |fefull|
              (OR |fe| |alg| (EQCAR |cat| '|CombinatorialFunctionCategory|)))
      (SETQ |partialResult|
              (COND
               ((OR (EQCAR |dom| '|Variable|) (EQCAR |dom| '|Symbol|))
                (COND
                 ((|member| (CAR |cat|)
                   '(|Magma| |AbelianSemiGroup| |AbelianGroup|))
                  (PROGN
                   (SETQ |d| (LIST '|Polynomial| |$Integer|))
                   (|augmentSub| |v| |d| SL)))
                 ((EQCAR |cat| '|Group|)
                  (PROGN
                   (SETQ |d|
                           (LIST '|Fraction| (LIST '|Polynomial| |$Integer|)))
                   (|augmentSub| |v| |d| SL)))
                 (|fefull|
                  (PROGN
                   (SETQ |d| (|defaultTargetFE| |dom|))
                   (|augmentSub| |v| |d| SL)))
                 (#1='T '|failed|)))
               ((|isEqualOrSubDomain| |dom| |$Integer|)
                (COND
                 (|fe|
                  (PROGN
                   (SETQ |d| (|defaultTargetFE| |$Integer|))
                   (|augmentSub| |v| |d| SL)))
                 (|alg|
                  (PROGN
                   (SETQ |d| '(|AlgebraicNumber|))
                   (|augmentSub| |v| |d| SL)))
                 (#1# '|failed|)))
               ((EQUAL (|underDomainOf| |dom|) |$ComplexInteger|)
                (PROGN
                 (SETQ |d| (|defaultTargetFE| |$ComplexInteger|))
                 (|hasCaty| |d| |cat| (|augmentSub| |v| |d| SL))))
               ((AND (EQUAL |dom| |$RationalNumber|) |alg|)
                (PROGN
                 (SETQ |d| '(|AlgebraicNumber|))
                 (|augmentSub| |v| |d| SL)))
               (|fefull|
                (PROGN
                 (SETQ |d| (|defaultTargetFE| |dom|))
                 (|augmentSub| |v| |d| SL)))
               (#1# '|failed|)))
      (COND ((EQ |partialResult| '|failed|) '|failed|)
            (#1# (|hasCaty| |d| |cat| |partialResult|)))))))

; hasCaty(d,cat,SL) ==
;   -- calls hasCat, which looks up a hashtable and returns:
;   -- 1. T, NIL or a (has x1 x2) condition, if cat is not parameterized
;   -- 2. a list of pairs (argument to cat,condition) otherwise
;   -- then the substitution SL is augmented, or the result is 'failed
;   cat is ['CATEGORY,.,:y] => hasAttSig(d,subCopy(y,constructSubst d),SL)
;   cat is ['SIGNATURE,foo,sig] =>
;     hasSig(d,foo,subCopy(sig,constructSubst d),SL)
;   cat is ['ATTRIBUTE,a] => BREAK()
;   x:= hasCat(opOf d,opOf cat) =>
;     y:= IFCDR cat =>
;       S  := constructSubst d
;       for [z,:cond] in x until not (S1='failed) repeat
;         S' := [[p, :mkDomPvar(p, d, z, y)] for [p,:d] in S]
;         if $domPvar then
;           dom := [first d, :[domArg(arg, i, z, y) for i in 0..
;                            for arg in rest d]]
;           SL := augmentSub($domPvar, dom, copy SL)
;         z' := [domArg2(a, S, S') for a in z]
;         S1:= unifyStruct(y,z',copy SL)
;         if not (S1='failed) then S1:=
;           atom cond => S1
;           ncond := subCopy(cond, S)
;           ncond is ['has, =d, =cat] => 'failed
;           hasCaty1(ncond,S1)
;       S1
;     atom x => SL
;     ncond := subCopy(x, constructSubst d)
;     ncond is ['has, =d, =cat] => 'failed
;     hasCaty1(substitute('failed, ['has, d, cat], ncond), SL)
;   'failed

(DEFUN |hasCaty| (|d| |cat| SL)
  (PROG (|ISTMP#1| |y| |foo| |ISTMP#2| |sig| |a| |x| S |z| |cond| |p| |S'|
         |dom| |z'| S1 |ncond|)
    (RETURN
     (COND
      ((AND (CONSP |cat|) (EQ (CAR |cat|) 'CATEGORY)
            (PROGN
             (SETQ |ISTMP#1| (CDR |cat|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |y| (CDR |ISTMP#1|)) #1='T))))
       (|hasAttSig| |d| (|subCopy| |y| (|constructSubst| |d|)) SL))
      ((AND (CONSP |cat|) (EQ (CAR |cat|) 'SIGNATURE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |cat|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |foo| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1#))))))
       (|hasSig| |d| |foo| (|subCopy| |sig| (|constructSubst| |d|)) SL))
      ((AND (CONSP |cat|) (EQ (CAR |cat|) 'ATTRIBUTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |cat|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#))))
       (BREAK))
      ((SETQ |x| (|hasCat| (|opOf| |d|) (|opOf| |cat|)))
       (COND
        ((SETQ |y| (IFCDR |cat|))
         (PROGN
          (SETQ S (|constructSubst| |d|))
          ((LAMBDA (|bfVar#130| |bfVar#129| |bfVar#131|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#130|)
                    (PROGN (SETQ |bfVar#129| (CAR |bfVar#130|)) NIL)
                    |bfVar#131|)
                (RETURN NIL))
               (#1#
                (AND (CONSP |bfVar#129|)
                     (PROGN
                      (SETQ |z| (CAR |bfVar#129|))
                      (SETQ |cond| (CDR |bfVar#129|))
                      #1#)
                     (PROGN
                      (SETQ |S'|
                              ((LAMBDA (|bfVar#134| |bfVar#133| |bfVar#132|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#133|)
                                        (PROGN
                                         (SETQ |bfVar#132| (CAR |bfVar#133|))
                                         NIL))
                                    (RETURN (NREVERSE |bfVar#134|)))
                                   (#1#
                                    (AND (CONSP |bfVar#132|)
                                         (PROGN
                                          (SETQ |p| (CAR |bfVar#132|))
                                          (SETQ |d| (CDR |bfVar#132|))
                                          #1#)
                                         (SETQ |bfVar#134|
                                                 (CONS
                                                  (CONS |p|
                                                        (|mkDomPvar| |p| |d|
                                                         |z| |y|))
                                                  |bfVar#134|)))))
                                  (SETQ |bfVar#133| (CDR |bfVar#133|))))
                               NIL S NIL))
                      (COND
                       (|$domPvar|
                        (SETQ |dom|
                                (CONS (CAR |d|)
                                      ((LAMBDA
                                           (|bfVar#136| |i| |bfVar#135| |arg|)
                                         (LOOP
                                          (COND
                                           ((OR (ATOM |bfVar#135|)
                                                (PROGN
                                                 (SETQ |arg| (CAR |bfVar#135|))
                                                 NIL))
                                            (RETURN (NREVERSE |bfVar#136|)))
                                           (#1#
                                            (SETQ |bfVar#136|
                                                    (CONS
                                                     (|domArg| |arg| |i| |z|
                                                      |y|)
                                                     |bfVar#136|))))
                                          (SETQ |i| (+ |i| 1))
                                          (SETQ |bfVar#135|
                                                  (CDR |bfVar#135|))))
                                       NIL 0 (CDR |d|) NIL)))
                        (SETQ SL (|augmentSub| |$domPvar| |dom| (COPY SL)))))
                      (SETQ |z'|
                              ((LAMBDA (|bfVar#138| |bfVar#137| |a|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#137|)
                                        (PROGN
                                         (SETQ |a| (CAR |bfVar#137|))
                                         NIL))
                                    (RETURN (NREVERSE |bfVar#138|)))
                                   (#1#
                                    (SETQ |bfVar#138|
                                            (CONS (|domArg2| |a| S |S'|)
                                                  |bfVar#138|))))
                                  (SETQ |bfVar#137| (CDR |bfVar#137|))))
                               NIL |z| NIL))
                      (SETQ S1 (|unifyStruct| |y| |z'| (COPY SL)))
                      (COND
                       ((NULL (EQ S1 '|failed|))
                        (SETQ S1
                                (COND ((ATOM |cond|) S1)
                                      (#1#
                                       (PROGN
                                        (SETQ |ncond| (|subCopy| |cond| S))
                                        (COND
                                         ((AND (CONSP |ncond|)
                                               (EQ (CAR |ncond|) '|has|)
                                               (PROGN
                                                (SETQ |ISTMP#1| (CDR |ncond|))
                                                (AND (CONSP |ISTMP#1|)
                                                     (EQUAL (CAR |ISTMP#1|)
                                                            |d|)
                                                     (PROGN
                                                      (SETQ |ISTMP#2|
                                                              (CDR |ISTMP#1|))
                                                      (AND (CONSP |ISTMP#2|)
                                                           (EQ (CDR |ISTMP#2|)
                                                               NIL)
                                                           (EQUAL
                                                            (CAR |ISTMP#2|)
                                                            |cat|))))))
                                          '|failed|)
                                         (#1#
                                          (|hasCaty1| |ncond| S1)))))))))))))
              (SETQ |bfVar#130| (CDR |bfVar#130|))
              (SETQ |bfVar#131| (NULL (EQ S1 '|failed|)))))
           |x| NIL NIL)
          S1))
        ((ATOM |x|) SL)
        (#1#
         (PROGN
          (SETQ |ncond| (|subCopy| |x| (|constructSubst| |d|)))
          (COND
           ((AND (CONSP |ncond|) (EQ (CAR |ncond|) '|has|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |ncond|))
                  (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |d|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (EQUAL (CAR |ISTMP#2|) |cat|))))))
            '|failed|)
           (#1#
            (|hasCaty1|
             (|substitute| '|failed| (LIST '|has| |d| |cat|) |ncond|) SL)))))))
      (#1# '|failed|)))))

; mkDomPvar(p, d, subs, y) ==
;   l := MEMQ(p, $FormalMapVariableList) =>
;     domArg(d, #$FormalMapVariableList - #l, subs, y)
;   d

(DEFUN |mkDomPvar| (|p| |d| |subs| |y|)
  (PROG (|l|)
    (RETURN
     (COND
      ((SETQ |l| (MEMQ |p| |$FormalMapVariableList|))
       (|domArg| |d| (- (LENGTH |$FormalMapVariableList|) (LENGTH |l|)) |subs|
        |y|))
      ('T |d|)))))

; domArg(type, i, subs, y) ==
;   p := MEMQ($FormalMapVariableList.i, subs) =>
;     y.(#subs - #p)
;   type

(DEFUN |domArg| (|type| |i| |subs| |y|)
  (PROG (|p|)
    (RETURN
     (COND
      ((SETQ |p| (MEMQ (ELT |$FormalMapVariableList| |i|) |subs|))
       (ELT |y| (- (LENGTH |subs|) (LENGTH |p|))))
      ('T |type|)))))

; domArg2(arg, SL1, SL2) ==
;   isSharpVar arg => subCopy(arg, SL1)
;   arg = '_$ and $domPvar => $domPvar
;   subCopy(arg, SL2)

(DEFUN |domArg2| (|arg| SL1 SL2)
  (PROG ()
    (RETURN
     (COND ((|isSharpVar| |arg|) (|subCopy| |arg| SL1))
           ((AND (EQ |arg| '$) |$domPvar|) |$domPvar|)
           ('T (|subCopy| |arg| SL2))))))

; hasCaty1(cond,SL) ==
;   -- cond is either a (has a b) or an OR/AND clause of such conditions,
;   --     or a special flag 'failed to indicate failure
;   -- SL is augmented, if cond is true, otherwise the result is 'failed
;   $domPvar: local := NIL
;   cond is 'failed => 'failed
;   cond is ['has,a,b] => hasCate(a,b,SL)
;   cond is ['AND,:args] =>
;     for x in args while not (S='failed) repeat S:=
;       x is ['has,a,b] => hasCate(a,b, SL)
;       -- next line is for an obscure bug in the table
;       x is [['has,a,b]] => hasCate(a,b, SL)
;       --'failed
;       hasCaty1(x, SL)
;     S
;   cond is ['OR,:args] =>
;     for x in args until not (S='failed) repeat S:=
;       x is ['has,a,b] => hasCate(a,b,copy SL)
;       -- next line is for an obscure bug in the table
;       x is [['has,a,b]] => hasCate(a,b,copy SL)
;       --'failed
;       hasCaty1(x, copy SL)
;     S
;   keyedSystemError("S2GE0016",
;     ['"hasCaty1",'"unexpected condition from category table"])

(DEFUN |hasCaty1| (|cond| SL)
  (PROG (|$domPvar| S |ISTMP#3| |args| |b| |ISTMP#2| |a| |ISTMP#1|)
    (DECLARE (SPECIAL |$domPvar|))
    (RETURN
     (PROGN
      (SETQ |$domPvar| NIL)
      (COND ((EQ |cond| '|failed|) '|failed|)
            ((AND (CONSP |cond|) (EQ (CAR |cond|) '|has|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |cond|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |a| (CAR |ISTMP#1|))
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                              (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
             (|hasCate| |a| |b| SL))
            ((AND (CONSP |cond|) (EQ (CAR |cond|) 'AND)
                  (PROGN (SETQ |args| (CDR |cond|)) #1#))
             (PROGN
              ((LAMBDA (|bfVar#139| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#139|)
                        (PROGN (SETQ |x| (CAR |bfVar#139|)) NIL)
                        (EQ S '|failed|))
                    (RETURN NIL))
                   (#1#
                    (SETQ S
                            (COND
                             ((AND (CONSP |x|) (EQ (CAR |x|) '|has|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |x|))
                                    (AND (CONSP |ISTMP#1|)
                                         (PROGN
                                          (SETQ |a| (CAR |ISTMP#1|))
                                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                          (AND (CONSP |ISTMP#2|)
                                               (EQ (CDR |ISTMP#2|) NIL)
                                               (PROGN
                                                (SETQ |b| (CAR |ISTMP#2|))
                                                #1#))))))
                              (|hasCate| |a| |b| SL))
                             ((AND (CONSP |x|) (EQ (CDR |x|) NIL)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CAR |x|))
                                    (AND (CONSP |ISTMP#1|)
                                         (EQ (CAR |ISTMP#1|) '|has|)
                                         (PROGN
                                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                          (AND (CONSP |ISTMP#2|)
                                               (PROGN
                                                (SETQ |a| (CAR |ISTMP#2|))
                                                (SETQ |ISTMP#3|
                                                        (CDR |ISTMP#2|))
                                                (AND (CONSP |ISTMP#3|)
                                                     (EQ (CDR |ISTMP#3|) NIL)
                                                     (PROGN
                                                      (SETQ |b|
                                                              (CAR |ISTMP#3|))
                                                      #1#))))))))
                              (|hasCate| |a| |b| SL))
                             (#1# (|hasCaty1| |x| SL))))))
                  (SETQ |bfVar#139| (CDR |bfVar#139|))))
               |args| NIL)
              S))
            ((AND (CONSP |cond|) (EQ (CAR |cond|) 'OR)
                  (PROGN (SETQ |args| (CDR |cond|)) #1#))
             (PROGN
              ((LAMBDA (|bfVar#140| |x| |bfVar#141|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#140|)
                        (PROGN (SETQ |x| (CAR |bfVar#140|)) NIL) |bfVar#141|)
                    (RETURN NIL))
                   (#1#
                    (SETQ S
                            (COND
                             ((AND (CONSP |x|) (EQ (CAR |x|) '|has|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |x|))
                                    (AND (CONSP |ISTMP#1|)
                                         (PROGN
                                          (SETQ |a| (CAR |ISTMP#1|))
                                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                          (AND (CONSP |ISTMP#2|)
                                               (EQ (CDR |ISTMP#2|) NIL)
                                               (PROGN
                                                (SETQ |b| (CAR |ISTMP#2|))
                                                #1#))))))
                              (|hasCate| |a| |b| (COPY SL)))
                             ((AND (CONSP |x|) (EQ (CDR |x|) NIL)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CAR |x|))
                                    (AND (CONSP |ISTMP#1|)
                                         (EQ (CAR |ISTMP#1|) '|has|)
                                         (PROGN
                                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                          (AND (CONSP |ISTMP#2|)
                                               (PROGN
                                                (SETQ |a| (CAR |ISTMP#2|))
                                                (SETQ |ISTMP#3|
                                                        (CDR |ISTMP#2|))
                                                (AND (CONSP |ISTMP#3|)
                                                     (EQ (CDR |ISTMP#3|) NIL)
                                                     (PROGN
                                                      (SETQ |b|
                                                              (CAR |ISTMP#3|))
                                                      #1#))))))))
                              (|hasCate| |a| |b| (COPY SL)))
                             (#1# (|hasCaty1| |x| (COPY SL)))))))
                  (SETQ |bfVar#140| (CDR |bfVar#140|))
                  (SETQ |bfVar#141| (NULL (EQ S '|failed|)))))
               |args| NIL NIL)
              S))
            (#1#
             (|keyedSystemError| 'S2GE0016
              (LIST "hasCaty1"
                    "unexpected condition from category table"))))))))

; hasAttSig(d,x,SL) ==
;   -- d is domain, x a list of attributes and signatures
;   -- the result is an augmented SL, if d has x, 'failed otherwise
;   for y in x until SL='failed repeat SL:=
;     y is ['ATTRIBUTE,a] => BREAK()
;     y is ['SIGNATURE,foo,s] => hasSig(d,foo,s,SL)
;     keyedSystemError("S2GE0016",
;       ['"hasAttSig",'"unexpected form of unnamed category"])
;   SL

(DEFUN |hasAttSig| (|d| |x| SL)
  (PROG (|ISTMP#1| |a| |foo| |ISTMP#2| |s|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#142| |y| |bfVar#143|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#142|) (PROGN (SETQ |y| (CAR |bfVar#142|)) NIL)
                |bfVar#143|)
            (RETURN NIL))
           (#1='T
            (SETQ SL
                    (COND
                     ((AND (CONSP |y|) (EQ (CAR |y|) 'ATTRIBUTE)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |y|))
                            (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                 (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#))))
                      (BREAK))
                     ((AND (CONSP |y|) (EQ (CAR |y|) 'SIGNATURE)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |y|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |foo| (CAR |ISTMP#1|))
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |s| (CAR |ISTMP#2|))
                                        #1#))))))
                      (|hasSig| |d| |foo| |s| SL))
                     (#1#
                      (|keyedSystemError| 'S2GE0016
                       (LIST "hasAttSig"
                             "unexpected form of unnamed category")))))))
          (SETQ |bfVar#142| (CDR |bfVar#142|))
          (SETQ |bfVar#143| (EQ SL '|failed|))))
       |x| NIL NIL)
      SL))))

; hasSigAnd(andCls, S0, SL) ==
;   dead := NIL
;   SA := 'failed
;   for cls in andCls while not dead repeat
;     SA :=
;       atom cls => copy SL
;       cls is ['has,a,b] =>
;         hasCate(subCopy(a,S0),subCopy(b,S0),copy SL)
;       keyedSystemError("S2GE0016",
;         ['"hasSigAnd",'"unexpected condition for signature"])
;     if SA = 'failed then dead := true
;   SA

(DEFUN |hasSigAnd| (|andCls| S0 SL)
  (PROG (|dead| SA |ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (PROGN
      (SETQ |dead| NIL)
      (SETQ SA '|failed|)
      ((LAMBDA (|bfVar#144| |cls|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#144|) (PROGN (SETQ |cls| (CAR |bfVar#144|)) NIL)
                |dead|)
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ SA
                     (COND ((ATOM |cls|) (COPY SL))
                           ((AND (CONSP |cls|) (EQ (CAR |cls|) '|has|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |cls|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |a| (CAR |ISTMP#1|))
                                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                        (AND (CONSP |ISTMP#2|)
                                             (EQ (CDR |ISTMP#2|) NIL)
                                             (PROGN
                                              (SETQ |b| (CAR |ISTMP#2|))
                                              #1#))))))
                            (|hasCate| (|subCopy| |a| S0) (|subCopy| |b| S0)
                             (COPY SL)))
                           (#1#
                            (|keyedSystemError| 'S2GE0016
                             (LIST "hasSigAnd"
                                   "unexpected condition for signature")))))
             (COND ((EQ SA '|failed|) (SETQ |dead| T))))))
          (SETQ |bfVar#144| (CDR |bfVar#144|))))
       |andCls| NIL)
      SA))))

; hasSigOr(orCls, S0, SL) ==
;   found := NIL
;   SA := 'failed
;   for cls in orCls until found repeat
;     SA :=
;       atom cls => copy SL
;       cls is ['has,a,b] =>
;         hasCate(subCopy(a,S0),subCopy(b,S0),copy SL)
;       cls is ['AND,:andCls] or cls is ['and,:andCls] =>
;         hasSigAnd(andCls, S0, SL)
;       keyedSystemError("S2GE0016",
;         ['"hasSigOr",'"unexpected condition for signature"])
;     if SA ~= 'failed then found := true
;   SA

(DEFUN |hasSigOr| (|orCls| S0 SL)
  (PROG (|found| SA |ISTMP#1| |a| |ISTMP#2| |b| |andCls|)
    (RETURN
     (PROGN
      (SETQ |found| NIL)
      (SETQ SA '|failed|)
      ((LAMBDA (|bfVar#145| |cls| |bfVar#146|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#145|) (PROGN (SETQ |cls| (CAR |bfVar#145|)) NIL)
                |bfVar#146|)
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ SA
                     (COND ((ATOM |cls|) (COPY SL))
                           ((AND (CONSP |cls|) (EQ (CAR |cls|) '|has|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |cls|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |a| (CAR |ISTMP#1|))
                                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                        (AND (CONSP |ISTMP#2|)
                                             (EQ (CDR |ISTMP#2|) NIL)
                                             (PROGN
                                              (SETQ |b| (CAR |ISTMP#2|))
                                              #1#))))))
                            (|hasCate| (|subCopy| |a| S0) (|subCopy| |b| S0)
                             (COPY SL)))
                           ((OR
                             (AND (CONSP |cls|) (EQ (CAR |cls|) 'AND)
                                  (PROGN (SETQ |andCls| (CDR |cls|)) #1#))
                             (AND (CONSP |cls|) (EQ (CAR |cls|) '|and|)
                                  (PROGN (SETQ |andCls| (CDR |cls|)) #1#)))
                            (|hasSigAnd| |andCls| S0 SL))
                           (#1#
                            (|keyedSystemError| 'S2GE0016
                             (LIST "hasSigOr"
                                   "unexpected condition for signature")))))
             (COND ((NOT (EQ SA '|failed|)) (SETQ |found| T))))))
          (SETQ |bfVar#145| (CDR |bfVar#145|))
          (SETQ |bfVar#146| |found|)))
       |orCls| NIL NIL)
      SA))))

; hasSig(dom,foo,sig,SL) ==
;   -- tests whether domain dom has function foo with signature sig
;   -- under substitution SL
;   $domPvar: local := nil
;   fun := constructor? first dom =>
;     S0:= constructSubst dom
;     p := ASSQ(foo, getOperationAlistFromLisplib first dom) =>
;       for [x, ., cond, .] in rest p until not (S = 'failed) repeat
;         S:=
;           atom cond => copy SL
;           cond is ['has,a,b] =>
;             hasCate(subCopy(a,S0),subCopy(b,S0),copy SL)
;           cond is ['AND,:andCls] or cond is ['and,:andCls] =>
;             hasSigAnd(andCls, S0, SL)
;           cond is ['OR,:orCls] or cond is ['or,:orCls] =>
;             hasSigOr(orCls, S0, SL)
;           keyedSystemError("S2GE0016",
;              ['"hasSig",'"unexpected condition for signature"])
;         not (S='failed) => S:= unifyStruct(subCopy(x,S0),sig,S)
;       S
;     'failed
;   'failed

(DEFUN |hasSig| (|dom| |foo| |sig| SL)
  (PROG (|$domPvar| S |orCls| |andCls| |b| |a| |ISTMP#3| |cond| |ISTMP#2|
         |ISTMP#1| |x| |p| S0 |fun|)
    (DECLARE (SPECIAL |$domPvar|))
    (RETURN
     (PROGN
      (SETQ |$domPvar| NIL)
      (COND
       ((SETQ |fun| (|constructor?| (CAR |dom|)))
        (PROGN
         (SETQ S0 (|constructSubst| |dom|))
         (COND
          ((SETQ |p| (ASSQ |foo| (|getOperationAlistFromLisplib| (CAR |dom|))))
           (PROGN
            ((LAMBDA (|bfVar#148| |bfVar#147| |bfVar#149|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#148|)
                      (PROGN (SETQ |bfVar#147| (CAR |bfVar#148|)) NIL)
                      |bfVar#149|)
                  (RETURN NIL))
                 (#1='T
                  (AND (CONSP |bfVar#147|)
                       (PROGN
                        (SETQ |x| (CAR |bfVar#147|))
                        (SETQ |ISTMP#1| (CDR |bfVar#147|))
                        (AND (CONSP |ISTMP#1|)
                             (PROGN
                              (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                              (AND (CONSP |ISTMP#2|)
                                   (PROGN
                                    (SETQ |cond| (CAR |ISTMP#2|))
                                    (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                    (AND (CONSP |ISTMP#3|)
                                         (EQ (CDR |ISTMP#3|) NIL)))))))
                       (PROGN
                        (SETQ S
                                (COND ((ATOM |cond|) (COPY SL))
                                      ((AND (CONSP |cond|)
                                            (EQ (CAR |cond|) '|has|)
                                            (PROGN
                                             (SETQ |ISTMP#1| (CDR |cond|))
                                             (AND (CONSP |ISTMP#1|)
                                                  (PROGN
                                                   (SETQ |a| (CAR |ISTMP#1|))
                                                   (SETQ |ISTMP#2|
                                                           (CDR |ISTMP#1|))
                                                   (AND (CONSP |ISTMP#2|)
                                                        (EQ (CDR |ISTMP#2|)
                                                            NIL)
                                                        (PROGN
                                                         (SETQ |b|
                                                                 (CAR
                                                                  |ISTMP#2|))
                                                         #1#))))))
                                       (|hasCate| (|subCopy| |a| S0)
                                        (|subCopy| |b| S0) (COPY SL)))
                                      ((OR
                                        (AND (CONSP |cond|)
                                             (EQ (CAR |cond|) 'AND)
                                             (PROGN
                                              (SETQ |andCls| (CDR |cond|))
                                              #1#))
                                        (AND (CONSP |cond|)
                                             (EQ (CAR |cond|) '|and|)
                                             (PROGN
                                              (SETQ |andCls| (CDR |cond|))
                                              #1#)))
                                       (|hasSigAnd| |andCls| S0 SL))
                                      ((OR
                                        (AND (CONSP |cond|)
                                             (EQ (CAR |cond|) 'OR)
                                             (PROGN
                                              (SETQ |orCls| (CDR |cond|))
                                              #1#))
                                        (AND (CONSP |cond|)
                                             (EQ (CAR |cond|) '|or|)
                                             (PROGN
                                              (SETQ |orCls| (CDR |cond|))
                                              #1#)))
                                       (|hasSigOr| |orCls| S0 SL))
                                      (#1#
                                       (|keyedSystemError| 'S2GE0016
                                        (LIST "hasSig"
                                              "unexpected condition for signature")))))
                        (COND
                         ((NULL (EQ S '|failed|))
                          (SETQ S
                                  (|unifyStruct| (|subCopy| |x| S0) |sig|
                                   S))))))))
                (SETQ |bfVar#148| (CDR |bfVar#148|))
                (SETQ |bfVar#149| (NULL (EQ S '|failed|)))))
             (CDR |p|) NIL NIL)
            S))
          (#1# '|failed|))))
       (#1# '|failed|))))))

; hasCatExpression(cond,SL) ==
;   cond is ['OR,:l] =>
;     or/[(y:=hasCatExpression(x,SL)) ~= 'failed for x in l] => y
;   cond is ['AND,:l] =>
;     and/[(SL:= hasCatExpression(x,SL)) ~= 'failed for x in l] => SL
;   cond is ['has,a,b] => hasCate(a,b,SL)
;   keyedSystemError("S2GE0016",
;     ['"hasSig",'"unexpected condition for attribute"])

(DEFUN |hasCatExpression| (|cond| SL)
  (PROG (|l| |y| |ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (COND
      ((AND (CONSP |cond|) (EQ (CAR |cond|) 'OR)
            (PROGN (SETQ |l| (CDR |cond|)) #1='T))
       (COND
        (((LAMBDA (|bfVar#151| |bfVar#150| |x|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#150|) (PROGN (SETQ |x| (CAR |bfVar#150|)) NIL))
               (RETURN |bfVar#151|))
              (#1#
               (PROGN
                (SETQ |bfVar#151|
                        (NOT
                         (EQ (SETQ |y| (|hasCatExpression| |x| SL))
                             '|failed|)))
                (COND (|bfVar#151| (RETURN |bfVar#151|))))))
             (SETQ |bfVar#150| (CDR |bfVar#150|))))
          NIL |l| NIL)
         (IDENTITY |y|))))
      ((AND (CONSP |cond|) (EQ (CAR |cond|) 'AND)
            (PROGN (SETQ |l| (CDR |cond|)) #1#))
       (COND
        (((LAMBDA (|bfVar#153| |bfVar#152| |x|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#152|) (PROGN (SETQ |x| (CAR |bfVar#152|)) NIL))
               (RETURN |bfVar#153|))
              (#1#
               (PROGN
                (SETQ |bfVar#153|
                        (NOT
                         (EQ (SETQ SL (|hasCatExpression| |x| SL)) '|failed|)))
                (COND ((NOT |bfVar#153|) (RETURN NIL))))))
             (SETQ |bfVar#152| (CDR |bfVar#152|))))
          T |l| NIL)
         (IDENTITY SL))))
      ((AND (CONSP |cond|) (EQ (CAR |cond|) '|has|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |cond|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
       (|hasCate| |a| |b| SL))
      (#1#
       (|keyedSystemError| 'S2GE0016
        (LIST "hasSig" "unexpected condition for attribute")))))))

; unifyStruct(s1,s2,SL) ==
;   -- tests for equality of s1 and s2 under substitutions SL and $Subst
;   -- the result is a substitution list or 'failed
;   s1=s2 => SL
;   if s1 is ['_:,x,.] then s1:= x
;   if s2 is ['_:,x,.] then s2:= x
;   if not atom s1 and first s1 = '_# then s1 := LENGTH CADR s1
;   if not atom s2 and first s2 = '_# then s2 := LENGTH CADR s2
;   s1=s2 => SL
;   isPatternVar s1 => unifyStructVar(s1,s2,SL)
;   isPatternVar s2 => unifyStructVar(s2,s1,SL)
;   atom s1 or atom s2 => 'failed
;   until null s1 or null s2 or SL='failed repeat
;     SL := unifyStruct(first s1, first s2, SL)
;     s1 := rest s1
;     s2 := rest s2
;     atom s1 =>
;         if s1 = s2 then s2 := nil
;         s1 := nil
;     atom s2 => s2 := nil
;   s1 or s2 => 'failed
;   SL

(DEFUN |unifyStruct| (|s1| |s2| SL)
  (PROG (|ISTMP#1| |x| |ISTMP#2|)
    (RETURN
     (COND ((EQUAL |s1| |s2|) SL)
           (#1='T
            (PROGN
             (COND
              ((AND (CONSP |s1|) (EQ (CAR |s1|) '|:|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |s1|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |x| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL))))))
               (SETQ |s1| |x|)))
             (COND
              ((AND (CONSP |s2|) (EQ (CAR |s2|) '|:|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |s2|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |x| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL))))))
               (SETQ |s2| |x|)))
             (COND
              ((AND (NULL (ATOM |s1|)) (EQ (CAR |s1|) '|#|))
               (SETQ |s1| (LENGTH (CADR |s1|)))))
             (COND
              ((AND (NULL (ATOM |s2|)) (EQ (CAR |s2|) '|#|))
               (SETQ |s2| (LENGTH (CADR |s2|)))))
             (COND ((EQUAL |s1| |s2|) SL)
                   ((|isPatternVar| |s1|) (|unifyStructVar| |s1| |s2| SL))
                   ((|isPatternVar| |s2|) (|unifyStructVar| |s2| |s1| SL))
                   ((OR (ATOM |s1|) (ATOM |s2|)) '|failed|)
                   (#1#
                    (PROGN
                     ((LAMBDA (|bfVar#154|)
                        (LOOP
                         (COND (|bfVar#154| (RETURN NIL))
                               (#1#
                                (PROGN
                                 (SETQ SL
                                         (|unifyStruct| (CAR |s1|) (CAR |s2|)
                                          SL))
                                 (SETQ |s1| (CDR |s1|))
                                 (SETQ |s2| (CDR |s2|))
                                 (COND
                                  ((ATOM |s1|)
                                   (PROGN
                                    (COND ((EQUAL |s1| |s2|) (SETQ |s2| NIL)))
                                    (SETQ |s1| NIL)))
                                  ((ATOM |s2|) (SETQ |s2| NIL))))))
                         (SETQ |bfVar#154|
                                 (OR (NULL |s1|) (NULL |s2|)
                                     (EQ SL '|failed|)))))
                      NIL)
                     (COND ((OR |s1| |s2|) '|failed|) (#1# SL)))))))))))

; unifyStructVar(v,s,SL) ==
;   -- the first argument is a pattern variable, which is not substituted
;   -- by SL
;   CONTAINED(v,s) => 'failed
;   ps := LASSOC(s, SL)
;   s1 := (ps => ps; s)
;   (s0 := LASSOC(v, SL)) or (s0 := LASSOC(v,$Subst)) =>
;     S:= unifyStruct(s0,s1,copy SL)
;     S='failed =>
;       $Coerce and not atom s0 and constructor? first s0 =>
;         containsVars s0 or containsVars s1 =>
;           ns0 := subCopy(s0, SL)
;           ns1 := subCopy(s1, SL)
;           containsVars ns0 or containsVars ns1 =>
;             $hope:= 'T
;             'failed
;           if canCoerce(ns0, ns1) then s3 := s1
;           else if canCoerce(ns1, ns0) then s3 := s0
;           else s3 := nil
;           s3 =>
;             if (s3 ~= s0) then SL := augmentSub(v,s3,SL)
;             if (s3 ~= s1) and isPatternVar(s) then SL := augmentSub(s,s3,SL)
;             SL
;           'failed
;         $domPvar =>
;           s3 := resolveTT(s0,s1)
;           s3 =>
;             if (s3 ~= s0) then SL := augmentSub(v,s3,SL)
;             if (s3 ~= s1) and isPatternVar(s) then SL := augmentSub(s,s3,SL)
;             SL
;           'failed
; --        isSubDomain(s,s0) => augmentSub(v,s0,SL)
;         'failed
;       'failed
;     augmentSub(v,s,S)
;   augmentSub(v,s,SL)

(DEFUN |unifyStructVar| (|v| |s| SL)
  (PROG (|ps| |s1| |s0| S |ns0| |ns1| |s3|)
    (RETURN
     (COND ((CONTAINED |v| |s|) '|failed|)
           (#1='T
            (PROGN
             (SETQ |ps| (LASSOC |s| SL))
             (SETQ |s1| (COND (|ps| |ps|) (#1# |s|)))
             (COND
              ((OR (SETQ |s0| (LASSOC |v| SL))
                   (SETQ |s0| (LASSOC |v| |$Subst|)))
               (PROGN
                (SETQ S (|unifyStruct| |s0| |s1| (COPY SL)))
                (COND
                 ((EQ S '|failed|)
                  (COND
                   ((AND |$Coerce| (NULL (ATOM |s0|))
                         (|constructor?| (CAR |s0|)))
                    (COND
                     ((OR (|containsVars| |s0|) (|containsVars| |s1|))
                      (PROGN
                       (SETQ |ns0| (|subCopy| |s0| SL))
                       (SETQ |ns1| (|subCopy| |s1| SL))
                       (COND
                        ((OR (|containsVars| |ns0|) (|containsVars| |ns1|))
                         (PROGN (SETQ |$hope| 'T) '|failed|))
                        (#1#
                         (PROGN
                          (COND ((|canCoerce| |ns0| |ns1|) (SETQ |s3| |s1|))
                                ((|canCoerce| |ns1| |ns0|) (SETQ |s3| |s0|))
                                (#1# (SETQ |s3| NIL)))
                          (COND
                           (|s3|
                            (PROGN
                             (COND
                              ((NOT (EQUAL |s3| |s0|))
                               (SETQ SL (|augmentSub| |v| |s3| SL))))
                             (COND
                              ((AND (NOT (EQUAL |s3| |s1|))
                                    (|isPatternVar| |s|))
                               (SETQ SL (|augmentSub| |s| |s3| SL))))
                             SL))
                           (#1# '|failed|)))))))
                     (|$domPvar|
                      (PROGN
                       (SETQ |s3| (|resolveTT| |s0| |s1|))
                       (COND
                        (|s3|
                         (PROGN
                          (COND
                           ((NOT (EQUAL |s3| |s0|))
                            (SETQ SL (|augmentSub| |v| |s3| SL))))
                          (COND
                           ((AND (NOT (EQUAL |s3| |s1|)) (|isPatternVar| |s|))
                            (SETQ SL (|augmentSub| |s| |s3| SL))))
                          SL))
                        (#1# '|failed|))))
                     (#1# '|failed|)))
                   (#1# '|failed|)))
                 (#1# (|augmentSub| |v| |s| S)))))
              (#1# (|augmentSub| |v| |s| SL)))))))))

; ofCategory(dom,cat) ==
;   -- entry point to category evaluation from other points than type
;   --   analysis
;   -- the result is true or NIL
;   $Subst:local:= NIL
;   $hope:local := NIL
;   IDENTP dom => NIL
;   cat is ['Join,:cats] => and/[ofCategory(dom,c) for c in cats]
;   (hasCaty(dom,cat,NIL) ~= 'failed)

(DEFUN |ofCategory| (|dom| |cat|)
  (PROG (|$hope| |$Subst| |cats|)
    (DECLARE (SPECIAL |$hope| |$Subst|))
    (RETURN
     (PROGN
      (SETQ |$Subst| NIL)
      (SETQ |$hope| NIL)
      (COND ((IDENTP |dom|) NIL)
            ((AND (CONSP |cat|) (EQ (CAR |cat|) '|Join|)
                  (PROGN (SETQ |cats| (CDR |cat|)) #1='T))
             ((LAMBDA (|bfVar#156| |bfVar#155| |c|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#155|)
                       (PROGN (SETQ |c| (CAR |bfVar#155|)) NIL))
                   (RETURN |bfVar#156|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#156| (|ofCategory| |dom| |c|))
                    (COND ((NOT |bfVar#156|) (RETURN NIL))))))
                 (SETQ |bfVar#155| (CDR |bfVar#155|))))
              T |cats| NIL))
            (#1# (NOT (EQ (|hasCaty| |dom| |cat| NIL) '|failed|))))))))

; printMms(mmS) ==
;   -- mmS a list of modemap signatures
;   sayMSG '" "
;   for [sig,imp,.] in mmS for i in 1.. repeat
;     istr := STRCONC('"[",STRINGIMAGE i,'"]")
;     if QCSIZE(istr) = 3 then istr := STRCONC(istr,'" ")
;     sayMSG [:bright istr, '"signature:   ", :formatSignature rest sig]
;     first sig = 'local =>
;       sayMSG ['"      implemented: local function ",imp]
;     imp is ['XLAM,:.] =>
;       sayMSG concat('"      implemented: XLAM from ",
;         prefix2String first sig)
;     sayMSG concat('"      implemented: slot ",imp,
;       '" from ", prefix2String first sig)
;   sayMSG '" "

(DEFUN |printMms| (|mmS|)
  (PROG (|sig| |ISTMP#1| |imp| |ISTMP#2| |istr|)
    (RETURN
     (PROGN
      (|sayMSG| " ")
      ((LAMBDA (|bfVar#158| |bfVar#157| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#158|)
                (PROGN (SETQ |bfVar#157| (CAR |bfVar#158|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#157|)
                 (PROGN
                  (SETQ |sig| (CAR |bfVar#157|))
                  (SETQ |ISTMP#1| (CDR |bfVar#157|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |imp| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)))))
                 (PROGN
                  (SETQ |istr| (STRCONC "[" (STRINGIMAGE |i|) "]"))
                  (COND
                   ((EQL (QCSIZE |istr|) 3)
                    (SETQ |istr| (STRCONC |istr| " "))))
                  (|sayMSG|
                   (APPEND (|bright| |istr|)
                           (CONS "signature:   "
                                 (|formatSignature| (CDR |sig|)))))
                  (COND
                   ((EQ (CAR |sig|) '|local|)
                    (|sayMSG|
                     (LIST "      implemented: local function " |imp|)))
                   ((AND (CONSP |imp|) (EQ (CAR |imp|) 'XLAM))
                    (|sayMSG|
                     (|concat| "      implemented: XLAM from "
                      (|prefix2String| (CAR |sig|)))))
                   (#1#
                    (|sayMSG|
                     (|concat| "      implemented: slot " |imp| " from "
                      (|prefix2String| (CAR |sig|))))))))))
          (SETQ |bfVar#158| (CDR |bfVar#158|))
          (SETQ |i| (+ |i| 1))))
       |mmS| NIL 1)
      (|sayMSG| " ")))))

; containsVars(t) ==
;   -- tests whether term t contains a * variable
;   atom t => isPatternVar t
;   containsVars1(t)

(DEFUN |containsVars| (|t|)
  (PROG ()
    (RETURN
     (COND ((ATOM |t|) (|isPatternVar| |t|)) ('T (|containsVars1| |t|))))))

; containsVars1(t) ==
;   -- recursive version, which works on a list
;   [t1,:t2]:= t
;   atom t1 =>
;     isPatternVar t1 or
;       atom t2 => isPatternVar t2
;       containsVars1(t2)
;   containsVars1(t1) or
;     atom t2 => isPatternVar t2
;     containsVars1(t2)

(DEFUN |containsVars1| (|t|)
  (PROG (|t1| |t2|)
    (RETURN
     (PROGN
      (SETQ |t1| (CAR |t|))
      (SETQ |t2| (CDR |t|))
      (COND
       ((ATOM |t1|)
        (OR (|isPatternVar| |t1|)
            (COND ((ATOM |t2|) (|isPatternVar| |t2|))
                  (#1='T (|containsVars1| |t2|)))))
       (#1#
        (OR (|containsVars1| |t1|)
            (COND ((ATOM |t2|) (|isPatternVar| |t2|))
                  (#1# (|containsVars1| |t2|))))))))))

; isPartialMode m ==
;   CONTAINED($EmptyMode,m)

(DEFUN |isPartialMode| (|m|) (PROG () (RETURN (CONTAINED |$EmptyMode| |m|))))

; getSymbolType var ==
; -- var is a pattern variable
;   p := ASSQ(var, $SymbolType) => rest p
;   t:= '(Polynomial (Integer))
;   $SymbolType:= CONS(CONS(var,t),$SymbolType)
;   t

(DEFUN |getSymbolType| (|var|)
  (PROG (|p| |t|)
    (RETURN
     (COND ((SETQ |p| (ASSQ |var| |$SymbolType|)) (CDR |p|))
           ('T
            (PROGN
             (SETQ |t| '(|Polynomial| (|Integer|)))
             (SETQ |$SymbolType| (CONS (CONS |var| |t|) |$SymbolType|))
             |t|))))))

; isEqualOrSubDomain(d1,d2) ==
;   -- last 2 parts are for tagged unions (hack for now, RSS)
;   (d1=d2) or isSubDomain(d1,d2) or
;     (atom(d1) and ((d2 is ['Variable,=d1]) or (d2 is [=d1])))
;      or (atom(d2) and ((d1 is ['Variable,=d2]) or (d1 is [=d2])))

(DEFUN |isEqualOrSubDomain| (|d1| |d2|)
  (PROG (|ISTMP#1|)
    (RETURN
     (OR (EQUAL |d1| |d2|) (|isSubDomain| |d1| |d2|)
         (AND (ATOM |d1|)
              (OR
               (AND (CONSP |d2|) (EQ (CAR |d2|) '|Variable|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |d2|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (EQUAL (CAR |ISTMP#1|) |d1|))))
               (AND (CONSP |d2|) (EQ (CDR |d2|) NIL) (EQUAL (CAR |d2|) |d1|))))
         (AND (ATOM |d2|)
              (OR
               (AND (CONSP |d1|) (EQ (CAR |d1|) '|Variable|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |d1|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (EQUAL (CAR |ISTMP#1|) |d2|))))
               (AND (CONSP |d1|) (EQ (CDR |d1|) NIL)
                    (EQUAL (CAR |d1|) |d2|))))))))

; defaultTypeForCategory(cat, SL) ==
;   -- this function returns a domain belonging to cat
;   -- note that it is important to note that in some contexts one
;   -- might not want to use this result. For example, evalMmCat1
;   -- calls this and should possibly fail in some cases.
;   cat := subCopy(cat, SL)
;   c := first cat
;   d := GETDATABASE(c, 'DEFAULTDOMAIN)
;   d => [d, :rest cat]
;   cat is [c] =>
;     c = 'Field => $RationalNumber
;     c in '(Ring IntegralDomain EuclideanDomain GcdDomain
;       OrderedRing DifferentialRing) => '(Integer)
;     c = 'OrderedSet => $Symbol
;     c = 'FloatingPointSystem => '(Float)
;     NIL
;   cat is [c,p1] =>
;     c = 'FiniteLinearAggregate => ['Vector, p1]
;     c = 'VectorCategory => ['Vector, p1]
;     c = 'SetAggregate => ['Set, p1]
;     c = 'SegmentCategory => ['Segment, p1]
;     NIL
;   cat is [c,p1,p2] =>
;     NIL
;   cat is [c,p1,p2,p3] =>
;     cat is ['MatrixCategory, d, ['Vector, =d], ['Vector, =d]] =>
;       ['Matrix, d]
;     NIL
;   NIL

(DEFUN |defaultTypeForCategory| (|cat| SL)
  (PROG (|c| |d| |ISTMP#1| |p1| |ISTMP#2| |p2| |ISTMP#3| |p3| |ISTMP#4|
         |ISTMP#5| |ISTMP#6| |ISTMP#7|)
    (RETURN
     (PROGN
      (SETQ |cat| (|subCopy| |cat| SL))
      (SETQ |c| (CAR |cat|))
      (SETQ |d| (GETDATABASE |c| 'DEFAULTDOMAIN))
      (COND (|d| (CONS |d| (CDR |cat|)))
            ((AND (CONSP |cat|) (EQ (CDR |cat|) NIL)
                  (PROGN (SETQ |c| (CAR |cat|)) #1='T))
             (COND ((EQ |c| '|Field|) |$RationalNumber|)
                   ((|member| |c|
                     '(|Ring| |IntegralDomain| |EuclideanDomain| |GcdDomain|
                       |OrderedRing| |DifferentialRing|))
                    '(|Integer|))
                   ((EQ |c| '|OrderedSet|) |$Symbol|)
                   ((EQ |c| '|FloatingPointSystem|) '(|Float|)) (#1# NIL)))
            ((AND (CONSP |cat|)
                  (PROGN
                   (SETQ |c| (CAR |cat|))
                   (SETQ |ISTMP#1| (CDR |cat|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ |p1| (CAR |ISTMP#1|)) #1#))))
             (COND ((EQ |c| '|FiniteLinearAggregate|) (LIST '|Vector| |p1|))
                   ((EQ |c| '|VectorCategory|) (LIST '|Vector| |p1|))
                   ((EQ |c| '|SetAggregate|) (LIST '|Set| |p1|))
                   ((EQ |c| '|SegmentCategory|) (LIST '|Segment| |p1|))
                   (#1# NIL)))
            ((AND (CONSP |cat|)
                  (PROGN
                   (SETQ |c| (CAR |cat|))
                   (SETQ |ISTMP#1| (CDR |cat|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |p1| (CAR |ISTMP#1|))
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                              (PROGN (SETQ |p2| (CAR |ISTMP#2|)) #1#))))))
             NIL)
            ((AND (CONSP |cat|)
                  (PROGN
                   (SETQ |c| (CAR |cat|))
                   (SETQ |ISTMP#1| (CDR |cat|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |p1| (CAR |ISTMP#1|))
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN
                               (SETQ |p2| (CAR |ISTMP#2|))
                               (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                               (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                    (PROGN
                                     (SETQ |p3| (CAR |ISTMP#3|))
                                     #1#))))))))
             (COND
              ((AND (CONSP |cat|) (EQ (CAR |cat|) '|MatrixCategory|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |cat|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |d| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (PROGN
                                 (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CAR |ISTMP#3|) '|Vector|)
                                      (PROGN
                                       (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                       (AND (CONSP |ISTMP#4|)
                                            (EQ (CDR |ISTMP#4|) NIL)
                                            (EQUAL (CAR |ISTMP#4|) |d|)))))
                                (PROGN
                                 (SETQ |ISTMP#5| (CDR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#5|)
                                      (EQ (CDR |ISTMP#5|) NIL)
                                      (PROGN
                                       (SETQ |ISTMP#6| (CAR |ISTMP#5|))
                                       (AND (CONSP |ISTMP#6|)
                                            (EQ (CAR |ISTMP#6|) '|Vector|)
                                            (PROGN
                                             (SETQ |ISTMP#7| (CDR |ISTMP#6|))
                                             (AND (CONSP |ISTMP#7|)
                                                  (EQ (CDR |ISTMP#7|) NIL)
                                                  (EQUAL (CAR |ISTMP#7|)
                                                         |d|))))))))))))
               (LIST '|Matrix| |d|))
              (#1# NIL)))
            (#1# NIL))))))


; )package "BOOT"

(IN-PACKAGE "BOOT")

; resolveTypeList u ==
;   u is [a,:tail] =>
;
;     -- if the list consists entirely of variables then keep it explicit
;     allVars :=
;       a is ['Variable,v] => [v]
;       nil
;     while allVars for b in tail repeat
;         allVars :=
;             b is ['Variable,v] => insert(v, allVars)
;             nil
;     allVars =>
;         null rest allVars => ['Variable, first allVars]
;         ['OrderedVariableList,nreverse allVars]
;
;     for md in tail repeat
;       a := resolveTT(md,a)
;       null a => return nil
;     a
;   throwKeyedMsg("S2IR0002",NIL)

(DEFUN |resolveTypeList| (|u|)
  (PROG (|a| |tail| |ISTMP#1| |v| |allVars|)
    (RETURN
     (COND
      ((AND (CONSP |u|)
            (PROGN (SETQ |a| (CAR |u|)) (SETQ |tail| (CDR |u|)) #1='T))
       (PROGN
        (SETQ |allVars|
                (COND
                 ((AND (CONSP |a|) (EQ (CAR |a|) '|Variable|)
                       (PROGN
                        (SETQ |ISTMP#1| (CDR |a|))
                        (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                             (PROGN (SETQ |v| (CAR |ISTMP#1|)) #1#))))
                  (LIST |v|))
                 (#1# NIL)))
        ((LAMBDA (|bfVar#1| |b|)
           (LOOP
            (COND
             ((OR (NOT |allVars|) (ATOM |bfVar#1|)
                  (PROGN (SETQ |b| (CAR |bfVar#1|)) NIL))
              (RETURN NIL))
             (#1#
              (SETQ |allVars|
                      (COND
                       ((AND (CONSP |b|) (EQ (CAR |b|) '|Variable|)
                             (PROGN
                              (SETQ |ISTMP#1| (CDR |b|))
                              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                   (PROGN (SETQ |v| (CAR |ISTMP#1|)) #1#))))
                        (|insert| |v| |allVars|))
                       (#1# NIL)))))
            (SETQ |bfVar#1| (CDR |bfVar#1|))))
         |tail| NIL)
        (COND
         (|allVars|
          (COND ((NULL (CDR |allVars|)) (LIST '|Variable| (CAR |allVars|)))
                (#1# (LIST '|OrderedVariableList| (NREVERSE |allVars|)))))
         (#1#
          (PROGN
           ((LAMBDA (|bfVar#2| |md|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#2|) (PROGN (SETQ |md| (CAR |bfVar#2|)) NIL))
                 (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |a| (|resolveTT| |md| |a|))
                  (COND ((NULL |a|) (RETURN NIL))))))
               (SETQ |bfVar#2| (CDR |bfVar#2|))))
            |tail| NIL)
           |a|)))))
      (#1# (|throwKeyedMsg| 'S2IR0002 NIL))))))

; resolveTypeListAny tl ==
;   rt := resolveTypeList tl
;   null rt => $Any
;   rt

(DEFUN |resolveTypeListAny| (|tl|)
  (PROG (|rt|)
    (RETURN
     (PROGN
      (SETQ |rt| (|resolveTypeList| |tl|))
      (COND ((NULL |rt|) |$Any|) ('T |rt|))))))

; resolveTTAny(t1,t2) ==
;   (t3 := resolveTT(t1, t2)) => t3
;   $Any

(DEFUN |resolveTTAny| (|t1| |t2|)
  (PROG (|t3|)
    (RETURN (COND ((SETQ |t3| (|resolveTT| |t1| |t2|)) |t3|) ('T |$Any|)))))

; resolveTT1(t1,t2) ==
;   -- this is the main symmetric resolve
;   -- first it looks for equal constructors on both sides
;   -- then it tries to use a rewrite rule
;   -- and finally it builds up a tower
;   t1=t2 => t1
;   (t1 = '$NoValueMode) or (t2 = '$NoValueMode) => NIL
;   (t1 = $Void) or (t2 = $Void) => $Void
;   (t1 = $Any) or (t2 = $Any) => $Any
;   t1 = '(Exit) => t2
;   t2 = '(Exit) => t1
;   t1 is ['Union,:.] => resolveTTUnion(t1,t2)
;   t2 is ['Union,:.] => resolveTTUnion(t2,t1)
;   STRINGP(t1) =>
;     t2 = $String => t2
;     NIL
;   STRINGP(t2) =>
;     t1 = $String => t1
;     NIL
;   if compareTT(t1,t2) then
;      t := t1
;      t1 := t2
;      t2 := t
;   (t := resolveTTSpecial(t1,t2)) and isValidType t => t
;   (t := resolveTTSpecial(t2,t1)) and isValidType t => t
;   isSubTowerOf(t1,t2) and canCoerceFrom(t1,t2) => t2
;   isSubTowerOf(t2,t1) and canCoerceFrom(t2,t1) => t1
;   t := resolveTTRed(t1,t2) => t
;   t := resolveTTCC(t1,t2) => t
;   (t := resolveTTEq(t1,t2)) and isValidType t => t
;   [c1,:arg1] := deconstructT t1
;   arg1 and
;     [c2,:arg2] := deconstructT t2
;     arg2 and
;       t := resolveTT1(last arg1,last arg2)
;       t and ( resolveTT2(c1,c2,arg1,arg2,t) or
;         resolveTT2(c2,c1,arg2,arg1,t) )

(DEFUN |resolveTT1| (|t1| |t2|)
  (PROG (|t| |LETTMP#1| |c1| |arg1| |c2| |arg2|)
    (RETURN
     (COND ((EQUAL |t1| |t2|) |t1|)
           ((OR (EQ |t1| '|$NoValueMode|) (EQ |t2| '|$NoValueMode|)) NIL)
           ((OR (EQUAL |t1| |$Void|) (EQUAL |t2| |$Void|)) |$Void|)
           ((OR (EQUAL |t1| |$Any|) (EQUAL |t2| |$Any|)) |$Any|)
           ((EQUAL |t1| '(|Exit|)) |t2|) ((EQUAL |t2| '(|Exit|)) |t1|)
           ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Union|))
            (|resolveTTUnion| |t1| |t2|))
           ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Union|))
            (|resolveTTUnion| |t2| |t1|))
           ((STRINGP |t1|) (COND ((EQUAL |t2| |$String|) |t2|) (#1='T NIL)))
           ((STRINGP |t2|) (COND ((EQUAL |t1| |$String|) |t1|) (#1# NIL)))
           (#1#
            (PROGN
             (COND
              ((|compareTT| |t1| |t2|) (SETQ |t| |t1|) (SETQ |t1| |t2|)
               (SETQ |t2| |t|)))
             (COND
              ((AND (SETQ |t| (|resolveTTSpecial| |t1| |t2|))
                    (|isValidType| |t|))
               |t|)
              ((AND (SETQ |t| (|resolveTTSpecial| |t2| |t1|))
                    (|isValidType| |t|))
               |t|)
              ((AND (|isSubTowerOf| |t1| |t2|) (|canCoerceFrom| |t1| |t2|))
               |t2|)
              ((AND (|isSubTowerOf| |t2| |t1|) (|canCoerceFrom| |t2| |t1|))
               |t1|)
              ((SETQ |t| (|resolveTTRed| |t1| |t2|)) |t|)
              ((SETQ |t| (|resolveTTCC| |t1| |t2|)) |t|)
              ((AND (SETQ |t| (|resolveTTEq| |t1| |t2|)) (|isValidType| |t|))
               |t|)
              (#1#
               (PROGN
                (SETQ |LETTMP#1| (|deconstructT| |t1|))
                (SETQ |c1| (CAR |LETTMP#1|))
                (SETQ |arg1| (CDR |LETTMP#1|))
                (AND |arg1|
                     (PROGN
                      (SETQ |LETTMP#1| (|deconstructT| |t2|))
                      (SETQ |c2| (CAR |LETTMP#1|))
                      (SETQ |arg2| (CDR |LETTMP#1|))
                      (AND |arg2|
                           (PROGN
                            (SETQ |t|
                                    (|resolveTT1| (|last| |arg1|)
                                     (|last| |arg2|)))
                            (AND |t|
                                 (OR (|resolveTT2| |c1| |c2| |arg1| |arg2| |t|)
                                     (|resolveTT2| |c2| |c1| |arg2| |arg1|
                                      |t|))))))))))))))))

; resolveTT2(c1,c2,arg1,arg2,t) ==
;   -- builds a tower and tests for all the necessary coercions
;   t0 := constructM(c2,replaceLast(arg2,t))
;   canCoerceFrom(t,t0) and
;     t1 := constructM(c1,replaceLast(arg1,t0))
;     canCoerceFrom(t0,t1) and t1

(DEFUN |resolveTT2| (|c1| |c2| |arg1| |arg2| |t|)
  (PROG (|t0| |t1|)
    (RETURN
     (PROGN
      (SETQ |t0| (|constructM| |c2| (|replaceLast| |arg2| |t|)))
      (AND (|canCoerceFrom| |t| |t0|)
           (PROGN
            (SETQ |t1| (|constructM| |c1| (|replaceLast| |arg1| |t0|)))
            (AND (|canCoerceFrom| |t0| |t1|) |t1|)))))))

; resolveTTUnion(t1 is ['Union,:doms],t2) ==
;   unionDoms1 :=
;     doms and first doms is [":",:.] =>
;       tagged := true
;       [t for [.,.,t] in doms]
;     tagged := false
;     doms
;   member(t2,unionDoms1) => t1
;   tagged => NIL
;   t2 isnt ['Union,:doms2] =>
;     ud := nil
;     bad := nil
;     for d in doms while not bad repeat
;       d = '"failed" => ud := [d,:ud]
;       null (d' := resolveTT(d,t2)) => bad := true
;       ud := [d',:ud]
;     bad => NIL
;     ['Union,:REMDUP reverse ud]
;   ud := nil
;   bad := nil
;   for d in doms2 while not bad repeat
;     d = '"failed" => ud := append(ud,[d])
;     null (d' := resolveTTUnion(t1,d)) => bad := true
;     ud := append(ud, rest d')
;   bad => NIL
;   ['Union,:REMDUP ud]

(DEFUN |resolveTTUnion| (|t1| |t2|)
  (PROG (|doms| |ISTMP#1| |tagged| |ISTMP#2| |t| |unionDoms1| |doms2| |ud|
         |bad| |d'|)
    (RETURN
     (PROGN
      (SETQ |doms| (CDR |t1|))
      (SETQ |unionDoms1|
              (COND
               ((AND |doms|
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |doms|))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|))))
                (PROGN
                 (SETQ |tagged| T)
                 ((LAMBDA (|bfVar#5| |bfVar#4| |bfVar#3|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#4|)
                           (PROGN (SETQ |bfVar#3| (CAR |bfVar#4|)) NIL))
                       (RETURN (NREVERSE |bfVar#5|)))
                      (#1='T
                       (AND (CONSP |bfVar#3|)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |bfVar#3|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |t| (CAR |ISTMP#2|))
                                         #1#)))))
                            (SETQ |bfVar#5| (CONS |t| |bfVar#5|)))))
                     (SETQ |bfVar#4| (CDR |bfVar#4|))))
                  NIL |doms| NIL)))
               (#1# (PROGN (SETQ |tagged| NIL) |doms|))))
      (COND ((|member| |t2| |unionDoms1|) |t1|) (|tagged| NIL)
            ((NOT
              (AND (CONSP |t2|) (EQ (CAR |t2|) '|Union|)
                   (PROGN (SETQ |doms2| (CDR |t2|)) #1#)))
             (PROGN
              (SETQ |ud| NIL)
              (SETQ |bad| NIL)
              ((LAMBDA (|bfVar#6| |d|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#6|) (PROGN (SETQ |d| (CAR |bfVar#6|)) NIL)
                        |bad|)
                    (RETURN NIL))
                   (#1#
                    (COND ((EQUAL |d| "failed") (SETQ |ud| (CONS |d| |ud|)))
                          ((NULL (SETQ |d'| (|resolveTT| |d| |t2|)))
                           (SETQ |bad| T))
                          (#1# (SETQ |ud| (CONS |d'| |ud|))))))
                  (SETQ |bfVar#6| (CDR |bfVar#6|))))
               |doms| NIL)
              (COND (|bad| NIL)
                    (#1# (CONS '|Union| (REMDUP (REVERSE |ud|)))))))
            (#1#
             (PROGN
              (SETQ |ud| NIL)
              (SETQ |bad| NIL)
              ((LAMBDA (|bfVar#7| |d|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#7|) (PROGN (SETQ |d| (CAR |bfVar#7|)) NIL)
                        |bad|)
                    (RETURN NIL))
                   (#1#
                    (COND
                     ((EQUAL |d| "failed")
                      (SETQ |ud| (APPEND |ud| (LIST |d|))))
                     ((NULL (SETQ |d'| (|resolveTTUnion| |t1| |d|)))
                      (SETQ |bad| T))
                     (#1# (SETQ |ud| (APPEND |ud| (CDR |d'|)))))))
                  (SETQ |bfVar#7| (CDR |bfVar#7|))))
               |doms2| NIL)
              (COND (|bad| NIL) (#1# (CONS '|Union| (REMDUP |ud|)))))))))))

; resolveTTSpecial(t1,t2) ==
;   -- tries to resolve things that would otherwise get mangled in the
;   -- rest of the resolve world. I'll leave it for Albi to fix those
;   -- things. (RSS 1/-86)
;
;   -- following is just an efficiency hack
;   (t1 = '(Symbol) or t1 is ['OrderedVariableList,.]) and PAIRP(t2) and
;       first(t2) = 'Polynomial => t2
;
;   (t1 = '(Symbol)) and ofCategory(t2, '(IntegerNumberSystem)) =>
;     resolveTT1(['Polynomial, t2], t2)
;
;   t1 = '(AlgebraicNumber) and (t2 = $Float or t2 = $DoubleFloat) =>
;     ['Expression, t2]
;   t1 = '(AlgebraicNumber) and (t2 = ['Complex, $Float] or t2 = ['Complex, $DoubleFloat]) =>
;     ['Expression, CADR t2]
;
;   t1 = '(AlgebraicNumber) and t2 is ['Complex,.] =>
;     resolveTT1('(Expression (Integer)), t2)
;
;   t1 is ['SimpleAlgebraicExtension,F,Rep,poly] =>
;     t2 = Rep => t1
;     t2 is ['UnivariatePolynomial,x,R] and (t3 := resolveTT(t1, R)) =>
;       ['UnivariatePolynomial,x,t3]
;     t2 is ['Variable,x] and (t3 := resolveTT(t1, F)) =>
;       ['UnivariatePolynomial,x,t3]
;     t2 is ['Polynomial,R] and (R' := resolveTT(Rep, t2)) =>
;       R' = Rep => t1
;       ['Polynomial,t1]
;     canCoerceFrom(t2,F) => t1
;     nil
;   t1 = $PositiveInteger and ofCategory(t2,'(Ring)) =>
;     resolveTT1($Integer,t2)
;   t1 = $NonNegativeInteger and ofCategory(t2,'(Ring)) =>
;     resolveTT1($Integer,t2)
;   t1 is ['OrderedVariableList,[x]] => resolveTTSpecial(['Variable, x], t2)
;   t1 is ['OrderedVariableList,vl] =>
;     ofCategory(t2,'(Ring)) => resolveTT(['Polynomial,'(Integer)],t2)
;     resolveTT($Symbol,t2)
;   t1 is ['Variable,x] =>
;     EQCAR(t2,'SimpleAlgebraicExtension) => resolveTTSpecial(t2,t1)
;     t2 is ['UnivariatePolynomial,y,S] =>
;       x = y => t2
;       resolveTT1(['UnivariatePolynomial,x,'(Integer)],t2)
;     t2 is ['Variable,y] =>
;       x = y => t1
; --    ['OrderedVariableList, MSORT [x,y]]
;       $Symbol
;     t2 = '(Symbol) => t2
;     t2 is ['Polynomial,.] => t2
;     t2 is ['OrderedVariableList, vl] and member(x,vl) => t2
;     isPolynomialMode t2 => nil
;     ofCategory(t2, '(IntegerNumberSystem)) => resolveTT(['Polynomial, t2], t2)
;     resolveTT(['Polynomial,'(Integer)],t2)
;   t1 is ['FunctionCalled,f] and t2 is ['FunctionCalled,g] =>
;     null (mf := get(f,'mode,$e)) => NIL
;     null (mg := get(g,'mode,$e)) => NIL
;     mf ~= mg => NIL
;     mf
;   t1 is ['UnivariatePolynomial,x,S] =>
;     EQCAR(t2,'Variable) =>
;       resolveTTSpecial(t2,t1)
;     EQCAR(t2,'SimpleAlgebraicExtension) =>
;       resolveTTSpecial(t2,t1)
;     t2 is ['UnivariatePolynomial,y,T] =>
;       (x = y) and (U := resolveTT1(S,T)) and ['UnivariatePolynomial,x,U]
;     nil
;   t1 = '(Pi) =>
;     t2 is ['Complex,d] => defaultTargetFE t2
;     t2 is ['AlgebraicNumber] => defaultTargetFE t2
;     EQCAR(t2, 'Variable) or t2 = $Symbol =>
;       defaultTargetFE($Symbol)
;     t2 is ['Polynomial, .] or t2 is ['Fraction, ['Polynomial, .]] =>
;       defaultTargetFE(t2)
;     nil
;   t1 is ['Polynomial,['Complex,u1]] and t2 is ['Complex,u2] =>
;     resolveTT1(t1,u2)
;   t1 is ['Polynomial,R] and t2 is ['Complex,S] =>
;     containsPolynomial(S) => resolveTT1(['Polynomial,['Complex,R]],t2)
;     ['Polynomial,['Complex,resolveTT1(R,S)]]
;   t1 is ['Expression, R] and t2 is ['Complex,S] =>
;     dom' := resolveTT(R, t2)
;     null dom' => nil
;     ['Expression, dom']
;   t1 is ['Segment, dom] and t2 isnt ['Segment,.] =>
;     dom' := resolveTT(dom, t2)
;     null dom' => nil
;     ['Segment, dom']
;   op1 := first(t1)
;   op2 := first(t2)
;   MEMQ(op1, '(GeneralUnivariatePowerSeries SparseUnivariateLaurentSeries _
;             SparseUnivariatePuiseuxSeries SparseUnivariateTaylorSeries _
;             UnivariateLaurentSeries UnivariatePuiseuxSeries _
;             UnivariateTaylorSeries)) =>
;       [., S1, var1, cen1] := t1
;       op1 = op2 =>
;           [., S2, var2, cen2] := t2
;           not algEqual(var1, var2, $Symbol) => nil
;           (U := resolveTT1(S1, S2)) =>
;                cen1 :=
;                    U = S1 => cen1
;                    objValUnwrap(coerceInt(objNewWrap(cen1, S1), U))
;                cen2 :=
;                    U = S2 => cen2
;                    objValUnwrap(coerceInt(objNewWrap(cen2, S2), U))
;                algEqual(cen1, cen2, U) =>
;                    [op1, U, var1, cen1]
;                nil
;           nil
;   nil

(DEFUN |resolveTTSpecial| (|t1| |t2|)
  (PROG (|ISTMP#1| F |ISTMP#2| |Rep| |ISTMP#3| |poly| |x| R |t3| |R'| |vl| |y|
         S |f| |g| |mf| |mg| T$ U |d| |u1| |u2| |dom'| |dom| |op1| |op2| S1
         |var1| |cen1| S2 |var2| |cen2|)
    (RETURN
     (COND
      ((AND
        (OR (EQUAL |t1| '(|Symbol|))
            (AND (CONSP |t1|) (EQ (CAR |t1|) '|OrderedVariableList|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t1|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)))))
        (CONSP |t2|) (EQ (CAR |t2|) '|Polynomial|))
       |t2|)
      ((AND (EQUAL |t1| '(|Symbol|))
            (|ofCategory| |t2| '(|IntegerNumberSystem|)))
       (|resolveTT1| (LIST '|Polynomial| |t2|) |t2|))
      ((AND (EQUAL |t1| '(|AlgebraicNumber|))
            (OR (EQUAL |t2| |$Float|) (EQUAL |t2| |$DoubleFloat|)))
       (LIST '|Expression| |t2|))
      ((AND (EQUAL |t1| '(|AlgebraicNumber|))
            (OR (EQUAL |t2| (LIST '|Complex| |$Float|))
                (EQUAL |t2| (LIST '|Complex| |$DoubleFloat|))))
       (LIST '|Expression| (CADR |t2|)))
      ((AND (EQUAL |t1| '(|AlgebraicNumber|)) (CONSP |t2|)
            (EQ (CAR |t2|) '|Complex|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t2|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
       (|resolveTT1| '(|Expression| (|Integer|)) |t2|))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|SimpleAlgebraicExtension|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ F (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |Rep| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN
                               (SETQ |poly| (CAR |ISTMP#3|))
                               #1='T))))))))
       (COND ((EQUAL |t2| |Rep|) |t1|)
             ((AND (CONSP |t2|) (EQ (CAR |t2|) '|UnivariatePolynomial|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |t2|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |x| (CAR |ISTMP#1|))
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ R (CAR |ISTMP#2|)) #1#)))))
                   (SETQ |t3| (|resolveTT| |t1| R)))
              (LIST '|UnivariatePolynomial| |x| |t3|))
             ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Variable|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |t2|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |x| (CAR |ISTMP#1|)) #1#)))
                   (SETQ |t3| (|resolveTT| |t1| F)))
              (LIST '|UnivariatePolynomial| |x| |t3|))
             ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Polynomial|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |t2|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ R (CAR |ISTMP#1|)) #1#)))
                   (SETQ |R'| (|resolveTT| |Rep| |t2|)))
              (COND ((EQUAL |R'| |Rep|) |t1|) (#1# (LIST '|Polynomial| |t1|))))
             ((|canCoerceFrom| |t2| F) |t1|) (#1# NIL)))
      ((AND (EQUAL |t1| |$PositiveInteger|) (|ofCategory| |t2| '(|Ring|)))
       (|resolveTT1| |$Integer| |t2|))
      ((AND (EQUAL |t1| |$NonNegativeInteger|) (|ofCategory| |t2| '(|Ring|)))
       (|resolveTT1| |$Integer| |t2|))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|OrderedVariableList|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |x| (CAR |ISTMP#2|)) #1#))))))
       (|resolveTTSpecial| (LIST '|Variable| |x|) |t2|))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|OrderedVariableList|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |vl| (CAR |ISTMP#1|)) #1#))))
       (COND
        ((|ofCategory| |t2| '(|Ring|))
         (|resolveTT| (LIST '|Polynomial| '(|Integer|)) |t2|))
        (#1# (|resolveTT| |$Symbol| |t2|))))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Variable|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |x| (CAR |ISTMP#1|)) #1#))))
       (COND
        ((EQCAR |t2| '|SimpleAlgebraicExtension|)
         (|resolveTTSpecial| |t2| |t1|))
        ((AND (CONSP |t2|) (EQ (CAR |t2|) '|UnivariatePolynomial|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |t2|))
               (AND (CONSP |ISTMP#1|)
                    (PROGN
                     (SETQ |y| (CAR |ISTMP#1|))
                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                     (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                          (PROGN (SETQ S (CAR |ISTMP#2|)) #1#))))))
         (COND ((EQUAL |x| |y|) |t2|)
               (#1#
                (|resolveTT1| (LIST '|UnivariatePolynomial| |x| '(|Integer|))
                 |t2|))))
        ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Variable|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |t2|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                    (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
         (COND ((EQUAL |x| |y|) |t1|) (#1# |$Symbol|)))
        ((EQUAL |t2| '(|Symbol|)) |t2|)
        ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Polynomial|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |t2|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
         |t2|)
        ((AND (CONSP |t2|) (EQ (CAR |t2|) '|OrderedVariableList|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |t2|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                    (PROGN (SETQ |vl| (CAR |ISTMP#1|)) #1#)))
              (|member| |x| |vl|))
         |t2|)
        ((|isPolynomialMode| |t2|) NIL)
        ((|ofCategory| |t2| '(|IntegerNumberSystem|))
         (|resolveTT| (LIST '|Polynomial| |t2|) |t2|))
        (#1# (|resolveTT| (LIST '|Polynomial| '(|Integer|)) |t2|))))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|FunctionCalled|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |f| (CAR |ISTMP#1|)) #1#)))
            (CONSP |t2|) (EQ (CAR |t2|) '|FunctionCalled|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t2|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |g| (CAR |ISTMP#1|)) #1#))))
       (COND ((NULL (SETQ |mf| (|get| |f| '|mode| |$e|))) NIL)
             ((NULL (SETQ |mg| (|get| |g| '|mode| |$e|))) NIL)
             ((NOT (EQUAL |mf| |mg|)) NIL) (#1# |mf|)))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|UnivariatePolynomial|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |x| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ S (CAR |ISTMP#2|)) #1#))))))
       (COND ((EQCAR |t2| '|Variable|) (|resolveTTSpecial| |t2| |t1|))
             ((EQCAR |t2| '|SimpleAlgebraicExtension|)
              (|resolveTTSpecial| |t2| |t1|))
             ((AND (CONSP |t2|) (EQ (CAR |t2|) '|UnivariatePolynomial|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |t2|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |y| (CAR |ISTMP#1|))
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ T$ (CAR |ISTMP#2|)) #1#))))))
              (AND (EQUAL |x| |y|) (SETQ U (|resolveTT1| S T$))
                   (LIST '|UnivariatePolynomial| |x| U)))
             (#1# NIL)))
      ((EQUAL |t1| '(|Pi|))
       (COND
        ((AND (CONSP |t2|) (EQ (CAR |t2|) '|Complex|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |t2|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                    (PROGN (SETQ |d| (CAR |ISTMP#1|)) #1#))))
         (|defaultTargetFE| |t2|))
        ((AND (CONSP |t2|) (EQ (CDR |t2|) NIL)
              (EQ (CAR |t2|) '|AlgebraicNumber|))
         (|defaultTargetFE| |t2|))
        ((OR (EQCAR |t2| '|Variable|) (EQUAL |t2| |$Symbol|))
         (|defaultTargetFE| |$Symbol|))
        ((OR
          (AND (CONSP |t2|) (EQ (CAR |t2|) '|Polynomial|)
               (PROGN
                (SETQ |ISTMP#1| (CDR |t2|))
                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
          (AND (CONSP |t2|) (EQ (CAR |t2|) '|Fraction|)
               (PROGN
                (SETQ |ISTMP#1| (CDR |t2|))
                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                     (PROGN
                      (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                      (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|Polynomial|)
                           (PROGN
                            (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                            (AND (CONSP |ISTMP#3|)
                                 (EQ (CDR |ISTMP#3|) NIL)))))))))
         (|defaultTargetFE| |t2|))
        (#1# NIL)))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Polynomial|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|Complex|)
                        (PROGN
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |u1| (CAR |ISTMP#3|)) #1#)))))))
            (CONSP |t2|) (EQ (CAR |t2|) '|Complex|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t2|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |u2| (CAR |ISTMP#1|)) #1#))))
       (|resolveTT1| |t1| |u2|))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Polynomial|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ R (CAR |ISTMP#1|)) #1#)))
            (CONSP |t2|) (EQ (CAR |t2|) '|Complex|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t2|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ S (CAR |ISTMP#1|)) #1#))))
       (COND
        ((|containsPolynomial| S)
         (|resolveTT1| (LIST '|Polynomial| (LIST '|Complex| R)) |t2|))
        (#1# (LIST '|Polynomial| (LIST '|Complex| (|resolveTT1| R S))))))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Expression|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ R (CAR |ISTMP#1|)) #1#)))
            (CONSP |t2|) (EQ (CAR |t2|) '|Complex|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t2|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ S (CAR |ISTMP#1|)) #1#))))
       (PROGN
        (SETQ |dom'| (|resolveTT| R |t2|))
        (COND ((NULL |dom'|) NIL) (#1# (LIST '|Expression| |dom'|)))))
      ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Segment|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t1|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |dom| (CAR |ISTMP#1|)) #1#)))
            (NOT
             (AND (CONSP |t2|) (EQ (CAR |t2|) '|Segment|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |t2|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))))
       (PROGN
        (SETQ |dom'| (|resolveTT| |dom| |t2|))
        (COND ((NULL |dom'|) NIL) (#1# (LIST '|Segment| |dom'|)))))
      (#1#
       (PROGN
        (SETQ |op1| (CAR |t1|))
        (SETQ |op2| (CAR |t2|))
        (COND
         ((MEMQ |op1|
                '(|GeneralUnivariatePowerSeries|
                  |SparseUnivariateLaurentSeries|
                  |SparseUnivariatePuiseuxSeries|
                  |SparseUnivariateTaylorSeries| |UnivariateLaurentSeries|
                  |UnivariatePuiseuxSeries| |UnivariateTaylorSeries|))
          (PROGN
           (SETQ S1 (CADR . #2=(|t1|)))
           (SETQ |var1| (CADDR . #2#))
           (SETQ |cen1| (CADDDR . #2#))
           (COND
            ((EQUAL |op1| |op2|)
             (PROGN
              (SETQ S2 (CADR . #3=(|t2|)))
              (SETQ |var2| (CADDR . #3#))
              (SETQ |cen2| (CADDDR . #3#))
              (COND ((NULL (|algEqual| |var1| |var2| |$Symbol|)) NIL)
                    ((SETQ U (|resolveTT1| S1 S2))
                     (PROGN
                      (SETQ |cen1|
                              (COND ((EQUAL U S1) |cen1|)
                                    (#1#
                                     (|objValUnwrap|
                                      (|coerceInt| (|objNewWrap| |cen1| S1)
                                       U)))))
                      (SETQ |cen2|
                              (COND ((EQUAL U S2) |cen2|)
                                    (#1#
                                     (|objValUnwrap|
                                      (|coerceInt| (|objNewWrap| |cen2| S2)
                                       U)))))
                      (COND
                       ((|algEqual| |cen1| |cen2| U)
                        (LIST |op1| U |var1| |cen1|))
                       (#1# NIL))))
                    (#1# NIL)))))))
         (#1# NIL))))))))

; resolveTTCC(t1,t2) ==
;   -- tries to use canCoerceFrom information to see if types can be
;   -- coerced to one another
;   gt21 := GGREATERP(t2,t1)
;   (c12 := canCoerceFrom(t1,t2)) and gt21 => t2
;   c21 := canCoerceFrom(t2,t1)
;   null (c12 or c21) => NIL
;   c12 and not c21 => t2
;   c21 and not c12 => t1
;   -- both are coerceable to each other
;   if gt21 then t1 else t2

(DEFUN |resolveTTCC| (|t1| |t2|)
  (PROG (|gt21| |c12| |c21|)
    (RETURN
     (PROGN
      (SETQ |gt21| (GGREATERP |t2| |t1|))
      (COND ((AND (SETQ |c12| (|canCoerceFrom| |t1| |t2|)) |gt21|) |t2|)
            (#1='T
             (PROGN
              (SETQ |c21| (|canCoerceFrom| |t2| |t1|))
              (COND ((NULL (OR |c12| |c21|)) NIL)
                    ((AND |c12| (NULL |c21|)) |t2|)
                    ((AND |c21| (NULL |c12|)) |t1|)
                    (#1# (COND (|gt21| |t1|) (#1# |t2|)))))))))))

; resolveTTEq(t1,t2) ==
;   -- tries to find the constructor of t1 somewhere in t2 (or vice versa)
;   -- and move the other guy to the top
;   [c1,:arg1] := deconstructT t1
;   [c2,:arg2] := deconstructT t2
;   t := resolveTTEq1(c1,arg1,[c2,arg2]) => t
;   t := ( arg1 and resolveTTEq2(c2,arg2,[c1,arg1]) ) => t
;   arg2 and resolveTTEq2(c1,arg1,[c2,arg2])

(DEFUN |resolveTTEq| (|t1| |t2|)
  (PROG (|LETTMP#1| |c1| |arg1| |c2| |arg2| |t|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|deconstructT| |t1|))
      (SETQ |c1| (CAR |LETTMP#1|))
      (SETQ |arg1| (CDR |LETTMP#1|))
      (SETQ |LETTMP#1| (|deconstructT| |t2|))
      (SETQ |c2| (CAR |LETTMP#1|))
      (SETQ |arg2| (CDR |LETTMP#1|))
      (COND ((SETQ |t| (|resolveTTEq1| |c1| |arg1| (LIST |c2| |arg2|))) |t|)
            ((SETQ |t|
                     (AND |arg1|
                          (|resolveTTEq2| |c2| |arg2| (LIST |c1| |arg1|))))
             |t|)
            ('T
             (AND |arg2| (|resolveTTEq2| |c1| |arg1| (LIST |c2| |arg2|)))))))))

; resolveTTEq1(c1,arg1,TL is [c2,arg2,:.]) ==
;   -- takes care of basic types and of types with the same constructor
;   -- calls resolveTT1 on the arguments in the second case
;   null arg1 and null arg2 =>
;     canCoerceFrom(c1,c2) => constructTowerT(c2,CDDR TL)
;     canCoerceFrom(c2,c1) and constructTowerT(c1,CDDR TL)
;   c1=c2 and
;     [c2,arg2,:TL] := bubbleType TL
;     until null arg1 or null arg2 or not t repeat
;       t := resolveTT1(first arg1, first arg2) =>
;         arg := CONS(t,arg)
;         arg1 := rest arg1
;         arg2 := rest arg2
;     t and null arg1 and null arg2 and
;       t0 := constructM(c1,nreverse arg)
;       constructTowerT(t0,TL)

(DEFUN |resolveTTEq1| (|c1| |arg1| TL)
  (PROG (|c2| |arg2| |LETTMP#1| |t| |arg| |t0|)
    (RETURN
     (PROGN
      (SETQ |c2| (CAR TL))
      (SETQ |arg2| (CADR TL))
      (COND
       ((AND (NULL |arg1|) (NULL |arg2|))
        (COND ((|canCoerceFrom| |c1| |c2|) (|constructTowerT| |c2| (CDDR TL)))
              (#1='T
               (AND (|canCoerceFrom| |c2| |c1|)
                    (|constructTowerT| |c1| (CDDR TL))))))
       (#1#
        (AND (EQUAL |c1| |c2|)
             (PROGN
              (SETQ |LETTMP#1| (|bubbleType| TL))
              (SETQ |c2| (CAR |LETTMP#1|))
              (SETQ |arg2| (CADR . #2=(|LETTMP#1|)))
              (SETQ TL (CDDR . #2#))
              ((LAMBDA (|bfVar#8|)
                 (LOOP
                  (COND (|bfVar#8| (RETURN NIL))
                        (#1#
                         (COND
                          ((SETQ |t| (|resolveTT1| (CAR |arg1|) (CAR |arg2|)))
                           (IDENTITY
                            (PROGN
                             (SETQ |arg| (CONS |t| |arg|))
                             (SETQ |arg1| (CDR |arg1|))
                             (SETQ |arg2| (CDR |arg2|))))))))
                  (SETQ |bfVar#8|
                          (OR (NULL |arg1|) (NULL |arg2|) (NULL |t|)))))
               NIL)
              (AND |t| (NULL |arg1|) (NULL |arg2|)
                   (PROGN
                    (SETQ |t0| (|constructM| |c1| (NREVERSE |arg|)))
                    (|constructTowerT| |t0| TL)))))))))))

; resolveTTEq2(c1,arg1,TL is [c,arg,:.]) ==
;   -- tries to resolveTTEq the type [c1,arg1] with the last argument
;   -- of the type represented by TL
;   [c2,:arg2] := deconstructT last arg
;   TL := [c2,arg2,:TL]
;   t := resolveTTEq1(c1,arg1,TL) => t
;   arg2 and resolveTTEq2(c1,arg1,TL)

(DEFUN |resolveTTEq2| (|c1| |arg1| TL)
  (PROG (|c| |arg| |LETTMP#1| |c2| |arg2| |t|)
    (RETURN
     (PROGN
      (SETQ |c| (CAR TL))
      (SETQ |arg| (CADR TL))
      (SETQ |LETTMP#1| (|deconstructT| (|last| |arg|)))
      (SETQ |c2| (CAR |LETTMP#1|))
      (SETQ |arg2| (CDR |LETTMP#1|))
      (SETQ TL (CONS |c2| (CONS |arg2| TL)))
      (COND ((SETQ |t| (|resolveTTEq1| |c1| |arg1| TL)) |t|)
            ('T (AND |arg2| (|resolveTTEq2| |c1| |arg1| TL))))))))

; resolveTTRed(t1,t2) ==
;   -- the same function as resolveTTEq, but instead of testing for
;   -- constructor equality, it looks whether a rewrite rule can be applied
;   t := resolveTTRed1(t1,t2,NIL) => t
;   [c1,:arg1] := deconstructT t1
;   t := arg1 and resolveTTRed2(t2,last arg1,[c1,arg1]) => t
;   [c2,:arg2] := deconstructT t2
;   arg2 and resolveTTRed2(t1,last arg2,[c2,arg2])

(DEFUN |resolveTTRed| (|t1| |t2|)
  (PROG (|t| |LETTMP#1| |c1| |arg1| |c2| |arg2|)
    (RETURN
     (COND ((SETQ |t| (|resolveTTRed1| |t1| |t2| NIL)) |t|)
           (#1='T
            (PROGN
             (SETQ |LETTMP#1| (|deconstructT| |t1|))
             (SETQ |c1| (CAR |LETTMP#1|))
             (SETQ |arg1| (CDR |LETTMP#1|))
             (COND
              ((SETQ |t|
                       (AND |arg1|
                            (|resolveTTRed2| |t2| (|last| |arg1|)
                             (LIST |c1| |arg1|))))
               |t|)
              (#1#
               (PROGN
                (SETQ |LETTMP#1| (|deconstructT| |t2|))
                (SETQ |c2| (CAR |LETTMP#1|))
                (SETQ |arg2| (CDR |LETTMP#1|))
                (AND |arg2|
                     (|resolveTTRed2| |t1| (|last| |arg2|)
                      (LIST |c2| |arg2|))))))))))))

; resolveTTRed1(t1,t2,TL) ==
;   -- tries to apply a reduction rule on (Resolve t1 t2)
;   -- then it creates a type using the result and TL
;   EQ(t,term1RW(t := ['Resolve,t1,t2],$Res)) and
;     EQ(t,term1RW(t := ['Resolve,t2,t1],$Res)) => NIL
;   [c2,:arg2] := deconstructT t2
;   [c2,arg2,:TL] := bubbleType [c2,arg2,:TL]
;   t2 := constructM(c2,arg2)
;   l := term1RWall(['Resolve,t1,t2],$Res)
;   for t0 in l until t repeat t := resolveTTRed3 t0
;   l and t => constructTowerT(t,TL)
;   l := term1RWall(['Resolve,t2,t1],$Res)
;   for t0 in l until t repeat t := resolveTTRed3 t0
;   l and t and constructTowerT(t,TL)

(DEFUN |resolveTTRed1| (|t1| |t2| TL)
  (PROG (|t| |LETTMP#1| |c2| |arg2| |l|)
    (RETURN
     (COND
      ((AND (EQ |t| (|term1RW| (SETQ |t| (LIST '|Resolve| |t1| |t2|)) |$Res|))
            (EQ |t| (|term1RW| (SETQ |t| (LIST '|Resolve| |t2| |t1|)) |$Res|)))
       NIL)
      (#1='T
       (PROGN
        (SETQ |LETTMP#1| (|deconstructT| |t2|))
        (SETQ |c2| (CAR |LETTMP#1|))
        (SETQ |arg2| (CDR |LETTMP#1|))
        (SETQ |LETTMP#1| (|bubbleType| (CONS |c2| (CONS |arg2| TL))))
        (SETQ |c2| (CAR |LETTMP#1|))
        (SETQ |arg2| (CADR . #2=(|LETTMP#1|)))
        (SETQ TL (CDDR . #2#))
        (SETQ |t2| (|constructM| |c2| |arg2|))
        (SETQ |l| (|term1RWall| (LIST '|Resolve| |t1| |t2|) |$Res|))
        ((LAMBDA (|bfVar#9| |t0| |bfVar#10|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#9|) (PROGN (SETQ |t0| (CAR |bfVar#9|)) NIL)
                  |bfVar#10|)
              (RETURN NIL))
             (#1# (SETQ |t| (|resolveTTRed3| |t0|))))
            (SETQ |bfVar#9| (CDR |bfVar#9|))
            (SETQ |bfVar#10| |t|)))
         |l| NIL NIL)
        (COND ((AND |l| |t|) (|constructTowerT| |t| TL))
              (#1#
               (PROGN
                (SETQ |l| (|term1RWall| (LIST '|Resolve| |t2| |t1|) |$Res|))
                ((LAMBDA (|bfVar#11| |t0| |bfVar#12|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#11|)
                          (PROGN (SETQ |t0| (CAR |bfVar#11|)) NIL) |bfVar#12|)
                      (RETURN NIL))
                     (#1# (SETQ |t| (|resolveTTRed3| |t0|))))
                    (SETQ |bfVar#11| (CDR |bfVar#11|))
                    (SETQ |bfVar#12| |t|)))
                 |l| NIL NIL)
                (AND |l| |t| (|constructTowerT| |t| TL)))))))))))

; resolveTTRed2(t1,t2,TL) ==
;   -- tries to resolveTTRed t1 and t2 and build a type using TL
;   t := resolveTTRed1(t1,t2,TL) => t
;   [c2,:arg2] := deconstructT t2
;   arg2 and resolveTTRed2(t1,last arg2,[c2,arg2,:TL])

(DEFUN |resolveTTRed2| (|t1| |t2| TL)
  (PROG (|t| |LETTMP#1| |c2| |arg2|)
    (RETURN
     (COND ((SETQ |t| (|resolveTTRed1| |t1| |t2| TL)) |t|)
           ('T
            (PROGN
             (SETQ |LETTMP#1| (|deconstructT| |t2|))
             (SETQ |c2| (CAR |LETTMP#1|))
             (SETQ |arg2| (CDR |LETTMP#1|))
             (AND |arg2|
                  (|resolveTTRed2| |t1| (|last| |arg2|)
                   (CONS |c2| (CONS |arg2| TL))))))))))

; resolveTTRed3(t) ==
;   -- recursive resolveTTRed which handles all subterms of the form
;   -- (Resolve t1 t2) or subterms which have to be interpreted
;   atom t => t
;   t is ['Resolve,a,b] =>
;     ( t1 := resolveTTRed3 a ) and ( t2 := resolveTTRed3 b ) and
;       resolveTT1(t1,t2)
;   t is ['Incl,a,b] => member(a,b) and b
;   t is ['SetDiff,a,b] => intersection(a,b) and SETDIFFERENCE(a,b)
;   t is ['SetComp,a,b] =>
;     and/[member(x,a) for x in b] and SETDIFFERENCE(a,b)
;   t is ['SetInter,a,b] => intersection(a,b)
;   t is ['SetUnion,a,b] => union(a,b)
;   t is ['VarEqual,a,b] => (a = b) and a
;   t is ['SetEqual,a,b] =>
;     (and/[member(x,a) for x in b] and and/[member(x,b) for x in a]) and a
;   [( atom x and x ) or ((not cs and x and not interpOp? x and x)
;     or resolveTTRed3 x) or return NIL
;       for x in t for cs in GETDATABASE(first t, 'COSIG)]

(DEFUN |resolveTTRed3| (|t|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |t1| |t2|)
    (RETURN
     (COND ((ATOM |t|) |t|)
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Resolve|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
            (AND (SETQ |t1| (|resolveTTRed3| |a|))
                 (SETQ |t2| (|resolveTTRed3| |b|)) (|resolveTT1| |t1| |t2|)))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Incl|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND (|member| |a| |b|) |b|))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|SetDiff|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND (|intersection| |a| |b|) (SETDIFFERENCE |a| |b|)))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|SetComp|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND
             ((LAMBDA (|bfVar#14| |bfVar#13| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#13|)
                       (PROGN (SETQ |x| (CAR |bfVar#13|)) NIL))
                   (RETURN |bfVar#14|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#14| (|member| |x| |a|))
                    (COND ((NOT |bfVar#14|) (RETURN NIL))))))
                 (SETQ |bfVar#13| (CDR |bfVar#13|))))
              T |b| NIL)
             (SETDIFFERENCE |a| |b|)))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|SetInter|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (|intersection| |a| |b|))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|SetUnion|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (|union| |a| |b|))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|VarEqual|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND (EQUAL |a| |b|) |a|))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|SetEqual|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND
             ((LAMBDA (|bfVar#16| |bfVar#15| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#15|)
                       (PROGN (SETQ |x| (CAR |bfVar#15|)) NIL))
                   (RETURN |bfVar#16|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#16| (|member| |x| |a|))
                    (COND ((NOT |bfVar#16|) (RETURN NIL))))))
                 (SETQ |bfVar#15| (CDR |bfVar#15|))))
              T |b| NIL)
             ((LAMBDA (|bfVar#18| |bfVar#17| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#17|)
                       (PROGN (SETQ |x| (CAR |bfVar#17|)) NIL))
                   (RETURN |bfVar#18|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#18| (|member| |x| |b|))
                    (COND ((NOT |bfVar#18|) (RETURN NIL))))))
                 (SETQ |bfVar#17| (CDR |bfVar#17|))))
              T |a| NIL)
             |a|))
           (#1#
            ((LAMBDA (|bfVar#21| |bfVar#19| |x| |bfVar#20| |cs|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#19|) (PROGN (SETQ |x| (CAR |bfVar#19|)) NIL)
                      (ATOM |bfVar#20|)
                      (PROGN (SETQ |cs| (CAR |bfVar#20|)) NIL))
                  (RETURN (NREVERSE |bfVar#21|)))
                 (#1#
                  (SETQ |bfVar#21|
                          (CONS
                           (OR (AND (ATOM |x|) |x|)
                               (AND (NULL |cs|) |x| (NULL (|interpOp?| |x|))
                                    |x|)
                               (|resolveTTRed3| |x|) (RETURN NIL))
                           |bfVar#21|))))
                (SETQ |bfVar#19| (CDR |bfVar#19|))
                (SETQ |bfVar#20| (CDR |bfVar#20|))))
             NIL |t| NIL (GETDATABASE (CAR |t|) 'COSIG) NIL))))))

; interpOp?(op) ==
;   PAIRP(op) and
;     first(op) in '(Incl SetDiff SetComp SetInter SetUnion VarEqual SetEqual)

(DEFUN |interpOp?| (|op|)
  (PROG ()
    (RETURN
     (AND (CONSP |op|)
          (|member| (CAR |op|)
           '(|Incl| |SetDiff| |SetComp| |SetInter| |SetUnion| |VarEqual|
             |SetEqual|))))))

; resolveTCat(t,c) ==
;   -- this function attempts to find a type tc of category c such that
;   -- t can be coerced to tc. NIL returned for failure.
;   -- Example:  t = Integer, c = Field ==> tc = Fraction(Integer)
;
;   -- first check whether t already belongs to c
;   ofCategory(t,c) => t
;
;   -- if t is built by a parametrized constructor and there is a
;   -- condition on the parameter that matches the category, try to
;   -- recurse. An example of this is (G I, Field) -> G RN
;
;   rest(t) and (tc := resolveTCat1(t,c)) => tc
;
;   -- now check some specific niladic categories
;   c in '((Field) (EuclideanDomain)) and ofCategory(t,'(IntegralDomain))=>
;       [$QuotientField, t]
;
;   (t is [t0]) and (sd := getImmediateSuperDomain(t0)) and sd ~= t0 =>
;     resolveTCat(sd,c)
;
;   SIZE(td := deconstructT t) ~= 2=> NIL
;   SIZE(tc := deconstructT c) ~= 2 => NIL
;   ut := underDomainOf t
;   null isValidType(uc := last tc) => NIL
;   null canCoerceFrom(ut,uc) => NIL
;   nt := constructT(first td,[uc])
;   ofCategory(nt,c) => nt
;   NIL

(DEFUN |resolveTCat| (|t| |c|)
  (PROG (|tc| |t0| |sd| |td| |ut| |uc| |nt|)
    (RETURN
     (COND ((|ofCategory| |t| |c|) |t|)
           ((AND (CDR |t|) (SETQ |tc| (|resolveTCat1| |t| |c|))) |tc|)
           ((AND (|member| |c| '((|Field|) (|EuclideanDomain|)))
                 (|ofCategory| |t| '(|IntegralDomain|)))
            (LIST |$QuotientField| |t|))
           ((AND (CONSP |t|) (EQ (CDR |t|) NIL)
                 (PROGN (SETQ |t0| (CAR |t|)) #1='T)
                 (SETQ |sd| (|getImmediateSuperDomain| |t0|))
                 (NOT (EQUAL |sd| |t0|)))
            (|resolveTCat| |sd| |c|))
           ((NOT (EQL (SIZE (SETQ |td| (|deconstructT| |t|))) 2)) NIL)
           ((NOT (EQL (SIZE (SETQ |tc| (|deconstructT| |c|))) 2)) NIL)
           (#1#
            (PROGN
             (SETQ |ut| (|underDomainOf| |t|))
             (COND ((NULL (|isValidType| (SETQ |uc| (|last| |tc|)))) NIL)
                   ((NULL (|canCoerceFrom| |ut| |uc|)) NIL)
                   (#1#
                    (PROGN
                     (SETQ |nt| (|constructT| (CAR |td|) (LIST |uc|)))
                     (COND ((|ofCategory| |nt| |c|) |nt|) (#1# NIL)))))))))))

; resolveTCat1(t,c) ==
;   -- does the hard work of looking at conditions on under domains
;   -- if null (ut := getUnderModeOf(t)) then ut := last dt
;   null (conds := getConditionsForCategoryOnType(t,c)) => NIL
; --rest(conds) => NIL   -- will handle later
;   cond := first conds
;   cond isnt [.,['has, pat, c1],:.] => NIL
;   rest(c1) => NIL      -- make it simple
;
;   argN := 0
;   t1 := nil
;
;   for ut in rest t for i in 1.. while (argN = 0) repeat
;     sharp := INTERNL1('"#", STRINGIMAGE(i))
;     sharp = pat =>
;       argN := i
;       t1 := ut
;
;   null t1 => NIL
;   null (t1' := resolveTCat(t1,c1)) => NIL
;   t' := copy t
;   t'.argN := t1'
;   t'

(DEFUN |resolveTCat1| (|t| |c|)
  (PROG (|conds| |cond| |ISTMP#1| |ISTMP#2| |ISTMP#3| |pat| |ISTMP#4| |c1|
         |argN| |t1| |sharp| |t1'| |t'|)
    (RETURN
     (COND
      ((NULL (SETQ |conds| (|getConditionsForCategoryOnType| |t| |c|))) NIL)
      (#1='T
       (PROGN
        (SETQ |cond| (CAR |conds|))
        (COND
         ((NOT
           (AND (CONSP |cond|)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |cond|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|has|)
                            (PROGN
                             (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                             (AND (CONSP |ISTMP#3|)
                                  (PROGN
                                   (SETQ |pat| (CAR |ISTMP#3|))
                                   (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                   (AND (CONSP |ISTMP#4|)
                                        (EQ (CDR |ISTMP#4|) NIL)
                                        (PROGN
                                         (SETQ |c1| (CAR |ISTMP#4|))
                                         #1#)))))))))))
          NIL)
         ((CDR |c1|) NIL)
         (#1#
          (PROGN
           (SETQ |argN| 0)
           (SETQ |t1| NIL)
           ((LAMBDA (|bfVar#22| |ut| |i|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#22|) (PROGN (SETQ |ut| (CAR |bfVar#22|)) NIL)
                     (NOT (EQL |argN| 0)))
                 (RETURN NIL))
                (#1#
                 (PROGN
                  (SETQ |sharp| (INTERNL1 "#" (STRINGIMAGE |i|)))
                  (COND
                   ((EQUAL |sharp| |pat|)
                    (PROGN (SETQ |argN| |i|) (SETQ |t1| |ut|)))))))
               (SETQ |bfVar#22| (CDR |bfVar#22|))
               (SETQ |i| (+ |i| 1))))
            (CDR |t|) NIL 1)
           (COND ((NULL |t1|) NIL)
                 ((NULL (SETQ |t1'| (|resolveTCat| |t1| |c1|))) NIL)
                 (#1#
                  (PROGN
                   (SETQ |t'| (COPY |t|))
                   (SETF (ELT |t'| |argN|) |t1'|)
                   |t'|))))))))))))

; getConditionsForCategoryOnType(t,cat) ==
;   getConditionalCategoryOfType(t,[NIL],['ATTRIBUTE,cat])

(DEFUN |getConditionsForCategoryOnType| (|t| |cat|)
  (PROG ()
    (RETURN
     (|getConditionalCategoryOfType| |t| (LIST NIL) (LIST 'ATTRIBUTE |cat|)))))

; getConditionalCategoryOfType(t,conditions,match) ==
;   if PAIRP t then t := first t
;   t in '(Union Mapping Record) => NIL
;   conCat := GETDATABASE(t,'CONSTRUCTORCATEGORY)
;   REMDUP rest getConditionalCategoryOfType1(conCat, conditions, match, [[]])

(DEFUN |getConditionalCategoryOfType| (|t| |conditions| |match|)
  (PROG (|conCat|)
    (RETURN
     (PROGN
      (COND ((CONSP |t|) (SETQ |t| (CAR |t|))))
      (COND ((|member| |t| '(|Union| |Mapping| |Record|)) NIL)
            ('T
             (PROGN
              (SETQ |conCat| (GETDATABASE |t| 'CONSTRUCTORCATEGORY))
              (REMDUP
               (CDR
                (|getConditionalCategoryOfType1| |conCat| |conditions| |match|
                 (LIST NIL)))))))))))

; getConditionalCategoryOfType1(cat,conditions,match,seen) ==
;   cat is ['Join,:cs] or cat is ['CATEGORY,:cs] =>
;     null cs => conditions
;     getConditionalCategoryOfType1([first cat,:rest cs],
;      getConditionalCategoryOfType1(first cs,conditions,match,seen),
;        match,seen)
;   cat is ['IF,., cond,.] =>
;     matchUpToPatternVars(cond,match,NIL) =>
;       RPLACD(conditions, CONS(cat, rest conditions))
;       conditions
;     conditions
;   cat is [catName,:.] and (GETDATABASE(catName,'CONSTRUCTORKIND) = 'category) =>
;     cat in rest seen => conditions
;     RPLACD(seen, [cat, :rest seen])
;     subCat := GETDATABASE(catName,'CONSTRUCTORCATEGORY)
;     -- substitute vars of cat into category
;     for v in rest cat for vv in $TriangleVariableList repeat
;       subCat := SUBST(v,vv,subCat)
;     getConditionalCategoryOfType1(subCat,conditions,match,seen)
;   conditions

(DEFUN |getConditionalCategoryOfType1| (|cat| |conditions| |match| |seen|)
  (PROG (|cs| |ISTMP#1| |ISTMP#2| |cond| |ISTMP#3| |catName| |subCat|)
    (RETURN
     (COND
      ((OR
        (AND (CONSP |cat|) (EQ (CAR |cat|) '|Join|)
             (PROGN (SETQ |cs| (CDR |cat|)) #1='T))
        (AND (CONSP |cat|) (EQ (CAR |cat|) 'CATEGORY)
             (PROGN (SETQ |cs| (CDR |cat|)) #1#)))
       (COND ((NULL |cs|) |conditions|)
             (#1#
              (|getConditionalCategoryOfType1| (CONS (CAR |cat|) (CDR |cs|))
               (|getConditionalCategoryOfType1| (CAR |cs|) |conditions| |match|
                |seen|)
               |match| |seen|))))
      ((AND (CONSP |cat|) (EQ (CAR |cat|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |cat|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |cond| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL))))))))
       (COND
        ((|matchUpToPatternVars| |cond| |match| NIL)
         (PROGN
          (RPLACD |conditions| (CONS |cat| (CDR |conditions|)))
          |conditions|))
        (#1# |conditions|)))
      ((AND (CONSP |cat|) (PROGN (SETQ |catName| (CAR |cat|)) #1#)
            (EQ (GETDATABASE |catName| 'CONSTRUCTORKIND) '|category|))
       (COND ((|member| |cat| (CDR |seen|)) |conditions|)
             (#1#
              (PROGN
               (RPLACD |seen| (CONS |cat| (CDR |seen|)))
               (SETQ |subCat| (GETDATABASE |catName| 'CONSTRUCTORCATEGORY))
               ((LAMBDA (|bfVar#23| |v| |bfVar#24| |vv|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#23|)
                         (PROGN (SETQ |v| (CAR |bfVar#23|)) NIL)
                         (ATOM |bfVar#24|)
                         (PROGN (SETQ |vv| (CAR |bfVar#24|)) NIL))
                     (RETURN NIL))
                    (#1# (SETQ |subCat| (SUBST |v| |vv| |subCat|))))
                   (SETQ |bfVar#23| (CDR |bfVar#23|))
                   (SETQ |bfVar#24| (CDR |bfVar#24|))))
                (CDR |cat|) NIL |$TriangleVariableList| NIL)
               (|getConditionalCategoryOfType1| |subCat| |conditions| |match|
                |seen|)))))
      (#1# |conditions|)))))

; matchUpToPatternVars(pat,form,patAlist) ==
;   -- tries to match pattern variables (of the # form) in pat
;   -- against expressions in form. If one is found, it is checked
;   -- against the patAlist to make sure we are using the same expression
;   -- each time.
;   EQUAL(pat,form) => true
;   isSharpVarWithNum(pat) =>
;     -- see is pattern variable is in alist
;     (p := assoc(pat, patAlist)) => EQUAL(form, rest p)
;     patAlist := [[pat,:form],:patAlist]
;     true
;   PAIRP(pat) =>
;     not (PAIRP form) => NIL
;     matchUpToPatternVars(first pat, first form, patAlist) and
;       matchUpToPatternVars(rest pat, rest form, patAlist)
;   NIL

(DEFUN |matchUpToPatternVars| (|pat| |form| |patAlist|)
  (PROG (|p|)
    (RETURN
     (COND ((EQUAL |pat| |form|) T)
           ((|isSharpVarWithNum| |pat|)
            (COND
             ((SETQ |p| (|assoc| |pat| |patAlist|)) (EQUAL |form| (CDR |p|)))
             (#1='T
              (PROGN
               (SETQ |patAlist| (CONS (CONS |pat| |form|) |patAlist|))
               T))))
           ((CONSP |pat|)
            (COND ((NULL (CONSP |form|)) NIL)
                  (#1#
                   (AND
                    (|matchUpToPatternVars| (CAR |pat|) (CAR |form|)
                     |patAlist|)
                    (|matchUpToPatternVars| (CDR |pat|) (CDR |form|)
                     |patAlist|)))))
           (#1# NIL)))))

; resolveTMOrCroak(t,m) ==
;   resolveTM(t,m) or throwKeyedMsg("S2IR0004",[t,m])

(DEFUN |resolveTMOrCroak| (|t| |m|)
  (PROG ()
    (RETURN
     (OR (|resolveTM| |t| |m|) (|throwKeyedMsg| 'S2IR0004 (LIST |t| |m|))))))

; resolveTM(t,m) ==
;   -- resolves a type with a mode which may be partially specified
;   startTimingProcess 'resolve
;   $Subst : local := NIL
;   $Coerce : local := 'T
;   m := SUBSTQ("**",$EmptyMode,m)
;   -- arbitrary limit
;   $resolve_level > 15 => nil
;   $resolve_level := $resolve_level + 1
;   tt := resolveTM1(t,m)
;   $resolve_level := $resolve_level - 1
;   result := tt and isValidType tt and tt
;   stopTimingProcess 'resolve
;   result

(DEFUN |resolveTM| (|t| |m|)
  (PROG (|$Coerce| |$Subst| |result| |tt|)
    (DECLARE (SPECIAL |$Coerce| |$Subst|))
    (RETURN
     (PROGN
      (|startTimingProcess| '|resolve|)
      (SETQ |$Subst| NIL)
      (SETQ |$Coerce| 'T)
      (SETQ |m| (SUBSTQ '** |$EmptyMode| |m|))
      (COND ((< 15 |$resolve_level|) NIL)
            ('T
             (PROGN
              (SETQ |$resolve_level| (+ |$resolve_level| 1))
              (SETQ |tt| (|resolveTM1| |t| |m|))
              (SETQ |$resolve_level| (- |$resolve_level| 1))
              (SETQ |result| (AND |tt| (|isValidType| |tt|) |tt|))
              (|stopTimingProcess| '|resolve|)
              |result|)))))))

; resolveTM1(t,m) ==
;   -- general resolveTM, which looks for a term variable
;   -- otherwise it looks whether the type has the same top level
;   -- constructor as the mode, looks for a rewrite rule, or builds up
;   -- a tower
;   t=m => t
;   m is ['Union,:.] => resolveTMUnion(t,m)
;   m = '(Void) => m
;   m = '(Any) => m
;   m = '(Exit) => t
;   containsVars m =>
;     isPatternVar m =>
;       p := ASSQ(m,$Subst) =>
;         $Coerce =>
;           tt := resolveTT1(t, rest p) => RPLACD(p, tt) and tt
;           NIL
;         t = rest p and t
;       $Subst := CONS(CONS(m,t),$Subst)
;       t
;     atom(t) or atom(m) => NIL
;     (t is ['Record,:tr]) and (m is ['Record,:mr]) and
;       (tt := resolveTMRecord(tr,mr)) => tt
;     t is ['Record,:.] or m is ['Record,:.] => NIL
;     t is ['Variable, .] and m is ['Mapping, :.] => m
;     t is ['FunctionCalled, .] and m is ['Mapping, :.] => m
;     if isEqualOrSubDomain(t, $Integer) then
;       t := $Integer
;     tt := resolveTMEq(t,m) => tt
;     $Coerce and
;       tt := resolveTMRed(t,m) => tt
;       resolveTM2(t,m)
;   $Coerce and canCoerceFrom(t,m) and m

(DEFUN |resolveTM1| (|t| |m|)
  (PROG (|p| |tt| |tr| |mr| |ISTMP#1|)
    (RETURN
     (COND ((EQUAL |t| |m|) |t|)
           ((AND (CONSP |m|) (EQ (CAR |m|) '|Union|))
            (|resolveTMUnion| |t| |m|))
           ((EQUAL |m| '(|Void|)) |m|) ((EQUAL |m| '(|Any|)) |m|)
           ((EQUAL |m| '(|Exit|)) |t|)
           ((|containsVars| |m|)
            (COND
             ((|isPatternVar| |m|)
              (COND
               ((SETQ |p| (ASSQ |m| |$Subst|))
                (COND
                 (|$Coerce|
                  (COND
                   ((SETQ |tt| (|resolveTT1| |t| (CDR |p|)))
                    (AND (RPLACD |p| |tt|) |tt|))
                   (#1='T NIL)))
                 (#1# (AND (EQUAL |t| (CDR |p|)) |t|))))
               (#1#
                (PROGN (SETQ |$Subst| (CONS (CONS |m| |t|) |$Subst|)) |t|))))
             ((OR (ATOM |t|) (ATOM |m|)) NIL)
             ((AND (CONSP |t|) (EQ (CAR |t|) '|Record|)
                   (PROGN (SETQ |tr| (CDR |t|)) #1#) (CONSP |m|)
                   (EQ (CAR |m|) '|Record|) (PROGN (SETQ |mr| (CDR |m|)) #1#)
                   (SETQ |tt| (|resolveTMRecord| |tr| |mr|)))
              |tt|)
             ((OR (AND (CONSP |t|) (EQ (CAR |t|) '|Record|))
                  (AND (CONSP |m|) (EQ (CAR |m|) '|Record|)))
              NIL)
             ((AND (CONSP |t|) (EQ (CAR |t|) '|Variable|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |t|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)))
                   (CONSP |m|) (EQ (CAR |m|) '|Mapping|))
              |m|)
             ((AND (CONSP |t|) (EQ (CAR |t|) '|FunctionCalled|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |t|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)))
                   (CONSP |m|) (EQ (CAR |m|) '|Mapping|))
              |m|)
             (#1#
              (PROGN
               (COND
                ((|isEqualOrSubDomain| |t| |$Integer|) (SETQ |t| |$Integer|)))
               (COND ((SETQ |tt| (|resolveTMEq| |t| |m|)) |tt|)
                     (#1#
                      (AND |$Coerce|
                           (COND ((SETQ |tt| (|resolveTMRed| |t| |m|)) |tt|)
                                 (#1# (|resolveTM2| |t| |m|))))))))))
           (#1# (AND |$Coerce| (|canCoerceFrom| |t| |m|) |m|))))))

; resolveTMRecord(tr,mr) ==
;   #tr ~= #mr => NIL
;   ok := true
;   tt := NIL
;   for ta in tr for ma in mr while ok repeat
;     -- element is [':,tag,mode]
;     CADR(ta) ~= CADR(ma) => ok := NIL      -- match tags
;     ra := resolveTM1(CADDR ta, CADDR ma)   -- resolve modes
;     null ra => ok := NIL
;     tt := CONS([first ta, CADR ta, ra], tt)
;   null ok => NIL
;   ['Record,nreverse tt]

(DEFUN |resolveTMRecord| (|tr| |mr|)
  (PROG (|ok| |tt| |ra|)
    (RETURN
     (COND ((NOT (EQL (LENGTH |tr|) (LENGTH |mr|))) NIL)
           (#1='T
            (PROGN
             (SETQ |ok| T)
             (SETQ |tt| NIL)
             ((LAMBDA (|bfVar#25| |ta| |bfVar#26| |ma|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#25|)
                       (PROGN (SETQ |ta| (CAR |bfVar#25|)) NIL)
                       (ATOM |bfVar#26|)
                       (PROGN (SETQ |ma| (CAR |bfVar#26|)) NIL) (NOT |ok|))
                   (RETURN NIL))
                  (#1#
                   (COND
                    ((NOT (EQUAL (CADR |ta|) (CADR |ma|))) (SETQ |ok| NIL))
                    (#1#
                     (PROGN
                      (SETQ |ra| (|resolveTM1| (CADDR |ta|) (CADDR |ma|)))
                      (COND ((NULL |ra|) (SETQ |ok| NIL))
                            (#1#
                             (SETQ |tt|
                                     (CONS (LIST (CAR |ta|) (CADR |ta|) |ra|)
                                           |tt|)))))))))
                 (SETQ |bfVar#25| (CDR |bfVar#25|))
                 (SETQ |bfVar#26| (CDR |bfVar#26|))))
              |tr| NIL |mr| NIL)
             (COND ((NULL |ok|) NIL)
                   (#1# (LIST '|Record| (NREVERSE |tt|))))))))))

; resolveTMUnion(t, m is ['Union,:ums]) ==
;   isTaggedUnion m => resolveTMTaggedUnion(t,m)
;   -- resolves t with a Union type
;   t isnt ['Union,:uts] =>
;     ums := REMDUP spliceTypeListForEmptyMode([t],ums)
;     ums' := nil
;     success := nil
;     for um in ums repeat
;       (um' := resolveTM1(t,um)) =>
;         success := true
;         um' in '(T TRUE) => ums' := [um,:ums']
;         ums' := [um',:ums']
;       ums' := [um,:ums']
;     -- remove any duplicate domains that might have been created
;     m' := ['Union,:REMDUP reverse ums']
;     success =>
;       null CONTAINED('_*_*,m') => m'
;       t = $Integer => NIL
;       resolveTM1($Integer,m')
;     NIL
;   -- t is actually a Union if we got here
;   ums := REMDUP spliceTypeListForEmptyMode(uts,ums)
;   bad := nil
;   doms := nil
;   for ut in uts while not bad repeat
;     (m' := resolveTMUnion(ut,['Union,:ums])) =>
;       doms := append(rest m', doms)
;     bad := true
;   bad => NIL
;   ['Union,:REMDUP doms]

(DEFUN |resolveTMUnion| (|t| |m|)
  (PROG (|ums| |uts| |ums'| |success| |um'| |m'| |bad| |doms|)
    (RETURN
     (PROGN
      (SETQ |ums| (CDR |m|))
      (COND ((|isTaggedUnion| |m|) (|resolveTMTaggedUnion| |t| |m|))
            ((NOT
              (AND (CONSP |t|) (EQ (CAR |t|) '|Union|)
                   (PROGN (SETQ |uts| (CDR |t|)) #1='T)))
             (PROGN
              (SETQ |ums|
                      (REMDUP (|spliceTypeListForEmptyMode| (LIST |t|) |ums|)))
              (SETQ |ums'| NIL)
              (SETQ |success| NIL)
              ((LAMBDA (|bfVar#27| |um|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#27|)
                        (PROGN (SETQ |um| (CAR |bfVar#27|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (COND
                     ((SETQ |um'| (|resolveTM1| |t| |um|))
                      (PROGN
                       (SETQ |success| T)
                       (COND
                        ((|member| |um'| '(T TRUE))
                         (SETQ |ums'| (CONS |um| |ums'|)))
                        (#1# (SETQ |ums'| (CONS |um'| |ums'|))))))
                     (#1# (SETQ |ums'| (CONS |um| |ums'|))))))
                  (SETQ |bfVar#27| (CDR |bfVar#27|))))
               |ums| NIL)
              (SETQ |m'| (CONS '|Union| (REMDUP (REVERSE |ums'|))))
              (COND
               (|success|
                (COND ((NULL (CONTAINED '** |m'|)) |m'|)
                      ((EQUAL |t| |$Integer|) NIL)
                      (#1# (|resolveTM1| |$Integer| |m'|))))
               (#1# NIL))))
            (#1#
             (PROGN
              (SETQ |ums| (REMDUP (|spliceTypeListForEmptyMode| |uts| |ums|)))
              (SETQ |bad| NIL)
              (SETQ |doms| NIL)
              ((LAMBDA (|bfVar#28| |ut|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#28|)
                        (PROGN (SETQ |ut| (CAR |bfVar#28|)) NIL) |bad|)
                    (RETURN NIL))
                   (#1#
                    (COND
                     ((SETQ |m'| (|resolveTMUnion| |ut| (CONS '|Union| |ums|)))
                      (SETQ |doms| (APPEND (CDR |m'|) |doms|)))
                     (#1# (SETQ |bad| T)))))
                  (SETQ |bfVar#28| (CDR |bfVar#28|))))
               |uts| NIL)
              (COND (|bad| NIL) (#1# (CONS '|Union| (REMDUP |doms|)))))))))))

; resolveTMTaggedUnion(t, m is ['Union,:ums]) ==
;   NIL

(DEFUN |resolveTMTaggedUnion| (|t| |m|)
  (PROG (|ums|) (RETURN (PROGN (SETQ |ums| (CDR |m|)) NIL))))

; spliceTypeListForEmptyMode(tl,ml) ==
;   -- splice in tl for occurrence of ** in ml
;   null ml => nil
;   ml is [m,:ml'] =>
;     m = "**" => append(tl,spliceTypeListForEmptyMode(tl,ml'))
;     [m,:spliceTypeListForEmptyMode(tl,ml')]

(DEFUN |spliceTypeListForEmptyMode| (|tl| |ml|)
  (PROG (|m| |ml'|)
    (RETURN
     (COND ((NULL |ml|) NIL)
           ((AND (CONSP |ml|)
                 (PROGN (SETQ |m| (CAR |ml|)) (SETQ |ml'| (CDR |ml|)) #1='T))
            (COND
             ((EQ |m| '**)
              (APPEND |tl| (|spliceTypeListForEmptyMode| |tl| |ml'|)))
             (#1# (CONS |m| (|spliceTypeListForEmptyMode| |tl| |ml'|)))))))))

; resolveTM2(t,m) ==
;   -- resolves t with the last argument of m and builds up a tower
;   [cm,:argm] := deconstructT m
;   argm and
;     tt := resolveTM1(t,last argm)
;     tt and
;       ttt := constructM(cm,replaceLast(argm,tt))
;       ttt and canCoerceFrom(tt,ttt) and ttt

(DEFUN |resolveTM2| (|t| |m|)
  (PROG (|LETTMP#1| |cm| |argm| |tt| |ttt|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|deconstructT| |m|))
      (SETQ |cm| (CAR |LETTMP#1|))
      (SETQ |argm| (CDR |LETTMP#1|))
      (AND |argm|
           (PROGN
            (SETQ |tt| (|resolveTM1| |t| (|last| |argm|)))
            (AND |tt|
                 (PROGN
                  (SETQ |ttt| (|constructM| |cm| (|replaceLast| |argm| |tt|)))
                  (AND |ttt| (|canCoerceFrom| |tt| |ttt|) |ttt|)))))))))

; resolveTMEq(t,m) ==
;   -- tests whether t and m have the same top level constructor, which,
;   -- in the case of t, could be bubbled up
;   (res := resolveTMSpecial(t,m)) => res
;   [cm,:argm] := deconstructT m
;   c := containsVars cm
;   TL := NIL
;   until b or not t repeat
;     [ct,:argt] := deconstructT t
;     b :=
;       c =>
;         SL := resolveTMEq1(ct,cm)
;         not EQ(SL,'failed)
;       ct=cm
;     not b =>
;       TL := [ct,argt,:TL]
;       t := argt and last argt
;   b and
;     t := resolveTMEq2(cm,argm,[ct,argt,:TL])
;     if t then for p in SL repeat $Subst := augmentSub(first p, rest p, $Subst)
;     t

(DEFUN |resolveTMEq| (|t| |m|)
  (PROG (|res| |LETTMP#1| |cm| |argm| |c| TL |ct| |argt| SL |b|)
    (RETURN
     (COND ((SETQ |res| (|resolveTMSpecial| |t| |m|)) |res|)
           (#1='T
            (PROGN
             (SETQ |LETTMP#1| (|deconstructT| |m|))
             (SETQ |cm| (CAR |LETTMP#1|))
             (SETQ |argm| (CDR |LETTMP#1|))
             (SETQ |c| (|containsVars| |cm|))
             (SETQ TL NIL)
             ((LAMBDA (|bfVar#29|)
                (LOOP
                 (COND (|bfVar#29| (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |LETTMP#1| (|deconstructT| |t|))
                         (SETQ |ct| (CAR |LETTMP#1|))
                         (SETQ |argt| (CDR |LETTMP#1|))
                         (SETQ |b|
                                 (COND
                                  (|c|
                                   (PROGN
                                    (SETQ SL (|resolveTMEq1| |ct| |cm|))
                                    (NULL (EQ SL '|failed|))))
                                  (#1# (EQUAL |ct| |cm|))))
                         (COND
                          ((NULL |b|)
                           (PROGN
                            (SETQ TL (CONS |ct| (CONS |argt| TL)))
                            (SETQ |t| (AND |argt| (|last| |argt|)))))))))
                 (SETQ |bfVar#29| (OR |b| (NULL |t|)))))
              NIL)
             (AND |b|
                  (PROGN
                   (SETQ |t|
                           (|resolveTMEq2| |cm| |argm|
                            (CONS |ct| (CONS |argt| TL))))
                   (COND
                    (|t|
                     ((LAMBDA (|bfVar#30| |p|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#30|)
                               (PROGN (SETQ |p| (CAR |bfVar#30|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (SETQ |$Subst|
                                   (|augmentSub| (CAR |p|) (CDR |p|)
                                    |$Subst|))))
                         (SETQ |bfVar#30| (CDR |bfVar#30|))))
                      SL NIL)))
                   |t|))))))))

; resolveTMSpecial(t,m) ==
;   -- a few special cases
;   t = $AnonymousFunction and m is ['Mapping,:.] => m
;   t is ['Variable,x] and m is ['OrderedVariableList,le] =>
;     isPatternVar le => ['OrderedVariableList,[x]]
;     PAIRP(le) and member(x,le) => le
;     NIL
;   t is ['Fraction, ['Complex, t1]] and m is ['Complex, m1] =>
;     resolveTM1(['Complex, ['Fraction, t1]], m)
;   t is ['Fraction, ['Polynomial, ['Complex, t1]]] and m is ['Complex, m1] =>
;     resolveTM1(['Complex, ['Fraction, ['Polynomial, t1]]], m)
;   t is ['Mapping,:lt] and m is ['Mapping,:lm] =>
;     #lt ~= #lm => NIL
;     l := NIL
;     ok := true
;     for at in lt for am in lm while ok repeat
;       (ok := resolveTM1(at,am)) => l := [ok,:l]
;     ok and ['Mapping,:reverse l]
;   t is ['Segment,u] and m is ['UniversalSegment,.] =>
;     resolveTM1(['UniversalSegment, u], m)
;   NIL

(DEFUN |resolveTMSpecial| (|t| |m|)
  (PROG (|ISTMP#1| |x| |le| |ISTMP#2| |ISTMP#3| |t1| |m1| |ISTMP#4| |ISTMP#5|
         |lt| |lm| |l| |ok| |u|)
    (RETURN
     (COND
      ((AND (EQUAL |t| |$AnonymousFunction|) (CONSP |m|)
            (EQ (CAR |m|) '|Mapping|))
       |m|)
      ((AND (CONSP |t|) (EQ (CAR |t|) '|Variable|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |x| (CAR |ISTMP#1|)) #1='T)))
            (CONSP |m|) (EQ (CAR |m|) '|OrderedVariableList|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |m|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |le| (CAR |ISTMP#1|)) #1#))))
       (COND ((|isPatternVar| |le|) (LIST '|OrderedVariableList| (LIST |x|)))
             ((AND (CONSP |le|) (|member| |x| |le|)) |le|) (#1# NIL)))
      ((AND (CONSP |t|) (EQ (CAR |t|) '|Fraction|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|Complex|)
                        (PROGN
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |t1| (CAR |ISTMP#3|)) #1#)))))))
            (CONSP |m|) (EQ (CAR |m|) '|Complex|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |m|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |m1| (CAR |ISTMP#1|)) #1#))))
       (|resolveTM1| (LIST '|Complex| (LIST '|Fraction| |t1|)) |m|))
      ((AND (CONSP |t|) (EQ (CAR |t|) '|Fraction|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|Polynomial|)
                        (PROGN
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN
                               (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                               (AND (CONSP |ISTMP#4|)
                                    (EQ (CAR |ISTMP#4|) '|Complex|)
                                    (PROGN
                                     (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                     (AND (CONSP |ISTMP#5|)
                                          (EQ (CDR |ISTMP#5|) NIL)
                                          (PROGN
                                           (SETQ |t1| (CAR |ISTMP#5|))
                                           #1#)))))))))))
            (CONSP |m|) (EQ (CAR |m|) '|Complex|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |m|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |m1| (CAR |ISTMP#1|)) #1#))))
       (|resolveTM1|
        (LIST '|Complex| (LIST '|Fraction| (LIST '|Polynomial| |t1|))) |m|))
      ((AND (CONSP |t|) (EQ (CAR |t|) '|Mapping|)
            (PROGN (SETQ |lt| (CDR |t|)) #1#) (CONSP |m|)
            (EQ (CAR |m|) '|Mapping|) (PROGN (SETQ |lm| (CDR |m|)) #1#))
       (COND ((NOT (EQL (LENGTH |lt|) (LENGTH |lm|))) NIL)
             (#1#
              (PROGN
               (SETQ |l| NIL)
               (SETQ |ok| T)
               ((LAMBDA (|bfVar#31| |at| |bfVar#32| |am|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#31|)
                         (PROGN (SETQ |at| (CAR |bfVar#31|)) NIL)
                         (ATOM |bfVar#32|)
                         (PROGN (SETQ |am| (CAR |bfVar#32|)) NIL) (NOT |ok|))
                     (RETURN NIL))
                    (#1#
                     (COND
                      ((SETQ |ok| (|resolveTM1| |at| |am|))
                       (IDENTITY (SETQ |l| (CONS |ok| |l|)))))))
                   (SETQ |bfVar#31| (CDR |bfVar#31|))
                   (SETQ |bfVar#32| (CDR |bfVar#32|))))
                |lt| NIL |lm| NIL)
               (AND |ok| (CONS '|Mapping| (REVERSE |l|)))))))
      ((AND (CONSP |t|) (EQ (CAR |t|) '|Segment|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |t|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |u| (CAR |ISTMP#1|)) #1#)))
            (CONSP |m|) (EQ (CAR |m|) '|UniversalSegment|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |m|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
       (|resolveTM1| (LIST '|UniversalSegment| |u|) |m|))
      (#1# NIL)))))

; resolveTMEq1(ct,cm) ==
;   -- ct and cm are type constructors
;   -- tests for a match from cm to ct
;   -- the result is a substitution or 'failed
;   not (first ct = first cm) => 'failed
;   SL := NIL
;   ct := rest ct
;   cm := rest cm
;   b := 'T
;   while ct and cm and b repeat
;     xt := first ct
;     ct := rest ct
;     xm := first cm
;     cm := rest cm
;     if not (atom xm) and first xm = ":"  --  i.e. Record
;       and first xt = ":" and CADR xm = CADR xt then
;         xm := CADDR xm
;         xt := CADDR xt
;     b :=
;       xt=xm => 'T
;       isPatternVar(xm) and
;         p := ASSQ(xm, $Subst) => xt = rest p
;         p := ASSQ(xm, SL) => xt = rest p
;         SL := augmentSub(xm,xt,SL)
;   b => SL
;   'failed

(DEFUN |resolveTMEq1| (|ct| |cm|)
  (PROG (SL |b| |xt| |xm| |p|)
    (RETURN
     (COND ((NULL (EQUAL (CAR |ct|) (CAR |cm|))) '|failed|)
           (#1='T
            (PROGN
             (SETQ SL NIL)
             (SETQ |ct| (CDR |ct|))
             (SETQ |cm| (CDR |cm|))
             (SETQ |b| 'T)
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT (AND |ct| |cm| |b|)) (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |xt| (CAR |ct|))
                         (SETQ |ct| (CDR |ct|))
                         (SETQ |xm| (CAR |cm|))
                         (SETQ |cm| (CDR |cm|))
                         (COND
                          ((AND (NULL (ATOM |xm|)) (EQ (CAR |xm|) '|:|)
                                (EQ (CAR |xt|) '|:|)
                                (EQUAL (CADR |xm|) (CADR |xt|)))
                           (SETQ |xm| (CADDR |xm|)) (SETQ |xt| (CADDR |xt|))))
                         (SETQ |b|
                                 (COND ((EQUAL |xt| |xm|) 'T)
                                       (#1#
                                        (AND (|isPatternVar| |xm|)
                                             (COND
                                              ((SETQ |p| (ASSQ |xm| |$Subst|))
                                               (EQUAL |xt| (CDR |p|)))
                                              ((SETQ |p| (ASSQ |xm| SL))
                                               (EQUAL |xt| (CDR |p|)))
                                              (#1#
                                               (SETQ SL
                                                       (|augmentSub| |xm| |xt|
                                                        SL))))))))))))))
             (COND (|b| SL) (#1# '|failed|))))))))

; resolveTMEq2(cm,argm,TL) ==
;   -- [cm,argm] is a deconstructed mode,
;   -- TL is a deconstructed type t
;   [ct,argt,:TL] :=
;     $Coerce => bubbleType TL
;     TL
;   argt0 := argt
;   null TL and
;     null argm => constructM(ct,argt)
; --  null argm => NIL
;     arg := NIL
;     while argt and argm until not tt repeat
;       x1 := first argt
;       argt := rest argt
;       x2 := first argm
;       argm := rest argm
;       tt := resolveTM1(x1,x2) =>
;         arg := CONS(tt,arg)
;     tt and arg = argt0 => constructT(ct, argt0)
;     null argt and null argm and tt and constructM(ct,nreverse arg)

(DEFUN |resolveTMEq2| (|cm| |argm| TL)
  (PROG (|LETTMP#1| |ct| |argt| |argt0| |arg| |x1| |x2| |tt|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (COND (|$Coerce| (|bubbleType| TL)) (#1='T TL)))
      (SETQ |ct| (CAR |LETTMP#1|))
      (SETQ |argt| (CADR . #2=(|LETTMP#1|)))
      (SETQ TL (CDDR . #2#))
      (SETQ |argt0| |argt|)
      (AND (NULL TL)
           (COND ((NULL |argm|) (|constructM| |ct| |argt|))
                 (#1#
                  (PROGN
                   (SETQ |arg| NIL)
                   ((LAMBDA (|bfVar#33|)
                      (LOOP
                       (COND
                        ((OR (NOT (AND |argt| |argm|)) |bfVar#33|)
                         (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |x1| (CAR |argt|))
                          (SETQ |argt| (CDR |argt|))
                          (SETQ |x2| (CAR |argm|))
                          (SETQ |argm| (CDR |argm|))
                          (COND
                           ((SETQ |tt| (|resolveTM1| |x1| |x2|))
                            (SETQ |arg| (CONS |tt| |arg|)))))))
                       (SETQ |bfVar#33| (NULL |tt|))))
                    NIL)
                   (COND
                    ((AND |tt| (EQUAL |arg| |argt0|))
                     (|constructT| |ct| |argt0|))
                    (#1#
                     (AND (NULL |argt|) (NULL |argm|) |tt|
                          (|constructM| |ct| (NREVERSE |arg|)))))))))))))

; resolveTMRed(t,m) ==
;   -- looks for an applicable rewrite rule at any level of t and tries
;   --   to bubble this constructor up to the top to t
;   TL := NIL
;   until b or not t repeat
;     [ct,:argt] := deconstructT t
;     b := not EQ(t,term1RW(['Resolve,t,m],$ResMode)) and
;       [c0,arg0,:TL0] := bubbleType [ct,argt,:TL]
;       null TL0 and
;         l := term1RWall(['Resolve,constructM(c0,arg0),m],$ResMode)
;         for t0 in l until t repeat t := resolveTMRed1 t0
;         l and t
;     b or
;       TL := [ct,argt,:TL]
;       t := argt and last argt
;   b and t

(DEFUN |resolveTMRed| (|t| |m|)
  (PROG (TL |LETTMP#1| |ct| |argt| |c0| |arg0| TL0 |l| |b|)
    (RETURN
     (PROGN
      (SETQ TL NIL)
      ((LAMBDA (|bfVar#34|)
         (LOOP
          (COND (|bfVar#34| (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |LETTMP#1| (|deconstructT| |t|))
                  (SETQ |ct| (CAR |LETTMP#1|))
                  (SETQ |argt| (CDR |LETTMP#1|))
                  (SETQ |b|
                          (AND
                           (NULL
                            (EQ |t|
                                (|term1RW| (LIST '|Resolve| |t| |m|)
                                 |$ResMode|)))
                           (PROGN
                            (SETQ |LETTMP#1|
                                    (|bubbleType|
                                     (CONS |ct| (CONS |argt| TL))))
                            (SETQ |c0| (CAR |LETTMP#1|))
                            (SETQ |arg0| (CADR . #2=(|LETTMP#1|)))
                            (SETQ TL0 (CDDR . #2#))
                            (AND (NULL TL0)
                                 (PROGN
                                  (SETQ |l|
                                          (|term1RWall|
                                           (LIST '|Resolve|
                                                 (|constructM| |c0| |arg0|)
                                                 |m|)
                                           |$ResMode|))
                                  ((LAMBDA (|bfVar#35| |t0| |bfVar#36|)
                                     (LOOP
                                      (COND
                                       ((OR (ATOM |bfVar#35|)
                                            (PROGN
                                             (SETQ |t0| (CAR |bfVar#35|))
                                             NIL)
                                            |bfVar#36|)
                                        (RETURN NIL))
                                       (#1# (SETQ |t| (|resolveTMRed1| |t0|))))
                                      (SETQ |bfVar#35| (CDR |bfVar#35|))
                                      (SETQ |bfVar#36| |t|)))
                                   |l| NIL NIL)
                                  (AND |l| |t|))))))
                  (OR |b|
                      (PROGN
                       (SETQ TL (CONS |ct| (CONS |argt| TL)))
                       (SETQ |t| (AND |argt| (|last| |argt|))))))))
          (SETQ |bfVar#34| (OR |b| (NULL |t|)))))
       NIL)
      (AND |b| |t|)))))

; resolveTMRed1(t) ==
;   -- recursive resolveTMRed which handles all subterms of the form
;   -- (Resolve a b)
;   atom t => t
;   t is ['Resolve,a,b] =>
;     ( a := resolveTMRed1 a ) and ( b := resolveTMRed1 b ) and
;       resolveTM1(a,b)
;   t is ['Incl,a,b] => PAIRP b and member(a,b) and b
;   t is ['Diff,a,b] => PAIRP a and member(b,a) and SETDIFFERENCE(a,[b])
;   t is ['SetIncl,a,b] => PAIRP b and and/[member(x,b) for x in a] and b
;   t is ['SetDiff,a,b] => PAIRP b and PAIRP b and
;                          intersection(a,b) and SETDIFFERENCE(a,b)
;   t is ['VarEqual,a,b] => (a = b) and b
;   t is ['SetComp,a,b] => PAIRP a and PAIRP b and
;     and/[member(x,a) for x in b] and SETDIFFERENCE(a,b)
;   t is ['SimpleAlgebraicExtension,a,b,p] =>  -- this is a hack. RSS
;     ['SimpleAlgebraicExtension, resolveTMRed1 a, resolveTMRed1 b,p]
;   [( atom x and x ) or resolveTMRed1 x or return NIL for x in t]

(DEFUN |resolveTMRed1| (|t|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |ISTMP#3| |p|)
    (RETURN
     (COND ((ATOM |t|) |t|)
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Resolve|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
            (AND (SETQ |a| (|resolveTMRed1| |a|))
                 (SETQ |b| (|resolveTMRed1| |b|)) (|resolveTM1| |a| |b|)))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Incl|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND (CONSP |b|) (|member| |a| |b|) |b|))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Diff|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND (CONSP |a|) (|member| |b| |a|)
                 (SETDIFFERENCE |a| (LIST |b|))))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|SetIncl|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND (CONSP |b|)
                 ((LAMBDA (|bfVar#38| |bfVar#37| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#37|)
                           (PROGN (SETQ |x| (CAR |bfVar#37|)) NIL))
                       (RETURN |bfVar#38|))
                      (#1#
                       (PROGN
                        (SETQ |bfVar#38| (|member| |x| |b|))
                        (COND ((NOT |bfVar#38|) (RETURN NIL))))))
                     (SETQ |bfVar#37| (CDR |bfVar#37|))))
                  T |a| NIL)
                 |b|))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|SetDiff|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND (CONSP |b|) (CONSP |b|) (|intersection| |a| |b|)
                 (SETDIFFERENCE |a| |b|)))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|VarEqual|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND (EQUAL |a| |b|) |b|))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|SetComp|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
            (AND (CONSP |a|) (CONSP |b|)
                 ((LAMBDA (|bfVar#40| |bfVar#39| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#39|)
                           (PROGN (SETQ |x| (CAR |bfVar#39|)) NIL))
                       (RETURN |bfVar#40|))
                      (#1#
                       (PROGN
                        (SETQ |bfVar#40| (|member| |x| |a|))
                        (COND ((NOT |bfVar#40|) (RETURN NIL))))))
                     (SETQ |bfVar#39| (CDR |bfVar#39|))))
                  T |b| NIL)
                 (SETDIFFERENCE |a| |b|)))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|SimpleAlgebraicExtension|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |b| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |p| (CAR |ISTMP#3|))
                                    #1#))))))))
            (LIST '|SimpleAlgebraicExtension| (|resolveTMRed1| |a|)
                  (|resolveTMRed1| |b|) |p|))
           (#1#
            ((LAMBDA (|bfVar#42| |bfVar#41| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#41|)
                      (PROGN (SETQ |x| (CAR |bfVar#41|)) NIL))
                  (RETURN (NREVERSE |bfVar#42|)))
                 (#1#
                  (SETQ |bfVar#42|
                          (CONS
                           (OR (AND (ATOM |x|) |x|) (|resolveTMRed1| |x|)
                               (RETURN NIL))
                           |bfVar#42|))))
                (SETQ |bfVar#41| (CDR |bfVar#41|))))
             NIL |t| NIL))))))

; getUnderModeOf d ==
;   not PAIRP d => NIL
;   for a in rest d for m in rest destructT d repeat
;     if m then return a

(DEFUN |getUnderModeOf| (|d|)
  (PROG ()
    (RETURN
     (COND ((NULL (CONSP |d|)) NIL)
           (#1='T
            ((LAMBDA (|bfVar#43| |a| |bfVar#44| |m|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#43|) (PROGN (SETQ |a| (CAR |bfVar#43|)) NIL)
                      (ATOM |bfVar#44|)
                      (PROGN (SETQ |m| (CAR |bfVar#44|)) NIL))
                  (RETURN NIL))
                 (#1# (COND (|m| (RETURN |a|)))))
                (SETQ |bfVar#43| (CDR |bfVar#43|))
                (SETQ |bfVar#44| (CDR |bfVar#44|))))
             (CDR |d|) NIL (CDR (|destructT| |d|)) NIL))))))

; deconstructT(t) ==
;   -- M is a type, which may contain type variables
;   -- results in a pair (type constructor . mode arguments)
;   IFCDR t and constructor? first t =>
;     dt := destructT first t
;     args := [ x for d in dt for y in t | ( x := d and y ) ]
;     c := [ x for d in dt for y in t | ( x := not d and y ) ]
;     CONS(c,args)
;   CONS(t,NIL)

(DEFUN |deconstructT| (|t|)
  (PROG (|dt| |x| |args| |c|)
    (RETURN
     (COND
      ((AND (IFCDR |t|) (|constructor?| (CAR |t|)))
       (PROGN
        (SETQ |dt| (|destructT| (CAR |t|)))
        (SETQ |args|
                ((LAMBDA (|bfVar#47| |bfVar#45| |d| |bfVar#46| |y|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#45|)
                          (PROGN (SETQ |d| (CAR |bfVar#45|)) NIL)
                          (ATOM |bfVar#46|)
                          (PROGN (SETQ |y| (CAR |bfVar#46|)) NIL))
                      (RETURN (NREVERSE |bfVar#47|)))
                     (#1='T
                      (AND (SETQ |x| (AND |d| |y|))
                           (SETQ |bfVar#47| (CONS |x| |bfVar#47|)))))
                    (SETQ |bfVar#45| (CDR |bfVar#45|))
                    (SETQ |bfVar#46| (CDR |bfVar#46|))))
                 NIL |dt| NIL |t| NIL))
        (SETQ |c|
                ((LAMBDA (|bfVar#50| |bfVar#48| |d| |bfVar#49| |y|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#48|)
                          (PROGN (SETQ |d| (CAR |bfVar#48|)) NIL)
                          (ATOM |bfVar#49|)
                          (PROGN (SETQ |y| (CAR |bfVar#49|)) NIL))
                      (RETURN (NREVERSE |bfVar#50|)))
                     (#1#
                      (AND (SETQ |x| (AND (NULL |d|) |y|))
                           (SETQ |bfVar#50| (CONS |x| |bfVar#50|)))))
                    (SETQ |bfVar#48| (CDR |bfVar#48|))
                    (SETQ |bfVar#49| (CDR |bfVar#49|))))
                 NIL |dt| NIL |t| NIL))
        (CONS |c| |args|)))
      (#1# (CONS |t| NIL))))))

; constructT(c,A) ==
;   -- c is a type constructor, A a list of argument types
;   A => [if d then POP A else POP c for d in destructT first c]
;   c

(DEFUN |constructT| (|c| A)
  (PROG ()
    (RETURN
     (COND
      (A
       ((LAMBDA (|bfVar#52| |bfVar#51| |d|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#51|) (PROGN (SETQ |d| (CAR |bfVar#51|)) NIL))
             (RETURN (NREVERSE |bfVar#52|)))
            (#1='T
             (SETQ |bfVar#52|
                     (CONS (COND (|d| (POP A)) (#1# (POP |c|))) |bfVar#52|))))
           (SETQ |bfVar#51| (CDR |bfVar#51|))))
        NIL (|destructT| (CAR |c|)) NIL))
      (#1# |c|)))))

; constructM(c,A) ==
;   -- replaces top level RE's or QF's by equivalent types, if possible
;   #c > 1 and nontrivialCosig(first(c)) => nil
;   containsVars(c) or containsVars(A) => NIL
;   -- collapses illegal FE's
;   first(c) = $FunctionalExpression => defaultTargetFE first A
;   constructT(c,A)

(DEFUN |constructM| (|c| A)
  (PROG ()
    (RETURN
     (COND ((AND (< 1 (LENGTH |c|)) (|nontrivialCosig| (CAR |c|))) NIL)
           ((OR (|containsVars| |c|) (|containsVars| A)) NIL)
           ((EQUAL (CAR |c|) |$FunctionalExpression|)
            (|defaultTargetFE| (CAR A)))
           ('T (|constructT| |c| A))))))

; replaceLast(A,t) ==
;   -- replaces the last element of the nonempty list A by t (constructively
;   nreverse RPLACA(reverse A,t)

(DEFUN |replaceLast| (A |t|)
  (PROG () (RETURN (NREVERSE (RPLACA (REVERSE A) |t|)))))

; nontrivialCosig(x) ==
;    cs := GETDATABASE(x, "COSIG")
;    sig := getConstructorSignature x
;    not("and"/[c or freeOfSharpVars s for c in rest cs for s in rest sig])

(DEFUN |nontrivialCosig| (|x|)
  (PROG (|cs| |sig|)
    (RETURN
     (PROGN
      (SETQ |cs| (GETDATABASE |x| 'COSIG))
      (SETQ |sig| (|getConstructorSignature| |x|))
      (NULL
       ((LAMBDA (|bfVar#55| |bfVar#53| |c| |bfVar#54| |s|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#53|) (PROGN (SETQ |c| (CAR |bfVar#53|)) NIL)
                 (ATOM |bfVar#54|) (PROGN (SETQ |s| (CAR |bfVar#54|)) NIL))
             (RETURN |bfVar#55|))
            ('T
             (PROGN
              (SETQ |bfVar#55| (OR |c| (|freeOfSharpVars| |s|)))
              (COND ((NOT |bfVar#55|) (RETURN NIL))))))
           (SETQ |bfVar#53| (CDR |bfVar#53|))
           (SETQ |bfVar#54| (CDR |bfVar#54|))))
        T (CDR |cs|) NIL (CDR |sig|) NIL))))))

; destructT(functor)==
;   -- provides a list of booleans, which indicate whether the arguments
;   -- to the functor are category forms or not
;   GETDATABASE(opOf functor,'COSIG)

(DEFUN |destructT| (|functor|)
  (PROG () (RETURN (GETDATABASE (|opOf| |functor|) 'COSIG))))

; constructTowerT(t,TL) ==
;   -- t is a type, TL a list of constructors and argument lists
;   -- t is embedded into TL
;   while TL and t repeat
;     [c,arg,:TL] := TL
;     t0 := constructM(c,replaceLast(arg,t))
;     t := canCoerceFrom(t,t0) and t0
;   t

(DEFUN |constructTowerT| (|t| TL)
  (PROG (|LETTMP#1| |c| |arg| |t0|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (AND TL |t|)) (RETURN NIL))
                ('T
                 (PROGN
                  (SETQ |LETTMP#1| TL)
                  (SETQ |c| (CAR |LETTMP#1|))
                  (SETQ |arg| (CADR . #1=(|LETTMP#1|)))
                  (SETQ TL (CDDR . #1#))
                  (SETQ |t0| (|constructM| |c| (|replaceLast| |arg| |t|)))
                  (SETQ |t| (AND (|canCoerceFrom| |t| |t0|) |t0|))))))))
      |t|))))

; bubbleType(TL) ==
;   -- tries to move the last constructor in TL upwards
;   -- uses canCoerceFrom to test whether two constructors can be bubbled
;   [c1,arg1,:T1] := TL
;   null T1 or null arg1 => TL
;   [c2,arg2,:T2] := T1
;   t := last arg1
;   t2 := constructM(c2,replaceLast(arg2,t))
;   arg1 := replaceLast(arg1,t2)
;   newCanCoerceCommute(c2,c1) or canCoerceCommute(c2, c1) =>
;     bubbleType [c1,arg1,:T2]
;   TL

(DEFUN |bubbleType| (TL)
  (PROG (|c1| |arg1| T1 |c2| |arg2| T2 |t| |t2|)
    (RETURN
     (PROGN
      (SETQ |c1| (CAR TL))
      (SETQ |arg1| (CADR . #1=(TL)))
      (SETQ T1 (CDDR . #1#))
      (COND ((OR (NULL T1) (NULL |arg1|)) TL)
            (#2='T
             (PROGN
              (SETQ |c2| (CAR T1))
              (SETQ |arg2| (CADR . #3=(T1)))
              (SETQ T2 (CDDR . #3#))
              (SETQ |t| (|last| |arg1|))
              (SETQ |t2| (|constructM| |c2| (|replaceLast| |arg2| |t|)))
              (SETQ |arg1| (|replaceLast| |arg1| |t2|))
              (COND
               ((OR (|newCanCoerceCommute| |c2| |c1|)
                    (|canCoerceCommute| |c2| |c1|))
                (|bubbleType| (CONS |c1| (CONS |arg1| T2))))
               (#2# TL)))))))))

; bubbleConstructor(TL) ==
;   -- TL is a nonempty list of type constructors and nonempty argument
;   -- lists representing a deconstructed type
;   -- then the lowest constructor is bubbled to the top
;   [c,arg,:T1] := TL
;   t := last arg
;   until null T1 repeat
;     [c1,arg1,:T1] := T1
;     arg1 := replaceLast(arg1,t)
;     t := constructT(c1,arg1)
;   constructT(c,replaceLast(arg,t))

(DEFUN |bubbleConstructor| (TL)
  (PROG (|c| |arg| T1 |t| |LETTMP#1| |c1| |arg1|)
    (RETURN
     (PROGN
      (SETQ |c| (CAR TL))
      (SETQ |arg| (CADR . #1=(TL)))
      (SETQ T1 (CDDR . #1#))
      (SETQ |t| (|last| |arg|))
      ((LAMBDA (|bfVar#56|)
         (LOOP
          (COND (|bfVar#56| (RETURN NIL))
                ('T
                 (PROGN
                  (SETQ |LETTMP#1| T1)
                  (SETQ |c1| (CAR |LETTMP#1|))
                  (SETQ |arg1| (CADR . #2=(|LETTMP#1|)))
                  (SETQ T1 (CDDR . #2#))
                  (SETQ |arg1| (|replaceLast| |arg1| |t|))
                  (SETQ |t| (|constructT| |c1| |arg1|)))))
          (SETQ |bfVar#56| (NULL T1))))
       NIL)
      (|constructT| |c| (|replaceLast| |arg| |t|))))))

; compareTT(t1,t2) ==
;   -- 'T if type t1 is more nested than t2
;   -- otherwise 'T if t1 is lexicographically greater than t2
;   EQCAR(t1,$QuotientField) or
;     MEMQ(opOf t2,[$QuotientField, 'SimpleAlgebraicExtension]) => NIL
;     CGREATERP(PRIN2CVEC opOf t1,PRIN2CVEC opOf t2)

(DEFUN |compareTT| (|t1| |t2|)
  (PROG ()
    (RETURN
     (OR (EQCAR |t1| |$QuotientField|)
         (COND
          ((MEMQ (|opOf| |t2|)
                 (LIST |$QuotientField| '|SimpleAlgebraicExtension|))
           NIL)
          ('T
           (CGREATERP (PRIN2CVEC (|opOf| |t1|)) (PRIN2CVEC (|opOf| |t2|)))))))))

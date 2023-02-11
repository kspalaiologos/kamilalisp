
; )package "BOOT"

(IN-PACKAGE "BOOT")

; canCoerceFrom(mr,m) ==
;   -- bind flag for recording/reporting instantiations
;   -- (see recordInstantiation)
;   $insideCanCoerceFrom: local := [mr,m]
;   canCoerceFrom0(mr,m)

(DEFUN |canCoerceFrom;| (|mr| |m|)
  (PROG (|$insideCanCoerceFrom|)
    (DECLARE (SPECIAL |$insideCanCoerceFrom|))
    (RETURN
     (PROGN
      (SETQ |$insideCanCoerceFrom| (LIST |mr| |m|))
      (|canCoerceFrom0| |mr| |m|)))))
(DEFUN |canCoerceFrom| (&REST |bfVar#1|)
  (PROG (|bfVar#2|)
    (RETURN
     (COND
      ((NOT
        (EQ
         (SETF |bfVar#2| #1=(GETHASH |bfVar#1| |canCoerceFrom;AL| #2='#:G115))
         #2#))
       |bfVar#2|)
      ('T (SETF #1# (APPLY #'|canCoerceFrom;| |bfVar#1|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|canCoerceFrom| '|cacheInfo|)
          '(|canCoerceFrom| |canCoerceFrom;AL| |hash-table|
            (SETQ |canCoerceFrom;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |canCoerceFrom;AL|))))
(EVAL-WHEN (EVAL LOAD) (SETQ |canCoerceFrom;AL| (MAKE_HASHTABLE 'UEQUAL)))

; canCoerce(t1, t2) ==
;   val := canCoerce1(t1, t2) => val
;   t1 is ['Variable, :.] =>
;     newMode := getMinimalVarMode(t1, nil)
;     canCoerce1(t1, newMode) and canCoerce1(newMode, t2)
;   nil

(DEFUN |canCoerce;| (|t1| |t2|)
  (PROG (|val| |newMode|)
    (RETURN
     (COND ((SETQ |val| (|canCoerce1| |t1| |t2|)) |val|)
           ((AND (CONSP |t1|) (EQ (CAR |t1|) '|Variable|))
            (PROGN
             (SETQ |newMode| (|getMinimalVarMode| |t1| NIL))
             (AND (|canCoerce1| |t1| |newMode|)
                  (|canCoerce1| |newMode| |t2|))))
           ('T NIL)))))
(DEFUN |canCoerce| (&REST |bfVar#3|)
  (PROG (|bfVar#4|)
    (RETURN
     (COND
      ((NOT
        (EQ (SETF |bfVar#4| #1=(GETHASH |bfVar#3| |canCoerce;AL| #2='#:G116))
            #2#))
       |bfVar#4|)
      ('T (SETF #1# (APPLY #'|canCoerce;| |bfVar#3|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|canCoerce| '|cacheInfo|)
          '(|canCoerce| |canCoerce;AL| |hash-table|
            (SETQ |canCoerce;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |canCoerce;AL|))))
(EVAL-WHEN (EVAL LOAD) (SETQ |canCoerce;AL| (MAKE_HASHTABLE 'UEQUAL)))

; isValidType form ==
;   -- returns true IFF form is a type whose arguments satisfy the
;   --  predicate of the type constructor
;   -- Note that some forms are said to be invalid because they would
;   -- cause problems with the interpreter. Thus things like P P I
;   -- are not valid.
;   STRINGP form => true
;   IDENTP  form => false
;   form in '((Mode) (Type) (Category)) => true
;   form is ['Record,:selectors] =>
;     and/[isValidType type for [:.,type] in selectors]
;   form is ['Enumeration,:args] =>
;     null (and/[IDENTP x for x in args]) => false
;     ((# args) = (# REMDUP args)) => true
;     false
;   form is ['Mapping,:mapargs] =>
;     null mapargs => NIL
;     and/[isValidType type for type in mapargs]
;   form is ['Union,:args] =>
;     -- check for a tagged union
;     args and first args is [":",:.] =>
;       and/[isValidType type for [:.,type] in args]
;     null (and/[isValidType arg for arg in args]) => NIL
;     ((# args) = (# REMDUP args)) => true
;     sayKeyedMsg("S2IR0005",[form])
;     NIL
;
;   badDoubles := CONS($QuotientField, '(Complex Polynomial Expression))
;   form is [T1, [T2, :.]] and T1 = T2 and member(T1, badDoubles) => NIL
;
;   form is [=$QuotientField,D] and not isPartialMode(D) and
;     ofCategory(D,'(Field)) => NIL
;   form is ['UnivariatePolynomial, x, ['UnivariatePolynomial, y, .]] and x=y =>
;     NIL
;   form = '(Complex (AlgebraicNumber)) => NIL
;   form is ['Expression, ['Kernel, . ]] => NIL
;   form is [op,:argl] =>
;     null constructor? op => nil
;     cosig := GETDATABASE(op, 'COSIG)
;     cosig and null rest cosig => -- niladic constructor
;         null argl => true
;         false
;     null (sig := getConstructorSignature form) => nil
;     [.,:cl] := sig
;     -- following line is needed to deal with mutable domains
;     if # cl ~= # argl and GENSYMP last argl then argl:= DROP(-1,argl)
;     # cl ~= # argl => nil
;     cl:= replaceSharps(cl,form)
;     and/[isValid for x in argl for c in cl] where isValid ==
;       categoryForm?(c) =>
;         evalCategory(x,MSUBSTQ(x,'_$,c)) and isValidType x
;       not (GETDATABASE(opOf x, 'CONSTRUCTORKIND) = 'domain)

(DEFUN |isValidType;| (|form|)
  (PROG (|selectors| |ISTMP#1| |type| |args| |mapargs| |badDoubles| T1
         |ISTMP#2| T2 D |x| |ISTMP#3| |ISTMP#4| |y| |ISTMP#5| |op| |argl|
         |cosig| |sig| |cl|)
    (RETURN
     (COND ((STRINGP |form|) T) ((IDENTP |form|) NIL)
           ((|member| |form| '((|Mode|) (|Type|) (|Category|))) T)
           ((AND (CONSP |form|) (EQ (CAR |form|) '|Record|)
                 (PROGN (SETQ |selectors| (CDR |form|)) #1='T))
            ((LAMBDA (|bfVar#7| |bfVar#6| |bfVar#5|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#6|)
                      (PROGN (SETQ |bfVar#5| (CAR |bfVar#6|)) NIL))
                  (RETURN |bfVar#7|))
                 (#1#
                  (AND (CONSP |bfVar#5|)
                       (PROGN (SETQ |ISTMP#1| (REVERSE |bfVar#5|)) #1#)
                       (CONSP |ISTMP#1|)
                       (PROGN (SETQ |type| (CAR |ISTMP#1|)) #1#)
                       (PROGN
                        (SETQ |bfVar#7| (|isValidType| |type|))
                        (COND ((NOT |bfVar#7|) (RETURN NIL)))))))
                (SETQ |bfVar#6| (CDR |bfVar#6|))))
             T |selectors| NIL))
           ((AND (CONSP |form|) (EQ (CAR |form|) '|Enumeration|)
                 (PROGN (SETQ |args| (CDR |form|)) #1#))
            (COND
             ((NULL
               ((LAMBDA (|bfVar#9| |bfVar#8| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#8|)
                         (PROGN (SETQ |x| (CAR |bfVar#8|)) NIL))
                     (RETURN |bfVar#9|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#9| (IDENTP |x|))
                      (COND ((NOT |bfVar#9|) (RETURN NIL))))))
                   (SETQ |bfVar#8| (CDR |bfVar#8|))))
                T |args| NIL))
              NIL)
             ((EQL (LENGTH |args|) (LENGTH (REMDUP |args|))) T) (#1# NIL)))
           ((AND (CONSP |form|) (EQ (CAR |form|) '|Mapping|)
                 (PROGN (SETQ |mapargs| (CDR |form|)) #1#))
            (COND ((NULL |mapargs|) NIL)
                  (#1#
                   ((LAMBDA (|bfVar#11| |bfVar#10| |type|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#10|)
                             (PROGN (SETQ |type| (CAR |bfVar#10|)) NIL))
                         (RETURN |bfVar#11|))
                        (#1#
                         (PROGN
                          (SETQ |bfVar#11| (|isValidType| |type|))
                          (COND ((NOT |bfVar#11|) (RETURN NIL))))))
                       (SETQ |bfVar#10| (CDR |bfVar#10|))))
                    T |mapargs| NIL))))
           ((AND (CONSP |form|) (EQ (CAR |form|) '|Union|)
                 (PROGN (SETQ |args| (CDR |form|)) #1#))
            (COND
             ((AND |args|
                   (PROGN
                    (SETQ |ISTMP#1| (CAR |args|))
                    (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|))))
              ((LAMBDA (|bfVar#14| |bfVar#13| |bfVar#12|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#13|)
                        (PROGN (SETQ |bfVar#12| (CAR |bfVar#13|)) NIL))
                    (RETURN |bfVar#14|))
                   (#1#
                    (AND (CONSP |bfVar#12|)
                         (PROGN (SETQ |ISTMP#1| (REVERSE |bfVar#12|)) #1#)
                         (CONSP |ISTMP#1|)
                         (PROGN (SETQ |type| (CAR |ISTMP#1|)) #1#)
                         (PROGN
                          (SETQ |bfVar#14| (|isValidType| |type|))
                          (COND ((NOT |bfVar#14|) (RETURN NIL)))))))
                  (SETQ |bfVar#13| (CDR |bfVar#13|))))
               T |args| NIL))
             ((NULL
               ((LAMBDA (|bfVar#16| |bfVar#15| |arg|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#15|)
                         (PROGN (SETQ |arg| (CAR |bfVar#15|)) NIL))
                     (RETURN |bfVar#16|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#16| (|isValidType| |arg|))
                      (COND ((NOT |bfVar#16|) (RETURN NIL))))))
                   (SETQ |bfVar#15| (CDR |bfVar#15|))))
                T |args| NIL))
              NIL)
             ((EQL (LENGTH |args|) (LENGTH (REMDUP |args|))) T)
             (#1# (PROGN (|sayKeyedMsg| 'S2IR0005 (LIST |form|)) NIL))))
           (#1#
            (PROGN
             (SETQ |badDoubles|
                     (CONS |$QuotientField|
                           '(|Complex| |Polynomial| |Expression|)))
             (COND
              ((AND (CONSP |form|)
                    (PROGN
                     (SETQ T1 (CAR |form|))
                     (SETQ |ISTMP#1| (CDR |form|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (PROGN
                           (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (PROGN (SETQ T2 (CAR |ISTMP#2|)) #1#)))))
                    (EQUAL T1 T2) (|member| T1 |badDoubles|))
               NIL)
              ((AND (CONSP |form|) (EQUAL (CAR |form|) |$QuotientField|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |form|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (PROGN (SETQ D (CAR |ISTMP#1|)) #1#)))
                    (NULL (|isPartialMode| D)) (|ofCategory| D '(|Field|)))
               NIL)
              ((AND (CONSP |form|) (EQ (CAR |form|) '|UnivariatePolynomial|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |form|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |x| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN
                                 (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CAR |ISTMP#3|)
                                          '|UnivariatePolynomial|)
                                      (PROGN
                                       (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                       (AND (CONSP |ISTMP#4|)
                                            (PROGN
                                             (SETQ |y| (CAR |ISTMP#4|))
                                             (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                             (AND (CONSP |ISTMP#5|)
                                                  (EQ (CDR |ISTMP#5|)
                                                      NIL)))))))))))
                    (EQUAL |x| |y|))
               NIL)
              ((EQUAL |form| '(|Complex| (|AlgebraicNumber|))) NIL)
              ((AND (CONSP |form|) (EQ (CAR |form|) '|Expression|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |form|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (PROGN
                           (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (EQ (CAR |ISTMP#2|) '|Kernel|)
                                (PROGN
                                 (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CDR |ISTMP#3|) NIL))))))))
               NIL)
              ((AND (CONSP |form|)
                    (PROGN
                     (SETQ |op| (CAR |form|))
                     (SETQ |argl| (CDR |form|))
                     #1#))
               (COND ((NULL (|constructor?| |op|)) NIL)
                     (#1#
                      (PROGN
                       (SETQ |cosig| (GETDATABASE |op| 'COSIG))
                       (COND
                        ((AND |cosig| (NULL (CDR |cosig|)))
                         (COND ((NULL |argl|) T) (#1# NIL)))
                        ((NULL (SETQ |sig| (|getConstructorSignature| |form|)))
                         NIL)
                        (#1#
                         (PROGN
                          (SETQ |cl| (CDR |sig|))
                          (COND
                           ((AND (NOT (EQL (LENGTH |cl|) (LENGTH |argl|)))
                                 (GENSYMP (|last| |argl|)))
                            (SETQ |argl| (DROP (- 1) |argl|))))
                          (COND ((NOT (EQL (LENGTH |cl|) (LENGTH |argl|))) NIL)
                                (#1#
                                 (PROGN
                                  (SETQ |cl| (|replaceSharps| |cl| |form|))
                                  ((LAMBDA
                                       (|bfVar#19| |bfVar#17| |x| |bfVar#18|
                                        |c|)
                                     (LOOP
                                      (COND
                                       ((OR (ATOM |bfVar#17|)
                                            (PROGN
                                             (SETQ |x| (CAR |bfVar#17|))
                                             NIL)
                                            (ATOM |bfVar#18|)
                                            (PROGN
                                             (SETQ |c| (CAR |bfVar#18|))
                                             NIL))
                                        (RETURN |bfVar#19|))
                                       (#1#
                                        (PROGN
                                         (SETQ |bfVar#19|
                                                 (COND
                                                  ((|categoryForm?| |c|)
                                                   (AND
                                                    (|evalCategory| |x|
                                                     (MSUBSTQ |x| '$ |c|))
                                                    (|isValidType| |x|)))
                                                  (#1#
                                                   (NULL
                                                    (EQ
                                                     (GETDATABASE (|opOf| |x|)
                                                      'CONSTRUCTORKIND)
                                                     '|domain|)))))
                                         (COND
                                          ((NOT |bfVar#19|) (RETURN NIL))))))
                                      (SETQ |bfVar#17| (CDR |bfVar#17|))
                                      (SETQ |bfVar#18| (CDR |bfVar#18|))))
                                   T |argl| NIL |cl| NIL))))))))))))))))))
(DEFUN |isValidType| (&REST |bfVar#20|)
  (PROG (|bfVar#21|)
    (RETURN
     (COND
      ((NOT
        (EQ
         (SETF |bfVar#21| #1=(GETHASH |bfVar#20| |isValidType;AL| #2='#:G117))
         #2#))
       |bfVar#21|)
      ('T (SETF #1# (APPLY #'|isValidType;| |bfVar#20|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|isValidType| '|cacheInfo|)
          '(|isValidType| |isValidType;AL| |hash-table|
            (SETQ |isValidType;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |isValidType;AL|))))
(EVAL-WHEN (EVAL LOAD) (SETQ |isValidType;AL| (MAKE_HASHTABLE 'UEQUAL)))

; selectMms1(op,tar,args1,args2,$Coerce) ==
;     selectMms2(op,tar,args1,args2,$Coerce)

(DEFUN |selectMms1;| (|op| |tar| |args1| |args2| |$Coerce|)
  (DECLARE (SPECIAL |$Coerce|))
  (PROG () (RETURN (|selectMms2| |op| |tar| |args1| |args2| |$Coerce|))))
(DEFUN |selectMms1| (&REST |bfVar#22|)
  (PROG (|bfVar#23|)
    (RETURN
     (COND
      ((NOT
        (EQ
         (SETF |bfVar#23| #1=(GETHASH |bfVar#22| |selectMms1;AL| #2='#:G118))
         #2#))
       |bfVar#23|)
      ('T (SETF #1# (APPLY #'|selectMms1;| |bfVar#22|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|selectMms1| '|cacheInfo|)
          '(|selectMms1| |selectMms1;AL| |hash-table|
            (SETQ |selectMms1;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |selectMms1;AL|))))
(EVAL-WHEN (EVAL LOAD) (SETQ |selectMms1;AL| (MAKE_HASHTABLE 'UEQUAL)))

; coerceConvertMmSelection(funName,m1,m2) ==
;   -- calls selectMms with $Coerce=NIL and tests for required
;   -- target type. funName is either 'coerce or 'convert.
;   $declaredMode : local:= NIL
;   $reportBottomUpFlag : local:= NIL
;   l := selectMms1(funName,m2,[m1],[m1],NIL)
;   --  mmS := [[sig,[targ,arg],:pred] for x in l | x is [sig,[.,arg],:pred] and
;   mmS := [x for x in l | x is [sig,:.] and hasCorrectTarget(m2,sig) and
;            sig is [dc,targ,oarg] and isEqualOrSubDomain(m1,oarg)]
;   mmS and first mmS

(DEFUN |coerceConvertMmSelection;| (|funName| |m1| |m2|)
  (PROG (|$reportBottomUpFlag| |$declaredMode| |mmS| |oarg| |ISTMP#2| |targ|
         |ISTMP#1| |dc| |sig| |l|)
    (DECLARE (SPECIAL |$reportBottomUpFlag| |$declaredMode|))
    (RETURN
     (PROGN
      (SETQ |$declaredMode| NIL)
      (SETQ |$reportBottomUpFlag| NIL)
      (SETQ |l| (|selectMms1| |funName| |m2| (LIST |m1|) (LIST |m1|) NIL))
      (SETQ |mmS|
              ((LAMBDA (|bfVar#25| |bfVar#24| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#24|)
                        (PROGN (SETQ |x| (CAR |bfVar#24|)) NIL))
                    (RETURN (NREVERSE |bfVar#25|)))
                   (#1='T
                    (AND (CONSP |x|) (PROGN (SETQ |sig| (CAR |x|)) #1#)
                         (|hasCorrectTarget| |m2| |sig|) (CONSP |sig|)
                         (PROGN
                          (SETQ |dc| (CAR |sig|))
                          (SETQ |ISTMP#1| (CDR |sig|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |targ| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |oarg| (CAR |ISTMP#2|))
                                      #1#)))))
                         (|isEqualOrSubDomain| |m1| |oarg|)
                         (SETQ |bfVar#25| (CONS |x| |bfVar#25|)))))
                  (SETQ |bfVar#24| (CDR |bfVar#24|))))
               NIL |l| NIL))
      (AND |mmS| (CAR |mmS|))))))
(DEFUN |coerceConvertMmSelection| (&REST |bfVar#26|)
  (PROG (|bfVar#27|)
    (RETURN
     (COND
      ((NOT
        (EQ
         (SETF |bfVar#27|
                 #1=(GETHASH |bfVar#26| |coerceConvertMmSelection;AL|
                             #2='#:G119))
         #2#))
       |bfVar#27|)
      ('T (SETF #1# (APPLY #'|coerceConvertMmSelection;| |bfVar#26|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|coerceConvertMmSelection| '|cacheInfo|)
          '(|coerceConvertMmSelection| |coerceConvertMmSelection;AL|
            |hash-table|
            (SETQ |coerceConvertMmSelection;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |coerceConvertMmSelection;AL|))))
(EVAL-WHEN (EVAL LOAD)
  (SETQ |coerceConvertMmSelection;AL| (MAKE_HASHTABLE 'UEQUAL)))

; resolveTT(t1,t2) ==
;   -- resolves two types
;   -- this symmetric resolve looks for a type t to which both t1 and t2
;   -- can be coerced
;   -- if resolveTT fails, the result will be NIL
;   startTimingProcess 'resolve
;   null (t := resolveTT1(t1,t2)) =>
;     stopTimingProcess 'resolve
;     nil
;   isValidType (t) =>
;     stopTimingProcess 'resolve
;     t
;   stopTimingProcess 'resolve
;   nil

(DEFUN |resolveTT;| (|t1| |t2|)
  (PROG (|t|)
    (RETURN
     (PROGN
      (|startTimingProcess| '|resolve|)
      (COND
       ((NULL (SETQ |t| (|resolveTT1| |t1| |t2|)))
        (PROGN (|stopTimingProcess| '|resolve|) NIL))
       ((|isValidType| |t|) (PROGN (|stopTimingProcess| '|resolve|) |t|))
       ('T (PROGN (|stopTimingProcess| '|resolve|) NIL)))))))
(DEFUN |resolveTT| (&REST |bfVar#28|)
  (PROG (|bfVar#29|)
    (RETURN
     (COND
      ((NOT
        (EQ (SETF |bfVar#29| #1=(GETHASH |bfVar#28| |resolveTT;AL| #2='#:G120))
            #2#))
       |bfVar#29|)
      ('T (SETF #1# (APPLY #'|resolveTT;| |bfVar#28|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|resolveTT| '|cacheInfo|)
          '(|resolveTT| |resolveTT;AL| |hash-table|
            (SETQ |resolveTT;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |resolveTT;AL|))))
(EVAL-WHEN (EVAL LOAD) (SETQ |resolveTT;AL| (MAKE_HASHTABLE 'UEQUAL)))

; isLegitimateMode(t,hasPolyMode,polyVarList) ==
;   -- returns true IFF t is a valid type.  i.e. if t has no repeated
;   --  variables, or two levels of Polynomial
;   null t        => true    -- a terminating condition with underDomainOf
;   t = $EmptyMode => true
;   STRINGP t     => true
;   ATOM t => false
;
;   badDoubles := CONS($QuotientField, '(Complex Polynomial Expression))
;   t is [T1, [T2, :.]] and T1 = T2 and member(T1, badDoubles) => NIL
;
;   t is [=$QuotientField,D] and not isPartialMode(D) and
;     ofCategory(D,'(Field)) => NIL
;   t = '(Complex (AlgebraicNumber)) => NIL
;
;   vl := isPolynomialMode t =>
;     if vl~='all then
;       var:= or/[(x in polyVarList => x;nil) for x in vl] => return false
;       listOfDuplicates vl => return false
;       polyVarList:= union(vl,polyVarList)
;     hasPolyMode => false
;     con := first t
;     poly? := (con = 'Polynomial or con = 'Expression)
;     isLegitimateMode(underDomainOf t,poly?,polyVarList)
;
;   constructor? first t =>
;     isLegitimateMode(underDomainOf t,hasPolyMode,polyVarList) => t
;   t is ['Mapping,:ml] =>
;     null ml => NIL
;     -- first arg is target, which can be Void
;     null isLegitimateMode(first ml,nil,nil) => NIL
;     for m in rest ml repeat
;       m = $Void =>
;         return NIL
;       null isLegitimateMode(m,nil,nil) => return NIL
;     true
;   t is ['Union,:ml] =>
;     -- check for tagged union
;     ml and first ml is [":",:.] => isLegitimateRecordOrTaggedUnion ml
;     null (and/[isLegitimateMode(m,nil,nil) for m in ml]) => NIL
;     ((# ml) = (# REMDUP ml)) => true
;     NIL
;   t is ['Record,:r] => isLegitimateRecordOrTaggedUnion r
;   t is ['Enumeration,:r] =>
;     null (and/[IDENTP x for x in r]) => false
;     ((# r) = (# REMDUP r)) => true
;     false
;   false

(DEFUN |isLegitimateMode;| (|t| |hasPolyMode| |polyVarList|)
  (PROG (|badDoubles| T1 |ISTMP#1| |ISTMP#2| T2 D |vl| |var| |con| |poly?| |ml|
         |r|)
    (RETURN
     (COND ((NULL |t|) T) ((EQUAL |t| |$EmptyMode|) T) ((STRINGP |t|) T)
           ((ATOM |t|) NIL)
           (#1='T
            (PROGN
             (SETQ |badDoubles|
                     (CONS |$QuotientField|
                           '(|Complex| |Polynomial| |Expression|)))
             (COND
              ((AND (CONSP |t|)
                    (PROGN
                     (SETQ T1 (CAR |t|))
                     (SETQ |ISTMP#1| (CDR |t|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (PROGN
                           (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (PROGN (SETQ T2 (CAR |ISTMP#2|)) #1#)))))
                    (EQUAL T1 T2) (|member| T1 |badDoubles|))
               NIL)
              ((AND (CONSP |t|) (EQUAL (CAR |t|) |$QuotientField|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |t|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (PROGN (SETQ D (CAR |ISTMP#1|)) #1#)))
                    (NULL (|isPartialMode| D)) (|ofCategory| D '(|Field|)))
               NIL)
              ((EQUAL |t| '(|Complex| (|AlgebraicNumber|))) NIL)
              ((SETQ |vl| (|isPolynomialMode| |t|))
               (PROGN
                (COND
                 ((NOT (EQ |vl| '|all|))
                  (COND
                   ((SETQ |var|
                            ((LAMBDA (|bfVar#31| |bfVar#30| |x|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#30|)
                                      (PROGN (SETQ |x| (CAR |bfVar#30|)) NIL))
                                  (RETURN |bfVar#31|))
                                 (#1#
                                  (PROGN
                                   (SETQ |bfVar#31|
                                           (COND
                                            ((|member| |x| |polyVarList|) |x|)
                                            (#1# NIL)))
                                   (COND (|bfVar#31| (RETURN |bfVar#31|))))))
                                (SETQ |bfVar#30| (CDR |bfVar#30|))))
                             NIL |vl| NIL))
                    (RETURN NIL))
                   ((|listOfDuplicates| |vl|) (RETURN NIL))
                   (#1# (SETQ |polyVarList| (|union| |vl| |polyVarList|))))))
                (COND (|hasPolyMode| NIL)
                      (#1#
                       (PROGN
                        (SETQ |con| (CAR |t|))
                        (SETQ |poly?|
                                (OR (EQ |con| '|Polynomial|)
                                    (EQ |con| '|Expression|)))
                        (|isLegitimateMode| (|underDomainOf| |t|) |poly?|
                         |polyVarList|))))))
              ((|constructor?| (CAR |t|))
               (COND
                ((|isLegitimateMode| (|underDomainOf| |t|) |hasPolyMode|
                  |polyVarList|)
                 (IDENTITY |t|))))
              ((AND (CONSP |t|) (EQ (CAR |t|) '|Mapping|)
                    (PROGN (SETQ |ml| (CDR |t|)) #1#))
               (COND ((NULL |ml|) NIL)
                     ((NULL (|isLegitimateMode| (CAR |ml|) NIL NIL)) NIL)
                     (#1#
                      (PROGN
                       ((LAMBDA (|bfVar#32| |m|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#32|)
                                 (PROGN (SETQ |m| (CAR |bfVar#32|)) NIL))
                             (RETURN NIL))
                            (#1#
                             (COND ((EQUAL |m| |$Void|) (RETURN NIL))
                                   ((NULL (|isLegitimateMode| |m| NIL NIL))
                                    (RETURN NIL)))))
                           (SETQ |bfVar#32| (CDR |bfVar#32|))))
                        (CDR |ml|) NIL)
                       T))))
              ((AND (CONSP |t|) (EQ (CAR |t|) '|Union|)
                    (PROGN (SETQ |ml| (CDR |t|)) #1#))
               (COND
                ((AND |ml|
                      (PROGN
                       (SETQ |ISTMP#1| (CAR |ml|))
                       (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|))))
                 (|isLegitimateRecordOrTaggedUnion| |ml|))
                ((NULL
                  ((LAMBDA (|bfVar#34| |bfVar#33| |m|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#33|)
                            (PROGN (SETQ |m| (CAR |bfVar#33|)) NIL))
                        (RETURN |bfVar#34|))
                       (#1#
                        (PROGN
                         (SETQ |bfVar#34| (|isLegitimateMode| |m| NIL NIL))
                         (COND ((NOT |bfVar#34|) (RETURN NIL))))))
                      (SETQ |bfVar#33| (CDR |bfVar#33|))))
                   T |ml| NIL))
                 NIL)
                ((EQL (LENGTH |ml|) (LENGTH (REMDUP |ml|))) T) (#1# NIL)))
              ((AND (CONSP |t|) (EQ (CAR |t|) '|Record|)
                    (PROGN (SETQ |r| (CDR |t|)) #1#))
               (|isLegitimateRecordOrTaggedUnion| |r|))
              ((AND (CONSP |t|) (EQ (CAR |t|) '|Enumeration|)
                    (PROGN (SETQ |r| (CDR |t|)) #1#))
               (COND
                ((NULL
                  ((LAMBDA (|bfVar#36| |bfVar#35| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#35|)
                            (PROGN (SETQ |x| (CAR |bfVar#35|)) NIL))
                        (RETURN |bfVar#36|))
                       (#1#
                        (PROGN
                         (SETQ |bfVar#36| (IDENTP |x|))
                         (COND ((NOT |bfVar#36|) (RETURN NIL))))))
                      (SETQ |bfVar#35| (CDR |bfVar#35|))))
                   T |r| NIL))
                 NIL)
                ((EQL (LENGTH |r|) (LENGTH (REMDUP |r|))) T) (#1# NIL)))
              (#1# NIL))))))))
(DEFUN |isLegitimateMode| (&REST |bfVar#37|)
  (PROG (|bfVar#38|)
    (RETURN
     (COND
      ((NOT
        (EQ
         (SETF |bfVar#38|
                 #1=(GETHASH |bfVar#37| |isLegitimateMode;AL| #2='#:G121))
         #2#))
       |bfVar#38|)
      ('T (SETF #1# (APPLY #'|isLegitimateMode;| |bfVar#37|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|isLegitimateMode| '|cacheInfo|)
          '(|isLegitimateMode| |isLegitimateMode;AL| |hash-table|
            (SETQ |isLegitimateMode;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |isLegitimateMode;AL|))))
(EVAL-WHEN (EVAL LOAD) (SETQ |isLegitimateMode;AL| (MAKE_HASHTABLE 'UEQUAL)))

; underDomainOf t ==
;   t = $RationalNumber => $Integer
;   not PAIRP t => NIL
;   d := deconstructT t
;   1 = #d => NIL
;   u := getUnderModeOf(t) => u
;   last d

(DEFUN |underDomainOf;| (|t|)
  (PROG (|d| |u|)
    (RETURN
     (COND ((EQUAL |t| |$RationalNumber|) |$Integer|) ((NULL (CONSP |t|)) NIL)
           (#1='T
            (PROGN
             (SETQ |d| (|deconstructT| |t|))
             (COND ((EQL 1 (LENGTH |d|)) NIL)
                   ((SETQ |u| (|getUnderModeOf| |t|)) |u|)
                   (#1# (|last| |d|)))))))))
(DEFUN |underDomainOf| (&REST |bfVar#39|)
  (PROG (|bfVar#40|)
    (RETURN
     (COND
      ((NOT
        (EQ
         (SETF |bfVar#40|
                 #1=(GETHASH |bfVar#39| |underDomainOf;AL| #2='#:G122))
         #2#))
       |bfVar#40|)
      ('T (SETF #1# (APPLY #'|underDomainOf;| |bfVar#39|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|underDomainOf| '|cacheInfo|)
          '(|underDomainOf| |underDomainOf;AL| |hash-table|
            (SETQ |underDomainOf;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |underDomainOf;AL|))))
(EVAL-WHEN (EVAL LOAD) (SETQ |underDomainOf;AL| (MAKE_HASHTABLE 'UEQUAL)))

; findRetractMms(st, tt) == findRetractMms1(st, tt)

(DEFUN |findRetractMms;| (|st| |tt|)
  (PROG () (RETURN (|findRetractMms1| |st| |tt|))))
(DEFUN |findRetractMms| (&REST |bfVar#41|)
  (PROG (|bfVar#42|)
    (RETURN
     (COND
      ((NOT
        (EQ
         (SETF |bfVar#42|
                 #1=(GETHASH |bfVar#41| |findRetractMms;AL| #2='#:G123))
         #2#))
       |bfVar#42|)
      ('T (SETF #1# (APPLY #'|findRetractMms;| |bfVar#41|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|findRetractMms| '|cacheInfo|)
          '(|findRetractMms| |findRetractMms;AL| |hash-table|
            (SETQ |findRetractMms;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |findRetractMms;AL|))))
(EVAL-WHEN (EVAL LOAD) (SETQ |findRetractMms;AL| (MAKE_HASHTABLE 'UEQUAL)))

; getConstantFromDomain(form,domainForm) ==
;     getConstantFromDomain1(form,domainForm)

(DEFUN |getConstantFromDomain;| (|form| |domainForm|)
  (PROG () (RETURN (|getConstantFromDomain1| |form| |domainForm|))))
(DEFUN |getConstantFromDomain| (&REST |bfVar#43|)
  (PROG (|bfVar#44|)
    (RETURN
     (COND
      ((NOT
        (EQ
         (SETF |bfVar#44|
                 #1=(GETHASH |bfVar#43| |getConstantFromDomain;AL| #2='#:G124))
         #2#))
       |bfVar#44|)
      ('T (SETF #1# (APPLY #'|getConstantFromDomain;| |bfVar#43|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|getConstantFromDomain| '|cacheInfo|)
          '(|getConstantFromDomain| |getConstantFromDomain;AL| |hash-table|
            (SETQ |getConstantFromDomain;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |getConstantFromDomain;AL|))))
(EVAL-WHEN (EVAL LOAD)
  (SETQ |getConstantFromDomain;AL| (MAKE_HASHTABLE 'UEQUAL)))

; interpLookup(funName, sig, dc) ==
;     dcVector:= evalDomain dc
;     NRTcompiledLookup(funName, sig, dcVector)

(DEFUN |interpLookup;| (|funName| |sig| |dc|)
  (PROG (|dcVector|)
    (RETURN
     (PROGN
      (SETQ |dcVector| (|evalDomain| |dc|))
      (|NRTcompiledLookup| |funName| |sig| |dcVector|)))))
(DEFUN |interpLookup| (&REST |bfVar#45|)
  (PROG (|bfVar#46|)
    (RETURN
     (COND
      ((NOT
        (EQ
         (SETF |bfVar#46| #1=(GETHASH |bfVar#45| |interpLookup;AL| #2='#:G125))
         #2#))
       |bfVar#46|)
      ('T (SETF #1# (APPLY #'|interpLookup;| |bfVar#45|)))))))
(EVAL-WHEN (EVAL LOAD)
  (SETF (GET '|interpLookup| '|cacheInfo|)
          '(|interpLookup| |interpLookup;AL| |hash-table|
            (SETQ |interpLookup;AL| (MAKE_HASHTABLE 'UEQUAL))
            (|hashCount| |interpLookup;AL|))))
(EVAL-WHEN (EVAL LOAD) (SETQ |interpLookup;AL| (MAKE_HASHTABLE 'UEQUAL)))

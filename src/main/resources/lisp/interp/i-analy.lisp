
; )package "BOOT"

(IN-PACKAGE "BOOT")

; getBasicMode x ==  getBasicMode0(x,$useIntegerSubdomain)

(DEFUN |getBasicMode| (|x|)
  (PROG () (RETURN (|getBasicMode0| |x| |$useIntegerSubdomain|))))

; getBasicMode0(x,useIntegerSubdomain) ==
;   --  if x is one of the basic types (Integer String Float Boolean) then
;   --  this function returns its type, and nil otherwise
;   x is nil => $EmptyMode
;   STRINGP x => $String
;   INTEGERP x =>
;     useIntegerSubdomain =>
;       x > 0 => $PositiveInteger
;       x = 0 => $NonNegativeInteger
;       $Integer
;     $Integer
;   FLOATP x => $DoubleFloat
;   (x='noBranch) or (x='noValue) => $NoValueMode
;   nil

(DEFUN |getBasicMode0| (|x| |useIntegerSubdomain|)
  (PROG ()
    (RETURN
     (COND ((NULL |x|) |$EmptyMode|) ((STRINGP |x|) |$String|)
           ((INTEGERP |x|)
            (COND
             (|useIntegerSubdomain|
              (COND ((< 0 |x|) |$PositiveInteger|)
                    ((EQL |x| 0) |$NonNegativeInteger|) (#1='T |$Integer|)))
             (#1# |$Integer|)))
           ((FLOATP |x|) |$DoubleFloat|)
           ((OR (EQ |x| '|noBranch|) (EQ |x| '|noValue|)) |$NoValueMode|)
           (#1# NIL)))))

; getBasicObject x ==
;   INTEGERP    x =>
;     t :=
;       not $useIntegerSubdomain => $Integer
;       x > 0 => $PositiveInteger
;       x = 0 => $NonNegativeInteger
;       $Integer
;     objNewWrap(x,t)
;   STRINGP x => objNewWrap(x,$String)
;   FLOATP  x => objNewWrap(x,$DoubleFloat)
;   NIL

(DEFUN |getBasicObject| (|x|)
  (PROG (|t|)
    (RETURN
     (COND
      ((INTEGERP |x|)
       (PROGN
        (SETQ |t|
                (COND ((NULL |$useIntegerSubdomain|) |$Integer|)
                      ((< 0 |x|) |$PositiveInteger|)
                      ((EQL |x| 0) |$NonNegativeInteger|) (#1='T |$Integer|)))
        (|objNewWrap| |x| |t|)))
      ((STRINGP |x|) (|objNewWrap| |x| |$String|))
      ((FLOATP |x|) (|objNewWrap| |x| |$DoubleFloat|)) (#1# NIL)))))

; getMinimalVariableTower(var,t) ==
;   -- gets the minimal polynomial subtower of t that contains the
;   -- given variable. Returns NIL if none.
;   STRINGP(t) or IDENTP(t) => NIL
;   t = $Symbol => t
;   t is ['Variable,u] =>
;     (u = var) => t
;     NIL
;   t is ['Polynomial,.] => t
;   t is [up,t',u,.] and MEMQ(up,$univariateDomains) =>
;     -- power series have one more arg and different ordering
;     u = var => t
;     getMinimalVariableTower(var,t')
;   t is [up,u,t'] and MEMQ(up,$univariateDomains) =>
;     u = var => t
;     getMinimalVariableTower(var,t')
;   t is [mp,u,t'] and MEMQ(mp,$multivariateDomains) =>
;     var in u => t
;     getMinimalVariableTower(var,t')
;   null (t' := underDomainOf t) => NIL
;   getMinimalVariableTower(var,t')

(DEFUN |getMinimalVariableTower| (|var| |t|)
  (PROG (|ISTMP#1| |u| |up| |t'| |ISTMP#2| |ISTMP#3| |mp|)
    (RETURN
     (COND ((OR (STRINGP |t|) (IDENTP |t|)) NIL) ((EQUAL |t| |$Symbol|) |t|)
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Variable|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |u| (CAR |ISTMP#1|)) #1='T))))
            (COND ((EQUAL |u| |var|) |t|) (#1# NIL)))
           ((AND (CONSP |t|) (EQ (CAR |t|) '|Polynomial|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
            |t|)
           ((AND (CONSP |t|)
                 (PROGN
                  (SETQ |up| (CAR |t|))
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |t'| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |u| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|)
                                   (EQ (CDR |ISTMP#3|) NIL)))))))
                 (MEMQ |up| |$univariateDomains|))
            (COND ((EQUAL |u| |var|) |t|)
                  (#1# (|getMinimalVariableTower| |var| |t'|))))
           ((AND (CONSP |t|)
                 (PROGN
                  (SETQ |up| (CAR |t|))
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |u| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |t'| (CAR |ISTMP#2|)) #1#)))))
                 (MEMQ |up| |$univariateDomains|))
            (COND ((EQUAL |u| |var|) |t|)
                  (#1# (|getMinimalVariableTower| |var| |t'|))))
           ((AND (CONSP |t|)
                 (PROGN
                  (SETQ |mp| (CAR |t|))
                  (SETQ |ISTMP#1| (CDR |t|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |u| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |t'| (CAR |ISTMP#2|)) #1#)))))
                 (MEMQ |mp| |$multivariateDomains|))
            (COND ((|member| |var| |u|) |t|)
                  (#1# (|getMinimalVariableTower| |var| |t'|))))
           ((NULL (SETQ |t'| (|underDomainOf| |t|))) NIL)
           (#1# (|getMinimalVariableTower| |var| |t'|))))))

; getMinimalVarMode(id,m) ==
;   --  This function finds the minimum polynomial subtower type of the
;   --  polynomial domain tower m which id to which can be coerced
;   --  It includes all polys above the found level if they are
;   --  contiguous.
;   --  E.g.:    x and G P[y] P[x] I ---> P[y] P[x] I
;   --           x and P[y] G P[x] I ---> P[x] I
;   m is ['Mapping, :.] => m
;   defaultMode :=
;     $Symbol
;   null m => defaultMode
;   (vl := polyVarlist m) and ((id in vl) or 'all in vl) =>
;     SUBSTQ('(Integer),$EmptyMode,m)
;   (um := underDomainOf m) => getMinimalVarMode(id,um)
;   defaultMode

(DEFUN |getMinimalVarMode| (|id| |m|)
  (PROG (|defaultMode| |vl| |um|)
    (RETURN
     (COND ((AND (CONSP |m|) (EQ (CAR |m|) '|Mapping|)) |m|)
           (#1='T
            (PROGN
             (SETQ |defaultMode| |$Symbol|)
             (COND ((NULL |m|) |defaultMode|)
                   ((AND (SETQ |vl| (|polyVarlist| |m|))
                         (OR (|member| |id| |vl|) (|member| '|all| |vl|)))
                    (SUBSTQ '(|Integer|) |$EmptyMode| |m|))
                   ((SETQ |um| (|underDomainOf| |m|))
                    (|getMinimalVarMode| |id| |um|))
                   (#1# |defaultMode|))))))))

; polyVarlist m ==
;   --  If m is a polynomial type this function returns a list of its
;   --  top level variables, and nil otherwise
;   -- ignore any QuotientFields that may separate poly types
;   m is [=$QuotientField,op] => polyVarlist op
;   m is [op,a,:.] =>
;     op in '(UnivariateTaylorSeries UnivariateLaurentSeries
;       UnivariatePuiseuxSeries) =>
;         [., ., a, :.] := m
;         a := removeQuote a
;         [a]
;     op in '(Polynomial Expression) =>
;       '(all)
;     a := removeQuote a
;     op in '(UnivariatePolynomial) =>
;       [a]
;     op in $multivariateDomains =>
;           a
;   nil

(DEFUN |polyVarlist| (|m|)
  (PROG (|ISTMP#1| |op| |a|)
    (RETURN
     (COND
      ((AND (CONSP |m|) (EQUAL (CAR |m|) |$QuotientField|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |m|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |op| (CAR |ISTMP#1|)) #1='T))))
       (|polyVarlist| |op|))
      ((AND (CONSP |m|)
            (PROGN
             (SETQ |op| (CAR |m|))
             (SETQ |ISTMP#1| (CDR |m|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#))))
       (COND
        ((|member| |op|
          '(|UnivariateTaylorSeries| |UnivariateLaurentSeries|
            |UnivariatePuiseuxSeries|))
         (PROGN
          (SETQ |a| (CADDR |m|))
          (SETQ |a| (|removeQuote| |a|))
          (LIST |a|)))
        ((|member| |op| '(|Polynomial| |Expression|)) '(|all|))
        (#1#
         (PROGN
          (SETQ |a| (|removeQuote| |a|))
          (COND ((|member| |op| '(|UnivariatePolynomial|)) (LIST |a|))
                ((|member| |op| |$multivariateDomains|) |a|))))))
      (#1# NIL)))))

; pushDownTargetInfo(op,target,arglist) ==
;   -- put target info on args for certain operations
;   target = $OutputForm => NIL
;   target = $Any        => NIL
;   target is ['Union, dom, tag] and tag = '"failed" => NIL
;   n := LENGTH arglist
;   pushDownOnArithmeticVariables(op,target,arglist)
;   (pdArgs := pushDownOp?(op,n)) =>
;     for i in pdArgs repeat
;       x := arglist.i
;       if not getTarget(x) then putTarget(x,target)
;   nargs := #arglist
;   1 = nargs =>
;     (op = 'SEGMENT) and (target is ['UniversalSegment,S]) =>
;       for x in arglist repeat
;         if not getTarget(x) then putTarget(x,S)
;   2 = nargs =>
;     op = "*" =>            -- only push down on 1st arg if not immed
;       if not getTarget CADR arglist then putTarget(CADR arglist,target)
;       getTarget(x := first arglist) => NIL
;       if getUnname(x) ~= $immediateDataSymbol then putTarget(x,target)
;     op = "**" or op = "^" =>           -- push down on base
;       if not getTarget first arglist then putTarget(first arglist, target)
;     (op = 'equation) and (target is ['Equation,S]) =>
;       for x in arglist repeat
;         if not getTarget(x) then putTarget(x,S)
;     (op = '_/) =>
;       targ :=
;         target is ['Fraction,S] => S
;         target
;       for x in arglist repeat
;         if not getTarget(x) then putTarget(x,targ)
;     (op = 'SEGMENT) and (target is ['Segment,S]) =>
;       for x in arglist repeat
;         if not getTarget(x) then putTarget(x,S)
;     (op = 'SEGMENT) and (target is ['UniversalSegment,S]) =>
;       for x in arglist repeat
;         if not getTarget(x) then putTarget(x,S)
;     NIL
;   NIL

(DEFUN |pushDownTargetInfo| (|op| |target| |arglist|)
  (PROG (|ISTMP#1| |dom| |ISTMP#2| |tag| |n| |pdArgs| |x| |nargs| S |targ|)
    (RETURN
     (COND ((EQUAL |target| |$OutputForm|) NIL) ((EQUAL |target| |$Any|) NIL)
           ((AND (CONSP |target|) (EQ (CAR |target|) '|Union|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |target|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |dom| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |tag| (CAR |ISTMP#2|)) #1='T)))))
                 (EQUAL |tag| "failed"))
            NIL)
           (#1#
            (PROGN
             (SETQ |n| (LENGTH |arglist|))
             (|pushDownOnArithmeticVariables| |op| |target| |arglist|)
             (COND
              ((SETQ |pdArgs| (|pushDownOp?| |op| |n|))
               ((LAMBDA (|bfVar#1| |i|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#1|)
                         (PROGN (SETQ |i| (CAR |bfVar#1|)) NIL))
                     (RETURN NIL))
                    (#1#
                     (PROGN
                      (SETQ |x| (ELT |arglist| |i|))
                      (COND
                       ((NULL (|getTarget| |x|))
                        (|putTarget| |x| |target|))))))
                   (SETQ |bfVar#1| (CDR |bfVar#1|))))
                |pdArgs| NIL))
              (#1#
               (PROGN
                (SETQ |nargs| (LENGTH |arglist|))
                (COND
                 ((EQL 1 |nargs|)
                  (COND
                   ((AND (EQ |op| 'SEGMENT) (CONSP |target|)
                         (EQ (CAR |target|) '|UniversalSegment|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |target|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                               (PROGN (SETQ S (CAR |ISTMP#1|)) #1#))))
                    (IDENTITY
                     ((LAMBDA (|bfVar#2| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#2|)
                               (PROGN (SETQ |x| (CAR |bfVar#2|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (COND
                            ((NULL (|getTarget| |x|)) (|putTarget| |x| S)))))
                         (SETQ |bfVar#2| (CDR |bfVar#2|))))
                      |arglist| NIL)))))
                 ((EQL 2 |nargs|)
                  (COND
                   ((EQ |op| '*)
                    (PROGN
                     (COND
                      ((NULL (|getTarget| (CADR |arglist|)))
                       (|putTarget| (CADR |arglist|) |target|)))
                     (COND ((|getTarget| (SETQ |x| (CAR |arglist|))) NIL)
                           (#1#
                            (COND
                             ((NOT
                               (EQUAL (|getUnname| |x|)
                                      |$immediateDataSymbol|))
                              (|putTarget| |x| |target|)))))))
                   ((OR (EQ |op| '**) (EQ |op| '^))
                    (COND
                     ((NULL (|getTarget| (CAR |arglist|)))
                      (|putTarget| (CAR |arglist|) |target|))))
                   ((AND (EQ |op| '|equation|) (CONSP |target|)
                         (EQ (CAR |target|) '|Equation|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |target|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                               (PROGN (SETQ S (CAR |ISTMP#1|)) #1#))))
                    ((LAMBDA (|bfVar#3| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#3|)
                              (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (COND
                           ((NULL (|getTarget| |x|)) (|putTarget| |x| S)))))
                        (SETQ |bfVar#3| (CDR |bfVar#3|))))
                     |arglist| NIL))
                   ((EQ |op| '/)
                    (PROGN
                     (SETQ |targ|
                             (COND
                              ((AND (CONSP |target|)
                                    (EQ (CAR |target|) '|Fraction|)
                                    (PROGN
                                     (SETQ |ISTMP#1| (CDR |target|))
                                     (AND (CONSP |ISTMP#1|)
                                          (EQ (CDR |ISTMP#1|) NIL)
                                          (PROGN
                                           (SETQ S (CAR |ISTMP#1|))
                                           #1#))))
                               S)
                              (#1# |target|)))
                     ((LAMBDA (|bfVar#4| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#4|)
                               (PROGN (SETQ |x| (CAR |bfVar#4|)) NIL))
                           (RETURN NIL))
                          (#1#
                           (COND
                            ((NULL (|getTarget| |x|))
                             (|putTarget| |x| |targ|)))))
                         (SETQ |bfVar#4| (CDR |bfVar#4|))))
                      |arglist| NIL)))
                   ((AND (EQ |op| 'SEGMENT) (CONSP |target|)
                         (EQ (CAR |target|) '|Segment|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |target|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                               (PROGN (SETQ S (CAR |ISTMP#1|)) #1#))))
                    ((LAMBDA (|bfVar#5| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#5|)
                              (PROGN (SETQ |x| (CAR |bfVar#5|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (COND
                           ((NULL (|getTarget| |x|)) (|putTarget| |x| S)))))
                        (SETQ |bfVar#5| (CDR |bfVar#5|))))
                     |arglist| NIL))
                   ((AND (EQ |op| 'SEGMENT) (CONSP |target|)
                         (EQ (CAR |target|) '|UniversalSegment|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |target|))
                          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                               (PROGN (SETQ S (CAR |ISTMP#1|)) #1#))))
                    ((LAMBDA (|bfVar#6| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#6|)
                              (PROGN (SETQ |x| (CAR |bfVar#6|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (COND
                           ((NULL (|getTarget| |x|)) (|putTarget| |x| S)))))
                        (SETQ |bfVar#6| (CDR |bfVar#6|))))
                     |arglist| NIL))
                   (#1# NIL)))
                 (#1# NIL)))))))))))

; pushDownOnArithmeticVariables(op,target,arglist) ==
;   -- tries to push appropriate target information onto variable
;   -- occurring in arithmetic expressions
;   PAIRP(target) and first(target) = 'Variable => NIL
;   not MEMQ(op,'(_+ _- _* _*_* _/)) => NIL
;   not containsPolynomial(target)   => NIL
;   for x in arglist for i in 1.. repeat
;     VECP(x) =>   -- leaf
;       transferPropsToNode(xn := getUnname(x),x)
;       getValue(x) or (xn = $immediateDataSymbol) => NIL
;       t := getMinimalVariableTower(xn,target) or target
;       if not getTarget(x) then putTarget(x,t)
;     PAIRP(x) =>  -- node
;       [op',:arglist'] := x
;       pushDownOnArithmeticVariables(getUnname op',target,arglist')
;   arglist

(DEFUN |pushDownOnArithmeticVariables| (|op| |target| |arglist|)
  (PROG (|xn| |t| |op'| |arglist'|)
    (RETURN
     (COND ((AND (CONSP |target|) (EQ (CAR |target|) '|Variable|)) NIL)
           ((NULL (MEMQ |op| '(+ - * ** /))) NIL)
           ((NULL (|containsPolynomial| |target|)) NIL)
           (#1='T
            (PROGN
             ((LAMBDA (|bfVar#7| |x| |i|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#7|) (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (COND
                    ((VECP |x|)
                     (PROGN
                      (|transferPropsToNode| (SETQ |xn| (|getUnname| |x|)) |x|)
                      (COND
                       ((OR (|getValue| |x|)
                            (EQUAL |xn| |$immediateDataSymbol|))
                        NIL)
                       (#1#
                        (PROGN
                         (SETQ |t|
                                 (OR (|getMinimalVariableTower| |xn| |target|)
                                     |target|))
                         (COND
                          ((NULL (|getTarget| |x|))
                           (|putTarget| |x| |t|))))))))
                    ((CONSP |x|)
                     (PROGN
                      (SETQ |op'| (CAR |x|))
                      (SETQ |arglist'| (CDR |x|))
                      (|pushDownOnArithmeticVariables| (|getUnname| |op'|)
                       |target| |arglist'|))))))
                 (SETQ |bfVar#7| (CDR |bfVar#7|))
                 (SETQ |i| (+ |i| 1))))
              |arglist| NIL 1)
             |arglist|))))))

; pushDownOp?(op,n) ==
;   -- determine if for op with n arguments whether for all modemaps
;   -- the target type is equal to one or more arguments. If so, a list
;   -- of the appropriate arguments is returned.
;   ops := [sig for [sig,:.] in getModemapsFromDatabase(op,n)]
;   null ops => NIL
;   op in '(_+ _* _- _exquo) => [i for i in 0..(n-1)]
;   -- each signature has form
;   -- [domain of implementation, target, arg1, arg2, ...]
;   -- sameAsTarg is a vector that counts the number of modemaps that
;   -- have the corresponding argument equal to the target type
;   sameAsTarg := GETZEROVEC n
;   numMms := LENGTH ops
;   for [.,targ,:argl] in ops repeat
;     for arg in argl for i in 0.. repeat
;       targ = arg => SETELT(sameAsTarg,i,1 + sameAsTarg.i)
;   -- now see which args have their count = numMms
;   ok := NIL
;   for i in 0..(n-1) repeat
;     if numMms = sameAsTarg.i then ok := cons(i,ok)
;   reverse ok

(DEFUN |pushDownOp?| (|op| |n|)
  (PROG (|sig| |ops| |sameAsTarg| |numMms| |ISTMP#1| |targ| |argl| |ok|)
    (RETURN
     (PROGN
      (SETQ |ops|
              ((LAMBDA (|bfVar#10| |bfVar#9| |bfVar#8|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#9|)
                        (PROGN (SETQ |bfVar#8| (CAR |bfVar#9|)) NIL))
                    (RETURN (NREVERSE |bfVar#10|)))
                   (#1='T
                    (AND (CONSP |bfVar#8|)
                         (PROGN (SETQ |sig| (CAR |bfVar#8|)) #1#)
                         (SETQ |bfVar#10| (CONS |sig| |bfVar#10|)))))
                  (SETQ |bfVar#9| (CDR |bfVar#9|))))
               NIL (|getModemapsFromDatabase| |op| |n|) NIL))
      (COND ((NULL |ops|) NIL)
            ((|member| |op| '(+ * - |exquo|))
             ((LAMBDA (|bfVar#12| |bfVar#11| |i|)
                (LOOP
                 (COND ((> |i| |bfVar#11|) (RETURN (NREVERSE |bfVar#12|)))
                       (#1# (SETQ |bfVar#12| (CONS |i| |bfVar#12|))))
                 (SETQ |i| (+ |i| 1))))
              NIL (- |n| 1) 0))
            (#1#
             (PROGN
              (SETQ |sameAsTarg| (GETZEROVEC |n|))
              (SETQ |numMms| (LENGTH |ops|))
              ((LAMBDA (|bfVar#14| |bfVar#13|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#14|)
                        (PROGN (SETQ |bfVar#13| (CAR |bfVar#14|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (AND (CONSP |bfVar#13|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |bfVar#13|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |targ| (CAR |ISTMP#1|))
                                (SETQ |argl| (CDR |ISTMP#1|))
                                #1#)))
                         ((LAMBDA (|bfVar#15| |arg| |i|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#15|)
                                   (PROGN (SETQ |arg| (CAR |bfVar#15|)) NIL))
                               (RETURN NIL))
                              (#1#
                               (COND
                                ((EQUAL |targ| |arg|)
                                 (IDENTITY
                                  (SETELT |sameAsTarg| |i|
                                   (+ 1 (ELT |sameAsTarg| |i|))))))))
                             (SETQ |bfVar#15| (CDR |bfVar#15|))
                             (SETQ |i| (+ |i| 1))))
                          |argl| NIL 0))))
                  (SETQ |bfVar#14| (CDR |bfVar#14|))))
               |ops| NIL)
              (SETQ |ok| NIL)
              ((LAMBDA (|bfVar#16| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#16|) (RETURN NIL))
                        (#1#
                         (COND
                          ((EQUAL |numMms| (ELT |sameAsTarg| |i|))
                           (SETQ |ok| (CONS |i| |ok|))))))
                  (SETQ |i| (+ |i| 1))))
               (- |n| 1) 0)
              (REVERSE |ok|))))))))

; bottomUp t ==
;   -- bottomUp takes an attributed tree, and returns the modeSet for it.
;   -- As a side-effect it also evaluates the tree.
;   t is [op,:argl] =>
;     tar := getTarget op
;     getUnname(op) ~= $immediateDataSymbol and (v := getValue op) =>
;       om := objMode(v)
;       null tar => [om]
;       (r := resolveTM(om,tar)) => [r]
;       [om]
;     if atom op then
;       opName:= getUnname op
;       if opName in $localVars then
;         putModeSet(op,bottomUpIdentifier(op,opName))
;       else
;         transferPropsToNode(opName,op)
;     else
;       opName := NIL
;       bottomUp op
;
;     opVal := getValue op
;
;     -- call a special handler if we are not being package called
;     dol := getAtree(op,'dollar) and (opName ~= 'construct)
;
;     (null dol) and (fn := GET(opName, "up")) and (u := FUNCALL(fn, t)) => u
;     nargs := #argl
;     if opName then for x in argl for i in 1.. repeat
;       putAtree(x,'callingFunction,opName)
;       putAtree(x,'argumentNumber,i)
;       putAtree(x,'totalArgs,nargs)
;
;     if tar then pushDownTargetInfo(opName,tar,argl)
;
;     -- see if we are calling a declared user map
;     -- if so, push down the declared types as targets on the args
;     if opVal and (objVal opVal  is ['SPADMAP,:.]) and
;       (getMode op is ['Mapping,:ms]) and (nargs + 1= #ms) then
;         for m in rest ms for x in argl repeat putTarget(x,m)
;
;     argModeSetList:= [bottomUp x for x in argl]
;
;     if not tar and opName = "*" and nargs = 2 then
;         [[t1],[t2]] := argModeSetList
;         tar := computeTypeWithVariablesTarget(t1, t2)
;         tar =>
;             pushDownTargetInfo(opName,tar,argl)
;             argModeSetList:= [bottomUp x for x in argl]
;
;     ms := bottomUpForm(t,op,opName,argl,argModeSetList)
;     -- If this is a type producing form, then we don't want
;     -- to store the representation object in the environment.
;     -- Rather, we want to record the reified canonical form.
;     if ms is [m] and (m is ["Mode"] or isCategoryForm(m))
;     then putValue(t,objNew(devaluate objValUnwrap getValue t, m))
;
;     -- given no target or package calling, force integer constants to
;     -- belong to tightest possible subdomain
;
;     op := first t                -- may have changed in bottomUpElt
;     $useIntegerSubdomain and null tar and null dol and
;       isEqualOrSubDomain(first ms,$Integer) =>
;         val := objVal getValue op
;         isWrapped val =>       -- constant if wrapped
;           val := unwrap val
;           bm := getBasicMode val
;           putValue(op,objNewWrap(val,bm))
;           putModeSet(op,[bm])
;         ms
;     ms
;   m := getBasicMode t => [m]
;   IDENTP (id := getUnname t) =>
;     putModeSet(t,bottomUpIdentifier(t,id))
;   keyedSystemError("S2GE0016",['"bottomUp",'"unknown object form"])

(DEFUN |bottomUp| (|t|)
  (PROG (|op| |argl| |tar| |v| |om| |r| |opName| |opVal| |dol| |fn| |u| |nargs|
         |ISTMP#1| |ms| |argModeSetList| |t1| |t2| |m| |val| |bm| |id|)
    (RETURN
     (COND
      ((AND (CONSP |t|)
            (PROGN (SETQ |op| (CAR |t|)) (SETQ |argl| (CDR |t|)) #1='T))
       (PROGN
        (SETQ |tar| (|getTarget| |op|))
        (COND
         ((AND (NOT (EQUAL (|getUnname| |op|) |$immediateDataSymbol|))
               (SETQ |v| (|getValue| |op|)))
          (PROGN
           (SETQ |om| (|objMode| |v|))
           (COND ((NULL |tar|) (LIST |om|))
                 ((SETQ |r| (|resolveTM| |om| |tar|)) (LIST |r|))
                 (#1# (LIST |om|)))))
         (#1#
          (PROGN
           (COND
            ((ATOM |op|) (SETQ |opName| (|getUnname| |op|))
             (COND
              ((|member| |opName| |$localVars|)
               (|putModeSet| |op| (|bottomUpIdentifier| |op| |opName|)))
              (#1# (|transferPropsToNode| |opName| |op|))))
            (#1# (SETQ |opName| NIL) (|bottomUp| |op|)))
           (SETQ |opVal| (|getValue| |op|))
           (SETQ |dol|
                   (AND (|getAtree| |op| '|dollar|)
                        (NOT (EQ |opName| '|construct|))))
           (COND
            ((AND (NULL |dol|) (SETQ |fn| (GET |opName| '|up|))
                  (SETQ |u| (FUNCALL |fn| |t|)))
             |u|)
            (#1#
             (PROGN
              (SETQ |nargs| (LENGTH |argl|))
              (COND
               (|opName|
                ((LAMBDA (|bfVar#17| |x| |i|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#17|)
                          (PROGN (SETQ |x| (CAR |bfVar#17|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (PROGN
                       (|putAtree| |x| '|callingFunction| |opName|)
                       (|putAtree| |x| '|argumentNumber| |i|)
                       (|putAtree| |x| '|totalArgs| |nargs|))))
                    (SETQ |bfVar#17| (CDR |bfVar#17|))
                    (SETQ |i| (+ |i| 1))))
                 |argl| NIL 1)))
              (COND (|tar| (|pushDownTargetInfo| |opName| |tar| |argl|)))
              (COND
               ((AND |opVal|
                     (PROGN
                      (SETQ |ISTMP#1| (|objVal| |opVal|))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADMAP)))
                     (PROGN
                      (SETQ |ISTMP#1| (|getMode| |op|))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
                           (PROGN (SETQ |ms| (CDR |ISTMP#1|)) #1#)))
                     (EQL (+ |nargs| 1) (LENGTH |ms|)))
                ((LAMBDA (|bfVar#18| |m| |bfVar#19| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#18|)
                          (PROGN (SETQ |m| (CAR |bfVar#18|)) NIL)
                          (ATOM |bfVar#19|)
                          (PROGN (SETQ |x| (CAR |bfVar#19|)) NIL))
                      (RETURN NIL))
                     (#1# (|putTarget| |x| |m|)))
                    (SETQ |bfVar#18| (CDR |bfVar#18|))
                    (SETQ |bfVar#19| (CDR |bfVar#19|))))
                 (CDR |ms|) NIL |argl| NIL)))
              (SETQ |argModeSetList|
                      ((LAMBDA (|bfVar#21| |bfVar#20| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#20|)
                                (PROGN (SETQ |x| (CAR |bfVar#20|)) NIL))
                            (RETURN (NREVERSE |bfVar#21|)))
                           (#1#
                            (SETQ |bfVar#21|
                                    (CONS (|bottomUp| |x|) |bfVar#21|))))
                          (SETQ |bfVar#20| (CDR |bfVar#20|))))
                       NIL |argl| NIL))
              (COND
               ((AND (NULL |tar|) (EQ |opName| '*) (EQL |nargs| 2))
                (SETQ |t1| (CAAR |argModeSetList|))
                (SETQ |t2| (CAADR |argModeSetList|))
                (SETQ |tar| (|computeTypeWithVariablesTarget| |t1| |t2|))
                (COND
                 (|tar|
                  (PROGN
                   (|pushDownTargetInfo| |opName| |tar| |argl|)
                   (SETQ |argModeSetList|
                           ((LAMBDA (|bfVar#23| |bfVar#22| |x|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#22|)
                                     (PROGN (SETQ |x| (CAR |bfVar#22|)) NIL))
                                 (RETURN (NREVERSE |bfVar#23|)))
                                (#1#
                                 (SETQ |bfVar#23|
                                         (CONS (|bottomUp| |x|) |bfVar#23|))))
                               (SETQ |bfVar#22| (CDR |bfVar#22|))))
                            NIL |argl| NIL)))))))
              (SETQ |ms|
                      (|bottomUpForm| |t| |op| |opName| |argl|
                       |argModeSetList|))
              (COND
               ((AND (CONSP |ms|) (EQ (CDR |ms|) NIL)
                     (PROGN (SETQ |m| (CAR |ms|)) #1#)
                     (OR
                      (AND (CONSP |m|) (EQ (CDR |m|) NIL)
                           (EQ (CAR |m|) '|Mode|))
                      (|isCategoryForm| |m|)))
                (|putValue| |t|
                 (|objNew| (|devaluate| (|objValUnwrap| (|getValue| |t|)))
                  |m|))))
              (SETQ |op| (CAR |t|))
              (COND
               ((AND |$useIntegerSubdomain| (NULL |tar|) (NULL |dol|)
                     (|isEqualOrSubDomain| (CAR |ms|) |$Integer|))
                (PROGN
                 (SETQ |val| (|objVal| (|getValue| |op|)))
                 (COND
                  ((|isWrapped| |val|)
                   (PROGN
                    (SETQ |val| (|unwrap| |val|))
                    (SETQ |bm| (|getBasicMode| |val|))
                    (|putValue| |op| (|objNewWrap| |val| |bm|))
                    (|putModeSet| |op| (LIST |bm|))))
                  (#1# |ms|))))
               (#1# |ms|))))))))))
      ((SETQ |m| (|getBasicMode| |t|)) (LIST |m|))
      ((IDENTP (SETQ |id| (|getUnname| |t|)))
       (|putModeSet| |t| (|bottomUpIdentifier| |t| |id|)))
      (#1#
       (|keyedSystemError| 'S2GE0016
        (LIST "bottomUp" "unknown object form")))))))

; computeTypeWithVariablesTarget(p, q) ==
;     polyVarlist(p) or polyVarlist(q) =>
;         t := resolveTT(p, q)
;         polyVarlist(t) => t
;         NIL
;     NIL

(DEFUN |computeTypeWithVariablesTarget| (|p| |q|)
  (PROG (|t|)
    (RETURN
     (COND
      ((OR (|polyVarlist| |p|) (|polyVarlist| |q|))
       (PROGN
        (SETQ |t| (|resolveTT| |p| |q|))
        (COND ((|polyVarlist| |t|) |t|) (#1='T NIL))))
      (#1# NIL)))))

; bottomUpCompile t ==
;   $genValue:local := false
;   ms := bottomUp t
;   compTran1 objVal getValue t
;   ms

(DEFUN |bottomUpCompile| (|t|)
  (PROG (|$genValue| |ms|)
    (DECLARE (SPECIAL |$genValue|))
    (RETURN
     (PROGN
      (SETQ |$genValue| NIL)
      (SETQ |ms| (|bottomUp| |t|))
      (|compTran1| (|objVal| (|getValue| |t|)))
      |ms|))))

; bottomUpUseSubdomain t ==
;   $useIntegerSubdomain : local := true
;   ms := bottomUp t
;   ($immediateDataSymbol ~= getUnname(t)) or ($Integer ~= first(ms)) => ms
;   null INTEGERP(num := objValUnwrap getValue t) => ms
;   o := getBasicObject(num)
;   putValue(t,o)
;   ms := [objMode o]
;   putModeSet(t,ms)
;   ms

(DEFUN |bottomUpUseSubdomain| (|t|)
  (PROG (|$useIntegerSubdomain| |o| |num| |ms|)
    (DECLARE (SPECIAL |$useIntegerSubdomain|))
    (RETURN
     (PROGN
      (SETQ |$useIntegerSubdomain| T)
      (SETQ |ms| (|bottomUp| |t|))
      (COND
       ((OR (NOT (EQUAL |$immediateDataSymbol| (|getUnname| |t|)))
            (NOT (EQUAL |$Integer| (CAR |ms|))))
        |ms|)
       ((NULL (INTEGERP (SETQ |num| (|objValUnwrap| (|getValue| |t|))))) |ms|)
       ('T
        (PROGN
         (SETQ |o| (|getBasicObject| |num|))
         (|putValue| |t| |o|)
         (SETQ |ms| (LIST (|objMode| |o|)))
         (|putModeSet| |t| |ms|)
         |ms|)))))))

; bottomUpPredicate(pred, name) ==
;   putTarget(pred,$Boolean)
;   ms := bottomUp pred
;   $Boolean ~= first ms => throwKeyedMsg("S2IB0001", [name])
;   ms

(DEFUN |bottomUpPredicate| (|pred| |name|)
  (PROG (|ms|)
    (RETURN
     (PROGN
      (|putTarget| |pred| |$Boolean|)
      (SETQ |ms| (|bottomUp| |pred|))
      (COND
       ((NOT (EQUAL |$Boolean| (CAR |ms|)))
        (|throwKeyedMsg| 'S2IB0001 (LIST |name|)))
       ('T |ms|))))))

; bottomUpCompilePredicate(pred, name) ==
;   $genValue:local := false
;   bottomUpPredicate(pred,name)

(DEFUN |bottomUpCompilePredicate| (|pred| |name|)
  (PROG (|$genValue|)
    (DECLARE (SPECIAL |$genValue|))
    (RETURN
     (PROGN (SETQ |$genValue| NIL) (|bottomUpPredicate| |pred| |name|)))))

; bottomUpIdentifier(t,id) ==
;   m := isType t => bottomUpType(t, m)
;   EQ(id,'noMapVal) => throwKeyedMsg("S2IB0002", NIL)
;   EQ(id,'noBranch) =>
;     keyedSystemError("S2GE0016",
;       ['"bottomUpIdentifier",'"trying to evaluate noBranch"])
;   transferPropsToNode(id,t)
;   defaultType := ['Variable,id]
;   -- This was meant to stop building silly symbols but had some unfortunate
;   -- side effects, like not being able to say e:=foo in the interpreter.  MCD
; --  defaultType :=
; --    getModemapsFromDatabase(id,1) =>
; --      userError ['"Cannot use operation name as a variable: ", id]
; --    ['Variable, id]
;   u := getValue t => --non-cached values MAY be re-evaluated
;     tar := getTarget t
;     expr:= objVal u
;     om := objMode(u)
;     (om ~= $EmptyMode) and (om isnt ['RuleCalled,.]) =>
;       $genValue or GENSYMP(id) =>
;         null tar => [om]
;         (r := resolveTM(om,tar)) => [r]
;         [om]
;       bottomUpDefault(t,id,defaultType,getTarget t)
;     interpRewriteRule(t, id) or
;       (isMapExpr expr and [objMode(u)]) or
;         keyedSystemError("S2GE0016",
;           ['"bottomUpIdentifier",'"cannot evaluate identifier"])
;   bottomUpDefault(t,id,defaultType,getTarget t)

(DEFUN |bottomUpIdentifier| (|t| |id|)
  (PROG (|m| |defaultType| |u| |tar| |expr| |om| |ISTMP#1| |r|)
    (RETURN
     (COND ((SETQ |m| (|isType| |t|)) (|bottomUpType| |t| |m|))
           ((EQ |id| '|noMapVal|) (|throwKeyedMsg| 'S2IB0002 NIL))
           ((EQ |id| '|noBranch|)
            (|keyedSystemError| 'S2GE0016
             (LIST "bottomUpIdentifier" "trying to evaluate noBranch")))
           (#1='T
            (PROGN
             (|transferPropsToNode| |id| |t|)
             (SETQ |defaultType| (LIST '|Variable| |id|))
             (COND
              ((SETQ |u| (|getValue| |t|))
               (PROGN
                (SETQ |tar| (|getTarget| |t|))
                (SETQ |expr| (|objVal| |u|))
                (SETQ |om| (|objMode| |u|))
                (COND
                 ((AND (NOT (EQUAL |om| |$EmptyMode|))
                       (NOT
                        (AND (CONSP |om|) (EQ (CAR |om|) '|RuleCalled|)
                             (PROGN
                              (SETQ |ISTMP#1| (CDR |om|))
                              (AND (CONSP |ISTMP#1|)
                                   (EQ (CDR |ISTMP#1|) NIL))))))
                  (COND
                   ((OR |$genValue| (GENSYMP |id|))
                    (COND ((NULL |tar|) (LIST |om|))
                          ((SETQ |r| (|resolveTM| |om| |tar|)) (LIST |r|))
                          (#1# (LIST |om|))))
                   (#1#
                    (|bottomUpDefault| |t| |id| |defaultType|
                     (|getTarget| |t|)))))
                 (#1#
                  (OR (|interpRewriteRule| |t| |id|)
                      (AND (|isMapExpr| |expr|) (LIST (|objMode| |u|)))
                      (|keyedSystemError| 'S2GE0016
                       (LIST "bottomUpIdentifier"
                             "cannot evaluate identifier")))))))
              (#1#
               (|bottomUpDefault| |t| |id| |defaultType|
                (|getTarget| |t|))))))))))

; bottomUpDefault(t,id,defaultMode,target) ==
;   if $genValue
;     then bottomUpDefaultEval(t, id, defaultMode, target)
;     else bottomUpDefaultCompile(t, id, defaultMode, target)

(DEFUN |bottomUpDefault| (|t| |id| |defaultMode| |target|)
  (PROG ()
    (RETURN
     (COND
      (|$genValue| (|bottomUpDefaultEval| |t| |id| |defaultMode| |target|))
      ('T (|bottomUpDefaultCompile| |t| |id| |defaultMode| |target|))))))

; bottomUpDefaultEval(t, id, defaultMode, target) ==
;   -- try to get value case.
;
;   -- 1. declared mode but no value case
;   (m := getMode t) =>
;     m is ['Mapping,:.] => throwKeyedMsg("S2IB0003",[getUnname t])
;
;     -- hmm, try to treat it like target mode or declared mode
;     if isPartialMode(m) then m := resolveTM(['Variable,id],m)
;     -- if there is a target, probably want it to be that way and not
;     -- declared mode. Like "x" in second line:
;     --   x : P[x] I
;     --   y : P[x] I
;     target and
;       (val := coerceInteractive(objNewWrap(id,['Variable,id]),target))=>
;         putValue(t,val)
;         [target]
;     -- Ok, see if we can make it into declared mode from symbolic form
;     -- For example, (x : P[x] I; x + 1)
;     not target and m and
;       (val := coerceInteractive(objNewWrap(id,['Variable,id]),m)) =>
;         putValue(t,val)
;         [m]
;     -- give up
;     throwKeyedMsg("S2IB0004", [id, m])
;
;   -- 2. no value and no mode case
;   val := objNewWrap(id,defaultMode)
;   (null target) or (defaultMode = target) =>
;     putValue(t,val)
;     [defaultMode]
;   if isPartialMode target then
;     -- this hackery will go away when Symbol is not the default type
;     if defaultMode = $Symbol and (target is [D,x,.]) then
;       (D in $univariateDomains and (x = id)) or
;         (D in $multivariateDomains and (id in x)) =>
;            dmode := [D,x,$Integer]
;            (val' := coerceInteractive(objNewWrap(id,
;              ['Variable,id]),dmode)) =>
;                defaultMode := dmode
;                val := val'
;       NIL
;     target := resolveTM(defaultMode,target)
;   -- The following is experimental.  SCM 10/11/90
;   if target and (tm := getMinimalVarMode(id, target)) then
;     target := tm
;   (null target) or null (val' := coerceInteractive(val,target)) =>
;     putValue(t,val)
;     [defaultMode]
;   putValue(t,val')
;   [target]

(DEFUN |bottomUpDefaultEval| (|t| |id| |defaultMode| |target|)
  (PROG (|m| |val| D |ISTMP#1| |x| |ISTMP#2| |dmode| |val'| |tm|)
    (RETURN
     (COND
      ((SETQ |m| (|getMode| |t|))
       (COND
        ((AND (CONSP |m|) (EQ (CAR |m|) '|Mapping|))
         (|throwKeyedMsg| 'S2IB0003 (LIST (|getUnname| |t|))))
        (#1='T
         (PROGN
          (COND
           ((|isPartialMode| |m|)
            (SETQ |m| (|resolveTM| (LIST '|Variable| |id|) |m|))))
          (COND
           ((AND |target|
                 (SETQ |val|
                         (|coerceInteractive|
                          (|objNewWrap| |id| (LIST '|Variable| |id|))
                          |target|)))
            (PROGN (|putValue| |t| |val|) (LIST |target|)))
           ((AND (NULL |target|) |m|
                 (SETQ |val|
                         (|coerceInteractive|
                          (|objNewWrap| |id| (LIST '|Variable| |id|)) |m|)))
            (PROGN (|putValue| |t| |val|) (LIST |m|)))
           (#1# (|throwKeyedMsg| 'S2IB0004 (LIST |id| |m|))))))))
      (#1#
       (PROGN
        (SETQ |val| (|objNewWrap| |id| |defaultMode|))
        (COND
         ((OR (NULL |target|) (EQUAL |defaultMode| |target|))
          (PROGN (|putValue| |t| |val|) (LIST |defaultMode|)))
         (#1#
          (PROGN
           (COND
            ((|isPartialMode| |target|)
             (COND
              ((AND (EQUAL |defaultMode| |$Symbol|) (CONSP |target|)
                    (PROGN
                     (SETQ D (CAR |target|))
                     (SETQ |ISTMP#1| (CDR |target|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |x| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL))))))
               (COND
                ((OR (AND (|member| D |$univariateDomains|) (EQUAL |x| |id|))
                     (AND (|member| D |$multivariateDomains|)
                          (|member| |id| |x|)))
                 (PROGN
                  (SETQ |dmode| (LIST D |x| |$Integer|))
                  (COND
                   ((SETQ |val'|
                            (|coerceInteractive|
                             (|objNewWrap| |id| (LIST '|Variable| |id|))
                             |dmode|))
                    (PROGN
                     (SETQ |defaultMode| |dmode|)
                     (SETQ |val| |val'|))))))
                (#1# NIL))))
             (SETQ |target| (|resolveTM| |defaultMode| |target|))))
           (COND
            ((AND |target| (SETQ |tm| (|getMinimalVarMode| |id| |target|)))
             (SETQ |target| |tm|)))
           (COND
            ((OR (NULL |target|)
                 (NULL (SETQ |val'| (|coerceInteractive| |val| |target|))))
             (PROGN (|putValue| |t| |val|) (LIST |defaultMode|)))
            (#1# (PROGN (|putValue| |t| |val'|) (LIST |target|)))))))))))))

; bottomUpDefaultCompile(t, id, defaultMode, target) ==
;   tmode := getMode t
;   tval  := getValue t
;   expr:=
;     id in $localVars => id
;     tmode or tval =>
;       envMode := tmode or objMode tval
;       envMode is ['Variable, :.] => objVal tval
;       id = $immediateDataSymbol => objVal tval
;       ['getValueFromEnvironment,MKQ id,MKQ envMode]
;     wrap id
;   tmode and tval and (mdv := objMode tval) =>
;     if isPartialMode tmode then
;       null (tmode := resolveTM(mdv,tmode)) =>
;         keyedMsgCompFailure("S2IB0010",NIL)
;     putValue(t,objNew(expr,tmode))
;     [tmode]
;   tmode or (tval and (tmode := objMode tval)) =>
;     putValue(t,objNew(expr,tmode))
;     [tmode]
;   obj := objNew(expr,defaultMode)
;   canCoerceFrom(defaultMode, target) and
;     (obj' := coerceInteractive(obj, target)) =>
;         putValue(t, obj')
;         [target]
;   putValue(t,obj)
;   [defaultMode]

(DEFUN |bottomUpDefaultCompile| (|t| |id| |defaultMode| |target|)
  (PROG (|tmode| |tval| |envMode| |expr| |mdv| |obj| |obj'|)
    (RETURN
     (PROGN
      (SETQ |tmode| (|getMode| |t|))
      (SETQ |tval| (|getValue| |t|))
      (SETQ |expr|
              (COND ((|member| |id| |$localVars|) |id|)
                    ((OR |tmode| |tval|)
                     (PROGN
                      (SETQ |envMode| (OR |tmode| (|objMode| |tval|)))
                      (COND
                       ((AND (CONSP |envMode|)
                             (EQ (CAR |envMode|) '|Variable|))
                        (|objVal| |tval|))
                       ((EQUAL |id| |$immediateDataSymbol|) (|objVal| |tval|))
                       (#1='T
                        (LIST '|getValueFromEnvironment| (MKQ |id|)
                              (MKQ |envMode|))))))
                    (#1# (|wrap| |id|))))
      (COND
       ((AND |tmode| |tval| (SETQ |mdv| (|objMode| |tval|)))
        (PROGN
         (COND
          ((|isPartialMode| |tmode|)
           (COND
            ((NULL (SETQ |tmode| (|resolveTM| |mdv| |tmode|)))
             (IDENTITY (|keyedMsgCompFailure| 'S2IB0010 NIL))))))
         (|putValue| |t| (|objNew| |expr| |tmode|))
         (LIST |tmode|)))
       ((OR |tmode| (AND |tval| (SETQ |tmode| (|objMode| |tval|))))
        (PROGN (|putValue| |t| (|objNew| |expr| |tmode|)) (LIST |tmode|)))
       (#1#
        (PROGN
         (SETQ |obj| (|objNew| |expr| |defaultMode|))
         (COND
          ((AND (|canCoerceFrom| |defaultMode| |target|)
                (SETQ |obj'| (|coerceInteractive| |obj| |target|)))
           (PROGN (|putValue| |t| |obj'|) (LIST |target|)))
          (#1# (PROGN (|putValue| |t| |obj|) (LIST |defaultMode|)))))))))))

; interpRewriteRule(t, id) ==
;   null get(id,'isInterpreterRule,$e) => NIL
;   (ms:= selectLocalMms(t,id,nil,nil)) and (ms:=evalForm(t,id,nil,ms)) =>
;     ms
;   nil

(DEFUN |interpRewriteRule| (|t| |id|)
  (PROG (|ms|)
    (RETURN
     (COND ((NULL (|get| |id| '|isInterpreterRule| |$e|)) NIL)
           ((AND (SETQ |ms| (|selectLocalMms| |t| |id| NIL NIL))
                 (SETQ |ms| (|evalForm| |t| |id| NIL |ms|)))
            |ms|)
           ('T NIL)))))

; bottomUpForm(t,op,opName,argl,argModeSetList) ==
;   not($inRetract) =>
;     bottomUpForm3(t,op,opName,argl,argModeSetList)
;   bottomUpForm2(t,op,opName,argl,argModeSetList)

(DEFUN |bottomUpForm| (|t| |op| |opName| |argl| |argModeSetList|)
  (PROG ()
    (RETURN
     (COND
      ((NULL |$inRetract|)
       (|bottomUpForm3| |t| |op| |opName| |argl| |argModeSetList|))
      ('T (|bottomUpForm2| |t| |op| |opName| |argl| |argModeSetList|))))))

; bottomUpForm3(t,op,opName,argl,argModeSetList) ==
;   $origArgModeSetList:local  := COPY argModeSetList
;   bottomUpForm2(t,op,opName,argl,argModeSetList)

(DEFUN |bottomUpForm3| (|t| |op| |opName| |argl| |argModeSetList|)
  (PROG (|$origArgModeSetList|)
    (DECLARE (SPECIAL |$origArgModeSetList|))
    (RETURN
     (PROGN
      (SETQ |$origArgModeSetList| (COPY |argModeSetList|))
      (|bottomUpForm2| |t| |op| |opName| |argl| |argModeSetList|)))))

; bottomUpForm2(t,op,opName,argl,argModeSetList) ==
;   not atom t and EQ(opName,"%%") => bottomUpPercent t
;   opVal := getValue op
;
;   -- for things with objects in operator position, be careful before
;   -- we enter general modemap selection
;
;   lookForIt :=
;     getAtree(op,'dollar) => true
;     not opVal => true
;     opMode := objMode opVal
;     not (opModeTop := IFCAR opMode) => true
;     opModeTop in '(Record Union) => false
;     opModeTop in '(Variable Mapping FunctionCalled RuleCalled AnonymousFunction) => true
;     false
;
;   -- get rid of Union($, "failed") except when op is "=" and all
;   -- modesets are the same
;
;   $genValue and
;     not (opName = "=" and argModeSetList is [[m],[=m]] and m is ['Union,:.]) and
;       (u := bottomUpFormUntaggedUnionRetract(t,op,opName,argl,argModeSetList)) => u
;
;   lookForIt and (u := bottomUpFormTuple(t, op, opName, argl)) => u
;
;   -- opName can change in the call to selectMms
;
;   (lookForIt and (mmS := selectMms(op,argl,getTarget op))) and
;     (mS := evalForm(op,opName := getUnname op,argl,mmS)) =>
;       putModeSet(op,mS)
;   bottomUpForm0(t,op,opName,argl,argModeSetList)

(DEFUN |bottomUpForm2| (|t| |op| |opName| |argl| |argModeSetList|)
  (PROG (|opVal| |opMode| |opModeTop| |lookForIt| |ISTMP#1| |m| |ISTMP#2|
         |ISTMP#3| |u| |mmS| |mS|)
    (RETURN
     (COND ((AND (NULL (ATOM |t|)) (EQ |opName| '%%)) (|bottomUpPercent| |t|))
           (#1='T
            (PROGN
             (SETQ |opVal| (|getValue| |op|))
             (SETQ |lookForIt|
                     (COND ((|getAtree| |op| '|dollar|) T) ((NULL |opVal|) T)
                           (#1#
                            (PROGN
                             (SETQ |opMode| (|objMode| |opVal|))
                             (COND
                              ((NULL (SETQ |opModeTop| (IFCAR |opMode|))) T)
                              ((|member| |opModeTop| '(|Record| |Union|)) NIL)
                              ((|member| |opModeTop|
                                '(|Variable| |Mapping| |FunctionCalled|
                                  |RuleCalled| |AnonymousFunction|))
                               T)
                              (#1# NIL))))))
             (COND
              ((AND |$genValue|
                    (NULL
                     (AND (EQ |opName| '=) (CONSP |argModeSetList|)
                          (PROGN
                           (SETQ |ISTMP#1| (CAR |argModeSetList|))
                           (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                (PROGN (SETQ |m| (CAR |ISTMP#1|)) #1#)))
                          (PROGN
                           (SETQ |ISTMP#2| (CDR |argModeSetList|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN
                                 (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CDR |ISTMP#3|) NIL)
                                      (EQUAL (CAR |ISTMP#3|) |m|)))))
                          (CONSP |m|) (EQ (CAR |m|) '|Union|)))
                    (SETQ |u|
                            (|bottomUpFormUntaggedUnionRetract| |t| |op|
                             |opName| |argl| |argModeSetList|)))
               |u|)
              ((AND |lookForIt|
                    (SETQ |u| (|bottomUpFormTuple| |t| |op| |opName| |argl|)))
               |u|)
              ((AND |lookForIt|
                    (SETQ |mmS| (|selectMms| |op| |argl| (|getTarget| |op|)))
                    (SETQ |mS|
                            (|evalForm| |op| (SETQ |opName| (|getUnname| |op|))
                             |argl| |mmS|)))
               (|putModeSet| |op| |mS|))
              (#1#
               (|bottomUpForm0| |t| |op| |opName| |argl|
                |argModeSetList|)))))))))

; bottomUpFormTuple(t, op, opName, args) ==
;   getAtree(op,'dollar) => NIL
;   null (singles := getModemapsFromDatabase(opName, 1)) => NIL
;
;   -- see if any of the modemaps have Tuple arguments
;   haveTuple := false
;   for mm in singles while not haveTuple repeat
;     if getFirstArgTypeFromMm(mm) is ["Tuple",.] then haveTuple := true
;   not haveTuple => nil
;   nargs := #args
;   nargs = 1 and getUnname first args = "Tuple" => NIL
;   nargs = 1 and (ms := bottomUp first args) and
;     (ms is [["Tuple",.]] or ms is [["List",.]]) => NIL
;
;   -- now make the args into a tuple
;
;   newArg := [mkAtreeNode "Tuple",:args]
;   bottomUp [op, newArg]

(DEFUN |bottomUpFormTuple| (|t| |op| |opName| |args|)
  (PROG (|singles| |haveTuple| |ISTMP#1| |ISTMP#2| |nargs| |ms| |newArg|)
    (RETURN
     (COND ((|getAtree| |op| '|dollar|) NIL)
           ((NULL (SETQ |singles| (|getModemapsFromDatabase| |opName| 1))) NIL)
           (#1='T
            (PROGN
             (SETQ |haveTuple| NIL)
             ((LAMBDA (|bfVar#24| |mm|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#24|)
                       (PROGN (SETQ |mm| (CAR |bfVar#24|)) NIL) |haveTuple|)
                   (RETURN NIL))
                  (#1#
                   (COND
                    ((PROGN
                      (SETQ |ISTMP#1| (|getFirstArgTypeFromMm| |mm|))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Tuple|)
                           (PROGN
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)))))
                     (SETQ |haveTuple| T)))))
                 (SETQ |bfVar#24| (CDR |bfVar#24|))))
              |singles| NIL)
             (COND ((NULL |haveTuple|) NIL)
                   (#1#
                    (PROGN
                     (SETQ |nargs| (LENGTH |args|))
                     (COND
                      ((AND (EQL |nargs| 1)
                            (EQ (|getUnname| (CAR |args|)) '|Tuple|))
                       NIL)
                      ((AND (EQL |nargs| 1)
                            (SETQ |ms| (|bottomUp| (CAR |args|)))
                            (OR
                             (AND (CONSP |ms|) (EQ (CDR |ms|) NIL)
                                  (PROGN
                                   (SETQ |ISTMP#1| (CAR |ms|))
                                   (AND (CONSP |ISTMP#1|)
                                        (EQ (CAR |ISTMP#1|) '|Tuple|)
                                        (PROGN
                                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                         (AND (CONSP |ISTMP#2|)
                                              (EQ (CDR |ISTMP#2|) NIL))))))
                             (AND (CONSP |ms|) (EQ (CDR |ms|) NIL)
                                  (PROGN
                                   (SETQ |ISTMP#1| (CAR |ms|))
                                   (AND (CONSP |ISTMP#1|)
                                        (EQ (CAR |ISTMP#1|) '|List|)
                                        (PROGN
                                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                         (AND (CONSP |ISTMP#2|)
                                              (EQ (CDR |ISTMP#2|) NIL))))))))
                       NIL)
                      (#1#
                       (PROGN
                        (SETQ |newArg| (CONS (|mkAtreeNode| '|Tuple|) |args|))
                        (|bottomUp| (LIST |op| |newArg|))))))))))))))

; printableArgModeSetList() ==
;   amsl := nil
;   for a in reverse $origArgModeSetList repeat
;     b := prefix2String first a
;     if ATOM b then b := [b]
;     amsl := ['%l,:b,:amsl]
;   if amsl then amsl := rest amsl
;   amsl

(DEFUN |printableArgModeSetList| ()
  (PROG (|b| |amsl|)
    (RETURN
     (PROGN
      (SETQ |amsl| NIL)
      ((LAMBDA (|bfVar#25| |a|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#25|) (PROGN (SETQ |a| (CAR |bfVar#25|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ |b| (|prefix2String| (CAR |a|)))
             (COND ((ATOM |b|) (SETQ |b| (LIST |b|))))
             (SETQ |amsl| (CONS '|%l| (APPEND |b| |amsl|))))))
          (SETQ |bfVar#25| (CDR |bfVar#25|))))
       (REVERSE |$origArgModeSetList|) NIL)
      (COND (|amsl| (SETQ |amsl| (CDR |amsl|))))
      |amsl|))))

; bottomUpForm0(t,op,opName,argl,argModeSetList) ==
;   op0 := op
;   opName0 := opName
;
;   m := isType t =>
;     bottomUpType(t, m)
;
;   opName = 'copy and argModeSetList is [[['Record,:rargs]]] =>
;     -- this is a hack until Records go through the normal
;     -- modemap selection process
;     rtype := ['Record,:rargs]
;     code := optRECORDCOPY(['RECORDCOPY, getArgValue(first argl, rtype),
;                            #rargs])
;     if $genValue then code := wrap timedEVALFUN code
;     val := objNew(code,rtype)
;     putValue(t,val)
;     putModeSet(t,[rtype])
;
;   m := getModeOrFirstModeSetIfThere op
;   m is ['Record,:.] and argModeSetList is [[['Variable,x]]] and
;       member(x,getUnionOrRecordTags m) and (u := bottomUpElt t) => u
;   m is ['Union,:.] and argModeSetList is [[['Variable,x]]] =>
;       member(x,getUnionOrRecordTags m) and (u := bottomUpElt t) => u
;       not $genValue =>
;         amsl := printableArgModeSetList()
;         throwKeyedMsgSP("S2IB0008",['"the union object",amsl], op)
;       object := retract getValue op
;       object = 'failed =>
;         throwKeyedMsgSP("S2IB0008",['"the union object",amsl], op)
;       putModeSet(op,[objMode(object)])
;       putValue(op,object)
;       (u := bottomUpElt t) => u
;       bottomUpForm0(t,op,opName,argl,argModeSetList)
;
;   (opName ~= "elt") and (opName ~= "apply") and
;     #argl = 1 and first first argModeSetList is ['Variable, var]
;       and var in '(first last rest) and
;         isEltable(op, argl, #argl) and (u := bottomUpElt t) => u
;
;   $genValue and
;     ( u:= bottomUpFormRetract(t,op,opName,argl,argModeSetList) ) => u
;
;   (opName ~= "elt") and (opName ~= "apply") and
;     isEltable(op, argl, #argl) and (u := bottomUpElt t) => u
;
;   amsl := printableArgModeSetList()
;   opName1 :=
;     opName0 = $immediateDataSymbol =>
;         (o := coerceInteractive(getValue op0,$OutputForm)) =>
;             outputTran2 objValUnwrap o
;         NIL
;     opName0
;
;   if null(opName1) then
;     opName1 :=
;         (o := getValue op0) => prefix2String objMode o
;         '"<unknown type>"
;     msgKey :=
;         null amsl => "S2IB0013"
;         "S2IB0012"
;   else
;     msgKey :=
;         null amsl => "S2IB0011"
;         (n := isSharpVarWithNum opName1) =>
;             opName1 := n
;             "S2IB0008g"
;         "S2IB0008"
;
;   sayIntelligentMessageAboutOpAvailability(opName1, #argl)
;
;   not $genValue =>
;     keyedMsgCompFailureSP(msgKey,[opName1, amsl], op0)
;   throwKeyedMsgSP(msgKey,[opName1, amsl], op0)

(DEFUN |bottomUpForm0| (|t| |op| |opName| |argl| |argModeSetList|)
  (PROG (|op0| |opName0| |m| |ISTMP#1| |ISTMP#2| |rargs| |rtype| |code| |val|
         |ISTMP#3| |x| |u| |amsl| |object| |var| |o| |opName1| |msgKey| |n|)
    (RETURN
     (PROGN
      (SETQ |op0| |op|)
      (SETQ |opName0| |opName|)
      (COND ((SETQ |m| (|isType| |t|)) (|bottomUpType| |t| |m|))
            ((AND (EQ |opName| '|copy|) (CONSP |argModeSetList|)
                  (EQ (CDR |argModeSetList|) NIL)
                  (PROGN
                   (SETQ |ISTMP#1| (CAR |argModeSetList|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN
                         (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|Record|)
                              (PROGN (SETQ |rargs| (CDR |ISTMP#2|)) #1='T))))))
             (PROGN
              (SETQ |rtype| (CONS '|Record| |rargs|))
              (SETQ |code|
                      (|optRECORDCOPY|
                       (LIST 'RECORDCOPY (|getArgValue| (CAR |argl|) |rtype|)
                             (LENGTH |rargs|))))
              (COND
               (|$genValue| (SETQ |code| (|wrap| (|timedEVALFUN| |code|)))))
              (SETQ |val| (|objNew| |code| |rtype|))
              (|putValue| |t| |val|)
              (|putModeSet| |t| (LIST |rtype|))))
            (#1#
             (PROGN
              (SETQ |m| (|getModeOrFirstModeSetIfThere| |op|))
              (COND
               ((AND (CONSP |m|) (EQ (CAR |m|) '|Record|)
                     (CONSP |argModeSetList|) (EQ (CDR |argModeSetList|) NIL)
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |argModeSetList|))
                      (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                           (PROGN
                            (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|)
                                 (EQ (CAR |ISTMP#2|) '|Variable|)
                                 (PROGN
                                  (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                  (AND (CONSP |ISTMP#3|)
                                       (EQ (CDR |ISTMP#3|) NIL)
                                       (PROGN
                                        (SETQ |x| (CAR |ISTMP#3|))
                                        #1#)))))))
                     (|member| |x| (|getUnionOrRecordTags| |m|))
                     (SETQ |u| (|bottomUpElt| |t|)))
                |u|)
               ((AND (CONSP |m|) (EQ (CAR |m|) '|Union|)
                     (CONSP |argModeSetList|) (EQ (CDR |argModeSetList|) NIL)
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |argModeSetList|))
                      (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                           (PROGN
                            (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|)
                                 (EQ (CAR |ISTMP#2|) '|Variable|)
                                 (PROGN
                                  (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                  (AND (CONSP |ISTMP#3|)
                                       (EQ (CDR |ISTMP#3|) NIL)
                                       (PROGN
                                        (SETQ |x| (CAR |ISTMP#3|))
                                        #1#))))))))
                (COND
                 ((AND (|member| |x| (|getUnionOrRecordTags| |m|))
                       (SETQ |u| (|bottomUpElt| |t|)))
                  |u|)
                 ((NULL |$genValue|)
                  (PROGN
                   (SETQ |amsl| (|printableArgModeSetList|))
                   (|throwKeyedMsgSP| 'S2IB0008
                    (LIST "the union object" |amsl|) |op|)))
                 (#1#
                  (PROGN
                   (SETQ |object| (|retract| (|getValue| |op|)))
                   (COND
                    ((EQ |object| '|failed|)
                     (|throwKeyedMsgSP| 'S2IB0008
                      (LIST "the union object" |amsl|) |op|))
                    (#1#
                     (PROGN
                      (|putModeSet| |op| (LIST (|objMode| |object|)))
                      (|putValue| |op| |object|)
                      (COND ((SETQ |u| (|bottomUpElt| |t|)) |u|)
                            (#1#
                             (|bottomUpForm0| |t| |op| |opName| |argl|
                              |argModeSetList|))))))))))
               ((AND (NOT (EQ |opName| '|elt|)) (NOT (EQ |opName| '|apply|))
                     (EQL (LENGTH |argl|) 1)
                     (PROGN
                      (SETQ |ISTMP#1| (CAR (CAR |argModeSetList|)))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Variable|)
                           (PROGN
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN (SETQ |var| (CAR |ISTMP#2|)) #1#)))))
                     (|member| |var| '(|first| |last| |rest|))
                     (|isEltable| |op| |argl| (LENGTH |argl|))
                     (SETQ |u| (|bottomUpElt| |t|)))
                |u|)
               ((AND |$genValue|
                     (SETQ |u|
                             (|bottomUpFormRetract| |t| |op| |opName| |argl|
                              |argModeSetList|)))
                |u|)
               ((AND (NOT (EQ |opName| '|elt|)) (NOT (EQ |opName| '|apply|))
                     (|isEltable| |op| |argl| (LENGTH |argl|))
                     (SETQ |u| (|bottomUpElt| |t|)))
                |u|)
               (#1#
                (PROGN
                 (SETQ |amsl| (|printableArgModeSetList|))
                 (SETQ |opName1|
                         (COND
                          ((EQUAL |opName0| |$immediateDataSymbol|)
                           (COND
                            ((SETQ |o|
                                     (|coerceInteractive| (|getValue| |op0|)
                                      |$OutputForm|))
                             (|outputTran2| (|objValUnwrap| |o|)))
                            (#1# NIL)))
                          (#1# |opName0|)))
                 (COND
                  ((NULL |opName1|)
                   (SETQ |opName1|
                           (COND
                            ((SETQ |o| (|getValue| |op0|))
                             (|prefix2String| (|objMode| |o|)))
                            (#1# "<unknown type>")))
                   (SETQ |msgKey|
                           (COND ((NULL |amsl|) 'S2IB0013) (#1# 'S2IB0012))))
                  (#1#
                   (SETQ |msgKey|
                           (COND ((NULL |amsl|) 'S2IB0011)
                                 ((SETQ |n| (|isSharpVarWithNum| |opName1|))
                                  (PROGN (SETQ |opName1| |n|) '|S2IB0008g|))
                                 (#1# 'S2IB0008)))))
                 (|sayIntelligentMessageAboutOpAvailability| |opName1|
                  (LENGTH |argl|))
                 (COND
                  ((NULL |$genValue|)
                   (|keyedMsgCompFailureSP| |msgKey| (LIST |opName1| |amsl|)
                    |op0|))
                  (#1#
                   (|throwKeyedMsgSP| |msgKey| (LIST |opName1| |amsl|)
                    |op0|)))))))))))))

; sayIntelligentMessageAboutOpAvailability(opName, nArgs) ==
;   -- see if we can give some decent messages about the availability if
;   -- library messages
;
;   NUMBERP opName => NIL
;
;   oo :=  object2Identifier opOf opName
;   if ( oo = "%" ) or ( domainForm? opName ) then
;     opName := "elt"
;
;   nAllExposedMmsWithName := #getModemapsFromDatabase(opName, NIL)
;   nAllMmsWithName        := #getAllModemapsFromDatabase(opName, NIL)
;
;   -- first see if there are ANY ops with this name
;
;   if nAllMmsWithName = 0 then
;     sayKeyedMsg("S2IB0008a", [opName])
;   else if nAllExposedMmsWithName = 0 then
;     nAllMmsWithName = 1 => sayKeyedMsg("S2IB0008b", [opName])
;     sayKeyedMsg("S2IB0008c", [opName, nAllMmsWithName])
;   else
;     -- now talk about specific arguments
;     nAllExposedMmsWithNameAndArgs   := #getModemapsFromDatabase(opName, nArgs)
;     nAllMmsWithNameAndArgs          := #getAllModemapsFromDatabase(opName, nArgs)
;     nAllMmsWithNameAndArgs = 0 =>
;         sayKeyedMsg("S2IB0008d", [opName, nArgs, nAllExposedMmsWithName, nAllMmsWithName - nAllExposedMmsWithName])
;     nAllExposedMmsWithNameAndArgs = 0 =>
;         sayKeyedMsg("S2IB0008e", [opName, nArgs, nAllMmsWithNameAndArgs - nAllExposedMmsWithNameAndArgs])
;     sayKeyedMsg("S2IB0008f", [opName, nArgs, nAllExposedMmsWithNameAndArgs, nAllMmsWithNameAndArgs - nAllExposedMmsWithNameAndArgs])
;   nil

(DEFUN |sayIntelligentMessageAboutOpAvailability| (|opName| |nArgs|)
  (PROG (|oo| |nAllExposedMmsWithName| |nAllMmsWithName|
         |nAllExposedMmsWithNameAndArgs| |nAllMmsWithNameAndArgs|)
    (RETURN
     (COND ((NUMBERP |opName|) NIL)
           (#1='T
            (PROGN
             (SETQ |oo| (|object2Identifier| (|opOf| |opName|)))
             (COND
              ((OR (EQ |oo| '%) (|domainForm?| |opName|))
               (SETQ |opName| '|elt|)))
             (SETQ |nAllExposedMmsWithName|
                     (LENGTH (|getModemapsFromDatabase| |opName| NIL)))
             (SETQ |nAllMmsWithName|
                     (LENGTH (|getAllModemapsFromDatabase| |opName| NIL)))
             (COND
              ((EQL |nAllMmsWithName| 0)
               (|sayKeyedMsg| '|S2IB0008a| (LIST |opName|)))
              ((EQL |nAllExposedMmsWithName| 0)
               (COND
                ((EQL |nAllMmsWithName| 1)
                 (|sayKeyedMsg| '|S2IB0008b| (LIST |opName|)))
                (#1#
                 (|sayKeyedMsg| '|S2IB0008c|
                  (LIST |opName| |nAllMmsWithName|)))))
              (#1#
               (SETQ |nAllExposedMmsWithNameAndArgs|
                       (LENGTH (|getModemapsFromDatabase| |opName| |nArgs|)))
               (SETQ |nAllMmsWithNameAndArgs|
                       (LENGTH
                        (|getAllModemapsFromDatabase| |opName| |nArgs|)))
               (COND
                ((EQL |nAllMmsWithNameAndArgs| 0)
                 (|sayKeyedMsg| '|S2IB0008d|
                  (LIST |opName| |nArgs| |nAllExposedMmsWithName|
                        (- |nAllMmsWithName| |nAllExposedMmsWithName|))))
                ((EQL |nAllExposedMmsWithNameAndArgs| 0)
                 (|sayKeyedMsg| '|S2IB0008e|
                  (LIST |opName| |nArgs|
                        (- |nAllMmsWithNameAndArgs|
                           |nAllExposedMmsWithNameAndArgs|))))
                (#1#
                 (|sayKeyedMsg| '|S2IB0008f|
                  (LIST |opName| |nArgs| |nAllExposedMmsWithNameAndArgs|
                        (- |nAllMmsWithNameAndArgs|
                           |nAllExposedMmsWithNameAndArgs|)))))))
             NIL))))))

; bottomUpType(t, type) ==
;   mode :=
;     if isPartialMode type then '(Mode)
;     else if categoryForm?(type) then '(Category)
;          else '(Type)
;   val:= objNew(type,mode)
;   putValue(t,val)
;   -- have to fix the following
;   putModeSet(t,[mode])

(DEFUN |bottomUpType| (|t| |type|)
  (PROG (|mode| |val|)
    (RETURN
     (PROGN
      (SETQ |mode|
              (COND ((|isPartialMode| |type|) '(|Mode|))
                    ((|categoryForm?| |type|) '(|Category|)) ('T '(|Type|))))
      (SETQ |val| (|objNew| |type| |mode|))
      (|putValue| |t| |val|)
      (|putModeSet| |t| (LIST |mode|))))))

; bottomUpPercent(tree is [op,:argl]) ==
;   -- handles a call %%(5), which means the output of step 5
;   -- %%() is the same as %%(-1)
;   null argl =>
;     val:= fetchOutput(-1)
;     putValue(op,val)
;     putModeSet(op,[objMode(val)])
;   argl is [t] =>
;     i:= getArgValue(t,$Integer) =>
;       val:= fetchOutput i
;       putValue(op,val)
;       putModeSet(op,[objMode(val)])
;     throwKeyedMsgSP("S2IB0006", NIL, t)
;   throwKeyedMsgSP("S2IB0006", NIL, op)

(DEFUN |bottomUpPercent| (|tree|)
  (PROG (|op| |argl| |val| |t| |i|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |tree|))
      (SETQ |argl| (CDR |tree|))
      (COND
       ((NULL |argl|)
        (PROGN
         (SETQ |val| (|fetchOutput| (- 1)))
         (|putValue| |op| |val|)
         (|putModeSet| |op| (LIST (|objMode| |val|)))))
       ((AND (CONSP |argl|) (EQ (CDR |argl|) NIL)
             (PROGN (SETQ |t| (CAR |argl|)) #1='T))
        (COND
         ((SETQ |i| (|getArgValue| |t| |$Integer|))
          (PROGN
           (SETQ |val| (|fetchOutput| |i|))
           (|putValue| |op| |val|)
           (|putModeSet| |op| (LIST (|objMode| |val|)))))
         (#1# (|throwKeyedMsgSP| 'S2IB0006 NIL |t|))))
       (#1# (|throwKeyedMsgSP| 'S2IB0006 NIL |op|)))))))

; bottomUpFormRetract(t,op,opName,argl,amsl) ==
;   -- tries to find one argument, which can be pulled back, and calls
;   -- bottomUpForm again. We do not retract the first argument to a
;   -- setelt, because this is presumably a destructive operation and
;   -- the retract can create a new object.
;
;   -- if no such operation exists in the database, don't bother
;   $inRetract: local := true
;   null getAllModemapsFromDatabase(getUnname op,#argl) => NIL
;
;   u := bottomUpFormAnyUnionRetract(t,op,opName,argl,amsl) => u
;
;   a  := NIL
;   b  := NIL
;   ms := NIL
;   for x in argl for m in amsl for i in 1.. repeat
;     -- do not retract first arg of a setelt
;     (i = 1) and (opName = "setelt!") =>
;         a := [x,:a]
;         ms := [m,:ms]
;     (i = 1) and (opName = "set!") =>
;         a := [x,:a]
;         ms := [m,:ms]
;     if PAIRP(m) and first(m) = $EmptyMode then return NIL
;     object:= retract getValue x
;     a:= [x,:a]
;     EQ(object,'failed) =>
;         putAtree(x,'retracted,nil)
;         ms := [m, :ms]
;     b:= true
;     RPLACA(m,objMode(object))
;     ms := [COPY_-TREE m, :ms]
;     putAtree(x,'retracted,true)
;     putValue(x,object)
;     putModeSet(x,[objMode(object)])
;   --insert pulled-back items
;   a := nreverse a
;   ms := nreverse ms
;
;   -- check that we haven't seen these types before
;   typesHad := getAtree(t, 'typesHad)
;   if member(ms, typesHad) then b := nil
;   else putAtree(t, 'typesHad, cons(ms, typesHad))
;
;   b and bottomUpForm(t,op,opName,a,amsl)

(DEFUN |bottomUpFormRetract| (|t| |op| |opName| |argl| |amsl|)
  (PROG (|$inRetract| |typesHad| |object| |ms| |b| |a| |u|)
    (DECLARE (SPECIAL |$inRetract|))
    (RETURN
     (PROGN
      (SETQ |$inRetract| T)
      (COND
       ((NULL
         (|getAllModemapsFromDatabase| (|getUnname| |op|) (LENGTH |argl|)))
        NIL)
       ((SETQ |u|
                (|bottomUpFormAnyUnionRetract| |t| |op| |opName| |argl|
                 |amsl|))
        |u|)
       (#1='T
        (PROGN
         (SETQ |a| NIL)
         (SETQ |b| NIL)
         (SETQ |ms| NIL)
         ((LAMBDA (|bfVar#26| |x| |bfVar#27| |m| |i|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#26|) (PROGN (SETQ |x| (CAR |bfVar#26|)) NIL)
                   (ATOM |bfVar#27|) (PROGN (SETQ |m| (CAR |bfVar#27|)) NIL))
               (RETURN NIL))
              (#1#
               (COND
                ((AND (EQL |i| 1) (EQ |opName| '|setelt!|))
                 (PROGN (SETQ |a| (CONS |x| |a|)) (SETQ |ms| (CONS |m| |ms|))))
                ((AND (EQL |i| 1) (EQ |opName| '|set!|))
                 (PROGN (SETQ |a| (CONS |x| |a|)) (SETQ |ms| (CONS |m| |ms|))))
                (#1#
                 (PROGN
                  (COND
                   ((AND (CONSP |m|) (EQUAL (CAR |m|) |$EmptyMode|))
                    (RETURN NIL)))
                  (SETQ |object| (|retract| (|getValue| |x|)))
                  (SETQ |a| (CONS |x| |a|))
                  (COND
                   ((EQ |object| '|failed|)
                    (PROGN
                     (|putAtree| |x| '|retracted| NIL)
                     (SETQ |ms| (CONS |m| |ms|))))
                   (#1#
                    (PROGN
                     (SETQ |b| T)
                     (RPLACA |m| (|objMode| |object|))
                     (SETQ |ms| (CONS (COPY-TREE |m|) |ms|))
                     (|putAtree| |x| '|retracted| T)
                     (|putValue| |x| |object|)
                     (|putModeSet| |x| (LIST (|objMode| |object|)))))))))))
             (SETQ |bfVar#26| (CDR |bfVar#26|))
             (SETQ |bfVar#27| (CDR |bfVar#27|))
             (SETQ |i| (+ |i| 1))))
          |argl| NIL |amsl| NIL 1)
         (SETQ |a| (NREVERSE |a|))
         (SETQ |ms| (NREVERSE |ms|))
         (SETQ |typesHad| (|getAtree| |t| '|typesHad|))
         (COND ((|member| |ms| |typesHad|) (SETQ |b| NIL))
               (#1# (|putAtree| |t| '|typesHad| (CONS |ms| |typesHad|))))
         (AND |b| (|bottomUpForm| |t| |op| |opName| |a| |amsl|)))))))))

; retractAtree atr ==
;     object:= retract getValue atr
;     EQ(object,'failed) =>
;         putAtree(atr,'retracted,nil)
;         nil
;     putAtree(atr,'retracted,true)
;     putValue(atr,object)
;     putModeSet(atr,[objMode(object)])
;     true

(DEFUN |retractAtree| (|atr|)
  (PROG (|object|)
    (RETURN
     (PROGN
      (SETQ |object| (|retract| (|getValue| |atr|)))
      (COND
       ((EQ |object| '|failed|)
        (PROGN (|putAtree| |atr| '|retracted| NIL) NIL))
       ('T
        (PROGN
         (|putAtree| |atr| '|retracted| T)
         (|putValue| |atr| |object|)
         (|putModeSet| |atr| (LIST (|objMode| |object|)))
         T)))))))

; bottomUpFormAnyUnionRetract(t,op,opName,argl,amsl) ==
;   -- see if we have a Union
;
;   ok := NIL
;   for m in amsl while not ok repeat
;     if atom first(m) then return NIL
;     first m = $Any => ok := true
;     (first first m = 'Union) => ok := true
;   not ok => NIL
;
;   a:= NIL
;   b:= NIL
;
;   for x in argl for m in amsl for i in 0.. repeat
;     m0 := first m
;     if ( (m0 = $Any) or (first m0 = 'Union) ) and
;       ('failed~=(object:=retract getValue x)) then
;         b := true
;         RPLACA(m,objMode(object))
;         putModeSet(x,[objMode(object)])
;         putValue(x,object)
;     a := cons(x,a)
;   b and bottomUpForm(t,op,opName,nreverse a,amsl)

(DEFUN |bottomUpFormAnyUnionRetract| (|t| |op| |opName| |argl| |amsl|)
  (PROG (|ok| |a| |b| |m0| |object|)
    (RETURN
     (PROGN
      (SETQ |ok| NIL)
      ((LAMBDA (|bfVar#28| |m|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#28|) (PROGN (SETQ |m| (CAR |bfVar#28|)) NIL) |ok|)
            (RETURN NIL))
           (#1='T
            (PROGN
             (COND ((ATOM (CAR |m|)) (RETURN NIL)))
             (COND ((EQUAL (CAR |m|) |$Any|) (SETQ |ok| T))
                   ((EQ (CAR (CAR |m|)) '|Union|) (SETQ |ok| T))))))
          (SETQ |bfVar#28| (CDR |bfVar#28|))))
       |amsl| NIL)
      (COND ((NULL |ok|) NIL)
            (#1#
             (PROGN
              (SETQ |a| NIL)
              (SETQ |b| NIL)
              ((LAMBDA (|bfVar#29| |x| |bfVar#30| |m| |i|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#29|)
                        (PROGN (SETQ |x| (CAR |bfVar#29|)) NIL)
                        (ATOM |bfVar#30|)
                        (PROGN (SETQ |m| (CAR |bfVar#30|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (PROGN
                     (SETQ |m0| (CAR |m|))
                     (COND
                      ((AND (OR (EQUAL |m0| |$Any|) (EQ (CAR |m0|) '|Union|))
                            (NOT
                             (EQ '|failed|
                                 (SETQ |object|
                                         (|retract| (|getValue| |x|))))))
                       (SETQ |b| T) (RPLACA |m| (|objMode| |object|))
                       (|putModeSet| |x| (LIST (|objMode| |object|)))
                       (|putValue| |x| |object|)))
                     (SETQ |a| (CONS |x| |a|)))))
                  (SETQ |bfVar#29| (CDR |bfVar#29|))
                  (SETQ |bfVar#30| (CDR |bfVar#30|))
                  (SETQ |i| (+ |i| 1))))
               |argl| NIL |amsl| NIL 0)
              (AND |b|
                   (|bottomUpForm| |t| |op| |opName| (NREVERSE |a|)
                    |amsl|)))))))))

; bottomUpFormUntaggedUnionRetract(t,op,opName,argl,amsl) ==
;   -- see if we have a Union with no tags, if so retract all such guys
;
;   ok := NIL
;   for [m] in amsl while not ok repeat
;     if atom m then return NIL
;     if m is ['Union, :.] and null getUnionOrRecordTags m then ok := true
;   not ok => NIL
;
;   a:= NIL
;   b:= NIL
;
;   for x in argl for m in amsl for i in 0.. repeat
;     m0 := first m
;     if (m0 is ['Union, :.] and null getUnionOrRecordTags m0) and
;       ('failed ~= (object:=retract getValue x)) then
;         b := true
;         RPLACA(m,objMode(object))
;         putModeSet(x,[objMode(object)])
;         putValue(x,object)
;     a := cons(x,a)
;   b and bottomUpForm(t,op,opName,nreverse a,amsl)

(DEFUN |bottomUpFormUntaggedUnionRetract| (|t| |op| |opName| |argl| |amsl|)
  (PROG (|ok| |m| |a| |b| |m0| |object|)
    (RETURN
     (PROGN
      (SETQ |ok| NIL)
      ((LAMBDA (|bfVar#32| |bfVar#31|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#32|)
                (PROGN (SETQ |bfVar#31| (CAR |bfVar#32|)) NIL) |ok|)
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#31|) (EQ (CDR |bfVar#31|) NIL)
                 (PROGN (SETQ |m| (CAR |bfVar#31|)) #1#)
                 (PROGN
                  (COND ((ATOM |m|) (RETURN NIL)))
                  (COND
                   ((AND (CONSP |m|) (EQ (CAR |m|) '|Union|)
                         (NULL (|getUnionOrRecordTags| |m|)))
                    (SETQ |ok| T)))))))
          (SETQ |bfVar#32| (CDR |bfVar#32|))))
       |amsl| NIL)
      (COND ((NULL |ok|) NIL)
            (#1#
             (PROGN
              (SETQ |a| NIL)
              (SETQ |b| NIL)
              ((LAMBDA (|bfVar#33| |x| |bfVar#34| |m| |i|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#33|)
                        (PROGN (SETQ |x| (CAR |bfVar#33|)) NIL)
                        (ATOM |bfVar#34|)
                        (PROGN (SETQ |m| (CAR |bfVar#34|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (PROGN
                     (SETQ |m0| (CAR |m|))
                     (COND
                      ((AND (CONSP |m0|) (EQ (CAR |m0|) '|Union|)
                            (NULL (|getUnionOrRecordTags| |m0|))
                            (NOT
                             (EQ '|failed|
                                 (SETQ |object|
                                         (|retract| (|getValue| |x|))))))
                       (SETQ |b| T) (RPLACA |m| (|objMode| |object|))
                       (|putModeSet| |x| (LIST (|objMode| |object|)))
                       (|putValue| |x| |object|)))
                     (SETQ |a| (CONS |x| |a|)))))
                  (SETQ |bfVar#33| (CDR |bfVar#33|))
                  (SETQ |bfVar#34| (CDR |bfVar#34|))
                  (SETQ |i| (+ |i| 1))))
               |argl| NIL |amsl| NIL 0)
              (AND |b|
                   (|bottomUpForm| |t| |op| |opName| (NREVERSE |a|)
                    |amsl|)))))))))

; bottomUpElt (form:=[op,:argl]) ==
;   -- this transfers expressions that look like function calls into
;   -- forms with elt or apply.
;
;     ms := bottomUp op
;     ms and (ms is [['Union,:.]] or ms is [['Record,:.]]) =>
;         rplac(rest form, [op, :argl])
;         rplac(first form, mkAtreeNode "elt")
;         bottomUp form
;
;     target  := getTarget form
;
;     newOps := [mkAtreeNode "elt", mkAtreeNode "apply"]
;     u := nil
;
;     while not u for newOp in newOps repeat
;         newArgs := [op,:argl]
;         if selectMms(newOp, newArgs, target) then
;             rplac(rest form, newArgs)
;             rplac(first form, newOp)
;             u := bottomUp form
;
;     while not u and ( "and"/[retractAtree(a) for a in newArgs] ) repeat
;         while not u for newOp in newOps repeat
;             newArgs := [op,:argl]
;             if selectMms(newOp, newArgs, target) then
;                 rplac(rest form, newArgs)
;                 rplac(first form, newOp)
;                 u := bottomUp form
;     u

(DEFUN |bottomUpElt| (|form|)
  (PROG (|op| |argl| |ms| |ISTMP#1| |target| |newOps| |u| |newArgs|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |ms| (|bottomUp| |op|))
      (COND
       ((AND |ms|
             (OR
              (AND (CONSP |ms|) (EQ (CDR |ms|) NIL)
                   (PROGN
                    (SETQ |ISTMP#1| (CAR |ms|))
                    (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Union|))))
              (AND (CONSP |ms|) (EQ (CDR |ms|) NIL)
                   (PROGN
                    (SETQ |ISTMP#1| (CAR |ms|))
                    (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Record|))))))
        (PROGN
         (|rplac| (CDR |form|) (CONS |op| |argl|))
         (|rplac| (CAR |form|) (|mkAtreeNode| '|elt|))
         (|bottomUp| |form|)))
       (#1='T
        (PROGN
         (SETQ |target| (|getTarget| |form|))
         (SETQ |newOps| (LIST (|mkAtreeNode| '|elt|) (|mkAtreeNode| '|apply|)))
         (SETQ |u| NIL)
         ((LAMBDA (|bfVar#35| |newOp|)
            (LOOP
             (COND
              ((OR |u| (ATOM |bfVar#35|)
                   (PROGN (SETQ |newOp| (CAR |bfVar#35|)) NIL))
               (RETURN NIL))
              (#1#
               (PROGN
                (SETQ |newArgs| (CONS |op| |argl|))
                (COND
                 ((|selectMms| |newOp| |newArgs| |target|)
                  (|rplac| (CDR |form|) |newArgs|)
                  (|rplac| (CAR |form|) |newOp|)
                  (SETQ |u| (|bottomUp| |form|)))))))
             (SETQ |bfVar#35| (CDR |bfVar#35|))))
          |newOps| NIL)
         ((LAMBDA ()
            (LOOP
             (COND
              ((NOT
                (AND (NULL |u|)
                     ((LAMBDA (|bfVar#37| |bfVar#36| |a|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#36|)
                               (PROGN (SETQ |a| (CAR |bfVar#36|)) NIL))
                           (RETURN |bfVar#37|))
                          (#1#
                           (PROGN
                            (SETQ |bfVar#37| (|retractAtree| |a|))
                            (COND ((NOT |bfVar#37|) (RETURN NIL))))))
                         (SETQ |bfVar#36| (CDR |bfVar#36|))))
                      T |newArgs| NIL)))
               (RETURN NIL))
              (#1#
               ((LAMBDA (|bfVar#38| |newOp|)
                  (LOOP
                   (COND
                    ((OR |u| (ATOM |bfVar#38|)
                         (PROGN (SETQ |newOp| (CAR |bfVar#38|)) NIL))
                     (RETURN NIL))
                    (#1#
                     (PROGN
                      (SETQ |newArgs| (CONS |op| |argl|))
                      (COND
                       ((|selectMms| |newOp| |newArgs| |target|)
                        (|rplac| (CDR |form|) |newArgs|)
                        (|rplac| (CAR |form|) |newOp|)
                        (SETQ |u| (|bottomUp| |form|)))))))
                   (SETQ |bfVar#38| (CDR |bfVar#38|))))
                |newOps| NIL))))))
         |u|)))))))

; isEltable(op,argl,numArgs) ==
;   -- determines if the object might possible have an elt function
;   -- we exclude Mapping and Variable types explicitly
;   v := getValue op =>
;     ZEROP numArgs => true
;     not(m := objMode(v)) => nil
;     m is ['Mapping, :.] => nil
;     objVal(v) is ['SPADMAP, :mapDef] and numMapArgs(mapDef) > 0 => nil
;     true
;   m := getMode op =>
;     ZEROP numArgs => true
;     m is ['Mapping, :.] => nil
;     true
;   numArgs ~= 1 => nil
;   name := getUnname op
;   name = 'SEQ => nil
;   arg := first argl
;   (getUnname arg) ~= 'construct => nil
;   true

(DEFUN |isEltable| (|op| |argl| |numArgs|)
  (PROG (|v| |m| |ISTMP#1| |mapDef| |name| |arg|)
    (RETURN
     (COND
      ((SETQ |v| (|getValue| |op|))
       (COND ((ZEROP |numArgs|) T) ((NULL (SETQ |m| (|objMode| |v|))) NIL)
             ((AND (CONSP |m|) (EQ (CAR |m|) '|Mapping|)) NIL)
             ((AND
               (PROGN
                (SETQ |ISTMP#1| (|objVal| |v|))
                (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADMAP)
                     (PROGN (SETQ |mapDef| (CDR |ISTMP#1|)) #1='T)))
               (< 0 (|numMapArgs| |mapDef|)))
              NIL)
             (#1# T)))
      ((SETQ |m| (|getMode| |op|))
       (COND ((ZEROP |numArgs|) T)
             ((AND (CONSP |m|) (EQ (CAR |m|) '|Mapping|)) NIL) (#1# T)))
      ((NOT (EQL |numArgs| 1)) NIL)
      (#1#
       (PROGN
        (SETQ |name| (|getUnname| |op|))
        (COND ((EQ |name| 'SEQ) NIL)
              (#1#
               (PROGN
                (SETQ |arg| (CAR |argl|))
                (COND ((NOT (EQ (|getUnname| |arg|) '|construct|)) NIL)
                      (#1# T)))))))))))

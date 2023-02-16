
; )package "BOOT"

(IN-PACKAGE "BOOT")

; $genValue := false

(EVAL-WHEN (EVAL LOAD) (SETQ |$genValue| NIL))

; quoteNontypeArgs(t) ==
;     t is [.] => t
;     op := opOf t
;     loadIfNecessary op
;     args := rest t
;     cs := rest GETDATABASE(op, 'COSIG)
;     nargs := [if c then quoteNontypeArgs(a) else ["QUOTE", a]
;                 for a in args for c in cs]
;     [op, :nargs]

(DEFUN |quoteNontypeArgs| (|t|)
  (PROG (|op| |args| |cs| |nargs|)
    (RETURN
     (COND ((AND (CONSP |t|) (EQ (CDR |t|) NIL)) |t|)
           (#1='T
            (PROGN
             (SETQ |op| (|opOf| |t|))
             (|loadIfNecessary| |op|)
             (SETQ |args| (CDR |t|))
             (SETQ |cs| (CDR (GETDATABASE |op| 'COSIG)))
             (SETQ |nargs|
                     ((LAMBDA (|bfVar#3| |bfVar#1| |a| |bfVar#2| |c|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#1|)
                               (PROGN (SETQ |a| (CAR |bfVar#1|)) NIL)
                               (ATOM |bfVar#2|)
                               (PROGN (SETQ |c| (CAR |bfVar#2|)) NIL))
                           (RETURN (NREVERSE |bfVar#3|)))
                          (#1#
                           (SETQ |bfVar#3|
                                   (CONS
                                    (COND (|c| (|quoteNontypeArgs| |a|))
                                          (#1# (LIST 'QUOTE |a|)))
                                    |bfVar#3|))))
                         (SETQ |bfVar#1| (CDR |bfVar#1|))
                         (SETQ |bfVar#2| (CDR |bfVar#2|))))
                      NIL |args| NIL |cs| NIL))
             (CONS |op| |nargs|)))))))

; evalType(t) == EVAL(quoteNontypeArgs(t))

(DEFUN |evalType| (|t|) (PROG () (RETURN (EVAL (|quoteNontypeArgs| |t|)))))

; $noEvalTypeMsg := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$noEvalTypeMsg| NIL))

; $evalDomain := nil

(EVAL-WHEN (EVAL LOAD) (SETQ |$evalDomain| NIL))

; evalDomain form ==
;   if $evalDomain then
;     sayMSG concat('"   instantiating","%b",prefix2String form,"%d")
;   startTimingProcess 'instantiation
;   result := eval mkEvalable form
;   stopTimingProcess 'instantiation
;   result

(DEFUN |evalDomain| (|form|)
  (PROG (|result|)
    (RETURN
     (PROGN
      (COND
       (|$evalDomain|
        (|sayMSG|
         (|concat| "   instantiating" '|%b| (|prefix2String| |form|) '|%d|))))
      (|startTimingProcess| '|instantiation|)
      (SETQ |result| (|eval| (|mkEvalable| |form|)))
      (|stopTimingProcess| '|instantiation|)
      |result|))))

; mkEvalable form ==
;   form is [op,:argl] =>
;     op="QUOTE" => form
;     op="WRAPPED" => mkEvalable devaluate argl
;     op="Record" => mkEvalableRecord form
;     op="Union"  => mkEvalableUnion  form
;     op="Mapping"=> mkEvalableMapping form
;     op="Enumeration" => form
;     loadIfNecessary op
;     kind:= GETDATABASE(op,'CONSTRUCTORKIND)
;     cosig := GETDATABASE(op, 'COSIG) =>
;       [op,:[val for x in argl for typeFlag in rest cosig]] where val ==
;         typeFlag =>
;           kind = 'category => MKQ x
;           VECP x => MKQ x
;           mkEvalable x
;         x is ['QUOTE,:.] => x
;         x is ['_#,y] => ['SIZE,MKQ y]
;         MKQ x
;     [op,:[mkEvalable x for x in argl]]
;   form=$EmptyMode => $Integer
;   IDENTP form and constructor?(form) => [form]
;   FBPIP form => BREAK()
;   form

(DEFUN |mkEvalable| (|form|)
  (PROG (|op| |argl| |kind| |cosig| |ISTMP#1| |y|)
    (RETURN
     (COND
      ((AND (CONSP |form|)
            (PROGN (SETQ |op| (CAR |form|)) (SETQ |argl| (CDR |form|)) #1='T))
       (COND ((EQ |op| 'QUOTE) |form|)
             ((EQ |op| 'WRAPPED) (|mkEvalable| (|devaluate| |argl|)))
             ((EQ |op| '|Record|) (|mkEvalableRecord| |form|))
             ((EQ |op| '|Union|) (|mkEvalableUnion| |form|))
             ((EQ |op| '|Mapping|) (|mkEvalableMapping| |form|))
             ((EQ |op| '|Enumeration|) |form|)
             (#1#
              (PROGN
               (|loadIfNecessary| |op|)
               (SETQ |kind| (GETDATABASE |op| 'CONSTRUCTORKIND))
               (COND
                ((SETQ |cosig| (GETDATABASE |op| 'COSIG))
                 (CONS |op|
                       ((LAMBDA (|bfVar#6| |bfVar#4| |x| |bfVar#5| |typeFlag|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#4|)
                                 (PROGN (SETQ |x| (CAR |bfVar#4|)) NIL)
                                 (ATOM |bfVar#5|)
                                 (PROGN (SETQ |typeFlag| (CAR |bfVar#5|)) NIL))
                             (RETURN (NREVERSE |bfVar#6|)))
                            (#1#
                             (SETQ |bfVar#6|
                                     (CONS
                                      (COND
                                       (|typeFlag|
                                        (COND
                                         ((EQ |kind| '|category|) (MKQ |x|))
                                         ((VECP |x|) (MKQ |x|))
                                         (#1# (|mkEvalable| |x|))))
                                       ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE))
                                        |x|)
                                       ((AND (CONSP |x|) (EQ (CAR |x|) '|#|)
                                             (PROGN
                                              (SETQ |ISTMP#1| (CDR |x|))
                                              (AND (CONSP |ISTMP#1|)
                                                   (EQ (CDR |ISTMP#1|) NIL)
                                                   (PROGN
                                                    (SETQ |y| (CAR |ISTMP#1|))
                                                    #1#))))
                                        (LIST 'SIZE (MKQ |y|)))
                                       (#1# (MKQ |x|)))
                                      |bfVar#6|))))
                           (SETQ |bfVar#4| (CDR |bfVar#4|))
                           (SETQ |bfVar#5| (CDR |bfVar#5|))))
                        NIL |argl| NIL (CDR |cosig|) NIL)))
                (#1#
                 (CONS |op|
                       ((LAMBDA (|bfVar#8| |bfVar#7| |x|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#7|)
                                 (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                             (RETURN (NREVERSE |bfVar#8|)))
                            (#1#
                             (SETQ |bfVar#8|
                                     (CONS (|mkEvalable| |x|) |bfVar#8|))))
                           (SETQ |bfVar#7| (CDR |bfVar#7|))))
                        NIL |argl| NIL))))))))
      ((EQUAL |form| |$EmptyMode|) |$Integer|)
      ((AND (IDENTP |form|) (|constructor?| |form|)) (LIST |form|))
      ((FBPIP |form|) (BREAK)) (#1# |form|)))))

; mkEvalableMapping form ==
;   [first form,:[mkEvalable d for d in rest form]]

(DEFUN |mkEvalableMapping| (|form|)
  (PROG ()
    (RETURN
     (CONS (CAR |form|)
           ((LAMBDA (|bfVar#10| |bfVar#9| |d|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#9|) (PROGN (SETQ |d| (CAR |bfVar#9|)) NIL))
                 (RETURN (NREVERSE |bfVar#10|)))
                ('T (SETQ |bfVar#10| (CONS (|mkEvalable| |d|) |bfVar#10|))))
               (SETQ |bfVar#9| (CDR |bfVar#9|))))
            NIL (CDR |form|) NIL)))))

; mkEvalableRecord form ==
;   [first form,:[[":",n,mkEvalable d] for [":",n,d] in rest form]]

(DEFUN |mkEvalableRecord| (|form|)
  (PROG (|ISTMP#1| |n| |ISTMP#2| |d|)
    (RETURN
     (CONS (CAR |form|)
           ((LAMBDA (|bfVar#13| |bfVar#12| |bfVar#11|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#12|)
                     (PROGN (SETQ |bfVar#11| (CAR |bfVar#12|)) NIL))
                 (RETURN (NREVERSE |bfVar#13|)))
                (#1='T
                 (AND (CONSP |bfVar#11|) (EQ (CAR |bfVar#11|) '|:|)
                      (PROGN
                       (SETQ |ISTMP#1| (CDR |bfVar#11|))
                       (AND (CONSP |ISTMP#1|)
                            (PROGN
                             (SETQ |n| (CAR |ISTMP#1|))
                             (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                             (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                  (PROGN (SETQ |d| (CAR |ISTMP#2|)) #1#)))))
                      (SETQ |bfVar#13|
                              (CONS (LIST '|:| |n| (|mkEvalable| |d|))
                                    |bfVar#13|)))))
               (SETQ |bfVar#12| (CDR |bfVar#12|))))
            NIL (CDR |form|) NIL)))))

; mkEvalableUnion form ==
;   isTaggedUnion form =>
;     [first form,:[[":",n,mkEvalable d] for [":",n,d] in rest form]]
;   [first form,:[mkEvalable d for d in rest form]]

(DEFUN |mkEvalableUnion| (|form|)
  (PROG (|ISTMP#1| |n| |ISTMP#2| |d|)
    (RETURN
     (COND
      ((|isTaggedUnion| |form|)
       (CONS (CAR |form|)
             ((LAMBDA (|bfVar#16| |bfVar#15| |bfVar#14|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#15|)
                       (PROGN (SETQ |bfVar#14| (CAR |bfVar#15|)) NIL))
                   (RETURN (NREVERSE |bfVar#16|)))
                  (#1='T
                   (AND (CONSP |bfVar#14|) (EQ (CAR |bfVar#14|) '|:|)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |bfVar#14|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |n| (CAR |ISTMP#1|))
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                    (PROGN (SETQ |d| (CAR |ISTMP#2|)) #1#)))))
                        (SETQ |bfVar#16|
                                (CONS (LIST '|:| |n| (|mkEvalable| |d|))
                                      |bfVar#16|)))))
                 (SETQ |bfVar#15| (CDR |bfVar#15|))))
              NIL (CDR |form|) NIL)))
      (#1#
       (CONS (CAR |form|)
             ((LAMBDA (|bfVar#18| |bfVar#17| |d|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#17|)
                       (PROGN (SETQ |d| (CAR |bfVar#17|)) NIL))
                   (RETURN (NREVERSE |bfVar#18|)))
                  (#1# (SETQ |bfVar#18| (CONS (|mkEvalable| |d|) |bfVar#18|))))
                 (SETQ |bfVar#17| (CDR |bfVar#17|))))
              NIL (CDR |form|) NIL)))))))

; evaluateType form ==
;   -- Takes a parsed, unabbreviated type and evaluates it, replacing
;   --  type valued variables with their values, and calling bottomUp
;   --  on non-type valued arguments to the constructor
;   --  and finally checking to see whether the type satisfies the
;   --  conditions of its modemap
;   domain:= isDomainValuedVariable form => domain
;   form = $EmptyMode => form
;   form = "?"        => $EmptyMode
;   STRINGP form => form
;   form = "$" => form
;   form is ['typeOf,.] =>
;     form' := mkAtree form
;     bottomUp form'
;     objVal getValue(form')
;   form is [op,:argl] =>
;     op='CATEGORY =>
;       argl is [x,:sigs] => [op,x,:[evaluateSignature(s) for s in sigs]]
;       form
;     op in '(Join Mapping) =>
;       [op,:[evaluateType arg for arg in argl]]
;     op='Union  =>
;       argl and first argl is [x,.,.] and member(x,'(_: Declare)) =>
;         [op,:[['_:,sel,evaluateType type] for ['_:,sel,type] in argl]]
;       [op,:[evaluateType arg for arg in argl]]
;     op='Record =>
;       [op,:[['_:,sel,evaluateType type] for ['_:,sel,type] in argl]]
;     op='Enumeration => form
;     evaluateFormAsType form
;   constructor? form =>
;     ATOM form => evaluateType [form]
;     throwEvalTypeMsg("S2IE0003",[form,form])
;   throwEvalTypeMsg("S2IE0004", [form])

(DEFUN |evaluateType| (|form|)
  (PROG (|domain| |ISTMP#1| |form'| |op| |argl| |x| |sigs| |ISTMP#2| |ISTMP#3|
         |sel| |type|)
    (RETURN
     (COND ((SETQ |domain| (|isDomainValuedVariable| |form|)) |domain|)
           ((EQUAL |form| |$EmptyMode|) |form|) ((EQ |form| '?) |$EmptyMode|)
           ((STRINGP |form|) |form|) ((EQ |form| '$) |form|)
           ((AND (CONSP |form|) (EQ (CAR |form|) '|typeOf|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |form|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
            (PROGN
             (SETQ |form'| (|mkAtree| |form|))
             (|bottomUp| |form'|)
             (|objVal| (|getValue| |form'|))))
           ((AND (CONSP |form|)
                 (PROGN
                  (SETQ |op| (CAR |form|))
                  (SETQ |argl| (CDR |form|))
                  #1='T))
            (COND
             ((EQ |op| 'CATEGORY)
              (COND
               ((AND (CONSP |argl|)
                     (PROGN
                      (SETQ |x| (CAR |argl|))
                      (SETQ |sigs| (CDR |argl|))
                      #1#))
                (CONS |op|
                      (CONS |x|
                            ((LAMBDA (|bfVar#20| |bfVar#19| |s|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#19|)
                                      (PROGN (SETQ |s| (CAR |bfVar#19|)) NIL))
                                  (RETURN (NREVERSE |bfVar#20|)))
                                 (#1#
                                  (SETQ |bfVar#20|
                                          (CONS (|evaluateSignature| |s|)
                                                |bfVar#20|))))
                                (SETQ |bfVar#19| (CDR |bfVar#19|))))
                             NIL |sigs| NIL))))
               (#1# |form|)))
             ((|member| |op| '(|Join| |Mapping|))
              (CONS |op|
                    ((LAMBDA (|bfVar#22| |bfVar#21| |arg|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#21|)
                              (PROGN (SETQ |arg| (CAR |bfVar#21|)) NIL))
                          (RETURN (NREVERSE |bfVar#22|)))
                         (#1#
                          (SETQ |bfVar#22|
                                  (CONS (|evaluateType| |arg|) |bfVar#22|))))
                        (SETQ |bfVar#21| (CDR |bfVar#21|))))
                     NIL |argl| NIL)))
             ((EQ |op| '|Union|)
              (COND
               ((AND |argl|
                     (PROGN
                      (SETQ |ISTMP#1| (CAR |argl|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |x| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|)
                                 (PROGN
                                  (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                  (AND (CONSP |ISTMP#3|)
                                       (EQ (CDR |ISTMP#3|) NIL)))))))
                     (|member| |x| '(|:| |Declare|)))
                (CONS |op|
                      ((LAMBDA (|bfVar#25| |bfVar#24| |bfVar#23|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#24|)
                                (PROGN (SETQ |bfVar#23| (CAR |bfVar#24|)) NIL))
                            (RETURN (NREVERSE |bfVar#25|)))
                           (#1#
                            (AND (CONSP |bfVar#23|) (EQ (CAR |bfVar#23|) '|:|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |bfVar#23|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |sel| (CAR |ISTMP#1|))
                                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                        (AND (CONSP |ISTMP#2|)
                                             (EQ (CDR |ISTMP#2|) NIL)
                                             (PROGN
                                              (SETQ |type| (CAR |ISTMP#2|))
                                              #1#)))))
                                 (SETQ |bfVar#25|
                                         (CONS
                                          (LIST '|:| |sel|
                                                (|evaluateType| |type|))
                                          |bfVar#25|)))))
                          (SETQ |bfVar#24| (CDR |bfVar#24|))))
                       NIL |argl| NIL)))
               (#1#
                (CONS |op|
                      ((LAMBDA (|bfVar#27| |bfVar#26| |arg|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#26|)
                                (PROGN (SETQ |arg| (CAR |bfVar#26|)) NIL))
                            (RETURN (NREVERSE |bfVar#27|)))
                           (#1#
                            (SETQ |bfVar#27|
                                    (CONS (|evaluateType| |arg|) |bfVar#27|))))
                          (SETQ |bfVar#26| (CDR |bfVar#26|))))
                       NIL |argl| NIL)))))
             ((EQ |op| '|Record|)
              (CONS |op|
                    ((LAMBDA (|bfVar#30| |bfVar#29| |bfVar#28|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#29|)
                              (PROGN (SETQ |bfVar#28| (CAR |bfVar#29|)) NIL))
                          (RETURN (NREVERSE |bfVar#30|)))
                         (#1#
                          (AND (CONSP |bfVar#28|) (EQ (CAR |bfVar#28|) '|:|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |bfVar#28|))
                                (AND (CONSP |ISTMP#1|)
                                     (PROGN
                                      (SETQ |sel| (CAR |ISTMP#1|))
                                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                      (AND (CONSP |ISTMP#2|)
                                           (EQ (CDR |ISTMP#2|) NIL)
                                           (PROGN
                                            (SETQ |type| (CAR |ISTMP#2|))
                                            #1#)))))
                               (SETQ |bfVar#30|
                                       (CONS
                                        (LIST '|:| |sel|
                                              (|evaluateType| |type|))
                                        |bfVar#30|)))))
                        (SETQ |bfVar#29| (CDR |bfVar#29|))))
                     NIL |argl| NIL)))
             ((EQ |op| '|Enumeration|) |form|)
             (#1# (|evaluateFormAsType| |form|))))
           ((|constructor?| |form|)
            (COND ((ATOM |form|) (|evaluateType| (LIST |form|)))
                  (#1# (|throwEvalTypeMsg| 'S2IE0003 (LIST |form| |form|)))))
           (#1# (|throwEvalTypeMsg| 'S2IE0004 (LIST |form|)))))))

; evaluateFormAsType form ==
;   form is [op,:args] and constructor? op => evaluateType1 form
;   t := mkAtree form
;   -- ??? Maybe we should be more careful about generalized types.
;   bottomUp t is [m] and (m = ["Mode"] or isCategoryForm(m)) =>
;     objVal getValue t
;   throwEvalTypeMsg("S2IE0004",[form])

(DEFUN |evaluateFormAsType| (|form|)
  (PROG (|op| |args| |t| |ISTMP#1| |m|)
    (RETURN
     (COND
      ((AND (CONSP |form|)
            (PROGN (SETQ |op| (CAR |form|)) (SETQ |args| (CDR |form|)) #1='T)
            (|constructor?| |op|))
       (|evaluateType1| |form|))
      (#1#
       (PROGN
        (SETQ |t| (|mkAtree| |form|))
        (COND
         ((AND
           (PROGN
            (SETQ |ISTMP#1| (|bottomUp| |t|))
            (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                 (PROGN (SETQ |m| (CAR |ISTMP#1|)) #1#)))
           (OR (EQUAL |m| (LIST '|Mode|)) (|isCategoryForm| |m|)))
          (|objVal| (|getValue| |t|)))
         (#1# (|throwEvalTypeMsg| 'S2IE0004 (LIST |form|))))))))))

; evaluateType1 form ==
;   --evaluates the arguments passed to a constructor
;   [op,:argl]:= form
;   constructor? op =>
;     null (sig := getConstructorSignature form) =>
;        throwEvalTypeMsg("S2IE0005",[form])
;     [.,:ml] := sig
;     ml := replaceSharps(ml,form)
;     # argl ~= #ml => throwEvalTypeMsg("S2IE0003",[form,form])
;     for x in argl for m in ml for argnum in 1.. repeat
;       typeList := [v,:typeList] where v ==
;         categoryForm?(m) =>
;           m := evaluateType MSUBSTQ(x,'_$,m)
;           evalCategory(x' := (evaluateType x), m) => x'
;           throwEvalTypeMsg("S2IE0004",[form])
;         m := evaluateType m
;         GETDATABASE(opOf m,'CONSTRUCTORKIND) = 'domain and
;             (tree := mkAtree x) and  putTarget(tree,m) and ((bottomUp tree) is [m1]) =>
;                 [zt,:zv]:= z1:= getAndEvalConstructorArgument tree
;                 (v1 := coerceOrRetract(z1, m)) => objValUnwrap v1
;                 throwKeyedMsgCannotCoerceWithValue(zv,zt,m)
;         throwEvalTypeMsg("S2IE0006",[makeOrdinal argnum,m,form])
;     [op,:NREVERSE typeList]
;   throwEvalTypeMsg("S2IE0007",[op])

(DEFUN |evaluateType1| (|form|)
  (PROG (|op| |argl| |sig| |ml| |x'| |tree| |ISTMP#1| |m1| |z1| |zt| |zv| |v1|
         |typeList|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (COND
       ((|constructor?| |op|)
        (COND
         ((NULL (SETQ |sig| (|getConstructorSignature| |form|)))
          (|throwEvalTypeMsg| 'S2IE0005 (LIST |form|)))
         (#1='T
          (PROGN
           (SETQ |ml| (CDR |sig|))
           (SETQ |ml| (|replaceSharps| |ml| |form|))
           (COND
            ((NOT (EQL (LENGTH |argl|) (LENGTH |ml|)))
             (|throwEvalTypeMsg| 'S2IE0003 (LIST |form| |form|)))
            (#1#
             (PROGN
              ((LAMBDA (|bfVar#31| |x| |bfVar#32| |m| |argnum|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#31|)
                        (PROGN (SETQ |x| (CAR |bfVar#31|)) NIL)
                        (ATOM |bfVar#32|)
                        (PROGN (SETQ |m| (CAR |bfVar#32|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (SETQ |typeList|
                            (CONS
                             (COND
                              ((|categoryForm?| |m|)
                               (PROGN
                                (SETQ |m|
                                        (|evaluateType| (MSUBSTQ |x| '$ |m|)))
                                (COND
                                 ((|evalCategory|
                                   (SETQ |x'| (|evaluateType| |x|)) |m|)
                                  |x'|)
                                 (#1#
                                  (|throwEvalTypeMsg| 'S2IE0004
                                   (LIST |form|))))))
                              (#1#
                               (PROGN
                                (SETQ |m| (|evaluateType| |m|))
                                (COND
                                 ((AND
                                   (EQ
                                    (GETDATABASE (|opOf| |m|) 'CONSTRUCTORKIND)
                                    '|domain|)
                                   (SETQ |tree| (|mkAtree| |x|))
                                   (|putTarget| |tree| |m|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (|bottomUp| |tree|))
                                    (AND (CONSP |ISTMP#1|)
                                         (EQ (CDR |ISTMP#1|) NIL)
                                         (PROGN
                                          (SETQ |m1| (CAR |ISTMP#1|))
                                          #1#))))
                                  (PROGN
                                   (SETQ |z1|
                                           (|getAndEvalConstructorArgument|
                                            |tree|))
                                   (SETQ |zt| (CAR |z1|))
                                   (SETQ |zv| (CDR |z1|))
                                   (COND
                                    ((SETQ |v1| (|coerceOrRetract| |z1| |m|))
                                     (|objValUnwrap| |v1|))
                                    (#1#
                                     (|throwKeyedMsgCannotCoerceWithValue| |zv|
                                      |zt| |m|)))))
                                 (#1#
                                  (|throwEvalTypeMsg| 'S2IE0006
                                   (LIST (|makeOrdinal| |argnum|) |m|
                                         |form|)))))))
                             |typeList|))))
                  (SETQ |bfVar#31| (CDR |bfVar#31|))
                  (SETQ |bfVar#32| (CDR |bfVar#32|))
                  (SETQ |argnum| (+ |argnum| 1))))
               |argl| NIL |ml| NIL 1)
              (CONS |op| (NREVERSE |typeList|)))))))))
       (#1# (|throwEvalTypeMsg| 'S2IE0007 (LIST |op|))))))))

; throwEvalTypeMsg(msg, args) ==
;   $justUnparseType : local := true
;   $noEvalTypeMsg => spadThrow()
;   throwKeyedMsg(msg, args)

(DEFUN |throwEvalTypeMsg| (|msg| |args|)
  (PROG (|$justUnparseType|)
    (DECLARE (SPECIAL |$justUnparseType|))
    (RETURN
     (PROGN
      (SETQ |$justUnparseType| T)
      (COND (|$noEvalTypeMsg| (|spadThrow|))
            ('T (|throwKeyedMsg| |msg| |args|)))))))

; makeOrdinal i ==
;   ('(first second third fourth fifth sixth seventh eighth ninth tenth)).(i-1)

(DEFUN |makeOrdinal| (|i|)
  (PROG ()
    (RETURN
     (ELT
      '(|first| |second| |third| |fourth| |fifth| |sixth| |seventh| |eighth|
        |ninth| |tenth|)
      (- |i| 1)))))

; evaluateSignature sig ==
;   -- calls evaluateType on a signature
;   sig is [ ='SIGNATURE,fun,sigl] =>
;     ['SIGNATURE,fun,
;       [(t = '_$ => t; evaluateType(t)) for t in sigl]]
;   sig

(DEFUN |evaluateSignature| (|sig|)
  (PROG (|ISTMP#1| |fun| |ISTMP#2| |sigl|)
    (RETURN
     (COND
      ((AND (CONSP |sig|) (EQUAL (CAR |sig|) 'SIGNATURE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |sig|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |fun| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |sigl| (CAR |ISTMP#2|)) #1='T))))))
       (LIST 'SIGNATURE |fun|
             ((LAMBDA (|bfVar#34| |bfVar#33| |t|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#33|)
                       (PROGN (SETQ |t| (CAR |bfVar#33|)) NIL))
                   (RETURN (NREVERSE |bfVar#34|)))
                  (#1#
                   (SETQ |bfVar#34|
                           (CONS
                            (COND ((EQ |t| '$) |t|) (#1# (|evaluateType| |t|)))
                            |bfVar#34|))))
                 (SETQ |bfVar#33| (CDR |bfVar#33|))))
              NIL |sigl| NIL)))
      (#1# |sig|)))))

; splitIntoBlocksOf200 a ==
;   null a => nil
;   [[first (r:=x) for x in tails a for i in 1..200],
;     :splitIntoBlocksOf200 rest r]

(DEFUN |splitIntoBlocksOf200| (|a|)
  (PROG (|r|)
    (RETURN
     (COND ((NULL |a|) NIL)
           (#1='T
            (CONS
             ((LAMBDA (|bfVar#35| |x| |i|)
                (LOOP
                 (COND
                  ((OR (ATOM |x|) (> |i| 200)) (RETURN (NREVERSE |bfVar#35|)))
                  (#1#
                   (SETQ |bfVar#35| (CONS (CAR (SETQ |r| |x|)) |bfVar#35|))))
                 (SETQ |x| (CDR |x|))
                 (SETQ |i| (+ |i| 1))))
              NIL |a| 1)
             (|splitIntoBlocksOf200| (CDR |r|))))))))

; evalForm(op,opName,argl,mmS) ==
;   -- applies the first applicable function
;
;   for mm in mmS until form repeat
;     [sig,fun,cond]:= mm
;     (CAR sig) = 'interpOnly => form := CAR sig
;     #argl ~= #CDDR sig => 'skip ---> RDJ 6/95
;     form:=
;       $genValue or null cond =>
;         [getArgValue2(x,t,sideEffectedArg?(t,sig,opName),opName) or return NIL
;          for x in argl for t in CDDR sig]
;       [getArgValueComp2(x,t,c,sideEffectedArg?(t,sig,opName),opName) or return NIL
;         for x in argl for t in CDDR sig for c in cond]
;     form or null argl =>
;       dc:= CAR sig
;       form :=
;         dc='local => --[fun,:form]
;           atom fun =>
;             fun in $localVars => ['SPADCALL,:form,fun]
;             [fun,:form,NIL]
;           ['SPADCALL,:form,fun]
;         dc is ["__FreeFunction__",:freeFun] =>
;           ['SPADCALL,:form,freeFun]
;         fun is ['XLAM,xargs,:xbody] =>
;           rec :=  first form
;           xbody is [['RECORDELT,.,ind,len]] =>
;             optRECORDELT([CAAR xbody,rec,ind,len])
;           xbody is [['SETRECORDELT,.,ind,len,.]] =>
;             optSETRECORDELT([CAAR xbody,rec,ind,len,CADDR form])
;           xbody is [['RECORDCOPY,.,len]] =>
;             optRECORDCOPY([CAAR xbody,rec,len])
;           ['FUNCALL,['function , ['LAMBDA,xargs,:xbody]],:TAKE(#xargs, form)]
;         dcVector := evalDomain dc
;         fun0 := NRTcompileEvalForm(opName,fun,dcVector)
;         null fun0 => throwKeyedMsg("S2IE0008",[opName])
;         [bpi,:domain] := fun0
;         EQ(bpi,function Undef) =>
;          sayKeyedMsg("S2IE0009",[opName,formatSignature CDR sig,CAR sig])
;          NIL
;         if $NRTmonitorIfTrue = true then
;           sayBrightlyNT ['"Applying ",first fun0,'" to:"]
;           pp [devaluateDeeply x for x in form]
;         _$:fluid := domain
;         ['SPADCALL, :form, fun0]
;   not form => nil
; --  not form => throwKeyedMsg("S2IE0008",[opName])
;   form='interpOnly => rewriteMap(op,opName,argl)
;   targetType := CADR sig
;   if CONTAINED('_#,targetType) then targetType := NRTtypeHack targetType
;   evalFormMkValue(op,form,targetType)

(DEFUN |evalForm| (|op| |opName| |argl| |mmS|)
  (PROG ($ |targetType| |domain| |bpi| |fun0| |dcVector| |ISTMP#5| |len|
         |ISTMP#4| |ind| |ISTMP#3| |ISTMP#2| |rec| |xbody| |xargs| |ISTMP#1|
         |freeFun| |dc| |form| |cond| |fun| |sig|)
    (DECLARE (SPECIAL $))
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#36| |mm| |bfVar#37|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#36|) (PROGN (SETQ |mm| (CAR |bfVar#36|)) NIL)
                |bfVar#37|)
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |sig| (CAR |mm|))
             (SETQ |fun| (CADR . #2=(|mm|)))
             (SETQ |cond| (CADDR . #2#))
             (COND ((EQ (CAR |sig|) '|interpOnly|) (SETQ |form| (CAR |sig|)))
                   ((NOT (EQL (LENGTH |argl|) (LENGTH (CDDR |sig|)))) '|skip|)
                   (#1#
                    (PROGN
                     (SETQ |form|
                             (COND
                              ((OR |$genValue| (NULL |cond|))
                               ((LAMBDA
                                    (|bfVar#40| |bfVar#38| |x| |bfVar#39| |t|)
                                  (LOOP
                                   (COND
                                    ((OR (ATOM |bfVar#38|)
                                         (PROGN
                                          (SETQ |x| (CAR |bfVar#38|))
                                          NIL)
                                         (ATOM |bfVar#39|)
                                         (PROGN
                                          (SETQ |t| (CAR |bfVar#39|))
                                          NIL))
                                     (RETURN (NREVERSE |bfVar#40|)))
                                    (#1#
                                     (SETQ |bfVar#40|
                                             (CONS
                                              (OR
                                               (|getArgValue2| |x| |t|
                                                (|sideEffectedArg?| |t| |sig|
                                                 |opName|)
                                                |opName|)
                                               (RETURN NIL))
                                              |bfVar#40|))))
                                   (SETQ |bfVar#38| (CDR |bfVar#38|))
                                   (SETQ |bfVar#39| (CDR |bfVar#39|))))
                                NIL |argl| NIL (CDDR |sig|) NIL))
                              (#1#
                               ((LAMBDA
                                    (|bfVar#44| |bfVar#41| |x| |bfVar#42| |t|
                                     |bfVar#43| |c|)
                                  (LOOP
                                   (COND
                                    ((OR (ATOM |bfVar#41|)
                                         (PROGN
                                          (SETQ |x| (CAR |bfVar#41|))
                                          NIL)
                                         (ATOM |bfVar#42|)
                                         (PROGN
                                          (SETQ |t| (CAR |bfVar#42|))
                                          NIL)
                                         (ATOM |bfVar#43|)
                                         (PROGN
                                          (SETQ |c| (CAR |bfVar#43|))
                                          NIL))
                                     (RETURN (NREVERSE |bfVar#44|)))
                                    (#1#
                                     (SETQ |bfVar#44|
                                             (CONS
                                              (OR
                                               (|getArgValueComp2| |x| |t| |c|
                                                (|sideEffectedArg?| |t| |sig|
                                                 |opName|)
                                                |opName|)
                                               (RETURN NIL))
                                              |bfVar#44|))))
                                   (SETQ |bfVar#41| (CDR |bfVar#41|))
                                   (SETQ |bfVar#42| (CDR |bfVar#42|))
                                   (SETQ |bfVar#43| (CDR |bfVar#43|))))
                                NIL |argl| NIL (CDDR |sig|) NIL |cond| NIL))))
                     (COND
                      ((OR |form| (NULL |argl|))
                       (PROGN
                        (SETQ |dc| (CAR |sig|))
                        (SETQ |form|
                                (COND
                                 ((EQ |dc| '|local|)
                                  (COND
                                   ((ATOM |fun|)
                                    (COND
                                     ((|member| |fun| |$localVars|)
                                      (CONS 'SPADCALL
                                            (APPEND |form| (CONS |fun| NIL))))
                                     (#1#
                                      (CONS |fun|
                                            (APPEND |form| (CONS NIL NIL))))))
                                   (#1#
                                    (CONS 'SPADCALL
                                          (APPEND |form| (CONS |fun| NIL))))))
                                 ((AND (CONSP |dc|)
                                       (EQ (CAR |dc|) '|_FreeFunction_|)
                                       (PROGN (SETQ |freeFun| (CDR |dc|)) #1#))
                                  (CONS 'SPADCALL
                                        (APPEND |form| (CONS |freeFun| NIL))))
                                 ((AND (CONSP |fun|) (EQ (CAR |fun|) 'XLAM)
                                       (PROGN
                                        (SETQ |ISTMP#1| (CDR |fun|))
                                        (AND (CONSP |ISTMP#1|)
                                             (PROGN
                                              (SETQ |xargs| (CAR |ISTMP#1|))
                                              (SETQ |xbody| (CDR |ISTMP#1|))
                                              #1#))))
                                  (PROGN
                                   (SETQ |rec| (CAR |form|))
                                   (COND
                                    ((AND (CONSP |xbody|)
                                          (EQ (CDR |xbody|) NIL)
                                          (PROGN
                                           (SETQ |ISTMP#1| (CAR |xbody|))
                                           (AND (CONSP |ISTMP#1|)
                                                (EQ (CAR |ISTMP#1|) 'RECORDELT)
                                                (PROGN
                                                 (SETQ |ISTMP#2|
                                                         (CDR |ISTMP#1|))
                                                 (AND (CONSP |ISTMP#2|)
                                                      (PROGN
                                                       (SETQ |ISTMP#3|
                                                               (CDR |ISTMP#2|))
                                                       (AND (CONSP |ISTMP#3|)
                                                            (PROGN
                                                             (SETQ |ind|
                                                                     (CAR
                                                                      |ISTMP#3|))
                                                             (SETQ |ISTMP#4|
                                                                     (CDR
                                                                      |ISTMP#3|))
                                                             (AND
                                                              (CONSP |ISTMP#4|)
                                                              (EQ
                                                               (CDR |ISTMP#4|)
                                                               NIL)
                                                              (PROGN
                                                               (SETQ |len|
                                                                       (CAR
                                                                        |ISTMP#4|))
                                                               #1#))))))))))
                                     (|optRECORDELT|
                                      (LIST (CAAR |xbody|) |rec| |ind| |len|)))
                                    ((AND (CONSP |xbody|)
                                          (EQ (CDR |xbody|) NIL)
                                          (PROGN
                                           (SETQ |ISTMP#1| (CAR |xbody|))
                                           (AND (CONSP |ISTMP#1|)
                                                (EQ (CAR |ISTMP#1|)
                                                    'SETRECORDELT)
                                                (PROGN
                                                 (SETQ |ISTMP#2|
                                                         (CDR |ISTMP#1|))
                                                 (AND (CONSP |ISTMP#2|)
                                                      (PROGN
                                                       (SETQ |ISTMP#3|
                                                               (CDR |ISTMP#2|))
                                                       (AND (CONSP |ISTMP#3|)
                                                            (PROGN
                                                             (SETQ |ind|
                                                                     (CAR
                                                                      |ISTMP#3|))
                                                             (SETQ |ISTMP#4|
                                                                     (CDR
                                                                      |ISTMP#3|))
                                                             (AND
                                                              (CONSP |ISTMP#4|)
                                                              (PROGN
                                                               (SETQ |len|
                                                                       (CAR
                                                                        |ISTMP#4|))
                                                               (SETQ |ISTMP#5|
                                                                       (CDR
                                                                        |ISTMP#4|))
                                                               (AND
                                                                (CONSP
                                                                 |ISTMP#5|)
                                                                (EQ
                                                                 (CDR
                                                                  |ISTMP#5|)
                                                                 NIL))))))))))))
                                     (|optSETRECORDELT|
                                      (LIST (CAAR |xbody|) |rec| |ind| |len|
                                            (CADDR |form|))))
                                    ((AND (CONSP |xbody|)
                                          (EQ (CDR |xbody|) NIL)
                                          (PROGN
                                           (SETQ |ISTMP#1| (CAR |xbody|))
                                           (AND (CONSP |ISTMP#1|)
                                                (EQ (CAR |ISTMP#1|)
                                                    'RECORDCOPY)
                                                (PROGN
                                                 (SETQ |ISTMP#2|
                                                         (CDR |ISTMP#1|))
                                                 (AND (CONSP |ISTMP#2|)
                                                      (PROGN
                                                       (SETQ |ISTMP#3|
                                                               (CDR |ISTMP#2|))
                                                       (AND (CONSP |ISTMP#3|)
                                                            (EQ (CDR |ISTMP#3|)
                                                                NIL)
                                                            (PROGN
                                                             (SETQ |len|
                                                                     (CAR
                                                                      |ISTMP#3|))
                                                             #1#))))))))
                                     (|optRECORDCOPY|
                                      (LIST (CAAR |xbody|) |rec| |len|)))
                                    (#1#
                                     (CONS 'FUNCALL
                                           (CONS
                                            (LIST '|function|
                                                  (CONS 'LAMBDA
                                                        (CONS |xargs|
                                                              |xbody|)))
                                            (TAKE (LENGTH |xargs|)
                                             |form|)))))))
                                 (#1#
                                  (PROGN
                                   (SETQ |dcVector| (|evalDomain| |dc|))
                                   (SETQ |fun0|
                                           (|NRTcompileEvalForm| |opName| |fun|
                                            |dcVector|))
                                   (COND
                                    ((NULL |fun0|)
                                     (|throwKeyedMsg| 'S2IE0008
                                      (LIST |opName|)))
                                    (#1#
                                     (PROGN
                                      (SETQ |bpi| (CAR |fun0|))
                                      (SETQ |domain| (CDR |fun0|))
                                      (COND
                                       ((EQ |bpi| #'|Undef|)
                                        (PROGN
                                         (|sayKeyedMsg| 'S2IE0009
                                          (LIST |opName|
                                                (|formatSignature| (CDR |sig|))
                                                (CAR |sig|)))
                                         NIL))
                                       (#1#
                                        (PROGN
                                         (COND
                                          ((EQUAL |$NRTmonitorIfTrue| T)
                                           (|sayBrightlyNT|
                                            (LIST "Applying " (CAR |fun0|)
                                                  " to:"))
                                           (|pp|
                                            ((LAMBDA
                                                 (|bfVar#46| |bfVar#45| |x|)
                                               (LOOP
                                                (COND
                                                 ((OR (ATOM |bfVar#45|)
                                                      (PROGN
                                                       (SETQ |x|
                                                               (CAR
                                                                |bfVar#45|))
                                                       NIL))
                                                  (RETURN
                                                   (NREVERSE |bfVar#46|)))
                                                 (#1#
                                                  (SETQ |bfVar#46|
                                                          (CONS
                                                           (|devaluateDeeply|
                                                            |x|)
                                                           |bfVar#46|))))
                                                (SETQ |bfVar#45|
                                                        (CDR |bfVar#45|))))
                                             NIL |form| NIL))))
                                         (SETQ $ |domain|)
                                         (CONS 'SPADCALL
                                               (APPEND |form|
                                                       (CONS |fun0|
                                                             NIL))))))))))))))))))))))
          (SETQ |bfVar#36| (CDR |bfVar#36|))
          (SETQ |bfVar#37| |form|)))
       |mmS| NIL NIL)
      (COND ((NULL |form|) NIL)
            ((EQ |form| '|interpOnly|) (|rewriteMap| |op| |opName| |argl|))
            (#1#
             (PROGN
              (SETQ |targetType| (CADR |sig|))
              (COND
               ((CONTAINED '|#| |targetType|)
                (SETQ |targetType| (|NRTtypeHack| |targetType|))))
              (|evalFormMkValue| |op| |form| |targetType|))))))))

; sideEffectedArg?(t,sig,opName) ==
;   opString := SYMBOL_-NAME opName
;   (opName ~= "setelt!") and (ELT(opString, #opString-1) ~= char '_!) => nil
;   dc := first sig
;   t = dc

(DEFUN |sideEffectedArg?| (|t| |sig| |opName|)
  (PROG (|opString| |dc|)
    (RETURN
     (PROGN
      (SETQ |opString| (SYMBOL-NAME |opName|))
      (COND
       ((AND (NOT (EQ |opName| '|setelt!|))
             (NOT
              (EQUAL (ELT |opString| (- (LENGTH |opString|) 1)) (|char| '!))))
        NIL)
       ('T (PROGN (SETQ |dc| (CAR |sig|)) (EQUAL |t| |dc|))))))))

; getArgValue(a, t) ==
;   atom a and not VECP a =>
;     t' := coerceOrRetract(getBasicObject a,t)
;     t' and wrapped2Quote objVal t'
;   v := getArgValue1(a, t) => v
;   alt := altTypeOf(objMode getValue a, a, nil) =>
;     t' := coerceInt(getValue a, alt)
;     t' := coerceOrRetract(t',t)
;     t' and wrapped2Quote objVal t'
;   nil

(DEFUN |getArgValue| (|a| |t|)
  (PROG (|t'| |v| |alt|)
    (RETURN
     (COND
      ((AND (ATOM |a|) (NULL (VECP |a|)))
       (PROGN
        (SETQ |t'| (|coerceOrRetract| (|getBasicObject| |a|) |t|))
        (AND |t'| (|wrapped2Quote| (|objVal| |t'|)))))
      ((SETQ |v| (|getArgValue1| |a| |t|)) |v|)
      ((SETQ |alt| (|altTypeOf| (|objMode| (|getValue| |a|)) |a| NIL))
       (PROGN
        (SETQ |t'| (|coerceInt| (|getValue| |a|) |alt|))
        (SETQ |t'| (|coerceOrRetract| |t'| |t|))
        (AND |t'| (|wrapped2Quote| (|objVal| |t'|)))))
      ('T NIL)))))

; getArgValue1(a,t) ==
;   -- creates a value for a, coercing to t
;   t' := getValue(a) =>
;     (m := getMode a) and (m is ['Mapping,:ml]) and (m = t) and
;       objValUnwrap(t') is ['SPADMAP, :.] =>
;         getMappingArgValue(a,t,m)
;     t' := coerceOrRetract(t',t)
;     t' and wrapped2Quote objVal t'
;   systemErrorHere '"getArgValue"

(DEFUN |getArgValue1| (|a| |t|)
  (PROG (|t'| |m| |ml| |ISTMP#1|)
    (RETURN
     (COND
      ((SETQ |t'| (|getValue| |a|))
       (COND
        ((AND (SETQ |m| (|getMode| |a|)) (CONSP |m|) (EQ (CAR |m|) '|Mapping|)
              (PROGN (SETQ |ml| (CDR |m|)) #1='T) (EQUAL |m| |t|)
              (PROGN
               (SETQ |ISTMP#1| (|objValUnwrap| |t'|))
               (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADMAP))))
         (|getMappingArgValue| |a| |t| |m|))
        (#1#
         (PROGN
          (SETQ |t'| (|coerceOrRetract| |t'| |t|))
          (AND |t'| (|wrapped2Quote| (|objVal| |t'|)))))))
      (#1# (|systemErrorHere| "getArgValue"))))))

; getArgValue2(a,t,se?,opName) ==
;   se? and (objMode(getValue a) ~= t) =>
;     throwKeyedMsg("S2IE0013", [opName, objMode(getValue a), t])
;   getArgValue(a,t)

(DEFUN |getArgValue2| (|a| |t| |se?| |opName|)
  (PROG ()
    (RETURN
     (COND
      ((AND |se?| (NOT (EQUAL (|objMode| (|getValue| |a|)) |t|)))
       (|throwKeyedMsg| 'S2IE0013
        (LIST |opName| (|objMode| (|getValue| |a|)) |t|)))
      ('T (|getArgValue| |a| |t|))))))

; getArgValueOrThrow(x, type) ==
;   getArgValue(x,type) or throwKeyedMsg("S2IC0007",[type])

(DEFUN |getArgValueOrThrow| (|x| |type|)
  (PROG ()
    (RETURN
     (OR (|getArgValue| |x| |type|)
         (|throwKeyedMsg| 'S2IC0007 (LIST |type|))))))

; getMappingArgValue(a,t,m is ['Mapping,:ml]) ==
;   (una := getUnname a) in $localVars =>
;     $genValue =>
;       name := get(una,'name,$env)
;       a.0 := name
;       mmS := selectLocalMms(a,name,rest ml, nil)
;       or/[mm for mm in mmS |
;         (mm is [[., :ml1],oldName,:.] and ml=ml1)] =>
;             MKQ [COERCE(oldName, 'FUNCTION)]
;       NIL
;     una
;   mmS := selectLocalMms(a,una,rest ml, nil)
;   or/[mm for mm in mmS |
;     (mm is [[., :ml1],oldName,:.] and ml=ml1)] =>
;         MKQ [COERCE(oldName, 'FUNCTION)]
;   NIL

(DEFUN |getMappingArgValue| (|a| |t| |m|)
  (PROG (|ml| |una| |name| |mmS| |ISTMP#1| |ml1| |ISTMP#2| |oldName|)
    (RETURN
     (PROGN
      (SETQ |ml| (CDR |m|))
      (COND
       ((|member| (SETQ |una| (|getUnname| |a|)) |$localVars|)
        (COND
         (|$genValue|
          (PROGN
           (SETQ |name| (|get| |una| '|name| |$env|))
           (SETF (ELT |a| 0) |name|)
           (SETQ |mmS| (|selectLocalMms| |a| |name| (CDR |ml|) NIL))
           (COND
            (((LAMBDA (|bfVar#48| |bfVar#47| |mm|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#47|)
                       (PROGN (SETQ |mm| (CAR |bfVar#47|)) NIL))
                   (RETURN |bfVar#48|))
                  (#1='T
                   (AND (CONSP |mm|)
                        (PROGN
                         (SETQ |ISTMP#1| (CAR |mm|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN (SETQ |ml1| (CDR |ISTMP#1|)) #1#)))
                        (PROGN
                         (SETQ |ISTMP#2| (CDR |mm|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN (SETQ |oldName| (CAR |ISTMP#2|)) #1#)))
                        (EQUAL |ml| |ml1|)
                        (PROGN
                         (SETQ |bfVar#48| |mm|)
                         (COND (|bfVar#48| (RETURN |bfVar#48|)))))))
                 (SETQ |bfVar#47| (CDR |bfVar#47|))))
              NIL |mmS| NIL)
             (MKQ (LIST (COERCE |oldName| 'FUNCTION))))
            (#1# NIL))))
         (#1# |una|)))
       (#1#
        (PROGN
         (SETQ |mmS| (|selectLocalMms| |a| |una| (CDR |ml|) NIL))
         (COND
          (((LAMBDA (|bfVar#50| |bfVar#49| |mm|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#49|)
                     (PROGN (SETQ |mm| (CAR |bfVar#49|)) NIL))
                 (RETURN |bfVar#50|))
                (#1#
                 (AND (CONSP |mm|)
                      (PROGN
                       (SETQ |ISTMP#1| (CAR |mm|))
                       (AND (CONSP |ISTMP#1|)
                            (PROGN (SETQ |ml1| (CDR |ISTMP#1|)) #1#)))
                      (PROGN
                       (SETQ |ISTMP#2| (CDR |mm|))
                       (AND (CONSP |ISTMP#2|)
                            (PROGN (SETQ |oldName| (CAR |ISTMP#2|)) #1#)))
                      (EQUAL |ml| |ml1|)
                      (PROGN
                       (SETQ |bfVar#50| |mm|)
                       (COND (|bfVar#50| (RETURN |bfVar#50|)))))))
               (SETQ |bfVar#49| (CDR |bfVar#49|))))
            NIL |mmS| NIL)
           (MKQ (LIST (COERCE |oldName| 'FUNCTION))))
          (#1# NIL)))))))))

; getArgValueComp2(arg, type, cond, se?, opName) ==
;   se? and (objMode(getValue arg) ~= type) =>
;     throwKeyedMsg("S2IE0013", [opName, objMode(getValue arg), type])
;   getArgValueComp(arg, type, cond)

(DEFUN |getArgValueComp2| (|arg| |type| |cond| |se?| |opName|)
  (PROG ()
    (RETURN
     (COND
      ((AND |se?| (NOT (EQUAL (|objMode| (|getValue| |arg|)) |type|)))
       (|throwKeyedMsg| 'S2IE0013
        (LIST |opName| (|objMode| (|getValue| |arg|)) |type|)))
      ('T (|getArgValueComp| |arg| |type| |cond|))))))

; getArgValueComp(arg,type,cond) ==
;   -- getArgValue for compiled case.  if there is a condition then
;   --  v must be data to verify that coerceInteractive succeeds.
;   v:= getArgValue(arg,type)
;   null v => nil
;   null cond => v
;   v is ['QUOTE,:.] or getBasicMode v => v
;   n := getUnnameIfCan arg
;   if num := isSharpVarWithNum n then
;     not $compilingMap => n := 'unknownVar
;     alias := get($mapName,'alias,$e)
;     n := alias.(num - 1)
;   keyedMsgCompFailure("S2IE0010",[n])

(DEFUN |getArgValueComp| (|arg| |type| |cond|)
  (PROG (|v| |n| |num| |alias|)
    (RETURN
     (PROGN
      (SETQ |v| (|getArgValue| |arg| |type|))
      (COND ((NULL |v|) NIL) ((NULL |cond|) |v|)
            ((OR (AND (CONSP |v|) (EQ (CAR |v|) 'QUOTE)) (|getBasicMode| |v|))
             |v|)
            (#1='T
             (PROGN
              (SETQ |n| (|getUnnameIfCan| |arg|))
              (COND
               ((SETQ |num| (|isSharpVarWithNum| |n|))
                (COND ((NULL |$compilingMap|) (SETQ |n| '|unknownVar|))
                      (#1#
                       (PROGN
                        (SETQ |alias| (|get| |$mapName| '|alias| |$e|))
                        (SETQ |n| (ELT |alias| (- |num| 1))))))))
              (|keyedMsgCompFailure| 'S2IE0010 (LIST |n|)))))))))

; evalFormMkValue(op,form,tm) ==
;   val:=
;     u:=
;       $genValue => wrap timedEVALFUN form
;       form
;     objNew(u,tm)
; --+
;   if $NRTmonitorIfTrue = true then
;     sayBrightlyNT ['"Value of ",op.0,'" ===> "]
;     pp unwrap u
;   putValue(op,val)
;   [tm]

(DEFUN |evalFormMkValue| (|op| |form| |tm|)
  (PROG (|u| |val|)
    (RETURN
     (PROGN
      (SETQ |val|
              (PROGN
               (SETQ |u|
                       (COND (|$genValue| (|wrap| (|timedEVALFUN| |form|)))
                             ('T |form|)))
               (|objNew| |u| |tm|)))
      (COND
       ((EQUAL |$NRTmonitorIfTrue| T)
        (|sayBrightlyNT| (LIST "Value of " (ELT |op| 0) " ===> "))
        (|pp| (|unwrap| |u|))))
      (|putValue| |op| |val|)
      (LIST |tm|)))))

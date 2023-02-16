
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($useParserSrcPos, NIL)

(DEFPARAMETER |$useParserSrcPos| NIL)

; DEFPARAMETER($transferParserSrcPos, NIL)

(DEFPARAMETER |$transferParserSrcPos| NIL)

; DEFCONST($failure, GENSYM())

(EVAL-WHEN (EVAL LOAD) (PROG () (RETURN (DEFCONST |$failure| (GENSYM)))))

; mkAtreeNode x ==
;   -- maker of attrib tree node
;   v := MAKE_VEC(5)
;   v.0 := x
;   v

(DEFUN |mkAtreeNode| (|x|)
  (PROG (|v|)
    (RETURN (PROGN (SETQ |v| (MAKE_VEC 5)) (SETF (ELT |v| 0) |x|) |v|))))

; mkAtree x ==
;   -- maker of attrib tree from parser form
;   mkAtree1 mkAtreeExpandMacros x

(DEFUN |mkAtree| (|x|)
  (PROG () (RETURN (|mkAtree1| (|mkAtreeExpandMacros| |x|)))))

; mkAtreeWithSrcPos(form, posnForm) ==
;     posnForm and $useParserSrcPos => pf2Atree(posnForm)
;     transferSrcPosInfo(posnForm, mkAtree form)

(DEFUN |mkAtreeWithSrcPos| (|form| |posnForm|)
  (PROG ()
    (RETURN
     (COND ((AND |posnForm| |$useParserSrcPos|) (|pf2Atree| |posnForm|))
           ('T (|transferSrcPosInfo| |posnForm| (|mkAtree| |form|)))))))

; mkAtree1WithSrcPos(form, posnForm) ==
;   transferSrcPosInfo(posnForm, mkAtree1 form)

(DEFUN |mkAtree1WithSrcPos| (|form| |posnForm|)
  (PROG () (RETURN (|transferSrcPosInfo| |posnForm| (|mkAtree1| |form|)))))

; mkAtreeNodeWithSrcPos(form, posnForm) ==
;   transferSrcPosInfo(posnForm, mkAtreeNode form)

(DEFUN |mkAtreeNodeWithSrcPos| (|form| |posnForm|)
  (PROG () (RETURN (|transferSrcPosInfo| |posnForm| (|mkAtreeNode| |form|)))))

; transferSrcPosInfo(pf, atree) ==
;     not (pf and $transferParserSrcPos) => atree
;     pos := pfPosOrNopos(pf)
;     pfNoPosition?(pos) => atree
;
;     -- following is a hack because parser code for getting filename
;     -- seems wrong.
;     fn := lnPlaceOfOrigin poGetLineObject(pos)
;     if NULL fn or fn = '"strings" then fn := '"console"
;
;     putSrcPos(atree, fn, pfSourceText(pf), pfLinePosn(pos), pfCharPosn(pos))
;     atree

(DEFUN |transferSrcPosInfo| (|pf| |atree|)
  (PROG (|pos| |fn|)
    (RETURN
     (COND ((NULL (AND |pf| |$transferParserSrcPos|)) |atree|)
           (#1='T
            (PROGN
             (SETQ |pos| (|pfPosOrNopos| |pf|))
             (COND ((|pfNoPosition?| |pos|) |atree|)
                   (#1#
                    (PROGN
                     (SETQ |fn| (|lnPlaceOfOrigin| (|poGetLineObject| |pos|)))
                     (COND
                      ((OR (NULL |fn|) (EQUAL |fn| "strings"))
                       (SETQ |fn| "console")))
                     (|putSrcPos| |atree| |fn| (|pfSourceText| |pf|)
                      (|pfLinePosn| |pos|) (|pfCharPosn| |pos|))
                     |atree|)))))))))

; mkAtreeExpandMacros x ==
;   -- handle macro expansion. if the macros have args we require that
;   -- we match the correct number of args
;   if x isnt ['MDEF,:.] and x isnt ['DEF,['macro,:.],:.] then
;     atom x and (m := isInterpMacro x) =>
;       [args,:body] := m
;       args => 'doNothing
;       x := body
;     x is [op,:argl] =>
;       op = 'QUOTE => 'doNothing
;       op = "where" and argl is [before, after] =>
;         -- in a where clause, what follows "where" (the "after" parm
;         -- above) might be a local macro, so do not expand the "before"
;         -- part yet
;         x := [op,before,mkAtreeExpandMacros after]
;       argl := [mkAtreeExpandMacros a for a in argl]
;       (m := isInterpMacro op) =>
;         [args,:body] := m
;         #args = #argl =>
;           sl := [[a,:s] for a in args for s in argl]
;           x := sublisNQ(sl, body)
;         null args => x := [body,:argl]
;         x := [op,:argl]
;       x := [mkAtreeExpandMacros op,:argl]
;   x

(DEFUN |mkAtreeExpandMacros| (|x|)
  (PROG (|ISTMP#1| |ISTMP#2| |m| |args| |body| |op| |argl| |before| |after|
         |sl|)
    (RETURN
     (PROGN
      (COND
       ((AND (NOT (AND (CONSP |x|) (EQ (CAR |x|) 'MDEF)))
             (NOT
              (AND (CONSP |x|) (EQ (CAR |x|) 'DEF)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |x|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|)
                               (EQ (CAR |ISTMP#2|) '|macro|))))))))
        (COND
         ((AND (ATOM |x|) (SETQ |m| (|isInterpMacro| |x|)))
          (PROGN
           (SETQ |args| (CAR |m|))
           (SETQ |body| (CDR |m|))
           (COND (|args| '|doNothing|) (#1='T (SETQ |x| |body|)))))
         ((AND (CONSP |x|)
               (PROGN (SETQ |op| (CAR |x|)) (SETQ |argl| (CDR |x|)) #1#))
          (COND ((EQ |op| 'QUOTE) '|doNothing|)
                ((AND (EQ |op| '|where|) (CONSP |argl|)
                      (PROGN
                       (SETQ |before| (CAR |argl|))
                       (SETQ |ISTMP#1| (CDR |argl|))
                       (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                            (PROGN (SETQ |after| (CAR |ISTMP#1|)) #1#))))
                 (SETQ |x|
                         (LIST |op| |before| (|mkAtreeExpandMacros| |after|))))
                (#1#
                 (PROGN
                  (SETQ |argl|
                          ((LAMBDA (|bfVar#2| |bfVar#1| |a|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#1|)
                                    (PROGN (SETQ |a| (CAR |bfVar#1|)) NIL))
                                (RETURN (NREVERSE |bfVar#2|)))
                               (#1#
                                (SETQ |bfVar#2|
                                        (CONS (|mkAtreeExpandMacros| |a|)
                                              |bfVar#2|))))
                              (SETQ |bfVar#1| (CDR |bfVar#1|))))
                           NIL |argl| NIL))
                  (COND
                   ((SETQ |m| (|isInterpMacro| |op|))
                    (PROGN
                     (SETQ |args| (CAR |m|))
                     (SETQ |body| (CDR |m|))
                     (COND
                      ((EQL (LENGTH |args|) (LENGTH |argl|))
                       (PROGN
                        (SETQ |sl|
                                ((LAMBDA
                                     (|bfVar#5| |bfVar#3| |a| |bfVar#4| |s|)
                                   (LOOP
                                    (COND
                                     ((OR (ATOM |bfVar#3|)
                                          (PROGN
                                           (SETQ |a| (CAR |bfVar#3|))
                                           NIL)
                                          (ATOM |bfVar#4|)
                                          (PROGN
                                           (SETQ |s| (CAR |bfVar#4|))
                                           NIL))
                                      (RETURN (NREVERSE |bfVar#5|)))
                                     (#1#
                                      (SETQ |bfVar#5|
                                              (CONS (CONS |a| |s|)
                                                    |bfVar#5|))))
                                    (SETQ |bfVar#3| (CDR |bfVar#3|))
                                    (SETQ |bfVar#4| (CDR |bfVar#4|))))
                                 NIL |args| NIL |argl| NIL))
                        (SETQ |x| (|sublisNQ| |sl| |body|))))
                      ((NULL |args|) (SETQ |x| (CONS |body| |argl|)))
                      (#1# (SETQ |x| (CONS |op| |argl|))))))
                   (#1#
                    (SETQ |x|
                            (CONS (|mkAtreeExpandMacros| |op|)
                                  |argl|)))))))))))
      |x|))))

; mkAtree1 x ==
;   -- first special handler for making attrib tree
;   null x => throwKeyedMsg("S2IP0005",['"NIL"])
;   VECP x => x
;   atom x =>
;     x in '(noBranch noMapVal) => x
;     x in '(nil true false) => mkAtree2([x],x,NIL)
;     x = "/throwAway" =>
;       -- don't want to actually compute this
;       tree := mkAtree1 '(void)
;       putValue(tree,objNewWrap(voidValue(),$Void))
;       putModeSet(tree,[$Void])
;       tree
;     getBasicMode x =>
;       v := mkAtreeNode $immediateDataSymbol
;       putValue(v,getBasicObject x)
;       v
;     IDENTP x => mkAtreeNode x
;     keyedSystemError("S2II0002",[x])
;   x is [op,:argl] => mkAtree2(x,op,argl)
;   systemErrorHere '"mkAtree1"

(DEFUN |mkAtree1| (|x|)
  (PROG (|tree| |v| |op| |argl|)
    (RETURN
     (COND ((NULL |x|) (|throwKeyedMsg| 'S2IP0005 (LIST "NIL")))
           ((VECP |x|) |x|)
           ((ATOM |x|)
            (COND ((|member| |x| '(|noBranch| |noMapVal|)) |x|)
                  ((|member| |x| '(|nil| |true| |false|))
                   (|mkAtree2| (LIST |x|) |x| NIL))
                  ((EQ |x| '|/throwAway|)
                   (PROGN
                    (SETQ |tree| (|mkAtree1| '(|void|)))
                    (|putValue| |tree| (|objNewWrap| (|voidValue|) |$Void|))
                    (|putModeSet| |tree| (LIST |$Void|))
                    |tree|))
                  ((|getBasicMode| |x|)
                   (PROGN
                    (SETQ |v| (|mkAtreeNode| |$immediateDataSymbol|))
                    (|putValue| |v| (|getBasicObject| |x|))
                    |v|))
                  ((IDENTP |x|) (|mkAtreeNode| |x|))
                  (#1='T (|keyedSystemError| 'S2II0002 (LIST |x|)))))
           ((AND (CONSP |x|)
                 (PROGN (SETQ |op| (CAR |x|)) (SETQ |argl| (CDR |x|)) #1#))
            (|mkAtree2| |x| |op| |argl|))
           (#1# (|systemErrorHere| "mkAtree1"))))))

; mkAtree2(x,op,argl) ==
;   nargl := #argl
;   (op= '_-) and (nargl = 1) and (INTEGERP first argl) =>
;     mkAtree1(- first argl)
;   op='_: and argl is [y,z] => [mkAtreeNode 'Declare,:argl]
;   op='COLLECT => [mkAtreeNode op,:transformCollect argl]
;   op= 'break =>
;     argl is [.,val] =>
;       if val = '$NoValue then val := '(void)
;       [mkAtreeNode op,mkAtree1 val]
;     [mkAtreeNode op,mkAtree1 '(void)]
;   op= "return" =>
;     argl is [val] =>
;       if val = '$NoValue then val := '(void)
;       [mkAtreeNode op,mkAtree1 val]
;     [mkAtreeNode op,mkAtree1 '(void)]
;   op='exit => mkAtree1 CADR argl
;   op = 'QUOTE => [mkAtreeNode op,:argl]
;   op='SEGMENT =>
;     argl is [a] => [mkAtreeNode op, mkAtree1 a]
;     z :=
;       null argl.1 => nil
;       mkAtree1 argl.1
;     [mkAtreeNode op, mkAtree1 argl.0,z]
;   op in '(pretend is isnt) =>
;     [mkAtreeNode op,mkAtree1 first argl,:rest argl]
;   op =  '_:_: =>
;     [mkAtreeNode 'COERCE,mkAtree1 first argl,CADR argl]
;   x is ['_@, expr, type] =>
;     t := evaluateType unabbrev type
;     t = '(DoubleFloat) and expr is [['_$elt, '(Float), 'float], :args] =>
;         mkAtree1 [['_$elt, '(DoubleFloat), 'float], :args]
;     t = '(DoubleFloat) and INTEGERP expr =>
;         v := mkAtreeNode $immediateDataSymbol
;         putValue(v,getBasicObject float expr)
;         v
;     t = '(Float) and INTEGERP expr =>
;         mkAtree1 ["::", expr, t]
;     typeIsASmallInteger(t) and INTEGERP expr =>
;         mkAtree1 ["::", expr, t]
;     [mkAtreeNode 'TARGET,mkAtree1 expr, type]
;   (op = "case") and (nargl = 2)  =>
;     [mkAtreeNode "case", mkAtree1 first argl, unabbrev CADR argl]
;   op='REPEAT => [mkAtreeNode op,:transformREPEAT argl]
;   op='LET and argl is [['construct,:.],rhs] =>
;     [mkAtreeNode 'LET,first argl,mkAtree1 rhs]
;   op='LET and argl is [['_:,a,.],rhs] =>
;     mkAtree1 ['SEQ,first argl,['LET,a,rhs]]
;   op is ['_$elt,D,op1] =>
;     op1 is '_= =>
;       a' := [mkAtreeNode '_=,:[mkAtree1 arg for arg in argl]]
;       [mkAtreeNode 'Dollar,D,a']
;     [mkAtreeNode 'Dollar,D,mkAtree1 [op1,:argl]]
;   op='_$elt =>
;     argl is [D,a] =>
;       INTEGERP a =>
;         a = 0 => mkAtree1 [['_$elt,D,'Zero]]
;         a = 1 => mkAtree1 [['_$elt,D,'One]]
;         t := evaluateType unabbrev [D]
;         typeIsASmallInteger(t) and SINTP a =>
;             v := mkAtreeNode $immediateDataSymbol
;             putValue(v,mkObjWrap(a, t))
;             v
;         mkAtree1 ["*",a,[['_$elt,D,'One]]]
;       [mkAtreeNode 'Dollar,D,mkAtree1 a]
;     keyedSystemError("S2II0003",['"$",argl,
;       '"not qualifying an operator"])
;   mkAtree3(x,op,argl)

(DEFUN |mkAtree2| (|x| |op| |argl|)
  (PROG (|nargl| |y| |ISTMP#1| |z| |val| |a| |expr| |ISTMP#2| |type| |t|
         |ISTMP#3| |args| |v| |rhs| |ISTMP#4| D |op1| |a'|)
    (RETURN
     (PROGN
      (SETQ |nargl| (LENGTH |argl|))
      (COND
       ((AND (EQ |op| '-) (EQL |nargl| 1) (INTEGERP (CAR |argl|)))
        (|mkAtree1| (- (CAR |argl|))))
       ((AND (EQ |op| '|:|) (CONSP |argl|)
             (PROGN
              (SETQ |y| (CAR |argl|))
              (SETQ |ISTMP#1| (CDR |argl|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |z| (CAR |ISTMP#1|)) #1='T))))
        (CONS (|mkAtreeNode| '|Declare|) |argl|))
       ((EQ |op| 'COLLECT)
        (CONS (|mkAtreeNode| |op|) (|transformCollect| |argl|)))
       ((EQ |op| '|break|)
        (COND
         ((AND (CONSP |argl|)
               (PROGN
                (SETQ |ISTMP#1| (CDR |argl|))
                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                     (PROGN (SETQ |val| (CAR |ISTMP#1|)) #1#))))
          (PROGN
           (COND ((EQ |val| '|$NoValue|) (SETQ |val| '(|void|))))
           (LIST (|mkAtreeNode| |op|) (|mkAtree1| |val|))))
         (#1# (LIST (|mkAtreeNode| |op|) (|mkAtree1| '(|void|))))))
       ((EQ |op| '|return|)
        (COND
         ((AND (CONSP |argl|) (EQ (CDR |argl|) NIL)
               (PROGN (SETQ |val| (CAR |argl|)) #1#))
          (PROGN
           (COND ((EQ |val| '|$NoValue|) (SETQ |val| '(|void|))))
           (LIST (|mkAtreeNode| |op|) (|mkAtree1| |val|))))
         (#1# (LIST (|mkAtreeNode| |op|) (|mkAtree1| '(|void|))))))
       ((EQ |op| '|exit|) (|mkAtree1| (CADR |argl|)))
       ((EQ |op| 'QUOTE) (CONS (|mkAtreeNode| |op|) |argl|))
       ((EQ |op| 'SEGMENT)
        (COND
         ((AND (CONSP |argl|) (EQ (CDR |argl|) NIL)
               (PROGN (SETQ |a| (CAR |argl|)) #1#))
          (LIST (|mkAtreeNode| |op|) (|mkAtree1| |a|)))
         (#1#
          (PROGN
           (SETQ |z|
                   (COND ((NULL (ELT |argl| 1)) NIL)
                         (#1# (|mkAtree1| (ELT |argl| 1)))))
           (LIST (|mkAtreeNode| |op|) (|mkAtree1| (ELT |argl| 0)) |z|)))))
       ((|member| |op| '(|pretend| |is| |isnt|))
        (CONS (|mkAtreeNode| |op|)
              (CONS (|mkAtree1| (CAR |argl|)) (CDR |argl|))))
       ((EQ |op| '|::|)
        (LIST (|mkAtreeNode| 'COERCE) (|mkAtree1| (CAR |argl|)) (CADR |argl|)))
       ((AND (CONSP |x|) (EQ (CAR |x|) '@)
             (PROGN
              (SETQ |ISTMP#1| (CDR |x|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |expr| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |type| (CAR |ISTMP#2|)) #1#))))))
        (PROGN
         (SETQ |t| (|evaluateType| (|unabbrev| |type|)))
         (COND
          ((AND (EQUAL |t| '(|DoubleFloat|)) (CONSP |expr|)
                (PROGN
                 (SETQ |ISTMP#1| (CAR |expr|))
                 (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|$elt|)
                      (PROGN
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|)
                            (EQUAL (CAR |ISTMP#2|) '(|Float|))
                            (PROGN
                             (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                             (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                  (EQ (CAR |ISTMP#3|) '|float|)))))))
                (PROGN (SETQ |args| (CDR |expr|)) #1#))
           (|mkAtree1| (CONS (LIST '|$elt| '(|DoubleFloat|) '|float|) |args|)))
          ((AND (EQUAL |t| '(|DoubleFloat|)) (INTEGERP |expr|))
           (PROGN
            (SETQ |v| (|mkAtreeNode| |$immediateDataSymbol|))
            (|putValue| |v| (|getBasicObject| (|float| |expr|)))
            |v|))
          ((AND (EQUAL |t| '(|Float|)) (INTEGERP |expr|))
           (|mkAtree1| (LIST '|::| |expr| |t|)))
          ((AND (|typeIsASmallInteger| |t|) (INTEGERP |expr|))
           (|mkAtree1| (LIST '|::| |expr| |t|)))
          (#1# (LIST (|mkAtreeNode| 'TARGET) (|mkAtree1| |expr|) |type|)))))
       ((AND (EQ |op| '|case|) (EQL |nargl| 2))
        (LIST (|mkAtreeNode| '|case|) (|mkAtree1| (CAR |argl|))
              (|unabbrev| (CADR |argl|))))
       ((EQ |op| 'REPEAT)
        (CONS (|mkAtreeNode| |op|) (|transformREPEAT| |argl|)))
       ((AND (EQ |op| 'LET) (CONSP |argl|)
             (PROGN
              (SETQ |ISTMP#1| (CAR |argl|))
              (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|construct|)))
             (PROGN
              (SETQ |ISTMP#2| (CDR |argl|))
              (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                   (PROGN (SETQ |rhs| (CAR |ISTMP#2|)) #1#))))
        (LIST (|mkAtreeNode| 'LET) (CAR |argl|) (|mkAtree1| |rhs|)))
       ((AND (EQ |op| 'LET) (CONSP |argl|)
             (PROGN
              (SETQ |ISTMP#1| (CAR |argl|))
              (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|)
                   (PROGN
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |a| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)))))))
             (PROGN
              (SETQ |ISTMP#4| (CDR |argl|))
              (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                   (PROGN (SETQ |rhs| (CAR |ISTMP#4|)) #1#))))
        (|mkAtree1| (LIST 'SEQ (CAR |argl|) (LIST 'LET |a| |rhs|))))
       ((AND (CONSP |op|) (EQ (CAR |op|) '|$elt|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |op|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ D (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |op1| (CAR |ISTMP#2|)) #1#))))))
        (COND
         ((EQ |op1| '=)
          (PROGN
           (SETQ |a'|
                   (CONS (|mkAtreeNode| '=)
                         ((LAMBDA (|bfVar#7| |bfVar#6| |arg|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#6|)
                                   (PROGN (SETQ |arg| (CAR |bfVar#6|)) NIL))
                               (RETURN (NREVERSE |bfVar#7|)))
                              (#1#
                               (SETQ |bfVar#7|
                                       (CONS (|mkAtree1| |arg|) |bfVar#7|))))
                             (SETQ |bfVar#6| (CDR |bfVar#6|))))
                          NIL |argl| NIL)))
           (LIST (|mkAtreeNode| '|Dollar|) D |a'|)))
         (#1#
          (LIST (|mkAtreeNode| '|Dollar|) D
                (|mkAtree1| (CONS |op1| |argl|))))))
       ((EQ |op| '|$elt|)
        (COND
         ((AND (CONSP |argl|)
               (PROGN
                (SETQ D (CAR |argl|))
                (SETQ |ISTMP#1| (CDR |argl|))
                (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                     (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#))))
          (COND
           ((INTEGERP |a|)
            (COND ((EQL |a| 0) (|mkAtree1| (LIST (LIST '|$elt| D '|Zero|))))
                  ((EQL |a| 1) (|mkAtree1| (LIST (LIST '|$elt| D '|One|))))
                  (#1#
                   (PROGN
                    (SETQ |t| (|evaluateType| (|unabbrev| (LIST D))))
                    (COND
                     ((AND (|typeIsASmallInteger| |t|) (SINTP |a|))
                      (PROGN
                       (SETQ |v| (|mkAtreeNode| |$immediateDataSymbol|))
                       (|putValue| |v| (|mkObjWrap| |a| |t|))
                       |v|))
                     (#1#
                      (|mkAtree1|
                       (LIST '* |a| (LIST (LIST '|$elt| D '|One|))))))))))
           (#1# (LIST (|mkAtreeNode| '|Dollar|) D (|mkAtree1| |a|)))))
         (#1#
          (|keyedSystemError| 'S2II0003
           (LIST "$" |argl| "not qualifying an operator")))))
       (#1# (|mkAtree3| |x| |op| |argl|)))))))

; mkAtree3fn(a, b) ==
;     a and b =>
;          if a = b then a
;          else throwMessage '"   double declaration of parameter"
;     a or b

(DEFUN |mkAtree3fn| (|a| |b|)
  (PROG ()
    (RETURN
     (COND
      ((AND |a| |b|)
       (COND ((EQUAL |a| |b|) |a|)
             (#1='T (|throwMessage| "   double declaration of parameter"))))
      (#1# (OR |a| |b|))))))

; mkAtree3(x,op,argl) ==
;   op='REDUCE and argl is [op1,axis,body] =>
;     [mkAtreeNode op,axis,mkAtree1 op1,mkAtree1 body]
;   op='has => [mkAtreeNode op, :argl]
;   op='_| => [mkAtreeNode 'AlgExtension,:[mkAtree1 arg for arg in argl]]
;   op='_= => [mkAtreeNode 'equation,:[mkAtree1 arg for arg in argl]]
;   op='not and argl is [["=",lhs,rhs]] =>
;     [mkAtreeNode 'not,[mkAtreeNode "=",mkAtree1 lhs,mkAtree1 rhs]]
;   op = "in" and argl is [var, ['SEGMENT, lb, ul]] =>
;     upTest:=
;       null ul => NIL
;       mkLessOrEqual(var,ul)
;     lowTest:=mkLessOrEqual(lb,var)
;     z :=
;       ul => ['and,lowTest,upTest]
;       lowTest
;     mkAtree1 z
;   x is ['IF,p,'noBranch,a] => mkAtree1 ['IF,['not,p],a,'noBranch]
;   x is ['MDEF,sym,junk1,junk2,val] =>
;     -- new macros look like  macro f ==  or macro f(x) ===
;     -- so transform into that format
;     mkAtree1 ['DEF,['macro,sym],junk1,junk2,val]
;   x is ["+->",funargs,funbody] =>
;     if funbody is [":",body,type] then
;       types := [type]
;       funbody := body
;     else types := [NIL]
;     v := collectDefTypesAndPreds funargs
;     types := [:types,:v.1]
;     [mkAtreeNode 'ADEF,[v.0,types,[NIL for a in types],funbody],
;       if v.2 then v.2 else true, false]
;   x is ['ADEF,arg,:r] =>
;     r := mkAtreeValueOf r
;     v :=
;       null arg => VECTOR(NIL,NIL,NIL)
;       PAIRP arg and rest arg and first arg~= "|" =>
;         collectDefTypesAndPreds ['Tuple,:arg]
;       null rest arg => collectDefTypesAndPreds first arg
;       collectDefTypesAndPreds arg
;     [types,:r'] := r
;     at := [mkAtree3fn(x, y) for x in rest types for y in v.1]
;     r := [[first types,:at],:r']
;     [mkAtreeNode 'ADEF,[v.0,:r],if v.2 then v.2 else true,false]
;   x is ["where", before, after] =>
;     [mkAtreeNode "where", before, mkAtree1 after]
;   x is ['DEF,['macro,form],.,.,body] =>
;     [mkAtreeNode 'MDEF,form,body]
;   x is ['DEF,a,:r] =>
;     r := mkAtreeValueOf r
;     a is [op,:arg] =>
;       v :=
;         null arg => VECTOR(NIL,NIL,NIL)
;         PAIRP arg and rest arg and first arg~= "|" =>
;           collectDefTypesAndPreds ['Tuple,:arg]
;         null rest arg => collectDefTypesAndPreds first arg
;         collectDefTypesAndPreds arg
;       [types,:r'] := r
;       at := [mkAtree3fn(x, y) for x in rest types for y in v.1]
;       r := [[first types,:at],:r']
;       [mkAtreeNode 'DEF,[[op,:v.0],:r],if v.2 then v.2 else true,false]
;     [mkAtreeNode 'DEF,[a,:r],true,false]
; --x is ['when,y,pred] =>
; --  y isnt ['DEF,a,:r] =>
; --    keyedSystemError("S2II0003",['"when",y,'"improper argument form"])
; --  a is [op,p1,:pr] =>
; --    null pr => mkAtree1 ['DEF,[op,["|",p1,pred]],:r]
; --    mkAtree1 ['DEF,[op,["|",['Tuple,p1,:pr],pred]],:r]
; --  [mkAtreeNode 'DEF, rest y, pred, false]
; --x is ['otherwise,u] =>
; --  throwMessage '"   otherwise is no longer supported."
;   z :=
;     getBasicMode op =>
;       v := mkAtreeNode $immediateDataSymbol
;       putValue(v,getBasicObject op)
;       v
;     atom op => mkAtreeNode op
;     mkAtree1 op
;   [z,:[mkAtree1 y for y in argl]]

(DEFUN |mkAtree3| (|x| |op| |argl|)
  (PROG (|op1| |ISTMP#1| |axis| |ISTMP#2| |body| |lhs| |ISTMP#3| |rhs| |var|
         |lb| |ISTMP#4| |ul| |upTest| |lowTest| |z| |p| |a| |sym| |junk1|
         |junk2| |val| |funargs| |funbody| |type| |types| |v| |arg| |r| |r'|
         |at| |before| |after| |form| |ISTMP#5| |ISTMP#6|)
    (RETURN
     (COND
      ((AND (EQ |op| 'REDUCE) (CONSP |argl|)
            (PROGN
             (SETQ |op1| (CAR |argl|))
             (SETQ |ISTMP#1| (CDR |argl|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |axis| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |body| (CAR |ISTMP#2|)) #1='T))))))
       (LIST (|mkAtreeNode| |op|) |axis| (|mkAtree1| |op1|)
             (|mkAtree1| |body|)))
      ((EQ |op| '|has|) (CONS (|mkAtreeNode| |op|) |argl|))
      ((EQ |op| '|\||)
       (CONS (|mkAtreeNode| '|AlgExtension|)
             ((LAMBDA (|bfVar#9| |bfVar#8| |arg|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#8|)
                       (PROGN (SETQ |arg| (CAR |bfVar#8|)) NIL))
                   (RETURN (NREVERSE |bfVar#9|)))
                  (#1# (SETQ |bfVar#9| (CONS (|mkAtree1| |arg|) |bfVar#9|))))
                 (SETQ |bfVar#8| (CDR |bfVar#8|))))
              NIL |argl| NIL)))
      ((EQ |op| '=)
       (CONS (|mkAtreeNode| '|equation|)
             ((LAMBDA (|bfVar#11| |bfVar#10| |arg|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#10|)
                       (PROGN (SETQ |arg| (CAR |bfVar#10|)) NIL))
                   (RETURN (NREVERSE |bfVar#11|)))
                  (#1# (SETQ |bfVar#11| (CONS (|mkAtree1| |arg|) |bfVar#11|))))
                 (SETQ |bfVar#10| (CDR |bfVar#10|))))
              NIL |argl| NIL)))
      ((AND (EQ |op| '|not|) (CONSP |argl|) (EQ (CDR |argl|) NIL)
            (PROGN
             (SETQ |ISTMP#1| (CAR |argl|))
             (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '=)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |lhs| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |rhs| (CAR |ISTMP#3|)) #1#))))))))
       (LIST (|mkAtreeNode| '|not|)
             (LIST (|mkAtreeNode| '=) (|mkAtree1| |lhs|) (|mkAtree1| |rhs|))))
      ((AND (EQ |op| '|in|) (CONSP |argl|)
            (PROGN
             (SETQ |var| (CAR |argl|))
             (SETQ |ISTMP#1| (CDR |argl|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) 'SEGMENT)
                        (PROGN
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|)
                              (PROGN
                               (SETQ |lb| (CAR |ISTMP#3|))
                               (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                               (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                    (PROGN
                                     (SETQ |ul| (CAR |ISTMP#4|))
                                     #1#))))))))))
       (PROGN
        (SETQ |upTest|
                (COND ((NULL |ul|) NIL) (#1# (|mkLessOrEqual| |var| |ul|))))
        (SETQ |lowTest| (|mkLessOrEqual| |lb| |var|))
        (SETQ |z|
                (COND (|ul| (LIST '|and| |lowTest| |upTest|)) (#1# |lowTest|)))
        (|mkAtree1| |z|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |p| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|noBranch|)
                        (PROGN
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |a| (CAR |ISTMP#3|)) #1#))))))))
       (|mkAtree1| (LIST 'IF (LIST '|not| |p|) |a| '|noBranch|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'MDEF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |sym| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |junk1| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|)
                              (PROGN
                               (SETQ |junk2| (CAR |ISTMP#3|))
                               (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                               (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                    (PROGN
                                     (SETQ |val| (CAR |ISTMP#4|))
                                     #1#))))))))))
       (|mkAtree1| (LIST 'DEF (LIST '|macro| |sym|) |junk1| |junk2| |val|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) '+->)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |funargs| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |funbody| (CAR |ISTMP#2|)) #1#))))))
       (PROGN
        (COND
         ((AND (CONSP |funbody|) (EQ (CAR |funbody|) '|:|)
               (PROGN
                (SETQ |ISTMP#1| (CDR |funbody|))
                (AND (CONSP |ISTMP#1|)
                     (PROGN
                      (SETQ |body| (CAR |ISTMP#1|))
                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                      (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                           (PROGN (SETQ |type| (CAR |ISTMP#2|)) #1#))))))
          (SETQ |types| (LIST |type|)) (SETQ |funbody| |body|))
         (#1# (SETQ |types| (LIST NIL))))
        (SETQ |v| (|collectDefTypesAndPreds| |funargs|))
        (SETQ |types| (APPEND |types| (ELT |v| 1)))
        (LIST (|mkAtreeNode| 'ADEF)
              (LIST (ELT |v| 0) |types|
                    ((LAMBDA (|bfVar#13| |bfVar#12| |a|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#12|)
                              (PROGN (SETQ |a| (CAR |bfVar#12|)) NIL))
                          (RETURN (NREVERSE |bfVar#13|)))
                         (#1# (SETQ |bfVar#13| (CONS NIL |bfVar#13|))))
                        (SETQ |bfVar#12| (CDR |bfVar#12|))))
                     NIL |types| NIL)
                    |funbody|)
              (COND ((ELT |v| 2) (ELT |v| 2)) (#1# T)) NIL)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'ADEF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |arg| (CAR |ISTMP#1|))
                   (SETQ |r| (CDR |ISTMP#1|))
                   #1#))))
       (PROGN
        (SETQ |r| (|mkAtreeValueOf| |r|))
        (SETQ |v|
                (COND ((NULL |arg|) (VECTOR NIL NIL NIL))
                      ((AND (CONSP |arg|) (CDR |arg|)
                            (NOT (EQ (CAR |arg|) '|\||)))
                       (|collectDefTypesAndPreds| (CONS '|Tuple| |arg|)))
                      ((NULL (CDR |arg|))
                       (|collectDefTypesAndPreds| (CAR |arg|)))
                      (#1# (|collectDefTypesAndPreds| |arg|))))
        (SETQ |types| (CAR |r|))
        (SETQ |r'| (CDR |r|))
        (SETQ |at|
                ((LAMBDA (|bfVar#16| |bfVar#14| |x| |bfVar#15| |y|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#14|)
                          (PROGN (SETQ |x| (CAR |bfVar#14|)) NIL)
                          (ATOM |bfVar#15|)
                          (PROGN (SETQ |y| (CAR |bfVar#15|)) NIL))
                      (RETURN (NREVERSE |bfVar#16|)))
                     (#1#
                      (SETQ |bfVar#16|
                              (CONS (|mkAtree3fn| |x| |y|) |bfVar#16|))))
                    (SETQ |bfVar#14| (CDR |bfVar#14|))
                    (SETQ |bfVar#15| (CDR |bfVar#15|))))
                 NIL (CDR |types|) NIL (ELT |v| 1) NIL))
        (SETQ |r| (CONS (CONS (CAR |types|) |at|) |r'|))
        (LIST (|mkAtreeNode| 'ADEF) (CONS (ELT |v| 0) |r|)
              (COND ((ELT |v| 2) (ELT |v| 2)) (#1# T)) NIL)))
      ((AND (CONSP |x|) (EQ (CAR |x|) '|where|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |before| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |after| (CAR |ISTMP#2|)) #1#))))))
       (LIST (|mkAtreeNode| '|where|) |before| (|mkAtree1| |after|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'DEF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|macro|)
                        (PROGN
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |form| (CAR |ISTMP#3|)) #1#)))))
                  (PROGN
                   (SETQ |ISTMP#4| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#4|)
                        (PROGN
                         (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                         (AND (CONSP |ISTMP#5|)
                              (PROGN
                               (SETQ |ISTMP#6| (CDR |ISTMP#5|))
                               (AND (CONSP |ISTMP#6|) (EQ (CDR |ISTMP#6|) NIL)
                                    (PROGN
                                     (SETQ |body| (CAR |ISTMP#6|))
                                     #1#))))))))))
       (LIST (|mkAtreeNode| 'MDEF) |form| |body|))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'DEF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |r| (CDR |ISTMP#1|))
                   #1#))))
       (PROGN
        (SETQ |r| (|mkAtreeValueOf| |r|))
        (COND
         ((AND (CONSP |a|)
               (PROGN (SETQ |op| (CAR |a|)) (SETQ |arg| (CDR |a|)) #1#))
          (PROGN
           (SETQ |v|
                   (COND ((NULL |arg|) (VECTOR NIL NIL NIL))
                         ((AND (CONSP |arg|) (CDR |arg|)
                               (NOT (EQ (CAR |arg|) '|\||)))
                          (|collectDefTypesAndPreds| (CONS '|Tuple| |arg|)))
                         ((NULL (CDR |arg|))
                          (|collectDefTypesAndPreds| (CAR |arg|)))
                         (#1# (|collectDefTypesAndPreds| |arg|))))
           (SETQ |types| (CAR |r|))
           (SETQ |r'| (CDR |r|))
           (SETQ |at|
                   ((LAMBDA (|bfVar#19| |bfVar#17| |x| |bfVar#18| |y|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#17|)
                             (PROGN (SETQ |x| (CAR |bfVar#17|)) NIL)
                             (ATOM |bfVar#18|)
                             (PROGN (SETQ |y| (CAR |bfVar#18|)) NIL))
                         (RETURN (NREVERSE |bfVar#19|)))
                        (#1#
                         (SETQ |bfVar#19|
                                 (CONS (|mkAtree3fn| |x| |y|) |bfVar#19|))))
                       (SETQ |bfVar#17| (CDR |bfVar#17|))
                       (SETQ |bfVar#18| (CDR |bfVar#18|))))
                    NIL (CDR |types|) NIL (ELT |v| 1) NIL))
           (SETQ |r| (CONS (CONS (CAR |types|) |at|) |r'|))
           (LIST (|mkAtreeNode| 'DEF) (CONS (CONS |op| (ELT |v| 0)) |r|)
                 (COND ((ELT |v| 2) (ELT |v| 2)) (#1# T)) NIL)))
         (#1# (LIST (|mkAtreeNode| 'DEF) (CONS |a| |r|) T NIL)))))
      (#1#
       (PROGN
        (SETQ |z|
                (COND
                 ((|getBasicMode| |op|)
                  (PROGN
                   (SETQ |v| (|mkAtreeNode| |$immediateDataSymbol|))
                   (|putValue| |v| (|getBasicObject| |op|))
                   |v|))
                 ((ATOM |op|) (|mkAtreeNode| |op|)) (#1# (|mkAtree1| |op|))))
        (CONS |z|
              ((LAMBDA (|bfVar#21| |bfVar#20| |y|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#20|)
                        (PROGN (SETQ |y| (CAR |bfVar#20|)) NIL))
                    (RETURN (NREVERSE |bfVar#21|)))
                   (#1# (SETQ |bfVar#21| (CONS (|mkAtree1| |y|) |bfVar#21|))))
                  (SETQ |bfVar#20| (CDR |bfVar#20|))))
               NIL |argl| NIL))))))))

; addPred(old, new) ==
;     null new => old
;     null old => new
;     ['and, old, new]

(DEFUN |addPred| (|old| |new|)
  (PROG ()
    (RETURN
     (COND ((NULL |new|) |old|) ((NULL |old|) |new|)
           ('T (LIST '|and| |old| |new|))))))

; collectDefTypesAndPreds args ==
;   -- given an arglist to a DEF-like form, this function returns
;   -- a vector of three things:
;   --   slot 0: just the variables
;   --   slot 1: the type declarations on the variables
;   --   slot 2: a predicate for all arguments
;   pred := types := vars := NIL
;   junk :=
;     IDENTP args =>
;       types := [NIL]
;       vars  := [args]
;     args is [":",var,type] =>
;       types := [type]
;       var is ["|",var',p] =>
;         vars := [var']
;         pred := addPred(pred, p)
;       vars := [var]
;     args is ["|",var,p] =>
;       pred := addPred(pred,p)
;       var is [":",var',type] =>
;         types := [type]
;         vars := [var']
;       var is ['Tuple,:.] or var is ["|",:.] =>
;         v := collectDefTypesAndPreds var
;         vars  := [:vars,:v.0]
;         types := [:types,:v.1]
;         pred  := addPred(pred,v.2)
;       vars := [var]
;       types := [NIL]
;     args is ['Tuple,:args'] =>
;       for a in args' repeat
;         v := collectDefTypesAndPreds a
;         vars  := [:vars,first v.0]
;         types := [:types,first v.1]
;         pred  := addPred(pred,v.2)
;     types := [NIL]
;     vars  := [args]
;   VECTOR(vars,types,pred)

(DEFUN |collectDefTypesAndPreds| (|args|)
  (PROG (|vars| |types| |pred| |ISTMP#1| |var| |ISTMP#2| |type| |var'| |p| |v|
         |args'| |junk|)
    (RETURN
     (PROGN
      (SETQ |pred| (SETQ |types| (SETQ |vars| NIL)))
      (SETQ |junk|
              (COND
               ((IDENTP |args|)
                (PROGN (SETQ |types| (LIST NIL)) (SETQ |vars| (LIST |args|))))
               ((AND (CONSP |args|) (EQ (CAR |args|) '|:|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |args|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |var| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN
                                  (SETQ |type| (CAR |ISTMP#2|))
                                  #1='T))))))
                (PROGN
                 (SETQ |types| (LIST |type|))
                 (COND
                  ((AND (CONSP |var|) (EQ (CAR |var|) '|\||)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |var|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |var'| (CAR |ISTMP#1|))
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                    (PROGN (SETQ |p| (CAR |ISTMP#2|)) #1#))))))
                   (PROGN
                    (SETQ |vars| (LIST |var'|))
                    (SETQ |pred| (|addPred| |pred| |p|))))
                  (#1# (SETQ |vars| (LIST |var|))))))
               ((AND (CONSP |args|) (EQ (CAR |args|) '|\||)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |args|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |var| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN (SETQ |p| (CAR |ISTMP#2|)) #1#))))))
                (PROGN
                 (SETQ |pred| (|addPred| |pred| |p|))
                 (COND
                  ((AND (CONSP |var|) (EQ (CAR |var|) '|:|)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |var|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |var'| (CAR |ISTMP#1|))
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                    (PROGN
                                     (SETQ |type| (CAR |ISTMP#2|))
                                     #1#))))))
                   (PROGN
                    (SETQ |types| (LIST |type|))
                    (SETQ |vars| (LIST |var'|))))
                  ((OR (AND (CONSP |var|) (EQ (CAR |var|) '|Tuple|))
                       (AND (CONSP |var|) (EQ (CAR |var|) '|\||)))
                   (PROGN
                    (SETQ |v| (|collectDefTypesAndPreds| |var|))
                    (SETQ |vars| (APPEND |vars| (ELT |v| 0)))
                    (SETQ |types| (APPEND |types| (ELT |v| 1)))
                    (SETQ |pred| (|addPred| |pred| (ELT |v| 2)))))
                  (#1#
                   (PROGN
                    (SETQ |vars| (LIST |var|))
                    (SETQ |types| (LIST NIL)))))))
               ((AND (CONSP |args|) (EQ (CAR |args|) '|Tuple|)
                     (PROGN (SETQ |args'| (CDR |args|)) #1#))
                ((LAMBDA (|bfVar#22| |a|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#22|)
                          (PROGN (SETQ |a| (CAR |bfVar#22|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (PROGN
                       (SETQ |v| (|collectDefTypesAndPreds| |a|))
                       (SETQ |vars|
                               (APPEND |vars| (CONS (CAR (ELT |v| 0)) NIL)))
                       (SETQ |types|
                               (APPEND |types| (CONS (CAR (ELT |v| 1)) NIL)))
                       (SETQ |pred| (|addPred| |pred| (ELT |v| 2))))))
                    (SETQ |bfVar#22| (CDR |bfVar#22|))))
                 |args'| NIL))
               (#1#
                (PROGN
                 (SETQ |types| (LIST NIL))
                 (SETQ |vars| (LIST |args|))))))
      (VECTOR |vars| |types| |pred|)))))

; mkAtreeValueOf l ==
;   -- scans for ['valueOf,atom]
;   not CONTAINED('valueOf,l) => l
;   mkAtreeValueOf1 l

(DEFUN |mkAtreeValueOf| (|l|)
  (PROG ()
    (RETURN
     (COND ((NULL (CONTAINED '|valueOf| |l|)) |l|)
           ('T (|mkAtreeValueOf1| |l|))))))

; mkAtreeValueOf1 l ==
;   null l or atom l or null rest l => l
;   l is ['valueOf,u] and IDENTP u =>
;     v := mkAtreeNode $immediateDataSymbol
;     putValue(v,get(u,'value,$InteractiveFrame) or
;       objNewWrap(u,['Variable,u]))
;     v
;   [mkAtreeValueOf1 x for x in l]

(DEFUN |mkAtreeValueOf1| (|l|)
  (PROG (|ISTMP#1| |u| |v|)
    (RETURN
     (COND ((OR (NULL |l|) (ATOM |l|) (NULL (CDR |l|))) |l|)
           ((AND (CONSP |l|) (EQ (CAR |l|) '|valueOf|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |l|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |u| (CAR |ISTMP#1|)) #1='T)))
                 (IDENTP |u|))
            (PROGN
             (SETQ |v| (|mkAtreeNode| |$immediateDataSymbol|))
             (|putValue| |v|
              (OR (|get| |u| '|value| |$InteractiveFrame|)
                  (|objNewWrap| |u| (LIST '|Variable| |u|))))
             |v|))
           (#1#
            ((LAMBDA (|bfVar#24| |bfVar#23| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#23|)
                      (PROGN (SETQ |x| (CAR |bfVar#23|)) NIL))
                  (RETURN (NREVERSE |bfVar#24|)))
                 (#1#
                  (SETQ |bfVar#24| (CONS (|mkAtreeValueOf1| |x|) |bfVar#24|))))
                (SETQ |bfVar#23| (CDR |bfVar#23|))))
             NIL |l| NIL))))))

; mkLessOrEqual(lhs,rhs) == ['not,['_<,rhs,lhs]]

(DEFUN |mkLessOrEqual| (|lhs| |rhs|)
  (PROG () (RETURN (LIST '|not| (LIST '< |rhs| |lhs|)))))

; emptyAtree expr ==
;   -- remove mode, value, and misc. info from attrib tree
;   VECP expr =>
;     $immediateDataSymbol = expr.0 => nil
;     expr.1:= NIL
;     expr.2:= NIL
;     expr.3:= NIL
;     -- kill proplist too?
;   atom expr => nil
;   for e in expr repeat emptyAtree e

(DEFUN |emptyAtree| (|expr|)
  (PROG ()
    (RETURN
     (COND
      ((VECP |expr|)
       (COND ((EQUAL |$immediateDataSymbol| (ELT |expr| 0)) NIL)
             (#1='T
              (PROGN
               (SETF (ELT |expr| 1) NIL)
               (SETF (ELT |expr| 2) NIL)
               (SETF (ELT |expr| 3) NIL)))))
      ((ATOM |expr|) NIL)
      (#1#
       ((LAMBDA (|bfVar#25| |e|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#25|) (PROGN (SETQ |e| (CAR |bfVar#25|)) NIL))
             (RETURN NIL))
            (#1# (|emptyAtree| |e|)))
           (SETQ |bfVar#25| (CDR |bfVar#25|))))
        |expr| NIL))))))

; unVectorize body ==
;   -- transforms from an atree back into a tree
;   VECP body =>
;     name := getUnname body
;     name ~= $immediateDataSymbol => name
;     objValUnwrap getValue body
;   atom body => body
;   body is [op,:argl] =>
;     newOp:=unVectorize op
;     if newOp = 'SUCHTHAT then newOp := '_|
;     if newOp = 'COERCE then newOp := '_:_:
;     if newOp = 'Dollar then newOp := "$elt"
;     [newOp,:unVectorize argl]
;   systemErrorHere '"unVectorize"

(DEFUN |unVectorize| (|body|)
  (PROG (|name| |op| |argl| |newOp|)
    (RETURN
     (COND
      ((VECP |body|)
       (PROGN
        (SETQ |name| (|getUnname| |body|))
        (COND ((NOT (EQUAL |name| |$immediateDataSymbol|)) |name|)
              (#1='T (|objValUnwrap| (|getValue| |body|))))))
      ((ATOM |body|) |body|)
      ((AND (CONSP |body|)
            (PROGN (SETQ |op| (CAR |body|)) (SETQ |argl| (CDR |body|)) #1#))
       (PROGN
        (SETQ |newOp| (|unVectorize| |op|))
        (COND ((EQ |newOp| 'SUCHTHAT) (SETQ |newOp| '|\||)))
        (COND ((EQ |newOp| 'COERCE) (SETQ |newOp| '|::|)))
        (COND ((EQ |newOp| '|Dollar|) (SETQ |newOp| '|$elt|)))
        (CONS |newOp| (|unVectorize| |argl|))))
      (#1# (|systemErrorHere| "unVectorize"))))))

; putAtree(x,prop,val) ==
;   x is [op,:.] =>
;     -- only willing to add property if op is a vector
;     -- otherwise will be pushing to deeply into calling structure
;     if VECP op then putAtree(op,prop,val)
;     x
;   null VECP x => x     -- just ignore it
;   n := QLASSQ(prop,'((mode . 1) (value . 2) (modeSet . 3)))
;     => x.n := val
;   x.4 := insertShortAlist(prop,val,x.4)
;   x

(DEFUN |putAtree| (|x| |prop| |val|)
  (PROG (|op| |n|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T))
       (PROGN (COND ((VECP |op|) (|putAtree| |op| |prop| |val|))) |x|))
      ((NULL (VECP |x|)) |x|)
      ((SETQ |n| (QLASSQ |prop| '((|mode| . 1) (|value| . 2) (|modeSet| . 3))))
       (SETF (ELT |x| |n|) |val|))
      (#1#
       (PROGN
        (SETF (ELT |x| 4) (|insertShortAlist| |prop| |val| (ELT |x| 4)))
        |x|))))))

; getAtree(x,prop) ==
;   x is [op,:.] =>
;     -- only willing to get property if op is a vector
;     -- otherwise will be pushing to deeply into calling structure
;     VECP op => getAtree(op,prop)
;     NIL
;   null VECP x => NIL     -- just ignore it
;   n:= QLASSQ(prop,'((mode . 1) (value . 2) (modeSet . 3)))
;     => x.n
;   QLASSQ(prop,x.4)

(DEFUN |getAtree| (|x| |prop|)
  (PROG (|op| |n|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T))
       (COND ((VECP |op|) (|getAtree| |op| |prop|)) (#1# NIL)))
      ((NULL (VECP |x|)) NIL)
      ((SETQ |n| (QLASSQ |prop| '((|mode| . 1) (|value| . 2) (|modeSet| . 3))))
       (ELT |x| |n|))
      (#1# (QLASSQ |prop| (ELT |x| 4)))))))

; putTarget(x, targ) ==
;   -- want to put nil modes perhaps to clear old target
;   if targ = $EmptyMode then targ := nil
;   putAtree(x,'target,targ)

(DEFUN |putTarget| (|x| |targ|)
  (PROG ()
    (RETURN
     (PROGN
      (COND ((EQUAL |targ| |$EmptyMode|) (SETQ |targ| NIL)))
      (|putAtree| |x| '|target| |targ|)))))

; getTarget(x) == getAtree(x,'target)

(DEFUN |getTarget| (|x|) (PROG () (RETURN (|getAtree| |x| '|target|))))

; insertShortAlist(prop,val,al) ==
;   pair := ASSQ(prop,al) =>
;     RPLACD(pair,val)
;     al
;   [[prop,:val],:al]

(DEFUN |insertShortAlist| (|prop| |val| |al|)
  (PROG (|pair|)
    (RETURN
     (COND
      ((SETQ |pair| (ASSQ |prop| |al|)) (PROGN (RPLACD |pair| |val|) |al|))
      ('T (CONS (CONS |prop| |val|) |al|))))))

; transferPropsToNode(x,t) ==
;   propList := getProplist(x,$env)
;   QLASSQ('Led,propList) or QLASSQ('Nud,propList) => nil
;   node :=
;     VECP t => t
;     first t
;   for prop in '(mode localModemap value name generatedCode)
;     repeat transfer(x,node,prop)
;       where
;         transfer(x,node,prop) ==
;           u := get(x,prop,$env) => putAtree(node,prop,u)
;           (not (x in $localVars)) and (u := get(x,prop,$e)) =>
;             putAtree(node,prop,u)
;   if not getMode(t) and (am := get(x,'automode,$env)) then
;     putModeSet(t,[am])
;     putMode(t,am)
;   t

(DEFUN |transferPropsToNode| (|x| |t|)
  (PROG (|propList| |node| |am|)
    (RETURN
     (PROGN
      (SETQ |propList| (|getProplist| |x| |$env|))
      (COND ((OR (QLASSQ '|Led| |propList|) (QLASSQ '|Nud| |propList|)) NIL)
            (#1='T
             (PROGN
              (SETQ |node| (COND ((VECP |t|) |t|) (#1# (CAR |t|))))
              ((LAMBDA (|bfVar#26| |prop|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#26|)
                        (PROGN (SETQ |prop| (CAR |bfVar#26|)) NIL))
                    (RETURN NIL))
                   (#1# (|transferPropsToNode,transfer| |x| |node| |prop|)))
                  (SETQ |bfVar#26| (CDR |bfVar#26|))))
               '(|mode| |localModemap| |value| |name| |generatedCode|) NIL)
              (COND
               ((AND (NULL (|getMode| |t|))
                     (SETQ |am| (|get| |x| '|automode| |$env|)))
                (|putModeSet| |t| (LIST |am|)) (|putMode| |t| |am|)))
              |t|)))))))
(DEFUN |transferPropsToNode,transfer| (|x| |node| |prop|)
  (PROG (|u|)
    (RETURN
     (COND
      ((SETQ |u| (|get| |x| |prop| |$env|)) (|putAtree| |node| |prop| |u|))
      ((AND (NULL (|member| |x| |$localVars|))
            (SETQ |u| (|get| |x| |prop| |$e|)))
       (|putAtree| |node| |prop| |u|))))))

; isLeaf x == atom x     --may be a number or a vector

(DEFUN |isLeaf| (|x|) (PROG () (RETURN (ATOM |x|))))

; getMode x ==
;   x is [op,:.] => getMode op
;   VECP x => x.1
;   m := getBasicMode x => m
;   keyedSystemError("S2II0001",[x])

(DEFUN |getMode| (|x|)
  (PROG (|op| |m|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T)) (|getMode| |op|))
      ((VECP |x|) (ELT |x| 1)) ((SETQ |m| (|getBasicMode| |x|)) |m|)
      (#1# (|keyedSystemError| 'S2II0001 (LIST |x|)))))))

; putMode(x,y) ==
;   x is [op,:.] => putMode(op,y)
;   null VECP x => keyedSystemError("S2II0001",[x])
;   x.1 := y

(DEFUN |putMode| (|x| |y|)
  (PROG (|op|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T))
       (|putMode| |op| |y|))
      ((NULL (VECP |x|)) (|keyedSystemError| 'S2II0001 (LIST |x|)))
      (#1# (SETF (ELT |x| 1) |y|))))))

; getValue x ==
;   VECP x => x.2
;   atom x =>
;     t := getBasicObject x => t
;     keyedSystemError("S2II0001",[x])
;   getValue first x

(DEFUN |getValue| (|x|)
  (PROG (|t|)
    (RETURN
     (COND ((VECP |x|) (ELT |x| 2))
           ((ATOM |x|)
            (COND ((SETQ |t| (|getBasicObject| |x|)) |t|)
                  (#1='T (|keyedSystemError| 'S2II0001 (LIST |x|)))))
           (#1# (|getValue| (CAR |x|)))))))

; putValue(x,y) ==
;   x is [op,:.] => putValue(op,y)
;   null VECP x => keyedSystemError("S2II0001",[x])
;   x.2 := y

(DEFUN |putValue| (|x| |y|)
  (PROG (|op|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T))
       (|putValue| |op| |y|))
      ((NULL (VECP |x|)) (|keyedSystemError| 'S2II0001 (LIST |x|)))
      (#1# (SETF (ELT |x| 2) |y|))))))

; putValueValue(vec,val) ==
;   putValue(vec,val)
;   vec

(DEFUN |putValueValue| (|vec| |val|)
  (PROG () (RETURN (PROGN (|putValue| |vec| |val|) |vec|))))

; getUnnameIfCan x ==
;   VECP x => x.0
;   x is [op,:.] => getUnnameIfCan op
;   atom x => x
;   nil

(DEFUN |getUnnameIfCan| (|x|)
  (PROG (|op|)
    (RETURN
     (COND ((VECP |x|) (ELT |x| 0))
           ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T))
            (|getUnnameIfCan| |op|))
           ((ATOM |x|) |x|) (#1# NIL)))))

; getUnname x ==
;   x is [op,:.] => getUnname op
;   getUnname1 x

(DEFUN |getUnname| (|x|)
  (PROG (|op|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T))
       (|getUnname| |op|))
      (#1# (|getUnname1| |x|))))))

; getUnname1 x ==
;   VECP x => x.0
;   null atom x => keyedSystemError("S2II0001",[x])
;   x

(DEFUN |getUnname1| (|x|)
  (PROG ()
    (RETURN
     (COND ((VECP |x|) (ELT |x| 0))
           ((NULL (ATOM |x|)) (|keyedSystemError| 'S2II0001 (LIST |x|)))
           ('T |x|)))))

; computedMode t ==
;   getModeSet t is [m] => m
;   keyedSystemError("S2GE0016",['"computedMode",'"non-singleton modeset"])

(DEFUN |computedMode| (|t|)
  (PROG (|ISTMP#1| |m|)
    (RETURN
     (COND
      ((PROGN
        (SETQ |ISTMP#1| (|getModeSet| |t|))
        (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
             (PROGN (SETQ |m| (CAR |ISTMP#1|)) #1='T)))
       |m|)
      (#1#
       (|keyedSystemError| 'S2GE0016
        (LIST "computedMode" "non-singleton modeset")))))))

; putModeSet(x,y) ==
;   x is [op,:.] => putModeSet(op,y)
;   not VECP x => keyedSystemError("S2II0001",[x])
;   x.3 := y
;   y

(DEFUN |putModeSet| (|x| |y|)
  (PROG (|op|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T))
       (|putModeSet| |op| |y|))
      ((NULL (VECP |x|)) (|keyedSystemError| 'S2II0001 (LIST |x|)))
      (#1# (PROGN (SETF (ELT |x| 3) |y|) |y|))))))

; getModeOrFirstModeSetIfThere x ==
;   x is [op,:.] => getModeOrFirstModeSetIfThere op
;   VECP x =>
;     m := x.1 => m
;     val := x.2 => objMode val
;     y := x.aModeSet =>
;       (y = [$EmptyMode]) and ((m := getMode x) is ['Mapping,:.]) => m
;       first y
;     NIL
;   m := getBasicMode x => m
;   NIL

(DEFUN |getModeOrFirstModeSetIfThere| (|x|)
  (PROG (|op| |m| |val| |y| |ISTMP#1|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T))
       (|getModeOrFirstModeSetIfThere| |op|))
      ((VECP |x|)
       (COND ((SETQ |m| (ELT |x| 1)) |m|)
             ((SETQ |val| (ELT |x| 2)) (|objMode| |val|))
             ((SETQ |y| (ELT |x| 3))
              (COND
               ((AND (EQUAL |y| (LIST |$EmptyMode|))
                     (PROGN
                      (SETQ |ISTMP#1| (SETQ |m| (|getMode| |x|)))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|))))
                |m|)
               (#1# (CAR |y|))))
             (#1# NIL)))
      ((SETQ |m| (|getBasicMode| |x|)) |m|) (#1# NIL)))))

; getModeSet x ==
;   x and PAIRP x => getModeSet first x
;   VECP x =>
;     y:= x.aModeSet =>
;       (y = [$EmptyMode]) and ((m := getMode x) is ['Mapping,:.]) =>
;         [m]
;       y
;     keyedSystemError("S2GE0016",['"getModeSet",'"no mode set"])
;   m:= getBasicMode x => [m]
;   null atom x => getModeSet first x
;   keyedSystemError("S2GE0016",['"getModeSet",
;     '"not an attributed tree"])

(DEFUN |getModeSet| (|x|)
  (PROG (|y| |m| |ISTMP#1|)
    (RETURN
     (COND ((AND |x| (CONSP |x|)) (|getModeSet| (CAR |x|)))
           ((VECP |x|)
            (COND
             ((SETQ |y| (ELT |x| 3))
              (COND
               ((AND (EQUAL |y| (LIST |$EmptyMode|))
                     (PROGN
                      (SETQ |ISTMP#1| (SETQ |m| (|getMode| |x|)))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|))))
                (LIST |m|))
               (#1='T |y|)))
             (#1#
              (|keyedSystemError| 'S2GE0016
               (LIST "getModeSet" "no mode set")))))
           ((SETQ |m| (|getBasicMode| |x|)) (LIST |m|))
           ((NULL (ATOM |x|)) (|getModeSet| (CAR |x|)))
           (#1#
            (|keyedSystemError| 'S2GE0016
             (LIST "getModeSet" "not an attributed tree")))))))

; getModeSetUseSubdomain x ==
;   x and PAIRP x => getModeSetUseSubdomain first x
;   VECP(x) =>
;     -- don't play subdomain games with retracted args
;     getAtree(x,'retracted) => getModeSet x
;     y := x.aModeSet =>
;       (y = [$EmptyMode]) and ((m := getMode x) is ['Mapping,:.]) =>
;         [m]
;       val := getValue x
;       (x.0 = $immediateDataSymbol) and (y = [$Integer]) =>
;         val := objValUnwrap val
;         m := getBasicMode0(val,true)
;         x.2 := objNewWrap(val,m)
;         x.aModeSet := [m]
;         [m]
;       null val => y
;       isEqualOrSubDomain(objMode(val),$Integer) and
;         INTEGERP(f := objValUnwrap val) =>
;           [getBasicMode0(f,true)]
;       y
;     keyedSystemError("S2GE0016",
;       ['"getModeSetUseSubomain",'"no mode set"])
;   m := getBasicMode0(x,true) => [m]
;   null atom x => getModeSetUseSubdomain first x
;   keyedSystemError("S2GE0016",
;     ['"getModeSetUseSubomain",'"not an attributed tree"])

(DEFUN |getModeSetUseSubdomain| (|x|)
  (PROG (|y| |m| |ISTMP#1| |val| |f|)
    (RETURN
     (COND ((AND |x| (CONSP |x|)) (|getModeSetUseSubdomain| (CAR |x|)))
           ((VECP |x|)
            (COND ((|getAtree| |x| '|retracted|) (|getModeSet| |x|))
                  ((SETQ |y| (ELT |x| 3))
                   (COND
                    ((AND (EQUAL |y| (LIST |$EmptyMode|))
                          (PROGN
                           (SETQ |ISTMP#1| (SETQ |m| (|getMode| |x|)))
                           (AND (CONSP |ISTMP#1|)
                                (EQ (CAR |ISTMP#1|) '|Mapping|))))
                     (LIST |m|))
                    (#1='T
                     (PROGN
                      (SETQ |val| (|getValue| |x|))
                      (COND
                       ((AND (EQUAL (ELT |x| 0) |$immediateDataSymbol|)
                             (EQUAL |y| (LIST |$Integer|)))
                        (PROGN
                         (SETQ |val| (|objValUnwrap| |val|))
                         (SETQ |m| (|getBasicMode0| |val| T))
                         (SETF (ELT |x| 2) (|objNewWrap| |val| |m|))
                         (SETF (ELT |x| 3) (LIST |m|))
                         (LIST |m|)))
                       ((NULL |val|) |y|)
                       ((AND
                         (|isEqualOrSubDomain| (|objMode| |val|) |$Integer|)
                         (INTEGERP (SETQ |f| (|objValUnwrap| |val|))))
                        (LIST (|getBasicMode0| |f| T)))
                       (#1# |y|))))))
                  (#1#
                   (|keyedSystemError| 'S2GE0016
                    (LIST "getModeSetUseSubomain" "no mode set")))))
           ((SETQ |m| (|getBasicMode0| |x| T)) (LIST |m|))
           ((NULL (ATOM |x|)) (|getModeSetUseSubdomain| (CAR |x|)))
           (#1#
            (|keyedSystemError| 'S2GE0016
             (LIST "getModeSetUseSubomain" "not an attributed tree")))))))

; getValueFromEnvironment(x,mode) ==
;   $failure ~= (v := getValueFromSpecificEnvironment(x,mode,$env)) => v
;   $failure ~= (v := getValueFromSpecificEnvironment(x,mode,$e))   => v
;   null(v := coerceInt(objNew(x, ['Variable, x]), mode)) =>
;      throwKeyedMsg("S2IE0001",[x])
;   objValUnwrap v

(DEFUN |getValueFromEnvironment| (|x| |mode|)
  (PROG (|v|)
    (RETURN
     (COND
      ((NOT
        (EQUAL |$failure|
               (SETQ |v|
                       (|getValueFromSpecificEnvironment| |x| |mode| |$env|))))
       |v|)
      ((NOT
        (EQUAL |$failure|
               (SETQ |v| (|getValueFromSpecificEnvironment| |x| |mode| |$e|))))
       |v|)
      ((NULL
        (SETQ |v| (|coerceInt| (|objNew| |x| (LIST '|Variable| |x|)) |mode|)))
       (|throwKeyedMsg| 'S2IE0001 (LIST |x|)))
      ('T (|objValUnwrap| |v|))))))

; getValueFromSpecificEnvironment(id,mode,e) ==
;   PAIRP e =>
;     u := get(id,'value,e) =>
;       objMode(u) = $EmptyMode =>
;         systemErrorHere '"getValueFromSpecificEnvironment"
;       v := objValUnwrap u
;       mode isnt ['Mapping,:mapSig] => v
;       v isnt ['SPADMAP, :.] => v
;       v' := coerceInt(u,mode)
;       null v' => throwKeyedMsg("S2IC0002",[objMode u,mode])
;       objValUnwrap v'
;
;     m := get(id,'mode,e) =>
;       -- See if we can make it into declared mode from symbolic form
;       -- For example, (x : P[x] I; x + 1)
;       if isPartialMode(m) then m' := resolveTM(['Variable,id],m)
;       else m' := m
;       m' and
;         (u := coerceInteractive(objNewWrap(id,['Variable,id]),m')) =>
;           objValUnwrap u
;
;       throwKeyedMsg("S2IE0002",[id,m])
;     $failure
;   $failure

(DEFUN |getValueFromSpecificEnvironment| (|id| |mode| |e|)
  (PROG (|u| |v| |mapSig| |v'| |m| |m'|)
    (RETURN
     (COND
      ((CONSP |e|)
       (COND
        ((SETQ |u| (|get| |id| '|value| |e|))
         (COND
          ((EQUAL (|objMode| |u|) |$EmptyMode|)
           (|systemErrorHere| "getValueFromSpecificEnvironment"))
          (#1='T
           (PROGN
            (SETQ |v| (|objValUnwrap| |u|))
            (COND
             ((NOT
               (AND (CONSP |mode|) (EQ (CAR |mode|) '|Mapping|)
                    (PROGN (SETQ |mapSig| (CDR |mode|)) #1#)))
              |v|)
             ((NOT (AND (CONSP |v|) (EQ (CAR |v|) 'SPADMAP))) |v|)
             (#1#
              (PROGN
               (SETQ |v'| (|coerceInt| |u| |mode|))
               (COND
                ((NULL |v'|)
                 (|throwKeyedMsg| 'S2IC0002 (LIST (|objMode| |u|) |mode|)))
                (#1# (|objValUnwrap| |v'|))))))))))
        ((SETQ |m| (|get| |id| '|mode| |e|))
         (PROGN
          (COND
           ((|isPartialMode| |m|)
            (SETQ |m'| (|resolveTM| (LIST '|Variable| |id|) |m|)))
           (#1# (SETQ |m'| |m|)))
          (COND
           ((AND |m'|
                 (SETQ |u|
                         (|coerceInteractive|
                          (|objNewWrap| |id| (LIST '|Variable| |id|)) |m'|)))
            (|objValUnwrap| |u|))
           (#1# (|throwKeyedMsg| 'S2IE0002 (LIST |id| |m|))))))
        (#1# |$failure|)))
      (#1# |$failure|)))))

; addBindingInteractive(var,proplist,e is [[curContour,:.],:.]) ==
;   -- change proplist of var in e destructively
;   u := ASSQ(var,curContour) =>
;     RPLACD(u,proplist)
;     e
;   rplac(CAAR e, [[var, :proplist], :curContour])
;   e

(DEFUN |addBindingInteractive| (|var| |proplist| |e|)
  (PROG (|curContour| |u|)
    (RETURN
     (PROGN
      (SETQ |curContour| (CAAR |e|))
      (COND
       ((SETQ |u| (ASSQ |var| |curContour|))
        (PROGN (RPLACD |u| |proplist|) |e|))
       ('T
        (PROGN
         (|rplac| (CAAR |e|) (CONS (CONS |var| |proplist|) |curContour|))
         |e|)))))))

; augProplistInteractive(proplist,prop,val) ==
;   u := ASSQ(prop,proplist) =>
;     RPLACD(u,val)
;     proplist
;   [[prop,:val],:proplist]

(DEFUN |augProplistInteractive| (|proplist| |prop| |val|)
  (PROG (|u|)
    (RETURN
     (COND
      ((SETQ |u| (ASSQ |prop| |proplist|))
       (PROGN (RPLACD |u| |val|) |proplist|))
      ('T (CONS (CONS |prop| |val|) |proplist|))))))

; getFlag x == get("--flags--",x,$e)

(DEFUN |getFlag| (|x|) (PROG () (RETURN (|get| '|--flags--| |x| |$e|))))

; putFlag(flag,value) ==
;   $e := put ("--flags--", flag, value, $e)

(DEFUN |putFlag| (|flag| |value|)
  (PROG () (RETURN (SETQ |$e| (|put| '|--flags--| |flag| |value| |$e|)))))

; get(x,prop,e) ==
;   $InteractiveMode => get0(x,prop,e)
;   get1(x,prop,e)

(DEFUN |get| (|x| |prop| |e|)
  (PROG ()
    (RETURN
     (COND (|$InteractiveMode| (|get0| |x| |prop| |e|))
           ('T (|get1| |x| |prop| |e|))))))

; get0(x,prop,e) ==
;   null atom x => get(QCAR x,prop,e)
;   (pl := getProplist(x, e)) => QLASSQ(prop, pl)
;   nil

(DEFUN |get0| (|x| |prop| |e|)
  (PROG (|pl|)
    (RETURN
     (COND ((NULL (ATOM |x|)) (|get| (QCAR |x|) |prop| |e|))
           ((SETQ |pl| (|getProplist| |x| |e|)) (QLASSQ |prop| |pl|))
           ('T NIL)))))

; get1(x,prop,e) ==
;     --this is the old get
;   negHash := nil
;   null atom x => get(QCAR x,prop,e)
;   if $envHashTable and (not(EQ($CategoryFrame, e))) and (not(EQ(prop, "modemap"))) then
;     null (HGET($envHashTable, [x, prop])) => return nil
;     negHash := null (HGET($envHashTable, [x, prop]))
;   prop="modemap" and $insideCapsuleFunctionIfTrue=true =>
;     ress := LASSOC("modemap",getProplist(x,$CapsuleModemapFrame))
;               or get2(x,prop,e)
;     -- SAY ["get1", x, prop, ress and true]
;     ress
;   ress := LASSOC(prop,getProplist(x,e)) or get2(x,prop,e)
;   if ress and negHash then
;     SAY ["get1", x, prop, ress and true]
;   ress

(DEFUN |get1| (|x| |prop| |e|)
  (PROG (|negHash| |ress|)
    (RETURN
     (PROGN
      (SETQ |negHash| NIL)
      (COND ((NULL (ATOM |x|)) (|get| (QCAR |x|) |prop| |e|))
            (#1='T
             (PROGN
              (COND
               ((AND |$envHashTable| (NULL (EQ |$CategoryFrame| |e|))
                     (NULL (EQ |prop| '|modemap|)))
                (COND
                 ((NULL (HGET |$envHashTable| (LIST |x| |prop|))) (RETURN NIL))
                 (#1#
                  (SETQ |negHash|
                          (NULL (HGET |$envHashTable| (LIST |x| |prop|))))))))
              (COND
               ((AND (EQ |prop| '|modemap|)
                     (EQUAL |$insideCapsuleFunctionIfTrue| T))
                (PROGN
                 (SETQ |ress|
                         (OR
                          (LASSOC '|modemap|
                           (|getProplist| |x| |$CapsuleModemapFrame|))
                          (|get2| |x| |prop| |e|)))
                 |ress|))
               (#1#
                (PROGN
                 (SETQ |ress|
                         (OR (LASSOC |prop| (|getProplist| |x| |e|))
                             (|get2| |x| |prop| |e|)))
                 (COND
                  ((AND |ress| |negHash|)
                   (SAY (LIST '|get1| |x| |prop| (AND |ress| T)))))
                 |ress|))))))))))

; get2(x,prop,e) ==
;   prop="modemap" and constructor? x =>
;     (u := getConstructorModemap(x)) => [u]
;     nil
;   nil

(DEFUN |get2| (|x| |prop| |e|)
  (PROG (|u|)
    (RETURN
     (COND
      ((AND (EQ |prop| '|modemap|) (|constructor?| |x|))
       (COND ((SETQ |u| (|getConstructorModemap| |x|)) (LIST |u|))
             (#1='T NIL)))
      (#1# NIL)))))

; getI(x,prop) == get(x,prop,$InteractiveFrame)

(DEFUN |getI| (|x| |prop|)
  (PROG () (RETURN (|get| |x| |prop| |$InteractiveFrame|))))

; putI(x,prop,val) == ($InteractiveFrame := put(x,prop,val,$InteractiveFrame))

(DEFUN |putI| (|x| |prop| |val|)
  (PROG ()
    (RETURN
     (SETQ |$InteractiveFrame| (|put| |x| |prop| |val| |$InteractiveFrame|)))))

; getIProplist x == getProplist(x,$InteractiveFrame)

(DEFUN |getIProplist| (|x|)
  (PROG () (RETURN (|getProplist| |x| |$InteractiveFrame|))))

; rempropI(x,prop) ==
;   id:=
;     atom x => x
;     first x
;   getI(id,prop) =>
;     recordNewValue(id,prop,NIL)
;     recordOldValue(id,prop,getI(id,prop))
;     $InteractiveFrame:= remprop(id,prop,$InteractiveFrame)

(DEFUN |rempropI| (|x| |prop|)
  (PROG (|id|)
    (RETURN
     (PROGN
      (SETQ |id| (COND ((ATOM |x|) |x|) ('T (CAR |x|))))
      (COND
       ((|getI| |id| |prop|)
        (PROGN
         (|recordNewValue| |id| |prop| NIL)
         (|recordOldValue| |id| |prop| (|getI| |id| |prop|))
         (SETQ |$InteractiveFrame|
                 (|remprop| |id| |prop| |$InteractiveFrame|)))))))))

; remprop(x,prop,e) ==
;   u:= assoc(prop,pl:= getProplist(x,e)) =>
;     e:= addBinding(x,DELASC(first u,pl),e)
;     e
;   e

(DEFUN |remprop| (|x| |prop| |e|)
  (PROG (|pl| |u|)
    (RETURN
     (COND
      ((SETQ |u| (|assoc| |prop| (SETQ |pl| (|getProplist| |x| |e|))))
       (PROGN (SETQ |e| (|addBinding| |x| (DELASC (CAR |u|) |pl|) |e|)) |e|))
      ('T |e|)))))

; fastSearchCurrentEnv(x,currentEnv) ==
;   u := QLASSQ(x, first currentEnv) => u
;   while (currentEnv:= QCDR currentEnv) repeat
;     u := QLASSQ(x, first currentEnv) => u

(DEFUN |fastSearchCurrentEnv| (|x| |currentEnv|)
  (PROG (|u|)
    (RETURN
     (COND ((SETQ |u| (QLASSQ |x| (CAR |currentEnv|))) |u|)
           (#1='T
            ((LAMBDA ()
               (LOOP
                (COND
                 ((NOT (SETQ |currentEnv| (QCDR |currentEnv|))) (RETURN NIL))
                 (#1#
                  (COND
                   ((SETQ |u| (QLASSQ |x| (CAR |currentEnv|)))
                    (IDENTITY |u|)))))))))))))

; put(x,prop,val,e) ==
;   $InteractiveMode and not EQ(e,$CategoryFrame) =>
;     putIntSymTab(x,prop,val,e)
;   --e must never be $CapsuleModemapFrame
;   null atom x => put(first x,prop,val,e)
;   newProplist:= augProplistOf(x,prop,val,e)
;   prop="modemap" and $insideCapsuleFunctionIfTrue=true =>
;     SAY ["**** modemap PUT on CapsuleModemapFrame: ",val]
;     $CapsuleModemapFrame:=
;       addBinding(x,augProplistOf(x,"modemap",val,$CapsuleModemapFrame),
;         $CapsuleModemapFrame)
;     e
;   addBinding(x,newProplist,e)

(DEFUN |put| (|x| |prop| |val| |e|)
  (PROG (|newProplist|)
    (RETURN
     (COND
      ((AND |$InteractiveMode| (NULL (EQ |e| |$CategoryFrame|)))
       (|putIntSymTab| |x| |prop| |val| |e|))
      ((NULL (ATOM |x|)) (|put| (CAR |x|) |prop| |val| |e|))
      (#1='T
       (PROGN
        (SETQ |newProplist| (|augProplistOf| |x| |prop| |val| |e|))
        (COND
         ((AND (EQ |prop| '|modemap|) (EQUAL |$insideCapsuleFunctionIfTrue| T))
          (PROGN
           (SAY (LIST '|**** modemap PUT on CapsuleModemapFrame: | |val|))
           (SETQ |$CapsuleModemapFrame|
                   (|addBinding| |x|
                    (|augProplistOf| |x| '|modemap| |val|
                     |$CapsuleModemapFrame|)
                    |$CapsuleModemapFrame|))
           |e|))
         (#1# (|addBinding| |x| |newProplist| |e|)))))))))

; putIntSymTab(x,prop,val,e) ==
;   null atom x => putIntSymTab(first x,prop,val,e)
;   pl0 := pl := search(x,e)
;   pl :=
;     null pl => [[prop,:val]]
;     u := ASSQ(prop,pl) =>
;       RPLACD(u,val)
;       pl
;     lp := LASTNODE pl
;     u := [[prop,:val]]
;     RPLACD(lp,u)
;     pl
;   EQ(pl0,pl) => e
;   addIntSymTabBinding(x,pl,e)

(DEFUN |putIntSymTab| (|x| |prop| |val| |e|)
  (PROG (|pl| |pl0| |u| |lp|)
    (RETURN
     (COND ((NULL (ATOM |x|)) (|putIntSymTab| (CAR |x|) |prop| |val| |e|))
           (#1='T
            (PROGN
             (SETQ |pl0| (SETQ |pl| (|search| |x| |e|)))
             (SETQ |pl|
                     (COND ((NULL |pl|) (LIST (CONS |prop| |val|)))
                           ((SETQ |u| (ASSQ |prop| |pl|))
                            (PROGN (RPLACD |u| |val|) |pl|))
                           (#1#
                            (PROGN
                             (SETQ |lp| (LASTNODE |pl|))
                             (SETQ |u| (LIST (CONS |prop| |val|)))
                             (RPLACD |lp| |u|)
                             |pl|))))
             (COND ((EQ |pl0| |pl|) |e|)
                   (#1# (|addIntSymTabBinding| |x| |pl| |e|)))))))))

; addIntSymTabBinding(var,proplist,e is [[curContour,:.],:.]) ==
;   -- change proplist of var in e destructively
;   u := ASSQ(var,curContour) =>
;     RPLACD(u,proplist)
;     e
;   rplac(CAAR e, [[var, :proplist], :curContour])
;   e

(DEFUN |addIntSymTabBinding| (|var| |proplist| |e|)
  (PROG (|curContour| |u|)
    (RETURN
     (PROGN
      (SETQ |curContour| (CAAR |e|))
      (COND
       ((SETQ |u| (ASSQ |var| |curContour|))
        (PROGN (RPLACD |u| |proplist|) |e|))
       ('T
        (PROGN
         (|rplac| (CAAR |e|) (CONS (CONS |var| |proplist|) |curContour|))
         |e|)))))))

; putSrcPos(x, file, src, line, col) ==
;     putAtree(x, 'srcAndPos, srcPos_New(file, src, line, col))

(DEFUN |putSrcPos| (|x| |file| |src| |line| |col|)
  (PROG ()
    (RETURN
     (|putAtree| |x| '|srcAndPos| (|srcPos_New| |file| |src| |line| |col|)))))

; getSrcPos(x) == getAtree(x, 'srcAndPos)

(DEFUN |getSrcPos| (|x|) (PROG () (RETURN (|getAtree| |x| '|srcAndPos|))))

; srcPosNew(file, src, line, col) == LIST2VEC [file, src, line, col]

(DEFUN |srcPosNew| (|file| |src| |line| |col|)
  (PROG () (RETURN (LIST2VEC (LIST |file| |src| |line| |col|)))))

; srcPosFile(sp) ==
;     if sp then sp.0 else nil

(DEFUN |srcPosFile| (|sp|)
  (PROG () (RETURN (COND (|sp| (ELT |sp| 0)) ('T NIL)))))

; srcPosSource(sp) ==
;     if sp then sp.1 else nil

(DEFUN |srcPosSource| (|sp|)
  (PROG () (RETURN (COND (|sp| (ELT |sp| 1)) ('T NIL)))))

; srcPosLine(sp) ==
;     if sp then sp.2 else nil

(DEFUN |srcPosLine| (|sp|)
  (PROG () (RETURN (COND (|sp| (ELT |sp| 2)) ('T NIL)))))

; srcPosColumn(sp) ==
;     if sp then sp.3 else nil

(DEFUN |srcPosColumn| (|sp|)
  (PROG () (RETURN (COND (|sp| (ELT |sp| 3)) ('T NIL)))))

; srcPosDisplay(sp) ==
;     null sp => nil
;     s := STRCONC('"_"", srcPosFile sp, '"_", line ",
;         STRINGIMAGE srcPosLine sp, '": ")
;     sayBrightly [s, srcPosSource sp]
;     col  := srcPosColumn sp
;     dots :=
;         col = 0 => '""
;         fillerSpaces(col, '".")
;     sayBrightly [fillerSpaces(#s, '" "), dots, '"^"]
;     true

(DEFUN |srcPosDisplay| (|sp|)
  (PROG (|s| |col| |dots|)
    (RETURN
     (COND ((NULL |sp|) NIL)
           (#1='T
            (PROGN
             (SETQ |s|
                     (STRCONC "\"" (|srcPosFile| |sp|) "\", line "
                      (STRINGIMAGE (|srcPosLine| |sp|)) ": "))
             (|sayBrightly| (LIST |s| (|srcPosSource| |sp|)))
             (SETQ |col| (|srcPosColumn| |sp|))
             (SETQ |dots|
                     (COND ((EQL |col| 0) "")
                           (#1# (|fillerSpaces| |col| "."))))
             (|sayBrightly|
              (LIST (|fillerSpaces| (LENGTH |s|) " ") |dots| "^"))
             T))))))

; mkObj(val, mode) == CONS(mode,val)              -- old names

(DEFUN |mkObj| (|val| |mode|) (PROG () (RETURN (CONS |mode| |val|))))

; mkObjWrap(val, mode) == CONS(mode,wrap val)

(DEFUN |mkObjWrap| (|val| |mode|)
  (PROG () (RETURN (CONS |mode| (|wrap| |val|)))))

; mkObjCode(val, mode) == ['CONS, MKQ mode,val ]

(DEFUN |mkObjCode| (|val| |mode|)
  (PROG () (RETURN (LIST 'CONS (MKQ |mode|) |val|))))

; objNew(val, mode) == CONS(mode,val)             -- new names as of 10/14/93

(DEFUN |objNew| (|val| |mode|) (PROG () (RETURN (CONS |mode| |val|))))

; objNewWrap(val, mode) == CONS(mode,wrap val)

(DEFUN |objNewWrap| (|val| |mode|)
  (PROG () (RETURN (CONS |mode| (|wrap| |val|)))))

; objNewCode(val, mode) == ['CONS, MKQ mode,val ]

(DEFUN |objNewCode| (|val| |mode|)
  (PROG () (RETURN (LIST 'CONS (MKQ |mode|) |val|))))

; objSetVal(obj,val) == RPLACD(obj,val)

(DEFUN |objSetVal| (|obj| |val|) (PROG () (RETURN (RPLACD |obj| |val|))))

; objSetMode(obj,mode) == RPLACA(obj,mode)

(DEFUN |objSetMode| (|obj| |mode|) (PROG () (RETURN (RPLACA |obj| |mode|))))

; objVal obj == rest obj

(DEFUN |objVal| (|obj|) (PROG () (RETURN (CDR |obj|))))

; objValUnwrap obj == unwrap rest obj

(DEFUN |objValUnwrap| (|obj|) (PROG () (RETURN (|unwrap| (CDR |obj|)))))

; objMode obj == first obj

(DEFUN |objMode| (|obj|) (PROG () (RETURN (CAR |obj|))))

; objCodeVal obj == CADDR obj

(DEFUN |objCodeVal| (|obj|) (PROG () (RETURN (CADDR |obj|))))

; objCodeMode obj == CADR obj

(DEFUN |objCodeMode| (|obj|) (PROG () (RETURN (CADR |obj|))))

; asTupleNew(size, listOfElts) == CONS(size, LIST2VEC listOfElts)

(DEFUN |asTupleNew| (SIZE |listOfElts|)
  (PROG () (RETURN (CONS SIZE (LIST2VEC |listOfElts|)))))

; asTupleNew0(listOfElts) == CONS(#listOfElts, LIST2VEC listOfElts)

(DEFUN |asTupleNew0| (|listOfElts|)
  (PROG () (RETURN (CONS (LENGTH |listOfElts|) (LIST2VEC |listOfElts|)))))

; asTupleNewCode(size, listOfElts) == ["asTupleNew", size, ['LIST, :listOfElts]]

(DEFUN |asTupleNewCode| (SIZE |listOfElts|)
  (PROG () (RETURN (LIST '|asTupleNew| SIZE (CONS 'LIST |listOfElts|)))))

; asTupleNewCode0(listForm) == ["asTupleNew0", listForm]

(DEFUN |asTupleNewCode0| (|listForm|)
  (PROG () (RETURN (LIST '|asTupleNew0| |listForm|))))

; asTupleSize(at) == first at

(DEFUN |asTupleSize| (|at|) (PROG () (RETURN (CAR |at|))))

; asTupleAsVector(at) == rest at

(DEFUN |asTupleAsVector| (|at|) (PROG () (RETURN (CDR |at|))))

; asTupleAsList(at) == VEC2LIST asTupleAsVector at

(DEFUN |asTupleAsList| (|at|)
  (PROG () (RETURN (VEC2LIST (|asTupleAsVector| |at|)))))

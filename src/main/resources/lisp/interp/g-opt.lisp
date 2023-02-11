
; )package "BOOT"

(IN-PACKAGE "BOOT")

; optimizeFunctionDef(def) ==
;   if $reportOptimization then
;     sayBrightlyI bright '"Original LISP code:"
;     pp def
;
;   def' := optimize COPY def
;
;   if $reportOptimization then
;     sayBrightlyI bright '"Optimized LISP code:"
;     pp def'
;     sayBrightlyI bright '"Final LISP code:"
;   [name,[slamOrLam,args,body]] := def'
;
;   body':=
;     removeTopLevelCatch body where
;       removeTopLevelCatch body ==
;         body is ["CATCH",g,u] =>
;           removeTopLevelCatch replaceThrowByReturn(u,g)
;         body
;       replaceThrowByReturn(x,g) ==
;         fn(x,g)
;         x
;       fn(x,g) ==
;         x is ["THROW", =g,:u] =>
;           rplac(first x,"RETURN")
;           rplac(rest x,replaceThrowByReturn(u,g))
;         atom x => nil
;         replaceThrowByReturn(first x,g)
;         replaceThrowByReturn(rest x,g)
;   [name,[slamOrLam,args,body']]

(DEFUN |optimizeFunctionDef| (|def|)
  (PROG (|def'| |name| |slamOrLam| |args| |body| |body'|)
    (RETURN
     (PROGN
      (COND
       (|$reportOptimization| (|sayBrightlyI| (|bright| "Original LISP code:"))
        (|pp| |def|)))
      (SETQ |def'| (|optimize| (COPY |def|)))
      (COND
       (|$reportOptimization|
        (|sayBrightlyI| (|bright| "Optimized LISP code:")) (|pp| |def'|)
        (|sayBrightlyI| (|bright| "Final LISP code:"))))
      (SETQ |name| (CAR |def'|))
      (SETQ |slamOrLam| (CAADR . #1=(|def'|)))
      (SETQ |args| (CADADR . #1#))
      (SETQ |body| (CAR (CDDADR . #1#)))
      (SETQ |body'| (|optimizeFunctionDef,removeTopLevelCatch| |body|))
      (LIST |name| (LIST |slamOrLam| |args| |body'|))))))
(DEFUN |optimizeFunctionDef,removeTopLevelCatch| (|body|)
  (PROG (|ISTMP#1| |g| |ISTMP#2| |u|)
    (RETURN
     (COND
      ((AND (CONSP |body|) (EQ (CAR |body|) 'CATCH)
            (PROGN
             (SETQ |ISTMP#1| (CDR |body|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |g| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |u| (CAR |ISTMP#2|)) #1='T))))))
       (|optimizeFunctionDef,removeTopLevelCatch|
        (|optimizeFunctionDef,replaceThrowByReturn| |u| |g|)))
      (#1# |body|)))))
(DEFUN |optimizeFunctionDef,replaceThrowByReturn| (|x| |g|)
  (PROG () (RETURN (PROGN (|optimizeFunctionDef,fn| |x| |g|) |x|))))
(DEFUN |optimizeFunctionDef,fn| (|x| |g|)
  (PROG (|ISTMP#1| |u|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'THROW)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |g|)
                  (PROGN (SETQ |u| (CDR |ISTMP#1|)) #1='T))))
       (PROGN
        (|rplac| (CAR |x|) 'RETURN)
        (|rplac| (CDR |x|)
         (|optimizeFunctionDef,replaceThrowByReturn| |u| |g|))))
      ((ATOM |x|) NIL)
      (#1#
       (PROGN
        (|optimizeFunctionDef,replaceThrowByReturn| (CAR |x|) |g|)
        (|optimizeFunctionDef,replaceThrowByReturn| (CDR |x|) |g|)))))))

; lispize x == first optimize [x]

(DEFUN |lispize| (|x|) (PROG () (RETURN (CAR (|optimize| (LIST |x|))))))

; optimize x ==
;   (opt x; x) where
;     opt x ==
;       atom x => nil
;       (y:= first x)='QUOTE => nil
;       y='CLOSEDFN => nil
;       y is [["XLAM",argl,body],:a] =>
;         optimize rest x
;         argl = "ignore" => rplac(first x, body)
;         if not (LENGTH argl<=LENGTH a) then
;           SAY '"length mismatch in XLAM expression"
;           PRETTYPRINT y
;         rplac(first x, optimize optXLAMCond SUBLIS(pairList(argl, a), body))
;       atom y =>
;         optimize rest x
;         y = "true" => rplac(first x, '(QUOTE (QUOTE T)))
;         y = "false" => rplac(first x, nil)
;       if first y = "IF" then (rplac(first x, optIF2COND y); y := first x)
;       op := GET(subrname first y, "OPTIMIZE") =>
;         (optimize rest x; rplac(first x, FUNCALL(op, optimize first x)))
;       rplac(first x, optimize first x)
;       optimize rest x

(DEFUN |optimize| (|x|) (PROG () (RETURN (PROGN (|optimize,opt| |x|) |x|))))
(DEFUN |optimize,opt| (|x|)
  (PROG (|y| |ISTMP#1| |ISTMP#2| |argl| |ISTMP#3| |body| |a| |op|)
    (RETURN
     (COND ((ATOM |x|) NIL) ((EQ (SETQ |y| (CAR |x|)) 'QUOTE) NIL)
           ((EQ |y| 'CLOSEDFN) NIL)
           ((AND (CONSP |y|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |y|))
                  (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'XLAM)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |argl| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |body| (CAR |ISTMP#3|))
                                    #1='T)))))))
                 (PROGN (SETQ |a| (CDR |y|)) #1#))
            (PROGN
             (|optimize| (CDR |x|))
             (COND ((EQ |argl| '|ignore|) (|rplac| (CAR |x|) |body|))
                   (#1#
                    (PROGN
                     (COND
                      ((NULL (NOT (< (LENGTH |a|) (LENGTH |argl|))))
                       (SAY "length mismatch in XLAM expression")
                       (PRETTYPRINT |y|)))
                     (|rplac| (CAR |x|)
                      (|optimize|
                       (|optXLAMCond|
                        (SUBLIS (|pairList| |argl| |a|) |body|)))))))))
           ((ATOM |y|)
            (PROGN
             (|optimize| (CDR |x|))
             (COND ((EQ |y| '|true|) (|rplac| (CAR |x|) '''T))
                   ((EQ |y| '|false|) (|rplac| (CAR |x|) NIL)))))
           (#1#
            (PROGN
             (COND
              ((EQ (CAR |y|) 'IF) (|rplac| (CAR |x|) (|optIF2COND| |y|))
               (SETQ |y| (CAR |x|))))
             (COND
              ((SETQ |op| (GET (|subrname| (CAR |y|)) 'OPTIMIZE))
               (PROGN
                (|optimize| (CDR |x|))
                (|rplac| (CAR |x|) (FUNCALL |op| (|optimize| (CAR |x|))))))
              (#1#
               (PROGN
                (|rplac| (CAR |x|) (|optimize| (CAR |x|)))
                (|optimize| (CDR |x|)))))))))))

; subrname u ==
;   IDENTP u => u
;   nil

(DEFUN |subrname| (|u|) (PROG () (RETURN (COND ((IDENTP |u|) |u|) ('T NIL)))))

; optCatch (x is ["CATCH",g,a]) ==
;   $InteractiveMode => x
;   atom a => a
;   if a is ["SEQ",:s,["THROW", =g,u]] then
;     changeThrowToExit(s,g) where
;       changeThrowToExit(s,g) ==
;         atom s or MEMQ(first s,'(QUOTE SEQ REPEAT COLLECT)) => nil
;         s is ["THROW", =g,:u] => (rplac(first s,"EXIT"); rplac(rest s,u))
;         changeThrowToExit(first s,g)
;         changeThrowToExit(rest s,g)
;     rplac(rest a,[:s,["EXIT",u]])
;     ["CATCH",y,a]:= optimize x
;   if hasNoThrows(a, g) where
;       hasNoThrows(a, g) ==
;         a is ["THROW", =g,:.] => false
;         atom a => true
;         hasNoThrows(first a,g) and hasNoThrows(rest a,g)
;      then (rplac(first x, first a); rplac(rest x, rest a))
;    else
;     val_sym := GENSYM()
;     changeThrowToGo(a, g, val_sym) where
;         changeThrowToGo(s, g, val_sym) ==
;             atom s or first s='QUOTE => nil
;             s is ["THROW", =g, u] =>
;                 changeThrowToGo(u, g, val_sym)
;                 rplac(first s, "PROGN")
;                 rplac(rest s, [["LET", val_sym, u], ["GO", CADR g]])
;             changeThrowToGo(first s, g, val_sym)
;             changeThrowToGo(rest s, g, val_sym)
;     rplac(first x,"SEQ")
;     rplac(rest x, [["EXIT",a], CADR g, ["EXIT", val_sym]])
;   x

(DEFUN |optCatch| (|x|)
  (PROG (|g| |a| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4| |ISTMP#5| |u| |s|
         |LETTMP#1| |y| |val_sym|)
    (RETURN
     (PROGN
      (SETQ |g| (CADR . #1=(|x|)))
      (SETQ |a| (CADDR . #1#))
      (COND (|$InteractiveMode| |x|) ((ATOM |a|) |a|)
            (#2='T
             (PROGN
              (COND
               ((AND (CONSP |a|) (EQ (CAR |a|) 'SEQ)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |a|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #2#)
                           (CONSP |ISTMP#2|)
                           (PROGN
                            (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                            (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) 'THROW)
                                 (PROGN
                                  (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                  (AND (CONSP |ISTMP#4|)
                                       (EQUAL (CAR |ISTMP#4|) |g|)
                                       (PROGN
                                        (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                        (AND (CONSP |ISTMP#5|)
                                             (EQ (CDR |ISTMP#5|) NIL)
                                             (PROGN
                                              (SETQ |u| (CAR |ISTMP#5|))
                                              #2#)))))))
                           (PROGN (SETQ |s| (CDR |ISTMP#2|)) #2#)
                           (PROGN (SETQ |s| (NREVERSE |s|)) #2#))))
                (|optCatch,changeThrowToExit| |s| |g|)
                (|rplac| (CDR |a|) (APPEND |s| (CONS (LIST 'EXIT |u|) NIL)))
                (SETQ |LETTMP#1| (|optimize| |x|))
                (SETQ |y| (CADR . #3=(|LETTMP#1|))) (SETQ |a| (CADDR . #3#))
                |LETTMP#1|))
              (COND
               ((|optCatch,hasNoThrows| |a| |g|) (|rplac| (CAR |x|) (CAR |a|))
                (|rplac| (CDR |x|) (CDR |a|)))
               (#2# (SETQ |val_sym| (GENSYM))
                (|optCatch,changeThrowToGo| |a| |g| |val_sym|)
                (|rplac| (CAR |x|) 'SEQ)
                (|rplac| (CDR |x|)
                 (LIST (LIST 'EXIT |a|) (CADR |g|) (LIST 'EXIT |val_sym|)))))
              |x|)))))))
(DEFUN |optCatch,changeThrowToGo| (|s| |g| |val_sym|)
  (PROG (|ISTMP#1| |ISTMP#2| |u|)
    (RETURN
     (COND ((OR (ATOM |s|) (EQ (CAR |s|) 'QUOTE)) NIL)
           ((AND (CONSP |s|) (EQ (CAR |s|) 'THROW)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |s|))
                  (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |g|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |u| (CAR |ISTMP#2|)) #1='T))))))
            (PROGN
             (|optCatch,changeThrowToGo| |u| |g| |val_sym|)
             (|rplac| (CAR |s|) 'PROGN)
             (|rplac| (CDR |s|)
              (LIST (LIST 'LET |val_sym| |u|) (LIST 'GO (CADR |g|))))))
           (#1#
            (PROGN
             (|optCatch,changeThrowToGo| (CAR |s|) |g| |val_sym|)
             (|optCatch,changeThrowToGo| (CDR |s|) |g| |val_sym|)))))))
(DEFUN |optCatch,hasNoThrows| (|a| |g|)
  (PROG (|ISTMP#1|)
    (RETURN
     (COND
      ((AND (CONSP |a|) (EQ (CAR |a|) 'THROW)
            (PROGN
             (SETQ |ISTMP#1| (CDR |a|))
             (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |g|))))
       NIL)
      ((ATOM |a|) T)
      ('T
       (AND (|optCatch,hasNoThrows| (CAR |a|) |g|)
            (|optCatch,hasNoThrows| (CDR |a|) |g|)))))))
(DEFUN |optCatch,changeThrowToExit| (|s| |g|)
  (PROG (|ISTMP#1| |u|)
    (RETURN
     (COND ((OR (ATOM |s|) (MEMQ (CAR |s|) '(QUOTE SEQ REPEAT COLLECT))) NIL)
           ((AND (CONSP |s|) (EQ (CAR |s|) 'THROW)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |s|))
                  (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |g|)
                       (PROGN (SETQ |u| (CDR |ISTMP#1|)) #1='T))))
            (PROGN (|rplac| (CAR |s|) 'EXIT) (|rplac| (CDR |s|) |u|)))
           (#1#
            (PROGN
             (|optCatch,changeThrowToExit| (CAR |s|) |g|)
             (|optCatch,changeThrowToExit| (CDR |s|) |g|)))))))

; optSPADCALL(form is ['SPADCALL,:argl]) ==
;   null $InteractiveMode => form
;   -- last arg is function/env, but may be a form
;   argl is [:argl,fun] =>
;     fun is ['ELT,dom,slot] =>
;       optCall ['call,['ELT,dom,slot],:argl]
;     form
;   form

(DEFUN |optSPADCALL| (|form|)
  (PROG (|argl| |ISTMP#1| |fun| |dom| |ISTMP#2| |slot|)
    (RETURN
     (PROGN
      (SETQ |argl| (CDR |form|))
      (COND ((NULL |$InteractiveMode|) |form|)
            ((AND (CONSP |argl|)
                  (PROGN (SETQ |ISTMP#1| (REVERSE |argl|)) #1='T)
                  (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |fun| (CAR |ISTMP#1|))
                   (SETQ |argl| (CDR |ISTMP#1|))
                   #1#)
                  (PROGN (SETQ |argl| (NREVERSE |argl|)) #1#))
             (COND
              ((AND (CONSP |fun|) (EQ (CAR |fun|) 'ELT)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |fun|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |dom| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |slot| (CAR |ISTMP#2|)) #1#))))))
               (|optCall|
                (CONS '|call| (CONS (LIST 'ELT |dom| |slot|) |argl|))))
              (#1# |form|)))
            (#1# |form|))))))

; optCall (x is ["call",:u]) ==
;   -- destructively optimizes this new x
;   x:= optimize [u]
;   -- next should happen only as result of macro expansion
;   atom first x => first x
;   [fn,:a]:= first x
;   atom fn => (rplac(rest x, a); rplac(first x, fn); x)
;   fn is ["applyFun",name] =>
;     (rplac(first x, "SPADCALL"); rplac(rest x, [:a, name]); x)
;   fn is [q,R,n] and MEMQ(q,'(ELT QREFELT CONST)) =>
;     not $bootStrapMode and (w:= optCallSpecially(x, n, R)) => w
;     q="CONST" =>
; --+
;       ["spadConstant",R,n]
;     --putInLocalDomainReferences will change this to ELT or QREFELT
;     rplac(first x, "SPADCALL")
;     if $QuickCode then RPLACA(fn,"QREFELT")
;     rplac(rest x, [:a, fn])
;     x
;   systemErrorHere '"optCall"

(DEFUN |optCall| (|x|)
  (PROG (|u| |LETTMP#1| |fn| |a| |ISTMP#1| |name| |q| R |ISTMP#2| |n| |w|)
    (RETURN
     (PROGN
      (SETQ |u| (CDR |x|))
      (SETQ |x| (|optimize| (LIST |u|)))
      (COND ((ATOM (CAR |x|)) (CAR |x|))
            (#1='T
             (PROGN
              (SETQ |LETTMP#1| (CAR |x|))
              (SETQ |fn| (CAR |LETTMP#1|))
              (SETQ |a| (CDR |LETTMP#1|))
              (COND
               ((ATOM |fn|)
                (PROGN (|rplac| (CDR |x|) |a|) (|rplac| (CAR |x|) |fn|) |x|))
               ((AND (CONSP |fn|) (EQ (CAR |fn|) '|applyFun|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |fn|))
                      (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                           (PROGN (SETQ |name| (CAR |ISTMP#1|)) #1#))))
                (PROGN
                 (|rplac| (CAR |x|) 'SPADCALL)
                 (|rplac| (CDR |x|) (APPEND |a| (CONS |name| NIL)))
                 |x|))
               ((AND (CONSP |fn|)
                     (PROGN
                      (SETQ |q| (CAR |fn|))
                      (SETQ |ISTMP#1| (CDR |fn|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ R (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN (SETQ |n| (CAR |ISTMP#2|)) #1#)))))
                     (MEMQ |q| '(ELT QREFELT CONST)))
                (COND
                 ((AND (NULL |$bootStrapMode|)
                       (SETQ |w| (|optCallSpecially| |x| |n| R)))
                  |w|)
                 ((EQ |q| 'CONST) (LIST '|spadConstant| R |n|))
                 (#1#
                  (PROGN
                   (|rplac| (CAR |x|) 'SPADCALL)
                   (COND (|$QuickCode| (RPLACA |fn| 'QREFELT)))
                   (|rplac| (CDR |x|) (APPEND |a| (CONS |fn| NIL)))
                   |x|))))
               (#1# (|systemErrorHere| "optCall"))))))))))

; optCallSpecially(x, n, R) ==
;     MEMQ(IFCAR R, $optimizableConstructorNames) => optSpecialCall(x, R, n)
;     nil

(DEFUN |optCallSpecially| (|x| |n| R)
  (PROG ()
    (RETURN
     (COND
      ((MEMQ (IFCAR R) |$optimizableConstructorNames|)
       (|optSpecialCall| |x| R |n|))
      ('T NIL)))))

; optCallEval u ==
;   -- Integer() is a lie, but otherwise we could not evaluate
;   -- needed domains
;   u is ["List",:.] => List Integer()
;   u is ["Vector",:.] => Vector Integer()
;   u is ["OneDimensionalArray", :.] => OneDimensionalArray Integer()
;   u is ["PrimitiveArray",:.] => PrimitiveArray Integer()
;   u is ["Matrix", :.] => Matrix Integer()
;   u is ["TwoDimensionalArray", :.] => TwoDimensionalArray Integer()
;   u is ["PrimitiveTwoDimensionalArray", :.] =>
;                        PrimitiveTwoDimensionalArray(Integer())
;   eval u

(DEFUN |optCallEval| (|u|)
  (PROG ()
    (RETURN
     (COND ((AND (CONSP |u|) (EQ (CAR |u|) '|List|)) (|List| (|Integer|)))
           ((AND (CONSP |u|) (EQ (CAR |u|) '|Vector|)) (|Vector| (|Integer|)))
           ((AND (CONSP |u|) (EQ (CAR |u|) '|OneDimensionalArray|))
            (|OneDimensionalArray| (|Integer|)))
           ((AND (CONSP |u|) (EQ (CAR |u|) '|PrimitiveArray|))
            (|PrimitiveArray| (|Integer|)))
           ((AND (CONSP |u|) (EQ (CAR |u|) '|Matrix|)) (|Matrix| (|Integer|)))
           ((AND (CONSP |u|) (EQ (CAR |u|) '|TwoDimensionalArray|))
            (|TwoDimensionalArray| (|Integer|)))
           ((AND (CONSP |u|) (EQ (CAR |u|) '|PrimitiveTwoDimensionalArray|))
            (|PrimitiveTwoDimensionalArray| (|Integer|)))
           ('T (|eval| |u|))))))

; optCons (x is ["CONS",a,b]) ==
;   a="NIL" =>
;     b='NIL => (rplac(first x,'QUOTE); rplac(rest x,['NIL,:'NIL]); x)
;     b is ['QUOTE,:c] => (rplac(first x,'QUOTE); rplac(rest x,['NIL,:c]); x)
;     x
;   a is ['QUOTE,a'] =>
;     b='NIL => (rplac(first x,'QUOTE); rplac(rest x,[a',:'NIL]); x)
;     b is ['QUOTE,:c] => (rplac(first x,'QUOTE); rplac(rest x,[a',:c]); x)
;     x
;   x

(DEFUN |optCons| (|x|)
  (PROG (|a| |b| |c| |ISTMP#1| |a'|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|x|)))
      (SETQ |b| (CADDR . #1#))
      (COND
       ((EQUAL |a| 'NIL)
        (COND
         ((EQUAL |b| 'NIL)
          (PROGN
           (|rplac| (CAR |x|) 'QUOTE)
           (|rplac| (CDR |x|) (CONS 'NIL 'NIL))
           |x|))
         ((AND (CONSP |b|) (EQ (CAR |b|) 'QUOTE)
               (PROGN (SETQ |c| (CDR |b|)) #2='T))
          (PROGN
           (|rplac| (CAR |x|) 'QUOTE)
           (|rplac| (CDR |x|) (CONS 'NIL |c|))
           |x|))
         (#2# |x|)))
       ((AND (CONSP |a|) (EQ (CAR |a|) 'QUOTE)
             (PROGN
              (SETQ |ISTMP#1| (CDR |a|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN (SETQ |a'| (CAR |ISTMP#1|)) #2#))))
        (COND
         ((EQUAL |b| 'NIL)
          (PROGN
           (|rplac| (CAR |x|) 'QUOTE)
           (|rplac| (CDR |x|) (CONS |a'| 'NIL))
           |x|))
         ((AND (CONSP |b|) (EQ (CAR |b|) 'QUOTE)
               (PROGN (SETQ |c| (CDR |b|)) #2#))
          (PROGN
           (|rplac| (CAR |x|) 'QUOTE)
           (|rplac| (CDR |x|) (CONS |a'| |c|))
           |x|))
         (#2# |x|)))
       (#2# |x|))))))

; optSpecialCall(x,y,n) ==
;   yval := optCallEval y
;   CAAAR x="CONST" =>
;     IFCAR yval.n = function Undef =>
;       keyedSystemError("S2GE0016",['"optSpecialCall",
;         '"invalid constant"])
;     MKQ yval.n
;   fn := GETL(compileTimeBindingOf first yval.n,'SPADreplace) =>
;     rplac(rest x,CDAR x)
;     rplac(first x,fn)
;     if fn is ["XLAM",:.] then x:=first optimize [x]
;     x
;   [fn,:a]:= first x
;   rplac(first x, "SPADCALL")
;   if $QuickCode then RPLACA(fn,"QREFELT")
;   rplac(rest x, [:a, fn])
;   x

(DEFUN |optSpecialCall| (|x| |y| |n|)
  (PROG (|yval| |fn| |LETTMP#1| |a|)
    (RETURN
     (PROGN
      (SETQ |yval| (|optCallEval| |y|))
      (COND
       ((EQ (CAAAR |x|) 'CONST)
        (COND
         ((EQUAL (IFCAR (ELT |yval| |n|)) #'|Undef|)
          (|keyedSystemError| 'S2GE0016
           (LIST "optSpecialCall" "invalid constant")))
         (#1='T (MKQ (ELT |yval| |n|)))))
       ((SETQ |fn|
                (GETL (|compileTimeBindingOf| (CAR (ELT |yval| |n|)))
                 '|SPADreplace|))
        (PROGN
         (|rplac| (CDR |x|) (CDAR |x|))
         (|rplac| (CAR |x|) |fn|)
         (COND
          ((AND (CONSP |fn|) (EQ (CAR |fn|) 'XLAM))
           (SETQ |x| (CAR (|optimize| (LIST |x|))))))
         |x|))
       (#1#
        (PROGN
         (SETQ |LETTMP#1| (CAR |x|))
         (SETQ |fn| (CAR |LETTMP#1|))
         (SETQ |a| (CDR |LETTMP#1|))
         (|rplac| (CAR |x|) 'SPADCALL)
         (COND (|$QuickCode| (RPLACA |fn| 'QREFELT)))
         (|rplac| (CDR |x|) (APPEND |a| (CONS |fn| NIL)))
         |x|)))))))

; compileTimeBindingOf u ==
;   NULL(name:= BPINAME u)  => keyedSystemError("S2OO0001",[u])
;   name="Undef" => MOAN "optimiser found unknown function"
;   name

(DEFUN |compileTimeBindingOf| (|u|)
  (PROG (|name|)
    (RETURN
     (COND
      ((NULL (SETQ |name| (BPINAME |u|)))
       (|keyedSystemError| 'S2OO0001 (LIST |u|)))
      ((EQ |name| '|Undef|) (MOAN '|optimiser found unknown function|))
      ('T |name|)))))

; optMkRecord ["mkRecord",:u] ==
;   u is [x] => ["LIST",x]
;   #u=2 => ["CONS",:u]
;   ["VECTOR",:u]

(DEFUN |optMkRecord| (|bfVar#1|)
  (PROG (|u| |x|)
    (RETURN
     (PROGN
      (SETQ |u| (CDR |bfVar#1|))
      (COND
       ((AND (CONSP |u|) (EQ (CDR |u|) NIL) (PROGN (SETQ |x| (CAR |u|)) #1='T))
        (LIST 'LIST |x|))
       ((EQL (LENGTH |u|) 2) (CONS 'CONS |u|)) (#1# (CONS 'VECTOR |u|)))))))

; optCond (x is ['COND,:l]) ==
;   if l is [a,[aa,b]] and TruthP aa and b is ["COND",:c] then
;     RPLACD(rest x,c)
;   if l is [[p1,:c1],[p2,:c2],:.] then
;     if (p1 is ['NULL,p1'] and p1' = p2) or (p2 is ['NULL,p2'] and p2' = p1) then
;       l:=[[p1,:c1],['(QUOTE T),:c2]]
;       RPLACD( x,l)
;     c1 is ['NIL] and p2 = '(QUOTE T) and first c2 = '(QUOTE T) =>
;       p1 is ['NULL,p1']=> return p1'
;       return ['NULL,p1]
;   l is [[p1,:c1],[p2,:c2],[p3,:c3]] and TruthP p3 =>
;     EqualBarGensym(c1,c3) =>
;       ["COND",[["OR",p1,["NULL",p2]],:c1],[['QUOTE,true],:c2]]
;     EqualBarGensym(c1,c2) => ["COND",[["OR",p1,p2],:c1],[['QUOTE,true],:c3]]
;     x
;   for y in tails l repeat
;     while y is [[a1,c1],[a2,c2],:y'] and EqualBarGensym(c1,c2) repeat
;       a:=['OR,a1,a2]
;       rplac(first first y, a)
;       rplac(rest y, y')
;   x

(DEFUN |optCond| (|x|)
  (PROG (|l| |a| |ISTMP#1| |ISTMP#2| |aa| |ISTMP#3| |b| |c| |p1| |c1| |p2| |c2|
         |p1'| |p2'| |ISTMP#4| |ISTMP#5| |p3| |c3| |a1| |a2| |y'|)
    (RETURN
     (PROGN
      (SETQ |l| (CDR |x|))
      (COND
       ((AND (CONSP |l|)
             (PROGN
              (SETQ |a| (CAR |l|))
              (SETQ |ISTMP#1| (CDR |l|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN
                    (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |aa| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                               (PROGN (SETQ |b| (CAR |ISTMP#3|)) #1='T)))))))
             (|TruthP| |aa|) (CONSP |b|) (EQ (CAR |b|) 'COND)
             (PROGN (SETQ |c| (CDR |b|)) #1#))
        (RPLACD (CDR |x|) |c|)))
      (COND
       ((AND (CONSP |l|)
             (PROGN
              (SETQ |ISTMP#1| (CAR |l|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |p1| (CAR |ISTMP#1|))
                    (SETQ |c1| (CDR |ISTMP#1|))
                    #1#)))
             (PROGN
              (SETQ |ISTMP#2| (CDR |l|))
              (AND (CONSP |ISTMP#2|)
                   (PROGN
                    (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                    (AND (CONSP |ISTMP#3|)
                         (PROGN
                          (SETQ |p2| (CAR |ISTMP#3|))
                          (SETQ |c2| (CDR |ISTMP#3|))
                          #1#))))))
        (COND
         ((OR
           (AND (CONSP |p1|) (EQ (CAR |p1|) 'NULL)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |p1|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |p1'| (CAR |ISTMP#1|)) #1#)))
                (EQUAL |p1'| |p2|))
           (AND (CONSP |p2|) (EQ (CAR |p2|) 'NULL)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |p2|))
                 (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                      (PROGN (SETQ |p2'| (CAR |ISTMP#1|)) #1#)))
                (EQUAL |p2'| |p1|)))
          (SETQ |l| (LIST (CONS |p1| |c1|) (CONS ''T |c2|))) (RPLACD |x| |l|)))
        (COND
         ((AND (CONSP |c1|) (EQ (CDR |c1|) NIL) (EQUAL (CAR |c1|) 'NIL)
               (EQUAL |p2| ''T) (EQUAL (CAR |c2|) ''T))
          (COND
           ((AND (CONSP |p1|) (EQ (CAR |p1|) 'NULL)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |p1|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |p1'| (CAR |ISTMP#1|)) #1#))))
            (RETURN |p1'|))
           (#1# (RETURN (LIST 'NULL |p1|))))))))
      (COND
       ((AND (CONSP |l|)
             (PROGN
              (SETQ |ISTMP#1| (CAR |l|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |p1| (CAR |ISTMP#1|))
                    (SETQ |c1| (CDR |ISTMP#1|))
                    #1#)))
             (PROGN
              (SETQ |ISTMP#2| (CDR |l|))
              (AND (CONSP |ISTMP#2|)
                   (PROGN
                    (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                    (AND (CONSP |ISTMP#3|)
                         (PROGN
                          (SETQ |p2| (CAR |ISTMP#3|))
                          (SETQ |c2| (CDR |ISTMP#3|))
                          #1#)))
                   (PROGN
                    (SETQ |ISTMP#4| (CDR |ISTMP#2|))
                    (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                         (PROGN
                          (SETQ |ISTMP#5| (CAR |ISTMP#4|))
                          (AND (CONSP |ISTMP#5|)
                               (PROGN
                                (SETQ |p3| (CAR |ISTMP#5|))
                                (SETQ |c3| (CDR |ISTMP#5|))
                                #1#)))))))
             (|TruthP| |p3|))
        (COND
         ((|EqualBarGensym| |c1| |c3|)
          (LIST 'COND (CONS (LIST 'OR |p1| (LIST 'NULL |p2|)) |c1|)
                (CONS (LIST 'QUOTE T) |c2|)))
         ((|EqualBarGensym| |c1| |c2|)
          (LIST 'COND (CONS (LIST 'OR |p1| |p2|) |c1|)
                (CONS (LIST 'QUOTE T) |c3|)))
         (#1# |x|)))
       (#1#
        (PROGN
         ((LAMBDA (|y|)
            (LOOP
             (COND ((ATOM |y|) (RETURN NIL))
                   (#1#
                    ((LAMBDA ()
                       (LOOP
                        (COND
                         ((NOT
                           (AND (CONSP |y|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CAR |y|))
                                 (AND (CONSP |ISTMP#1|)
                                      (PROGN
                                       (SETQ |a1| (CAR |ISTMP#1|))
                                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                       (AND (CONSP |ISTMP#2|)
                                            (EQ (CDR |ISTMP#2|) NIL)
                                            (PROGN
                                             (SETQ |c1| (CAR |ISTMP#2|))
                                             #1#)))))
                                (PROGN
                                 (SETQ |ISTMP#3| (CDR |y|))
                                 (AND (CONSP |ISTMP#3|)
                                      (PROGN
                                       (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                                       (AND (CONSP |ISTMP#4|)
                                            (PROGN
                                             (SETQ |a2| (CAR |ISTMP#4|))
                                             (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                             (AND (CONSP |ISTMP#5|)
                                                  (EQ (CDR |ISTMP#5|) NIL)
                                                  (PROGN
                                                   (SETQ |c2| (CAR |ISTMP#5|))
                                                   #1#)))))
                                      (PROGN (SETQ |y'| (CDR |ISTMP#3|)) #1#)))
                                (|EqualBarGensym| |c1| |c2|)))
                          (RETURN NIL))
                         (#1#
                          (PROGN
                           (SETQ |a| (LIST 'OR |a1| |a2|))
                           (|rplac| (CAR (CAR |y|)) |a|)
                           (|rplac| (CDR |y|) |y'|)))))))))
             (SETQ |y| (CDR |y|))))
          |l|)
         |x|)))))))

; EqualBarGensym(x,y) ==
;   $GensymAssoc: fluid := nil
;   fn(x,y) where
;     fn(x,y) ==
;       x=y => true
;       GENSYMP x and GENSYMP y =>
;         z:= assoc(x,$GensymAssoc) => (y=rest z => true; false)
;         $GensymAssoc:= [[x,:y],:$GensymAssoc]
;         true
;       null x => y is [g] and GENSYMP g
;       null y => x is [g] and GENSYMP g
;       atom x or atom y => false
;       fn(first x,first y) and fn(rest x,rest y)

(DEFUN |EqualBarGensym| (|x| |y|)
  (PROG (|$GensymAssoc|)
    (DECLARE (SPECIAL |$GensymAssoc|))
    (RETURN (PROGN (SETQ |$GensymAssoc| NIL) (|EqualBarGensym,fn| |x| |y|)))))
(DEFUN |EqualBarGensym,fn| (|x| |y|)
  (PROG (|z| |g|)
    (RETURN
     (COND ((EQUAL |x| |y|) T)
           ((AND (GENSYMP |x|) (GENSYMP |y|))
            (COND
             ((SETQ |z| (|assoc| |x| |$GensymAssoc|))
              (COND ((EQUAL |y| (CDR |z|)) T) (#1='T NIL)))
             (#1#
              (PROGN
               (SETQ |$GensymAssoc| (CONS (CONS |x| |y|) |$GensymAssoc|))
               T))))
           ((NULL |x|)
            (AND (CONSP |y|) (EQ (CDR |y|) NIL)
                 (PROGN (SETQ |g| (CAR |y|)) #1#) (GENSYMP |g|)))
           ((NULL |y|)
            (AND (CONSP |x|) (EQ (CDR |x|) NIL)
                 (PROGN (SETQ |g| (CAR |x|)) #1#) (GENSYMP |g|)))
           ((OR (ATOM |x|) (ATOM |y|)) NIL)
           (#1#
            (AND (|EqualBarGensym,fn| (CAR |x|) (CAR |y|))
                 (|EqualBarGensym,fn| (CDR |x|) (CDR |y|))))))))

; optIF2COND ["IF",a,b,c] ==
;   b is "noBranch" => ["COND",[["NULL",a],c]]
;   c is "noBranch" => ["COND",[a,b]]
;   c is ["IF",:.] => ["COND",[a,b],:rest optIF2COND c]
;   c is ["COND",:p] => ["COND",[a,b],:p]
;   ["COND",[a,b],[$true,c]]

(DEFUN |optIF2COND| (|bfVar#2|)
  (PROG (|a| |b| |c| |p|)
    (RETURN
     (PROGN
      (SETQ |a| (CADR . #1=(|bfVar#2|)))
      (SETQ |b| (CADDR . #1#))
      (SETQ |c| (CADDDR . #1#))
      (COND ((EQ |b| '|noBranch|) (LIST 'COND (LIST (LIST 'NULL |a|) |c|)))
            ((EQ |c| '|noBranch|) (LIST 'COND (LIST |a| |b|)))
            ((AND (CONSP |c|) (EQ (CAR |c|) 'IF))
             (CONS 'COND (CONS (LIST |a| |b|) (CDR (|optIF2COND| |c|)))))
            ((AND (CONSP |c|) (EQ (CAR |c|) 'COND)
                  (PROGN (SETQ |p| (CDR |c|)) #2='T))
             (CONS 'COND (CONS (LIST |a| |b|) |p|)))
            (#2# (LIST 'COND (LIST |a| |b|) (LIST |$true| |c|))))))))

; optXLAMCond x ==
;   x is ["COND",u:= [p,c],:l] =>
;     (optPredicateIfTrue p => c; ["COND",u,:optCONDtail l])
;   atom x => x
;   rplac(first x, optXLAMCond first x)
;   rplac(rest x, optXLAMCond rest x)
;   x

(DEFUN |optXLAMCond| (|x|)
  (PROG (|ISTMP#1| |ISTMP#2| |p| |ISTMP#3| |c| |u| |l|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'COND)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| #1=(CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |p| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |c| (CAR |ISTMP#3|)) #2='T)))))
                  (PROGN (SETQ |u| #1#) #2#)
                  (PROGN (SETQ |l| (CDR |ISTMP#1|)) #2#))))
       (COND ((|optPredicateIfTrue| |p|) |c|)
             (#2# (CONS 'COND (CONS |u| (|optCONDtail| |l|))))))
      ((ATOM |x|) |x|)
      (#2#
       (PROGN
        (|rplac| (CAR |x|) (|optXLAMCond| (CAR |x|)))
        (|rplac| (CDR |x|) (|optXLAMCond| (CDR |x|)))
        |x|))))))

; optPredicateIfTrue p ==
;   p is ['QUOTE,:.] => true
;   p is [fn,x] and MEMQ(fn,$BasicPredicates) and FUNCALL(fn,x) => true
;   nil

(DEFUN |optPredicateIfTrue| (|p|)
  (PROG (|fn| |ISTMP#1| |x|)
    (RETURN
     (COND ((AND (CONSP |p|) (EQ (CAR |p|) 'QUOTE)) T)
           ((AND (CONSP |p|)
                 (PROGN
                  (SETQ |fn| (CAR |p|))
                  (SETQ |ISTMP#1| (CDR |p|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |x| (CAR |ISTMP#1|)) #1='T)))
                 (MEMQ |fn| |$BasicPredicates|) (FUNCALL |fn| |x|))
            T)
           (#1# NIL)))))

; optCONDtail l ==
;   null l => nil
;   [frst:= [p,c],:l']:= l
;   optPredicateIfTrue p => [[$true,c]]
;   null rest l => [frst,[$true,["CondError"]]]
;   [frst,:optCONDtail l']

(DEFUN |optCONDtail| (|l|)
  (PROG (|frst| |p| |c| |l'|)
    (RETURN
     (COND ((NULL |l|) NIL)
           (#1='T
            (PROGN
             (SETQ |frst| (CAR . #2=(|l|)))
             (SETQ |p| (CAAR . #2#))
             (SETQ |c| (CADAR . #2#))
             (SETQ |l'| (CDR |l|))
             (COND ((|optPredicateIfTrue| |p|) (LIST (LIST |$true| |c|)))
                   ((NULL (CDR |l|))
                    (LIST |frst| (LIST |$true| (LIST '|CondError|))))
                   (#1# (CONS |frst| (|optCONDtail| |l'|))))))))))

; optSEQ ["SEQ",:l] ==
;   tryToRemoveSEQ SEQToCOND getRidOfTemps l where
;     getRidOfTemps l ==
;       null l => nil
;       l is [["LET",g,x,:.],:r] and GENSYMP g and 2>numOfOccurencesOf(g,r) =>
;         getRidOfTemps substitute(x,g,r)
;       first l="/throwAway" => getRidOfTemps rest l
;       --this gets rid of unwanted labels generated by declarations in SEQs
;       [first l,:getRidOfTemps rest l]
;     SEQToCOND l ==
;       transform:= [[a,b] for x in l while (x is ["COND",[a,["EXIT",b]]])]
;       before:= take(#transform,l)
;       aft:= after(l,before)
;       null before => ["SEQ",:aft]
;       null aft => ["COND",:transform,'((QUOTE T) (conderr))]
;       true => ["COND",:transform,['(QUOTE T),optSEQ ["SEQ",:aft]]]
;     tryToRemoveSEQ l ==
;       l is ["SEQ",[op,a]] and MEMQ(op,'(EXIT RETURN THROW)) => a
;       l

(DEFUN |optSEQ| (|bfVar#5|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l| (CDR |bfVar#5|))
      (|optSEQ,tryToRemoveSEQ|
       (|optSEQ,SEQToCOND| (|optSEQ,getRidOfTemps| |l|)))))))
(DEFUN |optSEQ,getRidOfTemps| (|l|)
  (PROG (|ISTMP#1| |ISTMP#2| |g| |ISTMP#3| |x| |r|)
    (RETURN
     (COND ((NULL |l|) NIL)
           ((AND (CONSP |l|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |l|))
                  (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'LET)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |g| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|)
                                   (PROGN
                                    (SETQ |x| (CAR |ISTMP#3|))
                                    #1='T)))))))
                 (PROGN (SETQ |r| (CDR |l|)) #1#) (GENSYMP |g|)
                 (< (|numOfOccurencesOf| |g| |r|) 2))
            (|optSEQ,getRidOfTemps| (|substitute| |x| |g| |r|)))
           ((EQ (CAR |l|) '|/throwAway|) (|optSEQ,getRidOfTemps| (CDR |l|)))
           (#1# (CONS (CAR |l|) (|optSEQ,getRidOfTemps| (CDR |l|))))))))
(DEFUN |optSEQ,SEQToCOND| (|l|)
  (PROG (|ISTMP#1| |ISTMP#2| |a| |ISTMP#3| |ISTMP#4| |ISTMP#5| |b| |transform|
         |before| |aft|)
    (RETURN
     (PROGN
      (SETQ |transform|
              ((LAMBDA (|bfVar#4| |bfVar#3| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#3|) (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL)
                        (NOT
                         (AND (CONSP |x|) (EQ (CAR |x|) 'COND)
                              (PROGN
                               (SETQ |ISTMP#1| (CDR |x|))
                               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                    (PROGN
                                     (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                     (AND (CONSP |ISTMP#2|)
                                          (PROGN
                                           (SETQ |a| (CAR |ISTMP#2|))
                                           (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                           (AND (CONSP |ISTMP#3|)
                                                (EQ (CDR |ISTMP#3|) NIL)
                                                (PROGN
                                                 (SETQ |ISTMP#4|
                                                         (CAR |ISTMP#3|))
                                                 (AND (CONSP |ISTMP#4|)
                                                      (EQ (CAR |ISTMP#4|)
                                                          'EXIT)
                                                      (PROGN
                                                       (SETQ |ISTMP#5|
                                                               (CDR |ISTMP#4|))
                                                       (AND (CONSP |ISTMP#5|)
                                                            (EQ (CDR |ISTMP#5|)
                                                                NIL)
                                                            (PROGN
                                                             (SETQ |b|
                                                                     (CAR
                                                                      |ISTMP#5|))
                                                             #1='T))))))))))))))
                    (RETURN (NREVERSE |bfVar#4|)))
                   (#1# (SETQ |bfVar#4| (CONS (LIST |a| |b|) |bfVar#4|))))
                  (SETQ |bfVar#3| (CDR |bfVar#3|))))
               NIL |l| NIL))
      (SETQ |before| (TAKE (LENGTH |transform|) |l|))
      (SETQ |aft| (|after| |l| |before|))
      (COND ((NULL |before|) (CONS 'SEQ |aft|))
            ((NULL |aft|)
             (CONS 'COND (APPEND |transform| (CONS '('T (|conderr|)) NIL))))
            (T
             (CONS 'COND
                   (APPEND |transform|
                           (CONS (LIST ''T (|optSEQ| (CONS 'SEQ |aft|)))
                                 NIL)))))))))
(DEFUN |optSEQ,tryToRemoveSEQ| (|l|)
  (PROG (|ISTMP#1| |ISTMP#2| |op| |ISTMP#3| |a|)
    (RETURN
     (COND
      ((AND (CONSP |l|) (EQ (CAR |l|) 'SEQ)
            (PROGN
             (SETQ |ISTMP#1| (CDR |l|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |op| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |a| (CAR |ISTMP#3|)) #1='T)))))))
            (MEMQ |op| '(EXIT RETURN THROW)))
       |a|)
      (#1# |l|)))))

; optRECORDELT ["RECORDELT",name,ind,len] ==
;   len=1 =>
;     ind=0 => ["QCAR",name]
;     keyedSystemError("S2OO0002",[ind])
;   len=2 =>
;     ind=0 => ["QCAR",name]
;     ind=1 => ["QCDR",name]
;     keyedSystemError("S2OO0002",[ind])
;   ["QVELT",name,ind]

(DEFUN |optRECORDELT| (|bfVar#6|)
  (PROG (|name| |ind| |len|)
    (RETURN
     (PROGN
      (SETQ |name| (CADR . #1=(|bfVar#6|)))
      (SETQ |ind| (CADDR . #1#))
      (SETQ |len| (CADDDR . #1#))
      (COND
       ((EQL |len| 1)
        (COND ((EQL |ind| 0) (LIST 'QCAR |name|))
              (#2='T (|keyedSystemError| 'S2OO0002 (LIST |ind|)))))
       ((EQL |len| 2)
        (COND ((EQL |ind| 0) (LIST 'QCAR |name|))
              ((EQL |ind| 1) (LIST 'QCDR |name|))
              (#2# (|keyedSystemError| 'S2OO0002 (LIST |ind|)))))
       (#2# (LIST 'QVELT |name| |ind|)))))))

; optSETRECORDELT ["SETRECORDELT",name,ind,len,expr] ==
;   len=1 =>
;     ind=0 => ["PROGN",["RPLACA",name,expr],["QCAR",name]]
;     keyedSystemError("S2OO0002",[ind])
;   len=2 =>
;     ind=0 => ["PROGN",["RPLACA",name,expr],["QCAR",name]]
;     ind=1 => ["PROGN",["RPLACD",name,expr],["QCDR",name]]
;     keyedSystemError("S2OO0002",[ind])
;   ["QSETVELT",name,ind,expr]

(DEFUN |optSETRECORDELT| (|bfVar#7|)
  (PROG (|name| |ind| |len| |expr|)
    (RETURN
     (PROGN
      (SETQ |name| (CADR . #1=(|bfVar#7|)))
      (SETQ |ind| (CADDR . #1#))
      (SETQ |len| (CADDDR . #1#))
      (SETQ |expr| (CAR (CDDDDR . #1#)))
      (COND
       ((EQL |len| 1)
        (COND
         ((EQL |ind| 0)
          (LIST 'PROGN (LIST 'RPLACA |name| |expr|) (LIST 'QCAR |name|)))
         (#2='T (|keyedSystemError| 'S2OO0002 (LIST |ind|)))))
       ((EQL |len| 2)
        (COND
         ((EQL |ind| 0)
          (LIST 'PROGN (LIST 'RPLACA |name| |expr|) (LIST 'QCAR |name|)))
         ((EQL |ind| 1)
          (LIST 'PROGN (LIST 'RPLACD |name| |expr|) (LIST 'QCDR |name|)))
         (#2# (|keyedSystemError| 'S2OO0002 (LIST |ind|)))))
       (#2# (LIST 'QSETVELT |name| |ind| |expr|)))))))

; optRECORDCOPY ["RECORDCOPY",name,len] ==
;   len=1 => ["LIST",["CAR",name]]
;   len=2 => ["CONS",["CAR",name],["CDR",name]]
;   ["MOVEVEC", ["MAKE_VEC", len], name]

(DEFUN |optRECORDCOPY| (|bfVar#8|)
  (PROG (|name| |len|)
    (RETURN
     (PROGN
      (SETQ |name| (CADR . #1=(|bfVar#8|)))
      (SETQ |len| (CADDR . #1#))
      (COND ((EQL |len| 1) (LIST 'LIST (LIST 'CAR |name|)))
            ((EQL |len| 2) (LIST 'CONS (LIST 'CAR |name|) (LIST 'CDR |name|)))
            ('T (LIST 'MOVEVEC (LIST 'MAKE_VEC |len|) |name|)))))))

; optSuchthat [.,:u] == ["SUCHTHAT",:u]

(DEFUN |optSuchthat| (|bfVar#9|)
  (PROG (|u|) (RETURN (PROGN (SETQ |u| (CDR |bfVar#9|)) (CONS 'SUCHTHAT |u|)))))

; opt_minus_SI u ==
;   u is ['minus_SI, v] =>
;     NUMBERP v => -v
;     u
;   u

(DEFUN |opt_minus_SI| (|u|)
  (PROG (|ISTMP#1| |v|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQ (CAR |u|) '|minus_SI|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |v| (CAR |ISTMP#1|)) #1='T))))
       (COND ((NUMBERP |v|) (- |v|)) (#1# |u|)))
      (#1# |u|)))))

; opt_- u ==
;   u is ['_-,v] =>
;     NUMBERP v => -v
;     u
;   u

(DEFUN |opt-| (|u|)
  (PROG (|ISTMP#1| |v|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQ (CAR |u|) '-)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |v| (CAR |ISTMP#1|)) #1='T))))
       (COND ((NUMBERP |v|) (- |v|)) (#1# |u|)))
      (#1# |u|)))))

; optEQ u ==
;   u is ['EQ,l,r] =>
;     NUMBERP l and NUMBERP r => ['QUOTE,EQ(l,r)]
;     -- That undoes some weird work in Boolean to do with the definition of true
;     u
;   u

(DEFUN |optEQ| (|u|)
  (PROG (|ISTMP#1| |l| |ISTMP#2| |r|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQ (CAR |u|) 'EQ)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |l| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |r| (CAR |ISTMP#2|)) #1='T))))))
       (COND ((AND (NUMBERP |l|) (NUMBERP |r|)) (LIST 'QUOTE (EQ |l| |r|)))
             (#1# |u|)))
      (#1# |u|)))))

; for x in '( (call         optCall) _
;               (SEQ          optSEQ)_
;               (EQ           optEQ)_
;               (minus_SI     opt_minus_SI)_
;               (_-           opt_-)_
;               (SPADCALL     optSPADCALL)_
;               (_|           optSuchthat)_
;               (CATCH        optCatch)_
;               (COND         optCond)_
;               (mkRecord     optMkRecord)_
;               (RECORDELT    optRECORDELT)_
;               (SETRECORDELT optSETRECORDELT)_
;               (RECORDCOPY   optRECORDCOPY)) _
;       repeat MAKEPROP(CAR x,'OPTIMIZE, CADR x)

(EVAL-WHEN (EVAL LOAD)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#10| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#10|) (PROGN (SETQ |x| (CAR |bfVar#10|)) NIL))
           (RETURN NIL))
          ('T (MAKEPROP (CAR |x|) 'OPTIMIZE (CADR |x|))))
         (SETQ |bfVar#10| (CDR |bfVar#10|))))
      '((|call| |optCall|) (SEQ |optSEQ|) (EQ |optEQ|)
        (|minus_SI| |opt_minus_SI|) (- |opt-|) (SPADCALL |optSPADCALL|)
        (|\|| |optSuchthat|) (CATCH |optCatch|) (COND |optCond|)
        (|mkRecord| |optMkRecord|) (RECORDELT |optRECORDELT|)
        (SETRECORDELT |optSETRECORDELT|) (RECORDCOPY |optRECORDCOPY|))
      NIL))))

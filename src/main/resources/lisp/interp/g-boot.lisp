
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($locVars, nil)

(DEFPARAMETER |$locVars| NIL)

; DEFPARAMETER($function_args, nil)

(DEFPARAMETER |$function_args| NIL)

; DEFPARAMETER($PrettyPrint, false)

(DEFPARAMETER |$PrettyPrint| NIL)

; DEFPARAMETER($COMPILE, true)

(DEFPARAMETER $COMPILE T)

; flattenCOND body ==
;   -- transforms nested COND clauses to flat ones, if possible
;   body isnt ['COND,:.] => body
;   ['COND,:extractCONDClauses body]

(DEFUN |flattenCOND| (|body|)
  (PROG ()
    (RETURN
     (COND ((NOT (AND (CONSP |body|) (EQ (CAR |body|) 'COND))) |body|)
           ('T (CONS 'COND (|extractCONDClauses| |body|)))))))

; extractCONDClauses clauses ==
;   -- extracts nested COND clauses into a flat structure
;   clauses is ['COND, [pred1,:act1],:restClauses] =>
;     if act1 is [['PROGN,:acts]] then act1 := acts
;     restClauses is [[''T,restCond]] =>
;       [[pred1,:act1],:extractCONDClauses restCond]
;     [[pred1,:act1],:restClauses]
;   [[''T,clauses]]

(DEFUN |extractCONDClauses| (|clauses|)
  (PROG (|ISTMP#1| |ISTMP#2| |pred1| |act1| |restClauses| |acts| |restCond|)
    (RETURN
     (COND
      ((AND (CONSP |clauses|) (EQ (CAR |clauses|) 'COND)
            (PROGN
             (SETQ |ISTMP#1| (CDR |clauses|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |pred1| (CAR |ISTMP#2|))
                         (SETQ |act1| (CDR |ISTMP#2|))
                         #1='T)))
                  (PROGN (SETQ |restClauses| (CDR |ISTMP#1|)) #1#))))
       (PROGN
        (COND
         ((AND (CONSP |act1|) (EQ (CDR |act1|) NIL)
               (PROGN
                (SETQ |ISTMP#1| (CAR |act1|))
                (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'PROGN)
                     (PROGN (SETQ |acts| (CDR |ISTMP#1|)) #1#))))
          (SETQ |act1| |acts|)))
        (COND
         ((AND (CONSP |restClauses|) (EQ (CDR |restClauses|) NIL)
               (PROGN
                (SETQ |ISTMP#1| (CAR |restClauses|))
                (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) ''T)
                     (PROGN
                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                      (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                           (PROGN (SETQ |restCond| (CAR |ISTMP#2|)) #1#))))))
          (CONS (CONS |pred1| |act1|) (|extractCONDClauses| |restCond|)))
         (#1# (CONS (CONS |pred1| |act1|) |restClauses|)))))
      (#1# (LIST (LIST ''T |clauses|)))))))

; COMP_1(x) ==
;   [fname, lamex, :.] := x
;   $FUNNAME : local := fname
;   $CLOSEDFNS : local := nil
;   lamex := compTran lamex
;   compNewnam lamex
;   if FBOUNDP(fname) then
;       FORMAT(true, '"~&~%;;;     ***       ~S REDEFINED~%", fname)
;   [[fname, lamex], :$CLOSEDFNS]

(DEFUN COMP_1 (|x|)
  (PROG ($CLOSEDFNS $FUNNAME |lamex| |fname|)
    (DECLARE (SPECIAL $CLOSEDFNS $FUNNAME))
    (RETURN
     (PROGN
      (SETQ |fname| (CAR |x|))
      (SETQ |lamex| (CADR |x|))
      (SETQ $FUNNAME |fname|)
      (SETQ $CLOSEDFNS NIL)
      (SETQ |lamex| (|compTran| |lamex|))
      (|compNewnam| |lamex|)
      (COND
       ((FBOUNDP |fname|)
        (FORMAT T "~&~%;;;     ***       ~S REDEFINED~%" |fname|)))
      (CONS (LIST |fname| |lamex|) $CLOSEDFNS)))))

; COMP_2(args) ==
;     [name, [type, argl, :bodyl], :junk] := args
;     junk => MOAN (FORMAT(nil, '"******pren error in (~S (~S ...) ...)",_
;                          name, type))
;     type is "SLAM" => BREAK()
;     type is 'domain_functor =>
;         compHash(name, argl, bodyl, "$ConstructorCache", 'domainEqualList)
;     type is 'category_functor => compSPADSLAM(name, argl, bodyl)
;     if type = 'mutable_domain_functor then
;         type := 'LAMBDA
;     bodyl := [name, [type, argl, :bodyl]]
;     if $PrettyPrint then PPRINT(bodyl)
;     if NULL($COMPILE) then
;       SAY '"No Compilation"
;     else
;       COMP370(bodyl)
;     name

(DEFUN COMP_2 (|args|)
  (PROG (|name| |type| |argl| |bodyl| |junk|)
    (RETURN
     (PROGN
      (SETQ |name| (CAR |args|))
      (SETQ |type| (CAADR . #1=(|args|)))
      (SETQ |argl| (CADADR . #1#))
      (SETQ |bodyl| (CDDADR . #1#))
      (SETQ |junk| (CDDR . #1#))
      (COND
       (|junk|
        (MOAN
         (FORMAT NIL "******pren error in (~S (~S ...) ...)" |name| |type|)))
       ((EQ |type| 'SLAM) (BREAK))
       ((EQ |type| '|domain_functor|)
        (|compHash| |name| |argl| |bodyl| '|$ConstructorCache|
         '|domainEqualList|))
       ((EQ |type| '|category_functor|) (|compSPADSLAM| |name| |argl| |bodyl|))
       (#2='T
        (PROGN
         (COND ((EQ |type| '|mutable_domain_functor|) (SETQ |type| 'LAMBDA)))
         (SETQ |bodyl| (LIST |name| (CONS |type| (CONS |argl| |bodyl|))))
         (COND (|$PrettyPrint| (PPRINT |bodyl|)))
         (COND ((NULL $COMPILE) (SAY "No Compilation"))
               (#2# (COMP370 |bodyl|)))
         |name|)))))))

; COMP(fun) == [COMP_2 nf for nf in COMP_1(fun)]

(DEFUN COMP (|fun|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#2| |bfVar#1| |nf|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|) (PROGN (SETQ |nf| (CAR |bfVar#1|)) NIL))
           (RETURN (NREVERSE |bfVar#2|)))
          ('T (SETQ |bfVar#2| (CONS (COMP_2 |nf|) |bfVar#2|))))
         (SETQ |bfVar#1| (CDR |bfVar#1|))))
      NIL (COMP_1 |fun|) NIL))))

; maybe_devaluate(a, ca) ==
;     ca => ["devaluate", a]
;     a

(DEFUN |maybe_devaluate| (|a| |ca|)
  (PROG () (RETURN (COND (|ca| (LIST '|devaluate| |a|)) ('T |a|)))))

; compSPADSLAM(name, argl, bodyl) ==
;     al := INTERNL1(name, '";AL")
;     auxfn := INTERNL1(name, '";")
;     if argl then
;         g2 := GENSYM()
;         g3 := GENSYM()
;         argtran :=
;             -- we call 'devaluate' only on domains
;             not(rest(argl)) =>
;                 maybe_devaluate(first(argl), first($functor_cosig1))
;             ["LIST", :[maybe_devaluate(g1, c1) for g1 in argl
;                                                for c1 in $functor_cosig1]]
;         app :=
;             not(rest(argl)) => [auxfn, g3]
;             ["APPLY", ["FUNCTION", auxfn], g3]
;         la1 := [["SETQ", g2, ["assoc", g3, al]], ["CDR", g2]]
;         la2 := [true, ["SETQ", al,
;                            ["cons5",
;                                 ["CONS", g3, ["SETQ", g2, app]], al]],
;                             g2]
;         lamex := ["LAMBDA", argl,
;                     ["LET", [g2, [g3, argtran]],
;                       ["COND", la1, la2]]]
;     else
;         lamex := ["LAMBDA", [],
;                     ["COND", [al], [true, ["SETQ", al, [auxfn]]]]]
;
;     output_lisp_defparameter(al, nil)
;     u := [name,lamex]
;     if $PrettyPrint then PRETTYPRINT(u)
;     COMP370(u)
;     u := [auxfn, ["LAMBDA", argl, :bodyl]]
;     if $PrettyPrint then PRETTYPRINT(u)
;     COMP370(u)
;     name

(DEFUN |compSPADSLAM| (|name| |argl| |bodyl|)
  (PROG (|al| |auxfn| |g2| |g3| |argtran| |app| |la1| |la2| |lamex| |u|)
    (RETURN
     (PROGN
      (SETQ |al| (INTERNL1 |name| ";AL"))
      (SETQ |auxfn| (INTERNL1 |name| ";"))
      (COND
       (|argl| (SETQ |g2| (GENSYM)) (SETQ |g3| (GENSYM))
        (SETQ |argtran|
                (COND
                 ((NULL (CDR |argl|))
                  (|maybe_devaluate| (CAR |argl|) (CAR |$functor_cosig1|)))
                 (#1='T
                  (CONS 'LIST
                        ((LAMBDA (|bfVar#5| |bfVar#3| |g1| |bfVar#4| |c1|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#3|)
                                  (PROGN (SETQ |g1| (CAR |bfVar#3|)) NIL)
                                  (ATOM |bfVar#4|)
                                  (PROGN (SETQ |c1| (CAR |bfVar#4|)) NIL))
                              (RETURN (NREVERSE |bfVar#5|)))
                             (#1#
                              (SETQ |bfVar#5|
                                      (CONS (|maybe_devaluate| |g1| |c1|)
                                            |bfVar#5|))))
                            (SETQ |bfVar#3| (CDR |bfVar#3|))
                            (SETQ |bfVar#4| (CDR |bfVar#4|))))
                         NIL |argl| NIL |$functor_cosig1| NIL)))))
        (SETQ |app|
                (COND ((NULL (CDR |argl|)) (LIST |auxfn| |g3|))
                      (#1# (LIST 'APPLY (LIST 'FUNCTION |auxfn|) |g3|))))
        (SETQ |la1|
                (LIST (LIST 'SETQ |g2| (LIST '|assoc| |g3| |al|))
                      (LIST 'CDR |g2|)))
        (SETQ |la2|
                (LIST T
                      (LIST 'SETQ |al|
                            (LIST '|cons5|
                                  (LIST 'CONS |g3| (LIST 'SETQ |g2| |app|))
                                  |al|))
                      |g2|))
        (SETQ |lamex|
                (LIST 'LAMBDA |argl|
                      (LIST 'LET (LIST |g2| (LIST |g3| |argtran|))
                            (LIST 'COND |la1| |la2|)))))
       (#1#
        (SETQ |lamex|
                (LIST 'LAMBDA NIL
                      (LIST 'COND (LIST |al|)
                            (LIST T (LIST 'SETQ |al| (LIST |auxfn|))))))))
      (|output_lisp_defparameter| |al| NIL)
      (SETQ |u| (LIST |name| |lamex|))
      (COND (|$PrettyPrint| (PRETTYPRINT |u|)))
      (COMP370 |u|)
      (SETQ |u| (LIST |auxfn| (CONS 'LAMBDA (CONS |argl| |bodyl|))))
      (COND (|$PrettyPrint| (PRETTYPRINT |u|)))
      (COMP370 |u|)
      |name|))))

; makeClosedfnName() ==
;     INTERN(CONCAT($FUNNAME, '"!", STRINGIMAGE(LENGTH($CLOSEDFNS))))

(DEFUN |makeClosedfnName| ()
  (PROG ()
    (RETURN (INTERN (CONCAT $FUNNAME "!" (STRINGIMAGE (LENGTH $CLOSEDFNS)))))))

; lambdaHelper1(y) ==
;     NOT(MEMQ(y, $locVars)) =>
;         $locVars := [y, :$locVars]
;         $newBindings := [y, :$newBindings]

(DEFUN |lambdaHelper1| (|y|)
  (PROG ()
    (RETURN
     (COND
      ((NULL (MEMQ |y| |$locVars|))
       (IDENTITY
        (PROGN
         (SETQ |$locVars| (CONS |y| |$locVars|))
         (SETQ |$newBindings| (CONS |y| |$newBindings|)))))))))

; lambdaHelper2(y) == MEMQ(y, $newBindings)

(DEFUN |lambdaHelper2| (|y|) (PROG () (RETURN (MEMQ |y| |$newBindings|))))

; compTran1(x) ==
;     ATOM(x) => nil
;     u := first(x)
;     u = "QUOTE" => nil
;     u = "MAKEPROP" => BREAK()
;     MEMQ(u, '(SPADLET SETQ LET)) =>
;         RPLACA(x, "LETT")
;         compTran1(CDDR x)
;         NOT(u = "SETQ") =>
;             IDENTP(CADR(x)) => PUSHLOCVAR(CADR(x))
;             EQCAR(CADR(x), "FLUID") => BREAK()
;             BREAK()
;             MAPC(FUNCTION PUSHLOCVAR, LISTOFATOMS(CADR x))
;     MEMQ(u, '(PROG LAMBDA)) =>
;         $newBindings : local := nil
;         MAPCAR(FUNCTION lambdaHelper1, x.1)
;         res := compTran1(CDDR(x))
;         $locVars := REMOVE_-IF(FUNCTION lambdaHelper2, $locVars)
;         [u, CADR(x), :res]
;     compTran1 u
;     compTran1(rest x)

(DEFUN |compTran1| (|x|)
  (PROG (|$newBindings| |res| |u|)
    (DECLARE (SPECIAL |$newBindings|))
    (RETURN
     (COND ((ATOM |x|) NIL)
           (#1='T
            (PROGN
             (SETQ |u| (CAR |x|))
             (COND ((EQ |u| 'QUOTE) NIL) ((EQ |u| 'MAKEPROP) (BREAK))
                   ((MEMQ |u| '(SPADLET SETQ LET))
                    (PROGN
                     (RPLACA |x| 'LETT)
                     (|compTran1| (CDDR |x|))
                     (COND
                      ((NULL (EQ |u| 'SETQ))
                       (COND ((IDENTP (CADR |x|)) (PUSHLOCVAR (CADR |x|)))
                             ((EQCAR (CADR |x|) 'FLUID) (BREAK))
                             (#1#
                              (PROGN
                               (BREAK)
                               (MAPC #'PUSHLOCVAR
                                     (LISTOFATOMS (CADR |x|))))))))))
                   ((MEMQ |u| '(PROG LAMBDA))
                    (PROGN
                     (SETQ |$newBindings| NIL)
                     (MAPCAR #'|lambdaHelper1| (ELT |x| 1))
                     (SETQ |res| (|compTran1| (CDDR |x|)))
                     (SETQ |$locVars| (REMOVE-IF #'|lambdaHelper2| |$locVars|))
                     (CONS |u| (CONS (CADR |x|) |res|))))
                   (#1#
                    (PROGN (|compTran1| |u|) (|compTran1| (CDR |x|)))))))))))

; compTranDryRun(x) ==
;     $insideCapsuleFunctionIfTrue : local := false
;     compTran(x)

(DEFUN |compTranDryRun| (|x|)
  (PROG (|$insideCapsuleFunctionIfTrue|)
    (DECLARE (SPECIAL |$insideCapsuleFunctionIfTrue|))
    (RETURN
     (PROGN (SETQ |$insideCapsuleFunctionIfTrue| NIL) (|compTran| |x|)))))

; compTran(x) ==
;     $locVars : local := nil
;     [x1, x2, :xl3] := x
;     $function_args : local := x2
;     xl3 := comp_expand(xl3)
;     compTran1 (xl3)
;     [x3, :xlt3] := xl3
;     x3 :=
;         NULL(xlt3) and (ATOM(x3) or _
;                             first(x3) = "SEQ" or _
;                             not(CONTAINED("EXIT", x3))) => x3
;         ["SEQ", :xl3]
;     $locVars := set_difference(REMDUP(NREVERSE($locVars)),
;                                LISTOFATOMS (x2))
;     lvars := $locVars
;     x3 :=
;         lvars or CONTAINED("RETURN", x3) =>
;             ["SPROG", compSpadProg(lvars), x3]
;         x3
;     x2 := addTypesToArgs(x2)
;     [x1, x2, x3]

(DEFUN |compTran| (|x|)
  (PROG (|$function_args| |$locVars| |lvars| |xlt3| |x3| |xl3| |x2| |x1|)
    (DECLARE (SPECIAL |$function_args| |$locVars|))
    (RETURN
     (PROGN
      (SETQ |$locVars| NIL)
      (SETQ |x1| (CAR |x|))
      (SETQ |x2| (CADR . #1=(|x|)))
      (SETQ |xl3| (CDDR . #1#))
      (SETQ |$function_args| |x2|)
      (SETQ |xl3| (|comp_expand| |xl3|))
      (|compTran1| |xl3|)
      (SETQ |x3| (CAR |xl3|))
      (SETQ |xlt3| (CDR |xl3|))
      (SETQ |x3|
              (COND
               ((AND (NULL |xlt3|)
                     (OR (ATOM |x3|) (EQ (CAR |x3|) 'SEQ)
                         (NULL (CONTAINED 'EXIT |x3|))))
                |x3|)
               (#2='T (CONS 'SEQ |xl3|))))
      (SETQ |$locVars|
              (|set_difference| (REMDUP (NREVERSE |$locVars|))
               (LISTOFATOMS |x2|)))
      (SETQ |lvars| |$locVars|)
      (SETQ |x3|
              (COND
               ((OR |lvars| (CONTAINED 'RETURN |x3|))
                (LIST 'SPROG (|compSpadProg| |lvars|) |x3|))
               (#2# |x3|)))
      (SETQ |x2| (|addTypesToArgs| |x2|))
      (LIST |x1| |x2| |x3|)))))

; addTypesToArgs(args) ==
;     $insideCapsuleFunctionIfTrue =>
;         sig := $signatureOfForm
;         spadTypes := [(ATOM(t) => [t]; t) for t in [:rest(sig), first(sig)]]
;         [[a, t] for a in args for t in spadTypes]
;     args

(DEFUN |addTypesToArgs| (|args|)
  (PROG (|sig| |spadTypes|)
    (RETURN
     (COND
      (|$insideCapsuleFunctionIfTrue|
       (PROGN
        (SETQ |sig| |$signatureOfForm|)
        (SETQ |spadTypes|
                ((LAMBDA (|bfVar#7| |bfVar#6| |t|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#6|)
                          (PROGN (SETQ |t| (CAR |bfVar#6|)) NIL))
                      (RETURN (NREVERSE |bfVar#7|)))
                     (#1='T
                      (SETQ |bfVar#7|
                              (CONS (COND ((ATOM |t|) (LIST |t|)) (#1# |t|))
                                    |bfVar#7|))))
                    (SETQ |bfVar#6| (CDR |bfVar#6|))))
                 NIL (APPEND (CDR |sig|) (CONS (CAR |sig|) NIL)) NIL))
        ((LAMBDA (|bfVar#10| |bfVar#8| |a| |bfVar#9| |t|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#8|) (PROGN (SETQ |a| (CAR |bfVar#8|)) NIL)
                  (ATOM |bfVar#9|) (PROGN (SETQ |t| (CAR |bfVar#9|)) NIL))
              (RETURN (NREVERSE |bfVar#10|)))
             (#1# (SETQ |bfVar#10| (CONS (LIST |a| |t|) |bfVar#10|))))
            (SETQ |bfVar#8| (CDR |bfVar#8|))
            (SETQ |bfVar#9| (CDR |bfVar#9|))))
         NIL |args| NIL |spadTypes| NIL)))
      (#1# |args|)))))

; addNilTypesToArgs(args) ==
;     $insideCapsuleFunctionIfTrue =>
;         [[arg, nil] for arg in args]
;     args

(DEFUN |addNilTypesToArgs| (|args|)
  (PROG ()
    (RETURN
     (COND
      (|$insideCapsuleFunctionIfTrue|
       ((LAMBDA (|bfVar#12| |bfVar#11| |arg|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#11|) (PROGN (SETQ |arg| (CAR |bfVar#11|)) NIL))
             (RETURN (NREVERSE |bfVar#12|)))
            (#1='T (SETQ |bfVar#12| (CONS (LIST |arg| NIL) |bfVar#12|))))
           (SETQ |bfVar#11| (CDR |bfVar#11|))))
        NIL |args| NIL))
      (#1# |args|)))))

; compSpadProg(lvars) ==
;     lvarTypes := ($insideCapsuleFunctionIfTrue => $locVarsTypes; nil)
;     types := []
;     for lvar in lvars repeat
;         x := ASSOC(lvar, lvarTypes)
;         types := [[lvar, (x => rest(x); nil)], :types]
;     NREVERSE(types)

(DEFUN |compSpadProg| (|lvars|)
  (PROG (|lvarTypes| |types| |x|)
    (RETURN
     (PROGN
      (SETQ |lvarTypes|
              (COND (|$insideCapsuleFunctionIfTrue| |$locVarsTypes|)
                    (#1='T NIL)))
      (SETQ |types| NIL)
      ((LAMBDA (|bfVar#13| |lvar|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#13|) (PROGN (SETQ |lvar| (CAR |bfVar#13|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |x| (ASSOC |lvar| |lvarTypes|))
             (SETQ |types|
                     (CONS (LIST |lvar| (COND (|x| (CDR |x|)) (#1# NIL)))
                           |types|)))))
          (SETQ |bfVar#13| (CDR |bfVar#13|))))
       |lvars| NIL)
      (NREVERSE |types|)))))

; compNewnam(x) ==
;     ATOM(x) => nil
;     y := first(x)
;     ATOM(y) =>
;         if not(y = "QUOTE") then compNewnam(rest(x))
;         if y = "CLOSEDFN" and BOUNDP('$CLOSEDFNS) then
;             u := makeClosedfnName()
;             PUSH([u, CADR(x)], $CLOSEDFNS)
;             RPLACA(x, "FUNCTION")
;             RPLACA(rest(x), u)
;     compNewnam(first(x))
;     compNewnam(rest(x))

(DEFUN |compNewnam| (|x|)
  (PROG (|y| |u|)
    (RETURN
     (COND ((ATOM |x|) NIL)
           (#1='T
            (PROGN
             (SETQ |y| (CAR |x|))
             (COND
              ((ATOM |y|)
               (PROGN
                (COND ((NULL (EQ |y| 'QUOTE)) (|compNewnam| (CDR |x|))))
                (COND
                 ((AND (EQ |y| 'CLOSEDFN) (BOUNDP '$CLOSEDFNS))
                  (SETQ |u| (|makeClosedfnName|))
                  (PUSH (LIST |u| (CADR |x|)) $CLOSEDFNS)
                  (RPLACA |x| 'FUNCTION) (RPLACA (CDR |x|) |u|)))))
              (#1#
               (PROGN (|compNewnam| (CAR |x|)) (|compNewnam| (CDR |x|)))))))))))

; PUSHLOCVAR(x) ==
;     x ~= "$" and SCHAR('"$", 0) = SCHAR(PNAME(x), 0) _
;       and (not(SCHAR('",", 0) = SCHAR(PNAME(x), 1)) or BREAK())
;       and not(DIGITP (SCHAR(PNAME(x), 1))) => nil
;     PUSH(x, $locVars)

(DEFUN PUSHLOCVAR (|x|)
  (PROG ()
    (RETURN
     (COND
      ((AND (NOT (EQ |x| '$)) (EQUAL (SCHAR "$" 0) (SCHAR (PNAME |x|) 0))
            (OR (NULL (EQUAL (SCHAR "," 0) (SCHAR (PNAME |x|) 1))) (BREAK))
            (NULL (DIGITP (SCHAR (PNAME |x|) 1))))
       NIL)
      ('T (PUSH |x| |$locVars|))))))

; comp_expand(x) ==
;     ATOM(x) => x
;     x is ["QUOTE",:.] => x
;     x is ["SPADREDUCE", op, axis, body] => BREAK()
;     x is ["REPEAT", :body] => comp_expand(expandREPEAT(body))
;     x is ["COLLECT", :body] => comp_expand(expandCOLLECT(body))
;     x is ["COLLECTV", :body] => comp_expand(expandCOLLECTV(body))
;     x is ["COLLECTVEC", :body] => comp_expand(expandCOLLECTV(body))
;     a := comp_expand (car x)
;     b := comp_expand (cdr x)
;     a = first x and b = rest x => x
;     CONS(a, b)

(DEFUN |comp_expand| (|x|)
  (PROG (|ISTMP#1| |op| |ISTMP#2| |axis| |ISTMP#3| |body| |a| |b|)
    (RETURN
     (COND ((ATOM |x|) |x|) ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'SPADREDUCE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |op| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |axis| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |body| (CAR |ISTMP#3|))
                                    #1='T))))))))
            (BREAK))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'REPEAT)
                 (PROGN (SETQ |body| (CDR |x|)) #1#))
            (|comp_expand| (|expandREPEAT| |body|)))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'COLLECT)
                 (PROGN (SETQ |body| (CDR |x|)) #1#))
            (|comp_expand| (|expandCOLLECT| |body|)))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'COLLECTV)
                 (PROGN (SETQ |body| (CDR |x|)) #1#))
            (|comp_expand| (|expandCOLLECTV| |body|)))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'COLLECTVEC)
                 (PROGN (SETQ |body| (CDR |x|)) #1#))
            (|comp_expand| (|expandCOLLECTV| |body|)))
           (#1#
            (PROGN
             (SETQ |a| (|comp_expand| (CAR |x|)))
             (SETQ |b| (|comp_expand| (CDR |x|)))
             (COND ((AND (EQUAL |a| (CAR |x|)) (EQUAL |b| (CDR |x|))) |x|)
                   (#1# (CONS |a| |b|)))))))))

; repeat_tran(l, lp) ==
;     ATOM(l) => ERROR('"REPEAT FORMAT ERROR")
;     IFCAR(IFCAR(l)) in '(EXIT RESET IN ON GSTEP ISTEP STEP
;                      UNTIL WHILE SUCHTHAT) =>
;         repeat_tran(rest(l), [first(l), :lp])
;     [NREVERSE(lp), :MKPF(l, "PROGN")]

(DEFUN |repeat_tran| (|l| |lp|)
  (PROG ()
    (RETURN
     (COND ((ATOM |l|) (ERROR "REPEAT FORMAT ERROR"))
           ((|member| (IFCAR (IFCAR |l|))
             '(EXIT RESET IN ON GSTEP ISTEP STEP UNTIL WHILE SUCHTHAT))
            (|repeat_tran| (CDR |l|) (CONS (CAR |l|) |lp|)))
           ('T (CONS (NREVERSE |lp|) (MKPF |l| 'PROGN)))))))

; expandCOLLECT(l) ==
;     [conds, :body] := repeat_tran(l, [])
;     -- create init of accumulate
;     init := ["SPADLET", G := GENSYM(), []]
;     ASSOC("EXIT", conds) => BREAK()
;     res := ["NREVERSE", G]
;     -- next code to accumulate result
;     acc := ["SETQ", G, ["CONS", body, G]]
;     ["PROGN", init, ["REPEAT", ["EXIT", res], :conds, acc]]

(DEFUN |expandCOLLECT| (|l|)
  (PROG (|LETTMP#1| |conds| |body| G |init| |res| |acc|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|repeat_tran| |l| NIL))
      (SETQ |conds| (CAR |LETTMP#1|))
      (SETQ |body| (CDR |LETTMP#1|))
      (SETQ |init| (LIST 'SPADLET (SETQ G (GENSYM)) NIL))
      (COND ((ASSOC 'EXIT |conds|) (BREAK))
            ('T
             (PROGN
              (SETQ |res| (LIST 'NREVERSE G))
              (SETQ |acc| (LIST 'SETQ G (LIST 'CONS |body| G)))
              (LIST 'PROGN |init|
                    (CONS 'REPEAT
                          (CONS (LIST 'EXIT |res|)
                                (APPEND |conds| (CONS |acc| NIL))))))))))))

; BADDO(OL) == ERROR(FORMAT(nil, '"BAD DO FORMAT~%~A", OL))

(DEFUN BADDO (OL)
  (PROG () (RETURN (ERROR (FORMAT NIL "BAD DO FORMAT~%~A" OL)))))

; arg_type(v) ==
;     p := position(v, $function_args)
;     p < 0 => nil
;     t := NTH(p, rest($signatureOfForm))
;     [v, :t]

(DEFUN |arg_type| (|v|)
  (PROG (|p| |t|)
    (RETURN
     (PROGN
      (SETQ |p| (|position| |v| |$function_args|))
      (COND ((MINUSP |p|) NIL)
            ('T
             (PROGN
              (SETQ |t| (NTH |p| (CDR |$signatureOfForm|)))
              (CONS |v| |t|))))))))

; has_typed_init(v) ==
;     not($insideCapsuleFunctionIfTrue) => nil
;     tv := ASSOC(v, $locVarsTypes) or arg_type(v)
;     NULL(tv) => nil
;     vt := [v, rest(tv)]
;     GetLispValue(vt)

(DEFUN |has_typed_init| (|v|)
  (PROG (|tv| |vt|)
    (RETURN
     (COND ((NULL |$insideCapsuleFunctionIfTrue|) NIL)
           (#1='T
            (PROGN
             (SETQ |tv| (OR (ASSOC |v| |$locVarsTypes|) (|arg_type| |v|)))
             (COND ((NULL |tv|) NIL)
                   (#1#
                    (PROGN
                     (SETQ |vt| (LIST |v| (CDR |tv|)))
                     (|GetLispValue| |vt|))))))))))

; expandDO(vl, endtest, exitforms, body_forms) ==
;     vars := []
;     u_vars := []
;     u_vals := []
;     inits := []
;     for vi in vl repeat
;         [v, :init_pom] := vi
;         not(IDENTP(v)) => BADDO(OL)
;         NULL(init_pom) and has_typed_init(v) => "iterate"
;         init :=
;             NULL(init_pom) => nil
;             first(init_pom)
;         vars := [v, :vars]
;         inits := [init, :inits]
;         if vi is [., ., u_val] then
;             u_vars := [v, :u_vars]
;             u_vals := [u_val, :u_vals]
;     if endtest then endtest := ["COND", [endtest, ["GO", "G191"]]]
;     exitforms := ["EXIT", exitforms]
;     u_vars3 := nil
;     for vv in u_vars for uu in u_vals repeat
;         u_vars3 :=
;             NULL(u_vars3) => ["SETQ", vv, uu]
;             ["SETQ", vv, ["PROG1", uu, u_vars3]]
;     lets := [["SPADLET", var, init] for var in vars for init in inits]
;     ["SEQ", :lets, :["G190", endtest, body_forms,
;           u_vars3, ["GO", "G190"], "G191", exitforms]]

(DEFUN |expandDO| (|vl| |endtest| |exitforms| |body_forms|)
  (PROG (|vars| |u_vars| |u_vals| |inits| |v| |init_pom| |init| |ISTMP#1|
         |ISTMP#2| |u_val| |u_vars3| |lets|)
    (RETURN
     (PROGN
      (SETQ |vars| NIL)
      (SETQ |u_vars| NIL)
      (SETQ |u_vals| NIL)
      (SETQ |inits| NIL)
      ((LAMBDA (|bfVar#14| |vi|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#14|) (PROGN (SETQ |vi| (CAR |bfVar#14|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |v| (CAR |vi|))
             (SETQ |init_pom| (CDR |vi|))
             (COND ((NULL (IDENTP |v|)) (BADDO OL))
                   ((AND (NULL |init_pom|) (|has_typed_init| |v|)) '|iterate|)
                   (#1#
                    (PROGN
                     (SETQ |init|
                             (COND ((NULL |init_pom|) NIL)
                                   (#1# (CAR |init_pom|))))
                     (SETQ |vars| (CONS |v| |vars|))
                     (SETQ |inits| (CONS |init| |inits|))
                     (COND
                      ((AND (CONSP |vi|)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |vi|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |u_val| (CAR |ISTMP#2|))
                                         #1#))))))
                       (SETQ |u_vars| (CONS |v| |u_vars|))
                       (SETQ |u_vals| (CONS |u_val| |u_vals|))))))))))
          (SETQ |bfVar#14| (CDR |bfVar#14|))))
       |vl| NIL)
      (COND
       (|endtest|
        (SETQ |endtest| (LIST 'COND (LIST |endtest| (LIST 'GO 'G191))))))
      (SETQ |exitforms| (LIST 'EXIT |exitforms|))
      (SETQ |u_vars3| NIL)
      ((LAMBDA (|bfVar#15| |vv| |bfVar#16| |uu|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#15|) (PROGN (SETQ |vv| (CAR |bfVar#15|)) NIL)
                (ATOM |bfVar#16|) (PROGN (SETQ |uu| (CAR |bfVar#16|)) NIL))
            (RETURN NIL))
           (#1#
            (SETQ |u_vars3|
                    (COND ((NULL |u_vars3|) (LIST 'SETQ |vv| |uu|))
                          (#1#
                           (LIST 'SETQ |vv| (LIST 'PROG1 |uu| |u_vars3|)))))))
          (SETQ |bfVar#15| (CDR |bfVar#15|))
          (SETQ |bfVar#16| (CDR |bfVar#16|))))
       |u_vars| NIL |u_vals| NIL)
      (SETQ |lets|
              ((LAMBDA (|bfVar#19| |bfVar#17| |var| |bfVar#18| |init|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#17|)
                        (PROGN (SETQ |var| (CAR |bfVar#17|)) NIL)
                        (ATOM |bfVar#18|)
                        (PROGN (SETQ |init| (CAR |bfVar#18|)) NIL))
                    (RETURN (NREVERSE |bfVar#19|)))
                   (#1#
                    (SETQ |bfVar#19|
                            (CONS (LIST 'SPADLET |var| |init|) |bfVar#19|))))
                  (SETQ |bfVar#17| (CDR |bfVar#17|))
                  (SETQ |bfVar#18| (CDR |bfVar#18|))))
               NIL |vars| NIL |inits| NIL))
      (CONS 'SEQ
            (APPEND |lets|
                    (LIST 'G190 |endtest| |body_forms| |u_vars3|
                          (LIST 'GO 'G190) 'G191 |exitforms|)))))))

; seq_opt(seq) ==
;    seq is ["SEQ", ["EXIT", body]] and body is ["SEQ",:.] => body
;    seq

(DEFUN |seq_opt| (|seq|)
  (PROG (|ISTMP#1| |ISTMP#2| |ISTMP#3| |body|)
    (RETURN
     (COND
      ((AND (CONSP |seq|) (EQ (CAR |seq|) 'SEQ)
            (PROGN
             (SETQ |ISTMP#1| (CDR |seq|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) 'EXIT)
                        (PROGN
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |body| (CAR |ISTMP#3|)) #1='T)))))))
            (CONSP |body|) (EQ (CAR |body|) 'SEQ))
       |body|)
      (#1# |seq|)))))

; MK_inc_SI(x) ==
;     ATOM(x) => ['inc_SI, x]
;     x is [op, xx, 1] and (op = 'sub_SI or op = "-") => xx
;     ['inc_SI, x]

(DEFUN |MK_inc_SI| (|x|)
  (PROG (|op| |ISTMP#1| |xx| |ISTMP#2|)
    (RETURN
     (COND ((ATOM |x|) (LIST '|inc_SI| |x|))
           ((AND (CONSP |x|)
                 (PROGN
                  (SETQ |op| (CAR |x|))
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |xx| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (EQUAL (CAR |ISTMP#2|) 1)))))
                 (OR (EQ |op| '|sub_SI|) (EQ |op| '-)))
            |xx|)
           ('T (LIST '|inc_SI| |x|))))))

; $TRACELETFLAG := false

(EVAL-WHEN (EVAL LOAD) (SETQ $TRACELETFLAG NIL))

; expandREPEAT(l) ==
;     [conds, :body] := repeat_tran(l, [])
;     tests := []
;     vl := []
;     result_expr := nil
;     for X in conds repeat
;         ATOM(X) => BREAK()
;         U := rest(X)
;         -- A hack to increase the likelihood of small integers
;         if X is ["STEP", ., i1, i2, :.] and member(i1, '(2 1 0 (One) (Zero)))
;            and member(i2, '(1 (One))) then X := ["ISTEP", :U]
;         op := first(X)
;         op = "GSTEP" =>
;             [var, empty_form, step_form, init_form] := U
;             tests := [["OR", ["SPADCALL", empty_form],
;                              ["PROGN", ["SETQ", var, ["SPADCALL", step_form]],
;                                   nil]], :tests]
;             vl := [[var, init_form], :vl]
;         op = "STEP" =>
;             [var, start, inc, :op_limit] := U
;             -- If not constant compute only once
;             if not(INTEGERP(inc)) then
;                 vl := [[(tmp := GENSYM()), inc], :vl]
;                 inc := tmp
;             if op_limit then
;                 -- If not constant compute only once
;                 if not(INTEGERP(final := first(op_limit))) then
;                     vl := [[(tmp := GENSYM()), final], :vl]
;                     final := tmp
;                 tests :=
;                   [(INTEGERP(inc) =>
;                      [(MINUSP(inc) => "<" ; ">"), var, final];
;                         ["IF", ["MINUSP", inc],
;                           ["<", var, final],
;                             [">", var, final]]),
;                               :tests]
;             vl := [[var, start, ["+", var, inc]], :vl]
;         op = "ISTEP" =>
;             [var, start, inc, :op_limit] := U
;             -- If not constant compute only once
;             if not(INTEGERP(inc)) then
;                 vl := [[(tmp := GENSYM()), inc], :vl]
;                 inc := tmp
;             if op_limit then
;                 if not(INTEGERP(final := first(op_limit))) then
;                     -- If not constant compute only once
;                     vl := [[(tmp := GENSYM()), final], :vl]
;                     final := tmp
;                 tests :=
;                   [(INTEGERP(inc) =>
;                      [(negative?_SI(inc) => "less_SI" ; "greater_SI"),
;                        var, final];
;                         ["IF", ["negative?_SI", inc],
;                           ["less_SI", var, final],
;                             ["greater_SI", var, final]]),
;                               :tests]
;             vl := [[var, start,
;                  (member(inc, '(1 (One))) => MK_inc_SI(first(U));
;                    ["add_SI", var, inc])], :vl]
;         op = "ON" =>
;             tests := [["ATOM", first(U)], :tests]
;             vl := [[first(U), CADR(U), ["CDR", first(U)]], :vl]
;         op = "RESET" => tests := [["PROGN", first(U), nil], :tests]
;         op = "IN" =>
;             tt :=
;                 SYMBOLP(first(U)) and SYMBOL_-PACKAGE(first(U))
;                   and $TRACELETFLAG =>
;                     [["/TRACELET-PRINT", first(U), (first U)]]
;                 nil
;             tests := [["OR", ["ATOM", (G := GENSYM())],
;                              ["PROGN", ["SETQ", first(U), ["CAR", G]],
;                                :APPEND(tt, [nil])]], :tests]
;             vl := [[G, CADR(U), ["CDR", G]], :vl]
;             vl := [[first(U)], :vl]
;         op = "UNTIL" =>
;             G := GENSYM()
;             tests := [G, :tests]
;             vl := [[G, nil, first(U)], :vl]
;         op = "WHILE" => tests := [["NULL", first(U)], :tests]
;         op = "SUCHTHAT" => body := ["COND", [first(U), body]]
;         op = "EXIT" =>
;             result_expr => BREAK()
;             result_expr := first(U)
;         FAIL()
;     expandDO(NREVERSE(vl), MKPF(NREVERSE(tests), "OR"), result_expr,
;              seq_opt(["SEQ", ["EXIT", body]]))

(DEFUN |expandREPEAT| (|l|)
  (PROG (|LETTMP#1| |conds| |body| |tests| |vl| |result_expr| U |ISTMP#1|
         |ISTMP#2| |i1| |ISTMP#3| |i2| |op| |var| |empty_form| |step_form|
         |init_form| |start| |inc| |op_limit| |tmp| |final| |tt| G)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|repeat_tran| |l| NIL))
      (SETQ |conds| (CAR |LETTMP#1|))
      (SETQ |body| (CDR |LETTMP#1|))
      (SETQ |tests| NIL)
      (SETQ |vl| NIL)
      (SETQ |result_expr| NIL)
      ((LAMBDA (|bfVar#20| X)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#20|) (PROGN (SETQ X (CAR |bfVar#20|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND ((ATOM X) (BREAK))
                  (#1#
                   (PROGN
                    (SETQ U (CDR X))
                    (COND
                     ((AND (CONSP X) (EQ (CAR X) 'STEP)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR X))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (PROGN
                                        (SETQ |i1| (CAR |ISTMP#2|))
                                        (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                        (AND (CONSP |ISTMP#3|)
                                             (PROGN
                                              (SETQ |i2| (CAR |ISTMP#3|))
                                              #1#)))))))
                           (|member| |i1| '(2 1 0 (|One|) (|Zero|)))
                           (|member| |i2| '(1 (|One|))))
                      (SETQ X (CONS 'ISTEP U))))
                    (SETQ |op| (CAR X))
                    (COND
                     ((EQ |op| 'GSTEP)
                      (PROGN
                       (SETQ |var| (CAR U))
                       (SETQ |empty_form| (CADR . #2=(U)))
                       (SETQ |step_form| (CADDR . #2#))
                       (SETQ |init_form| (CADDDR . #2#))
                       (SETQ |tests|
                               (CONS
                                (LIST 'OR (LIST 'SPADCALL |empty_form|)
                                      (LIST 'PROGN
                                            (LIST 'SETQ |var|
                                                  (LIST 'SPADCALL |step_form|))
                                            NIL))
                                |tests|))
                       (SETQ |vl| (CONS (LIST |var| |init_form|) |vl|))))
                     ((EQ |op| 'STEP)
                      (PROGN
                       (SETQ |var| (CAR U))
                       (SETQ |start| (CADR . #3=(U)))
                       (SETQ |inc| (CADDR . #3#))
                       (SETQ |op_limit| (CDDDR . #3#))
                       (COND
                        ((NULL (INTEGERP |inc|))
                         (SETQ |vl|
                                 (CONS (LIST (SETQ |tmp| (GENSYM)) |inc|)
                                       |vl|))
                         (SETQ |inc| |tmp|)))
                       (COND
                        (|op_limit|
                         (COND
                          ((NULL (INTEGERP (SETQ |final| (CAR |op_limit|))))
                           (SETQ |vl|
                                   (CONS (LIST (SETQ |tmp| (GENSYM)) |final|)
                                         |vl|))
                           (SETQ |final| |tmp|)))
                         (SETQ |tests|
                                 (CONS
                                  (COND
                                   ((INTEGERP |inc|)
                                    (LIST (COND ((MINUSP |inc|) '<) (#1# '>))
                                          |var| |final|))
                                   (#1#
                                    (LIST 'IF (LIST 'MINUSP |inc|)
                                          (LIST '< |var| |final|)
                                          (LIST '> |var| |final|))))
                                  |tests|))))
                       (SETQ |vl|
                               (CONS (LIST |var| |start| (LIST '+ |var| |inc|))
                                     |vl|))))
                     ((EQ |op| 'ISTEP)
                      (PROGN
                       (SETQ |var| (CAR U))
                       (SETQ |start| (CADR . #4=(U)))
                       (SETQ |inc| (CADDR . #4#))
                       (SETQ |op_limit| (CDDDR . #4#))
                       (COND
                        ((NULL (INTEGERP |inc|))
                         (SETQ |vl|
                                 (CONS (LIST (SETQ |tmp| (GENSYM)) |inc|)
                                       |vl|))
                         (SETQ |inc| |tmp|)))
                       (COND
                        (|op_limit|
                         (COND
                          ((NULL (INTEGERP (SETQ |final| (CAR |op_limit|))))
                           (SETQ |vl|
                                   (CONS (LIST (SETQ |tmp| (GENSYM)) |final|)
                                         |vl|))
                           (SETQ |final| |tmp|)))
                         (SETQ |tests|
                                 (CONS
                                  (COND
                                   ((INTEGERP |inc|)
                                    (LIST
                                     (COND ((|negative?_SI| |inc|) '|less_SI|)
                                           (#1# '|greater_SI|))
                                     |var| |final|))
                                   (#1#
                                    (LIST 'IF (LIST '|negative?_SI| |inc|)
                                          (LIST '|less_SI| |var| |final|)
                                          (LIST '|greater_SI| |var| |final|))))
                                  |tests|))))
                       (SETQ |vl|
                               (CONS
                                (LIST |var| |start|
                                      (COND
                                       ((|member| |inc| '(1 (|One|)))
                                        (|MK_inc_SI| (CAR U)))
                                       (#1# (LIST '|add_SI| |var| |inc|))))
                                |vl|))))
                     ((EQ |op| 'ON)
                      (PROGN
                       (SETQ |tests| (CONS (LIST 'ATOM (CAR U)) |tests|))
                       (SETQ |vl|
                               (CONS
                                (LIST (CAR U) (CADR U) (LIST 'CDR (CAR U)))
                                |vl|))))
                     ((EQ |op| 'RESET)
                      (SETQ |tests| (CONS (LIST 'PROGN (CAR U) NIL) |tests|)))
                     ((EQ |op| 'IN)
                      (PROGN
                       (SETQ |tt|
                               (COND
                                ((AND (SYMBOLP (CAR U))
                                      (SYMBOL-PACKAGE (CAR U)) $TRACELETFLAG)
                                 (LIST
                                  (LIST '/TRACELET-PRINT (CAR U) (CAR U))))
                                (#1# NIL)))
                       (SETQ |tests|
                               (CONS
                                (LIST 'OR (LIST 'ATOM (SETQ G (GENSYM)))
                                      (CONS 'PROGN
                                            (CONS
                                             (LIST 'SETQ (CAR U) (LIST 'CAR G))
                                             (APPEND |tt| (LIST NIL)))))
                                |tests|))
                       (SETQ |vl| (CONS (LIST G (CADR U) (LIST 'CDR G)) |vl|))
                       (SETQ |vl| (CONS (LIST (CAR U)) |vl|))))
                     ((EQ |op| 'UNTIL)
                      (PROGN
                       (SETQ G (GENSYM))
                       (SETQ |tests| (CONS G |tests|))
                       (SETQ |vl| (CONS (LIST G NIL (CAR U)) |vl|))))
                     ((EQ |op| 'WHILE)
                      (SETQ |tests| (CONS (LIST 'NULL (CAR U)) |tests|)))
                     ((EQ |op| 'SUCHTHAT)
                      (SETQ |body| (LIST 'COND (LIST (CAR U) |body|))))
                     ((EQ |op| 'EXIT)
                      (COND (|result_expr| (BREAK))
                            (#1# (SETQ |result_expr| (CAR U)))))
                     (#1# (FAIL))))))))
          (SETQ |bfVar#20| (CDR |bfVar#20|))))
       |conds| NIL)
      (|expandDO| (NREVERSE |vl|) (MKPF (NREVERSE |tests|) 'OR) |result_expr|
       (|seq_opt| (LIST 'SEQ (LIST 'EXIT |body|))))))))

; expandCOLLECTV(l) ==
;     -- If we can work out how often we will go round allocate a vector first
;     conds :=  []
;     [body, :iters] := REVERSE(l)
;     counter_var := nil
;     ret_val := nil
;     for iter in iters repeat
;         op := first(iter)
;         op in '(SUCHTHAT WHILE UNTIL GSTEP) =>
;             ret_val := ["LIST2VEC", ["COLLECT", :l]]
;             return nil -- break loop
;         op in '(IN ON) =>
;             conds := [["SIZE", CADDR(iter)], :conds]
;         op in '(STEP ISTEP) =>
;             [., var, start, step, :opt_limit] := iter
;             if start = 0 and step = 1 then
;                 counter_var := var
;             -- there may not be a limit
;             if opt_limit then
;                 limit := first(opt_limit)
;                 cond :=
;                     step = 1 =>
;                         start = 1 => limit
;                         start = 0 => MK_inc_SI(limit)
;                         MK_inc_SI(["-", limit, start])
;                     start = 1 => ["/", limit, step]
;                     start = 0 => ["/", MK_inc_SI(limit), step]
;                     ["/", ["-", MK_inc_SI(limit), start],
;                                             step]
;                 conds := [cond, :conds]
;         ERROR('"Cannot handle COLLECTV expansion")
;     ret_val => ret_val
;     if NULL(counter_var) then
;         counter_var := GENSYM()
;         iters := [["ISTEP", counter_var, 0, 1], :iters]
;     lv :=
;         NULL(conds) => FAIL()
;         NULL(rest(conds)) => first(conds)
;         ["MIN", :conds]
;     res := GENSYM()
;     ["PROGN", ["SPADLET", res, ["GETREFV", lv]],
;               ["REPEAT", :iters, ["SETELT", res, counter_var, body]],
;                  res]

(DEFUN |expandCOLLECTV| (|l|)
  (PROG (|conds| |LETTMP#1| |body| |iters| |counter_var| |ret_val| |op| |var|
         |start| |step| |opt_limit| |limit| |cond| |lv| |res|)
    (RETURN
     (PROGN
      (SETQ |conds| NIL)
      (SETQ |LETTMP#1| (REVERSE |l|))
      (SETQ |body| (CAR |LETTMP#1|))
      (SETQ |iters| (CDR |LETTMP#1|))
      (SETQ |counter_var| NIL)
      (SETQ |ret_val| NIL)
      ((LAMBDA (|bfVar#21| |iter|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#21|) (PROGN (SETQ |iter| (CAR |bfVar#21|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |op| (CAR |iter|))
             (COND
              ((|member| |op| '(SUCHTHAT WHILE UNTIL GSTEP))
               (PROGN
                (SETQ |ret_val| (LIST 'LIST2VEC (CONS 'COLLECT |l|)))
                (RETURN NIL)))
              ((|member| |op| '(IN ON))
               (SETQ |conds| (CONS (LIST 'SIZE (CADDR |iter|)) |conds|)))
              ((|member| |op| '(STEP ISTEP))
               (PROGN
                (SETQ |var| (CADR . #2=(|iter|)))
                (SETQ |start| (CADDR . #2#))
                (SETQ |step| (CADDDR . #2#))
                (SETQ |opt_limit| (CDDDDR . #2#))
                (COND
                 ((AND (EQL |start| 0) (EQL |step| 1))
                  (SETQ |counter_var| |var|)))
                (COND
                 (|opt_limit| (SETQ |limit| (CAR |opt_limit|))
                  (SETQ |cond|
                          (COND
                           ((EQL |step| 1)
                            (COND ((EQL |start| 1) |limit|)
                                  ((EQL |start| 0) (|MK_inc_SI| |limit|))
                                  (#1#
                                   (|MK_inc_SI| (LIST '- |limit| |start|)))))
                           ((EQL |start| 1) (LIST '/ |limit| |step|))
                           ((EQL |start| 0)
                            (LIST '/ (|MK_inc_SI| |limit|) |step|))
                           (#1#
                            (LIST '/ (LIST '- (|MK_inc_SI| |limit|) |start|)
                                  |step|))))
                  (SETQ |conds| (CONS |cond| |conds|))))))
              (#1# (ERROR "Cannot handle COLLECTV expansion"))))))
          (SETQ |bfVar#21| (CDR |bfVar#21|))))
       |iters| NIL)
      (COND (|ret_val| |ret_val|)
            (#1#
             (PROGN
              (COND
               ((NULL |counter_var|) (SETQ |counter_var| (GENSYM))
                (SETQ |iters| (CONS (LIST 'ISTEP |counter_var| 0 1) |iters|))))
              (SETQ |lv|
                      (COND ((NULL |conds|) (FAIL))
                            ((NULL (CDR |conds|)) (CAR |conds|))
                            (#1# (CONS 'MIN |conds|))))
              (SETQ |res| (GENSYM))
              (LIST 'PROGN (LIST 'SPADLET |res| (LIST 'GETREFV |lv|))
                    (CONS 'REPEAT
                          (APPEND |iters|
                                  (CONS
                                   (LIST 'SETELT |res| |counter_var| |body|)
                                   NIL)))
                    |res|))))))))

; DEFPARAMETER($comp370_apply, nil)

(DEFPARAMETER |$comp370_apply| NIL)

; COMP370(fn) ==
;     not(fn is [fname, [ltype, args, :body]]) => BREAK()
;     args :=
;         NULL(args) => args
;         LISTP(args) and $insideCapsuleFunctionIfTrue =>
;             [(STRINGP(CAR(arg)) => CONS(GENTEMP(), CDR(arg));
;               not(SYMBOLP(CAR(arg))) => BREAK();
;               arg)
;              for arg in args]
;         SYMBOLP(args) => ["&REST", args]
;         ATOM(args) => BREAK()
;         [(STRINGP(arg) => GENTEMP(); not(SYMBOLP(arg)) => BREAK(); arg)
;             for arg in args]
;     defun := if $insideCapsuleFunctionIfTrue then "SDEFUN" else "DEFUN"
;     nbody := [defun, fname, args, :body]
;     if $comp370_apply then
;         FUNCALL($comp370_apply, fname, nbody)

(DEFUN COMP370 (|fn|)
  (PROG (|fname| |ISTMP#1| |ISTMP#2| |ltype| |ISTMP#3| |args| |body| |defun|
         |nbody|)
    (RETURN
     (COND
      ((NULL
        (AND (CONSP |fn|)
             (PROGN
              (SETQ |fname| (CAR |fn|))
              (SETQ |ISTMP#1| (CDR |fn|))
              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                   (PROGN
                    (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN
                          (SETQ |ltype| (CAR |ISTMP#2|))
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|)
                               (PROGN
                                (SETQ |args| (CAR |ISTMP#3|))
                                (SETQ |body| (CDR |ISTMP#3|))
                                #1='T)))))))))
       (BREAK))
      (#1#
       (PROGN
        (SETQ |args|
                (COND ((NULL |args|) |args|)
                      ((AND (LISTP |args|) |$insideCapsuleFunctionIfTrue|)
                       ((LAMBDA (|bfVar#23| |bfVar#22| |arg|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#22|)
                                 (PROGN (SETQ |arg| (CAR |bfVar#22|)) NIL))
                             (RETURN (NREVERSE |bfVar#23|)))
                            (#1#
                             (SETQ |bfVar#23|
                                     (CONS
                                      (COND
                                       ((STRINGP (CAR |arg|))
                                        (CONS (GENTEMP) (CDR |arg|)))
                                       ((NULL (SYMBOLP (CAR |arg|))) (BREAK))
                                       (#1# |arg|))
                                      |bfVar#23|))))
                           (SETQ |bfVar#22| (CDR |bfVar#22|))))
                        NIL |args| NIL))
                      ((SYMBOLP |args|) (LIST '&REST |args|))
                      ((ATOM |args|) (BREAK))
                      (#1#
                       ((LAMBDA (|bfVar#25| |bfVar#24| |arg|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#24|)
                                 (PROGN (SETQ |arg| (CAR |bfVar#24|)) NIL))
                             (RETURN (NREVERSE |bfVar#25|)))
                            (#1#
                             (SETQ |bfVar#25|
                                     (CONS
                                      (COND ((STRINGP |arg|) (GENTEMP))
                                            ((NULL (SYMBOLP |arg|)) (BREAK))
                                            (#1# |arg|))
                                      |bfVar#25|))))
                           (SETQ |bfVar#24| (CDR |bfVar#24|))))
                        NIL |args| NIL))))
        (SETQ |defun|
                (COND (|$insideCapsuleFunctionIfTrue| 'SDEFUN) (#1# 'DEFUN)))
        (SETQ |nbody| (CONS |defun| (CONS |fname| (CONS |args| |body|))))
        (COND
         (|$comp370_apply| (FUNCALL |$comp370_apply| |fname| |nbody|)))))))))

; MKPF(l, op) ==
;     if MEMQ(op, ["*", "+", "AND", "OR", "PROGN"]) then
;         l := MKPFFLATTEN1(l, op, nil)
;     MKPF1(l, op)

(DEFUN MKPF (|l| |op|)
  (PROG ()
    (RETURN
     (PROGN
      (COND
       ((MEMQ |op| (LIST '* '+ 'AND 'OR 'PROGN))
        (SETQ |l| (MKPFFLATTEN1 |l| |op| NIL))))
      (MKPF1 |l| |op|)))))

; MKPFFLATTEN(x, op) ==
;     ATOM(x) => x
;     EQL(first(x), op) => [op, :MKPFFLATTEN1(rest x, op, nil)]
;     [MKPFFLATTEN(first x, op), :MKPFFLATTEN(rest x, op)]

(DEFUN MKPFFLATTEN (|x| |op|)
  (PROG ()
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((EQL (CAR |x|) |op|) (CONS |op| (MKPFFLATTEN1 (CDR |x|) |op| NIL)))
           ('T
            (CONS (MKPFFLATTEN (CAR |x|) |op|)
                  (MKPFFLATTEN (CDR |x|) |op|)))))))

; MKPFFLATTEN1(l, op, r) ==
;     NULL(l) => r
;     x := MKPFFLATTEN(first(l), op)
;     MKPFFLATTEN1(rest l, op, APPEND(r, (x is [=op, :r1] => r1; [x])))

(DEFUN MKPFFLATTEN1 (|l| |op| |r|)
  (PROG (|x| |r1|)
    (RETURN
     (COND ((NULL |l|) |r|)
           (#1='T
            (PROGN
             (SETQ |x| (MKPFFLATTEN (CAR |l|) |op|))
             (MKPFFLATTEN1 (CDR |l|) |op|
              (APPEND |r|
                      (COND
                       ((AND (CONSP |x|) (EQUAL (CAR |x|) |op|)
                             (PROGN (SETQ |r1| (CDR |x|)) #1#))
                        |r1|)
                       (#1# (LIST |x|)))))))))))

; MKPF1(l, op) ==
;     op = "PLUS" => BREAK()
;     op = "TIMES" => BREAK()
;     op = "QUOTIENT" => BREAK()
;     op = "MINUS" => BREAK()
;     op = "DIFFERENCE" => BREAK()
;     op = "EXPT" =>
;         l is [x, y] =>
;             EQL(y, 0) => 1
;             EQL(y, 1) => x
;             member(x, '(0 1 (ZERO) (ONE))) => x
;             ["EXPT", :l]
;         FAIL()
;     op = "OR" =>
;         MEMBER(true, l) => ["QUOTE", true]
;         l := REMOVE(false, l)
;         NULL(l) => false
;         rest(l) => ["OR", :l]
;         first(l)
;     op = "or" =>
;         MEMBER(true, l) => true
;         l := REMOVE(false, l)
;         NULL(l) => false
;         rest(l) => ["or", :l]
;         first(l)
;     op = "NULL" =>
;         rest(l) => FAIL()
;         l is [["NULL", :l1]] => first(l1)
;         first(l) = true => false
;         NULL(first(l)) => ["QUOTE", true]
;         ["NULL", :l]
;     op = "and" =>
;         l := REMOVE(true, REMOVE("true", l))
;         NULL(l) => true
;         rest(l) => ["and", :l]
;         first(l)
;     op = "AND" =>
;         l := REMOVE(true, REMOVE("true", l))
;         NULL(l) => ["QUOTE", true]
;         rest(l) => ["AND", :l]
;         first(l)
;     op = "PROGN" =>
;         l := REMOVE(nil, l)
;         NULL(l) => nil
;         rest(l) => ["PROGN", :l]
;         first(l)
;     op = "SEQ" =>
;         l is [["EXIT", :l1], :.] => first(l1)
;         rest(l) => ["SEQ", :l]
;         first(l)
;     op = "LIST" =>
;         l => ["LIST", :l]
;         nil
;     op = "CONS" =>
;         rest(l) => ["CONS", :l]
;         first(l)
;     [op, :l]

(DEFUN MKPF1 (|l| |op|)
  (PROG (|x| |ISTMP#1| |y| |l1|)
    (RETURN
     (COND ((EQ |op| 'PLUS) (BREAK)) ((EQ |op| 'TIMES) (BREAK))
           ((EQ |op| 'QUOTIENT) (BREAK)) ((EQ |op| 'MINUS) (BREAK))
           ((EQ |op| 'DIFFERENCE) (BREAK))
           ((EQ |op| 'EXPT)
            (COND
             ((AND (CONSP |l|)
                   (PROGN
                    (SETQ |x| (CAR |l|))
                    (SETQ |ISTMP#1| (CDR |l|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1='T))))
              (COND ((EQL |y| 0) 1) ((EQL |y| 1) |x|)
                    ((|member| |x| '(0 1 (ZERO) (ONE))) |x|)
                    (#1# (CONS 'EXPT |l|))))
             (#1# (FAIL))))
           ((EQ |op| 'OR)
            (COND ((MEMBER T |l|) (LIST 'QUOTE T))
                  (#1#
                   (PROGN
                    (SETQ |l| (REMOVE NIL |l|))
                    (COND ((NULL |l|) NIL) ((CDR |l|) (CONS 'OR |l|))
                          (#1# (CAR |l|)))))))
           ((EQ |op| '|or|)
            (COND ((MEMBER T |l|) T)
                  (#1#
                   (PROGN
                    (SETQ |l| (REMOVE NIL |l|))
                    (COND ((NULL |l|) NIL) ((CDR |l|) (CONS '|or| |l|))
                          (#1# (CAR |l|)))))))
           ((EQ |op| 'NULL)
            (COND ((CDR |l|) (FAIL))
                  ((AND (CONSP |l|) (EQ (CDR |l|) NIL)
                        (PROGN
                         (SETQ |ISTMP#1| (CAR |l|))
                         (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'NULL)
                              (PROGN (SETQ |l1| (CDR |ISTMP#1|)) #1#))))
                   (CAR |l1|))
                  ((EQUAL (CAR |l|) T) NIL) ((NULL (CAR |l|)) (LIST 'QUOTE T))
                  (#1# (CONS 'NULL |l|))))
           ((EQ |op| '|and|)
            (PROGN
             (SETQ |l| (REMOVE T (REMOVE '|true| |l|)))
             (COND ((NULL |l|) T) ((CDR |l|) (CONS '|and| |l|))
                   (#1# (CAR |l|)))))
           ((EQ |op| 'AND)
            (PROGN
             (SETQ |l| (REMOVE T (REMOVE '|true| |l|)))
             (COND ((NULL |l|) (LIST 'QUOTE T)) ((CDR |l|) (CONS 'AND |l|))
                   (#1# (CAR |l|)))))
           ((EQ |op| 'PROGN)
            (PROGN
             (SETQ |l| (REMOVE NIL |l|))
             (COND ((NULL |l|) NIL) ((CDR |l|) (CONS 'PROGN |l|))
                   (#1# (CAR |l|)))))
           ((EQ |op| 'SEQ)
            (COND
             ((AND (CONSP |l|)
                   (PROGN
                    (SETQ |ISTMP#1| (CAR |l|))
                    (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'EXIT)
                         (PROGN (SETQ |l1| (CDR |ISTMP#1|)) #1#))))
              (CAR |l1|))
             ((CDR |l|) (CONS 'SEQ |l|)) (#1# (CAR |l|))))
           ((EQ |op| 'LIST) (COND (|l| (CONS 'LIST |l|)) (#1# NIL)))
           ((EQ |op| 'CONS)
            (COND ((CDR |l|) (CONS 'CONS |l|)) (#1# (CAR |l|))))
           (#1# (CONS |op| |l|))))))

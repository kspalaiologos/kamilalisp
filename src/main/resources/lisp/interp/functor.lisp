
; )package "BOOT"

(IN-PACKAGE "BOOT")

; mkDevaluate a ==
;   null a => nil
;   a is ['QUOTE,a'] => (a' => a; nil)
;   a='$ => MKQ '$
;   a is ['LIST] => nil
;   a is ['LIST,:.] => a
;   ['devaluate,a]

(DEFUN |mkDevaluate| (|a|)
  (PROG (|ISTMP#1| |a'|)
    (RETURN
     (COND ((NULL |a|) NIL)
           ((AND (CONSP |a|) (EQ (CAR |a|) 'QUOTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |a|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |a'| (CAR |ISTMP#1|)) #1='T))))
            (COND (|a'| |a|) (#1# NIL)))
           ((EQ |a| '$) (MKQ '$))
           ((AND (CONSP |a|) (EQ (CDR |a|) NIL) (EQ (CAR |a|) 'LIST)) NIL)
           ((AND (CONSP |a|) (EQ (CAR |a|) 'LIST)) |a|)
           (#1# (LIST '|devaluate| |a|))))))

; compCategories(u, e) ==
;   ATOM u => u
;   not ATOM first u =>
;     error ['"compCategories: need an atom in operator position", first u]
;   first u = "Record" =>
;     -- There is no modemap property for these guys so do it by hand.
;       [first u, :[[":", a.1, compCategories1(a.2, '(SetCategory), e)]
;                    for a in rest u]]
;   first u = "Union" or first u = "Mapping" =>
;     -- There is no modemap property for these guys so do it by hand.
;       [first u, :[compCategories1(a, '(SetCategory), e) for a in rest u]]
;   u is ['SubDomain, D, .] => compCategories(D, e)
;   v := get(first u, 'modemap, e)
;   ATOM v =>
;     error ['"compCategories: could not get proper modemap for operator",first u]
;   rest v =>
;     error ['"compCategories: unexpected stuff at end of modemap",
;            rest v]
;   v:= CDDAAR v
;   v:=resolvePatternVars(v, rest u) -- replaces #n forms
;   -- select the modemap part of the first entry, and skip result etc.
;   u:=[first u, :[compCategories1(a, b, e) for a in rest u for b in v]]
;   u

(DEFUN |compCategories| (|u| |e|)
  (PROG (|ISTMP#1| D |ISTMP#2| |v|)
    (RETURN
     (COND ((ATOM |u|) |u|)
           ((NULL (ATOM (CAR |u|)))
            (|error|
             (LIST "compCategories: need an atom in operator position"
                   (CAR |u|))))
           ((EQ (CAR |u|) '|Record|)
            (CONS (CAR |u|)
                  ((LAMBDA (|bfVar#2| |bfVar#1| |a|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#1|)
                            (PROGN (SETQ |a| (CAR |bfVar#1|)) NIL))
                        (RETURN (NREVERSE |bfVar#2|)))
                       (#1='T
                        (SETQ |bfVar#2|
                                (CONS
                                 (LIST '|:| (ELT |a| 1)
                                       (|compCategories1| (ELT |a| 2)
                                        '(|SetCategory|) |e|))
                                 |bfVar#2|))))
                      (SETQ |bfVar#1| (CDR |bfVar#1|))))
                   NIL (CDR |u|) NIL)))
           ((OR (EQ (CAR |u|) '|Union|) (EQ (CAR |u|) '|Mapping|))
            (CONS (CAR |u|)
                  ((LAMBDA (|bfVar#4| |bfVar#3| |a|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#3|)
                            (PROGN (SETQ |a| (CAR |bfVar#3|)) NIL))
                        (RETURN (NREVERSE |bfVar#4|)))
                       (#1#
                        (SETQ |bfVar#4|
                                (CONS
                                 (|compCategories1| |a| '(|SetCategory|) |e|)
                                 |bfVar#4|))))
                      (SETQ |bfVar#3| (CDR |bfVar#3|))))
                   NIL (CDR |u|) NIL)))
           ((AND (CONSP |u|) (EQ (CAR |u|) '|SubDomain|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ D (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL))))))
            (|compCategories| D |e|))
           (#1#
            (PROGN
             (SETQ |v| (|get| (CAR |u|) '|modemap| |e|))
             (COND
              ((ATOM |v|)
               (|error|
                (LIST
                 "compCategories: could not get proper modemap for operator"
                 (CAR |u|))))
              ((CDR |v|)
               (|error|
                (LIST "compCategories: unexpected stuff at end of modemap"
                      (CDR |v|))))
              (#1#
               (PROGN
                (SETQ |v| (CDDAAR |v|))
                (SETQ |v| (|resolvePatternVars| |v| (CDR |u|)))
                (SETQ |u|
                        (CONS (CAR |u|)
                              ((LAMBDA (|bfVar#7| |bfVar#5| |a| |bfVar#6| |b|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#5|)
                                        (PROGN (SETQ |a| (CAR |bfVar#5|)) NIL)
                                        (ATOM |bfVar#6|)
                                        (PROGN (SETQ |b| (CAR |bfVar#6|)) NIL))
                                    (RETURN (NREVERSE |bfVar#7|)))
                                   (#1#
                                    (SETQ |bfVar#7|
                                            (CONS
                                             (|compCategories1| |a| |b| |e|)
                                             |bfVar#7|))))
                                  (SETQ |bfVar#5| (CDR |bfVar#5|))
                                  (SETQ |bfVar#6| (CDR |bfVar#6|))))
                               NIL (CDR |u|) NIL |v| NIL)))
                |u|)))))))))

; compCategories1(u, v, e) ==
; -- v is the mode of u
;   ATOM u => u
;   isCategoryForm(v) => compCategories(u, e)
;   [c, :.] := comp(macroExpand(u, e), v, e) => c
;   error 'compCategories1

(DEFUN |compCategories1| (|u| |v| |e|)
  (PROG (|LETTMP#1| |c|)
    (RETURN
     (COND ((ATOM |u|) |u|) ((|isCategoryForm| |v|) (|compCategories| |u| |e|))
           ((PROGN
             (SETQ |LETTMP#1| (|comp| (|macroExpand| |u| |e|) |v| |e|))
             (SETQ |c| (CAR |LETTMP#1|))
             |LETTMP#1|)
            |c|)
           ('T (|error| '|compCategories1|))))))

; optFunctorBody x ==
;   atom x => x
;   x is ['QUOTE,:l] => x
;   x is ['DomainSubstitutionMacro,parms,body] =>
;       optFunctorBody(DomainSubstitutionFunction($definition, parms, body))
;   x is ['LIST,:l] =>
;     null l => nil
;     l:= [optFunctorBody u for u in l]
;     and/[optFunctorBodyQuotable u for u in l] =>
;       ['QUOTE,[optFunctorBodyRequote u for u in l]]
;     l=rest x => x --CONS-saving hack
;     ['LIST,:l]
;   x is ['PROGN,:l] => ['PROGN,:optFunctorPROGN l]
;   x is ['COND,:l] =>
; --+
;     l:=
;       [CondClause u for u in l | u and first u] where
;         CondClause [pred,:conseq] ==
;           [optFunctorBody pred,:optFunctorPROGN conseq]
;     l:= EFFACE('((QUOTE T)),l)
;                    --delete any trailing ("T)
;     null l => nil
;     CAAR l='(QUOTE T) =>
;       (null CDAR l => nil; null CDDAR l => CADAR l; ["PROGN",:CDAR l])
;     null rest l and null CDAR l =>
;             --there is no meat to this COND
;       pred:= CAAR l
;       atom pred => nil
;       first pred="HasCategory" => nil
;       ['COND,:l]
;     ['COND,:l]
;   [optFunctorBody u for u in x]

(DEFUN |optFunctorBody| (|x|)
  (PROG (|l| |ISTMP#1| |parms| |ISTMP#2| |body| |pred|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)
                 (PROGN (SETQ |l| (CDR |x|)) #1='T))
            |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) '|DomainSubstitutionMacro|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |parms| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |body| (CAR |ISTMP#2|)) #1#))))))
            (|optFunctorBody|
             (|DomainSubstitutionFunction| |$definition| |parms| |body|)))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'LIST)
                 (PROGN (SETQ |l| (CDR |x|)) #1#))
            (COND ((NULL |l|) NIL)
                  (#1#
                   (PROGN
                    (SETQ |l|
                            ((LAMBDA (|bfVar#9| |bfVar#8| |u|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#8|)
                                      (PROGN (SETQ |u| (CAR |bfVar#8|)) NIL))
                                  (RETURN (NREVERSE |bfVar#9|)))
                                 (#1#
                                  (SETQ |bfVar#9|
                                          (CONS (|optFunctorBody| |u|)
                                                |bfVar#9|))))
                                (SETQ |bfVar#8| (CDR |bfVar#8|))))
                             NIL |l| NIL))
                    (COND
                     (((LAMBDA (|bfVar#11| |bfVar#10| |u|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#10|)
                                (PROGN (SETQ |u| (CAR |bfVar#10|)) NIL))
                            (RETURN |bfVar#11|))
                           (#1#
                            (PROGN
                             (SETQ |bfVar#11| (|optFunctorBodyQuotable| |u|))
                             (COND ((NOT |bfVar#11|) (RETURN NIL))))))
                          (SETQ |bfVar#10| (CDR |bfVar#10|))))
                       T |l| NIL)
                      (LIST 'QUOTE
                            ((LAMBDA (|bfVar#13| |bfVar#12| |u|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#12|)
                                      (PROGN (SETQ |u| (CAR |bfVar#12|)) NIL))
                                  (RETURN (NREVERSE |bfVar#13|)))
                                 (#1#
                                  (SETQ |bfVar#13|
                                          (CONS (|optFunctorBodyRequote| |u|)
                                                |bfVar#13|))))
                                (SETQ |bfVar#12| (CDR |bfVar#12|))))
                             NIL |l| NIL)))
                     ((EQUAL |l| (CDR |x|)) |x|) (#1# (CONS 'LIST |l|)))))))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'PROGN)
                 (PROGN (SETQ |l| (CDR |x|)) #1#))
            (CONS 'PROGN (|optFunctorPROGN| |l|)))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'COND)
                 (PROGN (SETQ |l| (CDR |x|)) #1#))
            (PROGN
             (SETQ |l|
                     ((LAMBDA (|bfVar#15| |bfVar#14| |u|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#14|)
                               (PROGN (SETQ |u| (CAR |bfVar#14|)) NIL))
                           (RETURN (NREVERSE |bfVar#15|)))
                          (#1#
                           (AND |u| (CAR |u|)
                                (SETQ |bfVar#15|
                                        (CONS (|optFunctorBody,CondClause| |u|)
                                              |bfVar#15|)))))
                         (SETQ |bfVar#14| (CDR |bfVar#14|))))
                      NIL |l| NIL))
             (SETQ |l| (EFFACE '('T) |l|))
             (COND ((NULL |l|) NIL)
                   ((EQUAL (CAAR |l|) ''T)
                    (COND ((NULL (CDAR |l|)) NIL)
                          ((NULL (CDDAR |l|)) (CADAR |l|))
                          (#1# (CONS 'PROGN (CDAR |l|)))))
                   ((AND (NULL (CDR |l|)) (NULL (CDAR |l|)))
                    (PROGN
                     (SETQ |pred| (CAAR |l|))
                     (COND ((ATOM |pred|) NIL)
                           ((EQ (CAR |pred|) '|HasCategory|) NIL)
                           (#1# (CONS 'COND |l|)))))
                   (#1# (CONS 'COND |l|)))))
           (#1#
            ((LAMBDA (|bfVar#17| |bfVar#16| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#16|)
                      (PROGN (SETQ |u| (CAR |bfVar#16|)) NIL))
                  (RETURN (NREVERSE |bfVar#17|)))
                 (#1#
                  (SETQ |bfVar#17| (CONS (|optFunctorBody| |u|) |bfVar#17|))))
                (SETQ |bfVar#16| (CDR |bfVar#16|))))
             NIL |x| NIL))))))
(DEFUN |optFunctorBody,CondClause| (|bfVar#18|)
  (PROG (|pred| |conseq|)
    (RETURN
     (PROGN
      (SETQ |pred| (CAR |bfVar#18|))
      (SETQ |conseq| (CDR |bfVar#18|))
      (CONS (|optFunctorBody| |pred|) (|optFunctorPROGN| |conseq|))))))

; optFunctorBodyQuotable u ==
;   null u => true
;   NUMBERP u => true
;   atom u => nil
;   u is ['QUOTE,:.] => true
;   nil

(DEFUN |optFunctorBodyQuotable| (|u|)
  (PROG ()
    (RETURN
     (COND ((NULL |u|) T) ((NUMBERP |u|) T) ((ATOM |u|) NIL)
           ((AND (CONSP |u|) (EQ (CAR |u|) 'QUOTE)) T) ('T NIL)))))

; optFunctorBodyRequote u ==
;   atom u => u
;   u is ['QUOTE,v] => v
;   systemErrorHere '"optFunctorBodyRequote"

(DEFUN |optFunctorBodyRequote| (|u|)
  (PROG (|ISTMP#1| |v|)
    (RETURN
     (COND ((ATOM |u|) |u|)
           ((AND (CONSP |u|) (EQ (CAR |u|) 'QUOTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |v| (CAR |ISTMP#1|)) #1='T))))
            |v|)
           (#1# (|systemErrorHere| "optFunctorBodyRequote"))))))

; optFunctorPROGN l ==
;   l is [x,:l'] =>
;     worthlessCode x => optFunctorPROGN l'
;     l':= optFunctorBody l'
;     l'=[nil] => [optFunctorBody x]
;     [optFunctorBody x,:l']
;   l

(DEFUN |optFunctorPROGN| (|l|)
  (PROG (|x| |l'|)
    (RETURN
     (COND
      ((AND (CONSP |l|)
            (PROGN (SETQ |x| (CAR |l|)) (SETQ |l'| (CDR |l|)) #1='T))
       (COND ((|worthlessCode| |x|) (|optFunctorPROGN| |l'|))
             (#1#
              (PROGN
               (SETQ |l'| (|optFunctorBody| |l'|))
               (COND ((EQUAL |l'| (LIST NIL)) (LIST (|optFunctorBody| |x|)))
                     (#1# (CONS (|optFunctorBody| |x|) |l'|)))))))
      (#1# |l|)))))

; worthlessCode x ==
;   x is ['COND,:l] and (and/[x is [.,y] and worthlessCode y for x in l]) => true
;   x is ['PROGN,:l] => (null (l':= optFunctorPROGN l) => true; false)
;   x is ['LIST] => true
;   null x => true
;   false

(DEFUN |worthlessCode| (|x|)
  (PROG (|l| |ISTMP#1| |y| |l'|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'COND) (PROGN (SETQ |l| (CDR |x|)) #1='T)
            ((LAMBDA (|bfVar#20| |bfVar#19| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#19|)
                      (PROGN (SETQ |x| (CAR |bfVar#19|)) NIL))
                  (RETURN |bfVar#20|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#20|
                           (AND (CONSP |x|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |x|))
                                 (AND (CONSP |ISTMP#1|)
                                      (EQ (CDR |ISTMP#1|) NIL)
                                      (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#)))
                                (|worthlessCode| |y|)))
                   (COND ((NOT |bfVar#20|) (RETURN NIL))))))
                (SETQ |bfVar#19| (CDR |bfVar#19|))))
             T |l| NIL))
       T)
      ((AND (CONSP |x|) (EQ (CAR |x|) 'PROGN) (PROGN (SETQ |l| (CDR |x|)) #1#))
       (COND ((NULL (SETQ |l'| (|optFunctorPROGN| |l|))) T) (#1# NIL)))
      ((AND (CONSP |x|) (EQ (CDR |x|) NIL) (EQ (CAR |x|) 'LIST)) T)
      ((NULL |x|) T) (#1# NIL)))))

; cons5(p,l) ==
;   l and (CAAR l = first p) => [p,: rest l]
;   LENGTH l < 5 => [p,:l]
;   RPLACD(QCDDR(QCDDR l), nil)
;   [p,:l]

(DEFUN |cons5| (|p| |l|)
  (PROG ()
    (RETURN
     (COND ((AND |l| (EQUAL (CAAR |l|) (CAR |p|))) (CONS |p| (CDR |l|)))
           ((< (LENGTH |l|) 5) (CONS |p| |l|))
           ('T (PROGN (RPLACD (QCDDR (QCDDR |l|)) NIL) (CONS |p| |l|)))))))

; mkDomainConstructor x ==
;   atom x => mkDevaluate x
;   x is ['Join] => nil
;   x is ['LIST] => nil
;   x is ['CATEGORY,:.] => MKQ x
;   x is ['mkCategory,:.] => MKQ x
;   x is ['_:,selector,dom] =>
;     ['LIST,MKQ '_:,MKQ selector,mkDomainConstructor dom]
;   x is ['Record,:argl] =>
;     ['LIST,MKQ 'Record,:[mkDomainConstructor y for y in argl]]
;   x is ['Join,:argl] =>
;     ['LIST,MKQ 'Join,:[mkDomainConstructor y for y in argl]]
;   x is [op] => MKQ x
;   x is [op,:argl] => ['LIST,MKQ op,:[mkDomainConstructor a for a in argl]]

(DEFUN |mkDomainConstructor| (|x|)
  (PROG (|ISTMP#1| |selector| |ISTMP#2| |dom| |argl| |op|)
    (RETURN
     (COND ((ATOM |x|) (|mkDevaluate| |x|))
           ((AND (CONSP |x|) (EQ (CDR |x|) NIL) (EQ (CAR |x|) '|Join|)) NIL)
           ((AND (CONSP |x|) (EQ (CDR |x|) NIL) (EQ (CAR |x|) 'LIST)) NIL)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'CATEGORY)) (MKQ |x|))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|mkCategory|)) (MKQ |x|))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|:|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |selector| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |dom| (CAR |ISTMP#2|)) #1='T))))))
            (LIST 'LIST (MKQ '|:|) (MKQ |selector|)
                  (|mkDomainConstructor| |dom|)))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|Record|)
                 (PROGN (SETQ |argl| (CDR |x|)) #1#))
            (CONS 'LIST
                  (CONS (MKQ '|Record|)
                        ((LAMBDA (|bfVar#22| |bfVar#21| |y|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#21|)
                                  (PROGN (SETQ |y| (CAR |bfVar#21|)) NIL))
                              (RETURN (NREVERSE |bfVar#22|)))
                             (#1#
                              (SETQ |bfVar#22|
                                      (CONS (|mkDomainConstructor| |y|)
                                            |bfVar#22|))))
                            (SETQ |bfVar#21| (CDR |bfVar#21|))))
                         NIL |argl| NIL))))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|Join|)
                 (PROGN (SETQ |argl| (CDR |x|)) #1#))
            (CONS 'LIST
                  (CONS (MKQ '|Join|)
                        ((LAMBDA (|bfVar#24| |bfVar#23| |y|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#23|)
                                  (PROGN (SETQ |y| (CAR |bfVar#23|)) NIL))
                              (RETURN (NREVERSE |bfVar#24|)))
                             (#1#
                              (SETQ |bfVar#24|
                                      (CONS (|mkDomainConstructor| |y|)
                                            |bfVar#24|))))
                            (SETQ |bfVar#23| (CDR |bfVar#23|))))
                         NIL |argl| NIL))))
           ((AND (CONSP |x|) (EQ (CDR |x|) NIL)
                 (PROGN (SETQ |op| (CAR |x|)) #1#))
            (MKQ |x|))
           ((AND (CONSP |x|)
                 (PROGN (SETQ |op| (CAR |x|)) (SETQ |argl| (CDR |x|)) #1#))
            (CONS 'LIST
                  (CONS (MKQ |op|)
                        ((LAMBDA (|bfVar#26| |bfVar#25| |a|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#25|)
                                  (PROGN (SETQ |a| (CAR |bfVar#25|)) NIL))
                              (RETURN (NREVERSE |bfVar#26|)))
                             (#1#
                              (SETQ |bfVar#26|
                                      (CONS (|mkDomainConstructor| |a|)
                                            |bfVar#26|))))
                            (SETQ |bfVar#25| (CDR |bfVar#25|))))
                         NIL |argl| NIL))))))))

; DescendCodeAdd(base, flag, kvec, e) ==
;   atom base => DescendCodeVarAdd(base, flag, kvec, e)
;   not (modemap:=get(opOf base,'modemap,$CategoryFrame)) =>
;       if getmode(opOf base, e) is ["Mapping", target, :formalArgModes]
;          then formalArgs:= take(#formalArgModes,$FormalMapVariableList)
;                 --argument substitution if parameterized?
;
;          else keyedSystemError("S2OR0001",[opOf base])
;       DescendCodeAdd1(base, flag, target, formalArgs, formalArgModes, kvec, e)
;   for [[[.,:formalArgs],target,:formalArgModes],.] in modemap repeat
;       (ans := DescendCodeAdd1(base, flag, target, formalArgs,
;                               formalArgModes, kvec, e)) => return ans
;   ans

(DEFUN |DescendCodeAdd| (|base| |flag| |kvec| |e|)
  (PROG (|modemap| |ISTMP#1| |ISTMP#2| |target| |formalArgModes| |formalArgs|
         |ISTMP#3| |ISTMP#4| |ans|)
    (RETURN
     (COND ((ATOM |base|) (|DescendCodeVarAdd| |base| |flag| |kvec| |e|))
           ((NULL
             (SETQ |modemap|
                     (|get| (|opOf| |base|) '|modemap| |$CategoryFrame|)))
            (PROGN
             (COND
              ((PROGN
                (SETQ |ISTMP#1| (|getmode| (|opOf| |base|) |e|))
                (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
                     (PROGN
                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                      (AND (CONSP |ISTMP#2|)
                           (PROGN
                            (SETQ |target| (CAR |ISTMP#2|))
                            (SETQ |formalArgModes| (CDR |ISTMP#2|))
                            #1='T)))))
               (SETQ |formalArgs|
                       (TAKE (LENGTH |formalArgModes|)
                        |$FormalMapVariableList|)))
              (#1# (|keyedSystemError| 'S2OR0001 (LIST (|opOf| |base|)))))
             (|DescendCodeAdd1| |base| |flag| |target| |formalArgs|
              |formalArgModes| |kvec| |e|)))
           (#1#
            (PROGN
             ((LAMBDA (|bfVar#28| |bfVar#27|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#28|)
                       (PROGN (SETQ |bfVar#27| (CAR |bfVar#28|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |bfVar#27|)
                        (PROGN
                         (SETQ |ISTMP#1| (CAR |bfVar#27|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|)
                                    (PROGN
                                     (SETQ |formalArgs| (CDR |ISTMP#2|))
                                     #1#)))
                              (PROGN
                               (SETQ |ISTMP#3| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#3|)
                                    (PROGN
                                     (SETQ |target| (CAR |ISTMP#3|))
                                     (SETQ |formalArgModes| (CDR |ISTMP#3|))
                                     #1#)))))
                        (PROGN
                         (SETQ |ISTMP#4| (CDR |bfVar#27|))
                         (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)))
                        (COND
                         ((SETQ |ans|
                                  (|DescendCodeAdd1| |base| |flag| |target|
                                   |formalArgs| |formalArgModes| |kvec| |e|))
                          (IDENTITY (RETURN |ans|)))))))
                 (SETQ |bfVar#28| (CDR |bfVar#28|))))
              |modemap| NIL)
             |ans|))))))

; DescendCodeAdd1(base, flag, target, formalArgs, formalArgModes, kvec, e) ==
;   slist:= pairList(formalArgs,rest $addFormLhs)
;          --base = comp $addFormLhs-- bound in compAdd
;   newModes:= SUBLIS(slist,formalArgModes)
;   or/[not comp(u,m,e) for u in rest $addFormLhs for m in newModes] =>
;     return nil
;       --I should check that the actual arguments are of the right type
;   for u in formalArgs for m in newModes repeat
;     [.,.,e]:= compMakeDeclaration(['_:,u,m],m,e)
;       --we can not substitute in the formal arguments before we comp
;       --for that may change the shape of the object, but we must before
;       --we match signatures
;   cat:= (compMakeCategoryObject(target,e)).expr
;   instantiatedBase:= GENVAR()
;   n:=MAXINDEX cat
;   code:=
;     [u
;       for i in 6..n | not atom cat.i and not atom (sig:= first cat.i)
;          and
;           (u:=
;             SetFunctionSlots(SUBLIS(slist, sig), ['ELT, instantiatedBase, i],
;                              flag, kvec)) ~= nil]
;      --The code from here to the end is designed to replace repeated LOAD/STORE
;      --combinations (SETELT ...(ELT ..)) by MVCs where this is practicable
;   copyvec:=GETREFV (1+n)
;   for u in code repeat
;       if update(u,copyvec,[]) then code:=delete(u,code)
;     where update(code,copyvec,sofar) ==
;       ATOM code =>nil
;       MEMQ(QCAR code,'(ELT QREFELT)) =>
;           copyvec.(CADDR code):=union(copyvec.(CADDR code), sofar)
;           true
;       code is [x,name,number,u'] and MEMQ(x,'(SETELT QSETREFV)) =>
;         update(u',copyvec,[[name,:number],:sofar])
;   for i in 6..n repeat
;     if copyvec.i then
;       v:=[($QuickCode => 'QREFELT;'ELT),instantiatedBase,i]
;       for u in copyvec.i repeat
;         [name,:count]:=u
;         v:=[($QuickCode => 'QSETREFV;'SETELT),name,count,v]
;       code:=[v,:code]
;   [['LET,instantiatedBase,base],:code]

(DEFUN |DescendCodeAdd1|
       (|base| |flag| |target| |formalArgs| |formalArgModes| |kvec| |e|)
  (PROG (|slist| |newModes| |LETTMP#1| |cat| |instantiatedBase| |n| |sig| |u|
         |code| |copyvec| |v| |name| |count|)
    (RETURN
     (PROGN
      (SETQ |slist| (|pairList| |formalArgs| (CDR |$addFormLhs|)))
      (SETQ |newModes| (SUBLIS |slist| |formalArgModes|))
      (COND
       (((LAMBDA (|bfVar#31| |bfVar#29| |u| |bfVar#30| |m|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#29|) (PROGN (SETQ |u| (CAR |bfVar#29|)) NIL)
                  (ATOM |bfVar#30|) (PROGN (SETQ |m| (CAR |bfVar#30|)) NIL))
              (RETURN |bfVar#31|))
             (#1='T
              (PROGN
               (SETQ |bfVar#31| (NULL (|comp| |u| |m| |e|)))
               (COND (|bfVar#31| (RETURN |bfVar#31|))))))
            (SETQ |bfVar#29| (CDR |bfVar#29|))
            (SETQ |bfVar#30| (CDR |bfVar#30|))))
         NIL (CDR |$addFormLhs|) NIL |newModes| NIL)
        (RETURN NIL))
       (#1#
        (PROGN
         ((LAMBDA (|bfVar#32| |u| |bfVar#33| |m|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#32|) (PROGN (SETQ |u| (CAR |bfVar#32|)) NIL)
                   (ATOM |bfVar#33|) (PROGN (SETQ |m| (CAR |bfVar#33|)) NIL))
               (RETURN NIL))
              (#1#
               (PROGN
                (SETQ |LETTMP#1|
                        (|compMakeDeclaration| (LIST '|:| |u| |m|) |m| |e|))
                (SETQ |e| (CADDR |LETTMP#1|))
                |LETTMP#1|)))
             (SETQ |bfVar#32| (CDR |bfVar#32|))
             (SETQ |bfVar#33| (CDR |bfVar#33|))))
          |formalArgs| NIL |newModes| NIL)
         (SETQ |cat| (CAR (|compMakeCategoryObject| |target| |e|)))
         (SETQ |instantiatedBase| (GENVAR))
         (SETQ |n| (MAXINDEX |cat|))
         (SETQ |code|
                 ((LAMBDA (|bfVar#34| |i|)
                    (LOOP
                     (COND ((> |i| |n|) (RETURN (NREVERSE |bfVar#34|)))
                           (#1#
                            (AND (NULL (ATOM (ELT |cat| |i|)))
                                 (NULL
                                  (ATOM (SETQ |sig| (CAR (ELT |cat| |i|)))))
                                 (SETQ |u|
                                         (|SetFunctionSlots|
                                          (SUBLIS |slist| |sig|)
                                          (LIST 'ELT |instantiatedBase| |i|)
                                          |flag| |kvec|))
                                 (SETQ |bfVar#34| (CONS |u| |bfVar#34|)))))
                     (SETQ |i| (+ |i| 1))))
                  NIL 6))
         (SETQ |copyvec| (GETREFV (+ 1 |n|)))
         ((LAMBDA (|bfVar#35| |u|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#35|) (PROGN (SETQ |u| (CAR |bfVar#35|)) NIL))
               (RETURN NIL))
              (#1#
               (COND
                ((|update| |u| |copyvec| NIL)
                 (SETQ |code| (|delete| |u| |code|))))))
             (SETQ |bfVar#35| (CDR |bfVar#35|))))
          |code| NIL)
         ((LAMBDA (|i|)
            (LOOP
             (COND ((> |i| |n|) (RETURN NIL))
                   (#1#
                    (COND
                     ((ELT |copyvec| |i|)
                      (SETQ |v|
                              (LIST (COND (|$QuickCode| 'QREFELT) (#1# 'ELT))
                                    |instantiatedBase| |i|))
                      ((LAMBDA (|bfVar#36| |u|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#36|)
                                (PROGN (SETQ |u| (CAR |bfVar#36|)) NIL))
                            (RETURN NIL))
                           (#1#
                            (PROGN
                             (SETQ |name| (CAR |u|))
                             (SETQ |count| (CDR |u|))
                             (SETQ |v|
                                     (LIST
                                      (COND (|$QuickCode| 'QSETREFV)
                                            (#1# 'SETELT))
                                      |name| |count| |v|)))))
                          (SETQ |bfVar#36| (CDR |bfVar#36|))))
                       (ELT |copyvec| |i|) NIL)
                      (SETQ |code| (CONS |v| |code|))))))
             (SETQ |i| (+ |i| 1))))
          6)
         (CONS (LIST 'LET |instantiatedBase| |base|) |code|))))))))
(DEFUN |DescendCodeAdd1,update| (|code| |copyvec| |sofar|)
  (PROG (|x| |ISTMP#1| |name| |ISTMP#2| |number| |ISTMP#3| |u'|)
    (RETURN
     (COND ((ATOM |code|) NIL)
           ((MEMQ (QCAR |code|) '(ELT QREFELT))
            (PROGN
             (SETF (ELT |copyvec| (CADDR |code|))
                     (|union| (ELT |copyvec| (CADDR |code|)) |sofar|))
             T))
           ((AND (CONSP |code|)
                 (PROGN
                  (SETQ |x| (CAR |code|))
                  (SETQ |ISTMP#1| (CDR |code|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |name| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |number| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN (SETQ |u'| (CAR |ISTMP#3|)) 'T)))))))
                 (MEMQ |x| '(SETELT QSETREFV)))
            (|DescendCodeAdd1,update| |u'| |copyvec|
             (CONS (CONS |name| |number|) |sofar|)))))))

; DescendCode(code, flag, viewAssoc, EnvToPass, kvec, e) ==
;   -- flag = true if we are walking down code always executed;
;   -- otherwise set to conditions in which
;   code=nil => nil
;   code='noBranch => nil
;   code is ['add,base,:codelist] =>
;     codelist:=
;         [v for u in codelist | (v := DescendCode(u, flag, viewAssoc,
;            EnvToPass, kvec, e)) ~= nil]
;                   -- must do this first, to get this overriding Add code
;     ['PROGN, :DescendCodeAdd(base, flag, kvec, e), :codelist]
;   code is ['PROGN,:codelist] =>
;     ['PROGN,:
;             --Two REVERSEs leave original order, but ensure last guy wins
;       NREVERSE [v for u in REVERSE codelist | (v := DescendCode(
;                          u, flag, viewAssoc, EnvToPass, kvec, e)) ~= nil]]
;   code is ['COND,:condlist] =>
;     c := [[u2 := ProcessCond(first(u), e), :q] for u in condlist] where q ==
;           null u2 => nil
;           f:=
;             TruthP u2 => flag;
;             TruthP flag =>
;                flag := ['NOT,u2]
;                u2
;             f1 := ['AND, flag, u2]
;             flag := ['AND,flag,['NOT,u2]];
;             f1
;           [DescendCode(v, f,
;             if first u is ['HasCategory,dom,cat]
;               then [[dom,:cat],:viewAssoc]
;               else viewAssoc, EnvToPass, kvec, e) for v in rest u]
;     TruthP CAAR c => ['PROGN,:CDAR c]
;     while (c and (last c is [c1] or last c is [c1,[]]) and
;             (c1 = '(QUOTE T))) repeat
;                    --strip out some worthless junk at the end
;         c := NREVERSE rest NREVERSE c
;     null c => '(LIST)
;     ['COND,:c]
;   code is ['LET,name,body,:.] =>
;                     --only keep the names that are useful
;     u:=member(name,$locals) =>
;         CONTAINED('$, body) and isDomainForm(body, e) =>
;           --instantiate domains which depend on $ after constants are set
;           code:=[($QuickCode => 'QSETREFV; 'SETELT),[($QuickCode => 'QREFELT; 'ELT),'$,5],#$locals-#u,code]
;           $epilogue:=
;             TruthP flag => [code,:$epilogue]
;             [['COND, [ProcessCond(flag, e), code]], :$epilogue]
;           nil
;         code
;     code -- doItIf deletes entries from $locals so can't optimize this
;   code is ['CodeDefine,sig,implem] =>
;              --Generated by doIt in COMPILER BOOT
;     dom:= EnvToPass
;     dom:=
;       u := LASSOC(dom, viewAssoc) => ["getDomainView", dom, u]
;       dom
;     body:= ['CONS,implem,dom]
;     u := SetFunctionSlots(sig, body, flag, kvec)
;     ConstantCreator u =>
;       if not (flag = true) then u := ['COND, [ProcessCond(flag, e), u]]
;       $ConstantAssignments:= [u,:$ConstantAssignments]
;       nil
;     u
;   code is ['_:,:.] => (RPLACA(code,'LIST); RPLACD(code,NIL))
;       --Yes, I know that's a hack, but how else do you kill a line?
;   code is ['LIST,:.] => nil
;   code is ['devaluate,:.] => nil
;   code is ['MDEF,:.] => nil
;   code is ['call,:.] => code
;   code is ['SETELT,:.] => code -- can be generated by doItIf
;   code is ['QSETREFV,:.] => code -- can be generated by doItIf
;   stackWarning ['"unknown Functor code ",code]
;   code

(DEFUN |DescendCode| (|code| |flag| |viewAssoc| |EnvToPass| |kvec| |e|)
  (PROG (|ISTMP#1| |base| |codelist| |v| |condlist| |u2| |f1| |f| |ISTMP#2|
         |dom| |ISTMP#3| |cat| |c| |c1| |name| |body| |u| |sig| |implem|)
    (RETURN
     (COND ((NULL |code|) NIL) ((EQ |code| '|noBranch|) NIL)
           ((AND (CONSP |code|) (EQ (CAR |code|) '|add|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |code|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |base| (CAR |ISTMP#1|))
                        (SETQ |codelist| (CDR |ISTMP#1|))
                        #1='T))))
            (PROGN
             (SETQ |codelist|
                     ((LAMBDA (|bfVar#38| |bfVar#37| |u|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#37|)
                               (PROGN (SETQ |u| (CAR |bfVar#37|)) NIL))
                           (RETURN (NREVERSE |bfVar#38|)))
                          (#1#
                           (AND
                            (SETQ |v|
                                    (|DescendCode| |u| |flag| |viewAssoc|
                                     |EnvToPass| |kvec| |e|))
                            (SETQ |bfVar#38| (CONS |v| |bfVar#38|)))))
                         (SETQ |bfVar#37| (CDR |bfVar#37|))))
                      NIL |codelist| NIL))
             (CONS 'PROGN
                   (APPEND (|DescendCodeAdd| |base| |flag| |kvec| |e|)
                           |codelist|))))
           ((AND (CONSP |code|) (EQ (CAR |code|) 'PROGN)
                 (PROGN (SETQ |codelist| (CDR |code|)) #1#))
            (CONS 'PROGN
                  (NREVERSE
                   ((LAMBDA (|bfVar#40| |bfVar#39| |u|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#39|)
                             (PROGN (SETQ |u| (CAR |bfVar#39|)) NIL))
                         (RETURN (NREVERSE |bfVar#40|)))
                        (#1#
                         (AND
                          (SETQ |v|
                                  (|DescendCode| |u| |flag| |viewAssoc|
                                   |EnvToPass| |kvec| |e|))
                          (SETQ |bfVar#40| (CONS |v| |bfVar#40|)))))
                       (SETQ |bfVar#39| (CDR |bfVar#39|))))
                    NIL (REVERSE |codelist|) NIL))))
           ((AND (CONSP |code|) (EQ (CAR |code|) 'COND)
                 (PROGN (SETQ |condlist| (CDR |code|)) #1#))
            (PROGN
             (SETQ |c|
                     ((LAMBDA (|bfVar#42| |bfVar#41| |u|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#41|)
                               (PROGN (SETQ |u| (CAR |bfVar#41|)) NIL))
                           (RETURN (NREVERSE |bfVar#42|)))
                          (#1#
                           (SETQ |bfVar#42|
                                   (CONS
                                    (CONS
                                     (SETQ |u2| (|ProcessCond| (CAR |u|) |e|))
                                     (COND ((NULL |u2|) NIL)
                                           (#1#
                                            (PROGN
                                             (SETQ |f|
                                                     (PROGN
                                                      (COND
                                                       ((|TruthP| |u2|) |flag|)
                                                       ((|TruthP| |flag|)
                                                        (PROGN
                                                         (SETQ |flag|
                                                                 (LIST 'NOT
                                                                       |u2|))
                                                         |u2|)))
                                                      (SETQ |f1|
                                                              (LIST 'AND |flag|
                                                                    |u2|))
                                                      (SETQ |flag|
                                                              (LIST 'AND |flag|
                                                                    (LIST 'NOT
                                                                          |u2|)))
                                                      |f1|))
                                             ((LAMBDA
                                                  (|bfVar#44| |bfVar#43| |v|)
                                                (LOOP
                                                 (COND
                                                  ((OR (ATOM |bfVar#43|)
                                                       (PROGN
                                                        (SETQ |v|
                                                                (CAR
                                                                 |bfVar#43|))
                                                        NIL))
                                                   (RETURN
                                                    (NREVERSE |bfVar#44|)))
                                                  (#1#
                                                   (SETQ |bfVar#44|
                                                           (CONS
                                                            (|DescendCode| |v|
                                                             |f|
                                                             (COND
                                                              ((PROGN
                                                                (SETQ |ISTMP#1|
                                                                        (CAR
                                                                         |u|))
                                                                (AND
                                                                 (CONSP
                                                                  |ISTMP#1|)
                                                                 (EQ
                                                                  (CAR
                                                                   |ISTMP#1|)
                                                                  '|HasCategory|)
                                                                 (PROGN
                                                                  (SETQ |ISTMP#2|
                                                                          (CDR
                                                                           |ISTMP#1|))
                                                                  (AND
                                                                   (CONSP
                                                                    |ISTMP#2|)
                                                                   (PROGN
                                                                    (SETQ |dom|
                                                                            (CAR
                                                                             |ISTMP#2|))
                                                                    (SETQ |ISTMP#3|
                                                                            (CDR
                                                                             |ISTMP#2|))
                                                                    (AND
                                                                     (CONSP
                                                                      |ISTMP#3|)
                                                                     (EQ
                                                                      (CDR
                                                                       |ISTMP#3|)
                                                                      NIL)
                                                                     (PROGN
                                                                      (SETQ |cat|
                                                                              (CAR
                                                                               |ISTMP#3|))
                                                                      #1#)))))))
                                                               (CONS
                                                                (CONS |dom|
                                                                      |cat|)
                                                                |viewAssoc|))
                                                              (#1#
                                                               |viewAssoc|))
                                                             |EnvToPass| |kvec|
                                                             |e|)
                                                            |bfVar#44|))))
                                                 (SETQ |bfVar#43|
                                                         (CDR |bfVar#43|))))
                                              NIL (CDR |u|) NIL)))))
                                    |bfVar#42|))))
                         (SETQ |bfVar#41| (CDR |bfVar#41|))))
                      NIL |condlist| NIL))
             (COND ((|TruthP| (CAAR |c|)) (CONS 'PROGN (CDAR |c|)))
                   (#1#
                    (PROGN
                     ((LAMBDA ()
                        (LOOP
                         (COND
                          ((NOT
                            (AND |c|
                                 (OR
                                  (PROGN
                                   (SETQ |ISTMP#1| (|last| |c|))
                                   (AND (CONSP |ISTMP#1|)
                                        (EQ (CDR |ISTMP#1|) NIL)
                                        (PROGN
                                         (SETQ |c1| (CAR |ISTMP#1|))
                                         #1#)))
                                  (PROGN
                                   (SETQ |ISTMP#1| (|last| |c|))
                                   (AND (CONSP |ISTMP#1|)
                                        (PROGN
                                         (SETQ |c1| (CAR |ISTMP#1|))
                                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                         (AND (CONSP |ISTMP#2|)
                                              (EQ (CDR |ISTMP#2|) NIL)
                                              (PROGN
                                               (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                               (AND (CONSP |ISTMP#3|)
                                                    (EQ (CDR |ISTMP#3|) NIL)
                                                    (NULL
                                                     (CAR |ISTMP#3|)))))))))
                                 (EQUAL |c1| ''T)))
                           (RETURN NIL))
                          (#1# (SETQ |c| (NREVERSE (CDR (NREVERSE |c|)))))))))
                     (COND ((NULL |c|) '(LIST)) (#1# (CONS 'COND |c|))))))))
           ((AND (CONSP |code|) (EQ (CAR |code|) 'LET)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |code|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |name| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN (SETQ |body| (CAR |ISTMP#2|)) #1#))))))
            (COND
             ((SETQ |u| (|member| |name| |$locals|))
              (COND
               ((AND (CONTAINED '$ |body|) (|isDomainForm| |body| |e|))
                (PROGN
                 (SETQ |code|
                         (LIST (COND (|$QuickCode| 'QSETREFV) (#1# 'SETELT))
                               (LIST (COND (|$QuickCode| 'QREFELT) (#1# 'ELT))
                                     '$ 5)
                               (- (LENGTH |$locals|) (LENGTH |u|)) |code|))
                 (SETQ |$epilogue|
                         (COND ((|TruthP| |flag|) (CONS |code| |$epilogue|))
                               (#1#
                                (CONS
                                 (LIST 'COND
                                       (LIST (|ProcessCond| |flag| |e|)
                                             |code|))
                                 |$epilogue|))))
                 NIL))
               (#1# |code|)))
             (#1# |code|)))
           ((AND (CONSP |code|) (EQ (CAR |code|) '|CodeDefine|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |code|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |sig| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |implem| (CAR |ISTMP#2|)) #1#))))))
            (PROGN
             (SETQ |dom| |EnvToPass|)
             (SETQ |dom|
                     (COND
                      ((SETQ |u| (LASSOC |dom| |viewAssoc|))
                       (LIST '|getDomainView| |dom| |u|))
                      (#1# |dom|)))
             (SETQ |body| (LIST 'CONS |implem| |dom|))
             (SETQ |u| (|SetFunctionSlots| |sig| |body| |flag| |kvec|))
             (COND
              ((|ConstantCreator| |u|)
               (PROGN
                (COND
                 ((NULL (EQUAL |flag| T))
                  (SETQ |u|
                          (LIST 'COND (LIST (|ProcessCond| |flag| |e|) |u|)))))
                (SETQ |$ConstantAssignments| (CONS |u| |$ConstantAssignments|))
                NIL))
              (#1# |u|))))
           ((AND (CONSP |code|) (EQ (CAR |code|) '|:|))
            (PROGN (RPLACA |code| 'LIST) (RPLACD |code| NIL)))
           ((AND (CONSP |code|) (EQ (CAR |code|) 'LIST)) NIL)
           ((AND (CONSP |code|) (EQ (CAR |code|) '|devaluate|)) NIL)
           ((AND (CONSP |code|) (EQ (CAR |code|) 'MDEF)) NIL)
           ((AND (CONSP |code|) (EQ (CAR |code|) '|call|)) |code|)
           ((AND (CONSP |code|) (EQ (CAR |code|) 'SETELT)) |code|)
           ((AND (CONSP |code|) (EQ (CAR |code|) 'QSETREFV)) |code|)
           (#1#
            (PROGN
             (|stackWarning| (LIST "unknown Functor code " |code|))
             |code|))))))

; ConstantCreator u ==
;   null u => nil
;   u is [q,.,.,u'] and (q='SETELT or q='QSETREFV) => ConstantCreator u'
;   u is ['CONS,:.] => nil
;   true

(DEFUN |ConstantCreator| (|u|)
  (PROG (|q| |ISTMP#1| |ISTMP#2| |ISTMP#3| |u'|)
    (RETURN
     (COND ((NULL |u|) NIL)
           ((AND (CONSP |u|)
                 (PROGN
                  (SETQ |q| (CAR |u|))
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |u'| (CAR |ISTMP#3|))
                                    #1='T)))))))
                 (OR (EQ |q| 'SETELT) (EQ |q| 'QSETREFV)))
            (|ConstantCreator| |u'|))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'CONS)) NIL) (#1# T)))))

; ProcessCond(cond, et) ==
;   ncond := SUBLIS($pairlis,cond)
;   INTEGERP POSN1(ncond, $NRTslot1PredicateList) => predicateBitRef(ncond, et)
;   cond

(DEFUN |ProcessCond| (|cond| |et|)
  (PROG (|ncond|)
    (RETURN
     (PROGN
      (SETQ |ncond| (SUBLIS |$pairlis| |cond|))
      (COND
       ((INTEGERP (POSN1 |ncond| |$NRTslot1PredicateList|))
        (|predicateBitRef| |ncond| |et|))
       ('T |cond|))))))

; SetFunctionSlots(sig, body, flag, kvec) ==
; --+
;   v := '$
;   u := kvec
;   if true then
;     null body => return NIL
;     for catImplem in LookUpSigSlots(sig,u.1) repeat
;       if catImplem is [q,.,index] and (q='ELT or q='CONST) then
;           if q is 'CONST and body is ['CONS,a,b] then
;              body := ['CONS,'IDENTITY,['FUNCALL,a,b]]
;           body:= [($QuickCode => 'QSETREFV; 'SETELT),v,index,body]
;           if REFVECP $SetFunctions and TruthP flag then u.index:= true
;                  --used by CheckVector to determine which ops are missing
;           if v='$ then  -- i.e. we are looking at the principal view
;             not REFVECP $SetFunctions => nil
;                     --packages don't set it
;             $MissingFunctionInfo.index:= flag
;             TruthP $SetFunctions.index => (body:= nil; return nil)
;                      -- the function was already assigned
;             $SetFunctions.index:=
;               TruthP flag => true
;               not $SetFunctions.index=>flag --JHD didn't set $SF on this branch
;               ["or",$SetFunctions.index,flag]
;       else
;           keyedSystemError("S2OR0002",[catImplem])
;   body is ['SETELT,:.] => body
;   body is ['QSETREFV,:.] => body
;   nil

(DEFUN |SetFunctionSlots| (|sig| |body| |flag| |kvec|)
  (PROG (|v| |u| |q| |ISTMP#1| |ISTMP#2| |index| |a| |b|)
    (RETURN
     (PROGN
      (SETQ |v| '$)
      (SETQ |u| |kvec|)
      (COND
       (T
        (COND ((NULL |body|) (RETURN NIL))
              (#1='T
               ((LAMBDA (|bfVar#45| |catImplem|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#45|)
                         (PROGN (SETQ |catImplem| (CAR |bfVar#45|)) NIL))
                     (RETURN NIL))
                    (#1#
                     (COND
                      ((AND (CONSP |catImplem|)
                            (PROGN
                             (SETQ |q| (CAR |catImplem|))
                             (SETQ |ISTMP#1| (CDR |catImplem|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |index| (CAR |ISTMP#2|))
                                         #1#)))))
                            (OR (EQ |q| 'ELT) (EQ |q| 'CONST)))
                       (COND
                        ((AND (EQ |q| 'CONST) (CONSP |body|)
                              (EQ (CAR |body|) 'CONS)
                              (PROGN
                               (SETQ |ISTMP#1| (CDR |body|))
                               (AND (CONSP |ISTMP#1|)
                                    (PROGN
                                     (SETQ |a| (CAR |ISTMP#1|))
                                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                     (AND (CONSP |ISTMP#2|)
                                          (EQ (CDR |ISTMP#2|) NIL)
                                          (PROGN
                                           (SETQ |b| (CAR |ISTMP#2|))
                                           #1#))))))
                         (SETQ |body|
                                 (LIST 'CONS 'IDENTITY
                                       (LIST 'FUNCALL |a| |b|)))))
                       (SETQ |body|
                               (LIST
                                (COND (|$QuickCode| 'QSETREFV) (#1# 'SETELT))
                                |v| |index| |body|))
                       (COND
                        ((AND (REFVECP |$SetFunctions|) (|TruthP| |flag|))
                         (SETF (ELT |u| |index|) T)))
                       (COND
                        ((EQ |v| '$)
                         (COND ((NULL (REFVECP |$SetFunctions|)) NIL)
                               (#1#
                                (PROGN
                                 (SETF (ELT |$MissingFunctionInfo| |index|)
                                         |flag|)
                                 (COND
                                  ((|TruthP| (ELT |$SetFunctions| |index|))
                                   (PROGN (SETQ |body| NIL) (RETURN NIL)))
                                  (#1#
                                   (SETF (ELT |$SetFunctions| |index|)
                                           (COND ((|TruthP| |flag|) T)
                                                 ((NULL
                                                   (ELT |$SetFunctions|
                                                        |index|))
                                                  |flag|)
                                                 (#1#
                                                  (LIST '|or|
                                                        (ELT |$SetFunctions|
                                                             |index|)
                                                        |flag|))))))))))))
                      (#1#
                       (|keyedSystemError| 'S2OR0002 (LIST |catImplem|))))))
                   (SETQ |bfVar#45| (CDR |bfVar#45|))))
                (|LookUpSigSlots| |sig| (ELT |u| 1)) NIL)))))
      (COND ((AND (CONSP |body|) (EQ (CAR |body|) 'SETELT)) |body|)
            ((AND (CONSP |body|) (EQ (CAR |body|) 'QSETREFV)) |body|)
            (#1# NIL))))))

; LookUpSigSlots(sig,siglist) ==
; --+ must kill any implementations below of the form (ELT $ NIL)
;   if $insideCategoryPackageIfTrue then
;            sig := substitute('$,CADR($functorForm),sig)
;   siglist := $lisplibOperationAlist
;   REMDUP [implem for u in siglist | SigSlotsMatch(sig,first u,implem:=CADDR u)
;               and IFCAR(IFCDR(IFCDR(implem)))]

(DEFUN |LookUpSigSlots| (|sig| |siglist|)
  (PROG (|implem|)
    (RETURN
     (PROGN
      (COND
       (|$insideCategoryPackageIfTrue|
        (SETQ |sig| (|substitute| '$ (CADR |$functorForm|) |sig|))))
      (SETQ |siglist| |$lisplibOperationAlist|)
      (REMDUP
       ((LAMBDA (|bfVar#47| |bfVar#46| |u|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#46|) (PROGN (SETQ |u| (CAR |bfVar#46|)) NIL))
             (RETURN (NREVERSE |bfVar#47|)))
            ('T
             (AND (|SigSlotsMatch| |sig| (CAR |u|) (SETQ |implem| (CADDR |u|)))
                  (IFCAR (IFCDR (IFCDR |implem|)))
                  (SETQ |bfVar#47| (CONS |implem| |bfVar#47|)))))
           (SETQ |bfVar#46| (CDR |bfVar#46|))))
        NIL |siglist| NIL))))))

; SigSlotsMatch(sig,pattern,implem) ==
;   sig=pattern => true
;   not (LENGTH CADR sig=LENGTH CADR pattern) => nil
;                        --CADR sig is the actual signature part
;   not (first sig=first pattern) => nil
;   pat' :=SUBSTQ($definition,'$,CADR pattern)
;   sig' :=SUBSTQ($definition,'$,CADR sig)
;   sig'=pat' => true
;   --If we don't have this next test, then we'll recurse in SetFunctionSlots
;   SourceLevelSubsume(sig',pat') => true
;   nil

(DEFUN |SigSlotsMatch| (|sig| |pattern| |implem|)
  (PROG (|pat'| |sig'|)
    (RETURN
     (COND ((EQUAL |sig| |pattern|) T)
           ((NULL (EQL (LENGTH (CADR |sig|)) (LENGTH (CADR |pattern|)))) NIL)
           ((NULL (EQUAL (CAR |sig|) (CAR |pattern|))) NIL)
           (#1='T
            (PROGN
             (SETQ |pat'| (SUBSTQ |$definition| '$ (CADR |pattern|)))
             (SETQ |sig'| (SUBSTQ |$definition| '$ (CADR |sig|)))
             (COND ((EQUAL |sig'| |pat'|) T)
                   ((|SourceLevelSubsume| |sig'| |pat'|) T) (#1# NIL))))))))

; makeMissingFunctionEntry(alist,i) ==
;   tran SUBLIS(alist,$MissingFunctionInfo.i) where
;     tran x ==
;       x is ["HasCategory",a,["QUOTE",b]] => ['has,a,b]
;       x is [op,:l] and op in '(AND OR NOT) => [op,:[tran y for y in l]]
;       x

(DEFUN |makeMissingFunctionEntry| (|alist| |i|)
  (PROG ()
    (RETURN
     (|makeMissingFunctionEntry,tran|
      (SUBLIS |alist| (ELT |$MissingFunctionInfo| |i|))))))
(DEFUN |makeMissingFunctionEntry,tran| (|x|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |ISTMP#3| |ISTMP#4| |b| |op| |l|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) '|HasCategory|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN
                         (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) 'QUOTE)
                              (PROGN
                               (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                               (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                    (PROGN
                                     (SETQ |b| (CAR |ISTMP#4|))
                                     #1='T))))))))))
       (LIST '|has| |a| |b|))
      ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) (SETQ |l| (CDR |x|)) #1#)
            (|member| |op| '(AND OR NOT)))
       (CONS |op|
             ((LAMBDA (|bfVar#49| |bfVar#48| |y|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#48|)
                       (PROGN (SETQ |y| (CAR |bfVar#48|)) NIL))
                   (RETURN (NREVERSE |bfVar#49|)))
                  (#1#
                   (SETQ |bfVar#49|
                           (CONS (|makeMissingFunctionEntry,tran| |y|)
                                 |bfVar#49|))))
                 (SETQ |bfVar#48| (CDR |bfVar#48|))))
              NIL |l| NIL)))
      (#1# |x|)))))

; InvestigateConditions(catvecListMaker, base_shell, e) ==
;   -- given a principal view and a list of secondary views,
;   -- discover under what conditions the secondary view are
;   -- always present.
;   [principal, :secondaries] := catvecListMaker
;       --We are not interested in the principal view
;       --The next block allows for the possibility that $principal may
;       --have conditional secondary views
; --+
;   null secondaries => '(T)
;       --return for packages which generally have no secondary views
;   if principal is [op, :.] then
;     [principal', :.] := compMakeCategoryObject(principal, e)
;               --Rather like eval, but quotes parameters first
;     for u in CADR principal'.4 repeat
;       if not TruthP(cond:=CADR u) then
;         new := ['CATEGORY, 'domain,
;                 ['IF, cond, ['ATTRIBUTE, first u], 'noBranch]]
;         principal is ['Join, :l] =>
;           not member(new,l) =>
;              principal := ['Join, :l, new]
;         principal := ['Join, principal, new]
;   [principal', Conditions] :=
;     pessimise(principal, nil) where
;       pessimise(a, Conditions) ==
;         atom a => [a, Conditions]
;         a is ['SIGNATURE, :.] => [a, Conditions]
;         a is ['IF,cond,:.] =>
;           if not member(cond, Conditions) then
;               Conditions := [cond, Conditions]
;           [nil, Conditions]
;         [r1, Conditions] := pessimise(first(a), Conditions)
;         [r2, Conditions] := pessimise(rest(a), Conditions)
;         [[r1, :r2], Conditions]
;   null Conditions => [true, :[true for u in secondaries]]
;   PrincipalSecondaries:= getViewsConditions(principal', e)
;   MinimalPrimary := first first PrincipalSecondaries
;   MaximalPrimary:= CAAR base_shell.4
;   necessarySecondaries:= [first u for u in PrincipalSecondaries | rest u=true]
;   and/[member(u,necessarySecondaries) for u in secondaries] =>
;     [true,:[true for u in secondaries]]
;   HackSlot4:=
;     MaximalPrimary = nil => nil
;     MinimalPrimary=MaximalPrimary => nil
;     MaximalPrimaries := [MaximalPrimary, :first (CatEval MaximalPrimary).4]
;     MinimalPrimaries := [MinimalPrimary, :first (CatEval MinimalPrimary).4]
;     MaximalPrimaries := set_difference(MaximalPrimaries, MinimalPrimaries)
;     [[x] for x in MaximalPrimaries]
;   (Conditions := Conds(principal, nil)) where
;     Conds(code,previous) ==
;            --each call takes a list of conditions, and returns a list
;            --of refinements of that list
;       atom code => [previous]
;       code is ['DomainSubstitutionMacro,.,b] => Conds(b,previous)
;       code is ['IF,a,b,c] => union(Conds(b,[a,:previous]),Conds(c,previous))
;       code is ['PROGN,:l] => "union"/[Conds(u,previous) for u in l]
;       code is ['CATEGORY,:l] => "union"/[Conds(u,previous) for u in l]
;       code is ['Join,:l] => "union"/[Conds(u,previous) for u in l]
;       [previous]
;   Conditions := EFFACE(nil, [EFFACE(nil, u) for u in Conditions])
;   partList:=
;     [getViewsConditions(partPessimise(principal, cond), e)
;          for cond in Conditions]
;   masterSecondaries:= secondaries
;   for u in partList repeat
;     for [v,:.] in u repeat
;       if not member(v,secondaries) then secondaries:= [v,:secondaries]
;   --PRETTYPRINT $Conditions
;   --PRETTYPRINT masterSecondaries
;   --PRETTYPRINT secondaries
;   (list:= [mkNilT member(u,necessarySecondaries) for u in secondaries]) where
;     mkNilT u ==
;       u => true
;       nil
;   for u in Conditions for newS in partList repeat
;     --newS is a list of secondaries and conditions (over and above
;     --u) for which they apply
;     u:=
;       LENGTH u=1 => first u
;       ['AND,:u]
;     for [v,:.] in newS repeat
;       for v' in [v, :first (CatEval v).4] repeat
;         if (w:= assoc(v', HackSlot4)) then
;           rplac(rest w, if rest w then mkOr(u, rest w) else u)
;     (list:= update(list,u,secondaries,newS)) where
;       update(list,cond,secondaries,newS) ==
;         (list2:=
;           [flist(sec,newS,old,cond) for sec in secondaries for old in list]) where
;             flist(sec,newS,old,cond) ==
;               old=true => old
;               for [newS2,:morecond] in newS repeat
;                 old:=
;                   not AncestorP(sec,[newS2]) => old
;                   cond2:= mkAnd(cond,morecond)
;                   null old => cond2
;                   mkOr(cond2,old)
;               old
;         list2
;   list:= ICformat_loop(list, secondaries, e)
;   [true,:[LASSOC(ms,list) for ms in masterSecondaries]]

(DEFUN |InvestigateConditions| (|catvecListMaker| |base_shell| |e|)
  (PROG (|principal| |secondaries| |op| |LETTMP#1| |principal'| |cond| |new|
         |l| |Conditions| |PrincipalSecondaries| |MinimalPrimary|
         |MaximalPrimary| |necessarySecondaries| |MaximalPrimaries|
         |MinimalPrimaries| |HackSlot4| |partList| |masterSecondaries| |v| LIST
         |w|)
    (RETURN
     (PROGN
      (SETQ |principal| (CAR |catvecListMaker|))
      (SETQ |secondaries| (CDR |catvecListMaker|))
      (COND ((NULL |secondaries|) '(T))
            (#1='T
             (PROGN
              (COND
               ((AND (CONSP |principal|)
                     (PROGN (SETQ |op| (CAR |principal|)) #1#))
                (SETQ |LETTMP#1| (|compMakeCategoryObject| |principal| |e|))
                (SETQ |principal'| (CAR |LETTMP#1|))
                ((LAMBDA (|bfVar#50| |u|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#50|)
                          (PROGN (SETQ |u| (CAR |bfVar#50|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (COND
                       ((NULL (|TruthP| (SETQ |cond| (CADR |u|))))
                        (SETQ |new|
                                (LIST 'CATEGORY '|domain|
                                      (LIST 'IF |cond|
                                            (LIST 'ATTRIBUTE (CAR |u|))
                                            '|noBranch|)))
                        (COND
                         ((AND (CONSP |principal|)
                               (EQ (CAR |principal|) '|Join|)
                               (PROGN (SETQ |l| (CDR |principal|)) #1#))
                          (COND
                           ((NULL (|member| |new| |l|))
                            (IDENTITY
                             (SETQ |principal|
                                     (CONS '|Join|
                                           (APPEND |l| (CONS |new| NIL))))))))
                         (#1#
                          (SETQ |principal|
                                  (LIST '|Join| |principal| |new|))))))))
                    (SETQ |bfVar#50| (CDR |bfVar#50|))))
                 (CADR (ELT |principal'| 4)) NIL)))
              (SETQ |LETTMP#1|
                      (|InvestigateConditions,pessimise| |principal| NIL))
              (SETQ |principal'| (CAR |LETTMP#1|))
              (SETQ |Conditions| (CADR |LETTMP#1|))
              (COND
               ((NULL |Conditions|)
                (CONS T
                      ((LAMBDA (|bfVar#52| |bfVar#51| |u|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#51|)
                                (PROGN (SETQ |u| (CAR |bfVar#51|)) NIL))
                            (RETURN (NREVERSE |bfVar#52|)))
                           (#1# (SETQ |bfVar#52| (CONS T |bfVar#52|))))
                          (SETQ |bfVar#51| (CDR |bfVar#51|))))
                       NIL |secondaries| NIL)))
               (#1#
                (PROGN
                 (SETQ |PrincipalSecondaries|
                         (|getViewsConditions| |principal'| |e|))
                 (SETQ |MinimalPrimary| (CAR (CAR |PrincipalSecondaries|)))
                 (SETQ |MaximalPrimary| (CAAR (ELT |base_shell| 4)))
                 (SETQ |necessarySecondaries|
                         ((LAMBDA (|bfVar#54| |bfVar#53| |u|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#53|)
                                   (PROGN (SETQ |u| (CAR |bfVar#53|)) NIL))
                               (RETURN (NREVERSE |bfVar#54|)))
                              (#1#
                               (AND (EQUAL (CDR |u|) T)
                                    (SETQ |bfVar#54|
                                            (CONS (CAR |u|) |bfVar#54|)))))
                             (SETQ |bfVar#53| (CDR |bfVar#53|))))
                          NIL |PrincipalSecondaries| NIL))
                 (COND
                  (((LAMBDA (|bfVar#56| |bfVar#55| |u|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#55|)
                             (PROGN (SETQ |u| (CAR |bfVar#55|)) NIL))
                         (RETURN |bfVar#56|))
                        (#1#
                         (PROGN
                          (SETQ |bfVar#56|
                                  (|member| |u| |necessarySecondaries|))
                          (COND ((NOT |bfVar#56|) (RETURN NIL))))))
                       (SETQ |bfVar#55| (CDR |bfVar#55|))))
                    T |secondaries| NIL)
                   (CONS T
                         ((LAMBDA (|bfVar#58| |bfVar#57| |u|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#57|)
                                   (PROGN (SETQ |u| (CAR |bfVar#57|)) NIL))
                               (RETURN (NREVERSE |bfVar#58|)))
                              (#1# (SETQ |bfVar#58| (CONS T |bfVar#58|))))
                             (SETQ |bfVar#57| (CDR |bfVar#57|))))
                          NIL |secondaries| NIL)))
                  (#1#
                   (PROGN
                    (SETQ |HackSlot4|
                            (COND ((NULL |MaximalPrimary|) NIL)
                                  ((EQUAL |MinimalPrimary| |MaximalPrimary|)
                                   NIL)
                                  (#1#
                                   (PROGN
                                    (SETQ |MaximalPrimaries|
                                            (CONS |MaximalPrimary|
                                                  (CAR
                                                   (ELT
                                                    (|CatEval|
                                                     |MaximalPrimary|)
                                                    4))))
                                    (SETQ |MinimalPrimaries|
                                            (CONS |MinimalPrimary|
                                                  (CAR
                                                   (ELT
                                                    (|CatEval|
                                                     |MinimalPrimary|)
                                                    4))))
                                    (SETQ |MaximalPrimaries|
                                            (|set_difference|
                                             |MaximalPrimaries|
                                             |MinimalPrimaries|))
                                    ((LAMBDA (|bfVar#60| |bfVar#59| |x|)
                                       (LOOP
                                        (COND
                                         ((OR (ATOM |bfVar#59|)
                                              (PROGN
                                               (SETQ |x| (CAR |bfVar#59|))
                                               NIL))
                                          (RETURN (NREVERSE |bfVar#60|)))
                                         (#1#
                                          (SETQ |bfVar#60|
                                                  (CONS (LIST |x|)
                                                        |bfVar#60|))))
                                        (SETQ |bfVar#59| (CDR |bfVar#59|))))
                                     NIL |MaximalPrimaries| NIL)))))
                    (SETQ |Conditions|
                            (|InvestigateConditions,Conds| |principal| NIL))
                    (SETQ |Conditions|
                            (EFFACE NIL
                             ((LAMBDA (|bfVar#68| |bfVar#67| |u|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#67|)
                                       (PROGN (SETQ |u| (CAR |bfVar#67|)) NIL))
                                   (RETURN (NREVERSE |bfVar#68|)))
                                  (#1#
                                   (SETQ |bfVar#68|
                                           (CONS (EFFACE NIL |u|)
                                                 |bfVar#68|))))
                                 (SETQ |bfVar#67| (CDR |bfVar#67|))))
                              NIL |Conditions| NIL)))
                    (SETQ |partList|
                            ((LAMBDA (|bfVar#70| |bfVar#69| |cond|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#69|)
                                      (PROGN
                                       (SETQ |cond| (CAR |bfVar#69|))
                                       NIL))
                                  (RETURN (NREVERSE |bfVar#70|)))
                                 (#1#
                                  (SETQ |bfVar#70|
                                          (CONS
                                           (|getViewsConditions|
                                            (|partPessimise| |principal|
                                             |cond|)
                                            |e|)
                                           |bfVar#70|))))
                                (SETQ |bfVar#69| (CDR |bfVar#69|))))
                             NIL |Conditions| NIL))
                    (SETQ |masterSecondaries| |secondaries|)
                    ((LAMBDA (|bfVar#71| |u|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#71|)
                              (PROGN (SETQ |u| (CAR |bfVar#71|)) NIL))
                          (RETURN NIL))
                         (#1#
                          ((LAMBDA (|bfVar#73| |bfVar#72|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#73|)
                                    (PROGN
                                     (SETQ |bfVar#72| (CAR |bfVar#73|))
                                     NIL))
                                (RETURN NIL))
                               (#1#
                                (AND (CONSP |bfVar#72|)
                                     (PROGN (SETQ |v| (CAR |bfVar#72|)) #1#)
                                     (COND
                                      ((NULL (|member| |v| |secondaries|))
                                       (SETQ |secondaries|
                                               (CONS |v| |secondaries|)))))))
                              (SETQ |bfVar#73| (CDR |bfVar#73|))))
                           |u| NIL)))
                        (SETQ |bfVar#71| (CDR |bfVar#71|))))
                     |partList| NIL)
                    (SETQ LIST
                            ((LAMBDA (|bfVar#75| |bfVar#74| |u|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#74|)
                                      (PROGN (SETQ |u| (CAR |bfVar#74|)) NIL))
                                  (RETURN (NREVERSE |bfVar#75|)))
                                 (#1#
                                  (SETQ |bfVar#75|
                                          (CONS
                                           (|InvestigateConditions,mkNilT|
                                            (|member| |u|
                                             |necessarySecondaries|))
                                           |bfVar#75|))))
                                (SETQ |bfVar#74| (CDR |bfVar#74|))))
                             NIL |secondaries| NIL))
                    ((LAMBDA (|bfVar#76| |u| |bfVar#77| |newS|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#76|)
                              (PROGN (SETQ |u| (CAR |bfVar#76|)) NIL)
                              (ATOM |bfVar#77|)
                              (PROGN (SETQ |newS| (CAR |bfVar#77|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (PROGN
                           (SETQ |u|
                                   (COND ((EQL (LENGTH |u|) 1) (CAR |u|))
                                         (#1# (CONS 'AND |u|))))
                           ((LAMBDA (|bfVar#79| |bfVar#78|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#79|)
                                     (PROGN
                                      (SETQ |bfVar#78| (CAR |bfVar#79|))
                                      NIL))
                                 (RETURN NIL))
                                (#1#
                                 (AND (CONSP |bfVar#78|)
                                      (PROGN (SETQ |v| (CAR |bfVar#78|)) #1#)
                                      ((LAMBDA (|bfVar#80| |v'|)
                                         (LOOP
                                          (COND
                                           ((OR (ATOM |bfVar#80|)
                                                (PROGN
                                                 (SETQ |v'| (CAR |bfVar#80|))
                                                 NIL))
                                            (RETURN NIL))
                                           (#1#
                                            (COND
                                             ((SETQ |w|
                                                      (|assoc| |v'|
                                                       |HackSlot4|))
                                              (|rplac| (CDR |w|)
                                               (COND
                                                ((CDR |w|)
                                                 (|mkOr| |u| (CDR |w|)))
                                                (#1# |u|)))))))
                                          (SETQ |bfVar#80| (CDR |bfVar#80|))))
                                       (CONS |v| (CAR (ELT (|CatEval| |v|) 4)))
                                       NIL))))
                               (SETQ |bfVar#79| (CDR |bfVar#79|))))
                            |newS| NIL)
                           (SETQ LIST
                                   (|InvestigateConditions,update| LIST |u|
                                    |secondaries| |newS|)))))
                        (SETQ |bfVar#76| (CDR |bfVar#76|))
                        (SETQ |bfVar#77| (CDR |bfVar#77|))))
                     |Conditions| NIL |partList| NIL)
                    (SETQ LIST (|ICformat_loop| LIST |secondaries| |e|))
                    (CONS T
                          ((LAMBDA (|bfVar#87| |bfVar#86| |ms|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#86|)
                                    (PROGN (SETQ |ms| (CAR |bfVar#86|)) NIL))
                                (RETURN (NREVERSE |bfVar#87|)))
                               (#1#
                                (SETQ |bfVar#87|
                                        (CONS (LASSOC |ms| LIST) |bfVar#87|))))
                              (SETQ |bfVar#86| (CDR |bfVar#86|))))
                           NIL |masterSecondaries| NIL)))))))))))))))
(DEFUN |InvestigateConditions,update| (LIST |cond| |secondaries| |newS|)
  (PROG (|list2|)
    (RETURN
     (PROGN
      (SETQ |list2|
              ((LAMBDA (|bfVar#83| |bfVar#81| |sec| |bfVar#82| |old|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#81|)
                        (PROGN (SETQ |sec| (CAR |bfVar#81|)) NIL)
                        (ATOM |bfVar#82|)
                        (PROGN (SETQ |old| (CAR |bfVar#82|)) NIL))
                    (RETURN (NREVERSE |bfVar#83|)))
                   ('T
                    (SETQ |bfVar#83|
                            (CONS
                             (|InvestigateConditions,flist| |sec| |newS| |old|
                              |cond|)
                             |bfVar#83|))))
                  (SETQ |bfVar#81| (CDR |bfVar#81|))
                  (SETQ |bfVar#82| (CDR |bfVar#82|))))
               NIL |secondaries| NIL LIST NIL))
      |list2|))))
(DEFUN |InvestigateConditions,flist| (|sec| |newS| |old| |cond|)
  (PROG (|newS2| |morecond| |cond2|)
    (RETURN
     (COND ((EQUAL |old| T) |old|)
           (#1='T
            (PROGN
             ((LAMBDA (|bfVar#85| |bfVar#84|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#85|)
                       (PROGN (SETQ |bfVar#84| (CAR |bfVar#85|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |bfVar#84|)
                        (PROGN
                         (SETQ |newS2| (CAR |bfVar#84|))
                         (SETQ |morecond| (CDR |bfVar#84|))
                         #1#)
                        (SETQ |old|
                                (COND
                                 ((NULL (|AncestorP| |sec| (LIST |newS2|)))
                                  |old|)
                                 (#1#
                                  (PROGN
                                   (SETQ |cond2| (|mkAnd| |cond| |morecond|))
                                   (COND ((NULL |old|) |cond2|)
                                         (#1# (|mkOr| |cond2| |old|))))))))))
                 (SETQ |bfVar#85| (CDR |bfVar#85|))))
              |newS| NIL)
             |old|))))))
(DEFUN |InvestigateConditions,mkNilT| (|u|)
  (PROG () (RETURN (COND (|u| T) ('T NIL)))))
(DEFUN |InvestigateConditions,Conds| (|code| |previous|)
  (PROG (|ISTMP#1| |ISTMP#2| |b| |a| |ISTMP#3| |c| |l|)
    (RETURN
     (COND ((ATOM |code|) (LIST |previous|))
           ((AND (CONSP |code|) (EQ (CAR |code|) '|DomainSubstitutionMacro|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |code|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T))))))
            (|InvestigateConditions,Conds| |b| |previous|))
           ((AND (CONSP |code|) (EQ (CAR |code|) 'IF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |code|))
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
                                    (SETQ |c| (CAR |ISTMP#3|))
                                    #1#))))))))
            (|union| (|InvestigateConditions,Conds| |b| (CONS |a| |previous|))
             (|InvestigateConditions,Conds| |c| |previous|)))
           ((AND (CONSP |code|) (EQ (CAR |code|) 'PROGN)
                 (PROGN (SETQ |l| (CDR |code|)) #1#))
            ((LAMBDA (|bfVar#62| |bfVar#61| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#61|)
                      (PROGN (SETQ |u| (CAR |bfVar#61|)) NIL))
                  (RETURN |bfVar#62|))
                 (#1#
                  (SETQ |bfVar#62|
                          (|union| |bfVar#62|
                           (|InvestigateConditions,Conds| |u| |previous|)))))
                (SETQ |bfVar#61| (CDR |bfVar#61|))))
             NIL |l| NIL))
           ((AND (CONSP |code|) (EQ (CAR |code|) 'CATEGORY)
                 (PROGN (SETQ |l| (CDR |code|)) #1#))
            ((LAMBDA (|bfVar#64| |bfVar#63| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#63|)
                      (PROGN (SETQ |u| (CAR |bfVar#63|)) NIL))
                  (RETURN |bfVar#64|))
                 (#1#
                  (SETQ |bfVar#64|
                          (|union| |bfVar#64|
                           (|InvestigateConditions,Conds| |u| |previous|)))))
                (SETQ |bfVar#63| (CDR |bfVar#63|))))
             NIL |l| NIL))
           ((AND (CONSP |code|) (EQ (CAR |code|) '|Join|)
                 (PROGN (SETQ |l| (CDR |code|)) #1#))
            ((LAMBDA (|bfVar#66| |bfVar#65| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#65|)
                      (PROGN (SETQ |u| (CAR |bfVar#65|)) NIL))
                  (RETURN |bfVar#66|))
                 (#1#
                  (SETQ |bfVar#66|
                          (|union| |bfVar#66|
                           (|InvestigateConditions,Conds| |u| |previous|)))))
                (SETQ |bfVar#65| (CDR |bfVar#65|))))
             NIL |l| NIL))
           (#1# (LIST |previous|))))))
(DEFUN |InvestigateConditions,pessimise| (|a| |Conditions|)
  (PROG (|ISTMP#1| |cond| |LETTMP#1| |r1| |r2|)
    (RETURN
     (COND ((ATOM |a|) (LIST |a| |Conditions|))
           ((AND (CONSP |a|) (EQ (CAR |a|) 'SIGNATURE))
            (LIST |a| |Conditions|))
           ((AND (CONSP |a|) (EQ (CAR |a|) 'IF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |a|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |cond| (CAR |ISTMP#1|)) #1='T))))
            (PROGN
             (COND
              ((NULL (|member| |cond| |Conditions|))
               (SETQ |Conditions| (LIST |cond| |Conditions|))))
             (LIST NIL |Conditions|)))
           (#1#
            (PROGN
             (SETQ |LETTMP#1|
                     (|InvestigateConditions,pessimise| (CAR |a|)
                      |Conditions|))
             (SETQ |r1| (CAR |LETTMP#1|))
             (SETQ |Conditions| (CADR |LETTMP#1|))
             (SETQ |LETTMP#1|
                     (|InvestigateConditions,pessimise| (CDR |a|)
                      |Conditions|))
             (SETQ |r2| (CAR |LETTMP#1|))
             (SETQ |Conditions| (CADR |LETTMP#1|))
             (LIST (CONS |r1| |r2|) |Conditions|)))))))

; ICformat_loop(list, secondaries, e) ==
;   $ICformat_hash : local := MAKE_HASHTABLE('EQUAL)
;   [[sec, :ICformat(u, e)] for u in list for sec in secondaries]

(DEFUN |ICformat_loop| (LIST |secondaries| |e|)
  (PROG (|$ICformat_hash|)
    (DECLARE (SPECIAL |$ICformat_hash|))
    (RETURN
     (PROGN
      (SETQ |$ICformat_hash| (MAKE_HASHTABLE 'EQUAL))
      ((LAMBDA (|bfVar#90| |bfVar#88| |u| |bfVar#89| |sec|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#88|) (PROGN (SETQ |u| (CAR |bfVar#88|)) NIL)
                (ATOM |bfVar#89|) (PROGN (SETQ |sec| (CAR |bfVar#89|)) NIL))
            (RETURN (NREVERSE |bfVar#90|)))
           ('T
            (SETQ |bfVar#90|
                    (CONS (CONS |sec| (|ICformat| |u| |e|)) |bfVar#90|))))
          (SETQ |bfVar#88| (CDR |bfVar#88|))
          (SETQ |bfVar#89| (CDR |bfVar#89|))))
       NIL LIST NIL |secondaries| NIL)))))

; ORreduce l ==
;     for u in l | u is ['AND, :.] or u is ['and, :.] repeat
;                                   --check that B causes (and A B) to go
;         for v in l | not (v = u) repeat
;             if member(v, u) or (and/[member(w, u) for w in v]) then
;                 l := delete(u, l)
;                        --v subsumes u
;                            --Note that we are ignoring AND as a component.
;                            --Convince yourself that this code still works
;     l

(DEFUN |ORreduce| (|l|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#91| |u|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#91|) (PROGN (SETQ |u| (CAR |bfVar#91|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND
             (OR (AND (CONSP |u|) (EQ (CAR |u|) 'AND))
                 (AND (CONSP |u|) (EQ (CAR |u|) '|and|)))
             ((LAMBDA (|bfVar#92| |v|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#92|)
                       (PROGN (SETQ |v| (CAR |bfVar#92|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (NULL (EQUAL |v| |u|))
                        (COND
                         ((OR (|member| |v| |u|)
                              ((LAMBDA (|bfVar#94| |bfVar#93| |w|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#93|)
                                        (PROGN
                                         (SETQ |w| (CAR |bfVar#93|))
                                         NIL))
                                    (RETURN |bfVar#94|))
                                   (#1#
                                    (PROGN
                                     (SETQ |bfVar#94| (|member| |w| |u|))
                                     (COND ((NOT |bfVar#94|) (RETURN NIL))))))
                                  (SETQ |bfVar#93| (CDR |bfVar#93|))))
                               T |v| NIL))
                          (SETQ |l| (|delete| |u| |l|)))))))
                 (SETQ |bfVar#92| (CDR |bfVar#92|))))
              |l| NIL))))
          (SETQ |bfVar#91| (CDR |bfVar#91|))))
       |l| NIL)
      |l|))))

; ICformat(u, e) ==
;       atom u => u
;       u is ['has,:.] =>
;           (res := HGET($ICformat_hash, u)) => res
;           res := compHasFormat(u, e)
;           HPUT($ICformat_hash, u, res)
;           res
;       u is ['AND,:l] or u is ['and,:l] =>
;         l:= REMDUP [ICformat(v, e) for [v,:l'] in tails l | not member(v,l')]
;              -- we could have duplicates after, even if not before
;         LENGTH l=1 => first l
;         l1:= first l
;         for u in rest l repeat
;           l1:=mkAnd(u,l1)
;         l1
;       u is ['OR,:l] =>
;         (l := ORreduce l)
;         LENGTH l=1 => ICformat(first l, e)
;         l:= ORreduce REMDUP [ICformat(u, e) for u in l]
;                  --causes multiple ANDs to be squashed, etc.
;                  -- and duplicates that have been built up by tidying
;         (l:= Hasreduce l) where
;           Hasreduce l ==
;             for u in l | u is ['HasCategory,name,cond] and cond is ['QUOTE,
;               cond] repeat
;                                   --check that v causes descendants to go
;                 for v in l | not (v=u) and v is ['HasCategory, =name,['QUOTE,
;                   cond2]] repeat if DescendantP(cond,cond2) then l:= delete(u,l)
;                        --v subsumes u
;             for u in l | u is ['AND,:l'] or u is ['and,:l'] repeat
;               for u' in l' | u' is ['HasCategory,name,cond] and cond is ['QUOTE,
;                 cond] repeat
;                                     --check that v causes descendants to go
;                   for v in l | v is ['HasCategory, =name,['QUOTE,
;                     cond2]] repeat if DescendantP(cond,cond2) then l:= delete(u,l)
;                          --v subsumes u
;             l
;         LENGTH l=1 => first l
;         ['OR,:l]
;       systemErrorHere '"ICformat"

(DEFUN |ICformat| (|u| |e|)
  (PROG (|res| |l| |v| |l'| |l1|)
    (RETURN
     (COND ((ATOM |u|) |u|)
           ((AND (CONSP |u|) (EQ (CAR |u|) '|has|))
            (COND ((SETQ |res| (HGET |$ICformat_hash| |u|)) |res|)
                  (#1='T
                   (PROGN
                    (SETQ |res| (|compHasFormat| |u| |e|))
                    (HPUT |$ICformat_hash| |u| |res|)
                    |res|))))
           ((OR
             (AND (CONSP |u|) (EQ (CAR |u|) 'AND)
                  (PROGN (SETQ |l| (CDR |u|)) #1#))
             (AND (CONSP |u|) (EQ (CAR |u|) '|and|)
                  (PROGN (SETQ |l| (CDR |u|)) #1#)))
            (PROGN
             (SETQ |l|
                     (REMDUP
                      ((LAMBDA (|bfVar#96| |bfVar#95|)
                         (LOOP
                          (COND
                           ((ATOM |bfVar#95|) (RETURN (NREVERSE |bfVar#96|)))
                           (#1#
                            (AND (CONSP |bfVar#95|)
                                 (PROGN
                                  (SETQ |v| (CAR |bfVar#95|))
                                  (SETQ |l'| (CDR |bfVar#95|))
                                  #1#)
                                 (NULL (|member| |v| |l'|))
                                 (SETQ |bfVar#96|
                                         (CONS (|ICformat| |v| |e|)
                                               |bfVar#96|)))))
                          (SETQ |bfVar#95| (CDR |bfVar#95|))))
                       NIL |l|)))
             (COND ((EQL (LENGTH |l|) 1) (CAR |l|))
                   (#1#
                    (PROGN
                     (SETQ |l1| (CAR |l|))
                     ((LAMBDA (|bfVar#97| |u|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#97|)
                               (PROGN (SETQ |u| (CAR |bfVar#97|)) NIL))
                           (RETURN NIL))
                          (#1# (SETQ |l1| (|mkAnd| |u| |l1|))))
                         (SETQ |bfVar#97| (CDR |bfVar#97|))))
                      (CDR |l|) NIL)
                     |l1|)))))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'OR)
                 (PROGN (SETQ |l| (CDR |u|)) #1#))
            (PROGN
             (SETQ |l| (|ORreduce| |l|))
             (COND ((EQL (LENGTH |l|) 1) (|ICformat| (CAR |l|) |e|))
                   (#1#
                    (PROGN
                     (SETQ |l|
                             (|ORreduce|
                              (REMDUP
                               ((LAMBDA (|bfVar#99| |bfVar#98| |u|)
                                  (LOOP
                                   (COND
                                    ((OR (ATOM |bfVar#98|)
                                         (PROGN
                                          (SETQ |u| (CAR |bfVar#98|))
                                          NIL))
                                     (RETURN (NREVERSE |bfVar#99|)))
                                    (#1#
                                     (SETQ |bfVar#99|
                                             (CONS (|ICformat| |u| |e|)
                                                   |bfVar#99|))))
                                   (SETQ |bfVar#98| (CDR |bfVar#98|))))
                                NIL |l| NIL))))
                     (SETQ |l| (|ICformat,Hasreduce| |l|))
                     (COND ((EQL (LENGTH |l|) 1) (CAR |l|))
                           (#1# (CONS 'OR |l|))))))))
           (#1# (|systemErrorHere| "ICformat"))))))
(DEFUN |ICformat,Hasreduce| (|l|)
  (PROG (|ISTMP#1| |name| |ISTMP#2| |cond| |ISTMP#3| |ISTMP#4| |cond2| |l'|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#100| |u|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#100|) (PROGN (SETQ |u| (CAR |bfVar#100|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |u|) (EQ (CAR |u|) '|HasCategory|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |name| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |cond| (CAR |ISTMP#2|)) #1#)))))
                 (CONSP |cond|) (EQ (CAR |cond|) 'QUOTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |cond|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |cond| (CAR |ISTMP#1|)) #1#)))
                 ((LAMBDA (|bfVar#101| |v|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#101|)
                           (PROGN (SETQ |v| (CAR |bfVar#101|)) NIL))
                       (RETURN NIL))
                      (#1#
                       (AND (NULL (EQUAL |v| |u|)) (CONSP |v|)
                            (EQ (CAR |v|) '|HasCategory|)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |v|))
                             (AND (CONSP |ISTMP#1|)
                                  (EQUAL (CAR |ISTMP#1|) |name|)
                                  (PROGN
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                         (AND (CONSP |ISTMP#3|)
                                              (EQ (CAR |ISTMP#3|) 'QUOTE)
                                              (PROGN
                                               (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                               (AND (CONSP |ISTMP#4|)
                                                    (EQ (CDR |ISTMP#4|) NIL)
                                                    (PROGN
                                                     (SETQ |cond2|
                                                             (CAR |ISTMP#4|))
                                                     #1#)))))))))
                            (COND
                             ((|DescendantP| |cond| |cond2|)
                              (SETQ |l| (|delete| |u| |l|)))))))
                     (SETQ |bfVar#101| (CDR |bfVar#101|))))
                  |l| NIL))))
          (SETQ |bfVar#100| (CDR |bfVar#100|))))
       |l| NIL)
      ((LAMBDA (|bfVar#102| |u|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#102|) (PROGN (SETQ |u| (CAR |bfVar#102|)) NIL))
            (RETURN NIL))
           (#1#
            (AND
             (OR
              (AND (CONSP |u|) (EQ (CAR |u|) 'AND)
                   (PROGN (SETQ |l'| (CDR |u|)) #1#))
              (AND (CONSP |u|) (EQ (CAR |u|) '|and|)
                   (PROGN (SETQ |l'| (CDR |u|)) #1#)))
             ((LAMBDA (|bfVar#103| |u'|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#103|)
                       (PROGN (SETQ |u'| (CAR |bfVar#103|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |u'|) (EQ (CAR |u'|) '|HasCategory|)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |u'|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |name| (CAR |ISTMP#1|))
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                    (PROGN
                                     (SETQ |cond| (CAR |ISTMP#2|))
                                     #1#)))))
                        (CONSP |cond|) (EQ (CAR |cond|) 'QUOTE)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |cond|))
                         (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                              (PROGN (SETQ |cond| (CAR |ISTMP#1|)) #1#)))
                        ((LAMBDA (|bfVar#104| |v|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#104|)
                                  (PROGN (SETQ |v| (CAR |bfVar#104|)) NIL))
                              (RETURN NIL))
                             (#1#
                              (AND (CONSP |v|) (EQ (CAR |v|) '|HasCategory|)
                                   (PROGN
                                    (SETQ |ISTMP#1| (CDR |v|))
                                    (AND (CONSP |ISTMP#1|)
                                         (EQUAL (CAR |ISTMP#1|) |name|)
                                         (PROGN
                                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                          (AND (CONSP |ISTMP#2|)
                                               (EQ (CDR |ISTMP#2|) NIL)
                                               (PROGN
                                                (SETQ |ISTMP#3|
                                                        (CAR |ISTMP#2|))
                                                (AND (CONSP |ISTMP#3|)
                                                     (EQ (CAR |ISTMP#3|)
                                                         'QUOTE)
                                                     (PROGN
                                                      (SETQ |ISTMP#4|
                                                              (CDR |ISTMP#3|))
                                                      (AND (CONSP |ISTMP#4|)
                                                           (EQ (CDR |ISTMP#4|)
                                                               NIL)
                                                           (PROGN
                                                            (SETQ |cond2|
                                                                    (CAR
                                                                     |ISTMP#4|))
                                                            #1#)))))))))
                                   (COND
                                    ((|DescendantP| |cond| |cond2|)
                                     (SETQ |l| (|delete| |u| |l|)))))))
                            (SETQ |bfVar#104| (CDR |bfVar#104|))))
                         |l| NIL))))
                 (SETQ |bfVar#103| (CDR |bfVar#103|))))
              |l'| NIL))))
          (SETQ |bfVar#102| (CDR |bfVar#102|))))
       |l| NIL)
      |l|))))

; partPessimise(a,trueconds) ==
;   atom a => a
;   a is ['SIGNATURE,:.] => a
;   a is ['IF,cond,:.] => (member(cond,trueconds) => a; nil)
;   [partPessimise(first a,trueconds),:partPessimise(rest a,trueconds)]

(DEFUN |partPessimise| (|a| |trueconds|)
  (PROG (|ISTMP#1| |cond|)
    (RETURN
     (COND ((ATOM |a|) |a|) ((AND (CONSP |a|) (EQ (CAR |a|) 'SIGNATURE)) |a|)
           ((AND (CONSP |a|) (EQ (CAR |a|) 'IF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |a|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |cond| (CAR |ISTMP#1|)) #1='T))))
            (COND ((|member| |cond| |trueconds|) |a|) (#1# NIL)))
           (#1#
            (CONS (|partPessimise| (CAR |a|) |trueconds|)
                  (|partPessimise| (CDR |a|) |trueconds|)))))))

; getViewsConditions(u, e) ==
;
;   --returns a list of all the categories that can be views of this one
;   --paired with the condition under which they are such views
;   [vec, :.] := compMakeCategoryObject(u, e) or
;     systemErrorHere '"getViewsConditions"
;   views:= [[first u,:CADR u] for u in CADR vec.4]
;   null vec.0 =>
; --+
;     null first(vec.4) => views
;     [[CAAR vec.4,:true],:views] --*
;   [[vec.0,:true],:views] --*

(DEFUN |getViewsConditions| (|u| |e|)
  (PROG (|LETTMP#1| |vec| |views|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1|
              (OR (|compMakeCategoryObject| |u| |e|)
                  (|systemErrorHere| "getViewsConditions")))
      (SETQ |vec| (CAR |LETTMP#1|))
      (SETQ |views|
              ((LAMBDA (|bfVar#106| |bfVar#105| |u|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#105|)
                        (PROGN (SETQ |u| (CAR |bfVar#105|)) NIL))
                    (RETURN (NREVERSE |bfVar#106|)))
                   (#1='T
                    (SETQ |bfVar#106|
                            (CONS (CONS (CAR |u|) (CADR |u|)) |bfVar#106|))))
                  (SETQ |bfVar#105| (CDR |bfVar#105|))))
               NIL (CADR (ELT |vec| 4)) NIL))
      (COND
       ((NULL (ELT |vec| 0))
        (COND ((NULL (CAR (ELT |vec| 4))) |views|)
              (#1# (CONS (CONS (CAAR (ELT |vec| 4)) T) |views|))))
       (#1# (CONS (CONS (ELT |vec| 0) T) |views|)))))))

; DescendCodeVarAdd(base, flag, kvec, e) ==
;    princview := kvec
;    [SetFunctionSlots(sig, SUBST('ELT,'CONST,implem), flag, kvec) repeat
;        for i in 6..MAXINDEX princview |
;          princview.i is [sig:=[op,types],:.] and
;            LASSOC([base, :SUBST(base, '$, types)], get(op, 'modemap, e)) is
;                   [[pred,implem]]]

(DEFUN |DescendCodeVarAdd| (|base| |flag| |kvec| |e|)
  (PROG (|princview| |ISTMP#1| |ISTMP#2| |op| |ISTMP#3| |types| |sig| |pred|
         |implem|)
    (RETURN
     (PROGN
      (SETQ |princview| |kvec|)
      ((LAMBDA (|bfVar#108| |bfVar#107| |i|)
         (LOOP
          (COND ((> |i| |bfVar#107|) (RETURN (NREVERSE |bfVar#108|)))
                (#1='T
                 (AND
                  (PROGN
                   (SETQ |ISTMP#1| (ELT |princview| |i|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |ISTMP#2| #2=(CAR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN
                               (SETQ |op| (CAR |ISTMP#2|))
                               (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                               (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                    (PROGN
                                     (SETQ |types| (CAR |ISTMP#3|))
                                     #1#)))))
                        (PROGN (SETQ |sig| #2#) #1#)))
                  (PROGN
                   (SETQ |ISTMP#1|
                           (LASSOC (CONS |base| (SUBST |base| '$ |types|))
                            (|get| |op| '|modemap| |e|)))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN
                         (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN
                               (SETQ |pred| (CAR |ISTMP#2|))
                               (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                               (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                    (PROGN
                                     (SETQ |implem| (CAR |ISTMP#3|))
                                     #1#)))))))
                  (SETQ |bfVar#108|
                          (CONS
                           (|SetFunctionSlots| |sig|
                            (SUBST 'ELT 'CONST |implem|) |flag| |kvec|)
                           |bfVar#108|)))))
          (SETQ |i| (+ |i| 1))))
       NIL (MAXINDEX |princview|) 6)))))

; resolvePatternVars(p,args) ==
;   p := SUBLISLIS(args, $TriangleVariableList, p)
;   SUBLISLIS(args, $FormalMapVariableList, p)

(DEFUN |resolvePatternVars| (|p| |args|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |p| (SUBLISLIS |args| |$TriangleVariableList| |p|))
      (SUBLISLIS |args| |$FormalMapVariableList| |p|)))))

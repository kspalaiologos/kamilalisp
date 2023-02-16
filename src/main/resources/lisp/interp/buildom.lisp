
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($noCategoryDomains, '(Mode))

(DEFPARAMETER |$noCategoryDomains| '(|Mode|))

; DEFPARAMETER($nonLisplibDomains,
;   APPEND($Primitives,$noCategoryDomains))

(DEFPARAMETER |$nonLisplibDomains| (APPEND |$Primitives| |$noCategoryDomains|))

; isRecord type == type is ['Record,:.]

(DEFUN |isRecord| (|type|)
  (PROG () (RETURN (AND (CONSP |type|) (EQ (CAR |type|) '|Record|)))))

; Record0 args ==
;     dom := GETREFV 11
;     -- JHD added an extra slot to cache EQUAL methods
;     dom.0 := ['Record, :[['_:, first a, devaluate rest a] for a in args]]
;     dom.1 :=
;            [function lookupInTable,dom,
;                [['_=,[[['Boolean],'_$,'_$],:6]],
;                 ['_~_=,[[['Boolean],'_$,'_$],:10]],
;                  ['coerce, [[$OutputForm, '_$], :7]]]]
;     dom.2 := NIL
;     dom.3 := ['RecordCategory,:QCDR dom.0]
;     dom.4 :=
;           [[ '(SetCategory) ], [ '(BasicType),
;              '(CoercibleTo (OutputForm)), '(SetCategory) ]]
;     dom.5 := [rest a for a in args]
;     dom.6 := [function RecordEqual, :dom]
;     dom.7 := [function RecordPrint, :dom]
;     dom.8 := [function Undef, :dom]
;   -- following is cache for equality functions
;     dom.9 := if (n:= LENGTH args) <= 2
;               then [NIL,:NIL]
;               else GETREFV n
;     dom.10 := [function RecordUnEqual, :dom]
;     dom

(DEFUN |Record0| (|args|)
  (PROG (|dom| |n|)
    (RETURN
     (PROGN
      (SETQ |dom| (GETREFV 11))
      (SETF (ELT |dom| 0)
              (CONS '|Record|
                    ((LAMBDA (|bfVar#2| |bfVar#1| |a|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#1|)
                              (PROGN (SETQ |a| (CAR |bfVar#1|)) NIL))
                          (RETURN (NREVERSE |bfVar#2|)))
                         (#1='T
                          (SETQ |bfVar#2|
                                  (CONS
                                   (LIST '|:| (CAR |a|)
                                         (|devaluate| (CDR |a|)))
                                   |bfVar#2|))))
                        (SETQ |bfVar#1| (CDR |bfVar#1|))))
                     NIL |args| NIL)))
      (SETF (ELT |dom| 1)
              (LIST #'|lookupInTable| |dom|
                    (LIST (LIST '= (CONS (LIST (LIST '|Boolean|) '$ '$) 6))
                          (LIST '~= (CONS (LIST (LIST '|Boolean|) '$ '$) 10))
                          (LIST '|coerce| (CONS (LIST |$OutputForm| '$) 7)))))
      (SETF (ELT |dom| 2) NIL)
      (SETF (ELT |dom| 3) (CONS '|RecordCategory| (QCDR (ELT |dom| 0))))
      (SETF (ELT |dom| 4)
              (LIST (LIST '(|SetCategory|))
                    (LIST '(|BasicType|) '(|CoercibleTo| (|OutputForm|))
                          '(|SetCategory|))))
      (SETF (ELT |dom| 5)
              ((LAMBDA (|bfVar#4| |bfVar#3| |a|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#3|)
                        (PROGN (SETQ |a| (CAR |bfVar#3|)) NIL))
                    (RETURN (NREVERSE |bfVar#4|)))
                   (#1# (SETQ |bfVar#4| (CONS (CDR |a|) |bfVar#4|))))
                  (SETQ |bfVar#3| (CDR |bfVar#3|))))
               NIL |args| NIL))
      (SETF (ELT |dom| 6) (CONS #'|RecordEqual| |dom|))
      (SETF (ELT |dom| 7) (CONS #'|RecordPrint| |dom|))
      (SETF (ELT |dom| 8) (CONS #'|Undef| |dom|))
      (SETF (ELT |dom| 9)
              (COND ((NOT (< 2 (SETQ |n| (LENGTH |args|)))) (CONS NIL NIL))
                    (#1# (GETREFV |n|))))
      (SETF (ELT |dom| 10) (CONS #'|RecordUnEqual| |dom|))
      |dom|))))

; RecordEqual(x,y,dom) ==
;   PAIRP x =>
;     b:=
;        SPADCALL(first x, first y, first(dom.9) or
;                            first RPLACA(dom.9, findEqualFun(dom.5.0)))
;     NULL rest(dom.5) => b
;     b and
;        SPADCALL(rest x, rest y, rest(dom.9) or
;                            rest RPLACD(dom.9, findEqualFun(dom.5.1)))
;   VECP x =>
;     equalfuns := dom.9
;     and/[SPADCALL(x.i,y.i,equalfuns.i or (equalfuns.i:=findEqualFun(fdom)))
;          for i in 0.. for fdom in dom.5]
;   error '"Bug: Silly record representation"

(DEFUN |RecordEqual| (|x| |y| |dom|)
  (PROG (|b| |equalfuns|)
    (RETURN
     (COND
      ((CONSP |x|)
       (PROGN
        (SETQ |b|
                (SPADCALL (CAR |x|) (CAR |y|)
                 (OR (CAR (ELT |dom| 9))
                     (CAR
                      (RPLACA (ELT |dom| 9)
                              (|findEqualFun| (ELT (ELT |dom| 5) 0)))))))
        (COND ((NULL (CDR (ELT |dom| 5))) |b|)
              (#1='T
               (AND |b|
                    (SPADCALL (CDR |x|) (CDR |y|)
                     (OR (CDR (ELT |dom| 9))
                         (CDR
                          (RPLACD (ELT |dom| 9)
                                  (|findEqualFun|
                                   (ELT (ELT |dom| 5) 1)))))))))))
      ((VECP |x|)
       (PROGN
        (SETQ |equalfuns| (ELT |dom| 9))
        ((LAMBDA (|bfVar#6| |i| |bfVar#5| |fdom|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#5|) (PROGN (SETQ |fdom| (CAR |bfVar#5|)) NIL))
              (RETURN |bfVar#6|))
             (#1#
              (PROGN
               (SETQ |bfVar#6|
                       (SPADCALL (ELT |x| |i|) (ELT |y| |i|)
                        (OR (ELT |equalfuns| |i|)
                            (SETF (ELT |equalfuns| |i|)
                                    (|findEqualFun| |fdom|)))))
               (COND ((NOT |bfVar#6|) (RETURN NIL))))))
            (SETQ |i| (+ |i| 1))
            (SETQ |bfVar#5| (CDR |bfVar#5|))))
         T 0 (ELT |dom| 5) NIL)))
      (#1# (|error| "Bug: Silly record representation"))))))

; RecordUnEqual(x,y,dom) == not(RecordEqual(x,y,dom))

(DEFUN |RecordUnEqual| (|x| |y| |dom|)
  (PROG () (RETURN (NULL (|RecordEqual| |x| |y| |dom|)))))

; RecordPrint(x,dom) == coerceRe2E(x,dom.3)

(DEFUN |RecordPrint| (|x| |dom|)
  (PROG () (RETURN (|coerceRe2E| |x| (ELT |dom| 3)))))

; coerceVal2E(x,m) ==
;    -- first catch "failed" etc.
;    STRINGP m and (x = m) => STRCONC('"_"", x, '"_"")
;    objValUnwrap coerceByFunction(objNewWrap(x, m), $OutputForm)

(DEFUN |coerceVal2E| (|x| |m|)
  (PROG ()
    (RETURN
     (COND ((AND (STRINGP |m|) (EQUAL |x| |m|)) (STRCONC "\"" |x| "\""))
           ('T
            (|objValUnwrap|
             (|coerceByFunction| (|objNewWrap| |x| |m|) |$OutputForm|)))))))

; findEqualFun(dom) ==
;   compiledLookup('_=,[$Boolean,'$,'$],dom)

(DEFUN |findEqualFun| (|dom|)
  (PROG () (RETURN (|compiledLookup| '= (LIST |$Boolean| '$ '$) |dom|))))

; coerceRe2E(x,source) ==
;   n := #rest(source)
;   n = 1 =>
;     ['construct,
;      ['_=, source.1.1, coerceVal2E(first x, source.1.2)] ]
;   n = 2 =>
;     ['construct,
;      ['_=, source.1.1, coerceVal2E(first x, source.1.2)], _
;      ['_=, source.2.1, coerceVal2E(rest x, source.2.2)] ]
;   VECP x =>
;     ['construct,
;      :[['_=,tag,coerceVal2E(x.i, fdom)]
;        for i in 0.. for [.,tag,fdom] in rest source]]
;   error '"Bug: ridiculous record representation"

(DEFUN |coerceRe2E| (|x| |source|)
  (PROG (|n| |ISTMP#1| |tag| |ISTMP#2| |fdom|)
    (RETURN
     (PROGN
      (SETQ |n| (LENGTH (CDR |source|)))
      (COND
       ((EQL |n| 1)
        (LIST '|construct|
              (LIST '= (ELT (ELT |source| 1) 1)
                    (|coerceVal2E| (CAR |x|) (ELT (ELT |source| 1) 2)))))
       ((EQL |n| 2)
        (LIST '|construct|
              (LIST '= (ELT (ELT |source| 1) 1)
                    (|coerceVal2E| (CAR |x|) (ELT (ELT |source| 1) 2)))
              (LIST '= (ELT (ELT |source| 2) 1)
                    (|coerceVal2E| (CDR |x|) (ELT (ELT |source| 2) 2)))))
       ((VECP |x|)
        (CONS '|construct|
              ((LAMBDA (|bfVar#9| |i| |bfVar#8| |bfVar#7|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#8|)
                        (PROGN (SETQ |bfVar#7| (CAR |bfVar#8|)) NIL))
                    (RETURN (NREVERSE |bfVar#9|)))
                   (#1='T
                    (AND (CONSP |bfVar#7|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |bfVar#7|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |tag| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |fdom| (CAR |ISTMP#2|))
                                      #1#)))))
                         (SETQ |bfVar#9|
                                 (CONS
                                  (LIST '= |tag|
                                        (|coerceVal2E| (ELT |x| |i|) |fdom|))
                                  |bfVar#9|)))))
                  (SETQ |i| (+ |i| 1))
                  (SETQ |bfVar#8| (CDR |bfVar#8|))))
               NIL 0 (CDR |source|) NIL)))
       (#1# (|error| "Bug: ridiculous record representation")))))))

; Union(:args) ==
;     dom := GETREFV 10
;     dom.0 := ['Union, :[(if a is ['_:,tag,domval] then ['_:,tag,devaluate domval]
;                           else devaluate a) for a in args]]
;     dom.1 :=
;             [function lookupInTable,dom,
;                [['_=,[[['Boolean],'_$,'_$],:6]],
;                 ['_~_=, [[['Boolean],'_$,'_$],:9]],
;                  ['coerce,[[$OutputForm, '_$],:7]]]]
;     dom.2 := NIL
;     dom.3 :=
;       '(SetCategory)
;     dom.4 :=
;           [[ '(SetCategory) ],[ '(BasicType),
;              '(CoercibleTo (OutputForm)),  '(SetCategory) ]]
;     dom.5 := args
;     dom.6 := [function UnionEqual, :dom]
;     dom.7 := [function UnionPrint, :dom]
;     dom.8 := [function Undef, :dom]
;     dom.9 := [function UnionUnEqual, :dom]
;     dom

(DEFUN |Union| (&REST |args|)
  (PROG (|dom| |ISTMP#1| |tag| |ISTMP#2| |domval|)
    (RETURN
     (PROGN
      (SETQ |dom| (GETREFV 10))
      (SETF (ELT |dom| 0)
              (CONS '|Union|
                    ((LAMBDA (|bfVar#11| |bfVar#10| |a|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#10|)
                              (PROGN (SETQ |a| (CAR |bfVar#10|)) NIL))
                          (RETURN (NREVERSE |bfVar#11|)))
                         (#1='T
                          (SETQ |bfVar#11|
                                  (CONS
                                   (COND
                                    ((AND (CONSP |a|) (EQ (CAR |a|) '|:|)
                                          (PROGN
                                           (SETQ |ISTMP#1| (CDR |a|))
                                           (AND (CONSP |ISTMP#1|)
                                                (PROGN
                                                 (SETQ |tag| (CAR |ISTMP#1|))
                                                 (SETQ |ISTMP#2|
                                                         (CDR |ISTMP#1|))
                                                 (AND (CONSP |ISTMP#2|)
                                                      (EQ (CDR |ISTMP#2|) NIL)
                                                      (PROGN
                                                       (SETQ |domval|
                                                               (CAR |ISTMP#2|))
                                                       #1#))))))
                                     (LIST '|:| |tag| (|devaluate| |domval|)))
                                    (#1# (|devaluate| |a|)))
                                   |bfVar#11|))))
                        (SETQ |bfVar#10| (CDR |bfVar#10|))))
                     NIL |args| NIL)))
      (SETF (ELT |dom| 1)
              (LIST #'|lookupInTable| |dom|
                    (LIST (LIST '= (CONS (LIST (LIST '|Boolean|) '$ '$) 6))
                          (LIST '~= (CONS (LIST (LIST '|Boolean|) '$ '$) 9))
                          (LIST '|coerce| (CONS (LIST |$OutputForm| '$) 7)))))
      (SETF (ELT |dom| 2) NIL)
      (SETF (ELT |dom| 3) '(|SetCategory|))
      (SETF (ELT |dom| 4)
              (LIST (LIST '(|SetCategory|))
                    (LIST '(|BasicType|) '(|CoercibleTo| (|OutputForm|))
                          '(|SetCategory|))))
      (SETF (ELT |dom| 5) |args|)
      (SETF (ELT |dom| 6) (CONS #'|UnionEqual| |dom|))
      (SETF (ELT |dom| 7) (CONS #'|UnionPrint| |dom|))
      (SETF (ELT |dom| 8) (CONS #'|Undef| |dom|))
      (SETF (ELT |dom| 9) (CONS #'|UnionUnEqual| |dom|))
      |dom|))))

; UnionEqual(x, y, dom) ==
;   ['Union,:branches] := dom.0
;   predlist := mkPredList branches
;   same := false
;   res := false
;   for b in stripUnionTags branches for p in predlist while not same repeat
;     p is ["EQCAR", "#1", n] =>
;         EQCAR(x, n) and EQCAR(y, n) =>
;             same := true
;             STRINGP b => res := (x = y)
;             x := rest x
;             y := rest y
;             res := SPADCALL(x, y, findEqualFun(evalDomain b))
;     typeFun := COERCE(['LAMBDA, '(_#1), p], 'FUNCTION)
;     FUNCALL(typeFun,x) and FUNCALL(typeFun,y) =>
;         same := true
;         STRINGP b => res := (x = y)
;         res := SPADCALL(x, y, findEqualFun(evalDomain b))
;   res

(DEFUN |UnionEqual| (|x| |y| |dom|)
  (PROG (|LETTMP#1| |branches| |predlist| |same| |res| |ISTMP#1| |ISTMP#2| |n|
         |typeFun|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (ELT |dom| 0))
      (SETQ |branches| (CDR |LETTMP#1|))
      (SETQ |predlist| (|mkPredList| |branches|))
      (SETQ |same| NIL)
      (SETQ |res| NIL)
      ((LAMBDA (|bfVar#12| |b| |bfVar#13| |p|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#12|) (PROGN (SETQ |b| (CAR |bfVar#12|)) NIL)
                (ATOM |bfVar#13|) (PROGN (SETQ |p| (CAR |bfVar#13|)) NIL)
                |same|)
            (RETURN NIL))
           (#1='T
            (COND
             ((AND (CONSP |p|) (EQ (CAR |p|) 'EQCAR)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |p|))
                    (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|#1|)
                         (PROGN
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ |n| (CAR |ISTMP#2|)) #1#))))))
              (COND
               ((AND (EQCAR |x| |n|) (EQCAR |y| |n|))
                (IDENTITY
                 (PROGN
                  (SETQ |same| T)
                  (COND ((STRINGP |b|) (SETQ |res| (EQUAL |x| |y|)))
                        (#1#
                         (PROGN
                          (SETQ |x| (CDR |x|))
                          (SETQ |y| (CDR |y|))
                          (SETQ |res|
                                  (SPADCALL |x| |y|
                                   (|findEqualFun|
                                    (|evalDomain| |b|))))))))))))
             (#1#
              (PROGN
               (SETQ |typeFun| (COERCE (LIST 'LAMBDA '(|#1|) |p|) 'FUNCTION))
               (COND
                ((AND (FUNCALL |typeFun| |x|) (FUNCALL |typeFun| |y|))
                 (PROGN
                  (SETQ |same| T)
                  (COND ((STRINGP |b|) (SETQ |res| (EQUAL |x| |y|)))
                        (#1#
                         (SETQ |res|
                                 (SPADCALL |x| |y|
                                  (|findEqualFun|
                                   (|evalDomain| |b|))))))))))))))
          (SETQ |bfVar#12| (CDR |bfVar#12|))
          (SETQ |bfVar#13| (CDR |bfVar#13|))))
       (|stripUnionTags| |branches|) NIL |predlist| NIL)
      |res|))))

; UnionUnEqual(x, y, dom) == not(UnionEqual(x, y, dom))

(DEFUN |UnionUnEqual| (|x| |y| |dom|)
  (PROG () (RETURN (NULL (|UnionEqual| |x| |y| |dom|)))))

; UnionPrint(x, dom) == coerceUn2E(x, dom.0)

(DEFUN |UnionPrint| (|x| |dom|)
  (PROG () (RETURN (|coerceUn2E| |x| (ELT |dom| 0)))))

; coerceUn2E(x,source) ==
;   ['Union,:branches] := source
;   predlist := mkPredList branches
;   found := false
;   for b in stripUnionTags branches for p in predlist while not(found) repeat
;       found :=
;           p is ["EQCAR", "#1", n] => EQCAR(x, n)
;           typeFun := COERCE(['LAMBDA, '(_#1), p], 'FUNCTION)
;           FUNCALL(typeFun,x)
;       if found then
;           if p is ['EQCAR, :.] then x := rest x
;           res := coerceVal2E(x,b)
;   not(found) =>
;     error '"Union bug: Cannot find appropriate branch for coerce to E"
;   res

(DEFUN |coerceUn2E| (|x| |source|)
  (PROG (|branches| |predlist| |found| |ISTMP#1| |ISTMP#2| |n| |typeFun| |res|)
    (RETURN
     (PROGN
      (SETQ |branches| (CDR |source|))
      (SETQ |predlist| (|mkPredList| |branches|))
      (SETQ |found| NIL)
      ((LAMBDA (|bfVar#14| |b| |bfVar#15| |p|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#14|) (PROGN (SETQ |b| (CAR |bfVar#14|)) NIL)
                (ATOM |bfVar#15|) (PROGN (SETQ |p| (CAR |bfVar#15|)) NIL)
                |found|)
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |found|
                     (COND
                      ((AND (CONSP |p|) (EQ (CAR |p|) 'EQCAR)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |p|))
                             (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|#1|)
                                  (PROGN
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |n| (CAR |ISTMP#2|))
                                         #1#))))))
                       (EQCAR |x| |n|))
                      (#1#
                       (PROGN
                        (SETQ |typeFun|
                                (COERCE (LIST 'LAMBDA '(|#1|) |p|) 'FUNCTION))
                        (FUNCALL |typeFun| |x|)))))
             (COND
              (|found|
               (COND
                ((AND (CONSP |p|) (EQ (CAR |p|) 'EQCAR)) (SETQ |x| (CDR |x|))))
               (SETQ |res| (|coerceVal2E| |x| |b|)))))))
          (SETQ |bfVar#14| (CDR |bfVar#14|))
          (SETQ |bfVar#15| (CDR |bfVar#15|))))
       (|stripUnionTags| |branches|) NIL |predlist| NIL)
      (COND
       ((NULL |found|)
        (|error| "Union bug: Cannot find appropriate branch for coerce to E"))
       (#1# |res|))))))

; mkPredList listOfEntries ==
;      [['EQCAR,"#1",i] for arg in listOfEntries for i in 0..]

(DEFUN |mkPredList| (|listOfEntries|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#17| |bfVar#16| |arg| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#16|) (PROGN (SETQ |arg| (CAR |bfVar#16|)) NIL))
           (RETURN (NREVERSE |bfVar#17|)))
          ('T (SETQ |bfVar#17| (CONS (LIST 'EQCAR '|#1| |i|) |bfVar#17|))))
         (SETQ |bfVar#16| (CDR |bfVar#16|))
         (SETQ |i| (+ |i| 1))))
      NIL |listOfEntries| NIL 0))))

; Mapping(:args) ==
;     dom := GETREFV 10
;     dom.0 := ['Mapping, :[devaluate a for a in args]]
;     dom.1 :=
;             [function lookupInTable,dom,
;                [['_=,[[['Boolean],'_$,'_$],:6]],
;                  ['coerce,[[$OutputForm, '_$],:7]]]]
;     dom.2 := NIL
;     dom.3 :=
;       '(SetCategory)
;     dom.4 :=
;           [[ '(SetCategory) ],[ '(BasicType),
;              '(CoercibleTo (OutputForm)), '(SetCategory) ]]
;     dom.5 := args
;     dom.6 := [function MappingEqual, :dom]
;     dom.7 := [function MappingPrint, :dom]
;     dom.8 := [function Undef, :dom]
;     dom.9 := [function MappingUnEqual, :dom]
;     dom

(DEFUN |Mapping| (&REST |args|)
  (PROG (|dom|)
    (RETURN
     (PROGN
      (SETQ |dom| (GETREFV 10))
      (SETF (ELT |dom| 0)
              (CONS '|Mapping|
                    ((LAMBDA (|bfVar#19| |bfVar#18| |a|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#18|)
                              (PROGN (SETQ |a| (CAR |bfVar#18|)) NIL))
                          (RETURN (NREVERSE |bfVar#19|)))
                         ('T
                          (SETQ |bfVar#19|
                                  (CONS (|devaluate| |a|) |bfVar#19|))))
                        (SETQ |bfVar#18| (CDR |bfVar#18|))))
                     NIL |args| NIL)))
      (SETF (ELT |dom| 1)
              (LIST #'|lookupInTable| |dom|
                    (LIST (LIST '= (CONS (LIST (LIST '|Boolean|) '$ '$) 6))
                          (LIST '|coerce| (CONS (LIST |$OutputForm| '$) 7)))))
      (SETF (ELT |dom| 2) NIL)
      (SETF (ELT |dom| 3) '(|SetCategory|))
      (SETF (ELT |dom| 4)
              (LIST (LIST '(|SetCategory|))
                    (LIST '(|BasicType|) '(|CoercibleTo| (|OutputForm|))
                          '(|SetCategory|))))
      (SETF (ELT |dom| 5) |args|)
      (SETF (ELT |dom| 6) (CONS #'|MappingEqual| |dom|))
      (SETF (ELT |dom| 7) (CONS #'|MappingPrint| |dom|))
      (SETF (ELT |dom| 8) (CONS #'|Undef| |dom|))
      (SETF (ELT |dom| 9) (CONS #'|MappingUnEqual| |dom|))
      |dom|))))

; MappingEqual(x, y, dom) == EQ(x,y)

(DEFUN |MappingEqual| (|x| |y| |dom|) (PROG () (RETURN (EQ |x| |y|))))

; MappingUnEqual(x, y, dom) == not(EQ(x,y))

(DEFUN |MappingUnEqual| (|x| |y| |dom|) (PROG () (RETURN (NULL (EQ |x| |y|)))))

; MappingPrint(x, dom) == coerceMap2E(x)

(DEFUN |MappingPrint| (|x| |dom|) (PROG () (RETURN (|coerceMap2E| |x|))))

; coerceMap2E(x) ==
;   -- nrlib domain
;   ARRAYP rest x => ['theMap, BPINAME first x,
;     if $testingSystem then 0 else REMAINDER(HASHEQ rest x, 1000)]
;   -- aldor
;   ['theMap, BPINAME first x]

(DEFUN |coerceMap2E| (|x|)
  (PROG ()
    (RETURN
     (COND
      ((ARRAYP (CDR |x|))
       (LIST '|theMap| (BPINAME (CAR |x|))
             (COND (|$testingSystem| 0)
                   (#1='T (REMAINDER (HASHEQ (CDR |x|)) 1000)))))
      (#1# (LIST '|theMap| (BPINAME (CAR |x|))))))))

; Enumeration0(:args) ==
;     dom := GETREFV 10
;     -- JHD added an extra slot to cache EQUAL methods
;     dom.0 := ['Enumeration, :args]
;     dom.1 :=
;            [function lookupInTable,dom,
;                [['_=,[[['Boolean],'_$,'_$],:6]],
;                  ['coerce,[[$OutputForm, '_$],:7], [['_$, $Symbol], :8]]
;                          ]]
;     dom.2 := NIL
;     dom.3 := ['EnumerationCategory,:QCDR dom.0]
;     dom.4 :=
;           [[ '(SetCategory) ], [ '(BasicType),
;              '(CoercibleTo (OutputForm)), '(SetCategory) ]]
;     dom.5 := args
;     dom.6 := [function EnumEqual, :dom]
;     dom.7 := [function EnumPrint, :dom]
;     dom.8 := [function createEnum, :dom]
;     dom.9 := [function EnumUnEqual, :dom]
;     dom

(DEFUN |Enumeration0| (&REST |args|)
  (PROG (|dom|)
    (RETURN
     (PROGN
      (SETQ |dom| (GETREFV 10))
      (SETF (ELT |dom| 0) (CONS '|Enumeration| |args|))
      (SETF (ELT |dom| 1)
              (LIST #'|lookupInTable| |dom|
                    (LIST (LIST '= (CONS (LIST (LIST '|Boolean|) '$ '$) 6))
                          (LIST '|coerce| (CONS (LIST |$OutputForm| '$) 7)
                                (CONS (LIST '$ |$Symbol|) 8)))))
      (SETF (ELT |dom| 2) NIL)
      (SETF (ELT |dom| 3) (CONS '|EnumerationCategory| (QCDR (ELT |dom| 0))))
      (SETF (ELT |dom| 4)
              (LIST (LIST '(|SetCategory|))
                    (LIST '(|BasicType|) '(|CoercibleTo| (|OutputForm|))
                          '(|SetCategory|))))
      (SETF (ELT |dom| 5) |args|)
      (SETF (ELT |dom| 6) (CONS #'|EnumEqual| |dom|))
      (SETF (ELT |dom| 7) (CONS #'|EnumPrint| |dom|))
      (SETF (ELT |dom| 8) (CONS #'|createEnum| |dom|))
      (SETF (ELT |dom| 9) (CONS #'|EnumUnEqual| |dom|))
      |dom|))))

; EnumEqual(e1,e2,dom) == e1=e2

(DEFUN |EnumEqual| (|e1| |e2| |dom|) (PROG () (RETURN (EQUAL |e1| |e2|))))

; EnumUnEqual(e1,e2,dom) == not(EnumEqual(e1,e2,dom))

(DEFUN |EnumUnEqual| (|e1| |e2| |dom|)
  (PROG () (RETURN (NULL (|EnumEqual| |e1| |e2| |dom|)))))

; EnumPrint(enum, dom) == dom.5.enum

(DEFUN |EnumPrint| (|enum| |dom|) (PROG () (RETURN (ELT (ELT |dom| 5) |enum|))))

; createEnum(sym, dom) ==
;   args := dom.5
;   val := -1
;   for v in args for i in 0.. repeat
;      sym=v => return(val:=i)
;   val<0 => error ["Cannot coerce",sym,"to",["Enumeration",:args]]
;   val

(DEFUN |createEnum| (|sym| |dom|)
  (PROG (|args| |val|)
    (RETURN
     (PROGN
      (SETQ |args| (ELT |dom| 5))
      (SETQ |val| (- 1))
      ((LAMBDA (|bfVar#20| |v| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#20|) (PROGN (SETQ |v| (CAR |bfVar#20|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND ((EQUAL |sym| |v|) (IDENTITY (RETURN (SETQ |val| |i|)))))))
          (SETQ |bfVar#20| (CDR |bfVar#20|))
          (SETQ |i| (+ |i| 1))))
       |args| NIL 0)
      (COND
       ((MINUSP |val|)
        (|error|
         (LIST '|Cannot coerce| |sym| '|to| (CONS '|Enumeration| |args|))))
       (#1# |val|))))))

; get_oplist_maker(op) ==
;     op = "Record" => "mkRecordFunList"
;     op = "Union" => "mkUnionFunList"
;     op = "Mapping" => "mkMappingFunList"
;     op = "Enumeration" => "mkEnumerationFunList"
;     false

(DEFUN |get_oplist_maker| (|op|)
  (PROG ()
    (RETURN
     (COND ((EQ |op| '|Record|) '|mkRecordFunList|)
           ((EQ |op| '|Union|) '|mkUnionFunList|)
           ((EQ |op| '|Mapping|) '|mkMappingFunList|)
           ((EQ |op| '|Enumeration|) '|mkEnumerationFunList|) ('T NIL)))))

; RecordCategory(:x) == constructorCategory ['Record,:x]

(DEFUN |RecordCategory| (&REST |x|)
  (PROG () (RETURN (|constructorCategory| (CONS '|Record| |x|)))))

; EnumerationCategory(:x) == constructorCategory ["Enumeration",:x]

(DEFUN |EnumerationCategory| (&REST |x|)
  (PROG () (RETURN (|constructorCategory| (CONS '|Enumeration| |x|)))))

; UnionCategory(:x) == constructorCategory ["Union",:x]

(DEFUN |UnionCategory| (&REST |x|)
  (PROG () (RETURN (|constructorCategory| (CONS '|Union| |x|)))))

; constructorCategory (title is [op,:.]) ==
;   constructorFunction := get_oplist_maker(op) or
;               systemErrorHere '"constructorCategory"
;   [funlist,.]:= FUNCALL(constructorFunction,"$",title,$CategoryFrame)
;   oplist:= [[[a,b],true,c] for [a,b,c] in funlist]
;   cat:=
;       JoinInner([SetCategory(), mkCategory(oplist, nil, nil, nil)])
;   cat.(0):= title
;   cat

(DEFUN |constructorCategory| (|title|)
  (PROG (|op| |constructorFunction| |LETTMP#1| |funlist| |a| |ISTMP#1| |b|
         |ISTMP#2| |c| |oplist| |cat|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |title|))
      (SETQ |constructorFunction|
              (OR (|get_oplist_maker| |op|)
                  (|systemErrorHere| "constructorCategory")))
      (SETQ |LETTMP#1|
              (FUNCALL |constructorFunction| '$ |title| |$CategoryFrame|))
      (SETQ |funlist| (CAR |LETTMP#1|))
      (SETQ |oplist|
              ((LAMBDA (|bfVar#23| |bfVar#22| |bfVar#21|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#22|)
                        (PROGN (SETQ |bfVar#21| (CAR |bfVar#22|)) NIL))
                    (RETURN (NREVERSE |bfVar#23|)))
                   (#1='T
                    (AND (CONSP |bfVar#21|)
                         (PROGN
                          (SETQ |a| (CAR |bfVar#21|))
                          (SETQ |ISTMP#1| (CDR |bfVar#21|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |b| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN (SETQ |c| (CAR |ISTMP#2|)) #1#)))))
                         (SETQ |bfVar#23|
                                 (CONS (LIST (LIST |a| |b|) T |c|)
                                       |bfVar#23|)))))
                  (SETQ |bfVar#22| (CDR |bfVar#22|))))
               NIL |funlist| NIL))
      (SETQ |cat|
              (|JoinInner|
               (LIST (|SetCategory|) (|mkCategory| |oplist| NIL NIL NIL))))
      (SETF (ELT |cat| 0) |title|)
      |cat|))))

; mkMappingFunList(nam,mapForm,e) ==
;   dc := GENSYM()
;   sigFunAlist:=
;     [['_=,[['Boolean],nam ,nam],['ELT,dc,6]],
;      ['_~_=, [['Boolean], nam, nam], ['ELT, dc, 9]],
;        ['coerce, [$OutputForm, nam], ['ELT, dc, 7]]]
;   [substitute(nam,dc,substitute("$",'Rep,sigFunAlist)),e]

(DEFUN |mkMappingFunList| (|nam| |mapForm| |e|)
  (PROG (|dc| |sigFunAlist|)
    (RETURN
     (PROGN
      (SETQ |dc| (GENSYM))
      (SETQ |sigFunAlist|
              (LIST
               (LIST '= (LIST (LIST '|Boolean|) |nam| |nam|)
                     (LIST 'ELT |dc| 6))
               (LIST '~= (LIST (LIST '|Boolean|) |nam| |nam|)
                     (LIST 'ELT |dc| 9))
               (LIST '|coerce| (LIST |$OutputForm| |nam|) (LIST 'ELT |dc| 7))))
      (LIST (|substitute| |nam| |dc| (|substitute| '$ '|Rep| |sigFunAlist|))
            |e|)))))

; mkRecordFunList(nam,['Record,:Alist],e) ==
;   len:= #Alist
;
; --  for (.,a,.) in Alist do
; --    if getmode(a,e) then MOAN("Symbol: ",a,
; --        " must not be both a variable and literal")
; --    e:= put(a,"isLiteral","true",e)
;   dc := GENSYM()
;   sigFunAlist:=
;      --:((a,(A,nam),('XLAM,("$1","$2"),('RECORDELT,"$1",i,len)))
;      --       for i in 0..,(.,a,A) in Alist),
;
;     [['construct,[nam,:[A for [.,a,A] in Alist]],'mkRecord],
;      ['_=, [['Boolean], nam, nam], ['ELT, dc, 6]],
;       ['_~_=, [['Boolean], nam, nam], ['ELT, dc, 10]],
;        ['coerce, [$OutputForm, nam], ['ELT, dc, 7]],:
;         [['elt,[A,nam,PNAME a],['XLAM,["$1","$2"],['RECORDELT,"$1",i,len]]]
;             for i in 0.. for [.,a,A] in Alist],:
;           [["setelt!", [A, nam, PNAME a, A], ['XLAM, ["$1", "$2", "$3"],
;             ['SETRECORDELT,"$1",i, len,"$3"]]]
;               for i in 0.. for [.,a,A] in Alist],:
;                 [['copy,[nam,nam],['XLAM,["$1"],['RECORDCOPY,
;                   "$1",len]]]]]
;   [substitute(nam,dc,substitute("$",'Rep,sigFunAlist)),e]

(DEFUN |mkRecordFunList| (|nam| |bfVar#33| |e|)
  (PROG (|Alist| |len| |dc| |ISTMP#1| |a| |ISTMP#2| A |sigFunAlist|)
    (RETURN
     (PROGN
      (SETQ |Alist| (CDR |bfVar#33|))
      (SETQ |len| (LENGTH |Alist|))
      (SETQ |dc| (GENSYM))
      (SETQ |sigFunAlist|
              (CONS
               (LIST '|construct|
                     (CONS |nam|
                           ((LAMBDA (|bfVar#26| |bfVar#25| |bfVar#24|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#25|)
                                     (PROGN
                                      (SETQ |bfVar#24| (CAR |bfVar#25|))
                                      NIL))
                                 (RETURN (NREVERSE |bfVar#26|)))
                                (#1='T
                                 (AND (CONSP |bfVar#24|)
                                      (PROGN
                                       (SETQ |ISTMP#1| (CDR |bfVar#24|))
                                       (AND (CONSP |ISTMP#1|)
                                            (PROGN
                                             (SETQ |a| (CAR |ISTMP#1|))
                                             (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                             (AND (CONSP |ISTMP#2|)
                                                  (EQ (CDR |ISTMP#2|) NIL)
                                                  (PROGN
                                                   (SETQ A (CAR |ISTMP#2|))
                                                   #1#)))))
                                      (SETQ |bfVar#26| (CONS A |bfVar#26|)))))
                               (SETQ |bfVar#25| (CDR |bfVar#25|))))
                            NIL |Alist| NIL))
                     '|mkRecord|)
               (CONS
                (LIST '= (LIST (LIST '|Boolean|) |nam| |nam|)
                      (LIST 'ELT |dc| 6))
                (CONS
                 (LIST '~= (LIST (LIST '|Boolean|) |nam| |nam|)
                       (LIST 'ELT |dc| 10))
                 (CONS
                  (LIST '|coerce| (LIST |$OutputForm| |nam|)
                        (LIST 'ELT |dc| 7))
                  (APPEND
                   ((LAMBDA (|bfVar#29| |i| |bfVar#28| |bfVar#27|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#28|)
                             (PROGN (SETQ |bfVar#27| (CAR |bfVar#28|)) NIL))
                         (RETURN (NREVERSE |bfVar#29|)))
                        (#1#
                         (AND (CONSP |bfVar#27|)
                              (PROGN
                               (SETQ |ISTMP#1| (CDR |bfVar#27|))
                               (AND (CONSP |ISTMP#1|)
                                    (PROGN
                                     (SETQ |a| (CAR |ISTMP#1|))
                                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                     (AND (CONSP |ISTMP#2|)
                                          (EQ (CDR |ISTMP#2|) NIL)
                                          (PROGN
                                           (SETQ A (CAR |ISTMP#2|))
                                           #1#)))))
                              (SETQ |bfVar#29|
                                      (CONS
                                       (LIST '|elt| (LIST A |nam| (PNAME |a|))
                                             (LIST 'XLAM (LIST '$1 '$2)
                                                   (LIST 'RECORDELT '$1 |i|
                                                         |len|)))
                                       |bfVar#29|)))))
                       (SETQ |i| (+ |i| 1))
                       (SETQ |bfVar#28| (CDR |bfVar#28|))))
                    NIL 0 |Alist| NIL)
                   (APPEND
                    ((LAMBDA (|bfVar#32| |i| |bfVar#31| |bfVar#30|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#31|)
                              (PROGN (SETQ |bfVar#30| (CAR |bfVar#31|)) NIL))
                          (RETURN (NREVERSE |bfVar#32|)))
                         (#1#
                          (AND (CONSP |bfVar#30|)
                               (PROGN
                                (SETQ |ISTMP#1| (CDR |bfVar#30|))
                                (AND (CONSP |ISTMP#1|)
                                     (PROGN
                                      (SETQ |a| (CAR |ISTMP#1|))
                                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                      (AND (CONSP |ISTMP#2|)
                                           (EQ (CDR |ISTMP#2|) NIL)
                                           (PROGN
                                            (SETQ A (CAR |ISTMP#2|))
                                            #1#)))))
                               (SETQ |bfVar#32|
                                       (CONS
                                        (LIST '|setelt!|
                                              (LIST A |nam| (PNAME |a|) A)
                                              (LIST 'XLAM (LIST '$1 '$2 '$3)
                                                    (LIST 'SETRECORDELT '$1 |i|
                                                          |len| '$3)))
                                        |bfVar#32|)))))
                        (SETQ |i| (+ |i| 1))
                        (SETQ |bfVar#31| (CDR |bfVar#31|))))
                     NIL 0 |Alist| NIL)
                    (LIST
                     (LIST '|copy| (LIST |nam| |nam|)
                           (LIST 'XLAM (LIST '$1)
                                 (LIST 'RECORDCOPY '$1 |len|)))))))))))
      (LIST (|substitute| |nam| |dc| (|substitute| '$ '|Rep| |sigFunAlist|))
            |e|)))))

; mkNewUnionFunList(name,form is ['Union,:listOfEntries],e) ==
;   dc := name
;   if name = 'Rep then name := '$
;   --2. create coercions from subtypes to subUnion
;   cList:=
;     [['_=,[['Boolean],name ,name],['ELT,dc,6]],
;      ['_~_=, [['Boolean], name, name], ['ELT, dc, 9]],
;      ['coerce, [$OutputForm, name], ['ELT, dc, 7]],:
;        ("append"/
;         [[['construct,[name,type],['XLAM,["#1"],['CONS,i,"#1"]]],
;           ['elt,[type,name,tag],cdownFun],
;             ["case", ['(Boolean), name, tag],
;                ['XLAM,["#1"],['QEQCAR,"#1",i]]]]
;                  for [.,tag,type] in listOfEntries for i in 0..])] where
;                    cdownFun() ==
;                     gg:=GENSYM()
;                     $InteractiveMode =>
;                       ['XLAM,["#1"],['PROG1,['QCDR,"#1"],
;                         ['check_union2, ['QEQCAR, "#1", i], type, form, "#1"]]]
;                     ['XLAM,["#1"],['PROG2,['LET,gg,"#1"],['QCDR,gg],
;                       ['check_union2, ['QEQCAR, gg, i], type, form, gg]]]
;   [cList,e]

(DEFUN |mkNewUnionFunList| (|name| |form| |e|)
  (PROG (|listOfEntries| |dc| |ISTMP#1| |tag| |ISTMP#2| |type| |gg| |cList|)
    (RETURN
     (PROGN
      (SETQ |listOfEntries| (CDR |form|))
      (SETQ |dc| |name|)
      (COND ((EQ |name| '|Rep|) (SETQ |name| '$)))
      (SETQ |cList|
              (CONS
               (LIST '= (LIST (LIST '|Boolean|) |name| |name|)
                     (LIST 'ELT |dc| 6))
               (CONS
                (LIST '~= (LIST (LIST '|Boolean|) |name| |name|)
                      (LIST 'ELT |dc| 9))
                (CONS
                 (LIST '|coerce| (LIST |$OutputForm| |name|)
                       (LIST 'ELT |dc| 7))
                 ((LAMBDA (|bfVar#36| |bfVar#35| |bfVar#34| |i|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#35|)
                           (PROGN (SETQ |bfVar#34| (CAR |bfVar#35|)) NIL))
                       (RETURN |bfVar#36|))
                      (#1='T
                       (AND (CONSP |bfVar#34|)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |bfVar#34|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |tag| (CAR |ISTMP#1|))
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (EQ (CDR |ISTMP#2|) NIL)
                                        (PROGN
                                         (SETQ |type| (CAR |ISTMP#2|))
                                         #1#)))))
                            (SETQ |bfVar#36|
                                    (APPEND |bfVar#36|
                                            (LIST
                                             (LIST '|construct|
                                                   (LIST |name| |type|)
                                                   (LIST 'XLAM (LIST '|#1|)
                                                         (LIST 'CONS |i|
                                                               '|#1|)))
                                             (LIST '|elt|
                                                   (LIST |type| |name| |tag|)
                                                   (PROGN
                                                    (SETQ |gg| (GENSYM))
                                                    (COND
                                                     (|$InteractiveMode|
                                                      (LIST 'XLAM (LIST '|#1|)
                                                            (LIST 'PROG1
                                                                  (LIST 'QCDR
                                                                        '|#1|)
                                                                  (LIST
                                                                   '|check_union2|
                                                                   (LIST
                                                                    'QEQCAR
                                                                    '|#1| |i|)
                                                                   |type|
                                                                   |form|
                                                                   '|#1|))))
                                                     (#1#
                                                      (LIST 'XLAM (LIST '|#1|)
                                                            (LIST 'PROG2
                                                                  (LIST 'LET
                                                                        |gg|
                                                                        '|#1|)
                                                                  (LIST 'QCDR
                                                                        |gg|)
                                                                  (LIST
                                                                   '|check_union2|
                                                                   (LIST
                                                                    'QEQCAR
                                                                    |gg| |i|)
                                                                   |type|
                                                                   |form|
                                                                   |gg|)))))))
                                             (LIST '|case|
                                                   (LIST '(|Boolean|) |name|
                                                         |tag|)
                                                   (LIST 'XLAM (LIST '|#1|)
                                                         (LIST 'QEQCAR '|#1|
                                                               |i|)))))))))
                     (SETQ |bfVar#35| (CDR |bfVar#35|))
                     (SETQ |i| (+ |i| 1))))
                  NIL |listOfEntries| NIL 0)))))
      (LIST |cList| |e|)))))

; mkEnumerationFunList(nam,['Enumeration,:SL],e) ==
;   len:= #SL
;   dc := nam
;   cList :=
;     [nil,
;       ['_=,[['Boolean],nam ,nam],['ELT,dc,6]],
;        ['_~_=, [['Boolean], nam, nam], ['ELT, dc, 9]],
;         ['_^_=,[['Boolean],nam ,nam],['ELT,dc,7]],
;           ['coerce,[nam, ['Symbol]], ['ELT, dc, 8]],
;             ['coerce,[['OutputForm],nam],['ELT,dc, 9]]]
;   [substitute(nam, dc, cList),e]

(DEFUN |mkEnumerationFunList| (|nam| |bfVar#37| |e|)
  (PROG (SL |len| |dc| |cList|)
    (RETURN
     (PROGN
      (SETQ SL (CDR |bfVar#37|))
      (SETQ |len| (LENGTH SL))
      (SETQ |dc| |nam|)
      (SETQ |cList|
              (LIST NIL
                    (LIST '= (LIST (LIST '|Boolean|) |nam| |nam|)
                          (LIST 'ELT |dc| 6))
                    (LIST '~= (LIST (LIST '|Boolean|) |nam| |nam|)
                          (LIST 'ELT |dc| 9))
                    (LIST '^= (LIST (LIST '|Boolean|) |nam| |nam|)
                          (LIST 'ELT |dc| 7))
                    (LIST '|coerce| (LIST |nam| (LIST '|Symbol|))
                          (LIST 'ELT |dc| 8))
                    (LIST '|coerce| (LIST (LIST '|OutputForm|) |nam|)
                          (LIST 'ELT |dc| 9))))
      (LIST (|substitute| |nam| |dc| |cList|) |e|)))))

; mkUnionFunList(op,form is ['Union,:listOfEntries],e) ==
;   first listOfEntries is [":",.,.] => mkNewUnionFunList(op,form,e)
;   --1. create representations of subtypes
;   predList:= mkPredList listOfEntries
;   g:=GENSYM()
;   --2. create coercions from subtypes to subUnion
;   cList:=
;    [['_=,[['Boolean],g ,g],['ELT,op,6]],
;     ['_~_=, [['Boolean], g, g], ['ELT,op,9]],
;     ['coerce, [$OutputForm, g], ['ELT, op, 7]],:
;      ("append"/
;       [[['autoCoerce,[g,t],upFun],
;         ['coerce,[t,g],cdownFun],
;         ['autoCoerce,[t,g],downFun], --this should be removed eventually
;         ["case", ['(Boolean), g, t], typeFun]]
;           for p in predList for t in listOfEntries])] where
;              upFun() ==
;                p is ['EQCAR,x,n] => ['XLAM,["#1"],['CONS,n,"#1"]]
;                ['XLAM,["#1"],"#1"]
;              cdownFun() ==
;                gg:=GENSYM()
;                if p is ['EQCAR,x,n] then
;                   ref:=['QCDR,gg]
;                   q:= ['QEQCAR, gg, n]
;                else
;                   ref:=gg
;                   q:= substitute(gg,"#1",p)
;                ['XLAM,["#1"],['PROG2,['LET,gg,"#1"],ref,
;                     ['check_union2, q, t, form, gg]]]
;              downFun() ==
;                 p is ['EQCAR,x,.] =>
;                   ['XLAM,["#1"],['QCDR,"#1"]]
;                 ['XLAM,["#1"],"#1"]
;              typeFun() ==
;                 p is ['EQCAR,x,n] =>
;                   ['XLAM,["#1"],['QEQCAR,x,n]]
;                 ['XLAM,["#1"],p]
;   op:=
;     op='Rep => '$
;     op
;   cList:= substitute(op,g,cList)
;   [cList,e]

(DEFUN |mkUnionFunList| (|op| |form| |e|)
  (PROG (|listOfEntries| |ISTMP#1| |ISTMP#2| |ISTMP#3| |predList| |g| |x| |n|
         |gg| |ref| |q| |cList|)
    (RETURN
     (PROGN
      (SETQ |listOfEntries| (CDR |form|))
      (COND
       ((PROGN
         (SETQ |ISTMP#1| (CAR |listOfEntries|))
         (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|)
              (PROGN
               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
               (AND (CONSP |ISTMP#2|)
                    (PROGN
                     (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                     (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)))))))
        (|mkNewUnionFunList| |op| |form| |e|))
       (#1='T
        (PROGN
         (SETQ |predList| (|mkPredList| |listOfEntries|))
         (SETQ |g| (GENSYM))
         (SETQ |cList|
                 (CONS
                  (LIST '= (LIST (LIST '|Boolean|) |g| |g|) (LIST 'ELT |op| 6))
                  (CONS
                   (LIST '~= (LIST (LIST '|Boolean|) |g| |g|)
                         (LIST 'ELT |op| 9))
                   (CONS
                    (LIST '|coerce| (LIST |$OutputForm| |g|)
                          (LIST 'ELT |op| 7))
                    ((LAMBDA (|bfVar#40| |bfVar#38| |p| |bfVar#39| |t|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#38|)
                              (PROGN (SETQ |p| (CAR |bfVar#38|)) NIL)
                              (ATOM |bfVar#39|)
                              (PROGN (SETQ |t| (CAR |bfVar#39|)) NIL))
                          (RETURN |bfVar#40|))
                         (#1#
                          (SETQ |bfVar#40|
                                  (APPEND |bfVar#40|
                                          (LIST
                                           (LIST '|autoCoerce| (LIST |g| |t|)
                                                 (COND
                                                  ((AND (CONSP |p|)
                                                        (EQ (CAR |p|) 'EQCAR)
                                                        (PROGN
                                                         (SETQ |ISTMP#1|
                                                                 (CDR |p|))
                                                         (AND (CONSP |ISTMP#1|)
                                                              (PROGN
                                                               (SETQ |x|
                                                                       (CAR
                                                                        |ISTMP#1|))
                                                               (SETQ |ISTMP#2|
                                                                       (CDR
                                                                        |ISTMP#1|))
                                                               (AND
                                                                (CONSP
                                                                 |ISTMP#2|)
                                                                (EQ
                                                                 (CDR
                                                                  |ISTMP#2|)
                                                                 NIL)
                                                                (PROGN
                                                                 (SETQ |n|
                                                                         (CAR
                                                                          |ISTMP#2|))
                                                                 #1#))))))
                                                   (LIST 'XLAM (LIST '|#1|)
                                                         (LIST 'CONS |n|
                                                               '|#1|)))
                                                  (#1#
                                                   (LIST 'XLAM (LIST '|#1|)
                                                         '|#1|))))
                                           (LIST '|coerce| (LIST |t| |g|)
                                                 (PROGN
                                                  (SETQ |gg| (GENSYM))
                                                  (COND
                                                   ((AND (CONSP |p|)
                                                         (EQ (CAR |p|) 'EQCAR)
                                                         (PROGN
                                                          (SETQ |ISTMP#1|
                                                                  (CDR |p|))
                                                          (AND
                                                           (CONSP |ISTMP#1|)
                                                           (PROGN
                                                            (SETQ |x|
                                                                    (CAR
                                                                     |ISTMP#1|))
                                                            (SETQ |ISTMP#2|
                                                                    (CDR
                                                                     |ISTMP#1|))
                                                            (AND
                                                             (CONSP |ISTMP#2|)
                                                             (EQ
                                                              (CDR |ISTMP#2|)
                                                              NIL)
                                                             (PROGN
                                                              (SETQ |n|
                                                                      (CAR
                                                                       |ISTMP#2|))
                                                              #1#))))))
                                                    (SETQ |ref|
                                                            (LIST 'QCDR |gg|))
                                                    (SETQ |q|
                                                            (LIST 'QEQCAR |gg|
                                                                  |n|)))
                                                   (#1# (SETQ |ref| |gg|)
                                                    (SETQ |q|
                                                            (|substitute| |gg|
                                                             '|#1| |p|))))
                                                  (LIST 'XLAM (LIST '|#1|)
                                                        (LIST 'PROG2
                                                              (LIST 'LET |gg|
                                                                    '|#1|)
                                                              |ref|
                                                              (LIST
                                                               '|check_union2|
                                                               |q| |t| |form|
                                                               |gg|)))))
                                           (LIST '|autoCoerce| (LIST |t| |g|)
                                                 (COND
                                                  ((AND (CONSP |p|)
                                                        (EQ (CAR |p|) 'EQCAR)
                                                        (PROGN
                                                         (SETQ |ISTMP#1|
                                                                 (CDR |p|))
                                                         (AND (CONSP |ISTMP#1|)
                                                              (PROGN
                                                               (SETQ |x|
                                                                       (CAR
                                                                        |ISTMP#1|))
                                                               (SETQ |ISTMP#2|
                                                                       (CDR
                                                                        |ISTMP#1|))
                                                               (AND
                                                                (CONSP
                                                                 |ISTMP#2|)
                                                                (EQ
                                                                 (CDR
                                                                  |ISTMP#2|)
                                                                 NIL))))))
                                                   (LIST 'XLAM (LIST '|#1|)
                                                         (LIST 'QCDR '|#1|)))
                                                  (#1#
                                                   (LIST 'XLAM (LIST '|#1|)
                                                         '|#1|))))
                                           (LIST '|case|
                                                 (LIST '(|Boolean|) |g| |t|)
                                                 (COND
                                                  ((AND (CONSP |p|)
                                                        (EQ (CAR |p|) 'EQCAR)
                                                        (PROGN
                                                         (SETQ |ISTMP#1|
                                                                 (CDR |p|))
                                                         (AND (CONSP |ISTMP#1|)
                                                              (PROGN
                                                               (SETQ |x|
                                                                       (CAR
                                                                        |ISTMP#1|))
                                                               (SETQ |ISTMP#2|
                                                                       (CDR
                                                                        |ISTMP#1|))
                                                               (AND
                                                                (CONSP
                                                                 |ISTMP#2|)
                                                                (EQ
                                                                 (CDR
                                                                  |ISTMP#2|)
                                                                 NIL)
                                                                (PROGN
                                                                 (SETQ |n|
                                                                         (CAR
                                                                          |ISTMP#2|))
                                                                 #1#))))))
                                                   (LIST 'XLAM (LIST '|#1|)
                                                         (LIST 'QEQCAR |x|
                                                               |n|)))
                                                  (#1#
                                                   (LIST 'XLAM (LIST '|#1|)
                                                         |p|)))))))))
                        (SETQ |bfVar#38| (CDR |bfVar#38|))
                        (SETQ |bfVar#39| (CDR |bfVar#39|))))
                     NIL |predList| NIL |listOfEntries| NIL)))))
         (SETQ |op| (COND ((EQ |op| '|Rep|) '$) (#1# |op|)))
         (SETQ |cList| (|substitute| |op| |g| |cList|))
         (LIST |cList| |e|))))))))

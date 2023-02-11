
(SDEFUN |FS2;smpmap|
        ((|fn| (|Mapping| S R))
         (|p| (|SparseMultivariatePolynomial| R (|Kernel| A))) ($ (B)))
        (SPROG NIL
               (SPADCALL (CONS #'|FS2;smpmap!1| (VECTOR |fn| $))
                         (CONS #'|FS2;smpmap!2| (VECTOR $ |fn|)) |p|
                         (QREFELT $ 21)))) 

(SDEFUN |FS2;smpmap!2| ((|y| NIL) ($$ NIL))
        (PROG (|fn| $)
          (LETT |fn| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |y| |fn|) (QREFELT $ 16)))))) 

(SDEFUN |FS2;smpmap!1| ((|x| NIL) ($$ NIL))
        (PROG ($ |fn|)
          (LETT $ (QREFELT $$ 1))
          (LETT |fn| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (CONS #'|FS2;smpmap!0| (VECTOR $ |fn|)) |x|
                             (QREFELT $ 15))))))) 

(SDEFUN |FS2;smpmap!0| ((|z| NIL) ($$ NIL))
        (PROG (|fn| $)
          (LETT |fn| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |fn| |z| (QREFELT $ 11)))))) 

(SDEFUN |FS2;map;MAB;2| ((|f| (|Mapping| S R)) (|x| (A)) ($ (B)))
        (SPADCALL (|FS2;smpmap| |f| (SPADCALL |x| (QREFELT $ 23)) $)
                  (|FS2;smpmap| |f| (SPADCALL |x| (QREFELT $ 24)) $)
                  (QREFELT $ 25))) 

(SDEFUN |FS2;map;MAB;3| ((|f| (|Mapping| S R)) (|x| (A)) ($ (B)))
        (SPROG ((#1=#:G733 NIL))
               (SPADCALL (|FS2;smpmap| |f| (SPADCALL |x| (QREFELT $ 23)) $)
                         (PROG2
                             (LETT #1#
                                   (SPADCALL
                                    (|FS2;smpmap| |f|
                                     (SPADCALL |x| (QREFELT $ 24)) $)
                                    (QREFELT $ 27)))
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0) (QREFELT $ 9)
                                           (|Union| (QREFELT $ 9) "failed")
                                           #1#))
                         (QREFELT $ 28)))) 

(SDEFUN |FS2;map;MAB;4| ((|f| (|Mapping| S R)) (|x| (A)) ($ (B)))
        (|FS2;smpmap| |f| (SPADCALL |x| (QREFELT $ 23)) $)) 

(DECLAIM (NOTINLINE |FunctionSpaceFunctions2;|)) 

(DEFUN |FunctionSpaceFunctions2| (&REST #1=#:G823)
  (SPROG NIL
         (PROG (#2=#:G824)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionSpaceFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FunctionSpaceFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FunctionSpaceFunctions2|)))))))))) 

(DEFUN |FunctionSpaceFunctions2;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|FunctionSpaceFunctions2| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 29))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FunctionSpaceFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#1| '(|IntegralDomain|))
      (COND
       ((|HasCategory| |#3| '(|IntegralDomain|))
        (QSETREFV $ 11 (CONS (|dispatchFunction| |FS2;map;MAB;2|) $)))
       ('T (QSETREFV $ 11 (CONS (|dispatchFunction| |FS2;map;MAB;3|) $)))))
     ('T (QSETREFV $ 11 (CONS (|dispatchFunction| |FS2;map;MAB;4|) $))))
    $))) 

(MAKEPROP '|FunctionSpaceFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Mapping| 8 6) (0 . |map|)
              (|Mapping| 9 7) (|Kernel| 7) (|ExpressionSpaceFunctions2| 7 9)
              (6 . |map|) (12 . |coerce|) (|Mapping| 9 13) (|Mapping| 9 6)
              (|SparseMultivariatePolynomial| 6 13)
              (|PolynomialCategoryLifting| (|IndexedExponents| 13) 13 6 19 9)
              (17 . |map|) (|SparseMultivariatePolynomial| 6 (|Kernel| $))
              (24 . |numer|) (29 . |denom|) (34 . /) (|Union| $ '"failed")
              (40 . |recip|) (45 . *))
           '#(|map| 51) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#4| (|Mapping| |#3| |#1|) |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 28
                                            '(2 0 9 10 7 11 2 14 9 12 13 15 1 9
                                              0 8 16 3 20 9 17 18 19 21 1 7 22
                                              0 23 1 7 22 0 24 2 9 0 0 0 25 1 9
                                              26 0 27 2 9 0 0 0 28 2 0 9 10 7
                                              11)))))
           '|lookupComplete|)) 

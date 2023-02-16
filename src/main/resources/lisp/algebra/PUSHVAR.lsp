
(SDEFUN |PUSHVAR;pushdown;PPRLPPR;1| ((|g| (PPR)) (|lv| (|List| OV)) ($ (PPR)))
        (SPROG
         ((|vals| (|List| (|Polynomial| R))) (#1=#:G709 NIL) (|x| NIL)
          (#2=#:G708 NIL))
         (SEQ
          (LETT |vals|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# |lv|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (|spadConstant| $ 13)
                                         (SPADCALL |x| (QREFELT $ 15)) 1
                                         (QREFELT $ 17))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL |g| |lv| |vals| (QREFELT $ 20)))))) 

(SDEFUN |PUSHVAR;map;M2PPR;2|
        ((|f| (|Mapping| PPR (|Polynomial| R))) (|p| (PPR)) ($ (PPR)))
        (SPROG ((|v| (OV)) (#1=#:G711 NIL))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 23))
                  (SPADCALL (SPADCALL |p| (QREFELT $ 24)) |f|))
                 ('T
                  (SEQ
                   (LETT |v|
                         (PROG2 (LETT #1# (SPADCALL |p| (QREFELT $ 26)))
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0) (QREFELT $ 8)
                                           (|Union| (QREFELT $ 8) "failed")
                                           #1#)))
                   (EXIT
                    (SPADCALL
                     (SPADCALL (CONS #'|PUSHVAR;map;M2PPR;2!0| (VECTOR $ |f|))
                               (SPADCALL |p| |v| (QREFELT $ 30))
                               (QREFELT $ 33))
                     |v| (QREFELT $ 34))))))))) 

(SDEFUN |PUSHVAR;map;M2PPR;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |f| |x| (QREFELT $ 28)))))) 

(SDEFUN |PUSHVAR;pushupCoef|
        ((|c| (|Polynomial| R)) (|lv| (|List| OV)) ($ (PPR)))
        (SPROG
         ((|uc| (|SparseUnivariatePolynomial| (|Polynomial| R))) (|ppr| (PPR))
          (|v2| (|Union| OV "failed")) (|v| (|Symbol|)) (#1=#:G730 NIL))
         (SEQ
          (COND ((SPADCALL |c| (QREFELT $ 35)) (SPADCALL |c| (QREFELT $ 36)))
                (#2='T
                 (SEQ
                  (LETT |v|
                        (PROG2 (LETT #1# (SPADCALL |c| (QREFELT $ 38)))
                            (QCDR #1#)
                          (|check_union2| (QEQCAR #1# 0) (|Symbol|)
                                          (|Union| (|Symbol|) "failed") #1#)))
                  (LETT |v2| (SPADCALL |v| (QREFELT $ 40)))
                  (LETT |uc| (SPADCALL |c| |v| (QREFELT $ 41)))
                  (LETT |ppr| (|spadConstant| $ 42))
                  (EXIT
                   (COND
                    ((QEQCAR |v2| 0)
                     (SEQ
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |uc| (QREFELT $ 44))))
                             (GO G191)))
                           (SEQ
                            (LETT |ppr|
                                  (SPADCALL |ppr|
                                            (SPADCALL
                                             (SPADCALL (|spadConstant| $ 11)
                                                       (QCDR |v2|)
                                                       (SPADCALL |uc|
                                                                 (QREFELT $
                                                                          45))
                                                       (QREFELT $ 46))
                                             (|PUSHVAR;pushupCoef|
                                              (SPADCALL |uc| (QREFELT $ 47))
                                              |lv| $)
                                             (QREFELT $ 48))
                                            (QREFELT $ 49)))
                            (EXIT (LETT |uc| (SPADCALL |uc| (QREFELT $ 50)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT |ppr|)))
                    (#2#
                     (SEQ
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |uc| (QREFELT $ 44))))
                             (GO G191)))
                           (SEQ
                            (LETT |ppr|
                                  (SPADCALL |ppr|
                                            (SPADCALL
                                             (SPADCALL (|spadConstant| $ 13)
                                                       |v|
                                                       (SPADCALL |uc|
                                                                 (QREFELT $
                                                                          45))
                                                       (QREFELT $ 17))
                                             (|PUSHVAR;pushupCoef|
                                              (SPADCALL |uc| (QREFELT $ 47))
                                              |lv| $)
                                             (QREFELT $ 51))
                                            (QREFELT $ 49)))
                            (EXIT (LETT |uc| (SPADCALL |uc| (QREFELT $ 50)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT |ppr|))))))))))) 

(SDEFUN |PUSHVAR;pushup;PPRLPPR;4| ((|g| (PPR)) (|lv| (|List| OV)) ($ (PPR)))
        (SPROG NIL
               (SPADCALL (CONS #'|PUSHVAR;pushup;PPRLPPR;4!0| (VECTOR $ |lv|))
                         |g| (QREFELT $ 28)))) 

(SDEFUN |PUSHVAR;pushup;PPRLPPR;4!0| ((|y| NIL) ($$ NIL))
        (PROG (|lv| $)
          (LETT |lv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|PUSHVAR;pushupCoef| |y| |lv| $))))) 

(DECLAIM (NOTINLINE |PushVariables;|)) 

(DEFUN |PushVariables| (&REST #1=#:G751)
  (SPROG NIL
         (PROG (#2=#:G752)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PushVariables|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PushVariables;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|PushVariables|)))))))))) 

(DEFUN |PushVariables;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|PushVariables| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 53))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PushVariables| (LIST DV$1 DV$2 DV$3 DV$4)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|PushVariables| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |One|) (4 . |One|)
              (|Polynomial| 6) (8 . |One|) (|Symbol|) (12 . |convert|)
              (|NonNegativeInteger|) (17 . |monomial|) (|List| 8) (|List| 12)
              (24 . |eval|) |PUSHVAR;pushdown;PPRLPPR;1| (|Boolean|)
              (31 . |ground?|) (36 . |retract|) (|Union| 8 '"failed")
              (41 . |mainVariable|) (|Mapping| 9 12) |PUSHVAR;map;M2PPR;2|
              (|SparseUnivariatePolynomial| $) (46 . |univariate|)
              (|Mapping| 9 9) (|SparseUnivariatePolynomial| 9) (52 . |map|)
              (58 . |multivariate|) (64 . |ground?|) (69 . |coerce|)
              (|Union| 14 '"failed") (74 . |mainVariable|)
              (|Union| $ '"failed") (79 . |variable|) (84 . |univariate|)
              (90 . |Zero|) (|SparseUnivariatePolynomial| 12) (94 . |zero?|)
              (99 . |degree|) (104 . |monomial|) (111 . |leadingCoefficient|)
              (116 . *) (122 . +) (128 . |reductum|) (133 . *)
              |PUSHVAR;pushup;PPRLPPR;4|)
           '#(|pushup| 139 |pushdown| 145 |map| 151) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|pushdown| (|#4| |#4| (|List| |#3|))) T)
                                   '((|pushup| (|#4| |#4| (|List| |#3|))) T)
                                   '((|map|
                                      (|#4|
                                       (|Mapping| |#4| (|Polynomial| |#1|))
                                       |#4|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 52
                                            '(0 6 0 10 0 9 0 11 0 12 0 13 1 8
                                              14 0 15 3 12 0 0 14 16 17 3 9 0 0
                                              18 19 20 1 9 22 0 23 1 9 12 0 24
                                              1 9 25 0 26 2 9 29 0 8 30 2 32 0
                                              31 0 33 2 9 0 29 8 34 1 12 22 0
                                              35 1 9 0 12 36 1 12 37 0 38 1 8
                                              39 14 40 2 12 29 0 14 41 0 9 0 42
                                              1 43 22 0 44 1 43 16 0 45 3 9 0 0
                                              8 16 46 1 43 12 0 47 2 9 0 0 0 48
                                              2 9 0 0 0 49 1 43 0 0 50 2 9 0 12
                                              0 51 2 0 9 9 18 52 2 0 9 9 18 21
                                              2 0 9 27 9 28)))))
           '|lookupComplete|)) 

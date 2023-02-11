
(SDEFUN |TSEREXPL;taylor_via_deriv;ULSLLULS;1|
        ((|f| (ULS)) (|lx| (|List| ULS))
         (|ld| (|List| (|Mapping| |Coef| |Coef|))) ($ (ULS)))
        (SPROG
         ((|lxt| (|List| UTS)) (#1=#:G701 NIL) (|x| NIL) (#2=#:G700 NIL)
          (|ft| (UTS)))
         (SEQ (LETT |ft| (SPADCALL |f| (QREFELT $ 9)))
              (LETT |lxt|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |x| NIL) (LETT #1# |lx|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |x| (QREFELT $ 9)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (SPADCALL (SPADCALL |ft| |lxt| |ld| (QREFELT $ 14))
                         (QREFELT $ 15)))))) 

(SDEFUN |TSEREXPL;taylor_via_lode;LULSLULS;2|
        ((|la| (|List| UTS)) (|z| (ULS)) (|lc| (|List| |Coef|)) ($ (ULS)))
        (SPROG ((|zt| (UTS)))
               (SEQ (LETT |zt| (SPADCALL |z| (QREFELT $ 9)))
                    (EXIT
                     (SPADCALL (SPADCALL |la| |zt| |lc| (QREFELT $ 19))
                               (QREFELT $ 15)))))) 

(SDEFUN |TSEREXPL;applyTaylor;M2ULS;3|
        ((|g| (|Mapping| UTS UTS)) (|f| (ULS)) ($ (ULS)))
        (SPADCALL (SPADCALL |g| (SPADCALL |f| (QREFELT $ 9)) (QREFELT $ 22))
                  (QREFELT $ 15))) 

(SDEFUN |TSEREXPL;apply_taylor;UTS2ULS;4| ((|g| (UTS)) (|f| (ULS)) ($ (ULS)))
        (SPADCALL (SPADCALL |g| (SPADCALL |f| (QREFELT $ 9)) (QREFELT $ 24))
                  (QREFELT $ 15))) 

(DECLAIM (NOTINLINE |TaylorSeriesExpansionLaurent;|)) 

(DEFUN |TaylorSeriesExpansionLaurent| (&REST #1=#:G707)
  (SPROG NIL
         (PROG (#2=#:G708)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TaylorSeriesExpansionLaurent|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |TaylorSeriesExpansionLaurent;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TaylorSeriesExpansionLaurent|)))))))))) 

(DEFUN |TaylorSeriesExpansionLaurent;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|TaylorSeriesExpansionLaurent| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 26))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TaylorSeriesExpansionLaurent|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TaylorSeriesExpansionLaurent| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |taylor|) (|List| 7) (|Mapping| 6 6)
              (|List| 11) (|TaylorSeriesExpansionTaylor| 6 7)
              (5 . |taylor_via_deriv|) (12 . |coerce|) (|List| 8)
              |TSEREXPL;taylor_via_deriv;ULSLLULS;1| (|List| 6)
              (17 . |taylor_via_lode|) |TSEREXPL;taylor_via_lode;LULSLULS;2|
              (|Mapping| 7 7) (24 . |applyTaylor|)
              |TSEREXPL;applyTaylor;M2ULS;3| (30 . |apply_taylor|)
              |TSEREXPL;apply_taylor;UTS2ULS;4|)
           '#(|taylor_via_lode| 36 |taylor_via_deriv| 43 |apply_taylor| 57
              |applyTaylor| 63)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(|TaylorSeriesExpansion&|)
                       (CONS
                        '#((|TaylorSeriesExpansion| 6 (|Integer|)
                                                    (|SingletonAsOrderedSet|) 8
                                                    7))
                        (|makeByteWordVec2| 25
                                            '(1 8 7 0 9 3 13 7 7 10 12 14 1 8 0
                                              7 15 3 13 7 10 7 18 19 2 13 7 21
                                              7 22 2 13 7 7 7 24 3 0 8 10 8 18
                                              20 3 0 8 8 16 12 17 3 0 8 6 16 12
                                              1 2 0 8 7 8 25 2 0 8 21 8 23)))))
           '|lookupComplete|)) 


(SDEFUN |TSEREXPP;rescale|
        ((|p| (UPS)) (|r0| (|Fraction| (|Integer|)))
         (|rn| (|Fraction| (|Integer|))) ($ (ULS)))
        (SPROG ((|s| (|PositiveInteger|)) (#1=#:G698 NIL))
               (SEQ
                (LETT |s|
                      (PROG1
                          (LETT #1#
                                (SPADCALL (SPADCALL |r0| |rn| (QREFELT $ 11))
                                          (QREFELT $ 13)))
                        (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                          '(|Integer|) #1#)))
                (EXIT
                 (SPADCALL (SPADCALL |p| (QREFELT $ 14)) |s| (QREFELT $ 16)))))) 

(SDEFUN |TSEREXPP;common_rep|
        ((|lp| (|List| UPS))
         ($
          (|Record| (|:| |laus| (|List| ULS))
                    (|:| |rpow| (|Fraction| (|Integer|))))))
        (SPROG
         ((#1=#:G779 NIL) (|p| NIL) (#2=#:G780 NIL) (|r| NIL) (#3=#:G778 NIL)
          (|rn| (|Fraction| (|Integer|))) (#4=#:G777 NIL) (#5=#:G776 NIL)
          (#6=#:G775 NIL) (#7=#:G774 NIL)
          (|lr| (|List| (|Fraction| (|Integer|)))) (#8=#:G773 NIL)
          (#9=#:G772 NIL))
         (SEQ
          (LETT |lr|
                (PROGN
                 (LETT #9# NIL)
                 (SEQ (LETT |p| NIL) (LETT #8# |lp|) G190
                      (COND
                       ((OR (ATOM #8#) (PROGN (LETT |p| (CAR #8#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #9# (CONS (SPADCALL |p| (QREFELT $ 17)) #9#))))
                      (LETT #8# (CDR #8#)) (GO G190) G191
                      (EXIT (NREVERSE #9#)))))
          (LETT |rn|
                (SPADCALL
                 (SPADCALL
                  (PROGN
                   (LETT #7# NIL)
                   (SEQ (LETT |r| NIL) (LETT #6# |lr|) G190
                        (COND
                         ((OR (ATOM #6#) (PROGN (LETT |r| (CAR #6#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #7# (CONS (SPADCALL |r| (QREFELT $ 18)) #7#))))
                        (LETT #6# (CDR #6#)) (GO G190) G191
                        (EXIT (NREVERSE #7#))))
                  (QREFELT $ 20))
                 (SPADCALL
                  (PROGN
                   (LETT #5# NIL)
                   (SEQ (LETT |r| NIL) (LETT #4# |lr|) G190
                        (COND
                         ((OR (ATOM #4#) (PROGN (LETT |r| (CAR #4#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #5# (CONS (SPADCALL |r| (QREFELT $ 21)) #5#))))
                        (LETT #4# (CDR #4#)) (GO G190) G191
                        (EXIT (NREVERSE #5#))))
                  (QREFELT $ 22))
                 (QREFELT $ 23)))
          (EXIT
           (CONS
            (PROGN
             (LETT #3# NIL)
             (SEQ (LETT |r| NIL) (LETT #2# |lr|) (LETT |p| NIL) (LETT #1# |lp|)
                  G190
                  (COND
                   ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL) (ATOM #2#)
                        (PROGN (LETT |r| (CAR #2#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #3# (CONS (|TSEREXPP;rescale| |p| |r| |rn| $) #3#))))
                  (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                  G191 (EXIT (NREVERSE #3#))))
            |rn|))))) 

(SDEFUN |TSEREXPP;taylor_via_deriv;UPSLLUPS;3|
        ((|f| (UPS)) (|lx| (|List| UPS))
         (|ld| (|List| (|Mapping| |Coef| |Coef|))) ($ (UPS)))
        (SPROG
         ((|lres| (ULS)) (|lla| (|List| ULS))
          (|nrep|
           (|Record| (|:| |laus| (|List| ULS))
                     (|:| |rpow| (|Fraction| (|Integer|))))))
         (SEQ (LETT |nrep| (|TSEREXPP;common_rep| (CONS |f| |lx|) $))
              (LETT |lla| (QCAR |nrep|))
              (LETT |lres|
                    (SPADCALL (|SPADfirst| |lla|) (CDR |lla|) |ld|
                              (QREFELT $ 28)))
              (EXIT (SPADCALL (QCDR |nrep|) |lres| (QREFELT $ 29)))))) 

(SDEFUN |TSEREXPP;taylor_via_lode;LUPSLUPS;4|
        ((|la| (|List| UTS)) (|z| (UPS)) (|lc| (|List| |Coef|)) ($ (UPS)))
        (SPROG
         ((|lres| (ULS)) (|lau| (ULS))
          (|nrep|
           (|Record| (|:| |laus| (|List| ULS))
                     (|:| |rpow| (|Fraction| (|Integer|))))))
         (SEQ (LETT |nrep| (|TSEREXPP;common_rep| (LIST |z|) $))
              (LETT |lau| (|SPADfirst| (QCAR |nrep|)))
              (LETT |lres| (SPADCALL |la| |lau| |lc| (QREFELT $ 34)))
              (EXIT (SPADCALL (QCDR |nrep|) |lres| (QREFELT $ 29)))))) 

(SDEFUN |TSEREXPP;applyTaylor;M2UPS;5|
        ((|g| (|Mapping| UTS UTS)) (|f| (UPS)) ($ (UPS)))
        (SPROG
         ((|lres| (ULS))
          (|nrep|
           (|Record| (|:| |laus| (|List| ULS))
                     (|:| |rpow| (|Fraction| (|Integer|))))))
         (SEQ (LETT |nrep| (|TSEREXPP;common_rep| (LIST |f|) $))
              (LETT |lres|
                    (SPADCALL |g| (|SPADfirst| (QCAR |nrep|)) (QREFELT $ 37)))
              (EXIT (SPADCALL (QCDR |nrep|) |lres| (QREFELT $ 29)))))) 

(SDEFUN |TSEREXPP;apply_taylor;UTS2UPS;6| ((|g| (UTS)) (|f| (UPS)) ($ (UPS)))
        (SPROG
         ((|lres| (ULS))
          (|nrep|
           (|Record| (|:| |laus| (|List| ULS))
                     (|:| |rpow| (|Fraction| (|Integer|))))))
         (SEQ (LETT |nrep| (|TSEREXPP;common_rep| (LIST |f|) $))
              (LETT |lres|
                    (SPADCALL |g| (|SPADfirst| (QCAR |nrep|)) (QREFELT $ 39)))
              (EXIT (SPADCALL (QCDR |nrep|) |lres| (QREFELT $ 29)))))) 

(DECLAIM (NOTINLINE |TaylorSeriesExpansionPuiseux;|)) 

(DEFUN |TaylorSeriesExpansionPuiseux| (&REST #1=#:G790)
  (SPROG NIL
         (PROG (#2=#:G791)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TaylorSeriesExpansionPuiseux|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |TaylorSeriesExpansionPuiseux;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TaylorSeriesExpansionPuiseux|)))))))))) 

(DEFUN |TaylorSeriesExpansionPuiseux;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|TaylorSeriesExpansionPuiseux| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 41))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|TaylorSeriesExpansionPuiseux|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|TaylorSeriesExpansionPuiseux| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Fraction| 12) (0 . /) (|Integer|)
              (6 . |retract|) (11 . |laurentRep|) (|PositiveInteger|)
              (16 . |multiplyExponents|) (22 . |rationalPower|) (27 . |numer|)
              (|List| $) (32 . |gcd|) (37 . |denom|) (42 . |lcm|) (47 . /)
              (|List| 8) (|Mapping| 6 6) (|List| 25)
              (|TaylorSeriesExpansionLaurent| 6 7 8) (53 . |taylor_via_deriv|)
              (60 . |puiseux|) (|List| 9)
              |TSEREXPP;taylor_via_deriv;UPSLLUPS;3| (|List| 7) (|List| 6)
              (66 . |taylor_via_lode|) |TSEREXPP;taylor_via_lode;LUPSLUPS;4|
              (|Mapping| 7 7) (73 . |applyTaylor|)
              |TSEREXPP;applyTaylor;M2UPS;5| (79 . |apply_taylor|)
              |TSEREXPP;apply_taylor;UTS2UPS;6|)
           '#(|taylor_via_lode| 85 |taylor_via_deriv| 92 |apply_taylor| 106
              |applyTaylor| 112)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(|TaylorSeriesExpansion&|)
                       (CONS
                        '#((|TaylorSeriesExpansion| 6 10
                                                    (|SingletonAsOrderedSet|) 9
                                                    7))
                        (|makeByteWordVec2| 40
                                            '(2 10 0 0 0 11 1 10 12 0 13 1 9 8
                                              0 14 2 8 0 0 15 16 1 9 10 0 17 1
                                              10 12 0 18 1 12 0 19 20 1 10 12 0
                                              21 1 12 0 19 22 2 10 0 12 12 23 3
                                              27 8 8 24 26 28 2 9 0 10 8 29 3
                                              27 8 32 8 33 34 2 27 8 36 8 37 2
                                              27 8 7 8 39 3 0 9 32 9 33 35 3 0
                                              9 9 30 26 31 3 0 9 6 30 26 1 2 0
                                              9 7 9 40 2 0 9 36 9 38)))))
           '|lookupComplete|)) 


(SDEFUN |TSEREXPG;stream_taylor|
        ((|f| (UPS)) (|x| (UPS)) (|xn| (UPS)) (|d| (|Mapping| UPS UPS))
         (|n| (|Integer|)) ($ (|Stream| UPS)))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|TSEREXPG;stream_taylor!0|
                       (VECTOR |x| |d| |xn| |f| |n| $))
                 (QREFELT $ 23))))) 

(SDEFUN |TSEREXPG;stream_taylor!0| (($$ NIL))
        (PROG ($ |n| |f| |xn| |d| |x|)
          (LETT $ (QREFELT $$ 5))
          (LETT |n| (QREFELT $$ 4))
          (LETT |f| (QREFELT $$ 3))
          (LETT |xn| (QREFELT $$ 2))
          (LETT |d| (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|qn| NIL) (|ninv| NIL) (|fn| NIL))
                   (SEQ
                    (LETT |qn|
                          (SPADCALL (|spadConstant| $ 13) |n| (QREFELT $ 15)))
                    (LETT |ninv|
                          (SPADCALL |qn| (|spadConstant| $ 10) (QREFELT $ 16)))
                    (LETT |fn| (SPADCALL |f| |xn| (QREFELT $ 17)))
                    (EXIT
                     (SPADCALL |fn|
                               (|TSEREXPG;stream_taylor|
                                (SPADCALL (SPADCALL |ninv| |f| (QREFELT $ 18))
                                          |d|)
                                |x| (SPADCALL |x| |xn| (QREFELT $ 17)) |d|
                                (SPADCALL |n| (|spadConstant| $ 13)
                                          (QREFELT $ 19))
                                $)
                               (QREFELT $ 21))))))))) 

(SDEFUN |TSEREXPG;taylor_via_deriv;UPSLLUPS;2|
        ((|f| (UPS)) (|lx| (|List| UPS))
         (|ld| (|List| (|Mapping| |Coef| |Coef|))) ($ (UPS)))
        (SPROG
         ((|ss| (|Stream| UPS)) (|d1| (|Mapping| |Coef| |Coef|)) (|x1| (UPS)))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |lx|) (LENGTH |ld|) (QREFELT $ 26))
            (|error|
             "taylor_via_deriv: number of variables must equal number of derivatives"))
           ((EQL (LENGTH |lx|) 0) |f|)
           (#1='T
            (SEQ
             (LETT |x1|
                   (SPADCALL (|SPADfirst| |lx|) (|spadConstant| $ 27)
                             (QREFELT $ 28)))
             (EXIT
              (COND
               ((SPADCALL (SPADCALL |x1| (|spadConstant| $ 27) (QREFELT $ 30))
                          (|spadConstant| $ 27) (QREFELT $ 31))
                (|error| "taylor_via_deriv: variable is of negative order"))
               ((SPADCALL (SPADCALL |x1| (|spadConstant| $ 27) (QREFELT $ 32))
                          (|spadConstant| $ 29) (QREFELT $ 33))
                (|error| "taylor_via_deriv: variable has constant term"))
               (#1#
                (SEQ
                 (LETT |x1|
                       (COND
                        ((SPADCALL (SPADCALL |x1| (QREFELT $ 34))
                                   (|spadConstant| $ 27) (QREFELT $ 35))
                         |x1|)
                        (#1# (SPADCALL |x1| (QREFELT $ 36)))))
                 (LETT |f| (SPADCALL |f| (CDR |lx|) (CDR |ld|) (QREFELT $ 40)))
                 (LETT |d1| (|SPADfirst| |ld|))
                 (LETT |ss|
                       (|TSEREXPG;stream_taylor| |f| |x1| (|spadConstant| $ 11)
                        (CONS #'|TSEREXPG;taylor_via_deriv;UPSLLUPS;2!0|
                              (VECTOR $ |d1|))
                        1 $))
                 (EXIT (SPADCALL |ss| (QREFELT $ 43))))))))))))) 

(SDEFUN |TSEREXPG;taylor_via_deriv;UPSLLUPS;2!0| ((|y| NIL) ($$ NIL))
        (PROG (|d1| $)
          (LETT |d1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |d1| |y| (QREFELT $ 41)))))) 

(SDEFUN |TSEREXPG;taylor_via_lode;LUPSLUPS;3|
        ((|la| (|List| UTS)) (|z| (UPS)) (|lc| (|List| |Coef|)) ($ (UPS)))
        (SPROG ((|ts| (UTS)))
               (SEQ
                (COND
                 ((SPADCALL (LENGTH |lc|) (LENGTH |la|) (QREFELT $ 26))
                  (|error|
                   "taylor_via_lode: number of coefficient and initial values must be equal"))
                 ('T
                  (SEQ
                   (LETT |ts|
                         (SPADCALL
                          (CONS #'|TSEREXPG;taylor_via_lode;LUPSLUPS;3!0|
                                (VECTOR |la| $))
                          |lc| (QREFELT $ 52)))
                   (EXIT
                    (SPADCALL (SPADCALL |ts| (QREFELT $ 54)) |z|
                              (QREFELT $ 55))))))))) 

(SDEFUN |TSEREXPG;taylor_via_lode;LUPSLUPS;3!0| ((|ls| NIL) ($$ NIL))
        (PROG ($ |la|)
          (LETT $ (QREFELT $$ 1))
          (LETT |la| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((#1=#:G733 NIL) (|s| NIL) (#2=#:G734 NIL) (|a| NIL)
              (#3=#:G732 NIL))
             (SEQ
              (SPADCALL (ELT $ 44)
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |a| NIL) (LETT #2# |la|) (LETT |s| NIL)
                              (LETT #1# |ls|) G190
                              (COND
                               ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL)
                                    (ATOM #2#)
                                    (PROGN (LETT |a| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #3#
                                      (CONS (SPADCALL |s| |a| (QREFELT $ 45))
                                            #3#))))
                              (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                              (GO G190) G191 (EXIT (NREVERSE #3#))))
                        (QREFELT $ 48)))))))) 

(SDEFUN |TSEREXPG;applyTaylor;M2UPS;4|
        ((|g| (|Mapping| UTS UTS)) (|f| (UPS)) ($ (UPS)))
        (SPROG ((|sg| (UTS)) (|c0| (|Coef|)))
               (SEQ
                (LETT |f| (SPADCALL |f| (|spadConstant| $ 27) (QREFELT $ 28)))
                (EXIT
                 (COND
                  ((SPADCALL (SPADCALL |f| (QREFELT $ 34))
                             (|spadConstant| $ 27) (QREFELT $ 31))
                   (|error| "applyTaylor: f of negative degree"))
                  ('T
                   (SEQ
                    (LETT |c0|
                          (SPADCALL |f| (|spadConstant| $ 27) (QREFELT $ 32)))
                    (LETT |sg|
                          (SPADCALL
                           (SPADCALL (SPADCALL |c0| (QREFELT $ 57))
                                     (SPADCALL (|spadConstant| $ 10) 1
                                               (QREFELT $ 58))
                                     (QREFELT $ 44))
                           |g|))
                    (EXIT
                     (SPADCALL (SPADCALL |sg| (QREFELT $ 54))
                               (SPADCALL |f| (SPADCALL |c0| (QREFELT $ 59))
                                         (QREFELT $ 60))
                               (QREFELT $ 55)))))))))) 

(SDEFUN |TSEREXPG;apply_taylor;UTS2UPS;5| ((|g| (UTS)) (|f| (UPS)) ($ (UPS)))
        (SPADCALL (SPADCALL |g| (QREFELT $ 54)) |f| (QREFELT $ 55))) 

(DECLAIM (NOTINLINE |TaylorSeriesExpansionGeneralized;|)) 

(DEFUN |TaylorSeriesExpansionGeneralized| (&REST #1=#:G743)
  (SPROG NIL
         (PROG (#2=#:G744)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TaylorSeriesExpansionGeneralized|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |TaylorSeriesExpansionGeneralized;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TaylorSeriesExpansionGeneralized|)))))))))) 

(DEFUN |TaylorSeriesExpansionGeneralized;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|TaylorSeriesExpansionGeneralized| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 64))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|TaylorSeriesExpansionGeneralized|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|TaylorSeriesExpansionGeneralized| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |One|) (4 . |One|) (|Integer|)
              (8 . |One|) (|Fraction| 12) (12 . /) (18 . *) (24 . *) (30 . *)
              (36 . +) (|Stream| 8) (42 . |concat|) (|Mapping| $)
              (48 . |delay|) (|Boolean|) (|NonNegativeInteger|) (53 . ~=)
              (59 . |Zero|) (63 . |removeZeros|) (69 . |Zero|) (73 . |order|)
              (79 . <) (85 . |coefficient|) (91 . ~=) (97 . |degree|) (102 . >)
              (108 . |reductum|) (|List| 8) (|Mapping| 6 6) (|List| 38)
              |TSEREXPG;taylor_via_deriv;UPSLLUPS;2| (113 . |map|) (|Stream| $)
              (119 . |infsum|) (124 . +) (130 . *) (|Mapping| 9 9 9) (|List| 9)
              (136 . |reduce|) (|Mapping| 9 47) (|List| 6)
              (|UnivariateTaylorSeriesODESolver| 6 9) (142 . |ode|)
              (|Stream| 6) (148 . |coefficients|) (153 . |apply_taylor|)
              |TSEREXPG;taylor_via_lode;LUPSLUPS;3| (159 . |coerce|)
              (164 . |monomial|) (170 . |coerce|) (175 . -) (|Mapping| 9 9)
              |TSEREXPG;applyTaylor;M2UPS;4| |TSEREXPG;apply_taylor;UTS2UPS;5|)
           '#(|taylor_via_lode| 181 |taylor_via_deriv| 188 |apply_taylor| 202
              |applyTaylor| 208)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(|TaylorSeriesExpansion&|)
                       (CONS
                        '#((|TaylorSeriesExpansion| 6 7
                                                    (|SingletonAsOrderedSet|) 8
                                                    9))
                        (|makeByteWordVec2| 63
                                            '(0 6 0 10 0 8 0 11 0 12 0 13 2 14
                                              0 12 12 15 2 6 0 14 0 16 2 8 0 0
                                              0 17 2 8 0 6 0 18 2 12 0 0 0 19 2
                                              20 0 8 0 21 1 20 0 22 23 2 25 24
                                              0 0 26 0 7 0 27 2 8 0 0 7 28 0 6
                                              0 29 2 8 7 0 7 30 2 7 24 0 0 31 2
                                              8 6 0 7 32 2 6 24 0 0 33 1 8 7 0
                                              34 2 7 24 0 0 35 1 8 0 0 36 2 8 0
                                              38 0 41 1 8 0 42 43 2 9 0 0 0 44
                                              2 9 0 0 0 45 2 47 9 46 0 48 2 51
                                              9 49 50 52 1 9 53 0 54 2 8 0 53 0
                                              55 1 9 0 6 57 2 9 0 6 25 58 1 8 0
                                              6 59 2 8 0 0 0 60 3 0 8 47 8 50
                                              56 3 0 8 8 37 39 40 3 0 8 6 37 39
                                              1 2 0 8 9 8 63 2 0 8 61 8 62)))))
           '|lookupComplete|)) 

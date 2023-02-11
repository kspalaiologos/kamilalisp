
(SDEFUN |SPFUTS;lambertW0;2UTS;1| ((|x| (UTS)) ($ (UTS)))
        (SPROG ((|dx| (UTS)))
               (SEQ (LETT |dx| (SPADCALL |x| (QREFELT $ 8)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (CONS #'|SPFUTS;lambertW0;2UTS;1!1| (VECTOR |dx| $))
                       (QREFELT $ 28))
                      (QREFELT $ 12)))))) 

(SDEFUN |SPFUTS;lambertW0;2UTS;1!1| ((|s| NIL) ($$ NIL))
        (PROG ($ |dx|)
          (LETT $ (QREFELT $$ 1))
          (LETT |dx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (|spadConstant| $ 9)
                             (CONS #'|SPFUTS;lambertW0;2UTS;1!0|
                                   (VECTOR $ |s| |dx|))
                             (QREFELT $ 25))))))) 

(SDEFUN |SPFUTS;lambertW0;2UTS;1!0| (($$ NIL))
        (PROG (|dx| |s| $)
          (LETT |dx| (QREFELT $$ 2))
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL
              (SPADCALL |dx|
                        (SPADCALL
                         (SPADCALL (SPADCALL |s| (QREFELT $ 12))
                                   (QREFELT $ 13))
                         (QREFELT $ 14))
                        (QREFELT $ 15))
              (SPADCALL
               (SPADCALL (|spadConstant| $ 16) (SPADCALL |s| (QREFELT $ 12))
                         (QREFELT $ 17))
               (SPADCALL (|spadConstant| $ 16) (QREFELT $ 13)) (QREFELT $ 21))
              (QREFELT $ 15))
             (QREFELT $ 22)))))) 

(SDEFUN |SPFUTS;compose| ((|s| (|Stream| |Coef|)) (|x| (UTS)) ($ (UTS)))
        (SPADCALL (SPADCALL |s| (SPADCALL |x| (QREFELT $ 22)) (QREFELT $ 30))
                  (QREFELT $ 12))) 

(SDEFUN |SPFUTS;p_re|
        ((|k| (|Integer|)) (|lcr| (|List| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|SPFUTS;p_re!0| (VECTOR |k| $ |lcr|))
                          (QREFELT $ 47))))) 

(SDEFUN |SPFUTS;p_re!0| (($$ NIL))
        (PROG (|lcr| $ |k|)
          (LETT |lcr| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |k| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|lm| NIL) (|ck_m| NIL) (#1=#:G719 NIL) (|cm| NIL)
              (#2=#:G718 NIL) (|m| NIL) (#3=#:G717 NIL) (|ss| NIL) (|two| NIL)
              (|three| NIL) (|ck| NIL))
             (SEQ (LETT |lm| (SPADCALL |lcr| (QREFELT $ 32)))
                  (LETT |ss| (|spadConstant| $ 9))
                  (SEQ (LETT |ck_m| NIL)
                       (LETT #1# (SPADCALL |lcr| (QREFELT $ 35)))
                       (LETT |cm| NIL) (LETT #2# |lm|) (LETT |m| 2)
                       (LETT #3# (SPADCALL |k| 2 (QREFELT $ 34))) G190
                       (COND
                        ((OR (|greater_SI| |m| #3#) (ATOM #2#)
                             (PROGN (LETT |cm| (CAR #2#)) NIL) (ATOM #1#)
                             (PROGN (LETT |ck_m| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |ss|
                               (SPADCALL |ss|
                                         (SPADCALL |cm| |ck_m| (QREFELT $ 36))
                                         (QREFELT $ 37)))))
                       (LETT |m|
                             (PROG1 (|inc_SI| |m|)
                               (LETT #2#
                                     (PROG1 (CDR #2#) (LETT #1# (CDR #1#))))))
                       (GO G190) G191 (EXIT NIL))
                  (LETT |two|
                        (SPADCALL (|spadConstant| $ 18) (|spadConstant| $ 18)
                                  (QREFELT $ 37)))
                  (LETT |three|
                        (SPADCALL |two| (|spadConstant| $ 18) (QREFELT $ 37)))
                  (LETT |ck|
                        (SPADCALL (SPADCALL |three| |ss| (QREFELT $ 36))
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |k| |two| (QREFELT $ 38))
                                    (|spadConstant| $ 18) (QREFELT $ 37))
                                   (SPADCALL
                                    (SPADCALL |k| (|spadConstant| $ 18)
                                              (QREFELT $ 38))
                                    |three| (QREFELT $ 39))
                                   (QREFELT $ 36))
                                  (QREFELT $ 40)))
                  (EXIT
                   (SPADCALL |ck|
                             (|SPFUTS;p_re|
                              (SPADCALL |k| (|spadConstant| $ 42)
                                        (QREFELT $ 43))
                              (SPADCALL |ck| |lcr| (QREFELT $ 44)) $)
                             (QREFELT $ 45))))))))) 

(SDEFUN |SPFUTS;p_stream|
        ((|g2| (|Coef|)) (|g3| (|Coef|)) ($ (|Stream| |Coef|)))
        (SPROG
         ((|c28| (|Coef|)) (|c20| (|Coef|)) (|c5| (|Coef|)) (|c4| (|Coef|))
          (|c2| (|Coef|)))
         (SEQ
          (LETT |c2|
                (SPADCALL (|spadConstant| $ 18) (|spadConstant| $ 18)
                          (QREFELT $ 37)))
          (LETT |c4| (SPADCALL |c2| |c2| (QREFELT $ 37)))
          (LETT |c5| (SPADCALL |c4| (|spadConstant| $ 18) (QREFELT $ 37)))
          (LETT |c20| (SPADCALL |c4| |c5| (QREFELT $ 36)))
          (LETT |c28|
                (SPADCALL |c4| (SPADCALL |c5| |c2| (QREFELT $ 37))
                          (QREFELT $ 36)))
          (EXIT
           (SPADCALL (|spadConstant| $ 9)
                     (SPADCALL (SPADCALL |g2| |c20| (QREFELT $ 40))
                               (SPADCALL (SPADCALL |g3| |c28| (QREFELT $ 40))
                                         (|SPFUTS;p_re| 4
                                          (LIST
                                           (SPADCALL |g3| |c28| (QREFELT $ 40))
                                           (SPADCALL |g2| |c20|
                                                     (QREFELT $ 40)))
                                          $)
                                         (QREFELT $ 45))
                               (QREFELT $ 45))
                     (QREFELT $ 45)))))) 

(SDEFUN |SPFUTS;weierstrassP0;2Coef2UTS;5|
        ((|g2| (|Coef|)) (|g3| (|Coef|)) (|x| (UTS)) ($ (UTS)))
        (|SPFUTS;compose| (|SPFUTS;p_stream| |g2| |g3| $)
         (SPADCALL |x| |x| (QREFELT $ 15)) $)) 

(SDEFUN |SPFUTS;weierstrassPPrime0;2Coef2UTS;6|
        ((|g2| (|Coef|)) (|g3| (|Coef|)) (|x| (UTS)) ($ (UTS)))
        (SPADCALL (SPADCALL (+ 1 1) |x| (QREFELT $ 49))
                  (|SPFUTS;compose|
                   (SPADCALL (|SPFUTS;p_stream| |g2| |g3| $) (QREFELT $ 50))
                   (SPADCALL |x| |x| (QREFELT $ 15)) $)
                  (QREFELT $ 15))) 

(SDEFUN |SPFUTS;weierstrassZeta0;2Coef2UTS;7|
        ((|g2| (|Coef|)) (|g3| (|Coef|)) (|x| (UTS)) ($ (UTS)))
        (SPROG ((|ps2| (|Stream| |Coef|)))
               (SEQ
                (LETT |ps2|
                      (SPADCALL (|SPFUTS;p_stream| |g2| |g3| $)
                                (SPADCALL (SPADCALL |x| |x| (QREFELT $ 15))
                                          (QREFELT $ 22))
                                (QREFELT $ 30)))
                (EXIT
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL (|spadConstant| $ 9) |ps2| (QREFELT $ 52))
                   (QREFELT $ 12))
                  (QREFELT $ 13)))))) 

(SDEFUN |SPFUTS;weierstrassSigma0;2Coef2UTS;8|
        ((|g2| (|Coef|)) (|g3| (|Coef|)) (|x| (UTS)) ($ (UTS)))
        (SPROG
         ((|lsigma| #1=(|Stream| |Coef|)) (|zs| #1#) (|ps2| (|Stream| |Coef|)))
         (SEQ
          (LETT |ps2|
                (SPADCALL (|SPFUTS;p_stream| |g2| |g3| $)
                          (SPADCALL (SPADCALL |x| |x| (QREFELT $ 15))
                                    (QREFELT $ 22))
                          (QREFELT $ 30)))
          (LETT |zs| (SPADCALL (|spadConstant| $ 9) |ps2| (QREFELT $ 52)))
          (LETT |lsigma|
                (SPADCALL (|spadConstant| $ 9) (SPADCALL |zs| (QREFELT $ 54))
                          (QREFELT $ 52)))
          (EXIT
           (SPADCALL |x|
                     (SPADCALL (SPADCALL |lsigma| (QREFELT $ 56))
                               (QREFELT $ 12))
                     (QREFELT $ 15)))))) 

(DECLAIM (NOTINLINE |SpecialFunctionUnivariateTaylorSeries;|)) 

(DEFUN |SpecialFunctionUnivariateTaylorSeries| (&REST #1=#:G729)
  (SPROG NIL
         (PROG (#2=#:G730)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SpecialFunctionUnivariateTaylorSeries|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |SpecialFunctionUnivariateTaylorSeries;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SpecialFunctionUnivariateTaylorSeries|)))))))))) 

(DEFUN |SpecialFunctionUnivariateTaylorSeries;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$|
                (LIST '|SpecialFunctionUnivariateTaylorSeries| DV$1 DV$2))
          (LETT $ (GETREFV 58))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|SpecialFunctionUnivariateTaylorSeries| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SpecialFunctionUnivariateTaylorSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |differentiate|) (5 . |Zero|) (9 . |Zero|) (|Stream| 6)
              (13 . |series|) (18 . -) (23 . |exp|) (28 . *) (34 . |One|)
              (38 . +) (44 . |One|) (|PositiveInteger|) (48 . |One|) (52 . ^)
              (58 . |coefficients|) (|Mapping| 11)
              (|StreamTaylorSeriesOperations| 6) (63 . |lazyIntegrate|)
              (|Mapping| 11 11) (|ParadoxicalCombinatorsForStreams| 6) (69 . Y)
              |SPFUTS;lambertW0;2UTS;1| (74 . |compose|) (|List| 6)
              (80 . |reverse|) (|Integer|) (85 . -) (91 . |rest|) (96 . *)
              (102 . +) (108 . *) (114 . -) (120 . /) (|SingleInteger|)
              (126 . |One|) (130 . +) (136 . |cons|) (142 . |concat|)
              (|Mapping| $) (148 . |delay|) |SPFUTS;weierstrassP0;2Coef2UTS;5|
              (153 . *) (159 . |deriv|) |SPFUTS;weierstrassPPrime0;2Coef2UTS;6|
              (164 . |integrate|) |SPFUTS;weierstrassZeta0;2Coef2UTS;7|
              (170 . -) (|StreamTranscendentalFunctions| 6) (175 . |exp|)
              |SPFUTS;weierstrassSigma0;2Coef2UTS;8|)
           '#(|weierstrassZeta0| 180 |weierstrassSigma0| 187
              |weierstrassPPrime0| 194 |weierstrassP0| 201 |lambertW0| 208)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|lambertW0| (|#2| |#2|)) T)
                                   '((|weierstrassP0| (|#2| |#1| |#1| |#2|)) T)
                                   '((|weierstrassPPrime0|
                                      (|#2| |#1| |#1| |#2|))
                                     T)
                                   '((|weierstrassZeta0| (|#2| |#1| |#1| |#2|))
                                     T)
                                   '((|weierstrassSigma0|
                                      (|#2| |#1| |#1| |#2|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 57
                                            '(1 7 0 0 8 0 6 0 9 0 7 0 10 1 7 0
                                              11 12 1 7 0 0 13 1 7 0 0 14 2 7 0
                                              0 0 15 0 7 0 16 2 7 0 0 0 17 0 6
                                              0 18 0 19 0 20 2 7 0 0 0 21 1 7
                                              11 0 22 2 24 11 6 23 25 1 27 11
                                              26 28 2 24 11 11 11 30 1 31 0 0
                                              32 2 33 0 0 0 34 1 31 0 0 35 2 6
                                              0 0 0 36 2 6 0 0 0 37 2 6 0 33 0
                                              38 2 6 0 0 0 39 2 6 0 0 0 40 0 41
                                              0 42 2 33 0 0 0 43 2 31 0 6 0 44
                                              2 11 0 6 0 45 1 11 0 46 47 2 7 0
                                              19 0 49 1 24 11 11 50 2 24 11 6
                                              11 52 1 24 11 11 54 1 55 11 11 56
                                              3 0 7 6 6 7 53 3 0 7 6 6 7 57 3 0
                                              7 6 6 7 51 3 0 7 6 6 7 48 1 0 7 7
                                              29)))))
           '|lookupComplete|)) 

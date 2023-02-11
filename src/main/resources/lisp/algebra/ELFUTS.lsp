
(SDEFUN |ELFUTS;sncndnre|
        ((|m| (|Coef|)) (|s0| (|Coef|)) (|c0| (|Coef|)) (|d0| (|Coef|))
         (|scd| (|List| (|Stream| |Coef|))) (|dx| (|Stream| |Coef|))
         (|sign| (|Coef|)) ($ (|List| (|Stream| |Coef|))))
        (SPROG NIL
               (LIST
                (SPADCALL |s0|
                          (CONS #'|ELFUTS;sncndnre!0| (VECTOR |dx| $ |scd|))
                          (QREFELT $ 16))
                (SPADCALL |c0|
                          (CONS #'|ELFUTS;sncndnre!1|
                                (VECTOR |dx| $ |scd| |sign|))
                          (QREFELT $ 16))
                (SPADCALL |d0|
                          (CONS #'|ELFUTS;sncndnre!2|
                                (VECTOR |dx| |scd| $ |m| |sign|))
                          (QREFELT $ 16))))) 

(SDEFUN |ELFUTS;sncndnre!2| (($$ NIL))
        (PROG (|sign| |m| $ |scd| |dx|)
          (LETT |sign| (QREFELT $$ 4))
          (LETT |m| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |scd| (QREFELT $$ 1))
          (LETT |dx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL
              (SPADCALL (SPADCALL |sign| |m| (QREFELT $ 22))
                        (SPADCALL |scd| (|spadConstant| $ 20) (QREFELT $ 12))
                        (QREFELT $ 21))
              (SPADCALL |scd| 2 (QREFELT $ 12)) (QREFELT $ 14))
             |dx| (QREFELT $ 14)))))) 

(SDEFUN |ELFUTS;sncndnre!1| (($$ NIL))
        (PROG (|sign| |scd| $ |dx|)
          (LETT |sign| (QREFELT $$ 3))
          (LETT |scd| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |dx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL
              (SPADCALL |sign|
                        (SPADCALL |scd| (|spadConstant| $ 20) (QREFELT $ 12))
                        (QREFELT $ 21))
              (SPADCALL |scd| 3 (QREFELT $ 12)) (QREFELT $ 14))
             |dx| (QREFELT $ 14)))))) 

(SDEFUN |ELFUTS;sncndnre!0| (($$ NIL))
        (PROG (|scd| $ |dx|)
          (LETT |scd| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |dx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |scd| 2 (QREFELT $ 12))
                       (SPADCALL |scd| 3 (QREFELT $ 12)) (QREFELT $ 14))
             |dx| (QREFELT $ 14)))))) 

(SDEFUN |ELFUTS;sncndn;SCoefL;2|
        ((|z| (|Stream| |Coef|)) (|m| (|Coef|)) ($ (|List| (|Stream| |Coef|))))
        (SPROG
         ((|dn1| #1=(|Stream| |Coef|)) (|cn1| #1#) (|sn1| #1#)
          (|invden| (|Stream| |Coef|)) (#2=#:G717 NIL) (|c1| (|Coef|))
          (|dn0| (|Coef|)) (|cn0| (|Coef|)) (|sn0| (|Coef|))
          (|scd| (|List| (|Stream| |Coef|))) (|z0| (|Coef|)))
         (SEQ
          (COND
           ((SPADCALL |z| (QREFELT $ 24))
            (LIST (SPADCALL (|spadConstant| $ 25) (QREFELT $ 26))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 26))
                  (SPADCALL (|spadConstant| $ 17) (QREFELT $ 26))))
           (#3='T
            (SEQ (LETT |z0| (SPADCALL |z| (QREFELT $ 27)))
                 (EXIT
                  (COND
                   ((SPADCALL |z0| (|spadConstant| $ 25) (QREFELT $ 29))
                    (SPADCALL
                     (CONS #'|ELFUTS;sncndn;SCoefL;2!0| (VECTOR |z| $ |m|)) 3
                     (QREFELT $ 34)))
                   ((QREFELT $ 8)
                    (SEQ
                     (LETT |scd|
                           (SPADCALL
                            (CONS #'|ELFUTS;sncndn;SCoefL;2!1|
                                  (VECTOR |z| $ |m|))
                            3 (QREFELT $ 34)))
                     (LETT |sn0| (SPADCALL |z0| |m| (QREFELT $ 35)))
                     (LETT |cn0| (SPADCALL |z0| |m| (QREFELT $ 36)))
                     (LETT |dn0| (SPADCALL |z0| |m| (QREFELT $ 37)))
                     (LETT |c1|
                           (SPADCALL |m| (SPADCALL |sn0| 2 (QREFELT $ 38))
                                     (QREFELT $ 22)))
                     (LETT |invden|
                           (PROG2
                               (LETT #2#
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 17)
                                                 (QREFELT $ 26))
                                       (SPADCALL
                                        (SPADCALL |c1|
                                                  (SPADCALL |scd| 1
                                                            (QREFELT $ 12))
                                                  (QREFELT $ 21))
                                        (SPADCALL |scd| 1 (QREFELT $ 12))
                                        (QREFELT $ 14))
                                       (QREFELT $ 39))
                                      (QREFELT $ 41)))
                               (QCDR #2#)
                             (|check_union2| (QEQCAR #2# 0)
                                             (|Stream| (QREFELT $ 6))
                                             (|Union| (|Stream| (QREFELT $ 6))
                                                      "failed")
                                             #2#)))
                     (LETT |sn1|
                           (SPADCALL |invden|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |cn0| |dn0| (QREFELT $ 22))
                                       (SPADCALL |scd| 1 (QREFELT $ 12))
                                       (QREFELT $ 21))
                                      (SPADCALL
                                       (SPADCALL |sn0|
                                                 (SPADCALL |scd| 2
                                                           (QREFELT $ 12))
                                                 (QREFELT $ 21))
                                       (SPADCALL |scd| 3 (QREFELT $ 12))
                                       (QREFELT $ 14))
                                      (QREFELT $ 42))
                                     (QREFELT $ 14)))
                     (LETT |cn1|
                           (SPADCALL |invden|
                                     (SPADCALL
                                      (SPADCALL |cn0|
                                                (SPADCALL |scd| 2
                                                          (QREFELT $ 12))
                                                (QREFELT $ 21))
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |sn0| |dn0| (QREFELT $ 22))
                                        (SPADCALL |scd| 1 (QREFELT $ 12))
                                        (QREFELT $ 21))
                                       (SPADCALL |scd| 3 (QREFELT $ 12))
                                       (QREFELT $ 14))
                                      (QREFELT $ 39))
                                     (QREFELT $ 14)))
                     (LETT |dn1|
                           (SPADCALL |invden|
                                     (SPADCALL
                                      (SPADCALL |dn0|
                                                (SPADCALL |scd| 3
                                                          (QREFELT $ 12))
                                                (QREFELT $ 21))
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |m| |sn0| (QREFELT $ 22))
                                         |cn0| (QREFELT $ 22))
                                        (SPADCALL |scd| 1 (QREFELT $ 12))
                                        (QREFELT $ 21))
                                       (SPADCALL |scd| 2 (QREFELT $ 12))
                                       (QREFELT $ 14))
                                      (QREFELT $ 39))
                                     (QREFELT $ 14)))
                     (EXIT (LIST |sn1| |cn1| |dn1|))))
                   (#3#
                    (|error|
                     "ELFUTS:sncndn: constant coefficient should be 0")))))))))) 

(SDEFUN |ELFUTS;sncndn;SCoefL;2!1| ((|x| NIL) ($$ NIL))
        (PROG (|m| $ |z|)
          (LETT |m| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ELFUTS;sncndnre| |m| (|spadConstant| $ 25) (|spadConstant| $ 17)
             (|spadConstant| $ 17) |x| (SPADCALL |z| (QREFELT $ 30))
             (SPADCALL (|spadConstant| $ 17) (QREFELT $ 31)) $))))) 

(SDEFUN |ELFUTS;sncndn;SCoefL;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|m| $ |z|)
          (LETT |m| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|ELFUTS;sncndnre| |m| (|spadConstant| $ 25) (|spadConstant| $ 17)
             (|spadConstant| $ 17) |x| (SPADCALL |z| (QREFELT $ 30))
             (SPADCALL (|spadConstant| $ 17) (QREFELT $ 31)) $))))) 

(SDEFUN |ELFUTS;jacobiSn;UTSCoefUTS;3| ((|z| (UTS)) (|m| (|Coef|)) ($ (UTS)))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |z| (QREFELT $ 44)) |m| (QREFELT $ 43))
                   1 (QREFELT $ 12))
         (QREFELT $ 45))) 

(SDEFUN |ELFUTS;jacobiCn;UTSCoefUTS;4| ((|z| (UTS)) (|m| (|Coef|)) ($ (UTS)))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |z| (QREFELT $ 44)) |m| (QREFELT $ 43))
                   2 (QREFELT $ 12))
         (QREFELT $ 45))) 

(SDEFUN |ELFUTS;jacobiDn;UTSCoefUTS;5| ((|z| (UTS)) (|m| (|Coef|)) ($ (UTS)))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |z| (QREFELT $ 44)) |m| (QREFELT $ 43))
                   3 (QREFELT $ 12))
         (QREFELT $ 45))) 

(SDEFUN |ELFUTS;ellipticE;UTSCoefUTS;6| ((|z| (UTS)) (|m| (|Coef|)) ($ (UTS)))
        (SPROG
         ((|c0| (|Coef|)) (|z0| (|Coef|)) (|s2| (UTS)) (|s1| (UTS))
          (|dz| (UTS)) (|cz| (|Stream| |Coef|)))
         (SEQ (LETT |cz| (SPADCALL |z| (QREFELT $ 44)))
              (EXIT
               (COND ((SPADCALL |cz| (QREFELT $ 24)) (|spadConstant| $ 28))
                     (#1='T
                      (SEQ (LETT |dz| (SPADCALL |z| (QREFELT $ 49)))
                           (LETT |s1|
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 18)
                                            (SPADCALL |m|
                                                      (SPADCALL |z| 2
                                                                (QREFELT $ 50))
                                                      (QREFELT $ 51))
                                            (QREFELT $ 52))
                                  (QREFELT $ 53)))
                           (LETT |s2|
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 18)
                                            (SPADCALL |z| 2 (QREFELT $ 50))
                                            (QREFELT $ 52))
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 55))
                                            (QREFELT $ 56))
                                  (QREFELT $ 57)))
                           (LETT |z0| (SPADCALL |z| 0 (QREFELT $ 59)))
                           (EXIT
                            (COND
                             ((SPADCALL |z0| (|spadConstant| $ 25)
                                        (QREFELT $ 29))
                              (SPADCALL
                               (SPADCALL (SPADCALL |s1| |s2| (QREFELT $ 60))
                                         |dz| (QREFELT $ 60))
                               (QREFELT $ 61)))
                             ((QREFELT $ 8)
                              (SEQ
                               (LETT |c0| (SPADCALL |z0| |m| (QREFELT $ 62)))
                               (EXIT
                                (SPADCALL (SPADCALL |c0| (QREFELT $ 63))
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |s1| |s2| (QREFELT $ 60))
                                            |dz| (QREFELT $ 60))
                                           (QREFELT $ 61))
                                          (QREFELT $ 64)))))
                             (#1#
                              (|error|
                               "ELFUTS:ellipticE: constant coefficient should be 0"))))))))))) 

(SDEFUN |ELFUTS;ellipticF;UTSCoefUTS;7| ((|z| (UTS)) (|m| (|Coef|)) ($ (UTS)))
        (SPROG
         ((|c0| (|Coef|)) (|z0| (|Coef|)) (|s2| (UTS)) (|s1| (UTS))
          (|dz| (UTS)) (|cz| (|Stream| |Coef|)))
         (SEQ (LETT |cz| (SPADCALL |z| (QREFELT $ 44)))
              (EXIT
               (COND ((SPADCALL |cz| (QREFELT $ 24)) (|spadConstant| $ 28))
                     (#1='T
                      (SEQ (LETT |dz| (SPADCALL |z| (QREFELT $ 49)))
                           (LETT |s1|
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 18)
                                            (SPADCALL |m|
                                                      (SPADCALL |z| 2
                                                                (QREFELT $ 50))
                                                      (QREFELT $ 51))
                                            (QREFELT $ 52))
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 55))
                                            (QREFELT $ 56))
                                  (QREFELT $ 57)))
                           (LETT |s2|
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 18)
                                            (SPADCALL |z| 2 (QREFELT $ 50))
                                            (QREFELT $ 52))
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 55))
                                            (QREFELT $ 56))
                                  (QREFELT $ 57)))
                           (LETT |z0| (SPADCALL |z| 0 (QREFELT $ 59)))
                           (EXIT
                            (COND
                             ((SPADCALL |z0| (|spadConstant| $ 25)
                                        (QREFELT $ 29))
                              (SPADCALL
                               (SPADCALL (SPADCALL |s1| |s2| (QREFELT $ 60))
                                         |dz| (QREFELT $ 60))
                               (QREFELT $ 61)))
                             ((QREFELT $ 8)
                              (SEQ
                               (LETT |c0| (SPADCALL |z0| |m| (QREFELT $ 66)))
                               (EXIT
                                (SPADCALL (SPADCALL |c0| (QREFELT $ 63))
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |s1| |s2| (QREFELT $ 60))
                                            |dz| (QREFELT $ 60))
                                           (QREFELT $ 61))
                                          (QREFELT $ 64)))))
                             (#1#
                              (|error|
                               "ELFUTS:ellipticF: constant coefficient should be 0"))))))))))) 

(SDEFUN |ELFUTS;ellipticPi;UTS2CoefUTS;8|
        ((|z| (UTS)) (|n| (|Coef|)) (|m| (|Coef|)) ($ (UTS)))
        (SPROG
         ((|c0| (|Coef|)) (|z0| (|Coef|)) (|ss| (UTS)) (|s2| (UTS))
          (|s1| (UTS)) (|dz| (UTS)) (|cz| (|Stream| |Coef|)))
         (SEQ (LETT |cz| (SPADCALL |z| (QREFELT $ 44)))
              (EXIT
               (COND ((SPADCALL |cz| (QREFELT $ 24)) (|spadConstant| $ 28))
                     (#1='T
                      (SEQ (LETT |dz| (SPADCALL |z| (QREFELT $ 49)))
                           (LETT |s1|
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 18)
                                            (SPADCALL |m|
                                                      (SPADCALL |z| 2
                                                                (QREFELT $ 50))
                                                      (QREFELT $ 51))
                                            (QREFELT $ 52))
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 55))
                                            (QREFELT $ 56))
                                  (QREFELT $ 57)))
                           (LETT |s2|
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 18)
                                            (SPADCALL |z| 2 (QREFELT $ 50))
                                            (QREFELT $ 52))
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 55))
                                            (QREFELT $ 56))
                                  (QREFELT $ 57)))
                           (LETT |ss|
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 18)
                                               (SPADCALL |n|
                                                         (SPADCALL |z| 2
                                                                   (QREFELT $
                                                                            50))
                                                         (QREFELT $ 51))
                                               (QREFELT $ 52))
                                     (SPADCALL (|spadConstant| $ 68)
                                               (QREFELT $ 56))
                                     (QREFELT $ 57))
                                    |s1| (QREFELT $ 60))
                                   |s2| (QREFELT $ 60))
                                  |dz| (QREFELT $ 60)))
                           (LETT |z0| (SPADCALL |z| 0 (QREFELT $ 59)))
                           (EXIT
                            (COND
                             ((SPADCALL |z0| (|spadConstant| $ 25)
                                        (QREFELT $ 29))
                              (SPADCALL |ss| (QREFELT $ 61)))
                             ((QREFELT $ 8)
                              (SEQ
                               (LETT |c0|
                                     (SPADCALL |z0| |n| |m| (QREFELT $ 69)))
                               (EXIT
                                (SPADCALL (SPADCALL |c0| (QREFELT $ 63))
                                          (SPADCALL |ss| (QREFELT $ 61))
                                          (QREFELT $ 64)))))
                             (#1#
                              (|error|
                               "ELFUTS:ellipticPi: constant coefficient should be 0"))))))))))) 

(DECLAIM (NOTINLINE |EllipticFunctionsUnivariateTaylorSeries;|)) 

(DEFUN |EllipticFunctionsUnivariateTaylorSeries| (&REST #1=#:G742)
  (SPROG NIL
         (PROG (#2=#:G743)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|EllipticFunctionsUnivariateTaylorSeries|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |EllipticFunctionsUnivariateTaylorSeries;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|EllipticFunctionsUnivariateTaylorSeries|)))))))))) 

(DEFUN |EllipticFunctionsUnivariateTaylorSeries;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$|
                (LIST '|EllipticFunctionsUnivariateTaylorSeries| DV$1 DV$2))
          (LETT $ (GETREFV 71))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|))))))))
          (|haddProp| |$ConstructorCache|
                      '|EllipticFunctionsUnivariateTaylorSeries|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|HasCategory| |#1| '(|SpecialFunctionCategory|)))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 65
                       (CONS
                        (|dispatchFunction| |ELFUTS;ellipticE;UTSCoefUTS;6|)
                        $))
             (QSETREFV $ 67
                       (CONS
                        (|dispatchFunction| |ELFUTS;ellipticF;UTSCoefUTS;7|)
                        $))
             (QSETREFV $ 70
                       (CONS
                        (|dispatchFunction| |ELFUTS;ellipticPi;UTS2CoefUTS;8|)
                        $)))))
          $))) 

(MAKEPROP '|EllipticFunctionsUnivariateTaylorSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'SPFCN
              (|Stream| 6) (|Integer|) (|List| 9) (0 . |elt|)
              (|StreamTaylorSeriesOperations| 6) (6 . *) (|Mapping| 9)
              (12 . |lazyIntegrate|) (18 . |One|) (22 . |One|)
              (|PositiveInteger|) (26 . |One|) (30 . *) (36 . *) (|Boolean|)
              (42 . |empty?|) (47 . |Zero|) (51 . |coerce|) (56 . |frst|)
              (61 . |Zero|) (65 . =) (71 . |deriv|) (76 . -) (|Mapping| 11 11)
              (|ParadoxicalCombinatorsForStreams| 6) (81 . Y) (87 . |jacobiSn|)
              (93 . |jacobiCn|) (99 . |jacobiDn|) (105 . ^) (111 . -)
              (|Union| 9 '"failed") (117 . |recip|) (122 . +)
              |ELFUTS;sncndn;SCoefL;2| (128 . |coefficients|) (133 . |series|)
              |ELFUTS;jacobiSn;UTSCoefUTS;3| |ELFUTS;jacobiCn;UTSCoefUTS;4|
              |ELFUTS;jacobiDn;UTSCoefUTS;5| (138 . |differentiate|) (143 . ^)
              (149 . *) (155 . -) (161 . |sqrt|) (|Fraction| 10) (166 . /)
              (172 . -) (177 . ^) (|NonNegativeInteger|) (183 . |coefficient|)
              (189 . *) (195 . |integrate|) (200 . |ellipticE|)
              (206 . |coerce|) (211 . +) (217 . |ellipticE|)
              (223 . |ellipticF|) (229 . |ellipticF|) (235 . |One|)
              (239 . |ellipticPi|) (246 . |ellipticPi|))
           '#(|sncndn| 253 |jacobiSn| 259 |jacobiDn| 265 |jacobiCn| 271
              |ellipticPi| 277 |ellipticF| 284 |ellipticE| 290)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|jacobiSn| (|#2| |#2| |#1|)) T)
                                   '((|jacobiCn| (|#2| |#2| |#1|)) T)
                                   '((|jacobiDn| (|#2| |#2| |#1|)) T)
                                   '((|ellipticE| (|#2| |#2| |#1|))
                                     (|has| 6 (|Algebra| 54)))
                                   '((|ellipticF| (|#2| |#2| |#1|))
                                     (|has| 6 (|Algebra| 54)))
                                   '((|ellipticPi| (|#2| |#2| |#1| |#1|))
                                     (|has| 6 (|Algebra| 54)))
                                   '((|sncndn|
                                      ((|List| (|Stream| |#1|)) (|Stream| |#1|)
                                       |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 70
                                            '(2 11 9 0 10 12 2 13 9 9 9 14 2 13
                                              9 6 15 16 0 6 0 17 0 7 0 18 0 19
                                              0 20 2 13 9 6 9 21 2 6 0 0 0 22 1
                                              9 23 0 24 0 6 0 25 1 13 9 6 26 1
                                              9 6 0 27 0 7 0 28 2 6 23 0 0 29 1
                                              13 9 9 30 1 6 0 0 31 2 33 11 32
                                              10 34 2 6 0 0 0 35 2 6 0 0 0 36 2
                                              6 0 0 0 37 2 6 0 0 19 38 2 13 9 9
                                              9 39 1 13 40 9 41 2 13 9 9 9 42 1
                                              7 9 0 44 1 7 0 9 45 1 7 0 0 49 2
                                              7 0 0 19 50 2 7 0 6 0 51 2 7 0 0
                                              0 52 1 7 0 0 53 2 54 0 10 10 55 1
                                              54 0 0 56 2 7 0 0 54 57 2 7 6 0
                                              58 59 2 7 0 0 0 60 1 7 0 0 61 2 6
                                              0 0 0 62 1 7 0 6 63 2 7 0 0 0 64
                                              2 0 7 7 6 65 2 6 0 0 0 66 2 0 7 7
                                              6 67 0 54 0 68 3 6 0 0 0 0 69 3 0
                                              7 7 6 6 70 2 0 11 9 6 43 2 0 7 7
                                              6 46 2 0 7 7 6 48 2 0 7 7 6 47 3
                                              1 7 7 6 6 70 2 1 7 7 6 67 2 1 7 7
                                              6 65)))))
           '|lookupComplete|)) 

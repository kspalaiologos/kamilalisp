
(SDEFUN |SIGNRF;sign;FU;1|
        ((|f| (|Fraction| (|Polynomial| R)))
         ($ (|Union| (|Integer|) #1="failed")))
        (SPROG ((|ud| #2=(|Union| (|Integer|) #1#)) (|un| #2#))
               (SEQ (LETT |un| (|SIGNRF;psign| (SPADCALL |f| (QREFELT $ 9)) $))
                    (EXIT
                     (COND ((QEQCAR |un| 1) (CONS 1 "failed"))
                           (#3='T
                            (SEQ
                             (LETT |ud|
                                   (|SIGNRF;psign|
                                    (SPADCALL |f| (QREFELT $ 10)) $))
                             (EXIT
                              (COND ((QEQCAR |ud| 1) (CONS 1 "failed"))
                                    (#3#
                                     (CONS 0
                                           (* (QCDR |un|)
                                              (QCDR |ud|))))))))))))) 

(SDEFUN |SIGNRF;finiteSign|
        ((|g|
          (|Fraction|
           (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
         (|a| (|Fraction| (|Polynomial| R)))
         ($ (|Union| (|Integer|) "failed")))
        (SPROG ((|un| #1=(|Union| (|Integer|) "failed")) (|ud| #1#))
               (SEQ
                (LETT |ud|
                      (SPADCALL (SPADCALL |g| (QREFELT $ 15)) |a| (ELT $ 12)
                                (QREFELT $ 18)))
                (EXIT
                 (COND ((QEQCAR |ud| 1) (CONS 1 "failed"))
                       (#2='T
                        (SEQ
                         (LETT |un|
                               (SPADCALL (SPADCALL |g| (QREFELT $ 19)) |a|
                                         (ELT $ 12) (QREFELT $ 18)))
                         (EXIT
                          (COND ((QEQCAR |un| 1) (CONS 1 "failed"))
                                (#2#
                                 (CONS 0 (* (QCDR |un|) (QCDR |ud|))))))))))))) 

(SDEFUN |SIGNRF;sign;FSOcU;3|
        ((|f| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
         (|a| (|OrderedCompletion| (|Fraction| (|Polynomial| R))))
         ($ (|Union| (|Integer|) "failed")))
        (SPROG
         ((|un| #1=(|Union| (|Integer|) "failed")) (|ud| #1#) (|n| (|Integer|))
          (|g|
           (|Fraction|
            (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R))))))
         (SEQ (LETT |g| (SPADCALL |f| |x| (QREFELT $ 22)))
              (EXIT
               (COND
                ((ZEROP (LETT |n| (SPADCALL |a| (QREFELT $ 25))))
                 (|SIGNRF;finiteSign| |g| (SPADCALL |a| (QREFELT $ 26)) $))
                (#2='T
                 (SEQ
                  (LETT |ud|
                        (SPADCALL (SPADCALL |g| (QREFELT $ 15)) |n| (ELT $ 12)
                                  (QREFELT $ 28)))
                  (EXIT
                   (COND ((QEQCAR |ud| 1) (CONS 1 "failed"))
                         (#2#
                          (SEQ
                           (LETT |un|
                                 (SPADCALL (SPADCALL |g| (QREFELT $ 19)) |n|
                                           (ELT $ 12) (QREFELT $ 28)))
                           (EXIT
                            (COND ((QEQCAR |un| 1) (CONS 1 "failed"))
                                  (#2#
                                   (CONS 0
                                         (* (QCDR |un|)
                                            (QCDR |ud|))))))))))))))))) 

(SDEFUN |SIGNRF;sign;FSFSU;4|
        ((|f| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
         (|a| (|Fraction| (|Polynomial| R))) (|st| (|String|))
         ($ (|Union| (|Integer|) "failed")))
        (SPROG
         ((|un| #1=(|Union| (|Integer|) "failed")) (|ud| #1#) (|d| (|Integer|))
          (|g|
           (|Fraction|
            (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R))))))
         (SEQ
          (LETT |ud|
                (SPADCALL
                 (SPADCALL (LETT |g| (SPADCALL |f| |x| (QREFELT $ 22)))
                           (QREFELT $ 15))
                 |a| (LETT |d| (SPADCALL |st| (QREFELT $ 32))) (ELT $ 12)
                 (QREFELT $ 33)))
          (EXIT
           (COND ((QEQCAR |ud| 1) (CONS 1 "failed"))
                 (#2='T
                  (SEQ
                   (LETT |un|
                         (SPADCALL (SPADCALL |g| (QREFELT $ 19)) |a| |d|
                                   (ELT $ 12) (QREFELT $ 33)))
                   (EXIT
                    (COND ((QEQCAR |un| 1) (CONS 1 "failed"))
                          (#2# (CONS 0 (* (QCDR |un|) (QCDR |ud|))))))))))))) 

(SDEFUN |SIGNRF;psign|
        ((|p| (|Polynomial| R)) ($ (|Union| (|Integer|) "failed")))
        (SPROG
         ((|ans| (|Integer|)) (#1=#:G770 NIL)
          (|u| (|Union| (|Integer|) "failed")) (#2=#:G771 NIL) (|term| NIL)
          (|s| (|Factored| (|Polynomial| R))) (|r| (|Union| R "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 36)))
                (EXIT
                 (COND ((QEQCAR |r| 0) (SPADCALL (QCDR |r|) (QREFELT $ 37)))
                       (#3='T
                        (SEQ
                         (LETT |u|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (LETT |s| (SPADCALL |p| (QREFELT $ 39)))
                                  (QREFELT $ 41))
                                 (QREFELT $ 42))
                                (QREFELT $ 37)))
                         (EXIT
                          (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                                (#3#
                                 (SEQ (LETT |ans| (QCDR |u|))
                                      (SEQ (LETT |term| NIL)
                                           (LETT #2#
                                                 (SPADCALL |s| (QREFELT $ 46)))
                                           G190
                                           (COND
                                            ((OR (ATOM #2#)
                                                 (PROGN
                                                  (LETT |term| (CAR #2#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (COND
                                              ((ODDP (QVELT |term| 2))
                                               (SEQ
                                                (LETT |u|
                                                      (|SIGNRF;sqfrSign|
                                                       (QVELT |term| 1) $))
                                                (EXIT
                                                 (COND
                                                  ((QEQCAR |u| 1)
                                                   (PROGN
                                                    (LETT #1#
                                                          (CONS 1 "failed"))
                                                    (GO #4=#:G769)))
                                                  ('T
                                                   (LETT |ans|
                                                         (* |ans|
                                                            (QCDR
                                                             |u|)))))))))))
                                           (LETT #2# (CDR #2#)) (GO G190) G191
                                           (EXIT NIL))
                                      (EXIT (CONS 0 |ans|))))))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |SIGNRF;sqfrSign|
        ((|p| (|Polynomial| R)) ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((|u| (|Union| (|Integer|) #1#)) (|l| (|List| (|Polynomial| R))))
         (SEQ
          (LETT |u|
                (|SIGNRF;termSign|
                 (|SPADfirst| (LETT |l| (SPADCALL |p| (QREFELT $ 48)))) $))
          (EXIT
           (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                 ('T (|SIGNRF;listSign| (CDR |l|) (QCDR |u|) $))))))) 

(SDEFUN |SIGNRF;listSign|
        ((|l| (|List| (|Polynomial| R))) (|s| (|Integer|))
         ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((#2=#:G786 NIL) (#3=#:G787 NIL) (|u| (|Union| (|Integer|) #1#))
          (#4=#:G788 NIL) (|term| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |term| NIL) (LETT #4# |l|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |term| (CAR #4#)) NIL))
                   (GO G191)))
                 (SEQ (LETT |u| (|SIGNRF;termSign| |term| $))
                      (EXIT
                       (COND
                        ((QEQCAR |u| 1)
                         (PROGN (LETT #3# (CONS 1 "failed")) (GO #5=#:G785)))
                        ('T
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (QCDR |u|) |s| (QREFELT $ 50))
                             (PROGN
                              (LETT #2#
                                    (PROGN
                                     (LETT #3# (CONS 1 "failed"))
                                     (GO #5#)))
                              (GO #6=#:G781)))))
                          #6# (EXIT #2#))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 0 |s|))))
          #5# (EXIT #3#)))) 

(SDEFUN |SIGNRF;termSign|
        ((|term| (|Polynomial| R)) ($ (|Union| (|Integer|) "failed")))
        (SPROG ((#1=#:G797 NIL) (#2=#:G798 NIL) (#3=#:G799 NIL) (|var| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |var| NIL)
                         (LETT #3# (SPADCALL |term| (QREFELT $ 52))) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |var| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((ODDP (SPADCALL |term| |var| (QREFELT $ 54)))
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2# (CONS 1 "failed"))
                                     (GO #4=#:G796)))
                              (GO #5=#:G794))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT
                   (SPADCALL (SPADCALL |term| (QREFELT $ 55))
                             (QREFELT $ 37)))))
                #4# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |RationalFunctionSign;|)) 

(DEFUN |RationalFunctionSign| (#1=#:G800)
  (SPROG NIL
         (PROG (#2=#:G801)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RationalFunctionSign|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|RationalFunctionSign;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RationalFunctionSign|)))))))))) 

(DEFUN |RationalFunctionSign;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RationalFunctionSign| DV$1))
          (LETT $ (GETREFV 56))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalFunctionSign| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RationalFunctionSign| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Polynomial| 6)
              (|Fraction| 7) (0 . |numer|) (5 . |denom|)
              (|Union| 27 '#1="failed") |SIGNRF;sign;FU;1|
              (|SparseUnivariatePolynomial| 8) (|Fraction| 13) (10 . |denom|)
              (|Mapping| 11 8) (|InnerPolySign| 8 13) (15 . |signAround|)
              (22 . |numer|) (|Symbol|)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 20) 20
                                                     6 7 8)
              (27 . |univariate|) (|SingleInteger|) (|OrderedCompletion| 8)
              (33 . |whatInfinity|) (38 . |retract|) (|Integer|)
              (43 . |signAround|) |SIGNRF;sign;FSOcU;3| (|String|)
              (|ToolsForSign| 6) (50 . |direction|) (55 . |signAround|)
              |SIGNRF;sign;FSFSU;4| (|Union| 6 '"failed") (63 . |retractIfCan|)
              (68 . |sign|) (|Factored| $) (73 . |squareFree|) (|Factored| 7)
              (78 . |unit|) (83 . |retract|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 43) (|:| |factor| 7) (|:| |exponent| 53))
              (|List| 44) (88 . |factorList|) (|List| $) (93 . |monomials|)
              (|Boolean|) (98 . ~=) (|List| 20) (104 . |variables|)
              (|NonNegativeInteger|) (109 . |degree|)
              (115 . |leadingCoefficient|))
           '#(|sign| 120) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|sign|
                                 ((|Union| (|Integer|) #1#)
                                  (|Fraction| (|Polynomial| |#1|))))
                                T)
                              '((|sign|
                                 ((|Union| (|Integer|) #1#)
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)
                                  (|OrderedCompletion|
                                   (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|sign|
                                 ((|Union| (|Integer|) #1#)
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)
                                  (|Fraction| (|Polynomial| |#1|)) (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 55
                                            '(1 8 7 0 9 1 8 7 0 10 1 14 13 0 15
                                              3 17 11 13 8 16 18 1 14 13 0 19 2
                                              21 14 8 20 22 1 24 23 0 25 1 24 8
                                              0 26 3 17 11 13 27 16 28 1 31 27
                                              30 32 4 17 11 13 8 27 16 33 1 7
                                              35 0 36 1 31 11 6 37 1 7 38 0 39
                                              1 40 7 0 41 1 7 6 0 42 1 40 45 0
                                              46 1 7 47 0 48 2 27 49 0 0 50 1 7
                                              51 0 52 2 7 53 0 20 54 1 7 6 0 55
                                              1 0 11 8 12 4 0 11 8 20 8 30 34 3
                                              0 11 8 20 24 29)))))
           '|lookupComplete|)) 

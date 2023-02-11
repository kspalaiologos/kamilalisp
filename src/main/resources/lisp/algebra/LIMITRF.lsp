
(SDEFUN |LIMITRF;limit;FEU;1|
        ((|f| (|Fraction| (|Polynomial| R)))
         (|eq| (|Equation| (|Fraction| (|Polynomial| R))))
         ($
          (|Union| (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                   (|Record|
                    (|:| |leftHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                          #1="failed"))
                    (|:| |rightHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                          #1#)))
                   "failed")))
        (SPROG
         ((|a| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
          (|xx| (|Union| (|Symbol|) "failed")))
         (SEQ
          (LETT |xx| (SPADCALL (SPADCALL |eq| (QREFELT $ 9)) (QREFELT $ 11)))
          (EXIT
           (COND
            ((QEQCAR |xx| 1)
             (|error| "limit: left hand side must be a variable"))
            ('T
             (SEQ (LETT |x| (QCDR |xx|))
                  (LETT |a| (SPADCALL |eq| (QREFELT $ 12)))
                  (EXIT
                   (|LIMITRF;locallimit| |f| |x| (SPADCALL |a| (QREFELT $ 14))
                    $))))))))) 

(SDEFUN |LIMITRF;complexLimit;FEOpc;2|
        ((|f| (|Fraction| (|Polynomial| R)))
         (|eq| (|Equation| (|Fraction| (|Polynomial| R))))
         ($ (|OnePointCompletion| (|Fraction| (|Polynomial| R)))))
        (SPROG
         ((|a| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
          (|xx| (|Union| (|Symbol|) "failed")))
         (SEQ
          (LETT |xx| (SPADCALL (SPADCALL |eq| (QREFELT $ 9)) (QREFELT $ 11)))
          (EXIT
           (COND
            ((QEQCAR |xx| 1)
             (|error| "limit: left hand side must be a variable"))
            ('T
             (SEQ (LETT |x| (QCDR |xx|))
                  (LETT |a| (SPADCALL |eq| (QREFELT $ 12)))
                  (EXIT
                   (|LIMITRF;locallimitcomplex| |f| |x|
                    (SPADCALL |a| (QREFELT $ 20)) $))))))))) 

(SDEFUN |LIMITRF;limit;FEU;3|
        ((|f| (|Fraction| (|Polynomial| R)))
         (|eq| (|Equation| (|OrderedCompletion| (|Polynomial| R))))
         ($
          (|Union| (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                   (|Record|
                    (|:| |leftHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                          #1="failed"))
                    (|:| |rightHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                          #1#)))
                   "failed")))
        (SPROG
         ((|a| (|OrderedCompletion| (|Fraction| (|Polynomial| R))))
          (|x| (|Symbol|)) (|xx| (|Union| (|Symbol|) "failed"))
          (|p| (|Union| (|Polynomial| R) "failed")))
         (SEQ
          (LETT |p| (SPADCALL (SPADCALL |eq| (QREFELT $ 24)) (QREFELT $ 26)))
          (EXIT
           (COND
            ((QEQCAR |p| 1)
             (|error| "limit: left hand side must be a variable"))
            (#2='T
             (SEQ (LETT |xx| (SPADCALL (QCDR |p|) (QREFELT $ 28)))
                  (EXIT
                   (COND
                    ((QEQCAR |xx| 1)
                     (|error| "limit: left hand side must be a variable"))
                    (#2#
                     (SEQ (LETT |x| (QCDR |xx|))
                          (LETT |a|
                                (SPADCALL (ELT $ 29)
                                          (SPADCALL |eq| (QREFELT $ 30))
                                          (QREFELT $ 33)))
                          (EXIT (|LIMITRF;locallimit| |f| |x| |a| $))))))))))))) 

(SDEFUN |LIMITRF;complexLimit;FEOpc;4|
        ((|f| (|Fraction| (|Polynomial| R)))
         (|eq| (|Equation| (|OnePointCompletion| (|Polynomial| R))))
         ($ (|OnePointCompletion| (|Fraction| (|Polynomial| R)))))
        (SPROG
         ((|a| (|OnePointCompletion| (|Fraction| (|Polynomial| R))))
          (|x| (|Symbol|)) (|xx| (|Union| (|Symbol|) "failed"))
          (|p| (|Union| (|Polynomial| R) "failed")))
         (SEQ
          (LETT |p| (SPADCALL (SPADCALL |eq| (QREFELT $ 37)) (QREFELT $ 38)))
          (EXIT
           (COND
            ((QEQCAR |p| 1)
             (|error| "limit: left hand side must be a variable"))
            (#1='T
             (SEQ (LETT |xx| (SPADCALL (QCDR |p|) (QREFELT $ 28)))
                  (EXIT
                   (COND
                    ((QEQCAR |xx| 1)
                     (|error| "limit: left hand side must be a variable"))
                    (#1#
                     (SEQ (LETT |x| (QCDR |xx|))
                          (LETT |a|
                                (SPADCALL (ELT $ 29)
                                          (SPADCALL |eq| (QREFELT $ 39))
                                          (QREFELT $ 41)))
                          (EXIT
                           (|LIMITRF;locallimitcomplex| |f| |x| |a|
                            $))))))))))))) 

(SDEFUN |LIMITRF;fLimit|
        ((|n| (|Integer|))
         (|d| (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R))))
         (|a| (|Fraction| (|Polynomial| R))) (|dir| (|Integer|))
         ($
          (|Union| (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                   "failed")))
        (SPROG ((|si| (|Integer|)) (|s| (|Union| (|Integer|) "failed")))
               (SEQ
                (LETT |s| (SPADCALL |d| |a| |dir| (ELT $ 45) (QREFELT $ 50)))
                (EXIT
                 (COND ((QEQCAR |s| 1) (CONS 1 "failed"))
                       (#1='T
                        (SEQ (LETT |si| (* |n| (QCDR |s|)))
                             (EXIT
                              (COND
                               ((EQL |si| 0) (|error| "fLimit: sign is 0"))
                               ((> |si| 0) (CONS 0 (SPADCALL (QREFELT $ 52))))
                               (#1# (CONS 0 (SPADCALL (QREFELT $ 53))))))))))))) 

(SDEFUN |LIMITRF;finiteComplexLimit|
        ((|f|
          (|Fraction|
           (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
         (|a| (|Fraction| (|Polynomial| R)))
         ($ (|OnePointCompletion| (|Fraction| (|Polynomial| R)))))
        (SPROG ((|d| #1=(|Fraction| (|Polynomial| R))) (|n| #1#))
               (COND
                ((SPADCALL
                  (LETT |n|
                        (SPADCALL (SPADCALL |f| (QREFELT $ 55)) |a|
                                  (QREFELT $ 56)))
                  (QREFELT $ 58))
                 (SPADCALL (|spadConstant| $ 59) (QREFELT $ 20)))
                ((SPADCALL
                  (LETT |d|
                        (SPADCALL (SPADCALL |f| (QREFELT $ 60)) |a|
                                  (QREFELT $ 56)))
                  (QREFELT $ 58))
                 (SPADCALL (QREFELT $ 61)))
                ('T
                 (SPADCALL (SPADCALL |n| |d| (QREFELT $ 62)) (QREFELT $ 20)))))) 

(SDEFUN |LIMITRF;finiteLimit|
        ((|f|
          (|Fraction|
           (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
         (|a| (|Fraction| (|Polynomial| R)))
         ($
          (|Union| (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                   (|Record|
                    (|:| |leftHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                          #1="failed"))
                    (|:| |rightHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                          #1#)))
                   "failed")))
        (SPROG
         ((|lhsl|
           #2=(|Union| (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                       #1#))
          (|rhsl| #2#) (|s| (|Union| (|Integer|) "failed"))
          (|d| #3=(|Fraction| (|Polynomial| R))) (|n| #3#))
         (SEQ
          (COND
           ((SPADCALL
             (LETT |n|
                   (SPADCALL (SPADCALL |f| (QREFELT $ 55)) |a| (QREFELT $ 56)))
             (QREFELT $ 58))
            (CONS 0 (SPADCALL (|spadConstant| $ 59) (QREFELT $ 14))))
           ((SPADCALL
             (LETT |d|
                   (SPADCALL (SPADCALL |f| (QREFELT $ 60)) |a| (QREFELT $ 56)))
             (QREFELT $ 58))
            (SEQ (LETT |s| (SPADCALL |n| (QREFELT $ 45)))
                 (EXIT
                  (COND ((QEQCAR |s| 1) (CONS 2 "failed"))
                        (#4='T
                         (SEQ
                          (LETT |rhsl|
                                (|LIMITRF;fLimit| (QCDR |s|)
                                 (SPADCALL |f| (QREFELT $ 60)) |a| 1 $))
                          (LETT |lhsl|
                                (|LIMITRF;fLimit| (QCDR |s|)
                                 (SPADCALL |f| (QREFELT $ 60)) |a| -1 $))
                          (EXIT
                           (COND
                            ((QEQCAR |rhsl| 1)
                             (COND ((QEQCAR |lhsl| 1) (CONS 2 "failed"))
                                   (#4# (CONS 1 (CONS |lhsl| |rhsl|)))))
                            ((QEQCAR |lhsl| 1) (CONS 1 (CONS |lhsl| |rhsl|)))
                            (#4#
                             (COND
                              ((SPADCALL (QCDR |rhsl|) (QCDR |lhsl|)
                                         (QREFELT $ 65))
                               (CONS 0 (QCDR |lhsl|)))
                              (#4# (CONS 1 (CONS |lhsl| |rhsl|)))))))))))))
           (#4#
            (CONS 0
                  (SPADCALL (SPADCALL |n| |d| (QREFELT $ 62))
                            (QREFELT $ 14)))))))) 

(SDEFUN |LIMITRF;locallimit|
        ((|f| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
         (|a| (|OrderedCompletion| (|Fraction| (|Polynomial| R))))
         ($
          (|Union| (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                   (|Record|
                    (|:| |leftHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                          #1="failed"))
                    (|:| |rightHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                          #1#)))
                   "failed")))
        (SPROG
         ((|si| (|Integer|)) (|sd| #2=(|Union| (|Integer|) "failed"))
          (|sn| #2#) (|dd| #3=(|NonNegativeInteger|)) (|dn| #3#)
          (|n| (|SingleInteger|))
          (|g|
           (|Fraction|
            (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R))))))
         (SEQ (LETT |g| (SPADCALL |f| |x| (QREFELT $ 68)))
              (EXIT
               (COND
                ((|zero?_SI| (LETT |n| (SPADCALL |a| (QREFELT $ 70))))
                 (|LIMITRF;finiteLimit| |g| (SPADCALL |a| (QREFELT $ 71)) $))
                (#4='T
                 (SEQ
                  (LETT |dn|
                        (SPADCALL (SPADCALL |g| (QREFELT $ 55))
                                  (QREFELT $ 73)))
                  (LETT |dd|
                        (SPADCALL (SPADCALL |g| (QREFELT $ 60))
                                  (QREFELT $ 73)))
                  (EXIT
                   (COND
                    ((> |dn| |dd|)
                     (SEQ
                      (LETT |sn|
                            (SPADCALL (SPADCALL |g| (QREFELT $ 55)) |n|
                                      (ELT $ 45) (QREFELT $ 74)))
                      (EXIT
                       (COND ((QEQCAR |sn| 1) (CONS 2 "failed"))
                             (#4#
                              (SEQ
                               (LETT |sd|
                                     (SPADCALL (SPADCALL |g| (QREFELT $ 60))
                                               |n| (ELT $ 45) (QREFELT $ 74)))
                               (EXIT
                                (COND ((QEQCAR |sd| 1) (CONS 2 "failed"))
                                      (#4#
                                       (SEQ
                                        (LETT |si| (* (QCDR |sn|) (QCDR |sd|)))
                                        (EXIT
                                         (COND
                                          ((EQL |si| 0)
                                           (|error| "locallimit: sign is 0"))
                                          ((> |si| 0)
                                           (CONS 0 (SPADCALL (QREFELT $ 52))))
                                          (#4#
                                           (CONS 0
                                                 (SPADCALL
                                                  (QREFELT $ 53))))))))))))))))
                    ((< |dn| |dd|)
                     (CONS 0 (SPADCALL (|spadConstant| $ 59) (QREFELT $ 14))))
                    (#4#
                     (CONS 0
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (SPADCALL |g| (QREFELT $ 55))
                                       (QREFELT $ 75))
                             (SPADCALL (SPADCALL |g| (QREFELT $ 60))
                                       (QREFELT $ 75))
                             (QREFELT $ 62))
                            (QREFELT $ 14))))))))))))) 

(SDEFUN |LIMITRF;limit;FESU;9|
        ((|f| (|Fraction| (|Polynomial| R)))
         (|eq| (|Equation| (|Fraction| (|Polynomial| R)))) (|st| (|String|))
         ($
          (|Union| (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                   "failed")))
        (SPROG
         ((|s| (|Union| (|Integer|) "failed"))
          (|d| #1=(|Fraction| (|Polynomial| R))) (|n| #1#)
          (|g|
           (|Fraction|
            (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
          (|a| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
          (|xx| (|Union| (|Symbol|) "failed")))
         (SEQ
          (LETT |xx| (SPADCALL (SPADCALL |eq| (QREFELT $ 9)) (QREFELT $ 11)))
          (EXIT
           (COND
            ((QEQCAR |xx| 1)
             (|error| "limit: left hand side must be a variable"))
            (#2='T
             (SEQ (LETT |x| (QCDR |xx|))
                  (LETT |a| (SPADCALL |eq| (QREFELT $ 12)))
                  (EXIT
                   (COND
                    ((SPADCALL
                      (LETT |n|
                            (SPADCALL
                             (SPADCALL
                              (LETT |g| (SPADCALL |f| |x| (QREFELT $ 68)))
                              (QREFELT $ 55))
                             |a| (QREFELT $ 56)))
                      (QREFELT $ 58))
                     (CONS 0 (SPADCALL (|spadConstant| $ 59) (QREFELT $ 14))))
                    ((SPADCALL
                      (LETT |d|
                            (SPADCALL (SPADCALL |g| (QREFELT $ 60)) |a|
                                      (QREFELT $ 56)))
                      (QREFELT $ 58))
                     (SEQ (LETT |s| (SPADCALL |n| (QREFELT $ 45)))
                          (EXIT
                           (COND ((QEQCAR |s| 1) (CONS 1 "failed"))
                                 (#2#
                                  (|LIMITRF;fLimit| (QCDR |s|)
                                   (SPADCALL |g| (QREFELT $ 60)) |a|
                                   (SPADCALL |st| (QREFELT $ 78)) $))))))
                    (#2#
                     (CONS 0
                           (SPADCALL (SPADCALL |n| |d| (QREFELT $ 62))
                                     (QREFELT $ 14))))))))))))) 

(SDEFUN |LIMITRF;locallimitcomplex|
        ((|f| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
         (|a| (|OnePointCompletion| (|Fraction| (|Polynomial| R))))
         ($ (|OnePointCompletion| (|Fraction| (|Polynomial| R)))))
        (SPROG
         ((|dd| #1=(|NonNegativeInteger|)) (|dn| #1#)
          (|r| (|Union| (|Fraction| (|Polynomial| R)) "failed"))
          (|g|
           (|Fraction|
            (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R))))))
         (SEQ (LETT |g| (SPADCALL |f| |x| (QREFELT $ 68)))
              (LETT |r| (SPADCALL |a| (QREFELT $ 81)))
              (EXIT
               (COND
                ((QEQCAR |r| 0)
                 (|LIMITRF;finiteComplexLimit| |g| (QCDR |r|) $))
                (#2='T
                 (SEQ
                  (LETT |dn|
                        (SPADCALL (SPADCALL |g| (QREFELT $ 55))
                                  (QREFELT $ 73)))
                  (LETT |dd|
                        (SPADCALL (SPADCALL |g| (QREFELT $ 60))
                                  (QREFELT $ 73)))
                  (EXIT
                   (COND ((> |dn| |dd|) (SPADCALL (QREFELT $ 61)))
                         ((< |dn| |dd|)
                          (SPADCALL (|spadConstant| $ 59) (QREFELT $ 20)))
                         (#2#
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |g| (QREFELT $ 55))
                                      (QREFELT $ 75))
                            (SPADCALL (SPADCALL |g| (QREFELT $ 60))
                                      (QREFELT $ 75))
                            (QREFELT $ 62))
                           (QREFELT $ 20)))))))))))) 

(DECLAIM (NOTINLINE |RationalFunctionLimitPackage;|)) 

(DEFUN |RationalFunctionLimitPackage| (#1=#:G834)
  (SPROG NIL
         (PROG (#2=#:G835)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RationalFunctionLimitPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|RationalFunctionLimitPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|RationalFunctionLimitPackage|)))))))))) 

(DEFUN |RationalFunctionLimitPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RationalFunctionLimitPackage| DV$1))
          (LETT $ (GETREFV 82))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalFunctionLimitPackage|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RationalFunctionLimitPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Fraction| 27)
              (|Equation| 7) (0 . |lhs|) (|Union| 66 '"failed")
              (5 . |retractIfCan|) (10 . |rhs|) (|OrderedCompletion| 7)
              (15 . |coerce|) (|Union| 13 '#1="failed")
              (|Record| (|:| |leftHandLimit| 15) (|:| |rightHandLimit| 15))
              (|Union| 13 16 '#2="failed") |LIMITRF;limit;FEU;1|
              (|OnePointCompletion| 7) (20 . |coerce|)
              |LIMITRF;complexLimit;FEOpc;2| (|OrderedCompletion| 27)
              (|Equation| 22) (25 . |lhs|) (|Union| 27 '"failed")
              (30 . |retractIfCan|) (|Polynomial| 6) (35 . |retractIfCan|)
              (40 . |coerce|) (45 . |rhs|) (|Mapping| 7 27)
              (|OrderedCompletionFunctions2| 27 7) (50 . |map|)
              |LIMITRF;limit;FEU;3| (|OnePointCompletion| 27) (|Equation| 35)
              (56 . |lhs|) (61 . |retractIfCan|) (66 . |rhs|)
              (|OnePointCompletionFunctions2| 27 7) (71 . |map|)
              |LIMITRF;complexLimit;FEOpc;4| (|Union| 47 '"failed")
              (|RationalFunctionSign| 6) (77 . |sign|)
              (|SparseUnivariatePolynomial| 7) (|Integer|) (|Mapping| 43 7)
              (|InnerPolySign| 7 46) (82 . |signAround|) (90 . |Zero|)
              (94 . |plusInfinity|) (98 . |minusInfinity|) (|Fraction| 46)
              (102 . |numer|) (107 . |elt|) (|Boolean|) (113 . |zero?|)
              (118 . |Zero|) (122 . |denom|) (127 . |infinity|) (131 . /)
              (137 . |One|) (141 . |One|) (145 . =) (|Symbol|)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 66) 66
                                                     6 27 7)
              (151 . |univariate|) (|SingleInteger|) (157 . |whatInfinity|)
              (162 . |retract|) (|NonNegativeInteger|) (167 . |degree|)
              (172 . |signAround|) (179 . |leadingCoefficient|) (|String|)
              (|ToolsForSign| 6) (184 . |direction|) |LIMITRF;limit;FESU;9|
              (|Union| 7 '"failed") (189 . |retractIfCan|))
           '#(|limit| 194 |complexLimit| 213) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|limit|
                                 ((|Union|
                                   (|OrderedCompletion|
                                    (|Fraction| (|Polynomial| |#1|)))
                                   (|Record|
                                    (|:| |leftHandLimit|
                                         (|Union|
                                          (|OrderedCompletion|
                                           (|Fraction| (|Polynomial| |#1|)))
                                          #1#))
                                    (|:| |rightHandLimit|
                                         (|Union|
                                          (|OrderedCompletion|
                                           (|Fraction| (|Polynomial| |#1|)))
                                          #1#)))
                                   #2#)
                                  (|Fraction| (|Polynomial| |#1|))
                                  (|Equation|
                                   (|OrderedCompletion| (|Polynomial| |#1|)))))
                                T)
                              '((|limit|
                                 ((|Union|
                                   (|OrderedCompletion|
                                    (|Fraction| (|Polynomial| |#1|)))
                                   (|Record|
                                    (|:| |leftHandLimit|
                                         (|Union|
                                          (|OrderedCompletion|
                                           (|Fraction| (|Polynomial| |#1|)))
                                          #1#))
                                    (|:| |rightHandLimit|
                                         (|Union|
                                          (|OrderedCompletion|
                                           (|Fraction| (|Polynomial| |#1|)))
                                          #1#)))
                                   #2#)
                                  (|Fraction| (|Polynomial| |#1|))
                                  (|Equation|
                                   (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|complexLimit|
                                 ((|OnePointCompletion|
                                   (|Fraction| (|Polynomial| |#1|)))
                                  (|Fraction| (|Polynomial| |#1|))
                                  (|Equation|
                                   (|OnePointCompletion|
                                    (|Polynomial| |#1|)))))
                                T)
                              '((|complexLimit|
                                 ((|OnePointCompletion|
                                   (|Fraction| (|Polynomial| |#1|)))
                                  (|Fraction| (|Polynomial| |#1|))
                                  (|Equation|
                                   (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|limit|
                                 ((|Union|
                                   (|OrderedCompletion|
                                    (|Fraction| (|Polynomial| |#1|)))
                                   #1#)
                                  (|Fraction| (|Polynomial| |#1|))
                                  (|Equation| (|Fraction| (|Polynomial| |#1|)))
                                  (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 81
                                            '(1 8 7 0 9 1 7 10 0 11 1 8 7 0 12
                                              1 13 0 7 14 1 19 0 7 20 1 23 22 0
                                              24 1 22 25 0 26 1 27 10 0 28 1 7
                                              0 27 29 1 23 22 0 30 2 32 13 31
                                              22 33 1 36 35 0 37 1 35 25 0 38 1
                                              36 35 0 39 2 40 19 31 35 41 1 44
                                              43 7 45 4 49 43 46 7 47 48 50 0 6
                                              0 51 0 13 0 52 0 13 0 53 1 54 46
                                              0 55 2 46 7 0 7 56 1 7 57 0 58 0
                                              7 0 59 1 54 46 0 60 0 19 0 61 2 7
                                              0 0 0 62 0 6 0 63 0 54 0 64 2 13
                                              57 0 0 65 2 67 54 7 66 68 1 13 69
                                              0 70 1 13 7 0 71 1 46 72 0 73 3
                                              49 43 46 47 48 74 1 46 7 0 75 1
                                              77 47 76 78 1 19 80 0 81 2 0 17 7
                                              8 18 2 0 17 7 23 34 3 0 15 7 8 76
                                              79 2 0 19 7 36 42 2 0 19 7 8
                                              21)))))
           '|lookupComplete|)) 


(SDEFUN |RURPK;rur;L2BL;1|
        ((|lp| (|List| (|Polynomial| R))) (|univ?| (|Boolean|))
         (|check?| (|Boolean|))
         ($
          (|List|
           (|Record| (|:| |complexRoots| (|SparseUnivariatePolynomial| R))
                     (|:| |coordinates| (|List| (|Polynomial| R)))))))
        (SPROG
         ((|toReturn|
           (|List|
            (|Record| (|:| |complexRoots| (|SparseUnivariatePolynomial| R))
                      (|:| |coordinates| (|List| (|Polynomial| R))))))
          (|lc| (|List| (|Polynomial| R))) (#1=#:G794 NIL) (#2=#:G793 NIL)
          (|g| (|SparseUnivariatePolynomial| R)) (#3=#:G732 NIL)
          (#4=#:G792 NIL) (|us| NIL) (#5=#:G791 NIL)
          (|lus|
           (|List|
            (|SquareFreeRegularTriangularSet| R
                                              (|IndexedExponents|
                                               (|OrderedVariableList| |lv|))
                                              (|OrderedVariableList| |lv|)
                                              (|NewSparseMultivariatePolynomial|
                                               R
                                               (|OrderedVariableList| |lv|)))))
          (#6=#:G790 NIL)
          (|toSee|
           (|List|
            (|Record|
             (|:| |val|
                  (|List|
                   (|NewSparseMultivariatePolynomial| R
                                                      (|OrderedVariableList|
                                                       |lv|))))
             (|:| |tower|
                  (|SquareFreeRegularTriangularSet| R
                                                    (|IndexedExponents|
                                                     (|OrderedVariableList|
                                                      |lv|))
                                                    (|OrderedVariableList|
                                                     |lv|)
                                                    (|NewSparseMultivariatePolynomial|
                                                     R
                                                     (|OrderedVariableList|
                                                      |lv|)))))))
          (|newlq|
           (|List|
            (|NewSparseMultivariatePolynomial| R
                                               (|OrderedVariableList| |lv|))))
          (#7=#:G789 NIL) (#8=#:G788 NIL)
          (|newts|
           (|SquareFreeRegularTriangularSet| R
                                             (|IndexedExponents|
                                              (|OrderedVariableList| |lv|))
                                             (|OrderedVariableList| |lv|)
                                             (|NewSparseMultivariatePolynomial|
                                              R (|OrderedVariableList| |lv|))))
          (|q|
           (|NewSparseMultivariatePolynomial| R (|OrderedVariableList| |lv|)))
          (|ts|
           (|SquareFreeRegularTriangularSet| R
                                             (|IndexedExponents|
                                              (|OrderedVariableList| |lv|))
                                             (|OrderedVariableList| |lv|)
                                             (|NewSparseMultivariatePolynomial|
                                              R (|OrderedVariableList| |lv|))))
          (#9=#:G787 NIL) (|qwt| NIL)
          (|lsfqwt|
           (|List|
            (|Record|
             (|:| |val|
                  (|NewSparseMultivariatePolynomial| R
                                                     (|OrderedVariableList|
                                                      |lv|)))
             (|:| |tower|
                  (|SquareFreeRegularTriangularSet| R
                                                    (|IndexedExponents|
                                                     (|OrderedVariableList|
                                                      |lv|))
                                                    (|OrderedVariableList|
                                                     |lv|)
                                                    (|NewSparseMultivariatePolynomial|
                                                     R
                                                     (|OrderedVariableList|
                                                      |lv|)))))))
          (#10=#:G786 NIL) (#11=#:G785 NIL) (#12=#:G784 NIL) (|fq| NIL)
          (|lfq|
           (|List|
            (|NewSparseMultivariatePolynomial| R
                                               (|OrderedVariableList| |lv|))))
          (#13=#:G744 NIL)
          (|lq|
           (|List|
            (|NewSparseMultivariatePolynomial| R
                                               (|OrderedVariableList| |lv|))))
          (|toSave|
           (|List|
            (|SquareFreeRegularTriangularSet| R
                                              (|IndexedExponents|
                                               (|OrderedVariableList| |lv|))
                                              (|OrderedVariableList| |lv|)
                                              (|NewSparseMultivariatePolynomial|
                                               R
                                               (|OrderedVariableList| |lv|)))))
          (|lqwt|
           (|Record|
            (|:| |val|
                 (|List|
                  (|NewSparseMultivariatePolynomial| R
                                                     (|OrderedVariableList|
                                                      |lv|))))
            (|:| |tower|
                 (|SquareFreeRegularTriangularSet| R
                                                   (|IndexedExponents|
                                                    (|OrderedVariableList|
                                                     |lv|))
                                                   (|OrderedVariableList| |lv|)
                                                   (|NewSparseMultivariatePolynomial|
                                                    R
                                                    (|OrderedVariableList|
                                                     |lv|))))))
          (|rif|
           (|Union|
            (|NewSparseMultivariatePolynomial| R (|OrderedVariableList| |lv|))
            "failed"))
          (#14=#:G783 NIL) (|p| NIL))
         (SEQ (LETT |lp| (SPADCALL (ELT $ 23) |lp| (QREFELT $ 26)))
              (EXIT
               (COND ((NULL |lp|) (|error| "rur$RURPACK: #1 is empty"))
                     ((SPADCALL (ELT $ 27) |lp| (QREFELT $ 28))
                      (|error| "rur$RURPACK: #1 is not a triangular set"))
                     ('T
                      (SEQ
                       (LETT |ts|
                             (SPADCALL (LIST (QREFELT $ 20)) (QREFELT $ 31)))
                       (LETT |lq| NIL)
                       (SEQ (LETT |p| NIL) (LETT #14# |lp|) G190
                            (COND
                             ((OR (ATOM #14#)
                                  (PROGN (LETT |p| (CAR #14#)) NIL))
                              (GO G191)))
                            (SEQ (LETT |rif| (SPADCALL |p| (QREFELT $ 32)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |rif| 1)
                                    (|error|
                                     "rur$RURPACK: #1 is not a subset of R[ls]"))
                                   ('T
                                    (SEQ (LETT |q| (QCDR |rif|))
                                         (EXIT
                                          (LETT |lq| (CONS |q| |lq|))))))))
                            (LETT #14# (CDR #14#)) (GO G190) G191 (EXIT NIL))
                       (LETT |lq| (SPADCALL (ELT $ 33) |lq| (QREFELT $ 35)))
                       (LETT |toSee| (LIST (CONS |lq| |ts|)))
                       (LETT |toSave| NIL)
                       (SEQ G190
                            (COND ((NULL (NULL (NULL |toSee|))) (GO G191)))
                            (SEQ (LETT |lqwt| (|SPADfirst| |toSee|))
                                 (LETT |toSee| (CDR |toSee|))
                                 (LETT |lq| (QCAR |lqwt|))
                                 (LETT |ts| (QCDR |lqwt|))
                                 (EXIT
                                  (COND
                                   ((NULL |lq|)
                                    (LETT |toSave| (CONS |ts| |toSave|)))
                                   ('T
                                    (SEQ (LETT |q| (|SPADfirst| |lq|))
                                         (LETT |lq| (CDR |lq|))
                                         (COND
                                          ((NULL
                                            (SPADCALL
                                             (SPADCALL |q| (QREFELT $ 36))
                                             (SPADCALL |ts| (QREFELT $ 37))
                                             (QREFELT $ 38)))
                                           (EXIT
                                            (|error|
                                             "rur$RURPACK: #1 is not a triangular set"))))
                                         (EXIT
                                          (COND
                                           ((SPADCALL
                                             (PROG2
                                                 (LETT #13#
                                                       (SPADCALL |ts|
                                                                 (QREFELT $
                                                                          39)))
                                                 (QCDR #13#)
                                               (|check_union2| (QEQCAR #13# 0)
                                                               (|SquareFreeRegularTriangularSet|
                                                                (QREFELT $ 6)
                                                                (|IndexedExponents|
                                                                 (|OrderedVariableList|
                                                                  (QREFELT $
                                                                           13)))
                                                                (|OrderedVariableList|
                                                                 (QREFELT $
                                                                          13))
                                                                (|NewSparseMultivariatePolynomial|
                                                                 (QREFELT $ 6)
                                                                 (|OrderedVariableList|
                                                                  (QREFELT $
                                                                           13))))
                                                               (|Union|
                                                                (|SquareFreeRegularTriangularSet|
                                                                 (QREFELT $ 6)
                                                                 (|IndexedExponents|
                                                                  (|OrderedVariableList|
                                                                   (QREFELT $
                                                                            13)))
                                                                 (|OrderedVariableList|
                                                                  (QREFELT $
                                                                           13))
                                                                 (|NewSparseMultivariatePolynomial|
                                                                  (QREFELT $ 6)
                                                                  (|OrderedVariableList|
                                                                   (QREFELT $
                                                                            13))))
                                                                "failed")
                                                               #13#))
                                             (QREFELT $ 40))
                                            (SEQ
                                             (LETT |lfq|
                                                   (SPADCALL (LIST |q|)
                                                             (QREFELT $ 42)))
                                             (EXIT
                                              (SEQ (LETT |fq| NIL)
                                                   (LETT #12# |lfq|) G190
                                                   (COND
                                                    ((OR (ATOM #12#)
                                                         (PROGN
                                                          (LETT |fq|
                                                                (CAR #12#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (LETT |newts|
                                                          (SPADCALL |fq| |ts|
                                                                    (QREFELT $
                                                                             43)))
                                                    (LETT |newlq|
                                                          (PROGN
                                                           (LETT #11# NIL)
                                                           (SEQ
                                                            (LETT #10# |lq|)
                                                            G190
                                                            (COND
                                                             ((OR (ATOM #10#)
                                                                  (PROGN
                                                                   (LETT |q|
                                                                         (CAR
                                                                          #10#))
                                                                   NIL))
                                                              (GO G191)))
                                                            (SEQ
                                                             (EXIT
                                                              (LETT #11#
                                                                    (CONS
                                                                     (QVELT
                                                                      (SPADCALL
                                                                       |q|
                                                                       |newts|
                                                                       (QREFELT
                                                                        $ 45))
                                                                      1)
                                                                     #11#))))
                                                            (LETT #10#
                                                                  (CDR #10#))
                                                            (GO G190) G191
                                                            (EXIT
                                                             (NREVERSE
                                                              #11#)))))
                                                    (EXIT
                                                     (LETT |toSee|
                                                           (CONS
                                                            (CONS |newlq|
                                                                  |newts|)
                                                            |toSee|))))
                                                   (LETT #12# (CDR #12#))
                                                   (GO G190) G191
                                                   (EXIT NIL)))))
                                           ('T
                                            (SEQ
                                             (LETT |lsfqwt|
                                                   (SPADCALL |q| |ts|
                                                             (QREFELT $ 48)))
                                             (EXIT
                                              (SEQ (LETT |qwt| NIL)
                                                   (LETT #9# |lsfqwt|) G190
                                                   (COND
                                                    ((OR (ATOM #9#)
                                                         (PROGN
                                                          (LETT |qwt|
                                                                (CAR #9#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ (LETT |q| (QCAR |qwt|))
                                                        (LETT |ts|
                                                              (QCDR |qwt|))
                                                        (COND
                                                         ((NULL
                                                           (SPADCALL
                                                            (SPADCALL |q|
                                                                      (QREFELT
                                                                       $ 49))
                                                            (QREFELT $ 50)))
                                                          (LETT |q|
                                                                (SPADCALL |q|
                                                                          |ts|
                                                                          (QREFELT
                                                                           $
                                                                           52)))))
                                                        (LETT |newts|
                                                              (SPADCALL |q|
                                                                        |ts|
                                                                        (QREFELT
                                                                         $
                                                                         43)))
                                                        (LETT |newlq|
                                                              (PROGN
                                                               (LETT #8# NIL)
                                                               (SEQ
                                                                (LETT #7# |lq|)
                                                                G190
                                                                (COND
                                                                 ((OR
                                                                   (ATOM #7#)
                                                                   (PROGN
                                                                    (LETT |q|
                                                                          (CAR
                                                                           #7#))
                                                                    NIL))
                                                                  (GO G191)))
                                                                (SEQ
                                                                 (EXIT
                                                                  (LETT #8#
                                                                        (CONS
                                                                         (QVELT
                                                                          (SPADCALL
                                                                           |q|
                                                                           |newts|
                                                                           (QREFELT
                                                                            $
                                                                            45))
                                                                          1)
                                                                         #8#))))
                                                                (LETT #7#
                                                                      (CDR
                                                                       #7#))
                                                                (GO G190) G191
                                                                (EXIT
                                                                 (NREVERSE
                                                                  #8#)))))
                                                        (EXIT
                                                         (LETT |toSee|
                                                               (CONS
                                                                (CONS |newlq|
                                                                      |newts|)
                                                                |toSee|))))
                                                   (LETT #9# (CDR #9#))
                                                   (GO G190) G191
                                                   (EXIT NIL))))))))))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (LETT |toReturn| NIL)
                       (SEQ (LETT #6# |toSave|) G190
                            (COND
                             ((OR (ATOM #6#) (PROGN (LETT |ts| (CAR #6#)) NIL))
                              (GO G191)))
                            (SEQ
                             (LETT |lus|
                                   (SPADCALL |ts| |univ?| (QREFELT $ 55)))
                             (COND
                              (|check?|
                               (COND
                                ((NULL (SPADCALL |ts| |lus| (QREFELT $ 56)))
                                 (EXIT
                                  (SEQ (SPADCALL "RUR for: " (QREFELT $ 60))
                                       (SPADCALL (SPADCALL |ts| (QREFELT $ 62))
                                                 (QREFELT $ 63))
                                       (SPADCALL "Is: " (QREFELT $ 60))
                                       (SEQ (LETT |us| NIL) (LETT #5# |lus|)
                                            G190
                                            (COND
                                             ((OR (ATOM #5#)
                                                  (PROGN
                                                   (LETT |us| (CAR #5#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (SPADCALL
                                               (SPADCALL |us| (QREFELT $ 62))
                                               (QREFELT $ 63))))
                                            (LETT #5# (CDR #5#)) (GO G190) G191
                                            (EXIT NIL))
                                       (EXIT
                                        (|error|
                                         "rur$RURPACK: bad result with function rur$IRURPK"))))))))
                             (EXIT
                              (SEQ (LETT |us| NIL) (LETT #4# |lus|) G190
                                   (COND
                                    ((OR (ATOM #4#)
                                         (PROGN (LETT |us| (CAR #4#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (LETT |g|
                                          (SPADCALL
                                           (PROG2
                                               (LETT #3#
                                                     (SPADCALL |us|
                                                               (QREFELT $ 17)
                                                               (QREFELT $ 65)))
                                               (QCDR #3#)
                                             (|check_union2| (QEQCAR #3# 0)
                                                             (|NewSparseMultivariatePolynomial|
                                                              (QREFELT $ 6)
                                                              (|OrderedVariableList|
                                                               (QREFELT $ 13)))
                                                             (|Union|
                                                              (|NewSparseMultivariatePolynomial|
                                                               (QREFELT $ 6)
                                                               (|OrderedVariableList|
                                                                (QREFELT $
                                                                         13)))
                                                              "failed")
                                                             #3#))
                                           (QREFELT $ 67)))
                                    (LETT |lc|
                                          (PROGN
                                           (LETT #2# NIL)
                                           (SEQ
                                            (LETT #1#
                                                  (SPADCALL
                                                   (SPADCALL |us|
                                                             (QREFELT $ 17)
                                                             (QREFELT $ 68))
                                                   (QREFELT $ 69)))
                                            G190
                                            (COND
                                             ((OR (ATOM #1#)
                                                  (PROGN
                                                   (LETT |q| (CAR #1#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #2#
                                                    (CONS
                                                     (SPADCALL |q|
                                                               (QREFELT $ 70))
                                                     #2#))))
                                            (LETT #1# (CDR #1#)) (GO G190) G191
                                            (EXIT (NREVERSE #2#)))))
                                    (EXIT
                                     (LETT |toReturn|
                                           (CONS (CONS |g| |lc|) |toReturn|))))
                                   (LETT #4# (CDR #4#)) (GO G190) G191
                                   (EXIT NIL))))
                            (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                       (EXIT |toReturn|)))))))) 

(SDEFUN |RURPK;rur;LBL;2|
        ((|lp| (|List| (|Polynomial| R))) (|univ?| (|Boolean|))
         ($
          (|List|
           (|Record| (|:| |complexRoots| (|SparseUnivariatePolynomial| R))
                     (|:| |coordinates| (|List| (|Polynomial| R)))))))
        (SPADCALL |lp| |univ?| NIL (QREFELT $ 73))) 

(SDEFUN |RURPK;rur;LL;3|
        ((|lp| (|List| (|Polynomial| R)))
         ($
          (|List|
           (|Record| (|:| |complexRoots| (|SparseUnivariatePolynomial| R))
                     (|:| |coordinates| (|List| (|Polynomial| R)))))))
        (SPADCALL |lp| 'T (QREFELT $ 74))) 

(DECLAIM (NOTINLINE |RationalUnivariateRepresentationPackage;|)) 

(DEFUN |RationalUnivariateRepresentationPackage| (&REST #1=#:G799)
  (SPROG NIL
         (PROG (#2=#:G800)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|RationalUnivariateRepresentationPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |RationalUnivariateRepresentationPackage;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|RationalUnivariateRepresentationPackage|)))))))))) 

(DEFUN |RationalUnivariateRepresentationPackage;| (|#1| |#2|)
  (SPROG
   ((#1=#:G720 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT |dv$| (LIST '|RationalUnivariateRepresentationPackage| DV$1 DV$2))
    (LETT $ (GETREFV 76))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|RationalUnivariateRepresentationPackage|
                (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
    (QSETREFV $ 13 (SPADCALL |#2| (QREFELT $ 10) (QREFELT $ 12)))
    (QSETREFV $ 17
              (PROG2 (LETT #1# (SPADCALL (QREFELT $ 10) (QREFELT $ 16)))
                  (QCDR #1#)
                (|check_union2| (QEQCAR #1# 0)
                                (|OrderedVariableList| (QREFELT $ 13))
                                (|Union| (|OrderedVariableList| (QREFELT $ 13))
                                         "failed")
                                #1#)))
    (QSETREFV $ 20 (SPADCALL (QREFELT $ 17) (QREFELT $ 19)))
    $))) 

(MAKEPROP '|RationalUnivariateRepresentationPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Symbol|)
              (0 . |new|) '|news| (|List| 8) (4 . |concat|) '|lv|
              (|Union| $ '"failed")
              (|OrderedVariableList| (NRTEVAL (QREFELT $ 13)))
              (10 . |variable|) '|newv|
              (|NewSparseMultivariatePolynomial| 6 15) (15 . |coerce|) '|newq|
              (|Boolean|) (|Polynomial| 6) (20 . |zero?|) (|Mapping| 21 22)
              (|List| 22) (25 . |remove|) (31 . |ground?|) (36 . |any?|)
              (|List| 18)
              (|SquareFreeRegularTriangularSet| 6 (|IndexedExponents| 15) 15
                                                18)
              (42 . |construct|) (47 . |retractIfCan|) (52 . |infRittWu?|)
              (|Mapping| 21 18 18) (58 . |sort|) (64 . |mvar|) (69 . |mvar|)
              (74 . >) (80 . |rest|) (85 . |empty?|)
              (|PolynomialSetUtilitiesPackage| 6 (|IndexedExponents| 15) 15 18)
              (90 . |irreducibleFactors|) (95 . |internalAugment|)
              (|Record| (|:| |rnum| 6) (|:| |polnum| 18) (|:| |den| 6))
              (101 . |remainder|) (|Record| (|:| |val| 18) (|:| |tower| $))
              (|List| 46) (107 . |squareFreePart|) (113 . |init|)
              (118 . |ground?|)
              (|NormalizationPackage| 6 (|IndexedExponents| 15) 15 18 30)
              (123 . |normalizedAssociate|) (|List| 30)
              (|InternalRationalUnivariateRepresentationPackage| 6
                                                                 (|IndexedExponents|
                                                                  15)
                                                                 15 18 30)
              (129 . |rur|) (135 . |checkRur|) (|Void|) (|String|)
              (|OutputPackage|) (141 . |output|) (|OutputForm|)
              (146 . |coerce|) (151 . |output|) (|Union| 18 '"failed")
              (156 . |select|) (|SparseUnivariatePolynomial| 6)
              (162 . |univariate|) (167 . |collectUpper|) (173 . |parts|)
              (178 . |convert|)
              (|Record| (|:| |complexRoots| 66) (|:| |coordinates| 25))
              (|List| 71) |RURPK;rur;L2BL;1| |RURPK;rur;LBL;2|
              |RURPK;rur;LL;3|)
           '#(|rur| 183) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rur|
                                 ((|List|
                                   (|Record|
                                    (|:| |complexRoots|
                                         (|SparseUnivariatePolynomial| |#1|))
                                    (|:| |coordinates|
                                         (|List| (|Polynomial| |#1|)))))
                                  (|List| (|Polynomial| |#1|)) (|Boolean|)))
                                T)
                              '((|rur|
                                 ((|List|
                                   (|Record|
                                    (|:| |complexRoots|
                                         (|SparseUnivariatePolynomial| |#1|))
                                    (|:| |coordinates|
                                         (|List| (|Polynomial| |#1|)))))
                                  (|List| (|Polynomial| |#1|))))
                                T)
                              '((|rur|
                                 ((|List|
                                   (|Record|
                                    (|:| |complexRoots|
                                         (|SparseUnivariatePolynomial| |#1|))
                                    (|:| |coordinates|
                                         (|List| (|Polynomial| |#1|)))))
                                  (|List| (|Polynomial| |#1|)) (|Boolean|)
                                  (|Boolean|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 75
                                            '(0 8 0 9 2 11 0 0 8 12 1 15 14 8
                                              16 1 18 0 15 19 1 22 21 0 23 2 25
                                              0 24 0 26 1 22 21 0 27 2 25 21 24
                                              0 28 1 30 0 29 31 1 18 14 22 32 2
                                              18 21 0 0 33 2 29 0 34 0 35 1 18
                                              15 0 36 1 30 15 0 37 2 15 21 0 0
                                              38 1 30 14 0 39 1 30 21 0 40 1 41
                                              29 29 42 2 30 0 18 0 43 2 30 44
                                              18 0 45 2 30 47 18 0 48 1 18 0 0
                                              49 1 18 21 0 50 2 51 18 18 30 52
                                              2 54 53 30 21 55 2 54 21 30 53 56
                                              1 59 57 58 60 1 30 61 0 62 1 59
                                              57 61 63 2 30 64 0 15 65 1 18 66
                                              0 67 2 30 0 0 15 68 1 30 29 0 69
                                              1 18 22 0 70 2 0 72 25 21 74 3 0
                                              72 25 21 21 73 1 0 72 25 75)))))
           '|lookupComplete|)) 

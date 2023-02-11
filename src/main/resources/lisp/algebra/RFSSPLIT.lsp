
(SDEFUN |RFSSPLIT;alg_split_root0;FKIL;1|
        ((|f| (F)) (|r| (|Kernel| F)) (|n| (|Integer|)) ($ (|List| F)))
        (SPROG
         ((#1=#:G719 NIL) (|i| NIL) (#2=#:G718 NIL)
          (|q| (|SparseUnivariatePolynomial| F)) (|f1| (F)) (|f0| (F))
          (|ef| (F)))
         (SEQ
          (COND
           ((EQL |n| 2)
            (SEQ
             (LETT |ef|
                   (SPADCALL |f| |r|
                             (SPADCALL (SPADCALL |r| (QREFELT $ 9))
                                       (QREFELT $ 10))
                             (QREFELT $ 11)))
             (LETT |f0|
                   (SPADCALL (SPADCALL |f| |ef| (QREFELT $ 12))
                             (SPADCALL 2 (QREFELT $ 14)) (QREFELT $ 15)))
             (LETT |f1|
                   (SPADCALL (SPADCALL |f| |ef| (QREFELT $ 16))
                             (SPADCALL 2 (QREFELT $ 14)) (QREFELT $ 15)))
             (EXIT
              (COND
               ((SPADCALL |r| (SPADCALL |f0| (QREFELT $ 18)) (QREFELT $ 22))
                (SEQ (SPADCALL (SPADCALL |f0| (QREFELT $ 24)) (QREFELT $ 26))
                     (EXIT
                      (|error| "alg_split_root0: roots did not cancel 1"))))
               (#3='T
                (SEQ
                 (LETT |f1|
                       (SPADCALL |f1| (SPADCALL |r| (QREFELT $ 9))
                                 (QREFELT $ 15)))
                 (EXIT
                  (COND
                   ((SPADCALL |r| (SPADCALL |f1| (QREFELT $ 18))
                              (QREFELT $ 22))
                    (SEQ
                     (SPADCALL (SPADCALL |f1| (QREFELT $ 24)) (QREFELT $ 26))
                     (EXIT
                      (|error| "alg_split_root0: roots did not cancel 2"))))
                   (#3# (LIST |f0| |f1|))))))))))
           (#3#
            (SEQ
             (LETT |q|
                   (SPADCALL |f| |r| (SPADCALL |r| (QREFELT $ 28))
                             (QREFELT $ 31)))
             (EXIT
              (PROGN
               (LETT #2# NIL)
               (SEQ (LETT |i| 0) (LETT #1# (- |n| 1)) G190
                    (COND ((|greater_SI| |i| #1#) (GO G191)))
                    (SEQ
                     (EXIT
                      (LETT #2# (CONS (SPADCALL |q| |i| (QREFELT $ 35)) #2#))))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                    (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |RFSSPLIT;alg_split_root2|
        ((|lf| (|List| F)) (|r| (|Kernel| F)) (|n| (|Integer|))
         ($ (|List| (|List| F))))
        (SPROG
         ((|res| (|List| (|List| F))) (|resi| (|List| F))
          (|nlf1| #1=(|List| (|List| F))) (|lf1| (|List| F)) (#2=#:G733 NIL)
          (|pow1| NIL) (|nlf0| #1#) (#3=#:G732 NIL) (|f| NIL) (#4=#:G731 NIL))
         (SEQ
          (LETT |nlf0|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |f| NIL) (LETT #3# |lf|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |f| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS (SPADCALL |f| |r| |n| (QREFELT $ 37))
                                    #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |res| NIL)
          (SEQ (LETT |pow1| 0) (LETT #2# (- |n| 1)) G190
               (COND ((|greater_SI| |pow1| #2#) (GO G191)))
               (SEQ (LETT |nlf1| |nlf0|) (LETT |resi| NIL)
                    (SEQ G190 (COND ((NULL (NULL (NULL |nlf1|))) (GO G191)))
                         (SEQ (LETT |lf1| (|SPADfirst| |nlf1|))
                              (LETT |resi| (CONS (|SPADfirst| |lf1|) |resi|))
                              (SPADCALL |nlf1| (CDR |lf1|) (QREFELT $ 39))
                              (EXIT (LETT |nlf1| (CDR |nlf1|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (LETT |resi| (NREVERSE |resi|))
                    (EXIT (LETT |res| (CONS |resi| |res|))))
               (LETT |pow1| (|inc_SI| |pow1|)) (GO G190) G191 (EXIT NIL))
          (EXIT (NREVERSE |res|))))) 

(SDEFUN |RFSSPLIT;alg_split_roots;L2KL;3|
        ((|lf| (|List| F)) (|r1| (|Kernel| F)) (|r2| (|Kernel| F))
         ($
          (|List|
           (|Record| (|:| |funs| (|List| F)) (|:| |nroot| F)
                     (|:| |npow1| (|Integer|)) (|:| |npow2| (|Integer|))))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |funs| (|List| F)) (|:| |nroot| F)
                      (|:| |npow1| (|Integer|)) (|:| |npow2| (|Integer|)))))
          (|nl| (|List| F)) (#1=#:G768 NIL) (|f1| NIL) (#2=#:G767 NIL)
          (|nrr| (F)) (|bb2| (F)) (#3=#:G746 NIL) (|bb1| (F))
          (|nn| (|Integer|)) (|np2| (|Integer|)) (|nn2| (|Integer|))
          (|g2| #4=(|Integer|)) (#5=#:G765 NIL) (|l2| NIL) (#6=#:G766 NIL)
          (|pow2| NIL) (|np1| (|Integer|)) (|nn1| (|Integer|)) (|g1| #4#)
          (|ll2| #7=(|List| (|List| F))) (#8=#:G763 NIL) (|l1| NIL)
          (#9=#:G764 NIL) (|pow1| NIL) (|rop| (|BasicOperator|)) (|ll1| #7#)
          (|b2| (F)) (|n2| #10=(|Integer|)) (|b1| (F)) (|n1| #10#)
          (|a2| #11=(|List| F)) (|a1| #11#))
         (SEQ (LETT |a1| (SPADCALL |r1| (QREFELT $ 40)))
              (LETT |a2| (SPADCALL |r2| (QREFELT $ 40)))
              (LETT |n1|
                    (SPADCALL (SPADCALL |a1| 2 (QREFELT $ 41)) (QREFELT $ 42)))
              (LETT |b1| (SPADCALL |a1| 1 (QREFELT $ 41)))
              (LETT |n2|
                    (SPADCALL (SPADCALL |a2| 2 (QREFELT $ 41)) (QREFELT $ 42)))
              (LETT |b2| (SPADCALL |a2| 1 (QREFELT $ 41)))
              (LETT |ll1| (|RFSSPLIT;alg_split_root2| |lf| |r1| |n1| $))
              (LETT |res| NIL) (LETT |rop| (SPADCALL |r1| (QREFELT $ 44)))
              (SEQ (LETT |pow1| 0) (LETT #9# (- |n1| 1)) (LETT |l1| NIL)
                   (LETT #8# |ll1|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |l1| (CAR #8#)) NIL)
                         (|greater_SI| |pow1| #9#))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (CONS #'|RFSSPLIT;alg_split_roots;L2KL;3!0| $)
                                 |l1| (QREFELT $ 49))
                       "iterate")
                      ('T
                       (SEQ
                        (LETT |ll2|
                              (|RFSSPLIT;alg_split_root2| |l1| |r2| |n2| $))
                        (LETT |g1| (GCD |n1| |pow1|))
                        (LETT |nn1|
                              (PROG2
                                  (LETT #3#
                                        (SPADCALL |n1| |g1| (QREFELT $ 51)))
                                  (QCDR #3#)
                                (|check_union2| (QEQCAR #3# 0) (|Integer|)
                                                (|Union| (|Integer|)
                                                         #12="failed")
                                                #3#)))
                        (LETT |np1|
                              (PROG2
                                  (LETT #3#
                                        (SPADCALL |pow1| |g1| (QREFELT $ 51)))
                                  (QCDR #3#)
                                (|check_union2| (QEQCAR #3# 0) (|Integer|)
                                                (|Union| (|Integer|) #12#)
                                                #3#)))
                        (EXIT
                         (SEQ (LETT |pow2| 0) (LETT #6# (- |n2| 1))
                              (LETT |l2| NIL) (LETT #5# |ll2|) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |l2| (CAR #5#)) NIL)
                                    (|greater_SI| |pow2| #6#))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL
                                   (CONS #'|RFSSPLIT;alg_split_roots;L2KL;3!1|
                                         $)
                                   |l2| (QREFELT $ 49))
                                  "iterate")
                                 ('T
                                  (SEQ (LETT |g2| (GCD |n2| |pow2|))
                                       (LETT |nn2|
                                             (PROG2
                                                 (LETT #3#
                                                       (SPADCALL |n2| |g2|
                                                                 (QREFELT $
                                                                          51)))
                                                 (QCDR #3#)
                                               (|check_union2| (QEQCAR #3# 0)
                                                               (|Integer|)
                                                               (|Union|
                                                                (|Integer|)
                                                                #12#)
                                                               #3#)))
                                       (LETT |np2|
                                             (PROG2
                                                 (LETT #3#
                                                       (SPADCALL |pow2| |g2|
                                                                 (QREFELT $
                                                                          51)))
                                                 (QCDR #3#)
                                               (|check_union2| (QEQCAR #3# 0)
                                                               (|Integer|)
                                                               (|Union|
                                                                (|Integer|)
                                                                #12#)
                                                               #3#)))
                                       (LETT |nn|
                                             (SPADCALL |nn1| |nn2|
                                                       (QREFELT $ 52)))
                                       (LETT |bb1|
                                             (SPADCALL |b1|
                                                       (* |np1|
                                                          (PROG2
                                                              (LETT #3#
                                                                    (SPADCALL
                                                                     |nn| |nn1|
                                                                     (QREFELT $
                                                                              51)))
                                                              (QCDR #3#)
                                                            (|check_union2|
                                                             (QEQCAR #3# 0)
                                                             (|Integer|)
                                                             (|Union|
                                                              (|Integer|) #12#)
                                                             #3#)))
                                                       (QREFELT $ 53)))
                                       (LETT |bb2|
                                             (SPADCALL |b2|
                                                       (* |np2|
                                                          (PROG2
                                                              (LETT #3#
                                                                    (SPADCALL
                                                                     |nn| |nn2|
                                                                     (QREFELT $
                                                                              51)))
                                                              (QCDR #3#)
                                                            (|check_union2|
                                                             (QEQCAR #3# 0)
                                                             (|Integer|)
                                                             (|Union|
                                                              (|Integer|) #12#)
                                                             #3#)))
                                                       (QREFELT $ 53)))
                                       (LETT |nrr|
                                             (COND
                                              ((> (+ |pow1| |pow2|) 0)
                                               (SPADCALL |rop|
                                                         (LIST
                                                          (SPADCALL |bb1| |bb2|
                                                                    (QREFELT $
                                                                             54))
                                                          (SPADCALL |nn|
                                                                    (QREFELT $
                                                                             14)))
                                                         (QREFELT $ 56)))
                                              ('T (|spadConstant| $ 33))))
                                       (LETT |nl|
                                             (PROGN
                                              (LETT #2# NIL)
                                              (SEQ (LETT |f1| NIL)
                                                   (LETT #1# |l2|) G190
                                                   (COND
                                                    ((OR (ATOM #1#)
                                                         (PROGN
                                                          (LETT |f1| (CAR #1#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #2#
                                                           (CONS
                                                            (SPADCALL |f1|
                                                                      |nrr|
                                                                      (QREFELT
                                                                       $ 54))
                                                            #2#))))
                                                   (LETT #1# (CDR #1#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #2#)))))
                                       (EXIT
                                        (LETT |res|
                                              (CONS
                                               (VECTOR |nl| |nrr| |pow1|
                                                       |pow2|)
                                               |res|))))))))
                              (LETT #5#
                                    (PROG1 (CDR #5#)
                                      (LETT |pow2| (|inc_SI| |pow2|))))
                              (GO G190) G191 (EXIT NIL))))))))
                   (LETT #8# (PROG1 (CDR #8#) (LETT |pow1| (|inc_SI| |pow1|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |RFSSPLIT;alg_split_roots;L2KL;3!1| ((|f1| NIL) ($ NIL))
        (SPADCALL |f1| (|spadConstant| $ 46) (QREFELT $ 47))) 

(SDEFUN |RFSSPLIT;alg_split_roots;L2KL;3!0| ((|f1| NIL) ($ NIL))
        (SPADCALL |f1| (|spadConstant| $ 46) (QREFELT $ 47))) 

(DECLAIM (NOTINLINE |RootFSSplit;|)) 

(DEFUN |RootFSSplit| (&REST #1=#:G769)
  (SPROG NIL
         (PROG (#2=#:G770)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RootFSSplit|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RootFSSplit;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|RootFSSplit|)))))))))) 

(DEFUN |RootFSSplit;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|RootFSSplit| DV$1 DV$2))
          (LETT $ (GETREFV 60))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RootFSSplit| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RootFSSplit| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Kernel| $) (0 . |coerce|) (5 . -) (10 . |eval|) (17 . +)
              (|Integer|) (23 . |coerce|) (28 . /) (34 . -) (|List| 8)
              (40 . |kernels|) (|Boolean|) (|Kernel| 7) (|List| 20)
              (45 . |member?|) (|OutputForm|) (51 . |coerce|) (|Void|)
              (56 . |print|) (|SparseUnivariatePolynomial| $) (61 . |minPoly|)
              (|SparseUnivariatePolynomial| 7)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 20) 20
                                                     6
                                                     (|SparseMultivariatePolynomial|
                                                      6 20)
                                                     7)
              (66 . |univariate|) (73 . |One|) (77 . |One|)
              (|NonNegativeInteger|) (81 . |coefficient|) (|List| 7)
              |RFSSPLIT;alg_split_root0;FKIL;1| (|List| 36) (87 . |setfirst!|)
              (93 . |argument|) (98 . |elt|) (104 . |retract|)
              (|BasicOperator|) (109 . |operator|) (114 . |Zero|)
              (118 . |Zero|) (122 . =) (|Mapping| 19 7) (128 . |every?|)
              (|Union| $ '"failed") (134 . |exquo|) (140 . |lcm|) (146 . ^)
              (152 . *) (|List| $) (158 . |kernel|)
              (|Record| (|:| |funs| 36) (|:| |nroot| 7) (|:| |npow1| 13)
                        (|:| |npow2| 13))
              (|List| 57) |RFSSPLIT;alg_split_roots;L2KL;3|)
           '#(|alg_split_roots| 164 |alg_split_root0| 171) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|alg_split_roots|
                                 ((|List|
                                   (|Record| (|:| |funs| (|List| |#2|))
                                             (|:| |nroot| |#2|)
                                             (|:| |npow1| (|Integer|))
                                             (|:| |npow2| (|Integer|))))
                                  (|List| |#2|) (|Kernel| |#2|)
                                  (|Kernel| |#2|)))
                                T)
                              '((|alg_split_root0|
                                 ((|List| |#2|) |#2| (|Kernel| |#2|)
                                  (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 59
                                            '(1 7 0 8 9 1 7 0 0 10 3 7 0 0 8 0
                                              11 2 7 0 0 0 12 1 7 0 13 14 2 7 0
                                              0 0 15 2 7 0 0 0 16 1 7 17 0 18 2
                                              21 19 20 0 22 1 7 23 0 24 1 23 25
                                              0 26 1 7 27 8 28 3 30 29 7 20 29
                                              31 0 6 0 32 0 7 0 33 2 29 7 0 34
                                              35 2 38 36 0 36 39 1 20 36 0 40 2
                                              36 7 0 13 41 1 7 13 0 42 1 20 43
                                              0 44 0 6 0 45 0 7 0 46 2 7 19 0 0
                                              47 2 36 19 48 0 49 2 13 50 0 0 51
                                              2 13 0 0 0 52 2 7 0 0 13 53 2 7 0
                                              0 0 54 2 7 0 43 55 56 3 0 58 36
                                              20 20 59 3 0 36 7 20 13 37)))))
           '|lookupComplete|)) 

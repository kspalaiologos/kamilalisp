
(SDEFUN |RDEAUX;multi_SPDE;2SupLIMU;1|
        ((|a| (|SparseUnivariatePolynomial| F))
         (|b| (|SparseUnivariatePolynomial| F))
         (|lc| (|List| (|SparseUnivariatePolynomial| F))) (|d| (|Integer|))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|Union|
           (|List|
            (|Record| (|:| |ans| (|SparseUnivariatePolynomial| F))
                      (|:| |remainder| (|SparseUnivariatePolynomial| F))))
           (|Record| (|:| |ans| (|List| (|SparseUnivariatePolynomial| F)))
                     (|:| |acoeff| (|SparseUnivariatePolynomial| F))
                     (|:| |eegen| (|SparseUnivariatePolynomial| F))
                     (|:| |bpar| (|SparseUnivariatePolynomial| F))
                     (|:| |lcpar| (|List| (|SparseUnivariatePolynomial| F)))
                     (|:| |dpar| (|Integer|))))))
        (SPROG
         ((#1=#:G744 NIL) (|s1| NIL) (#2=#:G745 NIL) (#3=#:G743 NIL)
          (#4=#:G741 NIL) (|s2| NIL) (#5=#:G742 NIL) (#6=#:G740 NIL)
          (|dres|
           (|Record| (|:| |ans| (|List| (|SparseUnivariatePolynomial| F)))
                     (|:| |acoeff| (|SparseUnivariatePolynomial| F))
                     (|:| |eegen| (|SparseUnivariatePolynomial| F))
                     (|:| |bpar| (|SparseUnivariatePolynomial| F))
                     (|:| |lcpar| (|List| (|SparseUnivariatePolynomial| F)))
                     (|:| |dpar| (|Integer|))))
          (|res1|
           (|Union|
            (|List|
             (|Record| (|:| |ans| (|SparseUnivariatePolynomial| F))
                       (|:| |remainder| (|SparseUnivariatePolynomial| F))))
            (|Record| (|:| |ans| (|List| (|SparseUnivariatePolynomial| F)))
                      (|:| |acoeff| (|SparseUnivariatePolynomial| F))
                      (|:| |eegen| (|SparseUnivariatePolynomial| F))
                      (|:| |bpar| (|SparseUnivariatePolynomial| F))
                      (|:| |lcpar| (|List| (|SparseUnivariatePolynomial| F)))
                      (|:| |dpar| (|Integer|)))))
          (|lr| (|List| (|SparseUnivariatePolynomial| F)))
          (|lnc| (|List| (|SparseUnivariatePolynomial| F)))
          (|nc| (|SparseUnivariatePolynomial| F))
          (|r| #7=(|SparseUnivariatePolynomial| F))
          (|qr|
           (|Record| (|:| |quotient| (|SparseUnivariatePolynomial| F))
                     (|:| |remainder| #7#)))
          (|cc2| #8=(|SparseUnivariatePolynomial| F)) (|cc1| #8#)
          (#9=#:G739 NIL) (|c| NIL) (#10=#:G738 NIL) (#11=#:G737 NIL)
          (|ee|
           (|Record| (|:| |coef1| (|SparseUnivariatePolynomial| F))
                     (|:| |coef2| (|SparseUnivariatePolynomial| F))
                     (|:| |generator| (|SparseUnivariatePolynomial| F))))
          (#12=#:G736 NIL) (#13=#:G735 NIL) (#14=#:G734 NIL) (#15=#:G733 NIL))
         (SEQ
          (COND
           ((< |d| 0)
            (CONS 0
                  (PROGN
                   (LETT #15# NIL)
                   (SEQ (LETT |c| NIL) (LETT #14# |lc|) G190
                        (COND
                         ((OR (ATOM #14#) (PROGN (LETT |c| (CAR #14#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #15#
                                (CONS (CONS (|spadConstant| $ 9) |c|) #15#))))
                        (LETT #14# (CDR #14#)) (GO G190) G191
                        (EXIT (NREVERSE #15#))))))
           ((SPADCALL (ELT $ 11) |lc| (QREFELT $ 14))
            (CONS 0
                  (PROGN
                   (LETT #13# NIL)
                   (SEQ (LETT |c| NIL) (LETT #12# |lc|) G190
                        (COND
                         ((OR (ATOM #12#) (PROGN (LETT |c| (CAR #12#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #13#
                                (CONS
                                 (CONS (|spadConstant| $ 9)
                                       (|spadConstant| $ 9))
                                 #13#))))
                        (LETT #12# (CDR #12#)) (GO G190) G191
                        (EXIT (NREVERSE #13#))))))
           (#16='T
            (SEQ (LETT |ee| (SPADCALL |a| |b| (QREFELT $ 16)))
                 (EXIT
                  (COND
                   ((SPADCALL (QVELT |ee| 2) (|spadConstant| $ 17)
                              (QREFELT $ 18))
                    (CONS 1
                          (VECTOR
                           (PROGN
                            (LETT #11# NIL)
                            (SEQ (LETT |c| NIL) (LETT #10# |lc|) G190
                                 (COND
                                  ((OR (ATOM #10#)
                                       (PROGN (LETT |c| (CAR #10#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #11#
                                         (CONS (|spadConstant| $ 9) #11#))))
                                 (LETT #10# (CDR #10#)) (GO G190) G191
                                 (EXIT (NREVERSE #11#))))
                           (|spadConstant| $ 17) (QVELT |ee| 2) |b| |lc| |d|)))
                   (#16#
                    (SEQ (LETT |lr| NIL) (LETT |lnc| NIL)
                         (SEQ (LETT |c| NIL) (LETT #9# |lc|) G190
                              (COND
                               ((OR (ATOM #9#)
                                    (PROGN (LETT |c| (CAR #9#)) NIL))
                                (GO G191)))
                              (SEQ
                               (LETT |cc1|
                                     (SPADCALL (QVELT |ee| 0) |c|
                                               (QREFELT $ 19)))
                               (LETT |cc2|
                                     (SPADCALL (QVELT |ee| 1) |c|
                                               (QREFELT $ 19)))
                               (LETT |qr| (SPADCALL |cc2| |a| (QREFELT $ 21)))
                               (LETT |r| (QCDR |qr|))
                               (LETT |nc|
                                     (SPADCALL
                                      (SPADCALL |cc1|
                                                (SPADCALL |b| (QCAR |qr|)
                                                          (QREFELT $ 19))
                                                (QREFELT $ 22))
                                      (SPADCALL |r| |der|) (QREFELT $ 23)))
                               (LETT |lnc| (CONS |nc| |lnc|))
                               (EXIT (LETT |lr| (CONS |r| |lr|))))
                              (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                         (LETT |lr| (NREVERSE |lr|))
                         (LETT |res1|
                               (SPADCALL |a|
                                         (SPADCALL |b| (SPADCALL |a| |der|)
                                                   (QREFELT $ 22))
                                         (NREVERSE |lnc|)
                                         (- |d| (SPADCALL |a| (QREFELT $ 25)))
                                         |der| (QREFELT $ 31)))
                         (EXIT
                          (COND
                           ((QEQCAR |res1| 1)
                            (SEQ (LETT |dres| (QCDR |res1|))
                                 (EXIT
                                  (CONS 1
                                        (VECTOR
                                         (PROGN
                                          (LETT #6# NIL)
                                          (SEQ (LETT #5# |lr|) (LETT |s2| NIL)
                                               (LETT #4# (QVELT |dres| 0)) G190
                                               (COND
                                                ((OR (ATOM #4#)
                                                     (PROGN
                                                      (LETT |s2| (CAR #4#))
                                                      NIL)
                                                     (ATOM #5#)
                                                     (PROGN
                                                      (LETT |r| (CAR #5#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #6#
                                                       (CONS
                                                        (SPADCALL
                                                         (SPADCALL |a| |s2|
                                                                   (QREFELT $
                                                                            19))
                                                         |r| (QREFELT $ 22))
                                                        #6#))))
                                               (LETT #4#
                                                     (PROG1 (CDR #4#)
                                                       (LETT #5# (CDR #5#))))
                                               (GO G190) G191
                                               (EXIT (NREVERSE #6#))))
                                         (SPADCALL |a| (QVELT |dres| 1)
                                                   (QREFELT $ 19))
                                         (QVELT |dres| 2) (QVELT |dres| 3)
                                         (QVELT |dres| 4) (QVELT |dres| 5))))))
                           (#16#
                            (CONS 0
                                  (PROGN
                                   (LETT #3# NIL)
                                   (SEQ (LETT #2# |lr|) (LETT |s1| NIL)
                                        (LETT #1# (QCDR |res1|)) G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN (LETT |s1| (CAR #1#)) NIL)
                                              (ATOM #2#)
                                              (PROGN (LETT |r| (CAR #2#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #3#
                                                (CONS
                                                 (CONS
                                                  (SPADCALL
                                                   (SPADCALL |a| (QCAR |s1|)
                                                             (QREFELT $ 19))
                                                   |r| (QREFELT $ 22))
                                                  (QCDR |s1|))
                                                 #3#))))
                                        (LETT #1#
                                              (PROG1 (CDR #1#)
                                                (LETT #2# (CDR #2#))))
                                        (GO G190) G191
                                        (EXIT (NREVERSE #3#)))))))))))))))))) 

(SDEFUN |RDEAUX;SPDE1;2SupMR;2|
        ((|b| (|SparseUnivariatePolynomial| F))
         (|c| (|SparseUnivariatePolynomial| F))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|Record| (|:| |ans| (|SparseUnivariatePolynomial| F))
                    (|:| |remainder| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((|q| (|SparseUnivariatePolynomial| F))
          (|qq| (|SparseUnivariatePolynomial| F)) (#1=#:G748 NIL)
          (#2=#:G754 NIL) (|n| (|Integer|)) (|lb| (F)) (|db| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ (LETT |q| (|spadConstant| $ 9))
                (LETT |db| (SPADCALL |b| (QREFELT $ 25)))
                (LETT |lb| (SPADCALL |b| (QREFELT $ 32)))
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL |c| (|spadConstant| $ 9) (QREFELT $ 18)))
                       (GO G191)))
                     (SEQ (LETT |n| (- (SPADCALL |c| (QREFELT $ 25)) |db|))
                          (EXIT
                           (COND
                            ((< |n| 0)
                             (PROGN (LETT #2# (CONS |q| |c|)) (GO #3=#:G753)))
                            ('T
                             (SEQ
                              (LETT |qq|
                                    (SPADCALL
                                     (SPADCALL (SPADCALL |c| (QREFELT $ 32))
                                               |lb| (QREFELT $ 33))
                                     (PROG1 (LETT #1# |n|)
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#))
                                     (QREFELT $ 34)))
                              (LETT |c|
                                    (SPADCALL
                                     (SPADCALL |c|
                                               (SPADCALL |b| |qq|
                                                         (QREFELT $ 19))
                                               (QREFELT $ 23))
                                     (SPADCALL |qq| |der|) (QREFELT $ 23)))
                              (EXIT
                               (LETT |q|
                                     (SPADCALL |q| |qq| (QREFELT $ 22)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS |q| (|spadConstant| $ 9)))))
          #3# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |RDEaux;|)) 

(DEFUN |RDEaux| (#1=#:G755)
  (SPROG NIL
         (PROG (#2=#:G756)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RDEaux|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RDEaux;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|RDEaux|)))))))))) 

(DEFUN |RDEaux;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RDEaux| DV$1))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RDEaux| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RDEaux| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|)
              (|SparseUnivariatePolynomial| 6) (4 . |Zero|) (|Boolean|)
              (8 . |zero?|) (|Mapping| 10 8) (|List| 8) (13 . |every?|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (19 . |extendedEuclidean|) (25 . |One|) (29 . ~=) (35 . *)
              (|Record| (|:| |quotient| $) (|:| |remainder| $)) (41 . |divide|)
              (47 . +) (53 . -) (|NonNegativeInteger|) (59 . |degree|)
              (|Record| (|:| |ans| 8) (|:| |remainder| 8))
              (|Record| (|:| |ans| 13) (|:| |acoeff| 8) (|:| |eegen| 8)
                        (|:| |bpar| 8) (|:| |lcpar| 13) (|:| |dpar| 29))
              (|Union| (|List| 26) 27) (|Integer|) (|Mapping| 8 8)
              |RDEAUX;multi_SPDE;2SupLIMU;1| (64 . |leadingCoefficient|)
              (69 . /) (75 . |monomial|) |RDEAUX;SPDE1;2SupMR;2|)
           '#(|multi_SPDE| 81 SPDE1 90) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|multi_SPDE|
                                 ((|Union|
                                   (|List|
                                    (|Record|
                                     (|:| |ans|
                                          (|SparseUnivariatePolynomial| |#1|))
                                     (|:| |remainder|
                                          (|SparseUnivariatePolynomial|
                                           |#1|))))
                                   (|Record|
                                    (|:| |ans|
                                         (|List|
                                          (|SparseUnivariatePolynomial| |#1|)))
                                    (|:| |acoeff|
                                         (|SparseUnivariatePolynomial| |#1|))
                                    (|:| |eegen|
                                         (|SparseUnivariatePolynomial| |#1|))
                                    (|:| |bpar|
                                         (|SparseUnivariatePolynomial| |#1|))
                                    (|:| |lcpar|
                                         (|List|
                                          (|SparseUnivariatePolynomial| |#1|)))
                                    (|:| |dpar| (|Integer|))))
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|List| (|SparseUnivariatePolynomial| |#1|))
                                  (|Integer|)
                                  (|Mapping|
                                   (|SparseUnivariatePolynomial| |#1|)
                                   (|SparseUnivariatePolynomial| |#1|))))
                                T)
                              '((SPDE1
                                 ((|Record|
                                   (|:| |ans|
                                        (|SparseUnivariatePolynomial| |#1|))
                                   (|:| |remainder|
                                        (|SparseUnivariatePolynomial| |#1|)))
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|Mapping|
                                   (|SparseUnivariatePolynomial| |#1|)
                                   (|SparseUnivariatePolynomial| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 35
                                            '(0 6 0 7 0 8 0 9 1 8 10 0 11 2 13
                                              10 12 0 14 2 8 15 0 0 16 0 8 0 17
                                              2 8 10 0 0 18 2 8 0 0 0 19 2 8 20
                                              0 0 21 2 8 0 0 0 22 2 8 0 0 0 23
                                              1 8 24 0 25 1 8 6 0 32 2 6 0 0 0
                                              33 2 8 0 6 24 34 5 0 28 8 8 13 29
                                              30 31 3 0 26 8 8 30 35)))))
           '|lookupComplete|)) 


(SDEFUN |PRIMELT;multi|
        ((|p| (|SparseUnivariatePolynomial| F)) (|v| (|Symbol|))
         ($ (|Polynomial| F)))
        (SPADCALL (SPADCALL (LIST #'|PRIMELT;multi!0|) |p| (QREFELT $ 9)) |v|
                  (QREFELT $ 12))) 

(SDEFUN |PRIMELT;multi!0| ((|f1| NIL) ($$ NIL)) |f1|) 

(SDEFUN |PRIMELT;randomInts|
        ((|n| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
         ($ (|List| (|Integer|))))
        (SPROG ((#1=#:G720 NIL) (|i| NIL) (#2=#:G719 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL (RANDOM |m|) |m| (QREFELT $ 14))
                                    #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |PRIMELT;incl?|
        ((|a| (|List| (|Symbol|))) (|b| (|List| (|Symbol|))) ($ (|Boolean|)))
        (SPROG NIL
               (SPADCALL (CONS #'|PRIMELT;incl?!0| (VECTOR $ |b|)) |a|
                         (QREFELT $ 19)))) 

(SDEFUN |PRIMELT;incl?!0| ((|s1| NIL) ($$ NIL))
        (PROG (|b| $)
          (LETT |b| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s1| |b| (QREFELT $ 17)))))) 

(SDEFUN |PRIMELT;primitiveElement;LLR;4|
        ((|l| (|List| (|Polynomial| F))) (|v| (|List| (|Symbol|)))
         ($
          (|Record| (|:| |coef| (|List| (|Integer|)))
                    (|:| |poly| (|List| (|SparseUnivariatePolynomial| F)))
                    (|:| |prim| (|SparseUnivariatePolynomial| F)))))
        (SPADCALL |l| |v| (SPADCALL (QREFELT $ 20)) (QREFELT $ 23))) 

(SDEFUN |PRIMELT;primitiveElement;PSPSR;5|
        ((|p1| (|Polynomial| F)) (|a1| (|Symbol|)) (|p2| (|Polynomial| F))
         (|a2| (|Symbol|))
         ($
          (|Record| (|:| |coef1| (|Integer|)) (|:| |coef2| (|Integer|))
                    (|:| |prim| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((#1=#:G739 NIL) (#2=#:G740 NIL)
          (|r| (|SparseUnivariatePolynomial| F)) (|w| (|Polynomial| F))
          (|c| (|Integer|)) (|i| NIL) (|b| (|Polynomial| F))
          (|u| (|Polynomial| F)))
         (SEQ
          (EXIT
           (COND
            ((EQL (SPADCALL |p2| |a1| (QREFELT $ 26)) 1)
             (VECTOR 0 1
                     (SPADCALL (SPADCALL |p1| |p2| |a1| (QREFELT $ 30))
                               (QREFELT $ 31))))
            ('T
             (SEQ
              (LETT |u| (SPADCALL (SPADCALL (QREFELT $ 20)) (QREFELT $ 32)))
              (LETT |b| (SPADCALL |a2| (QREFELT $ 32)))
              (EXIT
               (SEQ (LETT |i| 10) G190 NIL
                    (SEQ
                     (EXIT
                      (SEQ
                       (LETT |c| (SPADCALL (RANDOM |i|) |i| (QREFELT $ 14)))
                       (LETT |w|
                             (SPADCALL |u| (SPADCALL |c| |b| (QREFELT $ 33))
                                       (QREFELT $ 34)))
                       (LETT |r|
                             (SPADCALL
                              (SPADCALL (SPADCALL |p1| |a1| |w| (QREFELT $ 35))
                                        (SPADCALL |p2| |a1| |w| (QREFELT $ 35))
                                        |a2| (QREFELT $ 30))
                              (QREFELT $ 31)))
                       (EXIT
                        (COND
                         ((NULL (SPADCALL |r| (QREFELT $ 36)))
                          (COND
                           ((SPADCALL |r| (SPADCALL |r| (QREFELT $ 37))
                                      (QREFELT $ 38))
                            (PROGN
                             (LETT #1#
                                   (PROGN
                                    (LETT #2# (VECTOR 1 |c| |r|))
                                    (GO #3=#:G738)))
                             (GO #4=#:G733)))))))))
                     #4# (EXIT #1#))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))))
          #3# (EXIT #2#)))) 

(SDEFUN |PRIMELT;findUniv|
        ((|l| (|List| (|Polynomial| F))) (|v| (|Symbol|)) (|opt| (|Symbol|))
         ($ (|Union| (|Polynomial| F) "failed")))
        (SPROG ((#1=#:G750 NIL) (#2=#:G751 NIL) (#3=#:G752 NIL) (|p| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |p| NIL) (LETT #3# |l|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((> (SPADCALL |p| |v| (QREFELT $ 26)) 0)
                             (COND
                              ((|PRIMELT;incl?| (SPADCALL |p| (QREFELT $ 42))
                                (LIST |v| |opt|) $)
                               (PROGN
                                (LETT #1#
                                      (PROGN
                                       (LETT #2# (CONS 0 |p|))
                                       (GO #4=#:G749)))
                                (GO #5=#:G747))))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (CONS 1 "failed"))))
                #4# (EXIT #2#)))) 

(SDEFUN |PRIMELT;triangularLinearIfCan|
        ((|l| (|List| (|Polynomial| F))) (|lv| (|List| (|Symbol|)))
         (|w| (|Symbol|))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| F)) "failed")))
        (SPROG
         ((|ll| (|List| (|SparseUnivariatePolynomial| F)))
          (|bc|
           (|Union|
            (|Record| (|:| |coef1| (|SparseUnivariatePolynomial| F))
                      (|:| |coef2| (|SparseUnivariatePolynomial| F)))
            "failed"))
          (#1=#:G788 NIL) (#2=#:G789 NIL)
          (|p| (|SparseUnivariatePolynomial| (|Polynomial| F)))
          (|u| (|Union| (|Polynomial| F) "failed")) (#3=#:G790 NIL) (|v| NIL)
          (|pw| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (EXIT
           (SEQ (LETT |u| (|PRIMELT;findUniv| |l| |w| |w| $))
                (EXIT
                 (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                       ('T
                        (SEQ (LETT |pw| (SPADCALL (QCDR |u|) (QREFELT $ 31)))
                             (LETT |ll| NIL)
                             (SEQ (LETT |v| NIL) (LETT #3# |lv|) G190
                                  (COND
                                   ((OR (ATOM #3#)
                                        (PROGN (LETT |v| (CAR #3#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (SEQ
                                     (SEQ
                                      (LETT |u|
                                            (|PRIMELT;findUniv| |l| |v| |w| $))
                                      (EXIT
                                       (COND
                                        ((OR (QEQCAR |u| 1)
                                             (SPADCALL
                                              (SPADCALL
                                               (LETT |p|
                                                     (SPADCALL (QCDR |u|) |v|
                                                               (QREFELT $ 44)))
                                               (QREFELT $ 46))
                                              1 (QREFELT $ 47)))
                                         (PROGN
                                          (LETT #1#
                                                (PROGN
                                                 (LETT #2# (CONS 1 "failed"))
                                                 (GO #4=#:G787)))
                                          (GO #5=#:G777))))))
                                     (LETT |bc|
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |p| (QREFELT $ 48))
                                             (QREFELT $ 31))
                                            |pw| (|spadConstant| $ 49)
                                            (QREFELT $ 52)))
                                     (EXIT
                                      (COND
                                       ((QEQCAR |bc| 1)
                                        (|error| "Should not happen"))
                                       ('T
                                        (LETT |ll|
                                              (CONS
                                               (SPADCALL
                                                (LIST
                                                 #'|PRIMELT;triangularLinearIfCan!0|)
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL |p| 0
                                                              (QREFELT $ 54))
                                                    (QREFELT $ 31))
                                                   (QCAR (QCDR |bc|))
                                                   (QREFELT $ 55))
                                                  (QREFELT $ 56))
                                                 |pw| (QREFELT $ 57))
                                                (QREFELT $ 9))
                                               |ll|)))))))
                                   #5# (EXIT #1#))
                                  (LETT #3# (CDR #3#)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT
                              (CONS 0
                                    (CONS
                                     (SPADCALL
                                      (LIST
                                       #'|PRIMELT;triangularLinearIfCan!1|)
                                      |pw| (QREFELT $ 9))
                                     (NREVERSE |ll|))))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |PRIMELT;triangularLinearIfCan!1| ((|f1| NIL) ($$ NIL)) |f1|) 

(SDEFUN |PRIMELT;triangularLinearIfCan!0| ((|z1| NIL) ($$ NIL)) |z1|) 

(SDEFUN |PRIMELT;primitiveElement;LLSR;8|
        ((|l| (|List| (|Polynomial| F))) (|vars| (|List| (|Symbol|)))
         (|uu| (|Symbol|))
         ($
          (|Record| (|:| |coef| (|List| (|Integer|)))
                    (|:| |poly| (|List| (|SparseUnivariatePolynomial| F)))
                    (|:| |prim| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((#1=#:G817 NIL) (#2=#:G818 NIL)
          (|ltt| (|List| (|SparseUnivariatePolynomial| F)))
          (|tt| (|Union| (|List| (|SparseUnivariatePolynomial| F)) "failed"))
          (#3=#:G807 NIL) (#4=#:G806 #5=(|Polynomial| F)) (#6=#:G808 #5#)
          (#7=#:G821 NIL) (|c| NIL) (#8=#:G822 NIL) (|t| NIL)
          (|cf| (|List| (|Integer|))) (|i| NIL) (|n| (|NonNegativeInteger|))
          (|w| (|Polynomial| F)) (|elim| (|List| (|Symbol|)))
          (|vv| (|List| (|Polynomial| F))) (#9=#:G820 NIL) (|v| NIL)
          (#10=#:G819 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |vv|
                  (PROGN
                   (LETT #10# NIL)
                   (SEQ (LETT |v| NIL) (LETT #9# |vars|) G190
                        (COND
                         ((OR (ATOM #9#) (PROGN (LETT |v| (CAR #9#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #10#
                                (CONS (SPADCALL |v| (QREFELT $ 32)) #10#))))
                        (LETT #9# (CDR #9#)) (GO G190) G191
                        (EXIT (NREVERSE #10#)))))
            (LETT |elim| (SPADCALL |vars| |uu| (QREFELT $ 58)))
            (LETT |w| (SPADCALL |uu| (QREFELT $ 32))) (LETT |n| (LENGTH |l|))
            (EXIT
             (SEQ (LETT |i| 10) G190 NIL
                  (SEQ
                   (EXIT
                    (SEQ (LETT |cf| (|PRIMELT;randomInts| |n| |i| $))
                         (LETT |tt|
                               (|PRIMELT;triangularLinearIfCan|
                                (SPADCALL
                                 (CONS
                                  (SPADCALL |w|
                                            (PROGN
                                             (LETT #3# NIL)
                                             (SEQ (LETT |t| NIL)
                                                  (LETT #8# |vv|)
                                                  (LETT |c| NIL)
                                                  (LETT #7# |cf|) G190
                                                  (COND
                                                   ((OR (ATOM #7#)
                                                        (PROGN
                                                         (LETT |c| (CAR #7#))
                                                         NIL)
                                                        (ATOM #8#)
                                                        (PROGN
                                                         (LETT |t| (CAR #8#))
                                                         NIL))
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (PROGN
                                                     (LETT #6#
                                                           (SPADCALL |c| |t|
                                                                     (QREFELT $
                                                                              33)))
                                                     (COND
                                                      (#3#
                                                       (LETT #4#
                                                             (SPADCALL #4# #6#
                                                                       (QREFELT
                                                                        $
                                                                        59))))
                                                      ('T
                                                       (PROGN
                                                        (LETT #4# #6#)
                                                        (LETT #3# 'T)))))))
                                                  (LETT #7#
                                                        (PROG1 (CDR #7#)
                                                          (LETT #8#
                                                                (CDR #8#))))
                                                  (GO G190) G191 (EXIT NIL))
                                             (COND (#3# #4#)
                                                   ('T (|spadConstant| $ 29))))
                                            (QREFELT $ 34))
                                  |l|)
                                 |elim| (QREFELT $ 61))
                                |vars| |uu| $))
                         (EXIT
                          (COND
                           ((QEQCAR |tt| 0)
                            (PROGN
                             (LETT #1#
                                   (SEQ (LETT |ltt| (QCDR |tt|))
                                        (EXIT
                                         (PROGN
                                          (LETT #2#
                                                (VECTOR |cf| (CDR |ltt|)
                                                        (|SPADfirst| |ltt|)))
                                          (GO #11=#:G816)))))
                             (GO #12=#:G813)))))))
                   #12# (EXIT #1#))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))
          #11# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |PrimitiveElement;|)) 

(DEFUN |PrimitiveElement| (#1=#:G823)
  (SPROG NIL
         (PROG (#2=#:G824)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PrimitiveElement|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|PrimitiveElement;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PrimitiveElement|)))))))))) 

(DEFUN |PrimitiveElement;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PrimitiveElement| DV$1))
          (LETT $ (GETREFV 62))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PrimitiveElement| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PrimitiveElement| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Mapping| 6 6)
              (|SparseUnivariatePolynomial| 6) (0 . |map|) (|Symbol|)
              (|Polynomial| 6) (6 . |multivariate|) (|Integer|)
              (12 . |symmetricRemainder|) (|Boolean|) (|List| 10)
              (18 . |member?|) (|Mapping| 15 10) (24 . |every?|) (30 . |new|)
              (|Record| (|:| |coef| (|List| 13)) (|:| |poly| (|List| 8))
                        (|:| |prim| 8))
              (|List| 11) |PRIMELT;primitiveElement;LLSR;8|
              |PRIMELT;primitiveElement;LLR;4| (|NonNegativeInteger|)
              (34 . |degree|) (40 . |One|) (44 . |Zero|) (48 . |Zero|)
              (52 . |resultant|) (59 . |univariate|) (64 . |coerce|) (69 . *)
              (75 . -) (81 . |eval|) (88 . |zero?|) (93 . |squareFreePart|)
              (98 . =) (104 . |One|)
              (|Record| (|:| |coef1| 13) (|:| |coef2| 13) (|:| |prim| 8))
              |PRIMELT;primitiveElement;PSPSR;5| (108 . |variables|)
              (|SparseUnivariatePolynomial| $) (113 . |univariate|)
              (|SparseUnivariatePolynomial| 11) (119 . |degree|) (124 . ~=)
              (130 . |leadingCoefficient|) (135 . |One|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 50 '"failed")
              (139 . |extendedEuclidean|) (146 . |Zero|) (150 . |coefficient|)
              (156 . *) (162 . -) (167 . |rem|) (173 . |concat|) (179 . +)
              (|PolyGroebner| 6) (185 . |lexGroebner|))
           '#(|primitiveElement| 191) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|primitiveElement|
                                 ((|Record| (|:| |coef1| (|Integer|))
                                            (|:| |coef2| (|Integer|))
                                            (|:| |prim|
                                                 (|SparseUnivariatePolynomial|
                                                  |#1|)))
                                  (|Polynomial| |#1|) (|Symbol|)
                                  (|Polynomial| |#1|) (|Symbol|)))
                                T)
                              '((|primitiveElement|
                                 ((|Record| (|:| |coef| (|List| (|Integer|)))
                                            (|:| |poly|
                                                 (|List|
                                                  (|SparseUnivariatePolynomial|
                                                   |#1|)))
                                            (|:| |prim|
                                                 (|SparseUnivariatePolynomial|
                                                  |#1|)))
                                  (|List| (|Polynomial| |#1|))
                                  (|List| (|Symbol|))))
                                T)
                              '((|primitiveElement|
                                 ((|Record| (|:| |coef| (|List| (|Integer|)))
                                            (|:| |poly|
                                                 (|List|
                                                  (|SparseUnivariatePolynomial|
                                                   |#1|)))
                                            (|:| |prim|
                                                 (|SparseUnivariatePolynomial|
                                                  |#1|)))
                                  (|List| (|Polynomial| |#1|))
                                  (|List| (|Symbol|)) (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 61
                                            '(2 8 0 7 0 9 2 11 0 8 10 12 2 13 0
                                              0 0 14 2 16 15 10 0 17 2 16 15 18
                                              0 19 0 10 0 20 2 11 25 0 10 26 0
                                              6 0 27 0 6 0 28 0 11 0 29 3 11 0
                                              0 0 10 30 1 11 8 0 31 1 11 0 10
                                              32 2 11 0 13 0 33 2 11 0 0 0 34 3
                                              11 0 0 10 0 35 1 8 15 0 36 1 8 0
                                              0 37 2 8 15 0 0 38 0 11 0 39 1 11
                                              16 0 42 2 11 43 0 10 44 1 45 25 0
                                              46 2 25 15 0 0 47 1 45 11 0 48 0
                                              8 0 49 3 8 51 0 0 0 52 0 8 0 53 2
                                              45 11 0 25 54 2 8 0 0 0 55 1 8 0
                                              0 56 2 8 0 0 0 57 2 16 0 0 10 58
                                              2 11 0 0 0 59 2 60 22 22 16 61 4
                                              0 40 11 10 11 10 41 3 0 21 22 16
                                              10 23 2 0 21 22 16 24)))))
           '|lookupComplete|)) 

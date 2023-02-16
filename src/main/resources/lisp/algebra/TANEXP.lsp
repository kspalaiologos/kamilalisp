
(SDEFUN |TANEXP;m1toN| ((|n| (|Integer|)) ($ (|Integer|)))
        (COND ((ODDP |n|) -1) ('T 1))) 

(SDEFUN |TANEXP;tanAn;RPiSup;2|
        ((|a| (R)) (|n| (|PositiveInteger|))
         ($ (|SparseUnivariatePolynomial| R)))
        (SPROG ((|q| (|Fraction| (|SparseUnivariatePolynomial| R))))
               (SPADCALL
                (SPADCALL |a|
                          (SPADCALL (LETT |q| (|TANEXP;tanPIa| |n| $))
                                    (QREFELT $ 10))
                          (QREFELT $ 11))
                (SPADCALL |q| (QREFELT $ 12)) (QREFELT $ 13)))) 

(SDEFUN |TANEXP;tanNa;RIR;3| ((|a| (R)) (|n| (|Integer|)) ($ (R)))
        (SPROG
         ((|t| (|Fraction| (|SparseUnivariatePolynomial| R))) (#1=#:G709 NIL))
         (COND ((ZEROP |n|) (|spadConstant| $ 16))
               ((MINUSP |n|)
                (SPADCALL (SPADCALL |a| (- |n|) (QREFELT $ 18))
                          (QREFELT $ 19)))
               ('T
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (LETT |t|
                         (|TANEXP;tanPIa|
                          (PROG1 (LETT #1# |n|)
                            (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                              '(|Integer|) #1#))
                          $))
                   (QREFELT $ 12))
                  |a| (QREFELT $ 20))
                 (SPADCALL (SPADCALL |t| (QREFELT $ 10)) |a| (QREFELT $ 20))
                 (QREFELT $ 21)))))) 

(SDEFUN |TANEXP;tanSum;LR;4| ((|l| (|List| R)) ($ (R)))
        (SPROG
         ((#1=#:G723 NIL) (#2=#:G722 (R)) (#3=#:G724 (R)) (#4=#:G729 NIL)
          (|i| NIL) (#5=#:G720 NIL) (#6=#:G719 (R)) (#7=#:G721 (R))
          (#8=#:G728 NIL) (|m| (|Integer|)) (|v| (|Vector| R)))
         (SEQ
          (COND ((NULL |l|) (|spadConstant| $ 16))
                (#9='T
                 (SEQ
                  (LETT |m|
                        (SPADCALL (LETT |v| (SPADCALL |l| (QREFELT $ 25)))
                                  (QREFELT $ 26)))
                  (EXIT
                   (SPADCALL
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |i| 0)
                          (LETT #8# (QUOTIENT2 (- (QVSIZE |v|) 1) 2)) G190
                          (COND ((|greater_SI| |i| #8#) (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #7#
                                   (SPADCALL (|TANEXP;m1toN| |i| $)
                                             (SPADCALL |v| (+ (* 2 |i|) |m|)
                                                       (QREFELT $ 27))
                                             (QREFELT $ 28)))
                             (COND
                              (#5#
                               (LETT #6# (SPADCALL #6# #7# (QREFELT $ 29))))
                              ('T (PROGN (LETT #6# #7#) (LETT #5# 'T)))))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                     (COND (#5# #6#) (#9# (|spadConstant| $ 16))))
                    (SPADCALL (|spadConstant| $ 7)
                              (PROGN
                               (LETT #1# NIL)
                               (SEQ (LETT |i| 1)
                                    (LETT #4# (QUOTIENT2 (QVSIZE |v|) 2)) G190
                                    (COND ((|greater_SI| |i| #4#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #3#
                                             (SPADCALL (|TANEXP;m1toN| |i| $)
                                                       (SPADCALL |v|
                                                                 (+
                                                                  (- (* 2 |i|)
                                                                     1)
                                                                  |m|)
                                                                 (QREFELT $
                                                                          27))
                                                       (QREFELT $ 28)))
                                       (COND
                                        (#1#
                                         (LETT #2#
                                               (SPADCALL #2# #3#
                                                         (QREFELT $ 29))))
                                        ('T
                                         (PROGN
                                          (LETT #2# #3#)
                                          (LETT #1# 'T)))))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT NIL))
                               (COND (#1# #2#) (#9# (|spadConstant| $ 16))))
                              (QREFELT $ 29))
                    (QREFELT $ 21))))))))) 

(SDEFUN |TANEXP;tanPIa|
        ((|n| (|PositiveInteger|))
         ($ (|Fraction| (|SparseUnivariatePolynomial| R))))
        (SPROG
         ((#1=#:G734 NIL) (#2=#:G733 #3=(|SparseUnivariatePolynomial| R))
          (#4=#:G735 #3#) (#5=#:G739 NIL) (|i| NIL) (#6=#:G731 NIL)
          (#7=#:G730 #3#) (#8=#:G732 #3#) (#9=#:G738 NIL) (|m| (|Integer|))
          (|v| (|Vector| (|SparseUnivariatePolynomial| R))))
         (SEQ
          (LETT |m|
                (SPADCALL
                 (LETT |v|
                       (SPADCALL
                        (SPADCALL (|spadConstant| $ 7) 1 (QREFELT $ 33)) |n|
                        (QREFELT $ 36)))
                 (QREFELT $ 37)))
          (EXIT
           (SPADCALL
            (PROGN
             (LETT #6# NIL)
             (SEQ (LETT |i| 0) (LETT #9# (QUOTIENT2 (- (QVSIZE |v|) 1) 2)) G190
                  (COND ((|greater_SI| |i| #9#) (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #8#
                           (SPADCALL (|TANEXP;m1toN| |i| $)
                                     (SPADCALL |v| (+ (* 2 |i|) |m|)
                                               (QREFELT $ 38))
                                     (QREFELT $ 39)))
                     (COND (#6# (LETT #7# (SPADCALL #7# #8# (QREFELT $ 40))))
                           ('T (PROGN (LETT #7# #8#) (LETT #6# 'T)))))))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
             (COND (#6# #7#) (#10='T (|spadConstant| $ 41))))
            (SPADCALL (|spadConstant| $ 42)
                      (PROGN
                       (LETT #1# NIL)
                       (SEQ (LETT |i| 1) (LETT #5# (QUOTIENT2 (QVSIZE |v|) 2))
                            G190 (COND ((|greater_SI| |i| #5#) (GO G191)))
                            (SEQ
                             (EXIT
                              (PROGN
                               (LETT #4#
                                     (SPADCALL (|TANEXP;m1toN| |i| $)
                                               (SPADCALL |v|
                                                         (+ (- (* 2 |i|) 1)
                                                            |m|)
                                                         (QREFELT $ 38))
                                               (QREFELT $ 39)))
                               (COND
                                (#1#
                                 (LETT #2# (SPADCALL #2# #4# (QREFELT $ 40))))
                                ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (COND (#1# #2#) (#10# (|spadConstant| $ 41))))
                      (QREFELT $ 40))
            (QREFELT $ 43)))))) 

(DECLAIM (NOTINLINE |TangentExpansions;|)) 

(DEFUN |TangentExpansions| (#1=#:G740)
  (SPROG NIL
         (PROG (#2=#:G741)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|TangentExpansions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|TangentExpansions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|TangentExpansions|)))))))))) 

(DEFUN |TangentExpansions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|TangentExpansions| DV$1))
          (LETT $ (GETREFV 44))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TangentExpansions| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TangentExpansions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|)
              (|SparseUnivariatePolynomial| 6) (|Fraction| 8) (4 . |denom|)
              (9 . *) (15 . |numer|) (20 . -) (|PositiveInteger|)
              |TANEXP;tanAn;RPiSup;2| (26 . |Zero|) (|Integer|)
              |TANEXP;tanNa;RIR;3| (30 . -) (35 . |elt|) (41 . /) (|Vector| 6)
              (|List| 6) (|SymmetricFunctions| 6) (47 . |symFunc|)
              (52 . |minIndex|) (57 . |elt|) (63 . *) (69 . +)
              |TANEXP;tanSum;LR;4| (75 . |One|) (|NonNegativeInteger|)
              (79 . |monomial|) (|Vector| 8) (|SymmetricFunctions| 8)
              (85 . |symFunc|) (91 . |minIndex|) (96 . |elt|) (102 . *)
              (108 . +) (114 . |Zero|) (118 . |One|) (122 . /))
           '#(|tanSum| 128 |tanNa| 133 |tanAn| 139) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|tanSum| (|#1| (|List| |#1|))) T)
                                   '((|tanAn|
                                      ((|SparseUnivariatePolynomial| |#1|) |#1|
                                       (|PositiveInteger|)))
                                     T)
                                   '((|tanNa| (|#1| |#1| (|Integer|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 43
                                            '(0 6 0 7 1 9 8 0 10 2 8 0 6 0 11 1
                                              9 8 0 12 2 8 0 0 0 13 0 6 0 16 1
                                              6 0 0 19 2 8 6 0 6 20 2 6 0 0 0
                                              21 1 24 22 23 25 1 22 17 0 26 2
                                              22 6 0 17 27 2 6 0 17 0 28 2 6 0
                                              0 0 29 0 9 0 31 2 8 0 6 32 33 2
                                              35 34 8 14 36 1 34 17 0 37 2 34 8
                                              0 17 38 2 8 0 17 0 39 2 8 0 0 0
                                              40 0 8 0 41 0 8 0 42 2 9 0 8 8 43
                                              1 0 6 23 30 2 0 6 6 17 18 2 0 8 6
                                              14 15)))))
           '|lookupComplete|)) 

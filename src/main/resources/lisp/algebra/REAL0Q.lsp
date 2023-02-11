
(SDEFUN |REAL0Q;convert2PolInt|
        ((|f| (|Pol|)) ($ (|SparseUnivariatePolynomial| (|Integer|))))
        (SPROG ((|pden| (|Integer|)) (#1=#:G707 NIL) (|c| NIL) (#2=#:G706 NIL))
               (SEQ
                (LETT |pden|
                      (SPADCALL
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |c| NIL)
                             (LETT #1# (SPADCALL |f| (QREFELT $ 8))) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS (SPADCALL |c| (QREFELT $ 11))
                                           #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))
                       (QREFELT $ 13)))
                (EXIT
                 (SPADCALL (ELT $ 14) (SPADCALL |pden| |f| (QREFELT $ 15))
                           (QREFELT $ 19)))))) 

(SDEFUN |REAL0Q;realZeros;PolL;2|
        ((|f| (|Pol|))
         ($
          (|List|
           (|Record| (|:| |left| (|Fraction| (|Integer|)))
                     (|:| |right| (|Fraction| (|Integer|)))))))
        (SPADCALL (|REAL0Q;convert2PolInt| |f| $) (QREFELT $ 23))) 

(SDEFUN |REAL0Q;realZeros;PolFL;3|
        ((|f| (|Pol|)) (|rn| (|Fraction| (|Integer|)))
         ($
          (|List|
           (|Record| (|:| |left| (|Fraction| (|Integer|)))
                     (|:| |right| (|Fraction| (|Integer|)))))))
        (SPADCALL (|REAL0Q;convert2PolInt| |f| $) |rn| (QREFELT $ 25))) 

(SDEFUN |REAL0Q;realZeros;PolRL;4|
        ((|f| (|Pol|))
         (|bounds|
          (|Record| (|:| |left| (|Fraction| (|Integer|)))
                    (|:| |right| (|Fraction| (|Integer|)))))
         ($
          (|List|
           (|Record| (|:| |left| (|Fraction| (|Integer|)))
                     (|:| |right| (|Fraction| (|Integer|)))))))
        (SPADCALL (|REAL0Q;convert2PolInt| |f| $) |bounds| (QREFELT $ 27))) 

(SDEFUN |REAL0Q;realZeros;PolRFL;5|
        ((|f| (|Pol|))
         (|bounds|
          (|Record| (|:| |left| (|Fraction| (|Integer|)))
                    (|:| |right| (|Fraction| (|Integer|)))))
         (|rn| (|Fraction| (|Integer|)))
         ($
          (|List|
           (|Record| (|:| |left| (|Fraction| (|Integer|)))
                     (|:| |right| (|Fraction| (|Integer|)))))))
        (SPADCALL (|REAL0Q;convert2PolInt| |f| $) |bounds| |rn| (QREFELT $ 29))) 

(SDEFUN |REAL0Q;refine;PolRFR;6|
        ((|f| (|Pol|))
         (|int|
          (|Record| (|:| |left| (|Fraction| (|Integer|)))
                    (|:| |right| (|Fraction| (|Integer|)))))
         (|eps| (|Fraction| (|Integer|)))
         ($
          (|Record| (|:| |left| (|Fraction| (|Integer|)))
                    (|:| |right| (|Fraction| (|Integer|))))))
        (SPADCALL (|REAL0Q;convert2PolInt| |f| $) |int| |eps| (QREFELT $ 31))) 

(SDEFUN |REAL0Q;refine;Pol2RU;7|
        ((|f| (|Pol|))
         (|int|
          (|Record| (|:| |left| (|Fraction| (|Integer|)))
                    (|:| |right| (|Fraction| (|Integer|)))))
         (|bounds|
          (|Record| (|:| |left| (|Fraction| (|Integer|)))
                    (|:| |right| (|Fraction| (|Integer|)))))
         ($
          (|Union|
           (|Record| (|:| |left| (|Fraction| (|Integer|)))
                     (|:| |right| (|Fraction| (|Integer|))))
           "failed")))
        (SPADCALL (|REAL0Q;convert2PolInt| |f| $) |int| |bounds|
                  (QREFELT $ 34))) 

(DECLAIM (NOTINLINE |RealZeroPackageQ;|)) 

(DEFUN |RealZeroPackageQ| (#1=#:G723)
  (SPROG NIL
         (PROG (#2=#:G724)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RealZeroPackageQ|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RealZeroPackageQ;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RealZeroPackageQ|)))))))))) 

(DEFUN |RealZeroPackageQ;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RealZeroPackageQ| DV$1))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RealZeroPackageQ| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RealZeroPackageQ| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|List| 10)
              (0 . |coefficients|) (|Integer|) (|Fraction| 9) (5 . |denom|)
              (|List| $) (10 . |lcm|) (15 . |numer|) (20 . *)
              (|SparseUnivariatePolynomial| 9) (|Mapping| 9 10)
              (|UnivariatePolynomialCategoryFunctions2| 10 6 9 16) (26 . |map|)
              (|Record| (|:| |left| 10) (|:| |right| 10)) (|List| 20)
              (|RealZeroPackage| 16) (32 . |realZeros|)
              |REAL0Q;realZeros;PolL;2| (37 . |realZeros|)
              |REAL0Q;realZeros;PolFL;3| (43 . |realZeros|)
              |REAL0Q;realZeros;PolRL;4| (49 . |realZeros|)
              |REAL0Q;realZeros;PolRFL;5| (56 . |refine|)
              |REAL0Q;refine;PolRFR;6| (|Union| 20 '"failed") (63 . |refine|)
              |REAL0Q;refine;Pol2RU;7|)
           '#(|refine| 70 |realZeros| 84) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|realZeros|
                                 ((|List|
                                   (|Record|
                                    (|:| |left| (|Fraction| (|Integer|)))
                                    (|:| |right| (|Fraction| (|Integer|)))))
                                  |#1|))
                                T)
                              '((|realZeros|
                                 ((|List|
                                   (|Record|
                                    (|:| |left| (|Fraction| (|Integer|)))
                                    (|:| |right| (|Fraction| (|Integer|)))))
                                  |#1|
                                  (|Record|
                                   (|:| |left| (|Fraction| (|Integer|)))
                                   (|:| |right| (|Fraction| (|Integer|))))))
                                T)
                              '((|realZeros|
                                 ((|List|
                                   (|Record|
                                    (|:| |left| (|Fraction| (|Integer|)))
                                    (|:| |right| (|Fraction| (|Integer|)))))
                                  |#1| (|Fraction| (|Integer|))))
                                T)
                              '((|realZeros|
                                 ((|List|
                                   (|Record|
                                    (|:| |left| (|Fraction| (|Integer|)))
                                    (|:| |right| (|Fraction| (|Integer|)))))
                                  |#1|
                                  (|Record|
                                   (|:| |left| (|Fraction| (|Integer|)))
                                   (|:| |right| (|Fraction| (|Integer|))))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|refine|
                                 ((|Record|
                                   (|:| |left| (|Fraction| (|Integer|)))
                                   (|:| |right| (|Fraction| (|Integer|))))
                                  |#1|
                                  (|Record|
                                   (|:| |left| (|Fraction| (|Integer|)))
                                   (|:| |right| (|Fraction| (|Integer|))))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|refine|
                                 ((|Union|
                                   (|Record|
                                    (|:| |left| (|Fraction| (|Integer|)))
                                    (|:| |right| (|Fraction| (|Integer|))))
                                   "failed")
                                  |#1|
                                  (|Record|
                                   (|:| |left| (|Fraction| (|Integer|)))
                                   (|:| |right| (|Fraction| (|Integer|))))
                                  (|Record|
                                   (|:| |left| (|Fraction| (|Integer|)))
                                   (|:| |right| (|Fraction| (|Integer|))))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 35
                                            '(1 6 7 0 8 1 10 9 0 11 1 9 0 12 13
                                              1 10 9 0 14 2 6 0 9 0 15 2 18 16
                                              17 6 19 1 22 21 16 23 2 22 21 16
                                              10 25 2 22 21 16 20 27 3 22 21 16
                                              20 10 29 3 22 20 16 20 10 31 3 22
                                              33 16 20 20 34 3 0 33 6 20 20 35
                                              3 0 20 6 20 10 32 1 0 21 6 24 2 0
                                              21 6 10 26 2 0 21 6 20 28 3 0 21
                                              6 20 10 30)))))
           '|lookupComplete|)) 

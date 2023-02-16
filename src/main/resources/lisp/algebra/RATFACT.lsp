
(SDEFUN |RATFACT;factor;RPF;1| ((|p| (RP)) ($ (|Factored| RP)))
        (SPROG
         ((#1=#:G730 NIL) (|u| NIL) (#2=#:G729 NIL)
          (|ffact|
           (|Record| (|:| |contp| (|Integer|))
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr|
                                 (|SparseUnivariatePolynomial| (|Integer|)))
                            (|:| |pow| (|NonNegativeInteger|)))))))
          (|ipol| (|SparseUnivariatePolynomial| (|Integer|))) (|pol| (RP))
          (|pden| (|Integer|)) (#3=#:G728 NIL) (|c| NIL) (#4=#:G727 NIL))
         (SEQ
          (COND
           ((SPADCALL |p| (|spadConstant| $ 7) (QREFELT $ 11))
            (|spadConstant| $ 9))
           ('T
            (SEQ
             (LETT |pden|
                   (SPADCALL
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |c| NIL)
                          (LETT #3# (SPADCALL |p| (QREFELT $ 13))) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |c| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS (SPADCALL |c| (QREFELT $ 16)) #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#))))
                    (QREFELT $ 18)))
             (LETT |pol| (SPADCALL |pden| |p| (QREFELT $ 19)))
             (LETT |ipol| (SPADCALL (ELT $ 20) |pol| (QREFELT $ 24)))
             (LETT |ffact| (SPADCALL |ipol| NIL (QREFELT $ 28)))
             (EXIT
              (SPADCALL
               (SPADCALL (SPADCALL (QCAR |ffact|) |pden| (QREFELT $ 29))
                         (QREFELT $ 30))
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |u| NIL) (LETT #1# (QCDR |ffact|)) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (VECTOR (CONS 3 "prime")
                                      (SPADCALL (ELT $ 31) (QCAR |u|)
                                                (QREFELT $ 34))
                                      (QCDR |u|))
                              #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#))))
               (QREFELT $ 38))))))))) 

(SDEFUN |RATFACT;factorSquareFree;RPF;2| ((|p| (RP)) ($ (|Factored| RP)))
        (SPROG
         ((#1=#:G750 NIL) (|u| NIL) (#2=#:G749 NIL)
          (|ffact|
           (|Record| (|:| |contp| (|Integer|))
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr|
                                 (|SparseUnivariatePolynomial| (|Integer|)))
                            (|:| |pow| (|NonNegativeInteger|)))))))
          (|ipol| (|SparseUnivariatePolynomial| (|Integer|))) (|pol| (RP))
          (|pden| (|Integer|)) (#3=#:G748 NIL) (|c| NIL) (#4=#:G747 NIL))
         (SEQ
          (COND
           ((SPADCALL |p| (|spadConstant| $ 7) (QREFELT $ 11))
            (|spadConstant| $ 9))
           ('T
            (SEQ
             (LETT |pden|
                   (SPADCALL
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |c| NIL)
                          (LETT #3# (SPADCALL |p| (QREFELT $ 13))) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |c| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS (SPADCALL |c| (QREFELT $ 16)) #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#))))
                    (QREFELT $ 18)))
             (LETT |pol| (SPADCALL |pden| |p| (QREFELT $ 19)))
             (LETT |ipol| (SPADCALL (ELT $ 20) |pol| (QREFELT $ 24)))
             (LETT |ffact| (SPADCALL |ipol| 'T (QREFELT $ 28)))
             (EXIT
              (SPADCALL
               (SPADCALL (SPADCALL (QCAR |ffact|) |pden| (QREFELT $ 29))
                         (QREFELT $ 30))
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |u| NIL) (LETT #1# (QCDR |ffact|)) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (VECTOR (CONS 3 "prime")
                                      (SPADCALL (ELT $ 31) (QCAR |u|)
                                                (QREFELT $ 34))
                                      (QCDR |u|))
                              #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#))))
               (QREFELT $ 38))))))))) 

(DECLAIM (NOTINLINE |RationalFactorize;|)) 

(DEFUN |RationalFactorize| (#1=#:G751)
  (SPROG NIL
         (PROG (#2=#:G752)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RationalFactorize|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RationalFactorize;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RationalFactorize|)))))))))) 

(DEFUN |RationalFactorize;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RationalFactorize| DV$1))
          (LETT $ (GETREFV 41))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalFactorize| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RationalFactorize| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|)
              (|Factored| 6) (4 . |Zero|) (|Boolean|) (8 . =) (|List| 15)
              (14 . |coefficients|) (|Integer|) (|Fraction| 14) (19 . |denom|)
              (|List| $) (24 . |lcm|) (29 . *) (35 . |numer|)
              (|SparseUnivariatePolynomial| 14) (|Mapping| 14 15)
              (|UnivariatePolynomialCategoryFunctions2| 15 6 14 21)
              (40 . |map|)
              (|Record| (|:| |irr| 21) (|:| |pow| (|NonNegativeInteger|)))
              (|Record| (|:| |contp| 14) (|:| |factors| (|List| 25)))
              (|GaloisGroupFactorizer| 21) (46 . |henselFact|) (52 . /)
              (58 . |coerce|) (63 . |coerce|) (|Mapping| 15 14)
              (|UnivariatePolynomialCategoryFunctions2| 14 21 15 6)
              (68 . |map|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 35) (|:| |factor| 6)
                        (|:| |exponent| (|NonNegativeInteger|)))
              (|List| 36) (74 . |makeFR|) |RATFACT;factor;RPF;1|
              |RATFACT;factorSquareFree;RPF;2|)
           '#(|factorSquareFree| 80 |factor| 85) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|factor| ((|Factored| |#1|) |#1|)) T)
                                   '((|factorSquareFree|
                                      ((|Factored| |#1|) |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 40
                                            '(0 6 0 7 0 8 0 9 2 6 10 0 0 11 1 6
                                              12 0 13 1 15 14 0 16 1 14 0 17 18
                                              2 6 0 14 0 19 1 15 14 0 20 2 23
                                              21 22 6 24 2 27 26 21 10 28 2 15
                                              0 14 14 29 1 6 0 15 30 1 15 0 14
                                              31 2 33 6 32 21 34 2 8 0 6 37 38
                                              1 0 8 6 40 1 0 8 6 39)))))
           '|lookupComplete|)) 

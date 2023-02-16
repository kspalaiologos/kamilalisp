
(SDEFUN |GALPOLYU;factorsOfDegree;PiFL;1|
        ((|d| (|PositiveInteger|)) (|r| (|Factored| UP)) ($ (|List| UP)))
        (SPROG
         ((|lfact| (|List| UP)) (#1=#:G719 NIL) (|i| NIL) (#2=#:G718 NIL)
          (|fr| NIL))
         (SEQ (LETT |lfact| NIL)
              (SEQ (LETT |fr| NIL) (LETT #2# (SPADCALL |r| (QREFELT $ 12)))
                   G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |fr| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL (SPADCALL (QVELT |fr| 1) (QREFELT $ 14)) |d|)
                       (SEQ (LETT |i| 1) (LETT #1# (QVELT |fr| 2)) G190
                            (COND ((|greater_SI| |i| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |lfact| (CONS (QVELT |fr| 1) |lfact|))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |lfact|)))) 

(SDEFUN |GALPOLYU;factorOfDegree;PiFUP;2|
        ((|d| (|PositiveInteger|)) (|r| (|Factored| UP)) ($ (UP)))
        (SPROG ((#1=#:G726 NIL) (|factor| (UP)) (#2=#:G727 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |factor| (|spadConstant| $ 18))
                      (SEQ (LETT |i| NIL)
                           (LETT #2# (SPADCALL |r| (QREFELT $ 12))) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |factor| (QVELT |i| 1))
                                (EXIT
                                 (COND
                                  ((EQL (SPADCALL |factor| (QREFELT $ 14)) |d|)
                                   (PROGN
                                    (LETT #1# |factor|)
                                    (GO #3=#:G725))))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (|error| "factorOfDegree: Bad arguments"))))
                #3# (EXIT #1#)))) 

(SDEFUN |GALPOLYU;degreePartition;FM;3|
        ((|r| (|Factored| UP)) ($ (|Multiset| (|NonNegativeInteger|))))
        (SPROG ((#1=#:G733 NIL) (|i| NIL) (#2=#:G732 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |i| NIL) (LETT #1# (SPADCALL |r| (QREFELT $ 12)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS (SPADCALL (QVELT |i| 1) (QREFELT $ 14))
                                     #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 22))))) 

(SDEFUN |GALPOLYU;monic?;UPB;4| ((|p| (UP)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 24)) (|spadConstant| $ 25)
                  (QREFELT $ 27))) 

(SDEFUN |GALPOLYU;reverse;2UP;5| ((|p| (UP)) ($ (UP)))
        (SPROG
         ((|r| (UP)) (#1=#:G736 NIL) (#2=#:G740 NIL) (|i| NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |r| (|spadConstant| $ 18))
              (LETT |n| (SPADCALL |p| (QREFELT $ 14)))
              (SEQ (LETT |i| 0) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |r|
                           (SPADCALL |r|
                                     (SPADCALL
                                      (SPADCALL |p|
                                                (PROG1 (LETT #1# (- |n| |i|))
                                                  (|check_subtype2| (>= #1# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #1#))
                                                (QREFELT $ 29))
                                      |i| (QREFELT $ 30))
                                     (QREFELT $ 31)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(SDEFUN |GALPOLYU;scaleRoots;UPRUP;6| ((|p| (UP)) (|c| (R)) ($ (UP)))
        (SPROG ((|mc| (R)) (|r| (UP)) (|i| NIL) (|n| (|NonNegativeInteger|)))
               (SEQ
                (COND ((SPADCALL |c| (|spadConstant| $ 25) (QREFELT $ 27)) |p|)
                      (#1='T
                       (SEQ (LETT |n| (SPADCALL |p| (QREFELT $ 14)))
                            (EXIT
                             (COND
                              ((SPADCALL |c| (QREFELT $ 34))
                               (SPADCALL (SPADCALL |p| (QREFELT $ 24)) |n|
                                         (QREFELT $ 30)))
                              (#1#
                               (SEQ (LETT |r| (|spadConstant| $ 18))
                                    (LETT |mc| (|spadConstant| $ 25))
                                    (SEQ (LETT |i| |n|) G190
                                         (COND ((< |i| 0) (GO G191)))
                                         (SEQ
                                          (LETT |r|
                                                (SPADCALL |r|
                                                          (SPADCALL
                                                           (SPADCALL |mc|
                                                                     (SPADCALL
                                                                      |p| |i|
                                                                      (QREFELT
                                                                       $ 29))
                                                                     (QREFELT $
                                                                              35))
                                                           |i| (QREFELT $ 30))
                                                          (QREFELT $ 31)))
                                          (EXIT
                                           (LETT |mc|
                                                 (SPADCALL |mc| |c|
                                                           (QREFELT $ 35)))))
                                         (LETT |i| (+ |i| -1)) (GO G190) G191
                                         (EXIT NIL))
                                    (EXIT |r|))))))))))) 

(SDEFUN |GALPOLYU;shiftRoots;UPRUP;7| ((|p| (UP)) (|c| (R)) ($ (UP)))
        (SPADCALL (SPADCALL (ELT $ 37) |p| (QREFELT $ 41))
                  (SPADCALL (SPADCALL (|spadConstant| $ 25) 1 (QREFELT $ 30))
                            (SPADCALL |c| (QREFELT $ 37)) (QREFELT $ 42))
                  (QREFELT $ 43))) 

(DECLAIM (NOTINLINE |GaloisGroupPolynomialUtilities;|)) 

(DEFUN |GaloisGroupPolynomialUtilities| (&REST #1=#:G762)
  (SPROG NIL
         (PROG (#2=#:G763)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GaloisGroupPolynomialUtilities|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |GaloisGroupPolynomialUtilities;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|GaloisGroupPolynomialUtilities|)))))))))) 

(DEFUN |GaloisGroupPolynomialUtilities;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|GaloisGroupPolynomialUtilities| DV$1 DV$2))
          (LETT $ (GETREFV 45))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GaloisGroupPolynomialUtilities|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GaloisGroupPolynomialUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 8) (|:| |factor| 7) (|:| |exponent| 13))
              (|List| 9) (|Factored| 7) (0 . |factorList|)
              (|NonNegativeInteger|) (5 . |degree|) (|List| 7)
              (|PositiveInteger|) |GALPOLYU;factorsOfDegree;PiFL;1|
              (10 . |Zero|) |GALPOLYU;factorOfDegree;PiFUP;2| (|List| 13)
              (|Multiset| 13) (14 . |multiset|) |GALPOLYU;degreePartition;FM;3|
              (19 . |leadingCoefficient|) (24 . |One|) (|Boolean|) (28 . =)
              |GALPOLYU;monic?;UPB;4| (34 . |coefficient|) (40 . |monomial|)
              (46 . +) |GALPOLYU;reverse;2UP;5| (52 . |One|) (56 . |zero?|)
              (61 . *) |GALPOLYU;scaleRoots;UPRUP;6| (67 . |coerce|)
              (|SparseUnivariatePolynomial| 7) (|Mapping| 7 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 7 38) (72 . |map|)
              (78 . -) (84 . |elt|) |GALPOLYU;shiftRoots;UPRUP;7|)
           '#(|shiftRoots| 90 |scaleRoots| 96 |reverse| 102 |monic?| 107
              |factorsOfDegree| 112 |factorOfDegree| 118 |degreePartition| 124)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|monic?| ((|Boolean|) |#2|)) T)
                                   '((|reverse| (|#2| |#2|)) T)
                                   '((|scaleRoots| (|#2| |#2| |#1|)) T)
                                   '((|shiftRoots| (|#2| |#2| |#1|)) T)
                                   '((|degreePartition|
                                      ((|Multiset| (|NonNegativeInteger|))
                                       (|Factored| |#2|)))
                                     T)
                                   '((|factorOfDegree|
                                      (|#2| (|PositiveInteger|)
                                       (|Factored| |#2|)))
                                     T)
                                   '((|factorsOfDegree|
                                      ((|List| |#2|) (|PositiveInteger|)
                                       (|Factored| |#2|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 44
                                            '(1 11 10 0 12 1 7 13 0 14 0 7 0 18
                                              1 21 0 20 22 1 7 6 0 24 0 6 0 25
                                              2 6 26 0 0 27 2 7 6 0 13 29 2 7 0
                                              6 13 30 2 7 0 0 0 31 0 7 0 33 1 6
                                              26 0 34 2 6 0 0 0 35 1 7 0 6 37 2
                                              40 38 39 7 41 2 7 0 0 0 42 2 38 7
                                              0 7 43 2 0 7 7 6 44 2 0 7 7 6 36
                                              1 0 7 7 32 1 0 26 7 28 2 0 15 16
                                              11 17 2 0 7 16 11 19 1 0 21 11
                                              23)))))
           '|lookupComplete|)) 

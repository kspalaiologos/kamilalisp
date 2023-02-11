
(SDEFUN |INDE;coerceOF| ((|t| (|Term|)) ($ (|OutputForm|)))
        (COND ((EQL (QCDR |t|) 1) (SPADCALL (QCAR |t|) (QREFELT $ 10)))
              ('T
               (SPADCALL (SPADCALL (QCAR |t|) (QREFELT $ 10))
                         (SPADCALL (QCDR |t|) (QREFELT $ 12)) (QREFELT $ 13))))) 

(SDEFUN |INDE;coerce;$Of;2| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G715 NIL) (|t| NIL) (#2=#:G714 NIL))
               (SEQ
                (COND ((NULL |x|) (SPADCALL 1 (QREFELT $ 15)))
                      ((NULL (CDR |x|)) (|INDE;coerceOF| (|SPADfirst| |x|) $))
                      ('T
                       (SPADCALL (ELT $ 16)
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |t| NIL) (LETT #1# |x|) G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |t| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS (|INDE;coerceOF| |t| $)
                                                     #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#))))
                                 (QREFELT $ 19))))))) 

(DECLAIM (NOTINLINE |IndexedExponents;|)) 

(DEFUN |IndexedExponents| (#1=#:G725)
  (SPROG NIL
         (PROG (#2=#:G726)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IndexedExponents|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|IndexedExponents;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|IndexedExponents|)))))))))) 

(DEFUN |IndexedExponents;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IndexedExponents| DV$1))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory|
                                               (|NonNegativeInteger|)
                                               '(|AbelianGroup|))
                                              (|HasCategory| |#1|
                                                             '(|Comparable|))))))
          (|haddProp| |$ConstructorCache| '|IndexedExponents| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |k| |#1|) (|:| |c| (|NonNegativeInteger|))))
          (QSETREFV $ 8 (|List| (QREFELT $ 7)))
          $))) 

(MAKEPROP '|IndexedExponents| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|IndexedDirectProductObject| 11 6)
              (|local| |#1|) '|Term| '|Rep| (|OutputForm|) (0 . |coerce|)
              (|NonNegativeInteger|) (5 . |coerce|) (10 . ^) (|Integer|)
              (16 . |coerce|) (21 . *) (|Mapping| 9 9 9) (|List| 9)
              (27 . |reduce|) |INDE;coerce;$Of;2|
              (|Record| (|:| |k| 6) (|:| |c| 11)) (|List| 21) (|Mapping| 11 11)
              (|Boolean|) (|Union| $ '"failed") (|PositiveInteger|) (|String|)
              (|SingleInteger|) (|HashState|))
           '#(~= 33 |zero?| 39 |sup| 44 |subtractIfCan| 50 |smaller?| 56
              |sample| 62 |reductum| 66 |opposite?| 71 |numberOfMonomials| 77
              |monomial?| 82 |monomial| 87 |min| 93 |max| 99 |map| 105
              |listOfTerms| 111 |leadingTerm| 116 |leadingSupport| 121
              |leadingMonomial| 126 |leadingCoefficient| 131 |latex| 136 |inf|
              141 |hashUpdate!| 147 |hash| 153 |constructOrdered| 158
              |construct| 163 |coerce| 168 |Zero| 173 >= 177 > 183 = 189 <= 195
              < 201 - 207 + 218 * 224)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(NIL NIL NIL NIL NIL NIL |AbelianGroup&| NIL NIL
                     |OrderedSet&| |AbelianMonoid&| NIL |AbelianSemiGroup&|
                     |SetCategory&| |BasicType&| |PartialOrder&| NIL)
                  (CONS
                   '#((|IndexedDirectProductCategory| 11 6)
                      (|OrderedAbelianMonoidSup|)
                      (|IndexedProductCategory| 11 6)
                      (|OrderedCancellationAbelianMonoid|)
                      (|AbelianProductCategory| 11) (|OrderedAbelianMonoid|)
                      (|AbelianGroup|) (|OrderedAbelianSemiGroup|)
                      (|CancellationAbelianMonoid|) (|OrderedSet|)
                      (|AbelianMonoid|) (|Comparable|) (|AbelianSemiGroup|)
                      (|SetCategory|) (|BasicType|) (|PartialOrder|)
                      (|CoercibleTo| 9))
                   (|makeByteWordVec2| 29
                                       '(1 6 9 0 10 1 11 9 0 12 2 9 0 0 0 13 1
                                         14 9 0 15 2 9 0 0 0 16 2 18 9 17 0 19
                                         2 0 24 0 0 1 1 0 24 0 1 2 0 0 0 0 1 2
                                         0 25 0 0 1 2 0 24 0 0 1 0 0 0 1 1 2 0
                                         0 1 2 0 24 0 0 1 1 0 11 0 1 1 0 24 0 1
                                         2 0 0 11 6 1 2 0 0 0 0 1 2 0 0 0 0 1 2
                                         0 0 23 0 1 1 0 22 0 1 1 2 21 0 1 1 2 6
                                         0 1 1 2 0 0 1 1 2 11 0 1 1 0 27 0 1 2
                                         0 0 0 0 1 2 0 29 29 0 1 1 0 28 0 1 1 2
                                         0 22 1 1 0 0 22 1 1 0 9 0 20 0 0 0 1 2
                                         0 24 0 0 1 2 0 24 0 0 1 2 0 24 0 0 1 2
                                         0 24 0 0 1 2 0 24 0 0 1 2 1 0 0 0 1 1
                                         1 0 0 1 2 0 0 0 0 1 2 1 0 14 0 1 2 0 0
                                         11 0 1 2 0 0 26 0 1)))))
           '|lookupComplete|)) 


(DECLAIM (NOTINLINE |GuessFinite;|)) 

(DEFUN |GuessFinite| (#1=#:G715)
  (SPROG NIL
         (PROG (#2=#:G716)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|GuessFinite|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|GuessFinite;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|GuessFinite|)))))))))) 

(DEFUN |GuessFinite;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|GuessFinite| DV$1))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Symbol|)))))))
          (|haddProp| |$ConstructorCache| '|GuessFinite| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GuessFinite| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|Guess| 6 6 7 (NRTEVAL (ELT $ 9)) (NRTEVAL (ELT $ 10)))
              (|local| |#1|) (|Expression| (|Integer|))
              (|GuessFiniteFunctions| 6) (0 . EXPRR2F) (5 . F2EXPRR)
              (|Mapping| 25 26 27) (|Symbol|)
              (|Mapping| (|Stream| (|UnivariateFormalPowerSeries| 6))
                         (|UnivariateFormalPowerSeries| 6))
              (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                         (|Integer|) (|Integer|))
              (|Mapping| 14 (|NonNegativeInteger|))
              (|Mapping|
               (|Vector|
                (|UnivariateFormalPowerSeries|
                 (|SparseMultivariatePolynomial| 6 (|NonNegativeInteger|))))
               (|UnivariateFormalPowerSeries|
                (|SparseMultivariatePolynomial| 6 (|NonNegativeInteger|))))
              (|Mapping| 16 (|List| (|PositiveInteger|)))
              (|Mapping| (|Stream| 7) 7 12)
              (|Mapping| 6 (|NonNegativeInteger|) (|NonNegativeInteger|)
                         (|SparseUnivariatePolynomial| 6))
              (|Mapping|
               (|SparseMultivariatePolynomial| 6 (|NonNegativeInteger|))
               (|NonNegativeInteger|) (|NonNegativeInteger|)
               (|UnivariateFormalPowerSeries|
                (|SparseMultivariatePolynomial| 6 (|NonNegativeInteger|))))
              (|Mapping| 7 (|NonNegativeInteger|) 12 7)
              (|Mapping| 26 (|NonNegativeInteger|))
              (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                        (|:| |guessStream| 13) (|:| |guessModGen| 15)
                        (|:| |testGen| 17) (|:| |exprStream| 18)
                        (|:| |kind| 12) (|:| |qvar| 12) (|:| A 19) (|:| AF 20)
                        (|:| AX 21) (|:| C 22))
              (|Mapping| 23 27) (|List| 7) (|List| 6) (|List| (|GuessOption|))
              (|List| 11) (|List| 12) (|List| 26))
           '#() 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|guess|
                                 ((|List| #1=(|Expression| (|Integer|)))
                                  (|List| |#1|)))
                                T)
                              '((|guess|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guess|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List|
                                   (|Mapping| (|List| #1#) (|List| |#1|)
                                              (|List| (|GuessOption|))))
                                  (|List| (|Symbol|))))
                                T)
                              '((|guess|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List|
                                   (|Mapping| (|List| #1#) (|List| |#1|)
                                              (|List| (|GuessOption|))))
                                  (|List| (|Symbol|))
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessExpRat| ((|List| #1#) (|List| |#1|))) T)
                              '((|guessExpRat|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessBinRat| ((|List| #1#) (|List| |#1|))) T)
                              '((|guessBinRat|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessExpRat|
                                 ((|Mapping| (|List| #1#) (|List| |#1|)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 12))
                                     (|has| 6 (|RetractableTo| 12))))
                              '((|guessBinRat|
                                 ((|Mapping| (|List| #1#) (|List| |#1|)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 12))
                                     (|has| 6 (|RetractableTo| 12))))
                              '((|guessAlgDep|
                                 ((|List| #1#) (|List| (|List| |#1|))))
                                T)
                              '((|guessAlgDep|
                                 ((|List| #1#) (|List| (|List| |#1|))
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessADE| ((|List| #1#) (|List| |#1|))) T)
                              '((|guessADE|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessFE| ((|List| #1#) (|List| |#1|))) T)
                              '((|guessFE|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessAlg| ((|List| #1#) (|List| |#1|))) T)
                              '((|guessAlg|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessHolo| ((|List| #1#) (|List| |#1|))) T)
                              '((|guessHolo|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessPade|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessPade| ((|List| #1#) (|List| |#1|))) T)
                              '((|guessRec| ((|List| #1#) (|List| |#1|))) T)
                              '((|guessRec|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessPRec|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessPRec| ((|List| #1#) (|List| |#1|))) T)
                              '((|guessRat|
                                 ((|List| #1#) (|List| |#1|)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessRat| ((|List| #1#) (|List| |#1|))) T)
                              '((|algDepHP|
                                 ((|Record|
                                   (|:| |degreeStream|
                                        (|Stream| (|NonNegativeInteger|)))
                                   (|:| |guessStream|
                                        (|Mapping|
                                         (|Stream|
                                          (|UnivariateFormalPowerSeries| |#1|))
                                         (|UnivariateFormalPowerSeries| |#1|)))
                                   (|:| |guessModGen|
                                        (|Mapping|
                                         (|Mapping| (|Vector| (|U32Vector|))
                                                    (|List| (|U32Vector|))
                                                    (|Integer|) (|Integer|))
                                         (|NonNegativeInteger|)))
                                   (|:| |testGen|
                                        (|Mapping|
                                         (|Mapping|
                                          (|Vector|
                                           (|UnivariateFormalPowerSeries|
                                            (|SparseMultivariatePolynomial|
                                             |#1| (|NonNegativeInteger|))))
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| |#1|
                                                                           (|NonNegativeInteger|))))
                                         (|List| (|PositiveInteger|))))
                                   (|:| |exprStream|
                                        (|Mapping| (|Stream| #1#) #1#
                                                   (|Symbol|)))
                                   (|:| |kind| (|Symbol|))
                                   (|:| |qvar| (|Symbol|))
                                   (|:| A
                                        (|Mapping| |#1| (|NonNegativeInteger|)
                                                   (|NonNegativeInteger|)
                                                   (|SparseUnivariatePolynomial|
                                                    |#1|)))
                                   (|:| AF
                                        (|Mapping|
                                         (|SparseMultivariatePolynomial| |#1|
                                                                         (|NonNegativeInteger|))
                                         (|NonNegativeInteger|)
                                         (|NonNegativeInteger|)
                                         (|UnivariateFormalPowerSeries|
                                          (|SparseMultivariatePolynomial| |#1|
                                                                          (|NonNegativeInteger|)))))
                                   (|:| AX
                                        (|Mapping| #1# (|NonNegativeInteger|)
                                                   (|Symbol|) #1#))
                                   (|:| C
                                        (|Mapping| (|List| |#1|)
                                                   (|NonNegativeInteger|))))
                                  (|List| (|List| |#1|))
                                  (|List| (|GuessOption|))))
                                T)
                              '((|diffHP|
                                 ((|Record|
                                   (|:| |degreeStream|
                                        (|Stream| (|NonNegativeInteger|)))
                                   (|:| |guessStream|
                                        (|Mapping|
                                         (|Stream|
                                          (|UnivariateFormalPowerSeries| |#1|))
                                         (|UnivariateFormalPowerSeries| |#1|)))
                                   (|:| |guessModGen|
                                        (|Mapping|
                                         (|Mapping| (|Vector| (|U32Vector|))
                                                    (|List| (|U32Vector|))
                                                    (|Integer|) (|Integer|))
                                         (|NonNegativeInteger|)))
                                   (|:| |testGen|
                                        (|Mapping|
                                         (|Mapping|
                                          (|Vector|
                                           (|UnivariateFormalPowerSeries|
                                            (|SparseMultivariatePolynomial|
                                             |#1| (|NonNegativeInteger|))))
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| |#1|
                                                                           (|NonNegativeInteger|))))
                                         (|List| (|PositiveInteger|))))
                                   (|:| |exprStream|
                                        (|Mapping| (|Stream| #1#) #1#
                                                   (|Symbol|)))
                                   (|:| |kind| (|Symbol|))
                                   (|:| |qvar| (|Symbol|))
                                   (|:| A
                                        (|Mapping| |#1| (|NonNegativeInteger|)
                                                   (|NonNegativeInteger|)
                                                   (|SparseUnivariatePolynomial|
                                                    |#1|)))
                                   (|:| AF
                                        (|Mapping|
                                         (|SparseMultivariatePolynomial| |#1|
                                                                         (|NonNegativeInteger|))
                                         (|NonNegativeInteger|)
                                         (|NonNegativeInteger|)
                                         (|UnivariateFormalPowerSeries|
                                          (|SparseMultivariatePolynomial| |#1|
                                                                          (|NonNegativeInteger|)))))
                                   (|:| AX
                                        (|Mapping| #1# (|NonNegativeInteger|)
                                                   (|Symbol|) #1#))
                                   (|:| C
                                        (|Mapping| (|List| |#1|)
                                                   (|NonNegativeInteger|))))
                                  (|List| (|GuessOption|))))
                                T)
                              '((|substHP|
                                 ((|Record|
                                   (|:| |degreeStream|
                                        (|Stream| (|NonNegativeInteger|)))
                                   (|:| |guessStream|
                                        (|Mapping|
                                         (|Stream|
                                          (|UnivariateFormalPowerSeries| |#1|))
                                         (|UnivariateFormalPowerSeries| |#1|)))
                                   (|:| |guessModGen|
                                        (|Mapping|
                                         (|Mapping| (|Vector| (|U32Vector|))
                                                    (|List| (|U32Vector|))
                                                    (|Integer|) (|Integer|))
                                         (|NonNegativeInteger|)))
                                   (|:| |testGen|
                                        (|Mapping|
                                         (|Mapping|
                                          (|Vector|
                                           (|UnivariateFormalPowerSeries|
                                            (|SparseMultivariatePolynomial|
                                             |#1| (|NonNegativeInteger|))))
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| |#1|
                                                                           (|NonNegativeInteger|))))
                                         (|List| (|PositiveInteger|))))
                                   (|:| |exprStream|
                                        (|Mapping| (|Stream| #1#) #1#
                                                   (|Symbol|)))
                                   (|:| |kind| (|Symbol|))
                                   (|:| |qvar| (|Symbol|))
                                   (|:| A
                                        (|Mapping| |#1| (|NonNegativeInteger|)
                                                   (|NonNegativeInteger|)
                                                   (|SparseUnivariatePolynomial|
                                                    |#1|)))
                                   (|:| AF
                                        (|Mapping|
                                         (|SparseMultivariatePolynomial| |#1|
                                                                         (|NonNegativeInteger|))
                                         (|NonNegativeInteger|)
                                         (|NonNegativeInteger|)
                                         (|UnivariateFormalPowerSeries|
                                          (|SparseMultivariatePolynomial| |#1|
                                                                          (|NonNegativeInteger|)))))
                                   (|:| AX
                                        (|Mapping| #1# (|NonNegativeInteger|)
                                                   (|Symbol|) #1#))
                                   (|:| C
                                        (|Mapping| (|List| |#1|)
                                                   (|NonNegativeInteger|))))
                                  (|List| (|GuessOption|))))
                                T)
                              '((|shiftHP|
                                 ((|Record|
                                   (|:| |degreeStream|
                                        (|Stream| (|NonNegativeInteger|)))
                                   (|:| |guessStream|
                                        (|Mapping|
                                         (|Stream|
                                          (|UnivariateFormalPowerSeries| |#1|))
                                         (|UnivariateFormalPowerSeries| |#1|)))
                                   (|:| |guessModGen|
                                        (|Mapping|
                                         (|Mapping| (|Vector| (|U32Vector|))
                                                    (|List| (|U32Vector|))
                                                    (|Integer|) (|Integer|))
                                         (|NonNegativeInteger|)))
                                   (|:| |testGen|
                                        (|Mapping|
                                         (|Mapping|
                                          (|Vector|
                                           (|UnivariateFormalPowerSeries|
                                            (|SparseMultivariatePolynomial|
                                             |#1| (|NonNegativeInteger|))))
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| |#1|
                                                                           (|NonNegativeInteger|))))
                                         (|List| (|PositiveInteger|))))
                                   (|:| |exprStream|
                                        (|Mapping| (|Stream| #1#) #1#
                                                   (|Symbol|)))
                                   (|:| |kind| (|Symbol|))
                                   (|:| |qvar| (|Symbol|))
                                   (|:| A
                                        (|Mapping| |#1| (|NonNegativeInteger|)
                                                   (|NonNegativeInteger|)
                                                   (|SparseUnivariatePolynomial|
                                                    |#1|)))
                                   (|:| AF
                                        (|Mapping|
                                         (|SparseMultivariatePolynomial| |#1|
                                                                         (|NonNegativeInteger|))
                                         (|NonNegativeInteger|)
                                         (|NonNegativeInteger|)
                                         (|UnivariateFormalPowerSeries|
                                          (|SparseMultivariatePolynomial| |#1|
                                                                          (|NonNegativeInteger|)))))
                                   (|:| AX
                                        (|Mapping| #1# (|NonNegativeInteger|)
                                                   (|Symbol|) #1#))
                                   (|:| C
                                        (|Mapping| (|List| |#1|)
                                                   (|NonNegativeInteger|))))
                                  (|List| (|GuessOption|))))
                                T)
                              '((|shiftHP|
                                 ((|Mapping|
                                   (|Record|
                                    (|:| |degreeStream|
                                         (|Stream| (|NonNegativeInteger|)))
                                    (|:| |guessStream|
                                         (|Mapping|
                                          (|Stream|
                                           (|UnivariateFormalPowerSeries|
                                            |#1|))
                                          (|UnivariateFormalPowerSeries|
                                           |#1|)))
                                    (|:| |guessModGen|
                                         (|Mapping|
                                          (|Mapping| (|Vector| (|U32Vector|))
                                                     (|List| (|U32Vector|))
                                                     (|Integer|) (|Integer|))
                                          (|NonNegativeInteger|)))
                                    (|:| |testGen|
                                         (|Mapping|
                                          (|Mapping|
                                           (|Vector|
                                            (|UnivariateFormalPowerSeries|
                                             (|SparseMultivariatePolynomial|
                                              |#1| (|NonNegativeInteger|))))
                                           (|UnivariateFormalPowerSeries|
                                            (|SparseMultivariatePolynomial|
                                             |#1| (|NonNegativeInteger|))))
                                          (|List| (|PositiveInteger|))))
                                    (|:| |exprStream|
                                         (|Mapping| (|Stream| #1#) #1#
                                                    (|Symbol|)))
                                    (|:| |kind| (|Symbol|))
                                    (|:| |qvar| (|Symbol|))
                                    (|:| A
                                         (|Mapping| |#1| (|NonNegativeInteger|)
                                                    (|NonNegativeInteger|)
                                                    (|SparseUnivariatePolynomial|
                                                     |#1|)))
                                    (|:| AF
                                         (|Mapping|
                                          (|SparseMultivariatePolynomial| |#1|
                                                                          (|NonNegativeInteger|))
                                          (|NonNegativeInteger|)
                                          (|NonNegativeInteger|)
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| |#1|
                                                                           (|NonNegativeInteger|)))))
                                    (|:| AX
                                         (|Mapping| #1# (|NonNegativeInteger|)
                                                    (|Symbol|) #1#))
                                    (|:| C
                                         (|Mapping| (|List| |#1|)
                                                    (|NonNegativeInteger|))))
                                   (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 12))
                                     (|has| 6 (|RetractableTo| 12))))
                              '((|diffHP|
                                 ((|Mapping|
                                   (|Record|
                                    (|:| |degreeStream|
                                         (|Stream| (|NonNegativeInteger|)))
                                    (|:| |guessStream|
                                         (|Mapping|
                                          (|Stream|
                                           (|UnivariateFormalPowerSeries|
                                            |#1|))
                                          (|UnivariateFormalPowerSeries|
                                           |#1|)))
                                    (|:| |guessModGen|
                                         (|Mapping|
                                          (|Mapping| (|Vector| (|U32Vector|))
                                                     (|List| (|U32Vector|))
                                                     (|Integer|) (|Integer|))
                                          (|NonNegativeInteger|)))
                                    (|:| |testGen|
                                         (|Mapping|
                                          (|Mapping|
                                           (|Vector|
                                            (|UnivariateFormalPowerSeries|
                                             (|SparseMultivariatePolynomial|
                                              |#1| (|NonNegativeInteger|))))
                                           (|UnivariateFormalPowerSeries|
                                            (|SparseMultivariatePolynomial|
                                             |#1| (|NonNegativeInteger|))))
                                          (|List| (|PositiveInteger|))))
                                    (|:| |exprStream|
                                         (|Mapping| (|Stream| #1#) #1#
                                                    (|Symbol|)))
                                    (|:| |kind| (|Symbol|))
                                    (|:| |qvar| (|Symbol|))
                                    (|:| A
                                         (|Mapping| |#1| (|NonNegativeInteger|)
                                                    (|NonNegativeInteger|)
                                                    (|SparseUnivariatePolynomial|
                                                     |#1|)))
                                    (|:| AF
                                         (|Mapping|
                                          (|SparseMultivariatePolynomial| |#1|
                                                                          (|NonNegativeInteger|))
                                          (|NonNegativeInteger|)
                                          (|NonNegativeInteger|)
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| |#1|
                                                                           (|NonNegativeInteger|)))))
                                    (|:| AX
                                         (|Mapping| #1# (|NonNegativeInteger|)
                                                    (|Symbol|) #1#))
                                    (|:| C
                                         (|Mapping| (|List| |#1|)
                                                    (|NonNegativeInteger|))))
                                   (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 12))
                                     (|has| 6 (|RetractableTo| 12))))
                              '((|guessRec|
                                 ((|Mapping| (|List| #1#) (|List| |#1|)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 12))
                                     (|has| 6 (|RetractableTo| 12))))
                              '((|guessPRec|
                                 ((|Mapping| (|List| #1#) (|List| |#1|)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 12))
                                     (|has| 6 (|RetractableTo| 12))))
                              '((|guessRat|
                                 ((|Mapping| (|List| #1#) (|List| |#1|)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 12))
                                     (|has| 6 (|RetractableTo| 12))))
                              '((|guessADE|
                                 ((|Mapping| (|List| #1#) (|List| |#1|)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 12))
                                     (|has| 6 (|RetractableTo| 12))))
                              '((|guessHolo|
                                 ((|Mapping| (|List| #1#) (|List| |#1|)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 12))
                                     (|has| 6 (|RetractableTo| 12)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10 '(1 8 6 7 9 1 8 7 6 10)))))
           '|lookupIncomplete|)) 

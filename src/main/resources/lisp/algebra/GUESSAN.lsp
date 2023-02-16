
(DECLAIM (NOTINLINE |GuessAlgebraicNumber;|)) 

(DEFUN |GuessAlgebraicNumber| ()
  (SPROG NIL
         (PROG (#1=#:G717)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|GuessAlgebraicNumber|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|GuessAlgebraicNumber|
                             (LIST
                              (CONS NIL (CONS 1 (|GuessAlgebraicNumber;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|GuessAlgebraicNumber|)))))))))) 

(DEFUN |GuessAlgebraicNumber;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|GuessAlgebraicNumber|))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory|
                                               (|AlgebraicNumber|)
                                               '(|RetractableTo|
                                                 (|Symbol|)))))))
          (|haddProp| |$ConstructorCache| '|GuessAlgebraicNumber| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GuessAlgebraicNumber| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|Guess| 6 6 7 (NRTEVAL (ELT $ 8)) (NRTEVAL (ELT $ 9)))
              (|AlgebraicNumber|) (|Expression| (|Integer|)) (0 . |retract|)
              (5 . |coerce|) (|Mapping| 24 25 26) (|Symbol|)
              (|Mapping| (|Stream| (|UnivariateFormalPowerSeries| 6))
                         (|UnivariateFormalPowerSeries| 6))
              (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                         (|Integer|) (|Integer|))
              (|Mapping| 13 (|NonNegativeInteger|))
              (|Mapping|
               (|Vector|
                (|UnivariateFormalPowerSeries|
                 (|SparseMultivariatePolynomial| 6 (|NonNegativeInteger|))))
               (|UnivariateFormalPowerSeries|
                (|SparseMultivariatePolynomial| 6 (|NonNegativeInteger|))))
              (|Mapping| 15 (|List| (|PositiveInteger|)))
              (|Mapping| (|Stream| 7) 7 11)
              (|Mapping| 6 (|NonNegativeInteger|) (|NonNegativeInteger|)
                         (|SparseUnivariatePolynomial| 6))
              (|Mapping|
               (|SparseMultivariatePolynomial| 6 (|NonNegativeInteger|))
               (|NonNegativeInteger|) (|NonNegativeInteger|)
               (|UnivariateFormalPowerSeries|
                (|SparseMultivariatePolynomial| 6 (|NonNegativeInteger|))))
              (|Mapping| 7 (|NonNegativeInteger|) 11 7)
              (|Mapping| 25 (|NonNegativeInteger|))
              (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                        (|:| |guessStream| 12) (|:| |guessModGen| 14)
                        (|:| |testGen| 16) (|:| |exprStream| 17)
                        (|:| |kind| 11) (|:| |qvar| 11) (|:| A 18) (|:| AF 19)
                        (|:| AX 20) (|:| C 21))
              (|Mapping| 22 26) (|List| 7) (|List| 6) (|List| (|GuessOption|))
              (|List| 10) (|List| 11) (|List| 25))
           '#() 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|guess|
                                 ((|List| #1=(|Expression| (|Integer|)))
                                  (|List| #2=(|AlgebraicNumber|))))
                                T)
                              '((|guess|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guess|
                                 ((|List| #1#) (|List| #2#)
                                  (|List|
                                   (|Mapping| (|List| #1#) (|List| #2#)
                                              (|List| (|GuessOption|))))
                                  (|List| (|Symbol|))))
                                T)
                              '((|guess|
                                 ((|List| #1#) (|List| #2#)
                                  (|List|
                                   (|Mapping| (|List| #1#) (|List| #2#)
                                              (|List| (|GuessOption|))))
                                  (|List| (|Symbol|))
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessExpRat| ((|List| #1#) (|List| #2#))) T)
                              '((|guessExpRat|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessBinRat| ((|List| #1#) (|List| #2#))) T)
                              '((|guessBinRat|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessExpRat|
                                 ((|Mapping| (|List| #1#) (|List| #2#)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 11))
                                     (|has| 6 (|RetractableTo| 11))))
                              '((|guessBinRat|
                                 ((|Mapping| (|List| #1#) (|List| #2#)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 11))
                                     (|has| 6 (|RetractableTo| 11))))
                              '((|guessAlgDep|
                                 ((|List| #1#) (|List| (|List| #2#))))
                                T)
                              '((|guessAlgDep|
                                 ((|List| #1#) (|List| (|List| #2#))
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessADE| ((|List| #1#) (|List| #2#))) T)
                              '((|guessADE|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessFE| ((|List| #1#) (|List| #2#))) T)
                              '((|guessFE|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessAlg| ((|List| #1#) (|List| #2#))) T)
                              '((|guessAlg|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessHolo| ((|List| #1#) (|List| #2#))) T)
                              '((|guessHolo|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessPade|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessPade| ((|List| #1#) (|List| #2#))) T)
                              '((|guessRec| ((|List| #1#) (|List| #2#))) T)
                              '((|guessRec|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessPRec|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessPRec| ((|List| #1#) (|List| #2#))) T)
                              '((|guessRat|
                                 ((|List| #1#) (|List| #2#)
                                  (|List| (|GuessOption|))))
                                T)
                              '((|guessRat| ((|List| #1#) (|List| #2#))) T)
                              '((|algDepHP|
                                 ((|Record|
                                   (|:| |degreeStream|
                                        (|Stream| (|NonNegativeInteger|)))
                                   (|:| |guessStream|
                                        (|Mapping|
                                         (|Stream|
                                          (|UnivariateFormalPowerSeries| #2#))
                                         (|UnivariateFormalPowerSeries| #2#)))
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
                                            (|SparseMultivariatePolynomial| #2#
                                                                            (|NonNegativeInteger|))))
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| #2#
                                                                           (|NonNegativeInteger|))))
                                         (|List| (|PositiveInteger|))))
                                   (|:| |exprStream|
                                        (|Mapping| (|Stream| #1#) #1#
                                                   (|Symbol|)))
                                   (|:| |kind| (|Symbol|))
                                   (|:| |qvar| (|Symbol|))
                                   (|:| A
                                        (|Mapping| #3=(|AlgebraicNumber|)
                                                   (|NonNegativeInteger|)
                                                   (|NonNegativeInteger|)
                                                   (|SparseUnivariatePolynomial|
                                                    #3#)))
                                   (|:| AF
                                        (|Mapping|
                                         (|SparseMultivariatePolynomial| #2#
                                                                         (|NonNegativeInteger|))
                                         (|NonNegativeInteger|)
                                         (|NonNegativeInteger|)
                                         (|UnivariateFormalPowerSeries|
                                          (|SparseMultivariatePolynomial| #2#
                                                                          (|NonNegativeInteger|)))))
                                   (|:| AX
                                        (|Mapping| #1# (|NonNegativeInteger|)
                                                   (|Symbol|) #1#))
                                   (|:| C
                                        (|Mapping| (|List| #3#)
                                                   (|NonNegativeInteger|))))
                                  (|List| (|List| #2#))
                                  (|List| (|GuessOption|))))
                                T)
                              '((|diffHP|
                                 ((|Record|
                                   (|:| |degreeStream|
                                        (|Stream| (|NonNegativeInteger|)))
                                   (|:| |guessStream|
                                        (|Mapping|
                                         (|Stream|
                                          (|UnivariateFormalPowerSeries| #2#))
                                         (|UnivariateFormalPowerSeries| #2#)))
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
                                            (|SparseMultivariatePolynomial| #2#
                                                                            (|NonNegativeInteger|))))
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| #2#
                                                                           (|NonNegativeInteger|))))
                                         (|List| (|PositiveInteger|))))
                                   (|:| |exprStream|
                                        (|Mapping| (|Stream| #1#) #1#
                                                   (|Symbol|)))
                                   (|:| |kind| (|Symbol|))
                                   (|:| |qvar| (|Symbol|))
                                   (|:| A
                                        (|Mapping| #3# (|NonNegativeInteger|)
                                                   (|NonNegativeInteger|)
                                                   (|SparseUnivariatePolynomial|
                                                    #3#)))
                                   (|:| AF
                                        (|Mapping|
                                         (|SparseMultivariatePolynomial| #2#
                                                                         (|NonNegativeInteger|))
                                         (|NonNegativeInteger|)
                                         (|NonNegativeInteger|)
                                         (|UnivariateFormalPowerSeries|
                                          (|SparseMultivariatePolynomial| #2#
                                                                          (|NonNegativeInteger|)))))
                                   (|:| AX
                                        (|Mapping| #1# (|NonNegativeInteger|)
                                                   (|Symbol|) #1#))
                                   (|:| C
                                        (|Mapping| (|List| #3#)
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
                                          (|UnivariateFormalPowerSeries| #2#))
                                         (|UnivariateFormalPowerSeries| #2#)))
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
                                            (|SparseMultivariatePolynomial| #2#
                                                                            (|NonNegativeInteger|))))
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| #2#
                                                                           (|NonNegativeInteger|))))
                                         (|List| (|PositiveInteger|))))
                                   (|:| |exprStream|
                                        (|Mapping| (|Stream| #1#) #1#
                                                   (|Symbol|)))
                                   (|:| |kind| (|Symbol|))
                                   (|:| |qvar| (|Symbol|))
                                   (|:| A
                                        (|Mapping| #3# (|NonNegativeInteger|)
                                                   (|NonNegativeInteger|)
                                                   (|SparseUnivariatePolynomial|
                                                    #3#)))
                                   (|:| AF
                                        (|Mapping|
                                         (|SparseMultivariatePolynomial| #2#
                                                                         (|NonNegativeInteger|))
                                         (|NonNegativeInteger|)
                                         (|NonNegativeInteger|)
                                         (|UnivariateFormalPowerSeries|
                                          (|SparseMultivariatePolynomial| #2#
                                                                          (|NonNegativeInteger|)))))
                                   (|:| AX
                                        (|Mapping| #1# (|NonNegativeInteger|)
                                                   (|Symbol|) #1#))
                                   (|:| C
                                        (|Mapping| (|List| #3#)
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
                                          (|UnivariateFormalPowerSeries| #2#))
                                         (|UnivariateFormalPowerSeries| #2#)))
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
                                            (|SparseMultivariatePolynomial| #2#
                                                                            (|NonNegativeInteger|))))
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| #2#
                                                                           (|NonNegativeInteger|))))
                                         (|List| (|PositiveInteger|))))
                                   (|:| |exprStream|
                                        (|Mapping| (|Stream| #1#) #1#
                                                   (|Symbol|)))
                                   (|:| |kind| (|Symbol|))
                                   (|:| |qvar| (|Symbol|))
                                   (|:| A
                                        (|Mapping| #3# (|NonNegativeInteger|)
                                                   (|NonNegativeInteger|)
                                                   (|SparseUnivariatePolynomial|
                                                    #3#)))
                                   (|:| AF
                                        (|Mapping|
                                         (|SparseMultivariatePolynomial| #2#
                                                                         (|NonNegativeInteger|))
                                         (|NonNegativeInteger|)
                                         (|NonNegativeInteger|)
                                         (|UnivariateFormalPowerSeries|
                                          (|SparseMultivariatePolynomial| #2#
                                                                          (|NonNegativeInteger|)))))
                                   (|:| AX
                                        (|Mapping| #1# (|NonNegativeInteger|)
                                                   (|Symbol|) #1#))
                                   (|:| C
                                        (|Mapping| (|List| #3#)
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
                                           (|UnivariateFormalPowerSeries| #2#))
                                          (|UnivariateFormalPowerSeries| #2#)))
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
                                              #2# (|NonNegativeInteger|))))
                                           (|UnivariateFormalPowerSeries|
                                            (|SparseMultivariatePolynomial| #2#
                                                                            (|NonNegativeInteger|))))
                                          (|List| (|PositiveInteger|))))
                                    (|:| |exprStream|
                                         (|Mapping| (|Stream| #1#) #1#
                                                    (|Symbol|)))
                                    (|:| |kind| (|Symbol|))
                                    (|:| |qvar| (|Symbol|))
                                    (|:| A
                                         (|Mapping| #3# (|NonNegativeInteger|)
                                                    (|NonNegativeInteger|)
                                                    (|SparseUnivariatePolynomial|
                                                     #3#)))
                                    (|:| AF
                                         (|Mapping|
                                          (|SparseMultivariatePolynomial| #2#
                                                                          (|NonNegativeInteger|))
                                          (|NonNegativeInteger|)
                                          (|NonNegativeInteger|)
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| #2#
                                                                           (|NonNegativeInteger|)))))
                                    (|:| AX
                                         (|Mapping| #1# (|NonNegativeInteger|)
                                                    (|Symbol|) #1#))
                                    (|:| C
                                         (|Mapping| (|List| #3#)
                                                    (|NonNegativeInteger|))))
                                   (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 11))
                                     (|has| 6 (|RetractableTo| 11))))
                              '((|diffHP|
                                 ((|Mapping|
                                   (|Record|
                                    (|:| |degreeStream|
                                         (|Stream| (|NonNegativeInteger|)))
                                    (|:| |guessStream|
                                         (|Mapping|
                                          (|Stream|
                                           (|UnivariateFormalPowerSeries| #2#))
                                          (|UnivariateFormalPowerSeries| #2#)))
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
                                              #2# (|NonNegativeInteger|))))
                                           (|UnivariateFormalPowerSeries|
                                            (|SparseMultivariatePolynomial| #2#
                                                                            (|NonNegativeInteger|))))
                                          (|List| (|PositiveInteger|))))
                                    (|:| |exprStream|
                                         (|Mapping| (|Stream| #1#) #1#
                                                    (|Symbol|)))
                                    (|:| |kind| (|Symbol|))
                                    (|:| |qvar| (|Symbol|))
                                    (|:| A
                                         (|Mapping| #3# (|NonNegativeInteger|)
                                                    (|NonNegativeInteger|)
                                                    (|SparseUnivariatePolynomial|
                                                     #3#)))
                                    (|:| AF
                                         (|Mapping|
                                          (|SparseMultivariatePolynomial| #2#
                                                                          (|NonNegativeInteger|))
                                          (|NonNegativeInteger|)
                                          (|NonNegativeInteger|)
                                          (|UnivariateFormalPowerSeries|
                                           (|SparseMultivariatePolynomial| #2#
                                                                           (|NonNegativeInteger|)))))
                                    (|:| AX
                                         (|Mapping| #1# (|NonNegativeInteger|)
                                                    (|Symbol|) #1#))
                                    (|:| C
                                         (|Mapping| (|List| #3#)
                                                    (|NonNegativeInteger|))))
                                   (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 11))
                                     (|has| 6 (|RetractableTo| 11))))
                              '((|guessRec|
                                 ((|Mapping| (|List| #1#) (|List| #2#)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 11))
                                     (|has| 6 (|RetractableTo| 11))))
                              '((|guessPRec|
                                 ((|Mapping| (|List| #1#) (|List| #2#)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 11))
                                     (|has| 6 (|RetractableTo| 11))))
                              '((|guessRat|
                                 ((|Mapping| (|List| #1#) (|List| #2#)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 11))
                                     (|has| 6 (|RetractableTo| 11))))
                              '((|guessADE|
                                 ((|Mapping| (|List| #1#) (|List| #2#)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 11))
                                     (|has| 6 (|RetractableTo| 11))))
                              '((|guessHolo|
                                 ((|Mapping| (|List| #1#) (|List| #2#)
                                             (|List| (|GuessOption|)))
                                  (|Symbol|)))
                                (AND (|has| 6 (|RetractableTo| 11))
                                     (|has| 6 (|RetractableTo| 11)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 9 '(1 7 6 0 8 1 7 0 6 9)))))
           '|lookupIncomplete|)) 

(MAKEPROP '|GuessAlgebraicNumber| 'NILADIC T) 

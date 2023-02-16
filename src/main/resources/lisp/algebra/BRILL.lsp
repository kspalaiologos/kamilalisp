
(SDEFUN |BRILL;squaredPolynomial| ((|p| (UP)) ($ (|Boolean|)))
        (SPROG ((|d| (|NonNegativeInteger|)))
               (SEQ (LETT |d| (SPADCALL |p| (QREFELT $ 8)))
                    (EXIT
                     (COND ((EQL |d| 0) 'T) ((ODDP |d|) NIL)
                           ('T
                            (|BRILL;squaredPolynomial|
                             (SPADCALL |p| (QREFELT $ 10)) $))))))) 

(SDEFUN |BRILL;primeEnough?|
        ((|n| (|Integer|)) (|b| (|Integer|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G721 NIL) (#2=#:G722 NIL) (|bb| (|Float|)) (#3=#:G714 NIL)
          (|d| (|Union| (|Integer|) #4="failed")) (#5=#:G723 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |bb| (SPADCALL |b| (QREFELT $ 13)))
                (SEQ (LETT |i| 2) (LETT #5# |b|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ G190
                            (COND
                             ((NULL
                               (QEQCAR
                                (LETT |d| (SPADCALL |n| |i| (QREFELT $ 15)))
                                0))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ
                               (LETT |n|
                                     (PROG2 (LETT #3# |d|)
                                         (QCDR #3#)
                                       (|check_union2| (QEQCAR #3# 0)
                                                       (|Integer|)
                                                       (|Union| (|Integer|)
                                                                #4#)
                                                       #3#)))
                               (LETT |bb|
                                     (SPADCALL |bb|
                                               (SPADCALL |i| (QREFELT $ 13))
                                               (QREFELT $ 16)))
                               (EXIT
                                (COND
                                 ((SPADCALL |bb| (|spadConstant| $ 17)
                                            (QREFELT $ 19))
                                  (PROGN
                                   (LETT #1#
                                         (PROGN (LETT #2# NIL) (GO #6=#:G720)))
                                   (GO #7=#:G716)))))))
                             #7# (EXIT #1#))
                            NIL (GO G190) G191 (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL |n| (QREFELT $ 20)))))
          #6# (EXIT #2#)))) 

(SDEFUN |BRILL;brillhartTrials;Nni;3| (($ (|NonNegativeInteger|)))
        (QREFELT $ 21)) 

(SDEFUN |BRILL;brillhartTrials;2Nni;4|
        ((|n| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((|#G9| (|NonNegativeInteger|)) (|#G8| (|NonNegativeInteger|)))
               (SEQ
                (PROGN
                 (LETT |#G8| |n|)
                 (LETT |#G9| (QREFELT $ 21))
                 (SETELT $ 21 |#G8|)
                 (LETT |n| |#G9|))
                (EXIT |n|)))) 

(SDEFUN |BRILL;brillhartIrreducible?;UPB;5| ((|p| (UP)) ($ (|Boolean|)))
        (SPADCALL |p| (SPADCALL |p| (QREFELT $ 24)) (QREFELT $ 25))) 

(SDEFUN |BRILL;brillhartIrreducible?;UP2B;6|
        ((|p| (UP)) (|noLinears| (|Boolean|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G746 NIL) (#2=#:G747 NIL) (|small| (|Integer|)) (#3=#:G748 NIL)
          (|i| NIL) (|count| #4=(|Integer|)) (|largeEnough| #4#)
          (|polyx2| (|Boolean|)) (|even1| #5=(|Boolean|)) (|even0| #5#)
          (|origBound| #4#))
         (SEQ
          (EXIT
           (COND ((ZEROP (QREFELT $ 21)) NIL)
                 (#6='T
                  (SEQ
                   (LETT |origBound|
                         (LETT |largeEnough|
                               (+ (SPADCALL |p| (QREFELT $ 28)) 1)))
                   (LETT |even0| (EVENP (SPADCALL |p| 0 (QREFELT $ 29))))
                   (LETT |even1| (EVENP (SPADCALL |p| 1 (QREFELT $ 31))))
                   (LETT |polyx2| (|BRILL;squaredPolynomial| |p| $))
                   (EXIT
                    (COND
                     ((SPADCALL (SPADCALL |p| |largeEnough| (QREFELT $ 31))
                                (QREFELT $ 20))
                      'T)
                     (#6#
                      (SEQ
                       (COND
                        ((NULL |polyx2|)
                         (COND
                          ((SPADCALL
                            (SPADCALL |p| (- |largeEnough|) (QREFELT $ 31))
                            (QREFELT $ 20))
                           (EXIT 'T)))))
                       (EXIT
                        (COND ((EQL (QREFELT $ 21) 1) NIL)
                              (#6#
                               (SEQ (LETT |largeEnough| (+ |largeEnough| 1))
                                    (EXIT
                                     (COND
                                      ((|BRILL;primeEnough?|
                                        (SPADCALL |p| |largeEnough|
                                                  (QREFELT $ 31))
                                        (COND (|noLinears| 4) (#6# 2)) $)
                                       'T)
                                      (#6#
                                       (SEQ
                                        (COND
                                         ((NULL |polyx2|)
                                          (COND
                                           ((|BRILL;primeEnough?|
                                             (SPADCALL |p| (- |largeEnough|)
                                                       (QREFELT $ 31))
                                             (COND (|noLinears| 4) (#6# 2)) $)
                                            (EXIT 'T)))))
                                        (COND
                                         ((ODDP |largeEnough|)
                                          (COND
                                           (|even0|
                                            (LETT |largeEnough|
                                                  (+ |largeEnough| 1)))))
                                         (|even1|
                                          (LETT |largeEnough|
                                                (+ |largeEnough| 1))))
                                        (LETT |count|
                                              (+
                                               (* (COND (|polyx2| 2) (#6# 1))
                                                  (- (QREFELT $ 21) 2))
                                               |largeEnough|))
                                        (SEQ (LETT |i| (+ |largeEnough| 1))
                                             (LETT #3# |count|) G190
                                             (COND ((> |i| #3#) (GO G191)))
                                             (SEQ
                                              (LETT |small|
                                                    (COND
                                                     (|noLinears|
                                                      (EXPT (- |i| |origBound|)
                                                            2))
                                                     ('T (- |i| |origBound|))))
                                              (EXIT
                                               (COND
                                                ((|BRILL;primeEnough?|
                                                  (SPADCALL |p| |i|
                                                            (QREFELT $ 31))
                                                  |small| $)
                                                 (PROGN
                                                  (LETT #2# 'T)
                                                  (GO #7=#:G745)))
                                                ((NULL |polyx2|)
                                                 (SEQ
                                                  (EXIT
                                                   (COND
                                                    ((|BRILL;primeEnough?|
                                                      (SPADCALL |p| (- |i|)
                                                                (QREFELT $ 31))
                                                      |small| $)
                                                     (PROGN
                                                      (LETT #1#
                                                            (PROGN
                                                             (LETT #2# 'T)
                                                             (GO #7#)))
                                                      (GO #8=#:G737)))))
                                                  #8# (EXIT #1#))))))
                                             (LETT |i| (+ |i| 1)) (GO G190)
                                             G191 (EXIT NIL))
                                        (EXIT NIL)))))))))))))))))
          #7# (EXIT #2#)))) 

(SDEFUN |BRILL;noLinearFactor?;UPB;7| ((|p| (UP)) ($ (|Boolean|)))
        (COND
         ((ODDP (SPADCALL |p| (QREFELT $ 32)))
          (COND
           ((ODDP (SPADCALL |p| 0 (QREFELT $ 29)))
            (ODDP (SPADCALL |p| 1 (QREFELT $ 31))))
           (#1='T NIL)))
         (#1# NIL))) 

(DECLAIM (NOTINLINE |BrillhartTests;|)) 

(DEFUN |BrillhartTests| (#1=#:G752)
  (SPROG NIL
         (PROG (#2=#:G753)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|BrillhartTests|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|BrillhartTests;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|BrillhartTests|)))))))))) 

(DEFUN |BrillhartTests;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|BrillhartTests| DV$1))
          (LETT $ (GETREFV 33))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|BrillhartTests| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 21 6)
          $))) 

(MAKEPROP '|BrillhartTests| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              (0 . |degree|) (5 . |Zero|) (9 . |reductum|) (|Integer|)
              (|Float|) (14 . |coerce|) (|Union| $ '"failed") (19 . |exquo|)
              (25 . /) (31 . |One|) (|Boolean|) (35 . <) (41 . |prime?|)
              '|brillharttrials| |BRILL;brillhartTrials;Nni;3|
              |BRILL;brillhartTrials;2Nni;4| |BRILL;noLinearFactor?;UPB;7|
              |BRILL;brillhartIrreducible?;UP2B;6|
              |BRILL;brillhartIrreducible?;UPB;5|
              (|GaloisGroupFactorizationUtilities| 11 6 12) (46 . |rootBound|)
              (51 . |coefficient|) (57 . |One|) (61 . |elt|)
              (67 . |leadingCoefficient|))
           '#(|noLinearFactor?| 72 |brillhartTrials| 77 |brillhartIrreducible?|
              86)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|brillhartIrreducible?| ((|Boolean|) |#1|)) T)
                              '((|brillhartIrreducible?|
                                 ((|Boolean|) |#1| (|Boolean|)))
                                T)
                              '((|brillhartTrials| ((|NonNegativeInteger|))) T)
                              '((|brillhartTrials|
                                 ((|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|noLinearFactor?| ((|Boolean|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 32
                                            '(1 6 7 0 8 0 6 0 9 1 6 0 0 10 1 12
                                              0 11 13 2 11 14 0 0 15 2 12 0 0 0
                                              16 0 12 0 17 2 12 18 0 0 19 1 11
                                              18 0 20 1 27 11 6 28 2 6 11 0 7
                                              29 0 6 0 30 2 6 11 0 11 31 1 6 11
                                              0 32 1 0 18 6 24 0 0 7 22 1 0 7 7
                                              23 2 0 18 6 18 25 1 0 18 6
                                              26)))))
           '|lookupComplete|)) 

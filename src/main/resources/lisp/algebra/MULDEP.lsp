
(SDEFUN |MULDEP;solveOverQ|
        ((|m| (|Matrix| (|Fraction| (|Integer|))))
         (|v| (|Vector| (|Fraction| (|Integer|))))
         ($ (|Union| (|Vector| (|Fraction| (|Integer|))) "failed")))
        (SPADCALL |m| |v| (QREFELT $ 10))) 

(SDEFUN |MULDEP;logDependenceQ;LFU;2|
        ((|lq| (|List| (|Fraction| (|Integer|))))
         (|q| (|Fraction| (|Integer|)))
         ($ (|Union| (|Vector| (|Fraction| (|Integer|))) "failed")))
        (SPROG
         ((|qv| #1=(|Vector| (|Fraction| (|Integer|)))) (#2=#:G742 NIL)
          (|i| NIL) (#3=#:G741 NIL) (|m| (|Matrix| (|Fraction| (|Integer|))))
          (#4=#:G740 NIL) (|j| NIL) (#5=#:G739 NIL) (#6=#:G738 NIL)
          (#7=#:G737 NIL) (|tm| #8=(|Matrix| (|Integer|)))
          (|li| (|List| (|NonNegativeInteger|))) (#9=#:G736 NIL)
          (#10=#:G735 NIL) (|k0| (|NonNegativeInteger|))
          (|bas| #11=(|Vector| (|Integer|)))
          (|dr| (|Record| (|:| |basis| #11#) (|:| |transform| #8#))) (|v| #1#)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND ((NULL |lq|) (CONS 1 "failed"))
                (#12='T
                 (SEQ (LETT |n| (LENGTH |lq|))
                      (LETT |v|
                            (SPADCALL (SPADCALL |lq| (LIST |q|) (QREFELT $ 12))
                                      (QREFELT $ 13)))
                      (LETT |dr| (SPADCALL |v| (QREFELT $ 16)))
                      (LETT |bas| (QCAR |dr|)) (LETT |k0| (QVSIZE |bas|))
                      (LETT |li|
                            (PROGN
                             (LETT #10# NIL)
                             (SEQ (LETT |i| 1) (LETT #9# |k0|) G190
                                  (COND ((|greater_SI| |i| #9#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((NULL
                                       (SPADCALL
                                        (SPADCALL |bas| |i| (QREFELT $ 19))
                                        (QREFELT $ 21)))
                                      (LETT #10# (CONS |i| #10#))))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT (NREVERSE #10#)))))
                      (EXIT
                       (COND ((NULL |li|) (CONS 1 "failed"))
                             (#12#
                              (SEQ (LETT |tm| (QCDR |dr|))
                                   (LETT |m|
                                         (SPADCALL
                                          (PROGN
                                           (LETT #7# NIL)
                                           (SEQ (LETT |i| NIL) (LETT #6# |li|)
                                                G190
                                                (COND
                                                 ((OR (ATOM #6#)
                                                      (PROGN
                                                       (LETT |i| (CAR #6#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #7#
                                                        (CONS
                                                         (PROGN
                                                          (LETT #5# NIL)
                                                          (SEQ (LETT |j| 1)
                                                               (LETT #4# |n|)
                                                               G190
                                                               (COND
                                                                ((|greater_SI|
                                                                  |j| #4#)
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT #5#
                                                                       (CONS
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          |tm|
                                                                          |i|
                                                                          |j|
                                                                          (QREFELT
                                                                           $
                                                                           23))
                                                                         (QREFELT
                                                                          $
                                                                          25))
                                                                        #5#))))
                                                               (LETT |j|
                                                                     (|inc_SI|
                                                                      |j|))
                                                               (GO G190) G191
                                                               (EXIT
                                                                (NREVERSE
                                                                 #5#))))
                                                         #7#))))
                                                (LETT #6# (CDR #6#)) (GO G190)
                                                G191 (EXIT (NREVERSE #7#))))
                                          (QREFELT $ 27)))
                                   (LETT |qv|
                                         (SPADCALL
                                          (PROGN
                                           (LETT #3# NIL)
                                           (SEQ (LETT |i| NIL) (LETT #2# |li|)
                                                G190
                                                (COND
                                                 ((OR (ATOM #2#)
                                                      (PROGN
                                                       (LETT |i| (CAR #2#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #3#
                                                        (CONS
                                                         (SPADCALL
                                                          (SPADCALL |tm| |i|
                                                                    (+ |n| 1)
                                                                    (QREFELT $
                                                                             23))
                                                          (QREFELT $ 25))
                                                         #3#))))
                                                (LETT #2# (CDR #2#)) (GO G190)
                                                G191 (EXIT (NREVERSE #3#))))
                                          (QREFELT $ 13)))
                                   (EXIT
                                    (|MULDEP;solveOverQ| |m| |qv| $)))))))))))) 

(DECLAIM (NOTINLINE |MultiplicativeDependence;|)) 

(DEFUN |MultiplicativeDependence| ()
  (SPROG NIL
         (PROG (#1=#:G744)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|MultiplicativeDependence|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|MultiplicativeDependence|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|MultiplicativeDependence;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|MultiplicativeDependence|)))))))))) 

(DEFUN |MultiplicativeDependence;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|MultiplicativeDependence|))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MultiplicativeDependence| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MultiplicativeDependence| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Union| 8 '"failed") (|Matrix| 24)
              (|Vector| 24) (|LinearSystemMatrixPackage| 24 8 8 7)
              (0 . |particularSolution|) (|List| 24) (6 . |concat|)
              (12 . |vector|) (|Record| (|:| |basis| 18) (|:| |transform| 22))
              (|GcdBasis| 17) (17 . |gcdDecomposition|) (|Integer|)
              (|Vector| 17) (22 . |elt|) (|Boolean|) (28 . |unit?|)
              (|Matrix| 17) (33 . |elt|) (|Fraction| 17) (40 . |coerce|)
              (|List| 11) (45 . |matrix|) (50 . |One|)
              |MULDEP;logDependenceQ;LFU;2|)
           '#(|logDependenceQ| 54) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|logDependenceQ|
                                 ((|Union| (|Vector| (|Fraction| (|Integer|)))
                                           "failed")
                                  (|List| (|Fraction| (|Integer|)))
                                  (|Fraction| (|Integer|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 29
                                            '(2 9 6 7 8 10 2 11 0 0 0 12 1 8 0
                                              11 13 1 15 14 8 16 2 18 17 0 17
                                              19 1 17 20 0 21 3 22 17 0 17 17
                                              23 1 24 0 17 25 1 7 0 26 27 0 24
                                              0 28 2 0 6 11 24 29)))))
           '|lookupComplete|)) 

(MAKEPROP '|MultiplicativeDependence| 'NILADIC T) 

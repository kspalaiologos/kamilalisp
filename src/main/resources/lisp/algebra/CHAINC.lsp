
(PUT '|CHAINC;chainComplex;L$;1| '|SPADreplace| '(XLAM (|v|) |v|)) 

(SDEFUN |CHAINC;chainComplex;L$;1|
        ((|v| (|List| (|Matrix| (|Integer|)))) ($ ($))) |v|) 

(PUT '|CHAINC;transition_matrices;$L;2| '|SPADreplace| '(XLAM (|a|) |a|)) 

(SDEFUN |CHAINC;transition_matrices;$L;2|
        ((|a| ($)) ($ (|List| (|Matrix| (|Integer|))))) |a|) 

(SDEFUN |CHAINC;validate;$B;3| ((|a| ($)) ($ (|Boolean|)))
        (SPROG
         ((|last| #1=(|Matrix| (|Integer|))) (#2=#:G722 NIL)
          (|prod| (|Matrix| (|Integer|))) (|m| #1#) (#3=#:G723 NIL) (|x| NIL)
          (|len| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |len| (LENGTH |a|))
                (COND ((< |len| 2) (PROGN (LETT #2# 'T) (GO #4=#:G721))))
                (LETT |last| (SPADCALL |a| 1 (QREFELT $ 12)))
                (SEQ (LETT |x| 2) (LETT #3# |len|) G190
                     (COND ((|greater_SI| |x| #3#) (GO G191)))
                     (SEQ (LETT |m| (SPADCALL |a| |x| (QREFELT $ 12)))
                          (COND
                           ((SPADCALL (SPADCALL |m| (QREFELT $ 13))
                                      (SPADCALL |last| (QREFELT $ 14))
                                      (QREFELT $ 16))
                            (SEQ
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL "validate failed nRows="
                                           (QREFELT $ 19))
                                 (SPADCALL (SPADCALL |m| (QREFELT $ 13))
                                           (QREFELT $ 20))
                                 (QREFELT $ 21))
                                (SPADCALL " not equal to nCols "
                                          (QREFELT $ 19))
                                (QREFELT $ 21))
                               (SPADCALL (SPADCALL |last| (QREFELT $ 14))
                                         (QREFELT $ 20))
                               (QREFELT $ 21))
                              (QREFELT $ 23))
                             (EXIT (PROGN (LETT #2# NIL) (GO #4#))))))
                          (LETT |prod| (SPADCALL |last| |m| (QREFELT $ 24)))
                          (COND
                           ((NULL (SPADCALL |prod| (QREFELT $ 25)))
                            (SEQ
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL
                                    "validate failed: product of adjacent maps should be zero"
                                    (QREFELT $ 19))
                                   (SPADCALL |last| (QREFELT $ 26))
                                   (QREFELT $ 21))
                                  (SPADCALL " * " (QREFELT $ 19))
                                  (QREFELT $ 21))
                                 (SPADCALL |m| (QREFELT $ 26)) (QREFELT $ 21))
                                (SPADCALL " = " (QREFELT $ 19)) (QREFELT $ 21))
                               (SPADCALL |prod| (QREFELT $ 26)) (QREFELT $ 21))
                              (QREFELT $ 23))
                             (EXIT (PROGN (LETT #2# NIL) (GO #4#))))))
                          (EXIT (LETT |last| |m|)))
                     (LETT |x| (|inc_SI| |x|)) (GO G190) G191 (EXIT NIL))
                (EXIT 'T)))
          #4# (EXIT #2#)))) 

(SDEFUN |CHAINC;homology;$L;4| ((|a| ($)) ($ (|List| (|Homology|))))
        (SPROG
         ((|prev| (|Matrix| (|Integer|))) (|notFirst| (|Boolean|))
          (|res| (|List| (|Homology|))) (|m2| (|Homology|)) (#1=#:G730 NIL)
          (|m1| NIL))
         (SEQ (LETT |res| NIL) (LETT |prev| (MAKE_MATRIX 0 0))
              (LETT |notFirst| NIL)
              (SEQ (LETT |m1| NIL) (LETT #1# |a|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |m1| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     (|notFirst|
                      (SEQ (LETT |m2| (SPADCALL |m1| |prev| (QREFELT $ 29)))
                           (EXIT
                            (LETT |res|
                                  (SPADCALL |res| |m2| (QREFELT $ 31)))))))
                    (LETT |notFirst| 'T) (EXIT (LETT |prev| |m1|)))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |CHAINC;coerce;$Of;5| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|lst| (|List| (|OutputForm|))) (#1=#:G736 NIL) (|x| NIL)
          (#2=#:G735 NIL))
         (SEQ
          (LETT |lst|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# |s|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |x| (QREFELT $ 26)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL |lst| (QREFELT $ 34)))))) 

(DECLAIM (NOTINLINE |ChainComplex;|)) 

(DEFUN |ChainComplex| ()
  (SPROG NIL
         (PROG (#1=#:G738)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ChainComplex|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ChainComplex|
                             (LIST (CONS NIL (CONS 1 (|ChainComplex;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|ChainComplex|)))))))))) 

(DEFUN |ChainComplex;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ChainComplex|))
          (LETT $ (GETREFV 38))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ChainComplex| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|List| (|Matrix| (|Integer|))))
          $))) 

(MAKEPROP '|ChainComplex| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|List| 10)
              |CHAINC;chainComplex;L$;1| |CHAINC;transition_matrices;$L;2|
              (|Matrix| 11) (|Integer|) (0 . |elt|) (6 . |maxRowIndex|)
              (11 . |maxColIndex|) (|Boolean|) (16 . ~=) (|String|)
              (|OutputForm|) (22 . |message|) (27 . |coerce|) (32 . |hconcat|)
              (|Void|) (38 . |print|) (43 . *) (49 . |zero?|) (54 . |coerce|)
              |CHAINC;validate;$B;3| (|Homology|) (59 . |homologyGroup|)
              (|List| 28) (65 . |concat|) |CHAINC;homology;$L;4| (|List| $)
              (71 . |commaSeparate|) |CHAINC;coerce;$Of;5| (|SingleInteger|)
              (|HashState|))
           '#(~= 76 |validate| 82 |transition_matrices| 87 |latex| 92
              |homology| 97 |hashUpdate!| 102 |hash| 108 |coerce| 113
              |chainComplex| 118 = 123)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 18))
                        (|makeByteWordVec2| 37
                                            '(2 6 10 0 11 12 1 10 11 0 13 1 10
                                              11 0 14 2 11 15 0 0 16 1 18 0 17
                                              19 1 11 18 0 20 2 18 0 0 0 21 1
                                              18 22 0 23 2 10 0 0 0 24 1 10 15
                                              0 25 1 10 18 0 26 2 28 0 10 10 29
                                              2 30 0 0 28 31 1 18 0 33 34 2 0
                                              15 0 0 1 1 0 15 0 27 1 0 7 0 9 1
                                              0 17 0 1 1 0 30 0 32 2 0 37 37 0
                                              1 1 0 36 0 1 1 0 18 0 35 1 0 0 7
                                              8 2 0 15 0 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|ChainComplex| 'NILADIC T) 

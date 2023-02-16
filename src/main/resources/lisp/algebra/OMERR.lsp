
(SDEFUN |OMERR;coerce;$Of;1| ((|e| ($)) ($ (|OutputForm|)))
        (SPROG ((|infoSize| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((SPADCALL (QCAR |e|) (QREFELT $ 9))
                  (SPADCALL "Error parsing OpenMath object" (QREFELT $ 12)))
                 (#1='T
                  (SEQ (LETT |infoSize| (LENGTH (QCDR |e|)))
                       (EXIT
                        (COND
                         ((SPADCALL (QCAR |e|) (QREFELT $ 13))
                          (COND
                           ((EQL |infoSize| 1)
                            (SPADCALL
                             (STRCONC "Cannot handle CD "
                                      (SPADCALL (|SPADfirst| (QCDR |e|))
                                                (QREFELT $ 15)))
                             (QREFELT $ 12)))
                           (#1#
                            (|error| "Malformed info list in OMUnknownCD"))))
                         ((SPADCALL (QCAR |e|) (QREFELT $ 16))
                          (COND
                           ((EQL 2 |infoSize|)
                            (SPADCALL
                             (SPADCALL
                              (LIST "Cannot handle Symbol "
                                    (SPADCALL
                                     (SPADCALL (QCDR |e|) 2 (QREFELT $ 19))
                                     (QREFELT $ 15))
                                    " from CD "
                                    (SPADCALL
                                     (SPADCALL (QCDR |e|) 1 (QREFELT $ 19))
                                     (QREFELT $ 15)))
                              (QREFELT $ 21))
                             (QREFELT $ 12)))
                           (#1#
                            (|error|
                             "Malformed info list in OMUnknownSymbol"))))
                         ((SPADCALL (QCAR |e|) (QREFELT $ 22))
                          (SPADCALL "OpenMath read error" (QREFELT $ 12)))
                         (#1# (|error| "Malformed OpenMath Error")))))))))) 

(PUT '|OMERR;omError;OmekL$;2| '|SPADreplace| 'CONS) 

(SDEFUN |OMERR;omError;OmekL$;2|
        ((|e| (|OpenMathErrorKind|)) (|i| (|List| (|Symbol|))) ($ ($)))
        (CONS |e| |i|)) 

(PUT '|OMERR;errorKind;$Omek;3| '|SPADreplace| 'QCAR) 

(SDEFUN |OMERR;errorKind;$Omek;3| ((|e| ($)) ($ (|OpenMathErrorKind|)))
        (QCAR |e|)) 

(PUT '|OMERR;errorInfo;$L;4| '|SPADreplace| 'QCDR) 

(SDEFUN |OMERR;errorInfo;$L;4| ((|e| ($)) ($ (|List| (|Symbol|)))) (QCDR |e|)) 

(DECLAIM (NOTINLINE |OpenMathError;|)) 

(DEFUN |OpenMathError| ()
  (SPROG NIL
         (PROG (#1=#:G729)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OpenMathError|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OpenMathError|
                             (LIST (CONS NIL (CONS 1 (|OpenMathError;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|OpenMathError|)))))))))) 

(DEFUN |OpenMathError;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OpenMathError|))
          (LETT $ (GETREFV 29))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OpenMathError| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |err| (|OpenMathErrorKind|))
                              (|:| |info| (|List| (|Symbol|)))))
          $))) 

(MAKEPROP '|OpenMathError| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Boolean|) (|OpenMathErrorKind|)
              (0 . |OMParseError?|) (|String|) (|OutputForm|) (5 . |message|)
              (10 . |OMUnknownCD?|) (|Symbol|) (15 . |string|)
              (20 . |OMUnknownSymbol?|) (|Integer|) (|List| 14) (25 . |elt|)
              (|List| $) (31 . |concat|) (36 . |OMReadError?|)
              |OMERR;coerce;$Of;1| |OMERR;omError;OmekL$;2|
              |OMERR;errorKind;$Omek;3| |OMERR;errorInfo;$L;4|
              (|SingleInteger|) (|HashState|))
           '#(~= 41 |omError| 47 |latex| 53 |hashUpdate!| 58 |hash| 64
              |errorKind| 69 |errorInfo| 74 |coerce| 79 = 84)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 11))
                        (|makeByteWordVec2| 28
                                            '(1 8 7 0 9 1 11 0 10 12 1 8 7 0 13
                                              1 14 10 0 15 1 8 7 0 16 2 18 14 0
                                              17 19 1 10 0 20 21 1 8 7 0 22 2 0
                                              7 0 0 1 2 0 0 8 18 24 1 0 10 0 1
                                              2 0 28 28 0 1 1 0 27 0 1 1 0 8 0
                                              25 1 0 18 0 26 1 0 11 0 23 2 0 7
                                              0 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|OpenMathError| 'NILADIC T) 

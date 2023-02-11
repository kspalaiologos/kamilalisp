
(PUT '|OMERRK;OMParseError?;$B;1| '|SPADreplace| '(XLAM (|u|) (QEQCAR |u| 0))) 

(SDEFUN |OMERRK;OMParseError?;$B;1| ((|u| ($)) ($ (|Boolean|))) (QEQCAR |u| 0)) 

(PUT '|OMERRK;OMUnknownCD?;$B;2| '|SPADreplace| '(XLAM (|u|) (QEQCAR |u| 1))) 

(SDEFUN |OMERRK;OMUnknownCD?;$B;2| ((|u| ($)) ($ (|Boolean|))) (QEQCAR |u| 1)) 

(PUT '|OMERRK;OMUnknownSymbol?;$B;3| '|SPADreplace|
     '(XLAM (|u|) (QEQCAR |u| 2))) 

(SDEFUN |OMERRK;OMUnknownSymbol?;$B;3| ((|u| ($)) ($ (|Boolean|)))
        (QEQCAR |u| 2)) 

(PUT '|OMERRK;OMReadError?;$B;4| '|SPADreplace| '(XLAM (|u|) (QEQCAR |u| 3))) 

(SDEFUN |OMERRK;OMReadError?;$B;4| ((|u| ($)) ($ (|Boolean|))) (QEQCAR |u| 3)) 

(SDEFUN |OMERRK;coerce;S$;5| ((|s| (|Symbol|)) ($ ($)))
        (COND ((EQUAL |s| '|OMParseError|) (CONS 0 "OMParseError"))
              ((EQUAL |s| '|OMUnknownCD|) (CONS 1 "OMUnknownCD"))
              ((EQUAL |s| '|OMUnknownSymbol|) (CONS 2 "OMUnknownSymbol"))
              ((EQUAL |s| '|OMReadError|) (CONS 3 "OMReadError"))
              ('T
               (|error|
                (STRCONC (SPADCALL |s| (QREFELT $ 14))
                         " is not a valid OpenMathErrorKind."))))) 

(SDEFUN |OMERRK;=;2$B;6| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPADCALL |a| |b| (QREFELT $ 16))) 

(SDEFUN |OMERRK;coerce;$Of;7| ((|e| ($)) ($ (|OutputForm|)))
        (SPADCALL |e| (QREFELT $ 19))) 

(DECLAIM (NOTINLINE |OpenMathErrorKind;|)) 

(DEFUN |OpenMathErrorKind| ()
  (SPROG NIL
         (PROG (#1=#:G727)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OpenMathErrorKind|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OpenMathErrorKind|
                             (LIST
                              (CONS NIL (CONS 1 (|OpenMathErrorKind;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|OpenMathErrorKind|)))))))))) 

(DEFUN |OpenMathErrorKind;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OpenMathErrorKind|))
          (LETT $ (GETREFV 23))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OpenMathErrorKind| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Union| (|:| |parseError| "OMParseError")
                             (|:| |unknownCD| "OMUnknownCD")
                             (|:| |unknownSymbol| "OMUnknownSymbol")
                             (|:| |readError| "OMReadError")))
          $))) 

(MAKEPROP '|OpenMathErrorKind| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Boolean|)
              |OMERRK;OMParseError?;$B;1| |OMERRK;OMUnknownCD?;$B;2|
              |OMERRK;OMUnknownSymbol?;$B;3| |OMERRK;OMReadError?;$B;4|
              (|String|) (|Symbol|) (0 . |string|) |OMERRK;coerce;S$;5| (5 . =)
              |OMERRK;=;2$B;6| (|OutputForm|) (11 . |coerce|)
              |OMERRK;coerce;$Of;7| (|SingleInteger|) (|HashState|))
           '#(~= 16 |latex| 22 |hashUpdate!| 27 |hash| 33 |coerce| 38
              |OMUnknownSymbol?| 48 |OMUnknownCD?| 53 |OMReadError?| 58
              |OMParseError?| 63 = 68)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 18))
                        (|makeByteWordVec2| 22
                                            '(1 13 12 0 14 2 6 7 2 2 16 1 6 18
                                              2 19 2 0 7 0 0 1 1 0 12 0 1 2 0
                                              22 22 0 1 1 0 21 0 1 1 0 0 13 15
                                              1 0 18 0 20 1 0 7 0 10 1 0 7 0 9
                                              1 0 7 0 11 1 0 7 0 8 2 0 7 0 0
                                              17)))))
           '|lookupComplete|)) 

(MAKEPROP '|OpenMathErrorKind| 'NILADIC T) 

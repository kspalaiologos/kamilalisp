
(PUT '|OMENC;=;2$B;1| '|SPADreplace| '|eql_SI|) 

(SDEFUN |OMENC;=;2$B;1| ((|u| ($)) (|v| ($)) ($ (|Boolean|)))
        (|eql_SI| |u| |v|)) 

(SDEFUN |OMENC;coerce;$Of;2| ((|u| ($)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |u| 0 (QREFELT $ 8)) (SPADCALL "Unknown" (QREFELT $ 11)))
         ((SPADCALL |u| 1 (QREFELT $ 8)) (SPADCALL "Binary" (QREFELT $ 11)))
         ((SPADCALL |u| 2 (QREFELT $ 8)) (SPADCALL "XML" (QREFELT $ 11)))
         ((SPADCALL |u| 3 (QREFELT $ 8)) (SPADCALL "SGML" (QREFELT $ 11)))
         ('T (|error| "Bogus OpenMath Encoding Type")))) 

(PUT '|OMENC;OMencodingUnknown;$;3| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |OMENC;OMencodingUnknown;$;3| (($ ($))) 0) 

(PUT '|OMENC;OMencodingBinary;$;4| '|SPADreplace| '(XLAM NIL 1)) 

(SDEFUN |OMENC;OMencodingBinary;$;4| (($ ($))) 1) 

(PUT '|OMENC;OMencodingXML;$;5| '|SPADreplace| '(XLAM NIL 2)) 

(SDEFUN |OMENC;OMencodingXML;$;5| (($ ($))) 2) 

(PUT '|OMENC;OMencodingSGML;$;6| '|SPADreplace| '(XLAM NIL 3)) 

(SDEFUN |OMENC;OMencodingSGML;$;6| (($ ($))) 3) 

(DECLAIM (NOTINLINE |OpenMathEncoding;|)) 

(DEFUN |OpenMathEncoding| ()
  (SPROG NIL
         (PROG (#1=#:G702)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OpenMathEncoding|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OpenMathEncoding|
                             (LIST (CONS NIL (CONS 1 (|OpenMathEncoding;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|OpenMathEncoding|)))))))))) 

(DEFUN |OpenMathEncoding;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OpenMathEncoding|))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OpenMathEncoding| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|SingleInteger|))
          $))) 

(MAKEPROP '|OpenMathEncoding| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Boolean|) |OMENC;=;2$B;1|
              (|String|) (|OutputForm|) (0 . |message|) |OMENC;coerce;$Of;2|
              |OMENC;OMencodingUnknown;$;3| |OMENC;OMencodingBinary;$;4|
              |OMENC;OMencodingXML;$;5| |OMENC;OMencodingSGML;$;6|
              (|SingleInteger|) (|HashState|))
           '#(~= 5 |latex| 11 |hashUpdate!| 16 |hash| 22 |coerce| 27
              |OMencodingXML| 32 |OMencodingUnknown| 36 |OMencodingSGML| 40
              |OMencodingBinary| 44 = 48)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 10))
                        (|makeByteWordVec2| 18
                                            '(1 10 0 9 11 2 0 7 0 0 1 1 0 9 0 1
                                              2 0 18 18 0 1 1 0 17 0 1 1 0 10 0
                                              12 0 0 0 15 0 0 0 13 0 0 0 16 0 0
                                              0 14 2 0 7 0 0 8)))))
           '|lookupComplete|)) 

(MAKEPROP '|OpenMathEncoding| 'NILADIC T) 

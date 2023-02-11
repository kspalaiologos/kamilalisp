
(SDEFUN |OM-;OMwrite;SS;1| ((|x| (S)) ($ (|String|)))
        (SPADCALL |x| 'T (QREFELT $ 9))) 

(SDEFUN |OM-;OMwrite;OmdSV;2|
        ((|dev| (|OpenMathDevice|)) (|x| (S)) ($ (|Void|)))
        (SPADCALL |dev| |x| 'T (QREFELT $ 13))) 

(SDEFUN |OM-;OMwrite;SBS;3| ((|x| (S)) (|wholeObj| (|Boolean|)) ($ (|String|)))
        (SPROG ((|s| (|String|)) (|dev| (|OpenMathDevice|)) (|sp| (|None|)))
               (SEQ (LETT |s| "") (LETT |sp| (OM-STRINGTOSTRINGPTR |s|))
                    (LETT |dev|
                          (SPADCALL |sp| (SPADCALL (QREFELT $ 16))
                                    (QREFELT $ 17)))
                    (SPADCALL |dev| |x| |wholeObj| (QREFELT $ 13))
                    (SPADCALL |dev| (QREFELT $ 18))
                    (LETT |s| (OM-STRINGPTRTOSTRING |sp|)) (EXIT |s|)))) 

(DECLAIM (NOTINLINE |OpenMath&;|)) 

(DEFUN |OpenMath&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|OpenMath&| DV$1))
          (LETT $ (GETREFV 20))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OpenMath&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|String|) (|Boolean|)
              (0 . |OMwrite|) |OM-;OMwrite;SS;1| (|Void|) (|OpenMathDevice|)
              (6 . |OMwrite|) |OM-;OMwrite;OmdSV;2| (|OpenMathEncoding|)
              (13 . |OMencodingXML|) (17 . |OMopenString|) (23 . |OMclose|)
              |OM-;OMwrite;SBS;3|)
           '#(|OMwrite| 28) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|OMwrite| ((|String|) |#1|)) T)
                                   '((|OMwrite| ((|String|) |#1| (|Boolean|)))
                                     T)
                                   '((|OMwrite|
                                      ((|Void|) (|OpenMathDevice|) |#1|))
                                     T)
                                   '((|OMwrite|
                                      ((|Void|) (|OpenMathDevice|) |#1|
                                       (|Boolean|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(2 6 7 0 8 9 3 6 11 12 0 8 13 0 15
                                              0 16 2 12 0 7 15 17 1 12 11 0 18
                                              2 0 7 0 8 19 1 0 7 0 10 2 0 11 12
                                              0 14)))))
           '|lookupComplete|)) 

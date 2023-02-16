
(SDEFUN |XMLAT;xmlAttribute;2S$;1|
        ((|name| (|String|)) (|value| (|String|)) ($ ($)))
        (CONS |name| (LIST |value|))) 

(PUT '|XMLAT;xmlAttribute;SL$;2| '|SPADreplace| 'CONS) 

(SDEFUN |XMLAT;xmlAttribute;SL$;2|
        ((|name| (|String|)) (|values| (|List| (|String|))) ($ ($)))
        (CONS |name| |values|)) 

(SDEFUN |XMLAT;coerce;$S;3| ((|rp| ($)) ($ (|String|)))
        (SPROG ((|val| (|String|)) (#1=#:G707 NIL) (|vn| NIL))
               (SEQ (LETT |val| "")
                    (SEQ (LETT |vn| NIL) (LETT #1# (QCDR |rp|)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |vn| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND ((EQUAL |val| "") (LETT |val| |vn|))
                                 ('T
                                  (LETT |val|
                                        (SPADCALL (LIST |val| " " |vn|)
                                                  (QREFELT $ 12)))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL
                      (LIST " " (QCAR |rp|)
                            (SPADCALL "=" (SPADCALL (QREFELT $ 14))
                                      (QREFELT $ 15))
                            (SPADCALL |val| (SPADCALL (QREFELT $ 14))
                                      (QREFELT $ 15)))
                      (QREFELT $ 12)))))) 

(SDEFUN |XMLAT;outputVRML;$TfV;4| ((|rp| ($)) (|f1| (|TextFile|)) ($ (|Void|)))
        (SPROG ((|val| (|String|)) (#1=#:G713 NIL) (|vn| NIL))
               (SEQ (LETT |val| "")
                    (SEQ (LETT |vn| NIL) (LETT #1# (QCDR |rp|)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |vn| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND ((EQUAL |val| "") (LETT |val| |vn|))
                                 ('T
                                  (LETT |val|
                                        (SPADCALL (LIST |val| "," |vn|)
                                                  (QREFELT $ 12)))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (SPADCALL |f1|
                              (SPADCALL (LIST (QCAR |rp|) " " |val|)
                                        (QREFELT $ 12))
                              (QREFELT $ 18))
                    (EXIT (|Void|))))) 

(DECLAIM (NOTINLINE |XmlAttribute;|)) 

(DEFUN |XmlAttribute| ()
  (SPROG NIL
         (PROG (#1=#:G715)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|XmlAttribute|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|XmlAttribute|
                             (LIST (CONS NIL (CONS 1 (|XmlAttribute;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|XmlAttribute|)))))))))) 

(DEFUN |XmlAttribute;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|XmlAttribute|))
          (LETT $ (GETREFV 21))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|XmlAttribute| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |n| (|String|))
                              (|:| |v| (|List| (|String|)))))
          $))) 

(MAKEPROP '|XmlAttribute| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|String|)
              |XMLAT;xmlAttribute;2S$;1| (|List| 7) |XMLAT;xmlAttribute;SL$;2|
              (|List| $) (0 . |concat|) (|Character|) (5 . |quote|)
              (9 . |concat|) |XMLAT;coerce;$S;3| (|TextFile|)
              (15 . |writeLine!|) (|Void|) |XMLAT;outputVRML;$TfV;4|)
           '#(|xmlAttribute| 21 |outputVRML| 33 |coerce| 39) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|xmlAttribute| ($$ (|String|) (|String|))) T)
                              '((|xmlAttribute|
                                 ($$ (|String|) (|List| (|String|))))
                                T)
                              '((|coerce| ((|String|) $$)) T)
                              '((|outputVRML| ((|Void|) $$ (|TextFile|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 20
                                            '(1 7 0 11 12 0 13 0 14 2 7 0 0 13
                                              15 2 17 7 0 7 18 2 0 0 7 9 10 2 0
                                              0 7 7 8 2 0 19 0 17 20 1 0 7 0
                                              16)))))
           '|lookupComplete|)) 

(MAKEPROP '|XmlAttribute| 'NILADIC T) 

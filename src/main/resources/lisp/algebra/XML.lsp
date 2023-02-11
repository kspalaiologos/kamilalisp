
(SDEFUN |XML;writeXml;XeSV;1|
        ((|content| (|XmlElement|)) (|filename| (|String|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G702 NIL) (|line| NIL) (|lines| (|List| (|String|)))
          (|s1| (|String|)) (|f1| (|TextFile|)))
         (SEQ
          (LETT |f1|
                (SPADCALL (SPADCALL |filename| (QREFELT $ 8)) "output"
                          (QREFELT $ 10)))
          (LETT |s1| "<?xml version=")
          (LETT |s1| (SPADCALL |s1| (SPADCALL (QREFELT $ 12)) (QREFELT $ 13)))
          (LETT |s1| (STRCONC |s1| "1.0"))
          (LETT |s1| (SPADCALL |s1| (SPADCALL (QREFELT $ 12)) (QREFELT $ 13)))
          (LETT |s1| (STRCONC |s1| " encoding="))
          (LETT |s1| (SPADCALL |s1| (SPADCALL (QREFELT $ 12)) (QREFELT $ 13)))
          (LETT |s1| (STRCONC |s1| "UTF-8"))
          (LETT |s1| (SPADCALL |s1| (SPADCALL (QREFELT $ 12)) (QREFELT $ 13)))
          (LETT |s1| (STRCONC |s1| " standalone="))
          (LETT |s1| (SPADCALL |s1| (SPADCALL (QREFELT $ 12)) (QREFELT $ 13)))
          (LETT |s1| (STRCONC |s1| "no"))
          (LETT |s1| (SPADCALL |s1| (SPADCALL (QREFELT $ 12)) (QREFELT $ 13)))
          (LETT |s1| (STRCONC |s1| "?>")) (SPADCALL |f1| |s1| (QREFELT $ 14))
          (LETT |lines| (SPADCALL |content| (QREFELT $ 17)))
          (SEQ (LETT |line| NIL) (LETT #1# |lines|) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |line| (CAR #1#)) NIL))
                 (GO G191)))
               (SEQ (EXIT (SPADCALL |f1| |line| (QREFELT $ 14))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |f1| (QREFELT $ 18)))))) 

(SDEFUN |XML;writeVRML;XeSV;2|
        ((|content| (|XmlElement|)) (|filename| (|String|)) ($ (|Void|)))
        (SPROG ((|f1| (|TextFile|)))
               (SEQ
                (LETT |f1|
                      (SPADCALL (SPADCALL |filename| (QREFELT $ 8)) "output"
                                (QREFELT $ 10)))
                (SPADCALL |f1| "#VRML V2.0 utf8" (QREFELT $ 14))
                (SPADCALL |content| |f1| (QREFELT $ 21))
                (EXIT (SPADCALL |f1| (QREFELT $ 18)))))) 

(DECLAIM (NOTINLINE |ExportXml;|)) 

(DEFUN |ExportXml| ()
  (SPROG NIL
         (PROG (#1=#:G706)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ExportXml|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ExportXml|
                             (LIST (CONS NIL (CONS 1 (|ExportXml;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|ExportXml|)))))))))) 

(DEFUN |ExportXml;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ExportXml|))
          (LETT $ (GETREFV 23))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ExportXml| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ExportXml| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|String|) (|FileName|) (0 . |coerce|)
              (|TextFile|) (5 . |open|) (|Character|) (11 . |quote|)
              (15 . |concat|) (21 . |writeLine!|) (|List| 6) (|XmlElement|)
              (27 . |coerce|) (32 . |close!|) (|Void|) |XML;writeXml;XeSV;1|
              (37 . |outputVRML|) |XML;writeVRML;XeSV;2|)
           '#(|writeXml| 43 |writeVRML| 49) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|writeXml|
                                 ((|Void|) (|XmlElement|) (|String|)))
                                T)
                              '((|writeVRML|
                                 ((|Void|) (|XmlElement|) (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 22
                                            '(1 7 0 6 8 2 9 0 7 6 10 0 11 0 12
                                              2 6 0 0 11 13 2 9 6 0 6 14 1 16
                                              15 0 17 1 9 0 0 18 2 16 19 0 9 21
                                              2 0 19 16 6 20 2 0 19 16 6
                                              22)))))
           '|lookupComplete|)) 

(MAKEPROP '|ExportXml| 'NILADIC T) 

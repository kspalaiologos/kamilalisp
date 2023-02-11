
(SDEFUN |TEMUTL;stripC| ((|s| (|String|)) (|u| (|String|)) ($ (|String|)))
        (SPROG ((|i| (|Integer|)))
               (SEQ (LETT |i| (SPADCALL |u| |s| 1 (QREFELT $ 10)))
                    (EXIT
                     (COND ((EQL |i| 0) |s|)
                           ('T
                            (SPADCALL |s| (SPADCALL |i| (QREFELT $ 13))
                                      (QREFELT $ 14)))))))) 

(SDEFUN |TEMUTL;stripCommentsAndBlanks;2S;2| ((|s| (|String|)) ($ (|String|)))
        (SPADCALL (|TEMUTL;stripC| (|TEMUTL;stripC| |s| "++" $) "--" $)
                  (|STR_to_CHAR| " ") (QREFELT $ 16))) 

(SDEFUN |TEMUTL;interpretString;SA;3| ((|s| (|String|)) ($ (|Any|)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 18)) (QREFELT $ 20))) 

(DECLAIM (NOTINLINE |TemplateUtilities;|)) 

(DEFUN |TemplateUtilities| ()
  (SPROG NIL
         (PROG (#1=#:G699)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|TemplateUtilities|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|TemplateUtilities|
                             (LIST
                              (CONS NIL (CONS 1 (|TemplateUtilities;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|TemplateUtilities|)))))))))) 

(DEFUN |TemplateUtilities;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|TemplateUtilities|))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TemplateUtilities| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TemplateUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|InputForm|) (0 . |One|) (|Integer|)
              (|String|) (4 . |position|) (11 . |Zero|) (|UniversalSegment| 8)
              (15 . SEGMENT) (20 . |delete|) (|Character|) (26 . |trim|)
              |TEMUTL;stripCommentsAndBlanks;2S;2| (32 . |parse|) (|Any|)
              (37 . |interpret|) |TEMUTL;interpretString;SA;3|)
           '#(|stripCommentsAndBlanks| 42 |interpretString| 47) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|interpretString| ((|Any|) (|String|))) T)
                              '((|stripCommentsAndBlanks|
                                 ((|String|) (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(0 6 0 7 3 9 8 0 0 8 10 0 6 0 11 1
                                              12 0 8 13 2 9 0 0 12 14 2 9 0 0
                                              15 16 1 6 0 9 18 1 6 19 0 20 1 0
                                              9 9 17 1 0 19 9 21)))))
           '|lookupComplete|)) 

(MAKEPROP '|TemplateUtilities| 'NILADIC T) 

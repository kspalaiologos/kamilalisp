
(SDEFUN |SPECOUT;juxtaposeTerms|
        ((|l| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (SPADCALL |l| (QREFELT $ 8))) 

(SDEFUN |SPECOUT;outputAsFortran;OfV;2| ((|e| (|OutputForm|)) ($ (|Void|)))
        (SEQ (|dispfortexp| |e|) (EXIT (SPADCALL (QREFELT $ 10))))) 

(SDEFUN |SPECOUT;outputAsFortran;SOfV;3|
        ((|var| (|String|)) (|e| (|OutputForm|)) ($ (|Void|)))
        (SEQ
         (LETT |e|
               (SPADCALL
                (SPADCALL (SPADCALL |var| (QREFELT $ 14)) (QREFELT $ 15)) |e|
                (QREFELT $ 16)))
         (EXIT (SPADCALL |e| (QREFELT $ 11))))) 

(SDEFUN |SPECOUT;outputAsFortran;LV;4|
        ((|l| (|List| (|OutputForm|))) ($ (|Void|)))
        (SPADCALL (|SPECOUT;juxtaposeTerms| |l| $) (QREFELT $ 11))) 

(SDEFUN |SPECOUT;outputAsScript;OfV;5| ((|e| (|OutputForm|)) ($ (|Void|)))
        (SEQ (|formulaFormat| |e|) (EXIT (SPADCALL (QREFELT $ 10))))) 

(SDEFUN |SPECOUT;outputAsScript;LV;6|
        ((|l| (|List| (|OutputForm|))) ($ (|Void|)))
        (SPADCALL (|SPECOUT;juxtaposeTerms| |l| $) (QREFELT $ 20))) 

(SDEFUN |SPECOUT;outputAsTex;OfV;7| ((|e| (|OutputForm|)) ($ (|Void|)))
        (SEQ (|texFormat| |e|) (EXIT (SPADCALL (QREFELT $ 10))))) 

(SDEFUN |SPECOUT;outputAsTex;LV;8| ((|l| (|List| (|OutputForm|))) ($ (|Void|)))
        (SPADCALL (|SPECOUT;juxtaposeTerms| |l| $) (QREFELT $ 22))) 

(DECLAIM (NOTINLINE |SpecialOutputPackage;|)) 

(DEFUN |SpecialOutputPackage| ()
  (SPROG NIL
         (PROG (#1=#:G716)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|SpecialOutputPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|SpecialOutputPackage|
                             (LIST
                              (CONS NIL (CONS 1 (|SpecialOutputPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|SpecialOutputPackage|)))))))))) 

(DEFUN |SpecialOutputPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|SpecialOutputPackage|))
          (LETT $ (GETREFV 24))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SpecialOutputPackage| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SpecialOutputPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| $) (|OutputForm|)
              (0 . |blankSeparate|) (|Void|) (5 . |void|)
              |SPECOUT;outputAsFortran;OfV;2| (|String|) (|Symbol|)
              (9 . |coerce|) (14 . |coerce|) (19 . =)
              |SPECOUT;outputAsFortran;SOfV;3| (|List| 7)
              |SPECOUT;outputAsFortran;LV;4| |SPECOUT;outputAsScript;OfV;5|
              |SPECOUT;outputAsScript;LV;6| |SPECOUT;outputAsTex;OfV;7|
              |SPECOUT;outputAsTex;LV;8|)
           '#(|outputAsTex| 25 |outputAsScript| 35 |outputAsFortran| 45) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|outputAsFortran|
                                 ((|Void|) (|String|) (|OutputForm|)))
                                T)
                              '((|outputAsFortran| ((|Void|) (|OutputForm|)))
                                T)
                              '((|outputAsScript| ((|Void|) (|OutputForm|))) T)
                              '((|outputAsTex| ((|Void|) (|OutputForm|))) T)
                              '((|outputAsFortran|
                                 ((|Void|) (|List| (|OutputForm|))))
                                T)
                              '((|outputAsScript|
                                 ((|Void|) (|List| (|OutputForm|))))
                                T)
                              '((|outputAsTex|
                                 ((|Void|) (|List| (|OutputForm|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 23
                                            '(1 7 0 6 8 0 9 0 10 1 13 0 12 14 1
                                              13 7 0 15 2 7 0 0 0 16 1 0 9 7 22
                                              1 0 9 18 23 1 0 9 7 20 1 0 9 18
                                              21 2 0 9 12 7 17 1 0 9 7 11 1 0 9
                                              18 19)))))
           '|lookupComplete|)) 

(MAKEPROP '|SpecialOutputPackage| 'NILADIC T) 

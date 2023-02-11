
(SDEFUN |OUT;output;OfV;1| ((|e| (|OutputForm|)) ($ (|Void|)))
        (SEQ (|mathprint| |e|) (EXIT (SPADCALL (QREFELT $ 7))))) 

(SDEFUN |OUT;output;SV;2| ((|s| (|String|)) ($ (|Void|)))
        (SPADCALL |s| (QREFELT $ 9))) 

(SDEFUN |OUT;output;SOfV;3|
        ((|s| (|String|)) (|e| (|OutputForm|)) ($ (|Void|)))
        (SPADCALL (SPADCALL (LIST |s| |e|) (QREFELT $ 13)) (QREFELT $ 9))) 

(SDEFUN |OUT;outputList;LV;4| ((|l| (|List| (|Any|))) ($ (|Void|)))
        (SPROG ((#1=#:G703 NIL) (|x| NIL) (#2=#:G702 NIL))
               (SEQ
                (SPADCALL
                 (SPADCALL
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2#
                                (CONS
                                 (COND
                                  ((SPADCALL |x| (QREFELT $ 18))
                                   (SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                             (QREFELT $ 20)))
                                  ('T (SPADCALL |x| (QREFELT $ 21))))
                                 #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#))))
                  (QREFELT $ 22))
                 (QREFELT $ 9))))) 

(DECLAIM (NOTINLINE |OutputPackage;|)) 

(DEFUN |OutputPackage| ()
  (SPROG NIL
         (PROG (#1=#:G705)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OutputPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OutputPackage|
                             (LIST (CONS NIL (CONS 1 (|OutputPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|OutputPackage|)))))))))) 

(DEFUN |OutputPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OutputPackage|))
          (LETT $ (GETREFV 25))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OutputPackage| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OutputPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Void|) (0 . |void|) (|OutputForm|)
              |OUT;output;OfV;1| (|String|) |OUT;output;SV;2| (|List| $)
              (4 . |blankSeparate|) |OUT;output;SOfV;3| (|Boolean|) (|Any|)
              (|AnyFunctions1| 10) (9 . |retractable?|) (14 . |retract|)
              (19 . |message|) (24 . |coerce|) (29 . |hconcat|) (|List| 16)
              |OUT;outputList;LV;4|)
           '#(|outputList| 34 |output| 39) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|output| ((|Void|) (|String|))) T)
                                   '((|output| ((|Void|) (|OutputForm|))) T)
                                   '((|output|
                                      ((|Void|) (|String|) (|OutputForm|)))
                                     T)
                                   '((|outputList| ((|Void|) (|List| (|Any|))))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 24
                                            '(0 6 0 7 1 8 0 12 13 1 17 15 16 18
                                              1 17 10 16 19 1 8 0 10 20 1 16 8
                                              0 21 1 8 0 12 22 1 0 6 23 24 1 0
                                              6 8 9 1 0 6 10 11 2 0 6 10 8
                                              14)))))
           '|lookupComplete|)) 

(MAKEPROP '|OutputPackage| 'NILADIC T) 

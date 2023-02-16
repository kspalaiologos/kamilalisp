
(SDEFUN |FMTOUT;setFormats!;LV;1|
        ((|l| (|List| (|OutputFormatterCategory|))) ($ (|Void|)))
        (SPADCALL (QREFELT $ 9) |l| (QREFELT $ 10))) 

(PUT '|FMTOUT;convert;OfI$;2| '|SPADreplace| 'CONS) 

(SDEFUN |FMTOUT;convert;OfI$;2|
        ((|e| (|OutputForm|)) (|n| (|Integer|)) ($ ($))) (CONS |e| |n|)) 

(SDEFUN |FMTOUT;display;$V;3| ((|x| ($)) ($ (|Void|)))
        (SPROG ((#1=#:G702 NIL) (F NIL))
               (SEQ (LETT F NIL)
                    (LETT #1# (SPADCALL (QREFELT $ 9) (QREFELT $ 16))) G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT F (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (SPADCALL
                       (SPADCALL (QCAR |x|) (QCDR |x|)
                                 (|compiledLookupCheck| '|convert|
                                                        (LIST '$
                                                              (LIST
                                                               '|OutputForm|)
                                                              (LIST
                                                               '|Integer|))
                                                        F))
                       (|compiledLookupCheck| '|display|
                                              (LIST (LIST '|Void|) '$) F))))
                    (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL)))) 

(DECLAIM (NOTINLINE |FormattedOutput;|)) 

(DEFUN |FormattedOutput| ()
  (SPROG NIL
         (PROG (#1=#:G704)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FormattedOutput|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FormattedOutput|
                             (LIST (CONS NIL (CONS 1 (|FormattedOutput;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|FormattedOutput|)))))))))) 

(DEFUN |FormattedOutput;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FormattedOutput|))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FormattedOutput| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (SPADCALL NIL (QREFELT $ 8)))
          $))) 

(MAKEPROP '|FormattedOutput| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| (|OutputFormatterCategory|))
              (|Reference| 6) (0 . |ref|) '|formatters| (5 . |setelt!|)
              (|Void|) |FMTOUT;setFormats!;LV;1| (|OutputForm|) (|Integer|)
              |FMTOUT;convert;OfI$;2| (11 . |deref|) |FMTOUT;display;$V;3|)
           '#(|setFormats!| 16 |display| 21 |convert| 26) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|OutputFormatterCategory|))
                             (|makeByteWordVec2| 17
                                                 '(1 7 0 6 8 2 7 6 0 6 10 1 7 6
                                                   0 16 1 0 11 6 12 1 0 11 0 17
                                                   2 0 0 13 14 15)))))
           '|lookupComplete|)) 

(MAKEPROP '|FormattedOutput| 'NILADIC T) 

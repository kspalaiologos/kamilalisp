
(SDEFUN |JFRICAS;setFormatsAux!|
        ((|lf| (|List| (|FormatterCategory|))) ($ (|Void|)))
        (SPROG
         ((#1=#:G712 NIL) (|f| NIL) (#2=#:G711 NIL) (|e| #3=(|OutputBox|))
          (|b| #3#) (|n| (|String|)) (#4=#:G710 NIL))
         (SEQ
          (COND
           ((NULL |lf|) (SPADCALL "set output formatted off" (QREFELT $ 9)))
           ('T
            (SEQ
             (SEQ (LETT |f| NIL) (LETT #4# |lf|) G190
                  (COND
                   ((OR (ATOM #4#) (PROGN (LETT |f| (CAR #4#)) NIL))
                    (GO G191)))
                  (SEQ (LETT |n| (STRINGIMAGE (CAR (|devaluate| |f|))))
                       (LETT |b|
                             (SPADCALL (STRCONC "--FORMAT:BEG:" |n|)
                                       (QREFELT $ 11)))
                       (LETT |e|
                             (SPADCALL (STRCONC "--FORMAT:END:" |n|)
                                       (QREFELT $ 11)))
                       (EXIT
                        (SPADCALL
                         (CONS #'|JFRICAS;setFormatsAux!!0| (VECTOR $ |f| |b|))
                         (CONS #'|JFRICAS;setFormatsAux!!1| (VECTOR $ |e| |f|))
                         (|compiledLookupCheck| '|setDefault!|
                                                (LIST
                                                 (LIST '|Record|
                                                       (LIST '|:| '|prolog|
                                                             (LIST '|Mapping|
                                                                   (LIST
                                                                    '|OutputBox|)
                                                                   (LIST
                                                                    '|String|)))
                                                       (LIST '|:| '|epilog|
                                                             (LIST '|Mapping|
                                                                   (LIST
                                                                    '|OutputBox|)
                                                                   (LIST
                                                                    '|String|))))
                                                 (LIST '|Mapping|
                                                       (LIST '|OutputBox|)
                                                       (LIST '|String|))
                                                 (LIST '|Mapping|
                                                       (LIST '|OutputBox|)
                                                       (LIST '|String|)))
                                                (|Formatter| |f|)))))
                  (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
             (SPADCALL
              (PROGN
               (LETT #2# NIL)
               (SEQ (LETT |f| NIL) (LETT #1# |lf|) G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ (EXIT (LETT #2# (CONS (|Formatter| |f|) #2#))))
                    (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#))))
              (QREFELT $ 21))
             (EXIT (SPADCALL "set output formatted on" (QREFELT $ 9))))))))) 

(SDEFUN |JFRICAS;setFormatsAux!!1| ((|s| NIL) ($$ NIL))
        (PROG (|f| |e| $)
          (LETT |f| (QREFELT $$ 2))
          (LETT |e| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (LIST
              (SPADCALL |s|
                        (|compiledLookupCheck| '|defaultEpilogue|
                                               (LIST (LIST '|OutputBox|)
                                                     (LIST '|String|))
                                               |f|))
              |e|)
             (|spadConstant| $ 13)
             (SPADCALL (|spadConstant| $ 13) (QREFELT $ 16)) (QREFELT $ 18)))))) 

(SDEFUN |JFRICAS;setFormatsAux!!0| ((|s| NIL) ($$ NIL))
        (PROG (|b| |f| $)
          (LETT |b| (QREFELT $$ 2))
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (LIST |b|
                   (SPADCALL |s|
                             (|compiledLookupCheck| '|defaultPrologue|
                                                    (LIST (LIST '|OutputBox|)
                                                          (LIST '|String|))
                                                    |f|)))
             (|spadConstant| $ 13)
             (SPADCALL (|spadConstant| $ 13) (QREFELT $ 16)) (QREFELT $ 18)))))) 

(SDEFUN |JFRICAS;setFormats!;LV;2| ((|lt| (|List| (|Type|))) ($ (|Void|)))
        (SPROG ((#1=#:G717 NIL) (|t| NIL))
               (SEQ
                (SEQ (LETT |t| NIL) (LETT #1# |lt|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((NULL (|HasCategory| |t| '(|FormatterCategory|)))
                         (|error|
                          "Argument not of type List(FormatterCategory)")))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT (|JFRICAS;setFormatsAux!| |lt| $))))) 

(SDEFUN |JFRICAS;setFormat!;TV;3| ((|t| (|Type|)) ($ (|Void|)))
        (COND
         ((|HasCategory| |t| '(|FormatterCategory|))
          (SPADCALL (LIST |t|) (QREFELT $ 23)))
         ('T (|error| "Argument not of type FormatterCategory")))) 

(DECLAIM (NOTINLINE |JFriCASSupport;|)) 

(DEFUN |JFriCASSupport| ()
  (SPROG NIL
         (PROG (#1=#:G720)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|JFriCASSupport|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|JFriCASSupport|
                             (LIST (CONS NIL (CONS 1 (|JFriCASSupport;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|JFriCASSupport|)))))))))) 

(DEFUN |JFriCASSupport;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|JFriCASSupport|))
          (LETT $ (GETREFV 26))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|JFriCASSupport| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|JFriCASSupport| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Void|) (|String|)
              (|MoreSystemCommands|) (0 . |systemCommand|) (|OutputBox|)
              (5 . |box|) (|NonNegativeInteger|) (10 . |One|) (|Integer|)
              (14 . |One|) (18 . -) (|List| $) (23 . |vconcat|)
              (|List| (|OutputFormatterCategory|)) (|FormattedOutput|)
              (30 . |setFormats!|) (|List| 24) |JFRICAS;setFormats!;LV;2|
              (|Type|) |JFRICAS;setFormat!;TV;3|)
           '#(|setFormats!| 35 |setFormat!| 40) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|setFormat!| ((|Void|) (|Type|))) T)
                                   '((|setFormats!|
                                      ((|Void|) (|List| (|Type|))))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 25
                                            '(1 8 6 7 9 1 10 0 7 11 0 12 0 13 0
                                              14 0 15 1 14 0 0 16 3 10 0 17 12
                                              14 18 1 20 6 19 21 1 0 6 22 23 1
                                              0 6 24 25)))))
           '|lookupComplete|)) 

(MAKEPROP '|JFriCASSupport| 'NILADIC T) 


(SDEFUN |PLOT1;plot;SSSP;1|
        ((|f| (S)) (|x| (|Symbol|)) (|xRange| (|Segment| (|DoubleFloat|)))
         ($ (|Plot|)))
        (SPADCALL (SPADCALL |f| |x| (QREFELT $ 10)) |xRange| (QREFELT $ 13))) 

(SDEFUN |PLOT1;plotPolar;SSP;2| ((|f| (S)) (|theta| (|Symbol|)) ($ (|Plot|)))
        (SPADCALL (SPADCALL |f| |theta| (QREFELT $ 10)) (QREFELT $ 15))) 

(SDEFUN |PLOT1;plot;2SSSP;3|
        ((|f1| (S)) (|f2| (S)) (|t| (|Symbol|))
         (|tRange| (|Segment| (|DoubleFloat|))) ($ (|Plot|)))
        (SPADCALL (SPADCALL |f1| |t| (QREFELT $ 10))
                  (SPADCALL |f2| |t| (QREFELT $ 10)) |tRange| (QREFELT $ 17))) 

(SDEFUN |PLOT1;plotPolar;SSSP;4|
        ((|f| (S)) (|theta| (|Symbol|))
         (|thetaRange| (|Segment| (|DoubleFloat|))) ($ (|Plot|)))
        (SPADCALL (SPADCALL |f| |theta| (QREFELT $ 10)) |thetaRange|
                  (QREFELT $ 19))) 

(DECLAIM (NOTINLINE |PlotFunctions1;|)) 

(DEFUN |PlotFunctions1| (#1=#:G705)
  (SPROG NIL
         (PROG (#2=#:G706)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PlotFunctions1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|PlotFunctions1;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PlotFunctions1|)))))))))) 

(DEFUN |PlotFunctions1;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PlotFunctions1| DV$1))
          (LETT $ (GETREFV 21))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PlotFunctions1| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PlotFunctions1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|)
              (|Mapping| (|DoubleFloat|) (|DoubleFloat|)) (|Symbol|)
              (|MakeFloatCompiledFunction| 6) (0 . |makeFloatFunction|)
              (|Segment| (|DoubleFloat|)) (|Plot|) (6 . |plot|)
              |PLOT1;plot;SSSP;1| (12 . |plotPolar|) |PLOT1;plotPolar;SSP;2|
              (17 . |plot|) |PLOT1;plot;2SSSP;3| (24 . |plotPolar|)
              |PLOT1;plotPolar;SSSP;4|)
           '#(|plotPolar| 30 |plot| 43) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|plot|
                                 ((|Plot|) |#1| (|Symbol|)
                                  (|Segment| (|DoubleFloat|))))
                                T)
                              '((|plot|
                                 ((|Plot|) |#1| |#1| (|Symbol|)
                                  (|Segment| (|DoubleFloat|))))
                                T)
                              '((|plotPolar|
                                 ((|Plot|) |#1| (|Symbol|)
                                  (|Segment| (|DoubleFloat|))))
                                T)
                              '((|plotPolar| ((|Plot|) |#1| (|Symbol|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 20
                                            '(2 9 7 6 8 10 2 12 0 7 11 13 1 12
                                              0 7 15 3 12 0 7 7 11 17 2 12 0 7
                                              11 19 2 0 12 6 8 16 3 0 12 6 8 11
                                              20 4 0 12 6 6 8 11 18 3 0 12 6 8
                                              11 14)))))
           '|lookupComplete|)) 

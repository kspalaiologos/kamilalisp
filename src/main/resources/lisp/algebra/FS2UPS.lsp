
(DECLAIM (NOTINLINE |FunctionSpaceToUnivariatePowerSeries;|)) 

(DEFUN |FunctionSpaceToUnivariatePowerSeries| (&REST #1=#:G713)
  (SPROG NIL
         (PROG (#2=#:G714)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T T T T T T NIL))
                     (HGET |$ConstructorCache|
                           '|FunctionSpaceToUnivariatePowerSeries|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |FunctionSpaceToUnivariatePowerSeries;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionSpaceToUnivariatePowerSeries|)))))))))) 

(DEFUN |FunctionSpaceToUnivariatePowerSeries;|
       (|#1| |#2| |#3| |#4| |#5| |#6| |#7| |#8|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$8 NIL) (DV$7 NIL) (DV$6 NIL) (DV$5 NIL)
    (DV$4 NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT DV$7 (|devaluate| |#7|))
    (LETT DV$8 |#8|)
    (LETT |dv$|
          (LIST '|FunctionSpaceToUnivariatePowerSeries| DV$1 DV$2 DV$3 DV$4
                DV$5 DV$6 DV$7 DV$8))
    (LETT $ (GETREFV 20))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FunctionSpaceToUnivariatePowerSeries|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7 DV$8) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (QSETREFV $ 12 |#7|)
    (QSETREFV $ 13 |#8|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|FunctionSpaceToUnivariatePowerSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|FunctionSpaceToUnivariatePowerSeries2| 6 7 8 9 10 11 12
                                                       (NRTEVAL (ELT $ 14))
                                                       (NRTEVAL
                                                        (QREFELT $ 13)))
              (|local| |#1|) (|local| |#2|) (|local| |#3|) (|local| |#4|)
              (|local| |#5|) (|local| |#6|) (|local| |#7|) (|local| |#8|)
              (0 . |coerce|)
              (|Record| (|:| |func| (|String|)) (|:| |prob| (|String|)))
              (|Union| (|:| |%series| 9) (|:| |%problem| 15)) (|Boolean|)
              (|Union| '#1="complex" '#2="real: two sides"
                       '#3="real: left side" '#4="real: right side"
                       '#5="just do it")
              (|Mapping| 17 7))
           '#(|exprToUPS| 5 |exprToPS| 12 |exprToGenUPS| 33) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|exprToUPS|
                                 ((|Union| (|:| |%series| |#4|)
                                           (|:| |%problem|
                                                (|Record|
                                                 (|:| |func| (|String|))
                                                 (|:| |prob| (|String|)))))
                                  |#2| (|Boolean|)
                                  (|Union| #1# #2# #3# #4# #5#)))
                                T)
                              '((|exprToGenUPS|
                                 ((|Union| (|:| |%series| |#4|)
                                           (|:| |%problem|
                                                (|Record|
                                                 (|:| |func| (|String|))
                                                 (|:| |prob| (|String|)))))
                                  |#2| (|Boolean|)
                                  (|Union| #1# #2# #3# #4# #5#)))
                                T)
                              '((|exprToPS|
                                 ((|Union| (|:| |%series| |#4|)
                                           (|:| |%problem|
                                                (|Record|
                                                 (|:| |func| (|String|))
                                                 (|:| |prob| (|String|)))))
                                  |#2| (|Boolean|)
                                  (|Union| #1# #2# #3# #4# #5#) (|Boolean|)
                                  |#2|))
                                T)
                              '((|exprToPS|
                                 ((|Union| (|:| |%series| |#4|)
                                           (|:| |%problem|
                                                (|Record|
                                                 (|:| |func| (|String|))
                                                 (|:| |prob| (|String|)))))
                                  |#2| (|Boolean|)
                                  (|Union| #1# #2# #3# #4# #5#) (|Boolean|)
                                  |#2| (|Mapping| (|Boolean|) |#2|)
                                  (|Mapping| (|Boolean|) |#2|)
                                  (|Mapping| (|Boolean|) |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(1 7 0 8 14 3 0 16 7 17 18 1 8 0
                                              16 7 17 18 17 7 19 19 19 1 5 0 16
                                              7 17 18 17 7 1 3 0 16 7 17 18
                                              1)))))
           '|lookupComplete|)) 

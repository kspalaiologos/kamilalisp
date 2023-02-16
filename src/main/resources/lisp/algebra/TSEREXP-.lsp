
(SDEFUN |TSEREXP-;taylor_via_deriv;CoefLLPS;1|
        ((|f| (|Coef|)) (|lx| (|List| PS))
         (|ld| (|List| (|Mapping| |Coef| |Coef|))) ($ (PS)))
        (SPADCALL (SPADCALL |f| (|spadConstant| $ 12) (QREFELT $ 13)) |lx| |ld|
                  (QREFELT $ 17))) 

(DECLAIM (NOTINLINE |TaylorSeriesExpansion&;|)) 

(DEFUN |TaylorSeriesExpansion&| (|#1| |#2| |#3| |#4| |#5| |#6|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$6 NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT |dv$| (LIST '|TaylorSeriesExpansion&| DV$1 DV$2 DV$3 DV$4 DV$5 DV$6))
    (LETT $ (GETREFV 19))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|TaylorSeriesExpansion&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (0 . |Zero|) (4 . |monomial|) (|List| 10) (|Mapping| 7 7)
              (|List| 15) (10 . |taylor_via_deriv|)
              |TSEREXP-;taylor_via_deriv;CoefLLPS;1|)
           '#(|taylor_via_deriv| 17) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|taylor_via_deriv|
                                 (|#5| |#2| (|List| |#5|)
                                  (|List| (|Mapping| |#2| |#2|))))
                                T)
                              '((|taylor_via_deriv|
                                 (|#5| |#5| (|List| |#5|)
                                  (|List| (|Mapping| |#2| |#2|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(0 8 0 12 2 10 0 7 8 13 3 6 10 10
                                              14 16 17 3 0 10 7 14 16 18)))))
           '|lookupComplete|)) 

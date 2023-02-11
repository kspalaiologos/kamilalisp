
(SDEFUN |LLINDEP;csolve_pol;MLL;1|
        ((|csolve| (|Mapping| (|List| (|Vector| Q)) (|Matrix| F)))
         (|lp| (|List| UP)) ($ (|List| (|Vector| Q))))
        (SPROG ((|rs1| (|Matrix| F)) (|m1| (|Matrix| UP)))
               (SEQ (LETT |m1| (SPADCALL (LIST |lp|) (QREFELT $ 11)))
                    (LETT |rs1| (SPADCALL |m1| (QREFELT $ 14)))
                    (EXIT (SPADCALL |rs1| |csolve|))))) 

(SDEFUN |LLINDEP;csolve_rf;MLL;2|
        ((|csolve| (|Mapping| (|List| (|Vector| Q)) (|Matrix| F)))
         (|lrf| (|List| (|Fraction| UP))) ($ (|List| (|Vector| Q))))
        (SPROG
         ((|rs2| (|Matrix| F)) (|rs1| (|Matrix| UP))
          (|m1| (|Matrix| (|Fraction| UP))))
         (SEQ (LETT |m1| (SPADCALL (LIST |lrf|) (QREFELT $ 21)))
              (LETT |rs1| (SPADCALL |m1| (QREFELT $ 23)))
              (LETT |rs2| (SPADCALL |rs1| (QREFELT $ 14)))
              (EXIT (SPADCALL |rs2| |csolve|))))) 

(SDEFUN |LLINDEP;csolve_rmat;MML;3|
        ((|csolve| (|Mapping| (|List| (|Vector| Q)) (|Matrix| F)))
         (|mrf| (|Matrix| (|Fraction| UP))) ($ (|List| (|Vector| Q))))
        (SPROG ((|rs2| (|Matrix| F)) (|rs1| (|Matrix| UP)))
               (SEQ (LETT |rs1| (SPADCALL |mrf| (QREFELT $ 23)))
                    (LETT |rs2| (SPADCALL |rs1| (QREFELT $ 14)))
                    (EXIT (SPADCALL |rs2| |csolve|))))) 

(DECLAIM (NOTINLINE |LiftLinearDependence;|)) 

(DEFUN |LiftLinearDependence| (&REST #1=#:G708)
  (SPROG NIL
         (PROG (#2=#:G709)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LiftLinearDependence|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |LiftLinearDependence;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|LiftLinearDependence|)))))))))) 

(DEFUN |LiftLinearDependence;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|LiftLinearDependence| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 27))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|LiftLinearDependence|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|LiftLinearDependence| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|List| 17) (|Matrix| 8) (0 . |matrix|)
              (|Matrix| 6) (|Matrix| $) (5 . |reducedSystem|)
              (|List| (|Vector| 7)) (|Mapping| 15 12) (|List| 8)
              |LLINDEP;csolve_pol;MLL;1| (|List| 24) (|Matrix| 22)
              (10 . |matrix|) (|Fraction| 8) (15 . |reducedSystem|) (|List| 22)
              |LLINDEP;csolve_rf;MLL;2| |LLINDEP;csolve_rmat;MML;3|)
           '#(|csolve_rmat| 20 |csolve_rf| 26 |csolve_pol| 32) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|csolve_pol|
                                 ((|List| (|Vector| |#2|))
                                  (|Mapping| (|List| (|Vector| |#2|))
                                             (|Matrix| |#1|))
                                  (|List| |#3|)))
                                T)
                              '((|csolve_rf|
                                 ((|List| (|Vector| |#2|))
                                  (|Mapping| (|List| (|Vector| |#2|))
                                             (|Matrix| |#1|))
                                  (|List| (|Fraction| |#3|))))
                                T)
                              '((|csolve_rmat|
                                 ((|List| (|Vector| |#2|))
                                  (|Mapping| (|List| (|Vector| |#2|))
                                             (|Matrix| |#1|))
                                  (|Matrix| (|Fraction| |#3|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 26
                                            '(1 10 0 9 11 1 8 12 13 14 1 20 0
                                              19 21 1 22 10 13 23 2 0 15 16 20
                                              26 2 0 15 16 24 25 2 0 15 16 17
                                              18)))))
           '|lookupComplete|)) 

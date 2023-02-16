
(SDEFUN |REALSOLV;prn2rfi|
        ((|p| (|Polynomial| (|Fraction| (|Integer|))))
         ($ (|Fraction| (|Polynomial| (|Integer|)))))
        (SPADCALL (ELT $ 8) (CONS #'|REALSOLV;prn2rfi!0| $) |p| (QREFELT $ 19))) 

(SDEFUN |REALSOLV;prn2rfi!0| ((|x| NIL) ($ NIL))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 12))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 12))
                  (QREFELT $ 14))) 

(SDEFUN |REALSOLV;pi2rfi|
        ((|p| (|Polynomial| (|Integer|)))
         ($ (|Fraction| (|Polynomial| (|Integer|)))))
        (SPADCALL |p| (QREFELT $ 21))) 

(SDEFUN |REALSOLV;solve;PFL;3|
        ((|p| (|Polynomial| (|Fraction| (|Integer|)))) (|eps| (|Float|))
         ($ (|List| (|Float|))))
        (SPADCALL (|REALSOLV;prn2rfi| |p| $) |eps| (QREFELT $ 25))) 

(SDEFUN |REALSOLV;solve;PFL;4|
        ((|p| (|Polynomial| (|Integer|))) (|eps| (|Float|))
         ($ (|List| (|Float|))))
        (SPADCALL (SPADCALL |p| (QREFELT $ 21)) |eps| (QREFELT $ 25))) 

(SDEFUN |REALSOLV;realSolve;LLFL;5|
        ((|lp| (|List| (|Polynomial| (|Integer|)))) (|lv| (|List| (|Symbol|)))
         (|eps| (|Float|)) ($ (|List| (|List| (|Float|)))))
        (SPADCALL
         (SPADCALL (CONS (|function| |REALSOLV;pi2rfi|) $) |lp| (QREFELT $ 32))
         |lv| |eps| (QREFELT $ 35))) 

(DECLAIM (NOTINLINE |RealSolvePackage;|)) 

(DEFUN |RealSolvePackage| ()
  (SPROG NIL
         (PROG (#1=#:G712)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|RealSolvePackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|RealSolvePackage|
                             (LIST (CONS NIL (CONS 1 (|RealSolvePackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|RealSolvePackage|)))))))))) 

(DEFUN |RealSolvePackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|RealSolvePackage|))
          (LETT $ (GETREFV 37))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RealSolvePackage| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RealSolvePackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Symbol|) (|Fraction| 20) (0 . |coerce|)
              (|Integer|) (|Fraction| 9) (5 . |numer|) (10 . |coerce|)
              (15 . |denom|) (20 . /) (|Mapping| 7 6) (|Mapping| 7 10)
              (|Polynomial| 10)
              (|PolynomialCategoryLifting| (|IndexedExponents| 6) 6 10 17 7)
              (26 . |map|) (|Polynomial| 9) (33 . |coerce|) (|List| 23)
              (|Float|) (|FloatingRealPackage| 23) (38 . |realRoots|)
              |REALSOLV;solve;PFL;3| |REALSOLV;solve;PFL;4| (|List| 7)
              (|Mapping| 7 20) (|List| 20) (|ListFunctions2| 20 7) (44 . |map|)
              (|List| 22) (|List| 6) (50 . |realRoots|)
              |REALSOLV;realSolve;LLFL;5|)
           '#(|solve| 57 |realSolve| 69) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solve|
                                 ((|List| (|Float|))
                                  (|Polynomial| (|Fraction| (|Integer|)))
                                  (|Float|)))
                                T)
                              '((|solve|
                                 ((|List| (|Float|)) (|Polynomial| (|Integer|))
                                  (|Float|)))
                                T)
                              '((|realSolve|
                                 ((|List| (|List| (|Float|)))
                                  (|List| (|Polynomial| (|Integer|)))
                                  (|List| (|Symbol|)) (|Float|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 36
                                            '(1 7 0 6 8 1 10 9 0 11 1 7 0 9 12
                                              1 10 9 0 13 2 7 0 0 0 14 3 18 7
                                              15 16 17 19 1 7 0 20 21 2 24 22 7
                                              23 25 2 31 28 29 30 32 3 24 33 28
                                              34 23 35 2 0 22 17 23 26 2 0 22
                                              20 23 27 3 0 33 30 34 23 36)))))
           '|lookupComplete|)) 

(MAKEPROP '|RealSolvePackage| 'NILADIC T) 


(SDEFUN |FEXPR;mkEqn|
        ((|s1| (|Symbol|)) (|s2| (|Symbol|)) ($ (|Equation| (|Expression| R))))
        (SPADCALL (SPADCALL |s2| (QREFELT $ 13))
                  (SPADCALL
                   (SPADCALL |s1| (SPADCALL |s2| (QREFELT $ 15))
                             (QREFELT $ 16))
                   (QREFELT $ 13))
                  (QREFELT $ 18))) 

(SDEFUN |FEXPR;fixUpSymbols|
        ((|u| (|Expression| R)) ($ (|Union| (|Expression| R) "failed")))
        (SPROG
         ((#1=#:G770 NIL) (|i| NIL) (#2=#:G769 NIL) (|sym| (|Symbol|))
          (|syms| (|List| (|Symbol|))) (#3=#:G768 NIL) (|s| NIL)
          (#4=#:G767 NIL) (#5=#:G764 NIL) (#6=#:G765 NIL) (#7=#:G766 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |syms| (SPADCALL |u| (QREFELT $ 20)))
                (COND
                 ((EQL (LENGTH (QREFELT $ 6)) 1)
                  (COND
                   ((ZEROP (LENGTH (QREFELT $ 7)))
                    (EXIT
                     (COND ((NULL (EQL (LENGTH |syms|) 1)) (CONS 1 "failed"))
                           ('T
                            (CONS 0
                                  (SPADCALL |u|
                                            (SPADCALL
                                             (SPADCALL (|SPADfirst| |syms|)
                                                       (QREFELT $ 13))
                                             (SPADCALL
                                              (|SPADfirst| (QREFELT $ 6))
                                              (QREFELT $ 13))
                                             (QREFELT $ 18))
                                            (QREFELT $ 23))))))))))
                (COND
                 ((ZEROP (LENGTH (QREFELT $ 6)))
                  (COND
                   ((EQL (LENGTH (QREFELT $ 7)) 1)
                    (EXIT
                     (SEQ
                      (SEQ
                       (EXIT
                        (SEQ (LETT |s| NIL) (LETT #7# |syms|) G190
                             (COND
                              ((OR (ATOM #7#) (PROGN (LETT |s| (CAR #7#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((NULL (SPADCALL |s| (QREFELT $ 25)))
                                 (PROGN
                                  (LETT #5#
                                        (PROGN
                                         (LETT #6# (CONS 1 "failed"))
                                         (GO #8=#:G763)))
                                  (GO #9=#:G735))))))
                             (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL)))
                       #9# (EXIT #5#))
                      (COND
                       ((NULL
                         (EQL
                          (LENGTH
                           (LETT |syms|
                                 (SPADCALL
                                  (PROGN
                                   (LETT #4# NIL)
                                   (SEQ (LETT |s| NIL) (LETT #3# |syms|) G190
                                        (COND
                                         ((OR (ATOM #3#)
                                              (PROGN (LETT |s| (CAR #3#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #4#
                                                (CONS
                                                 (SPADCALL |s| (QREFELT $ 26))
                                                 #4#))))
                                        (LETT #3# (CDR #3#)) (GO G190) G191
                                        (EXIT (NREVERSE #4#))))
                                  (QREFELT $ 27))))
                          1))
                        (EXIT (CONS 1 "failed"))))
                      (LETT |sym| (|SPADfirst| (QREFELT $ 7)))
                      (EXIT
                       (CONS 0
                             (SPADCALL |u|
                                       (PROGN
                                        (LETT #2# NIL)
                                        (SEQ (LETT |i| NIL)
                                             (LETT #1#
                                                   (SPADCALL |u|
                                                             (QREFELT $ 20)))
                                             G190
                                             (COND
                                              ((OR (ATOM #1#)
                                                   (PROGN
                                                    (LETT |i| (CAR #1#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT #2#
                                                     (CONS
                                                      (|FEXPR;mkEqn| |sym| |i|
                                                       $)
                                                      #2#))))
                                             (LETT #1# (CDR #1#)) (GO G190)
                                             G191 (EXIT (NREVERSE #2#))))
                                       (QREFELT $ 29))))))))))
                (EXIT (CONS 1 "failed"))))
          #8# (EXIT #6#)))) 

(SDEFUN |FEXPR;extraSymbols?| ((|u| (|Expression| R)) ($ (|Boolean|)))
        (SPROG
         ((|extras| (|List| (|Symbol|))) (|syms| (|List| (|Symbol|)))
          (#1=#:G776 NIL) (|v| NIL) (#2=#:G775 NIL))
         (SEQ
          (LETT |syms|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |v| NIL) (LETT #1# (SPADCALL |u| (QREFELT $ 20)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |v| (QREFELT $ 26)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (LETT |extras|
                (SPADCALL |syms|
                          (SPADCALL (QREFELT $ 6) (QREFELT $ 7) (QREFELT $ 30))
                          (QREFELT $ 31)))
          (EXIT (NULL (NULL |extras|)))))) 

(SDEFUN |FEXPR;checkSymbols| ((|u| (|Expression| R)) ($ (|Expression| R)))
        (SPROG
         ((#1=#:G794 NIL) (|v| NIL) (#2=#:G793 NIL)
          (|m| (|Union| (|Expression| R) "failed"))
          (|extras| (|List| (|Symbol|))) (|syms| (|List| (|Symbol|)))
          (#3=#:G792 NIL) (#4=#:G791 NIL))
         (SEQ
          (LETT |syms|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |v| NIL) (LETT #3# (SPADCALL |u| (QREFELT $ 20)))
                      G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |v| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4# (CONS (SPADCALL |v| (QREFELT $ 26)) #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |extras|
                (SPADCALL |syms|
                          (SPADCALL (QREFELT $ 6) (QREFELT $ 7) (QREFELT $ 30))
                          (QREFELT $ 31)))
          (COND
           ((NULL (NULL |extras|))
            (EXIT
             (SEQ (LETT |m| (|FEXPR;fixUpSymbols| |u| $))
                  (EXIT
                   (COND ((QEQCAR |m| 0) (QCDR |m|))
                         ('T
                          (|error|
                           (LIST '|mathprint|
                                 (LIST 'CONCAT
                                       (SPADCALL "Extra symbols detected:"
                                                 (QREFELT $ 35))
                                       (SPADCALL
                                        (PROGN
                                         (LETT #2# NIL)
                                         (SEQ (LETT |v| NIL)
                                              (LETT #1# |extras|) G190
                                              (COND
                                               ((OR (ATOM #1#)
                                                    (PROGN
                                                     (LETT |v| (CAR #1#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #2#
                                                      (CONS
                                                       (SPADCALL |v|
                                                                 (QREFELT $
                                                                          33))
                                                       #2#))))
                                              (LETT #1# (CDR #1#)) (GO G190)
                                              G191 (EXIT (NREVERSE #2#))))
                                        (QREFELT $ 37))))))))))))
          (EXIT |u|)))) 

(SDEFUN |FEXPR;notSymbol?| ((|v| (|BasicOperator|)) ($ (|Boolean|)))
        (SPROG ((|s| (|Symbol|)))
               (SEQ (LETT |s| (SPADCALL |v| (QREFELT $ 39)))
                    (COND
                     ((SPADCALL |s| (QREFELT $ 6) (QREFELT $ 40)) (EXIT NIL))
                     ((SPADCALL |s| (QREFELT $ 25))
                      (COND
                       ((SPADCALL (SPADCALL |s| (QREFELT $ 26)) (QREFELT $ 7)
                                  (QREFELT $ 40))
                        (EXIT NIL)))))
                    (EXIT 'T)))) 

(SDEFUN |FEXPR;extraOperators?| ((|u| (|Expression| R)) ($ (|Boolean|)))
        (SPROG
         ((|extras| (|List| (|Symbol|)))
          (|fortranFunctions| (|List| (|Symbol|))) (|ops| (|List| (|Symbol|)))
          (#1=#:G805 NIL) (|v| NIL) (#2=#:G804 NIL))
         (SEQ
          (LETT |ops|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |v| NIL) (LETT #1# (SPADCALL |u| (QREFELT $ 42)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((|FEXPR;notSymbol?| |v| $)
                          (LETT #2#
                                (CONS (SPADCALL |v| (QREFELT $ 39)) #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (COND
           ((QREFELT $ 11)
            (LETT |fortranFunctions|
                  (SPADCALL (QREFELT $ 9) (QREFELT $ 10) (QREFELT $ 43))))
           ('T (LETT |fortranFunctions| (QREFELT $ 9))))
          (LETT |extras| (SPADCALL |ops| |fortranFunctions| (QREFELT $ 31)))
          (EXIT (NULL (NULL |extras|)))))) 

(SDEFUN |FEXPR;checkOperators| ((|u| (|Expression| R)) ($ (|Void|)))
        (SPROG
         ((#1=#:G826 NIL) (|v| NIL) (#2=#:G825 NIL)
          (|extras| (|List| (|Symbol|)))
          (|fortranFunctions| (|List| (|Symbol|))) (|ops| (|List| (|Symbol|)))
          (#3=#:G824 NIL) (#4=#:G823 NIL))
         (SEQ
          (LETT |ops|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |v| NIL) (LETT #3# (SPADCALL |u| (QREFELT $ 42)))
                      G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |v| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((|FEXPR;notSymbol?| |v| $)
                          (LETT #4#
                                (CONS (SPADCALL |v| (QREFELT $ 39)) #4#))))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (COND
           ((QREFELT $ 11)
            (LETT |fortranFunctions|
                  (SPADCALL (QREFELT $ 9) (QREFELT $ 10) (QREFELT $ 43))))
           ('T (LETT |fortranFunctions| (QREFELT $ 9))))
          (LETT |extras| (SPADCALL |ops| |fortranFunctions| (QREFELT $ 31)))
          (COND
           ((NULL (NULL |extras|))
            (EXIT
             (|error|
              (LIST '|mathprint|
                    (LIST 'CONCAT
                          (SPADCALL "Non FORTRAN-77 functions detected:"
                                    (QREFELT $ 35))
                          (SPADCALL
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |v| NIL) (LETT #1# |extras|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |v| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS (SPADCALL |v| (QREFELT $ 33))
                                               #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           (QREFELT $ 37))))))))
          (EXIT (SPADCALL (QREFELT $ 45)))))) 

(SDEFUN |FEXPR;checkForNagOperators| ((|u| (|Expression| R)) ($ ($)))
        (SPROG
         ((|piSub| (|Equation| (|Expression| R))) (|piOp| (|BasicOperator|)))
         (SEQ
          (COND
           ((QREFELT $ 11)
            (SEQ (LETT |piOp| (SPADCALL 'X01AAF (QREFELT $ 46)))
                 (LETT |piSub|
                       (SPADCALL
                        (SPADCALL (SPADCALL (QREFELT $ 48)) (QREFELT $ 50))
                        (SPADCALL |piOp| (|spadConstant| $ 51) (QREFELT $ 52))
                        (QREFELT $ 18)))
                 (EXIT (SPADCALL |u| |piSub| (QREFELT $ 23)))))
           ('T |u|))))) 

(SDEFUN |FEXPR;retractIfCan;PU;9|
        ((|u| (|Polynomial| (|Integer|))) ($ (|Union| $ "failed")))
        (SPADCALL (SPADCALL |u| (QREFELT $ 55)) (QREFELT $ 57))) 

(SDEFUN |FEXPR;retract;P$;10| ((|u| (|Polynomial| (|Integer|))) ($ ($)))
        (SPADCALL (SPADCALL |u| (QREFELT $ 55)) (QREFELT $ 59))) 

(SDEFUN |FEXPR;retractIfCan;FU;11|
        ((|u| (|Fraction| (|Polynomial| (|Integer|))))
         ($ (|Union| $ "failed")))
        (SPADCALL (SPADCALL |u| (QREFELT $ 62)) (QREFELT $ 57))) 

(SDEFUN |FEXPR;retract;F$;12|
        ((|u| (|Fraction| (|Polynomial| (|Integer|)))) ($ ($)))
        (SPADCALL (SPADCALL |u| (QREFELT $ 62)) (QREFELT $ 59))) 

(SDEFUN |FEXPR;int2R| ((|u| (|Integer|)) ($ (R))) (SPADCALL |u| (QREFELT $ 66))) 

(SDEFUN |FEXPR;retractIfCan;EU;14|
        ((|u| (|Expression| (|Integer|))) ($ (|Union| $ "failed")))
        (SPADCALL
         (SPADCALL (CONS (|function| |FEXPR;int2R|) $) |u| (QREFELT $ 69))
         (QREFELT $ 70))) 

(SDEFUN |FEXPR;retract;E$;15| ((|u| (|Expression| (|Integer|))) ($ ($)))
        (SPADCALL
         (SPADCALL (CONS (|function| |FEXPR;int2R|) $) |u| (QREFELT $ 69))
         (QREFELT $ 71))) 

(SDEFUN |FEXPR;retractIfCan;PU;16|
        ((|u| (|Polynomial| (|Float|))) ($ (|Union| $ "failed")))
        (SPADCALL (SPADCALL |u| (QREFELT $ 74)) (QREFELT $ 75))) 

(SDEFUN |FEXPR;retract;P$;17| ((|u| (|Polynomial| (|Float|))) ($ ($)))
        (SPADCALL (SPADCALL |u| (QREFELT $ 74)) (QREFELT $ 77))) 

(SDEFUN |FEXPR;retractIfCan;FU;18|
        ((|u| (|Fraction| (|Polynomial| (|Float|)))) ($ (|Union| $ "failed")))
        (SPADCALL (SPADCALL |u| (QREFELT $ 80)) (QREFELT $ 75))) 

(SDEFUN |FEXPR;retract;F$;19|
        ((|u| (|Fraction| (|Polynomial| (|Float|)))) ($ ($)))
        (SPADCALL (SPADCALL |u| (QREFELT $ 80)) (QREFELT $ 77))) 

(SDEFUN |FEXPR;float2R| ((|u| (|Float|)) ($ (R))) (SPADCALL |u| (QREFELT $ 84))) 

(SDEFUN |FEXPR;retractIfCan;EU;21|
        ((|u| (|Expression| (|Float|))) ($ (|Union| $ "failed")))
        (SPADCALL
         (SPADCALL (CONS (|function| |FEXPR;float2R|) $) |u| (QREFELT $ 87))
         (QREFELT $ 70))) 

(SDEFUN |FEXPR;retract;E$;22| ((|u| (|Expression| (|Float|))) ($ ($)))
        (SPADCALL
         (SPADCALL (CONS (|function| |FEXPR;float2R|) $) |u| (QREFELT $ 87))
         (QREFELT $ 71))) 

(SDEFUN |FEXPR;useNagFunctions;B;23| (($ (|Boolean|))) (QREFELT $ 11)) 

(SDEFUN |FEXPR;useNagFunctions;2B;24| ((|v| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((|old| (|Boolean|)))
               (SEQ (LETT |old| (QREFELT $ 11)) (SETELT $ 11 |v|)
                    (EXIT |old|)))) 

(SDEFUN |FEXPR;log10;2$;25| ((|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL '|log10| (QREFELT $ 46)) |x| (QREFELT $ 90))) 

(SDEFUN |FEXPR;pi;$;26| (($ ($)))
        (SPADCALL (SPADCALL 'X01AAF (QREFELT $ 46)) (|spadConstant| $ 92)
                  (QREFELT $ 90))) 

(PUT '|FEXPR;coerce;$E;27| '|SPADreplace| '(XLAM (|u|) |u|)) 

(SDEFUN |FEXPR;coerce;$E;27| ((|u| ($)) ($ (|Expression| R))) |u|) 

(SDEFUN |FEXPR;retractIfCan;EU;28|
        ((|u| (|Expression| R)) ($ (|Union| $ "failed")))
        (SPROG ((#1=#:G888 NIL) (|m| (|Union| (|Expression| R) "failed")))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((|FEXPR;extraSymbols?| |u| $)
                    (SEQ (LETT |m| (|FEXPR;fixUpSymbols| |u| $))
                         (EXIT
                          (COND
                           ((QEQCAR |m| 1)
                            (PROGN
                             (LETT #1# (CONS 1 "failed"))
                             (GO #2=#:G887)))
                           (#3='T (LETT |u| (QCDR |m|))))))))
                  (EXIT
                   (COND ((|FEXPR;extraOperators?| |u| $) (CONS 1 "failed"))
                         (#3#
                          (CONS 0 (|FEXPR;checkForNagOperators| |u| $)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |FEXPR;retract;E$;29| ((|u| (|Expression| R)) ($ ($)))
        (SEQ (LETT |u| (|FEXPR;checkSymbols| |u| $))
             (|FEXPR;checkOperators| |u| $)
             (EXIT (|FEXPR;checkForNagOperators| |u| $)))) 

(SDEFUN |FEXPR;retractIfCan;SU;30| ((|u| (|Symbol|)) ($ (|Union| $ "failed")))
        (SEQ
         (COND
          ((NULL (SPADCALL |u| (QREFELT $ 6) (QREFELT $ 40)))
           (COND
            ((SPADCALL |u| (QREFELT $ 25))
             (COND
              ((NULL
                (SPADCALL (SPADCALL |u| (QREFELT $ 26)) (QREFELT $ 7)
                          (QREFELT $ 40)))
               (EXIT (CONS 1 #1="failed")))))
            ('T (EXIT (CONS 1 #1#))))))
         (EXIT (CONS 0 (SPADCALL |u| (QREFELT $ 13)))))) 

(SDEFUN |FEXPR;retract;S$;31| ((|u| (|Symbol|)) ($ ($)))
        (SPROG ((|res| (|Union| $ "failed")))
               (SEQ (LETT |res| (SPADCALL |u| (QREFELT $ 95)))
                    (EXIT
                     (COND
                      ((QEQCAR |res| 1)
                       (|error|
                        (LIST '|mathprint|
                              (LIST 'CONCAT
                                    (SPADCALL "Illegal Symbol Detected:"
                                              (QREFELT $ 35))
                                    NIL))))
                      ('T (QCDR |res|))))))) 

(DECLAIM (NOTINLINE |FortranExpression;|)) 

(DEFUN |FortranExpression| (&REST #1=#:G916)
  (SPROG NIL
         (PROG (#2=#:G917)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL NIL T))
                     (HGET |$ConstructorCache| '|FortranExpression|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FortranExpression;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FortranExpression|)))))))))) 

(DEFUN |FortranExpression;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 |#2|)
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|FortranExpression| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 112))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#3|
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| |#3|
                                                             '(|RetractableTo|
                                                               (|Float|)))))))
          (|haddProp| |$ConstructorCache| '|FortranExpression|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (AND (|HasCategory| $ '(|Ring|)) (|augmentPredVector| $ 4))
          (AND (|HasCategory| $ '(|RetractableTo| (|Integer|)))
               (|augmentPredVector| $ 8))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    '(|abs| |sqrt| |exp| |log| |log10| |sin| |cos| |tan| |asin|
                      |acos| |atan| |sinh| |cosh| |tanh| |nthRoot| |%power|))
          (QSETREFV $ 10 '(|pi| X01AAF))
          (QSETREFV $ 11 'T)
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 58
                       (CONS (|dispatchFunction| |FEXPR;retractIfCan;PU;9|) $))
             (QSETREFV $ 60
                       (CONS (|dispatchFunction| |FEXPR;retract;P$;10|) $))
             (QSETREFV $ 63
                       (CONS (|dispatchFunction| |FEXPR;retractIfCan;FU;11|)
                             $))
             (QSETREFV $ 64
                       (CONS (|dispatchFunction| |FEXPR;retract;F$;12|) $))
             (QSETREFV $ 57
                       (CONS (|dispatchFunction| |FEXPR;retractIfCan;EU;14|)
                             $))
             (QSETREFV $ 59
                       (CONS (|dispatchFunction| |FEXPR;retract;E$;15|) $)))))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 76
                       (CONS (|dispatchFunction| |FEXPR;retractIfCan;PU;16|)
                             $))
             (QSETREFV $ 78
                       (CONS (|dispatchFunction| |FEXPR;retract;P$;17|) $))
             (QSETREFV $ 81
                       (CONS (|dispatchFunction| |FEXPR;retractIfCan;FU;18|)
                             $))
             (QSETREFV $ 82
                       (CONS (|dispatchFunction| |FEXPR;retract;F$;19|) $))
             (QSETREFV $ 75
                       (CONS (|dispatchFunction| |FEXPR;retractIfCan;EU;21|)
                             $))
             (QSETREFV $ 77
                       (CONS (|dispatchFunction| |FEXPR;retract;E$;22|) $)))))
          $))) 

(MAKEPROP '|FortranExpression| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Expression| 8) (|local| |#1|)
              (|local| |#2|) (|local| |#3|) '|f77Functions| '|nagFunctions|
              '|useNagFunctionsFlag| (|Symbol|) (0 . |coerce|)
              (|Record| (|:| |sub| (|List| 34)) (|:| |sup| (|List| 34))
                        (|:| |presup| (|List| 34)) (|:| |presub| (|List| 34))
                        (|:| |args| (|List| 34)))
              (5 . |scripts|) (10 . |script|) (|Equation| 5) (16 . |equation|)
              (|List| 12) (22 . |variables|) (27 . |One|) (|Equation| $)
              (31 . |subst|) (|Boolean|) (37 . |scripted?|) (42 . |name|)
              (47 . |removeDuplicates!|) (|List| 22) (52 . |subst|)
              (58 . |setUnion|) (64 . |setDifference|) (|String|)
              (70 . |string|) (|OutputForm|) (75 . |coerce|) (|List| 32)
              (80 . |coerce|) (|BasicOperator|) (85 . |name|) (90 . |member?|)
              (|List| 38) (96 . |operators|) (101 . |append|) (|Void|)
              (107 . |void|) (111 . |operator|) (|Pi|) (116 . |pi|)
              (|PiCoercions| 8) (120 . |coerce|) (125 . |Zero|)
              (129 . |kernel|) (|Polynomial| 65) (|Expression| 65)
              (135 . |coerce|) (|Union| $ '"failed") (140 . |retractIfCan|)
              (145 . |retractIfCan|) (150 . |retract|) (155 . |retract|)
              (|Fraction| 53) (160 . |coerce|) (165 . |retractIfCan|)
              (170 . |retract|) (|Integer|) (175 . |coerce|) (|Mapping| 8 65)
              (|ExpressionFunctions2| 65 8) (180 . |map|)
              |FEXPR;retractIfCan;EU;28| |FEXPR;retract;E$;29|
              (|Polynomial| 83) (|Expression| 83) (186 . |coerce|)
              (191 . |retractIfCan|) (196 . |retractIfCan|) (201 . |retract|)
              (206 . |retract|) (|Fraction| 72) (211 . |coerce|)
              (216 . |retractIfCan|) (221 . |retract|) (|Float|)
              (226 . |coerce|) (|Mapping| 8 83) (|ExpressionFunctions2| 83 8)
              (231 . |map|) |FEXPR;useNagFunctions;B;23|
              |FEXPR;useNagFunctions;2B;24| (237 . |kernel|)
              |FEXPR;log10;2$;25| (243 . |Zero|) |FEXPR;pi;$;26|
              |FEXPR;coerce;$E;27| |FEXPR;retractIfCan;SU;30|
              |FEXPR;retract;S$;31| (|SparseUnivariatePolynomial| $)
              (|Kernel| $) (|NonNegativeInteger|) (|List| 99)
              (|Union| 8 '"failed") (|PositiveInteger|) (|Mapping| $ 107)
              (|Mapping| $ $) (|List| 103) (|List| 104) (|List| $) (|List| 98)
              (|Union| 98 '"failed") (|SingleInteger|) (|HashState|))
           '#(~= 247 |zero?| 253 |variables| 258 |useNagFunctions| 263 |tower|
              272 |tanh| 282 |tan| 287 |subtractIfCan| 292 |subst| 298 |sqrt|
              317 |smaller?| 322 |sinh| 328 |sin| 333 |sample| 338 |rightRecip|
              342 |rightPower| 347 |retractIfCan| 359 |retract| 409 |recip| 459
              |pi| 464 |paren| 468 |opposite?| 473 |operators| 479 |operator|
              484 |one?| 489 |odd?| 494 |minPoly| 499 |map| 504 |mainKernel|
              510 |log10| 515 |log| 520 |leftRecip| 525 |leftPower| 530 |latex|
              542 |kernels| 547 |kernel| 557 |is?| 569 |height| 581
              |hashUpdate!| 586 |hash| 592 |freeOf?| 597 |exp| 609 |even?| 614
              |eval| 619 |elt| 715 |distribute| 811 |differentiate| 822
              |definingPolynomial| 848 |cosh| 853 |cos| 858 |commutator| 863
              |coerce| 869 |characteristic| 894 |box| 898 |belong?| 903 |atan|
              908 |associator| 913 |asin| 920 |antiCommutator| 925
              |annihilate?| 931 |acos| 937 |abs| 942 ^ 947 |Zero| 959 |One| 963
              D 967 = 993 - 999 + 1010 * 1016)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|PartialDifferentialRing&| |Algebra&| NIL NIL |Rng&| |Module&|
                NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL NIL
                |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |ExpressionSpace&| NIL |MagmaWithUnit&| |AbelianMonoid&|
                |NonAssociativeSemiRng&| NIL |Magma&| |AbelianSemiGroup&|
                |RetractableTo&| |SetCategory&| |Evalable&| |RetractableTo&|
                NIL NIL |BasicType&| |InnerEvalable&| |InnerEvalable&| NIL NIL)
             (CONS
              '#((|PartialDifferentialRing| 12) (|Algebra| 8) (|Ring|)
                 (|SemiRing|) (|Rng|) (|Module| 8) (|SemiRng|) (|BiModule| 8 8)
                 (|NonAssociativeRing|) (|BiModule| $$ $$) (|RightModule| 8)
                 (|LeftModule| 8) (|RightModule| $$) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|ExpressionSpace|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|AbelianMonoid|) (|NonAssociativeSemiRng|) (|Comparable|)
                 (|Magma|) (|AbelianSemiGroup|) (|RetractableTo| 8)
                 (|SetCategory|) (|Evalable| $$)
                 (|RetractableTo| (|Kernel| $$)) (|CoercibleFrom| 8)
                 (|unitsKnown|) (|BasicType|) (|InnerEvalable| $$ $$)
                 (|InnerEvalable| (|Kernel| $$) $$)
                 (|CoercibleFrom| (|Kernel| $$)) (|CoercibleTo| 34))
              (|makeByteWordVec2| 111
                                  '(1 5 0 12 13 1 12 14 0 15 2 12 0 0 14 16 2
                                    17 0 5 5 18 1 5 19 0 20 0 0 0 21 2 5 0 0 22
                                    23 1 12 24 0 25 1 12 0 0 26 1 19 0 0 27 2 5
                                    0 0 28 29 2 19 0 0 0 30 2 19 0 0 0 31 1 12
                                    32 0 33 1 32 34 0 35 1 36 34 0 37 1 38 12 0
                                    39 2 19 24 12 0 40 1 5 41 0 42 2 19 0 0 0
                                    43 0 44 0 45 1 38 0 12 46 0 47 0 48 1 49 5
                                    47 50 0 5 0 51 2 5 0 38 0 52 1 54 0 53 55 1
                                    0 56 54 57 1 0 56 53 58 1 0 0 54 59 1 0 0
                                    53 60 1 54 0 61 62 1 0 56 61 63 1 0 0 61 64
                                    1 8 0 65 66 2 68 5 67 54 69 1 73 0 72 74 1
                                    0 56 73 75 1 0 56 72 76 1 0 0 73 77 1 0 0
                                    72 78 1 73 0 79 80 1 0 56 79 81 1 0 0 79 82
                                    1 8 0 83 84 2 86 5 85 73 87 2 0 0 38 0 90 0
                                    0 0 92 2 0 24 0 0 1 1 0 24 0 1 1 0 19 0 1 0
                                    0 24 88 1 0 24 24 89 1 0 108 107 1 1 0 108
                                    0 1 1 0 0 0 1 1 0 0 0 1 2 0 56 0 0 1 2 0 0
                                    0 28 1 3 0 0 0 108 107 1 2 0 0 0 22 1 1 0 0
                                    0 1 2 0 24 0 0 1 1 0 0 0 1 1 0 0 0 1 0 0 0
                                    1 1 0 56 0 1 2 0 0 0 102 1 2 0 0 0 99 1 1 2
                                    56 72 76 1 2 56 79 81 1 2 56 73 75 1 1 56
                                    53 58 1 1 56 61 63 1 1 56 54 57 1 0 56 12
                                    95 1 0 56 5 70 1 0 101 0 1 1 0 109 0 1 1 2
                                    0 72 78 1 2 0 79 82 1 2 0 73 77 1 1 0 53 60
                                    1 1 0 61 64 1 1 0 54 59 1 0 0 12 96 1 0 0 5
                                    71 1 0 8 0 1 1 0 98 0 1 1 0 56 0 1 0 0 0 93
                                    1 0 0 0 1 2 0 24 0 0 1 1 0 41 0 1 1 0 38 38
                                    1 1 0 24 0 1 1 4 24 0 1 1 3 97 98 1 2 0 0
                                    104 98 1 1 0 109 0 1 1 0 0 0 91 1 0 0 0 1 1
                                    0 56 0 1 2 0 0 0 102 1 2 0 0 0 99 1 1 0 32
                                    0 1 1 0 108 0 1 1 0 108 107 1 2 0 0 38 0 90
                                    2 0 0 38 107 1 2 0 24 0 38 1 2 0 24 0 12 1
                                    1 0 99 0 1 2 0 111 111 0 1 1 0 110 0 1 2 0
                                    24 0 12 1 2 0 24 0 0 1 1 0 0 0 1 1 4 24 0 1
                                    3 0 0 0 38 103 1 3 0 0 0 38 104 1 3 0 0 0
                                    41 105 1 3 0 0 0 12 104 1 3 0 0 0 41 106 1
                                    3 0 0 0 19 105 1 3 0 0 0 12 103 1 3 0 0 0
                                    19 106 1 3 0 0 0 0 0 1 3 0 0 0 107 107 1 2
                                    0 0 0 28 1 2 0 0 0 22 1 3 0 0 0 108 107 1 3
                                    0 0 0 98 0 1 2 0 0 38 107 1 9 0 0 38 0 0 0
                                    0 0 0 0 0 1 10 0 0 38 0 0 0 0 0 0 0 0 0 1 7
                                    0 0 38 0 0 0 0 0 0 1 8 0 0 38 0 0 0 0 0 0 0
                                    1 6 0 0 38 0 0 0 0 0 1 4 0 0 38 0 0 0 1 5 0
                                    0 38 0 0 0 0 1 2 0 0 38 0 1 3 0 0 38 0 0 1
                                    1 0 0 0 1 2 0 0 0 0 1 2 0 0 0 12 1 3 0 0 0
                                    12 99 1 2 0 0 0 19 1 3 0 0 0 19 100 1 1 3 0
                                    0 1 1 0 0 0 1 1 0 0 0 1 2 0 0 0 0 1 1 0 5 0
                                    94 1 0 0 65 1 1 0 0 8 1 1 0 0 98 1 1 0 34 0
                                    1 0 0 99 1 1 0 0 0 1 1 0 24 38 1 1 0 0 0 1
                                    3 0 0 0 0 0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 24
                                    0 0 1 1 0 0 0 1 1 0 0 0 1 2 0 0 0 102 1 2 0
                                    0 0 99 1 0 0 0 92 0 0 0 21 2 0 0 0 12 1 3 0
                                    0 0 12 99 1 2 0 0 0 19 1 3 0 0 0 19 100 1 2
                                    0 24 0 0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 0 0 0
                                    1 2 0 0 102 0 1 2 0 0 0 0 1 2 0 0 65 0 1 2
                                    0 0 99 0 1 2 0 0 0 8 1 2 0 0 8 0 1)))))
           '|lookupComplete|)) 

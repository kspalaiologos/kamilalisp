
(SDEFUN |UTSODETL;UP2UTS;UPUTS;1| ((|p| (UP)) ($ (UTS)))
        (SPROG
         ((#1=#:G696 NIL) (#2=#:G695 (UTS)) (#3=#:G697 (UTS)) (#4=#:G700 NIL)
          (|i| NIL) (|q| (UP)))
         (SEQ
          (LETT |q|
                (SPADCALL |p|
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 10) 1 (QREFELT $ 13))
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 16) (QREFELT $ 17))
                            (QREFELT $ 18))
                           (QREFELT $ 19))
                          (QREFELT $ 20)))
          (EXIT
           (PROGN
            (LETT #1# NIL)
            (SEQ (LETT |i| 0) (LETT #4# (SPADCALL |q| (QREFELT $ 21))) G190
                 (COND ((|greater_SI| |i| #4#) (GO G191)))
                 (SEQ
                  (EXIT
                   (PROGN
                    (LETT #3#
                          (SPADCALL (SPADCALL |q| |i| (QREFELT $ 22)) |i|
                                    (QREFELT $ 23)))
                    (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 24))))
                          ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (COND (#1# #2#) ('T (|spadConstant| $ 16)))))))) 

(SDEFUN |UTSODETL;UTS2UP;UTSNniUP;2|
        ((|s| (UTS)) (|n| (|NonNegativeInteger|)) ($ (UP)))
        (SPROG
         ((|xmcn| (UP)) (|ans| (UP)) (#1=#:G707 NIL) (|i| NIL) (|xmc| (UP)))
         (SEQ
          (LETT |xmc|
                (SPADCALL (SPADCALL (|spadConstant| $ 10) 1 (QREFELT $ 13))
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 16) (QREFELT $ 17))
                           (QREFELT $ 18))
                          (QREFELT $ 26)))
          (LETT |xmcn| (|spadConstant| $ 11))
          (LETT |ans| (|spadConstant| $ 15))
          (SEQ (LETT |i| 0) (LETT #1# |n|) G190
               (COND ((|greater_SI| |i| #1#) (GO G191)))
               (SEQ
                (LETT |ans|
                      (SPADCALL |ans|
                                (SPADCALL (SPADCALL |s| |i| (QREFELT $ 27))
                                          |xmcn| (QREFELT $ 28))
                                (QREFELT $ 19)))
                (EXIT (LETT |xmcn| (SPADCALL |xmc| |xmcn| (QREFELT $ 29)))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |ans|)))) 

(SDEFUN |UTSODETL;LODO2FUN;LM;3| ((|op| (L)) ($ (|Mapping| UTS (|List| UTS))))
        (SPROG
         ((|v| (|Vector| UTS)) (#1=#:G723 NIL) (#2=#:G725 NIL) (|i| NIL)
          (#3=#:G724 NIL) (|n| (|NonNegativeInteger|)) (#4=#:G716 NIL)
          (|a| (UTS)) (#5=#:G714 NIL))
         (SEQ
          (LETT |a|
                (PROG2
                    (LETT #5#
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |op| (QREFELT $ 31))
                                      (QREFELT $ 32))
                            (QREFELT $ 25))
                           (QREFELT $ 34)))
                    (QCDR #5#)
                  (|check_union2| (QEQCAR #5# 0) (QREFELT $ 9)
                                  (|Union| (QREFELT $ 9) "failed") #5#)))
          (LETT |n|
                (PROG1
                    (LETT #4#
                          (SPADCALL (SPADCALL |op| (QREFELT $ 35))
                                    (|spadConstant| $ 36) (QREFELT $ 38)))
                  (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #4#)))
          (LETT |v|
                (PROGN
                 (LETT #3#
                       (GETREFV (|inc_SI| (- |n| #6=(|spadConstant| $ 41)))))
                 (SEQ (LETT |i| #6#) (LETT #2# |n|) (LETT #1# 0) G190
                      (COND ((> |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #3# #1#
                                (SPADCALL |a|
                                          (SPADCALL
                                           (SPADCALL |op| |i| (QREFELT $ 42))
                                           (QREFELT $ 25))
                                          (QREFELT $ 43)))))
                      (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |i| (+ |i| 1))))
                      (GO G190) G191 (EXIT NIL))
                 #3#))
          (EXIT (CONS #'|UTSODETL;LODO2FUN;LM;3!0| (VECTOR $ |v|)))))) 

(SDEFUN |UTSODETL;LODO2FUN;LM;3!0| ((|l1| NIL) ($$ NIL))
        (PROG (|v| $)
          (LETT |v| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|UTSODETL;fun| |v| |l1| $))))) 

(SDEFUN |UTSODETL;fun| ((|v| (|Vector| UTS)) (|l| (|List| UTS)) ($ (UTS)))
        (SPROG ((|ans| (UTS)) (#1=#:G730 NIL) (|b| NIL) (|i| NIL))
               (SEQ (LETT |ans| (|spadConstant| $ 16))
                    (SEQ (LETT |i| 1) (LETT |b| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |b| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |ans|
                                 (SPADCALL |ans|
                                           (SPADCALL
                                            (SPADCALL |v| |i| (QREFELT $ 47))
                                            |b| (QREFELT $ 43))
                                           (QREFELT $ 24)))))
                         (LETT #1# (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|))))
                         (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |UTSODETL;RF2UTS;FUTS;5| ((|f| (|Fraction| UP)) ($ (UTS)))
        (SPROG ((#1=#:G736 NIL))
               (SPADCALL
                (SPADCALL (SPADCALL |f| (QREFELT $ 49)) (QREFELT $ 25))
                (PROG2
                    (LETT #1#
                          (SPADCALL
                           (SPADCALL (SPADCALL |f| (QREFELT $ 50))
                                     (QREFELT $ 25))
                           (QREFELT $ 34)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (QREFELT $ 9)
                                  (|Union| (QREFELT $ 9) "failed") #1#))
                (QREFELT $ 43)))) 

(DECLAIM (NOTINLINE |UTSodetools;|)) 

(DEFUN |UTSodetools| (&REST #1=#:G739)
  (SPROG NIL
         (PROG (#2=#:G740)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UTSodetools|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |UTSodetools;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|UTSodetools|)))))))))) 

(DEFUN |UTSodetools;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|UTSodetools| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 52))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))))))
    (|haddProp| |$ConstructorCache| '|UTSodetools| (LIST DV$1 DV$2 DV$3 DV$4)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 51 (CONS (|dispatchFunction| |UTSODETL;RF2UTS;FUTS;5|) $))))
    $))) 

(MAKEPROP '|UTSodetools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |One|) (4 . |One|)
              (|NonNegativeInteger|) (8 . |monomial|) (14 . |Zero|)
              (18 . |Zero|) (22 . |Zero|) (26 . |center|) (31 . |coerce|)
              (36 . +) (42 . |elt|) (48 . |degree|) (53 . |coefficient|)
              (59 . |monomial|) (65 . +) |UTSODETL;UP2UTS;UPUTS;1| (71 . -)
              (77 . |coefficient|) (83 . *) (89 . *)
              |UTSODETL;UTS2UP;UTSNniUP;2| (95 . |leadingCoefficient|)
              (100 . -) (|Union| $ '"failed") (105 . |recip|) (110 . |degree|)
              (115 . |One|) (|Integer|) (119 . -) (|SingleInteger|)
              (125 . |Zero|) (129 . |Zero|) (133 . |coefficient|) (139 . *)
              (|Mapping| 9 (|List| 9)) |UTSODETL;LODO2FUN;LM;3| (|Vector| 9)
              (145 . |elt|) (|Fraction| 7) (151 . |numer|) (156 . |denom|)
              (161 . RF2UTS))
           '#(UTS2UP 166 UP2UTS 172 RF2UTS 177 LODO2FUN 182) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((UP2UTS (|#4| |#2|)) T)
                                   '((UTS2UP
                                      (|#2| |#4| (|NonNegativeInteger|)))
                                     T)
                                   '((LODO2FUN
                                      ((|Mapping| |#4| (|List| |#4|)) |#3|))
                                     T)
                                   '((RF2UTS (|#4| (|Fraction| |#2|)))
                                     (|has| 6 (|IntegralDomain|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 51
                                            '(0 6 0 10 0 7 0 11 2 7 0 6 12 13 0
                                              6 0 14 0 7 0 15 0 9 0 16 1 9 6 0
                                              17 1 7 0 6 18 2 7 0 0 0 19 2 7 0
                                              0 0 20 1 7 12 0 21 2 7 6 0 12 22
                                              2 9 0 6 12 23 2 9 0 0 0 24 2 7 0
                                              0 0 26 2 9 6 0 12 27 2 7 0 6 0 28
                                              2 7 0 0 0 29 1 8 7 0 31 1 7 0 0
                                              32 1 9 33 0 34 1 8 12 0 35 0 12 0
                                              36 2 37 0 0 0 38 0 39 0 40 0 12 0
                                              41 2 8 7 0 12 42 2 9 0 0 0 43 2
                                              46 9 0 37 47 1 48 7 0 49 1 48 7 0
                                              50 1 0 9 48 51 2 0 7 9 12 30 1 0
                                              9 7 25 1 1 9 48 51 1 0 44 8
                                              45)))))
           '|lookupComplete|)) 

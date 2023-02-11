
(SDEFUN |POLTOPOL;variable1|
        ((|xx| (|Symbol|)) ($ (|OrderedVariableList| |lv|)))
        (SPROG ((#1=#:G694 NIL))
               (PROG2 (LETT #1# (SPADCALL |xx| (QREFELT $ 11)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0)
                                 (|OrderedVariableList| (QREFELT $ 6))
                                 (|Union| (|OrderedVariableList| (QREFELT $ 6))
                                          "failed")
                                 #1#)))) 

(SDEFUN |POLTOPOL;pToHdmp;PHdmp;2|
        ((|pol| (|Polynomial| R))
         ($ (|HomogeneousDistributedMultivariatePolynomial| |lv| R)))
        (SPADCALL (CONS (|function| |POLTOPOL;variable1|) $) |pol|
                  (QREFELT $ 16))) 

(SDEFUN |POLTOPOL;hdmpToP;HdmpP;3|
        ((|hdpol| (|HomogeneousDistributedMultivariatePolynomial| |lv| R))
         ($ (|Polynomial| R)))
        (SPADCALL (ELT $ 18) |hdpol| (QREFELT $ 21))) 

(SDEFUN |POLTOPOL;dmpToP;DmpP;4|
        ((|dpol| (|DistributedMultivariatePolynomial| |lv| R))
         ($ (|Polynomial| R)))
        (SPADCALL (ELT $ 18) |dpol| (QREFELT $ 25))) 

(SDEFUN |POLTOPOL;pToDmp;PDmp;5|
        ((|pol| (|Polynomial| R))
         ($ (|DistributedMultivariatePolynomial| |lv| R)))
        (SPADCALL (CONS (|function| |POLTOPOL;variable1|) $) |pol|
                  (QREFELT $ 28))) 

(SDEFUN |POLTOPOL;dmpToHdmp;DmpHdmp;6|
        ((|dpol| (|DistributedMultivariatePolynomial| |lv| R))
         ($ (|HomogeneousDistributedMultivariatePolynomial| |lv| R)))
        (COND
         ((SPADCALL |dpol| (|spadConstant| $ 31) (QREFELT $ 33))
          (|spadConstant| $ 34))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |dpol| (QREFELT $ 35))
                     (SPADCALL
                      (SPADCALL (SPADCALL |dpol| (QREFELT $ 37))
                                (QREFELT $ 39))
                      (QREFELT $ 41))
                     (QREFELT $ 42))
           (SPADCALL (SPADCALL |dpol| (QREFELT $ 43)) (QREFELT $ 44))
           (QREFELT $ 45))))) 

(SDEFUN |POLTOPOL;hdmpToDmp;HdmpDmp;7|
        ((|hdpol| (|HomogeneousDistributedMultivariatePolynomial| |lv| R))
         ($ (|DistributedMultivariatePolynomial| |lv| R)))
        (SPROG ((|dd| (|DirectProduct| (|#| |lv|) (|NonNegativeInteger|))))
               (SEQ
                (COND
                 ((SPADCALL |hdpol| (|spadConstant| $ 34) (QREFELT $ 46))
                  (|spadConstant| $ 31))
                 ('T
                  (SEQ
                   (LETT |dd|
                         (SPADCALL
                          (SPADCALL (SPADCALL |hdpol| (QREFELT $ 47))
                                    (QREFELT $ 48))
                          (QREFELT $ 49)))
                   (EXIT
                    (SPADCALL
                     (SPADCALL (SPADCALL |hdpol| (QREFELT $ 50)) |dd|
                               (QREFELT $ 51))
                     (SPADCALL (SPADCALL |hdpol| (QREFELT $ 52))
                               (QREFELT $ 53))
                     (QREFELT $ 54))))))))) 

(DECLAIM (NOTINLINE |PolToPol;|)) 

(DEFUN |PolToPol| (&REST #1=#:G719)
  (SPROG NIL
         (PROG (#2=#:G720)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|PolToPol|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PolToPol;|) #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|PolToPol|)))))))))) 

(DEFUN |PolToPol;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PolToPol| DV$1 DV$2))
          (LETT $ (GETREFV 55))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PolToPol| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PolToPol| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Union| $ '"failed") (|Symbol|)
              (|OrderedVariableList| (NRTEVAL (QREFELT $ 6))) (0 . |variable|)
              (|HomogeneousDistributedMultivariatePolynomial|
               (NRTEVAL (QREFELT $ 6)) 7)
              (|Mapping| 10 9) (|Polynomial| 7)
              (|MPolyCatFunctions3| 9 10 (|IndexedExponents| 9) 40 7 14 12)
              (5 . |map|) |POLTOPOL;pToHdmp;PHdmp;2| (11 . |convert|)
              (|Mapping| 9 10)
              (|MPolyCatFunctions3| 10 9 40 (|IndexedExponents| 9) 7 12 14)
              (16 . |map|) |POLTOPOL;hdmpToP;HdmpP;3|
              (|DistributedMultivariatePolynomial| (NRTEVAL (QREFELT $ 6)) 7)
              (|MPolyCatFunctions3| 10 9 36 (|IndexedExponents| 9) 7 23 14)
              (22 . |map|) |POLTOPOL;dmpToP;DmpP;4|
              (|MPolyCatFunctions3| 9 10 (|IndexedExponents| 9) 36 7 14 23)
              (28 . |map|) |POLTOPOL;pToDmp;PDmp;5| (34 . |Zero|) (38 . |Zero|)
              (|Boolean|) (42 . =) (48 . |Zero|) (52 . |leadingCoefficient|)
              (|DirectProduct| (NRTEVAL (LENGTH (QREFELT $ 6)))
                               (|NonNegativeInteger|))
              (57 . |degree|) (|Vector| (|NonNegativeInteger|)) (62 . |coerce|)
              (|HomogeneousDirectProduct| (NRTEVAL (LENGTH (QREFELT $ 6)))
                                          (|NonNegativeInteger|))
              (67 . |directProduct|) (72 . |monomial|) (78 . |reductum|)
              |POLTOPOL;dmpToHdmp;DmpHdmp;6| (83 . +) (89 . =) (95 . |degree|)
              (100 . |coerce|) (105 . |directProduct|)
              (110 . |leadingCoefficient|) (115 . |monomial|)
              (121 . |reductum|) |POLTOPOL;hdmpToDmp;HdmpDmp;7| (126 . +))
           '#(|pToHdmp| 132 |pToDmp| 137 |hdmpToP| 142 |hdmpToDmp| 147 |dmpToP|
              152 |dmpToHdmp| 157)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|dmpToHdmp|
                                 ((|HomogeneousDistributedMultivariatePolynomial|
                                   |#1| |#2|)
                                  (|DistributedMultivariatePolynomial| |#1|
                                                                       |#2|)))
                                T)
                              '((|hdmpToDmp|
                                 ((|DistributedMultivariatePolynomial| |#1|
                                                                       |#2|)
                                  (|HomogeneousDistributedMultivariatePolynomial|
                                   |#1| |#2|)))
                                T)
                              '((|pToHdmp|
                                 ((|HomogeneousDistributedMultivariatePolynomial|
                                   |#1| |#2|)
                                  (|Polynomial| |#2|)))
                                T)
                              '((|hdmpToP|
                                 ((|Polynomial| |#2|)
                                  (|HomogeneousDistributedMultivariatePolynomial|
                                   |#1| |#2|)))
                                T)
                              '((|dmpToP|
                                 ((|Polynomial| |#2|)
                                  (|DistributedMultivariatePolynomial| |#1|
                                                                       |#2|)))
                                T)
                              '((|pToDmp|
                                 ((|DistributedMultivariatePolynomial| |#1|
                                                                       |#2|)
                                  (|Polynomial| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 54
                                            '(1 10 8 9 11 2 15 12 13 14 16 1 10
                                              9 0 18 2 20 14 19 12 21 2 24 14
                                              19 23 25 2 27 23 13 14 28 0 7 0
                                              30 0 23 0 31 2 23 32 0 0 33 0 12
                                              0 34 1 23 7 0 35 1 23 36 0 37 1
                                              36 38 0 39 1 40 0 38 41 2 12 0 7
                                              40 42 1 23 0 0 43 2 12 0 0 0 45 2
                                              12 32 0 0 46 1 12 40 0 47 1 40 38
                                              0 48 1 36 0 38 49 1 12 7 0 50 2
                                              23 0 7 36 51 1 12 0 0 52 2 23 0 0
                                              0 54 1 0 12 14 17 1 0 23 14 29 1
                                              0 14 12 22 1 0 23 12 53 1 0 14 23
                                              26 1 0 12 23 44)))))
           '|lookupComplete|)) 

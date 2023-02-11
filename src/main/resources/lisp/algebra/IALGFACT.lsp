
(SDEFUN |IALGFACT;perturbfactor|
        ((|f| (|AlPol|)) (|k| (|Integer|))
         (|fact| (|Mapping| (|Factored| UP) UP)) ($ (|List| |AlPol|)))
        (SPROG
         ((#1=#:G716 NIL) (|pp| NIL) (#2=#:G715 NIL) (|pol| (|AlPol|))
          (|lsols| (|List| |AlPol|)) (|newf| (|AlPol|)))
         (SEQ
          (LETT |pol|
                (SPADCALL (SPADCALL (|spadConstant| $ 10) 1 (QREFELT $ 13))
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |k| (QREFELT $ 15)) 1
                                      (QREFELT $ 17))
                            (QREFELT $ 18))
                           0 (QREFELT $ 13))
                          (QREFELT $ 19)))
          (LETT |newf| (SPADCALL |f| |pol| (QREFELT $ 20)))
          (LETT |lsols| (|IALGFACT;irrfactor| |newf| |k| |fact| $))
          (LETT |pol|
                (SPADCALL (SPADCALL (|spadConstant| $ 10) 1 (QREFELT $ 13))
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |k| (QREFELT $ 15)) 1
                                      (QREFELT $ 17))
                            (QREFELT $ 18))
                           0 (QREFELT $ 13))
                          (QREFELT $ 21)))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |pp| NIL) (LETT #1# |lsols|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |pp| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2# (CONS (SPADCALL |pp| |pol| (QREFELT $ 20)) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |IALGFACT;irrfactor|
        ((|f| (|AlPol|)) (|k| (|Integer|))
         (|fact| (|Mapping| (|Factored| UP) UP)) ($ (|List| |AlPol|)))
        (SPROG
         ((|listerm| (|List| |AlPol|)) (|newf| (|AlPol|)) (#1=#:G723 NIL)
          (|g| (|AlPol|)) (#2=#:G733 NIL) (|pelt| NIL)
          (|listfact|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| UP)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|nn| (UP)))
         (SEQ
          (COND ((EQL (SPADCALL |f| (QREFELT $ 22)) 1) (LIST |f|))
                (#3='T
                 (SEQ (LETT |newf| |f|) (LETT |nn| (|IALGFACT;pnorm| |f| $))
                      (LETT |listfact|
                            (SPADCALL (SPADCALL |nn| |fact|) (QREFELT $ 27)))
                      (EXIT
                       (COND
                        ((EQL (LENGTH |listfact|) 1)
                         (COND
                          ((EQL (QVELT (|SPADfirst| |listfact|) 2) 1)
                           (LIST |f|))
                          (#3#
                           (|IALGFACT;perturbfactor| |f| (+ |k| 1) |fact| $))))
                        (#3#
                         (SEQ (LETT |listerm| NIL)
                              (SEQ (LETT |pelt| NIL) (LETT #2# |listfact|) G190
                                   (COND
                                    ((OR (ATOM #2#)
                                         (PROGN (LETT |pelt| (CAR #2#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (LETT |g|
                                          (SPADCALL
                                           (|IALGFACT;change| (QVELT |pelt| 1)
                                            $)
                                           |newf| (QREFELT $ 28)))
                                    (LETT |newf|
                                          (PROG2
                                              (LETT #1#
                                                    (SPADCALL |newf| |g|
                                                              (QREFELT $ 30)))
                                              (QCDR #1#)
                                            (|check_union2| (QEQCAR #1# 0)
                                                            (QREFELT $ 9)
                                                            (|Union|
                                                             (QREFELT $ 9)
                                                             "failed")
                                                            #1#)))
                                    (EXIT
                                     (LETT |listerm|
                                           (COND
                                            ((EQL (QVELT |pelt| 2) 1)
                                             (CONS |g| |listerm|))
                                            ('T
                                             (SPADCALL
                                              (|IALGFACT;perturbfactor| |g|
                                               (+ |k| 1) |fact| $)
                                              |listerm| (QREFELT $ 32)))))))
                                   (LETT #2# (CDR #2#)) (GO G190) G191
                                   (EXIT NIL))
                              (EXIT |listerm|))))))))))) 

(SDEFUN |IALGFACT;factor;AlPolMF;3|
        ((|f| (|AlPol|)) (|fact| (|Mapping| (|Factored| UP) UP))
         ($ (|Factored| |AlPol|)))
        (SPROG
         ((#1=#:G736 NIL) (#2=#:G735 #3=(|Factored| |AlPol|)) (#4=#:G737 #3#)
          (#5=#:G740 NIL) (#6=#:G739 #3#) (#7=#:G741 #3#) (#8=#:G746 NIL)
          (|pol| NIL) (#9=#:G745 NIL) (|sqterm| NIL)
          (|sqf| (|Factored| |AlPol|)))
         (SEQ (LETT |sqf| (SPADCALL |f| (QREFELT $ 34)))
              (EXIT
               (SPADCALL (SPADCALL |sqf| (QREFELT $ 36))
                         (PROGN
                          (LETT #1# NIL)
                          (SEQ (LETT |sqterm| NIL)
                               (LETT #9# (SPADCALL |sqf| (QREFELT $ 39))) G190
                               (COND
                                ((OR (ATOM #9#)
                                     (PROGN (LETT |sqterm| (CAR #9#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (PROGN
                                  (LETT #4#
                                        (PROGN
                                         (LETT #5# NIL)
                                         (SEQ (LETT |pol| NIL)
                                              (LETT #8#
                                                    (|IALGFACT;irrfactor|
                                                     (QVELT |sqterm| 1) 0
                                                     |fact| $))
                                              G190
                                              (COND
                                               ((OR (ATOM #8#)
                                                    (PROGN
                                                     (LETT |pol| (CAR #8#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (PROGN
                                                 (LETT #7#
                                                       (SPADCALL |pol|
                                                                 (QVELT
                                                                  |sqterm| 2)
                                                                 (QREFELT $
                                                                          40)))
                                                 (COND
                                                  (#5#
                                                   (LETT #6#
                                                         (SPADCALL #6# #7#
                                                                   (QREFELT $
                                                                            41))))
                                                  ('T
                                                   (PROGN
                                                    (LETT #6# #7#)
                                                    (LETT #5# 'T)))))))
                                              (LETT #8# (CDR #8#)) (GO G190)
                                              G191 (EXIT NIL))
                                         (COND (#5# #6#)
                                               ('T (|spadConstant| $ 42)))))
                                  (COND
                                   (#1#
                                    (LETT #2#
                                          (SPADCALL #2# #4# (QREFELT $ 41))))
                                   ('T
                                    (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                               (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                          (COND (#1# #2#) ('T (|spadConstant| $ 42))))
                         (QREFELT $ 43)))))) 

(SDEFUN |IALGFACT;pnorm| ((|q| (|AlPol|)) ($ (UP)))
        (SPADCALL (|IALGFACT;convrt| |q| $) (QREFELT $ 53) (QREFELT $ 54))) 

(SDEFUN |IALGFACT;change| ((|q| (UP)) ($ (|AlPol|)))
        (SPADCALL (ELT $ 55) |q| (QREFELT $ 58))) 

(SDEFUN |IALGFACT;convrt|
        ((|q| (|AlPol|)) ($ (|SparseUnivariatePolynomial| UP)))
        (SPADCALL (SPADCALL (ELT $ 59) |q| (QREFELT $ 62)) (QREFELT $ 64))) 

(DECLAIM (NOTINLINE |InnerAlgFactor;|)) 

(DEFUN |InnerAlgFactor| (&REST #1=#:G753)
  (SPROG NIL
         (PROG (#2=#:G754)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InnerAlgFactor|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |InnerAlgFactor;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InnerAlgFactor|)))))))))) 

(DEFUN |InnerAlgFactor;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|InnerAlgFactor| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 65))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|InnerAlgFactor|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 47 (SPADCALL (QREFELT $ 46)))
    (QSETREFV $ 53 (SPADCALL (ELT $ 48) (QREFELT $ 47) (QREFELT $ 52)))
    $))) 

(MAKEPROP '|InnerAlgFactor| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |One|) (4 . |One|)
              (|NonNegativeInteger|) (8 . |monomial|) (|Integer|)
              (14 . |coerce|) (19 . |One|) (23 . |monomial|) (29 . |reduce|)
              (34 . -) (40 . |elt|) (46 . +) (52 . |degree|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 23) (|:| |factor| 7) (|:| |exponent| 12))
              (|List| 24) (|Factored| 7) (57 . |factorList|) (62 . |gcd|)
              (|Union| $ '"failed") (68 . |exquo|) (|List| 9) (74 . |append|)
              (|Factored| $) (80 . |squareFree|) (|Factored| 9) (85 . |unit|)
              (|Record| (|:| |flag| 23) (|:| |factor| 9) (|:| |exponent| 12))
              (|List| 37) (90 . |factorList|) (95 . |primeFactor|) (101 . *)
              (107 . |One|) (111 . *) (|Mapping| 26 7)
              |IALGFACT;factor;AlPolMF;3| (117 . |definingPolynomial|) '|p|
              (121 . |coerce|) (|SparseUnivariatePolynomial| 7) (|Mapping| 7 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 7 49) (126 . |map|)
              '|newp| (132 . |resultant|) (138 . |coerce|) (|Mapping| 8 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 8 9) (143 . |map|)
              (149 . |lift|) (|Mapping| 7 8)
              (|UnivariatePolynomialCategoryFunctions2| 8 9 7 49) (154 . |map|)
              (|CommuteUnivariatePolynomialCategory| 6 7 49) (160 . |swap|))
           '#(|factor| 165) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|factor|
                                 ((|Factored| |#4|) |#4|
                                  (|Mapping| (|Factored| |#2|) |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 64
                                            '(0 8 0 10 0 6 0 11 2 9 0 8 12 13 1
                                              6 0 14 15 0 7 0 16 2 7 0 6 12 17
                                              1 8 0 7 18 2 9 0 0 0 19 2 9 0 0 0
                                              20 2 9 0 0 0 21 1 9 12 0 22 1 26
                                              25 0 27 2 9 0 0 0 28 2 9 29 0 0
                                              30 2 31 0 0 0 32 1 9 33 0 34 1 35
                                              9 0 36 1 35 38 0 39 2 35 0 9 12
                                              40 2 35 0 0 0 41 0 35 0 42 2 35 0
                                              9 0 43 0 8 7 46 1 7 0 6 48 2 51
                                              49 50 7 52 2 49 7 0 0 54 1 8 0 6
                                              55 2 57 9 56 7 58 1 8 7 0 59 2 61
                                              49 60 9 62 1 63 49 49 64 2 0 35 9
                                              44 45)))))
           '|lookupComplete|)) 

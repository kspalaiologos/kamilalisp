
(SDEFUN |PSQFR;pPolRoot| ((|f| (P)) ($ (P)))
        (SPROG
         ((|uf| (|SparseUnivariatePolynomial| P)) (#1=#:G707 NIL)
          (|mv| (|VarSet|)) (|lvar| (|List| |VarSet|)))
         (SEQ (LETT |lvar| (SPADCALL |f| (QREFELT $ 14)))
              (EXIT
               (COND ((NULL |lvar|) |f|)
                     ('T
                      (SEQ (LETT |mv| (|SPADfirst| |lvar|))
                           (LETT |uf| (SPADCALL |f| |mv| (QREFELT $ 16)))
                           (LETT |uf|
                                 (PROG2
                                     (LETT #1#
                                           (SPADCALL |uf| (QREFELT $ 12)
                                                     (QREFELT $ 19)))
                                     (QCDR #1#)
                                   (|check_union2| (QEQCAR #1# 0)
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 9))
                                                   (|Union|
                                                    (|SparseUnivariatePolynomial|
                                                     (QREFELT $ 9))
                                                    "failed")
                                                   #1#)))
                           (LETT |uf|
                                 (SPADCALL
                                  (CONS (|function| |PSQFR;pPolRoot|) $) |uf|
                                  (QREFELT $ 21)))
                           (EXIT (SPADCALL |uf| |mv| (QREFELT $ 22)))))))))) 

(SDEFUN |PSQFR;putPth| ((|f| (P)) ($ (P)))
        (SPROG
         ((|uf| (|SparseUnivariatePolynomial| P)) (|mv| (|VarSet|))
          (|lvar| (|List| |VarSet|)))
         (SEQ (LETT |lvar| (SPADCALL |f| (QREFELT $ 14)))
              (EXIT
               (COND ((NULL |lvar|) |f|)
                     ('T
                      (SEQ (LETT |mv| (|SPADfirst| |lvar|))
                           (LETT |uf| (SPADCALL |f| |mv| (QREFELT $ 16)))
                           (LETT |uf|
                                 (SPADCALL |uf| (QREFELT $ 12) (QREFELT $ 23)))
                           (LETT |uf|
                                 (SPADCALL (CONS (|function| |PSQFR;putPth|) $)
                                           |uf| (QREFELT $ 21)))
                           (EXIT (SPADCALL |uf| |mv| (QREFELT $ 22)))))))))) 

(SDEFUN |PSQFR;pthPower| ((|f| (P)) ($ (|Factored| P)))
        (SPROG
         ((#1=#:G747 NIL) (|u| NIL) (#2=#:G746 NIL) (#3=#:G745 NIL)
          (#4=#:G744 NIL) (|psqfr| (|Factored| P)) (|isSq| (|Boolean|))
          (|proot| (P)) (|g| (|Union| P "failed")))
         (SEQ (LETT |proot| (|spadConstant| $ 24)) (LETT |isSq| NIL)
              (SEQ (LETT |g| (SPADCALL |f| (QREFELT $ 25)))
                   (EXIT
                    (COND
                     ((QEQCAR |g| 1) (LETT |proot| (|PSQFR;pPolRoot| |f| $)))
                     (#5='T
                      (SEQ (LETT |proot| (QCDR |g|))
                           (EXIT (LETT |isSq| 'T)))))))
              (LETT |psqfr|
                    (|PSQFR;finSqFr| |proot| (SPADCALL |f| (QREFELT $ 14)) $))
              (EXIT
               (COND
                (|isSq|
                 (SPADCALL
                  (SPADCALL (SPADCALL |psqfr| (QREFELT $ 27)) (QREFELT $ 12)
                            (QREFELT $ 28))
                  (PROGN
                   (LETT #4# NIL)
                   (SEQ (LETT |u| NIL)
                        (LETT #3# (SPADCALL |psqfr| (QREFELT $ 32))) G190
                        (COND
                         ((OR (ATOM #3#) (PROGN (LETT |u| (CAR #3#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #4#
                                (CONS
                                 (VECTOR (QVELT |u| 0) (QVELT |u| 1)
                                         (* (QVELT |u| 2) (QREFELT $ 12)))
                                 #4#))))
                        (LETT #3# (CDR #3#)) (GO G190) G191
                        (EXIT (NREVERSE #4#))))
                  (QREFELT $ 33)))
                (#5#
                 (SPADCALL (SPADCALL |psqfr| (QREFELT $ 27))
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |u| NIL)
                                 (LETT #1# (SPADCALL |psqfr| (QREFELT $ 32)))
                                 G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |u| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS
                                          (VECTOR (CONS 0 "nil")
                                                  (|PSQFR;putPth| (QVELT |u| 1)
                                                   $)
                                                  (QVELT |u| 2))
                                          #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           (QREFELT $ 33)))))))) 

(SDEFUN |PSQFR;finSqFr|
        ((|f| (P)) (|lvar| (|List| |VarSet|)) ($ (|Factored| P)))
        (SPROG
         ((|pfaclist|
           (|List|
            #1=(|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                         (|:| |factor| P)
                         (|:| |exponent| (|NonNegativeInteger|)))))
          (|sqp| #2=(|Factored| P)) (|cont| (P)) (|cont1| (P))
          (|flistfin1| (|List| #1#)) (#3=#:G779 NIL) (|uu| NIL) (#4=#:G778 NIL)
          (|listfin1| #2#) (|uexp| (|NonNegativeInteger|)) (#5=#:G777 NIL)
          (|u| NIL) (|squf| (|Factored| (|SparseUnivariatePolynomial| P)))
          (|uf| (|SparseUnivariatePolynomial| P)) (#6=#:G749 NIL)
          (|mv| (|VarSet|)))
         (SEQ
          (COND ((NULL |lvar|) (|PSQFR;pthPower| |f| $))
                (#7='T
                 (SEQ (LETT |mv| (|SPADfirst| |lvar|))
                      (LETT |lvar| (CDR |lvar|))
                      (EXIT
                       (COND
                        ((SPADCALL (SPADCALL |f| |mv| (QREFELT $ 34))
                                   (|spadConstant| $ 24) (QREFELT $ 36))
                         (|PSQFR;finSqFr| |f| |lvar| $))
                        (#7#
                         (SEQ (LETT |uf| (SPADCALL |f| |mv| (QREFELT $ 16)))
                              (LETT |cont| (SPADCALL |uf| (QREFELT $ 37)))
                              (LETT |cont1| (|spadConstant| $ 38))
                              (LETT |uf|
                                    (PROG2
                                        (LETT #6#
                                              (SPADCALL |uf| |cont|
                                                        (QREFELT $ 39)))
                                        (QCDR #6#)
                                      (|check_union2| (QEQCAR #6# 0)
                                                      (|SparseUnivariatePolynomial|
                                                       (QREFELT $ 9))
                                                      (|Union|
                                                       (|SparseUnivariatePolynomial|
                                                        (QREFELT $ 9))
                                                       "failed")
                                                      #6#)))
                              (LETT |squf| (SPADCALL |uf| (QREFELT $ 42)))
                              (LETT |pfaclist| NIL)
                              (SEQ (LETT |u| NIL)
                                   (LETT #5# (SPADCALL |squf| (QREFELT $ 45)))
                                   G190
                                   (COND
                                    ((OR (ATOM #5#)
                                         (PROGN (LETT |u| (CAR #5#)) NIL))
                                     (GO G191)))
                                   (SEQ (LETT |uexp| (QVELT |u| 2))
                                        (EXIT
                                         (COND
                                          ((SPADCALL (QVELT |u| 0)
                                                     (CONS 1 "sqfr")
                                                     (QREFELT $ 46))
                                           (LETT |pfaclist|
                                                 (CONS
                                                  (VECTOR (QVELT |u| 0)
                                                          (SPADCALL
                                                           (QVELT |u| 1) |mv|
                                                           (QREFELT $ 22))
                                                          |uexp|)
                                                  |pfaclist|)))
                                          ('T
                                           (SEQ
                                            (LETT |listfin1|
                                                  (SPADCALL
                                                   (SPADCALL (QVELT |u| 1) |mv|
                                                             (QREFELT $ 22))
                                                   (QREFELT $ 47)))
                                            (LETT |flistfin1|
                                                  (PROGN
                                                   (LETT #4# NIL)
                                                   (SEQ (LETT |uu| NIL)
                                                        (LETT #3#
                                                              (SPADCALL
                                                               |listfin1|
                                                               (QREFELT $ 32)))
                                                        G190
                                                        (COND
                                                         ((OR (ATOM #3#)
                                                              (PROGN
                                                               (LETT |uu|
                                                                     (CAR #3#))
                                                               NIL))
                                                          (GO G191)))
                                                        (SEQ
                                                         (EXIT
                                                          (LETT #4#
                                                                (CONS
                                                                 (VECTOR
                                                                  (QVELT |uu|
                                                                         0)
                                                                  (QVELT |uu|
                                                                         1)
                                                                  (*
                                                                   (QVELT |uu|
                                                                          2)
                                                                   |uexp|))
                                                                 #4#))))
                                                        (LETT #3# (CDR #3#))
                                                        (GO G190) G191
                                                        (EXIT
                                                         (NREVERSE #4#)))))
                                            (LETT |cont1|
                                                  (SPADCALL |cont1|
                                                            (SPADCALL
                                                             (SPADCALL
                                                              |listfin1|
                                                              (QREFELT $ 27))
                                                             |uexp|
                                                             (QREFELT $ 28))
                                                            (QREFELT $ 48)))
                                            (EXIT
                                             (LETT |pfaclist|
                                                   (SPADCALL |flistfin1|
                                                             |pfaclist|
                                                             (QREFELT $
                                                                      49)))))))))
                                   (LETT #5# (CDR #5#)) (GO G190) G191
                                   (EXIT NIL))
                              (LETT |cont|
                                    (SPADCALL |cont| |cont1| (QREFELT $ 48)))
                              (EXIT
                               (COND
                                ((SPADCALL |cont| (|spadConstant| $ 38)
                                           (QREFELT $ 51))
                                 (SEQ
                                  (LETT |sqp| (SPADCALL |cont| (QREFELT $ 47)))
                                  (LETT |pfaclist|
                                        (SPADCALL
                                         (SPADCALL |sqp| (QREFELT $ 32))
                                         |pfaclist| (QREFELT $ 49)))
                                  (EXIT
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |sqp| (QREFELT $ 27))
                                              (SPADCALL
                                               (SPADCALL |squf| (QREFELT $ 52))
                                               0 (QREFELT $ 53))
                                              (QREFELT $ 48))
                                    |pfaclist| (QREFELT $ 33)))))
                                (#7#
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |squf| (QREFELT $ 52)) 0
                                            (QREFELT $ 53))
                                  |pfaclist| (QREFELT $ 33))))))))))))))) 

(SDEFUN |PSQFR;squareFree;PF;5| ((|p| (P)) ($ (|Factored| P)))
        (SPROG
         ((|sqp| (|Factored| P))
          (|pfaclist|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| P)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#1=#:G801 NIL) (|u| NIL) (#2=#:G800 NIL)
          (|squp| (|Factored| (|SparseUnivariatePolynomial| P)))
          (|up| (|SparseUnivariatePolynomial| P)) (#3=#:G785 NIL) (|cont| (P))
          (|mv| (|Union| |VarSet| "failed")))
         (SEQ (LETT |mv| (SPADCALL |p| (QREFELT $ 55)))
              (EXIT
               (COND ((QEQCAR |mv| 1) (SPADCALL |p| NIL (QREFELT $ 33)))
                     ((SPADCALL (SPADCALL (QREFELT $ 11)) 0 (QREFELT $ 56))
                      (|PSQFR;finSqFr| |p| (SPADCALL |p| (QREFELT $ 14)) $))
                     (#4='T
                      (SEQ
                       (LETT |up| (SPADCALL |p| (QCDR |mv|) (QREFELT $ 16)))
                       (LETT |cont| (SPADCALL |up| (QREFELT $ 37)))
                       (LETT |up|
                             (PROG2
                                 (LETT #3#
                                       (SPADCALL |up| |cont| (QREFELT $ 39)))
                                 (QCDR #3#)
                               (|check_union2| (QEQCAR #3# 0)
                                               (|SparseUnivariatePolynomial|
                                                (QREFELT $ 9))
                                               (|Union|
                                                (|SparseUnivariatePolynomial|
                                                 (QREFELT $ 9))
                                                "failed")
                                               #3#)))
                       (LETT |squp| (SPADCALL |up| (QREFELT $ 42)))
                       (LETT |pfaclist|
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |u| NIL)
                                   (LETT #1# (SPADCALL |squp| (QREFELT $ 45)))
                                   G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |u| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS
                                            (VECTOR (QVELT |u| 0)
                                                    (SPADCALL (QVELT |u| 1)
                                                              (QCDR |mv|)
                                                              (QREFELT $ 22))
                                                    (QVELT |u| 2))
                                            #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#)))))
                       (EXIT
                        (COND
                         ((SPADCALL |cont| (|spadConstant| $ 38)
                                    (QREFELT $ 51))
                          (SEQ (LETT |sqp| (SPADCALL |cont| (QREFELT $ 47)))
                               (EXIT
                                (SPADCALL
                                 (SPADCALL (SPADCALL |sqp| (QREFELT $ 27))
                                           (SPADCALL
                                            (SPADCALL |squp| (QREFELT $ 52)) 0
                                            (QREFELT $ 53))
                                           (QREFELT $ 48))
                                 (SPADCALL (SPADCALL |sqp| (QREFELT $ 32))
                                           |pfaclist| (QREFELT $ 49))
                                 (QREFELT $ 33)))))
                         (#4#
                          (SPADCALL
                           (SPADCALL (SPADCALL |squp| (QREFELT $ 52)) 0
                                     (QREFELT $ 53))
                           |pfaclist| (QREFELT $ 33)))))))))))) 

(DECLAIM (NOTINLINE |PolynomialSquareFree;|)) 

(DEFUN |PolynomialSquareFree| (&REST #1=#:G802)
  (SPROG NIL
         (PROG (#2=#:G803)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialSquareFree|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PolynomialSquareFree;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PolynomialSquareFree|)))))))))) 

(DEFUN |PolynomialSquareFree;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|PolynomialSquareFree| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 57))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PolynomialSquareFree|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 12 (SPADCALL (QREFELT $ 11)))
    $))) 

(MAKEPROP '|PolynomialSquareFree| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|NonNegativeInteger|)
              (0 . |characteristic|) '|chrc| (|List| 6) (4 . |variables|)
              (|SparseUnivariatePolynomial| $) (9 . |univariate|)
              (|Union| $ '"failed") (|SparseUnivariatePolynomial| 9)
              (15 . |divideExponents|) (|Mapping| 9 9) (21 . |map|)
              (27 . |multivariate|) (33 . |multiplyExponents|) (39 . |Zero|)
              (43 . |charthRoot|) (|Factored| 9) (48 . |unit|) (53 . ^)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 29) (|:| |factor| 9) (|:| |exponent| 10))
              (|List| 30) (59 . |factorList|) (64 . |makeFR|)
              (70 . |differentiate|) (|Boolean|) (76 . =) (82 . |content|)
              (87 . |One|) (91 . |exquo|) (|Factored| 18)
              (|UnivariatePolynomialSquareFree| 9 18) (97 . |squareFree|)
              (|Record| (|:| |flag| 29) (|:| |factor| 18) (|:| |exponent| 10))
              (|List| 43) (102 . |factorList|) (107 . =)
              |PSQFR;squareFree;PF;5| (113 . *) (119 . |append|) (125 . |One|)
              (129 . ~=) (135 . |unit|) (140 . |coefficient|)
              (|Union| 6 '"failed") (146 . |mainVariable|) (151 . ~=))
           '#(|squareFree| 157) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|squareFree| ((|Factored| |#4|) |#4|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 56
                                            '(0 8 10 11 1 9 13 0 14 2 9 15 0 6
                                              16 2 18 17 0 10 19 2 18 0 20 0 21
                                              2 9 0 15 6 22 2 18 0 0 10 23 0 9
                                              0 24 1 9 17 0 25 1 26 9 0 27 2 9
                                              0 0 10 28 1 26 31 0 32 2 26 0 9
                                              31 33 2 9 0 0 6 34 2 9 35 0 0 36
                                              1 18 9 0 37 0 9 0 38 2 18 17 0 9
                                              39 1 41 40 18 42 1 40 44 0 45 2
                                              29 35 0 0 46 2 9 0 0 0 48 2 31 0
                                              0 0 49 0 8 0 50 2 9 35 0 0 51 1
                                              40 18 0 52 2 18 9 0 10 53 1 9 54
                                              0 55 2 10 35 0 0 56 1 0 26 9
                                              47)))))
           '|lookupComplete|)) 

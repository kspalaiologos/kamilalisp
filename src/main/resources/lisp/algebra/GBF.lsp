
(SDEFUN |GBF;createGroebnerBases|
        ((|basis|
          (|List|
           (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                     (|:| |pol| |Dpol|))))
         (|redPols| (|List| |Dpol|)) (|nonZeroRestrictions| (|List| |Dpol|))
         (|inputPolys| (|List| |Dpol|))
         (|lcP|
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|))))
         (|listOfBases| (|List| (|List| |Dpol|))) (|info| (|Boolean|))
         ($ (|List| (|List| |Dpol|))))
        (SPROG
         ((|newBasis| (|List| |Dpol|)) (#1=#:G768 NIL) (#2=#:G767 NIL)
          (|newInputPolys| (|List| |Dpol|)) (#3=#:G766 NIL) (#4=#:G762 NIL)
          (|nP| (|Dpol|)) (|allReducedFactors| (|List| |Dpol|))
          (|fnP| (|Dpol|)) (#5=#:G765 NIL) (|doSplitting?| #6=(|Boolean|))
          (|irreducibleFactors| (|List| |Dpol|)) (|terminateWithBasis| #6#)
          (|stopDividing| #6#) (#7=#:G718 NIL)
          (|nPq| (|Union| |Dpol| #8="failed")) (#9=#:G764 NIL) (#10=#:G763 NIL)
          (|q| NIL) (|h| (|Dpol|)) (|p| (|Dpol|)))
         (SEQ (LETT |doSplitting?| NIL) (LETT |terminateWithBasis| NIL)
              (LETT |allReducedFactors| NIL)
              (SEQ G190
                   (COND
                    ((NULL (NULL (OR |doSplitting?| |terminateWithBasis|)))
                     (GO G191)))
                   (SEQ
                    (LETT |terminateWithBasis|
                          (COND ((NULL |inputPolys|) (NULL |lcP|)) ('T NIL)))
                    (EXIT
                     (COND
                      ((NULL |terminateWithBasis|)
                       (SEQ
                        (LETT |nP|
                              (COND
                               ((NULL (NULL |inputPolys|))
                                (SEQ (LETT |p| (|SPADfirst| |inputPolys|))
                                     (LETT |inputPolys| (CDR |inputPolys|))
                                     (EXIT
                                      (SPADCALL
                                       (SPADCALL |p| |redPols| (QREFELT $ 12))
                                       (QREFELT $ 13)))))
                               ('T
                                (SEQ
                                 (LETT |h|
                                       (SPADCALL (|SPADfirst| |lcP|)
                                                 (QREFELT $ 15)))
                                 (LETT |lcP| (CDR |lcP|))
                                 (EXIT
                                  (SPADCALL
                                   (SPADCALL |h| |redPols| (QREFELT $ 12))
                                   (QREFELT $ 13)))))))
                        (EXIT
                         (COND
                          ((SPADCALL |nP| (|spadConstant| $ 16) (QREFELT $ 18))
                           (SEQ
                            (LETT |basis|
                                  (LIST (CONS 0 (|spadConstant| $ 16))))
                            (EXIT (LETT |terminateWithBasis| 'T))))
                          ('T
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |nP| (|spadConstant| $ 21)
                                         (QREFELT $ 22))
                               (PROGN
                                (LETT #4#
                                      (SEQ
                                       (SEQ (LETT |q| NIL)
                                            (LETT #10# |nonZeroRestrictions|)
                                            G190
                                            (COND
                                             ((OR (ATOM #10#)
                                                  (PROGN
                                                   (LETT |q| (CAR #10#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ (LETT |stopDividing| NIL)
                                                 (EXIT
                                                  (SEQ (LETT #9# NIL) G190
                                                       (COND (#9# (GO G191)))
                                                       (SEQ
                                                        (LETT |nPq|
                                                              (SPADCALL |nP|
                                                                        |q|
                                                                        (QREFELT
                                                                         $
                                                                         24)))
                                                        (LETT |stopDividing|
                                                              (QEQCAR |nPq| 1))
                                                        (COND
                                                         ((NULL |stopDividing|)
                                                          (LETT |nP|
                                                                (PROG2
                                                                    (LETT #7#
                                                                          |nPq|)
                                                                    (QCDR #7#)
                                                                  (|check_union2|
                                                                   (QEQCAR #7#
                                                                           0)
                                                                   (QREFELT $
                                                                            9)
                                                                   (|Union|
                                                                    (QREFELT $
                                                                             9)
                                                                    #8#)
                                                                   #7#)))))
                                                        (EXIT
                                                         (LETT |stopDividing|
                                                               (COND
                                                                (|stopDividing|
                                                                 'T)
                                                                ('T
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   |nP|
                                                                   (QREFELT $
                                                                            25))
                                                                  (QREFELT $
                                                                           26)))))))
                                                       (LETT #9#
                                                             |stopDividing|)
                                                       (GO G190) G191
                                                       (EXIT NIL))))
                                            (LETT #10# (CDR #10#)) (GO G190)
                                            G191 (EXIT NIL))
                                       (EXIT
                                        (COND
                                         ((SPADCALL
                                           (SPADCALL |nP| (QREFELT $ 25))
                                           (QREFELT $ 26))
                                          (SEQ
                                           (LETT |basis|
                                                 (LIST
                                                  (CONS 0
                                                        (|spadConstant| $
                                                                        16))))
                                           (EXIT
                                            (LETT |terminateWithBasis| 'T))))
                                         ('T
                                          (SEQ
                                           (LETT |nP|
                                                 (SPADCALL
                                                  (SPADCALL |nP| |redPols|
                                                            (QREFELT $ 12))
                                                  (QREFELT $ 13)))
                                           (EXIT
                                            (COND
                                             ((SPADCALL
                                               (SPADCALL |nP| (QREFELT $ 25))
                                               (QREFELT $ 26))
                                              (SEQ
                                               (LETT |basis|
                                                     (LIST
                                                      (CONS 0
                                                            (|spadConstant| $
                                                                            16))))
                                               (EXIT
                                                (LETT |terminateWithBasis|
                                                      'T))))
                                             ((SPADCALL |nP|
                                                        (|spadConstant| $ 21)
                                                        (QREFELT $ 22))
                                              (SEQ
                                               (LETT |irreducibleFactors|
                                                     (|GBF;createAllFactors|
                                                      |nP| $))
                                               (LETT |doSplitting?|
                                                     (NULL
                                                      (NULL
                                                       (CDR
                                                        |irreducibleFactors|))))
                                               (EXIT
                                                (COND
                                                 (|doSplitting?|
                                                  (SEQ
                                                   (SEQ
                                                    (LETT #5#
                                                          |irreducibleFactors|)
                                                    G190
                                                    (COND
                                                     ((OR (ATOM #5#)
                                                          (PROGN
                                                           (LETT |fnP|
                                                                 (CAR #5#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (LETT |fnP|
                                                           (SPADCALL
                                                            (SPADCALL |fnP|
                                                                      |redPols|
                                                                      (QREFELT
                                                                       $ 12))
                                                            (QREFELT $ 13)))
                                                     (EXIT
                                                      (LETT |allReducedFactors|
                                                            (CONS |fnP|
                                                                  |allReducedFactors|))))
                                                    (LETT #5# (CDR #5#))
                                                    (GO G190) G191 (EXIT NIL))
                                                   (EXIT
                                                    (LETT |allReducedFactors|
                                                          (REVERSE
                                                           |allReducedFactors|)))))
                                                 ('T
                                                  (SEQ
                                                   (LETT |nP|
                                                         (|SPADfirst|
                                                          |irreducibleFactors|))
                                                   (LETT |lcP|
                                                         (|GBF;updateCritPairs|
                                                          |lcP|
                                                          (|GBF;newPairs|
                                                           |basis| |nP| $)
                                                          |nP| $))
                                                   (LETT |basis|
                                                         (|GBF;updateBasis|
                                                          |basis| |nP|
                                                          (SPADCALL |nP|
                                                                    (QREFELT $
                                                                             28))
                                                          $))
                                                   (EXIT
                                                    (LETT |redPols|
                                                          (SPADCALL |redPols|
                                                                    |nP|
                                                                    (QREFELT $
                                                                             29))))))))))))))))))
                                (GO #11=#:G744)))))
                            #11# (EXIT #4#))))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                (|doSplitting?|
                 (SEQ
                  (SEQ (LETT #3# |allReducedFactors|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |fnP| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |fnP| (|spadConstant| $ 16)
                                     (QREFELT $ 22))
                           (SEQ
                            (LETT |newInputPolys|
                                  (SPADCALL
                                   (CONS #'|GBF;createGroebnerBases!0| $)
                                   (CONS |fnP| |inputPolys|) (QREFELT $ 32)))
                            (LETT |listOfBases|
                                  (|GBF;createGroebnerBases| |basis| |redPols|
                                   |nonZeroRestrictions| |newInputPolys| |lcP|
                                   |listOfBases| |info| $))
                            (EXIT
                             (LETT |nonZeroRestrictions|
                                   (CONS |fnP| |nonZeroRestrictions|)))))
                          ('T
                           (SEQ
                            (COND
                             (|info|
                              (SPADCALL "we terminated with [1]"
                                        (QREFELT $ 36))))
                            (EXIT
                             (LETT |listOfBases|
                                   (CONS (LIST (|spadConstant| $ 16))
                                         |listOfBases|))))))))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (EXIT |listOfBases|)))
                ('T
                 (SEQ
                  (LETT |newBasis|
                        (SPADCALL
                         (SPADCALL (CONS #'|GBF;createGroebnerBases!1| $)
                                   (PROGN
                                    (LETT #2# NIL)
                                    (SEQ (LETT #1# |basis|) G190
                                         (COND
                                          ((OR (ATOM #1#)
                                               (PROGN
                                                (LETT |p| (CAR #1#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #2# (CONS (QCDR |p|) #2#))))
                                         (LETT #1# (CDR #1#)) (GO G190) G191
                                         (EXIT (NREVERSE #2#))))
                                   (QREFELT $ 32))
                         (QREFELT $ 37)))
                  (COND
                   (|info|
                    (SEQ
                     (SPADCALL
                      "we found a groebner basis and check whether it "
                      (QREFELT $ 36))
                     (SPADCALL "contains reducible polynomials" (QREFELT $ 36))
                     (EXIT
                      (SPADCALL (SPADCALL |newBasis| (QREFELT $ 38))
                                (QREFELT $ 39))))))
                  (EXIT
                   (SPADCALL
                    (SPADCALL (SPADCALL |newBasis| |info| (QREFELT $ 41))
                              |listOfBases| (QREFELT $ 42))
                    (QREFELT $ 43)))))))))) 

(SDEFUN |GBF;createGroebnerBases!1| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 25)) (SPADCALL |y| (QREFELT $ 25))
                  (QREFELT $ 30))) 

(SDEFUN |GBF;createGroebnerBases!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 25)) (SPADCALL |y| (QREFELT $ 25))
                  (QREFELT $ 30))) 

(SDEFUN |GBF;createAllFactors| ((|p| (|Dpol|)) ($ (|List| |Dpol|)))
        (SPROG
         ((|loF| (|List| |Dpol|)) (#1=#:G785 NIL) (|el| NIL) (#2=#:G784 NIL))
         (SEQ
          (LETT |loF|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |el| NIL)
                      (LETT #1#
                            (SPADCALL (SPADCALL |p| (QREFELT $ 46))
                                      (QREFELT $ 50)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |el| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QVELT |el| 1) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (SPADCALL (CONS #'|GBF;createAllFactors!0| $) |loF|
                     (QREFELT $ 32)))))) 

(SDEFUN |GBF;createAllFactors!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 25)) (SPADCALL |y| (QREFELT $ 25))
                  (QREFELT $ 51))) 

(SDEFUN |GBF;newPairs|
        ((|lp|
          (|List|
           (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                     (|:| |pol| |Dpol|))))
         (|p| (|Dpol|))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|)))))
        (SPROG
         ((|lcP|
           (|List|
            (|Record| (|:| |lcmfij| |Expon|)
                      (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                      (|:| |polj| |Dpol|))))
          (#1=#:G797 NIL) (|q| NIL) (#2=#:G796 NIL)
          (|totdegreeOfp| (|NonNegativeInteger|)))
         (SEQ (LETT |totdegreeOfp| (SPADCALL |p| (QREFELT $ 28)))
              (LETT |lcP|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |q| NIL) (LETT #1# |lp|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |q| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL |q| |p| |totdegreeOfp|
                                             (QREFELT $ 53))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (SPADCALL (SPADCALL (ELT $ 54) |lcP| (QREFELT $ 57))
                         (QREFELT $ 58)))))) 

(SDEFUN |GBF;updateCritPairs|
        ((|oldListOfcritPairs|
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|))))
         (|newListOfcritPairs|
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|))))
         (|p| (|Dpol|))
         ($
          (|List|
           (|Record| (|:| |lcmfij| |Expon|)
                     (|:| |totdeg| (|NonNegativeInteger|)) (|:| |poli| |Dpol|)
                     (|:| |polj| |Dpol|)))))
        (SPADCALL |newListOfcritPairs|
                  (SPADCALL |p| |oldListOfcritPairs| (QREFELT $ 59))
                  (QREFELT $ 60))) 

(SDEFUN |GBF;updateBasis|
        ((|lp|
          (|List|
           (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                     (|:| |pol| |Dpol|))))
         (|p| (|Dpol|)) (|deg| (|NonNegativeInteger|))
         ($
          (|List|
           (|Record| (|:| |totdeg| (|NonNegativeInteger|))
                     (|:| |pol| |Dpol|)))))
        (SPADCALL |p| |deg| |lp| (QREFELT $ 62))) 

(SDEFUN |GBF;factorGroebnerBasis;LL;6|
        ((|basis| (|List| |Dpol|)) ($ (|List| (|List| |Dpol|))))
        (SPADCALL |basis| NIL (QREFELT $ 41))) 

(SDEFUN |GBF;factorGroebnerBasis;LBL;7|
        ((|basis| (|List| |Dpol|)) (|info| (|Boolean|))
         ($ (|List| (|List| |Dpol|))))
        (SPROG
         ((|foundAReducible| (|Boolean|)) (#1=#:G816 NIL) (|el| NIL)
          (#2=#:G815 NIL) (#3=#:G814 NIL) (|p| NIL))
         (SEQ (LETT |foundAReducible| NIL)
              (SEQ (LETT |p| NIL) (LETT #3# |basis|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL)
                         (NULL (NULL |foundAReducible|)))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |foundAReducible|
                           (< 1
                              (LENGTH
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |el| NIL)
                                     (LETT #1#
                                           (SPADCALL
                                            (SPADCALL |p| (QREFELT $ 46))
                                            (QREFELT $ 50)))
                                     G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |el| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #2# (CONS (QVELT |el| 1) #2#))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT (NREVERSE #2#)))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                (|foundAReducible|
                 (SEQ
                  (COND
                   (|info|
                    (SPADCALL
                     "factorGroebnerBasis:        we found reducible polynomials and continue splitting"
                     (QREFELT $ 36))))
                  (EXIT
                   (|GBF;createGroebnerBases| NIL NIL NIL |basis| NIL NIL
                    |info| $))))
                ('T
                 (SEQ
                  (COND
                   (|info|
                    (SPADCALL
                     "factorGroebnerBasis: no reducible polynomials in this basis"
                     (QREFELT $ 36))))
                  (EXIT (LIST |basis|))))))))) 

(SDEFUN |GBF;groebnerFactorize;2LL;8|
        ((|basis| (|List| |Dpol|)) (|nonZeroRestrictions| (|List| |Dpol|))
         ($ (|List| (|List| |Dpol|))))
        (SPADCALL |basis| |nonZeroRestrictions| NIL (QREFELT $ 65))) 

(SDEFUN |GBF;groebnerFactorize;2LBL;9|
        ((|basis| (|List| |Dpol|)) (|nonZeroRestrictions| (|List| |Dpol|))
         (|info| (|Boolean|)) ($ (|List| (|List| |Dpol|))))
        (SPROG ((#1=#:G828 NIL) (|p| NIL) (#2=#:G827 NIL))
               (SEQ
                (COND ((SPADCALL |basis| NIL (QREFELT $ 67)) (LIST |basis|))
                      (#3='T
                       (SEQ
                        (LETT |basis|
                              (SPADCALL (ELT $ 68) |basis| (QREFELT $ 70)))
                        (EXIT
                         (COND
                          ((SPADCALL |basis| NIL (QREFELT $ 67))
                           (LIST (LIST (|spadConstant| $ 21))))
                          (#3#
                           (SEQ
                            (LETT |basis|
                                  (PROGN
                                   (LETT #2# NIL)
                                   (SEQ (LETT |p| NIL) (LETT #1# |basis|) G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN (LETT |p| (CAR #1#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #2#
                                                (CONS
                                                 (SPADCALL |p| (QREFELT $ 13))
                                                 #2#))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT (NREVERSE #2#)))))
                            (EXIT
                             (COND
                              ((SPADCALL (|spadConstant| $ 16) |basis|
                                         (QREFELT $ 71))
                               (LIST (LIST (|spadConstant| $ 16))))
                              (#3#
                               (SEQ
                                (LETT |basis|
                                      (SPADCALL
                                       (CONS #'|GBF;groebnerFactorize;2LBL;9!0|
                                             $)
                                       |basis| (QREFELT $ 32)))
                                (EXIT
                                 (|GBF;createGroebnerBases| NIL NIL
                                  |nonZeroRestrictions| |basis| NIL NIL |info|
                                  $)))))))))))))))) 

(SDEFUN |GBF;groebnerFactorize;2LBL;9!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 25)) (SPADCALL |y| (QREFELT $ 25))
                  (QREFELT $ 30))) 

(SDEFUN |GBF;groebnerFactorize;LL;10|
        ((|basis| (|List| |Dpol|)) ($ (|List| (|List| |Dpol|))))
        (SPADCALL |basis| NIL NIL (QREFELT $ 65))) 

(SDEFUN |GBF;groebnerFactorize;LBL;11|
        ((|basis| (|List| |Dpol|)) (|info| (|Boolean|))
         ($ (|List| (|List| |Dpol|))))
        (SPADCALL |basis| NIL |info| (QREFELT $ 65))) 

(DECLAIM (NOTINLINE |GroebnerFactorizationPackage;|)) 

(DEFUN |GroebnerFactorizationPackage| (&REST #1=#:G831)
  (SPROG NIL
         (PROG (#2=#:G832)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GroebnerFactorizationPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |GroebnerFactorizationPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|GroebnerFactorizationPackage|)))))))))) 

(DEFUN |GroebnerFactorizationPackage;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|GroebnerFactorizationPackage| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 74))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|GroebnerFactorizationPackage|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|GroebnerFactorizationPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|List| 9)
              (|GroebnerInternalPackage| 6 7 9) (0 . |redPol|) (6 . |hMonic|)
              (|Record| (|:| |lcmfij| 7) (|:| |totdeg| 27) (|:| |poli| 9)
                        (|:| |polj| 9))
              (11 . |sPol|) (16 . |One|) (|Boolean|) (20 . =) (26 . |Zero|)
              (30 . |Zero|) (34 . |Zero|) (38 . ~=) (|Union| $ '"failed")
              (44 . |exquo|) (50 . |degree|) (55 . |zero?|)
              (|NonNegativeInteger|) (60 . |virtualDegree|) (65 . |concat|)
              (71 . >) (|Mapping| 17 9 9) (77 . |sort|) (|Void|) (|String|)
              (|OutputForm|) (83 . |messagePrint|) (88 . |minGbasis|)
              (93 . |coerce|) (98 . |print|) (|List| 10)
              |GBF;factorGroebnerBasis;LBL;7| (103 . |append|)
              (109 . |removeDuplicates|) (|Factored| 9)
              (|MultivariateFactorize| 8 7 6 9) (114 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 47) (|:| |factor| 9) (|:| |exponent| 27))
              (|List| 48) (119 . |factorList|) (124 . <)
              (|Record| (|:| |totdeg| 27) (|:| |pol| 9)) (130 . |makeCrit|)
              (137 . |critpOrder|) (|Mapping| 17 14 14) (|List| 14)
              (143 . |sort|) (149 . |critMTonD1|) (154 . |critBonD|)
              (160 . |updatD|) (|List| 52) (166 . |updatF|)
              |GBF;factorGroebnerBasis;LL;6| (173 . |One|)
              |GBF;groebnerFactorize;2LBL;9| |GBF;groebnerFactorize;2LL;8|
              (177 . =) (183 . |zero?|) (|Mapping| 17 9) (188 . |remove|)
              (194 . |member?|) |GBF;groebnerFactorize;LL;10|
              |GBF;groebnerFactorize;LBL;11|)
           '#(|groebnerFactorize| 200 |factorGroebnerBasis| 224) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|factorGroebnerBasis|
                                 ((|List| (|List| |#4|)) (|List| |#4|)))
                                T)
                              '((|factorGroebnerBasis|
                                 ((|List| (|List| |#4|)) (|List| |#4|)
                                  (|Boolean|)))
                                T)
                              '((|groebnerFactorize|
                                 ((|List| (|List| |#4|)) (|List| |#4|)
                                  (|List| |#4|)))
                                T)
                              '((|groebnerFactorize|
                                 ((|List| (|List| |#4|)) (|List| |#4|)
                                  (|List| |#4|) (|Boolean|)))
                                T)
                              '((|groebnerFactorize|
                                 ((|List| (|List| |#4|)) (|List| |#4|)))
                                T)
                              '((|groebnerFactorize|
                                 ((|List| (|List| |#4|)) (|List| |#4|)
                                  (|Boolean|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 73
                                            '(2 11 9 9 10 12 1 11 9 9 13 1 11 9
                                              14 15 0 9 0 16 2 9 17 0 0 18 0 6
                                              0 19 0 7 0 20 0 9 0 21 2 9 17 0 0
                                              22 2 9 23 0 0 24 1 9 7 0 25 1 7
                                              17 0 26 1 11 27 9 28 2 10 0 0 9
                                              29 2 7 17 0 0 30 2 10 0 31 0 32 1
                                              35 33 34 36 1 11 10 10 37 1 10 35
                                              0 38 1 35 33 0 39 2 40 0 0 0 42 1
                                              40 0 0 43 1 45 44 9 46 1 44 49 0
                                              50 2 7 17 0 0 51 3 11 14 52 9 27
                                              53 2 11 17 14 14 54 2 56 0 55 0
                                              57 1 11 56 56 58 2 11 56 9 56 59
                                              2 11 56 56 56 60 3 11 61 9 27 61
                                              62 0 6 0 64 2 10 17 0 0 67 1 9 17
                                              0 68 2 10 0 69 0 70 2 10 17 9 0
                                              71 2 0 40 10 10 66 3 0 40 10 10
                                              17 65 2 0 40 10 17 73 1 0 40 10
                                              72 1 0 40 10 63 2 0 40 10 17
                                              41)))))
           '|lookupComplete|)) 

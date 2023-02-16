
(SDEFUN |UTSODE;stFunc1;MM;1|
        ((|f| (|Mapping| UTS UTS))
         ($ (|Mapping| (|Stream| |Coef|) (|Stream| |Coef|))))
        (SPROG NIL (CONS #'|UTSODE;stFunc1;MM;1!0| (VECTOR |f| $)))) 

(SDEFUN |UTSODE;stFunc1;MM;1!0| ((|s| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL (SPADCALL |s| (QREFELT $ 9)) |f|)
                      (QREFELT $ 10)))))) 

(SDEFUN |UTSODE;stFunc2;MM;2|
        ((|f| (|Mapping| UTS UTS UTS))
         ($ (|Mapping| (|Stream| |Coef|) (|Stream| |Coef|) (|Stream| |Coef|))))
        (SPROG NIL (CONS #'|UTSODE;stFunc2;MM;2!0| (VECTOR |f| $)))) 

(SDEFUN |UTSODE;stFunc2;MM;2!0| ((|s1| NIL) (|s2| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |s1| (QREFELT $ 9))
                       (SPADCALL |s2| (QREFELT $ 9)) |f|)
             (QREFELT $ 10)))))) 

(SDEFUN |UTSODE;stFuncN;MM;3|
        ((|f| (|Mapping| UTS (|List| UTS)))
         ($ (|Mapping| (|Stream| |Coef|) (|List| (|Stream| |Coef|)))))
        (SPROG NIL (CONS #'|UTSODE;stFuncN;MM;3!0| (VECTOR |f| $)))) 

(SDEFUN |UTSODE;stFuncN;MM;3!0| ((|ls| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL (SPADCALL (ELT $ 9) |ls| (QREFELT $ 21)) |f|)
                      (QREFELT $ 10)))))) 

(SDEFUN |UTSODE;divloopre|
        ((|hx| (|Coef|)) (|tx| (|Stream| |Coef|)) (|hy| (|Coef|))
         (|ty| (|Stream| |Coef|)) (|c| (|Stream| |Coef|))
         ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|UTSODE;divloopre!0|
                      (VECTOR |c| |ty| |tx| $ |hy| |hx|))
                (QREFELT $ 32)))) 

(SDEFUN |UTSODE;divloopre!0| (($$ NIL))
        (PROG (|hx| |hy| $ |tx| |ty| |c|)
          (LETT |hx| (QREFELT $$ 5))
          (LETT |hy| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |tx| (QREFELT $$ 2))
          (LETT |ty| (QREFELT $$ 1))
          (LETT |c| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |hx| |hy| (QREFELT $ 25))
                      (SPADCALL |hy|
                                (SPADCALL |tx|
                                          (SPADCALL |ty| |c| (QREFELT $ 27))
                                          (QREFELT $ 28))
                                (QREFELT $ 29))
                      (QREFELT $ 30)))))) 

(SDEFUN |UTSODE;divloop|
        ((|hx| (|Coef|)) (|tx| (|Stream| |Coef|)) (|hy| (|Coef|))
         (|ty| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|UTSODE;divloop!0| (VECTOR $ |ty| |hy| |tx| |hx|))
                (QREFELT $ 34)))) 

(SDEFUN |UTSODE;divloop!0| ((|s| NIL) ($$ NIL))
        (PROG (|hx| |tx| |hy| |ty| $)
          (LETT |hx| (QREFELT $$ 4))
          (LETT |tx| (QREFELT $$ 3))
          (LETT |hy| (QREFELT $$ 2))
          (LETT |ty| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|UTSODE;divloopre| |hx| |tx| |hy| |ty| |s| $))))) 

(SDEFUN |UTSODE;sdiv|
        ((|x| (|Stream| |Coef|)) (|y| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|UTSODE;sdiv!0| (VECTOR |y| $ |x|))
                          (QREFELT $ 32))))) 

(SDEFUN |UTSODE;sdiv!0| (($$ NIL))
        (PROG (|x| $ |y|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |y| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|hx| NIL) (|tx| NIL) (|hy| NIL) (|ty| NIL) (|rhy| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |x| (QREFELT $ 36)) (SPADCALL (QREFELT $ 37)))
                     ((SPADCALL |y| (QREFELT $ 36))
                      (|error| "stream division by zero"))
                     ('T
                      (SEQ (LETT |hx| (SPADCALL |x| (QREFELT $ 38)))
                           (LETT |tx| (SPADCALL |x| (QREFELT $ 39)))
                           (LETT |hy| (SPADCALL |y| (QREFELT $ 38)))
                           (LETT |ty| (SPADCALL |y| (QREFELT $ 39)))
                           (EXIT
                            (COND
                             ((SPADCALL |hy| (QREFELT $ 40))
                              (COND
                               ((SPADCALL |hx| (QREFELT $ 40))
                                (|UTSODE;sdiv| |tx| |ty| $))
                               ('T (|error| "stream division by zero"))))
                             ('T
                              (SEQ (LETT |rhy| (SPADCALL |hy| (QREFELT $ 42)))
                                   (EXIT
                                    (COND
                                     ((QEQCAR |rhy| 1)
                                      (|error|
                                       "stream division:no reciprocal"))
                                     ('T
                                      (|UTSODE;divloop| |hx| |tx| (QCDR |rhy|)
                                       |ty| $))))))))))))))))) 

(SDEFUN |UTSODE;fixedPointExquo;3UTS;7| ((|f| (UTS)) (|g| (UTS)) ($ (UTS)))
        (SPADCALL
         (|UTSODE;sdiv| (SPADCALL |f| (QREFELT $ 10))
          (SPADCALL |g| (QREFELT $ 10)) $)
         (QREFELT $ 9))) 

(SDEFUN |UTSODE;ode1re|
        ((|f| (|Mapping| (|Stream| |Coef|) (|Stream| |Coef|))) (|c| (|Coef|))
         (|y| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL |c| (CONS #'|UTSODE;ode1re!0| (VECTOR |f| |y|))
                         (QREFELT $ 45)))) 

(SDEFUN |UTSODE;ode1re!0| (($$ NIL))
        (PROG (|y| |f|)
          (LETT |y| (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |y| |f|))))) 

(SDEFUN |UTSODE;iOde1|
        ((|f| (|Mapping| (|Stream| |Coef|) (|Stream| |Coef|))) (|c| (|Coef|))
         ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL (CONS #'|UTSODE;iOde1!0| (VECTOR $ |c| |f|))
                         (QREFELT $ 34)))) 

(SDEFUN |UTSODE;iOde1!0| ((|s| NIL) ($$ NIL))
        (PROG (|f| |c| $)
          (LETT |f| (QREFELT $$ 2))
          (LETT |c| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|UTSODE;ode1re| |f| |c| |s| $))))) 

(SDEFUN |UTSODE;ode1;MCoefUTS;10|
        ((|f| (|Mapping| UTS UTS)) (|c| (|Coef|)) ($ (UTS)))
        (SPADCALL (|UTSODE;iOde1| (SPADCALL |f| (QREFELT $ 13)) |c| $)
                  (QREFELT $ 9))) 

(SDEFUN |UTSODE;ode2re|
        ((|f|
          (|Mapping| (|Stream| |Coef|) (|Stream| |Coef|) (|Stream| |Coef|)))
         (|c0| (|Coef|)) (|c1| (|Coef|)) (|y| (|Stream| |Coef|))
         ($ (|Stream| |Coef|)))
        (SPROG ((|yi| (|Stream| |Coef|)))
               (SEQ
                (LETT |yi|
                      (SPADCALL |c1|
                                (CONS #'|UTSODE;ode2re!0| (VECTOR |f| $ |y|))
                                (QREFELT $ 45)))
                (EXIT
                 (SPADCALL |c0| (CONS #'|UTSODE;ode2re!1| |yi|)
                           (QREFELT $ 45)))))) 

(SDEFUN |UTSODE;ode2re!1| ((|yi| NIL)) |yi|) 

(SDEFUN |UTSODE;ode2re!0| (($$ NIL))
        (PROG (|y| $ |f|)
          (LETT |y| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |y| (SPADCALL |y| (QREFELT $ 47)) |f|))))) 

(SDEFUN |UTSODE;iOde2|
        ((|f|
          (|Mapping| (|Stream| |Coef|) (|Stream| |Coef|) (|Stream| |Coef|)))
         (|c0| (|Coef|)) (|c1| (|Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL (CONS #'|UTSODE;iOde2!0| (VECTOR $ |c1| |c0| |f|))
                         (QREFELT $ 34)))) 

(SDEFUN |UTSODE;iOde2!0| ((|s| NIL) ($$ NIL))
        (PROG (|f| |c0| |c1| $)
          (LETT |f| (QREFELT $$ 3))
          (LETT |c0| (QREFELT $$ 2))
          (LETT |c1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|UTSODE;ode2re| |f| |c0| |c1| |s| $))))) 

(SDEFUN |UTSODE;ode2;M2CoefUTS;13|
        ((|f| (|Mapping| UTS UTS UTS)) (|c0| (|Coef|)) (|c1| (|Coef|))
         ($ (UTS)))
        (SPADCALL (|UTSODE;iOde2| (SPADCALL |f| (QREFELT $ 16)) |c0| |c1| $)
                  (QREFELT $ 9))) 

(SDEFUN |UTSODE;odeNre|
        ((|f| (|Mapping| (|Stream| |Coef|) (|List| (|Stream| |Coef|))))
         (|cl| (|List| |Coef|)) (|yl| (|List| (|Stream| |Coef|)))
         ($ (|List| (|Stream| |Coef|))))
        (SPROG
         ((|yil| (|List| (|Stream| |Coef|))) (#1=#:G794 NIL) (|c| NIL)
          (#2=#:G795 NIL) (|y| NIL) (#3=#:G793 NIL))
         (SEQ
          (LETT |yil|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |y| NIL) (LETT #2# (CDR |yl|)) (LETT |c| NIL)
                      (LETT #1# |cl|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL)
                            (ATOM #2#) (PROGN (LETT |y| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (SPADCALL |c| (CONS #'|UTSODE;odeNre!0| |y|)
                                         (QREFELT $ 45))
                               #3#))))
                      (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                      (GO G190) G191 (EXIT (NREVERSE #3#)))))
          (EXIT (SPADCALL |yil| (LIST (SPADCALL |yil| |f|)) (QREFELT $ 49)))))) 

(SDEFUN |UTSODE;odeNre!0| ((|y| NIL)) |y|) 

(SDEFUN |UTSODE;iOde|
        ((|f| (|Mapping| (|Stream| |Coef|) (|List| (|Stream| |Coef|))))
         (|cl| (|List| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG NIL
               (|SPADfirst|
                (SPADCALL (CONS #'|UTSODE;iOde!0| (VECTOR $ |cl| |f|))
                          (+ (LENGTH |cl|) 1) (QREFELT $ 52))))) 

(SDEFUN |UTSODE;iOde!0| ((|ls| NIL) ($$ NIL))
        (PROG (|f| |cl| $)
          (LETT |f| (QREFELT $$ 2))
          (LETT |cl| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|UTSODE;odeNre| |f| |cl| |ls| $))))) 

(SDEFUN |UTSODE;ode;MLUTS;16|
        ((|f| (|Mapping| UTS (|List| UTS))) (|cl| (|List| |Coef|)) ($ (UTS)))
        (SPADCALL (|UTSODE;iOde| (SPADCALL |f| (QREFELT $ 24)) |cl| $)
                  (QREFELT $ 9))) 

(SDEFUN |UTSODE;simulre|
        ((|cst| (|List| |Coef|))
         (|lsf|
          (|List| (|Mapping| (|Stream| |Coef|) (|List| (|Stream| |Coef|)))))
         (|c| (|List| (|Stream| |Coef|))) ($ (|List| (|Stream| |Coef|))))
        (SPROG
         ((#1=#:G816 NIL) (|csti| NIL) (#2=#:G817 NIL) (|lsfi| NIL)
          (#3=#:G815 NIL))
         (SEQ
          (PROGN
           (LETT #3# NIL)
           (SEQ (LETT |lsfi| NIL) (LETT #2# |lsf|) (LETT |csti| NIL)
                (LETT #1# |cst|) G190
                (COND
                 ((OR (ATOM #1#) (PROGN (LETT |csti| (CAR #1#)) NIL) (ATOM #2#)
                      (PROGN (LETT |lsfi| (CAR #2#)) NIL))
                  (GO G191)))
                (SEQ
                 (EXIT
                  (LETT #3#
                        (CONS
                         (SPADCALL |csti|
                                   (CONS #'|UTSODE;simulre!0|
                                         (VECTOR |lsfi| |c| $))
                                   (QREFELT $ 45))
                         #3#))))
                (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                G191 (EXIT (NREVERSE #3#))))))) 

(SDEFUN |UTSODE;simulre!0| (($$ NIL))
        (PROG ($ |c| |lsfi|)
          (LETT $ (QREFELT $$ 2))
          (LETT |c| (QREFELT $$ 1))
          (LETT |lsfi| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL
              (SPADCALL (|spadConstant| $ 55) (|spadConstant| $ 57)
                        (QREFELT $ 58))
              |c| (QREFELT $ 59))
             |lsfi|))))) 

(SDEFUN |UTSODE;iMpsode|
        ((|cs| (|List| |Coef|))
         (|lsts|
          (|List| (|Mapping| (|Stream| |Coef|) (|List| (|Stream| |Coef|)))))
         ($ (|List| (|Stream| |Coef|))))
        (SPROG NIL
               (SPADCALL (CONS #'|UTSODE;iMpsode!0| (VECTOR $ |lsts| |cs|))
                         (LENGTH |cs|) (QREFELT $ 52)))) 

(SDEFUN |UTSODE;iMpsode!0| ((|ls| NIL) ($$ NIL))
        (PROG (|cs| |lsts| $)
          (LETT |cs| (QREFELT $$ 2))
          (LETT |lsts| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|UTSODE;simulre| |cs| |lsts| |ls| $))))) 

(SDEFUN |UTSODE;mpsode;LLL;19|
        ((|cs| (|List| |Coef|)) (|lsts| (|List| (|Mapping| UTS (|List| UTS))))
         ($ (|List| UTS)))
        (SPROG
         ((|stSol| (|List| (|Stream| |Coef|))) (#1=#:G829 NIL) (|lst| NIL)
          (#2=#:G828 NIL))
         (SEQ
          (LETT |stSol|
                (|UTSODE;iMpsode| |cs|
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |lst| NIL) (LETT #1# |lsts|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |lst| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS (SPADCALL |lst| (QREFELT $ 24)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 $))
          (EXIT (SPADCALL (ELT $ 9) |stSol| (QREFELT $ 21)))))) 

(DECLAIM (NOTINLINE |UnivariateTaylorSeriesODESolver;|)) 

(DEFUN |UnivariateTaylorSeriesODESolver| (&REST #1=#:G830)
  (SPROG NIL
         (PROG (#2=#:G831)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariateTaylorSeriesODESolver|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |UnivariateTaylorSeriesODESolver;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariateTaylorSeriesODESolver|)))))))))) 

(DEFUN |UnivariateTaylorSeriesODESolver;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|UnivariateTaylorSeriesODESolver| DV$1 DV$2))
          (LETT $ (GETREFV 62))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|UnivariateTaylorSeriesODESolver|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|UnivariateTaylorSeriesODESolver| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Stream| 6) (0 . |series|) (5 . |coefficients|) (|Mapping| 8 8)
              (|Mapping| 7 7) |UTSODE;stFunc1;MM;1| (|Mapping| 8 8 8)
              (|Mapping| 7 7 7) |UTSODE;stFunc2;MM;2| (|List| 7)
              (|Mapping| 7 8) (|List| 8) (|ListFunctions2| 8 7) (10 . |map|)
              (|Mapping| 8 19) (|Mapping| 7 17) |UTSODE;stFuncN;MM;3| (16 . *)
              (|StreamTaylorSeriesOperations| 6) (22 . *) (28 . -) (34 . *)
              (40 . |concat|) (|Mapping| $) (46 . |delay|)
              (|ParadoxicalCombinatorsForStreams| 6) (51 . Y) (|Boolean|)
              (56 . |empty?|) (61 . |empty|) (65 . |frst|) (70 . |rst|)
              (75 . |zero?|) (|Union| $ '"failed") (80 . |recip|)
              |UTSODE;fixedPointExquo;3UTS;7| (|Mapping| 8)
              (85 . |lazyIntegrate|) |UTSODE;ode1;MCoefUTS;10| (91 . |deriv|)
              |UTSODE;ode2;M2CoefUTS;13| (96 . |concat|) (|Mapping| 19 19)
              (|Integer|) (102 . Y) (|List| 6) |UTSODE;ode;MLUTS;16|
              (108 . |One|) (112 . |One|) (116 . |One|) (120 . |monom|)
              (126 . |concat|) (|List| 23) |UTSODE;mpsode;LLL;19|)
           '#(|stFuncN| 132 |stFunc2| 137 |stFunc1| 142 |ode2| 147 |ode1| 154
              |ode| 160 |mpsode| 166 |fixedPointExquo| 172)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|stFunc1|
                                 ((|Mapping| (|Stream| |#1|) (|Stream| |#1|))
                                  (|Mapping| |#2| |#2|)))
                                T)
                              '((|stFunc2|
                                 ((|Mapping| (|Stream| |#1|) (|Stream| |#1|)
                                             (|Stream| |#1|))
                                  (|Mapping| |#2| |#2| |#2|)))
                                T)
                              '((|stFuncN|
                                 ((|Mapping| (|Stream| |#1|)
                                             (|List| (|Stream| |#1|)))
                                  (|Mapping| |#2| (|List| |#2|))))
                                T)
                              '((|fixedPointExquo| (|#2| |#2| |#2|)) T)
                              '((|ode1| (|#2| (|Mapping| |#2| |#2|) |#1|)) T)
                              '((|ode2|
                                 (|#2| (|Mapping| |#2| |#2| |#2|) |#1| |#1|))
                                T)
                              '((|ode|
                                 (|#2| (|Mapping| |#2| (|List| |#2|))
                                  (|List| |#1|)))
                                T)
                              '((|mpsode|
                                 ((|List| |#2|) (|List| |#1|)
                                  (|List| (|Mapping| |#2| (|List| |#2|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 61
                                            '(1 7 0 8 9 1 7 8 0 10 2 20 17 18
                                              19 21 2 6 0 0 0 25 2 26 8 8 8 27
                                              2 26 8 8 8 28 2 26 8 6 8 29 2 8 0
                                              6 0 30 1 8 0 31 32 1 33 8 11 34 1
                                              8 35 0 36 0 8 0 37 1 8 6 0 38 1 8
                                              0 0 39 1 6 35 0 40 1 6 41 0 42 2
                                              26 8 6 44 45 1 26 8 8 47 2 19 0 0
                                              0 49 2 33 19 50 51 52 0 6 0 55 0
                                              7 0 56 0 51 0 57 2 26 8 6 51 58 2
                                              19 0 8 0 59 1 0 22 23 24 1 0 14
                                              15 16 1 0 11 12 13 3 0 7 15 6 6
                                              48 2 0 7 12 6 46 2 0 7 23 53 54 2
                                              0 17 53 60 61 2 0 7 7 7 43)))))
           '|lookupComplete|)) 

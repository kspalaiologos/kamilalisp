
(SDEFUN |INTRAT;infieldint;FU;1|
        ((|f| (|Fraction| UP)) ($ (|Union| (|Fraction| UP) "failed")))
        (SPROG
         ((|s1|
           (|Record| (|:| |ratpart| (|Fraction| UP))
                     (|:| |coeffs| (|Vector| F))))
          (|rec|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| UP))
                      (|:| |coeffs| (|Vector| F)))))
          (|ext|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| F))))
         (SEQ (LETT |ext| (CONS #'|INTRAT;infieldint;FU;1!0| $))
              (LETT |rec|
                    (SPADCALL (ELT $ 15) |ext| (ELT $ 12) (LIST |f|)
                              (QREFELT $ 24)))
              (EXIT
               (COND ((NULL |rec|) (CONS 1 "failed"))
                     ('T
                      (SEQ (LETT |s1| (|SPADfirst| |rec|))
                           (EXIT
                            (CONS 0
                                  (SPADCALL
                                   (SPADCALL (QCAR |s1|)
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL (QCDR |s1|) 1
                                                         (QREFELT $ 28))
                                               (QREFELT $ 29))
                                              (QREFELT $ 31))
                                             (QREFELT $ 32))
                                   (QREFELT $ 33))))))))))) 

(SDEFUN |INTRAT;infieldint;FU;1!0| ((|lg| NIL) ($ NIL))
        (SPROG ((#1=#:G708 NIL) (|bv| NIL) (#2=#:G707 NIL) (|r1| NIL))
               (SEQ
                (LETT |r1|
                      (SPADCALL (SPADCALL (LIST |lg|) (QREFELT $ 10))
                                (QREFELT $ 12)))
                (EXIT
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |bv| NIL) (LETT #1# |r1|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |bv| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS (CONS (|spadConstant| $ 13) |bv|) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |INTRAT;integrate;FIr;2|
        ((|f| (|Fraction| UP)) ($ (|IntegrationResult| (|Fraction| UP))))
        (SPROG
         ((|rec|
           (|Record| (|:| |ir| (|IntegrationResult| (|Fraction| UP)))
                     (|:| |specpart| (|Fraction| UP)) (|:| |polypart| UP))))
         (SEQ (LETT |rec| (SPADCALL |f| (ELT $ 15) (QREFELT $ 38)))
              (EXIT
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL (QVELT |rec| 2) (QREFELT $ 39))
                           (QREFELT $ 31))
                 (QREFELT $ 41))
                (QVELT |rec| 0) (QREFELT $ 42)))))) 

(DECLAIM (NOTINLINE |RationalIntegration;|)) 

(DEFUN |RationalIntegration| (&REST #1=#:G726)
  (SPROG NIL
         (PROG (#2=#:G727)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RationalIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RationalIntegration;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RationalIntegration|)))))))))) 

(DEFUN |RationalIntegration;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|RationalIntegration| DV$1 DV$2))
          (LETT $ (GETREFV 44))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalIntegration|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RationalIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|List| (|List| 6)) (|Matrix| 6) (0 . |matrix|) (|List| 27)
              (5 . |nullSpace|) (10 . |Zero|) (14 . |Zero|)
              (18 . |differentiate|)
              (|Record| (|:| |ratpart| 30) (|:| |coeffs| 27)) (|List| 16)
              (|Mapping| 7 7) (|Record| (|:| |ratpart| 6) (|:| |coeffs| 27))
              (|Mapping| (|List| 19) (|List| 6)) (|Mapping| 11 9) (|List| 30)
              (|ParametricTranscendentalIntegration| 6 7) (23 . |primextint|)
              (31 . |One|) (|Integer|) (|Vector| 6) (35 . |elt|)
              (41 . |coerce|) (|Fraction| 7) (46 . |coerce|) (51 . /) (57 . -)
              (|Union| 30 '#1="failed") |INTRAT;infieldint;FU;1|
              (|Record| (|:| |ir| 40) (|:| |specpart| 30) (|:| |polypart| 7))
              (|TranscendentalIntegration| 6 7) (62 . |monomialIntegrate|)
              (68 . |integrate|) (|IntegrationResult| 30) (73 . |coerce|)
              (78 . +) |INTRAT;integrate;FIr;2|)
           '#(|integrate| 84 |infieldint| 89) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|integrate|
                                 ((|IntegrationResult| (|Fraction| |#2|))
                                  (|Fraction| |#2|)))
                                T)
                              '((|infieldint|
                                 ((|Union| (|Fraction| |#2|) #1#)
                                  (|Fraction| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 43
                                            '(1 9 0 8 10 1 9 11 0 12 0 6 0 13 0
                                              7 0 14 1 7 0 0 15 4 23 17 18 20
                                              21 22 24 0 6 0 25 2 27 6 0 26 28
                                              1 7 0 6 29 1 30 0 7 31 2 30 0 0 0
                                              32 1 30 0 0 33 2 37 36 30 18 38 1
                                              7 0 0 39 1 40 0 30 41 2 40 0 0 0
                                              42 1 0 40 30 43 1 0 34 30 35)))))
           '|lookupComplete|)) 

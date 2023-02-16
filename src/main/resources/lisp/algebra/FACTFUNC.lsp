
(SDEFUN |FACTFUNC;nthRoot;FNniR;1|
        ((|ff| (|Factored| M)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| M)
                    (|:| |radicand| (|List| M)))))
        (SPROG
         ((#1=#:G738 NIL) (|radi| (|List| M)) (|coeff| (M))
          (|qr|
           (|Record| (|:| |quotient| (|NonNegativeInteger|))
                     (|:| |remainder| (|NonNegativeInteger|))))
          (#2=#:G741 NIL) (|term| NIL) (|d| (|NonNegativeInteger|))
          (#3=#:G720 NIL) (#4=#:G740 NIL) (|t| NIL) (#5=#:G739 NIL)
          (|lf|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| M)
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ (LETT |coeff| (|spadConstant| $ 7))
              (LETT |radi|
                    (COND
                     ((SPADCALL (SPADCALL |ff| (QREFELT $ 9))
                                (|spadConstant| $ 7) (QREFELT $ 11))
                      NIL)
                     (#6='T (LIST (SPADCALL |ff| (QREFELT $ 9))))))
              (LETT |lf| (SPADCALL |ff| (QREFELT $ 15)))
              (LETT |d|
                    (COND
                     ((NULL |radi|)
                      (PROG1
                          (LETT #3#
                                (SPADCALL
                                 (CONS |n|
                                       (PROGN
                                        (LETT #5# NIL)
                                        (SEQ (LETT |t| NIL) (LETT #4# |lf|)
                                             G190
                                             (COND
                                              ((OR (ATOM #4#)
                                                   (PROGN
                                                    (LETT |t| (CAR #4#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT #5#
                                                     (CONS (QVELT |t| 2)
                                                           #5#))))
                                             (LETT #4# (CDR #4#)) (GO G190)
                                             G191 (EXIT (NREVERSE #5#)))))
                                 (QREFELT $ 18)))
                        (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #3#)))
                     (#6# 1)))
              (LETT |n| (QUOTIENT2 |n| |d|))
              (SEQ (LETT |term| NIL) (LETT #2# |lf|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |term| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ
                      (LETT |qr|
                            (DIVIDE2 (QUOTIENT2 (QVELT |term| 2) |d|) |n|))
                      (LETT |coeff|
                            (SPADCALL |coeff|
                                      (SPADCALL (QVELT |term| 1) (QCAR |qr|)
                                                (QREFELT $ 20))
                                      (QREFELT $ 21)))
                      (EXIT
                       (COND
                        ((NULL (ZEROP (QCDR |qr|)))
                         (PROGN
                          (LETT #1#
                                (LETT |radi|
                                      (SPADCALL |radi|
                                                (SPADCALL (QVELT |term| 1)
                                                          (QCDR |qr|)
                                                          (QREFELT $ 20))
                                                (QREFELT $ 23))))
                          (GO #7=#:G733)))))))
                    #7# (EXIT #1#))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |n| |coeff| |radi|))))) 

(SDEFUN |FACTFUNC;log;FL;2|
        ((|ff| (|Factored| M))
         ($
          (|List|
           (|Record| (|:| |coef| (|NonNegativeInteger|)) (|:| |logand| M)))))
        (SPROG ((#1=#:G750 NIL) (|term| NIL) (#2=#:G749 NIL))
               (SEQ
                (CONS (CONS 1 (SPADCALL |ff| (QREFELT $ 9)))
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |term| NIL)
                            (LETT #1# (SPADCALL |ff| (QREFELT $ 15))) G190
                            (COND
                             ((OR (ATOM #1#)
                                  (PROGN (LETT |term| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS
                                     (CONS (QVELT |term| 2) (QVELT |term| 1))
                                     #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#)))))))) 

(DECLAIM (NOTINLINE |FactoredFunctions;|)) 

(DEFUN |FactoredFunctions| (#1=#:G751)
  (SPROG NIL
         (PROG (#2=#:G752)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FactoredFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FactoredFunctions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FactoredFunctions|)))))))))) 

(DEFUN |FactoredFunctions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FactoredFunctions| DV$1))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FactoredFunctions| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FactoredFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|) (|Factored| 6)
              (4 . |unit|) (|Boolean|) (9 . =)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 12) (|:| |factor| 6) (|:| |exponent| 19))
              (|List| 13) (15 . |factorList|) (|List| $) (|Integer|)
              (20 . |gcd|) (|NonNegativeInteger|) (25 . ^) (31 . *) (|List| 6)
              (37 . |concat!|)
              (|Record| (|:| |exponent| 19) (|:| |coef| 6) (|:| |radicand| 22))
              |FACTFUNC;nthRoot;FNniR;1| (43 . |One|)
              (|Record| (|:| |coef| 19) (|:| |logand| 6)) (|List| 27)
              |FACTFUNC;log;FL;2|)
           '#(|nthRoot| 47 |log| 53) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|nthRoot|
                                 ((|Record|
                                   (|:| |exponent| (|NonNegativeInteger|))
                                   (|:| |coef| |#1|)
                                   (|:| |radicand| (|List| |#1|)))
                                  (|Factored| |#1|) (|NonNegativeInteger|)))
                                T)
                              '((|log|
                                 ((|List|
                                   (|Record|
                                    (|:| |coef| (|NonNegativeInteger|))
                                    (|:| |logand| |#1|)))
                                  (|Factored| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 29
                                            '(0 6 0 7 1 8 6 0 9 2 6 10 0 0 11 1
                                              8 14 0 15 1 17 0 16 18 2 6 0 0 19
                                              20 2 6 0 0 0 21 2 22 0 0 6 23 0 8
                                              0 26 2 0 24 8 19 25 1 0 28 8
                                              29)))))
           '|lookupComplete|)) 

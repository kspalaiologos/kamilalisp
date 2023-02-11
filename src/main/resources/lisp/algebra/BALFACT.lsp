
(SDEFUN |BALFACT;balancedFactorisation;2UPF;1|
        ((|a| (UP)) (|b| (UP)) ($ (|Factored| UP)))
        (SPADCALL |a| (LIST |b|) (QREFELT $ 10))) 

(SDEFUN |BALFACT;balSqfr1|
        ((|a| (UP)) (|n| (|NonNegativeInteger|)) (|b| (UP))
         ($ (|Factored| UP)))
        (SPROG ((#1=#:G711 NIL) (|fa| (|Factored| UP)) (|g| (UP)))
               (SEQ (LETT |g| (SPADCALL |a| |b| (QREFELT $ 12)))
                    (LETT |fa|
                          (SPADCALL
                           (PROG2 (LETT #1# (SPADCALL |a| |g| (QREFELT $ 14)))
                               (QCDR #1#)
                             (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                             (|Union| (QREFELT $ 7)
                                                      #2="failed")
                                             #1#))
                           |n| (QREFELT $ 16)))
                    (EXIT
                     (COND ((SPADCALL |g| (QREFELT $ 18)) |fa|)
                           ('T
                            (SPADCALL |fa|
                                      (|BALFACT;balSqfr1| |g| |n|
                                       (PROG2
                                           (LETT #1#
                                                 (SPADCALL |b|
                                                           (SPADCALL |g|
                                                                     (SPADCALL
                                                                      |b| |g|
                                                                      (QREFELT
                                                                       $ 19))
                                                                     (QREFELT $
                                                                              20))
                                                           (QREFELT $ 14)))
                                           (QCDR #1#)
                                         (|check_union2| (QEQCAR #1# 0)
                                                         (QREFELT $ 7)
                                                         (|Union| (QREFELT $ 7)
                                                                  #2#)
                                                         #1#))
                                       $)
                                      (QREFELT $ 21)))))))) 

(SDEFUN |BALFACT;balSqfr|
        ((|a| (UP)) (|n| (|NonNegativeInteger|)) (|l| (|List| UP))
         ($ (|Factored| UP)))
        (SPROG
         ((#1=#:G718 NIL) (#2=#:G717 #3=(|Factored| UP)) (#4=#:G719 #3#)
          (#5=#:G722 NIL) (|f| NIL) (|b| (UP)))
         (SEQ (LETT |b| (|SPADfirst| |l|))
              (EXIT
               (COND ((NULL (CDR |l|)) (|BALFACT;balSqfr1| |a| |n| |b| $))
                     (#6='T
                      (PROGN
                       (LETT #1# NIL)
                       (SEQ (LETT |f| NIL)
                            (LETT #5#
                                  (SPADCALL
                                   (|BALFACT;balSqfr| |a| |n| (CDR |l|) $)
                                   (QREFELT $ 25)))
                            G190
                            (COND
                             ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (PROGN
                               (LETT #4#
                                     (|BALFACT;balSqfr1| (QVELT |f| 1) |n| |b|
                                      $))
                               (COND
                                (#1#
                                 (LETT #2# (SPADCALL #2# #4# (QREFELT $ 21))))
                                ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                            (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                       (COND (#1# #2#) (#6# (|spadConstant| $ 26)))))))))) 

(SDEFUN |BALFACT;balancedFactorisation;UPLF;4|
        ((|a| (UP)) (|l| (|List| UP)) ($ (|Factored| UP)))
        (SPROG
         ((#1=#:G726 NIL) (#2=#:G725 #3=(|Factored| UP)) (#4=#:G727 #3#)
          (#5=#:G731 NIL) (|f| NIL) (|sa| (|Factored| UP)) (|ll| (|List| UP)))
         (SEQ
          (COND
           ((NULL
             (LETT |ll|
                   (SPADCALL
                    (CONS #'|BALFACT;balancedFactorisation;UPLF;4!0| $) |l|
                    (QREFELT $ 31))))
            (|error| "balancedFactorisation: 2nd argument is empty or all 0"))
           (#6='T
            (SEQ (LETT |sa| (SPADCALL |a| (QREFELT $ 33)))
                 (EXIT
                  (SPADCALL (SPADCALL |sa| (QREFELT $ 34))
                            (PROGN
                             (LETT #1# NIL)
                             (SEQ (LETT |f| NIL)
                                  (LETT #5# (SPADCALL |sa| (QREFELT $ 25)))
                                  G190
                                  (COND
                                   ((OR (ATOM #5#)
                                        (PROGN (LETT |f| (CAR #5#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #4#
                                           (|BALFACT;balSqfr| (QVELT |f| 1)
                                            (QVELT |f| 2) |ll| $))
                                     (COND
                                      (#1#
                                       (LETT #2#
                                             (SPADCALL #2# #4#
                                                       (QREFELT $ 21))))
                                      ('T
                                       (PROGN
                                        (LETT #2# #4#)
                                        (LETT #1# 'T)))))))
                                  (LETT #5# (CDR #5#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#1# #2#) (#6# (|spadConstant| $ 26))))
                            (QREFELT $ 35))))))))) 

(SDEFUN |BALFACT;balancedFactorisation;UPLF;4!0| ((|z1| NIL) ($ NIL))
        (SPADCALL |z1| (|spadConstant| $ 28) (QREFELT $ 29))) 

(DECLAIM (NOTINLINE |BalancedFactorisation;|)) 

(DEFUN |BalancedFactorisation| (&REST #1=#:G732)
  (SPROG NIL
         (PROG (#2=#:G733)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|BalancedFactorisation|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |BalancedFactorisation;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|BalancedFactorisation|)))))))))) 

(DEFUN |BalancedFactorisation;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|BalancedFactorisation| DV$1 DV$2))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|BalancedFactorisation|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|BalancedFactorisation| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Factored| 7) (|List| 7) |BALFACT;balancedFactorisation;UPLF;4|
              |BALFACT;balancedFactorisation;2UPF;1| (0 . |gcd|)
              (|Union| $ '"failed") (6 . |exquo|) (|NonNegativeInteger|)
              (12 . |sqfrFactor|) (|Boolean|) (18 . |ground?|) (23 . |order|)
              (29 . ^) (35 . *) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 22) (|:| |factor| 7) (|:| |exponent| 15))
              (|List| 23) (41 . |factorList|) (46 . |One|) (50 . |Zero|)
              (54 . |Zero|) (58 . ~=) (|Mapping| 17 7) (64 . |select|)
              (|Factored| $) (70 . |squareFree|) (75 . |unit|) (80 . *))
           '#(|balancedFactorisation| 86) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|balancedFactorisation|
                                 ((|Factored| |#2|) |#2| |#2|))
                                T)
                              '((|balancedFactorisation|
                                 ((|Factored| |#2|) |#2| (|List| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 35
                                            '(2 7 0 0 0 12 2 7 13 0 0 14 2 8 0
                                              7 15 16 1 7 17 0 18 2 7 15 0 0 19
                                              2 7 0 0 15 20 2 8 0 0 0 21 1 8 24
                                              0 25 0 8 0 26 0 6 0 27 0 7 0 28 2
                                              7 17 0 0 29 2 9 0 30 0 31 1 7 32
                                              0 33 1 8 7 0 34 2 8 0 7 0 35 2 0
                                              8 7 9 10 2 0 8 7 7 11)))))
           '|lookupComplete|)) 

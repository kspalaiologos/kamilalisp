
(SDEFUN |POLYROOT;zroot|
        ((|x| (|Integer|)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|))
                    (|:| |coef| (|Integer|)) (|:| |radicand| (|Integer|)))))
        (SPROG
         ((#1=#:G715 NIL) (#2=#:G714 #3=(|Integer|)) (#4=#:G716 #3#)
          (#5=#:G719 NIL) (#6=#:G689 NIL)
          (|s|
           (|Record| (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coef| (|Integer|)) (|:| |radicand| (|List| #3#)))))
         (SEQ
          (COND ((OR (ZEROP |x|) (EQL |x| 1)) (VECTOR 1 |x| 1))
                ('T
                 (SEQ
                  (LETT |s|
                        (SPADCALL (SPADCALL |x| (QREFELT $ 15)) |n|
                                  (QREFELT $ 20)))
                  (EXIT
                   (VECTOR (QVELT |s| 0) (QVELT |s| 1)
                           (PROGN
                            (LETT #1# NIL)
                            (SEQ (LETT #6# NIL) (LETT #5# (QVELT |s| 2)) G190
                                 (COND
                                  ((OR (ATOM #5#)
                                       (PROGN (LETT #6# (CAR #5#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (PROGN
                                    (LETT #4# #6#)
                                    (COND (#1# (LETT #2# (* #2# #4#)))
                                          ('T
                                           (PROGN
                                            (LETT #2# #4#)
                                            (LETT #1# 'T)))))))
                                 (LETT #5# (CDR #5#)) (GO G190) G191
                                 (EXIT NIL))
                            (COND (#1# #2#) ('T 1))))))))))) 

(SDEFUN |POLYROOT;czroot|
        ((|x| (|Integer|)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                    (|:| |radicand| F))))
        (SPROG
         ((|rec|
           (|Record| (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coef| (|Integer|)) (|:| |radicand| (|Integer|)))))
         (SEQ (LETT |rec| (|POLYROOT;zroot| |x| |n| $))
              (COND
               ((EQL (QVELT |rec| 0) 2)
                (COND
                 ((< (QVELT |rec| 2) 0)
                  (EXIT
                   (VECTOR (QVELT |rec| 0)
                           (SPADCALL (QVELT |rec| 1)
                                     (SPADCALL
                                      (SPADCALL (SPADCALL (QREFELT $ 21))
                                                (QREFELT $ 22))
                                      (QREFELT $ 23))
                                     (QREFELT $ 24))
                           (SPADCALL (- (QVELT |rec| 2)) (QREFELT $ 25))))))))
              (EXIT
               (VECTOR (QVELT |rec| 0)
                       (SPADCALL (QVELT |rec| 1) (QREFELT $ 25))
                       (SPADCALL (QVELT |rec| 2) (QREFELT $ 25))))))) 

(SDEFUN |POLYROOT;qroot;FNniR;3|
        ((|x| (|Fraction| (|Integer|))) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                    (|:| |radicand| F))))
        (SPROG
         ((|m| (|NonNegativeInteger|)) (#1=#:G732 NIL)
          (|sd|
           #2=(|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                        (|:| |radicand| F)))
          (|sn| #2#))
         (SEQ
          (LETT |sn| (|POLYROOT;czroot| (SPADCALL |x| (QREFELT $ 27)) |n| $))
          (LETT |sd| (|POLYROOT;czroot| (SPADCALL |x| (QREFELT $ 28)) |n| $))
          (LETT |m|
                (PROG1
                    (LETT #1#
                          (SPADCALL (QVELT |sn| 0) (QVELT |sd| 0)
                                    (QREFELT $ 29)))
                  (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #1#)))
          (EXIT
           (VECTOR |m| (SPADCALL (QVELT |sn| 1) (QVELT |sd| 1) (QREFELT $ 30))
                   (SPADCALL
                    (SPADCALL (QVELT |sn| 2) (QUOTIENT2 |m| (QVELT |sn| 0))
                              (QREFELT $ 31))
                    (SPADCALL (QVELT |sd| 2) (QUOTIENT2 |m| (QVELT |sd| 0))
                              (QREFELT $ 31))
                    (QREFELT $ 30))))))) 

(SDEFUN |POLYROOT;qroot;FNniR;4|
        ((|x| (|Fraction| (|Integer|))) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                    (|:| |radicand| F))))
        (SPROG
         ((|m| (|NonNegativeInteger|)) (#1=#:G738 NIL)
          (|sd|
           #2=(|Record| (|:| |exponent| (|NonNegativeInteger|))
                        (|:| |coef| (|Integer|)) (|:| |radicand| (|Integer|))))
          (|sn| #2#))
         (SEQ
          (LETT |sn| (|POLYROOT;zroot| (SPADCALL |x| (QREFELT $ 27)) |n| $))
          (LETT |sd| (|POLYROOT;zroot| (SPADCALL |x| (QREFELT $ 28)) |n| $))
          (LETT |m|
                (PROG1
                    (LETT #1#
                          (SPADCALL (QVELT |sn| 0) (QVELT |sd| 0)
                                    (QREFELT $ 29)))
                  (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #1#)))
          (EXIT
           (VECTOR |m|
                   (SPADCALL (SPADCALL (QVELT |sn| 1) (QREFELT $ 25))
                             (SPADCALL (QVELT |sd| 1) (QREFELT $ 25))
                             (QREFELT $ 30))
                   (SPADCALL
                    (SPADCALL
                     (EXPT (QVELT |sn| 2) (QUOTIENT2 |m| (QVELT |sn| 0)))
                     (QREFELT $ 25))
                    (SPADCALL
                     (EXPT (QVELT |sd| 2) (QUOTIENT2 |m| (QVELT |sd| 0)))
                     (QREFELT $ 25))
                    (QREFELT $ 30))))))) 

(SDEFUN |POLYROOT;rroot;RNniR;5|
        ((|x| (R)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                    (|:| |radicand| F))))
        (SPROG ((|r| (|Union| (|Fraction| (|Integer|)) "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 35)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 1)
                       (VECTOR |n| (|spadConstant| $ 36)
                               (SPADCALL (SPADCALL |x| (QREFELT $ 22))
                                         (QREFELT $ 23))))
                      ('T (SPADCALL (QCDR |r|) |n| (QREFELT $ 33)))))))) 

(SDEFUN |POLYROOT;rroot;RNniR;6|
        ((|x| (R)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                    (|:| |radicand| F))))
        (SPROG ((|r| (|Union| (|Integer|) "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 39)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 1)
                       (VECTOR |n| (|spadConstant| $ 36)
                               (SPADCALL (SPADCALL |x| (QREFELT $ 22))
                                         (QREFELT $ 23))))
                      ('T
                       (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 40)) |n|
                                 (QREFELT $ 33)))))))) 

(SDEFUN |POLYROOT;rroot;RNniR;7|
        ((|x| (R)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                    (|:| |radicand| F))))
        (VECTOR |n| (|spadConstant| $ 36)
                (SPADCALL (SPADCALL |x| (QREFELT $ 22)) (QREFELT $ 23)))) 

(SDEFUN |POLYROOT;rsplit|
        ((|l| (|List| P)) ($ (|Record| (|:| |coef| R) (|:| |poly| P))))
        (SPROG
         ((|r| (R)) (|p| (P)) (|u| (|Union| R "failed")) (#1=#:G764 NIL)
          (|q| NIL))
         (SEQ (LETT |r| (|spadConstant| $ 11)) (LETT |p| (|spadConstant| $ 12))
              (SEQ (LETT |q| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |q| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |u| (SPADCALL |q| (QREFELT $ 42)))
                        (EXIT
                         (COND
                          ((QEQCAR |u| 1)
                           (LETT |p| (SPADCALL |p| |q| (QREFELT $ 43))))
                          ('T
                           (LETT |r|
                                 (SPADCALL |r| (QCDR |u|) (QREFELT $ 44)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |r| |p|))))) 

(SDEFUN |POLYROOT;nthr;PNniR;9|
        ((|x| (P)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| P)
                    (|:| |radicand| (|List| P)))))
        (SPROG
         ((|rec|
           (|Record| (|:| |exponent| (|NonNegativeInteger|))
                     (|:| |coef| (|Integer|)) (|:| |radicand| (|Integer|))))
          (|r| (|Union| (|Integer|) "failed")))
         (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 45)))
              (EXIT
               (COND
                ((QEQCAR |r| 1)
                 (SPADCALL (SPADCALL |x| (QREFELT $ 46)) |n| (QREFELT $ 50)))
                ('T
                 (SEQ (LETT |rec| (|POLYROOT;zroot| (QCDR |r|) |n| $))
                      (EXIT
                       (VECTOR (QVELT |rec| 0)
                               (SPADCALL (QVELT |rec| 1) (QREFELT $ 51))
                               (LIST
                                (SPADCALL (QVELT |rec| 2)
                                          (QREFELT $ 51)))))))))))) 

(SDEFUN |POLYROOT;nthr;PNniR;10|
        ((|x| (P)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| P)
                    (|:| |radicand| (|List| P)))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 46)) |n| (QREFELT $ 50))) 

(SDEFUN |POLYROOT;froot;FNniR;11|
        ((|x| (F)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                    (|:| |radicand| F))))
        (SPROG
         ((|m| (|NonNegativeInteger|)) (#1=#:G779 NIL)
          (|rd|
           #2=(|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                        (|:| |radicand| F)))
          (|rn| #2#) (|pd| #3=(|Record| (|:| |coef| R) (|:| |poly| P)))
          (|pn| #3#)
          (|sd|
           #4=(|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| P)
                        (|:| |radicand| (|List| P))))
          (|sn| #4#))
         (SEQ
          (COND
           ((OR (SPADCALL |x| (QREFELT $ 54))
                (SPADCALL |x| (|spadConstant| $ 36) (QREFELT $ 55)))
            (VECTOR 1 |x| (|spadConstant| $ 36)))
           ('T
            (SEQ
             (LETT |sn|
                   (SPADCALL (SPADCALL |x| (QREFELT $ 56)) |n| (QREFELT $ 52)))
             (LETT |sd|
                   (SPADCALL (SPADCALL |x| (QREFELT $ 57)) |n| (QREFELT $ 52)))
             (LETT |pn| (|POLYROOT;rsplit| (QVELT |sn| 2) $))
             (LETT |pd| (|POLYROOT;rsplit| (QVELT |sd| 2) $))
             (LETT |rn| (SPADCALL (QCAR |pn|) (QVELT |sn| 0) (QREFELT $ 37)))
             (LETT |rd| (SPADCALL (QCAR |pd|) (QVELT |sd| 0) (QREFELT $ 37)))
             (LETT |m|
                   (PROG1
                       (LETT #1#
                             (SPADCALL
                              (LIST (QVELT |rn| 0) (QVELT |rd| 0)
                                    (QVELT |sn| 0) (QVELT |sd| 0))
                              (QREFELT $ 59)))
                     (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #1#)))
             (EXIT
              (VECTOR |m|
                      (SPADCALL
                       (SPADCALL (SPADCALL (QVELT |sn| 1) (QREFELT $ 23))
                                 (SPADCALL (QVELT |sd| 1) (QREFELT $ 23))
                                 (QREFELT $ 30))
                       (SPADCALL (QVELT |rn| 1) (QVELT |rd| 1) (QREFELT $ 30))
                       (QREFELT $ 60))
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (QVELT |rn| 2)
                                   (QUOTIENT2 |m| (QVELT |rn| 0))
                                   (QREFELT $ 31))
                         (SPADCALL (QVELT |rd| 2)
                                   (QUOTIENT2 |m| (QVELT |rd| 0))
                                   (QREFELT $ 31))
                         (QREFELT $ 30))
                        (SPADCALL
                         (SPADCALL (QCDR |pn|) (QUOTIENT2 |m| (QVELT |sn| 0))
                                   (QREFELT $ 61))
                         (QREFELT $ 23))
                        (QREFELT $ 60))
                       (SPADCALL
                        (SPADCALL (QCDR |pd|) (QUOTIENT2 |m| (QVELT |sd| 0))
                                  (QREFELT $ 61))
                        (QREFELT $ 23))
                       (QREFELT $ 30)))))))))) 

(DECLAIM (NOTINLINE |PolynomialRoots;|)) 

(DEFUN |PolynomialRoots| (&REST #1=#:G782)
  (SPROG NIL
         (PROG (#2=#:G783)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialRoots|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PolynomialRoots;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PolynomialRoots|)))))))))) 

(DEFUN |PolynomialRoots;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|PolynomialRoots| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 63))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#3| '(|GcdDomain|))))))
    (|haddProp| |$ConstructorCache| '|PolynomialRoots|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasSignature| |#3| (LIST '|imaginary| (LIST (|devaluate| |#3|))))
      (PROGN
       (QSETREFV $ 33 (CONS (|dispatchFunction| |POLYROOT;qroot;FNniR;3|) $))))
     ('T
      (QSETREFV $ 33 (CONS (|dispatchFunction| |POLYROOT;qroot;FNniR;4|) $))))
    (COND
     ((|HasCategory| |#3| '(|RetractableTo| (|Fraction| (|Integer|))))
      (QSETREFV $ 37 (CONS (|dispatchFunction| |POLYROOT;rroot;RNniR;5|) $)))
     ((|HasCategory| |#3| '(|RetractableTo| (|Integer|)))
      (QSETREFV $ 37 (CONS (|dispatchFunction| |POLYROOT;rroot;RNniR;6|) $)))
     ('T
      (QSETREFV $ 37 (CONS (|dispatchFunction| |POLYROOT;rroot;RNniR;7|) $))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (COND
        ((|HasCategory| |#3| '(|RetractableTo| (|Integer|)))
         (QSETREFV $ 52 (CONS (|dispatchFunction| |POLYROOT;nthr;PNniR;9|) $)))
        ('T
         (QSETREFV $ 52
                   (CONS (|dispatchFunction| |POLYROOT;nthr;PNniR;10|) $))))
       (QSETREFV $ 62
                 (CONS (|dispatchFunction| |POLYROOT;froot;FNniR;11|) $)))))
    $))) 

(MAKEPROP '|PolynomialRoots| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (0 . |One|)
              (4 . |One|) (|Factored| $) (|Integer|) (8 . |squareFree|)
              (|Record| (|:| |exponent| 18) (|:| |coef| 14)
                        (|:| |radicand| (|List| 14)))
              (|Factored| 14) (|NonNegativeInteger|) (|FactoredFunctions| 14)
              (13 . |nthRoot|) (19 . |imaginary|) (23 . |coerce|)
              (28 . |coerce|) (33 . *) (39 . |coerce|) (|Fraction| 14)
              (44 . |numer|) (49 . |denom|) (54 . |lcm|) (60 . /) (66 . ^)
              (|Record| (|:| |exponent| 18) (|:| |coef| 10)
                        (|:| |radicand| 10))
              (72 . |qroot|) (|Union| 26 '#1="failed") (78 . |retractIfCan|)
              (83 . |One|) (87 . |rroot|) (|Union| 14 '#1#)
              (93 . |retractIfCan|) (98 . |coerce|) (|Union| 8 '#1#)
              (103 . |retractIfCan|) (108 . *) (114 . *) (120 . |retractIfCan|)
              (125 . |squareFree|)
              (|Record| (|:| |exponent| 18) (|:| |coef| 9)
                        (|:| |radicand| (|List| 9)))
              (|Factored| 9) (|FactoredFunctions| 9) (130 . |nthRoot|)
              (136 . |coerce|) (141 . |nthr|) (|Boolean|) (147 . |zero?|)
              (152 . =) (158 . |numer|) (163 . |denom|) (|List| $)
              (168 . |lcm|) (173 . *) (179 . ^) (185 . |froot|))
           '#(|rroot| 191 |qroot| 197 |nthr| 203 |froot| 209) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rroot|
                                 ((|Record|
                                   (|:| |exponent| (|NonNegativeInteger|))
                                   (|:| |coef| |#5|) (|:| |radicand| |#5|))
                                  |#3| (|NonNegativeInteger|)))
                                T)
                              '((|qroot|
                                 ((|Record|
                                   (|:| |exponent| (|NonNegativeInteger|))
                                   (|:| |coef| |#5|) (|:| |radicand| |#5|))
                                  (|Fraction| (|Integer|))
                                  (|NonNegativeInteger|)))
                                T)
                              '((|froot|
                                 ((|Record|
                                   (|:| |exponent| (|NonNegativeInteger|))
                                   (|:| |coef| |#5|) (|:| |radicand| |#5|))
                                  |#5| (|NonNegativeInteger|)))
                                (|has| 8 (|GcdDomain|)))
                              '((|nthr|
                                 ((|Record|
                                   (|:| |exponent| (|NonNegativeInteger|))
                                   (|:| |coef| |#4|)
                                   (|:| |radicand| (|List| |#4|)))
                                  |#4| (|NonNegativeInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 62
                                            '(0 8 0 11 0 9 0 12 1 14 13 0 15 2
                                              19 16 17 18 20 0 8 0 21 1 9 0 8
                                              22 1 10 0 9 23 2 10 0 14 0 24 1
                                              10 0 14 25 1 26 14 0 27 1 26 14 0
                                              28 2 14 0 0 0 29 2 10 0 0 0 30 2
                                              10 0 0 18 31 2 0 32 26 18 33 1 8
                                              34 0 35 0 10 0 36 2 0 32 8 18 37
                                              1 8 38 0 39 1 26 0 14 40 1 9 41 0
                                              42 2 9 0 0 0 43 2 8 0 0 0 44 1 9
                                              38 0 45 1 9 13 0 46 2 49 47 48 18
                                              50 1 9 0 14 51 2 0 47 9 18 52 1
                                              10 53 0 54 2 10 53 0 0 55 1 10 9
                                              0 56 1 10 9 0 57 1 14 0 58 59 2
                                              10 0 0 0 60 2 9 0 0 18 61 2 0 32
                                              10 18 62 2 0 32 8 18 37 2 0 32 26
                                              18 33 2 0 47 9 18 52 2 1 32 10 18
                                              62)))))
           '|lookupComplete|)) 

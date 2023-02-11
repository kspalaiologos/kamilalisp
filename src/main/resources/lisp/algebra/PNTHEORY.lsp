
(SDEFUN |PNTHEORY;MonicQuotient|
        ((|a| (|SparseUnivariatePolynomial| (|Integer|)))
         (|b| (|SparseUnivariatePolynomial| (|Integer|)))
         ($ (|SparseUnivariatePolynomial| (|Integer|))))
        (SPROG
         ((|da| #1=(|NonNegativeInteger|))
          (|q| (|SparseUnivariatePolynomial| (|Integer|)))
          (|t| (|SparseUnivariatePolynomial| (|Integer|))) (#2=#:G714 NIL)
          (|db| #1#))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |b| (QREFELT $ 26)) 1 (QREFELT $ 28))
            (|error| "divisor must be monic"))
           ((SPADCALL |b| (|spadConstant| $ 7) (QREFELT $ 29)) |a|)
           ('T
            (SEQ (LETT |da| (SPADCALL |a| (QREFELT $ 30)))
                 (LETT |db| (SPADCALL |b| (QREFELT $ 30)))
                 (LETT |q| (|spadConstant| $ 17))
                 (SEQ G190 (COND ((NULL (>= |da| |db|)) (GO G191)))
                      (SEQ
                       (LETT |t|
                             (SPADCALL (SPADCALL |a| (QREFELT $ 26))
                                       (PROG1 (LETT #2# (- |da| |db|))
                                         (|check_subtype2| (>= #2# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #2#))
                                       (QREFELT $ 10)))
                       (LETT |a|
                             (SPADCALL |a| (SPADCALL |b| |t| (QREFELT $ 31))
                                       (QREFELT $ 32)))
                       (LETT |q| (SPADCALL |q| |t| (QREFELT $ 33)))
                       (EXIT (LETT |da| (SPADCALL |a| (QREFELT $ 30)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT |q|))))))) 

(SDEFUN |PNTHEORY;cyclotomic;ISup;2|
        ((|n| (|Integer|)) ($ (|SparseUnivariatePolynomial| (|Integer|))))
        (SPADCALL |n| (QREFELT $ 35))) 

(SDEFUN |PNTHEORY;euler;ISup;3|
        ((|n| (|Integer|))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|p| #1=(|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|c| (|Fraction| (|Integer|))) (#2=#:G728 NIL)
          (|t| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (#3=#:G734 NIL) (|i| NIL) (|s| #4=(|Integer|))
          (|#G8|
           (|Record| (|:| |En| (|Integer|))
                     (|:| |Ev|
                          (|SparseUnivariatePolynomial|
                           (|Fraction| (|Integer|))))))
          (|#G7| #1#) (|#G6| #4#))
         (SEQ
          (COND ((< |n| 0) (|error| "euler not defined for negative integers"))
                (#5='T
                 (SEQ
                  (COND
                   ((< |n| (QCAR (QREFELT $ 19)))
                    (PROGN
                     (LETT |#G6| 0)
                     (LETT |#G7| (|spadConstant| $ 18))
                     (LETT |s| |#G6|)
                     (LETT |p| |#G7|)))
                   (#5#
                    (PROGN
                     (LETT |#G8| (QREFELT $ 19))
                     (LETT |s| (QCAR |#G8|))
                     (LETT |p| (QCDR |#G8|))
                     |#G8|)))
                  (SEQ (LETT |i| (+ |s| 1)) (LETT #3# |n|) G190
                       (COND ((> |i| #3#) (GO G191)))
                       (SEQ
                        (LETT |t|
                              (SPADCALL (SPADCALL |i| (QREFELT $ 37))
                                        (SPADCALL |p| (QREFELT $ 38))
                                        (QREFELT $ 39)))
                        (LETT |c|
                              (SPADCALL
                               (SPADCALL (SPADCALL |i| (QREFELT $ 41))
                                         (EXPT 2
                                               (PROG1 (LETT #2# |i|)
                                                 (|check_subtype2| (>= #2# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #2#)))
                                         (QREFELT $ 42))
                               (SPADCALL |t| (SPADCALL 1 2 (QREFELT $ 42))
                                         (QREFELT $ 43))
                               (QREFELT $ 44)))
                        (EXIT
                         (LETT |p|
                               (SPADCALL |t| (SPADCALL |c| (QREFELT $ 45))
                                         (QREFELT $ 46)))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                  (PROGN (RPLACA (QREFELT $ 19) |n|) (QCAR (QREFELT $ 19)))
                  (PROGN (RPLACD (QREFELT $ 19) |p|) (QCDR (QREFELT $ 19)))
                  (EXIT |p|))))))) 

(SDEFUN |PNTHEORY;bernoulli;ISup;4|
        ((|n| (|Integer|))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|p| #1=(|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|c| (|Fraction| (|Integer|)))
          (|t| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (#2=#:G742 NIL) (|i| NIL) (|s| #3=(|Integer|))
          (|#G15|
           (|Record| (|:| |Bn| (|Integer|))
                     (|:| |Bv|
                          (|SparseUnivariatePolynomial|
                           (|Fraction| (|Integer|))))))
          (|#G14| #1#) (|#G13| #3#))
         (SEQ
          (COND
           ((< |n| 0) (|error| "bernoulli not defined for negative integers"))
           (#4='T
            (SEQ
             (COND
              ((< |n| (QCAR (QREFELT $ 20)))
               (PROGN
                (LETT |#G13| 0)
                (LETT |#G14| (|spadConstant| $ 18))
                (LETT |s| |#G13|)
                (LETT |p| |#G14|)))
              (#4#
               (PROGN
                (LETT |#G15| (QREFELT $ 20))
                (LETT |s| (QCAR |#G15|))
                (LETT |p| (QCDR |#G15|))
                |#G15|)))
             (SEQ (LETT |i| (+ |s| 1)) (LETT #2# |n|) G190
                  (COND ((> |i| #2#) (GO G191)))
                  (SEQ
                   (LETT |t|
                         (SPADCALL (SPADCALL |i| (QREFELT $ 37))
                                   (SPADCALL |p| (QREFELT $ 38))
                                   (QREFELT $ 39)))
                   (LETT |c| (SPADCALL |i| (QREFELT $ 48)))
                   (EXIT
                    (LETT |p|
                          (SPADCALL |t| (SPADCALL |c| (QREFELT $ 45))
                                    (QREFELT $ 46)))))
                  (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
             (PROGN (RPLACA (QREFELT $ 20) |n|) (QCAR (QREFELT $ 20)))
             (PROGN (RPLACD (QREFELT $ 20) |p|) (QCDR (QREFELT $ 20)))
             (EXIT |p|))))))) 

(SDEFUN |PNTHEORY;fixedDivisor;SupI;5|
        ((|a| (|SparseUnivariatePolynomial| (|Integer|))) ($ (|Integer|)))
        (SPROG
         ((|g| (|Integer|)) (#1=#:G747 NIL) (|k| NIL)
          (|d| (|NonNegativeInteger|)))
         (SEQ (|SparseUnivariatePolynomial| (|Integer|))
              (LETT |d| (SPADCALL |a| (QREFELT $ 30)))
              (LETT |g|
                    (SPADCALL |a| (SPADCALL |a| (QREFELT $ 50))
                              (QREFELT $ 51)))
              (SEQ (LETT |k| 1) (LETT #1# |d|) G190
                   (COND
                    ((OR (|greater_SI| |k| #1#) (NULL (> |g| 1))) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |g| (GCD |g| (SPADCALL |a| |k| (QREFELT $ 52))))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT |g|)))) 

(SDEFUN |PNTHEORY;hermite;ISup;6|
        ((|n| (|Integer|)) ($ (|SparseUnivariatePolynomial| (|Integer|))))
        (SPROG
         ((|q| (|SparseUnivariatePolynomial| (|Integer|)))
          (|p| #1=(|SparseUnivariatePolynomial| (|Integer|))) (|#G28| #1#)
          (|#G27| (|SparseUnivariatePolynomial| (|Integer|))) (#2=#:G755 NIL)
          (|k| NIL) (|s| (|Integer|))
          (|#G22|
           (|Record| (|:| |Hn| (|Integer|))
                     (|:| H1 (|SparseUnivariatePolynomial| (|Integer|)))
                     (|:| H2 (|SparseUnivariatePolynomial| (|Integer|))))))
         (SEQ
          (COND
           ((< |n| 0) (|error| "hermite not defined for negative integers"))
           (#3='T
            (SEQ
             (COND
              ((< |n| (QVELT (QREFELT $ 21) 0))
               (SEQ (LETT |s| 0) (LETT |p| (|spadConstant| $ 7))
                    (EXIT (LETT |q| (QREFELT $ 11)))))
              (#3#
               (PROGN
                (LETT |#G22| (QREFELT $ 21))
                (LETT |s| (QVELT |#G22| 0))
                (LETT |p| (QVELT |#G22| 1))
                (LETT |q| (QVELT |#G22| 2))
                |#G22|)))
             (SEQ (LETT |k| (+ |s| 1)) (LETT #2# |n|) G190
                  (COND ((> |k| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT |#G27|
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL 2 (QREFELT $ 11) (QREFELT $ 55)) |p|
                             (QREFELT $ 31))
                            (SPADCALL (* 2 (- |k| 1)) |q| (QREFELT $ 56))
                            (QREFELT $ 32)))
                     (LETT |#G28| |p|)
                     (LETT |p| |#G27|)
                     (LETT |q| |#G28|))))
                  (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
             (QSETVELT (QREFELT $ 21) 0 |n|) (QSETVELT (QREFELT $ 21) 1 |p|)
             (QSETVELT (QREFELT $ 21) 2 |q|) (EXIT |p|))))))) 

(SDEFUN |PNTHEORY;legendre;ISup;7|
        ((|n| (|Integer|))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
        (SPROG
         ((|q| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|p| #1=(|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|#G36| #1#)
          (|#G35| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|t| (|Integer|)) (#2=#:G764 NIL) (|k| NIL) (|s| (|Integer|))
          (|#G30|
           (|Record| (|:| |Pn| (|Integer|))
                     (|:| P1
                          (|SparseUnivariatePolynomial|
                           (|Fraction| (|Integer|))))
                     (|:| P2
                          (|SparseUnivariatePolynomial|
                           (|Fraction| (|Integer|)))))))
         (SEQ
          (COND
           ((< |n| 0) (|error| "legendre not defined for negative integers"))
           (#3='T
            (SEQ
             (COND
              ((< |n| (QVELT (QREFELT $ 23) 0))
               (SEQ (LETT |s| 0) (LETT |p| (|spadConstant| $ 18))
                    (EXIT (LETT |q| (QREFELT $ 16)))))
              (#3#
               (PROGN
                (LETT |#G30| (QREFELT $ 23))
                (LETT |s| (QVELT |#G30| 0))
                (LETT |p| (QVELT |#G30| 1))
                (LETT |q| (QVELT |#G30| 2))
                |#G30|)))
             (SEQ (LETT |k| (+ |s| 1)) (LETT #2# |n|) G190
                  (COND ((> |k| #2#) (GO G191)))
                  (SEQ (LETT |t| (- |k| 1))
                       (EXIT
                        (PROGN
                         (LETT |#G35|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (+ |k| |t|) |k| (QREFELT $ 42))
                                  (QREFELT $ 16) (QREFELT $ 39))
                                 |p| (QREFELT $ 58))
                                (SPADCALL (SPADCALL |t| |k| (QREFELT $ 42)) |q|
                                          (QREFELT $ 39))
                                (QREFELT $ 59)))
                         (LETT |#G36| |p|)
                         (LETT |p| |#G35|)
                         (LETT |q| |#G36|))))
                  (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
             (QSETVELT (QREFELT $ 23) 0 |n|) (QSETVELT (QREFELT $ 23) 1 |p|)
             (QSETVELT (QREFELT $ 23) 2 |q|) (EXIT |p|))))))) 

(SDEFUN |PNTHEORY;laguerre;ISup;8|
        ((|n| (|Integer|)) ($ (|SparseUnivariatePolynomial| (|Integer|))))
        (SPROG
         ((|q| (|SparseUnivariatePolynomial| (|Integer|)))
          (|p| #1=(|SparseUnivariatePolynomial| (|Integer|))) (|#G44| #1#)
          (|#G43| (|SparseUnivariatePolynomial| (|Integer|))) (|t| (|Integer|))
          (#2=#:G773 NIL) (|k| NIL) (|s| (|Integer|))
          (|#G38|
           (|Record| (|:| |Ln| (|Integer|))
                     (|:| L1 (|SparseUnivariatePolynomial| (|Integer|)))
                     (|:| L2 (|SparseUnivariatePolynomial| (|Integer|))))))
         (SEQ
          (COND
           ((< |n| 0) (|error| "laguerre not defined for negative integers"))
           (#3='T
            (SEQ
             (COND
              ((< |n| (QVELT (QREFELT $ 22) 0))
               (SEQ (LETT |s| 0) (LETT |p| (|spadConstant| $ 7))
                    (EXIT (LETT |q| (QREFELT $ 11)))))
              (#3#
               (PROGN
                (LETT |#G38| (QREFELT $ 22))
                (LETT |s| (QVELT |#G38| 0))
                (LETT |p| (QVELT |#G38| 1))
                (LETT |q| (QVELT |#G38| 2))
                |#G38|)))
             (SEQ (LETT |k| (+ |s| 1)) (LETT #2# |n|) G190
                  (COND ((> |k| #2#) (GO G191)))
                  (SEQ (LETT |t| (- |k| 1))
                       (EXIT
                        (PROGN
                         (LETT |#G43|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (+ |k| |t|) (QREFELT $ 61))
                                  (QREFELT $ 11) (QREFELT $ 32))
                                 |p| (QREFELT $ 31))
                                (SPADCALL (EXPT |t| 2) |q| (QREFELT $ 56))
                                (QREFELT $ 32)))
                         (LETT |#G44| |p|)
                         (LETT |p| |#G43|)
                         (LETT |q| |#G44|))))
                  (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
             (QSETVELT (QREFELT $ 22) 0 |n|) (QSETVELT (QREFELT $ 22) 1 |p|)
             (QSETVELT (QREFELT $ 22) 2 |q|) (EXIT |p|))))))) 

(SDEFUN |PNTHEORY;chebyshevT;ISup;9|
        ((|n| (|Integer|)) ($ (|SparseUnivariatePolynomial| (|Integer|))))
        (SPROG
         ((|q| (|SparseUnivariatePolynomial| (|Integer|)))
          (|p| #1=(|SparseUnivariatePolynomial| (|Integer|))) (|#G52| #1#)
          (|#G51| (|SparseUnivariatePolynomial| (|Integer|))) (#2=#:G781 NIL)
          (|k| NIL) (|s| (|Integer|))
          (|#G46|
           (|Record| (|:| |Tn| (|Integer|))
                     (|:| T1 (|SparseUnivariatePolynomial| (|Integer|)))
                     (|:| T2 (|SparseUnivariatePolynomial| (|Integer|))))))
         (SEQ
          (COND
           ((< |n| 0) (|error| "chebyshevT not defined for negative integers"))
           (#3='T
            (SEQ
             (COND
              ((< |n| (QVELT (QREFELT $ 24) 0))
               (SEQ (LETT |s| 0) (LETT |p| (|spadConstant| $ 7))
                    (EXIT (LETT |q| (QREFELT $ 11)))))
              (#3#
               (PROGN
                (LETT |#G46| (QREFELT $ 24))
                (LETT |s| (QVELT |#G46| 0))
                (LETT |p| (QVELT |#G46| 1))
                (LETT |q| (QVELT |#G46| 2))
                |#G46|)))
             (SEQ (LETT |k| (+ |s| 1)) (LETT #2# |n|) G190
                  (COND ((> |k| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT |#G51|
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL 2 (QREFELT $ 11) (QREFELT $ 55)) |p|
                             (QREFELT $ 31))
                            |q| (QREFELT $ 32)))
                     (LETT |#G52| |p|)
                     (LETT |p| |#G51|)
                     (LETT |q| |#G52|))))
                  (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
             (QSETVELT (QREFELT $ 24) 0 |n|) (QSETVELT (QREFELT $ 24) 1 |p|)
             (QSETVELT (QREFELT $ 24) 2 |q|) (EXIT |p|))))))) 

(SDEFUN |PNTHEORY;chebyshevU;ISup;10|
        ((|n| (|Integer|)) ($ (|SparseUnivariatePolynomial| (|Integer|))))
        (SPROG
         ((|q| (|SparseUnivariatePolynomial| (|Integer|)))
          (|p| #1=(|SparseUnivariatePolynomial| (|Integer|))) (|#G60| #1#)
          (|#G59| (|SparseUnivariatePolynomial| (|Integer|))) (#2=#:G789 NIL)
          (|k| NIL) (|s| (|Integer|))
          (|#G54|
           (|Record| (|:| |Un| (|Integer|))
                     (|:| U1 (|SparseUnivariatePolynomial| (|Integer|)))
                     (|:| U2 (|SparseUnivariatePolynomial| (|Integer|))))))
         (SEQ
          (COND
           ((< |n| 0) (|error| "chebyshevU not defined for negative integers"))
           (#3='T
            (SEQ
             (COND
              ((< |n| (QVELT (QREFELT $ 25) 0))
               (SEQ (LETT |s| 0) (LETT |p| (|spadConstant| $ 7))
                    (EXIT (LETT |q| (|spadConstant| $ 17)))))
              (#3#
               (PROGN
                (LETT |#G54| (QREFELT $ 25))
                (LETT |s| (QVELT |#G54| 0))
                (LETT |p| (QVELT |#G54| 1))
                (LETT |q| (QVELT |#G54| 2))
                |#G54|)))
             (SEQ (LETT |k| (+ |s| 1)) (LETT #2# |n|) G190
                  (COND ((> |k| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT |#G59|
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL 2 (QREFELT $ 11) (QREFELT $ 55)) |p|
                             (QREFELT $ 31))
                            |q| (QREFELT $ 32)))
                     (LETT |#G60| |p|)
                     (LETT |p| |#G59|)
                     (LETT |q| |#G60|))))
                  (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
             (QSETVELT (QREFELT $ 25) 0 |n|) (QSETVELT (QREFELT $ 25) 1 |p|)
             (QSETVELT (QREFELT $ 25) 2 |q|) (EXIT |p|))))))) 

(DECLAIM (NOTINLINE |PolynomialNumberTheoryFunctions;|)) 

(DEFUN |PolynomialNumberTheoryFunctions| ()
  (SPROG NIL
         (PROG (#1=#:G791)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache|
                          '|PolynomialNumberTheoryFunctions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|PolynomialNumberTheoryFunctions|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|PolynomialNumberTheoryFunctions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|PolynomialNumberTheoryFunctions|)))))))))) 

(DEFUN |PolynomialNumberTheoryFunctions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PolynomialNumberTheoryFunctions|))
          (LETT $ (GETREFV 65))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PolynomialNumberTheoryFunctions|
                      NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 11 (SPADCALL 1 1 (QREFELT $ 10)))
          (QSETREFV $ 16 (SPADCALL (|spadConstant| $ 13) 1 (QREFELT $ 15)))
          (QSETREFV $ 19 (CONS 0 (|spadConstant| $ 18)))
          (QSETREFV $ 20 (CONS 0 (|spadConstant| $ 18)))
          (QSETREFV $ 21 (VECTOR 0 (|spadConstant| $ 7) (QREFELT $ 11)))
          (QSETREFV $ 22 (VECTOR 0 (|spadConstant| $ 7) (QREFELT $ 11)))
          (QSETREFV $ 23 (VECTOR 0 (|spadConstant| $ 18) (QREFELT $ 16)))
          (QSETREFV $ 24 (VECTOR 0 (|spadConstant| $ 7) (QREFELT $ 11)))
          (QSETREFV $ 25 (VECTOR 0 (|spadConstant| $ 7) (|spadConstant| $ 17)))
          $))) 

(MAKEPROP '|PolynomialNumberTheoryFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|SparseUnivariatePolynomial| 8)
              (0 . |One|) (|Integer|) (|NonNegativeInteger|) (4 . |monomial|)
              '|x| (|Fraction| 8) (10 . |One|)
              (|SparseUnivariatePolynomial| 12) (14 . |monomial|) '|y|
              (20 . |Zero|) (24 . |One|) 'E 'B 'H 'L 'P 'CT 'U
              (28 . |leadingCoefficient|) (|Boolean|) (33 . ~=) (39 . =)
              (45 . |degree|) (50 . *) (56 . -) (62 . +)
              (|CyclotomicUtilities|) (68 . |cyclotomic|)
              |PNTHEORY;cyclotomic;ISup;2| (73 . |coerce|) (78 . |integrate|)
              (83 . *) (|IntegerNumberTheoryFunctions|) (89 . |euler|) (94 . /)
              (100 . |elt|) (106 . -) (112 . |coerce|) (117 . +)
              |PNTHEORY;euler;ISup;3| (123 . |bernoulli|)
              |PNTHEORY;bernoulli;ISup;4| (128 . |minimumDegree|)
              (133 . |coefficient|) (139 . |elt|)
              |PNTHEORY;fixedDivisor;SupI;5| (|PositiveInteger|) (145 . *)
              (151 . *) |PNTHEORY;hermite;ISup;6| (157 . *) (163 . -)
              |PNTHEORY;legendre;ISup;7| (169 . |coerce|)
              |PNTHEORY;laguerre;ISup;8| |PNTHEORY;chebyshevT;ISup;9|
              |PNTHEORY;chebyshevU;ISup;10|)
           '#(|legendre| 174 |laguerre| 179 |hermite| 184 |fixedDivisor| 189
              |euler| 194 |cyclotomic| 199 |chebyshevU| 204 |chebyshevT| 209
              |bernoulli| 214)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|bernoulli|
                                 ((|SparseUnivariatePolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|chebyshevT|
                                 ((|SparseUnivariatePolynomial| (|Integer|))
                                  (|Integer|)))
                                T)
                              '((|chebyshevU|
                                 ((|SparseUnivariatePolynomial| (|Integer|))
                                  (|Integer|)))
                                T)
                              '((|cyclotomic|
                                 ((|SparseUnivariatePolynomial| (|Integer|))
                                  (|Integer|)))
                                T)
                              '((|euler|
                                 ((|SparseUnivariatePolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|fixedDivisor|
                                 ((|Integer|)
                                  (|SparseUnivariatePolynomial| (|Integer|))))
                                T)
                              '((|hermite|
                                 ((|SparseUnivariatePolynomial| (|Integer|))
                                  (|Integer|)))
                                T)
                              '((|laguerre|
                                 ((|SparseUnivariatePolynomial| (|Integer|))
                                  (|Integer|)))
                                T)
                              '((|legendre|
                                 ((|SparseUnivariatePolynomial|
                                   (|Fraction| (|Integer|)))
                                  (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 64
                                            '(0 6 0 7 2 6 0 8 9 10 0 12 0 13 2
                                              14 0 12 9 15 0 6 0 17 0 14 0 18 1
                                              6 8 0 26 2 8 27 0 0 28 2 6 27 0 0
                                              29 1 6 9 0 30 2 6 0 0 0 31 2 6 0
                                              0 0 32 2 6 0 0 0 33 1 34 6 8 35 1
                                              12 0 8 37 1 14 0 0 38 2 14 0 12 0
                                              39 1 40 8 8 41 2 12 0 8 8 42 2 14
                                              12 0 12 43 2 12 0 0 0 44 1 14 0
                                              12 45 2 14 0 0 0 46 1 40 12 8 48
                                              1 6 9 0 50 2 6 8 0 9 51 2 6 8 0 8
                                              52 2 6 0 54 0 55 2 6 0 8 0 56 2
                                              14 0 0 0 58 2 14 0 0 0 59 1 6 0 8
                                              61 1 0 14 8 60 1 0 6 8 62 1 0 6 8
                                              57 1 0 8 6 53 1 0 14 8 47 1 0 6 8
                                              36 1 0 6 8 64 1 0 6 8 63 1 0 14 8
                                              49)))))
           '|lookupComplete|)) 

(MAKEPROP '|PolynomialNumberTheoryFunctions| 'NILADIC T) 

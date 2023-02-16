
(SDEFUN |RCFIELD-;sqrt;2S;1| ((|a| (S)) ($ (S))) (SPADCALL |a| 2 (QREFELT $ 8))) 

(SDEFUN |RCFIELD-;sqrt;FS;2| ((|a| (|Fraction| (|Integer|))) ($ (S)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 11)) 2 (QREFELT $ 8))) 

(SDEFUN |RCFIELD-;sqrt;IS;3| ((|a| (|Integer|)) ($ (S)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 14)) 2 (QREFELT $ 8))) 

(PUT '|RCFIELD-;characteristic;Nni;4| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |RCFIELD-;characteristic;Nni;4| (($ (|NonNegativeInteger|))) 0) 

(SDEFUN |RCFIELD-;rootOf;SupPiOfU;5|
        ((|pol| (|SparseUnivariatePolynomial| S)) (|n| (|PositiveInteger|))
         (|o| (|OutputForm|)) ($ (|Union| S "failed")))
        (SPROG ((|r| (|Union| S "failed")))
               (SEQ (LETT |r| (SPADCALL |pol| |n| (QREFELT $ 20)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0
                                  (SPADCALL (QCDR |r|) |o|
                                            (QREFELT $ 22))))))))) 

(SDEFUN |RCFIELD-;rootOf;SupPiU;6|
        ((|pol| (|SparseUnivariatePolynomial| S)) (|n| (|PositiveInteger|))
         ($ (|Union| S "failed")))
        (SPROG ((|liste| (|List| S)))
               (SEQ (LETT |liste| (SPADCALL |pol| (QREFELT $ 25)))
                    (EXIT
                     (COND ((> (LENGTH |liste|) |n|) (CONS 1 "failed"))
                           ('T
                            (CONS 0 (SPADCALL |liste| |n| (QREFELT $ 27))))))))) 

(SDEFUN |RCFIELD-;sqrt;SPiS;7| ((|x| (S)) (|n| (|PositiveInteger|)) ($ (S)))
        (SPROG ((|r| (|Union| S "failed")))
               (SEQ
                (COND ((EQL |n| 1) |x|)
                      ((SPADCALL |x| (QREFELT $ 31)) (|spadConstant| $ 32))
                      ((SPADCALL |x| (QREFELT $ 33)) (|spadConstant| $ 29))
                      (#1='T
                       (SEQ
                        (COND
                         ((ODDP |n|)
                          (LETT |r|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 29) |n|
                                            (QREFELT $ 35))
                                  (SPADCALL |x| (QREFELT $ 36)) (QREFELT $ 37))
                                 1 (QREFELT $ 20))))
                         (#1#
                          (LETT |r|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 29) |n|
                                            (QREFELT $ 35))
                                  (SPADCALL |x| (QREFELT $ 36)) (QREFELT $ 37))
                                 2 (QREFELT $ 20)))))
                        (EXIT
                         (COND ((QEQCAR |r| 1) (|error| "no roots"))
                               ((EQL |n| 2)
                                (SPADCALL (QCDR |r|)
                                          (SPADCALL
                                           (SPADCALL |x| (QREFELT $ 38))
                                           (QREFELT $ 39))
                                          (QREFELT $ 40)))
                               (#1#
                                (SPADCALL (QCDR |r|)
                                          (SPADCALL
                                           (SPADCALL |x| (QREFELT $ 38))
                                           (SPADCALL |n| (QREFELT $ 41))
                                           (QREFELT $ 42))
                                          (QREFELT $ 40))))))))))) 

(SDEFUN |RCFIELD-;^;SFS;8| ((|x| (S)) (|rn| (|Fraction| (|Integer|))) ($ (S)))
        (SPROG ((#1=#:G763 NIL))
               (SPADCALL
                (SPADCALL |x| (SPADCALL |rn| (QREFELT $ 44)) (QREFELT $ 45))
                (PROG1 (LETT #1# (SPADCALL |rn| (QREFELT $ 46)))
                  (|check_subtype2| (> #1# 0) '(|PositiveInteger|) '(|Integer|)
                                    #1#))
                (QREFELT $ 8)))) 

(SDEFUN |RCFIELD-;nthRoot;SIS;9| ((|x| (S)) (|n| (|Integer|)) ($ (S)))
        (SPROG ((#1=#:G767 NIL) (#2=#:G765 NIL))
               (COND ((ZEROP |n|) |x|)
                     ((MINUSP |n|)
                      (SPADCALL
                       (SPADCALL |x|
                                 (PROG1 (LETT #2# (- |n|))
                                   (|check_subtype2| (> #2# 0)
                                                     '(|PositiveInteger|)
                                                     '(|Integer|) #2#))
                                 (QREFELT $ 8))
                       (QREFELT $ 48)))
                     ('T
                      (SPADCALL |x|
                                (PROG1 (LETT #1# |n|)
                                  (|check_subtype2| (> #1# 0)
                                                    '(|PositiveInteger|)
                                                    '(|Integer|) #1#))
                                (QREFELT $ 8)))))) 

(SDEFUN |RCFIELD-;allRootsOf;SupL;10|
        ((|p| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         ($ (|List| S)))
        (SPADCALL (SPADCALL (ELT $ 11) |p| (QREFELT $ 53)) (QREFELT $ 25))) 

(SDEFUN |RCFIELD-;allRootsOf;SupL;11|
        ((|p| (|SparseUnivariatePolynomial| (|Integer|))) ($ (|List| S)))
        (SPADCALL (SPADCALL (ELT $ 14) |p| (QREFELT $ 58)) (QREFELT $ 25))) 

(SDEFUN |RCFIELD-;allRootsOf;PL;12| ((|p| (|Polynomial| S)) ($ (|List| S)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 61)) (QREFELT $ 25))) 

(SDEFUN |RCFIELD-;allRootsOf;PL;13|
        ((|p| (|Polynomial| (|Fraction| (|Integer|)))) ($ (|List| S)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 65)) (QREFELT $ 66))) 

(SDEFUN |RCFIELD-;allRootsOf;PL;14|
        ((|p| (|Polynomial| (|Integer|))) ($ (|List| S)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 69)) (QREFELT $ 70))) 

(DECLAIM (NOTINLINE |RealClosedField&;|)) 

(DEFUN |RealClosedField&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RealClosedField&| DV$1))
          (LETT $ (GETREFV 72))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RealClosedField&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|PositiveInteger|)
              (0 . |sqrt|) |RCFIELD-;sqrt;2S;1| (|Fraction| 13) (6 . |coerce|)
              |RCFIELD-;sqrt;FS;2| (|Integer|) (11 . |coerce|)
              |RCFIELD-;sqrt;IS;3| (|NonNegativeInteger|)
              |RCFIELD-;characteristic;Nni;4| (|Union| $ '#1="failed")
              (|SparseUnivariatePolynomial| $) (16 . |rootOf|) (|OutputForm|)
              (22 . |rename!|) |RCFIELD-;rootOf;SupPiOfU;5| (|List| $)
              (28 . |allRootsOf|) (|List| 6) (33 . |elt|)
              |RCFIELD-;rootOf;SupPiU;6| (39 . |One|) (|Boolean|)
              (43 . |zero?|) (48 . |Zero|) (52 . |one?|)
              (|SparseUnivariatePolynomial| 6) (57 . |monomial|)
              (63 . |coerce|) (68 . -) (74 . |coerce|) (79 . |root|)
              (84 . |rename|) (90 . |coerce|) (95 . |root|)
              |RCFIELD-;sqrt;SPiS;7| (101 . |numer|) (106 . ^) (112 . |denom|)
              |RCFIELD-;^;SFS;8| (117 . |inv|) |RCFIELD-;nthRoot;SIS;9|
              (|Mapping| 6 10) (|SparseUnivariatePolynomial| 10)
              (|SparseUnivariatePolynomialFunctions2| 10 6) (122 . |map|)
              |RCFIELD-;allRootsOf;SupL;10| (|Mapping| 6 13)
              (|SparseUnivariatePolynomial| 13)
              (|SparseUnivariatePolynomialFunctions2| 13 6) (128 . |map|)
              |RCFIELD-;allRootsOf;SupL;11| (|Polynomial| 6)
              (134 . |univariate|) (|Polynomial| $) |RCFIELD-;allRootsOf;PL;12|
              (|Polynomial| 10) (139 . |univariate|) (144 . |allRootsOf|)
              |RCFIELD-;allRootsOf;PL;13| (|Polynomial| 13)
              (149 . |univariate|) (154 . |allRootsOf|)
              |RCFIELD-;allRootsOf;PL;14|)
           '#(|sqrt| 159 |rootOf| 180 |nthRoot| 193 |characteristic| 199
              |allRootsOf| 203 ^ 228)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|sqrt| (|#1| (|Integer|))) T)
                                   '((|sqrt| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|sqrt| (|#1| |#1| (|PositiveInteger|)))
                                     T)
                                   '((|allRootsOf|
                                      ((|List| |#1|)
                                       (|Polynomial| (|Integer|))))
                                     T)
                                   '((|allRootsOf|
                                      ((|List| |#1|)
                                       (|Polynomial|
                                        (|Fraction| (|Integer|)))))
                                     T)
                                   '((|allRootsOf|
                                      ((|List| |#1|) (|Polynomial| |#1|)))
                                     T)
                                   '((|allRootsOf|
                                      ((|List| |#1|)
                                       (|SparseUnivariatePolynomial|
                                        (|Integer|))))
                                     T)
                                   '((|allRootsOf|
                                      ((|List| |#1|)
                                       (|SparseUnivariatePolynomial|
                                        (|Fraction| (|Integer|)))))
                                     T)
                                   '((|allRootsOf|
                                      ((|List| |#1|)
                                       (|SparseUnivariatePolynomial| |#1|)))
                                     T)
                                   '((|rootOf|
                                      ((|Union| |#1| #1#)
                                       (|SparseUnivariatePolynomial| |#1|)
                                       (|PositiveInteger|)))
                                     T)
                                   '((|rootOf|
                                      ((|Union| |#1| "failed")
                                       (|SparseUnivariatePolynomial| |#1|)
                                       (|PositiveInteger|) (|OutputForm|)))
                                     T)
                                   '((^ (|#1| |#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|nthRoot| (|#1| |#1| (|Integer|))) T)
                                   '((|sqrt| (|#1| |#1|)) T)
                                   '((^ (|#1| |#1| (|Integer|))) T)
                                   '((|characteristic|
                                      ((|NonNegativeInteger|)))
                                     T)
                                   '((^ (|#1| |#1| (|NonNegativeInteger|))) T)
                                   '((^ (|#1| |#1| (|PositiveInteger|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 71
                                            '(2 6 0 0 7 8 1 6 0 10 11 1 6 0 13
                                              14 2 6 18 19 7 20 2 6 0 0 21 22 1
                                              6 24 19 25 2 26 6 0 13 27 0 6 0
                                              29 1 6 30 0 31 0 6 0 32 1 6 30 0
                                              33 2 34 0 6 16 35 1 34 0 6 36 2
                                              34 0 0 0 37 1 6 21 0 38 1 21 0 0
                                              39 2 6 0 0 21 40 1 7 21 0 41 2 21
                                              0 0 0 42 1 10 13 0 44 2 6 0 0 13
                                              45 1 10 13 0 46 1 6 0 0 48 2 52
                                              34 50 51 53 2 57 34 55 56 58 1 60
                                              34 0 61 1 64 51 0 65 1 6 24 51 66
                                              1 68 56 0 69 1 6 24 56 70 1 0 0
                                              10 12 1 0 0 13 15 2 0 0 0 7 43 1
                                              0 0 0 9 3 0 18 19 7 21 23 2 0 18
                                              19 7 28 2 0 0 0 13 49 0 0 16 17 1
                                              0 24 68 71 1 0 24 62 63 1 0 24 64
                                              67 1 0 24 56 59 1 0 24 51 54 2 0
                                              0 0 10 47)))))
           '|lookupComplete|)) 

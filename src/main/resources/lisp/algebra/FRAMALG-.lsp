
(SDEFUN |FRAMALG-;traceMatrix;M;1| (($ (|Matrix| R)))
        (SPADCALL (SPADCALL (QREFELT $ 10)) (QREFELT $ 12))) 

(SDEFUN |FRAMALG-;discriminant;R;2| (($ (R)))
        (SPADCALL (SPADCALL (QREFELT $ 10)) (QREFELT $ 14))) 

(SDEFUN |FRAMALG-;regularRepresentation;SM;3| ((|x| (S)) ($ (|Matrix| R)))
        (SPADCALL |x| (SPADCALL (QREFELT $ 10)) (QREFELT $ 16))) 

(SDEFUN |FRAMALG-;coordinates;SV;4| ((|x| (S)) ($ (|Vector| R)))
        (SPADCALL |x| (SPADCALL (QREFELT $ 10)) (QREFELT $ 19))) 

(SDEFUN |FRAMALG-;represents;VS;5| ((|x| (|Vector| R)) ($ (S)))
        (SPADCALL |x| (SPADCALL (QREFELT $ 10)) (QREFELT $ 21))) 

(SDEFUN |FRAMALG-;regularRepresentation;SM;6| ((|x| (S)) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G716 NIL) (|i| NIL) (|j| NIL) (|b| (|Vector| S))
          (|m| (|Matrix| R)) (|n| (|NonNegativeInteger|)))
         (SEQ
          (LETT |m|
                (MAKE_MATRIX1 (LETT |n| (SPADCALL (QREFELT $ 24))) |n|
                              (|spadConstant| $ 25)))
          (LETT |b| (SPADCALL (QREFELT $ 10)))
          (SEQ (LETT |j| (PROGN |m| 1))
               (LETT |i| (SPADCALL |b| (QREFELT $ 28))) (LETT #1# (QVSIZE |b|))
               G190 (COND ((> |i| #1#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |m| |j|
                           (SPADCALL
                            (SPADCALL |x| (QAREF1O |b| |i| 1) (QREFELT $ 29))
                            (QREFELT $ 30))
                           (QREFELT $ 31))))
               (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190) G191
               (EXIT NIL))
          (EXIT (SPADCALL |m| (QREFELT $ 32)))))) 

(SDEFUN |FRAMALG-;characteristicPolynomial;SUP;7| ((|x| (S)) ($ (UP)))
        (SPROG
         ((|mat1| (|Matrix| UP)) (|mat0| (|Matrix| UP)) (|mat00| (|Matrix| R)))
         (SEQ (LETT |mat00| (SPADCALL |x| (QREFELT $ 33)))
              (LETT |mat0| (SPADCALL (ELT $ 34) |mat00| (QREFELT $ 38)))
              (LETT |mat1|
                    (SPADCALL (SPADCALL (QREFELT $ 24))
                              (SPADCALL (|spadConstant| $ 40) 1 (QREFELT $ 42))
                              (QREFELT $ 43)))
              (EXIT
               (SPADCALL (SPADCALL |mat1| |mat0| (QREFELT $ 44))
                         (QREFELT $ 45)))))) 

(SDEFUN |FRAMALG-;minimalPolynomial;SUP;8| ((|x| (S)) ($ (UP)))
        (SPROG
         ((#1=#:G728 NIL) (#2=#:G727 (UP)) (#3=#:G729 (UP)) (#4=#:G733 NIL)
          (|i| NIL) (|v| (|Vector| R)) (|y| (S)) (#5=#:G732 NIL)
          (|m| (|Matrix| R)) (|n| (|PositiveInteger|)))
         (SEQ (LETT |y| (|spadConstant| $ 39))
              (LETT |n| (SPADCALL (QREFELT $ 24)))
              (LETT |m| (SPADCALL |n| (+ |n| 1) (QREFELT $ 47)))
              (SEQ (LETT |i| 1) (LETT #5# (+ |n| 1)) G190
                   (COND ((|greater_SI| |i| #5#) (GO G191)))
                   (SEQ
                    (SPADCALL |m| |i| (SPADCALL |y| (QREFELT $ 30))
                              (QREFELT $ 48))
                    (EXIT (LETT |y| (SPADCALL |y| |x| (QREFELT $ 29)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |v| (|SPADfirst| (SPADCALL |m| (QREFELT $ 50))))
              (EXIT
               (PROGN
                (LETT #1# NIL)
                (SEQ (LETT |i| 0) (LETT #4# (- (QVSIZE |v|) 1)) G190
                     (COND ((|greater_SI| |i| #4#) (GO G191)))
                     (SEQ
                      (EXIT
                       (PROGN
                        (LETT #3#
                              (SPADCALL (SPADCALL |v| (+ |i| 1) (QREFELT $ 51))
                                        |i| (QREFELT $ 42)))
                        (COND
                         (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 52))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (COND (#1# #2#) ('T (|spadConstant| $ 53)))))))) 

(DECLAIM (NOTINLINE |FramedAlgebra&;|)) 

(DEFUN |FramedAlgebra&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|FramedAlgebra&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 55))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#3| '(|CommutativeRing|))
            (QSETREFV $ 46
                      (CONS
                       (|dispatchFunction|
                        |FRAMALG-;characteristicPolynomial;SUP;7|)
                       $))))
          (COND
           ((|HasCategory| |#2| '(|Field|))
            (PROGN
             (QSETREFV $ 54
                       (CONS
                        (|dispatchFunction| |FRAMALG-;minimalPolynomial;SUP;8|)
                        $)))))
          $))) 

(MAKEPROP '|FramedAlgebra&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Vector| $) (0 . |basis|) (|Matrix| 7)
              (4 . |traceMatrix|) |FRAMALG-;traceMatrix;M;1|
              (9 . |discriminant|) |FRAMALG-;discriminant;R;2|
              (14 . |regularRepresentation|)
              |FRAMALG-;regularRepresentation;SM;6| (|Vector| 7)
              (20 . |coordinates|) |FRAMALG-;coordinates;SV;4|
              (26 . |represents|) |FRAMALG-;represents;VS;5|
              (|PositiveInteger|) (32 . |rank|) (36 . |Zero|) (|Integer|)
              (|Vector| 6) (40 . |minIndex|) (45 . *) (51 . |coordinates|)
              (56 . |setRow!|) (63 . |transpose|)
              (68 . |regularRepresentation|) (73 . |coerce|) (|Matrix| 8)
              (|Mapping| 8 7)
              (|MatrixCategoryFunctions2| 7 18 18 11 8 (|Vector| 8)
                                          (|Vector| 8) 35)
              (78 . |map|) (84 . |One|) (88 . |One|) (|NonNegativeInteger|)
              (92 . |monomial|) (98 . |scalarMatrix|) (104 . -)
              (110 . |determinant|) (115 . |characteristicPolynomial|)
              (120 . |zero|) (126 . |setColumn!|) (|List| 18)
              (133 . |nullSpace|) (138 . |elt|) (144 . +) (150 . |Zero|)
              (154 . |minimalPolynomial|))
           '#(|traceMatrix| 159 |represents| 163 |regularRepresentation| 168
              |minimalPolynomial| 173 |discriminant| 178 |coordinates| 182
              |characteristicPolynomial| 187)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|regularRepresentation|
                                 ((|Matrix| |#2|) |#1|))
                                T)
                              '((|discriminant| (|#2|)) T)
                              '((|traceMatrix| ((|Matrix| |#2|))) T)
                              '((|coordinates| ((|Vector| |#2|) |#1|)) T)
                              '((|coordinates|
                                 ((|Matrix| |#2|) (|Vector| |#1|)))
                                T)
                              '((|represents| (|#1| (|Vector| |#2|))) T)
                              '((|minimalPolynomial| (|#3| |#1|)) T)
                              '((|characteristicPolynomial| (|#3| |#1|)) T)
                              '((|traceMatrix|
                                 ((|Matrix| |#2|) (|Vector| |#1|)))
                                T)
                              '((|discriminant| (|#2| (|Vector| |#1|))) T)
                              '((|represents|
                                 (|#1| (|Vector| |#2|) (|Vector| |#1|)))
                                T)
                              '((|coordinates|
                                 ((|Matrix| |#2|) (|Vector| |#1|)
                                  (|Vector| |#1|)))
                                T)
                              '((|coordinates|
                                 ((|Vector| |#2|) |#1| (|Vector| |#1|)))
                                T)
                              '((|regularRepresentation|
                                 ((|Matrix| |#2|) |#1| (|Vector| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 54
                                            '(0 6 9 10 1 6 11 9 12 1 6 7 9 14 2
                                              6 11 0 9 16 2 6 18 0 9 19 2 6 0
                                              18 9 21 0 6 23 24 0 7 0 25 1 27
                                              26 0 28 2 6 0 0 0 29 1 6 18 0 30
                                              3 11 0 0 26 18 31 1 11 0 0 32 1 6
                                              11 0 33 1 8 0 7 34 2 37 35 36 11
                                              38 0 6 0 39 0 7 0 40 2 8 0 7 41
                                              42 2 35 0 41 8 43 2 35 0 0 0 44 1
                                              35 8 0 45 1 0 8 0 46 2 11 0 41 41
                                              47 3 11 0 0 26 18 48 1 11 49 0 50
                                              2 18 7 0 26 51 2 8 0 0 0 52 0 8 0
                                              53 1 0 8 0 54 0 0 11 13 1 0 0 18
                                              22 1 0 11 0 17 1 0 8 0 54 0 0 7
                                              15 1 0 18 0 20 1 0 8 0 46)))))
           '|lookupComplete|)) 

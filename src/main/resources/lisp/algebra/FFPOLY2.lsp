
(SDEFUN |FFPOLY2;rootOfIrreduciblePoly;SupF;1|
        ((|pf| (|SparseUnivariatePolynomial| GF)) ($ (F)))
        (SPROG
         ((|stillToFactor| #1=(|SparseUnivariatePolynomial| F)) (|root| (F))
          (|degSTF| #2=(|NonNegativeInteger|)) (|degh| #2#)
          (|h| (|SparseUnivariatePolynomial| F)) (#3=#:G729 NIL) (|j| NIL)
          (|trModp| (|SparseUnivariatePolynomial| F)) (|beta| (F))
          (#4=#:G728 NIL) (|i| NIL) (|basispointer| (|Integer|))
          (|basis| (|Vector| F))
          (|qexp| (|PrimitiveArray| (|SparseUnivariatePolynomial| GF)))
          (|p| #1#) (|deg| (|PositiveInteger|)) (#5=#:G700 NIL)
          (|sizeGF| (|NonNegativeInteger|)))
         (SEQ (LETT |sizeGF| (SPADCALL (QREFELT $ 9)))
              (LETT |deg|
                    (PROG1 (LETT #5# (SPADCALL |pf| (QREFELT $ 11)))
                      (|check_subtype2| (> #5# 0) '(|PositiveInteger|)
                                        '(|NonNegativeInteger|) #5#)))
              (EXIT
               (COND ((EQL |deg| 0) (|error| "no roots"))
                     ((EQL |deg| 1)
                      (SPADCALL
                       (SPADCALL (SPADCALL |pf| 0 (QREFELT $ 16))
                                 (QREFELT $ 17))
                       (QREFELT $ 18)))
                     ('T
                      (SEQ (LETT |p| (SPADCALL (ELT $ 17) |pf| (QREFELT $ 22)))
                           (LETT |qexp| (SPADCALL |pf| (QREFELT $ 25)))
                           (LETT |stillToFactor| |p|)
                           (LETT |basis| (SPADCALL |deg| (QREFELT $ 28)))
                           (LETT |basispointer| 1)
                           (LETT |root| (|spadConstant| $ 12))
                           (SEQ G190
                                (COND
                                 ((NULL (SPADCALL |root| (QREFELT $ 30)))
                                  (GO G191)))
                                (SEQ
                                 (LETT |beta|
                                       (SPADCALL |basis| |basispointer|
                                                 (QREFELT $ 33)))
                                 (COND
                                  ((SPADCALL |beta| (|spadConstant| $ 14)
                                             (QREFELT $ 34))
                                   (SEQ
                                    (LETT |basispointer| (+ |basispointer| 1))
                                    (EXIT
                                     (LETT |beta|
                                           (SPADCALL |basis| |basispointer|
                                                     (QREFELT $ 33)))))))
                                 (LETT |basispointer| (+ |basispointer| 1))
                                 (LETT |trModp|
                                       (SPADCALL
                                        (SPADCALL (ELT $ 17) (QAREF1 |qexp| 0)
                                                  (QREFELT $ 22))
                                        |beta| (QREFELT $ 35)))
                                 (SEQ (LETT |i| 1) (LETT #4# (- |deg| 1)) G190
                                      (COND ((|greater_SI| |i| #4#) (GO G191)))
                                      (SEQ
                                       (LETT |beta|
                                             (SPADCALL |beta| (QREFELT $ 36)))
                                       (EXIT
                                        (LETT |trModp|
                                              (SPADCALL |trModp|
                                                        (SPADCALL |beta|
                                                                  (SPADCALL
                                                                   (ELT $ 17)
                                                                   (QAREF1
                                                                    |qexp| |i|)
                                                                   (QREFELT $
                                                                            22))
                                                                  (QREFELT $
                                                                           37))
                                                        (QREFELT $ 38)))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT
                                  (COND
                                   ((> (SPADCALL |trModp| (QREFELT $ 39)) 0)
                                    (SEQ (LETT |j| 1) (LETT #3# |sizeGF|) G190
                                         (COND
                                          ((|greater_SI| |j| #3#) (GO G191)))
                                         (SEQ
                                          (LETT |h|
                                                (SPADCALL |stillToFactor|
                                                          (SPADCALL |trModp|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       |j|
                                                                       (QREFELT
                                                                        $ 40))
                                                                      (QREFELT
                                                                       $ 17))
                                                                     (QREFELT $
                                                                              41))
                                                                    (QREFELT $
                                                                             38))
                                                          (QREFELT $ 42)))
                                          (COND
                                           ((SPADCALL
                                             (SPADCALL |h| (QREFELT $ 43))
                                             (|spadConstant| $ 14)
                                             (QREFELT $ 44))
                                            (LETT |h|
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL |h|
                                                              (QREFELT $ 43))
                                                    (QREFELT $ 45))
                                                   |h| (QREFELT $ 37)))))
                                          (LETT |degh|
                                                (SPADCALL |h| (QREFELT $ 39)))
                                          (LETT |degSTF|
                                                (SPADCALL |stillToFactor|
                                                          (QREFELT $ 39)))
                                          (EXIT
                                           (COND
                                            ((EQL |degh| 1)
                                             (LETT |root|
                                                   (SPADCALL
                                                    (SPADCALL |h| 0
                                                              (QREFELT $ 46))
                                                    (QREFELT $ 18))))
                                            ((EQL (- |degSTF| |degh|) 1)
                                             (LETT |root|
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |stillToFactor|
                                                               |h|
                                                               (QREFELT $ 47))
                                                     0 (QREFELT $ 46))
                                                    (QREFELT $ 18))))
                                            ((> |degh| 1)
                                             (COND
                                              ((< |degh| |degSTF|)
                                               (COND
                                                ((> (* 2 |degh|) |degSTF|)
                                                 (LETT |stillToFactor|
                                                       (SPADCALL
                                                        |stillToFactor| |h|
                                                        (QREFELT $ 47))))
                                                ('T
                                                 (LETT |stillToFactor|
                                                       |h|)))))))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT NIL))))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT |root|)))))))) 

(DECLAIM (NOTINLINE |FiniteFieldPolynomialPackage2;|)) 

(DEFUN |FiniteFieldPolynomialPackage2| (&REST #1=#:G730)
  (SPROG NIL
         (PROG (#2=#:G731)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FiniteFieldPolynomialPackage2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FiniteFieldPolynomialPackage2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FiniteFieldPolynomialPackage2|)))))))))) 

(DEFUN |FiniteFieldPolynomialPackage2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FiniteFieldPolynomialPackage2| DV$1 DV$2))
          (LETT $ (GETREFV 49))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FiniteFieldPolynomialPackage2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FiniteFieldPolynomialPackage2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|NonNegativeInteger|) (0 . |size|)
              (|SparseUnivariatePolynomial| 7) (4 . |degree|) (9 . |Zero|)
              (13 . |Zero|) (17 . |One|) (21 . |One|) (25 . |coefficient|)
              (31 . |coerce|) (36 . -) (|SparseUnivariatePolynomial| 6)
              (|Mapping| 6 7) (|SparseUnivariatePolynomialFunctions2| 7 6)
              (41 . |map|) (|PrimitiveArray| 10)
              (|FiniteFieldPolynomialPackage| 7) (47 . |reducedQPowers|)
              (|Vector| $) (|PositiveInteger|) (52 . |basis|) (|Boolean|)
              (57 . |zero?|) (|Integer|) (|Vector| 6) (62 . |elt|) (68 . =)
              (74 . *) (80 . |Frobenius|) (85 . *) (91 . +) (97 . |degree|)
              (102 . |index|) (107 . |coerce|) (112 . |gcd|)
              (118 . |leadingCoefficient|) (123 . ~=) (129 . |inv|)
              (134 . |coefficient|) (140 . |quo|)
              |FFPOLY2;rootOfIrreduciblePoly;SupF;1|)
           '#(|rootOfIrreduciblePoly| 146) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rootOfIrreduciblePoly|
                                 (|#1| (|SparseUnivariatePolynomial| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 48
                                            '(0 7 8 9 1 10 8 0 11 0 6 0 12 0 7
                                              0 13 0 6 0 14 0 7 0 15 2 10 7 0 8
                                              16 1 6 0 7 17 1 6 0 0 18 2 21 19
                                              20 10 22 1 24 23 10 25 1 6 26 27
                                              28 1 6 29 0 30 2 32 6 0 31 33 2 6
                                              29 0 0 34 2 19 0 0 6 35 1 6 0 0
                                              36 2 19 0 6 0 37 2 19 0 0 0 38 1
                                              19 8 0 39 1 7 0 27 40 1 19 0 6 41
                                              2 19 0 0 0 42 1 19 6 0 43 2 6 29
                                              0 0 44 1 6 0 0 45 2 19 6 0 8 46 2
                                              19 0 0 0 47 1 0 6 10 48)))))
           '|lookupComplete|)) 


(SDEFUN |POLYLIFT;map;MMPS;1|
        ((|fv| (|Mapping| S |Vars|)) (|fc| (|Mapping| S R)) (|p| (P)) ($ (S)))
        (SPROG
         ((|ans| (S)) (|pow0| (S)) (|i0| #1=(|NonNegativeInteger|)) (|pow| (S))
          (|i| #1#) (#2=#:G717 NIL) (|mon| NIL) (|lc0| (S))
          (|mon0| (|SparseUnivariatePolynomial| P)) (|t| (S))
          (|ml| (|List| (|SparseUnivariatePolynomial| P)))
          (|up| (|SparseUnivariatePolynomial| P))
          (|x1| (|Union| |Vars| "failed")))
         (SEQ (LETT |x1| (SPADCALL |p| (QREFELT $ 12)))
              (EXIT
               (COND
                ((QEQCAR |x1| 1) (SPADCALL (SPADCALL |p| (QREFELT $ 13)) |fc|))
                (#3='T
                 (SEQ (LETT |up| (SPADCALL |p| (QCDR |x1|) (QREFELT $ 15)))
                      (LETT |ml| (REVERSE (SPADCALL |up| (QREFELT $ 18))))
                      (LETT |t| (SPADCALL (QCDR |x1|) |fv|))
                      (LETT |mon0| (|SPADfirst| |ml|))
                      (LETT |i0| (SPADCALL |mon0| (QREFELT $ 20)))
                      (LETT |lc0|
                            (SPADCALL |fv| |fc|
                                      (SPADCALL |mon0| (QREFELT $ 21))
                                      (QREFELT $ 24)))
                      (COND
                       ((> |i0| 0)
                        (SEQ (LETT |pow0| (SPADCALL |t| |i0| (QREFELT $ 27)))
                             (EXIT
                              (LETT |ans|
                                    (SPADCALL |lc0| |pow0| (QREFELT $ 28))))))
                       (#3# (LETT |ans| |lc0|)))
                      (SEQ (LETT |mon| NIL) (LETT #2# (CDR |ml|)) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |mon| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |i| (SPADCALL |mon| (QREFELT $ 20)))
                                (EXIT
                                 (COND
                                  ((EQL |i| 0)
                                   (LETT |ans|
                                         (SPADCALL |ans|
                                                   (SPADCALL |fv| |fc|
                                                             (SPADCALL |mon|
                                                                       (QREFELT
                                                                        $ 21))
                                                             (QREFELT $ 24))
                                                   (QREFELT $ 29))))
                                  ('T
                                   (SEQ
                                    (LETT |pow|
                                          (COND
                                           ((OR (<= |i0| 0)
                                                (NULL (> |i| |i0|)))
                                            (SPADCALL |t| |i| (QREFELT $ 27)))
                                           ('T
                                            (SPADCALL |pow0|
                                                      (SPADCALL |t|
                                                                (- |i| |i0|)
                                                                (QREFELT $ 31))
                                                      (QREFELT $ 28)))))
                                    (LETT |i0| |i|) (LETT |pow0| |pow|)
                                    (EXIT
                                     (LETT |ans|
                                           (SPADCALL |ans|
                                                     (SPADCALL
                                                      (SPADCALL |fv| |fc|
                                                                (SPADCALL |mon|
                                                                          (QREFELT
                                                                           $
                                                                           21))
                                                                (QREFELT $ 24))
                                                      |pow| (QREFELT $ 28))
                                                     (QREFELT $ 29)))))))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |ans|)))))))) 

(SDEFUN |POLYLIFT;map;MMPS;2|
        ((|fv| (|Mapping| S |Vars|)) (|fc| (|Mapping| S R)) (|p| (P)) ($ (S)))
        (SPROG
         ((|up| (|SparseUnivariatePolynomial| P)) (|ans| (S)) (|t| (S))
          (|x1| (|Union| |Vars| "failed")))
         (SEQ (LETT |x1| (SPADCALL |p| (QREFELT $ 12)))
              (EXIT
               (COND
                ((QEQCAR |x1| 1) (SPADCALL (SPADCALL |p| (QREFELT $ 13)) |fc|))
                ('T
                 (SEQ (LETT |up| (SPADCALL |p| (QCDR |x1|) (QREFELT $ 15)))
                      (LETT |t| (SPADCALL (QCDR |x1|) |fv|))
                      (LETT |ans|
                            (SPADCALL
                             (SPADCALL |fv| |fc| (SPADCALL |up| (QREFELT $ 21))
                                       (QREFELT $ 24))
                             (SPADCALL |t| (SPADCALL |up| (QREFELT $ 20))
                                       (QREFELT $ 27))
                             (QREFELT $ 32)))
                      (LETT |up| (SPADCALL |up| (QREFELT $ 33)))
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |up| (QREFELT $ 35))))
                             (GO G191)))
                           (SEQ
                            (LETT |ans|
                                  (SPADCALL |ans|
                                            (SPADCALL
                                             (SPADCALL |fv| |fc|
                                                       (SPADCALL |up|
                                                                 (QREFELT $
                                                                          21))
                                                       (QREFELT $ 24))
                                             (SPADCALL |t|
                                                       (SPADCALL |up|
                                                                 (QREFELT $
                                                                          20))
                                                       (QREFELT $ 27))
                                             (QREFELT $ 32))
                                            (QREFELT $ 29)))
                            (EXIT (LETT |up| (SPADCALL |up| (QREFELT $ 33)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT |ans|)))))))) 

(DECLAIM (NOTINLINE |PolynomialCategoryLifting;|)) 

(DEFUN |PolynomialCategoryLifting| (&REST #1=#:G736)
  (SPROG NIL
         (PROG (#2=#:G737)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialCategoryLifting|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PolynomialCategoryLifting;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PolynomialCategoryLifting|)))))))))) 

(DEFUN |PolynomialCategoryLifting;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|PolynomialCategoryLifting| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 36))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PolynomialCategoryLifting|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#5| '(|SemiRng|))
      (QSETREFV $ 24 (CONS (|dispatchFunction| |POLYLIFT;map;MMPS;1|) $)))
     ('T (QSETREFV $ 24 (CONS (|dispatchFunction| |POLYLIFT;map;MMPS;2|) $))))
    $))) 

(MAKEPROP '|PolynomialCategoryLifting| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|Union| 7 '"failed") (0 . |mainVariable|)
              (5 . |leadingCoefficient|) (|SparseUnivariatePolynomial| $)
              (10 . |univariate|) (|List| $) (|SparseUnivariatePolynomial| 9)
              (16 . |monomials|) (|NonNegativeInteger|) (21 . |degree|)
              (26 . |leadingCoefficient|) (|Mapping| 10 7) (|Mapping| 10 8)
              (31 . |map|) (38 . |Zero|) (42 . |Zero|) (46 . ^) (52 . *)
              (58 . +) (|PositiveInteger|) (64 . ^) (70 . *) (76 . |reductum|)
              (|Boolean|) (81 . |zero?|))
           '#(|map| 86) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 (|#5| (|Mapping| |#5| |#2|)
                                  (|Mapping| |#5| |#3|) |#4|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 35
                                            '(1 9 11 0 12 1 9 8 0 13 2 9 14 0 7
                                              15 1 17 16 0 18 1 17 19 0 20 1 17
                                              9 0 21 3 0 10 22 23 9 24 0 6 0 25
                                              0 8 0 26 2 10 0 0 19 27 2 10 0 0
                                              0 28 2 10 0 0 0 29 2 10 0 0 30 31
                                              2 10 0 0 0 32 1 17 0 0 33 1 17 34
                                              0 35 3 0 10 22 23 9 24)))))
           '|lookupComplete|)) 

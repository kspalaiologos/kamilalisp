
(SDEFUN |IRREDFFX;qAdicExpansion|
        ((|z| (|Integer|)) ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((|r| (|SparseUnivariatePolynomial| GF))
          (|qr|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|)))))
         (SEQ (LETT |qr| (DIVIDE2 |z| (QREFELT $ 11)))
              (EXIT
               (COND
                ((ZEROP (QCDR |qr|))
                 (SPADCALL (SPADCALL (|spadConstant| $ 12) 1 (QREFELT $ 14))
                           (|IRREDFFX;qAdicExpansion| (QCAR |qr|) $)
                           (QREFELT $ 15)))
                (#1='T
                 (SEQ
                  (LETT |r|
                        (SPADCALL (SPADCALL (QCDR |qr|) (QREFELT $ 17))
                                  (QREFELT $ 18)))
                  (EXIT
                   (COND ((ZEROP (QCAR |qr|)) |r|)
                         (#1#
                          (SPADCALL |r|
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 12) 1
                                               (QREFELT $ 14))
                                     (|IRREDFFX;qAdicExpansion| (QCAR |qr|) $)
                                     (QREFELT $ 15))
                                    (QREFELT $ 19)))))))))))) 

(SDEFUN |IRREDFFX;getIrredPoly|
        ((|start| (|Integer|)) (|n| (|PositiveInteger|))
         ($ (|SparseUnivariatePolynomial| GF)))
        (SPROG
         ((|found| (|Boolean|)) (|pol| (|SparseUnivariatePolynomial| GF))
          (|end| (|Integer|)) (|mon| (|SparseUnivariatePolynomial| GF)))
         (SEQ (LETT |mon| (SPADCALL (|spadConstant| $ 12) |n| (QREFELT $ 14)))
              (LETT |pol| (|spadConstant| $ 20)) (LETT |found| NIL)
              (LETT |end| (- (EXPT (QREFELT $ 11) |n|) 1))
              (SEQ G190
                   (COND
                    ((NULL (NULL (OR (< |end| |start|) |found|))) (GO G191)))
                   (SEQ
                    (COND
                     ((EQL (GCD |start| (QREFELT $ 9)) 1)
                      (COND
                       ((SPADCALL
                         (LETT |pol|
                               (SPADCALL |mon|
                                         (|IRREDFFX;qAdicExpansion| |start| $)
                                         (QREFELT $ 19)))
                         (QREFELT $ 23))
                        (LETT |found| 'T)))))
                    (EXIT (LETT |start| (+ |start| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((SPADCALL |pol| (QREFELT $ 24))
                 (|error| "no irreducible poly found"))
                ('T |pol|)))))) 

(SDEFUN |IRREDFFX;generateIrredPoly;PiSup;3|
        ((|n| (|PositiveInteger|)) ($ (|SparseUnivariatePolynomial| GF)))
        (COND ((EQL |n| 1) (SPADCALL (|spadConstant| $ 12) 1 (QREFELT $ 14)))
              ((OR (EQL (GCD (QREFELT $ 9) |n|) 1) (< |n| (QREFELT $ 11)))
               (COND ((ODDP |n|) (|IRREDFFX;getIrredPoly| 2 |n| $))
                     ('T (|IRREDFFX;getIrredPoly| 1 |n| $))))
              ('T (|IRREDFFX;getIrredPoly| (+ (QREFELT $ 11) 1) |n| $)))) 

(DECLAIM (NOTINLINE |IrredPolyOverFiniteField;|)) 

(DEFUN |IrredPolyOverFiniteField| (#1=#:G724)
  (SPROG NIL
         (PROG (#2=#:G725)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IrredPolyOverFiniteField|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|IrredPolyOverFiniteField;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|IrredPolyOverFiniteField|)))))))))) 

(DEFUN |IrredPolyOverFiniteField;| (|#1|)
  (SPROG
   ((#1=#:G702 NIL) (#2=#:G701 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|IrredPolyOverFiniteField| DV$1))
    (LETT $ (GETREFV 26))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|IrredPolyOverFiniteField| (LIST DV$1)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 9
              (PROG1 (LETT #2# (SPADCALL (QREFELT $ 8)))
                (|check_subtype2| (> #2# 0) '(|PositiveInteger|)
                                  '(|NonNegativeInteger|) #2#)))
    (QSETREFV $ 11
              (PROG1 (LETT #1# (SPADCALL (QREFELT $ 10)))
                (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                  '(|NonNegativeInteger|) #1#)))
    $))) 

(MAKEPROP '|IrredPolyOverFiniteField| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              (0 . |characteristic|) '|p| (4 . |size|) '|q| (8 . |One|)
              (|SparseUnivariatePolynomial| 6) (12 . |monomial|) (18 . *)
              (|PositiveInteger|) (24 . |index|) (29 . |coerce|) (34 . +)
              (40 . |Zero|) (|Boolean|) (|DistinctDegreeFactorize| 6 13)
              (44 . |irreducible?|) (49 . |zero?|)
              |IRREDFFX;generateIrredPoly;PiSup;3|)
           '#(|generateIrredPoly| 54) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|generateIrredPoly|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|PositiveInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 25
                                            '(0 6 7 8 0 6 7 10 0 6 0 12 2 13 0
                                              6 7 14 2 13 0 0 0 15 1 6 0 16 17
                                              1 13 0 6 18 2 13 0 0 0 19 0 13 0
                                              20 1 22 21 13 23 1 13 21 0 24 1 0
                                              13 16 25)))))
           '|lookupComplete|)) 

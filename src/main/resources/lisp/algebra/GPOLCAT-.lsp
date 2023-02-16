
(SDEFUN |GPOLCAT-;monomials;SL;1| ((|p| (S)) ($ (|List| S)))
        (SPROG ((|ml| (|List| S)))
               (SEQ (LETT |ml| NIL)
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p| (|spadConstant| $ 10)
                                      (QREFELT $ 13)))
                           (GO G191)))
                         (SEQ
                          (LETT |ml| (CONS (SPADCALL |p| (QREFELT $ 14)) |ml|))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 15)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (NREVERSE |ml|))))) 

(SDEFUN |GPOLCAT-;monomial;SLLS;2|
        ((|p| (S)) (|lv| (|List| |VarSet|))
         (|ln| (|List| (|NonNegativeInteger|))) ($ (S)))
        (COND
         ((NULL |lv|)
          (COND ((NULL |ln|) |p|)
                (#1='T (|error| "mismatched lists in monomial"))))
         ((NULL |ln|) (|error| "mismatched lists in monomial"))
         (#1#
          (SPADCALL
           (SPADCALL |p| (|SPADfirst| |lv|) (|SPADfirst| |ln|) (QREFELT $ 19))
           (CDR |lv|) (CDR |ln|) (QREFELT $ 22))))) 

(SDEFUN |GPOLCAT-;mkPrim| ((|p| (S)) ($ (S)))
        (SPADCALL (|spadConstant| $ 25) (SPADCALL |p| (QREFELT $ 26))
                  (QREFELT $ 27))) 

(SDEFUN |GPOLCAT-;primitiveMonomials;SL;4| ((|p| (S)) ($ (|List| S)))
        (SPROG ((|ml| (|List| S)))
               (SEQ (LETT |ml| NIL)
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p| (|spadConstant| $ 10)
                                      (QREFELT $ 13)))
                           (GO G191)))
                         (SEQ
                          (LETT |ml|
                                (CONS
                                 (|GPOLCAT-;mkPrim|
                                  (SPADCALL |p| (QREFELT $ 14)) $)
                                 |ml|))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 15)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (NREVERSE |ml|))))) 

(DECLAIM (NOTINLINE |MaybeSkewPolynomialCategory&;|)) 

(DEFUN |MaybeSkewPolynomialCategory&| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|MaybeSkewPolynomialCategory&| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 29))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|canonicalUnitNormal|))
                                        (|HasCategory| |#2| '(|Comparable|))
                                        (|HasCategory| |#2| '(|SemiRing|))
                                        (|HasCategory| |#2| '(|Ring|))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 3)
      (PROGN
       (QSETREFV $ 28
                 (CONS (|dispatchFunction| |GPOLCAT-;primitiveMonomials;SL;4|)
                       $)))))
    $))) 

(MAKEPROP '|MaybeSkewPolynomialCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |Zero|) (4 . |Zero|)
              (|Boolean|) (8 . ~=) (14 . |leadingMonomial|) (19 . |reductum|)
              (|List| $) |GPOLCAT-;monomials;SL;1| (|NonNegativeInteger|)
              (24 . |monomial|) (|List| 9) (|List| 18) (31 . |monomial|)
              |GPOLCAT-;monomial;SLLS;2| (38 . |One|) (42 . |One|)
              (46 . |degree|) (51 . |monomial|) (57 . |primitiveMonomials|))
           '#(|primitiveMonomials| 62 |monomials| 67 |monomial| 72) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|primitiveMonomials| ((|List| |#1|) |#1|)) T)
                              '((|monomial|
                                 (|#1| |#1| (|List| |#4|)
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|monomial|
                                 (|#1| |#1| |#4| (|NonNegativeInteger|)))
                                T)
                              '((|monomials| ((|List| |#1|) |#1|)) T)
                              '((|monomial| (|#1| |#2| |#3|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 28
                                            '(0 6 0 10 0 7 0 11 2 6 12 0 0 13 1
                                              6 0 0 14 1 6 0 0 15 3 6 0 0 9 18
                                              19 3 6 0 0 20 21 22 0 6 0 24 0 7
                                              0 25 1 6 8 0 26 2 6 0 7 8 27 1 0
                                              16 0 28 1 0 16 0 28 1 0 16 0 17 3
                                              0 0 0 20 21 23)))))
           '|lookupComplete|)) 

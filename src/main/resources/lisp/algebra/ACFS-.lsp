
(SDEFUN |ACFS-;rootOf;2S;1| ((|p| (S)) ($ (S)))
        (SPROG ((|l| (|List| (|Symbol|))))
               (COND
                ((NULL (LETT |l| (SPADCALL |p| (QREFELT $ 9))))
                 (|error| "rootOf: constant expression"))
                ('T (SPADCALL |p| (|SPADfirst| |l|) (QREFELT $ 11)))))) 

(SDEFUN |ACFS-;rootsOf;SL;2| ((|p| (S)) ($ (|List| S)))
        (SPROG ((|l| (|List| (|Symbol|))))
               (COND
                ((NULL (LETT |l| (SPADCALL |p| (QREFELT $ 9))))
                 (|error| "rootsOf: constant expression"))
                ('T (SPADCALL |p| (|SPADfirst| |l|) (QREFELT $ 14)))))) 

(SDEFUN |ACFS-;zeroOf;2S;3| ((|p| (S)) ($ (S)))
        (SPROG ((|l| (|List| (|Symbol|))))
               (COND
                ((NULL (LETT |l| (SPADCALL |p| (QREFELT $ 9))))
                 (|error| "zeroOf: constant expression"))
                ('T (SPADCALL |p| (|SPADfirst| |l|) (QREFELT $ 16)))))) 

(SDEFUN |ACFS-;zerosOf;SL;4| ((|p| (S)) ($ (|List| S)))
        (SPROG ((|l| (|List| (|Symbol|))))
               (COND
                ((NULL (LETT |l| (SPADCALL |p| (QREFELT $ 9))))
                 (|error| "zerosOf: constant expression"))
                ('T (SPADCALL |p| (|SPADfirst| |l|) (QREFELT $ 18)))))) 

(SDEFUN |ACFS-;zeroOf;SSS;5| ((|p| (S)) (|x| (|Symbol|)) ($ (S)))
        (SPROG
         ((|n| (|SparseUnivariatePolynomial| S))
          (|f| (|Fraction| (|SparseUnivariatePolynomial| S))))
         (SEQ
          (LETT |n|
                (SPADCALL
                 (LETT |f|
                       (SPADCALL |p| (SPADCALL |x| (QREFELT $ 21))
                                 (QREFELT $ 24)))
                 (QREFELT $ 27)))
          (EXIT
           (COND
            ((> (SPADCALL (SPADCALL |f| (QREFELT $ 28)) (QREFELT $ 30)) 0)
             (|error| "zeroOf: variable appears in denom"))
            ((EQL (SPADCALL |n| (QREFELT $ 30)) 0)
             (|error| "zeroOf: constant expression"))
            ('T (SPADCALL |n| |x| (QREFELT $ 32)))))))) 

(SDEFUN |ACFS-;rootOf;SSS;6| ((|p| (S)) (|x| (|Symbol|)) ($ (S)))
        (SPROG
         ((|n| (|SparseUnivariatePolynomial| S))
          (|f| (|Fraction| (|SparseUnivariatePolynomial| S))))
         (SEQ
          (LETT |n|
                (SPADCALL
                 (LETT |f|
                       (SPADCALL |p| (SPADCALL |x| (QREFELT $ 21))
                                 (QREFELT $ 24)))
                 (QREFELT $ 27)))
          (EXIT
           (COND
            ((> (SPADCALL (SPADCALL |f| (QREFELT $ 28)) (QREFELT $ 30)) 0)
             (|error| "roofOf: variable appears in denom"))
            ((EQL (SPADCALL |n| (QREFELT $ 30)) 0)
             (|error| "rootOf: constant expression"))
            ('T (SPADCALL |n| |x| (QREFELT $ 34)))))))) 

(SDEFUN |ACFS-;zerosOf;SSL;7| ((|p| (S)) (|x| (|Symbol|)) ($ (|List| S)))
        (SPROG
         ((|n| (|SparseUnivariatePolynomial| S))
          (|f| (|Fraction| (|SparseUnivariatePolynomial| S))))
         (SEQ
          (LETT |n|
                (SPADCALL
                 (LETT |f|
                       (SPADCALL |p| (SPADCALL |x| (QREFELT $ 21))
                                 (QREFELT $ 24)))
                 (QREFELT $ 27)))
          (EXIT
           (COND
            ((> (SPADCALL (SPADCALL |f| (QREFELT $ 28)) (QREFELT $ 30)) 0)
             (|error| "zerosOf: variable appears in denom"))
            ((EQL (SPADCALL |n| (QREFELT $ 30)) 0) NIL)
            ('T (SPADCALL |n| |x| (QREFELT $ 36)))))))) 

(SDEFUN |ACFS-;rootsOf;SSL;8| ((|p| (S)) (|x| (|Symbol|)) ($ (|List| S)))
        (SPROG
         ((|n| (|SparseUnivariatePolynomial| S))
          (|f| (|Fraction| (|SparseUnivariatePolynomial| S))))
         (SEQ
          (LETT |n|
                (SPADCALL
                 (LETT |f|
                       (SPADCALL |p| (SPADCALL |x| (QREFELT $ 21))
                                 (QREFELT $ 24)))
                 (QREFELT $ 27)))
          (EXIT
           (COND
            ((> (SPADCALL (SPADCALL |f| (QREFELT $ 28)) (QREFELT $ 30)) 0)
             (|error| "roofsOf: variable appears in denom"))
            ((EQL (SPADCALL |n| (QREFELT $ 30)) 0) NIL)
            ('T (SPADCALL |n| |x| (QREFELT $ 38)))))))) 

(SDEFUN |ACFS-;rootsOf;SupSL;9|
        ((|p| (|SparseUnivariatePolynomial| S)) (|y| (|Symbol|))
         ($ (|List| S)))
        (SPROG ((|r| (|Union| S "failed")))
               (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 41)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 0) (SPADCALL (QCDR |r|) |y| (QREFELT $ 14)))
                      ('T (SPADCALL |p| |y| (QREFELT $ 43)))))))) 

(SDEFUN |ACFS-;zerosOf;SupSL;10|
        ((|p| (|SparseUnivariatePolynomial| S)) (|y| (|Symbol|))
         ($ (|List| S)))
        (SPROG ((|r| (|Union| S "failed")))
               (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 41)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 0) (SPADCALL (QCDR |r|) |y| (QREFELT $ 18)))
                      ('T (SPADCALL |p| |y| (QREFELT $ 45)))))))) 

(SDEFUN |ACFS-;zeroOf;SupSS;11|
        ((|p| (|SparseUnivariatePolynomial| S)) (|y| (|Symbol|)) ($ (S)))
        (SPROG ((|r| (|Union| S "failed")))
               (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 41)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 0) (SPADCALL (QCDR |r|) |y| (QREFELT $ 16)))
                      ('T (SPADCALL |p| |y| (QREFELT $ 47)))))))) 

(DECLAIM (NOTINLINE |AlgebraicallyClosedFunctionSpace&;|)) 

(DEFUN |AlgebraicallyClosedFunctionSpace&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|AlgebraicallyClosedFunctionSpace&| DV$1 DV$2))
          (LETT $ (GETREFV 50))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|RetractableTo|
                                                               (|Integer|)))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|AlgebraicallyClosedFunctionSpace&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 10)
              (0 . |variables|) (|Symbol|) (5 . |rootOf|) |ACFS-;rootOf;2S;1|
              (|List| $) (11 . |rootsOf|) |ACFS-;rootsOf;SL;2| (17 . |zeroOf|)
              |ACFS-;zeroOf;2S;3| (23 . |zerosOf|) |ACFS-;zerosOf;SL;4|
              (|Kernel| 6) (29 . |kernel|) (|Fraction| 31) (|Kernel| $)
              (34 . |univariate|) (|SparseUnivariatePolynomial| 6)
              (|Fraction| 25) (40 . |numer|) (45 . |denom|)
              (|NonNegativeInteger|) (50 . |degree|)
              (|SparseUnivariatePolynomial| $) (55 . |zeroOf|)
              |ACFS-;zeroOf;SSS;5| (61 . |rootOf|) |ACFS-;rootOf;SSS;6|
              (67 . |zerosOf|) |ACFS-;zerosOf;SSL;7| (73 . |rootsOf|)
              |ACFS-;rootsOf;SSL;8| (|Union| 6 '"failed") (79 . |retractIfCan|)
              (|AlgebraicallyClosedField&| 6) (84 . |rootsOf|)
              |ACFS-;rootsOf;SupSL;9| (90 . |zerosOf|) |ACFS-;zerosOf;SupSL;10|
              (96 . |zeroOf|) |ACFS-;zeroOf;SupSS;11| (|Polynomial| $))
           '#(|zerosOf| 102 |zeroOf| 119 |rootsOf| 136 |rootOf| 153) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|zerosOf| ((|List| |#1|) |#1| (|Symbol|))) T)
                              '((|zeroOf| (|#1| |#1| (|Symbol|))) T)
                              '((|zerosOf| ((|List| |#1|) |#1|)) T)
                              '((|zeroOf| (|#1| |#1|)) T)
                              '((|rootsOf| ((|List| |#1|) |#1| (|Symbol|))) T)
                              '((|rootOf| (|#1| |#1| (|Symbol|))) T)
                              '((|rootsOf| ((|List| |#1|) |#1|)) T)
                              '((|rootOf| (|#1| |#1|)) T)
                              '((|zerosOf|
                                 ((|List| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|Symbol|)))
                                T)
                              '((|zerosOf|
                                 ((|List| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|zerosOf| ((|List| |#1|) (|Polynomial| |#1|)))
                                T)
                              '((|zeroOf|
                                 (|#1| (|SparseUnivariatePolynomial| |#1|)
                                  (|Symbol|)))
                                T)
                              '((|zeroOf|
                                 (|#1| (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|zeroOf| (|#1| (|Polynomial| |#1|))) T)
                              '((|rootsOf|
                                 ((|List| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|Symbol|)))
                                T)
                              '((|rootsOf|
                                 ((|List| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|rootsOf| ((|List| |#1|) (|Polynomial| |#1|)))
                                T)
                              '((|rootOf|
                                 (|#1| (|SparseUnivariatePolynomial| |#1|)
                                  (|Symbol|)))
                                T)
                              '((|rootOf|
                                 (|#1| (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|rootOf| (|#1| (|Polynomial| |#1|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 48
                                            '(1 6 8 0 9 2 6 0 0 10 11 2 6 13 0
                                              10 14 2 6 0 0 10 16 2 6 13 0 10
                                              18 1 20 0 10 21 2 6 22 0 23 24 1
                                              26 25 0 27 1 26 25 0 28 1 25 29 0
                                              30 2 6 0 31 10 32 2 6 0 31 10 34
                                              2 6 13 31 10 36 2 6 13 31 10 38 1
                                              25 40 0 41 2 42 13 31 10 43 2 42
                                              13 31 10 45 2 42 0 31 10 47 2 0
                                              13 0 10 37 1 0 13 0 19 2 0 13 31
                                              10 46 2 0 0 0 10 33 1 0 0 0 17 2
                                              0 0 31 10 48 2 0 13 0 10 39 1 0
                                              13 0 15 2 0 13 31 10 44 2 0 0 0
                                              10 35 1 0 0 0 12)))))
           '|lookupComplete|)) 

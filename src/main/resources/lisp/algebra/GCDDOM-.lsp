
(SDEFUN |GCDDOM-;lcm;3S;1| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPROG ((LCM (|Union| S "failed")))
               (SEQ
                (COND
                 ((OR (SPADCALL |y| (|spadConstant| $ 7) (QREFELT $ 9))
                      (SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 9)))
                  (|spadConstant| $ 7))
                 ('T
                  (SEQ
                   (LETT LCM
                         (SPADCALL |y| (SPADCALL |x| |y| (QREFELT $ 10))
                                   (QREFELT $ 12)))
                   (EXIT
                    (COND
                     ((QEQCAR LCM 0) (SPADCALL |x| (QCDR LCM) (QREFELT $ 13)))
                     ('T (|error| "bad gcd in lcm computation")))))))))) 

(SDEFUN |GCDDOM-;lcm;LS;2| ((|l| (|List| S)) ($ (S)))
        (SPADCALL (ELT $ 15) |l| (|spadConstant| $ 16) (|spadConstant| $ 7)
                  (QREFELT $ 19))) 

(SDEFUN |GCDDOM-;gcd;LS;3| ((|l| (|List| S)) ($ (S)))
        (SPADCALL (ELT $ 10) |l| (|spadConstant| $ 7) (|spadConstant| $ 16)
                  (QREFELT $ 19))) 

(SDEFUN |GCDDOM-;gcdPolynomial;3Sup;4|
        ((|p1| (|SparseUnivariatePolynomial| S))
         (|p2| (|SparseUnivariatePolynomial| S))
         ($ (|SparseUnivariatePolynomial| S)))
        (SPROG
         ((#1=#:G846 NIL) (|c2| (S)) (|p| (|SparseUnivariatePolynomial| S))
          (|c1| (S)) (|e1| #2=(|NonNegativeInteger|)) (|e2| #2#))
         (SEQ
          (COND ((SPADCALL |p1| (QREFELT $ 24)) (SPADCALL |p2| (QREFELT $ 25)))
                ((SPADCALL |p2| (QREFELT $ 24)) (SPADCALL |p1| (QREFELT $ 25)))
                (#3='T
                 (SEQ (LETT |c1| (SPADCALL |p1| (QREFELT $ 26)))
                      (LETT |c2| (SPADCALL |p2| (QREFELT $ 26)))
                      (LETT |p1|
                            (PROG2
                                (LETT #1# (SPADCALL |p1| |c1| (QREFELT $ 27)))
                                (QCDR #1#)
                              (|check_union2| (QEQCAR #1# 0)
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 6))
                                              (|Union|
                                               (|SparseUnivariatePolynomial|
                                                (QREFELT $ 6))
                                               #4="failed")
                                              #1#)))
                      (LETT |p2|
                            (PROG2
                                (LETT #1# (SPADCALL |p2| |c2| (QREFELT $ 27)))
                                (QCDR #1#)
                              (|check_union2| (QEQCAR #1# 0)
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 6))
                                              (|Union|
                                               (|SparseUnivariatePolynomial|
                                                (QREFELT $ 6))
                                               #4#)
                                              #1#)))
                      (SEQ (LETT |e1| (SPADCALL |p1| (QREFELT $ 29)))
                           (EXIT
                            (COND
                             ((> |e1| 0)
                              (LETT |p1|
                                    (PROG2
                                        (LETT #1#
                                              (SPADCALL |p1|
                                                        (SPADCALL
                                                         (|spadConstant| $ 16)
                                                         |e1| (QREFELT $ 32))
                                                        (QREFELT $ 33)))
                                        (QCDR #1#)
                                      (|check_union2| (QEQCAR #1# 0)
                                                      (|SparseUnivariatePolynomial|
                                                       (QREFELT $ 6))
                                                      (|Union|
                                                       (|SparseUnivariatePolynomial|
                                                        (QREFELT $ 6))
                                                       #4#)
                                                      #1#)))))))
                      (SEQ (LETT |e2| (SPADCALL |p2| (QREFELT $ 29)))
                           (EXIT
                            (COND
                             ((> |e2| 0)
                              (LETT |p2|
                                    (PROG2
                                        (LETT #1#
                                              (SPADCALL |p2|
                                                        (SPADCALL
                                                         (|spadConstant| $ 16)
                                                         |e2| (QREFELT $ 32))
                                                        (QREFELT $ 33)))
                                        (QCDR #1#)
                                      (|check_union2| (QEQCAR #1# 0)
                                                      (|SparseUnivariatePolynomial|
                                                       (QREFELT $ 6))
                                                      (|Union|
                                                       (|SparseUnivariatePolynomial|
                                                        (QREFELT $ 6))
                                                       #4#)
                                                      #1#)))))))
                      (LETT |e1| (MIN |e1| |e2|))
                      (LETT |c1| (SPADCALL |c1| |c2| (QREFELT $ 10)))
                      (LETT |p1|
                            (COND
                             ((OR (EQL (SPADCALL |p1| (QREFELT $ 34)) 0)
                                  (EQL (SPADCALL |p2| (QREFELT $ 34)) 0))
                              (SPADCALL |c1| 0 (QREFELT $ 32)))
                             ('T
                              (SEQ
                               (LETT |p| (SPADCALL |p1| |p2| (QREFELT $ 35)))
                               (EXIT
                                (COND
                                 ((EQL (SPADCALL |p| (QREFELT $ 34)) 0)
                                  (SPADCALL |c1| 0 (QREFELT $ 32)))
                                 (#3#
                                  (SEQ
                                   (LETT |c2|
                                         (SPADCALL
                                          (SPADCALL |p1| (QREFELT $ 36))
                                          (SPADCALL |p2| (QREFELT $ 36))
                                          (QREFELT $ 10)))
                                   (EXIT
                                    (SPADCALL
                                     (SPADCALL |c1|
                                               (SPADCALL
                                                (PROG2
                                                    (LETT #1#
                                                          (SPADCALL
                                                           (SPADCALL |c2| |p|
                                                                     (QREFELT $
                                                                              37))
                                                           (SPADCALL |p|
                                                                     (QREFELT $
                                                                              36))
                                                           (QREFELT $ 27)))
                                                    (QCDR #1#)
                                                  (|check_union2|
                                                   (QEQCAR #1# 0)
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 6))
                                                   (|Union|
                                                    (|SparseUnivariatePolynomial|
                                                     (QREFELT $ 6))
                                                    #4#)
                                                   #1#))
                                                (QREFELT $ 38))
                                               (QREFELT $ 37))
                                     (QREFELT $ 25)))))))))))
                      (EXIT
                       (COND ((ZEROP |e1|) |p1|)
                             (#3#
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 16) |e1|
                                         (QREFELT $ 32))
                               |p1| (QREFELT $ 39))))))))))) 

(SDEFUN |GCDDOM-;lcmCoef;2SR;5|
        ((|c1| (S)) (|c2| (S))
         ($ (|Record| (|:| |llcm_res| S) (|:| |coeff1| S) (|:| |coeff2| S))))
        (SPROG ((|cc2| (S)) (#1=#:G942 NIL) (|cc1| (S)) (|g| (S)))
               (SEQ (LETT |g| (SPADCALL |c1| |c2| (QREFELT $ 10)))
                    (LETT |cc1|
                          (PROG2 (LETT #1# (SPADCALL |c2| |g| (QREFELT $ 12)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                            (|Union| (QREFELT $ 6) #2="failed")
                                            #1#)))
                    (LETT |cc2|
                          (PROG2 (LETT #1# (SPADCALL |c1| |g| (QREFELT $ 12)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                            (|Union| (QREFELT $ 6) #2#) #1#)))
                    (EXIT
                     (VECTOR (SPADCALL |cc1| |c1| (QREFELT $ 13)) |cc1|
                             |cc2|))))) 

(DECLAIM (NOTINLINE |GcdDomain&;|)) 

(DEFUN |GcdDomain&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|GcdDomain&| DV$1))
          (LETT $ (GETREFV 44))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GcdDomain&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|) (|Boolean|)
              (4 . =) (10 . |gcd|) (|Union| $ '"failed") (16 . |exquo|)
              (22 . *) |GCDDOM-;lcm;3S;1| (28 . |lcm|) (34 . |One|)
              (|Mapping| 6 6 6) (|List| 6) (38 . |reduce|) (|List| $)
              |GCDDOM-;lcm;LS;2| |GCDDOM-;gcd;LS;3|
              (|SparseUnivariatePolynomial| 6) (46 . |zero?|)
              (51 . |unitCanonical|) (56 . |content|) (61 . |exquo|)
              (|NonNegativeInteger|) (67 . |minimumDegree|) (72 . |Zero|)
              (76 . |One|) (80 . |monomial|) (86 . |exquo|) (92 . |degree|)
              (97 . |subResultantGcd|) (103 . |leadingCoefficient|) (108 . *)
              (114 . |primitivePart|) (119 . *)
              (|SparseUnivariatePolynomial| $) |GCDDOM-;gcdPolynomial;3Sup;4|
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              |GCDDOM-;lcmCoef;2SR;5|)
           '#(|lcmCoef| 125 |lcm| 131 |gcdPolynomial| 142 |gcd| 148) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|gcdPolynomial|
                                 ((|SparseUnivariatePolynomial| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T)
                              '((|lcm| (|#1| (|List| |#1|))) T)
                              '((|lcm| (|#1| |#1| |#1|)) T)
                              '((|gcd| (|#1| (|List| |#1|))) T)
                              '((|gcd| (|#1| |#1| |#1|)) T)
                              '((|lcmCoef|
                                 ((|Record| (|:| |llcm_res| |#1|)
                                            (|:| |coeff1| |#1|)
                                            (|:| |coeff2| |#1|))
                                  |#1| |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 43
                                            '(0 6 0 7 2 6 8 0 0 9 2 6 0 0 0 10
                                              2 6 11 0 0 12 2 6 0 0 0 13 2 6 0
                                              0 0 15 0 6 0 16 4 18 6 17 0 6 6
                                              19 1 23 8 0 24 1 23 0 0 25 1 23 6
                                              0 26 2 23 11 0 6 27 1 23 28 0 29
                                              0 23 0 30 0 23 0 31 2 23 0 6 28
                                              32 2 23 11 0 0 33 1 23 28 0 34 2
                                              23 0 0 0 35 1 23 6 0 36 2 23 0 6
                                              0 37 1 23 0 0 38 2 23 0 0 0 39 2
                                              0 42 0 0 43 2 0 0 0 0 14 1 0 0 20
                                              21 2 0 40 40 40 41 1 0 0 20
                                              22)))))
           '|lookupComplete|)) 

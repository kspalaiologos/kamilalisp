
(SDEFUN |UPOLYC-;variables;SL;1|
        ((|p| (S)) ($ (|List| (|SingletonAsOrderedSet|))))
        (COND
         ((OR (SPADCALL |p| (QREFELT $ 9))
              (ZEROP (SPADCALL |p| (QREFELT $ 11))))
          NIL)
         ('T (LIST (SPADCALL (QREFELT $ 13)))))) 

(SDEFUN |UPOLYC-;degree;SSaosNni;2|
        ((|p| (S)) (|v| (|SingletonAsOrderedSet|)) ($ (|NonNegativeInteger|)))
        (SPADCALL |p| (QREFELT $ 11))) 

(SDEFUN |UPOLYC-;totalDegree;SLNni;3|
        ((|p| (S)) (|lv| (|List| (|SingletonAsOrderedSet|)))
         ($ (|NonNegativeInteger|)))
        (COND ((NULL |lv|) 0) ('T (SPADCALL |p| (QREFELT $ 17))))) 

(SDEFUN |UPOLYC-;degree;SLL;4|
        ((|p| (S)) (|lv| (|List| (|SingletonAsOrderedSet|)))
         ($ (|List| (|NonNegativeInteger|))))
        (COND ((NULL |lv|) NIL) ('T (LIST (SPADCALL |p| (QREFELT $ 11)))))) 

(SDEFUN |UPOLYC-;eval;SLLS;5|
        ((|p| (S)) (|lv| (|List| (|SingletonAsOrderedSet|))) (|lq| (|List| S))
         ($ (S)))
        (COND ((NULL |lv|) |p|)
              ((NULL (NULL (CDR |lv|)))
               (|error| "can only eval a univariate polynomial once"))
              ('T
               (SPADCALL |p| (|SPADfirst| |lv|) (|SPADfirst| |lq|)
                         (QREFELT $ 21))))) 

(SDEFUN |UPOLYC-;eval;SSaos2S;6|
        ((|p| (S)) (|v| (|SingletonAsOrderedSet|)) (|q| (S)) ($ (S)))
        (SPADCALL |p| |q| (QREFELT $ 24))) 

(SDEFUN |UPOLYC-;eval;SLLS;7|
        ((|p| (S)) (|lv| (|List| (|SingletonAsOrderedSet|))) (|lr| (|List| R))
         ($ (S)))
        (COND ((NULL |lv|) |p|)
              ((NULL (NULL (CDR |lv|)))
               (|error| "can only eval a univariate polynomial once"))
              ('T
               (SPADCALL |p| (|SPADfirst| |lv|) (|SPADfirst| |lr|)
                         (QREFELT $ 26))))) 

(SDEFUN |UPOLYC-;eval;SSaosRS;8|
        ((|p| (S)) (|v| (|SingletonAsOrderedSet|)) (|r| (R)) ($ (S)))
        (SPADCALL (SPADCALL |p| |r| (QREFELT $ 29)) (QREFELT $ 30))) 

(SDEFUN |UPOLYC-;eval;SLS;9| ((|p| (S)) (|le| (|List| (|Equation| S))) ($ (S)))
        (COND ((NULL |le|) |p|)
              ((NULL (NULL (CDR |le|)))
               (|error| "can only eval a univariate polynomial once"))
              ('T
               (COND
                ((QEQCAR
                  (SPADCALL (SPADCALL (|SPADfirst| |le|) (QREFELT $ 33))
                            (QREFELT $ 35))
                  1)
                 |p|)
                ('T
                 (SPADCALL |p| (SPADCALL (|SPADfirst| |le|) (QREFELT $ 36))
                           (QREFELT $ 24))))))) 

(SDEFUN |UPOLYC-;mainVariable;SU;10|
        ((|p| (S)) ($ (|Union| (|SingletonAsOrderedSet|) "failed")))
        (COND ((ZEROP (SPADCALL |p| (QREFELT $ 11))) (CONS 1 "failed"))
              ('T (CONS 0 (SPADCALL (QREFELT $ 13)))))) 

(SDEFUN |UPOLYC-;minimumDegree;SSaosNni;11|
        ((|p| (S)) (|v| (|SingletonAsOrderedSet|)) ($ (|NonNegativeInteger|)))
        (SPADCALL |p| (QREFELT $ 40))) 

(SDEFUN |UPOLYC-;minimumDegree;SLL;12|
        ((|p| (S)) (|lv| (|List| (|SingletonAsOrderedSet|)))
         ($ (|List| (|NonNegativeInteger|))))
        (COND ((NULL |lv|) NIL) ('T (LIST (SPADCALL |p| (QREFELT $ 40)))))) 

(SDEFUN |UPOLYC-;monomial;SSaosNniS;13|
        ((|p| (S)) (|v| (|SingletonAsOrderedSet|)) (|n| (|NonNegativeInteger|))
         ($ (S)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|UPOLYC-;monomial;SSaosNniS;13!0| (VECTOR $ |n|)) |p|
                (QREFELT $ 45)))) 

(SDEFUN |UPOLYC-;monomial;SSaosNniS;13!0| ((|x1| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |n| (QREFELT $ 43)))))) 

(SDEFUN |UPOLYC-;coerce;SaosS;14| ((|v| (|SingletonAsOrderedSet|)) ($ (S)))
        (SPADCALL (|spadConstant| $ 48) 1 (QREFELT $ 49))) 

(SDEFUN |UPOLYC-;makeSUP;SSup;15|
        ((|p| (S)) ($ (|SparseUnivariatePolynomial| R)))
        (COND ((SPADCALL |p| (QREFELT $ 9)) (|spadConstant| $ 52))
              ('T
               (SPADCALL
                (SPADCALL (SPADCALL |p| (QREFELT $ 53))
                          (SPADCALL |p| (QREFELT $ 11)) (QREFELT $ 54))
                (SPADCALL (SPADCALL |p| (QREFELT $ 55)) (QREFELT $ 56))
                (QREFELT $ 57))))) 

(SDEFUN |UPOLYC-;unmakeSUP;SupS;16|
        ((|sp| (|SparseUnivariatePolynomial| R)) ($ (S)))
        (COND ((SPADCALL |sp| (QREFELT $ 59)) (|spadConstant| $ 60))
              ('T
               (SPADCALL
                (SPADCALL (SPADCALL |sp| (QREFELT $ 61))
                          (SPADCALL |sp| (QREFELT $ 62)) (QREFELT $ 49))
                (SPADCALL (SPADCALL |sp| (QREFELT $ 63)) (QREFELT $ 64))
                (QREFELT $ 65))))) 

(SDEFUN |UPOLYC-;solveLinearPolynomialEquation;LSupU;17|
        ((|lpp| (|List| (|SparseUnivariatePolynomial| S)))
         (|pp| (|SparseUnivariatePolynomial| S))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| S)) "failed")))
        (SPADCALL |lpp| |pp| (QREFELT $ 71))) 

(SDEFUN |UPOLYC-;factorPolynomial;SupF;18|
        ((|pp| (|SparseUnivariatePolynomial| S))
         ($ (|Factored| (|SparseUnivariatePolynomial| S))))
        (SPADCALL |pp| (QREFELT $ 77))) 

(SDEFUN |UPOLYC-;factorSquareFreePolynomial;SupF;19|
        ((|pp| (|SparseUnivariatePolynomial| S))
         ($ (|Factored| (|SparseUnivariatePolynomial| S))))
        (SPADCALL |pp| (QREFELT $ 80))) 

(SDEFUN |UPOLYC-;factor;SF;20| ((|p| (S)) ($ (|Factored| S)))
        (SPROG
         ((#1=#:G837 NIL) (|w| NIL) (#2=#:G836 NIL) (|ansR| (|Factored| R)))
         (SEQ
          (COND
           ((ZEROP (SPADCALL |p| (QREFELT $ 11)))
            (SEQ
             (LETT |ansR|
                   (SPADCALL (SPADCALL |p| (QREFELT $ 53)) (QREFELT $ 83)))
             (EXIT
              (SPADCALL
               (SPADCALL (SPADCALL |ansR| (QREFELT $ 85)) (QREFELT $ 30))
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |w| NIL) (LETT #1# (SPADCALL |ansR| (QREFELT $ 89)))
                     G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |w| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (VECTOR (QVELT |w| 0)
                                      (SPADCALL (QVELT |w| 1) (QREFELT $ 30))
                                      (QVELT |w| 2))
                              #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#))))
               (QREFELT $ 93)))))
           ('T
            (SPADCALL (ELT $ 64)
                      (SPADCALL (SPADCALL |p| (QREFELT $ 56)) (QREFELT $ 94))
                      (QREFELT $ 98))))))) 

(SDEFUN |UPOLYC-;vectorise;SNniV;21|
        ((|p| (S)) (|n| (|NonNegativeInteger|)) ($ (|Vector| R)))
        (SPROG
         ((#1=#:G841 NIL) (#2=#:G845 NIL) (|i| NIL) (|m| (|Integer|))
          (|v| (|Vector| R)))
         (SEQ
          (LETT |m|
                (SPADCALL (LETT |v| (MAKEARR1 |n| (|spadConstant| $ 100)))
                          (QREFELT $ 103)))
          (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 103)))
               (LETT #2# (QVSIZE |v|)) G190 (COND ((> |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (QSETAREF1O |v| |i|
                             (SPADCALL |p|
                                       (PROG1 (LETT #1# (- |i| |m|))
                                         (|check_subtype2| (>= #1# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #1#))
                                       (QREFELT $ 104))
                             1)))
               (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
          (EXIT |v|)))) 

(SDEFUN |UPOLYC-;unvectorise;VS;22| ((|v| (|Vector| R)) ($ (S)))
        (SPROG ((|p| (S)) (#1=#:G847 NIL) (#2=#:G851 NIL) (|i| NIL))
               (SEQ (LETT |p| (|spadConstant| $ 60))
                    (SEQ (LETT |i| 1) (LETT #2# (QVSIZE |v|)) G190
                         (COND ((|greater_SI| |i| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |p|
                                 (SPADCALL |p|
                                           (SPADCALL
                                            (SPADCALL |v| |i| (QREFELT $ 106))
                                            (PROG1 (LETT #1# (- |i| 1))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 49))
                                           (QREFELT $ 65)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |p|)))) 

(SDEFUN |UPOLYC-;retract;SR;23| ((|p| (S)) ($ (R)))
        (COND ((SPADCALL |p| (QREFELT $ 9)) (|spadConstant| $ 100))
              ((ZEROP (SPADCALL |p| (QREFELT $ 11)))
               (SPADCALL |p| (QREFELT $ 53)))
              ('T (|error| "Polynomial is not of degree 0")))) 

(SDEFUN |UPOLYC-;retractIfCan;SU;24| ((|p| (S)) ($ (|Union| R "failed")))
        (COND ((SPADCALL |p| (QREFELT $ 9)) (CONS 0 (|spadConstant| $ 100)))
              ((ZEROP (SPADCALL |p| (QREFELT $ 11)))
               (CONS 0 (SPADCALL |p| (QREFELT $ 53))))
              ('T (CONS 1 "failed")))) 

(SDEFUN |UPOLYC-;init;S;25| (($ (S)))
        (SPADCALL (|spadConstant| $ 111) (QREFELT $ 30))) 

(SDEFUN |UPOLYC-;nextItemInner| ((|n| (S)) ($ (|Union| S #1="failed")))
        (SPROG
         ((|n3| #2=(|Union| R #3="failed")) (#4=#:G869 NIL)
          (|n2| (|Union| S #1#)) (|n1| (S)) (|nn| #2#))
         (SEQ
          (COND
           ((SPADCALL |n| (QREFELT $ 9))
            (CONS 0
                  (SPADCALL
                   (PROG2
                       (LETT #4#
                             (SPADCALL (|spadConstant| $ 100) (QREFELT $ 114)))
                       (QCDR #4#)
                     (|check_union2| (QEQCAR #4# 0) (QREFELT $ 7)
                                     (|Union| (QREFELT $ 7) #3#) #4#))
                   (QREFELT $ 30))))
           ((ZEROP (SPADCALL |n| (QREFELT $ 11)))
            (SEQ
             (LETT |nn|
                   (SPADCALL (SPADCALL |n| (QREFELT $ 53)) (QREFELT $ 114)))
             (EXIT
              (COND ((QEQCAR |nn| 1) (CONS 1 "failed"))
                    (#5='T (CONS 0 (SPADCALL (QCDR |nn|) (QREFELT $ 30))))))))
           (#5#
            (SEQ (LETT |n1| (SPADCALL |n| (QREFELT $ 55)))
                 (LETT |n2| (|UPOLYC-;nextItemInner| |n1| $))
                 (EXIT
                  (COND
                   ((QEQCAR |n2| 0)
                    (CONS 0
                          (SPADCALL
                           (SPADCALL (SPADCALL |n| (QREFELT $ 53))
                                     (SPADCALL |n| (QREFELT $ 11))
                                     (QREFELT $ 49))
                           (QCDR |n2|) (QREFELT $ 65))))
                   ((< (+ 1 (SPADCALL |n1| (QREFELT $ 11)))
                       (SPADCALL |n| (QREFELT $ 11)))
                    (CONS 0
                          (SPADCALL
                           (SPADCALL (SPADCALL |n| (QREFELT $ 53))
                                     (SPADCALL |n| (QREFELT $ 11))
                                     (QREFELT $ 49))
                           (SPADCALL
                            (PROG2
                                (LETT #4#
                                      (SPADCALL (|spadConstant| $ 111)
                                                (QREFELT $ 114)))
                                (QCDR #4#)
                              (|check_union2| (QEQCAR #4# 0) (QREFELT $ 7)
                                              (|Union| (QREFELT $ 7) #3#) #4#))
                            (+ 1 (SPADCALL |n1| (QREFELT $ 11)))
                            (QREFELT $ 49))
                           (QREFELT $ 65))))
                   (#5#
                    (SEQ
                     (LETT |n3|
                           (SPADCALL (SPADCALL |n| (QREFELT $ 53))
                                     (QREFELT $ 114)))
                     (EXIT
                      (COND ((QEQCAR |n3| 1) (CONS 1 "failed"))
                            (#5#
                             (CONS 0
                                   (SPADCALL (QCDR |n3|)
                                             (SPADCALL |n| (QREFELT $ 11))
                                             (QREFELT $ 49)))))))))))))))) 

(SDEFUN |UPOLYC-;nextItem;SU;27| ((|n| (S)) ($ (|Union| S #1="failed")))
        (SPROG ((#2=#:G882 NIL) (|n1| (|Union| S "failed")))
               (SEQ (LETT |n1| (|UPOLYC-;nextItemInner| |n| $))
                    (EXIT
                     (COND
                      ((QEQCAR |n1| 1)
                       (CONS 0
                             (SPADCALL
                              (PROG2
                                  (LETT #2#
                                        (SPADCALL (|spadConstant| $ 111)
                                                  (QREFELT $ 114)))
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 0) (QREFELT $ 7)
                                                (|Union| (QREFELT $ 7) #1#)
                                                #2#))
                              (+ 1 (SPADCALL |n| (QREFELT $ 11)))
                              (QREFELT $ 49))))
                      ('T |n1|)))))) 

(SDEFUN |UPOLYC-;content;SSaosS;28|
        ((|p| (S)) (|v| (|SingletonAsOrderedSet|)) ($ (S)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 116)) (QREFELT $ 30))) 

(SDEFUN |UPOLYC-;primeFactor| ((|p| (S)) (|q| (S)) ($ (S)))
        (SPROG ((|p1| (S)) (#1=#:G888 NIL))
               (SEQ
                (LETT |p1|
                      (PROG2
                          (LETT #1#
                                (SPADCALL |p|
                                          (SPADCALL |p| |q| (QREFELT $ 118))
                                          (QREFELT $ 119)))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                        (|Union| (QREFELT $ 6) "failed") #1#)))
                (EXIT
                 (COND ((SPADCALL |p1| |p| (QREFELT $ 120)) |p|)
                       ('T (|UPOLYC-;primeFactor| |p1| |q| $))))))) 

(SDEFUN |UPOLYC-;separate;2SR;30|
        ((|p| (S)) (|q| (S))
         ($ (|Record| (|:| |primePart| S) (|:| |commonPart| S))))
        (SPROG ((#1=#:G894 NIL) (|a| (S)))
               (SEQ (LETT |a| (|UPOLYC-;primeFactor| |p| |q| $))
                    (EXIT
                     (CONS |a|
                           (PROG2 (LETT #1# (SPADCALL |p| |a| (QREFELT $ 119)))
                               (QCDR #1#)
                             (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                             (|Union| (QREFELT $ 6) "failed")
                                             #1#))))))) 

(SDEFUN |UPOLYC-;differentiate;SM2S;31|
        ((|x| (S)) (|deriv| (|Mapping| R R)) (|x'| (S)) ($ (S)))
        (SPROG
         ((|d| (S)) (#1=#:G900 NIL) (|lc| (R)) (|dg| (|NonNegativeInteger|)))
         (SEQ (LETT |d| (|spadConstant| $ 60))
              (SEQ G190
                   (COND
                    ((NULL (> (LETT |dg| (SPADCALL |x| (QREFELT $ 11))) 0))
                     (GO G191)))
                   (SEQ (LETT |lc| (SPADCALL |x| (QREFELT $ 53)))
                        (LETT |d|
                              (SPADCALL
                               (SPADCALL |d|
                                         (SPADCALL |x'|
                                                   (SPADCALL
                                                    (SPADCALL |dg| |lc|
                                                              (QREFELT $ 123))
                                                    (PROG1
                                                        (LETT #1# (- |dg| 1))
                                                      (|check_subtype2|
                                                       (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#))
                                                    (QREFELT $ 49))
                                                   (QREFELT $ 124))
                                         (QREFELT $ 65))
                               (SPADCALL (SPADCALL |lc| |deriv|) |dg|
                                         (QREFELT $ 49))
                               (QREFELT $ 65)))
                        (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 55)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |d|
                         (SPADCALL
                          (SPADCALL (SPADCALL |x| (QREFELT $ 53)) |deriv|)
                          (QREFELT $ 30))
                         (QREFELT $ 65)))))) 

(SDEFUN |UPOLYC-;ncdiff| ((|n| (|NonNegativeInteger|)) (|x'| (S)) ($ (S)))
        (SPROG ((|n1| (|NonNegativeInteger|)) (#1=#:G916 NIL))
               (COND ((ZEROP |n|) (|spadConstant| $ 60))
                     ((ZEROP
                       (LETT |n1|
                             (PROG1 (LETT #1# (- |n| 1))
                               (|check_subtype2| (>= #1# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #1#))))
                      |x'|)
                     ('T
                      (SPADCALL
                       (SPADCALL |x'|
                                 (SPADCALL (|spadConstant| $ 48) |n1|
                                           (QREFELT $ 49))
                                 (QREFELT $ 124))
                       (SPADCALL
                        (SPADCALL (|spadConstant| $ 48) 1 (QREFELT $ 49))
                        (|UPOLYC-;ncdiff| |n1| |x'| $) (QREFELT $ 124))
                       (QREFELT $ 65)))))) 

(SDEFUN |UPOLYC-;differentiate;SM2S;33|
        ((|x| (S)) (|deriv| (|Mapping| R R)) (|x'| (S)) ($ (S)))
        (SPROG ((|d| (S)) (|lc| (R)) (|dg| (|NonNegativeInteger|)))
               (SEQ (LETT |d| (|spadConstant| $ 60))
                    (SEQ G190
                         (COND
                          ((NULL
                            (> (LETT |dg| (SPADCALL |x| (QREFELT $ 11))) 0))
                           (GO G191)))
                         (SEQ (LETT |lc| (SPADCALL |x| (QREFELT $ 53)))
                              (LETT |d|
                                    (SPADCALL
                                     (SPADCALL |d|
                                               (SPADCALL
                                                (SPADCALL |lc| |deriv|) |dg|
                                                (QREFELT $ 49))
                                               (QREFELT $ 65))
                                     (SPADCALL |lc|
                                               (|UPOLYC-;ncdiff| |dg| |x'| $)
                                               (QREFELT $ 127))
                                     (QREFELT $ 65)))
                              (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 55)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL |d|
                               (SPADCALL
                                (SPADCALL (SPADCALL |x| (QREFELT $ 53))
                                          |deriv|)
                                (QREFELT $ 30))
                               (QREFELT $ 65)))))) 

(SDEFUN |UPOLYC-;differentiate;SMS;34|
        ((|x| (S)) (|deriv| (|Mapping| R R)) ($ (S)))
        (SPADCALL |x| |deriv| (|spadConstant| $ 47) (QREFELT $ 128))) 

(SDEFUN |UPOLYC-;differentiate;2S;35| ((|x| (S)) ($ (S)))
        (SPROG ((|d| (S)) (#1=#:G929 NIL) (|dg| (|NonNegativeInteger|)))
               (SEQ (LETT |d| (|spadConstant| $ 60))
                    (SEQ G190
                         (COND
                          ((NULL
                            (> (LETT |dg| (SPADCALL |x| (QREFELT $ 11))) 0))
                           (GO G191)))
                         (SEQ
                          (LETT |d|
                                (SPADCALL |d|
                                          (SPADCALL
                                           (SPADCALL |dg|
                                                     (SPADCALL |x|
                                                               (QREFELT $ 53))
                                                     (QREFELT $ 123))
                                           (PROG1 (LETT #1# (- |dg| 1))
                                             (|check_subtype2| (>= #1# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #1#))
                                           (QREFELT $ 49))
                                          (QREFELT $ 65)))
                          (EXIT (LETT |x| (SPADCALL |x| (QREFELT $ 55)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |d|)))) 

(SDEFUN |UPOLYC-;differentiate;SSaosS;36|
        ((|x| (S)) (|v| (|SingletonAsOrderedSet|)) ($ (S)))
        (SPADCALL |x| (QREFELT $ 131))) 

(SDEFUN |UPOLYC-;pseudoRemainder;3S;37| ((|p| (S)) (|q| (S)) ($ (S)))
        (SPROG
         ((|n| (|NonNegativeInteger|)) (#1=#:G942 NIL) (#2=#:G949 NIL)
          (|u| (|Union| (|NonNegativeInteger|) "failed")) (#3=#:G935 NIL)
          (|e2| (|NonNegativeInteger|)) (|c2| (R)))
         (SEQ
          (COND
           ((SPADCALL |q| (QREFELT $ 9)) (|error| "PseudoDivision by Zero"))
           ((SPADCALL |p| (QREFELT $ 9)) (|spadConstant| $ 60))
           (#4='T
            (SEQ (LETT |c2| (SPADCALL |q| (QREFELT $ 53)))
                 (LETT |e2| (SPADCALL |q| (QREFELT $ 11)))
                 (LETT |q| (SPADCALL |q| (QREFELT $ 55)))
                 (LETT |n|
                       (PROG1
                           (LETT #3#
                                 (MAX
                                  (+ (- (SPADCALL |p| (QREFELT $ 11)) |e2|) 1)
                                  0))
                         (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #3#)))
                 (SEQ
                  (EXIT
                   (SEQ G190
                        (COND
                         ((NULL (NULL (SPADCALL |p| (QREFELT $ 9))))
                          (GO G191)))
                        (SEQ
                         (SEQ
                          (LETT |u|
                                (SPADCALL (SPADCALL |p| (QREFELT $ 11)) |e2|
                                          (QREFELT $ 133)))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 1)
                             (PROGN (LETT #2# 1) (GO #5=#:G944))))))
                         (LETT |p|
                               (SPADCALL
                                (SPADCALL |c2| (SPADCALL |p| (QREFELT $ 55))
                                          (QREFELT $ 127))
                                (QCDR |u|) (SPADCALL |p| (QREFELT $ 53)) |q|
                                (QREFELT $ 134)))
                         (EXIT
                          (LETT |n|
                                (PROG1 (LETT #1# (- |n| 1))
                                  (|check_subtype2| (>= #1# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #1#)))))
                        NIL (GO G190) G191 (EXIT NIL)))
                  #5# (EXIT #2#))
                 (EXIT
                  (COND ((EQL |n| 0) |p|)
                        (#4#
                         (SPADCALL (SPADCALL |c2| |n| (QREFELT $ 135)) |p|
                                   (QREFELT $ 127))))))))))) 

(SDEFUN |UPOLYC-;elt;3F;38|
        ((|g| (|Fraction| S)) (|f| (|Fraction| S)) ($ (|Fraction| S)))
        (SPADCALL (SPADCALL (SPADCALL |g| (QREFELT $ 138)) |f| (QREFELT $ 140))
                  (SPADCALL (SPADCALL |g| (QREFELT $ 141)) |f| (QREFELT $ 140))
                  (QREFELT $ 142))) 

(SDEFUN |UPOLYC-;pseudoQuotient;3S;39| ((|p| (S)) (|q| (S)) ($ (S)))
        (SPROG
         ((|quot| (S)) (|mon| (S)) (#1=#:G954 NIL) (|i| (|NonNegativeInteger|))
          (#2=#:G953 NIL) (|delta| (|Integer|)) (#3=#:G951 NIL) (|lcQ| (R))
          (|degQ| #4=(|NonNegativeInteger|)) (|degP| #4#) (|#G77| #4#)
          (|#G76| #4#))
         (SEQ
          (COND
           ((SPADCALL |q| (QREFELT $ 9)) (|error| "PseudoDivision by Zero"))
           ((SPADCALL |p| (QREFELT $ 9)) (|spadConstant| $ 60))
           (#5='T
            (SEQ
             (PROGN
              (LETT |#G76| (SPADCALL |p| (QREFELT $ 11)))
              (LETT |#G77| (SPADCALL |q| (QREFELT $ 11)))
              (LETT |degP| |#G76|)
              (LETT |degQ| |#G77|))
             (EXIT
              (COND ((< |degP| |degQ|) (|spadConstant| $ 60))
                    (#5#
                     (SEQ (LETT |lcQ| (SPADCALL |q| (QREFELT $ 53)))
                          (LETT |q| (SPADCALL |q| (QREFELT $ 55)))
                          (LETT |i|
                                (PROG1 (LETT #3# (+ (- |degP| |degQ|) 1))
                                  (|check_subtype2| (>= #3# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #3#)))
                          (LETT |quot| (|spadConstant| $ 60))
                          (SEQ G190
                               (COND
                                ((NULL
                                  (>=
                                   (LETT |delta|
                                         (- (SPADCALL |p| (QREFELT $ 11))
                                            |degQ|))
                                   0))
                                 (GO G191)))
                               (SEQ
                                (LETT |i|
                                      (PROG1 (LETT #2# (- |i| 1))
                                        (|check_subtype2| (>= #2# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #2#)))
                                (LETT |mon|
                                      (SPADCALL (SPADCALL |p| (QREFELT $ 53))
                                                (PROG1 (LETT #1# |delta|)
                                                  (|check_subtype2| (>= #1# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #1#))
                                                (QREFELT $ 49)))
                                (LETT |quot|
                                      (SPADCALL |quot|
                                                (SPADCALL
                                                 (SPADCALL |lcQ| |i|
                                                           (QREFELT $ 135))
                                                 |mon| (QREFELT $ 127))
                                                (QREFELT $ 65)))
                                (EXIT
                                 (LETT |p|
                                       (SPADCALL
                                        (SPADCALL |lcQ|
                                                  (SPADCALL |p| (QREFELT $ 55))
                                                  (QREFELT $ 127))
                                        (SPADCALL |mon| |q| (QREFELT $ 124))
                                        (QREFELT $ 144)))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (EXIT |quot|))))))))))) 

(SDEFUN |UPOLYC-;pseudoDivide;2SR;40|
        ((|p| (S)) (|q| (S))
         ($ (|Record| (|:| |coef| R) (|:| |quotient| S) (|:| |remainder| S))))
        (SPROG
         ((|quot| (S)) (|mon| (S)) (#1=#:G966 NIL) (|i| (|NonNegativeInteger|))
          (#2=#:G965 NIL) (|delta| (|Integer|)) (|co| (R)) (#3=#:G963 NIL)
          (|lcQ| (R)) (|degQ| #4=(|NonNegativeInteger|)) (|degP| #4#)
          (|#G81| #4#) (|#G80| #4#))
         (SEQ
          (COND
           ((SPADCALL |q| (QREFELT $ 9)) (|error| "PseudoDivision by Zero"))
           ((SPADCALL |p| (QREFELT $ 9))
            (VECTOR (|spadConstant| $ 48) (|spadConstant| $ 60) |p|))
           (#5='T
            (SEQ
             (PROGN
              (LETT |#G80| (SPADCALL |p| (QREFELT $ 11)))
              (LETT |#G81| (SPADCALL |q| (QREFELT $ 11)))
              (LETT |degP| |#G80|)
              (LETT |degQ| |#G81|))
             (EXIT
              (COND
               ((< |degP| |degQ|)
                (VECTOR (|spadConstant| $ 48) (|spadConstant| $ 60) |p|))
               (#5#
                (SEQ (LETT |lcQ| (SPADCALL |q| (QREFELT $ 53)))
                     (LETT |q| (SPADCALL |q| (QREFELT $ 55)))
                     (LETT |i|
                           (PROG1 (LETT #3# (+ (- |degP| |degQ|) 1))
                             (|check_subtype2| (>= #3# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #3#)))
                     (LETT |co| (SPADCALL |lcQ| |i| (QREFELT $ 135)))
                     (LETT |quot| (|spadConstant| $ 60))
                     (SEQ G190
                          (COND
                           ((NULL
                             (>=
                              (LETT |delta|
                                    (- (SPADCALL |p| (QREFELT $ 11)) |degQ|))
                              0))
                            (GO G191)))
                          (SEQ
                           (LETT |i|
                                 (PROG1 (LETT #2# (- |i| 1))
                                   (|check_subtype2| (>= #2# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #2#)))
                           (LETT |mon|
                                 (SPADCALL (SPADCALL |p| (QREFELT $ 53))
                                           (PROG1 (LETT #1# |delta|)
                                             (|check_subtype2| (>= #1# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #1#))
                                           (QREFELT $ 49)))
                           (LETT |quot|
                                 (SPADCALL |quot|
                                           (SPADCALL
                                            (SPADCALL |lcQ| |i|
                                                      (QREFELT $ 135))
                                            |mon| (QREFELT $ 127))
                                           (QREFELT $ 65)))
                           (EXIT
                            (LETT |p|
                                  (SPADCALL
                                   (SPADCALL |lcQ|
                                             (SPADCALL |p| (QREFELT $ 55))
                                             (QREFELT $ 127))
                                   (SPADCALL |mon| |q| (QREFELT $ 124))
                                   (QREFELT $ 144)))))
                          NIL (GO G190) G191 (EXIT NIL))
                     (LETT |p|
                           (SPADCALL (SPADCALL |lcQ| |i| (QREFELT $ 135)) |p|
                                     (QREFELT $ 127)))
                     (EXIT (VECTOR |co| |quot| |p|)))))))))))) 

(SDEFUN |UPOLYC-;composite;FSU;41|
        ((|f| (|Fraction| S)) (|q| (S)) ($ (|Union| (|Fraction| S) "failed")))
        (SPROG ((|d| #1=(|Union| S "failed")) (|n| #1#))
               (SEQ
                (LETT |n|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 138)) |q|
                                (QREFELT $ 148)))
                (EXIT
                 (COND ((QEQCAR |n| 1) (CONS 1 "failed"))
                       (#2='T
                        (SEQ
                         (LETT |d|
                               (SPADCALL (SPADCALL |f| (QREFELT $ 141)) |q|
                                         (QREFELT $ 148)))
                         (EXIT
                          (COND ((QEQCAR |d| 1) (CONS 1 "failed"))
                                (#2#
                                 (CONS 0
                                       (SPADCALL (QCDR |n|) (QCDR |d|)
                                                 (QREFELT $ 149))))))))))))) 

(SDEFUN |UPOLYC-;composite;2SU;42|
        ((|p| (S)) (|q| (S)) ($ (|Union| S #1="failed")))
        (SPROG
         ((#2=#:G998 NIL) (|w| #3=(|Union| S "failed")) (|u| (|Union| S #1#))
          (|v| #3#)
          (|cqr|
           (|Record| (|:| |coef| R) (|:| |quotient| S) (|:| |remainder| S))))
         (SEQ
          (COND ((SPADCALL |p| (QREFELT $ 152)) (CONS 0 |p|))
                ('T
                 (SEQ
                  (EXIT
                   (SEQ (LETT |cqr| (SPADCALL |p| |q| (QREFELT $ 153)))
                        (COND
                         ((SPADCALL (QVELT |cqr| 2) (QREFELT $ 152))
                          (SEQ
                           (LETT |v|
                                 (SPADCALL (QVELT |cqr| 2) (QVELT |cqr| 0)
                                           (QREFELT $ 154)))
                           (EXIT
                            (COND
                             ((QEQCAR |v| 0)
                              (SEQ
                               (LETT |u|
                                     (SPADCALL (QVELT |cqr| 1) |q|
                                               (QREFELT $ 148)))
                               (EXIT
                                (COND
                                 ((QEQCAR |u| 0)
                                  (SEQ
                                   (LETT |w|
                                         (SPADCALL (QCDR |u|) (QVELT |cqr| 0)
                                                   (QREFELT $ 154)))
                                   (EXIT
                                    (COND
                                     ((QEQCAR |w| 0)
                                      (PROGN
                                       (LETT #2#
                                             (CONS 0
                                                   (SPADCALL (QCDR |v|)
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (|spadConstant|
                                                                $ 48)
                                                               1
                                                               (QREFELT $ 49))
                                                              (QCDR |w|)
                                                              (QREFELT $ 124))
                                                             (QREFELT $ 65))))
                                       (GO #4=#:G995))))))))))))))))
                        (EXIT (CONS 1 "failed"))))
                  #4# (EXIT #2#))))))) 

(SDEFUN |UPOLYC-;elt;S2F;43|
        ((|p| (S)) (|f| (|Fraction| S)) ($ (|Fraction| S)))
        (SPROG
         ((|ans| (|Fraction| S)) (#1=#:G1004 NIL) (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND ((SPADCALL |p| (QREFELT $ 9)) (|spadConstant| $ 156))
                (#2='T
                 (SEQ
                  (LETT |ans|
                        (SPADCALL
                         (SPADCALL (SPADCALL |p| (QREFELT $ 53))
                                   (QREFELT $ 30))
                         (QREFELT $ 157)))
                  (LETT |n| (SPADCALL |p| (QREFELT $ 11)))
                  (SEQ G190
                       (COND
                        ((NULL
                          (NULL
                           (SPADCALL (LETT |p| (SPADCALL |p| (QREFELT $ 55)))
                                     (QREFELT $ 9))))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |ans|
                               (SPADCALL
                                (SPADCALL |ans|
                                          (SPADCALL |f|
                                                    (PROG1
                                                        (LETT #1#
                                                              (- |n|
                                                                 (LETT |n|
                                                                       (SPADCALL
                                                                        |p|
                                                                        (QREFELT
                                                                         $
                                                                         11)))))
                                                      (|check_subtype2|
                                                       (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#))
                                                    (QREFELT $ 158))
                                          (QREFELT $ 159))
                                (SPADCALL
                                 (SPADCALL (SPADCALL |p| (QREFELT $ 53))
                                           (QREFELT $ 30))
                                 (QREFELT $ 157))
                                (QREFELT $ 160)))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (COND ((ZEROP |n|) |ans|)
                         (#2#
                          (SPADCALL |ans| (SPADCALL |f| |n| (QREFELT $ 161))
                                    (QREFELT $ 159))))))))))) 

(SDEFUN |UPOLYC-;order;2SNni;44|
        ((|p| (S)) (|q| (S)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|ans| (|NonNegativeInteger|)) (#1=#:G1020 NIL)
          (|u| (|Union| S "failed")))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |p| (QREFELT $ 9))
             (|error| "order: arguments must be nonzero"))
            ((< (SPADCALL |q| (QREFELT $ 11)) 1)
             (|error| "order: place must be non-trivial"))
            ('T
             (SEQ (LETT |ans| 0)
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ (LETT |u| (SPADCALL |p| |q| (QREFELT $ 119)))
                             (EXIT
                              (COND
                               ((QEQCAR |u| 1)
                                (PROGN (LETT #1# |ans|) (GO #2=#:G1019)))
                               ('T
                                (SEQ (LETT |p| (QCDR |u|))
                                     (EXIT (LETT |ans| (+ |ans| 1))))))))
                        NIL (GO G190) G191 (EXIT NIL)))))))
          #2# (EXIT #1#)))) 

(SDEFUN |UPOLYC-;squareFree;SF;45| ((|p| (S)) ($ (|Factored| S)))
        (SPADCALL |p| (QREFELT $ 165))) 

(SDEFUN |UPOLYC-;squareFreePart;2S;46| ((|p| (S)) ($ (S)))
        (SPADCALL |p| (QREFELT $ 167))) 

(SDEFUN |UPOLYC-;gcdPolynomial;3Sup;47|
        ((|pp| (|SparseUnivariatePolynomial| S))
         (|qq| (|SparseUnivariatePolynomial| S))
         ($ (|SparseUnivariatePolynomial| S)))
        (COND ((SPADCALL |pp| (QREFELT $ 169)) (SPADCALL |qq| (QREFELT $ 170)))
              ((SPADCALL |qq| (QREFELT $ 169)) (SPADCALL |pp| (QREFELT $ 170)))
              ('T
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL |pp| (QREFELT $ 171))
                           (SPADCALL |qq| (QREFELT $ 171)) (QREFELT $ 118))
                 (SPADCALL
                  (SPADCALL (SPADCALL |pp| (QREFELT $ 172))
                            (SPADCALL |qq| (QREFELT $ 172)) (QREFELT $ 173))
                  (QREFELT $ 172))
                 (QREFELT $ 174))
                (QREFELT $ 170))))) 

(SDEFUN |UPOLYC-;squareFreePolynomial;SupF;48|
        ((|pp| (|SparseUnivariatePolynomial| S))
         ($ (|Factored| (|SparseUnivariatePolynomial| S))))
        (SPADCALL |pp| (QREFELT $ 177))) 

(SDEFUN |UPOLYC-;elt;F2R;49| ((|f| (|Fraction| S)) (|r| (R)) ($ (R)))
        (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 138)) |r| (QREFELT $ 29))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 141)) |r| (QREFELT $ 29))
                  (QREFELT $ 179))) 

(SDEFUN |UPOLYC-;euclideanSize;SNni;50| ((|x| (S)) ($ (|NonNegativeInteger|)))
        (COND
         ((SPADCALL |x| (QREFELT $ 9))
          (|error| "euclideanSize called on 0 in Univariate Polynomial"))
         ('T (SPADCALL |x| (QREFELT $ 11))))) 

(SDEFUN |UPOLYC-;divide;2SR;51|
        ((|x| (S)) (|y| (S))
         ($ (|Record| (|:| |quotient| S) (|:| |remainder| S))))
        (SPROG
         ((|quot| (S)) (|n| (|NonNegativeInteger|)) (#1=#:G1045 NIL) (|f| (R))
          (|lc| (R)))
         (SEQ
          (COND
           ((SPADCALL |y| (QREFELT $ 9))
            (|error| "division by 0 in Univariate Polynomials"))
           ('T
            (SEQ (LETT |quot| (|spadConstant| $ 60))
                 (LETT |lc|
                       (SPADCALL (SPADCALL |y| (QREFELT $ 53))
                                 (QREFELT $ 182)))
                 (SEQ G190
                      (COND
                       ((NULL
                         (COND ((SPADCALL |x| (QREFELT $ 9)) NIL)
                               ('T
                                (>= (SPADCALL |x| (QREFELT $ 11))
                                    (SPADCALL |y| (QREFELT $ 11))))))
                        (GO G191)))
                      (SEQ
                       (LETT |f|
                             (SPADCALL |lc| (SPADCALL |x| (QREFELT $ 53))
                                       (QREFELT $ 183)))
                       (LETT |n|
                             (PROG1
                                 (LETT #1#
                                       (- (SPADCALL |x| (QREFELT $ 11))
                                          (SPADCALL |y| (QREFELT $ 11))))
                               (|check_subtype2| (>= #1# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #1#)))
                       (LETT |quot|
                             (SPADCALL |quot| (SPADCALL |f| |n| (QREFELT $ 49))
                                       (QREFELT $ 65)))
                       (EXIT
                        (LETT |x|
                              (SPADCALL |x|
                                        (SPADCALL
                                         (SPADCALL |f| |n| (QREFELT $ 49)) |y|
                                         (QREFELT $ 124))
                                        (QREFELT $ 144)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT (CONS |quot| |x|)))))))) 

(SDEFUN |UPOLYC-;integrate;2S;52| ((|p| (S)) ($ (S)))
        (SPROG ((|ans| (S)) (|d| (|NonNegativeInteger|)) (|l| (R)))
               (SEQ (LETT |ans| (|spadConstant| $ 60))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p| (|spadConstant| $ 60)
                                      (QREFELT $ 186)))
                           (GO G191)))
                         (SEQ (LETT |l| (SPADCALL |p| (QREFELT $ 53)))
                              (LETT |d| (+ 1 (SPADCALL |p| (QREFELT $ 11))))
                              (LETT |ans|
                                    (SPADCALL |ans|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL |d| (QREFELT $ 188))
                                                (QREFELT $ 189))
                                               (SPADCALL |l| |d|
                                                         (QREFELT $ 49))
                                               (QREFELT $ 190))
                                              (QREFELT $ 65)))
                              (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 55)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(DECLAIM (NOTINLINE |UnivariatePolynomialCategory&;|)) 

(DEFUN |UnivariatePolynomialCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|UnivariatePolynomialCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 198))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#2| '(|Field|))
                                              (|HasCategory| |#2|
                                                             '(|GcdDomain|))
                                              (|HasCategory| |#2|
                                                             '(|IntegralDomain|))
                                              (|HasCategory| |#2|
                                                             '(|CommutativeRing|))
                                              (|HasCategory| |#2|
                                                             '(|StepThrough|))
                                              (|HasCategory| |#2|
                                                             '(|Ring|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#2| '(|SemiRing|))
            (QSETREFV $ 50
                      (CONS (|dispatchFunction| |UPOLYC-;coerce;SaosS;14|)
                            $))))
          (COND
           ((|HasCategory| |#2| '(|PolynomialFactorizationExplicit|))
            (PROGN
             (QSETREFV $ 75
                       (CONS
                        (|dispatchFunction|
                         |UPOLYC-;solveLinearPolynomialEquation;LSupU;17|)
                        $))
             (QSETREFV $ 79
                       (CONS
                        (|dispatchFunction| |UPOLYC-;factorPolynomial;SupF;18|)
                        $))
             (QSETREFV $ 81
                       (CONS
                        (|dispatchFunction|
                         |UPOLYC-;factorSquareFreePolynomial;SupF;19|)
                        $))
             (QSETREFV $ 99
                       (CONS (|dispatchFunction| |UPOLYC-;factor;SF;20|) $)))))
          (COND
           ((|testBitVector| |pv$| 6)
            (PROGN
             (QSETREFV $ 112 (CONS (|dispatchFunction| |UPOLYC-;init;S;25|) $))
             NIL
             (QSETREFV $ 115
                       (CONS (|dispatchFunction| |UPOLYC-;nextItem;SU;27|)
                             $)))))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 117
                       (CONS (|dispatchFunction| |UPOLYC-;content;SSaosS;28|)
                             $))
             NIL
             (QSETREFV $ 122
                       (CONS (|dispatchFunction| |UPOLYC-;separate;2SR;30|)
                             $)))))
          (COND
           ((|testBitVector| |pv$| 5)
            (QSETREFV $ 126
                      (CONS
                       (|dispatchFunction| |UPOLYC-;differentiate;SM2S;31|)
                       $)))
           ((|testBitVector| |pv$| 7)
            (PROGN
             (QSETREFV $ 126
                       (CONS
                        (|dispatchFunction| |UPOLYC-;differentiate;SM2S;33|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 7)
            (PROGN
             (QSETREFV $ 129
                       (CONS
                        (|dispatchFunction| |UPOLYC-;differentiate;SMS;34|) $))
             (QSETREFV $ 130
                       (CONS (|dispatchFunction| |UPOLYC-;differentiate;2S;35|)
                             $))
             (QSETREFV $ 132
                       (CONS
                        (|dispatchFunction| |UPOLYC-;differentiate;SSaosS;36|)
                        $))
             (QSETREFV $ 136
                       (CONS
                        (|dispatchFunction| |UPOLYC-;pseudoRemainder;3S;37|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 143 (CONS (|dispatchFunction| |UPOLYC-;elt;3F;38|) $))
             (QSETREFV $ 145
                       (CONS
                        (|dispatchFunction| |UPOLYC-;pseudoQuotient;3S;39|) $))
             (QSETREFV $ 147
                       (CONS (|dispatchFunction| |UPOLYC-;pseudoDivide;2SR;40|)
                             $))
             (QSETREFV $ 151
                       (CONS (|dispatchFunction| |UPOLYC-;composite;FSU;41|)
                             $))
             (QSETREFV $ 155
                       (CONS (|dispatchFunction| |UPOLYC-;composite;2SU;42|)
                             $))
             (QSETREFV $ 162
                       (CONS (|dispatchFunction| |UPOLYC-;elt;S2F;43|) $))
             (QSETREFV $ 163
                       (CONS (|dispatchFunction| |UPOLYC-;order;2SNni;44|)
                             $)))))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 166
                       (CONS (|dispatchFunction| |UPOLYC-;squareFree;SF;45|)
                             $))
             (QSETREFV $ 168
                       (CONS
                        (|dispatchFunction| |UPOLYC-;squareFreePart;2S;46|)
                        $)))))
          (COND
           ((|HasCategory| |#2| '(|PolynomialFactorizationExplicit|))
            (PROGN
             (QSETREFV $ 175
                       (CONS
                        (|dispatchFunction| |UPOLYC-;gcdPolynomial;3Sup;47|)
                        $))
             (QSETREFV $ 178
                       (CONS
                        (|dispatchFunction|
                         |UPOLYC-;squareFreePolynomial;SupF;48|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 180
                       (CONS (|dispatchFunction| |UPOLYC-;elt;F2R;49|) $))
             (QSETREFV $ 181
                       (CONS
                        (|dispatchFunction| |UPOLYC-;euclideanSize;SNni;50|)
                        $))
             (QSETREFV $ 185
                       (CONS (|dispatchFunction| |UPOLYC-;divide;2SR;51|)
                             $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 191
                      (CONS (|dispatchFunction| |UPOLYC-;integrate;2S;52|)
                            $))))
          $))) 

(MAKEPROP '|UnivariatePolynomialCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (0 . |zero?|) (|NonNegativeInteger|) (5 . |degree|)
              (|SingletonAsOrderedSet|) (10 . |create|) (|List| 12)
              |UPOLYC-;variables;SL;1| |UPOLYC-;degree;SSaosNni;2|
              (14 . |totalDegree|) |UPOLYC-;totalDegree;SLNni;3| (|List| 10)
              |UPOLYC-;degree;SLL;4| (19 . |eval|) (|List| $)
              |UPOLYC-;eval;SLLS;5| (26 . |elt|) |UPOLYC-;eval;SSaos2S;6|
              (32 . |eval|) (|List| 7) |UPOLYC-;eval;SLLS;7| (39 . |elt|)
              (45 . |coerce|) |UPOLYC-;eval;SSaosRS;8| (|Equation| 6)
              (50 . |lhs|) (|Union| 12 '#1="failed") (55 . |mainVariable|)
              (60 . |rhs|) (|List| 194) |UPOLYC-;eval;SLS;9|
              |UPOLYC-;mainVariable;SU;10| (65 . |minimumDegree|)
              |UPOLYC-;minimumDegree;SSaosNni;11|
              |UPOLYC-;minimumDegree;SLL;12| (70 . +) (|Mapping| 10 10)
              (76 . |mapExponents|) |UPOLYC-;monomial;SSaosNniS;13|
              (82 . |One|) (86 . |One|) (90 . |monomial|) (96 . |coerce|)
              (|SparseUnivariatePolynomial| 7) (101 . |Zero|)
              (105 . |leadingCoefficient|) (110 . |monomial|)
              (116 . |reductum|) (121 . |makeSUP|) (126 . +)
              |UPOLYC-;makeSUP;SSup;15| (132 . |zero?|) (137 . |Zero|)
              (141 . |leadingCoefficient|) (146 . |degree|) (151 . |reductum|)
              (156 . |unmakeSUP|) (161 . +) |UPOLYC-;unmakeSUP;SupS;16|
              (|Union| 68 '"failed") (|List| 69)
              (|SparseUnivariatePolynomial| 6)
              (|PolynomialFactorizationByRecursion| 7 10 12 6)
              (167 . |solveLinearPolynomialEquationByRecursion|)
              (|Union| 73 '#2="failed") (|List| 74)
              (|SparseUnivariatePolynomial| $)
              (173 . |solveLinearPolynomialEquation|) (|Factored| 69)
              (179 . |factorByRecursion|) (|Factored| 74)
              (184 . |factorPolynomial|) (189 . |factorSquareFreeByRecursion|)
              (194 . |factorSquareFreePolynomial|) (|Factored| $)
              (199 . |factor|) (|Factored| 7) (204 . |unit|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 86) (|:| |factor| 7) (|:| |exponent| 10))
              (|List| 87) (209 . |factorList|)
              (|Record| (|:| |flag| 86) (|:| |factor| 6) (|:| |exponent| 10))
              (|List| 90) (|Factored| 6) (214 . |makeFR|)
              (220 . |factorPolynomial|) (|Mapping| 6 51) (|Factored| 51)
              (|FactoredFunctions2| 51 6) (225 . |map_preserving|)
              (231 . |factor|) (236 . |Zero|) (|Integer|) (|Vector| 7)
              (240 . |minIndex|) (245 . |coefficient|)
              |UPOLYC-;vectorise;SNniV;21| (251 . |elt|)
              |UPOLYC-;unvectorise;VS;22| |UPOLYC-;retract;SR;23|
              (|Union| 7 '"failed") |UPOLYC-;retractIfCan;SU;24| (257 . |init|)
              (261 . |init|) (|Union| $ '#3="failed") (265 . |nextItem|)
              (270 . |nextItem|) (275 . |content|) (280 . |content|)
              (286 . |gcd|) (292 . |exquo|) (298 . =)
              (|Record| (|:| |primePart| $) (|:| |commonPart| $))
              (304 . |separate|) (310 . *) (316 . *) (|Mapping| 7 7)
              (322 . |differentiate|) (329 . *) (335 . |differentiate|)
              (342 . |differentiate|) (348 . |differentiate|)
              (353 . |differentiate|) (358 . |differentiate|)
              (364 . |subtractIfCan|) (370 . |fmecg|) (378 . ^)
              (384 . |pseudoRemainder|) (|Fraction| 6) (390 . |numer|)
              (|Fraction| $) (395 . |elt|) (401 . |denom|) (406 . /)
              (412 . |elt|) (418 . -) (424 . |pseudoQuotient|)
              (|Record| (|:| |coef| 7) (|:| |quotient| $) (|:| |remainder| $))
              (430 . |pseudoDivide|) (436 . |composite|) (442 . /)
              (|Union| 139 '#4="failed") (448 . |composite|) (454 . |ground?|)
              (459 . |pseudoDivide|) (465 . |exquo|) (471 . |composite|)
              (477 . |Zero|) (481 . |coerce|) (486 . ^) (492 . *) (498 . +)
              (504 . ^) (510 . |elt|) (516 . |order|)
              (|UnivariatePolynomialSquareFree| 7 6) (522 . |squareFree|)
              (527 . |squareFree|) (532 . |squareFreePart|)
              (537 . |squareFreePart|) (542 . |zero?|) (547 . |unitCanonical|)
              (552 . |content|) (557 . |primitivePart|)
              (562 . |subResultantGcd|) (568 . *) (574 . |gcdPolynomial|)
              (|UnivariatePolynomialSquareFree| 6 69) (580 . |squareFree|)
              (585 . |squareFreePolynomial|) (590 . /) (596 . |elt|)
              (602 . |euclideanSize|) (607 . |inv|) (612 . *)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (618 . |divide|) (624 . ~=) (|Fraction| 101) (630 . |coerce|)
              (635 . |inv|) (640 . *) (646 . |integrate|) (|List| 193)
              (|Symbol|) (|Equation| $) (|Union| 187 '#5="failed")
              (|Union| 101 '#5#) (|OutputForm|))
           '#(|vectorise| 651 |variables| 657 |unvectorise| 662 |unmakeSUP| 667
              |totalDegree| 672 |squareFreePolynomial| 678 |squareFreePart| 683
              |squareFree| 688 |solveLinearPolynomialEquation| 693 |separate|
              699 |retractIfCan| 705 |retract| 710 |pseudoRemainder| 715
              |pseudoQuotient| 721 |pseudoDivide| 727 |order| 733 |nextItem|
              739 |monomial| 744 |minimumDegree| 751 |makeSUP| 763
              |mainVariable| 768 |integrate| 773 |init| 778 |gcdPolynomial| 782
              |factorSquareFreePolynomial| 788 |factorPolynomial| 793 |factor|
              798 |eval| 803 |euclideanSize| 837 |elt| 842 |divide| 860
              |differentiate| 866 |degree| 890 |content| 902 |composite| 908
              |coerce| 920)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|coerce| (|#1| (|Integer|))) T)
                                   '((|differentiate| (|#1| |#1|)) T)
                                   '((|differentiate|
                                      (|#1| |#1| (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Mapping| |#2| |#2|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Mapping| |#2| |#2|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Symbol|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))))
                                     T)
                                   '((|differentiate| (|#1| |#1| (|Symbol|)))
                                     T)
                                   '((|init| (|#1|)) T)
                                   '((|nextItem| ((|Union| |#1| #3#) |#1|)) T)
                                   '((|elt|
                                      ((|Fraction| |#1|) |#1|
                                       (|Fraction| |#1|)))
                                     T)
                                   '((|coerce| (|#1| |#1|)) T)
                                   '((|gcdPolynomial|
                                      ((|SparseUnivariatePolynomial| |#1|)
                                       (|SparseUnivariatePolynomial| |#1|)
                                       (|SparseUnivariatePolynomial| |#1|)))
                                     T)
                                   '((|euclideanSize|
                                      ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((|divide|
                                      ((|Record| (|:| |quotient| |#1|)
                                                 (|:| |remainder| |#1|))
                                       |#1| |#1|))
                                     T)
                                   '((|integrate| (|#1| |#1|)) T)
                                   '((|elt| (|#2| (|Fraction| |#1|) |#2|)) T)
                                   '((|separate|
                                      ((|Record| (|:| |primePart| |#1|)
                                                 (|:| |commonPart| |#1|))
                                       |#1| |#1|))
                                     T)
                                   '((|pseudoDivide|
                                      ((|Record| (|:| |coef| |#2|)
                                                 (|:| |quotient| |#1|)
                                                 (|:| |remainder| |#1|))
                                       |#1| |#1|))
                                     T)
                                   '((|pseudoQuotient| (|#1| |#1| |#1|)) T)
                                   '((|composite|
                                      ((|Union| (|Fraction| |#1|) #4#)
                                       (|Fraction| |#1|) |#1|))
                                     T)
                                   '((|composite|
                                      ((|Union| |#1| "failed") |#1| |#1|))
                                     T)
                                   '((|order|
                                      ((|NonNegativeInteger|) |#1| |#1|))
                                     T)
                                   '((|elt|
                                      ((|Fraction| |#1|) (|Fraction| |#1|)
                                       (|Fraction| |#1|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|pseudoRemainder| (|#1| |#1| |#1|)) T)
                                   '((|unmakeSUP|
                                      (|#1|
                                       (|SparseUnivariatePolynomial| |#2|)))
                                     T)
                                   '((|makeSUP|
                                      ((|SparseUnivariatePolynomial| |#2|)
                                       |#1|))
                                     T)
                                   '((|unvectorise| (|#1| (|Vector| |#2|))) T)
                                   '((|vectorise|
                                      ((|Vector| |#2|) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|elt| (|#1| |#1| |#1|)) T)
                                   '((|elt| (|#2| |#1| |#2|)) T)
                                   '((|coerce|
                                      (|#1| (|SingletonAsOrderedSet|)))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union| (|SingletonAsOrderedSet|) #5#)
                                       |#1|))
                                     T)
                                   '((|retract|
                                      ((|SingletonAsOrderedSet|) |#1|))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|List| |#1|) (|List| |#1|)))
                                     T)
                                   '((|eval| (|#1| |#1| |#1| |#1|)) T)
                                   '((|eval| (|#1| |#1| (|Equation| |#1|))) T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|Equation| |#1|))))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|SingletonAsOrderedSet|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1|
                                       (|List| (|SingletonAsOrderedSet|))))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|SingletonAsOrderedSet|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1|
                                       (|List| (|SingletonAsOrderedSet|))
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|squareFree| ((|Factored| |#1|) |#1|)) T)
                                   '((|squareFreePart| (|#1| |#1|)) T)
                                   '((|factor| ((|Factored| |#1|) |#1|)) T)
                                   '((|squareFreePolynomial|
                                      ((|Factored|
                                        (|SparseUnivariatePolynomial| |#1|))
                                       (|SparseUnivariatePolynomial| |#1|)))
                                     T)
                                   '((|factorPolynomial|
                                      ((|Factored|
                                        (|SparseUnivariatePolynomial| |#1|))
                                       (|SparseUnivariatePolynomial| |#1|)))
                                     T)
                                   '((|factorSquareFreePolynomial|
                                      ((|Factored|
                                        (|SparseUnivariatePolynomial| |#1|))
                                       (|SparseUnivariatePolynomial| |#1|)))
                                     T)
                                   '((|solveLinearPolynomialEquation|
                                      ((|Union|
                                        (|List|
                                         (|SparseUnivariatePolynomial| |#1|))
                                        #2#)
                                       (|List|
                                        (|SparseUnivariatePolynomial| |#1|))
                                       (|SparseUnivariatePolynomial| |#1|)))
                                     T)
                                   '((|content|
                                      (|#1| |#1| (|SingletonAsOrderedSet|)))
                                     T)
                                   '((|minimumDegree|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|List| (|SingletonAsOrderedSet|))))
                                     T)
                                   '((|minimumDegree|
                                      ((|NonNegativeInteger|) |#1|
                                       (|SingletonAsOrderedSet|)))
                                     T)
                                   '((|eval|
                                      (|#1| |#1|
                                       (|List| (|SingletonAsOrderedSet|))
                                       (|List| |#1|)))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|SingletonAsOrderedSet|)
                                       |#1|))
                                     T)
                                   '((|eval|
                                      (|#1| |#1|
                                       (|List| (|SingletonAsOrderedSet|))
                                       (|List| |#2|)))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|SingletonAsOrderedSet|)
                                       |#2|))
                                     T)
                                   '((|variables|
                                      ((|List| (|SingletonAsOrderedSet|))
                                       |#1|))
                                     T)
                                   '((|totalDegree|
                                      ((|NonNegativeInteger|) |#1|
                                       (|List| (|SingletonAsOrderedSet|))))
                                     T)
                                   '((|totalDegree|
                                      ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((|monomial|
                                      (|#1| |#1|
                                       (|List| (|SingletonAsOrderedSet|))
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|monomial|
                                      (|#1| |#1| (|SingletonAsOrderedSet|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|mainVariable|
                                      ((|Union| (|SingletonAsOrderedSet|) #1#)
                                       |#1|))
                                     T)
                                   '((|degree|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|List| (|SingletonAsOrderedSet|))))
                                     T)
                                   '((|degree|
                                      ((|NonNegativeInteger|) |#1|
                                       (|SingletonAsOrderedSet|)))
                                     T)
                                   '((|content| (|#2| |#1|)) T)
                                   '((|minimumDegree|
                                      ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((|coerce| (|#1| |#2|)) T)
                                   '((|retractIfCan| ((|Union| |#2| #5#) |#1|))
                                     T)
                                   '((|retract| (|#2| |#1|)) T)
                                   '((|retract|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #5#)
                                       |#1|))
                                     T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) #5#) |#1|))
                                     T)
                                   '((|degree| ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((|monomial|
                                      (|#1| |#2| (|NonNegativeInteger|)))
                                     T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 191
                                            '(1 6 8 0 9 1 6 10 0 11 0 12 0 13 1
                                              6 10 0 17 3 6 0 0 12 0 21 2 6 0 0
                                              0 24 3 6 0 0 12 7 26 2 6 7 0 7 29
                                              1 6 0 7 30 1 32 6 0 33 1 6 34 0
                                              35 1 32 6 0 36 1 6 10 0 40 2 10 0
                                              0 0 43 2 6 0 44 0 45 0 6 0 47 0 7
                                              0 48 2 6 0 7 10 49 1 0 0 12 50 0
                                              51 0 52 1 6 7 0 53 2 51 0 7 10 54
                                              1 6 0 0 55 1 6 51 0 56 2 51 0 0 0
                                              57 1 51 8 0 59 0 6 0 60 1 51 7 0
                                              61 1 51 10 0 62 1 51 0 0 63 1 6 0
                                              51 64 2 6 0 0 0 65 2 70 67 68 69
                                              71 2 0 72 73 74 75 1 70 76 69 77
                                              1 0 78 74 79 1 70 76 69 80 1 0 78
                                              74 81 1 7 82 0 83 1 84 7 0 85 1
                                              84 88 0 89 2 92 0 6 91 93 1 7 78
                                              74 94 2 97 92 95 96 98 1 0 82 0
                                              99 0 7 0 100 1 102 101 0 103 2 6
                                              7 0 10 104 2 102 7 0 101 106 0 7
                                              0 111 0 0 0 112 1 7 113 0 114 1 0
                                              113 0 115 1 6 7 0 116 2 0 0 0 12
                                              117 2 6 0 0 0 118 2 6 113 0 0 119
                                              2 6 8 0 0 120 2 0 121 0 0 122 2 7
                                              0 10 0 123 2 6 0 0 0 124 3 0 0 0
                                              125 0 126 2 6 0 7 0 127 3 6 0 0
                                              125 0 128 2 0 0 0 125 129 1 0 0 0
                                              130 1 6 0 0 131 2 0 0 0 12 132 2
                                              10 113 0 0 133 4 6 0 0 10 7 0 134
                                              2 7 0 0 10 135 2 0 0 0 0 136 1
                                              137 6 0 138 2 6 139 0 139 140 1
                                              137 6 0 141 2 137 0 0 0 142 2 0
                                              139 139 139 143 2 6 0 0 0 144 2 0
                                              0 0 0 145 2 0 146 0 0 147 2 6 113
                                              0 0 148 2 137 0 6 6 149 2 0 150
                                              139 0 151 1 6 8 0 152 2 6 146 0 0
                                              153 2 6 113 0 7 154 2 0 113 0 0
                                              155 0 137 0 156 1 137 0 6 157 2
                                              137 0 0 101 158 2 137 0 0 0 159 2
                                              137 0 0 0 160 2 137 0 0 10 161 2
                                              0 139 0 139 162 2 0 10 0 0 163 1
                                              164 92 6 165 1 0 82 0 166 1 164 6
                                              6 167 1 0 0 0 168 1 69 8 0 169 1
                                              69 0 0 170 1 69 6 0 171 1 69 0 0
                                              172 2 69 0 0 0 173 2 69 0 6 0 174
                                              2 0 74 74 74 175 1 176 76 69 177
                                              1 0 78 74 178 2 7 0 0 0 179 2 0 7
                                              139 7 180 1 0 10 0 181 1 7 0 0
                                              182 2 7 0 0 0 183 2 0 184 0 0 185
                                              2 6 8 0 0 186 1 187 0 101 188 1
                                              187 0 0 189 2 6 0 187 0 190 1 0 0
                                              0 191 2 0 102 0 10 105 1 0 14 0
                                              15 1 0 0 102 107 1 0 0 51 66 2 0
                                              10 0 14 18 1 0 78 74 178 1 0 0 0
                                              168 1 0 82 0 166 2 0 72 73 74 75
                                              2 0 121 0 0 122 1 0 109 0 110 1 0
                                              7 0 108 2 0 0 0 0 136 2 0 0 0 0
                                              145 2 0 146 0 0 147 2 0 10 0 0
                                              163 1 0 113 0 115 3 0 0 0 12 10
                                              46 2 0 10 0 12 41 2 0 19 0 14 42
                                              1 0 51 0 58 1 0 34 0 39 1 0 0 0
                                              191 0 0 0 112 2 0 74 74 74 175 1
                                              0 78 74 81 1 0 78 74 79 1 0 82 0
                                              99 2 0 0 0 37 38 3 0 0 0 12 0 25
                                              3 0 0 0 14 22 23 3 0 0 0 14 27 28
                                              3 0 0 0 12 7 31 1 0 10 0 181 2 0
                                              139 0 139 162 2 0 7 139 7 180 2 0
                                              139 139 139 143 2 0 184 0 0 185 1
                                              0 0 0 130 2 0 0 0 125 129 3 0 0 0
                                              125 0 126 2 0 0 0 12 132 2 0 10 0
                                              12 16 2 0 19 0 14 20 2 0 0 0 12
                                              117 2 0 150 139 0 151 2 0 113 0 0
                                              155 1 0 0 12 50)))))
           '|lookupComplete|)) 

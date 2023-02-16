
(SDEFUN |XPFACT;my_degree|
        ((|p| (|XDistributedPolynomial| |vl| F)) ($ (|Integer|)))
        (COND ((SPADCALL |p| (|spadConstant| $ 10) (QREFELT $ 12)) -1)
              ('T (SPADCALL |p| (QREFELT $ 15))))) 

(SDEFUN |XPFACT;top_split;XdpL;2|
        ((|p| (|XDistributedPolynomial| |vl| F))
         ($ (|List| (|XDistributedPolynomial| |vl| F))))
        (SPROG
         ((|p2| #1=(|XDistributedPolynomial| |vl| F)) (|p1| #1#)
          (|lt2|
           (|List| #2=(|Record| (|:| |k| (|FreeMonoid| |vl|)) (|:| |c| F))))
          (#3=#:G742 NIL) (|r| NIL) (#4=#:G741 NIL) (|lt1| (|List| #2#))
          (#5=#:G740 NIL) (#6=#:G739 NIL) (|lt| (|List| #2#))
          (|d| (|NonNegativeInteger|)))
         (SEQ (LETT |d| (SPADCALL |p| (QREFELT $ 15)))
              (EXIT
               (COND ((EQL |d| 0) (LIST |p| (|spadConstant| $ 10)))
                     ('T
                      (SEQ (LETT |lt| (SPADCALL |p| (QREFELT $ 18)))
                           (LETT |lt1|
                                 (PROGN
                                  (LETT #6# NIL)
                                  (SEQ (LETT |r| NIL) (LETT #5# |lt|) G190
                                       (COND
                                        ((OR (ATOM #5#)
                                             (PROGN (LETT |r| (CAR #5#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (COND
                                          ((EQL
                                            (SPADCALL (QCAR |r|)
                                                      (QREFELT $ 20))
                                            |d|)
                                           (LETT #6# (CONS |r| #6#))))))
                                       (LETT #5# (CDR #5#)) (GO G190) G191
                                       (EXIT (NREVERSE #6#)))))
                           (LETT |lt2|
                                 (PROGN
                                  (LETT #4# NIL)
                                  (SEQ (LETT |r| NIL) (LETT #3# |lt|) G190
                                       (COND
                                        ((OR (ATOM #3#)
                                             (PROGN (LETT |r| (CAR #3#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (COND
                                          ((<
                                            (SPADCALL (QCAR |r|)
                                                      (QREFELT $ 20))
                                            |d|)
                                           (LETT #4# (CONS |r| #4#))))))
                                       (LETT #3# (CDR #3#)) (GO G190) G191
                                       (EXIT (NREVERSE #4#)))))
                           (LETT |p1| (SPADCALL |lt1| (QREFELT $ 21)))
                           (LETT |p2| (SPADCALL |lt2| (QREFELT $ 21)))
                           (EXIT (LIST |p1| |p2|))))))))) 

(SDEFUN |XPFACT;ldivide;2XdpR;3|
        ((|x| (|XDistributedPolynomial| |vl| F))
         (|y| (|XDistributedPolynomial| |vl| F))
         ($
          (|Record| (|:| |quotient| (|XDistributedPolynomial| |vl| F))
                    (|:| |remainder| (|XDistributedPolynomial| |vl| F)))))
        (SPROG
         ((|dx| #1=(|Integer|)) (#2=#:G755 NIL) (|ndx| #1#)
          (|qq| (|XDistributedPolynomial| |vl| F))
          (|q1| (|XDistributedPolynomial| |vl| F))
          (|tx| (|List| (|XDistributedPolynomial| |vl| F)))
          (|dy| (|NonNegativeInteger|)) (|ilc| (F)) (|w| (|FreeMonoid| |vl|)))
         (SEQ
          (EXIT
           (SEQ (LETT |w| (SPADCALL |y| (QREFELT $ 24)))
                (LETT |ilc|
                      (SPADCALL (|spadConstant| $ 13)
                                (SPADCALL |y| (QREFELT $ 25)) (QREFELT $ 26)))
                (LETT |dy| (SPADCALL |y| (QREFELT $ 15)))
                (LETT |dx| (|XPFACT;my_degree| |x| $))
                (EXIT
                 (COND ((< |dx| |dy|) (CONS (|spadConstant| $ 10) |x|))
                       ('T
                        (SEQ (LETT |qq| (|spadConstant| $ 10))
                             (EXIT
                              (SEQ G190 NIL
                                   (SEQ
                                    (LETT |tx| (SPADCALL |x| (QREFELT $ 23)))
                                    (LETT |q1|
                                          (SPADCALL |ilc|
                                                    (SPADCALL
                                                     (|SPADfirst| |tx|) |w|
                                                     (QREFELT $ 27))
                                                    (QREFELT $ 28)))
                                    (LETT |x|
                                          (SPADCALL |x|
                                                    (SPADCALL |y| |q1|
                                                              (QREFELT $ 29))
                                                    (QREFELT $ 30)))
                                    (LETT |qq|
                                          (SPADCALL |qq| |q1| (QREFELT $ 31)))
                                    (LETT |ndx| (|XPFACT;my_degree| |x| $))
                                    (COND
                                     ((OR (EQL |ndx| |dx|) (< |ndx| |dy|))
                                      (EXIT
                                       (PROGN
                                        (LETT #2# (CONS |qq| |x|))
                                        (GO #3=#:G754)))))
                                    (EXIT (LETT |dx| |ndx|)))
                                   NIL (GO G190) G191 (EXIT NIL)))))))))
          #3# (EXIT #2#)))) 

(SDEFUN |XPFACT;lexquo|
        ((|x| (|XDistributedPolynomial| |vl| F))
         (|y| (|XDistributedPolynomial| |vl| F))
         ($ (|Union| (|XDistributedPolynomial| |vl| F) "failed")))
        (SPROG
         ((|r| #1=(|XDistributedPolynomial| |vl| F))
          (|q| #2=(|XDistributedPolynomial| |vl| F))
          (|#G12| (|Record| (|:| |quotient| #2#) (|:| |remainder| #1#))))
         (SEQ
          (PROGN
           (LETT |#G12| (SPADCALL |x| |y| (QREFELT $ 33)))
           (LETT |q| (QCAR |#G12|))
           (LETT |r| (QCDR |#G12|))
           |#G12|)
          (EXIT
           (COND
            ((SPADCALL |r| (|spadConstant| $ 10) (QREFELT $ 12)) (CONS 0 |q|))
            ('T (CONS 1 "failed"))))))) 

(SDEFUN |XPFACT;left_ext_GCD;2XdpU;5|
        ((|a| (|XDistributedPolynomial| |vl| F))
         (|b| (|XDistributedPolynomial| |vl| F))
         ($
          (|Union|
           (|Record| (|:| |g| (|XDistributedPolynomial| |vl| F))
                     (|:| |c1| (|XDistributedPolynomial| |vl| F))
                     (|:| |c2| (|XDistributedPolynomial| |vl| F))
                     (|:| |cu| (|XDistributedPolynomial| |vl| F))
                     (|:| |cv| (|XDistributedPolynomial| |vl| F)))
           "failed")))
        (SPROG
         ((|v| #1=(|XDistributedPolynomial| |vl| F))
          (|v0| #2=(|XDistributedPolynomial| |vl| F))
          (|#G21| #3=(|XDistributedPolynomial| |vl| F)) (|#G20| #1#) (|u| #2#)
          (|u0| #1#) (|#G19| #3#) (|#G18| #2#)
          (|#G17| #4=(|XDistributedPolynomial| |vl| F))
          (|#G16| (|XDistributedPolynomial| |vl| F)) (#5=#:G777 NIL) (|r| #4#)
          (|q| #6=(|XDistributedPolynomial| |vl| F))
          (|#G15| (|Record| (|:| |quotient| #6#) (|:| |remainder| #4#))))
         (SEQ
          (EXIT
           (SEQ (LETT |u0| (LETT |v| (|spadConstant| $ 34)))
                (LETT |v0| (LETT |u| (|spadConstant| $ 10)))
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL |b| (|spadConstant| $ 10) (QREFELT $ 35)))
                       (GO G191)))
                     (SEQ
                      (PROGN
                       (LETT |#G15| (SPADCALL |a| |b| (QREFELT $ 33)))
                       (LETT |q| (QCAR |#G15|))
                       (LETT |r| (QCDR |#G15|))
                       |#G15|)
                      (COND
                       ((NULL
                         (< (|XPFACT;my_degree| |r| $)
                            (SPADCALL |b| (QREFELT $ 15))))
                        (EXIT
                         (PROGN (LETT #5# (CONS 1 "failed")) (GO #7=#:G776)))))
                      (PROGN
                       (LETT |#G16| |b|)
                       (LETT |#G17| |r|)
                       (LETT |a| |#G16|)
                       (LETT |b| |#G17|))
                      (PROGN
                       (LETT |#G18| |u|)
                       (LETT |#G19|
                             (SPADCALL |u0| (SPADCALL |u| |q| (QREFELT $ 29))
                                       (QREFELT $ 30)))
                       (LETT |u0| |#G18|)
                       (LETT |u| |#G19|))
                      (EXIT
                       (PROGN
                        (LETT |#G20| |v|)
                        (LETT |#G21|
                              (SPADCALL |v0| (SPADCALL |v| |q| (QREFELT $ 29))
                                        (QREFELT $ 30)))
                        (LETT |v0| |#G20|)
                        (LETT |v| |#G21|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (VECTOR |a| |u0| |v0| |u| |v|)))))
          #7# (EXIT #5#)))) 

(SDEFUN |XPFACT;homo_fact1|
        ((|p1| (|XDistributedPolynomial| |vl| F))
         ($ (|List| (|XDistributedPolynomial| |vl| F))))
        (SPROG
         ((#1=#:G790 NIL) (#2=#:G792 NIL)
          (|lf| (|XDistributedPolynomial| |vl| F)) (|n1| (|Integer|))
          (|n1u| (|Union| (|NonNegativeInteger|) "failed"))
          (|n2| #3=(|NonNegativeInteger|))
          (|rf| (|XDistributedPolynomial| |vl| F)) (#4=#:G791 NIL)
          (|lw2| (|FreeMonoid| |vl|)) (|lw1| (|FreeMonoid| |vl|)) (|c0| (F))
          (|n| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL |p1| (QREFELT $ 39)))
                (LETT |lw2| (SPADCALL |p1| (QREFELT $ 24)))
                (LETT |c0| (SPADCALL |p1| (QREFELT $ 25)))
                (LETT |lw1| (|spadConstant| $ 40))
                (EXIT
                 (COND ((EQL (SPADCALL |lw2| (QREFELT $ 20)) 0) NIL)
                       ('T
                        (SEQ
                         (SEQ
                          (EXIT
                           (SEQ G190
                                (COND
                                 ((NULL (> (SPADCALL |lw2| (QREFELT $ 20)) 0))
                                  (GO G191)))
                                (SEQ
                                 (LETT |lw1|
                                       (SPADCALL |lw1|
                                                 (SPADCALL
                                                  (SPADCALL |lw2|
                                                            (QREFELT $ 41))
                                                  (QREFELT $ 42))
                                                 (QREFELT $ 43)))
                                 (LETT |lw2| (SPADCALL |lw2| (QREFELT $ 44)))
                                 (EXIT
                                  (COND
                                   ((EQL (SPADCALL |lw2| (QREFELT $ 20)) 0)
                                    (PROGN (LETT #4# 1) (GO #5=#:G786)))
                                   ('T
                                    (SEQ
                                     (LETT |rf|
                                           (SPADCALL |p1| |lw1|
                                                     (QREFELT $ 27)))
                                     (LETT |n2| (SPADCALL |rf| (QREFELT $ 39)))
                                     (LETT |n1u|
                                           (SPADCALL |n| |n2| (QREFELT $ 46)))
                                     (EXIT
                                      (COND ((QEQCAR |n1u| 1) "iterate")
                                            ('T
                                             (SEQ (LETT |n1| (QCDR |n1u|))
                                                  (LETT |lf|
                                                        (SPADCALL |p1| |lw2|
                                                                  (QREFELT $
                                                                           47)))
                                                  (EXIT
                                                   (COND
                                                    ((SPADCALL |n1|
                                                               (SPADCALL |lf|
                                                                         (QREFELT
                                                                          $
                                                                          39))
                                                               (QREFELT $ 49))
                                                     "iterate")
                                                    ('T
                                                     (SEQ
                                                      (EXIT
                                                       (SEQ
                                                        (LETT |lf|
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (|spadConstant|
                                                                 $ 13)
                                                                |c0|
                                                                (QREFELT $ 26))
                                                               |lf|
                                                               (QREFELT $ 28)))
                                                        (EXIT
                                                         (COND
                                                          ((SPADCALL |p1|
                                                                     (SPADCALL
                                                                      |lf| |rf|
                                                                      (QREFELT
                                                                       $ 29))
                                                                     (QREFELT $
                                                                              12))
                                                           (PROGN
                                                            (LETT #1#
                                                                  (PROGN
                                                                   (LETT #2#
                                                                         (LIST
                                                                          |lf|
                                                                          |rf|))
                                                                   (GO
                                                                    #6=#:G789)))
                                                            (GO
                                                             #7=#:G782)))))))
                                                      #7#
                                                      (EXIT #1#))))))))))))))
                                NIL (GO G190) G191 (EXIT NIL)))
                          #5# (EXIT #4#))
                         (EXIT NIL)))))))
          #6# (EXIT #2#)))) 

(SDEFUN |XPFACT;homo_fact;XdpL;7|
        ((|p| (|XDistributedPolynomial| |vl| F))
         ($ (|List| (|XDistributedPolynomial| |vl| F))))
        (SPROG
         ((|res| (|List| (|XDistributedPolynomial| |vl| F)))
          (|p1| (|XDistributedPolynomial| |vl| F)) (#1=#:G800 NIL)
          (|fl1| (|List| (|XDistributedPolynomial| |vl| F))))
         (SEQ
          (EXIT
           (SEQ (LETT |res| NIL)
                (SEQ G190 NIL
                     (SEQ (LETT |fl1| (|XPFACT;homo_fact1| |p| $))
                          (EXIT
                           (COND
                            ((NULL |fl1|)
                             (SEQ (LETT |res| (CONS |p| |res|))
                                  (LETT |res| (REVERSE |res|))
                                  (EXIT
                                   (PROGN (LETT #1# |res|) (GO #2=#:G799)))))
                            ('T
                             (SEQ (LETT |p1| (|SPADfirst| |fl1|))
                                  (LETT |res| (CONS |p1| |res|))
                                  (EXIT
                                   (LETT |p| (|SPADfirst| (CDR |fl1|)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #2# (EXIT #1#)))) 

(SDEFUN |XPFACT;XDP_to_YDP|
        ((|p| (|XDistributedPolynomial| |vl| F))
         ($ (|XDistributedPolynomial| |vl| (|Polynomial| F))))
        (SPROG
         ((|lt2|
           (|List|
            (|Record| (|:| |k| (|FreeMonoid| |vl|))
                      (|:| |c| (|Polynomial| F)))))
          (#1=#:G812 NIL) (|t| NIL)
          (|lt| (|List| (|Record| (|:| |k| (|FreeMonoid| |vl|)) (|:| |c| F)))))
         (SEQ (LETT |lt| (SPADCALL |p| (QREFELT $ 18))) (LETT |lt2| NIL)
              (SEQ (LETT |t| NIL) (LETT #1# |lt|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |lt2|
                           (CONS
                            (CONS (QCAR |t|)
                                  (SPADCALL (QCDR |t|) (QREFELT $ 52)))
                            |lt2|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |lt2| (NREVERSE |lt2|))
              (EXIT (SPADCALL |lt2| (QREFELT $ 56)))))) 

(SDEFUN |XPFACT;eval_YDP|
        ((|p| (|XDistributedPolynomial| |vl| (|Polynomial| F)))
         (|ls| (|List| (|Symbol|))) (|lval| (|List| F))
         ($ (|XDistributedPolynomial| |vl| F)))
        (SPROG
         ((|lt2| (|List| (|Record| (|:| |k| (|FreeMonoid| |vl|)) (|:| |c| F))))
          (|nc| (F)) (#1=#:G820 NIL) (|t| NIL)
          (|lt|
           (|List|
            (|Record| (|:| |k| (|FreeMonoid| |vl|))
                      (|:| |c| (|Polynomial| F))))))
         (SEQ (LETT |lt| (SPADCALL |p| (QREFELT $ 57))) (LETT |lt2| NIL)
              (SEQ (LETT |t| NIL) (LETT #1# |lt|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |nc|
                          (SPADCALL
                           (SPADCALL (QCDR |t|) |ls| |lval| (QREFELT $ 60))
                           (QREFELT $ 61)))
                    (EXIT
                     (COND
                      ((SPADCALL |nc| (|spadConstant| $ 8) (QREFELT $ 62))
                       "iterate")
                      ('T (LETT |lt2| (CONS (CONS (QCAR |t|) |nc|) |lt2|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |lt2| (QREFELT $ 21)))))) 

(SDEFUN |XPFACT;eval_sup|
        ((|p1| (|SparseUnivariatePolynomial| F))
         (|w| (|XDistributedPolynomial| |vl| F))
         ($ (|XDistributedPolynomial| |vl| F)))
        (SPROG
         ((|res| (|XDistributedPolynomial| |vl| F)) (#1=#:G834 NIL) (|i| NIL)
          (|od| (|Integer|)) (#2=#:G833 NIL) (|nd| (|NonNegativeInteger|))
          (|c| (F)))
         (SEQ (LETT |res| (|spadConstant| $ 10)) (LETT |od| -1)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |p1| (|spadConstant| $ 64) (QREFELT $ 65)))
                     (GO G191)))
                   (SEQ (LETT |c| (SPADCALL |p1| (QREFELT $ 66)))
                        (LETT |nd| (SPADCALL |p1| (QREFELT $ 67)))
                        (SEQ (LETT |i| |nd|) (LETT #2# (- |od| 1)) G190
                             (COND ((> |i| #2#) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |res|
                                     (SPADCALL |w| |res| (QREFELT $ 29)))))
                             (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                        (LETT |res|
                              (SPADCALL |res| (SPADCALL |c| (QREFELT $ 68))
                                        (QREFELT $ 31)))
                        (LETT |p1| (SPADCALL |p1| (QREFELT $ 69)))
                        (EXIT (LETT |od| |nd|)))
                   NIL (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |i| 1) (LETT #1# |od|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT (LETT |res| (SPADCALL |w| |res| (QREFELT $ 29)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |XPFACT;restn|
        ((|w| (|FreeMonoid| |vl|)) (|j| (|Integer|)) ($ (|FreeMonoid| |vl|)))
        (SPROG ((#1=#:G839 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| 1) (LETT #1# |j|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ (EXIT (LETT |w| (SPADCALL |w| (QREFELT $ 44)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |w|)))) 

(SDEFUN |XPFACT;firstn|
        ((|w| (|FreeMonoid| |vl|)) (|j| (|Integer|)) ($ (|FreeMonoid| |vl|)))
        (SPROG ((|res| (|FreeMonoid| |vl|)) (#1=#:G845 NIL) (|i| NIL))
               (SEQ (LETT |res| (|spadConstant| $ 40))
                    (SEQ (LETT |i| 1) (LETT #1# |j|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (LETT |res|
                                (SPADCALL |res|
                                          (SPADCALL
                                           (SPADCALL |w| (QREFELT $ 41))
                                           (QREFELT $ 42))
                                          (QREFELT $ 43)))
                          (EXIT (LETT |w| (SPADCALL |w| (QREFELT $ 44)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |XPFACT;my_ground| ((|fr| (|Fraction| (|Polynomial| F))) ($ (F)))
        (SPADCALL (SPADCALL (SPADCALL |fr| (QREFELT $ 71)) (QREFELT $ 61))
                  (SPADCALL (SPADCALL |fr| (QREFELT $ 72)) (QREFELT $ 61))
                  (QREFELT $ 26))) 

(SDEFUN |XPFACT;rational_solution1|
        ((|eq| (|Equation| (|Fraction| (|Polynomial| F))))
         ($ (|List| (|Fraction| (|Polynomial| F)))))
        (SPROG
         ((|dr| (|Polynomial| F)) (|nr| #1=(|Polynomial| F))
          (|re| (|Fraction| (|Polynomial| F))) (|nl| #1#)
          (|le| (|Fraction| (|Polynomial| F))))
         (SEQ (LETT |le| (SPADCALL |eq| (QREFELT $ 74)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |le| (QREFELT $ 72)) (|spadConstant| $ 75)
                           (QREFELT $ 76))
                 NIL)
                ('T
                 (SEQ (LETT |nl| (SPADCALL |le| (QREFELT $ 71)))
                      (COND
                       ((OR
                         (SPADCALL (SPADCALL |nl| (QREFELT $ 77)) 1
                                   (QREFELT $ 49))
                         (SPADCALL (SPADCALL |nl| (QREFELT $ 78))
                                   (|spadConstant| $ 79) (QREFELT $ 76)))
                        (EXIT NIL)))
                      (LETT |re| (SPADCALL |eq| (QREFELT $ 80)))
                      (LETT |nr| (SPADCALL |re| (QREFELT $ 71)))
                      (COND ((NULL (SPADCALL |nr| (QREFELT $ 81))) (EXIT NIL)))
                      (LETT |dr| (SPADCALL |re| (QREFELT $ 72)))
                      (COND ((NULL (SPADCALL |dr| (QREFELT $ 81))) (EXIT NIL)))
                      (EXIT
                       (LIST |le|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 75)
                                         (SPADCALL |nl| (QREFELT $ 82))
                                         (QREFELT $ 83))
                               (|XPFACT;my_ground| |re| $) (QREFELT $ 86))
                              (QREFELT $ 87))))))))))) 

(SDEFUN |XPFACT;rational_solution|
        ((|leq| (|List| (|Equation| (|Fraction| (|Polynomial| F)))))
         (|ls| (|List| (|Symbol|))) ($ (|List| F)))
        (SPROG
         ((|sol| (|List| F)) (|v| (|Symbol|)) (#1=#:G865 NIL)
          (|sol1| (|List| (|Fraction| (|Polynomial| F)))) (#2=#:G866 NIL)
          (|eq| NIL) (#3=#:G867 NIL) (|s| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |sol| NIL)
                (SEQ (LETT |s| NIL) (LETT #3# |ls|) (LETT |eq| NIL)
                     (LETT #2# |leq|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |eq| (CAR #2#)) NIL)
                           (ATOM #3#) (PROGN (LETT |s| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((NULL
                          (LETT |sol1| (|XPFACT;rational_solution1| |eq| $)))
                         (PROGN (LETT #1# NIL) (GO #4=#:G864)))
                        ('T
                         (SEQ
                          (LETT |v|
                                (|SPADfirst|
                                 (SPADCALL
                                  (SPADCALL (|SPADfirst| |sol1|)
                                            (QREFELT $ 71))
                                  (QREFELT $ 88))))
                          (EXIT
                           (COND
                            ((SPADCALL |s| |v| (QREFELT $ 90))
                             (|error| "strange solution"))
                            ('T
                             (LETT |sol|
                                   (CONS
                                    (|XPFACT;my_ground|
                                     (|SPADfirst| (CDR |sol1|)) $)
                                    |sol|))))))))))
                     (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT (REVERSE |sol|))))
          #4# (EXIT #1#)))) 

(SDEFUN |XPFACT;get_rational_solution|
        ((|lsol| (|List| (|List| (|Equation| (|Fraction| (|Polynomial| F))))))
         (|ls| (|List| (|Symbol|))) ($ (|List| F)))
        (SPROG ((#1=#:G873 NIL) (|sol| (|List| F)) (#2=#:G874 NIL) (|leq| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |leq| NIL) (LETT #2# |lsol|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |leq| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL
                            (NULL
                             (LETT |sol|
                                   (|XPFACT;rational_solution| |leq| |ls| $))))
                           (PROGN (LETT #1# |sol|) (GO #3=#:G872))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT NIL)))
                #3# (EXIT #1#)))) 

(SDEFUN |XPFACT;algebraic_solution|
        ((|leq| (|List| (|Equation| (|Fraction| (|Polynomial| F)))))
         (|alg_sym| (|Symbol|)) (|ls| (|List| (|Symbol|)))
         ($
          (|Union|
           (|Record| (|:| |pol| (|Polynomial| F)) (|:| |sol1| (|List| F)))
           "failed")))
        (SPROG
         ((|v_lst| (|List| (|Symbol|))) (|eq| (|Polynomial| F))
          (|eqf| (|Fraction| (|Polynomial| F)))
          (|eq1| (|Equation| (|Fraction| (|Polynomial| F))))
          (|sol1| (|List| F)))
         (SEQ (LETT |sol1| (|XPFACT;rational_solution| (CDR |leq|) |ls| $))
              (EXIT
               (COND ((NULL |sol1|) (CONS 1 "failed"))
                     (#1='T
                      (SEQ (LETT |eq1| (|SPADfirst| |leq|))
                           (LETT |eqf|
                                 (SPADCALL (SPADCALL |eq1| (QREFELT $ 74))
                                           (SPADCALL |eq1| (QREFELT $ 80))
                                           (QREFELT $ 91)))
                           (LETT |eq| (SPADCALL |eqf| (QREFELT $ 71)))
                           (LETT |v_lst| (SPADCALL |eq| (QREFELT $ 88)))
                           (EXIT
                            (COND
                             ((SPADCALL |v_lst| (LIST |alg_sym|)
                                        (QREFELT $ 92))
                              (CONS 0 (CONS |eq| |sol1|)))
                             (#1# (CONS 1 "failed"))))))))))) 

(SDEFUN |XPFACT;get_algebraic_solution|
        ((|lsol| (|List| (|List| (|Equation| (|Fraction| (|Polynomial| F))))))
         (|alg_sym| (|Symbol|)) (|ls| (|List| (|Symbol|)))
         ($
          (|Union|
           (|Record| (|:| |pol| (|Polynomial| F)) (|:| |sol1| (|List| F)))
           "failed")))
        (SPROG
         ((#1=#:G887 NIL)
          (|sol|
           (|Union|
            (|Record| (|:| |pol| (|Polynomial| F)) (|:| |sol1| (|List| F)))
            "failed"))
          (#2=#:G888 NIL) (|leq| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |leq| NIL) (LETT #2# |lsol|) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |leq| (CAR #2#)) NIL))
                   (GO G191)))
                 (SEQ
                  (LETT |sol|
                        (|XPFACT;algebraic_solution| |leq| |alg_sym| |ls| $))
                  (EXIT
                   (COND
                    ((QEQCAR |sol| 0)
                     (PROGN (LETT #1# |sol|) (GO #3=#:G886))))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 1 "failed"))))
          #3# (EXIT #1#)))) 

(SDEFUN |XPFACT;my_mul|
        ((|l| (|List| (|XDistributedPolynomial| |vl| F)))
         ($ (|XDistributedPolynomial| |vl| F)))
        (SPROG
         ((|res| (|XDistributedPolynomial| |vl| F)) (#1=#:G893 NIL) (|p| NIL))
         (SEQ (LETT |l| (REVERSE |l|)) (LETT |res| (|SPADfirst| |l|))
              (SEQ (LETT |p| NIL) (LETT #1# (CDR |l|)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT (LETT |res| (SPADCALL |p| |res| (QREFELT $ 29)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |XPFACT;overlap_steps|
        ((|ll| (|List| (|XDistributedPolynomial| |vl| F)))
         (|rl| (|List| (|XDistributedPolynomial| |vl| F)))
         ($ (|List| (|Integer|))))
        (SPROG
         ((|d| (|NonNegativeInteger|)) (|res| (|List| (|Integer|)))
          (#1=#:G897 NIL) (#2=#:G903 NIL) (|p2| NIL) (#3=#:G904 NIL) (|k| NIL)
          (|kk| (|NonNegativeInteger|))
          (|p1| (|XDistributedPolynomial| |vl| F)))
         (SEQ (LETT |res| NIL) (LETT |p1| (SPADCALL |ll| (QREFELT $ 93)))
              (LETT |d| (SPADCALL |p1| (QREFELT $ 15)))
              (LETT |kk| (LENGTH |ll|))
              (SEQ (LETT |k| 1) (LETT #3# |kk|) (LETT |p2| NIL) (LETT #2# |rl|)
                   G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |p2| (CAR #2#)) NIL)
                         (|greater_SI| |k| #3#))
                     (GO G191)))
                   (SEQ
                    (COND
                     ((SPADCALL |p2| |p1| (QREFELT $ 12))
                      (COND
                       ((SPADCALL (SPADCALL |rl| |k| (QREFELT $ 94))
                                  (SPADCALL |ll|
                                            (PROG1 (LETT #1# (- |kk| |k|))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 95))
                                  (QREFELT $ 96))
                        (LETT |res| (CONS |d| |res|))))))
                    (EXIT (LETT |d| (+ |d| (SPADCALL |p2| (QREFELT $ 15))))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT |k| (|inc_SI| |k|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (REVERSE |res|))))) 

(SDEFUN |XPFACT;lift1;FmXdpIFmXdpIFXdpBR;21|
        ((|lw| (|FreeMonoid| |vl|))
         (|lfy| (|XDistributedPolynomial| |vl| (|Polynomial| F)))
         (|d1| (|Integer|)) (|rw| (|FreeMonoid| |vl|))
         (|rfy| (|XDistributedPolynomial| |vl| (|Polynomial| F)))
         (|j| (|Integer|)) (|lc| (F))
         (|rp| (|XDistributedPolynomial| |vl| (|Polynomial| F)))
         (|o_case| (|Boolean|))
         ($
          (|Record|
           (|:| |l_fac| (|XDistributedPolynomial| |vl| (|Polynomial| F)))
           (|:| |r_fac| (|XDistributedPolynomial| |vl| (|Polynomial| F)))
           (|:| |residual| (|XDistributedPolynomial| |vl| (|Polynomial| F)))
           (|:| |nsym| (|Union| (|Symbol|) "none")))))
        (SPROG
         ((|lf1| #1=(|XDistributedPolynomial| |vl| (|Polynomial| F)))
          (|rf1| (|XDistributedPolynomial| |vl| (|Polynomial| F)))
          (|rf1p| #2=(|XDistributedPolynomial| |vl| (|Polynomial| F)))
          (|nc1| (|Polynomial| F)) (|nc2| (|Polynomial| F)) (|piv2| (F))
          (|rdc0| (|Polynomial| F)) (|ldc| (F))
          (|lqu| (|Union| (|FreeMonoid| |vl|) "failed"))
          (|ldc0| (|Polynomial| F)) (|rdc| (F))
          (|rqu| (|Union| (|FreeMonoid| |vl|) "failed"))
          (|dc| #3=(|Polynomial| F)) (|dw| (|FreeMonoid| |vl|))
          (|dif_p| (|XDistributedPolynomial| |vl| (|Polynomial| F))) (|oc| #3#)
          (|nc| (|Polynomial| F)) (|nsu| (|Union| (|Symbol|) "none"))
          (|ns| (|Symbol|)) (|low| #4=(|FreeMonoid| |vl|)) (|row| #4#)
          (|lop| #1#) (|rcw| (|FreeMonoid| |vl|)) (|rop| #2#)
          (|lcw| (|FreeMonoid| |vl|)))
         (SEQ (LETT |nsu| (CONS 1 "none"))
              (LETT |lcw| (|XPFACT;restn| |lw| (- |d1| |j|) $))
              (LETT |rop| (SPADCALL |rfy| |lcw| (QREFELT $ 97)))
              (COND
               ((SPADCALL |rop| (|spadConstant| $ 98) (QREFELT $ 99))
                (SEQ (LETT |rf1p| (SPADCALL |rp| |lw| (QREFELT $ 97)))
                     (LETT |rf1|
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 75) |lc|
                                      (QREFELT $ 83))
                            |rf1p| (QREFELT $ 100)))
                     (LETT |rp|
                           (SPADCALL |rp|
                                     (SPADCALL |lfy| |rf1| (QREFELT $ 101))
                                     (QREFELT $ 102)))
                     (LETT |lf1| (SPADCALL |rp| |rw| (QREFELT $ 103)))
                     (EXIT
                      (LETT |rp|
                            (SPADCALL |rp|
                                      (SPADCALL |lf1| |rfy| (QREFELT $ 101))
                                      (QREFELT $ 102))))))
               (#5='T
                (SEQ (LETT |rcw| (|XPFACT;firstn| |rw| |j| $))
                     (LETT |lop| (SPADCALL |lfy| |rcw| (QREFELT $ 103)))
                     (LETT |row|
                           (SPADCALL |lw| (SPADCALL |rop| (QREFELT $ 104))
                                     (QREFELT $ 43)))
                     (EXIT
                      (COND
                       ((SPADCALL |lop| (|spadConstant| $ 98) (QREFELT $ 99))
                        (SEQ (LETT |lf1| (SPADCALL |rp| |rw| (QREFELT $ 103)))
                             (LETT |rp|
                                   (SPADCALL |rp|
                                             (SPADCALL |lf1| |rfy|
                                                       (QREFELT $ 101))
                                             (QREFELT $ 102)))
                             (LETT |rf1p| (SPADCALL |rp| |lw| (QREFELT $ 97)))
                             (LETT |rf1|
                                   (SPADCALL
                                    (SPADCALL (|spadConstant| $ 75) |lc|
                                              (QREFELT $ 83))
                                    |rf1p| (QREFELT $ 100)))
                             (EXIT
                              (LETT |rp|
                                    (SPADCALL |rp|
                                              (SPADCALL |lfy| |rf1|
                                                        (QREFELT $ 101))
                                              (QREFELT $ 102))))))
                       (#5#
                        (SEQ
                         (LETT |low|
                               (SPADCALL (SPADCALL |lop| (QREFELT $ 104)) |rw|
                                         (QREFELT $ 43)))
                         (EXIT
                          (COND
                           ((SPADCALL |row| |low| (QREFELT $ 105))
                            (SEQ
                             (LETT |lf1| (SPADCALL |rp| |rw| (QREFELT $ 103)))
                             (LETT |rp|
                                   (SPADCALL |rp|
                                             (SPADCALL |lf1| |rfy|
                                                       (QREFELT $ 101))
                                             (QREFELT $ 102)))
                             (LETT |rf1p| (SPADCALL |rp| |lw| (QREFELT $ 97)))
                             (LETT |rf1|
                                   (SPADCALL
                                    (SPADCALL (|spadConstant| $ 75) |lc|
                                              (QREFELT $ 83))
                                    |rf1p| (QREFELT $ 100)))
                             (EXIT
                              (LETT |rp|
                                    (SPADCALL |rp|
                                              (SPADCALL |lfy| |rf1|
                                                        (QREFELT $ 101))
                                              (QREFELT $ 102))))))
                           ((SPADCALL |low| |row| (QREFELT $ 105))
                            (SEQ
                             (LETT |rf1p| (SPADCALL |rp| |lw| (QREFELT $ 97)))
                             (LETT |rf1|
                                   (SPADCALL
                                    (SPADCALL (|spadConstant| $ 75) |lc|
                                              (QREFELT $ 83))
                                    |rf1p| (QREFELT $ 100)))
                             (LETT |rp|
                                   (SPADCALL |rp|
                                             (SPADCALL |lfy| |rf1|
                                                       (QREFELT $ 101))
                                             (QREFELT $ 102)))
                             (LETT |lf1| (SPADCALL |rp| |rw| (QREFELT $ 103)))
                             (EXIT
                              (LETT |rp|
                                    (SPADCALL |rp|
                                              (SPADCALL |lf1| |rfy|
                                                        (QREFELT $ 101))
                                              (QREFELT $ 102))))))
                           (|o_case|
                            (SEQ (LETT |ns| (SPADCALL (QREFELT $ 106)))
                                 (LETT |nsu| (CONS 0 |ns|))
                                 (LETT |nc|
                                       (SPADCALL (|spadConstant| $ 75) |ns| 1
                                                 (QREFELT $ 107)))
                                 (LETT |oc|
                                       (SPADCALL |rp| |low| (QREFELT $ 108)))
                                 (LETT |rf1p|
                                       (SPADCALL |rp| |lw| (QREFELT $ 97)))
                                 (LETT |rf1|
                                       (SPADCALL
                                        (SPADCALL (|spadConstant| $ 75) |lc|
                                                  (QREFELT $ 83))
                                        |rf1p| (QREFELT $ 100)))
                                 (LETT |lf1|
                                       (SPADCALL |rp| |rw| (QREFELT $ 103)))
                                 (LETT |rf1|
                                       (SPADCALL |rf1|
                                                 (SPADCALL |nc| |rop|
                                                           (QREFELT $ 100))
                                                 (QREFELT $ 109)))
                                 (LETT |lf1|
                                       (SPADCALL |lf1|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL |oc| |lc|
                                                             (QREFELT $ 83))
                                                   |nc| (QREFELT $ 110))
                                                  |lop| (QREFELT $ 100))
                                                 (QREFELT $ 102)))
                                 (EXIT
                                  (LETT |rp|
                                        (SPADCALL
                                         (SPADCALL |rp|
                                                   (SPADCALL |lfy| |rf1|
                                                             (QREFELT $ 101))
                                                   (QREFELT $ 102))
                                         (SPADCALL |lf1| |rfy| (QREFELT $ 101))
                                         (QREFELT $ 102))))))
                           (#5#
                            (SEQ
                             (LETT |oc| (SPADCALL |rp| |low| (QREFELT $ 108)))
                             (LETT |dif_p|
                                   (SPADCALL
                                    (SPADCALL |lfy| |rop| (QREFELT $ 101))
                                    (SPADCALL |lop| |rfy| (QREFELT $ 101))
                                    (QREFELT $ 102)))
                             (EXIT
                              (COND
                               ((SPADCALL |dif_p| (|spadConstant| $ 98)
                                          (QREFELT $ 99))
                                (|error| "impossible 1"))
                               (#5#
                                (SEQ
                                 (LETT |dw| (SPADCALL |dif_p| (QREFELT $ 104)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |dw| |low| (QREFELT $ 111))
                                    (|error| "impossible 2"))
                                   (#5#
                                    (SEQ
                                     (LETT |dc|
                                           (SPADCALL |rp| |dw|
                                                     (QREFELT $ 108)))
                                     (LETT |rdc| (|spadConstant| $ 8))
                                     (LETT |ldc| (|spadConstant| $ 8))
                                     (LETT |ldc0|
                                           (SEQ
                                            (LETT |rqu|
                                                  (SPADCALL |dw| |lw|
                                                            (QREFELT $ 112)))
                                            (EXIT
                                             (COND
                                              ((QEQCAR |rqu| 1)
                                               (|spadConstant| $ 79))
                                              (#5#
                                               (SEQ
                                                (LETT |rdc|
                                                      (SPADCALL
                                                       (SPADCALL |rop|
                                                                 (QCDR |rqu|)
                                                                 (QREFELT $
                                                                          108))
                                                       (QREFELT $ 61)))
                                                (EXIT
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (|spadConstant| $ 13) |lc|
                                                   (QREFELT $ 26))
                                                  |dc| (QREFELT $ 113)))))))))
                                     (LETT |rdc0|
                                           (SEQ
                                            (LETT |lqu|
                                                  (SPADCALL |dw| |rw|
                                                            (QREFELT $ 114)))
                                            (EXIT
                                             (COND
                                              ((QEQCAR |lqu| 1)
                                               (|spadConstant| $ 79))
                                              (#5#
                                               (SEQ
                                                (LETT |ldc|
                                                      (SPADCALL
                                                       (SPADCALL |lop|
                                                                 (QCDR |lqu|)
                                                                 (QREFELT $
                                                                          108))
                                                       (QREFELT $ 61)))
                                                (EXIT |dc|)))))))
                                     (LETT |piv2|
                                           (SPADCALL |rdc|
                                                     (|spadConstant| $ 13)
                                                     (QREFELT $ 115)))
                                     (EXIT
                                      (COND
                                       ((SPADCALL |piv2| (|spadConstant| $ 8)
                                                  (QREFELT $ 62))
                                        (|error| "impossible 3"))
                                       (#5#
                                        (SEQ
                                         (LETT |nc2|
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 13)
                                                          |piv2|
                                                          (QREFELT $ 26))
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL |dc| |ldc0|
                                                            (QREFELT $ 116))
                                                  |rdc0| (QREFELT $ 116))
                                                 (SPADCALL |ldc| |oc|
                                                           (QREFELT $ 113))
                                                 (QREFELT $ 110))
                                                (QREFELT $ 113)))
                                         (LETT |nc1|
                                               (SPADCALL
                                                (SPADCALL |oc| (QREFELT $ 118))
                                                |nc2| (QREFELT $ 116)))
                                         (LETT |rf1p|
                                               (SPADCALL |rp| |lw|
                                                         (QREFELT $ 97)))
                                         (LETT |rf1|
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 75)
                                                          |lc| (QREFELT $ 83))
                                                |rf1p| (QREFELT $ 100)))
                                         (LETT |rf1|
                                               (SPADCALL |rf1|
                                                         (SPADCALL |nc1| |rop|
                                                                   (QREFELT $
                                                                            100))
                                                         (QREFELT $ 109)))
                                         (LETT |lf1|
                                               (SPADCALL |rp| |rw|
                                                         (QREFELT $ 103)))
                                         (LETT |lf1|
                                               (SPADCALL |lf1|
                                                         (SPADCALL |nc2| |lop|
                                                                   (QREFELT $
                                                                            100))
                                                         (QREFELT $ 109)))
                                         (EXIT
                                          (LETT |rp|
                                                (SPADCALL
                                                 (SPADCALL |rp|
                                                           (SPADCALL |lfy|
                                                                     |rf1|
                                                                     (QREFELT $
                                                                              101))
                                                           (QREFELT $ 102))
                                                 (SPADCALL |lf1| |rfy|
                                                           (QREFELT $ 101))
                                                 (QREFELT $
                                                          102)))))))))))))))))))))))))))
              (EXIT (VECTOR |lf1| |rf1| |rp| |nsu|))))) 

(SDEFUN |XPFACT;dc_fact11|
        ((|lf| (|XDistributedPolynomial| |vl| F))
         (|lrl| (|List| (|XDistributedPolynomial| |vl| (|Polynomial| F))))
         (|eqs| (|List| (|Polynomial| F)))
         ($ (|Union| (|XDistributedPolynomial| |vl| F) "failed")))
        (SPROG
         ((#1=#:G961 NIL) (|w| (|XDistributedPolynomial| |vl| F))
          (|nfac| (|SparseUnivariatePolynomial| F))
          (|fac| #2=(|SparseUnivariatePolynomial| F)) (#3=#:G966 NIL)
          (|fr| NIL) (|inv_tt| (|SparseUnivariatePolynomial| F)) (|tt1| (F))
          (|tt0| (F)) (|tt| (|SparseUnivariatePolynomial| F))
          (|md| (|Integer|)) (#4=#:G965 NIL) (#5=#:G964 NIL)
          (|fl|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #2#)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|feq| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|eq1| (|SparseUnivariatePolynomial| F))
          (|ueqs| (|List| (|SparseUnivariatePolynomial| F))) (#6=#:G963 NIL)
          (|eq| NIL) (#7=#:G962 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |ueqs|
                  (PROGN
                   (LETT #7# NIL)
                   (SEQ (LETT |eq| NIL) (LETT #6# |eqs|) G190
                        (COND
                         ((OR (ATOM #6#) (PROGN (LETT |eq| (CAR #6#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #7#
                                (CONS (SPADCALL |eq| (QREFELT $ 125)) #7#))))
                        (LETT #6# (CDR #6#)) (GO G190) G191
                        (EXIT (NREVERSE #7#)))))
            (LETT |eq1| (SPADCALL |ueqs| (QREFELT $ 127)))
            (EXIT
             (COND ((< (SPADCALL |eq1| (QREFELT $ 67)) 1) (CONS 1 "failed"))
                   (#8='T
                    (SEQ (LETT |feq| (SPADCALL |eq1| (QREFELT $ 129)))
                         (LETT |fl| (SPADCALL |feq| (QREFELT $ 134)))
                         (LETT |md|
                               (SPADCALL
                                (PROGN
                                 (LETT #5# NIL)
                                 (SEQ (LETT |fr| NIL) (LETT #4# |fl|) G190
                                      (COND
                                       ((OR (ATOM #4#)
                                            (PROGN (LETT |fr| (CAR #4#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #5#
                                              (CONS
                                               (SPADCALL (QVELT |fr| 1)
                                                         (QREFELT $ 67))
                                               #5#))))
                                      (LETT #4# (CDR #4#)) (GO G190) G191
                                      (EXIT (NREVERSE #5#))))
                                (QREFELT $ 136)))
                         (LETT |tt|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|SPADfirst| |lrl|) (QREFELT $ 137))
                                 (QREFELT $ 125))
                                (QREFELT $ 138)))
                         (EXIT
                          (COND
                           ((> (SPADCALL |tt| (QREFELT $ 67)) 1)
                            (|error| "degree(tt) > 1"))
                           (#8#
                            (SEQ (LETT |tt0| (SPADCALL |tt| 0 (QREFELT $ 139)))
                                 (LETT |tt1| (SPADCALL |tt| (QREFELT $ 66)))
                                 (LETT |inv_tt|
                                       (SPADCALL
                                        (SPADCALL (|spadConstant| $ 13) |tt1|
                                                  (QREFELT $ 26))
                                        (SPADCALL
                                         (SPADCALL (|spadConstant| $ 13) 1
                                                   (QREFELT $ 140))
                                         (SPADCALL |tt0| (QREFELT $ 141))
                                         (QREFELT $ 144))
                                        (QREFELT $ 145)))
                                 (SEQ (LETT |fr| NIL) (LETT #3# |fl|) G190
                                      (COND
                                       ((OR (ATOM #3#)
                                            (PROGN (LETT |fr| (CAR #3#)) NIL))
                                        (GO G191)))
                                      (SEQ (LETT |fac| (QVELT |fr| 1))
                                           (EXIT
                                            (COND
                                             ((>
                                               (SPADCALL |fac| (QREFELT $ 67))
                                               |md|)
                                              "iterate")
                                             ('T
                                              (SEQ
                                               (LETT |nfac|
                                                     (SPADCALL |fac|
                                                               (QREFELT $ 124)
                                                               |inv_tt|
                                                               (QREFELT $
                                                                        146)))
                                               (LETT |w|
                                                     (SPADCALL |lf|
                                                               (|XPFACT;eval_YDP|
                                                                (SPADCALL
                                                                 (ELT $ 109)
                                                                 (CDR |lrl|)
                                                                 (|spadConstant|
                                                                  $ 98)
                                                                 (QREFELT $
                                                                          149))
                                                                NIL NIL $)
                                                               (QREFELT $ 31)))
                                               (EXIT
                                                (PROGN
                                                 (LETT #1#
                                                       (CONS 0
                                                             (|XPFACT;eval_sup|
                                                              |nfac| |w| $)))
                                                 (GO #9=#:G960))))))))
                                      (LETT #3# (CDR #3#)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT (|error| "impossible"))))))))))))
          #9# (EXIT #1#)))) 

(SDEFUN |XPFACT;dc_fact12|
        ((|lf| (|XDistributedPolynomial| |vl| F))
         (|lrl| (|List| (|XDistributedPolynomial| |vl| (|Polynomial| F))))
         (|eq| (|Polynomial| F)) (|sol1| (|List| F)) (|ls| (|List| (|Symbol|)))
         ($ (|XDistributedPolynomial| |vl| F)))
        (SPROG
         ((|w| (|XDistributedPolynomial| |vl| F))
          (|nfac| (|SparseUnivariatePolynomial| F))
          (|inv_tt| (|SparseUnivariatePolynomial| F)) (|tt1| (F)) (|tt0| (F))
          (|tt| (|SparseUnivariatePolynomial| F))
          (|ueq| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |ueq| (SPADCALL |eq| (QREFELT $ 125)))
              (LETT |tt|
                    (SPADCALL
                     (SPADCALL (SPADCALL (|SPADfirst| |lrl|) (QREFELT $ 137))
                               (QREFELT $ 125))
                     (QREFELT $ 138)))
              (EXIT
               (COND
                ((> (SPADCALL |tt| (QREFELT $ 67)) 1)
                 (|error| "degree(tt) > 1"))
                ('T
                 (SEQ (LETT |tt0| (SPADCALL |tt| 0 (QREFELT $ 139)))
                      (LETT |tt1| (SPADCALL |tt| (QREFELT $ 66)))
                      (LETT |inv_tt|
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 13) |tt1|
                                       (QREFELT $ 26))
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 13) 1
                                        (QREFELT $ 140))
                              (SPADCALL |tt0| (QREFELT $ 141)) (QREFELT $ 144))
                             (QREFELT $ 145)))
                      (LETT |nfac|
                            (SPADCALL |ueq| (QREFELT $ 124) |inv_tt|
                                      (QREFELT $ 146)))
                      (LETT |w|
                            (SPADCALL |lf|
                                      (|XPFACT;eval_YDP|
                                       (SPADCALL (ELT $ 109) (CDR |lrl|)
                                                 (|spadConstant| $ 98)
                                                 (QREFELT $ 149))
                                       |ls| |sol1| $)
                                      (QREFELT $ 31)))
                      (EXIT (|XPFACT;eval_sup| |nfac| |w| $))))))))) 

(SDEFUN |XPFACT;dc_fact1|
        ((|d| (|NonNegativeInteger|)) (|lc| (F))
         (|ll| (|List| (|XDistributedPolynomial| |vl| F)))
         (|rl| (|List| (|XDistributedPolynomial| |vl| F)))
         (|rs| (|XDistributedPolynomial| |vl| F))
         ($
          (|Union| (|List| (|XDistributedPolynomial| |vl| F))
                   (|XDistributedPolynomial| |vl| F) "failed")))
        (SPROG
         ((|rf| (|XDistributedPolynomial| |vl| F))
          (|lf| (|XDistributedPolynomial| |vl| F))
          (|solr|
           (|Record| (|:| |pol| (|Polynomial| F)) (|:| |sol1| (|List| F))))
          (|solu|
           (|Union|
            (|Record| (|:| |pol| (|Polynomial| F)) (|:| |sol1| (|List| F)))
            "failed"))
          (|ls| (|List| (|Symbol|))) (|alg_sym| (|Symbol|)) (|sol| (|List| F))
          (|lsol| (|List| (|List| (|Equation| (|Fraction| (|Polynomial| F))))))
          (#1=#:G1064 NIL) (|eq| NIL) (#2=#:G1063 NIL)
          (|au| (|Union| (|XDistributedPolynomial| |vl| F) "failed"))
          (|rrl1| (|List| (|XDistributedPolynomial| |vl| (|Polynomial| F))))
          (|eqs| (|List| (|Polynomial| F)))
          (|rp| (|XDistributedPolynomial| |vl| (|Polynomial| F)))
          (|ts| (|List| (|XDistributedPolynomial| |vl| F))) (#3=#:G1061 NIL)
          (|lr1| NIL) (#4=#:G1062 NIL) (|rr1| NIL) (#5=#:G1060 NIL)
          (#6=#:G1059 NIL) (|j| NIL)
          (|rrl| (|List| (|XDistributedPolynomial| |vl| (|Polynomial| F))))
          (|rf1| #7=(|XDistributedPolynomial| |vl| (|Polynomial| F)))
          (#8=#:G1057 NIL) (#9=#:G1058 NIL) (#10=#:G1056 NIL) (#11=#:G1055 NIL)
          (|lrl| (|List| (|XDistributedPolynomial| |vl| (|Polynomial| F))))
          (|lf1| #12=(|XDistributedPolynomial| |vl| (|Polynomial| F)))
          (#13=#:G1053 NIL) (#14=#:G1054 NIL) (#15=#:G1052 NIL)
          (#16=#:G1051 NIL) (|alg_case2| #17=(|Boolean|)) (|alg_case| #17#)
          (|nsu| #18=(|Union| (|Symbol|) "none"))
          (|#G122|
           (|Record| (|:| |l_fac| #12#) (|:| |r_fac| #7#)
                     (|:| |residual|
                          (|XDistributedPolynomial| |vl| (|Polynomial| F)))
                     (|:| |nsym| #18#)))
          (#19=#:G1049 NIL) (#20=#:G1050 NIL) (#21=#:G1048 NIL)
          (|lovl| (|List| (|Integer|))) (|ovls| (|Integer|)) (|o_case| #17#)
          (#22=#:G1047 NIL) (|md| (|NonNegativeInteger|))
          (|rw| #23=(|FreeMonoid| |vl|)) (|lw| #23#)
          (|d2| #24=(|NonNegativeInteger|)) (|d1| #24#)
          (|rfy| #25=(|XDistributedPolynomial| |vl| (|Polynomial| F)))
          (|lfy| #25#))
         (SEQ
          (LETT |lf| (SPADCALL |lc| (|XPFACT;my_mul| |ll| $) (QREFELT $ 28)))
          (LETT |rf| (|XPFACT;my_mul| |rl| $))
          (LETT |lfy| (|XPFACT;XDP_to_YDP| |lf| $))
          (LETT |rfy| (|XPFACT;XDP_to_YDP| |rf| $))
          (LETT |d1| (SPADCALL |lf| (QREFELT $ 15)))
          (LETT |d2| (SPADCALL |rf| (QREFELT $ 15)))
          (LETT |lw| (SPADCALL |lf| (QREFELT $ 24)))
          (LETT |rw| (SPADCALL |rf| (QREFELT $ 24)))
          (LETT |md| (MIN |d1| |d2|))
          (LETT |lovl| (|XPFACT;overlap_steps| |ll| |rl| $))
          (LETT |lovl| (SPADCALL |lovl| (+ |md| 1) (QREFELT $ 150)))
          (LETT |ovls| (|SPADfirst| |lovl|)) (LETT |lovl| (CDR |lovl|))
          (LETT |lrl| NIL) (LETT |rrl| NIL) (LETT |eqs| NIL) (LETT |ls| NIL)
          (LETT |alg_case| 'T) (LETT |alg_case2| NIL)
          (SEQ (LETT |j| 1) (LETT #22# |md|) G190
               (COND ((|greater_SI| |j| #22#) (GO G191)))
               (SEQ (LETT |o_case| NIL)
                    (COND
                     ((EQL |j| |ovls|)
                      (SEQ (LETT |o_case| 'T)
                           (LETT |ovls| (|SPADfirst| |lovl|))
                           (EXIT (LETT |lovl| (CDR |lovl|))))))
                    (LETT |rp|
                          (SPADCALL
                           (SPADCALL (ELT $ 109)
                                     (PROGN
                                      (LETT #21# NIL)
                                      (SEQ (LETT |rr1| NIL) (LETT #20# |rrl|)
                                           (LETT |lr1| NIL) (LETT #19# |lrl|)
                                           G190
                                           (COND
                                            ((OR (ATOM #19#)
                                                 (PROGN
                                                  (LETT |lr1| (CAR #19#))
                                                  NIL)
                                                 (ATOM #20#)
                                                 (PROGN
                                                  (LETT |rr1| (CAR #20#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #21#
                                                   (CONS
                                                    (SPADCALL |lr1| |rr1|
                                                              (QREFELT $ 101))
                                                    #21#))))
                                           (LETT #19#
                                                 (PROG1 (CDR #19#)
                                                   (LETT #20# (CDR #20#))))
                                           (GO G190) G191
                                           (EXIT (NREVERSE #21#))))
                                     (|spadConstant| $ 98) (QREFELT $ 149))
                           (QREFELT $ 151)))
                    (COND
                     ((EQL (- |d| |j|) (|XPFACT;my_degree| |rs| $))
                      (SEQ (LETT |ts| (SPADCALL |rs| (QREFELT $ 23)))
                           (LETT |rp|
                                 (SPADCALL |rp|
                                           (|XPFACT;XDP_to_YDP|
                                            (|SPADfirst| |ts|) $)
                                           (QREFELT $ 109)))
                           (EXIT (LETT |rs| (|SPADfirst| (CDR |ts|)))))))
                    (PROGN
                     (LETT |#G122|
                           (SPADCALL |lw| |lfy| |d1| |rw| |rfy| |j| |lc| |rp|
                                     |o_case| (QREFELT $ 121)))
                     (LETT |lf1| (QVELT |#G122| 0))
                     (LETT |rf1| (QVELT |#G122| 1))
                     (LETT |rp| (QVELT |#G122| 2))
                     (LETT |nsu| (QVELT |#G122| 3))
                     |#G122|)
                    (COND
                     ((QEQCAR |nsu| 0)
                      (SEQ (LETT |ls| (CONS (QCDR |nsu|) |ls|))
                           (COND ((< |j| |md|) (LETT |alg_case| NIL)))
                           (EXIT
                            (COND ((EQL |j| |md|) (LETT |alg_case2| 'T)))))))
                    (LETT |eqs|
                          (SPADCALL |eqs| (SPADCALL |rp| (QREFELT $ 153))
                                    (QREFELT $ 154)))
                    (LETT |lrl| (CONS |lf1| |lrl|))
                    (EXIT (LETT |rrl| (SPADCALL |rrl| |rf1| (QREFELT $ 155)))))
               (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
          (COND
           ((> |d1| |d2|)
            (SEQ (LETT |j| (+ |md| 1)) (LETT #16# |d1|) G190
                 (COND ((> |j| #16#) (GO G191)))
                 (SEQ
                  (LETT |rp|
                        (SPADCALL
                         (SPADCALL (ELT $ 109)
                                   (PROGN
                                    (LETT #15# NIL)
                                    (SEQ (LETT |rr1| NIL) (LETT #14# |rrl|)
                                         (LETT |lr1| NIL) (LETT #13# |lrl|)
                                         G190
                                         (COND
                                          ((OR (ATOM #13#)
                                               (PROGN
                                                (LETT |lr1| (CAR #13#))
                                                NIL)
                                               (ATOM #14#)
                                               (PROGN
                                                (LETT |rr1| (CAR #14#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #15#
                                                 (CONS
                                                  (SPADCALL |lr1| |rr1|
                                                            (QREFELT $ 101))
                                                  #15#))))
                                         (LETT #13#
                                               (PROG1 (CDR #13#)
                                                 (LETT #14# (CDR #14#))))
                                         (GO G190) G191
                                         (EXIT (NREVERSE #15#))))
                                   (QREFELT $ 156))
                         (QREFELT $ 151)))
                  (COND
                   ((EQL (- |d| |j|) (|XPFACT;my_degree| |rs| $))
                    (SEQ (LETT |ts| (SPADCALL |rs| (QREFELT $ 23)))
                         (LETT |rp|
                               (SPADCALL |rp|
                                         (|XPFACT;XDP_to_YDP|
                                          (|SPADfirst| |ts|) $)
                                         (QREFELT $ 109)))
                         (EXIT (LETT |rs| (|SPADfirst| (CDR |ts|)))))))
                  (LETT |lf1| (SPADCALL |rp| |rw| (QREFELT $ 103)))
                  (LETT |rp|
                        (SPADCALL |rp| (SPADCALL |lf1| |rfy| (QREFELT $ 101))
                                  (QREFELT $ 102)))
                  (LETT |eqs|
                        (SPADCALL |eqs| (SPADCALL |rp| (QREFELT $ 153))
                                  (QREFELT $ 154)))
                  (EXIT (LETT |lrl| (CONS |lf1| |lrl|))))
                 (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
          (LETT |rrl1| |rrl|)
          (COND
           ((> |d2| |d1|)
            (SEQ (LETT |j| (+ |md| 1)) (LETT #11# |d2|) G190
                 (COND ((> |j| #11#) (GO G191)))
                 (SEQ
                  (LETT |rp|
                        (SPADCALL
                         (SPADCALL (ELT $ 109)
                                   (PROGN
                                    (LETT #10# NIL)
                                    (SEQ (LETT |rr1| NIL) (LETT #9# |rrl1|)
                                         (LETT |lr1| NIL) (LETT #8# |lrl|) G190
                                         (COND
                                          ((OR (ATOM #8#)
                                               (PROGN
                                                (LETT |lr1| (CAR #8#))
                                                NIL)
                                               (ATOM #9#)
                                               (PROGN
                                                (LETT |rr1| (CAR #9#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #10#
                                                 (CONS
                                                  (SPADCALL |lr1| |rr1|
                                                            (QREFELT $ 101))
                                                  #10#))))
                                         (LETT #8#
                                               (PROG1 (CDR #8#)
                                                 (LETT #9# (CDR #9#))))
                                         (GO G190) G191
                                         (EXIT (NREVERSE #10#))))
                                   (QREFELT $ 156))
                         (QREFELT $ 151)))
                  (COND
                   ((EQL (- |d| |j|) (|XPFACT;my_degree| |rs| $))
                    (SEQ (LETT |ts| (SPADCALL |rs| (QREFELT $ 23)))
                         (LETT |rp|
                               (SPADCALL |rp|
                                         (|XPFACT;XDP_to_YDP|
                                          (|SPADfirst| |ts|) $)
                                         (QREFELT $ 109)))
                         (EXIT (LETT |rs| (|SPADfirst| (CDR |ts|)))))))
                  (LETT |rf1| (SPADCALL |rp| |lw| (QREFELT $ 97)))
                  (LETT |rf1|
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 75) |lc| (QREFELT $ 83))
                         |rf1| (QREFELT $ 100)))
                  (LETT |rp|
                        (SPADCALL |rp| (SPADCALL |lfy| |rf1| (QREFELT $ 101))
                                  (QREFELT $ 102)))
                  (LETT |eqs|
                        (SPADCALL |eqs| (SPADCALL |rp| (QREFELT $ 153))
                                  (QREFELT $ 154)))
                  (LETT |rrl| (SPADCALL |rrl| |rf1| (QREFELT $ 155)))
                  (EXIT
                   (LETT |rrl1|
                         (CDR (SPADCALL |rrl1| |rf1| (QREFELT $ 155))))))
                 (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
          (SEQ (LETT |j| (+ (MAX |d1| |d2|) 1)) (LETT #6# |d|) G190
               (COND ((> |j| #6#) (GO G191)))
               (SEQ
                (LETT |rp|
                      (SPADCALL
                       (SPADCALL (ELT $ 109)
                                 (PROGN
                                  (LETT #5# NIL)
                                  (SEQ (LETT |rr1| NIL) (LETT #4# |rrl1|)
                                       (LETT |lr1| NIL) (LETT #3# |lrl|) G190
                                       (COND
                                        ((OR (ATOM #3#)
                                             (PROGN (LETT |lr1| (CAR #3#)) NIL)
                                             (ATOM #4#)
                                             (PROGN
                                              (LETT |rr1| (CAR #4#))
                                              NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #5#
                                               (CONS
                                                (SPADCALL |lr1| |rr1|
                                                          (QREFELT $ 101))
                                                #5#))))
                                       (LETT #3#
                                             (PROG1 (CDR #3#)
                                               (LETT #4# (CDR #4#))))
                                       (GO G190) G191 (EXIT (NREVERSE #5#))))
                                 (QREFELT $ 156))
                       (QREFELT $ 151)))
                (COND
                 ((EQL (- |d| |j|) (|XPFACT;my_degree| |rs| $))
                  (SEQ (LETT |ts| (SPADCALL |rs| (QREFELT $ 23)))
                       (LETT |rp|
                             (SPADCALL |rp|
                                       (|XPFACT;XDP_to_YDP| (|SPADfirst| |ts|)
                                        $)
                                       (QREFELT $ 109)))
                       (EXIT (LETT |rs| (|SPADfirst| (CDR |ts|)))))))
                (LETT |eqs|
                      (SPADCALL |eqs| (SPADCALL |rp| (QREFELT $ 153))
                                (QREFELT $ 154)))
                (EXIT (LETT |rrl1| (CDR |rrl1|))))
               (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (COND
            ((NULL |eqs|)
             (COND
              ((NULL |ls|)
               (SEQ
                (LETT |lf|
                      (SPADCALL |lf|
                                (|XPFACT;eval_YDP|
                                 (SPADCALL (ELT $ 109) |lrl| (QREFELT $ 156))
                                 NIL NIL $)
                                (QREFELT $ 31)))
                (LETT |rf|
                      (SPADCALL |rf|
                                (|XPFACT;eval_YDP|
                                 (SPADCALL (ELT $ 109) |rrl| (QREFELT $ 156))
                                 NIL NIL $)
                                (QREFELT $ 31)))
                (EXIT (CONS 0 (LIST |lf| |rf|)))))
              (#26='T (|error| "impossible"))))
            ((NULL |ls|) (CONS 2 "failed"))
            (|alg_case|
             (COND
              ((SPADCALL (LENGTH |ls|) 1 (QREFELT $ 157))
               (|error| "impossible"))
              (#26#
               (SEQ (LETT |au| (|XPFACT;dc_fact11| |lf| |lrl| |eqs| $))
                    (EXIT
                     (COND ((QEQCAR |au| 1) (CONS 2 "failed"))
                           (#26# (CONS 1 (QCDR |au|)))))))))
            (#26#
             (SEQ
              (LETT |lsol|
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |eq| NIL) (LETT #1# |eqs|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |eq| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS (SPADCALL |eq| (QREFELT $ 87)) #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     |ls| (QREFELT $ 161)))
              (LETT |sol| (|XPFACT;get_rational_solution| |lsol| |ls| $))
              (EXIT
               (COND
                ((NULL |sol|)
                 (COND
                  (|alg_case2|
                   (SEQ (LETT |alg_sym| (|SPADfirst| |ls|))
                        (LETT |ls| (CDR |ls|))
                        (LETT |solu|
                              (|XPFACT;get_algebraic_solution| |lsol| |alg_sym|
                               |ls| $))
                        (EXIT
                         (COND ((QEQCAR |solu| 1) (CONS 2 "failed"))
                               (#26#
                                (SEQ (LETT |solr| (QCDR |solu|))
                                     (EXIT
                                      (CONS 1
                                            (|XPFACT;dc_fact12| |lf| |lrl|
                                             (QCAR |solr|) (QCDR |solr|) |ls|
                                             $)))))))))
                  (#26# (CONS 2 "failed"))))
                (#26#
                 (SEQ
                  (LETT |lf|
                        (SPADCALL |lf|
                                  (|XPFACT;eval_YDP|
                                   (SPADCALL (ELT $ 109) |lrl| (QREFELT $ 156))
                                   |ls| |sol| $)
                                  (QREFELT $ 31)))
                  (LETT |rf|
                        (SPADCALL |rf|
                                  (|XPFACT;eval_YDP|
                                   (SPADCALL (ELT $ 109) |rrl| (QREFELT $ 156))
                                   |ls| |sol| $)
                                  (QREFELT $ 31)))
                  (EXIT (CONS 0 (LIST |lf| |rf|)))))))))))))) 

(SDEFUN |XPFACT;factor;XdpL;25|
        ((|p| (|XDistributedPolynomial| |vl| F))
         ($ (|List| (|XDistributedPolynomial| |vl| F))))
        (SPROG
         ((|rf| #1=(|List| (|XDistributedPolynomial| |vl| F)))
          (|d| (|NonNegativeInteger|)) (#2=#:G1073 NIL) (|rf0| #1#)
          (|p1| (|XDistributedPolynomial| |vl| F))
          (|lf| (|List| (|XDistributedPolynomial| |vl| F)))
          (|rs| #3=(|XDistributedPolynomial| |vl| F))
          (|ts| (|List| (|XDistributedPolynomial| |vl| F))) (|lc| (F))
          (|res| (|List| (|XDistributedPolynomial| |vl| F))) (#4=#:G1085 NIL)
          (|d1| (|NonNegativeInteger|)) (#5=#:G1070 NIL)
          (|pu| (|Union| (|XDistributedPolynomial| |vl| F) "failed"))
          (|f1| (|XDistributedPolynomial| |vl| F)) (#6=#:G1068 NIL)
          (|fl| (|List| (|XDistributedPolynomial| |vl| F)))
          (|fu|
           (|Union| (|List| (|XDistributedPolynomial| |vl| F))
                    (|XDistributedPolynomial| |vl| F) "failed"))
          (|tp| #3#) (#7=#:G1065 NIL) (|dd| (|Integer|)))
         (SEQ (LETT |dd| (|XPFACT;my_degree| |p| $))
              (EXIT
               (COND ((<= |dd| 1) (LIST |p|))
                     ('T
                      (SEQ
                       (LETT |d|
                             (PROG1 (LETT #7# |dd|)
                               (|check_subtype2| (>= #7# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #7#)))
                       (LETT |ts| (SPADCALL |p| (QREFELT $ 23)))
                       (LETT |tp| (|SPADfirst| |ts|))
                       (LETT |rs| (|SPADfirst| (CDR |ts|)))
                       (LETT |lc| (SPADCALL |tp| (QREFELT $ 25)))
                       (LETT |tp|
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 13) |lc|
                                        (QREFELT $ 26))
                              |tp| (QREFELT $ 28)))
                       (LETT |rf| (SPADCALL |tp| (QREFELT $ 50)))
                       (LETT |rf0| |rf|) (LETT |lf| NIL) (LETT |res| NIL)
                       (SEQ
                        (EXIT
                         (SEQ G190 NIL
                              (SEQ
                               (LETT |lf|
                                     (SPADCALL |lf| (|SPADfirst| |rf|)
                                               (QREFELT $ 162)))
                               (LETT |rf| (CDR |rf|))
                               (EXIT
                                (COND
                                 ((NULL |rf|)
                                  (SEQ (LETT |res| (CONS |p| |res|))
                                       (EXIT
                                        (PROGN (LETT #4# 1) (GO #8=#:G1081)))))
                                 ('T
                                  (SEQ
                                   (LETT |fu|
                                         (|XPFACT;dc_fact1| |d| |lc| |lf| |rf|
                                          |rs| $))
                                   (COND
                                    ((QEQCAR |fu| 0)
                                     (SEQ (LETT |fl| (QCDR |fu|))
                                          (LETT |res|
                                                (CONS (|SPADfirst| |fl|)
                                                      |res|))
                                          (LETT |p| (|SPADfirst| (CDR |fl|)))
                                          (LETT |ts|
                                                (SPADCALL |p| (QREFELT $ 23)))
                                          (LETT |lc|
                                                (SPADCALL |p| (QREFELT $ 25)))
                                          (LETT |d|
                                                (PROG1
                                                    (LETT #6#
                                                          (|XPFACT;my_degree|
                                                           |p| $))
                                                  (|check_subtype2| (>= #6# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #6#)))
                                          (LETT |rs| (|SPADfirst| (CDR |ts|)))
                                          (LETT |lf| NIL)
                                          (EXIT (LETT |rf0| |rf|)))))
                                   (EXIT
                                    (COND
                                     ((QEQCAR |fu| 1)
                                      (SEQ (LETT |f1| (QCDR |fu|))
                                           (LETT |pu|
                                                 (|XPFACT;lexquo| |p| |f1| $))
                                           (EXIT
                                            (COND
                                             ((QEQCAR |pu| 1)
                                              (|error| "lexquo(p, f1)"))
                                             ('T
                                              (SEQ (LETT |p1| (QCDR |pu|))
                                                   (LETT |d1|
                                                         (PROG1
                                                             (LETT #5#
                                                                   (|XPFACT;my_degree|
                                                                    |p1| $))
                                                           (|check_subtype2|
                                                            (>= #5# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #5#)))
                                                   (EXIT
                                                    (COND
                                                     ((EQL |d1| 0)
                                                      (SEQ
                                                       (LETT |res|
                                                             (CONS |p| |res|))
                                                       (EXIT
                                                        (PROGN
                                                         (LETT #4# |$NoValue|)
                                                         (GO #8#)))))
                                                     ('T
                                                      (SEQ (LETT |p| |p1|)
                                                           (LETT |res|
                                                                 (CONS |f1|
                                                                       |res|))
                                                           (LETT |lc|
                                                                 (SPADCALL |p|
                                                                           (QREFELT
                                                                            $
                                                                            25)))
                                                           (LETT |ts|
                                                                 (SPADCALL |p|
                                                                           (QREFELT
                                                                            $
                                                                            23)))
                                                           (LETT |rs|
                                                                 (|SPADfirst|
                                                                  (CDR |ts|)))
                                                           (LETT |lf| NIL)
                                                           (SEQ G190
                                                                (COND
                                                                 ((NULL
                                                                   (> |d|
                                                                      |d1|))
                                                                  (GO G191)))
                                                                (SEQ
                                                                 (LETT |p1|
                                                                       (|SPADfirst|
                                                                        |rf0|))
                                                                 (LETT |rf0|
                                                                       (CDR
                                                                        |rf0|))
                                                                 (EXIT
                                                                  (LETT |d|
                                                                        (PROG1
                                                                            (LETT
                                                                             #2#
                                                                             (-
                                                                              |d|
                                                                              (SPADCALL
                                                                               |p1|
                                                                               (QREFELT
                                                                                $
                                                                                15))))
                                                                          (|check_subtype2|
                                                                           (>=
                                                                            #2#
                                                                            0)
                                                                           '(|NonNegativeInteger|)
                                                                           '(|Integer|)
                                                                           #2#)))))
                                                                NIL (GO G190)
                                                                G191
                                                                (EXIT NIL))
                                                           (EXIT
                                                            (COND
                                                             ((< |d| |d1|)
                                                              (|error|
                                                               "d < d1"))
                                                             ('T
                                                              (LETT |rf|
                                                                    |rf0|)))))))))))))))))))))
                              NIL (GO G190) G191 (EXIT NIL)))
                        #8# (EXIT #4#))
                       (EXIT (REVERSE |res|))))))))) 

(DECLAIM (NOTINLINE |XPolynomialFactor;|)) 

(DEFUN |XPolynomialFactor| (&REST #1=#:G1086)
  (SPROG NIL
         (PROG (#2=#:G1087)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|XPolynomialFactor|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |XPolynomialFactor;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|XPolynomialFactor|)))))))))) 

(DEFUN |XPolynomialFactor;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|XPolynomialFactor| DV$1 DV$2))
          (LETT $ (GETREFV 164))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|PolynomialFactorizationExplicit|))))))
          (|haddProp| |$ConstructorCache| '|XPolynomialFactor| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 124 (SPADCALL (QREFELT $ 123)))
             (QSETREFV $ 163
                       (CONS (|dispatchFunction| |XPFACT;factor;XdpL;25|)
                             $)))))
          $))) 

(MAKEPROP '|XPolynomialFactor| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |Zero|) (|XDistributedPolynomial| 6 7) (4 . |Zero|)
              (|Boolean|) (8 . =) (14 . |One|) (|NonNegativeInteger|)
              (18 . |degree|) (|Record| (|:| |k| 19) (|:| |c| 7)) (|List| 16)
              (23 . |listOfTerms|) (|FreeMonoid| 6) (28 . |length|)
              (33 . |construct|) (|List| 9) |XPFACT;top_split;XdpL;2|
              (38 . |maxdeg|) (43 . |leadingCoefficient|) (48 . /)
              (54 . |lquo|) (60 . *) (66 . *) (72 . -) (78 . +)
              (|Record| (|:| |quotient| 9) (|:| |remainder| 9))
              |XPFACT;ldivide;2XdpR;3| (84 . |One|) (88 . ~=)
              (|Record| (|:| |g| 9) (|:| |c1| 9) (|:| |c2| 9) (|:| |cu| 9)
                        (|:| |cv| 9))
              (|Union| 36 '"failed") |XPFACT;left_ext_GCD;2XdpU;5|
              (94 . |numberOfMonomials|) (99 . |One|) (103 . |first|)
              (108 . |coerce|) (113 . *) (119 . |rest|) (|Union| $ '"failed")
              (124 . |exquo|) (130 . |rquo|) (|Integer|) (136 . ~=)
              |XPFACT;homo_fact;XdpL;7| (|Polynomial| 7) (142 . |coerce|)
              (|Record| (|:| |k| 19) (|:| |c| 51)) (|List| 53)
              (|XDistributedPolynomial| 6 51) (147 . |construct|)
              (152 . |listOfTerms|) (|List| 89) (|List| 7) (157 . |eval|)
              (164 . |ground|) (169 . =) (|SparseUnivariatePolynomial| 7)
              (175 . |Zero|) (179 . ~=) (185 . |leadingCoefficient|)
              (190 . |degree|) (195 . |coerce|) (200 . |reductum|)
              (|Fraction| 51) (205 . |numer|) (210 . |denom|) (|Equation| 70)
              (215 . |lhs|) (220 . |One|) (224 . ~=) (230 . |totalDegree|)
              (235 . |reductum|) (240 . |Zero|) (244 . |rhs|) (249 . |ground?|)
              (254 . |leadingCoefficient|) (259 . /) (|Fraction| 48)
              (265 . |One|) (269 . *) (275 . |coerce|) (280 . |variables|)
              (|Symbol|) (285 . ~=) (291 . -) (297 . =) (303 . |last|)
              (308 . |first|) (314 . |rest|) (320 . =) (326 . |lquo|)
              (332 . |Zero|) (336 . =) (342 . *) (348 . *) (354 . -)
              (360 . |rquo|) (366 . |maxdeg|) (371 . <) (377 . |new|)
              (381 . |monomial|) (388 . |coefficient|) (394 . +) (400 . +)
              (406 . >=) (412 . |lquo|) (418 . *) (424 . |rquo|) (430 . -)
              (436 . -) (442 . |One|) (446 . -) (|Union| 89 '#1="none")
              (|Record| (|:| |l_fac| 55) (|:| |r_fac| 55) (|:| |residual| 55)
                        (|:| |nsym| 119))
              |XPFACT;lift1;FmXdpIFmXdpIFXdpBR;21| (|SingletonAsOrderedSet|)
              (451 . |create|) '|dummy| (455 . |univariate|) (|List| $)
              (460 . |gcd|) (|Factored| $) (465 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 130) (|:| |factor| 63) (|:| |exponent| 14))
              (|List| 131) (|Factored| 63) (470 . |factorList|) (|List| 48)
              (475 . |min|) (480 . |constant|) (485 . -) (490 . |coefficient|)
              (496 . |monomial|) (502 . |coerce|) (507 . |One|) (511 . /)
              (517 . -) (523 . *) (529 . |eval|) (|Mapping| 55 55 55)
              (|List| 55) (536 . |reduce|) (543 . |concat|) (549 . -)
              (|List| 51) (554 . |coefficients|) (559 . |concat|)
              (565 . |concat|) (571 . |reduce|) (577 . ~=) (|List| (|List| 73))
              (|List| 70) (|SystemSolvePackage| 7) (583 . |solve|)
              (589 . |concat|) (595 . |factor|))
           '#(|top_split| 600 |lift1| 605 |left_ext_GCD| 618 |ldivide| 624
              |homo_fact| 630 |factor| 635)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|homo_fact|
                                 ((|List| (|XDistributedPolynomial| |#1| |#2|))
                                  (|XDistributedPolynomial| |#1| |#2|)))
                                T)
                              '((|top_split|
                                 ((|List| (|XDistributedPolynomial| |#1| |#2|))
                                  (|XDistributedPolynomial| |#1| |#2|)))
                                T)
                              '((|left_ext_GCD|
                                 ((|Union|
                                   (|Record|
                                    (|:| |g|
                                         (|XDistributedPolynomial| |#1| |#2|))
                                    (|:| |c1|
                                         (|XDistributedPolynomial| |#1| |#2|))
                                    (|:| |c2|
                                         (|XDistributedPolynomial| |#1| |#2|))
                                    (|:| |cu|
                                         (|XDistributedPolynomial| |#1| |#2|))
                                    (|:| |cv|
                                         (|XDistributedPolynomial| |#1| |#2|)))
                                   "failed")
                                  (|XDistributedPolynomial| |#1| |#2|)
                                  (|XDistributedPolynomial| |#1| |#2|)))
                                T)
                              '((|ldivide|
                                 ((|Record|
                                   (|:| |quotient|
                                        (|XDistributedPolynomial| |#1| |#2|))
                                   (|:| |remainder|
                                        (|XDistributedPolynomial| |#1| |#2|)))
                                  (|XDistributedPolynomial| |#1| |#2|)
                                  (|XDistributedPolynomial| |#1| |#2|)))
                                T)
                              '((|lift1|
                                 ((|Record|
                                   (|:| |l_fac|
                                        (|XDistributedPolynomial| |#1|
                                                                  (|Polynomial|
                                                                   |#2|)))
                                   (|:| |r_fac|
                                        (|XDistributedPolynomial| |#1|
                                                                  (|Polynomial|
                                                                   |#2|)))
                                   (|:| |residual|
                                        (|XDistributedPolynomial| |#1|
                                                                  (|Polynomial|
                                                                   |#2|)))
                                   (|:| |nsym| (|Union| (|Symbol|) #1#)))
                                  (|FreeMonoid| |#1|)
                                  (|XDistributedPolynomial| |#1|
                                                            (|Polynomial|
                                                             |#2|))
                                  (|Integer|) (|FreeMonoid| |#1|)
                                  (|XDistributedPolynomial| |#1|
                                                            (|Polynomial|
                                                             |#2|))
                                  (|Integer|) |#2|
                                  (|XDistributedPolynomial| |#1|
                                                            (|Polynomial|
                                                             |#2|))
                                  (|Boolean|)))
                                T)
                              '((|factor|
                                 ((|List| (|XDistributedPolynomial| |#1| |#2|))
                                  (|XDistributedPolynomial| |#1| |#2|)))
                                (|has| 7 (|PolynomialFactorizationExplicit|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 163
                                            '(0 7 0 8 0 9 0 10 2 9 11 0 0 12 0
                                              7 0 13 1 9 14 0 15 1 9 17 0 18 1
                                              19 14 0 20 1 9 0 17 21 1 9 19 0
                                              24 1 9 7 0 25 2 7 0 0 0 26 2 9 0
                                              0 19 27 2 9 0 7 0 28 2 9 0 0 0 29
                                              2 9 0 0 0 30 2 9 0 0 0 31 0 9 0
                                              34 2 9 11 0 0 35 1 9 14 0 39 0 19
                                              0 40 1 19 6 0 41 1 19 0 6 42 2 19
                                              0 0 0 43 1 19 0 0 44 2 14 45 0 0
                                              46 2 9 0 0 19 47 2 48 11 0 0 49 1
                                              51 0 7 52 1 55 0 54 56 1 55 54 0
                                              57 3 51 0 0 58 59 60 1 51 7 0 61
                                              2 7 11 0 0 62 0 63 0 64 2 63 11 0
                                              0 65 1 63 7 0 66 1 63 14 0 67 1 9
                                              0 7 68 1 63 0 0 69 1 70 51 0 71 1
                                              70 51 0 72 1 73 70 0 74 0 51 0 75
                                              2 51 11 0 0 76 1 51 14 0 77 1 51
                                              0 0 78 0 51 0 79 1 73 70 0 80 1
                                              51 11 0 81 1 51 7 0 82 2 51 0 0 7
                                              83 0 84 0 85 2 51 0 0 7 86 1 70 0
                                              51 87 1 51 58 0 88 2 89 11 0 0 90
                                              2 70 0 0 0 91 2 58 11 0 0 92 1 22
                                              9 0 93 2 22 0 0 14 94 2 22 0 0 14
                                              95 2 22 11 0 0 96 2 55 0 0 19 97
                                              0 55 0 98 2 55 11 0 0 99 2 55 0
                                              51 0 100 2 55 0 0 0 101 2 55 0 0
                                              0 102 2 55 0 0 19 103 1 55 19 0
                                              104 2 19 11 0 0 105 0 89 0 106 3
                                              51 0 0 89 14 107 2 55 51 0 19 108
                                              2 55 0 0 0 109 2 51 0 0 0 110 2
                                              19 11 0 0 111 2 19 45 0 0 112 2
                                              51 0 7 0 113 2 19 45 0 0 114 2 7
                                              0 0 0 115 2 51 0 0 0 116 0 70 0
                                              117 1 51 0 0 118 0 122 0 123 1 51
                                              63 0 125 1 63 0 126 127 1 63 128
                                              0 129 1 133 132 0 134 1 135 48 0
                                              136 1 55 51 0 137 1 63 0 0 138 2
                                              63 7 0 14 139 2 63 0 7 14 140 1
                                              63 0 7 141 0 63 0 142 2 63 0 0 7
                                              143 2 63 0 0 0 144 2 63 0 7 0 145
                                              3 63 0 0 122 0 146 3 148 55 147 0
                                              55 149 2 135 0 0 48 150 1 55 0 0
                                              151 1 55 152 0 153 2 152 0 0 0
                                              154 2 148 0 0 55 155 2 148 55 147
                                              0 156 2 14 11 0 0 157 2 160 158
                                              159 58 161 2 22 0 0 9 162 1 0 22
                                              9 163 1 0 22 9 23 9 0 120 19 55
                                              48 19 55 48 7 55 11 121 2 0 37 9
                                              9 38 2 0 32 9 9 33 1 0 22 9 50 1
                                              1 22 9 163)))))
           '|lookupComplete|)) 

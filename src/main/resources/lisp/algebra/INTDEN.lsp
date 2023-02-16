
(SDEFUN |INTDEN;li_factors|
        ((|df| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|lk| (|List| (|Kernel| F))) (|x| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |cfactor| (|SparseUnivariatePolynomial| F))
                     (|:| |ufun| F) (|:| |vfun| F) (|:| |den| (|Integer|))))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |cfactor| (|SparseUnivariatePolynomial| F))
                      (|:| |ufun| F) (|:| |vfun| F) (|:| |den| (|Integer|)))))
          (|f2| (|SparseUnivariatePolynomial| F)) (|k2| (F)) (#1=#:G840 NIL)
          (|c| NIL) (#2=#:G841 NIL) (|ki| NIL) (#3=#:G839 NIL) (|u1| (F))
          (#4=#:G837 NIL) (|ui| NIL) (#5=#:G838 NIL) (#6=#:G836 NIL)
          (|d| #7=(|Integer|))
          (|cd| (|Record| (|:| |num| (|List| (|Integer|))) (|:| |den| #7#)))
          (|sv| (|Vector| (|Fraction| (|Integer|))))
          (|su| (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
          (|ulst| (|List| F)) (#8=#:G835 NIL) (|kk| NIL) (#9=#:G834 NIL)
          (|dvvec| (|Vector| F)) (#10=#:G833 NIL) (#11=#:G832 NIL)
          (|vlst| (|List| F)) (#12=#:G831 NIL) (#13=#:G830 NIL) (|rsum| (F))
          (|deg1| (|NonNegativeInteger|))
          (|f1| #14=(|SparseUnivariatePolynomial| F)) (#15=#:G829 NIL)
          (|fac| NIL) (|u0| (F)) (|dummy| (|SingletonAsOrderedSet|))
          (|lfac|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #14#)
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ
          (LETT |lfac|
                (SPADCALL (SPADCALL |df| (QREFELT $ 11)) (QREFELT $ 15)))
          (LETT |res| NIL) (LETT |dummy| (SPADCALL (QREFELT $ 17)))
          (LETT |vlst| NIL)
          (LETT |u0| (SPADCALL (SPADCALL |k| (QREFELT $ 20)) 1 (QREFELT $ 22)))
          (SEQ (LETT |fac| NIL) (LETT #15# |lfac|) G190
               (COND
                ((OR (ATOM #15#) (PROGN (LETT |fac| (CAR #15#)) NIL))
                 (GO G191)))
               (SEQ (LETT |f1| (QVELT |fac| 1))
                    (LETT |f1|
                          (SPADCALL
                           (SPADCALL (SPADCALL |f1| (QREFELT $ 23))
                                     (QREFELT $ 24))
                           |f1| (QREFELT $ 25)))
                    (LETT |deg1| (SPADCALL |f1| (QREFELT $ 27)))
                    (EXIT
                     (COND ((EQL |deg1| 0) "iterate")
                           ((SPADCALL
                             (CONS #'|INTDEN;li_factors!0| (VECTOR $ |x|))
                             (SPADCALL |f1| (QREFELT $ 34)) (QREFELT $ 36))
                            (LETT |res|
                                  (CONS
                                   (VECTOR |f1| |f1| |u0| (|spadConstant| $ 29)
                                           1)
                                   |res|)))
                           ((NULL |lk|) "iterate")
                           ('T
                            (SEQ
                             (LETT |rsum|
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |deg1| (QREFELT $ 37))
                                              (QREFELT $ 24))
                                    (SPADCALL |f1| (- |deg1| 1) (QREFELT $ 40))
                                    (QREFELT $ 41)))
                             (COND
                              ((> |deg1| 1)
                               (LETT |f2|
                                     (SPADCALL |f1| |dummy|
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 39)
                                                          1 (QREFELT $ 42))
                                                (SPADCALL |rsum|
                                                          (QREFELT $ 43))
                                                (QREFELT $ 44))
                                               (QREFELT $ 45)))))
                             (COND
                              ((> |deg1| 1)
                               (COND
                                ((NULL
                                  (SPADCALL
                                   (CONS #'|INTDEN;li_factors!1|
                                         (VECTOR $ |x|))
                                   (SPADCALL |f2| (QREFELT $ 34))
                                   (QREFELT $ 36)))
                                 (EXIT "iterate")))))
                             (COND
                              ((NULL |vlst|)
                               (SEQ
                                (LETT |vlst|
                                      (PROGN
                                       (LETT #13# NIL)
                                       (SEQ (LETT |kk| NIL) (LETT #12# |lk|)
                                            G190
                                            (COND
                                             ((OR (ATOM #12#)
                                                  (PROGN
                                                   (LETT |kk| (CAR #12#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #13#
                                                    (CONS
                                                     (COND
                                                      ((SPADCALL |kk| '|log|
                                                                 (QREFELT $
                                                                          46))
                                                       (SPADCALL |kk|
                                                                 (QREFELT $
                                                                          48)))
                                                      ('T
                                                       (SPADCALL
                                                        (SPADCALL |kk|
                                                                  (QREFELT $
                                                                           20))
                                                        1 (QREFELT $ 22))))
                                                     #13#))))
                                            (LETT #12# (CDR #12#)) (GO G190)
                                            G191 (EXIT (NREVERSE #13#)))))
                                (LETT |dvvec|
                                      (SPADCALL
                                       (PROGN
                                        (LETT #11# NIL)
                                        (SEQ (LETT |c| NIL) (LETT #10# |vlst|)
                                             G190
                                             (COND
                                              ((OR (ATOM #10#)
                                                   (PROGN
                                                    (LETT |c| (CAR #10#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT #11#
                                                     (CONS
                                                      (SPADCALL |c| |x|
                                                                (QREFELT $ 31))
                                                      #11#))))
                                             (LETT #10# (CDR #10#)) (GO G190)
                                             G191 (EXIT (NREVERSE #11#))))
                                       (QREFELT $ 50)))
                                (EXIT
                                 (LETT |ulst|
                                       (PROGN
                                        (LETT #9# NIL)
                                        (SEQ (LETT |kk| NIL) (LETT #8# |lk|)
                                             G190
                                             (COND
                                              ((OR (ATOM #8#)
                                                   (PROGN
                                                    (LETT |kk| (CAR #8#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT #9#
                                                     (CONS
                                                      (COND
                                                       ((SPADCALL |kk| '|log|
                                                                  (QREFELT $
                                                                           46))
                                                        (SPADCALL
                                                         (SPADCALL |kk|
                                                                   (QREFELT $
                                                                            20))
                                                         1 (QREFELT $ 22)))
                                                       ('T
                                                        (SPADCALL |kk|
                                                                  (QREFELT $
                                                                           48))))
                                                      #9#))))
                                             (LETT #8# (CDR #8#)) (GO G190)
                                             G191 (EXIT (NREVERSE #9#)))))))))
                             (LETT |su|
                                   (SPADCALL |dvvec|
                                             (SPADCALL |rsum| |x|
                                                       (QREFELT $ 31))
                                             (QREFELT $ 53)))
                             (EXIT
                              (COND ((QEQCAR |su| 1) "iterate")
                                    ('T
                                     (SEQ (LETT |sv| (QCDR |su|))
                                          (LETT |cd|
                                                (SPADCALL |sv| (QREFELT $ 57)))
                                          (LETT |d| (QCDR |cd|))
                                          (EXIT
                                           (COND
                                            ((SPADCALL |d| 1 (QREFELT $ 58))
                                             "iterate")
                                            ('T
                                             (SEQ
                                              (LETT |u1|
                                                    (SPADCALL (ELT $ 41)
                                                              (PROGN
                                                               (LETT #6# NIL)
                                                               (SEQ
                                                                (LETT |ki| NIL)
                                                                (LETT #5#
                                                                      (QCAR
                                                                       |cd|))
                                                                (LETT |ui| NIL)
                                                                (LETT #4#
                                                                      |ulst|)
                                                                G190
                                                                (COND
                                                                 ((OR
                                                                   (ATOM #4#)
                                                                   (PROGN
                                                                    (LETT |ui|
                                                                          (CAR
                                                                           #4#))
                                                                    NIL)
                                                                   (ATOM #5#)
                                                                   (PROGN
                                                                    (LETT |ki|
                                                                          (CAR
                                                                           #5#))
                                                                    NIL))
                                                                  (GO G191)))
                                                                (SEQ
                                                                 (EXIT
                                                                  (LETT #6#
                                                                        (CONS
                                                                         (SPADCALL
                                                                          |ui|
                                                                          |ki|
                                                                          (QREFELT
                                                                           $
                                                                           59))
                                                                         #6#))))
                                                                (LETT #4#
                                                                      (PROG1
                                                                          (CDR
                                                                           #4#)
                                                                        (LETT
                                                                         #5#
                                                                         (CDR
                                                                          #5#))))
                                                                (GO G190) G191
                                                                (EXIT
                                                                 (NREVERSE
                                                                  #6#))))
                                                              (QREFELT $ 61)))
                                              (LETT |k2|
                                                    (SPADCALL (ELT $ 62)
                                                              (PROGN
                                                               (LETT #3# NIL)
                                                               (SEQ
                                                                (LETT |ki| NIL)
                                                                (LETT #2#
                                                                      (QCAR
                                                                       |cd|))
                                                                (LETT |c| NIL)
                                                                (LETT #1#
                                                                      |vlst|)
                                                                G190
                                                                (COND
                                                                 ((OR
                                                                   (ATOM #1#)
                                                                   (PROGN
                                                                    (LETT |c|
                                                                          (CAR
                                                                           #1#))
                                                                    NIL)
                                                                   (ATOM #2#)
                                                                   (PROGN
                                                                    (LETT |ki|
                                                                          (CAR
                                                                           #2#))
                                                                    NIL))
                                                                  (GO G191)))
                                                                (SEQ
                                                                 (EXIT
                                                                  (LETT #3#
                                                                        (CONS
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            |ki|
                                                                            (QREFELT
                                                                             $
                                                                             63))
                                                                           (QREFELT
                                                                            $
                                                                            64))
                                                                          |c|
                                                                          (QREFELT
                                                                           $
                                                                           41))
                                                                         #3#))))
                                                                (LETT #1#
                                                                      (PROG1
                                                                          (CDR
                                                                           #1#)
                                                                        (LETT
                                                                         #2#
                                                                         (CDR
                                                                          #2#))))
                                                                (GO G190) G191
                                                                (EXIT
                                                                 (NREVERSE
                                                                  #3#))))
                                                              (QREFELT $ 61)))
                                              (LETT |f2|
                                                    (SPADCALL |f1| |dummy|
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (|spadConstant|
                                                                 $ 39)
                                                                1
                                                                (QREFELT $ 42))
                                                               (SPADCALL |k2|
                                                                         (QREFELT
                                                                          $
                                                                          43))
                                                               (QREFELT $ 44))
                                                              (QREFELT $ 45)))
                                              (COND
                                               ((NULL
                                                 (SPADCALL
                                                  (CONS #'|INTDEN;li_factors!2|
                                                        (VECTOR $ |x|))
                                                  (SPADCALL |f2|
                                                            (QREFELT $ 34))
                                                  (QREFELT $ 36)))
                                                (EXIT
                                                 (|error| "Impossible 1"))))
                                              (EXIT
                                               (LETT |res|
                                                     (CONS
                                                      (VECTOR |f1| |f2|
                                                              (SPADCALL
                                                               (SPADCALL |u0|
                                                                         |d|
                                                                         (QREFELT
                                                                          $
                                                                          59))
                                                               |u1|
                                                               (QREFELT $ 41))
                                                              |k2| |d|)
                                                      |res|))))))))))))))))
               (LETT #15# (CDR #15#)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(SDEFUN |INTDEN;li_factors!2| ((|c| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c| |x| (QREFELT $ 31)) (|spadConstant| $ 29)
                      (QREFELT $ 33)))))) 

(SDEFUN |INTDEN;li_factors!1| ((|c| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c| |x| (QREFELT $ 31)) (|spadConstant| $ 29)
                      (QREFELT $ 33)))))) 

(SDEFUN |INTDEN;li_factors!0| ((|c| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c| |x| (QREFELT $ 31)) (|spadConstant| $ 29)
                      (QREFELT $ 33)))))) 

(SDEFUN |INTDEN;poly_factors|
        ((|df| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|lk| (|List| (|Kernel| F))) (|x| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |cfactor| (|SparseUnivariatePolynomial| F))
                     (|:| |ufun| F) (|:| |vfun| F) (|:| |den| (|Integer|))))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |cfactor| (|SparseUnivariatePolynomial| F))
                      (|:| |ufun| F) (|:| |vfun| F) (|:| |den| (|Integer|)))))
          (|f2| (|SparseUnivariatePolynomial| F)) (|k2| (F)) (#1=#:G917 NIL)
          (|c| NIL) (#2=#:G918 NIL) (|ki| NIL) (#3=#:G916 NIL) (|u1| (F))
          (#4=#:G914 NIL) (|ui| NIL) (#5=#:G915 NIL) (#6=#:G913 NIL)
          (|d| #7=(|Integer|))
          (|cd| (|Record| (|:| |num| (|List| (|Integer|))) (|:| |den| #7#)))
          (|sv| (|Vector| (|Fraction| (|Integer|))))
          (|su| (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
          (|ulst| (|List| F)) (#8=#:G912 NIL) (|kk| NIL) (#9=#:G911 NIL)
          (|dvvec| (|Vector| F)) (#10=#:G910 NIL) (#11=#:G909 NIL)
          (|vlst| (|List| F)) (#12=#:G908 NIL) (#13=#:G907 NIL) (|lprod| (F))
          (|f1| #14=(|SparseUnivariatePolynomial| F)) (|tc| (F))
          (|deg1| (|NonNegativeInteger|)) (#15=#:G906 NIL) (|fac| NIL)
          (|v0| (F)) (|dummy| (|SingletonAsOrderedSet|))
          (|lfac|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #14#)
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ
          (LETT |lfac|
                (SPADCALL (SPADCALL |df| (QREFELT $ 11)) (QREFELT $ 15)))
          (LETT |res| NIL) (LETT |dummy| (SPADCALL (QREFELT $ 17)))
          (LETT |vlst| NIL)
          (LETT |v0| (SPADCALL (SPADCALL |k| (QREFELT $ 20)) 1 (QREFELT $ 22)))
          (SEQ (LETT |fac| NIL) (LETT #15# |lfac|) G190
               (COND
                ((OR (ATOM #15#) (PROGN (LETT |fac| (CAR #15#)) NIL))
                 (GO G191)))
               (SEQ (LETT |f1| (QVELT |fac| 1))
                    (LETT |deg1| (SPADCALL |f1| (QREFELT $ 27)))
                    (EXIT
                     (COND ((EQL |deg1| 0) "iterate")
                           ('T
                            (SEQ (LETT |tc| (SPADCALL |f1| 0 (QREFELT $ 40)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |tc| (|spadConstant| $ 29)
                                              (QREFELT $ 33))
                                    "iterate")
                                   ('T
                                    (SEQ
                                     (LETT |f1|
                                           (SPADCALL
                                            (SPADCALL |tc| (QREFELT $ 24)) |f1|
                                            (QREFELT $ 25)))
                                     (EXIT
                                      (COND
                                       ((SPADCALL
                                         (CONS #'|INTDEN;poly_factors!0|
                                               (VECTOR $ |x|))
                                         (SPADCALL |f1| (QREFELT $ 34))
                                         (QREFELT $ 36))
                                        (LETT |res|
                                              (CONS
                                               (VECTOR |f1| |f1|
                                                       (|spadConstant| $ 39)
                                                       |v0| 1)
                                               |res|)))
                                       ((NULL |lk|) "iterate")
                                       ('T
                                        (SEQ
                                         (LETT |lprod|
                                               (SPADCALL |f1| (QREFELT $ 23)))
                                         (COND
                                          ((NULL |vlst|)
                                           (SEQ
                                            (LETT |vlst|
                                                  (PROGN
                                                   (LETT #13# NIL)
                                                   (SEQ (LETT |kk| NIL)
                                                        (LETT #12# |lk|) G190
                                                        (COND
                                                         ((OR (ATOM #12#)
                                                              (PROGN
                                                               (LETT |kk|
                                                                     (CAR
                                                                      #12#))
                                                               NIL))
                                                          (GO G191)))
                                                        (SEQ
                                                         (EXIT
                                                          (LETT #13#
                                                                (CONS
                                                                 (COND
                                                                  ((SPADCALL
                                                                    |kk| '|log|
                                                                    (QREFELT $
                                                                             46))
                                                                   (SPADCALL
                                                                    |kk|
                                                                    (QREFELT $
                                                                             48)))
                                                                  ('T
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |kk|
                                                                     (QREFELT $
                                                                              20))
                                                                    1
                                                                    (QREFELT $
                                                                             22))))
                                                                 #13#))))
                                                        (LETT #12# (CDR #12#))
                                                        (GO G190) G191
                                                        (EXIT
                                                         (NREVERSE #13#)))))
                                            (LETT |dvvec|
                                                  (SPADCALL
                                                   (PROGN
                                                    (LETT #11# NIL)
                                                    (SEQ (LETT |c| NIL)
                                                         (LETT #10# |vlst|)
                                                         G190
                                                         (COND
                                                          ((OR (ATOM #10#)
                                                               (PROGN
                                                                (LETT |c|
                                                                      (CAR
                                                                       #10#))
                                                                NIL))
                                                           (GO G191)))
                                                         (SEQ
                                                          (EXIT
                                                           (LETT #11#
                                                                 (CONS
                                                                  (SPADCALL |c|
                                                                            |x|
                                                                            (QREFELT
                                                                             $
                                                                             31))
                                                                  #11#))))
                                                         (LETT #10# (CDR #10#))
                                                         (GO G190) G191
                                                         (EXIT
                                                          (NREVERSE #11#))))
                                                   (QREFELT $ 50)))
                                            (EXIT
                                             (LETT |ulst|
                                                   (PROGN
                                                    (LETT #9# NIL)
                                                    (SEQ (LETT |kk| NIL)
                                                         (LETT #8# |lk|) G190
                                                         (COND
                                                          ((OR (ATOM #8#)
                                                               (PROGN
                                                                (LETT |kk|
                                                                      (CAR
                                                                       #8#))
                                                                NIL))
                                                           (GO G191)))
                                                         (SEQ
                                                          (EXIT
                                                           (LETT #9#
                                                                 (CONS
                                                                  (COND
                                                                   ((SPADCALL
                                                                     |kk|
                                                                     '|log|
                                                                     (QREFELT $
                                                                              46))
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      |kk|
                                                                      (QREFELT
                                                                       $ 20))
                                                                     1
                                                                     (QREFELT $
                                                                              22)))
                                                                   ('T
                                                                    (SPADCALL
                                                                     |kk|
                                                                     (QREFELT $
                                                                              48))))
                                                                  #9#))))
                                                         (LETT #8# (CDR #8#))
                                                         (GO G190) G191
                                                         (EXIT
                                                          (NREVERSE
                                                           #9#)))))))))
                                         (LETT |su|
                                               (SPADCALL |dvvec|
                                                         (SPADCALL
                                                          (SPADCALL |lprod| |x|
                                                                    (QREFELT $
                                                                             31))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL |deg1|
                                                                      (QREFELT
                                                                       $ 63))
                                                            (QREFELT $ 64))
                                                           |lprod|
                                                           (QREFELT $ 41))
                                                          (QREFELT $ 65))
                                                         (QREFELT $ 53)))
                                         (EXIT
                                          (COND ((QEQCAR |su| 1) "iterate")
                                                ('T
                                                 (SEQ (LETT |sv| (QCDR |su|))
                                                      (LETT |cd|
                                                            (SPADCALL |sv|
                                                                      (QREFELT
                                                                       $ 57)))
                                                      (LETT |d| (QCDR |cd|))
                                                      (EXIT
                                                       (COND
                                                        ((SPADCALL |d| 1
                                                                   (QREFELT $
                                                                            58))
                                                         "iterate")
                                                        ('T
                                                         (SEQ
                                                          (LETT |u1|
                                                                (SPADCALL
                                                                 (ELT $ 41)
                                                                 (PROGN
                                                                  (LETT #6#
                                                                        NIL)
                                                                  (SEQ
                                                                   (LETT |ki|
                                                                         NIL)
                                                                   (LETT #5#
                                                                         (QCAR
                                                                          |cd|))
                                                                   (LETT |ui|
                                                                         NIL)
                                                                   (LETT #4#
                                                                         |ulst|)
                                                                   G190
                                                                   (COND
                                                                    ((OR
                                                                      (ATOM
                                                                       #4#)
                                                                      (PROGN
                                                                       (LETT
                                                                        |ui|
                                                                        (CAR
                                                                         #4#))
                                                                       NIL)
                                                                      (ATOM
                                                                       #5#)
                                                                      (PROGN
                                                                       (LETT
                                                                        |ki|
                                                                        (CAR
                                                                         #5#))
                                                                       NIL))
                                                                     (GO
                                                                      G191)))
                                                                   (SEQ
                                                                    (EXIT
                                                                     (LETT #6#
                                                                           (CONS
                                                                            (SPADCALL
                                                                             |ui|
                                                                             |ki|
                                                                             (QREFELT
                                                                              $
                                                                              59))
                                                                            #6#))))
                                                                   (LETT #4#
                                                                         (PROG1
                                                                             (CDR
                                                                              #4#)
                                                                           (LETT
                                                                            #5#
                                                                            (CDR
                                                                             #5#))))
                                                                   (GO G190)
                                                                   G191
                                                                   (EXIT
                                                                    (NREVERSE
                                                                     #6#))))
                                                                 (QREFELT $
                                                                          61)))
                                                          (LETT |k2|
                                                                (SPADCALL
                                                                 (ELT $ 62)
                                                                 (PROGN
                                                                  (LETT #3#
                                                                        NIL)
                                                                  (SEQ
                                                                   (LETT |ki|
                                                                         NIL)
                                                                   (LETT #2#
                                                                         (QCAR
                                                                          |cd|))
                                                                   (LETT |c|
                                                                         NIL)
                                                                   (LETT #1#
                                                                         |vlst|)
                                                                   G190
                                                                   (COND
                                                                    ((OR
                                                                      (ATOM
                                                                       #1#)
                                                                      (PROGN
                                                                       (LETT
                                                                        |c|
                                                                        (CAR
                                                                         #1#))
                                                                       NIL)
                                                                      (ATOM
                                                                       #2#)
                                                                      (PROGN
                                                                       (LETT
                                                                        |ki|
                                                                        (CAR
                                                                         #2#))
                                                                       NIL))
                                                                     (GO
                                                                      G191)))
                                                                   (SEQ
                                                                    (EXIT
                                                                     (LETT #3#
                                                                           (CONS
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               |ki|
                                                                               (QREFELT
                                                                                $
                                                                                63))
                                                                              (QREFELT
                                                                               $
                                                                               64))
                                                                             |c|
                                                                             (QREFELT
                                                                              $
                                                                              41))
                                                                            #3#))))
                                                                   (LETT #1#
                                                                         (PROG1
                                                                             (CDR
                                                                              #1#)
                                                                           (LETT
                                                                            #2#
                                                                            (CDR
                                                                             #2#))))
                                                                   (GO G190)
                                                                   G191
                                                                   (EXIT
                                                                    (NREVERSE
                                                                     #3#))))
                                                                 (QREFELT $
                                                                          61)))
                                                          (LETT |f2|
                                                                (SPADCALL |f1|
                                                                          |dummy|
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            |u1|
                                                                            (QREFELT
                                                                             $
                                                                             24))
                                                                           (SPADCALL
                                                                            (|spadConstant|
                                                                             $
                                                                             39)
                                                                            1
                                                                            (QREFELT
                                                                             $
                                                                             42))
                                                                           (QREFELT
                                                                            $
                                                                            25))
                                                                          (QREFELT
                                                                           $
                                                                           45)))
                                                          (COND
                                                           ((NULL
                                                             (SPADCALL
                                                              (CONS
                                                               #'|INTDEN;poly_factors!1|
                                                               (VECTOR $ |x|))
                                                              (SPADCALL |f2|
                                                                        (QREFELT
                                                                         $ 34))
                                                              (QREFELT $ 36)))
                                                            (EXIT "iterate")))
                                                          (EXIT
                                                           (LETT |res|
                                                                 (CONS
                                                                  (VECTOR |f1|
                                                                          |f2|
                                                                          |u1|
                                                                          (SPADCALL
                                                                           |v0|
                                                                           |k2|
                                                                           (QREFELT
                                                                            $
                                                                            62))
                                                                          1)
                                                                  |res|))))))))))))))))))))))))
               (LETT #15# (CDR #15#)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(SDEFUN |INTDEN;poly_factors!1| ((|c| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c| |x| (QREFELT $ 31)) (|spadConstant| $ 29)
                      (QREFELT $ 33)))))) 

(SDEFUN |INTDEN;poly_factors!0| ((|c| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c| |x| (QREFELT $ 31)) (|spadConstant| $ 29)
                      (QREFELT $ 33)))))) 

(SDEFUN |INTDEN;decompose1|
        ((|nn| (|SparseUnivariatePolynomial| F))
         (|elden| (|SparseUnivariatePolynomial| F))
         (|lidens| (|List| (|SparseUnivariatePolynomial| F)))
         ($ (|List| (|SparseUnivariatePolynomial| F))))
        (SPROG ((|res| (|List| (|SparseUnivariatePolynomial| F))))
               (SEQ
                (COND
                 ((> (SPADCALL |elden| (QREFELT $ 27)) 0)
                  (LETT |lidens| (CONS |elden| |lidens|)))
                 ((SPADCALL |elden| (|spadConstant| $ 66) (QREFELT $ 67))
                  (|error| "Impossible 5")))
                (LETT |res| (SPADCALL |nn| |lidens| (QREFELT $ 70)))
                (EXIT
                 (COND ((> (SPADCALL |elden| (QREFELT $ 27)) 0) |res|)
                       ('T (CONS (|spadConstant| $ 71) |res|))))))) 

(SDEFUN |INTDEN;p_power_in_q|
        ((|p| (|SparseMultivariatePolynomial| F (|Kernel| F)))
         (|q| (|SparseMultivariatePolynomial| F (|Kernel| F))) ($ (|Integer|)))
        (SPROG
         ((|res| (|Integer|)) (#1=#:G925 NIL)
          (|qq|
           (|Union| (|SparseMultivariatePolynomial| F (|Kernel| F))
                    #2="failed")))
         (SEQ (LETT |res| 0)
              (SEQ G190
                   (COND
                    ((NULL
                      (QEQCAR (LETT |qq| (SPADCALL |q| |p| (QREFELT $ 74))) 0))
                     (GO G191)))
                   (SEQ
                    (LETT |q|
                          (PROG2 (LETT #1# |qq|)
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0)
                                            (|SparseMultivariatePolynomial|
                                             (QREFELT $ 7)
                                             (|Kernel| (QREFELT $ 7)))
                                            (|Union|
                                             (|SparseMultivariatePolynomial|
                                              (QREFELT $ 7)
                                              (|Kernel| (QREFELT $ 7)))
                                             #2#)
                                            #1#)))
                    (EXIT (LETT |res| (+ |res| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |INTDEN;MP_to_MPF|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         (|lk| (|List| (|Kernel| F)))
         ($ (|SparseMultivariatePolynomial| F (|Kernel| F))))
        (SPROG NIL
               (SPADCALL (CONS #'|INTDEN;MP_to_MPF!0| (VECTOR $ |lk|))
                         (CONS #'|INTDEN;MP_to_MPF!1| $) |p| (QREFELT $ 85)))) 

(SDEFUN |INTDEN;MP_to_MPF!1| ((|c| NIL) ($ NIL))
        (SPADCALL (SPADCALL |c| (QREFELT $ 64)) (QREFELT $ 80))) 

(SDEFUN |INTDEN;MP_to_MPF!0| ((|k| NIL) ($$ NIL))
        (PROG (|lk| $)
          (LETT |lk| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((SPADCALL |k| |lk| (QREFELT $ 76))
              (SPADCALL (|spadConstant| $ 77) |k| (|spadConstant| $ 78)
                        (QREFELT $ 79)))
             ('T (SPADCALL (SPADCALL |k| (QREFELT $ 48)) (QREFELT $ 80)))))))) 

(SDEFUN |INTDEN;solve_u;2FSU;6|
        ((|f1| (F)) (|u| (F)) (|x| (|Symbol|))
         ($ (|Union| (|List| (|List| F)) "failed")))
        (SPROG
         ((#1=#:G1015 NIL) (|c| NIL) (#2=#:G1016 NIL) (|j| NIL)
          (#3=#:G1014 NIL) (#4=#:G1002 NIL) (#5=#:G1013 NIL) (|sl| (|List| F))
          (|sl0| (|Union| (|List| F) "failed")) (|eqsl| (|List| F))
          (|eqs| (|SparseMultivariatePolynomial| F (|Kernel| F)))
          (#6=#:G1011 NIL) (|p1| NIL) (#7=#:G1012 NIL) (|coef| NIL)
          (|lpow| (|List| (|SparseMultivariatePolynomial| F (|Kernel| F))))
          (|pp| #8=(|SparseMultivariatePolynomial| F (|Kernel| F)))
          (#9=#:G1010 NIL) (|lpow0| (|List| #8#)) (#10=#:G1009 NIL)
          (|coefs| (|List| (|Symbol|))) (#11=#:G1008 NIL) (#12=#:G1007 NIL)
          (|nf1| #13=(|SparseMultivariatePolynomial| F (|Kernel| F)))
          (|cc| (F)) (|ccru| (|Union| F "failed"))
          (|ccu|
           (|Union| (|SparseMultivariatePolynomial| F (|Kernel| F)) "failed"))
          (|dup| #8#) (#14=#:G957 NIL) (|nup| #8#) (#15=#:G955 NIL)
          (|m| (|Integer|)) (|n| (|Integer|))
          (|qu| (|Union| (|NonNegativeInteger|) "failed"))
          (|degdu| #16=(|NonNegativeInteger|)) (|degnu| #16#) (|degdf| #16#)
          (|degnf| #16#) (|du| #13#) (|nu| #13#) (|df1| #13#)
          (|vk2| (|List| #17=(|Kernel| F))) (#18=#:G1006 NIL) (|k| NIL)
          (#19=#:G1005 NIL) (|k1| (|Kernel| F)) (|vk| (|List| #17#))
          (#20=#:G1004 NIL) (#21=#:G1003 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |vk|
                  (PROGN
                   (LETT #21# NIL)
                   (SEQ (LETT |k| NIL)
                        (LETT #20# (SPADCALL |u| (QREFELT $ 87))) G190
                        (COND
                         ((OR (ATOM #20#) (PROGN (LETT |k| (CAR #20#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL
                             (SPADCALL (SPADCALL |k| (QREFELT $ 48)) |x|
                                       (QREFELT $ 31))
                             (|spadConstant| $ 29) (QREFELT $ 88))
                            (LETT #21# (CONS |k| #21#))))))
                        (LETT #20# (CDR #20#)) (GO G190) G191
                        (EXIT (NREVERSE #21#)))))
            (EXIT
             (COND ((NULL |vk|) (|error| "solve_u: constant u"))
                   (#22='T
                    (SEQ (LETT |k1| (SPADCALL |vk| (QREFELT $ 89)))
                         (EXIT
                          (COND
                           ((SPADCALL (SPADCALL |f1| |x| (QREFELT $ 31))
                                      (|spadConstant| $ 29) (QREFELT $ 33))
                            (CONS 0 (LIST (LIST |f1| (|spadConstant| $ 29)))))
                           (#22#
                            (SEQ
                             (LETT |vk2|
                                   (PROGN
                                    (LETT #19# NIL)
                                    (SEQ (LETT |k| NIL)
                                         (LETT #18#
                                               (SPADCALL |f1| (QREFELT $ 87)))
                                         G190
                                         (COND
                                          ((OR (ATOM #18#)
                                               (PROGN
                                                (LETT |k| (CAR #18#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((SPADCALL
                                              (SPADCALL
                                               (SPADCALL |k| (QREFELT $ 48))
                                               |x| (QREFELT $ 31))
                                              (|spadConstant| $ 29)
                                              (QREFELT $ 88))
                                             (LETT #19# (CONS |k| #19#))))))
                                         (LETT #18# (CDR #18#)) (GO G190) G191
                                         (EXIT (NREVERSE #19#)))))
                             (COND
                              ((NULL (SPADCALL |vk2| |vk| (QREFELT $ 90)))
                               (COND
                                ((NULL
                                  (NULL (SPADCALL |vk| |vk2| (QREFELT $ 90))))
                                 (EXIT
                                  (PROGN
                                   (LETT #4# (CONS 1 #23="failed"))
                                   (GO #24=#:G1001))))))
                              (#22#
                               (EXIT
                                (PROGN (LETT #4# (CONS 1 #23#)) (GO #24#)))))
                             (LETT |nf1|
                                   (|INTDEN;MP_to_MPF|
                                    (SPADCALL |f1| (QREFELT $ 92)) |vk| $))
                             (LETT |df1|
                                   (|INTDEN;MP_to_MPF|
                                    (SPADCALL |f1| (QREFELT $ 93)) |vk| $))
                             (LETT |nu|
                                   (|INTDEN;MP_to_MPF|
                                    (SPADCALL |u| (QREFELT $ 92)) |vk| $))
                             (LETT |du|
                                   (|INTDEN;MP_to_MPF|
                                    (SPADCALL |u| (QREFELT $ 93)) |vk| $))
                             (LETT |degnf|
                                   (SPADCALL |nf1| |k1| (QREFELT $ 94)))
                             (LETT |degdf|
                                   (SPADCALL |df1| |k1| (QREFELT $ 94)))
                             (LETT |degnu| (SPADCALL |nu| |k1| (QREFELT $ 94)))
                             (LETT |degdu| (SPADCALL |du| |k1| (QREFELT $ 94)))
                             (COND
                              ((EQL |degdu| 0)
                               (SEQ
                                (LETT |qu|
                                      (SPADCALL |degdf| |degnu|
                                                (QREFELT $ 95)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |qu| 1)
                                   (PROGN
                                    (LETT #4# (CONS 1 "failed"))
                                    (GO #24#)))
                                  (#22#
                                   (SEQ (LETT |n| (QCDR |qu|))
                                        (LETT |qu|
                                              (SPADCALL |degnf| |degnu|
                                                        (QREFELT $ 95)))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |qu| 1)
                                           (PROGN
                                            (LETT #4# (CONS 1 "failed"))
                                            (GO #24#)))
                                          (#22#
                                           (LETT |m|
                                                 (- (QCDR |qu|) |n|)))))))))))
                              ((EQL |degnu| 0)
                               (SEQ
                                (LETT |qu|
                                      (SPADCALL |degdf| |degdu|
                                                (QREFELT $ 95)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |qu| 1)
                                   (PROGN
                                    (LETT #4# (CONS 1 "failed"))
                                    (GO #24#)))
                                  (#22#
                                   (SEQ (LETT |m| (QCDR |qu|))
                                        (LETT |qu|
                                              (SPADCALL |degnf| |degdu|
                                                        (QREFELT $ 95)))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |qu| 1)
                                           (PROGN
                                            (LETT #4# (CONS 1 "failed"))
                                            (GO #24#)))
                                          (#22#
                                           (LETT |n|
                                                 (- (QCDR |qu|) |m|)))))))))))
                              (#22#
                               (SEQ
                                (LETT |m| (|INTDEN;p_power_in_q| |du| |df1| $))
                                (LETT |n| (|INTDEN;p_power_in_q| |nu| |df1| $))
                                (EXIT
                                 (COND
                                  ((SPADCALL
                                    (+ (* |m| |degdu|) (* |n| |degnu|)) |degdf|
                                    (QREFELT $ 58))
                                   (PROGN
                                    (LETT #4# (CONS 1 "failed"))
                                    (GO #24#))))))))
                             (LETT |n| (MAX |n| 0)) (LETT |m| (MAX |m| 0))
                             (LETT |nup|
                                   (COND
                                    ((> |n| 0)
                                     (SPADCALL |nu|
                                               (PROG1 (LETT #15# |n|)
                                                 (|check_subtype2| (>= #15# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #15#))
                                               (QREFELT $ 96)))
                                    (#22# (|spadConstant| $ 77))))
                             (LETT |dup|
                                   (COND
                                    ((> |m| 0)
                                     (SPADCALL |du|
                                               (PROG1 (LETT #14# |m|)
                                                 (|check_subtype2| (>= #14# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #14#))
                                               (QREFELT $ 96)))
                                    (#22# (|spadConstant| $ 77))))
                             (LETT |ccu|
                                   (SPADCALL |df1|
                                             (SPADCALL |dup| |nup|
                                                       (QREFELT $ 97))
                                             (QREFELT $ 74)))
                             (EXIT
                              (COND
                               ((QEQCAR |ccu| 1)
                                (PROGN (LETT #4# (CONS 1 "failed")) (GO #24#)))
                               (#22#
                                (SEQ
                                 (LETT |ccru|
                                       (SPADCALL (QCDR |ccu|) (QREFELT $ 99)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |ccru| 1)
                                    (PROGN
                                     (LETT #4# (CONS 1 "failed"))
                                     (GO #24#)))
                                   (#22#
                                    (SEQ (LETT |cc| (QCDR |ccru|))
                                         (LETT |nf1|
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 39)
                                                          |cc| (QREFELT $ 65))
                                                |nf1| (QREFELT $ 104)))
                                         (LETT |coefs|
                                               (PROGN
                                                (LETT #12# NIL)
                                                (SEQ (LETT |j| (- |n|))
                                                     (LETT #11# |m|) G190
                                                     (COND
                                                      ((> |j| #11#) (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #12#
                                                             (CONS
                                                              (SPADCALL
                                                               (QREFELT $ 105))
                                                              #12#))))
                                                     (LETT |j| (+ |j| 1))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #12#)))))
                                         (LETT |eqs| |nf1|)
                                         (LETT |pp| (|spadConstant| $ 77))
                                         (LETT |lpow0| (LIST |pp|))
                                         (SEQ (LETT |j| (- 1 |n|))
                                              (LETT #10# |m|) G190
                                              (COND ((> |j| #10#) (GO G191)))
                                              (SEQ
                                               (LETT |pp|
                                                     (SPADCALL |nu| |pp|
                                                               (QREFELT $ 97)))
                                               (EXIT
                                                (LETT |lpow0|
                                                      (CONS |pp| |lpow0|))))
                                              (LETT |j| (+ |j| 1)) (GO G190)
                                              G191 (EXIT NIL))
                                         (LETT |lpow|
                                               (LIST (|SPADfirst| |lpow0|)))
                                         (LETT |pp| (|spadConstant| $ 77))
                                         (SEQ (LETT |p1| NIL)
                                              (LETT #9# (CDR |lpow0|)) G190
                                              (COND
                                               ((OR (ATOM #9#)
                                                    (PROGN
                                                     (LETT |p1| (CAR #9#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (LETT |pp|
                                                     (SPADCALL |du| |pp|
                                                               (QREFELT $ 97)))
                                               (EXIT
                                                (LETT |lpow|
                                                      (CONS
                                                       (SPADCALL |pp| |p1|
                                                                 (QREFELT $
                                                                          97))
                                                       |lpow|))))
                                              (LETT #9# (CDR #9#)) (GO G190)
                                              G191 (EXIT NIL))
                                         (SEQ (LETT |coef| NIL)
                                              (LETT #7# |coefs|)
                                              (LETT |p1| NIL) (LETT #6# |lpow|)
                                              G190
                                              (COND
                                               ((OR (ATOM #6#)
                                                    (PROGN
                                                     (LETT |p1| (CAR #6#))
                                                     NIL)
                                                    (ATOM #7#)
                                                    (PROGN
                                                     (LETT |coef| (CAR #7#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT |eqs|
                                                      (SPADCALL |eqs|
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  |coef|
                                                                  (QREFELT $
                                                                           106))
                                                                 |p1|
                                                                 (QREFELT $
                                                                          104))
                                                                (QREFELT $
                                                                         107)))))
                                              (LETT #6#
                                                    (PROG1 (CDR #6#)
                                                      (LETT #7# (CDR #7#))))
                                              (GO G190) G191 (EXIT NIL))
                                         (LETT |eqsl|
                                               (SPADCALL |eqs|
                                                         (QREFELT $ 108)))
                                         (LETT |sl0|
                                               (SPADCALL |eqsl| |coefs|
                                                         (QREFELT $ 112)))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |sl0| 1) (CONS 1 "failed"))
                                           (#22#
                                            (SEQ (LETT |sl| (QCDR |sl0|))
                                                 (SEQ (LETT |c| NIL)
                                                      (LETT #5# |sl|) G190
                                                      (COND
                                                       ((OR (ATOM #5#)
                                                            (PROGN
                                                             (LETT |c|
                                                                   (CAR #5#))
                                                             NIL))
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (COND
                                                         ((SPADCALL
                                                           (SPADCALL |c| |x|
                                                                     (QREFELT $
                                                                              31))
                                                           (|spadConstant| $
                                                                           29)
                                                           (QREFELT $ 88))
                                                          (PROGN
                                                           (LETT #4#
                                                                 (CONS 1
                                                                       "failed"))
                                                           (GO #24#))))))
                                                      (LETT #5# (CDR #5#))
                                                      (GO G190) G191
                                                      (EXIT NIL))
                                                 (EXIT
                                                  (CONS 0
                                                        (PROGN
                                                         (LETT #3# NIL)
                                                         (SEQ
                                                          (LETT |j| (- |n|))
                                                          (LETT #2# |m|)
                                                          (LETT |c| NIL)
                                                          (LETT #1# |sl|) G190
                                                          (COND
                                                           ((OR (ATOM #1#)
                                                                (PROGN
                                                                 (LETT |c|
                                                                       (CAR
                                                                        #1#))
                                                                 NIL)
                                                                (> |j| #2#))
                                                            (GO G191)))
                                                          (SEQ
                                                           (EXIT
                                                            (COND
                                                             ((SPADCALL |c|
                                                                        (|spadConstant|
                                                                         $ 29)
                                                                        (QREFELT
                                                                         $ 88))
                                                              (LETT #3#
                                                                    (CONS
                                                                     (LIST |c|
                                                                           (SPADCALL
                                                                            |j|
                                                                            (QREFELT
                                                                             $
                                                                             37)))
                                                                     #3#))))))
                                                          (LETT #1#
                                                                (PROG1
                                                                    (CDR #1#)
                                                                  (LETT |j|
                                                                        (+ |j|
                                                                           1))))
                                                          (GO G190) G191
                                                          (EXIT
                                                           (NREVERSE
                                                            #3#))))))))))))))))))))))))))))
          #24# (EXIT #4#)))) 

(SDEFUN |INTDEN;li_int1|
        ((|f| (F)) (|u| (F)) (|x| (|Symbol|))
         ($ (|Union| (|List| (|List| F)) "failed")))
        (SPROG ((|deru| (F)))
               (SEQ (LETT |deru| (SPADCALL |u| |x| (QREFELT $ 31)))
                    (EXIT
                     (COND
                      ((SPADCALL |deru| (|spadConstant| $ 29) (QREFELT $ 33))
                       (|error| "li_int1: constant log"))
                      ('T
                       (SPADCALL (SPADCALL |f| |deru| (QREFELT $ 65)) |u| |x|
                                 (QREFELT $ 114)))))))) 

(SDEFUN |INTDEN;mk_li|
        ((|c| (F)) (|j| (|Integer|)) (|u| (F)) (|s| (F)) ($ (F)))
        (SPROG ((|es| (F)))
               (SEQ
                (COND
                 ((EQL |j| -1)
                  (SPADCALL |c|
                            (SPADCALL
                             (SPADCALL (SPADCALL |u| (QREFELT $ 115)) |s|
                                       (QREFELT $ 62))
                             (QREFELT $ 115))
                            (QREFELT $ 41)))
                 ('T
                  (SEQ (LETT |es| (SPADCALL |s| (QREFELT $ 116)))
                       (EXIT
                        (SPADCALL
                         (SPADCALL |c|
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL |u| |es| (QREFELT $ 41))
                                     (+ |j| 1) (QREFELT $ 59))
                                    (QREFELT $ 117))
                                   (QREFELT $ 41))
                         (SPADCALL |es| (+ |j| 1) (QREFELT $ 59))
                         (QREFELT $ 65))))))))) 

(SDEFUN |INTDEN;UP2UPR|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($
          (|SparseUnivariatePolynomial|
           (|Fraction| (|SparseUnivariatePolynomial| F)))))
        (SPADCALL (CONS #'|INTDEN;UP2UPR!0| $) |p| (QREFELT $ 123))) 

(SDEFUN |INTDEN;UP2UPR!0| ((|x1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x1| (QREFELT $ 43)) (QREFELT $ 119))) 

(SDEFUN |INTDEN;li_int3|
        ((|f| (F)) (|rf| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|k| (|Kernel| F)) (|lk| (|List| (|Kernel| F))) (|x| (|Symbol|))
         ($
          (|Union|
           (|Record|
            (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |logpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |ir|
                 (|IntegrationResult|
                  (|Fraction| (|SparseUnivariatePolynomial| F)))))
           "failed")))
        (SPROG
         ((|res| (F)) (#1=#:G1066 NIL) (|zz| NIL) (|lle| (F))
          (|logs|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff|
                           (|SparseUnivariatePolynomial|
                            (|Fraction| (|SparseUnivariatePolynomial| F))))
                      (|:| |logand|
                           (|SparseUnivariatePolynomial|
                            (|Fraction| (|SparseUnivariatePolynomial| F)))))))
          (#2=#:G1065 NIL) (|e| NIL) (|zzl| (|List| F)) (|rf1k| (|Kernel| F))
          (|elpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|lli| (|List| (|List| F))) (#3=#:G1060 NIL)
          (|liu| (|Union| (|List| (|List| F)) "failed")) (|tf| (F))
          (|c_shift| (F)) (|ddf| (F)) (|rf1| (F)) (|rfc| (F))
          (|deg1| (|NonNegativeInteger|)) (|u1| (F))
          (|cfac| (|SparseUnivariatePolynomial| F))
          (|liden| #4=(|SparseUnivariatePolynomial| F)) (#5=#:G1063 NIL)
          (|ldr| NIL) (#6=#:G1064 NIL) (|linum| NIL)
          (|dummy| (|SingletonAsOrderedSet|))
          (|linums| (|List| (|SparseUnivariatePolynomial| F)))
          (|dn| (|List| (|SparseUnivariatePolynomial| F)))
          (|elden| (|Union| (|SparseUnivariatePolynomial| F) "failed"))
          (|lidens| (|List| #4#)) (#7=#:G1062 NIL) (#8=#:G1061 NIL)
          (|ldrs|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |cfactor| (|SparseUnivariatePolynomial| F))
                      (|:| |ufun| F) (|:| |vfun| F) (|:| |den| (|Integer|))))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |ldrs|
                  (|INTDEN;li_factors| (SPADCALL |rf| (QREFELT $ 124)) |k| |lk|
                   |x| $))
            (LETT |lidens|
                  (PROGN
                   (LETT #8# NIL)
                   (SEQ (LETT |ldr| NIL) (LETT #7# |ldrs|) G190
                        (COND
                         ((OR (ATOM #7#) (PROGN (LETT |ldr| (CAR #7#)) NIL))
                          (GO G191)))
                        (SEQ (EXIT (LETT #8# (CONS (QVELT |ldr| 0) #8#))))
                        (LETT #7# (CDR #7#)) (GO G190) G191
                        (EXIT (NREVERSE #8#)))))
            (EXIT
             (COND ((NULL |lidens|) (CONS 1 "failed"))
                   (#9='T
                    (SEQ
                     (LETT |elden|
                           (SPADCALL (SPADCALL |rf| (QREFELT $ 124))
                                     (SPADCALL (ELT $ 125) |lidens|
                                               (QREFELT $ 127))
                                     (QREFELT $ 128)))
                     (EXIT
                      (COND ((QEQCAR |elden| 1) (|error| "Impossible 2"))
                            (#9#
                             (SEQ
                              (LETT |dn|
                                    (|INTDEN;decompose1|
                                     (SPADCALL |rf| (QREFELT $ 129))
                                     (QCDR |elden|) |lidens| $))
                              (LETT |elpart|
                                    (SPADCALL (|SPADfirst| |dn|) (QCDR |elden|)
                                              (QREFELT $ 130)))
                              (LETT |linums| (CDR |dn|))
                              (LETT |dummy| (SPADCALL (QREFELT $ 17)))
                              (LETT |res| (|spadConstant| $ 29))
                              (LETT |logs| NIL)
                              (SEQ (LETT |linum| NIL) (LETT #6# |linums|)
                                   (LETT |ldr| NIL) (LETT #5# |ldrs|) G190
                                   (COND
                                    ((OR (ATOM #5#)
                                         (PROGN (LETT |ldr| (CAR #5#)) NIL)
                                         (ATOM #6#)
                                         (PROGN (LETT |linum| (CAR #6#)) NIL))
                                     (GO G191)))
                                   (SEQ (LETT |liden| (QVELT |ldr| 0))
                                        (LETT |cfac| (QVELT |ldr| 1))
                                        (LETT |u1| (QVELT |ldr| 2))
                                        (SEQ
                                         (LETT |deg1|
                                               (SPADCALL |liden|
                                                         (QREFELT $ 27)))
                                         (EXIT
                                          (COND
                                           ((> |deg1| 1)
                                            (SEQ
                                             (LETT |rfc|
                                                   (SPADCALL |cfac|
                                                             (QREFELT $ 132)))
                                             (LETT |c_shift|
                                                   (SPADCALL |rfc|
                                                             (QREFELT $ 133)))
                                             (LETT |rf1|
                                                   (SPADCALL |rfc|
                                                             (QVELT |ldr| 3)
                                                             (QREFELT $ 134)))
                                             (LETT |ddf|
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |liden|
                                                               (QREFELT $ 135))
                                                     |dummy| |rf1|
                                                     (QREFELT $ 136))
                                                    (QREFELT $ 137)))
                                             (EXIT
                                              (LETT |tf|
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL |linum| |dummy|
                                                                |rf1|
                                                                (QREFELT $
                                                                         136))
                                                      (QREFELT $ 137))
                                                     |ddf| (QREFELT $ 65))))))
                                           ('T
                                            (SEQ
                                             (LETT |c_shift|
                                                   (SPADCALL |cfac| 0
                                                             (QREFELT $ 40)))
                                             (EXIT
                                              (LETT |tf|
                                                    (SPADCALL |linum|
                                                              (QREFELT $
                                                                       137)))))))))
                                        (LETT |liu|
                                              (|INTDEN;li_int1| |tf| |u1| |x|
                                               $))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |liu| 1)
                                           (PROGN
                                            (LETT #3# (CONS 1 "failed"))
                                            (GO #10=#:G1059)))
                                          ('T
                                           (SEQ (LETT |lli| (QCDR |liu|))
                                                (COND
                                                 ((EQL (LENGTH |lli|) 1)
                                                  (COND
                                                   ((SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL |lli| 1
                                                                (QREFELT $
                                                                         139))
                                                      2 (QREFELT $ 22))
                                                     (SPADCALL
                                                      (|spadConstant| $ 39)
                                                      (QREFELT $ 133))
                                                     (QREFELT $ 33))
                                                    (EXIT
                                                     (COND
                                                      ((EQL |deg1| 1)
                                                       (LETT |logs|
                                                             (CONS
                                                              (VECTOR
                                                               (|spadConstant|
                                                                $ 102)
                                                               (SPADCALL
                                                                (SPADCALL
                                                                 (|spadConstant|
                                                                  $ 140)
                                                                 1
                                                                 (QREFELT $
                                                                          141))
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |lli| 1
                                                                     (QREFELT $
                                                                              139))
                                                                    1
                                                                    (QREFELT $
                                                                             22))
                                                                   (QREFELT $
                                                                            43))
                                                                  (QREFELT $
                                                                           119))
                                                                 (QREFELT $
                                                                          142))
                                                                (QREFELT $
                                                                         143))
                                                               (SPADCALL
                                                                (SPADCALL
                                                                 |liden|
                                                                 (QREFELT $
                                                                          119))
                                                                (QREFELT $
                                                                         142)))
                                                              |logs|)))
                                                      ('T
                                                       (LETT |elpart|
                                                             (SPADCALL |elpart|
                                                                       (SPADCALL
                                                                        |linum|
                                                                        |liden|
                                                                        (QREFELT
                                                                         $
                                                                         130))
                                                                       (QREFELT
                                                                        $
                                                                        144))))))))))
                                                (COND
                                                 ((> |deg1| 1)
                                                  (SEQ
                                                   (LETT |rf1k|
                                                         (SPADCALL |rfc|
                                                                   (QREFELT $
                                                                            145)))
                                                   (EXIT
                                                    (LETT |zzl|
                                                          (SPADCALL |cfac|
                                                                    (QREFELT $
                                                                             147)))))))
                                                (EXIT
                                                 (SEQ (LETT |e| NIL)
                                                      (LETT #2# |lli|) G190
                                                      (COND
                                                       ((OR (ATOM #2#)
                                                            (PROGN
                                                             (LETT |e|
                                                                   (CAR #2#))
                                                             NIL))
                                                        (GO G191)))
                                                      (SEQ
                                                       (COND
                                                        ((SPADCALL
                                                          (SPADCALL |e| 2
                                                                    (QREFELT $
                                                                             22))
                                                          (SPADCALL
                                                           (|spadConstant| $
                                                                           39)
                                                           (QREFELT $ 133))
                                                          (QREFELT $ 33))
                                                         (COND
                                                          ((EQL |deg1| 1)
                                                           (EXIT
                                                            (LETT |logs|
                                                                  (CONS
                                                                   (VECTOR
                                                                    (|spadConstant|
                                                                     $ 102)
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (|spadConstant|
                                                                       $ 140)
                                                                      1
                                                                      (QREFELT
                                                                       $ 141))
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         |e| 1
                                                                         (QREFELT
                                                                          $
                                                                          22))
                                                                        (QREFELT
                                                                         $ 43))
                                                                       (QREFELT
                                                                        $ 119))
                                                                      (QREFELT
                                                                       $ 142))
                                                                     (QREFELT $
                                                                              143))
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      |liden|
                                                                      (QREFELT
                                                                       $ 119))
                                                                     (QREFELT $
                                                                              142)))
                                                                   |logs|)))))))
                                                       (LETT |lle|
                                                             (|INTDEN;mk_li|
                                                              (SPADCALL |e| 1
                                                                        (QREFELT
                                                                         $ 22))
                                                              (SPADCALL
                                                               (SPADCALL |e| 2
                                                                         (QREFELT
                                                                          $
                                                                          22))
                                                               (QREFELT $ 148))
                                                              |u1| |c_shift|
                                                              $))
                                                       (EXIT
                                                        (COND
                                                         ((> |deg1| 1)
                                                          (SEQ (LETT |zz| NIL)
                                                               (LETT #1# |zzl|)
                                                               G190
                                                               (COND
                                                                ((OR (ATOM #1#)
                                                                     (PROGN
                                                                      (LETT
                                                                       |zz|
                                                                       (CAR
                                                                        #1#))
                                                                      NIL))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT |res|
                                                                       (SPADCALL
                                                                        |res|
                                                                        (SPADCALL
                                                                         |lle|
                                                                         |rf1k|
                                                                         |zz|
                                                                         (QREFELT
                                                                          $
                                                                          149))
                                                                        (QREFELT
                                                                         $
                                                                         62)))))
                                                               (LETT #1#
                                                                     (CDR #1#))
                                                               (GO G190) G191
                                                               (EXIT NIL)))
                                                         ('T
                                                          (LETT |res|
                                                                (SPADCALL |res|
                                                                          |lle|
                                                                          (QREFELT
                                                                           $
                                                                           62)))))))
                                                      (LETT #2# (CDR #2#))
                                                      (GO G190) G191
                                                      (EXIT NIL))))))))
                                   (LETT #5#
                                         (PROG1 (CDR #5#)
                                           (LETT #6# (CDR #6#))))
                                   (GO G190) G191 (EXIT NIL))
                              (EXIT
                               (CONS 0
                                     (VECTOR
                                      (SPADCALL (SPADCALL |res| (QREFELT $ 43))
                                                (QREFELT $ 119))
                                      |elpart|
                                      (SPADCALL (|spadConstant| $ 150) |logs|
                                                NIL
                                                (QREFELT $ 156)))))))))))))))
          #10# (EXIT #3#)))) 

(SDEFUN |INTDEN;mk_poly|
        ((|c| (F)) (|j| (|Integer|)) (|u| (F)) (|s| (F)) ($ (F)))
        (SPROG
         ((|ifac| (F)) (|res| (F)) (|i1| (|Integer|)) (#1=#:G1072 NIL)
          (|i| NIL) (|j1| (|Integer|)) (|eu| (F)))
         (SEQ
          (COND
           ((EQL |j| 0)
            (SPADCALL |c|
                      (SPADCALL |u|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |u| (QREFELT $ 116))
                                           (SPADCALL (|spadConstant| $ 39) |s|
                                                     (QREFELT $ 65))
                                           (QREFELT $ 62))
                                 (QREFELT $ 115))
                                (QREFELT $ 134))
                      (QREFELT $ 41)))
           ('T
            (SEQ
             (LETT |eu|
                   (SPADCALL |s| (SPADCALL |u| (QREFELT $ 116))
                             (QREFELT $ 41)))
             (LETT |j1| (+ |j| 1))
             (LETT |res|
                   (SPADCALL (SPADCALL |u| |j1| (QREFELT $ 59))
                             (SPADCALL (SPADCALL |j1| (QREFELT $ 63))
                                       (QREFELT $ 64))
                             (QREFELT $ 65)))
             (LETT |res|
                   (SPADCALL |res|
                             (SPADCALL (SPADCALL |u| |j| (QREFELT $ 59))
                                       (SPADCALL
                                        (SPADCALL |eu| (|spadConstant| $ 39)
                                                  (QREFELT $ 62))
                                        (QREFELT $ 115))
                                       (QREFELT $ 41))
                             (QREFELT $ 134)))
             (LETT |ifac|
                   (SPADCALL
                    (SPADCALL (SPADCALL |j| (QREFELT $ 63)) (QREFELT $ 64))
                    (QREFELT $ 133)))
             (SEQ (LETT |i| 1) (LETT #1# |j|) G190
                  (COND ((|greater_SI| |i| #1#) (GO G191)))
                  (SEQ (LETT |i1| (- |j| |i|))
                       (LETT |res|
                             (SPADCALL |res|
                                       (SPADCALL
                                        (SPADCALL |ifac|
                                                  (SPADCALL |u| |i1|
                                                            (QREFELT $ 59))
                                                  (QREFELT $ 41))
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL (+ |i| 1) (QREFELT $ 63))
                                          (QREFELT $ 64))
                                         (SPADCALL |eu| (QREFELT $ 133))
                                         (QREFELT $ 157))
                                        (QREFELT $ 41))
                                       (QREFELT $ 62)))
                       (EXIT
                        (LETT |ifac|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (SPADCALL |i1| (QREFELT $ 63))
                                          (QREFELT $ 64))
                                |ifac| (QREFELT $ 41))
                               (QREFELT $ 133)))))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
             (EXIT (SPADCALL |c| |res| (QREFELT $ 41))))))))) 

(SDEFUN |INTDEN;poly_int3|
        ((|f| (F)) (|rf| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|k| (|Kernel| F)) (|lk| (|List| (|Kernel| F))) (|x| (|Symbol|))
         ($
          (|Union|
           (|Record|
            (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |logpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |ir|
                 (|IntegrationResult|
                  (|Fraction| (|SparseUnivariatePolynomial| F)))))
           "failed")))
        (SPROG
         ((|res| (F)) (#1=#:G1113 NIL) (|zz| NIL) (|lle| (F)) (#2=#:G1105 NIL)
          (|ii| (|Integer|)) (#3=#:G1112 NIL) (|e| NIL) (|zzl| (|List| F))
          (|rf1k| (|Kernel| F))
          (|elpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|lpoly| (|List| (|List| F)))
          (|polyu| (|Union| (|List| (|List| F)) "failed")) (|tf| (F))
          (|c_shift| (F)) (|ddf| (F)) (|rf1| (F)) (|rfc| (F))
          (|deg1| (|NonNegativeInteger|))
          (|polynum| #4=(|SparseUnivariatePolynomial| F)) (|v1| (F))
          (|cfac| (|SparseUnivariatePolynomial| F))
          (|polyden| #5=(|SparseUnivariatePolynomial| F)) (#6=#:G1110 NIL)
          (|ldr| NIL) (#7=#:G1111 NIL) (|polynum1| NIL)
          (|logs|
           (|List|
            (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                      (|:| |coeff|
                           (|SparseUnivariatePolynomial|
                            (|Fraction| (|SparseUnivariatePolynomial| F))))
                      (|:| |logand|
                           (|SparseUnivariatePolynomial|
                            (|Fraction| (|SparseUnivariatePolynomial| F)))))))
          (|dummy| (|SingletonAsOrderedSet|))
          (|polynums1| (|List| (|SparseUnivariatePolynomial| F)))
          (|dn| (|List| (|SparseUnivariatePolynomial| F)))
          (|elden| (|Union| (|SparseUnivariatePolynomial| F) "failed"))
          (|polydens1| (|List| #4#)) (#8=#:G1109 NIL) (|p| NIL)
          (#9=#:G1108 NIL) (|polydens| (|List| #5#)) (#10=#:G1107 NIL)
          (#11=#:G1106 NIL)
          (|ldrs|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |cfactor| (|SparseUnivariatePolynomial| F))
                      (|:| |ufun| F) (|:| |vfun| F) (|:| |den| (|Integer|))))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |ldrs|
                  (|INTDEN;poly_factors| (SPADCALL |rf| (QREFELT $ 124)) |k|
                   |lk| |x| $))
            (LETT |polydens|
                  (PROGN
                   (LETT #11# NIL)
                   (SEQ (LETT |ldr| NIL) (LETT #10# |ldrs|) G190
                        (COND
                         ((OR (ATOM #10#) (PROGN (LETT |ldr| (CAR #10#)) NIL))
                          (GO G191)))
                        (SEQ (EXIT (LETT #11# (CONS (QVELT |ldr| 0) #11#))))
                        (LETT #10# (CDR #10#)) (GO G190) G191
                        (EXIT (NREVERSE #11#)))))
            (EXIT
             (COND ((NULL |polydens|) (CONS 1 "failed"))
                   (#12='T
                    (SEQ
                     (LETT |polydens1|
                           (PROGN
                            (LETT #9# NIL)
                            (SEQ (LETT |p| NIL) (LETT #8# |polydens|) G190
                                 (COND
                                  ((OR (ATOM #8#)
                                       (PROGN (LETT |p| (CAR #8#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #9#
                                         (CONS
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |p| (QREFELT $ 23))
                                            (QREFELT $ 24))
                                           |p| (QREFELT $ 25))
                                          #9#))))
                                 (LETT #8# (CDR #8#)) (GO G190) G191
                                 (EXIT (NREVERSE #9#)))))
                     (LETT |elden|
                           (SPADCALL (SPADCALL |rf| (QREFELT $ 124))
                                     (SPADCALL (ELT $ 125) |polydens1|
                                               (QREFELT $ 127))
                                     (QREFELT $ 128)))
                     (EXIT
                      (COND ((QEQCAR |elden| 1) (|error| "Impossible 4"))
                            (#12#
                             (SEQ
                              (LETT |dn|
                                    (|INTDEN;decompose1|
                                     (SPADCALL |rf| (QREFELT $ 129))
                                     (QCDR |elden|) |polydens1| $))
                              (LETT |elpart|
                                    (SPADCALL (|SPADfirst| |dn|) (QCDR |elden|)
                                              (QREFELT $ 130)))
                              (LETT |polynums1| (CDR |dn|))
                              (LETT |dummy| (SPADCALL (QREFELT $ 17)))
                              (LETT |res| (|spadConstant| $ 29))
                              (LETT |logs| NIL)
                              (SEQ (LETT |polynum1| NIL) (LETT #7# |polynums1|)
                                   (LETT |ldr| NIL) (LETT #6# |ldrs|) G190
                                   (COND
                                    ((OR (ATOM #6#)
                                         (PROGN (LETT |ldr| (CAR #6#)) NIL)
                                         (ATOM #7#)
                                         (PROGN
                                          (LETT |polynum1| (CAR #7#))
                                          NIL))
                                     (GO G191)))
                                   (SEQ (LETT |polyden| (QVELT |ldr| 0))
                                        (LETT |cfac| (QVELT |ldr| 1))
                                        (LETT |v1| (QVELT |ldr| 3))
                                        (LETT |polynum|
                                              (SPADCALL
                                               (SPADCALL |polyden|
                                                         (QREFELT $ 23))
                                               |polynum1| (QREFELT $ 25)))
                                        (SEQ
                                         (LETT |deg1|
                                               (SPADCALL |polyden|
                                                         (QREFELT $ 27)))
                                         (EXIT
                                          (COND
                                           ((> |deg1| 1)
                                            (SEQ
                                             (LETT |rfc|
                                                   (SPADCALL |cfac|
                                                             (QREFELT $ 132)))
                                             (LETT |rf1|
                                                   (SPADCALL |rfc|
                                                             (QVELT |ldr| 2)
                                                             (QREFELT $ 65)))
                                             (LETT |c_shift|
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (|spadConstant| $ 39)
                                                     |rfc| (QREFELT $ 65))
                                                    (QREFELT $ 133)))
                                             (LETT |ddf|
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |cfac|
                                                               (QREFELT $ 135))
                                                     |dummy| |rfc|
                                                     (QREFELT $ 136))
                                                    (QREFELT $ 137)))
                                             (EXIT
                                              (LETT |tf|
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |polynum|
                                                                 |dummy| |rf1|
                                                                 (QREFELT $
                                                                          136))
                                                       (QREFELT $ 137))
                                                      (SPADCALL |rfc| |ddf|
                                                                (QREFELT $ 41))
                                                      (QREFELT $ 65))
                                                     (QREFELT $ 133))))))
                                           ('T
                                            (SEQ
                                             (LETT |c_shift|
                                                   (SPADCALL |cfac| 1
                                                             (QREFELT $ 40)))
                                             (EXIT
                                              (LETT |tf|
                                                    (SPADCALL |polynum|
                                                              (QREFELT $
                                                                       137)))))))))
                                        (LETT |polyu|
                                              (|INTDEN;li_int1| |tf| |v1| |x|
                                               $))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |polyu| 1)
                                           (PROGN
                                            (LETT #2# (CONS 1 "failed"))
                                            (GO #13=#:G1104)))
                                          ('T
                                           (SEQ (LETT |lpoly| (QCDR |polyu|))
                                                (COND
                                                 ((EQL (LENGTH |lpoly|) 1)
                                                  (COND
                                                   ((SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL |lpoly| 1
                                                                (QREFELT $
                                                                         139))
                                                      2 (QREFELT $ 22))
                                                     (|spadConstant| $ 29)
                                                     (QREFELT $ 33))
                                                    (EXIT
                                                     (LETT |elpart|
                                                           (SPADCALL |elpart|
                                                                     (SPADCALL
                                                                      |polynum|
                                                                      |polyden|
                                                                      (QREFELT
                                                                       $ 130))
                                                                     (QREFELT $
                                                                              144))))))))
                                                (COND
                                                 ((> |deg1| 1)
                                                  (SEQ
                                                   (LETT |rf1k|
                                                         (SPADCALL |rfc|
                                                                   (QREFELT $
                                                                            145)))
                                                   (EXIT
                                                    (LETT |zzl|
                                                          (SPADCALL |cfac|
                                                                    (QREFELT $
                                                                             147)))))))
                                                (EXIT
                                                 (SEQ (LETT |e| NIL)
                                                      (LETT #3# |lpoly|) G190
                                                      (COND
                                                       ((OR (ATOM #3#)
                                                            (PROGN
                                                             (LETT |e|
                                                                   (CAR #3#))
                                                             NIL))
                                                        (GO G191)))
                                                      (SEQ
                                                       (LETT |ii|
                                                             (SPADCALL
                                                              (SPADCALL |e| 2
                                                                        (QREFELT
                                                                         $ 22))
                                                              (QREFELT $ 148)))
                                                       (EXIT
                                                        (COND
                                                         ((< |ii| 0)
                                                          (PROGN
                                                           (LETT #2#
                                                                 (CONS 1
                                                                       "failed"))
                                                           (GO #13#)))
                                                         ((SPADCALL
                                                           (SPADCALL |e| 1
                                                                     (QREFELT $
                                                                              22))
                                                           (|spadConstant| $
                                                                           29)
                                                           (QREFELT $ 33))
                                                          "iterate")
                                                         ('T
                                                          (SEQ
                                                           (LETT |lle|
                                                                 (|INTDEN;mk_poly|
                                                                  (SPADCALL |e|
                                                                            1
                                                                            (QREFELT
                                                                             $
                                                                             22))
                                                                  |ii| |v1|
                                                                  |c_shift| $))
                                                           (EXIT
                                                            (COND
                                                             ((> |deg1| 1)
                                                              (SEQ
                                                               (LETT |zz| NIL)
                                                               (LETT #1# |zzl|)
                                                               G190
                                                               (COND
                                                                ((OR (ATOM #1#)
                                                                     (PROGN
                                                                      (LETT
                                                                       |zz|
                                                                       (CAR
                                                                        #1#))
                                                                      NIL))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT |res|
                                                                       (SPADCALL
                                                                        |res|
                                                                        (SPADCALL
                                                                         |lle|
                                                                         |rf1k|
                                                                         |zz|
                                                                         (QREFELT
                                                                          $
                                                                          149))
                                                                        (QREFELT
                                                                         $
                                                                         62)))))
                                                               (LETT #1#
                                                                     (CDR #1#))
                                                               (GO G190) G191
                                                               (EXIT NIL)))
                                                             ('T
                                                              (LETT |res|
                                                                    (SPADCALL
                                                                     |res|
                                                                     |lle|
                                                                     (QREFELT $
                                                                              62)))))))))))
                                                      (LETT #3# (CDR #3#))
                                                      (GO G190) G191
                                                      (EXIT NIL))))))))
                                   (LETT #6#
                                         (PROG1 (CDR #6#)
                                           (LETT #7# (CDR #7#))))
                                   (GO G190) G191 (EXIT NIL))
                              (EXIT
                               (CONS 0
                                     (VECTOR
                                      (SPADCALL (SPADCALL |res| (QREFELT $ 43))
                                                (QREFELT $ 119))
                                      |elpart|
                                      (SPADCALL (|spadConstant| $ 150) |logs|
                                                NIL
                                                (QREFELT $ 156)))))))))))))))
          #13# (EXIT #2#)))) 

(SDEFUN |INTDEN;li_int;FKSR;13|
        ((|rf| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|k| (|Kernel| F)) (|x| (|Symbol|))
         ($
          (|Record|
           (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
           (|:| |logpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
           (|:| |ir|
                (|IntegrationResult|
                 (|Fraction| (|SparseUnivariatePolynomial| F)))))))
        (SPROG
         ((|res|
           (|Union|
            (|Record|
             (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |logpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |ir|
                  (|IntegrationResult|
                   (|Fraction| (|SparseUnivariatePolynomial| F)))))
            "failed"))
          (|lk| (|List| (|Kernel| F))) (#1=#:G1122 NIL) (|kk| NIL)
          (#2=#:G1121 NIL) (|f| (F)))
         (SEQ (LETT |f| (SPADCALL |rf| |k| (QREFELT $ 159)))
              (LETT |lk|
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |kk| NIL)
                           (LETT #1# (SPADCALL |f| (QREFELT $ 160))) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |kk| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((COND ((SPADCALL |kk| '|exp| (QREFELT $ 46)) 'T)
                                     ((SPADCALL |kk| '|log| (QREFELT $ 46))
                                      (SPADCALL |kk| |k| (QREFELT $ 161)))
                                     (#3='T NIL))
                               (LETT #2# (CONS |kk| #2#))))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     |x| (QREFELT $ 163)))
              (LETT |res| (|INTDEN;li_int3| |f| |rf| |k| |lk| |x| $))
              (EXIT
               (COND
                ((QEQCAR |res| 1)
                 (VECTOR (|spadConstant| $ 150) |rf| (|spadConstant| $ 164)))
                (#3# (QCDR |res|))))))) 

(SDEFUN |INTDEN;poly_int;FKSR;14|
        ((|rf| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|k| (|Kernel| F)) (|x| (|Symbol|))
         ($
          (|Record|
           (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
           (|:| |logpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
           (|:| |ir|
                (|IntegrationResult|
                 (|Fraction| (|SparseUnivariatePolynomial| F)))))))
        (SPROG
         ((|res|
           (|Union|
            (|Record|
             (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |logpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |ir|
                  (|IntegrationResult|
                   (|Fraction| (|SparseUnivariatePolynomial| F)))))
            "failed"))
          (|lk| (|List| (|Kernel| F))) (#1=#:G1130 NIL) (|kk| NIL)
          (#2=#:G1129 NIL) (|f| (F)))
         (SEQ (LETT |f| (SPADCALL |rf| |k| (QREFELT $ 159)))
              (LETT |lk|
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |kk| NIL)
                           (LETT #1# (SPADCALL |f| (QREFELT $ 160))) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |kk| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((COND ((SPADCALL |kk| '|exp| (QREFELT $ 46)) 'T)
                                     ((SPADCALL |kk| '|log| (QREFELT $ 46))
                                      (SPADCALL |kk| |k| (QREFELT $ 161)))
                                     (#3='T NIL))
                               (LETT #2# (CONS |kk| #2#))))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     |x| (QREFELT $ 163)))
              (LETT |res| (|INTDEN;poly_int3| |f| |rf| |k| |lk| |x| $))
              (EXIT
               (COND
                ((QEQCAR |res| 1)
                 (VECTOR (|spadConstant| $ 150) |rf| (|spadConstant| $ 164)))
                (#3# (QCDR |res|))))))) 

(DECLAIM (NOTINLINE |DenominatorIntegration;|)) 

(DEFUN |DenominatorIntegration| (&REST #1=#:G1131)
  (SPROG NIL
         (PROG (#2=#:G1132)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|DenominatorIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |DenominatorIntegration;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DenominatorIntegration|)))))))))) 

(DEFUN |DenominatorIntegration;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|DenominatorIntegration| DV$1 DV$2))
          (LETT $ (GETREFV 168))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DenominatorIntegration|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DenominatorIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Factored| 9) (|SparseUnivariatePolynomial| 7)
              (|ExpressionFactorPolynomial| 6 7) (0 . |factorPolynomial|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 12) (|:| |factor| 9) (|:| |exponent| 26))
              (|List| 13) (5 . |factorList|) (|SingletonAsOrderedSet|)
              (10 . |create|) (|List| 7) (|Kernel| 7) (14 . |argument|)
              (|Integer|) (19 . |elt|) (25 . |leadingCoefficient|) (30 . |inv|)
              (35 . *) (|NonNegativeInteger|) (41 . |degree|) (46 . |Zero|)
              (50 . |Zero|) (|Symbol|) (54 . D) (|Boolean|) (60 . =)
              (66 . |coefficients|) (|Mapping| 32 7) (71 . |every?|)
              (77 . |coerce|) (82 . |One|) (86 . |One|) (90 . |coefficient|)
              (96 . *) (102 . |monomial|) (108 . |coerce|) (113 . -)
              (119 . |eval|) (126 . |is?|) (|Kernel| $) (132 . |coerce|)
              (|Vector| 7) (137 . |vector|) (|Union| 55 '"failed")
              (|IntegerLinearDependence| 7) (142 . |particularSolutionOverQ|)
              (|Record| (|:| |num| (|List| 21)) (|:| |den| 21)) (|Vector| 101)
              (|InnerCommonDenominator| 21 101 (|List| 21) 55)
              (148 . |splitDenominator|) (153 . ~=) (159 . ^) (|Mapping| 7 7 7)
              (165 . |reduce|) (171 . +) (177 . |coerce|) (182 . |coerce|)
              (187 . /) (193 . |One|) (197 . ~=) (|List| 9)
              (|PartialFractionUtilities| 7 9) (203 . |decompose|)
              (209 . |Zero|) (|Union| $ '"failed")
              (|SparseMultivariatePolynomial| 7 19) (213 . |exquo|) (|List| 19)
              (219 . |member?|) (225 . |One|) (229 . |One|) (233 . |monomial|)
              (240 . |coerce|) (|Mapping| 73 19) (|Mapping| 73 6)
              (|SparseMultivariatePolynomial| 6 19)
              (|PolynomialCategoryLifting| (|IndexedExponents| 19) 19 6 83 73)
              (245 . |map|) (|List| 47) (252 . |kernels|) (257 . ~=)
              (263 . |last|) (268 . |setDifference|)
              (|SparseMultivariatePolynomial| 6 47) (274 . |numer|)
              (279 . |denom|) (284 . |degree|) (290 . |exquo|) (296 . ^)
              (302 . *) (|Union| 7 '"failed") (308 . |retractIfCan|) (313 . /)
              (|Fraction| 21) (319 . |One|) (323 . |One|) (327 . *)
              (333 . |new|) (337 . |coerce|) (342 . -) (348 . |coefficients|)
              (|Union| 18 '"failed") (|List| 30) (|ExpressionLinearSolve| 6 7)
              (353 . |lin_sol|) (|Union| 138 '"failed") |INTDEN;solve_u;2FSU;6|
              (359 . |log|) (364 . |exp|) (369 . |li|) (|Fraction| 9)
              (374 . |coerce|) (|SparseUnivariatePolynomial| 118)
              (|Mapping| 118 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 9 118 120)
              (379 . |map|) (385 . |denom|) (390 . *) (|Mapping| 9 9 9)
              (396 . |reduce|) (402 . |exquo|) (408 . |numer|) (413 . /)
              (|SparseUnivariatePolynomial| $) (419 . |rootOf|) (424 . -)
              (429 . -) (435 . |differentiate|) (440 . |eval|)
              (447 . |retract|) (|List| 18) (452 . |elt|) (458 . |One|)
              (462 . |monomial|) (468 . |coerce|) (473 . -) (479 . +)
              (485 . |retract|) (|List| $) (490 . |zerosOf|) (495 . |retract|)
              (500 . |eval|) (507 . |Zero|)
              (|Record| (|:| |scalar| 101) (|:| |coeff| 120)
                        (|:| |logand| 120))
              (|List| 151) (|Record| (|:| |integrand| 118) (|:| |intvar| 118))
              (|List| 153) (|IntegrationResult| 118) (511 . |mkAnswer|)
              (518 . |polylog|)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 19) 19
                                                     6 83 7)
              (524 . |multivariate|) (530 . |tower|) (535 . ~=)
              (|IntegrationTools| 6 7) (541 . |varselect|) (547 . |Zero|)
              (|Record| (|:| |answer| 118) (|:| |logpart| 118) (|:| |ir| 155))
              |INTDEN;li_int;FKSR;13| |INTDEN;poly_int;FKSR;14|)
           '#(|solve_u| 551 |poly_int| 558 |li_int| 565) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|li_int|
                                 ((|Record|
                                   (|:| |answer|
                                        (|Fraction|
                                         (|SparseUnivariatePolynomial| |#2|)))
                                   (|:| |logpart|
                                        (|Fraction|
                                         (|SparseUnivariatePolynomial| |#2|)))
                                   (|:| |ir|
                                        (|IntegrationResult|
                                         (|Fraction|
                                          (|SparseUnivariatePolynomial|
                                           |#2|)))))
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial| |#2|))
                                  (|Kernel| |#2|) (|Symbol|)))
                                T)
                              '((|poly_int|
                                 ((|Record|
                                   (|:| |answer|
                                        (|Fraction|
                                         (|SparseUnivariatePolynomial| |#2|)))
                                   (|:| |logpart|
                                        (|Fraction|
                                         (|SparseUnivariatePolynomial| |#2|)))
                                   (|:| |ir|
                                        (|IntegrationResult|
                                         (|Fraction|
                                          (|SparseUnivariatePolynomial|
                                           |#2|)))))
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial| |#2|))
                                  (|Kernel| |#2|) (|Symbol|)))
                                T)
                              '((|solve_u|
                                 ((|Union| (|List| (|List| |#2|)) "failed")
                                  |#2| |#2| (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 167
                                            '(1 10 8 9 11 1 8 14 0 15 0 16 0 17
                                              1 19 18 0 20 2 18 7 0 21 22 1 9 7
                                              0 23 1 7 0 0 24 2 9 0 7 0 25 1 9
                                              26 0 27 0 6 0 28 0 7 0 29 2 7 0 0
                                              30 31 2 7 32 0 0 33 1 9 18 0 34 2
                                              18 32 35 0 36 1 7 0 21 37 0 6 0
                                              38 0 7 0 39 2 9 7 0 26 40 2 7 0 0
                                              0 41 2 9 0 7 26 42 1 9 0 7 43 2 9
                                              0 0 0 44 3 9 0 0 16 0 45 2 19 32
                                              0 30 46 1 7 0 47 48 1 49 0 18 50
                                              2 52 51 49 7 53 1 56 54 55 57 2
                                              21 32 0 0 58 2 7 0 0 21 59 2 18 7
                                              60 0 61 2 7 0 0 0 62 1 6 0 21 63
                                              1 7 0 6 64 2 7 0 0 0 65 0 9 0 66
                                              2 9 32 0 0 67 2 69 68 9 68 70 0 9
                                              0 71 2 73 72 0 0 74 2 75 32 19 0
                                              76 0 73 0 77 0 26 0 78 3 73 0 0
                                              19 26 79 1 73 0 7 80 3 84 73 81
                                              82 83 85 1 7 86 0 87 2 7 32 0 0
                                              88 1 75 19 0 89 2 75 0 0 0 90 1 7
                                              91 0 92 1 7 91 0 93 2 73 26 0 19
                                              94 2 26 72 0 0 95 2 73 0 0 26 96
                                              2 73 0 0 0 97 1 73 98 0 99 2 73 0
                                              0 7 100 0 101 0 102 0 83 0 103 2
                                              73 0 7 0 104 0 30 0 105 1 7 0 30
                                              106 2 73 0 0 0 107 1 73 18 0 108
                                              2 111 109 18 110 112 1 7 0 0 115
                                              1 7 0 0 116 1 7 0 0 117 1 118 0 9
                                              119 2 122 120 121 9 123 1 118 9 0
                                              124 2 9 0 0 0 125 2 68 9 126 0
                                              127 2 9 72 0 0 128 1 118 9 0 129
                                              2 118 0 9 9 130 1 7 0 131 132 1 7
                                              0 0 133 2 7 0 0 0 134 1 9 0 0 135
                                              3 9 0 0 16 7 136 1 9 7 0 137 2
                                              138 18 0 21 139 0 118 0 140 2 120
                                              0 118 26 141 1 120 0 118 142 2
                                              120 0 0 0 143 2 118 0 0 0 144 1 7
                                              47 0 145 1 7 146 131 147 1 7 21 0
                                              148 3 7 0 0 47 0 149 0 118 0 150
                                              3 155 0 118 152 154 156 2 7 0 0 0
                                              157 2 158 7 118 19 159 1 7 86 0
                                              160 2 19 32 0 0 161 2 162 75 75
                                              30 163 0 155 0 164 3 0 113 7 7 30
                                              114 3 0 165 118 19 30 167 3 0 165
                                              118 19 30 166)))))
           '|lookupComplete|)) 

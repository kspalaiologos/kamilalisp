
(SDEFUN |FR;convert;$If;1| ((|x| ($)) ($ (|InputForm|)))
        (SPROG
         ((|l| (|List| (|InputForm|))) (|iFun| (|List| (|InputForm|)))
          (|iExpon| (|InputForm|)) (|iFactor| (|InputForm|)) (#1=#:G797 NIL)
          (|rec| NIL)
          (|lf|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| R)
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ
          (COND
           ((NULL (LETT |lf| (REVERSE (SPADCALL |x| (QREFELT $ 11)))))
            (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 14)))
           (#2='T
            (SEQ (LETT |l| NIL)
                 (SEQ (LETT |rec| NIL) (LETT #1# |lf|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (QVELT |rec| 1) (|spadConstant| $ 15)
                                    (QREFELT $ 17))
                          (SPADCALL
                           "WARNING (convert$Factored): 1 should not appear as factor."
                           (QREFELT $ 21)))
                         ('T
                          (SEQ
                           (LETT |iFactor|
                                 (SPADCALL
                                  (SPADCALL (QVELT |rec| 1) (QREFELT $ 14))
                                  (QREFELT $ 23)))
                           (LETT |iExpon|
                                 (SPADCALL (QVELT |rec| 2) (QREFELT $ 25)))
                           (LETT |iFun|
                                 (COND
                                  ((QEQCAR (QVELT |rec| 0) 0)
                                   (LIST (SPADCALL '|nilFactor| (QREFELT $ 27))
                                         |iFactor| |iExpon|))
                                  ((QEQCAR (QVELT |rec| 0) 1)
                                   (LIST
                                    (SPADCALL '|sqfrFactor| (QREFELT $ 27))
                                    |iFactor| |iExpon|))
                                  ((QEQCAR (QVELT |rec| 0) 3)
                                   (LIST
                                    (SPADCALL '|primeFactor| (QREFELT $ 27))
                                    |iFactor| |iExpon|))
                                  ((QEQCAR (QVELT |rec| 0) 2)
                                   (LIST
                                    (SPADCALL '|irreducibleFactor|
                                              (QREFELT $ 27))
                                    |iFactor| |iExpon|))
                                  ('T NIL)))
                           (EXIT (LETT |l| (CONS |iFun| |l|))))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (COND
                   ((NULL |l|)
                    (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 14)))
                   (#2#
                    (SEQ
                     (COND
                      ((SPADCALL (SPADCALL |x| (QREFELT $ 12))
                                 (|spadConstant| $ 15) (QREFELT $ 28))
                       (LETT |l|
                             (CONS
                              (SPADCALL (SPADCALL |x| (QREFELT $ 12))
                                        (QREFELT $ 14))
                              |l|))))
                     (EXIT
                      (COND ((NULL (CDR |l|)) (|SPADfirst| |l|))
                            (#2#
                             (SPADCALL (SPADCALL '* (QREFELT $ 27)) |l|
                                       (QREFELT $ 30))))))))))))))) 

(SDEFUN |FR;nilFactor;RNni$;2| ((|r| (R)) (|i| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |r| |i| (CONS 0 "nil") (QREFELT $ 35))) 

(SDEFUN |FR;sqfrFactor;RNni$;3|
        ((|r| (R)) (|i| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |r| |i| (CONS 1 "sqfr") (QREFELT $ 35))) 

(SDEFUN |FR;irreducibleFactor;RNni$;4|
        ((|r| (R)) (|i| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |r| |i| (CONS 2 "irred") (QREFELT $ 35))) 

(SDEFUN |FR;primeFactor;RNni$;5|
        ((|r| (R)) (|i| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |r| |i| (CONS 3 "prime") (QREFELT $ 35))) 

(SDEFUN |FR;unit?;$B;6| ((|u| ($)) ($ (|Boolean|)))
        (COND ((NULL (QCDR |u|)) (NULL (SPADCALL (QCAR |u|) (QREFELT $ 40))))
              ('T NIL))) 

(PUT '|FR;factorList;$L;7| '|SPADreplace| 'QCDR) 

(SDEFUN |FR;factorList;$L;7|
        ((|u| ($))
         ($
          (|List|
           (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                     (|:| |factor| R)
                     (|:| |exponent| (|NonNegativeInteger|))))))
        (QCDR |u|)) 

(PUT '|FR;unit;$R;8| '|SPADreplace| 'QCAR) 

(SDEFUN |FR;unit;$R;8| ((|u| ($)) ($ (R))) (QCAR |u|)) 

(SDEFUN |FR;numberOfFactors;$Nni;9| ((|u| ($)) ($ (|NonNegativeInteger|)))
        (LENGTH (QCDR |u|))) 

(SDEFUN |FR;Zero;$;10| (($ ($)))
        (CONS (|spadConstant| $ 15)
              (LIST (VECTOR (CONS 0 "nil") (|spadConstant| $ 45) 1)))) 

(SDEFUN |FR;zero?;$B;11| ((|u| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QCDR |u|) 1 (QREFELT $ 46))
          (COND
           ((QEQCAR (QVELT (|SPADfirst| (QCDR |u|)) 0) 0)
            (COND
             ((SPADCALL (QVELT (|SPADfirst| (QCDR |u|)) 1) (QREFELT $ 40))
              (SPADCALL (QCAR |u|) (|spadConstant| $ 15) (QREFELT $ 17)))
             (#1='T NIL)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |FR;One;$;12| (($ ($))) (CONS (|spadConstant| $ 15) NIL)) 

(SDEFUN |FR;one?;$B;13| ((|u| ($)) ($ (|Boolean|)))
        (COND
         ((NULL (QCDR |u|))
          (SPADCALL (QCAR |u|) (|spadConstant| $ 15) (QREFELT $ 17)))
         ('T NIL))) 

(PUT '|FR;mkFF| '|SPADreplace| 'CONS) 

(SDEFUN |FR;mkFF|
        ((|r| (R))
         (|x|
          (|List|
           (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                     (|:| |factor| R)
                     (|:| |exponent| (|NonNegativeInteger|)))))
         ($ ($)))
        (CONS |r| |x|)) 

(SDEFUN |FR;coerce;I$;15| ((|j| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |j| (QREFELT $ 49)) (QREFELT $ 50))) 

(SDEFUN |FR;characteristic;Nni;16| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 52))) 

(SDEFUN |FR;*;I2$;17| ((|i| (|Integer|)) (|u| ($)) ($ ($)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 51)) |u| (QREFELT $ 54))) 

(SDEFUN |FR;*;R2$;18| ((|r| (R)) (|u| ($)) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 50)) |u| (QREFELT $ 54))) 

(SDEFUN |FR;factors;$L;19|
        ((|u| ($))
         ($
          (|List|
           (|Record| (|:| |factor| R)
                     (|:| |exponent| (|NonNegativeInteger|))))))
        (SPROG ((#1=#:G877 NIL) (|fe| NIL) (#2=#:G876 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |fe| NIL) (LETT #1# (SPADCALL |u| (QREFELT $ 11)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |fe| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (CONS (QVELT |fe| 1) (QVELT |fe| 2))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FR;expand;$R;20| ((|u| ($)) ($ (R)))
        (SPROG
         ((#1=#:G881 NIL) (#2=#:G880 (R)) (#3=#:G882 (R)) (#4=#:G884 NIL)
          (|y| NIL))
         (SEQ
          (SPADCALL (SPADCALL |u| (QREFELT $ 12))
                    (PROGN
                     (LETT #1# NIL)
                     (SEQ (LETT |y| NIL)
                          (LETT #4# (SPADCALL |u| (QREFELT $ 11))) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |y| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #3#
                                   (SPADCALL (QVELT |y| 1) (QVELT |y| 2)
                                             (QREFELT $ 60)))
                             (COND
                              (#1#
                               (LETT #2# (SPADCALL #2# #3# (QREFELT $ 61))))
                              ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                          (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                     (COND (#1# #2#) ('T (|spadConstant| $ 15))))
                    (QREFELT $ 61))))) 

(SDEFUN |FR;makeFR;RL$;21|
        ((|u| (R))
         (|x|
          (|List|
           (|Record|
            (|:| |flag| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
            (|:| |factor| R) (|:| |exponent| (|NonNegativeInteger|)))))
         ($ ($)))
        (SPROG
         ((|f|
           #5=(|Record| (|:| |flag| (|Union| #1# #2# #3# #4#)) (|:| |factor| R)
                        (|:| |exponent| (|NonNegativeInteger|))))
          (|p|
           #6=(|List|
               (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#))
                         (|:| |factor| R)
                         (|:| |exponent| (|NonNegativeInteger|)))))
          (#7=#:G916 NIL) (|f1| #5#) (|o| #6#))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |u| (|spadConstant| $ 45) (QREFELT $ 17))
             (|spadConstant| $ 44))
            ((NULL |x|) (|FR;mkFF| |u| NIL $))
            (#8='T
             (SEQ
              (LETT |x|
                    (SPADCALL (CONS (|function| |FR;LispLessP|) $) |x|
                              (QREFELT $ 64)))
              (SEQ G190
                   (COND
                    ((NULL
                      (COND ((NULL |x|) NIL)
                            ('T (EQL (QVELT (|SPADfirst| |x|) 2) 0))))
                     (GO G191)))
                   (SEQ (EXIT (LETT |x| (CDR |x|)))) NIL (GO G190) G191
                   (EXIT NIL))
              (EXIT
               (COND ((NULL |x|) (|FR;mkFF| |u| NIL $))
                     (#8#
                      (SEQ (LETT |o| |x|) (LETT |p| |x|)
                           (LETT |f| (|SPADfirst| |p|))
                           (EXIT
                            (COND
                             ((SPADCALL (QVELT |f| 1) (|spadConstant| $ 45)
                                        (QREFELT $ 17))
                              (|spadConstant| $ 44))
                             (#8#
                              (SEQ (LETT |x| (CDR |x|))
                                   (SEQ G190
                                        (COND
                                         ((NULL (NULL (NULL |x|))) (GO G191)))
                                        (SEQ (LETT |f1| (|SPADfirst| |x|))
                                             (EXIT
                                              (COND
                                               ((EQL (QVELT |f1| 2) 0)
                                                (SEQ
                                                 (SPADCALL |p| (CDR |x|)
                                                           (QREFELT $ 65))
                                                 (EXIT (LETT |x| (CDR |x|)))))
                                               ((SPADCALL (QVELT |f1| 1)
                                                          (|spadConstant| $ 45)
                                                          (QREFELT $ 17))
                                                (PROGN
                                                 (LETT #7#
                                                       (|spadConstant| $ 44))
                                                 (GO #9=#:G915)))
                                               ((SPADCALL (QVELT |f1| 1)
                                                          (QVELT |f| 1)
                                                          (QREFELT $ 17))
                                                (SEQ
                                                 (LETT |f|
                                                       (VECTOR
                                                        (|FR;stricterFlag|
                                                         (QVELT |f| 0)
                                                         (QVELT |f1| 0) $)
                                                        (QVELT |f| 1)
                                                        (+ (QVELT |f| 2)
                                                           (QVELT |f1| 2))))
                                                 (SPADCALL |p| |f|
                                                           (QREFELT $ 66))
                                                 (SPADCALL |p| (CDR |x|)
                                                           (QREFELT $ 65))
                                                 (EXIT (LETT |x| (CDR |x|)))))
                                               ('T
                                                (SEQ (LETT |p| |x|)
                                                     (LETT |f| |f1|)
                                                     (EXIT
                                                      (LETT |x|
                                                            (CDR |x|))))))))
                                        NIL (GO G190) G191 (EXIT NIL))
                                   (EXIT
                                    (SPADCALL (|FR;mkFF| |u| |o| $)
                                              (QREFELT $ 67)))))))))))))))
          #9# (EXIT #7#)))) 

(PUT '|FR;rational?;$B;22| '|SPADreplace| '(XLAM (|x|) 'T)) 

(SDEFUN |FR;rational?;$B;22| ((|x| ($)) ($ (|Boolean|))) 'T) 

(SDEFUN |FR;rationalIfCan;$U;23|
        ((|x| ($)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (CONS 0 (SPADCALL |x| (QREFELT $ 71)))) 

(SDEFUN |FR;rational;$F;24| ((|x| ($)) ($ (|Fraction| (|Integer|))))
        (SPROG
         ((#1=#:G931 NIL) (#2=#:G930 #3=(|Fraction| (|Integer|)))
          (#4=#:G932 #3#) (#5=#:G934 NIL) (|f| NIL))
         (SEQ
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 74))
                    (PROGN
                     (LETT #1# NIL)
                     (SEQ (LETT |f| NIL)
                          (LETT #5# (SPADCALL |x| (QREFELT $ 11))) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #4#
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL (QVELT |f| 1) (QREFELT $ 74))
                                     (QREFELT $ 75))
                                    (QVELT |f| 2) (QREFELT $ 76)))
                             (COND
                              (#1#
                               (LETT #2# (SPADCALL #2# #4# (QREFELT $ 77))))
                              ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                     (COND (#1# #2#) ('T (|spadConstant| $ 78))))
                    (QREFELT $ 79))))) 

(SDEFUN |FR;elt;3$;25| ((|x| ($)) (|v| ($)) ($ ($)))
        (SPADCALL |x| (SPADCALL |v| (QREFELT $ 62)) (QREFELT $ 80))) 

(SDEFUN |FR;eval;$L$;26| ((|x| ($)) (|l| (|List| (|Equation| $))) ($ ($)))
        (SPROG ((#1=#:G940 NIL) (|e| NIL) (#2=#:G939 NIL))
               (SEQ
                (SPADCALL |x|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |e| NIL) (LETT #1# |l|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |e| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |e| (QREFELT $ 83))
                                           (QREFELT $ 62))
                                          (SPADCALL
                                           (SPADCALL |e| (QREFELT $ 84))
                                           (QREFELT $ 62))
                                          (QREFELT $ 86))
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 88))))) 

(SDEFUN |FR;eval;$LL$;27|
        ((|x| ($)) (|ls| (|List| (|Symbol|))) (|lv| (|List| $)) ($ ($)))
        (SPROG ((#1=#:G945 NIL) (|v| NIL) (#2=#:G944 NIL))
               (SEQ
                (SPADCALL |x| |ls|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |v| NIL) (LETT #1# |lv|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |v| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |v| (QREFELT $ 62))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 93))))) 

(SDEFUN |FR;convert;$F;28| ((|x| ($)) ($ (|Float|)))
        (SPROG
         ((#1=#:G953 NIL) (#2=#:G952 #3=(|Float|)) (#4=#:G954 #3#)
          (#5=#:G956 NIL) (|f| NIL))
         (SEQ
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 96))
                    (PROGN
                     (LETT #1# NIL)
                     (SEQ (LETT |f| NIL)
                          (LETT #5# (SPADCALL |x| (QREFELT $ 11))) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #4#
                                   (SPADCALL
                                    (SPADCALL (QVELT |f| 1) (QREFELT $ 96))
                                    (QVELT |f| 2) (QREFELT $ 97)))
                             (COND
                              (#1#
                               (LETT #2# (SPADCALL #2# #4# (QREFELT $ 98))))
                              ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                     (COND (#1# #2#) ('T (|spadConstant| $ 99))))
                    (QREFELT $ 98))))) 

(SDEFUN |FR;convert;$Df;29| ((|x| ($)) ($ (|DoubleFloat|)))
        (SPROG
         ((#1=#:G963 NIL) (#2=#:G962 #3=(|DoubleFloat|)) (#4=#:G964 #3#)
          (#5=#:G966 NIL) (|f| NIL))
         (SEQ
          (|mul_DF| (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 102))
                    (PROGN
                     (LETT #1# NIL)
                     (SEQ (LETT |f| NIL)
                          (LETT #5# (SPADCALL |x| (QREFELT $ 11))) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #4#
                                   (|expt_DF_I|
                                    (SPADCALL (QVELT |f| 1) (QREFELT $ 102))
                                    (QVELT |f| 2)))
                             (COND (#1# (LETT #2# (|mul_DF| #2# #4#)))
                                   ('T
                                    (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                     (COND (#1# #2#) ('T 1.0))))))) 

(SDEFUN |FR;*;3$;30| ((|u| ($)) (|v| ($)) ($ ($)))
        (SPROG
         ((|res|
           (|List|
            (|Record|
             (|:| |flag| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
             (|:| |factor| R) (|:| |exponent| (|NonNegativeInteger|)))))
          (|lv|
           #5=(|List|
               (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#))
                         (|:| |factor| R)
                         (|:| |exponent| (|NonNegativeInteger|)))))
          (|lu| #5#)
          (|v1|
           #6=(|Record| (|:| |flag| (|Union| #1# #2# #3# #4#)) (|:| |factor| R)
                        (|:| |exponent| (|NonNegativeInteger|))))
          (|u1| #6#))
         (SEQ
          (COND
           ((OR (SPADCALL |u| (QREFELT $ 47)) (SPADCALL |v| (QREFELT $ 47)))
            (|spadConstant| $ 44))
           ('T
            (COND ((SPADCALL |u| (QREFELT $ 48)) |v|)
                  ((SPADCALL |v| (QREFELT $ 48)) |u|)
                  (#7='T
                   (SEQ (LETT |lu| (SPADCALL |u| (QREFELT $ 11)))
                        (LETT |lv| (SPADCALL |v| (QREFELT $ 11)))
                        (LETT |res| NIL)
                        (SEQ G190
                             (COND
                              ((NULL
                                (COND ((NULL |lu|) NIL)
                                      ('T (NULL (NULL |lv|)))))
                               (GO G191)))
                             (SEQ (LETT |u1| (|SPADfirst| |lu|))
                                  (LETT |v1| (|SPADfirst| |lv|))
                                  (EXIT
                                   (COND
                                    ((SPADCALL (QVELT |u1| 1) (QVELT |v1| 1)
                                               (QREFELT $ 17))
                                     (SEQ
                                      (LETT |res|
                                            (CONS
                                             (VECTOR
                                              (|FR;stricterFlag| (QVELT |u1| 0)
                                               (QVELT |v1| 0) $)
                                              (QVELT |u1| 1)
                                              (+ (QVELT |u1| 2)
                                                 (QVELT |v1| 2)))
                                             |res|))
                                      (LETT |lu| (CDR |lu|))
                                      (EXIT (LETT |lv| (CDR |lv|)))))
                                    ((|FR;LispLessP| |u1| |v1| $)
                                     (SEQ (LETT |res| (CONS |u1| |res|))
                                          (EXIT (LETT |lu| (CDR |lu|)))))
                                    ('T
                                     (SEQ (LETT |res| (CONS |v1| |res|))
                                          (EXIT (LETT |lv| (CDR |lv|))))))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (LETT |res|
                              (SPADCALL (NREVERSE |res|)
                                        (COND ((NULL |lu|) |lv|) (#7# |lu|))
                                        (QREFELT $ 104)))
                        (EXIT
                         (|FR;mkFF|
                          (SPADCALL (SPADCALL |u| (QREFELT $ 12))
                                    (SPADCALL |v| (QREFELT $ 12))
                                    (QREFELT $ 61))
                          |res| $)))))))))) 

(SDEFUN |FR;^;$Nni$;31| ((|u| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((#1=#:G1004 NIL) (|x| NIL) (#2=#:G1003 NIL))
               (SEQ
                (COND ((EQL |n| 0) (|spadConstant| $ 43)) ((EQL |n| 1) |u|)
                      ('T
                       (|FR;mkFF|
                        (SPADCALL (SPADCALL |u| (QREFELT $ 12)) |n|
                                  (QREFELT $ 60))
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |x| NIL)
                              (LETT #1# (SPADCALL |u| (QREFELT $ 11))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |x| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS
                                       (VECTOR (QVELT |x| 0) (QVELT |x| 1)
                                               (* |n| (QVELT |x| 2)))
                                       #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))
                        $)))))) 

(SDEFUN |FR;coerce;$Of;32| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|e| (|OutputForm|)) (|l| (|List| (|OutputForm|))) (#1=#:G1022 NIL)
          (|rec| NIL)
          (|lf|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| R)
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ
          (COND
           ((NULL (LETT |lf| (REVERSE (SPADCALL |x| (QREFELT $ 11)))))
            (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 106)))
           (#2='T
            (SEQ (LETT |l| NIL)
                 (SEQ (LETT |rec| NIL) (LETT #1# |lf|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (QVELT |rec| 1) (|spadConstant| $ 15)
                                    (QREFELT $ 17))
                          (SPADCALL
                           "WARNING (coerce$Factored): 1 should not appear as factor."
                           (QREFELT $ 21)))
                         ((EQL (QVELT |rec| 2) 1)
                          (LETT |l|
                                (CONS
                                 (SPADCALL (QVELT |rec| 1) (QREFELT $ 106))
                                 |l|)))
                         ('T
                          (LETT |l|
                                (CONS
                                 (SPADCALL
                                  (SPADCALL (QVELT |rec| 1) (QREFELT $ 106))
                                  (SPADCALL (QVELT |rec| 2) (QREFELT $ 107))
                                  (QREFELT $ 108))
                                 |l|))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (COND
                   ((NULL |l|)
                    (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 106)))
                   (#2#
                    (SEQ
                     (LETT |e|
                           (COND ((NULL (CDR |l|)) (|SPADfirst| |l|))
                                 (#2#
                                  (SPADCALL (ELT $ 109) |l| (QREFELT $ 112)))))
                     (EXIT
                      (COND
                       ((SPADCALL (|spadConstant| $ 15)
                                  (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 17))
                        |e|)
                       (#2#
                        (SPADCALL
                         (SPADCALL (SPADCALL |x| (QREFELT $ 12))
                                   (QREFELT $ 106))
                         |e| (QREFELT $ 109))))))))))))))) 

(SDEFUN |FR;retract;$R;33| ((|u| ($)) ($ (R))) (SPADCALL |u| (QREFELT $ 62))) 

(SDEFUN |FR;retractIfCan;$U;34| ((|u| ($)) ($ (|Union| R "failed")))
        (CONS 0 (SPADCALL |u| (QREFELT $ 62)))) 

(SDEFUN |FR;LispLessP|
        ((|y|
          (|Record|
           (|:| |flag| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
           (|:| |factor| R) (|:| |exponent| (|NonNegativeInteger|))))
         (|y1|
          (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#)) (|:| |factor| R)
                    (|:| |exponent| (|NonNegativeInteger|))))
         ($ (|Boolean|)))
        (COND
         ((QREFELT $ 32)
          (SPADCALL (QVELT |y| 1) (QVELT |y1| 1) (QREFELT $ 117)))
         ((QREFELT $ 33)
          (SPADCALL (QVELT |y| 1) (QVELT |y1| 1) (QREFELT $ 118)))
         ('T (NULL (GGREATERP (QVELT |y| 1) (QVELT |y1| 1)))))) 

(SDEFUN |FR;stricterFlag|
        ((|fl1| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
         (|fl2| (|Union| #1# #2# #3# #4#)) ($ (|Union| #1# #2# #3# #4#)))
        (COND ((QEQCAR |fl1| 3) |fl1|)
              ((QEQCAR |fl1| 2) (COND ((QEQCAR |fl2| 3) |fl2|) (#5='T |fl1|)))
              ((QEQCAR |fl1| 1) (COND ((QEQCAR |fl2| 0) |fl1|) (#5# |fl2|)))
              (#5# |fl2|))) 

(SDEFUN |FR;coerce;R$;37| ((|r| (R)) ($ ($))) (SPADCALL |r| (QREFELT $ 121))) 

(SDEFUN |FR;coerce;R$;38| ((|r| (R)) ($ ($)))
        (COND ((SPADCALL |r| (QREFELT $ 40)) (|spadConstant| $ 44))
              ((SPADCALL |r| (QREFELT $ 122)) (|FR;mkFF| |r| NIL $))
              ((|HasCategory| (QREFELT $ 6) '(|Field|))
               (|error| "zero divisor in a field"))
              ('T (SPADCALL (SPADCALL |r| (QREFELT $ 124)) (QREFELT $ 67))))) 

(SDEFUN |FR;coerce;R$;39| ((|r| (R)) ($ ($)))
        (COND
         ((SPADCALL |r| (|spadConstant| $ 15) (QREFELT $ 17))
          (|spadConstant| $ 43))
         ('T
          (SPADCALL
           (|FR;mkFF| (|spadConstant| $ 15)
            (LIST (VECTOR (CONS 0 "nil") |r| 1)) $)
           (QREFELT $ 67))))) 

(SDEFUN |FR;=;2$B;40| ((|u| ($)) (|v| ($)) ($ (|Boolean|)))
        (SPROG
         ((|lv|
           #1=(|List|
               (|Record|
                (|:| |flag| (|Union| #2="nil" #3="sqfr" #4="irred" #5="prime"))
                (|:| |factor| R) (|:| |exponent| (|NonNegativeInteger|)))))
          (|lu| #1#) (#6=#:G1075 NIL)
          (|v1|
           #7=(|Record| (|:| |flag| (|Union| #2# #3# #4# #5#)) (|:| |factor| R)
                        (|:| |exponent| (|NonNegativeInteger|))))
          (|u1| #7#))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |u| (QREFELT $ 12))
                       (SPADCALL |v| (QREFELT $ 12)) (QREFELT $ 28))
             NIL)
            (#8='T
             (SEQ (LETT |lu| (SPADCALL |u| (QREFELT $ 11)))
                  (LETT |lv| (SPADCALL |v| (QREFELT $ 11)))
                  (SEQ G190
                       (COND
                        ((NULL
                          (COND ((NULL |lu|) NIL) ('T (NULL (NULL |lv|)))))
                         (GO G191)))
                       (SEQ (LETT |u1| (|SPADfirst| |lu|))
                            (LETT |v1| (|SPADfirst| |lv|))
                            (EXIT
                             (COND
                              ((OR
                                (SPADCALL (QVELT |u1| 2) (QVELT |v1| 2)
                                          (QREFELT $ 125))
                                (SPADCALL (QVELT |u1| 1) (QVELT |v1| 1)
                                          (QREFELT $ 28)))
                               (PROGN (LETT #6# NIL) (GO #9=#:G1074)))
                              ('T
                               (SEQ (LETT |lu| (CDR |lu|))
                                    (EXIT (LETT |lv| (CDR |lv|))))))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT (COND ((NULL |lu|) (NULL |lv|)) (#8# NIL)))))))
          #9# (EXIT #6#)))) 

(SDEFUN |FR;-;2$;41| ((|u| ($)) ($ ($)))
        (COND ((SPADCALL |u| (QREFELT $ 47)) |u|)
              ('T
               (|FR;mkFF|
                (SPADCALL (SPADCALL |u| (QREFELT $ 12)) (QREFELT $ 127))
                (SPADCALL |u| (QREFELT $ 11)) $)))) 

(SDEFUN |FR;recip;$U;42| ((|u| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|r| (|Union| R #1#)))
               (SEQ
                (COND
                 ((NULL (NULL (SPADCALL |u| (QREFELT $ 11))))
                  (CONS 1 "failed"))
                 ('T
                  (SEQ
                   (LETT |r|
                         (SPADCALL (SPADCALL |u| (QREFELT $ 12))
                                   (QREFELT $ 130)))
                   (EXIT
                    (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                          ('T (CONS 0 (|FR;mkFF| (QCDR |r|) NIL $))))))))))) 

(SDEFUN |FR;flagFactor;RNniU$;43|
        ((|r| (R)) (|i| (|NonNegativeInteger|))
         (|fl| (|Union| "nil" "sqfr" "irred" "prime")) ($ ($)))
        (COND ((ZEROP |i|) (|spadConstant| $ 43))
              ((SPADCALL |r| (QREFELT $ 40)) (|spadConstant| $ 44))
              ('T
               (SPADCALL
                (|FR;mkFF| (|spadConstant| $ 15) (LIST (VECTOR |fl| |r| |i|))
                 $)
                (QREFELT $ 67))))) 

(SDEFUN |FR;differentiate;$M$;44| ((|u| ($)) (|deriv| (|Mapping| R R)) ($ ($)))
        (SPROG
         ((#1=#:G1102 NIL) (#2=#:G1101 ($)) (#3=#:G1103 ($)) (#4=#:G1105 NIL)
          (#5=#:G1110 NIL) (|fact| NIL) (|ans| ($)))
         (SEQ
          (LETT |ans|
                (SPADCALL (SPADCALL (SPADCALL |u| (QREFELT $ 12)) |deriv|)
                          (|FR;mkFF| (|spadConstant| $ 15)
                           (SPADCALL |u| (QREFELT $ 11)) $)
                          (QREFELT $ 56)))
          (EXIT
           (SPADCALL |ans|
                     (PROGN
                      (LETT #1# NIL)
                      (SEQ (LETT |fact| NIL)
                           (LETT #5# (SPADCALL |u| (QREFELT $ 11))) G190
                           (COND
                            ((OR (ATOM #5#)
                                 (PROGN (LETT |fact| (CAR #5#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (PROGN
                              (LETT #3#
                                    (SPADCALL
                                     (SPADCALL (QVELT |fact| 2)
                                               (SPADCALL (QVELT |fact| 1)
                                                         |deriv|)
                                               (QREFELT $ 132))
                                     (PROG2
                                         (LETT #4#
                                               (SPADCALL |u|
                                                         (SPADCALL
                                                          (QVELT |fact| 1) 1
                                                          (QREFELT $ 36))
                                                         (QREFELT $ 133)))
                                         (QCDR #4#)
                                       (|check_union2| (QEQCAR #4# 0) $
                                                       (|Union| $ "failed")
                                                       #4#))
                                     (QREFELT $ 56)))
                              (COND
                               (#1#
                                (LETT #2# (SPADCALL #2# #3# (QREFELT $ 134))))
                               ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                           (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                      (COND (#1# #2#) ('T (|spadConstant| $ 44))))
                     (QREFELT $ 134)))))) 

(SDEFUN |FR;map;M2$;45| ((|fn| (|Mapping| R R)) (|u| ($)) ($ ($)))
        (SPROG
         ((|l|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| R)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#1=#:G1124 NIL) (|f| NIL) (#2=#:G1123 NIL))
         (SEQ
          (LETT |l|
                (CONS
                 (VECTOR (CONS 0 "nil")
                         (SPADCALL (SPADCALL |u| (QREFELT $ 12)) |fn|) 1)
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |f| NIL) (LETT #1# (SPADCALL |u| (QREFELT $ 11)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (VECTOR (CONS 0 "nil")
                                        (SPADCALL (QVELT |f| 1) |fn|)
                                        (QVELT |f| 2))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))))
          (EXIT (SPADCALL (|spadConstant| $ 15) |l| (QREFELT $ 68)))))) 

(SDEFUN |FR;mergeFactors;3$;46| ((|f| ($)) (|g| ($)) ($ ($)))
        (|FR;mkFF|
         (SPADCALL (SPADCALL |f| (QREFELT $ 12)) (SPADCALL |g| (QREFELT $ 12))
                   (QREFELT $ 61))
         (SPADCALL (CONS (|function| |FR;LispLessP|) $)
                   (SPADCALL |f| (QREFELT $ 11)) (SPADCALL |g| (QREFELT $ 11))
                   (QREFELT $ 138))
         $)) 

(SDEFUN |FR;exquo;2$U;47| ((|u| ($)) (|v| ($)) ($ (|Union| $ #1="failed")))
        (SPROG
         ((#2=#:G1162 NIL)
          (|lu|
           #3=(|List|
               #4=(|Record|
                   (|:| |flag|
                        (|Union| #5="nil" #6="sqfr" #7="irred" #8="prime"))
                   (|:| |factor| R) (|:| |exponent| (|NonNegativeInteger|)))))
          (|res|
           (|List|
            (|Record| (|:| |flag| (|Union| #5# #6# #7# #8#)) (|:| |factor| R)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|lv| #3#) (|newfactor| #4#) (#9=#:G1146 NIL) (|expn| (|Integer|))
          (|v1|
           #10=(|Record| (|:| |flag| (|Union| #5# #6# #7# #8#))
                         (|:| |factor| R)
                         (|:| |exponent| (|NonNegativeInteger|))))
          (|u1| #10#) (|newunit| (R)) (#11=#:G1135 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |newunit|
                  (PROG2
                      (LETT #11#
                            (SPADCALL (SPADCALL |u| (QREFELT $ 12))
                                      (SPADCALL |v| (QREFELT $ 12))
                                      (QREFELT $ 140)))
                      (QCDR #11#)
                    (|check_union2| (QEQCAR #11# 0) (QREFELT $ 6)
                                    (|Union| (QREFELT $ 6) #1#) #11#)))
            (LETT |lu| (SPADCALL |u| (QREFELT $ 11)))
            (LETT |lv| (SPADCALL |v| (QREFELT $ 11)))
            (EXIT
             (COND ((NULL |lv|) (CONS 0 (|FR;mkFF| |newunit| |lu| $)))
                   ('T
                    (SEQ (LETT |res| NIL)
                         (SEQ G190
                              (COND
                               ((NULL
                                 (COND ((NULL |lu|) NIL)
                                       ('T (NULL (NULL |lv|)))))
                                (GO G191)))
                              (SEQ (LETT |u1| (|SPADfirst| |lu|))
                                   (LETT |v1| (|SPADfirst| |lv|))
                                   (EXIT
                                    (COND
                                     ((SPADCALL (QVELT |u1| 1) (QVELT |v1| 1)
                                                (QREFELT $ 17))
                                      (SEQ
                                       (LETT |expn|
                                             (- (QVELT |u1| 2) (QVELT |v1| 2)))
                                       (EXIT
                                        (COND
                                         ((< |expn| 0)
                                          (PROGN
                                           (LETT #2# (CONS 1 "failed"))
                                           (GO #12=#:G1161)))
                                         ('T
                                          (SEQ
                                           (COND
                                            ((> |expn| 0)
                                             (SEQ
                                              (LETT |newfactor|
                                                    (VECTOR
                                                     (|FR;stricterFlag|
                                                      (QVELT |u1| 0)
                                                      (QVELT |v1| 0) $)
                                                     (QVELT |u1| 1)
                                                     (PROG1 (LETT #9# |expn|)
                                                       (|check_subtype2|
                                                        (>= #9# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #9#))))
                                              (EXIT
                                               (LETT |res|
                                                     (CONS |newfactor|
                                                           |res|))))))
                                           (LETT |lu| (CDR |lu|))
                                           (EXIT (LETT |lv| (CDR |lv|)))))))))
                                     ((|FR;LispLessP| |u1| |v1| $)
                                      (SEQ (LETT |res| (CONS |u1| |res|))
                                           (EXIT (LETT |lu| (CDR |lu|)))))
                                     ('T
                                      (PROGN
                                       (LETT #2# (CONS 1 "failed"))
                                       (GO #12#))))))
                              NIL (GO G190) G191 (EXIT NIL))
                         (COND ((NULL (NULL |lv|)) (EXIT (CONS 1 "failed"))))
                         (EXIT
                          (CONS 0
                                (|FR;mkFF| |newunit|
                                 (SPADCALL (NREVERSE |res|) |lu|
                                           (QREFELT $ 104))
                                 $)))))))))
          #12# (EXIT #2#)))) 

(SDEFUN |FR;unitNormal;$R;48|
        ((|u| ($))
         ($ (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))))
        (SPROG
         ((|vl|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| R)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|as| (R)) (|un| (R)) (|e| (|NonNegativeInteger|))
          (|ucar|
           (|Record| (|:| |unit| R) (|:| |canonical| R) (|:| |associate| R)))
          (#1=#:G1183 NIL) (|x| NIL) (|ur| (|Union| R "failed")))
         (SEQ
          (LETT |ur|
                (SPADCALL (LETT |un| (SPADCALL |u| (QREFELT $ 12)))
                          (QREFELT $ 130)))
          (EXIT
           (COND
            ((QEQCAR |ur| 1)
             (VECTOR (|spadConstant| $ 43) |u| (|spadConstant| $ 43)))
            ('T
             (SEQ (LETT |as| (QCDR |ur|)) (LETT |vl| NIL)
                  (SEQ (LETT |x| NIL) (LETT #1# (SPADCALL |u| (QREFELT $ 11)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |ucar| (SPADCALL (QVELT |x| 1) (QREFELT $ 142)))
                        (LETT |e| (QVELT |x| 2))
                        (LETT |un|
                              (SPADCALL |un|
                                        (SPADCALL (QVELT |ucar| 0) |e|
                                                  (QREFELT $ 60))
                                        (QREFELT $ 61)))
                        (LETT |as|
                              (SPADCALL |as|
                                        (SPADCALL (QVELT |ucar| 2) |e|
                                                  (QREFELT $ 60))
                                        (QREFELT $ 61)))
                        (EXIT
                         (COND
                          ((NULL
                            (SPADCALL (QVELT |ucar| 1) (|spadConstant| $ 15)
                                      (QREFELT $ 17)))
                           (LETT |vl|
                                 (CONS
                                  (VECTOR (QVELT |x| 0) (QVELT |ucar| 1) |e|)
                                  |vl|))))))
                       (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (VECTOR (|FR;mkFF| |un| NIL $)
                           (|FR;mkFF| (|spadConstant| $ 15) (NREVERSE |vl|) $)
                           (|FR;mkFF| |as| NIL $)))))))))) 

(SDEFUN |FR;unitNormalize;2$;49| ((|u| ($)) ($ ($)))
        (SPROG
         ((|uca|
           (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))))
         (SEQ (LETT |uca| (SPADCALL |u| (QREFELT $ 143)))
              (EXIT
               (|FR;mkFF|
                (SPADCALL (SPADCALL (QVELT |uca| 0) (QREFELT $ 12))
                          (SPADCALL (QVELT |uca| 1) (QREFELT $ 12))
                          (QREFELT $ 61))
                (SPADCALL (QVELT |uca| 1) (QREFELT $ 11)) $))))) 

(SDEFUN |FR;+;3$;50| ((|u| ($)) (|v| ($)) ($ ($)))
        (SPROG ((#1=#:G1190 NIL) (|eu1| (R)) (|u1| ($)))
               (SEQ
                (COND ((SPADCALL |u| (QREFELT $ 47)) |v|)
                      ((SPADCALL |v| (QREFELT $ 47)) |u|)
                      ('T
                       (SEQ (LETT |u1| (SPADCALL |u| |v| (QREFELT $ 144)))
                            (LETT |eu1| (SPADCALL |u1| (QREFELT $ 62)))
                            (EXIT
                             (SPADCALL
                              (SPADCALL
                               (PROG2
                                   (LETT #1#
                                         (SPADCALL
                                          (SPADCALL |u| (QREFELT $ 62)) |eu1|
                                          (QREFELT $ 140)))
                                   (QCDR #1#)
                                 (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                                 (|Union| (QREFELT $ 6)
                                                          #2="failed")
                                                 #1#))
                               (PROG2
                                   (LETT #1#
                                         (SPADCALL
                                          (SPADCALL |v| (QREFELT $ 62)) |eu1|
                                          (QREFELT $ 140)))
                                   (QCDR #1#)
                                 (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                                 (|Union| (QREFELT $ 6) #2#)
                                                 #1#))
                               (QREFELT $ 145))
                              |u1| (QREFELT $ 56))))))))) 

(SDEFUN |FR;all_primes|
        ((|lf|
          (|List|
           (|Record| (|:| |flag| #1=(|Union| "nil" "sqfr" "irred" "prime"))
                     (|:| |factor| R)
                     (|:| |exponent| (|NonNegativeInteger|)))))
         ($ (|Boolean|)))
        (SPROG ((#2=#:G1207 NIL) (|fg| #1#) (#3=#:G1208 NIL) (|f| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |f| NIL) (LETT #3# |lf|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |f| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ (LETT |fg| (QVELT |f| 0))
                            (EXIT
                             (COND
                              ((NULL (QEQCAR |fg| 3))
                               (COND
                                ((NULL (QEQCAR |fg| 2))
                                 (PROGN (LETT #2# NIL) (GO #4=#:G1206))))))))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |FR;all_sqf|
        ((|lf|
          (|List|
           (|Record| (|:| |flag| #1=(|Union| "nil" "sqfr" "irred" "prime"))
                     (|:| |factor| R)
                     (|:| |exponent| (|NonNegativeInteger|)))))
         ($ (|Boolean|)))
        (SPROG ((#2=#:G1220 NIL) (|fg| #1#) (#3=#:G1221 NIL) (|f| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |f| NIL) (LETT #3# |lf|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |f| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ (LETT |fg| (QVELT |f| 0))
                            (EXIT
                             (COND
                              ((QEQCAR |fg| 0)
                               (PROGN (LETT #2# NIL) (GO #4=#:G1219))))))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |FR;gcd1|
        ((|lu|
          (|List|
           (|Record|
            (|:| |flag| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
            (|:| |factor| R) (|:| |exponent| (|NonNegativeInteger|)))))
         (|lv|
          (|List|
           (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#)) (|:| |factor| R)
                     (|:| |exponent| (|NonNegativeInteger|)))))
         ($ ($)))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#)) (|:| |factor| R)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|ev| #5=(|NonNegativeInteger|)) (#6=#:G1264 NIL) (|f| NIL)
          (#7=#:G1265 NIL) (|i| NIL) (|eu| #5#) (#8=#:G1262 NIL)
          (#9=#:G1263 NIL) (|nf| (R)) (#10=#:G1261 NIL) (|j| NIL)
          (|fg| (|Union| #1# #2# #3# #4#)) (|tr| #11=(|Matrix| (|Integer|)))
          (|nfv| #12=(|Vector| R))
          (|dr| (|Record| (|:| |basis| #12#) (|:| |transform| #11#)))
          (#13=#:G1259 NIL) (#14=#:G1260 NIL) (#15=#:G1257 NIL)
          (#16=#:G1258 NIL) (|vr| (|Vector| R))
          (|nv| #17=(|NonNegativeInteger|)) (|nu| #17#) (|#G110| #17#)
          (|#G109| #17#))
         (SEQ
          (PROGN
           (LETT |#G109| (LENGTH |lu|))
           (LETT |#G110| (LENGTH |lv|))
           (LETT |nu| |#G109|)
           (LETT |nv| |#G110|))
          (LETT |vr| (MAKEARR1 (+ |nu| |nv|) (|spadConstant| $ 45)))
          (SEQ (LETT |i| 1) (LETT #16# |nu|) (LETT |f| NIL) (LETT #15# |lu|)
               G190
               (COND
                ((OR (ATOM #15#) (PROGN (LETT |f| (CAR #15#)) NIL)
                     (|greater_SI| |i| #16#))
                 (GO G191)))
               (SEQ (EXIT (SPADCALL |vr| |i| (QVELT |f| 1) (QREFELT $ 147))))
               (LETT #15# (PROG1 (CDR #15#) (LETT |i| (|inc_SI| |i|))))
               (GO G190) G191 (EXIT NIL))
          (SEQ (LETT |i| (+ |nu| 1)) (LETT #14# (+ |nu| |nv|)) (LETT |f| NIL)
               (LETT #13# |lv|) G190
               (COND
                ((OR (ATOM #13#) (PROGN (LETT |f| (CAR #13#)) NIL)
                     (> |i| #14#))
                 (GO G191)))
               (SEQ (EXIT (SPADCALL |vr| |i| (QVELT |f| 1) (QREFELT $ 147))))
               (LETT #13# (PROG1 (CDR #13#) (LETT |i| (+ |i| 1)))) (GO G190)
               G191 (EXIT NIL))
          (LETT |dr| (SPADCALL |vr| (QREFELT $ 150))) (LETT |nfv| (QCAR |dr|))
          (LETT |tr| (QCDR |dr|)) (LETT |res| NIL)
          (LETT |fg|
                (SEQ
                 (COND
                  ((|FR;all_sqf| |lu| $)
                   (COND ((|FR;all_sqf| |lv| $) (EXIT (CONS 1 "sqfr"))))))
                 (EXIT (CONS 0 "nil"))))
          (SEQ (LETT |j| 1) (LETT #10# (QVSIZE |nfv|)) G190
               (COND ((|greater_SI| |j| #10#) (GO G191)))
               (SEQ (LETT |nf| (SPADCALL |nfv| |j| (QREFELT $ 151)))
                    (EXIT
                     (COND ((SPADCALL |nf| (QREFELT $ 122)) "iterate")
                           ('T
                            (SEQ (LETT |eu| 0)
                                 (SEQ (LETT |i| 1) (LETT #9# |nu|)
                                      (LETT |f| NIL) (LETT #8# |lu|) G190
                                      (COND
                                       ((OR (ATOM #8#)
                                            (PROGN (LETT |f| (CAR #8#)) NIL)
                                            (|greater_SI| |i| #9#))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT |eu|
                                              (+ |eu|
                                                 (* (QVELT |f| 2)
                                                    (SPADCALL |tr| |j| |i|
                                                              (QREFELT $
                                                                       153)))))))
                                      (LETT #8#
                                            (PROG1 (CDR #8#)
                                              (LETT |i| (|inc_SI| |i|))))
                                      (GO G190) G191 (EXIT NIL))
                                 (EXIT
                                  (COND ((EQL |eu| 0) "iterate")
                                        ('T
                                         (SEQ (LETT |ev| 0)
                                              (SEQ (LETT |i| (+ |nu| 1))
                                                   (LETT #7# (+ |nu| |nv|))
                                                   (LETT |f| NIL)
                                                   (LETT #6# |lv|) G190
                                                   (COND
                                                    ((OR (ATOM #6#)
                                                         (PROGN
                                                          (LETT |f| (CAR #6#))
                                                          NIL)
                                                         (> |i| #7#))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT |ev|
                                                           (+ |ev|
                                                              (* (QVELT |f| 2)
                                                                 (SPADCALL |tr|
                                                                           |j|
                                                                           |i|
                                                                           (QREFELT
                                                                            $
                                                                            153)))))))
                                                   (LETT #6#
                                                         (PROG1 (CDR #6#)
                                                           (LETT |i|
                                                                 (+ |i| 1))))
                                                   (GO G190) G191 (EXIT NIL))
                                              (EXIT
                                               (COND ((EQL |ev| 0) "iterate")
                                                     ('T
                                                      (LETT |res|
                                                            (CONS
                                                             (VECTOR |fg| |nf|
                                                                     (MIN |eu|
                                                                          |ev|))
                                                             |res|))))))))))))))
               (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
          (LETT |res|
                (SPADCALL (CONS (|function| |FR;LispLessP|) $) |res|
                          (QREFELT $ 64)))
          (EXIT (|FR;mkFF| (|spadConstant| $ 15) |res| $))))) 

(SDEFUN |FR;gcd;3$;54| ((|u| ($)) (|v| ($)) ($ ($)))
        (SPROG
         ((#1=#:G1291 NIL)
          (|res|
           (|List|
            (|Record|
             (|:| |flag| (|Union| #2="nil" #3="sqfr" #4="irred" #5="prime"))
             (|:| |factor| R) (|:| |exponent| (|NonNegativeInteger|)))))
          (#6=#:G1293 NIL) (|v1| NIL) (#7=#:G1292 NIL) (|u1| NIL)
          (|lv|
           #8=(|List|
               (|Record| (|:| |flag| (|Union| #2# #3# #4# #5#))
                         (|:| |factor| R)
                         (|:| |exponent| (|NonNegativeInteger|)))))
          (|lu| #8#) (|#G125| #8#) (|#G124| #8#)
          (|nv| #9=(|NonNegativeInteger|)) (|nu| #9#) (|#G123| #9#)
          (|#G122| #9#))
         (SEQ
          (COND
           ((OR (SPADCALL |u| (QREFELT $ 48)) (SPADCALL |v| (QREFELT $ 48)))
            (|spadConstant| $ 43))
           ('T
            (COND ((SPADCALL |u| (QREFELT $ 47)) |v|)
                  ((SPADCALL |v| (QREFELT $ 47)) |u|)
                  (#10='T
                   (SEQ (LETT |lu| (SPADCALL |u| (QREFELT $ 11)))
                        (LETT |lv| (SPADCALL |v| (QREFELT $ 11)))
                        (COND
                         ((|FR;all_primes| |lu| $)
                          (COND
                           ((NULL (|FR;all_primes| |lv| $))
                            (EXIT (|FR;gcd1| |lu| |lv| $)))))
                         (#10# (EXIT (|FR;gcd1| |lu| |lv| $))))
                        (LETT |res| NIL)
                        (PROGN
                         (LETT |#G122| (LENGTH |lu|))
                         (LETT |#G123| (LENGTH |lv|))
                         (LETT |nu| |#G122|)
                         (LETT |nv| |#G123|))
                        (COND
                         ((> |nu| |nv|)
                          (PROGN
                           (LETT |#G124| |lv|)
                           (LETT |#G125| |lu|)
                           (LETT |lu| |#G124|)
                           (LETT |lv| |#G125|))))
                        (SEQ (LETT |u1| NIL) (LETT #7# |lu|) G190
                             (COND
                              ((OR (ATOM #7#)
                                   (PROGN (LETT |u1| (CAR #7#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |v1| NIL) (LETT #6# |lv|) G190
                                    (COND
                                     ((OR (ATOM #6#)
                                          (PROGN (LETT |v1| (CAR #6#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL (QVELT |u1| 1) (QVELT |v1| 1)
                                                  (QREFELT $ 17))
                                        (SEQ
                                         (LETT |res|
                                               (CONS
                                                (VECTOR
                                                 (|FR;stricterFlag|
                                                  (QVELT |u1| 0) (QVELT |v1| 0)
                                                  $)
                                                 (QVELT |u1| 1)
                                                 (MIN (QVELT |u1| 2)
                                                      (QVELT |v1| 2)))
                                                |res|))
                                         (EXIT
                                          (PROGN
                                           (LETT #1# 1)
                                           (GO #11=#:G1283))))))))
                                    (LETT #6# (CDR #6#)) (GO G190) G191
                                    (EXIT NIL)))
                              #11# (EXIT #1#))
                             (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (|FR;mkFF| (|spadConstant| $ 15) (NREVERSE |res|)
                          $)))))))))) 

(SDEFUN |FR;+;3$;55| ((|u| ($)) (|v| ($)) ($ ($)))
        (COND ((SPADCALL |u| (QREFELT $ 47)) |v|)
              ((SPADCALL |v| (QREFELT $ 47)) |u|)
              ('T
               (SPADCALL
                (SPADCALL (SPADCALL |u| (QREFELT $ 62))
                          (SPADCALL |v| (QREFELT $ 62)) (QREFELT $ 145))
                1 (QREFELT $ 38))))) 

(SDEFUN |FR;prime?;$B;56| ((|u| ($)) ($ (|Boolean|)))
        (SPROG
         ((|l|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| R)
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ (LETT |l| (SPADCALL |u| (QREFELT $ 11)))
              (EXIT
               (COND
                ((SPADCALL |l| 1 (QREFELT $ 46))
                 (COND
                  ((EQL (QVELT (|SPADfirst| |l|) 2) 1)
                   (QEQCAR (QVELT (|SPADfirst| |l|) 0) 3))
                  (#1='T NIL)))
                (#1# NIL)))))) 

(DECLAIM (NOTINLINE |Factored;|)) 

(DEFUN |Factored| (#1=#:G1313)
  (SPROG NIL
         (PROG (#2=#:G1314)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Factored|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Factored;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Factored|)))))))))) 

(DEFUN |Factored;| (|#1|)
  (SPROG ((|pv$| NIL) (#1=#:G1312 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Factored| DV$1))
          (LETT $ (GETREFV 163))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|PartialDifferentialRing|
                                                               (|Symbol|)))
                                              (|HasCategory| |#1|
                                                             '(|DifferentialRing|))
                                              (|HasCategory| |#1|
                                                             (LIST
                                                              '|InnerEvalable|
                                                              '(|Symbol|)
                                                              (|devaluate|
                                                               |#1|)))
                                              (|HasCategory| |#1|
                                                             (LIST '|Evalable|
                                                                   (|devaluate|
                                                                    |#1|)))
                                              (|HasCategory| |#1|
                                                             (LIST '|Eltable|
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   (|devaluate|
                                                                    |#1|)))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| |#1|
                                                             '(|InnerEvalable|
                                                               (|Symbol|) $))
                                              (|HasCategory| |#1|
                                                             '(|Evalable| $))
                                              (|HasCategory| |#1|
                                                             '(|Eltable| $ $))
                                              (|HasCategory| |#1|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#1|
                                                             '(|UniqueFactorizationDomain|))
                                              (LETT #1#
                                                    (|HasCategory| |#1|
                                                                   '(|GcdDomain|)))
                                              (OR #1#
                                                  (|HasCategory| |#1|
                                                                 '(|UniqueFactorizationDomain|)))
                                              (|HasCategory| |#1|
                                                             '(|RealConstant|))
                                              (|HasCategory| |#1|
                                                             '(|IntegerNumberSystem|))))))
          (|haddProp| |$ConstructorCache| '|Factored| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |unt| |#1|)
                              (|:| |fct|
                                   (|List|
                                    (|Record|
                                     (|:| |flag|
                                          (|Union| "nil" "sqfr" "irred"
                                                   "prime"))
                                     (|:| |factor| |#1|)
                                     (|:| |exponent|
                                          (|NonNegativeInteger|)))))))
          (COND
           ((|testBitVector| |pv$| 11)
            (QSETREFV $ 31 (CONS (|dispatchFunction| |FR;convert;$If;1|) $))))
          (QSETREFV $ 32 (|HasCategory| |#1| '(|OrderedSet|)))
          (QSETREFV $ 33 (|HasCategory| |#1| '(|Comparable|)))
          (COND
           ((|testBitVector| |pv$| 16)
            (PROGN
             (QSETREFV $ 69 (CONS (|dispatchFunction| |FR;rational?;$B;22|) $))
             (QSETREFV $ 73
                       (CONS (|dispatchFunction| |FR;rationalIfCan;$U;23|) $))
             (QSETREFV $ 71
                       (CONS (|dispatchFunction| |FR;rational;$F;24|) $)))))
          (COND
           ((|testBitVector| |pv$| 5)
            (QSETREFV $ 81 (CONS (|dispatchFunction| |FR;elt;3$;25|) $))))
          (COND
           ((|testBitVector| |pv$| 4)
            (QSETREFV $ 90 (CONS (|dispatchFunction| |FR;eval;$L$;26|) $))))
          (COND
           ((|testBitVector| |pv$| 3)
            (QSETREFV $ 94 (CONS (|dispatchFunction| |FR;eval;$LL$;27|) $))))
          (COND
           ((|testBitVector| |pv$| 15)
            (PROGN
             (QSETREFV $ 100 (CONS (|dispatchFunction| |FR;convert;$F;28|) $))
             (QSETREFV $ 103
                       (CONS (|dispatchFunction| |FR;convert;$Df;29|) $)))))
          (COND
           ((|testBitVector| |pv$| 16)
            (QSETREFV $ 50 (CONS (|dispatchFunction| |FR;coerce;R$;37|) $)))
           ((|testBitVector| |pv$| 12)
            (QSETREFV $ 50 (CONS (|dispatchFunction| |FR;coerce;R$;38|) $)))
           ('T
            (QSETREFV $ 50 (CONS (|dispatchFunction| |FR;coerce;R$;39|) $))))
          (COND
           ((|testBitVector| |pv$| 13)
            (PROGN
             (QSETREFV $ 134 (CONS (|dispatchFunction| |FR;+;3$;50|) $))
             (QSETREFV $ 144 (CONS (|dispatchFunction| |FR;gcd;3$;54|) $))))
           ('T (QSETREFV $ 134 (CONS (|dispatchFunction| |FR;+;3$;55|) $))))
          (COND
           ((|testBitVector| |pv$| 12)
            (QSETREFV $ 154 (CONS (|dispatchFunction| |FR;prime?;$B;56|) $))))
          $))) 

(MAKEPROP '|Factored| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 8) (|:| |factor| 6) (|:| |exponent| 34))
              (|List| 9) |FR;factorList;$L;7| |FR;unit;$R;8| (|InputForm|)
              (0 . |convert|) (5 . |One|) (|Boolean|) (9 . =) (|Void|)
              (|String|) (|OutputForm|) (15 . |messagePrint|)
              (|InputFormFunctions1| 6) (20 . |coerceToType|) (|Integer|)
              (25 . |convert|) (|Symbol|) (30 . |convert|) (35 . ~=) (|List| $)
              (41 . |binary|) (47 . |convert|) '|orderedR?| '|comparableR?|
              (|NonNegativeInteger|) |FR;flagFactor;RNniU$;43|
              |FR;nilFactor;RNni$;2| |FR;sqfrFactor;RNni$;3|
              |FR;irreducibleFactor;RNni$;4| |FR;primeFactor;RNni$;5|
              (52 . |zero?|) |FR;unit?;$B;6| |FR;numberOfFactors;$Nni;9|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |FR;One;$;12|) $))
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |FR;Zero;$;10|) $))
              (57 . |Zero|) (61 . |size?|) |FR;zero?;$B;11| |FR;one?;$B;13|
              (67 . |coerce|) (72 . |coerce|) |FR;coerce;I$;15|
              (77 . |characteristic|) |FR;characteristic;Nni;16| |FR;*;3$;30|
              |FR;*;I2$;17| |FR;*;R2$;18|
              (|Record| (|:| |factor| 6) (|:| |exponent| 34)) (|List| 57)
              |FR;factors;$L;19| (81 . ^) (87 . *) |FR;expand;$R;20|
              (|Mapping| 16 9 9) (93 . |sort!|) (99 . |setrest!|)
              (105 . |setfirst!|) |FR;unitNormalize;2$;49| |FR;makeFR;RL$;21|
              (111 . |rational?|) (|Fraction| 24) (116 . |rational|)
              (|Union| 70 '"failed") (121 . |rationalIfCan|) (126 . |convert|)
              (131 . |coerce|) (136 . ^) (142 . *) (148 . |One|) (152 . *)
              (158 . |elt|) (164 . |elt|) (|Equation| $$) (170 . |lhs|)
              (175 . |rhs|) (|Equation| 6) (180 . =) (|List| 85) (186 . |eval|)
              (|List| 155) (192 . |eval|) (|List| 26) (|List| 6) (198 . |eval|)
              (205 . |eval|) (|Float|) (212 . |convert|) (217 . ^) (223 . *)
              (229 . |One|) (233 . |convert|) (|DoubleFloat|) (238 . |convert|)
              (243 . |convert|) (248 . |concat!|) |FR;^;$Nni$;31|
              (254 . |coerce|) (259 . |coerce|) (264 . ^) (270 . *)
              (|Mapping| 20 20 20) (|List| 20) (276 . |reduce|)
              |FR;coerce;$Of;32| |FR;retract;$R;33| (|Union| 6 '"failed")
              |FR;retractIfCan;$U;34| (282 . <) (288 . |smaller?|)
              (|Factored| 6) (|IntegerFactorizationPackage| 6) (294 . |factor|)
              (299 . |unit?|) (|Factored| $) (304 . |squareFree|) (309 . ~=)
              |FR;=;2$B;40| (315 . -) |FR;-;2$;41| (|Union| $ '"failed")
              (320 . |recip|) |FR;recip;$U;42| (325 . *) |FR;exquo;2$U;47|
              (331 . +) (|Mapping| 6 6) |FR;differentiate;$M$;44|
              |FR;map;M2$;45| (337 . |merge|) |FR;mergeFactors;3$;46|
              (344 . |exquo|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (350 . |unitNormal|) |FR;unitNormal;$R;48| (355 . |gcd|)
              (361 . +) (|Vector| 6) (367 . |setelt!|)
              (|Record| (|:| |basis| 146) (|:| |transform| 152)) (|GcdBasis| 6)
              (374 . |gcdDecomposition|) (379 . |elt|) (|Matrix| 24)
              (385 . |elt|) (392 . |prime?|) (|Equation| $)
              (|SparseUnivariatePolynomial| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|List| 34) (|Union| 24 '"failed") (|PositiveInteger|)
              (|HashState|) (|SingleInteger|))
           '#(~= 397 |zero?| 403 |unitNormalize| 408 |unitNormal| 413
              |unitCanonical| 418 |unit?| 423 |unit| 428 |subtractIfCan| 433
              |squareFreePart| 439 |squareFree| 444 |sqfrFactor| 449 |sample|
              455 |rightRecip| 459 |rightPower| 464 |retractIfCan| 476
              |retract| 491 |recip| 506 |rationalIfCan| 511 |rational?| 516
              |rational| 521 |primeFactor| 526 |prime?| 532 |opposite?| 537
              |one?| 543 |numberOfFactors| 548 |nilFactor| 553 |mergeFactors|
              559 |map| 565 |makeFR| 571 |leftRecip| 577 |leftPower| 582
              |lcmCoef| 594 |lcm| 600 |latex| 611 |irreducibleFactor| 616
              |hashUpdate!| 622 |hash| 628 |gcdPolynomial| 633 |gcd| 639
              |flagFactor| 650 |factors| 657 |factorList| 662 |factor| 667
              |exquo| 672 |expand| 678 |eval| 683 |elt| 763 |differentiate| 775
              |convert| 825 |commutator| 840 |coerce| 846 |characteristic| 871
              |associator| 875 |associates?| 882 |antiCommutator| 888
              |annihilate?| 894 ^ 900 |Zero| 912 |One| 916 D 920 = 970 - 976 +
              987 * 993)
           'NIL
           (CONS
            (|makeByteWordVec2| 15
                                '(12 14 0 0 0 13 0 0 0 1 2 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4 6 7 9
                                  15 0 0 0 0 0 0 3 4 5 6 7 8 9 10 11 15 15))
            (CONS
             '#(|UniqueFactorizationDomain&| |GcdDomain&| NIL NIL
                |DifferentialExtension&| NIL |Algebra&| |EntireRing&|
                |Algebra&| |PartialDifferentialRing&| |DifferentialRing&| NIL
                |Rng&| NIL |Module&| |Module&| NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL |NonAssociativeRng&| NIL
                |AbelianGroup&| NIL NIL NIL NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| |FullyRetractableTo&|
                |FullyEvalableOver&| |Magma&| |AbelianSemiGroup&|
                |RetractableTo&| NIL |SetCategory&| |Evalable&|
                |RetractableTo&| |RetractableTo&| |Evalable&| NIL NIL NIL NIL
                NIL |BasicType&| NIL |InnerEvalable&| |InnerEvalable&| NIL NIL
                NIL |InnerEvalable&| |InnerEvalable&| NIL NIL NIL NIL)
             (CONS
              '#((|UniqueFactorizationDomain|) (|GcdDomain|) (|IntegralDomain|)
                 (|CommutativeRing|) (|DifferentialExtension| 6)
                 (|LeftOreRing|) (|Algebra| 6) (|EntireRing|) (|Algebra| $$)
                 (|PartialDifferentialRing| 26) (|DifferentialRing|) (|Ring|)
                 (|Rng|) (|SemiRing|) (|Module| 6) (|Module| $$) (|SemiRng|)
                 (|BiModule| 6 6) (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|RightModule| 6) (|LeftModule| 6) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|RightModule| $$) (|AbelianGroup|)
                 (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|FullyRetractableTo| 6) (|FullyEvalableOver| 6) (|Magma|)
                 (|AbelianSemiGroup|) (|RetractableTo| 6) (|CommutativeStar|)
                 (|SetCategory|) (|Evalable| 6) (|RetractableTo| 70)
                 (|RetractableTo| 24) (|Evalable| $$) (|RealConstant|)
                 (|CoercibleFrom| 6) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 20)
                 (|InnerEvalable| 26 6) (|InnerEvalable| 6 6) (|Eltable| 6 $$)
                 (|CoercibleFrom| 70) (|CoercibleFrom| 24)
                 (|InnerEvalable| 26 $$) (|InnerEvalable| $$ $$)
                 (|Eltable| $$ $$) (|ConvertibleTo| 13) (|ConvertibleTo| 101)
                 (|ConvertibleTo| 95))
              (|makeByteWordVec2| 162
                                  '(1 6 13 0 14 0 6 0 15 2 6 16 0 0 17 1 20 18
                                    19 21 1 22 13 13 23 1 13 0 24 25 1 13 0 26
                                    27 2 6 16 0 0 28 2 13 0 0 29 30 1 0 13 0 31
                                    1 6 16 0 40 0 6 0 45 2 10 16 0 34 46 1 6 0
                                    24 49 1 0 0 6 50 0 6 34 52 2 6 0 0 34 60 2
                                    6 0 0 0 61 2 10 0 63 0 64 2 10 0 0 0 65 2
                                    10 9 0 9 66 1 0 16 0 69 1 0 70 0 71 1 0 72
                                    0 73 1 6 24 0 74 1 70 0 24 75 2 70 0 0 24
                                    76 2 70 0 0 70 77 0 70 0 78 2 70 0 24 0 79
                                    2 0 0 0 6 80 2 0 0 0 0 81 1 82 2 0 83 1 82
                                    2 0 84 2 85 0 6 6 86 2 0 0 0 87 88 2 0 0 0
                                    89 90 3 0 0 0 91 92 93 3 0 0 0 91 29 94 1 6
                                    95 0 96 2 95 0 0 24 97 2 95 0 0 0 98 0 95 0
                                    99 1 0 95 0 100 1 6 101 0 102 1 0 101 0 103
                                    2 10 0 0 0 104 1 6 20 0 106 1 34 20 0 107 2
                                    20 0 0 0 108 2 20 0 0 0 109 2 111 20 110 0
                                    112 2 6 16 0 0 117 2 6 16 0 0 118 1 120 119
                                    6 121 1 6 16 0 122 1 6 123 0 124 2 34 16 0
                                    0 125 1 6 0 0 127 1 6 129 0 130 2 6 0 24 0
                                    132 2 0 0 0 0 134 3 10 0 63 0 0 138 2 6 129
                                    0 0 140 1 6 141 0 142 2 0 0 0 0 144 2 6 0 0
                                    0 145 3 146 6 0 24 6 147 1 149 148 146 150
                                    2 146 6 0 24 151 3 152 24 0 24 24 153 1 0
                                    16 0 154 2 0 16 0 0 1 1 0 16 0 47 1 0 0 0
                                    67 1 0 141 0 143 1 0 0 0 1 1 0 16 0 41 1 0
                                    6 0 12 2 0 129 0 0 1 1 12 0 0 1 1 12 123 0
                                    1 2 0 0 6 34 37 0 0 0 1 1 0 129 0 1 2 0 0 0
                                    34 1 2 0 0 0 160 1 1 6 72 0 1 1 7 159 0 1 1
                                    0 115 0 116 1 6 70 0 1 1 7 24 0 1 1 0 6 0
                                    114 1 0 129 0 131 1 16 72 0 73 1 16 16 0 69
                                    1 16 70 0 71 2 0 0 6 34 39 1 12 16 0 154 2
                                    0 16 0 0 1 1 0 16 0 48 1 0 34 0 42 2 0 0 6
                                    34 36 2 0 0 0 0 139 2 0 0 135 0 137 2 0 0 6
                                    10 68 1 0 129 0 1 2 0 0 0 34 1 2 0 0 0 160
                                    1 2 13 157 0 0 1 1 13 0 29 1 2 13 0 0 0 1 1
                                    0 19 0 1 2 0 0 6 34 38 2 0 161 161 0 1 1 0
                                    162 0 1 2 13 156 156 156 1 1 13 0 29 1 2 13
                                    0 0 0 144 3 0 0 6 34 8 35 1 0 58 0 59 1 0
                                    10 0 11 1 12 123 0 1 2 0 129 0 0 133 1 0 6
                                    0 62 2 9 0 0 155 1 2 9 0 0 89 90 3 9 0 0 0
                                    0 1 3 9 0 0 29 29 1 2 4 0 0 85 1 2 4 0 0 87
                                    88 3 4 0 0 6 6 1 3 4 0 0 92 92 1 3 8 0 0 91
                                    29 94 3 8 0 0 26 0 1 3 3 0 0 91 92 93 3 3 0
                                    0 26 6 1 2 10 0 0 0 81 2 5 0 0 6 80 2 2 0 0
                                    34 1 1 2 0 0 1 3 1 0 0 91 158 1 2 1 0 0 91
                                    1 3 1 0 0 26 34 1 2 1 0 0 26 1 2 0 0 0 135
                                    136 3 0 0 0 135 34 1 1 11 13 0 31 1 15 101
                                    0 103 1 15 95 0 100 2 0 0 0 0 1 1 6 0 70 1
                                    1 0 0 6 50 1 0 0 0 1 1 0 0 24 51 1 0 20 0
                                    113 0 0 34 53 3 0 0 0 0 0 1 2 0 16 0 0 1 2
                                    0 0 0 0 1 2 0 16 0 0 1 2 0 0 0 34 105 2 0 0
                                    0 160 1 0 0 0 44 0 0 0 43 2 2 0 0 34 1 1 2
                                    0 0 1 3 1 0 0 26 34 1 3 1 0 0 91 158 1 2 1
                                    0 0 26 1 2 1 0 0 91 1 3 0 0 0 135 34 1 2 0
                                    0 0 135 1 2 0 16 0 0 126 2 0 0 0 0 1 1 0 0
                                    0 128 2 0 0 0 0 134 2 0 0 6 0 56 2 0 0 0 6
                                    1 2 0 0 34 0 1 2 0 0 24 0 55 2 0 0 0 0 54 2
                                    0 0 160 0 1)))))
           '|lookupComplete|)) 


(SDEFUN |IR;-;2$;1| ((|u| ($)) ($ ($))) (SPADCALL -1 |u| (QREFELT $ 14))) 

(SDEFUN |IR;Zero;$;2| (($ ($)))
        (SPADCALL (|spadConstant| $ 17) NIL NIL (QREFELT $ 22))) 

(SDEFUN |IR;coerce;F$;3| ((|x| (F)) ($ ($)))
        (SPADCALL |x| NIL NIL (QREFELT $ 22))) 

(PUT '|IR;ratpart;$F;4| '|SPADreplace| '(XLAM (|u|) (QVELT |u| 0))) 

(SDEFUN |IR;ratpart;$F;4| ((|u| ($)) ($ (F))) (QVELT |u| 0)) 

(PUT '|IR;logpart;$L;5| '|SPADreplace| '(XLAM (|u|) (QVELT |u| 1))) 

(SDEFUN |IR;logpart;$L;5|
        ((|u| ($))
         ($
          (|List|
           (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                     (|:| |coeff| (|SparseUnivariatePolynomial| F))
                     (|:| |logand| (|SparseUnivariatePolynomial| F))))))
        (QVELT |u| 1)) 

(PUT '|IR;notelem;$L;6| '|SPADreplace| '(XLAM (|u|) (QVELT |u| 2))) 

(SDEFUN |IR;notelem;$L;6|
        ((|u| ($))
         ($ (|List| (|Record| (|:| |integrand| F) (|:| |intvar| F)))))
        (QVELT |u| 2)) 

(SDEFUN |IR;elem?;$B;7| ((|u| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |u| (QREFELT $ 26)))) 

(SDEFUN |IR;mkAnswer;FLL$;8|
        ((|x| (F))
         (|l|
          (|List|
           (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                     (|:| |coeff| (|SparseUnivariatePolynomial| F))
                     (|:| |logand| (|SparseUnivariatePolynomial| F)))))
         (|n| (|List| (|Record| (|:| |integrand| F) (|:| |intvar| F))))
         ($ ($)))
        (VECTOR |x| |l| (|IR;nesimp| |n| $))) 

(SDEFUN |IR;timelog|
        ((|r| (|Fraction| (|Integer|)))
         (|lg|
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| F))
                    (|:| |logand| (|SparseUnivariatePolynomial| F))))
         ($
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| F))
                    (|:| |logand| (|SparseUnivariatePolynomial| F)))))
        (VECTOR (SPADCALL |r| (QVELT |lg| 0) (QREFELT $ 30)) (QVELT |lg| 1)
                (QVELT |lg| 2))) 

(SDEFUN |IR;integral;2F$;10| ((|f| (F)) (|x| (F)) ($ ($)))
        (COND ((SPADCALL |f| (QREFELT $ 31)) (|spadConstant| $ 16))
              ('T
               (SPADCALL (|spadConstant| $ 17) NIL (LIST (CONS |f| |x|))
                         (QREFELT $ 22))))) 

(SDEFUN |IR;timene|
        ((|r| (|Fraction| (|Integer|)))
         (|ne| (|Record| (|:| |integrand| F) (|:| |intvar| F)))
         ($ (|Record| (|:| |integrand| F) (|:| |intvar| F))))
        (CONS (SPADCALL (|IR;Q2F| |r| $) (QCAR |ne|) (QREFELT $ 33))
              (QCDR |ne|))) 

(SDEFUN |IR;*;I2$;12| ((|n| (|Integer|)) (|u| ($)) ($ ($)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 34)) |u| (QREFELT $ 35))) 

(SDEFUN |IR;Q2F| ((|r| (|Fraction| (|Integer|))) ($ (F)))
        (SPADCALL (SPADCALL (SPADCALL |r| (QREFELT $ 36)) (QREFELT $ 37))
                  (SPADCALL (SPADCALL |r| (QREFELT $ 38)) (QREFELT $ 37))
                  (QREFELT $ 39))) 

(SDEFUN |IR;neselect|
        ((|l| (|List| (|Record| (|:| |integrand| F) (|:| |intvar| F))))
         (|x| (F)) ($ (F)))
        (SPROG
         ((#1=#:G755 NIL) (#2=#:G754 (F)) (#3=#:G756 (F)) (#4=#:G758 NIL)
          (|ne| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |ne| NIL) (LETT #4# |l|) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |ne| (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (COND
                   ((SPADCALL (QCDR |ne|) |x| (QREFELT $ 40))
                    (PROGN
                     (LETT #3# (QCAR |ne|))
                     (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 41))))
                           ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 17))))))) 

(SDEFUN |IR;integral;FS$;15| ((|f| (F)) (|x| (|Symbol|)) ($ ($)))
        (SPADCALL |f| (SPADCALL |x| (QREFELT $ 42)) (QREFELT $ 32))) 

(SDEFUN |IR;LOG2O|
        ((|rec|
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| F))
                    (|:| |logand| (|SparseUnivariatePolynomial| F))))
         ($ (|OutputForm|)))
        (SPROG
         ((|logandp| (|OutputForm|)) (|cc| (F)) (|coeffp| (|OutputForm|))
          (|lg| (F)) (|lastc| (F)))
         (SEQ
          (COND
           ((EQL (SPADCALL (QVELT |rec| 1) (QREFELT $ 46)) 1)
            (SEQ
             (LETT |lastc|
                   (SPADCALL
                    (SPADCALL (SPADCALL (QVELT |rec| 1) 0 (QREFELT $ 48))
                              (SPADCALL (QVELT |rec| 1) 1 (QREFELT $ 48))
                              (QREFELT $ 39))
                    (QREFELT $ 49)))
             (LETT |lg| (SPADCALL (QVELT |rec| 2) |lastc| (QREFELT $ 50)))
             (LETT |logandp|
                   (SPADCALL (SPADCALL '|log| (QREFELT $ 11))
                             (LIST (SPADCALL |lg| (QREFELT $ 51)))
                             (QREFELT $ 53)))
             (LETT |cc|
                   (SPADCALL (|IR;Q2F| (QVELT |rec| 0) $) |lastc|
                             (QREFELT $ 33)))
             (EXIT
              (COND
               ((SPADCALL |cc| (|spadConstant| $ 47) (QREFELT $ 40)) |logandp|)
               ((SPADCALL |cc| (SPADCALL (|spadConstant| $ 47) (QREFELT $ 49))
                          (QREFELT $ 40))
                (SPADCALL |logandp| (QREFELT $ 55)))
               (#1='T
                (SPADCALL (SPADCALL |cc| (QREFELT $ 51)) |logandp|
                          (QREFELT $ 56)))))))
           (#1#
            (SEQ
             (LETT |coeffp|
                   (SPADCALL
                    (SPADCALL (QVELT |rec| 1) (QREFELT $ 12) (QREFELT $ 57))
                    (SPADCALL 0 (QREFELT $ 58)) (QREFELT $ 59)))
             (LETT |logandp|
                   (SPADCALL (QREFELT $ 12)
                             (SPADCALL (SPADCALL '|log| (QREFELT $ 11))
                                       (LIST
                                        (SPADCALL (QVELT |rec| 2)
                                                  (QREFELT $ 12)
                                                  (QREFELT $ 57)))
                                       (QREFELT $ 53))
                             (QREFELT $ 56)))
             (COND
              ((SPADCALL (LETT |cc| (|IR;Q2F| (QVELT |rec| 0) $))
                         (|spadConstant| $ 47) (QREFELT $ 60))
               (LETT |logandp|
                     (SPADCALL (SPADCALL |cc| (QREFELT $ 51)) |logandp|
                               (QREFELT $ 56)))))
             (EXIT (SPADCALL |logandp| |coeffp| (QREFELT $ 61))))))))) 

(SDEFUN |IR;nesimp|
        ((|l| (|List| (|Record| (|:| |integrand| F) (|:| |intvar| F))))
         ($ (|List| (|Record| (|:| |integrand| F) (|:| |intvar| F)))))
        (SPROG
         ((|u| (F)) (#1=#:G778 NIL) (#2=#:G780 NIL) (|ne| NIL) (#3=#:G779 NIL)
          (|x| NIL) (#4=#:G777 NIL))
         (SEQ
          (PROGN
           (LETT #4# NIL)
           (SEQ (LETT |x| NIL)
                (LETT #1#
                      (SPADCALL
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |ne| NIL) (LETT #2# |l|) G190
                             (COND
                              ((OR (ATOM #2#)
                                   (PROGN (LETT |ne| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ (EXIT (LETT #3# (CONS (QCDR |ne|) #3#))))
                             (LETT #2# (CDR #2#)) (GO G190) G191
                             (EXIT (NREVERSE #3#))))
                       (QREFELT $ 63)))
                G190
                (COND
                 ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (COND
                   ((SPADCALL (LETT |u| (|IR;neselect| |l| |x| $))
                              (|spadConstant| $ 17) (QREFELT $ 60))
                    (LETT #4# (CONS (CONS |u| |x|) #4#))))))
                (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #4#))))))) 

(SDEFUN |IR;retractIfCan;$U;18| ((|u| ($)) ($ (|Union| F "failed")))
        (SPROG
         ((#1=#:G787 NIL) (#2=#:G786 (F)) (#3=#:G788 (F)) (#4=#:G794 NIL)
          (|ne| NIL))
         (SEQ
          (COND
           ((NULL (SPADCALL |u| (QREFELT $ 25)))
            (CONS 0
                  (SPADCALL (SPADCALL |u| (QREFELT $ 24))
                            (PROGN
                             (LETT #1# NIL)
                             (SEQ (LETT |ne| NIL)
                                  (LETT #4# (SPADCALL |u| (QREFELT $ 26))) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |ne| (CAR #4#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #3#
                                           (SPADCALL (QCAR |ne|)
                                                     (SPADCALL (QCDR |ne|)
                                                               (QREFELT $ 64))
                                                     (QREFELT $ 65)))
                                     (COND
                                      (#1#
                                       (LETT #2#
                                             (SPADCALL #2# #3#
                                                       (QREFELT $ 41))))
                                      ('T
                                       (PROGN
                                        (LETT #2# #3#)
                                        (LETT #1# 'T)))))))
                                  (LETT #4# (CDR #4#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#1# #2#) (#5='T (|spadConstant| $ 17))))
                            (QREFELT $ 41))))
           (#5# (CONS 1 "failed")))))) 

(SDEFUN |IR;retractIfCan;$U;19| ((|u| ($)) ($ (|Union| F "failed")))
        (SEQ
         (COND
          ((SPADCALL |u| (QREFELT $ 28))
           (COND
            ((NULL (SPADCALL |u| (QREFELT $ 25)))
             (EXIT (CONS 0 (SPADCALL |u| (QREFELT $ 24))))))))
         (EXIT (CONS 1 "failed")))) 

(SDEFUN |IR;retractIfCan;$U;20| ((|u| ($)) ($ (|Union| F "failed")))
        (SEQ
         (COND
          ((SPADCALL |u| (QREFELT $ 28))
           (COND
            ((NULL (SPADCALL |u| (QREFELT $ 25)))
             (EXIT (CONS 0 (SPADCALL |u| (QREFELT $ 24))))))))
         (EXIT (CONS 1 "failed")))) 

(SDEFUN |IR;*;F2$;21| ((|r| (|Fraction| (|Integer|))) (|u| ($)) ($ ($)))
        (SPROG NIL
               (COND
                ((SPADCALL |r| (|spadConstant| $ 68) (QREFELT $ 69))
                 (|spadConstant| $ 16))
                ('T
                 (SPADCALL
                  (SPADCALL (|IR;Q2F| |r| $) (SPADCALL |u| (QREFELT $ 24))
                            (QREFELT $ 33))
                  (SPADCALL (CONS #'|IR;*;F2$;21!0| (VECTOR $ |r|))
                            (SPADCALL |u| (QREFELT $ 25)) (QREFELT $ 71))
                  (SPADCALL (CONS #'|IR;*;F2$;21!1| (VECTOR $ |r|))
                            (SPADCALL |u| (QREFELT $ 26)) (QREFELT $ 73))
                  (QREFELT $ 22)))))) 

(SDEFUN |IR;*;F2$;21!1| ((|x1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|IR;timene| |r| |x1| $))))) 

(SDEFUN |IR;*;F2$;21!0| ((|x1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|IR;timelog| |r| |x1| $))))) 

(SDEFUN |IR;+;3$;22| ((|u| ($)) (|v| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |u| (QREFELT $ 24)) (SPADCALL |v| (QREFELT $ 24))
                   (QREFELT $ 41))
         (SPADCALL (SPADCALL |u| (QREFELT $ 25)) (SPADCALL |v| (QREFELT $ 25))
                   (QREFELT $ 74))
         (|IR;nesimp|
          (SPADCALL (SPADCALL |u| (QREFELT $ 26)) (SPADCALL |v| (QREFELT $ 26))
                    (QREFELT $ 75))
          $)
         (QREFELT $ 22))) 

(SDEFUN |IR;differentiate;$SF;23| ((|u| ($)) (|x| (|Symbol|)) ($ (F)))
        (SPROG NIL
               (SPADCALL |u|
                         (CONS #'|IR;differentiate;$SF;23!0| (VECTOR $ |x|))
                         (QREFELT $ 79)))) 

(SDEFUN |IR;differentiate;$SF;23!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 77)))))) 

(SDEFUN |IR;differentiate;$MF;24|
        ((|u| ($)) (|derivation| (|Mapping| F F)) ($ (F)))
        (SPROG
         ((#1=#:G836 NIL) (#2=#:G835 (F)) (#3=#:G837 (F)) (#4=#:G841 NIL)
          (|ne| NIL) (#5=#:G831 NIL) (#6=#:G830 (F)) (#7=#:G832 (F))
          (#8=#:G840 NIL) (|log| NIL))
         (SEQ
          (SPADCALL
           (SPADCALL (SPADCALL (SPADCALL |u| (QREFELT $ 24)) |derivation|)
                     (PROGN
                      (LETT #5# NIL)
                      (SEQ (LETT |log| NIL)
                           (LETT #8# (SPADCALL |u| (QREFELT $ 25))) G190
                           (COND
                            ((OR (ATOM #8#) (PROGN (LETT |log| (CAR #8#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (PROGN
                              (LETT #7# (|IR;pLogDeriv| |log| |derivation| $))
                              (COND
                               (#5#
                                (LETT #6# (SPADCALL #6# #7# (QREFELT $ 41))))
                               ('T (PROGN (LETT #6# #7#) (LETT #5# 'T)))))))
                           (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                      (COND (#5# #6#) (#9='T (|spadConstant| $ 17))))
                     (QREFELT $ 41))
           (PROGN
            (LETT #1# NIL)
            (SEQ (LETT |ne| NIL) (LETT #4# (SPADCALL |u| (QREFELT $ 26))) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |ne| (CAR #4#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (PROGN
                    (LETT #3# (|IR;pNeDeriv| |ne| |derivation| $))
                    (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 41))))
                          ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (COND (#1# #2#) (#9# (|spadConstant| $ 17))))
           (QREFELT $ 41))))) 

(SDEFUN |IR;pNeDeriv|
        ((|ne| (|Record| (|:| |integrand| F) (|:| |intvar| F)))
         (|derivation| (|Mapping| F F)) ($ (F)))
        (COND
         ((SPADCALL (SPADCALL (QCDR |ne|) |derivation|) (|spadConstant| $ 47)
                    (QREFELT $ 40))
          (QCAR |ne|))
         ((SPADCALL (SPADCALL (QCAR |ne|) |derivation|) (QREFELT $ 31))
          (|spadConstant| $ 17))
         ('T
          (|error|
           "pNeDeriv: cannot differentiate not elementary part into F")))) 

(SDEFUN |IR;pLogDeriv|
        ((|log|
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| F))
                    (|:| |logand| (|SparseUnivariatePolynomial| F))))
         (|derivation| (|Mapping| F F)) ($ (F)))
        (SPROG
         ((|ans| (F)) (|algans| #1=(|SparseUnivariatePolynomial| F))
          (#2=#:G864 NIL) (|i| NIL)
          (|diflog|
           (|Record| (|:| |coef1| #1#)
                     (|:| |coef2| (|SparseUnivariatePolynomial| F))))
          (#3=#:G855 NIL) (|numlog| (|SparseUnivariatePolynomial| F)) (|c| (F))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |derivation| (QVELT |log| 1) (QREFELT $ 81))
                      (|spadConstant| $ 82) (QREFELT $ 83))
            (|error|
             "pLogDeriv: can only handle logs with constant coefficients"))
           (#4='T
            (SEQ (LETT |n| (SPADCALL (QVELT |log| 1) (QREFELT $ 46)))
                 (EXIT
                  (COND
                   ((EQL |n| 1)
                    (SEQ
                     (LETT |c|
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (QVELT |log| 1) (QREFELT $ 84))
                              (QREFELT $ 85))
                             (SPADCALL (QVELT |log| 1) (QREFELT $ 85))
                             (QREFELT $ 39))
                            (QREFELT $ 49)))
                     (LETT |ans| (SPADCALL (QVELT |log| 2) |c| (QREFELT $ 50)))
                     (EXIT
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (|IR;Q2F| (QVELT |log| 0) $) |c|
                                  (QREFELT $ 33))
                        (SPADCALL |ans| |derivation|) (QREFELT $ 33))
                       |ans| (QREFELT $ 39)))))
                   (#4#
                    (SEQ
                     (LETT |numlog|
                           (SPADCALL |derivation| (QVELT |log| 2)
                                     (QREFELT $ 81)))
                     (LETT |diflog|
                           (PROG2
                               (LETT #3#
                                     (SPADCALL (QVELT |log| 2) (QVELT |log| 1)
                                               |numlog| (QREFELT $ 88)))
                               (QCDR #3#)
                             (|check_union2| (QEQCAR #3# 0)
                                             (|Record|
                                              (|:| |coef1|
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 6)))
                                              (|:| |coef2|
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 6))))
                                             (|Union|
                                              (|Record|
                                               (|:| |coef1|
                                                    (|SparseUnivariatePolynomial|
                                                     (QREFELT $ 6)))
                                               (|:| |coef2|
                                                    (|SparseUnivariatePolynomial|
                                                     (QREFELT $ 6))))
                                              "failed")
                                             #3#)))
                     (LETT |algans| (QCAR |diflog|))
                     (LETT |ans| (|spadConstant| $ 17))
                     (SEQ (LETT |i| 0)
                          (LETT #2# (SPADCALL |n| 1 (QREFELT $ 89))) G190
                          (COND ((|greater_SI| |i| #2#) (GO G191)))
                          (SEQ
                           (LETT |algans|
                                 (SPADCALL
                                  (SPADCALL |algans|
                                            (SPADCALL (|spadConstant| $ 47) 1
                                                      (QREFELT $ 90))
                                            (QREFELT $ 91))
                                  (QVELT |log| 1) (QREFELT $ 92)))
                           (EXIT
                            (LETT |ans|
                                  (SPADCALL |ans|
                                            (SPADCALL |algans| |i|
                                                      (QREFELT $ 48))
                                            (QREFELT $ 41)))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                     (EXIT
                      (SPADCALL (|IR;Q2F| (QVELT |log| 0) $) |ans|
                                (QREFELT $ 33))))))))))))) 

(SDEFUN |IR;coerce;$Of;27| ((|u| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|OutputForm|))) (#1=#:G890 NIL) (|f| NIL)
          (#2=#:G889 NIL) (#3=#:G888 NIL) (#4=#:G887 NIL)
          (|r| (|Union| F "failed")))
         (SEQ (LETT |r| (SPADCALL |u| (QREFELT $ 67)))
              (EXIT
               (COND ((QEQCAR |r| 0) (SPADCALL (QCDR |r|) (QREFELT $ 51)))
                     (#5='T
                      (SEQ
                       (LETT |l|
                             (NREVERSE
                              (PROGN
                               (LETT #4# NIL)
                               (SEQ (LETT |f| NIL)
                                    (LETT #3# (SPADCALL |u| (QREFELT $ 25)))
                                    G190
                                    (COND
                                     ((OR (ATOM #3#)
                                          (PROGN (LETT |f| (CAR #3#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #4#
                                            (CONS (|IR;LOG2O| |f| $) #4#))))
                                    (LETT #3# (CDR #3#)) (GO G190) G191
                                    (EXIT (NREVERSE #4#))))))
                       (COND
                        ((SPADCALL (SPADCALL |u| (QREFELT $ 24))
                                   (|spadConstant| $ 17) (QREFELT $ 60))
                         (LETT |l|
                               (CONS
                                (SPADCALL (SPADCALL |u| (QREFELT $ 24))
                                          (QREFELT $ 51))
                                |l|))))
                       (COND
                        ((NULL (SPADCALL |u| (QREFELT $ 28)))
                         (LETT |l|
                               (SPADCALL
                                (PROGN
                                 (LETT #2# NIL)
                                 (SEQ (LETT |f| NIL)
                                      (LETT #1# (SPADCALL |u| (QREFELT $ 26)))
                                      G190
                                      (COND
                                       ((OR (ATOM #1#)
                                            (PROGN (LETT |f| (CAR #1#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #2#
                                              (CONS (|IR;NE2O| |f| $) #2#))))
                                      (LETT #1# (CDR #1#)) (GO G190) G191
                                      (EXIT (NREVERSE #2#))))
                                |l| (QREFELT $ 94)))))
                       (EXIT
                        (COND
                         ((NULL |l|)
                          (SPADCALL (|spadConstant| $ 16) (QREFELT $ 95)))
                         (#5# (SPADCALL (ELT $ 96) |l| (QREFELT $ 98)))))))))))) 

(SDEFUN |IR;NE2O|
        ((|ne| (|Record| (|:| |integrand| F) (|:| |intvar| F)))
         ($ (|OutputForm|)))
        (SPADCALL
         (SPADCALL (SPADCALL (QCAR |ne|) (QREFELT $ 51))
                   (SPADCALL
                    (LIST (SPADCALL '|d| (QREFELT $ 11))
                          (SPADCALL (QCDR |ne|) (QREFELT $ 51)))
                    (QREFELT $ 99))
                   (QREFELT $ 56))
         (QREFELT $ 100))) 

(DECLAIM (NOTINLINE |IntegrationResult;|)) 

(DEFUN |IntegrationResult| (#1=#:G897)
  (SPROG NIL
         (PROG (#2=#:G898)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IntegrationResult|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|IntegrationResult;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|IntegrationResult|)))))))))) 

(DEFUN |IntegrationResult;| (|#1|)
  (SPROG ((|pv$| NIL) (#1=#:G896 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IntegrationResult| DV$1))
          (LETT $ (GETREFV 106))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory|
                                               (|Fraction| (|Integer|))
                                               '(|AbelianGroup|))
                                              (LETT #1#
                                                    (|HasCategory|
                                                     (|Fraction| (|Integer|))
                                                     '(|AbelianMonoid|)))
                                              (OR
                                               (|HasCategory|
                                                (|Fraction| (|Integer|))
                                                '(|AbelianGroup|))
                                               #1#)
                                              (|HasCategory| |#1|
                                                             '(|PartialDifferentialRing|
                                                               (|Symbol|)))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Symbol|)))))))
          (|haddProp| |$ConstructorCache| '|IntegrationResult| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |ratp| |#1|)
                              (|:| |logp|
                                   (|List|
                                    (|Record|
                                     (|:| |scalar| (|Fraction| (|Integer|)))
                                     (|:| |coeff|
                                          (|SparseUnivariatePolynomial| |#1|))
                                     (|:| |logand|
                                          (|SparseUnivariatePolynomial|
                                           |#1|)))))
                              (|:| |nelem|
                                   (|List|
                                    (|Record| (|:| |integrand| |#1|)
                                              (|:| |intvar| |#1|))))))
          (QSETREFV $ 12 (SPADCALL (SPADCALL (QREFELT $ 9)) (QREFELT $ 11)))
          (COND
           ((|testBitVector| |pv$| 5)
            (QSETREFV $ 43
                      (CONS (|dispatchFunction| |IR;integral;FS$;15|) $))))
          (COND
           ((|HasCategory| |#1| '(|LiouvillianFunctionCategory|))
            (COND
             ((|testBitVector| |pv$| 5)
              (QSETREFV $ 67
                        (CONS (|dispatchFunction| |IR;retractIfCan;$U;18|) $)))
             ('T
              (QSETREFV $ 67
                        (CONS (|dispatchFunction| |IR;retractIfCan;$U;19|)
                              $)))))
           ('T
            (QSETREFV $ 67
                      (CONS (|dispatchFunction| |IR;retractIfCan;$U;20|) $))))
          (COND
           ((|testBitVector| |pv$| 4)
            (QSETREFV $ 80
                      (CONS (|dispatchFunction| |IR;differentiate;$SF;23|)
                            $))))
          $))) 

(MAKEPROP '|IntegrationResult| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Symbol|)
              (0 . |new|) (|OutputForm|) (4 . |coerce|) '|alpha| (|Integer|)
              |IR;*;I2$;12| |IR;-;2$;1|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |IR;Zero;$;2|) $))
              (9 . |Zero|)
              (|Record| (|:| |scalar| 29) (|:| |coeff| 45) (|:| |logand| 45))
              (|List| 18) (|Record| (|:| |integrand| 6) (|:| |intvar| 6))
              (|List| 20) |IR;mkAnswer;FLL$;8| |IR;coerce;F$;3|
              |IR;ratpart;$F;4| |IR;logpart;$L;5| |IR;notelem;$L;6| (|Boolean|)
              |IR;elem?;$B;7| (|Fraction| 13) (13 . *) (19 . |zero?|)
              |IR;integral;2F$;10| (24 . *) (30 . |coerce|) |IR;*;F2$;21|
              (35 . |numer|) (40 . |coerce|) (45 . |denom|) (50 . /) (56 . =)
              (62 . +) (68 . |coerce|) (73 . |integral|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 6) (79 . |degree|) (84 . |One|)
              (88 . |coefficient|) (94 . -) (99 . |elt|) (105 . |coerce|)
              (|List| $) (110 . |prefix|) (116 . |One|) (120 . -) (125 . *)
              (131 . |outputForm|) (137 . |coerce|) (142 . =) (148 . ~=)
              (154 . |sum|) (|List| 6) (160 . |removeDuplicates!|)
              (165 . |retract|) (170 . |integral|) (|Union| 6 '"failed")
              (176 . |retractIfCan|) (181 . |Zero|) (185 . =) (|Mapping| 18 18)
              (191 . |map|) (|Mapping| 20 20) (197 . |map|) (203 . |concat|)
              (209 . |concat|) |IR;+;3$;22| (215 . |differentiate|)
              (|Mapping| 6 6) |IR;differentiate;$MF;24| (221 . |differentiate|)
              (227 . |map|) (233 . |Zero|) (237 . ~=) (243 . |reductum|)
              (248 . |leadingCoefficient|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 86 '"failed")
              (253 . |extendedEuclidean|) (260 . -) (266 . |monomial|)
              (272 . *) (278 . |rem|) (|List| 10) (284 . |concat|)
              |IR;coerce;$Of;27| (290 . +) (|Mapping| 10 10 10)
              (296 . |reduce|) (302 . |hconcat|) (307 . |int|)
              (|Union| $ '"failed") (|PositiveInteger|) (|HashState|)
              (|String|) (|SingleInteger|))
           '#(~= 312 |zero?| 318 |subtractIfCan| 323 |sample| 329
              |retractIfCan| 333 |retract| 338 |ratpart| 343 |opposite?| 348
              |notelem| 354 |mkAnswer| 359 |logpart| 366 |latex| 371 |integral|
              376 |hashUpdate!| 388 |hash| 394 |elem?| 399 |differentiate| 404
              |coerce| 416 |Zero| 426 = 430 - 436 + 447 * 453)
           'NIL
           (CONS (|makeByteWordVec2| 3 '(0 0 0 0 1 1 3 0 0 0 0 0 0))
                 (CONS
                  '#(|Module&| NIL NIL NIL |AbelianGroup&| NIL |AbelianMonoid&|
                     |AbelianSemiGroup&| |RetractableTo&| |SetCategory&| NIL
                     |BasicType&| NIL)
                  (CONS
                   '#((|Module| 29) (|BiModule| 29 29) (|LeftModule| 29)
                      (|RightModule| 29) (|AbelianGroup|)
                      (|CancellationAbelianMonoid|) (|AbelianMonoid|)
                      (|AbelianSemiGroup|) (|RetractableTo| 6) (|SetCategory|)
                      (|CoercibleFrom| 6) (|BasicType|) (|CoercibleTo| 10))
                   (|makeByteWordVec2| 105
                                       '(0 8 0 9 1 8 10 0 11 0 6 0 17 2 29 0 0
                                         29 30 1 6 27 0 31 2 6 0 0 0 33 1 29 0
                                         13 34 1 29 13 0 36 1 6 0 13 37 1 29 13
                                         0 38 2 6 0 0 0 39 2 6 27 0 0 40 2 6 0
                                         0 0 41 1 6 0 8 42 2 0 0 6 8 43 1 45 44
                                         0 46 0 6 0 47 2 45 6 0 44 48 1 6 0 0
                                         49 2 45 6 0 6 50 1 6 10 0 51 2 10 0 0
                                         52 53 0 45 0 54 1 10 0 0 55 2 10 0 0 0
                                         56 2 45 10 0 10 57 1 13 10 0 58 2 10 0
                                         0 0 59 2 6 27 0 0 60 2 10 0 0 0 61 1
                                         62 0 0 63 1 6 8 0 64 2 6 0 0 8 65 1 0
                                         66 0 67 0 29 0 68 2 29 27 0 0 69 2 19
                                         0 70 0 71 2 21 0 72 0 73 2 19 0 0 0 74
                                         2 21 0 0 0 75 2 6 0 0 8 77 2 0 6 0 8
                                         80 2 45 0 78 0 81 0 45 0 82 2 45 27 0
                                         0 83 1 45 0 0 84 1 45 6 0 85 3 45 87 0
                                         0 0 88 2 44 0 0 0 89 2 45 0 6 44 90 2
                                         45 0 0 0 91 2 45 0 0 0 92 2 93 0 0 0
                                         94 2 10 0 0 0 96 2 93 10 97 0 98 1 10
                                         0 52 99 1 10 0 0 100 2 0 27 0 0 1 1 2
                                         27 0 1 2 1 101 0 0 1 0 2 0 1 1 0 66 0
                                         67 1 0 6 0 1 1 0 6 0 24 2 2 27 0 0 1 1
                                         0 21 0 26 3 0 0 6 19 21 22 1 0 19 0 25
                                         1 0 104 0 1 2 5 0 6 8 43 2 0 0 6 6 32
                                         2 0 103 103 0 1 1 0 105 0 1 1 0 27 0
                                         28 2 4 6 0 8 80 2 0 6 0 78 79 1 0 0 6
                                         23 1 0 10 0 95 0 2 0 16 2 0 27 0 0 1 2
                                         1 0 0 0 1 1 1 0 0 15 2 0 0 0 0 76 2 1
                                         0 13 0 14 2 2 0 44 0 1 2 0 0 0 29 1 2
                                         0 0 29 0 35 2 0 0 102 0 1)))))
           '|lookupComplete|)) 

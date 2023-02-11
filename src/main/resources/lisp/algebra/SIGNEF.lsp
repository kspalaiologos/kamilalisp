
(SDEFUN |SIGNEF;sign;FSOcU;1|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (|OrderedCompletion| F))
         ($ (|Union| (|Integer|) "failed")))
        (COND ((NULL (SPADCALL |f| (QREFELT $ 10))) (CONS 1 "failed"))
              ('T (|SIGNEF;insign| |f| |x| |a| 0 $)))) 

(SDEFUN |SIGNEF;sign;FSFSU;2|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (F)) (|st| (|String|))
         ($ (|Union| (|Integer|) "failed")))
        (COND ((NULL (SPADCALL |f| (QREFELT $ 10))) (CONS 1 "failed"))
              ('T (|SIGNEF;psign| |f| |x| |a| |st| 0 $)))) 

(SDEFUN |SIGNEF;sign;FU;3| ((|f| (F)) ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((#2=#:G802 NIL) (|r| (|Union| (|Interval| (|Float|)) "failed"))
          (|f2| (|Expression| (|Interval| (|Float|))))
          (|f2u| (|Union| (|Expression| (|Interval| (|Float|))) "failed"))
          (|mapfun| (|Mapping| (|Interval| (|Float|)) R)) (#3=#:G801 NIL)
          (|ud| #4=(|Union| (|Integer|) #1#)) (|un| #4#))
         (SEQ
          (EXIT
           (SEQ
            (EXIT
             (COND ((NULL (SPADCALL |f| (QREFELT $ 10))) (CONS 1 "failed"))
                   ('T
                    (SEQ
                     (SEQ
                      (LETT |un|
                            (|SIGNEF;smpsign| (SPADCALL |f| (QREFELT $ 18)) $))
                      (EXIT
                       (COND
                        ((QEQCAR |un| 0)
                         (SEQ
                          (LETT |ud|
                                (|SIGNEF;smpsign| (SPADCALL |f| (QREFELT $ 19))
                                 $))
                          (EXIT
                           (COND
                            ((QEQCAR |ud| 0)
                             (PROGN
                              (LETT #3# (CONS 0 (* (QCDR |un|) (QCDR |ud|))))
                              (GO #5=#:G799))))))))))
                     (COND
                      ((NULL (NULL (SPADCALL |f| (QREFELT $ 21))))
                       (EXIT (CONS 1 "failed"))))
                     (EXIT
                      (COND
                       ((SPADCALL (SPADCALL "rootOf" (QREFELT $ 22))
                                  (SPADCALL (ELT $ 24)
                                            (SPADCALL |f| (QREFELT $ 26))
                                            (QREFELT $ 29))
                                  (QREFELT $ 30))
                        (CONS 1 "failed"))
                       (#6='T
                        (SEQ
                         (COND
                          ((|HasCategory| (QREFELT $ 6)
                                          (LIST '|ConvertibleTo| '(|Float|)))
                           (SEQ (LETT |mapfun| (CONS #'|SIGNEF;sign;FU;3!0| $))
                                (LETT |f2u|
                                      (|trappedSpadEval|
                                       (SPADCALL |mapfun| |f| (QREFELT $ 38))))
                                (EXIT
                                 (COND ((QEQCAR |f2u| 1) "failed")
                                       (#6#
                                        (SEQ (LETT |f2| (QCDR |f2u|))
                                             (LETT |r|
                                                   (SPADCALL |f2|
                                                             (QREFELT $ 40)))
                                             (COND
                                              ((QEQCAR |r| 1)
                                               (PROGN
                                                (LETT #2# (CONS 1 "failed"))
                                                (GO #7=#:G800))))
                                             (EXIT
                                              (COND
                                               ((SPADCALL (QCDR |r|)
                                                          (QREFELT $ 41))
                                                (PROGN
                                                 (LETT #2# (CONS 0 -1))
                                                 (GO #7#)))
                                               ((SPADCALL (QCDR |r|)
                                                          (QREFELT $ 44))
                                                (PROGN
                                                 (LETT #2# (CONS 0 1))
                                                 (GO #7#)))
                                               ((SPADCALL (QCDR |r|)
                                                          (QREFELT $ 45))
                                                (PROGN
                                                 (LETT #2# (CONS 0 0))
                                                 (GO #7#)))
                                               (#6# "failed"))))))))))
                         (EXIT (CONS 1 "failed"))))))))))
            #5# (EXIT #3#)))
          #7# (EXIT #2#)))) 

(SDEFUN |SIGNEF;sign;FU;3!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 32)) (QREFELT $ 34))) 

(SDEFUN |SIGNEF;overRF|
        ((|a| (|OrderedCompletion| F))
         ($
          (|Union| (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                   "failed")))
        (SPROG
         ((|u| (|Union| (|Fraction| (|Polynomial| R)) "failed"))
          (|n| (|SingleInteger|)))
         (SEQ (LETT |n| (SPADCALL |a| (QREFELT $ 48)))
              (EXIT
               (COND
                ((|eql_SI| |n| 0)
                 (SEQ
                  (LETT |u|
                        (SPADCALL (SPADCALL |a| (QREFELT $ 51))
                                  (QREFELT $ 53)))
                  (EXIT
                   (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                         (#1='T
                          (CONS 0 (SPADCALL (QCDR |u|) (QREFELT $ 56))))))))
                ((SPADCALL |n| 0 (QREFELT $ 57))
                 (CONS 0 (SPADCALL (QREFELT $ 58))))
                (#1# (CONS 0 (SPADCALL (QREFELT $ 59))))))))) 

(SDEFUN |SIGNEF;ofesign|
        ((|a| (|OrderedCompletion| F)) ($ (|Union| (|Integer|) "failed")))
        (SPROG ((|n| (|Integer|)))
               (COND
                ((SPADCALL (LETT |n| (SPADCALL |a| (QREFELT $ 48))) 0
                           (QREFELT $ 61))
                 (CONS 0 |n|))
                ('T (SPADCALL (SPADCALL |a| (QREFELT $ 51)) (QREFELT $ 46)))))) 

(SDEFUN |SIGNEF;insign|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (|OrderedCompletion| F))
         (|m| (|NonNegativeInteger|)) ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((|ur| #2=(|Union| (|Integer|) #1#)) (#3=#:G841 NIL) (|ul| #2#)
          (|s| (|Union| (|Integer|) #1#)) (|v| (F)) (|n| (|Integer|))
          (|u|
           (|Union| (|OrderedCompletion| F)
                    (|Record|
                     (|:| |leftHandLimit|
                          (|Union| (|OrderedCompletion| F) #4="failed"))
                     (|:| |rightHandLimit|
                          (|Union| (|OrderedCompletion| F) #4#)))
                    "failed"))
          (|eq| (|Equation| (|OrderedCompletion| F))) (#5=#:G850 NIL)
          (|ua|
           (|Union| (|OrderedCompletion| (|Fraction| (|Polynomial| R)))
                    "failed"))
          (|uf| (|Union| (|Fraction| (|Polynomial| R)) "failed")))
         (SEQ
          (COND ((> |m| 10) (CONS 1 "failed"))
                (#6='T
                 (SEQ
                  (EXIT
                   (SEQ
                    (SEQ (LETT |uf| (SPADCALL |f| (QREFELT $ 53)))
                         (EXIT
                          (COND
                           ((QEQCAR |uf| 0)
                            (SEQ (LETT |ua| (|SIGNEF;overRF| |a| $))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |ua| 0)
                                    (PROGN
                                     (LETT #5#
                                           (SPADCALL (QCDR |uf|) |x|
                                                     (QCDR |ua|)
                                                     (QREFELT $ 63)))
                                     (GO #7=#:G848))))))))))
                    (LETT |eq|
                          (SPADCALL
                           (SPADCALL (SPADCALL |x| (QREFELT $ 64))
                                     (QREFELT $ 65))
                           |a| (QREFELT $ 67)))
                    (LETT |u| (SPADCALL |f| |eq| (QREFELT $ 72)))
                    (EXIT
                     (COND ((QEQCAR |u| 2) (CONS 1 "failed"))
                           ((QEQCAR |u| 0)
                            (COND
                             ((SPADCALL
                               (LETT |n| (SPADCALL (QCDR |u|) (QREFELT $ 48)))
                               0 (QREFELT $ 61))
                              (CONS 0 |n|))
                             (#6#
                              (SEQ
                               (LETT |v| (SPADCALL (QCDR |u|) (QREFELT $ 51)))
                               (EXIT
                                (COND
                                 ((SPADCALL |v| (|spadConstant| $ 50)
                                            (QREFELT $ 73))
                                  (SEQ
                                   (LETT |s|
                                         (|SIGNEF;insign|
                                          (SPADCALL |f| |x| (QREFELT $ 74)) |x|
                                          |a| (+ |m| 1) $))
                                   (EXIT
                                    (COND ((QEQCAR |s| 1) (CONS 1 "failed"))
                                          (#6#
                                           (CONS 0 (- (* (QCDR |s|) |n|))))))))
                                 (#6# (SPADCALL |v| (QREFELT $ 46)))))))))
                           (#6#
                            (COND
                             ((OR (QEQCAR (QCAR (QCDR |u|)) 1)
                                  (QEQCAR (QCDR (QCDR |u|)) 1))
                              (CONS 1 "failed"))
                             ('T
                              (SEQ
                               (LETT |ul|
                                     (|SIGNEF;ofesign|
                                      (PROG2 (LETT #3# (QCAR (QCDR |u|)))
                                          (QCDR #3#)
                                        (|check_union2| (QEQCAR #3# 0)
                                                        (|OrderedCompletion|
                                                         (QREFELT $ 7))
                                                        (|Union|
                                                         (|OrderedCompletion|
                                                          (QREFELT $ 7))
                                                         #4#)
                                                        #3#))
                                      $))
                               (EXIT
                                (COND ((QEQCAR |ul| 1) (CONS 1 "failed"))
                                      (#6#
                                       (SEQ
                                        (LETT |ur|
                                              (|SIGNEF;ofesign|
                                               (PROG2
                                                   (LETT #3# (QCDR (QCDR |u|)))
                                                   (QCDR #3#)
                                                 (|check_union2| (QEQCAR #3# 0)
                                                                 (|OrderedCompletion|
                                                                  (QREFELT $
                                                                           7))
                                                                 (|Union|
                                                                  (|OrderedCompletion|
                                                                   (QREFELT $
                                                                            7))
                                                                  #4#)
                                                                 #3#))
                                               $))
                                        (EXIT
                                         (COND
                                          ((OR (QEQCAR |ur| 1)
                                               (NULL
                                                (EQL (QCDR |ul|) (QCDR |ur|))))
                                           (CONS 1 "failed"))
                                          ('T |ul|)))))))))))))))
                  #7# (EXIT #5#))))))) 

(SDEFUN |SIGNEF;psign|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (F)) (|st| (|String|))
         (|m| (|NonNegativeInteger|)) ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((|s| (|Union| (|Integer|) #1#)) (|v| (F)) (|n| (|Integer|))
          (|u| (|Union| (|OrderedCompletion| F) "failed"))
          (|eq| (|Equation| F)) (#2=#:G867 NIL)
          (|ua| #3=(|Union| (|Fraction| (|Polynomial| R)) "failed"))
          (|uf| #3#))
         (SEQ
          (COND ((> |m| 10) (CONS 1 "failed"))
                ((SPADCALL |f| (|spadConstant| $ 50) (QREFELT $ 73))
                 (CONS 0 0))
                (#4='T
                 (SEQ
                  (EXIT
                   (SEQ
                    (SEQ (LETT |uf| (SPADCALL |f| (QREFELT $ 53)))
                         (EXIT
                          (COND
                           ((QEQCAR |uf| 0)
                            (SEQ (LETT |ua| (SPADCALL |a| (QREFELT $ 53)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |ua| 0)
                                    (PROGN
                                     (LETT #2#
                                           (SPADCALL (QCDR |uf|) |x|
                                                     (QCDR |ua|) |st|
                                                     (QREFELT $ 75)))
                                     (GO #5=#:G865))))))))))
                    (LETT |eq|
                          (SPADCALL (SPADCALL |x| (QREFELT $ 64)) |a|
                                    (QREFELT $ 77)))
                    (LETT |u| (SPADCALL |f| |eq| |st| (QREFELT $ 78)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ((QEQCAR |u| 0)
                            (COND
                             ((SPADCALL
                               (LETT |n| (SPADCALL (QCDR |u|) (QREFELT $ 48)))
                               0 (QREFELT $ 61))
                              (CONS 0 |n|))
                             (#4#
                              (SEQ
                               (LETT |v| (SPADCALL (QCDR |u|) (QREFELT $ 51)))
                               (EXIT
                                (COND
                                 ((SPADCALL |v| (|spadConstant| $ 50)
                                            (QREFELT $ 73))
                                  (SEQ
                                   (LETT |s|
                                         (|SIGNEF;psign|
                                          (SPADCALL |f| |x| (QREFELT $ 74)) |x|
                                          |a| |st| (+ |m| 1) $))
                                   (EXIT
                                    (COND ((QEQCAR |s| 1) (CONS 1 "failed"))
                                          (#4#
                                           (CONS 0
                                                 (*
                                                  (SPADCALL |st|
                                                            (QREFELT $ 80))
                                                  (QCDR |s|))))))))
                                 (#4# (SPADCALL |v| (QREFELT $ 46)))))))))))))
                  #5# (EXIT #2#))))))) 

(SDEFUN |SIGNEF;smpsign2|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         ($ (|Union| (|Integer|) "failed")))
        (SPROG
         ((|ans| (|Integer|)) (#1=#:G891 NIL)
          (|u| (|Union| (|Integer|) "failed")) (#2=#:G892 NIL) (|term| NIL)
          (|s| (|Factored| (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|r| (|Union| R "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 83)))
                (EXIT
                 (COND ((QEQCAR |r| 0) (SPADCALL (QCDR |r|) (QREFELT $ 84)))
                       (#3='T
                        (SEQ
                         (LETT |u|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (LETT |s| (SPADCALL |p| (QREFELT $ 86)))
                                  (QREFELT $ 88))
                                 (QREFELT $ 89))
                                (QREFELT $ 84)))
                         (EXIT
                          (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                                (#3#
                                 (SEQ (LETT |ans| (QCDR |u|))
                                      (SEQ (LETT |term| NIL)
                                           (LETT #2#
                                                 (SPADCALL |s| (QREFELT $ 93)))
                                           G190
                                           (COND
                                            ((OR (ATOM #2#)
                                                 (PROGN
                                                  (LETT |term| (CAR #2#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (COND
                                              ((ODDP (QVELT |term| 2))
                                               (SEQ
                                                (LETT |u|
                                                      (|SIGNEF;sqfrSign|
                                                       (QVELT |term| 1) $))
                                                (EXIT
                                                 (COND
                                                  ((QEQCAR |u| 1)
                                                   (PROGN
                                                    (LETT #1#
                                                          (CONS 1 "failed"))
                                                    (GO #4=#:G890)))
                                                  ('T
                                                   (LETT |ans|
                                                         (* |ans|
                                                            (QCDR
                                                             |u|)))))))))))
                                           (LETT #2# (CDR #2#)) (GO G190) G191
                                           (EXIT NIL))
                                      (EXIT (CONS 0 |ans|))))))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |SIGNEF;smpsign|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((|zu| (|Union| (|Boolean|) "failed"))
          (|up| (|SparseUnivariatePolynomial| F)) (|b| (|OrderedCompletion| F))
          (|a| (|OrderedCompletion| F)) (|x0| (F))
          (|s0| (|Union| (|Integer|) #1#)) (|k| (|Kernel| F))
          (|vl| (|List| (|Kernel| F))) (|resu| (|Union| (|Integer|) #1#)))
         (SEQ (LETT |resu| (|SIGNEF;smpsign2| |p| $))
              (EXIT
               (COND ((QEQCAR |resu| 0) |resu|)
                     (#2='T
                      (SEQ (LETT |vl| (SPADCALL |p| (QREFELT $ 98)))
                           (EXIT
                            (COND
                             ((EQL (LENGTH |vl|) 1)
                              (SEQ (LETT |k| (|SPADfirst| |vl|))
                                   (LETT |s0| (|SIGNEF;kerSign| |k| $))
                                   (LETT |a| (SPADCALL (QREFELT $ 99)))
                                   (LETT |b| (SPADCALL (QREFELT $ 100)))
                                   (LETT |x0| (|spadConstant| $ 50))
                                   (COND
                                    ((QEQCAR |s0| 0)
                                     (SEQ
                                      (COND
                                       ((SPADCALL |s0| (CONS 0 1)
                                                  (QREFELT $ 101))
                                        (LETT |a|
                                              (SPADCALL (|spadConstant| $ 50)
                                                        (QREFELT $ 65)))))
                                      (EXIT
                                       (COND
                                        ((SPADCALL |s0| (CONS 0 -1)
                                                   (QREFELT $ 101))
                                         (LETT |b|
                                               (SPADCALL (|spadConstant| $ 50)
                                                         (QREFELT $ 65)))))))))
                                   (COND
                                    ((SPADCALL |k| '|atan| (QREFELT $ 103))
                                     (SEQ
                                      (LETT |a|
                                            (COND
                                             ((SPADCALL |a|
                                                        (SPADCALL
                                                         (|spadConstant| $ 50)
                                                         (QREFELT $ 65))
                                                        (QREFELT $ 104))
                                              |a|)
                                             (#2#
                                              (SPADCALL
                                               (SPADCALL (|spadConstant| $ 43)
                                                         (QREFELT $ 105))
                                               (QREFELT $ 65)))))
                                      (EXIT
                                       (LETT |b|
                                             (COND
                                              ((SPADCALL |b|
                                                         (SPADCALL
                                                          (|spadConstant| $ 50)
                                                          (QREFELT $ 65))
                                                         (QREFELT $ 104))
                                               |b|)
                                              (#2#
                                               (SPADCALL (|spadConstant| $ 43)
                                                         (QREFELT $ 65)))))))))
                                   (LETT |up|
                                         (SPADCALL (ELT $ 106)
                                                   (SPADCALL |p|
                                                             (QREFELT $ 108))
                                                   (QREFELT $ 112)))
                                   (LETT |zu|
                                         (SPADCALL |up| |a| |b| 'T
                                                   (QREFELT $ 115)))
                                   (EXIT
                                    (COND
                                     ((OR (QEQCAR |zu| 1) (QCDR |zu|))
                                      (CONS 1 "failed"))
                                     ('T
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |up| (QREFELT $ 96) |x0|
                                                  (QREFELT $ 116))
                                        (QREFELT $ 117))
                                       (QREFELT $ 46)))))))
                             (#2# (CONS 1 "failed"))))))))))) 

(SDEFUN |SIGNEF;sqfrSign|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((|u| (|Union| (|Integer|) #1#))
          (|l| (|List| (|SparseMultivariatePolynomial| R (|Kernel| F)))))
         (SEQ
          (LETT |u|
                (|SIGNEF;termSign|
                 (|SPADfirst| (LETT |l| (SPADCALL |p| (QREFELT $ 119)))) $))
          (EXIT
           (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                 ('T (|SIGNEF;listSign| (CDR |l|) (QCDR |u|) $))))))) 

(SDEFUN |SIGNEF;listSign|
        ((|l| (|List| (|SparseMultivariatePolynomial| R (|Kernel| F))))
         (|s| (|Integer|)) ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((#2=#:G917 NIL) (#3=#:G918 NIL) (|u| (|Union| (|Integer|) #1#))
          (#4=#:G919 NIL) (|term| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |term| NIL) (LETT #4# |l|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |term| (CAR #4#)) NIL))
                   (GO G191)))
                 (SEQ (LETT |u| (|SIGNEF;termSign| |term| $))
                      (EXIT
                       (COND
                        ((QEQCAR |u| 1)
                         (PROGN (LETT #3# (CONS 1 "failed")) (GO #5=#:G916)))
                        ('T
                         (SEQ
                          (EXIT
                           (COND
                            ((NULL (EQL |s| (QCDR |u|)))
                             (PROGN
                              (LETT #2#
                                    (PROGN
                                     (LETT #3# (CONS 1 "failed"))
                                     (GO #5#)))
                              (GO #6=#:G912)))))
                          #6# (EXIT #2#))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 0 |s|))))
          #5# (EXIT #3#)))) 

(SDEFUN |SIGNEF;termSign|
        ((|term| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((#2=#:G930 NIL) (#3=#:G931 NIL) (#4=#:G929 NIL)
          (|vs| (|Union| (|Integer|) #1#)) (#5=#:G932 NIL)
          (|lv| (|List| (|Kernel| F))) (|var| NIL)
          (|us| (|Union| (|Integer|) "failed")))
         (SEQ
          (EXIT
           (SEQ
            (LETT |us|
                  (SPADCALL (SPADCALL |term| (QREFELT $ 120)) (QREFELT $ 84)))
            (EXIT
             (COND ((QEQCAR |us| 1) (CONS 1 "failed"))
                   ('T
                    (SEQ
                     (SEQ
                      (EXIT
                       (SEQ (LETT |var| NIL)
                            (LETT #5#
                                  (LETT |lv| (SPADCALL |term| (QREFELT $ 98))))
                            G190
                            (COND
                             ((OR (ATOM #5#)
                                  (PROGN (LETT |var| (CAR #5#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((ODDP (SPADCALL |term| |var| (QREFELT $ 122)))
                                (PROGN
                                 (LETT #2#
                                       (SEQ
                                        (EXIT
                                         (SEQ
                                          (COND
                                           ((NULL (CDR |lv|))
                                            (SEQ
                                             (LETT |vs|
                                                   (|SIGNEF;kerSign|
                                                    (|SPADfirst| |lv|) $))
                                             (EXIT
                                              (COND
                                               ((QEQCAR |vs| 0)
                                                (PROGN
                                                 (LETT #4#
                                                       (PROGN
                                                        (LETT #3#
                                                              (CONS 0
                                                                    (*
                                                                     (QCDR
                                                                      |us|)
                                                                     (QCDR
                                                                      |vs|))))
                                                        (GO #6=#:G928)))
                                                 (GO #7=#:G923))))))))
                                          (EXIT
                                           (PROGN
                                            (LETT #3# (CONS 1 "failed"))
                                            (GO #6#)))))
                                        #7# (EXIT #4#)))
                                 (GO #8=#:G925))))))
                            (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL)))
                      #8# (EXIT #2#))
                     (EXIT (CONS 0 (QCDR |us|)))))))))
          #6# (EXIT #3#)))) 

(SDEFUN |SIGNEF;kerSign|
        ((|k| (|Kernel| F)) ($ (|Union| (|Integer|) #1="failed")))
        (SPROG
         ((|s| (|Union| (|Integer|) #1#)) (|arg| (|List| F))
          (|op| (|BasicOperator|)))
         (SEQ (LETT |op| (SPADCALL |k| (QREFELT $ 123)))
              (COND
               ((OR (SPADCALL |op| '|pi| (QREFELT $ 124))
                    (OR (SPADCALL |op| '|exp| (QREFELT $ 124))
                        (OR (SPADCALL |op| '|cosh| (QREFELT $ 124))
                            (SPADCALL |op| '|sech| (QREFELT $ 124)))))
                (EXIT (CONS 0 1))))
              (EXIT
               (COND
                ((NULL (LETT |arg| (SPADCALL |k| (QREFELT $ 126))))
                 (CONS 1 "failed"))
                (#2='T
                 (SEQ (LETT |s| (SPADCALL (|SPADfirst| |arg|) (QREFELT $ 46)))
                      (EXIT
                       (COND
                        ((QEQCAR |s| 1)
                         (COND
                          ((SPADCALL |op| '|nthRoot| (QREFELT $ 124))
                           (COND
                            ((EVENP
                              (SPADCALL (SPADCALL |arg| (QREFELT $ 127))
                                        (QREFELT $ 128)))
                             (CONS 0 1))
                            (#2# (CONS 1 "failed"))))
                          (#2# (CONS 1 "failed"))))
                        ((SPADCALL |op| '|log| (QREFELT $ 124))
                         (COND ((< (QCDR |s|) 0) (CONS 1 "failed"))
                               (#2#
                                (SPADCALL
                                 (SPADCALL (|SPADfirst| |arg|)
                                           (|spadConstant| $ 43)
                                           (QREFELT $ 129))
                                 (QREFELT $ 46)))))
                        ((OR
                          (OR (SPADCALL |op| '|tanh| (QREFELT $ 124))
                              (OR (SPADCALL |op| '|sinh| (QREFELT $ 124))
                                  (OR (SPADCALL |op| '|csch| (QREFELT $ 124))
                                      (SPADCALL |op| '|coth|
                                                (QREFELT $ 124)))))
                          (OR (SPADCALL |op| '|atan| (QREFELT $ 124))
                              (OR (SPADCALL |op| '|Si| (QREFELT $ 124))
                                  (OR
                                   (SPADCALL |op| '|fresnelS| (QREFELT $ 124))
                                   (SPADCALL |op| '|fresnelC|
                                             (QREFELT $ 124))))))
                         |s|)
                        ('T
                         (COND
                          ((SPADCALL |op| '|nthRoot| (QREFELT $ 124))
                           (COND
                            ((EVENP
                              (SPADCALL (SPADCALL |arg| (QREFELT $ 127))
                                        (QREFELT $ 128)))
                             (COND ((< (QCDR |s|) 0) (CONS 1 "failed"))
                                   (#2# |s|)))
                            (#2# |s|)))
                          ((SPADCALL |op| '|%power| (QREFELT $ 124))
                           (COND ((< (QCDR |s|) 0) (CONS 1 "failed"))
                                 (#2# |s|)))
                          (#2# (CONS 1 "failed"))))))))))))) 

(DECLAIM (NOTINLINE |ElementaryFunctionSign;|)) 

(DEFUN |ElementaryFunctionSign| (&REST #1=#:G959)
  (SPROG NIL
         (PROG (#2=#:G960)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ElementaryFunctionSign|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ElementaryFunctionSign;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ElementaryFunctionSign|)))))))))) 

(DEFUN |ElementaryFunctionSign;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ElementaryFunctionSign| DV$1 DV$2))
          (LETT $ (GETREFV 130))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ElementaryFunctionSign|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 96 (SPADCALL (QREFELT $ 95)))
          $))) 

(MAKEPROP '|ElementaryFunctionSign| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (|TrigonometricManipulations| 6 7) (0 . |real?|)
              (|Union| 60 '#1="failed") (|Symbol|) (|OrderedCompletion| 7)
              |SIGNEF;sign;FSOcU;1| (|String|) |SIGNEF;sign;FSFSU;2|
              (|SparseMultivariatePolynomial| 6 (|Kernel| $)) (5 . |numer|)
              (10 . |denom|) (|List| 12) (15 . |variables|) (20 . |coerce|)
              (|BasicOperator|) (25 . |name|) (|List| 23) (30 . |operators|)
              (|Mapping| 12 23) (|ListFunctions2| 23 12) (35 . |map|)
              (41 . |member?|) (|Float|) (47 . |convert|) (|Interval| 31)
              (52 . |interval|) (|Expression| 33) (|Mapping| 33 6)
              (|FunctionSpaceFunctions2| 6 7 33 35) (57 . |map|)
              (|Union| 33 '"failed") (63 . |retractIfCan|) (68 . |negative?|)
              (73 . |One|) (77 . |One|) (81 . |positive?|) (86 . |zero?|)
              |SIGNEF;sign;FU;3| (|SingleInteger|) (91 . |whatInfinity|)
              (96 . |Zero|) (100 . |Zero|) (104 . |retract|)
              (|Union| 54 '"failed") (109 . |retractIfCan|)
              (|Fraction| (|Polynomial| 6)) (|OrderedCompletion| 54)
              (114 . |coerce|) (119 . >) (125 . |plusInfinity|)
              (129 . |minusInfinity|) (|Integer|) (133 . ~=)
              (|RationalFunctionSign| 6) (139 . |sign|) (146 . |coerce|)
              (151 . |coerce|) (|Equation| 13) (156 . |equation|)
              (|Union| 13 '"failed")
              (|Record| (|:| |leftHandLimit| 68) (|:| |rightHandLimit| 68))
              (|Union| 13 69 '"failed") (|PowerSeriesLimitPackage| 6 7)
              (162 . |limit|) (168 . =) (174 . |differentiate|) (180 . |sign|)
              (|Equation| 7) (188 . |equation|) (194 . |limit|)
              (|ToolsForSign| 6) (201 . |direction|) (|Union| 6 '"failed")
              (|SparseMultivariatePolynomial| 6 102) (206 . |retractIfCan|)
              (211 . |sign|) (|Factored| $) (216 . |squareFree|)
              (|Factored| 82) (221 . |unit|) (226 . |retract|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 90) (|:| |factor| 82) (|:| |exponent| 121))
              (|List| 91) (231 . |factorList|) (|SingletonAsOrderedSet|)
              (236 . |create|) '|sas| (|List| 102) (240 . |variables|)
              (245 . |minusInfinity|) (249 . |plusInfinity|) (253 . =)
              (|Kernel| 7) (259 . |is?|) (265 . =) (271 . -) (276 . |coerce|)
              (|SparseUnivariatePolynomial| 6) (281 . |univariate|)
              (|SparseUnivariatePolynomial| 7) (|Mapping| 7 6)
              (|SparseUnivariatePolynomialFunctions2| 6 7) (286 . |map|)
              (|Union| 8 '"failed") (|DefiniteIntegrationTools| 6 7)
              (292 . |checkForZero|) (300 . |eval|) (307 . |retract|)
              (|List| $) (312 . |monomials|) (317 . |leadingCoefficient|)
              (|NonNegativeInteger|) (322 . |degree|) (328 . |operator|)
              (333 . |is?|) (|List| 7) (339 . |argument|) (344 . |second|)
              (349 . |retract|) (354 . -))
           '#(|sign| 360) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|sign| ((|Union| (|Integer|) #1#) |#2|)) T)
                              '((|sign|
                                 ((|Union| (|Integer|) #1#) |#2| (|Symbol|)
                                  (|OrderedCompletion| |#2|)))
                                T)
                              '((|sign|
                                 ((|Union| (|Integer|) #1#) |#2| (|Symbol|)
                                  |#2| (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 129
                                            '(1 9 8 7 10 1 7 17 0 18 1 7 17 0
                                              19 1 7 20 0 21 1 12 0 15 22 1 23
                                              12 0 24 1 7 25 0 26 2 28 20 27 25
                                              29 2 20 8 12 0 30 1 6 31 0 32 1
                                              33 0 31 34 2 37 35 36 7 38 1 35
                                              39 0 40 1 33 8 0 41 0 6 0 42 0 7
                                              0 43 1 33 8 0 44 1 33 8 0 45 1 13
                                              47 0 48 0 6 0 49 0 7 0 50 1 13 7
                                              0 51 1 7 52 0 53 1 55 0 54 56 2
                                              47 8 0 0 57 0 55 0 58 0 55 0 59 2
                                              60 8 0 0 61 3 62 11 54 12 55 63 1
                                              7 0 12 64 1 13 0 7 65 2 66 0 13
                                              13 67 2 71 70 7 66 72 2 7 8 0 0
                                              73 2 7 0 0 12 74 4 62 11 54 12 54
                                              15 75 2 76 0 7 7 77 3 71 68 7 76
                                              15 78 1 79 60 15 80 1 82 81 0 83
                                              1 79 11 6 84 1 82 85 0 86 1 87 82
                                              0 88 1 82 6 0 89 1 87 92 0 93 0
                                              94 0 95 1 82 97 0 98 0 13 0 99 0
                                              13 0 100 2 11 8 0 0 101 2 102 8 0
                                              12 103 2 13 8 0 0 104 1 7 0 0 105
                                              1 7 0 6 106 1 82 107 0 108 2 111
                                              109 110 107 112 4 114 113 109 13
                                              13 8 115 3 109 0 0 94 7 116 1 109
                                              7 0 117 1 82 118 0 119 1 82 6 0
                                              120 2 82 121 0 102 122 1 102 23 0
                                              123 2 23 8 0 12 124 1 102 125 0
                                              126 1 125 7 0 127 1 7 60 0 128 2
                                              7 0 0 0 129 1 0 11 7 46 4 0 11 7
                                              12 7 15 16 3 0 11 7 12 13 14)))))
           '|lookupComplete|)) 


(SDEFUN |DFINTTLS;variation|
        ((|p| (|SparseUnivariatePolynomial| F)) (|a| (F))
         ($ (|Union| (|Integer|) "failed")))
        (|DFINTTLS;var|
         (SPADCALL |p|
                   (SPADCALL (SPADCALL (|spadConstant| $ 9) 1 (QREFELT $ 12))
                             (SPADCALL |a| (QREFELT $ 13)) (QREFELT $ 14))
                   (QREFELT $ 15))
         $)) 

(SDEFUN |DFINTTLS;keeprec?|
        ((|a| (|Fraction| (|Integer|)))
         (|rec|
          (|Record| (|:| |left| (|Fraction| (|Integer|)))
                    (|:| |right| (|Fraction| (|Integer|)))))
         ($ (|Boolean|)))
        (COND ((SPADCALL |a| (QCDR |rec|) (QREFELT $ 18)) 'T)
              ('T (SPADCALL |a| (QCAR |rec|) (QREFELT $ 19))))) 

(SDEFUN |DFINTTLS;checkHalfAx|
        ((|p| (|SparseUnivariatePolynomial| F)) (|a| (F)) (|d| (|Integer|))
         (|incl?| (|Boolean|)) ($ (|Union| (|Boolean|) "failed")))
        (|DFINTTLS;posRoot|
         (SPADCALL |p|
                   (SPADCALL |d|
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 9) 1 (QREFELT $ 12))
                              (SPADCALL |a| (QREFELT $ 13)) (QREFELT $ 14))
                             (QREFELT $ 21))
                   (QREFELT $ 15))
         |incl?| $)) 

(SDEFUN |DFINTTLS;ignore?;SB;4| ((|str| (|String|)) ($ (|Boolean|)))
        (COND ((EQUAL |str| "noPole") 'T)
              ('T (|error| "integrate: last argument must be 'noPole'")))) 

(SDEFUN |DFINTTLS;computeInt;KF2OcBU;5|
        ((|k| (|Kernel| F)) (|f| (F)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) (|eval?| (|Boolean|))
         ($ (|Union| (|OrderedCompletion| F) "failed")))
        (SPROG
         ((#1=#:G749 NIL) (|ia| #2=(|Union| (|OrderedCompletion| F) "failed"))
          (|ib| #2#))
         (SEQ
          (COND ((SPADCALL |f| '|integral| (QREFELT $ 25)) (CONS 1 "failed"))
                (#3='T
                 (SEQ
                  (EXIT
                   (SEQ
                    (COND
                     ((NULL |eval?|) (LETT |f| (|DFINTTLS;mkLogPos| |f| $))))
                    (SEQ
                     (LETT |ib|
                           (|DFINTTLS;findLimit| |f| |k| |b| "left" |eval?| $))
                     (EXIT
                      (COND
                       ((QEQCAR |ib| 1)
                        (PROGN (LETT #1# (CONS 1 #4="failed")) (GO #5=#:G743)))
                       (#3#
                        (SEQ
                         (LETT |ia|
                               (|DFINTTLS;findLimit| |f| |k| |a| "right"
                                |eval?| $))
                         (EXIT
                          (COND
                           ((QEQCAR |ia| 1)
                            (PROGN (LETT #1# (CONS 1 #4#)) (GO #5#))))))))))
                    (COND
                     ((SPADCALL (QCDR |ia|) (QREFELT $ 27))
                      (COND
                       ((SPADCALL (QCDR |ia|) (QCDR |ib|) (QREFELT $ 28))
                        (EXIT (CONS 1 "failed"))))))
                    (EXIT
                     (CONS 0
                           (SPADCALL (QCDR |ib|)
                                     (SPADCALL (QCDR |ia|) (QREFELT $ 29))
                                     (QREFELT $ 30))))))
                  #5# (EXIT #1#))))))) 

(SDEFUN |DFINTTLS;findLimit|
        ((|f| (F)) (|k| (|Kernel| F)) (|a| (|OrderedCompletion| F))
         (|dir| (|String|)) (|eval?| (|Boolean|))
         ($ (|Union| (|OrderedCompletion| F) "failed")))
        (SPROG
         ((|u|
           (|Union| (|OrderedCompletion| F)
                    (|Record|
                     (|:| |leftHandLimit|
                          (|Union| (|OrderedCompletion| F) #1="failed"))
                     (|:| |rightHandLimit|
                          (|Union| (|OrderedCompletion| F) #1#)))
                    "failed"))
          (|r| (|Union| F "failed")))
         (SEQ (LETT |r| (SPADCALL |a| (QREFELT $ 35)))
              (EXIT
               (COND
                ((QEQCAR |r| 0)
                 (COND
                  (|eval?|
                   (CONS 0
                         (SPADCALL
                          (|DFINTTLS;mkLogPos|
                           (SPADCALL |f| |k| (QCDR |r|) (QREFELT $ 37)) $)
                          (QREFELT $ 38))))
                  (#2='T
                   (SEQ
                    (LETT |u|
                          (SPADCALL |f|
                                    (SPADCALL (SPADCALL |k| (QREFELT $ 39))
                                              (QCDR |r|) (QREFELT $ 41))
                                    |dir| (QREFELT $ 43)))
                    (EXIT
                     (COND ((QEQCAR |u| 0) (CONS 0 (QCDR |u|)))
                           (#2# (CONS 1 "failed"))))))))
                (#2#
                 (SEQ
                  (LETT |u|
                        (SPADCALL |f|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |k| (QREFELT $ 39))
                                             (QREFELT $ 38))
                                   |a| (QREFELT $ 45))
                                  (QREFELT $ 48)))
                  (EXIT
                   (COND ((QEQCAR |u| 0) (CONS 0 (QCDR |u|)))
                         (#2# (CONS 1 "failed"))))))))))) 

(SDEFUN |DFINTTLS;mkLogPos| ((|f| (F)) ($ (F)))
        (SPROG
         ((|lv| (|List| F)) (|lk| (|List| (|Kernel| F)))
          (|v| (|Union| F "positive")) (#1=#:G778 NIL) (|k| NIL))
         (SEQ (LETT |lk| NIL) (LETT |lv| NIL)
              (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |f| (QREFELT $ 50))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |k| '|log| (QREFELT $ 51))
                       (SEQ (LETT |v| (|DFINTTLS;mkKerPos| |k| $))
                            (EXIT
                             (COND
                              ((QEQCAR |v| 0)
                               (SEQ (LETT |lk| (CONS |k| |lk|))
                                    (EXIT
                                     (LETT |lv|
                                           (CONS (QCDR |v|) |lv|))))))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |f| |lk| |lv| (QREFELT $ 53)))))) 

(SDEFUN |DFINTTLS;mkKerPos| ((|k| (|Kernel| F)) ($ (|Union| F "positive")))
        (SPROG ((|u| (|Union| (|Boolean|) "failed")) (|f| (F)))
               (SEQ
                (LETT |u|
                      (|DFINTTLS;negative|
                       (LETT |f| (|SPADfirst| (SPADCALL |k| (QREFELT $ 55))))
                       $))
                (EXIT
                 (COND
                  ((QEQCAR |u| 1)
                   (CONS 0
                         (SPADCALL
                          (SPADCALL (SPADCALL |f| 2 (QREFELT $ 57))
                                    (QREFELT $ 58))
                          (SPADCALL 2 (QREFELT $ 59)) (QREFELT $ 60))))
                  ((QCDR |u|)
                   (CONS 0
                         (SPADCALL (SPADCALL |f| (QREFELT $ 61))
                                   (QREFELT $ 58))))
                  ('T (CONS 1 "positive"))))))) 

(SDEFUN |DFINTTLS;negative| ((|f| (F)) ($ (|Union| (|Boolean|) "failed")))
        (SPROG ((|u| (|Union| (|Integer|) "failed")))
               (SEQ (LETT |u| (SPADCALL |f| (QREFELT $ 64)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (CONS 0 (< (QCDR |u|) 0)))))))) 

(SDEFUN |DFINTTLS;checkForZero;PS2OcBU;10|
        ((|p| (|Polynomial| R)) (|x| (|Symbol|)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) (|incl?| (|Boolean|))
         ($ (|Union| (|Boolean|) "failed")))
        (SPADCALL
         (SPADCALL (ELT $ 68) (SPADCALL |p| |x| (QREFELT $ 70)) (QREFELT $ 74))
         |a| |b| |incl?| (QREFELT $ 76))) 

(SDEFUN |DFINTTLS;checkForZero;Sup2OcBU;11|
        ((|q| (|SparseUnivariatePolynomial| F)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) (|incl?| (|Boolean|))
         ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((|u| (|Union| (|Boolean|) "failed")) (#1=#:G824 NIL)
          (|i|
           (|Union|
            (|:| |fin|
                 (|Record| (|:| |left| (|Fraction| (|Integer|)))
                           (|:| |right| (|Fraction| (|Integer|)))))
            (|:| |halfinf|
                 (|Record| (|:| |endpoint| (|Fraction| (|Integer|)))
                           (|:| |dir| (|Integer|))))
            (|:| |all| "all") (|:| |failed| "failed")))
          (|d| (|Union| (|SparseUnivariatePolynomial| (|Integer|)) "failed")))
         (SEQ
          (COND ((SPADCALL |q| (QREFELT $ 78)) (CONS 0 NIL))
                (#2='T
                 (SEQ
                  (EXIT
                   (SEQ
                    (SEQ (LETT |d| (|DFINTTLS;maprat| |q| $))
                         (EXIT
                          (COND
                           ((QEQCAR |d| 0)
                            (SEQ (LETT |i| (|DFINTTLS;intrat| |a| |b| $))
                                 (EXIT
                                  (COND
                                   ((NULL (QEQCAR |i| 3))
                                    (PROGN
                                     (LETT #1#
                                           (COND
                                            ((NULL
                                              (|DFINTTLS;findRealZero|
                                               (QCDR |d|) |i| |incl?| $))
                                             (CONS 0 NIL))
                                            (#2# (CONS 0 'T))))
                                     (GO #3=#:G821))))))))))
                    (LETT |u| (|DFINTTLS;checkBudan| |q| |a| |b| |incl?| $))
                    (EXIT
                     (COND
                      ((QEQCAR |u| 1)
                       (COND (|incl?| (|DFINTTLS;checkDeriv| |q| |a| |b| $))
                             (#2# (CONS 1 "failed"))))
                      (#2# (CONS 0 (QCDR |u|)))))))
                  #3# (EXIT #1#))))))) 

(SDEFUN |DFINTTLS;maprat|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($ (|Union| (|SparseUnivariatePolynomial| (|Integer|)) "failed")))
        (SPROG
         ((|ans| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (#1=#:G839 NIL) (|r| (|Union| (|Fraction| (|Integer|)) "failed"))
          (|c| (F)))
         (SEQ
          (EXIT
           (SEQ (LETT |ans| (|spadConstant| $ 80))
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL |p| (|spadConstant| $ 81) (QREFELT $ 82)))
                       (GO G191)))
                     (SEQ
                      (LETT |r|
                            (SPADCALL (LETT |c| (SPADCALL |p| (QREFELT $ 83)))
                                      (QREFELT $ 85)))
                      (EXIT
                       (COND
                        ((QEQCAR |r| 1)
                         (PROGN (LETT #1# (CONS 1 "failed")) (GO #2=#:G838)))
                        ('T
                         (SEQ
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (SPADCALL (QCDR |r|)
                                                    (SPADCALL |p|
                                                              (QREFELT $ 86))
                                                    (QREFELT $ 87))
                                          (QREFELT $ 88)))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 89)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT
                 (CONS 0
                       (SPADCALL (ELT $ 90)
                                 (QCAR (SPADCALL |ans| (QREFELT $ 93)))
                                 (QREFELT $ 97))))))
          #2# (EXIT #1#)))) 

(SDEFUN |DFINTTLS;intrat|
        ((|a| (|OrderedCompletion| F)) (|b| (|OrderedCompletion| F))
         ($
          (|Union|
           (|:| |fin|
                (|Record| (|:| |left| (|Fraction| (|Integer|)))
                          (|:| |right| (|Fraction| (|Integer|)))))
           (|:| |halfinf|
                (|Record| (|:| |endpoint| (|Fraction| (|Integer|)))
                          (|:| |dir| (|Integer|))))
           (|:| |all| #1="all") (|:| |failed| #2="failed"))))
        (SPROG
         ((|t| #3=(|Union| (|Fraction| (|Integer|)) "failed"))
          (|n| (|SingleInteger|)) (|q| #3#) (|r| (|Union| F "failed")))
         (SEQ
          (COND
           ((SPADCALL (LETT |n| (SPADCALL |a| (QREFELT $ 99))) 0
                      (QREFELT $ 100))
            (SEQ (LETT |r| (SPADCALL |b| (QREFELT $ 35)))
                 (EXIT
                  (COND ((QEQCAR |r| 1) (CONS 2 #1#))
                        (#4='T
                         (SEQ (LETT |q| (SPADCALL (QCDR |r|) (QREFELT $ 85)))
                              (EXIT
                               (COND ((QEQCAR |q| 1) (CONS 3 #2#))
                                     (#4#
                                      (CONS 1 (CONS (QCDR |q|) |n|)))))))))))
           (#4#
            (SEQ
             (LETT |q|
                   (SPADCALL (SPADCALL |a| (QREFELT $ 101)) (QREFELT $ 85)))
             (EXIT
              (COND ((QEQCAR |q| 1) (CONS 3 #2#))
                    ((SPADCALL (LETT |n| (SPADCALL |b| (QREFELT $ 99))) 0
                               (QREFELT $ 100))
                     (CONS 1 (CONS (QCDR |q|) |n|)))
                    (#4#
                     (SEQ
                      (LETT |t|
                            (SPADCALL (SPADCALL |b| (QREFELT $ 101))
                                      (QREFELT $ 85)))
                      (EXIT
                       (COND ((QEQCAR |t| 1) (CONS 3 #2#))
                             (#4#
                              (CONS 0 (CONS (QCDR |q|) (QCDR |t|)))))))))))))))) 

(SDEFUN |DFINTTLS;findRealZero|
        ((|p| (|SparseUnivariatePolynomial| (|Integer|)))
         (|i|
          (|Union|
           (|:| |fin|
                #1=(|Record| (|:| |left| (|Fraction| (|Integer|)))
                             (|:| |right| (|Fraction| (|Integer|)))))
           (|:| |halfinf|
                (|Record| (|:| |endpoint| #2=(|Fraction| (|Integer|)))
                          (|:| |dir| (|Integer|))))
           (|:| |all| #3="all") (|:| |failed| #4="failed")))
         (|incl?| (|Boolean|))
         ($
          (|List|
           (|Record| (|:| |left| #5=(|Fraction| (|Integer|)))
                     (|:| |right| #6=(|Fraction| (|Integer|)))))))
        (SPROG
         ((|ep| #2#) (#7=#:G862 NIL)
          (|l|
           (|List|
            (|Record| (|:| |left| (|Fraction| (|Integer|)))
                      (|:| |right| (|Fraction| (|Integer|))))))
          (#8=#:G877 NIL)
          (|u|
           (|Union|
            (|Record| (|:| |left| (|Fraction| (|Integer|)))
                      (|:| |right| (|Fraction| (|Integer|))))
            #9="failed"))
          (#10=#:G889 NIL) (|t| NIL) (#11=#:G888 NIL)
          (|bounds|
           (|Record| (|:| |left| (|Fraction| (|Integer|)))
                     (|:| |right| (|Fraction| (|Integer|)))))
          (#12=#:G872 NIL) (#13=#:G871 #5#) (#14=#:G873 #5#) (#15=#:G887 NIL)
          (#16=#:G869 NIL) (#17=#:G868 #6#) (#18=#:G870 #6#) (#19=#:G886 NIL)
          (|r| #1#))
         (SEQ (LETT |p| (SPADCALL |p| (QREFELT $ 102)))
              (EXIT
               (COND
                ((QEQCAR |i| 0)
                 (SEQ
                  (LETT |l|
                        (SPADCALL |p| (LETT |r| (CDR |i|)) (QREFELT $ 106)))
                  (EXIT
                   (COND (|incl?| |l|)
                         (#20='T
                          (SPADCALL
                           (CONS #'|DFINTTLS;findRealZero!0| (VECTOR $ |r|))
                           |l| (QREFELT $ 108)))))))
                ((QEQCAR |i| 2) (SPADCALL |p| (QREFELT $ 109)))
                ((QEQCAR |i| 1)
                 (COND ((NULL (LETT |l| (SPADCALL |p| (QREFELT $ 109)))) NIL)
                       (#20#
                        (SEQ
                         (LETT |bounds|
                               (COND
                                ((>
                                  (QCDR
                                   (PROG2 (LETT #7# |i|)
                                       (QCDR #7#)
                                     (|check_union2| (QEQCAR #7# 1)
                                                     (|Record|
                                                      (|:| |endpoint|
                                                           (|Fraction|
                                                            (|Integer|)))
                                                      (|:| |dir| (|Integer|)))
                                                     (|Union|
                                                      (|:| |fin|
                                                           (|Record|
                                                            (|:| |left|
                                                                 (|Fraction|
                                                                  (|Integer|)))
                                                            (|:| |right|
                                                                 (|Fraction|
                                                                  (|Integer|)))))
                                                      (|:| |halfinf|
                                                           (|Record|
                                                            (|:| |endpoint|
                                                                 (|Fraction|
                                                                  (|Integer|)))
                                                            (|:| |dir|
                                                                 (|Integer|))))
                                                      (|:| |all| #3#)
                                                      (|:| |failed| #4#))
                                                     #7#)))
                                  0)
                                 (CONS
                                  (QCAR
                                   (PROG2 (LETT #7# |i|)
                                       (QCDR #7#)
                                     (|check_union2| (QEQCAR #7# 1)
                                                     (|Record|
                                                      (|:| |endpoint|
                                                           (|Fraction|
                                                            (|Integer|)))
                                                      (|:| |dir| (|Integer|)))
                                                     (|Union|
                                                      (|:| |fin|
                                                           (|Record|
                                                            (|:| |left|
                                                                 (|Fraction|
                                                                  (|Integer|)))
                                                            (|:| |right|
                                                                 (|Fraction|
                                                                  (|Integer|)))))
                                                      (|:| |halfinf|
                                                           (|Record|
                                                            (|:| |endpoint|
                                                                 (|Fraction|
                                                                  (|Integer|)))
                                                            (|:| |dir|
                                                                 (|Integer|))))
                                                      (|:| |all| #3#)
                                                      (|:| |failed| #4#))
                                                     #7#)))
                                  (PROGN
                                   (LETT #16# NIL)
                                   (SEQ (LETT |t| NIL) (LETT #19# |l|) G190
                                        (COND
                                         ((OR (ATOM #19#)
                                              (PROGN
                                               (LETT |t| (CAR #19#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (PROGN
                                           (LETT #18# (QCDR |t|))
                                           (COND
                                            (#16#
                                             (LETT #17#
                                                   (SPADCALL #17# #18#
                                                             (QREFELT $ 110))))
                                            ('T
                                             (PROGN
                                              (LETT #17# #18#)
                                              (LETT #16# 'T)))))))
                                        (LETT #19# (CDR #19#)) (GO G190) G191
                                        (EXIT NIL))
                                   (COND (#16# #17#)
                                         (#20# (|IdentityError| '|max|))))))
                                (#20#
                                 (CONS
                                  (PROGN
                                   (LETT #12# NIL)
                                   (SEQ (LETT |t| NIL) (LETT #15# |l|) G190
                                        (COND
                                         ((OR (ATOM #15#)
                                              (PROGN
                                               (LETT |t| (CAR #15#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (PROGN
                                           (LETT #14# (QCAR |t|))
                                           (COND
                                            (#12#
                                             (LETT #13#
                                                   (SPADCALL #13# #14#
                                                             (QREFELT $ 111))))
                                            ('T
                                             (PROGN
                                              (LETT #13# #14#)
                                              (LETT #12# 'T)))))))
                                        (LETT #15# (CDR #15#)) (GO G190) G191
                                        (EXIT NIL))
                                   (COND (#12# #13#)
                                         (#20# (|IdentityError| '|min|))))
                                  (QCAR
                                   (PROG2 (LETT #7# |i|)
                                       (QCDR #7#)
                                     (|check_union2| (QEQCAR #7# 1)
                                                     (|Record|
                                                      (|:| |endpoint|
                                                           (|Fraction|
                                                            (|Integer|)))
                                                      (|:| |dir| (|Integer|)))
                                                     (|Union|
                                                      (|:| |fin|
                                                           (|Record|
                                                            (|:| |left|
                                                                 (|Fraction|
                                                                  (|Integer|)))
                                                            (|:| |right|
                                                                 (|Fraction|
                                                                  (|Integer|)))))
                                                      (|:| |halfinf|
                                                           (|Record|
                                                            (|:| |endpoint|
                                                                 (|Fraction|
                                                                  (|Integer|)))
                                                            (|:| |dir|
                                                                 (|Integer|))))
                                                      (|:| |all| #3#)
                                                      (|:| |failed| #4#))
                                                     #7#)))))))
                         (LETT |l|
                               (PROGN
                                (LETT #11# NIL)
                                (SEQ (LETT |t| NIL) (LETT #10# |l|) G190
                                     (COND
                                      ((OR (ATOM #10#)
                                           (PROGN (LETT |t| (CAR #10#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((QEQCAR
                                          (LETT |u|
                                                (SPADCALL |p| |t| |bounds|
                                                          (QREFELT $ 113)))
                                          0)
                                         (LETT #11#
                                               (CONS
                                                (PROG2 (LETT #8# |u|)
                                                    (QCDR #8#)
                                                  (|check_union2|
                                                   (QEQCAR #8# 0)
                                                   (|Record|
                                                    (|:| |left|
                                                         (|Fraction|
                                                          (|Integer|)))
                                                    (|:| |right|
                                                         (|Fraction|
                                                          (|Integer|))))
                                                   (|Union|
                                                    (|Record|
                                                     (|:| |left|
                                                          (|Fraction|
                                                           (|Integer|)))
                                                     (|:| |right|
                                                          (|Fraction|
                                                           (|Integer|))))
                                                    #9#)
                                                   #8#))
                                                #11#))))))
                                     (LETT #10# (CDR #10#)) (GO G190) G191
                                     (EXIT (NREVERSE #11#)))))
                         (EXIT
                          (COND (|incl?| |l|)
                                (#20#
                                 (SEQ
                                  (LETT |ep|
                                        (QCAR
                                         (PROG2 (LETT #7# |i|)
                                             (QCDR #7#)
                                           (|check_union2| (QEQCAR #7# 1)
                                                           (|Record|
                                                            (|:| |endpoint|
                                                                 (|Fraction|
                                                                  (|Integer|)))
                                                            (|:| |dir|
                                                                 (|Integer|)))
                                                           (|Union|
                                                            (|:| |fin|
                                                                 (|Record|
                                                                  (|:| |left|
                                                                       (|Fraction|
                                                                        (|Integer|)))
                                                                  (|:| |right|
                                                                       (|Fraction|
                                                                        (|Integer|)))))
                                                            (|:| |halfinf|
                                                                 (|Record|
                                                                  (|:|
                                                                   |endpoint|
                                                                   (|Fraction|
                                                                    (|Integer|)))
                                                                  (|:| |dir|
                                                                       (|Integer|))))
                                                            (|:| |all| #3#)
                                                            (|:| |failed| #4#))
                                                           #7#))))
                                  (EXIT
                                   (SPADCALL
                                    (CONS #'|DFINTTLS;findRealZero!1|
                                          (VECTOR $ |ep|))
                                    |l| (QREFELT $ 108)))))))))))
                (#20# (|error| "findRealZero: should not happpen"))))))) 

(SDEFUN |DFINTTLS;findRealZero!1| ((|s| NIL) ($$ NIL))
        (PROG (|ep| $)
          (LETT |ep| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|DFINTTLS;keeprec?| |ep| |s| $))))) 

(SDEFUN |DFINTTLS;findRealZero!0| ((|s| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((|DFINTTLS;keeprec?| (QCAR |r|) |s| $)
              (|DFINTTLS;keeprec?| (QCDR |r|) |s| $))
             ('T NIL)))))) 

(SDEFUN |DFINTTLS;checkBudan|
        ((|p| (|SparseUnivariatePolynomial| F)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) (|incl?| (|Boolean|))
         ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((|v| (|Integer|)) (|m| (|Integer|)) (#1=#:G910 NIL)
          (|vb| #2=(|Union| (|Integer|) "failed")) (|va| #2#)
          (|zb?| #3=(|Boolean|)) (|bb| (F)) (#4=#:G894 NIL)
          (|n| (|SingleInteger|)) (#5=#:G911 NIL) (|za?| #3#) (|aa| (F))
          (|r| (|Union| F "failed")))
         (SEQ (LETT |r| (SPADCALL |b| (QREFELT $ 35)))
              (EXIT
               (COND
                ((SPADCALL (LETT |n| (SPADCALL |a| (QREFELT $ 99))) 0
                           (QREFELT $ 100))
                 (COND ((QEQCAR |r| 1) (|DFINTTLS;realRoot| |p| $))
                       (#6='T
                        (|DFINTTLS;checkHalfAx| |p| (QCDR |r|) |n| |incl?|
                         $))))
                (#6#
                 (SEQ
                  (EXIT
                   (SEQ
                    (SEQ
                     (LETT |za?|
                           (SPADCALL
                            (SPADCALL |p|
                                      (LETT |aa|
                                            (SPADCALL |a| (QREFELT $ 101)))
                                      (QREFELT $ 114))
                            (QREFELT $ 115)))
                     (EXIT
                      (COND
                       (|za?|
                        (COND
                         (|incl?|
                          (PROGN (LETT #5# (CONS 0 'T)) (GO #7=#:G907))))))))
                    (EXIT
                     (COND
                      ((SPADCALL (LETT |n| (SPADCALL |b| (QREFELT $ 99))) 0
                                 (QREFELT $ 100))
                       (|DFINTTLS;checkHalfAx| |p| |aa| |n| |incl?| $))
                      (#6#
                       (SEQ
                        (EXIT
                         (SEQ
                          (SEQ
                           (LETT |zb?|
                                 (SPADCALL
                                  (SPADCALL |p|
                                            (LETT |bb|
                                                  (PROG2 (LETT #4# |r|)
                                                      (QCDR #4#)
                                                    (|check_union2|
                                                     (QEQCAR #4# 0)
                                                     (QREFELT $ 7)
                                                     (|Union| (QREFELT $ 7)
                                                              "failed")
                                                     #4#)))
                                            (QREFELT $ 114))
                                  (QREFELT $ 115)))
                           (EXIT
                            (COND
                             (|zb?|
                              (COND
                               (|incl?|
                                (PROGN
                                 (LETT #1# (CONS 0 'T))
                                 (GO #8=#:G906))))))))
                          (SEQ (LETT |va| (|DFINTTLS;variation| |p| |aa| $))
                               (EXIT
                                (COND
                                 ((QEQCAR |va| 1)
                                  (PROGN
                                   (LETT #1# (CONS 1 #9="failed"))
                                   (GO #8#)))
                                 (#6#
                                  (SEQ
                                   (LETT |vb|
                                         (|DFINTTLS;variation| |p| |bb| $))
                                   (EXIT
                                    (COND
                                     ((QEQCAR |vb| 1)
                                      (PROGN
                                       (LETT #1# (CONS 1 #9#))
                                       (GO #8#))))))))))
                          (LETT |m| 0) (COND (|za?| (LETT |m| (+ |m| 1))))
                          (COND (|zb?| (LETT |m| (+ |m| 1))))
                          (EXIT
                           (COND
                            ((ODDP (LETT |v| (- (QCDR |va|) (QCDR |vb|))))
                             (COND ((OR |incl?| (EVENP |m|)) (CONS 0 'T))
                                   ((EQL |v| 1) (CONS 0 NIL))
                                   (#6# (CONS 1 "failed"))))
                            ((ZEROP |v|) (CONS 0 NIL))
                            ((EQL |m| 1) (CONS 0 'T))
                            (#6# (CONS 1 "failed"))))))
                        #8# (EXIT #1#)))))))
                  #7# (EXIT #5#)))))))) 

(SDEFUN |DFINTTLS;checkDeriv|
        ((|p| (|SparseUnivariatePolynomial| F)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) ($ (|Union| (|Boolean|) #1="failed")))
        (SPROG
         ((|u| (|Union| (|Boolean|) #1#)) (|s| (|Union| (|Boolean|) "failed"))
          (|r| (|Union| F "failed")))
         (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 116)))
              (EXIT
               (COND
                ((QEQCAR |r| 0) (CONS 0 (SPADCALL (QCDR |r|) (QREFELT $ 115))))
                (#2='T
                 (SEQ (LETT |s| (|DFINTTLS;sameSign| |p| |a| |b| $))
                      (EXIT
                       (COND ((QEQCAR |s| 1) (CONS 1 "failed"))
                             ((QCDR |s|)
                              (SEQ
                               (LETT |u|
                                     (|DFINTTLS;checkDeriv|
                                      (SPADCALL |p| (QREFELT $ 117)) |a| |b|
                                      $))
                               (EXIT
                                (COND
                                 ((OR (QEQCAR |u| 1) (QCDR |u|))
                                  (CONS 1 "failed"))
                                 ('T (CONS 0 NIL))))))
                             (#2# (CONS 0 'T))))))))))) 

(SDEFUN |DFINTTLS;realRoot|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($ (|Union| (|Boolean|) "failed")))
        (SPROG ((|b| (|Union| (|Boolean|) "failed")))
               (SEQ (LETT |b| (|DFINTTLS;posRoot| |p| 'T $))
                    (EXIT
                     (COND ((QEQCAR |b| 1) (CONS 1 "failed"))
                           ((QCDR |b|) (CONS 0 'T))
                           ('T
                            (|DFINTTLS;posRoot|
                             (SPADCALL |p|
                                       (SPADCALL |p|
                                                 (SPADCALL (|spadConstant| $ 9)
                                                           1 (QREFELT $ 12))
                                                 (QREFELT $ 14))
                                       (QREFELT $ 15))
                             'T $))))))) 

(SDEFUN |DFINTTLS;sameSign|
        ((|p| (|SparseUnivariatePolynomial| F)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((|s| (|Union| (|Integer|) "failed")) (|eb| #1=(|Union| F "failed"))
          (|ea| #1#))
         (SEQ (LETT |ea| (|DFINTTLS;infeval| |p| |a| $))
              (EXIT
               (COND ((QEQCAR |ea| 1) (CONS 1 "failed"))
                     (#2='T
                      (SEQ (LETT |eb| (|DFINTTLS;infeval| |p| |b| $))
                           (EXIT
                            (COND ((QEQCAR |eb| 1) (CONS 1 "failed"))
                                  (#2#
                                   (SEQ
                                    (LETT |s|
                                          (SPADCALL
                                           (SPADCALL (QCDR |ea|) (QCDR |eb|)
                                                     (QREFELT $ 118))
                                           (QREFELT $ 64)))
                                    (EXIT
                                     (COND ((QEQCAR |s| 1) (CONS 1 "failed"))
                                           (#2#
                                            (CONS 0
                                                  (> (QCDR |s|)
                                                     0)))))))))))))))) 

(SDEFUN |DFINTTLS;posRoot|
        ((|p| (|SparseUnivariatePolynomial| F)) (|incl0?| (|Boolean|))
         ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((|v| (|Union| (|Integer|) "failed")) (#1=#:G952 NIL)
          (|z0?| (|Boolean|)))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (LETT |z0?|
                   (SPADCALL (SPADCALL |p| 0 (QREFELT $ 119)) (QREFELT $ 115)))
             (EXIT
              (COND
               (|z0?|
                (COND
                 (|incl0?| (PROGN (LETT #1# (CONS 0 'T)) (GO #2=#:G950))))))))
            (LETT |v| (|DFINTTLS;var| |p| $))
            (EXIT
             (COND ((QEQCAR |v| 1) (CONS 1 "failed"))
                   ((ODDP (QCDR |v|))
                    (COND ((OR |incl0?| (NULL |z0?|)) (CONS 0 'T))
                          ((EQL (QCDR |v|) 1) (CONS 0 NIL))
                          (#3='T (CONS 1 "failed"))))
                   ((ZEROP (QCDR |v|)) (CONS 0 NIL)) (|z0?| (CONS 0 'T))
                   (#3# (CONS 1 "failed"))))))
          #2# (EXIT #1#)))) 

(SDEFUN |DFINTTLS;infeval|
        ((|p| (|SparseUnivariatePolynomial| F)) (|a| (|OrderedCompletion| F))
         ($ (|Union| F "failed")))
        (SPROG ((|u| (|Union| (|Integer|) "failed")) (|n| (|SingleInteger|)))
               (SEQ
                (COND
                 ((|zero?_SI| (LETT |n| (SPADCALL |a| (QREFELT $ 99))))
                  (CONS 0
                        (SPADCALL |p| (SPADCALL |a| (QREFELT $ 101))
                                  (QREFELT $ 114))))
                 (#1='T
                  (SEQ (LETT |u| (SPADCALL |p| |n| (ELT $ 64) (QREFELT $ 122)))
                       (EXIT
                        (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                              (#1#
                               (CONS 0
                                     (SPADCALL (QCDR |u|)
                                               (QREFELT $ 59)))))))))))) 

(SDEFUN |DFINTTLS;var|
        ((|q| (|SparseUnivariatePolynomial| F))
         ($ (|Union| (|Integer|) "failed")))
        (SPROG
         ((|lastCoef| #1=(|Union| (|Boolean|) "failed")) (|i| (|Integer|))
          (#2=#:G976 NIL) (|next| #1#))
         (SEQ
          (EXIT
           (SEQ (LETT |i| 0)
                (LETT |lastCoef|
                      (|DFINTTLS;negative| (SPADCALL |q| (QREFELT $ 83)) $))
                (EXIT
                 (COND ((QEQCAR |lastCoef| 1) (CONS 1 "failed"))
                       ('T
                        (SEQ
                         (SEQ G190
                              (COND
                               ((NULL
                                 (SPADCALL
                                  (LETT |q| (SPADCALL |q| (QREFELT $ 89)))
                                  (|spadConstant| $ 81) (QREFELT $ 82)))
                                (GO G191)))
                              (SEQ
                               (LETT |next|
                                     (|DFINTTLS;negative|
                                      (SPADCALL |q| (QREFELT $ 83)) $))
                               (EXIT
                                (COND
                                 ((QEQCAR |next| 1)
                                  (PROGN
                                   (LETT #2# (CONS 1 "failed"))
                                   (GO #3=#:G975)))
                                 ('T
                                  (SEQ
                                   (COND
                                    ((QCDR |lastCoef|)
                                     (COND
                                      ((NULL (QCDR |next|))
                                       (COND
                                        ((QCDR |lastCoef|)
                                         (LETT |i| (+ |i| 1)))))))
                                    ((OR (QCDR |next|) (QCDR |lastCoef|))
                                     (LETT |i| (+ |i| 1))))
                                   (EXIT (LETT |lastCoef| |next|)))))))
                              NIL (GO G190) G191 (EXIT NIL))
                         (EXIT (CONS 0 |i|))))))))
          #3# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |DefiniteIntegrationTools;|)) 

(DEFUN |DefiniteIntegrationTools| (&REST #1=#:G977)
  (SPROG NIL
         (PROG (#2=#:G978)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|DefiniteIntegrationTools|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |DefiniteIntegrationTools;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|DefiniteIntegrationTools|)))))))))) 

(DEFUN |DefiniteIntegrationTools;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|DefiniteIntegrationTools| DV$1 DV$2))
          (LETT $ (GETREFV 123))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DefiniteIntegrationTools|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DefiniteIntegrationTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . |One|)
              (4 . |One|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 7) (8 . |monomial|) (14 . |coerce|)
              (19 . -) (25 . |elt|) (|Boolean|) (|Fraction| 20) (31 . >)
              (37 . <) (|Integer|) (43 . *) (|String|) |DFINTTLS;ignore?;SB;4|
              (|Symbol|) (49 . |is?|) (|OrderedCompletion| 7)
              (55 . |infinite?|) (60 . =) (66 . -) (71 . +)
              (|Union| 26 '#1="failed") (|Kernel| 7)
              |DFINTTLS;computeInt;KF2OcBU;5| (|Union| 7 '"failed")
              (77 . |retractIfCan|) (|Kernel| $) (82 . |eval|) (89 . |coerce|)
              (94 . |coerce|) (|Equation| 7) (99 . |equation|)
              (|PowerSeriesLimitPackage| 6 7) (105 . |limit|) (|Equation| 26)
              (112 . |equation|)
              (|Record| (|:| |leftHandLimit| 31) (|:| |rightHandLimit| 31))
              (|Union| 26 46 '"failed") (118 . |limit|) (|List| 36)
              (124 . |kernels|) (129 . |is?|) (|List| $) (135 . |eval|)
              (|List| 7) (142 . |argument|) (|PositiveInteger|) (147 . ^)
              (153 . |log|) (158 . |coerce|) (163 . /) (169 . -)
              (|Union| 20 '"failed") (|ElementaryFunctionSign| 6 7)
              (174 . |sign|) (179 . |Zero|) (183 . |Zero|) (|Polynomial| 6)
              (187 . |coerce|) (|SparseUnivariatePolynomial| $)
              (192 . |univariate|) (|Mapping| 7 67)
              (|SparseUnivariatePolynomial| 67)
              (|SparseUnivariatePolynomialFunctions2| 67 7) (198 . |map|)
              (|Union| 16 '#2="failed") |DFINTTLS;checkForZero;Sup2OcBU;11|
              |DFINTTLS;checkForZero;PS2OcBU;10| (204 . |ground?|)
              (|SparseUnivariatePolynomial| 17) (209 . |Zero|) (213 . |Zero|)
              (217 . ~=) (223 . |leadingCoefficient|) (|Union| 17 '"failed")
              (228 . |retractIfCan|) (233 . |degree|) (238 . |monomial|)
              (244 . +) (250 . |reductum|) (255 . |numer|)
              (|Record| (|:| |num| 79) (|:| |den| 20))
              (|UnivariatePolynomialCommonDenominator| 20 17 79)
              (260 . |splitDenominator|) (|SparseUnivariatePolynomial| 20)
              (|Mapping| 20 17) (|SparseUnivariatePolynomialFunctions2| 17 20)
              (265 . |map|) (|SingleInteger|) (271 . |whatInfinity|) (276 . ~=)
              (282 . |retract|) (287 . |squareFreePart|)
              (|Record| (|:| |left| 17) (|:| |right| 17)) (|List| 103)
              (|RealZeroPackage| 94) (292 . |realZeros|) (|Mapping| 16 103)
              (298 . |select!|) (304 . |realZeros|) (309 . |max|) (315 . |min|)
              (|Union| 103 '"failed") (321 . |refine|) (328 . |elt|)
              (334 . |zero?|) (339 . |retractIfCan|) (344 . |differentiate|)
              (349 . *) (355 . |coefficient|) (|Mapping| 62 7)
              (|InnerPolySign| 7 11) (361 . |signAround|))
           '#(|ignore?| 368 |computeInt| 373 |checkForZero| 382) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|ignore?| ((|Boolean|) (|String|))) T)
                                   '((|computeInt|
                                      ((|Union| (|OrderedCompletion| |#2|) #1#)
                                       (|Kernel| |#2|) |#2|
                                       (|OrderedCompletion| |#2|)
                                       (|OrderedCompletion| |#2|) (|Boolean|)))
                                     T)
                                   '((|checkForZero|
                                      ((|Union| (|Boolean|) "failed")
                                       (|Polynomial| |#1|) (|Symbol|)
                                       (|OrderedCompletion| |#2|)
                                       (|OrderedCompletion| |#2|) (|Boolean|)))
                                     T)
                                   '((|checkForZero|
                                      ((|Union| (|Boolean|) #2#)
                                       (|SparseUnivariatePolynomial| |#2|)
                                       (|OrderedCompletion| |#2|)
                                       (|OrderedCompletion| |#2|) (|Boolean|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 122
                                            '(0 6 0 8 0 7 0 9 2 11 0 7 10 12 1
                                              11 0 7 13 2 11 0 0 0 14 2 11 0 0
                                              0 15 2 17 16 0 0 18 2 17 16 0 0
                                              19 2 11 0 20 0 21 2 7 16 0 24 25
                                              1 26 16 0 27 2 26 16 0 0 28 1 26
                                              0 0 29 2 26 0 0 0 30 1 26 34 0 35
                                              3 7 0 0 36 0 37 1 26 0 7 38 1 7 0
                                              36 39 2 40 0 7 7 41 3 42 31 7 40
                                              22 43 2 44 0 26 26 45 2 42 47 7
                                              44 48 1 7 49 0 50 2 32 16 0 24 51
                                              3 7 0 0 49 52 53 1 32 54 0 55 2 7
                                              0 0 56 57 1 7 0 0 58 1 7 0 20 59
                                              2 7 0 0 0 60 1 7 0 0 61 1 63 62 7
                                              64 0 6 0 65 0 7 0 66 1 7 0 67 68
                                              2 67 69 0 24 70 2 73 11 71 72 74
                                              1 11 16 0 78 0 79 0 80 0 11 0 81
                                              2 11 16 0 0 82 1 11 7 0 83 1 7 84
                                              0 85 1 11 10 0 86 2 79 0 17 10 87
                                              2 79 0 0 0 88 1 11 0 0 89 1 17 20
                                              0 90 1 92 91 79 93 2 96 94 95 79
                                              97 1 26 98 0 99 2 98 16 0 0 100 1
                                              26 7 0 101 1 94 0 0 102 2 105 104
                                              94 103 106 2 104 0 107 0 108 1
                                              105 104 94 109 2 17 0 0 0 110 2
                                              17 0 0 0 111 3 105 112 94 103 103
                                              113 2 11 7 0 7 114 1 7 16 0 115 1
                                              11 34 0 116 1 11 0 0 117 2 7 0 0
                                              0 118 2 11 7 0 10 119 3 121 62 11
                                              20 120 122 1 0 16 22 23 5 0 31 32
                                              7 26 26 16 33 4 0 75 11 26 26 16
                                              76 5 0 75 67 24 26 26 16 77)))))
           '|lookupComplete|)) 


(SDEFUN |IDECOMP;convertQF|
        ((|a| (|Fraction| (|Integer|)))
         ($ (|Fraction| (|Polynomial| (|Integer|)))))
        (SPADCALL (SPADCALL (SPADCALL |a| (QREFELT $ 9)) (QREFELT $ 11))
                  (SPADCALL (SPADCALL |a| (QREFELT $ 12)) (QREFELT $ 11))
                  (QREFELT $ 13))) 

(SDEFUN |IDECOMP;convertFQ|
        ((|a| (|Fraction| (|Polynomial| (|Integer|))))
         ($ (|Fraction| (|Integer|))))
        (SPADCALL (SPADCALL (SPADCALL |a| (QREFELT $ 15)) (QREFELT $ 16))
                  (SPADCALL (SPADCALL |a| (QREFELT $ 17)) (QREFELT $ 16))
                  (QREFELT $ 18))) 

(SDEFUN |IDECOMP;internalForm|
        ((I
          (|PolynomialIdeal| (|Fraction| (|Integer|))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Integer|)))))
         ($
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|)))))))
        (SPROG
         ((|nId|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|))))))
          (#1=#:G749 NIL) (|poly| NIL) (#2=#:G748 NIL)
          (|Id|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction| (|Integer|))))))
         (SEQ (LETT |Id| (SPADCALL I (QREFELT $ 21)))
              (LETT |nId|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |poly| NIL) (LETT #1# |Id|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |poly| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL
                                    (CONS (|function| |IDECOMP;convertQF|) $)
                                    |poly| (QREFELT $ 26))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (COND
                ((SPADCALL I (QREFELT $ 28)) (SPADCALL |nId| (QREFELT $ 31)))
                ('T (SPADCALL |nId| (QREFELT $ 32)))))))) 

(SDEFUN |IDECOMP;externalForm|
        ((I
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         ($
          (|PolynomialIdeal| (|Fraction| (|Integer|))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Integer|))))))
        (SPROG
         ((|nId|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction| (|Integer|)))))
          (#1=#:G756 NIL) (|poly| NIL) (#2=#:G755 NIL)
          (|Id|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|)))))))
         (SEQ (LETT |Id| (SPADCALL I (QREFELT $ 33)))
              (LETT |nId|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |poly| NIL) (LETT #1# |Id|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |poly| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL
                                    (CONS (|function| |IDECOMP;convertFQ|) $)
                                    |poly| (QREFELT $ 36))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (COND
                ((SPADCALL I (QREFELT $ 37)) (SPADCALL |nId| (QREFELT $ 38)))
                ('T (SPADCALL |nId| (QREFELT $ 39)))))))) 

(SDEFUN |IDECOMP;deleteunit|
        ((|lI|
          (|List|
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|)))))))
         ($
          (|List|
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|))))))))
        (SPROG ((#1=#:G768 NIL) (I NIL) (#2=#:G767 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT I NIL) (LETT #1# |lI|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT I (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((NULL
                           (SPADCALL (|spadConstant| $ 47) I (QREFELT $ 48)))
                          (LETT #2# (CONS I #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |IDECOMP;rearrange|
        ((|vlist| (|List| (|OrderedVariableList| |vl|)))
         ($ (|List| (|OrderedVariableList| |vl|))))
        (COND ((SPADCALL |vlist| NIL (QREFELT $ 50)) |vlist|)
              ('T
               (SPADCALL (ELT $ 51)
                         (SPADCALL (QREFELT $ 44)
                                   (SPADCALL (QREFELT $ 44) |vlist|
                                             (QREFELT $ 52))
                                   (QREFELT $ 52))
                         (QREFELT $ 54))))) 

(SDEFUN |IDECOMP;zeroRadComp|
        ((I
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         (|truelist| (|List| (|OrderedVariableList| |vl|)))
         ($
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|)))))))
        (SPROG
         ((|ris|
           #1=(|List|
               (|DistributedMultivariatePolynomial| |vl|
                                                    (|Fraction|
                                                     (|Polynomial|
                                                      (|Integer|))))))
          (#2=#:G800 NIL) (|h| NIL) (#3=#:G799 NIL)
          (|lf|
           #4=(|DistributedMultivariatePolynomial| |vl|
                                                   (|Fraction|
                                                    (|Polynomial|
                                                     (|Integer|)))))
          (|Id| #1#) (#5=#:G798 NIL) (#6=#:G797 NIL)
          (|pw|
           #7=(|DistributedMultivariatePolynomial| |vl|
                                                   (|Fraction|
                                                    (|Polynomial|
                                                     (|Integer|)))))
          (|pv| #7#) (|val| (|Integer|))
          (|g|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (#8=#:G781 NIL) (|f| #4#)
          (|py|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (|px|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (|y| (|OrderedVariableList| |vl|))
          (|x| (|OrderedVariableList| |vl|)))
         (SEQ
          (COND ((SPADCALL |truelist| NIL (QREFELT $ 50)) I)
                (#9='T
                 (SEQ (LETT |Id| (SPADCALL I (QREFELT $ 33)))
                      (LETT |x| (SPADCALL |truelist| '|last| (QREFELT $ 56)))
                      (EXIT
                       (COND
                        ((EQL (LENGTH |Id|) 1)
                         (SEQ (LETT |f| (|SPADfirst| |Id|))
                              (LETT |g|
                                    (PROG2
                                        (LETT #8#
                                              (SPADCALL |f|
                                                        (SPADCALL |f|
                                                                  (SPADCALL |f|
                                                                            |x|
                                                                            (QREFELT
                                                                             $
                                                                             57))
                                                                  (QREFELT $
                                                                           58))
                                                        (QREFELT $ 59)))
                                        (QCDR #8#)
                                      (|check_union2| (QEQCAR #8# 0)
                                                      (|DistributedMultivariatePolynomial|
                                                       (QREFELT $ 6)
                                                       (|Fraction|
                                                        (|Polynomial|
                                                         (|Integer|))))
                                                      (|Union|
                                                       (|DistributedMultivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Fraction|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                       #10="failed")
                                                      #8#)))
                              (EXIT (SPADCALL (LIST |g|) (QREFELT $ 31)))))
                        (#9#
                         (SEQ (LETT |y| (|SPADfirst| |truelist|))
                              (LETT |px| (SPADCALL |x| (QREFELT $ 60)))
                              (LETT |py| (SPADCALL |y| (QREFELT $ 60)))
                              (LETT |f| (SPADCALL |Id| '|last| (QREFELT $ 61)))
                              (LETT |g|
                                    (PROG2
                                        (LETT #8#
                                              (SPADCALL |f|
                                                        (SPADCALL |f|
                                                                  (SPADCALL |f|
                                                                            |x|
                                                                            (QREFELT
                                                                             $
                                                                             57))
                                                                  (QREFELT $
                                                                           58))
                                                        (QREFELT $ 59)))
                                        (QCDR #8#)
                                      (|check_union2| (QEQCAR #8# 0)
                                                      (|DistributedMultivariatePolynomial|
                                                       (QREFELT $ 6)
                                                       (|Fraction|
                                                        (|Polynomial|
                                                         (|Integer|))))
                                                      (|Union|
                                                       (|DistributedMultivariatePolynomial|
                                                        (QREFELT $ 6)
                                                        (|Fraction|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                       #10#)
                                                      #8#)))
                              (LETT |Id|
                                    (SPADCALL
                                     (CONS |g|
                                           (SPADCALL |f| |Id| (QREFELT $ 62)))
                                     (QREFELT $ 64)))
                              (LETT |lf| (|SPADfirst| |Id|))
                              (LETT |pv| (|spadConstant| $ 65))
                              (LETT |pw| (|spadConstant| $ 65))
                              (SEQ G190
                                   (COND
                                    ((NULL
                                      (SPADCALL
                                       (SPADCALL |lf| |y| (QREFELT $ 67)) 1
                                       (QREFELT $ 68)))
                                     (GO G191)))
                                   (SEQ (LETT |val| (RANDOM 23))
                                        (LETT |pv|
                                              (SPADCALL |px|
                                                        (SPADCALL |val| |py|
                                                                  (QREFELT $
                                                                           69))
                                                        (QREFELT $ 70)))
                                        (LETT |pw|
                                              (SPADCALL |px|
                                                        (SPADCALL |val| |py|
                                                                  (QREFELT $
                                                                           69))
                                                        (QREFELT $ 71)))
                                        (LETT |Id|
                                              (SPADCALL
                                               (PROGN
                                                (LETT #6# NIL)
                                                (SEQ (LETT |h| NIL)
                                                     (LETT #5# |Id|) G190
                                                     (COND
                                                      ((OR (ATOM #5#)
                                                           (PROGN
                                                            (LETT |h|
                                                                  (CAR #5#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #6#
                                                             (CONS
                                                              (SPADCALL
                                                               (SPADCALL |h|
                                                                         |x|
                                                                         (QREFELT
                                                                          $
                                                                          73))
                                                               |pv|
                                                               (QREFELT $ 75))
                                                              #6#))))
                                                     (LETT #5# (CDR #5#))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #6#))))
                                               (QREFELT $ 64)))
                                        (EXIT (LETT |lf| (|SPADfirst| |Id|))))
                                   NIL (GO G190) G191 (EXIT NIL))
                              (LETT |ris|
                                    (SPADCALL
                                     (|IDECOMP;zeroRadComp|
                                      (SPADCALL (CDR |Id|) (QREFELT $ 31))
                                      (CDR |truelist|) $)
                                     (QREFELT $ 33)))
                              (LETT |ris| (CONS |lf| |ris|))
                              (COND
                               ((SPADCALL |pv| (|spadConstant| $ 65)
                                          (QREFELT $ 78))
                                (LETT |ris|
                                      (PROGN
                                       (LETT #3# NIL)
                                       (SEQ (LETT |h| NIL) (LETT #2# |ris|)
                                            G190
                                            (COND
                                             ((OR (ATOM #2#)
                                                  (PROGN
                                                   (LETT |h| (CAR #2#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #3#
                                                    (CONS
                                                     (SPADCALL
                                                      (SPADCALL |h| |x|
                                                                (QREFELT $ 73))
                                                      |pw| (QREFELT $ 75))
                                                     #3#))))
                                            (LETT #2# (CDR #2#)) (GO G190) G191
                                            (EXIT (NREVERSE #3#)))))))
                              (EXIT
                               (SPADCALL (SPADCALL |ris| (QREFELT $ 64))
                                         (QREFELT $ 31))))))))))))) 

(SDEFUN |IDECOMP;goodPower|
        ((|s|
          #1=(|DistributedMultivariatePolynomial| |vl|
                                                  (|Fraction|
                                                   (|Polynomial|
                                                    (|Integer|)))))
         (I
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         ($
          (|Record|
           (|:| |spol|
                (|DistributedMultivariatePolynomial| |vl|
                                                     (|Fraction|
                                                      (|Polynomial|
                                                       (|Integer|)))))
           (|:| |id|
                (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                                   (|DirectProduct| (|#| |vl|)
                                                    (|NonNegativeInteger|))
                                   (|OrderedVariableList| |vl|)
                                   (|DistributedMultivariatePolynomial| |vl|
                                                                        (|Fraction|
                                                                         (|Polynomial|
                                                                          (|Integer|)))))))))
        (SPROG
         ((|f| #1#) (#2=#:G810 NIL) (|g| NIL) (#3=#:G809 NIL)
          (J
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|))))))
          (JJ
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|)))))))
         (SEQ (LETT |f| |s|) (LETT I (SPADCALL I (QREFELT $ 79)))
              (LETT J
                    (SPADCALL (LETT JJ (SPADCALL I |s| (QREFELT $ 80)))
                              (QREFELT $ 33)))
              (SEQ G190
                   (COND
                    ((NULL
                      (NULL
                       (SPADCALL
                        (SPADCALL
                         (PROGN
                          (LETT #3# NIL)
                          (SEQ (LETT |g| NIL) (LETT #2# J) G190
                               (COND
                                ((OR (ATOM #2#)
                                     (PROGN (LETT |g| (CAR #2#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #3#
                                       (CONS (SPADCALL |f| |g| (QREFELT $ 81))
                                             #3#))))
                               (LETT #2# (CDR #2#)) (GO G190) G191
                               (EXIT (NREVERSE #3#))))
                         (QREFELT $ 32))
                        I (QREFELT $ 82))))
                     (GO G191)))
                   (SEQ (EXIT (LETT |f| (SPADCALL |s| |f| (QREFELT $ 81)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |f| JJ))))) 

(SDEFUN |IDECOMP;zerodimcase|
        ((J
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         (|truelist| (|List| (|OrderedVariableList| |vl|))) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G824 NIL)
          (|Jd|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|))))))
          (#2=#:G759 NIL) (|y| (|Union| (|OrderedVariableList| |vl|) "failed"))
          (|f|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (#3=#:G825 NIL) (|x| NIL) (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL (|spadConstant| $ 47) J (QREFELT $ 48))
                 (SPADCALL |truelist| NIL (QREFELT $ 50)))
             'T)
            ('T
             (SEQ (LETT |n| (LENGTH |truelist|))
                  (LETT |Jd|
                        (SPADCALL (SPADCALL J (QREFELT $ 33)) (QREFELT $ 64)))
                  (SEQ (LETT |x| NIL) (LETT #3# |truelist|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL)
                             (NULL (SPADCALL |Jd| NIL (QREFELT $ 84))))
                         (GO G191)))
                       (SEQ (LETT |f| (|SPADfirst| |Jd|))
                            (LETT |Jd| (CDR |Jd|))
                            (SEQ (LETT |y| (SPADCALL |f| (QREFELT $ 86)))
                                 (EXIT
                                  (COND
                                   ((OR (QEQCAR |y| 1)
                                        (OR
                                         (SPADCALL (QCDR |y|) |x|
                                                   (QREFELT $ 87))
                                         (NULL (|IDECOMP;ismonic| |f| |x| $))))
                                    (PROGN (LETT #1# NIL) (GO #4=#:G823))))))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND
                                     ((SPADCALL |Jd| NIL (QREFELT $ 84))
                                      (SPADCALL
                                       (PROG2
                                           (LETT #2#
                                                 (SPADCALL (|SPADfirst| |Jd|)
                                                           (QREFELT $ 86)))
                                           (QCDR #2#)
                                         (|check_union2| (QEQCAR #2# 0)
                                                         (|OrderedVariableList|
                                                          (QREFELT $ 6))
                                                         (|Union|
                                                          (|OrderedVariableList|
                                                           (QREFELT $ 6))
                                                          "failed")
                                                         #2#))
                                       |x| (QREFELT $ 88)))
                                     ('T NIL)))
                                   (GO G191)))
                                 (SEQ (EXIT (LETT |Jd| (CDR |Jd|)))) NIL
                                 (GO G190) G191 (EXIT NIL))
                            (EXIT
                             (COND
                              ((SPADCALL |Jd| NIL (QREFELT $ 89))
                               (COND
                                ((< (SPADCALL |x| |truelist| (QREFELT $ 90))
                                    |n|)
                                 (PROGN (LETT #1# NIL) (GO #4#))))))))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))))
          #4# (EXIT #1#)))) 

(SDEFUN |IDECOMP;findvar|
        ((J
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         (|truelist| (|List| (|OrderedVariableList| |vl|)))
         ($ (|OrderedVariableList| |vl|)))
        (SPROG
         ((|badvar| (|List| (|OrderedVariableList| |vl|)))
          (|lmonicvar| (|List| (|OrderedVariableList| |vl|)))
          (|vt| (|List| (|OrderedVariableList| |vl|)))
          (|t|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (#1=#:G831 NIL) (|f| NIL))
         (SEQ (LETT |lmonicvar| NIL)
              (SEQ (LETT |f| NIL) (LETT #1# (SPADCALL J (QREFELT $ 33))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |t|
                          (SPADCALL |f| (SPADCALL |f| (QREFELT $ 91))
                                    (QREFELT $ 71)))
                    (LETT |vt| (SPADCALL |t| (QREFELT $ 92)))
                    (EXIT
                     (COND
                      ((EQL (LENGTH |vt|) 1)
                       (LETT |lmonicvar|
                             (SPADCALL |vt| |lmonicvar| (QREFELT $ 93)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |badvar| (SPADCALL |truelist| |lmonicvar| (QREFELT $ 52)))
              (EXIT (|SPADfirst| |badvar|))))) 

(SDEFUN |IDECOMP;reduceDim|
        ((|flag| (|Union| "zeroPrimDecomp" "zeroRadComp"))
         (J
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         (|truelist| (|List| (|OrderedVariableList| |vl|)))
         ($
          #1=(|List|
              (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                                 (|DirectProduct| (|#| |vl|)
                                                  (|NonNegativeInteger|))
                                 (|OrderedVariableList| |vl|)
                                 (|DistributedMultivariatePolynomial| |vl|
                                                                      (|Fraction|
                                                                       (|Polynomial|
                                                                        (|Integer|))))))))
        (SPROG
         ((|res1|
           (|List|
            (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                               (|DirectProduct| (|#| |vl|)
                                                (|NonNegativeInteger|))
                               (|OrderedVariableList| |vl|)
                               (|DistributedMultivariatePolynomial| |vl|
                                                                    (|Fraction|
                                                                     (|Polynomial|
                                                                      (|Integer|)))))))
          (#2=#:G867 NIL) (JJ NIL) (|sresult| #1#)
          (|sideal|
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|))))))
          (|good|
           (|Record|
            (|:| |spol|
                 (|DistributedMultivariatePolynomial| |vl|
                                                      (|Fraction|
                                                       (|Polynomial|
                                                        (|Integer|)))))
            (|:| |id|
                 (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                                    (|DirectProduct| (|#| |vl|)
                                                     (|NonNegativeInteger|))
                                    (|OrderedVariableList| |vl|)
                                    (|DistributedMultivariatePolynomial| |vl|
                                                                         (|Fraction|
                                                                          (|Polynomial|
                                                                           (|Integer|))))))))
          (#3=#:G866 NIL) (II NIL) (#4=#:G865 NIL)
          (|s|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (#5=#:G845 NIL)
          (#6=#:G844 #7=(|Fraction| (|Polynomial| (|Integer|))))
          (#8=#:G846 #7#) (#9=#:G864 NIL) (|f| NIL) (#10=#:G863 NIL)
          (#11=#:G862 NIL) (#12=#:G861 NIL) (|idp| NIL) (#13=#:G860 NIL)
          (|Jc|
           (|List|
            (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                               (|DirectProduct| (|#| |vl|)
                                                (|NonNegativeInteger|))
                               (|OrderedVariableList| |vl|)
                               (|DistributedMultivariatePolynomial| |vl|
                                                                    (|Fraction|
                                                                     (|Polynomial|
                                                                      (|Integer|)))))))
          (|Jnew|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|))))))
          (#14=#:G859 NIL) (#15=#:G858 NIL) (|x| (|OrderedVariableList| |vl|)))
         (SEQ
          (COND ((SPADCALL (|spadConstant| $ 47) J (QREFELT $ 48)) (LIST J))
                ((|IDECOMP;zerodimcase| J |truelist| $)
                 (COND
                  ((QEQCAR |flag| 0) (|IDECOMP;zeroPrimDecomp| J |truelist| $))
                  ((QEQCAR |flag| 1)
                   (LIST (|IDECOMP;zeroRadComp| J |truelist| $)))))
                (#16='T
                 (SEQ (LETT |x| (|IDECOMP;findvar| J |truelist| $))
                      (LETT |Jnew|
                            (PROGN
                             (LETT #15# NIL)
                             (SEQ (LETT |f| NIL)
                                  (LETT #14# (SPADCALL J (QREFELT $ 33))) G190
                                  (COND
                                   ((OR (ATOM #14#)
                                        (PROGN (LETT |f| (CAR #14#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #15#
                                          (CONS (|IDECOMP;pushdown| |f| |x| $)
                                                #15#))))
                                  (LETT #14# (CDR #14#)) (GO G190) G191
                                  (EXIT (NREVERSE #15#)))))
                      (LETT |Jc| NIL)
                      (LETT |Jc|
                            (|IDECOMP;reduceDim| |flag|
                             (SPADCALL |Jnew| (QREFELT $ 31))
                             (SPADCALL |x| |truelist| (QREFELT $ 94)) $))
                      (LETT |res1|
                            (PROGN
                             (LETT #13# NIL)
                             (SEQ (LETT |idp| NIL) (LETT #12# |Jc|) G190
                                  (COND
                                   ((OR (ATOM #12#)
                                        (PROGN (LETT |idp| (CAR #12#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #13#
                                          (CONS
                                           (SPADCALL
                                            (PROGN
                                             (LETT #11# NIL)
                                             (SEQ (LETT |f| NIL)
                                                  (LETT #10#
                                                        (SPADCALL |idp|
                                                                  (QREFELT $
                                                                           33)))
                                                  G190
                                                  (COND
                                                   ((OR (ATOM #10#)
                                                        (PROGN
                                                         (LETT |f| (CAR #10#))
                                                         NIL))
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT #11#
                                                          (CONS
                                                           (|IDECOMP;pushup|
                                                            |f| |x| $)
                                                           #11#))))
                                                  (LETT #10# (CDR #10#))
                                                  (GO G190) G191
                                                  (EXIT (NREVERSE #11#))))
                                            (QREFELT $ 32))
                                           #13#))))
                                  (LETT #12# (CDR #12#)) (GO G190) G191
                                  (EXIT (NREVERSE #13#)))))
                      (LETT |s|
                            (|IDECOMP;pushup|
                             (SPADCALL
                              (PROGN
                               (LETT #5# NIL)
                               (SEQ (LETT |f| NIL) (LETT #9# |Jnew|) G190
                                    (COND
                                     ((OR (ATOM #9#)
                                          (PROGN (LETT |f| (CAR #9#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #8# (SPADCALL |f| (QREFELT $ 95)))
                                       (COND
                                        (#5#
                                         (LETT #6#
                                               (SPADCALL #6# #8#
                                                         (QREFELT $ 96))))
                                        ('T
                                         (PROGN
                                          (LETT #6# #8#)
                                          (LETT #5# 'T)))))))
                                    (LETT #9# (CDR #9#)) (GO G190) G191
                                    (EXIT NIL))
                               (COND (#5# #6#) (#16# (|spadConstant| $ 45))))
                              (QREFELT $ 97))
                             |x| $))
                      (EXIT
                       (COND ((EQL (SPADCALL |s| |x| (QREFELT $ 67)) 0) |res1|)
                             (#16#
                              (SEQ
                               (LETT |res1|
                                     (PROGN
                                      (LETT #4# NIL)
                                      (SEQ (LETT II NIL) (LETT #3# |res1|) G190
                                           (COND
                                            ((OR (ATOM #3#)
                                                 (PROGN
                                                  (LETT II (CAR #3#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #4#
                                                   (CONS
                                                    (SPADCALL II |s|
                                                              (QREFELT $ 80))
                                                    #4#))))
                                           (LETT #3# (CDR #3#)) (GO G190) G191
                                           (EXIT (NREVERSE #4#)))))
                               (LETT |good| (|IDECOMP;goodPower| |s| J $))
                               (LETT |sideal|
                                     (SPADCALL
                                      (SPADCALL
                                       (CONS (QCAR |good|)
                                             (SPADCALL J (QREFELT $ 33)))
                                       (QREFELT $ 64))
                                      (QREFELT $ 31)))
                               (EXIT
                                (COND
                                 ((SPADCALL (QCDR |good|) |sideal|
                                            (QREFELT $ 82))
                                  |res1|)
                                 (#16#
                                  (SEQ
                                   (LETT |sresult|
                                         (|IDECOMP;reduceDim| |flag| |sideal|
                                          |truelist| $))
                                   (SEQ (LETT JJ NIL) (LETT #2# |sresult|) G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN (LETT JJ (CAR #2#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((NULL
                                             (SPADCALL (QCDR |good|) JJ
                                                       (QREFELT $ 82)))
                                            (LETT |res1| (CONS JJ |res1|))))))
                                        (LETT #2# (CDR #2#)) (GO G190) G191
                                        (EXIT NIL))
                                   (EXIT |res1|))))))))))))))) 

(SDEFUN |IDECOMP;zeroPrimDecomp|
        ((I
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         (|truelist| (|List| (|OrderedVariableList| |vl|)))
         ($
          (|List|
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|))))))))
        (SPROG
         ((|ris|
           (|List|
            (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                               (|DirectProduct| (|#| |vl|)
                                                (|NonNegativeInteger|))
                               (|OrderedVariableList| |vl|)
                               (|DistributedMultivariatePolynomial| |vl|
                                                                    (|Fraction|
                                                                     (|Polynomial|
                                                                      (|Integer|)))))))
          (#1=#:G885 NIL)
          (J1
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|))))))
          (|g|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (#2=#:G886 NIL) (|ef| NIL)
          (|lfact|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor|
                           (|DistributedMultivariatePolynomial| |vl|
                                                                (|Fraction|
                                                                 (|Polynomial|
                                                                  (|Integer|)))))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|Jd|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|))))))
          (J
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|))))))
          (|lval| #3=(|List| (|Integer|)))
          (|newJ|
           (|Record| (|:| |changeval| #3#)
                     (|:| |genideal|
                          (|PolynomialIdeal|
                           (|Fraction| (|Polynomial| (|Integer|)))
                           (|DirectProduct| (|#| |vl|) (|NonNegativeInteger|))
                           (|OrderedVariableList| |vl|)
                           (|DistributedMultivariatePolynomial| |vl|
                                                                (|Fraction|
                                                                 (|Polynomial|
                                                                  (|Integer|)))))))))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |truelist| NIL (QREFELT $ 50))
             (SPADCALL I (QREFELT $ 99)))
            ('T
             (SEQ (LETT |newJ| (|IDECOMP;genPosLastVar| I |truelist| $))
                  (LETT |lval| (QCAR |newJ|))
                  (LETT J (SPADCALL (QCDR |newJ|) (QREFELT $ 79)))
                  (LETT |Jd| (SPADCALL J (QREFELT $ 33)))
                  (LETT |g| (SPADCALL |Jd| '|last| (QREFELT $ 61)))
                  (LETT |lfact|
                        (SPADCALL (SPADCALL |g| (QREFELT $ 102))
                                  (QREFELT $ 106)))
                  (LETT |ris| NIL)
                  (SEQ (LETT |ef| NIL) (LETT #2# |lfact|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |ef| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |g|
                              (SPADCALL (QVELT |ef| 1) (QVELT |ef| 2)
                                        (QREFELT $ 107)))
                        (LETT J1
                              (SPADCALL
                               (SPADCALL (CONS |g| |Jd|) (QREFELT $ 64))
                               (QREFELT $ 31)))
                        (COND
                         ((NULL (|IDECOMP;is0dimprimary| J1 |truelist| $))
                          (PROGN
                           (LETT #1# (|IDECOMP;zeroPrimDecomp| I |truelist| $))
                           (GO #4=#:G884))))
                        (EXIT
                         (LETT |ris|
                               (CONS
                                (SPADCALL
                                 (|IDECOMP;backGenPos| J1 |lval| |truelist| $)
                                 (QREFELT $ 79))
                                |ris|))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT |ris|)))))
          #4# (EXIT #1#)))) 

(SDEFUN |IDECOMP;radical;2Pi;13|
        ((I
          (|PolynomialIdeal| (|Fraction| (|Integer|))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Integer|)))))
         ($
          (|PolynomialIdeal| (|Fraction| (|Integer|))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Integer|))))))
        (SPROG
         ((#1=#:G894 NIL)
          (#2=#:G893
           #3=(|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                                 (|DirectProduct| (|#| |vl|)
                                                  (|NonNegativeInteger|))
                                 (|OrderedVariableList| |vl|)
                                 (|DistributedMultivariatePolynomial| |vl|
                                                                      (|Fraction|
                                                                       (|Polynomial|
                                                                        (|Integer|))))))
          (#4=#:G895 #3#) (#5=#:G899 NIL) (#6=#:G689 NIL)
          (|truelist| (|List| (|OrderedVariableList| |vl|))) (#7=#:G888 NIL)
          (#8=#:G887 #9=(|List| (|OrderedVariableList| |vl|))) (#10=#:G889 #9#)
          (#11=#:G898 NIL) (|f| NIL)
          (J
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|)))))))
         (SEQ (LETT J (SPADCALL (|IDECOMP;internalForm| I $) (QREFELT $ 79)))
              (LETT |truelist|
                    (|IDECOMP;rearrange|
                     (PROGN
                      (LETT #7# NIL)
                      (SEQ (LETT |f| NIL)
                           (LETT #11# (SPADCALL J (QREFELT $ 33))) G190
                           (COND
                            ((OR (ATOM #11#) (PROGN (LETT |f| (CAR #11#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (PROGN
                              (LETT #10# (SPADCALL |f| (QREFELT $ 92)))
                              (COND
                               (#7#
                                (LETT #8# (SPADCALL #8# #10# (QREFELT $ 93))))
                               ('T (PROGN (LETT #8# #10#) (LETT #7# 'T)))))))
                           (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                      (COND (#7# #8#) (#12='T (|IdentityError| '|setUnion|))))
                     $))
              (EXIT
               (COND
                ((SPADCALL |truelist| NIL (QREFELT $ 50))
                 (|IDECOMP;externalForm| J $))
                (#12#
                 (|IDECOMP;externalForm|
                  (PROGN
                   (LETT #1# NIL)
                   (SEQ (LETT #6# NIL)
                        (LETT #5#
                              (|IDECOMP;reduceDim| (CONS 1 "zeroRadComp") J
                               |truelist| $))
                        G190
                        (COND
                         ((OR (ATOM #5#) (PROGN (LETT #6# (CAR #5#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (PROGN
                           (LETT #4# #6#)
                           (COND
                            (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 108))))
                            ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                        (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                   (COND (#1# #2#) (#12# (|IdentityError| '|intersect|))))
                  $))))))) 

(SDEFUN |IDECOMP;pushdown|
        ((|g|
          (|DistributedMultivariatePolynomial| |vl|
                                               (|Fraction|
                                                (|Polynomial| (|Integer|)))))
         (|x| (|OrderedVariableList| |vl|))
         ($
          (|DistributedMultivariatePolynomial| |vl|
                                               (|Fraction|
                                                (|Polynomial| (|Integer|))))))
        (SPROG
         ((|rf|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (|g1|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (|i| (|Integer|)))
         (SEQ (LETT |rf| (|spadConstant| $ 65))
              (LETT |i| (SPADCALL |x| (QREFELT $ 44) (QREFELT $ 90)))
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |g| (|spadConstant| $ 65) (QREFELT $ 78)))
                     (GO G191)))
                   (SEQ (LETT |g1| (SPADCALL |g| (QREFELT $ 91)))
                        (LETT |rf|
                              (SPADCALL |rf|
                                        (|IDECOMP;pushdterm|
                                         (SPADCALL |g| |g1| (QREFELT $ 71)) |x|
                                         |i| $)
                                        (QREFELT $ 70)))
                        (EXIT (LETT |g| |g1|)))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |rf|)))) 

(SDEFUN |IDECOMP;pushdterm|
        ((|t|
          (|DistributedMultivariatePolynomial| |vl|
                                               (|Fraction|
                                                (|Polynomial| (|Integer|)))))
         (|x| (|OrderedVariableList| |vl|)) (|i| (|Integer|))
         ($
          (|DistributedMultivariatePolynomial| |vl|
                                               (|Fraction|
                                                (|Polynomial| (|Integer|))))))
        (SPROG
         ((#1=#:G906 NIL)
          (|newt|
           (|Union|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial| (|Integer|))))
            #2="failed"))
          (|cf| (|Fraction| (|Polynomial| (|Integer|)))) (|xp| (|Symbol|))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |t| |x| (QREFELT $ 67)))
              (LETT |xp| (SPADCALL |x| (QREFELT $ 110)))
              (LETT |cf|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 111) |xp| |n| (QREFELT $ 112))
                     (QREFELT $ 113)))
              (LETT |newt|
                    (SPADCALL |t|
                              (SPADCALL (|spadConstant| $ 47) |x| |n|
                                        (QREFELT $ 114))
                              (QREFELT $ 59)))
              (EXIT
               (SPADCALL |cf|
                         (PROG2 (LETT #1# |newt|)
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0)
                                           (|DistributedMultivariatePolynomial|
                                            (QREFELT $ 6)
                                            (|Fraction|
                                             (|Polynomial| (|Integer|))))
                                           (|Union|
                                            (|DistributedMultivariatePolynomial|
                                             (QREFELT $ 6)
                                             (|Fraction|
                                              (|Polynomial| (|Integer|))))
                                            #2#)
                                           #1#))
                         (QREFELT $ 115)))))) 

(SDEFUN |IDECOMP;pushup|
        ((|f|
          #1=(|DistributedMultivariatePolynomial| |vl|
                                                  (|Fraction|
                                                   (|Polynomial|
                                                    (|Integer|)))))
         (|x| (|OrderedVariableList| |vl|))
         ($
          (|DistributedMultivariatePolynomial| |vl|
                                               (|Fraction|
                                                (|Polynomial| (|Integer|))))))
        (SPROG
         ((|rf|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (|g| #1#) (|h| (|Polynomial| (|Integer|))) (|xp| (|Symbol|)))
         (SEQ (LETT |h| (|spadConstant| $ 111))
              (LETT |rf| (|spadConstant| $ 65)) (LETT |g| |f|)
              (LETT |xp| (SPADCALL |x| (QREFELT $ 110)))
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |g| (|spadConstant| $ 65) (QREFELT $ 78)))
                     (GO G191)))
                   (SEQ
                    (LETT |h|
                          (SPADCALL
                           (|IDECOMP;trueden|
                            (SPADCALL (SPADCALL |g| (QREFELT $ 95))
                                      (QREFELT $ 17))
                            |xp| $)
                           |h| (QREFELT $ 116)))
                    (EXIT (LETT |g| (SPADCALL |g| (QREFELT $ 91)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |f|
                    (SPADCALL (SPADCALL |h| (QREFELT $ 113)) |f|
                              (QREFELT $ 115)))
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |f| (|spadConstant| $ 65) (QREFELT $ 78)))
                     (GO G191)))
                   (SEQ (LETT |g| (SPADCALL |f| (QREFELT $ 91)))
                        (LETT |rf|
                              (SPADCALL |rf|
                                        (|IDECOMP;pushuterm|
                                         (SPADCALL |f| |g| (QREFELT $ 71)) |xp|
                                         |x| $)
                                        (QREFELT $ 70)))
                        (EXIT (LETT |f| |g|)))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |rf|)))) 

(SDEFUN |IDECOMP;trueden|
        ((|c| (|Polynomial| (|Integer|))) (|x| (|Symbol|))
         ($ (|Polynomial| (|Integer|))))
        (COND
         ((EQL (SPADCALL |c| |x| (QREFELT $ 117)) 0) (|spadConstant| $ 111))
         ('T |c|))) 

(SDEFUN |IDECOMP;pushuterm|
        ((|t|
          (|DistributedMultivariatePolynomial| |vl|
                                               (|Fraction|
                                                (|Polynomial| (|Integer|)))))
         (|xp| (|Symbol|)) (|x| (|OrderedVariableList| |vl|))
         ($
          (|DistributedMultivariatePolynomial| |vl|
                                               (|Fraction|
                                                (|Polynomial| (|Integer|))))))
        (SPADCALL
         (|IDECOMP;pushucoef|
          (SPADCALL (SPADCALL (SPADCALL |t| (QREFELT $ 95)) (QREFELT $ 15))
                    |xp| (QREFELT $ 118))
          |x| $)
         (SPADCALL
          (SPADCALL
           (SPADCALL (SPADCALL (SPADCALL |t| (QREFELT $ 95)) (QREFELT $ 17))
                     (QREFELT $ 113))
           (QREFELT $ 119))
          (SPADCALL |t| (QREFELT $ 121)) (QREFELT $ 122))
         (QREFELT $ 81))) 

(SDEFUN |IDECOMP;pushucoef|
        ((|c| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         (|x| (|OrderedVariableList| |vl|))
         ($
          (|DistributedMultivariatePolynomial| |vl|
                                               (|Fraction|
                                                (|Polynomial| (|Integer|))))))
        (COND
         ((SPADCALL |c| (|spadConstant| $ 124) (QREFELT $ 125))
          (|spadConstant| $ 65))
         ('T
          (SPADCALL
           (SPADCALL
            (SPADCALL (SPADCALL (SPADCALL |c| (QREFELT $ 126)) (QREFELT $ 113))
                      (QREFELT $ 97))
            |x| (SPADCALL |c| (QREFELT $ 127)) (QREFELT $ 114))
           (|IDECOMP;pushucoef| (SPADCALL |c| (QREFELT $ 128)) |x| $)
           (QREFELT $ 70))))) 

(SDEFUN |IDECOMP;is0dimprimary|
        ((J
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         (|truelist| (|List| (|OrderedVariableList| |vl|))) ($ (|Boolean|)))
        (SPROG
         ((JP
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|))))))
          (#1=#:G940 NIL)
          (JM
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|))))))
          (|i| (|Union| (|NonNegativeInteger|) "failed")) (#2=#:G928 NIL)
          (|x| (|OrderedVariableList| |vl|)) (#3=#:G941 NIL) (|f| NIL)
          (JR
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|))))))
          (|Jd|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|)))))))
         (SEQ
          (EXIT
           (COND ((SPADCALL (|spadConstant| $ 47) J (QREFELT $ 48)) 'T)
                 (#4='T
                  (SEQ
                   (LETT |Jd|
                         (SPADCALL (SPADCALL J (QREFELT $ 79)) (QREFELT $ 33)))
                   (EXIT
                    (COND
                     ((SPADCALL
                       (LENGTH
                        (SPADCALL
                         (SPADCALL (SPADCALL |Jd| '|last| (QREFELT $ 61))
                                   (QREFELT $ 102))
                         (QREFELT $ 106)))
                       1 (QREFELT $ 68))
                      (PROGN (LETT #1# NIL) (GO #5=#:G939)))
                     (#4#
                      (SEQ
                       (LETT |i|
                             (SPADCALL (LENGTH |truelist|) 1 (QREFELT $ 129)))
                       (EXIT
                        (COND ((QEQCAR |i| 1) (PROGN (LETT #1# 'T) (GO #5#)))
                              (#4#
                               (SEQ (LETT JR (REVERSE |Jd|))
                                    (LETT JM
                                          (SPADCALL (LIST (|SPADfirst| JR))
                                                    (QREFELT $ 31)))
                                    (LETT JP NIL)
                                    (SEQ (LETT |f| NIL) (LETT #3# (CDR JR))
                                         G190
                                         (COND
                                          ((OR (ATOM #3#)
                                               (PROGN
                                                (LETT |f| (CAR #3#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((|IDECOMP;ismonic| |f|
                                              (SPADCALL |truelist| (QCDR |i|)
                                                        (QREFELT $ 130))
                                              $)
                                             (SEQ
                                              (LETT |x|
                                                    (SPADCALL |truelist|
                                                              (QCDR |i|)
                                                              (QREFELT $ 130)))
                                              (LETT |i|
                                                    (CONS 0
                                                          (PROG1
                                                              (LETT #2#
                                                                    (-
                                                                     (QCDR |i|)
                                                                     1))
                                                            (|check_subtype2|
                                                             (>= #2# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|)
                                                             #2#))))
                                              (COND
                                               ((NULL
                                                 (|IDECOMP;testPower|
                                                  (SPADCALL |f| |x|
                                                            (QREFELT $ 73))
                                                  |x| JM $))
                                                (PROGN
                                                 (LETT #1# NIL)
                                                 (GO #5#))))
                                              (EXIT
                                               (LETT JM
                                                     (SPADCALL
                                                      (SPADCALL (CONS |f| JP)
                                                                (SPADCALL JM
                                                                          (QREFELT
                                                                           $
                                                                           33))
                                                                (QREFELT $
                                                                         131))
                                                      (QREFELT $ 31))))))
                                            ('T
                                             (SEQ
                                              (COND
                                               ((NULL
                                                 (SPADCALL |f| JM
                                                           (QREFELT $ 132)))
                                                (PROGN
                                                 (LETT #1# NIL)
                                                 (GO #5#))))
                                              (EXIT
                                               (LETT JP (CONS |f| JP))))))))
                                         (LETT #3# (CDR #3#)) (GO G190) G191
                                         (EXIT NIL))
                                    (EXIT 'T)))))))))))))
          #5# (EXIT #1#)))) 

(SDEFUN |IDECOMP;genPosLastVar|
        ((J
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         (|truelist| (|List| (|OrderedVariableList| |vl|)))
         ($
          (|Record| (|:| |changeval| (|List| (|Integer|)))
                    (|:| |genideal|
                         (|PolynomialIdeal|
                          (|Fraction| (|Polynomial| (|Integer|)))
                          (|DirectProduct| (|#| |vl|) (|NonNegativeInteger|))
                          (|OrderedVariableList| |vl|)
                          (|DistributedMultivariatePolynomial| |vl|
                                                               (|Fraction|
                                                                (|Polynomial|
                                                                 (|Integer|)))))))))
        (SPROG
         ((#1=#:G957 NIL) (|p| NIL) (#2=#:G956 NIL)
          (|val|
           #3=(|DistributedMultivariatePolynomial| |vl|
                                                   (|Fraction|
                                                    (|Polynomial|
                                                     (|Integer|)))))
          (#4=#:G946 NIL) (#5=#:G945 #3#) (#6=#:G947 #3#) (#7=#:G954 NIL)
          (|vv| NIL) (#8=#:G955 NIL) (|rv| NIL)
          (|ranvals| (|List| (|Integer|))) (#9=#:G953 NIL) (#10=#:G952 NIL)
          (|lv1| (|List| (|OrderedVariableList| |vl|)))
          (|x| (|OrderedVariableList| |vl|)))
         (SEQ (LETT |x| (SPADCALL |truelist| (QREFELT $ 133)))
              (LETT |lv1| (SPADCALL |x| |truelist| (QREFELT $ 94)))
              (LETT |ranvals|
                    (PROGN
                     (LETT #10# NIL)
                     (SEQ (LETT |vv| NIL) (LETT #9# |lv1|) G190
                          (COND
                           ((OR (ATOM #9#) (PROGN (LETT |vv| (CAR #9#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #10# (CONS (RANDOM 23) #10#))))
                          (LETT #9# (CDR #9#)) (GO G190) G191
                          (EXIT (NREVERSE #10#)))))
              (LETT |val|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |rv| NIL) (LETT #8# |ranvals|) (LETT |vv| NIL)
                          (LETT #7# |lv1|) G190
                          (COND
                           ((OR (ATOM #7#) (PROGN (LETT |vv| (CAR #7#)) NIL)
                                (ATOM #8#) (PROGN (LETT |rv| (CAR #8#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #6#
                                   (SPADCALL |rv|
                                             (SPADCALL |vv| (QREFELT $ 60))
                                             (QREFELT $ 69)))
                             (COND
                              (#4#
                               (LETT #5# (SPADCALL #5# #6# (QREFELT $ 70))))
                              ('T (PROGN (LETT #5# #6#) (LETT #4# 'T)))))))
                          (LETT #7# (PROG1 (CDR #7#) (LETT #8# (CDR #8#))))
                          (GO G190) G191 (EXIT NIL))
                     (COND (#4# #5#) ('T (|spadConstant| $ 65)))))
              (LETT |val|
                    (SPADCALL |val| (SPADCALL |x| (QREFELT $ 60))
                              (QREFELT $ 70)))
              (EXIT
               (CONS |ranvals|
                     (SPADCALL
                      (SPADCALL
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |p| NIL)
                             (LETT #1# (SPADCALL J (QREFELT $ 33))) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS
                                      (SPADCALL
                                       (SPADCALL |p| |x| (QREFELT $ 73)) |val|
                                       (QREFELT $ 75))
                                      #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))
                       (QREFELT $ 64))
                      (QREFELT $ 31))))))) 

(SDEFUN |IDECOMP;backGenPos|
        ((I
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         (|lval| (|List| (|Integer|)))
         (|truelist| (|List| (|OrderedVariableList| |vl|)))
         ($
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|)))))))
        (SPROG
         ((#1=#:G980 NIL) (|p| NIL) (#2=#:G979 NIL)
          (|val|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (#3=#:G971 NIL)
          (#4=#:G970
           #5=(|DistributedMultivariatePolynomial| |vl|
                                                   (|Fraction|
                                                    (|Polynomial|
                                                     (|Integer|)))))
          (#6=#:G972 #5#) (#7=#:G977 NIL) (|vv| NIL) (#8=#:G978 NIL) (|rv| NIL)
          (|lv1| (|List| (|OrderedVariableList| |vl|)))
          (|x| (|OrderedVariableList| |vl|)))
         (SEQ
          (COND ((SPADCALL |lval| NIL (QREFELT $ 135)) I)
                (#9='T
                 (SEQ (LETT |x| (SPADCALL |truelist| (QREFELT $ 133)))
                      (LETT |lv1| (SPADCALL |x| |truelist| (QREFELT $ 94)))
                      (LETT |val|
                            (SPADCALL
                             (PROGN
                              (LETT #3# NIL)
                              (SEQ (LETT |rv| NIL) (LETT #8# |lval|)
                                   (LETT |vv| NIL) (LETT #7# |lv1|) G190
                                   (COND
                                    ((OR (ATOM #7#)
                                         (PROGN (LETT |vv| (CAR #7#)) NIL)
                                         (ATOM #8#)
                                         (PROGN (LETT |rv| (CAR #8#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (PROGN
                                      (LETT #6#
                                            (SPADCALL |rv|
                                                      (SPADCALL |vv|
                                                                (QREFELT $ 60))
                                                      (QREFELT $ 69)))
                                      (COND
                                       (#3#
                                        (LETT #4#
                                              (SPADCALL #4# #6#
                                                        (QREFELT $ 70))))
                                       ('T
                                        (PROGN
                                         (LETT #4# #6#)
                                         (LETT #3# 'T)))))))
                                   (LETT #7#
                                         (PROG1 (CDR #7#)
                                           (LETT #8# (CDR #8#))))
                                   (GO G190) G191 (EXIT NIL))
                              (COND (#3# #4#) (#9# (|spadConstant| $ 65))))
                             (QREFELT $ 136)))
                      (LETT |val|
                            (SPADCALL |val| (SPADCALL |x| (QREFELT $ 60))
                                      (QREFELT $ 70)))
                      (EXIT
                       (SPADCALL
                        (SPADCALL
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |p| NIL)
                               (LETT #1# (SPADCALL I (QREFELT $ 33))) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |p| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS
                                        (SPADCALL
                                         (SPADCALL |p| |x| (QREFELT $ 73))
                                         |val| (QREFELT $ 75))
                                        #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 64))
                        (QREFELT $ 31))))))))) 

(SDEFUN |IDECOMP;ismonic|
        ((|f|
          (|DistributedMultivariatePolynomial| |vl|
                                               (|Fraction|
                                                (|Polynomial| (|Integer|)))))
         (|x| (|OrderedVariableList| |vl|)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL (SPADCALL |f| |x| (QREFELT $ 73)) (QREFELT $ 137))
                  (QREFELT $ 138))) 

(SDEFUN |IDECOMP;testPower|
        ((|uf|
          (|SparseUnivariatePolynomial|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|))))))
         (|x| (|OrderedVariableList| |vl|))
         (J
          (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Integer|))))))
         ($ (|Boolean|)))
        (SPROG
         ((|g|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (|linp|
           (|SparseUnivariatePolynomial|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|))))))
          (|trailp|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (#1=#:G983 NIL) (|df| (|PositiveInteger|)) (#2=#:G982 NIL))
         (SEQ
          (LETT |df|
                (PROG1 (LETT #2# (SPADCALL |uf| (QREFELT $ 139)))
                  (|check_subtype2| (> #2# 0) '(|PositiveInteger|)
                                    '(|NonNegativeInteger|) #2#)))
          (LETT |trailp|
                (SPADCALL
                 (SPADCALL (SPADCALL |df| (QREFELT $ 11)) (QREFELT $ 119))
                 (SPADCALL |uf|
                           (PROG1 (LETT #1# (- |df| 1))
                             (|check_subtype2| (>= #1# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #1#))
                           (QREFELT $ 140))
                 (QREFELT $ 115)))
          (LETT |linp|
                (SPADCALL
                 (SPADCALL (SPADCALL (|spadConstant| $ 47) 1 (QREFELT $ 141))
                           (SPADCALL |trailp| 0 (QREFELT $ 141))
                           (QREFELT $ 142))
                 |df| (QREFELT $ 143)))
          (LETT |g|
                (SPADCALL (SPADCALL |uf| |linp| (QREFELT $ 144)) |x|
                          (QREFELT $ 145)))
          (EXIT (SPADCALL |g| J (QREFELT $ 132)))))) 

(SDEFUN |IDECOMP;zeroDimPrime?;PiB;25|
        ((I
          (|PolynomialIdeal| (|Fraction| (|Integer|))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Integer|)))))
         ($ (|Boolean|)))
        (SPROG
         ((|lfact|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor|
                           (|DistributedMultivariatePolynomial| |vl|
                                                                (|Fraction|
                                                                 (|Polynomial|
                                                                  (|Integer|)))))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|g|
           (|DistributedMultivariatePolynomial| |vl|
                                                (|Fraction|
                                                 (|Polynomial| (|Integer|)))))
          (|i| (|NonNegativeInteger|)) (#1=#:G997 NIL) (#2=#:G998 NIL)
          (|f| NIL)
          (|Jd|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction|
                                                  (|Polynomial|
                                                   (|Integer|))))))
          (|n| (|NonNegativeInteger|))
          (J
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|)))))))
         (SEQ
          (EXIT
           (SEQ
            (LETT J
                  (SPADCALL
                   (QCDR
                    (|IDECOMP;genPosLastVar| (|IDECOMP;internalForm| I $)
                     (QREFELT $ 44) $))
                   (QREFELT $ 79)))
            (EXIT
             (COND ((SPADCALL (|spadConstant| $ 47) J (QREFELT $ 48)) 'T)
                   (#3='T
                    (SEQ (LETT |n| (LENGTH (QREFELT $ 6))) (LETT |i| 1)
                         (LETT |Jd| (SPADCALL J (QREFELT $ 33)))
                         (EXIT
                          (COND
                           ((SPADCALL (LENGTH |Jd|) |n| (QREFELT $ 68)) NIL)
                           (#3#
                            (SEQ
                             (SEQ (LETT |f| NIL) (LETT #2# |Jd|) G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |f| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (COND
                                    ((NULL
                                      (|IDECOMP;ismonic| |f|
                                       (SPADCALL (QREFELT $ 44) |i|
                                                 (QREFELT $ 130))
                                       $))
                                     (PROGN (LETT #1# NIL) (GO #4=#:G996))))
                                   (COND
                                    ((< |i| |n|)
                                     (COND
                                      ((SPADCALL
                                        (SPADCALL
                                         (SPADCALL |f|
                                                   (SPADCALL (QREFELT $ 44) |i|
                                                             (QREFELT $ 130))
                                                   (QREFELT $ 73))
                                         (QREFELT $ 139))
                                        1 (QREFELT $ 68))
                                       (PROGN (LETT #1# NIL) (GO #4#))))))
                                   (EXIT (LETT |i| (+ |i| 1))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT NIL))
                             (LETT |g| (SPADCALL |Jd| |n| (QREFELT $ 146)))
                             (EXIT
                              (COND
                               ((>
                                 (LENGTH
                                  (LETT |lfact|
                                        (SPADCALL
                                         (SPADCALL |g| (QREFELT $ 102))
                                         (QREFELT $ 106))))
                                 1)
                                NIL)
                               (#3#
                                (EQL
                                 (QVELT (SPADCALL |lfact| 1 (QREFELT $ 147)) 2)
                                 1))))))))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |IDECOMP;zeroDimPrimary?;PiB;26|
        ((J
          (|PolynomialIdeal| (|Fraction| (|Integer|))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Integer|)))))
         ($ (|Boolean|)))
        (|IDECOMP;is0dimprimary| (|IDECOMP;internalForm| J $) (QREFELT $ 44) $)) 

(SDEFUN |IDECOMP;primaryDecomp;PiL;27|
        ((I
          (|PolynomialIdeal| (|Fraction| (|Integer|))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Integer|)))))
         ($
          (|List|
           (|PolynomialIdeal| (|Fraction| (|Integer|))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Integer|)))))))
        (SPROG
         ((#1=#:G1012 NIL) (II NIL) (#2=#:G1011 NIL)
          (|truelist| (|List| (|OrderedVariableList| |vl|))) (#3=#:G1001 NIL)
          (#4=#:G1000 #5=(|List| (|OrderedVariableList| |vl|)))
          (#6=#:G1002 #5#) (#7=#:G1010 NIL) (|f| NIL)
          (J
           (|PolynomialIdeal| (|Fraction| (|Polynomial| (|Integer|)))
                              (|DirectProduct| (|#| |vl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |vl|)
                              (|DistributedMultivariatePolynomial| |vl|
                                                                   (|Fraction|
                                                                    (|Polynomial|
                                                                     (|Integer|)))))))
         (SEQ (LETT J (SPADCALL (|IDECOMP;internalForm| I $) (QREFELT $ 79)))
              (LETT |truelist|
                    (|IDECOMP;rearrange|
                     (PROGN
                      (LETT #3# NIL)
                      (SEQ (LETT |f| NIL)
                           (LETT #7# (SPADCALL J (QREFELT $ 33))) G190
                           (COND
                            ((OR (ATOM #7#) (PROGN (LETT |f| (CAR #7#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (PROGN
                              (LETT #6# (SPADCALL |f| (QREFELT $ 92)))
                              (COND
                               (#3#
                                (LETT #4# (SPADCALL #4# #6# (QREFELT $ 93))))
                               ('T (PROGN (LETT #4# #6#) (LETT #3# 'T)))))))
                           (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                      (COND (#3# #4#) (#8='T (|IdentityError| '|setUnion|))))
                     $))
              (EXIT
               (COND
                ((SPADCALL |truelist| NIL (QREFELT $ 50))
                 (LIST (|IDECOMP;externalForm| J $)))
                (#8#
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT II NIL)
                       (LETT #1#
                             (|IDECOMP;reduceDim| (CONS 0 "zeroPrimDecomp") J
                              |truelist| $))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT II (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (|IDECOMP;externalForm| II $) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#)))))))))) 

(SDEFUN |IDECOMP;contract;PiLPi;28|
        ((I
          (|PolynomialIdeal| (|Fraction| (|Integer|))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Integer|)))))
         (|lvar| (|List| (|OrderedVariableList| |vl|)))
         ($
          (|PolynomialIdeal| (|Fraction| (|Integer|))
                             (|DirectProduct| (|#| |vl|)
                                              (|NonNegativeInteger|))
                             (|OrderedVariableList| |vl|)
                             (|DistributedMultivariatePolynomial| |vl|
                                                                  (|Fraction|
                                                                   (|Integer|))))))
        (SPROG
         ((#1=#:G1048 NIL) (|gg| NIL) (#2=#:G1047 NIL)
          (|fullPol|
           (|List|
            #3=(|DistributedMultivariatePolynomial| |vl|
                                                    (|Fraction| (|Integer|)))))
          (#4=#:G1046 NIL) (|vv| NIL) (#5=#:G1045 NIL)
          (J
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction| (|Integer|)))))
          (#6=#:G759 NIL) (#7=#:G1044 NIL) (|f| NIL) (#8=#:G1043 NIL)
          (|lJ|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction| (|Integer|)))))
          (#9=#:G1042 NIL) (|g| NIL) (#10=#:G1041 NIL)
          (|subsVars| (|List| #3#)) (#11=#:G1040 NIL) (#12=#:G1039 NIL)
          (|newVars| (|List| (|OrderedVariableList| |vl|))) (#13=#:G1038 NIL)
          (#14=#:G1037 NIL) (|n| (|NonNegativeInteger|))
          (|fullVars| #15=(|List| (|OrderedVariableList| |vl|)))
          (#16=#:G1014 NIL) (#17=#:G1013 #15#) (#18=#:G1015 #15#)
          (#19=#:G1036 NIL)
          (|Id|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction| (|Integer|))))))
         (SEQ
          (LETT |Id| (SPADCALL (SPADCALL I (QREFELT $ 152)) (QREFELT $ 21)))
          (EXIT
           (COND ((NULL |Id|) I)
                 (#20='T
                  (SEQ
                   (LETT |fullVars|
                         (PROGN
                          (LETT #16# NIL)
                          (SEQ (LETT |g| NIL) (LETT #19# |Id|) G190
                               (COND
                                ((OR (ATOM #19#)
                                     (PROGN (LETT |g| (CAR #19#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (PROGN
                                  (LETT #18# (SPADCALL |g| (QREFELT $ 153)))
                                  (COND
                                   (#16#
                                    (LETT #17#
                                          (SPADCALL #17# #18# (QREFELT $ 93))))
                                   ('T
                                    (PROGN
                                     (LETT #17# #18#)
                                     (LETT #16# 'T)))))))
                               (LETT #19# (CDR #19#)) (GO G190) G191
                               (EXIT NIL))
                          (COND (#16# #17#)
                                (#20# (|IdentityError| '|setUnion|)))))
                   (EXIT
                    (COND ((SPADCALL |fullVars| |lvar| (QREFELT $ 50)) I)
                          (#20#
                           (SEQ (LETT |n| (LENGTH |lvar|))
                                (EXIT
                                 (COND
                                  ((< (LENGTH |fullVars|) |n|)
                                   (|error| "wrong vars"))
                                  ((EQL |n| 0) I)
                                  (#20#
                                   (SEQ
                                    (LETT |newVars|
                                          (SPADCALL
                                           (PROGN
                                            (LETT #14# NIL)
                                            (SEQ (LETT |vv| NIL)
                                                 (LETT #13# |fullVars|) G190
                                                 (COND
                                                  ((OR (ATOM #13#)
                                                       (PROGN
                                                        (LETT |vv| (CAR #13#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (COND
                                                    ((NULL
                                                      (SPADCALL |vv| |lvar|
                                                                (QREFELT $
                                                                         154)))
                                                     (LETT #14#
                                                           (CONS |vv|
                                                                 #14#))))))
                                                 (LETT #13# (CDR #13#))
                                                 (GO G190) G191
                                                 (EXIT (NREVERSE #14#))))
                                           |lvar| (QREFELT $ 155)))
                                    (LETT |subsVars|
                                          (PROGN
                                           (LETT #12# NIL)
                                           (SEQ (LETT |vv| NIL)
                                                (LETT #11# |newVars|) G190
                                                (COND
                                                 ((OR (ATOM #11#)
                                                      (PROGN
                                                       (LETT |vv| (CAR #11#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #12#
                                                        (CONS
                                                         (SPADCALL
                                                          (|spadConstant| $
                                                                          156)
                                                          |vv| 1
                                                          (QREFELT $ 157))
                                                         #12#))))
                                                (LETT #11# (CDR #11#))
                                                (GO G190) G191
                                                (EXIT (NREVERSE #12#)))))
                                    (LETT |lJ|
                                          (PROGN
                                           (LETT #10# NIL)
                                           (SEQ (LETT |g| NIL) (LETT #9# |Id|)
                                                G190
                                                (COND
                                                 ((OR (ATOM #9#)
                                                      (PROGN
                                                       (LETT |g| (CAR #9#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #10#
                                                        (CONS
                                                         (SPADCALL |g|
                                                                   |fullVars|
                                                                   |subsVars|
                                                                   (QREFELT $
                                                                            159))
                                                         #10#))))
                                                (LETT #9# (CDR #9#)) (GO G190)
                                                G191 (EXIT (NREVERSE #10#)))))
                                    (LETT J (SPADCALL |lJ| (QREFELT $ 161)))
                                    (EXIT
                                     (COND
                                      ((SPADCALL J
                                                 (LIST (|spadConstant| $ 156))
                                                 (QREFELT $ 162))
                                       (SPADCALL J (QREFELT $ 38)))
                                      ((SPADCALL J
                                                 (LIST (|spadConstant| $ 163))
                                                 (QREFELT $ 162))
                                       (SPADCALL NIL (QREFELT $ 38)))
                                      (#20#
                                       (SEQ
                                        (LETT J
                                              (PROGN
                                               (LETT #8# NIL)
                                               (SEQ (LETT |f| NIL) (LETT #7# J)
                                                    G190
                                                    (COND
                                                     ((OR (ATOM #7#)
                                                          (PROGN
                                                           (LETT |f| (CAR #7#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (COND
                                                       ((SPADCALL
                                                         (PROG2
                                                             (LETT #6#
                                                                   (SPADCALL
                                                                    |f|
                                                                    (QREFELT $
                                                                             164)))
                                                             (QCDR #6#)
                                                           (|check_union2|
                                                            (QEQCAR #6# 0)
                                                            (|OrderedVariableList|
                                                             (QREFELT $ 6))
                                                            (|Union|
                                                             (|OrderedVariableList|
                                                              (QREFELT $ 6))
                                                             "failed")
                                                            #6#))
                                                         |newVars|
                                                         (QREFELT $ 154))
                                                        (LETT #8#
                                                              (CONS |f|
                                                                    #8#))))))
                                                    (LETT #7# (CDR #7#))
                                                    (GO G190) G191
                                                    (EXIT (NREVERSE #8#)))))
                                        (LETT |fullPol|
                                              (PROGN
                                               (LETT #5# NIL)
                                               (SEQ (LETT |vv| NIL)
                                                    (LETT #4# |fullVars|) G190
                                                    (COND
                                                     ((OR (ATOM #4#)
                                                          (PROGN
                                                           (LETT |vv|
                                                                 (CAR #4#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (LETT #5#
                                                            (CONS
                                                             (SPADCALL
                                                              (|spadConstant| $
                                                                              156)
                                                              |vv| 1
                                                              (QREFELT $ 157))
                                                             #5#))))
                                                    (LETT #4# (CDR #4#))
                                                    (GO G190) G191
                                                    (EXIT (NREVERSE #5#)))))
                                        (EXIT
                                         (SPADCALL
                                          (PROGN
                                           (LETT #2# NIL)
                                           (SEQ (LETT |gg| NIL) (LETT #1# J)
                                                G190
                                                (COND
                                                 ((OR (ATOM #1#)
                                                      (PROGN
                                                       (LETT |gg| (CAR #1#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #2#
                                                        (CONS
                                                         (SPADCALL |gg|
                                                                   |newVars|
                                                                   |fullPol|
                                                                   (QREFELT $
                                                                            159))
                                                         #2#))))
                                                (LETT #1# (CDR #1#)) (GO G190)
                                                G191 (EXIT (NREVERSE #2#))))
                                          (QREFELT $ 38)))))))))))))))))))))) 

(DECLAIM (NOTINLINE |IdealDecompositionPackage;|)) 

(DEFUN |IdealDecompositionPackage| (#1=#:G1051)
  (SPROG NIL
         (PROG (#2=#:G1052)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|IdealDecompositionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|IdealDecompositionPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|IdealDecompositionPackage|)))))))))) 

(DEFUN |IdealDecompositionPackage;| (|#1|)
  (SPROG
   ((#1=#:G762 NIL) (#2=#:G759 NIL) (#3=#:G1050 NIL) (|xx| NIL)
    (#4=#:G1049 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (SEQ
    (PROGN
     (LETT DV$1 |#1|)
     (LETT |dv$| (LIST '|IdealDecompositionPackage| DV$1))
     (LETT $ (GETREFV 166))
     (QSETREFV $ 0 |dv$|)
     (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
     (|haddProp| |$ConstructorCache| '|IdealDecompositionPackage| (LIST DV$1)
                 (CONS 1 $))
     (|stuffDomainSlots| $)
     (QSETREFV $ 6 |#1|)
     (SETF |pv$| (QREFELT $ 3))
     (QSETREFV $ 44
               (PROGN
                (LETT #4# NIL)
                (SEQ (LETT |xx| NIL) (LETT #3# |#1|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |xx| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #4#
                             (CONS
                              (PROG2 (LETT #2# (SPADCALL |xx| (QREFELT $ 43)))
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 0)
                                                (|OrderedVariableList|
                                                 (SPADCALL |xx|
                                                           (QREFELT $ 43)))
                                                (|Union|
                                                 (|OrderedVariableList|
                                                  (SPADCALL |xx|
                                                            (QREFELT $ 43)))
                                                 "failed")
                                                #2#))
                              #4#))))
                     (LETT #3# (CDR #3#)) (GO G190) G191
                     (EXIT (NREVERSE #4#)))))
     (QSETREFV $ 46
               (PROG1 (LETT #1# (- (LENGTH (QREFELT $ 44)) 1))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))
     $)))) 

(MAKEPROP '|IdealDecompositionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|) (|Fraction| 7)
              (0 . |numer|) (|Fraction| 14) (5 . |coerce|) (10 . |denom|)
              (15 . /) (|Polynomial| 7) (21 . |numer|) (26 . |ground|)
              (31 . |denom|) (36 . /) (|List| 24)
              (|PolynomialIdeal| 8 120 42 24) (42 . |generators|)
              (|DistributedMultivariatePolynomial| (NRTEVAL (QREFELT $ 6)) 10)
              (|Mapping| 10 8)
              (|DistributedMultivariatePolynomial| (NRTEVAL (QREFELT $ 6)) 8)
              (|MPolyCatFunctions2| 42 120 120 8 10 24 22) (47 . |map|)
              (|Boolean|) (53 . |groebner?|) (|List| 22)
              (|PolynomialIdeal| 10 120 42 22) (58 . |groebnerIdeal|)
              (63 . |ideal|) (68 . |generators|) (|Mapping| 8 10)
              (|MPolyCatFunctions2| 42 120 120 10 8 22 24) (73 . |map|)
              (79 . |groebner?|) (84 . |groebnerIdeal|) (89 . |ideal|)
              (|Union| $ '"failed") (|Symbol|)
              (|OrderedVariableList| (NRTEVAL (QREFELT $ 6))) (94 . |variable|)
              '|lvint| (99 . |One|) '|nvint1| (103 . |One|) (107 . |element?|)
              (|List| 42) (113 . =) (119 . >) (125 . |setDifference|)
              (|Mapping| 27 42 42) (131 . |sort|) '"last" (137 . |elt|)
              (143 . |differentiate|) (149 . |gcd|) (155 . |exquo|)
              (161 . |coerce|) (166 . |elt|) (172 . |remove|)
              (|GroebnerPackage| 10 120 22) (178 . |groebner|) (183 . |Zero|)
              (|NonNegativeInteger|) (187 . |degree|) (193 . ~=) (199 . *)
              (205 . +) (211 . -) (|SparseUnivariatePolynomial| $)
              (217 . |univariate|) (|SparseUnivariatePolynomial| 22)
              (223 . |elt|) (229 . |Zero|) (233 . |Zero|) (237 . ~=)
              (243 . |groebner|) (248 . |saturate|) (254 . *) (260 . |in?|)
              (266 . |One|) (270 . ~=) (|Union| 42 '"failed")
              (276 . |mainVariable|) (281 . ~=) (287 . =) (293 . =)
              (299 . |position|) (305 . |reductum|) (310 . |variables|)
              (315 . |setUnion|) (321 . |remove|) (327 . |leadingCoefficient|)
              (332 . *) (338 . |coerce|) (|List| 30) (343 . |list|)
              (|Factored| 22)
              (|MPolyCatRationalFunctionFactorizer| 120 42 7 22)
              (348 . |factor|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 103) (|:| |factor| 22) (|:| |exponent| 66))
              (|List| 104) (353 . |factorList|) (358 . ^) (364 . |intersect|)
              |IDECOMP;radical;2Pi;13| (370 . |convert|) (375 . |One|)
              (379 . |monomial|) (386 . |coerce|) (391 . |monomial|) (398 . *)
              (404 . |lcm|) (410 . |degree|) (416 . |univariate|) (422 . |inv|)
              (|DirectProduct| (NRTEVAL (LENGTH (QREFELT $ 6))) 66)
              (427 . |degree|) (432 . |monomial|)
              (|SparseUnivariatePolynomial| 14) (438 . |Zero|) (442 . =)
              (448 . |leadingCoefficient|) (453 . |degree|) (458 . |reductum|)
              (463 . |subtractIfCan|) (469 . |elt|) (475 . |append|)
              (481 . |inRadical?|) (487 . |last|) (|List| 7) (492 . =)
              (498 . -) (503 . |leadingCoefficient|) (508 . |ground?|)
              (513 . |degree|) (518 . |coefficient|) (524 . |monomial|)
              (530 . +) (536 . ^) (542 . -) (548 . |multivariate|)
              (554 . |elt|) (560 . |elt|) |IDECOMP;zeroDimPrime?;PiB;25|
              |IDECOMP;zeroDimPrimary?;PiB;26| (|List| 20)
              |IDECOMP;primaryDecomp;PiL;27| (566 . |groebner|)
              (571 . |variables|) (576 . |member?|) (582 . |append|)
              (588 . |One|) (592 . |monomial|) (|List| $) (599 . |eval|)
              (|GroebnerPackage| 8 120 24) (606 . |groebner|) (611 . =)
              (617 . |Zero|) (621 . |mainVariable|)
              |IDECOMP;contract;PiLPi;28|)
           '#(|zeroDimPrime?| 626 |zeroDimPrimary?| 631 |radical| 636 |prime?|
              641 |primaryDecomp| 646 |contract| 651)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|zeroDimPrime?|
                                 ((|Boolean|)
                                  (|PolynomialIdeal| (|Fraction| (|Integer|))
                                                     (|DirectProduct|
                                                      (|#| |#1|)
                                                      (|NonNegativeInteger|))
                                                     (|OrderedVariableList|
                                                      |#1|)
                                                     (|DistributedMultivariatePolynomial|
                                                      |#1|
                                                      (|Fraction|
                                                       (|Integer|))))))
                                T)
                              '((|zeroDimPrimary?|
                                 ((|Boolean|)
                                  (|PolynomialIdeal| (|Fraction| (|Integer|))
                                                     (|DirectProduct|
                                                      (|#| |#1|)
                                                      (|NonNegativeInteger|))
                                                     (|OrderedVariableList|
                                                      |#1|)
                                                     (|DistributedMultivariatePolynomial|
                                                      |#1|
                                                      (|Fraction|
                                                       (|Integer|))))))
                                T)
                              '((|prime?|
                                 ((|Boolean|)
                                  (|PolynomialIdeal| (|Fraction| (|Integer|))
                                                     (|DirectProduct|
                                                      (|#| |#1|)
                                                      (|NonNegativeInteger|))
                                                     (|OrderedVariableList|
                                                      |#1|)
                                                     (|DistributedMultivariatePolynomial|
                                                      |#1|
                                                      (|Fraction|
                                                       (|Integer|))))))
                                T)
                              '((|radical|
                                 ((|PolynomialIdeal| (|Fraction| (|Integer|))
                                                     (|DirectProduct|
                                                      (|#| |#1|)
                                                      (|NonNegativeInteger|))
                                                     (|OrderedVariableList|
                                                      |#1|)
                                                     (|DistributedMultivariatePolynomial|
                                                      |#1|
                                                      (|Fraction|
                                                       (|Integer|))))
                                  (|PolynomialIdeal| (|Fraction| (|Integer|))
                                                     (|DirectProduct|
                                                      (|#| |#1|)
                                                      (|NonNegativeInteger|))
                                                     (|OrderedVariableList|
                                                      |#1|)
                                                     (|DistributedMultivariatePolynomial|
                                                      |#1|
                                                      (|Fraction|
                                                       (|Integer|))))))
                                T)
                              '((|primaryDecomp|
                                 ((|List|
                                   (|PolynomialIdeal| (|Fraction| (|Integer|))
                                                      (|DirectProduct|
                                                       (|#| |#1|)
                                                       (|NonNegativeInteger|))
                                                      (|OrderedVariableList|
                                                       |#1|)
                                                      (|DistributedMultivariatePolynomial|
                                                       |#1|
                                                       (|Fraction|
                                                        (|Integer|)))))
                                  (|PolynomialIdeal| (|Fraction| (|Integer|))
                                                     (|DirectProduct|
                                                      (|#| |#1|)
                                                      (|NonNegativeInteger|))
                                                     (|OrderedVariableList|
                                                      |#1|)
                                                     (|DistributedMultivariatePolynomial|
                                                      |#1|
                                                      (|Fraction|
                                                       (|Integer|))))))
                                T)
                              '((|contract|
                                 ((|PolynomialIdeal| (|Fraction| (|Integer|))
                                                     (|DirectProduct|
                                                      (|#| |#1|)
                                                      (|NonNegativeInteger|))
                                                     (|OrderedVariableList|
                                                      |#1|)
                                                     (|DistributedMultivariatePolynomial|
                                                      |#1|
                                                      (|Fraction|
                                                       (|Integer|))))
                                  (|PolynomialIdeal| (|Fraction| (|Integer|))
                                                     (|DirectProduct|
                                                      (|#| |#1|)
                                                      (|NonNegativeInteger|))
                                                     (|OrderedVariableList|
                                                      |#1|)
                                                     (|DistributedMultivariatePolynomial|
                                                      |#1|
                                                      (|Fraction|
                                                       (|Integer|))))
                                  (|List| (|OrderedVariableList| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 165
                                            '(1 8 7 0 9 1 10 0 7 11 1 8 7 0 12
                                              2 10 0 0 0 13 1 10 14 0 15 1 14 7
                                              0 16 1 10 14 0 17 2 8 0 7 7 18 1
                                              20 19 0 21 2 25 22 23 24 26 1 20
                                              27 0 28 1 30 0 29 31 1 30 0 29 32
                                              1 30 29 0 33 2 35 24 34 22 36 1
                                              30 27 0 37 1 20 0 19 38 1 20 0 19
                                              39 1 42 40 41 43 0 10 0 45 0 22 0
                                              47 2 30 27 22 0 48 2 49 27 0 0 50
                                              2 42 27 0 0 51 2 49 0 0 0 52 2 49
                                              0 53 0 54 2 49 42 0 55 56 2 22 0
                                              0 42 57 2 22 0 0 0 58 2 22 40 0 0
                                              59 1 22 0 42 60 2 29 22 0 55 61 2
                                              29 0 22 0 62 1 63 29 29 64 0 22 0
                                              65 2 22 66 0 42 67 2 66 27 0 0 68
                                              2 22 0 7 0 69 2 22 0 0 0 70 2 22
                                              0 0 0 71 2 22 72 0 42 73 2 74 22
                                              0 22 75 0 10 0 76 0 8 0 77 2 22
                                              27 0 0 78 1 30 0 0 79 2 30 0 0 22
                                              80 2 22 0 0 0 81 2 30 27 0 0 82 0
                                              8 0 83 2 29 27 0 0 84 1 22 85 0
                                              86 2 42 27 0 0 87 2 42 27 0 0 88
                                              2 29 27 0 0 89 2 49 7 42 0 90 1
                                              22 0 0 91 1 22 49 0 92 2 49 0 0 0
                                              93 2 49 0 42 0 94 1 22 10 0 95 2
                                              10 0 0 0 96 1 22 0 10 97 1 98 0
                                              30 99 1 101 100 22 102 1 100 105
                                              0 106 2 22 0 0 66 107 2 30 0 0 0
                                              108 1 42 41 0 110 0 14 0 111 3 14
                                              0 0 41 66 112 1 10 0 14 113 3 22
                                              0 0 42 66 114 2 22 0 10 0 115 2
                                              14 0 0 0 116 2 14 66 0 41 117 2
                                              14 72 0 41 118 1 10 0 0 119 1 22
                                              120 0 121 2 22 0 10 120 122 0 123
                                              0 124 2 123 27 0 0 125 1 123 14 0
                                              126 1 123 66 0 127 1 123 0 0 128
                                              2 66 40 0 0 129 2 49 42 0 7 130 2
                                              29 0 0 0 131 2 30 27 22 0 132 1
                                              49 42 0 133 2 134 27 0 0 135 1 22
                                              0 0 136 1 74 22 0 137 1 22 27 0
                                              138 1 74 66 0 139 2 74 22 0 66
                                              140 2 74 0 22 66 141 2 74 0 0 0
                                              142 2 74 0 0 66 143 2 74 0 0 0
                                              144 2 22 0 72 42 145 2 29 22 0 7
                                              146 2 105 104 0 7 147 1 20 0 0
                                              152 1 24 49 0 153 2 49 27 42 0
                                              154 2 49 0 0 0 155 0 24 0 156 3
                                              24 0 0 42 66 157 3 24 0 0 49 158
                                              159 1 160 19 19 161 2 19 27 0 0
                                              162 0 24 0 163 1 24 85 0 164 1 0
                                              27 20 148 1 0 27 20 149 1 0 20 20
                                              109 1 0 27 20 1 1 0 150 20 151 2
                                              0 20 20 49 165)))))
           '|lookupComplete|)) 

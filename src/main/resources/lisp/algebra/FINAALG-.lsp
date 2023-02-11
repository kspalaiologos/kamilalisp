
(SDEFUN |FINAALG-;leftCharacteristicPolynomial;SSup;1|
        ((|a| (S)) ($ (|SparseUnivariatePolynomial| R)))
        (SPROG
         ((#1=#:G741 NIL) (|j| NIL) (#2=#:G740 NIL) (|i| NIL)
          (|mb| (|Matrix| (|SparseUnivariatePolynomial| R)))
          (|ma| (|Matrix| R)) (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 9)))
              (LETT |ma|
                    (SPADCALL |a| (SPADCALL (QREFELT $ 11)) (QREFELT $ 13)))
              (LETT |mb| (SPADCALL |n| |n| (QREFELT $ 16)))
              (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |mb| |i| |j|
                                      (COND
                                       ((EQL |i| |j|)
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |ma| |i| |j|
                                                    (QREFELT $ 18))
                                          0 (QREFELT $ 20))
                                         (SPADCALL (|spadConstant| $ 21) 1
                                                   (QREFELT $ 20))
                                         (QREFELT $ 22)))
                                       ('T
                                        (SPADCALL
                                         (SPADCALL |ma| |i| |j| (QREFELT $ 18))
                                         1 (QREFELT $ 20))))
                                      (QREFELT $ 23))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |mb| (QREFELT $ 24)))))) 

(SDEFUN |FINAALG-;rightCharacteristicPolynomial;SSup;2|
        ((|a| (S)) ($ (|SparseUnivariatePolynomial| R)))
        (SPROG
         ((#1=#:G749 NIL) (|j| NIL) (#2=#:G748 NIL) (|i| NIL)
          (|mb| (|Matrix| (|SparseUnivariatePolynomial| R)))
          (|ma| (|Matrix| R)) (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 9)))
              (LETT |ma|
                    (SPADCALL |a| (SPADCALL (QREFELT $ 11)) (QREFELT $ 26)))
              (LETT |mb| (SPADCALL |n| |n| (QREFELT $ 16)))
              (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |mb| |i| |j|
                                      (COND
                                       ((EQL |i| |j|)
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |ma| |i| |j|
                                                    (QREFELT $ 18))
                                          0 (QREFELT $ 20))
                                         (SPADCALL (|spadConstant| $ 21) 1
                                                   (QREFELT $ 20))
                                         (QREFELT $ 22)))
                                       ('T
                                        (SPADCALL
                                         (SPADCALL |ma| |i| |j| (QREFELT $ 18))
                                         1 (QREFELT $ 20))))
                                      (QREFELT $ 23))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |mb| (QREFELT $ 24)))))) 

(SDEFUN |FINAALG-;leftTrace;SR;3| ((|a| (S)) ($ (R)))
        (SPROG ((|t| (R)) (#1=#:G754 NIL) (|i| NIL) (|ma| (|Matrix| R)))
               (SEQ (LETT |t| (|spadConstant| $ 28))
                    (LETT |ma|
                          (SPADCALL |a| (SPADCALL (QREFELT $ 11))
                                    (QREFELT $ 13)))
                    (SEQ (LETT |i| 1) (LETT #1# (SPADCALL (QREFELT $ 9))) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |t|
                                 (SPADCALL |t|
                                           (SPADCALL |ma| |i| |i|
                                                     (QREFELT $ 18))
                                           (QREFELT $ 29)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |t|)))) 

(SDEFUN |FINAALG-;rightTrace;SR;4| ((|a| (S)) ($ (R)))
        (SPROG ((|t| (R)) (#1=#:G759 NIL) (|i| NIL) (|ma| (|Matrix| R)))
               (SEQ (LETT |t| (|spadConstant| $ 28))
                    (LETT |ma|
                          (SPADCALL |a| (SPADCALL (QREFELT $ 11))
                                    (QREFELT $ 26)))
                    (SEQ (LETT |i| 1) (LETT #1# (SPADCALL (QREFELT $ 9))) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |t|
                                 (SPADCALL |t|
                                           (SPADCALL |ma| |i| |i|
                                                     (QREFELT $ 18))
                                           (QREFELT $ 29)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |t|)))) 

(SDEFUN |FINAALG-;leftNorm;SR;5| ((|a| (S)) ($ (R)))
        (SPADCALL (SPADCALL |a| (SPADCALL (QREFELT $ 11)) (QREFELT $ 13))
                  (QREFELT $ 32))) 

(SDEFUN |FINAALG-;rightNorm;SR;6| ((|a| (S)) ($ (R)))
        (SPADCALL (SPADCALL |a| (SPADCALL (QREFELT $ 11)) (QREFELT $ 26))
                  (QREFELT $ 32))) 

(SDEFUN |FINAALG-;antiAssociative?;B;7| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G772 NIL) (#2=#:G773 NIL) (#3=#:G776 NIL) (|k| NIL)
          (#4=#:G775 NIL) (|j| NIL) (#5=#:G774 NIL) (|i| NIL)
          (|n| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                            (COND ((|greater_SI| |j| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |b| |i| (QREFELT $ 36))
                                            (SPADCALL |b| |j| (QREFELT $ 36))
                                            (QREFELT $ 37))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (QREFELT $ 37))
                                          (SPADCALL
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL
                                            (SPADCALL |b| |j| (QREFELT $ 36))
                                            (SPADCALL |b| |k| (QREFELT $ 36))
                                            (QREFELT $ 37))
                                           (QREFELT $ 37))
                                          (QREFELT $ 38))
                                         (QREFELT $ 40)))
                                       (PROGN
                                        (LETT #1#
                                              (SEQ
                                               (SPADCALL
                                                "algebra is not anti-associative"
                                                (QREFELT $ 44))
                                               (EXIT
                                                (PROGN
                                                 (LETT #2# NIL)
                                                 (GO #6=#:G771)))))
                                        (GO #7=#:G767))))))
                                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                   (EXIT NIL)))
                             #7# (EXIT #1#))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL "algebra is anti-associative" (QREFELT $ 44))
                (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |FINAALG-;jordanAdmissible?;B;8| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G794 NIL) (#2=#:G795 NIL) (#3=#:G799 NIL) (|l| NIL)
          (#4=#:G798 NIL) (|k| NIL) (#5=#:G797 NIL) (|j| NIL) (#6=#:G796 NIL)
          (|i| NIL) (|n| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (EXIT
                 (COND
                  ((QEQCAR
                    (SPADCALL (SPADCALL 2 (|spadConstant| $ 21) (QREFELT $ 46))
                              (QREFELT $ 48))
                    1)
                   (SEQ
                    (SPADCALL
                     "this algebra is not Jordan admissible, as 2 is not invertible in the ground ring"
                     (QREFELT $ 44))
                    (EXIT NIL)))
                  ('T
                   (SEQ
                    (SEQ (LETT |i| 1) (LETT #6# |n|) G190
                         (COND ((|greater_SI| |i| #6#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SEQ (LETT |j| 1) (LETT #5# |n|) G190
                                (COND ((|greater_SI| |j| #5#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SEQ (LETT |k| 1) (LETT #4# |n|) G190
                                       (COND
                                        ((|greater_SI| |k| #4#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (SEQ (LETT |l| 1) (LETT #3# |n|) G190
                                              (COND
                                               ((|greater_SI| |l| #3#)
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (COND
                                                 ((NULL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL |b| |i|
                                                                  (QREFELT $
                                                                           36))
                                                        (SPADCALL |b| |j|
                                                                  (QREFELT $
                                                                           36))
                                                        (QREFELT $ 49))
                                                       (SPADCALL
                                                        (SPADCALL |b| |l|
                                                                  (QREFELT $
                                                                           36))
                                                        (SPADCALL |b| |k|
                                                                  (QREFELT $
                                                                           36))
                                                        (QREFELT $ 49))
                                                       (QREFELT $ 49))
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL |b| |l|
                                                                  (QREFELT $
                                                                           36))
                                                        (SPADCALL |b| |j|
                                                                  (QREFELT $
                                                                           36))
                                                        (QREFELT $ 49))
                                                       (SPADCALL
                                                        (SPADCALL |b| |k|
                                                                  (QREFELT $
                                                                           36))
                                                        (SPADCALL |b| |i|
                                                                  (QREFELT $
                                                                           36))
                                                        (QREFELT $ 49))
                                                       (QREFELT $ 49))
                                                      (QREFELT $ 38))
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |b| |k|
                                                                 (QREFELT $
                                                                          36))
                                                       (SPADCALL |b| |j|
                                                                 (QREFELT $
                                                                          36))
                                                       (QREFELT $ 49))
                                                      (SPADCALL
                                                       (SPADCALL |b| |i|
                                                                 (QREFELT $
                                                                          36))
                                                       (SPADCALL |b| |l|
                                                                 (QREFELT $
                                                                          36))
                                                       (QREFELT $ 49))
                                                      (QREFELT $ 49))
                                                     (QREFELT $ 38))
                                                    (QREFELT $ 40)))
                                                  (PROGN
                                                   (LETT #1#
                                                         (SEQ
                                                          (SPADCALL
                                                           "this algebra is not Jordan admissible"
                                                           (QREFELT $ 44))
                                                          (EXIT
                                                           (PROGN
                                                            (LETT #2# NIL)
                                                            (GO #7=#:G793)))))
                                                   (GO #8=#:G787))))))
                                              (LETT |l| (|inc_SI| |l|))
                                              (GO G190) G191 (EXIT NIL)))
                                        #8# (EXIT #1#))
                                       (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                       (EXIT NIL))))
                                (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                (EXIT NIL))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (SPADCALL "this algebra is Jordan admissible"
                              (QREFELT $ 44))
                    (EXIT 'T)))))))
          #7# (EXIT #2#)))) 

(SDEFUN |FINAALG-;lieAdmissible?;B;9| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G810 NIL) (#2=#:G811 NIL) (#3=#:G814 NIL) (|k| NIL)
          (#4=#:G813 NIL) (|j| NIL) (#5=#:G812 NIL) (|i| NIL)
          (|b| (|Vector| S)) (|n| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL (QREFELT $ 9)))
                (LETT |b| (SPADCALL (QREFELT $ 11)))
                (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                            (COND ((|greater_SI| |j| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |b| |i| (QREFELT $ 36))
                                             (SPADCALL |b| |j| (QREFELT $ 36))
                                             (QREFELT $ 51))
                                            (SPADCALL |b| |k| (QREFELT $ 36))
                                            (QREFELT $ 51))
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |b| |j| (QREFELT $ 36))
                                             (SPADCALL |b| |k| (QREFELT $ 36))
                                             (QREFELT $ 51))
                                            (SPADCALL |b| |i| (QREFELT $ 36))
                                            (QREFELT $ 51))
                                           (QREFELT $ 38))
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |b| |k| (QREFELT $ 36))
                                            (SPADCALL |b| |i| (QREFELT $ 36))
                                            (QREFELT $ 51))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (QREFELT $ 51))
                                          (QREFELT $ 38))
                                         (QREFELT $ 40)))
                                       (PROGN
                                        (LETT #1#
                                              (SEQ
                                               (SPADCALL
                                                "this algebra is not Lie admissible"
                                                (QREFELT $ 44))
                                               (EXIT
                                                (PROGN
                                                 (LETT #2# NIL)
                                                 (GO #6=#:G809)))))
                                        (GO #7=#:G805))))))
                                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                   (EXIT NIL)))
                             #7# (EXIT #1#))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL "this algebra is Lie admissible" (QREFELT $ 44))
                (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |FINAALG-;structuralConstants;VV;10|
        ((|b| (|Vector| S)) ($ (|Vector| (|Matrix| R))))
        (SPROG
         ((#1=#:G832 NIL) (|k| NIL) (|covec| (|Vector| R)) (#2=#:G831 NIL)
          (|j| NIL) (#3=#:G830 NIL) (|i| NIL) (|sC| (|Vector| (|Matrix| R)))
          (#4=#:G827 NIL) (#5=#:G829 NIL) (#6=#:G828 NIL)
          (|m| (|NonNegativeInteger|)) (#7=#:G815 NIL))
         (SEQ
          (LETT |m|
                (PROG1 (LETT #7# (QVSIZE |b|))
                  (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #7#)))
          (LETT |sC|
                (PROGN
                 (LETT #6# (GETREFV |m|))
                 (SEQ (LETT |k| 1) (LETT #5# |m|) (LETT #4# 0) G190
                      (COND ((|greater_SI| |k| #5#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #6# #4#
                                (MAKE_MATRIX1 |m| |m| (|spadConstant| $ 28)))))
                      (LETT #4#
                            (PROG1 (|inc_SI| #4#) (LETT |k| (|inc_SI| |k|))))
                      (GO G190) G191 (EXIT NIL))
                 #6#))
          (SEQ (LETT |i| 1) (LETT #3# |m|) G190
               (COND ((|greater_SI| |i| #3#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #2# |m|) G190
                      (COND ((|greater_SI| |j| #2#) (GO G191)))
                      (SEQ
                       (LETT |covec|
                             (SPADCALL
                              (SPADCALL (SPADCALL |b| |i| (QREFELT $ 36))
                                        (SPADCALL |b| |j| (QREFELT $ 36))
                                        (QREFELT $ 37))
                              |b| (QREFELT $ 54)))
                       (EXIT
                        (SEQ (LETT |k| 1) (LETT #1# |m|) G190
                             (COND ((|greater_SI| |k| #1#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL (SPADCALL |sC| |k| (QREFELT $ 56)) |i|
                                         |j|
                                         (SPADCALL |covec| |k| (QREFELT $ 57))
                                         (QREFELT $ 58))))
                             (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                             (EXIT NIL))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |sC|)))) 

(SDEFUN |FINAALG-;leftRecip;SU;11| ((|x| (S)) ($ (|Union| S "failed")))
        (SPROG
         ((#1=#:G851 NIL) (#2=#:G853 NIL) (|power| NIL) (#3=#:G854 NIL)
          (|i| NIL) (#4=#:G852 NIL) (|invCR| (R)) (|invC| (|Union| R "failed"))
          (|vectorOfCoef| (|Vector| R)) (|cond| (|Matrix| R))
          (|listOfPowers| (|List| S)) (|xx| (S)) (|k| (|PositiveInteger|))
          (|b| (|Vector| S)) (|lu| (|Union| S "failed")))
         (SEQ
          (COND ((SPADCALL |x| (QREFELT $ 40)) (CONS 1 "failed"))
                (#5='T
                 (SEQ (LETT |lu| (SPADCALL (QREFELT $ 60)))
                      (EXIT
                       (COND ((QEQCAR |lu| 1) (CONS 1 "failed"))
                             (#5#
                              (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                                   (LETT |xx| (QCDR |lu|)) (LETT |k| 1)
                                   (LETT |cond|
                                         (SPADCALL
                                          (SPADCALL |xx| |b| (QREFELT $ 54))
                                          (QREFELT $ 61)))
                                   (LETT |listOfPowers| (LIST |xx|))
                                   (SEQ G190
                                        (COND
                                         ((NULL
                                           (EQL
                                            (SPADCALL |cond| (QREFELT $ 62))
                                            |k|))
                                          (GO G191)))
                                        (SEQ (LETT |k| (+ |k| 1))
                                             (LETT |xx|
                                                   (SPADCALL |xx| |x|
                                                             (QREFELT $ 37)))
                                             (LETT |listOfPowers|
                                                   (CONS |xx| |listOfPowers|))
                                             (EXIT
                                              (LETT |cond|
                                                    (SPADCALL |cond|
                                                              (SPADCALL
                                                               (SPADCALL |xx|
                                                                         |b|
                                                                         (QREFELT
                                                                          $
                                                                          54))
                                                               (QREFELT $ 61))
                                                              (QREFELT $
                                                                       63)))))
                                        NIL (GO G190) G191 (EXIT NIL))
                                   (LETT |vectorOfCoef|
                                         (|SPADfirst|
                                          (SPADCALL |cond| (QREFELT $ 65))))
                                   (LETT |invC|
                                         (SPADCALL
                                          (SPADCALL |vectorOfCoef| 1
                                                    (QREFELT $ 57))
                                          (QREFELT $ 48)))
                                   (EXIT
                                    (COND ((QEQCAR |invC| 1) (CONS 1 "failed"))
                                          (#5#
                                           (SEQ
                                            (LETT |invCR|
                                                  (SPADCALL (QCDR |invC|)
                                                            (QREFELT $ 66)))
                                            (EXIT
                                             (CONS 0
                                                   (SPADCALL (ELT $ 38)
                                                             (PROGN
                                                              (LETT #4#
                                                                    (GETREFV
                                                                     (MIN
                                                                      (|inc_SI|
                                                                       (-
                                                                        #6=(QVSIZE
                                                                            |vectorOfCoef|)
                                                                        2))
                                                                      (SIZE
                                                                       #7=(REVERSE
                                                                           |listOfPowers|)))))
                                                              (SEQ (LETT |i| 2)
                                                                   (LETT #3#
                                                                         #6#)
                                                                   (LETT
                                                                    |power|
                                                                    NIL)
                                                                   (LETT #2#
                                                                         #7#)
                                                                   (LETT #1# 0)
                                                                   G190
                                                                   (COND
                                                                    ((OR
                                                                      (ATOM
                                                                       #2#)
                                                                      (PROGN
                                                                       (LETT
                                                                        |power|
                                                                        (CAR
                                                                         #2#))
                                                                       NIL)
                                                                      (|greater_SI|
                                                                       |i|
                                                                       #3#))
                                                                     (GO
                                                                      G191)))
                                                                   (SEQ
                                                                    (EXIT
                                                                     (SETELT
                                                                      #4# #1#
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        |invCR|
                                                                        (SPADCALL
                                                                         |vectorOfCoef|
                                                                         |i|
                                                                         (QREFELT
                                                                          $
                                                                          57))
                                                                        (QREFELT
                                                                         $ 67))
                                                                       |power|
                                                                       (QREFELT
                                                                        $
                                                                        68)))))
                                                                   (LETT #1#
                                                                         (PROG1
                                                                             (|inc_SI|
                                                                              #1#)
                                                                           (LETT
                                                                            #2#
                                                                            (PROG1
                                                                                (CDR
                                                                                 #2#)
                                                                              (LETT
                                                                               |i|
                                                                               (|inc_SI|
                                                                                |i|))))))
                                                                   (GO G190)
                                                                   G191
                                                                   (EXIT NIL))
                                                              #4#)
                                                             (QREFELT $
                                                                      70)))))))))))))))))) 

(SDEFUN |FINAALG-;rightRecip;SU;12| ((|x| (S)) ($ (|Union| S "failed")))
        (SPROG
         ((#1=#:G873 NIL) (#2=#:G875 NIL) (|power| NIL) (#3=#:G876 NIL)
          (|i| NIL) (#4=#:G874 NIL) (|invCR| (R)) (|invC| (|Union| R "failed"))
          (|vectorOfCoef| (|Vector| R)) (|cond| (|Matrix| R))
          (|listOfPowers| (|List| S)) (|xx| (S)) (|k| (|PositiveInteger|))
          (|b| (|Vector| S)) (|ru| (|Union| S "failed")))
         (SEQ
          (COND ((SPADCALL |x| (QREFELT $ 40)) (CONS 1 "failed"))
                (#5='T
                 (SEQ (LETT |ru| (SPADCALL (QREFELT $ 72)))
                      (EXIT
                       (COND ((QEQCAR |ru| 1) (CONS 1 "failed"))
                             (#5#
                              (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                                   (LETT |xx| (QCDR |ru|)) (LETT |k| 1)
                                   (LETT |cond|
                                         (SPADCALL
                                          (SPADCALL |xx| |b| (QREFELT $ 54))
                                          (QREFELT $ 61)))
                                   (LETT |listOfPowers| (LIST |xx|))
                                   (SEQ G190
                                        (COND
                                         ((NULL
                                           (EQL
                                            (SPADCALL |cond| (QREFELT $ 62))
                                            |k|))
                                          (GO G191)))
                                        (SEQ (LETT |k| (+ |k| 1))
                                             (LETT |xx|
                                                   (SPADCALL |x| |xx|
                                                             (QREFELT $ 37)))
                                             (LETT |listOfPowers|
                                                   (CONS |xx| |listOfPowers|))
                                             (EXIT
                                              (LETT |cond|
                                                    (SPADCALL |cond|
                                                              (SPADCALL
                                                               (SPADCALL |xx|
                                                                         |b|
                                                                         (QREFELT
                                                                          $
                                                                          54))
                                                               (QREFELT $ 61))
                                                              (QREFELT $
                                                                       63)))))
                                        NIL (GO G190) G191 (EXIT NIL))
                                   (LETT |vectorOfCoef|
                                         (|SPADfirst|
                                          (SPADCALL |cond| (QREFELT $ 65))))
                                   (LETT |invC|
                                         (SPADCALL
                                          (SPADCALL |vectorOfCoef| 1
                                                    (QREFELT $ 57))
                                          (QREFELT $ 48)))
                                   (EXIT
                                    (COND ((QEQCAR |invC| 1) (CONS 1 "failed"))
                                          (#5#
                                           (SEQ
                                            (LETT |invCR|
                                                  (SPADCALL (QCDR |invC|)
                                                            (QREFELT $ 66)))
                                            (EXIT
                                             (CONS 0
                                                   (SPADCALL (ELT $ 38)
                                                             (PROGN
                                                              (LETT #4#
                                                                    (GETREFV
                                                                     (MIN
                                                                      (|inc_SI|
                                                                       (-
                                                                        #6=(QVSIZE
                                                                            |vectorOfCoef|)
                                                                        2))
                                                                      (SIZE
                                                                       #7=(REVERSE
                                                                           |listOfPowers|)))))
                                                              (SEQ (LETT |i| 2)
                                                                   (LETT #3#
                                                                         #6#)
                                                                   (LETT
                                                                    |power|
                                                                    NIL)
                                                                   (LETT #2#
                                                                         #7#)
                                                                   (LETT #1# 0)
                                                                   G190
                                                                   (COND
                                                                    ((OR
                                                                      (ATOM
                                                                       #2#)
                                                                      (PROGN
                                                                       (LETT
                                                                        |power|
                                                                        (CAR
                                                                         #2#))
                                                                       NIL)
                                                                      (|greater_SI|
                                                                       |i|
                                                                       #3#))
                                                                     (GO
                                                                      G191)))
                                                                   (SEQ
                                                                    (EXIT
                                                                     (SETELT
                                                                      #4# #1#
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        |invCR|
                                                                        (SPADCALL
                                                                         |vectorOfCoef|
                                                                         |i|
                                                                         (QREFELT
                                                                          $
                                                                          57))
                                                                        (QREFELT
                                                                         $ 67))
                                                                       |power|
                                                                       (QREFELT
                                                                        $
                                                                        68)))))
                                                                   (LETT #1#
                                                                         (PROG1
                                                                             (|inc_SI|
                                                                              #1#)
                                                                           (LETT
                                                                            #2#
                                                                            (PROG1
                                                                                (CDR
                                                                                 #2#)
                                                                              (LETT
                                                                               |i|
                                                                               (|inc_SI|
                                                                                |i|))))))
                                                                   (GO G190)
                                                                   G191
                                                                   (EXIT NIL))
                                                              #4#)
                                                             (QREFELT $
                                                                      70)))))))))))))))))) 

(SDEFUN |FINAALG-;recip;SU;13| ((|x| (S)) ($ (|Union| S "failed")))
        (SPROG ((|rrx| (|Union| S "failed")) (|lrx| (|Union| S "failed")))
               (SEQ (LETT |lrx| (SPADCALL |x| (QREFELT $ 74)))
                    (EXIT
                     (COND ((QEQCAR |lrx| 1) (CONS 1 "failed"))
                           ('T
                            (SEQ (LETT |rrx| (SPADCALL |x| (QREFELT $ 75)))
                                 (EXIT
                                  (COND
                                   ((OR (QEQCAR |rrx| 1)
                                        (SPADCALL (QCDR |lrx|) (QCDR |rrx|)
                                                  (QREFELT $ 76)))
                                    (CONS 1 "failed"))
                                   ('T (CONS 0 (QCDR |lrx|)))))))))))) 

(SDEFUN |FINAALG-;leftMinimalPolynomial;SSup;14|
        ((|x| (S)) ($ (|SparseUnivariatePolynomial| R)))
        (SPROG
         ((|res| (|SparseUnivariatePolynomial| R)) (#1=#:G896 NIL) (|i| NIL)
          (|vectorOfCoef| (|Vector| R)) (|cond| (|Matrix| R)) (|xx| (S))
          (|k| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (COND
           ((SPADCALL |x| (QREFELT $ 40))
            (SPADCALL (|spadConstant| $ 21) 1 (QREFELT $ 20)))
           ('T
            (SEQ (LETT |b| (SPADCALL (QREFELT $ 11))) (LETT |xx| |x|)
                 (LETT |k| 1)
                 (LETT |cond|
                       (SPADCALL (SPADCALL |xx| |b| (QREFELT $ 54))
                                 (QREFELT $ 61)))
                 (SEQ G190
                      (COND
                       ((NULL (EQL (SPADCALL |cond| (QREFELT $ 62)) |k|))
                        (GO G191)))
                      (SEQ (LETT |k| (+ |k| 1))
                           (LETT |xx| (SPADCALL |x| |xx| (QREFELT $ 37)))
                           (EXIT
                            (LETT |cond|
                                  (SPADCALL |cond|
                                            (SPADCALL
                                             (SPADCALL |xx| |b| (QREFELT $ 54))
                                             (QREFELT $ 61))
                                            (QREFELT $ 63)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (LETT |vectorOfCoef|
                       (|SPADfirst| (SPADCALL |cond| (QREFELT $ 65))))
                 (LETT |res| (|spadConstant| $ 78))
                 (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT |res|
                              (SPADCALL |res|
                                        (SPADCALL
                                         (SPADCALL |vectorOfCoef| |i|
                                                   (QREFELT $ 57))
                                         |i| (QREFELT $ 20))
                                        (QREFELT $ 79)))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (EXIT |res|))))))) 

(SDEFUN |FINAALG-;rightMinimalPolynomial;SSup;15|
        ((|x| (S)) ($ (|SparseUnivariatePolynomial| R)))
        (SPROG
         ((|res| (|SparseUnivariatePolynomial| R)) (#1=#:G905 NIL) (|i| NIL)
          (|vectorOfCoef| (|Vector| R)) (|cond| (|Matrix| R)) (|xx| (S))
          (|k| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (COND
           ((SPADCALL |x| (QREFELT $ 40))
            (SPADCALL (|spadConstant| $ 21) 1 (QREFELT $ 20)))
           ('T
            (SEQ (LETT |b| (SPADCALL (QREFELT $ 11))) (LETT |xx| |x|)
                 (LETT |k| 1)
                 (LETT |cond|
                       (SPADCALL (SPADCALL |xx| |b| (QREFELT $ 54))
                                 (QREFELT $ 61)))
                 (SEQ G190
                      (COND
                       ((NULL (EQL (SPADCALL |cond| (QREFELT $ 62)) |k|))
                        (GO G191)))
                      (SEQ (LETT |k| (+ |k| 1))
                           (LETT |xx| (SPADCALL |xx| |x| (QREFELT $ 37)))
                           (EXIT
                            (LETT |cond|
                                  (SPADCALL |cond|
                                            (SPADCALL
                                             (SPADCALL |xx| |b| (QREFELT $ 54))
                                             (QREFELT $ 61))
                                            (QREFELT $ 63)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (LETT |vectorOfCoef|
                       (|SPADfirst| (SPADCALL |cond| (QREFELT $ 65))))
                 (LETT |res| (|spadConstant| $ 78))
                 (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT |res|
                              (SPADCALL |res|
                                        (SPADCALL
                                         (SPADCALL |vectorOfCoef| |i|
                                                   (QREFELT $ 57))
                                         |i| (QREFELT $ 20))
                                        (QREFELT $ 79)))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (EXIT |res|))))))) 

(SDEFUN |FINAALG-;associatorDependence;L;16| (($ (|List| (|Vector| R))))
        (SPROG
         ((|z| (|Integer|)) (#1=#:G921 NIL) (|r| NIL) (|a213| #2=(|Vector| R))
          (|a321| #2#) (|a132| #2#) (|a312| #2#) (|a231| #2#) (|a123| #2#)
          (#3=#:G920 NIL) (|k| NIL) (#4=#:G919 NIL) (|j| NIL) (#5=#:G918 NIL)
          (|i| NIL) (|cond| (|Matrix| R)) (|b| (|Vector| S))
          (|n| (|PositiveInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 9)))
              (LETT |b| (SPADCALL (QREFELT $ 11)))
              (LETT |cond| (MAKE_MATRIX1 (EXPT |n| 4) 6 (|spadConstant| $ 28)))
              (LETT |z| 0)
              (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                   (COND ((|greater_SI| |i| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                          (COND ((|greater_SI| |j| #4#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                                 (COND ((|greater_SI| |k| #3#) (GO G191)))
                                 (SEQ
                                  (LETT |a123|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |b| |i| (QREFELT $ 36))
                                          (SPADCALL |b| |j| (QREFELT $ 36))
                                          (SPADCALL |b| |k| (QREFELT $ 36))
                                          (QREFELT $ 82))
                                         |b| (QREFELT $ 54)))
                                  (LETT |a231|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |b| |j| (QREFELT $ 36))
                                          (SPADCALL |b| |k| (QREFELT $ 36))
                                          (SPADCALL |b| |i| (QREFELT $ 36))
                                          (QREFELT $ 82))
                                         |b| (QREFELT $ 54)))
                                  (LETT |a312|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |b| |k| (QREFELT $ 36))
                                          (SPADCALL |b| |i| (QREFELT $ 36))
                                          (SPADCALL |b| |j| (QREFELT $ 36))
                                          (QREFELT $ 82))
                                         |b| (QREFELT $ 54)))
                                  (LETT |a132|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |b| |i| (QREFELT $ 36))
                                          (SPADCALL |b| |k| (QREFELT $ 36))
                                          (SPADCALL |b| |j| (QREFELT $ 36))
                                          (QREFELT $ 82))
                                         |b| (QREFELT $ 54)))
                                  (LETT |a321|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |b| |k| (QREFELT $ 36))
                                          (SPADCALL |b| |j| (QREFELT $ 36))
                                          (SPADCALL |b| |i| (QREFELT $ 36))
                                          (QREFELT $ 82))
                                         |b| (QREFELT $ 54)))
                                  (LETT |a213|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |b| |j| (QREFELT $ 36))
                                          (SPADCALL |b| |i| (QREFELT $ 36))
                                          (SPADCALL |b| |k| (QREFELT $ 36))
                                          (QREFELT $ 82))
                                         |b| (QREFELT $ 54)))
                                  (EXIT
                                   (SEQ (LETT |r| 1) (LETT #1# |n|) G190
                                        (COND
                                         ((|greater_SI| |r| #1#) (GO G191)))
                                        (SEQ (LETT |z| (+ |z| 1))
                                             (SPADCALL |cond| |z| 1
                                                       (SPADCALL |a123| |r|
                                                                 (QREFELT $
                                                                          57))
                                                       (QREFELT $ 58))
                                             (SPADCALL |cond| |z| 2
                                                       (SPADCALL |a231| |r|
                                                                 (QREFELT $
                                                                          57))
                                                       (QREFELT $ 58))
                                             (SPADCALL |cond| |z| 3
                                                       (SPADCALL |a312| |r|
                                                                 (QREFELT $
                                                                          57))
                                                       (QREFELT $ 58))
                                             (SPADCALL |cond| |z| 4
                                                       (SPADCALL |a132| |r|
                                                                 (QREFELT $
                                                                          57))
                                                       (QREFELT $ 58))
                                             (SPADCALL |cond| |z| 5
                                                       (SPADCALL |a321| |r|
                                                                 (QREFELT $
                                                                          57))
                                                       (QREFELT $ 58))
                                             (EXIT
                                              (SPADCALL |cond| |z| 6
                                                        (SPADCALL |a213| |r|
                                                                  (QREFELT $
                                                                           57))
                                                        (QREFELT $ 58))))
                                        (LETT |r| (|inc_SI| |r|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |cond| (QREFELT $ 65)))))) 

(SDEFUN |FINAALG-;jacobiIdentity?;B;17| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G932 NIL) (#2=#:G933 NIL) (#3=#:G936 NIL) (|k| NIL)
          (#4=#:G935 NIL) (|j| NIL) (#5=#:G934 NIL) (|i| NIL)
          (|b| (|Vector| S)) (|n| (|PositiveInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL (QREFELT $ 9)))
                (LETT |b| (SPADCALL (QREFELT $ 11)))
                (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                            (COND ((|greater_SI| |j| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |b| |i| (QREFELT $ 36))
                                             (SPADCALL |b| |j| (QREFELT $ 36))
                                             (QREFELT $ 37))
                                            (SPADCALL |b| |k| (QREFELT $ 36))
                                            (QREFELT $ 37))
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |b| |j| (QREFELT $ 36))
                                             (SPADCALL |b| |k| (QREFELT $ 36))
                                             (QREFELT $ 37))
                                            (SPADCALL |b| |i| (QREFELT $ 36))
                                            (QREFELT $ 37))
                                           (QREFELT $ 38))
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |b| |k| (QREFELT $ 36))
                                            (SPADCALL |b| |i| (QREFELT $ 36))
                                            (QREFELT $ 37))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (QREFELT $ 37))
                                          (QREFELT $ 38))
                                         (QREFELT $ 40)))
                                       (PROGN
                                        (LETT #1#
                                              (SEQ
                                               (SPADCALL
                                                "Jacobi identity does not hold"
                                                (QREFELT $ 44))
                                               (EXIT
                                                (PROGN
                                                 (LETT #2# NIL)
                                                 (GO #6=#:G931)))))
                                        (GO #7=#:G927))))))
                                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                   (EXIT NIL)))
                             #7# (EXIT #1#))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL "Jacobi identity holds" (QREFELT $ 44)) (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |FINAALG-;lieAlgebra?;B;18| (($ (|Boolean|)))
        (SEQ
         (COND
          ((SPADCALL (QREFELT $ 85))
           (COND
            ((SPADCALL (QREFELT $ 86))
             (SEQ (SPADCALL "this is a Lie algebra" (QREFELT $ 44)) (EXIT 'T)))
            (#1='T
             (SEQ (SPADCALL "this is not a Lie algebra" (QREFELT $ 44))
                  (EXIT NIL)))))
          (#1#
           (SEQ (SPADCALL "this is not a Lie algebra" (QREFELT $ 44))
                (EXIT NIL)))))) 

(SDEFUN |FINAALG-;jordanAlgebra?;B;19| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G959 NIL) (#2=#:G960 NIL) (#3=#:G964 NIL) (|l| NIL)
          (#4=#:G963 NIL) (|k| NIL) (#5=#:G962 NIL) (|j| NIL) (#6=#:G961 NIL)
          (|i| NIL) (|n| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (EXIT
                 (COND
                  ((QEQCAR
                    (SPADCALL (SPADCALL 2 (|spadConstant| $ 21) (QREFELT $ 46))
                              (QREFELT $ 48))
                    1)
                   (SEQ
                    (SPADCALL
                     "this is not a Jordan algebra, as 2 is not invertible in the ground ring"
                     (QREFELT $ 44))
                    (EXIT NIL)))
                  ((SPADCALL (QREFELT $ 88))
                   (SEQ
                    (SEQ (LETT |i| 1) (LETT #6# |n|) G190
                         (COND ((|greater_SI| |i| #6#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SEQ (LETT |j| 1) (LETT #5# |n|) G190
                                (COND ((|greater_SI| |j| #5#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SEQ (LETT |k| 1) (LETT #4# |n|) G190
                                       (COND
                                        ((|greater_SI| |k| #4#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (SEQ (LETT |l| 1) (LETT #3# |n|) G190
                                              (COND
                                               ((|greater_SI| |l| #3#)
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (COND
                                                 ((NULL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |b| |i|
                                                                 (QREFELT $
                                                                          36))
                                                       (SPADCALL |b| |j|
                                                                 (QREFELT $
                                                                          36))
                                                       (SPADCALL
                                                        (SPADCALL |b| |l|
                                                                  (QREFELT $
                                                                           36))
                                                        (SPADCALL |b| |k|
                                                                  (QREFELT $
                                                                           36))
                                                        (QREFELT $ 37))
                                                       (QREFELT $ 82))
                                                      (SPADCALL
                                                       (SPADCALL |b| |l|
                                                                 (QREFELT $
                                                                          36))
                                                       (SPADCALL |b| |j|
                                                                 (QREFELT $
                                                                          36))
                                                       (SPADCALL
                                                        (SPADCALL |b| |k|
                                                                  (QREFELT $
                                                                           36))
                                                        (SPADCALL |b| |i|
                                                                  (QREFELT $
                                                                           36))
                                                        (QREFELT $ 37))
                                                       (QREFELT $ 82))
                                                      (QREFELT $ 38))
                                                     (SPADCALL
                                                      (SPADCALL |b| |k|
                                                                (QREFELT $ 36))
                                                      (SPADCALL |b| |j|
                                                                (QREFELT $ 36))
                                                      (SPADCALL
                                                       (SPADCALL |b| |i|
                                                                 (QREFELT $
                                                                          36))
                                                       (SPADCALL |b| |l|
                                                                 (QREFELT $
                                                                          36))
                                                       (QREFELT $ 37))
                                                      (QREFELT $ 82))
                                                     (QREFELT $ 38))
                                                    (QREFELT $ 40)))
                                                  (PROGN
                                                   (LETT #1#
                                                         (SEQ
                                                          (SPADCALL
                                                           "not a Jordan algebra"
                                                           (QREFELT $ 44))
                                                          (EXIT
                                                           (PROGN
                                                            (LETT #2# NIL)
                                                            (GO #7=#:G958)))))
                                                   (GO #8=#:G951))))))
                                              (LETT |l| (|inc_SI| |l|))
                                              (GO G190) G191 (EXIT NIL)))
                                        #8# (EXIT #1#))
                                       (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                       (EXIT NIL))))
                                (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                (EXIT NIL))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (SPADCALL "this is a Jordan algebra" (QREFELT $ 44))
                    (EXIT 'T)))
                  ('T
                   (SEQ
                    (SPADCALL "this is not a Jordan algebra" (QREFELT $ 44))
                    (EXIT NIL)))))))
          #7# (EXIT #2#)))) 

(SDEFUN |FINAALG-;noncommutativeJordanAlgebra?;B;20| (($ (|Boolean|)))
        (SEQ
         (COND
          ((QEQCAR
            (SPADCALL (SPADCALL 2 (|spadConstant| $ 21) (QREFELT $ 46))
                      (QREFELT $ 48))
            1)
           (SEQ
            (SPADCALL
             "this is not a noncommutative Jordan algebra, as 2 is not invertible in the ground ring"
             (QREFELT $ 44))
            (EXIT NIL)))
          ((SPADCALL (QREFELT $ 90))
           (COND
            ((SPADCALL (QREFELT $ 91))
             (SEQ
              (SPADCALL "this is a noncommutative Jordan algebra"
                        (QREFELT $ 44))
              (EXIT 'T)))
            (#1='T
             (SEQ
              (SPADCALL
               "this is not a noncommutative Jordan algebra, as it is not Jordan admissible"
               (QREFELT $ 44))
              (EXIT NIL)))))
          (#1#
           (SEQ
            (SPADCALL
             "this is not a noncommutative Jordan algebra, as it is not flexible"
             (QREFELT $ 44))
            (EXIT NIL)))))) 

(SDEFUN |FINAALG-;antiCommutative?;B;21| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G982 NIL) (#2=#:G983 NIL) (#3=#:G985 NIL) (|j| NIL)
          (#4=#:G984 NIL) (|i| NIL) (|n| (|PositiveInteger|))
          (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (SEQ (LETT |i| 1) (LETT #4# |n|) G190
                     (COND ((|greater_SI| |i| #4#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| |i|) (LETT #3# |n|) G190
                            (COND ((> |j| #3#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((NULL
                                 (SPADCALL
                                  (COND
                                   ((EQL |i| |j|)
                                    (SPADCALL (SPADCALL |b| |i| (QREFELT $ 36))
                                              (SPADCALL |b| |i| (QREFELT $ 36))
                                              (QREFELT $ 37)))
                                   ('T
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL |b| |i| (QREFELT $ 36))
                                      (SPADCALL |b| |j| (QREFELT $ 36))
                                      (QREFELT $ 37))
                                     (SPADCALL
                                      (SPADCALL |b| |j| (QREFELT $ 36))
                                      (SPADCALL |b| |i| (QREFELT $ 36))
                                      (QREFELT $ 37))
                                     (QREFELT $ 38))))
                                  (QREFELT $ 40)))
                                (PROGN
                                 (LETT #1#
                                       (SEQ
                                        (SPADCALL
                                         "algebra is not anti-commutative"
                                         (QREFELT $ 44))
                                        (EXIT
                                         (PROGN
                                          (LETT #2# NIL)
                                          (GO #5=#:G981)))))
                                 (GO #6=#:G978))))))
                            (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                      #6# (EXIT #1#))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL "algebra is anti-commutative" (QREFELT $ 44))
                (EXIT 'T)))
          #5# (EXIT #2#)))) 

(SDEFUN |FINAALG-;commutative?;B;22| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G994 NIL) (#2=#:G995 NIL) (#3=#:G997 NIL) (|j| NIL)
          (#4=#:G996 NIL) (|i| NIL) (|n| (|PositiveInteger|))
          (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (SEQ (LETT |i| 1) (LETT #4# |n|) G190
                     (COND ((|greater_SI| |i| #4#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| (+ |i| 1)) (LETT #3# |n|) G190
                            (COND ((> |j| #3#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((NULL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |b| |i| (QREFELT $ 36))
                                            (SPADCALL |b| |j| (QREFELT $ 36))
                                            (QREFELT $ 51))
                                  (QREFELT $ 40)))
                                (PROGN
                                 (LETT #1#
                                       (SEQ
                                        (SPADCALL "algebra is not commutative"
                                                  (QREFELT $ 44))
                                        (EXIT
                                         (PROGN
                                          (LETT #2# NIL)
                                          (GO #5=#:G993)))))
                                 (GO #6=#:G990))))))
                            (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                      #6# (EXIT #1#))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL "algebra is commutative" (QREFELT $ 44)) (EXIT 'T)))
          #5# (EXIT #2#)))) 

(SDEFUN |FINAALG-;associative?;B;23| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G1008 NIL) (#2=#:G1009 NIL) (#3=#:G1012 NIL) (|k| NIL)
          (#4=#:G1011 NIL) (|j| NIL) (#5=#:G1010 NIL) (|i| NIL)
          (|n| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                            (COND ((|greater_SI| |j| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |b| |i| (QREFELT $ 36))
                                          (SPADCALL |b| |j| (QREFELT $ 36))
                                          (SPADCALL |b| |k| (QREFELT $ 36))
                                          (QREFELT $ 82))
                                         (QREFELT $ 40)))
                                       (PROGN
                                        (LETT #1#
                                              (SEQ
                                               (SPADCALL
                                                "algebra is not associative"
                                                (QREFELT $ 44))
                                               (EXIT
                                                (PROGN
                                                 (LETT #2# NIL)
                                                 (GO #6=#:G1007)))))
                                        (GO #7=#:G1003))))))
                                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                   (EXIT NIL)))
                             #7# (EXIT #1#))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL "algebra is associative" (QREFELT $ 44)) (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |FINAALG-;leftAlternative?;B;24| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G1023 NIL) (#2=#:G1024 NIL) (#3=#:G1027 NIL) (|k| NIL)
          (#4=#:G1026 NIL) (|j| NIL) (#5=#:G1025 NIL) (|i| NIL)
          (|n| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                            (COND ((|greater_SI| |j| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (SPADCALL
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (QREFELT $ 38))
                                         (QREFELT $ 40)))
                                       (PROGN
                                        (LETT #1#
                                              (SEQ
                                               (SPADCALL
                                                "algebra is not left alternative"
                                                (QREFELT $ 44))
                                               (EXIT
                                                (PROGN
                                                 (LETT #2# NIL)
                                                 (GO #6=#:G1022)))))
                                        (GO #7=#:G1018))))))
                                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                   (EXIT NIL)))
                             #7# (EXIT #1#))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL "algebra satisfies 2*associator(a,a,b) = 0"
                          (QREFELT $ 44))
                (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |FINAALG-;rightAlternative?;B;25| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G1038 NIL) (#2=#:G1039 NIL) (#3=#:G1042 NIL) (|k| NIL)
          (#4=#:G1041 NIL) (|j| NIL) (#5=#:G1040 NIL) (|i| NIL)
          (|n| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                            (COND ((|greater_SI| |j| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (SPADCALL
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (QREFELT $ 38))
                                         (QREFELT $ 40)))
                                       (PROGN
                                        (LETT #1#
                                              (SEQ
                                               (SPADCALL
                                                "algebra is not right alternative"
                                                (QREFELT $ 44))
                                               (EXIT
                                                (PROGN
                                                 (LETT #2# NIL)
                                                 (GO #6=#:G1037)))))
                                        (GO #7=#:G1033))))))
                                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                   (EXIT NIL)))
                             #7# (EXIT #1#))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL "algebra satisfies 2*associator(a,b,b) = 0"
                          (QREFELT $ 44))
                (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |FINAALG-;flexible?;B;26| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G1053 NIL) (#2=#:G1054 NIL) (#3=#:G1057 NIL) (|k| NIL)
          (#4=#:G1056 NIL) (|j| NIL) (#5=#:G1055 NIL) (|i| NIL)
          (|n| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                            (COND ((|greater_SI| |j| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (SPADCALL
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (QREFELT $ 38))
                                         (QREFELT $ 40)))
                                       (PROGN
                                        (LETT #1#
                                              (SEQ
                                               (SPADCALL
                                                "algebra is not flexible"
                                                (QREFELT $ 44))
                                               (EXIT
                                                (PROGN
                                                 (LETT #2# NIL)
                                                 (GO #6=#:G1052)))))
                                        (GO #7=#:G1048))))))
                                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                   (EXIT NIL)))
                             #7# (EXIT #1#))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL "algebra satisfies 2*associator(a,b,a) = 0"
                          (QREFELT $ 44))
                (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |FINAALG-;alternative?;B;27| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G1070 NIL) (#2=#:G1071 NIL) (#3=#:G1074 NIL) (|k| NIL)
          (#4=#:G1073 NIL) (|j| NIL) (#5=#:G1072 NIL) (|i| NIL)
          (|n| (|PositiveInteger|)) (|b| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |b| (SPADCALL (QREFELT $ 11)))
                (LETT |n| (SPADCALL (QREFELT $ 9)))
                (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #4# |n|) G190
                            (COND ((|greater_SI| |j| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (SPADCALL
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (QREFELT $ 38))
                                         (QREFELT $ 40)))
                                       (SEQ
                                        (SPADCALL "algebra is not alternative"
                                                  (QREFELT $ 44))
                                        (EXIT
                                         (PROGN
                                          (LETT #2# NIL)
                                          (GO #6=#:G1069)))))
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (SPADCALL
                                           (SPADCALL |b| |i| (QREFELT $ 36))
                                           (SPADCALL |b| |k| (QREFELT $ 36))
                                           (SPADCALL |b| |j| (QREFELT $ 36))
                                           (QREFELT $ 82))
                                          (QREFELT $ 38))
                                         (QREFELT $ 40)))
                                       (PROGN
                                        (LETT #1#
                                              (SEQ
                                               (SPADCALL
                                                "algebra is not alternative"
                                                (QREFELT $ 44))
                                               (EXIT
                                                (PROGN
                                                 (LETT #2# NIL)
                                                 (GO #6#)))))
                                        (GO #7=#:G1064)))))
                                    #7# (EXIT #1#))
                                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                   (EXIT NIL))))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (SPADCALL
                 "algebra satisfies 2*associator(a,b,b) = 0 =  2*associator(a,a,b) = 0"
                 (QREFELT $ 44))
                (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |FINAALG-;leftDiscriminant;VR;28| ((|v| (|Vector| S)) ($ (R)))
        (SPADCALL (SPADCALL |v| (QREFELT $ 100)) (QREFELT $ 32))) 

(SDEFUN |FINAALG-;rightDiscriminant;VR;29| ((|v| (|Vector| S)) ($ (R)))
        (SPADCALL (SPADCALL |v| (QREFELT $ 102)) (QREFELT $ 32))) 

(SDEFUN |FINAALG-;coordinates;2VM;30|
        ((|v| (|Vector| S)) (|b| (|Vector| S)) ($ (|Matrix| R)))
        (SPROG ((#1=#:G1081 NIL) (|i| NIL) (|j| NIL) (|m| (|Matrix| R)))
               (SEQ
                (LETT |m|
                      (MAKE_MATRIX1 (QVSIZE |v|) (QVSIZE |b|)
                                    (|spadConstant| $ 28)))
                (SEQ (LETT |j| (PROGN |m| 1))
                     (LETT |i| (SPADCALL |v| (QREFELT $ 104)))
                     (LETT #1# (QVSIZE |v|)) G190
                     (COND ((> |i| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |m| |j|
                                 (SPADCALL (QAREF1O |v| |i| 1) |b|
                                           (QREFELT $ 54))
                                 (QREFELT $ 105))))
                     (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT |m|)))) 

(SDEFUN |FINAALG-;represents;VVS;31|
        ((|v| (|Vector| R)) (|b| (|Vector| S)) ($ (S)))
        (SPROG
         ((#1=#:G1088 NIL) (#2=#:G1090 NIL) (|i| NIL) (#3=#:G1089 NIL)
          (|m| (|Integer|)))
         (SEQ (LETT |m| (- (SPADCALL |v| (QREFELT $ 107)) 1))
              (EXIT
               (SPADCALL (ELT $ 38)
                         (PROGN
                          (LETT #3# (GETREFV #4=(QVSIZE |b|)))
                          (SEQ (LETT |i| 1) (LETT #2# #4#) (LETT #1# 0) G190
                               (COND ((|greater_SI| |i| #2#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (SETELT #3# #1#
                                         (SPADCALL
                                          (SPADCALL |v| (+ |i| |m|)
                                                    (QREFELT $ 57))
                                          (SPADCALL |b| (+ |i| |m|)
                                                    (QREFELT $ 36))
                                          (QREFELT $ 68)))))
                               (LETT #1#
                                     (PROG1 (|inc_SI| #1#)
                                       (LETT |i| (|inc_SI| |i|))))
                               (GO G190) G191 (EXIT NIL))
                          #3#)
                         (QREFELT $ 70)))))) 

(SDEFUN |FINAALG-;leftTraceMatrix;VM;32| ((|v| (|Vector| S)) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G1099 NIL) (|j| NIL) (#2=#:G1098 NIL) (#3=#:G1097 NIL)
          (|i| NIL) (#4=#:G1096 NIL))
         (SEQ
          (SPADCALL
           (PROGN
            (LETT #4# NIL)
            (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 104)))
                 (LETT #3# (QVSIZE |v|)) G190 (COND ((> |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #4#
                         (CONS
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |j| (SPADCALL |v| (QREFELT $ 104)))
                                (LETT #1# (QVSIZE |v|)) G190
                                (COND ((> |j| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |v| |i| (QREFELT $ 36))
                                           (SPADCALL |v| |j| (QREFELT $ 36))
                                           (QREFELT $ 37))
                                          (QREFELT $ 109))
                                         #2#))))
                                (LETT |j| (+ |j| 1)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          #4#))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT (NREVERSE #4#))))
           (QREFELT $ 111))))) 

(SDEFUN |FINAALG-;rightTraceMatrix;VM;33| ((|v| (|Vector| S)) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G1108 NIL) (|j| NIL) (#2=#:G1107 NIL) (#3=#:G1106 NIL)
          (|i| NIL) (#4=#:G1105 NIL))
         (SEQ
          (SPADCALL
           (PROGN
            (LETT #4# NIL)
            (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 104)))
                 (LETT #3# (QVSIZE |v|)) G190 (COND ((> |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #4#
                         (CONS
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |j| (SPADCALL |v| (QREFELT $ 104)))
                                (LETT #1# (QVSIZE |v|)) G190
                                (COND ((> |j| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |v| |i| (QREFELT $ 36))
                                           (SPADCALL |v| |j| (QREFELT $ 36))
                                           (QREFELT $ 37))
                                          (QREFELT $ 113))
                                         #2#))))
                                (LETT |j| (+ |j| 1)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          #4#))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT (NREVERSE #4#))))
           (QREFELT $ 111))))) 

(SDEFUN |FINAALG-;leftRegularRepresentation;SVM;34|
        ((|x| (S)) (|b| (|Vector| S)) ($ (|Matrix| R)))
        (SPROG ((#1=#:G1116 NIL) (|i| NIL) (#2=#:G1115 NIL) (|m| (|Integer|)))
               (SEQ (LETT |m| (- (SPADCALL |b| (QREFELT $ 104)) 1))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |i| 1) (LETT #1# (SPADCALL (QREFELT $ 9)))
                             G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |x|
                                                  (SPADCALL |b| (+ |i| |m|)
                                                            (QREFELT $ 36))
                                                  (QREFELT $ 37))
                                        |b| (QREFELT $ 54))
                                       (QREFELT $ 116))
                                      #2#))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))
                       (QREFELT $ 111))
                      (QREFELT $ 117)))))) 

(SDEFUN |FINAALG-;rightRegularRepresentation;SVM;35|
        ((|x| (S)) (|b| (|Vector| S)) ($ (|Matrix| R)))
        (SPROG ((#1=#:G1124 NIL) (|i| NIL) (#2=#:G1123 NIL) (|m| (|Integer|)))
               (SEQ (LETT |m| (- (SPADCALL |b| (QREFELT $ 104)) 1))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |i| 1) (LETT #1# (SPADCALL (QREFELT $ 9)))
                             G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |b| (+ |i| |m|)
                                                   (QREFELT $ 36))
                                         |x| (QREFELT $ 37))
                                        |b| (QREFELT $ 54))
                                       (QREFELT $ 116))
                                      #2#))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))
                       (QREFELT $ 111))
                      (QREFELT $ 117)))))) 

(DECLAIM (NOTINLINE |FiniteRankNonAssociativeAlgebra&;|)) 

(DEFUN |FiniteRankNonAssociativeAlgebra&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FiniteRankNonAssociativeAlgebra&| DV$1 DV$2))
          (LETT $ (GETREFV 120))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|IntegralDomain|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| (|SparseUnivariatePolynomial| |#2|)
                           '(|CommutativeRing|))
            (PROGN
             (QSETREFV $ 25
                       (CONS
                        (|dispatchFunction|
                         |FINAALG-;leftCharacteristicPolynomial;SSup;1|)
                        $))
             (QSETREFV $ 27
                       (CONS
                        (|dispatchFunction|
                         |FINAALG-;rightCharacteristicPolynomial;SSup;2|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 71
                       (CONS (|dispatchFunction| |FINAALG-;leftRecip;SU;11|)
                             $))
             (QSETREFV $ 73
                       (CONS (|dispatchFunction| |FINAALG-;rightRecip;SU;12|)
                             $))
             (QSETREFV $ 77
                       (CONS (|dispatchFunction| |FINAALG-;recip;SU;13|) $))
             (QSETREFV $ 80
                       (CONS
                        (|dispatchFunction|
                         |FINAALG-;leftMinimalPolynomial;SSup;14|)
                        $))
             (QSETREFV $ 81
                       (CONS
                        (|dispatchFunction|
                         |FINAALG-;rightMinimalPolynomial;SSup;15|)
                        $))
             (QSETREFV $ 83
                       (CONS
                        (|dispatchFunction|
                         |FINAALG-;associatorDependence;L;16|)
                        $)))))
          $))) 

(MAKEPROP '|FiniteRankNonAssociativeAlgebra&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|PositiveInteger|) (0 . |rank|) (|Vector| $) (4 . |someBasis|)
              (|Matrix| 7) (8 . |leftRegularRepresentation|)
              (|NonNegativeInteger|) (|Matrix| 19) (14 . |zero|) (|Integer|)
              (20 . |elt|) (|SparseUnivariatePolynomial| 7) (27 . |monomial|)
              (33 . |One|) (37 . -) (43 . |setelt!|) (51 . |determinant|)
              (56 . |leftCharacteristicPolynomial|)
              (61 . |rightRegularRepresentation|)
              (67 . |rightCharacteristicPolynomial|) (72 . |Zero|) (76 . +)
              |FINAALG-;leftTrace;SR;3| |FINAALG-;rightTrace;SR;4|
              (82 . |determinant|) |FINAALG-;leftNorm;SR;5|
              |FINAALG-;rightNorm;SR;6| (|Vector| 6) (87 . |elt|) (93 . *)
              (99 . +) (|Boolean|) (105 . |zero?|) (|Void|) (|String|)
              (|OutputForm|) (110 . |messagePrint|)
              |FINAALG-;antiAssociative?;B;7| (115 . *) (|Union| $ '"failed")
              (121 . |recip|) (126 . |antiCommutator|)
              |FINAALG-;jordanAdmissible?;B;8| (132 . |commutator|)
              |FINAALG-;lieAdmissible?;B;9| (|Vector| 7) (138 . |coordinates|)
              (|Vector| 12) (144 . |elt|) (150 . |elt|) (156 . |setelt!|)
              |FINAALG-;structuralConstants;VV;10| (164 . |leftUnit|)
              (168 . |coerce|) (173 . |rank|) (178 . |horizConcat|) (|List| 53)
              (184 . |nullSpace|) (189 . -) (194 . *) (200 . *)
              (|Mapping| 6 6 6) (206 . |reduce|) (212 . |leftRecip|)
              (217 . |rightUnit|) (221 . |rightRecip|) (226 . |leftRecip|)
              (231 . |rightRecip|) (236 . ~=) (242 . |recip|) (247 . |Zero|)
              (251 . +) (257 . |leftMinimalPolynomial|)
              (262 . |rightMinimalPolynomial|) (267 . |associator|)
              (274 . |associatorDependence|) |FINAALG-;jacobiIdentity?;B;17|
              (278 . |antiCommutative?|) (282 . |jacobiIdentity?|)
              |FINAALG-;lieAlgebra?;B;18| (286 . |commutative?|)
              |FINAALG-;jordanAlgebra?;B;19| (290 . |flexible?|)
              (294 . |jordanAdmissible?|)
              |FINAALG-;noncommutativeJordanAlgebra?;B;20|
              |FINAALG-;antiCommutative?;B;21| |FINAALG-;commutative?;B;22|
              |FINAALG-;associative?;B;23| |FINAALG-;leftAlternative?;B;24|
              |FINAALG-;rightAlternative?;B;25| |FINAALG-;flexible?;B;26|
              |FINAALG-;alternative?;B;27| (298 . |leftTraceMatrix|)
              |FINAALG-;leftDiscriminant;VR;28| (303 . |rightTraceMatrix|)
              |FINAALG-;rightDiscriminant;VR;29| (308 . |minIndex|)
              (313 . |setRow!|) |FINAALG-;coordinates;2VM;30|
              (320 . |minIndex|) |FINAALG-;represents;VVS;31|
              (325 . |leftTrace|) (|List| 115) (330 . |matrix|)
              |FINAALG-;leftTraceMatrix;VM;32| (335 . |rightTrace|)
              |FINAALG-;rightTraceMatrix;VM;33| (|List| 7) (340 . |parts|)
              (345 . |transpose|) |FINAALG-;leftRegularRepresentation;SVM;34|
              |FINAALG-;rightRegularRepresentation;SVM;35|)
           '#(|structuralConstants| 350 |rightTraceMatrix| 355 |rightTrace| 360
              |rightRegularRepresentation| 365 |rightRecip| 371 |rightNorm| 376
              |rightMinimalPolynomial| 381 |rightDiscriminant| 386
              |rightCharacteristicPolynomial| 391 |rightAlternative?| 396
              |represents| 400 |recip| 406 |noncommutativeJordanAlgebra?| 411
              |lieAlgebra?| 415 |lieAdmissible?| 419 |leftTraceMatrix| 423
              |leftTrace| 428 |leftRegularRepresentation| 433 |leftRecip| 439
              |leftNorm| 444 |leftMinimalPolynomial| 449 |leftDiscriminant| 454
              |leftCharacteristicPolynomial| 459 |leftAlternative?| 464
              |jordanAlgebra?| 468 |jordanAdmissible?| 472 |jacobiIdentity?|
              476 |flexible?| 480 |coordinates| 484 |commutative?| 490
              |associatorDependence| 494 |associative?| 498 |antiCommutative?|
              502 |antiAssociative?| 506 |alternative?| 510)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rightMinimalPolynomial|
                                 ((|SparseUnivariatePolynomial| |#2|) |#1|))
                                T)
                              '((|leftMinimalPolynomial|
                                 ((|SparseUnivariatePolynomial| |#2|) |#1|))
                                T)
                              '((|associatorDependence|
                                 ((|List| (|Vector| |#2|))))
                                T)
                              '((|rightRecip| ((|Union| |#1| "failed") |#1|))
                                T)
                              '((|leftRecip| ((|Union| |#1| "failed") |#1|)) T)
                              '((|recip| ((|Union| |#1| "failed") |#1|)) T)
                              '((|lieAlgebra?| ((|Boolean|))) T)
                              '((|jordanAlgebra?| ((|Boolean|))) T)
                              '((|noncommutativeJordanAlgebra?| ((|Boolean|)))
                                T)
                              '((|jordanAdmissible?| ((|Boolean|))) T)
                              '((|lieAdmissible?| ((|Boolean|))) T)
                              '((|jacobiIdentity?| ((|Boolean|))) T)
                              '((|alternative?| ((|Boolean|))) T)
                              '((|flexible?| ((|Boolean|))) T)
                              '((|rightAlternative?| ((|Boolean|))) T)
                              '((|leftAlternative?| ((|Boolean|))) T)
                              '((|antiAssociative?| ((|Boolean|))) T)
                              '((|associative?| ((|Boolean|))) T)
                              '((|antiCommutative?| ((|Boolean|))) T)
                              '((|commutative?| ((|Boolean|))) T)
                              '((|rightCharacteristicPolynomial|
                                 ((|SparseUnivariatePolynomial| |#2|) |#1|))
                                T)
                              '((|leftCharacteristicPolynomial|
                                 ((|SparseUnivariatePolynomial| |#2|) |#1|))
                                T)
                              '((|rightTraceMatrix|
                                 ((|Matrix| |#2|) (|Vector| |#1|)))
                                T)
                              '((|leftTraceMatrix|
                                 ((|Matrix| |#2|) (|Vector| |#1|)))
                                T)
                              '((|rightDiscriminant| (|#2| (|Vector| |#1|))) T)
                              '((|leftDiscriminant| (|#2| (|Vector| |#1|))) T)
                              '((|represents|
                                 (|#1| (|Vector| |#2|) (|Vector| |#1|)))
                                T)
                              '((|coordinates|
                                 ((|Matrix| |#2|) (|Vector| |#1|)
                                  (|Vector| |#1|)))
                                T)
                              '((|coordinates|
                                 ((|Vector| |#2|) |#1| (|Vector| |#1|)))
                                T)
                              '((|rightNorm| (|#2| |#1|)) T)
                              '((|leftNorm| (|#2| |#1|)) T)
                              '((|rightTrace| (|#2| |#1|)) T)
                              '((|leftTrace| (|#2| |#1|)) T)
                              '((|rightRegularRepresentation|
                                 ((|Matrix| |#2|) |#1| (|Vector| |#1|)))
                                T)
                              '((|leftRegularRepresentation|
                                 ((|Matrix| |#2|) |#1| (|Vector| |#1|)))
                                T)
                              '((|structuralConstants|
                                 ((|Vector| (|Matrix| |#2|)) (|Vector| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 119
                                            '(0 6 8 9 0 6 10 11 2 6 12 0 10 13
                                              2 15 0 14 14 16 3 12 7 0 17 17 18
                                              2 19 0 7 14 20 0 7 0 21 2 19 0 0
                                              0 22 4 15 19 0 17 17 19 23 1 15
                                              19 0 24 1 0 19 0 25 2 6 12 0 10
                                              26 1 0 19 0 27 0 7 0 28 2 7 0 0 0
                                              29 1 12 7 0 32 2 35 6 0 17 36 2 6
                                              0 0 0 37 2 6 0 0 0 38 1 6 39 0 40
                                              1 43 41 42 44 2 7 0 8 0 46 1 7 47
                                              0 48 2 6 0 0 0 49 2 6 0 0 0 51 2
                                              6 53 0 10 54 2 55 12 0 17 56 2 53
                                              7 0 17 57 4 12 7 0 17 17 7 58 0 6
                                              47 60 1 12 0 53 61 1 12 14 0 62 2
                                              12 0 0 0 63 1 12 64 0 65 1 7 0 0
                                              66 2 7 0 0 0 67 2 6 0 7 0 68 2 35
                                              6 69 0 70 1 0 47 0 71 0 6 47 72 1
                                              0 47 0 73 1 6 47 0 74 1 6 47 0 75
                                              2 6 39 0 0 76 1 0 47 0 77 0 19 0
                                              78 2 19 0 0 0 79 1 0 19 0 80 1 0
                                              19 0 81 3 6 0 0 0 0 82 0 0 64 83
                                              0 6 39 85 0 6 39 86 0 6 39 88 0 6
                                              39 90 0 6 39 91 1 6 12 10 100 1 6
                                              12 10 102 1 35 17 0 104 3 12 0 0
                                              17 53 105 1 53 17 0 107 1 6 7 0
                                              109 1 12 0 110 111 1 6 7 0 113 1
                                              53 115 0 116 1 12 0 0 117 1 0 55
                                              10 59 1 0 12 10 114 1 0 7 0 31 2
                                              0 12 0 10 119 1 0 47 0 73 1 0 7 0
                                              34 1 0 19 0 81 1 0 7 10 103 1 0
                                              19 0 27 0 0 39 97 2 0 0 53 10 108
                                              1 0 47 0 77 0 0 39 92 0 0 39 87 0
                                              0 39 52 1 0 12 10 112 1 0 7 0 30
                                              2 0 12 0 10 118 1 0 47 0 71 1 0 7
                                              0 33 1 0 19 0 80 1 0 7 10 101 1 0
                                              19 0 25 0 0 39 96 0 0 39 89 0 0
                                              39 50 0 0 39 84 0 0 39 98 2 0 12
                                              10 10 106 0 0 39 94 0 0 64 83 0 0
                                              39 95 0 0 39 93 0 0 39 45 0 0 39
                                              99)))))
           '|lookupComplete|)) 

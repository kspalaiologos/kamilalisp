
(SDEFUN |RECLOS;relativeApprox;2$F;1|
        ((|nbe| ($)) (|prec| ($)) ($ (|Fraction| (|Integer|))))
        (SPROG ((|appr| ($)))
               (SEQ
                (COND ((QEQCAR |nbe| 0) (SPADCALL |nbe| (QREFELT $ 14)))
                      ('T
                       (SEQ
                        (LETT |appr|
                              (SPADCALL (QVELT (QCDR |nbe|) 1)
                                        (QVELT (QCDR |nbe|) 0) |prec|
                                        (QREFELT $ 17)))
                        (EXIT (SPADCALL |appr| |prec| (QREFELT $ 18))))))))) 

(SDEFUN |RECLOS;approximate;2$F;2|
        ((|nbe| ($)) (|prec| ($)) ($ (|Fraction| (|Integer|))))
        (SPROG ((|appr| ($)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |nbe| (QREFELT $ 19)) |prec|
                            (QREFELT $ 21))
                  (|spadConstant| $ 22))
                 ((QEQCAR |nbe| 0) (SPADCALL |nbe| (QREFELT $ 14)))
                 ('T
                  (SEQ
                   (LETT |appr|
                         (SPADCALL (QVELT (QCDR |nbe|) 1)
                                   (QVELT (QCDR |nbe|) 0) |prec|
                                   (QREFELT $ 23)))
                   (EXIT (SPADCALL |appr| |prec| (QREFELT $ 24))))))))) 

(SDEFUN |RECLOS;newElementIfneeded|
        ((|s|
          (|RightOpenIntervalRootCharacterization| $
                                                   (|SparseUnivariatePolynomial|
                                                    $)))
         (|o| (|OutputForm|)) ($ ($)))
        (SPROG ((|res| (|Rec|)) (|p| (|SparseUnivariatePolynomial| $)))
               (SEQ (LETT |p| (SPADCALL |s| (QREFELT $ 25)))
                    (EXIT
                     (COND
                      ((EQL (SPADCALL |p| (QREFELT $ 27)) 1)
                       (SPADCALL
                        (SPADCALL (SPADCALL |p| 0 (QREFELT $ 30))
                                  (SPADCALL |p| (QREFELT $ 31)) (QREFELT $ 32))
                        (QREFELT $ 33)))
                      ('T
                       (SEQ
                        (LETT |res|
                              (VECTOR |s|
                                      (SPADCALL (|spadConstant| $ 34) 1
                                                (QREFELT $ 36))
                                      |o| (QREFELT $ 9)))
                        (SETELT $ 9 (+ (QREFELT $ 9) 1))
                        (EXIT (CONS 1 |res|))))))))) 

(SDEFUN |RECLOS;algebraicOf;RoircOf$;4|
        ((|s|
          (|RightOpenIntervalRootCharacterization| $
                                                   (|SparseUnivariatePolynomial|
                                                    $)))
         (|o| (|OutputForm|)) ($ ($)))
        (SPROG ((|res| (|Rec|)) (|pol| (|SparseUnivariatePolynomial| $)))
               (SEQ (LETT |pol| (SPADCALL |s| (QREFELT $ 25)))
                    (EXIT
                     (COND
                      ((EQL (SPADCALL |pol| (QREFELT $ 27)) 1)
                       (SPADCALL
                        (SPADCALL (SPADCALL |pol| 0 (QREFELT $ 30))
                                  (SPADCALL |pol| (QREFELT $ 31))
                                  (QREFELT $ 32))
                        (QREFELT $ 33)))
                      ('T
                       (SEQ
                        (LETT |res|
                              (VECTOR |s|
                                      (SPADCALL (|spadConstant| $ 34) 1
                                                (QREFELT $ 36))
                                      |o| (QREFELT $ 9)))
                        (SETELT $ 9 (+ (QREFELT $ 9) 1))
                        (EXIT (CONS 1 |res|))))))))) 

(SDEFUN |RECLOS;rename!;$Of$;5| ((|x| ($)) (|o| (|OutputForm|)) ($ ($)))
        (SEQ (QSETVELT (QCDR |x|) 2 |o|) (EXIT |x|))) 

(SDEFUN |RECLOS;rename;$Of$;6| ((|x| ($)) (|o| (|OutputForm|)) ($ ($)))
        (CONS 1
              (VECTOR (QVELT (QCDR |x|) 0) (QVELT (QCDR |x|) 1) |o|
                      (QVELT (QCDR |x|) 3)))) 

(SDEFUN |RECLOS;rootOf;SupPiU;7|
        ((|pol| (|SparseUnivariatePolynomial| $)) (|n| (|PositiveInteger|))
         ($ (|Union| $ "failed")))
        (SPROG
         ((|o| (|OutputForm|))
          (|r|
           (|Union|
            (|RightOpenIntervalRootCharacterization| $
                                                     (|SparseUnivariatePolynomial|
                                                      $))
            "failed")))
         (SEQ
          (COND ((EQL (SPADCALL |pol| (QREFELT $ 27)) 0) (CONS 1 "failed"))
                ((EQL (SPADCALL |pol| (QREFELT $ 27)) 1)
                 (COND
                  ((EQL |n| 1)
                   (CONS 0
                         (SPADCALL
                          (SPADCALL (SPADCALL |pol| 0 (QREFELT $ 30))
                                    (SPADCALL |pol| (QREFELT $ 31))
                                    (QREFELT $ 32))
                          (QREFELT $ 33))))
                  (#1='T (CONS 1 "failed"))))
                (#1#
                 (SEQ (LETT |r| (SPADCALL |pol| |n| (QREFELT $ 44)))
                      (EXIT
                       (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                             (#1#
                              (SEQ
                               (LETT |o|
                                     (SPADCALL
                                      (SPADCALL (QREFELT $ 12) (QREFELT $ 45))
                                      (SPADCALL (QREFELT $ 9) (QREFELT $ 46))
                                      (QREFELT $ 47)))
                               (EXIT
                                (CONS 0
                                      (SPADCALL (QCDR |r|) |o|
                                                (QREFELT $ 39)))))))))))))) 

(SDEFUN |RECLOS;allRootsOf;SupL;8|
        ((|pol| (|SparseUnivariatePolynomial| $)) ($ (|List| $)))
        (SPROG
         ((|res| (|List| $)) (|o| (|OutputForm|)) (#1=#:G790 NIL) (|term| NIL)
          (|liste|
           (|List|
            (|RightOpenIntervalRootCharacterization| $
                                                     (|SparseUnivariatePolynomial|
                                                      $)))))
         (SEQ
          (COND ((EQL (SPADCALL |pol| (QREFELT $ 27)) 0) NIL)
                ((EQL (SPADCALL |pol| (QREFELT $ 27)) 1)
                 (LIST
                  (SPADCALL
                   (SPADCALL (SPADCALL |pol| 0 (QREFELT $ 30))
                             (SPADCALL |pol| (QREFELT $ 31)) (QREFELT $ 32))
                   (QREFELT $ 33))))
                ('T
                 (SEQ (LETT |liste| (SPADCALL |pol| (QREFELT $ 51)))
                      (LETT |res| NIL)
                      (SEQ (LETT |term| NIL) (LETT #1# |liste|) G190
                           (COND
                            ((OR (ATOM #1#)
                                 (PROGN (LETT |term| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |o|
                                  (SPADCALL
                                   (SPADCALL (QREFELT $ 12) (QREFELT $ 45))
                                   (SPADCALL (QREFELT $ 9) (QREFELT $ 46))
                                   (QREFELT $ 47)))
                            (EXIT
                             (LETT |res|
                                   (SPADCALL
                                    (SPADCALL |term| |o| (QREFELT $ 39)) |res|
                                    (QREFELT $ 53)))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (SPADCALL |res| (QREFELT $ 54))))))))) 

(SDEFUN |RECLOS;coerce;2$;9| ((|x| ($)) ($ ($)))
        (COND ((QEQCAR |x| 0) |x|)
              ('T
               (CONS 1
                     (VECTOR (QVELT (QCDR |x|) 0)
                             (SPADCALL (QVELT (QCDR |x|) 1)
                                       (SPADCALL (QVELT (QCDR |x|) 0)
                                                 (QREFELT $ 25))
                                       (QREFELT $ 56))
                             (QVELT (QCDR |x|) 2) (QVELT (QCDR |x|) 3)))))) 

(SDEFUN |RECLOS;positive?;$B;10| ((|x| ($)) ($ (|Boolean|)))
        (COND ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) (QREFELT $ 58)))
              ('T
               (SPADCALL (QVELT (QCDR |x|) 1) (QVELT (QCDR |x|) 0)
                         (QREFELT $ 59))))) 

(SDEFUN |RECLOS;negative?;$B;11| ((|x| ($)) ($ (|Boolean|)))
        (COND ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) (QREFELT $ 61)))
              ('T
               (SPADCALL (QVELT (QCDR |x|) 1) (QVELT (QCDR |x|) 0)
                         (QREFELT $ 62))))) 

(SDEFUN |RECLOS;abs;2$;12| ((|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 65)) |x| (QREFELT $ 66))) 

(SDEFUN |RECLOS;sign;$I;13| ((|x| ($)) ($ (|Integer|)))
        (COND ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) (QREFELT $ 67)))
              ('T
               (SPADCALL (QVELT (QCDR |x|) 1) (QVELT (QCDR |x|) 0)
                         (QREFELT $ 68))))) 

(SDEFUN |RECLOS;<;2$B;14| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |y| |x| (QREFELT $ 69)) (QREFELT $ 60))) 

(SDEFUN |RECLOS;=;2$B;15| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |x| |y| (QREFELT $ 69)) (QREFELT $ 70))) 

(SDEFUN |RECLOS;mainCharacterization;$U;16|
        ((|x| ($))
         ($
          (|Union|
           (|RightOpenIntervalRootCharacterization| $
                                                    (|SparseUnivariatePolynomial|
                                                     $))
           "failed")))
        (COND ((QEQCAR |x| 0) (CONS 1 "failed"))
              ('T (CONS 0 (QVELT (QCDR |x|) 0))))) 

(SDEFUN |RECLOS;mainDefiningPolynomial;$U;17|
        ((|x| ($)) ($ (|Union| (|SparseUnivariatePolynomial| $) "failed")))
        (COND ((QEQCAR |x| 0) (CONS 1 "failed"))
              ('T (CONS 0 (SPADCALL (QVELT (QCDR |x|) 0) (QREFELT $ 25)))))) 

(SDEFUN |RECLOS;mainForm;$U;18|
        ((|x| ($)) ($ (|Union| (|OutputForm|) "failed")))
        (COND ((QEQCAR |x| 0) (CONS 1 "failed"))
              ('T (CONS 0 (QVELT (QCDR |x|) 2))))) 

(SDEFUN |RECLOS;mainValue;$U;19|
        ((|x| ($)) ($ (|Union| (|SparseUnivariatePolynomial| $) "failed")))
        (COND ((QEQCAR |x| 0) (CONS 1 "failed"))
              ('T (CONS 0 (QVELT (QCDR |x|) 1))))) 

(SDEFUN |RECLOS;coerce;$Of;20| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((|xx| ($)))
               (SEQ
                (COND ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) (QREFELT $ 79)))
                      ('T
                       (SEQ (LETT |xx| (SPADCALL |x| (QREFELT $ 57)))
                            (EXIT
                             (SPADCALL
                              (SPADCALL (QVELT (QCDR |xx|) 1) (QREFELT $ 80))
                              (QVELT (QCDR |x|) 2) (QREFELT $ 81))))))))) 

(SDEFUN |RECLOS;inv;2$;21| ((|x| ($)) ($ ($)))
        (SPROG ((|res| (|Union| $ "failed")))
               (SEQ (LETT |res| (SPADCALL |x| (QREFELT $ 83)))
                    (EXIT
                     (COND ((QEQCAR |res| 1) (|error| "Division by 0"))
                           ('T (QCDR |res|))))))) 

(SDEFUN |RECLOS;recip;$U;22| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|r| (|Union| (|SparseUnivariatePolynomial| $) "failed")))
               (SEQ
                (COND
                 ((QEQCAR |x| 0)
                  (SEQ (LETT |r| (SPADCALL (QCDR |x|) (QREFELT $ 85)))
                       (EXIT
                        (COND ((QEQCAR |r| 0) (CONS 0 (CONS 0 (QCDR |r|))))
                              (#1='T (CONS 1 "failed"))))))
                 (#1#
                  (SEQ
                   (LETT |r|
                         (SPADCALL (QVELT (QCDR |x|) 1) (QVELT (QCDR |x|) 0)
                                   (QREFELT $ 87)))
                   (EXIT
                    (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                          (#1#
                           (CONS 0
                                 (|RECLOS;lessAlgebraic|
                                  (CONS 1
                                        (VECTOR (QVELT (QCDR |x|) 0) (QCDR |r|)
                                                (QVELT (QCDR |x|) 2)
                                                (QVELT (QCDR |x|) 3)))
                                  $))))))))))) 

(SDEFUN |RECLOS;*;I2$;23| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPROG NIL
               (COND
                ((QEQCAR |x| 0)
                 (CONS 0 (SPADCALL |n| (QCDR |x|) (QREFELT $ 88))))
                ((ZEROP |n|) (|spadConstant| $ 28)) ((EQL |n| 1) |x|)
                ('T
                 (CONS 1
                       (VECTOR (QVELT (QCDR |x|) 0)
                               (SPADCALL
                                (CONS #'|RECLOS;*;I2$;23!0| (VECTOR $ |n|))
                                (QVELT (QCDR |x|) 1) (QREFELT $ 90))
                               (QVELT (QCDR |x|) 2) (QVELT (QCDR |x|) 3))))))) 

(SDEFUN |RECLOS;*;I2$;23!0| ((|z| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |z| (QREFELT $ 66)))))) 

(SDEFUN |RECLOS;*;TheField2$;24| ((|rn| (|TheField|)) (|x| ($)) ($ ($)))
        (SPROG NIL
               (COND
                ((QEQCAR |x| 0)
                 (CONS 0 (SPADCALL |rn| (QCDR |x|) (QREFELT $ 91))))
                ((SPADCALL |rn| (QREFELT $ 92)) (|spadConstant| $ 28))
                ((SPADCALL |rn| (QREFELT $ 93)) |x|)
                ('T
                 (CONS 1
                       (VECTOR (QVELT (QCDR |x|) 0)
                               (SPADCALL
                                (CONS #'|RECLOS;*;TheField2$;24!0|
                                      (VECTOR $ |rn|))
                                (QVELT (QCDR |x|) 1) (QREFELT $ 90))
                               (QVELT (QCDR |x|) 2) (QVELT (QCDR |x|) 3))))))) 

(SDEFUN |RECLOS;*;TheField2$;24!0| ((|z| NIL) ($$ NIL))
        (PROG (|rn| $)
          (LETT |rn| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |rn| |z| (QREFELT $ 94)))))) 

(SDEFUN |RECLOS;*;3$;25| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG NIL
               (SEQ
                (COND
                 ((QEQCAR |x| 0)
                  (COND
                   ((QEQCAR |y| 0)
                    (EXIT
                     (CONS 0
                           (SPADCALL (QCDR |x|) (QCDR |y|)
                                     (QREFELT $ 91))))))))
                (EXIT
                 (COND
                  ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) |y| (QREFELT $ 94)))
                  ((QEQCAR |y| 0) (SPADCALL (QCDR |y|) |x| (QREFELT $ 94)))
                  (#1='T
                   (COND
                    ((> (QVELT (QCDR |y|) 3) (QVELT (QCDR |x|) 3))
                     (CONS 1
                           (VECTOR (QVELT (QCDR |y|) 0)
                                   (SPADCALL
                                    (CONS #'|RECLOS;*;3$;25!0| (VECTOR $ |x|))
                                    (QVELT (QCDR |y|) 1) (QREFELT $ 90))
                                   (QVELT (QCDR |y|) 2) (QVELT (QCDR |y|) 3))))
                    ((> (QVELT (QCDR |x|) 3) (QVELT (QCDR |y|) 3))
                     (CONS 1
                           (VECTOR (QVELT (QCDR |x|) 0)
                                   (SPADCALL
                                    (CONS #'|RECLOS;*;3$;25!1| (VECTOR $ |y|))
                                    (QVELT (QCDR |x|) 1) (QREFELT $ 90))
                                   (QVELT (QCDR |x|) 2) (QVELT (QCDR |x|) 3))))
                    (#1#
                     (|RECLOS;lessAlgebraic|
                      (CONS 1
                            (VECTOR (QVELT (QCDR |x|) 0)
                                    (SPADCALL
                                     (SPADCALL (QVELT (QCDR |x|) 1)
                                               (QVELT (QCDR |y|) 1)
                                               (QREFELT $ 96))
                                     (SPADCALL (QVELT (QCDR |x|) 0)
                                               (QREFELT $ 25))
                                     (QREFELT $ 56))
                                    (QVELT (QCDR |x|) 2) (QVELT (QCDR |x|) 3)))
                      $))))))))) 

(SDEFUN |RECLOS;*;3$;25!1| ((|z| NIL) ($$ NIL))
        (PROG (|y| $)
          (LETT |y| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z| |y| (QREFELT $ 95)))))) 

(SDEFUN |RECLOS;*;3$;25!0| ((|z| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |z| (QREFELT $ 95)))))) 

(SDEFUN |RECLOS;nonNull| ((|rep| (|Rec|)) ($ ($)))
        (COND
         ((EQL (SPADCALL (QVELT |rep| 1) (QREFELT $ 27)) 0)
          (SPADCALL (QVELT |rep| 1) (QREFELT $ 31)))
         ((OR (EQL (SPADCALL (QVELT |rep| 1) (QREFELT $ 97)) 1)
              (NULL (SPADCALL (QVELT |rep| 1) (QVELT |rep| 0) (QREFELT $ 98))))
          (CONS 1 |rep|))
         ('T (|spadConstant| $ 28)))) 

(SDEFUN |RECLOS;zero?;$B;27| ((|x| ($)) ($ (|Boolean|)))
        (COND ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) (QREFELT $ 92))) ('T NIL))) 

(SDEFUN |RECLOS;+;3$;28| ((|x| ($)) (|y| ($)) ($ ($)))
        (SEQ
         (COND
          ((QEQCAR |x| 0)
           (COND
            ((QEQCAR |y| 0)
             (EXIT
              (CONS 0 (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 99))))))))
         (EXIT
          (COND
           ((QEQCAR |x| 0)
            (COND ((SPADCALL |x| (QREFELT $ 70)) |y|)
                  (#1='T
                   (|RECLOS;nonNull|
                    (VECTOR (QVELT (QCDR |y|) 0)
                            (SPADCALL (SPADCALL |x| (QREFELT $ 100))
                                      (QVELT (QCDR |y|) 1) (QREFELT $ 101))
                            (QVELT (QCDR |y|) 2) (QVELT (QCDR |y|) 3))
                    $))))
           ((QEQCAR |y| 0)
            (COND ((SPADCALL |y| (QREFELT $ 70)) |x|)
                  (#1#
                   (|RECLOS;nonNull|
                    (VECTOR (QVELT (QCDR |x|) 0)
                            (SPADCALL (QVELT (QCDR |x|) 1)
                                      (SPADCALL |y| (QREFELT $ 100))
                                      (QREFELT $ 101))
                            (QVELT (QCDR |x|) 2) (QVELT (QCDR |x|) 3))
                    $))))
           (#1#
            (COND
             ((> (QVELT (QCDR |y|) 3) (QVELT (QCDR |x|) 3))
              (|RECLOS;nonNull|
               (VECTOR (QVELT (QCDR |y|) 0)
                       (SPADCALL (SPADCALL |x| (QREFELT $ 100))
                                 (QVELT (QCDR |y|) 1) (QREFELT $ 101))
                       (QVELT (QCDR |y|) 2) (QVELT (QCDR |y|) 3))
               $))
             ((> (QVELT (QCDR |x|) 3) (QVELT (QCDR |y|) 3))
              (|RECLOS;nonNull|
               (VECTOR (QVELT (QCDR |x|) 0)
                       (SPADCALL (QVELT (QCDR |x|) 1)
                                 (SPADCALL |y| (QREFELT $ 100))
                                 (QREFELT $ 101))
                       (QVELT (QCDR |x|) 2) (QVELT (QCDR |x|) 3))
               $))
             (#1#
              (|RECLOS;nonNull|
               (VECTOR (QVELT (QCDR |x|) 0)
                       (SPADCALL (QVELT (QCDR |x|) 1) (QVELT (QCDR |y|) 1)
                                 (QREFELT $ 101))
                       (QVELT (QCDR |x|) 2) (QVELT (QCDR |x|) 3))
               $)))))))) 

(SDEFUN |RECLOS;-;2$;29| ((|x| ($)) ($ ($)))
        (COND ((QEQCAR |x| 0) (CONS 0 (SPADCALL (QCDR |x|) (QREFELT $ 103))))
              ('T
               (CONS 1
                     (VECTOR (QVELT (QCDR |x|) 0)
                             (SPADCALL (QVELT (QCDR |x|) 1) (QREFELT $ 104))
                             (QVELT (QCDR |x|) 2) (QVELT (QCDR |x|) 3)))))) 

(SDEFUN |RECLOS;retractIfCan;$U;30|
        ((|x| ($)) ($ (|Union| |TheField| "failed")))
        (SPROG ((|res| ($)) (|o| (|PositiveInteger|)))
               (SEQ
                (COND ((QEQCAR |x| 0) (CONS 0 (QCDR |x|)))
                      (#1='T
                       (SEQ (LETT |o| (QVELT (QCDR |x|) 3))
                            (LETT |res| (|RECLOS;lessAlgebraic| |x| $))
                            (EXIT
                             (COND ((QEQCAR |res| 0) (CONS 0 (QCDR |res|)))
                                   ((EQL |o| (QVELT (QCDR |res|) 3))
                                    (CONS 1 "failed"))
                                   (#1#
                                    (SPADCALL |res| (QREFELT $ 106))))))))))) 

(SDEFUN |RECLOS;retract;$TheField;31| ((|x| ($)) ($ (|TheField|)))
        (SPROG ((|res| ($)) (|o| (|PositiveInteger|)))
               (SEQ
                (COND ((QEQCAR |x| 0) (QCDR |x|))
                      (#1='T
                       (SEQ (LETT |o| (QVELT (QCDR |x|) 3))
                            (LETT |res| (|RECLOS;lessAlgebraic| |x| $))
                            (EXIT
                             (COND ((QEQCAR |res| 0) (QCDR |res|))
                                   ((EQL |o| (QVELT (QCDR |res|) 3))
                                    (|error| "Can't retract"))
                                   (#1#
                                    (SPADCALL |res| (QREFELT $ 107))))))))))) 

(SDEFUN |RECLOS;lessAlgebraic| ((|x| ($)) ($ ($)))
        (SPROG ((|def| (|SparseUnivariatePolynomial| $)))
               (SEQ
                (COND ((QEQCAR |x| 0) |x|)
                      ((EQL (SPADCALL (QVELT (QCDR |x|) 1) (QREFELT $ 27)) 0)
                       (SPADCALL (QVELT (QCDR |x|) 1) (QREFELT $ 31)))
                      (#1='T
                       (SEQ
                        (LETT |def|
                              (SPADCALL (QVELT (QCDR |x|) 0) (QREFELT $ 25)))
                        (EXIT
                         (COND
                          ((EQL (SPADCALL |def| (QREFELT $ 27)) 1)
                           (SPADCALL (QVELT (QCDR |x|) 1)
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |def| 0 (QREFELT $ 30))
                                       (SPADCALL |def| (QREFELT $ 31))
                                       (QREFELT $ 32))
                                      (QREFELT $ 33))
                                     (QREFELT $ 108)))
                          (#1# |x|))))))))) 

(SDEFUN |RECLOS;Zero;$;33| (($ ($))) (CONS 0 (|spadConstant| $ 29))) 

(SDEFUN |RECLOS;One;$;34| (($ ($))) (CONS 0 (|spadConstant| $ 35))) 

(PUT '|RECLOS;coerce;TheField$;35| '|SPADreplace| '(XLAM (|rn|) (CONS 0 |rn|))) 

(SDEFUN |RECLOS;coerce;TheField$;35| ((|rn| (|TheField|)) ($ ($)))
        (CONS 0 |rn|)) 

(DECLAIM (NOTINLINE |RealClosure;|)) 

(DEFUN |RealClosure| (#1=#:G930)
  (SPROG NIL
         (PROG (#2=#:G931)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RealClosure|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RealClosure;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|RealClosure|)))))))))) 

(DEFUN |RealClosure;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RealClosure| DV$1))
          (LETT $ (GETREFV 129))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (OR
                                               (|HasCategory| |#1|
                                                              '(|RetractableTo|
                                                                (|Integer|)))
                                               (|HasCategory|
                                                (|Fraction| (|Integer|))
                                                '(|RetractableTo|
                                                  (|Integer|))))
                                              (|HasCategory|
                                               (|Fraction| (|Integer|))
                                               '(|RetractableTo|
                                                 (|Fraction| (|Integer|))))))))
          (|haddProp| |$ConstructorCache| '|RealClosure| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record|
                     (|:| |seg|
                          (|RightOpenIntervalRootCharacterization| $
                                                                   (|SparseUnivariatePolynomial|
                                                                    $)))
                     (|:| |val| (|SparseUnivariatePolynomial| $))
                     (|:| |outForm| (|OutputForm|))
                     (|:| |order| (|PositiveInteger|))))
          (QSETREFV $ 8 (|Union| |#1| (QREFELT $ 7)))
          (QSETREFV $ 9 1)
          (QSETREFV $ 12 (SPADCALL (QREFELT $ 11)))
          $))) 

(MAKEPROP '|RealClosure| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rec| '|Rep|
              '|orderOfCreation| (|Symbol|) (0 . |new|) '|instanceName|
              (|Fraction| 64) (4 . |retract|) (|SparseUnivariatePolynomial| $$)
              (|RightOpenIntervalRootCharacterization| $$ 15)
              (9 . |relativeApprox|) |RECLOS;relativeApprox;2$F;1|
              |RECLOS;abs;2$;12| (|Boolean|) |RECLOS;<;2$B;14| (16 . |Zero|)
              (20 . |approximate|) |RECLOS;approximate;2$F;2|
              (27 . |definingPolynomial|) (|NonNegativeInteger|)
              (32 . |degree|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |RECLOS;Zero;$;33|) $))
              (37 . |Zero|) (41 . |coefficient|) (47 . |leadingCoefficient|)
              (52 . /) |RECLOS;-;2$;29|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |RECLOS;One;$;34|) $))
              (58 . |One|) (62 . |monomial|)
              (|RightOpenIntervalRootCharacterization| $ 48) (|OutputForm|)
              |RECLOS;algebraicOf;RoircOf$;4| |RECLOS;rename!;$Of$;5|
              |RECLOS;rename;$Of$;6| (|Union| $ '"failed") (|PositiveInteger|)
              (68 . |rootOf|) (74 . |coerce|) (79 . |coerce|) (84 . |hconcat|)
              (|SparseUnivariatePolynomial| $) |RECLOS;rootOf;SupPiU;7|
              (|List| $) (90 . |allRootsOf|) (|List| $$) (95 . |cons|)
              (101 . |reverse!|) |RECLOS;allRootsOf;SupL;8| (106 . |rem|)
              |RECLOS;coerce;2$;9| (112 . |positive?|) (117 . |positive?|)
              |RECLOS;positive?;$B;10| (123 . |negative?|) (128 . |negative?|)
              |RECLOS;negative?;$B;11| (|Integer|) |RECLOS;sign;$I;13|
              |RECLOS;*;I2$;23| (134 . |sign|) (139 . |sign|) (145 . -)
              |RECLOS;zero?;$B;27| |RECLOS;=;2$B;15| (|Union| 37 '"failed")
              |RECLOS;mainCharacterization;$U;16| (|Union| 48 '#1="failed")
              |RECLOS;mainDefiningPolynomial;$U;17| (|Union| 38 '#1#)
              |RECLOS;mainForm;$U;18| |RECLOS;mainValue;$U;19| (151 . |coerce|)
              (156 . |univariate|) (161 . |outputForm|) |RECLOS;coerce;$Of;20|
              |RECLOS;recip;$U;22| |RECLOS;inv;2$;21| (167 . |recip|)
              (|Union| 15 '"failed") (172 . |recip|) (178 . *)
              (|Mapping| $$ $$) (184 . |map|) (190 . *) (196 . |zero?|)
              (201 . |one?|) |RECLOS;*;TheField2$;24| |RECLOS;*;3$;25|
              (206 . *) (212 . |numberOfMonomials|) (217 . |zero?|) (223 . +)
              (229 . |coerce|) (234 . +) |RECLOS;+;3$;28| (240 . -) (245 . -)
              (|Union| 6 '#2="failed") |RECLOS;retractIfCan;$U;30|
              |RECLOS;retract;$TheField;31| (250 . |elt|)
              |RECLOS;coerce;TheField$;35| (|Union| 64 '#2#) (|Union| 13 '#2#)
              (|Polynomial| 64) (|Polynomial| $) (|Polynomial| 13)
              (|SparseUnivariatePolynomial| 13)
              (|SparseUnivariatePolynomial| 64)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |coef| 50) (|:| |generator| $))
              (|Union| 50 '"failed")
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 123 '"failed") (|Factored| $) (|HashState|) (|String|)
              (|SingleInteger|))
           '#(~= 256 |zero?| 262 |unitNormal| 267 |unitCanonical| 272 |unit?|
              277 |subtractIfCan| 282 |squareFreePart| 288 |squareFree| 293
              |sqrt| 298 |smaller?| 319 |sizeLess?| 325 |sign| 331 |sample| 336
              |rootOf| 340 |rightRecip| 353 |rightPower| 358 |retractIfCan| 370
              |retract| 390 |rename!| 410 |rename| 416 |rem| 422
              |relativeApprox| 428 |recip| 434 |quo| 439 |principalIdeal| 445
              |prime?| 450 |positive?| 455 |opposite?| 460 |one?| 466 |nthRoot|
              471 |negative?| 477 |multiEuclidean| 482 |min| 488 |max| 494
              |mainValue| 500 |mainForm| 505 |mainDefiningPolynomial| 510
              |mainCharacterization| 515 |leftRecip| 520 |leftPower| 525
              |lcmCoef| 537 |lcm| 543 |latex| 554 |inv| 559 |hashUpdate!| 564
              |hash| 570 |gcdPolynomial| 575 |gcd| 581 |factor| 592
              |extendedEuclidean| 597 |exquo| 610 |expressIdealMember| 616
              |euclideanSize| 622 |divide| 627 |commutator| 633 |coerce| 639
              |characteristic| 664 |associator| 668 |associates?| 675
              |approximate| 681 |antiCommutator| 687 |annihilate?| 693
              |allRootsOf| 699 |algebraicOf| 729 |abs| 735 ^ 740 |Zero| 764
              |One| 768 >= 772 > 778 = 784 <= 790 < 796 / 802 - 808 + 819 *
              825)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
                                  0 0 0 0 1))
            (CONS
             '#(|RealClosedField&| |Field&| |EuclideanDomain&|
                |UniqueFactorizationDomain&| NIL |GcdDomain&| NIL
                |DivisionRing&| NIL NIL |OrderedRing&| NIL |Algebra&|
                |Algebra&| |Algebra&| |EntireRing&| |Algebra&| NIL |Rng&| NIL
                |Module&| |Module&| |Module&| |Module&| NIL NIL NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |OrderedSet&| NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| |FullyRetractableTo&| |FullyRetractableTo&|
                NIL |Magma&| |AbelianSemiGroup&| |RetractableTo&|
                |RetractableTo&| NIL |SetCategory&| |RetractableTo&| NIL
                |RadicalCategory&| NIL NIL NIL NIL NIL |PartialOrder&| NIL
                |BasicType&| NIL NIL)
             (CONS
              '#((|RealClosedField|) (|Field|) (|EuclideanDomain|)
                 (|UniqueFactorizationDomain|) (|PrincipalIdealDomain|)
                 (|GcdDomain|) (|IntegralDomain|) (|DivisionRing|)
                 (|LeftOreRing|) (|CommutativeRing|) (|OrderedRing|)
                 (|CharacteristicZero|) (|Algebra| 6) (|Algebra| 64)
                 (|Algebra| 13) (|EntireRing|) (|Algebra| $$) (|Ring|) (|Rng|)
                 (|SemiRing|) (|Module| 6) (|Module| 64) (|Module| 13)
                 (|Module| $$) (|SemiRng|) (|BiModule| 6 6) (|BiModule| 64 64)
                 (|BiModule| 13 13) (|BiModule| $$ $$) (|OrderedAbelianGroup|)
                 (|NonAssociativeRing|) (|RightModule| 6) (|LeftModule| 6)
                 (|RightModule| 64) (|LeftModule| 64) (|RightModule| 13)
                 (|LeftModule| 13) (|LeftModule| $$)
                 (|OrderedCancellationAbelianMonoid|) (|NonAssociativeRng|)
                 (|RightModule| $$) (|OrderedAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianSemiGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|OrderedSet|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|FullyRetractableTo| 6) (|FullyRetractableTo| 13)
                 (|Comparable|) (|Magma|) (|AbelianSemiGroup|)
                 (|RetractableTo| 6) (|RetractableTo| 13) (|CommutativeStar|)
                 (|SetCategory|) (|RetractableTo| 64) (|CoercibleFrom| 6)
                 (|RadicalCategory|) (|CoercibleFrom| 13) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|PartialOrder|) (|unitsKnown|) (|BasicType|)
                 (|CoercibleTo| 38) (|CoercibleFrom| 64))
              (|makeByteWordVec2| 128
                                  '(0 10 0 11 1 0 13 0 14 3 16 2 15 0 2 17 0 13
                                    0 22 3 16 2 15 0 2 23 1 16 15 0 25 1 15 26
                                    0 27 0 6 0 29 2 15 2 0 26 30 1 15 2 0 31 2
                                    0 0 0 0 32 0 6 0 35 2 15 0 2 26 36 2 16 42
                                    15 43 44 1 10 38 0 45 1 43 38 0 46 2 38 0 0
                                    0 47 1 16 50 15 51 2 52 0 2 0 53 1 52 0 0
                                    54 2 15 0 0 0 56 1 6 20 0 58 2 16 20 15 0
                                    59 1 6 20 0 61 2 16 20 15 0 62 1 6 64 0 67
                                    2 16 64 15 0 68 2 0 0 0 0 69 1 6 38 0 79 1
                                    15 15 0 80 2 15 38 0 38 81 1 6 42 0 85 2 16
                                    86 15 0 87 2 6 0 64 0 88 2 15 0 89 0 90 2 6
                                    0 0 0 91 1 6 20 0 92 1 6 20 0 93 2 15 0 0 0
                                    96 1 15 26 0 97 2 16 20 15 0 98 2 6 0 0 0
                                    99 1 15 0 2 100 2 15 0 0 0 101 1 6 0 0 103
                                    1 15 0 0 104 2 15 2 0 2 108 2 0 20 0 0 1 1
                                    0 20 0 70 1 0 117 0 1 1 0 0 0 1 1 0 20 0 1
                                    2 0 42 0 0 1 1 0 0 0 1 1 0 125 0 1 1 0 0 64
                                    1 1 0 0 13 1 2 0 0 0 43 1 1 0 0 0 1 2 0 20
                                    0 0 1 2 0 20 0 0 1 1 0 64 0 65 0 0 0 1 2 0
                                    42 48 43 49 3 0 42 48 43 38 1 1 0 42 0 1 2
                                    0 0 0 26 1 2 0 0 0 43 1 1 1 110 0 1 1 2 111
                                    0 1 1 0 105 0 106 1 0 111 0 1 1 1 64 0 1 1
                                    2 13 0 14 1 0 6 0 107 1 0 13 0 14 2 0 0 0
                                    38 40 2 0 0 0 38 41 2 0 0 0 0 1 2 0 13 0 0
                                    18 1 0 42 0 83 2 0 0 0 0 1 1 0 119 50 1 1 0
                                    20 0 1 1 0 20 0 60 2 0 20 0 0 1 1 0 20 0 1
                                    2 0 0 0 64 1 1 0 20 0 63 2 0 120 50 0 1 2 0
                                    0 0 0 1 2 0 0 0 0 1 1 0 74 0 78 1 0 76 0 77
                                    1 0 74 0 75 1 0 72 0 73 1 0 42 0 1 2 0 0 0
                                    26 1 2 0 0 0 43 1 2 0 118 0 0 1 1 0 0 50 1
                                    2 0 0 0 0 1 1 0 127 0 1 1 0 0 0 84 2 0 126
                                    126 0 1 1 0 128 0 1 2 0 48 48 48 1 1 0 0 50
                                    1 2 0 0 0 0 1 1 0 125 0 1 2 0 122 0 0 1 3 0
                                    124 0 0 0 1 2 0 42 0 0 1 2 0 120 50 0 1 1 0
                                    26 0 1 2 0 121 0 0 1 2 0 0 0 0 1 1 0 0 6
                                    109 1 0 0 13 1 1 0 0 64 1 1 0 0 0 57 1 0 38
                                    0 82 0 0 26 1 3 0 0 0 0 0 1 2 0 20 0 0 1 2
                                    0 13 0 0 24 2 0 0 0 0 1 2 0 20 0 0 1 1 0 50
                                    112 1 1 0 50 113 1 1 0 50 114 1 1 0 50 115
                                    1 1 0 50 116 1 1 0 50 48 55 2 0 0 37 38 39
                                    1 0 0 0 19 2 0 0 0 13 1 2 0 0 0 64 1 2 0 0
                                    0 26 1 2 0 0 0 43 1 0 0 0 28 0 0 0 34 2 0
                                    20 0 0 1 2 0 20 0 0 1 2 0 20 0 0 71 2 0 20
                                    0 0 1 2 0 20 0 0 21 2 0 0 0 0 32 1 0 0 0 33
                                    2 0 0 0 0 69 2 0 0 0 0 102 2 0 0 6 0 94 2 0
                                    0 0 6 1 2 0 0 13 0 1 2 0 0 0 13 1 2 0 0 0
                                    64 1 2 0 0 64 0 66 2 0 0 26 0 1 2 0 0 0 0
                                    95 2 0 0 43 0 1)))))
           '|lookupComplete|)) 

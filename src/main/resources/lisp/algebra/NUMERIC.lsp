
(SDEFUN |NUMERIC;complexNumericIfCan;PU;1|
        ((|p| (|Polynomial| (|Complex| S)))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG ((|p'| (|Union| (|Complex| S) "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 9)))
                    (EXIT
                     (COND ((QEQCAR |p'| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0 (SPADCALL (QCDR |p'|) (QREFELT $ 12))))))))) 

(SDEFUN |NUMERIC;complexNumericIfCan;PPiU;2|
        ((|p| (|Polynomial| (|Complex| S))) (|n| (|PositiveInteger|))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG ((|p'| (|Union| (|Complex| S) "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 9)))
                    (EXIT
                     (COND ((QEQCAR |p'| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0
                                  (SPADCALL (QCDR |p'|) |n|
                                            (QREFELT $ 16))))))))) 

(SDEFUN |NUMERIC;numericIfCan;PU;3|
        ((|p| (|Polynomial| S)) ($ (|Union| (|Float|) "failed")))
        (SPROG ((|p'| (|Union| S "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 20)))
                    (EXIT
                     (COND ((QEQCAR |p'| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0 (SPADCALL (QCDR |p'|) (QREFELT $ 22))))))))) 

(SDEFUN |NUMERIC;complexNumericIfCan;PU;4|
        ((|p| (|Polynomial| S)) ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG ((|p'| (|Union| S "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 20)))
                    (EXIT
                     (COND ((QEQCAR |p'| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0 (SPADCALL (QCDR |p'|) (QREFELT $ 25))))))))) 

(SDEFUN |NUMERIC;complexNumericIfCan;PPiU;5|
        ((|p| (|Polynomial| S)) (|n| (|PositiveInteger|))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG ((|p'| (|Union| S "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 20)))
                    (EXIT
                     (COND ((QEQCAR |p'| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0
                                  (SPADCALL (QCDR |p'|) |n|
                                            (QREFELT $ 27))))))))) 

(SDEFUN |NUMERIC;numericIfCan;PPiU;6|
        ((|p| (|Polynomial| S)) (|n| (|PositiveInteger|))
         ($ (|Union| (|Float|) "failed")))
        (SPROG
         ((|ans| (|Union| (|Float|) "failed")) (|old| (|PositiveInteger|)))
         (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
              (LETT |ans| (SPADCALL |p| (QREFELT $ 24)))
              (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;numericIfCan;FU;7|
        ((|f| (|Fraction| (|Polynomial| S))) ($ (|Union| (|Float|) "failed")))
        (SPROG ((|den| #1=(|Union| (|Float|) "failed")) (|num| #1#))
               (SEQ
                (LETT |num|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 32)) (QREFELT $ 24)))
                (EXIT
                 (COND ((QEQCAR |num| 1) (CONS 1 "failed"))
                       (#2='T
                        (SEQ
                         (LETT |den|
                               (SPADCALL (SPADCALL |f| (QREFELT $ 33))
                                         (QREFELT $ 24)))
                         (EXIT
                          (COND ((QEQCAR |den| 1) (CONS 1 "failed"))
                                (#2#
                                 (CONS 0
                                       (SPADCALL (QCDR |num|) (QCDR |den|)
                                                 (QREFELT $ 34))))))))))))) 

(SDEFUN |NUMERIC;complexNumericIfCan;FU;8|
        ((|f| (|Fraction| (|Polynomial| S)))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG
         ((|den| #1=(|Union| (|Complex| (|Float|)) "failed")) (|num| #1#))
         (SEQ
          (LETT |num| (SPADCALL (SPADCALL |f| (QREFELT $ 32)) (QREFELT $ 26)))
          (EXIT
           (COND ((QEQCAR |num| 1) (CONS 1 "failed"))
                 (#2='T
                  (SEQ
                   (LETT |den|
                         (SPADCALL (SPADCALL |f| (QREFELT $ 33))
                                   (QREFELT $ 26)))
                   (EXIT
                    (COND ((QEQCAR |den| 1) (CONS 1 "failed"))
                          (#2#
                           (CONS 0
                                 (SPADCALL (QCDR |num|) (QCDR |den|)
                                           (QREFELT $ 36))))))))))))) 

(SDEFUN |NUMERIC;complexNumericIfCan;FPiU;9|
        ((|f| (|Fraction| (|Polynomial| S))) (|n| (|PositiveInteger|))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG
         ((|den| #1=(|Union| (|Complex| (|Float|)) "failed")) (|num| #1#))
         (SEQ
          (LETT |num|
                (SPADCALL (SPADCALL |f| (QREFELT $ 32)) |n| (QREFELT $ 28)))
          (EXIT
           (COND ((QEQCAR |num| 1) (CONS 1 "failed"))
                 (#2='T
                  (SEQ
                   (LETT |den|
                         (SPADCALL (SPADCALL |f| (QREFELT $ 33)) |n|
                                   (QREFELT $ 28)))
                   (EXIT
                    (COND ((QEQCAR |den| 1) (CONS 1 "failed"))
                          (#2#
                           (CONS 0
                                 (SPADCALL (QCDR |num|) (QCDR |den|)
                                           (QREFELT $ 36))))))))))))) 

(SDEFUN |NUMERIC;numericIfCan;FPiU;10|
        ((|f| (|Fraction| (|Polynomial| S))) (|n| (|PositiveInteger|))
         ($ (|Union| (|Float|) "failed")))
        (SPROG
         ((|ans| (|Union| (|Float|) "failed")) (|old| (|PositiveInteger|)))
         (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
              (LETT |ans| (SPADCALL |f| (QREFELT $ 35)))
              (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;complexNumericIfCan;FU;11|
        ((|f| (|Fraction| (|Polynomial| (|Complex| S))))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG
         ((|den| #1=(|Union| (|Complex| (|Float|)) "failed")) (|num| #1#))
         (SEQ
          (LETT |num| (SPADCALL (SPADCALL |f| (QREFELT $ 41)) (QREFELT $ 14)))
          (EXIT
           (COND ((QEQCAR |num| 1) (CONS 1 "failed"))
                 (#2='T
                  (SEQ
                   (LETT |den|
                         (SPADCALL (SPADCALL |f| (QREFELT $ 42))
                                   (QREFELT $ 14)))
                   (EXIT
                    (COND ((QEQCAR |den| 1) (CONS 1 "failed"))
                          (#2#
                           (CONS 0
                                 (SPADCALL (QCDR |num|) (QCDR |den|)
                                           (QREFELT $ 36))))))))))))) 

(SDEFUN |NUMERIC;complexNumericIfCan;FPiU;12|
        ((|f| (|Fraction| (|Polynomial| (|Complex| S))))
         (|n| (|PositiveInteger|))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG
         ((|den| #1=(|Union| (|Complex| (|Float|)) "failed")) (|num| #1#))
         (SEQ
          (LETT |num|
                (SPADCALL (SPADCALL |f| (QREFELT $ 41)) |n| (QREFELT $ 17)))
          (EXIT
           (COND ((QEQCAR |num| 1) (CONS 1 "failed"))
                 (#2='T
                  (SEQ
                   (LETT |den|
                         (SPADCALL (SPADCALL |f| (QREFELT $ 42)) |n|
                                   (QREFELT $ 17)))
                   (EXIT
                    (COND ((QEQCAR |den| 1) (CONS 1 "failed"))
                          (#2#
                           (CONS 0
                                 (SPADCALL (QCDR |num|) (QCDR |den|)
                                           (QREFELT $ 36))))))))))))) 

(SDEFUN |NUMERIC;numericIfCan;EU;13|
        ((|x| (|Expression| S)) ($ (|Union| (|Float|) "failed")))
        (|trappedSpadEvalUnion|
         (SPADCALL (SPADCALL (ELT $ 45) |x| (QREFELT $ 50)) (QREFELT $ 51)))) 

(SDEFUN |NUMERIC;complexNumericIfCan;EU;14|
        ((|x| (|Expression| S)) ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPADCALL (SPADCALL (ELT $ 53) |x| (QREFELT $ 57)) (QREFELT $ 58))) 

(SDEFUN |NUMERIC;numericIfCan;EPiU;15|
        ((|x| (|Expression| S)) (|n| (|PositiveInteger|))
         ($ (|Union| (|Float|) "failed")))
        (SPROG ((|old| (|PositiveInteger|)))
               (SEQ (LETT |old| (SPADCALL (QREFELT $ 60)))
                    (EXIT
                     (|finally|
                      (SEQ (SPADCALL |n| (QREFELT $ 29))
                           (EXIT (SPADCALL |x| (QREFELT $ 52))))
                      (SPADCALL |old| (QREFELT $ 61))))))) 

(SDEFUN |NUMERIC;complexNumericIfCan;EPiU;16|
        ((|x| (|Expression| S)) (|n| (|PositiveInteger|))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG
         ((|ans| (|Union| (|Complex| (|Float|)) "failed"))
          (|x'| (|Expression| (|Complex| S))) (|old| (|PositiveInteger|)))
         (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
              (LETT |x'| (SPADCALL (ELT $ 53) |x| (QREFELT $ 57)))
              (LETT |ans| (SPADCALL |x'| (QREFELT $ 58)))
              (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;complexNumericIfCan;EU;17|
        ((|x| (|Expression| (|Complex| S)))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPADCALL (SPADCALL (ELT $ 64) |x| (QREFELT $ 68)) (QREFELT $ 69))) 

(SDEFUN |NUMERIC;complexNumericIfCan;EPiU;18|
        ((|x| (|Expression| (|Complex| S))) (|n| (|PositiveInteger|))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG
         ((|ans| (|Union| (|Complex| (|Float|)) "failed"))
          (|x'| (|Expression| (|Complex| (|Float|))))
          (|old| (|PositiveInteger|)))
         (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
              (LETT |x'| (SPADCALL (ELT $ 64) |x| (QREFELT $ 68)))
              (LETT |ans| (SPADCALL |x'| (QREFELT $ 69)))
              (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;convert| ((|x| (|Complex| S)) ($ (|Complex| (|Float|))))
        (SPADCALL (ELT $ 45) |x| (QREFELT $ 72))) 

(SDEFUN |NUMERIC;complexNumericIfCan;EU;20|
        ((|x| (|Expression| (|Complex| S)))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPADCALL
         (SPADCALL (CONS (|function| |NUMERIC;convert|) $) |x| (QREFELT $ 68))
         (QREFELT $ 69))) 

(SDEFUN |NUMERIC;complexNumericIfCan;EPiU;21|
        ((|x| (|Expression| (|Complex| S))) (|n| (|PositiveInteger|))
         ($ (|Union| (|Complex| (|Float|)) "failed")))
        (SPROG
         ((|ans| (|Union| (|Complex| (|Float|)) "failed"))
          (|x'| (|Expression| (|Complex| (|Float|))))
          (|old| (|PositiveInteger|)))
         (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
              (LETT |x'|
                    (SPADCALL (CONS (|function| |NUMERIC;convert|) $) |x|
                              (QREFELT $ 68)))
              (LETT |ans| (SPADCALL |x'| (QREFELT $ 69)))
              (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;numeric;SF;22| ((|s| (S)) ($ (|Float|)))
        (SPADCALL |s| (QREFELT $ 45))) 

(SDEFUN |NUMERIC;complexNumeric;SC;23| ((|s| (S)) ($ (|Complex| (|Float|))))
        (SPADCALL |s| (QREFELT $ 73))) 

(SDEFUN |NUMERIC;complexNumeric;SPiC;24|
        ((|s| (S)) (|n| (|PositiveInteger|)) ($ (|Complex| (|Float|))))
        (SPROG ((|ans| (|Complex| (|Float|))) (|old| (|PositiveInteger|)))
               (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
                    (LETT |ans| (SPADCALL |s| (QREFELT $ 25)))
                    (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;complexNumeric;SC;25| ((|s| (S)) ($ (|Complex| (|Float|))))
        (SPADCALL (SPADCALL |s| (QREFELT $ 45)) (QREFELT $ 74))) 

(SDEFUN |NUMERIC;complexNumeric;SPiC;26|
        ((|s| (S)) (|n| (|PositiveInteger|)) ($ (|Complex| (|Float|))))
        (SPADCALL (SPADCALL |s| |n| (QREFELT $ 75)) (QREFELT $ 74))) 

(SDEFUN |NUMERIC;complexNumeric;PC;27|
        ((|p| (|Polynomial| (|Complex| S))) ($ (|Complex| (|Float|))))
        (SPROG ((|p'| (|Union| (|Complex| S) "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 9)))
                    (EXIT
                     (COND
                      ((QEQCAR |p'| 1)
                       (|error|
                        "Cannot compute the numerical value of a non-constant polynomial"))
                      ('T (SPADCALL (QCDR |p'|) (QREFELT $ 12)))))))) 

(SDEFUN |NUMERIC;complexNumeric;PPiC;28|
        ((|p| (|Polynomial| (|Complex| S))) (|n| (|PositiveInteger|))
         ($ (|Complex| (|Float|))))
        (SPROG ((|p'| (|Union| (|Complex| S) "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 9)))
                    (EXIT
                     (COND
                      ((QEQCAR |p'| 1)
                       (|error|
                        "Cannot compute the numerical value of a non-constant polynomial"))
                      ('T (SPADCALL (QCDR |p'|) |n| (QREFELT $ 16)))))))) 

(SDEFUN |NUMERIC;complexNumeric;CC;29|
        ((|s| (|Complex| S)) ($ (|Complex| (|Float|))))
        (SPADCALL |s| (QREFELT $ 64))) 

(SDEFUN |NUMERIC;complexNumeric;CPiC;30|
        ((|s| (|Complex| S)) (|n| (|PositiveInteger|))
         ($ (|Complex| (|Float|))))
        (SPROG ((|ans| (|Complex| (|Float|))) (|old| (|PositiveInteger|)))
               (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
                    (LETT |ans| (SPADCALL |s| (QREFELT $ 12)))
                    (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;complexNumeric;CC;31|
        ((|s| (|Complex| S)) ($ (|Complex| (|Float|))))
        (SPADCALL |s| (QREFELT $ 64))) 

(SDEFUN |NUMERIC;complexNumeric;CPiC;32|
        ((|s| (|Complex| S)) (|n| (|PositiveInteger|))
         ($ (|Complex| (|Float|))))
        (SPROG ((|ans| (|Complex| (|Float|))) (|old| (|PositiveInteger|)))
               (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
                    (LETT |ans| (SPADCALL |s| (QREFELT $ 12)))
                    (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;complexNumeric;CC;33|
        ((|s| (|Complex| S)) ($ (|Complex| (|Float|))))
        (SPROG ((|s'| (|Union| S "failed")))
               (SEQ (LETT |s'| (SPADCALL |s| (QREFELT $ 78)))
                    (EXIT
                     (COND
                      ((QEQCAR |s'| 1)
                       (|error|
                        "Cannot compute the numerical value of a non-constant object"))
                      ('T (SPADCALL (QCDR |s'|) (QREFELT $ 25)))))))) 

(SDEFUN |NUMERIC;complexNumeric;CPiC;34|
        ((|s| (|Complex| S)) (|n| (|PositiveInteger|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|ans| (|Complex| (|Float|))) (|old| (|PositiveInteger|))
          (|s'| (|Union| S "failed")))
         (SEQ (LETT |s'| (SPADCALL |s| (QREFELT $ 78)))
              (EXIT
               (COND
                ((QEQCAR |s'| 1)
                 (|error|
                  "Cannot compute the numerical value of a non-constant object"))
                ('T
                 (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
                      (LETT |ans| (SPADCALL (QCDR |s'|) (QREFELT $ 25)))
                      (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))))))) 

(SDEFUN |NUMERIC;numeric;SPiF;35|
        ((|s| (S)) (|n| (|PositiveInteger|)) ($ (|Float|)))
        (SPROG ((|ans| (|Float|)) (|old| (|PositiveInteger|)))
               (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
                    (LETT |ans| (SPADCALL |s| (QREFELT $ 22)))
                    (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;numeric;PF;36| ((|p| (|Polynomial| S)) ($ (|Float|)))
        (SPROG ((|p'| (|Union| S "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 20)))
                    (EXIT
                     (COND
                      ((QEQCAR |p'| 1)
                       (|error|
                        "Can only compute the numerical value of a constant, real-valued polynomial"))
                      ('T (SPADCALL (QCDR |p'|) (QREFELT $ 22)))))))) 

(SDEFUN |NUMERIC;complexNumeric;PC;37|
        ((|p| (|Polynomial| S)) ($ (|Complex| (|Float|))))
        (SPROG ((|p'| (|Union| S "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 20)))
                    (EXIT
                     (COND
                      ((QEQCAR |p'| 1)
                       (|error|
                        "Cannot compute the numerical value of a non-constant polynomial"))
                      ('T (SPADCALL (QCDR |p'|) (QREFELT $ 25)))))))) 

(SDEFUN |NUMERIC;complexNumeric;PPiC;38|
        ((|p| (|Polynomial| S)) (|n| (|PositiveInteger|))
         ($ (|Complex| (|Float|))))
        (SPROG ((|p'| (|Union| S "failed")))
               (SEQ (LETT |p'| (SPADCALL |p| (QREFELT $ 20)))
                    (EXIT
                     (COND
                      ((QEQCAR |p'| 1)
                       (|error|
                        "Cannot compute the numerical value of a non-constant polynomial"))
                      ('T (SPADCALL (QCDR |p'|) |n| (QREFELT $ 27)))))))) 

(SDEFUN |NUMERIC;numeric;PPiF;39|
        ((|p| (|Polynomial| S)) (|n| (|PositiveInteger|)) ($ (|Float|)))
        (SPROG ((|ans| (|Float|)) (|old| (|PositiveInteger|)))
               (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
                    (LETT |ans| (SPADCALL |p| (QREFELT $ 79)))
                    (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;numeric;FF;40|
        ((|f| (|Fraction| (|Polynomial| S))) ($ (|Float|)))
        (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 32)) (QREFELT $ 79))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 33)) (QREFELT $ 79))
                  (QREFELT $ 34))) 

(SDEFUN |NUMERIC;complexNumeric;FC;41|
        ((|f| (|Fraction| (|Polynomial| S))) ($ (|Complex| (|Float|))))
        (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 32)) (QREFELT $ 80))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 33)) (QREFELT $ 80))
                  (QREFELT $ 36))) 

(SDEFUN |NUMERIC;complexNumeric;FPiC;42|
        ((|f| (|Fraction| (|Polynomial| S))) (|n| (|PositiveInteger|))
         ($ (|Complex| (|Float|))))
        (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 32)) |n| (QREFELT $ 81))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 33)) |n| (QREFELT $ 81))
                  (QREFELT $ 36))) 

(SDEFUN |NUMERIC;numeric;FPiF;43|
        ((|f| (|Fraction| (|Polynomial| S))) (|n| (|PositiveInteger|))
         ($ (|Float|)))
        (SPROG ((|ans| (|Float|)) (|old| (|PositiveInteger|)))
               (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
                    (LETT |ans| (SPADCALL |f| (QREFELT $ 83)))
                    (SPADCALL |old| (QREFELT $ 29)) (EXIT |ans|)))) 

(SDEFUN |NUMERIC;complexNumeric;FC;44|
        ((|f| (|Fraction| (|Polynomial| (|Complex| S))))
         ($ (|Complex| (|Float|))))
        (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 41)) (QREFELT $ 76))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 42)) (QREFELT $ 76))
                  (QREFELT $ 36))) 

(SDEFUN |NUMERIC;complexNumeric;FPiC;45|
        ((|f| (|Fraction| (|Polynomial| (|Complex| S))))
         (|n| (|PositiveInteger|)) ($ (|Complex| (|Float|))))
        (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 41)) |n| (QREFELT $ 77))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 42)) |n| (QREFELT $ 77))
                  (QREFELT $ 36))) 

(SDEFUN |NUMERIC;numeric;EF;46| ((|x| (|Expression| S)) ($ (|Float|)))
        (SPROG ((|x'| (|Union| (|Float|) "failed")))
               (SEQ
                (LETT |x'|
                      (SPADCALL (SPADCALL (ELT $ 45) |x| (QREFELT $ 50))
                                (QREFELT $ 51)))
                (EXIT
                 (COND
                  ((QEQCAR |x'| 1)
                   (|error|
                    "Can only compute the numerical value of a constant, real-valued Expression"))
                  ('T (QCDR |x'|))))))) 

(SDEFUN |NUMERIC;complexNumeric;EC;47|
        ((|x| (|Expression| S)) ($ (|Complex| (|Float|))))
        (SPROG ((|x'| (|Union| (|Complex| (|Float|)) "failed")))
               (SEQ
                (LETT |x'|
                      (SPADCALL (SPADCALL (ELT $ 25) |x| (QREFELT $ 92))
                                (QREFELT $ 69)))
                (EXIT
                 (COND
                  ((QEQCAR |x'| 1)
                   (|error|
                    "Cannot compute the numerical value of a non-constant expression"))
                  ('T (QCDR |x'|))))))) 

(SDEFUN |NUMERIC;numeric;EPiF;48|
        ((|x| (|Expression| S)) (|n| (|PositiveInteger|)) ($ (|Float|)))
        (SPROG
         ((|ans| (|Union| (|Float|) "failed")) (|x'| (|Expression| (|Float|)))
          (|old| (|PositiveInteger|)))
         (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
              (LETT |x'| (SPADCALL (ELT $ 45) |x| (QREFELT $ 50)))
              (LETT |ans| (SPADCALL |x'| (QREFELT $ 51)))
              (SPADCALL |old| (QREFELT $ 29))
              (EXIT
               (COND
                ((QEQCAR |ans| 1)
                 (|error|
                  "Can only compute the numerical value of a constant, real-valued Expression"))
                ('T (QCDR |ans|))))))) 

(SDEFUN |NUMERIC;complexNumeric;EPiC;49|
        ((|x| (|Expression| S)) (|n| (|PositiveInteger|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|ans| (|Union| (|Complex| (|Float|)) "failed"))
          (|x'| (|Expression| (|Complex| (|Float|))))
          (|old| (|PositiveInteger|)))
         (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
              (LETT |x'| (SPADCALL (ELT $ 25) |x| (QREFELT $ 92)))
              (LETT |ans| (SPADCALL |x'| (QREFELT $ 69)))
              (SPADCALL |old| (QREFELT $ 29))
              (EXIT
               (COND
                ((QEQCAR |ans| 1)
                 (|error|
                  "Cannot compute the numerical value of a non-constant expression"))
                ('T (QCDR |ans|))))))) 

(SDEFUN |NUMERIC;complexNumeric;EC;50|
        ((|x| (|Expression| (|Complex| S))) ($ (|Complex| (|Float|))))
        (SPROG ((|x'| (|Union| (|Complex| (|Float|)) "failed")))
               (SEQ
                (LETT |x'|
                      (SPADCALL (SPADCALL (ELT $ 12) |x| (QREFELT $ 68))
                                (QREFELT $ 69)))
                (EXIT
                 (COND
                  ((QEQCAR |x'| 1)
                   (|error|
                    "Cannot compute the numerical value of a non-constant expression"))
                  ('T (QCDR |x'|))))))) 

(SDEFUN |NUMERIC;complexNumeric;EPiC;51|
        ((|x| (|Expression| (|Complex| S))) (|n| (|PositiveInteger|))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|ans| (|Union| (|Complex| (|Float|)) "failed"))
          (|x'| (|Expression| (|Complex| (|Float|))))
          (|old| (|PositiveInteger|)))
         (SEQ (LETT |old| (SPADCALL |n| (QREFELT $ 29)))
              (LETT |x'| (SPADCALL (ELT $ 12) |x| (QREFELT $ 68)))
              (LETT |ans| (SPADCALL |x'| (QREFELT $ 69)))
              (SPADCALL |old| (QREFELT $ 29))
              (EXIT
               (COND
                ((QEQCAR |ans| 1)
                 (|error|
                  "Cannot compute the numerical value of a non-constant expression"))
                ('T (QCDR |ans|))))))) 

(DECLAIM (NOTINLINE |Numeric;|)) 

(DEFUN |Numeric| (#1=#:G942)
  (SPROG NIL
         (PROG (#2=#:G943)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Numeric|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Numeric;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Numeric|)))))))))) 

(DEFUN |Numeric;| (|#1|)
  (SPROG ((|pv$| NIL) (#1=#:G941 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Numeric| DV$1))
          (LETT $ (GETREFV 98))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (LETT #1#
                                                    (|HasCategory| |#1|
                                                                   '(|IntegralDomain|)))
                                              (AND #1#
                                                   (|HasCategory| |#1|
                                                                  '(|OrderedSet|)))
                                              (|HasCategory| |#1| '(|Ring|))
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|))))))
          (|haddProp| |$ConstructorCache| '|Numeric| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 14
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumericIfCan;PU;1|)
                        $))
             (QSETREFV $ 17
                       (CONS
                        (|dispatchFunction|
                         |NUMERIC;complexNumericIfCan;PPiU;2|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 24
                       (CONS (|dispatchFunction| |NUMERIC;numericIfCan;PU;3|)
                             $))
             (QSETREFV $ 26
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumericIfCan;PU;4|)
                        $))
             (QSETREFV $ 28
                       (CONS
                        (|dispatchFunction|
                         |NUMERIC;complexNumericIfCan;PPiU;5|)
                        $))
             (QSETREFV $ 30
                       (CONS (|dispatchFunction| |NUMERIC;numericIfCan;PPiU;6|)
                             $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 35
                       (CONS (|dispatchFunction| |NUMERIC;numericIfCan;FU;7|)
                             $))
             (QSETREFV $ 37
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumericIfCan;FU;8|)
                        $))
             (QSETREFV $ 38
                       (CONS
                        (|dispatchFunction|
                         |NUMERIC;complexNumericIfCan;FPiU;9|)
                        $))
             (QSETREFV $ 39
                       (CONS
                        (|dispatchFunction| |NUMERIC;numericIfCan;FPiU;10|) $))
             (QSETREFV $ 43
                       (CONS
                        (|dispatchFunction|
                         |NUMERIC;complexNumericIfCan;FU;11|)
                        $))
             (QSETREFV $ 44
                       (CONS
                        (|dispatchFunction|
                         |NUMERIC;complexNumericIfCan;FPiU;12|)
                        $))
             (COND
              ((|HasCategory| |#1| '(|OrderedSet|))
               (PROGN
                (QSETREFV $ 52
                          (CONS
                           (|dispatchFunction| |NUMERIC;numericIfCan;EU;13|)
                           $))
                (QSETREFV $ 59
                          (CONS
                           (|dispatchFunction|
                            |NUMERIC;complexNumericIfCan;EU;14|)
                           $))
                (QSETREFV $ 62
                          (CONS
                           (|dispatchFunction| |NUMERIC;numericIfCan;EPiU;15|)
                           $))
                (QSETREFV $ 63
                          (CONS
                           (|dispatchFunction|
                            |NUMERIC;complexNumericIfCan;EPiU;16|)
                           $))
                (COND
                 ((|HasCategory| |#1| '(|RealConstant|))
                  (PROGN
                   (QSETREFV $ 58
                             (CONS
                              (|dispatchFunction|
                               |NUMERIC;complexNumericIfCan;EU;17|)
                              $))
                   (QSETREFV $ 70
                             (CONS
                              (|dispatchFunction|
                               |NUMERIC;complexNumericIfCan;EPiU;18|)
                              $))))
                 ('T
                  (PROGN
                   (QSETREFV $ 58
                             (CONS
                              (|dispatchFunction|
                               |NUMERIC;complexNumericIfCan;EU;20|)
                              $))
                   (QSETREFV $ 70
                             (CONS
                              (|dispatchFunction|
                               |NUMERIC;complexNumericIfCan;EPiU;21|)
                              $)))))))))))
          (COND
           ((|HasCategory| |#1| '(|ConvertibleTo| (|Complex| (|Float|))))
            (PROGN
             (QSETREFV $ 25
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;SC;23|) $))
             (QSETREFV $ 27
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;SPiC;24|)
                        $))))
           ('T
            (PROGN
             (QSETREFV $ 25
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;SC;25|) $))
             (QSETREFV $ 27
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;SPiC;26|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 76
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;PC;27|) $))
             (QSETREFV $ 77
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;PPiC;28|)
                        $))
             (COND
              ((|HasCategory| |#1| '(|RealConstant|))
               (PROGN
                (QSETREFV $ 12
                          (CONS
                           (|dispatchFunction| |NUMERIC;complexNumeric;CC;29|)
                           $))
                (QSETREFV $ 16
                          (CONS
                           (|dispatchFunction|
                            |NUMERIC;complexNumeric;CPiC;30|)
                           $))))
              ((|HasCategory| (|Complex| |#1|)
                              '(|ConvertibleTo| (|Complex| (|Float|))))
               (PROGN
                (QSETREFV $ 12
                          (CONS
                           (|dispatchFunction| |NUMERIC;complexNumeric;CC;31|)
                           $))
                (QSETREFV $ 16
                          (CONS
                           (|dispatchFunction|
                            |NUMERIC;complexNumeric;CPiC;32|)
                           $))))
              ('T
               (PROGN
                (QSETREFV $ 12
                          (CONS
                           (|dispatchFunction| |NUMERIC;complexNumeric;CC;33|)
                           $))
                (QSETREFV $ 16
                          (CONS
                           (|dispatchFunction|
                            |NUMERIC;complexNumeric;CPiC;34|)
                           $))))))))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 79
                       (CONS (|dispatchFunction| |NUMERIC;numeric;PF;36|) $))
             (QSETREFV $ 80
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;PC;37|) $))
             (QSETREFV $ 81
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;PPiC;38|)
                        $))
             (QSETREFV $ 82
                       (CONS (|dispatchFunction| |NUMERIC;numeric;PPiF;39|)
                             $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 83
                       (CONS (|dispatchFunction| |NUMERIC;numeric;FF;40|) $))
             (QSETREFV $ 84
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;FC;41|) $))
             (QSETREFV $ 85
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;FPiC;42|)
                        $))
             (QSETREFV $ 86
                       (CONS (|dispatchFunction| |NUMERIC;numeric;FPiF;43|) $))
             (QSETREFV $ 87
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;FC;44|) $))
             (QSETREFV $ 88
                       (CONS
                        (|dispatchFunction| |NUMERIC;complexNumeric;FPiC;45|)
                        $))
             (COND
              ((|HasCategory| |#1| '(|OrderedSet|))
               (PROGN
                (QSETREFV $ 89
                          (CONS (|dispatchFunction| |NUMERIC;numeric;EF;46|)
                                $))
                (QSETREFV $ 93
                          (CONS
                           (|dispatchFunction| |NUMERIC;complexNumeric;EC;47|)
                           $))
                (QSETREFV $ 94
                          (CONS (|dispatchFunction| |NUMERIC;numeric;EPiF;48|)
                                $))
                (QSETREFV $ 95
                          (CONS
                           (|dispatchFunction|
                            |NUMERIC;complexNumeric;EPiC;49|)
                           $))
                (QSETREFV $ 96
                          (CONS
                           (|dispatchFunction| |NUMERIC;complexNumeric;EC;50|)
                           $))
                (QSETREFV $ 97
                          (CONS
                           (|dispatchFunction|
                            |NUMERIC;complexNumeric;EPiC;51|)
                           $))))))))
          $))) 

(MAKEPROP '|Numeric| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Union| 11 '#1="failed")
              (|Polynomial| 11) (0 . |retractIfCan|) (|Complex| 21)
              (|Complex| 6) (5 . |complexNumeric|) (|Union| 10 '#2="failed")
              (10 . |complexNumericIfCan|) (|PositiveInteger|)
              (15 . |complexNumeric|) (21 . |complexNumericIfCan|)
              (|Union| 6 '#1#) (|Polynomial| 6) (27 . |retractIfCan|) (|Float|)
              |NUMERIC;numeric;SF;22| (|Union| 21 '#3="failed")
              (32 . |numericIfCan|) (37 . |complexNumeric|)
              (42 . |complexNumericIfCan|) (47 . |complexNumeric|)
              (53 . |complexNumericIfCan|) (59 . |digits|)
              (64 . |numericIfCan|) (|Fraction| 19) (70 . |numer|)
              (75 . |denom|) (80 . /) (86 . |numericIfCan|) (91 . /)
              (97 . |complexNumericIfCan|) (102 . |complexNumericIfCan|)
              (108 . |numericIfCan|) (|Fraction| 8) (114 . |numer|)
              (119 . |denom|) (124 . |complexNumericIfCan|)
              (129 . |complexNumericIfCan|) (135 . |convert|) (|Expression| 21)
              (|Mapping| 21 6) (|Expression| 6) (|ExpressionFunctions2| 6 21)
              (140 . |map|) (146 . |retractIfCan|) (151 . |numericIfCan|)
              (156 . |coerce|) (|Expression| 11) (|Mapping| 11 6)
              (|ExpressionFunctions2| 6 11) (161 . |map|)
              (167 . |complexNumericIfCan|) (172 . |complexNumericIfCan|)
              (177 . |bits|) (181 . |bits|) (186 . |numericIfCan|)
              (192 . |complexNumericIfCan|) (198 . |convert|) (|Expression| 10)
              (|Mapping| 10 11) (|ExpressionFunctions2| 11 10) (203 . |map|)
              (209 . |retractIfCan|) (214 . |complexNumericIfCan|)
              (|ComplexFunctions2| 6 21) (220 . |map|) (226 . |convert|)
              (231 . |coerce|) |NUMERIC;numeric;SPiF;35|
              (236 . |complexNumeric|) (241 . |complexNumeric|)
              (247 . |retractIfCan|) (252 . |numeric|) (257 . |complexNumeric|)
              (262 . |complexNumeric|) (268 . |numeric|) (274 . |numeric|)
              (279 . |complexNumeric|) (284 . |complexNumeric|)
              (290 . |numeric|) (296 . |complexNumeric|)
              (301 . |complexNumeric|) (307 . |numeric|) (|Mapping| 10 6)
              (|ExpressionFunctions2| 6 10) (312 . |map|)
              (318 . |complexNumeric|) (323 . |numeric|)
              (329 . |complexNumeric|) (335 . |complexNumeric|)
              (340 . |complexNumeric|))
           '#(|numericIfCan| 346 |numeric| 379 |complexNumericIfCan| 423
              |complexNumeric| 489)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|numeric| ((|Float|) |#1|)) T)
                                   '((|numeric|
                                      ((|Float|) |#1| (|PositiveInteger|)))
                                     T)
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|)) |#1|))
                                     T)
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|)) |#1|
                                       (|PositiveInteger|)))
                                     T)
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|)) (|Complex| |#1|)))
                                     (|has| 6 (|CommutativeRing|)))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|)) (|Complex| |#1|)
                                       (|PositiveInteger|)))
                                     (|has| 6 (|CommutativeRing|)))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Polynomial| (|Complex| |#1|))))
                                     (|has| 6 (|CommutativeRing|)))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Polynomial| (|Complex| |#1|))
                                       (|PositiveInteger|)))
                                     (|has| 6 (|CommutativeRing|)))
                                   '((|numeric|
                                      ((|Float|) (|Polynomial| |#1|)))
                                     (|has| 6 (|Ring|)))
                                   '((|numeric|
                                      ((|Float|) (|Polynomial| |#1|)
                                       (|PositiveInteger|)))
                                     (|has| 6 (|Ring|)))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Polynomial| |#1|)))
                                     (|has| 6 (|Ring|)))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Polynomial| |#1|)
                                       (|PositiveInteger|)))
                                     (|has| 6 (|Ring|)))
                                   '((|numeric|
                                      ((|Float|)
                                       (|Fraction| (|Polynomial| |#1|))))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|numeric|
                                      ((|Float|)
                                       (|Fraction| (|Polynomial| |#1|))
                                       (|PositiveInteger|)))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Fraction| (|Polynomial| |#1|))))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Fraction| (|Polynomial| |#1|))
                                       (|PositiveInteger|)))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Fraction|
                                        (|Polynomial| (|Complex| |#1|)))))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Fraction|
                                        (|Polynomial| (|Complex| |#1|)))
                                       (|PositiveInteger|)))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|numeric|
                                      ((|Float|) (|Expression| |#1|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|numeric|
                                      ((|Float|) (|Expression| |#1|)
                                       (|PositiveInteger|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Expression| |#1|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Expression| |#1|)
                                       (|PositiveInteger|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Expression| (|Complex| |#1|))))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|complexNumeric|
                                      ((|Complex| (|Float|))
                                       (|Expression| (|Complex| |#1|))
                                       (|PositiveInteger|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) #2#)
                                       (|Polynomial| (|Complex| |#1|))))
                                     (|has| 6 (|CommutativeRing|)))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Polynomial| (|Complex| |#1|))
                                       (|PositiveInteger|)))
                                     (|has| 6 (|CommutativeRing|)))
                                   '((|numericIfCan|
                                      ((|Union| (|Float|) #3#)
                                       (|Polynomial| |#1|)))
                                     (|has| 6 (|Ring|)))
                                   '((|numericIfCan|
                                      ((|Union| (|Float|) "failed")
                                       (|Polynomial| |#1|)
                                       (|PositiveInteger|)))
                                     (|has| 6 (|Ring|)))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Polynomial| |#1|)))
                                     (|has| 6 (|Ring|)))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Polynomial| |#1|)
                                       (|PositiveInteger|)))
                                     (|has| 6 (|Ring|)))
                                   '((|numericIfCan|
                                      ((|Union| (|Float|) "failed")
                                       (|Fraction| (|Polynomial| |#1|))))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|numericIfCan|
                                      ((|Union| (|Float|) "failed")
                                       (|Fraction| (|Polynomial| |#1|))
                                       (|PositiveInteger|)))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Fraction| (|Polynomial| |#1|))))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Fraction| (|Polynomial| |#1|))
                                       (|PositiveInteger|)))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Fraction|
                                        (|Polynomial| (|Complex| |#1|)))))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Fraction|
                                        (|Polynomial| (|Complex| |#1|)))
                                       (|PositiveInteger|)))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|numericIfCan|
                                      ((|Union| (|Float|) "failed")
                                       (|Expression| |#1|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|numericIfCan|
                                      ((|Union| (|Float|) "failed")
                                       (|Expression| |#1|)
                                       (|PositiveInteger|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Expression| |#1|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Expression| |#1|)
                                       (|PositiveInteger|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Expression| (|Complex| |#1|))))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|))))
                                   '((|complexNumericIfCan|
                                      ((|Union| (|Complex| (|Float|)) "failed")
                                       (|Expression| (|Complex| |#1|))
                                       (|PositiveInteger|)))
                                     (AND (|has| 6 (|OrderedSet|))
                                          (|has| 6 (|IntegralDomain|)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 97
                                            '(1 8 7 0 9 1 0 10 11 12 1 0 13 8
                                              14 2 0 10 11 15 16 2 0 13 8 15 17
                                              1 19 18 0 20 1 0 23 19 24 1 0 10
                                              6 25 1 0 13 19 26 2 0 10 6 15 27
                                              2 0 13 19 15 28 1 21 15 15 29 2 0
                                              23 19 15 30 1 31 19 0 32 1 31 19
                                              0 33 2 21 0 0 0 34 1 0 23 31 35 2
                                              10 0 0 0 36 1 0 13 31 37 2 0 13
                                              31 15 38 2 0 23 31 15 39 1 40 8 0
                                              41 1 40 8 0 42 1 0 13 40 43 2 0
                                              13 40 15 44 1 6 21 0 45 2 49 46
                                              47 48 50 1 46 23 0 51 1 0 23 48
                                              52 1 11 0 6 53 2 56 54 55 48 57 1
                                              0 13 54 58 1 0 13 48 59 0 21 15
                                              60 1 21 15 15 61 2 0 23 48 15 62
                                              2 0 13 48 15 63 1 11 10 0 64 2 67
                                              65 66 54 68 1 65 13 0 69 2 0 13
                                              54 15 70 2 71 10 47 11 72 1 6 10
                                              0 73 1 10 0 21 74 1 0 10 8 76 2 0
                                              10 8 15 77 1 11 18 0 78 1 0 21 19
                                              79 1 0 10 19 80 2 0 10 19 15 81 2
                                              0 21 19 15 82 1 0 21 31 83 1 0 10
                                              31 84 2 0 10 31 15 85 2 0 21 31
                                              15 86 1 0 10 40 87 2 0 10 40 15
                                              88 1 0 21 48 89 2 91 65 90 48 92
                                              1 0 10 48 93 2 0 21 48 15 94 2 0
                                              10 48 15 95 1 0 10 54 96 2 0 10
                                              54 15 97 1 2 23 48 52 2 2 23 48
                                              15 62 1 1 23 31 35 2 1 23 31 15
                                              39 2 3 23 19 15 30 1 3 23 19 24 1
                                              2 21 48 89 2 2 21 48 15 94 1 1 21
                                              31 83 2 1 21 31 15 86 2 3 21 19
                                              15 82 1 3 21 19 79 2 0 21 6 15 75
                                              1 0 21 6 22 1 2 13 48 59 2 2 13
                                              48 15 63 2 2 13 54 15 70 1 2 13
                                              54 58 2 4 13 8 15 17 1 4 13 8 14
                                              1 1 13 31 37 2 1 13 31 15 38 2 1
                                              13 40 15 44 1 1 13 40 43 1 3 13
                                              19 26 2 3 13 19 15 28 1 2 10 48
                                              93 1 2 10 54 96 2 2 10 48 15 95 2
                                              2 10 54 15 97 1 4 10 11 12 1 4 10
                                              8 76 2 4 10 11 15 16 2 4 10 8 15
                                              77 1 1 10 31 84 2 1 10 31 15 85 2
                                              1 10 40 15 88 1 1 10 40 87 2 3 10
                                              19 15 81 1 3 10 19 80 1 0 10 6 25
                                              2 0 10 6 15 27)))))
           '|lookupComplete|)) 

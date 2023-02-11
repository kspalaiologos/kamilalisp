
(SDEFUN |FSPECF;abs;2F;1| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 13) |x| (QREFELT $ 45))) 

(SDEFUN |FSPECF;conjugate;2F;2| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 14) |x| (QREFELT $ 45))) 

(SDEFUN |FSPECF;Gamma;2F;3| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 15) |x| (QREFELT $ 45))) 

(SDEFUN |FSPECF;Gamma;3F;4| ((|a| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 16) |a| |x| (QREFELT $ 49))) 

(SDEFUN |FSPECF;Beta;3F;5| ((|x| (F)) (|y| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 17) |x| |y| (QREFELT $ 49))) 

(SDEFUN |FSPECF;digamma;2F;6| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 18) |x| (QREFELT $ 45))) 

(SDEFUN |FSPECF;polygamma;3F;7| ((|k| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 19) |k| |x| (QREFELT $ 49))) 

(SDEFUN |FSPECF;besselJ;3F;8| ((|a| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 20) |a| |x| (QREFELT $ 49))) 

(SDEFUN |FSPECF;besselY;3F;9| ((|a| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 21) |a| |x| (QREFELT $ 49))) 

(SDEFUN |FSPECF;besselI;3F;10| ((|a| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 22) |a| |x| (QREFELT $ 49))) 

(SDEFUN |FSPECF;besselK;3F;11| ((|a| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 23) |a| |x| (QREFELT $ 49))) 

(SDEFUN |FSPECF;airyAi;2F;12| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 24) |x| (QREFELT $ 45))) 

(SDEFUN |FSPECF;airyAiPrime;2F;13| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 25) |x| (QREFELT $ 45))) 

(SDEFUN |FSPECF;airyBi;2F;14| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 26) |x| (QREFELT $ 45))) 

(SDEFUN |FSPECF;airyBiPrime;2F;15| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 27) |x| (QREFELT $ 45))) 

(SDEFUN |FSPECF;lambertW;2F;16| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 28) |x| (QREFELT $ 45))) 

(SDEFUN |FSPECF;polylog;3F;17| ((|s| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 29) |s| |x| (QREFELT $ 49))) 

(SDEFUN |FSPECF;weierstrassP;4F;18| ((|g2| (F)) (|g3| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 30) |g2| |g3| |x| (QREFELT $ 64))) 

(SDEFUN |FSPECF;weierstrassPPrime;4F;19|
        ((|g2| (F)) (|g3| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 31) |g2| |g3| |x| (QREFELT $ 64))) 

(SDEFUN |FSPECF;weierstrassSigma;4F;20|
        ((|g2| (F)) (|g3| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 32) |g2| |g3| |x| (QREFELT $ 64))) 

(SDEFUN |FSPECF;weierstrassZeta;4F;21|
        ((|g2| (F)) (|g3| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 33) |g2| |g3| |x| (QREFELT $ 64))) 

(SDEFUN |FSPECF;hypergeometricF;2L2F;22|
        ((|a| (|List| F)) (|b| (|List| F)) (|z| (F)) ($ (F)))
        (SPROG
         ((|q| (F)) (|p| (F)) (|nbi| #1=(|NonNegativeInteger|)) (|nai| #1#))
         (SEQ (LETT |nai| (LENGTH |a|)) (LETT |nbi| (LENGTH |b|))
              (COND
               ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
                (COND ((<= |nai| (+ |nbi| 1)) (EXIT (|spadConstant| $ 74))))))
              (LETT |p| (SPADCALL (LENGTH |a|) (QREFELT $ 76)))
              (LETT |q| (SPADCALL (LENGTH |b|) (QREFELT $ 76)))
              (EXIT
               (SPADCALL (QREFELT $ 34)
                         (SPADCALL
                          (SPADCALL |a|
                                    (SPADCALL |b| (LIST |z|) (QREFELT $ 78))
                                    (QREFELT $ 78))
                          (LIST |p| |q|) (QREFELT $ 78))
                         (QREFELT $ 80)))))) 

(SDEFUN |FSPECF;meijerG;4L2F;23|
        ((|a| (|List| F)) (|b| (|List| F)) (|c| (|List| F)) (|d| (|List| F))
         (|z| (F)) ($ (F)))
        (SPROG ((|m2| (F)) (|m1| (F)) (|n2| (F)) (|n1| (F)))
               (SEQ (LETT |n1| (SPADCALL (LENGTH |a|) (QREFELT $ 76)))
                    (LETT |n2| (SPADCALL (LENGTH |b|) (QREFELT $ 76)))
                    (LETT |m1| (SPADCALL (LENGTH |c|) (QREFELT $ 76)))
                    (LETT |m2| (SPADCALL (LENGTH |d|) (QREFELT $ 76)))
                    (EXIT
                     (SPADCALL (QREFELT $ 35)
                               (SPADCALL
                                (SPADCALL |a|
                                          (SPADCALL |b|
                                                    (SPADCALL |c|
                                                              (SPADCALL |d|
                                                                        (LIST
                                                                         |z|)
                                                                        (QREFELT
                                                                         $ 78))
                                                              (QREFELT $ 78))
                                                    (QREFELT $ 78))
                                          (QREFELT $ 78))
                                (LIST |n1| |n2| |m1| |m2|) (QREFELT $ 78))
                               (QREFELT $ 80)))))) 

(SDEFUN |FSPECF;grad2|
        ((|l| (|List| F)) (|t| (|Symbol|)) (|op| (|BasicOperator|))
         (|d2| (|Mapping| F F F)) ($ (F)))
        (SPROG ((|dm| (F)) (|x2| (F)) (|x1| (F)))
               (SEQ (LETT |x1| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |x2| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (LETT |dm|
                          (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |x1| |t| (QREFELT $ 98))
                                (SPADCALL (QREFELT $ 84)
                                          (LIST
                                           (SPADCALL |op| (LIST |dm| |x2|)
                                                     (QREFELT $ 80))
                                           |dm| |x1|)
                                          (QREFELT $ 99))
                                (QREFELT $ 100))
                      (SPADCALL (SPADCALL |x2| |t| (QREFELT $ 98))
                                (SPADCALL |x1| |x2| |d2|) (QREFELT $ 100))
                      (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;grad3|
        ((|l| (|List| F)) (|t| (|Symbol|)) (|op| (|BasicOperator|))
         (|d3| (|Mapping| F F F F)) ($ (F)))
        (SPROG ((|dm2| (F)) (|dm1| (F)) (|x3| (F)) (|x2| (F)) (|x1| (F)))
               (SEQ (LETT |x1| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |x2| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (LETT |x3| (SPADCALL |l| 3 (QREFELT $ 95)))
                    (LETT |dm1|
                          (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
                    (LETT |dm2|
                          (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (SPADCALL |x1| |t| (QREFELT $ 98))
                                 (SPADCALL (QREFELT $ 84)
                                           (LIST
                                            (SPADCALL |op|
                                                      (LIST |dm1| |x2| |x3|)
                                                      (QREFELT $ 80))
                                            |dm1| |x1|)
                                           (QREFELT $ 99))
                                 (QREFELT $ 100))
                       (SPADCALL (SPADCALL |x2| |t| (QREFELT $ 98))
                                 (SPADCALL (QREFELT $ 84)
                                           (LIST
                                            (SPADCALL |op|
                                                      (LIST |x1| |dm2| |x3|)
                                                      (QREFELT $ 80))
                                            |dm2| |x2|)
                                           (QREFELT $ 99))
                                 (QREFELT $ 100))
                       (QREFELT $ 101))
                      (SPADCALL (SPADCALL |x3| |t| (QREFELT $ 98))
                                (SPADCALL |x1| |x2| |x3| |d3|) (QREFELT $ 100))
                      (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;grad4|
        ((|l| (|List| F)) (|t| (|Symbol|)) (|op| (|BasicOperator|))
         (|d4| (|Mapping| F F F F F)) ($ (F)))
        (SPROG
         ((|kd3| (F)) (|kd2| (F)) (|kd1| (F)) (|dm3| (F)) (|dm2| (F))
          (|dm1| (F)) (|x4| (F)) (|x3| (F)) (|x2| (F)) (|x1| (F)))
         (SEQ (LETT |x1| (SPADCALL |l| 1 (QREFELT $ 95)))
              (LETT |x2| (SPADCALL |l| 2 (QREFELT $ 95)))
              (LETT |x3| (SPADCALL |l| 3 (QREFELT $ 95)))
              (LETT |x4| (SPADCALL |l| 4 (QREFELT $ 95)))
              (LETT |dm1| (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
              (LETT |dm2| (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
              (LETT |dm3| (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
              (LETT |kd1|
                    (SPADCALL (QREFELT $ 84)
                              (LIST
                               (SPADCALL |op| (LIST |dm1| |x2| |x3| |x4|)
                                         (QREFELT $ 80))
                               |dm1| |x1|)
                              (QREFELT $ 99)))
              (LETT |kd2|
                    (SPADCALL (QREFELT $ 84)
                              (LIST
                               (SPADCALL |op| (LIST |x1| |dm2| |x3| |x4|)
                                         (QREFELT $ 80))
                               |dm2| |x2|)
                              (QREFELT $ 99)))
              (LETT |kd3|
                    (SPADCALL (QREFELT $ 84)
                              (LIST
                               (SPADCALL |op| (LIST |x1| |x2| |dm3| |x4|)
                                         (QREFELT $ 80))
                               |dm3| |x3|)
                              (QREFELT $ 99)))
              (EXIT
               (SPADCALL
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL |x1| |t| (QREFELT $ 98)) |kd1|
                            (QREFELT $ 100))
                  (SPADCALL (SPADCALL |x2| |t| (QREFELT $ 98)) |kd2|
                            (QREFELT $ 100))
                  (QREFELT $ 101))
                 (SPADCALL (SPADCALL |x3| |t| (QREFELT $ 98)) |kd3|
                           (QREFELT $ 100))
                 (QREFELT $ 101))
                (SPADCALL (SPADCALL |x4| |t| (QREFELT $ 98))
                          (SPADCALL |x1| |x2| |x3| |x4| |d4|) (QREFELT $ 100))
                (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;weierstrassPInverse;4F;27|
        ((|g2| (F)) (|g3| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 102) |g2| |g3| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eWeierstrassPInverse| ((|g2| (F)) (|g3| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 102) (LIST |g2| |g3| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elWeierstrassPInverse| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eWeierstrassPInverse| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eWeierstrassPInverseGrad_g2| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|s2| (F)) (|s1| (F)) (|delta| (F)) (|wpi| (F)) (|z| (F)) (|g3| (F))
          (|g2| (F)))
         (SEQ (LETT |g2| (SPADCALL |l| 1 (QREFELT $ 95)))
              (LETT |g3| (SPADCALL |l| 2 (QREFELT $ 95)))
              (LETT |z| (SPADCALL |l| 3 (QREFELT $ 95)))
              (LETT |wpi| (SPADCALL |g2| |g3| |z| (QREFELT $ 103)))
              (LETT |delta|
                    (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                              (SPADCALL 27 (SPADCALL |g3| 2 (QREFELT $ 107))
                                        (QREFELT $ 92))
                              (QREFELT $ 108)))
              (LETT |s1|
                    (SPADCALL
                     (SPADCALL (SPADCALL 18 |g3| (QREFELT $ 92))
                               (SPADCALL |g2| |g3| |wpi| (QREFELT $ 68))
                               (QREFELT $ 100))
                     (SPADCALL (SPADCALL |g2| 2 (QREFELT $ 107)) |wpi|
                               (QREFELT $ 100))
                     (QREFELT $ 108)))
              (LETT |s2|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL 36 |g3| (QREFELT $ 92))
                                (SPADCALL |z| 2 (QREFELT $ 107))
                                (QREFELT $ 100))
                      (SPADCALL
                       (SPADCALL 2 (SPADCALL |g2| 2 (QREFELT $ 107))
                                 (QREFELT $ 92))
                       |z| (QREFELT $ 100))
                      (QREFELT $ 108))
                     (SPADCALL (SPADCALL 6 |g2| (QREFELT $ 92)) |g3|
                               (QREFELT $ 100))
                     (QREFELT $ 108)))
              (EXIT
               (SPADCALL
                (SPADCALL |s1|
                          (SPADCALL |s2|
                                    (SPADCALL |g2| |g3| |wpi| (QREFELT $ 66))
                                    (QREFELT $ 109))
                          (QREFELT $ 101))
                (SPADCALL 4 |delta| (QREFELT $ 92)) (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;eWeierstrassPInverseGrad_g3| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|s2| (F)) (|s1| (F)) (|delta| (F)) (|wpi| (F)) (|z| (F)) (|g3| (F))
          (|g2| (F)))
         (SEQ (LETT |g2| (SPADCALL |l| 1 (QREFELT $ 95)))
              (LETT |g3| (SPADCALL |l| 2 (QREFELT $ 95)))
              (LETT |z| (SPADCALL |l| 3 (QREFELT $ 95)))
              (LETT |wpi| (SPADCALL |g2| |g3| |z| (QREFELT $ 103)))
              (LETT |delta|
                    (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                              (SPADCALL 27 (SPADCALL |g3| 2 (QREFELT $ 107))
                                        (QREFELT $ 92))
                              (QREFELT $ 108)))
              (LETT |s1|
                    (SPADCALL
                     (SPADCALL (SPADCALL 9 |g3| (QREFELT $ 92)) |wpi|
                               (QREFELT $ 100))
                     (SPADCALL (SPADCALL 6 |g2| (QREFELT $ 92))
                               (SPADCALL |g2| |g3| |wpi| (QREFELT $ 68))
                               (QREFELT $ 100))
                     (QREFELT $ 108)))
              (LETT |s2|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (SPADCALL 12 |g2| (QREFELT $ 92))
                                 (SPADCALL |z| 2 (QREFELT $ 107))
                                 (QREFELT $ 100))
                       (QREFELT $ 110))
                      (SPADCALL (SPADCALL 18 |g3| (QREFELT $ 92)) |z|
                                (QREFELT $ 100))
                      (QREFELT $ 101))
                     (SPADCALL 2 (SPADCALL |g2| 2 (QREFELT $ 107))
                               (QREFELT $ 92))
                     (QREFELT $ 101)))
              (EXIT
               (SPADCALL
                (SPADCALL |s1|
                          (SPADCALL |s2|
                                    (SPADCALL |g2| |g3| |wpi| (QREFELT $ 66))
                                    (QREFELT $ 109))
                          (QREFELT $ 101))
                (SPADCALL 2 |delta| (QREFELT $ 92)) (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;eWeierstrassPInverseGrad_z| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|z| (F)) (|g3| (F)) (|g2| (F)))
               (SEQ (LETT |g2| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |g3| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (LETT |z| (SPADCALL |l| 3 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL (|spadConstant| $ 74)
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL 4 (SPADCALL |z| 3 (QREFELT $ 107))
                                            (QREFELT $ 92))
                                  (SPADCALL |g2| |z| (QREFELT $ 100))
                                  (QREFELT $ 108))
                                 |g3| (QREFELT $ 108))
                                (QREFELT $ 113))
                               (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;whittakerM;4F;33| ((|k| (F)) (|m| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 116) |k| |m| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eWhittakerM| ((|k| (F)) (|m| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 116) (LIST |k| |m| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elWhittakerM| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eWhittakerM| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eWhittakerMGrad_z| ((|k| (F)) (|m| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (QREFELT $ 87) (SPADCALL |k| |z| (QREFELT $ 109))
                    (QREFELT $ 108))
          (SPADCALL |k| |m| |z| (QREFELT $ 117)) (QREFELT $ 100))
         (SPADCALL
          (SPADCALL
           (SPADCALL (SPADCALL (QREFELT $ 87) |k| (QREFELT $ 101)) |m|
                     (QREFELT $ 101))
           (SPADCALL (SPADCALL |k| (|spadConstant| $ 74) (QREFELT $ 101)) |m|
                     |z| (QREFELT $ 117))
           (QREFELT $ 100))
          |z| (QREFELT $ 109))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dWhittakerM| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad3| |l| |t| (QREFELT $ 116)
         (CONS (|function| |FSPECF;eWhittakerMGrad_z|) $) $)) 

(SDEFUN |FSPECF;whittakerW;4F;38| ((|k| (F)) (|m| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 120) |k| |m| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eWhittakerW| ((|k| (F)) (|m| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 120) (LIST |k| |m| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elWhittakerW| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eWhittakerW| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eWhittakerWGrad_z| ((|k| (F)) (|m| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (QREFELT $ 87) (SPADCALL |k| |z| (QREFELT $ 109))
                    (QREFELT $ 108))
          (SPADCALL |k| |m| |z| (QREFELT $ 121)) (QREFELT $ 100))
         (SPADCALL
          (SPADCALL (SPADCALL |k| (|spadConstant| $ 74) (QREFELT $ 101)) |m|
                    |z| (QREFELT $ 121))
          |z| (QREFELT $ 109))
         (QREFELT $ 108))) 

(SDEFUN |FSPECF;dWhittakerW| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad3| |l| |t| (QREFELT $ 120)
         (CONS (|function| |FSPECF;eWhittakerWGrad_z|) $) $)) 

(SDEFUN |FSPECF;angerJ;3F;43| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 122) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eAngerJ| ((|v| (F)) (|z| (F)) ($ (F)))
        (COND
         ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
          (SPADCALL
           (SPADCALL (SPADCALL |v| (SPADCALL (QREFELT $ 124)) (QREFELT $ 100))
                     (QREFELT $ 125))
           (SPADCALL |v| (SPADCALL (QREFELT $ 124)) (QREFELT $ 100))
           (QREFELT $ 109)))
         ('T (SPADCALL (QREFELT $ 122) (LIST |v| |z|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elAngerJ| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eAngerJ| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eAngerJGrad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 123))
           (QREFELT $ 110))
          (SPADCALL
           (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 123)) (QREFELT $ 100))
           |z| (QREFELT $ 109))
          (QREFELT $ 101))
         (SPADCALL
          (SPADCALL (SPADCALL |v| (SPADCALL (QREFELT $ 124)) (QREFELT $ 100))
                    (QREFELT $ 125))
          (SPADCALL (SPADCALL (QREFELT $ 124)) |z| (QREFELT $ 100))
          (QREFELT $ 109))
         (QREFELT $ 108))) 

(SDEFUN |FSPECF;dAngerJ| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 122)
         (CONS (|function| |FSPECF;eAngerJGrad_z|) $) $)) 

(SDEFUN |FSPECF;eeAngerJ| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (QREFELT $ 122) |l| (QREFELT $ 99))) 

(SDEFUN |FSPECF;weberE;3F;49| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 126) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eWeberE| ((|v| (F)) (|z| (F)) ($ (F)))
        (COND
         ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
          (SPADCALL
           (SPADCALL 2
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (SPADCALL (QREFELT $ 87) |v| (QREFELT $ 100))
                                 (SPADCALL (QREFELT $ 124)) (QREFELT $ 100))
                       (QREFELT $ 125))
                      2 (QREFELT $ 128))
                     (QREFELT $ 92))
           (SPADCALL |v| (SPADCALL (QREFELT $ 124)) (QREFELT $ 100))
           (QREFELT $ 109)))
         ('T (SPADCALL (QREFELT $ 126) (LIST |v| |z|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elWeberE| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eWeberE| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eWeberEGrad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 127))
           (QREFELT $ 110))
          (SPADCALL
           (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 127)) (QREFELT $ 100))
           |z| (QREFELT $ 109))
          (QREFELT $ 101))
         (SPADCALL
          (SPADCALL (|spadConstant| $ 74)
                    (SPADCALL
                     (SPADCALL |v| (SPADCALL (QREFELT $ 124)) (QREFELT $ 100))
                     (QREFELT $ 129))
                    (QREFELT $ 108))
          (SPADCALL (SPADCALL (QREFELT $ 124)) |z| (QREFELT $ 100))
          (QREFELT $ 109))
         (QREFELT $ 108))) 

(SDEFUN |FSPECF;dWeberE| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 126)
         (CONS (|function| |FSPECF;eWeberEGrad_z|) $) $)) 

(SDEFUN |FSPECF;eeWeberE| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (QREFELT $ 126) |l| (QREFELT $ 99))) 

(SDEFUN |FSPECF;struveH;3F;55| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 130) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eStruveH| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 130) (LIST |v| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elStruveH| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eStruveH| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eStruveHGrad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 131))
           (QREFELT $ 110))
          (SPADCALL
           (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 131)) (QREFELT $ 100))
           |z| (QREFELT $ 109))
          (QREFELT $ 101))
         (SPADCALL
          (SPADCALL (SPADCALL (QREFELT $ 87) |z| (QREFELT $ 100)) |v|
                    (QREFELT $ 132))
          (SPADCALL (SPADCALL (SPADCALL (QREFELT $ 124)) (QREFELT $ 113))
                    (SPADCALL (SPADCALL |v| (QREFELT $ 94) (QREFELT $ 101))
                              (QREFELT $ 48))
                    (QREFELT $ 100))
          (QREFELT $ 109))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dStruveH| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 130)
         (CONS (|function| |FSPECF;eStruveHGrad_z|) $) $)) 

(SDEFUN |FSPECF;struveL;3F;60| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 133) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eStruveL| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 133) (LIST |v| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elStruveL| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eStruveL| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eStruveLGrad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                    (QREFELT $ 134))
          (SPADCALL
           (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 134)) (QREFELT $ 100))
           |z| (QREFELT $ 109))
          (QREFELT $ 101))
         (SPADCALL
          (SPADCALL (SPADCALL (QREFELT $ 87) |z| (QREFELT $ 100)) |v|
                    (QREFELT $ 132))
          (SPADCALL (SPADCALL (SPADCALL (QREFELT $ 124)) (QREFELT $ 113))
                    (SPADCALL (SPADCALL |v| (QREFELT $ 94) (QREFELT $ 101))
                              (QREFELT $ 48))
                    (QREFELT $ 100))
          (QREFELT $ 109))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dStruveL| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 133)
         (CONS (|function| |FSPECF;eStruveLGrad_z|) $) $)) 

(SDEFUN |FSPECF;hankelH1;3F;65| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 135) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eHankelH1| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 135) (LIST |v| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elHankelH1| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eHankelH1| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eHankelH1Grad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                    (QREFELT $ 136))
          (QREFELT $ 110))
         (SPADCALL
          (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 136)) (QREFELT $ 100)) |z|
          (QREFELT $ 109))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dHankelH1| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 135)
         (CONS (|function| |FSPECF;eHankelH1Grad_z|) $) $)) 

(SDEFUN |FSPECF;hankelH2;3F;70| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 137) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eHankelH2| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 137) (LIST |v| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elHankelH2| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eHankelH2| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eHankelH2Grad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                    (QREFELT $ 138))
          (QREFELT $ 110))
         (SPADCALL
          (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 138)) (QREFELT $ 100)) |z|
          (QREFELT $ 109))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dHankelH2| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 137)
         (CONS (|function| |FSPECF;eHankelH2Grad_z|) $) $)) 

(SDEFUN |FSPECF;lommelS1;4F;75| ((|m| (F)) (|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 139) |m| |v| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eLommelS1| ((|m| (F)) (|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 139) (LIST |m| |v| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elLommelS1| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eLommelS1| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eLommelS1Grad_z| ((|m| (F)) (|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL |v| (SPADCALL |m| |v| |z| (QREFELT $ 140))
                     (QREFELT $ 100))
           |z| (QREFELT $ 109))
          (QREFELT $ 110))
         (SPADCALL
          (SPADCALL (SPADCALL |m| |v| (QREFELT $ 101)) (|spadConstant| $ 74)
                    (QREFELT $ 108))
          (SPADCALL (SPADCALL |m| (|spadConstant| $ 74) (QREFELT $ 108))
                    (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 108)) |z|
                    (QREFELT $ 140))
          (QREFELT $ 100))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dLommelS1| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad3| |l| |t| (QREFELT $ 139)
         (CONS (|function| |FSPECF;eLommelS1Grad_z|) $) $)) 

(SDEFUN |FSPECF;lommelS2;4F;80| ((|mu| (F)) (|nu| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 141) |mu| |nu| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eLommelS2| ((|mu| (F)) (|nu| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 141) (LIST |mu| |nu| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elLommelS2| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eLommelS2| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eLommelS2Grad_z| ((|m| (F)) (|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL |v| (SPADCALL |m| |v| |z| (QREFELT $ 142))
                     (QREFELT $ 100))
           |z| (QREFELT $ 109))
          (QREFELT $ 110))
         (SPADCALL
          (SPADCALL (SPADCALL |m| |v| (QREFELT $ 101)) (|spadConstant| $ 74)
                    (QREFELT $ 108))
          (SPADCALL (SPADCALL |m| (|spadConstant| $ 74) (QREFELT $ 108))
                    (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 108)) |z|
                    (QREFELT $ 142))
          (QREFELT $ 100))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dLommelS2| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad3| |l| |t| (QREFELT $ 141)
         (CONS (|function| |FSPECF;eLommelS2Grad_z|) $) $)) 

(SDEFUN |FSPECF;kummerM;4F;85| ((|mu| (F)) (|nu| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 143) |mu| |nu| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eKummerM| ((|a| (F)) (|b| (F)) (|z| (F)) ($ (F)))
        (COND
         ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 74))
         ('T (SPADCALL (QREFELT $ 143) (LIST |a| |b| |z|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elKummerM| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eKummerM| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eKummerMGrad_z| ((|a| (F)) (|b| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL (SPADCALL |z| |a| (QREFELT $ 101)) |b| (QREFELT $ 108))
           (SPADCALL |a| |b| |z| (QREFELT $ 144)) (QREFELT $ 100))
          (SPADCALL (SPADCALL |b| |a| (QREFELT $ 108))
                    (SPADCALL
                     (SPADCALL |a| (|spadConstant| $ 74) (QREFELT $ 108)) |b|
                     |z| (QREFELT $ 144))
                    (QREFELT $ 100))
          (QREFELT $ 101))
         |z| (QREFELT $ 109))) 

(SDEFUN |FSPECF;dKummerM| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad3| |l| |t| (QREFELT $ 143)
         (CONS (|function| |FSPECF;eKummerMGrad_z|) $) $)) 

(SDEFUN |FSPECF;kummerU;4F;90| ((|a| (F)) (|b| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 145) |a| |b| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eKummerU| ((|a| (F)) (|b| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 145) (LIST |a| |b| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elKummerU| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eKummerU| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eKummerUGrad_z| ((|a| (F)) (|b| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL (SPADCALL |z| |a| (QREFELT $ 101)) |b| (QREFELT $ 108))
           (SPADCALL |a| |b| |z| (QREFELT $ 146)) (QREFELT $ 100))
          (SPADCALL (SPADCALL |a| (|spadConstant| $ 74) (QREFELT $ 108)) |b|
                    |z| (QREFELT $ 146))
          (QREFELT $ 108))
         |z| (QREFELT $ 109))) 

(SDEFUN |FSPECF;dKummerU| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad3| |l| |t| (QREFELT $ 145)
         (CONS (|function| |FSPECF;eKummerUGrad_z|) $) $)) 

(SDEFUN |FSPECF;legendreP;4F;95| ((|nu| (F)) (|mu| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 147) |nu| |mu| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eLegendreP| ((|nu| (F)) (|mu| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 147) (LIST |nu| |mu| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elLegendreP| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eLegendreP| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eLegendrePGrad_z| ((|nu| (F)) (|mu| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL |nu| |mu| (QREFELT $ 108)) (|spadConstant| $ 74)
                    (QREFELT $ 101))
          (SPADCALL (SPADCALL |nu| (|spadConstant| $ 74) (QREFELT $ 101)) |mu|
                    |z| (QREFELT $ 148))
          (QREFELT $ 100))
         (SPADCALL
          (SPADCALL (SPADCALL |nu| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                    (QREFELT $ 100))
          (SPADCALL |nu| |mu| |z| (QREFELT $ 148)) (QREFELT $ 100))
         (QREFELT $ 108))) 

(SDEFUN |FSPECF;dLegendreP| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad3| |l| |t| (QREFELT $ 147)
         (CONS (|function| |FSPECF;eLegendrePGrad_z|) $) $)) 

(SDEFUN |FSPECF;legendreQ;4F;100| ((|nu| (F)) (|mu| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 149) |nu| |mu| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eLegendreQ| ((|nu| (F)) (|mu| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 149) (LIST |nu| |mu| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elLegendreQ| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eLegendreQ| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eLegendreQGrad_z| ((|nu| (F)) (|mu| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL |nu| |mu| (QREFELT $ 108)) (|spadConstant| $ 74)
                    (QREFELT $ 101))
          (SPADCALL (SPADCALL |nu| (|spadConstant| $ 74) (QREFELT $ 101)) |mu|
                    |z| (QREFELT $ 150))
          (QREFELT $ 100))
         (SPADCALL
          (SPADCALL (SPADCALL |nu| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                    (QREFELT $ 100))
          (SPADCALL |nu| |mu| |z| (QREFELT $ 150)) (QREFELT $ 100))
         (QREFELT $ 108))) 

(SDEFUN |FSPECF;dLegendreQ| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad3| |l| |t| (QREFELT $ 149)
         (CONS (|function| |FSPECF;eLegendreQGrad_z|) $) $)) 

(SDEFUN |FSPECF;kelvinBei;3F;105| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 151) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eKelvinBei| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 151) (LIST |v| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elKelvinBei| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eKelvinBei| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eKelvinBeiGrad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (QREFELT $ 87)
                    (SPADCALL (SPADCALL 2 (QREFELT $ 76)) (QREFELT $ 113))
                    (QREFELT $ 100))
          (SPADCALL
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 152))
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 153))
           (QREFELT $ 108))
          (QREFELT $ 100))
         (SPADCALL
          (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 152)) (QREFELT $ 100)) |z|
          (QREFELT $ 109))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dKelvinBei| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 151)
         (CONS (|function| |FSPECF;eKelvinBeiGrad_z|) $) $)) 

(SDEFUN |FSPECF;kelvinBer;3F;110| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 154) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eKelvinBer| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 154) (LIST |v| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elKelvinBer| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eKelvinBer| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eKelvinBerGrad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (QREFELT $ 87)
                    (SPADCALL (SPADCALL 2 (QREFELT $ 76)) (QREFELT $ 113))
                    (QREFELT $ 100))
          (SPADCALL
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 153))
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 152))
           (QREFELT $ 101))
          (QREFELT $ 100))
         (SPADCALL
          (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 153)) (QREFELT $ 100)) |z|
          (QREFELT $ 109))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dKelvinBer| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 154)
         (CONS (|function| |FSPECF;eKelvinBerGrad_z|) $) $)) 

(SDEFUN |FSPECF;kelvinKei;3F;115| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 155) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eKelvinKei| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 155) (LIST |v| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elKelvinKei| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eKelvinKei| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eKelvinKeiGrad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (QREFELT $ 87)
                    (SPADCALL (SPADCALL 2 (QREFELT $ 76)) (QREFELT $ 113))
                    (QREFELT $ 100))
          (SPADCALL
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 156))
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 157))
           (QREFELT $ 108))
          (QREFELT $ 100))
         (SPADCALL
          (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 156)) (QREFELT $ 100)) |z|
          (QREFELT $ 109))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dKelvinKei| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 155)
         (CONS (|function| |FSPECF;eKelvinKeiGrad_z|) $) $)) 

(SDEFUN |FSPECF;kelvinKer;3F;120| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 158) |v| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eKelvinKer| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 158) (LIST |v| |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elKelvinKer| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eKelvinKer| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eKelvinKerGrad_z| ((|v| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (QREFELT $ 87)
                    (SPADCALL (SPADCALL 2 (QREFELT $ 76)) (QREFELT $ 113))
                    (QREFELT $ 100))
          (SPADCALL
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 157))
           (SPADCALL (SPADCALL |v| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                     (QREFELT $ 156))
           (QREFELT $ 101))
          (QREFELT $ 100))
         (SPADCALL
          (SPADCALL |v| (SPADCALL |v| |z| (QREFELT $ 157)) (QREFELT $ 100)) |z|
          (QREFELT $ 109))
         (QREFELT $ 101))) 

(SDEFUN |FSPECF;dKelvinKer| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 158)
         (CONS (|function| |FSPECF;eKelvinKerGrad_z|) $) $)) 

(SDEFUN |FSPECF;ellipticK;2F;125| ((|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 159) |m| (QREFELT $ 45))) 

(SDEFUN |FSPECF;eEllipticK| ((|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 159) (LIST |m|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elEllipticK| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eEllipticK| (SPADCALL |l| 1 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;dEllipticK| ((|m| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL (QREFELT $ 87)
                   (SPADCALL (SPADCALL |m| (QREFELT $ 161))
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 74) |m|
                                        (QREFELT $ 108))
                              (SPADCALL |m| (QREFELT $ 160)) (QREFELT $ 100))
                             (QREFELT $ 108))
                   (QREFELT $ 100))
         (SPADCALL |m| (SPADCALL (|spadConstant| $ 74) |m| (QREFELT $ 108))
                   (QREFELT $ 100))
         (QREFELT $ 109))) 

(SDEFUN |FSPECF;ellipticE;2F;129| ((|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 166) |m| (QREFELT $ 45))) 

(SDEFUN |FSPECF;eEllipticE| ((|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 166) (LIST |m|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elEllipticE| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eEllipticE| (SPADCALL |l| 1 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;dEllipticE| ((|m| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL (QREFELT $ 87)
                   (SPADCALL (SPADCALL |m| (QREFELT $ 161))
                             (SPADCALL |m| (QREFELT $ 160)) (QREFELT $ 108))
                   (QREFELT $ 100))
         |m| (QREFELT $ 109))) 

(SDEFUN |FSPECF;ellipticE;3F;133| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 167) |z| |m| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eEllipticE2| ((|z| (F)) (|m| (F)) ($ (F)))
        (COND
         ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 70))
         ((SPADCALL |z| (|spadConstant| $ 74) (QREFELT $ 72))
          (|FSPECF;eEllipticE| |m| $))
         ('T (SPADCALL (QREFELT $ 167) (LIST |z| |m|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elEllipticE2| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eEllipticE2| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eEllipticE2Grad_z| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 74)
                                 (SPADCALL |m| (SPADCALL |z| 2 (QREFELT $ 107))
                                           (QREFELT $ 100))
                                 (QREFELT $ 108))
                       (QREFELT $ 113))
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 74)
                                 (SPADCALL |z| 2 (QREFELT $ 107))
                                 (QREFELT $ 108))
                       (QREFELT $ 113))
                      (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;eEllipticE2Grad_m| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (QREFELT $ 87)
                                (SPADCALL (SPADCALL |z| |m| (QREFELT $ 168))
                                          (SPADCALL |z| |m| (QREFELT $ 169))
                                          (QREFELT $ 108))
                                (QREFELT $ 100))
                      |m| (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;inEllipticE2| ((|li| (|List| (|InputForm|))) ($ (|InputForm|)))
        (SPADCALL (CONS (SPADCALL '|ellipticE| (QREFELT $ 171)) |li|)
                  (QREFELT $ 172))) 

(SDEFUN |FSPECF;ellipticF;3F;139| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 175) |z| |m| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eEllipticF| ((|z| (F)) (|m| (F)) ($ (F)))
        (COND
         ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 70))
         ((SPADCALL |z| (|spadConstant| $ 74) (QREFELT $ 72))
          (SPADCALL |m| (QREFELT $ 160)))
         ('T (SPADCALL (QREFELT $ 175) (LIST |z| |m|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elEllipticF| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eEllipticF| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eEllipticFGrad_z| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL (|spadConstant| $ 74)
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 74)
                                           (SPADCALL |m|
                                                     (SPADCALL |z| 2
                                                               (QREFELT $ 107))
                                                     (QREFELT $ 100))
                                           (QREFELT $ 108))
                                 (QREFELT $ 113))
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 74)
                                           (SPADCALL |z| 2 (QREFELT $ 107))
                                           (QREFELT $ 108))
                                 (QREFELT $ 113))
                                (QREFELT $ 100))
                               (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;eEllipticFGrad_m| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (QREFELT $ 87)
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |z| |m| (QREFELT $ 168))
                                            (SPADCALL
                                             (SPADCALL (|spadConstant| $ 74)
                                                       |m| (QREFELT $ 108))
                                             (SPADCALL |z| |m| (QREFELT $ 169))
                                             (QREFELT $ 100))
                                            (QREFELT $ 108))
                                  |m| (QREFELT $ 109))
                                 (SPADCALL
                                  (SPADCALL |z|
                                            (SPADCALL
                                             (SPADCALL (|spadConstant| $ 74)
                                                       (SPADCALL |z| 2
                                                                 (QREFELT $
                                                                          107))
                                                       (QREFELT $ 108))
                                             (QREFELT $ 113))
                                            (QREFELT $ 100))
                                  (SPADCALL
                                   (SPADCALL (|spadConstant| $ 74)
                                             (SPADCALL |m|
                                                       (SPADCALL |z| 2
                                                                 (QREFELT $
                                                                          107))
                                                       (QREFELT $ 100))
                                             (QREFELT $ 108))
                                   (QREFELT $ 113))
                                  (QREFELT $ 109))
                                 (QREFELT $ 108))
                                (QREFELT $ 100))
                      (SPADCALL (|spadConstant| $ 74) |m| (QREFELT $ 108))
                      (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;ellipticPi;4F;144| ((|z| (F)) (|n| (F)) (|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 176) |z| |n| |m| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eEllipticPi| ((|z| (F)) (|n| (F)) (|m| (F)) ($ (F)))
        (COND
         ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 70))
         ('T (SPADCALL (QREFELT $ 176) (LIST |z| |n| |m|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elEllipticPi| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eEllipticPi| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eEllipticPiGrad_z| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|n| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |n| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 3 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL (|spadConstant| $ 74)
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 74)
                                           (SPADCALL |n|
                                                     (SPADCALL |z| 2
                                                               (QREFELT $ 107))
                                                     (QREFELT $ 100))
                                           (QREFELT $ 108))
                                 (SPADCALL
                                  (SPADCALL (|spadConstant| $ 74)
                                            (SPADCALL |m|
                                                      (SPADCALL |z| 2
                                                                (QREFELT $
                                                                         107))
                                                      (QREFELT $ 100))
                                            (QREFELT $ 108))
                                  (QREFELT $ 113))
                                 (QREFELT $ 100))
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 74)
                                           (SPADCALL |z| 2 (QREFELT $ 107))
                                           (QREFELT $ 108))
                                 (QREFELT $ 113))
                                (QREFELT $ 100))
                               (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;eEllipticPiGrad_n| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|t4| (F)) (|t3| (F)) (|t2| (F)) (|t1| (F)) (|m| (F)) (|n| (F))
          (|z| (F)))
         (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
              (LETT |n| (SPADCALL |l| 2 (QREFELT $ 95)))
              (LETT |m| (SPADCALL |l| 3 (QREFELT $ 95)))
              (LETT |t1|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (SPADCALL |n| 2 (QREFELT $ 107)) |m|
                                 (QREFELT $ 108))
                       (SPADCALL |z| |n| |m| (QREFELT $ 177)) (QREFELT $ 100))
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 108))
                        (SPADCALL |n| |m| (QREFELT $ 108)) (QREFELT $ 100))
                       |n| (QREFELT $ 100))
                      (QREFELT $ 109))
                     (QREFELT $ 110)))
              (LETT |t2|
                    (SPADCALL (SPADCALL |z| |m| (QREFELT $ 169))
                              (SPADCALL
                               (SPADCALL |n| (|spadConstant| $ 74)
                                         (QREFELT $ 108))
                               |n| (QREFELT $ 100))
                              (QREFELT $ 109)))
              (LETT |t3|
                    (SPADCALL
                     (SPADCALL (SPADCALL |z| |m| (QREFELT $ 168))
                               (SPADCALL
                                (SPADCALL |n| (|spadConstant| $ 74)
                                          (QREFELT $ 108))
                                (SPADCALL |n| |m| (QREFELT $ 108))
                                (QREFELT $ 100))
                               (QREFELT $ 109))
                     (QREFELT $ 110)))
              (LETT |t4|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |n| |z| (QREFELT $ 100))
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 74)
                                           (SPADCALL |m|
                                                     (SPADCALL |z| 2
                                                               (QREFELT $ 107))
                                                     (QREFELT $ 100))
                                           (QREFELT $ 108))
                                 (QREFELT $ 113))
                                (QREFELT $ 100))
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 74)
                                 (SPADCALL |z| 2 (QREFELT $ 107))
                                 (QREFELT $ 108))
                       (QREFELT $ 113))
                      (QREFELT $ 100))
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 74)
                                 (SPADCALL |n| (SPADCALL |z| 2 (QREFELT $ 107))
                                           (QREFELT $ 100))
                                 (QREFELT $ 108))
                       (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 108))
                       (QREFELT $ 100))
                      (SPADCALL |n| |m| (QREFELT $ 108)) (QREFELT $ 100))
                     (QREFELT $ 109)))
              (EXIT
               (SPADCALL (QREFELT $ 87)
                         (SPADCALL
                          (SPADCALL (SPADCALL |t1| |t2| (QREFELT $ 101)) |t3|
                                    (QREFELT $ 101))
                          |t4| (QREFELT $ 101))
                         (QREFELT $ 100)))))) 

(SDEFUN |FSPECF;eEllipticPiGrad_m| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|t2| (F)) (|t1| (F)) (|m| (F)) (|n| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |n| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 3 (QREFELT $ 95)))
                    (LETT |t1|
                          (SPADCALL
                           (SPADCALL (SPADCALL |m| |z| (QREFELT $ 100))
                                     (SPADCALL
                                      (SPADCALL (|spadConstant| $ 74)
                                                (SPADCALL |z| 2
                                                          (QREFELT $ 107))
                                                (QREFELT $ 108))
                                      (QREFELT $ 113))
                                     (QREFELT $ 100))
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 74)
                                      (SPADCALL |m|
                                                (SPADCALL |z| 2
                                                          (QREFELT $ 107))
                                                (QREFELT $ 100))
                                      (QREFELT $ 108))
                            (QREFELT $ 113))
                           (QREFELT $ 109)))
                    (LETT |t2|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |z| |m| (QREFELT $ 168))
                                      (QREFELT $ 110))
                            |t1| (QREFELT $ 101))
                           (SPADCALL (|spadConstant| $ 74) |m| (QREFELT $ 108))
                           (QREFELT $ 109)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (QREFELT $ 87)
                                (SPADCALL
                                 (SPADCALL |z| |n| |m| (QREFELT $ 177)) |t2|
                                 (QREFELT $ 101))
                                (QREFELT $ 100))
                      (SPADCALL |n| |m| (QREFELT $ 108)) (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;jacobiSn;3F;150| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 178) |z| |m| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eJacobiSn| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPROG ((#1=#:G1151 NIL) (|args| (|List| F)))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
                   (|spadConstant| $ 70))
                  ('T
                   (SEQ
                    (COND
                     ((SPADCALL |z| (QREFELT $ 175) (QREFELT $ 180))
                      (SEQ
                       (LETT |args|
                             (SPADCALL (SPADCALL |z| (QREFELT $ 182))
                                       (QREFELT $ 184)))
                       (EXIT
                        (COND
                         ((SPADCALL |m| (SPADCALL |args| 2 (QREFELT $ 95))
                                    (QREFELT $ 72))
                          (PROGN
                           (LETT #1# (SPADCALL |args| 1 (QREFELT $ 95)))
                           (GO #2=#:G1150))))))))
                    (EXIT
                     (SPADCALL (QREFELT $ 178) (LIST |z| |m|)
                               (QREFELT $ 99)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |FSPECF;elJacobiSn| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eJacobiSn| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;jacobiGradHelper| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL |z|
                   (SPADCALL
                    (SPADCALL (SPADCALL |z| |m| (QREFELT $ 179)) |m|
                              (QREFELT $ 168))
                    (SPADCALL (|spadConstant| $ 74) |m| (QREFELT $ 108))
                    (QREFELT $ 109))
                   (QREFELT $ 108))
         |m| (QREFELT $ 109))) 

(SDEFUN |FSPECF;eJacobiSnGrad_z| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL (SPADCALL |z| |m| (QREFELT $ 185))
                               (SPADCALL |z| |m| (QREFELT $ 186))
                               (QREFELT $ 100)))))) 

(SDEFUN |FSPECF;eJacobiSnGrad_m| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL (QREFELT $ 87)
                               (SPADCALL
                                (SPADCALL (|FSPECF;eJacobiSnGrad_z| |l| $)
                                          (|FSPECF;jacobiGradHelper| |z| |m| $)
                                          (QREFELT $ 100))
                                (SPADCALL
                                 (SPADCALL (SPADCALL |z| |m| (QREFELT $ 179))
                                           (SPADCALL
                                            (SPADCALL |z| |m| (QREFELT $ 185))
                                            2 (QREFELT $ 128))
                                           (QREFELT $ 100))
                                 (SPADCALL (|spadConstant| $ 74) |m|
                                           (QREFELT $ 108))
                                 (QREFELT $ 109))
                                (QREFELT $ 101))
                               (QREFELT $ 100)))))) 

(SDEFUN |FSPECF;jacobiCn;3F;156| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 187) |z| |m| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eJacobiCn| ((|z| (F)) (|m| (F)) ($ (F)))
        (COND
         ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 74))
         ('T (SPADCALL (QREFELT $ 187) (LIST |z| |m|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elJacobiCn| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eJacobiCn| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eJacobiCnGrad_z| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |z| |m| (QREFELT $ 179))
                                (SPADCALL |z| |m| (QREFELT $ 186))
                                (QREFELT $ 100))
                      (QREFELT $ 110)))))) 

(SDEFUN |FSPECF;eJacobiCnGrad_m| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL (QREFELT $ 87)
                               (SPADCALL
                                (SPADCALL (|FSPECF;eJacobiCnGrad_z| |l| $)
                                          (|FSPECF;jacobiGradHelper| |z| |m| $)
                                          (QREFELT $ 100))
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |z| |m| (QREFELT $ 179))
                                            2 (QREFELT $ 128))
                                  (SPADCALL |z| |m| (QREFELT $ 185))
                                  (QREFELT $ 100))
                                 (SPADCALL (|spadConstant| $ 74) |m|
                                           (QREFELT $ 108))
                                 (QREFELT $ 109))
                                (QREFELT $ 108))
                               (QREFELT $ 100)))))) 

(SDEFUN |FSPECF;jacobiDn;3F;161| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 188) |z| |m| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eJacobiDn| ((|z| (F)) (|m| (F)) ($ (F)))
        (COND
         ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 74))
         ('T (SPADCALL (QREFELT $ 188) (LIST |z| |m|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elJacobiDn| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eJacobiDn| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eJacobiDnGrad_z| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL |m| (SPADCALL |z| |m| (QREFELT $ 179))
                                 (QREFELT $ 100))
                       (SPADCALL |z| |m| (QREFELT $ 185)) (QREFELT $ 100))
                      (QREFELT $ 110)))))) 

(SDEFUN |FSPECF;eJacobiDnGrad_m| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL (QREFELT $ 87)
                               (SPADCALL
                                (SPADCALL (|FSPECF;eJacobiDnGrad_z| |l| $)
                                          (|FSPECF;jacobiGradHelper| |z| |m| $)
                                          (QREFELT $ 100))
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |z| |m| (QREFELT $ 179))
                                            2 (QREFELT $ 128))
                                  (SPADCALL |z| |m| (QREFELT $ 186))
                                  (QREFELT $ 100))
                                 (SPADCALL (|spadConstant| $ 74) |m|
                                           (QREFELT $ 108))
                                 (QREFELT $ 109))
                                (QREFELT $ 108))
                               (QREFELT $ 100)))))) 

(SDEFUN |FSPECF;jacobiZeta;3F;166| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 189) |z| |m| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eJacobiZeta| ((|z| (F)) (|m| (F)) ($ (F)))
        (COND
         ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 70))
         ('T (SPADCALL (QREFELT $ 189) (LIST |z| |m|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elJacobiZeta| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eJacobiZeta| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eJacobiZetaGrad_z| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|dn| (F)) (|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (LETT |dn| (SPADCALL |z| |m| (QREFELT $ 186)))
                    (EXIT
                     (SPADCALL (SPADCALL |dn| |dn| (QREFELT $ 100))
                               (SPADCALL (SPADCALL |m| (QREFELT $ 161))
                                         (SPADCALL |m| (QREFELT $ 160))
                                         (QREFELT $ 109))
                               (QREFELT $ 108)))))) 

(SDEFUN |FSPECF;eJacobiZetaGrad_m| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|res4| (F)) (|res3| (F)) (|res2| (F)) (|res1| (F)) (|dn| (F))
          (|er| (F)) (|ee| (F)) (|ek| (F)) (|m| (F)) (|z| (F)))
         (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
              (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
              (LETT |ek| (SPADCALL |m| (QREFELT $ 160)))
              (LETT |ee| (SPADCALL |m| (QREFELT $ 161)))
              (LETT |er| (SPADCALL |ee| |ek| (QREFELT $ 109)))
              (LETT |dn| (SPADCALL |z| |m| (QREFELT $ 186)))
              (LETT |res1|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |dn| |dn| (QREFELT $ 100)) |m|
                                (QREFELT $ 101))
                      (|spadConstant| $ 74) (QREFELT $ 108))
                     (SPADCALL |z| |m| (QREFELT $ 190)) (QREFELT $ 100)))
              (LETT |res2|
                    (SPADCALL |res1|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL |m| (|spadConstant| $ 74)
                                           (QREFELT $ 108))
                                 |z| (QREFELT $ 100))
                                |dn| (QREFELT $ 100))
                               |dn| (QREFELT $ 100))
                              (QREFELT $ 101)))
              (LETT |res3|
                    (SPADCALL |res2|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL |m|
                                          (SPADCALL |z| |m| (QREFELT $ 185))
                                          (QREFELT $ 100))
                                (SPADCALL |z| |m| (QREFELT $ 186))
                                (QREFELT $ 100))
                               (SPADCALL |z| |m| (QREFELT $ 179))
                               (QREFELT $ 100))
                              (QREFELT $ 108)))
              (LETT |res4|
                    (SPADCALL |res3|
                              (SPADCALL
                               (SPADCALL |z|
                                         (SPADCALL
                                          (SPADCALL (|spadConstant| $ 74) |m|
                                                    (QREFELT $ 108))
                                          (SPADCALL |dn| |dn| (QREFELT $ 100))
                                          (QREFELT $ 101))
                                         (QREFELT $ 100))
                               |er| (QREFELT $ 100))
                              (QREFELT $ 101)))
              (EXIT
               (SPADCALL
                (SPADCALL (QREFELT $ 87)
                          (SPADCALL |res4|
                                    (SPADCALL
                                     (SPADCALL |z| |er| (QREFELT $ 100)) |er|
                                     (QREFELT $ 100))
                                    (QREFELT $ 108))
                          (QREFELT $ 100))
                (SPADCALL (SPADCALL |m| |m| (QREFELT $ 100)) |m|
                          (QREFELT $ 108))
                (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;jacobiTheta;3F;171| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 191) |z| |m| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eJacobiTheta| ((|z| (F)) (|m| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 191) (LIST |z| |m|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elJacobiTheta| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eJacobiTheta| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eJacobiThetaGrad_z| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (EXIT
                     (SPADCALL (SPADCALL |z| |m| (QREFELT $ 190))
                               (SPADCALL |z| |m| (QREFELT $ 192))
                               (QREFELT $ 100)))))) 

(SDEFUN |FSPECF;eJacobiThetaGrad_m| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|dm| (F)) (|m| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |m| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (LETT |dm|
                          (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
                    (EXIT
                     (SPADCALL (QREFELT $ 84)
                               (LIST
                                (SPADCALL (QREFELT $ 191) (LIST |z| |dm|)
                                          (QREFELT $ 80))
                                |dm| |m|)
                               (QREFELT $ 99)))))) 

(SDEFUN |FSPECF;lerchPhi;4F;176| ((|z| (F)) (|s| (F)) (|a| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 193) |z| |s| |a| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eLerchPhi| ((|z| (F)) (|s| (F)) (|a| (F)) ($ (F)))
        (COND
         ((SPADCALL |a| (|spadConstant| $ 74) (QREFELT $ 72))
          (SPADCALL (SPADCALL |s| |z| (QREFELT $ 63)) |z| (QREFELT $ 109)))
         ('T (SPADCALL (QREFELT $ 193) (LIST |z| |s| |a|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elLerchPhi| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eLerchPhi| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;dLerchPhi| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (SPROG ((|dm| (F)) (|da| (F)) (|dz| (F)) (|a| (F)) (|s| (F)) (|z| (F)))
               (SEQ (LETT |z| (SPADCALL |l| 1 (QREFELT $ 95)))
                    (LETT |s| (SPADCALL |l| 2 (QREFELT $ 95)))
                    (LETT |a| (SPADCALL |l| 3 (QREFELT $ 95)))
                    (LETT |dz|
                          (SPADCALL
                           (SPADCALL (SPADCALL |z| |t| (QREFELT $ 98))
                                     (SPADCALL
                                      (SPADCALL |z|
                                                (SPADCALL |s|
                                                          (|spadConstant| $ 74)
                                                          (QREFELT $ 108))
                                                |a| (QREFELT $ 194))
                                      (SPADCALL |a|
                                                (SPADCALL |z| |s| |a|
                                                          (QREFELT $ 194))
                                                (QREFELT $ 100))
                                      (QREFELT $ 108))
                                     (QREFELT $ 100))
                           |z| (QREFELT $ 109)))
                    (LETT |da|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |a| |t| (QREFELT $ 98)) |s|
                                      (QREFELT $ 100))
                            (SPADCALL |z|
                                      (SPADCALL |s| (|spadConstant| $ 74)
                                                (QREFELT $ 101))
                                      |a| (QREFELT $ 194))
                            (QREFELT $ 100))
                           (QREFELT $ 110)))
                    (LETT |dm|
                          (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (SPADCALL |s| |t| (QREFELT $ 98))
                                 (SPADCALL (QREFELT $ 84)
                                           (LIST
                                            (SPADCALL (QREFELT $ 193)
                                                      (LIST |z| |dm| |a|)
                                                      (QREFELT $ 80))
                                            |dm| |s|)
                                           (QREFELT $ 99))
                                 (QREFELT $ 100))
                       |dz| (QREFELT $ 101))
                      |da| (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;riemannZeta;2F;180| ((|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 195) |z| (QREFELT $ 45))) 

(SDEFUN |FSPECF;eRiemannZeta| ((|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 195) (LIST |z|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;elRiemannZeta| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eRiemannZeta| (SPADCALL |l| 1 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;charlierC;4F;183| ((|n| (F)) (|a| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 36) |n| |a| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eCharlierC| ((|n| (F)) (|a| (F)) (|z| (F)) ($ (F)))
        (COND
         ((SPADCALL |n| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 74))
         ((SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 72))
          (SPADCALL (SPADCALL |z| |a| (QREFELT $ 108)) |a| (QREFELT $ 109)))
         ('T (SPADCALL (QREFELT $ 36) (LIST |n| |a| |z|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elCharlierC| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eCharlierC| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;hermiteH;3F;186| ((|n| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 37) |n| |z| (QREFELT $ 49))) 

(SDEFUN |FSPECF;eHermiteH| ((|n| (F)) (|z| (F)) ($ (F)))
        (COND
         ((SPADCALL |n| (SPADCALL (|spadConstant| $ 74) (QREFELT $ 110))
                    (QREFELT $ 72))
          (|spadConstant| $ 70))
         ((SPADCALL |n| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 74))
         ((SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 72))
          (SPADCALL (SPADCALL 2 (QREFELT $ 76)) |z| (QREFELT $ 100)))
         ('T (SPADCALL (QREFELT $ 37) (LIST |n| |z|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elHermiteH| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eHermiteH| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eHermiteHGrad_z| ((|n| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (SPADCALL (SPADCALL 2 (QREFELT $ 76)) |n| (QREFELT $ 100))
                  (SPADCALL
                   (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 108)) |z|
                   (QREFELT $ 198))
                  (QREFELT $ 100))) 

(SDEFUN |FSPECF;dHermiteH| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad2| |l| |t| (QREFELT $ 37)
         (CONS (|function| |FSPECF;eHermiteHGrad_z|) $) $)) 

(SDEFUN |FSPECF;jacobiP;5F;191|
        ((|n| (F)) (|a| (F)) (|b| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 38) |n| |a| |b| |z| (QREFELT $ 199))) 

(SDEFUN |FSPECF;eJacobiP| ((|n| (F)) (|a| (F)) (|b| (F)) (|z| (F)) ($ (F)))
        (COND
         ((SPADCALL |n| (SPADCALL (|spadConstant| $ 74) (QREFELT $ 110))
                    (QREFELT $ 72))
          (|spadConstant| $ 70))
         ((SPADCALL |n| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 74))
         ((SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 72))
          (SPADCALL
           (SPADCALL (QREFELT $ 87) (SPADCALL |a| |b| (QREFELT $ 108))
                     (QREFELT $ 100))
           (SPADCALL
            (SPADCALL (|spadConstant| $ 74)
                      (SPADCALL (QREFELT $ 87)
                                (SPADCALL |a| |b| (QREFELT $ 101))
                                (QREFELT $ 100))
                      (QREFELT $ 101))
            |z| (QREFELT $ 100))
           (QREFELT $ 101)))
         ('T (SPADCALL (QREFELT $ 38) (LIST |n| |a| |b| |z|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elJacobiP| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eJacobiP| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95))
         (SPADCALL |l| 4 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eJacobiPGrad_z|
        ((|n| (F)) (|a| (F)) (|b| (F)) (|z| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL (QREFELT $ 87)
                   (SPADCALL
                    (SPADCALL (SPADCALL |a| |b| (QREFELT $ 101)) |n|
                              (QREFELT $ 101))
                    (|spadConstant| $ 74) (QREFELT $ 101))
                   (QREFELT $ 100))
         (SPADCALL (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 108))
                   (SPADCALL |a| (|spadConstant| $ 74) (QREFELT $ 101))
                   (SPADCALL |b| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                   (QREFELT $ 200))
         (QREFELT $ 100))) 

(SDEFUN |FSPECF;dJacobiP| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad4| |l| |t| (QREFELT $ 38)
         (CONS (|function| |FSPECF;eJacobiPGrad_z|) $) $)) 

(SDEFUN |FSPECF;laguerreL;4F;196| ((|n| (F)) (|a| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 39) |n| |a| |z| (QREFELT $ 64))) 

(SDEFUN |FSPECF;eLaguerreL| ((|n| (F)) (|a| (F)) (|z| (F)) ($ (F)))
        (COND
         ((SPADCALL |n| (SPADCALL (|spadConstant| $ 74) (QREFELT $ 110))
                    (QREFELT $ 72))
          (|spadConstant| $ 70))
         ((SPADCALL |n| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 74))
         ((SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 72))
          (SPADCALL (SPADCALL (|spadConstant| $ 74) |a| (QREFELT $ 101)) |z|
                    (QREFELT $ 108)))
         ('T (SPADCALL (QREFELT $ 39) (LIST |n| |a| |z|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elLaguerreL| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eLaguerreL| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;eLaguerreLGrad_z| ((|n| (F)) (|a| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 108))
                  (SPADCALL |a| (|spadConstant| $ 74) (QREFELT $ 101)) |z|
                  (QREFELT $ 201))) 

(SDEFUN |FSPECF;dLaguerreL| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (|FSPECF;grad3| |l| |t| (QREFELT $ 39)
         (CONS (|function| |FSPECF;eLaguerreLGrad_z|) $) $)) 

(SDEFUN |FSPECF;meixnerM;5F;201|
        ((|n| (F)) (|b| (F)) (|c| (F)) (|z| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 40) |n| |b| |c| |z| (QREFELT $ 199))) 

(SDEFUN |FSPECF;eMeixnerM| ((|n| (F)) (|b| (F)) (|c| (F)) (|z| (F)) ($ (F)))
        (COND
         ((SPADCALL |n| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 74))
         ((SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 72))
          (SPADCALL
           (SPADCALL
            (SPADCALL (SPADCALL |c| (|spadConstant| $ 74) (QREFELT $ 108)) |z|
                      (QREFELT $ 100))
            (SPADCALL |c| |b| (QREFELT $ 100)) (QREFELT $ 109))
           (|spadConstant| $ 74) (QREFELT $ 101)))
         ('T (SPADCALL (QREFELT $ 40) (LIST |n| |b| |c| |z|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;elMeixnerM| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;eMeixnerM| (SPADCALL |l| 1 (QREFELT $ 95))
         (SPADCALL |l| 2 (QREFELT $ 95)) (SPADCALL |l| 3 (QREFELT $ 95))
         (SPADCALL |l| 4 (QREFELT $ 95)) $)) 

(SDEFUN |FSPECF;belong?;BoB;204| ((|op| (|BasicOperator|)) ($ (|Boolean|)))
        (SPADCALL |op| (QREFELT $ 8) (QREFELT $ 203))) 

(SDEFUN |FSPECF;operator;2Bo;205|
        ((|op| (|BasicOperator|)) ($ (|BasicOperator|)))
        (COND ((SPADCALL |op| '|abs| (QREFELT $ 205)) (QREFELT $ 13))
              ((SPADCALL |op| '|conjugate| (QREFELT $ 205)) (QREFELT $ 14))
              ((SPADCALL |op| '|Gamma| (QREFELT $ 205)) (QREFELT $ 15))
              ((SPADCALL |op| '|Gamma2| (QREFELT $ 205)) (QREFELT $ 16))
              ((SPADCALL |op| '|Beta| (QREFELT $ 205)) (QREFELT $ 17))
              ((SPADCALL |op| '|digamma| (QREFELT $ 205)) (QREFELT $ 18))
              ((SPADCALL |op| '|polygamma| (QREFELT $ 205)) (QREFELT $ 19))
              ((SPADCALL |op| '|besselJ| (QREFELT $ 205)) (QREFELT $ 20))
              ((SPADCALL |op| '|besselY| (QREFELT $ 205)) (QREFELT $ 21))
              ((SPADCALL |op| '|besselI| (QREFELT $ 205)) (QREFELT $ 22))
              ((SPADCALL |op| '|besselK| (QREFELT $ 205)) (QREFELT $ 23))
              ((SPADCALL |op| '|airyAi| (QREFELT $ 205)) (QREFELT $ 24))
              ((SPADCALL |op| '|airyAiPrime| (QREFELT $ 205)) (QREFELT $ 25))
              ((SPADCALL |op| '|airyBi| (QREFELT $ 205)) (QREFELT $ 26))
              ((SPADCALL |op| '|airyBiPrime| (QREFELT $ 205)) (QREFELT $ 27))
              ((SPADCALL |op| '|lambertW| (QREFELT $ 205)) (QREFELT $ 28))
              ((SPADCALL |op| '|polylog| (QREFELT $ 205)) (QREFELT $ 29))
              ((SPADCALL |op| '|weierstrassP| (QREFELT $ 205)) (QREFELT $ 30))
              ((SPADCALL |op| '|weierstrassPPrime| (QREFELT $ 205))
               (QREFELT $ 31))
              ((SPADCALL |op| '|weierstrassSigma| (QREFELT $ 205))
               (QREFELT $ 32))
              ((SPADCALL |op| '|weierstrassZeta| (QREFELT $ 205))
               (QREFELT $ 33))
              ((SPADCALL |op| '|hypergeometricF| (QREFELT $ 205))
               (QREFELT $ 34))
              ((SPADCALL |op| '|meijerG| (QREFELT $ 205)) (QREFELT $ 35))
              ((SPADCALL |op| '|weierstrassPInverse| (QREFELT $ 205))
               (QREFELT $ 102))
              ((SPADCALL |op| '|whittakerM| (QREFELT $ 205)) (QREFELT $ 116))
              ((SPADCALL |op| '|whittakerW| (QREFELT $ 205)) (QREFELT $ 120))
              ((SPADCALL |op| '|angerJ| (QREFELT $ 205)) (QREFELT $ 122))
              ((SPADCALL |op| '|weberE| (QREFELT $ 205)) (QREFELT $ 126))
              ((SPADCALL |op| '|struveH| (QREFELT $ 205)) (QREFELT $ 130))
              ((SPADCALL |op| '|struveL| (QREFELT $ 205)) (QREFELT $ 133))
              ((SPADCALL |op| '|hankelH1| (QREFELT $ 205)) (QREFELT $ 135))
              ((SPADCALL |op| '|hankelH2| (QREFELT $ 205)) (QREFELT $ 137))
              ((SPADCALL |op| '|lommelS1| (QREFELT $ 205)) (QREFELT $ 139))
              ((SPADCALL |op| '|lommelS2| (QREFELT $ 205)) (QREFELT $ 141))
              ((SPADCALL |op| '|kummerM| (QREFELT $ 205)) (QREFELT $ 143))
              ((SPADCALL |op| '|kummerU| (QREFELT $ 205)) (QREFELT $ 145))
              ((SPADCALL |op| '|legendreP| (QREFELT $ 205)) (QREFELT $ 147))
              ((SPADCALL |op| '|legendreQ| (QREFELT $ 205)) (QREFELT $ 149))
              ((SPADCALL |op| '|kelvinBei| (QREFELT $ 205)) (QREFELT $ 151))
              ((SPADCALL |op| '|kelvinBer| (QREFELT $ 205)) (QREFELT $ 154))
              ((SPADCALL |op| '|kelvinKei| (QREFELT $ 205)) (QREFELT $ 155))
              ((SPADCALL |op| '|kelvinKer| (QREFELT $ 205)) (QREFELT $ 158))
              ((SPADCALL |op| '|ellipticK| (QREFELT $ 205)) (QREFELT $ 159))
              ((SPADCALL |op| '|ellipticE| (QREFELT $ 205)) (QREFELT $ 166))
              ((SPADCALL |op| '|ellipticE2| (QREFELT $ 205)) (QREFELT $ 167))
              ((SPADCALL |op| '|ellipticF| (QREFELT $ 205)) (QREFELT $ 175))
              ((SPADCALL |op| '|ellipticPi| (QREFELT $ 205)) (QREFELT $ 176))
              ((SPADCALL |op| '|jacobiSn| (QREFELT $ 205)) (QREFELT $ 178))
              ((SPADCALL |op| '|jacobiCn| (QREFELT $ 205)) (QREFELT $ 187))
              ((SPADCALL |op| '|jacobiDn| (QREFELT $ 205)) (QREFELT $ 188))
              ((SPADCALL |op| '|jacobiZeta| (QREFELT $ 205)) (QREFELT $ 189))
              ((SPADCALL |op| '|jacobiTheta| (QREFELT $ 205)) (QREFELT $ 191))
              ((SPADCALL |op| '|lerchPhi| (QREFELT $ 205)) (QREFELT $ 193))
              ((SPADCALL |op| '|riemannZeta| (QREFELT $ 205)) (QREFELT $ 195))
              ((SPADCALL |op| '|charlierC| (QREFELT $ 205)) (QREFELT $ 36))
              ((SPADCALL |op| '|hermiteH| (QREFELT $ 205)) (QREFELT $ 37))
              ((SPADCALL |op| '|jacobiP| (QREFELT $ 205)) (QREFELT $ 38))
              ((SPADCALL |op| '|laguerreL| (QREFELT $ 205)) (QREFELT $ 39))
              ((SPADCALL |op| '|meixnerM| (QREFELT $ 205)) (QREFELT $ 40))
              ((SPADCALL |op| '|%logGamma| (QREFELT $ 205)) (QREFELT $ 41))
              ((SPADCALL |op| '|%eis| (QREFELT $ 205)) (QREFELT $ 42))
              ((SPADCALL |op| '|%erfs| (QREFELT $ 205)) (QREFELT $ 43))
              ((SPADCALL |op| '|%erfis| (QREFELT $ 205)) (QREFELT $ 44))
              ('T (|error| "Not a special operator")))) 

(SDEFUN |FSPECF;iGamma| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (|spadConstant| $ 74) (QREFELT $ 72)) |x|)
              ('T (SPADCALL (QREFELT $ 15) |x| (QREFELT $ 207))))) 

(SDEFUN |FSPECF;iabs| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 208)) (|spadConstant| $ 70))
              ((SPADCALL |x| (QREFELT $ 209)) (|spadConstant| $ 74))
              ((SPADCALL |x| (QREFELT $ 13) (QREFELT $ 180)) |x|)
              ((SPADCALL |x| (QREFELT $ 14) (QREFELT $ 180))
               (SPADCALL (QREFELT $ 13)
                         (SPADCALL
                          (SPADCALL (SPADCALL |x| (QREFELT $ 182))
                                    (QREFELT $ 184))
                          1 (QREFELT $ 95))
                         (QREFELT $ 207)))
              ((SPADCALL |x| (|spadConstant| $ 70) (QREFELT $ 210))
               (SPADCALL (QREFELT $ 13) (SPADCALL |x| (QREFELT $ 110))
                         (QREFELT $ 207)))
              ('T (SPADCALL (QREFELT $ 13) |x| (QREFELT $ 207))))) 

(SDEFUN |FSPECF;iconjugate| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 208)) (|spadConstant| $ 70))
              ((SPADCALL |x| (QREFELT $ 14) (QREFELT $ 180))
               (SPADCALL
                (SPADCALL (SPADCALL |x| (QREFELT $ 182)) (QREFELT $ 184)) 1
                (QREFELT $ 95)))
              ((SPADCALL |x| (QREFELT $ 13) (QREFELT $ 180)) |x|)
              ('T (SPADCALL (QREFELT $ 14) |x| (QREFELT $ 207))))) 

(SDEFUN |FSPECF;iBeta| ((|x| (F)) (|y| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 17) (LIST |x| |y|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;idigamma| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 18) |x| (QREFELT $ 207))) 

(SDEFUN |FSPECF;iiipolygamma| ((|n| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 19) (LIST |n| |x|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;iiiBesselJ| ((|x| (F)) (|y| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 20) (LIST |x| |y|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;iiiBesselY| ((|x| (F)) (|y| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 21) (LIST |x| |y|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;iiiBesselI| ((|x| (F)) (|y| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 22) (LIST |x| |y|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;iiiBesselK| ((|x| (F)) (|y| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 23) (LIST |x| |y|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;iAiryAi;2F;216| ((|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |x| (QREFELT $ 208))
          (SPADCALL (|spadConstant| $ 74)
                    (SPADCALL
                     (SPADCALL (SPADCALL 3 (QREFELT $ 76)) (QREFELT $ 93)
                               (QREFELT $ 132))
                     (SPADCALL (QREFELT $ 93) (QREFELT $ 48)) (QREFELT $ 100))
                    (QREFELT $ 109)))
         ('T (SPADCALL (QREFELT $ 24) |x| (QREFELT $ 207))))) 

(SDEFUN |FSPECF;iAiryAiPrime;2F;217| ((|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |x| (QREFELT $ 208))
          (SPADCALL
           (SPADCALL (|spadConstant| $ 74)
                     (SPADCALL
                      (SPADCALL (SPADCALL 3 (QREFELT $ 76)) (QREFELT $ 88)
                                (QREFELT $ 132))
                      (SPADCALL (QREFELT $ 88) (QREFELT $ 48)) (QREFELT $ 100))
                     (QREFELT $ 109))
           (QREFELT $ 110)))
         ('T (SPADCALL (QREFELT $ 25) |x| (QREFELT $ 207))))) 

(SDEFUN |FSPECF;iAiryBi;2F;218| ((|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |x| (QREFELT $ 208))
          (SPADCALL (|spadConstant| $ 74)
                    (SPADCALL
                     (SPADCALL (SPADCALL 3 (QREFELT $ 76)) (QREFELT $ 90)
                               (QREFELT $ 132))
                     (SPADCALL (QREFELT $ 93) (QREFELT $ 48)) (QREFELT $ 100))
                    (QREFELT $ 109)))
         ('T (SPADCALL (QREFELT $ 26) |x| (QREFELT $ 207))))) 

(SDEFUN |FSPECF;iAiryBiPrime;2F;219| ((|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |x| (QREFELT $ 208))
          (SPADCALL
           (SPADCALL (SPADCALL 3 (QREFELT $ 76)) (QREFELT $ 90)
                     (QREFELT $ 132))
           (SPADCALL (QREFELT $ 88) (QREFELT $ 48)) (QREFELT $ 109)))
         ('T (SPADCALL (QREFELT $ 27) |x| (QREFELT $ 207))))) 

(SDEFUN |FSPECF;iAiryAi;2F;220| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 24) |x| (QREFELT $ 207))) 

(SDEFUN |FSPECF;iAiryAiPrime;2F;221| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 25) |x| (QREFELT $ 207))) 

(SDEFUN |FSPECF;iAiryBi;2F;222| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 26) |x| (QREFELT $ 207))) 

(SDEFUN |FSPECF;iAiryBiPrime;2F;223| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 27) |x| (QREFELT $ 207))) 

(SDEFUN |FSPECF;iLambertW;2F;224| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 208)) (|spadConstant| $ 70))
              ((SPADCALL |x| (SPADCALL (|spadConstant| $ 74) (QREFELT $ 215))
                         (QREFELT $ 72))
               (|spadConstant| $ 74))
              ((SPADCALL |x|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 74) (QREFELT $ 110))
                           (QREFELT $ 215))
                          (QREFELT $ 110))
                         (QREFELT $ 72))
               (SPADCALL (|spadConstant| $ 74) (QREFELT $ 110)))
              ('T (SPADCALL (QREFELT $ 28) |x| (QREFELT $ 207))))) 

(SDEFUN |FSPECF;iLambertW;2F;225| ((|x| (F)) ($ (F)))
        (COND ((SPADCALL |x| (QREFELT $ 208)) (|spadConstant| $ 70))
              ('T (SPADCALL (QREFELT $ 28) |x| (QREFELT $ 207))))) 

(SDEFUN |FSPECF;iiPolylog;3F;226| ((|s| (F)) (|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |s| (|spadConstant| $ 74) (QREFELT $ 72))
          (SPADCALL
           (SPADCALL (SPADCALL (|spadConstant| $ 74) |x| (QREFELT $ 108))
                     (QREFELT $ 217))
           (QREFELT $ 110)))
         ((SPADCALL |s| (SPADCALL 2 (QREFELT $ 76)) (QREFELT $ 72))
          (SPADCALL (SPADCALL (|spadConstant| $ 74) |x| (QREFELT $ 108))
                    (QREFELT $ 218)))
         ('T (SPADCALL (QREFELT $ 29) (LIST |s| |x|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;iiPolylog;3F;227| ((|s| (F)) (|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |s| (|spadConstant| $ 74) (QREFELT $ 72))
          (SPADCALL
           (SPADCALL (SPADCALL (|spadConstant| $ 74) |x| (QREFELT $ 108))
                     (QREFELT $ 217))
           (QREFELT $ 110)))
         ('T (SPADCALL (QREFELT $ 29) (LIST |s| |x|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;iiPolylog;3F;228| ((|s| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 29) (LIST |s| |x|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;iPolylog| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 220))
                  (QREFELT $ 219))) 

(SDEFUN |FSPECF;iWeierstrassP| ((|g2| (F)) (|g3| (F)) (|x| (F)) ($ (F)))
        (SPROG ((#1=#:G1451 NIL) (|args| (|List| F)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |x| (QREFELT $ 102) (QREFELT $ 180))
                    (SEQ
                     (LETT |args|
                           (SPADCALL (SPADCALL |x| (QREFELT $ 182))
                                     (QREFELT $ 184)))
                     (EXIT
                      (COND
                       ((SPADCALL |g2| (SPADCALL |args| 1 (QREFELT $ 95))
                                  (QREFELT $ 72))
                        (COND
                         ((SPADCALL |g3| (SPADCALL |args| 2 (QREFELT $ 95))
                                    (QREFELT $ 72))
                          (PROGN
                           (LETT #1# (SPADCALL |args| 3 (QREFELT $ 95)))
                           (GO #2=#:G1450))))))))))
                  (EXIT
                   (SPADCALL (QREFELT $ 30) (LIST |g2| |g3| |x|)
                             (QREFELT $ 99)))))
                #2# (EXIT #1#)))) 

(SDEFUN |FSPECF;iWeierstrassPPrime| ((|g2| (F)) (|g3| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 31) (LIST |g2| |g3| |x|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;iWeierstrassSigma| ((|g2| (F)) (|g3| (F)) (|x| (F)) ($ (F)))
        (COND
         ((SPADCALL |x| (|spadConstant| $ 70) (QREFELT $ 72))
          (|spadConstant| $ 70))
         ('T (SPADCALL (QREFELT $ 32) (LIST |g2| |g3| |x|) (QREFELT $ 99))))) 

(SDEFUN |FSPECF;iWeierstrassZeta| ((|g2| (F)) (|g3| (F)) (|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 33) (LIST |g2| |g3| |x|) (QREFELT $ 99))) 

(SDEFUN |FSPECF;iiabs;2F;234| ((|x| (F)) ($ (F)))
        (SPROG
         ((#1=#:G1475 NIL) (|b| #2=(|Union| R "failed")) (|a| #2#)
          (|f| (|Fraction| (|Polynomial| R)))
          (|r| (|Union| (|Fraction| (|Polynomial| R)) "failed")))
         (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 222)))
              (EXIT
               (COND ((QEQCAR |r| 1) (|FSPECF;iabs| |x| $))
                     (#3='T
                      (SEQ
                       (EXIT
                        (SEQ (LETT |f| (QCDR |r|))
                             (SEQ
                              (LETT |a|
                                    (SPADCALL (SPADCALL |f| (QREFELT $ 225))
                                              (QREFELT $ 227)))
                              (EXIT
                               (COND
                                ((QEQCAR |a| 1)
                                 (PROGN
                                  (LETT #1# (|FSPECF;iabs| |x| $))
                                  (GO #4=#:G1472)))
                                (#3#
                                 (SEQ
                                  (LETT |b|
                                        (SPADCALL
                                         (SPADCALL |f| (QREFELT $ 228))
                                         (QREFELT $ 227)))
                                  (EXIT
                                   (COND
                                    ((QEQCAR |b| 1)
                                     (PROGN
                                      (LETT #1# (|FSPECF;iabs| |x| $))
                                      (GO #4#))))))))))
                             (EXIT
                              (SPADCALL
                               (SPADCALL (SPADCALL (QCDR |a|) (QREFELT $ 229))
                                         (QREFELT $ 230))
                               (SPADCALL (SPADCALL (QCDR |b|) (QREFELT $ 229))
                                         (QREFELT $ 230))
                               (QREFELT $ 109)))))
                       #4# (EXIT #1#)))))))) 

(SDEFUN |FSPECF;iiabs;2F;235| ((|x| (F)) ($ (F))) (|FSPECF;iabs| |x| $)) 

(SDEFUN |FSPECF;iiconjugate;2F;236| ((|x| (F)) ($ (F)))
        (SPROG ((#1=#:G1521 NIL))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL |x| (QREFELT $ 14) (QREFELT $ 180))
                   (SPADCALL
                    (SPADCALL (SPADCALL |x| (QREFELT $ 182)) (QREFELT $ 184)) 1
                    (QREFELT $ 95)))
                  ((SPADCALL |x| (QREFELT $ 13) (QREFELT $ 180)) |x|)
                  ((QEQCAR (SPADCALL |x| (QREFELT $ 233)) 0)
                   (|FSPECF;iconjugate| |x| $))
                  ('T
                   (SEQ
                    (LETT |x|
                          (SPADCALL |x| (SPADCALL |x| (QREFELT $ 235))
                                    (SPADCALL
                                     (CONS #'|FSPECF;iiconjugate;2F;236!0| $)
                                     (SPADCALL |x| (QREFELT $ 235))
                                     (QREFELT $ 248))
                                    (QREFELT $ 249)))
                    (COND
                     ((|HasSignature| (QREFELT $ 6)
                                      (LIST '|conjugate|
                                            (LIST (|devaluate| (QREFELT $ 6))
                                                  (|devaluate|
                                                   (QREFELT $ 6)))))
                      (LETT |x|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (ELT $ 250)
                                        (SPADCALL |x| (QREFELT $ 252))
                                        (QREFELT $ 254))
                              (QREFELT $ 255))
                             (SPADCALL
                              (SPADCALL (ELT $ 250)
                                        (SPADCALL |x| (QREFELT $ 256))
                                        (QREFELT $ 254))
                              (QREFELT $ 255))
                             (QREFELT $ 109)))))
                    (EXIT (PROGN (LETT #1# |x|) (GO #2=#:G1520)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |FSPECF;iiconjugate;2F;236!0| ((|k| NIL) ($ NIL))
        (SEQ
         (COND
          ((SPADCALL (SPADCALL |k| (QREFELT $ 237)) (|spadConstant| $ 238)
                     (QREFELT $ 239))
           (EXIT (|FSPECF;iconjugate| (SPADCALL |k| (QREFELT $ 240)) $)))
          ((SPADCALL (SPADCALL |k| (QREFELT $ 237)) (|spadConstant| $ 241)
                     (QREFELT $ 239))
           (COND
            ((QEQCAR (SPADCALL (SPADCALL |k| (QREFELT $ 240)) (QREFELT $ 233))
                     0)
             (EXIT (|FSPECF;iconjugate| (SPADCALL |k| (QREFELT $ 240)) $))))))
         (EXIT (SPADCALL (ELT $ 242) |k| (QREFELT $ 244))))) 

(SDEFUN |FSPECF;iiGamma;2F;237| ((|x| (F)) ($ (F)))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 257)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (|FSPECF;iGamma| |x| $))
                           ('T
                            (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 258))
                                      (QREFELT $ 230)))))))) 

(SDEFUN |FSPECF;iiBeta;LF;238| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G1534 NIL) (|s| #2=(|Union| R "failed")) (|r| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 257)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1)
                          (PROGN
                           (LETT #1#
                                 (|FSPECF;iBeta| (|SPADfirst| |l|)
                                  (SPADCALL |l| (QREFELT $ 220)) $))
                           (GO #3=#:G1532)))
                         ('T
                          (SEQ
                           (LETT |s|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 220))
                                           (QREFELT $ 257)))
                           (EXIT
                            (COND
                             ((QEQCAR |s| 1)
                              (PROGN
                               (LETT #1#
                                     (|FSPECF;iBeta| (|SPADfirst| |l|)
                                      (SPADCALL |l| (QREFELT $ 220)) $))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |r|) (QCDR |s|) (QREFELT $ 260))
                             (QREFELT $ 230)))))
                #3# (EXIT #1#)))) 

(SDEFUN |FSPECF;iidigamma;2F;239| ((|x| (F)) ($ (F)))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 257)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (|FSPECF;idigamma| |x| $))
                           ('T
                            (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 262))
                                      (QREFELT $ 230)))))))) 

(SDEFUN |FSPECF;iipolygamma;LF;240| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G1547 NIL) (|r| #2=(|Union| R "failed")) (|s| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |s| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 257)))
                       (EXIT
                        (COND
                         ((QEQCAR |s| 1)
                          (PROGN
                           (LETT #1#
                                 (|FSPECF;iiipolygamma| (|SPADfirst| |l|)
                                  (SPADCALL |l| (QREFELT $ 220)) $))
                           (GO #3=#:G1545)))
                         ('T
                          (SEQ
                           (LETT |r|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 220))
                                           (QREFELT $ 257)))
                           (EXIT
                            (COND
                             ((QEQCAR |r| 1)
                              (PROGN
                               (LETT #1#
                                     (|FSPECF;iiipolygamma| (|SPADfirst| |l|)
                                      (SPADCALL |l| (QREFELT $ 220)) $))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |s|) (QCDR |r|) (QREFELT $ 264))
                             (QREFELT $ 230)))))
                #3# (EXIT #1#)))) 

(SDEFUN |FSPECF;iiBesselJ;LF;241| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G1555 NIL) (|s| #2=(|Union| R "failed")) (|r| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 257)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1)
                          (PROGN
                           (LETT #1#
                                 (|FSPECF;iiiBesselJ| (|SPADfirst| |l|)
                                  (SPADCALL |l| (QREFELT $ 220)) $))
                           (GO #3=#:G1553)))
                         ('T
                          (SEQ
                           (LETT |s|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 220))
                                           (QREFELT $ 257)))
                           (EXIT
                            (COND
                             ((QEQCAR |s| 1)
                              (PROGN
                               (LETT #1#
                                     (|FSPECF;iiiBesselJ| (|SPADfirst| |l|)
                                      (SPADCALL |l| (QREFELT $ 220)) $))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |r|) (QCDR |s|) (QREFELT $ 266))
                             (QREFELT $ 230)))))
                #3# (EXIT #1#)))) 

(SDEFUN |FSPECF;iiBesselY;LF;242| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G1563 NIL) (|s| #2=(|Union| R "failed")) (|r| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 257)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1)
                          (PROGN
                           (LETT #1#
                                 (|FSPECF;iiiBesselY| (|SPADfirst| |l|)
                                  (SPADCALL |l| (QREFELT $ 220)) $))
                           (GO #3=#:G1561)))
                         ('T
                          (SEQ
                           (LETT |s|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 220))
                                           (QREFELT $ 257)))
                           (EXIT
                            (COND
                             ((QEQCAR |s| 1)
                              (PROGN
                               (LETT #1#
                                     (|FSPECF;iiiBesselY| (|SPADfirst| |l|)
                                      (SPADCALL |l| (QREFELT $ 220)) $))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |r|) (QCDR |s|) (QREFELT $ 268))
                             (QREFELT $ 230)))))
                #3# (EXIT #1#)))) 

(SDEFUN |FSPECF;iiBesselI;LF;243| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G1571 NIL) (|s| #2=(|Union| R "failed")) (|r| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 257)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1)
                          (PROGN
                           (LETT #1#
                                 (|FSPECF;iiiBesselI| (|SPADfirst| |l|)
                                  (SPADCALL |l| (QREFELT $ 220)) $))
                           (GO #3=#:G1569)))
                         ('T
                          (SEQ
                           (LETT |s|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 220))
                                           (QREFELT $ 257)))
                           (EXIT
                            (COND
                             ((QEQCAR |s| 1)
                              (PROGN
                               (LETT #1#
                                     (|FSPECF;iiiBesselI| (|SPADfirst| |l|)
                                      (SPADCALL |l| (QREFELT $ 220)) $))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |r|) (QCDR |s|) (QREFELT $ 270))
                             (QREFELT $ 230)))))
                #3# (EXIT #1#)))) 

(SDEFUN |FSPECF;iiBesselK;LF;244| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G1579 NIL) (|s| #2=(|Union| R "failed")) (|r| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 257)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1)
                          (PROGN
                           (LETT #1#
                                 (|FSPECF;iiiBesselK| (|SPADfirst| |l|)
                                  (SPADCALL |l| (QREFELT $ 220)) $))
                           (GO #3=#:G1577)))
                         ('T
                          (SEQ
                           (LETT |s|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 220))
                                           (QREFELT $ 257)))
                           (EXIT
                            (COND
                             ((QEQCAR |s| 1)
                              (PROGN
                               (LETT #1#
                                     (|FSPECF;iiiBesselK| (|SPADfirst| |l|)
                                      (SPADCALL |l| (QREFELT $ 220)) $))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |r|) (QCDR |s|) (QREFELT $ 272))
                             (QREFELT $ 230)))))
                #3# (EXIT #1#)))) 

(SDEFUN |FSPECF;iiAiryAi;2F;245| ((|x| (F)) ($ (F)))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 257)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (SPADCALL |x| (QREFELT $ 211)))
                           ('T
                            (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 274))
                                      (QREFELT $ 230)))))))) 

(SDEFUN |FSPECF;iiAiryAiPrime;2F;246| ((|x| (F)) ($ (F)))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 257)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (SPADCALL |x| (QREFELT $ 212)))
                           ('T
                            (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 276))
                                      (QREFELT $ 230)))))))) 

(SDEFUN |FSPECF;iiAiryBi;2F;247| ((|x| (F)) ($ (F)))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 257)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (SPADCALL |x| (QREFELT $ 213)))
                           ('T
                            (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 278))
                                      (QREFELT $ 230)))))))) 

(SDEFUN |FSPECF;iiAiryBiPrime;2F;248| ((|x| (F)) ($ (F)))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 257)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (SPADCALL |x| (QREFELT $ 214)))
                           ('T
                            (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 280))
                                      (QREFELT $ 230)))))))) 

(SDEFUN |FSPECF;iiGamma;2F;249| ((|x| (F)) ($ (F)))
        (SPROG ((#1=#:G1607 NIL) (|r| (|Union| (|Integer|) "failed")))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 283)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 0)
                          (COND
                           ((>= (QCDR |r|) 1)
                            (PROGN
                             (LETT #1#
                                   (SPADCALL
                                    (SPADCALL (- (QCDR |r|) 1) (QREFELT $ 284))
                                    (QREFELT $ 76)))
                             (GO #2=#:G1605))))))))
                  (EXIT (|FSPECF;iGamma| |x| $))))
                #2# (EXIT #1#)))) 

(SDEFUN |FSPECF;iiGamma;2F;250| ((|x| (F)) ($ (F))) (|FSPECF;iGamma| |x| $)) 

(SDEFUN |FSPECF;iiBeta;LF;251| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iBeta| (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 220)) $)) 

(SDEFUN |FSPECF;iidigamma;2F;252| ((|x| (F)) ($ (F))) (|FSPECF;idigamma| |x| $)) 

(SDEFUN |FSPECF;iipolygamma;LF;253| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iiipolygamma| (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 220))
         $)) 

(SDEFUN |FSPECF;iiBesselJ;LF;254| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iiiBesselJ| (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 220))
         $)) 

(SDEFUN |FSPECF;iiBesselY;LF;255| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iiiBesselY| (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 220))
         $)) 

(SDEFUN |FSPECF;iiBesselI;LF;256| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iiiBesselI| (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 220))
         $)) 

(SDEFUN |FSPECF;iiBesselK;LF;257| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iiiBesselK| (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 220))
         $)) 

(SDEFUN |FSPECF;iiAiryAi;2F;258| ((|x| (F)) ($ (F)))
        (SPADCALL |x| (QREFELT $ 211))) 

(SDEFUN |FSPECF;iiAiryAiPrime;2F;259| ((|x| (F)) ($ (F)))
        (SPADCALL |x| (QREFELT $ 212))) 

(SDEFUN |FSPECF;iiAiryBi;2F;260| ((|x| (F)) ($ (F)))
        (SPADCALL |x| (QREFELT $ 213))) 

(SDEFUN |FSPECF;iiAiryBiPrime;2F;261| ((|x| (F)) ($ (F)))
        (SPADCALL |x| (QREFELT $ 214))) 

(SDEFUN |FSPECF;iiWeierstrassP| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iWeierstrassP| (|SPADfirst| |l|)
         (SPADCALL |l| (QREFELT $ 220)) (SPADCALL |l| (QREFELT $ 285)) $)) 

(SDEFUN |FSPECF;iiWeierstrassPPrime| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iWeierstrassPPrime| (|SPADfirst| |l|)
         (SPADCALL |l| (QREFELT $ 220)) (SPADCALL |l| (QREFELT $ 285)) $)) 

(SDEFUN |FSPECF;iiWeierstrassSigma| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iWeierstrassSigma| (|SPADfirst| |l|)
         (SPADCALL |l| (QREFELT $ 220)) (SPADCALL |l| (QREFELT $ 285)) $)) 

(SDEFUN |FSPECF;iiWeierstrassZeta| ((|l| (|List| F)) ($ (F)))
        (|FSPECF;iWeierstrassZeta| (|SPADfirst| |l|)
         (SPADCALL |l| (QREFELT $ 220)) (SPADCALL |l| (QREFELT $ 285)) $)) 

(SDEFUN |FSPECF;diff1| ((|op| (|BasicOperator|)) (|n| (F)) (|x| (F)) ($ (F)))
        (SPROG ((|dm| (F)))
               (SEQ
                (LETT |dm| (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
                (EXIT
                 (SPADCALL (QREFELT $ 84)
                           (LIST (SPADCALL |op| (LIST |dm| |x|) (QREFELT $ 80))
                                 |dm| |n|)
                           (QREFELT $ 99)))))) 

(SDEFUN |FSPECF;iBesselJ| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (SPROG ((|x| (F)) (|n| (F)))
               (SEQ (LETT |n| (|SPADfirst| |l|))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 220)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |n| |t| (QREFELT $ 98))
                                (|FSPECF;diff1| (QREFELT $ 20) |n| |x| $)
                                (QREFELT $ 100))
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| |t| (QREFELT $ 98))
                                 (QREFELT $ 87) (QREFELT $ 100))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 108))
                         |x| (QREFELT $ 54))
                        (SPADCALL
                         (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 101))
                         |x| (QREFELT $ 54))
                        (QREFELT $ 108))
                       (QREFELT $ 100))
                      (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;iBesselY| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (SPROG ((|x| (F)) (|n| (F)))
               (SEQ (LETT |n| (|SPADfirst| |l|))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 220)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |n| |t| (QREFELT $ 98))
                                (|FSPECF;diff1| (QREFELT $ 21) |n| |x| $)
                                (QREFELT $ 100))
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| |t| (QREFELT $ 98))
                                 (QREFELT $ 87) (QREFELT $ 100))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 108))
                         |x| (QREFELT $ 55))
                        (SPADCALL
                         (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 101))
                         |x| (QREFELT $ 55))
                        (QREFELT $ 108))
                       (QREFELT $ 100))
                      (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;iBesselI| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (SPROG ((|x| (F)) (|n| (F)))
               (SEQ (LETT |n| (|SPADfirst| |l|))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 220)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |n| |t| (QREFELT $ 98))
                                (|FSPECF;diff1| (QREFELT $ 22) |n| |x| $)
                                (QREFELT $ 100))
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| |t| (QREFELT $ 98))
                                 (QREFELT $ 87) (QREFELT $ 100))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 108))
                         |x| (QREFELT $ 56))
                        (SPADCALL
                         (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 101))
                         |x| (QREFELT $ 56))
                        (QREFELT $ 101))
                       (QREFELT $ 100))
                      (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;iBesselK| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (SPROG ((|x| (F)) (|n| (F)))
               (SEQ (LETT |n| (|SPADfirst| |l|))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 220)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |n| |t| (QREFELT $ 98))
                                (|FSPECF;diff1| (QREFELT $ 23) |n| |x| $)
                                (QREFELT $ 100))
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| |t| (QREFELT $ 98))
                                 (QREFELT $ 87) (QREFELT $ 100))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 108))
                         |x| (QREFELT $ 57))
                        (SPADCALL
                         (SPADCALL |n| (|spadConstant| $ 74) (QREFELT $ 101))
                         |x| (QREFELT $ 57))
                        (QREFELT $ 101))
                       (QREFELT $ 100))
                      (QREFELT $ 108)))))) 

(SDEFUN |FSPECF;dPolylog| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (SPROG ((|x| (F)) (|s| (F)))
               (SEQ (LETT |s| (|SPADfirst| |l|))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 220)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |s| |t| (QREFELT $ 98))
                                (|FSPECF;diff1| (QREFELT $ 29) |s| |x| $)
                                (QREFELT $ 100))
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| |t| (QREFELT $ 98))
                                 (SPADCALL
                                  (SPADCALL |s| (|spadConstant| $ 74)
                                            (QREFELT $ 108))
                                  |x| (QREFELT $ 63))
                                 (QREFELT $ 100))
                       |x| (QREFELT $ 109))
                      (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;ipolygamma| ((|l| (|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG ((|y| (F)) (|n| (F)))
               (SEQ
                (COND
                 ((SPADCALL |x| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 289))
                            (QREFELT $ 290))
                  (|error|
                   "cannot differentiate polygamma with respect to the first argument"))
                 ('T
                  (SEQ (LETT |n| (|SPADfirst| |l|))
                       (LETT |y| (SPADCALL |l| (QREFELT $ 220)))
                       (EXIT
                        (SPADCALL (SPADCALL |y| |x| (QREFELT $ 98))
                                  (SPADCALL
                                   (SPADCALL |n| (|spadConstant| $ 74)
                                             (QREFELT $ 101))
                                   |y| (QREFELT $ 53))
                                  (QREFELT $ 100))))))))) 

(SDEFUN |FSPECF;iBetaGrad1| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|y| (F)) (|x| (F)))
               (SEQ (LETT |x| (|SPADfirst| |l|))
                    (LETT |y| (SPADCALL |l| (QREFELT $ 220)))
                    (EXIT
                     (SPADCALL (SPADCALL |x| |y| (QREFELT $ 51))
                               (SPADCALL (SPADCALL |x| (QREFELT $ 52))
                                         (SPADCALL
                                          (SPADCALL |x| |y| (QREFELT $ 101))
                                          (QREFELT $ 52))
                                         (QREFELT $ 108))
                               (QREFELT $ 100)))))) 

(SDEFUN |FSPECF;iBetaGrad2| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|y| (F)) (|x| (F)))
               (SEQ (LETT |x| (|SPADfirst| |l|))
                    (LETT |y| (SPADCALL |l| (QREFELT $ 220)))
                    (EXIT
                     (SPADCALL (SPADCALL |x| |y| (QREFELT $ 51))
                               (SPADCALL (SPADCALL |y| (QREFELT $ 52))
                                         (SPADCALL
                                          (SPADCALL |x| |y| (QREFELT $ 101))
                                          (QREFELT $ 52))
                                         (QREFELT $ 108))
                               (QREFELT $ 100)))))) 

(SDEFUN |FSPECF;iGamma2| ((|l| (|List| F)) (|t| (|Symbol|)) ($ (F)))
        (SPROG ((|x| (F)) (|a| (F)))
               (SEQ (LETT |a| (|SPADfirst| |l|))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 220)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |a| |t| (QREFELT $ 98))
                                (|FSPECF;diff1| (QREFELT $ 16) |a| |x| $)
                                (QREFELT $ 100))
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| |t| (QREFELT $ 98))
                                 (SPADCALL |x|
                                           (SPADCALL |a| (|spadConstant| $ 74)
                                                     (QREFELT $ 108))
                                           (QREFELT $ 132))
                                 (QREFELT $ 100))
                       (SPADCALL (SPADCALL |x| (QREFELT $ 110))
                                 (QREFELT $ 215))
                       (QREFELT $ 100))
                      (QREFELT $ 108)))))) 

(SDEFUN |FSPECF;inGamma2| ((|li| (|List| (|InputForm|))) ($ (|InputForm|)))
        (SPADCALL (CONS (SPADCALL '|Gamma| (QREFELT $ 171)) |li|)
                  (QREFELT $ 172))) 

(SDEFUN |FSPECF;dLambertW| ((|x| (F)) ($ (F)))
        (SPROG ((|lw| (F)))
               (SEQ (LETT |lw| (SPADCALL |x| (QREFELT $ 62)))
                    (EXIT
                     (SPADCALL |lw|
                               (SPADCALL |x|
                                         (SPADCALL (|spadConstant| $ 74) |lw|
                                                   (QREFELT $ 101))
                                         (QREFELT $ 100))
                               (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;iWeierstrassPGrad1| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|wp| (F)) (|delta| (F)) (|x| (F)) (|g3| (F)) (|g2| (F)))
               (SEQ (LETT |g2| (|SPADfirst| |l|))
                    (LETT |g3| (SPADCALL |l| (QREFELT $ 220)))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 285)))
                    (LETT |delta|
                          (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                                    (SPADCALL 27
                                              (SPADCALL |g3| 2 (QREFELT $ 107))
                                              (QREFELT $ 92))
                                    (QREFELT $ 108)))
                    (LETT |wp| (SPADCALL |g2| |g3| |x| (QREFELT $ 65)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL |g2| |g3| |x| (QREFELT $ 66))
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL 9 (QREFELT $ 87)
                                                 (QREFELT $ 92))
                                       |g3| (QREFELT $ 100))
                                      (SPADCALL |g2| |g3| |x| (QREFELT $ 68))
                                      (QREFELT $ 100))
                                     (QREFELT $ 110))
                                    (SPADCALL
                                     (SPADCALL (QREFELT $ 89)
                                               (SPADCALL |g2| 2
                                                         (QREFELT $ 107))
                                               (QREFELT $ 100))
                                     |x| (QREFELT $ 100))
                                    (QREFELT $ 101))
                                   (QREFELT $ 100))
                         (SPADCALL (SPADCALL 9 |g3| (QREFELT $ 92))
                                   (SPADCALL |wp| 2 (QREFELT $ 107))
                                   (QREFELT $ 100))
                         (QREFELT $ 108))
                        (SPADCALL
                         (SPADCALL (QREFELT $ 87)
                                   (SPADCALL |g2| 2 (QREFELT $ 107))
                                   (QREFELT $ 100))
                         |wp| (QREFELT $ 100))
                        (QREFELT $ 101))
                       (SPADCALL
                        (SPADCALL (SPADCALL 3 (QREFELT $ 87) (QREFELT $ 92))
                                  |g2| (QREFELT $ 100))
                        |g3| (QREFELT $ 100))
                       (QREFELT $ 101))
                      |delta| (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;iWeierstrassPGrad2| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|wp| (F)) (|delta| (F)) (|x| (F)) (|g3| (F)) (|g2| (F)))
               (SEQ (LETT |g2| (|SPADfirst| |l|))
                    (LETT |g3| (SPADCALL |l| (QREFELT $ 220)))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 285)))
                    (LETT |delta|
                          (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                                    (SPADCALL 27
                                              (SPADCALL |g3| 2 (QREFELT $ 107))
                                              (QREFELT $ 92))
                                    (QREFELT $ 108)))
                    (LETT |wp| (SPADCALL |g2| |g3| |x| (QREFELT $ 65)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL |g2| |g3| |x| (QREFELT $ 66))
                                   (SPADCALL
                                    (SPADCALL (SPADCALL 3 |g2| (QREFELT $ 92))
                                              (SPADCALL |g2| |g3| |x|
                                                        (QREFELT $ 68))
                                              (QREFELT $ 100))
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL 9 (QREFELT $ 87)
                                                (QREFELT $ 92))
                                      |g3| (QREFELT $ 100))
                                     |x| (QREFELT $ 100))
                                    (QREFELT $ 108))
                                   (QREFELT $ 100))
                         (SPADCALL (SPADCALL 6 |g2| (QREFELT $ 92))
                                   (SPADCALL |wp| 2 (QREFELT $ 107))
                                   (QREFELT $ 100))
                         (QREFELT $ 101))
                        (SPADCALL (SPADCALL 9 |g3| (QREFELT $ 92)) |wp|
                                  (QREFELT $ 100))
                        (QREFELT $ 108))
                       (SPADCALL |g2| 2 (QREFELT $ 107)) (QREFELT $ 108))
                      |delta| (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;iWeierstrassPGrad3| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 220))
                  (SPADCALL |l| (QREFELT $ 285)) (QREFELT $ 66))) 

(SDEFUN |FSPECF;iWeierstrassPPrimeGrad1| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|wpp2| (F)) (|wpp| (F)) (|wp| (F)) (|delta| (F)) (|x| (F))
          (|g3| (F)) (|g2| (F)))
         (SEQ (LETT |g2| (|SPADfirst| |l|))
              (LETT |g3| (SPADCALL |l| (QREFELT $ 220)))
              (LETT |x| (SPADCALL |l| (QREFELT $ 285)))
              (LETT |delta|
                    (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                              (SPADCALL 27 (SPADCALL |g3| 2 (QREFELT $ 107))
                                        (QREFELT $ 92))
                              (QREFELT $ 108)))
              (LETT |wp| (SPADCALL |g2| |g3| |x| (QREFELT $ 65)))
              (LETT |wpp| (SPADCALL |g2| |g3| |x| (QREFELT $ 66)))
              (LETT |wpp2|
                    (SPADCALL
                     (SPADCALL 6 (SPADCALL |wp| 2 (QREFELT $ 107))
                               (QREFELT $ 92))
                     (SPADCALL (QREFELT $ 87) |g2| (QREFELT $ 100))
                     (QREFELT $ 108)))
              (EXIT
               (SPADCALL
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL |wpp2|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL 9 (QREFELT $ 87) (QREFELT $ 92))
                                 |g3| (QREFELT $ 100))
                                (SPADCALL |g2| |g3| |x| (QREFELT $ 68))
                                (QREFELT $ 100))
                               (QREFELT $ 110))
                              (SPADCALL
                               (SPADCALL (QREFELT $ 89)
                                         (SPADCALL |g2| 2 (QREFELT $ 107))
                                         (QREFELT $ 100))
                               |x| (QREFELT $ 100))
                              (QREFELT $ 101))
                             (QREFELT $ 100))
                   (SPADCALL |wpp|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL 9 (QREFELT $ 87) (QREFELT $ 92)) |g3|
                                (QREFELT $ 100))
                               |wp| (QREFELT $ 100))
                              (SPADCALL (QREFELT $ 89)
                                        (SPADCALL |g2| 2 (QREFELT $ 107))
                                        (QREFELT $ 100))
                              (QREFELT $ 101))
                             (QREFELT $ 100))
                   (QREFELT $ 101))
                  (SPADCALL
                   (SPADCALL (SPADCALL 18 |g3| (QREFELT $ 92)) |wp|
                             (QREFELT $ 100))
                   |wpp| (QREFELT $ 100))
                  (QREFELT $ 108))
                 (SPADCALL
                  (SPADCALL (QREFELT $ 87) (SPADCALL |g2| 2 (QREFELT $ 107))
                            (QREFELT $ 100))
                  |wpp| (QREFELT $ 100))
                 (QREFELT $ 101))
                |delta| (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;iWeierstrassPPrimeGrad2| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|wpp2| (F)) (|wpp| (F)) (|wp| (F)) (|delta| (F)) (|x| (F))
          (|g3| (F)) (|g2| (F)))
         (SEQ (LETT |g2| (|SPADfirst| |l|))
              (LETT |g3| (SPADCALL |l| (QREFELT $ 220)))
              (LETT |x| (SPADCALL |l| (QREFELT $ 285)))
              (LETT |delta|
                    (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                              (SPADCALL 27 (SPADCALL |g3| 2 (QREFELT $ 107))
                                        (QREFELT $ 92))
                              (QREFELT $ 108)))
              (LETT |wp| (SPADCALL |g2| |g3| |x| (QREFELT $ 65)))
              (LETT |wpp| (SPADCALL |g2| |g3| |x| (QREFELT $ 66)))
              (LETT |wpp2|
                    (SPADCALL
                     (SPADCALL 6 (SPADCALL |wp| 2 (QREFELT $ 107))
                               (QREFELT $ 92))
                     (SPADCALL (QREFELT $ 87) |g2| (QREFELT $ 100))
                     (QREFELT $ 108)))
              (EXIT
               (SPADCALL
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL |wpp2|
                             (SPADCALL
                              (SPADCALL (SPADCALL 3 |g2| (QREFELT $ 92))
                                        (SPADCALL |g2| |g3| |x| (QREFELT $ 68))
                                        (QREFELT $ 100))
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL 9 (QREFELT $ 87) (QREFELT $ 92)) |g3|
                                (QREFELT $ 100))
                               |x| (QREFELT $ 100))
                              (QREFELT $ 108))
                             (QREFELT $ 100))
                   (SPADCALL |wpp|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (SPADCALL 3 |g2| (QREFELT $ 92)) |wp|
                                         (QREFELT $ 100))
                               (QREFELT $ 110))
                              (SPADCALL
                               (SPADCALL 9 (QREFELT $ 87) (QREFELT $ 92)) |g3|
                               (QREFELT $ 100))
                              (QREFELT $ 108))
                             (QREFELT $ 100))
                   (QREFELT $ 101))
                  (SPADCALL
                   (SPADCALL (SPADCALL 12 |g2| (QREFELT $ 92)) |wp|
                             (QREFELT $ 100))
                   |wpp| (QREFELT $ 100))
                  (QREFELT $ 101))
                 (SPADCALL (SPADCALL 9 |g3| (QREFELT $ 92)) |wpp|
                           (QREFELT $ 100))
                 (QREFELT $ 108))
                |delta| (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;iWeierstrassPPrimeGrad3| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|g2| (F)))
               (SEQ (LETT |g2| (|SPADfirst| |l|))
                    (EXIT
                     (SPADCALL
                      (SPADCALL 6
                                (SPADCALL
                                 (SPADCALL |g2| (SPADCALL |l| (QREFELT $ 220))
                                           (SPADCALL |l| (QREFELT $ 285))
                                           (QREFELT $ 65))
                                 2 (QREFELT $ 128))
                                (QREFELT $ 92))
                      (SPADCALL (QREFELT $ 87) |g2| (QREFELT $ 100))
                      (QREFELT $ 108)))))) 

(SDEFUN |FSPECF;iWeierstrassSigmaGrad1| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|wsp2| (F)) (|wsp| (F)) (|wz| (F)) (|ws| (F)) (|delta| (F))
          (|x| (F)) (|g3| (F)) (|g2| (F)))
         (SEQ (LETT |g2| (|SPADfirst| |l|))
              (LETT |g3| (SPADCALL |l| (QREFELT $ 220)))
              (LETT |x| (SPADCALL |l| (QREFELT $ 285)))
              (LETT |delta|
                    (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                              (SPADCALL 27 (SPADCALL |g3| 2 (QREFELT $ 107))
                                        (QREFELT $ 92))
                              (QREFELT $ 108)))
              (LETT |ws| (SPADCALL |g2| |g3| |x| (QREFELT $ 67)))
              (LETT |wz| (SPADCALL |g2| |g3| |x| (QREFELT $ 68)))
              (LETT |wsp| (SPADCALL |wz| |ws| (QREFELT $ 100)))
              (LETT |wsp2|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |g2| |g3| |x| (QREFELT $ 65)) |ws|
                                (QREFELT $ 100))
                      (QREFELT $ 110))
                     (SPADCALL (SPADCALL |wz| 2 (QREFELT $ 107)) |ws|
                               (QREFELT $ 100))
                     (QREFELT $ 101)))
              (EXIT
               (SPADCALL
                (SPADCALL (QREFELT $ 89)
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (SPADCALL 9 |g3| (QREFELT $ 92)) |wsp2|
                                        (QREFELT $ 100))
                              (QREFELT $ 110))
                             (SPADCALL (SPADCALL |g2| 2 (QREFELT $ 107)) |ws|
                                       (QREFELT $ 100))
                             (QREFELT $ 108))
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL 3 (QREFELT $ 89) (QREFELT $ 92)) |g2|
                                (QREFELT $ 100))
                               |g3| (QREFELT $ 100))
                              (SPADCALL |x| 2 (QREFELT $ 107)) (QREFELT $ 100))
                             |ws| (QREFELT $ 100))
                            (QREFELT $ 108))
                           (SPADCALL
                            (SPADCALL (SPADCALL |g2| 2 (QREFELT $ 107)) |x|
                                      (QREFELT $ 100))
                            |wsp| (QREFELT $ 100))
                           (QREFELT $ 101))
                          (QREFELT $ 100))
                |delta| (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;iWeierstrassSigmaGrad2| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|wsp2| (F)) (|wsp| (F)) (|wz| (F)) (|ws| (F)) (|delta| (F))
          (|x| (F)) (|g3| (F)) (|g2| (F)))
         (SEQ (LETT |g2| (|SPADfirst| |l|))
              (LETT |g3| (SPADCALL |l| (QREFELT $ 220)))
              (LETT |x| (SPADCALL |l| (QREFELT $ 285)))
              (LETT |delta|
                    (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                              (SPADCALL 27 (SPADCALL |g3| 2 (QREFELT $ 107))
                                        (QREFELT $ 92))
                              (QREFELT $ 108)))
              (LETT |ws| (SPADCALL |g2| |g3| |x| (QREFELT $ 67)))
              (LETT |wz| (SPADCALL |g2| |g3| |x| (QREFELT $ 68)))
              (LETT |wsp| (SPADCALL |wz| |ws| (QREFELT $ 100)))
              (LETT |wsp2|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |g2| |g3| |x| (QREFELT $ 65)) |ws|
                                (QREFELT $ 100))
                      (QREFELT $ 110))
                     (SPADCALL (SPADCALL |wz| 2 (QREFELT $ 107)) |ws|
                               (QREFELT $ 100))
                     (QREFELT $ 101)))
              (EXIT
               (SPADCALL
                (SPADCALL (QREFELT $ 87)
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (SPADCALL 3 |g2| (QREFELT $ 92)) |wsp2|
                                       (QREFELT $ 100))
                             (SPADCALL (SPADCALL 9 |g3| (QREFELT $ 92)) |ws|
                                       (QREFELT $ 100))
                             (QREFELT $ 101))
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (QREFELT $ 89)
                                        (SPADCALL |g2| 2 (QREFELT $ 107))
                                        (QREFELT $ 100))
                              (SPADCALL |x| 2 (QREFELT $ 107)) (QREFELT $ 100))
                             |ws| (QREFELT $ 100))
                            (QREFELT $ 101))
                           (SPADCALL
                            (SPADCALL (SPADCALL 9 |g3| (QREFELT $ 92)) |x|
                                      (QREFELT $ 100))
                            |wsp| (QREFELT $ 100))
                           (QREFELT $ 108))
                          (QREFELT $ 100))
                |delta| (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;iWeierstrassSigmaGrad3| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|x| (F)) (|g3| (F)) (|g2| (F)))
               (SEQ (LETT |g2| (|SPADfirst| |l|))
                    (LETT |g3| (SPADCALL |l| (QREFELT $ 220)))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 285)))
                    (EXIT
                     (SPADCALL (SPADCALL |g2| |g3| |x| (QREFELT $ 68))
                               (SPADCALL |g2| |g3| |x| (QREFELT $ 67))
                               (QREFELT $ 100)))))) 

(SDEFUN |FSPECF;iWeierstrassZetaGrad1| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|wp| (F)) (|delta| (F)) (|x| (F)) (|g3| (F)) (|g2| (F)))
               (SEQ (LETT |g2| (|SPADfirst| |l|))
                    (LETT |g3| (SPADCALL |l| (QREFELT $ 220)))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 285)))
                    (LETT |delta|
                          (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                                    (SPADCALL 27
                                              (SPADCALL |g3| 2 (QREFELT $ 107))
                                              (QREFELT $ 92))
                                    (QREFELT $ 108)))
                    (LETT |wp| (SPADCALL |g2| |g3| |x| (QREFELT $ 65)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (QREFELT $ 87)
                                   (SPADCALL |g2| |g3| |x| (QREFELT $ 68))
                                   (QREFELT $ 100))
                         (SPADCALL
                          (SPADCALL (SPADCALL 9 |g3| (QREFELT $ 92)) |wp|
                                    (QREFELT $ 100))
                          (SPADCALL (QREFELT $ 87)
                                    (SPADCALL |g2| 2 (QREFELT $ 107))
                                    (QREFELT $ 100))
                          (QREFELT $ 101))
                         (QREFELT $ 100))
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (QREFELT $ 87) |g2| (QREFELT $ 100)) |x|
                          (QREFELT $ 100))
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (QREFELT $ 87) |g2| (QREFELT $ 100)) |wp|
                           (QREFELT $ 100))
                          (SPADCALL (SPADCALL 3 (QREFELT $ 89) (QREFELT $ 92))
                                    |g3| (QREFELT $ 100))
                          (QREFELT $ 101))
                         (QREFELT $ 100))
                        (QREFELT $ 108))
                       (SPADCALL
                        (SPADCALL (SPADCALL 9 (QREFELT $ 89) (QREFELT $ 92))
                                  |g3| (QREFELT $ 100))
                        (SPADCALL |g2| |g3| |x| (QREFELT $ 66))
                        (QREFELT $ 100))
                       (QREFELT $ 101))
                      |delta| (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;iWeierstrassZetaGrad2| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|wp| (F)) (|delta| (F)) (|x| (F)) (|g3| (F)) (|g2| (F)))
               (SEQ (LETT |g2| (|SPADfirst| |l|))
                    (LETT |g3| (SPADCALL |l| (QREFELT $ 220)))
                    (LETT |x| (SPADCALL |l| (QREFELT $ 285)))
                    (LETT |delta|
                          (SPADCALL (SPADCALL |g2| 3 (QREFELT $ 107))
                                    (SPADCALL 27
                                              (SPADCALL |g3| 2 (QREFELT $ 107))
                                              (QREFELT $ 92))
                                    (QREFELT $ 108)))
                    (LETT |wp| (SPADCALL |g2| |g3| |x| (QREFELT $ 65)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL 3 (SPADCALL |g2| |g3| |x| (QREFELT $ 68))
                                    (QREFELT $ 92))
                          (SPADCALL (SPADCALL |g2| |wp| (QREFELT $ 100))
                                    (SPADCALL
                                     (SPADCALL 3 (QREFELT $ 87) (QREFELT $ 92))
                                     |g3| (QREFELT $ 100))
                                    (QREFELT $ 101))
                          (QREFELT $ 100))
                         (QREFELT $ 110))
                        (SPADCALL (SPADCALL (QREFELT $ 87) |x| (QREFELT $ 100))
                                  (SPADCALL
                                   (SPADCALL (SPADCALL 9 |g3| (QREFELT $ 92))
                                             |wp| (QREFELT $ 100))
                                   (SPADCALL (QREFELT $ 87)
                                             (SPADCALL |g2| 2 (QREFELT $ 107))
                                             (QREFELT $ 100))
                                   (QREFELT $ 101))
                                  (QREFELT $ 100))
                        (QREFELT $ 101))
                       (SPADCALL
                        (SPADCALL (SPADCALL 3 (QREFELT $ 87) (QREFELT $ 92))
                                  |g2| (QREFELT $ 100))
                        (SPADCALL |g2| |g3| |x| (QREFELT $ 66))
                        (QREFELT $ 100))
                       (QREFELT $ 108))
                      |delta| (QREFELT $ 109)))))) 

(SDEFUN |FSPECF;iWeierstrassZetaGrad3| ((|l| (|List| F)) ($ (F)))
        (SPADCALL
         (SPADCALL (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 220))
                   (SPADCALL |l| (QREFELT $ 285)) (QREFELT $ 65))
         (QREFELT $ 110))) 

(SDEFUN |FSPECF;dconjugate| ((|lo| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |lo| 1 (QREFELT $ 293)) (QREFELT $ 294))) 

(SDEFUN |FSPECF;get_int_listf| ((|lf| (|List| F)) ($ (|List| (|Integer|))))
        (SPADCALL (ELT $ 297) |lf| (QREFELT $ 301))) 

(SDEFUN |FSPECF;replace_i|
        ((|lp| (|List| F)) (|v| (F)) (|i| (|NonNegativeInteger|))
         ($ (|List| F)))
        (SPROG ((#1=#:G1725 NIL))
               (SPADCALL
                (SPADCALL |lp|
                          (PROG1 (LETT #1# (- |i| 1))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#))
                          (QREFELT $ 302))
                (CONS |v| (SPADCALL |lp| |i| (QREFELT $ 303))) (QREFELT $ 78)))) 

(SDEFUN |FSPECF;iiHypergeometricF;LF;293| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((#1=#:G1731 NIL) (#2=#:G1732 NIL) (|q| #3=(|Integer|)) (|p| #3#)
          (|pqi| (|List| (|Integer|))) (|pq| (|List| F))
          (|nn| (|NonNegativeInteger|)) (#4=#:G1727 NIL) (|z| (F))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (LENGTH |l|))
                (LETT |z| (SPADCALL |l| (- |n| 2) (QREFELT $ 95)))
                (COND
                 ((SPADCALL |z| (|spadConstant| $ 70) (QREFELT $ 72))
                  (SEQ
                   (EXIT
                    (SEQ
                     (LETT |nn|
                           (PROG1 (LETT #4# (- |n| 2))
                             (|check_subtype2| (>= #4# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #4#)))
                     (LETT |pq| (SPADCALL |l| |nn| (QREFELT $ 303)))
                     (LETT |pqi| (|FSPECF;get_int_listf| |pq| $))
                     (LETT |p| (|SPADfirst| |pqi|))
                     (LETT |q| (|SPADfirst| (CDR |pqi|)))
                     (EXIT
                      (COND
                       ((<= |p| (+ |q| 1))
                        (PROGN
                         (LETT #1#
                               (PROGN
                                (LETT #2# (|spadConstant| $ 74))
                                (GO #5=#:G1730)))
                         (GO #6=#:G1728)))))))
                   #6# (EXIT #1#))))
                (EXIT (SPADCALL (QREFELT $ 34) |l| (QREFELT $ 99)))))
          #5# (EXIT #2#)))) 

(SDEFUN |FSPECF;idvsum|
        ((|op| (|BasicOperator|)) (|n| (|Integer|)) (|l| (|List| F))
         (|x| (|Symbol|)) ($ (F)))
        (SPROG
         ((|res| (F)) (|nl| (|List| F)) (|dm| (F)) (#1=#:G1740 NIL) (|i| NIL)
          (#2=#:G1741 NIL) (|a| NIL))
         (SEQ (LETT |res| (|spadConstant| $ 70))
              (SEQ (LETT |a| NIL) (LETT #2# |l|) (LETT |i| 1) (LETT #1# |n|)
                   G190
                   (COND
                    ((OR (|greater_SI| |i| #1#) (ATOM #2#)
                         (PROGN (LETT |a| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |dm|
                          (SPADCALL (SPADCALL (QREFELT $ 96)) (QREFELT $ 97)))
                    (LETT |nl| (|FSPECF;replace_i| |l| |dm| |i| $))
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res|
                                     (SPADCALL
                                      (SPADCALL |a| |x| (QREFELT $ 98))
                                      (SPADCALL (QREFELT $ 84)
                                                (LIST
                                                 (SPADCALL |op| |nl|
                                                           (QREFELT $ 80))
                                                 |dm| |a|)
                                                (QREFELT $ 99))
                                      (QREFELT $ 100))
                                     (QREFELT $ 101)))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #2# (CDR #2#))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FSPECF;dvhypergeom| ((|l| #1=(|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG
         ((|aprod| (F)) (|nl| (|List| F)) (|nl1| (|List| F)) (|nl0| (|List| F))
          (|bprod| (F)) (|b| (F)) (#2=#:G1752 NIL) (|i| NIL) (|a| (F))
          (#3=#:G1751 NIL) (|q| #4=(|Integer|)) (|p| #4#) (|z| (F))
          (|l1| (|List| F)) (|ol| #1#) (|pqi| (|List| (|Integer|)))
          (|pq| (|List| F)) (|nn| (|NonNegativeInteger|)) (#5=#:G1742 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |l|))
              (LETT |nn|
                    (PROG1 (LETT #5# (- |n| 2))
                      (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #5#)))
              (LETT |pq| (SPADCALL |l| |nn| (QREFELT $ 303)))
              (LETT |pqi| (|FSPECF;get_int_listf| |pq| $)) (LETT |ol| |l|)
              (LETT |l| (SPADCALL |l| |nn| (QREFELT $ 302)))
              (LETT |l1| (REVERSE |l|)) (LETT |z| (|SPADfirst| |l1|))
              (LETT |p| (|SPADfirst| |pqi|))
              (LETT |q| (|SPADfirst| (CDR |pqi|)))
              (LETT |aprod| (|spadConstant| $ 74)) (LETT |nl| NIL)
              (SEQ (LETT |i| 1) (LETT #3# |p|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ (LETT |a| (|SPADfirst| |l|))
                        (LETT |nl|
                              (CONS
                               (SPADCALL |a| (|spadConstant| $ 74)
                                         (QREFELT $ 101))
                               |nl|))
                        (LETT |aprod| (SPADCALL |aprod| |a| (QREFELT $ 100)))
                        (EXIT (LETT |l| (CDR |l|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |bprod| (|spadConstant| $ 74))
              (SEQ (LETT |i| 1) (LETT #2# |q|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ (LETT |b| (|SPADfirst| |l|))
                        (LETT |nl|
                              (CONS
                               (SPADCALL |b| (|spadConstant| $ 74)
                                         (QREFELT $ 101))
                               |nl|))
                        (LETT |bprod| (SPADCALL |bprod| |b| (QREFELT $ 100)))
                        (EXIT (LETT |l| (CDR |l|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |nl0| (NREVERSE |nl|)) (LETT |nl1| (CONS |z| |pq|))
              (LETT |nl| (SPADCALL |nl0| |nl1| (QREFELT $ 78)))
              (LETT |aprod| (SPADCALL |aprod| |bprod| (QREFELT $ 109)))
              (EXIT
               (SPADCALL (|FSPECF;idvsum| (QREFELT $ 34) (- |nn| 1) |ol| |x| $)
                         (SPADCALL
                          (SPADCALL (SPADCALL |z| |x| (QREFELT $ 98)) |aprod|
                                    (QREFELT $ 100))
                          (SPADCALL (QREFELT $ 34) |nl| (QREFELT $ 80))
                          (QREFELT $ 100))
                         (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;add_pairs_to_list|
        ((|lp| (|List| (|List| F))) (|l| (|List| F)) ($ (|List| F)))
        (SPROG ((#1=#:G1758 NIL) (|p| NIL))
               (SEQ
                (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL (LENGTH |p|) 2 (QREFELT $ 304))
                         (|error| "not a list of pairs"))
                        ('T
                         (LETT |l|
                               (CONS (SPADCALL |p| 2 (QREFELT $ 95))
                                     (CONS (SPADCALL |p| 1 (QREFELT $ 95))
                                           |l|)))))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |l|)))) 

(SDEFUN |FSPECF;dvmeijer| ((|l| #1=(|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG
         ((|om| (F)) (|nm| (F)) (|l2| (|List| F)) (|sign| (F)) (|na| (F))
          (|a| (F)) (|n2| (|Integer|)) (|n1| (|Integer|)) (|z| (F))
          (|l1| (|List| F)) (|nli| (|List| (|Integer|))) (|nl| (|List| F))
          (|l0| #1#) (|nn| (|NonNegativeInteger|)) (#2=#:G1759 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |l|))
              (LETT |nn|
                    (PROG1 (LETT #2# (- |n| 4))
                      (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #2#)))
              (LETT |l0| |l|) (LETT |nl| (SPADCALL |l| |nn| (QREFELT $ 303)))
              (LETT |nli| (|FSPECF;get_int_listf| |nl| $))
              (LETT |l| (SPADCALL |l| |nn| (QREFELT $ 302)))
              (LETT |l1| (REVERSE |l|)) (LETT |z| (|SPADfirst| |l1|))
              (LETT |n1| (|SPADfirst| |nli|))
              (LETT |n2| (SPADCALL |nli| 2 (QREFELT $ 305)))
              (LETT |a| (|SPADfirst| |l|)) (LETT |sign| (|spadConstant| $ 74))
              (COND
               ((OR (> |n1| 0) (> |n2| 0))
                (SEQ
                 (LETT |na|
                       (SPADCALL |a| (|spadConstant| $ 74) (QREFELT $ 108)))
                 (COND
                  ((EQL |n1| 0)
                   (LETT |sign|
                         (SPADCALL (|spadConstant| $ 74) (QREFELT $ 110)))))
                 (EXIT (LETT |l2| (CONS |na| (CDR |l|))))))
               ('T
                (SEQ (LETT |na| |a|)
                     (COND
                      ((> (SPADCALL |nli| 3 (QREFELT $ 305)) 0)
                       (LETT |sign|
                             (SPADCALL (|spadConstant| $ 74)
                                       (QREFELT $ 110)))))
                     (EXIT
                      (LETT |l2|
                            (CONS
                             (SPADCALL |a| (|spadConstant| $ 74)
                                       (QREFELT $ 101))
                             (CDR |l|)))))))
              (LETT |nm|
                    (SPADCALL (QREFELT $ 35)
                              (SPADCALL |l2| |nl| (QREFELT $ 78))
                              (QREFELT $ 80)))
              (LETT |om| (SPADCALL (QREFELT $ 35) |l0| (QREFELT $ 80)))
              (EXIT
               (SPADCALL (|FSPECF;idvsum| (QREFELT $ 35) (- |nn| 1) |l0| |x| $)
                         (SPADCALL
                          (SPADCALL (SPADCALL |z| |x| (QREFELT $ 98))
                                    (SPADCALL
                                     (SPADCALL |sign| |nm| (QREFELT $ 100))
                                     (SPADCALL |na| |om| (QREFELT $ 100))
                                     (QREFELT $ 101))
                                    (QREFELT $ 100))
                          |z| (QREFELT $ 109))
                         (QREFELT $ 101)))))) 

(SDEFUN |FSPECF;get_if_list|
        ((|n| (|Integer|)) (|lf| (|List| (|InputForm|)))
         ($ (|List| (|List| (|InputForm|)))))
        (SPROG ((|a| (|List| (|InputForm|))) (#1=#:G1772 NIL) (|i| NIL))
               (SEQ (LETT |a| NIL)
                    (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ (LETT |a| (CONS (|SPADfirst| |lf|) |a|))
                              (EXIT (LETT |lf| (CDR |lf|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (LETT |a|
                          (CONS (SPADCALL '|construct| (QREFELT $ 171))
                                (NREVERSE |a|)))
                    (EXIT (LIST |a| |lf|))))) 

(SDEFUN |FSPECF;get_if_lists|
        ((|ln| (|List| (|Integer|))) (|lf| (|List| (|InputForm|)))
         ($ (|List| (|List| (|InputForm|)))))
        (SPROG
         ((|rl| (|List| (|List| (|InputForm|))))
          (|al| (|List| (|List| (|InputForm|)))) (#1=#:G1778 NIL) (|n| NIL))
         (SEQ (LETT |rl| NIL)
              (SEQ (LETT |n| NIL) (LETT #1# |ln|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |n| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |al| (|FSPECF;get_if_list| |n| |lf| $))
                        (LETT |rl| (CONS (|SPADfirst| |al|) |rl|))
                        (EXIT (LETT |lf| (|SPADfirst| (CDR |al|)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |rl| (NREVERSE |rl|)) (EXIT (CONS |lf| |rl|))))) 

(SDEFUN |FSPECF;get_int_listi|
        ((|n| (|Integer|)) (|lo| (|List| (|InputForm|)))
         ($ (|List| (|Integer|))))
        (SPROG
         ((|rl| (|List| (|Integer|))) (|p| (|Integer|)) (#1=#:G1785 NIL)
          (|i| NIL) (|n0| (|NonNegativeInteger|)) (#2=#:G1779 NIL))
         (SEQ
          (LETT |n0|
                (PROG1 (LETT #2# (- (LENGTH |lo|) |n|))
                  (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #2#)))
          (LETT |lo| (SPADCALL |lo| |n0| (QREFELT $ 307))) (LETT |rl| NIL)
          (SEQ (LETT |i| 1) (LETT #1# |n|) G190
               (COND ((|greater_SI| |i| #1#) (GO G191)))
               (SEQ (LETT |p| (SPADCALL (|SPADfirst| |lo|) (QREFELT $ 309)))
                    (LETT |rl| (CONS |p| |rl|)) (EXIT (LETT |lo| (CDR |lo|))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |rl| (NREVERSE |rl|)) (EXIT |rl|)))) 

(SDEFUN |FSPECF;get_of_list|
        ((|n| (|Integer|)) (|lo| (|List| (|OutputForm|)))
         ($ (|List| (|List| (|OutputForm|)))))
        (SPROG ((|a| (|List| (|OutputForm|))) (#1=#:G1791 NIL) (|i| NIL))
               (SEQ (LETT |a| NIL)
                    (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ (LETT |a| (CONS (|SPADfirst| |lo|) |a|))
                              (EXIT (LETT |lo| (CDR |lo|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (LETT |a| (NREVERSE |a|)) (EXIT (LIST |a| |lo|))))) 

(SDEFUN |FSPECF;get_of_lists|
        ((|ln| (|List| (|Integer|))) (|lo| (|List| (|OutputForm|)))
         ($ (|List| (|List| (|OutputForm|)))))
        (SPROG
         ((|rl| (|List| (|List| (|OutputForm|))))
          (|al| (|List| (|List| (|OutputForm|)))) (#1=#:G1797 NIL) (|n| NIL))
         (SEQ (LETT |rl| NIL)
              (SEQ (LETT |n| NIL) (LETT #1# |ln|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |n| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |al| (|FSPECF;get_of_list| |n| |lo| $))
                        (LETT |rl| (CONS (|SPADfirst| |al|) |rl|))
                        (EXIT (LETT |lo| (|SPADfirst| (CDR |al|)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |rl| (NREVERSE |rl|)) (EXIT (CONS |lo| |rl|))))) 

(SDEFUN |FSPECF;get_int_listo|
        ((|n| (|Integer|)) (|lo| (|List| (|OutputForm|)))
         ($ (|List| (|Integer|))))
        (SPROG
         ((|rl| (|List| (|Integer|))) (|p| (|Integer|)) (#1=#:G1804 NIL)
          (|i| NIL) (|n0| (|NonNegativeInteger|)) (#2=#:G1798 NIL))
         (SEQ
          (LETT |n0|
                (PROG1 (LETT #2# (- (LENGTH |lo|) |n|))
                  (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #2#)))
          (LETT |lo| (SPADCALL |lo| |n0| (QREFELT $ 310))) (LETT |rl| NIL)
          (SEQ (LETT |i| 1) (LETT #1# |n|) G190
               (COND ((|greater_SI| |i| #1#) (GO G191)))
               (SEQ (LETT |p| (SPADCALL (|SPADfirst| |lo|) (QREFELT $ 309)))
                    (LETT |rl| (CONS |p| |rl|)) (EXIT (LETT |lo| (CDR |lo|))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |rl| (NREVERSE |rl|)) (EXIT |rl|)))) 

(SDEFUN |FSPECF;dhyper0|
        ((|op| (|OutputForm|)) (|lo| (|List| (|OutputForm|)))
         ($ (|OutputForm|)))
        (SPROG
         ((|z| (|OutputForm|)) (|b| #1=(|List| (|OutputForm|))) (|a| #1#)
          (|al| (|List| (|List| (|OutputForm|)))) (|pql| (|List| (|Integer|)))
          (|n0| (|NonNegativeInteger|)) (#2=#:G1805 NIL))
         (SEQ
          (LETT |n0|
                (PROG1 (LETT #2# (- (LENGTH |lo|) 2))
                  (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #2#)))
          (LETT |pql| (|FSPECF;get_int_listo| 2 |lo| $))
          (LETT |lo| (SPADCALL |lo| |n0| (QREFELT $ 311)))
          (LETT |al| (|FSPECF;get_of_lists| |pql| |lo| $))
          (LETT |lo| (|SPADfirst| |al|)) (LETT |al| (CDR |al|))
          (LETT |a| (|SPADfirst| |al|)) (LETT |b| (|SPADfirst| (CDR |al|)))
          (LETT |z| (|SPADfirst| |lo|))
          (EXIT
           (SPADCALL |op|
                     (LIST (SPADCALL |a| (QREFELT $ 312))
                           (SPADCALL |b| (QREFELT $ 312)) |z|)
                     (QREFELT $ 313)))))) 

(SDEFUN |FSPECF;dhyper| ((|lo| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (|FSPECF;dhyper0| (SPADCALL '|hypergeometricF| (QREFELT $ 314)) |lo| $)) 

(SDEFUN |FSPECF;ddhyper| ((|lo| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (|FSPECF;dhyper0| (|SPADfirst| |lo|) (CDR |lo|) $)) 

(SDEFUN |FSPECF;dmeijer0|
        ((|op| (|OutputForm|)) (|lo| (|List| (|OutputForm|)))
         ($ (|OutputForm|)))
        (SPROG
         ((|z| (|OutputForm|)) (|al| (|List| (|List| (|OutputForm|))))
          (|nl| (|List| (|Integer|))) (|n0| (|NonNegativeInteger|))
          (#1=#:G1810 NIL))
         (SEQ
          (LETT |n0|
                (PROG1 (LETT #1# (- (LENGTH |lo|) 4))
                  (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #1#)))
          (LETT |nl| (|FSPECF;get_int_listo| 4 |lo| $))
          (LETT |lo| (SPADCALL |lo| |n0| (QREFELT $ 311)))
          (LETT |al| (|FSPECF;get_of_lists| |nl| |lo| $))
          (LETT |lo| (|SPADfirst| |al|)) (LETT |al| (CDR |al|))
          (LETT |z| (|SPADfirst| |lo|))
          (EXIT
           (SPADCALL |op|
                     (SPADCALL (SPADCALL (ELT $ 312) |al| (QREFELT $ 317))
                               (LIST |z|) (QREFELT $ 318))
                     (QREFELT $ 313)))))) 

(SDEFUN |FSPECF;dmeijer| ((|lo| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (|FSPECF;dmeijer0| (SPADCALL '|meijerG| (QREFELT $ 314)) |lo| $)) 

(SDEFUN |FSPECF;ddmeijer| ((|lo| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        (|FSPECF;dmeijer0| (|SPADfirst| |lo|) (CDR |lo|) $)) 

(SDEFUN |FSPECF;inhyper| ((|lf| (|List| (|InputForm|))) ($ (|InputForm|)))
        (SPROG
         ((|li| (|List| #1=(|InputForm|))) (|zi| #1#) (|bi| #2=(|InputForm|))
          (|b| #3=(|List| (|InputForm|))) (|ai| #2#) (|a| #3#)
          (|al| (|List| (|List| (|InputForm|)))) (|pqi| (|List| (|Integer|))))
         (SEQ (LETT |pqi| (|FSPECF;get_int_listi| 2 |lf| $))
              (LETT |al| (|FSPECF;get_if_lists| |pqi| |lf| $))
              (LETT |lf| (|SPADfirst| |al|)) (LETT |al| (CDR |al|))
              (LETT |a| (|SPADfirst| |al|))
              (LETT |ai| (SPADCALL |a| (QREFELT $ 172)))
              (LETT |b| (|SPADfirst| (CDR |al|)))
              (LETT |bi| (SPADCALL |b| (QREFELT $ 172)))
              (LETT |zi| (|SPADfirst| |lf|))
              (LETT |li|
                    (LIST (SPADCALL '|hypergeometricF| (QREFELT $ 171)) |ai|
                          |bi| |zi|))
              (EXIT (SPADCALL |li| (QREFELT $ 172)))))) 

(SDEFUN |FSPECF;inmeijer| ((|lf| (|List| (|InputForm|))) ($ (|InputForm|)))
        (SPROG
         ((|li| (|List| #1=(|InputForm|))) (|zi| #1#) (|di| #2=(|InputForm|))
          (|d| #3=(|List| (|InputForm|)))
          (|al| (|List| (|List| (|InputForm|)))) (|ci| #2#) (|c| #3#)
          (|bi| #2#) (|b| #3#) (|ai| #2#) (|a| #3#)
          (|pqi| (|List| (|Integer|))))
         (SEQ (LETT |pqi| (|FSPECF;get_int_listi| 4 |lf| $))
              (LETT |al| (|FSPECF;get_if_lists| |pqi| |lf| $))
              (LETT |lf| (|SPADfirst| |al|)) (LETT |al| (CDR |al|))
              (LETT |a| (|SPADfirst| |al|))
              (LETT |ai| (SPADCALL |a| (QREFELT $ 172))) (LETT |al| (CDR |al|))
              (LETT |b| (|SPADfirst| |al|))
              (LETT |bi| (SPADCALL |b| (QREFELT $ 172))) (LETT |al| (CDR |al|))
              (LETT |c| (|SPADfirst| |al|))
              (LETT |ci| (SPADCALL |c| (QREFELT $ 172))) (LETT |al| (CDR |al|))
              (LETT |d| (|SPADfirst| |al|))
              (LETT |di| (SPADCALL |d| (QREFELT $ 172)))
              (LETT |zi| (|SPADfirst| |lf|))
              (LETT |li|
                    (LIST (SPADCALL '|meijerG| (QREFELT $ 171)) |ai| |bi| |ci|
                          |di| |zi|))
              (EXIT (SPADCALL |li| (QREFELT $ 172)))))) 

(SDEFUN |FSPECF;iiHypergeometricF;LF;312| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (QREFELT $ 34) |l| (QREFELT $ 99))) 

(SDEFUN |FSPECF;iiMeijerG| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (QREFELT $ 35) |l| (QREFELT $ 99))) 

(SDEFUN |FSPECF;d_eis| ((|x| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL (SPADCALL (QREFELT $ 42) |x| (QREFELT $ 207))
                   (QREFELT $ 110))
         (SPADCALL (|spadConstant| $ 74) |x| (QREFELT $ 109)) (QREFELT $ 101))) 

(SDEFUN |FSPECF;d_erfs| ((|x| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL (SPADCALL 2 |x| (QREFELT $ 92))
                   (SPADCALL (QREFELT $ 43) |x| (QREFELT $ 207))
                   (QREFELT $ 100))
         (SPADCALL (SPADCALL 2 (QREFELT $ 76))
                   (SPADCALL (SPADCALL (QREFELT $ 124)) (QREFELT $ 113))
                   (QREFELT $ 109))
         (QREFELT $ 108))) 

(SDEFUN |FSPECF;d_erfis| ((|x| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL 2 |x| (QREFELT $ 92))
                    (SPADCALL (QREFELT $ 44) |x| (QREFELT $ 207))
                    (QREFELT $ 100))
          (QREFELT $ 110))
         (SPADCALL (SPADCALL 2 (QREFELT $ 76))
                   (SPADCALL (SPADCALL (QREFELT $ 124)) (QREFELT $ 113))
                   (QREFELT $ 109))
         (QREFELT $ 101))) 

(DECLAIM (NOTINLINE |FunctionalSpecialFunction;|)) 

(DEFUN |FunctionalSpecialFunction| (&REST #1=#:G1897)
  (SPROG NIL
         (PROG (#2=#:G1898)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionalSpecialFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FunctionalSpecialFunction;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionalSpecialFunction|)))))))))) 

(DEFUN |FunctionalSpecialFunction;| (|#1| |#2|)
  (SPROG
   ((#1=#:G832 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|FunctionalSpecialFunction| DV$1 DV$2))
    (LETT $ (GETREFV 320))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|RetractableTo|
                                                         (|Integer|)))))))
    (|haddProp| |$ConstructorCache| '|FunctionalSpecialFunction|
                (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 '|special|)
    (QSETREFV $ 13 (SPADCALL '|abs| (QREFELT $ 12)))
    (QSETREFV $ 14 (SPADCALL '|conjugate| (QREFELT $ 12)))
    (QSETREFV $ 15 (SPADCALL '|Gamma| (QREFELT $ 12)))
    (QSETREFV $ 16 (SPADCALL '|Gamma2| (QREFELT $ 12)))
    (QSETREFV $ 17 (SPADCALL '|Beta| (QREFELT $ 12)))
    (QSETREFV $ 18 (SPADCALL '|digamma| (QREFELT $ 12)))
    (QSETREFV $ 19 (SPADCALL '|polygamma| (QREFELT $ 12)))
    (QSETREFV $ 20 (SPADCALL '|besselJ| (QREFELT $ 12)))
    (QSETREFV $ 21 (SPADCALL '|besselY| (QREFELT $ 12)))
    (QSETREFV $ 22 (SPADCALL '|besselI| (QREFELT $ 12)))
    (QSETREFV $ 23 (SPADCALL '|besselK| (QREFELT $ 12)))
    (QSETREFV $ 24 (SPADCALL '|airyAi| (QREFELT $ 12)))
    (QSETREFV $ 25 (SPADCALL '|airyAiPrime| (QREFELT $ 12)))
    (QSETREFV $ 26 (SPADCALL '|airyBi| (QREFELT $ 12)))
    (QSETREFV $ 27 (SPADCALL '|airyBiPrime| (QREFELT $ 12)))
    (QSETREFV $ 28 (SPADCALL '|lambertW| (QREFELT $ 12)))
    (QSETREFV $ 29 (SPADCALL '|polylog| (QREFELT $ 12)))
    (QSETREFV $ 30 (SPADCALL '|weierstrassP| (QREFELT $ 12)))
    (QSETREFV $ 31 (SPADCALL '|weierstrassPPrime| (QREFELT $ 12)))
    (QSETREFV $ 32 (SPADCALL '|weierstrassSigma| (QREFELT $ 12)))
    (QSETREFV $ 33 (SPADCALL '|weierstrassZeta| (QREFELT $ 12)))
    (QSETREFV $ 34 (SPADCALL '|hypergeometricF| (QREFELT $ 12)))
    (QSETREFV $ 35 (SPADCALL '|meijerG| (QREFELT $ 12)))
    (QSETREFV $ 36 (SPADCALL '|charlierC| (QREFELT $ 12)))
    (QSETREFV $ 37 (SPADCALL '|hermiteH| (QREFELT $ 12)))
    (QSETREFV $ 38 (SPADCALL '|jacobiP| (QREFELT $ 12)))
    (QSETREFV $ 39 (SPADCALL '|laguerreL| (QREFELT $ 12)))
    (QSETREFV $ 40 (SPADCALL '|meixnerM| (QREFELT $ 12)))
    (QSETREFV $ 41 (SPADCALL '|%logGamma| (QREFELT $ 12)))
    (QSETREFV $ 42 (SPADCALL '|%eis| (QREFELT $ 12)))
    (QSETREFV $ 43 (SPADCALL '|%erfs| (QREFELT $ 12)))
    (QSETREFV $ 44 (SPADCALL '|%erfis| (QREFELT $ 12)))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 81
                 (CONS (|dispatchFunction| |FSPECF;hypergeometricF;2L2F;22|)
                       $))
       (QSETREFV $ 82
                 (CONS (|dispatchFunction| |FSPECF;meijerG;4L2F;23|) $)))))
    (QSETREFV $ 84
              (SPADCALL (SPADCALL '|%diff| (QREFELT $ 12)) (QREFELT $ 83)))
    (QSETREFV $ 87
              (PROG2
                  (LETT #1#
                        (SPADCALL (SPADCALL 2 (QREFELT $ 76)) (QREFELT $ 86)))
                  (QCDR #1#)
                (|check_union2| (QEQCAR #1# 0) |#2| (|Union| |#2| #2="failed")
                                #1#)))
    (QSETREFV $ 88
              (PROG2
                  (LETT #1#
                        (SPADCALL (SPADCALL 3 (QREFELT $ 76)) (QREFELT $ 86)))
                  (QCDR #1#)
                (|check_union2| (QEQCAR #1# 0) |#2| (|Union| |#2| #2#) #1#)))
    (QSETREFV $ 89
              (PROG2
                  (LETT #1#
                        (SPADCALL (SPADCALL 4 (QREFELT $ 76)) (QREFELT $ 86)))
                  (QCDR #1#)
                (|check_union2| (QEQCAR #1# 0) |#2| (|Union| |#2| #2#) #1#)))
    (QSETREFV $ 90
              (PROG2
                  (LETT #1#
                        (SPADCALL (SPADCALL 6 (QREFELT $ 76)) (QREFELT $ 86)))
                  (QCDR #1#)
                (|check_union2| (QEQCAR #1# 0) |#2| (|Union| |#2| #2#) #1#)))
    (QSETREFV $ 93 (SPADCALL 2 (QREFELT $ 88) (QREFELT $ 92)))
    (QSETREFV $ 94 (SPADCALL 3 (QREFELT $ 87) (QREFELT $ 92)))
    (QSETREFV $ 102 (SPADCALL '|weierstrassPInverse| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 102)
              (CONS (|function| |FSPECF;elWeierstrassPInverse|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|RadicalCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 102)
                 (LIST
                  (CONS (|function| |FSPECF;eWeierstrassPInverseGrad_g2|) $)
                  (CONS (|function| |FSPECF;eWeierstrassPInverseGrad_g3|) $)
                  (CONS (|function| |FSPECF;eWeierstrassPInverseGrad_z|) $))
                 (QREFELT $ 115)))))
    (QSETREFV $ 116 (SPADCALL '|whittakerM| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 116) (CONS (|function| |FSPECF;elWhittakerM|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 116) '|%specialDiff|
              (CONS (|function| |FSPECF;dWhittakerM|) $) (QREFELT $ 119))
    (QSETREFV $ 120 (SPADCALL '|whittakerW| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 120) (CONS (|function| |FSPECF;elWhittakerW|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 120) '|%specialDiff|
              (CONS (|function| |FSPECF;dWhittakerW|) $) (QREFELT $ 119))
    (QSETREFV $ 122 (SPADCALL '|angerJ| (QREFELT $ 12)))
    (COND
     ((|HasCategory| |#2| '(|TranscendentalFunctionCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 122) (CONS (|function| |FSPECF;elAngerJ|) $)
                 (QREFELT $ 106))
       (SPADCALL (QREFELT $ 122) '|%specialDiff|
                 (CONS (|function| |FSPECF;dAngerJ|) $) (QREFELT $ 119))))
     ('T
      (PROGN
       (SPADCALL (QREFELT $ 122) (CONS (|function| |FSPECF;eeAngerJ|) $)
                 (QREFELT $ 106)))))
    (QSETREFV $ 126 (SPADCALL '|weberE| (QREFELT $ 12)))
    (COND
     ((|HasCategory| |#2| '(|TranscendentalFunctionCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 126) (CONS (|function| |FSPECF;elWeberE|) $)
                 (QREFELT $ 106))
       (SPADCALL (QREFELT $ 126) '|%specialDiff|
                 (CONS (|function| |FSPECF;dWeberE|) $) (QREFELT $ 119))))
     ('T
      (PROGN
       (SPADCALL (QREFELT $ 126) (CONS (|function| |FSPECF;eeWeberE|) $)
                 (QREFELT $ 106)))))
    (QSETREFV $ 130 (SPADCALL '|struveH| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 130) (CONS (|function| |FSPECF;elStruveH|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|TranscendentalFunctionCategory|))
      (COND
       ((|HasCategory| |#2| '(|RadicalCategory|))
        (PROGN
         (SPADCALL (QREFELT $ 130) '|%specialDiff|
                   (CONS (|function| |FSPECF;dStruveH|) $)
                   (QREFELT $ 119)))))))
    (QSETREFV $ 133 (SPADCALL '|struveL| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 133) (CONS (|function| |FSPECF;elStruveL|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|TranscendentalFunctionCategory|))
      (COND
       ((|HasCategory| |#2| '(|RadicalCategory|))
        (PROGN
         (SPADCALL (QREFELT $ 133) '|%specialDiff|
                   (CONS (|function| |FSPECF;dStruveL|) $)
                   (QREFELT $ 119)))))))
    (QSETREFV $ 135 (SPADCALL '|hankelH1| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 135) (CONS (|function| |FSPECF;elHankelH1|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 135) '|%specialDiff|
              (CONS (|function| |FSPECF;dHankelH1|) $) (QREFELT $ 119))
    (QSETREFV $ 137 (SPADCALL '|hankelH2| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 137) (CONS (|function| |FSPECF;elHankelH2|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 137) '|%specialDiff|
              (CONS (|function| |FSPECF;dHankelH2|) $) (QREFELT $ 119))
    (QSETREFV $ 139 (SPADCALL '|lommelS1| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 139) (CONS (|function| |FSPECF;elLommelS1|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 139) '|%specialDiff|
              (CONS (|function| |FSPECF;dLommelS1|) $) (QREFELT $ 119))
    (QSETREFV $ 141 (SPADCALL '|lommelS2| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 141) (CONS (|function| |FSPECF;elLommelS2|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 141) '|%specialDiff|
              (CONS (|function| |FSPECF;dLommelS2|) $) (QREFELT $ 119))
    (QSETREFV $ 143 (SPADCALL '|kummerM| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 143) (CONS (|function| |FSPECF;elKummerM|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 143) '|%specialDiff|
              (CONS (|function| |FSPECF;dKummerM|) $) (QREFELT $ 119))
    (QSETREFV $ 145 (SPADCALL '|kummerU| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 145) (CONS (|function| |FSPECF;elKummerU|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 145) '|%specialDiff|
              (CONS (|function| |FSPECF;dKummerU|) $) (QREFELT $ 119))
    (QSETREFV $ 147 (SPADCALL '|legendreP| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 147) (CONS (|function| |FSPECF;elLegendreP|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 147) '|%specialDiff|
              (CONS (|function| |FSPECF;dLegendreP|) $) (QREFELT $ 119))
    (QSETREFV $ 149 (SPADCALL '|legendreQ| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 149) (CONS (|function| |FSPECF;elLegendreQ|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 149) '|%specialDiff|
              (CONS (|function| |FSPECF;dLegendreQ|) $) (QREFELT $ 119))
    (QSETREFV $ 151 (SPADCALL '|kelvinBei| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 151) (CONS (|function| |FSPECF;elKelvinBei|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|RadicalCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 151) '|%specialDiff|
                 (CONS (|function| |FSPECF;dKelvinBei|) $) (QREFELT $ 119)))))
    (QSETREFV $ 154 (SPADCALL '|kelvinBer| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 154) (CONS (|function| |FSPECF;elKelvinBer|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|RadicalCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 154) '|%specialDiff|
                 (CONS (|function| |FSPECF;dKelvinBer|) $) (QREFELT $ 119)))))
    (QSETREFV $ 155 (SPADCALL '|kelvinKei| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 155) (CONS (|function| |FSPECF;elKelvinKei|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|RadicalCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 155) '|%specialDiff|
                 (CONS (|function| |FSPECF;dKelvinKei|) $) (QREFELT $ 119)))))
    (QSETREFV $ 158 (SPADCALL '|kelvinKer| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 158) (CONS (|function| |FSPECF;elKelvinKer|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|RadicalCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 158) '|%specialDiff|
                 (CONS (|function| |FSPECF;dKelvinKer|) $) (QREFELT $ 119)))))
    (QSETREFV $ 159 (SPADCALL '|ellipticK| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 159) (CONS (|function| |FSPECF;elEllipticK|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 159) (CONS (|function| |FSPECF;dEllipticK|) $)
              (QREFELT $ 165))
    (QSETREFV $ 166 (SPADCALL '|ellipticE| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 166) (CONS (|function| |FSPECF;elEllipticE|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 166) (CONS (|function| |FSPECF;dEllipticE|) $)
              (QREFELT $ 165))
    (QSETREFV $ 167 (SPADCALL '|ellipticE2| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 167) (CONS (|function| |FSPECF;elEllipticE2|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|RadicalCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 167)
                 (LIST (CONS (|function| |FSPECF;eEllipticE2Grad_z|) $)
                       (CONS (|function| |FSPECF;eEllipticE2Grad_m|) $))
                 (QREFELT $ 115)))))
    (SPADCALL (QREFELT $ 167) (CONS (|function| |FSPECF;inEllipticE2|) $)
              (QREFELT $ 174))
    (QSETREFV $ 175 (SPADCALL '|ellipticF| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 175) (CONS (|function| |FSPECF;elEllipticF|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|RadicalCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 175)
                 (LIST (CONS (|function| |FSPECF;eEllipticFGrad_z|) $)
                       (CONS (|function| |FSPECF;eEllipticFGrad_m|) $))
                 (QREFELT $ 115)))))
    (QSETREFV $ 176 (SPADCALL '|ellipticPi| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 176) (CONS (|function| |FSPECF;elEllipticPi|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|RadicalCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 176)
                 (LIST (CONS (|function| |FSPECF;eEllipticPiGrad_z|) $)
                       (CONS (|function| |FSPECF;eEllipticPiGrad_n|) $)
                       (CONS (|function| |FSPECF;eEllipticPiGrad_m|) $))
                 (QREFELT $ 115)))))
    (QSETREFV $ 178 (SPADCALL '|jacobiSn| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 178) (CONS (|function| |FSPECF;elJacobiSn|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 178)
              (LIST (CONS (|function| |FSPECF;eJacobiSnGrad_z|) $)
                    (CONS (|function| |FSPECF;eJacobiSnGrad_m|) $))
              (QREFELT $ 115))
    (QSETREFV $ 187 (SPADCALL '|jacobiCn| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 187) (CONS (|function| |FSPECF;elJacobiCn|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 187)
              (LIST (CONS (|function| |FSPECF;eJacobiCnGrad_z|) $)
                    (CONS (|function| |FSPECF;eJacobiCnGrad_m|) $))
              (QREFELT $ 115))
    (QSETREFV $ 188 (SPADCALL '|jacobiDn| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 188) (CONS (|function| |FSPECF;elJacobiDn|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 188)
              (LIST (CONS (|function| |FSPECF;eJacobiDnGrad_z|) $)
                    (CONS (|function| |FSPECF;eJacobiDnGrad_m|) $))
              (QREFELT $ 115))
    (QSETREFV $ 189 (SPADCALL '|jacobiZeta| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 189) (CONS (|function| |FSPECF;elJacobiZeta|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 189)
              (LIST (CONS (|function| |FSPECF;eJacobiZetaGrad_z|) $)
                    (CONS (|function| |FSPECF;eJacobiZetaGrad_m|) $))
              (QREFELT $ 115))
    (QSETREFV $ 191 (SPADCALL '|jacobiTheta| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 191) (CONS (|function| |FSPECF;elJacobiTheta|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 191)
              (LIST (CONS (|function| |FSPECF;eJacobiThetaGrad_z|) $)
                    (CONS (|function| |FSPECF;eJacobiThetaGrad_m|) $))
              (QREFELT $ 115))
    (QSETREFV $ 193 (SPADCALL '|lerchPhi| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 193) (CONS (|function| |FSPECF;elLerchPhi|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 193) '|%specialDiff|
              (CONS (|function| |FSPECF;dLerchPhi|) $) (QREFELT $ 119))
    (QSETREFV $ 195 (SPADCALL '|riemannZeta| (QREFELT $ 12)))
    (SPADCALL (QREFELT $ 195) (CONS (|function| |FSPECF;elRiemannZeta|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 36) (CONS (|function| |FSPECF;elCharlierC|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 37) (CONS (|function| |FSPECF;elHermiteH|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 37) '|%specialDiff|
              (CONS (|function| |FSPECF;dHermiteH|) $) (QREFELT $ 119))
    (SPADCALL (QREFELT $ 38) (CONS (|function| |FSPECF;elJacobiP|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 38) '|%specialDiff|
              (CONS (|function| |FSPECF;dJacobiP|) $) (QREFELT $ 119))
    (SPADCALL (QREFELT $ 39) (CONS (|function| |FSPECF;elLaguerreL|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 39) '|%specialDiff|
              (CONS (|function| |FSPECF;dLaguerreL|) $) (QREFELT $ 119))
    (SPADCALL (QREFELT $ 40) (CONS (|function| |FSPECF;elMeixnerM|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|ElementaryFunctionCategory|))
      (PROGN
       (QSETREFV $ 211 (CONS (|dispatchFunction| |FSPECF;iAiryAi;2F;216|) $))
       (QSETREFV $ 212
                 (CONS (|dispatchFunction| |FSPECF;iAiryAiPrime;2F;217|) $))
       (QSETREFV $ 213 (CONS (|dispatchFunction| |FSPECF;iAiryBi;2F;218|) $))
       (QSETREFV $ 214
                 (CONS (|dispatchFunction| |FSPECF;iAiryBiPrime;2F;219|) $))))
     ('T
      (PROGN
       (QSETREFV $ 211 (CONS (|dispatchFunction| |FSPECF;iAiryAi;2F;220|) $))
       (QSETREFV $ 212
                 (CONS (|dispatchFunction| |FSPECF;iAiryAiPrime;2F;221|) $))
       (QSETREFV $ 213 (CONS (|dispatchFunction| |FSPECF;iAiryBi;2F;222|) $))
       (QSETREFV $ 214
                 (CONS (|dispatchFunction| |FSPECF;iAiryBiPrime;2F;223|) $)))))
    (COND
     ((|HasCategory| |#2| '(|ElementaryFunctionCategory|))
      (QSETREFV $ 216 (CONS (|dispatchFunction| |FSPECF;iLambertW;2F;224|) $)))
     ('T
      (QSETREFV $ 216
                (CONS (|dispatchFunction| |FSPECF;iLambertW;2F;225|) $))))
    (COND
     ((|HasCategory| |#2| '(|ElementaryFunctionCategory|))
      (COND
       ((|HasCategory| |#2| '(|LiouvillianFunctionCategory|))
        (QSETREFV $ 219
                  (CONS (|dispatchFunction| |FSPECF;iiPolylog;3F;226|) $)))
       ('T
        (QSETREFV $ 219
                  (CONS (|dispatchFunction| |FSPECF;iiPolylog;3F;227|) $)))))
     ('T
      (QSETREFV $ 219
                (CONS (|dispatchFunction| |FSPECF;iiPolylog;3F;228|) $))))
    (COND
     ((|HasSignature| |#1|
                      (LIST '|abs|
                            (LIST (|devaluate| |#1|) (|devaluate| |#1|))))
      (PROGN
       (QSETREFV $ 231 (CONS (|dispatchFunction| |FSPECF;iiabs;2F;234|) $))))
     ('T (QSETREFV $ 231 (CONS (|dispatchFunction| |FSPECF;iiabs;2F;235|) $))))
    (COND
     ((|HasCategory| |#1| '(|SpecialFunctionCategory|))
      (PROGN
       (QSETREFV $ 259 (CONS (|dispatchFunction| |FSPECF;iiGamma;2F;237|) $))
       (QSETREFV $ 261 (CONS (|dispatchFunction| |FSPECF;iiBeta;LF;238|) $))
       (QSETREFV $ 263 (CONS (|dispatchFunction| |FSPECF;iidigamma;2F;239|) $))
       (QSETREFV $ 265
                 (CONS (|dispatchFunction| |FSPECF;iipolygamma;LF;240|) $))
       (QSETREFV $ 267 (CONS (|dispatchFunction| |FSPECF;iiBesselJ;LF;241|) $))
       (QSETREFV $ 269 (CONS (|dispatchFunction| |FSPECF;iiBesselY;LF;242|) $))
       (QSETREFV $ 271 (CONS (|dispatchFunction| |FSPECF;iiBesselI;LF;243|) $))
       (QSETREFV $ 273 (CONS (|dispatchFunction| |FSPECF;iiBesselK;LF;244|) $))
       (QSETREFV $ 275 (CONS (|dispatchFunction| |FSPECF;iiAiryAi;2F;245|) $))
       (QSETREFV $ 277
                 (CONS (|dispatchFunction| |FSPECF;iiAiryAiPrime;2F;246|) $))
       (QSETREFV $ 279 (CONS (|dispatchFunction| |FSPECF;iiAiryBi;2F;247|) $))
       (QSETREFV $ 281
                 (CONS (|dispatchFunction| |FSPECF;iiAiryBiPrime;2F;248|) $))))
     ('T
      (PROGN
       (COND
        ((|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
         (QSETREFV $ 259
                   (CONS (|dispatchFunction| |FSPECF;iiGamma;2F;249|) $)))
        ('T
         (QSETREFV $ 259
                   (CONS (|dispatchFunction| |FSPECF;iiGamma;2F;250|) $))))
       (QSETREFV $ 261 (CONS (|dispatchFunction| |FSPECF;iiBeta;LF;251|) $))
       (QSETREFV $ 263 (CONS (|dispatchFunction| |FSPECF;iidigamma;2F;252|) $))
       (QSETREFV $ 265
                 (CONS (|dispatchFunction| |FSPECF;iipolygamma;LF;253|) $))
       (QSETREFV $ 267 (CONS (|dispatchFunction| |FSPECF;iiBesselJ;LF;254|) $))
       (QSETREFV $ 269 (CONS (|dispatchFunction| |FSPECF;iiBesselY;LF;255|) $))
       (QSETREFV $ 271 (CONS (|dispatchFunction| |FSPECF;iiBesselI;LF;256|) $))
       (QSETREFV $ 273 (CONS (|dispatchFunction| |FSPECF;iiBesselK;LF;257|) $))
       (QSETREFV $ 275 (CONS (|dispatchFunction| |FSPECF;iiAiryAi;2F;258|) $))
       (QSETREFV $ 277
                 (CONS (|dispatchFunction| |FSPECF;iiAiryAiPrime;2F;259|) $))
       (QSETREFV $ 279 (CONS (|dispatchFunction| |FSPECF;iiAiryBi;2F;260|) $))
       (QSETREFV $ 281
                 (CONS (|dispatchFunction| |FSPECF;iiAiryBiPrime;2F;261|)
                       $)))))
    (SPADCALL (QREFELT $ 15) (ELT $ 259) (QREFELT $ 286))
    (SPADCALL (QREFELT $ 13) (ELT $ 231) (QREFELT $ 286))
    (SPADCALL (QREFELT $ 14) (ELT $ 242) (QREFELT $ 286))
    (SPADCALL (QREFELT $ 17) (ELT $ 261) (QREFELT $ 106))
    (SPADCALL (QREFELT $ 18) (ELT $ 263) (QREFELT $ 286))
    (SPADCALL (QREFELT $ 19) (ELT $ 265) (QREFELT $ 106))
    (SPADCALL (QREFELT $ 20) (ELT $ 267) (QREFELT $ 106))
    (SPADCALL (QREFELT $ 21) (ELT $ 269) (QREFELT $ 106))
    (SPADCALL (QREFELT $ 22) (ELT $ 271) (QREFELT $ 106))
    (SPADCALL (QREFELT $ 23) (ELT $ 273) (QREFELT $ 106))
    (SPADCALL (QREFELT $ 24) (ELT $ 275) (QREFELT $ 286))
    (SPADCALL (QREFELT $ 25) (ELT $ 277) (QREFELT $ 286))
    (SPADCALL (QREFELT $ 26) (ELT $ 279) (QREFELT $ 286))
    (SPADCALL (QREFELT $ 27) (ELT $ 281) (QREFELT $ 286))
    (SPADCALL (QREFELT $ 28) (ELT $ 216) (QREFELT $ 286))
    (SPADCALL (QREFELT $ 29) (CONS (|function| |FSPECF;iPolylog|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 30) (CONS (|function| |FSPECF;iiWeierstrassP|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 31) (CONS (|function| |FSPECF;iiWeierstrassPPrime|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 32) (CONS (|function| |FSPECF;iiWeierstrassSigma|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 33) (CONS (|function| |FSPECF;iiWeierstrassZeta|) $)
              (QREFELT $ 106))
    (SPADCALL (QREFELT $ 34) (ELT $ 287) (QREFELT $ 106))
    (SPADCALL (QREFELT $ 35) (CONS (|function| |FSPECF;iiMeijerG|) $)
              (QREFELT $ 106))
    (COND
     ((|HasCategory| |#2| '(|ElementaryFunctionCategory|))
      (PROGN
       (SPADCALL (QREFELT $ 16) '|%specialDiff|
                 (CONS (|function| |FSPECF;iGamma2|) $) (QREFELT $ 119)))))
    (SPADCALL (QREFELT $ 16) (CONS (|function| |FSPECF;inGamma2|) $)
              (QREFELT $ 174))
    (SPADCALL (QREFELT $ 14) (CONS (|function| |FSPECF;dconjugate|) $)
              (QREFELT $ 296))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 287
                 (CONS (|dispatchFunction| |FSPECF;iiHypergeometricF;LF;293|)
                       $))
       (SPADCALL (QREFELT $ 34) '|%diffDisp|
                 (CONS (|function| |FSPECF;ddhyper|) $) (QREFELT $ 119))
       (SPADCALL (QREFELT $ 35) '|%diffDisp|
                 (CONS (|function| |FSPECF;ddmeijer|) $) (QREFELT $ 119))
       (SPADCALL (QREFELT $ 34) (CONS (|function| |FSPECF;dhyper|) $)
                 (QREFELT $ 296))
       (SPADCALL (QREFELT $ 35) (CONS (|function| |FSPECF;dmeijer|) $)
                 (QREFELT $ 296))
       (SPADCALL (QREFELT $ 34) '|%specialDiff|
                 (CONS (|function| |FSPECF;dvhypergeom|) $) (QREFELT $ 119))
       (SPADCALL (QREFELT $ 35) '|%specialDiff|
                 (CONS (|function| |FSPECF;dvmeijer|) $) (QREFELT $ 119))
       (SPADCALL (QREFELT $ 34) (CONS (|function| |FSPECF;inhyper|) $)
                 (QREFELT $ 174))
       (SPADCALL (QREFELT $ 35) (CONS (|function| |FSPECF;inmeijer|) $)
                 (QREFELT $ 174))))
     ('T
      (QSETREFV $ 287
                (CONS (|dispatchFunction| |FSPECF;iiHypergeometricF;LF;312|)
                      $))))
    (COND
     ((|HasCategory| |#2| '(|TranscendentalFunctionCategory|))
      (COND
       ((|HasCategory| |#2| '(|RadicalCategory|))
        (PROGN
         (SPADCALL (QREFELT $ 43) (CONS (|function| |FSPECF;d_erfs|) $)
                   (QREFELT $ 165))
         (SPADCALL (QREFELT $ 44) (CONS (|function| |FSPECF;d_erfis|) $)
                   (QREFELT $ 165)))))))
    (SPADCALL (QREFELT $ 13) (CONS #'|FunctionalSpecialFunction!0| $)
              (QREFELT $ 165))
    (SPADCALL (QREFELT $ 15) (CONS #'|FunctionalSpecialFunction!1| $)
              (QREFELT $ 165))
    (SPADCALL (QREFELT $ 41) (ELT $ 52) (QREFELT $ 165))
    (SPADCALL (QREFELT $ 17)
              (LIST (CONS (|function| |FSPECF;iBetaGrad1|) $)
                    (CONS (|function| |FSPECF;iBetaGrad2|) $))
              (QREFELT $ 115))
    (SPADCALL (QREFELT $ 18) (CONS #'|FunctionalSpecialFunction!2| $)
              (QREFELT $ 165))
    (SPADCALL (QREFELT $ 42) (CONS (|function| |FSPECF;d_eis|) $)
              (QREFELT $ 165))
    (SPADCALL (QREFELT $ 24) (ELT $ 59) (QREFELT $ 165))
    (SPADCALL (QREFELT $ 25) (CONS #'|FunctionalSpecialFunction!3| $)
              (QREFELT $ 165))
    (SPADCALL (QREFELT $ 26) (ELT $ 61) (QREFELT $ 165))
    (SPADCALL (QREFELT $ 27) (CONS #'|FunctionalSpecialFunction!4| $)
              (QREFELT $ 165))
    (SPADCALL (QREFELT $ 28) (CONS (|function| |FSPECF;dLambertW|) $)
              (QREFELT $ 165))
    (SPADCALL (QREFELT $ 30)
              (LIST (CONS (|function| |FSPECF;iWeierstrassPGrad1|) $)
                    (CONS (|function| |FSPECF;iWeierstrassPGrad2|) $)
                    (CONS (|function| |FSPECF;iWeierstrassPGrad3|) $))
              (QREFELT $ 115))
    (SPADCALL (QREFELT $ 31)
              (LIST (CONS (|function| |FSPECF;iWeierstrassPPrimeGrad1|) $)
                    (CONS (|function| |FSPECF;iWeierstrassPPrimeGrad2|) $)
                    (CONS (|function| |FSPECF;iWeierstrassPPrimeGrad3|) $))
              (QREFELT $ 115))
    (SPADCALL (QREFELT $ 32)
              (LIST (CONS (|function| |FSPECF;iWeierstrassSigmaGrad1|) $)
                    (CONS (|function| |FSPECF;iWeierstrassSigmaGrad2|) $)
                    (CONS (|function| |FSPECF;iWeierstrassSigmaGrad3|) $))
              (QREFELT $ 115))
    (SPADCALL (QREFELT $ 33)
              (LIST (CONS (|function| |FSPECF;iWeierstrassZetaGrad1|) $)
                    (CONS (|function| |FSPECF;iWeierstrassZetaGrad2|) $)
                    (CONS (|function| |FSPECF;iWeierstrassZetaGrad3|) $))
              (QREFELT $ 115))
    (SPADCALL (QREFELT $ 19) '|%specialDiff|
              (CONS (|function| |FSPECF;ipolygamma|) $) (QREFELT $ 119))
    (SPADCALL (QREFELT $ 20) '|%specialDiff|
              (CONS (|function| |FSPECF;iBesselJ|) $) (QREFELT $ 119))
    (SPADCALL (QREFELT $ 21) '|%specialDiff|
              (CONS (|function| |FSPECF;iBesselY|) $) (QREFELT $ 119))
    (SPADCALL (QREFELT $ 22) '|%specialDiff|
              (CONS (|function| |FSPECF;iBesselI|) $) (QREFELT $ 119))
    (SPADCALL (QREFELT $ 23) '|%specialDiff|
              (CONS (|function| |FSPECF;iBesselK|) $) (QREFELT $ 119))
    (SPADCALL (QREFELT $ 29) '|%specialDiff|
              (CONS (|function| |FSPECF;dPolylog|) $) (QREFELT $ 119))
    $))) 

(DEFUN |FunctionalSpecialFunction!4| (|x| $)
  (SPADCALL |x| (SPADCALL |x| (QREFELT $ 60)) (QREFELT $ 100))) 

(DEFUN |FunctionalSpecialFunction!3| (|x| $)
  (SPADCALL |x| (SPADCALL |x| (QREFELT $ 58)) (QREFELT $ 100))) 

(DEFUN |FunctionalSpecialFunction!2| (|x| $)
  (SPADCALL (|spadConstant| $ 74) |x| (QREFELT $ 53))) 

(DEFUN |FunctionalSpecialFunction!1| (|x| $)
  (SPADCALL (SPADCALL |x| (QREFELT $ 52)) (SPADCALL |x| (QREFELT $ 48))
            (QREFELT $ 100))) 

(DEFUN |FunctionalSpecialFunction!0| (|x| $)
  (SPADCALL (SPADCALL |x| (QREFELT $ 46)) (SPADCALL |x| (QREFELT $ 319))
            (QREFELT $ 100))) 

(MAKEPROP '|FunctionalSpecialFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'SPECIAL
              (|BasicOperator|) (|Symbol|) (|CommonOperators|) (0 . |operator|)
              '|opabs| '|opconjugate| '|opGamma| '|opGamma2| '|opBeta|
              '|opdigamma| '|oppolygamma| '|opBesselJ| '|opBesselY|
              '|opBesselI| '|opBesselK| '|opAiryAi| '|opAiryAiPrime|
              '|opAiryBi| '|opAiryBiPrime| '|opLambertW| '|opPolylog|
              '|opWeierstrassP| '|opWeierstrassPPrime| '|opWeierstrassSigma|
              '|opWeierstrassZeta| '|opHypergeometricF| '|opMeijerG|
              '|opCharlierC| '|opHermiteH| '|opJacobiP| '|opLaguerreL|
              '|opMeixnerM| '|op_log_gamma| '|op_eis| '|op_erfs| '|op_erfis|
              (5 . |elt|) |FSPECF;abs;2F;1| |FSPECF;conjugate;2F;2|
              |FSPECF;Gamma;2F;3| (11 . |elt|) |FSPECF;Gamma;3F;4|
              |FSPECF;Beta;3F;5| |FSPECF;digamma;2F;6| |FSPECF;polygamma;3F;7|
              |FSPECF;besselJ;3F;8| |FSPECF;besselY;3F;9|
              |FSPECF;besselI;3F;10| |FSPECF;besselK;3F;11|
              |FSPECF;airyAi;2F;12| |FSPECF;airyAiPrime;2F;13|
              |FSPECF;airyBi;2F;14| |FSPECF;airyBiPrime;2F;15|
              |FSPECF;lambertW;2F;16| |FSPECF;polylog;3F;17| (18 . |elt|)
              |FSPECF;weierstrassP;4F;18| |FSPECF;weierstrassPPrime;4F;19|
              |FSPECF;weierstrassSigma;4F;20| |FSPECF;weierstrassZeta;4F;21|
              (26 . |Zero|) (30 . |Zero|) (|Boolean|) (34 . =) (40 . |One|)
              (44 . |One|) (|Integer|) (48 . |coerce|) (|List| 7)
              (53 . |concat|) (|List| $) (59 . |elt|) (65 . |hypergeometricF|)
              (72 . |meijerG|) (81 . |operator|) '|opdiff|
              (|Union| $ '"failed") (86 . |recip|) '|ahalf| '|athird|
              '|afourth| '|asixth| (|PositiveInteger|) (91 . *) '|twothirds|
              '|threehalfs| (97 . |elt|) (103 . |new|) (107 . |coerce|)
              (112 . |differentiate|) (118 . |kernel|) (124 . *) (130 . +)
              '|opWeierstrassPInverse| |FSPECF;weierstrassPInverse;4F;27|
              (|Mapping| 7 77) (|BasicOperatorFunctions1| 7) (136 . |evaluate|)
              (142 . ^) (148 . -) (154 . /) (160 . -)
              (|SparseMultivariatePolynomial| 6 183) (165 . |One|)
              (169 . |sqrt|) (|List| 104) (174 . |derivative|) '|opWhittakerM|
              |FSPECF;whittakerM;4F;33| (|None|) (180 . |setProperty|)
              '|opWhittakerW| |FSPECF;whittakerW;4F;38| '|opAngerJ|
              |FSPECF;angerJ;3F;43| (187 . |pi|) (191 . |sin|) '|opWeberE|
              |FSPECF;weberE;3F;49| (196 . ^) (202 . |cos|) '|opStruveH|
              |FSPECF;struveH;3F;55| (207 . ^) '|opStruveL|
              |FSPECF;struveL;3F;60| '|opHankelH1| |FSPECF;hankelH1;3F;65|
              '|opHankelH2| |FSPECF;hankelH2;3F;70| '|opLommelS1|
              |FSPECF;lommelS1;4F;75| '|opLommelS2| |FSPECF;lommelS2;4F;80|
              '|opKummerM| |FSPECF;kummerM;4F;85| '|opKummerU|
              |FSPECF;kummerU;4F;90| '|opLegendreP| |FSPECF;legendreP;4F;95|
              '|opLegendreQ| |FSPECF;legendreQ;4F;100| '|opKelvinBei|
              |FSPECF;kelvinBei;3F;105| |FSPECF;kelvinBer;3F;110|
              '|opKelvinBer| '|opKelvinKei| |FSPECF;kelvinKei;3F;115|
              |FSPECF;kelvinKer;3F;120| '|opKelvinKer| '|opEllipticK|
              |FSPECF;ellipticK;2F;125| |FSPECF;ellipticE;2F;129|
              (|Fraction| 75) (213 . |One|) (|Mapping| 7 7)
              (217 . |derivative|) '|opEllipticE| '|opEllipticE2|
              |FSPECF;ellipticE;3F;133| |FSPECF;ellipticF;3F;139| (|InputForm|)
              (223 . |convert|) (228 . |convert|) (|Mapping| 170 306)
              (233 . |input|) '|opEllipticF| '|opEllipticPi|
              |FSPECF;ellipticPi;4F;144| '|opJacobiSn| |FSPECF;jacobiSn;3F;150|
              (239 . |is?|) (|Kernel| $) (245 . |retract|) (|Kernel| 7)
              (250 . |argument|) |FSPECF;jacobiCn;3F;156|
              |FSPECF;jacobiDn;3F;161| '|opJacobiCn| '|opJacobiDn|
              '|opJacobiZeta| |FSPECF;jacobiZeta;3F;166| '|opJacobiTheta|
              |FSPECF;jacobiTheta;3F;171| '|opLerchPhi|
              |FSPECF;lerchPhi;4F;176| '|opRiemannZeta|
              |FSPECF;riemannZeta;2F;180| |FSPECF;charlierC;4F;183|
              |FSPECF;hermiteH;3F;186| (255 . |elt|) |FSPECF;jacobiP;5F;191|
              |FSPECF;laguerreL;4F;196| |FSPECF;meixnerM;5F;201| (264 . |has?|)
              |FSPECF;belong?;BoB;204| (270 . |is?|) |FSPECF;operator;2Bo;205|
              (276 . |kernel|) (282 . |zero?|) (287 . |one?|)
              (292 . |smaller?|) (298 . |iAiryAi|) (303 . |iAiryAiPrime|)
              (308 . |iAiryBi|) (313 . |iAiryBiPrime|) (318 . |exp|)
              (323 . |iLambertW|) (328 . |log|) (333 . |dilog|)
              (338 . |iiPolylog|) (344 . |second|) (|Union| 224 '#1="failed")
              (349 . |retractIfCan|) (|Polynomial| 6) (|Fraction| 223)
              (354 . |numer|) (|Union| 6 '"failed") (359 . |retractIfCan|)
              (364 . |denom|) (369 . |abs|) (374 . |coerce|) (379 . |iiabs|)
              (|Union| 10 '#1#) (384 . |retractIfCan|) (|List| 181)
              (389 . |kernels|) (|NonNegativeInteger|) (394 . |height|)
              (399 . |Zero|) (403 . =) (409 . |coerce|) (414 . |One|)
              |FSPECF;iiconjugate;2F;236| (|Mapping| $ $) (418 . |map|)
              (|Mapping| 7 183) (|List| 183) (|ListFunctions2| 183 7)
              (424 . |map|) (430 . |eval|) (437 . |conjugate|)
              (|SparseMultivariatePolynomial| 6 181) (442 . |numer|)
              (|Mapping| 6 6) (447 . |map|) (453 . |coerce|) (458 . |denom|)
              (463 . |retractIfCan|) (468 . |Gamma|) (473 . |iiGamma|)
              (478 . |Beta|) (484 . |iiBeta|) (489 . |digamma|)
              (494 . |iidigamma|) (499 . |polygamma|) (505 . |iipolygamma|)
              (510 . |besselJ|) (516 . |iiBesselJ|) (521 . |besselY|)
              (527 . |iiBesselY|) (532 . |besselI|) (538 . |iiBesselI|)
              (543 . |besselK|) (549 . |iiBesselK|) (554 . |airyAi|)
              (559 . |iiAiryAi|) (564 . |airyAiPrime|) (569 . |iiAiryAiPrime|)
              (574 . |airyBi|) (579 . |iiAiryBi|) (584 . |airyBiPrime|)
              (589 . |iiAiryBiPrime|) (|Union| 75 '#1#) (594 . |retractIfCan|)
              (599 . |factorial|) (604 . |third|) (609 . |evaluate|)
              (615 . |iiHypergeometricF|) (|List| 10) (620 . |variables|)
              (625 . |member?|) (|OutputForm|) (|List| 291) (631 . |elt|)
              (637 . |overbar|) (|Mapping| 291 292) (642 . |display|)
              (648 . |retract|) (|List| 75) (|Mapping| 75 7)
              (|ListFunctions2| 7 75) (653 . |map|) (659 . |first|)
              (665 . |rest|) (671 . ~=) (677 . |elt|) (|List| 170)
              (683 . |rest|) (|SExpression|) (689 . |integer|) (694 . |rest|)
              (700 . |first|) (706 . |bracket|) (711 . |prefix|)
              (717 . |coerce|) (|List| 292) (|ListFunctions2| 292 291)
              (722 . |map|) (728 . |concat|) (734 . |inv|))
           '#(|whittakerW| 739 |whittakerM| 746 |weierstrassZeta| 753
              |weierstrassSigma| 760 |weierstrassPPrime| 767
              |weierstrassPInverse| 774 |weierstrassP| 781 |weberE| 788
              |struveL| 794 |struveH| 800 |riemannZeta| 806 |polylog| 811
              |polygamma| 817 |operator| 823 |meixnerM| 828 |meijerG| 836
              |lommelS2| 845 |lommelS1| 852 |lerchPhi| 859 |legendreQ| 866
              |legendreP| 873 |lambertW| 880 |laguerreL| 885 |kummerU| 892
              |kummerM| 899 |kelvinKer| 906 |kelvinKei| 912 |kelvinBer| 918
              |kelvinBei| 924 |jacobiZeta| 930 |jacobiTheta| 936 |jacobiSn| 942
              |jacobiP| 948 |jacobiDn| 956 |jacobiCn| 962 |iipolygamma| 968
              |iidigamma| 973 |iiconjugate| 978 |iiabs| 983 |iiPolylog| 988
              |iiHypergeometricF| 994 |iiGamma| 999 |iiBeta| 1004 |iiBesselY|
              1009 |iiBesselK| 1014 |iiBesselJ| 1019 |iiBesselI| 1024
              |iiAiryBiPrime| 1029 |iiAiryBi| 1034 |iiAiryAiPrime| 1039
              |iiAiryAi| 1044 |iLambertW| 1049 |iAiryBiPrime| 1054 |iAiryBi|
              1059 |iAiryAiPrime| 1064 |iAiryAi| 1069 |hypergeometricF| 1074
              |hermiteH| 1081 |hankelH2| 1087 |hankelH1| 1093 |ellipticPi| 1099
              |ellipticK| 1106 |ellipticF| 1111 |ellipticE| 1117 |digamma| 1128
              |conjugate| 1133 |charlierC| 1138 |besselY| 1145 |besselK| 1151
              |besselJ| 1157 |besselI| 1163 |belong?| 1169 |angerJ| 1174
              |airyBiPrime| 1180 |airyBi| 1185 |airyAiPrime| 1190 |airyAi| 1195
              |abs| 1200 |Gamma| 1205 |Beta| 1216)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|belong?| ((|Boolean|) (|BasicOperator|))) T)
                              '((|operator|
                                 ((|BasicOperator|) (|BasicOperator|)))
                                T)
                              '((|abs| (|#2| |#2|)) T)
                              '((|conjugate| (|#2| |#2|)) T)
                              '((|Gamma| (|#2| |#2|)) T)
                              '((|Gamma| (|#2| |#2| |#2|)) T)
                              '((|Beta| (|#2| |#2| |#2|)) T)
                              '((|digamma| (|#2| |#2|)) T)
                              '((|polygamma| (|#2| |#2| |#2|)) T)
                              '((|besselJ| (|#2| |#2| |#2|)) T)
                              '((|besselY| (|#2| |#2| |#2|)) T)
                              '((|besselI| (|#2| |#2| |#2|)) T)
                              '((|besselK| (|#2| |#2| |#2|)) T)
                              '((|airyAi| (|#2| |#2|)) T)
                              '((|airyAiPrime| (|#2| |#2|)) T)
                              '((|airyBi| (|#2| |#2|)) T)
                              '((|airyBiPrime| (|#2| |#2|)) T)
                              '((|lambertW| (|#2| |#2|)) T)
                              '((|polylog| (|#2| |#2| |#2|)) T)
                              '((|weierstrassP| (|#2| |#2| |#2| |#2|)) T)
                              '((|weierstrassPPrime| (|#2| |#2| |#2| |#2|)) T)
                              '((|weierstrassSigma| (|#2| |#2| |#2| |#2|)) T)
                              '((|weierstrassZeta| (|#2| |#2| |#2| |#2|)) T)
                              '((|weierstrassPInverse| (|#2| |#2| |#2| |#2|))
                                T)
                              '((|whittakerM| (|#2| |#2| |#2| |#2|)) T)
                              '((|whittakerW| (|#2| |#2| |#2| |#2|)) T)
                              '((|angerJ| (|#2| |#2| |#2|)) T)
                              '((|weberE| (|#2| |#2| |#2|)) T)
                              '((|struveH| (|#2| |#2| |#2|)) T)
                              '((|struveL| (|#2| |#2| |#2|)) T)
                              '((|hankelH1| (|#2| |#2| |#2|)) T)
                              '((|hankelH2| (|#2| |#2| |#2|)) T)
                              '((|lommelS1| (|#2| |#2| |#2| |#2|)) T)
                              '((|lommelS2| (|#2| |#2| |#2| |#2|)) T)
                              '((|kummerM| (|#2| |#2| |#2| |#2|)) T)
                              '((|kummerU| (|#2| |#2| |#2| |#2|)) T)
                              '((|legendreP| (|#2| |#2| |#2| |#2|)) T)
                              '((|legendreQ| (|#2| |#2| |#2| |#2|)) T)
                              '((|kelvinBei| (|#2| |#2| |#2|)) T)
                              '((|kelvinBer| (|#2| |#2| |#2|)) T)
                              '((|kelvinKei| (|#2| |#2| |#2|)) T)
                              '((|kelvinKer| (|#2| |#2| |#2|)) T)
                              '((|ellipticK| (|#2| |#2|)) T)
                              '((|ellipticE| (|#2| |#2|)) T)
                              '((|ellipticE| (|#2| |#2| |#2|)) T)
                              '((|ellipticF| (|#2| |#2| |#2|)) T)
                              '((|ellipticPi| (|#2| |#2| |#2| |#2|)) T)
                              '((|jacobiSn| (|#2| |#2| |#2|)) T)
                              '((|jacobiCn| (|#2| |#2| |#2|)) T)
                              '((|jacobiDn| (|#2| |#2| |#2|)) T)
                              '((|jacobiZeta| (|#2| |#2| |#2|)) T)
                              '((|jacobiTheta| (|#2| |#2| |#2|)) T)
                              '((|lerchPhi| (|#2| |#2| |#2| |#2|)) T)
                              '((|riemannZeta| (|#2| |#2|)) T)
                              '((|charlierC| (|#2| |#2| |#2| |#2|)) T)
                              '((|hermiteH| (|#2| |#2| |#2|)) T)
                              '((|jacobiP| (|#2| |#2| |#2| |#2| |#2|)) T)
                              '((|laguerreL| (|#2| |#2| |#2| |#2|)) T)
                              '((|meixnerM| (|#2| |#2| |#2| |#2| |#2|)) T)
                              '((|hypergeometricF|
                                 (|#2| (|List| |#2|) (|List| |#2|) |#2|))
                                (|has| 7 (|RetractableTo| 75)))
                              '((|meijerG|
                                 (|#2| (|List| |#2|) (|List| |#2|)
                                  (|List| |#2|) (|List| |#2|) |#2|))
                                (|has| 7 (|RetractableTo| 75)))
                              '((|iiGamma| (|#2| |#2|)) T)
                              '((|iiabs| (|#2| |#2|)) T)
                              '((|iiconjugate| (|#2| |#2|)) T)
                              '((|iiBeta| (|#2| (|List| |#2|))) T)
                              '((|iidigamma| (|#2| |#2|)) T)
                              '((|iipolygamma| (|#2| (|List| |#2|))) T)
                              '((|iiBesselJ| (|#2| (|List| |#2|))) T)
                              '((|iiBesselY| (|#2| (|List| |#2|))) T)
                              '((|iiBesselI| (|#2| (|List| |#2|))) T)
                              '((|iiBesselK| (|#2| (|List| |#2|))) T)
                              '((|iiAiryAi| (|#2| |#2|)) T)
                              '((|iiAiryAiPrime| (|#2| |#2|)) T)
                              '((|iiAiryBi| (|#2| |#2|)) T)
                              '((|iiAiryBiPrime| (|#2| |#2|)) T)
                              '((|iAiryAi| (|#2| |#2|)) T)
                              '((|iAiryAiPrime| (|#2| |#2|)) T)
                              '((|iAiryBi| (|#2| |#2|)) T)
                              '((|iAiryBiPrime| (|#2| |#2|)) T)
                              '((|iiHypergeometricF| (|#2| (|List| |#2|))) T)
                              '((|iiPolylog| (|#2| |#2| |#2|)) T)
                              '((|iLambertW| (|#2| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 319
                                            '(1 11 9 10 12 2 7 0 9 0 45 3 7 0 9
                                              0 0 49 4 7 0 9 0 0 0 64 0 6 0 69
                                              0 7 0 70 2 7 71 0 0 72 0 6 0 73 0
                                              7 0 74 1 7 0 75 76 2 77 0 0 0 78
                                              2 7 0 9 79 80 3 0 7 77 77 7 81 5
                                              0 7 77 77 77 77 7 82 1 7 9 9 83 1
                                              7 85 0 86 2 7 0 91 0 92 2 77 7 0
                                              75 95 0 10 0 96 1 7 0 10 97 2 7 0
                                              0 10 98 2 7 0 9 79 99 2 7 0 0 0
                                              100 2 7 0 0 0 101 2 105 9 9 104
                                              106 2 7 0 0 91 107 2 7 0 0 0 108
                                              2 7 0 0 0 109 1 7 0 0 110 0 111 0
                                              112 1 7 0 0 113 2 105 9 9 114 115
                                              3 9 0 0 10 118 119 0 7 0 124 1 7
                                              0 0 125 2 7 0 0 75 128 1 7 0 0
                                              129 2 7 0 0 0 132 0 162 0 163 2
                                              105 9 9 164 165 1 10 170 0 171 1
                                              170 0 79 172 2 9 0 0 173 174 2 7
                                              71 0 9 180 1 7 181 0 182 1 183 77
                                              0 184 5 7 0 9 0 0 0 0 199 2 9 71
                                              0 10 203 2 9 71 0 10 205 2 7 0 9
                                              0 207 1 7 71 0 208 1 7 71 0 209 2
                                              7 71 0 0 210 1 0 7 7 211 1 0 7 7
                                              212 1 0 7 7 213 1 0 7 7 214 1 7 0
                                              0 215 1 0 7 7 216 1 7 0 0 217 1 7
                                              0 0 218 2 0 7 7 7 219 1 77 7 0
                                              220 1 7 221 0 222 1 224 223 0 225
                                              1 223 226 0 227 1 224 223 0 228 1
                                              6 0 0 229 1 7 0 6 230 1 0 7 7 231
                                              1 7 232 0 233 1 7 234 0 235 1 183
                                              236 0 237 0 236 0 238 2 236 71 0
                                              0 239 1 7 0 181 240 0 91 0 241 2
                                              7 0 243 181 244 2 247 77 245 246
                                              248 3 7 0 0 234 79 249 1 6 0 0
                                              250 1 7 251 0 252 2 111 0 253 0
                                              254 1 7 0 251 255 1 7 251 0 256 1
                                              7 226 0 257 1 6 0 0 258 1 0 7 7
                                              259 2 6 0 0 0 260 1 0 7 77 261 1
                                              6 0 0 262 1 0 7 7 263 2 6 0 0 0
                                              264 1 0 7 77 265 2 6 0 0 0 266 1
                                              0 7 77 267 2 6 0 0 0 268 1 0 7 77
                                              269 2 6 0 0 0 270 1 0 7 77 271 2
                                              6 0 0 0 272 1 0 7 77 273 1 6 0 0
                                              274 1 0 7 7 275 1 6 0 0 276 1 0 7
                                              7 277 1 6 0 0 278 1 0 7 7 279 1 6
                                              0 0 280 1 0 7 7 281 1 7 282 0 283
                                              1 75 0 0 284 1 77 7 0 285 2 105 9
                                              9 164 286 1 0 7 77 287 1 7 288 0
                                              289 2 288 71 10 0 290 2 292 291 0
                                              75 293 1 291 0 0 294 2 9 0 0 295
                                              296 1 7 75 0 297 2 300 298 299 77
                                              301 2 77 0 0 236 302 2 77 0 0 236
                                              303 2 236 71 0 0 304 2 298 75 0
                                              75 305 2 306 0 0 236 307 1 308 75
                                              0 309 2 292 0 0 236 310 2 292 0 0
                                              236 311 1 291 0 79 312 2 291 0 0
                                              79 313 1 10 291 0 314 2 316 292
                                              295 315 317 2 292 0 0 0 318 1 7 0
                                              0 319 3 0 7 7 7 7 121 3 0 7 7 7 7
                                              117 3 0 7 7 7 7 68 3 0 7 7 7 7 67
                                              3 0 7 7 7 7 66 3 0 7 7 7 7 103 3
                                              0 7 7 7 7 65 2 0 7 7 7 127 2 0 7
                                              7 7 134 2 0 7 7 7 131 1 0 7 7 196
                                              2 0 7 7 7 63 2 0 7 7 7 53 1 0 9 9
                                              206 4 0 7 7 7 7 7 202 5 1 7 77 77
                                              77 77 7 82 3 0 7 7 7 7 142 3 0 7
                                              7 7 7 140 3 0 7 7 7 7 194 3 0 7 7
                                              7 7 150 3 0 7 7 7 7 148 1 0 7 7
                                              62 3 0 7 7 7 7 201 3 0 7 7 7 7
                                              146 3 0 7 7 7 7 144 2 0 7 7 7 157
                                              2 0 7 7 7 156 2 0 7 7 7 153 2 0 7
                                              7 7 152 2 0 7 7 7 190 2 0 7 7 7
                                              192 2 0 7 7 7 179 4 0 7 7 7 7 7
                                              200 2 0 7 7 7 186 2 0 7 7 7 185 1
                                              0 7 77 265 1 0 7 7 263 1 0 7 7
                                              242 1 0 7 7 231 2 0 7 7 7 219 1 0
                                              7 77 287 1 0 7 7 259 1 0 7 77 261
                                              1 0 7 77 269 1 0 7 77 273 1 0 7
                                              77 267 1 0 7 77 271 1 0 7 7 281 1
                                              0 7 7 279 1 0 7 7 277 1 0 7 7 275
                                              1 0 7 7 216 1 0 7 7 214 1 0 7 7
                                              213 1 0 7 7 212 1 0 7 7 211 3 1 7
                                              77 77 7 81 2 0 7 7 7 198 2 0 7 7
                                              7 138 2 0 7 7 7 136 3 0 7 7 7 7
                                              177 1 0 7 7 160 2 0 7 7 7 169 1 0
                                              7 7 161 2 0 7 7 7 168 1 0 7 7 52
                                              1 0 7 7 47 3 0 7 7 7 7 197 2 0 7
                                              7 7 55 2 0 7 7 7 57 2 0 7 7 7 54
                                              2 0 7 7 7 56 1 0 71 9 204 2 0 7 7
                                              7 123 1 0 7 7 61 1 0 7 7 60 1 0 7
                                              7 59 1 0 7 7 58 1 0 7 7 46 1 0 7
                                              7 48 2 0 7 7 7 50 2 0 7 7 7
                                              51)))))
           '|lookupComplete|)) 

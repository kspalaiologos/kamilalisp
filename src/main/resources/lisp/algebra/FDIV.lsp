
(SDEFUN |FDIV;Zero;$;1| (($ ($))) (|spadConstant| $ 13)) 

(SDEFUN |FDIV;coerce;$Of;2| ((|d| ($)) ($ (|OutputForm|)))
        (SPADCALL |d| (QREFELT $ 16))) 

(SDEFUN |FDIV;=;2$B;3| ((|d1| ($)) (|d2| ($)) ($ (|Boolean|)))
        (SPADCALL |d1| |d2| (QREFELT $ 19))) 

(SDEFUN |FDIV;*;I2$;4| ((|n| (|Integer|)) (|d| ($)) ($ ($)))
        (SPADCALL |n| |d| (QREFELT $ 22))) 

(SDEFUN |FDIV;+;3$;5| ((|d1| ($)) (|d2| ($)) ($ ($)))
        (SPADCALL |d1| |d2| (QREFELT $ 24))) 

(SDEFUN |FDIV;-;2$;6| ((|d| ($)) ($ ($))) (SPADCALL |d| (QREFELT $ 26))) 

(SDEFUN |FDIV;ideal;$Fi;7|
        ((|d| ($)) ($ (|FractionalIdeal| UP (|Fraction| UP) UPUP R)))
        (SPADCALL |d| (QREFELT $ 29))) 

(SDEFUN |FDIV;reduce;2$;8| ((|d| ($)) ($ ($))) (SPADCALL |d| (QREFELT $ 31))) 

(SDEFUN |FDIV;generator;$U;9| ((|d| ($)) ($ (|Union| R "failed")))
        (SPADCALL |d| (QREFELT $ 34))) 

(SDEFUN |FDIV;generator;$ILU;10|
        ((|d| ($)) (|k| (|Integer|)) (|lp| (|List| UP))
         ($ (|Union| R "failed")))
        (SPADCALL |d| |k| |lp| (QREFELT $ 37))) 

(SDEFUN |FDIV;decompose;$R;11|
        ((|d| ($))
         ($
          (|Record| (|:| |id| (|FractionalIdeal| UP (|Fraction| UP) UPUP R))
                    (|:| |principalPart| R))))
        (SPADCALL |d| (QREFELT $ 40))) 

(SDEFUN |FDIV;divisor;Fi$;12|
        ((|i| (|FractionalIdeal| UP (|Fraction| UP) UPUP R)) ($ ($)))
        (SPADCALL |i| (QREFELT $ 42))) 

(SDEFUN |FDIV;divisor;R$;13| ((|f| (R)) ($ ($))) (SPADCALL |f| (QREFELT $ 44))) 

(SDEFUN |FDIV;divisor;2F$;14| ((|a| (F)) (|b| (F)) ($ ($)))
        (SPADCALL |a| |b| (QREFELT $ 46))) 

(SDEFUN |FDIV;divisor;2FI$;15| ((|a| (F)) (|b| (F)) (|n| (|Integer|)) ($ ($)))
        (SPADCALL |a| |b| |n| (QREFELT $ 48))) 

(SDEFUN |FDIV;divisor;R2UP$;16| ((|h| (R)) (|d| (UP)) (|g| (UP)) ($ ($)))
        (SPADCALL |h| |d| |g| (QREFELT $ 50))) 

(SDEFUN |FDIV;Zero;$;17| (($ ($))) (CONS (|spadConstant| $ 57) (MAKE-ARRAY 0))) 

(SDEFUN |FDIV;divisor;Fi$;18|
        ((|i| (|FractionalIdeal| UP (|Fraction| UP) UPUP R)) ($ ($)))
        (CONS |i| (MAKE-ARRAY 0))) 

(SDEFUN |FDIV;divisor;R$;19| ((|f| (R)) ($ ($)))
        (SPADCALL (SPADCALL (VECTOR |f|) (QREFELT $ 59)) (QREFELT $ 43))) 

(SDEFUN |FDIV;coerce;$Of;20| ((|d| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |d| (QREFELT $ 30)) (QREFELT $ 60))) 

(PUT '|FDIV;ideal;$Fi;21| '|SPADreplace| 'QCAR) 

(SDEFUN |FDIV;ideal;$Fi;21|
        ((|d| ($)) ($ (|FractionalIdeal| UP (|Fraction| UP) UPUP R)))
        (QCAR |d|)) 

(SDEFUN |FDIV;decompose;$R;22|
        ((|d| ($))
         ($
          (|Record| (|:| |id| (|FractionalIdeal| UP (|Fraction| UP) UPUP R))
                    (|:| |principalPart| R))))
        (CONS (SPADCALL |d| (QREFELT $ 30)) (|spadConstant| $ 61))) 

(SDEFUN |FDIV;=;2$B;23| ((|d1| ($)) (|d2| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL (SPADCALL |d1| (QREFELT $ 30)) (QREFELT $ 63))
                  (SPADCALL (SPADCALL |d2| (QREFELT $ 30)) (QREFELT $ 63))
                  (QREFELT $ 64))) 

(SDEFUN |FDIV;*;I2$;24| ((|n| (|Integer|)) (|d| ($)) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |d| (QREFELT $ 30)) |n| (QREFELT $ 65))
                  (QREFELT $ 43))) 

(SDEFUN |FDIV;+;3$;25| ((|d1| ($)) (|d2| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |d1| (QREFELT $ 30))
                   (SPADCALL |d2| (QREFELT $ 30)) (QREFELT $ 66))
         (QREFELT $ 43))) 

(SDEFUN |FDIV;-;2$;26| ((|d| ($)) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |d| (QREFELT $ 30)) (QREFELT $ 67))
                  (QREFELT $ 43))) 

(SDEFUN |FDIV;divisor;R2UP$;27| ((|h| (R)) (|d| (UP)) (|g| (UP)) ($ ($)))
        (|FDIV;makeDivisor| |d| (SPADCALL |h| (QREFELT $ 68)) |g| $)) 

(SDEFUN |FDIV;intReduce| ((|h| (R)) (|b| (UP)) ($ (R)))
        (SPROG
         ((#1=#:G758 NIL) (#2=#:G760 NIL) (|i| NIL) (#3=#:G759 NIL)
          (|v| (|Vector| UP)))
         (SEQ (LETT |v| (QCAR (SPADCALL |h| (QREFELT $ 70))))
              (EXIT
               (SPADCALL
                (PROGN
                 (LETT #3#
                       (GETREFV
                        (|inc_SI|
                         (- #4=(QVSIZE |v|)
                            #5=(SPADCALL |v| (QREFELT $ 72))))))
                 (SEQ (LETT |i| #5#) (LETT #2# #4#) (LETT #1# 0) G190
                      (COND ((> |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #3# #1#
                                (SPADCALL (QAREF1O |v| |i| 1) |b|
                                          (QREFELT $ 73)))))
                      (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |i| (+ |i| 1))))
                      (GO G190) G191 (EXIT NIL))
                 #3#)
                (|spadConstant| $ 56) (QREFELT $ 74)))))) 

(SDEFUN |FDIV;divisor;2F$;29| ((|a| (F)) (|b| (F)) ($ ($)))
        (SPROG ((|d| (UP)) (|x| (UP)))
               (SEQ
                (LETT |x| (SPADCALL (|spadConstant| $ 55) 1 (QREFELT $ 76)))
                (COND
                 ((NULL
                   (SPADCALL
                    (SPADCALL
                     (LETT |d|
                           (SPADCALL |x| (SPADCALL |a| (QREFELT $ 77))
                                     (QREFELT $ 78)))
                     (SPADCALL (SPADCALL (QREFELT $ 80)) (QREFELT $ 81))
                     (QREFELT $ 82))
                    (QREFELT $ 83)))
                  (EXIT (|error| "divisor: point is singular"))))
                (EXIT
                 (|FDIV;makeDivisor| |d|
                  (SPADCALL (SPADCALL (|spadConstant| $ 84) 1 (QREFELT $ 85))
                            (SPADCALL
                             (SPADCALL (SPADCALL |b| (QREFELT $ 77))
                                       (QREFELT $ 86))
                             (QREFELT $ 87))
                            (QREFELT $ 88))
                  (|spadConstant| $ 56) $))))) 

(SDEFUN |FDIV;divisor;2FI$;30| ((|a| (F)) (|b| (F)) (|n| (|Integer|)) ($ ($)))
        (SPROG
         ((|g| ($)) (|m| (|NonNegativeInteger|)) (#1=#:G770 NIL)
          (#2=#:G769 NIL) (|d| (UP)))
         (SEQ
          (COND
           ((NULL
             (SPADCALL
              (SPADCALL
               (LETT |d|
                     (SPADCALL
                      (SPADCALL (|spadConstant| $ 55) 1 (QREFELT $ 76))
                      (SPADCALL |a| (QREFELT $ 77)) (QREFELT $ 78)))
               (SPADCALL (SPADCALL (QREFELT $ 80)) (QREFELT $ 81))
               (QREFELT $ 82))
              (QREFELT $ 83)))
            (COND
             ((QEQCAR (SPADCALL |n| (SPADCALL (QREFELT $ 90)) (QREFELT $ 92))
                      1)
              (EXIT (|error| "divisor: point is singular"))))))
          (LETT |m|
                (COND
                 ((< |n| 0)
                  (PROG1 (LETT #2# (- |n|))
                    (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #2#)))
                 (#3='T
                  (PROG1 (LETT #1# |n|)
                    (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #1#)))))
          (LETT |g|
                (|FDIV;makeDivisor| (SPADCALL |d| |m| (QREFELT $ 94))
                 (SPADCALL
                  (SPADCALL (SPADCALL (|spadConstant| $ 84) 1 (QREFELT $ 85))
                            (SPADCALL
                             (SPADCALL (SPADCALL |b| (QREFELT $ 77))
                                       (QREFELT $ 86))
                             (QREFELT $ 87))
                            (QREFELT $ 88))
                  |m| (QREFELT $ 95))
                 (|spadConstant| $ 56) $))
          (EXIT (COND ((< |n| 0) (SPADCALL |g| (QREFELT $ 27))) (#3# |g|)))))) 

(SDEFUN |FDIV;reduce;2$;31| ((|d| ($)) ($ ($)))
        (SPROG
         ((|e| (UP)) (|b| (UP))
          (|cd| (|Record| (|:| |num| UPUP) (|:| |den| UP))) (|n| (|Vector| R))
          (|i| (|FractionalIdeal| UP (|Fraction| UP) UPUP R))
          (|j| (|FractionalIdeal| UP (|Fraction| UP) UPUP R)))
         (SEQ
          (LETT |i|
                (SPADCALL (LETT |j| (SPADCALL |d| (QREFELT $ 30)))
                          (QREFELT $ 96)))
          (EXIT
           (COND ((SPADCALL |i| |j| (QREFELT $ 97)) |d|)
                 ((SPADCALL (QVSIZE (LETT |n| (SPADCALL |i| (QREFELT $ 98)))) 2
                            (QREFELT $ 99))
                  (SPADCALL |i| (QREFELT $ 43)))
                 ('T
                  (SEQ
                   (LETT |cd|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL |n| (+ 1 (SPADCALL |n| (QREFELT $ 100)))
                                     (QREFELT $ 101))
                           (QREFELT $ 68))
                          (QREFELT $ 104)))
                   (LETT |b|
                         (SPADCALL
                          (SPADCALL (QCDR |cd|)
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL |n|
                                                (SPADCALL |n| (QREFELT $ 100))
                                                (QREFELT $ 101))
                                      (QREFELT $ 105))
                                     (QREFELT $ 81))
                                    (QREFELT $ 106))
                          (SPADCALL
                           (SPADCALL (SPADCALL (QCAR |cd|) (QREFELT $ 107))
                                     (QREFELT $ 108))
                           (QREFELT $ 81))
                          (QREFELT $ 82)))
                   (LETT |e|
                         (SPADCALL (QCDR |cd|) (SPADCALL |i| (QREFELT $ 109))
                                   (QREFELT $ 106)))
                   (EXIT
                    (SPADCALL
                     (SPADCALL
                      (VECTOR
                       (SPADCALL (SPADCALL |b| |e| (QREFELT $ 110))
                                 (QREFELT $ 111))
                       (SPADCALL
                        (SPADCALL
                         (CONS #'|FDIV;reduce;2$;31!0| (VECTOR |e| |b| $))
                         (QCAR |cd|) (QREFELT $ 113))
                        (QREFELT $ 107)))
                      (QREFELT $ 59))
                     (QREFELT $ 43)))))))))) 

(SDEFUN |FDIV;reduce;2$;31!0| ((|s| NIL) ($$ NIL))
        (PROG ($ |b| |e|)
          (LETT $ (QREFELT $$ 2))
          (LETT |b| (QREFELT $$ 1))
          (LETT |e| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |s| (QREFELT $ 81)) |b| (QREFELT $ 73)) |e|
             (QREFELT $ 110)))))) 

(SDEFUN |FDIV;finiteBasis;$V;32| ((|d| ($)) ($ (|Vector| R)))
        (SEQ
         (COND
          ((SPADCALL (QCDR |d|) (QREFELT $ 114))
           (PROGN
            (RPLACD |d|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |d| (QREFELT $ 30)) (QREFELT $ 116))
                      (QREFELT $ 117))
                     (QREFELT $ 118)))
            (QCDR |d|))))
         (EXIT (QCDR |d|)))) 

(SDEFUN |FDIV;generator;$U;33| ((|d| ($)) ($ (|Union| R "failed")))
        (SPROG
         ((#1=#:G799 NIL) (#2=#:G800 NIL) (#3=#:G801 NIL) (|i| NIL)
          (|bsis| (|Vector| R)))
         (SEQ
          (EXIT
           (SEQ (LETT |bsis| (SPADCALL |d| (QREFELT $ 119)))
                (SEQ
                 (EXIT
                  (SEQ (LETT |i| (SPADCALL |bsis| (QREFELT $ 100)))
                       (LETT #3# (QVSIZE |bsis|)) G190
                       (COND ((> |i| #3#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (QAREF1O |bsis| |i| 1) (QREFELT $ 120))
                           (PROGN
                            (LETT #1#
                                  (PROGN
                                   (LETT #2#
                                         (CONS 0
                                               (SPADCALL (QAREF1O |bsis| |i| 1)
                                                         (QREFELT $ 121))))
                                   (GO #4=#:G798)))
                            (GO #5=#:G796))))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                 #5# (EXIT #1#))
                (EXIT (CONS 1 "failed"))))
          #4# (EXIT #2#)))) 

(SDEFUN |FDIV;generator;$ILU;34|
        ((|d| ($)) (|k| (|Integer|)) (|lp| (|List| UP))
         ($ (|Union| R "failed")))
        (SPROG
         ((#1=#:G810 NIL) (#2=#:G811 NIL) (|kk| (|Integer|)) (|fi| (R))
          (#3=#:G812 NIL) (|i| NIL) (|bas| (|Vector| R)))
         (SEQ
          (EXIT
           (SEQ (LETT |bas| (SPADCALL |d| (QREFELT $ 119)))
                (SEQ
                 (EXIT
                  (SEQ (LETT |i| (SPADCALL |bas| (QREFELT $ 100)))
                       (LETT #3# (QVSIZE |bas|)) G190
                       (COND ((> |i| #3#) (GO G191)))
                       (SEQ
                        (LETT |kk|
                              (SPADCALL (LETT |fi| (QAREF1O |bas| |i| 1)) |lp|
                                        (QREFELT $ 122)))
                        (EXIT
                         (COND
                          ((EQL |kk| |k|)
                           (PROGN
                            (LETT #1#
                                  (PROGN
                                   (LETT #2#
                                         (CONS 0
                                               (SPADCALL |fi|
                                                         (QREFELT $ 121))))
                                   (GO #4=#:G809)))
                            (GO #5=#:G807))))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                 #5# (EXIT #1#))
                (EXIT (CONS 1 "failed"))))
          #4# (EXIT #2#)))) 

(SDEFUN |FDIV;lSpaceBasis;$V;35| ((|d| ($)) ($ (|Vector| R)))
        (SPADCALL (ELT $ 121)
                  (SPADCALL
                   (SPADCALL (SPADCALL |d| (QREFELT $ 27)) (QREFELT $ 119))
                   (QREFELT $ 123))
                  (QREFELT $ 125))) 

(SDEFUN |FDIV;makeDivisor| ((|b| (UP)) (|hh| (UPUP)) (|g| (UP)) ($ ($)))
        (SPROG ((|h| (R)))
               (SEQ
                (LETT |b|
                      (SPADCALL |b|
                                (SPADCALL
                                 (SPADCALL
                                  (LETT |h| (SPADCALL |hh| (QREFELT $ 107)))
                                  (QREFELT $ 108))
                                 (QREFELT $ 81))
                                (QREFELT $ 82)))
                (LETT |h| (|FDIV;intReduce| |h| |b| $))
                (COND
                 ((NULL
                   (SPADCALL (SPADCALL |g| |b| (QREFELT $ 82)) (QREFELT $ 83)))
                  (LETT |h|
                        (|FDIV;intReduce|
                         (SPADCALL |h| (SPADCALL (QREFELT $ 90))
                                   (QREFELT $ 127))
                         |b| $))))
                (EXIT
                 (SPADCALL
                  (SPADCALL
                   (VECTOR
                    (SPADCALL (SPADCALL |b| (QREFELT $ 86)) (QREFELT $ 111))
                    |h|)
                   (QREFELT $ 59))
                  (QREFELT $ 43)))))) 

(DECLAIM (NOTINLINE |FiniteDivisor;|)) 

(DEFUN |FiniteDivisor| (&REST #1=#:G819)
  (SPROG NIL
         (PROG (#2=#:G820)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FiniteDivisor|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FiniteDivisor;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|FiniteDivisor|)))))))))) 

(DEFUN |FiniteDivisor;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|FiniteDivisor| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 131))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FiniteDivisor| (LIST DV$1 DV$2 DV$3 DV$4)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((QEQCAR (SPADCALL (QREFELT $ 11)) 0)
      (PROGN
       (QSETREFV $ 12 (|HyperellipticFiniteDivisor| |#1| |#2| |#3| |#4|))
       (QSETREFV $ 14
                 (CONS #'|makeSpadConstant|
                       (LIST (|dispatchFunction| |FDIV;Zero;$;1|) $ 14)))
       (QSETREFV $ 17 (CONS (|dispatchFunction| |FDIV;coerce;$Of;2|) $))
       (QSETREFV $ 20 (CONS (|dispatchFunction| |FDIV;=;2$B;3|) $))
       (QSETREFV $ 23 (CONS (|dispatchFunction| |FDIV;*;I2$;4|) $))
       (QSETREFV $ 25 (CONS (|dispatchFunction| |FDIV;+;3$;5|) $))
       (QSETREFV $ 27 (CONS (|dispatchFunction| |FDIV;-;2$;6|) $))
       (QSETREFV $ 30 (CONS (|dispatchFunction| |FDIV;ideal;$Fi;7|) $))
       (QSETREFV $ 32 (CONS (|dispatchFunction| |FDIV;reduce;2$;8|) $))
       (QSETREFV $ 35 (CONS (|dispatchFunction| |FDIV;generator;$U;9|) $))
       (QSETREFV $ 38 (CONS (|dispatchFunction| |FDIV;generator;$ILU;10|) $))
       (QSETREFV $ 41 (CONS (|dispatchFunction| |FDIV;decompose;$R;11|) $))
       (QSETREFV $ 43 (CONS (|dispatchFunction| |FDIV;divisor;Fi$;12|) $))
       (QSETREFV $ 45 (CONS (|dispatchFunction| |FDIV;divisor;R$;13|) $))
       (QSETREFV $ 47 (CONS (|dispatchFunction| |FDIV;divisor;2F$;14|) $))
       (QSETREFV $ 49 (CONS (|dispatchFunction| |FDIV;divisor;2FI$;15|) $))
       (QSETREFV $ 51 (CONS (|dispatchFunction| |FDIV;divisor;R2UP$;16|) $))))
     ('T
      (PROGN
       (SETELT $ 12
               (|Record|
                (|:| |id| (|FractionalIdeal| |#2| (|Fraction| |#2|) |#3| |#4|))
                (|:| |fbasis| (|Vector| |#4|))))
       NIL
       NIL
       (QSETREFV $ 54 (SPADCALL (QREFELT $ 53)))
       (QSETREFV $ 14
                 (CONS #'|makeSpadConstant|
                       (LIST (|dispatchFunction| |FDIV;Zero;$;17|) $ 14)))
       (QSETREFV $ 43 (CONS (|dispatchFunction| |FDIV;divisor;Fi$;18|) $))
       (QSETREFV $ 45 (CONS (|dispatchFunction| |FDIV;divisor;R$;19|) $))
       (QSETREFV $ 17 (CONS (|dispatchFunction| |FDIV;coerce;$Of;20|) $))
       (QSETREFV $ 30 (CONS (|dispatchFunction| |FDIV;ideal;$Fi;21|) $))
       (QSETREFV $ 41 (CONS (|dispatchFunction| |FDIV;decompose;$R;22|) $))
       (QSETREFV $ 20 (CONS (|dispatchFunction| |FDIV;=;2$B;23|) $))
       (QSETREFV $ 23 (CONS (|dispatchFunction| |FDIV;*;I2$;24|) $))
       (QSETREFV $ 25 (CONS (|dispatchFunction| |FDIV;+;3$;25|) $))
       (QSETREFV $ 27 (CONS (|dispatchFunction| |FDIV;-;2$;26|) $))
       (QSETREFV $ 51 (CONS (|dispatchFunction| |FDIV;divisor;R2UP$;27|) $))
       (QSETREFV $ 47 (CONS (|dispatchFunction| |FDIV;divisor;2F$;29|) $))
       (QSETREFV $ 49 (CONS (|dispatchFunction| |FDIV;divisor;2FI$;30|) $))
       (QSETREFV $ 32 (CONS (|dispatchFunction| |FDIV;reduce;2$;31|) $))
       (QSETREFV $ 119 (CONS (|dispatchFunction| |FDIV;finiteBasis;$V;32|) $))
       (QSETREFV $ 35 (CONS (|dispatchFunction| |FDIV;generator;$U;33|) $))
       (QSETREFV $ 38 (CONS (|dispatchFunction| |FDIV;generator;$ILU;34|) $))
       (QSETREFV $ 126
                 (CONS (|dispatchFunction| |FDIV;lSpaceBasis;$V;35|) $)))))
    $))) 

(MAKEPROP '|FiniteDivisor| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Union| 7 '"failed")
              (0 . |hyperelliptic|) '|Rep| (4 . |Zero|) (8 . |Zero|)
              (|OutputForm|) (12 . |coerce|) (17 . |coerce|) (|Boolean|)
              (22 . =) (28 . =) (|Integer|) (34 . *) (40 . *) (46 . +) (52 . +)
              (58 . -) (63 . -) (|FractionalIdeal| 7 79 8 9) (68 . |ideal|)
              (73 . |ideal|) (78 . |reduce|) (83 . |reduce|)
              (|Union| 9 '"failed") (88 . |generator|) (93 . |generator|)
              (|List| 7) (98 . |generator|) (105 . |generator|)
              (|Record| (|:| |id| 28) (|:| |principalPart| 9))
              (112 . |decompose|) (117 . |decompose|) (122 . |divisor|)
              (127 . |divisor|) (132 . |divisor|) (137 . |divisor|)
              (142 . |divisor|) (148 . |divisor|) (154 . |divisor|)
              (161 . |divisor|) (168 . |divisor|) (175 . |divisor|)
              (|Vector| $) (182 . |integralBasis|) '|ww| (186 . |One|)
              (190 . |One|) (194 . |One|) (|Vector| 9) (198 . |ideal|)
              (203 . |coerce|) (208 . |One|) (212 . |basis|) (216 . |basis|)
              (221 . =) (227 . ^) (233 . *) (239 . |inv|) (244 . |lift|)
              (|Record| (|:| |num| 71) (|:| |den| 7))
              (249 . |integralCoordinates|) (|Vector| 7) (254 . |minIndex|)
              (259 . |rem|) (265 . |integralRepresents|) (|NonNegativeInteger|)
              (271 . |monomial|) (277 . |coerce|) (282 . -) (|Fraction| 7)
              (288 . |discriminant|) (292 . |retract|) (297 . |gcd|)
              (303 . |ground?|) (308 . |One|) (312 . |monomial|)
              (318 . |coerce|) (323 . |coerce|) (328 . -) (|PositiveInteger|)
              (334 . |rank|) (|Union| $ '"failed") (338 . |exquo|)
              (344 . |Zero|) (348 . ^) (354 . ^) (360 . |minimize|) (365 . =)
              (371 . |numer|) (376 . ~=) (382 . |minIndex|) (387 . |elt|)
              (|Record| (|:| |num| 8) (|:| |den| 7))
              (|UnivariatePolynomialCommonDenominator| 7 79 8)
              (393 . |splitDenominator|) (398 . |retract|) (403 . *)
              (409 . |reduce|) (414 . |norm|) (419 . |denom|) (424 . /)
              (430 . |coerce|) (|Mapping| 79 79) (435 . |map|) (441 . |empty?|)
              (|FractionalIdealAsModule| 7 79 8 9 (NRTEVAL (QREFELT $ 54)))
              (446 . |module|) (451 . |basis|) (456 . |normalizeAtInfinity|)
              (461 . |finiteBasis|) (466 . |integralAtInfinity?|)
              (471 . |primitivePart|) (476 . |special_order|)
              (482 . |reduceBasisAtInfinity|) (|Mapping| 9 9) (487 . |map!|)
              (493 . |lSpaceBasis|) (498 . ^) (|HashState|) (|String|)
              (|SingleInteger|))
           '#(~= 504 |zero?| 510 |subtractIfCan| 515 |sample| 521 |reduce| 525
              |principal?| 530 |opposite?| 535 |latex| 541 |lSpaceBasis| 546
              |ideal| 551 |hashUpdate!| 556 |hash| 562 |generator| 567
              |finiteBasis| 579 |divisor| 584 |decompose| 623 |coerce| 628
              |Zero| 633 = 637 - 643 + 654 * 660)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|FiniteDivisorCategory&| |AbelianGroup&| NIL
                     |AbelianMonoid&| |AbelianSemiGroup&| |SetCategory&|
                     |BasicType&| NIL)
                  (CONS
                   '#((|FiniteDivisorCategory| 6 7 8 9) (|AbelianGroup|)
                      (|CancellationAbelianMonoid|) (|AbelianMonoid|)
                      (|AbelianSemiGroup|) (|SetCategory|) (|BasicType|)
                      (|CoercibleTo| 15))
                   (|makeByteWordVec2| 130
                                       '(0 9 10 11 0 12 0 13 0 0 0 14 1 12 15 0
                                         16 1 0 15 0 17 2 12 18 0 0 19 2 0 18 0
                                         0 20 2 12 0 21 0 22 2 0 0 21 0 23 2 12
                                         0 0 0 24 2 0 0 0 0 25 1 12 0 0 26 1 0
                                         0 0 27 1 12 28 0 29 1 0 28 0 30 1 12 0
                                         0 31 1 0 0 0 32 1 12 33 0 34 1 0 33 0
                                         35 3 12 33 0 21 36 37 3 0 33 0 21 36
                                         38 1 12 39 0 40 1 0 39 0 41 1 12 0 28
                                         42 1 0 0 28 43 1 12 0 9 44 1 0 0 9 45
                                         2 12 0 6 6 46 2 0 0 6 6 47 3 12 0 6 6
                                         21 48 3 0 0 6 6 21 49 3 12 0 9 7 7 50
                                         3 0 0 9 7 7 51 0 9 52 53 0 6 0 55 0 7
                                         0 56 0 28 0 57 1 28 0 58 59 1 28 15 0
                                         60 0 9 0 61 0 9 52 62 1 28 58 0 63 2
                                         58 18 0 0 64 2 28 0 0 21 65 2 28 0 0 0
                                         66 1 28 0 0 67 1 9 8 0 68 1 9 69 0 70
                                         1 71 21 0 72 2 7 0 0 0 73 2 9 0 71 7
                                         74 2 7 0 6 75 76 1 7 0 6 77 2 7 0 0 0
                                         78 0 9 79 80 1 79 7 0 81 2 7 0 0 0 82
                                         1 7 18 0 83 0 79 0 84 2 8 0 79 75 85 1
                                         79 0 7 86 1 8 0 79 87 2 8 0 0 0 88 0 9
                                         89 90 2 21 91 0 0 92 0 6 0 93 2 7 0 0
                                         75 94 2 8 0 0 75 95 1 28 0 0 96 2 28
                                         18 0 0 97 1 28 58 0 98 2 75 18 0 0 99
                                         1 58 21 0 100 2 58 9 0 21 101 1 103
                                         102 8 104 1 9 79 0 105 2 7 0 0 0 106 1
                                         9 0 8 107 1 9 79 0 108 1 28 7 0 109 2
                                         79 0 7 7 110 1 9 0 79 111 2 8 0 112 0
                                         113 1 58 18 0 114 1 115 0 28 116 1 115
                                         58 0 117 1 9 52 52 118 1 0 58 0 119 1
                                         9 18 0 120 1 9 0 0 121 2 9 21 0 36 122
                                         1 9 52 52 123 2 58 0 124 0 125 1 0 58
                                         0 126 2 9 0 0 89 127 2 0 18 0 0 1 1 0
                                         18 0 1 2 0 91 0 0 1 0 0 0 1 1 0 0 0 32
                                         1 0 18 0 1 2 0 18 0 0 1 1 0 129 0 1 1
                                         0 58 0 126 1 0 28 0 30 2 0 128 128 0 1
                                         1 0 130 0 1 3 0 33 0 21 36 38 1 0 33 0
                                         35 1 0 58 0 119 5 0 0 9 7 7 7 6 1 3 0
                                         0 9 7 7 51 2 0 0 6 6 47 3 0 0 6 6 21
                                         49 1 0 0 28 43 1 0 0 9 45 1 0 39 0 41
                                         1 0 15 0 17 0 0 0 14 2 0 18 0 0 20 1 0
                                         0 0 27 2 0 0 0 0 1 2 0 0 0 0 25 2 0 0
                                         21 0 23 2 0 0 75 0 1 2 0 0 89 0 1)))))
           '|lookupComplete|)) 

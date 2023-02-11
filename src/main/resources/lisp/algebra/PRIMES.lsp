
(SDEFUN |PRIMES;primes;2IL;1| ((|m| (I)) (|n| (I)) ($ (|List| I)))
        (SPROG
         ((|ll| (|List| I)) (#1=#:G738 NIL) (|k| NIL) (#2=#:G737 NIL)
          (|m0| (I)))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 33) (QREFELT $ 35))
            (LETT |m| (|spadConstant| $ 11))))
          (LETT |m0| |m|)
          (COND
           ((OR (SPADCALL |n| (QREFELT $ 17) (QREFELT $ 35))
                (SPADCALL |n| |m| (QREFELT $ 35)))
            (EXIT NIL)))
          (COND
           ((SPADCALL |m| (QREFELT $ 36))
            (LETT |m| (SPADCALL |m| (|spadConstant| $ 11) (QREFELT $ 37)))))
          (LETT |ll|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| (SPADCALL |m| (QREFELT $ 38)))
                      (LETT #1# (SPADCALL |n| (QREFELT $ 38))) G190
                      (COND ((> |k| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (SPADCALL |k| (QREFELT $ 8))
                                    (QREFELT $ 39))
                          (LETT #2#
                                (CONS (SPADCALL |k| (QREFELT $ 8)) #2#))))))
                      (LETT |k| (+ |k| 2)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (COND
            ((SPADCALL |m0| (QREFELT $ 17) (QREFELT $ 40))
             (CONS (QREFELT $ 17) |ll|))
            ('T |ll|)))))) 

(SDEFUN |PRIMES;rabinProvesCompositeSmall|
        ((|p| (I)) (|n| (I)) (|nm1| (I)) (|q| (I)) (|k| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G746 NIL) (#2=#:G745 NIL) (|t| (I)) (#3=#:G747 NIL) (|j| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |t| (SPADCALL |p| |q| |n| (QREFELT $ 43)))
                (COND
                 ((NULL (SPADCALL |t| (|spadConstant| $ 11) (QREFELT $ 44)))
                  (COND
                   ((NULL (SPADCALL |t| |nm1| (QREFELT $ 44)))
                    (SEQ
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #3# (- |k| 1)) G190
                            (COND ((|greater_SI| |j| #3#) (GO G191)))
                            (SEQ
                             (LETT |t| (SPADCALL |t| |t| |n| (QREFELT $ 45)))
                             (EXIT
                              (COND
                               ((SPADCALL |t| (|spadConstant| $ 11)
                                          (QREFELT $ 44))
                                (PROGN (LETT #1# 'T) (GO #4=#:G744)))
                               ((SPADCALL |t| |nm1| (QREFELT $ 44))
                                (PROGN
                                 (LETT #2# |$NoValue|)
                                 (GO #5=#:G741))))))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL)))
                      #5# (EXIT #2#))
                     (EXIT
                      (COND
                       ((NULL (SPADCALL |t| |nm1| (QREFELT $ 44)))
                        (PROGN (LETT #1# 'T) (GO #4#))))))))))
                (EXIT NIL)))
          #4# (EXIT #1#)))) 

(SDEFUN |PRIMES;rabinProvesComposite|
        ((|p| (I)) (|n| (I)) (|nm1| (I)) (|q| (I)) (|k| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G756 NIL) (#2=#:G755 NIL) (|t| (I)) (|oldt| (I))
          (#3=#:G757 NIL) (|j| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |t| (SPADCALL |p| |q| |n| (QREFELT $ 43)))
                (COND
                 ((SPADCALL |t| |nm1| (QREFELT $ 44))
                  (SPADCALL (QREFELT $ 32) 1
                            (+ (SPADCALL (QREFELT $ 32) 1 (QREFELT $ 46)) 1)
                            (QREFELT $ 47))))
                (COND
                 ((NULL (SPADCALL |t| (|spadConstant| $ 11) (QREFELT $ 44)))
                  (COND
                   ((NULL (SPADCALL |t| |nm1| (QREFELT $ 44)))
                    (SEQ
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| 1) (LETT #3# (- |k| 1)) G190
                            (COND ((|greater_SI| |j| #3#) (GO G191)))
                            (SEQ (LETT |oldt| |t|)
                                 (LETT |t|
                                       (SPADCALL |t| |t| |n| (QREFELT $ 45)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |t| (|spadConstant| $ 11)
                                              (QREFELT $ 44))
                                    (PROGN (LETT #1# 'T) (GO #4=#:G754)))
                                   ((SPADCALL |t| |nm1| (QREFELT $ 44))
                                    (SEQ
                                     (SETELT $ 28
                                             (SPADCALL (QREFELT $ 28) |oldt|
                                                       (QREFELT $ 48)))
                                     (SPADCALL (QREFELT $ 32) (+ |j| 1)
                                               (+
                                                (SPADCALL (QREFELT $ 32)
                                                          (+ |j| 1)
                                                          (QREFELT $ 46))
                                                1)
                                               (QREFELT $ 47))
                                     (EXIT
                                      (PROGN
                                       (LETT #2# |$NoValue|)
                                       (GO #5=#:G751))))))))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL)))
                      #5# (EXIT #2#))
                     (EXIT
                      (COND
                       ((NULL (SPADCALL |t| |nm1| (QREFELT $ 44)))
                        (PROGN (LETT #1# 'T) (GO #4#))))))))))
                (EXIT
                 (COND ((> (SPADCALL (QREFELT $ 28) (QREFELT $ 49)) 2) 'T)
                       ('T NIL)))))
          #4# (EXIT #1#)))) 

(SDEFUN |PRIMES;prime?;IB;4| ((|n| (I)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G800 NIL) (#2=#:G803 NIL) (|probablySafe| (I))
          (|currPrime| (I)) (#3=#:G802 NIL) (|n9| (I)) (#4=#:G801 NIL)
          (#5=#:G804 NIL) (|i| NIL) (|mn| (|Integer|)) (|q| (I)) (|k| NIL)
          (|nm1| (I)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |n| (SPADCALL (|spadConstant| $ 11) (QREFELT $ 50))
                        (QREFELT $ 35))
              (LETT |n| (SPADCALL |n| (QREFELT $ 50)))))
            (EXIT
             (COND ((SPADCALL |n| (QREFELT $ 17) (QREFELT $ 35)) NIL)
                   ((SPADCALL |n| (QREFELT $ 13) (QREFELT $ 35))
                    (SPADCALL |n| (QREFELT $ 9) (QREFELT $ 51)))
                   (#6='T
                    (COND
                     ((NULL
                       (SPADCALL (SPADCALL |n| (QREFELT $ 12) (QREFELT $ 52))
                                 (|spadConstant| $ 11) (QREFELT $ 44)))
                      NIL)
                     ((SPADCALL |n| (QREFELT $ 16) (QREFELT $ 35)) 'T)
                     (#6#
                      (SEQ
                       (LETT |nm1|
                             (SPADCALL |n| (|spadConstant| $ 11)
                                       (QREFELT $ 53)))
                       (LETT |q|
                             (SPADCALL |nm1| (QREFELT $ 17) (QREFELT $ 54)))
                       (SEQ (LETT |k| 1) G190
                            (COND
                             ((NULL (NULL (SPADCALL |q| (QREFELT $ 55))))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |q|
                                    (SPADCALL |q| (QREFELT $ 17)
                                              (QREFELT $ 54)))))
                            (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                            (EXIT NIL))
                       (EXIT
                        (COND
                         ((SPADCALL |n| (QREFELT $ 25) (QREFELT $ 35))
                          (COND
                           ((OR
                             (|PRIMES;rabinProvesCompositeSmall|
                              (SPADCALL 2 (QREFELT $ 8)) |n| |nm1| |q| |k| $)
                             (|PRIMES;rabinProvesCompositeSmall|
                              (SPADCALL 3 (QREFELT $ 8)) |n| |nm1| |q| |k| $))
                            (PROGN (LETT #2# NIL) (GO #7=#:G799)))
                           ((SPADCALL |n| (QREFELT $ 20) (QREFELT $ 35))
                            (COND
                             ((OR
                               (|PRIMES;rabinProvesCompositeSmall|
                                (SPADCALL 5 (QREFELT $ 8)) |n| |nm1| |q| |k| $)
                               (SPADCALL |n| (QREFELT $ 19) (QREFELT $ 51)))
                              (PROGN (LETT #2# NIL) (GO #7#)))
                             ('T 'T)))
                           (#6#
                            (COND
                             ((|PRIMES;rabinProvesCompositeSmall|
                               (SPADCALL 7 (QREFELT $ 8)) |n| |nm1| |q| |k| $)
                              (PROGN (LETT #2# NIL) (GO #7#)))
                             ((SPADCALL |n| (QREFELT $ 22) (QREFELT $ 35))
                              (COND
                               ((OR
                                 (|PRIMES;rabinProvesCompositeSmall|
                                  (SPADCALL 10 (QREFELT $ 8)) |n| |nm1| |q| |k|
                                  $)
                                 (SPADCALL |n| (QREFELT $ 21) (QREFELT $ 51)))
                                (PROGN (LETT #2# NIL) (GO #7#)))
                               ('T 'T)))
                             (#6#
                              (COND
                               ((OR
                                 (|PRIMES;rabinProvesCompositeSmall|
                                  (SPADCALL 5 (QREFELT $ 8)) |n| |nm1| |q| |k|
                                  $)
                                 (|PRIMES;rabinProvesCompositeSmall|
                                  (SPADCALL 11 (QREFELT $ 8)) |n| |nm1| |q| |k|
                                  $))
                                (PROGN (LETT #2# NIL) (GO #7#)))
                               ((SPADCALL |n| (QREFELT $ 24) (QREFELT $ 35))
                                (COND
                                 ((SPADCALL |n| (QREFELT $ 23) (QREFELT $ 51))
                                  (PROGN (LETT #2# NIL) (GO #7#)))
                                 (#6# 'T)))
                               (#6#
                                (COND
                                 ((OR
                                   (|PRIMES;rabinProvesCompositeSmall|
                                    (SPADCALL 13 (QREFELT $ 8)) |n| |nm1| |q|
                                    |k| $)
                                   (|PRIMES;rabinProvesCompositeSmall|
                                    (SPADCALL 17 (QREFELT $ 8)) |n| |nm1| |q|
                                    |k| $))
                                  (PROGN (LETT #2# NIL) (GO #7#)))
                                 ('T 'T)))))))))
                         (#6#
                          (SEQ
                           (EXIT
                            (SEQ (SETELT $ 28 (SPADCALL (QREFELT $ 27)))
                                 (SETELT $ 32 (SPADCALL |k| 0 (QREFELT $ 31)))
                                 (LETT |mn| (PROGN (QREFELT $ 9) 1))
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |i| (+ |mn| 1))
                                        (LETT #5# (+ |mn| 10)) G190
                                        (COND ((> |i| #5#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((|PRIMES;rabinProvesComposite|
                                             (SPADCALL (QREFELT $ 9) |i|
                                                       (QREFELT $ 56))
                                             |n| |nm1| |q| |k| $)
                                            (PROGN
                                             (LETT #4#
                                                   (PROGN
                                                    (LETT #2# NIL)
                                                    (GO #7#)))
                                             (GO #8=#:G785))))))
                                        (LETT |i| (+ |i| 1)) (GO G190) G191
                                        (EXIT NIL)))
                                  #8# (EXIT #4#))
                                 (COND
                                  ((SPADCALL |q| (|spadConstant| $ 11)
                                             (QREFELT $ 57))
                                   (COND
                                    ((SPADCALL
                                      (SPADCALL (SPADCALL 3 |n| (QREFELT $ 58))
                                                (|spadConstant| $ 11)
                                                (QREFELT $ 37))
                                      (QREFELT $ 60))
                                     (EXIT NIL)))))
                                 (SEQ
                                  (LETT |n9|
                                        (SPADCALL |n|
                                                  (SPADCALL 9 (QREFELT $ 8))
                                                  (QREFELT $ 61)))
                                  (EXIT
                                   (COND
                                    ((OR
                                      (SPADCALL |n9| (|spadConstant| $ 11)
                                                (QREFELT $ 44))
                                      (SPADCALL |n9|
                                                (SPADCALL (|spadConstant| $ 11)
                                                          (QREFELT $ 50))
                                                (QREFELT $ 44)))
                                     (COND
                                      ((SPADCALL
                                        (SPADCALL
                                         (SPADCALL 8 |n| (QREFELT $ 58))
                                         (|spadConstant| $ 11) (QREFELT $ 37))
                                        (QREFELT $ 60))
                                       (PROGN
                                        (LETT #3# NIL)
                                        (GO #9=#:G795))))))))
                                 (LETT |currPrime|
                                       (SPADCALL (QREFELT $ 9) (+ |mn| 10)
                                                 (QREFELT $ 56)))
                                 (LETT |probablySafe| (QREFELT $ 18))
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (COND
                                          ((EQL
                                            (SPADCALL (QREFELT $ 32) |k|
                                                      (QREFELT $ 46))
                                            0)
                                           'T)
                                          ('T
                                           (SPADCALL |n| |probablySafe|
                                                     (QREFELT $ 57)))))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SEQ
                                         (LETT |currPrime|
                                               (SPADCALL |currPrime|
                                                         (QREFELT $ 62)))
                                         (LETT |probablySafe|
                                               (SPADCALL |probablySafe|
                                                         (SPADCALL 100
                                                                   (QREFELT $
                                                                            8))
                                                         (QREFELT $ 10)))
                                         (EXIT
                                          (COND
                                           ((|PRIMES;rabinProvesComposite|
                                             |currPrime| |n| |nm1| |q| |k| $)
                                            (PROGN
                                             (LETT #1#
                                                   (PROGN
                                                    (LETT #2# NIL)
                                                    (GO #7#)))
                                             (GO #10=#:G793)))))))
                                       #10# (EXIT #1#))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (EXIT 'T)))
                           #9# (EXIT #3#)))))))))))))
          #7# (EXIT #2#)))) 

(SDEFUN |PRIMES;nextPrime;2I;5| ((|n| (I)) ($ (I)))
        (SEQ
         (COND ((SPADCALL |n| (QREFELT $ 17) (QREFELT $ 35)) (QREFELT $ 17))
               (#1='T
                (SEQ
                 (COND
                  ((SPADCALL |n| (QREFELT $ 55))
                   (LETT |n| (SPADCALL |n| (QREFELT $ 17) (QREFELT $ 37))))
                  (#1#
                   (LETT |n|
                         (SPADCALL |n| (|spadConstant| $ 11) (QREFELT $ 37)))))
                 (SEQ G190
                      (COND
                       ((NULL (NULL (SPADCALL |n| (QREFELT $ 39)))) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT |n|
                              (SPADCALL |n| (QREFELT $ 17) (QREFELT $ 37)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT |n|)))))) 

(SDEFUN |PRIMES;prevPrime;2I;6| ((|n| (I)) ($ (I)))
        (SEQ
         (COND
          ((SPADCALL |n| (SPADCALL 3 (QREFELT $ 8)) (QREFELT $ 35))
           (|error| "no primes less than 2"))
          ((SPADCALL |n| (SPADCALL 3 (QREFELT $ 8)) (QREFELT $ 44))
           (QREFELT $ 17))
          (#1='T
           (SEQ
            (COND
             ((SPADCALL |n| (QREFELT $ 55))
              (LETT |n| (SPADCALL |n| (QREFELT $ 17) (QREFELT $ 53))))
             (#1#
              (LETT |n| (SPADCALL |n| (|spadConstant| $ 11) (QREFELT $ 53)))))
            (SEQ G190
                 (COND ((NULL (NULL (SPADCALL |n| (QREFELT $ 39)))) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT |n| (SPADCALL |n| (QREFELT $ 17) (QREFELT $ 53)))))
                 NIL (GO G190) G191 (EXIT NIL))
            (EXIT |n|)))))) 

(DECLAIM (NOTINLINE |IntegerPrimesPackage;|)) 

(DEFUN |IntegerPrimesPackage| (#1=#:G818)
  (SPROG NIL
         (PROG (#2=#:G819)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IntegerPrimesPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|IntegerPrimesPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|IntegerPrimesPackage|)))))))))) 

(DEFUN |IntegerPrimesPackage;| (|#1|)
  (SPROG
   ((#1=#:G728 NIL) (#2=#:G727 NIL) (#3=#:G729 NIL) (#4=#:G817 NIL)
    (#5=#:G689 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (SEQ
    (PROGN
     (LETT DV$1 (|devaluate| |#1|))
     (LETT |dv$| (LIST '|IntegerPrimesPackage| DV$1))
     (LETT $ (GETREFV 64))
     (QSETREFV $ 0 |dv$|)
     (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
     (|haddProp| |$ConstructorCache| '|IntegerPrimesPackage| (LIST DV$1)
                 (CONS 1 $))
     (|stuffDomainSlots| $)
     (QSETREFV $ 6 |#1|)
     (SETF |pv$| (QREFELT $ 3))
     (QSETREFV $ 9
               (LIST (SPADCALL 2 (QREFELT $ 8)) (SPADCALL 3 (QREFELT $ 8))
                     (SPADCALL 5 (QREFELT $ 8)) (SPADCALL 7 (QREFELT $ 8))
                     (SPADCALL 11 (QREFELT $ 8)) (SPADCALL 13 (QREFELT $ 8))
                     (SPADCALL 17 (QREFELT $ 8)) (SPADCALL 19 (QREFELT $ 8))
                     (SPADCALL 23 (QREFELT $ 8)) (SPADCALL 29 (QREFELT $ 8))
                     (SPADCALL 31 (QREFELT $ 8)) (SPADCALL 37 (QREFELT $ 8))
                     (SPADCALL 41 (QREFELT $ 8)) (SPADCALL 43 (QREFELT $ 8))
                     (SPADCALL 47 (QREFELT $ 8)) (SPADCALL 53 (QREFELT $ 8))
                     (SPADCALL 59 (QREFELT $ 8)) (SPADCALL 61 (QREFELT $ 8))
                     (SPADCALL 67 (QREFELT $ 8)) (SPADCALL 71 (QREFELT $ 8))
                     (SPADCALL 73 (QREFELT $ 8)) (SPADCALL 79 (QREFELT $ 8))
                     (SPADCALL 83 (QREFELT $ 8)) (SPADCALL 89 (QREFELT $ 8))
                     (SPADCALL 97 (QREFELT $ 8)) (SPADCALL 101 (QREFELT $ 8))
                     (SPADCALL 103 (QREFELT $ 8)) (SPADCALL 107 (QREFELT $ 8))
                     (SPADCALL 109 (QREFELT $ 8)) (SPADCALL 113 (QREFELT $ 8))
                     (SPADCALL 127 (QREFELT $ 8)) (SPADCALL 131 (QREFELT $ 8))
                     (SPADCALL 137 (QREFELT $ 8)) (SPADCALL 139 (QREFELT $ 8))
                     (SPADCALL 149 (QREFELT $ 8)) (SPADCALL 151 (QREFELT $ 8))
                     (SPADCALL 157 (QREFELT $ 8)) (SPADCALL 163 (QREFELT $ 8))
                     (SPADCALL 167 (QREFELT $ 8)) (SPADCALL 173 (QREFELT $ 8))
                     (SPADCALL 179 (QREFELT $ 8)) (SPADCALL 181 (QREFELT $ 8))
                     (SPADCALL 191 (QREFELT $ 8)) (SPADCALL 193 (QREFELT $ 8))
                     (SPADCALL 197 (QREFELT $ 8)) (SPADCALL 199 (QREFELT $ 8))
                     (SPADCALL 211 (QREFELT $ 8)) (SPADCALL 223 (QREFELT $ 8))
                     (SPADCALL 227 (QREFELT $ 8)) (SPADCALL 229 (QREFELT $ 8))
                     (SPADCALL 233 (QREFELT $ 8)) (SPADCALL 239 (QREFELT $ 8))
                     (SPADCALL 241 (QREFELT $ 8)) (SPADCALL 251 (QREFELT $ 8))
                     (SPADCALL 257 (QREFELT $ 8)) (SPADCALL 263 (QREFELT $ 8))
                     (SPADCALL 269 (QREFELT $ 8)) (SPADCALL 271 (QREFELT $ 8))
                     (SPADCALL 277 (QREFELT $ 8)) (SPADCALL 281 (QREFELT $ 8))
                     (SPADCALL 283 (QREFELT $ 8)) (SPADCALL 293 (QREFELT $ 8))
                     (SPADCALL 307 (QREFELT $ 8)) (SPADCALL 311 (QREFELT $ 8))
                     (SPADCALL 313 (QREFELT $ 8))))
     (QSETREFV $ 12
               (PROGN
                (LETT #1# NIL)
                (SEQ (LETT #5# NIL) (LETT #4# (QREFELT $ 9)) G190
                     (COND
                      ((OR (ATOM #4#) (PROGN (LETT #5# (CAR #4#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (PROGN
                        (LETT #3# #5#)
                        (COND
                         (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 10))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                     (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                (COND (#1# #2#) ('T (|spadConstant| $ 11)))))
     (QSETREFV $ 13 (SPADCALL 317 (QREFELT $ 8)))
     (QSETREFV $ 16 (SPADCALL (QREFELT $ 13) 2 (QREFELT $ 15)))
     (QSETREFV $ 17 (SPADCALL 2 (QREFELT $ 8)))
     (QSETREFV $ 18 (SPADCALL (SPADCALL 10 (QREFELT $ 8)) 20 (QREFELT $ 15)))
     (QSETREFV $ 19
               (LIST (SPADCALL 25326001 (QREFELT $ 8))
                     (SPADCALL 161304001 (QREFELT $ 8))
                     (SPADCALL 960946321 (QREFELT $ 8))
                     (SPADCALL 1157839381 (QREFELT $ 8))
                     (SPADCALL 3697278427 (QREFELT $ 8))
                     (SPADCALL 5764643587 (QREFELT $ 8))
                     (SPADCALL 6770862367 (QREFELT $ 8))
                     (SPADCALL 14386156093 (QREFELT $ 8))
                     (SPADCALL 15579919981 (QREFELT $ 8))
                     (SPADCALL 18459366157 (QREFELT $ 8))
                     (SPADCALL 19887974881 (QREFELT $ 8))
                     (SPADCALL 21276028621 (QREFELT $ 8))))
     (QSETREFV $ 20 (SPADCALL 27716349961 (QREFELT $ 8)))
     (QSETREFV $ 21
               (LIST (SPADCALL 3215031751 (QREFELT $ 8))
                     (SPADCALL 118670087467 (QREFELT $ 8))
                     (SPADCALL 128282461501 (QREFELT $ 8))
                     (SPADCALL 354864744877 (QREFELT $ 8))
                     (SPADCALL 546348519181 (QREFELT $ 8))
                     (SPADCALL 602248359169 (QREFELT $ 8))
                     (SPADCALL 669094855201 (QREFELT $ 8))))
     (QSETREFV $ 22 (SPADCALL (EXPT 10 12) (QREFELT $ 8)))
     (QSETREFV $ 23
               (LIST (SPADCALL 2152302898747 (QREFELT $ 8))
                     (SPADCALL 3474749660383 (QREFELT $ 8))))
     (QSETREFV $ 24 (SPADCALL (EXPT 10 13) (QREFELT $ 8)))
     (QSETREFV $ 25 (SPADCALL 341550071728321 (QREFELT $ 8)))
     (QSETREFV $ 28 (SPADCALL (QREFELT $ 27)))
     (QSETREFV $ 32 (SPADCALL 1 0 (QREFELT $ 31)))
     $)))) 

(MAKEPROP '|IntegerPrimesPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|) (0 . |coerce|)
              '|smallPrimes| (5 . *) (11 . |One|) '|productSmallPrimes|
              '|nextSmallPrime| (|PositiveInteger|) (15 . ^)
              '|nextSmallPrimeSquared| '|two| '|tenPowerTwenty|
              '|PomeranceList| '|PomeranceLimit| '|PinchList| '|PinchLimit|
              '|PinchList2| '|PinchLimit2| '|JaeschkeLimit| (|Set| 6)
              (21 . |empty|) '|rootsMinus1| (|NonNegativeInteger|)
              (|Vector| 29) (25 . |new|) '|count2Order| (31 . |Zero|)
              (|Boolean|) (35 . <) (41 . |even?|) (46 . +) (52 . |convert|)
              |PRIMES;prime?;IB;4| (57 . <=) (|List| 6) |PRIMES;primes;2IL;1|
              (63 . |powmod|) (70 . =) (76 . |mulmod|) (83 . |elt|)
              (89 . |setelt!|) (96 . |union|) (102 . |#|) (107 . -)
              (112 . |member?|) (118 . |gcd|) (124 . -) (130 . |quo|)
              (136 . |odd?|) (141 . |elt|) (147 . >) (153 . *)
              (|IntegerRoots| 6) (159 . |perfectSquare?|) (164 . |rem|)
              |PRIMES;nextPrime;2I;5| |PRIMES;prevPrime;2I;6|)
           '#(|primes| 170 |prime?| 176 |prevPrime| 181 |nextPrime| 186) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|prime?| ((|Boolean|) |#1|)) T)
                                   '((|nextPrime| (|#1| |#1|)) T)
                                   '((|prevPrime| (|#1| |#1|)) T)
                                   '((|primes| ((|List| |#1|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 63
                                            '(1 6 0 7 8 2 6 0 0 0 10 0 6 0 11 2
                                              6 0 0 14 15 0 26 0 27 2 30 0 29
                                              29 31 0 6 0 33 2 6 34 0 0 35 1 6
                                              34 0 36 2 6 0 0 0 37 1 6 7 0 38 2
                                              6 34 0 0 40 3 6 0 0 0 0 43 2 6 34
                                              0 0 44 3 6 0 0 0 0 45 2 30 29 0 7
                                              46 3 30 29 0 7 29 47 2 26 0 0 6
                                              48 1 26 29 0 49 1 6 0 0 50 2 41
                                              34 6 0 51 2 6 0 0 0 52 2 6 0 0 0
                                              53 2 6 0 0 0 54 1 6 34 0 55 2 41
                                              6 0 7 56 2 6 34 0 0 57 2 6 0 14 0
                                              58 1 59 34 6 60 2 6 0 0 0 61 2 0
                                              41 6 6 42 1 0 34 6 39 1 0 6 6 63
                                              1 0 6 6 62)))))
           '|lookupComplete|)) 

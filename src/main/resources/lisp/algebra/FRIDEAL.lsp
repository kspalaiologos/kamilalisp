
(SDEFUN |FRIDEAL;One;$;1| (($ ($)))
        (CONS (VECTOR (|spadConstant| $ 13)) (|spadConstant| $ 12))) 

(PUT '|FRIDEAL;numer;$V;2| '|SPADreplace| 'QCAR) 

(SDEFUN |FRIDEAL;numer;$V;2| ((|i| ($)) ($ (|Vector| A))) (QCAR |i|)) 

(PUT '|FRIDEAL;denom;$R;3| '|SPADreplace| 'QCDR) 

(SDEFUN |FRIDEAL;denom;$R;3| ((|i| ($)) ($ (R))) (QCDR |i|)) 

(PUT '|FRIDEAL;mkIdeal| '|SPADreplace| 'CONS) 

(SDEFUN |FRIDEAL;mkIdeal| ((|v| (|Vector| A)) (|d| (R)) ($ ($))) (CONS |v| |d|)) 

(SDEFUN |FRIDEAL;invrep| ((|m| (|Matrix| F)) ($ (A)))
        (SPADCALL
         (SPADCALL (SPADCALL |m| (QREFELT $ 18))
                   (SPADCALL (|spadConstant| $ 13) (QREFELT $ 20))
                   (QREFELT $ 21))
         (QREFELT $ 22))) 

(SDEFUN |FRIDEAL;upmat|
        ((|x| (A)) (|i| (|NonNegativeInteger|)) ($ (|Matrix| UP)))
        (SPROG NIL
               (SPADCALL (CONS #'|FRIDEAL;upmat!0| (VECTOR $ |i|))
                         (SPADCALL (SPADCALL |x| (QREFELT $ 25))
                                   (QREFELT $ 18))
                         (QREFELT $ 29)))) 

(SDEFUN |FRIDEAL;upmat!0| ((|s| NIL) ($$ NIL))
        (PROG (|i| $)
          (LETT |i| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s| |i| (QREFELT $ 24)))))) 

(SDEFUN |FRIDEAL;ret?| ((|v| (|Vector| A)) ($ (|Boolean|)))
        (SPADCALL (CONS #'|FRIDEAL;ret?!0| $) |v| (QREFELT $ 34))) 

(SDEFUN |FRIDEAL;ret?!0| ((|s| NIL) ($ NIL))
        (QEQCAR (SPADCALL |s| (QREFELT $ 31)) 0)) 

(SDEFUN |FRIDEAL;=;2$B;8| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 16)) (SPADCALL |y| (QREFELT $ 16))
                    (QREFELT $ 35))
          (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (SPADCALL |y| (QREFELT $ 15))
                    (QREFELT $ 36)))
         ('T NIL))) 

(SDEFUN |FRIDEAL;agcd| ((|l| (|List| A)) ($ (R)))
        (SPROG ((#1=#:G730 NIL) (|a| NIL) (#2=#:G729 NIL))
               (SEQ
                (SPADCALL (ELT $ 39)
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |a| NIL) (LETT #1# |l|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |a| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (|FRIDEAL;vgcd|
                                          (SPADCALL |a| (QREFELT $ 20)) $)
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (|spadConstant| $ 38) (QREFELT $ 42))))) 

(SDEFUN |FRIDEAL;oldnorm| ((|i| ($)) ($ (F)))
        (SPROG ((#1=#:G748 NIL) (|u| NIL) (#2=#:G747 NIL))
               (SEQ
                (SPADCALL
                 (SPADCALL
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |u| NIL)
                        (LETT #1#
                              (SPADCALL
                               (SPADCALL (|FRIDEAL;summat| |i| $)
                                         (QREFELT $ 43))
                               (QREFELT $ 45)))
                        G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2# (CONS (SPADCALL |u| (QREFELT $ 46)) #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#))))
                  (QREFELT $ 48))
                 (SPADCALL (SPADCALL |i| (QREFELT $ 16))
                           (SPADCALL (QREFELT $ 50)) (QREFELT $ 51))
                 (QREFELT $ 52))))) 

(SDEFUN |FRIDEAL;norm;$F;11| ((|i| ($)) ($ (F)))
        (SPROG
         ((#1=#:G777 NIL) (|j| NIL) (#2=#:G776 NIL)
          (|dv| (|SingletonAsOrderedSet|))
          (|pp| (|SparseUnivariatePolynomial| A)) (#3=#:G775 NIL)
          (|j0| (|Integer|)) (|chara| (|NonNegativeInteger|)) (|n| (|Integer|))
          (|v| (|Vector| A)))
         (SEQ (LETT |v| (SPADCALL |i| (QREFELT $ 15)))
              (LETT |n| (* (- (QVSIZE |v|) 1) (SPADCALL (QREFELT $ 50))))
              (LETT |chara| (SPADCALL (QREFELT $ 53)))
              (COND
               ((> |chara| 0)
                (COND ((>= |n| |chara|) (EXIT (|FRIDEAL;oldnorm| |i| $))))))
              (LETT |pp| (|spadConstant| $ 56))
              (LETT |j0| (SPADCALL |v| (QREFELT $ 58)))
              (SEQ (LETT |j| 0) (LETT #3# (- (QVSIZE |v|) 1)) G190
                   (COND ((|greater_SI| |j| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |pp|
                           (SPADCALL |pp|
                                     (SPADCALL (QAREF1O |v| (+ |j0| |j|) 1) |j|
                                               (QREFELT $ 59))
                                     (QREFELT $ 60)))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (LETT |dv| (SPADCALL (QREFELT $ 62)))
              (EXIT
               (SPADCALL
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |j| 0) (LETT #1# |n|) G190
                       (COND ((|greater_SI| |j| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL |pp| |dv|
                                             (SPADCALL |j| (QREFELT $ 63))
                                             (QREFELT $ 64))
                                   (QREFELT $ 65))
                                  (QREFELT $ 66))
                                 (QREFELT $ 46))
                                #2#))))
                       (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 48))
                (SPADCALL (SPADCALL |i| (QREFELT $ 16))
                          (SPADCALL (QREFELT $ 50)) (QREFELT $ 51))
                (QREFELT $ 52)))))) 

(SDEFUN |FRIDEAL;tryRange|
        ((|range| (|NonNegativeInteger|)) (|nm| (|Vector| A)) (|nrm| (R))
         (|i| ($)) ($ (|Union| $ "failed")))
        (SPROG
         ((#1=#:G789 NIL) (#2=#:G790 NIL) (#3=#:G783 NIL) (|a| (A)) (|j| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |j| 0) G190 (COND ((|greater_SI| |j| 10) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ
                    (LETT |a| (SPADCALL (* 10 |range|) |nm| (QREFELT $ 68)))
                    (EXIT
                     (COND
                      ((SPADCALL
                        (SPADCALL
                         (PROG2
                             (LETT #3#
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |a| (QREFELT $ 66))
                                              (QREFELT $ 46))
                                    |nrm| (QREFELT $ 70)))
                             (QCDR #3#)
                           (|check_union2| (QEQCAR #3# 0) (QREFELT $ 6)
                                           (|Union| (QREFELT $ 6) "failed")
                                           #3#))
                         |nrm| (QREFELT $ 39))
                        (QREFELT $ 71))
                       (PROGN
                        (LETT #1#
                              (PROGN
                               (LETT #2#
                                     (CONS 0
                                           (|FRIDEAL;intIdeal|
                                            (LIST
                                             (SPADCALL
                                              (SPADCALL |nrm| (QREFELT $ 72))
                                              (QREFELT $ 73))
                                             |a|)
                                            (SPADCALL |i| (QREFELT $ 16)) $)))
                               (GO #4=#:G788)))
                        (GO #5=#:G785)))))))
                  #5# (EXIT #1#))
                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 1 "failed"))))
          #4# (EXIT #2#)))) 

(SDEFUN |FRIDEAL;summat| ((|i| ($)) ($ (|Matrix| UP)))
        (SPROG
         ((#1=#:G800 NIL) (|j| NIL) (#2=#:G799 NIL) (|m| (|Integer|))
          (|v| (|Vector| A)))
         (SEQ
          (LETT |m|
                (SPADCALL (LETT |v| (SPADCALL |i| (QREFELT $ 15)))
                          (QREFELT $ 58)))
          (EXIT
           (SPADCALL (ELT $ 74)
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |j| 0) (LETT #1# (- (QVSIZE |v|) 1)) G190
                           (COND ((|greater_SI| |j| #1#) (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (|FRIDEAL;upmat|
                                     (QAREF1O |v| (+ |j| |m|) 1) |j| $)
                                    #2#))))
                           (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (QREFELT $ 77)))))) 

(SDEFUN |FRIDEAL;inv;2$;14| ((|i| ($)) ($ ($)))
        (SPROG
         ((#1=#:G939 NIL) (|j| NIL) (#2=#:G938 NIL)
          (|d| (|NonNegativeInteger|)) (#3=#:G937 NIL) (|p| NIL)
          (#4=#:G936 NIL) (|invd| (F))
          (|cd2| (|Record| (|:| |num| (|List| R)) (|:| |den| R)))
          (|cd| (|Record| (|:| |num| (|Matrix| UP)) (|:| |den| UP)))
          (|m| (|Matrix| (|Fraction| UP))) (#5=#:G808 NIL))
         (SEQ
          (LETT |m|
                (PROG2
                    (LETT #5#
                          (SPADCALL
                           (SPADCALL (ELT $ 79) (|FRIDEAL;summat| |i| $)
                                     (QREFELT $ 83))
                           (QREFELT $ 84)))
                    (QCDR #5#)
                  (|check_union2| (QEQCAR #5# 0)
                                  (|Matrix| (|Fraction| (QREFELT $ 8)))
                                  (|Union|
                                   (|Matrix| (|Fraction| (QREFELT $ 8)))
                                   "failed")
                                  #5#)))
          (LETT |cd|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (SPADCALL |i| (QREFELT $ 16)) (QREFELT $ 72))
                    (QREFELT $ 85))
                   (QREFELT $ 79))
                  |m| (QREFELT $ 86))
                 (QREFELT $ 89)))
          (LETT |cd2|
                (SPADCALL (SPADCALL (QCDR |cd|) (QREFELT $ 45))
                          (QREFELT $ 92)))
          (LETT |invd|
                (SPADCALL (QCDR |cd2|)
                          (SPADCALL (ELT $ 39) (QCAR |cd2|) (QREFELT $ 93))
                          (QREFELT $ 52)))
          (LETT |d|
                (SPADCALL (ELT $ 97)
                          (PROGN
                           (LETT #4# NIL)
                           (SEQ (LETT |p| NIL)
                                (LETT #3#
                                      (SPADCALL (QCAR |cd|) (QREFELT $ 95)))
                                G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |p| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #4#
                                        (CONS (SPADCALL |p| (QREFELT $ 96))
                                              #4#))))
                                (LETT #3# (CDR #3#)) (GO G190) G191
                                (EXIT (NREVERSE #4#))))
                          (QREFELT $ 100)))
          (EXIT
           (SPADCALL
            (PROGN
             (LETT #2# (GETREFV (|inc_SI| |d|)))
             (SEQ (LETT |j| 0) (LETT #1# |d|) G190
                  (COND ((|greater_SI| |j| #1#) (GO G191)))
                  (SEQ
                   (EXIT
                    (SETELT #2# |j|
                            (SPADCALL |invd|
                                      (|FRIDEAL;invrep|
                                       (SPADCALL
                                        (CONS #'|FRIDEAL;inv;2$;14!0|
                                              (VECTOR $ |j|))
                                        (QCAR |cd|) (QREFELT $ 104))
                                       $)
                                      (QREFELT $ 105)))))
                  (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
             #2#)
            (QREFELT $ 106)))))) 

(SDEFUN |FRIDEAL;inv;2$;14!0| ((|s| NIL) ($$ NIL))
        (PROG (|j| $)
          (LETT |j| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s| |j| (QREFELT $ 101)))))) 

(SDEFUN |FRIDEAL;ideal;V$;15| ((|v| (|Vector| A)) ($ ($)))
        (SPROG
         ((#1=#:G957 NIL) (|i| NIL) (#2=#:G956 NIL) (|d| (R)) (#3=#:G955 NIL)
          (#4=#:G954 NIL))
         (SEQ
          (LETT |d|
                (SPADCALL (ELT $ 110)
                          (PROGN
                           (LETT #4# NIL)
                           (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 58)))
                                (LETT #3# (QVSIZE |v|)) G190
                                (COND ((> |i| #3#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #4#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL (QAREF1O |v| |i| 1)
                                                    (QREFELT $ 20))
                                          (QREFELT $ 109))
                                         #4#))))
                                (LETT |i| (+ |i| 1)) (GO G190) G191
                                (EXIT (NREVERSE #4#))))
                          (QREFELT $ 93)))
          (EXIT
           (|FRIDEAL;intIdeal|
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 58)))
                  (LETT #1# (QVSIZE |v|)) G190 (COND ((> |i| #1#) (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #2#
                          (CONS
                           (SPADCALL (SPADCALL |d| (QREFELT $ 72))
                                     (QAREF1O |v| |i| 1) (QREFELT $ 105))
                           #2#))))
                  (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT (NREVERSE #2#))))
            |d| $))))) 

(SDEFUN |FRIDEAL;intIdeal| ((|l| (|List| A)) (|d| (R)) ($ ($)))
        (SPROG
         ((|va| (|Vector| A)) (#1=#:G974 NIL) (#2=#:G976 NIL) (|m| NIL)
          (#3=#:G975 NIL) (|invb| (F)) (|a| (A)) (|b| (R)) (|g| (R)) (|r| (R))
          (|nr| (|List| A)) (|lr| (|List| R)) (|u| (|Union| F "failed"))
          (#4=#:G973 NIL) (|x| NIL))
         (SEQ (LETT |lr| NIL) (LETT |nr| NIL)
              (SEQ (LETT |x| NIL) (LETT #4# (SPADCALL |l| (QREFELT $ 112)))
                   G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 31)))
                        (EXIT
                         (COND
                          ((QEQCAR |u| 0)
                           (LETT |lr|
                                 (CONS (SPADCALL (QCDR |u|) (QREFELT $ 46))
                                       |lr|)))
                          ('T (LETT |nr| (CONS |x| |nr|))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (LETT |r| (SPADCALL |lr| (QREFELT $ 48)))
              (LETT |g| (|FRIDEAL;agcd| |nr| $))
              (LETT |a|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL |r|
                                (LETT |b|
                                      (SPADCALL
                                       (SPADCALL |d| |r| (QREFELT $ 39)) |g|
                                       (QREFELT $ 39)))
                                (QREFELT $ 113))
                      (QREFELT $ 72))
                     (QREFELT $ 73)))
              (LETT |d| (SPADCALL |d| |b| (QREFELT $ 113)))
              (COND
               ((SPADCALL |r| (|spadConstant| $ 38) (QREFELT $ 114))
                (COND
                 ((QEQCAR (SPADCALL |g| |r| (QREFELT $ 70)) 0)
                  (EXIT (|FRIDEAL;mkIdeal| (VECTOR |a|) |d| $))))))
              (LETT |invb|
                    (SPADCALL (SPADCALL |b| (QREFELT $ 72)) (QREFELT $ 115)))
              (LETT |va|
                    (PROGN
                     (LETT #3# (GETREFV (SIZE |nr|)))
                     (SEQ (LETT |m| NIL) (LETT #2# |nr|) (LETT #1# 0) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |m| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (SETELT #3# #1#
                                    (SPADCALL |invb| |m| (QREFELT $ 105)))))
                          (LETT #1#
                                (PROG1 (|inc_SI| #1#) (LETT #2# (CDR #2#))))
                          (GO G190) G191 (EXIT NIL))
                     #3#))
              (EXIT
               (COND
                ((SPADCALL |a| (QREFELT $ 116)) (|FRIDEAL;mkIdeal| |va| |d| $))
                ('T
                 (|FRIDEAL;mkIdeal| (SPADCALL |a| |va| (QREFELT $ 117)) |d|
                  $))))))) 

(SDEFUN |FRIDEAL;vgcd| ((|v| (|Vector| F)) ($ (R)))
        (SPROG ((#1=#:G981 NIL) (|i| NIL) (#2=#:G980 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 118)))
                       (LETT #1# (QVSIZE |v|)) G190
                       (COND ((> |i| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |v| |i| (QREFELT $ 119))
                                          (QREFELT $ 46))
                                #2#))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 48))))) 

(SDEFUN |FRIDEAL;poly| ((|i| ($)) ($ (|SparseUnivariatePolynomial| A)))
        (SPROG
         ((#1=#:G983 NIL) (#2=#:G982 #3=(|SparseUnivariatePolynomial| A))
          (#4=#:G984 #3#) (#5=#:G987 NIL) (|m| (|Integer|)) (|v| (|Vector| A)))
         (SEQ
          (LETT |m|
                (SPADCALL (LETT |v| (SPADCALL |i| (QREFELT $ 15)))
                          (QREFELT $ 58)))
          (EXIT
           (PROGN
            (LETT #1# NIL)
            (SEQ (LETT |i| 0) (LETT #5# (- (QVSIZE |v|) 1)) G190
                 (COND ((|greater_SI| |i| #5#) (GO G191)))
                 (SEQ
                  (EXIT
                   (PROGN
                    (LETT #4#
                          (SPADCALL (QAREF1O |v| (+ |i| |m|) 1) |i|
                                    (QREFELT $ 59)))
                    (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 60))))
                          ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (COND (#1# #2#) ('T (|spadConstant| $ 56)))))))) 

(SDEFUN |FRIDEAL;*;3$;19| ((|i1| ($)) (|i2| ($)) ($ ($)))
        (|FRIDEAL;intIdeal|
         (SPADCALL
          (SPADCALL (|FRIDEAL;poly| |i1| $) (|FRIDEAL;poly| |i2| $)
                    (QREFELT $ 120))
          (QREFELT $ 121))
         (SPADCALL (SPADCALL |i1| (QREFELT $ 16))
                   (SPADCALL |i2| (QREFELT $ 16)) (QREFELT $ 122))
         $)) 

(SDEFUN |FRIDEAL;^;$I$;20| ((|i| ($)) (|m| (|Integer|)) ($ ($)))
        (SPROG
         ((#1=#:G996 NIL) (|j| NIL) (#2=#:G995 NIL) (|v| (|Vector| A))
          (|n| (|NonNegativeInteger|)) (#3=#:G990 NIL))
         (SEQ
          (COND
           ((< |m| 0)
            (SPADCALL (SPADCALL |i| (QREFELT $ 107)) (- |m|) (QREFELT $ 124)))
           ('T
            (SEQ
             (LETT |n|
                   (PROG1 (LETT #3# |m|)
                     (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #3#)))
             (LETT |v| (SPADCALL |i| (QREFELT $ 15)))
             (EXIT
              (|FRIDEAL;intIdeal|
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |j| (SPADCALL |v| (QREFELT $ 58)))
                     (LETT #1# (QVSIZE |v|)) G190
                     (COND ((> |j| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (SPADCALL (QAREF1O |v| |j| 1) |n|
                                        (QREFELT $ 125))
                              #2#))))
                     (LETT |j| (+ |j| 1)) (GO G190) G191
                     (EXIT (NREVERSE #2#))))
               (SPADCALL (SPADCALL |i| (QREFELT $ 16)) |n| (QREFELT $ 126))
               $)))))))) 

(SDEFUN |FRIDEAL;num2O| ((|v| (|Vector| A)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G1001 NIL) (|i| NIL) (#2=#:G1000 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 58)))
                       (LETT #1# (QVSIZE |v|)) G190
                       (COND ((> |i| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (QAREF1O |v| |i| 1) (QREFELT $ 128))
                                #2#))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 129))))) 

(SDEFUN |FRIDEAL;basis;$V;22| ((|i| ($)) ($ (|Vector| A)))
        (SPROG
         ((#1=#:G1007 NIL) (#2=#:G1009 NIL) (|j| NIL) (#3=#:G1008 NIL)
          (|d| (F)) (|v| (|Vector| A)))
         (SEQ (LETT |v| (SPADCALL |i| (QREFELT $ 15)))
              (LETT |d|
                    (SPADCALL
                     (SPADCALL (SPADCALL |i| (QREFELT $ 16)) (QREFELT $ 72))
                     (QREFELT $ 115)))
              (EXIT
               (PROGN
                (LETT #3#
                      (GETREFV
                       (|inc_SI|
                        (- #4=(QVSIZE |v|) #5=(SPADCALL |v| (QREFELT $ 58))))))
                (SEQ (LETT |j| #5#) (LETT #2# #4#) (LETT #1# 0) G190
                     (COND ((> |j| #2#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SETELT #3# #1#
                               (SPADCALL |d| (QAREF1O |v| |j| 1)
                                         (QREFELT $ 105)))))
                     (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |j| (+ |j| 1))))
                     (GO G190) G191 (EXIT NIL))
                #3#))))) 

(SDEFUN |FRIDEAL;coerce;$Of;23| ((|i| ($)) ($ (|OutputForm|)))
        (SPROG ((|nm| (|OutputForm|)))
               (SEQ
                (LETT |nm| (|FRIDEAL;num2O| (SPADCALL |i| (QREFELT $ 15)) $))
                (EXIT
                 (COND
                  ((SPADCALL (SPADCALL |i| (QREFELT $ 16))
                             (|spadConstant| $ 12) (QREFELT $ 35))
                   |nm|)
                  ('T
                   (SPADCALL
                    (SPADCALL (SPADCALL 1 (QREFELT $ 131))
                              (SPADCALL (SPADCALL |i| (QREFELT $ 16))
                                        (QREFELT $ 132))
                              (QREFELT $ 133))
                    |nm| (QREFELT $ 134)))))))) 

(SDEFUN |FRIDEAL;randomLC;NniVA;24|
        ((|m| (|NonNegativeInteger|)) (|v| (|Vector| A)) ($ (A)))
        (SPROG
         ((#1=#:G1014 NIL) (#2=#:G1013 (A)) (#3=#:G1015 (A)) (#4=#:G1017 NIL)
          (|j| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |j| (SPADCALL |v| (QREFELT $ 58)))
                (LETT #4# (QVSIZE |v|)) G190 (COND ((> |j| #4#) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (SPADCALL (SPADCALL (QREFELT $ 136))
                                   (QAREF1O |v| |j| 1) (QREFELT $ 105)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 137))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 138))))))) 

(SDEFUN |FRIDEAL;randomLC;NniVA;25|
        ((|m| (|NonNegativeInteger|)) (|v| (|Vector| A)) ($ (A)))
        (SPROG
         ((#1=#:G1019 NIL) (#2=#:G1018 (A)) (#3=#:G1020 (A)) (#4=#:G1022 NIL)
          (|j| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |j| (SPADCALL |v| (QREFELT $ 58)))
                (LETT #4# (QVSIZE |v|)) G190 (COND ((> |j| #4#) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (SPADCALL (RANDOM |m|) (QAREF1O |v| |j| 1)
                                   (QREFELT $ 139)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 137))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 138))))))) 

(SDEFUN |FRIDEAL;minimize;2$;26| ((|i| ($)) ($ ($)))
        (SPROG
         ((#1=#:G1032 NIL) (#2=#:G1033 NIL) (|u| (|Union| $ "failed"))
          (|range| NIL) (|nrm| (R)) (|n| (|NonNegativeInteger|))
          (|nm| (|Vector| A)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QVSIZE (LETT |nm| (SPADCALL |i| (QREFELT $ 15)))))
                (COND ((EQL |n| 1) (EXIT |i|))
                      ((< |n| 3) (COND ((|FRIDEAL;ret?| |nm| $) (EXIT |i|)))))
                (LETT |nrm|
                      (SPADCALL
                       (SPADCALL
                        (|FRIDEAL;mkIdeal| |nm| (|spadConstant| $ 12) $)
                        (QREFELT $ 67))
                       (QREFELT $ 46)))
                (SEQ
                 (EXIT
                  (SEQ (LETT |range| 1) G190
                       (COND ((|greater_SI| |range| 5) (GO G191)))
                       (SEQ
                        (LETT |u|
                              (|FRIDEAL;tryRange| |range| |nm| |nrm| |i| $))
                        (EXIT
                         (COND
                          ((QEQCAR |u| 0)
                           (PROGN
                            (LETT #1#
                                  (PROGN
                                   (LETT #2# (QCDR |u|))
                                   (GO #3=#:G1031)))
                            (GO #4=#:G1029))))))
                       (LETT |range| (|inc_SI| |range|)) (GO G190) G191
                       (EXIT NIL)))
                 #4# (EXIT #1#))
                (EXIT |i|)))
          #3# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |FractionalIdeal;|)) 

(DEFUN |FractionalIdeal| (&REST #1=#:G1034)
  (SPROG NIL
         (PROG (#2=#:G1035)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FractionalIdeal|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FractionalIdeal;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FractionalIdeal|)))))))))) 

(DEFUN |FractionalIdeal;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|FractionalIdeal| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 144))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FractionalIdeal|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (|Record| (|:| |num| (|Vector| |#4|)) (|:| |den| |#1|)))
    (COND
     ((|HasCategory| |#2| '(|Finite|))
      (QSETREFV $ 68
                (CONS (|dispatchFunction| |FRIDEAL;randomLC;NniVA;24|) $)))
     ('T
      (QSETREFV $ 68
                (CONS (|dispatchFunction| |FRIDEAL;randomLC;NniVA;25|) $))))
    $))) 

(MAKEPROP '|FractionalIdeal| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) '|Rep|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |FRIDEAL;One;$;1|) $))
              (0 . |One|) (4 . |One|) (|Vector| 9) |FRIDEAL;numer;$V;2|
              |FRIDEAL;denom;$R;3| (|Matrix| 7) (8 . |transpose|) (|Vector| 7)
              (13 . |coordinates|) (18 . *) (24 . |represents|)
              (|NonNegativeInteger|) (29 . |monomial|)
              (35 . |regularRepresentation|) (|Matrix| 8) (|Mapping| 8 7)
              (|MatrixCategoryFunctions2| 7 19 19 17 8 (|Vector| 8)
                                          (|Vector| 8) 26)
              (40 . |map|) (|Union| 7 '"failed") (46 . |retractIfCan|)
              (|Boolean|) (|Mapping| 32 9) (51 . |any?|) (57 . =) (63 . =)
              |FRIDEAL;=;2$B;8| (69 . |Zero|) (73 . |gcd|) (|Mapping| 6 6 6)
              (|List| 6) (79 . |reduce|) (86 . |determinant|) (|List| 7)
              (91 . |coefficients|) (96 . |retract|) (|List| $) (101 . |gcd|)
              (|PositiveInteger|) (106 . |rank|) (110 . ^) (116 . /)
              (122 . |characteristic|) (126 . |Zero|)
              (|SparseUnivariatePolynomial| 9) (130 . |Zero|) (|Integer|)
              (134 . |minIndex|) (139 . |monomial|) (145 . +)
              (|SingletonAsOrderedSet|) (151 . |create|) (155 . |coerce|)
              (160 . |eval|) (167 . |retract|) (172 . |norm|)
              |FRIDEAL;norm;$F;11| (177 . |randomLC|) (|Union| $ '"failed")
              (183 . |exquo|) (189 . |unit?|) (194 . |coerce|) (199 . |coerce|)
              (204 . +) (|Mapping| 26 26 26) (|List| 26) (210 . |reduce|)
              (|Fraction| 8) (216 . |coerce|) (|Matrix| 78) (|Mapping| 78 8)
              (|MatrixCategoryFunctions2| 8 (|Vector| 8) (|Vector| 8) 26 78
                                          (|Vector| 78) (|Vector| 78) 80)
              (221 . |map|) (227 . |inverse|) (232 . |coerce|) (237 . *)
              (|Record| (|:| |num| 26) (|:| |den| 8))
              (|MatrixCommonDenominator| 8 78) (243 . |splitDenominator|)
              (|Record| (|:| |num| 41) (|:| |den| 6))
              (|InnerCommonDenominator| 6 7 41 44) (248 . |splitDenominator|)
              (253 . |reduce|) (|List| 8) (259 . |parts|) (264 . |degree|)
              (269 . |max|) (|Mapping| 23 23 23) (|List| 23) (275 . |reduce|)
              (281 . |coefficient|) (|Mapping| 7 8)
              (|MatrixCategoryFunctions2| 8 (|Vector| 8) (|Vector| 8) 26 7 19
                                          19 17)
              (287 . |map|) (293 . *) |FRIDEAL;ideal;V$;15| |FRIDEAL;inv;2$;14|
              (|CommonDenominator| 6 7 19) (299 . |commonDenominator|)
              (304 . |lcm|) (|List| 9) (310 . |removeDuplicates|) (315 . |quo|)
              (321 . ~=) (327 . |inv|) (332 . |zero?|) (337 . |concat|)
              (343 . |minIndex|) (348 . |elt|) (354 . *) (360 . |coefficients|)
              (365 . *) |FRIDEAL;*;3$;19| |FRIDEAL;^;$I$;20| (371 . ^)
              (377 . ^) (|OutputForm|) (383 . |coerce|) (388 . |paren|)
              |FRIDEAL;basis;$V;22| (393 . |coerce|) (398 . |coerce|) (403 . /)
              (409 . *) |FRIDEAL;coerce;$Of;23| (415 . |random|) (419 . +)
              (425 . |Zero|) (429 . *) |FRIDEAL;minimize;2$;26| (|HashState|)
              (|String|) (|SingleInteger|))
           '#(~= 435 |sample| 441 |rightRecip| 445 |rightPower| 450 |recip| 462
              |randomLC| 467 |one?| 473 |numer| 478 |norm| 483 |minimize| 488
              |leftRecip| 493 |leftPower| 498 |latex| 510 |inv| 515 |ideal| 520
              |hashUpdate!| 525 |hash| 531 |denom| 536 |conjugate| 541
              |commutator| 547 |coerce| 553 |basis| 558 ^ 563 |One| 581 = 585 /
              591 * 597)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|Group&| NIL NIL |MagmaWithUnit&| |Magma&| |SetCategory&|
                     NIL NIL |BasicType&| NIL)
                  (CONS
                   '#((|Group|) (|Monoid|) (|SemiGroup|) (|MagmaWithUnit|)
                      (|Magma|) (|SetCategory|) (|unitsKnown|)
                      (|TwoSidedRecip|) (|BasicType|) (|CoercibleTo| 127))
                   (|makeByteWordVec2| 143
                                       '(0 6 0 12 0 9 0 13 1 17 0 0 18 1 9 19 0
                                         20 2 17 19 0 19 21 1 9 0 19 22 2 8 0 7
                                         23 24 1 9 17 0 25 2 28 26 27 17 29 1 9
                                         30 0 31 2 14 32 33 0 34 2 6 32 0 0 35
                                         2 14 32 0 0 36 0 6 0 38 2 6 0 0 0 39 3
                                         41 6 40 0 6 42 1 26 8 0 43 1 8 44 0 45
                                         1 7 6 0 46 1 6 0 47 48 0 9 49 50 2 6 0
                                         0 49 51 2 7 0 6 6 52 0 9 23 53 0 7 0
                                         54 0 55 0 56 1 14 57 0 58 2 55 0 9 23
                                         59 2 55 0 0 0 60 0 61 0 62 1 9 0 57 63
                                         3 55 0 0 61 9 64 1 55 9 0 65 1 9 7 0
                                         66 2 0 9 23 14 68 2 6 69 0 0 70 1 6 32
                                         0 71 1 7 0 6 72 1 9 0 7 73 2 26 0 0 0
                                         74 2 76 26 75 0 77 1 78 0 8 79 2 82 80
                                         81 26 83 1 80 69 0 84 1 8 0 7 85 2 80
                                         0 78 0 86 1 88 87 80 89 1 91 90 44 92
                                         2 41 6 40 0 93 1 26 94 0 95 1 8 23 0
                                         96 2 23 0 0 0 97 2 99 23 98 0 100 2 8
                                         7 0 23 101 2 103 17 102 26 104 2 9 0 7
                                         0 105 1 108 6 19 109 2 6 0 0 0 110 1
                                         111 0 0 112 2 6 0 0 0 113 2 6 32 0 0
                                         114 1 7 0 0 115 1 9 32 0 116 2 14 0 9
                                         0 117 1 19 57 0 118 2 19 7 0 57 119 2
                                         55 0 0 0 120 1 55 111 0 121 2 6 0 0 0
                                         122 2 9 0 0 23 125 2 6 0 0 23 126 1 9
                                         127 0 128 1 127 0 47 129 1 57 127 0
                                         131 1 6 127 0 132 2 127 0 0 0 133 2
                                         127 0 0 0 134 0 7 0 136 2 9 0 0 0 137
                                         0 9 0 138 2 9 0 57 0 139 2 0 32 0 0 1
                                         0 0 0 1 1 0 69 0 1 2 0 0 0 23 1 2 0 0
                                         0 49 1 1 0 69 0 1 2 0 9 23 14 68 1 0
                                         32 0 1 1 0 14 0 15 1 0 7 0 67 1 0 0 0
                                         140 1 0 69 0 1 2 0 0 0 23 1 2 0 0 0 49
                                         1 1 0 142 0 1 1 0 0 0 107 1 0 0 14 106
                                         2 0 141 141 0 1 1 0 143 0 1 1 0 6 0 16
                                         2 0 0 0 0 1 2 0 0 0 0 1 1 0 127 0 135
                                         1 0 14 0 130 2 0 0 0 57 124 2 0 0 0 23
                                         1 2 0 0 0 49 1 0 0 0 11 2 0 32 0 0 37
                                         2 0 0 0 0 1 2 0 0 0 0 123)))))
           '|lookupComplete|)) 


(SDEFUN |INTFACT;squareFree;IF;1| ((|n| (I)) ($ (|Factored| I)))
        (SPROG
         ((|y|
           #1=(|List|
               (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                         (|:| |factor| I)
                         (|:| |exponent| (|NonNegativeInteger|)))))
          (|v| (|Union| I "failed")) (|m| (I)) (|x| (|Factored| I)) (|lim| (I))
          (#2=#:G736 NIL) (#3=#:G737 NIL) (|l| #1#) (|sv| (|Factored| I))
          (|rec| NIL) (|u| (I)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |n| (|spadConstant| $ 7) (QREFELT $ 11))
              (SEQ (LETT |m| (SPADCALL |n| (QREFELT $ 12)))
                   (EXIT
                    (LETT |u|
                          (SPADCALL (|spadConstant| $ 13) (QREFELT $ 12))))))
             (#4='T
              (SEQ (LETT |m| |n|) (EXIT (LETT |u| (|spadConstant| $ 13))))))
            (COND
             ((SPADCALL |m| (|spadConstant| $ 13) (QREFELT $ 15))
              (SEQ (LETT |v| (SPADCALL |m| (QREFELT $ 18)))
                   (EXIT
                    (COND
                     ((QEQCAR |v| 0)
                      (PROGN
                       (LETT #2#
                             (SEQ
                              (SEQ (LETT |rec| NIL)
                                   (LETT #3#
                                         (LETT |l|
                                               (SPADCALL
                                                (LETT |sv|
                                                      (SPADCALL (QCDR |v|)
                                                                (QREFELT $
                                                                         19)))
                                                (QREFELT $ 23))))
                                   G190
                                   (COND
                                    ((OR (ATOM #3#)
                                         (PROGN (LETT |rec| (CAR #3#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (QSETVELT |rec| 2 (* 2 (QVELT |rec| 2)))))
                                   (LETT #3# (CDR #3#)) (GO G190) G191
                                   (EXIT NIL))
                              (EXIT
                               (SPADCALL
                                (SPADCALL |u| (SPADCALL |sv| (QREFELT $ 24))
                                          (QREFELT $ 25))
                                |l| (QREFELT $ 26)))))
                       (GO #5=#:G734))))))))
            (LETT |lim|
                  (SPADCALL (|spadConstant| $ 13)
                            (SPADCALL |m| 3 (QREFELT $ 28)) (QREFELT $ 29)))
            (EXIT
             (COND
              ((SPADCALL |lim| (SPADCALL 100000 (QREFELT $ 31)) (QREFELT $ 15))
               (SPADCALL |u|
                         (SPADCALL (SPADCALL |m| (QREFELT $ 32))
                                   (QREFELT $ 23))
                         (QREFELT $ 26)))
              (#4#
               (SEQ (LETT |x| (|INTFACT;BasicSieve| |m| |lim| $))
                    (LETT |y|
                          (SEQ (LETT |m| (SPADCALL |x| (QREFELT $ 24)))
                               (EXIT
                                (COND
                                 ((SPADCALL |m| (|spadConstant| $ 13)
                                            (QREFELT $ 33))
                                  (SPADCALL |x| (QREFELT $ 23)))
                                 (#4#
                                  (SEQ (LETT |v| (SPADCALL |m| (QREFELT $ 18)))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |v| 0)
                                          (CONS
                                           (VECTOR (CONS 1 "sqfr") (QCDR |v|)
                                                   2)
                                           (SPADCALL |x| (QREFELT $ 23))))
                                         (#4#
                                          (CONS (VECTOR (CONS 1 "sqfr") |m| 1)
                                                (SPADCALL |x|
                                                          (QREFELT $
                                                                   23))))))))))))
                    (EXIT (SPADCALL |u| |y| (QREFELT $ 26)))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |INTFACT;PollardSmallFactor;IU;2| ((|n| (I)) ($ (|Union| I "failed")))
        (SPROG
         ((G (I)) (|x| (I)) (|y| (I)) (#1=#:G773 NIL) (#2=#:G772 NIL) (|i| NIL)
          (|l| (I)) (|ys| (I)) (#3=#:G771 NIL) (|r| (I)) (|k| (I)) (|q| (I))
          (#4=#:G770 NIL) (#5=#:G769 NIL) (#6=#:G768 NIL) (#7=#:G767 NIL)
          (|m| (I)) (|x0| (I)))
         (SEQ (LETT |x0| (SPADCALL |n| (QREFELT $ 34)))
              (LETT |m| (SPADCALL 100 (QREFELT $ 31))) (LETT |y| |x0|)
              (LETT |r| (|spadConstant| $ 13)) (LETT |q| (|spadConstant| $ 13))
              (LETT G (|spadConstant| $ 13))
              (SEQ (LETT #7# NIL) G190 (COND (#7# (GO G191)))
                   (SEQ (LETT |x| |y|) (LETT |ys| |y|)
                        (SEQ (LETT |i| 1)
                             (LETT #6# (SPADCALL |r| (QREFELT $ 35))) G190
                             (COND ((|greater_SI| |i| #6#) (GO G191)))
                             (SEQ
                              (LETT |y|
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL |y| |y| (QREFELT $ 25))
                                      (SPADCALL 5 (QREFELT $ 31))
                                      (QREFELT $ 29))
                                     |n| (QREFELT $ 36)))
                              (EXIT
                               (LETT |q|
                                     (SPADCALL
                                      (SPADCALL |q|
                                                (SPADCALL
                                                 (SPADCALL |x| |y|
                                                           (QREFELT $ 37))
                                                 (QREFELT $ 38))
                                                (QREFELT $ 25))
                                      |n| (QREFELT $ 36)))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |k| (|spadConstant| $ 7))
                        (LETT G (SPADCALL |q| |n| (QREFELT $ 39)))
                        (SEQ (LETT #5# NIL) G190 (COND (#5# (GO G191)))
                             (SEQ (LETT |ys| |y|)
                                  (SEQ (LETT |i| 1)
                                       (LETT #4#
                                             (SPADCALL
                                              (SPADCALL |m|
                                                        (SPADCALL |r| |k|
                                                                  (QREFELT $
                                                                           37))
                                                        (QREFELT $ 40))
                                              (QREFELT $ 35)))
                                       G190
                                       (COND
                                        ((|greater_SI| |i| #4#) (GO G191)))
                                       (SEQ
                                        (LETT |y|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL |y| |y|
                                                          (QREFELT $ 25))
                                                (SPADCALL 5 (QREFELT $ 31))
                                                (QREFELT $ 29))
                                               |n| (QREFELT $ 36)))
                                        (EXIT
                                         (LETT |q|
                                               (SPADCALL
                                                (SPADCALL |q|
                                                          (SPADCALL
                                                           (SPADCALL |x| |y|
                                                                     (QREFELT $
                                                                              37))
                                                           (QREFELT $ 38))
                                                          (QREFELT $ 25))
                                                |n| (QREFELT $ 36)))))
                                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                       (EXIT NIL))
                                  (LETT G (SPADCALL |q| |n| (QREFELT $ 39)))
                                  (EXIT
                                   (LETT |k|
                                         (SPADCALL |k| |m| (QREFELT $ 29)))))
                             (LETT #5#
                                   (COND ((SPADCALL |k| |r| (QREFELT $ 41)) 'T)
                                         ('T
                                          (SPADCALL G (|spadConstant| $ 13)
                                                    (QREFELT $ 15)))))
                             (GO G190) G191 (EXIT NIL))
                        (LETT |k| (SPADCALL |k| |r| (QREFELT $ 29)))
                        (EXIT (LETT |r| (SPADCALL 2 |r| (QREFELT $ 43)))))
                   (LETT #7# (SPADCALL G (|spadConstant| $ 13) (QREFELT $ 15)))
                   (GO G190) G191 (EXIT NIL))
              (COND
               ((SPADCALL G |n| (QREFELT $ 33))
                (SEQ (LETT |l| (SPADCALL |k| |m| (QREFELT $ 37)))
                     (LETT G (|spadConstant| $ 13))
                     (SEQ (LETT #3# NIL) G190 (COND (#3# (GO G191)))
                          (SEQ
                           (LETT |ys|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |ys| |ys| (QREFELT $ 25))
                                            (SPADCALL 5 (QREFELT $ 31))
                                            (QREFELT $ 29))
                                  |n| (QREFELT $ 36)))
                           (LETT G
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |x| |ys| (QREFELT $ 37))
                                            (QREFELT $ 38))
                                  |n| (QREFELT $ 39)))
                           (EXIT
                            (LETT |l|
                                  (SPADCALL |l| (|spadConstant| $ 13)
                                            (QREFELT $ 29)))))
                          (LETT #3#
                                (SPADCALL G (|spadConstant| $ 13)
                                          (QREFELT $ 15)))
                          (GO G190) G191 (EXIT NIL))
                     (EXIT
                      (COND
                       ((SPADCALL G |n| (QREFELT $ 33))
                        (SEQ (LETT |y| |x0|) (LETT |x| |x0|)
                             (SEQ (LETT |i| 1)
                                  (LETT #2# (SPADCALL |l| (QREFELT $ 35))) G190
                                  (COND ((|greater_SI| |i| #2#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT |y|
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |y| |y| (QREFELT $ 25))
                                            (SPADCALL 5 (QREFELT $ 31))
                                            (QREFELT $ 29))
                                           |n| (QREFELT $ 36)))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT NIL))
                             (LETT G
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |x| |y| (QREFELT $ 37))
                                              (QREFELT $ 38))
                                    |n| (QREFELT $ 39)))
                             (EXIT
                              (SEQ (LETT #1# NIL) G190 (COND (#1# (GO G191)))
                                   (SEQ
                                    (LETT |y|
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |y| |y| (QREFELT $ 25))
                                            (SPADCALL 5 (QREFELT $ 31))
                                            (QREFELT $ 29))
                                           |n| (QREFELT $ 36)))
                                    (LETT |x|
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |x| |x| (QREFELT $ 25))
                                            (SPADCALL 5 (QREFELT $ 31))
                                            (QREFELT $ 29))
                                           |n| (QREFELT $ 36)))
                                    (EXIT
                                     (LETT G
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |x| |y| (QREFELT $ 37))
                                             (QREFELT $ 38))
                                            |n| (QREFELT $ 39)))))
                                   (LETT #1#
                                         (SPADCALL G (|spadConstant| $ 13)
                                                   (QREFELT $ 15)))
                                   (GO G190) G191 (EXIT NIL))))))))))
              (EXIT
               (COND ((SPADCALL G |n| (QREFELT $ 33)) (CONS 1 "failed"))
                     ('T (CONS 0 G))))))) 

(SDEFUN |INTFACT;PollardSmallFactor20| ((|n| (I)) ($ (|Union| I "failed")))
        (SPROG ((#1=#:G782 NIL) (|r| (|Union| I "failed")) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| 1) G190
                       (COND ((|greater_SI| |i| 20) (GO G191)))
                       (SEQ (LETT |r| (SPADCALL |n| (QREFELT $ 44)))
                            (EXIT
                             (COND
                              ((QEQCAR |r| 0)
                               (PROGN (LETT #1# |r|) (GO #2=#:G781))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT |r|)))
                #2# (EXIT #1#)))) 

(SDEFUN |INTFACT;BasicSieve| ((|r| (I)) (|lim| (I)) ($ (|Factored| I)))
        (SPROG
         ((|d| (I))
          (|ls|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| I)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|n| (I)) (|m| NIL) (#1=#:G798 NIL) (#2=#:G799 NIL) (|s| NIL)
          (|l| (|List| I)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |l|
                  (LIST (|spadConstant| $ 13) (SPADCALL 2 (QREFELT $ 31))
                        (SPADCALL 2 (QREFELT $ 31)) (SPADCALL 4 (QREFELT $ 31))
                        (SPADCALL 2 (QREFELT $ 31)) (SPADCALL 4 (QREFELT $ 31))
                        (SPADCALL 2 (QREFELT $ 31)) (SPADCALL 4 (QREFELT $ 31))
                        (SPADCALL 6 (QREFELT $ 31)) (SPADCALL 2 (QREFELT $ 31))
                        (SPADCALL 6 (QREFELT $ 31))))
            (SPADCALL |l| (SPADCALL |l| 3 (QREFELT $ 46)) (QREFELT $ 47))
            (LETT |d| (SPADCALL 2 (QREFELT $ 31))) (LETT |n| |r|)
            (LETT |ls| NIL)
            (EXIT
             (SEQ (LETT |s| NIL) (LETT #2# |l|) G190
                  (COND
                   ((OR (ATOM #2#) (PROGN (LETT |s| (CAR #2#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (COND
                     ((SPADCALL |d| |lim| (QREFELT $ 15))
                      (PROGN
                       (LETT #1# (SPADCALL |n| |ls| (QREFELT $ 26)))
                       (GO #3=#:G797)))
                     ('T
                      (SEQ
                       (COND
                        ((SPADCALL |n| (SPADCALL |d| |d| (QREFELT $ 25))
                                   (QREFELT $ 11))
                         (SEQ
                          (COND
                           ((SPADCALL |n| (|spadConstant| $ 13) (QREFELT $ 15))
                            (LETT |ls|
                                  (CONS (VECTOR (CONS 3 "prime") |n| 1)
                                        |ls|))))
                          (EXIT
                           (PROGN
                            (LETT #1#
                                  (SPADCALL (|spadConstant| $ 13) |ls|
                                            (QREFELT $ 26)))
                            (GO #3#))))))
                       (SEQ (LETT |m| 0) G190
                            (COND
                             ((NULL
                               (SPADCALL (SPADCALL |n| |d| (QREFELT $ 36))
                                         (QREFELT $ 48)))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |n| (SPADCALL |n| |d| (QREFELT $ 49)))))
                            (LETT |m| (|inc_SI| |m|)) (GO G190) G191
                            (EXIT NIL))
                       (COND
                        ((> |m| 0)
                         (LETT |ls|
                               (CONS (VECTOR (CONS 3 "prime") |d| |m|) |ls|))))
                       (EXIT (LETT |d| (SPADCALL |d| |s| (QREFELT $ 29)))))))))
                  (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL)))))
          #3# (EXIT #1#)))) 

(SDEFUN |INTFACT;BasicMethod;IF;5| ((|n| (I)) ($ (|Factored| I)))
        (SPROG ((|x| (|Factored| I)) (|u| (I)) (|m| (I)))
               (SEQ
                (COND
                 ((SPADCALL |n| (|spadConstant| $ 7) (QREFELT $ 11))
                  (SEQ (LETT |m| (SPADCALL |n| (QREFELT $ 12)))
                       (EXIT
                        (LETT |u|
                              (SPADCALL (|spadConstant| $ 13)
                                        (QREFELT $ 12))))))
                 ('T
                  (SEQ (LETT |m| |n|)
                       (EXIT (LETT |u| (|spadConstant| $ 13))))))
                (LETT |x|
                      (|INTFACT;BasicSieve| |m|
                       (SPADCALL (|spadConstant| $ 13)
                                 (SPADCALL |m| (QREFELT $ 50)) (QREFELT $ 29))
                       $))
                (EXIT
                 (SPADCALL |u| (SPADCALL |x| (QREFELT $ 23)) (QREFELT $ 26)))))) 

(SDEFUN |INTFACT;factor;IF;6| ((|m| (I)) ($ (|Factored| I)))
        (SPROG
         ((|flb|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| I)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|c| (|NonNegativeInteger|)) (|n| (I)) (|d| (|Union| I "failed"))
          (|y| (|Union| I "failed")) (|x| (I))
          (|s|
           (|Record| (|:| |base| I) (|:| |exponent| (|NonNegativeInteger|))))
          (|f| #1=(|ListMultiDictionary| I)) (|b| #1#) (|a| #1#) (|u| (I)))
         (SEQ
          (COND ((SPADCALL |m| (QREFELT $ 48)) (|spadConstant| $ 9))
                (#2='T
                 (SEQ
                  (COND
                   ((SPADCALL |m| (QREFELT $ 52))
                    (SEQ (LETT |n| (SPADCALL |m| (QREFELT $ 12)))
                         (EXIT
                          (LETT |u|
                                (SPADCALL (|spadConstant| $ 13)
                                          (QREFELT $ 12))))))
                   (#2#
                    (SEQ (LETT |n| |m|)
                         (EXIT (LETT |u| (|spadConstant| $ 13))))))
                  (LETT |b|
                        (|INTFACT;BasicSieve| |n|
                         (SPADCALL 10000 (QREFELT $ 31)) $))
                  (LETT |flb| (SPADCALL |b| (QREFELT $ 23)))
                  (LETT |n| (SPADCALL |b| (QREFELT $ 24)))
                  (EXIT
                   (COND
                    ((SPADCALL |n| (|spadConstant| $ 13) (QREFELT $ 33))
                     (SPADCALL |u| |flb| (QREFELT $ 26)))
                    (#2#
                     (SEQ (LETT |a| (SPADCALL (QREFELT $ 54)))
                          (LETT |b| (SPADCALL (QREFELT $ 54)))
                          (LETT |f| (SPADCALL (QREFELT $ 54)))
                          (SPADCALL |n| |a| (QREFELT $ 55))
                          (SEQ G190
                               (COND
                                ((NULL (NULL (SPADCALL |a| (QREFELT $ 56))))
                                 (GO G191)))
                               (SEQ (LETT |n| (SPADCALL |a| (QREFELT $ 57)))
                                    (LETT |c|
                                          (SPADCALL |n| |a| (QREFELT $ 58)))
                                    (SPADCALL |n| |a| (QREFELT $ 59))
                                    (EXIT
                                     (COND
                                      ((SPADCALL |n| (QREFELT $ 61))
                                       (SPADCALL |n| |b| |c| (QREFELT $ 62)))
                                      ((>
                                        (QCDR
                                         (LETT |s|
                                               (SPADCALL |n| (QREFELT $ 64))))
                                        1)
                                       (SPADCALL (QCAR |s|) |a|
                                                 (* |c| (QCDR |s|))
                                                 (QREFELT $ 62)))
                                      ('T
                                       (SEQ
                                        (LETT |x|
                                              (SPADCALL |n| (QREFELT $ 50)))
                                        (COND
                                         ((SPADCALL
                                           (SPADCALL |x| 2 (QREFELT $ 66)) |n|
                                           (QREFELT $ 11))
                                          (LETT |x|
                                                (SPADCALL |x|
                                                          (|spadConstant| $ 13)
                                                          (QREFELT $ 29)))))
                                        (LETT |y|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL |x| 2 (QREFELT $ 66))
                                                |n| (QREFELT $ 37))
                                               (QREFELT $ 18)))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |y| 0)
                                           (SEQ
                                            (SPADCALL
                                             (SPADCALL |x| (QCDR |y|)
                                                       (QREFELT $ 29))
                                             |a| |c| (QREFELT $ 62))
                                            (EXIT
                                             (SPADCALL
                                              (SPADCALL |x| (QCDR |y|)
                                                        (QREFELT $ 37))
                                              |a| |c| (QREFELT $ 62)))))
                                          ('T
                                           (SEQ
                                            (LETT |d|
                                                  (|INTFACT;PollardSmallFactor20|
                                                   |n| $))
                                            (EXIT
                                             (COND
                                              ((QEQCAR |d| 0)
                                               (SEQ
                                                (SEQ (LETT |m| 0) G190
                                                     (COND
                                                      ((NULL
                                                        (SPADCALL
                                                         (SPADCALL |n|
                                                                   (QCDR |d|)
                                                                   (QREFELT $
                                                                            36))
                                                         (QREFELT $ 48)))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT |n|
                                                             (SPADCALL |n|
                                                                       (QCDR
                                                                        |d|)
                                                                       (QREFELT
                                                                        $
                                                                        49)))))
                                                     (LETT |m| (|inc_SI| |m|))
                                                     (GO G190) G191 (EXIT NIL))
                                                (SPADCALL (QCDR |d|) |a|
                                                          (* |m| |c|)
                                                          (QREFELT $ 62))
                                                (EXIT
                                                 (COND
                                                  ((SPADCALL |n|
                                                             (|spadConstant| $
                                                                             13)
                                                             (QREFELT $ 15))
                                                   (SPADCALL |n| |a| |c|
                                                             (QREFELT $
                                                                      62)))))))
                                              ('T
                                               (SPADCALL |n| |f| |c|
                                                         (QREFELT $
                                                                  62))))))))))))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (SEQ G190
                               (COND
                                ((NULL (NULL (SPADCALL |b| (QREFELT $ 56))))
                                 (GO G191)))
                               (SEQ (LETT |n| (SPADCALL |b| (QREFELT $ 57)))
                                    (LETT |c|
                                          (SPADCALL |n| |b| (QREFELT $ 58)))
                                    (SPADCALL |n| |b| (QREFELT $ 59))
                                    (EXIT
                                     (LETT |flb|
                                           (CONS
                                            (VECTOR (CONS 3 "prime") |n| |c|)
                                            |flb|))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (SEQ G190
                               (COND
                                ((NULL (NULL (SPADCALL |f| (QREFELT $ 56))))
                                 (GO G191)))
                               (SEQ (LETT |n| (SPADCALL |f| (QREFELT $ 57)))
                                    (LETT |c|
                                          (SPADCALL |n| |f| (QREFELT $ 58)))
                                    (SPADCALL |n| |f| (QREFELT $ 59))
                                    (EXIT
                                     (LETT |flb|
                                           (CONS
                                            (VECTOR (CONS 0 "nil") |n| |c|)
                                            |flb|))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (EXIT (SPADCALL |u| |flb| (QREFELT $ 26))))))))))))) 

(DECLAIM (NOTINLINE |IntegerFactorizationPackage;|)) 

(DEFUN |IntegerFactorizationPackage| (#1=#:G839)
  (SPROG NIL
         (PROG (#2=#:G840)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IntegerFactorizationPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|IntegerFactorizationPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|IntegerFactorizationPackage|)))))))))) 

(DEFUN |IntegerFactorizationPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IntegerFactorizationPackage| DV$1))
          (LETT $ (GETREFV 67))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegerFactorizationPackage|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IntegerFactorizationPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|)
              (|Factored| 6) (4 . |Zero|) (|Boolean|) (8 . <) (14 . -)
              (19 . |One|) (23 . |One|) (27 . >) (|Union| 6 '"failed")
              (|IntegerRoots| 6) (33 . |perfectSqrt|) |INTFACT;squareFree;IF;1|
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 20) (|:| |factor| 6) (|:| |exponent| 27))
              (|List| 21) (38 . |factorList|) (43 . |unit|) (48 . *)
              (54 . |makeFR|) (|NonNegativeInteger|) (60 . |approxNthRoot|)
              (66 . +) (|Integer|) (72 . |coerce|) |INTFACT;factor;IF;6|
              (77 . =) (83 . |random|) (88 . |convert|) (93 . |rem|) (99 . -)
              (105 . |abs|) (110 . |gcd|) (116 . |min|) (122 . >=)
              (|PositiveInteger|) (128 . *) |INTFACT;PollardSmallFactor;IU;2|
              (|List| 6) (134 . |rest|) (140 . |concat!|) (146 . |zero?|)
              (151 . |quo|) (157 . |approxSqrt|) |INTFACT;BasicMethod;IF;5|
              (162 . |negative?|) (|ListMultiDictionary| 6)
              (167 . |dictionary|) (171 . |insert!|) (177 . |empty?|)
              (182 . |inspect|) (187 . |count|) (193 . |remove!|)
              (|IntegerPrimesPackage| 6) (199 . |prime?|) (204 . |insert!|)
              (|Record| (|:| |base| 6) (|:| |exponent| 27))
              (211 . |perfectNthRoot|) (216 . |base|) (220 . ^))
           '#(|squareFree| 226 |factor| 231 |PollardSmallFactor| 236
              |BasicMethod| 241)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|factor| ((|Factored| |#1|) |#1|)) T)
                                   '((|squareFree| ((|Factored| |#1|) |#1|)) T)
                                   '((|BasicMethod| ((|Factored| |#1|) |#1|))
                                     T)
                                   '((|PollardSmallFactor|
                                      ((|Union| |#1| "failed") |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 66
                                            '(0 6 0 7 0 8 0 9 2 6 10 0 0 11 1 6
                                              0 0 12 0 6 0 13 0 8 0 14 2 6 10 0
                                              0 15 1 17 16 6 18 1 8 22 0 23 1 8
                                              6 0 24 2 6 0 0 0 25 2 8 0 6 22 26
                                              2 17 6 6 27 28 2 6 0 0 0 29 1 6 0
                                              30 31 2 6 10 0 0 33 1 6 0 0 34 1
                                              6 30 0 35 2 6 0 0 0 36 2 6 0 0 0
                                              37 1 6 0 0 38 2 6 0 0 0 39 2 6 0
                                              0 0 40 2 6 10 0 0 41 2 6 0 42 0
                                              43 2 45 0 0 27 46 2 45 0 0 0 47 1
                                              6 10 0 48 2 6 0 0 0 49 1 17 6 6
                                              50 1 6 10 0 52 0 53 0 54 2 53 0 6
                                              0 55 1 53 10 0 56 1 53 6 0 57 2
                                              53 27 6 0 58 2 53 0 6 0 59 1 60
                                              10 6 61 3 53 0 6 0 27 62 1 17 63
                                              6 64 0 6 0 65 2 6 0 0 42 66 1 0 8
                                              6 19 1 0 8 6 32 1 0 16 6 44 1 0 8
                                              6 51)))))
           '|lookupComplete|)) 

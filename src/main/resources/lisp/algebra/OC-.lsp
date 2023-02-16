
(SDEFUN |OC-;characteristic;Nni;1| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 9))) 

(PUT '|OC-;rank;Pi;2| '|SPADreplace| '(XLAM NIL 8)) 

(SDEFUN |OC-;rank;Pi;2| (($ (|PositiveInteger|))) 8) 

(SDEFUN |OC-;coordinates;SV;3| ((|x| (S)) ($ (|Vector| R)))
        (SPADCALL
         (LIST (SPADCALL |x| (QREFELT $ 13)) (SPADCALL |x| (QREFELT $ 14))
               (SPADCALL |x| (QREFELT $ 15)) (SPADCALL |x| (QREFELT $ 16))
               (SPADCALL |x| (QREFELT $ 17)) (SPADCALL |x| (QREFELT $ 18))
               (SPADCALL |x| (QREFELT $ 19)) (SPADCALL |x| (QREFELT $ 20)))
         (QREFELT $ 23))) 

(SDEFUN |OC-;represents;VS;4| ((|v| (|Vector| R)) ($ (S)))
        (SPADCALL (SPADCALL |v| 1 (QREFELT $ 27))
                  (SPADCALL |v| 2 (QREFELT $ 27))
                  (SPADCALL |v| 3 (QREFELT $ 27))
                  (SPADCALL |v| 4 (QREFELT $ 27))
                  (SPADCALL |v| 5 (QREFELT $ 27))
                  (SPADCALL |v| 6 (QREFELT $ 27))
                  (SPADCALL |v| 7 (QREFELT $ 27))
                  (SPADCALL |v| 8 (QREFELT $ 27)) (QREFELT $ 28))) 

(SDEFUN |OC-;basis;V;5| (($ (|Vector| S)))
        (SPROG ((|i| NIL) (|vv| (|Vector| R)) (|res| (|Vector| S)))
               (SEQ (LETT |res| (SPADCALL 8 (QREFELT $ 31)))
                    (LETT |vv| (SPADCALL 8 (QREFELT $ 32)))
                    (SEQ (LETT |i| 1) G190
                         (COND ((|greater_SI| |i| 8) (GO G191)))
                         (SEQ
                          (SPADCALL |vv| |i| (|spadConstant| $ 25)
                                    (QREFELT $ 33))
                          (SPADCALL |res| |i| (SPADCALL |vv| (QREFELT $ 34))
                                    (QREFELT $ 35))
                          (EXIT
                           (SPADCALL |vv| |i| (|spadConstant| $ 37)
                                     (QREFELT $ 33))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |OC-;conjugate;2S;6| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 13))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 40))
                  (QREFELT $ 28))) 

(SDEFUN |OC-;map;M2S;7| ((|fn| (|Mapping| R R)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 13)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 14)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 15)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 16)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 17)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 18)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 19)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 20)) |fn|) (QREFELT $ 28))) 

(SDEFUN |OC-;norm;SR;8| ((|x| (S)) ($ (R)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL
             (SPADCALL
              (SPADCALL
               (SPADCALL (SPADCALL |x| (QREFELT $ 13))
                         (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 44))
               (SPADCALL (SPADCALL |x| (QREFELT $ 14))
                         (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 44))
               (QREFELT $ 45))
              (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                        (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 44))
              (QREFELT $ 45))
             (SPADCALL (SPADCALL |x| (QREFELT $ 16))
                       (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 44))
             (QREFELT $ 45))
            (SPADCALL (SPADCALL |x| (QREFELT $ 17))
                      (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 44))
            (QREFELT $ 45))
           (SPADCALL (SPADCALL |x| (QREFELT $ 18))
                     (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 44))
           (QREFELT $ 45))
          (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (SPADCALL |x| (QREFELT $ 19))
                    (QREFELT $ 44))
          (QREFELT $ 45))
         (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (SPADCALL |x| (QREFELT $ 20))
                   (QREFELT $ 44))
         (QREFELT $ 45))) 

(SDEFUN |OC-;=;2SB;9| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 13)) (SPADCALL |y| (QREFELT $ 13))
                    (QREFELT $ 48))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 14))
                      (SPADCALL |y| (QREFELT $ 14)) (QREFELT $ 48))
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 15))
                        (SPADCALL |y| (QREFELT $ 15)) (QREFELT $ 48))
              (COND
               ((SPADCALL (SPADCALL |x| (QREFELT $ 16))
                          (SPADCALL |y| (QREFELT $ 16)) (QREFELT $ 48))
                (COND
                 ((SPADCALL (SPADCALL |x| (QREFELT $ 17))
                            (SPADCALL |y| (QREFELT $ 17)) (QREFELT $ 48))
                  (COND
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 18))
                              (SPADCALL |y| (QREFELT $ 18)) (QREFELT $ 48))
                    (COND
                     ((SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                (SPADCALL |y| (QREFELT $ 19)) (QREFELT $ 48))
                      (SPADCALL (SPADCALL |x| (QREFELT $ 20))
                                (SPADCALL |y| (QREFELT $ 20)) (QREFELT $ 48)))
                     (#1='T NIL)))
                   (#1# NIL)))
                 (#1# NIL)))
               (#1# NIL)))
             (#1# NIL)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |OC-;+;3S;10| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (SPADCALL |y| (QREFELT $ 13))
                   (QREFELT $ 45))
         (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (SPADCALL |y| (QREFELT $ 14))
                   (QREFELT $ 45))
         (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (SPADCALL |y| (QREFELT $ 15))
                   (QREFELT $ 45))
         (SPADCALL (SPADCALL |x| (QREFELT $ 16)) (SPADCALL |y| (QREFELT $ 16))
                   (QREFELT $ 45))
         (SPADCALL (SPADCALL |x| (QREFELT $ 17)) (SPADCALL |y| (QREFELT $ 17))
                   (QREFELT $ 45))
         (SPADCALL (SPADCALL |x| (QREFELT $ 18)) (SPADCALL |y| (QREFELT $ 18))
                   (QREFELT $ 45))
         (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (SPADCALL |y| (QREFELT $ 19))
                   (QREFELT $ 45))
         (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (SPADCALL |y| (QREFELT $ 20))
                   (QREFELT $ 45))
         (QREFELT $ 28))) 

(SDEFUN |OC-;-;2S;11| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 40))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 40))
                  (QREFELT $ 28))) 

(SDEFUN |OC-;*;R2S;12| ((|r| (R)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |r| (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 44))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 44))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 44))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 44))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 44))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 44))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 44))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 44))
                  (QREFELT $ 28))) 

(SDEFUN |OC-;*;I2S;13| ((|n| (|Integer|)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |n| (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 53))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 53))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 53))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 53))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 53))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 53))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 53))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 53))
                  (QREFELT $ 28))) 

(SDEFUN |OC-;coerce;RS;14| ((|r| (R)) ($ (S)))
        (SPADCALL |r| (|spadConstant| $ 37) (|spadConstant| $ 37)
                  (|spadConstant| $ 37) (|spadConstant| $ 37)
                  (|spadConstant| $ 37) (|spadConstant| $ 37)
                  (|spadConstant| $ 37) (QREFELT $ 28))) 

(SDEFUN |OC-;coerce;IS;15| ((|n| (|Integer|)) ($ (S)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 56)) (|spadConstant| $ 37)
                  (|spadConstant| $ 37) (|spadConstant| $ 37)
                  (|spadConstant| $ 37) (|spadConstant| $ 37)
                  (|spadConstant| $ 37) (|spadConstant| $ 37) (QREFELT $ 28))) 

(SDEFUN |OC-;zero?;SB;16| ((|x| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 58))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 58))
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 58))
              (COND
               ((SPADCALL (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 58))
                (COND
                 ((SPADCALL (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 58))
                  (COND
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 58))
                    (COND
                     ((SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 58))
                      (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 58)))
                     (#1='T NIL)))
                   (#1# NIL)))
                 (#1# NIL)))
               (#1# NIL)))
             (#1# NIL)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |OC-;retract;SR;17| ((|x| (S)) ($ (R)))
        (SEQ
         (COND
          ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 58))
           (COND
            ((SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 58))
             (COND
              ((SPADCALL (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 58))
               (COND
                ((SPADCALL (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 58))
                 (COND
                  ((SPADCALL (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 58))
                   (COND
                    ((SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 58))
                     (COND
                      ((NULL
                        (SPADCALL (SPADCALL |x| (QREFELT $ 20))
                                  (QREFELT $ 58)))
                       (EXIT (|error| #1="Cannot retract octonion.")))))
                    (#2='T (EXIT (|error| #1#)))))
                  (#2# (EXIT (|error| #1#)))))
                (#2# (EXIT (|error| #1#)))))
              (#2# (EXIT (|error| #1#)))))
            (#2# (EXIT (|error| #1#)))))
          (#2# (EXIT (|error| #1#))))
         (EXIT (SPADCALL |x| (QREFELT $ 13))))) 

(SDEFUN |OC-;retractIfCan;SU;18| ((|x| (S)) ($ (|Union| R "failed")))
        (SEQ
         (COND
          ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 58))
           (COND
            ((SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 58))
             (COND
              ((SPADCALL (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 58))
               (COND
                ((SPADCALL (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 58))
                 (COND
                  ((SPADCALL (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 58))
                   (COND
                    ((SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 58))
                     (COND
                      ((NULL
                        (SPADCALL (SPADCALL |x| (QREFELT $ 20))
                                  (QREFELT $ 58)))
                       (EXIT (CONS 1 #1="failed")))))
                    (#2='T (EXIT (CONS 1 #1#)))))
                  (#2# (EXIT (CONS 1 #1#)))))
                (#2# (EXIT (CONS 1 #1#)))))
              (#2# (EXIT (CONS 1 #1#)))))
            (#2# (EXIT (CONS 1 #1#)))))
          (#2# (EXIT (CONS 1 #1#))))
         (EXIT (CONS 0 (SPADCALL |x| (QREFELT $ 13)))))) 

(SDEFUN |OC-;coerce;SOf;19| ((|x| (S)) ($ (|OutputForm|)))
        (SPROG ((|part| (|OutputForm|)) (|z| (|OutputForm|)) (|y| (S)))
               (SEQ
                (COND
                 ((SPADCALL |x| (QREFELT $ 63))
                  (SPADCALL (|spadConstant| $ 37) (QREFELT $ 65)))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 58)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 37)
                                   (SPADCALL |x| (QREFELT $ 14))
                                   (SPADCALL |x| (QREFELT $ 15))
                                   (SPADCALL |x| (QREFELT $ 16))
                                   (SPADCALL |x| (QREFELT $ 17))
                                   (SPADCALL |x| (QREFELT $ 18))
                                   (SPADCALL |x| (QREFELT $ 19))
                                   (SPADCALL |x| (QREFELT $ 20))
                                   (QREFELT $ 28)))
                   (EXIT
                    (COND
                     ((SPADCALL |y| (QREFELT $ 63))
                      (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 65)))
                     (#1='T
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 65))
                       (SPADCALL |y| (QREFELT $ 66)) (QREFELT $ 67)))))))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 58)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (SPADCALL |x| (QREFELT $ 15))
                                   (SPADCALL |x| (QREFELT $ 16))
                                   (SPADCALL |x| (QREFELT $ 17))
                                   (SPADCALL |x| (QREFELT $ 18))
                                   (SPADCALL |x| (QREFELT $ 19))
                                   (SPADCALL |x| (QREFELT $ 20))
                                   (QREFELT $ 28)))
                   (LETT |z|
                         (SEQ (LETT |part| (SPADCALL '|i| (QREFELT $ 69)))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |x| (QREFELT $ 14))
                                           (|spadConstant| $ 25)
                                           (QREFELT $ 48))
                                 |part|)
                                (#1#
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 14))
                                            (QREFELT $ 65))
                                  |part| (QREFELT $ 70)))))))
                   (EXIT
                    (COND ((SPADCALL |y| (QREFELT $ 63)) |z|)
                          (#1#
                           (SPADCALL |z| (SPADCALL |y| (QREFELT $ 66))
                                     (QREFELT $ 67)))))))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 58)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (|spadConstant| $ 37)
                                   (SPADCALL |x| (QREFELT $ 16))
                                   (SPADCALL |x| (QREFELT $ 17))
                                   (SPADCALL |x| (QREFELT $ 18))
                                   (SPADCALL |x| (QREFELT $ 19))
                                   (SPADCALL |x| (QREFELT $ 20))
                                   (QREFELT $ 28)))
                   (LETT |z|
                         (SEQ (LETT |part| (SPADCALL '|j| (QREFELT $ 69)))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                           (|spadConstant| $ 25)
                                           (QREFELT $ 48))
                                 |part|)
                                (#1#
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                            (QREFELT $ 65))
                                  |part| (QREFELT $ 70)))))))
                   (EXIT
                    (COND ((SPADCALL |y| (QREFELT $ 63)) |z|)
                          (#1#
                           (SPADCALL |z| (SPADCALL |y| (QREFELT $ 66))
                                     (QREFELT $ 67)))))))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 58)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (SPADCALL |x| (QREFELT $ 17))
                                   (SPADCALL |x| (QREFELT $ 18))
                                   (SPADCALL |x| (QREFELT $ 19))
                                   (SPADCALL |x| (QREFELT $ 20))
                                   (QREFELT $ 28)))
                   (LETT |z|
                         (SEQ (LETT |part| (SPADCALL '|k| (QREFELT $ 69)))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |x| (QREFELT $ 16))
                                           (|spadConstant| $ 25)
                                           (QREFELT $ 48))
                                 |part|)
                                (#1#
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 16))
                                            (QREFELT $ 65))
                                  |part| (QREFELT $ 70)))))))
                   (EXIT
                    (COND ((SPADCALL |y| (QREFELT $ 63)) |z|)
                          (#1#
                           (SPADCALL |z| (SPADCALL |y| (QREFELT $ 66))
                                     (QREFELT $ 67)))))))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 58)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (|spadConstant| $ 37)
                                   (SPADCALL |x| (QREFELT $ 18))
                                   (SPADCALL |x| (QREFELT $ 19))
                                   (SPADCALL |x| (QREFELT $ 20))
                                   (QREFELT $ 28)))
                   (LETT |z|
                         (SEQ (LETT |part| (SPADCALL 'E (QREFELT $ 69)))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |x| (QREFELT $ 17))
                                           (|spadConstant| $ 25)
                                           (QREFELT $ 48))
                                 |part|)
                                (#1#
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 17))
                                            (QREFELT $ 65))
                                  |part| (QREFELT $ 70)))))))
                   (EXIT
                    (COND ((SPADCALL |y| (QREFELT $ 63)) |z|)
                          (#1#
                           (SPADCALL |z| (SPADCALL |y| (QREFELT $ 66))
                                     (QREFELT $ 67)))))))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 58)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (SPADCALL |x| (QREFELT $ 19))
                                   (SPADCALL |x| (QREFELT $ 20))
                                   (QREFELT $ 28)))
                   (LETT |z|
                         (SEQ (LETT |part| (SPADCALL 'I (QREFELT $ 69)))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |x| (QREFELT $ 18))
                                           (|spadConstant| $ 25)
                                           (QREFELT $ 48))
                                 |part|)
                                (#1#
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 18))
                                            (QREFELT $ 65))
                                  |part| (QREFELT $ 70)))))))
                   (EXIT
                    (COND ((SPADCALL |y| (QREFELT $ 63)) |z|)
                          (#1#
                           (SPADCALL |z| (SPADCALL |y| (QREFELT $ 66))
                                     (QREFELT $ 67)))))))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 58)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (|spadConstant| $ 37) (|spadConstant| $ 37)
                                   (|spadConstant| $ 37)
                                   (SPADCALL |x| (QREFELT $ 20))
                                   (QREFELT $ 28)))
                   (LETT |z|
                         (SEQ (LETT |part| (SPADCALL 'J (QREFELT $ 69)))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                           (|spadConstant| $ 25)
                                           (QREFELT $ 48))
                                 |part|)
                                (#1#
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                            (QREFELT $ 65))
                                  |part| (QREFELT $ 70)))))))
                   (EXIT
                    (COND ((SPADCALL |y| (QREFELT $ 63)) |z|)
                          (#1#
                           (SPADCALL |z| (SPADCALL |y| (QREFELT $ 66))
                                     (QREFELT $ 67)))))))
                 ('T
                  (SEQ (LETT |part| (SPADCALL 'K (QREFELT $ 69)))
                       (EXIT
                        (COND
                         ((SPADCALL (SPADCALL |x| (QREFELT $ 20))
                                    (|spadConstant| $ 25) (QREFELT $ 48))
                          |part|)
                         (#1#
                          (SPADCALL
                           (SPADCALL (SPADCALL |x| (QREFELT $ 20))
                                     (QREFELT $ 65))
                           |part| (QREFELT $ 70))))))))))) 

(SDEFUN |OC-;inv;2S;20| ((|x| (S)) ($ (S)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 72)) (|spadConstant| $ 37)
                    (QREFELT $ 48))
          (|error| "This octonion is not invertible."))
         ('T
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 72)) (QREFELT $ 73))
                    (SPADCALL |x| (QREFELT $ 74)) (QREFELT $ 75))))) 

(SDEFUN |OC-;convert;SIf;21| ((|x| (S)) ($ (|InputForm|)))
        (SPROG ((|l| (|List| (|InputForm|))))
               (SEQ
                (LETT |l|
                      (LIST (SPADCALL '|octon| (QREFELT $ 78))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 13))
                                      (QREFELT $ 79))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 14))
                                      (QREFELT $ 79))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                      (QREFELT $ 79))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 16))
                                      (QREFELT $ 79))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 17))
                                      (QREFELT $ 79))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 18))
                                      (QREFELT $ 79))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                      (QREFELT $ 79))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 20))
                                      (QREFELT $ 79))))
                (EXIT (SPADCALL |l| (QREFELT $ 81)))))) 

(SDEFUN |OC-;<;2SB;22| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 13)) (SPADCALL |y| (QREFELT $ 13))
                    (QREFELT $ 48))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 14))
                      (SPADCALL |y| (QREFELT $ 14)) (QREFELT $ 48))
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 15))
                        (SPADCALL |y| (QREFELT $ 15)) (QREFELT $ 48))
              (COND
               ((SPADCALL (SPADCALL |x| (QREFELT $ 16))
                          (SPADCALL |y| (QREFELT $ 16)) (QREFELT $ 48))
                (COND
                 ((SPADCALL (SPADCALL |x| (QREFELT $ 17))
                            (SPADCALL |y| (QREFELT $ 17)) (QREFELT $ 48))
                  (COND
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 18))
                              (SPADCALL |y| (QREFELT $ 18)) (QREFELT $ 48))
                    (COND
                     ((SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                (SPADCALL |y| (QREFELT $ 19)) (QREFELT $ 48))
                      (SPADCALL (SPADCALL |x| (QREFELT $ 20))
                                (SPADCALL |y| (QREFELT $ 20)) (QREFELT $ 83)))
                     (#1='T
                      (SPADCALL (SPADCALL |x| (QREFELT $ 19))
                                (SPADCALL |y| (QREFELT $ 19))
                                (QREFELT $ 83)))))
                   (#1#
                    (SPADCALL (SPADCALL |x| (QREFELT $ 18))
                              (SPADCALL |y| (QREFELT $ 18)) (QREFELT $ 83)))))
                 (#1#
                  (SPADCALL (SPADCALL |x| (QREFELT $ 17))
                            (SPADCALL |y| (QREFELT $ 17)) (QREFELT $ 83)))))
               (#1#
                (SPADCALL (SPADCALL |x| (QREFELT $ 16))
                          (SPADCALL |y| (QREFELT $ 16)) (QREFELT $ 83)))))
             (#1#
              (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                        (SPADCALL |y| (QREFELT $ 15)) (QREFELT $ 83)))))
           (#1#
            (SPADCALL (SPADCALL |x| (QREFELT $ 14))
                      (SPADCALL |y| (QREFELT $ 14)) (QREFELT $ 83)))))
         (#1#
          (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (SPADCALL |y| (QREFELT $ 13))
                    (QREFELT $ 83))))) 

(SDEFUN |OC-;abs;SR;23| ((|x| (S)) ($ (R)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 72)) (QREFELT $ 85))) 

(SDEFUN |OC-;rational?;SB;24| ((|x| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 58))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 58))
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 58))
              (COND
               ((SPADCALL (SPADCALL |x| (QREFELT $ 17)) (QREFELT $ 58))
                (COND
                 ((SPADCALL (SPADCALL |x| (QREFELT $ 18)) (QREFELT $ 58))
                  (COND
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 58))
                    (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 58)))
                   (#1='T NIL)))
                 (#1# NIL)))
               (#1# NIL)))
             (#1# NIL)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |OC-;rational;SF;25| ((|x| (S)) ($ (|Fraction| (|Integer|))))
        (COND
         ((SPADCALL |x| (QREFELT $ 88))
          (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 90)))
         ('T (|error| "Not a rational number")))) 

(SDEFUN |OC-;rationalIfCan;SU;26|
        ((|x| (S)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (COND
         ((SPADCALL |x| (QREFELT $ 88))
          (CONS 0 (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 90))))
         ('T (CONS 1 "failed")))) 

(DECLAIM (NOTINLINE |OctonionCategory&;|)) 

(DEFUN |OctonionCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|OctonionCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 96))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2| '(|Field|))
                                              (|HasCategory| |#2|
                                                             '(|IntegerNumberSystem|))
                                              (|HasCategory| |#2|
                                                             '(|RealNumberSystem|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| |#2|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#2|
                                                             '(|OrderedSet|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 76 (CONS (|dispatchFunction| |OC-;inv;2S;20|) $))))
          (COND
           ((|testBitVector| |pv$| 6)
            (QSETREFV $ 82
                      (CONS (|dispatchFunction| |OC-;convert;SIf;21|) $))))
          (COND
           ((|testBitVector| |pv$| 7)
            (QSETREFV $ 84 (CONS (|dispatchFunction| |OC-;<;2SB;22|) $))))
          (COND
           ((|testBitVector| |pv$| 3)
            (QSETREFV $ 86 (CONS (|dispatchFunction| |OC-;abs;SR;23|) $))))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 87
                       (CONS (|dispatchFunction| |OC-;rational?;SB;24|) $))
             (QSETREFV $ 91 (CONS (|dispatchFunction| |OC-;rational;SF;25|) $))
             (QSETREFV $ 93
                       (CONS (|dispatchFunction| |OC-;rationalIfCan;SU;26|)
                             $)))))
          $))) 

(MAKEPROP '|OctonionCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|NonNegativeInteger|) (0 . |characteristic|)
              |OC-;characteristic;Nni;1| (|PositiveInteger|) |OC-;rank;Pi;2|
              (4 . |real|) (9 . |imagi|) (14 . |imagj|) (19 . |imagk|)
              (24 . |imagE|) (29 . |imagI|) (34 . |imagJ|) (39 . |imagK|)
              (|List| 7) (|Vector| 7) (44 . |vector|) |OC-;coordinates;SV;3|
              (49 . |One|) (|Integer|) (53 . |elt|) (59 . |octon|)
              |OC-;represents;VS;4| (|Vector| 6) (71 . |zero|) (76 . |zero|)
              (81 . |setelt!|) (88 . |represents|) (93 . |setelt!|)
              (100 . |Zero|) (104 . |Zero|) (|Vector| $) |OC-;basis;V;5|
              (108 . -) |OC-;conjugate;2S;6| (|Mapping| 7 7) |OC-;map;M2S;7|
              (113 . *) (119 . +) |OC-;norm;SR;8| (|Boolean|) (125 . =)
              |OC-;=;2SB;9| |OC-;+;3S;10| |OC-;-;2S;11| |OC-;*;R2S;12|
              (131 . *) |OC-;*;I2S;13| |OC-;coerce;RS;14| (137 . |coerce|)
              |OC-;coerce;IS;15| (142 . |zero?|) |OC-;zero?;SB;16|
              |OC-;retract;SR;17| (|Union| 7 '"failed")
              |OC-;retractIfCan;SU;18| (147 . |zero?|) (|OutputForm|)
              (152 . |coerce|) (157 . |coerce|) (162 . +) (|Symbol|)
              (168 . |coerce|) (173 . *) |OC-;coerce;SOf;19| (179 . |norm|)
              (184 . |inv|) (189 . |conjugate|) (194 . *) (200 . |inv|)
              (|InputForm|) (205 . |convert|) (210 . |convert|) (|List| $)
              (215 . |convert|) (220 . |convert|) (225 . <) (231 . <)
              (237 . |sqrt|) (242 . |abs|) (247 . |rational?|)
              (252 . |rational?|) (|Fraction| 26) (257 . |rational|)
              (262 . |rational|) (|Union| 89 '#1="failed")
              (267 . |rationalIfCan|) (|Union| 26 '#2="failed") (|Matrix| 7))
           '#(|zero?| 272 |retractIfCan| 277 |retract| 282 |represents| 287
              |rationalIfCan| 292 |rational?| 297 |rational| 302 |rank| 307
              |norm| 311 |map| 316 |inv| 322 |coordinates| 327 |convert| 332
              |conjugate| 337 |coerce| 342 |characteristic| 357 |basis| 361
              |abs| 365 = 370 < 376 - 382 + 387 * 393)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((< ((|Boolean|) |#1| |#1|)) T)
                                   '((|convert| ((|InputForm|) |#1|)) T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|characteristic|
                                      ((|NonNegativeInteger|)))
                                     T)
                                   '((|inv| (|#1| |#1|)) T)
                                   '((|rationalIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #1#)
                                       |#1|))
                                     T)
                                   '((|rational|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|rational?| ((|Boolean|) |#1|)) T)
                                   '((|abs| (|#2| |#1|)) T)
                                   '((|norm| (|#2| |#1|)) T)
                                   '((|conjugate| (|#1| |#1|)) T)
                                   '((|map| (|#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|coerce| (|#1| |#2|)) T)
                                   '((|retractIfCan| ((|Union| |#2| #2#) |#1|))
                                     T)
                                   '((|retract| (|#2| |#1|)) T)
                                   '((|retract|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #2#)
                                       |#1|))
                                     T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) #2#) |#1|))
                                     T)
                                   '((|basis| ((|Vector| |#1|))) T)
                                   '((|coordinates| ((|Vector| |#2|) |#1|)) T)
                                   '((|coordinates|
                                      ((|Matrix| |#2|) (|Vector| |#1|)))
                                     T)
                                   '((|represents| (|#1| (|Vector| |#2|))) T)
                                   '((|convert| ((|Vector| |#2|) |#1|)) T)
                                   '((|convert| (|#1| (|Vector| |#2|))) T)
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
                                   '((|rank| ((|PositiveInteger|))) T)
                                   '((* (|#1| |#2| |#1|)) T)
                                   '((* (|#1| |#1| |#2|)) T)
                                   '((|zero?| ((|Boolean|) |#1|)) T)
                                   '((* (|#1| (|NonNegativeInteger|) |#1|)) T)
                                   '((- (|#1| |#1|)) T)
                                   '((- (|#1| |#1| |#1|)) T)
                                   '((* (|#1| (|Integer|) |#1|)) T)
                                   '((* (|#1| |#1| |#1|)) T)
                                   '((* (|#1| (|PositiveInteger|) |#1|)) T)
                                   '((+ (|#1| |#1| |#1|)) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((= ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 93
                                            '(0 7 8 9 1 6 7 0 13 1 6 7 0 14 1 6
                                              7 0 15 1 6 7 0 16 1 6 7 0 17 1 6
                                              7 0 18 1 6 7 0 19 1 6 7 0 20 1 22
                                              0 21 23 0 7 0 25 2 22 7 0 26 27 8
                                              6 0 7 7 7 7 7 7 7 7 28 1 30 0 8
                                              31 1 22 0 8 32 3 22 7 0 26 7 33 1
                                              6 0 22 34 3 30 6 0 26 6 35 0 6 0
                                              36 0 7 0 37 1 7 0 0 40 2 7 0 0 0
                                              44 2 7 0 0 0 45 2 7 47 0 0 48 2 7
                                              0 26 0 53 1 7 0 26 56 1 7 47 0 58
                                              1 6 47 0 63 1 7 64 0 65 1 6 64 0
                                              66 2 64 0 0 0 67 1 68 64 0 69 2
                                              64 0 0 0 70 1 6 7 0 72 1 7 0 0 73
                                              1 6 0 0 74 2 6 0 7 0 75 1 0 0 0
                                              76 1 77 0 68 78 1 7 77 0 79 1 77
                                              0 80 81 1 0 77 0 82 2 7 47 0 0 83
                                              2 0 47 0 0 84 1 7 0 0 85 1 0 7 0
                                              86 1 0 47 0 87 1 6 47 0 88 1 7 89
                                              0 90 1 0 89 0 91 1 0 92 0 93 1 0
                                              47 0 59 1 0 61 0 62 1 0 7 0 60 1
                                              0 0 22 29 1 0 92 0 93 1 0 47 0 87
                                              1 0 89 0 91 0 0 11 12 1 0 7 0 46
                                              2 0 0 42 0 43 1 0 0 0 76 1 0 22 0
                                              24 1 0 77 0 82 1 0 0 0 41 1 0 0
                                              26 57 1 0 0 7 55 1 0 64 0 71 0 0
                                              8 10 0 0 38 39 1 0 7 0 86 2 0 47
                                              0 0 49 2 0 47 0 0 84 1 0 0 0 51 2
                                              0 0 0 0 50 2 0 0 7 0 52 2 0 0 26
                                              0 54)))))
           '|lookupComplete|)) 

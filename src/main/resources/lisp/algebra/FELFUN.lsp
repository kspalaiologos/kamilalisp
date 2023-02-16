
(SDEFUN |FELFUN;rabs;2F;1| ((|r| (|Float|)) ($ (|Float|)))
        (SPADCALL |r| (QREFELT $ 7))) 

(SDEFUN |FELFUN;rabs;CF;2| ((|r| (|Complex| (|Float|))) ($ (|Float|)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 10)) (QREFELT $ 11))) 

(SDEFUN |FELFUN;landen1;F2L;3|
        ((|m1| (|Float|)) (|res| (|List| (|Float|))) ($ (|List| (|Float|))))
        (SPROG ((|kn1| (|Float|)) (|kp| (|Float|)))
               (SEQ
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL (SPADCALL |m1| (QREFELT $ 8))
                                  (SPADCALL 25 -2 10 (QREFELT $ 15))
                                  (QREFELT $ 17)))
                       (GO G191)))
                     (SEQ (LETT |kp| (SPADCALL |m1| (QREFELT $ 18)))
                          (LETT |kn1|
                                (SPADCALL (SPADCALL 2 |kp| (QREFELT $ 19))
                                          (SPADCALL (|spadConstant| $ 20) |kp|
                                                    (QREFELT $ 21))
                                          (QREFELT $ 22)))
                          (LETT |res|
                                (CONS
                                 (SPADCALL (|spadConstant| $ 20) |kn1|
                                           (QREFELT $ 23))
                                 |res|))
                          (EXIT
                           (LETT |m1|
                                 (SPADCALL (SPADCALL 2 |kn1| (QREFELT $ 19))
                                           (SPADCALL |kn1| 2 (QREFELT $ 24))
                                           (QREFELT $ 23)))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS |m1| |res|))))) 

(SDEFUN |FELFUN;landen2;FLFL;4|
        ((|m| (|Float|)) (|res| (|List| (|Float|))) (|eps| (|Float|))
         ($ (|List| (|Float|))))
        (SPROG
         ((|kn| (|Float|)) (|kp| (|Float|)) (#1=#:G770 NIL) (|am| (|Float|)))
         (SEQ
          (SEQ
           (EXIT
            (SEQ G190 NIL
                 (SEQ (LETT |am| (SPADCALL |m| (QREFELT $ 8)))
                      (EXIT
                       (COND
                        ((SPADCALL |am| |eps| (QREFELT $ 17))
                         (SEQ
                          (LETT |kn|
                                (SPADCALL (SPADCALL 1 4 (QREFELT $ 29)) |m|
                                          (QREFELT $ 30)))
                          (LETT |res| (CONS |kn| |res|))
                          (EXIT (PROGN (LETT #1# |$NoValue|) (GO #2=#:G767)))))
                        ('T
                         (SEQ
                          (LETT |kp|
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 20) |m|
                                           (QREFELT $ 23))
                                 (QREFELT $ 18)))
                          (LETT |kn|
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 20) |kp|
                                           (QREFELT $ 23))
                                 (SPADCALL (|spadConstant| $ 20) |kp|
                                           (QREFELT $ 21))
                                 (QREFELT $ 22)))
                          (LETT |res| (CONS |kn| |res|))
                          (EXIT
                           (LETT |m| (SPADCALL |kn| 2 (QREFELT $ 24)))))))))
                 NIL (GO G190) G191 (EXIT NIL)))
           #2# (EXIT #1#))
          (EXIT |res|)))) 

(SDEFUN |FELFUN;landen;2FL;5|
        ((|m| (|Float|)) (|eps| (|Float|)) ($ (|List| (|Float|))))
        (SPROG ((|res| (|List| (|Float|))) (|m1| (|Float|)))
               (SEQ (LETT |res| NIL)
                    (COND
                     ((SPADCALL
                       (SPADCALL
                        (LETT |m1|
                              (SPADCALL (|spadConstant| $ 20) |m|
                                        (QREFELT $ 23)))
                        (QREFELT $ 8))
                       (SPADCALL 25 -2 10 (QREFELT $ 15)) (QREFELT $ 17))
                      (SEQ (LETT |res| (SPADCALL |m1| |res| (QREFELT $ 26)))
                           (LETT |m|
                                 (SPADCALL (|spadConstant| $ 20)
                                           (|SPADfirst| |res|) (QREFELT $ 23)))
                           (EXIT (LETT |res| (CDR |res|))))))
                    (EXIT (SPADCALL |m| |res| |eps| (QREFELT $ 31)))))) 

(SDEFUN |FELFUN;kprod;LF;6| ((|ll| (|List| (|Float|))) ($ (|Float|)))
        (SPROG ((#1=#:G781 NIL) (|k| NIL) (#2=#:G780 NIL))
               (SEQ
                (SPADCALL (ELT $ 34)
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |k| NIL) (LETT #1# |ll|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |k| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL (|spadConstant| $ 20) |k|
                                                   (QREFELT $ 21))
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 36))))) 

(SDEFUN |FELFUN;sn2;FLF;7|
        ((|z| (|Float|)) (|ll| (|List| (|Float|))) ($ (|Float|)))
        (SPROG ((|res| (|Float|)) (#1=#:G786 NIL) (|k| NIL))
               (SEQ (LETT |res| (SPADCALL |z| (QREFELT $ 38)))
                    (SEQ (LETT |k| NIL) (LETT #1# |ll|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL (|spadConstant| $ 20) |k|
                                             (QREFELT $ 21))
                                   |res| (QREFELT $ 34))
                                  (SPADCALL (|spadConstant| $ 20)
                                            (SPADCALL |k|
                                                      (SPADCALL |res| 2
                                                                (QREFELT $ 24))
                                                      (QREFELT $ 34))
                                            (QREFELT $ 21))
                                  (QREFELT $ 22)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |FELFUN;landen1;C2L;8|
        ((|m1| (|Complex| (|Float|))) (|res| (|List| (|Complex| (|Float|))))
         ($ (|List| (|Complex| (|Float|)))))
        (SPROG ((|kn1| (|Complex| (|Float|))) (|kp| (|Complex| (|Float|))))
               (SEQ
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL (SPADCALL |m1| (QREFELT $ 12))
                                  (SPADCALL 25 -2 10 (QREFELT $ 15))
                                  (QREFELT $ 17)))
                       (GO G191)))
                     (SEQ (LETT |kp| (SPADCALL |m1| (QREFELT $ 40)))
                          (LETT |kn1|
                                (SPADCALL (SPADCALL 2 |kp| (QREFELT $ 41))
                                          (SPADCALL (|spadConstant| $ 32) |kp|
                                                    (QREFELT $ 42))
                                          (QREFELT $ 43)))
                          (LETT |res|
                                (CONS
                                 (SPADCALL (|spadConstant| $ 32) |kn1|
                                           (QREFELT $ 44))
                                 |res|))
                          (EXIT
                           (LETT |m1|
                                 (SPADCALL (SPADCALL 2 |kn1| (QREFELT $ 41))
                                           (SPADCALL |kn1| 2 (QREFELT $ 45))
                                           (QREFELT $ 44)))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS |m1| |res|))))) 

(SDEFUN |FELFUN;landen2;CLFL;9|
        ((|m| (|Complex| (|Float|))) (|res| (|List| (|Complex| (|Float|))))
         (|eps| (|Float|)) ($ (|List| (|Complex| (|Float|)))))
        (SPROG
         ((|kn| (|Complex| (|Float|))) (|kp| (|Complex| (|Float|)))
          (#1=#:G799 NIL) (|am| (|Float|)))
         (SEQ
          (SEQ
           (EXIT
            (SEQ G190 NIL
                 (SEQ (LETT |am| (SPADCALL |m| (QREFELT $ 12)))
                      (EXIT
                       (COND
                        ((SPADCALL |am| |eps| (QREFELT $ 17))
                         (SEQ
                          (LETT |kn|
                                (SPADCALL (SPADCALL 1 4 (QREFELT $ 29)) |m|
                                          (QREFELT $ 49)))
                          (LETT |res| (CONS |kn| |res|))
                          (EXIT (PROGN (LETT #1# |$NoValue|) (GO #2=#:G796)))))
                        ('T
                         (SEQ
                          (LETT |kp|
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 32) |m|
                                           (QREFELT $ 44))
                                 (QREFELT $ 40)))
                          (LETT |kn|
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 32) |kp|
                                           (QREFELT $ 44))
                                 (SPADCALL (|spadConstant| $ 32) |kp|
                                           (QREFELT $ 42))
                                 (QREFELT $ 43)))
                          (LETT |res| (CONS |kn| |res|))
                          (EXIT
                           (LETT |m| (SPADCALL |kn| 2 (QREFELT $ 45)))))))))
                 NIL (GO G190) G191 (EXIT NIL)))
           #2# (EXIT #1#))
          (EXIT |res|)))) 

(SDEFUN |FELFUN;landen;CFL;10|
        ((|m| (|Complex| (|Float|))) (|eps| (|Float|))
         ($ (|List| (|Complex| (|Float|)))))
        (SPROG
         ((|res| (|List| (|Complex| (|Float|)))) (|m1| (|Complex| (|Float|))))
         (SEQ (LETT |res| NIL)
              (COND
               ((SPADCALL
                 (SPADCALL
                  (LETT |m1|
                        (SPADCALL (|spadConstant| $ 32) |m| (QREFELT $ 44)))
                  (QREFELT $ 12))
                 (SPADCALL 25 -2 10 (QREFELT $ 15)) (QREFELT $ 17))
                (SEQ (LETT |res| (SPADCALL |m1| |res| (QREFELT $ 47)))
                     (LETT |m|
                           (SPADCALL (|spadConstant| $ 32) (|SPADfirst| |res|)
                                     (QREFELT $ 44)))
                     (EXIT (LETT |res| (CDR |res|))))))
              (EXIT (SPADCALL |m| |res| |eps| (QREFELT $ 50)))))) 

(SDEFUN |FELFUN;kprod;LC;11|
        ((|ll| (|List| (|Complex| (|Float|)))) ($ (|Complex| (|Float|))))
        (SPROG ((#1=#:G810 NIL) (|k| NIL) (#2=#:G809 NIL))
               (SEQ
                (SPADCALL (ELT $ 52)
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |k| NIL) (LETT #1# |ll|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |k| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL (|spadConstant| $ 32) |k|
                                                   (QREFELT $ 42))
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 54))))) 

(SDEFUN |FELFUN;sn2;CLC;12|
        ((|z| (|Complex| (|Float|))) (|ll| (|List| (|Complex| (|Float|))))
         ($ (|Complex| (|Float|))))
        (SPROG ((|res| (|Complex| (|Float|))) (#1=#:G815 NIL) (|k| NIL))
               (SEQ (LETT |res| (SPADCALL |z| (QREFELT $ 56)))
                    (SEQ (LETT |k| NIL) (LETT #1# |ll|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL (|spadConstant| $ 32) |k|
                                             (QREFELT $ 42))
                                   |res| (QREFELT $ 52))
                                  (SPADCALL (|spadConstant| $ 32)
                                            (SPADCALL |k|
                                                      (SPADCALL |res| 2
                                                                (QREFELT $ 45))
                                                      (QREFELT $ 52))
                                            (QREFELT $ 42))
                                  (QREFELT $ 43)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |FELFUN;pimod| ((|z| (|Float|)) ($ (|Float|)))
        (SPROG ((|nn| (|Integer|)) (|pi2| (|Float|)))
               (SEQ
                (LETT |pi2|
                      (SPADCALL 2 (SPADCALL (QREFELT $ 58)) (QREFELT $ 19)))
                (LETT |nn|
                      (SPADCALL
                       (SPADCALL (SPADCALL |z| |pi2| (QREFELT $ 22))
                                 (QREFELT $ 59))
                       (QREFELT $ 60)))
                (EXIT
                 (SPADCALL |z| (SPADCALL |nn| |pi2| (QREFELT $ 61))
                           (QREFELT $ 23)))))) 

(SDEFUN |FELFUN;two_to_minus_n| ((|n| (|Integer|)) ($ (|Float|)))
        (COND
         ((SPADCALL (SPADCALL (QREFELT $ 62)) 2 (QREFELT $ 63))
          (|error| "Only base 2 is supported"))
         ('T (SPADCALL 1 (- |n|) (QREFELT $ 64))))) 

(SDEFUN |FELFUN;ellipticK;2F;15| ((|m| (|Float|)) ($ (|Float|)))
        (SPROG
         ((|res| (|Float|)) (|ll| (|List| (|Float|))) (|eps| (|Float|))
          (|prec| (|PositiveInteger|)) (|obits| (|PositiveInteger|)))
         (SEQ
          (COND
           ((SPADCALL |m| (SPADCALL 1 0 10 (QREFELT $ 15)) (QREFELT $ 66))
            (|error| "ellipticK : m >= 1.0"))
           ('T
            (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                 (LETT |prec| (+ |obits| 20)) (SPADCALL |prec| (QREFELT $ 68))
                 (LETT |eps| (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2) $))
                 (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 33)))
                 (LETT |res|
                       (SPADCALL
                        (SPADCALL (SPADCALL 1 2 (QREFELT $ 29))
                                  (SPADCALL (QREFELT $ 58)) (QREFELT $ 30))
                        (SPADCALL |ll| (QREFELT $ 37)) (QREFELT $ 34)))
                 (SPADCALL |obits| (QREFELT $ 68)) (EXIT |res|))))))) 

(SDEFUN |FELFUN;ellipticK;2C;16|
        ((|m| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|res| (|Complex| (|Float|))) (|ll| (|List| (|Complex| (|Float|))))
          (|eps| (|Float|)) (|prec| (|PositiveInteger|))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 32) (QREFELT $ 70))
            (|error| "ellipticK : m = 1.0"))
           ('T
            (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                 (LETT |prec| (+ |obits| 20)) (SPADCALL |prec| (QREFELT $ 68))
                 (LETT |eps| (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2) $))
                 (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 51)))
                 (LETT |res|
                       (SPADCALL
                        (SPADCALL (SPADCALL 1 2 (QREFELT $ 29))
                                  (SPADCALL (QREFELT $ 58)) (QREFELT $ 30))
                        (SPADCALL |ll| (QREFELT $ 55)) (QREFELT $ 72)))
                 (SPADCALL |obits| (QREFELT $ 68)) (EXIT |res|))))))) 

(SDEFUN |FELFUN;sin1| ((|z| (|Float|)) ($ (|Float|)))
        (SPROG ((|z1| (|Float|)))
               (SEQ
                (COND
                 ((OR (SPADCALL |z| (|spadConstant| $ 20) (QREFELT $ 17))
                      (SPADCALL |z| (SPADCALL 2 0 10 (QREFELT $ 15))
                                (QREFELT $ 74)))
                  (SPADCALL (|spadConstant| $ 20) (SPADCALL |z| (QREFELT $ 38))
                            (QREFELT $ 23)))
                 ('T
                  (SEQ
                   (LETT |z1|
                         (SPADCALL |z|
                                   (SPADCALL (SPADCALL (QREFELT $ 58))
                                             (SPADCALL 2 0 10 (QREFELT $ 15))
                                             (QREFELT $ 22))
                                   (QREFELT $ 23)))
                   (LETT |z1| (SPADCALL |z1| 2 (QREFELT $ 48)))
                   (EXIT
                    (SPADCALL 2
                              (SPADCALL (SPADCALL |z1| (QREFELT $ 38)) 2
                                        (QREFELT $ 75))
                              (QREFELT $ 19))))))))) 

(SDEFUN |FELFUN;sn21| ((|z| (|Float|)) (|ll| (|List| (|Float|))) ($ (|Float|)))
        (SPROG
         ((|res| (|Float|)) (|kres| (|Float|)) (|res0| (|Float|))
          (#1=#:G833 NIL) (|k| NIL))
         (SEQ (LETT |res| (|FELFUN;sin1| |z| $))
              (SEQ (LETT |k| NIL) (LETT #1# |ll|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |res0|
                          (SPADCALL (|spadConstant| $ 20) |res|
                                    (QREFELT $ 23)))
                    (LETT |kres| (SPADCALL |k| |res| (QREFELT $ 34)))
                    (EXIT
                     (LETT |res|
                           (SPADCALL
                            (SPADCALL (SPADCALL |res| |kres| (QREFELT $ 23))
                                      (SPADCALL |kres| |res| (QREFELT $ 34))
                                      (QREFELT $ 21))
                            (SPADCALL (|spadConstant| $ 20)
                                      (SPADCALL |k|
                                                (SPADCALL |res0| 2
                                                          (QREFELT $ 24))
                                                (QREFELT $ 34))
                                      (QREFELT $ 21))
                            (QREFELT $ 22)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FELFUN;sn1|
        ((|z| (|Float|)) (|m| (|Float|)) (|prec| (|PositiveInteger|))
         ($ (|Float|)))
        (SPROG
         ((|z1| #1=(|Float|)) (|kk| (|Float|)) (|ll| (|List| (|Float|)))
          (|res1| (|Float|)) (|res| (|Float|)) (|z0| (|Float|))
          (|sign| (|Float|)) (|m1| (|Float|)) (|kp1| #1#) (|kp| (|Float|))
          (|eps| (|Float|)))
         (SEQ
          (COND
           ((OR (SPADCALL |m| (SPADCALL 8 -1 10 (QREFELT $ 15)) (QREFELT $ 74))
                (SPADCALL |m|
                          (SPADCALL (SPADCALL 4 0 10 (QREFELT $ 15))
                                    (QREFELT $ 76))
                          (QREFELT $ 17)))
            (SEQ (LETT |prec| (+ |prec| 20))
                 (EXIT (SPADCALL |prec| (QREFELT $ 68))))))
          (LETT |eps| (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2) $))
          (EXIT
           (COND
            ((SPADCALL |m|
                       (SPADCALL (SPADCALL 48 0 10 (QREFELT $ 15))
                                 (QREFELT $ 76))
                       (QREFELT $ 17))
             (SEQ
              (LETT |kp|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 20) |m| (QREFELT $ 23))
                     (QREFELT $ 18)))
              (LETT |kp1|
                    (SPADCALL (SPADCALL 2 0 10 (QREFELT $ 15))
                              (SPADCALL (|spadConstant| $ 20) |kp|
                                        (QREFELT $ 21))
                              (QREFELT $ 22)))
              (LETT |m1|
                    (SPADCALL (SPADCALL 2 |kp1| (QREFELT $ 19))
                              (SPADCALL |kp1| 2 (QREFELT $ 24))
                              (QREFELT $ 23)))
              (LETT |z| (SPADCALL |z| |kp1| (QREFELT $ 22))) (LETT |ll| NIL)
              (COND
               ((SPADCALL |m1| (SPADCALL 25 -2 10 (QREFELT $ 15))
                          (QREFELT $ 17))
                (SEQ (LETT |ll| (SPADCALL |m1| |ll| (QREFELT $ 26)))
                     (LETT |m|
                           (SPADCALL (|spadConstant| $ 20) (|SPADfirst| |ll|)
                                     (QREFELT $ 23)))
                     (EXIT
                      (LETT |ll|
                            (SPADCALL |m| (CDR |ll|) |eps| (QREFELT $ 31))))))
               (#2='T
                (LETT |ll|
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 20) |m1| (QREFELT $ 23))
                       |eps| (QREFELT $ 33)))))
              (LETT |kk| (SPADCALL |ll| (QREFELT $ 37)))
              (LETT |z1| (SPADCALL |z| |kk| (QREFELT $ 22)))
              (LETT |z1| (|FELFUN;pimod| |z1| $))
              (COND
               ((SPADCALL |z1| (|spadConstant| $ 65) (QREFELT $ 17))
                (SEQ
                 (LETT |sign| (SPADCALL (|spadConstant| $ 20) (QREFELT $ 76)))
                 (EXIT (LETT |z1| (SPADCALL |z1| (QREFELT $ 76))))))
               (#2# (LETT |sign| (|spadConstant| $ 20))))
              (LETT |z0| (SPADCALL |z1| |kk| (QREFELT $ 34)))
              (EXIT
               (COND
                ((SPADCALL |z0| (SPADCALL 5 -1 10 (QREFELT $ 15))
                           (QREFELT $ 17))
                 (SEQ (LETT |res| (SPADCALL |z1| |ll| (QREFELT $ 39)))
                      (EXIT
                       (SPADCALL
                        (SPADCALL (SPADCALL |sign| |kp1| (QREFELT $ 34)) |res|
                                  (QREFELT $ 34))
                        (SPADCALL (|spadConstant| $ 20)
                                  (SPADCALL
                                   (SPADCALL |kp1| (|spadConstant| $ 20)
                                             (QREFELT $ 23))
                                   (SPADCALL |res| 2 (QREFELT $ 24))
                                   (QREFELT $ 34))
                                  (QREFELT $ 21))
                        (QREFELT $ 22)))))
                (#2#
                 (SEQ (LETT |res1| (|FELFUN;sn21| |z1| |ll| $))
                      (EXIT
                       (SPADCALL
                        (SPADCALL (SPADCALL |sign| |kp1| (QREFELT $ 34))
                                  (SPADCALL (|spadConstant| $ 20) |res1|
                                            (QREFELT $ 23))
                                  (QREFELT $ 34))
                        (SPADCALL |kp1|
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |kp1| (|spadConstant| $ 20)
                                              (QREFELT $ 23))
                                    (SPADCALL |res1|
                                              (SPADCALL 2 0 10 (QREFELT $ 15))
                                              (QREFELT $ 23))
                                    (QREFELT $ 34))
                                   |res1| (QREFELT $ 34))
                                  (QREFELT $ 21))
                        (QREFELT $ 22)))))))))
            (#2#
             (SEQ (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 33)))
                  (LETT |kk| (SPADCALL |ll| (QREFELT $ 37)))
                  (LETT |z1| (SPADCALL |z| |kk| (QREFELT $ 22)))
                  (EXIT (SPADCALL |z1| |ll| (QREFELT $ 39)))))))))) 

(SDEFUN |FELFUN;cn1|
        ((|z| (|Float|)) (|m| (|Float|)) (|prec| (|PositiveInteger|))
         ($ (|Float|)))
        (SPROG
         ((|res0| (|Float|)) (|sgn| (|Float|)) (|nn| (|Integer|))
          (|z2| (|Float|)) (|pih| (|Float|)) (|z1| (|Float|)) (|kk| (|Float|))
          (|ll| (|List| (|Float|))) (|eps| (|Float|)))
         (SEQ
          (COND
           ((SPADCALL |z| (|spadConstant| $ 65) (QREFELT $ 17))
            (LETT |z| (SPADCALL |z| (QREFELT $ 76)))))
          (LETT |prec| (* 2 |prec|))
          (COND
           ((OR (SPADCALL |m| (SPADCALL 8 -1 10 (QREFELT $ 15)) (QREFELT $ 74))
                (SPADCALL |m|
                          (SPADCALL (SPADCALL 4 0 10 (QREFELT $ 15))
                                    (QREFELT $ 76))
                          (QREFELT $ 17)))
            (LETT |prec| (+ |prec| 20))))
          (SPADCALL |prec| (QREFELT $ 68))
          (LETT |eps| (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2) $))
          (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 33)))
          (LETT |kk| (SPADCALL |ll| (QREFELT $ 37)))
          (LETT |z1| (SPADCALL |z| |kk| (QREFELT $ 22)))
          (LETT |pih|
                (SPADCALL (SPADCALL 5 -1 10 (QREFELT $ 15))
                          (SPADCALL (QREFELT $ 58)) (QREFELT $ 34)))
          (LETT |nn|
                (SPADCALL
                 (SPADCALL (SPADCALL |z1| |pih| (QREFELT $ 22)) (QREFELT $ 59))
                 (QREFELT $ 60)))
          (COND
           ((ODDP |nn|)
            (SEQ
             (LETT |z2|
                   (SPADCALL |z1| (SPADCALL |nn| |pih| (QREFELT $ 61))
                             (QREFELT $ 23)))
             (LETT |nn| (QUOTIENT2 |nn| 2))
             (LETT |sgn|
                   (COND ((ODDP |nn|) (|spadConstant| $ 20))
                         (#1='T
                          (SPADCALL (|spadConstant| $ 20) (QREFELT $ 76)))))
             (EXIT
              (LETT |sgn|
                    (SPADCALL (SPADCALL |z2| (QREFELT $ 77)) |sgn|
                              (QREFELT $ 61))))))
           (#1#
            (SEQ (LETT |nn| (QUOTIENT2 |nn| 2))
                 (EXIT
                  (LETT |sgn|
                        (COND
                         ((ODDP |nn|)
                          (SPADCALL (|spadConstant| $ 20) (QREFELT $ 76)))
                         (#1# (|spadConstant| $ 20))))))))
          (LETT |res0| (SPADCALL |z1| |ll| (QREFELT $ 39)))
          (EXIT
           (SPADCALL |sgn|
                     (SPADCALL
                      (SPADCALL (|spadConstant| $ 20)
                                (SPADCALL |res0| 2 (QREFELT $ 24))
                                (QREFELT $ 23))
                      (QREFELT $ 18))
                     (QREFELT $ 34)))))) 

(SDEFUN |FELFUN;dn1|
        ((|z| (|Float|)) (|m| (|Float|)) (|prec| (|PositiveInteger|))
         ($ (|Float|)))
        (SPROG ((|res0| (|Float|)))
               (SEQ (LETT |prec| (* 2 |prec|)) (SPADCALL |prec| (QREFELT $ 68))
                    (LETT |res0| (|FELFUN;sn1| |z| |m| |prec| $))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (|spadConstant| $ 20)
                                (SPADCALL |m|
                                          (SPADCALL |res0| 2 (QREFELT $ 24))
                                          (QREFELT $ 34))
                                (QREFELT $ 23))
                      (QREFELT $ 18)))))) 

(SDEFUN |FELFUN;jacobi_imaginary|
        ((|z| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ (|List| (|Complex| (|Float|)))))
        (SPROG
         ((|cc| (|Complex| (|Float|))) (|pl| (|List| (|Complex| (|Float|))))
          (|iu| (|Complex| (|Float|))))
         (SEQ
          (LETT |iu|
                (SPADCALL (|spadConstant| $ 65)
                          (SPADCALL 1 0 10 (QREFELT $ 15)) (QREFELT $ 79)))
          (LETT |pl|
                (|FELFUN;sn_cn_dn|
                 (SPADCALL (SPADCALL |iu| |z| (QREFELT $ 52)) (QREFELT $ 80))
                 (SPADCALL (|spadConstant| $ 32) |m| (QREFELT $ 44)) $))
          (LETT |cc| (SPADCALL |pl| 3 (QREFELT $ 81)))
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |pl| 1 (QREFELT $ 81)) (|spadConstant| $ 32)
                       (QREFELT $ 70))
             (COND
              ((SPADCALL |cc| (|spadConstant| $ 78) (QREFELT $ 70))
               (SEQ (LETT |cc| (SPADCALL |pl| 2 (QREFELT $ 81)))
                    (EXIT
                     (LIST (|spadConstant| $ 78) (|spadConstant| $ 32)
                           (SPADCALL (|spadConstant| $ 32) |cc| (QREFELT $ 43))
                           (SPADCALL (SPADCALL |pl| 4 (QREFELT $ 81)) |cc|
                                     (QREFELT $ 43))))))
              (#1='T
               (LIST (|spadConstant| $ 32)
                     (SPADCALL
                      (SPADCALL |iu| (SPADCALL |pl| 2 (QREFELT $ 81))
                                (QREFELT $ 52))
                      |cc| (QREFELT $ 43))
                     (SPADCALL (|spadConstant| $ 32) |cc| (QREFELT $ 43))
                     (SPADCALL (SPADCALL |pl| 4 (QREFELT $ 81)) |cc|
                               (QREFELT $ 43))))))
            (#1#
             (LIST (|spadConstant| $ 32)
                   (SPADCALL
                    (SPADCALL |iu| (SPADCALL |pl| 2 (QREFELT $ 81))
                              (QREFELT $ 52))
                    |cc| (QREFELT $ 43))
                   (|spadConstant| $ 78)
                   (SPADCALL (SPADCALL |pl| 4 (QREFELT $ 81)) |cc|
                             (QREFELT $ 43))))))))) 

(SDEFUN |FELFUN;sn_cn_dn|
        ((|z| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ #1=(|List| (|Complex| (|Float|)))))
        (SPROG
         ((|ni| #2=(|Integer|)) (|d1| #3=(|Complex| (|Float|))) (|c1| #3#)
          (|s1| #4=(|Complex| (|Float|))) (|#G81| #5=(|Complex| (|Float|)))
          (|#G80| #5#) (|#G79| #4#) (|#G78| #3#) (|#G77| #5#) (|#G76| #3#)
          (|ms1| #6=(|Complex| (|Float|))) (|nr| #2#) (|#G75| #3#) (|#G74| #5#)
          (|#G73| #5#) (|iu| (|Complex| (|Float|)))
          (|den| #7=(|Complex| (|Float|))) (|ms2| (|Complex| (|Float|)))
          (|s2| #4#) (|ctwo| (|Complex| (|Float|)))
          (|zz1| (|Complex| (|Float|))) (|z1| #3#) (|iz1| #8=(|Float|))
          (|itau| #8#) (|tau| #3#) (|ppi| (|Float|))
          (|kk2| #9=(|Complex| (|Float|)))
          (|ll2| (|List| (|Complex| (|Float|)))) (|kn| #3#) (|mp| #7#)
          (|ms0| #6#) (|m1| #7#) (|kk| #9#)
          (|ll| (|List| (|Complex| (|Float|)))) (|eps| (|Float|))
          (|res| (|List| #3#)) (|pl| #1#) (|k| #6#)
          (|cc| (|Complex| (|Float|))) (|prec| (|PositiveInteger|))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 78) (QREFELT $ 70))
            (LIST (|spadConstant| $ 32) (SPADCALL |z| (QREFELT $ 56))
                  (SPADCALL |z| (QREFELT $ 82)) (|spadConstant| $ 32)))
           (#10='T
            (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                 (LETT |prec| (+ |obits| 20))
                 (EXIT
                  (COND
                   ((SPADCALL |m| (|spadConstant| $ 32) (QREFELT $ 70))
                    (SEQ (LETT |cc| (SPADCALL |z| (QREFELT $ 83)))
                         (LETT |res|
                               (COND
                                ((SPADCALL |cc| (|spadConstant| $ 78)
                                           (QREFELT $ 70))
                                 (SEQ
                                  (LETT |cc|
                                        (SPADCALL (|spadConstant| $ 32)
                                                  (SPADCALL |z| (QREFELT $ 84))
                                                  (QREFELT $ 43)))
                                  (EXIT
                                   (LIST (|spadConstant| $ 78)
                                         (|spadConstant| $ 32) |cc| |cc|))))
                                (#10#
                                 (SEQ
                                  (LETT |cc|
                                        (SPADCALL (|spadConstant| $ 32) |cc|
                                                  (QREFELT $ 43)))
                                  (EXIT
                                   (LIST (|spadConstant| $ 32)
                                         (SPADCALL |z| (QREFELT $ 85)) |cc|
                                         |cc|))))))
                         (EXIT |res|)))
                   ((SPADCALL
                     (SPADCALL
                      (SPADCALL |m| (|spadConstant| $ 32) (QREFELT $ 44))
                      (QREFELT $ 12))
                     (SPADCALL 5 -1 10 (QREFELT $ 15)) (QREFELT $ 17))
                    (|FELFUN;jacobi_imaginary| |z| |m| $))
                   ((SPADCALL (SPADCALL |m| (QREFELT $ 12))
                              (|spadConstant| $ 20) (QREFELT $ 74))
                    (SEQ
                     (LETT |m|
                           (SPADCALL (|spadConstant| $ 32) |m| (QREFELT $ 43)))
                     (LETT |k| (SPADCALL |m| (QREFELT $ 40)))
                     (LETT |z| (SPADCALL |z| |k| (QREFELT $ 43)))
                     (LETT |pl| (|FELFUN;sn_cn_dn| |z| |m| $))
                     (LETT |res|
                           (COND
                            ((SPADCALL (SPADCALL |pl| 1 (QREFELT $ 81))
                                       (|spadConstant| $ 32) (QREFELT $ 70))
                             (LIST (|spadConstant| $ 32)
                                   (SPADCALL |k|
                                             (SPADCALL |pl| 2 (QREFELT $ 81))
                                             (QREFELT $ 52))
                                   (SPADCALL |pl| 4 (QREFELT $ 81))
                                   (SPADCALL |pl| 3 (QREFELT $ 81))))
                            (#10#
                             (LIST (|spadConstant| $ 78) (|spadConstant| $ 32)
                                   (SPADCALL (SPADCALL |pl| 4 (QREFELT $ 81))
                                             |k| (QREFELT $ 43))
                                   (SPADCALL (SPADCALL |pl| 3 (QREFELT $ 81))
                                             |k| (QREFELT $ 43))))))
                     (EXIT |res|)))
                   ((SPADCALL (SPADCALL |m| (QREFELT $ 11))
                              (SPADCALL 5 -1 10 (QREFELT $ 15)) (QREFELT $ 74))
                    (|FELFUN;jacobi_imaginary| |z| |m| $))
                   (#10#
                    (SEQ
                     (LETT |eps|
                           (SPADCALL 1 (- (QUOTIENT2 |prec| 2))
                                     (QREFELT $ 64)))
                     (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 51)))
                     (LETT |kk| (SPADCALL |ll| (QREFELT $ 55)))
                     (LETT |z1| (SPADCALL |z| |kk| (QREFELT $ 43)))
                     (LETT |m1|
                           (SPADCALL (|spadConstant| $ 32) |m| (QREFELT $ 44)))
                     (LETT |ms0| (SPADCALL |m| (QREFELT $ 40)))
                     (COND
                      ((SPADCALL (SPADCALL |ms0| (QREFELT $ 12))
                                 (SPADCALL 25 -2 10 (QREFELT $ 15))
                                 (QREFELT $ 17))
                       (SEQ
                        (LETT |kn|
                              (SPADCALL (SPADCALL 2 |ms0| (QREFELT $ 41))
                                        (SPADCALL (|spadConstant| $ 32) |ms0|
                                                  (QREFELT $ 42))
                                        (QREFELT $ 43)))
                        (LETT |ll2|
                              (SPADCALL
                               (SPADCALL (SPADCALL 2 |kn| (QREFELT $ 41))
                                         (SPADCALL |kn| 2 (QREFELT $ 45))
                                         (QREFELT $ 44))
                               (LIST
                                (SPADCALL (|spadConstant| $ 32) |kn|
                                          (QREFELT $ 44)))
                               (QREFELT $ 47)))
                        (LETT |mp|
                              (SPADCALL (|spadConstant| $ 32)
                                        (|SPADfirst| |ll2|) (QREFELT $ 44)))
                        (EXIT
                         (LETT |ll2|
                               (SPADCALL |mp| (CDR |ll2|) |eps|
                                         (QREFELT $ 50))))))
                      (#10#
                       (SEQ
                        (LETT |kn|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 32) |ms0|
                                         (QREFELT $ 44))
                               (SPADCALL (|spadConstant| $ 32) |ms0|
                                         (QREFELT $ 42))
                               (QREFELT $ 43)))
                        (EXIT
                         (LETT |ll2|
                               (SPADCALL (SPADCALL |kn| 2 (QREFELT $ 45))
                                         (LIST |kn|) |eps| (QREFELT $ 50)))))))
                     (LETT |iu|
                           (SPADCALL (|spadConstant| $ 65)
                                     (SPADCALL 1 0 10 (QREFELT $ 15))
                                     (QREFELT $ 79)))
                     (LETT |kk2| (SPADCALL |ll2| (QREFELT $ 55)))
                     (LETT |ppi|
                           (SPADCALL (SPADCALL (QREFELT $ 58)) 2
                                     (QREFELT $ 48)))
                     (LETT |z1|
                           (SPADCALL |z| (SPADCALL |kk| |ppi| (QREFELT $ 86))
                                     (QREFELT $ 43)))
                     (LETT |tau|
                           (SPADCALL (SPADCALL |iu| |kk2| (QREFELT $ 52)) |kk|
                                     (QREFELT $ 43)))
                     (LETT |itau| (SPADCALL |tau| (QREFELT $ 87)))
                     (LETT |iz1| (SPADCALL |z1| (QREFELT $ 87)))
                     (LETT |ni|
                           (SPADCALL
                            (SPADCALL (SPADCALL |iz1| |itau| (QREFELT $ 22))
                                      (QREFELT $ 59))
                            (QREFELT $ 60)))
                     (LETT |z1|
                           (SPADCALL |z1| (SPADCALL |ni| |tau| (QREFELT $ 88))
                                     (QREFELT $ 44)))
                     (LETT |nr|
                           (SPADCALL
                            (SPADCALL (SPADCALL |z1| (QREFELT $ 11))
                                      (QREFELT $ 59))
                            (QREFELT $ 60)))
                     (LETT |z1|
                           (SPADCALL |z1|
                                     (SPADCALL (SPADCALL |nr| (QREFELT $ 89))
                                               (QREFELT $ 90))
                                     (QREFELT $ 44)))
                     (LETT |zz1| (SPADCALL |ppi| |z1| (QREFELT $ 72)))
                     (LETT |s1| (SPADCALL |zz1| |ll| (QREFELT $ 57)))
                     (LETT |ctwo|
                           (SPADCALL (SPADCALL 2 0 10 (QREFELT $ 15))
                                     (QREFELT $ 90)))
                     (LETT |s2|
                           (SPADCALL (SPADCALL |zz1| |ctwo| (QREFELT $ 43))
                                     |ll| (QREFELT $ 57)))
                     (LETT |s2| (SPADCALL |s2| |s2| (QREFELT $ 52)))
                     (LETT |ms2| (SPADCALL |m| |s2| (QREFELT $ 52)))
                     (LETT |den|
                           (SPADCALL (|spadConstant| $ 32)
                                     (SPADCALL |ms2| |s2| (QREFELT $ 52))
                                     (QREFELT $ 44)))
                     (LETT |c1|
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 32)
                                      (SPADCALL |s2|
                                                (SPADCALL |ctwo| |ms2|
                                                          (QREFELT $ 44))
                                                (QREFELT $ 52))
                                      (QREFELT $ 44))
                            |den| (QREFELT $ 43)))
                     (LETT |d1|
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 32)
                                      (SPADCALL |ms2|
                                                (SPADCALL |ctwo| |s2|
                                                          (QREFELT $ 44))
                                                (QREFELT $ 52))
                                      (QREFELT $ 44))
                            |den| (QREFELT $ 43)))
                     (LETT |ni| (SPADCALL |ni| 4 (QREFELT $ 91)))
                     (LETT |nr| (SPADCALL |nr| 4 (QREFELT $ 91)))
                     (LETT |iu|
                           (SPADCALL (|spadConstant| $ 65)
                                     (SPADCALL 1 0 10 (QREFELT $ 15))
                                     (QREFELT $ 79)))
                     (COND
                      ((>= |nr| 2)
                       (SEQ
                        (PROGN
                         (LETT |#G73| (SPADCALL |s1| (QREFELT $ 80)))
                         (LETT |#G74| (SPADCALL |c1| (QREFELT $ 80)))
                         (LETT |#G75| |d1|)
                         (LETT |s1| |#G73|)
                         (LETT |c1| |#G74|)
                         (LETT |d1| |#G75|))
                        (EXIT (LETT |nr| (- |nr| 2))))))
                     (COND
                      ((EQL |nr| 1)
                       (SEQ (LETT |ms1| (SPADCALL |m1| (QREFELT $ 40)))
                            (EXIT
                             (PROGN
                              (LETT |#G76| (SPADCALL |c1| |d1| (QREFELT $ 43)))
                              (LETT |#G77|
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL |ms1| |s1| (QREFELT $ 52)) |d1|
                                      (QREFELT $ 43))
                                     (QREFELT $ 80)))
                              (LETT |#G78|
                                    (SPADCALL |ms1| |d1| (QREFELT $ 43)))
                              (LETT |s1| |#G76|)
                              (LETT |c1| |#G77|)
                              (LETT |d1| |#G78|))))))
                     (COND
                      ((>= |ni| 2)
                       (SEQ
                        (PROGN
                         (LETT |#G79| |s1|)
                         (LETT |#G80| (SPADCALL |c1| (QREFELT $ 80)))
                         (LETT |#G81| (SPADCALL |d1| (QREFELT $ 80)))
                         (LETT |s1| |#G79|)
                         (LETT |c1| |#G80|)
                         (LETT |d1| |#G81|))
                        (EXIT (LETT |ni| (- |ni| 2))))))
                     (EXIT
                      (COND
                       ((EQL |ni| 0)
                        (LIST (|spadConstant| $ 32) |s1| |c1| |d1|))
                       ((SPADCALL |s1| (|spadConstant| $ 78) (QREFELT $ 70))
                        (LIST (|spadConstant| $ 78) (|spadConstant| $ 32)
                              (SPADCALL (SPADCALL |iu| |d1| (QREFELT $ 52))
                                        (QREFELT $ 80))
                              (SPADCALL (SPADCALL |iu| |ms0| (QREFELT $ 52))
                                        (QREFELT $ 80))))
                       (#10#
                        (LIST (|spadConstant| $ 32)
                              (SPADCALL (|spadConstant| $ 32)
                                        (SPADCALL |ms0| |s1| (QREFELT $ 52))
                                        (QREFELT $ 43))
                              (SPADCALL
                               (SPADCALL (SPADCALL |iu| |d1| (QREFELT $ 52))
                                         (SPADCALL |ms0| |s1| (QREFELT $ 52))
                                         (QREFELT $ 43))
                               (QREFELT $ 80))
                              (SPADCALL
                               (SPADCALL (SPADCALL |iu| |c1| (QREFELT $ 52))
                                         |s1| (QREFELT $ 43))
                               (QREFELT $ 80)))))))))))))))) 

(SDEFUN |FELFUN;jacobiSn;3C;24|
        ((|z| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (SPROG ((|pl| (|List| (|Complex| (|Float|)))))
               (SEQ (LETT |pl| (|FELFUN;sn_cn_dn| |z| |m| $))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |pl| 1 (QREFELT $ 81))
                                 (|spadConstant| $ 78) (QREFELT $ 70))
                       (|error| "pole of jacobiSn"))
                      ('T (SPADCALL |pl| 2 (QREFELT $ 81)))))))) 

(SDEFUN |FELFUN;jacobiCn;3C;25|
        ((|z| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (SPROG ((|pl| (|List| (|Complex| (|Float|)))))
               (SEQ (LETT |pl| (|FELFUN;sn_cn_dn| |z| |m| $))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |pl| 1 (QREFELT $ 81))
                                 (|spadConstant| $ 78) (QREFELT $ 70))
                       (|error| "pole of jacobiCn"))
                      ('T (SPADCALL |pl| 3 (QREFELT $ 81)))))))) 

(SDEFUN |FELFUN;jacobiDn;3C;26|
        ((|z| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (SPROG ((|pl| (|List| (|Complex| (|Float|)))))
               (SEQ (LETT |pl| (|FELFUN;sn_cn_dn| |z| |m| $))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |pl| 1 (QREFELT $ 81))
                                 (|spadConstant| $ 78) (QREFELT $ 70))
                       (|error| "pole of jacobiDn"))
                      ('T (SPADCALL |pl| 4 (QREFELT $ 81)))))))) 

(SDEFUN |FELFUN;jacobiSn;3F;27| ((|z| (|Float|)) (|m| (|Float|)) ($ (|Float|)))
        (SPROG
         ((|res| (|Float|)) (|k| (|Float|)) (|prec| (|PositiveInteger|))
          (|obits| (|PositiveInteger|)))
         (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
              (LETT |prec| (+ |obits| 20))
              (EXIT
               (COND
                ((SPADCALL |m| (SPADCALL 1 0 10 (QREFELT $ 15)) (QREFELT $ 95))
                 (SEQ (SPADCALL |prec| (QREFELT $ 68))
                      (LETT |res| (SPADCALL |z| (QREFELT $ 96)))
                      (SPADCALL |obits| (QREFELT $ 68)) (EXIT |res|)))
                (#1='T
                 (SEQ (SPADCALL |prec| (QREFELT $ 68))
                      (COND
                       ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 74))
                        (SEQ
                         (LETT |m|
                               (SPADCALL (|spadConstant| $ 20) |m|
                                         (QREFELT $ 22)))
                         (LETT |k| (SPADCALL |m| (QREFELT $ 18)))
                         (LETT |z| (SPADCALL |z| |k| (QREFELT $ 22)))
                         (EXIT
                          (LETT |res|
                                (SPADCALL |k| (|FELFUN;sn1| |z| |m| |prec| $)
                                          (QREFELT $ 34))))))
                       (#1# (LETT |res| (|FELFUN;sn1| |z| |m| |prec| $))))
                      (SPADCALL |obits| (QREFELT $ 68)) (EXIT |res|)))))))) 

(SDEFUN |FELFUN;jacobiCn;3F;28| ((|z| (|Float|)) (|m| (|Float|)) ($ (|Float|)))
        (SPROG
         ((|res| (|Float|)) (|k| (|Float|)) (|prec| (|PositiveInteger|))
          (|obits| (|PositiveInteger|)))
         (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
              (LETT |prec| (+ |obits| 20))
              (EXIT
               (COND
                ((SPADCALL |m| (SPADCALL 1 0 10 (QREFELT $ 15)) (QREFELT $ 95))
                 (SEQ (SPADCALL |prec| (QREFELT $ 68))
                      (LETT |res|
                            (SPADCALL (|spadConstant| $ 20)
                                      (SPADCALL |z| (QREFELT $ 98))
                                      (QREFELT $ 22)))
                      (SPADCALL |obits| (QREFELT $ 68)) (EXIT |res|)))
                (#1='T
                 (SEQ (SPADCALL |prec| (QREFELT $ 68))
                      (COND
                       ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 74))
                        (SEQ
                         (LETT |m|
                               (SPADCALL (|spadConstant| $ 20) |m|
                                         (QREFELT $ 22)))
                         (LETT |k| (SPADCALL |m| (QREFELT $ 18)))
                         (LETT |z| (SPADCALL |z| |k| (QREFELT $ 22)))
                         (EXIT (LETT |res| (|FELFUN;dn1| |z| |m| |prec| $)))))
                       (#1# (LETT |res| (|FELFUN;cn1| |z| |m| |prec| $))))
                      (SPADCALL |obits| (QREFELT $ 68)) (EXIT |res|)))))))) 

(SDEFUN |FELFUN;jacobiDn;3F;29| ((|z| (|Float|)) (|m| (|Float|)) ($ (|Float|)))
        (SPROG
         ((|res| (|Float|)) (|k| (|Float|)) (|prec| (|PositiveInteger|))
          (|obits| (|PositiveInteger|)))
         (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
              (LETT |prec| (+ |obits| 20))
              (EXIT
               (COND
                ((SPADCALL |m| (SPADCALL 1 0 10 (QREFELT $ 15)) (QREFELT $ 95))
                 (SEQ (SPADCALL |prec| (QREFELT $ 68))
                      (LETT |res|
                            (SPADCALL (|spadConstant| $ 20)
                                      (SPADCALL |z| (QREFELT $ 98))
                                      (QREFELT $ 22)))
                      (SPADCALL |obits| (QREFELT $ 68)) (EXIT |res|)))
                (#1='T
                 (SEQ (SPADCALL |prec| (QREFELT $ 68))
                      (COND
                       ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 74))
                        (SEQ
                         (LETT |m|
                               (SPADCALL (|spadConstant| $ 20) |m|
                                         (QREFELT $ 22)))
                         (LETT |k| (SPADCALL |m| (QREFELT $ 18)))
                         (LETT |z| (SPADCALL |z| |k| (QREFELT $ 22)))
                         (EXIT (LETT |res| (|FELFUN;cn1| |z| |m| |prec| $)))))
                       (#1# (LETT |res| (|FELFUN;dn1| |z| |m| |prec| $))))
                      (SPADCALL |obits| (QREFELT $ 68)) (EXIT |res|)))))))) 

(SDEFUN |FELFUN;zeta2|
        ((|z| (|Float|)) (|k0| (|Float|)) (|ll| (|List| (|Float|)))
         ($ (|Float|)))
        (SPROG
         ((|snz| (|Float|)) (|res| (|Float|)) (|r| (|Float|))
          (|snf_inv| #1=(|Float|)) (|k_snz2| #2=(|Float|)) (|snz2| #2#)
          (|p| #2#) (|k1inv| #1#) (|k1| (|Float|)) (#3=#:G912 NIL) (|k| NIL)
          (|z1| (|Float|)) (|nn| (|Integer|)) (|pii| (|Float|)))
         (SEQ (LETT |res| (|spadConstant| $ 65))
              (LETT |pii| (SPADCALL (QREFELT $ 58)))
              (LETT |nn|
                    (SPADCALL
                     (SPADCALL (SPADCALL |z| |pii| (QREFELT $ 22))
                               (QREFELT $ 59))
                     (QREFELT $ 60)))
              (LETT |z1|
                    (SPADCALL |z| (SPADCALL |nn| |pii| (QREFELT $ 61))
                              (QREFELT $ 23)))
              (LETT |snz| (SPADCALL |z1| (QREFELT $ 38)))
              (SEQ (LETT |k| NIL) (LETT #3# |ll|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |k| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |k1|
                          (SPADCALL (|spadConstant| $ 20) |k| (QREFELT $ 21)))
                    (LETT |k1inv|
                          (SPADCALL (|spadConstant| $ 20) |k1| (QREFELT $ 22)))
                    (LETT |p|
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 20) |k| (QREFELT $ 23))
                           |k1inv| (QREFELT $ 34)))
                    (LETT |snz2| (SPADCALL |snz| |snz| (QREFELT $ 34)))
                    (LETT |k_snz2| (SPADCALL |k| |snz2| (QREFELT $ 34)))
                    (LETT |snf_inv|
                          (SPADCALL (|spadConstant| $ 20)
                                    (SPADCALL (|spadConstant| $ 20) |k_snz2|
                                              (QREFELT $ 21))
                                    (QREFELT $ 22)))
                    (LETT |r|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 20) |snz2|
                                      (QREFELT $ 23))
                            (SPADCALL (|spadConstant| $ 20)
                                      (SPADCALL |k| |k_snz2| (QREFELT $ 34))
                                      (QREFELT $ 23))
                            (QREFELT $ 34))
                           (QREFELT $ 18)))
                    (LETT |r|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 20) |p|
                                       (QREFELT $ 23))
                             |snz| (QREFELT $ 34))
                            |r| (QREFELT $ 34))
                           |snf_inv| (QREFELT $ 34)))
                    (LETT |res|
                          (SPADCALL
                           (SPADCALL (SPADCALL 2 |k1inv| (QREFELT $ 19)) |res|
                                     (QREFELT $ 34))
                           |r| (QREFELT $ 21)))
                    (EXIT
                     (LETT |snz|
                           (SPADCALL (SPADCALL |k1| |snz| (QREFELT $ 34))
                                     |snf_inv| (QREFELT $ 34)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FELFUN;jacobiZeta;3F;31|
        ((|z| (|Float|)) (|m| (|Float|)) ($ (|Float|)))
        (SPROG
         ((|res| (|Float|)) (|z1| (|Float|)) (|kk| (|Float|))
          (|ll| (|List| (|Float|))) (|eps| (|Float|))
          (|prec| (|PositiveInteger|)) (|obits| (|PositiveInteger|)))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 65) (QREFELT $ 95))
            (|spadConstant| $ 65))
           ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 95))
            (SPADCALL |z| (QREFELT $ 96)))
           (#1='T
            (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                 (EXIT
                  (|finally|
                   (SEQ (LETT |prec| (+ |obits| 20))
                        (SPADCALL |prec| (QREFELT $ 68))
                        (EXIT
                         (COND
                          ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 74))
                           (|error| "jacobiZeta: m > 1"))
                          (#1#
                           (SEQ
                            (LETT |eps|
                                  (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2)
                                   $))
                            (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 33)))
                            (LETT |kk| (SPADCALL |ll| (QREFELT $ 37)))
                            (LETT |z1| (SPADCALL |z| |kk| (QREFELT $ 22)))
                            (EXIT
                             (LETT |res|
                                   (|FELFUN;zeta2| |z1|
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 20) |m|
                                               (QREFELT $ 23))
                                     (QREFELT $ 18))
                                    |ll| $))))))))
                   (SPADCALL |obits| (QREFELT $ 68)))))))))) 

(SDEFUN |FELFUN;theta0|
        ((|tau| #1=(|Complex| (|Float|))) ($ (|List| (|Complex| (|Float|)))))
        (SPROG
         ((|t3| #2=(|Complex| (|Float|))) (|t2| (|Complex| (|Float|)))
          (|pp| #3=(|Complex| (|Float|))) (|nt3| #2#) (#4=#:G934 NIL) (|i| NIL)
          (#5=#:G935 NIL) (|iq2| #6=(|Complex| (|Float|)))
          (|liq2| (|List| (|Complex| (|Float|)))) (#7=#:G933 NIL)
          (|rtd| (|Float|)) (|q| #3#) (|q2| #6#) (|k| (|Integer|)) (|otau| #1#)
          (|tresh| (|Float|)) (|prec| (|PositiveInteger|)))
         (SEQ (LETT |prec| (SPADCALL (QREFELT $ 67)))
              (LETT |tresh|
                    (SPADCALL
                     (SPADCALL (SPADCALL 38 100 (QREFELT $ 29)) |prec|
                               (QREFELT $ 102))
                     (QREFELT $ 103)))
              (LETT |k| 0)
              (COND
               ((NULL
                 (SPADCALL (SPADCALL (|spadConstant| $ 20) 2 (QREFELT $ 48))
                           (SPADCALL |tau| (QREFELT $ 87)) (QREFELT $ 17)))
                (EXIT (|error| "imag(tau) must be bigger than 1/2"))))
              (LETT |otau| |tau|)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |tau| (QREFELT $ 87)) |tresh|
                                (QREFELT $ 17)))
                     (GO G191)))
                   (SEQ
                    (LETT |tau|
                          (SPADCALL (SPADCALL 2 (QREFELT $ 89)) |tau|
                                    (QREFELT $ 72)))
                    (EXIT (LETT |k| (+ |k| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |q2|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (|spadConstant| $ 20) 2 (QREFELT $ 48))
                        (SPADCALL (QREFELT $ 58)) (QREFELT $ 34))
                       (SPADCALL (QREFELT $ 104)) (QREFELT $ 72))
                      |tau| (QREFELT $ 52))
                     (QREFELT $ 105)))
              (LETT |q| (SPADCALL |q2| |q2| (QREFELT $ 52)))
              (LETT |t2|
                    (SPADCALL (SPADCALL 2 (QREFELT $ 89))
                              (SPADCALL (|spadConstant| $ 32)
                                        (SPADCALL |q| |q| (QREFELT $ 52))
                                        (QREFELT $ 42))
                              (QREFELT $ 72)))
              (LETT |t3|
                    (SPADCALL (|spadConstant| $ 32)
                              (SPADCALL (SPADCALL 2 (QREFELT $ 89)) |q|
                                        (QREFELT $ 72))
                              (QREFELT $ 42)))
              (LETT |t2|
                    (SPADCALL (SPADCALL |q2| |t2| (QREFELT $ 52)) |t2|
                              (QREFELT $ 52)))
              (LETT |t3| (SPADCALL |t3| |t3| (QREFELT $ 52)))
              (EXIT
               (COND ((EQL |k| 0) (LIST |t2| |t3|))
                     ('T
                      (SEQ
                       (LETT |rtd|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 20) 2
                                         (QREFELT $ 48))
                               (SPADCALL (QREFELT $ 58)) (QREFELT $ 34))
                              (SPADCALL |otau| (QREFELT $ 11)) (QREFELT $ 34)))
                       (LETT |iq2|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (SPADCALL (QREFELT $ 104)) |rtd|
                                         (QREFELT $ 86))
                               (QREFELT $ 80))
                              (QREFELT $ 105)))
                       (LETT |liq2| NIL)
                       (SEQ (LETT |i| 1) (LETT #7# |k|) G190
                            (COND ((|greater_SI| |i| #7#) (GO G191)))
                            (SEQ (LETT |liq2| (CONS |iq2| |liq2|))
                                 (EXIT
                                  (LETT |iq2|
                                        (SPADCALL |iq2| |iq2|
                                                  (QREFELT $ 52)))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (SEQ (LETT #5# |liq2|) (LETT |i| 1) (LETT #4# |k|) G190
                            (COND
                             ((OR (|greater_SI| |i| #4#) (ATOM #5#)
                                  (PROGN (LETT |iq2| (CAR #5#)) NIL))
                              (GO G191)))
                            (SEQ
                             (LETT |nt3| (SPADCALL |t3| |t2| (QREFELT $ 42)))
                             (LETT |t2|
                                   (SPADCALL (SPADCALL 2 (QREFELT $ 89))
                                             (SPADCALL
                                              (SPADCALL |t2| |t3|
                                                        (QREFELT $ 52))
                                              (QREFELT $ 40))
                                             (QREFELT $ 72)))
                             (LETT |pp| (SPADCALL |t2| |iq2| (QREFELT $ 52)))
                             (COND
                              ((SPADCALL (SPADCALL |pp| (QREFELT $ 11))
                                         (|spadConstant| $ 65) (QREFELT $ 17))
                               (LETT |t2| (SPADCALL |t2| (QREFELT $ 80)))))
                             (EXIT (LETT |t3| |nt3|)))
                            (LETT |i|
                                  (PROG1 (|inc_SI| |i|) (LETT #5# (CDR #5#))))
                            (GO G190) G191 (EXIT NIL))
                       (EXIT (LIST |t2| |t3|))))))))) 

(SDEFUN |FELFUN;modularInvariants|
        ((|tau| (|Complex| (|Float|))) ($ (|List| (|Complex| (|Float|)))))
        (SPROG
         ((|g3| #1=(|Complex| (|Float|))) (|g2| #1#)
          (|m2| #2=(|Complex| (|Float|))) (|m| #2#) (|k| (|Complex| (|Float|)))
          (|t3| #3=(|Complex| (|Float|))) (|t2| #3#)
          (|td| (|List| (|Complex| (|Float|)))))
         (SEQ (LETT |td| (|FELFUN;theta0| |tau| $))
              (LETT |t2| (|SPADfirst| |td|))
              (LETT |t3| (|SPADfirst| (CDR |td|)))
              (LETT |k| (SPADCALL |t2| |t3| (QREFELT $ 43)))
              (LETT |m| (SPADCALL |k| |k| (QREFELT $ 52)))
              (LETT |m2| (SPADCALL |m| |m| (QREFELT $ 52)))
              (LETT |g2|
                    (SPADCALL
                     (SPADCALL (SPADCALL 4 3 (QREFELT $ 29)) (QREFELT $ 103))
                     (SPADCALL (SPADCALL |m2| |m| (QREFELT $ 44))
                               (|spadConstant| $ 32) (QREFELT $ 42))
                     (QREFELT $ 72)))
              (LETT |g3|
                    (SPADCALL
                     (SPADCALL (SPADCALL 4 27 (QREFELT $ 29)) (QREFELT $ 103))
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL 2 (QREFELT $ 89)) |m|
                                   (QREFELT $ 72))
                         |m2| (QREFELT $ 52))
                        (SPADCALL (SPADCALL 3 (QREFELT $ 89)) |m2|
                                  (QREFELT $ 72))
                        (QREFELT $ 44))
                       (SPADCALL (SPADCALL 3 (QREFELT $ 89)) |m|
                                 (QREFELT $ 72))
                       (QREFELT $ 44))
                      (SPADCALL 2 (QREFELT $ 106)) (QREFELT $ 42))
                     (QREFELT $ 72)))
              (EXIT (LIST |g2| |g3| |t3|))))) 

(SDEFUN |FELFUN;reduce_periods|
        ((|w1| #1=(|Complex| (|Float|))) (|w2| #2=(|Complex| (|Float|)))
         ($ (|List| (|Complex| (|Float|)))))
        (SPROG
         ((|aw1| #3=(|Float|)) (#4=#:G947 NIL) (|rit| (|Float|))
          (|tau| (|Complex| (|Float|))) (|aw2| #3#) (|#G116| #3#) (|#G115| #3#)
          (|#G114| #1#) (|#G113| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |aw1| (SPADCALL |w1| (QREFELT $ 12)))
                (LETT |aw2| (SPADCALL |w2| (QREFELT $ 12)))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (COND
                        ((SPADCALL |aw2| |aw1| (QREFELT $ 74))
                         (SEQ
                          (PROGN
                           (LETT |#G113| |w2|)
                           (LETT |#G114| |w1|)
                           (LETT |w1| |#G113|)
                           (LETT |w2| |#G114|))
                          (EXIT
                           (PROGN
                            (LETT |#G115| |aw2|)
                            (LETT |#G116| |aw1|)
                            (LETT |aw1| |#G115|)
                            (LETT |aw2| |#G116|))))))
                       (LETT |tau| (SPADCALL |w1| |w2| (QREFELT $ 43)))
                       (COND
                        ((SPADCALL (SPADCALL |tau| (QREFELT $ 87))
                                   (|spadConstant| $ 65) (QREFELT $ 17))
                         (SEQ (LETT |tau| (SPADCALL |tau| (QREFELT $ 80)))
                              (EXIT
                               (LETT |w1| (SPADCALL |w1| (QREFELT $ 80)))))))
                       (LETT |rit|
                             (SPADCALL (SPADCALL |tau| (QREFELT $ 11))
                                       (QREFELT $ 59)))
                       (EXIT
                        (COND
                         ((SPADCALL |rit| (|spadConstant| $ 65) (QREFELT $ 95))
                          (PROGN (LETT #4# (LIST |w1| |w2|)) (GO #5=#:G946)))
                         ('T
                          (SEQ
                           (LETT |w1|
                                 (SPADCALL |w1|
                                           (SPADCALL |rit| |w2| (QREFELT $ 72))
                                           (QREFELT $ 44)))
                           (EXIT
                            (COND
                             ((SPADCALL
                               (SPADCALL (SPADCALL 2 3 (QREFELT $ 29))
                                         (QREFELT $ 103))
                               (SPADCALL |tau| (QREFELT $ 87)) (QREFELT $ 17))
                              (PROGN (LETT #4# (LIST |w1| |w2|)) (GO #5#)))
                             ('T
                              (LETT |aw1|
                                    (SPADCALL |w1| (QREFELT $ 12)))))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #5# (EXIT #4#)))) 

(SDEFUN |FELFUN;modularInvariantJ;2C;35|
        ((|tau| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|g2_3| (|Complex| (|Float|))) (|g3| #1=(|Complex| (|Float|)))
          (|g2| #1#) (|md| (|List| (|Complex| (|Float|))))
          (|nw| (|List| (|Complex| (|Float|)))) (|obits| (|PositiveInteger|)))
         (SEQ
          (COND
           ((NULL
             (SPADCALL (|spadConstant| $ 65) (SPADCALL |tau| (QREFELT $ 87))
                       (QREFELT $ 17)))
            (|error| "need imag(tau) > 0"))
           ('T
            (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                 (EXIT
                  (|finally|
                   (SEQ (SPADCALL (+ (* 3 |obits|) 20) (QREFELT $ 68))
                        (LETT |nw|
                              (|FELFUN;reduce_periods| |tau|
                               (|spadConstant| $ 32) $))
                        (SPADCALL (+ |obits| 20) (QREFELT $ 68))
                        (LETT |tau|
                              (SPADCALL (SPADCALL |nw| 1 (QREFELT $ 81))
                                        (SPADCALL |nw| 2 (QREFELT $ 81))
                                        (QREFELT $ 43)))
                        (LETT |md| (|FELFUN;modularInvariants| |tau| $))
                        (LETT |g2| (SPADCALL |md| 1 (QREFELT $ 81)))
                        (LETT |g3| (SPADCALL |md| 2 (QREFELT $ 81)))
                        (LETT |g2_3|
                              (SPADCALL (SPADCALL |g2| |g2| (QREFELT $ 52))
                                        |g2| (QREFELT $ 52)))
                        (EXIT
                         (SPADCALL (SPADCALL 1728 |g2_3| (QREFELT $ 41))
                                   (SPADCALL |g2_3|
                                             (SPADCALL
                                              (SPADCALL 27 |g3| (QREFELT $ 41))
                                              |g3| (QREFELT $ 52))
                                             (QREFELT $ 44))
                                   (QREFELT $ 43))))
                   (SPADCALL |obits| (QREFELT $ 68)))))))))) 

(SDEFUN |FELFUN;weierstrassInvariants;2CL;36|
        ((|w1| (|Complex| (|Float|))) (|w2| (|Complex| (|Float|)))
         ($ (|List| (|Complex| (|Float|)))))
        (SPROG
         ((|s4| #1=(|Complex| (|Float|))) (|s2| #1#)
          (|s| #2=(|Complex| (|Float|))) (|tf| #3=(|Complex| (|Float|)))
          (|g3| #3#) (|g2| #3#) (|md| (|List| (|Complex| (|Float|))))
          (|tau| #2#) (|nw| (|List| (|Complex| (|Float|))))
          (|obits| (|PositiveInteger|)))
         (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
              (EXIT
               (|finally|
                (SEQ (SPADCALL (+ (* 3 |obits|) 20) (QREFELT $ 68))
                     (LETT |nw| (|FELFUN;reduce_periods| |w1| |w2| $))
                     (SPADCALL (+ |obits| 20) (QREFELT $ 68))
                     (LETT |w1| (SPADCALL |nw| 1 (QREFELT $ 81)))
                     (LETT |w2| (SPADCALL |nw| 2 (QREFELT $ 81)))
                     (LETT |tau| (SPADCALL |w1| |w2| (QREFELT $ 43)))
                     (LETT |md| (|FELFUN;modularInvariants| |tau| $))
                     (LETT |g2| (SPADCALL |md| 1 (QREFELT $ 81)))
                     (LETT |g3| (SPADCALL |md| 2 (QREFELT $ 81)))
                     (LETT |tf| (SPADCALL |md| 3 (QREFELT $ 81)))
                     (LETT |s|
                           (SPADCALL
                            (SPADCALL (SPADCALL (QREFELT $ 58)) |tf|
                                      (QREFELT $ 72))
                            |w2| (QREFELT $ 43)))
                     (LETT |s2| (SPADCALL |s| |s| (QREFELT $ 52)))
                     (LETT |s4| (SPADCALL |s2| |s2| (QREFELT $ 52)))
                     (EXIT
                      (LIST (SPADCALL |s4| |g2| (QREFELT $ 52))
                            (SPADCALL (SPADCALL |s2| |s4| (QREFELT $ 52)) |g3|
                                      (QREFELT $ 52)))))
                (SPADCALL |obits| (QREFELT $ 68))))))) 

(SDEFUN |FELFUN;ellipticF;3F;37|
        ((|z| (|Float|)) (|m| (|Float|)) ($ (|Float|)))
        (SPROG
         ((|res| (|Float|)) (|delta| (|Float|)) (#1=#:G966 NIL) (|k| NIL)
          (|ll| (|List| (|Float|))) (|eps| (|Float|))
          (|prec| (|PositiveInteger|)) (|z2| (|Float|)) (|m2| (|Float|))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 95))
            (SPADCALL |z| (QREFELT $ 109)))
           (#2='T
            (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                 (EXIT
                  (COND
                   ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 74))
                    (SEQ (SPADCALL (+ |obits| 20) (QREFELT $ 68))
                         (LETT |m2| (SPADCALL |m| (QREFELT $ 18)))
                         (LETT |z2| (SPADCALL |m2| |z| (QREFELT $ 34)))
                         (EXIT
                          (COND
                           ((SPADCALL |z2| (|spadConstant| $ 20)
                                      (QREFELT $ 74))
                            (SEQ (SPADCALL |obits| (QREFELT $ 68))
                                 (EXIT
                                  (|error| "ellipticF: abs(z) > 1/sqrt(m)"))))
                           (#2#
                            (SEQ
                             (LETT |res|
                                   (SPADCALL
                                    (SPADCALL |z2|
                                              (SPADCALL (|spadConstant| $ 20)
                                                        |m| (QREFELT $ 22))
                                              (QREFELT $ 110))
                                    |m2| (QREFELT $ 22)))
                             (SPADCALL |obits| (QREFELT $ 68))
                             (EXIT |res|)))))))
                   ((SPADCALL |m| (|spadConstant| $ 65) (QREFELT $ 95))
                    (SPADCALL |z| (QREFELT $ 111)))
                   (#2#
                    (COND
                     ((SPADCALL (SPADCALL |z| (QREFELT $ 7))
                                (|spadConstant| $ 20) (QREFELT $ 74))
                      (|error| "ellipticF: abs(z) > 1"))
                     ((SPADCALL |z| (|spadConstant| $ 20) (QREFELT $ 95))
                      (SPADCALL |m| (QREFELT $ 69)))
                     (#2#
                      (COND
                       ((SPADCALL |z|
                                  (SPADCALL (|spadConstant| $ 20)
                                            (QREFELT $ 76))
                                  (QREFELT $ 95))
                        (SPADCALL (SPADCALL |m| (QREFELT $ 69))
                                  (QREFELT $ 76)))
                       (#2#
                        (SEQ (LETT |prec| (+ |obits| 20))
                             (SPADCALL |prec| (QREFELT $ 68))
                             (LETT |eps|
                                   (|FELFUN;two_to_minus_n|
                                    (QUOTIENT2 |prec| 2) $))
                             (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 33)))
                             (LETT |res| (SPADCALL |ll| (QREFELT $ 37)))
                             (LETT |ll| (NREVERSE |ll|))
                             (SEQ (LETT |k| NIL) (LETT #1# |ll|) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |k| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |delta|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL (|spadConstant| $ 20) |k|
                                                     (QREFELT $ 21))
                                           2 (QREFELT $ 75))
                                          (SPADCALL
                                           (SPADCALL 4 |k| (QREFELT $ 19))
                                           (SPADCALL |z| 2 (QREFELT $ 24))
                                           (QREFELT $ 34))
                                          (QREFELT $ 23)))
                                   (EXIT
                                    (LETT |z|
                                          (SPADCALL
                                           (SPADCALL 2 |z| (QREFELT $ 19))
                                           (SPADCALL
                                            (SPADCALL (|spadConstant| $ 20) |k|
                                                      (QREFELT $ 21))
                                            (SPADCALL |delta| (QREFELT $ 18))
                                            (QREFELT $ 21))
                                           (QREFELT $ 22)))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT NIL))
                             (LETT |res|
                                   (SPADCALL |res|
                                             (SPADCALL |z| (QREFELT $ 111))
                                             (QREFELT $ 34)))
                             (SPADCALL |obits| (QREFELT $ 68))
                             (EXIT |res|))))))))))))))) 

(SDEFUN |FELFUN;half_z|
        ((|z| #1=(|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|zz| #2=(|Complex| (|Float|))) (|snf| (|Complex| (|Float|)))
          (|dnz| #3=(|Complex| (|Float|))) (|cnz| #3#) (|z2| #2#) (|z0| #1#))
         (SEQ (LETT |z0| |z|) (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 52)))
              (LETT |z2|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 32)
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 32) |z2|
                                          (QREFELT $ 44))
                                (QREFELT $ 40))
                               (QREFELT $ 44))
                     (SPADCALL (|spadConstant| $ 32)
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 32)
                                          (SPADCALL |m| |z2| (QREFELT $ 52))
                                          (QREFELT $ 44))
                                (QREFELT $ 40))
                               (QREFELT $ 42))
                     (QREFELT $ 43)))
              (LETT |cnz|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 32) |z2| (QREFELT $ 44))
                     (QREFELT $ 40)))
              (LETT |dnz|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 32)
                               (SPADCALL |m| |z2| (QREFELT $ 52))
                               (QREFELT $ 44))
                     (QREFELT $ 40)))
              (LETT |snf|
                    (SPADCALL (SPADCALL |cnz| |dnz| (QREFELT $ 52))
                              (SPADCALL (|spadConstant| $ 32)
                                        (SPADCALL
                                         (SPADCALL |m| |z2| (QREFELT $ 52))
                                         |z2| (QREFELT $ 52))
                                        (QREFELT $ 44))
                              (QREFELT $ 43)))
              (LETT |z| (SPADCALL |z2| (QREFELT $ 40)))
              (LETT |zz| (SPADCALL |z| |snf| (QREFELT $ 52)))
              (COND
               ((SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL |z0| (QREFELT $ 112)) |zz|
                            (QREFELT $ 52))
                  (QREFELT $ 11))
                 (|spadConstant| $ 65) (QREFELT $ 17))
                (LETT |z| (SPADCALL |z| (QREFELT $ 80)))))
              (EXIT |z|)))) 

(SDEFUN |FELFUN;ellipticF_aux|
        ((|z| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|delta| (|Complex| (|Float|))) (#1=#:G980 NIL) (|k| NIL)
          (|sf| (|Float|)) (|nz| (|Float|))
          (|ll| (|List| (|Complex| (|Float|)))) (|res| (|Complex| (|Float|)))
          (|eps| (|Float|)) (|prec| (|PositiveInteger|))
          (|z2| (|Complex| (|Float|))) (|m2| (|Complex| (|Float|)))
          (|obits| (|PositiveInteger|)))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 32) (QREFELT $ 70))
            (SPADCALL |z| (QREFELT $ 113)))
           (#2='T
            (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                 (EXIT
                  (COND
                   ((SPADCALL (SPADCALL |m| (QREFELT $ 12))
                              (|spadConstant| $ 20) (QREFELT $ 74))
                    (SEQ (SPADCALL (+ |obits| 20) (QREFELT $ 68))
                         (LETT |m2| (SPADCALL |m| (QREFELT $ 40)))
                         (LETT |z2| (SPADCALL |m2| |z| (QREFELT $ 52)))
                         (EXIT
                          (SPADCALL
                           (|FELFUN;ellipticF_aux| |z2|
                            (SPADCALL (|spadConstant| $ 32) |m| (QREFELT $ 43))
                            $)
                           |m2| (QREFELT $ 43)))))
                   ((SPADCALL |m| (|spadConstant| $ 78) (QREFELT $ 70))
                    (SPADCALL |z| (QREFELT $ 114)))
                   ((SPADCALL |z| (|spadConstant| $ 32) (QREFELT $ 70))
                    (SPADCALL |m| (QREFELT $ 73)))
                   (#2#
                    (COND
                     ((SPADCALL |z|
                                (SPADCALL (|spadConstant| $ 32) (QREFELT $ 80))
                                (QREFELT $ 70))
                      (SPADCALL (SPADCALL |m| (QREFELT $ 73)) (QREFELT $ 80)))
                     (#2#
                      (SEQ (LETT |prec| (+ |obits| 20))
                           (SPADCALL |prec| (QREFELT $ 68))
                           (LETT |eps|
                                 (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2)
                                  $))
                           (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 51)))
                           (LETT |res| (SPADCALL |ll| (QREFELT $ 55)))
                           (LETT |ll| (NREVERSE |ll|))
                           (LETT |sf| (|spadConstant| $ 20))
                           (LETT |nz| (SPADCALL |z| (QREFELT $ 115)))
                           (COND
                            ((SPADCALL (|spadConstant| $ 20) |nz|
                                       (QREFELT $ 17))
                             (SEQ (LETT |z| (|FELFUN;half_z| |z| |m| $))
                                  (EXIT
                                   (LETT |sf| (SPADCALL 2 (QREFELT $ 89)))))))
                           (SEQ (LETT |k| NIL) (LETT #1# |ll|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |k| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (LETT |delta|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL (|spadConstant| $ 32) |k|
                                                   (QREFELT $ 42))
                                         2 (QREFELT $ 116))
                                        (SPADCALL
                                         (SPADCALL 4 |k| (QREFELT $ 41))
                                         (SPADCALL |z| 2 (QREFELT $ 45))
                                         (QREFELT $ 52))
                                        (QREFELT $ 44)))
                                 (EXIT
                                  (LETT |z|
                                        (SPADCALL
                                         (SPADCALL 2 |z| (QREFELT $ 41))
                                         (SPADCALL
                                          (SPADCALL (|spadConstant| $ 32) |k|
                                                    (QREFELT $ 42))
                                          (SPADCALL |delta| (QREFELT $ 40))
                                          (QREFELT $ 42))
                                         (QREFELT $ 43)))))
                                (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (SPADCALL (SPADCALL |sf| |res| (QREFELT $ 72))
                                      (SPADCALL |z| (QREFELT $ 114))
                                      (QREFELT $ 52))))))))))))))) 

(SDEFUN |FELFUN;ellipticF;3C;40|
        ((|z| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (SPROG ((|obits| (|PositiveInteger|)))
               (SEQ
                (COND
                 ((SPADCALL |m| (|spadConstant| $ 32) (QREFELT $ 70))
                  (SPADCALL |z| (QREFELT $ 113)))
                 ('T
                  (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                       (EXIT
                        (|finally| (|FELFUN;ellipticF_aux| |z| |m| $)
                                   (SPADCALL |obits| (QREFELT $ 68)))))))))) 

(SDEFUN |FELFUN;ellipticE;2F;41| ((|m| (|Float|)) ($ (|Float|)))
        (SPROG
         ((|e_val| #1=(|Float|)) (|p| (|Float|)) (|k1inv| (|Float|))
          (|f_val| #1#) (|k1| (|Float|)) (#2=#:G988 NIL) (|k| NIL)
          (|ll| (|List| (|Float|))) (|eps| (|Float|))
          (|prec| (|PositiveInteger|)) (|obits| (|PositiveInteger|)))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 66))
            (|error| "ellipticE: m >=1"))
           ((SPADCALL |m| (|spadConstant| $ 65) (QREFELT $ 95))
            (SPADCALL (SPADCALL (QREFELT $ 58)) 2 (QREFELT $ 48)))
           ('T
            (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                 (LETT |prec| (+ |obits| 20)) (SPADCALL |prec| (QREFELT $ 68))
                 (LETT |eps| (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2) $))
                 (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 33)))
                 (LETT |f_val|
                       (LETT |e_val|
                             (SPADCALL (SPADCALL (QREFELT $ 58)) 2
                                       (QREFELT $ 48))))
                 (SEQ (LETT |k| NIL) (LETT #2# |ll|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (LETT |k1|
                             (SPADCALL (|spadConstant| $ 20) |k|
                                       (QREFELT $ 21)))
                       (LETT |f_val| (SPADCALL |k1| |f_val| (QREFELT $ 34)))
                       (LETT |k1inv|
                             (SPADCALL (|spadConstant| $ 20) |k1|
                                       (QREFELT $ 22)))
                       (LETT |p|
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 20) |k|
                                        (QREFELT $ 23))
                              |k1inv| (QREFELT $ 34)))
                       (EXIT
                        (LETT |e_val|
                              (SPADCALL
                               (SPADCALL (SPADCALL 2 |k1inv| (QREFELT $ 19))
                                         |e_val| (QREFELT $ 34))
                               (SPADCALL |p| |f_val| (QREFELT $ 34))
                               (QREFELT $ 23)))))
                      (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                 (SPADCALL |obits| (QREFELT $ 68)) (EXIT |e_val|))))))) 

(SDEFUN |FELFUN;ellipticE;2C;42|
        ((|m| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|e_val| #1=(|Complex| (|Float|))) (|p| (|Complex| (|Float|)))
          (|k1inv| (|Complex| (|Float|))) (|f_val| #1#)
          (|k1| (|Complex| (|Float|))) (#2=#:G996 NIL) (|k| NIL)
          (|ll| (|List| (|Complex| (|Float|)))) (|eps| (|Float|))
          (|prec| (|PositiveInteger|)) (|obits| (|PositiveInteger|)))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 32) (QREFELT $ 70))
            (|error| "ellipticE: m = 1"))
           (#3='T
            (SEQ
             (LETT |e_val|
                   (SPADCALL
                    (SPADCALL (SPADCALL (QREFELT $ 58))
                              (SPADCALL 2 (QREFELT $ 89)) (QREFELT $ 22))
                    (QREFELT $ 90)))
             (EXIT
              (COND
               ((SPADCALL |m| (|spadConstant| $ 78) (QREFELT $ 70)) |e_val|)
               (#3#
                (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                     (EXIT
                      (|finally|
                       (SEQ (LETT |prec| (+ |obits| 20))
                            (SPADCALL |prec| (QREFELT $ 68))
                            (LETT |eps|
                                  (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2)
                                   $))
                            (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 51)))
                            (LETT |f_val| |e_val|)
                            (SEQ (LETT |k| NIL) (LETT #2# |ll|) G190
                                 (COND
                                  ((OR (ATOM #2#)
                                       (PROGN (LETT |k| (CAR #2#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |k1|
                                        (SPADCALL (|spadConstant| $ 32) |k|
                                                  (QREFELT $ 42)))
                                  (LETT |f_val|
                                        (SPADCALL |k1| |f_val| (QREFELT $ 52)))
                                  (LETT |k1inv|
                                        (SPADCALL (|spadConstant| $ 32) |k1|
                                                  (QREFELT $ 43)))
                                  (LETT |p|
                                        (SPADCALL
                                         (SPADCALL (|spadConstant| $ 32) |k|
                                                   (QREFELT $ 44))
                                         |k1inv| (QREFELT $ 52)))
                                  (EXIT
                                   (LETT |e_val|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL 2 |k1inv| (QREFELT $ 41))
                                           |e_val| (QREFELT $ 52))
                                          (SPADCALL |p| |f_val| (QREFELT $ 52))
                                          (QREFELT $ 44)))))
                                 (LETT #2# (CDR #2#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |e_val|))
                       (SPADCALL |obits| (QREFELT $ 68)))))))))))))) 

(SDEFUN |FELFUN;ellipticE;3F;43|
        ((|z| (|Float|)) (|m| (|Float|)) ($ (|Float|)))
        (SPROG
         ((|e_val| #1=(|Float|)) (|r| #2=(|Float|)) (|k_z2| #3=(|Float|))
          (|z2| #3#) (|p| #3#) (|k1inv| (|Float|)) (|f_val| #1#)
          (|k1| (|Float|)) (#4=#:G1012 NIL) (|k| NIL) (#5=#:G1013 NIL)
          (|lz| (|List| (|Float|))) (|delta| #6=(|Float|)) (#7=#:G1011 NIL)
          (|llr| (|List| (|Float|))) (|ll| (|List| (|Float|)))
          (|eps| (|Float|)) (|prec| (|PositiveInteger|)) (|res| #6#) (|m2| #2#)
          (|obits| (|PositiveInteger|)))
         (SEQ
          (COND ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 95)) |z|)
                (#8='T
                 (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                      (EXIT
                       (COND
                        ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 74))
                         (SEQ (SPADCALL (+ |obits| 20) (QREFELT $ 68))
                              (LETT |m2| (SPADCALL |m| (QREFELT $ 18)))
                              (LETT |z2| (SPADCALL |m2| |z| (QREFELT $ 34)))
                              (EXIT
                               (COND
                                ((SPADCALL |z2| (|spadConstant| $ 20)
                                           (QREFELT $ 74))
                                 (SEQ (SPADCALL |obits| (QREFELT $ 68))
                                      (EXIT
                                       (|error|
                                        "ellipticE: abs(z) > 1/sqrt(m)"))))
                                (#8#
                                 (SEQ
                                  (LETT |res|
                                        (SPADCALL
                                         (SPADCALL |m2|
                                                   (SPADCALL |z2|
                                                             (SPADCALL
                                                              (|spadConstant| $
                                                                              20)
                                                              |m|
                                                              (QREFELT $ 22))
                                                             (QREFELT $ 120))
                                                   (QREFELT $ 34))
                                         (SPADCALL
                                          (SPADCALL |m| (|spadConstant| $ 20)
                                                    (QREFELT $ 23))
                                          |z| (QREFELT $ 34))
                                         (QREFELT $ 23)))
                                  (SPADCALL |obits| (QREFELT $ 68))
                                  (EXIT |res|)))))))
                        ((SPADCALL |m| (|spadConstant| $ 65) (QREFELT $ 95))
                         (SPADCALL |z| (QREFELT $ 111)))
                        (#8#
                         (COND
                          ((SPADCALL (SPADCALL |z| (QREFELT $ 7))
                                     (|spadConstant| $ 20) (QREFELT $ 74))
                           (|error| "ellipticE: abs(z) > 1"))
                          ((SPADCALL |z| (|spadConstant| $ 20) (QREFELT $ 95))
                           (SPADCALL |m| (QREFELT $ 118)))
                          (#8#
                           (COND
                            ((SPADCALL |z|
                                       (SPADCALL (|spadConstant| $ 20)
                                                 (QREFELT $ 76))
                                       (QREFELT $ 95))
                             (SPADCALL (SPADCALL |m| (QREFELT $ 118))
                                       (QREFELT $ 76)))
                            (#8#
                             (SEQ (LETT |prec| (+ |obits| 20))
                                  (SPADCALL |prec| (QREFELT $ 68))
                                  (LETT |eps|
                                        (|FELFUN;two_to_minus_n|
                                         (QUOTIENT2 |prec| 2) $))
                                  (LETT |ll|
                                        (SPADCALL |m| |eps| (QREFELT $ 33)))
                                  (LETT |llr| (REVERSE |ll|)) (LETT |lz| NIL)
                                  (SEQ (LETT |k| NIL) (LETT #7# |llr|) G190
                                       (COND
                                        ((OR (ATOM #7#)
                                             (PROGN (LETT |k| (CAR #7#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |delta|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 20)
                                                          |k| (QREFELT $ 21))
                                                2 (QREFELT $ 75))
                                               (SPADCALL
                                                (SPADCALL 4 |k| (QREFELT $ 19))
                                                (SPADCALL |z| 2 (QREFELT $ 24))
                                                (QREFELT $ 34))
                                               (QREFELT $ 23)))
                                        (LETT |z|
                                              (SPADCALL
                                               (SPADCALL 2 |z| (QREFELT $ 19))
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 20)
                                                          |k| (QREFELT $ 21))
                                                (SPADCALL |delta|
                                                          (QREFELT $ 18))
                                                (QREFELT $ 21))
                                               (QREFELT $ 22)))
                                        (EXIT (LETT |lz| (CONS |z| |lz|))))
                                       (LETT #7# (CDR #7#)) (GO G190) G191
                                       (EXIT NIL))
                                  (LETT |f_val|
                                        (LETT |e_val|
                                              (SPADCALL |z| (QREFELT $ 111))))
                                  (SEQ (LETT #5# |lz|) (LETT |k| NIL)
                                       (LETT #4# |ll|) G190
                                       (COND
                                        ((OR (ATOM #4#)
                                             (PROGN (LETT |k| (CAR #4#)) NIL)
                                             (ATOM #5#)
                                             (PROGN (LETT |z| (CAR #5#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |k1|
                                              (SPADCALL (|spadConstant| $ 20)
                                                        |k| (QREFELT $ 21)))
                                        (LETT |f_val|
                                              (SPADCALL |k1| |f_val|
                                                        (QREFELT $ 34)))
                                        (LETT |k1inv|
                                              (SPADCALL (|spadConstant| $ 20)
                                                        |k1| (QREFELT $ 22)))
                                        (LETT |p|
                                              (SPADCALL
                                               (SPADCALL (|spadConstant| $ 20)
                                                         |k| (QREFELT $ 23))
                                               |k1inv| (QREFELT $ 34)))
                                        (LETT |z2|
                                              (SPADCALL |z| |z|
                                                        (QREFELT $ 34)))
                                        (LETT |k_z2|
                                              (SPADCALL |k| |z2|
                                                        (QREFELT $ 34)))
                                        (LETT |r|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 20)
                                                          |z2| (QREFELT $ 23))
                                                (SPADCALL (|spadConstant| $ 20)
                                                          (SPADCALL |k| |k_z2|
                                                                    (QREFELT $
                                                                             34))
                                                          (QREFELT $ 23))
                                                (QREFELT $ 34))
                                               (QREFELT $ 18)))
                                        (LETT |r|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL
                                                  (|spadConstant| $ 20) |p|
                                                  (QREFELT $ 23))
                                                 |z| (QREFELT $ 34))
                                                |r| (QREFELT $ 34))
                                               (SPADCALL (|spadConstant| $ 20)
                                                         |k_z2| (QREFELT $ 21))
                                               (QREFELT $ 22)))
                                        (EXIT
                                         (LETT |e_val|
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL 2 |k1inv|
                                                            (QREFELT $ 19))
                                                  |e_val| (QREFELT $ 34))
                                                 (SPADCALL |p| |f_val|
                                                           (QREFELT $ 34))
                                                 (QREFELT $ 23))
                                                |r| (QREFELT $ 21)))))
                                       (LETT #4#
                                             (PROG1 (CDR #4#)
                                               (LETT #5# (CDR #5#))))
                                       (GO G190) G191 (EXIT NIL))
                                  (SPADCALL |obits| (QREFELT $ 68))
                                  (EXIT |e_val|))))))))))))))) 

(SDEFUN |FELFUN;ellipticE_aux|
        ((|z| #1=(|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (SPROG
         ((|e_val| #2=(|Complex| (|Float|))) (|r| #3=(|Complex| (|Float|)))
          (|k_z2| #4=(|Complex| (|Float|))) (|z2| #4#) (|p| #4#)
          (|k1inv| (|Complex| (|Float|))) (|f_val| #2#)
          (|k1| (|Complex| (|Float|))) (#5=#:G1028 NIL) (|k| NIL)
          (#6=#:G1029 NIL) (|lz| (|List| (|Complex| (|Float|))))
          (|delta| (|Complex| (|Float|))) (#7=#:G1027 NIL)
          (|res0| (|Complex| (|Float|))) (|z0| #1#) (|sf| (|Float|))
          (|nz| (|Float|)) (|llr| (|List| (|Complex| (|Float|))))
          (|ll| (|List| (|Complex| (|Float|)))) (|eps| (|Float|))
          (|prec| (|PositiveInteger|)) (|m2| #3#)
          (|obits| (|PositiveInteger|)))
         (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |m| (QREFELT $ 12)) (|spadConstant| $ 20)
                           (QREFELT $ 74))
                 (SEQ (SPADCALL (+ |obits| 20) (QREFELT $ 68))
                      (LETT |m2| (SPADCALL |m| (QREFELT $ 40)))
                      (LETT |z2| (SPADCALL |m2| |z| (QREFELT $ 52)))
                      (EXIT
                       (SPADCALL
                        (SPADCALL |m2|
                                  (|FELFUN;ellipticE_aux| |z2|
                                   (SPADCALL (|spadConstant| $ 32) |m|
                                             (QREFELT $ 43))
                                   $)
                                  (QREFELT $ 52))
                        (SPADCALL
                         (SPADCALL |m| (|spadConstant| $ 32) (QREFELT $ 44))
                         |z| (QREFELT $ 52))
                        (QREFELT $ 44)))))
                ((SPADCALL |m| (|spadConstant| $ 78) (QREFELT $ 70))
                 (SPADCALL |z| (QREFELT $ 114)))
                ((SPADCALL |z| (|spadConstant| $ 32) (QREFELT $ 70))
                 (SPADCALL |m| (QREFELT $ 119)))
                (#8='T
                 (COND
                  ((SPADCALL |z|
                             (SPADCALL (|spadConstant| $ 32) (QREFELT $ 80))
                             (QREFELT $ 70))
                   (SPADCALL (SPADCALL |m| (QREFELT $ 119)) (QREFELT $ 80)))
                  (#8#
                   (SEQ (LETT |prec| (+ |obits| 20))
                        (SPADCALL |prec| (QREFELT $ 68))
                        (LETT |eps|
                              (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2) $))
                        (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 51)))
                        (LETT |llr| (REVERSE |ll|)) (LETT |lz| NIL)
                        (LETT |sf| (|spadConstant| $ 20))
                        (LETT |nz| (SPADCALL |z| (QREFELT $ 115)))
                        (LETT |res0| (|spadConstant| $ 78))
                        (COND
                         ((SPADCALL (|spadConstant| $ 20) |nz| (QREFELT $ 17))
                          (SEQ (LETT |sf| (SPADCALL 2 (QREFELT $ 89)))
                               (LETT |z0| |z|)
                               (LETT |z| (|FELFUN;half_z| |z| |m| $))
                               (EXIT
                                (LETT |res0|
                                      (SPADCALL |z0|
                                                (SPADCALL |z| 2 (QREFELT $ 45))
                                                (QREFELT $ 52)))))))
                        (SEQ (LETT |k| NIL) (LETT #7# |llr|) G190
                             (COND
                              ((OR (ATOM #7#) (PROGN (LETT |k| (CAR #7#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |delta|
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL (|spadConstant| $ 32) |k|
                                                (QREFELT $ 42))
                                      2 (QREFELT $ 116))
                                     (SPADCALL (SPADCALL 4 |k| (QREFELT $ 41))
                                               (SPADCALL |z| 2 (QREFELT $ 45))
                                               (QREFELT $ 52))
                                     (QREFELT $ 44)))
                              (LETT |z|
                                    (SPADCALL (SPADCALL 2 |z| (QREFELT $ 41))
                                              (SPADCALL
                                               (SPADCALL (|spadConstant| $ 32)
                                                         |k| (QREFELT $ 42))
                                               (SPADCALL |delta|
                                                         (QREFELT $ 40))
                                               (QREFELT $ 42))
                                              (QREFELT $ 43)))
                              (EXIT (LETT |lz| (CONS |z| |lz|))))
                             (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                        (LETT |f_val|
                              (LETT |e_val| (SPADCALL |z| (QREFELT $ 114))))
                        (SEQ (LETT #6# |lz|) (LETT |k| NIL) (LETT #5# |ll|)
                             G190
                             (COND
                              ((OR (ATOM #5#) (PROGN (LETT |k| (CAR #5#)) NIL)
                                   (ATOM #6#) (PROGN (LETT |z| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |k1|
                                    (SPADCALL (|spadConstant| $ 32) |k|
                                              (QREFELT $ 42)))
                              (LETT |f_val|
                                    (SPADCALL |k1| |f_val| (QREFELT $ 52)))
                              (LETT |k1inv|
                                    (SPADCALL (|spadConstant| $ 32) |k1|
                                              (QREFELT $ 43)))
                              (LETT |p|
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 32) |k|
                                               (QREFELT $ 44))
                                     |k1inv| (QREFELT $ 52)))
                              (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 52)))
                              (LETT |k_z2| (SPADCALL |k| |z2| (QREFELT $ 52)))
                              (LETT |r|
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL (|spadConstant| $ 32) |z2|
                                                (QREFELT $ 44))
                                      (SPADCALL (|spadConstant| $ 32)
                                                (SPADCALL |k| |k_z2|
                                                          (QREFELT $ 52))
                                                (QREFELT $ 44))
                                      (QREFELT $ 52))
                                     (QREFELT $ 40)))
                              (LETT |r|
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 32) |p|
                                                 (QREFELT $ 44))
                                       |z| (QREFELT $ 52))
                                      |r| (QREFELT $ 52))
                                     (SPADCALL (|spadConstant| $ 32) |k_z2|
                                               (QREFELT $ 42))
                                     (QREFELT $ 43)))
                              (EXIT
                               (LETT |e_val|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL 2 |k1inv| (QREFELT $ 41))
                                        |e_val| (QREFELT $ 52))
                                       (SPADCALL |p| |f_val| (QREFELT $ 52))
                                       (QREFELT $ 44))
                                      |r| (QREFELT $ 42)))))
                             (LETT #5# (PROG1 (CDR #5#) (LETT #6# (CDR #6#))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (SPADCALL (SPADCALL |sf| |e_val| (QREFELT $ 72))
                                   (SPADCALL |m| |res0| (QREFELT $ 52))
                                   (QREFELT $ 44)))))))))))) 

(SDEFUN |FELFUN;ellipticE;3C;45|
        ((|z| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (SPROG ((|obits| (|PositiveInteger|)))
               (SEQ
                (COND ((SPADCALL |m| (|spadConstant| $ 32) (QREFELT $ 70)) |z|)
                      ('T
                       (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                            (EXIT
                             (|finally| (|FELFUN;ellipticE_aux| |z| |m| $)
                                        (SPADCALL |obits|
                                                  (QREFELT $ 68)))))))))) 

(SDEFUN |FELFUN;pi0_aux| ((|t| (|Float|)) (|n1| (|Float|)) ($ (|Float|)))
        (SPROG ((|ns| (|Float|)))
               (SEQ
                (COND
                 ((SPADCALL |n1| (|spadConstant| $ 65) (QREFELT $ 95)) |t|)
                 ((SPADCALL (|spadConstant| $ 65) |n1| (QREFELT $ 17))
                  (SEQ (LETT |ns| (SPADCALL |n1| (QREFELT $ 18)))
                       (EXIT
                        (SPADCALL
                         (SPADCALL (SPADCALL |ns| |t| (QREFELT $ 34))
                                   (QREFELT $ 122))
                         |ns| (QREFELT $ 22)))))
                 ('T
                  (SEQ
                   (LETT |ns|
                         (SPADCALL (SPADCALL |n1| (QREFELT $ 76))
                                   (QREFELT $ 18)))
                   (EXIT
                    (SPADCALL
                     (SPADCALL (SPADCALL |ns| |t| (QREFELT $ 34))
                               (QREFELT $ 109))
                     |ns| (QREFELT $ 22))))))))) 

(SDEFUN |FELFUN;pi0| ((|z| (|Float|)) (|n1| (|Float|)) ($ (|Float|)))
        (|FELFUN;pi0_aux|
         (SPADCALL |z|
                   (SPADCALL
                    (SPADCALL (|spadConstant| $ 20)
                              (SPADCALL |z| 2 (QREFELT $ 24)) (QREFELT $ 23))
                    (QREFELT $ 18))
                   (QREFELT $ 22))
         |n1| $)) 

(SDEFUN |FELFUN;pi0_auxc|
        ((|t| (|Complex| (|Float|))) (|n1| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (SPROG ((|ns| (|Complex| (|Float|))))
               (SEQ
                (COND
                 ((SPADCALL |n1| (|spadConstant| $ 78) (QREFELT $ 70)) |t|)
                 ('T
                  (SEQ (LETT |ns| (SPADCALL |n1| (QREFELT $ 40)))
                       (EXIT
                        (SPADCALL
                         (SPADCALL (SPADCALL |ns| |t| (QREFELT $ 52))
                                   (QREFELT $ 123))
                         |ns| (QREFELT $ 43))))))))) 

(SDEFUN |FELFUN;pi0c|
        ((|z| (|Complex| (|Float|))) (|n1| (|Complex| (|Float|)))
         ($ (|Complex| (|Float|))))
        (|FELFUN;pi0_auxc|
         (SPADCALL |z|
                   (SPADCALL
                    (SPADCALL (|spadConstant| $ 32)
                              (SPADCALL |z| 2 (QREFELT $ 45)) (QREFELT $ 44))
                    (QREFELT $ 40))
                   (QREFELT $ 43))
         |n1| $)) 

(SDEFUN |FELFUN;ellipticPi_r|
        ((|z| #1=(|Float|)) (|n| #2=(|Float|)) (|m| (|Float|)) ($ (|Float|)))
        (SPROG
         ((|pi_val| (|Float|)) (|p_inv| (|Float|)) (|f_val| (|Float|))
          (|k1| (|Float|)) (#3=#:G1062 NIL) (|k| NIL) (#4=#:G1063 NIL)
          (#5=#:G1064 NIL) (#6=#:G1065 NIL) (|p| #7=(|Float|))
          (|lnk| (|List| (|Float|))) (|nk| #2#) (|cc| #8=(|Float|))
          (|lp| (|List| (|Float|))) (#9=#:G1061 NIL) (|lz| (|List| (|Float|)))
          (|delta| (|Float|)) (#10=#:G1060 NIL) (|z0| #1#)
          (|llr| (|List| (|Float|))) (|ll| (|List| (|Float|)))
          (|eps| (|Float|)) (|prec| (|PositiveInteger|)) (|nn1| #11=(|Float|))
          (|nn| (|Float|)) (|res1| #8#) (|n1| #7#) (|lzz| #8#) (|z2| #11#)
          (|m1| #7#))
         (SEQ
          (COND
           ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 74))
            (COND
             ((SPADCALL
               (SPADCALL |m| (SPADCALL |z| 2 (QREFELT $ 24)) (QREFELT $ 34))
               (|spadConstant| $ 20) (QREFELT $ 66))
              (|error| "m*z^2 >= 1"))
             (#12='T
              (SEQ (LETT |m1| (SPADCALL |m| (QREFELT $ 18)))
                   (EXIT
                    (SPADCALL
                     (|FELFUN;ellipticPi_r| (SPADCALL |m1| |z| (QREFELT $ 34))
                      (SPADCALL |n| |m| (QREFELT $ 22))
                      (SPADCALL (|spadConstant| $ 20) |m| (QREFELT $ 22)) $)
                     |m1| (QREFELT $ 22)))))))
           (#12#
            (SEQ (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 34)))
                 (EXIT
                  (COND
                   ((SPADCALL |z2| (|spadConstant| $ 20) (QREFELT $ 66))
                    (|error| "abs(z) >= 1"))
                   ((SPADCALL (SPADCALL |n| |z2| (QREFELT $ 34))
                              (|spadConstant| $ 20) (QREFELT $ 66))
                    (|error| "n*z^2 >= 1"))
                   ((SPADCALL |m| (|spadConstant| $ 20) (QREFELT $ 95))
                    (SEQ
                     (LETT |lzz|
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 20) |z|
                                        (QREFELT $ 21))
                              (SPADCALL (|spadConstant| $ 20) |z|
                                        (QREFELT $ 23))
                              (QREFELT $ 22))
                             (QREFELT $ 124))
                            2 (QREFELT $ 48)))
                     (EXIT
                      (COND
                       ((SPADCALL |n| (|spadConstant| $ 65) (QREFELT $ 17))
                        (SEQ
                         (LETT |n1|
                               (SPADCALL (SPADCALL |n| (QREFELT $ 76))
                                         (QREFELT $ 18)))
                         (EXIT
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL |n1|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |n1| |z| (QREFELT $ 34))
                                        (QREFELT $ 76))
                                       (QREFELT $ 122))
                                      (QREFELT $ 34))
                            |lzz| (QREFELT $ 23))
                           (SPADCALL |n| (|spadConstant| $ 20) (QREFELT $ 23))
                           (QREFELT $ 22)))))
                       ((SPADCALL |n| (|spadConstant| $ 20) (QREFELT $ 95))
                        (SPADCALL
                         (SPADCALL |lzz|
                                   (SPADCALL |z|
                                             (SPADCALL |z2|
                                                       (|spadConstant| $ 20)
                                                       (QREFELT $ 23))
                                             (QREFELT $ 22))
                                   (QREFELT $ 23))
                         2 (QREFELT $ 48)))
                       (#12#
                        (SEQ (LETT |n1| (SPADCALL |n| (QREFELT $ 18)))
                             (LETT |res1|
                                   (SPADCALL
                                    (SPADCALL |n1|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 20)
                                                          (SPADCALL |n1| |z|
                                                                    (QREFELT $
                                                                             34))
                                                          (QREFELT $ 21))
                                                (SPADCALL (|spadConstant| $ 20)
                                                          (SPADCALL |n1| |z|
                                                                    (QREFELT $
                                                                             34))
                                                          (QREFELT $ 23))
                                                (QREFELT $ 22))
                                               (QREFELT $ 124))
                                              (QREFELT $ 34))
                                    2 (QREFELT $ 48)))
                             (EXIT
                              (SPADCALL (SPADCALL |res1| |lzz| (QREFELT $ 23))
                                        (SPADCALL |n| (|spadConstant| $ 20)
                                                  (QREFELT $ 23))
                                        (QREFELT $ 22)))))))))
                   (#12#
                    (SEQ
                     (COND
                      ((SPADCALL (|spadConstant| $ 65) |n| (QREFELT $ 17))
                       (COND
                        ((SPADCALL |n| |m| (QREFELT $ 17))
                         (EXIT
                          (SEQ (LETT |nn| (SPADCALL |m| |n| (QREFELT $ 22)))
                               (LETT |nn1|
                                     (SPADCALL
                                      (SPADCALL (|spadConstant| $ 20) |n|
                                                (QREFELT $ 23))
                                      (SPADCALL (|spadConstant| $ 20) |nn|
                                                (QREFELT $ 23))
                                      (QREFELT $ 34)))
                               (EXIT
                                (SPADCALL
                                 (SPADCALL (SPADCALL |z| |m| (QREFELT $ 110))
                                           (|FELFUN;ellipticPi_r| |z| |nn| |m|
                                            $)
                                           (QREFELT $ 23))
                                 (|FELFUN;pi0_aux|
                                  (SPADCALL |z|
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL (|spadConstant| $ 20)
                                                        (SPADCALL |m| |z2|
                                                                  (QREFELT $
                                                                           34))
                                                        (QREFELT $ 23))
                                              (SPADCALL (|spadConstant| $ 20)
                                                        |z2| (QREFELT $ 23))
                                              (QREFELT $ 34))
                                             (QREFELT $ 18))
                                            (QREFELT $ 22))
                                  |nn1| $)
                                 (QREFELT $ 21))))))
                        ((SPADCALL |n| (|spadConstant| $ 65) (QREFELT $ 17))
                         (COND
                          ((SPADCALL |m| |n| (QREFELT $ 17))
                           (EXIT
                            (SEQ (LETT |nn| (SPADCALL |m| |n| (QREFELT $ 22)))
                                 (LETT |nn1|
                                       (SPADCALL
                                        (SPADCALL (|spadConstant| $ 20) |n|
                                                  (QREFELT $ 23))
                                        (SPADCALL (|spadConstant| $ 20) |nn|
                                                  (QREFELT $ 23))
                                        (QREFELT $ 34)))
                                 (EXIT
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |z| |m| (QREFELT $ 110))
                                             (|FELFUN;ellipticPi_r| |z| |nn|
                                              |m| $)
                                             (QREFELT $ 23))
                                   (|FELFUN;pi0_aux|
                                    (SPADCALL |z|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL (|spadConstant| $ 20)
                                                          (SPADCALL |m| |z2|
                                                                    (QREFELT $
                                                                             34))
                                                          (QREFELT $ 23))
                                                (SPADCALL (|spadConstant| $ 20)
                                                          |z2| (QREFELT $ 23))
                                                (QREFELT $ 34))
                                               (QREFELT $ 18))
                                              (QREFELT $ 22))
                                    |nn1| $)
                                   (QREFELT $ 21))))))))))
                      ((SPADCALL |n| (|spadConstant| $ 65) (QREFELT $ 17))
                       (COND
                        ((SPADCALL |m| |n| (QREFELT $ 17))
                         (EXIT
                          (SEQ (LETT |nn| (SPADCALL |m| |n| (QREFELT $ 22)))
                               (LETT |nn1|
                                     (SPADCALL
                                      (SPADCALL (|spadConstant| $ 20) |n|
                                                (QREFELT $ 23))
                                      (SPADCALL (|spadConstant| $ 20) |nn|
                                                (QREFELT $ 23))
                                      (QREFELT $ 34)))
                               (EXIT
                                (SPADCALL
                                 (SPADCALL (SPADCALL |z| |m| (QREFELT $ 110))
                                           (|FELFUN;ellipticPi_r| |z| |nn| |m|
                                            $)
                                           (QREFELT $ 23))
                                 (|FELFUN;pi0_aux|
                                  (SPADCALL |z|
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL (|spadConstant| $ 20)
                                                        (SPADCALL |m| |z2|
                                                                  (QREFELT $
                                                                           34))
                                                        (QREFELT $ 23))
                                              (SPADCALL (|spadConstant| $ 20)
                                                        |z2| (QREFELT $ 23))
                                              (QREFELT $ 34))
                                             (QREFELT $ 18))
                                            (QREFELT $ 22))
                                  |nn1| $)
                                 (QREFELT $ 21)))))))))
                     (LETT |prec| (SPADCALL (QREFELT $ 67)))
                     (LETT |eps|
                           (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2) $))
                     (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 33)))
                     (LETT |llr| (REVERSE |ll|)) (LETT |lz| NIL)
                     (LETT |lp| NIL) (LETT |lnk| NIL) (LETT |z0| |z|)
                     (SEQ (LETT |k| NIL) (LETT #10# |llr|) G190
                          (COND
                           ((OR (ATOM #10#) (PROGN (LETT |k| (CAR #10#)) NIL))
                            (GO G191)))
                          (SEQ
                           (LETT |delta|
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL (|spadConstant| $ 20) |k|
                                             (QREFELT $ 21))
                                   2 (QREFELT $ 75))
                                  (SPADCALL (SPADCALL 4 |k| (QREFELT $ 19))
                                            (SPADCALL |z| 2 (QREFELT $ 24))
                                            (QREFELT $ 34))
                                  (QREFELT $ 23)))
                           (LETT |z|
                                 (SPADCALL (SPADCALL 2 |z| (QREFELT $ 19))
                                           (SPADCALL
                                            (SPADCALL (|spadConstant| $ 20) |k|
                                                      (QREFELT $ 21))
                                            (SPADCALL |delta| (QREFELT $ 18))
                                            (QREFELT $ 21))
                                           (QREFELT $ 22)))
                           (EXIT (LETT |lz| (CONS |z| |lz|))))
                          (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
                     (LETT |f_val| (SPADCALL |z| (QREFELT $ 111)))
                     (LETT |nk| |n|)
                     (LETT |p|
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 20)
                                      (SPADCALL |m| |nk| (QREFELT $ 22))
                                      (QREFELT $ 23))
                            (QREFELT $ 18)))
                     (SEQ (LETT |k| NIL) (LETT #9# |llr|) G190
                          (COND
                           ((OR (ATOM #9#) (PROGN (LETT |k| (CAR #9#)) NIL))
                            (GO G191)))
                          (SEQ (LETT |lp| (CONS |p| |lp|))
                               (LETT |cc|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 20) |p|
                                                 (QREFELT $ 21))
                                       (SPADCALL (|spadConstant| $ 20) |k|
                                                 (QREFELT $ 21))
                                       (QREFELT $ 34))
                                      2 (QREFELT $ 48)))
                               (LETT |nk|
                                     (SPADCALL |nk|
                                               (SPADCALL |cc| 2 (QREFELT $ 24))
                                               (QREFELT $ 34)))
                               (LETT |lnk| (CONS |nk| |lnk|))
                               (EXIT
                                (LETT |p|
                                      (SPADCALL
                                       (SPADCALL (|spadConstant| $ 20)
                                                 (SPADCALL
                                                  (SPADCALL |k| 2
                                                            (QREFELT $ 24))
                                                  |nk| (QREFELT $ 22))
                                                 (QREFELT $ 23))
                                       (QREFELT $ 18)))))
                          (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                     (LETT |pi_val|
                           (|FELFUN;pi0| |z|
                            (SPADCALL (|spadConstant| $ 20) |nk|
                                      (QREFELT $ 23))
                            $))
                     (LETT |p_inv| (|spadConstant| $ 65))
                     (SEQ (LETT #6# |lnk|) (LETT #5# |lp|) (LETT #4# |lz|)
                          (LETT |k| NIL) (LETT #3# |ll|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |k| (CAR #3#)) NIL)
                                (ATOM #4#) (PROGN (LETT |z| (CAR #4#)) NIL)
                                (ATOM #5#) (PROGN (LETT |p| (CAR #5#)) NIL)
                                (ATOM #6#) (PROGN (LETT |nk| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (LETT |pi_val|
                                 (SPADCALL |pi_val|
                                           (SPADCALL |p_inv|
                                                     (|FELFUN;pi0| |z|
                                                      (SPADCALL
                                                       (|spadConstant| $ 20)
                                                       |nk| (QREFELT $ 23))
                                                      $)
                                                     (QREFELT $ 34))
                                           (QREFELT $ 23)))
                           (LETT |k1|
                                 (SPADCALL (|spadConstant| $ 20) |k|
                                           (QREFELT $ 21)))
                           (LETT |f_val|
                                 (SPADCALL |k1| |f_val| (QREFELT $ 34)))
                           (LETT |pi_val|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL 2 |k1| (QREFELT $ 19))
                                            |pi_val| (QREFELT $ 34))
                                  (SPADCALL
                                   (SPADCALL |p| (|spadConstant| $ 20)
                                             (QREFELT $ 23))
                                   |f_val| (QREFELT $ 34))
                                  (QREFELT $ 21)))
                           (LETT |p_inv|
                                 (SPADCALL (|spadConstant| $ 20) |p|
                                           (QREFELT $ 22)))
                           (EXIT
                            (LETT |pi_val|
                                  (SPADCALL |p_inv| |pi_val| (QREFELT $ 34)))))
                          (LETT #3#
                                (PROG1 (CDR #3#)
                                  (LETT #4#
                                        (PROG1 (CDR #4#)
                                          (LETT #5#
                                                (PROG1 (CDR #5#)
                                                  (LETT #6# (CDR #6#))))))))
                          (GO G190) G191 (EXIT NIL))
                     (EXIT
                      (SPADCALL |pi_val|
                                (SPADCALL |p_inv|
                                          (|FELFUN;pi0| |z0|
                                           (SPADCALL (|spadConstant| $ 20) |n|
                                                     (QREFELT $ 23))
                                           $)
                                          (QREFELT $ 34))
                                (QREFELT $ 23))))))))))))) 

(SDEFUN |FELFUN;ellipticPi;4F;51|
        ((|z| (|Float|)) (|n| (|Float|)) (|m| (|Float|)) ($ (|Float|)))
        (SPROG ((|obits| (|PositiveInteger|)))
               (SEQ
                (COND
                 ((SPADCALL |n| (|spadConstant| $ 65) (QREFELT $ 95))
                  (SPADCALL |z| |m| (QREFELT $ 110)))
                 ('T
                  (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                       (EXIT
                        (|finally|
                         (SEQ (SPADCALL (+ |obits| 20) (QREFELT $ 68))
                              (EXIT (|FELFUN;ellipticPi_r| |z| |n| |m| $)))
                         (SPADCALL |obits| (QREFELT $ 68)))))))))) 

(SDEFUN |FELFUN;ellipticPi_aux|
        ((|z| #1=(|Complex| (|Float|))) (|n| #2=(|Complex| (|Float|)))
         (|m| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|pi_val| (|Complex| (|Float|))) (|p_inv| #3=(|Complex| (|Float|)))
          (|f_val| (|Complex| (|Float|))) (|k1| (|Complex| (|Float|)))
          (#4=#:G1090 NIL) (|k| NIL) (#5=#:G1091 NIL) (#6=#:G1092 NIL)
          (#7=#:G1093 NIL) (|p| #8=(|Complex| (|Float|)))
          (|lnk| (|List| (|Complex| (|Float|)))) (|nk| #2#)
          (|cc| #9=(|Complex| (|Float|))) (|lp| (|List| (|Complex| (|Float|))))
          (#10=#:G1089 NIL) (|lz| (|List| (|Complex| (|Float|))))
          (|delta| (|Complex| (|Float|))) (#11=#:G1088 NIL) (|z0| #1#)
          (|llr| (|List| (|Complex| (|Float|))))
          (|ll| (|List| (|Complex| (|Float|)))) (|eps| (|Float|))
          (|prec| (|PositiveInteger|)) (|res0| #3#) (|h1| #8#)
          (|h| #12=(|Complex| (|Float|))) (|t| #9#) (|ss| #12#) (|z12| #12#)
          (|z2| #12#) (|sf| (|Float|)) (|nz| (|Float|)) (|nn1| #12#) (|nn| #9#)
          (|res1| #9#) (|n1| #8#) (|lzz| #9#) (|ctwo| (|Complex| (|Float|))))
         (SEQ
          (LETT |ctwo|
                (SPADCALL (SPADCALL 2 0 10 (QREFELT $ 15)) (QREFELT $ 90)))
          (LETT |z2| (SPADCALL |z| |z| (QREFELT $ 52)))
          (EXIT
           (COND
            ((SPADCALL |m| (|spadConstant| $ 32) (QREFELT $ 70))
             (SEQ
              (LETT |lzz|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 32) |z| (QREFELT $ 42))
                       (SPADCALL (|spadConstant| $ 32) |z| (QREFELT $ 44))
                       (QREFELT $ 43))
                      (QREFELT $ 126))
                     |ctwo| (QREFELT $ 43)))
              (EXIT
               (COND
                ((SPADCALL |n| (|spadConstant| $ 32) (QREFELT $ 70))
                 (SPADCALL
                  (SPADCALL |lzz|
                            (SPADCALL |z|
                                      (SPADCALL |z2| (|spadConstant| $ 32)
                                                (QREFELT $ 44))
                                      (QREFELT $ 43))
                            (QREFELT $ 44))
                  |ctwo| (QREFELT $ 43)))
                (#13='T
                 (SEQ (LETT |n1| (SPADCALL |n| (QREFELT $ 40)))
                      (LETT |res1|
                            (SPADCALL
                             (SPADCALL |n1|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL (|spadConstant| $ 32)
                                                   (SPADCALL |n1| |z|
                                                             (QREFELT $ 52))
                                                   (QREFELT $ 42))
                                         (SPADCALL (|spadConstant| $ 32)
                                                   (SPADCALL |n1| |z|
                                                             (QREFELT $ 52))
                                                   (QREFELT $ 44))
                                         (QREFELT $ 43))
                                        (QREFELT $ 126))
                                       (QREFELT $ 52))
                             |ctwo| (QREFELT $ 43)))
                      (EXIT
                       (SPADCALL (SPADCALL |res1| |lzz| (QREFELT $ 44))
                                 (SPADCALL |n| (|spadConstant| $ 32)
                                           (QREFELT $ 44))
                                 (QREFELT $ 43)))))))))
            ((SPADCALL (SPADCALL |n| (QREFELT $ 12))
                       (SPADCALL |m| (QREFELT $ 12)) (QREFELT $ 17))
             (SEQ (LETT |nn| (SPADCALL |m| |n| (QREFELT $ 43)))
                  (LETT |nn1|
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 32) |n| (QREFELT $ 44))
                         (SPADCALL (|spadConstant| $ 32) |nn| (QREFELT $ 44))
                         (QREFELT $ 52)))
                  (EXIT
                   (SPADCALL
                    (SPADCALL (SPADCALL |z| |m| (QREFELT $ 117))
                              (|FELFUN;ellipticPi_aux| |z| |nn| |m| $)
                              (QREFELT $ 44))
                    (|FELFUN;pi0_auxc|
                     (SPADCALL |z|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 32)
                                           (SPADCALL |m| |z2| (QREFELT $ 52))
                                           (QREFELT $ 44))
                                 (QREFELT $ 40))
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 32) |z2|
                                           (QREFELT $ 44))
                                 (QREFELT $ 40))
                                (QREFELT $ 52))
                               (QREFELT $ 43))
                     |nn1| $)
                    (QREFELT $ 42)))))
            (#13#
             (SEQ (LETT |nz| (SPADCALL |z| (QREFELT $ 115)))
                  (LETT |sf| (|spadConstant| $ 20))
                  (LETT |res0| (|spadConstant| $ 78))
                  (COND
                   ((SPADCALL (|spadConstant| $ 20) |nz| (QREFELT $ 17))
                    (SEQ (LETT |z0| |z|)
                         (LETT |sf| (SPADCALL 2 (QREFELT $ 89)))
                         (LETT |z| (|FELFUN;half_z| |z| |m| $))
                         (LETT |z2| (SPADCALL |z0| |z0| (QREFELT $ 52)))
                         (LETT |z12| (SPADCALL |z| |z| (QREFELT $ 52)))
                         (LETT |ss|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 32) |z2|
                                           (QREFELT $ 44))
                                 (QREFELT $ 40))
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 32)
                                           (SPADCALL |m| |z2| (QREFELT $ 52))
                                           (QREFELT $ 44))
                                 (QREFELT $ 40))
                                (QREFELT $ 52)))
                         (LETT |ss|
                               (SPADCALL |z2|
                                         (SPADCALL |z12| |ss| (QREFELT $ 52))
                                         (QREFELT $ 44)))
                         (LETT |t|
                               (SPADCALL (SPADCALL |z0| |z12| (QREFELT $ 52))
                                         (SPADCALL (|spadConstant| $ 32)
                                                   (SPADCALL |n| |ss|
                                                             (QREFELT $ 52))
                                                   (QREFELT $ 44))
                                         (QREFELT $ 43)))
                         (LETT |h|
                               (SPADCALL
                                (SPADCALL |n|
                                          (SPADCALL (|spadConstant| $ 32) |n|
                                                    (QREFELT $ 44))
                                          (QREFELT $ 52))
                                (SPADCALL |n| |m| (QREFELT $ 44))
                                (QREFELT $ 52)))
                         (LETT |res0|
                               (COND
                                ((SPADCALL |h| (|spadConstant| $ 78)
                                           (QREFELT $ 70))
                                 |t|)
                                (#13#
                                 (SEQ (LETT |h1| (SPADCALL |h| (QREFELT $ 40)))
                                      (EXIT
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |t| |h1| (QREFELT $ 52))
                                         (QREFELT $ 123))
                                        |h1| (QREFELT $ 43)))))))
                         (EXIT
                          (LETT |res0|
                                (SPADCALL |n| |res0| (QREFELT $ 52)))))))
                  (LETT |prec| (SPADCALL (QREFELT $ 67)))
                  (LETT |eps| (|FELFUN;two_to_minus_n| (QUOTIENT2 |prec| 2) $))
                  (LETT |ll| (SPADCALL |m| |eps| (QREFELT $ 51)))
                  (LETT |llr| (REVERSE |ll|)) (LETT |lz| NIL) (LETT |lp| NIL)
                  (LETT |lnk| NIL) (LETT |nk| |n|) (LETT |z0| |z|)
                  (SEQ (LETT |k| NIL) (LETT #11# |llr|) G190
                       (COND
                        ((OR (ATOM #11#) (PROGN (LETT |k| (CAR #11#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |delta|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 32) |k|
                                          (QREFELT $ 42))
                                2 (QREFELT $ 116))
                               (SPADCALL (SPADCALL 4 |k| (QREFELT $ 41))
                                         (SPADCALL |z| 2 (QREFELT $ 45))
                                         (QREFELT $ 52))
                               (QREFELT $ 44)))
                        (LETT |z|
                              (SPADCALL (SPADCALL 2 |z| (QREFELT $ 41))
                                        (SPADCALL
                                         (SPADCALL (|spadConstant| $ 32) |k|
                                                   (QREFELT $ 42))
                                         (SPADCALL |delta| (QREFELT $ 40))
                                         (QREFELT $ 42))
                                        (QREFELT $ 43)))
                        (EXIT (LETT |lz| (CONS |z| |lz|))))
                       (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                  (LETT |f_val| (SPADCALL |z| (QREFELT $ 114)))
                  (LETT |p|
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 32)
                                   (SPADCALL |m| |nk| (QREFELT $ 43))
                                   (QREFELT $ 44))
                         (QREFELT $ 40)))
                  (SEQ (LETT |k| NIL) (LETT #10# |llr|) G190
                       (COND
                        ((OR (ATOM #10#) (PROGN (LETT |k| (CAR #10#)) NIL))
                         (GO G191)))
                       (SEQ (LETT |lp| (CONS |p| |lp|))
                            (LETT |cc|
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL (|spadConstant| $ 32) |p|
                                              (QREFELT $ 42))
                                    (SPADCALL (|spadConstant| $ 32) |k|
                                              (QREFELT $ 42))
                                    (QREFELT $ 52))
                                   (SPADCALL 2 (QREFELT $ 106))
                                   (QREFELT $ 43)))
                            (LETT |nk|
                                  (SPADCALL |nk|
                                            (SPADCALL |cc| 2 (QREFELT $ 45))
                                            (QREFELT $ 52)))
                            (LETT |lnk| (CONS |nk| |lnk|))
                            (EXIT
                             (LETT |p|
                                   (SPADCALL
                                    (SPADCALL (|spadConstant| $ 32)
                                              (SPADCALL
                                               (SPADCALL |k| 2 (QREFELT $ 45))
                                               |nk| (QREFELT $ 43))
                                              (QREFELT $ 44))
                                    (QREFELT $ 40)))))
                       (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
                  (LETT |pi_val|
                        (|FELFUN;pi0c| |z|
                         (SPADCALL (|spadConstant| $ 32) |nk| (QREFELT $ 44))
                         $))
                  (LETT |p_inv| (|spadConstant| $ 78))
                  (SEQ (LETT #7# |lnk|) (LETT #6# |lp|) (LETT #5# |lz|)
                       (LETT |k| NIL) (LETT #4# |ll|) G190
                       (COND
                        ((OR (ATOM #4#) (PROGN (LETT |k| (CAR #4#)) NIL)
                             (ATOM #5#) (PROGN (LETT |z| (CAR #5#)) NIL)
                             (ATOM #6#) (PROGN (LETT |p| (CAR #6#)) NIL)
                             (ATOM #7#) (PROGN (LETT |nk| (CAR #7#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |pi_val|
                              (SPADCALL |pi_val|
                                        (SPADCALL |p_inv|
                                                  (|FELFUN;pi0c| |z|
                                                   (SPADCALL
                                                    (|spadConstant| $ 32) |nk|
                                                    (QREFELT $ 44))
                                                   $)
                                                  (QREFELT $ 52))
                                        (QREFELT $ 44)))
                        (LETT |k1|
                              (SPADCALL (|spadConstant| $ 32) |k|
                                        (QREFELT $ 42)))
                        (LETT |f_val| (SPADCALL |k1| |f_val| (QREFELT $ 52)))
                        (LETT |pi_val|
                              (SPADCALL
                               (SPADCALL (SPADCALL 2 |k1| (QREFELT $ 41))
                                         |pi_val| (QREFELT $ 52))
                               (SPADCALL
                                (SPADCALL |p| (|spadConstant| $ 32)
                                          (QREFELT $ 44))
                                |f_val| (QREFELT $ 52))
                               (QREFELT $ 42)))
                        (LETT |p_inv|
                              (SPADCALL (|spadConstant| $ 32) |p|
                                        (QREFELT $ 43)))
                        (EXIT
                         (LETT |pi_val|
                               (SPADCALL |p_inv| |pi_val| (QREFELT $ 52)))))
                       (LETT #4#
                             (PROG1 (CDR #4#)
                               (LETT #5#
                                     (PROG1 (CDR #5#)
                                       (LETT #6#
                                             (PROG1 (CDR #6#)
                                               (LETT #7# (CDR #7#))))))))
                       (GO G190) G191 (EXIT NIL))
                  (LETT |pi_val|
                        (SPADCALL |pi_val|
                                  (SPADCALL |p_inv|
                                            (|FELFUN;pi0c| |z0|
                                             (SPADCALL (|spadConstant| $ 32)
                                                       |n| (QREFELT $ 44))
                                             $)
                                            (QREFELT $ 52))
                                  (QREFELT $ 44)))
                  (EXIT
                   (SPADCALL (SPADCALL |sf| |pi_val| (QREFELT $ 72)) |res0|
                             (QREFELT $ 42)))))))))) 

(SDEFUN |FELFUN;ellipticPi;4C;53|
        ((|z| (|Complex| (|Float|))) (|n| (|Complex| (|Float|)))
         (|m| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG ((|m1| (|Complex| (|Float|))) (|obits| (|PositiveInteger|)))
               (SEQ
                (COND
                 ((SPADCALL |n| (|spadConstant| $ 78) (QREFELT $ 70))
                  (SPADCALL |z| |m| (QREFELT $ 117)))
                 (#1='T
                  (SEQ (LETT |obits| (SPADCALL (QREFELT $ 67)))
                       (EXIT
                        (|finally|
                         (SEQ (SPADCALL (+ |obits| 20) (QREFELT $ 68))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |m| (QREFELT $ 12))
                                           (|spadConstant| $ 20)
                                           (QREFELT $ 74))
                                 (SEQ (LETT |m1| (SPADCALL |m| (QREFELT $ 40)))
                                      (EXIT
                                       (SPADCALL
                                        (|FELFUN;ellipticPi_aux|
                                         (SPADCALL |m1| |z| (QREFELT $ 52))
                                         (SPADCALL |n| |m| (QREFELT $ 43))
                                         (SPADCALL (|spadConstant| $ 32) |m|
                                                   (QREFELT $ 43))
                                         $)
                                        |m1| (QREFELT $ 43)))))
                                (#1#
                                 (|FELFUN;ellipticPi_aux| |z| |n| |m| $)))))
                         (SPADCALL |obits| (QREFELT $ 68)))))))))) 

(SDEFUN |FELFUN;mkr|
        ((|rr| (|Complex| (|Float|))) (|g23| (|Complex| (|Float|)))
         (|r1| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG ((|pr| (|Complex| (|Float|))))
               (SEQ (LETT |pr| (SPADCALL |r1| |rr| (QREFELT $ 52)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |pr| 2 (QREFELT $ 45)) |g23|
                                (QREFELT $ 42))
                      |pr| (QREFELT $ 43)))))) 

(SDEFUN |FELFUN;cardano|
        ((|g2| (|Complex| (|Float|))) (|g3| (|Complex| (|Float|)))
         ($ (|List| (|Complex| (|Float|)))))
        (SPROG
         ((|g23| #1=(|Complex| (|Float|))) (|r1| (|Float|))
          (|rr| (|Complex| (|Float|))) (|sd1| #1#) (|sd| (|Complex| (|Float|)))
          (|dd1| #1#) (|dd| (|Complex| (|Float|))))
         (SEQ
          (LETT |dd|
                (SPADCALL
                 (SPADCALL 27 (SPADCALL |g3| 2 (QREFELT $ 45)) (QREFELT $ 41))
                 (SPADCALL |g2| 3 (QREFELT $ 45)) (QREFELT $ 44)))
          (LETT |dd1|
                (SPADCALL |dd|
                          (SPADCALL (SPADCALL 3 0 10 (QREFELT $ 15))
                                    (QREFELT $ 90))
                          (QREFELT $ 43)))
          (LETT |sd| (SPADCALL |dd1| (QREFELT $ 40)))
          (LETT |sd1|
                (SPADCALL
                 (SPADCALL |sd| (SPADCALL 3 |g3| (QREFELT $ 41))
                           (QREFELT $ 42))
                 (SPADCALL (SPADCALL 24 0 10 (QREFELT $ 15)) (QREFELT $ 90))
                 (QREFELT $ 43)))
          (LETT |rr|
                (SPADCALL |sd1| (SPADCALL 1 3 (QREFELT $ 29)) (QREFELT $ 128)))
          (LETT |r1|
                (SPADCALL (SPADCALL 3 0 10 (QREFELT $ 15)) (QREFELT $ 18)))
          (LETT |g23|
                (SPADCALL |g2|
                          (SPADCALL (SPADCALL 12 0 10 (QREFELT $ 15))
                                    (QREFELT $ 90))
                          (QREFELT $ 43)))
          (EXIT
           (LIST (|FELFUN;mkr| |rr| |g23| (|spadConstant| $ 32) $)
                 (|FELFUN;mkr| |rr| |g23|
                  (SPADCALL
                   (SPADCALL (SPADCALL (|spadConstant| $ 20) (QREFELT $ 76))
                             |r1| (QREFELT $ 79))
                   (SPADCALL (SPADCALL 2 0 10 (QREFELT $ 15)) (QREFELT $ 90))
                   (QREFELT $ 43))
                  $)
                 (|FELFUN;mkr| |rr| |g23|
                  (SPADCALL
                   (SPADCALL (SPADCALL (|spadConstant| $ 20) (QREFELT $ 76))
                             (SPADCALL |r1| (QREFELT $ 76)) (QREFELT $ 79))
                   (SPADCALL (SPADCALL 2 0 10 (QREFELT $ 15)) (QREFELT $ 90))
                   (QREFELT $ 43))
                  $)))))) 

(SDEFUN |FELFUN;weierstrassHalfPeriods;2CL;56|
        ((|g2| (|Complex| (|Float|))) (|g3| (|Complex| (|Float|)))
         ($ (|List| (|Complex| (|Float|)))))
        (SPROG
         ((|omega2| #1=(|Complex| (|Float|))) (|omega1| #1#)
          (|zq| (|Complex| (|Float|))) (|m| #1#) (|e13| (|Complex| (|Float|)))
          (|rl| (|List| (|Complex| (|Float|)))))
         (SEQ (LETT |rl| (|FELFUN;cardano| |g2| |g3| $))
              (LETT |e13|
                    (SPADCALL (SPADCALL |rl| 1 (QREFELT $ 81))
                              (SPADCALL |rl| 3 (QREFELT $ 81)) (QREFELT $ 44)))
              (LETT |m|
                    (SPADCALL
                     (SPADCALL (SPADCALL |rl| 2 (QREFELT $ 81))
                               (SPADCALL |rl| 3 (QREFELT $ 81)) (QREFELT $ 44))
                     |e13| (QREFELT $ 43)))
              (LETT |zq| (SPADCALL |e13| (QREFELT $ 40)))
              (LETT |omega1|
                    (SPADCALL
                     (SPADCALL 2 (SPADCALL |m| (QREFELT $ 73)) (QREFELT $ 41))
                     |zq| (QREFELT $ 43)))
              (LETT |omega2|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL 2
                                (SPADCALL (|spadConstant| $ 65)
                                          (SPADCALL 1 0 10 (QREFELT $ 15))
                                          (QREFELT $ 79))
                                (QREFELT $ 41))
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 32) |m| (QREFELT $ 44))
                       (QREFELT $ 73))
                      (QREFELT $ 52))
                     |zq| (QREFELT $ 43)))
              (EXIT (LIST |omega1| |omega2|))))) 

(SDEFUN |FELFUN;weierstrassP;4C;57|
        ((|g2| (|Complex| (|Float|))) (|g3| (|Complex| (|Float|)))
         (|x| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|pp| (|Complex| (|Float|))) (|x1| (|Complex| (|Float|)))
          (|zq| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
          (|e13| (|Complex| (|Float|))) (|rl| (|List| (|Complex| (|Float|)))))
         (SEQ (LETT |rl| (|FELFUN;cardano| |g2| |g3| $))
              (LETT |e13|
                    (SPADCALL (SPADCALL |rl| 1 (QREFELT $ 81))
                              (SPADCALL |rl| 3 (QREFELT $ 81)) (QREFELT $ 44)))
              (LETT |m|
                    (SPADCALL
                     (SPADCALL (SPADCALL |rl| 2 (QREFELT $ 81))
                               (SPADCALL |rl| 3 (QREFELT $ 81)) (QREFELT $ 44))
                     |e13| (QREFELT $ 43)))
              (LETT |zq| (SPADCALL |e13| (QREFELT $ 40)))
              (LETT |x1| (SPADCALL |zq| |x| (QREFELT $ 52)))
              (LETT |pp| (SPADCALL |x1| |m| (QREFELT $ 92)))
              (EXIT
               (SPADCALL (SPADCALL |rl| 3 (QREFELT $ 81))
                         (SPADCALL |e13| (SPADCALL |pp| 2 (QREFELT $ 45))
                                   (QREFELT $ 43))
                         (QREFELT $ 42)))))) 

(SDEFUN |FELFUN;weierstrassPPrime;4C;58|
        ((|g2| (|Complex| (|Float|))) (|g3| (|Complex| (|Float|)))
         (|x| (|Complex| (|Float|))) ($ (|Complex| (|Float|))))
        (SPROG
         ((|d1| #1=(|Complex| (|Float|))) (|c1| #1#) (|s1| #1#)
          (|pl| (|List| (|Complex| (|Float|)))) (|x1| (|Complex| (|Float|)))
          (|zq| (|Complex| (|Float|))) (|m| (|Complex| (|Float|)))
          (|e13| (|Complex| (|Float|))) (|rl| (|List| (|Complex| (|Float|)))))
         (SEQ (LETT |rl| (|FELFUN;cardano| |g2| |g3| $))
              (LETT |e13|
                    (SPADCALL (SPADCALL |rl| 1 (QREFELT $ 81))
                              (SPADCALL |rl| 3 (QREFELT $ 81)) (QREFELT $ 44)))
              (LETT |m|
                    (SPADCALL
                     (SPADCALL (SPADCALL |rl| 2 (QREFELT $ 81))
                               (SPADCALL |rl| 3 (QREFELT $ 81)) (QREFELT $ 44))
                     |e13| (QREFELT $ 43)))
              (LETT |zq| (SPADCALL |e13| (QREFELT $ 40)))
              (LETT |x1| (SPADCALL |zq| |x| (QREFELT $ 52)))
              (LETT |pl| (|FELFUN;sn_cn_dn| |x1| |m| $))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |pl| 1 (QREFELT $ 81))
                           (|spadConstant| $ 78) (QREFELT $ 70))
                 (|spadConstant| $ 78))
                ('T
                 (SEQ (LETT |s1| (SPADCALL |pl| 2 (QREFELT $ 81)))
                      (LETT |c1| (SPADCALL |pl| 3 (QREFELT $ 81)))
                      (LETT |d1| (SPADCALL |pl| 4 (QREFELT $ 81)))
                      (EXIT
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (SPADCALL 2 |zq| (QREFELT $ 41)) |e13|
                                     (QREFELT $ 52))
                           |c1| (QREFELT $ 52))
                          |d1| (QREFELT $ 52))
                         (SPADCALL |s1| 3 (QREFELT $ 45)) (QREFELT $ 43))
                        (QREFELT $ 80)))))))))) 

(SDEFUN |FELFUN;weierstrassP;4F;59|
        ((|g2| (|Float|)) (|g3| (|Float|)) (|x| (|Float|)) ($ (|Float|)))
        (SPADCALL
         (SPADCALL (SPADCALL |g2| (QREFELT $ 90))
                   (SPADCALL |g3| (QREFELT $ 90)) (SPADCALL |x| (QREFELT $ 90))
                   (QREFELT $ 130))
         (QREFELT $ 11))) 

(SDEFUN |FELFUN;weierstrassPPrime;4F;60|
        ((|g2| (|Float|)) (|g3| (|Float|)) (|x| (|Float|)) ($ (|Float|)))
        (SPADCALL
         (SPADCALL (SPADCALL |g2| (QREFELT $ 90))
                   (SPADCALL |g3| (QREFELT $ 90)) (SPADCALL |x| (QREFELT $ 90))
                   (QREFELT $ 131))
         (QREFELT $ 11))) 

(DECLAIM (NOTINLINE |FloatEllipticFunctions;|)) 

(DEFUN |FloatEllipticFunctions| ()
  (SPROG NIL
         (PROG (#1=#:G1112)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FloatEllipticFunctions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FloatEllipticFunctions|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|FloatEllipticFunctions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|FloatEllipticFunctions|)))))))))) 

(DEFUN |FloatEllipticFunctions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FloatEllipticFunctions|))
          (LETT $ (GETREFV 134))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FloatEllipticFunctions| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FloatEllipticFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Float|) (0 . |abs|) |FELFUN;rabs;2F;1|
              (|Complex| 6) (5 . |abs|) (10 . |real|) |FELFUN;rabs;CF;2|
              (|Integer|) (|PositiveInteger|) (15 . |float|) (|Boolean|)
              (22 . <) (28 . |sqrt|) (33 . *) (39 . |One|) (43 . +) (49 . /)
              (55 . -) (61 . ^) (|List| 6) |FELFUN;landen1;F2L;3|
              (|Fraction| 13) (67 . |One|) (71 . /) (77 . *)
              |FELFUN;landen2;FLFL;4| (83 . |One|) |FELFUN;landen;2FL;5|
              (87 . *) (|Mapping| 6 6 6) (93 . |reduce|) |FELFUN;kprod;LF;6|
              (99 . |sin|) |FELFUN;sn2;FLF;7| (104 . |sqrt|) (109 . *)
              (115 . +) (121 . /) (127 . -) (133 . ^) (|List| 9)
              |FELFUN;landen1;C2L;8| (139 . /) (145 . *)
              |FELFUN;landen2;CLFL;9| |FELFUN;landen;CFL;10| (151 . *)
              (|Mapping| 9 9 9) (157 . |reduce|) |FELFUN;kprod;LC;11|
              (163 . |sin|) |FELFUN;sn2;CLC;12| (168 . |pi|) (172 . |round|)
              (177 . |retract|) (182 . *) (188 . |base|) (192 . ~=)
              (198 . |float|) (204 . |Zero|) (208 . >=) (214 . |bits|)
              (218 . |bits|) |FELFUN;ellipticK;2F;15| (223 . =) (229 . |pi|)
              (233 . *) |FELFUN;ellipticK;2C;16| (239 . >) (245 . ^) (251 . -)
              (256 . |sign|) (261 . |Zero|) (265 . |complex|) (271 . -)
              (276 . |elt|) (282 . |cos|) (287 . |cosh|) (292 . |sinh|)
              (297 . |tanh|) (302 . *) (308 . |imag|) (313 . *)
              (319 . |coerce|) (324 . |coerce|) (329 . |positiveRemainder|)
              |FELFUN;jacobiSn;3C;24| |FELFUN;jacobiCn;3C;25|
              |FELFUN;jacobiDn;3C;26| (335 . =) (341 . |tanh|)
              |FELFUN;jacobiSn;3F;27| (346 . |cosh|) |FELFUN;jacobiCn;3F;28|
              |FELFUN;jacobiDn;3F;29| |FELFUN;jacobiZeta;3F;31| (351 . *)
              (357 . |coerce|) (362 . |imaginary|) (366 . |exp|)
              (371 . |coerce|) |FELFUN;modularInvariantJ;2C;35|
              |FELFUN;weierstrassInvariants;2CL;36| (376 . |atanh|)
              |FELFUN;ellipticF;3F;37| (381 . |asin|) (386 . |conjugate|)
              (391 . |atanh|) (396 . |asin|) (401 . |norm|) (406 . ^)
              |FELFUN;ellipticF;3C;40| |FELFUN;ellipticE;2F;41|
              |FELFUN;ellipticE;2C;42| |FELFUN;ellipticE;3F;43|
              |FELFUN;ellipticE;3C;45| (412 . |atan|) (417 . |atan|)
              (422 . |log|) |FELFUN;ellipticPi;4F;51| (427 . |log|)
              |FELFUN;ellipticPi;4C;53| (432 . ^)
              |FELFUN;weierstrassHalfPeriods;2CL;56|
              |FELFUN;weierstrassP;4C;57| |FELFUN;weierstrassPPrime;4C;58|
              |FELFUN;weierstrassP;4F;59| |FELFUN;weierstrassPPrime;4F;60|)
           '#(|weierstrassPPrime| 438 |weierstrassP| 452
              |weierstrassInvariants| 466 |weierstrassHalfPeriods| 472 |sn2|
              478 |rabs| 490 |modularInvariantJ| 500 |landen2| 505 |landen1|
              519 |landen| 531 |kprod| 543 |jacobiZeta| 553 |jacobiSn| 559
              |jacobiDn| 571 |jacobiCn| 583 |ellipticPi| 595 |ellipticK| 609
              |ellipticF| 619 |ellipticE| 631)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|jacobiSn| ((|Float|) (|Float|) (|Float|))) T)
                              '((|jacobiSn|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))
                                  (|Complex| (|Float|))))
                                T)
                              '((|jacobiCn| ((|Float|) (|Float|) (|Float|))) T)
                              '((|jacobiCn|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))
                                  (|Complex| (|Float|))))
                                T)
                              '((|jacobiDn| ((|Float|) (|Float|) (|Float|))) T)
                              '((|jacobiDn|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))
                                  (|Complex| (|Float|))))
                                T)
                              '((|jacobiZeta| ((|Float|) (|Float|) (|Float|)))
                                T)
                              '((|weierstrassP|
                                 ((|Float|) (|Float|) (|Float|) (|Float|)))
                                T)
                              '((|weierstrassP|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))
                                  (|Complex| (|Float|)) (|Complex| (|Float|))))
                                T)
                              '((|weierstrassPPrime|
                                 ((|Float|) (|Float|) (|Float|) (|Float|)))
                                T)
                              '((|weierstrassPPrime|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))
                                  (|Complex| (|Float|)) (|Complex| (|Float|))))
                                T)
                              '((|weierstrassHalfPeriods|
                                 ((|List| (|Complex| (|Float|)))
                                  (|Complex| (|Float|)) (|Complex| (|Float|))))
                                T)
                              '((|weierstrassInvariants|
                                 ((|List| (|Complex| (|Float|)))
                                  (|Complex| (|Float|)) (|Complex| (|Float|))))
                                T)
                              '((|modularInvariantJ|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))))
                                T)
                              '((|ellipticK| ((|Float|) (|Float|))) T)
                              '((|ellipticK|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))))
                                T)
                              '((|ellipticE| ((|Float|) (|Float|))) T)
                              '((|ellipticE|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))))
                                T)
                              '((|ellipticE| ((|Float|) (|Float|) (|Float|)))
                                T)
                              '((|ellipticE|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))
                                  (|Complex| (|Float|))))
                                T)
                              '((|ellipticF| ((|Float|) (|Float|) (|Float|)))
                                T)
                              '((|ellipticF|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))
                                  (|Complex| (|Float|))))
                                T)
                              '((|ellipticPi|
                                 ((|Float|) (|Float|) (|Float|) (|Float|)))
                                T)
                              '((|ellipticPi|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))
                                  (|Complex| (|Float|)) (|Complex| (|Float|))))
                                T)
                              '((|rabs| ((|Float|) (|Float|))) T)
                              '((|rabs| ((|Float|) (|Complex| (|Float|)))) T)
                              '((|landen1|
                                 ((|List| (|Float|)) (|Float|)
                                  (|List| (|Float|))))
                                T)
                              '((|landen1|
                                 ((|List| (|Complex| (|Float|)))
                                  (|Complex| (|Float|))
                                  (|List| (|Complex| (|Float|)))))
                                T)
                              '((|landen2|
                                 ((|List| (|Float|)) (|Float|)
                                  (|List| (|Float|)) (|Float|)))
                                T)
                              '((|landen2|
                                 ((|List| (|Complex| (|Float|)))
                                  (|Complex| (|Float|))
                                  (|List| (|Complex| (|Float|))) (|Float|)))
                                T)
                              '((|landen|
                                 ((|List| (|Float|)) (|Float|) (|Float|)))
                                T)
                              '((|landen|
                                 ((|List| (|Complex| (|Float|)))
                                  (|Complex| (|Float|)) (|Float|)))
                                T)
                              '((|kprod| ((|Float|) (|List| (|Float|)))) T)
                              '((|kprod|
                                 ((|Complex| (|Float|))
                                  (|List| (|Complex| (|Float|)))))
                                T)
                              '((|sn2|
                                 ((|Float|) (|Float|) (|List| (|Float|))))
                                T)
                              '((|sn2|
                                 ((|Complex| (|Float|)) (|Complex| (|Float|))
                                  (|List| (|Complex| (|Float|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 133
                                            '(1 6 0 0 7 1 9 0 0 10 1 9 6 0 11 3
                                              6 0 13 13 14 15 2 6 16 0 0 17 1 6
                                              0 0 18 2 6 0 14 0 19 0 6 0 20 2 6
                                              0 0 0 21 2 6 0 0 0 22 2 6 0 0 0
                                              23 2 6 0 0 14 24 0 27 0 28 2 27 0
                                              13 13 29 2 6 0 27 0 30 0 9 0 32 2
                                              6 0 0 0 34 2 25 6 35 0 36 1 6 0 0
                                              38 1 9 0 0 40 2 9 0 14 0 41 2 9 0
                                              0 0 42 2 9 0 0 0 43 2 9 0 0 0 44
                                              2 9 0 0 14 45 2 6 0 0 13 48 2 9 0
                                              27 0 49 2 9 0 0 0 52 2 46 9 53 0
                                              54 1 9 0 0 56 0 6 0 58 1 6 0 0 59
                                              1 6 13 0 60 2 6 0 13 0 61 0 6 14
                                              62 2 13 16 0 0 63 2 6 0 13 13 64
                                              0 6 0 65 2 6 16 0 0 66 0 6 14 67
                                              1 6 14 14 68 2 9 16 0 0 70 0 9 0
                                              71 2 9 0 6 0 72 2 6 16 0 0 74 2 6
                                              0 0 13 75 1 6 0 0 76 1 6 13 0 77
                                              0 9 0 78 2 9 0 6 6 79 1 9 0 0 80
                                              2 46 9 0 13 81 1 9 0 0 82 1 9 0 0
                                              83 1 9 0 0 84 1 9 0 0 85 2 9 0 0
                                              6 86 1 9 6 0 87 2 9 0 13 0 88 1 6
                                              0 13 89 1 9 0 6 90 2 13 0 0 0 91
                                              2 6 16 0 0 95 1 6 0 0 96 1 6 0 0
                                              98 2 27 0 0 13 102 1 6 0 27 103 0
                                              9 0 104 1 9 0 0 105 1 9 0 13 106
                                              1 6 0 0 109 1 6 0 0 111 1 9 0 0
                                              112 1 9 0 0 113 1 9 0 0 114 1 9 6
                                              0 115 2 9 0 0 13 116 1 6 0 0 122
                                              1 9 0 0 123 1 6 0 0 124 1 9 0 0
                                              126 2 9 0 0 27 128 3 0 9 9 9 9
                                              131 3 0 6 6 6 6 133 3 0 9 9 9 9
                                              130 3 0 6 6 6 6 132 2 0 46 9 9
                                              108 2 0 46 9 9 129 2 0 9 9 46 57
                                              2 0 6 6 25 39 1 0 6 6 8 1 0 6 9
                                              12 1 0 9 9 107 3 0 25 6 25 6 31 3
                                              0 46 9 46 6 50 2 0 25 6 25 26 2 0
                                              46 9 46 47 2 0 25 6 6 33 2 0 46 9
                                              6 51 1 0 6 25 37 1 0 9 46 55 2 0
                                              6 6 6 101 2 0 9 9 9 92 2 0 6 6 6
                                              97 2 0 9 9 9 94 2 0 6 6 6 100 2 0
                                              9 9 9 93 2 0 6 6 6 99 3 0 9 9 9 9
                                              127 3 0 6 6 6 6 125 1 0 6 6 69 1
                                              0 9 9 73 2 0 9 9 9 117 2 0 6 6 6
                                              110 1 0 9 9 119 1 0 6 6 118 2 0 9
                                              9 9 121 2 0 6 6 6 120)))))
           '|lookupComplete|)) 

(MAKEPROP '|FloatEllipticFunctions| 'NILADIC T) 

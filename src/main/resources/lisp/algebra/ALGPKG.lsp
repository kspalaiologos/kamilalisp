
(SDEFUN |ALGPKG;convVM| ((|v| (|Vector| R)) ($ (|Matrix| R)))
        (SPROG
         ((|z| (|Integer|)) (#1=#:G711 NIL) (|j| NIL) (#2=#:G710 NIL) (|i| NIL)
          (|cond| (|Matrix| R)))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (QREFELT $ 10) (QREFELT $ 10)
                              (|spadConstant| $ 16)))
          (LETT |z| 0)
          (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #1# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #1#) (GO G191)))
                      (SEQ (LETT |z| (+ |z| 1))
                           (EXIT
                            (SPADCALL |cond| |i| |j|
                                      (SPADCALL |v| |z| (QREFELT $ 20))
                                      (QREFELT $ 22))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |cond|)))) 

(SDEFUN |ALGPKG;radicalOfLeftTraceForm;L;2| (($ (|List| A)))
        (SPROG ((|ma| (|Matrix| R)))
               (SEQ (LETT |ma| (SPADCALL (QREFELT $ 23)))
                    (EXIT
                     (SPADCALL (ELT $ 24) (SPADCALL |ma| (QREFELT $ 26))
                               (QREFELT $ 30)))))) 

(SDEFUN |ALGPKG;basisOfLeftAnnihilator;AL;3| ((|a| (A)) ($ (|List| A)))
        (SPROG
         ((|cond| (|Matrix| R)) (#1=#:G722 NIL) (#2=#:G724 NIL) (|i| NIL)
          (#3=#:G723 NIL) (|ca| (|Matrix| R)))
         (SEQ
          (LETT |ca|
                (SPADCALL
                 (SPADCALL (SPADCALL |a| (QREFELT $ 32)) (QREFELT $ 33))
                 (QREFELT $ 34)))
          (LETT |cond|
                (SPADCALL (ELT $ 35)
                          (PROGN
                           (LETT #3# (GETREFV #4=(QVSIZE (QREFELT $ 15))))
                           (SEQ (LETT |i| 1) (LETT #2# #4#) (LETT #1# 0) G190
                                (COND ((|greater_SI| |i| #2#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SETELT #3# #1#
                                          (SPADCALL |ca|
                                                    (SPADCALL
                                                     (SPADCALL (QREFELT $ 15)
                                                               |i|
                                                               (QREFELT $ 36))
                                                     (QREFELT $ 34))
                                                    (QREFELT $ 37)))))
                                (LETT #1#
                                      (PROG1 (|inc_SI| #1#)
                                        (LETT |i| (|inc_SI| |i|))))
                                (GO G190) G191 (EXIT NIL))
                           #3#)
                          (QREFELT $ 39)))
          (EXIT
           (SPADCALL (ELT $ 24) (SPADCALL |cond| (QREFELT $ 26))
                     (QREFELT $ 30)))))) 

(SDEFUN |ALGPKG;basisOfRightAnnihilator;AL;4| ((|a| (A)) ($ (|List| A)))
        (SPROG
         ((|cond| (|Matrix| R)) (#1=#:G732 NIL) (#2=#:G734 NIL) (|i| NIL)
          (#3=#:G733 NIL) (|ca| (|Matrix| R)))
         (SEQ
          (LETT |ca|
                (SPADCALL
                 (SPADCALL (SPADCALL |a| (QREFELT $ 32)) (QREFELT $ 33))
                 (QREFELT $ 34)))
          (LETT |cond|
                (SPADCALL (ELT $ 35)
                          (PROGN
                           (LETT #3# (GETREFV #4=(QVSIZE (QREFELT $ 15))))
                           (SEQ (LETT |i| 1) (LETT #2# #4#) (LETT #1# 0) G190
                                (COND ((|greater_SI| |i| #2#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SETELT #3# #1#
                                          (SPADCALL |ca|
                                                    (SPADCALL (QREFELT $ 15)
                                                              |i|
                                                              (QREFELT $ 36))
                                                    (QREFELT $ 37)))))
                                (LETT #1#
                                      (PROG1 (|inc_SI| #1#)
                                        (LETT |i| (|inc_SI| |i|))))
                                (GO G190) G191 (EXIT NIL))
                           #3#)
                          (QREFELT $ 39)))
          (EXIT
           (SPADCALL (ELT $ 24) (SPADCALL |cond| (QREFELT $ 26))
                     (QREFELT $ 30)))))) 

(SDEFUN |ALGPKG;basisOfLeftNucloid;L;5| (($ (|List| (|Matrix| R))))
        (SPROG
         ((#1=#:G755 NIL) (|sol| NIL) (#2=#:G754 NIL) (|r2| (|Integer|))
          (|r1| (|Integer|)) (#3=#:G753 NIL) (|r| NIL) (|z| (|Integer|))
          (#4=#:G752 NIL) (|k| NIL) (#5=#:G751 NIL) (|j| NIL) (#6=#:G750 NIL)
          (|i| NIL) (|condo| #7=(|Matrix| R)) (|cond| #7#))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (QREFELT $ 12) (QREFELT $ 11)
                              (|spadConstant| $ 16)))
          (LETT |condo|
                (MAKE_MATRIX1 (QREFELT $ 12) (QREFELT $ 11)
                              (|spadConstant| $ 16)))
          (LETT |z| 0)
          (SEQ (LETT |i| 1) (LETT #6# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |i| #6#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #5# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #5#) (GO G191)))
                      (SEQ (LETT |r1| 0)
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #4# (QREFELT $ 10)) G190
                                 (COND ((|greater_SI| |k| #4#) (GO G191)))
                                 (SEQ (LETT |z| (+ |z| 1)) (LETT |r2| |i|)
                                      (EXIT
                                       (SEQ (LETT |r| 1)
                                            (LETT #3# (QREFELT $ 10)) G190
                                            (COND
                                             ((|greater_SI| |r| #3#)
                                              (GO G191)))
                                            (SEQ (LETT |r1| (+ |r1| 1))
                                                 (SPADCALL |cond| |z| |r1|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (QREFELT $ 15) |r|
                                                             (QREFELT $ 36))
                                                            |i| |j|
                                                            (QREFELT $ 42))
                                                           (QREFELT $ 22))
                                                 (SPADCALL |condo| |z| |r2|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 15)
                                                              |k|
                                                              (QREFELT $ 36))
                                                             |r| |j|
                                                             (QREFELT $ 42))
                                                            (QREFELT $ 43))
                                                           (QREFELT $ 22))
                                                 (EXIT
                                                  (LETT |r2|
                                                        (+ |r2|
                                                           (QREFELT $ 10)))))
                                            (LETT |r| (|inc_SI| |r|)) (GO G190)
                                            G191 (EXIT NIL))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |sol| NIL)
                 (LETT #1#
                       (SPADCALL (SPADCALL |cond| |condo| (QREFELT $ 44))
                                 (QREFELT $ 26)))
                 G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |sol| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ (EXIT (LETT #2# (CONS (|ALGPKG;convVM| |sol| $) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |ALGPKG;basisOfCommutingElements;L;6| (($ (|List| A)))
        (SPROG
         ((|cond| (|Matrix| R)) (|gam| (|Matrix| R)) (#1=#:G763 NIL)
          (#2=#:G765 NIL) (|i| NIL) (#3=#:G764 NIL))
         (SEQ
          (LETT |cond|
                (SPADCALL (ELT $ 35)
                          (PROGN
                           (LETT #3# (GETREFV #4=(QVSIZE (QREFELT $ 15))))
                           (SEQ (LETT |i| 1) (LETT #2# #4#) (LETT #1# 0) G190
                                (COND ((|greater_SI| |i| #2#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SETELT #3# #1#
                                          (SPADCALL
                                           (LETT |gam|
                                                 (SPADCALL (QREFELT $ 15) |i|
                                                           (QREFELT $ 36)))
                                           (SPADCALL |gam| (QREFELT $ 34))
                                           (QREFELT $ 47)))))
                                (LETT #1#
                                      (PROG1 (|inc_SI| #1#)
                                        (LETT |i| (|inc_SI| |i|))))
                                (GO G190) G191 (EXIT NIL))
                           #3#)
                          (QREFELT $ 39)))
          (EXIT
           (SPADCALL (ELT $ 24) (SPADCALL |cond| (QREFELT $ 26))
                     (QREFELT $ 30)))))) 

(SDEFUN |ALGPKG;basisOfLeftNucleus;L;7| (($ (|List| A)))
        (SPROG
         ((|entry| (R)) (#1=#:G785 NIL) (|l| NIL) (#2=#:G784 NIL) (|i| NIL)
          (|z| (|Integer|)) (#3=#:G783 NIL) (|s| NIL) (#4=#:G782 NIL) (|j| NIL)
          (#5=#:G781 NIL) (|k| NIL) (|condi| (|Matrix| R)))
         (SEQ
          (LETT |condi|
                (MAKE_MATRIX1 (QREFELT $ 12) (QREFELT $ 10)
                              (|spadConstant| $ 16)))
          (LETT |z| 0)
          (SEQ (LETT |k| 1) (LETT #5# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |k| #5#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #4# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #4#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SEQ (LETT |s| 1) (LETT #3# (QREFELT $ 10)) G190
                             (COND ((|greater_SI| |s| #3#) (GO G191)))
                             (SEQ (LETT |z| (+ |z| 1))
                                  (EXIT
                                   (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 10))
                                        G190
                                        (COND
                                         ((|greater_SI| |i| #2#) (GO G191)))
                                        (SEQ
                                         (LETT |entry| (|spadConstant| $ 16))
                                         (SEQ (LETT |l| 1)
                                              (LETT #1# (QREFELT $ 10)) G190
                                              (COND
                                               ((|greater_SI| |l| #1#)
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT |entry|
                                                      (SPADCALL
                                                       (SPADCALL |entry|
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (QREFELT $
                                                                             15)
                                                                    |l|
                                                                    (QREFELT $
                                                                             36))
                                                                   |j| |k|
                                                                   (QREFELT $
                                                                            42))
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (QREFELT $
                                                                             15)
                                                                    |s|
                                                                    (QREFELT $
                                                                             36))
                                                                   |i| |l|
                                                                   (QREFELT $
                                                                            42))
                                                                  (QREFELT $
                                                                           49))
                                                                 (QREFELT $
                                                                          50))
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (QREFELT $ 15) |l|
                                                          (QREFELT $ 36))
                                                         |i| |j|
                                                         (QREFELT $ 42))
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (QREFELT $ 15) |s|
                                                          (QREFELT $ 36))
                                                         |l| |k|
                                                         (QREFELT $ 42))
                                                        (QREFELT $ 49))
                                                       (QREFELT $ 51)))))
                                              (LETT |l| (|inc_SI| |l|))
                                              (GO G190) G191 (EXIT NIL))
                                         (EXIT
                                          (SPADCALL |condi| |z| |i| |entry|
                                                    (QREFELT $ 22))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT NIL))))
                             (LETT |s| (|inc_SI| |s|)) (GO G190) G191
                             (EXIT NIL))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (SPADCALL (ELT $ 24) (SPADCALL |condi| (QREFELT $ 26))
                     (QREFELT $ 30)))))) 

(SDEFUN |ALGPKG;basisOfRightNucleus;L;8| (($ (|List| A)))
        (SPROG
         ((|entry| (R)) (#1=#:G805 NIL) (|l| NIL) (#2=#:G804 NIL) (|i| NIL)
          (|z| (|Integer|)) (#3=#:G803 NIL) (|s| NIL) (#4=#:G802 NIL) (|j| NIL)
          (#5=#:G801 NIL) (|k| NIL) (|condo| (|Matrix| R)))
         (SEQ
          (LETT |condo|
                (MAKE_MATRIX1 (QREFELT $ 12) (QREFELT $ 10)
                              (|spadConstant| $ 16)))
          (LETT |z| 0)
          (SEQ (LETT |k| 1) (LETT #5# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |k| #5#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #4# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #4#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SEQ (LETT |s| 1) (LETT #3# (QREFELT $ 10)) G190
                             (COND ((|greater_SI| |s| #3#) (GO G191)))
                             (SEQ (LETT |z| (+ |z| 1))
                                  (EXIT
                                   (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 10))
                                        G190
                                        (COND
                                         ((|greater_SI| |i| #2#) (GO G191)))
                                        (SEQ
                                         (LETT |entry| (|spadConstant| $ 16))
                                         (SEQ (LETT |l| 1)
                                              (LETT #1# (QREFELT $ 10)) G190
                                              (COND
                                               ((|greater_SI| |l| #1#)
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT |entry|
                                                      (SPADCALL
                                                       (SPADCALL |entry|
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (QREFELT $
                                                                             15)
                                                                    |l|
                                                                    (QREFELT $
                                                                             36))
                                                                   |k| |i|
                                                                   (QREFELT $
                                                                            42))
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (QREFELT $
                                                                             15)
                                                                    |s|
                                                                    (QREFELT $
                                                                             36))
                                                                   |j| |l|
                                                                   (QREFELT $
                                                                            42))
                                                                  (QREFELT $
                                                                           49))
                                                                 (QREFELT $
                                                                          50))
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (QREFELT $ 15) |l|
                                                          (QREFELT $ 36))
                                                         |j| |k|
                                                         (QREFELT $ 42))
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (QREFELT $ 15) |s|
                                                          (QREFELT $ 36))
                                                         |l| |i|
                                                         (QREFELT $ 42))
                                                        (QREFELT $ 49))
                                                       (QREFELT $ 51)))))
                                              (LETT |l| (|inc_SI| |l|))
                                              (GO G190) G191 (EXIT NIL))
                                         (EXIT
                                          (SPADCALL |condo| |z| |i| |entry|
                                                    (QREFELT $ 22))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT NIL))))
                             (LETT |s| (|inc_SI| |s|)) (GO G190) G191
                             (EXIT NIL))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (SPADCALL (ELT $ 24) (SPADCALL |condo| (QREFELT $ 26))
                     (QREFELT $ 30)))))) 

(SDEFUN |ALGPKG;basisOfMiddleNucleus;L;9| (($ (|List| A)))
        (SPROG
         ((|entry| (R)) (#1=#:G825 NIL) (|l| NIL) (#2=#:G824 NIL) (|i| NIL)
          (|z| (|Integer|)) (#3=#:G823 NIL) (|s| NIL) (#4=#:G822 NIL) (|j| NIL)
          (#5=#:G821 NIL) (|k| NIL) (|conda| (|Matrix| R)))
         (SEQ
          (LETT |conda|
                (MAKE_MATRIX1 (QREFELT $ 12) (QREFELT $ 10)
                              (|spadConstant| $ 16)))
          (LETT |z| 0)
          (SEQ (LETT |k| 1) (LETT #5# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |k| #5#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #4# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #4#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SEQ (LETT |s| 1) (LETT #3# (QREFELT $ 10)) G190
                             (COND ((|greater_SI| |s| #3#) (GO G191)))
                             (SEQ (LETT |z| (+ |z| 1))
                                  (EXIT
                                   (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 10))
                                        G190
                                        (COND
                                         ((|greater_SI| |i| #2#) (GO G191)))
                                        (SEQ
                                         (LETT |entry| (|spadConstant| $ 16))
                                         (SEQ (LETT |l| 1)
                                              (LETT #1# (QREFELT $ 10)) G190
                                              (COND
                                               ((|greater_SI| |l| #1#)
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT |entry|
                                                      (SPADCALL
                                                       (SPADCALL |entry|
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (QREFELT $
                                                                             15)
                                                                    |l|
                                                                    (QREFELT $
                                                                             36))
                                                                   |j| |i|
                                                                   (QREFELT $
                                                                            42))
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (QREFELT $
                                                                             15)
                                                                    |s|
                                                                    (QREFELT $
                                                                             36))
                                                                   |l| |k|
                                                                   (QREFELT $
                                                                            42))
                                                                  (QREFELT $
                                                                           49))
                                                                 (QREFELT $
                                                                          50))
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (QREFELT $ 15) |l|
                                                          (QREFELT $ 36))
                                                         |i| |k|
                                                         (QREFELT $ 42))
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (QREFELT $ 15) |s|
                                                          (QREFELT $ 36))
                                                         |j| |l|
                                                         (QREFELT $ 42))
                                                        (QREFELT $ 49))
                                                       (QREFELT $ 51)))))
                                              (LETT |l| (|inc_SI| |l|))
                                              (GO G190) G191 (EXIT NIL))
                                         (EXIT
                                          (SPADCALL |conda| |z| |i| |entry|
                                                    (QREFELT $ 22))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT NIL))))
                             (LETT |s| (|inc_SI| |s|)) (GO G190) G191
                             (EXIT NIL))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (SPADCALL (ELT $ 24) (SPADCALL |conda| (QREFELT $ 26))
                     (QREFELT $ 30)))))) 

(SDEFUN |ALGPKG;basisOfNucleus;L;10| (($ (|List| A)))
        (SPROG
         ((|ent| (R)) (|enter| (R)) (|entry| (R)) (#1=#:G846 NIL) (|l| NIL)
          (#2=#:G845 NIL) (|i| NIL) (|w| (|Integer|)) (|u| (|Integer|))
          (|z| (|Integer|)) (#3=#:G844 NIL) (|s| NIL) (#4=#:G843 NIL) (|j| NIL)
          (#5=#:G842 NIL) (|k| NIL) (|condi| (|Matrix| R)))
         (SEQ
          (LETT |condi|
                (MAKE_MATRIX1 (* 3 (QREFELT $ 12)) (QREFELT $ 10)
                              (|spadConstant| $ 16)))
          (LETT |z| 0) (LETT |u| (QREFELT $ 12))
          (LETT |w| (* 2 (QREFELT $ 12)))
          (SEQ (LETT |k| 1) (LETT #5# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |k| #5#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #4# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #4#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SEQ (LETT |s| 1) (LETT #3# (QREFELT $ 10)) G190
                             (COND ((|greater_SI| |s| #3#) (GO G191)))
                             (SEQ (LETT |z| (+ |z| 1)) (LETT |u| (+ |u| 1))
                                  (LETT |w| (+ |w| 1))
                                  (EXIT
                                   (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 10))
                                        G190
                                        (COND
                                         ((|greater_SI| |i| #2#) (GO G191)))
                                        (SEQ
                                         (LETT |entry| (|spadConstant| $ 16))
                                         (LETT |enter| (|spadConstant| $ 16))
                                         (LETT |ent| (|spadConstant| $ 16))
                                         (SEQ (LETT |l| 1)
                                              (LETT #1# (QREFELT $ 10)) G190
                                              (COND
                                               ((|greater_SI| |l| #1#)
                                                (GO G191)))
                                              (SEQ
                                               (LETT |entry|
                                                     (SPADCALL
                                                      (SPADCALL |entry|
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (QREFELT $
                                                                            15)
                                                                   |l|
                                                                   (QREFELT $
                                                                            36))
                                                                  |j| |k|
                                                                  (QREFELT $
                                                                           42))
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (QREFELT $
                                                                            15)
                                                                   |s|
                                                                   (QREFELT $
                                                                            36))
                                                                  |i| |l|
                                                                  (QREFELT $
                                                                           42))
                                                                 (QREFELT $
                                                                          49))
                                                                (QREFELT $ 50))
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (QREFELT $ 15) |l|
                                                         (QREFELT $ 36))
                                                        |i| |j| (QREFELT $ 42))
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (QREFELT $ 15) |s|
                                                         (QREFELT $ 36))
                                                        |l| |k| (QREFELT $ 42))
                                                       (QREFELT $ 49))
                                                      (QREFELT $ 51)))
                                               (LETT |enter|
                                                     (SPADCALL
                                                      (SPADCALL |enter|
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (QREFELT $
                                                                            15)
                                                                   |l|
                                                                   (QREFELT $
                                                                            36))
                                                                  |k| |i|
                                                                  (QREFELT $
                                                                           42))
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (QREFELT $
                                                                            15)
                                                                   |s|
                                                                   (QREFELT $
                                                                            36))
                                                                  |j| |l|
                                                                  (QREFELT $
                                                                           42))
                                                                 (QREFELT $
                                                                          49))
                                                                (QREFELT $ 50))
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (QREFELT $ 15) |l|
                                                         (QREFELT $ 36))
                                                        |j| |k| (QREFELT $ 42))
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (QREFELT $ 15) |s|
                                                         (QREFELT $ 36))
                                                        |l| |i| (QREFELT $ 42))
                                                       (QREFELT $ 49))
                                                      (QREFELT $ 51)))
                                               (EXIT
                                                (LETT |ent|
                                                      (SPADCALL
                                                       (SPADCALL |ent|
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (QREFELT $
                                                                             15)
                                                                    |l|
                                                                    (QREFELT $
                                                                             36))
                                                                   |j| |k|
                                                                   (QREFELT $
                                                                            42))
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (QREFELT $
                                                                             15)
                                                                    |s|
                                                                    (QREFELT $
                                                                             36))
                                                                   |i| |l|
                                                                   (QREFELT $
                                                                            42))
                                                                  (QREFELT $
                                                                           49))
                                                                 (QREFELT $
                                                                          50))
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (QREFELT $ 15) |l|
                                                          (QREFELT $ 36))
                                                         |j| |i|
                                                         (QREFELT $ 42))
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (QREFELT $ 15) |s|
                                                          (QREFELT $ 36))
                                                         |l| |k|
                                                         (QREFELT $ 42))
                                                        (QREFELT $ 49))
                                                       (QREFELT $ 51)))))
                                              (LETT |l| (|inc_SI| |l|))
                                              (GO G190) G191 (EXIT NIL))
                                         (SPADCALL |condi| |z| |i| |entry|
                                                   (QREFELT $ 22))
                                         (SPADCALL |condi| |u| |i| |enter|
                                                   (QREFELT $ 22))
                                         (EXIT
                                          (SPADCALL |condi| |w| |i| |ent|
                                                    (QREFELT $ 22))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT NIL))))
                             (LETT |s| (|inc_SI| |s|)) (GO G190) G191
                             (EXIT NIL))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (SPADCALL (ELT $ 24) (SPADCALL |condi| (QREFELT $ 26))
                     (QREFELT $ 30)))))) 

(SDEFUN |ALGPKG;basisOfCenter;L;11| (($ (|List| A)))
        (SPROG
         ((D #1=(|Matrix| R)) (|enter| (R)) (|entry| (R)) (#2=#:G871 NIL)
          (|l| NIL) (#3=#:G870 NIL) (|i| NIL) (|u| (|Integer|))
          (|z| (|Integer|)) (#4=#:G869 NIL) (|s| NIL) (#5=#:G868 NIL) (|j| NIL)
          (#6=#:G867 NIL) (|k| NIL) (|condi| (|Matrix| R)) (B #1#)
          (|cond| (|Matrix| R)) (|gammak| (|Matrix| R)) (#7=#:G866 NIL)
          (|gamma1| (|Matrix| R)))
         (SEQ (LETT |gamma1| (SPADCALL (QREFELT $ 15) (QREFELT $ 56)))
              (LETT |gamma1|
                    (SPADCALL |gamma1| (SPADCALL |gamma1| (QREFELT $ 34))
                              (QREFELT $ 47)))
              (LETT |cond| |gamma1|)
              (SEQ (LETT |i| 2) (LETT #7# (QREFELT $ 10)) G190
                   (COND ((|greater_SI| |i| #7#) (GO G191)))
                   (SEQ
                    (LETT |gammak|
                          (SPADCALL (QREFELT $ 15) |i| (QREFELT $ 36)))
                    (LETT |gammak|
                          (SPADCALL |gammak| (SPADCALL |gammak| (QREFELT $ 34))
                                    (QREFELT $ 47)))
                    (EXIT
                     (LETT |cond| (SPADCALL |cond| |gammak| (QREFELT $ 35)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT B |cond|)
              (LETT |condi|
                    (MAKE_MATRIX1 (* 2 (QREFELT $ 12)) (QREFELT $ 10)
                                  (|spadConstant| $ 16)))
              (LETT |z| 0) (LETT |u| (QREFELT $ 12))
              (SEQ (LETT |k| 1) (LETT #6# (QREFELT $ 10)) G190
                   (COND ((|greater_SI| |k| #6#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #5# (QREFELT $ 10)) G190
                          (COND ((|greater_SI| |j| #5#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |s| 1) (LETT #4# (QREFELT $ 10)) G190
                                 (COND ((|greater_SI| |s| #4#) (GO G191)))
                                 (SEQ (LETT |z| (+ |z| 1)) (LETT |u| (+ |u| 1))
                                      (EXIT
                                       (SEQ (LETT |i| 1)
                                            (LETT #3# (QREFELT $ 10)) G190
                                            (COND
                                             ((|greater_SI| |i| #3#)
                                              (GO G191)))
                                            (SEQ
                                             (LETT |entry|
                                                   (|spadConstant| $ 16))
                                             (LETT |enter|
                                                   (|spadConstant| $ 16))
                                             (SEQ (LETT |l| 1)
                                                  (LETT #2# (QREFELT $ 10))
                                                  G190
                                                  (COND
                                                   ((|greater_SI| |l| #2#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (LETT |entry|
                                                         (SPADCALL
                                                          (SPADCALL |entry|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (QREFELT
                                                                        $ 15)
                                                                       |l|
                                                                       (QREFELT
                                                                        $ 36))
                                                                      |j| |k|
                                                                      (QREFELT
                                                                       $ 42))
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (QREFELT
                                                                        $ 15)
                                                                       |s|
                                                                       (QREFELT
                                                                        $ 36))
                                                                      |i| |l|
                                                                      (QREFELT
                                                                       $ 42))
                                                                     (QREFELT $
                                                                              49))
                                                                    (QREFELT $
                                                                             50))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (QREFELT $ 15) |l|
                                                             (QREFELT $ 36))
                                                            |i| |j|
                                                            (QREFELT $ 42))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (QREFELT $ 15) |s|
                                                             (QREFELT $ 36))
                                                            |l| |k|
                                                            (QREFELT $ 42))
                                                           (QREFELT $ 49))
                                                          (QREFELT $ 51)))
                                                   (EXIT
                                                    (LETT |enter|
                                                          (SPADCALL
                                                           (SPADCALL |enter|
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 15)
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 36))
                                                                       |k| |i|
                                                                       (QREFELT
                                                                        $ 42))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 15)
                                                                        |s|
                                                                        (QREFELT
                                                                         $ 36))
                                                                       |j| |l|
                                                                       (QREFELT
                                                                        $ 42))
                                                                      (QREFELT
                                                                       $ 49))
                                                                     (QREFELT $
                                                                              50))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 15)
                                                              |l|
                                                              (QREFELT $ 36))
                                                             |j| |k|
                                                             (QREFELT $ 42))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 15)
                                                              |s|
                                                              (QREFELT $ 36))
                                                             |l| |i|
                                                             (QREFELT $ 42))
                                                            (QREFELT $ 49))
                                                           (QREFELT $ 51)))))
                                                  (LETT |l| (|inc_SI| |l|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (SPADCALL |condi| |z| |i| |entry|
                                                       (QREFELT $ 22))
                                             (EXIT
                                              (SPADCALL |condi| |u| |i| |enter|
                                                        (QREFELT $ 22))))
                                            (LETT |i| (|inc_SI| |i|)) (GO G190)
                                            G191 (EXIT NIL))))
                                 (LETT |s| (|inc_SI| |s|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (LETT D (SPADCALL |condi| B (QREFELT $ 35)))
              (EXIT
               (SPADCALL (ELT $ 24) (SPADCALL D (QREFELT $ 26))
                         (QREFELT $ 30)))))) 

(SDEFUN |ALGPKG;basisOfRightNucloid;L;12| (($ (|List| (|Matrix| R))))
        (SPROG
         ((#1=#:G892 NIL) (|sol| NIL) (#2=#:G891 NIL) (|r2| (|Integer|))
          (|r1| (|Integer|)) (#3=#:G890 NIL) (|r| NIL) (|z| (|Integer|))
          (#4=#:G889 NIL) (|k| NIL) (#5=#:G888 NIL) (|j| NIL) (#6=#:G887 NIL)
          (|i| NIL) (|condo| #7=(|Matrix| R)) (|cond| #7#))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (QREFELT $ 12) (QREFELT $ 11)
                              (|spadConstant| $ 16)))
          (LETT |condo|
                (MAKE_MATRIX1 (QREFELT $ 12) (QREFELT $ 11)
                              (|spadConstant| $ 16)))
          (LETT |z| 0)
          (SEQ (LETT |i| 1) (LETT #6# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |i| #6#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #5# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #5#) (GO G191)))
                      (SEQ (LETT |r1| 0)
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #4# (QREFELT $ 10)) G190
                                 (COND ((|greater_SI| |k| #4#) (GO G191)))
                                 (SEQ (LETT |z| (+ |z| 1)) (LETT |r2| |i|)
                                      (EXIT
                                       (SEQ (LETT |r| 1)
                                            (LETT #3# (QREFELT $ 10)) G190
                                            (COND
                                             ((|greater_SI| |r| #3#)
                                              (GO G191)))
                                            (SEQ (LETT |r1| (+ |r1| 1))
                                                 (SPADCALL |cond| |z| |r1|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (QREFELT $ 15) |r|
                                                             (QREFELT $ 36))
                                                            |j| |i|
                                                            (QREFELT $ 42))
                                                           (QREFELT $ 22))
                                                 (SPADCALL |condo| |z| |r2|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 15)
                                                              |k|
                                                              (QREFELT $ 36))
                                                             |j| |r|
                                                             (QREFELT $ 42))
                                                            (QREFELT $ 43))
                                                           (QREFELT $ 22))
                                                 (EXIT
                                                  (LETT |r2|
                                                        (+ |r2|
                                                           (QREFELT $ 10)))))
                                            (LETT |r| (|inc_SI| |r|)) (GO G190)
                                            G191 (EXIT NIL))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |sol| NIL)
                 (LETT #1#
                       (SPADCALL (SPADCALL |cond| |condo| (QREFELT $ 44))
                                 (QREFELT $ 26)))
                 G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |sol| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ (EXIT (LETT #2# (CONS (|ALGPKG;convVM| |sol| $) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |ALGPKG;basisOfCentroid;L;13| (($ (|List| (|Matrix| R))))
        (SPROG
         ((#1=#:G913 NIL) (|sol| NIL) (#2=#:G912 NIL) (|r2| (|Integer|))
          (|r1| (|Integer|)) (#3=#:G911 NIL) (|r| NIL) (|u| (|Integer|))
          (|z| (|Integer|)) (#4=#:G910 NIL) (|k| NIL) (#5=#:G909 NIL) (|j| NIL)
          (#6=#:G908 NIL) (|i| NIL) (|condo| #7=(|Matrix| R)) (|cond| #7#))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (* 2 (QREFELT $ 12)) (QREFELT $ 11)
                              (|spadConstant| $ 16)))
          (LETT |condo|
                (MAKE_MATRIX1 (* 2 (QREFELT $ 12)) (QREFELT $ 11)
                              (|spadConstant| $ 16)))
          (LETT |z| 0) (LETT |u| (QREFELT $ 12))
          (SEQ (LETT |i| 1) (LETT #6# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |i| #6#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #5# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #5#) (GO G191)))
                      (SEQ (LETT |r1| 0)
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #4# (QREFELT $ 10)) G190
                                 (COND ((|greater_SI| |k| #4#) (GO G191)))
                                 (SEQ (LETT |z| (+ |z| 1)) (LETT |u| (+ |u| 1))
                                      (LETT |r2| |i|)
                                      (EXIT
                                       (SEQ (LETT |r| 1)
                                            (LETT #3# (QREFELT $ 10)) G190
                                            (COND
                                             ((|greater_SI| |r| #3#)
                                              (GO G191)))
                                            (SEQ (LETT |r1| (+ |r1| 1))
                                                 (SPADCALL |cond| |z| |r1|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (QREFELT $ 15) |r|
                                                             (QREFELT $ 36))
                                                            |i| |j|
                                                            (QREFELT $ 42))
                                                           (QREFELT $ 22))
                                                 (SPADCALL |cond| |u| |r1|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (QREFELT $ 15) |r|
                                                             (QREFELT $ 36))
                                                            |j| |i|
                                                            (QREFELT $ 42))
                                                           (QREFELT $ 22))
                                                 (SPADCALL |condo| |z| |r2|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 15)
                                                              |k|
                                                              (QREFELT $ 36))
                                                             |r| |j|
                                                             (QREFELT $ 42))
                                                            (QREFELT $ 43))
                                                           (QREFELT $ 22))
                                                 (SPADCALL |condo| |u| |r2|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 15)
                                                              |k|
                                                              (QREFELT $ 36))
                                                             |j| |r|
                                                             (QREFELT $ 42))
                                                            (QREFELT $ 43))
                                                           (QREFELT $ 22))
                                                 (EXIT
                                                  (LETT |r2|
                                                        (+ |r2|
                                                           (QREFELT $ 10)))))
                                            (LETT |r| (|inc_SI| |r|)) (GO G190)
                                            G191 (EXIT NIL))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |sol| NIL)
                 (LETT #1#
                       (SPADCALL (SPADCALL |cond| |condo| (QREFELT $ 44))
                                 (QREFELT $ 26)))
                 G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |sol| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ (EXIT (LETT #2# (CONS (|ALGPKG;convVM| |sol| $) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |ALGPKG;doubleRank;ANni;14| ((|x| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|enter| (R)) (|entry| (R)) (#1=#:G927 NIL) (|i| NIL)
          (|u| (|Integer|)) (|z| (|Integer|)) (#2=#:G926 NIL) (|j| NIL)
          (#3=#:G925 NIL) (|k| NIL) (|cond| (|Matrix| R)))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (* 2 (QREFELT $ 10)) (QREFELT $ 10)
                              (|spadConstant| $ 16)))
          (SEQ (LETT |k| 1) (LETT #3# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |k| #3#) (GO G191)))
               (SEQ (LETT |z| 0) (LETT |u| (QREFELT $ 10))
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #2# (QREFELT $ 10)) G190
                          (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ (LETT |z| (+ |z| 1)) (LETT |u| (+ |u| 1))
                               (LETT |entry| (|spadConstant| $ 16))
                               (LETT |enter| (|spadConstant| $ 16))
                               (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 10)) G190
                                    (COND ((|greater_SI| |i| #1#) (GO G191)))
                                    (SEQ
                                     (LETT |entry|
                                           (SPADCALL |entry|
                                                     (SPADCALL
                                                      (SPADCALL |x| |i|
                                                                (QREFELT $ 60))
                                                      (SPADCALL
                                                       (SPADCALL (QREFELT $ 15)
                                                                 |k|
                                                                 (QREFELT $
                                                                          36))
                                                       |j| |i| (QREFELT $ 42))
                                                      (QREFELT $ 49))
                                                     (QREFELT $ 50)))
                                     (EXIT
                                      (LETT |enter|
                                            (SPADCALL |enter|
                                                      (SPADCALL
                                                       (SPADCALL |x| |i|
                                                                 (QREFELT $
                                                                          60))
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (QREFELT $ 15) |k|
                                                         (QREFELT $ 36))
                                                        |i| |j| (QREFELT $ 42))
                                                       (QREFELT $ 49))
                                                      (QREFELT $ 50)))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT NIL))
                               (SPADCALL |cond| |z| |k| |entry| (QREFELT $ 22))
                               (EXIT
                                (SPADCALL |cond| |u| |k| |enter|
                                          (QREFELT $ 22))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |cond| (QREFELT $ 62)))))) 

(SDEFUN |ALGPKG;weakBiRank;ANni;15| ((|x| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|entry| (R)) (#1=#:G946 NIL) (|s| NIL) (#2=#:G945 NIL) (|l| NIL)
          (#3=#:G944 NIL) (|k| NIL) (|z| (|Integer|)) (#4=#:G943 NIL) (|j| NIL)
          (#5=#:G942 NIL) (|i| NIL) (|cond| (|Matrix| R)))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (QREFELT $ 11) (QREFELT $ 10)
                              (|spadConstant| $ 16)))
          (LETT |z| 0)
          (SEQ (LETT |i| 1) (LETT #5# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |i| #5#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #4# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #4#) (GO G191)))
                      (SEQ (LETT |z| (+ |z| 1))
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #3# (QREFELT $ 10)) G190
                                 (COND ((|greater_SI| |k| #3#) (GO G191)))
                                 (SEQ (LETT |entry| (|spadConstant| $ 16))
                                      (SEQ (LETT |l| 1)
                                           (LETT #2# (QREFELT $ 10)) G190
                                           (COND
                                            ((|greater_SI| |l| #2#) (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (SEQ (LETT |s| 1)
                                                  (LETT #1# (QREFELT $ 10))
                                                  G190
                                                  (COND
                                                   ((|greater_SI| |s| #1#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |entry|
                                                          (SPADCALL |entry|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       |x| |l|
                                                                       (QREFELT
                                                                        $ 60))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 15)
                                                                        |s|
                                                                        (QREFELT
                                                                         $ 36))
                                                                       |i| |l|
                                                                       (QREFELT
                                                                        $ 42))
                                                                      (QREFELT
                                                                       $ 49))
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (QREFELT
                                                                        $ 15)
                                                                       |k|
                                                                       (QREFELT
                                                                        $ 36))
                                                                      |s| |j|
                                                                      (QREFELT
                                                                       $ 42))
                                                                     (QREFELT $
                                                                              49))
                                                                    (QREFELT $
                                                                             50)))))
                                                  (LETT |s| (|inc_SI| |s|))
                                                  (GO G190) G191 (EXIT NIL))))
                                           (LETT |l| (|inc_SI| |l|)) (GO G190)
                                           G191 (EXIT NIL))
                                      (EXIT
                                       (SPADCALL |cond| |z| |k| |entry|
                                                 (QREFELT $ 22))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |cond| (QREFELT $ 62)))))) 

(SDEFUN |ALGPKG;biRank;ANni;16| ((|x| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|enter| (R)) (|entry| (R)) (#1=#:G977 NIL) (|i| NIL) (#2=#:G976 NIL)
          (|k| NIL) (|w| (|Integer|)) (|u| (|Integer|)) (#3=#:G975 NIL)
          (|j| NIL) (|c| (|PositiveInteger|)) (#4=#:G974 NIL) (|s| NIL)
          (#5=#:G973 NIL) (|l| NIL) (#6=#:G972 NIL) (|z| (|Integer|))
          (#7=#:G971 NIL) (#8=#:G970 NIL) (|cond| (|Matrix| R)))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (+ (+ (QREFELT $ 11) (* 2 (QREFELT $ 10))) 1)
                              (QREFELT $ 10) (|spadConstant| $ 16)))
          (LETT |z| 0)
          (SEQ (LETT |j| 1) (LETT #8# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |j| #8#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |i| 1) (LETT #7# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |i| #7#) (GO G191)))
                      (SEQ (LETT |z| (+ |z| 1))
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #6# (QREFELT $ 10)) G190
                                 (COND ((|greater_SI| |k| #6#) (GO G191)))
                                 (SEQ (LETT |entry| (|spadConstant| $ 16))
                                      (SEQ (LETT |l| 1)
                                           (LETT #5# (QREFELT $ 10)) G190
                                           (COND
                                            ((|greater_SI| |l| #5#) (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (SEQ (LETT |s| 1)
                                                  (LETT #4# (QREFELT $ 10))
                                                  G190
                                                  (COND
                                                   ((|greater_SI| |s| #4#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |entry|
                                                          (SPADCALL |entry|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       |x| |l|
                                                                       (QREFELT
                                                                        $ 60))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 15)
                                                                        |s|
                                                                        (QREFELT
                                                                         $ 36))
                                                                       |i| |l|
                                                                       (QREFELT
                                                                        $ 42))
                                                                      (QREFELT
                                                                       $ 49))
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (QREFELT
                                                                        $ 15)
                                                                       |k|
                                                                       (QREFELT
                                                                        $ 36))
                                                                      |s| |j|
                                                                      (QREFELT
                                                                       $ 42))
                                                                     (QREFELT $
                                                                              49))
                                                                    (QREFELT $
                                                                             50)))))
                                                  (LETT |s| (|inc_SI| |s|))
                                                  (GO G190) G191 (EXIT NIL))))
                                           (LETT |l| (|inc_SI| |l|)) (GO G190)
                                           G191 (EXIT NIL))
                                      (EXIT
                                       (SPADCALL |cond| |z| |k| |entry|
                                                 (QREFELT $ 22))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))))
               (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
          (LETT |u| (* (QREFELT $ 10) (QREFELT $ 10)))
          (LETT |w| (* (QREFELT $ 10) (+ (QREFELT $ 10) 1)))
          (LETT |c| (+ (+ (QREFELT $ 11) (* 2 (QREFELT $ 10))) 1))
          (SEQ (LETT |j| 1) (LETT #3# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |j| #3#) (GO G191)))
               (SEQ (LETT |u| (+ |u| 1)) (LETT |w| (+ |w| 1))
                    (SEQ (LETT |k| 1) (LETT #2# (QREFELT $ 10)) G190
                         (COND ((|greater_SI| |k| #2#) (GO G191)))
                         (SEQ (LETT |entry| (|spadConstant| $ 16))
                              (LETT |enter| (|spadConstant| $ 16))
                              (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 10)) G190
                                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                                   (SEQ
                                    (LETT |entry|
                                          (SPADCALL |entry|
                                                    (SPADCALL
                                                     (SPADCALL |x| |i|
                                                               (QREFELT $ 60))
                                                     (SPADCALL
                                                      (SPADCALL (QREFELT $ 15)
                                                                |k|
                                                                (QREFELT $ 36))
                                                      |j| |i| (QREFELT $ 42))
                                                     (QREFELT $ 49))
                                                    (QREFELT $ 50)))
                                    (EXIT
                                     (LETT |enter|
                                           (SPADCALL |enter|
                                                     (SPADCALL
                                                      (SPADCALL |x| |i|
                                                                (QREFELT $ 60))
                                                      (SPADCALL
                                                       (SPADCALL (QREFELT $ 15)
                                                                 |k|
                                                                 (QREFELT $
                                                                          36))
                                                       |i| |j| (QREFELT $ 42))
                                                      (QREFELT $ 49))
                                                     (QREFELT $ 50)))))
                                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                   (EXIT NIL))
                              (SPADCALL |cond| |u| |k| |entry| (QREFELT $ 22))
                              (EXIT
                               (SPADCALL |cond| |w| |k| |enter|
                                         (QREFELT $ 22))))
                         (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL |cond| |c| |j| (SPADCALL |x| |j| (QREFELT $ 60))
                               (QREFELT $ 22))))
               (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |cond| (QREFELT $ 62)))))) 

(SDEFUN |ALGPKG;leftRank;ANni;17| ((|x| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|entry| (R)) (#1=#:G989 NIL) (|i| NIL) (#2=#:G988 NIL) (|j| NIL)
          (#3=#:G987 NIL) (|k| NIL) (|cond| (|Matrix| R)))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (QREFELT $ 10) (QREFELT $ 10)
                              (|spadConstant| $ 16)))
          (SEQ (LETT |k| 1) (LETT #3# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |k| #3#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #2# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #2#) (GO G191)))
                      (SEQ (LETT |entry| (|spadConstant| $ 16))
                           (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 10)) G190
                                (COND ((|greater_SI| |i| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |entry|
                                        (SPADCALL |entry|
                                                  (SPADCALL
                                                   (SPADCALL |x| |i|
                                                             (QREFELT $ 60))
                                                   (SPADCALL
                                                    (SPADCALL (QREFELT $ 15)
                                                              |k|
                                                              (QREFELT $ 36))
                                                    |i| |j| (QREFELT $ 42))
                                                   (QREFELT $ 49))
                                                  (QREFELT $ 50)))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT
                            (SPADCALL |cond| |j| |k| |entry| (QREFELT $ 22))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |cond| (QREFELT $ 62)))))) 

(SDEFUN |ALGPKG;rightRank;ANni;18| ((|x| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|entry| (R)) (#1=#:G1001 NIL) (|i| NIL) (#2=#:G1000 NIL) (|j| NIL)
          (#3=#:G999 NIL) (|k| NIL) (|cond| (|Matrix| R)))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (QREFELT $ 10) (QREFELT $ 10)
                              (|spadConstant| $ 16)))
          (SEQ (LETT |k| 1) (LETT #3# (QREFELT $ 10)) G190
               (COND ((|greater_SI| |k| #3#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #2# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #2#) (GO G191)))
                      (SEQ (LETT |entry| (|spadConstant| $ 16))
                           (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 10)) G190
                                (COND ((|greater_SI| |i| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |entry|
                                        (SPADCALL |entry|
                                                  (SPADCALL
                                                   (SPADCALL |x| |i|
                                                             (QREFELT $ 60))
                                                   (SPADCALL
                                                    (SPADCALL (QREFELT $ 15)
                                                              |k|
                                                              (QREFELT $ 36))
                                                    |j| |i| (QREFELT $ 42))
                                                   (QREFELT $ 49))
                                                  (QREFELT $ 50)))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT
                            (SPADCALL |cond| |j| |k| |entry| (QREFELT $ 22))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |cond| (QREFELT $ 62)))))) 

(SDEFUN |ALGPKG;basis;2V;19| ((|va| (|Vector| A)) ($ (|Vector| A)))
        (SPROG
         ((#1=#:G1018 NIL) (#2=#:G1020 NIL) (#3=#:G1019 NIL)
          (|finished?| (|Boolean|)) (|j| (|Integer|)) (|h| (|Integer|))
          (|lj| (|List| (|Integer|))) (|mCI| (|Integer|)) (|mRI| (|Integer|))
          (|m| (|Matrix| R)) (#4=#:G1017 NIL) (|i| NIL) (|v| (|Vector| A)))
         (SEQ (LETT |v| (SPADCALL (ELT $ 69) |va| (QREFELT $ 72)))
              (LETT |v| (SPADCALL |v| (QREFELT $ 73)))
              (EXIT
               (COND
                ((SPADCALL |v| (QREFELT $ 74)) (VECTOR (|spadConstant| $ 75)))
                ('T
                 (SEQ
                  (LETT |m|
                        (SPADCALL
                         (SPADCALL (SPADCALL |v| 1 (QREFELT $ 76))
                                   (QREFELT $ 32))
                         (QREFELT $ 33)))
                  (SEQ (LETT |i| 2) (LETT #4# (QVSIZE |v|)) G190
                       (COND ((|greater_SI| |i| #4#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |m|
                               (SPADCALL |m|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |v| |i| (QREFELT $ 76))
                                           (QREFELT $ 32))
                                          (QREFELT $ 33))
                                         (QREFELT $ 77)))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (LETT |m| (SPADCALL |m| (QREFELT $ 78))) (LETT |lj| NIL)
                  (LETT |h| 1) (LETT |mRI| (SPADCALL |m| (QREFELT $ 79)))
                  (LETT |mCI| (SPADCALL |m| (QREFELT $ 80)))
                  (LETT |finished?| NIL) (LETT |j| 1)
                  (SEQ G190 (COND ((NULL (NULL |finished?|)) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL
                            (SPADCALL (SPADCALL |m| |h| |j| (QREFELT $ 42))
                                      (QREFELT $ 81)))
                           (SEQ (LETT |lj| (CONS |j| |lj|)) (LETT |h| |mRI|)
                                (SEQ G190
                                     (COND
                                      ((NULL
                                        (SPADCALL
                                         (SPADCALL |m| |h| |j| (QREFELT $ 42))
                                         (QREFELT $ 81)))
                                       (GO G191)))
                                     (SEQ (EXIT (LETT |h| (- |h| 1)))) NIL
                                     (GO G190) G191 (EXIT NIL))
                                (LETT |finished?| (EQL |h| |mRI|))
                                (EXIT
                                 (COND
                                  ((NULL |finished?|) (LETT |h| (+ |h| 1)))))))
                          ((< |j| |mCI|) (LETT |j| (+ |j| 1)))
                          ('T (LETT |finished?| 'T)))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (PROGN
                    (LETT #3# (GETREFV (SIZE #5=(REVERSE |lj|))))
                    (SEQ (LETT #2# #5#) (LETT #1# 0) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |j| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (SETELT #3# #1# (SPADCALL |v| |j| (QREFELT $ 76)))))
                         (LETT #1# (PROG1 (|inc_SI| #1#) (LETT #2# (CDR #2#))))
                         (GO G190) G191 (EXIT NIL))
                    #3#))))))))) 

(DECLAIM (NOTINLINE |AlgebraPackage;|)) 

(DEFUN |AlgebraPackage| (&REST #1=#:G1021)
  (SPROG NIL
         (PROG (#2=#:G1022)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|AlgebraPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |AlgebraPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|AlgebraPackage|)))))))))) 

(DEFUN |AlgebraPackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|AlgebraPackage| DV$1 DV$2))
          (LETT $ (GETREFV 83))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|EuclideanDomain|))))))
          (|haddProp| |$ConstructorCache| '|AlgebraPackage| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
          (QSETREFV $ 11 (* (QREFELT $ 10) (QREFELT $ 10)))
          (QSETREFV $ 12 (* (QREFELT $ 10) (QREFELT $ 11)))
          (QSETREFV $ 15 (SPADCALL (QREFELT $ 14)))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 82
                      (CONS (|dispatchFunction| |ALGPKG;basis;2V;19|) $))))
          $))) 

(MAKEPROP '|AlgebraPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|PositiveInteger|) (0 . |rank|) '|n| '|n2| '|n3| (|Vector| 21)
              (4 . |structuralConstants|) '|gamma| (8 . |Zero|) (12 . |One|)
              (|Integer|) (|Vector| 6) (16 . |elt|) (|Matrix| 6)
              (22 . |setelt!|) (30 . |leftTraceMatrix|) (34 . |represents|)
              (|List| 19) (39 . |nullSpace|) (|List| 7) (|Mapping| 7 19)
              (|ListFunctions2| 19 7) (44 . |map|)
              |ALGPKG;radicalOfLeftTraceForm;L;2| (50 . |coordinates|)
              (55 . |coerce|) (60 . |transpose|) (65 . |vertConcat|)
              (71 . |elt|) (77 . *) (|Mapping| 21 21 21) (83 . |reduce|)
              |ALGPKG;basisOfLeftAnnihilator;AL;3|
              |ALGPKG;basisOfRightAnnihilator;AL;4| (89 . |elt|) (96 . -)
              (101 . +) (|List| 21) |ALGPKG;basisOfLeftNucloid;L;5| (107 . -)
              |ALGPKG;basisOfCommutingElements;L;6| (113 . *) (119 . +)
              (125 . -) |ALGPKG;basisOfLeftNucleus;L;7|
              |ALGPKG;basisOfRightNucleus;L;8|
              |ALGPKG;basisOfMiddleNucleus;L;9| |ALGPKG;basisOfNucleus;L;10|
              (131 . |first|) |ALGPKG;basisOfCenter;L;11|
              |ALGPKG;basisOfRightNucloid;L;12| |ALGPKG;basisOfCentroid;L;13|
              (136 . |elt|) (|NonNegativeInteger|) (142 . |rank|)
              |ALGPKG;doubleRank;ANni;14| |ALGPKG;weakBiRank;ANni;15|
              |ALGPKG;biRank;ANni;16| |ALGPKG;leftRank;ANni;17|
              |ALGPKG;rightRank;ANni;18| (|Boolean|) (147 . |zero?|)
              (|Mapping| 68 7) (|Vector| 7) (152 . |remove|)
              (158 . |removeDuplicates|) (163 . |empty?|) (168 . |Zero|)
              (172 . |elt|) (178 . |horizConcat|) (184 . |rowEchelon|)
              (189 . |maxRowIndex|) (194 . |maxColIndex|) (199 . |zero?|)
              (204 . |basis|))
           '#(|weakBiRank| 209 |rightRank| 214 |radicalOfLeftTraceForm| 219
              |leftRank| 223 |doubleRank| 228 |biRank| 233
              |basisOfRightNucloid| 238 |basisOfRightNucleus| 242
              |basisOfRightAnnihilator| 246 |basisOfNucleus| 251
              |basisOfMiddleNucleus| 255 |basisOfLeftNucloid| 259
              |basisOfLeftNucleus| 263 |basisOfLeftAnnihilator| 267
              |basisOfCommutingElements| 272 |basisOfCentroid| 276
              |basisOfCenter| 280 |basis| 284)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|leftRank| ((|NonNegativeInteger|) |#2|)) T)
                              '((|rightRank| ((|NonNegativeInteger|) |#2|)) T)
                              '((|doubleRank| ((|NonNegativeInteger|) |#2|)) T)
                              '((|weakBiRank| ((|NonNegativeInteger|) |#2|)) T)
                              '((|biRank| ((|NonNegativeInteger|) |#2|)) T)
                              '((|basisOfCommutingElements| ((|List| |#2|))) T)
                              '((|basisOfLeftAnnihilator| ((|List| |#2|) |#2|))
                                T)
                              '((|basisOfRightAnnihilator|
                                 ((|List| |#2|) |#2|))
                                T)
                              '((|basisOfLeftNucleus| ((|List| |#2|))) T)
                              '((|basisOfRightNucleus| ((|List| |#2|))) T)
                              '((|basisOfMiddleNucleus| ((|List| |#2|))) T)
                              '((|basisOfNucleus| ((|List| |#2|))) T)
                              '((|basisOfCenter| ((|List| |#2|))) T)
                              '((|basisOfLeftNucloid|
                                 ((|List| (|Matrix| |#1|))))
                                T)
                              '((|basisOfRightNucloid|
                                 ((|List| (|Matrix| |#1|))))
                                T)
                              '((|basisOfCentroid| ((|List| (|Matrix| |#1|))))
                                T)
                              '((|radicalOfLeftTraceForm| ((|List| |#2|))) T)
                              '((|basis| ((|Vector| |#2|) (|Vector| |#2|)))
                                (|has| 6 (|EuclideanDomain|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 82
                                            '(0 7 8 9 0 7 13 14 0 6 0 16 0 6 0
                                              17 2 19 6 0 18 20 4 21 6 0 18 18
                                              6 22 0 7 21 23 1 7 0 19 24 1 21
                                              25 0 26 2 29 27 28 25 30 1 7 19 0
                                              32 1 21 0 19 33 1 21 0 0 34 2 21
                                              0 0 0 35 2 13 21 0 18 36 2 21 0 0
                                              0 37 2 13 21 38 0 39 3 21 6 0 18
                                              18 42 1 6 0 0 43 2 21 0 0 0 44 2
                                              21 0 0 0 47 2 6 0 0 0 49 2 6 0 0
                                              0 50 2 6 0 0 0 51 1 13 21 0 56 2
                                              7 6 0 18 60 1 21 61 0 62 1 7 68 0
                                              69 2 71 0 70 0 72 1 71 0 0 73 1
                                              71 68 0 74 0 7 0 75 2 71 7 0 18
                                              76 2 21 0 0 0 77 1 21 0 0 78 1 21
                                              18 0 79 1 21 18 0 80 1 6 68 0 81
                                              1 0 71 71 82 1 0 61 7 64 1 0 61 7
                                              67 0 0 27 31 1 0 61 7 66 1 0 61 7
                                              63 1 0 61 7 65 0 0 45 58 0 0 27
                                              53 1 0 27 7 41 0 0 27 55 0 0 27
                                              54 0 0 45 46 0 0 27 52 1 0 27 7
                                              40 0 0 27 48 0 0 45 59 0 0 27 57
                                              1 1 71 71 82)))))
           '|lookupComplete|)) 

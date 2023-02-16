
(SDEFUN |INTHEORY;harmonic;IF;1|
        ((|n| (|Integer|)) ($ (|Fraction| (|Integer|))))
        (SPROG
         ((|h| #1=(|Fraction| (|Integer|))) (#2=#:G729 NIL) (|k| NIL)
          (|s| #3=(|Integer|))
          (|#G3| (|Record| (|:| |Hn| #3#) (|:| |Hv| #1#))))
         (SEQ
          (COND
           ((< |n| 0) (|error| "harmonic not defined for negative integers"))
           (#4='T
            (SEQ
             (COND
              ((>= |n| (QCAR (QREFELT $ 16)))
               (PROGN
                (LETT |#G3| (QREFELT $ 16))
                (LETT |s| (QCAR |#G3|))
                (LETT |h| (QCDR |#G3|))
                |#G3|))
              (#4# (SEQ (LETT |s| 0) (EXIT (LETT |h| (|spadConstant| $ 17))))))
             (SEQ (LETT |k| (+ |s| 1)) (LETT #2# |n|) G190
                  (COND ((> |k| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT |h|
                          (SPADCALL |h| (SPADCALL 1 |k| (QREFELT $ 18))
                                    (QREFELT $ 19)))))
                  (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
             (PROGN (RPLACA (QREFELT $ 16) |n|) (QCAR (QREFELT $ 16)))
             (PROGN (RPLACD (QREFELT $ 16) |h|) (QCDR (QREFELT $ 16)))
             (EXIT |h|))))))) 

(SDEFUN |INTHEORY;fibonacci;2I;2| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|f2| #1=(|Integer|)) (|f1| #1#) (|#G14| #2=(|Integer|)) (|#G13| #2#)
          (|#G12| #2#) (|#G11| #2#) (|t| (|Integer|)) (|k| NIL)
          (|#G9| (|PositiveInteger|)) (|#G8| (|NonNegativeInteger|)))
         (SEQ
          (COND ((EQL |n| 0) 0)
                ((< |n| 0)
                 (* (COND ((ODDP |n|) 1) (#3='T -1))
                    (SPADCALL (- |n|) (QREFELT $ 21))))
                (#3#
                 (SEQ
                  (PROGN
                   (LETT |#G8| 0)
                   (LETT |#G9| 1)
                   (LETT |f1| |#G8|)
                   (LETT |f2| |#G9|))
                  (SEQ (LETT |k| (- (INTEGER-LENGTH |n|) 2)) G190
                       (COND ((< |k| 0) (GO G191)))
                       (SEQ (LETT |t| (EXPT |f2| 2))
                            (PROGN
                             (LETT |#G11| (+ |t| (EXPT |f1| 2)))
                             (LETT |#G12| (+ |t| (* (* 2 |f1|) |f2|)))
                             (LETT |f1| |#G11|)
                             (LETT |f2| |#G12|))
                            (EXIT
                             (COND
                              ((SPADCALL |n| |k| (QREFELT $ 23))
                               (PROGN
                                (LETT |#G13| |f2|)
                                (LETT |#G14| (+ |f1| |f2|))
                                (LETT |f1| |#G13|)
                                (LETT |f2| |#G14|))))))
                       (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                  (EXIT |f2|))))))) 

(SDEFUN |INTHEORY;carmichaelLambda;2I;3| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPROG ((#1=#:G758 NIL) (|pk| NIL) (#2=#:G757 NIL))
               (SEQ
                (COND
                 ((<= |n| 0)
                  (|error|
                   "carmichaelLambda defined only for positive integers"))
                 ('T
                  (SPADCALL
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |pk| NIL)
                         (LETT #1#
                               (SPADCALL (SPADCALL |n| (QREFELT $ 25))
                                         (QREFELT $ 30)))
                         G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |pk| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #2#
                                 (CONS
                                  (COND
                                   ((OR (>= (QVELT |pk| 1) 3)
                                        (<= (QVELT |pk| 2) 2))
                                    (*
                                     (EXPT (QVELT |pk| 1) (- (QVELT |pk| 2) 1))
                                     (- (QVELT |pk| 1) 1)))
                                   ('T (EXPT 2 (- (QVELT |pk| 2) 2))))
                                  #2#))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))
                   (QREFELT $ 32))))))) 

(SDEFUN |INTHEORY;euler;2I;4| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|e| #1=(|Integer|)) (|t| #1#) (#2=#:G775 NIL) (|j| NIL)
          (#3=#:G774 NIL) (|i| NIL) (#4=#:G773 NIL) (#5=#:G760 NIL)
          (|l| (|Integer|)))
         (SEQ
          (COND ((< |n| 0) (|error| "euler not defined for negative integers"))
                ((ODDP |n|) 0)
                (#6='T
                 (SEQ (LETT |l| (SPADCALL (QREFELT $ 10) (QREFELT $ 34)))
                      (EXIT
                       (COND
                        ((< |n| |l|)
                         (SPADCALL (QREFELT $ 10) |n| (QREFELT $ 35)))
                        (#6#
                         (SEQ
                          (SPADCALL (QREFELT $ 10)
                                    (SPADCALL
                                     (PROG1 (LETT #5# (- (+ |n| 1) |l|))
                                       (|check_subtype2| (>= #5# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #5#))
                                     0 (QREFELT $ 9))
                                    (QREFELT $ 36))
                          (SEQ (LETT |i| 1) (LETT #4# |l|) G190
                               (COND ((> |i| #4#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (SPADCALL (QREFELT $ 10) |i| 0
                                           (QREFELT $ 37))))
                               (LETT |i| (+ |i| 2)) (GO G190) G191 (EXIT NIL))
                          (SEQ (LETT |i| (+ |l| 1)) (LETT #3# |n|) G190
                               (COND ((> |i| #3#) (GO G191)))
                               (SEQ (LETT |t| (LETT |e| 1))
                                    (SEQ (LETT |j| 2) (LETT #2# (- |i| 2)) G190
                                         (COND ((> |j| #2#) (GO G191)))
                                         (SEQ
                                          (LETT |t|
                                                (QUOTIENT2
                                                 (* (* |t| (+ (- |i| |j|) 1))
                                                    (+ (- |i| |j|) 2))
                                                 (* |j| (- |j| 1))))
                                          (EXIT
                                           (LETT |e|
                                                 (+ |e|
                                                    (* |t|
                                                       (SPADCALL (QREFELT $ 10)
                                                                 |j|
                                                                 (QREFELT $
                                                                          35)))))))
                                         (LETT |j| (+ |j| 2)) (GO G190) G191
                                         (EXIT NIL))
                                    (EXIT
                                     (SPADCALL (QREFELT $ 10) |i| (- |e|)
                                               (QREFELT $ 37))))
                               (LETT |i| (+ |i| 2)) (GO G190) G191 (EXIT NIL))
                          (EXIT
                           (SPADCALL (QREFELT $ 10) |n|
                                     (QREFELT $ 35))))))))))))) 

(SDEFUN |INTHEORY;bernoulli;IF;5|
        ((|n| (|Integer|)) ($ (|Fraction| (|Integer|))))
        (SPROG
         ((|b| (|Fraction| (|Integer|))) (|t| (|Integer|)) (#1=#:G792 NIL)
          (|j| NIL) (#2=#:G791 NIL) (|i| NIL) (#3=#:G790 NIL) (#4=#:G777 NIL)
          (|l| (|Integer|)))
         (SEQ
          (COND
           ((< |n| 0) (|error| "bernoulli not defined for negative integers"))
           ((ODDP |n|)
            (COND
             ((EQL |n| 1)
              (SPADCALL (SPADCALL 1 2 (QREFELT $ 18)) (QREFELT $ 39)))
             (#5='T (|spadConstant| $ 17))))
           (#5#
            (SEQ (LETT |l| (SPADCALL (QREFELT $ 15) (QREFELT $ 40)))
                 (EXIT
                  (COND
                   ((< |n| |l|) (SPADCALL (QREFELT $ 15) |n| (QREFELT $ 41)))
                   (#5#
                    (SEQ
                     (SPADCALL (QREFELT $ 15)
                               (SPADCALL
                                (PROG1 (LETT #4# (- (+ |n| 1) |l|))
                                  (|check_subtype2| (>= #4# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #4#))
                                (|spadConstant| $ 17) (QREFELT $ 14))
                               (QREFELT $ 42))
                     (SEQ (LETT |i| 1) (LETT #3# |l|) G190
                          (COND ((> |i| #3#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL (QREFELT $ 15) |i| (|spadConstant| $ 17)
                                      (QREFELT $ 43))))
                          (LETT |i| (+ |i| 2)) (GO G190) G191 (EXIT NIL))
                     (SEQ (LETT |i| (+ |l| 1)) (LETT #2# |n|) G190
                          (COND ((> |i| #2#) (GO G191)))
                          (SEQ (LETT |t| 1)
                               (LETT |b| (SPADCALL (- 1 |i|) 2 (QREFELT $ 18)))
                               (SEQ (LETT |j| 2) (LETT #1# (- |i| 2)) G190
                                    (COND ((> |j| #1#) (GO G191)))
                                    (SEQ
                                     (LETT |t|
                                           (QUOTIENT2
                                            (* (* |t| (+ (- |i| |j|) 2))
                                               (+ (- |i| |j|) 3))
                                            (* |j| (- |j| 1))))
                                     (EXIT
                                      (LETT |b|
                                            (SPADCALL |b|
                                                      (SPADCALL
                                                       (SPADCALL |t|
                                                                 (QREFELT $
                                                                          44))
                                                       (SPADCALL (QREFELT $ 15)
                                                                 |j|
                                                                 (QREFELT $
                                                                          41))
                                                       (QREFELT $ 45))
                                                      (QREFELT $ 19)))))
                                    (LETT |j| (+ |j| 2)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (SPADCALL (QREFELT $ 15) |i|
                                          (SPADCALL
                                           (SPADCALL |b|
                                                     (SPADCALL (+ |i| 1)
                                                               (QREFELT $ 44))
                                                     (QREFELT $ 46))
                                           (QREFELT $ 39))
                                          (QREFELT $ 43))))
                          (LETT |i| (+ |i| 2)) (GO G190) G191 (EXIT NIL))
                     (EXIT
                      (SPADCALL (QREFELT $ 15) |n| (QREFELT $ 41))))))))))))) 

(SDEFUN |INTHEORY;inverse|
        ((|a| (|Integer|)) (|b| #1=(|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|d1| #2=(|Integer|)) (|c1| (|Integer|)) (|#G30| #3=(|Integer|))
          (|#G29| #2#) (|#G28| #3#) (|#G27| #1#) (|r| #3#) (|q| (|Integer|))
          (|borg| #1#))
         (SEQ (LETT |borg| |b|) (LETT |c1| 1) (LETT |d1| 0)
              (SEQ G190
                   (COND ((NULL (SPADCALL |b| 0 (QREFELT $ 48))) (GO G191)))
                   (SEQ (LETT |q| (QUOTIENT2 |a| |b|))
                        (LETT |r| (- |a| (* |q| |b|)))
                        (PROGN
                         (LETT |#G27| |b|)
                         (LETT |#G28| |r|)
                         (LETT |a| |#G27|)
                         (LETT |b| |#G28|))
                        (EXIT
                         (PROGN
                          (LETT |#G29| |d1|)
                          (LETT |#G30| (- |c1| (* |q| |d1|)))
                          (LETT |c1| |#G29|)
                          (LETT |d1| |#G30|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((SPADCALL |a| 1 (QREFELT $ 48))
                 (|error| "moduli are not relatively prime"))
                ('T (SPADCALL |c1| |borg| (QREFELT $ 49)))))))) 

(SDEFUN |INTHEORY;chineseRemainder;5I;7|
        ((|x1| (|Integer|)) (|m1| (|Integer|)) (|x2| (|Integer|))
         (|m2| (|Integer|)) ($ (|Integer|)))
        (SEQ
         (COND ((OR (< |m1| 0) (< |m2| 0)) (|error| "moduli must be positive"))
               ('T
                (SEQ (LETT |x1| (SPADCALL |x1| |m1| (QREFELT $ 49)))
                     (LETT |x2| (SPADCALL |x2| |m2| (QREFELT $ 49)))
                     (EXIT
                      (+ |x1|
                         (* |m1|
                            (SPADCALL
                             (* (- |x2| |x1|) (|INTHEORY;inverse| |m1| |m2| $))
                             |m2| (QREFELT $ 49)))))))))) 

(SDEFUN |INTHEORY;jacobi;3I;8|
        ((|a| (|Integer|)) (|b| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|j| (|Integer|)) (|k| NIL) (#1=#:G823 NIL) (|#G40| (|Integer|))
          (|#G39| (|Integer|)))
         (SEQ (COND ((< |b| 0) (LETT |b| (- |b|))))
              (EXIT
               (COND
                ((EQL |b| 0)
                 (|error| "second argument of jacobi may not be 0"))
                ((EQL |b| 1) 1)
                (#2='T
                 (SEQ
                  (COND
                   ((EVENP |b|)
                    (COND
                     ((> (SPADCALL |a| 4 (QREFELT $ 49)) 1)
                      (EXIT
                       (|error|
                        "J(a/b) not defined for b even and a = 2 or 3 (mod 4)"))))))
                  (COND ((EVENP |b|) (COND ((EVENP |a|) (EXIT 0)))))
                  (SEQ (LETT |k| 0) G190 (COND ((NULL (EVENP |b|)) (GO G191)))
                       (SEQ (EXIT (LETT |b| (QUOTIENT2 |b| 2))))
                       (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                  (LETT |j|
                        (SEQ
                         (COND
                          ((ODDP |k|)
                           (COND
                            ((EQL (SPADCALL |a| 8 (QREFELT $ 49)) 5)
                             (EXIT -1)))))
                         (EXIT 1)))
                  (EXIT
                   (COND ((EQL |b| 1) |j|)
                         (#2#
                          (SEQ (LETT |a| (SPADCALL |a| |b| (QREFELT $ 49)))
                               (SEQ G190 (COND ((NULL (> |a| 1)) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((ODDP |a|)
                                        (SEQ
                                         (COND
                                          ((EQL (REM |a| 4) 3)
                                           (COND
                                            ((EQL (REM |b| 4) 3)
                                             (LETT |j| (- |j|))))))
                                         (EXIT
                                          (PROGN
                                           (LETT |#G39| (REM |b| |a|))
                                           (LETT |#G40| |a|)
                                           (LETT |a| |#G39|)
                                           (LETT |b| |#G40|)))))
                                       ('T
                                        (SEQ
                                         (SEQ (LETT #1# NIL) (LETT |k| 0) G190
                                              (COND (#1# (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT |a| (QUOTIENT2 |a| 2))))
                                              (LETT |k|
                                                    (PROG1 (|inc_SI| |k|)
                                                      (LETT #1# (ODDP |a|))))
                                              (GO G190) G191 (EXIT NIL))
                                         (EXIT
                                          (COND
                                           ((ODDP |k|)
                                            (COND
                                             ((> (REM (+ |b| 2) 8) 4)
                                              (LETT |j| (- |j|))))))))))))
                                    NIL (GO G190) G191 (EXIT NIL))
                               (EXIT
                                (COND ((EQL |a| 0) 0) (#2# |j|)))))))))))))) 

(SDEFUN |INTHEORY;legendre;3I;9|
        ((|a| (|Integer|)) (|p| (|Integer|)) ($ (|Integer|)))
        (COND
         ((< |p| 0)
          (|error| "legendre not defined for negative characteristic"))
         ((SPADCALL |p| (QREFELT $ 53)) (SPADCALL |a| |p| (QREFELT $ 51)))
         ('T (|error| "characteristic of legendre must be prime")))) 

(SDEFUN |INTHEORY;eulerPhi;2I;10| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPROG ((|r| (|Fraction| (|Integer|))) (#1=#:G831 NIL) (|entry| NIL))
               (SEQ
                (COND ((EQL |n| 0) 0)
                      ('T
                       (SEQ (LETT |r| (|spadConstant| $ 12))
                            (SEQ (LETT |entry| NIL)
                                 (LETT #1#
                                       (SPADCALL (SPADCALL |n| (QREFELT $ 25))
                                                 (QREFELT $ 30)))
                                 G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |entry| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |r|
                                         (SPADCALL
                                          (SPADCALL (- (QVELT |entry| 1) 1)
                                                    (QVELT |entry| 1)
                                                    (QREFELT $ 18))
                                          |r| (QREFELT $ 45)))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT
                             (SPADCALL (SPADCALL |n| |r| (QREFELT $ 55))
                                       (QREFELT $ 56))))))))) 

(SDEFUN |INTHEORY;divisors;IL;11| ((|n| (|Integer|)) ($ (|List| (|Integer|))))
        (SPROG
         ((|oldList| #1=(|List| (|Integer|))) (|newList| #1#) (#2=#:G845 NIL)
          (|m| NIL) (|pow| (|Integer|)) (#3=#:G844 NIL) (|k| NIL)
          (#4=#:G843 NIL) (|f| NIL))
         (SEQ (LETT |oldList| (LIST 1))
              (SEQ (LETT |f| NIL)
                   (LETT #4#
                         (SPADCALL (SPADCALL |n| (QREFELT $ 25))
                                   (QREFELT $ 30)))
                   G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |f| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |newList| |oldList|)
                        (SEQ (LETT |k| 1) (LETT #3# (QVELT |f| 2)) G190
                             (COND ((|greater_SI| |k| #3#) (GO G191)))
                             (SEQ (LETT |pow| (EXPT (QVELT |f| 1) |k|))
                                  (EXIT
                                   (SEQ (LETT |m| NIL) (LETT #2# |oldList|)
                                        G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN (LETT |m| (CAR #2#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT |newList|
                                                (CONS (* |pow| |m|)
                                                      |newList|))))
                                        (LETT #2# (CDR #2#)) (GO G190) G191
                                        (EXIT NIL))))
                             (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT (LETT |oldList| |newList|)))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL (ELT $ 58) |oldList| (QREFELT $ 61)))))) 

(SDEFUN |INTHEORY;numberOfDivisors;2I;12|
        ((|n| (|Integer|)) ($ #1=(|Integer|)))
        (SPROG
         ((#2=#:G848 NIL) (#3=#:G847 #1#) (#4=#:G849 #1#) (#5=#:G851 NIL)
          (|entry| NIL))
         (SEQ
          (COND ((EQL |n| 0) 0)
                (#6='T
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |entry| NIL)
                       (LETT #5#
                             (SPADCALL (SPADCALL |n| (QREFELT $ 25))
                                       (QREFELT $ 30)))
                       G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |entry| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4# (+ 1 (QVELT |entry| 2)))
                          (COND (#2# (LETT #3# (* #3# #4#)))
                                ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#2# #3#) (#6# 1)))))))) 

(SDEFUN |INTHEORY;sumOfDivisors;2I;13| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|r| #1=(|Fraction| (|Integer|))) (#2=#:G854 NIL) (#3=#:G853 #1#)
          (#4=#:G855 #1#) (#5=#:G858 NIL) (|entry| NIL))
         (SEQ
          (COND ((EQL |n| 0) 0)
                (#6='T
                 (SEQ
                  (LETT |r|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |entry| NIL)
                              (LETT #5#
                                    (SPADCALL (SPADCALL |n| (QREFELT $ 25))
                                              (QREFELT $ 30)))
                              G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |entry| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #4#
                                       (SPADCALL
                                        (-
                                         (EXPT (QVELT |entry| 1)
                                               (+ (QVELT |entry| 2) 1))
                                         1)
                                        (- (QVELT |entry| 1) 1)
                                        (QREFELT $ 18)))
                                 (COND
                                  (#2#
                                   (LETT #3#
                                         (SPADCALL #3# #4# (QREFELT $ 45))))
                                  ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                         (COND (#2# #3#) (#6# (|spadConstant| $ 12)))))
                  (EXIT (SPADCALL |r| (QREFELT $ 56))))))))) 

(SDEFUN |INTHEORY;sumOfKthPowerDivisors;INniI;14|
        ((|n| (|Integer|)) (|k| (|NonNegativeInteger|)) ($ (|Integer|)))
        (SPROG
         ((|r| #1=(|Fraction| (|Integer|))) (#2=#:G861 NIL) (#3=#:G860 #1#)
          (#4=#:G862 #1#) (#5=#:G865 NIL) (|entry| NIL))
         (SEQ
          (COND ((EQL |n| 0) 0)
                (#6='T
                 (SEQ
                  (LETT |r|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |entry| NIL)
                              (LETT #5#
                                    (SPADCALL (SPADCALL |n| (QREFELT $ 25))
                                              (QREFELT $ 30)))
                              G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |entry| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #4#
                                       (SPADCALL
                                        (-
                                         (EXPT (QVELT |entry| 1)
                                               (+ (* |k| (QVELT |entry| 2))
                                                  |k|))
                                         1)
                                        (- (EXPT (QVELT |entry| 1) |k|) 1)
                                        (QREFELT $ 18)))
                                 (COND
                                  (#2#
                                   (LETT #3#
                                         (SPADCALL #3# #4# (QREFELT $ 45))))
                                  ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                         (COND (#2# #3#) (#6# (|spadConstant| $ 12)))))
                  (EXIT (SPADCALL |r| (QREFELT $ 56))))))))) 

(SDEFUN |INTHEORY;moebiusMu;2I;15| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((#1=#:G872 NIL) (#2=#:G873 NIL) (#3=#:G874 NIL) (|k| NIL)
          (|t| (|Factored| (|Integer|))))
         (SEQ
          (EXIT
           (COND ((EQL |n| 1) 1)
                 (#4='T
                  (SEQ (LETT |t| (SPADCALL |n| (QREFELT $ 25)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |k| NIL)
                              (LETT #3# (SPADCALL |t| (QREFELT $ 30))) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |k| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((> (QVELT |k| 2) 1)
                                  (PROGN
                                   (LETT #1#
                                         (PROGN (LETT #2# 0) (GO #5=#:G871)))
                                   (GO #6=#:G869))))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                        #6# (EXIT #1#))
                       (EXIT
                        (COND ((ODDP (SPADCALL |t| (QREFELT $ 66))) -1)
                              (#4# 1)))))))
          #5# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |IntegerNumberTheoryFunctions;|)) 

(DEFUN |IntegerNumberTheoryFunctions| ()
  (SPROG NIL
         (PROG (#1=#:G876)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|IntegerNumberTheoryFunctions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|IntegerNumberTheoryFunctions|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|IntegerNumberTheoryFunctions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|IntegerNumberTheoryFunctions|)))))))))) 

(DEFUN |IntegerNumberTheoryFunctions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|IntegerNumberTheoryFunctions|))
          (LETT $ (GETREFV 68))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegerNumberTheoryFunctions| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 10 (SPADCALL 1 1 (QREFELT $ 9)))
          (QSETREFV $ 15 (SPADCALL 1 (|spadConstant| $ 12) (QREFELT $ 14)))
          (QSETREFV $ 16 (CONS 1 (|spadConstant| $ 12)))
          $))) 

(MAKEPROP '|IntegerNumberTheoryFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|NonNegativeInteger|) (|Integer|)
              (|IndexedFlexibleArray| 7 (NRTEVAL 0)) (0 . |new|) 'E
              (|Fraction| 7) (6 . |One|)
              (|IndexedFlexibleArray| 11 (NRTEVAL 0)) (10 . |new|) 'B 'H
              (16 . |Zero|) (20 . /) (26 . +) |INTHEORY;harmonic;IF;1|
              |INTHEORY;fibonacci;2I;2| (|Boolean|) (32 . |bit?|)
              (|Factored| $) (38 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 26) (|:| |factor| 7) (|:| |exponent| 6))
              (|List| 27) (|Factored| 7) (43 . |factorList|) (|List| $)
              (48 . |lcm|) |INTHEORY;carmichaelLambda;2I;3| (53 . |#|)
              (58 . |elt|) (64 . |concat!|) (70 . |setelt!|)
              |INTHEORY;euler;2I;4| (77 . -) (82 . |#|) (87 . |elt|)
              (93 . |concat!|) (99 . |setelt!|) (106 . |coerce|) (111 . *)
              (117 . /) |INTHEORY;bernoulli;IF;5| (123 . ~=)
              (129 . |positiveRemainder|) |INTHEORY;chineseRemainder;5I;7|
              |INTHEORY;jacobi;3I;8| (|IntegerPrimesPackage| 7)
              (135 . |prime?|) |INTHEORY;legendre;3I;9| (140 . *)
              (146 . |numer|) |INTHEORY;eulerPhi;2I;10| (151 . <)
              (|Mapping| 22 7 7) (|List| 7) (157 . |sort|)
              |INTHEORY;divisors;IL;11| |INTHEORY;numberOfDivisors;2I;12|
              |INTHEORY;sumOfDivisors;2I;13|
              |INTHEORY;sumOfKthPowerDivisors;INniI;14|
              (163 . |numberOfFactors|) |INTHEORY;moebiusMu;2I;15|)
           '#(|sumOfKthPowerDivisors| 168 |sumOfDivisors| 174
              |numberOfDivisors| 179 |moebiusMu| 184 |legendre| 189 |jacobi|
              195 |harmonic| 201 |fibonacci| 206 |eulerPhi| 211 |euler| 216
              |divisors| 221 |chineseRemainder| 226 |carmichaelLambda| 234
              |bernoulli| 239)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|bernoulli|
                                 ((|Fraction| (|Integer|)) (|Integer|)))
                                T)
                              '((|carmichaelLambda| ((|Integer|) (|Integer|)))
                                T)
                              '((|chineseRemainder|
                                 ((|Integer|) (|Integer|) (|Integer|)
                                  (|Integer|) (|Integer|)))
                                T)
                              '((|divisors| ((|List| (|Integer|)) (|Integer|)))
                                T)
                              '((|euler| ((|Integer|) (|Integer|))) T)
                              '((|eulerPhi| ((|Integer|) (|Integer|))) T)
                              '((|fibonacci| ((|Integer|) (|Integer|))) T)
                              '((|harmonic|
                                 ((|Fraction| (|Integer|)) (|Integer|)))
                                T)
                              '((|jacobi|
                                 ((|Integer|) (|Integer|) (|Integer|)))
                                T)
                              '((|legendre|
                                 ((|Integer|) (|Integer|) (|Integer|)))
                                T)
                              '((|moebiusMu| ((|Integer|) (|Integer|))) T)
                              '((|numberOfDivisors| ((|Integer|) (|Integer|)))
                                T)
                              '((|sumOfDivisors| ((|Integer|) (|Integer|))) T)
                              '((|sumOfKthPowerDivisors|
                                 ((|Integer|) (|Integer|)
                                  (|NonNegativeInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 67
                                            '(2 8 0 6 7 9 0 11 0 12 2 13 0 6 11
                                              14 0 11 0 17 2 11 0 7 7 18 2 11 0
                                              0 0 19 2 7 22 0 0 23 1 7 24 0 25
                                              1 29 28 0 30 1 7 0 31 32 1 8 6 0
                                              34 2 8 7 0 7 35 2 8 0 0 0 36 3 8
                                              7 0 7 7 37 1 11 0 0 39 1 13 6 0
                                              40 2 13 11 0 7 41 2 13 0 0 0 42 3
                                              13 11 0 7 11 43 1 11 0 7 44 2 11
                                              0 0 11 45 2 11 0 0 0 46 2 7 22 0
                                              0 48 2 7 0 0 0 49 1 52 22 7 53 2
                                              11 0 7 0 55 1 11 7 0 56 2 7 22 0
                                              0 58 2 60 0 59 0 61 1 29 6 0 66 2
                                              0 7 7 6 65 1 0 7 7 64 1 0 7 7 63
                                              1 0 7 7 67 2 0 7 7 7 54 2 0 7 7 7
                                              51 1 0 11 7 20 1 0 7 7 21 1 0 7 7
                                              57 1 0 7 7 38 1 0 60 7 62 4 0 7 7
                                              7 7 7 50 1 0 7 7 33 1 0 11 7
                                              47)))))
           '|lookupComplete|)) 

(MAKEPROP '|IntegerNumberTheoryFunctions| 'NILADIC T) 

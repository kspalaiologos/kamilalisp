
(SDEFUN |JVF;diff;JB$;1| ((|jb| (JB)) ($ ($)))
        (CONS (LIST (|spadConstant| $ 14)) (LIST |jb|))) 

(SDEFUN |JVF;diffX;Pi$;2| ((|i| (|PositiveInteger|)) ($ ($)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 16)) (QREFELT $ 15))) 

(SDEFUN |JVF;diffU;Pi$;3| ((|i| (|PositiveInteger|)) ($ ($)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 18)) (QREFELT $ 15))) 

(SDEFUN |JVF;diffP;PiL$;4|
        ((|i| (|PositiveInteger|)) (|mu| (|List| (|NonNegativeInteger|)))
         ($ ($)))
        (SPADCALL (SPADCALL |i| |mu| (QREFELT $ 21)) (QREFELT $ 15))) 

(SDEFUN |JVF;monom| ((|c| (D)) (|jb| (JB)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |c| (QREFELT $ 24))
          (SPADCALL (SPADCALL "D" (QREFELT $ 27))
                    (SPADCALL |jb| (QREFELT $ 28)) (QREFELT $ 29)))
         ('T
          (SPADCALL (SPADCALL |c| (QREFELT $ 30))
                    (SPADCALL (SPADCALL "D" (QREFELT $ 27))
                              (SPADCALL |jb| (QREFELT $ 28)) (QREFELT $ 29))
                    (QREFELT $ 31))))) 

(SDEFUN |JVF;coerce;$Of;6| ((|v| ($)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G732 NIL) (|c| NIL) (#2=#:G733 NIL) (|jb| NIL) (#3=#:G731 NIL))
         (SEQ
          (COND
           ((NULL (QCDR |v|)) (SPADCALL (|spadConstant| $ 32) (QREFELT $ 30)))
           ((EQL (LENGTH (QCDR |v|)) 1)
            (|JVF;monom| (|SPADfirst| (QCAR |v|)) (|SPADfirst| (QCDR |v|)) $))
           ('T
            (SPADCALL (ELT $ 33)
                      (PROGN
                       (LETT #3# NIL)
                       (SEQ (LETT |jb| NIL) (LETT #2# (QCDR |v|))
                            (LETT |c| NIL) (LETT #1# (QCAR |v|)) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL)
                                  (ATOM #2#) (PROGN (LETT |jb| (CAR #2#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #3# (CONS (|JVF;monom| |c| |jb| $) #3#))))
                            (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                            (GO G190) G191 (EXIT (NREVERSE #3#))))
                      (QREFELT $ 36))))))) 

(SDEFUN |JVF;coefficients;$L;7| ((|v| ($)) ($ (|List| D)))
        (SPADCALL (QCAR |v|) (QREFELT $ 39))) 

(SDEFUN |JVF;directions;$L;8| ((|v| ($)) ($ (|List| JB)))
        (SPADCALL (QCDR |v|) (QREFELT $ 42))) 

(SDEFUN |JVF;coefficient;$JBD;9| ((|v| ($)) (|jb| (JB)) ($ (D)))
        (SPROG ((|pos| (|Integer|)))
               (SEQ (LETT |pos| (SPADCALL |jb| (QCDR |v|) (QREFELT $ 45)))
                    (EXIT
                     (COND
                      ((< |pos| (PROGN (QCDR |v|) 1)) (|spadConstant| $ 32))
                      ('T (SPADCALL (QCAR |v|) |pos| (QREFELT $ 46)))))))) 

(SDEFUN |JVF;copy;2$;10| ((|v| ($)) ($ ($)))
        (CONS (SPADCALL (QCAR |v|) (QREFELT $ 39))
              (SPADCALL (QCDR |v|) (QREFELT $ 42)))) 

(PUT '|JVF;Zero;$;11| '|SPADreplace| '(XLAM NIL (CONS NIL NIL))) 

(SDEFUN |JVF;Zero;$;11| (($ ($))) (CONS NIL NIL)) 

(SDEFUN |JVF;zero?;$B;12| ((|v| ($)) ($ (|Boolean|))) (NULL (QCDR |v|))) 

(SDEFUN |JVF;-;2$;13| ((|v| ($)) ($ ($)))
        (SPROG ((#1=#:G745 NIL) (|c| NIL) (#2=#:G744 NIL))
               (SEQ
                (CONS
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |c| NIL) (LETT #1# (QCAR |v|)) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |c| (QREFELT $ 51)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QCDR |v|))))) 

(SDEFUN |JVF;+;3$;14| ((|v| ($)) (|w| ($)) ($ ($)))
        (SPROG
         ((|lj2| (|List| JB)) (|lc2| (|List| D)) (|resJ| (|List| JB))
          (|resC| (|List| D)) (|sum| (D)) (#1=#:G764 NIL) (|c1| NIL)
          (#2=#:G765 NIL) (|j1| NIL))
         (SEQ
          (COND ((SPADCALL |v| (QREFELT $ 50)) |w|)
                ((SPADCALL |w| (QREFELT $ 50)) |v|)
                ('T
                 (SEQ (LETT |lc2| (SPADCALL (QCAR |w|) (QREFELT $ 39)))
                      (LETT |lj2| (SPADCALL (QCDR |w|) (QREFELT $ 42)))
                      (LETT |resC| NIL) (LETT |resJ| NIL)
                      (SEQ (LETT |j1| NIL) (LETT #2# (QCDR |v|))
                           (LETT |c1| NIL) (LETT #1# (QCAR |v|)) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |c1| (CAR #1#)) NIL)
                                 (ATOM #2#) (PROGN (LETT |j1| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND ((NULL |lj2|) NIL)
                                          ('T
                                           (SPADCALL (|SPADfirst| |lj2|) |j1|
                                                     (QREFELT $ 53)))))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |resC|
                                        (CONS (|SPADfirst| |lc2|) |resC|))
                                  (LETT |resJ|
                                        (CONS (|SPADfirst| |lj2|) |resJ|))
                                  (LETT |lc2| (CDR |lc2|))
                                  (EXIT (LETT |lj2| (CDR |lj2|))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT
                             (COND
                              ((OR (NULL |lj2|)
                                   (NULL
                                    (SPADCALL (|SPADfirst| |lj2|) |j1|
                                              (QREFELT $ 54))))
                               (SEQ (LETT |resC| (CONS |c1| |resC|))
                                    (EXIT (LETT |resJ| (CONS |j1| |resJ|)))))
                              ('T
                               (SEQ
                                (LETT |sum|
                                      (SPADCALL |c1| (|SPADfirst| |lc2|)
                                                (QREFELT $ 55)))
                                (COND
                                 ((NULL (SPADCALL |sum| (QREFELT $ 56)))
                                  (SEQ (LETT |resC| (CONS |sum| |resC|))
                                       (EXIT
                                        (LETT |resJ| (CONS |j1| |resJ|))))))
                                (LETT |lc2| (CDR |lc2|))
                                (EXIT (LETT |lj2| (CDR |lj2|))))))))
                           (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                           (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (CONS (SPADCALL (NREVERSE |resC|) |lc2| (QREFELT $ 57))
                             (SPADCALL (NREVERSE |resJ|) |lj2|
                                       (QREFELT $ 58)))))))))) 

(SDEFUN |JVF;*;D2$;15| ((|f| (D)) (|v| ($)) ($ ($)))
        (SPROG ((#1=#:G771 NIL) (|c| NIL) (#2=#:G770 NIL))
               (SEQ
                (COND ((SPADCALL |f| (QREFELT $ 56)) (|spadConstant| $ 49))
                      ('T
                       (CONS
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |c| NIL) (LETT #1# (QCAR |v|)) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |c| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |f| |c| (QREFELT $ 60))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))
                        (QCDR |v|))))))) 

(SDEFUN |JVF;prolong;$Nni$;16| ((|v| ($)) (|q| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|oldDir| (|List| JB)) (|oldCo| (|List| D)) (|newDir| (|List| JB))
          (|newCo| (|List| D)) (|res| ($)) (|newco| (D))
          (|nu| (|List| (|NonNegativeInteger|))) (#1=#:G851 NIL) (|i| NIL)
          (|j| (|Integer|)) (#2=#:G825 NIL) (|newjv| (JB)) (#3=#:G820 NIL)
          (#4=#:G818 NIL) (#5=#:G850 NIL) (|k| NIL)
          (|mu| (|List| (|NonNegativeInteger|))) (|a| (|PositiveInteger|))
          (|jm| (|SparseEchelonMatrix| JB D)) (#6=#:G848 NIL) (|jv| NIL)
          (#7=#:G849 NIL) (|co| NIL) (#8=#:G847 NIL) (|qq| NIL) (#9=#:G806 NIL)
          (#10=#:G846 NIL) (#11=#:G845 NIL) (#12=#:G844 NIL) (#13=#:G842 NIL)
          (#14=#:G843 NIL) (#15=#:G791 NIL) (#16=#:G841 NIL) (#17=#:G840 NIL)
          (|dxi| (|Matrix| D)) (|ind2| (|List| (|PositiveInteger|)))
          (|eta| (|List| D)) (|ind1| (|List| (|PositiveInteger|)))
          (|xi| (|List| D)) (|jt| (|Symbol|)) (#18=#:G838 NIL) (#19=#:G839 NIL)
          (|coeffs| (|List| D)) (|dirs| (|List| JB)))
         (SEQ
          (COND ((ZEROP |q|) |v|)
                ('T
                 (SEQ (LETT |dirs| (SPADCALL |v| (QREFELT $ 43)))
                      (LETT |coeffs| (SPADCALL |v| (QREFELT $ 40)))
                      (LETT |xi| NIL) (LETT |eta| NIL) (LETT |ind1| NIL)
                      (LETT |ind2| NIL)
                      (SEQ (LETT |co| NIL) (LETT #19# |coeffs|) (LETT |jv| NIL)
                           (LETT #18# |dirs|) G190
                           (COND
                            ((OR (ATOM #18#) (PROGN (LETT |jv| (CAR #18#)) NIL)
                                 (ATOM #19#)
                                 (PROGN (LETT |co| (CAR #19#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |jt| (SPADCALL |jv| (QREFELT $ 63)))
                                (EXIT
                                 (COND
                                  ((EQUAL |jt| '|Indep|)
                                   (SEQ (LETT |xi| (CONS |co| |xi|))
                                        (EXIT
                                         (LETT |ind1|
                                               (CONS
                                                (SPADCALL |jv| (QREFELT $ 64))
                                                |ind1|)))))
                                  ((EQUAL |jt| '|Dep|)
                                   (SEQ (LETT |eta| (CONS |co| |eta|))
                                        (EXIT
                                         (LETT |ind2|
                                               (CONS
                                                (SPADCALL |jv| (QREFELT $ 64))
                                                |ind2|)))))
                                  ('T
                                   (|error|
                                    "not base vector field in prolong")))))
                           (LETT #18#
                                 (PROG1 (CDR #18#) (LETT #19# (CDR #19#))))
                           (GO G190) G191 (EXIT NIL))
                      (LETT |dxi|
                            (MAKE_MATRIX1 (LENGTH |xi|) (QREFELT $ 10)
                                          (|spadConstant| $ 32)))
                      (SEQ (LETT |i| 1) (LETT |co| NIL) (LETT #17# |xi|) G190
                           (COND
                            ((OR (ATOM #17#)
                                 (PROGN (LETT |co| (CAR #17#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |jm| (SPADCALL (LIST |co|) (QREFELT $ 67)))
                            (EXIT
                             (SEQ (LETT |j| 1) (LETT #16# (QREFELT $ 10)) G190
                                  (COND ((|greater_SI| |j| #16#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (QSETAREF2O |dxi| |i| |j|
                                                (QCAR
                                                 (SPADCALL |co|
                                                           (PROG1
                                                               (LETT #15# |j|)
                                                             (|check_subtype2|
                                                              (> #15# 0)
                                                              '(|PositiveInteger|)
                                                              '(|NonNegativeInteger|)
                                                              #15#))
                                                           |jm|
                                                           (QREFELT $ 69)))
                                                1 1)))
                                  (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                  (EXIT NIL))))
                           (LETT #17#
                                 (PROG1 (CDR #17#) (LETT |i| (|inc_SI| |i|))))
                           (GO G190) G191 (EXIT NIL))
                      (LETT |j| (QREFELT $ 12)) (LETT |oldCo| NIL)
                      (SEQ (LETT |i| NIL) (LETT #14# |ind2|) (LETT |co| NIL)
                           (LETT #13# |eta|) G190
                           (COND
                            ((OR (ATOM #13#) (PROGN (LETT |co| (CAR #13#)) NIL)
                                 (ATOM #14#) (PROGN (LETT |i| (CAR #14#)) NIL))
                             (GO G191)))
                           (SEQ
                            (SEQ G190 (COND ((NULL (> |j| |i|)) (GO G191)))
                                 (SEQ
                                  (LETT |oldCo|
                                        (CONS (|spadConstant| $ 32) |oldCo|))
                                  (EXIT (LETT |j| (- |j| 1))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (LETT |oldCo| (CONS |co| |oldCo|))
                            (EXIT (LETT |j| (- |j| 1))))
                           (LETT #13#
                                 (PROG1 (CDR #13#) (LETT #14# (CDR #14#))))
                           (GO G190) G191 (EXIT NIL))
                      (COND
                       ((NULL (ZEROP |j|))
                        (SEQ (LETT |i| 1) (LETT #12# |j|) G190
                             (COND ((|greater_SI| |i| #12#) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |oldCo|
                                     (CONS (|spadConstant| $ 32) |oldCo|))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))))
                      (LETT |oldDir|
                            (PROGN
                             (LETT #11# NIL)
                             (SEQ (LETT |i| 1) (LETT #10# (QREFELT $ 12)) G190
                                  (COND ((|greater_SI| |i| #10#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #11#
                                          (CONS
                                           (SPADCALL
                                            (PROG1 (LETT #9# |i|)
                                              (|check_subtype2| (> #9# 0)
                                                                '(|PositiveInteger|)
                                                                '(|NonNegativeInteger|)
                                                                #9#))
                                            (QREFELT $ 18))
                                           #11#))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT (NREVERSE #11#)))))
                      (LETT |res| |v|)
                      (SEQ (LETT |qq| 1) (LETT #8# |q|) G190
                           (COND ((|greater_SI| |qq| #8#) (GO G191)))
                           (SEQ (LETT |newCo| NIL) (LETT |newDir| NIL)
                                (SEQ (LETT |co| NIL) (LETT #7# |oldCo|)
                                     (LETT |jv| NIL) (LETT #6# |oldDir|) G190
                                     (COND
                                      ((OR (ATOM #6#)
                                           (PROGN (LETT |jv| (CAR #6#)) NIL)
                                           (ATOM #7#)
                                           (PROGN (LETT |co| (CAR #7#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |jm|
                                            (SPADCALL (LIST |co|)
                                                      (QREFELT $ 67)))
                                      (LETT |a| (SPADCALL |jv| (QREFELT $ 64)))
                                      (LETT |mu|
                                            (SPADCALL |jv| (QREFELT $ 71)))
                                      (EXIT
                                       (SEQ
                                        (LETT |k|
                                              (MAX 1
                                                   (SPADCALL |jv|
                                                             (QREFELT $ 73))))
                                        (LETT #5# (QREFELT $ 10)) G190
                                        (COND ((> |k| #5#) (GO G191)))
                                        (SEQ
                                         (LETT |newjv|
                                               (PROG2
                                                   (LETT #3#
                                                         (SPADCALL |jv|
                                                                   (PROG1
                                                                       (LETT
                                                                        #4#
                                                                        |k|)
                                                                     (|check_subtype2|
                                                                      (> #4# 0)
                                                                      '(|PositiveInteger|)
                                                                      '(|NonNegativeInteger|)
                                                                      #4#))
                                                                   (QREFELT $
                                                                            75)))
                                                   (QCDR #3#)
                                                 (|check_union2| (QEQCAR #3# 0)
                                                                 (QREFELT $ 6)
                                                                 (|Union|
                                                                  (QREFELT $ 6)
                                                                  "0")
                                                                 #3#)))
                                         (LETT |newco|
                                               (QCAR
                                                (SPADCALL |co|
                                                          (PROG1 (LETT #2# |k|)
                                                            (|check_subtype2|
                                                             (> #2# 0)
                                                             '(|PositiveInteger|)
                                                             '(|NonNegativeInteger|)
                                                             #2#))
                                                          |jm|
                                                          (QREFELT $ 69))))
                                         (SEQ (LETT |j| 1) (LETT |i| NIL)
                                              (LETT #1# |ind1|) G190
                                              (COND
                                               ((OR (ATOM #1#)
                                                    (PROGN
                                                     (LETT |i| (CAR #1#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (LETT |nu|
                                                     (SPADCALL |mu|
                                                               (QREFELT $ 76)))
                                               (SPADCALL |nu| |i|
                                                         (+
                                                          (SPADCALL |nu| |i|
                                                                    (QREFELT $
                                                                             77))
                                                          1)
                                                         (QREFELT $ 78))
                                               (EXIT
                                                (LETT |newco|
                                                      (SPADCALL |newco|
                                                                (SPADCALL
                                                                 (QAREF2O |dxi|
                                                                          |j|
                                                                          |k| 1
                                                                          1)
                                                                 (SPADCALL
                                                                  (SPADCALL |a|
                                                                            |nu|
                                                                            (QREFELT
                                                                             $
                                                                             79))
                                                                  (QREFELT $
                                                                           80))
                                                                 (QREFELT $
                                                                          60))
                                                                (QREFELT $
                                                                         81)))))
                                              (LETT #1#
                                                    (PROG1 (CDR #1#)
                                                      (LETT |j|
                                                            (|inc_SI| |j|))))
                                              (GO G190) G191 (EXIT NIL))
                                         (LETT |res|
                                               (SPADCALL |res|
                                                         (SPADCALL |newco|
                                                                   (SPADCALL
                                                                    |newjv|
                                                                    (QREFELT $
                                                                             15))
                                                                   (QREFELT $
                                                                            61))
                                                         (QREFELT $ 59)))
                                         (LETT |newCo| (CONS |newco| |newCo|))
                                         (EXIT
                                          (LETT |newDir|
                                                (CONS |newjv| |newDir|))))
                                        (LETT |k| (+ |k| 1)) (GO G190) G191
                                        (EXIT NIL))))
                                     (LETT #6#
                                           (PROG1 (CDR #6#)
                                             (LETT #7# (CDR #7#))))
                                     (GO G190) G191 (EXIT NIL))
                                (LETT |oldCo| |newCo|)
                                (EXIT (LETT |oldDir| |newDir|)))
                           (LETT |qq| (|inc_SI| |qq|)) (GO G190) G191
                           (EXIT NIL))
                      (EXIT |res|))))))) 

(SDEFUN |JVF;eval;$2D;17| ((|v| ($)) (|f| (D)) ($ (D)))
        (SPROG
         ((|res| (D)) (#1=#:G856 NIL) (|c| NIL) (#2=#:G857 NIL) (|jb| NIL))
         (SEQ (LETT |res| (|spadConstant| $ 32))
              (SEQ (LETT |jb| NIL) (LETT #2# (QCDR |v|)) (LETT |c| NIL)
                   (LETT #1# (QCAR |v|)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL) (ATOM #2#)
                         (PROGN (LETT |jb| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res|
                                     (SPADCALL |c|
                                               (SPADCALL |f| |jb|
                                                         (QREFELT $ 83))
                                               (QREFELT $ 60))
                                     (QREFELT $ 55)))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |JVF;commutator;3$;18| ((|v| ($)) (|w| ($)) ($ ($)))
        (SPROG
         ((|res2| ($)) (|rjb| (|List| JB)) (|rco| (|List| D)) (|sum| (D))
          (#1=#:G878 NIL) (|c1| NIL) (#2=#:G879 NIL) (|j1| NIL) (#3=#:G876 NIL)
          (|c2| NIL) (#4=#:G877 NIL) (|j2| NIL) (|res1| ($)) (#5=#:G874 NIL)
          (#6=#:G875 NIL) (#7=#:G872 NIL) (#8=#:G873 NIL))
         (SEQ (LETT |rco| NIL) (LETT |rjb| NIL)
              (SEQ (LETT |j1| NIL) (LETT #8# (QCDR |v|)) (LETT |c1| NIL)
                   (LETT #7# (QCAR |v|)) G190
                   (COND
                    ((OR (ATOM #7#) (PROGN (LETT |c1| (CAR #7#)) NIL)
                         (ATOM #8#) (PROGN (LETT |j1| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |sum| (|spadConstant| $ 32))
                        (SEQ (LETT |j2| NIL) (LETT #6# (QCDR |w|))
                             (LETT |c2| NIL) (LETT #5# (QCAR |w|)) G190
                             (COND
                              ((OR (ATOM #5#) (PROGN (LETT |c2| (CAR #5#)) NIL)
                                   (ATOM #6#)
                                   (PROGN (LETT |j2| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |sum|
                                     (SPADCALL |sum|
                                               (SPADCALL |c2|
                                                         (SPADCALL |c1| |j2|
                                                                   (QREFELT $
                                                                            83))
                                                         (QREFELT $ 60))
                                               (QREFELT $ 55)))))
                             (LETT #5# (PROG1 (CDR #5#) (LETT #6# (CDR #6#))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((NULL (SPADCALL |sum| (QREFELT $ 56)))
                           (SEQ (LETT |rco| (CONS |sum| |rco|))
                                (EXIT (LETT |rjb| (CONS |j1| |rjb|))))))))
                   (LETT #7# (PROG1 (CDR #7#) (LETT #8# (CDR #8#)))) (GO G190)
                   G191 (EXIT NIL))
              (LETT |res1| (CONS (NREVERSE |rco|) (NREVERSE |rjb|)))
              (LETT |rco| NIL) (LETT |rjb| NIL)
              (SEQ (LETT |j2| NIL) (LETT #4# (QCDR |w|)) (LETT |c2| NIL)
                   (LETT #3# (QCAR |w|)) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |c2| (CAR #3#)) NIL)
                         (ATOM #4#) (PROGN (LETT |j2| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |sum| (|spadConstant| $ 32))
                        (SEQ (LETT |j1| NIL) (LETT #2# (QCDR |v|))
                             (LETT |c1| NIL) (LETT #1# (QCAR |v|)) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |c1| (CAR #1#)) NIL)
                                   (ATOM #2#)
                                   (PROGN (LETT |j1| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |sum|
                                     (SPADCALL |sum|
                                               (SPADCALL |c1|
                                                         (SPADCALL |c2| |j1|
                                                                   (QREFELT $
                                                                            83))
                                                         (QREFELT $ 60))
                                               (QREFELT $ 55)))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((NULL (SPADCALL |sum| (QREFELT $ 56)))
                           (SEQ (LETT |rco| (CONS |sum| |rco|))
                                (EXIT (LETT |rjb| (CONS |j2| |rjb|))))))))
                   (LETT #3# (PROG1 (CDR #3#) (LETT #4# (CDR #4#)))) (GO G190)
                   G191 (EXIT NIL))
              (LETT |res2| (CONS (NREVERSE |rco|) (NREVERSE |rjb|)))
              (EXIT (SPADCALL |res2| |res1| (QREFELT $ 85)))))) 

(SDEFUN |JVF;table;LTda;19| ((|lv| (|List| $)) ($ (|TwoDimensionalArray| $)))
        (SPROG
         ((|c| ($)) (#1=#:G892 NIL) (|v2| NIL) (|j| NIL) (|v1| ($)) (|i| NIL)
          (#2=#:G891 NIL) (|res| (|TwoDimensionalArray| $))
          (|len| (|NonNegativeInteger|)))
         (SEQ (LETT |len| (SPADCALL |lv| (QREFELT $ 88)))
              (EXIT
               (COND ((ZEROP |len|) (|error| "empty list in table"))
                     ('T
                      (SEQ
                       (LETT |res|
                             (SPADCALL |len| |len| (|spadConstant| $ 49)
                                       (QREFELT $ 90)))
                       (SEQ (LETT #2# NIL) (LETT |i| 1) G190
                            (COND (#2# (GO G191)))
                            (SEQ (LETT |v1| (SPADCALL |lv| (QREFELT $ 91)))
                                 (LETT |lv| (SPADCALL |lv| (QREFELT $ 92)))
                                 (EXIT
                                  (SEQ (LETT |j| (+ |i| 1)) (LETT |v2| NIL)
                                       (LETT #1# |lv|) G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |v2| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |c|
                                              (SPADCALL |v1| |v2|
                                                        (QREFELT $ 86)))
                                        (SPADCALL |res| |i| |j| |c|
                                                  (QREFELT $ 93))
                                        (EXIT
                                         (SPADCALL |res| |j| |i|
                                                   (SPADCALL |c|
                                                             (QREFELT $ 52))
                                                   (QREFELT $ 93))))
                                       (LETT #1#
                                             (PROG1 (CDR #1#)
                                               (LETT |j| (+ |j| 1))))
                                       (GO G190) G191 (EXIT NIL))))
                            (LETT |i|
                                  (PROG1 (|inc_SI| |i|)
                                    (LETT #2# (SPADCALL |lv| (QREFELT $ 94)))))
                            (GO G190) G191 (EXIT NIL))
                       (EXIT |res|)))))))) 

(SDEFUN |JVF;lie;3$;20| ((|v| ($)) (|w| ($)) ($ ($)))
        (SPADCALL |v| |w| (QREFELT $ 86))) 

(DECLAIM (NOTINLINE |JetVectorField;|)) 

(DEFUN |JetVectorField| (&REST #1=#:G898)
  (SPROG NIL
         (PROG (#2=#:G899)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|JetVectorField|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |JetVectorField;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|JetVectorField|)))))))))) 

(DEFUN |JetVectorField;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G897 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|JetVectorField| DV$1 DV$2))
    (LETT $ (GETREFV 101))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2| '(|AbelianGroup|))
                                        (LETT #1#
                                              (|HasCategory| |#2|
                                                             '(|AbelianMonoid|)))
                                        (OR
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         #1#)))))
    (|haddProp| |$ConstructorCache| '|JetVectorField| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
    (QSETREFV $ 12 (SPADCALL (QREFELT $ 11)))
    (QSETREFV $ 13
              (|Record| (|:| |Coeff| (|List| |#2|)) (|:| |Dir| (|List| |#1|))))
    $))) 

(MAKEPROP '|JetVectorField| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|PositiveInteger|) (0 . |numIndVar|) '|nn| (4 . |numDepVar|)
              '|mm| '|Rep| (8 . |One|) |JVF;diff;JB$;1| (12 . X)
              |JVF;diffX;Pi$;2| (17 . U) |JVF;diffU;Pi$;3| (|List| 72) (22 . P)
              |JVF;diffP;PiL$;4| (|Boolean|) (28 . |one?|) (|String|)
              (|OutputForm|) (33 . |message|) (38 . |coerce|) (43 . |sub|)
              (49 . |coerce|) (54 . *) (60 . |Zero|) (64 . +)
              (|Mapping| 26 26 26) (|List| 26) (70 . |reduce|)
              |JVF;coerce;$Of;6| (|List| 7) (76 . |copy|)
              |JVF;coefficients;$L;7| (|List| 6) (81 . |copy|)
              |JVF;directions;$L;8| (|Integer|) (86 . |position|) (92 . |qelt|)
              |JVF;coefficient;$JBD;9| |JVF;copy;2$;10|
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |JVF;Zero;$;11|) $))
              |JVF;zero?;$B;12| (98 . -) |JVF;-;2$;13| (103 . <) (109 . =)
              (115 . +) (121 . |zero?|) (126 . |concat!|) (132 . |concat!|)
              |JVF;+;3$;14| (138 . *) |JVF;*;D2$;15| (|Symbol|) (144 . |type|)
              (149 . |index|) (|SparseEchelonMatrix| 6 $) (|List| $)
              (154 . |jacobiMatrix|) (|Record| (|:| |DPhi| $) (|:| |JVars| 41))
              (159 . |formalDiff2|) (166 . |One|) (170 . |multiIndex|)
              (|NonNegativeInteger|) (175 . |class|) (|Union| $ '"0")
              (180 . |differentiate|) (186 . |copy|) (191 . |qelt|)
              (197 . |qsetelt!|) (204 . |Pm|) (210 . |coerce|) (215 . -)
              |JVF;prolong;$Nni$;16| (221 . |differentiate|) |JVF;eval;$2D;17|
              (227 . -) |JVF;commutator;3$;18| (|List| $$) (233 . |#|)
              (|TwoDimensionalArray| $$) (238 . |new|) (245 . |first|)
              (250 . |rest|) (255 . |qsetelt!|) (263 . |empty?|)
              (|TwoDimensionalArray| $) |JVF;table;LTda;19| |JVF;lie;3$;20|
              (|Union| $ '"failed") (|HashState|) (|SingleInteger|))
           '#(~= 268 |zero?| 274 |table| 279 |subtractIfCan| 284 |sample| 290
              |prolong| 294 |opposite?| 300 |lie| 306 |latex| 312 |hashUpdate!|
              317 |hash| 323 |eval| 328 |directions| 334 |diffX| 339 |diffU|
              344 |diffP| 349 |diff| 355 |copy| 360 |commutator| 365 |coerce|
              371 |coefficients| 376 |coefficient| 381 |Zero| 387 = 391 - 397 +
              408 * 414)
           'NIL
           (CONS (|makeByteWordVec2| 3 '(0 0 0 0 1 1 3 0 0 0 0))
                 (CONS
                  '#(|Module&| NIL NIL NIL |AbelianGroup&| NIL |AbelianMonoid&|
                     |AbelianSemiGroup&| |SetCategory&| |BasicType&| NIL)
                  (CONS
                   '#((|Module| 7) (|BiModule| 7 7) (|LeftModule| 7)
                      (|RightModule| 7) (|AbelianGroup|)
                      (|CancellationAbelianMonoid|) (|AbelianMonoid|)
                      (|AbelianSemiGroup|) (|SetCategory|) (|BasicType|)
                      (|CoercibleTo| 26))
                   (|makeByteWordVec2| 100
                                       '(0 6 8 9 0 6 8 11 0 7 0 14 1 6 0 8 16 1
                                         6 0 8 18 2 6 0 8 20 21 1 7 23 0 24 1
                                         26 0 25 27 1 6 26 0 28 2 26 0 0 0 29 1
                                         7 26 0 30 2 26 0 0 0 31 0 7 0 32 2 26
                                         0 0 0 33 2 35 26 34 0 36 1 38 0 0 39 1
                                         41 0 0 42 2 41 44 6 0 45 2 38 7 0 44
                                         46 1 7 0 0 51 2 6 23 0 0 53 2 6 23 0 0
                                         54 2 7 0 0 0 55 1 7 23 0 56 2 38 0 0 0
                                         57 2 41 0 0 0 58 2 7 0 0 0 60 1 6 62 0
                                         63 1 6 8 0 64 1 7 65 66 67 3 7 68 0 8
                                         65 69 0 6 0 70 1 6 20 0 71 1 6 72 0 73
                                         2 6 74 0 8 75 1 20 0 0 76 2 20 72 0 44
                                         77 3 20 72 0 44 72 78 2 6 0 8 20 79 1
                                         7 0 6 80 2 7 0 0 0 81 2 7 0 0 6 83 2 0
                                         0 0 0 85 1 87 72 0 88 3 89 0 72 72 2
                                         90 1 87 2 0 91 1 87 0 0 92 4 89 2 0 44
                                         44 2 93 1 87 23 0 94 2 0 23 0 0 1 1 2
                                         23 0 50 1 0 95 66 96 2 1 98 0 0 1 0 2
                                         0 1 2 0 0 0 72 82 2 2 23 0 0 1 2 0 0 0
                                         0 97 1 0 25 0 1 2 0 99 99 0 1 1 0 100
                                         0 1 2 0 7 0 7 84 1 0 41 0 43 1 0 0 8
                                         17 1 0 0 8 19 2 0 0 8 20 22 1 0 0 6 15
                                         1 0 0 0 48 2 0 0 0 0 86 1 0 26 0 37 1
                                         0 38 0 40 2 0 7 0 6 47 0 2 0 49 2 0 23
                                         0 0 1 2 1 0 0 0 85 1 1 0 0 52 2 0 0 0
                                         0 59 2 1 0 44 0 1 2 2 0 72 0 1 2 0 0 0
                                         7 1 2 0 0 7 0 61 2 0 0 8 0 1)))))
           '|lookupComplete|)) 


(SDEFUN |JDE;setSimpMode;2Nni;1|
        ((|i| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((|j| (|NonNegativeInteger|)))
               (SEQ (LETT |j| (QREFELT $ 13)) (SETELT $ 13 |i|) (EXIT |j|)))) 

(SDEFUN |JDE;adapt|
        ((|der| (|List| (|NonNegativeInteger|))) (|pro?| (|List| (|Boolean|)))
         (|dep| (|Union| "failed" (|List| (|List| (|NonNegativeInteger|)))))
         ($
          (|Record| (|:| |Der| (|List| (|NonNegativeInteger|)))
                    (|:| |Pro?| (|List| (|Boolean|))))))
        (SPROG
         ((|resPro?| (|List| (|Boolean|)))
          (|resDer| (|List| (|NonNegativeInteger|))) (|b| (|Boolean|))
          (#1=#:G767 NIL) (|i| NIL) (#2=#:G766 NIL)
          (|j| (|NonNegativeInteger|)) (#3=#:G765 NIL) (#4=#:G764 NIL)
          (#5=#:G763 NIL) (|d| NIL) (#6=#:G762 NIL) (#7=#:G761 NIL)
          (#8=#:G760 NIL) (#9=#:G759 NIL))
         (SEQ
          (COND
           ((QEQCAR |dep| 0)
            (CONS
             (PROGN
              (LETT #9# NIL)
              (SEQ (LETT |i| NIL) (LETT #8# |der|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |i| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (LETT #9# (CONS 1 #9#)))) (LETT #8# (CDR #8#))
                   (GO G190) G191 (EXIT (NREVERSE #9#))))
             (PROGN
              (LETT #7# NIL)
              (SEQ (LETT |i| NIL) (LETT #6# |der|) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |i| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (LETT #7# (CONS NIL #7#)))) (LETT #6# (CDR #6#))
                   (GO G190) G191 (EXIT (NREVERSE #7#))))))
           ('T
            (SEQ (LETT |resDer| NIL) (LETT |resPro?| NIL)
                 (SEQ (LETT |d| NIL) (LETT #5# (QCDR |dep|)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |d| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((EQL (SPADCALL |d| (QREFELT $ 17)) 1)
                          (SEQ
                           (LETT |resDer|
                                 (CONS
                                  (SPADCALL |der| (|SPADfirst| |d|)
                                            (QREFELT $ 19))
                                  |resDer|))
                           (EXIT
                            (LETT |resPro?|
                                  (CONS
                                   (SPADCALL |pro?| (|SPADfirst| |d|)
                                             (QREFELT $ 22))
                                   |resPro?|)))))
                         ('T
                          (SEQ
                           (LETT |j|
                                 (SPADCALL (ELT $ 23)
                                           (PROGN
                                            (LETT #4# NIL)
                                            (SEQ (LETT |i| NIL) (LETT #3# |d|)
                                                 G190
                                                 (COND
                                                  ((OR (ATOM #3#)
                                                       (PROGN
                                                        (LETT |i| (CAR #3#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #4#
                                                         (CONS
                                                          (SPADCALL |der| |i|
                                                                    (QREFELT $
                                                                             19))
                                                          #4#))))
                                                 (LETT #3# (CDR #3#)) (GO G190)
                                                 G191 (EXIT (NREVERSE #4#))))
                                           (QREFELT $ 25)))
                           (LETT |b|
                                 (SPADCALL (ELT $ 26)
                                           (PROGN
                                            (LETT #2# NIL)
                                            (SEQ (LETT |i| NIL) (LETT #1# |d|)
                                                 G190
                                                 (COND
                                                  ((OR (ATOM #1#)
                                                       (PROGN
                                                        (LETT |i| (CAR #1#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #2#
                                                         (CONS
                                                          (SPADCALL |pro?| |i|
                                                                    (QREFELT $
                                                                             22))
                                                          #2#))))
                                                 (LETT #1# (CDR #1#)) (GO G190)
                                                 G191 (EXIT (NREVERSE #2#))))
                                           (QREFELT $ 28)))
                           (LETT |resDer| (CONS |j| |resDer|))
                           (EXIT (LETT |resPro?| (CONS |b| |resPro?|))))))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (EXIT (CONS (NREVERSE |resDer|) (NREVERSE |resPro?|))))))))) 

(SDEFUN |JDE;copy;2$;3| ((|De| ($)) ($ ($)))
        (SPROG
         ((|newOrd| (|List| (|NonNegativeInteger|)))
          (|newSys| (|List| |SysRec|)) (#1=#:G779 NIL) (|sys| NIL)
          (#2=#:G778 NIL))
         (SEQ
          (LETT |newSys|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |sys| NIL) (LETT #1# (QCAR |De|)) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |sys| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (VECTOR
                                (SPADCALL (QVELT |sys| 0) (QREFELT $ 32))
                                (SPADCALL (QVELT |sys| 1) (QREFELT $ 34))
                                (SPADCALL (QVELT |sys| 2) (QREFELT $ 35))
                                (SPADCALL (QVELT |sys| 3) (QREFELT $ 36))
                                (QVELT |sys| 4) (QVELT |sys| 5)
                                (QVELT |sys| 6))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (LETT |newOrd| (SPADCALL (QCDR |De|) (QREFELT $ 35)))
          (EXIT (CONS |newSys| |newOrd|))))) 

(SDEFUN |JDE;order;$Nni;4| ((|De| ($)) ($ (|NonNegativeInteger|)))
        (COND ((NULL (QCDR |De|)) 0) ('T (|SPADfirst| (QCDR |De|))))) 

(SDEFUN |JDE;retract;$L;5| ((|De| ($)) ($ (|List| D)))
        (SPROG
         ((|LSys| (|List| (|List| D))) (#1=#:G789 NIL) (|sys| NIL)
          (#2=#:G788 NIL))
         (SEQ
          (LETT |LSys|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |sys| NIL) (LETT #1# (QCAR |De|)) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |sys| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QVELT |sys| 0) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL (ELT $ 39) |LSys| NIL (QREFELT $ 42)))))) 

(SDEFUN |JDE;jacobiMatrix;$L;6|
        ((|De| ($)) ($ (|List| (|SparseEchelonMatrix| JB D))))
        (SPROG ((#1=#:G794 NIL) (|sys| NIL) (#2=#:G793 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |sys| NIL) (LETT #1# (QCAR |De|)) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |sys| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QVELT |sys| 1) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |JDE;printSys;LOf;7| ((|sys| (|List| D)) ($ (|OutputForm|)))
        (SPROG
         ((|tmp| (|List| (|OutputForm|))) (#1=#:G804 NIL) (|eq| NIL)
          (|leq| (|List| (|Equation| D))) (#2=#:G803 NIL) (#3=#:G802 NIL))
         (SEQ
          (COND ((NULL |sys|) (SPADCALL (QREFELT $ 47)))
                ('T
                 (SEQ
                  (LETT |leq|
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |eq| NIL) (LETT #2# |sys|) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |eq| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #3#
                                      (CONS
                                       (SPADCALL |eq| (|spadConstant| $ 48)
                                                 (QREFELT $ 50))
                                       #3#))))
                              (LETT #2# (CDR #2#)) (GO G190) G191
                              (EXIT (NREVERSE #3#)))))
                  (LETT |tmp| NIL)
                  (SEQ (LETT |eq| NIL) (LETT #1# |leq|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |eq| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |tmp|
                               (CONS (SPADCALL |eq| (QREFELT $ 51))
                                     (CONS (SPADCALL " " (QREFELT $ 53))
                                           |tmp|)))))
                       (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                  (EXIT (SPADCALL (REVERSE |tmp|) (QREFELT $ 55))))))))) 

(SDEFUN |JDE;coerce;$Of;8| ((|De| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |De| (QREFELT $ 43)) (QREFELT $ 56))) 

(SDEFUN |JDE;display;$V;9| ((|De| ($)) ($ (|Void|)))
        (SPROG ((#1=#:G813 NIL) (|sys| NIL) (#2=#:G814 NIL) (|ord| NIL))
               (SEQ
                (SEQ (LETT |ord| NIL) (LETT #2# (QCDR |De|)) (LETT |sys| NIL)
                     (LETT #1# (QCAR |De|)) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |sys| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |ord| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (SPADCALL
                       (SPADCALL (SPADCALL "Order: " (QREFELT $ 53))
                                 (SPADCALL |ord| (QREFELT $ 58))
                                 (QREFELT $ 59))
                       (QREFELT $ 61))
                      (SPADCALL (SPADCALL "  System:" (QREFELT $ 53))
                                (QREFELT $ 61))
                      (SPADCALL
                       (SPADCALL (SPADCALL "    " (QREFELT $ 53))
                                 (SPADCALL (QVELT |sys| 0) (QREFELT $ 56))
                                 (QREFELT $ 59))
                       (QREFELT $ 61))
                      (COND
                       ((QVELT |sys| 4)
                        (SPADCALL
                         (SPADCALL "    (system simplified)" (QREFELT $ 53))
                         (QREFELT $ 61))))
                      (COND
                       ((QVELT |sys| 5)
                        (SPADCALL
                         (SPADCALL (SPADCALL "  Dimension: " (QREFELT $ 53))
                                   (SPADCALL (QVELT |sys| 6) (QREFELT $ 58))
                                   (QREFELT $ 59))
                         (QREFELT $ 61))))
                      (SPADCALL (SPADCALL "  Jacobi matrix:" (QREFELT $ 53))
                                (QREFELT $ 61))
                      (SPADCALL
                       (SPADCALL (SPADCALL "    " (QREFELT $ 53))
                                 (SPADCALL (QVELT |sys| 1) (QREFELT $ 62))
                                 (QREFELT $ 59))
                       (QREFELT $ 61))
                      (SPADCALL
                       (SPADCALL (SPADCALL "    " (QREFELT $ 53))
                                 (SPADCALL
                                  (SPADCALL (QVELT |sys| 1) (QREFELT $ 64))
                                  (QREFELT $ 65))
                                 (QREFELT $ 59))
                       (QREFELT $ 61))
                      (SPADCALL (SPADCALL "  Last derivations:" (QREFELT $ 53))
                                (QREFELT $ 61))
                      (EXIT
                       (SPADCALL
                        (SPADCALL (SPADCALL "    " (QREFELT $ 53))
                                  (SPADCALL (QVELT |sys| 2) (QREFELT $ 66))
                                  (QREFELT $ 59))
                        (QREFELT $ 61))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL (QREFELT $ 67)))))) 

(SDEFUN |JDE;makeSystem2|
        ((|sys| (|List| D)) (|jm| (|SparseEchelonMatrix| JB D))
         (|der| (|List| (|NonNegativeInteger|))) ($ ($)))
        (SPROG
         ((|resSys| (|List| |SysRec|)) (|rec| (|SysRec|)) (#1=#:G842 NIL)
          (|ord| NIL) (|i| NIL) (|pos| (|Integer|)) (#2=#:G839 NIL) (|eq| NIL)
          (#3=#:G840 NIL) (#4=#:G841 NIL) (|q| NIL) (|j| NIL)
          (|vjm| (|Vector| (|SparseEchelonMatrix| JB D)))
          (|vder| (|Vector| (|List| (|NonNegativeInteger|))))
          (|vsys| (|Vector| (|List| D)))
          (|ljm| (|List| (|SparseEchelonMatrix| JB D))) (|inds| (|List| JB))
          (#5=#:G838 NIL) (|nord| (|NonNegativeInteger|))
          (|resOrd| (|List| (|NonNegativeInteger|)))
          (|lord| (|List| (|NonNegativeInteger|))) (#6=#:G837 NIL)
          (#7=#:G836 NIL))
         (SEQ
          (LETT |lord|
                (PROGN
                 (LETT #7# NIL)
                 (SEQ (LETT |i| 1) (LETT #6# (SPADCALL |jm| (QREFELT $ 69)))
                      G190 (COND ((|greater_SI| |i| #6#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #7#
                              (CONS
                               (SPADCALL
                                (|SPADfirst|
                                 (QCAR (SPADCALL |jm| |i| (QREFELT $ 71))))
                                (QREFELT $ 72))
                               #7#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #7#)))))
          (LETT |resOrd|
                (REVERSE
                 (SPADCALL (SPADCALL |lord| (QREFELT $ 73)) (QREFELT $ 74))))
          (LETT |nord| (SPADCALL |resOrd| (QREFELT $ 17)))
          (LETT |inds| (SPADCALL |jm| (QREFELT $ 64))) (LETT |ljm| NIL)
          (SEQ (LETT |q| NIL) (LETT #5# |resOrd|) G190
               (COND
                ((OR (ATOM #5#) (PROGN (LETT |q| (CAR #5#)) NIL)) (GO G191)))
               (SEQ
                (SEQ G190
                     (COND
                      ((NULL
                        (> (SPADCALL (|SPADfirst| |inds|) (QREFELT $ 72)) |q|))
                       (GO G191)))
                     (SEQ (EXIT (LETT |inds| (CDR |inds|)))) NIL (GO G190) G191
                     (EXIT NIL))
                (EXIT
                 (LETT |ljm| (CONS (SPADCALL |inds| 1 (QREFELT $ 77)) |ljm|))))
               (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
          (LETT |vsys| (MAKEARR1 |nord| NIL))
          (LETT |vder| (MAKEARR1 |nord| NIL))
          (LETT |vjm| (SPADCALL (NREVERSE |ljm|) (QREFELT $ 79)))
          (SEQ (LETT |j| (SPADCALL |jm| (QREFELT $ 69))) (LETT |q| NIL)
               (LETT #4# (REVERSE |lord|)) (LETT |i| NIL)
               (LETT #3# (REVERSE |der|)) (LETT |eq| NIL)
               (LETT #2# (REVERSE |sys|)) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |eq| (CAR #2#)) NIL) (ATOM #3#)
                     (PROGN (LETT |i| (CAR #3#)) NIL) (ATOM #4#)
                     (PROGN (LETT |q| (CAR #4#)) NIL) (< |j| 1))
                 (GO G191)))
               (SEQ
                (LETT |pos|
                      (- (+ (SPADCALL |q| |resOrd| (QREFELT $ 80)) 1)
                         (PROGN |resOrd| 1)))
                (EXIT
                 (COND
                  ((NULL (QAREF1O |vsys| |pos| 1))
                   (SEQ (QSETAREF1O |vsys| |pos| (LIST |eq|) 1)
                        (SPADCALL (QAREF1O |vjm| |pos| 1) 1
                                  (SPADCALL |jm| |j| (QREFELT $ 71))
                                  (QREFELT $ 81))
                        (EXIT (QSETAREF1O |vder| |pos| (LIST |i|) 1))))
                  ('T
                   (SEQ
                    (QSETAREF1O |vsys| |pos|
                                (CONS |eq| (QAREF1O |vsys| |pos| 1)) 1)
                    (SPADCALL (QAREF1O |vjm| |pos| 1)
                              (SPADCALL |jm| |j| (QREFELT $ 71))
                              (QREFELT $ 82))
                    (EXIT
                     (QSETAREF1O |vder| |pos|
                                 (CONS |i| (QAREF1O |vder| |pos| 1)) 1)))))))
               (LETT #2#
                     (PROG1 (CDR #2#)
                       (LETT #3#
                             (PROG1 (CDR #3#)
                               (LETT #4#
                                     (PROG1 (CDR #4#)
                                       (LETT |j| (+ |j| -1))))))))
               (GO G190) G191 (EXIT NIL))
          (LETT |resSys| NIL)
          (SEQ (LETT |i| (SPADCALL |vsys| (QREFELT $ 84))) (LETT |ord| NIL)
               (LETT #1# |resOrd|) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |ord| (CAR #1#)) NIL)) (GO G191)))
               (SEQ
                (LETT |rec|
                      (VECTOR (QAREF1O |vsys| |i| 1) (QAREF1O |vjm| |i| 1)
                              (QAREF1O |vder| |i| 1)
                              (SPADCALL
                               (SPADCALL (QAREF1O |vder| |i| 1) (QREFELT $ 17))
                               NIL (QREFELT $ 85))
                              NIL NIL 0))
                (EXIT (LETT |resSys| (CONS |rec| |resSys|))))
               (LETT #1# (PROG1 (CDR #1#) (LETT |i| (+ |i| 1)))) (GO G190) G191
               (EXIT NIL))
          (EXIT (CONS (NREVERSE |resSys|) |resOrd|))))) 

(SDEFUN |JDE;makeSystem;L$;11| ((|sys| (|List| D)) ($ ($)))
        (SPROG
         ((|jm| (|SparseEchelonMatrix| JB D))
          (|der| (|List| (|NonNegativeInteger|))) (#1=#:G853 NIL) (|eq| NIL)
          (#2=#:G852 NIL) (|nsys| (|List| D)) (#3=#:G851 NIL) (#4=#:G850 NIL))
         (SEQ
          (COND ((NULL |sys|) (CONS NIL NIL))
                ('T
                 (SEQ
                  (LETT |nsys|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |eq| NIL) (LETT #3# |sys|) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |eq| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #4#
                                      (CONS (SPADCALL |eq| (QREFELT $ 86))
                                            #4#))))
                              (LETT #3# (CDR #3#)) (GO G190) G191
                              (EXIT (NREVERSE #4#)))))
                  (LETT |der|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |eq| NIL) (LETT #1# |nsys|) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |eq| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ (EXIT (LETT #2# (CONS 1 #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))
                  (LETT |jm| (SPADCALL |nsys| (QREFELT $ 88)))
                  (EXIT (|JDE;makeSystem2| |nsys| |jm| |der| $)))))))) 

(SDEFUN |JDE;join;3$;12| ((|De1| ($)) (|De2| ($)) ($ ($)))
        (SPROG
         ((|ord2| #1=(|List| (|NonNegativeInteger|))) (|ord1| #1#)
          (|sys2| #2=(|List| |SysRec|)) (|sys1| #2#)
          (|resOrd| (|List| (|NonNegativeInteger|)))
          (|resSys| (|List| |SysRec|)) (|rec| (|SysRec|)) (|rec2| (|SysRec|))
          (|rec1| (|SysRec|)) (|o2| #3=(|NonNegativeInteger|)) (|o1| #3#)
          (|cDe2| ($)) (|cDe1| ($)))
         (SEQ (LETT |cDe1| (SPADCALL |De1| (QREFELT $ 37)))
              (LETT |cDe2| (SPADCALL |De2| (QREFELT $ 37)))
              (LETT |sys1| (QCAR |cDe1|)) (LETT |sys2| (QCAR |cDe2|))
              (LETT |ord1| (QCDR |cDe1|)) (LETT |ord2| (QCDR |cDe2|))
              (LETT |resSys| NIL) (LETT |resOrd| NIL)
              (SEQ G190
                   (COND
                    ((NULL (COND ((NULL |ord1|) (NULL (NULL |ord2|))) ('T 'T)))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL |ord1|)
                       (SEQ
                        (LETT |resSys|
                              (SPADCALL (NREVERSE |sys2|) |resSys|
                                        (QREFELT $ 91)))
                        (LETT |resOrd|
                              (SPADCALL (NREVERSE |ord2|) |resOrd|
                                        (QREFELT $ 92)))
                        (EXIT (LETT |ord2| NIL))))
                      ((NULL |ord2|)
                       (SEQ
                        (LETT |resSys|
                              (SPADCALL (NREVERSE |sys1|) |resSys|
                                        (QREFELT $ 91)))
                        (LETT |resOrd|
                              (SPADCALL (NREVERSE |ord1|) |resOrd|
                                        (QREFELT $ 92)))
                        (EXIT (LETT |ord1| NIL))))
                      ('T
                       (SEQ (LETT |o1| (|SPADfirst| |ord1|))
                            (LETT |o2| (|SPADfirst| |ord2|))
                            (EXIT
                             (COND
                              ((> |o1| |o2|)
                               (SEQ
                                (LETT |resSys|
                                      (CONS (|SPADfirst| |sys1|) |resSys|))
                                (LETT |resOrd| (CONS |o1| |resOrd|))
                                (LETT |sys1| (CDR |sys1|))
                                (EXIT (LETT |ord1| (CDR |ord1|)))))
                              ((> |o2| |o1|)
                               (SEQ
                                (LETT |resSys|
                                      (CONS (|SPADfirst| |sys2|) |resSys|))
                                (LETT |resOrd| (CONS |o2| |resOrd|))
                                (LETT |sys2| (CDR |sys2|))
                                (EXIT (LETT |ord2| (CDR |ord2|)))))
                              ('T
                               (SEQ (LETT |rec1| (|SPADfirst| |sys1|))
                                    (LETT |rec2| (|SPADfirst| |sys2|))
                                    (LETT |rec|
                                          (VECTOR
                                           (SPADCALL (QVELT |rec1| 0)
                                                     (QVELT |rec2| 0)
                                                     (QREFELT $ 93))
                                           (SPADCALL (QVELT |rec1| 1)
                                                     (QVELT |rec2| 1)
                                                     (QREFELT $ 94))
                                           (SPADCALL (QVELT |rec1| 2)
                                                     (QVELT |rec2| 2)
                                                     (QREFELT $ 92))
                                           (SPADCALL (QVELT |rec1| 3)
                                                     (QVELT |rec2| 3)
                                                     (QREFELT $ 95))
                                           NIL NIL 0))
                                    (LETT |resSys| (CONS |rec| |resSys|))
                                    (LETT |resOrd| (CONS |o1| |resOrd|))
                                    (LETT |sys1| (CDR |sys1|))
                                    (LETT |sys2| (CDR |sys2|))
                                    (LETT |ord1| (CDR |ord1|))
                                    (EXIT (LETT |ord2| (CDR |ord2|))))))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (CONS (NREVERSE |resSys|) (NREVERSE |resOrd|)))))) 

(SDEFUN |JDE;insert;L2$;13| ((|sys| (|List| D)) (|De| ($)) ($ ($)))
        (SPROG ((|newDe| ($)))
               (SEQ (LETT |newDe| (SPADCALL |sys| (QREFELT $ 89)))
                    (EXIT (SPADCALL |De| |newDe| (QREFELT $ 96)))))) 

(SDEFUN |JDE;dimension;$2Nni;14|
        ((|De| ($)) (|q| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|res| (|NonNegativeInteger|)) (#1=#:G884 NIL)
          (|resSys| (|List| |SysRec|)) (|d| (|NonNegativeInteger|))
          (|simp?| (|Boolean|)) (|qq| (|Integer|)) (#2=#:G890 NIL) (|j| NIL)
          (#3=#:G888 NIL) (|sys| NIL) (#4=#:G889 NIL) (|ord| NIL)
          (|tord| (|List| (|NonNegativeInteger|))) (|tsys| (|List| |SysRec|)))
         (SEQ
          (COND ((NULL (QCDR |De|)) (SPADCALL |q| (QREFELT $ 98)))
                ('T
                 (SEQ (LETT |simp?| 'T)
                      (LETT |tsys| (SPADCALL (QCAR |De|) (QREFELT $ 99)))
                      (LETT |tord| (SPADCALL (QCDR |De|) (QREFELT $ 35)))
                      (LETT |resSys| NIL)
                      (SEQ G190
                           (COND
                            ((NULL (> (|SPADfirst| |tord|) |q|)) (GO G191)))
                           (SEQ
                            (LETT |resSys|
                                  (CONS (|SPADfirst| |tsys|) |resSys|))
                            (LETT |tsys| (CDR |tsys|))
                            (EXIT (LETT |tord| (CDR |tord|))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |qq| |q|) (LETT |res| 0)
                      (SEQ (LETT |ord| NIL) (LETT #4# |tord|) (LETT |sys| NIL)
                           (LETT #3# |tsys|) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |sys| (CAR #3#)) NIL)
                                 (ATOM #4#) (PROGN (LETT |ord| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ
                            (SEQ (LETT |j| (+ |ord| 1)) (LETT #2# |qq|) G190
                                 (COND ((> |j| #2#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |res|
                                         (+ |res|
                                            (SPADCALL |j| (QREFELT $ 100))))))
                                 (LETT |j| (+ |j| 1)) (GO G190) G191
                                 (EXIT NIL))
                            (LETT |qq| (- |ord| 1))
                            (LETT |simp?|
                                  (COND (|simp?| (QVELT |sys| 4)) ('T NIL)))
                            (COND
                             ((QVELT |sys| 5)
                              (LETT |res| (+ |res| (QVELT |sys| 6))))
                             ('T
                              (SEQ
                               (LETT |d|
                                     (SPADCALL (QVELT |sys| 0) (QVELT |sys| 1)
                                               |ord| (QREFELT $ 101)))
                               (LETT |res| (+ |res| |d|)) (QSETVELT |sys| 5 'T)
                               (EXIT (QSETVELT |sys| 6 |d|)))))
                            (EXIT (LETT |resSys| (CONS |sys| |resSys|))))
                           (LETT #3# (PROG1 (CDR #3#) (LETT #4# (CDR #4#))))
                           (GO G190) G191 (EXIT NIL))
                      (COND
                       ((NULL |simp?|)
                        (SPADCALL
                         (SPADCALL
                          "***** Warning: system not simplified in dimension"
                          (QREFELT $ 53))
                         (QREFELT $ 61))))
                      (COND
                       ((>= |qq| 0)
                        (LETT |res|
                              (+ |res|
                                 (SPADCALL
                                  (PROG1 (LETT #1# |qq|)
                                    (|check_subtype2| (>= #1# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #1#))
                                  (QREFELT $ 98))))))
                      (PROGN (RPLACA |De| (NREVERSE |resSys|)) (QCAR |De|))
                      (EXIT |res|))))))) 

(SDEFUN |JDE;simplify;$R;15|
        ((|De| ($)) ($ (|Record| (|:| |SDe| $) (|:| IC (|List| D)))))
        (SPROG
         ((|u?| (|Boolean|)) (#1=#:G956 NIL) (#2=#:G969 NIL)
          (|j| (|NonNegativeInteger|)) (#3=#:G970 NIL) (|lj| (|List| JB))
          (#4=#:G968 NIL) (|eq| NIL) (|i| NIL)
          (|jm0| (|SparseEchelonMatrix| JB D))
          (|tord| (|List| (|NonNegativeInteger|))) (|tsys| (|List| |SysRec|))
          (|resOrd| (|List| (|NonNegativeInteger|)))
          (|resSys| (|List| |SysRec|)) (|rec| (|SysRec|)) (|pos| (|Integer|))
          (|hord| (|List| (|NonNegativeInteger|)))
          (|djm| (|SparseEchelonMatrix| JB D)) (|newPro?| (|List| (|Boolean|)))
          (|newDer| (|List| (|NonNegativeInteger|))) (|newEqs| #5=(|List| D))
          (|pos2| #6=(|Integer|)) (|pos1| #6#) (|ICs| (|List| D))
          (|o| (|NonNegativeInteger|)) (#7=#:G966 NIL) (#8=#:G967 NIL)
          (|pro?| NIL)
          (|ad|
           (|Record| (|:| |Der| (|List| (|NonNegativeInteger|)))
                     (|:| |Pro?| (|List| (|Boolean|)))))
          (|newJM| #9=(|SparseEchelonMatrix| JB D))
          (|tmp|
           (|Record| (|:| |Sys| #5#) (|:| JM #9#)
                     (|:| |Depend|
                          (|Union| "failed"
                                   (|List| (|List| (|NonNegativeInteger|)))))))
          (|AllEqs| (|List| D)) (|sys| (|SysRec|)) (|q| (|NonNegativeInteger|))
          (|cDe| ($)))
         (SEQ (LETT |resSys| NIL) (LETT |resOrd| NIL) (LETT |ICs| NIL)
              (LETT |cDe| (SPADCALL |De| (QREFELT $ 37)))
              (LETT |tsys| (QCAR |cDe|)) (LETT |tord| (QCDR |cDe|))
              (LETT |AllEqs| NIL)
              (COND
               ((> (QREFELT $ 13) 0)
                (LETT |AllEqs| (SPADCALL |cDe| (QREFELT $ 43)))))
              (SEQ G190 (COND ((NULL (NULL (NULL |tord|))) (GO G191)))
                   (SEQ (LETT |q| (|SPADfirst| |tord|))
                        (LETT |sys| (|SPADfirst| |tsys|))
                        (COND
                         ((QVELT |sys| 4)
                          (SEQ (LETT |resSys| (CONS |sys| |resSys|))
                               (EXIT (LETT |resOrd| (CONS |q| |resOrd|)))))
                         ('T
                          (SEQ
                           (COND
                            ((> (QREFELT $ 13) 0)
                             (SEQ G190
                                  (COND
                                   ((NULL
                                     (COND ((NULL |AllEqs|) NIL)
                                           ('T
                                            (NULL
                                             (<
                                              (SPADCALL (|SPADfirst| |AllEqs|)
                                                        (QREFELT $ 103))
                                              |q|)))))
                                    (GO G191)))
                                  (SEQ (EXIT (LETT |AllEqs| (CDR |AllEqs|))))
                                  NIL (GO G190) G191 (EXIT NIL))))
                           (COND
                            ((> (QREFELT $ 13) 0)
                             (SEQ
                              (LETT |tmp|
                                    (SPADCALL (QVELT |sys| 0) (QVELT |sys| 1)
                                              |AllEqs| (QREFELT $ 106)))
                              (EXIT
                               (LETT |tmp|
                                     (SPADCALL (QVELT |tmp| 0) (QVELT |tmp| 1)
                                               (QREFELT $ 107))))))
                            ('T
                             (LETT |tmp|
                                   (SPADCALL (QVELT |sys| 0) (QVELT |sys| 1)
                                             (QREFELT $ 107)))))
                           (LETT |newEqs| (QVELT |tmp| 0))
                           (LETT |newJM| (QVELT |tmp| 1))
                           (LETT |ad|
                                 (|JDE;adapt| (QVELT |sys| 2) (QVELT |sys| 3)
                                  (QVELT |tmp| 2) $))
                           (LETT |newDer| (QCAR |ad|))
                           (LETT |newPro?| (QCDR |ad|)) (LETT |j| 0)
                           (SEQ (LETT |i| 1) (LETT |pro?| NIL)
                                (LETT #8# |newPro?|) (LETT |eq| NIL)
                                (LETT #7# |newEqs|) G190
                                (COND
                                 ((OR (ATOM #7#)
                                      (PROGN (LETT |eq| (CAR #7#)) NIL)
                                      (ATOM #8#)
                                      (PROGN (LETT |pro?| (CAR #8#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (LETT |o|
                                       (SPADCALL
                                        (|SPADfirst|
                                         (QCAR
                                          (SPADCALL |newJM| (- |i| |j|)
                                                    (QREFELT $ 71))))
                                        (QREFELT $ 72)))
                                 (EXIT
                                  (COND
                                   ((> |o| |q|)
                                    (|error| "order raised in simplify"))
                                   ((< |o| |q|)
                                    (SEQ (LETT |ICs| (CONS |eq| |ICs|))
                                         (LETT |j| (+ |j| 1))
                                         (LETT |pos1| (+ (- |i| |j|) 1))
                                         (LETT |pos2|
                                               (+ (- |i| |j|)
                                                  (PROGN |newEqs| 1)))
                                         (LETT |newEqs|
                                               (SPADCALL |newEqs| |pos2|
                                                         (QREFELT $ 108)))
                                         (LETT |newDer|
                                               (SPADCALL |newDer| |pos2|
                                                         (QREFELT $ 109)))
                                         (LETT |newPro?|
                                               (SPADCALL |newPro?| |pos2|
                                                         (QREFELT $ 110)))
                                         (LETT |djm|
                                               (SPADCALL |newJM| |pos1| |pos1|
                                                         (QREFELT $ 111)))
                                         (SPADCALL |djm|
                                                   (CONS
                                                    #'|JDE;simplify;$R;15!0|
                                                    (VECTOR |o| $))
                                                   (QREFELT $ 114))
                                         (SPADCALL |newJM| |pos1|
                                                   (QREFELT $ 115))
                                         (LETT |pos|
                                               (SPADCALL |o| |tord|
                                                         (QREFELT $ 80)))
                                         (EXIT
                                          (COND
                                           ((>= |pos| (PROGN |tord| 1))
                                            (SEQ
                                             (LETT |rec|
                                                   (SPADCALL |tsys| |pos|
                                                             (QREFELT $ 116)))
                                             (SPADCALL (QVELT |rec| 0) |eq|
                                                       (QREFELT $ 117))
                                             (SPADCALL (QVELT |rec| 1)
                                                       (SPADCALL |djm| 1
                                                                 (QREFELT $
                                                                          71))
                                                       (QREFELT $ 118))
                                             (SPADCALL (QVELT |rec| 2) 1
                                                       (QREFELT $ 119))
                                             (SPADCALL (QVELT |rec| 3) |pro?|
                                                       (QREFELT $ 120))
                                             (QSETVELT |rec| 4 NIL)
                                             (QSETVELT |rec| 5 NIL)
                                             (QSETVELT |rec| 6 0)
                                             (EXIT
                                              (SPADCALL |tsys| |pos| |rec|
                                                        (QREFELT $ 121)))))
                                           ('T
                                            (SEQ
                                             (LETT |rec|
                                                   (VECTOR (LIST |eq|) |djm|
                                                           (LIST 1)
                                                           (LIST |pro?|) NIL
                                                           NIL 0))
                                             (LETT |hord| NIL)
                                             (LETT |pos|
                                                   (- (PROGN |tord| 1) 1))
                                             (SEQ G190
                                                  (COND
                                                   ((NULL
                                                     (COND ((NULL |tord|) NIL)
                                                           ('T
                                                            (>
                                                             (|SPADfirst|
                                                              |tord|)
                                                             |o|))))
                                                    (GO G191)))
                                                  (SEQ
                                                   (LETT |hord|
                                                         (CONS
                                                          (|SPADfirst| |tord|)
                                                          |hord|))
                                                   (LETT |tord| (CDR |tord|))
                                                   (EXIT
                                                    (LETT |pos| (+ |pos| 1))))
                                                  NIL (GO G190) G191
                                                  (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL |tord|)
                                                (SEQ
                                                 (LETT |tord|
                                                       (NREVERSE
                                                        (CONS |o| |hord|)))
                                                 (EXIT
                                                  (SPADCALL |tsys| |rec|
                                                            (QREFELT $ 122)))))
                                               ('T
                                                (SEQ
                                                 (LETT |tord|
                                                       (SPADCALL
                                                        (NREVERSE |hord|)
                                                        (CONS |o| |tord|)
                                                        (QREFELT $ 92)))
                                                 (EXIT
                                                  (LETT |tsys|
                                                        (SPADCALL |rec| |tsys|
                                                                  |pos|
                                                                  (QREFELT $
                                                                           123)))))))))))))))))
                                (LETT #7#
                                      (PROG1 (CDR #7#)
                                        (LETT #8#
                                              (PROG1 (CDR #8#)
                                                (LETT |i| (|inc_SI| |i|))))))
                                (GO G190) G191 (EXIT NIL))
                           (LETT |rec|
                                 (VECTOR |newEqs| |newJM| |newDer| |newPro?| 'T
                                         NIL 0))
                           (LETT |resSys| (CONS |rec| |resSys|))
                           (EXIT (LETT |resOrd| (CONS |q| |resOrd|))))))
                        (LETT |tsys| (CDR |tsys|))
                        (EXIT (LETT |tord| (CDR |tord|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND
               ((ZEROP |q|)
                (SEQ (LETT |jm0| (QVELT (|SPADfirst| |resSys|) 1))
                     (EXIT
                      (SEQ (LETT |i| 1) (LETT |eq| NIL)
                           (LETT #4# (QVELT (|SPADfirst| |resSys|) 0)) G190
                           (COND
                            ((OR (ATOM #4#) (PROGN (LETT |eq| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |lj|
                                  (QCAR (SPADCALL |jm0| |i| (QREFELT $ 71))))
                            (EXIT
                             (COND
                              ((NULL |lj|) (|error| "inconsistent system"))
                              ('T
                               (SEQ (LETT |u?| NIL)
                                    (SEQ (LETT #3# NIL) (LETT |j| 1)
                                         (LETT #2# (QREFELT $ 12)) G190
                                         (COND
                                          ((OR (|greater_SI| |j| #2#) #3#)
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT |u?|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (PROG1 (LETT #1# |j|)
                                                     (|check_subtype2|
                                                      (> #1# 0)
                                                      '(|PositiveInteger|)
                                                      '(|NonNegativeInteger|)
                                                      #1#))
                                                   (QREFELT $ 124))
                                                  |lj| (QREFELT $ 125)))))
                                         (LETT |j|
                                               (PROG1 (|inc_SI| |j|)
                                                 (LETT #3# |u?|)))
                                         (GO G190) G191 (EXIT NIL))
                                    (EXIT
                                     (COND
                                      ((NULL |u?|)
                                       (|error|
                                        "independent variables not independent")))))))))
                           (LETT #4#
                                 (PROG1 (CDR #4#) (LETT |i| (|inc_SI| |i|))))
                           (GO G190) G191 (EXIT NIL))))))
              (EXIT
               (CONS (CONS (NREVERSE |resSys|) (NREVERSE |resOrd|))
                     (NREVERSE |ICs|)))))) 

(SDEFUN |JDE;simplify;$R;15!0| ((|#1| NIL) ($$ NIL))
        (PROG ($ |o|)
          (LETT $ (QREFELT $$ 1))
          (LETT |o| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |#1| (QREFELT $ 72)) |o| (QREFELT $ 112)))))) 

(SDEFUN |JDE;project;$Nni$;16|
        ((|De| ($)) (|q| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|resOrd| (|List| (|NonNegativeInteger|)))
          (|resSys| (|List| |SysRec|)) (|check| (|Boolean|)) (|cDe| ($)))
         (SEQ (LETT |cDe| (SPADCALL |De| (QREFELT $ 37)))
              (EXIT
               (COND ((>= |q| (SPADCALL |De| (QREFELT $ 38))) |cDe|)
                     ('T
                      (SEQ (LETT |resSys| (QCAR |cDe|))
                           (LETT |resOrd| (QCDR |cDe|)) (LETT |check| 'T)
                           (SEQ G190
                                (COND
                                 ((NULL
                                   (COND ((NULL |resOrd|) NIL)
                                         ('T (> (|SPADfirst| |resOrd|) |q|))))
                                  (GO G191)))
                                (SEQ
                                 (LETT |check|
                                       (COND
                                        (|check|
                                         (QVELT (|SPADfirst| |resSys|) 4))
                                        ('T NIL)))
                                 (LETT |resSys| (CDR |resSys|))
                                 (EXIT (LETT |resOrd| (CDR |resOrd|))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (COND
                            ((NULL |check|)
                             (SPADCALL
                              (SPADCALL
                               "***** Warning: projection of not simplified system"
                               (QREFELT $ 53))
                              (QREFELT $ 61))))
                           (EXIT (CONS |resSys| |resOrd|))))))))) 

(SDEFUN |JDE;prolong;$R;17|
        ((|De| ($)) ($ (|Record| (|:| |SDe| $) (|:| IC (|List| D)))))
        (SPROG
         ((|tmp| (|Record| (|:| |SDe| $) (|:| IC (|List| D)))) (|res| ($))
          (|pOrd| (|List| (|NonNegativeInteger|))) (|pSys| (|List| |SysRec|))
          (|lastOrd| #1=(|NonNegativeInteger|)) (#2=#:G1034 NIL) (|j| NIL)
          (#3=#:G1033 NIL) (|lastRec| (|SysRec|)) (|pRec| (|SysRec|))
          (#4=#:G1032 NIL) (|i| NIL) (#5=#:G1031 NIL) (#6=#:G1030 NIL)
          (#7=#:G1029 NIL) (|pJM| (|SparseEchelonMatrix| JB D))
          (|pIC| (|List| D)) (|pJV| (|List| (|List| JB)))
          (|pDer| (|List| (|NonNegativeInteger|))) (|pEqs| (|List| D))
          (|FDiff| (|Record| (|:| |DPhi| D) (|:| |JVars| (|List| JB))))
          (#8=#:G996 NIL) (#9=#:G1028 NIL)
          (|jmeq| (|SparseEchelonMatrix| JB D)) (#10=#:G1025 NIL) (|eq| NIL)
          (#11=#:G1026 NIL) (#12=#:G1027 NIL) (|pro?| NIL) (|k| NIL)
          (#13=#:G1023 NIL) (#14=#:G1024 NIL) (|ord| NIL) (#15=#:G1022 NIL)
          (#16=#:G1021 NIL) (#17=#:G1020 NIL) (#18=#:G1019 NIL)
          (#19=#:G982 NIL) (#20=#:G1018 NIL) (#21=#:G1016 NIL)
          (#22=#:G1017 NIL) (|q| #1#) (|rec| (|SysRec|)))
         (SEQ (LETT |pEqs| NIL) (LETT |pDer| NIL) (LETT |pJV| NIL)
              (LETT |pIC| NIL) (LETT |rec| (|SPADfirst| (QCAR |De|)))
              (LETT |q| (|SPADfirst| (QCDR |De|)))
              (SEQ (LETT |k| 1) (LETT |j| NIL) (LETT #22# (QVELT |rec| 2))
                   (LETT |eq| NIL) (LETT #21# (QVELT |rec| 0)) G190
                   (COND
                    ((OR (ATOM #21#) (PROGN (LETT |eq| (CAR #21#)) NIL)
                         (ATOM #22#) (PROGN (LETT |j| (CAR #22#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |jmeq|
                          (SPADCALL (QVELT |rec| 1) |k| |k| (QREFELT $ 111)))
                    (EXIT
                     (SEQ (LETT |i| (QREFELT $ 10)) (LETT #20# |j|) G190
                          (COND ((< |i| #20#) (GO G191)))
                          (SEQ
                           (LETT |FDiff|
                                 (SPADCALL |eq|
                                           (PROG1 (LETT #19# |i|)
                                             (|check_subtype2| (> #19# 0)
                                                               '(|PositiveInteger|)
                                                               '(|NonNegativeInteger|)
                                                               #19#))
                                           |jmeq| (QREFELT $ 130)))
                           (LETT |pEqs| (CONS (QCAR |FDiff|) |pEqs|))
                           (LETT |pDer| (CONS |i| |pDer|))
                           (EXIT (LETT |pJV| (CONS (QCDR |FDiff|) |pJV|))))
                          (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))))
                   (LETT #21#
                         (PROG1 (CDR #21#)
                           (LETT #22#
                                 (PROG1 (CDR #22#)
                                   (LETT |k| (|inc_SI| |k|))))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |pEqs| (NREVERSE |pEqs|)) (LETT |pJV| (NREVERSE |pJV|))
              (LETT |pDer| (NREVERSE |pDer|))
              (LETT |pJM| (SPADCALL |pEqs| |pJV| (QREFELT $ 132)))
              (LETT |pRec|
                    (VECTOR |pEqs| |pJM| |pDer|
                            (PROGN
                             (LETT #18# NIL)
                             (SEQ (LETT |i| NIL) (LETT #17# |pDer|) G190
                                  (COND
                                   ((OR (ATOM #17#)
                                        (PROGN (LETT |i| (CAR #17#)) NIL))
                                    (GO G191)))
                                  (SEQ (EXIT (LETT #18# (CONS NIL #18#))))
                                  (LETT #17# (CDR #17#)) (GO G190) G191
                                  (EXIT (NREVERSE #18#))))
                            NIL NIL 0))
              (LETT |pSys| (LIST |pRec|)) (LETT |pOrd| (LIST (+ |q| 1)))
              (LETT |lastRec| (MOVEVEC (MAKE_VEC 7) |rec|))
              (QSETVELT |lastRec| 3
                        (PROGN
                         (LETT #16# NIL)
                         (SEQ (LETT |j| NIL) (LETT #15# (QVELT |rec| 2)) G190
                              (COND
                               ((OR (ATOM #15#)
                                    (PROGN (LETT |j| (CAR #15#)) NIL))
                                (GO G191)))
                              (SEQ (EXIT (LETT #16# (CONS 'T #16#))))
                              (LETT #15# (CDR #15#)) (GO G190) G191
                              (EXIT (NREVERSE #16#)))))
              (LETT |lastOrd| |q|)
              (SEQ (LETT |ord| NIL) (LETT #14# (CDR (QCDR |De|)))
                   (LETT #13# (CDR (QCAR |De|))) G190
                   (COND
                    ((OR (ATOM #13#) (PROGN (LETT |rec| (CAR #13#)) NIL)
                         (ATOM #14#) (PROGN (LETT |ord| (CAR #14#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |pEqs| NIL) (LETT |pDer| NIL) (LETT |pJV| NIL)
                        (SEQ (LETT |k| 1) (LETT |pro?| NIL)
                             (LETT #12# (QVELT |rec| 3)) (LETT |j| NIL)
                             (LETT #11# (QVELT |rec| 2)) (LETT |eq| NIL)
                             (LETT #10# (QVELT |rec| 0)) G190
                             (COND
                              ((OR (ATOM #10#)
                                   (PROGN (LETT |eq| (CAR #10#)) NIL)
                                   (ATOM #11#)
                                   (PROGN (LETT |j| (CAR #11#)) NIL)
                                   (ATOM #12#)
                                   (PROGN (LETT |pro?| (CAR #12#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((NULL |pro?|)
                                 (SEQ
                                  (LETT |jmeq|
                                        (SPADCALL (QVELT |rec| 1) |k| |k|
                                                  (QREFELT $ 111)))
                                  (EXIT
                                   (SEQ (LETT |i| (QREFELT $ 10))
                                        (LETT #9# |j|) G190
                                        (COND ((< |i| #9#) (GO G191)))
                                        (SEQ
                                         (LETT |FDiff|
                                               (SPADCALL |eq|
                                                         (PROG1 (LETT #8# |i|)
                                                           (|check_subtype2|
                                                            (> #8# 0)
                                                            '(|PositiveInteger|)
                                                            '(|NonNegativeInteger|)
                                                            #8#))
                                                         |jmeq|
                                                         (QREFELT $ 130)))
                                         (LETT |pEqs|
                                               (CONS (QCAR |FDiff|) |pEqs|))
                                         (LETT |pDer| (CONS |i| |pDer|))
                                         (EXIT
                                          (LETT |pJV|
                                                (CONS (QCDR |FDiff|) |pJV|))))
                                        (LETT |i| (+ |i| -1)) (GO G190) G191
                                        (EXIT NIL))))))))
                             (LETT #10#
                                   (PROG1 (CDR #10#)
                                     (LETT #11#
                                           (PROG1 (CDR #11#)
                                             (LETT #12#
                                                   (PROG1 (CDR #12#)
                                                     (LETT |k|
                                                           (|inc_SI|
                                                            |k|))))))))
                             (GO G190) G191 (EXIT NIL))
                        (COND
                         ((NULL |pEqs|)
                          (SEQ (LETT |pSys| (CONS |lastRec| |pSys|))
                               (EXIT (LETT |pOrd| (CONS |lastOrd| |pOrd|)))))
                         ('T
                          (SEQ
                           (LETT |pIC| (SPADCALL |pIC| |pEqs| (QREFELT $ 39)))
                           (LETT |pJM| (SPADCALL |pEqs| |pJV| (QREFELT $ 132)))
                           (EXIT
                            (COND
                             ((< (+ |ord| 1) |lastOrd|)
                              (SEQ
                               (LETT |pRec|
                                     (VECTOR |pEqs| |pJM| |pDer|
                                             (PROGN
                                              (LETT #7# NIL)
                                              (SEQ (LETT |i| NIL)
                                                   (LETT #6# |pDer|) G190
                                                   (COND
                                                    ((OR (ATOM #6#)
                                                         (PROGN
                                                          (LETT |i| (CAR #6#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #7#
                                                           (CONS NIL #7#))))
                                                   (LETT #6# (CDR #6#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #7#))))
                                             NIL NIL 0))
                               (LETT |pSys|
                                     (CONS |pRec| (CONS |lastRec| |pSys|)))
                               (EXIT
                                (LETT |pOrd|
                                      (CONS (+ |ord| 1)
                                            (CONS |lastOrd| |pOrd|))))))
                             ('T
                              (SEQ
                               (LETT |pRec|
                                     (VECTOR
                                      (SPADCALL (QVELT |lastRec| 0) |pEqs|
                                                (QREFELT $ 39))
                                      (SPADCALL (QVELT |lastRec| 1) |pJM|
                                                (QREFELT $ 94))
                                      (SPADCALL (QVELT |lastRec| 2) |pDer|
                                                (QREFELT $ 133))
                                      (SPADCALL (QVELT |lastRec| 3)
                                                (PROGN
                                                 (LETT #5# NIL)
                                                 (SEQ (LETT |i| NIL)
                                                      (LETT #4# |pDer|) G190
                                                      (COND
                                                       ((OR (ATOM #4#)
                                                            (PROGN
                                                             (LETT |i|
                                                                   (CAR #4#))
                                                             NIL))
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (LETT #5#
                                                              (CONS NIL #5#))))
                                                      (LETT #4# (CDR #4#))
                                                      (GO G190) G191
                                                      (EXIT (NREVERSE #5#))))
                                                (QREFELT $ 134))
                                      NIL NIL 0))
                               (LETT |pSys| (CONS |pRec| |pSys|))
                               (EXIT
                                (LETT |pOrd| (CONS |lastOrd| |pOrd|))))))))))
                        (LETT |lastRec| (MOVEVEC (MAKE_VEC 7) |rec|))
                        (QSETVELT |lastRec| 3
                                  (PROGN
                                   (LETT #3# NIL)
                                   (SEQ (LETT |j| NIL)
                                        (LETT #2# (QVELT |rec| 2)) G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN (LETT |j| (CAR #2#)) NIL))
                                          (GO G191)))
                                        (SEQ (EXIT (LETT #3# (CONS 'T #3#))))
                                        (LETT #2# (CDR #2#)) (GO G190) G191
                                        (EXIT (NREVERSE #3#)))))
                        (EXIT (LETT |lastOrd| |ord|)))
                   (LETT #13# (PROG1 (CDR #13#) (LETT #14# (CDR #14#))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |pSys| (CONS |lastRec| |pSys|))
              (LETT |pOrd| (CONS |lastOrd| |pOrd|))
              (LETT |res| (CONS (NREVERSE |pSys|) (NREVERSE |pOrd|)))
              (LETT |tmp| (SPADCALL |res| (QREFELT $ 127)))
              (EXIT
               (CONS (QCAR |tmp|)
                     (SPADCALL |pIC| (QCDR |tmp|) (QREFELT $ 93))))))) 

(SDEFUN |JDE;prolong;$NniR;18|
        ((|De| ($)) (|q| (|NonNegativeInteger|))
         ($ (|Record| (|:| |SDe| $) (|:| IC (|List| D)))))
        (SPROG
         ((|tmp| (|Record| (|:| |SDe| $) (|:| IC (|List| D)))) (|res| ($))
          (|pOrd| (|List| (|NonNegativeInteger|))) (|pSys| (|List| |SysRec|))
          (|lastOrd| #1=(|NonNegativeInteger|)) (|lastRec| (|SysRec|))
          (#2=#:G1094 NIL) (|j| NIL) (#3=#:G1093 NIL) (|pRec| (|SysRec|))
          (#4=#:G1092 NIL) (|i| NIL) (#5=#:G1091 NIL) (#6=#:G1090 NIL)
          (#7=#:G1089 NIL) (|pIC| (|List| D))
          (|pJM| (|SparseEchelonMatrix| JB D))
          (|pDer| (|List| (|NonNegativeInteger|))) (|pJV| (|List| (|List| JB)))
          (|pEqs| (|List| D))
          (|FDiff| (|Record| (|:| |DPhi| D) (|:| |JVars| (|List| JB))))
          (#8=#:G1056 NIL) (#9=#:G1088 NIL)
          (|jmeq| (|SparseEchelonMatrix| JB D)) (#10=#:G1085 NIL) (|eq| NIL)
          (#11=#:G1086 NIL) (#12=#:G1087 NIL) (|pro?| NIL) (|k| NIL)
          (#13=#:G1083 NIL) (#14=#:G1084 NIL) (#15=#:G1082 NIL)
          (#16=#:G1081 NIL) (#17=#:G1042 NIL) (#18=#:G1080 NIL)
          (#19=#:G1078 NIL) (#20=#:G1079 NIL) (|ord| #1#) (|rec| (|SysRec|))
          (|tord| (|List| (|NonNegativeInteger|))) (|tsys| (|List| |SysRec|))
          (|cDe| ($)))
         (SEQ (LETT |cDe| (SPADCALL |De| (QREFELT $ 37)))
              (LETT |tsys| (QCAR |cDe|)) (LETT |tord| (QCDR |cDe|))
              (LETT |pSys| NIL) (LETT |pOrd| NIL) (LETT |pIC| NIL)
              (SEQ G190 (COND ((NULL (> (|SPADfirst| |tord|) |q|)) (GO G191)))
                   (SEQ (LETT |pSys| (CONS (|SPADfirst| |tsys|) |pSys|))
                        (LETT |pOrd| (CONS (|SPADfirst| |tord|) |pOrd|))
                        (LETT |tsys| (CDR |tsys|))
                        (EXIT (LETT |tord| (CDR |tord|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND
               ((NULL (EQL (|SPADfirst| |tord|) |q|))
                (SEQ (LETT |pEqs| NIL) (LETT |pDer| NIL) (LETT |pJV| NIL)
                     (LETT |rec| (|SPADfirst| |tsys|))
                     (LETT |ord| (|SPADfirst| |tord|))
                     (SEQ (LETT |k| 1) (LETT |j| NIL)
                          (LETT #20# (QVELT |rec| 2)) (LETT |eq| NIL)
                          (LETT #19# (QVELT |rec| 0)) G190
                          (COND
                           ((OR (ATOM #19#) (PROGN (LETT |eq| (CAR #19#)) NIL)
                                (ATOM #20#) (PROGN (LETT |j| (CAR #20#)) NIL))
                            (GO G191)))
                          (SEQ
                           (LETT |jmeq|
                                 (SPADCALL (QVELT |rec| 1) |k| |k|
                                           (QREFELT $ 111)))
                           (EXIT
                            (SEQ (LETT |i| (QREFELT $ 10)) (LETT #18# |j|) G190
                                 (COND ((< |i| #18#) (GO G191)))
                                 (SEQ
                                  (LETT |FDiff|
                                        (SPADCALL |eq|
                                                  (PROG1 (LETT #17# |i|)
                                                    (|check_subtype2|
                                                     (> #17# 0)
                                                     '(|PositiveInteger|)
                                                     '(|NonNegativeInteger|)
                                                     #17#))
                                                  |jmeq| (QREFELT $ 130)))
                                  (LETT |pEqs| (CONS (QCAR |FDiff|) |pEqs|))
                                  (LETT |pDer| (CONS |i| |pDer|))
                                  (EXIT
                                   (LETT |pJV| (CONS (QCDR |FDiff|) |pJV|))))
                                 (LETT |i| (+ |i| -1)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT #19#
                                (PROG1 (CDR #19#)
                                  (LETT #20#
                                        (PROG1 (CDR #20#)
                                          (LETT |k| (|inc_SI| |k|))))))
                          (GO G190) G191 (EXIT NIL))
                     (LETT |pEqs| (NREVERSE |pEqs|))
                     (LETT |pJV| (NREVERSE |pJV|))
                     (LETT |pDer| (NREVERSE |pDer|))
                     (LETT |pJM| (SPADCALL |pEqs| |pJV| (QREFELT $ 132)))
                     (LETT |pIC| |pEqs|)
                     (LETT |pRec|
                           (VECTOR |pEqs| |pJM| |pDer|
                                   (PROGN
                                    (LETT #16# NIL)
                                    (SEQ (LETT |i| NIL) (LETT #15# |pDer|) G190
                                         (COND
                                          ((OR (ATOM #15#)
                                               (PROGN
                                                (LETT |i| (CAR #15#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT (LETT #16# (CONS NIL #16#))))
                                         (LETT #15# (CDR #15#)) (GO G190) G191
                                         (EXIT (NREVERSE #16#))))
                                   NIL NIL 0))
                     (LETT |pSys| (CONS |pRec| |pSys|))
                     (EXIT (LETT |pOrd| (CONS (+ |ord| 1) |pOrd|))))))
              (LETT |lastRec| (|SPADfirst| |tsys|))
              (LETT |lastOrd| (|SPADfirst| |tord|))
              (SEQ (LETT #14# (CDR |tord|)) (LETT #13# (CDR |tsys|)) G190
                   (COND
                    ((OR (ATOM #13#) (PROGN (LETT |rec| (CAR #13#)) NIL)
                         (ATOM #14#) (PROGN (LETT |ord| (CAR #14#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |pEqs| NIL) (LETT |pDer| NIL) (LETT |pJV| NIL)
                        (SEQ (LETT |k| 1) (LETT |pro?| NIL)
                             (LETT #12# (QVELT |rec| 3)) (LETT |j| NIL)
                             (LETT #11# (QVELT |rec| 2)) (LETT |eq| NIL)
                             (LETT #10# (QVELT |rec| 0)) G190
                             (COND
                              ((OR (ATOM #10#)
                                   (PROGN (LETT |eq| (CAR #10#)) NIL)
                                   (ATOM #11#)
                                   (PROGN (LETT |j| (CAR #11#)) NIL)
                                   (ATOM #12#)
                                   (PROGN (LETT |pro?| (CAR #12#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((NULL |pro?|)
                                 (SEQ
                                  (LETT |jmeq|
                                        (SPADCALL (QVELT |rec| 1) |k| |k|
                                                  (QREFELT $ 111)))
                                  (EXIT
                                   (SEQ (LETT |i| (QREFELT $ 10))
                                        (LETT #9# |j|) G190
                                        (COND ((< |i| #9#) (GO G191)))
                                        (SEQ
                                         (LETT |FDiff|
                                               (SPADCALL |eq|
                                                         (PROG1 (LETT #8# |i|)
                                                           (|check_subtype2|
                                                            (> #8# 0)
                                                            '(|PositiveInteger|)
                                                            '(|NonNegativeInteger|)
                                                            #8#))
                                                         |jmeq|
                                                         (QREFELT $ 130)))
                                         (LETT |pEqs|
                                               (CONS (QCAR |FDiff|) |pEqs|))
                                         (LETT |pDer| (CONS |i| |pDer|))
                                         (EXIT
                                          (LETT |pJV|
                                                (CONS (QCDR |FDiff|) |pJV|))))
                                        (LETT |i| (+ |i| -1)) (GO G190) G191
                                        (EXIT NIL))))))))
                             (LETT #10#
                                   (PROG1 (CDR #10#)
                                     (LETT #11#
                                           (PROG1 (CDR #11#)
                                             (LETT #12#
                                                   (PROG1 (CDR #12#)
                                                     (LETT |k|
                                                           (|inc_SI|
                                                            |k|))))))))
                             (GO G190) G191 (EXIT NIL))
                        (COND
                         ((NULL |pEqs|)
                          (SEQ (LETT |pSys| (CONS |lastRec| |pSys|))
                               (EXIT (LETT |pOrd| (CONS |lastOrd| |pOrd|)))))
                         ('T
                          (SEQ (LETT |pEqs| (NREVERSE |pEqs|))
                               (LETT |pJV| (NREVERSE |pJV|))
                               (LETT |pDer| (NREVERSE |pDer|))
                               (LETT |pJM|
                                     (SPADCALL |pEqs| |pJV| (QREFELT $ 132)))
                               (LETT |pIC|
                                     (SPADCALL |pIC| |pEqs| (QREFELT $ 39)))
                               (COND
                                ((< (+ |ord| 1) |lastOrd|)
                                 (SEQ
                                  (LETT |pRec|
                                        (VECTOR |pEqs| |pJM| |pDer|
                                                (PROGN
                                                 (LETT #7# NIL)
                                                 (SEQ (LETT |i| NIL)
                                                      (LETT #6# |pDer|) G190
                                                      (COND
                                                       ((OR (ATOM #6#)
                                                            (PROGN
                                                             (LETT |i|
                                                                   (CAR #6#))
                                                             NIL))
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (LETT #7#
                                                              (CONS NIL #7#))))
                                                      (LETT #6# (CDR #6#))
                                                      (GO G190) G191
                                                      (EXIT (NREVERSE #7#))))
                                                NIL NIL 0))
                                  (LETT |pSys|
                                        (CONS |pRec| (CONS |lastRec| |pSys|)))
                                  (EXIT
                                   (LETT |pOrd|
                                         (CONS (+ |ord| 1)
                                               (CONS |lastOrd| |pOrd|))))))
                                ('T
                                 (SEQ
                                  (LETT |pRec|
                                        (VECTOR
                                         (SPADCALL (QVELT |lastRec| 0) |pEqs|
                                                   (QREFELT $ 93))
                                         (SPADCALL (QVELT |lastRec| 1) |pJM|
                                                   (QREFELT $ 94))
                                         (SPADCALL (QVELT |lastRec| 2) |pDer|
                                                   (QREFELT $ 92))
                                         (SPADCALL (QVELT |lastRec| 3)
                                                   (PROGN
                                                    (LETT #5# NIL)
                                                    (SEQ (LETT |i| NIL)
                                                         (LETT #4# |pDer|) G190
                                                         (COND
                                                          ((OR (ATOM #4#)
                                                               (PROGN
                                                                (LETT |i|
                                                                      (CAR
                                                                       #4#))
                                                                NIL))
                                                           (GO G191)))
                                                         (SEQ
                                                          (EXIT
                                                           (LETT #5#
                                                                 (CONS NIL
                                                                       #5#))))
                                                         (LETT #4# (CDR #4#))
                                                         (GO G190) G191
                                                         (EXIT
                                                          (NREVERSE #5#))))
                                                   (QREFELT $ 95))
                                         NIL NIL 0))
                                  (LETT |pSys| (CONS |pRec| |pSys|))
                                  (EXIT
                                   (LETT |pOrd| (CONS |lastOrd| |pOrd|))))))
                               (EXIT
                                (QSETVELT |rec| 3
                                          (PROGN
                                           (LETT #3# NIL)
                                           (SEQ (LETT |j| NIL)
                                                (LETT #2# (QVELT |rec| 2)) G190
                                                (COND
                                                 ((OR (ATOM #2#)
                                                      (PROGN
                                                       (LETT |j| (CAR #2#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #3# (CONS 'T #3#))))
                                                (LETT #2# (CDR #2#)) (GO G190)
                                                G191
                                                (EXIT (NREVERSE #3#)))))))))
                        (LETT |lastRec| |rec|) (EXIT (LETT |lastOrd| |ord|)))
                   (LETT #13# (PROG1 (CDR #13#) (LETT #14# (CDR #14#))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |pSys| (CONS |lastRec| |pSys|))
              (LETT |pOrd| (CONS |lastOrd| |pOrd|))
              (LETT |res| (CONS (NREVERSE |pSys|) (NREVERSE |pOrd|)))
              (LETT |tmp| (SPADCALL |res| (QREFELT $ 127)))
              (EXIT
               (CONS (QCAR |tmp|)
                     (SPADCALL |pIC| (QCDR |tmp|) (QREFELT $ 93))))))) 

(SDEFUN |JDE;extractSymbol;$BSem;19|
        ((|De| ($)) (|solved?| (|Boolean|)) ($ (|SparseEchelonMatrix| JB D)))
        (SPROG ((|res| (|SparseEchelonMatrix| JB D)))
               (SEQ
                (LETT |res|
                      (SPADCALL (QVELT (|SPADfirst| (QCAR |De|)) 1)
                                (QREFELT $ 137)))
                (COND
                 (|solved?|
                  (LETT |res| (QVELT (SPADCALL |res| (QREFELT $ 139)) 0))))
                (EXIT |res|)))) 

(SDEFUN |JDE;analyseSymbol;SemR;20|
        ((|Symb| (|SparseEchelonMatrix| JB D))
         ($
          (|Record| (|:| |Rank| (|NonNegativeInteger|))
                    (|:| |NumMultVar| (|NonNegativeInteger|))
                    (|:| |Betas| (|List| (|NonNegativeInteger|))))))
        (SPROG
         ((|LBeta| (|List| (|NonNegativeInteger|))) (#1=#:G1114 NIL) (|k| NIL)
          (|MSum| #2=(|NonNegativeInteger|))
          (|LastClass| (|NonNegativeInteger|)) (|BetaI| #2#) (#3=#:G1113 NIL)
          (|CurClass| (|NonNegativeInteger|)) (#4=#:G1112 NIL) (|jv| NIL)
          (|pivs|
           (|Record| (|:| |Indices| (|List| JB)) (|:| |Entries| (|List| D))))
          (|ech| #5=(|SparseEchelonMatrix| JB D))
          (|tmp|
           (|Record| (|:| |Ech| #5#) (|:| |Lt| (|Matrix| D))
                     (|:| |Pivots| (|List| D))
                     (|:| |Rank| (|NonNegativeInteger|)))))
         (SEQ (LETT |tmp| (SPADCALL |Symb| (QREFELT $ 139)))
              (LETT |ech| (QVELT |tmp| 0))
              (LETT |pivs| (SPADCALL |ech| (QREFELT $ 141))) (LETT |MSum| 0)
              (LETT |BetaI| 0) (LETT |LastClass| (QREFELT $ 10))
              (LETT |LBeta| NIL)
              (SEQ (LETT |jv| NIL) (LETT #4# (QCAR |pivs|)) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |jv| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |CurClass| (SPADCALL |jv| (QREFELT $ 142)))
                        (EXIT
                         (COND
                          ((EQL |CurClass| |LastClass|)
                           (LETT |BetaI| (+ |BetaI| 1)))
                          ('T
                           (SEQ (LETT |LBeta| (CONS |BetaI| |LBeta|))
                                (LETT |MSum|
                                      (+ |MSum| (* |BetaI| |LastClass|)))
                                (SEQ (LETT |k| 2)
                                     (LETT #3# (- |LastClass| |CurClass|)) G190
                                     (COND ((|greater_SI| |k| #3#) (GO G191)))
                                     (SEQ
                                      (EXIT (LETT |LBeta| (CONS 0 |LBeta|))))
                                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                     (EXIT NIL))
                                (LETT |BetaI| 1)
                                (EXIT (LETT |LastClass| |CurClass|)))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (LETT |LBeta| (CONS |BetaI| |LBeta|))
              (LETT |MSum| (+ |MSum| (* |BetaI| |LastClass|)))
              (SEQ (LETT |k| 2) (LETT #1# |LastClass|) G190
                   (COND ((|greater_SI| |k| #1#) (GO G191)))
                   (SEQ (EXIT (LETT |LBeta| (CONS 0 |LBeta|))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR (QVELT |tmp| 3) |MSum| |LBeta|))))) 

(SDEFUN |JDE;prolongSymbol;2Sem;21|
        ((|Symb| (|SparseEchelonMatrix| JB D))
         ($ (|SparseEchelonMatrix| JB D)))
        (SPROG
         ((|ninds| (|List| JB)) (#1=#:G1126 NIL) (#2=#:G1142 NIL)
          (#3=#:G1154 NIL) (|jv| NIL) (#4=#:G1153 NIL) (|i| NIL)
          (|r|
           (|Record| (|:| |Indices| (|List| JB)) (|:| |Entries| (|List| D))))
          (#5=#:G1152 NIL) (|j| NIL) (|res| (|SparseEchelonMatrix| JB D))
          (|newInds| (|List| JB)) (#6=#:G1124 NIL) (#7=#:G1151 NIL)
          (#8=#:G1150 NIL) (|oldInds| (|List| JB)))
         (SEQ (LETT |oldInds| (SPADCALL |Symb| (QREFELT $ 64)))
              (LETT |newInds| NIL)
              (SEQ (LETT |jv| NIL) (LETT #8# (REVERSE |oldInds|)) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |jv| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |i| 1) (LETT #7# (QREFELT $ 10)) G190
                          (COND ((|greater_SI| |i| #7#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT |newInds|
                                  (CONS
                                   (PROG2
                                       (LETT #1#
                                             (SPADCALL |jv|
                                                       (PROG1 (LETT #6# |i|)
                                                         (|check_subtype2|
                                                          (> #6# 0)
                                                          '(|PositiveInteger|)
                                                          '(|NonNegativeInteger|)
                                                          #6#))
                                                       (QREFELT $ 146)))
                                       (QCDR #1#)
                                     (|check_union2| (QEQCAR #1# 0)
                                                     (QREFELT $ 6)
                                                     (|Union| (QREFELT $ 6)
                                                              #9="0")
                                                     #1#))
                                   |newInds|))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
              (LETT |newInds|
                    (SPADCALL (CONS #'|JDE;prolongSymbol;2Sem;21!0| $)
                              (SPADCALL |newInds| (QREFELT $ 148))
                              (QREFELT $ 150)))
              (LETT |res|
                    (SPADCALL |newInds|
                              (* (QREFELT $ 10)
                                 (SPADCALL |Symb| (QREFELT $ 69)))
                              (QREFELT $ 77)))
              (SEQ (LETT |j| 1) (LETT #5# (SPADCALL |Symb| (QREFELT $ 69)))
                   G190 (COND ((|greater_SI| |j| #5#) (GO G191)))
                   (SEQ (LETT |r| (SPADCALL |Symb| |j| (QREFELT $ 71)))
                        (EXIT
                         (SEQ (LETT |i| (QREFELT $ 10)) G190
                              (COND ((< |i| 1) (GO G191)))
                              (SEQ
                               (LETT |ninds|
                                     (PROGN
                                      (LETT #4# NIL)
                                      (SEQ (LETT |jv| NIL)
                                           (LETT #3# (QCAR |r|)) G190
                                           (COND
                                            ((OR (ATOM #3#)
                                                 (PROGN
                                                  (LETT |jv| (CAR #3#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #4#
                                                   (CONS
                                                    (PROG2
                                                        (LETT #1#
                                                              (SPADCALL |jv|
                                                                        (PROG1
                                                                            (LETT
                                                                             #2#
                                                                             |i|)
                                                                          (|check_subtype2|
                                                                           (>
                                                                            #2#
                                                                            0)
                                                                           '(|PositiveInteger|)
                                                                           '(|NonNegativeInteger|)
                                                                           #2#))
                                                                        (QREFELT
                                                                         $
                                                                         146)))
                                                        (QCDR #1#)
                                                      (|check_union2|
                                                       (QEQCAR #1# 0)
                                                       (QREFELT $ 6)
                                                       (|Union| (QREFELT $ 6)
                                                                #9#)
                                                       #1#))
                                                    #4#))))
                                           (LETT #3# (CDR #3#)) (GO G190) G191
                                           (EXIT (NREVERSE #4#)))))
                               (EXIT
                                (SPADCALL |res|
                                          (+ (- (* (QREFELT $ 10) |j|) |i|) 1)
                                          |ninds| (QCDR |r|) (QREFELT $ 151))))
                              (LETT |i| (+ |i| -1)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |JDE;prolongSymbol;2Sem;21!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL |y| |x| (QREFELT $ 147))) 

(SDEFUN |JDE;prolongMV;2R;22|
        ((|mv|
          (|Record| (|:| |Rank| (|NonNegativeInteger|))
                    (|:| |NumMultVar| (|NonNegativeInteger|))
                    (|:| |Betas| (|List| (|NonNegativeInteger|)))))
         ($
          (|Record| (|:| |Rank| (|NonNegativeInteger|))
                    (|:| |NumMultVar| (|NonNegativeInteger|))
                    (|:| |Betas| (|List| (|NonNegativeInteger|))))))
        (SPROG
         ((|newBeta| (|List| (|NonNegativeInteger|)))
          (|msum| #1=(|NonNegativeInteger|)) (|rank| #1#) (|sum| #1#)
          (#2=#:G1161 NIL) (|beta| NIL) (|k| NIL)
          (|oldBeta| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |oldBeta| (REVERSE (QVELT |mv| 2))) (LETT |newBeta| NIL)
              (LETT |sum| 0) (LETT |rank| 0) (LETT |msum| 0)
              (SEQ (LETT |k| (QREFELT $ 10)) (LETT |beta| NIL)
                   (LETT #2# |oldBeta|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |beta| (CAR #2#)) NIL)
                         (< |k| 1))
                     (GO G191)))
                   (SEQ (LETT |sum| (+ |sum| |beta|))
                        (LETT |rank| (+ |rank| |sum|))
                        (LETT |msum| (+ |msum| (* |k| |sum|)))
                        (EXIT (LETT |newBeta| (CONS |sum| |newBeta|))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT |k| (+ |k| -1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT (VECTOR |rank| |msum| (NREVERSE |newBeta|)))))) 

(SDEFUN |JDE;power|
        ((|lc| (|List| D)) (|mu| (|List| (|NonNegativeInteger|)))
         (|mask| (|List| (|PositiveInteger|))) ($ (D)))
        (SPROG ((|k| (|PositiveInteger|)) (|res| (D)))
               (SEQ (LETT |res| (|spadConstant| $ 76)) (LETT |k| 1)
                    (SEQ G190 (COND ((NULL (NULL (NULL |mask|))) (GO G191)))
                         (SEQ
                          (SEQ G190
                               (COND
                                ((NULL (< |k| (|SPADfirst| |mask|)))
                                 (GO G191)))
                               (SEQ (LETT |mu| (CDR |mu|))
                                    (EXIT (LETT |k| (+ |k| 1))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (LETT |res|
                                (SPADCALL |res|
                                          (SPADCALL (|SPADfirst| |lc|)
                                                    (|SPADfirst| |mu|)
                                                    (QREFELT $ 154))
                                          (QREFELT $ 155)))
                          (LETT |lc| (CDR |lc|)) (LETT |mask| (CDR |mask|))
                          (LETT |mu| (CDR |mu|)) (EXIT (LETT |k| (+ |k| 1))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |JDE;extPower|
        ((|llc| (|Matrix| D)) (|mu| (|List| (|NonNegativeInteger|)))
         (|nu| (|List| (|NonNegativeInteger|))) ($ (D)))
        (SPROG
         ((|res| (D)) (|prod| (D)) (#1=#:G1180 NIL) (|si| NIL) (#2=#:G1181 NIL)
          (|mi| NIL) (#3=#:G1179 NIL) (|s| NIL)
          (|rmu| (|List| (|PositiveInteger|)))
          (|snu| (|List| (|List| (|PositiveInteger|)))))
         (SEQ (LETT |snu| (SPADCALL |nu| (QREFELT $ 157)))
              (LETT |rmu| (SPADCALL |mu| (QREFELT $ 159)))
              (LETT |res| (|spadConstant| $ 48))
              (SEQ (LETT |s| NIL) (LETT #3# |snu|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |s| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |prod| (|spadConstant| $ 76))
                        (SEQ (LETT |mi| NIL) (LETT #2# |rmu|) (LETT |si| NIL)
                             (LETT #1# |s|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |si| (CAR #1#)) NIL)
                                   (ATOM #2#)
                                   (PROGN (LETT |mi| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |prod|
                                     (SPADCALL |prod|
                                               (QAREF2O |llc|
                                                        (+
                                                         (- (QREFELT $ 10)
                                                            |si|)
                                                         1)
                                                        |mi| 1 1)
                                               (QREFELT $ 155)))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (LETT |res| (SPADCALL |res| |prod| (QREFELT $ 160)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |JDE;tableau;SemJdSem;25|
        ((|Symb| (|SparseEchelonMatrix| JB D)) (|chi| (|JetDifferential| JB D))
         ($ (|SparseEchelonMatrix| JB D)))
        (SPROG
         ((|le| (|List| D)) (|li| (|List| JB)) (#1=#:G1195 NIL)
          (#2=#:G1210 NIL) (|i| NIL) (#3=#:G1211 NIL) (|s| NIL)
          (|mu| (|List| (|NonNegativeInteger|))) (|a| #4=(|PositiveInteger|))
          (#5=#:G1208 NIL) (|jv| NIL) (#6=#:G1209 NIL) (|ent| NIL)
          (|sum| (|Vector| D))
          (|r|
           (|Record| (|:| |Indices| (|List| JB)) (|:| |Entries| (|List| D))))
          (#7=#:G1207 NIL) (|k| NIL) (|res| (|SparseEchelonMatrix| JB D))
          (#8=#:G1186 NIL) (#9=#:G1206 NIL) (|cinds| (|List| #4#))
          (#10=#:G1205 NIL) (|d| NIL) (#11=#:G1204 NIL) (|coeffs| (|List| D))
          (|diffs| (|List| JB)))
         (SEQ (LETT |diffs| (SPADCALL |chi| (QREFELT $ 162)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |diffs| (QREFELT $ 163))
                           (SPADCALL (QREFELT $ 10) (QREFELT $ 164))
                           (QREFELT $ 165))
                 (|error| "illegal differential in tableau"))
                ('T
                 (SEQ (LETT |coeffs| (SPADCALL |chi| (QREFELT $ 166)))
                      (LETT |cinds|
                            (PROGN
                             (LETT #11# NIL)
                             (SEQ (LETT |d| NIL) (LETT #10# |diffs|) G190
                                  (COND
                                   ((OR (ATOM #10#)
                                        (PROGN (LETT |d| (CAR #10#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #11#
                                          (CONS (SPADCALL |d| (QREFELT $ 167))
                                                #11#))))
                                  (LETT #10# (CDR #10#)) (GO G190) G191
                                  (EXIT (NREVERSE #11#)))))
                      (LETT |res|
                            (SPADCALL
                             (PROGN
                              (LETT #9# NIL)
                              (SEQ (LETT |i| (QREFELT $ 12)) G190
                                   (COND ((< |i| 1) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #9#
                                           (CONS
                                            (SPADCALL
                                             (PROG1 (LETT #8# |i|)
                                               (|check_subtype2| (> #8# 0)
                                                                 '(|PositiveInteger|)
                                                                 '(|NonNegativeInteger|)
                                                                 #8#))
                                             (QREFELT $ 124))
                                            #9#))))
                                   (LETT |i| (+ |i| -1)) (GO G190) G191
                                   (EXIT (NREVERSE #9#))))
                             (SPADCALL |Symb| (QREFELT $ 69)) (QREFELT $ 77)))
                      (SEQ (LETT |k| 1)
                           (LETT #7# (SPADCALL |Symb| (QREFELT $ 69))) G190
                           (COND ((|greater_SI| |k| #7#) (GO G191)))
                           (SEQ (LETT |r| (SPADCALL |Symb| |k| (QREFELT $ 71)))
                                (LETT |sum|
                                      (MAKEARR1 (QREFELT $ 12)
                                                (|spadConstant| $ 48)))
                                (SEQ (LETT |ent| NIL) (LETT #6# (QCDR |r|))
                                     (LETT |jv| NIL) (LETT #5# (QCAR |r|)) G190
                                     (COND
                                      ((OR (ATOM #5#)
                                           (PROGN (LETT |jv| (CAR #5#)) NIL)
                                           (ATOM #6#)
                                           (PROGN (LETT |ent| (CAR #6#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |a|
                                            (SPADCALL |jv| (QREFELT $ 167)))
                                      (LETT |mu|
                                            (SPADCALL |jv| (QREFELT $ 168)))
                                      (EXIT
                                       (QSETAREF1O |sum| |a|
                                                   (SPADCALL
                                                    (QAREF1O |sum| |a| 1)
                                                    (SPADCALL |ent|
                                                              (|JDE;power|
                                                               |coeffs| |mu|
                                                               |cinds| $)
                                                              (QREFELT $ 155))
                                                    (QREFELT $ 160))
                                                   1)))
                                     (LETT #5#
                                           (PROG1 (CDR #5#)
                                             (LETT #6# (CDR #6#))))
                                     (GO G190) G191 (EXIT NIL))
                                (LETT |li| NIL) (LETT |le| NIL)
                                (SEQ (LETT |s| NIL)
                                     (LETT #3#
                                           (SPADCALL |sum| (QREFELT $ 170)))
                                     (LETT |i| 1) (LETT #2# (QREFELT $ 12))
                                     G190
                                     (COND
                                      ((OR (|greater_SI| |i| #2#) (ATOM #3#)
                                           (PROGN (LETT |s| (CAR #3#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((NULL (SPADCALL |s| (QREFELT $ 171)))
                                         (SEQ
                                          (LETT |li|
                                                (CONS
                                                 (SPADCALL
                                                  (PROG1 (LETT #1# |i|)
                                                    (|check_subtype2| (> #1# 0)
                                                                      '(|PositiveInteger|)
                                                                      '(|NonNegativeInteger|)
                                                                      #1#))
                                                  (QREFELT $ 124))
                                                 |li|))
                                          (EXIT
                                           (LETT |le| (CONS |s| |le|))))))))
                                     (LETT |i|
                                           (PROG1 (|inc_SI| |i|)
                                             (LETT #3# (CDR #3#))))
                                     (GO G190) G191 (EXIT NIL))
                                (EXIT
                                 (SPADCALL |res| |k| |li| |le|
                                           (QREFELT $ 151))))
                           (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                      (EXIT |res|)))))))) 

(SDEFUN |JDE;tableau;SemLSem;26|
        ((|Symb| (|SparseEchelonMatrix| JB D))
         (|lchi| (|List| (|JetDifferential| JB D)))
         ($ (|SparseEchelonMatrix| JB D)))
        (SPROG
         ((|rres|
           #1=(|Record| (|:| |Indices| (|List| JB))
                        (|:| |Entries| (|List| D))))
          (|s| (D)) (|mu| #2=(|List| (|NonNegativeInteger|))) (#3=#:G1238 NIL)
          (|jv| NIL) (#4=#:G1239 NIL) (|ent| NIL) (|r| #1#) (#5=#:G1237 NIL)
          (|k| NIL) (|nu| #2#) (|a| (|PositiveInteger|)) (#6=#:G1236 NIL)
          (|vv| NIL) (|res| (|SparseEchelonMatrix| JB D)) (#7=#:G1217 NIL)
          (#8=#:G1235 NIL) (|j| NIL) (|i| NIL) (#9=#:G1234 NIL) (|chi| NIL)
          (|mco| (|Matrix| D)) (|inds| (|List| JB)) (#10=#:G1213 NIL)
          (|q| (|NonNegativeInteger|)))
         (SEQ
          (LETT |q|
                (SPADCALL (|SPADfirst| (SPADCALL |Symb| (QREFELT $ 64)))
                          (QREFELT $ 72)))
          (LETT |inds|
                (SPADCALL |q|
                          (PROG1
                              (LETT #10#
                                    (+ (- (QREFELT $ 10) (LENGTH |lchi|)) 1))
                            (|check_subtype2| (> #10# 0) '(|PositiveInteger|)
                                              '(|Integer|) #10#))
                          (QREFELT $ 173)))
          (LETT |mco|
                (MAKE_MATRIX1 (LENGTH |lchi|) (QREFELT $ 10)
                              (|spadConstant| $ 48)))
          (SEQ (LETT |chi| NIL) (LETT #9# |lchi|) (LETT |i| 1) G190
               (COND
                ((OR (ATOM #9#) (PROGN (LETT |chi| (CAR #9#)) NIL)) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #8# (QREFELT $ 10)) G190
                      (COND ((|greater_SI| |j| #8#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF2O |mco| |i| |j|
                                    (SPADCALL |chi|
                                              (SPADCALL
                                               (PROG1 (LETT #7# |j|)
                                                 (|check_subtype2| (> #7# 0)
                                                                   '(|PositiveInteger|)
                                                                   '(|NonNegativeInteger|)
                                                                   #7#))
                                               (QREFELT $ 164))
                                              (QREFELT $ 174))
                                    1 1)))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #9# (CDR #9#)))) (GO G190)
               G191 (EXIT NIL))
          (LETT |res|
                (SPADCALL |inds| (SPADCALL |Symb| (QREFELT $ 69))
                          (QREFELT $ 77)))
          (SEQ (LETT |vv| NIL) (LETT #6# (REVERSE |inds|)) G190
               (COND
                ((OR (ATOM #6#) (PROGN (LETT |vv| (CAR #6#)) NIL)) (GO G191)))
               (SEQ (LETT |a| (SPADCALL |vv| (QREFELT $ 167)))
                    (LETT |nu| (SPADCALL |vv| (QREFELT $ 168)))
                    (EXIT
                     (SEQ (LETT |k| 1)
                          (LETT #5# (SPADCALL |Symb| (QREFELT $ 69))) G190
                          (COND ((|greater_SI| |k| #5#) (GO G191)))
                          (SEQ (LETT |r| (SPADCALL |Symb| |k| (QREFELT $ 71)))
                               (LETT |s| (|spadConstant| $ 48))
                               (SEQ (LETT |ent| NIL) (LETT #4# (QCDR |r|))
                                    (LETT |jv| NIL) (LETT #3# (QCAR |r|)) G190
                                    (COND
                                     ((OR (ATOM #3#)
                                          (PROGN (LETT |jv| (CAR #3#)) NIL)
                                          (ATOM #4#)
                                          (PROGN (LETT |ent| (CAR #4#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((EQL (SPADCALL |jv| (QREFELT $ 167))
                                             |a|)
                                        (SEQ
                                         (LETT |mu|
                                               (SPADCALL |jv| (QREFELT $ 168)))
                                         (EXIT
                                          (LETT |s|
                                                (SPADCALL |s|
                                                          (SPADCALL |ent|
                                                                    (|JDE;extPower|
                                                                     |mco| |mu|
                                                                     |nu| $)
                                                                    (QREFELT $
                                                                             155))
                                                          (QREFELT $
                                                                   160)))))))))
                                    (LETT #3#
                                          (PROG1 (CDR #3#)
                                            (LETT #4# (CDR #4#))))
                                    (GO G190) G191 (EXIT NIL))
                               (EXIT
                                (COND
                                 ((NULL (SPADCALL |s| (QREFELT $ 171)))
                                  (SEQ
                                   (LETT |rres|
                                         (SPADCALL |res| |k| (QREFELT $ 71)))
                                   (PROGN
                                    (RPLACA |rres| (CONS |vv| (QCAR |rres|)))
                                    (QCAR |rres|))
                                   (PROGN
                                    (RPLACD |rres| (CONS |s| (QCDR |rres|)))
                                    (QCDR |rres|))
                                   (EXIT
                                    (SPADCALL |res| |k| |rres|
                                              (QREFELT $ 81))))))))
                          (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                          (EXIT NIL))))
               (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
          (EXIT |res|)))) 

(DECLAIM (NOTINLINE |JetDifferentialEquation;|)) 

(DEFUN |JetDifferentialEquation| (&REST #1=#:G1240)
  (SPROG NIL
         (PROG (#2=#:G1241)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|JetDifferentialEquation|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |JetDifferentialEquation;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|JetDifferentialEquation|)))))))))) 

(DEFUN |JetDifferentialEquation;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|JetDifferentialEquation| DV$1 DV$2))
          (LETT $ (GETREFV 177))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|JetDifferentialEquation|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
          (QSETREFV $ 12 (SPADCALL (QREFELT $ 11)))
          (QSETREFV $ 13 0)
          (QSETREFV $ 29
                    (|Record| (|:| |Eqs| (|List| |#2|))
                              (|:| JM (|SparseEchelonMatrix| |#1| |#2|))
                              (|:| |Deriv| (|List| (|NonNegativeInteger|)))
                              (|:| |Prolonged?| (|List| (|Boolean|)))
                              (|:| |Simp?| (|Boolean|))
                              (|:| |Dim?| (|Boolean|))
                              (|:| |Dim| (|NonNegativeInteger|))))
          (QSETREFV $ 30
                    (|Record| (|:| |Sys| (|List| (QREFELT $ 29)))
                              (|:| |Order| (|List| (|NonNegativeInteger|)))))
          $))) 

(MAKEPROP '|JetDifferentialEquation| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|PositiveInteger|) (0 . |numIndVar|) '|nn| (4 . |numDepVar|)
              '|mm| '|simpMode| (|NonNegativeInteger|) |JDE;setSimpMode;2Nni;1|
              (|List| 14) (8 . |#|) (|Integer|) (13 . |qelt|) (|Boolean|)
              (|List| 20) (19 . |qelt|) (25 . |min|) (|Mapping| 14 14 14)
              (31 . |reduce|) (37 . |and|) (|Mapping| 20 20 20) (43 . |reduce|)
              '|SysRec| '|Rep| (|List| 7) (49 . |copy|)
              (|SparseEchelonMatrix| 6 7) (54 . |copy|) (59 . |copy|)
              (64 . |copy|) |JDE;copy;2$;3| |JDE;order;$Nni;4| (69 . |append|)
              (|Mapping| 31 31 31) (|List| 31) (75 . |reduce|)
              |JDE;retract;$L;5| (|List| 33) |JDE;jacobiMatrix;$L;6|
              (|OutputForm|) (82 . |empty|) (86 . |Zero|) (|Equation| 7)
              (90 . =) (96 . |coerce|) (|String|) (101 . |message|) (|List| $)
              (106 . |vconcat|) |JDE;printSys;LOf;7| |JDE;coerce;$Of;8|
              (111 . |coerce|) (116 . |hconcat|) (|Void|) (122 . |print|)
              (127 . |coerce|) (|List| 6) (132 . |allIndices|) (137 . |coerce|)
              (142 . |coerce|) (147 . |void|) |JDE;display;$V;9|
              (151 . |nrows|) (|Record| (|:| |Indices| 63) (|:| |Entries| 31))
              (156 . |row|) (162 . |order|) (167 . |removeDuplicates|)
              (172 . |sort|) (177 . |One|) (181 . |One|) (185 . |new|)
              (|Vector| 33) (191 . |construct|) (196 . |position|)
              (202 . |setRow!|) (209 . |consRow!|) (|Vector| 31)
              (215 . |minIndex|) (220 . |new|) (226 . |numerator|)
              (|SparseEchelonMatrix| 6 $) (231 . |jacobiMatrix|)
              |JDE;makeSystem;L$;11| (|List| 29) (236 . |concat!|)
              (242 . |concat!|) (248 . |concat!|) (254 . |join|)
              (260 . |concat!|) |JDE;join;3$;12| |JDE;insert;L2$;13|
              (266 . |dimJ|) (271 . |copy|) (276 . |dimS|) (281 . |orderDim|)
              |JDE;dimension;$2Nni;14| (288 . |order|)
              (|Union| '"failed" (|List| 16))
              (|Record| (|:| |Sys| 54) (|:| JM 87) (|:| |Depend| 104))
              (293 . |simpMod|) (300 . |simplify|) (306 . |delete|)
              (312 . |delete|) (318 . |delete|) (324 . |extract|) (331 . >)
              (|Mapping| 20 6) (337 . |sortedPurge!|) (343 . |deleteRow!|)
              (349 . |qelt|) (355 . |concat!|) (361 . |appendRow!|)
              (367 . |concat!|) (373 . |concat!|) (379 . |qsetelt!|)
              (386 . |concat!|) (392 . |insert!|) (399 . U) (404 . |member?|)
              (|Record| (|:| |SDe| $) (|:| IC 31)) |JDE;simplify;$R;15|
              |JDE;project;$Nni$;16| (|Record| (|:| |DPhi| $) (|:| |JVars| 63))
              (410 . |formalDiff2|) (|List| 63) (417 . |jacobiMatrix|)
              (423 . |append|) (429 . |append|) |JDE;prolong;$R;17|
              |JDE;prolong;$NniR;18| (435 . |extractSymbol|)
              (|Record| (|:| |Ech| $) (|:| |Lt| (|Matrix| 7)) (|:| |Pivots| 31)
                        (|:| |Rank| 14))
              (440 . |rowEchelon|) |JDE;extractSymbol;$BSem;19|
              (445 . |pivots|) (450 . |class|)
              (|Record| (|:| |Rank| 14) (|:| |NumMultVar| 14) (|:| |Betas| 16))
              |JDE;analyseSymbol;SemR;20| (|Union| $ '"0")
              (455 . |differentiate|) (461 . <) (467 . |removeDuplicates!|)
              (|Mapping| 20 6 6) (472 . |sort!|) (478 . |setRow!|)
              |JDE;prolongSymbol;2Sem;21| |JDE;prolongMV;2R;22| (486 . ^)
              (492 . *) (|List| 158) (498 . |allRepeated|) (|List| 8)
              (503 . |m2r|) (508 . +) (|JetDifferential| 6 7)
              (514 . |differentials|) (519 . |last|) (524 . X) (529 . >)
              (535 . |coefficients|) (540 . |index|) (545 . |multiIndex|)
              (|Vector| 7) (550 . |entries|) (555 . |zero?|)
              |JDE;tableau;SemJdSem;25| (560 . |variables|)
              (566 . |coefficient|) (|List| 161) |JDE;tableau;SemLSem;26|)
           '#(|tableau| 572 |simplify| 584 |setSimpMode| 589 |retract| 594
              |prolongSymbol| 599 |prolongMV| 604 |prolong| 609 |project| 620
              |printSys| 626 |order| 631 |makeSystem| 636 |join| 641
              |jacobiMatrix| 647 |insert| 652 |extractSymbol| 658 |display| 664
              |dimension| 669 |copy| 675 |coerce| 680 |analyseSymbol| 685)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|order| ((|NonNegativeInteger|) $$)) T)
                                   '((|coerce| ((|OutputForm|) $$)) T)
                                   '((|printSys|
                                      ((|OutputForm|) (|List| |#2|)))
                                     T)
                                   '((|display| ((|Void|) $$)) T)
                                   '((|copy| ($$ $$)) T)
                                   '((|retract| ((|List| |#2|) $$)) T)
                                   '((|jacobiMatrix|
                                      ((|List|
                                        (|SparseEchelonMatrix| |#1| |#2|))
                                       $$))
                                     T)
                                   '((|makeSystem| ($$ (|List| |#2|))) T)
                                   '((|join| ($$ $$ $$)) T)
                                   '((|insert| ($$ (|List| |#2|) $$)) T)
                                   '((|dimension|
                                      ((|NonNegativeInteger|) $$
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|setSimpMode|
                                      ((|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|simplify|
                                      ((|Record| (|:| |SDe| $$)
                                                 (|:| IC (|List| |#2|)))
                                       $$))
                                     T)
                                   '((|extractSymbol|
                                      ((|SparseEchelonMatrix| |#1| |#2|) $$
                                       (|Boolean|)))
                                     T)
                                   '((|analyseSymbol|
                                      ((|Record|
                                        (|:| |Rank| (|NonNegativeInteger|))
                                        (|:| |NumMultVar|
                                             (|NonNegativeInteger|))
                                        (|:| |Betas|
                                             (|List| (|NonNegativeInteger|))))
                                       (|SparseEchelonMatrix| |#1| |#2|)))
                                     T)
                                   '((|prolongSymbol|
                                      ((|SparseEchelonMatrix| |#1| |#2|)
                                       (|SparseEchelonMatrix| |#1| |#2|)))
                                     T)
                                   '((|prolongMV|
                                      ((|Record|
                                        (|:| |Rank| (|NonNegativeInteger|))
                                        (|:| |NumMultVar|
                                             (|NonNegativeInteger|))
                                        (|:| |Betas|
                                             (|List| (|NonNegativeInteger|))))
                                       (|Record|
                                        (|:| |Rank| (|NonNegativeInteger|))
                                        (|:| |NumMultVar|
                                             (|NonNegativeInteger|))
                                        (|:| |Betas|
                                             (|List|
                                              (|NonNegativeInteger|))))))
                                     T)
                                   '((|project| ($$ $$ (|NonNegativeInteger|)))
                                     T)
                                   '((|prolong|
                                      ((|Record| (|:| |SDe| $$)
                                                 (|:| IC (|List| |#2|)))
                                       $$))
                                     T)
                                   '((|prolong|
                                      ((|Record| (|:| |SDe| $$)
                                                 (|:| IC (|List| |#2|)))
                                       $$ (|NonNegativeInteger|)))
                                     T)
                                   '((|tableau|
                                      ((|SparseEchelonMatrix| |#1| |#2|)
                                       (|SparseEchelonMatrix| |#1| |#2|)
                                       (|JetDifferential| |#1| |#2|)))
                                     T)
                                   '((|tableau|
                                      ((|SparseEchelonMatrix| |#1| |#2|)
                                       (|SparseEchelonMatrix| |#1| |#2|)
                                       (|List| (|JetDifferential| |#1| |#2|))))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 176
                                            '(0 6 8 9 0 6 8 11 1 16 14 0 17 2
                                              16 14 0 18 19 2 21 20 0 18 22 2
                                              14 0 0 0 23 2 16 14 24 0 25 2 20
                                              0 0 0 26 2 21 20 27 0 28 1 31 0 0
                                              32 1 33 0 0 34 1 16 0 0 35 1 21 0
                                              0 36 2 31 0 0 0 39 3 41 31 40 0
                                              31 42 0 46 0 47 0 7 0 48 2 49 0 7
                                              7 50 1 49 46 0 51 1 46 0 52 53 1
                                              46 0 54 55 1 14 46 0 58 2 46 0 0
                                              0 59 1 46 60 0 61 1 33 46 0 62 1
                                              33 63 0 64 1 63 46 0 65 1 16 46 0
                                              66 0 60 0 67 1 33 14 0 69 2 33 70
                                              0 18 71 1 6 14 0 72 1 16 0 0 73 1
                                              16 0 0 74 0 6 0 75 0 7 0 76 2 33
                                              0 63 18 77 1 78 0 44 79 2 16 18
                                              14 0 80 3 33 60 0 18 70 81 2 33
                                              60 0 70 82 1 83 18 0 84 2 21 0 14
                                              20 85 1 7 0 0 86 1 7 87 54 88 2
                                              90 0 0 0 91 2 16 0 0 0 92 2 31 0
                                              0 0 93 2 33 0 0 0 94 2 21 0 0 0
                                              95 1 6 14 14 98 1 90 0 0 99 1 6
                                              14 14 100 3 7 14 54 87 14 101 1 7
                                              14 0 103 3 7 105 54 87 54 106 2 7
                                              105 54 87 107 2 31 0 0 18 108 2
                                              16 0 0 18 109 2 21 0 0 18 110 3
                                              33 0 0 18 18 111 2 14 20 0 0 112
                                              2 33 60 0 113 114 2 33 60 0 18
                                              115 2 90 29 0 18 116 2 31 0 0 7
                                              117 2 33 60 0 70 118 2 16 0 0 14
                                              119 2 21 0 0 20 120 3 90 29 0 18
                                              29 121 2 90 0 0 29 122 3 90 0 29
                                              0 18 123 1 6 0 8 124 2 63 20 6 0
                                              125 3 7 129 0 8 87 130 2 7 87 54
                                              131 132 2 16 0 0 0 133 2 21 0 0 0
                                              134 1 7 87 87 137 1 33 138 0 139
                                              1 33 70 0 141 1 6 14 0 142 2 6
                                              145 0 8 146 2 6 20 0 0 147 1 63 0
                                              0 148 2 63 0 149 0 150 4 33 60 0
                                              18 63 31 151 2 7 0 0 14 154 2 7 0
                                              0 0 155 1 6 156 16 157 1 6 158 16
                                              159 2 7 0 0 0 160 1 161 63 0 162
                                              1 63 6 0 163 1 6 0 8 164 2 6 20 0
                                              0 165 1 161 31 0 166 1 6 8 0 167
                                              1 6 16 0 168 1 169 31 0 170 1 7
                                              20 0 171 2 6 54 14 8 173 2 161 7
                                              0 6 174 2 0 33 33 175 176 2 0 33
                                              33 161 172 1 0 126 0 127 1 0 14
                                              14 15 1 0 31 0 43 1 0 33 33 152 1
                                              0 143 143 153 1 0 126 0 135 2 0
                                              126 0 14 136 2 0 0 0 14 128 1 0
                                              46 31 56 1 0 14 0 38 1 0 0 31 89
                                              2 0 0 0 0 96 1 0 44 0 45 2 0 0 31
                                              0 97 2 0 33 0 20 140 1 0 60 0 68
                                              2 0 14 0 14 102 1 0 0 0 37 1 0 46
                                              0 57 1 0 143 33 144)))))
           '|lookupComplete|)) 

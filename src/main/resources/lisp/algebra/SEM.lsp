
(SDEFUN |SEM;greater|
        ((|r1|
          (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
         (|r2|
          (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
         ($ (|Boolean|)))
        (COND ((NULL (QCAR |r1|)) NIL) ((NULL (QCAR |r2|)) 'T)
              ('T
               (SPADCALL (|SPADfirst| (QCAR |r2|)) (|SPADfirst| (QCAR |r1|))
                         (QREFELT $ 16))))) 

(PUT '|SEM;ncols;$Nni;2| '|SPADreplace| '(XLAM (A) (QVELT A 0))) 

(SDEFUN |SEM;ncols;$Nni;2| ((A ($)) ($ (|NonNegativeInteger|))) (QVELT A 0)) 

(PUT '|SEM;nrows;$Nni;3| '|SPADreplace| '(XLAM (A) (QVELT A 1))) 

(SDEFUN |SEM;nrows;$Nni;3| ((A ($)) ($ (|NonNegativeInteger|))) (QVELT A 1)) 

(SDEFUN |SEM;allIndices;$L;4| ((A ($)) ($ (|List| C)))
        (SPADCALL (QVELT A 2) (QREFELT $ 22))) 

(SDEFUN |SEM;row;$IR;5|
        ((A ($)) (|i| (|Integer|))
         ($ (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D)))))
        (QAREF1O (QVELT A 3) |i| 1)) 

(SDEFUN |SEM;setRow!;$IRV;6|
        ((A ($)) (|i| (|Integer|))
         (|r| (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
         ($ (|Void|)))
        (SEQ (QSETAREF1O (QVELT A 3) |i| |r| 1)
             (EXIT (SPADCALL (QREFELT $ 28))))) 

(SDEFUN |SEM;setRow!;$ILLV;7|
        ((A ($)) (|i| (|Integer|)) (|inds| (|List| C)) (|ents| (|List| D))
         ($ (|Void|)))
        (SEQ (QSETAREF1O (QVELT A 3) |i| (CONS |inds| |ents|) 1)
             (EXIT (SPADCALL (QREFELT $ 28))))) 

(SDEFUN |SEM;new;LI$;8| ((|inds| (|List| C)) (|n| (|Integer|)) ($ ($)))
        (SPROG
         ((#1=#:G790 NIL) (#2=#:G792 NIL) (|i| NIL) (#3=#:G791 NIL)
          (#4=#:G786 NIL))
         (SEQ
          (VECTOR (LENGTH |inds|)
                  (PROG1 (LETT #4# |n|)
                    (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #4#))
                  |inds|
                  (PROGN
                   (LETT #3# (GETREFV |n|))
                   (SEQ (LETT |i| 1) (LETT #2# |n|) (LETT #1# 0) G190
                        (COND ((|greater_SI| |i| #2#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SETELT #3# #1#
                                  (CONS (CAR (QREFELT $ 11))
                                        (CDR (QREFELT $ 11))))))
                        (LETT #1#
                              (PROG1 (|inc_SI| #1#) (LETT |i| (|inc_SI| |i|))))
                        (GO G190) G191 (EXIT NIL))
                   #3#))))) 

(SDEFUN |SEM;elt;$ICD;9| ((A ($)) (|i| (|Integer|)) (|c| (C)) ($ (D)))
        (SPROG
         ((|pos| (|Integer|))
          (|r|
           (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D)))))
         (SEQ (LETT |r| (SPADCALL A |i| (QREFELT $ 26)))
              (LETT |pos| (SPADCALL |c| (QCAR |r|) (QREFELT $ 33)))
              (EXIT
               (COND ((< |pos| (QREFELT $ 8)) (|spadConstant| $ 34))
                     ('T (SPADCALL (QCDR |r|) |pos| (QREFELT $ 35)))))))) 

(SDEFUN |SEM;setelt!;$ICDV;10|
        ((A ($)) (|i| (|Integer|)) (|c| (C)) (|d| (D)) ($ (|Void|)))
        (SPROG
         ((|j| (|Integer|)) (#1=#:G801 NIL) (|ind| NIL) (|pos| (|Integer|))
          (|r|
           (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D)))))
         (SEQ (LETT |r| (SPADCALL A |i| (QREFELT $ 26)))
              (LETT |pos| (SPADCALL |c| (QCAR |r|) (QREFELT $ 33)))
              (COND
               ((>= |pos| (QREFELT $ 8))
                (SPADCALL (QCDR |r|) |pos| |d| (QREFELT $ 37)))
               ('T
                (SEQ (LETT |j| (QREFELT $ 8))
                     (SEQ (LETT |ind| NIL) (LETT #1# (QCAR |r|)) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |ind| (CAR #1#)) NIL)
                                (NULL (SPADCALL |c| |ind| (QREFELT $ 16))))
                            (GO G191)))
                          (SEQ (EXIT (LETT |j| (+ |j| 1))))
                          (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                     (PROGN
                      (RPLACA |r| (SPADCALL |c| (QCAR |r|) |j| (QREFELT $ 38)))
                      (QCAR |r|))
                     (EXIT
                      (PROGN
                       (RPLACD |r|
                               (SPADCALL |d| (QCDR |r|) |j| (QREFELT $ 39)))
                       (QCDR |r|))))))
              (QSETAREF1O (QVELT A 3) |i| |r| 1)
              (EXIT (SPADCALL (QREFELT $ 28)))))) 

(SDEFUN |SEM;coerce;$M;11| ((A ($)) ($ (|Matrix| D)))
        (SPROG
         ((|ents| (|List| D)) (|inds| (|List| C)) (#1=#:G816 NIL) (|ind| NIL)
          (|j| NIL) (#2=#:G815 NIL) (|r| NIL) (|i| NIL) (AA (|Matrix| D)))
         (SEQ
          (COND
           ((ZEROP (QVELT A 0))
            (|error| "cannot coerce matrix with zero columns"))
           ('T
            (SEQ
             (LETT AA
                   (MAKE_MATRIX1 (QVELT A 1) (QVELT A 0)
                                 (|spadConstant| $ 34)))
             (SEQ (LETT |i| (PROGN AA 1)) (LETT |r| NIL)
                  (LETT #2# (SPADCALL (QVELT A 3) (QREFELT $ 43))) G190
                  (COND
                   ((OR (ATOM #2#) (PROGN (LETT |r| (CAR #2#)) NIL))
                    (GO G191)))
                  (SEQ (LETT |inds| (QCAR |r|)) (LETT |ents| (QCDR |r|))
                       (EXIT
                        (SEQ (LETT |j| (PROGN AA 1)) (LETT |ind| NIL)
                             (LETT #1# (QVELT A 2)) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |ind| (CAR #1#)) NIL)
                                   (NULL (NULL (NULL |inds|))))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |ind| (|SPADfirst| |inds|)
                                           (QREFELT $ 44))
                                 (SEQ
                                  (QSETAREF2O AA |i| |j| (|SPADfirst| |ents|) 1
                                              1)
                                  (LETT |inds| (CDR |inds|))
                                  (EXIT (LETT |ents| (CDR |ents|))))))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT |j| (+ |j| 1))))
                             (GO G190) G191 (EXIT NIL))))
                  (LETT #2# (PROG1 (CDR #2#) (LETT |i| (+ |i| 1)))) (GO G190)
                  G191 (EXIT NIL))
             (EXIT AA))))))) 

(SDEFUN |SEM;coerce;$Of;12| ((A ($)) ($ (|OutputForm|)))
        (COND
         ((ZEROP (QVELT A 0)) (SPADCALL (|spadConstant| $ 34) (QREFELT $ 48)))
         ('T (SPADCALL (SPADCALL A (QREFELT $ 46)) (QREFELT $ 49))))) 

(SDEFUN |SEM;copy;2$;13| ((A ($)) ($ ($)))
        (SPROG
         ((|r|
           (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
          (#1=#:G825 NIL) (|l| NIL)
          (|resRows|
           (|Vector|
            (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))))
         (SEQ (LETT |resRows| (MAKEARR1 (QVELT A 1) (QREFELT $ 11)))
              (SEQ (LETT |l| 1) (LETT #1# (QVELT A 1)) G190
                   (COND ((|greater_SI| |l| #1#) (GO G191)))
                   (SEQ (LETT |r| (QAREF1O (QVELT A 3) |l| 1))
                        (EXIT
                         (QSETAREF1O |resRows| |l|
                                     (CONS (SPADCALL (QCAR |r|) (QREFELT $ 22))
                                           (SPADCALL (QCDR |r|)
                                                     (QREFELT $ 51)))
                                     1)))
                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (VECTOR (QVELT A 0) (QVELT A 1)
                       (SPADCALL (QVELT A 2) (QREFELT $ 22)) |resRows|))))) 

(SDEFUN |SEM;elimZeroCols!;$V;14| ((A ($)) ($ (|Void|)))
        (SPROG ((|newInds| (|List| C)) (#1=#:G831 NIL) (|r| NIL))
               (SEQ (LETT |newInds| NIL)
                    (SEQ (LETT |r| NIL)
                         (LETT #1# (SPADCALL (QVELT A 3) (QREFELT $ 43))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |newInds|
                                 (SPADCALL
                                  (SPADCALL
                                   (CONS #'|SEM;elimZeroCols!;$V;14!0| $)
                                   |newInds| (QCAR |r|) (QREFELT $ 54))
                                  (QREFELT $ 55)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (QSETVELT A 2 |newInds|) (EXIT (SPADCALL (QREFELT $ 28)))))) 

(SDEFUN |SEM;elimZeroCols!;$V;14!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL |y| |x| (QREFELT $ 16))) 

(SDEFUN |SEM;purge!;$MV;15|
        ((A ($)) (|crit| (|Mapping| (|Boolean|) C)) ($ (|Void|)))
        (SPROG
         ((|newEnts| (|List| D)) (|newInds| (|List| C)) (#1=#:G850 NIL)
          (|c| NIL) (#2=#:G851 NIL) (|e| NIL)
          (|r|
           (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
          (#3=#:G849 NIL) (|l| NIL) (#4=#:G848 NIL))
         (SEQ (LETT |newInds| NIL)
              (SEQ (LETT |c| NIL) (LETT #4# (QVELT A 2)) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |c| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL (SPADCALL |c| |crit|))
                       (LETT |newInds| (CONS |c| |newInds|))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (LETT |newInds| (NREVERSE |newInds|))
              (COND
               ((SPADCALL (LENGTH |newInds|) (LENGTH (QVELT A 2))
                          (QREFELT $ 57))
                (SEQ (QSETVELT A 2 |newInds|)
                     (EXIT
                      (SEQ (LETT |l| 1) (LETT #3# (QVELT A 1)) G190
                           (COND ((|greater_SI| |l| #3#) (GO G191)))
                           (SEQ (LETT |r| (QAREF1O (QVELT A 3) |l| 1))
                                (LETT |newInds| NIL) (LETT |newEnts| NIL)
                                (SEQ (LETT |e| NIL) (LETT #2# (QCDR |r|))
                                     (LETT |c| NIL) (LETT #1# (QCAR |r|)) G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |c| (CAR #1#)) NIL)
                                           (ATOM #2#)
                                           (PROGN (LETT |e| (CAR #2#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((NULL (SPADCALL |c| |crit|))
                                         (SEQ
                                          (LETT |newInds| (CONS |c| |newInds|))
                                          (EXIT
                                           (LETT |newEnts|
                                                 (CONS |e| |newEnts|))))))))
                                     (LETT #1#
                                           (PROG1 (CDR #1#)
                                             (LETT #2# (CDR #2#))))
                                     (GO G190) G191 (EXIT NIL))
                                (EXIT
                                 (QSETAREF1O (QVELT A 3) |l|
                                             (CONS (NREVERSE |newInds|)
                                                   (NREVERSE |newEnts|))
                                             1)))
                           (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                           (EXIT NIL))))))
              (EXIT (SPADCALL (QREFELT $ 28)))))) 

(SDEFUN |SEM;sortedPurge!;$MV;16|
        ((A ($)) (|crit| (|Mapping| (|Boolean|) C)) ($ (|Void|)))
        (SPROG
         ((|r|
           (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
          (#1=#:G867 NIL) (|l| NIL))
         (SEQ
          (COND
           ((SPADCALL (|SPADfirst| (QVELT A 2)) |crit|)
            (SEQ
             (SEQ G190
                  (COND
                   ((NULL
                     (COND ((NULL (QVELT A 2)) NIL)
                           ('T (SPADCALL (|SPADfirst| (QVELT A 2)) |crit|))))
                    (GO G191)))
                  (SEQ (EXIT (QSETVELT A 2 (CDR (QVELT A 2))))) NIL (GO G190)
                  G191 (EXIT NIL))
             (EXIT
              (SEQ (LETT |l| 1) (LETT #1# (QVELT A 1)) G190
                   (COND ((|greater_SI| |l| #1#) (GO G191)))
                   (SEQ (LETT |r| (QAREF1O (QVELT A 3) |l| 1))
                        (SEQ G190
                             (COND
                              ((NULL
                                (COND ((NULL (QCAR |r|)) NIL)
                                      ('T
                                       (SPADCALL (|SPADfirst| (QCAR |r|))
                                                 |crit|))))
                               (GO G191)))
                             (SEQ
                              (PROGN (RPLACA |r| (CDR (QCAR |r|))) (QCAR |r|))
                              (EXIT
                               (PROGN
                                (RPLACD |r| (CDR (QCDR |r|)))
                                (QCDR |r|))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (EXIT (QSETAREF1O (QVELT A 3) |l| |r| 1)))
                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))))))
          (EXIT (SPADCALL (QREFELT $ 28)))))) 

(SDEFUN |SEM;deleteRow!;$IV;17| ((A ($)) (|i| (|Integer|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G879 NIL) (|l| NIL) (#2=#:G878 NIL)
          (|resRows|
           (|Vector|
            (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D)))))
          (|nr| (|NonNegativeInteger|)) (#3=#:G868 NIL))
         (SEQ
          (COND ((> |i| (QVELT A 1)) A)
                ('T
                 (SEQ
                  (LETT |nr|
                        (PROG1 (LETT #3# (- (QVELT A 1) 1))
                          (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #3#)))
                  (LETT |resRows| (MAKEARR1 |nr| (QREFELT $ 11)))
                  (SEQ (LETT |l| 1) (LETT #2# (- |i| 1)) G190
                       (COND ((|greater_SI| |l| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (QSETAREF1O |resRows| |l| (QAREF1O (QVELT A 3) |l| 1)
                                     1)))
                       (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
                  (SEQ (LETT |l| (+ |i| 1)) (LETT #1# (QVELT A 1)) G190
                       (COND ((> |l| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (QSETAREF1O |resRows| (- |l| 1)
                                     (QAREF1O (QVELT A 3) |l| 1) 1)))
                       (LETT |l| (+ |l| 1)) (GO G190) G191 (EXIT NIL))
                  (QSETVELT A 1 |nr|) (QSETVELT A 3 |resRows|)
                  (EXIT (SPADCALL (QREFELT $ 28))))))))) 

(SDEFUN |SEM;consRow!;$RV;18|
        ((A ($))
         (|r| (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
         ($ (|Void|)))
        (SPROG
         ((|newInds| (|List| C))
          (|newRows|
           (|List|
            (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))))
         (SEQ (QSETVELT A 1 (+ (QVELT A 1) 1))
              (LETT |newRows| (CONS |r| (SPADCALL (QVELT A 3) (QREFELT $ 43))))
              (QSETVELT A 3 (SPADCALL |newRows| (QREFELT $ 62)))
              (LETT |newInds| (SPADCALL (QCAR |r|) (QVELT A 2) (QREFELT $ 63)))
              (COND
               ((NULL (NULL |newInds|))
                (QSETVELT A 2
                          (SPADCALL (CONS #'|SEM;consRow!;$RV;18!0| $)
                                    (QVELT A 2)
                                    (SPADCALL
                                     (CONS #'|SEM;consRow!;$RV;18!1| $)
                                     |newInds| (QREFELT $ 64))
                                    (QREFELT $ 65)))))
              (EXIT (SPADCALL (QREFELT $ 28)))))) 

(SDEFUN |SEM;consRow!;$RV;18!1| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL |y| |x| (QREFELT $ 16))) 

(SDEFUN |SEM;consRow!;$RV;18!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL |y| |x| (QREFELT $ 16))) 

(SDEFUN |SEM;appendRow!;$RV;19|
        ((A ($))
         (|r| (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
         ($ (|Void|)))
        (SPROG
         ((|newInds| (|List| C))
          (|newRows|
           (|List|
            (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))))
         (SEQ (QSETVELT A 1 (+ (QVELT A 1) 1))
              (LETT |newRows|
                    (SPADCALL (SPADCALL (QVELT A 3) (QREFELT $ 43)) |r|
                              (QREFELT $ 67)))
              (QSETVELT A 3 (SPADCALL |newRows| (QREFELT $ 62)))
              (LETT |newInds| (SPADCALL (QCAR |r|) (QVELT A 2) (QREFELT $ 63)))
              (COND
               ((NULL (NULL |newInds|))
                (QSETVELT A 2
                          (SPADCALL (CONS #'|SEM;appendRow!;$RV;19!0| $)
                                    (QVELT A 2)
                                    (SPADCALL
                                     (CONS #'|SEM;appendRow!;$RV;19!1| $)
                                     |newInds| (QREFELT $ 64))
                                    (QREFELT $ 65)))))
              (EXIT (SPADCALL (QREFELT $ 28)))))) 

(SDEFUN |SEM;appendRow!;$RV;19!1| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL |y| |x| (QREFELT $ 16))) 

(SDEFUN |SEM;appendRow!;$RV;19!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL |y| |x| (QREFELT $ 16))) 

(SDEFUN |SEM;extract;$2I$;20|
        ((A ($)) (|i1| (|Integer|)) (|i2| (|Integer|)) ($ ($)))
        (SPROG
         ((|newInds| (|List| C)) (#1=#:G906 NIL) (|i| NIL)
          (|resRows|
           (|Vector|
            (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D)))))
          (|nr| (|NonNegativeInteger|)) (#2=#:G898 NIL))
         (SEQ
          (LETT |nr|
                (PROG1 (LETT #2# (+ (- |i2| |i1|) 1))
                  (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #2#)))
          (LETT |resRows| (MAKEARR1 |nr| (QREFELT $ 11))) (LETT |newInds| NIL)
          (SEQ (LETT |i| |i1|) (LETT #1# |i2|) G190
               (COND ((> |i| #1#) (GO G191)))
               (SEQ
                (QSETAREF1O |resRows| (+ (- |i| |i1|) 1)
                            (SPADCALL A |i| (QREFELT $ 26)) 1)
                (EXIT
                 (LETT |newInds|
                       (SPADCALL
                        (SPADCALL (CONS #'|SEM;extract;$2I$;20!0| $) |newInds|
                                  (QCAR (SPADCALL A |i| (QREFELT $ 26)))
                                  (QREFELT $ 65))
                        (QREFELT $ 55)))))
               (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
          (EXIT (VECTOR (QVELT A 0) |nr| |newInds| |resRows|))))) 

(SDEFUN |SEM;extract;$2I$;20!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL |y| |x| (QREFELT $ 16))) 

(SDEFUN |SEM;join;3$;21| ((A1 ($)) (A2 ($)) ($ ($)))
        (SPROG
         ((#1=#:G922 NIL) (|l| NIL) (#2=#:G921 NIL)
          (|newRows|
           (|Vector|
            (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D)))))
          (|newNRows| (|NonNegativeInteger|)) (|newInds| (|List| C)))
         (SEQ
          (LETT |newInds|
                (SPADCALL
                 (SPADCALL (CONS #'|SEM;join;3$;21!0| $) (QVELT A1 2)
                           (QVELT A2 2) (QREFELT $ 65))
                 (QREFELT $ 55)))
          (LETT |newNRows| (+ (QVELT A1 1) (QVELT A2 1)))
          (LETT |newRows| (MAKEARR1 |newNRows| (QREFELT $ 11)))
          (SEQ (LETT |l| 1) (LETT #2# (QVELT A1 1)) G190
               (COND ((|greater_SI| |l| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (QSETAREF1O |newRows| |l| (QAREF1O (QVELT A1 3) |l| 1) 1)))
               (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
          (SEQ (LETT |l| 1) (LETT #1# (QVELT A2 1)) G190
               (COND ((|greater_SI| |l| #1#) (GO G191)))
               (SEQ
                (EXIT
                 (QSETAREF1O |newRows| (+ (QVELT A1 1) |l|)
                             (QAREF1O (QVELT A2 3) |l| 1) 1)))
               (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
          (EXIT (VECTOR (LENGTH |newInds|) |newNRows| |newInds| |newRows|))))) 

(SDEFUN |SEM;join;3$;21!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL |y| |x| (QREFELT $ 16))) 

(SDEFUN |SEM;horizJoin;3$;22| ((A1 ($)) (A2 ($)) ($ ($)))
        (SPROG
         ((|r2|
           #1=(|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
          (|r1| #1#) (#2=#:G929 NIL) (|i| NIL) (|res| ($))
          (|newInds| (|List| C)))
         (SEQ
          (COND
           ((SPADCALL (QVELT A1 1) (QVELT A2 1) (QREFELT $ 57))
            (|error| "incompatible dimensions in horizJoin"))
           ('T
            (SEQ
             (LETT |newInds|
                   (SPADCALL (QVELT A1 2) (QVELT A2 2) (QREFELT $ 71)))
             (LETT |res| (SPADCALL |newInds| (QVELT A1 1) (QREFELT $ 32)))
             (SEQ (LETT |i| 1) (LETT #2# (QVELT A1 1)) G190
                  (COND ((|greater_SI| |i| #2#) (GO G191)))
                  (SEQ (LETT |r1| (SPADCALL A1 |i| (QREFELT $ 26)))
                       (LETT |r2| (SPADCALL A2 |i| (QREFELT $ 26)))
                       (EXIT
                        (SPADCALL |res| |i|
                                  (SPADCALL (QCAR |r1|) (QCAR |r2|)
                                            (QREFELT $ 71))
                                  (SPADCALL (QCDR |r1|) (QCDR |r2|)
                                            (QREFELT $ 72))
                                  (QREFELT $ 31))))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
             (EXIT |res|))))))) 

(SDEFUN |SEM;horizSplit;$CR;23|
        ((A ($)) (|c| (C)) ($ (|Record| (|:| |Left| $) (|:| |Right| $))))
        (SPROG
         ((|le| (|List| D)) (|li| (|List| C)) (|re| (|List| D))
          (|ri| (|List| C))
          (|r|
           (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
          (#1=#:G949 NIL) (|i| NIL) (RA ($)) (LA ($)) (|linds| (|List| C))
          (|rinds| (|List| C)))
         (SEQ (LETT |rinds| (SPADCALL A (QREFELT $ 23))) (LETT |linds| NIL)
              (SEQ G190
                   (COND
                    ((NULL
                      (COND ((NULL |rinds|) NIL)
                            ('T
                             (SPADCALL (|SPADfirst| |rinds|) |c|
                                       (QREFELT $ 74)))))
                     (GO G191)))
                   (SEQ (LETT |linds| (CONS (|SPADfirst| |rinds|) |linds|))
                        (EXIT (LETT |rinds| (CDR |rinds|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((NULL |linds|)
                 (CONS (SPADCALL |linds| (QVELT A 1) (QREFELT $ 32)) A))
                (#2='T
                 (SEQ (LETT |linds| (NREVERSE |linds|))
                      (EXIT
                       (COND
                        ((NULL |rinds|)
                         (CONS A
                               (SPADCALL |rinds| (QVELT A 1) (QREFELT $ 32))))
                        (#2#
                         (SEQ
                          (LETT LA
                                (SPADCALL |linds| (QVELT A 1) (QREFELT $ 32)))
                          (LETT RA
                                (SPADCALL |rinds| (QVELT A 1) (QREFELT $ 32)))
                          (SEQ (LETT |i| 1) (LETT #1# (QVELT A 1)) G190
                               (COND ((|greater_SI| |i| #1#) (GO G191)))
                               (SEQ (LETT |r| (SPADCALL A |i| (QREFELT $ 26)))
                                    (LETT |ri| (QCAR |r|))
                                    (LETT |re| (QCDR |r|)) (LETT |li| NIL)
                                    (LETT |le| NIL)
                                    (SEQ G190
                                         (COND
                                          ((NULL
                                            (COND ((NULL |ri|) NIL)
                                                  ('T
                                                   (SPADCALL (|SPADfirst| |ri|)
                                                             |c|
                                                             (QREFELT $ 74)))))
                                           (GO G191)))
                                         (SEQ
                                          (LETT |li|
                                                (CONS (|SPADfirst| |ri|) |li|))
                                          (LETT |le|
                                                (CONS (|SPADfirst| |re|) |le|))
                                          (LETT |ri| (CDR |ri|))
                                          (EXIT (LETT |re| (CDR |re|))))
                                         NIL (GO G190) G191 (EXIT NIL))
                                    (COND
                                     ((NULL (NULL |li|))
                                      (SEQ (LETT |li| (NREVERSE |li|))
                                           (LETT |le| (NREVERSE |le|))
                                           (EXIT
                                            (SPADCALL LA |i| |li| |le|
                                                      (QREFELT $ 31))))))
                                    (EXIT
                                     (COND
                                      ((NULL (NULL |ri|))
                                       (SPADCALL RA |i| |ri| |re|
                                                 (QREFELT $ 31))))))
                               (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT (CONS LA RA))))))))))))) 

(SDEFUN |SEM;addRows|
        ((|d1| (D))
         (|r1|
          (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
         (|d2| (D))
         (|r2|
          (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
         ($ (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D)))))
        (SPROG
         ((|resE| (|List| D)) (|resI| (|List| C)) (|lent2| (|List| D))
          (|lind2| (|List| C)) (|sum| (D)) (#1=#:G997 NIL) (|c1| NIL)
          (#2=#:G998 NIL) (|e1| NIL) (#3=#:G996 NIL) (|e2| NIL) (#4=#:G995 NIL)
          (|lent1| (|List| D)) (#5=#:G994 NIL) (#6=#:G993 NIL) (#7=#:G992 NIL)
          (#8=#:G991 NIL) (#9=#:G990 NIL) (#10=#:G989 NIL))
         (SEQ
          (COND
           ((NULL (QCAR |r1|))
            (COND ((SPADCALL |d2| (QREFELT $ 77)) |r2|)
                  (#11='T
                   (CONS (QCAR |r2|)
                         (PROGN
                          (LETT #10# NIL)
                          (SEQ (LETT |e2| NIL) (LETT #9# (QCDR |r2|)) G190
                               (COND
                                ((OR (ATOM #9#)
                                     (PROGN (LETT |e2| (CAR #9#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #10#
                                       (CONS
                                        (SPADCALL |d2| |e2| (QREFELT $ 78))
                                        #10#))))
                               (LETT #9# (CDR #9#)) (GO G190) G191
                               (EXIT (NREVERSE #10#))))))))
           ((NULL (QCAR |r2|))
            (COND ((SPADCALL |d1| (QREFELT $ 77)) |r1|)
                  (#11#
                   (CONS (QCAR |r1|)
                         (PROGN
                          (LETT #8# NIL)
                          (SEQ (LETT |e1| NIL) (LETT #7# (QCDR |r1|)) G190
                               (COND
                                ((OR (ATOM #7#)
                                     (PROGN (LETT |e1| (CAR #7#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #8#
                                       (CONS
                                        (SPADCALL |d1| |e1| (QREFELT $ 78))
                                        #8#))))
                               (LETT #7# (CDR #7#)) (GO G190) G191
                               (EXIT (NREVERSE #8#))))))))
           (#11#
            (SEQ (LETT |resI| NIL) (LETT |resE| NIL)
                 (COND
                  ((OR (QREFELT $ 12) (NULL (SPADCALL |d1| (QREFELT $ 77))))
                   (LETT |lent1|
                         (PROGN
                          (LETT #6# NIL)
                          (SEQ (LETT |e1| NIL) (LETT #5# (QCDR |r1|)) G190
                               (COND
                                ((OR (ATOM #5#)
                                     (PROGN (LETT |e1| (CAR #5#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #6#
                                       (CONS
                                        (SPADCALL |d1| |e1| (QREFELT $ 78))
                                        #6#))))
                               (LETT #5# (CDR #5#)) (GO G190) G191
                               (EXIT (NREVERSE #6#))))))
                  ('T (LETT |lent1| (QCDR |r1|))))
                 (COND
                  ((OR (QREFELT $ 12) (NULL (SPADCALL |d2| (QREFELT $ 77))))
                   (LETT |lent2|
                         (PROGN
                          (LETT #4# NIL)
                          (SEQ (LETT |e2| NIL) (LETT #3# (QCDR |r2|)) G190
                               (COND
                                ((OR (ATOM #3#)
                                     (PROGN (LETT |e2| (CAR #3#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #4#
                                       (CONS
                                        (SPADCALL |d2| |e2| (QREFELT $ 78))
                                        #4#))))
                               (LETT #3# (CDR #3#)) (GO G190) G191
                               (EXIT (NREVERSE #4#))))))
                  ('T (LETT |lent2| (SPADCALL (QCDR |r2|) (QREFELT $ 51)))))
                 (LETT |lind2| (SPADCALL (QCAR |r2|) (QREFELT $ 22)))
                 (SEQ (LETT |e1| NIL) (LETT #2# |lent1|) (LETT |c1| NIL)
                      (LETT #1# (QCAR |r1|)) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |c1| (CAR #1#)) NIL)
                            (ATOM #2#) (PROGN (LETT |e1| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (SEQ G190
                            (COND
                             ((NULL
                               (COND ((NULL |lind2|) NIL)
                                     ('T
                                      (SPADCALL |c1| (|SPADfirst| |lind2|)
                                                (QREFELT $ 16)))))
                              (GO G191)))
                            (SEQ
                             (LETT |resI| (CONS (|SPADfirst| |lind2|) |resI|))
                             (LETT |resE| (CONS (|SPADfirst| |lent2|) |resE|))
                             (LETT |lind2| (CDR |lind2|))
                             (EXIT (LETT |lent2| (CDR |lent2|))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (COND
                         ((OR (NULL |lind2|)
                              (NULL
                               (SPADCALL (|SPADfirst| |lind2|) |c1|
                                         (QREFELT $ 44))))
                          (SEQ (LETT |resI| (CONS |c1| |resI|))
                               (EXIT (LETT |resE| (CONS |e1| |resE|)))))
                         ('T
                          (SEQ
                           (LETT |sum|
                                 (SPADCALL |e1| (|SPADfirst| |lent2|)
                                           (QREFELT $ 79)))
                           (COND
                            ((OR (QREFELT $ 12)
                                 (NULL (SPADCALL |sum| (QREFELT $ 80))))
                             (SEQ (LETT |resI| (CONS |c1| |resI|))
                                  (EXIT (LETT |resE| (CONS |sum| |resE|))))))
                           (LETT |lind2| (CDR |lind2|))
                           (EXIT (LETT |lent2| (CDR |lent2|))))))))
                      (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                      (GO G190) G191 (EXIT NIL))
                 (LETT |resI|
                       (SPADCALL (NREVERSE |resI|) |lind2| (QREFELT $ 81)))
                 (LETT |resE|
                       (SPADCALL (NREVERSE |resE|) |lent2| (QREFELT $ 82)))
                 (SEQ G190
                      (COND
                       ((NULL
                         (COND ((NULL |resE|) NIL)
                               ('T
                                (SPADCALL (|SPADfirst| |resE|)
                                          (QREFELT $ 80)))))
                        (GO G191)))
                      (SEQ (LETT |resI| (CDR |resI|))
                           (EXIT (LETT |resE| (CDR |resE|))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT (CONS |resI| |resE|)))))))) 

(SDEFUN |SEM;pivot;$IR;25|
        ((A ($)) (|i| (|Integer|))
         ($ (|Record| (|:| |Index| C) (|:| |Entry| D))))
        (SPROG
         ((|r|
           (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D)))))
         (SEQ (LETT |r| (SPADCALL A |i| (QREFELT $ 26)))
              (EXIT
               (COND ((NULL (QCAR |r|)) (|error| "empty row"))
                     ('T
                      (CONS (|SPADfirst| (QCAR |r|))
                            (|SPADfirst| (QCDR |r|))))))))) 

(SDEFUN |SEM;pivots;$R;26|
        ((A ($))
         ($ (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D)))))
        (SPROG
         ((|resE| (|List| D)) (|resI| (|List| C)) (#1=#:G1009 NIL) (|r| NIL))
         (SEQ (LETT |resI| NIL) (LETT |resE| NIL)
              (SEQ (LETT |r| NIL)
                   (LETT #1# (SPADCALL (QVELT A 3) (QREFELT $ 43))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL (NULL (QCAR |r|)))
                       (SEQ
                        (LETT |resI| (CONS (|SPADfirst| (QCAR |r|)) |resI|))
                        (EXIT
                         (LETT |resE|
                               (CONS (|SPADfirst| (QCDR |r|)) |resE|))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS (NREVERSE |resI|) (NREVERSE |resE|)))))) 

(SDEFUN |SEM;rowEchelon;$R;27|
        ((AA ($))
         ($
          (|Record| (|:| |Ech| $) (|:| |Lt| (|Matrix| D))
                    (|:| |Pivots| (|List| D))
                    (|:| |Rank| (|NonNegativeInteger|)))))
        (SPROG
         ((|rk| (|NonNegativeInteger|)) (#1=#:G1077 NIL) (|l| NIL)
          (#2=#:G1076 NIL) (|f| (D)) (#3=#:G1075 NIL)
          (|r|
           #4=(|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
          (|c| (D)) (#5=#:G1074 NIL) (|j| NIL) (|pr| #4#) (|Pivs| (|List| D))
          (|piv| (D)) (|pivrow| (|NonNegativeInteger|))
          (|pivlen| #6=(|NonNegativeInteger|)) (|k| (|Integer|)) (|len| #6#)
          (#7=#:G1073 NIL) (|pivind| (C)) (#8=#:G1031 NIL)
          (|finished?| #9=(|Boolean|)) (#10=#:G1071 NIL) (|i| NIL)
          (#11=#:G1072 NIL) (|oldr| #4#) (|sorted?| #9#) (|newr| #4#)
          (#12=#:G1070 NIL) (#13=#:G1069 NIL) (|changed?| #9#)
          (#14=#:G1068 NIL) (|LTr| (|Matrix| D)) (#15=#:G1065 NIL)
          (#16=#:G1067 NIL) (#17=#:G1066 NIL) (A ($)))
         (SEQ (LETT A (SPADCALL AA (QREFELT $ 52)))
              (LETT |LTr|
                    (SPADCALL
                     (PROGN
                      (LETT #17# (GETREFV #18=(QVELT A 1)))
                      (SEQ (LETT |i| 1) (LETT #16# #18#) (LETT #15# 0) G190
                           (COND ((|greater_SI| |i| #16#) (GO G191)))
                           (SEQ (EXIT (SETELT #17# #15# (|spadConstant| $ 9))))
                           (LETT #15#
                                 (PROG1 (|inc_SI| #15#)
                                   (LETT |i| (|inc_SI| |i|))))
                           (GO G190) G191 (EXIT NIL))
                      #17#)
                     (QREFELT $ 87)))
              (LETT |Pivs| NIL)
              (SEQ (LETT |i| 1) (LETT #14# (QVELT A 1)) G190
                   (COND ((|greater_SI| |i| #14#) (GO G191)))
                   (SEQ (LETT |r| (QAREF1O (QVELT A 3) |i| 1))
                        (LETT |changed?| NIL)
                        (SEQ G190
                             (COND
                              ((NULL
                                (COND ((NULL (QCDR |r|)) NIL)
                                      ('T
                                       (SPADCALL (|SPADfirst| (QCDR |r|))
                                                 (QREFELT $ 80)))))
                               (GO G191)))
                             (SEQ
                              (PROGN (RPLACD |r| (CDR (QCDR |r|))) (QCDR |r|))
                              (PROGN (RPLACA |r| (CDR (QCAR |r|))) (QCAR |r|))
                              (EXIT (LETT |changed?| 'T)))
                             NIL (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          (|changed?| (QSETAREF1O (QVELT A 3) |i| |r| 1)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |sorted?| NIL)
              (SEQ (LETT #13# NIL) G190 (COND (#13# (GO G191)))
                   (SEQ (LETT |sorted?| 'T)
                        (LETT |oldr| (QAREF1O (QVELT A 3) 1 1))
                        (EXIT
                         (SEQ (LETT |i| 2) (LETT #12# (QVELT A 1)) G190
                              (COND ((|greater_SI| |i| #12#) (GO G191)))
                              (SEQ (LETT |newr| (QAREF1O (QVELT A 3) |i| 1))
                                   (EXIT
                                    (COND
                                     ((|SEM;greater| |newr| |oldr| $)
                                      (SEQ
                                       (QSETAREF1O (QVELT A 3) |i| |oldr| 1)
                                       (QSETAREF1O (QVELT A 3) (- |i| 1) |newr|
                                                   1)
                                       (SPADCALL |LTr| (- |i| 1) |i|
                                                 (QREFELT $ 88))
                                       (EXIT (LETT |sorted?| NIL))))
                                     ('T (LETT |oldr| |newr|)))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT #13# |sorted?|) (GO G190) G191 (EXIT NIL))
              (LETT |finished?| NIL)
              (SEQ (LETT #11# NIL) (LETT |i| 1) (LETT #10# (QVELT A 1)) G190
                   (COND ((OR (|greater_SI| |i| #10#) #11#) (GO G191)))
                   (SEQ (LETT |r| (QAREF1O (QVELT A 3) |i| 1))
                        (LETT |finished?| (NULL (QCAR |r|)))
                        (EXIT
                         (COND
                          (|finished?|
                           (LETT |rk|
                                 (PROG1 (LETT #8# (- |i| 1))
                                   (|check_subtype2| (>= #8# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #8#))))
                          ('T
                           (SEQ (LETT |pivind| (|SPADfirst| (QCAR |r|)))
                                (LETT |pivlen| (LENGTH (QCAR |r|)))
                                (LETT |pivrow| |i|) (LETT |k| 0)
                                (SEQ (LETT |j| (+ |i| 1))
                                     (LETT #7# (QVELT A 1)) G190
                                     (COND
                                      ((OR (> |j| #7#)
                                           (NULL
                                            (COND
                                             ((NULL
                                               (QCAR
                                                (QAREF1O (QVELT A 3) |j| 1)))
                                              NIL)
                                             ('T
                                              (SPADCALL |pivind|
                                                        (|SPADfirst|
                                                         (QCAR
                                                          (QAREF1O (QVELT A 3)
                                                                   |j| 1)))
                                                        (QREFELT $ 44))))))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |len|
                                            (LENGTH
                                             (QCAR
                                              (QAREF1O (QVELT A 3) |j| 1))))
                                      (LETT |k| (+ |k| 1))
                                      (EXIT
                                       (COND
                                        ((< |len| |pivlen|)
                                         (SEQ (LETT |pivlen| |len|)
                                              (EXIT (LETT |pivrow| |j|)))))))
                                     (LETT |j| (+ |j| 1)) (GO G190) G191
                                     (EXIT NIL))
                                (LETT |piv|
                                      (|SPADfirst|
                                       (QCDR
                                        (QAREF1O (QVELT A 3) |pivrow| 1))))
                                (LETT |Pivs| (CONS |piv| |Pivs|))
                                (EXIT
                                 (COND
                                  ((> |k| 0)
                                   (SEQ
                                    (COND
                                     ((SPADCALL |pivrow| |i| (QREFELT $ 57))
                                      (SEQ
                                       (LETT |pr|
                                             (QAREF1O (QVELT A 3) |pivrow| 1))
                                       (QSETAREF1O (QVELT A 3) |pivrow|
                                                   (QAREF1O (QVELT A 3) |i| 1)
                                                   1)
                                       (QSETAREF1O (QVELT A 3) |i| |pr| 1)
                                       (EXIT
                                        (SPADCALL |LTr| |i| |pivrow|
                                                  (QREFELT $ 88))))))
                                    (LETT |pr|
                                          (CONS
                                           (CAR (QAREF1O (QVELT A 3) |i| 1))
                                           (CDR (QAREF1O (QVELT A 3) |i| 1))))
                                    (PROGN
                                     (RPLACA |pr| (CDR (QCAR |pr|)))
                                     (QCAR |pr|))
                                    (PROGN
                                     (RPLACD |pr| (CDR (QCDR |pr|)))
                                     (QCDR |pr|))
                                    (EXIT
                                     (SEQ (LETT |j| (+ |i| 1))
                                          (LETT #5# (+ |i| |k|)) G190
                                          (COND ((> |j| #5#) (GO G191)))
                                          (SEQ
                                           (LETT |r|
                                                 (CONS
                                                  (CAR
                                                   (QAREF1O (QVELT A 3)
                                                            (+ |i| 1) 1))
                                                  (CDR
                                                   (QAREF1O (QVELT A 3)
                                                            (+ |i| 1) 1))))
                                           (LETT |c| (|SPADfirst| (QCDR |r|)))
                                           (PROGN
                                            (RPLACA |r| (CDR (QCAR |r|)))
                                            (QCAR |r|))
                                           (PROGN
                                            (RPLACD |r| (CDR (QCDR |r|)))
                                            (QCDR |r|))
                                           (LETT |r|
                                                 (|SEM;addRows| |piv| |r|
                                                  (SPADCALL |c| (QREFELT $ 89))
                                                  |pr| $))
                                           (SEQ (LETT |l| 1)
                                                (LETT #3# (QVELT A 1)) G190
                                                (COND
                                                 ((|greater_SI| |l| #3#)
                                                  (GO G191)))
                                                (SEQ
                                                 (LETT |f|
                                                       (SPADCALL
                                                        (SPADCALL |piv|
                                                                  (QAREF2O
                                                                   |LTr|
                                                                   (+ |i| 1)
                                                                   |l| 1 1)
                                                                  (QREFELT $
                                                                           78))
                                                        (SPADCALL |c|
                                                                  (QAREF2O
                                                                   |LTr| |i|
                                                                   |l| 1 1)
                                                                  (QREFELT $
                                                                           78))
                                                        (QREFELT $ 90)))
                                                 (EXIT
                                                  (QSETAREF2O |LTr| (+ |i| 1)
                                                              |l| |f| 1 1)))
                                                (LETT |l| (|inc_SI| |l|))
                                                (GO G190) G191 (EXIT NIL))
                                           (SEQ (LETT |l| (+ |i| 2))
                                                (LETT #2#
                                                      (-
                                                       (+ (+ (* 2 |i|) |k|) 1)
                                                       |j|))
                                                G190
                                                (COND ((> |l| #2#) (GO G191)))
                                                (SEQ
                                                 (QSETAREF1O (QVELT A 3)
                                                             (- |l| 1)
                                                             (QAREF1O
                                                              (QVELT A 3) |l|
                                                              1)
                                                             1)
                                                 (EXIT
                                                  (SPADCALL |LTr| (- |l| 1) |l|
                                                            (QREFELT $ 88))))
                                                (LETT |l| (+ |l| 1)) (GO G190)
                                                G191 (EXIT NIL))
                                           (SEQ
                                            (LETT |l|
                                                  (- (+ (+ (* 2 |i|) |k|) 2)
                                                     |j|))
                                            (LETT #1# (QVELT A 1)) G190
                                            (COND
                                             ((OR (> |l| #1#)
                                                  (NULL
                                                   (|SEM;greater|
                                                    (QAREF1O (QVELT A 3) |l| 1)
                                                    |r| $)))
                                              (GO G191)))
                                            (SEQ
                                             (QSETAREF1O (QVELT A 3) (- |l| 1)
                                                         (QAREF1O (QVELT A 3)
                                                                  |l| 1)
                                                         1)
                                             (EXIT
                                              (SPADCALL |LTr| (- |l| 1) |l|
                                                        (QREFELT $ 88))))
                                            (LETT |l| (+ |l| 1)) (GO G190) G191
                                            (EXIT NIL))
                                           (EXIT
                                            (QSETAREF1O (QVELT A 3) (- |l| 1)
                                                        |r| 1)))
                                          (LETT |j| (+ |j| 1)) (GO G190) G191
                                          (EXIT NIL))))))))))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #11# |finished?|)))
                   (GO G190) G191 (EXIT NIL))
              (COND ((NULL |finished?|) (LETT |rk| (QVELT A 1))))
              (EXIT (VECTOR A |LTr| |Pivs| |rk|))))) 

(SDEFUN |SEM;setGcdMode;2S;28| ((|s| (|Symbol|)) ($ (|Symbol|)))
        (SPROG ((|tmp| (|Symbol|)))
               (SEQ (LETT |tmp| (QREFELT $ 14))
                    (COND
                     ((OR (EQUAL |s| '|iterated|) (EQUAL |s| '|random|))
                      (EXIT (SEQ (SETELT $ 14 |s|) (EXIT |tmp|)))))
                    (EXIT (|error| "unknown gcd mode"))))) 

(SDEFUN |SEM;randomGCD| ((|le| (|List| D)) ($ (D)))
        (SPROG
         ((|l| (|List| D)) (|tmp| (|Union| D "failed")) (#1=#:G1106 NIL)
          (|e| NIL) (|h| (D)) (|g| (D)) (#2=#:G1105 NIL) (|f| (D)))
         (SEQ
          (EXIT
           (COND
            ((EQL (LENGTH |le|) 2)
             (SPADCALL (|SPADfirst| |le|) (SPADCALL |le| (QREFELT $ 95))
                       (QREFELT $ 96)))
            (#3='T
             (SEQ (LETT |f| (|SPADfirst| |le|))
                  (LETT |g| (SPADCALL |le| (QREFELT $ 95)))
                  (LETT |l| (CDR (CDR |le|)))
                  (SEQ G190 (COND ((NULL (NULL (NULL |l|))) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (|SPADfirst| |l|) (QREFELT $ 77))
                           (PROGN
                            (LETT #2# (|spadConstant| $ 9))
                            (GO #4=#:G1104)))
                          ('T
                           (SEQ
                            (LETT |f|
                                  (SPADCALL |f|
                                            (SPADCALL (+ 1 (RANDOM 113))
                                                      (|SPADfirst| |l|)
                                                      (QREFELT $ 97))
                                            (QREFELT $ 79)))
                            (LETT |l| (CDR |l|))
                            (EXIT
                             (COND
                              ((NULL (NULL |l|))
                               (COND
                                ((SPADCALL (|SPADfirst| |l|) (QREFELT $ 77))
                                 (PROGN
                                  (LETT #2# (|spadConstant| $ 9))
                                  (GO #4#)))
                                ('T
                                 (SEQ
                                  (LETT |g|
                                        (SPADCALL |g|
                                                  (SPADCALL (+ 1 (RANDOM 113))
                                                            (|SPADfirst| |l|)
                                                            (QREFELT $ 97))
                                                  (QREFELT $ 79)))
                                  (EXIT (LETT |l| (CDR |l|))))))))))))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (LETT |h| (SPADCALL |f| |g| (QREFELT $ 96)))
                  (LETT |l| (LIST |h|))
                  (SEQ (LETT |e| NIL) (LETT #1# |le|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ (LETT |tmp| (SPADCALL |e| |h| (QREFELT $ 99)))
                            (EXIT
                             (COND
                              ((QEQCAR |tmp| 1) (LETT |l| (CONS |e| |l|))))))
                       (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (COND ((EQL (LENGTH |l|) 1) |h|)
                         (#3# (|SEM;randomGCD| |l| $))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |SEM;iteratedGCD| ((|le| (|List| D)) ($ (D)))
        (SPROG ((|l| (|List| D)) (|res| (D)))
               (SEQ
                (LETT |res|
                      (SPADCALL (|SPADfirst| |le|)
                                (SPADCALL |le| (QREFELT $ 95)) (QREFELT $ 96)))
                (LETT |l| (CDR (CDR |le|)))
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((NULL |l|) NIL)
                              ('T (NULL (SPADCALL |res| (QREFELT $ 77))))))
                       (GO G191)))
                     (SEQ
                      (LETT |res|
                            (SPADCALL |res| (|SPADfirst| |l|) (QREFELT $ 96)))
                      (EXIT (LETT |l| (CDR |l|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))) 

(SDEFUN |SEM;makePrimitive|
        ((|r| (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
         ($
          (|Record| (|:| GCD D)
                    (|:| |Row|
                         (|Record| (|:| |Indices| (|List| C))
                                   (|:| |Entries| (|List| D)))))))
        (SPROG
         ((|le| (|List| D)) (#1=#:G1118 NIL) (#2=#:G1126 NIL) (|e| NIL)
          (#3=#:G1125 NIL) (|g| (D)))
         (SEQ (LETT |le| (QCDR |r|))
              (EXIT
               (COND
                ((EQL (LENGTH |le|) 1)
                 (CONS (|SPADfirst| |le|)
                       (CONS (QCAR |r|) (LIST (|spadConstant| $ 9)))))
                (#4='T
                 (SEQ
                  (COND
                   ((EQUAL (QREFELT $ 14) '|iterated|)
                    (LETT |g| (|SEM;iteratedGCD| |le| $)))
                   (#4# (LETT |g| (|SEM;randomGCD| |le| $))))
                  (EXIT
                   (COND
                    ((SPADCALL |g| (QREFELT $ 77))
                     (CONS (|spadConstant| $ 9) |r|))
                    (#4#
                     (SEQ
                      (LETT |le|
                            (PROGN
                             (LETT #3# NIL)
                             (SEQ (LETT |e| NIL) (LETT #2# |le|) G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |e| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #3#
                                          (CONS
                                           (PROG2
                                               (LETT #1#
                                                     (SPADCALL |e| |g|
                                                               (QREFELT $ 99)))
                                               (QCDR #1#)
                                             (|check_union2| (QEQCAR #1# 0)
                                                             (QREFELT $ 7)
                                                             (|Union|
                                                              (QREFELT $ 7)
                                                              "failed")
                                                             #1#))
                                           #3#))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT (NREVERSE #3#)))))
                      (EXIT (CONS |g| (CONS (QCAR |r|) |le|)))))))))))))) 

(SDEFUN |SEM;primitiveRowEchelon;$R;32|
        ((AA ($))
         ($
          (|Record| (|:| |Ech| $) (|:| |Lt| (|Matrix| (|Fraction| D)))
                    (|:| |Pivots| (|List| D))
                    (|:| |Rank| (|NonNegativeInteger|)))))
        (SPROG
         ((|rk| (|NonNegativeInteger|)) (#1=#:G1204 NIL) (|l| NIL)
          (#2=#:G1203 NIL) (|fd| (|Fraction| D)) (#3=#:G1202 NIL)
          (|r|
           #4=(|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
          (|c| (D)) (#5=#:G1201 NIL) (|j| NIL) (|pr| #4#) (|Pivs| (|List| D))
          (|piv| (D)) (#6=#:G1200 NIL) (|q| (|Fraction| D))
          (|tmp|
           (|Record| (|:| GCD D)
                     (|:| |Row|
                          (|Record| (|:| |Indices| (|List| C))
                                    (|:| |Entries| (|List| D))))))
          (|pivrow| (|NonNegativeInteger|))
          (|pivlen| #7=(|NonNegativeInteger|)) (|k| (|Integer|)) (|len| #7#)
          (#8=#:G1199 NIL) (|pivind| (C)) (#9=#:G1152 NIL)
          (|finished?| #10=(|Boolean|)) (#11=#:G1197 NIL) (|i| NIL)
          (#12=#:G1198 NIL) (|oldr| #4#) (|sorted?| #10#) (|newr| #4#)
          (#13=#:G1196 NIL) (#14=#:G1195 NIL) (|changed?| #10#)
          (#15=#:G1194 NIL) (|LTr| (|Matrix| (|Fraction| D))) (#16=#:G1191 NIL)
          (#17=#:G1193 NIL) (#18=#:G1192 NIL) (A ($)))
         (SEQ (LETT A (SPADCALL AA (QREFELT $ 52)))
              (LETT |LTr|
                    (SPADCALL
                     (PROGN
                      (LETT #18# (GETREFV #19=(QVELT A 1)))
                      (SEQ (LETT |i| 1) (LETT #17# #19#) (LETT #16# 0) G190
                           (COND ((|greater_SI| |i| #17#) (GO G191)))
                           (SEQ
                            (EXIT (SETELT #18# #16# (|spadConstant| $ 101))))
                           (LETT #16#
                                 (PROG1 (|inc_SI| #16#)
                                   (LETT |i| (|inc_SI| |i|))))
                           (GO G190) G191 (EXIT NIL))
                      #18#)
                     (QREFELT $ 104)))
              (LETT |Pivs| NIL)
              (SEQ (LETT |i| 1) (LETT #15# (QVELT A 1)) G190
                   (COND ((|greater_SI| |i| #15#) (GO G191)))
                   (SEQ (LETT |r| (QAREF1O (QVELT A 3) |i| 1))
                        (LETT |changed?| NIL)
                        (SEQ G190
                             (COND
                              ((NULL
                                (COND ((NULL (QCDR |r|)) NIL)
                                      ('T
                                       (SPADCALL (|SPADfirst| (QCDR |r|))
                                                 (QREFELT $ 80)))))
                               (GO G191)))
                             (SEQ
                              (PROGN (RPLACD |r| (CDR (QCDR |r|))) (QCDR |r|))
                              (PROGN (RPLACA |r| (CDR (QCAR |r|))) (QCAR |r|))
                              (EXIT (LETT |changed?| 'T)))
                             NIL (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          (|changed?| (QSETAREF1O (QVELT A 3) |i| |r| 1)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |sorted?| NIL)
              (SEQ (LETT #14# NIL) G190 (COND (#14# (GO G191)))
                   (SEQ (LETT |sorted?| 'T)
                        (LETT |oldr| (QAREF1O (QVELT A 3) 1 1))
                        (EXIT
                         (SEQ (LETT |i| 2) (LETT #13# (QVELT A 1)) G190
                              (COND ((|greater_SI| |i| #13#) (GO G191)))
                              (SEQ (LETT |newr| (QAREF1O (QVELT A 3) |i| 1))
                                   (EXIT
                                    (COND
                                     ((|SEM;greater| |newr| |oldr| $)
                                      (SEQ
                                       (QSETAREF1O (QVELT A 3) |i| |oldr| 1)
                                       (QSETAREF1O (QVELT A 3) (- |i| 1) |newr|
                                                   1)
                                       (SPADCALL |LTr| (- |i| 1) |i|
                                                 (QREFELT $ 105))
                                       (EXIT (LETT |sorted?| NIL))))
                                     ('T (LETT |oldr| |newr|)))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT #14# |sorted?|) (GO G190) G191 (EXIT NIL))
              (LETT |finished?| NIL)
              (SEQ (LETT #12# NIL) (LETT |i| 1) (LETT #11# (QVELT A 1)) G190
                   (COND ((OR (|greater_SI| |i| #11#) #12#) (GO G191)))
                   (SEQ (LETT |r| (QAREF1O (QVELT A 3) |i| 1))
                        (LETT |finished?| (NULL (QCAR |r|)))
                        (EXIT
                         (COND
                          (|finished?|
                           (LETT |rk|
                                 (PROG1 (LETT #9# (- |i| 1))
                                   (|check_subtype2| (>= #9# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #9#))))
                          ('T
                           (SEQ (LETT |pivind| (|SPADfirst| (QCAR |r|)))
                                (LETT |pivlen| (LENGTH (QCAR |r|)))
                                (LETT |pivrow| |i|) (LETT |k| 0)
                                (SEQ (LETT |j| (+ |i| 1))
                                     (LETT #8# (QVELT A 1)) G190
                                     (COND
                                      ((OR (> |j| #8#)
                                           (NULL
                                            (COND
                                             ((NULL
                                               (QCAR
                                                (QAREF1O (QVELT A 3) |j| 1)))
                                              NIL)
                                             ('T
                                              (SPADCALL |pivind|
                                                        (|SPADfirst|
                                                         (QCAR
                                                          (QAREF1O (QVELT A 3)
                                                                   |j| 1)))
                                                        (QREFELT $ 44))))))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |len|
                                            (LENGTH
                                             (QCAR
                                              (QAREF1O (QVELT A 3) |j| 1))))
                                      (LETT |k| (+ |k| 1))
                                      (EXIT
                                       (COND
                                        ((< |len| |pivlen|)
                                         (SEQ (LETT |pivlen| |len|)
                                              (EXIT (LETT |pivrow| |j|)))))))
                                     (LETT |j| (+ |j| 1)) (GO G190) G191
                                     (EXIT NIL))
                                (LETT |tmp|
                                      (|SEM;makePrimitive|
                                       (QAREF1O (QVELT A 3) |pivrow| 1) $))
                                (COND
                                 ((NULL (SPADCALL (QCAR |tmp|) (QREFELT $ 77)))
                                  (SEQ
                                   (QSETAREF1O (QVELT A 3) |pivrow|
                                               (QCDR |tmp|) 1)
                                   (LETT |q|
                                         (SPADCALL (|spadConstant| $ 9)
                                                   (QCAR |tmp|)
                                                   (QREFELT $ 106)))
                                   (EXIT
                                    (SEQ (LETT |l| 1) (LETT #6# (QVELT A 1))
                                         G190
                                         (COND
                                          ((|greater_SI| |l| #6#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((NULL
                                              (SPADCALL
                                               (QAREF2O |LTr| |pivrow| |l| 1 1)
                                               (QREFELT $ 107)))
                                             (QSETAREF2O |LTr| |pivrow| |l|
                                                         (SPADCALL |q|
                                                                   (QAREF2O
                                                                    |LTr|
                                                                    |pivrow|
                                                                    |l| 1 1)
                                                                   (QREFELT $
                                                                            108))
                                                         1 1)))))
                                         (LETT |l| (|inc_SI| |l|)) (GO G190)
                                         G191 (EXIT NIL))))))
                                (LETT |piv|
                                      (|SPADfirst|
                                       (QCDR
                                        (QAREF1O (QVELT A 3) |pivrow| 1))))
                                (LETT |Pivs| (CONS |piv| |Pivs|))
                                (EXIT
                                 (COND
                                  ((> |k| 0)
                                   (SEQ
                                    (COND
                                     ((SPADCALL |pivrow| |i| (QREFELT $ 57))
                                      (SEQ
                                       (LETT |pr|
                                             (QAREF1O (QVELT A 3) |pivrow| 1))
                                       (QSETAREF1O (QVELT A 3) |pivrow|
                                                   (QAREF1O (QVELT A 3) |i| 1)
                                                   1)
                                       (QSETAREF1O (QVELT A 3) |i| |pr| 1)
                                       (EXIT
                                        (SPADCALL |LTr| |i| |pivrow|
                                                  (QREFELT $ 105))))))
                                    (LETT |pr|
                                          (CONS (CAR (QCDR |tmp|))
                                                (CDR (QCDR |tmp|))))
                                    (PROGN
                                     (RPLACA |pr| (CDR (QCAR |pr|)))
                                     (QCAR |pr|))
                                    (PROGN
                                     (RPLACD |pr| (CDR (QCDR |pr|)))
                                     (QCDR |pr|))
                                    (EXIT
                                     (SEQ (LETT |j| (+ |i| 1))
                                          (LETT #5# (+ |i| |k|)) G190
                                          (COND ((> |j| #5#) (GO G191)))
                                          (SEQ
                                           (LETT |r|
                                                 (CONS
                                                  (CAR
                                                   (QAREF1O (QVELT A 3)
                                                            (+ |i| 1) 1))
                                                  (CDR
                                                   (QAREF1O (QVELT A 3)
                                                            (+ |i| 1) 1))))
                                           (LETT |c| (|SPADfirst| (QCDR |r|)))
                                           (PROGN
                                            (RPLACA |r| (CDR (QCAR |r|)))
                                            (QCAR |r|))
                                           (PROGN
                                            (RPLACD |r| (CDR (QCDR |r|)))
                                            (QCDR |r|))
                                           (LETT |r|
                                                 (|SEM;addRows| |piv| |r|
                                                  (SPADCALL |c| (QREFELT $ 89))
                                                  |pr| $))
                                           (SEQ (LETT |l| 1)
                                                (LETT #3# (QVELT A 1)) G190
                                                (COND
                                                 ((|greater_SI| |l| #3#)
                                                  (GO G191)))
                                                (SEQ
                                                 (LETT |fd|
                                                       (SPADCALL
                                                        (SPADCALL |piv|
                                                                  (QAREF2O
                                                                   |LTr|
                                                                   (+ |i| 1)
                                                                   |l| 1 1)
                                                                  (QREFELT $
                                                                           109))
                                                        (SPADCALL |c|
                                                                  (QAREF2O
                                                                   |LTr| |i|
                                                                   |l| 1 1)
                                                                  (QREFELT $
                                                                           109))
                                                        (QREFELT $ 110)))
                                                 (EXIT
                                                  (QSETAREF2O |LTr| (+ |i| 1)
                                                              |l| |fd| 1 1)))
                                                (LETT |l| (|inc_SI| |l|))
                                                (GO G190) G191 (EXIT NIL))
                                           (SEQ (LETT |l| (+ |i| 2))
                                                (LETT #2#
                                                      (-
                                                       (+ (+ (* 2 |i|) |k|) 1)
                                                       |j|))
                                                G190
                                                (COND ((> |l| #2#) (GO G191)))
                                                (SEQ
                                                 (QSETAREF1O (QVELT A 3)
                                                             (- |l| 1)
                                                             (QAREF1O
                                                              (QVELT A 3) |l|
                                                              1)
                                                             1)
                                                 (EXIT
                                                  (SPADCALL |LTr| (- |l| 1) |l|
                                                            (QREFELT $ 105))))
                                                (LETT |l| (+ |l| 1)) (GO G190)
                                                G191 (EXIT NIL))
                                           (SEQ
                                            (LETT |l|
                                                  (- (+ (+ (* 2 |i|) |k|) 2)
                                                     |j|))
                                            (LETT #1# (QVELT A 1)) G190
                                            (COND
                                             ((OR (> |l| #1#)
                                                  (NULL
                                                   (|SEM;greater|
                                                    (QAREF1O (QVELT A 3) |l| 1)
                                                    |r| $)))
                                              (GO G191)))
                                            (SEQ
                                             (QSETAREF1O (QVELT A 3) (- |l| 1)
                                                         (QAREF1O (QVELT A 3)
                                                                  |l| 1)
                                                         1)
                                             (EXIT
                                              (SPADCALL |LTr| (- |l| 1) |l|
                                                        (QREFELT $ 105))))
                                            (LETT |l| (+ |l| 1)) (GO G190) G191
                                            (EXIT NIL))
                                           (EXIT
                                            (QSETAREF1O (QVELT A 3) (- |l| 1)
                                                        |r| 1)))
                                          (LETT |j| (+ |j| 1)) (GO G190) G191
                                          (EXIT NIL))))))))))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #12# |finished?|)))
                   (GO G190) G191 (EXIT NIL))
              (COND ((NULL |finished?|) (LETT |rk| (QVELT A 1))))
              (EXIT (VECTOR A |LTr| |Pivs| |rk|))))) 

(SDEFUN |SEM;*;M2$;33| ((LM (|Matrix| D)) (AA ($)) ($ ($)))
        (SPROG
         ((|r|
           (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
          (#1=#:G1233 NIL) (|k| NIL) (#2=#:G1232 NIL) (#3=#:G1231 NIL)
          (|inds| (|List| C)) (#4=#:G1230 NIL) (|i| NIL) (|tmp| (|Vector| D))
          (#5=#:G1229 NIL) (|c| NIL) (|res| ($))
          (|rlen| (|NonNegativeInteger|)) (A ($)))
         (SEQ
          (COND
           ((SPADCALL (ANCOLS LM) (QVELT AA 1) (QREFELT $ 57))
            (|error| "improper matrix dimensions"))
           ('T
            (SEQ (LETT A (SPADCALL AA (QREFELT $ 52)))
                 (LETT |rlen| (ANROWS LM))
                 (LETT |res| (SPADCALL (QVELT A 2) |rlen| (QREFELT $ 32)))
                 (SEQ (LETT |c| NIL) (LETT #5# (QVELT A 2)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |c| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ (LETT |tmp| (MAKEARR1 |rlen| (|spadConstant| $ 34)))
                           (SEQ (LETT |i| 1) (LETT #4# (QVELT A 1)) G190
                                (COND ((|greater_SI| |i| #4#) (GO G191)))
                                (SEQ (LETT |r| (QAREF1O (QVELT A 3) |i| 1))
                                     (LETT |inds| (QCAR |r|))
                                     (EXIT
                                      (COND
                                       ((NULL (NULL |inds|))
                                        (COND
                                         ((SPADCALL (|SPADfirst| |inds|) |c|
                                                    (QREFELT $ 44))
                                          (SEQ
                                           (SEQ (LETT |k| 1) (LETT #3# |rlen|)
                                                G190
                                                (COND
                                                 ((|greater_SI| |k| #3#)
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (COND
                                                   ((NULL
                                                     (SPADCALL
                                                      (QAREF2O LM |k| |i| 1 1)
                                                      (QREFELT $ 80)))
                                                    (QSETAREF1O |tmp| |k|
                                                                (SPADCALL
                                                                 (QAREF1O |tmp|
                                                                          |k|
                                                                          1)
                                                                 (SPADCALL
                                                                  (QAREF2O LM
                                                                           |k|
                                                                           |i|
                                                                           1 1)
                                                                  (|SPADfirst|
                                                                   (QCDR |r|))
                                                                  (QREFELT $
                                                                           78))
                                                                 (QREFELT $
                                                                          79))
                                                                1)))))
                                                (LETT |k| (|inc_SI| |k|))
                                                (GO G190) G191 (EXIT NIL))
                                           (PROGN
                                            (RPLACD |r| (CDR (QCDR |r|)))
                                            (QCDR |r|))
                                           (PROGN
                                            (RPLACA |r| (CDR |inds|))
                                            (QCAR |r|))
                                           (EXIT
                                            (QSETAREF1O (QVELT A 3) |i| |r|
                                                        1)))))))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #2# |rlen|) G190
                                 (COND ((|greater_SI| |k| #2#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((NULL
                                      (SPADCALL (QAREF1O |tmp| |k| 1)
                                                (QREFELT $ 80)))
                                     (SEQ
                                      (LETT |r|
                                            (QAREF1O (QVELT |res| 3) |k| 1))
                                      (PROGN
                                       (RPLACA |r| (CONS |c| (QCAR |r|)))
                                       (QCAR |r|))
                                      (PROGN
                                       (RPLACD |r|
                                               (CONS (QAREF1O |tmp| |k| 1)
                                                     (QCDR |r|)))
                                       (QCDR |r|))
                                      (EXIT
                                       (QSETAREF1O (QVELT |res| 3) |k| |r|
                                                   1)))))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (SEQ (LETT |k| 1) (LETT #1# |rlen|) G190
                      (COND ((|greater_SI| |k| #1#) (GO G191)))
                      (SEQ (LETT |r| (QAREF1O (QVELT |res| 3) |k| 1))
                           (PROGN
                            (RPLACA |r| (NREVERSE (QCAR |r|)))
                            (QCAR |r|))
                           (PROGN
                            (RPLACD |r| (NREVERSE (QCDR |r|)))
                            (QCDR |r|))
                           (EXIT (QSETAREF1O (QVELT |res| 3) |k| |r| 1)))
                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                 (EXIT |res|))))))) 

(SDEFUN |SEM;mult| ((|f| (|Fraction| D)) (|d| (D)) ($ (D)))
        (SPROG ((|tmp| (|Union| D "failed")) (|res| (D)))
               (SEQ
                (LETT |res|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 114)) |d|
                                (QREFELT $ 78)))
                (LETT |tmp|
                      (SPADCALL |res| (SPADCALL |f| (QREFELT $ 115))
                                (QREFELT $ 99)))
                (EXIT
                 (COND ((QEQCAR |tmp| 1) (|error| "cannot divide in mult"))
                       ('T (QCDR |tmp|))))))) 

(SDEFUN |SEM;*;M2$;35| ((LM (|Matrix| (|Fraction| D))) (AA ($)) ($ ($)))
        (SPROG
         ((|r|
           (|Record| (|:| |Indices| (|List| C)) (|:| |Entries| (|List| D))))
          (#1=#:G1271 NIL) (|k| NIL) (|d| (|Union| D "failed"))
          (#2=#:G1270 NIL) (#3=#:G1269 NIL) (|inds| (|List| C))
          (#4=#:G1268 NIL) (|i| NIL) (|tmp| (|Vector| (|Fraction| D)))
          (#5=#:G1267 NIL) (|c| NIL) (|res| ($))
          (|rlen| (|NonNegativeInteger|)) (A ($)))
         (SEQ
          (COND
           ((SPADCALL (ANCOLS LM) (QVELT AA 1) (QREFELT $ 57))
            (|error| "improper matrix dimensions"))
           ('T
            (SEQ (LETT A (SPADCALL AA (QREFELT $ 52)))
                 (LETT |rlen| (ANROWS LM))
                 (LETT |res| (SPADCALL (QVELT A 2) |rlen| (QREFELT $ 32)))
                 (SEQ (LETT |c| NIL) (LETT #5# (QVELT A 2)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |c| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (LETT |tmp| (MAKEARR1 |rlen| (|spadConstant| $ 116)))
                       (SEQ (LETT |i| 1) (LETT #4# (QVELT A 1)) G190
                            (COND ((|greater_SI| |i| #4#) (GO G191)))
                            (SEQ (LETT |r| (QAREF1O (QVELT A 3) |i| 1))
                                 (LETT |inds| (QCAR |r|))
                                 (EXIT
                                  (COND
                                   ((NULL (NULL |inds|))
                                    (COND
                                     ((SPADCALL (|SPADfirst| |inds|) |c|
                                                (QREFELT $ 44))
                                      (SEQ
                                       (SEQ (LETT |k| 1) (LETT #3# |rlen|) G190
                                            (COND
                                             ((|greater_SI| |k| #3#)
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL
                                                  (QAREF2O LM |k| |i| 1 1)
                                                  (QREFELT $ 107)))
                                                (QSETAREF1O |tmp| |k|
                                                            (SPADCALL
                                                             (QAREF1O |tmp| |k|
                                                                      1)
                                                             (SPADCALL
                                                              (QAREF2O LM |k|
                                                                       |i| 1 1)
                                                              (|SPADfirst|
                                                               (QCDR |r|))
                                                              (QREFELT $ 117))
                                                             (QREFELT $ 118))
                                                            1)))))
                                            (LETT |k| (|inc_SI| |k|)) (GO G190)
                                            G191 (EXIT NIL))
                                       (PROGN
                                        (RPLACD |r| (CDR (QCDR |r|)))
                                        (QCDR |r|))
                                       (PROGN
                                        (RPLACA |r| (CDR |inds|))
                                        (QCAR |r|))
                                       (EXIT
                                        (QSETAREF1O (QVELT A 3) |i| |r|
                                                    1)))))))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (EXIT
                        (SEQ (LETT |k| 1) (LETT #2# |rlen|) G190
                             (COND ((|greater_SI| |k| #2#) (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((NULL
                                  (SPADCALL (QAREF1O |tmp| |k| 1)
                                            (QREFELT $ 107)))
                                 (SEQ
                                  (LETT |d|
                                        (SPADCALL (QAREF1O |tmp| |k| 1)
                                                  (QREFELT $ 120)))
                                  (EXIT
                                   (COND
                                    ((QEQCAR |d| 1)
                                     (|error| "cannot divide in *"))
                                    ('T
                                     (SEQ
                                      (LETT |r|
                                            (QAREF1O (QVELT |res| 3) |k| 1))
                                      (PROGN
                                       (RPLACA |r| (CONS |c| (QCAR |r|)))
                                       (QCAR |r|))
                                      (PROGN
                                       (RPLACD |r|
                                               (CONS (QCDR |d|) (QCDR |r|)))
                                       (QCDR |r|))
                                      (EXIT
                                       (QSETAREF1O (QVELT |res| 3) |k| |r|
                                                   1)))))))))))
                             (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                             (EXIT NIL))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (SEQ (LETT |k| 1) (LETT #1# |rlen|) G190
                      (COND ((|greater_SI| |k| #1#) (GO G191)))
                      (SEQ (LETT |r| (QAREF1O (QVELT |res| 3) |k| 1))
                           (PROGN
                            (RPLACA |r| (NREVERSE (QCAR |r|)))
                            (QCAR |r|))
                           (PROGN
                            (RPLACD |r| (NREVERSE (QCDR |r|)))
                            (QCDR |r|))
                           (EXIT (QSETAREF1O (QVELT |res| 3) |k| |r| 1)))
                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                 (EXIT |res|))))))) 

(DECLAIM (NOTINLINE |SparseEchelonMatrix;|)) 

(DEFUN |SparseEchelonMatrix| (&REST #1=#:G1273)
  (SPROG NIL
         (PROG (#2=#:G1274)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SparseEchelonMatrix|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SparseEchelonMatrix;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|SparseEchelonMatrix|)))))))))) 

(DEFUN |SparseEchelonMatrix;| (|#1| |#2|)
  (SPROG
   ((|i| NIL) (#1=#:G1272 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL)
    (DV$1 NIL))
   (SEQ
    (PROGN
     (LETT DV$1 (|devaluate| |#1|))
     (LETT DV$2 (|devaluate| |#2|))
     (LETT |dv$| (LIST '|SparseEchelonMatrix| DV$1 DV$2))
     (LETT $ (GETREFV 122))
     (QSETREFV $ 0 |dv$|)
     (QSETREFV $ 3
               (LETT |pv$|
                     (|buildPredVector| 0 0
                                        (LIST
                                         (|HasCategory| |#2| '(|GcdDomain|))
                                         (|HasCategory| |#2|
                                                        '(|IntegralDomain|))))))
     (|haddProp| |$ConstructorCache| '|SparseEchelonMatrix| (LIST DV$1 DV$2)
                 (CONS 1 $))
     (|stuffDomainSlots| $)
     (QSETREFV $ 6 |#1|)
     (QSETREFV $ 7 |#2|)
     (SETF |pv$| (QREFELT $ 3))
     (QSETREFV $ 8
               (PROGN
                (PROGN
                 (LETT #1# NIL)
                 (SEQ (LETT |i| 1) G190 (COND ((|greater_SI| |i| 1) (GO G191)))
                      (SEQ (EXIT (LETT #1# (CONS |i| #1#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #1#))))
                1))
     (QSETREFV $ 10 (- (QREFELT $ 8) 1))
     (QSETREFV $ 11 (CONS NIL NIL))
     (QSETREFV $ 12 (|HasCategory| |#2| '(|lazyRepresentation|)))
     (QSETREFV $ 13 113)
     (QSETREFV $ 14 '|iterated|)
     (QSETREFV $ 17
               (|Record| (|:| |NCols| (|NonNegativeInteger|))
                         (|:| |NRows| (|NonNegativeInteger|))
                         (|:| |AllInds| (|List| |#1|))
                         (|:| |Rows|
                              (|Vector|
                               (|Record| (|:| |Indices| (|List| |#1|))
                                         (|:| |Entries| (|List| |#2|)))))))
     (COND
      ((|testBitVector| |pv$| 1)
       (PROGN
        (QSETREFV $ 94 (CONS (|dispatchFunction| |SEM;setGcdMode;2S;28|) $))
        (QSETREFV $ 112
                  (CONS (|dispatchFunction| |SEM;primitiveRowEchelon;$R;32|)
                        $)))))
     (COND
      ((|testBitVector| |pv$| 2)
       (PROGN (QSETREFV $ 121 (CONS (|dispatchFunction| |SEM;*;M2$;35|) $)))))
     $)))) 

(MAKEPROP '|SparseEchelonMatrix| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|minInd|
              (0 . |One|) '|offset| '|emptyRec| '|noChecks?| '|seed| '|GCDmode|
              (|Boolean|) (4 . <) '|Rep| (|NonNegativeInteger|)
              |SEM;ncols;$Nni;2| |SEM;nrows;$Nni;3| (|List| 6) (10 . |copy|)
              |SEM;allIndices;$L;4|
              (|Record| (|:| |Indices| 21) (|:| |Entries| 30)) (|Integer|)
              |SEM;row;$IR;5| (|Void|) (15 . |void|) |SEM;setRow!;$IRV;6|
              (|List| 7) |SEM;setRow!;$ILLV;7| |SEM;new;LI$;8|
              (19 . |position|) (25 . |Zero|) (29 . |qelt|) |SEM;elt;$ICD;9|
              (35 . |qsetelt!|) (42 . |insert!|) (49 . |insert!|)
              |SEM;setelt!;$ICDV;10| (|List| 24) (|Vector| 24) (56 . |entries|)
              (61 . =) (|Matrix| 7) |SEM;coerce;$M;11| (|OutputForm|)
              (67 . |coerce|) (72 . |coerce|) |SEM;coerce;$Of;12| (77 . |copy|)
              |SEM;copy;2$;13| (|Mapping| 15 6 6) (82 . |merge!|)
              (89 . |removeDuplicates!|) |SEM;elimZeroCols!;$V;14| (94 . ~=)
              (|Mapping| 15 6) |SEM;purge!;$MV;15| |SEM;sortedPurge!;$MV;16|
              |SEM;deleteRow!;$IV;17| (100 . |construct|)
              (105 . |setDifference|) (111 . |sort!|) (117 . |merge|)
              |SEM;consRow!;$RV;18| (124 . |concat|) |SEM;appendRow!;$RV;19|
              |SEM;extract;$2I$;20| |SEM;join;3$;21| (130 . |append|)
              (136 . |append|) |SEM;horizJoin;3$;22| (142 . >)
              (|Record| (|:| |Left| $) (|:| |Right| $)) |SEM;horizSplit;$CR;23|
              (148 . |one?|) (153 . *) (159 . +) (165 . |zero?|)
              (170 . |concat!|) (176 . |concat!|)
              (|Record| (|:| |Index| 6) (|:| |Entry| 7)) |SEM;pivot;$IR;25|
              |SEM;pivots;$R;26| (|Vector| 7) (182 . |diagonalMatrix|)
              (187 . |swapRows!|) (194 . -) (199 . -)
              (|Record| (|:| |Ech| $) (|:| |Lt| 45) (|:| |Pivots| 30)
                        (|:| |Rank| 18))
              |SEM;rowEchelon;$R;27| (|Symbol|) (205 . |setGcdMode|)
              (210 . |second|) (215 . |gcd|) (221 . *) (|Union| $ '"failed")
              (227 . |exquo|) (|Fraction| 7) (233 . |One|) (|Vector| 100)
              (|Matrix| 100) (237 . |diagonalMatrix|) (242 . |swapRows!|)
              (249 . /) (255 . |zero?|) (260 . *) (266 . *) (272 . -)
              (|Record| (|:| |Ech| $) (|:| |Lt| 103) (|:| |Pivots| 30)
                        (|:| |Rank| 18))
              (278 . |primitiveRowEchelon|) |SEM;*;M2$;33| (283 . |numer|)
              (288 . |denom|) (293 . |Zero|) (297 . *) (303 . +)
              (|Union| 7 '"failed") (309 . |retractIfCan|) (314 . *))
           '#(|sortedPurge!| 320 |setelt!| 326 |setRow!| 334 |setGcdMode| 349
              |rowEchelon| 354 |row| 359 |purge!| 365 |primitiveRowEchelon| 371
              |pivots| 376 |pivot| 381 |nrows| 387 |new| 392 |ncols| 398 |join|
              403 |horizSplit| 409 |horizJoin| 415 |extract| 421 |elt| 428
              |elimZeroCols!| 435 |deleteRow!| 440 |copy| 446 |consRow!| 451
              |coerce| 457 |appendRow!| 467 |allIndices| 473 * 478)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(NIL NIL NIL)
                       (CONS
                        '#((|CoercibleTo| 47) (|shallowlyMutable|)
                           (|finiteAggregate|))
                        (|makeByteWordVec2| 121
                                            '(0 7 0 9 2 6 15 0 0 16 1 21 0 0 22
                                              0 27 0 28 2 21 25 6 0 33 0 7 0 34
                                              2 30 7 0 25 35 3 30 7 0 25 7 37 3
                                              21 0 6 0 25 38 3 30 0 7 0 25 39 1
                                              42 41 0 43 2 6 15 0 0 44 1 7 47 0
                                              48 1 45 47 0 49 1 30 0 0 51 3 21
                                              0 53 0 0 54 1 21 0 0 55 2 18 15 0
                                              0 57 1 42 0 41 62 2 21 0 0 0 63 2
                                              21 0 53 0 64 3 21 0 53 0 0 65 2
                                              41 0 0 24 67 2 21 0 0 0 71 2 30 0
                                              0 0 72 2 6 15 0 0 74 1 7 15 0 77
                                              2 7 0 0 0 78 2 7 0 0 0 79 1 7 15
                                              0 80 2 21 0 0 0 81 2 30 0 0 0 82
                                              1 45 0 86 87 3 45 0 0 25 25 88 1
                                              7 0 0 89 2 7 0 0 0 90 1 0 93 93
                                              94 1 30 7 0 95 2 7 0 0 0 96 2 7 0
                                              25 0 97 2 7 98 0 0 99 0 100 0 101
                                              1 103 0 102 104 3 103 0 0 25 25
                                              105 2 100 0 7 7 106 1 100 15 0
                                              107 2 100 0 0 0 108 2 100 0 7 0
                                              109 2 100 0 0 0 110 1 0 111 0 112
                                              1 100 7 0 114 1 100 7 0 115 0 100
                                              0 116 2 100 0 0 7 117 2 100 0 0 0
                                              118 1 100 119 0 120 2 0 0 103 0
                                              121 2 0 27 0 58 60 4 0 27 0 25 6
                                              7 40 4 0 27 0 25 21 30 31 3 0 27
                                              0 25 24 29 1 1 93 93 94 1 0 91 0
                                              92 2 0 24 0 25 26 2 0 27 0 58 59
                                              1 1 111 0 112 1 0 24 0 85 2 0 83
                                              0 25 84 1 0 18 0 20 2 0 0 21 25
                                              32 1 0 18 0 19 2 0 0 0 0 70 2 0
                                              75 0 6 76 2 0 0 0 0 73 3 0 0 0 25
                                              25 69 3 0 7 0 25 6 36 1 0 27 0 56
                                              2 0 27 0 25 61 1 0 0 0 52 2 0 27
                                              0 24 66 1 0 47 0 50 1 0 45 0 46 2
                                              0 27 0 24 68 1 0 21 0 23 2 2 0
                                              103 0 121 2 0 0 45 0 113)))))
           '|lookupComplete|)) 


(SDEFUN |IRSN;aIdInverse| (($ (|Void|)))
        (SPROG
         ((#1=#:G845 NIL) (#2=#:G783 NIL) (#3=#:G760 NIL) (|i| NIL)
          (#4=#:G856 NIL) (|k| NIL) (#5=#:G746 NIL) (#6=#:G730 NIL) (|j| NIL)
          (#7=#:G855 NIL) (|l| NIL) (#8=#:G854 NIL)
          (|idperm| (|List| (|Integer|))) (#9=#:G852 NIL) (#10=#:G853 NIL))
         (SEQ
          (EXIT
           (SEQ (SETELT $ 13 (MAKE_MATRIX1 (QREFELT $ 7) (QREFELT $ 7) 0))
                (SEQ (LETT |k| 1) (LETT #10# (QREFELT $ 7)) G190
                     (COND ((|greater_SI| |k| #10#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL (QREFELT $ 13) |k| |k| 1 (QREFELT $ 16))))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((< (QREFELT $ 10) 5)
                  (PROGN (LETT #9# (QREFELT $ 13)) (GO #11=#:G851))))
                (LETT |idperm| NIL)
                (SEQ (LETT |k| (QREFELT $ 10)) G190
                     (COND ((< |k| 1) (GO G191)))
                     (SEQ (EXIT (LETT |idperm| (CONS |k| |idperm|))))
                     (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                (SEQ (LETT |k| 1) (LETT #8# (- (QREFELT $ 7) 1)) G190
                     (COND ((|greater_SI| |k| #8#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |l| (+ |k| 1)) (LETT #7# (QREFELT $ 7)) G190
                            (COND ((> |l| #7#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL (QREFELT $ 13) |k| |l|
                                        (|IRSN;signum| |k| |l| |idperm| $)
                                        (QREFELT $ 16))))
                            (LETT |l| (+ |l| 1)) (GO G190) G191 (EXIT NIL))))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                (EXIT
                 (SEQ (LETT |j| (QREFELT $ 7)) G190
                      (COND ((< |j| 2) (GO G191)))
                      (SEQ
                       (SEQ (LETT |i| (- |j| 1)) G190
                            (COND ((< |i| 1) (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL (QREFELT $ 13)
                                        (PROG1 (LETT #6# |i|)
                                          (|check_subtype2| (>= #6# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #6#))
                                        |j|
                                        (-
                                         (SPADCALL (QREFELT $ 13)
                                                   (PROG1 (LETT #5# |i|)
                                                     (|check_subtype2|
                                                      (>= #5# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #5#))
                                                   |j| (QREFELT $ 17)))
                                        (QREFELT $ 16))))
                            (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (SEQ (LETT |k| (+ |j| 1)) (LETT #4# (QREFELT $ 7)) G190
                             (COND ((> |k| #4#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |i| (- |j| 1)) G190
                                    (COND ((< |i| 1) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (SPADCALL (QREFELT $ 13)
                                                (PROG1 (LETT #3# |i|)
                                                  (|check_subtype2| (>= #3# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #3#))
                                                |k|
                                                (+
                                                 (SPADCALL (QREFELT $ 13)
                                                           (PROG1
                                                               (LETT #2# |i|)
                                                             (|check_subtype2|
                                                              (>= #2# 0)
                                                              '(|NonNegativeInteger|)
                                                              '(|Integer|)
                                                              #2#))
                                                           |k| (QREFELT $ 17))
                                                 (*
                                                  (SPADCALL (QREFELT $ 13)
                                                            (PROG1
                                                                (LETT #1# |i|)
                                                              (|check_subtype2|
                                                               (>= #1# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #1#))
                                                            |j| (QREFELT $ 17))
                                                  (SPADCALL (QREFELT $ 13) |j|
                                                            |k|
                                                            (QREFELT $ 17))))
                                                (QREFELT $ 16))))
                                    (LETT |i| (+ |i| -1)) (GO G190) G191
                                    (EXIT NIL))))
                             (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))))
                      (LETT |j| (+ |j| -1)) (GO G190) G191 (EXIT NIL)))))
          #11# (EXIT #9#)))) 

(SDEFUN |IRSN;alreadyComputed?|
        ((|lambda| (|List| #1=(|Integer|))) ($ (|Void|)))
        (SPROG
         ((#2=#:G865 NIL) (#3=#:G863 NIL) (#4=#:G862 #1#) (#5=#:G864 #1#)
          (#6=#:G868 NIL) (#7=#:G689 NIL) (#8=#:G858 NIL) (#9=#:G857 NIL))
         (SEQ
          (COND
           ((NULL (SPADCALL |lambda| (QREFELT $ 6) (QREFELT $ 20)))
            (SEQ (SETELT $ 6 |lambda|)
                 (SETELT $ 9 (SPADCALL |lambda| (QREFELT $ 22)))
                 (SETELT $ 11
                         (PROG1 (LETT #9# (|SPADfirst| (QREFELT $ 9)))
                           (|check_subtype2| (>= #9# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #9#)))
                 (SETELT $ 12
                         (PROG1 (LETT #8# (|SPADfirst| |lambda|))
                           (|check_subtype2| (>= #8# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #8#)))
                 (SETELT $ 10
                         (PROG1
                             (LETT #2#
                                   (PROGN
                                    (LETT #3# NIL)
                                    (SEQ (LETT #7# NIL) (LETT #6# |lambda|)
                                         G190
                                         (COND
                                          ((OR (ATOM #6#)
                                               (PROGN
                                                (LETT #7# (CAR #6#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (PROGN
                                            (LETT #5# #7#)
                                            (COND (#3# (LETT #4# (+ #4# #5#)))
                                                  ('T
                                                   (PROGN
                                                    (LETT #4# #5#)
                                                    (LETT #3# 'T)))))))
                                         (LETT #6# (CDR #6#)) (GO G190) G191
                                         (EXIT NIL))
                                    (COND (#3# #4#) ('T 0))))
                           (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #2#)))
                 (SETELT $ 8 (SPADCALL |lambda| (QREFELT $ 25)))
                 (SETELT $ 7 (LENGTH (QREFELT $ 8)))
                 (EXIT (|IRSN;aIdInverse| $)))))))) 

(SDEFUN |IRSN;listPermutation|
        ((|pi| (|Permutation| (|Integer|))) ($ (|List| (|Integer|))))
        (SPROG ((|li| (|List| (|Integer|))) (|k| NIL))
               (SEQ (LETT |li| NIL)
                    (SEQ (LETT |k| (QREFELT $ 10)) G190
                         (COND ((< |k| 1) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |li|
                                 (CONS (SPADCALL |pi| |k| (QREFELT $ 27))
                                       |li|))))
                         (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                    (EXIT |li|)))) 

(SDEFUN |IRSN;signum|
        ((|numberOfRowTableau| (|NonNegativeInteger|))
         (|numberOfColumnTableau| (|NonNegativeInteger|))
         (|pi| (|List| (|Integer|))) ($ (|Integer|)))
        (SPROG
         ((|k| #1=(|NonNegativeInteger|)) (|l| #1#) (|end| #2=(|Boolean|))
          (|sign| (|Integer|)) (|z| #1#) (|swap| (|Integer|)) (|endk| #2#)
          (|ctrl| #2#) (|s| #1#) (|columntab| #3=(|Matrix| (|Integer|)))
          (|rowtab| #3#))
         (SEQ
          (LETT |rowtab|
                (SPADCALL
                 (SPADCALL (QREFELT $ 8) |numberOfRowTableau| (QREFELT $ 28))
                 (QREFELT $ 29)))
          (LETT |columntab|
                (SPADCALL
                 (SPADCALL (QREFELT $ 8) |numberOfColumnTableau|
                           (QREFELT $ 28))
                 (QREFELT $ 29)))
          (LETT |sign| 1) (LETT |end| NIL) (LETT |k| 1)
          (SEQ G190
               (COND
                ((NULL (COND ((<= |k| (QREFELT $ 11)) (NULL |end|)) ('T NIL)))
                 (GO G191)))
               (SEQ (LETT |l| 1)
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND
                             ((<= |l|
                                  (SPADCALL (QREFELT $ 6) |k| (QREFELT $ 30)))
                              (NULL |end|))
                             ('T NIL)))
                           (GO G191)))
                         (SEQ (LETT |z| |l|) (LETT |endk| NIL)
                              (SEQ G190
                                   (COND
                                    ((NULL
                                      (COND
                                       ((<= |z|
                                            (SPADCALL (QREFELT $ 6) |k|
                                                      (QREFELT $ 30)))
                                        (NULL |endk|))
                                       ('T NIL)))
                                     (GO G191)))
                                   (SEQ (LETT |s| |k|) (LETT |ctrl| 'T)
                                        (SEQ G190
                                             (COND ((NULL |ctrl|) (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((<= |s|
                                                     (SPADCALL (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 30)))
                                                 (COND
                                                  ((EQL
                                                    (+ 1
                                                       (SPADCALL |rowtab| |k|
                                                                 |z|
                                                                 (QREFELT $
                                                                          17)))
                                                    (SPADCALL |pi|
                                                              (+ 1
                                                                 (SPADCALL
                                                                  |columntab|
                                                                  |s| |l|
                                                                  (QREFELT $
                                                                           17)))
                                                              (QREFELT $ 30)))
                                                   (LETT |ctrl| NIL))
                                                  ('T (LETT |s| (+ |s| 1)))))
                                                ('T (LETT |ctrl| NIL)))))
                                             NIL (GO G190) G191 (EXIT NIL))
                                        (LETT |endk|
                                              (<= |s|
                                                  (SPADCALL (QREFELT $ 9) |l|
                                                            (QREFELT $ 30))))
                                        (EXIT
                                         (COND
                                          (|endk|
                                           (SEQ
                                            (COND
                                             ((< |k| |s|)
                                              (SEQ (LETT |sign| (- |sign|))
                                                   (LETT |swap|
                                                         (SPADCALL |columntab|
                                                                   |s| |l|
                                                                   (QREFELT $
                                                                            17)))
                                                   (SPADCALL |columntab| |s|
                                                             |l|
                                                             (SPADCALL
                                                              |columntab| |k|
                                                              |l|
                                                              (QREFELT $ 17))
                                                             (QREFELT $ 16))
                                                   (EXIT
                                                    (SPADCALL |columntab| |k|
                                                              |l| |swap|
                                                              (QREFELT $
                                                                       16))))))
                                            (EXIT
                                             (COND
                                              ((< |l| |z|)
                                               (SEQ
                                                (LETT |swap|
                                                      (SPADCALL |rowtab| |k|
                                                                |z|
                                                                (QREFELT $
                                                                         17)))
                                                (SPADCALL |rowtab| |k| |z|
                                                          (SPADCALL |rowtab|
                                                                    |k| |l|
                                                                    (QREFELT $
                                                                             17))
                                                          (QREFELT $ 16))
                                                (EXIT
                                                 (SPADCALL |rowtab| |k| |l|
                                                           |swap|
                                                           (QREFELT $
                                                                    16)))))))))
                                          ('T (LETT |z| (+ |z| 1))))))
                                   NIL (GO G190) G191 (EXIT NIL))
                              (COND
                               ((> |z|
                                   (SPADCALL (QREFELT $ 6) |k| (QREFELT $ 30)))
                                (SEQ (LETT |sign| 0) (EXIT (LETT |end| 'T)))))
                              (EXIT (LETT |l| (+ |l| 1))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (LETT |k| (+ |k| 1))))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT |sign|)))) 

(SDEFUN |IRSN;sumPartition|
        ((|lambda| (|List| (|Integer|))) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G907 NIL) (|prev| (|Integer|)) (|ok| (|Boolean|))
          (|sum| (|Integer|)) (#2=#:G910 NIL) (|x| NIL))
         (SEQ (LETT |ok| 'T) (LETT |prev| (|SPADfirst| |lambda|))
              (LETT |sum| 0)
              (SEQ (LETT |x| NIL) (LETT #2# |lambda|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |sum| (+ |sum| |x|))
                        (LETT |ok| (COND (|ok| (>= |prev| |x|)) ('T NIL)))
                        (EXIT (LETT |prev| |x|)))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (COND ((NULL |ok|) (|error| "No proper partition ")))
              (EXIT
               (PROG1 (LETT #1# |sum|)
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))))) 

(SDEFUN |IRSN;testPermutation|
        ((|pi| (|List| (|Integer|))) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G920 NIL) (#2=#:G924 NIL) (|i| NIL)
          (|test| (|Vector| (|Boolean|))) (#3=#:G916 NIL) (|ok| (|Boolean|))
          (#4=#:G923 NIL))
         (SEQ (LETT |ok| 'T) (SETELT $ 10 0)
              (SEQ (LETT |i| NIL) (LETT #4# |pi|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |i| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (COND ((> |i| (QREFELT $ 10)) (SETELT $ 10 |i|)))
                        (EXIT (COND ((< |i| 1) (LETT |ok| NIL)))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (COND
               ((EQL (QREFELT $ 10) (LENGTH |pi|))
                (COND ((NULL |ok|) (|error| #5="No permutation of 1,2,..,n"))))
               ('T (|error| #5#)))
              (LETT |test|
                    (MAKEARR1
                     (PROG1 (LETT #3# (QREFELT $ 10))
                       (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #3#))
                     NIL))
              (SEQ (LETT |i| NIL) (LETT #2# |pi|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (SPADCALL |test| |i| 'T (QREFELT $ 32))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (COND
               ((SPADCALL NIL |test| (QREFELT $ 33))
                (|error| "No permutation")))
              (EXIT
               (PROG1 (LETT #1# (QREFELT $ 10))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))))) 

(SDEFUN |IRSN;dimensionOfIrreducibleRepresentation;LNni;7|
        ((|lambda| (|List| (|Integer|))) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G929 NIL) (|dd| (|Integer|)) (#2=#:G933 NIL) (|j| NIL)
          (#3=#:G932 NIL) (|i| NIL) (|lambdaprime| (|List| (|Integer|)))
          (|nn| (|Integer|)))
         (SEQ (LETT |nn| (|IRSN;sumPartition| |lambda| $)) (LETT |dd| 1)
              (LETT |lambdaprime| (SPADCALL |lambda| (QREFELT $ 22)))
              (SEQ (LETT |i| 1)
                   (LETT #3# (SPADCALL |lambdaprime| 1 (QREFELT $ 30))) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1)
                          (LETT #2# (SPADCALL |lambda| |i| (QREFELT $ 30)))
                          G190 (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT |dd|
                                  (* |dd|
                                     (+
                                      (-
                                       (-
                                        (+
                                         (SPADCALL |lambda| |i| (QREFELT $ 30))
                                         (SPADCALL |lambdaprime| |j|
                                                   (QREFELT $ 30)))
                                        |i|)
                                       |j|)
                                      1)))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (PROG1
                   (LETT #1# (QUOTIENT2 (SPADCALL |nn| (QREFELT $ 35)) |dd|))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))))) 

(SDEFUN |IRSN;irreducibleRepresentation;LPM;8|
        ((|lambda| (|List| (|Integer|))) (|pi| (|Permutation| (|Integer|)))
         ($ (|Matrix| (|Integer|))))
        (SPROG
         ((#1=#:G942 NIL) (|l| NIL) (#2=#:G941 NIL) (|k| NIL)
          (|aPi| (|Matrix| (|Integer|))) (|piList| (|List| (|Integer|)))
          (|nn| (|NonNegativeInteger|)))
         (SEQ (LETT |nn| (|IRSN;sumPartition| |lambda| $))
              (|IRSN;alreadyComputed?| |lambda| $)
              (LETT |piList| (|IRSN;listPermutation| |pi| $))
              (COND
               ((NULL (EQL |nn| (|IRSN;testPermutation| |piList| $)))
                (|error| "Partition and permutation are not consistent")))
              (LETT |aPi| (MAKE_MATRIX1 (QREFELT $ 7) (QREFELT $ 7) 0))
              (SEQ (LETT |k| 1) (LETT #2# (QREFELT $ 7)) G190
                   (COND ((|greater_SI| |k| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |l| 1) (LETT #1# (QREFELT $ 7)) G190
                          (COND ((|greater_SI| |l| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |aPi| |k| |l|
                                      (|IRSN;signum| |k| |l| |piList| $)
                                      (QREFELT $ 16))))
                          (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL (QREFELT $ 13) |aPi| (QREFELT $ 38)))))) 

(SDEFUN |IRSN;irreducibleRepresentation;LL;9|
        ((|lambda| (|List| (|Integer|))) ($ (|List| (|Matrix| (|Integer|)))))
        (SPROG
         ((|listperm| (|List| (|Permutation| (|Integer|))))
          (|li| (|List| (|Integer|))) (|k| NIL))
         (SEQ (LETT |listperm| NIL) (LETT |li| NIL)
              (|IRSN;sumPartition| |lambda| $)
              (|IRSN;alreadyComputed?| |lambda| $)
              (LETT |listperm|
                    (COND
                     ((EQL (QREFELT $ 10) 1)
                      (CONS (|spadConstant| $ 40) |listperm|))
                     ((EQL (QREFELT $ 10) 2)
                      (CONS (SPADCALL (LIST 1 2) (QREFELT $ 41)) |listperm|))
                     ('T
                      (SEQ
                       (SEQ (LETT |k| (QREFELT $ 10)) G190
                            (COND ((< |k| 1) (GO G191)))
                            (SEQ (EXIT (LETT |li| (CONS |k| |li|))))
                            (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                       (LETT |listperm|
                             (CONS (SPADCALL |li| (QREFELT $ 41)) |listperm|))
                       (EXIT
                        (CONS (SPADCALL (LIST 1 2) (QREFELT $ 41))
                              |listperm|))))))
              (EXIT (SPADCALL |lambda| |listperm| (QREFELT $ 43)))))) 

(SDEFUN |IRSN;irreducibleRepresentation;LLL;10|
        ((|lambda| (|List| (|Integer|)))
         (|listperm| (|List| (|Permutation| (|Integer|))))
         ($ (|List| (|Matrix| (|Integer|)))))
        (SPROG ((#1=#:G953 NIL) (|pi| NIL) (#2=#:G952 NIL))
               (SEQ (|IRSN;sumPartition| |lambda| $)
                    (|IRSN;alreadyComputed?| |lambda| $)
                    (EXIT
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |pi| NIL) (LETT #1# |listperm|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |pi| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (SPADCALL |lambda| |pi| (QREFELT $ 39))
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#)))))))) 

(DECLAIM (NOTINLINE |IrrRepSymNatPackage;|)) 

(DEFUN |IrrRepSymNatPackage| ()
  (SPROG NIL
         (PROG (#1=#:G955)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|IrrRepSymNatPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|IrrRepSymNatPackage|
                             (LIST
                              (CONS NIL (CONS 1 (|IrrRepSymNatPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|IrrRepSymNatPackage|)))))))))) 

(DEFUN |IrrRepSymNatPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|IrrRepSymNatPackage|))
          (LETT $ (GETREFV 45))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IrrRepSymNatPackage| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 NIL)
          (QSETREFV $ 7 0)
          (QSETREFV $ 8 NIL)
          (QSETREFV $ 9 NIL)
          (QSETREFV $ 10 0)
          (QSETREFV $ 11 0)
          (QSETREFV $ 12 0)
          (QSETREFV $ 13 (MAKE_MATRIX1 1 1 0))
          $))) 

(MAKEPROP '|IrrRepSymNatPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|oldlambda| '|flambda| '|younglist|
              '|lprime| '|n| '|rows| '|columns| '|aId| (|Integer|)
              (|Matrix| 14) (0 . |setelt!|) (8 . |elt|) (|Boolean|) (|List| 14)
              (15 . =) (|PartitionsAndPermutations|) (21 . |conjugate|)
              (|List| 15) (|SymmetricGroupCombinatoricFunctions|)
              (26 . |listYoungTableaus|) (|Permutation| 14) (31 . |eval|)
              (37 . |elt|) (43 . |copy|) (48 . |elt|) (|Vector| 18)
              (54 . |setelt!|) (61 . |member?|)
              (|IntegerCombinatoricFunctions| 14) (67 . |factorial|)
              (|NonNegativeInteger|)
              |IRSN;dimensionOfIrreducibleRepresentation;LNni;7| (72 . *)
              |IRSN;irreducibleRepresentation;LPM;8| (78 . |One|)
              (82 . |cycle|) (|List| 26)
              |IRSN;irreducibleRepresentation;LLL;10|
              |IRSN;irreducibleRepresentation;LL;9|)
           '#(|irreducibleRepresentation| 87
              |dimensionOfIrreducibleRepresentation| 104)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|dimensionOfIrreducibleRepresentation|
                                 ((|NonNegativeInteger|) (|List| (|Integer|))))
                                T)
                              '((|irreducibleRepresentation|
                                 ((|Matrix| (|Integer|)) (|List| (|Integer|))
                                  (|Permutation| (|Integer|))))
                                T)
                              '((|irreducibleRepresentation|
                                 ((|List| (|Matrix| (|Integer|)))
                                  (|List| (|Integer|))))
                                T)
                              '((|irreducibleRepresentation|
                                 ((|List| (|Matrix| (|Integer|)))
                                  (|List| (|Integer|))
                                  (|List| (|Permutation| (|Integer|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 44
                                            '(4 15 14 0 14 14 14 16 3 15 14 0
                                              14 14 17 2 19 18 0 0 20 1 21 19
                                              19 22 1 24 23 19 25 2 26 14 0 14
                                              27 2 23 15 0 14 28 1 15 0 0 29 2
                                              19 14 0 14 30 3 31 18 0 14 18 32
                                              2 31 18 18 0 33 1 34 14 14 35 2
                                              15 0 0 0 38 0 26 0 40 1 26 0 19
                                              41 2 0 15 19 26 39 2 0 23 19 42
                                              43 1 0 23 19 44 1 0 36 19 37)))))
           '|lookupComplete|)) 

(MAKEPROP '|IrrRepSymNatPackage| 'NILADIC T) 

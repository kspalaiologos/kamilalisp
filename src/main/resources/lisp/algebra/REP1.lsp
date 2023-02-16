
(SDEFUN |REP1;calcCoef|
        ((|beta| (|List| (|Integer|))) (C (|Matrix| (|Integer|)))
         ($ (|Integer|)))
        (SPROG ((|prod| (|Integer|)) (#1=#:G714 NIL) (|i| NIL))
               (SEQ (LETT |prod| 1)
                    (SEQ (LETT |i| 1) (LETT #1# (LENGTH |beta|)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |prod|
                                 (* |prod|
                                    (SPADCALL
                                     (SPADCALL |beta| |i| (QREFELT $ 9))
                                     (SPADCALL (SPADCALL C |i| (QREFELT $ 12))
                                               (QREFELT $ 13))
                                     (QREFELT $ 15))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |prod|)))) 

(SDEFUN |REP1;invContent|
        ((|alpha| (|List| #1=(|Integer|))) ($ (|Vector| (|Integer|))))
        (SPROG
         ((|i| (|NonNegativeInteger|)) (#2=#:G732 NIL) (|k| NIL)
          (|j| (|Integer|)) (#3=#:G731 NIL) (|og| NIL)
          (|f| (|Vector| (|Integer|))) (|n| (|NonNegativeInteger|))
          (#4=#:G721 NIL) (#5=#:G719 NIL) (#6=#:G718 #1#) (#7=#:G720 #1#)
          (#8=#:G730 NIL) (#9=#:G689 NIL))
         (SEQ
          (LETT |n|
                (PROG1
                    (LETT #4#
                          (PROGN
                           (LETT #5# NIL)
                           (SEQ (LETT #9# NIL) (LETT #8# |alpha|) G190
                                (COND
                                 ((OR (ATOM #8#)
                                      (PROGN (LETT #9# (CAR #8#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (PROGN
                                   (LETT #7# #9#)
                                   (COND (#5# (LETT #6# (+ #6# #7#)))
                                         ('T
                                          (PROGN
                                           (LETT #6# #7#)
                                           (LETT #5# 'T)))))))
                                (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                           (COND (#5# #6#) ('T 0))))
                  (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #4#)))
          (LETT |f| (MAKEARR1 |n| 0)) (LETT |i| 1) (LETT |j| -1)
          (SEQ (LETT |og| NIL) (LETT #3# |alpha|) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |og| (CAR #3#)) NIL)) (GO G191)))
               (SEQ (LETT |j| (+ |j| 1))
                    (EXIT
                     (SEQ (LETT |k| 1) (LETT #2# |og|) G190
                          (COND ((|greater_SI| |k| #2#) (GO G191)))
                          (SEQ (SPADCALL |f| |i| |j| (QREFELT $ 18))
                               (EXIT (LETT |i| (+ |i| 1))))
                          (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                          (EXIT NIL))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT |f|)))) 

(SDEFUN |REP1;antisymmetricTensors;MPiM;3|
        ((|a| (|Matrix| R)) (|k| (|PositiveInteger|)) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G765 NIL) (|t| NIL) (#2=#:G766 NIL) (|tt| NIL) (#3=#:G763 NIL)
          (|r| NIL) (#4=#:G764 NIL) (|rr| NIL) (|c| #5=(|Matrix| R))
          (#6=#:G761 NIL) (|j| NIL) (#7=#:G762 NIL) (|lt| NIL) (#8=#:G759 NIL)
          (|i| NIL) (#9=#:G760 NIL) (|lr| NIL) (|b| #5#) (#10=#:G741 NIL)
          (#11=#:G740 NIL) (|ilc| (|List| (|List| (|Integer|))))
          (#12=#:G758 NIL) (#13=#:G757 NIL)
          (|ilr| (|List| (|List| (|Integer|)))) (#14=#:G756 NIL)
          (#15=#:G755 NIL) (|mc| #16=(|Integer|)) (|mr| #16#)
          (|nc| (|NonNegativeInteger|)) (|nr| (|NonNegativeInteger|)))
         (SEQ (LETT |nr| (ANROWS |a|)) (LETT |nc| (ANCOLS |a|))
              (EXIT
               (COND ((EQL |k| 1) |a|)
                     ((> |k| (MIN |nr| |nc|))
                      (|error|
                       "second parameter for antisymmetricTensors is too large"))
                     ('T
                      (SEQ (LETT |mr| (SPADCALL |nr| |k| (QREFELT $ 19)))
                           (LETT |mc| (SPADCALL |nc| |k| (QREFELT $ 19)))
                           (LETT |ilr|
                                 (PROGN
                                  (LETT #15# NIL)
                                  (SEQ (LETT |i| 0) (LETT #14# (- |mr| 1)) G190
                                       (COND
                                        ((|greater_SI| |i| #14#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #15#
                                               (CONS
                                                (SPADCALL |nr| |k| |i|
                                                          (QREFELT $ 21))
                                                #15#))))
                                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                       (EXIT (NREVERSE #15#)))))
                           (LETT |ilc|
                                 (PROGN
                                  (LETT #13# NIL)
                                  (SEQ (LETT |i| 0) (LETT #12# (- |mc| 1)) G190
                                       (COND
                                        ((|greater_SI| |i| #12#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #13#
                                               (CONS
                                                (SPADCALL |nc| |k| |i|
                                                          (QREFELT $ 21))
                                                #13#))))
                                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                       (EXIT (NREVERSE #13#)))))
                           (LETT |b|
                                 (SPADCALL
                                  (PROG1 (LETT #11# |mr|)
                                    (|check_subtype2| (>= #11# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #11#))
                                  (PROG1 (LETT #10# |mc|)
                                    (|check_subtype2| (>= #10# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #10#))
                                  (QREFELT $ 24)))
                           (SEQ (LETT |lr| NIL) (LETT #9# |ilr|) (LETT |i| 1)
                                (LETT #8# |mr|) G190
                                (COND
                                 ((OR (|greater_SI| |i| #8#) (ATOM #9#)
                                      (PROGN (LETT |lr| (CAR #9#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SEQ (LETT |lt| NIL) (LETT #7# |ilc|)
                                       (LETT |j| 1) (LETT #6# |mc|) G190
                                       (COND
                                        ((OR (|greater_SI| |j| #6#) (ATOM #7#)
                                             (PROGN (LETT |lt| (CAR #7#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |c|
                                              (SPADCALL |k| |k|
                                                        (QREFELT $ 24)))
                                        (SEQ (LETT |rr| NIL) (LETT #4# |lr|)
                                             (LETT |r| 1) (LETT #3# |k|) G190
                                             (COND
                                              ((OR (|greater_SI| |r| #3#)
                                                   (ATOM #4#)
                                                   (PROGN
                                                    (LETT |rr| (CAR #4#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (SEQ (LETT |tt| NIL)
                                                    (LETT #2# |lt|)
                                                    (LETT |t| 1) (LETT #1# |k|)
                                                    G190
                                                    (COND
                                                     ((OR
                                                       (|greater_SI| |t| #1#)
                                                       (ATOM #2#)
                                                       (PROGN
                                                        (LETT |tt| (CAR #2#))
                                                        NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (SPADCALL |c| |r| |t|
                                                                (SPADCALL |a|
                                                                          (+ 1
                                                                             |rr|)
                                                                          (+ 1
                                                                             |tt|)
                                                                          (QREFELT
                                                                           $
                                                                           25))
                                                                (QREFELT $
                                                                         26))))
                                                    (LETT |t|
                                                          (PROG1 (|inc_SI| |t|)
                                                            (LETT #2#
                                                                  (CDR #2#))))
                                                    (GO G190) G191
                                                    (EXIT NIL))))
                                             (LETT |r|
                                                   (PROG1 (|inc_SI| |r|)
                                                     (LETT #4# (CDR #4#))))
                                             (GO G190) G191 (EXIT NIL))
                                        (EXIT
                                         (SPADCALL |b| |i| |j|
                                                   (SPADCALL |c|
                                                             (QREFELT $ 27))
                                                   (QREFELT $ 26))))
                                       (LETT |j|
                                             (PROG1 (|inc_SI| |j|)
                                               (LETT #7# (CDR #7#))))
                                       (GO G190) G191 (EXIT NIL))))
                                (LETT |i|
                                      (PROG1 (|inc_SI| |i|)
                                        (LETT #9# (CDR #9#))))
                                (GO G190) G191 (EXIT NIL))
                           (EXIT |b|)))))))) 

(SDEFUN |REP1;antisymmetricTensors;LPiL;4|
        ((|la| (|List| (|Matrix| R))) (|k| (|PositiveInteger|))
         ($ (|List| (|Matrix| R))))
        (SPROG ((#1=#:G771 NIL) (|ma| NIL) (#2=#:G770 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |ma| NIL) (LETT #1# |la|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |ma| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |ma| |k| (QREFELT $ 29)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |REP1;symmetricTensors;MPiM;5|
        ((|a| (|Matrix| R)) (|n| (|PositiveInteger|)) ($ (|Matrix| R)))
        (SPROG
         ((|colemanMatrix| (|Matrix| (|Integer|))) (|help| (R)) (#1=#:G779 NIL)
          (#2=#:G778 NIL) (#3=#:G792 NIL) (|k| NIL)
          (|gamma| (|List| (|Integer|))) (|g| #4=(|Vector| (|Integer|)))
          (|beta| #5=(|List| (|Integer|))) (#6=#:G791 NIL) (|j| NIL) (|f| #4#)
          (|alpha| #5#) (#7=#:G790 NIL) (|i| NIL)
          (|nullMatrix| (|Matrix| (|Integer|))) (|c| (|Matrix| R))
          (|dimc| (|NonNegativeInteger|)) (#8=#:G773 NIL)
          (|dimr| (|NonNegativeInteger|)) (#9=#:G772 NIL)
          (|mc| (|NonNegativeInteger|)) (|mr| (|NonNegativeInteger|)))
         (SEQ (LETT |mr| (ANROWS |a|)) (LETT |mc| (ANCOLS |a|))
              (EXIT
               (COND ((EQL |n| 1) |a|)
                     ('T
                      (SEQ
                       (LETT |dimr|
                             (PROG1
                                 (LETT #9#
                                       (SPADCALL (- (+ |mr| |n|) 1) |n|
                                                 (QREFELT $ 19)))
                               (|check_subtype2| (>= #9# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #9#)))
                       (LETT |dimc|
                             (PROG1
                                 (LETT #8#
                                       (SPADCALL (- (+ |mc| |n|) 1) |n|
                                                 (QREFELT $ 19)))
                               (|check_subtype2| (>= #8# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #8#)))
                       (LETT |c|
                             (MAKE_MATRIX1 |dimr| |dimc|
                                           (|spadConstant| $ 16)))
                       (LETT |f| (MAKEARR1 |n| 0)) (LETT |g| (MAKEARR1 |n| 0))
                       (LETT |nullMatrix| (MAKE_MATRIX1 1 1 0))
                       (SEQ (LETT |i| 1) (LETT #7# |dimr|) G190
                            (COND ((|greater_SI| |i| #7#) (GO G191)))
                            (SEQ
                             (LETT |alpha|
                                   (SPADCALL |n| |mr| (- |i| 1)
                                             (QREFELT $ 32)))
                             (LETT |f| (|REP1;invContent| |alpha| $))
                             (EXIT
                              (SEQ (LETT |j| 1) (LETT #6# |dimc|) G190
                                   (COND ((|greater_SI| |j| #6#) (GO G191)))
                                   (SEQ
                                    (LETT |beta|
                                          (SPADCALL |n| |mc| (- |j| 1)
                                                    (QREFELT $ 32)))
                                    (LETT |g| (|REP1;invContent| |beta| $))
                                    (LETT |colemanMatrix|
                                          (SPADCALL |alpha| |beta| |nullMatrix|
                                                    (QREFELT $ 33)))
                                    (EXIT
                                     (SEQ G190
                                          (COND
                                           ((NULL
                                             (SPADCALL |colemanMatrix|
                                                       |nullMatrix|
                                                       (QREFELT $ 35)))
                                            (GO G191)))
                                          (SEQ
                                           (LETT |gamma|
                                                 (SPADCALL |alpha| |beta|
                                                           |colemanMatrix|
                                                           (QREFELT $ 36)))
                                           (LETT |help|
                                                 (SPADCALL
                                                  (|REP1;calcCoef| |beta|
                                                   |colemanMatrix| $)
                                                  (QREFELT $ 37)))
                                           (SEQ (LETT |k| 1) (LETT #3# |n|)
                                                G190
                                                (COND
                                                 ((|greater_SI| |k| #3#)
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT |help|
                                                        (SPADCALL |help|
                                                                  (SPADCALL |a|
                                                                            (PROG1
                                                                                (LETT
                                                                                 #2#
                                                                                 (+
                                                                                  1
                                                                                  (SPADCALL
                                                                                   |f|
                                                                                   |k|
                                                                                   (QREFELT
                                                                                    $
                                                                                    38))))
                                                                              (|check_subtype2|
                                                                               (>=
                                                                                #2#
                                                                                0)
                                                                               '(|NonNegativeInteger|)
                                                                               '(|Integer|)
                                                                               #2#))
                                                                            (PROG1
                                                                                (LETT
                                                                                 #1#
                                                                                 (+
                                                                                  1
                                                                                  (SPADCALL
                                                                                   |g|
                                                                                   (SPADCALL
                                                                                    |gamma|
                                                                                    |k|
                                                                                    (QREFELT
                                                                                     $
                                                                                     9))
                                                                                   (QREFELT
                                                                                    $
                                                                                    38))))
                                                                              (|check_subtype2|
                                                                               (>=
                                                                                #1#
                                                                                0)
                                                                               '(|NonNegativeInteger|)
                                                                               '(|Integer|)
                                                                               #1#))
                                                                            (QREFELT
                                                                             $
                                                                             25))
                                                                  (QREFELT $
                                                                           39)))))
                                                (LETT |k| (|inc_SI| |k|))
                                                (GO G190) G191 (EXIT NIL))
                                           (SPADCALL |c| |i| |j|
                                                     (SPADCALL
                                                      (SPADCALL |c| |i| |j|
                                                                (QREFELT $ 25))
                                                      |help| (QREFELT $ 40))
                                                     (QREFELT $ 26))
                                           (EXIT
                                            (LETT |colemanMatrix|
                                                  (SPADCALL |alpha| |beta|
                                                            |colemanMatrix|
                                                            (QREFELT $ 33)))))
                                          NIL (GO G190) G191 (EXIT NIL))))
                                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                   (EXIT NIL))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (EXIT |c|)))))))) 

(SDEFUN |REP1;symmetricTensors;LPiL;6|
        ((|la| (|List| (|Matrix| R))) (|k| (|PositiveInteger|))
         ($ (|List| (|Matrix| R))))
        (SPROG ((#1=#:G797 NIL) (|ma| NIL) (#2=#:G796 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |ma| NIL) (LETT #1# |la|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |ma| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |ma| |k| (QREFELT $ 41)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |REP1;tensorProduct;3M;7|
        ((|a| (|Matrix| R)) (|b| (|Matrix| R)) ($ (|Matrix| R)))
        (SPADCALL |a| |b| (QREFELT $ 43))) 

(SDEFUN |REP1;tensorProduct;3L;8|
        ((|la| (|List| (|Matrix| R))) (|lb| (|List| (|Matrix| R)))
         ($ (|List| (|Matrix| R))))
        (SPROG ((#1=#:G803 NIL) (|i| NIL) (#2=#:G802 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 1) (LETT #1# (LENGTH |la|)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL |la| |i| (QREFELT $ 45))
                                         (SPADCALL |lb| |i| (QREFELT $ 45))
                                         (QREFELT $ 44))
                               #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |REP1;tensorProduct;2M;9| ((|a| (|Matrix| R)) ($ (|Matrix| R)))
        (SPADCALL |a| |a| (QREFELT $ 44))) 

(SDEFUN |REP1;tensorProduct;2L;10|
        ((|la| (|List| (|Matrix| R))) ($ (|List| (|Matrix| R))))
        (SPADCALL |la| |la| (QREFELT $ 46))) 

(SDEFUN |REP1;permutationRepresentation;PIM;11|
        ((|p| (|Permutation| (|Integer|))) (|n| (|Integer|))
         ($ (|Matrix| (|Integer|))))
        (SPROG
         ((#1=#:G815 NIL) (|i| NIL) (|a| (|Matrix| (|Integer|)))
          (#2=#:G810 NIL) (#3=#:G809 NIL))
         (SEQ
          (LETT |a|
                (SPADCALL
                 (PROG1 (LETT #3# |n|)
                   (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #3#))
                 (PROG1 (LETT #2# |n|)
                   (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #2#))
                 (QREFELT $ 49)))
          (SEQ (LETT |i| 1) (LETT #1# |n|) G190
               (COND ((|greater_SI| |i| #1#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |a| (SPADCALL |p| |i| (QREFELT $ 51)) |i| 1
                           (QREFELT $ 52))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |a|)))) 

(SDEFUN |REP1;permutationRepresentation;LM;12|
        ((|p| (|List| (|Integer|))) ($ (|Matrix| (|Integer|))))
        (SPROG
         ((#1=#:G824 NIL) (|i| NIL) (|a| (|Matrix| (|Integer|)))
          (#2=#:G819 NIL) (#3=#:G818 NIL) (|n| (|Integer|)))
         (SEQ (LETT |n| (LENGTH |p|))
              (LETT |a|
                    (SPADCALL
                     (PROG1 (LETT #3# |n|)
                       (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #3#))
                     (PROG1 (LETT #2# |n|)
                       (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #2#))
                     (QREFELT $ 49)))
              (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |a| (SPADCALL |p| |i| (QREFELT $ 9)) |i| 1
                               (QREFELT $ 52))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |a|)))) 

(SDEFUN |REP1;permutationRepresentation;LIL;13|
        ((|listperm| (|List| (|Permutation| (|Integer|)))) (|n| (|Integer|))
         ($ (|List| (|Matrix| (|Integer|)))))
        (SPROG ((#1=#:G829 NIL) (|perm| NIL) (#2=#:G828 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |perm| NIL) (LETT #1# |listperm|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |perm| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |perm| |n| (QREFELT $ 53))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |REP1;permutationRepresentation;LL;14|
        ((|listperm| (|List| (|List| (|Integer|))))
         ($ (|List| (|Matrix| (|Integer|)))))
        (SPROG ((#1=#:G834 NIL) (|perm| NIL) (#2=#:G833 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |perm| NIL) (LETT #1# |listperm|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |perm| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |perm| (QREFELT $ 54)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |REP1;createGenericMatrix;NniM;15|
        ((|m| (|NonNegativeInteger|)) ($ (|Matrix| (|Polynomial| R))))
        (SPROG
         ((|sy| (|Symbol|)) (|le| (|List| (|OutputForm|)))
          (|jof| #1=(|OutputForm|)) (|iof| #1#) (#2=#:G851 NIL) (|j| NIL)
          (#3=#:G850 NIL) (|i| NIL) (|res| (|Matrix| (|Polynomial| R))))
         (SEQ (LETT |res| (MAKE_MATRIX1 |m| |m| (|spadConstant| $ 61)))
              (SEQ (LETT |i| 1) (LETT #3# |m|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #2# |m|) G190
                          (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ (LETT |iof| (SPADCALL |i| (QREFELT $ 63)))
                               (LETT |jof| (SPADCALL |j| (QREFELT $ 63)))
                               (LETT |le|
                                     (CONS |iof|
                                           (SPADCALL |jof| (QREFELT $ 65))))
                               (LETT |sy| (SPADCALL '|x| |le| (QREFELT $ 67)))
                               (EXIT
                                (SPADCALL |res| |i| |j|
                                          (SPADCALL |sy| (QREFELT $ 68))
                                          (QREFELT $ 70))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(DECLAIM (NOTINLINE |RepresentationPackage1;|)) 

(DEFUN |RepresentationPackage1| (#1=#:G852)
  (SPROG NIL
         (PROG (#2=#:G853)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RepresentationPackage1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|RepresentationPackage1;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RepresentationPackage1|)))))))))) 

(DEFUN |RepresentationPackage1;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RepresentationPackage1| DV$1))
          (LETT $ (GETREFV 72))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|))))))
          (|haddProp| |$ConstructorCache| '|RepresentationPackage1| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 29
                       (CONS
                        (|dispatchFunction| |REP1;antisymmetricTensors;MPiM;3|)
                        $))
             (QSETREFV $ 31
                       (CONS
                        (|dispatchFunction| |REP1;antisymmetricTensors;LPiL;4|)
                        $)))))
          $))) 

(MAKEPROP '|RepresentationPackage1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|) (|List| 7)
              (0 . |elt|) (|Vector| 7) (|Matrix| 7) (6 . |row|)
              (12 . |entries|) (|IntegerCombinatoricFunctions| 7)
              (17 . |multinomial|) (23 . |Zero|) (27 . |One|) (31 . |setelt!|)
              (38 . |binomial|) (|SymmetricGroupCombinatoricFunctions|)
              (44 . |subSet|) (|NonNegativeInteger|) (|Matrix| 6) (51 . |zero|)
              (57 . |elt|) (64 . |setelt!|) (72 . |determinant|)
              (|PositiveInteger|) (77 . |antisymmetricTensors|) (|List| 23)
              (83 . |antisymmetricTensors|) (89 . |unrankImproperPartitions1|)
              (96 . |nextColeman|) (|Boolean|) (103 . ~=)
              (109 . |inverseColeman|) (116 . |coerce|) (121 . |elt|) (127 . *)
              (133 . +) |REP1;symmetricTensors;MPiM;5|
              |REP1;symmetricTensors;LPiL;6| (139 . |kroneckerProduct|)
              |REP1;tensorProduct;3M;7| (145 . |elt|) |REP1;tensorProduct;3L;8|
              |REP1;tensorProduct;2M;9| |REP1;tensorProduct;2L;10|
              (151 . |zero|) (|Permutation| 7) (157 . |eval|) (163 . |setelt!|)
              |REP1;permutationRepresentation;PIM;11|
              |REP1;permutationRepresentation;LM;12| (|List| 11) (|List| 50)
              |REP1;permutationRepresentation;LIL;13| (|List| 8)
              |REP1;permutationRepresentation;LL;14| (|Polynomial| 6)
              (171 . |Zero|) (|OutputForm|) (175 . |coerce|) (|List| 62)
              (180 . |list|) (|Symbol|) (185 . |subscript|) (191 . |coerce|)
              (|Matrix| 60) (196 . |setelt!|)
              |REP1;createGenericMatrix;NniM;15|)
           '#(|tensorProduct| 204 |symmetricTensors| 226
              |permutationRepresentation| 238 |createGenericMatrix| 260
              |antisymmetricTensors| 265)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|antisymmetricTensors|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)
                                  (|PositiveInteger|)))
                                (|has| 6 (|CommutativeRing|)))
                              '((|antisymmetricTensors|
                                 ((|List| (|Matrix| |#1|))
                                  (|List| (|Matrix| |#1|))
                                  (|PositiveInteger|)))
                                (|has| 6 (|CommutativeRing|)))
                              '((|createGenericMatrix|
                                 ((|Matrix| (|Polynomial| |#1|))
                                  (|NonNegativeInteger|)))
                                T)
                              '((|symmetricTensors|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|symmetricTensors|
                                 ((|List| (|Matrix| |#1|))
                                  (|List| (|Matrix| |#1|))
                                  (|PositiveInteger|)))
                                T)
                              '((|tensorProduct|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)
                                  (|Matrix| |#1|)))
                                T)
                              '((|tensorProduct|
                                 ((|List| (|Matrix| |#1|))
                                  (|List| (|Matrix| |#1|))
                                  (|List| (|Matrix| |#1|))))
                                T)
                              '((|tensorProduct|
                                 ((|Matrix| |#1|) (|Matrix| |#1|)))
                                T)
                              '((|tensorProduct|
                                 ((|List| (|Matrix| |#1|))
                                  (|List| (|Matrix| |#1|))))
                                T)
                              '((|permutationRepresentation|
                                 ((|Matrix| (|Integer|))
                                  (|Permutation| (|Integer|)) (|Integer|)))
                                T)
                              '((|permutationRepresentation|
                                 ((|Matrix| (|Integer|)) (|List| (|Integer|))))
                                T)
                              '((|permutationRepresentation|
                                 ((|List| (|Matrix| (|Integer|)))
                                  (|List| (|Permutation| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|permutationRepresentation|
                                 ((|List| (|Matrix| (|Integer|)))
                                  (|List| (|List| (|Integer|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 71
                                            '(2 8 7 0 7 9 2 11 10 0 7 12 1 10 8
                                              0 13 2 14 7 7 8 15 0 6 0 16 0 6 0
                                              17 3 10 7 0 7 7 18 2 14 7 7 7 19
                                              3 20 8 7 7 7 21 2 23 0 22 22 24 3
                                              23 6 0 7 7 25 4 23 6 0 7 7 6 26 1
                                              23 6 0 27 2 0 23 23 28 29 2 0 30
                                              30 28 31 3 20 8 7 7 7 32 3 20 11
                                              8 8 11 33 2 11 34 0 0 35 3 20 8 8
                                              8 11 36 1 6 0 7 37 2 10 7 0 7 38
                                              2 6 0 0 0 39 2 6 0 0 0 40 2 23 0
                                              0 0 43 2 30 23 0 7 45 2 11 0 22
                                              22 49 2 50 7 0 7 51 4 11 7 0 7 7
                                              7 52 0 60 0 61 1 7 62 0 63 1 64 0
                                              62 65 2 66 0 0 64 67 1 60 0 66 68
                                              4 69 60 0 7 7 60 70 2 0 23 23 23
                                              44 2 0 30 30 30 46 1 0 30 30 48 1
                                              0 23 23 47 2 0 23 23 28 41 2 0 30
                                              30 28 42 1 0 11 8 54 2 0 11 50 7
                                              53 1 0 55 58 59 2 0 55 56 7 57 1
                                              0 69 22 71 2 1 23 23 28 29 2 1 30
                                              30 28 31)))))
           '|lookupComplete|)) 


(SDEFUN |SGCF;numberOfImproperPartitionsInternal|
        ((|n| (|Integer|)) (|m| (|Integer|)) (|cm| (|Integer|))
         ($ (|Integer|)))
        (SPROG ((|s| (|Integer|)) (#1=#:G709 NIL) (|i| NIL))
               (SEQ
                (COND ((EQL |n| 0) (SPADCALL |m| |cm| (QREFELT $ 8)))
                      ('T
                       (SEQ (COND ((EQL |cm| 0) (COND ((> |n| 0) (EXIT 0)))))
                            (LETT |s| 0)
                            (SEQ (LETT |i| 0) (LETT #1# (- |n| 1)) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |s|
                                         (+ |s|
                                            (|SGCF;numberOfImproperPartitionsInternal|
                                             |i| |m| (- |cm| 1) $)))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |s|))))))) 

(SDEFUN |SGCF;numberOfImproperPartitions;3I;2|
        ((|n| (|Integer|)) (|m| (|Integer|)) ($ (|Integer|)))
        (SPROG ((|s| (|Integer|)) (#1=#:G715 NIL) (|i| NIL) (#2=#:G714 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((OR (< |n| 0) (< |m| 1))
                    (PROGN (LETT #2# 0) (GO #3=#:G713))))
                  (COND
                   ((OR (EQL |m| 1) (EQL |n| 0))
                    (PROGN (LETT #2# 1) (GO #3#))))
                  (LETT |s| 0)
                  (SEQ (LETT |i| 0) (LETT #1# |n|) G190
                       (COND ((|greater_SI| |i| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |s|
                               (+ |s|
                                  (SPADCALL (- |n| |i|) (- |m| 1)
                                            (QREFELT $ 9))))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT |s|)))
                #3# (EXIT #2#)))) 

(SDEFUN |SGCF;unrankImproperPartitions0;3IL;3|
        ((|n| (|Integer|)) (|m| (|Integer|)) (|k| (|Integer|))
         ($ (|List| (|Integer|))))
        (SPROG
         ((|l| (|List| (|Integer|))) (#1=#:G731 NIL) (|s| #2=(|Integer|))
          (|sOld| #2#) (#3=#:G733 NIL) (|y| NIL) (#4=#:G732 NIL) (|t| NIL))
         (SEQ (LETT |l| NIL)
              (EXIT
               (COND
                ((< |k| 0) (|error| "counting of partitions is started at 0"))
                ((>= |k| (SPADCALL |n| |m| (QREFELT $ 9)))
                 (|error| "there are not so many partitions"))
                ('T
                 (SEQ
                  (SEQ (LETT |t| 0) (LETT #4# (- |m| 2)) G190
                       (COND ((|greater_SI| |t| #4#) (GO G191)))
                       (SEQ (LETT |s| 0)
                            (SEQ
                             (EXIT
                              (SEQ (LETT |y| 0) (LETT #3# |n|) G190
                                   (COND ((|greater_SI| |y| #3#) (GO G191)))
                                   (SEQ (LETT |sOld| |s|)
                                        (LETT |s|
                                              (+ |s|
                                                 (SPADCALL (- |n| |y|)
                                                           (- (- |m| |t|) 1)
                                                           (QREFELT $ 9))))
                                        (EXIT
                                         (COND
                                          ((> |s| |k|)
                                           (PROGN
                                            (LETT #1# |$NoValue|)
                                            (GO #5=#:G724))))))
                                   (LETT |y| (|inc_SI| |y|)) (GO G190) G191
                                   (EXIT NIL)))
                             #5# (EXIT #1#))
                            (LETT |l|
                                  (SPADCALL |l| (SPADCALL |y| (QREFELT $ 11))
                                            (QREFELT $ 12)))
                            (LETT |k| (- |k| |sOld|))
                            (EXIT (LETT |n| (- |n| |y|))))
                       (LETT |t| (|inc_SI| |t|)) (GO G190) G191 (EXIT NIL))
                  (LETT |l|
                        (SPADCALL |l| (SPADCALL |n| (QREFELT $ 11))
                                  (QREFELT $ 12)))
                  (EXIT |l|)))))))) 

(SDEFUN |SGCF;unrankImproperPartitions1;3IL;4|
        ((|n| (|Integer|)) (|m| #1=(|Integer|)) (|k| (|Integer|))
         ($ (|List| (|Integer|))))
        (SPROG
         ((#2=#:G757 NIL) (|i| NIL) (|nonZeroPos| (|List| (|Integer|)))
          (|nonZeros| (|List| (|Integer|))) (#3=#:G756 NIL)
          (|s| #4=(|Integer|)) (|sOld| #4#) (|y| NIL) (|cm| #1#)
          (|partition| (|Vector| (|Integer|))) (#5=#:G735 NIL))
         (SEQ (LETT |nonZeros| NIL)
              (LETT |partition|
                    (MAKEARR1
                     (PROG1 (LETT #5# |m|)
                       (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #5#))
                     0))
              (EXIT
               (COND
                ((OR (< |k| 0) (>= |k| (SPADCALL |n| |m| (QREFELT $ 9))))
                 |nonZeros|)
                ('T
                 (SEQ (LETT |cm| |m|)
                      (SEQ G190
                           (COND
                            ((NULL (SPADCALL |n| 0 (QREFELT $ 15))) (GO G191)))
                           (SEQ (LETT |s| 0) (LETT |cm| (- |cm| 1))
                                (SEQ
                                 (EXIT
                                  (SEQ (LETT |y| |n|) G190
                                       (COND ((< |y| 1) (GO G191)))
                                       (SEQ (LETT |sOld| |s|)
                                            (LETT |s|
                                                  (+ |s|
                                                     (|SGCF;numberOfImproperPartitionsInternal|
                                                      (- |n| |y|) |m| |cm| $)))
                                            (EXIT
                                             (COND
                                              ((> |s| |k|)
                                               (PROGN
                                                (LETT #3# |$NoValue|)
                                                (GO #6=#:G739))))))
                                       (LETT |y| (+ |y| -1)) (GO G190) G191
                                       (EXIT NIL)))
                                 #6# (EXIT #3#))
                                (LETT |nonZeros|
                                      (SPADCALL |nonZeros|
                                                (SPADCALL |y| (QREFELT $ 11))
                                                (QREFELT $ 12)))
                                (LETT |k| (- |k| |sOld|))
                                (EXIT (LETT |n| (- |n| |y|))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |nonZeroPos|
                            (REVERSE
                             (SPADCALL |m| (- |m| |cm|) |k| (QREFELT $ 16))))
                      (SEQ (LETT |i| 1) (LETT #2# (- |m| |cm|)) G190
                           (COND ((|greater_SI| |i| #2#) (GO G191)))
                           (SEQ
                            (EXIT
                             (SPADCALL |partition|
                                       (+ 1
                                          (SPADCALL |nonZeroPos| |i|
                                                    (QREFELT $ 17)))
                                       (SPADCALL |nonZeros| |i| (QREFELT $ 17))
                                       (QREFELT $ 19))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT (SPADCALL |partition| (QREFELT $ 20)))))))))) 

(SDEFUN |SGCF;subSet;3IL;5|
        ((|n| (|Integer|)) (|m| #1=(|Integer|)) (|k| #2=(|Integer|))
         ($ (|List| (|Integer|))))
        (SPROG
         ((|s| #1#) (|mm| #2#) (|l| (|List| (|Integer|))) (#3=#:G768 NIL)
          (#4=#:G770 NIL) (|y| NIL) (#5=#:G769 NIL) (|t| NIL)
          (|bin| (|Integer|)))
         (SEQ
          (COND
           ((OR (OR (OR (< |k| 0) (< |n| 0)) (< |m| 0)) (> |m| |n|))
            (|error| "improper argument to subSet"))
           ('T
            (SEQ (LETT |bin| (SPADCALL |n| |m| (QREFELT $ 8)))
                 (EXIT
                  (COND
                   ((>= |k| |bin|) (|error| "there are not so many subsets"))
                   (#6='T
                    (SEQ (LETT |l| NIL)
                         (EXIT
                          (COND ((EQL |n| 0) |l|)
                                (#6#
                                 (SEQ (LETT |mm| |k|) (LETT |s| |m|)
                                      (SEQ (LETT |t| 0) (LETT #5# (- |m| 1))
                                           G190
                                           (COND
                                            ((|greater_SI| |t| #5#) (GO G191)))
                                           (SEQ
                                            (SEQ
                                             (EXIT
                                              (SEQ (LETT |y| (- |s| 1))
                                                   (LETT #4# (+ |n| 1)) G190
                                                   (COND
                                                    ((> |y| #4#) (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (COND
                                                      ((>
                                                        (SPADCALL |y| |s|
                                                                  (QREFELT $
                                                                           8))
                                                        |mm|)
                                                       (PROGN
                                                        (LETT #3# 1)
                                                        (GO #7=#:G761))))))
                                                   (LETT |y| (+ |y| 1))
                                                   (GO G190) G191 (EXIT NIL)))
                                             #7# (EXIT #3#))
                                            (LETT |l|
                                                  (SPADCALL |l|
                                                            (SPADCALL (- |y| 1)
                                                                      (QREFELT
                                                                       $ 11))
                                                            (QREFELT $ 12)))
                                            (LETT |mm|
                                                  (- |mm|
                                                     (SPADCALL (- |y| 1) |s|
                                                               (QREFELT $ 8))))
                                            (EXIT (LETT |s| (- |s| 1))))
                                           (LETT |t| (|inc_SI| |t|)) (GO G190)
                                           G191 (EXIT NIL))
                                      (EXIT |l|))))))))))))))) 

(SDEFUN |SGCF;nextLatticePermutation;2LBL;6|
        ((|lambda| (|List| #1=(|Integer|))) (|lattP| (|List| (|Integer|)))
         (|constructNotFirst| (|Boolean|)) ($ (|List| (|Integer|))))
        (SPROG
         ((#2=#:G806 NIL) (|l| NIL) (|i| NIL)
          (|rightPosition| #3=(|NonNegativeInteger|)) (#4=#:G792 NIL)
          (|j| (|NonNegativeInteger|)) (#5=#:G805 NIL) (|ready| (|Boolean|))
          (|leftEntry| #6=(|NonNegativeInteger|)) (#7=#:G781 NIL)
          (|rightEntry| #6#) (#8=#:G804 NIL) (#9=#:G779 NIL)
          (|help| (|Vector| (|Integer|))) (|n| #3#) (#10=#:G778 NIL)
          (#11=#:G776 NIL) (#12=#:G775 #1#) (#13=#:G777 #1#) (#14=#:G803 NIL)
          (#15=#:G689 NIL) (|columns| (|NonNegativeInteger|)) (#16=#:G771 NIL)
          (|lprime| (|List| (|Integer|))))
         (SEQ (LETT |lprime| (SPADCALL |lambda| (QREFELT $ 23)))
              (LETT |columns|
                    (PROG1 (LETT #16# (|SPADfirst| |lambda|))
                      (|check_subtype2| (>= #16# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #16#)))
              (LETT |n|
                    (PROG1
                        (LETT #10#
                              (PROGN
                               (LETT #11# NIL)
                               (SEQ (LETT #15# NIL) (LETT #14# |lambda|) G190
                                    (COND
                                     ((OR (ATOM #14#)
                                          (PROGN (LETT #15# (CAR #14#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #13# #15#)
                                       (COND (#11# (LETT #12# (+ #12# #13#)))
                                             ('T
                                              (PROGN
                                               (LETT #12# #13#)
                                               (LETT #11# 'T)))))))
                                    (LETT #14# (CDR #14#)) (GO G190) G191
                                    (EXIT NIL))
                               (COND (#11# #12#) (#17='T 0))))
                      (|check_subtype2| (>= #10# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #10#)))
              (EXIT
               (COND
                (|constructNotFirst|
                 (SEQ (LETT |help| (MAKEARR1 |columns| 0))
                      (LETT |rightPosition| |n|)
                      (LETT |leftEntry|
                            (PROG1
                                (LETT #9#
                                      (SPADCALL |lattP| |rightPosition|
                                                (QREFELT $ 17)))
                              (|check_subtype2| (>= #9# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #9#)))
                      (LETT |ready| NIL)
                      (SEQ (LETT #8# NIL) G190 (COND (#8# (GO G191)))
                           (SEQ (LETT |rightEntry| |leftEntry|)
                                (LETT |leftEntry|
                                      (PROG1
                                          (LETT #7#
                                                (SPADCALL |lattP|
                                                          (- |rightPosition| 1)
                                                          (QREFELT $ 17)))
                                        (|check_subtype2| (>= #7# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #7#)))
                                (SPADCALL |help| |rightEntry|
                                          (+
                                           (SPADCALL |help| |rightEntry|
                                                     (QREFELT $ 24))
                                           1)
                                          (QREFELT $ 19))
                                (COND
                                 ((> |rightEntry| |leftEntry|)
                                  (COND
                                   ((>
                                     (-
                                      (SPADCALL |lprime| |leftEntry|
                                                (QREFELT $ 17))
                                      (SPADCALL |help| |leftEntry|
                                                (QREFELT $ 24)))
                                     (+
                                      (-
                                       (SPADCALL |lprime| |rightEntry|
                                                 (QREFELT $ 17))
                                       (SPADCALL |help| |rightEntry|
                                                 (QREFELT $ 24)))
                                      1))
                                    (SEQ (LETT |ready| 'T)
                                         (LETT |j| (+ |leftEntry| 1))
                                         (SEQ G190
                                              (COND
                                               ((NULL
                                                 (COND
                                                  ((EQL
                                                    (SPADCALL |help| |j|
                                                              (QREFELT $ 24))
                                                    0)
                                                   'T)
                                                  ('T
                                                   (<
                                                    (-
                                                     (SPADCALL |lprime|
                                                               |leftEntry|
                                                               (QREFELT $ 17))
                                                     (SPADCALL |lprime| |j|
                                                               (QREFELT $ 17)))
                                                    (+
                                                     (-
                                                      (SPADCALL |help|
                                                                |leftEntry|
                                                                (QREFELT $ 24))
                                                      (SPADCALL |help| |j|
                                                                (QREFELT $
                                                                         24)))
                                                     2)))))
                                                (GO G191)))
                                              (SEQ (EXIT (LETT |j| (+ |j| 1))))
                                              NIL (GO G190) G191 (EXIT NIL))
                                         (SPADCALL |lattP|
                                                   (- |rightPosition| 1) |j|
                                                   (QREFELT $ 25))
                                         (SPADCALL |help| |j|
                                                   (-
                                                    (SPADCALL |help| |j|
                                                              (QREFELT $ 24))
                                                    1)
                                                   (QREFELT $ 19))
                                         (SPADCALL |help| |leftEntry|
                                                   (+
                                                    (SPADCALL |help|
                                                              |leftEntry|
                                                              (QREFELT $ 24))
                                                    1)
                                                   (QREFELT $ 19))
                                         (EXIT
                                          (SEQ (LETT |l| |rightPosition|)
                                               (LETT #5# |n|) G190
                                               (COND ((> |l| #5#) (GO G191)))
                                               (SEQ (LETT |j| 0)
                                                    (SEQ G190
                                                         (COND
                                                          ((NULL
                                                            (EQL
                                                             (SPADCALL |help|
                                                                       (+ 1
                                                                          |j|)
                                                                       (QREFELT
                                                                        $ 24))
                                                             0))
                                                           (GO G191)))
                                                         (SEQ
                                                          (EXIT
                                                           (LETT |j|
                                                                 (+ |j| 1))))
                                                         NIL (GO G190) G191
                                                         (EXIT NIL))
                                                    (SPADCALL |lattP| |l|
                                                              (+ |j| 1)
                                                              (QREFELT $ 25))
                                                    (EXIT
                                                     (SPADCALL |help| (+ 1 |j|)
                                                               (-
                                                                (SPADCALL
                                                                 |help|
                                                                 (+ 1 |j|)
                                                                 (QREFELT $
                                                                          24))
                                                                1)
                                                               (QREFELT $
                                                                        19))))
                                               (LETT |l| (+ |l| 1)) (GO G190)
                                               G191 (EXIT NIL))))))))
                                (LETT |rightPosition|
                                      (PROG1 (LETT #4# (- |rightPosition| 1))
                                        (|check_subtype2| (>= #4# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #4#)))
                                (EXIT
                                 (COND
                                  ((EQL |rightPosition| 1)
                                   (LETT |constructNotFirst| NIL)))))
                           (LETT #8#
                                 (COND
                                  ((OR |ready| (NULL |constructNotFirst|)) 'T)
                                  ('T NIL)))
                           (GO G190) G191 (EXIT NIL))
                      (EXIT (COND (|constructNotFirst| |lattP|) (#17# NIL)))))
                (#17#
                 (SEQ (LETT |lattP| NIL)
                      (SEQ (LETT |i| |columns|) G190
                           (COND ((< |i| 1) (GO G191)))
                           (SEQ
                            (EXIT
                             (SEQ (LETT |l| 1)
                                  (LETT #2#
                                        (SPADCALL |lprime| |i| (QREFELT $ 17)))
                                  G190
                                  (COND ((|greater_SI| |l| #2#) (GO G191)))
                                  (SEQ
                                   (EXIT (LETT |lattP| (CONS |i| |lattP|))))
                                  (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                  (EXIT NIL))))
                           (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                      (EXIT |lattP|)))))))) 

(SDEFUN |SGCF;makeYoungTableau;2LM;7|
        ((|lambda| (|List| (|Integer|))) (|gitter| (|List| (|Integer|)))
         ($ (|Matrix| (|Integer|))))
        (SPROG
         ((|i| (|Integer|)) (|j| (|Integer|)) (#1=#:G815 NIL) (|l| NIL)
          (|help| (|Vector| (|Integer|))) (|ytab| (|Matrix| (|Integer|)))
          (|rows| (|NonNegativeInteger|)) (#2=#:G809 NIL)
          (|columns| (|NonNegativeInteger|)) (#3=#:G808 NIL)
          (|lprime| (|List| (|Integer|))))
         (SEQ (LETT |lprime| (SPADCALL |lambda| (QREFELT $ 23)))
              (LETT |columns|
                    (PROG1 (LETT #3# (|SPADfirst| |lambda|))
                      (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #3#)))
              (LETT |rows|
                    (PROG1 (LETT #2# (|SPADfirst| |lprime|))
                      (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #2#)))
              (LETT |ytab| (MAKE_MATRIX1 |rows| |columns| 0))
              (LETT |help| (MAKEARR1 |columns| 1)) (LETT |i| -1) (LETT |j| 0)
              (SEQ (LETT |l| 1) (LETT #1# (LENGTH |gitter|)) G190
                   (COND ((|greater_SI| |l| #1#) (GO G191)))
                   (SEQ (LETT |j| (SPADCALL |gitter| |l| (QREFELT $ 17)))
                        (LETT |i| (+ |i| 1))
                        (SPADCALL |ytab| (SPADCALL |help| |j| (QREFELT $ 24))
                                  |j| |i| (QREFELT $ 28))
                        (EXIT
                         (SPADCALL |help| |j|
                                   (+ (SPADCALL |help| |j| (QREFELT $ 24)) 1)
                                   (QREFELT $ 19))))
                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
              (EXIT |ytab|)))) 

(SDEFUN |SGCF;listYoungTableaus;LL;8|
        ((|lambda| (|List| (|Integer|))) ($ (|List| (|Matrix| (|Integer|)))))
        (SPROG
         ((|lattice| (|List| (|Integer|)))
          (|younglist| (|List| (|Matrix| (|Integer|))))
          (|ytab| (|Matrix| (|Integer|))) (#1=#:G821 NIL))
         (SEQ (LETT |younglist| NIL)
              (LETT |lattice| (SPADCALL |lambda| |lattice| NIL (QREFELT $ 26)))
              (SEQ (LETT #1# NIL) G190 (COND (#1# (GO G191)))
                   (SEQ
                    (LETT |ytab| (SPADCALL |lambda| |lattice| (QREFELT $ 29)))
                    (LETT |younglist|
                          (SPADCALL |younglist| (LIST |ytab|) (QREFELT $ 31)))
                    (EXIT
                     (LETT |lattice|
                           (SPADCALL |lambda| |lattice| 'T (QREFELT $ 26)))))
                   (LETT #1# (NULL |lattice|)) (GO G190) G191 (EXIT NIL))
              (EXIT |younglist|)))) 

(SDEFUN |SGCF;nextColeman;2L2M;9|
        ((|alpha| (|List| (|Integer|))) (|beta| (|List| (|Integer|)))
         (C (|Matrix| (|Integer|))) ($ (|Matrix| (|Integer|))))
        (SPROG
         ((|vrest| (|Vector| (|Integer|))) (|coleman| (|Matrix| (|Integer|)))
          (|succ| (|Vector| (|Integer|))) (#1=#:G839 NIL)
          (|i| (|NonNegativeInteger|)) (#2=#:G832 NIL) (|j| (|Integer|))
          (#3=#:G824 NIL) (#4=#:G838 NIL) (#5=#:G822 NIL)
          (|cnull| (|Matrix| (|Integer|))) (|vnull| (|Vector| (|Integer|)))
          (|ncol| #6=(|NonNegativeInteger|)) (|nrow| #6#))
         (SEQ
          (EXIT
           (SEQ (LETT |nrow| (LENGTH |beta|)) (LETT |ncol| (LENGTH |alpha|))
                (LETT |vnull| (SPADCALL NIL (QREFELT $ 33)))
                (LETT |vrest| (MAKEARR1 |ncol| 0))
                (LETT |cnull| (MAKE_MATRIX1 1 1 0))
                (LETT |coleman| (SPADCALL C (QREFELT $ 34)))
                (COND
                 ((SPADCALL |coleman| |cnull| (QREFELT $ 35))
                  (SEQ
                   (LETT |i|
                         (PROG1 (LETT #5# (- |nrow| 1))
                           (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #5#)))
                   (LETT |vrest|
                         (SPADCALL (SPADCALL |coleman| |i| (QREFELT $ 36))
                                   (SPADCALL |coleman| |nrow| (QREFELT $ 36))
                                   (QREFELT $ 37)))
                   (LETT |succ|
                         (SPADCALL |vrest|
                                   (SPADCALL |coleman| |i| (QREFELT $ 36))
                                   (SPADCALL |beta| |i| (QREFELT $ 17))
                                   (QREFELT $ 38)))
                   (SEQ G190
                        (COND
                         ((NULL (SPADCALL |succ| |vnull| (QREFELT $ 39)))
                          (GO G191)))
                        (SEQ
                         (COND
                          ((EQL |i| 1)
                           (PROGN (LETT #4# |cnull|) (GO #7=#:G837))))
                         (LETT |i|
                               (PROG1 (LETT #3# (- |i| 1))
                                 (|check_subtype2| (>= #3# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #3#)))
                         (LETT |vrest|
                               (SPADCALL |vrest|
                                         (SPADCALL |coleman| |i|
                                                   (QREFELT $ 36))
                                         (QREFELT $ 37)))
                         (EXIT
                          (LETT |succ|
                                (SPADCALL |vrest|
                                          (SPADCALL |coleman| |i|
                                                    (QREFELT $ 36))
                                          (SPADCALL |beta| |i| (QREFELT $ 17))
                                          (QREFELT $ 38)))))
                        NIL (GO G190) G191 (EXIT NIL))
                   (LETT |j| |i|)
                   (LETT |coleman|
                         (SPADCALL |coleman| |i| |succ| (QREFELT $ 40)))
                   (EXIT
                    (LETT |vrest|
                          (SPADCALL |vrest|
                                    (SPADCALL |coleman| |i| (QREFELT $ 36))
                                    (QREFELT $ 41))))))
                 ('T
                  (SEQ (LETT |vrest| (SPADCALL |alpha| (QREFELT $ 33)))
                       (LETT |coleman| (MAKE_MATRIX1 |nrow| |ncol| 0))
                       (EXIT (LETT |j| 0)))))
                (SEQ
                 (LETT |i|
                       (PROG1 (LETT #2# (+ |j| 1))
                         (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #2#)))
                 (LETT #1# (- |nrow| 1)) G190 (COND ((> |i| #1#) (GO G191)))
                 (SEQ
                  (LETT |succ|
                        (SPADCALL |vrest| |vnull|
                                  (SPADCALL |beta| |i| (QREFELT $ 17))
                                  (QREFELT $ 38)))
                  (LETT |coleman|
                        (SPADCALL |coleman| |i| |succ| (QREFELT $ 40)))
                  (EXIT
                   (LETT |vrest| (SPADCALL |vrest| |succ| (QREFELT $ 41)))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL |coleman| |nrow| |vrest| (QREFELT $ 40)))))
          #7# (EXIT #4#)))) 

(SDEFUN |SGCF;nextPartition;2VIV;10|
        ((|gamma| (|Vector| (|Integer|))) (|part| (|Vector| (|Integer|)))
         (|number| (|Integer|)) ($ (|Vector| (|Integer|))))
        (SPADCALL (SPADCALL |gamma| (QREFELT $ 20)) |part| |number|
                  (QREFELT $ 43))) 

(SDEFUN |SGCF;nextPartition;LVIV;11|
        ((|gamma| (|List| (|Integer|))) (|part| (|Vector| (|Integer|)))
         (|number| (|Integer|)) ($ (|Vector| (|Integer|))))
        (SPROG
         ((#1=#:G856 NIL) (|k| NIL) (|j| (|NonNegativeInteger|))
          (|sum| (|Integer|)) (|i| (|NonNegativeInteger|)) (#2=#:G855 NIL)
          (|vnull| (|Vector| (|Integer|))) (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (LENGTH |gamma|)) (LETT |vnull| (MAKE-ARRAY 0))
                (COND
                 ((SPADCALL |part| |vnull| (QREFELT $ 44))
                  (SEQ (LETT |i| 2)
                       (LETT |sum| (SPADCALL |part| 1 (QREFELT $ 24)))
                       (SEQ G190
                            (COND
                             ((NULL
                               (COND
                                ((EQL (SPADCALL |part| |i| (QREFELT $ 24))
                                      (SPADCALL |gamma| |i| (QREFELT $ 17)))
                                 'T)
                                ('T (EQL |sum| 0))))
                              (GO G191)))
                            (SEQ
                             (LETT |sum|
                                   (+ |sum|
                                      (SPADCALL |part| |i| (QREFELT $ 24))))
                             (LETT |i| (+ |i| 1))
                             (EXIT
                              (COND
                               ((EQL |i| (+ 1 |n|))
                                (PROGN (LETT #2# |vnull|) (GO #3=#:G854))))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (LETT |sum| (- |sum| 1))
                       (EXIT
                        (SPADCALL |part| |i|
                                  (+ (SPADCALL |part| |i| (QREFELT $ 24)) 1)
                                  (QREFELT $ 19)))))
                 ('T
                  (SEQ (LETT |sum| |number|) (LETT |part| (MAKEARR1 |n| 0))
                       (EXIT (LETT |i| (+ 1 |n|))))))
                (LETT |j| 1)
                (SEQ G190
                     (COND
                      ((NULL (> |sum| (SPADCALL |gamma| |j| (QREFELT $ 17))))
                       (GO G191)))
                     (SEQ
                      (SPADCALL |part| |j|
                                (SPADCALL |gamma| |j| (QREFELT $ 17))
                                (QREFELT $ 19))
                      (LETT |sum|
                            (- |sum| (SPADCALL |gamma| |j| (QREFELT $ 17))))
                      (EXIT (LETT |j| (+ |j| 1))))
                     NIL (GO G190) G191 (EXIT NIL))
                (SPADCALL |part| |j| |sum| (QREFELT $ 19))
                (SEQ (LETT |k| (+ |j| 1)) (LETT #1# (- |i| 1)) G190
                     (COND ((> |k| #1#) (GO G191)))
                     (SEQ (EXIT (SPADCALL |part| |k| 0 (QREFELT $ 19))))
                     (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                (EXIT |part|)))
          #3# (EXIT #2#)))) 

(SDEFUN |SGCF;inverseColeman;2LML;12|
        ((|alpha| (|List| (|Integer|))) (|beta| (|List| (|Integer|)))
         (C (|Matrix| (|Integer|))) ($ (|List| (|Integer|))))
        (SPROG
         ((|pi| (|List| (|Integer|))) (#1=#:G872 NIL) (|k| NIL) (#2=#:G871 NIL)
          (|i| NIL) (#3=#:G870 NIL) (|j| NIL) (|sum| (|Integer|))
          (#4=#:G869 NIL) (|help| (|Vector| (|Integer|)))
          (|ncol| #5=(|NonNegativeInteger|)) (|nrow| #5#))
         (SEQ (LETT |pi| NIL) (LETT |nrow| (LENGTH |beta|))
              (LETT |ncol| (LENGTH |alpha|)) (LETT |help| (MAKEARR1 |nrow| 0))
              (LETT |sum| 1)
              (SEQ (LETT |i| 1) (LETT #4# |nrow|) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ (SPADCALL |help| |i| |sum| (QREFELT $ 19))
                        (EXIT
                         (LETT |sum|
                               (+ |sum|
                                  (SPADCALL |beta| |i| (QREFELT $ 17))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |j| 1) (LETT #3# |ncol|) G190
                   (COND ((|greater_SI| |j| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |i| 1) (LETT #2# |nrow|) G190
                          (COND ((|greater_SI| |i| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |k| 2)
                                 (LETT #1#
                                       (+ 1
                                          (SPADCALL C |i| |j| (QREFELT $ 45))))
                                 G190 (COND ((|greater_SI| |k| #1#) (GO G191)))
                                 (SEQ
                                  (LETT |pi|
                                        (SPADCALL |pi|
                                                  (SPADCALL
                                                   (SPADCALL |help| |i|
                                                             (QREFELT $ 24))
                                                   (QREFELT $ 11))
                                                  (QREFELT $ 12)))
                                  (EXIT
                                   (SPADCALL |help| |i|
                                             (+
                                              (SPADCALL |help| |i|
                                                        (QREFELT $ 24))
                                              1)
                                             (QREFELT $ 19))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (EXIT |pi|)))) 

(SDEFUN |SGCF;coleman;3LM;13|
        ((|alpha| (|List| (|Integer|))) (|beta| (|List| (|Integer|)))
         (|pi| (|List| (|Integer|))) ($ (|Matrix| (|Integer|))))
        (SPROG
         ((#1=#:G895 NIL) (|j| NIL) (|betasum| #2=(|NonNegativeInteger|))
          (#3=#:G886 NIL) (|help| (|List| (|Integer|))) (#4=#:G884 NIL)
          (#5=#:G894 NIL) (|i| NIL) (|temp| (|List| (|List| (|Integer|))))
          (|alphasum| #2#) (#6=#:G878 NIL) (#7=#:G876 NIL) (#8=#:G893 NIL)
          (|colematrix| (|Matrix| (|Integer|)))
          (|ncol| #9=(|NonNegativeInteger|)) (|nrow| #9#))
         (SEQ (LETT |nrow| (LENGTH |beta|)) (LETT |ncol| (LENGTH |alpha|))
              (LETT |temp| NIL) (LETT |help| NIL)
              (LETT |colematrix| (MAKE_MATRIX1 |nrow| |ncol| 0))
              (LETT |betasum| 0) (LETT |alphasum| 0)
              (SEQ (LETT |i| 1) (LETT #8# |ncol|) G190
                   (COND ((|greater_SI| |i| #8#) (GO G191)))
                   (SEQ (LETT |help| NIL)
                        (SEQ (LETT |j| (SPADCALL |alpha| |i| (QREFELT $ 17)))
                             G190 (COND ((< |j| 1) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |help|
                                     (CONS
                                      (SPADCALL |pi|
                                                (+
                                                 (PROG1 (LETT #7# |j|)
                                                   (|check_subtype2| (>= #7# 0)
                                                                     '(|NonNegativeInteger|)
                                                                     '(|Integer|)
                                                                     #7#))
                                                 |alphasum|)
                                                (QREFELT $ 17))
                                      |help|))))
                             (LETT |j| (+ |j| -1)) (GO G190) G191 (EXIT NIL))
                        (LETT |alphasum|
                              (PROG1
                                  (LETT #6#
                                        (+ |alphasum|
                                           (SPADCALL |alpha| |i|
                                                     (QREFELT $ 17))))
                                (|check_subtype2| (>= #6# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #6#)))
                        (EXIT
                         (LETT |temp|
                               (SPADCALL |temp|
                                         (SPADCALL |help| (QREFELT $ 48))
                                         (QREFELT $ 49)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |i| 1) (LETT #5# |nrow|) G190
                   (COND ((|greater_SI| |i| #5#) (GO G191)))
                   (SEQ (LETT |help| NIL)
                        (SEQ (LETT |j| (SPADCALL |beta| |i| (QREFELT $ 17)))
                             G190 (COND ((< |j| 1) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |help|
                                     (CONS
                                      (+
                                       (PROG1 (LETT #4# |j|)
                                         (|check_subtype2| (>= #4# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #4#))
                                       |betasum|)
                                      |help|))))
                             (LETT |j| (+ |j| -1)) (GO G190) G191 (EXIT NIL))
                        (LETT |betasum|
                              (PROG1
                                  (LETT #3#
                                        (+ |betasum|
                                           (SPADCALL |beta| |i|
                                                     (QREFELT $ 17))))
                                (|check_subtype2| (>= #3# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #3#)))
                        (EXIT
                         (SEQ (LETT |j| 1) (LETT #1# |ncol|) G190
                              (COND ((|greater_SI| |j| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (SPADCALL |colematrix| |i| |j|
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |help| (QREFELT $ 51))
                                            (SPADCALL
                                             (SPADCALL |temp| |j|
                                                       (QREFELT $ 52))
                                             (QREFELT $ 51))
                                            (QREFELT $ 53))
                                           (QREFELT $ 55))
                                          (QREFELT $ 28))))
                              (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |colematrix|)))) 

(DECLAIM (NOTINLINE |SymmetricGroupCombinatoricFunctions;|)) 

(DEFUN |SymmetricGroupCombinatoricFunctions| ()
  (SPROG NIL
         (PROG (#1=#:G897)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache|
                          '|SymmetricGroupCombinatoricFunctions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|SymmetricGroupCombinatoricFunctions|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|SymmetricGroupCombinatoricFunctions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|SymmetricGroupCombinatoricFunctions|)))))))))) 

(DEFUN |SymmetricGroupCombinatoricFunctions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|SymmetricGroupCombinatoricFunctions|))
          (LETT $ (GETREFV 57))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|SymmetricGroupCombinatoricFunctions| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SymmetricGroupCombinatoricFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Integer|)
              (|IntegerCombinatoricFunctions| 6) (0 . |binomial|)
              |SGCF;numberOfImproperPartitions;3I;2| (|List| 6) (6 . |list|)
              (11 . |append|) |SGCF;unrankImproperPartitions0;3IL;3|
              (|Boolean|) (17 . ~=) |SGCF;subSet;3IL;5| (23 . |elt|)
              (|Vector| 6) (29 . |setelt!|) (36 . |entries|)
              |SGCF;unrankImproperPartitions1;3IL;4|
              (|PartitionsAndPermutations|) (41 . |conjugate|) (46 . |elt|)
              (52 . |setelt!|) |SGCF;nextLatticePermutation;2LBL;6|
              (|Matrix| 6) (59 . |setelt!|) |SGCF;makeYoungTableau;2LM;7|
              (|List| 27) (67 . |append|) |SGCF;listYoungTableaus;LL;8|
              (73 . |vector|) (78 . |copy|) (83 . ~=) (89 . |row|) (95 . +)
              |SGCF;nextPartition;2VIV;10| (101 . =) (107 . |setRow!|)
              (114 . -) |SGCF;nextColeman;2L2M;9| |SGCF;nextPartition;LVIV;11|
              (120 . ~=) (126 . |elt|) |SGCF;inverseColeman;2LML;12|
              (|List| 10) (133 . |list|) (138 . |append|) (|Set| 6)
              (144 . |set|) (149 . |elt|) (155 . |intersect|)
              (|NonNegativeInteger|) (161 . |#|) |SGCF;coleman;3LM;13|)
           '#(|unrankImproperPartitions1| 166 |unrankImproperPartitions0| 173
              |subSet| 180 |numberOfImproperPartitions| 187 |nextPartition| 193
              |nextLatticePermutation| 207 |nextColeman| 214 |makeYoungTableau|
              221 |listYoungTableaus| 227 |inverseColeman| 232 |coleman| 239)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|coleman|
                                 ((|Matrix| (|Integer|)) (|List| (|Integer|))
                                  (|List| (|Integer|)) (|List| (|Integer|))))
                                T)
                              '((|inverseColeman|
                                 ((|List| (|Integer|)) (|List| (|Integer|))
                                  (|List| (|Integer|)) (|Matrix| (|Integer|))))
                                T)
                              '((|listYoungTableaus|
                                 ((|List| (|Matrix| (|Integer|)))
                                  (|List| (|Integer|))))
                                T)
                              '((|makeYoungTableau|
                                 ((|Matrix| (|Integer|)) (|List| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|nextColeman|
                                 ((|Matrix| (|Integer|)) (|List| (|Integer|))
                                  (|List| (|Integer|)) (|Matrix| (|Integer|))))
                                T)
                              '((|nextLatticePermutation|
                                 ((|List| (|Integer|)) (|List| (|Integer|))
                                  (|List| (|Integer|)) (|Boolean|)))
                                T)
                              '((|nextPartition|
                                 ((|Vector| (|Integer|)) (|Vector| (|Integer|))
                                  (|Vector| (|Integer|)) (|Integer|)))
                                T)
                              '((|nextPartition|
                                 ((|Vector| (|Integer|)) (|List| (|Integer|))
                                  (|Vector| (|Integer|)) (|Integer|)))
                                T)
                              '((|numberOfImproperPartitions|
                                 ((|Integer|) (|Integer|) (|Integer|)))
                                T)
                              '((|subSet|
                                 ((|List| (|Integer|)) (|Integer|) (|Integer|)
                                  (|Integer|)))
                                T)
                              '((|unrankImproperPartitions0|
                                 ((|List| (|Integer|)) (|Integer|) (|Integer|)
                                  (|Integer|)))
                                T)
                              '((|unrankImproperPartitions1|
                                 ((|List| (|Integer|)) (|Integer|) (|Integer|)
                                  (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 56
                                            '(2 7 6 6 6 8 1 10 0 6 11 2 10 0 0
                                              0 12 2 6 14 0 0 15 2 10 6 0 6 17
                                              3 18 6 0 6 6 19 1 18 10 0 20 1 22
                                              10 10 23 2 18 6 0 6 24 3 10 6 0 6
                                              6 25 4 27 6 0 6 6 6 28 2 30 0 0 0
                                              31 1 18 0 10 33 1 27 0 0 34 2 27
                                              14 0 0 35 2 27 18 0 6 36 2 18 0 0
                                              0 37 2 18 14 0 0 39 3 27 0 0 6 18
                                              40 2 18 0 0 0 41 2 18 14 0 0 44 3
                                              27 6 0 6 6 45 1 47 0 10 48 2 47 0
                                              0 0 49 1 50 0 10 51 2 47 10 0 6
                                              52 2 50 0 0 0 53 1 50 54 0 55 3 0
                                              10 6 6 6 21 3 0 10 6 6 6 13 3 0
                                              10 6 6 6 16 2 0 6 6 6 9 3 0 18 18
                                              18 6 38 3 0 18 10 18 6 43 3 0 10
                                              10 10 14 26 3 0 27 10 10 27 42 2
                                              0 27 10 10 29 1 0 30 10 32 3 0 10
                                              10 10 27 46 3 0 27 10 10 10
                                              56)))))
           '|lookupComplete|)) 

(MAKEPROP '|SymmetricGroupCombinatoricFunctions| 'NILADIC T) 

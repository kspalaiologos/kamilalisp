
(SDEFUN |IMODHP;eval1s|
        ((|gvl|
          (|List|
           (|PrimitiveArray|
            (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                      (|:| |denom| (|Polynomial| (|Integer|)))))))
         (|pt| (|Integer|)) (|var| (|Symbol|))
         (|pss|
          (|Record| (|:| |prime| #1=(|Integer|))
                    (|:| |eval1coeffbuf| (|U32Vector|))
                    (|:| |eval1expbuf| (|SortedExponentVector|))))
         ($ (|Union| (|List| (|U32Vector|)) "failed")))
        (SPROG
         ((|resl| (|List| (|U32Vector|))) (|nlc| (|Integer|))
          (|dms| (|SingleInteger|)) (#2=#:G755 NIL) (|dm| #3=(|Integer|))
          (|nm| #3#)
          (|nlcq|
           (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                     (|:| |denom| (|Polynomial| (|Integer|)))))
          (#4=#:G757 NIL) (|j| NIL) (|ress| (|U32Vector|))
          (|n| (|NonNegativeInteger|)) (#5=#:G756 NIL) (|gv0| NIL) (|p| #1#))
         (SEQ
          (EXIT
           (SEQ (LETT |p| (QVELT |pss| 0)) (LETT |resl| NIL)
                (SEQ (LETT |gv0| NIL) (LETT #5# |gvl|) G190
                     (COND
                      ((OR (ATOM #5#) (PROGN (LETT |gv0| (CAR #5#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |n| (QVSIZE |gv0|))
                          (LETT |ress| (GETREFV_U32 |n| 0))
                          (SEQ (LETT |j| 0) (LETT #4# (- |n| 1)) G190
                               (COND ((|greater_SI| |j| #4#) (GO G191)))
                               (SEQ (LETT |nlcq| (QAREF1 |gv0| |j|))
                                    (LETT |nm|
                                          (SPADCALL (QCAR |nlcq|) |pt| |pss|
                                                    (QREFELT $ 10)))
                                    (LETT |dm|
                                          (SPADCALL (QCDR |nlcq|) |pt| |pss|
                                                    (QREFELT $ 10)))
                                    (EXIT
                                     (COND
                                      ((EQL |dm| 0)
                                       (PROGN
                                        (LETT #2# (CONS 1 "failed"))
                                        (GO #6=#:G754)))
                                      ('T
                                       (SEQ (LETT |dms| |dm|)
                                            (LETT |nlc|
                                                  (QSMULMOD32 |nm|
                                                              (SPADCALL |dms|
                                                                        |p|
                                                                        (QREFELT
                                                                         $ 12))
                                                              |p|))
                                            (EXIT
                                             (SETELT_U32 |ress| |j|
                                                         |nlc|)))))))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT (LETT |resl| (CONS |ress| |resl|))))
                     (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (NREVERSE |resl|)))))
          #6# (EXIT #2#)))) 

(SDEFUN |IMODHP;eval2s|
        ((|gvl|
          (|List|
           (|PrimitiveArray|
            (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                      (|:| |denom| (|Polynomial| (|Integer|)))))))
         (|pt| (|Integer|)) (|var| (|Symbol|))
         (|pss|
          (|Record| (|:| |prime| (|Integer|))
                    (|:| |eval1coeffbuf| (|U32Vector|))
                    (|:| |eval1expbuf| (|SortedExponentVector|))))
         ($
          (|Union|
           (|List|
            (|PrimitiveArray|
             (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                       (|:| |denom| (|Polynomial| (|Integer|))))))
           "failed")))
        (SPROG
         ((|resl|
           (|List|
            (|PrimitiveArray|
             (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                       (|:| |denom| (|Polynomial| (|Integer|)))))))
          (#1=#:G778 NIL)
          (|res1|
           (|Union|
            (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                      (|:| |denom| (|Polynomial| (|Integer|))))
            "failed"))
          (|nlcq|
           (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                     (|:| |denom| (|Polynomial| (|Integer|)))))
          (#2=#:G780 NIL) (|j| NIL)
          (|ress|
           (|PrimitiveArray|
            (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                      (|:| |denom| (|Polynomial| (|Integer|))))))
          (|n| (|NonNegativeInteger|)) (#3=#:G779 NIL) (|gv0| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |resl| NIL)
                (SEQ (LETT |gv0| NIL) (LETT #3# |gvl|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |gv0| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |n| (QVSIZE |gv0|))
                          (LETT |ress|
                                (MAKEARR1 |n|
                                          (CONS (|spadConstant| $ 13)
                                                (|spadConstant| $ 14))))
                          (SEQ (LETT |j| 0) (LETT #2# (- |n| 1)) G190
                               (COND ((|greater_SI| |j| #2#) (GO G191)))
                               (SEQ (LETT |nlcq| (QAREF1 |gv0| |j|))
                                    (LETT |res1|
                                          (SPADCALL |nlcq| |var| |pt| |pss|
                                                    (QREFELT $ 18)))
                                    (EXIT
                                     (COND
                                      ((QEQCAR |res1| 1)
                                       (PROGN
                                        (LETT #1# (CONS 1 "failed"))
                                        (GO #4=#:G777)))
                                      ('T
                                       (QSETAREF1 |ress| |j| (QCDR |res1|))))))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT (LETT |resl| (CONS |ress| |resl|))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (NREVERSE |resl|)))))
          #4# (EXIT #1#)))) 

(SDEFUN |IMODHP;eval3s|
        ((|gvl|
          (|List| (|PrimitiveArray| (|Fraction| (|Polynomial| (|Integer|))))))
         (|p| (|Integer|))
         ($
          (|Union|
           (|List|
            (|PrimitiveArray|
             (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                       (|:| |denom| (|Polynomial| (|Integer|))))))
           "failed")))
        (SPROG
         ((|resl|
           (|List|
            (|PrimitiveArray|
             (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                       (|:| |denom| (|Polynomial| (|Integer|)))))))
          (#1=#:G799 NIL)
          (|res1|
           (|Union|
            (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                      (|:| |denom| (|Polynomial| (|Integer|))))
            "failed"))
          (|nlcq| (|Fraction| (|Polynomial| (|Integer|)))) (#2=#:G801 NIL)
          (|j| NIL)
          (|ress|
           (|PrimitiveArray|
            (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                      (|:| |denom| (|Polynomial| (|Integer|))))))
          (|n| (|NonNegativeInteger|)) (#3=#:G800 NIL) (|gv0| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |resl| NIL)
                (SEQ (LETT |gv0| NIL) (LETT #3# |gvl|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |gv0| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |n| (QVSIZE |gv0|))
                          (LETT |ress|
                                (MAKEARR1 |n|
                                          (CONS (|spadConstant| $ 13)
                                                (|spadConstant| $ 14))))
                          (SEQ (LETT |j| 0) (LETT #2# (- |n| 1)) G190
                               (COND ((|greater_SI| |j| #2#) (GO G191)))
                               (SEQ (LETT |nlcq| (QAREF1 |gv0| |j|))
                                    (LETT |res1|
                                          (SPADCALL |nlcq| |p| (QREFELT $ 22)))
                                    (EXIT
                                     (COND
                                      ((QEQCAR |res1| 1)
                                       (PROGN
                                        (LETT #1# (CONS 1 "failed"))
                                        (GO #4=#:G798)))
                                      ('T
                                       (QSETAREF1 |ress| |j| (QCDR |res1|))))))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT (LETT |resl| (CONS |ress| |resl|))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (NREVERSE |resl|)))))
          #4# (EXIT #1#)))) 

(SDEFUN |IMODHP;do_modular_solve0|
        ((|gv| (|Vector| (|U32Vector|))) (|ve| (|Vector| (|Integer|)))
         (|sigma| (|NonNegativeInteger|)) (|pts| (|U32Vector|))
         (|prime| (|Integer|)) (|kind| (|Symbol|)) ($ (|List| (|Any|))))
        (COND
         ((OR (EQUAL |kind| '|diffHP|) (EQUAL |kind| '|qdiffHP|))
          (SPADCALL |gv| |ve| |sigma| |prime| (QREFELT $ 28)))
         ((OR (EQUAL |kind| '|shiftHP|)
              (OR (EQUAL |kind| '|qshiftHP|) (EQUAL |kind| '|qmixed|)))
          (SPADCALL |gv| |ve| |pts| |prime| (QREFELT $ 30)))
         ('T
          (|error|
           "kind must be diffHP, qdiffHP, shiftHP, qshiftHP or qmixed")))) 

(SDEFUN |IMODHP;do_modular_solve;VVNniUvISU;5|
        ((|gv| (|Vector| (|U32Vector|))) (|ve| (|Vector| (|Integer|)))
         (|sigma| (|NonNegativeInteger|)) (|pts| (|U32Vector|))
         (|prime| (|Integer|)) (|kind| (|Symbol|))
         ($
          (|Union|
           (|Record| (|:| |basis| #1=(|TwoDimensionalArray| (|U32Vector|)))
                     (|:| |defects| (|Vector| (|Integer|)))
                     (|:| |cinds| (|Vector| (|Integer|))))
           "no_solution")))
        (SPROG
         ((#2=#:G860 NIL) (|j| (|Integer|)) (#3=#:G859 NIL) (#4=#:G867 NIL)
          (|i| NIL) (|cindk| (|Integer|)) (#5=#:G866 NIL) (|k| NIL)
          (#6=#:G865 NIL) (#7=#:G864 NIL)
          (|nbas| (|TwoDimensionalArray| (|U32Vector|)))
          (|nr| (|NonNegativeInteger|)) (|bas| #1#)
          (|res|
           (|Record| (|:| |basis| (|TwoDimensionalArray| (|U32Vector|)))
                     (|:| |defects| (|Vector| (|Integer|)))
                     (|:| |cinds| (|Vector| (|Integer|)))))
          (|bm| (|Vector| (|U32Vector|))) (|dbm| #8=(|Any|)) (|ok| (|Boolean|))
          (#9=#:G863 NIL) (|m2| #10=(|NonNegativeInteger|))
          (|va| (|Vector| (|Integer|))) (|dva| #8#) (|blr| (|List| (|Any|)))
          (|nve| (|Vector| (|Integer|))) (|ngv| (|Vector| (|U32Vector|)))
          (#11=#:G862 NIL) (|m1| (|NonNegativeInteger|)) (#12=#:G861 NIL)
          (|m0| #10#))
         (SEQ
          (EXIT
           (SEQ (LETT |m0| (QVSIZE |ve|)) (LETT |m1| 0)
                (SEQ (LETT |i| 1) (LETT #12# |m0|) G190
                     (COND ((|greater_SI| |i| #12#) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((>= (SPADCALL |ve| |i| (QREFELT $ 31)) 0)
                         (LETT |m1| (+ |m1| 1))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((< |m1| |m0|)
                  (SEQ (LETT |ngv| (MAKEARR1 |m1| (GETREFV_U32 0 0)))
                       (LETT |nve| (MAKEARR1 |m1| 0)) (LETT |j| 1)
                       (EXIT
                        (SEQ (LETT |i| 1) (LETT #11# |m0|) G190
                             (COND ((|greater_SI| |i| #11#) (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((>= (SPADCALL |ve| |i| (QREFELT $ 31)) 0)
                                 (SEQ
                                  (SPADCALL |ngv| |j|
                                            (SPADCALL |gv| |i| (QREFELT $ 32))
                                            (QREFELT $ 33))
                                  (SPADCALL |nve| |j|
                                            (SPADCALL |ve| |i| (QREFELT $ 31))
                                            (QREFELT $ 34))
                                  (EXIT (LETT |j| (+ |j| 1))))))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL)))))
                 (#13='T (SEQ (LETT |ngv| |gv|) (EXIT (LETT |nve| |ve|)))))
                (LETT |blr|
                      (|IMODHP;do_modular_solve0| |ngv| |nve| |sigma| |pts|
                       |prime| |kind| $))
                (LETT |dva| (SPADCALL |blr| 3 (QREFELT $ 36)))
                (LETT |va| (SPADCALL |dva| (QREFELT $ 38))) (LETT |ok| NIL)
                (LETT |m2| (QVSIZE |va|))
                (SEQ (LETT |i| 1) (LETT #9# |m2|) G190
                     (COND ((|greater_SI| |i| #9#) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |ok|
                             (COND (|ok| 'T)
                                   ('T
                                    (>= (SPADCALL |va| |i| (QREFELT $ 31))
                                        0))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT
                 (COND
                  (|ok|
                   (SEQ (LETT |dbm| (SPADCALL |blr| 1 (QREFELT $ 36)))
                        (LETT |bm| (SPADCALL |dbm| (QREFELT $ 40)))
                        (LETT |res|
                              (SPADCALL |bm| |nve| |va| |prime|
                                        (QREFELT $ 42)))
                        (COND
                         ((< |m1| |m0|)
                          (SEQ (LETT |bas| (QVELT |res| 0))
                               (LETT |nr| (ANROWS |bas|))
                               (LETT |nbas|
                                     (MAKE_MATRIX1 |nr| |m0|
                                                   (GETREFV_U32 0 0)))
                               (LETT |j| 1)
                               (SEQ (LETT |i| 1) (LETT #7# |m0|) G190
                                    (COND ((|greater_SI| |i| #7#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((>= (SPADCALL |ve| |i| (QREFELT $ 31))
                                            0)
                                        (SEQ
                                         (SEQ (LETT |k| 1) (LETT #6# |nr|) G190
                                              (COND
                                               ((|greater_SI| |k| #6#)
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (QSETAREF2O |nbas| |k| |i|
                                                            (QAREF2O |bas| |k|
                                                                     |j| 1 1)
                                                            1 1)))
                                              (LETT |k| (|inc_SI| |k|))
                                              (GO G190) G191 (EXIT NIL))
                                         (EXIT (LETT |j| (+ |j| 1))))))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT NIL))
                               (QSETVELT |res| 0 |nbas|)
                               (EXIT
                                (SEQ (LETT |k| 1) (LETT #5# |nr|) G190
                                     (COND ((|greater_SI| |k| #5#) (GO G191)))
                                     (SEQ
                                      (LETT |cindk|
                                            (SPADCALL (QVELT |res| 2) |k|
                                                      (QREFELT $ 31)))
                                      (LETT |j| 1)
                                      (EXIT
                                       (SEQ
                                        (EXIT
                                         (SEQ (LETT |i| 1) (LETT #4# |m0|) G190
                                              (COND
                                               ((|greater_SI| |i| #4#)
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (COND
                                                 ((>=
                                                   (SPADCALL |ve| |i|
                                                             (QREFELT $ 31))
                                                   0)
                                                  (SEQ
                                                   (COND
                                                    ((EQL |j| |cindk|)
                                                     (SEQ
                                                      (SPADCALL (QVELT |res| 2)
                                                                |k| |i|
                                                                (QREFELT $ 34))
                                                      (EXIT
                                                       (PROGN
                                                        (LETT #3# 1)
                                                        (GO #14=#:G849))))))
                                                   (EXIT
                                                    (LETT |j| (+ |j| 1))))))))
                                              (LETT |i| (|inc_SI| |i|))
                                              (GO G190) G191 (EXIT NIL)))
                                        #14# (EXIT #3#))))
                                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                     (EXIT NIL))))))
                        (EXIT (CONS 0 |res|))))
                  (#13#
                   (PROGN
                    (LETT #2# (CONS 1 "no_solution"))
                    (GO #15=#:G858)))))))
          #15# (EXIT #2#)))) 

(SDEFUN |IMODHP;compute_blocks|
        ((|offsets| (|Vector| (|Integer|))) (|rowlen| (|Integer|))
         (|nsols| (|Integer|)) ($ (|Vector| (|Integer|))))
        (SPROG
         ((#1=#:G872 NIL) (|i| NIL) (|block_offsets| (|Vector| (|Integer|))))
         (SEQ (LETT |block_offsets| (MAKEARR1 |nsols| 0))
              (SEQ (LETT |i| 1) (LETT #1# |nsols|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |block_offsets| |i|
                               (SPADCALL |offsets| (+ (* (- |i| 1) |rowlen|) 1)
                                         (QREFELT $ 31))
                               (QREFELT $ 34))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |block_offsets|)))) 

(SDEFUN |IMODHP;merge_exponents;IVSevVSevL;7|
        ((|nvars| (|Integer|)) (|offsets| (|Vector| (|Integer|)))
         (|exps| (|SortedExponentVector|)) (|noffsets| (|Vector| (|Integer|)))
         (|nexps| (|SortedExponentVector|)) ($ (|List| (|List| (|Integer|)))))
        (SPROG
         ((|j0| (|Integer|)) (|i0| (|Integer|)) (|j| (|Integer|))
          (|i| (|Integer|)) (|ci| (|Integer|)) (#1=#:G904 NIL)
          (|j0i| (|Integer|)) (|ji| #2=(|Integer|)) (|jl| (|List| (|Integer|)))
          (|i0i| (|Integer|)) (|ii| #2#) (|il| (|List| (|Integer|)))
          (#3=#:G908 NIL) (|k| NIL) (|lj| (|Integer|)) (|li| (|Integer|))
          (#4=#:G905 NIL) (#5=#:G907 NIL) (|jj| NIL) (#6=#:G906 NIL)
          (|kk| (|Integer|)) (|nn| (|Integer|)) (|oc| (|NonNegativeInteger|))
          (|m| #7=(|Integer|)) (|n| #7#))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QUOTIENT2 (QV_LEN_U32 |exps|) |nvars|))
                (LETT |m| (QUOTIENT2 (QV_LEN_U32 |nexps|) |nvars|))
                (LETT |oc| (QVSIZE |offsets|)) (LETT |i0| 0) (LETT |j0| 0)
                (LETT |ci| 0) (LETT |i| 0) (LETT |j| 0) (LETT |li| 0)
                (LETT |lj| 0) (LETT |il| NIL) (LETT |jl| NIL) (LETT |kk| 1)
                (LETT |nn| (- |nvars| 1))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (LETT |i0i| 1) (LETT |j0i| 1) (LETT |ii| |nvars|)
                           (LETT |ji| |nvars|)
                           (COND
                            ((OR (EQL |i0| |li|) (EQL |j0| |lj|))
                             (EXIT
                              (SEQ (LETT |kk| (+ |kk| 1))
                                   (COND
                                    ((< |i0| |li|)
                                     (SEQ (LETT |jj| |i0|)
                                          (LETT #6# (- |li| 1)) G190
                                          (COND ((> |jj| #6#) (GO G191)))
                                          (SEQ (LETT |jl| (CONS |ci| |jl|))
                                               (EXIT (LETT |ci| (+ |ci| 1))))
                                          (LETT |jj| (+ |jj| 1)) (GO G190) G191
                                          (EXIT NIL))))
                                   (COND
                                    ((< |j0| |lj|)
                                     (SEQ (LETT |jj| |j0|)
                                          (LETT #5# (- |lj| 1)) G190
                                          (COND ((> |jj| #5#) (GO G191)))
                                          (SEQ (LETT |il| (CONS |ci| |il|))
                                               (EXIT (LETT |ci| (+ |ci| 1))))
                                          (LETT |jj| (+ |jj| 1)) (GO G190) G191
                                          (EXIT NIL))))
                                   (EXIT
                                    (COND
                                     ((EQL |li| |n|)
                                      (PROGN
                                       (LETT #4#
                                             (LIST (NREVERSE |il|)
                                                   (NREVERSE |jl|)))
                                       (GO #8=#:G903)))
                                     ('T
                                      (SEQ (LETT |i0| |li|) (LETT |j0| |lj|)
                                           (LETT |i| (* |i0| |nvars|))
                                           (LETT |j| (* |j0| |nvars|))
                                           (EXIT
                                            (COND
                                             ((<= |kk| |oc|)
                                              (SEQ
                                               (LETT |li|
                                                     (SPADCALL |offsets| |kk|
                                                               (QREFELT $ 31)))
                                               (EXIT
                                                (LETT |lj|
                                                      (SPADCALL |noffsets| |kk|
                                                                (QREFELT $
                                                                         31))))))
                                             ('T
                                              (SEQ (LETT |li| |n|)
                                                   (EXIT
                                                    (LETT |lj|
                                                          |m|))))))))))))))
                           (SEQ
                            (EXIT
                             (SEQ (LETT |k| 0) (LETT #3# |nn|) G190
                                  (COND ((|greater_SI| |k| #3#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL (ELT_U32 |exps| (+ |i| |k|))
                                                (ELT_U32 |nexps| (+ |j| |k|))
                                                (QREFELT $ 46))
                                      (PROGN
                                       (LETT #1#
                                             (COND
                                              ((> (ELT_U32 |exps| (+ |i| |k|))
                                                  (ELT_U32 |nexps|
                                                           (+ |j| |k|)))
                                               (SEQ
                                                (LETT |il| (CONS |ci| |il|))
                                                (LETT |ii| 0) (LETT |i0i| 0)
                                                (EXIT
                                                 (PROGN
                                                  (LETT #1# 1)
                                                  (GO #9=#:G899)))))
                                              ('T
                                               (SEQ
                                                (LETT |jl| (CONS |ci| |jl|))
                                                (LETT |ji| 0) (LETT |j0i| 0)
                                                (EXIT
                                                 (PROGN
                                                  (LETT #1# 1)
                                                  (GO #9#)))))))
                                       (GO #9#))))))
                                  (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                  (EXIT NIL)))
                            #9# (EXIT #1#))
                           (LETT |ci| (+ |ci| 1)) (LETT |i| (+ |i| |ii|))
                           (LETT |j| (+ |j| |ji|)) (LETT |i0| (+ |i0| |i0i|))
                           (EXIT (LETT |j0| (+ |j0| |j0i|))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #8# (EXIT #4#)))) 

(SDEFUN |IMODHP;merge2;I2LVSevVSevR;8|
        ((|nvars| (|Integer|)) (|odl| (|List| (|Integer|)))
         (|ndl| (|List| (|Integer|))) (|ov1| (|Vector| (|Integer|)))
         (|exps1| (|SortedExponentVector|)) (|ov2| (|Vector| (|Integer|)))
         (|exps2| (|SortedExponentVector|))
         ($
          (|Record| (|:| |offsetdata| (|Vector| (|Integer|)))
                    (|:| |expdata| (|SortedExponentVector|)))))
        (SPROG
         ((#1=#:G940 NIL) (|i| (|Integer|)) (|ci| (|Integer|))
          (|i00| (|Integer|)) (|i0| (|Integer|)) (|j0| (|Integer|))
          (|j| (|Integer|)) (#2=#:G939 NIL) (|k| NIL) (|j00| (|Integer|))
          (#3=#:G938 NIL) (|lj| #4=(|Integer|)) (|li| #4#) (|kk| (|Integer|))
          (#5=#:G937 NIL) (|ci0| (|Integer|)) (|nv1| (|Integer|))
          (|noffsets| (|Vector| (|Integer|))) (|m| (|NonNegativeInteger|))
          (|nexps| (|SortedExponentVector|)) (#6=#:G911 NIL)
          (|nn1| (|Integer|)) (|n1| (|Integer|)) (|nn| (|NonNegativeInteger|))
          (|n0| (|NonNegativeInteger|)))
         (SEQ (LETT |n0| (QV_LEN_U32 |exps1|)) (LETT |nn| (LENGTH |odl|))
              (LETT |n1| (+ (QUOTIENT2 |n0| |nvars|) |nn|))
              (LETT |nn1| (* |n1| |nvars|))
              (LETT |nexps|
                    (GETREFV_U32
                     (PROG1 (LETT #6# |nn1|)
                       (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #6#))
                     0))
              (LETT |m| (QVSIZE |ov2|)) (LETT |noffsets| (MAKEARR1 |m| 0))
              (LETT |nv1| (- |nvars| 1)) (LETT |i0| 0) (LETT |j0| 0)
              (LETT |ci0| 0) (LETT |i| 0) (LETT |j| 0) (LETT |ci| 0)
              (LETT |j00| (COND ((NULL |ndl|) |n1|) ('T (|SPADfirst| |ndl|))))
              (LETT |i00| (|SPADfirst| |odl|))
              (LETT |li| (SPADCALL |ov1| 1 (QREFELT $ 31)))
              (LETT |lj| (SPADCALL |ov2| 1 (QREFELT $ 31))) (LETT |kk| 1)
              (SEQ (LETT |ci0| 0) (LETT #5# (- |n1| 1)) G190
                   (COND ((|greater_SI| |ci0| #5#) (GO G191)))
                   (SEQ
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((EQL |i0| |li|) (EQL |j0| |lj|)) ('T NIL)))
                           (GO G191)))
                         (SEQ (SPADCALL |noffsets| |kk| |ci0| (QREFELT $ 34))
                              (LETT |kk| (+ |kk| 1))
                              (EXIT
                               (COND
                                ((<= |kk| |m|)
                                 (SEQ
                                  (LETT |li|
                                        (SPADCALL |ov1| |kk| (QREFELT $ 31)))
                                  (EXIT
                                   (LETT |lj|
                                         (SPADCALL |ov2| |kk|
                                                   (QREFELT $ 31))))))
                                ('T
                                 (SEQ (LETT |li| |n1|)
                                      (EXIT (LETT |lj| |n1|)))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (COND
                     ((EQL |ci0| |j00|)
                      (SEQ
                       (SEQ (LETT |k| 0) (LETT #3# |nv1|) G190
                            (COND ((|greater_SI| |k| #3#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SETELT_U32 |nexps| (+ |ci| |k|)
                                          (ELT_U32 |exps1| (+ |i| |k|)))))
                            (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                            (EXIT NIL))
                       (LETT |ndl| (CDR |ndl|))
                       (EXIT
                        (LETT |j00|
                              (COND ((NULL |ndl|) |n1|)
                                    ('T (|SPADfirst| |ndl|)))))))
                     ('T
                      (SEQ
                       (SEQ (LETT |k| 0) (LETT #2# |nv1|) G190
                            (COND ((|greater_SI| |k| #2#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SETELT_U32 |nexps| (+ |ci| |k|)
                                          (ELT_U32 |exps2| (+ |j| |k|)))))
                            (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                            (EXIT NIL))
                       (LETT |j| (+ |j| |nvars|))
                       (EXIT (LETT |j0| (+ |j0| 1))))))
                    (COND
                     ((SPADCALL |ci0| |i00| (QREFELT $ 46))
                      (SEQ (LETT |i| (+ |i| |nvars|))
                           (EXIT (LETT |i0| (+ |i0| 1)))))
                     ('T
                      (SEQ (LETT |odl| (CDR |odl|))
                           (EXIT
                            (LETT |i00|
                                  (COND ((NULL |odl|) |n1|)
                                        ('T (|SPADfirst| |odl|))))))))
                    (EXIT (LETT |ci| (+ |ci| |nvars|))))
                   (LETT |ci0| (|inc_SI| |ci0|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |i| |kk|) (LETT #1# |m|) G190
                   (COND ((> |i| #1#) (GO G191)))
                   (SEQ (EXIT (SPADCALL |noffsets| |i| |n1| (QREFELT $ 34))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |noffsets| |nexps|))))) 

(SDEFUN |IMODHP;check_defects|
        ((|va| (|Vector| (|Integer|))) (|civ| (|Vector| (|Integer|)))
         (|pss|
          (|Record| (|:| |degree_bounds| (|Vector| (|Integer|)))
                    (|:| |pss_sigma| (|NonNegativeInteger|))
                    (|:| |points| (|U32Vector|)) (|:| |pss_qvar| (|Symbol|))
                    (|:| |pss_qval| (|Integer|)) (|:| |pss_kind| (|Symbol|))
                    (|:| |oldva| #1=(|Vector| (|Integer|)))
                    (|:| |oldciv| #2=(|Vector| (|Integer|)))
                    (|:| |pss_m| (|Integer|)) (|:| |sol_cnt| #3=(|Integer|))
                    (|:| |pss1|
                         (|Record| (|:| |prime| (|Integer|))
                                   (|:| |eval1coeffbuf| (|U32Vector|))
                                   (|:| |eval1expbuf|
                                        (|SortedExponentVector|))))))
         ($ (|Union| "OK" "failed" "all_bad")))
        (SPROG
         ((#4=#:G961 NIL) (#5=#:G960 NIL) (|is_bad| (|Boolean|))
          (|all_bad| (|Boolean|)) (#6=#:G962 NIL) (|i| NIL) (|ociv| #2#)
          (|ova| #1#) (|nsols| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |nsols| (QVELT |pss| 9))
                (LETT |is_bad| (> (QVSIZE |va|) |nsols|))
                (LETT |all_bad| (< (QVSIZE |va|) |nsols|))
                (COND
                 ((EQL (QVSIZE |va|) |nsols|)
                  (SEQ (LETT |ova| (QVELT |pss| 6))
                       (LETT |ociv| (QVELT |pss| 7))
                       (EXIT
                        (SEQ
                         (EXIT
                          (SEQ (LETT |i| 1) (LETT #6# |nsols|) G190
                               (COND ((|greater_SI| |i| #6#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((< (SPADCALL |va| |i| (QREFELT $ 31))
                                      (SPADCALL |ova| |i| (QREFELT $ 31)))
                                   (SEQ (LETT |all_bad| 'T)
                                        (EXIT
                                         (PROGN (LETT #5# 1) (GO #7=#:G955)))))
                                  ((> (SPADCALL |va| |i| (QREFELT $ 31))
                                      (SPADCALL |ova| |i| (QREFELT $ 31)))
                                   (SEQ (LETT |is_bad| 'T)
                                        (EXIT (PROGN (LETT #5# 1) (GO #7#)))))
                                  ((< (SPADCALL |civ| |i| (QREFELT $ 31))
                                      (SPADCALL |ociv| |i| (QREFELT $ 31)))
                                   (SEQ (LETT |all_bad| 'T)
                                        (EXIT (PROGN (LETT #5# 1) (GO #7#)))))
                                  ((> (SPADCALL |civ| |i| (QREFELT $ 31))
                                      (SPADCALL |ociv| |i| (QREFELT $ 31)))
                                   (SEQ (LETT |is_bad| 'T)
                                        (EXIT
                                         (PROGN (LETT #5# 1) (GO #7#))))))))
                               (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                               (EXIT NIL)))
                         #7# (EXIT #5#))))))
                (EXIT
                 (COND
                  (|is_bad|
                   (PROGN (LETT #4# (CONS 1 "failed")) (GO #8=#:G959)))
                  (|all_bad| (PROGN (LETT #4# (CONS 2 "all_bad")) (GO #8#)))
                  ('T (PROGN (LETT #4# (CONS 0 "OK")) (GO #8#)))))))
          #8# (EXIT #4#)))) 

(SDEFUN |IMODHP;eval_and_solve|
        ((|pt| (|Integer|)) (|vars| (|List| (|Symbol|)))
         (|gvl|
          (|List|
           (|PrimitiveArray|
            (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                      (|:| |denom| (|Polynomial| (|Integer|)))))))
         (|pss|
          (|Record| (|:| |degree_bounds| #1=(|Vector| (|Integer|)))
                    (|:| |pss_sigma| (|NonNegativeInteger|))
                    (|:| |points| (|U32Vector|)) (|:| |pss_qvar| (|Symbol|))
                    (|:| |pss_qval| (|Integer|)) (|:| |pss_kind| (|Symbol|))
                    (|:| |oldva| (|Vector| (|Integer|)))
                    (|:| |oldciv| (|Vector| (|Integer|)))
                    (|:| |pss_m| (|Integer|)) (|:| |sol_cnt| (|Integer|))
                    (|:| |pss1|
                         #2=(|Record| (|:| |prime| #3=(|Integer|))
                                      (|:| |eval1coeffbuf| (|U32Vector|))
                                      (|:| |eval1expbuf|
                                           (|SortedExponentVector|))))))
         (|gen|
          (|Mapping| #4=(|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|)))
         ($
          (|Union|
           (|Record| (|:| |defects| (|Vector| (|Integer|)))
                     (|:| |cinds| (|Vector| (|Integer|)))
                     (|:| |rowlen| (|Integer|))
                     (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))
                     (|:| |coeffdata| (|U32Vector|)))
           "failed" "no_solution")))
        (SPROG
         ((#5=#:G1006 NIL)
          (|ngvl|
           (|List|
            (|PrimitiveArray|
             (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                       (|:| |denom| (|Polynomial| (|Integer|)))))))
          (|ngv0p|
           (|Union|
            (|List|
             (|PrimitiveArray|
              (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                        (|:| |denom| (|Polynomial| (|Integer|))))))
            "failed"))
          (#6=#:G1011 NIL) (|i| NIL) (|nev| #7=(|SortedExponentVector|))
          (#8=#:G992 NIL) (|ncv| #9=(|U32Vector|)) (#10=#:G990 NIL)
          (|k| (|Integer|)) (|cpl| (|Integer|)) (#11=#:G1010 NIL) (|l| NIL)
          (|cp| (|U32Vector|)) (|mm| (|Integer|)) (|k1| (|Integer|))
          (#12=#:G1009 NIL) (|j| NIL) (#13=#:G1008 NIL)
          (|ov| (|Vector| (|Integer|))) (|ev| #7#) (#14=#:G979 NIL) (|cv| #9#)
          (#15=#:G977 NIL) (|r_cnt| (|Integer|)) (#16=#:G1007 NIL)
          (|m| #17=(|NonNegativeInteger|)) (|nsols| #17#)
          (|civ| #18=(|Vector| (|Integer|))) (|va| #19=(|Vector| (|Integer|)))
          (|bm| #20=(|TwoDimensionalArray| (|U32Vector|)))
          (|rblr|
           (|Record| (|:| |basis| (|TwoDimensionalArray| (|U32Vector|)))
                     (|:| |defects| (|Vector| (|Integer|)))
                     (|:| |cinds| (|Vector| (|Integer|)))))
          (|blr|
           (|Union|
            (|Record| (|:| |basis| #20#) (|:| |defects| #19#)
                      (|:| |cinds| #18#))
            "no_solution"))
          (|ve| #1#) (|ngv2| #4#) (|ngv10| (|List| (|U32Vector|)))
          (|ngv10p| (|Union| (|List| (|U32Vector|)) "failed"))
          (|nvars| (|NonNegativeInteger|)) (|p| #3#) (|pss1| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |pss1| (QVELT |pss| 10)) (LETT |p| (QVELT |pss1| 0))
                (LETT |nvars| (LENGTH |vars|))
                (EXIT
                 (COND
                  ((EQL |nvars| 1)
                   (SEQ
                    (LETT |ngv10p|
                          (|IMODHP;eval1s| |gvl| |pt| (|SPADfirst| |vars|)
                           |pss1| $))
                    (EXIT
                     (COND
                      ((QEQCAR |ngv10p| 1)
                       (PROGN (LETT #5# (CONS 1 "failed")) (GO #21=#:G1005)))
                      (#22='T
                       (SEQ (LETT |ngv10| (QCDR |ngv10p|))
                            (LETT |ngv2|
                                  (SPADCALL |ngv10| |p| (QVELT |pss| 4) |gen|))
                            (LETT |ve| (QVELT |pss| 0))
                            (LETT |blr|
                                  (SPADCALL |ngv2| |ve| (QVELT |pss| 1)
                                            (QVELT |pss| 2) |p| (QVELT |pss| 5)
                                            (QREFELT $ 44)))
                            (EXIT
                             (COND
                              ((QEQCAR |blr| 1)
                               (PROGN
                                (LETT #5# (CONS 2 "no_solution"))
                                (GO #21#)))
                              (#22#
                               (SEQ (LETT |rblr| (QCDR |blr|))
                                    (LETT |bm| (QVELT |rblr| 0))
                                    (LETT |va| (QVELT |rblr| 1))
                                    (LETT |civ| (QVELT |rblr| 2))
                                    (LETT |nsols| (QVSIZE |va|))
                                    (LETT |r_cnt| 0) (LETT |m| (QVSIZE |ve|))
                                    (SEQ (LETT |j| 1) (LETT #16# |m|) G190
                                         (COND
                                          ((|greater_SI| |j| #16#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT |r_cnt|
                                                 (+
                                                  (+ |r_cnt|
                                                     (SPADCALL |ve| |j|
                                                               (QREFELT $ 31)))
                                                  1))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT NIL))
                                    (LETT |r_cnt| (* |r_cnt| |nsols|))
                                    (LETT |cv|
                                          (GETREFV_U32
                                           (PROG1 (LETT #15# |r_cnt|)
                                             (|check_subtype2| (>= #15# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #15#))
                                           0))
                                    (LETT |ev|
                                          (GETREFV_U32
                                           (PROG1 (LETT #14# |r_cnt|)
                                             (|check_subtype2| (>= #14# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #14#))
                                           0))
                                    (LETT |ov| (MAKEARR1 (* |nsols| |m|) 0))
                                    (LETT |k| 0) (LETT |k1| 1)
                                    (SEQ (LETT |i| 1) (LETT #13# |nsols|) G190
                                         (COND
                                          ((|greater_SI| |i| #13#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (SEQ (LETT |j| 1) (LETT #12# |m|)
                                                G190
                                                (COND
                                                 ((|greater_SI| |j| #12#)
                                                  (GO G191)))
                                                (SEQ
                                                 (SPADCALL |ov| |k1| |k|
                                                           (QREFELT $ 34))
                                                 (LETT |k1| (+ |k1| 1))
                                                 (LETT |mm|
                                                       (SPADCALL |ve| |j|
                                                                 (QREFELT $
                                                                          31)))
                                                 (LETT |cp|
                                                       (SPADCALL |bm| |i| |j|
                                                                 (QREFELT $
                                                                          54)))
                                                 (EXIT
                                                  (SEQ (LETT |l| 0)
                                                       (LETT #11# |mm|) G190
                                                       (COND
                                                        ((|greater_SI| |l|
                                                                       #11#)
                                                         (GO G191)))
                                                       (SEQ
                                                        (LETT |cpl|
                                                              (ELT_U32 |cp|
                                                                       |l|))
                                                        (EXIT
                                                         (COND
                                                          ((SPADCALL |cpl| 0
                                                                     (QREFELT $
                                                                              46))
                                                           (SEQ
                                                            (SETELT_U32 |cv|
                                                                        |k|
                                                                        |cpl|)
                                                            (SETELT_U32 |ev|
                                                                        |k|
                                                                        |l|)
                                                            (EXIT
                                                             (LETT |k|
                                                                   (+ |k|
                                                                      1))))))))
                                                       (LETT |l|
                                                             (|inc_SI| |l|))
                                                       (GO G190) G191
                                                       (EXIT NIL))))
                                                (LETT |j| (|inc_SI| |j|))
                                                (GO G190) G191 (EXIT NIL))))
                                         (LETT |i| (|inc_SI| |i|)) (GO G190)
                                         G191 (EXIT NIL))
                                    (LETT |ncv|
                                          (GETREFV_U32
                                           (PROG1 (LETT #10# |k|)
                                             (|check_subtype2| (>= #10# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #10#))
                                           0))
                                    (LETT |nev|
                                          (GETREFV_U32
                                           (PROG1 (LETT #8# |k|)
                                             (|check_subtype2| (>= #8# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #8#))
                                           0))
                                    (SEQ (LETT |i| 0) (LETT #6# (- |k| 1)) G190
                                         (COND
                                          ((|greater_SI| |i| #6#) (GO G191)))
                                         (SEQ
                                          (SETELT_U32 |ncv| |i|
                                                      (ELT_U32 |cv| |i|))
                                          (EXIT
                                           (SETELT_U32 |nev| |i|
                                                       (ELT_U32 |ev| |i|))))
                                         (LETT |i| (|inc_SI| |i|)) (GO G190)
                                         G191 (EXIT NIL))
                                    (EXIT
                                     (PROGN
                                      (LETT #5#
                                            (CONS 0
                                                  (VECTOR |va| |civ| |m| |ov|
                                                          |nev| |ncv|)))
                                      (GO #21#)))))))))))))
                  (#22#
                   (SEQ
                    (LETT |ngv0p|
                          (|IMODHP;eval2s| |gvl| |pt| (|SPADfirst| |vars|)
                           |pss1| $))
                    (EXIT
                     (COND
                      ((QEQCAR |ngv0p| 1)
                       (PROGN (LETT #5# (CONS 1 "failed")) (GO #21#)))
                      (#22#
                       (SEQ (LETT |ngvl| (QCDR |ngv0p|))
                            (EXIT
                             (PROGN
                              (LETT #5#
                                    (|IMODHP;do_poly_modular| (CDR |vars|)
                                     |ngvl| |pss| |gen| $))
                              (GO #21#)))))))))))))
          #21# (EXIT #5#)))) 

(SDEFUN |IMODHP;do_poly_modular|
        ((|vars| (|List| (|Symbol|)))
         (|gvl|
          (|List|
           (|PrimitiveArray|
            (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                      (|:| |denom| (|Polynomial| (|Integer|)))))))
         (|pss|
          (|Record| (|:| |degree_bounds| (|Vector| (|Integer|)))
                    (|:| |pss_sigma| (|NonNegativeInteger|))
                    (|:| |points| #1=(|U32Vector|)) (|:| |pss_qvar| (|Symbol|))
                    (|:| |pss_qval| (|Integer|)) (|:| |pss_kind| (|Symbol|))
                    (|:| |oldva| (|Vector| (|Integer|)))
                    (|:| |oldciv| (|Vector| (|Integer|)))
                    (|:| |pss_m| #2=(|Integer|)) (|:| |sol_cnt| (|Integer|))
                    (|:| |pss1|
                         (|Record| (|:| |prime| #3=(|Integer|))
                                   (|:| |eval1coeffbuf| (|U32Vector|))
                                   (|:| |eval1expbuf|
                                        (|SortedExponentVector|))))))
         (|gen|
          (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|)))
         ($
          (|Union|
           (|Record| (|:| |defects| (|Vector| (|Integer|)))
                     (|:| |cinds| (|Vector| (|Integer|)))
                     (|:| |rowlen| (|Integer|))
                     (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))
                     (|:| |coeffdata| (|U32Vector|)))
           "failed" "no_solution")))
        (SPROG
         ((#4=#:G1069 NIL)
          (|rr|
           (|Record| (|:| |nvars| (|Integer|))
                     (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))
                     (|:| |coeffdata| (|U32Vector|))))
          (|pp|
           (|Union|
            (|Record| (|:| |nvars| (|Integer|))
                      (|:| |offsetdata| (|Vector| (|Integer|)))
                      (|:| |expdata| (|SortedExponentVector|))
                      (|:| |coeffdata| (|U32Vector|)))
            "failed"))
          (#5=#:G1073 NIL) (|j| NIL) (|hi| #6=(|Integer|)) (|lo| #6#)
          (|invc| (|Integer|)) (#7=#:G1068 NIL) (|ok| #8=(|Boolean|))
          (|nofi| #6#) (|ofi| #6#) (|ofin| #9=(|Integer|)) (|cnum| #6#)
          (#10=#:G1072 NIL) (|i| (|Integer|)) (|n1| (|NonNegativeInteger|))
          (|block_offsets| (|Vector| (|Integer|))) (|coeffs| (|U32Vector|))
          (|jl| (|Integer|)) (|ndl| #11=(|List| (|Integer|))) (#12=#:G1071 NIL)
          (|ncoeffs| (|U32Vector|)) (|nn| (|NonNegativeInteger|))
          (|n0| (|NonNegativeInteger|))
          (|rstate| (|VectorModularReconstructor|))
          (|ncc| (|NonNegativeInteger|)) (|exps| (|SortedExponentVector|))
          (|offsets| (|Vector| (|Integer|)))
          (|oer|
           (|Record| (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))))
          (|odl| #11#) (|dl| (|List| (|List| (|Integer|))))
          (|good_cnt| #13=(|Integer|)) (|all_bad| #8#) (|nsols| #9#)
          (|bad_cnt| #13#) (|chk_ress| (|Union| "OK" "failed" "all_bad"))
          (|noffsets| (|Vector| (|Integer|)))
          (|nexps| (|SortedExponentVector|)) (|civ| (|Vector| (|Integer|)))
          (|va| (|Vector| (|Integer|)))
          (|ppr|
           (|Record| (|:| |defects| (|Vector| (|Integer|)))
                     (|:| |cinds| (|Vector| (|Integer|)))
                     (|:| |rowlen| (|Integer|))
                     (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))
                     (|:| |coeffdata| (|U32Vector|))))
          (|pprp|
           (|Union|
            (|Record| (|:| |defects| (|Vector| (|Integer|)))
                      (|:| |cinds| (|Vector| (|Integer|)))
                      (|:| |rowlen| (|Integer|))
                      (|:| |offsetdata| (|Vector| (|Integer|)))
                      (|:| |expdata| (|SortedExponentVector|))
                      (|:| |coeffdata| (|U32Vector|)))
            "failed" "no_solution"))
          (|qn| (|Integer|)) (#14=#:G1070 NIL) (|k| NIL) (|pts| #1#)
          (|npt| (|Integer|)) (|lpt| (|List| (|Integer|))) (|pt| (|Integer|))
          (|nvars| (|NonNegativeInteger|)) (|m| #2#) (|p| #3#)
          (|update_qval| (|Boolean|)) (|update_points| #8#))
         (SEQ
          (EXIT
           (SEQ (LETT |lpt| NIL) (LETT |bad_cnt| 0) (LETT |good_cnt| 0)
                (LETT |exps| (GETREFV_U32 0 0)) (LETT |offsets| (MAKE-ARRAY 0))
                (LETT |all_bad| 'T)
                (LETT |update_points|
                      (COND
                       ((EQUAL (QVELT |pss| 5) '|qshiftHP|)
                        (EQUAL (QVELT |pss| 3) (|SPADfirst| |vars|)))
                       ('T NIL)))
                (LETT |update_qval|
                      (COND
                       ((OR (EQUAL (QVELT |pss| 5) '|qshiftHP|)
                            (OR (EQUAL (QVELT |pss| 5) '|qdiffHP|)
                                (EQUAL (QVELT |pss| 5) '|qmixed|)))
                        (EQUAL (QVELT |pss| 3) (|SPADfirst| |vars|)))
                       ('T NIL)))
                (LETT |p| (QVELT (QVELT |pss| 10) 0))
                (LETT |m| (QVELT |pss| 8)) (LETT |nvars| (LENGTH |vars|))
                (LETT |nsols| (+ |m| 1))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (LETT |ok| NIL)
                           (SEQ (LETT |k| 1) G190
                                (COND
                                 ((OR (|greater_SI| |k| 100)
                                      (NULL (NULL |ok|)))
                                  (GO G191)))
                                (SEQ (LETT |pt| (RANDOM |p|))
                                     (EXIT
                                      (COND
                                       ((SPADCALL |pt| |lpt| (QREFELT $ 55))
                                        "iterate")
                                       ('T
                                        (SEQ (LETT |lpt| (CONS |pt| |lpt|))
                                             (EXIT (LETT |ok| 'T)))))))
                                (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                (EXIT NIL))
                           (COND
                            ((EQL
                              (SPADCALL (LETT |npt| (LENGTH |lpt|)) 100
                                        (QREFELT $ 56))
                              0)
                             (SEQ
                              (SPADCALL
                               (SPADCALL "Number of evaluation points"
                                         (QREFELT $ 59))
                               (QREFELT $ 61))
                              (EXIT
                               (SPADCALL (SPADCALL |npt| (QREFELT $ 62))
                                         (QREFELT $ 61))))))
                           (EXIT
                            (COND
                             (|ok|
                              (SEQ
                               (COND
                                (|update_points|
                                 (SEQ (LETT |pts| (QVELT |pss| 2))
                                      (LETT |qn| 1)
                                      (EXIT
                                       (SEQ (LETT |k| 0)
                                            (LETT #14# (- (QVELT |pss| 1) 1))
                                            G190
                                            (COND
                                             ((|greater_SI| |k| #14#)
                                              (GO G191)))
                                            (SEQ (SETELT_U32 |pts| |k| |qn|)
                                                 (EXIT
                                                  (LETT |qn|
                                                        (SPADCALL (* |pt| |qn|)
                                                                  |p|
                                                                  (QREFELT $
                                                                           56)))))
                                            (LETT |k| (|inc_SI| |k|)) (GO G190)
                                            G191 (EXIT NIL))))))
                               (COND (|update_qval| (QSETVELT |pss| 4 |pt|)))
                               (LETT |pprp|
                                     (|IMODHP;eval_and_solve| |pt| |vars| |gvl|
                                      |pss| |gen| $))
                               (EXIT
                                (COND
                                 ((QEQCAR |pprp| 2)
                                  (PROGN
                                   (LETT #4# (CONS 2 "no_solution"))
                                   (GO #15=#:G1067)))
                                 ((QEQCAR |pprp| 1)
                                  (SEQ (LETT |bad_cnt| (+ |bad_cnt| 1))
                                       (EXIT
                                        (COND
                                         ((> |bad_cnt| (+ |good_cnt| 2))
                                          (PROGN
                                           (LETT #4# (CONS 1 "failed"))
                                           (GO #15#)))
                                         ('T "iterate")))))
                                 ('T
                                  (SEQ (LETT |ppr| (QCDR |pprp|))
                                       (LETT |va| (QVELT |ppr| 0))
                                       (LETT |civ| (QVELT |ppr| 1))
                                       (LETT |nexps| (QVELT |ppr| 4))
                                       (LETT |noffsets| (QVELT |ppr| 3))
                                       (LETT |coeffs| (QVELT |ppr| 5))
                                       (LETT |chk_ress|
                                             (|IMODHP;check_defects| |va| |civ|
                                              |pss| $))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |chk_ress| 1)
                                          (SEQ (LETT |bad_cnt| (+ |bad_cnt| 1))
                                               (EXIT
                                                (COND
                                                 ((> |bad_cnt|
                                                     (+ |good_cnt| 2))
                                                  (PROGN
                                                   (LETT #4# (CONS 1 "failed"))
                                                   (GO #15#)))
                                                 ('T "iterate")))))
                                         ('T
                                          (SEQ
                                           (COND
                                            ((QEQCAR |chk_ress| 2)
                                             (LETT |all_bad| 'T)))
                                           (COND
                                            (|all_bad|
                                             (SEQ (LETT |nsols| (QVSIZE |va|))
                                                  (QSETVELT |pss| 9 |nsols|)
                                                  (QSETVELT |pss| 6 |va|)
                                                  (QSETVELT |pss| 7 |civ|)
                                                  (LETT |exps| |nexps|)
                                                  (LETT |offsets| |noffsets|)
                                                  (EXIT
                                                   (LETT |rstate|
                                                         (SPADCALL
                                                          (QV_LEN_U32 |coeffs|)
                                                          |p|
                                                          (QREFELT $ 64)))))))
                                           (LETT |all_bad| NIL)
                                           (LETT |good_cnt| (+ |good_cnt| 1))
                                           (LETT |dl|
                                                 (SPADCALL |nvars| |offsets|
                                                           |exps| |noffsets|
                                                           |nexps|
                                                           (QREFELT $ 49)))
                                           (LETT |odl|
                                                 (SPADCALL |dl| 1
                                                           (QREFELT $ 65)))
                                           (LETT |ndl|
                                                 (SPADCALL |dl| 2
                                                           (QREFELT $ 65)))
                                           (COND
                                            ((SPADCALL |odl| NIL
                                                       (QREFELT $ 66))
                                             (SEQ
                                              (LETT |oer|
                                                    (SPADCALL |nvars| |odl|
                                                              |ndl| |offsets|
                                                              |exps| |noffsets|
                                                              |nexps|
                                                              (QREFELT $ 52)))
                                              (LETT |offsets| (QCAR |oer|))
                                              (LETT |exps| (QCDR |oer|))
                                              (LETT |ncc|
                                                    (QUOTIENT2
                                                     (QV_LEN_U32 |exps|)
                                                     |nvars|))
                                              (EXIT
                                               (LETT |rstate|
                                                     (SPADCALL |ncc| |p|
                                                               (QREFELT $
                                                                        64)))))))
                                           (COND
                                            ((SPADCALL |ndl| NIL
                                                       (QREFELT $ 66))
                                             (SEQ
                                              (LETT |n0| (QV_LEN_U32 |coeffs|))
                                              (LETT |nn| (LENGTH |ndl|))
                                              (LETT |n1| (+ |n0| |nn|))
                                              (LETT |ncoeffs|
                                                    (GETREFV_U32 |n1| 0))
                                              (LETT |i| 0)
                                              (LETT |jl| (|SPADfirst| |ndl|))
                                              (SEQ (LETT |j| 0)
                                                   (LETT #12# (- |n1| 1)) G190
                                                   (COND
                                                    ((|greater_SI| |j| #12#)
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (COND
                                                      ((EQL |j| |jl|)
                                                       (SEQ
                                                        (SETELT_U32 |ncoeffs|
                                                                    |j| 0)
                                                        (LETT |ndl|
                                                              (CDR |ndl|))
                                                        (EXIT
                                                         (LETT |jl|
                                                               (COND
                                                                ((NULL |ndl|)
                                                                 |n1|)
                                                                ('T
                                                                 (|SPADfirst|
                                                                  |ndl|)))))))
                                                      ('T
                                                       (SEQ
                                                        (SETELT_U32 |ncoeffs|
                                                                    |j|
                                                                    (ELT_U32
                                                                     |coeffs|
                                                                     |i|))
                                                        (EXIT
                                                         (LETT |i|
                                                               (+ |i| 1))))))))
                                                   (LETT |j| (|inc_SI| |j|))
                                                   (GO G190) G191 (EXIT NIL))
                                              (EXIT
                                               (LETT |coeffs| |ncoeffs|)))))
                                           (LETT |block_offsets|
                                                 (|IMODHP;compute_blocks|
                                                  |offsets| |m| |nsols| $))
                                           (LETT |n1| (QV_LEN_U32 |coeffs|))
                                           (LETT |ok| 'T)
                                           (SEQ
                                            (EXIT
                                             (SEQ (LETT |i| 1)
                                                  (LETT #10# |nsols|) G190
                                                  (COND
                                                   ((|greater_SI| |i| #10#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (LETT |cnum|
                                                         (SPADCALL |civ| |i|
                                                                   (QREFELT $
                                                                            31)))
                                                   (LETT |ofin|
                                                         (+ (* |m| (- |i| 1))
                                                            |cnum|))
                                                   (LETT |ofi|
                                                         (SPADCALL |offsets|
                                                                   |ofin|
                                                                   (QREFELT $
                                                                            31)))
                                                   (LETT |nofi|
                                                         (COND
                                                          ((OR (< |i| |nsols|)
                                                               (< |cnum| |m|))
                                                           (SPADCALL |offsets|
                                                                     (+ |ofin|
                                                                        1)
                                                                     (QREFELT $
                                                                              31)))
                                                          ('T |n1|)))
                                                   (LETT |nofi| (- |nofi| 1))
                                                   (EXIT
                                                    (COND
                                                     ((< |nofi| |ofi|)
                                                      (SEQ
                                                       (SPADCALL
                                                        (SPADCALL |civ|
                                                                  (QREFELT $
                                                                           67))
                                                        (QREFELT $ 61))
                                                       (SPADCALL
                                                        (SPADCALL |offsets|
                                                                  (QREFELT $
                                                                           67))
                                                        (QREFELT $ 61))
                                                       (EXIT
                                                        (|error|
                                                         "Internal error: corrupted offsets 1"))))
                                                     ((EQL
                                                       (ELT_U32 |coeffs|
                                                                |nofi|)
                                                       0)
                                                      (SEQ (LETT |ok| NIL)
                                                           (EXIT
                                                            (PROGN
                                                             (LETT #7# 1)
                                                             (GO
                                                              #16=#:G1054)))))
                                                     ('T
                                                      (SEQ
                                                       (LETT |invc|
                                                             (SPADCALL
                                                              (ELT_U32 |coeffs|
                                                                       |nofi|)
                                                              |p|
                                                              (QREFELT $ 68)))
                                                       (LETT |lo|
                                                             (SPADCALL
                                                              |block_offsets|
                                                              |i|
                                                              (QREFELT $ 31)))
                                                       (LETT |hi|
                                                             (COND
                                                              ((< |i| |nsols|)
                                                               (SPADCALL
                                                                |block_offsets|
                                                                (+ |i| 1)
                                                                (QREFELT $
                                                                         31)))
                                                              ('T |n1|)))
                                                       (EXIT
                                                        (SEQ (LETT |j| |lo|)
                                                             (LETT #5#
                                                                   (- |hi| 1))
                                                             G190
                                                             (COND
                                                              ((> |j| #5#)
                                                               (GO G191)))
                                                             (SEQ
                                                              (EXIT
                                                               (SETELT_U32
                                                                |coeffs| |j|
                                                                (QSMULMOD32
                                                                 (ELT_U32
                                                                  |coeffs| |j|)
                                                                 |invc| |p|))))
                                                             (LETT |j|
                                                                   (+ |j| 1))
                                                             (GO G190) G191
                                                             (EXIT NIL))))))))
                                                  (LETT |i| (|inc_SI| |i|))
                                                  (GO G190) G191 (EXIT NIL)))
                                            #16# (EXIT #7#))
                                           (EXIT
                                            (COND
                                             (|ok|
                                              (SEQ
                                               (SPADCALL |coeffs| |pt| |rstate|
                                                         (QREFELT $ 69))
                                               (LETT |pp|
                                                     (SPADCALL |rstate| |nvars|
                                                               |block_offsets|
                                                               |offsets| |exps|
                                                               (QREFELT $ 72)))
                                               (EXIT
                                                (COND
                                                 ((QEQCAR |pp| 1) "iterate")
                                                 ('T
                                                  (SEQ (LETT |rr| (QCDR |pp|))
                                                       (EXIT
                                                        (PROGN
                                                         (LETT #4#
                                                               (CONS 0
                                                                     (VECTOR
                                                                      |va|
                                                                      |civ| |m|
                                                                      (QVELT
                                                                       |rr| 1)
                                                                      (QVELT
                                                                       |rr| 2)
                                                                      (QVELT
                                                                       |rr|
                                                                       3))))
                                                         (GO #15#)))))))))
                                             ('T "iterate")))))))))))))
                             ('T (|error| "Run out of evaluation points")))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #15# (EXIT #4#)))) 

(SDEFUN |IMODHP;do_poly_integer0|
        ((|vars| (|List| (|Symbol|)))
         (|gvl|
          (|List| (|PrimitiveArray| (|Fraction| (|Polynomial| (|Integer|))))))
         (|pss|
          (|Record| (|:| |degree_bounds| (|Vector| (|Integer|)))
                    (|:| |pss_sigma| (|NonNegativeInteger|))
                    (|:| |points| (|U32Vector|)) (|:| |pss_qvar| (|Symbol|))
                    (|:| |pss_qval| (|Integer|)) (|:| |pss_kind| (|Symbol|))
                    (|:| |oldva| (|Vector| (|Integer|)))
                    (|:| |oldciv| (|Vector| (|Integer|)))
                    (|:| |pss_m| #1=(|Integer|)) (|:| |sol_cnt| (|Integer|))
                    (|:| |pss1|
                         #2=(|Record| (|:| |prime| (|Integer|))
                                      (|:| |eval1coeffbuf| (|U32Vector|))
                                      (|:| |eval1expbuf|
                                           (|SortedExponentVector|))))))
         (|gen|
          (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|)))
         ($
          (|Union|
           (|Record| (|:| |defects| (|Vector| (|Integer|)))
                     (|:| |cinds| (|Vector| (|Integer|)))
                     (|:| |rowlen| (|Integer|))
                     (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))
                     (|:| |coeffdata| (|PrimitiveArray| (|Integer|))))
           "no_solution")))
        (SPROG
         ((#3=#:G1122 NIL)
          (|pp| (|Union| (|PrimitiveArray| (|Integer|)) "failed"))
          (#4=#:G1125 NIL) (|j| NIL) (|hi| #5=(|Integer|)) (|lo| #5#)
          (|invc| (|Integer|)) (#6=#:G1121 NIL) (|ok| #7=(|Boolean|))
          (|nofi| #5#) (|ofi| #5#) (|ofin| #8=(|Integer|)) (|cnum| #5#)
          (#9=#:G1124 NIL) (|i| (|Integer|)) (|n1| (|NonNegativeInteger|))
          (|block_offsets| (|Vector| (|Integer|))) (|coeffs| (|U32Vector|))
          (|jl| (|Integer|)) (|ndl| #10=(|List| (|Integer|))) (#11=#:G1123 NIL)
          (|ncoeffs| (|U32Vector|)) (|nn| (|NonNegativeInteger|))
          (|n0| (|NonNegativeInteger|))
          (|rstate| (|VectorIntegerReconstructor|))
          (|ncc| (|NonNegativeInteger|)) (|exps| (|SortedExponentVector|))
          (|offsets| (|Vector| (|Integer|)))
          (|oer|
           (|Record| (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))))
          (|odl| #10#) (|dl| (|List| (|List| (|Integer|)))) (|all_bad| #7#)
          (|nsols| #8#) (|chk_ress| (|Union| "OK" "failed" "all_bad"))
          (|noffsets| (|Vector| (|Integer|)))
          (|nexps| (|SortedExponentVector|)) (|civ| (|Vector| (|Integer|)))
          (|va| (|Vector| (|Integer|)))
          (|ppr|
           (|Record| (|:| |defects| (|Vector| (|Integer|)))
                     (|:| |cinds| (|Vector| (|Integer|)))
                     (|:| |rowlen| (|Integer|))
                     (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))
                     (|:| |coeffdata| (|U32Vector|))))
          (|pprp|
           (|Union|
            (|Record| (|:| |defects| (|Vector| (|Integer|)))
                      (|:| |cinds| (|Vector| (|Integer|)))
                      (|:| |rowlen| (|Integer|))
                      (|:| |offsetdata| (|Vector| (|Integer|)))
                      (|:| |expdata| (|SortedExponentVector|))
                      (|:| |coeffdata| (|U32Vector|)))
            "failed" "no_solution"))
          (|ngvl|
           (|List|
            (|PrimitiveArray|
             (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                       (|:| |denom| (|Polynomial| (|Integer|)))))))
          (|ngv0p|
           (|Union|
            (|List|
             (|PrimitiveArray|
              (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                        (|:| |denom| (|Polynomial| (|Integer|))))))
            "failed"))
          (|lp| (|List| (|Integer|))) (|p| (|Integer|)) (|k| NIL)
          (|nvars| (|NonNegativeInteger|)) (|m| #1#) (|pss1| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |lp| NIL) (LETT |exps| (GETREFV_U32 0 0))
                (LETT |offsets| (MAKE-ARRAY 0)) (LETT |all_bad| 'T)
                (LETT |pss1| (QVELT |pss| 10)) (LETT |p| 16)
                (LETT |m| (QVELT |pss| 8)) (LETT |nvars| (LENGTH |vars|))
                (LETT |nsols| (+ |m| 1))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (LETT |ok| NIL)
                           (SEQ (LETT |k| 1) G190
                                (COND
                                 ((OR (|greater_SI| |k| 100)
                                      (NULL (NULL |ok|)))
                                  (GO G191)))
                                (SEQ
                                 (LETT |p|
                                       (SPADCALL (+ (RANDOM 200000) 200000)
                                                 (QREFELT $ 74)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |p| |lp| (QREFELT $ 55))
                                    "iterate")
                                   ('T
                                    (SEQ (LETT |lp| (CONS |p| |lp|))
                                         (EXIT (LETT |ok| 'T)))))))
                                (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT
                            (COND
                             (|ok|
                              (SEQ (QSETVELT |pss1| 0 |p|)
                                   (LETT |ngv0p| (|IMODHP;eval3s| |gvl| |p| $))
                                   (EXIT
                                    (COND ((QEQCAR |ngv0p| 1) "iterate")
                                          ('T
                                           (SEQ (LETT |ngvl| (QCDR |ngv0p|))
                                                (LETT |pprp|
                                                      (|IMODHP;do_poly_modular|
                                                       |vars| |ngvl| |pss|
                                                       |gen| $))
                                                (EXIT
                                                 (COND
                                                  ((QEQCAR |pprp| 2)
                                                   (PROGN
                                                    (LETT #3#
                                                          (CONS 1
                                                                "no_solution"))
                                                    (GO #12=#:G1120)))
                                                  ((QEQCAR |pprp| 1) "iterate")
                                                  ('T
                                                   (SEQ
                                                    (LETT |ppr| (QCDR |pprp|))
                                                    (LETT |va| (QVELT |ppr| 0))
                                                    (LETT |civ|
                                                          (QVELT |ppr| 1))
                                                    (LETT |nexps|
                                                          (QVELT |ppr| 4))
                                                    (LETT |noffsets|
                                                          (QVELT |ppr| 3))
                                                    (LETT |coeffs|
                                                          (QVELT |ppr| 5))
                                                    (LETT |chk_ress|
                                                          (|IMODHP;check_defects|
                                                           |va| |civ| |pss| $))
                                                    (EXIT
                                                     (COND
                                                      ((QEQCAR |chk_ress| 1)
                                                       "iterate")
                                                      ('T
                                                       (SEQ
                                                        (COND
                                                         ((QEQCAR |chk_ress| 2)
                                                          (LETT |all_bad| 'T)))
                                                        (COND
                                                         (|all_bad|
                                                          (SEQ
                                                           (LETT |nsols|
                                                                 (QVSIZE |va|))
                                                           (QSETVELT |pss| 9
                                                                     |nsols|)
                                                           (QSETVELT |pss| 6
                                                                     |va|)
                                                           (QSETVELT |pss| 7
                                                                     |civ|)
                                                           (LETT |exps|
                                                                 |nexps|)
                                                           (LETT |offsets|
                                                                 |noffsets|)
                                                           (EXIT
                                                            (LETT |rstate|
                                                                  (SPADCALL
                                                                   (QV_LEN_U32
                                                                    |coeffs|)
                                                                   (QREFELT $
                                                                            76)))))))
                                                        (LETT |all_bad| NIL)
                                                        (LETT |dl|
                                                              (SPADCALL
                                                               (+ |nvars| 1)
                                                               |offsets| |exps|
                                                               |noffsets|
                                                               |nexps|
                                                               (QREFELT $ 49)))
                                                        (LETT |odl|
                                                              (SPADCALL |dl| 1
                                                                        (QREFELT
                                                                         $
                                                                         65)))
                                                        (LETT |ndl|
                                                              (SPADCALL |dl| 2
                                                                        (QREFELT
                                                                         $
                                                                         65)))
                                                        (COND
                                                         ((SPADCALL |odl| NIL
                                                                    (QREFELT $
                                                                             66))
                                                          (SEQ
                                                           (LETT |oer|
                                                                 (SPADCALL
                                                                  (+ |nvars| 1)
                                                                  |odl| |ndl|
                                                                  |offsets|
                                                                  |exps|
                                                                  |noffsets|
                                                                  |nexps|
                                                                  (QREFELT $
                                                                           52)))
                                                           (LETT |offsets|
                                                                 (QCAR |oer|))
                                                           (LETT |exps|
                                                                 (QCDR |oer|))
                                                           (LETT |ncc|
                                                                 (QUOTIENT2
                                                                  (QV_LEN_U32
                                                                   |exps|)
                                                                  (+ |nvars|
                                                                     1)))
                                                           (EXIT
                                                            (LETT |rstate|
                                                                  (SPADCALL
                                                                   |ncc|
                                                                   (QREFELT $
                                                                            76)))))))
                                                        (COND
                                                         ((SPADCALL |ndl| NIL
                                                                    (QREFELT $
                                                                             66))
                                                          (SEQ
                                                           (LETT |n0|
                                                                 (QV_LEN_U32
                                                                  |coeffs|))
                                                           (LETT |nn|
                                                                 (LENGTH
                                                                  |ndl|))
                                                           (LETT |n1|
                                                                 (+ |n0| |nn|))
                                                           (LETT |ncoeffs|
                                                                 (GETREFV_U32
                                                                  |n1| 0))
                                                           (LETT |i| 0)
                                                           (LETT |jl|
                                                                 (|SPADfirst|
                                                                  |ndl|))
                                                           (SEQ (LETT |j| 0)
                                                                (LETT #11#
                                                                      (- |n1|
                                                                         1))
                                                                G190
                                                                (COND
                                                                 ((|greater_SI|
                                                                   |j| #11#)
                                                                  (GO G191)))
                                                                (SEQ
                                                                 (EXIT
                                                                  (COND
                                                                   ((EQL |j|
                                                                         |jl|)
                                                                    (SEQ
                                                                     (SETELT_U32
                                                                      |ncoeffs|
                                                                      |j| 0)
                                                                     (LETT
                                                                      |ndl|
                                                                      (CDR
                                                                       |ndl|))
                                                                     (EXIT
                                                                      (LETT
                                                                       |jl|
                                                                       (COND
                                                                        ((NULL
                                                                          |ndl|)
                                                                         |n1|)
                                                                        ('T
                                                                         (|SPADfirst|
                                                                          |ndl|)))))))
                                                                   ('T
                                                                    (SEQ
                                                                     (SETELT_U32
                                                                      |ncoeffs|
                                                                      |j|
                                                                      (ELT_U32
                                                                       |coeffs|
                                                                       |i|))
                                                                     (EXIT
                                                                      (LETT |i|
                                                                            (+
                                                                             |i|
                                                                             1))))))))
                                                                (LETT |j|
                                                                      (|inc_SI|
                                                                       |j|))
                                                                (GO G190) G191
                                                                (EXIT NIL))
                                                           (EXIT
                                                            (LETT |coeffs|
                                                                  |ncoeffs|)))))
                                                        (LETT |block_offsets|
                                                              (|IMODHP;compute_blocks|
                                                               |offsets| |m|
                                                               |nsols| $))
                                                        (LETT |n1|
                                                              (QV_LEN_U32
                                                               |coeffs|))
                                                        (LETT |ok| 'T)
                                                        (SEQ
                                                         (EXIT
                                                          (SEQ (LETT |i| 1)
                                                               (LETT #9#
                                                                     |nsols|)
                                                               G190
                                                               (COND
                                                                ((|greater_SI|
                                                                  |i| #9#)
                                                                 (GO G191)))
                                                               (SEQ
                                                                (LETT |cnum|
                                                                      (SPADCALL
                                                                       |civ|
                                                                       |i|
                                                                       (QREFELT
                                                                        $ 31)))
                                                                (LETT |ofin|
                                                                      (+
                                                                       (* |m|
                                                                          (-
                                                                           |i|
                                                                           1))
                                                                       |cnum|))
                                                                (LETT |ofi|
                                                                      (SPADCALL
                                                                       |offsets|
                                                                       |ofin|
                                                                       (QREFELT
                                                                        $ 31)))
                                                                (LETT |nofi|
                                                                      (COND
                                                                       ((OR
                                                                         (< |i|
                                                                            |nsols|)
                                                                         (<
                                                                          |cnum|
                                                                          |m|))
                                                                        (SPADCALL
                                                                         |offsets|
                                                                         (+
                                                                          |ofin|
                                                                          1)
                                                                         (QREFELT
                                                                          $
                                                                          31)))
                                                                       ('T
                                                                        |n1|)))
                                                                (LETT |nofi|
                                                                      (- |nofi|
                                                                         1))
                                                                (EXIT
                                                                 (COND
                                                                  ((< |nofi|
                                                                      |ofi|)
                                                                   (SEQ
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      |civ|
                                                                      (QREFELT
                                                                       $ 67))
                                                                     (QREFELT $
                                                                              61))
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      |offsets|
                                                                      (QREFELT
                                                                       $ 67))
                                                                     (QREFELT $
                                                                              61))
                                                                    (EXIT
                                                                     (|error|
                                                                      "Internal error: corrupted offsets"))))
                                                                  ((EQL
                                                                    (ELT_U32
                                                                     |coeffs|
                                                                     |nofi|)
                                                                    0)
                                                                   (SEQ
                                                                    (LETT |ok|
                                                                          NIL)
                                                                    (EXIT
                                                                     (PROGN
                                                                      (LETT #6#
                                                                            1)
                                                                      (GO
                                                                       #13=#:G1108)))))
                                                                  ('T
                                                                   (SEQ
                                                                    (LETT
                                                                     |invc|
                                                                     (SPADCALL
                                                                      (ELT_U32
                                                                       |coeffs|
                                                                       |nofi|)
                                                                      |p|
                                                                      (QREFELT
                                                                       $ 68)))
                                                                    (LETT |lo|
                                                                          (SPADCALL
                                                                           |block_offsets|
                                                                           |i|
                                                                           (QREFELT
                                                                            $
                                                                            31)))
                                                                    (LETT |hi|
                                                                          (COND
                                                                           ((<
                                                                             |i|
                                                                             |nsols|)
                                                                            (SPADCALL
                                                                             |block_offsets|
                                                                             (+
                                                                              |i|
                                                                              1)
                                                                             (QREFELT
                                                                              $
                                                                              31)))
                                                                           ('T
                                                                            |n1|)))
                                                                    (EXIT
                                                                     (SEQ
                                                                      (LETT |j|
                                                                            |lo|)
                                                                      (LETT #4#
                                                                            (-
                                                                             |hi|
                                                                             1))
                                                                      G190
                                                                      (COND
                                                                       ((> |j|
                                                                           #4#)
                                                                        (GO
                                                                         G191)))
                                                                      (SEQ
                                                                       (EXIT
                                                                        (SETELT_U32
                                                                         |coeffs|
                                                                         |j|
                                                                         (QSMULMOD32
                                                                          (ELT_U32
                                                                           |coeffs|
                                                                           |j|)
                                                                          |invc|
                                                                          |p|))))
                                                                      (LETT |j|
                                                                            (+
                                                                             |j|
                                                                             1))
                                                                      (GO G190)
                                                                      G191
                                                                      (EXIT
                                                                       NIL))))))))
                                                               (LETT |i|
                                                                     (|inc_SI|
                                                                      |i|))
                                                               (GO G190) G191
                                                               (EXIT NIL)))
                                                         #13# (EXIT #6#))
                                                        (EXIT
                                                         (COND
                                                          (|ok|
                                                           (SEQ
                                                            (SPADCALL |coeffs|
                                                                      |p|
                                                                      |rstate|
                                                                      (QREFELT
                                                                       $ 77))
                                                            (LETT |pp|
                                                                  (SPADCALL
                                                                   |rstate|
                                                                   |block_offsets|
                                                                   (QREFELT $
                                                                            79)))
                                                            (EXIT
                                                             (COND
                                                              ((QEQCAR |pp| 1)
                                                               "iterate")
                                                              ('T
                                                               (PROGN
                                                                (LETT #3#
                                                                      (CONS 0
                                                                            (VECTOR
                                                                             |va|
                                                                             |civ|
                                                                             |m|
                                                                             |offsets|
                                                                             |exps|
                                                                             (QCDR
                                                                              |pp|))))
                                                                (GO #12#)))))))
                                                          ('T
                                                           "iterate")))))))))))))))))
                             ('T (|error| "Run out of primes")))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #12# (EXIT #3#)))) 

(SDEFUN |IMODHP;do_poly_integer;LLVNniUv2SMU;13|
        ((|vars| (|List| (|Symbol|)))
         (|gvl|
          (|List| (|PrimitiveArray| (|Fraction| (|Polynomial| (|Integer|))))))
         (|ve| (|Vector| (|Integer|))) (|sigma| (|NonNegativeInteger|))
         (|pts| (|U32Vector|)) (|kind| (|Symbol|)) (|qvar| (|Symbol|))
         (|gen|
          (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|)))
         ($
          (|Union|
           (|Record| (|:| |defects| (|Vector| (|Integer|)))
                     (|:| |cinds| (|Vector| (|Integer|)))
                     (|:| |rowlen| (|Integer|))
                     (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))
                     (|:| |coeffdata| (|PrimitiveArray| (|Integer|))))
           "no_solution")))
        (SPROG
         ((#1=#:G1138 NIL)
          (|pss|
           (|Record| (|:| |degree_bounds| (|Vector| (|Integer|)))
                     (|:| |pss_sigma| (|NonNegativeInteger|))
                     (|:| |points| (|U32Vector|)) (|:| |pss_qvar| (|Symbol|))
                     (|:| |pss_qval| (|Integer|)) (|:| |pss_kind| (|Symbol|))
                     (|:| |oldva| (|Vector| (|Integer|)))
                     (|:| |oldciv| (|Vector| (|Integer|)))
                     (|:| |pss_m| (|Integer|)) (|:| |sol_cnt| (|Integer|))
                     (|:| |pss1|
                          (|Record| (|:| |prime| (|Integer|))
                                    (|:| |eval1coeffbuf| (|U32Vector|))
                                    (|:| |eval1expbuf|
                                         (|SortedExponentVector|))))))
          (|pss1|
           (|Record| (|:| |prime| (|Integer|))
                     (|:| |eval1coeffbuf| (|U32Vector|))
                     (|:| |eval1expbuf| (|SortedExponentVector|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |pss1| (VECTOR 0 (GETREFV_U32 10 0) (GETREFV_U32 10 0)))
                (LETT |pss|
                      (VECTOR |ve| |sigma| |pts| |qvar| 0 |kind| (MAKE-ARRAY 0)
                              (MAKE-ARRAY 0) (QVSIZE |ve|) (+ (QVSIZE |ve|) 1)
                              |pss1|))
                (EXIT
                 (PROGN
                  (LETT #1#
                        (|IMODHP;do_poly_integer0| |vars| |gvl| |pss| |gen| $))
                  (GO #2=#:G1137)))))
          #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |InnerModularHermitePade;|)) 

(DEFUN |InnerModularHermitePade| ()
  (SPROG NIL
         (PROG (#1=#:G1140)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|InnerModularHermitePade|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|InnerModularHermitePade|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|InnerModularHermitePade;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|InnerModularHermitePade|)))))))))) 

(DEFUN |InnerModularHermitePade;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|InnerModularHermitePade|))
          (LETT $ (GETREFV 86))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InnerModularHermitePade| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|InnerModularHermitePade| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Integer|) (|Polynomial| 6)
              (|Record| (|:| |prime| 6) (|:| |eval1coeffbuf| 29)
                        (|:| |eval1expbuf| 48))
              (|PolynomialEvaluationUtilities|) (0 . |eval1a|)
              (|SingleInteger|) (7 . |invmod|) (13 . |Zero|) (17 . |One|)
              (|Record| (|:| |numer| 7) (|:| |denom| 7)) (|Union| 15 '"failed")
              (|Symbol|) (21 . |eval1|) (|Fraction| 7) (29 . |Zero|)
              (33 . |One|) (37 . |modpreduction|) (|List| 35) (|Vector| 29)
              (|Vector| 6) (|NonNegativeInteger|)
              (|NaiveBeckermannLabahnModular|) (43 . |naiveBeckermannLabahn|)
              (|U32Vector|) (51 . |naiveBeckermannLabahnMultipoint|)
              (59 . |elt|) (65 . |elt|) (71 . |setelt!|) (78 . |setelt!|)
              (|Any|) (85 . |elt|) (|AnyFunctions1| 25) (91 . |retract|)
              (|AnyFunctions1| 24) (96 . |retract|)
              (|Record| (|:| |basis| 53) (|:| |defects| 25) (|:| |cinds| 25))
              (101 . |reduceBasis|) (|Union| 41 '"no_solution")
              |IMODHP;do_modular_solve;VVNniUvISU;5| (|Boolean|) (109 . ~=)
              (|List| 51) (|SortedExponentVector|)
              |IMODHP;merge_exponents;IVSevVSevL;7|
              (|Record| (|:| |offsetdata| 25) (|:| |expdata| 48)) (|List| 6)
              |IMODHP;merge2;I2LVSevVSevR;8| (|TwoDimensionalArray| 29)
              (115 . |elt|) (122 . |member?|) (128 . |positiveRemainder|)
              (|String|) (|OutputForm|) (134 . |message|) (|Void|)
              (139 . |print|) (144 . |coerce|) (|VectorModularReconstructor|)
              (149 . |empty|) (155 . |elt|) (161 . ~=) (167 . |coerce|)
              (172 . |invmod|) (178 . |chinese_update|)
              (|Record| (|:| |nvars| 6) (|:| |offsetdata| 25)
                        (|:| |expdata| 48) (|:| |coeffdata| 29))
              (|Union| 70 '"failed") (185 . |reconstruct|)
              (|IntegerPrimesPackage| 6) (194 . |nextPrime|)
              (|VectorIntegerReconstructor|) (199 . |empty|)
              (204 . |chinese_update|) (|Union| (|PrimitiveArray| 6) '"failed")
              (211 . |reconstruct|)
              (|Record| (|:| |defects| 25) (|:| |cinds| 25) (|:| |rowlen| 6)
                        (|:| |offsetdata| 25) (|:| |expdata| 48)
                        (|:| |coeffdata| (|PrimitiveArray| 6)))
              (|Union| 80 '"no_solution") (|List| 17)
              (|List| (|PrimitiveArray| 19)) (|Mapping| 24 (|List| 29) 6 6)
              |IMODHP;do_poly_integer;LLVNniUv2SMU;13|)
           '#(|merge_exponents| 217 |merge2| 226 |do_poly_integer| 237
              |do_modular_solve| 249)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|do_modular_solve|
                                 ((|Union|
                                   (|Record|
                                    (|:| |basis|
                                         (|TwoDimensionalArray| (|U32Vector|)))
                                    (|:| |defects| (|Vector| (|Integer|)))
                                    (|:| |cinds| (|Vector| (|Integer|))))
                                   "no_solution")
                                  (|Vector| (|U32Vector|))
                                  (|Vector| (|Integer|)) (|NonNegativeInteger|)
                                  (|U32Vector|) (|Integer|) (|Symbol|)))
                                T)
                              '((|do_poly_integer|
                                 ((|Union|
                                   (|Record|
                                    (|:| |defects| (|Vector| (|Integer|)))
                                    (|:| |cinds| (|Vector| (|Integer|)))
                                    (|:| |rowlen| (|Integer|))
                                    (|:| |offsetdata| (|Vector| (|Integer|)))
                                    (|:| |expdata| (|SortedExponentVector|))
                                    (|:| |coeffdata|
                                         (|PrimitiveArray| (|Integer|))))
                                   "no_solution")
                                  (|List| (|Symbol|))
                                  (|List|
                                   (|PrimitiveArray|
                                    (|Fraction| (|Polynomial| (|Integer|)))))
                                  (|Vector| (|Integer|)) (|NonNegativeInteger|)
                                  (|U32Vector|) (|Symbol|) (|Symbol|)
                                  (|Mapping| (|Vector| (|U32Vector|))
                                             (|List| (|U32Vector|)) (|Integer|)
                                             (|Integer|))))
                                T)
                              '((|merge_exponents|
                                 ((|List| (|List| (|Integer|))) (|Integer|)
                                  (|Vector| (|Integer|))
                                  (|SortedExponentVector|)
                                  (|Vector| (|Integer|))
                                  (|SortedExponentVector|)))
                                T)
                              '((|merge2|
                                 ((|Record|
                                   (|:| |offsetdata| (|Vector| (|Integer|)))
                                   (|:| |expdata| (|SortedExponentVector|)))
                                  (|Integer|) (|List| (|Integer|))
                                  (|List| (|Integer|)) (|Vector| (|Integer|))
                                  (|SortedExponentVector|)
                                  (|Vector| (|Integer|))
                                  (|SortedExponentVector|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 85
                                            '(3 9 6 7 6 8 10 2 11 0 0 0 12 0 7
                                              0 13 0 7 0 14 4 9 16 15 17 6 8 18
                                              0 19 0 20 0 19 0 21 2 9 16 19 6
                                              22 4 27 23 24 25 26 6 28 4 27 23
                                              24 25 29 6 30 2 25 6 0 6 31 2 24
                                              29 0 6 32 3 24 29 0 6 29 33 3 25
                                              6 0 6 6 34 2 23 35 0 6 36 1 37 25
                                              35 38 1 39 24 35 40 4 27 41 24 25
                                              25 6 42 2 6 45 0 0 46 3 53 29 0 6
                                              6 54 2 51 45 6 0 55 2 6 0 0 0 56
                                              1 58 0 57 59 1 58 60 0 61 1 6 58
                                              0 62 2 63 0 6 6 64 2 47 51 0 6 65
                                              2 51 45 0 0 66 1 25 58 0 67 2 6 0
                                              0 0 68 3 63 60 29 6 0 69 5 63 71
                                              0 6 25 25 48 72 1 73 6 6 74 1 75
                                              0 6 76 3 75 60 29 6 0 77 2 75 78
                                              0 25 79 5 0 47 6 25 48 25 48 49 7
                                              0 50 6 51 51 25 48 25 48 52 8 0
                                              81 82 83 25 26 29 17 17 84 85 6 0
                                              43 24 25 26 29 6 17 44)))))
           '|lookupComplete|)) 

(MAKEPROP '|InnerModularHermitePade| 'NILADIC T) 

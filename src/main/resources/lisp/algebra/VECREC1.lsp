
(SDEFUN |VECREC1;empty;2I$;1|
        ((|npoly| (|Integer|)) (|np| (|Integer|)) ($ ($)))
        (SPROG
         ((|state| ($)) (#1=#:G717 NIL) (|i| NIL)
          (|polyvec| (|PrimitiveArray| (|U32Vector|))) (#2=#:G708 NIL))
         (SEQ
          (LETT |polyvec|
                (MAKEARR1
                 (PROG1 (LETT #2# |npoly|)
                   (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #2#))
                 (GETREFV_U32 0 0)))
          (SEQ (LETT |i| 0) (LETT #1# (- |npoly| 1)) G190
               (COND ((|greater_SI| |i| #1#) (GO G191)))
               (SEQ (EXIT (QSETAREF1 |polyvec| |i| (GETREFV_U32 5 0))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |state|
                (VECTOR |np| (GETREFV_U32 5 0) 0 0 |npoly| 5 |polyvec| 3 1
                        (MAKE-ARRAY 0) (MAKE-ARRAY 0)))
          (SETELT_U32 (QVELT |state| 1) 0 1) (EXIT |state|)))) 

(SDEFUN |VECREC1;add_slots;L$V;2|
        ((|ndl| (|List| (|Integer|))) (|statearg| ($)) ($ (|Void|)))
        (SPROG
         ((|j| (|Integer|)) (|li| (|Integer|)) (#1=#:G725 NIL) (#2=#:G734 NIL)
          (|i| NIL) (|nvec| (|PrimitiveArray| (|U32Vector|)))
          (|npoly| (|NonNegativeInteger|)) (|n1| (|NonNegativeInteger|))
          (|n0| (|NonNegativeInteger|)) (|m| (|Integer|))
          (|polyvec| (|PrimitiveArray| (|U32Vector|))) (|state| (|Rep|)))
         (SEQ (LETT |state| |statearg|) (LETT |polyvec| (QVELT |state| 6))
              (LETT |m| (QVELT |state| 5)) (LETT |n0| (QVSIZE |polyvec|))
              (LETT |n1| (LENGTH |ndl|)) (LETT |npoly| (+ |n0| |n1|))
              (LETT |nvec| (MAKEARR1 |npoly| (GETREFV_U32 0 0)))
              (LETT |li| (|SPADfirst| |ndl|)) (LETT |j| 0)
              (SEQ (LETT |i| 0) (LETT #2# (- |npoly| 1)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL |i| |li|)
                       (SEQ
                        (QSETAREF1 |nvec| |i|
                                   (GETREFV_U32
                                    (PROG1 (LETT #1# |m|)
                                      (|check_subtype2| (>= #1# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #1#))
                                    0))
                        (LETT |ndl| (CDR |ndl|))
                        (EXIT
                         (LETT |li|
                               (COND ((NULL |ndl|) |npoly|)
                                     ('T (|SPADfirst| |ndl|)))))))
                      ('T
                       (SEQ (QSETAREF1 |nvec| |i| (QAREF1 |polyvec| |j|))
                            (EXIT (LETT |j| (+ |j| 1))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (COND
               ((NULL (SPADCALL (QVELT |state| 9) (QREFELT $ 11)))
                (SEQ (QSETVELT |state| 9 (MAKEARR1 |npoly| (GETREFV_U32 0 0)))
                     (EXIT
                      (QSETVELT |state| 10
                                (MAKEARR1 |npoly| (GETREFV_U32 0 0)))))))
              (QSETVELT |state| 6 |polyvec|)
              (EXIT (QSETVELT |state| 4 |npoly|))))) 

(SDEFUN |VECREC1;double_poly_space| ((|statearg| ($)) ($ (|Void|)))
        (SPROG
         ((|op| (|U32Vector|)) (|np| (|U32Vector|)) (#1=#:G737 NIL)
          (#2=#:G743 NIL) (|i| NIL) (|n| (|Integer|)) (|m| (|Integer|))
          (|polyvec| (|PrimitiveArray| (|U32Vector|))) (|state| (|Rep|)))
         (SEQ (LETT |state| |statearg|) (LETT |polyvec| (QVELT |state| 6))
              (LETT |m| (QVELT |state| 5)) (LETT |n| (* 2 |m|))
              (SEQ (LETT |i| 0) (LETT #2# (- (QVELT |state| 4) 1)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (LETT |np|
                          (GETREFV_U32
                           (PROG1 (LETT #1# |n|)
                             (|check_subtype2| (>= #1# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #1#))
                           0))
                    (LETT |op| (QAREF1 |polyvec| |i|))
                    (SPADCALL |np| |op| |m| (QREFELT $ 17))
                    (EXIT (QSETAREF1 |polyvec| |i| |np|)))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (QSETVELT |state| 5 |n|))))) 

(SDEFUN |VECREC1;chinese_update;UvI$V;4|
        ((|vec| (|U32Vector|)) (|pt| (|Integer|)) (|statearg| ($))
         ($ (|Void|)))
        (SPROG
         ((|mtvec| (|U32Vector|)) (|nmt| (|U32Vector|)) (#1=#:G750 NIL)
          (|cor| #2=(|Integer|)) (|pol| (|U32Vector|)) (#3=#:G756 NIL)
          (|i| NIL) (|nn| #2#) (|polyvec| (|PrimitiveArray| (|U32Vector|)))
          (|mtcor| (|Integer|)) (|mtval| (|Integer|)) (|p| (|Integer|))
          (|npt1| (|Integer|)) (|npt| (|Integer|)) (|state| (|Rep|)))
         (SEQ (LETT |state| |statearg|) (LETT |mtvec| (QVELT |state| 1))
              (LETT |npt| (QVELT |state| 3)) (LETT |npt1| (+ |npt| 1))
              (LETT |p| (QVELT |state| 0))
              (LETT |mtval| (SPADCALL |mtvec| |npt| |pt| |p| (QREFELT $ 18)))
              (EXIT
               (COND ((EQL |mtval| 0) (|error| "Duplicate point in update"))
                     ('T
                      (SEQ (LETT |mtcor| (SPADCALL |mtval| |p| (QREFELT $ 19)))
                           (QSETVELT |state| 3 |npt1|)
                           (COND
                            ((> |npt1| (QVELT |state| 5))
                             (|VECREC1;double_poly_space| |statearg| $)))
                           (LETT |polyvec| (QVELT |state| 6))
                           (LETT |nn| (- |npt| 1))
                           (SEQ (LETT |i| 0) (LETT #3# (- (QVELT |state| 4) 1))
                                G190 (COND ((|greater_SI| |i| #3#) (GO G191)))
                                (SEQ (LETT |pol| (QAREF1 |polyvec| |i|))
                                     (LETT |cor|
                                           (- (ELT_U32 |vec| |i|)
                                              (SPADCALL |pol| |nn| |pt| |p|
                                                        (QREFELT $ 18))))
                                     (LETT |cor|
                                           (COND ((< |cor| 0) (+ |cor| |p|))
                                                 ('T |cor|)))
                                     (LETT |cor|
                                           (SPADCALL (* |cor| |mtcor|) |p|
                                                     (QREFELT $ 20)))
                                     (EXIT
                                      (SPADCALL |pol| |mtvec| 0 |npt| |cor| |p|
                                                (QREFELT $ 21))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL))
                           (COND
                            ((< (QV_LEN_U32 |mtvec|) (+ |npt1| 1))
                             (SEQ
                              (LETT |nmt|
                                    (GETREFV_U32
                                     (* 2
                                        (PROG1 (LETT #1# |npt1|)
                                          (|check_subtype2| (>= #1# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #1#)))
                                     0))
                              (SPADCALL |nmt| |mtvec| |npt1| (QREFELT $ 17))
                              (EXIT (LETT |mtvec| |nmt|)))))
                           (SPADCALL |mtvec| (+ |npt1| 1) (- |p| |pt|) |p|
                                     (QREFELT $ 22))
                           (EXIT (QSETVELT |state| 1 |mtvec|))))))))) 

(SDEFUN |VECREC1;rational_reconstruction;2Uv2IU;5|
        ((|x| (|U32Vector|)) (|y| (|U32Vector|)) (|i| (|Integer|))
         (|p| (|Integer|))
         ($
          (|Union|
           (|Record| (|:| |numer| (|U32Vector|)) (|:| |denom| (|U32Vector|)))
           "failed")))
        (SPROG
         ((|c| #1=(|Integer|)) (|ds1| #2=(|Integer|)) (|s1| #3=(|U32Vector|))
          (|ds0| #2#) (|s0| #3#) (|tmp| #4=(|Integer|)) (|tmpp| #3#)
          (|dr1| #5=(|Integer|)) (|r1| #3#) (|dr0| #5#) (|r0| #3#)
          (|ds0a| (|Integer|)) (#6=#:G782 NIL) (|c0| #1#) (|c1| #4#)
          (|delta| #4#) (|j| #5#))
         (SEQ (LETT |j| (SPADCALL |y| (QREFELT $ 24)))
              (LETT |r0| (GETREFV_U32 (+ |j| 1) 0))
              (SPADCALL |r0| |y| (+ |j| 1) (QREFELT $ 17)) (LETT |dr0| |j|)
              (LETT |s0| (GETREFV_U32 (+ |j| 1) 0)) (LETT |ds0| 0)
              (LETT |r1| (GETREFV_U32 (+ |j| 1) 0))
              (LETT |dr1| (SPADCALL |x| (QREFELT $ 24)))
              (SPADCALL |r1| |x| (+ |dr1| 1) (QREFELT $ 17))
              (LETT |s1| (GETREFV_U32 (+ |j| 1) 0)) (SETELT_U32 |s1| 0 1)
              (LETT |ds1| 0)
              (SEQ G190 (COND ((NULL (> |dr1| |i|)) (GO G191)))
                   (SEQ
                    (SEQ G190 (COND ((NULL (>= |dr0| |dr1|)) (GO G191)))
                         (SEQ (LETT |delta| (- |dr0| |dr1|))
                              (LETT |c1| (- |p| (ELT_U32 |r0| |dr0|)))
                              (LETT |c0| (ELT_U32 |r1| |dr1|))
                              (SETELT_U32 |r0| |dr0| 0)
                              (LETT |dr0| (- |dr0| 1))
                              (SPADCALL |r0| |c0| |r1| |c1| |dr0| |delta| |p|
                                        (QREFELT $ 25))
                              (SEQ
                               (EXIT
                                (SEQ G190
                                     (COND
                                      ((NULL (EQL (ELT_U32 |r0| |dr0|) 0))
                                       (GO G191)))
                                     (SEQ (LETT |dr0| (- |dr0| 1))
                                          (EXIT
                                           (COND
                                            ((< |dr0| 0)
                                             (PROGN
                                              (LETT #6# |$NoValue|)
                                              (GO #7=#:G766))))))
                                     NIL (GO G190) G191 (EXIT NIL)))
                               #7# (EXIT #6#))
                              (LETT |ds0a| (+ |ds1| |delta|))
                              (LETT |ds0a|
                                    (COND ((> |ds0| |ds0a|) |ds0|)
                                          ('T |ds0a|)))
                              (SPADCALL |s0| |c0| |s1| |c1| |ds0a| |delta| |p|
                                        (QREFELT $ 25))
                              (EXIT
                               (LETT |ds0|
                                     (COND ((> |ds0| |ds0a|) |ds0|)
                                           ((< |ds0| |ds0a|) |ds0a|)
                                           ('T
                                            (SEQ
                                             (SEQ G190
                                                  (COND
                                                   ((NULL
                                                     (EQL (ELT_U32 |s0| |ds0a|)
                                                          0))
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |ds0a|
                                                          (- |ds0a| 1))))
                                                  NIL (GO G190) G191
                                                  (EXIT NIL))
                                             (EXIT |ds0a|)))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (LETT |tmpp| |r0|) (LETT |tmp| |dr0|) (LETT |r0| |r1|)
                    (LETT |dr0| |dr1|) (LETT |r1| |tmpp|) (LETT |dr1| |tmp|)
                    (LETT |tmpp| |s0|) (LETT |tmp| |ds0|) (LETT |s0| |s1|)
                    (LETT |ds0| |ds1|) (LETT |s1| |tmpp|)
                    (EXIT (LETT |ds1| |tmp|)))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((OR (> |ds1| (- (- |j| |i|) 2))
                     (SPADCALL
                      (SPADCALL (SPADCALL |s1| |y| |p| (QREFELT $ 26))
                                (QREFELT $ 24))
                      0 (QREFELT $ 27)))
                 (CONS 1 "failed"))
                ('T
                 (SEQ (LETT |c| (ELT_U32 |s1| |ds1|))
                      (LETT |c| (SPADCALL |c| |p| (QREFELT $ 19)))
                      (SPADCALL |r1| |dr1| |c| |p| (QREFELT $ 28))
                      (SPADCALL |s1| |ds1| |c| |p| (QREFELT $ 28))
                      (EXIT (CONS 0 (CONS |r1| |s1|)))))))))) 

(SDEFUN |VECREC1;rational_reconstruction;$U;6|
        ((|statearg| ($))
         ($
          (|Union|
           (|Record| (|:| |numers| (|PrimitiveArray| (|U32Vector|)))
                     (|:| |denoms| (|PrimitiveArray| (|U32Vector|))))
           "failed")))
        (SPROG
         ((#1=#:G815 NIL) (|cden| #2=(|U32Vector|))
          (|ppr|
           (|Record| (|:| |numer| (|U32Vector|)) (|:| |denom| (|U32Vector|))))
          (|pp|
           (|Union| (|Record| (|:| |numer| (|U32Vector|)) (|:| |denom| #2#))
                    "failed"))
          (|rp| (|U32Vector|)) (|deg_r1| (|Integer|)) (|r1| (|U32Vector|))
          (|j| #3=(|Integer|)) (|dens| (|PrimitiveArray| (|U32Vector|)))
          (|nums| (|PrimitiveArray| (|U32Vector|))) (#4=#:G794 NIL)
          (#5=#:G792 NIL) (|n| (|Integer|)) (|bound| (|Integer|))
          (|m| (|Integer|)) (|j0| #3#) (|p| (|Integer|))
          (|polyvec| (|PrimitiveArray| (|U32Vector|)))
          (|modulus| (|U32Vector|)) (|state| (|Rep|)))
         (SEQ
          (EXIT
           (SEQ (LETT |state| |statearg|) (LETT |modulus| (QVELT |state| 1))
                (LETT |polyvec| (QVELT |state| 6)) (LETT |p| (QVELT |state| 0))
                (LETT |j0| (QVELT |state| 2)) (LETT |m| (QVELT |state| 3))
                (EXIT
                 (COND
                  ((<= |m| (QVELT |state| 7))
                   (PROGN (LETT #1# (CONS 1 "failed")) (GO #6=#:G814)))
                  (#7='T
                   (SEQ
                    (QSETVELT |state| 7
                              (+ (QVELT |state| 7) (QVELT |state| 8)))
                    (COND
                     ((> |m| 30)
                      (QSETVELT |state| 8
                                (+ (QVELT |state| 8)
                                   (COND ((> |m| 200) 4) (#7# 1))))))
                    (LETT |bound| (QUOTIENT2 |m| 2))
                    (LETT |pp|
                          (SPADCALL (QAREF1 |polyvec| |j0|) |modulus| |bound|
                                    |p| (QREFELT $ 31)))
                    (EXIT
                     (COND ((QEQCAR |pp| 1) (CONS 1 "failed"))
                           (#7#
                            (SEQ (LETT |n| (QVELT |state| 4))
                                 (COND
                                  ((SPADCALL (QVELT |state| 9) (QREFELT $ 11))
                                   (SEQ
                                    (QSETVELT |state| 9
                                              (MAKEARR1
                                               (PROG1 (LETT #5# |n|)
                                                 (|check_subtype2| (>= #5# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #5#))
                                               (GETREFV_U32 0 0)))
                                    (EXIT
                                     (QSETVELT |state| 10
                                               (MAKEARR1
                                                (PROG1 (LETT #4# |n|)
                                                  (|check_subtype2| (>= #4# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #4#))
                                                (GETREFV_U32 0 0)))))))
                                 (LETT |nums| (QVELT |state| 9))
                                 (LETT |dens| (QVELT |state| 10))
                                 (LETT |ppr| (QCDR |pp|))
                                 (QSETAREF1 |nums| |j0| (QCAR |ppr|))
                                 (QSETAREF1 |dens| |j0| (QCDR |ppr|))
                                 (LETT |cden| (QCDR |ppr|)) (LETT |j| |j0|)
                                 (EXIT
                                  (SEQ G190 NIL
                                       (SEQ (LETT |j| (+ |j| 1))
                                            (COND
                                             ((>= |j| |n|)
                                              (LETT |j| (- |j| |n|))))
                                            (EXIT
                                             (COND
                                              ((EQL |j| |j0|)
                                               (PROGN
                                                (LETT #1#
                                                      (CONS 0
                                                            (CONS |nums|
                                                                  |dens|)))
                                                (GO #6#)))
                                              ('T
                                               (SEQ
                                                (LETT |r1|
                                                      (QAREF1 |polyvec| |j|))
                                                (LETT |r1|
                                                      (SPADCALL |r1| |cden| |p|
                                                                (QREFELT $
                                                                         32)))
                                                (SPADCALL |r1| |modulus| |p|
                                                          (QREFELT $ 33))
                                                (LETT |deg_r1|
                                                      (SPADCALL |r1|
                                                                (QREFELT $
                                                                         24)))
                                                (EXIT
                                                 (COND
                                                  ((< |deg_r1| |bound|)
                                                   (SEQ
                                                    (LETT |rp|
                                                          (GETREFV_U32
                                                           (+ |deg_r1| 1) 0))
                                                    (SPADCALL |rp| |r1|
                                                              (+ |deg_r1| 1)
                                                              (QREFELT $ 17))
                                                    (QSETAREF1 |nums| |j| |rp|)
                                                    (EXIT
                                                     (QSETAREF1 |dens| |j|
                                                                |cden|))))
                                                  ('T
                                                   (SEQ
                                                    (LETT |pp|
                                                          (SPADCALL |r1|
                                                                    |modulus|
                                                                    |bound| |p|
                                                                    (QREFELT $
                                                                             31)))
                                                    (EXIT
                                                     (COND
                                                      ((QEQCAR |pp| 1)
                                                       (SEQ
                                                        (QSETVELT |state| 2
                                                                  |j|)
                                                        (EXIT
                                                         (PROGN
                                                          (LETT #1#
                                                                (CONS 1
                                                                      "failed"))
                                                          (GO #6#)))))
                                                      ('T
                                                       (SEQ
                                                        (LETT |ppr|
                                                              (QCDR |pp|))
                                                        (LETT |cden|
                                                              (SPADCALL |cden|
                                                                        (QCDR
                                                                         |ppr|)
                                                                        |p|
                                                                        (QREFELT
                                                                         $
                                                                         32)))
                                                        (EXIT
                                                         (COND
                                                          ((>
                                                            (SPADCALL |cden|
                                                                      (QREFELT
                                                                       $ 24))
                                                            |bound|)
                                                           (SEQ
                                                            (QSETVELT |state| 2
                                                                      |j|)
                                                            (EXIT
                                                             (PROGN
                                                              (LETT #1#
                                                                    (CONS 1
                                                                          "failed"))
                                                              (GO #6#)))))
                                                          ('T
                                                           (SEQ
                                                            (QSETAREF1 |nums|
                                                                       |j|
                                                                       (QCAR
                                                                        |ppr|))
                                                            (EXIT
                                                             (QSETAREF1 |dens|
                                                                        |j|
                                                                        |cden|)))))))))))))))))))
                                       NIL (GO G190) G191
                                       (EXIT NIL)))))))))))))
          #6# (EXIT #1#)))) 

(SDEFUN |VECREC1;repack_polys;IVSevPaR;7|
        ((|var_cnt| (|Integer|)) (|poly_offsets| (|Vector| (|Integer|)))
         (|exps| (|SortedExponentVector|))
         (|coeffs| (|PrimitiveArray| (|U32Vector|)))
         ($
          (|Record| (|:| |nvars| (|Integer|))
                    (|:| |offsetdata| (|Vector| (|Integer|)))
                    (|:| |expdata| (|SortedExponentVector|))
                    (|:| |coeffdata| (|U32Vector|)))))
        (SPROG
         ((#1=#:G847 NIL) (|i| NIL) (|oei| #2=(|SingleInteger|)) (|nei| #2#)
          (|oei0| #2#) (#3=#:G846 NIL) (|i1| NIL) (|nm| #2#)
          (|cij| (|Integer|)) (#4=#:G845 NIL) (|j| NIL)
          (|k| (|NonNegativeInteger|)) (|ci| (|U32Vector|)) (|opi| (|Integer|))
          (|pi| (|Integer|)) (#5=#:G844 NIL) (|npo| (|Vector| (|Integer|)))
          (|pi_cnt| (|NonNegativeInteger|)) (|ncoeffs| (|U32Vector|))
          (|nexps| (|SortedExponentVector|)) (|nnvars| (|Integer|))
          (|m| (|Integer|)) (#6=#:G843 NIL) (#7=#:G842 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |m| 0) (LETT |n| (QVSIZE |coeffs|))
              (SEQ (LETT |i| 0) (LETT #7# (- |n| 1)) G190
                   (COND ((|greater_SI| |i| #7#) (GO G191)))
                   (SEQ (LETT |ci| (QAREF1 |coeffs| |i|))
                        (LETT |k| (QV_LEN_U32 |ci|))
                        (EXIT
                         (SEQ (LETT |j| 0) (LETT #6# (- |k| 1)) G190
                              (COND ((|greater_SI| |j| #6#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL (ELT_U32 |ci| |j|) 0
                                            (QREFELT $ 27))
                                  (LETT |m| (+ |m| 1))))))
                              (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |nnvars| (+ |var_cnt| 1))
              (LETT |nexps| (GETREFV_U32 (* |m| |nnvars|) 0))
              (LETT |ncoeffs| (GETREFV_U32 |m| 0))
              (LETT |pi_cnt| (QVSIZE |poly_offsets|))
              (LETT |npo| (MAKEARR1 |pi_cnt| 0)) (LETT |pi| 1)
              (LETT |opi| (SPADCALL |poly_offsets| |pi| (QREFELT $ 38)))
              (LETT |nm| 0) (LETT |oei| 0) (LETT |nei| 0)
              (SEQ (LETT |i| 0) (LETT #5# (- |n| 1)) G190
                   (COND ((|greater_SI| |i| #5#) (GO G191)))
                   (SEQ
                    (SEQ G190 (COND ((NULL (EQL |opi| |i|)) (GO G191)))
                         (SEQ (SPADCALL |npo| |pi| |nm| (QREFELT $ 39))
                              (LETT |pi| (+ |pi| 1))
                              (EXIT
                               (LETT |opi|
                                     (COND
                                      ((<= |pi| |pi_cnt|)
                                       (LETT |opi|
                                             (SPADCALL |poly_offsets| |pi|
                                                       (QREFELT $ 38))))
                                      ('T -1)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (LETT |ci| (QAREF1 |coeffs| |i|))
                    (LETT |k| (QV_LEN_U32 |ci|))
                    (SEQ (LETT |j| 0) (LETT #4# (- |k| 1)) G190
                         (COND ((|greater_SI| |j| #4#) (GO G191)))
                         (SEQ (LETT |cij| (ELT_U32 |ci| |j|))
                              (EXIT
                               (COND
                                ((SPADCALL |cij| 0 (QREFELT $ 27))
                                 (SEQ (SETELT_U32 |ncoeffs| |nm| |cij|)
                                      (LETT |nm| (|add_SI| |nm| 1))
                                      (LETT |oei0| |oei|)
                                      (SEQ (LETT |i1| 1) (LETT #3# |var_cnt|)
                                           G190
                                           (COND
                                            ((|greater_SI| |i1| #3#)
                                             (GO G191)))
                                           (SEQ
                                            (SETELT_U32 |nexps| |nei|
                                                        (ELT_U32 |exps|
                                                                 |oei0|))
                                            (LETT |nei| (|add_SI| |nei| 1))
                                            (EXIT
                                             (LETT |oei0|
                                                   (|add_SI| |oei0| 1))))
                                           (LETT |i1| (|inc_SI| |i1|))
                                           (GO G190) G191 (EXIT NIL))
                                      (SETELT_U32 |nexps| |nei| |j|)
                                      (EXIT
                                       (LETT |nei| (|add_SI| |nei| 1))))))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (LETT |oei| (|add_SI| |oei| |var_cnt|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |i| |pi|) (LETT #1# |pi_cnt|) G190
                   (COND ((> |i| #1#) (GO G191)))
                   (SEQ (EXIT (SPADCALL |npo| |i| |nm| (QREFELT $ 39))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |nnvars| |npo| |nexps| |ncoeffs|))))) 

(SDEFUN |VECREC1;remove_denoms;V2PaIPa;8|
        ((|block_offsets| (|Vector| (|Integer|)))
         (|nums| (|PrimitiveArray| (|U32Vector|)))
         (|dens| (|PrimitiveArray| (|U32Vector|))) (|p| (|Integer|))
         ($ (|PrimitiveArray| (|U32Vector|))))
        (SPROG
         ((|dt| #1=(|Integer|)) (#2=#:G871 NIL) (|j| NIL)
          (|tmpp2| #3=(|U32Vector|)) (|tmpp1| #3#) (|dtmp| #1#) (|dresi| #1#)
          (|resi| (|U32Vector|)) (#4=#:G870 NIL) (|i| NIL) (|dcf| #1#)
          (|cfactor| (|U32Vector|)) (#5=#:G869 NIL) (#6=#:G868 NIL)
          (|dcden| #1#) (|cden| (|U32Vector|)) (|hi| #7=(|Integer|)) (|li| #7#)
          (#8=#:G867 NIL) (|ib| NIL) (|res| (|PrimitiveArray| (|U32Vector|)))
          (|np| (|NonNegativeInteger|)) (|nb| (|NonNegativeInteger|)))
         (SEQ (LETT |nb| (QVSIZE |block_offsets|)) (LETT |np| (QVSIZE |nums|))
              (LETT |res| (MAKEARR1 |np| (GETREFV_U32 0 0)))
              (SEQ (LETT |ib| 1) (LETT #8# |nb|) G190
                   (COND ((|greater_SI| |ib| #8#) (GO G191)))
                   (SEQ
                    (LETT |li| (SPADCALL |block_offsets| |ib| (QREFELT $ 38)))
                    (LETT |hi|
                          (COND ((EQL |ib| |nb|) |np|)
                                ('T
                                 (SPADCALL |block_offsets| (+ |ib| 1)
                                           (QREFELT $ 38)))))
                    (LETT |hi| (- |hi| 1))
                    (LETT |cden|
                          (SPADCALL |dens| |li| |hi| |p| (QREFELT $ 43)))
                    (LETT |dcden| (SPADCALL |cden| (QREFELT $ 24)))
                    (LETT |tmpp1| (GETREFV_U32 (+ |dcden| 1) 0))
                    (LETT |tmpp2| (GETREFV_U32 (+ |dcden| 1) 0))
                    (SEQ (LETT |i| |li|) (LETT #6# |hi|) G190
                         (COND ((> |i| #6#) (GO G191)))
                         (SEQ
                          (SPADCALL |tmpp1| |cden| (+ |dcden| 1)
                                    (QREFELT $ 17))
                          (SEQ (LETT |j| 0) (LETT #5# |dcden|) G190
                               (COND ((|greater_SI| |j| #5#) (GO G191)))
                               (SEQ (EXIT (SETELT_U32 |tmpp2| |j| 0)))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT NIL))
                          (SPADCALL |tmpp1| (QAREF1 |dens| |i|) |tmpp2| |p|
                                    (QREFELT $ 44))
                          (LETT |dt| (SPADCALL |tmpp2| (QREFELT $ 24)))
                          (EXIT
                           (QSETAREF1 |res| |i|
                                      (COND
                                       ((> |dt| 0)
                                        (SPADCALL |tmpp2| (QAREF1 |nums| |i|)
                                                  |p| (QREFELT $ 32)))
                                       ('T
                                        (SEQ
                                         (COND
                                          ((EQL |dt| 0)
                                           (COND
                                            ((SPADCALL (ELT_U32 |tmpp2| 0) 1
                                                       (QREFELT $ 27))
                                             (EXIT
                                              (|error|
                                               "remove_denoms expect quotient to be 1"))))))
                                         (EXIT (QAREF1 |nums| |i|))))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                    (LETT |cfactor|
                          (SPADCALL |res| |li| |hi| |p| (QREFELT $ 45)))
                    (LETT |dcf| (SPADCALL |cfactor| (QREFELT $ 24)))
                    (LETT |dtmp| |dcden|)
                    (EXIT
                     (COND
                      ((>= |dcf| 1)
                       (SEQ (LETT |i| |li|) (LETT #4# |hi|) G190
                            (COND ((> |i| #4#) (GO G191)))
                            (SEQ (LETT |resi| (QAREF1 |res| |i|))
                                 (LETT |dresi|
                                       (SPADCALL |resi| (QREFELT $ 24)))
                                 (COND
                                  ((> |dresi| |dtmp|)
                                   (SEQ (LETT |dtmp| |dresi|)
                                        (LETT |tmpp1|
                                              (GETREFV_U32 (+ |dtmp| 1) 0))
                                        (EXIT
                                         (LETT |tmpp2|
                                               (GETREFV_U32 (+ |dtmp| 1) 0)))))
                                  ('T
                                   (SEQ (LETT |j| 0) (LETT #2# |dtmp|) G190
                                        (COND
                                         ((|greater_SI| |j| #2#) (GO G191)))
                                        (SEQ (EXIT (SETELT_U32 |tmpp2| |j| 0)))
                                        (LETT |j| (|inc_SI| |j|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (SPADCALL |tmpp1| |resi| (+ |dresi| 1)
                                           (QREFELT $ 17))
                                 (SPADCALL |tmpp1| |cfactor| |tmpp2| |p|
                                           (QREFELT $ 44))
                                 (LETT |dt| (SPADCALL |tmpp2| (QREFELT $ 24)))
                                 (QSETAREF1 |res| |i|
                                            (GETREFV_U32 (+ |dt| 1) 0))
                                 (EXIT
                                  (SPADCALL (QAREF1 |res| |i|) |tmpp2|
                                            (+ |dt| 1) (QREFELT $ 17))))
                            (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))))))
                   (LETT |ib| (|inc_SI| |ib|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |VECREC1;reconstruct;I2VSev2PaIR;9|
        ((|var_cnt| (|Integer|)) (|block_offsets| (|Vector| (|Integer|)))
         (|poly_offsets| (|Vector| (|Integer|)))
         (|exps| (|SortedExponentVector|))
         (|nums| (|PrimitiveArray| (|U32Vector|)))
         (|dens| (|PrimitiveArray| (|U32Vector|))) (|p| (|Integer|))
         ($
          (|Record| (|:| |nvars| (|Integer|))
                    (|:| |offsetdata| (|Vector| (|Integer|)))
                    (|:| |expdata| (|SortedExponentVector|))
                    (|:| |coeffdata| (|U32Vector|)))))
        (SPROG ((|ppa| (|PrimitiveArray| (|U32Vector|))))
               (SEQ
                (LETT |ppa|
                      (SPADCALL |block_offsets| |nums| |dens| |p|
                                (QREFELT $ 46)))
                (EXIT
                 (SPADCALL |var_cnt| |poly_offsets| |exps| |ppa|
                           (QREFELT $ 42)))))) 

(SDEFUN |VECREC1;reconstruct;$I2VSevU;10|
        ((|statearg| ($)) (|var_cnt| (|Integer|))
         (|block_offsets| (|Vector| (|Integer|)))
         (|poly_offsets| (|Vector| (|Integer|)))
         (|exps| (|SortedExponentVector|))
         ($
          (|Union|
           (|Record| (|:| |nvars| (|Integer|))
                     (|:| |offsetdata| (|Vector| (|Integer|)))
                     (|:| |expdata| (|SortedExponentVector|))
                     (|:| |coeffdata| (|U32Vector|)))
           "failed")))
        (SPROG
         ((|ppr|
           (|Record| (|:| |numers| (|PrimitiveArray| (|U32Vector|)))
                     (|:| |denoms| (|PrimitiveArray| (|U32Vector|)))))
          (|state| (|Rep|)) (#1=#:G889 NIL)
          (|pp|
           (|Union|
            (|Record| (|:| |numers| (|PrimitiveArray| (|U32Vector|)))
                      (|:| |denoms| (|PrimitiveArray| (|U32Vector|))))
            "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |pp| (SPADCALL |statearg| (QREFELT $ 36)))
                (EXIT
                 (COND
                  ((QEQCAR |pp| 1)
                   (PROGN (LETT #1# (CONS 1 "failed")) (GO #2=#:G888)))
                  ('T
                   (SEQ (LETT |state| |statearg|) (LETT |ppr| (QCDR |pp|))
                        (EXIT
                         (CONS 0
                               (SPADCALL |var_cnt| |block_offsets|
                                         |poly_offsets| |exps| (QCAR |ppr|)
                                         (QCDR |ppr|) (QVELT |state| 0)
                                         (QREFELT $ 47))))))))))
          #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |VectorModularReconstructor;|)) 

(DEFUN |VectorModularReconstructor| ()
  (SPROG NIL
         (PROG (#1=#:G891)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|VectorModularReconstructor|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|VectorModularReconstructor|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|VectorModularReconstructor;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|VectorModularReconstructor|)))))))))) 

(DEFUN |VectorModularReconstructor;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|VectorModularReconstructor|))
          (LETT $ (GETREFV 50))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|VectorModularReconstructor| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |prime| (|Integer|))
                              (|:| |lpol| (|U32Vector|))
                              (|:| |curj| (|Integer|))
                              (|:| |npoints| (|Integer|))
                              (|:| |npolys| (|Integer|))
                              (|:| |palloc| (|Integer|))
                              (|:| |polys| (|PrimitiveArray| (|U32Vector|)))
                              (|:| |next_rec| (|Integer|))
                              (|:| |rec_step| (|Integer|))
                              (|:| |numers| (|PrimitiveArray| (|U32Vector|)))
                              (|:| |denoms| (|PrimitiveArray| (|U32Vector|)))))
          $))) 

(MAKEPROP '|VectorModularReconstructor| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Integer|) |VECREC1;empty;2I$;1|
              (|Boolean|) (|PrimitiveArray| 15) (0 . |empty?|) (|Void|)
              (|List| 7) |VECREC1;add_slots;L$V;2| (|U32Vector|)
              (|U32VectorPolynomialOperations|) (5 . |copy_first|)
              (12 . |eval_at|) (20 . |invmod|) (26 . |positiveRemainder|)
              (32 . |vector_add_mul|) (42 . |mul_by_binomial|)
              |VECREC1;chinese_update;UvI$V;4| (50 . |degree|)
              (55 . |vector_combination|) (66 . |gcd|) (73 . ~=)
              (79 . |mul_by_scalar|)
              (|Record| (|:| |numer| 15) (|:| |denom| 15))
              (|Union| 29 '"failed") |VECREC1;rational_reconstruction;2Uv2IU;5|
              (87 . |mul|) (94 . |remainder!|)
              (|Record| (|:| |numers| 10) (|:| |denoms| 10))
              (|Union| 34 '"failed") |VECREC1;rational_reconstruction;$U;6|
              (|Vector| 7) (101 . |elt|) (107 . |setelt!|)
              (|Record| (|:| |nvars| 7) (|:| |offsetdata| 37)
                        (|:| |expdata| 41) (|:| |coeffdata| 15))
              (|SortedExponentVector|) |VECREC1;repack_polys;IVSevPaR;7|
              (114 . |lcm|) (122 . |divide!|) (130 . |gcd|)
              |VECREC1;remove_denoms;V2PaIPa;8|
              |VECREC1;reconstruct;I2VSev2PaIR;9| (|Union| 40 '"failed")
              |VECREC1;reconstruct;$I2VSevU;10|)
           '#(|repack_polys| 138 |remove_denoms| 146 |reconstruct| 154
              |rational_reconstruction| 174 |empty| 187 |chinese_update| 193
              |add_slots| 200)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|empty| ($$ (|Integer|) (|Integer|))) T)
                                   '((|add_slots|
                                      ((|Void|) (|List| (|Integer|)) $$))
                                     T)
                                   '((|chinese_update|
                                      ((|Void|) (|U32Vector|) (|Integer|) $$))
                                     T)
                                   '((|rational_reconstruction|
                                      ((|Union|
                                        (|Record|
                                         (|:| |numers|
                                              (|PrimitiveArray| (|U32Vector|)))
                                         (|:| |denoms|
                                              (|PrimitiveArray|
                                               (|U32Vector|))))
                                        "failed")
                                       $$))
                                     T)
                                   '((|rational_reconstruction|
                                      ((|Union|
                                        (|Record| (|:| |numer| (|U32Vector|))
                                                  (|:| |denom| (|U32Vector|)))
                                        "failed")
                                       (|U32Vector|) (|U32Vector|) (|Integer|)
                                       (|Integer|)))
                                     T)
                                   '((|repack_polys|
                                      ((|Record| (|:| |nvars| (|Integer|))
                                                 (|:| |offsetdata|
                                                      (|Vector| (|Integer|)))
                                                 (|:| |expdata|
                                                      (|SortedExponentVector|))
                                                 (|:| |coeffdata|
                                                      (|U32Vector|)))
                                       (|Integer|) (|Vector| (|Integer|))
                                       (|SortedExponentVector|)
                                       (|PrimitiveArray| (|U32Vector|))))
                                     T)
                                   '((|remove_denoms|
                                      ((|PrimitiveArray| (|U32Vector|))
                                       (|Vector| (|Integer|))
                                       (|PrimitiveArray| (|U32Vector|))
                                       (|PrimitiveArray| (|U32Vector|))
                                       (|Integer|)))
                                     T)
                                   '((|reconstruct|
                                      ((|Record| (|:| |nvars| (|Integer|))
                                                 (|:| |offsetdata|
                                                      (|Vector| (|Integer|)))
                                                 (|:| |expdata|
                                                      (|SortedExponentVector|))
                                                 (|:| |coeffdata|
                                                      (|U32Vector|)))
                                       (|Integer|) (|Vector| (|Integer|))
                                       (|Vector| (|Integer|))
                                       (|SortedExponentVector|)
                                       (|PrimitiveArray| (|U32Vector|))
                                       (|PrimitiveArray| (|U32Vector|))
                                       (|Integer|)))
                                     T)
                                   '((|reconstruct|
                                      ((|Union|
                                        (|Record| (|:| |nvars| (|Integer|))
                                                  (|:| |offsetdata|
                                                       (|Vector| (|Integer|)))
                                                  (|:| |expdata|
                                                       (|SortedExponentVector|))
                                                  (|:| |coeffdata|
                                                       (|U32Vector|)))
                                        "failed")
                                       $$ (|Integer|) (|Vector| (|Integer|))
                                       (|Vector| (|Integer|))
                                       (|SortedExponentVector|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 49
                                            '(1 10 9 0 11 3 16 12 15 15 7 17 4
                                              16 7 15 7 7 7 18 2 7 0 0 0 19 2 7
                                              0 0 0 20 6 16 12 15 15 7 7 7 7 21
                                              4 16 12 15 7 7 7 22 1 16 7 15 24
                                              7 16 12 15 7 15 7 7 7 7 25 3 16
                                              15 15 15 7 26 2 7 9 0 0 27 4 16
                                              12 15 7 7 7 28 3 16 15 15 15 7 32
                                              3 16 12 15 15 7 33 2 37 7 0 7 38
                                              3 37 7 0 7 7 39 4 16 15 10 7 7 7
                                              43 4 16 12 15 15 15 7 44 4 16 15
                                              10 7 7 7 45 4 0 40 7 37 41 10 42
                                              4 0 10 37 10 10 7 46 5 0 48 0 7
                                              37 37 41 49 7 0 40 7 37 37 41 10
                                              10 7 47 1 0 35 0 36 4 0 30 15 15
                                              7 7 31 2 0 0 7 7 8 3 0 12 15 7 0
                                              23 2 0 12 13 0 14)))))
           '|lookupComplete|)) 

(MAKEPROP '|VectorModularReconstructor| 'NILADIC T) 

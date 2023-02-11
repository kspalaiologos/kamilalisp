
(SDEFUN |MODFACT;mvmul|
        ((|m| (|U32Matrix|)) (|v| (|U32Vector|)) (|p| (|Integer|))
         ($ (|U32Vector|)))
        (SPROG
         ((|ss| (|Integer|)) (#1=#:G716 NIL) (|j| NIL) (#2=#:G715 NIL)
          (|i| NIL) (|res| (|U32Vector|)) (|nc| (|NonNegativeInteger|))
          (|nr| (|NonNegativeInteger|)))
         (SEQ (LETT |nr| (ANROWS_U32 |m|)) (LETT |nc| (ANCOLS_U32 |m|))
              (EXIT
               (COND
                ((SPADCALL |nc| (QV_LEN_U32 |v|) (QREFELT $ 8))
                 (|error| "mvmul: nc ~= #v"))
                ('T
                 (SEQ (LETT |res| (GETREFV_U32 |nr| 0))
                      (SEQ (LETT |i| 0) (LETT #2# (- |nr| 1)) G190
                           (COND ((|greater_SI| |i| #2#) (GO G191)))
                           (SEQ (LETT |ss| 0)
                                (SEQ (LETT |j| 0) (LETT #1# (- |nc| 1)) G190
                                     (COND ((|greater_SI| |j| #1#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT |ss|
                                             (QSMULADD64_32
                                              (AREF2_U32 |m| |i| |j|)
                                              (ELT_U32 |v| |j|) |ss|))))
                                     (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                     (EXIT NIL))
                                (EXIT
                                 (SETELT_U32 |res| |i| (QSMOD64_32 |ss| |p|))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT |res|)))))))) 

(SDEFUN |MODFACT;mmul;2UmIUm;2|
        ((|m1| (|U32Matrix|)) (|m2| (|U32Matrix|)) (|p| (|Integer|))
         ($ (|U32Matrix|)))
        (SPROG
         ((|ss| (|Integer|)) (#1=#:G729 NIL) (|k| NIL) (#2=#:G728 NIL)
          (|j| NIL) (#3=#:G727 NIL) (|i| NIL) (|res| (|U32Matrix|))
          (|nr2| #4=(|NonNegativeInteger|)) (|nc1| (|NonNegativeInteger|))
          (|nr1| #4#))
         (SEQ (LETT |nr1| (ANROWS_U32 |m1|)) (LETT |nc1| (ANCOLS_U32 |m1|))
              (EXIT
               (COND
                ((SPADCALL |nc1| (ANCOLS_U32 |m2|) (QREFELT $ 8))
                 (|error| "mmul: dimensions do not match"))
                ('T
                 (SEQ (LETT |nr2| (ANROWS_U32 |m2|))
                      (LETT |res| (MAKE_MATRIX1_U32 |nr1| |nr2| 0))
                      (SEQ (LETT |i| 0) (LETT #3# (- |nr1| 1)) G190
                           (COND ((|greater_SI| |i| #3#) (GO G191)))
                           (SEQ
                            (EXIT
                             (SEQ (LETT |j| 0) (LETT #2# (- |nr2| 1)) G190
                                  (COND ((|greater_SI| |j| #2#) (GO G191)))
                                  (SEQ (LETT |ss| 0)
                                       (SEQ (LETT |k| 0) (LETT #1# (- |nc1| 1))
                                            G190
                                            (COND
                                             ((|greater_SI| |k| #1#)
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT |ss|
                                                    (QSMULADD64_32
                                                     (AREF2_U32 |m1| |i| |k|)
                                                     (AREF2_U32 |m2| |j| |k|)
                                                     |ss|))))
                                            (LETT |k| (|inc_SI| |k|)) (GO G190)
                                            G191 (EXIT NIL))
                                       (EXIT
                                        (SETAREF2_U32 |res| |i| |j|
                                                      (QSMOD64_32 |ss| |p|))))
                                  (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                  (EXIT NIL))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT |res|)))))))) 

(SDEFUN |MODFACT;copy_slice2|
        ((|np| (|U32Vector|)) (|op| (|U32Vector|)) (|n| (|Integer|))
         (|m| (|Integer|)) ($ (|Void|)))
        (SPROG ((#1=#:G733 NIL) (|i| NIL))
               (SEQ (LETT |i| 0) (LETT #1# (- |m| 1)) G190
                    (COND ((|greater_SI| |i| #1#) (GO G191)))
                    (SEQ
                     (EXIT (SETELT_U32 |np| |i| (ELT_U32 |op| (+ |n| |i|)))))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))) 

(SDEFUN |MODFACT;red_pol;UvLV;4|
        ((|pol| (|U32Vector|))
         (|rdata|
          (|List|
           (|Record| (|:| |ind| (|NonNegativeInteger|))
                     (|:| |poly| (|U32Vector|)))))
         ($ (|Void|)))
        (SPROG
         ((#1=#:G746 NIL) (|i| NIL) (|tmp| (|U32Vector|))
          (|mi| (|NonNegativeInteger|)) (|ni| #2=(|Integer|))
          (|ii| #3=(|NonNegativeInteger|)) (#4=#:G745 NIL) (|ri| NIL)
          (|n0| #2#) (|f| (|U32Vector|)) (|p| #3#)
          (|r0|
           (|Record| (|:| |ind| (|NonNegativeInteger|))
                     (|:| |poly| (|U32Vector|)))))
         (SEQ (LETT |r0| (|SPADfirst| |rdata|)) (LETT |p| (QCAR |r0|))
              (LETT |f| (QCDR |r0|)) (LETT |n0| (SPADCALL |f| (QREFELT $ 14)))
              (LETT |rdata| (CDR |rdata|))
              (SEQ (LETT |ri| NIL) (LETT #4# |rdata|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |ri| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ii| (QCAR |ri|))
                        (LETT |ni| (SPADCALL |pol| (QREFELT $ 14)))
                        (EXIT
                         (COND
                          ((>= |ni| |ii|)
                           (SEQ (LETT |mi| (+ (- |ni| |ii|) 1))
                                (LETT |tmp| (GETREFV_U32 |mi| 0))
                                (|MODFACT;copy_slice2| |tmp| |pol| |ii| |mi| $)
                                (SPADCALL |tmp| (QCDR |ri|) |pol|
                                          (- (+ |n0| |mi|) 2) |p|
                                          (QREFELT $ 16))
                                (EXIT
                                 (SEQ (LETT |i| |ii|) (LETT #1# |ni|) G190
                                      (COND ((> |i| #1#) (GO G191)))
                                      (SEQ (EXIT (SETELT_U32 |pol| |i| 0)))
                                      (LETT |i| (+ |i| 1)) (GO G190) G191
                                      (EXIT NIL))))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |pol| |f| |p| (QREFELT $ 17)))))) 

(SDEFUN |MODFACT;mod_exp;UvILUv;5|
        ((|pol| (|U32Vector|)) (|n| (|Integer|))
         (|rdata|
          (|List|
           (|Record| (|:| |ind| (|NonNegativeInteger|))
                     (|:| |poly| (|U32Vector|)))))
         ($ (|U32Vector|)))
        (SPROG
         ((|pow1| #1=(|U32Vector|)) (#2=#:G758 NIL) (|has_res| (|Boolean|))
          (|res1| #1#) (|res| #3=(|U32Vector|)) (|pow| #3#)
          (|m| (|NonNegativeInteger|)) (|f| (|U32Vector|))
          (|p| (|NonNegativeInteger|))
          (|r0|
           (|Record| (|:| |ind| (|NonNegativeInteger|))
                     (|:| |poly| (|U32Vector|)))))
         (SEQ
          (COND ((<= |n| 0) (|error| "mod_exp: n must be positive"))
                ('T
                 (SEQ (LETT |r0| (|SPADfirst| |rdata|)) (LETT |p| (QCAR |r0|))
                      (LETT |f| (QCDR |r0|))
                      (LETT |m| (SPADCALL |f| (QREFELT $ 14)))
                      (LETT |pow| (GETREFV_U32 |m| 0))
                      (SPADCALL |pow| |pol| (MIN |m| (QV_LEN_U32 |pol|))
                                (QREFELT $ 21))
                      (LETT |res| (GETREFV_U32 |m| 0)) (LETT |has_res| NIL)
                      (SEQ
                       (EXIT
                        (SEQ G190 (COND ((NULL (> |n| 0)) (GO G191)))
                             (SEQ
                              (COND
                               ((ODDP |n|)
                                (COND
                                 (|has_res|
                                  (SEQ
                                   (LETT |res1|
                                         (SPADCALL |pow| |res| |p|
                                                   (QREFELT $ 22)))
                                   (SPADCALL |res1| |rdata| (QREFELT $ 20))
                                   (EXIT
                                    (SPADCALL |res| |res1|
                                              (MIN |m| (QV_LEN_U32 |res1|))
                                              (QREFELT $ 21)))))
                                 ('T
                                  (SEQ
                                   (SPADCALL |res| |pow| |m| (QREFELT $ 21))
                                   (EXIT (LETT |has_res| 'T)))))))
                              (LETT |n| (QUOTIENT2 |n| 2))
                              (EXIT
                               (COND
                                ((EQL |n| 0)
                                 (PROGN (LETT #2# |$NoValue|) (GO #4=#:G755)))
                                ('T
                                 (SEQ
                                  (LETT |pow1|
                                        (SPADCALL |pow| |pow| |p|
                                                  (QREFELT $ 22)))
                                  (SPADCALL |pow1| |rdata| (QREFELT $ 20))
                                  (EXIT
                                   (SPADCALL |pow| |pow1|
                                             (MIN |m| (QV_LEN_U32 |pow1|))
                                             (QREFELT $ 21))))))))
                             NIL (GO G190) G191 (EXIT NIL)))
                       #4# (EXIT #2#))
                      (EXIT |res|))))))) 

(SDEFUN |MODFACT;power_matrix;UvNniLR;6|
        ((|xp| (|U32Vector|)) (|l| (|NonNegativeInteger|))
         (|rdata|
          (|List|
           (|Record| (|:| |ind| (|NonNegativeInteger|))
                     (|:| |poly| (|U32Vector|)))))
         ($ (|Record| (|:| |matr| (|U32Matrix|)) (|:| |poly| (|U32Vector|)))))
        (SPROG
         ((#1=#:G773 NIL) (|k| NIL) (|nn1| (|Integer|)) (|pow1| (|U32Vector|))
          (#2=#:G772 NIL) (#3=#:G771 NIL) (|j| NIL) (|n1| (|SingleInteger|))
          (|l1| (|Integer|)) (|pow| (|U32Vector|)) (|pm| (|U32Matrix|))
          (|n| (|NonNegativeInteger|)) (|f| (|U32Vector|))
          (|p| (|NonNegativeInteger|))
          (|r0|
           (|Record| (|:| |ind| (|NonNegativeInteger|))
                     (|:| |poly| (|U32Vector|)))))
         (SEQ (LETT |r0| (|SPADfirst| |rdata|)) (LETT |p| (QCAR |r0|))
              (LETT |f| (QCDR |r0|)) (LETT |n| (SPADCALL |f| (QREFELT $ 14)))
              (LETT |pm| (MAKE_MATRIX1_U32 |n| |l| 0))
              (SETAREF2_U32 |pm| 0 0 1) (LETT |pow| (GETREFV_U32 |n| 0))
              (SPADCALL |pow| |xp| (MIN |n| (QV_LEN_U32 |xp|)) (QREFELT $ 21))
              (LETT |l1| (- |l| 1)) (LETT |n1| (- |n| 1))
              (SEQ (LETT |j| 1) (LETT #3# |l1|) G190
                   (COND ((|greater_SI| |j| #3#) (GO G191)))
                   (SEQ
                    (SEQ (LETT |k| 0) (LETT #2# (- |n| 1)) G190
                         (COND ((|greater_SI| |k| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SETAREF2_U32 |pm| |k| |j| (ELT_U32 |pow| |k|))))
                         (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                    (LETT |pow1| (SPADCALL |xp| |pow| |p| (QREFELT $ 22)))
                    (SPADCALL |pow1| |rdata| (QREFELT $ 20))
                    (LETT |nn1|
                          (MIN |n| (+ (SPADCALL |pow1| (QREFELT $ 14)) 1)))
                    (SPADCALL |pow| |pow1| |nn1| (QREFELT $ 21))
                    (EXIT
                     (SEQ (LETT |k| |nn1|) (LETT #1# (- |n| 1)) G190
                          (COND ((> |k| #1#) (GO G191)))
                          (SEQ (EXIT (SETELT_U32 |pow| |k| 0)))
                          (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |pm| |pow|))))) 

(SDEFUN |MODFACT;modular_compose;UvUmUv2NniLUv;7|
        ((|pol| (|U32Vector|)) (|pm| (|U32Matrix|)) (|xp1| (|U32Vector|))
         (|l1| (|NonNegativeInteger|)) (|l2| (|NonNegativeInteger|))
         (|rdata|
          (|List|
           (|Record| (|:| |ind| (|NonNegativeInteger|))
                     (|:| |poly| (|U32Vector|)))))
         ($ (|U32Vector|)))
        (SPROG
         ((|res1| (|U32Vector|)) (#1=#:G790 NIL) (|i| (|SingleInteger|))
          (|k| NIL) (|ns1| (|SingleInteger|)) (|res| #2=(|U32Vector|))
          (|p1| #2#) (|m2| (|U32Matrix|)) (#3=#:G789 NIL) (#4=#:G788 NIL)
          (|j| NIL) (|k1| #5=(|SingleInteger|)) (|l1s| #5#)
          (|m1| (|U32Matrix|)) (|ns| #5#) (|n| (|NonNegativeInteger|))
          (|f| (|U32Vector|)) (|p| (|NonNegativeInteger|))
          (|r0|
           (|Record| (|:| |ind| (|NonNegativeInteger|))
                     (|:| |poly| (|U32Vector|)))))
         (SEQ (LETT |r0| (|SPADfirst| |rdata|)) (LETT |p| (QCAR |r0|))
              (LETT |f| (QCDR |r0|)) (LETT |n| (SPADCALL |f| (QREFELT $ 14)))
              (LETT |ns| |n|) (LETT |m1| (MAKE_MATRIX1_U32 |l2| |l1| 0))
              (LETT |i| 0) (LETT |l1s| (- |l1| 1)) (LETT |k1| (- |l2| 1))
              (SEQ (LETT |j| 0) (LETT #4# |k1|) G190
                   (COND ((|greater_SI| |j| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |k| 0) (LETT #3# |l1s|) G190
                          (COND
                           ((OR (|greater_SI| |k| #3#)
                                (NULL (|less_SI| |i| |ns|)))
                            (GO G191)))
                          (SEQ (SETAREF2_U32 |m1| |j| |k| (ELT_U32 |pol| |i|))
                               (EXIT (LETT |i| (|add_SI| |i| 1))))
                          (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (LETT |m2| (SPADCALL |m1| |pm| |p| (QREFELT $ 11)))
              (LETT |p1| (GETREFV_U32 |n| 0)) (LETT |res| (GETREFV_U32 |n| 0))
              (LETT |ns1| (|sub_SI| |ns| 1))
              (SEQ (LETT |k| |k1|) G190 (COND ((< |k| 0) (GO G191)))
                   (SEQ
                    (SEQ (LETT |i| 0) (LETT #1# |ns1|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SETELT_U32 |p1| |i| (AREF2_U32 |m2| |k| |i|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (COND
                     ((< |k| |k1|)
                      (SEQ
                       (LETT |res1| (SPADCALL |xp1| |res| |p| (QREFELT $ 22)))
                       (SPADCALL |res1| |rdata| (QREFELT $ 20))
                       (EXIT
                        (SPADCALL |res| |res1| (MIN |n| (QV_LEN_U32 |res1|))
                                  (QREFELT $ 21))))))
                    (EXIT (SPADCALL |res| |p1| 0 |ns1| 1 |p| (QREFELT $ 26))))
                   (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |MODFACT;ini_rdata;UvIL;8|
        ((|pol| (|U32Vector|)) (|p| (|Integer|))
         ($
          (|List|
           #1=(|Record| (|:| |ind| (|NonNegativeInteger|))
                        (|:| |poly| (|U32Vector|))))))
        (SPROG
         ((|res| (|List| #1#)) (|tmp1| #2=(|U32Vector|)) (#3=#:G801 NIL)
          (|i| NIL) (|ni| #4=(|Integer|)) (|ii| #4#) (|nn| (|Integer|))
          (|tmp| #2#) (|n1| #4#) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |pol| (QREFELT $ 14)))
              (LETT |res| (LIST (CONS |p| |pol|)))
              (LETT |ni| (LETT |n1| (- |n| 1)))
              (LETT |tmp| (GETREFV_U32 (* 2 |n1|) 0))
              (SEQ G190 (COND ((NULL (> |ni| 10)) (GO G191)))
                   (SEQ (LETT |nn| (QUOTIENT2 (- |ni| 1) 2))
                        (LETT |ii| (- (+ |n1| |ni|) |nn|))
                        (LETT |ni| (- (- |ii| |n1|) 1))
                        (SEQ (LETT |i| 0) (LETT #3# |n1|) G190
                             (COND ((|greater_SI| |i| #3#) (GO G191)))
                             (SEQ (EXIT (SETELT_U32 |tmp| |i| 0)))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (SETELT_U32 |tmp| |ii| 1)
                        (SPADCALL |tmp| |pol| |p| (QREFELT $ 17))
                        (LETT |tmp1| (GETREFV_U32 |n| 0))
                        (SPADCALL |tmp1| |tmp| |n| (QREFELT $ 21))
                        (EXIT (LETT |res| (CONS (CONS |ii| |tmp1|) |res|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |res|))))) 

(SDEFUN |MODFACT;floor_sqrt| ((|n| (|Integer|)) ($ (|Integer|)))
        (SPROG ((|res| (|Integer|)))
               (SEQ (LETT |res| (SPADCALL |n| (QREFELT $ 31)))
                    (EXIT
                     (COND ((<= |n| (* |res| |res|)) |res|)
                           ('T (+ |res| 1))))))) 

(SDEFUN |MODFACT;eqfact|
        ((|pol| (|U32Vector|)) (|l| (|Integer|)) (|pmat1| (|U32Matrix|))
         (|xp1| (|U32Vector|)) (|pmat2| (|U32Matrix|)) (|xp2| (|U32Vector|))
         (|l1| (|NonNegativeInteger|)) (|l2| (|NonNegativeInteger|))
         (|k1| (|Integer|)) (|k2| (|Integer|))
         (|rdata|
          (|List|
           (|Record| (|:| |ind| #1=(|NonNegativeInteger|))
                     (|:| |poly| #2=(|U32Vector|)))))
         (|res| (|List| (|U32Vector|))) ($ (|List| (|U32Vector|))))
        (SPROG
         ((|dg| #3=(|NonNegativeInteger|)) (|dp| (|NonNegativeInteger|))
          (|#G64| (|NonNegativeInteger|)) (|#G63| #3#) (|g| #4=(|U32Vector|))
          (|#G62| #4#) (|#G61| #5=(|U32Vector|)) (|tmp| #5#) (|tr1| #5#)
          (|tr| #5#) (#6=#:G826 NIL) (|i| NIL) (#7=#:G825 NIL) (#8=#:G824 NIL)
          (|kk| (|Integer|)) (#9=#:G823 NIL) (|n0| (|Integer|)) (|rpol| #5#)
          (|n| (|NonNegativeInteger|)) (|f| #2#) (|p| #1#)
          (|r0|
           (|Record| (|:| |ind| (|NonNegativeInteger|))
                     (|:| |poly| (|U32Vector|)))))
         (SEQ
          (COND ((EQL |l| 1) (CONS |pol| |res|))
                ('T
                 (SEQ (LETT |r0| (|SPADfirst| |rdata|)) (LETT |p| (QCAR |r0|))
                      (LETT |f| (QCDR |r0|))
                      (LETT |n| (SPADCALL |f| (QREFELT $ 14)))
                      (LETT |rpol| (GETREFV_U32 |n| 0))
                      (LETT |dp| (SPADCALL |pol| (QREFELT $ 14)))
                      (LETT |tmp| (GETREFV_U32 (+ |dp| 1) 0))
                      (SPADCALL |tmp| |pol| (+ |dp| 1) (QREFELT $ 21))
                      (LETT |pol| |tmp|) (LETT |n0| (QUOTIENT2 |dp| |l|))
                      (SEQ G190 (COND ((NULL (> |l| 1)) (GO G191)))
                           (SEQ
                            (SEQ (LETT |i| 0) (LETT #9# (- |n| 1)) G190
                                 (COND ((|greater_SI| |i| #9#) (GO G191)))
                                 (SEQ
                                  (EXIT (SETELT_U32 |rpol| |i| (RANDOM |p|))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (LETT |tr| |rpol|)
                            (LETT |kk| (MIN (- |n0| 1) |k1|))
                            (SEQ (LETT |i| 1) (LETT #8# |kk|) G190
                                 (COND ((|greater_SI| |i| #8#) (GO G191)))
                                 (SEQ (LETT |tr1| |tr|)
                                      (LETT |tr|
                                            (SPADCALL |tr| |pmat1| |xp1| |l1|
                                                      |l2| |rdata|
                                                      (QREFELT $ 27)))
                                      (EXIT
                                       (SPADCALL |tr| |rpol| 0 (- |n| 1) 1 |p|
                                                 (QREFELT $ 26))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (SEQ (LETT |i| 2)
                                 (LETT #7# (QUOTIENT2 (- |n0| 1) |k1|)) G190
                                 (COND ((|greater_SI| |i| #7#) (GO G191)))
                                 (SEQ
                                  (LETT |tr|
                                        (SPADCALL |tr| |pmat2| |xp2| |l1| |l2|
                                                  |rdata| (QREFELT $ 27)))
                                  (EXIT
                                   (SPADCALL |tr| |tr1| 0 (- |n| 1) 1 |p|
                                             (QREFELT $ 26))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (COND
                             ((> |n0| |k1|)
                              (SEQ (LETT |i| 1)
                                   (LETT #6# (REM (- |n0| 1) |k1|)) G190
                                   (COND ((|greater_SI| |i| #6#) (GO G191)))
                                   (SEQ
                                    (LETT |tr|
                                          (SPADCALL |tr| |pmat1| |xp1| |l1|
                                                    |l2| |rdata|
                                                    (QREFELT $ 27)))
                                    (EXIT
                                     (SPADCALL |tr| |rpol| 0 (- |n| 1) 1 |p|
                                               (QREFELT $ 26))))
                                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                   (EXIT NIL))))
                            (LETT |tr1|
                                  (COND ((EQL |p| 2) |tr|)
                                        ('T
                                         (SPADCALL |tr| (QUOTIENT2 (- |p| 1) 2)
                                                   |rdata| (QREFELT $ 23)))))
                            (LETT |tmp| (GETREFV_U32 |n| 0))
                            (SPADCALL |tr1| |pol| |tmp| |p| (QREFELT $ 32))
                            (LETT |tmp| (GETREFV_U32 |dp| 0))
                            (SPADCALL |tmp| |tr1| |dp| (QREFELT $ 21))
                            (COND
                             ((EQL (ELT_U32 |tmp| 0) 0)
                              (SETELT_U32 |tmp| 0 (- |p| 1)))
                             ('T (SETELT_U32 |tmp| 0 (- (ELT_U32 |tmp| 0) 1))))
                            (LETT |g|
                                  (SPADCALL |tmp| |pol| |p| (QREFELT $ 33)))
                            (LETT |dg| (SPADCALL |g| (QREFELT $ 14)))
                            (COND
                             ((OR (EQL |dg| 0) (EQL |dg| |dp|))
                              (EXIT "iterate")))
                            (SPADCALL |tmp| 0 (QREFELT $ 34))
                            (SPADCALL |pol| |g| |tmp| |p| (QREFELT $ 32))
                            (LETT |dp| (- |dp| |dg|))
                            (LETT |pol| (GETREFV_U32 (+ |dp| 1) 0))
                            (SPADCALL |pol| |tmp| (+ |dp| 1) (QREFELT $ 21))
                            (COND
                             ((< |dp| |dg|)
                              (SEQ
                               (PROGN
                                (LETT |#G61| |pol|)
                                (LETT |#G62| |g|)
                                (LETT |g| |#G61|)
                                (LETT |pol| |#G62|))
                               (EXIT
                                (PROGN
                                 (LETT |#G63| |dg|)
                                 (LETT |#G64| |dp|)
                                 (LETT |dp| |#G63|)
                                 (LETT |dg| |#G64|))))))
                            (LETT |res|
                                  (|MODFACT;eqfact| |g| (QUOTIENT2 |dg| |n0|)
                                   |pmat1| |xp1| |pmat2| |xp2| |l1| |l2| |k1|
                                   |k2| |rdata| |res| $))
                            (EXIT (LETT |l| (QUOTIENT2 |dp| |n0|))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT (CONS |pol| |res|)))))))) 

(SDEFUN |MODFACT;do_ddfact|
        ((|pol| (|U32Vector|)) (|p| (|Integer|)) (|do_eqfact?| (|Boolean|))
         ($
          (|List|
           (|Record| (|:| |poly| (|U32Vector|))
                     (|:| |degree| (|NonNegativeInteger|))
                     (|:| |separate_factors|
                          (|Mapping| (|List| (|U32Vector|))))))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |poly| (|U32Vector|))
                      (|:| |degree| (|NonNegativeInteger|))
                      (|:| |separate_factors|
                           (|Mapping| (|List| (|U32Vector|)))))))
          (#1=#:G848 NIL) (|dg| (|Integer|)) (|pk| (|U32Vector|))
          (#2=#:G855 NIL) (#3=#:G853 NIL) (#4=#:G854 NIL)
          (|n| #5=(|NonNegativeInteger|)) (|tmp| #6=(|U32Vector|))
          (#7=#:G859 NIL) (|g1| NIL) (|res1| (|List| (|U32Vector|)))
          (|g| (|U32Vector|)) (|i| (|NonNegativeInteger|)) (#8=#:G858 NIL)
          (#9=#:G857 NIL) (|i1| NIL) (|xp2| #10=(|U32Vector|))
          (|pmat2| #11=(|U32Matrix|)) (|#G72| #10#) (|#G71| #11#)
          (|#G70| #12=(|Record| (|:| |matr| #11#) (|:| |poly| #10#)))
          (|pk1| #6#) (|pj| #13=(|U32Vector|)) (|lpj| (|List| #6#))
          (#14=#:G856 NIL) (|k2| (|NonNegativeInteger|))
          (|k1| (|NonNegativeInteger|)) (|n2| (|NonNegativeInteger|))
          (|xp1| #10#) (|pmat1| #11#) (|#G68| #12#)
          (|l1| (|NonNegativeInteger|)) (|l2| (|NonNegativeInteger|))
          (|n0| #5#) (|xp| #13#)
          (|rdata|
           (|List|
            (|Record| (|:| |ind| (|NonNegativeInteger|))
                      (|:| |poly| (|U32Vector|))))))
         (SEQ (LETT |rdata| (SPADCALL |pol| |p| (QREFELT $ 28)))
              (LETT |xp| (SPADCALL (QREFELT $ 29) |p| |rdata| (QREFELT $ 23)))
              (LETT |n| (SPADCALL |pol| (QREFELT $ 14))) (LETT |n0| |n|)
              (LETT |l2|
                    (COND ((< |n| 120) 1) ((< |n| 360) 3)
                          (#15='T (SPADCALL |n| 4 (QREFELT $ 35)))))
              (LETT |l1| (QUOTIENT2 (- (+ |n| |l2|) 1) |l2|))
              (PROGN
               (LETT |#G68| (SPADCALL |xp| |l1| |rdata| (QREFELT $ 25)))
               (LETT |pmat1| (QCAR |#G68|))
               (LETT |xp1| (QCDR |#G68|))
               |#G68|)
              (LETT |tmp| (GETREFV_U32 |n| 0)) (SETELT_U32 |tmp| 1 1)
              (LETT |lpj| (LIST |tmp|)) (LETT |n2| (QUOTIENT2 |n| 2))
              (LETT |k1|
                    (COND ((EQL |l2| 1) |l2|)
                          (#15# (|MODFACT;floor_sqrt| |n2| $))))
              (LETT |k2| (QUOTIENT2 (- (+ |n2| |k1|) 1) |k1|)) (LETT |pj| |xp|)
              (SEQ (LETT |i| 1) (LETT #14# (- |k1| 1)) G190
                   (COND ((|greater_SI| |i| #14#) (GO G191)))
                   (SEQ (LETT |lpj| (CONS |pj| |lpj|))
                        (EXIT
                         (LETT |pj|
                               (SPADCALL |pj| |pmat1| |xp1| |l1| |l2| |rdata|
                                         (QREFELT $ 27)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |pk| |pj|) (LETT |tmp| (GETREFV_U32 (+ |n| 1) 0))
              (SPADCALL |tmp| |pol| (+ |n| 1) (QREFELT $ 21))
              (LETT |pol| |tmp|) (LETT |res| NIL)
              (LETT |pk1| (GETREFV_U32 |n0| 0))
              (COND
               ((> |k1| 1)
                (PROGN
                 (LETT |#G70| (SPADCALL |pj| |l1| |rdata| (QREFELT $ 25)))
                 (LETT |pmat2| (QCAR |#G70|))
                 (LETT |xp2| (QCDR |#G70|))
                 |#G70|))
               (#15#
                (PROGN
                 (LETT |#G71| |pmat1|)
                 (LETT |#G72| |xp1|)
                 (LETT |pmat2| |#G71|)
                 (LETT |xp2| |#G72|))))
              (LETT |i| 0)
              (SEQ
               (EXIT
                (SEQ (LETT |i1| 1) (LETT #9# |k2|) G190
                     (COND ((|greater_SI| |i1| #9#) (GO G191)))
                     (SEQ
                      (SEQ
                       (EXIT
                        (SEQ (LETT #8# |lpj|) G190
                             (COND
                              ((OR (ATOM #8#)
                                   (PROGN (LETT |pj| (CAR #8#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |i| (+ |i| 1))
                                    (SPADCALL |pk1| |pk| |n0| (QREFELT $ 21))
                                    (SPADCALL |pk1| |pj| 0 (- |n0| 1) (- |p| 1)
                                              |p| (QREFELT $ 26))
                                    (LETT |g|
                                          (SPADCALL |pk1| |pol| |p|
                                                    (QREFELT $ 33)))
                                    (SEQ
                                     (LETT |dg| (SPADCALL |g| (QREFELT $ 14)))
                                     (EXIT
                                      (COND
                                       ((> |dg| 0)
                                        (SEQ
                                         (COND
                                          ((EQL |dg| |i|)
                                           (LETT |res|
                                                 (CONS
                                                  (VECTOR |g| |i|
                                                          (CONS
                                                           #'|MODFACT;do_ddfact!0|
                                                           |g|))
                                                  |res|)))
                                          (|do_eqfact?|
                                           (SEQ
                                            (LETT |res1|
                                                  (|MODFACT;eqfact| |g|
                                                   (QUOTIENT2 |dg| |i|) |pmat1|
                                                   |xp1| |pmat2| |xp2| |l1|
                                                   |l2| |k1| |k2| |rdata| NIL
                                                   $))
                                            (EXIT
                                             (SEQ (LETT |g1| NIL)
                                                  (LETT #7# |res1|) G190
                                                  (COND
                                                   ((OR (ATOM #7#)
                                                        (PROGN
                                                         (LETT |g1| (CAR #7#))
                                                         NIL))
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |res|
                                                          (CONS
                                                           (VECTOR |g1| |i|
                                                                   (CONS
                                                                    #'|MODFACT;do_ddfact!1|
                                                                    |g1|))
                                                           |res|))))
                                                  (LETT #7# (CDR #7#))
                                                  (GO G190) G191 (EXIT NIL)))))
                                          ('T
                                           (LETT |res|
                                                 (CONS
                                                  (VECTOR |g| |i|
                                                          (CONS
                                                           #'|MODFACT;do_ddfact!2|
                                                           (VECTOR |rdata| |k2|
                                                                   |k1| |l2|
                                                                   |l1| |xp2|
                                                                   |pmat2|
                                                                   |xp1|
                                                                   |pmat1| $
                                                                   |i| |dg|
                                                                   |g|)))
                                                  |res|))))
                                         (LETT |tmp|
                                               (GETREFV_U32
                                                (+
                                                 (- |n|
                                                    (SPADCALL |g|
                                                              (QREFELT $ 14)))
                                                 1)
                                                0))
                                         (SPADCALL |pol| |g| |tmp| |p|
                                                   (QREFELT $ 32))
                                         (LETT |pol| |tmp|)
                                         (EXIT
                                          (LETT |n|
                                                (SPADCALL |pol|
                                                          (QREFELT $
                                                                   14)))))))))
                                    (EXIT
                                     (COND
                                      ((>= |i| (QUOTIENT2 |n| 2))
                                       (PROGN
                                        (LETT #3#
                                              (PROGN
                                               (LETT #4# 1)
                                               (GO #16=#:G844)))
                                        (GO #17=#:G843)))))))
                              #17# (EXIT #3#))
                             (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL)))
                       #16# (EXIT #4#))
                      (EXIT
                       (COND
                        ((>= |i| (QUOTIENT2 |n| 2))
                         (PROGN (LETT #2# 1) (GO #18=#:G846)))
                        ('T
                         (LETT |pk|
                               (SPADCALL |pk| |pmat2| |xp2| |l1| |l2| |rdata|
                                         (QREFELT $ 27)))))))
                     (LETT |i1| (|inc_SI| |i1|)) (GO G190) G191 (EXIT NIL)))
               #18# (EXIT #2#))
              (SEQ (LETT |dg| (SPADCALL |pol| (QREFELT $ 14)))
                   (EXIT
                    (COND
                     ((> |dg| 0)
                      (LETT |res|
                            (CONS
                             (VECTOR |pol|
                                     (PROG1 (LETT #1# |dg|)
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#))
                                     (CONS #'|MODFACT;do_ddfact!3| |pol|))
                             |res|))))))
              (EXIT |res|)))) 

(SDEFUN |MODFACT;do_ddfact!3| ((|pol| NIL)) (LIST |pol|)) 

(SDEFUN |MODFACT;do_ddfact!2| (($$ NIL))
        (PROG (|g| |dg| |i| $ |pmat1| |xp1| |pmat2| |xp2| |l1| |l2| |k1| |k2|
               |rdata|)
          (LETT |g| (QREFELT $$ 12))
          (LETT |dg| (QREFELT $$ 11))
          (LETT |i| (QREFELT $$ 10))
          (LETT $ (QREFELT $$ 9))
          (LETT |pmat1| (QREFELT $$ 8))
          (LETT |xp1| (QREFELT $$ 7))
          (LETT |pmat2| (QREFELT $$ 6))
          (LETT |xp2| (QREFELT $$ 5))
          (LETT |l1| (QREFELT $$ 4))
          (LETT |l2| (QREFELT $$ 3))
          (LETT |k1| (QREFELT $$ 2))
          (LETT |k2| (QREFELT $$ 1))
          (LETT |rdata| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|MODFACT;eqfact| |g| (SPADCALL |dg| |i| (QREFELT $ 36)) |pmat1|
             |xp1| |pmat2| |xp2| |l1| |l2| |k1| |k2| |rdata| NIL $))))) 

(SDEFUN |MODFACT;do_ddfact!1| ((|g1| NIL)) (LIST |g1|)) 

(SDEFUN |MODFACT;do_ddfact!0| ((|g| NIL)) (LIST |g|)) 

(SDEFUN |MODFACT;ddfact;UvIL;12|
        ((|pol| (|U32Vector|)) (|prime| (|Integer|))
         ($
          (|List|
           (|Record| (|:| |poly| (|U32Vector|))
                     (|:| |degree| (|NonNegativeInteger|))
                     (|:| |separate_factors|
                          (|Mapping| (|List| (|U32Vector|))))))))
        (|MODFACT;do_ddfact| |pol| |prime| NIL $)) 

(SDEFUN |MODFACT;mfactor;UvIL;13|
        ((|pol| (|U32Vector|)) (|prime| (|Integer|))
         ($ (|List| (|U32Vector|))))
        (SPROG
         ((#1=#:G869 NIL) (|el| NIL) (#2=#:G868 NIL)
          (|rl1|
           (|List|
            (|Record| (|:| |poly| (|U32Vector|))
                      (|:| |degree| (|NonNegativeInteger|))
                      (|:| |separate_factors|
                           (|Mapping| (|List| (|U32Vector|))))))))
         (SEQ (LETT |rl1| (|MODFACT;do_ddfact| |pol| |prime| 'T $))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |el| NIL) (LETT #1# |rl1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |el| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT #2# (CONS (QVELT |el| 0) #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(DECLAIM (NOTINLINE |ModularFactorization;|)) 

(DEFUN |ModularFactorization| ()
  (SPROG NIL
         (PROG (#1=#:G871)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ModularFactorization|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ModularFactorization|
                             (LIST
                              (CONS NIL (CONS 1 (|ModularFactorization;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|ModularFactorization|)))))))))) 

(DEFUN |ModularFactorization;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ModularFactorization|))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ModularFactorization| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 29 (GETREFV_U32 2 0))
          (SETELT_U32 (QREFELT $ 29) 1 1)
          $))) 

(MAKEPROP '|ModularFactorization| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Boolean|) (|NonNegativeInteger|)
              (0 . ~=) (|U32Matrix|) (|Integer|) |MODFACT;mmul;2UmIUm;2|
              (|U32Vector|) (|U32VectorPolynomialOperations|) (6 . |degree|)
              (|Void|) (11 . |truncated_mul_add|) (20 . |remainder!|)
              (|Record| (|:| |ind| 7) (|:| |poly| 12)) (|List| 18)
              |MODFACT;red_pol;UvLV;4| (27 . |copy_first|) (34 . |mul|)
              |MODFACT;mod_exp;UvILUv;5|
              (|Record| (|:| |matr| 9) (|:| |poly| 12))
              |MODFACT;power_matrix;UvNniLR;6| (41 . |vector_add_mul|)
              |MODFACT;modular_compose;UvUmUv2NniLUv;7|
              |MODFACT;ini_rdata;UvIL;8| '|x1| (|IntegerRoots| 10)
              (51 . |approxSqrt|) (56 . |divide!|) (64 . |gcd|) (71 . |fill!|)
              (77 . |approxNthRoot|) (83 . |quo|) (|Mapping| 41)
              (|Record| (|:| |poly| 12) (|:| |degree| 7)
                        (|:| |separate_factors| 37))
              (|List| 38) |MODFACT;ddfact;UvIL;12| (|List| 12)
              |MODFACT;mfactor;UvIL;13|)
           '#(|red_pol| 89 |power_matrix| 95 |modular_compose| 102 |mod_exp|
              112 |mmul| 119 |mfactor| 126 |ini_rdata| 132 |ddfact| 138)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|mfactor|
                                 ((|List| (|U32Vector|)) (|U32Vector|)
                                  (|Integer|)))
                                T)
                              '((|ddfact|
                                 ((|List|
                                   (|Record| (|:| |poly| (|U32Vector|))
                                             (|:| |degree|
                                                  (|NonNegativeInteger|))
                                             (|:| |separate_factors|
                                                  (|Mapping|
                                                   (|List| (|U32Vector|))))))
                                  (|U32Vector|) (|Integer|)))
                                T)
                              '((|mmul|
                                 ((|U32Matrix|) (|U32Matrix|) (|U32Matrix|)
                                  (|Integer|)))
                                T)
                              '((|mod_exp|
                                 ((|U32Vector|) (|U32Vector|) (|Integer|)
                                  (|List|
                                   (|Record| (|:| |ind| (|NonNegativeInteger|))
                                             (|:| |poly| (|U32Vector|))))))
                                T)
                              '((|power_matrix|
                                 ((|Record| (|:| |matr| (|U32Matrix|))
                                            (|:| |poly| (|U32Vector|)))
                                  (|U32Vector|) (|NonNegativeInteger|)
                                  (|List|
                                   (|Record| (|:| |ind| (|NonNegativeInteger|))
                                             (|:| |poly| (|U32Vector|))))))
                                T)
                              '((|modular_compose|
                                 ((|U32Vector|) (|U32Vector|) (|U32Matrix|)
                                  (|U32Vector|) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)
                                  (|List|
                                   (|Record| (|:| |ind| (|NonNegativeInteger|))
                                             (|:| |poly| (|U32Vector|))))))
                                T)
                              '((|ini_rdata|
                                 ((|List|
                                   (|Record| (|:| |ind| (|NonNegativeInteger|))
                                             (|:| |poly| (|U32Vector|))))
                                  (|U32Vector|) (|Integer|)))
                                T)
                              '((|red_pol|
                                 ((|Void|) (|U32Vector|)
                                  (|List|
                                   (|Record| (|:| |ind| (|NonNegativeInteger|))
                                             (|:| |poly| (|U32Vector|))))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 42
                                            '(2 7 6 0 0 8 1 13 10 12 14 5 13 15
                                              12 12 12 10 10 16 3 13 15 12 12
                                              10 17 3 13 15 12 12 10 21 3 13 12
                                              12 12 10 22 6 13 15 12 12 10 10
                                              10 10 26 1 30 10 10 31 4 13 15 12
                                              12 12 10 32 3 13 12 12 12 10 33 2
                                              12 0 0 10 34 2 30 10 10 7 35 2 10
                                              0 0 0 36 2 0 15 12 19 20 3 0 24
                                              12 7 19 25 6 0 12 12 9 12 7 7 19
                                              27 3 0 12 12 10 19 23 3 0 9 9 9
                                              10 11 2 0 41 12 10 42 2 0 19 12
                                              10 28 2 0 39 12 10 40)))))
           '|lookupComplete|)) 

(MAKEPROP '|ModularFactorization| 'NILADIC T) 


(PUT '|VSBASIS;Zero;$;1| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |VSBASIS;Zero;$;1| (($ ($))) NIL) 

(PUT '|VSBASIS;coerce;$L;2| '|SPADreplace| '(XLAM (B) B)) 

(SDEFUN |VSBASIS;coerce;$L;2| ((B ($)) ($ (|List| (|Vector| R)))) B) 

(SDEFUN |VSBASIS;coerce;$Of;3| ((B ($)) ($ (|OutputForm|)))
        (SPROG ((|a2| (|OutputForm|)) (|a1| (|OutputForm|)))
               (SEQ (LETT |a1| (SPADCALL "VectorSpace " (QREFELT $ 12)))
                    (LETT |a2| (SPADCALL B (QREFELT $ 13)))
                    (EXIT (SPADCALL |a1| |a2| (QREFELT $ 14)))))) 

(SDEFUN |VSBASIS;column2matrix| ((|Lv| (|List| (|Vector| R))) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G730 NIL) (|k| NIL) (#2=#:G731 NIL) (|v| NIL) (M (|Matrix| R))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVSIZE (SPADCALL |Lv| 1 (QREFELT $ 19))))
              (LETT M (MAKE_MATRIX1 |n| (LENGTH |Lv|) (|spadConstant| $ 20)))
              (SEQ (LETT |v| NIL) (LETT #2# |Lv|) (LETT |k| 1)
                   (LETT #1# (LENGTH |Lv|)) G190
                   (COND
                    ((OR (|greater_SI| |k| #1#) (ATOM #2#)
                         (PROGN (LETT |v| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |n| (QVSIZE |v|) (QREFELT $ 23))
                       (|error|
                        "Length of vectors in VectorSpaceBasis must have the same size"))
                      ('T (SPADCALL M |k| |v| (QREFELT $ 25))))))
                   (LETT |k| (PROG1 (|inc_SI| |k|) (LETT #2# (CDR #2#))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT M)))) 

(SDEFUN |VSBASIS;basis;L$;5| ((|Lv| (|List| (|Vector| R))) ($ ($)))
        (COND ((EQL (LENGTH |Lv|) 0) (|spadConstant| $ 8))
              ('T (SPADCALL (|VSBASIS;column2matrix| |Lv| $) (QREFELT $ 26))))) 

(SDEFUN |VSBASIS;columnSpace;M$;6| ((M (|Matrix| R)) ($ ($)))
        (SPADCALL M (QREFELT $ 26))) 

(SDEFUN |VSBASIS;nullSpace;M$;7| ((M (|Matrix| R)) ($ ($)))
        (SPADCALL M (QREFELT $ 29))) 

(SDEFUN |VSBASIS;sumBasis;2L$;8|
        ((|Lv| (|List| (|Vector| R))) (|Lw| (|List| (|Vector| R))) ($ ($)))
        (SPADCALL (SPADCALL |Lv| |Lw| (QREFELT $ 31)) (QREFELT $ 27))) 

(SDEFUN |VSBASIS;sumBasis;3$;9| ((B1 ($)) (B2 ($)) ($ ($)))
        (SPADCALL (SPADCALL B1 B2 (QREFELT $ 31)) (QREFELT $ 27))) 

(SDEFUN |VSBASIS;sumBasis;L$;10|
        ((|LLv| (|List| (|List| (|Vector| R)))) ($ ($)))
        (SPADCALL (SPADCALL |LLv| (QREFELT $ 35)) (QREFELT $ 27))) 

(SDEFUN |VSBASIS;sumBasis;L$;11| ((LB (|List| $)) ($ ($)))
        (SPADCALL (SPADCALL LB (QREFELT $ 38)) (QREFELT $ 27))) 

(SDEFUN |VSBASIS;+;3$;12| ((B1 ($)) (B2 ($)) ($ ($)))
        (SPADCALL B1 B2 (QREFELT $ 33))) 

(SDEFUN |VSBASIS;subVector|
        ((|v| (|Vector| R)) (|a| (|Integer|)) (|b| (|Integer|))
         ($ (|Vector| R)))
        (SPROG ((#1=#:G746 NIL) (|k| NIL) (|vv| (|Vector| R)) (#2=#:G741 NIL))
               (SEQ
                (LETT |vv|
                      (MAKEARR1
                       (PROG1 (LETT #2# (+ (- |b| |a|) 1))
                         (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #2#))
                       (|spadConstant| $ 20)))
                (SEQ (LETT |k| 1) (LETT #1# (+ (- |b| |a|) 1)) G190
                     (COND ((|greater_SI| |k| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (QSETAREF1O |vv| |k| (QAREF1O |v| (- (+ |k| |a|) 1) 1)
                                   1)))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                (EXIT |vv|)))) 

(SDEFUN |VSBASIS;linearSum|
        ((|t| (|Vector| R)) (|Lv| (|List| (|Vector| R))) ($ (|Vector| R)))
        (SPROG
         ((#1=#:G756 NIL) (|j| NIL) (|t2| (R)) (#2=#:G754 NIL) (|k| NIL)
          (#3=#:G755 NIL) (|v2| NIL) (|vv| (|Vector| R)))
         (SEQ
          (LETT |vv|
                (MAKEARR1 (QVSIZE (SPADCALL |Lv| 1 (QREFELT $ 19)))
                          (|spadConstant| $ 20)))
          (SEQ (LETT |v2| NIL) (LETT #3# |Lv|) (LETT |k| 1)
               (LETT #2# (LENGTH |Lv|)) G190
               (COND
                ((OR (|greater_SI| |k| #2#) (ATOM #3#)
                     (PROGN (LETT |v2| (CAR #3#)) NIL))
                 (GO G191)))
               (SEQ (LETT |t2| (SPADCALL |t| |k| (QREFELT $ 41)))
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# (QVSIZE |vv|)) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |vv| |j|
                                      (SPADCALL
                                       (SPADCALL |vv| |j| (QREFELT $ 41))
                                       (SPADCALL |t2|
                                                 (SPADCALL |v2| |j|
                                                           (QREFELT $ 41))
                                                 (QREFELT $ 42))
                                       (QREFELT $ 43))
                                      (QREFELT $ 44))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
               (LETT |k| (PROG1 (|inc_SI| |k|) (LETT #3# (CDR #3#)))) (GO G190)
               G191 (EXIT NIL))
          (EXIT |vv|)))) 

(SDEFUN |VSBASIS;intBasis0|
        ((|Lv| (|List| (|Vector| R))) (|Lw| (|List| (|Vector| R))) ($ ($)))
        (SPROG
         ((#1=#:G777 NIL) (|cc| NIL) (#2=#:G776 NIL)
          (|LcoeffB1| (|List| (|Vector| R))) (#3=#:G775 NIL) (|kv| NIL)
          (#4=#:G774 NIL) (|lker| (|List| (|Vector| R))) (#5=#:G772 NIL)
          (|k| NIL) (#6=#:G773 NIL) (|v| NIL) (#7=#:G770 NIL) (#8=#:G771 NIL)
          (|w| NIL) (M (|Matrix| R)) (|d2| #9=(|NonNegativeInteger|))
          (|d1| #9#))
         (SEQ
          (COND ((OR (NULL |Lv|) (NULL |Lw|)) (|spadConstant| $ 8))
                ('T
                 (SEQ (LETT |d1| (LENGTH |Lv|)) (LETT |d2| (LENGTH |Lw|))
                      (EXIT
                       (COND
                        ((SPADCALL (QVSIZE (|SPADfirst| |Lv|))
                                   (QVSIZE (|SPADfirst| |Lw|)) (QREFELT $ 23))
                         (|error|
                          "vectors have different lengths in intBasis"))
                        ('T
                         (SEQ
                          (LETT M
                                (MAKE_MATRIX1 (QVSIZE (|SPADfirst| |Lv|))
                                              (+ |d1| |d2|)
                                              (|spadConstant| $ 20)))
                          (SEQ (LETT |w| NIL) (LETT #8# |Lw|) (LETT |k| 1)
                               (LETT #7# |d2|) G190
                               (COND
                                ((OR (|greater_SI| |k| #7#) (ATOM #8#)
                                     (PROGN (LETT |w| (CAR #8#)) NIL))
                                 (GO G191)))
                               (SEQ (EXIT (SPADCALL M |k| |w| (QREFELT $ 25))))
                               (LETT |k|
                                     (PROG1 (|inc_SI| |k|)
                                       (LETT #8# (CDR #8#))))
                               (GO G190) G191 (EXIT NIL))
                          (SEQ (LETT |v| NIL) (LETT #6# |Lv|) (LETT |k| 1)
                               (LETT #5# |d1|) G190
                               (COND
                                ((OR (|greater_SI| |k| #5#) (ATOM #6#)
                                     (PROGN (LETT |v| (CAR #6#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (SPADCALL M (+ |d2| |k|) |v| (QREFELT $ 25))))
                               (LETT |k|
                                     (PROG1 (|inc_SI| |k|)
                                       (LETT #6# (CDR #6#))))
                               (GO G190) G191 (EXIT NIL))
                          (LETT |lker| (SPADCALL M (QREFELT $ 29)))
                          (LETT |LcoeffB1|
                                (PROGN
                                 (LETT #4# NIL)
                                 (SEQ (LETT |kv| NIL) (LETT #3# |lker|) G190
                                      (COND
                                       ((OR (ATOM #3#)
                                            (PROGN (LETT |kv| (CAR #3#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #4#
                                              (CONS
                                               (|VSBASIS;subVector| |kv|
                                                (+ |d2| 1) (+ |d2| |d1|) $)
                                               #4#))))
                                      (LETT #3# (CDR #3#)) (GO G190) G191
                                      (EXIT (NREVERSE #4#)))))
                          (EXIT
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |cc| NIL) (LETT #1# |LcoeffB1|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |cc| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS
                                          (|VSBASIS;linearSum| |cc| |Lv| $)
                                          #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))))))))))))) 

(SDEFUN |VSBASIS;intBasis;2L$;16|
        ((|Lv| (|List| (|Vector| R))) (|Lw| (|List| (|Vector| R))) ($ ($)))
        (|VSBASIS;intBasis0| |Lv| |Lw| $)) 

(SDEFUN |VSBASIS;intBasis;3$;17| ((B1 ($)) (B2 ($)) ($ ($)))
        (SPROG ((|Lw| (|Rep|)) (|Lv| (|Rep|)))
               (SEQ (LETT |Lv| B1) (LETT |Lw| B2)
                    (EXIT (|VSBASIS;intBasis0| |Lv| |Lw| $))))) 

(SDEFUN |VSBASIS;intBasis;L$;18| ((LLB (|List| (|List| (|Vector| R)))) ($ ($)))
        (SPROG ((|res| ($)) (#1=#:G786 NIL) (LB NIL))
               (SEQ
                (COND
                 ((EQL (LENGTH LLB) 0)
                  (|error| "intersect no subspace is impossible"))
                 ('T
                  (SEQ
                   (LETT |res|
                         (SPADCALL (SPADCALL LLB 1 (QREFELT $ 47))
                                   (QREFELT $ 27)))
                   (SEQ (LETT LB NIL) (LETT #1# (CDR LLB)) G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT LB (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT |res|
                                (SPADCALL |res| (SPADCALL LB (QREFELT $ 27))
                                          (QREFELT $ 46)))))
                        (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                   (EXIT |res|))))))) 

(SDEFUN |VSBASIS;intBasis;L$;19| ((LLB (|List| $)) ($ ($)))
        (SPROG ((|res| ($)) (#1=#:G794 NIL) (LB NIL))
               (SEQ
                (COND
                 ((EQL (SPADCALL LLB (QREFELT $ 50)) 0)
                  (|error| "intersect no subspace is impossible"))
                 ('T
                  (SEQ (LETT |res| (SPADCALL LLB 1 (QREFELT $ 51)))
                       (SEQ (LETT LB NIL)
                            (LETT #1# (SPADCALL LLB (QREFELT $ 52))) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT LB (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |res| (SPADCALL |res| LB (QREFELT $ 46)))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                       (EXIT |res|))))))) 

(SDEFUN |VSBASIS;*;3$;20| ((B1 ($)) (B2 ($)) ($ ($)))
        (SPADCALL B1 B2 (QREFELT $ 46))) 

(PUT '|VSBASIS;rank;$Nni;21| '|SPADreplace| 'LENGTH) 

(SDEFUN |VSBASIS;rank;$Nni;21| ((B ($)) ($ (|NonNegativeInteger|))) (LENGTH B)) 

(SDEFUN |VSBASIS;rank;LNni;22|
        ((|Lv| (|List| (|Vector| R))) ($ (|NonNegativeInteger|)))
        (SPADCALL (SPADCALL |Lv| (QREFELT $ 27)) (QREFELT $ 55))) 

(SDEFUN |VSBASIS;isBasis?;LB;23| ((|Lv| (|List| (|Vector| R))) ($ (|Boolean|)))
        (EQL (SPADCALL |Lv| (QREFELT $ 55)) (LENGTH |Lv|))) 

(SDEFUN |VSBASIS;subspace?;2$B;24| ((B1 ($)) (B2 ($)) ($ (|Boolean|)))
        (EQL (SPADCALL B2 (QREFELT $ 55))
             (SPADCALL (SPADCALL B1 B2 (QREFELT $ 33)) (QREFELT $ 55)))) 

(SDEFUN |VSBASIS;=;2$B;25| ((B1 ($)) (B2 ($)) ($ (|Boolean|)))
        (SPROG
         ((|rks| #1=(|NonNegativeInteger|)) (#2=#:G803 NIL) (|rk2| #1#)
          (|rk1| #1#))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |rk1| (SPADCALL B1 (QREFELT $ 55)))
                       (LETT |rk2| (SPADCALL B2 (QREFELT $ 55)))
                       (QREFELT $ 23))
             (PROGN (LETT #2# NIL) (GO #3=#:G802)))
            (#4='T
             (SEQ
              (LETT |rks|
                    (SPADCALL (SPADCALL B1 B2 (QREFELT $ 33)) (QREFELT $ 55)))
              (EXIT (COND ((EQL |rks| |rk1|) (EQL |rks| |rk2|)) (#4# NIL)))))))
          #3# (EXIT #2#)))) 

(SDEFUN |VSBASIS;canonicalBasis;Nni$;26| ((|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((L (|List| (|Vector| R))) (|v| (|Vector| R)) (#1=#:G809 NIL)
          (|k| NIL))
         (SEQ (LETT L NIL)
              (SEQ (LETT |k| 1) (LETT #1# |n|) G190
                   (COND ((|greater_SI| |k| #1#) (GO G191)))
                   (SEQ (LETT |v| (MAKEARR1 |n| (|spadConstant| $ 20)))
                        (SPADCALL |v| (- (+ |n| 1) |k|) (|spadConstant| $ 16)
                                  (QREFELT $ 44))
                        (EXIT (LETT L (CONS |v| L))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT L)))) 

(SDEFUN |VSBASIS;complementSpace;L$;27| ((|Lv| (|List| (|Vector| R))) ($ ($)))
        (SPROG
         ((|ind| (|NonNegativeInteger|)) (RES ($)) (#1=#:G821 NIL) (|k| NIL)
          (#2=#:G822 NIL) (|v| NIL) (#3=#:G819 NIL) (#4=#:G820 NIL)
          (|n| (|NonNegativeInteger|)) (M (|Matrix| R))
          (|Lw| (|List| (|Vector| R))) (|bc| (|List| (|Vector| R)))
          (|dim| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL |Lv| NIL (QREFELT $ 59))
            (|error|
             "Can't get vector length of an empty family for complementSpace"))
           ('T
            (SEQ (LETT |dim| (QVSIZE (SPADCALL |Lv| 1 (QREFELT $ 19))))
                 (LETT |bc|
                       (SPADCALL (SPADCALL |dim| (QREFELT $ 60))
                                 (QREFELT $ 9)))
                 (LETT |Lw| (SPADCALL |Lv| |bc| (QREFELT $ 31)))
                 (LETT M
                       (SPADCALL (|VSBASIS;column2matrix| |Lw| $)
                                 (QREFELT $ 61)))
                 (LETT |n| (LENGTH |Lv|)) (LETT |ind| 1)
                 (SEQ (LETT |v| NIL) (LETT #4# |Lw|) (LETT |k| 1)
                      (LETT #3# |n|) G190
                      (COND
                       ((OR (|greater_SI| |k| #3#) (ATOM #4#)
                            (PROGN (LETT |v| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((<= |ind| |dim|)
                          (COND
                           ((SPADCALL (SPADCALL M |ind| |k| (QREFELT $ 62))
                                      (|spadConstant| $ 20) (QREFELT $ 63))
                            (LETT |ind| (+ |ind| 1))))))))
                      (LETT |k| (PROG1 (|inc_SI| |k|) (LETT #4# (CDR #4#))))
                      (GO G190) G191 (EXIT NIL))
                 (LETT RES NIL)
                 (SEQ (LETT |v| NIL) (LETT #2# |bc|) (LETT |k| (+ |n| 1))
                      (LETT #1# (+ |n| |dim|)) G190
                      (COND
                       ((OR (> |k| #1#) (ATOM #2#)
                            (PROGN (LETT |v| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((<= |ind| |dim|)
                          (COND
                           ((SPADCALL (SPADCALL M |ind| |k| (QREFELT $ 62))
                                      (|spadConstant| $ 20) (QREFELT $ 63))
                            (SEQ (LETT RES (CONS |v| RES))
                                 (EXIT (LETT |ind| (+ |ind| 1))))))))))
                      (LETT |k| (PROG1 (+ |k| 1) (LETT #2# (CDR #2#))))
                      (GO G190) G191 (EXIT NIL))
                 (EXIT (NREVERSE RES)))))))) 

(SDEFUN |VSBASIS;complementSpace;LNni$;28|
        ((|Lv| (|List| (|Vector| R))) (|n| (|NonNegativeInteger|)) ($ ($)))
        (COND
         ((SPADCALL |Lv| NIL (QREFELT $ 59)) (SPADCALL |n| (QREFELT $ 60)))
         ((SPADCALL |n| (QVSIZE (SPADCALL |Lv| 1 (QREFELT $ 19)))
                    (QREFELT $ 23))
          (|error| "Inconsistant vector length in complementSpace"))
         ('T (SPADCALL |Lv| (QREFELT $ 65))))) 

(SDEFUN |VSBASIS;complementSpace;2$;29| ((B ($)) ($ ($)))
        (SPROG
         ((|ind| (|NonNegativeInteger|)) (RES ($)) (#1=#:G831 NIL) (|k| NIL)
          (#2=#:G832 NIL) (|v| NIL) (|n| (|NonNegativeInteger|))
          (M (|Matrix| R)) (|Lw| (|List| (|Vector| R)))
          (|bc| (|List| (|Vector| R))) (|dim| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL B (|spadConstant| $ 8) (QREFELT $ 59))
            (|error|
             "Can't get vector length of an empty basis for complement Space"))
           ('T
            (SEQ (LETT |dim| (QVSIZE (SPADCALL B 1 (QREFELT $ 19))))
                 (LETT |bc|
                       (SPADCALL (SPADCALL |dim| (QREFELT $ 60))
                                 (QREFELT $ 9)))
                 (LETT |Lw|
                       (SPADCALL (SPADCALL B (QREFELT $ 9)) |bc|
                                 (QREFELT $ 31)))
                 (LETT M
                       (SPADCALL (|VSBASIS;column2matrix| |Lw| $)
                                 (QREFELT $ 61)))
                 (LETT |n| (LENGTH B)) (LETT |ind| (+ |n| 1)) (LETT RES NIL)
                 (SEQ (LETT |v| NIL) (LETT #2# |bc|) (LETT |k| (+ |n| 1))
                      (LETT #1# (+ |n| |dim|)) G190
                      (COND
                       ((OR (> |k| #1#) (ATOM #2#)
                            (PROGN (LETT |v| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((<= |ind| |dim|)
                          (COND
                           ((SPADCALL (SPADCALL M |ind| |k| (QREFELT $ 62))
                                      (|spadConstant| $ 20) (QREFELT $ 63))
                            (SEQ (LETT RES (CONS |v| RES))
                                 (EXIT (LETT |ind| (+ |ind| 1))))))))))
                      (LETT |k| (PROG1 (+ |k| 1) (LETT #2# (CDR #2#))))
                      (GO G190) G191 (EXIT NIL))
                 (EXIT (NREVERSE RES)))))))) 

(SDEFUN |VSBASIS;complementSpace;$Nni$;30|
        ((B ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (COND ((SPADCALL B NIL (QREFELT $ 59)) (SPADCALL |n| (QREFELT $ 60)))
              ((SPADCALL |n| (QVSIZE (SPADCALL B 1 (QREFELT $ 19)))
                         (QREFELT $ 23))
               (|error| "Inconsistant vector length in complementSpace"))
              ('T (SPADCALL B (QREFELT $ 65))))) 

(SDEFUN |VSBASIS;member?;V$B;31| ((|v| (|Vector| R)) (B ($)) ($ (|Boolean|)))
        (SPADCALL (|VSBASIS;column2matrix| B $) |v| (QREFELT $ 69))) 

(SDEFUN |VSBASIS;coordinatesIfCan;V$U;32|
        ((|v| (|Vector| R)) (B ($)) ($ (|Union| (|Vector| R) "failed")))
        (SPADCALL (|VSBASIS;column2matrix| B $) |v| (QREFELT $ 72))) 

(SDEFUN |VSBASIS;coordinates;V$V;33|
        ((V (|Vector| R)) (B ($)) ($ (|Vector| R)))
        (SPROG ((|res| (|Union| (|Vector| R) "failed")))
               (SEQ
                (LETT |res|
                      (SPADCALL (|VSBASIS;column2matrix| B $) V
                                (QREFELT $ 72)))
                (EXIT
                 (COND
                  ((QEQCAR |res| 1) (|error| "Vector not in the subspace"))
                  ('T (QCDR |res|))))))) 

(DECLAIM (NOTINLINE |VectorSpaceBasis;|)) 

(DEFUN |VectorSpaceBasis| (#1=#:G847)
  (SPROG NIL
         (PROG (#2=#:G848)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|VectorSpaceBasis|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|VectorSpaceBasis;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|VectorSpaceBasis|)))))))))) 

(DEFUN |VectorSpaceBasis;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|VectorSpaceBasis| DV$1))
          (LETT $ (GETREFV 75))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|VectorSpaceBasis| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|List| (|Vector| |#1|)))
          $))) 

(MAKEPROP '|VectorSpaceBasis| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|List| 17) (|local| |#1|) '|Rep|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |VSBASIS;Zero;$;1|) $))
              |VSBASIS;coerce;$L;2| (|String|) (|OutputForm|) (0 . |message|)
              (5 . |coerce|) (10 . |hconcat|) |VSBASIS;coerce;$Of;3|
              (16 . |One|) (|Vector| 6) (|Integer|) (20 . |elt|) (26 . |Zero|)
              (|Boolean|) (|NonNegativeInteger|) (30 . ~=) (|Matrix| 6)
              (36 . |setColumn!|) (43 . |columnSpace|) |VSBASIS;basis;L$;5|
              |VSBASIS;columnSpace;M$;6| (48 . |nullSpace|)
              |VSBASIS;nullSpace;M$;7| (53 . |concat|) |VSBASIS;sumBasis;2L$;8|
              |VSBASIS;sumBasis;3$;9| (|List| $) (59 . |concat|) (|List| 5)
              |VSBASIS;sumBasis;L$;10| (64 . |concat|) |VSBASIS;sumBasis;L$;11|
              |VSBASIS;+;3$;12| (69 . |elt|) (75 . *) (81 . +) (87 . |setelt!|)
              |VSBASIS;intBasis;2L$;16| |VSBASIS;intBasis;3$;17| (94 . |elt|)
              |VSBASIS;intBasis;L$;18| (|List| $$) (100 . |#|) (105 . |elt|)
              (111 . |rest|) |VSBASIS;intBasis;L$;19| |VSBASIS;*;3$;20|
              |VSBASIS;rank;$Nni;21| |VSBASIS;rank;LNni;22|
              |VSBASIS;isBasis?;LB;23| |VSBASIS;subspace?;2$B;24|
              |VSBASIS;=;2$B;25| |VSBASIS;canonicalBasis;Nni$;26|
              (116 . |rowEchelon|) (121 . |elt|) (128 . ~=)
              |VSBASIS;complementSpace;L$;27| |VSBASIS;complementSpace;2$;29|
              |VSBASIS;complementSpace;LNni$;28|
              |VSBASIS;complementSpace;$Nni$;30|
              (|LinearSystemMatrixPackage1| 6) (134 . |hasSolution?|)
              |VSBASIS;member?;V$B;31| (|Union| 17 '"failed")
              (140 . |particularSolution|) |VSBASIS;coordinatesIfCan;V$U;32|
              |VSBASIS;coordinates;V$V;33|)
           '#(~= 146 |sumBasis| 152 |subspace?| 174 |rank| 180 |nullSpace| 190
              |member?| 195 |isBasis?| 201 |intBasis| 206 |coordinatesIfCan|
              228 |coordinates| 234 |complementSpace| 240 |columnSpace| 262
              |coerce| 267 |canonicalBasis| 277 |basis| 282 |Zero| 287 = 291 +
              297 * 303)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0))
                 (CONS '#(|BasicType&| NIL)
                       (CONS '#((|BasicType|) (|CoercibleTo| 11))
                             (|makeByteWordVec2| 74
                                                 '(1 11 0 10 12 1 5 11 0 13 2
                                                   11 0 0 0 14 0 6 0 16 2 7 17
                                                   0 18 19 0 6 0 20 2 22 21 0 0
                                                   23 3 24 0 0 18 17 25 1 24 5
                                                   0 26 1 24 5 0 29 2 5 0 0 0
                                                   31 1 5 0 34 35 1 7 0 34 38 2
                                                   17 6 0 18 41 2 6 0 0 0 42 2
                                                   6 0 0 0 43 3 17 6 0 18 6 44
                                                   2 36 5 0 18 47 1 49 22 0 50
                                                   2 49 2 0 18 51 1 49 0 0 52 1
                                                   24 0 0 61 3 24 6 0 18 18 62
                                                   2 6 21 0 0 63 2 68 21 24 17
                                                   69 2 68 71 24 17 72 2 0 21 0
                                                   0 1 1 0 0 36 37 2 0 0 5 5 32
                                                   1 0 0 34 39 2 0 0 0 0 33 2 0
                                                   21 0 0 58 1 0 22 5 56 1 0 22
                                                   0 55 1 0 0 24 30 2 0 21 17 0
                                                   70 1 0 21 5 57 1 0 0 36 48 1
                                                   0 0 34 53 2 0 0 5 5 45 2 0 0
                                                   0 0 46 2 0 71 17 0 73 2 0 17
                                                   17 0 74 1 0 0 5 64 2 0 0 5
                                                   22 66 1 0 0 0 65 2 0 0 0 22
                                                   67 1 0 0 24 28 1 0 5 0 9 1 0
                                                   11 0 15 1 0 0 22 60 1 0 0 5
                                                   27 0 0 0 8 2 0 21 0 0 59 2 0
                                                   0 0 0 40 2 0 0 0 0 54)))))
           '|lookupComplete|)) 

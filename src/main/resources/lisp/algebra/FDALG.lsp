
(SDEFUN |FDALG;characteristic;Nni;1| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 10))) 

(SDEFUN |FDALG;qeltA|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) ($ (F)))
        (SPADCALL |p| (+ 1 |i|) (+ 1 |j|) |l| (QREFELT $ 13))) 

(SDEFUN |FDALG;qeltv|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|)) ($ (F)))
        (SPADCALL |p| (+ 1 |i|) 1 |l| (QREFELT $ 13))) 

(SDEFUN |FDALG;qeltu|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|j| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|)) ($ (F)))
        (SPADCALL |p| 1 (+ 1 |j|) |l| (QREFELT $ 13))) 

(SDEFUN |FDALG;qlstA|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ (|List| F)))
        (SPADCALL |p| (+ 1 |i|) (+ 1 |j|) (QREFELT $ 17))) 

(SDEFUN |FDALG;qsetu!|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|))
         (|alpha| (F)) ($ (F)))
        (SPADCALL |p| 1 (+ 1 |i|) |l| |alpha| (QREFELT $ 18))) 

(SDEFUN |FDALG;qsetA!|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) (|alpha| (F)) ($ (F)))
        (SPADCALL |p| (+ 1 |i|) (+ 1 |j|) |l| |alpha| (QREFELT $ 18))) 

(SDEFUN |FDALG;qsetv!|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|))
         (|alpha| (F)) ($ (F)))
        (SPADCALL |p| (+ 1 |i|) 1 |l| |alpha| (QREFELT $ 18))) 

(SDEFUN |FDALG;qmtxu|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|j1| (|NonNegativeInteger|)) (|j2| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) ($ (|Matrix| F)))
        (SPADCALL |p| 1 1 (+ 1 |j1|) (+ 1 |j2|) |l| (QREFELT $ 20))) 

(SDEFUN |FDALG;qmtxA|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i1| (|NonNegativeInteger|)) (|i2| (|NonNegativeInteger|))
         (|j1| (|NonNegativeInteger|)) (|j2| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) ($ (|Matrix| F)))
        (SPADCALL |p| (+ 1 |i1|) (+ 1 |i2|) (+ 1 |j1|) (+ 1 |j2|) |l|
                  (QREFELT $ 20))) 

(SDEFUN |FDALG;qmtxv|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i1| (|NonNegativeInteger|)) (|i2| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) ($ (|Matrix| F)))
        (SPADCALL |p| (+ 1 |i1|) (+ 1 |i2|) 1 1 |l| (QREFELT $ 20))) 

(SDEFUN |FDALG;qscalev!|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i1| (|NonNegativeInteger|)) (|i2| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) (|alpha| (F))
         ($ (|LinearMultivariateMatrixPencil| F)))
        (SPADCALL |p| (+ 1 |i1|) (+ 1 |i2|) 1 1 |l| |alpha| (QREFELT $ 21))) 

(SDEFUN |FDALG;qscale!| ((|f| ($)) (|alpha| (F)) ($ ($)))
        (SEQ
         (SPADCALL (QVELT |f| 2) (+ 1 1) (+ 1 (QVELT |f| 0)) 1 1 1 |alpha|
                   (QREFELT $ 21))
         (EXIT |f|))) 

(SDEFUN |FDALG;qsetmtxu!|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|j| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|))
         (|a| (|Matrix| F)) ($ (|Matrix| F)))
        (SPADCALL |p| 1 (+ 1 |j|) |l| |a| (QREFELT $ 22))) 

(SDEFUN |FDALG;qsetmtxA!|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) (|a| (|Matrix| F)) ($ (|Matrix| F)))
        (SPADCALL |p| (+ 1 |i|) (+ 1 |j|) |l| |a| (QREFELT $ 22))) 

(SDEFUN |FDALG;qsetmtxv!|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|))
         (|a| (|Matrix| F)) ($ (|Matrix| F)))
        (SPADCALL |p| (+ 1 |i|) 1 |l| |a| (QREFELT $ 22))) 

(SDEFUN |FDALG;qzeroA?|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPADCALL |p| (+ 1 |i|) (+ 1 |j|) (QREFELT $ 24))) 

(SDEFUN |FDALG;qzeromtxA?|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i1| (|NonNegativeInteger|)) (|i2| (|NonNegativeInteger|))
         (|j1| (|NonNegativeInteger|)) (|j2| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPADCALL |p| (+ 1 |i1|) (+ 1 |i2|) (+ 1 |j1|) (+ 1 |j2|)
                  (QREFELT $ 25))) 

(SDEFUN |FDALG;qsemizeroA?|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i1| (|NonNegativeInteger|)) (|i2| (|NonNegativeInteger|))
         (|j1| (|NonNegativeInteger|)) (|j2| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPADCALL |p| (+ 1 |i1|) (+ 1 |i2|) (+ 1 |j1|) (+ 1 |j2|) |l|
                  (QREFELT $ 26))) 

(SDEFUN |FDALG;qzerov?|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|i1| (|NonNegativeInteger|)) (|i2| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPADCALL |p| (+ 1 |i1|) (+ 1 |i2|) 1 1 (QREFELT $ 25))) 

(SDEFUN |FDALG;interval;2NniL;21|
        ((|i_min| (|NonNegativeInteger|)) (|i_max| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|lst_wrk| (|List| (|NonNegativeInteger|))) (#1=#:G968 NIL)
          (|k| NIL))
         (SEQ (LETT |lst_wrk| NIL)
              (SEQ (LETT |k| |i_max|) (LETT #1# |i_min|) G190
                   (COND ((< |k| #1#) (GO G191)))
                   (SEQ (EXIT (LETT |lst_wrk| (CONS |k| |lst_wrk|))))
                   (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
              (EXIT |lst_wrk|)))) 

(SDEFUN |FDALG;qnew;Nni$;22| ((|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|flg_ref| #1=(|Boolean|)) (|flg_min| #1#)
          (|lp| (|LinearMultivariateMatrixPencil| F))
          (|lst_new| (|List| (|FreeMonoid| VAR))))
         (SEQ (LETT |lst_new| (LIST (|spadConstant| $ 30)))
              (LETT |lp|
                    (SPADCALL (+ |n| 1) (+ |n| 1) (LENGTH |lst_new|)
                              (QREFELT $ 31)))
              (SPADCALL |lp| 1 2 1 (|spadConstant| $ 15) (QREFELT $ 18))
              (LETT |flg_min| NIL) (LETT |flg_ref| NIL)
              (EXIT (VECTOR |n| |lst_new| |lp| |flg_min| |flg_ref| 'T 'T 'T))))) 

(SDEFUN |FDALG;qnew;NniL$;23|
        ((|n| (|NonNegativeInteger|)) (|lst| (|List| (|FreeMonoid| VAR)))
         ($ ($)))
        (SPROG
         ((|flg_ref| #1=(|Boolean|)) (|flg_min| #1#)
          (|lp| (|LinearMultivariateMatrixPencil| F))
          (|lst_new| (|List| (|FreeMonoid| VAR))))
         (SEQ
          (LETT |lst_new|
                (CONS (|spadConstant| $ 30)
                      (SPADCALL (|spadConstant| $ 30) |lst| (QREFELT $ 34))))
          (LETT |lp|
                (SPADCALL (+ |n| 1) (+ |n| 1) (LENGTH |lst_new|)
                          (QREFELT $ 31)))
          (SPADCALL |lp| 1 2 1 (|spadConstant| $ 15) (QREFELT $ 18))
          (LETT |flg_min| NIL) (LETT |flg_ref| NIL)
          (EXIT (VECTOR |n| |lst_new| |lp| |flg_min| |flg_ref| 'T 'T 'T))))) 

(SDEFUN |FDALG;new;LmmpL$;24|
        ((|lp| (|LinearMultivariateMatrixPencil| F))
         (|lst| (|List| (|FreeMonoid| VAR))) ($ ($)))
        (SPROG
         ((|flg_ref| #1=(|Boolean|)) (|flg_min| #1#)
          (|n| (|NonNegativeInteger|)) (#2=#:G977 NIL) (#3=#:G982 NIL)
          (#4=#:G983 NIL) (|mon| NIL))
         (SEQ
          (SEQ
           (EXIT
            (SEQ (LETT |mon| NIL) (LETT #4# |lst|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |mon| (CAR #4#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((> (SPADCALL |mon| (QREFELT $ 36)) 1)
                     (PROGN
                      (LETT #3#
                            (|error|
                             "FDALG: new(lp, lst) - monomials not linear."))
                      (GO #5=#:G975))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL)))
           #5# (EXIT #3#))
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |lp| (QREFELT $ 37))
                       (SPADCALL |lp| (QREFELT $ 38)) (QREFELT $ 39))
             (|error| "FDALG: new(lp,lst) - Linear Pencil is not square."))
            ((SPADCALL (LENGTH |lst|) (SPADCALL |lp| (QREFELT $ 40))
                       (QREFELT $ 39))
             (|error| "FDALG: new(lp,lst) - lengths do not agree."))
            ('T
             (SEQ
              (LETT |n|
                    (PROG1 (LETT #2# (- (SPADCALL |lp| (QREFELT $ 37)) 1))
                      (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #2#)))
              (LETT |flg_min| NIL) (LETT |flg_ref| NIL)
              (EXIT (VECTOR |n| |lst| |lp| |flg_min| |flg_ref| 'T 'T 'T))))))))) 

(SDEFUN |FDALG;getSupport|
        ((|var| (|List| VAR)) ($ (|List| (|FreeMonoid| VAR))))
        (SPROG
         ((#1=#:G997 NIL) (|k| NIL) (|lst_mon| (|List| (|FreeMonoid| VAR))))
         (SEQ
          (LETT |lst_mon|
                (SPADCALL (+ 1 (LENGTH |var|)) (|spadConstant| $ 30)
                          (QREFELT $ 42)))
          (SEQ (LETT |k| 1) (LETT #1# (LENGTH |var|)) G190
               (COND ((|greater_SI| |k| #1#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |lst_mon| (+ |k| 1)
                           (SPADCALL (SPADCALL |var| |k| (QREFELT $ 45))
                                     (QREFELT $ 46))
                           (QREFELT $ 47))))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (EXIT |lst_mon|)))) 

(SDEFUN |FDALG;new;F$;26| ((|c| (F)) ($ ($)))
        (SPROG ((|als| ($)) (#1=#:G1001 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |c| (QREFELT $ 48))
                    (PROGN
                     (LETT #1# (SPADCALL (|spadConstant| $ 49) (QREFELT $ 51)))
                     (GO #2=#:G1000))))
                  (LETT |als| (SPADCALL 1 (QREFELT $ 32)))
                  (|FDALG;qsetA!| (QVELT |als| 2) 1 1 1 (|spadConstant| $ 15)
                   $)
                  (|FDALG;qsetv!| (QVELT |als| 2) 1 1 |c| $)
                  (QSETVELT |als| 3 'T) (QSETVELT |als| 4 'T) (EXIT |als|)))
                #2# (EXIT #1#)))) 

(SDEFUN |FDALG;new;FmF$;27| ((|m| (|FreeMonoid| VAR)) (|c| (F)) ($ ($)))
        (SPROG
         ((#1=#:G1022 NIL) (|k| NIL) (|l| (|NonNegativeInteger|))
          (#2=#:G1021 NIL) (|i| NIL) (|pos| (|NonNegativeInteger|))
          (#3=#:G1008 NIL) (#4=#:G1020 NIL) (|fct| NIL) (|als| ($))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL |c| (QREFELT $ 48))
            (SEQ (LETT |als| (SPADCALL 1 (QREFELT $ 32)))
                 (EXIT
                  (|FDALG;qsetA!| (QVELT |als| 2) 1 1 1 (|spadConstant| $ 15)
                   $))))
           ('T
            (SEQ (LETT |n| (+ (SPADCALL |m| (QREFELT $ 36)) 1))
                 (LETT |als|
                       (SPADCALL |n|
                                 (|FDALG;getSupport|
                                  (SPADCALL |m| (QREFELT $ 53)) $)
                                 (QREFELT $ 35)))
                 (LETT |l| 0)
                 (SEQ (LETT |fct| NIL) (LETT #4# (SPADCALL |m| (QREFELT $ 56)))
                      G190
                      (COND
                       ((OR (ATOM #4#) (PROGN (LETT |fct| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ
                       (LETT |pos|
                             (PROG1
                                 (LETT #3#
                                       (SPADCALL
                                        (SPADCALL (QCAR |fct|) (QREFELT $ 46))
                                        (QVELT |als| 1) (QREFELT $ 57)))
                               (|check_subtype2| (>= #3# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #3#)))
                       (EXIT
                        (SEQ (LETT |i| 1) (LETT #2# (QCDR |fct|)) G190
                             (COND ((|greater_SI| |i| #2#) (GO G191)))
                             (SEQ
                              (|FDALG;qsetA!| (QVELT |als| 2) (+ 1 |l|)
                               (+ (+ 1 |l|) 1) |pos|
                               (SPADCALL (|spadConstant| $ 15) (QREFELT $ 58))
                               $)
                              (EXIT (LETT |l| (+ |l| 1))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))))
                      (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                 (SEQ (LETT |k| 1) (LETT #1# |n|) G190
                      (COND ((|greater_SI| |k| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (|FDALG;qsetA!| (QVELT |als| 2) |k| |k| 1
                         (|spadConstant| $ 15) $)))
                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                 (EXIT (|FDALG;qsetv!| (QVELT |als| 2) |n| 1 |c| $)))))
          (QSETVELT |als| 3 'T) (QSETVELT |als| 4 'T) (EXIT |als|)))) 

(SDEFUN |FDALG;Zero;$;28| (($ ($)))
        (SPROG ((|als| ($)))
               (SEQ (LETT |als| (SPADCALL 1 (QREFELT $ 32)))
                    (|FDALG;qsetA!| (QVELT |als| 2) 1 1 1 (|spadConstant| $ 15)
                     $)
                    (QSETVELT |als| 3 'T) (QSETVELT |als| 4 'T)
                    (QSETVELT |als| 5 NIL) (QSETVELT |als| 6 NIL)
                    (QSETVELT |als| 7 NIL) (EXIT |als|)))) 

(SDEFUN |FDALG;One;$;29| (($ ($)))
        (SPROG ((|als| ($)))
               (SEQ (LETT |als| (SPADCALL 1 (QREFELT $ 32)))
                    (|FDALG;qsetA!| (QVELT |als| 2) 1 1 1 (|spadConstant| $ 15)
                     $)
                    (|FDALG;qsetv!| (QVELT |als| 2) 1 1 (|spadConstant| $ 15)
                     $)
                    (QSETVELT |als| 3 'T) (QSETVELT |als| 4 'T)
                    (QSETVELT |als| 5 NIL) (QSETVELT |als| 6 NIL)
                    (QSETVELT |als| 7 NIL) (EXIT |als|)))) 

(SDEFUN |FDALG;copy;2$;30| ((|f| ($)) ($ ($)))
        (SPROG
         ((|supp_new| (|List| (|FreeMonoid| VAR)))
          (|lmmp_new| (|LinearMultivariateMatrixPencil| F)))
         (SEQ (LETT |lmmp_new| (SPADCALL (QVELT |f| 2) (QREFELT $ 60)))
              (LETT |supp_new| (SPADCALL (QVELT |f| 1) (QREFELT $ 61)))
              (EXIT
               (VECTOR (QVELT |f| 0) |supp_new| |lmmp_new| (QVELT |f| 3)
                       (QVELT |f| 4) 'T (QVELT |f| 6) (QVELT |f| 7)))))) 

(SDEFUN |FDALG;copy;$F$;31| ((|f| ($)) (|alpha| (F)) ($ ($)))
        (SPROG
         ((|supp_new| (|List| (|FreeMonoid| VAR)))
          (|lmmp_new| (|LinearMultivariateMatrixPencil| F)) (#1=#:G1034 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |alpha| (QREFELT $ 48))
              (PROGN
               (LETT #1# (SPADCALL (|spadConstant| $ 49) (QREFELT $ 51)))
               (GO #2=#:G1033))))
            (LETT |lmmp_new| (SPADCALL (QVELT |f| 2) (QREFELT $ 60)))
            (LETT |supp_new| (SPADCALL (QVELT |f| 1) (QREFELT $ 61)))
            (|FDALG;qscalev!| |lmmp_new| 1 (QVELT |f| 0) 1 |alpha| $)
            (EXIT
             (VECTOR (QVELT |f| 0) |supp_new| |lmmp_new| (QVELT |f| 3)
                     (QVELT |f| 4) 'T (QVELT |f| 6) (QVELT |f| 7)))))
          #2# (EXIT #1#)))) 

(SDEFUN |FDALG;coerce;Fm$;32| ((|m| (|FreeMonoid| VAR)) ($ ($)))
        (SPADCALL |m| (|spadConstant| $ 15) (QREFELT $ 59))) 

(SDEFUN |FDALG;coerce;F$;33| ((|c| (F)) ($ ($)))
        (SPADCALL (|spadConstant| $ 14) |c| (QREFELT $ 62))) 

(SDEFUN |FDALG;enableDebugOutput;2$;34| ((|f| ($)) ($ ($)))
        (SEQ (QSETVELT |f| 6 'T) (EXIT |f|))) 

(SDEFUN |FDALG;disableDebugOutput;2$;35| ((|f| ($)) ($ ($)))
        (SEQ (QSETVELT |f| 6 NIL) (EXIT |f|))) 

(SDEFUN |FDALG;toggleDebugOutput;2$;36| ((|f| ($)) ($ ($)))
        (SEQ (QSETVELT |f| 6 (NULL (QVELT |f| 6))) (EXIT |f|))) 

(SDEFUN |FDALG;enableAlternativeOutput;2$;37| ((|f| ($)) ($ ($)))
        (SEQ (QSETVELT |f| 7 'T) (EXIT |f|))) 

(SDEFUN |FDALG;disableAlternativeOutput;2$;38| ((|f| ($)) ($ ($)))
        (SEQ (QSETVELT |f| 7 NIL) (EXIT |f|))) 

(SDEFUN |FDALG;toggleAlternativeOutput;2$;39| ((|f| ($)) ($ ($)))
        (SEQ (QSETVELT |f| 7 (NULL (QVELT |f| 7))) (EXIT |f|))) 

(PUT '|FDALG;minimal?;$B;40| '|SPADreplace| '(XLAM (|f|) (QVELT |f| 3))) 

(SDEFUN |FDALG;minimal?;$B;40| ((|f| ($)) ($ (|Boolean|))) (QVELT |f| 3)) 

(PUT '|FDALG;mutable?;$B;41| '|SPADreplace| '(XLAM (|f|) (QVELT |f| 5))) 

(SDEFUN |FDALG;mutable?;$B;41| ((|f| ($)) ($ (|Boolean|))) (QVELT |f| 5)) 

(SDEFUN |FDALG;qregular?;$2NniB;42|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1060 NIL) (#2=#:G1061 NIL) (|i| NIL) (|lst_ele| (|List| F)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((NULL
               (SPADCALL (QVELT |f| 2) (+ 1 |i_min|) (+ 1 |i_max|) 1
                         (QREFELT $ 73)))
              (PROGN (LETT #1# NIL) (GO #3=#:G1059))))
            (LETT |lst_ele|
                  (SPADCALL (QVELT |f| 2) (+ 1 |i_min|) (+ 1 |i_max|) 1
                            (QREFELT $ 74)))
            (SEQ (LETT |i| 1) (LETT #2# (LENGTH |lst_ele|)) G190
                 (COND ((|greater_SI| |i| #2#) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |lst_ele| |i| (QREFELT $ 75))
                                (|spadConstant| $ 15) (QREFELT $ 76)))
                     (PROGN (LETT #1# NIL) (GO #3#))))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #3# (EXIT #1#)))) 

(SDEFUN |FDALG;scalar?;$2NniB;43|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1069 NIL) (|flg_wrk| (|Boolean|)) (#2=#:G1070 NIL) (|k| NIL)
          (|a_lst| (|List| F)))
         (SEQ (LETT |a_lst| (|FDALG;qlstA| (QVELT |f| 2) |i| |j| $))
              (LETT |flg_wrk| 'T)
              (SEQ
               (EXIT
                (SEQ (LETT |k| 2) (LETT #2# (LENGTH (QVELT |f| 1))) G190
                     (COND ((|greater_SI| |k| #2#) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((NULL
                          (SPADCALL (SPADCALL |a_lst| |k| (QREFELT $ 75))
                                    (QREFELT $ 48)))
                         (SEQ (LETT |flg_wrk| NIL)
                              (EXIT
                               (PROGN
                                (LETT #1# |$NoValue|)
                                (GO #3=#:G1066))))))))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL)))
               #3# (EXIT #1#))
              (EXIT |flg_wrk|)))) 

(SDEFUN |FDALG;zero?;$2NniB;44|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPROG ((|flg_wrk| (|Boolean|)))
               (SEQ
                (LETT |flg_wrk|
                      (COND
                       ((SPADCALL |f| |i| |j| (QREFELT $ 78))
                        (SPADCALL (|FDALG;qeltA| (QVELT |f| 2) |i| |j| 1 $)
                                  (QREFELT $ 48)))
                       ('T NIL)))
                (EXIT |flg_wrk|)))) 

(SDEFUN |FDALG;scalar?;$B;45| ((|f| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G1082 NIL) (#2=#:G1083 NIL) (|k| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((> (QVELT |f| 0) 1)
                    (PROGN (LETT #1# NIL) (GO #3=#:G1081))))
                  (COND
                   ((NULL (SPADCALL |f| 1 (QVELT |f| 0) (QREFELT $ 77)))
                    (PROGN (LETT #1# NIL) (GO #3#))))
                  (SEQ (LETT |k| 2) (LETT #2# (LENGTH (QVELT |f| 1))) G190
                       (COND ((|greater_SI| |k| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL
                            (SPADCALL (QVELT |f| 2) (+ 1 1) (+ 1 (QVELT |f| 0))
                                      |k| (QREFELT $ 80)))
                           (PROGN (LETT #1# NIL) (GO #3#))))))
                       (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |FDALG;regular?;$B;46| ((|f| ($)) ($ (|Boolean|)))
        (SPROG ((|flg_wrk| (|Boolean|)) (|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (QVELT |f| 0)) (LETT |flg_wrk| NIL)
                    (COND
                     ((EQL
                       (SPADCALL (|FDALG;qmtxA| (QVELT |f| 2) 1 |n| 1 |n| 1 $)
                                 (QREFELT $ 82))
                       |n|)
                      (LETT |flg_wrk| 'T)))
                    (EXIT |flg_wrk|)))) 

(SDEFUN |FDALG;polynomialForm?| ((|f| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1098 NIL) (#2=#:G1100 NIL) (|i| NIL) (|lst_ele| (|List| F))
          (#3=#:G1099 NIL) (|k| NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((NULL
               (SPADCALL (QVELT |f| 2) (+ 1 1) (+ 1 (QVELT |f| 0)) 1
                         (QREFELT $ 84)))
              (PROGN (LETT #1# NIL) (GO #4=#:G1097))))
            (SEQ (LETT |k| 2) (LETT #3# (LENGTH (QVELT |f| 1))) G190
                 (COND ((|greater_SI| |k| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((NULL
                      (SPADCALL (QVELT |f| 2) (+ 1 1) (+ 1 (QVELT |f| 0)) |k|
                                (QREFELT $ 80)))
                     (PROGN (LETT #1# NIL) (GO #4#))))))
                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
            (LETT |lst_ele|
                  (SPADCALL (QVELT |f| 2) (+ 1 1) (+ 1 (QVELT |f| 0)) 1
                            (QREFELT $ 74)))
            (SEQ (LETT |i| 1) (LETT #2# (LENGTH |lst_ele|)) G190
                 (COND ((|greater_SI| |i| #2#) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |lst_ele| |i| (QREFELT $ 75))
                                (|spadConstant| $ 15) (QREFELT $ 76)))
                     (PROGN (LETT #1# NIL) (GO #4#))))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #4# (EXIT #1#)))) 

(SDEFUN |FDALG;polynomial?;$B;48| ((|f| ($)) ($ (|Boolean|)))
        (|FDALG;polynomialForm?| |f| $)) 

(PUT '|FDALG;dimension;$Nni;49| '|SPADreplace| '(XLAM (|f|) (QVELT |f| 0))) 

(SDEFUN |FDALG;dimension;$Nni;49| ((|f| ($)) ($ (|NonNegativeInteger|)))
        (QVELT |f| 0)) 

(SDEFUN |FDALG;variables;$L;50| ((|f| ($)) ($ (|List| (|FreeMonoid| VAR))))
        (SPADCALL (QVELT |f| 1) (QREFELT $ 61))) 

(SDEFUN |FDALG;elt;$NniF;51| ((|f| ($)) (|i| (|NonNegativeInteger|)) ($ (F)))
        (COND
         ((OR (< |i| 1) (> |i| (QVELT |f| 0)))
          (|error| "FDALG: elt(%,i) - index out of range."))
         ('T (|FDALG;qeltv| (QVELT |f| 2) |i| 1 $)))) 

(SDEFUN |FDALG;qelt;$2NniXdp;52|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ (|XDistributedPolynomial| VAR F)))
        (SPROG
         ((|a_tmp| (|XDistributedPolynomial| VAR F)) (#1=#:G1114 NIL)
          (|k| NIL))
         (SEQ (LETT |a_tmp| (|spadConstant| $ 90))
              (SEQ (LETT |k| 1) (LETT #1# (LENGTH (QVELT |f| 1))) G190
                   (COND ((|greater_SI| |k| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |a_tmp|
                           (SPADCALL |a_tmp|
                                     (SPADCALL
                                      (|FDALG;qeltA| (QVELT |f| 2) |i| |j| |k|
                                       $)
                                      (SPADCALL
                                       (SPADCALL (QVELT |f| 1) |k|
                                                 (QREFELT $ 91))
                                       (QREFELT $ 92))
                                      (QREFELT $ 93))
                                     (QREFELT $ 94)))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT |a_tmp|)))) 

(SDEFUN |FDALG;elt;$2NniXdp;53|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ (|XDistributedPolynomial| VAR F)))
        (COND
         ((OR (< |i| 1)
              (OR (OR (> |i| (QVELT |f| 0)) (< |j| 1)) (> |j| (QVELT |f| 0))))
          (|error| "FDALG: elt(%,i,j) - index out of range."))
         ('T (SPADCALL |f| |i| |j| (QREFELT $ 95))))) 

(SDEFUN |FDALG;setelt!;$Nni2F;54|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|alpha| (F)) ($ (F)))
        (SPROG ((|v_old| (F)))
               (SEQ
                (COND
                 ((NULL (QVELT |f| 5))
                  (|error|
                   "FDALG: setelt!(%,i,alpha) - element is not mutable."))
                 ((OR (< |i| 1) (> |i| (QVELT |f| 0)))
                  (|error| "FDALG: setelt!(%,i,alpha) - index out of range."))
                 ('T
                  (SEQ (LETT |v_old| (|FDALG;qeltv| (QVELT |f| 2) |i| 1 $))
                       (COND
                        ((NULL (SPADCALL |v_old| |alpha| (QREFELT $ 76)))
                         (SEQ (|FDALG;qsetv!| (QVELT |f| 2) |i| 1 |alpha| $)
                              (QSETVELT |f| 3 NIL)
                              (EXIT (QSETVELT |f| 4 NIL)))))
                       (EXIT |alpha|))))))) 

(SDEFUN |FDALG;setelt!;$2Nni2Xdp;55|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|p| (|XDistributedPolynomial| VAR F))
         ($ (|XDistributedPolynomial| VAR F)))
        (SPROG
         ((|p_new| #1=(|List| F)) (|pos| (|NonNegativeInteger|))
          (#2=#:G1133 NIL) (#3=#:G1140 NIL) (|mon| NIL) (#4=#:G1139 NIL)
          (|k| NIL) (|p_old| #1#))
         (SEQ
          (COND
           ((NULL (QVELT |f| 5))
            (|error| "FDALG: setelt!(%,i,j,p) - element is not mutable."))
           ((NULL (|FDALG;polynomialForm?| |f| $))
            (|error|
             "FDALG: setelt!(%,i,j,p) - system not in polynomial form."))
           ((OR (< |i| 1)
                (OR (OR (> |i| (QVELT |f| 0)) (< |j| 1))
                    (> |j| (QVELT |f| 0))))
            (|error| "FDALG: setelt!(%,i,j,p) - index out of range."))
           ('T
            (COND
             ((> |i| |j|)
              (|error| "FDALG: setelt!(%,i,j,p) - entry not above diagonal."))
             ('T
              (SEQ
               (COND
                ((NULL (SPADCALL |p| (QREFELT $ 98)))
                 (COND
                  ((> (SPADCALL |p| (QREFELT $ 99)) 1)
                   (EXIT
                    (|error|
                     "FDALG: setelt!(%,i,j,p) - degree higher than one."))))))
               (LETT |p_old| (|FDALG;qlstA| (QVELT |f| 2) |i| |j| $))
               (SEQ (LETT |k| 1) (LETT #4# (LENGTH (QVELT |f| 1))) G190
                    (COND ((|greater_SI| |k| #4#) (GO G191)))
                    (SEQ
                     (EXIT
                      (|FDALG;qsetA!| (QVELT |f| 2) |i| |j| |k|
                       (|spadConstant| $ 50) $)))
                    (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
               (SEQ (LETT |mon| NIL)
                    (LETT #3#
                          (|FDALG;getSupport| (SPADCALL |p| (QREFELT $ 100))
                           $))
                    G190
                    (COND
                     ((OR (ATOM #3#) (PROGN (LETT |mon| (CAR #3#)) NIL))
                      (GO G191)))
                    (SEQ
                     (LETT |pos|
                           (PROG1
                               (LETT #2#
                                     (SPADCALL |mon| (QVELT |f| 1)
                                               (QREFELT $ 57)))
                             (|check_subtype2| (>= #2# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #2#)))
                     (EXIT
                      (COND
                       ((EQL |pos| 0)
                        (|error|
                         "FDALG: setelt!(%,i,j,p) - monomial not available."))
                       ('T
                        (|FDALG;qsetA!| (QVELT |f| 2) |i| |j| |pos|
                         (SPADCALL |p| |mon| (QREFELT $ 101)) $)))))
                    (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
               (LETT |p_new| (|FDALG;qlstA| (QVELT |f| 2) |i| |j| $))
               (COND
                ((NULL (SPADCALL |p_old| |p_new| (QREFELT $ 102)))
                 (QSETVELT |f| 3 NIL)))
               (EXIT |p|))))))))) 

(SDEFUN |FDALG;vector;$M;56| ((|f| ($)) ($ (|Matrix| F)))
        (|FDALG;qmtxv| (QVELT |f| 2) 1 (QVELT |f| 0) 1 $)) 

(SDEFUN |FDALG;vector;$M;57|
        ((|f| ($)) ($ (|Matrix| (|XDistributedPolynomial| VAR F))))
        (SPROG
         ((#1=#:G1147 NIL) (|i| NIL)
          (|v_wrk| (|Matrix| (|XDistributedPolynomial| VAR F)))
          (|v_tmp| (|Matrix| F)))
         (SEQ (LETT |v_tmp| (|FDALG;qmtxv| (QVELT |f| 2) 1 (QVELT |f| 0) 1 $))
              (LETT |v_wrk|
                    (MAKE_MATRIX1 (ANROWS |v_tmp|) 1 (|spadConstant| $ 90)))
              (SEQ (LETT |i| 1) (LETT #1# (ANROWS |v_tmp|)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF2O |v_wrk| |i| 1
                                 (SPADCALL (QAREF2O |v_tmp| |i| 1 1 1)
                                           (QREFELT $ 105))
                                 1 1)))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |v_wrk|)))) 

(SDEFUN |FDALG;matrix;$FmM;58|
        ((|f| ($)) (|m| (|FreeMonoid| VAR)) ($ (|Matrix| F)))
        (SPROG ((|pos| (|NonNegativeInteger|)) (#1=#:G1148 NIL))
               (SEQ
                (LETT |pos|
                      (PROG1
                          (LETT #1#
                                (SPADCALL |m| (QVELT |f| 1) (QREFELT $ 57)))
                        (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #1#)))
                (EXIT
                 (COND
                  ((EQL |pos| 0)
                   (|error| "FDALG: matrix(%,m) - monoid not available."))
                  ('T
                   (|FDALG;qmtxA| (QVELT |f| 2) 1 (QVELT |f| 0) 1 (QVELT |f| 0)
                    |pos| $))))))) 

(SDEFUN |FDALG;matrix;$M;59|
        ((|f| ($)) ($ (|Matrix| (|XDistributedPolynomial| VAR F))))
        (SPROG
         ((#1=#:G1163 NIL) (|j| NIL) (#2=#:G1162 NIL) (|i| NIL)
          (|A_tmp| (|Matrix| F)) (#3=#:G1161 NIL) (|k| NIL)
          (|A_wrk| (|Matrix| (|XDistributedPolynomial| VAR F)))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |A_wrk| (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 90)))
              (SEQ (LETT |k| 1) (LETT #3# (LENGTH (QVELT |f| 1))) G190
                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                   (SEQ
                    (LETT |A_tmp|
                          (|FDALG;qmtxA| (QVELT |f| 2) 1 (QVELT |f| 0) 1
                           (QVELT |f| 0) |k| $))
                    (EXIT
                     (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                          (COND ((|greater_SI| |i| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                                 (COND ((|greater_SI| |j| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (QSETAREF2O |A_wrk| |i| |j|
                                               (SPADCALL
                                                (QAREF2O |A_wrk| |i| |j| 1 1)
                                                (SPADCALL
                                                 (QAREF2O |A_tmp| |i| |j| 1 1)
                                                 (SPADCALL
                                                  (SPADCALL (QVELT |f| 1) |k|
                                                            (QREFELT $ 91))
                                                  (QREFELT $ 92))
                                                 (QREFELT $ 93))
                                                (QREFELT $ 94))
                                               1 1)))
                                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT |A_wrk|)))) 

(SDEFUN |FDALG;appendSupport!;$L$;60|
        ((|f| ($)) (|lst| (|List| (|FreeMonoid| VAR))) ($ ($)))
        (SPROG
         ((|lst_new| (|List| (|FreeMonoid| VAR)))
          (|pos| (|NonNegativeInteger|)) (#1=#:G1165 NIL) (#2=#:G1171 NIL)
          (|mon| NIL))
         (SEQ (LETT |lst_new| NIL)
              (SEQ (LETT |mon| NIL) (LETT #2# |lst|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |mon| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |pos|
                          (PROG1
                              (LETT #1#
                                    (SPADCALL |mon| (QVELT |f| 1)
                                              (QREFELT $ 57)))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#)))
                    (EXIT
                     (COND
                      ((ZEROP |pos|)
                       (LETT |lst_new| (CONS |mon| |lst_new|))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (COND
               ((> (LENGTH |lst_new|) 0)
                (SPADCALL (QVELT |f| 2) (LENGTH |lst_new|) (QREFELT $ 110))))
              (QSETVELT |f| 1
                        (SPADCALL (QVELT |f| 1) |lst_new| (QREFELT $ 111)))
              (EXIT |f|)))) 

(PUT '|FDALG;pencil;$Lmmp;61| '|SPADreplace| '(XLAM (|f|) (QVELT |f| 2))) 

(SDEFUN |FDALG;pencil;$Lmmp;61|
        ((|f| ($)) ($ (|LinearMultivariateMatrixPencil| F))) (QVELT |f| 2)) 

(SDEFUN |FDALG;qswapRows!;$2Nni$;62|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ ($)))
        (SEQ
         (COND
          ((NULL (EQL |i| |j|))
           (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) (QREFELT $ 114))))
         (EXIT |f|))) 

(SDEFUN |FDALG;swapRows!;$2Nni$;63|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ ($)))
        (SEQ
         (COND
          ((OR (< |i| 1)
               (OR (OR (> |i| (QVELT |f| 0)) (< |j| 1)) (> |j| (QVELT |f| 0))))
           (|error| "FDALG: swapRows!(%,i,j) - index/indices out of range."))
          ('T
           (SEQ
            (COND
             ((NULL (EQL |i| |j|))
              (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) (QREFELT $ 114))))
            (QSETVELT |f| 4 NIL) (EXIT |f|)))))) 

(SDEFUN |FDALG;qaddRows!;$2NniF$;64|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|alpha| (F)) ($ ($)))
        (SEQ
         (COND
          ((NULL (EQL |i| |j|))
           (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) |alpha|
                     (QREFELT $ 117))))
         (EXIT |f|))) 

(SDEFUN |FDALG;addRowsColumns!;$2NniF$;65|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|alpha| (F)) ($ ($)))
        (SEQ
         (COND
          ((EQL |i| |j|)
           (|error|
            "FDALG: addRowsColumns!(%,i,j,alpha) - indices must be different."))
          ((OR (< |i| 1)
               (OR (OR (> |i| (QVELT |f| 0)) (< |j| 1)) (> |j| (QVELT |f| 0))))
           (|error|
            "FDALG: addRowsColumns!(%,i,j,alpha) - index/indices out of range."))
          ('T
           (COND
            ((EQL |j| 1)
             (|error|
              "FDALG: addRowsColumns!(%,i,j,alpha) - first column must not be used."))
            ('T
             (SEQ
              (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) |alpha|
                        (QREFELT $ 117))
              (SPADCALL (QVELT |f| 2) (+ 1 |j|) (+ 1 |i|)
                        (SPADCALL |alpha| (QREFELT $ 58)) (QREFELT $ 119))
              (COND ((< |i| |j|) (QSETVELT |f| 4 NIL))) (EXIT |f|)))))))) 

(SDEFUN |FDALG;addColumnsRows!;$2NniF$;66|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|alpha| (F)) ($ ($)))
        (SEQ
         (COND
          ((EQL |i| |j|)
           (|error|
            "FDALG: addColumnsRows!(%,i,j,alpha) - indices must be different."))
          ((OR (< |i| 1)
               (OR (OR (> |i| (QVELT |f| 0)) (< |j| 1)) (> |j| (QVELT |f| 0))))
           (|error|
            "FDALG: addColumnsRows!(%,i,j,alpha) - index/indices out of range."))
          ('T
           (COND
            ((EQL |i| 1)
             (|error|
              "FDALG: addColumnsRows!(%,i,j,alpha) - first column must not be used."))
            ('T
             (SEQ
              (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) |alpha|
                        (QREFELT $ 119))
              (SPADCALL (QVELT |f| 2) (+ 1 |j|) (+ 1 |i|)
                        (SPADCALL |alpha| (QREFELT $ 58)) (QREFELT $ 117))
              (EXIT |f|)))))))) 

(SDEFUN |FDALG;addRows!;$2NniF$;67|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|alpha| (F)) ($ ($)))
        (SEQ
         (COND
          ((EQL |i| |j|)
           (|error|
            "FDALG: addRows!(%,i,j,alpha) - indices must be different."))
          ((OR (< |i| 1)
               (OR (OR (> |i| (QVELT |f| 0)) (< |j| 1)) (> |j| (QVELT |f| 0))))
           (|error|
            "FDALG: addRows!(%,i,j,alpha) - index/indices out of range."))
          ('T
           (SEQ
            (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) |alpha|
                      (QREFELT $ 122))
            (COND ((< |i| |j|) (QSETVELT |f| 4 NIL))) (EXIT |f|)))))) 

(SDEFUN |FDALG;qmultiplyRow!|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|alpha| (F)) ($ ($)))
        (SEQ (SPADCALL (QVELT |f| 2) (+ 1 |i|) |alpha| (QREFELT $ 124))
             (EXIT |f|))) 

(SDEFUN |FDALG;multiplyRow!;$NniF$;69|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|alpha| (F)) ($ ($)))
        (SPROG ((#1=#:G1210 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |alpha| (|spadConstant| $ 15) (QREFELT $ 76))
                    (PROGN (LETT #1# |f|) (GO #2=#:G1209))))
                  (COND
                   ((OR (< |i| 1) (> |i| (QVELT |f| 0)))
                    (EXIT
                     (|error|
                      "FDALG: multiplyRow!(%,i,alpha) - index out of range."))))
                  (EXIT
                   (COND
                    ((SPADCALL |alpha| (QREFELT $ 48))
                     (|error| "FDALG: multiplyRow!(%,i,alpha) - zero factor."))
                    ('T
                     (SEQ
                      (SPADCALL (QVELT |f| 2) (+ 1 |i|) |alpha|
                                (QREFELT $ 124))
                      (EXIT |f|)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |FDALG;qmultiplyColumn!|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|alpha| (F)) ($ ($)))
        (SEQ (SPADCALL (QVELT |f| 2) (+ 1 |i|) |alpha| (QREFELT $ 126))
             (EXIT |f|))) 

(SDEFUN |FDALG;multiplyColumn!;$NniF$;71|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|alpha| (F)) ($ ($)))
        (SPROG ((#1=#:G1220 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |alpha| (|spadConstant| $ 15) (QREFELT $ 76))
                    (PROGN (LETT #1# |f|) (GO #2=#:G1219))))
                  (COND
                   ((OR (< |i| 1) (> |i| (QVELT |f| 0)))
                    (EXIT
                     (|error|
                      "FDALG: multiplyColumn!(%,i,alpha) - index out of range."))))
                  (EXIT
                   (COND
                    ((SPADCALL |alpha| (QREFELT $ 48))
                     (|error|
                      "FDALG: multiplyColumn!(%,i,alpha) - zero factor."))
                    ('T
                     (SEQ
                      (SPADCALL (QVELT |f| 2) (+ 1 |i|) |alpha|
                                (QREFELT $ 126))
                      (EXIT |f|)))))))
                #2# (EXIT #1#)))) 

(SDEFUN |FDALG;qswapColumns!;$2Nni$;72|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ ($)))
        (SEQ
         (COND
          ((NULL (EQL |i| |j|))
           (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) (QREFELT $ 128))))
         (EXIT |f|))) 

(SDEFUN |FDALG;swapColumns!;$2Nni$;73|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ ($)))
        (SEQ
         (COND
          ((OR (< |i| 1)
               (OR (OR (> |i| (QVELT |f| 0)) (< |j| 1)) (> |j| (QVELT |f| 0))))
           (|error|
            "FDALG: swapColumns!(%,i,j) - index/indices out of range."))
          ((OR (EQL |i| 1) (EQL |j| 1))
           (|error|
            "FDALG: swapColumns!(%,i,j) - first column must not be changed."))
          ('T
           (SEQ
            (COND
             ((NULL (EQL |i| |j|))
              (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) (QREFELT $ 128))))
            (QSETVELT |f| 4 NIL) (EXIT |f|)))))) 

(SDEFUN |FDALG;swapRowsColumns!;$2Nni$;74|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ ($)))
        (SEQ
         (COND
          ((OR (< |i| 1)
               (OR (OR (> |i| (QVELT |f| 0)) (< |j| 1)) (> |j| (QVELT |f| 0))))
           (|error|
            "FDALG: swapRowsColumns!(%,i,j) - index/indices out of range."))
          ((OR (EQL |i| 1) (EQL |j| 1))
           (|error|
            "FDALG: swapRowsColumns!(%,i,j) - first column must not be changed."))
          ('T
           (SEQ
            (COND
             ((NULL (EQL |i| |j|))
              (SEQ (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) (QREFELT $ 114))
                   (EXIT
                    (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|)
                              (QREFELT $ 128))))))
            (QSETVELT |f| 4 NIL) (EXIT |f|)))))) 

(SDEFUN |FDALG;addColumns!;$2NniF$;75|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|alpha| (F)) ($ ($)))
        (SEQ
         (COND
          ((EQL |i| |j|)
           (|error|
            "FDALG: addColumns!(%,i,j,alpha) - indices must be different."))
          ((OR (< |i| 1)
               (OR (OR (> |i| (QVELT |f| 0)) (< |j| 1)) (> |j| (QVELT |f| 0))))
           (|error|
            "FDALG: addColumns!(%,i,j,alpha) - index/indices out of range."))
          ('T
           (COND
            ((EQL |i| 1)
             (|error|
              "FDALG: addColumns!(%,i,j,alpha) - first column must not be used."))
            ('T
             (SEQ
              (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) |alpha|
                        (QREFELT $ 132))
              (COND ((> |i| |j|) (QSETVELT |f| 4 NIL))) (EXIT |f|)))))))) 

(SDEFUN |FDALG;qaddColumns!;$2NniF$;76|
        ((|f| ($)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         (|alpha| (F)) ($ ($)))
        (SEQ
         (COND
          ((NULL (EQL |i| |j|))
           (SPADCALL (QVELT |f| 2) (+ 1 |i|) (+ 1 |j|) |alpha|
                     (QREFELT $ 132))))
         (EXIT |f|))) 

(SDEFUN |FDALG;removeRowsColumns;$2L$;77|
        ((|f| ($)) (|lst_row| (|List| (|NonNegativeInteger|)))
         (|lst_col| (|List| (|NonNegativeInteger|))) ($ ($)))
        (SPROG
         ((|f_new| ($)) (|lst_c| #1=(|List| (|NonNegativeInteger|)))
          (|lst_r| #1#))
         (SEQ
          (LETT |lst_r|
                (SPADCALL (CONS #'|FDALG;removeRowsColumns;$2L$;77!0| $)
                          (SPADCALL |lst_row| (QREFELT $ 137))
                          (QREFELT $ 139)))
          (LETT |lst_c|
                (SPADCALL (CONS #'|FDALG;removeRowsColumns;$2L$;77!1| $)
                          (SPADCALL |lst_col| (QREFELT $ 137))
                          (QREFELT $ 139)))
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |lst_r| (QREFELT $ 140))
                       (SPADCALL |lst_c| (QREFELT $ 140)) (QREFELT $ 39))
             (|error|
              "FDALG: removeRowsColumns(%,rows,cols) - number of rows and columns differ."))
            ('T
             (SEQ
              (LETT |f_new|
                    (SPADCALL
                     (SPADCALL (QVELT |f| 2) |lst_r| |lst_c| (QREFELT $ 141))
                     (QVELT |f| 1) (QREFELT $ 41)))
              (EXIT |f_new|)))))))) 

(SDEFUN |FDALG;removeRowsColumns;$2L$;77!1| ((|a| NIL) ($ NIL))
        (SPADCALL |a| (|spadConstant| $ 135) (QREFELT $ 136))) 

(SDEFUN |FDALG;removeRowsColumns;$2L$;77!0| ((|a| NIL) ($ NIL))
        (SPADCALL |a| (|spadConstant| $ 135) (QREFELT $ 136))) 

(SDEFUN |FDALG;insertRowsColumns;$2L$;78|
        ((|f| ($)) (|lst_row| (|List| (|NonNegativeInteger|)))
         (|lst_col| (|List| (|NonNegativeInteger|))) ($ ($)))
        (SPROG
         ((#1=#:G1260 NIL) (|k| NIL) (|f_new| ($))
          (|lst_c| #2=(|List| (|NonNegativeInteger|))) (|lst_r| #2#))
         (SEQ
          (LETT |lst_r|
                (SPADCALL (CONS #'|FDALG;insertRowsColumns;$2L$;78!0| $)
                          |lst_row| (QREFELT $ 139)))
          (LETT |lst_c|
                (SPADCALL (CONS #'|FDALG;insertRowsColumns;$2L$;78!1| $)
                          |lst_col| (QREFELT $ 139)))
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |lst_r| (QREFELT $ 140))
                       (SPADCALL |lst_c| (QREFELT $ 140)) (QREFELT $ 39))
             (|error|
              "FDALG: insertRowsColumns(%,rows,cols) - number of rows and columns differ."))
            ('T
             (SEQ
              (LETT |f_new|
                    (SPADCALL
                     (SPADCALL (QVELT |f| 2) |lst_r| |lst_c| (QREFELT $ 143))
                     (QVELT |f| 1) (QREFELT $ 41)))
              (SEQ (LETT |k| 1) (LETT #1# (SPADCALL |lst_r| (QREFELT $ 140)))
                   G190 (COND ((|greater_SI| |k| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (|FDALG;qsetA!| (QVELT |f_new| 2)
                      (+ |k| (SPADCALL |lst_row| |k| (QREFELT $ 144)))
                      (+ |k| (SPADCALL |lst_col| |k| (QREFELT $ 144))) 1
                      (|spadConstant| $ 15) $)))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT |f_new|)))))))) 

(SDEFUN |FDALG;insertRowsColumns;$2L$;78!1| ((|a| NIL) ($ NIL))
        (SPADCALL |a| (|spadConstant| $ 135) (QREFELT $ 136))) 

(SDEFUN |FDALG;insertRowsColumns;$2L$;78!0| ((|a| NIL) ($ NIL))
        (SPADCALL |a| (|spadConstant| $ 135) (QREFELT $ 136))) 

(SDEFUN |FDALG;qzero?;$4NniB;79|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) (|j_min| (|NonNegativeInteger|))
         (|j_max| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPADCALL (QVELT |f| 2) (+ 1 |i_min|) (+ 1 |i_max|) (+ 1 |j_min|)
                  (+ 1 |j_max|) (QREFELT $ 25))) 

(SDEFUN |FDALG;qzero?;$5NniB;80|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) (|j_min| (|NonNegativeInteger|))
         (|j_max| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPADCALL (QVELT |f| 2) (+ 1 |i_min|) (+ 1 |i_max|) (+ 1 |j_min|)
                  (+ 1 |j_max|) |l| (QREFELT $ 147))) 

(SDEFUN |FDALG;qzero?;$4NniFmB;81|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) (|j_min| (|NonNegativeInteger|))
         (|j_max| (|NonNegativeInteger|)) (|m| (|FreeMonoid| VAR))
         ($ (|Boolean|)))
        (SPROG ((|l| (|NonNegativeInteger|)) (#1=#:G1265 NIL))
               (SEQ
                (LETT |l|
                      (PROG1
                          (LETT #1#
                                (SPADCALL |m| (QVELT |f| 1) (QREFELT $ 57)))
                        (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #1#)))
                (EXIT
                 (SPADCALL (QVELT |f| 2) (+ 1 |i_min|) (+ 1 |i_max|)
                           (+ 1 |j_min|) (+ 1 |j_max|) |l| (QREFELT $ 147)))))) 

(SDEFUN |FDALG;blockStructure;$M;82|
        ((|f| ($)) ($ (|Matrix| (|NonNegativeInteger|))))
        (SPROG
         ((|sze_tmp| (|NonNegativeInteger|)) (#1=#:G1294 NIL) (#2=#:G1303 NIL)
          (|k| NIL) (#3=#:G1291 NIL) (#4=#:G1302 NIL) (#5=#:G1290 NIL)
          (#6=#:G1301 NIL) (|idx_l| (|List| #7=(|NonNegativeInteger|)))
          (|blo_mtx| (|Matrix| (|NonNegativeInteger|)))
          (|m| (|NonNegativeInteger|)) (|flg_tmp| (|Boolean|)) (#8=#:G1300 NIL)
          (#9=#:G1278 NIL) (#10=#:G1299 NIL) (|i| NIL)
          (|cnt_l| (|List| (|NonNegativeInteger|))) (#11=#:G1274 NIL)
          (#12=#:G1273 NIL) (|j_wrk| #7#))
         (SEQ (LETT |cnt_l| NIL)
              (SEQ (LETT |i| (QVELT |f| 0)) G190 (COND ((< |i| 1) (GO G191)))
                   (SEQ (LETT |j_wrk| 1)
                        (SEQ G190
                             (COND
                              ((NULL
                                (|FDALG;qzeroA?| (QVELT |f| 2) |i| |j_wrk| $))
                               (GO G191)))
                             (SEQ (EXIT (LETT |j_wrk| (+ |j_wrk| 1)))) NIL
                             (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (LETT |cnt_l|
                               (CONS
                                (MIN
                                 (PROG1 (LETT #12# (- |i| 1))
                                   (|check_subtype2| (>= #12# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #12#))
                                 (PROG1 (LETT #11# (- |j_wrk| 1))
                                   (|check_subtype2| (>= #11# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #11#)))
                                |cnt_l|))))
                   (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
              (LETT |idx_l| (LIST 1))
              (SEQ (LETT |i| 2) (LETT #10# (QVELT |f| 0)) G190
                   (COND ((|greater_SI| |i| #10#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL (SPADCALL |cnt_l| |i| (QREFELT $ 144))
                            (PROG1 (LETT #9# (- |i| 1))
                              (|check_subtype2| (>= #9# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #9#)))
                       (SEQ (LETT |flg_tmp| 'T)
                            (SEQ (LETT |k| (+ |i| 1)) (LETT #8# (QVELT |f| 0))
                                 G190 (COND ((> |k| #8#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((< (SPADCALL |cnt_l| |k| (QREFELT $ 144))
                                        (SPADCALL |cnt_l| |i| (QREFELT $ 144)))
                                     (LETT |flg_tmp| NIL)))))
                                 (LETT |k| (+ |k| 1)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT
                             (COND
                              (|flg_tmp|
                               (LETT |idx_l| (CONS |i| |idx_l|))))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |m| (SPADCALL |idx_l| (QREFELT $ 140)))
              (LETT |blo_mtx| (SPADCALL |m| 4 0 (QREFELT $ 151)))
              (LETT |idx_l| (SPADCALL |idx_l| (QREFELT $ 152)))
              (QSETAREF2O |blo_mtx| |m| 2 (QVELT |f| 0) 1 1)
              (SEQ (LETT |k| 1) (LETT #6# |m|) G190
                   (COND ((|greater_SI| |k| #6#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF2O |blo_mtx| |k| 1
                                 (SPADCALL |idx_l| |k| (QREFELT $ 144)) 1 1)))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |k| 1)
                   (LETT #4#
                         (PROG1 (LETT #5# (- |m| 1))
                           (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #5#)))
                   G190 (COND ((|greater_SI| |k| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF2O |blo_mtx| |k| 2
                                 (PROG1
                                     (LETT #3#
                                           (-
                                            (SPADCALL |idx_l| (+ |k| 1)
                                                      (QREFELT $ 144))
                                            1))
                                   (|check_subtype2| (>= #3# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #3#))
                                 1 1)))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |k| 1) (LETT #2# |m|) G190
                   (COND ((|greater_SI| |k| #2#) (GO G191)))
                   (SEQ
                    (LETT |sze_tmp|
                          (PROG1
                              (LETT #1#
                                    (- (+ (QAREF2O |blo_mtx| |k| 2 1 1) 1)
                                       (QAREF2O |blo_mtx| |k| 1 1 1)))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#)))
                    (QSETAREF2O |blo_mtx| |k| 3 |sze_tmp| 1 1)
                    (EXIT
                     (COND
                      ((EQL |sze_tmp| 1) (QSETAREF2O |blo_mtx| |k| 4 1 1 1)))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT |blo_mtx|)))) 

(SDEFUN |FDALG;refined?;$B;83| ((|f| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G1308 NIL) (|blo_mtx| (|Matrix| (|NonNegativeInteger|))))
               (SEQ
                (EXIT
                 (SEQ (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153)))
                      (COND
                       ((EQL (SPADCALL |blo_mtx| (QREFELT $ 154))
                             (QVELT |f| 0))
                        (PROGN (LETT #1# 'T) (GO #2=#:G1307))))
                      (EXIT (QVELT |f| 4))))
                #2# (EXIT #1#)))) 

(SDEFUN |FDALG;qblockElimination|
        ((|f| ($)) (|rsrc| (|List| (|NonNegativeInteger|)))
         (|rdst| (|List| (|NonNegativeInteger|))) (|flg_u| (|Boolean|))
         (|csrc| (|List| (|NonNegativeInteger|)))
         (|cdst| (|List| (|NonNegativeInteger|))) (|flg_v| (|Boolean|))
         ($ (|List| (|Matrix| F))))
        (SPROG
         ((|lst_trn| (|List| (|Matrix| F)))
          (|col_ext| (|List| (|NonNegativeInteger|)))
          (|col_dst| #1=(|List| (|NonNegativeInteger|))) (|col_src| #1#)
          (|row_ext| (|List| (|NonNegativeInteger|))) (|row_dst| #1#)
          (|row_src| #1#))
         (SEQ
          (LETT |row_src|
                (SPADCALL (CONS #'|FDALG;qblockElimination!0| $) |rsrc|
                          (QREFELT $ 139)))
          (LETT |row_dst|
                (SPADCALL (CONS #'|FDALG;qblockElimination!1| $) |rdst|
                          (QREFELT $ 139)))
          (LETT |row_ext| NIL)
          (COND (|flg_u| (LETT |row_ext| (CONS 1 |row_ext|))))
          (LETT |col_src|
                (SPADCALL (CONS #'|FDALG;qblockElimination!2| $) |csrc|
                          (QREFELT $ 139)))
          (LETT |col_dst|
                (SPADCALL (CONS #'|FDALG;qblockElimination!3| $) |cdst|
                          (QREFELT $ 139)))
          (LETT |col_ext| NIL)
          (COND (|flg_v| (LETT |col_ext| (CONS 1 |col_ext|))))
          (LETT |lst_trn|
                (SPADCALL (QVELT |f| 2) |row_src| |row_dst| |row_ext| |col_src|
                          |col_dst| |col_ext| (QREFELT $ 157)))
          (EXIT |lst_trn|)))) 

(SDEFUN |FDALG;qblockElimination!3| ((|a| NIL) ($ NIL))
        (SPADCALL |a| (|spadConstant| $ 135) (QREFELT $ 136))) 

(SDEFUN |FDALG;qblockElimination!2| ((|a| NIL) ($ NIL))
        (SPADCALL |a| (|spadConstant| $ 135) (QREFELT $ 136))) 

(SDEFUN |FDALG;qblockElimination!1| ((|a| NIL) ($ NIL))
        (SPADCALL |a| (|spadConstant| $ 135) (QREFELT $ 136))) 

(SDEFUN |FDALG;qblockElimination!0| ((|a| NIL) ($ NIL))
        (SPADCALL |a| (|spadConstant| $ 135) (QREFELT $ 136))) 

(SDEFUN |FDALG;blockElimination;$2LB2LBL;85|
        ((|f| ($)) (|rsrc| (|List| (|NonNegativeInteger|)))
         (|rdst| (|List| (|NonNegativeInteger|))) (|flg_u| (|Boolean|))
         (|csrc| (|List| (|NonNegativeInteger|)))
         (|cdst| (|List| (|NonNegativeInteger|))) (|flg_v| (|Boolean|))
         ($ (|List| (|Matrix| F))))
        (SPROG
         ((#1=#:G1352 NIL) (|k| NIL) (|lst_trn| (|List| (|Matrix| F)))
          (|flg_col| #2=(|Boolean|)) (|flg_row| #2#)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0)) (LETT |flg_row| 'T)
              (COND
               ((> (SPADCALL |rsrc| (QREFELT $ 140)) 0)
                (COND
                 ((OR (< (SPADCALL (ELT $ 158) |rsrc| (QREFELT $ 160)) 1)
                      (> (SPADCALL (ELT $ 161) |rsrc| (QREFELT $ 160)) |n|))
                  (LETT |flg_row| NIL)))))
              (COND
               ((> (SPADCALL |rdst| (QREFELT $ 140)) 0)
                (COND
                 ((OR (< (SPADCALL (ELT $ 158) |rdst| (QREFELT $ 160)) 1)
                      (> (SPADCALL (ELT $ 161) |rdst| (QREFELT $ 160)) |n|))
                  (LETT |flg_row| NIL)))))
              (EXIT
               (COND
                (|flg_row|
                 (SEQ (LETT |flg_col| 'T)
                      (COND
                       ((> (SPADCALL |csrc| (QREFELT $ 140)) 0)
                        (COND
                         ((OR
                           (< (SPADCALL (ELT $ 158) |csrc| (QREFELT $ 160)) 1)
                           (> (SPADCALL (ELT $ 161) |csrc| (QREFELT $ 160))
                              |n|))
                          (LETT |flg_col| NIL)))))
                      (COND
                       ((> (SPADCALL |cdst| (QREFELT $ 140)) 0)
                        (COND
                         ((OR
                           (< (SPADCALL (ELT $ 158) |cdst| (QREFELT $ 160)) 1)
                           (> (SPADCALL (ELT $ 161) |cdst| (QREFELT $ 160))
                              |n|))
                          (LETT |flg_col| NIL)))))
                      (EXIT
                       (COND
                        (|flg_col|
                         (SEQ
                          (LETT |lst_trn|
                                (|FDALG;qblockElimination| |f| |rsrc| |rdst|
                                 |flg_u| |csrc| |cdst| |flg_v| $))
                          (COND
                           ((> (LENGTH |lst_trn|) 0)
                            (SEQ (LETT |k| 1) (LETT #1# (LENGTH |lst_trn|))
                                 G190 (COND ((|greater_SI| |k| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SPADCALL |lst_trn| |k|
                                             (SPADCALL
                                              (SPADCALL |lst_trn| |k|
                                                        (QREFELT $ 162))
                                              2 (+ (QVELT |f| 0) 1) 2
                                              (+ (QVELT |f| 0) 1)
                                              (QREFELT $ 163))
                                             (QREFELT $ 164))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                          (EXIT |lst_trn|)))
                        (#3='T
                         (|error|
                          "FDALG: blockElimination(f, ...) - column index index out of range."))))))
                (#3#
                 (|error|
                  "FDALG: blockElimination(f, ...) - row index out of range."))))))) 

(SDEFUN |FDALG;blockElimination;$4LL;86|
        ((|f| ($)) (|rsrc| (|List| (|NonNegativeInteger|)))
         (|rdst| (|List| (|NonNegativeInteger|)))
         (|csrc| (|List| (|NonNegativeInteger|)))
         (|cdst| (|List| (|NonNegativeInteger|))) ($ (|List| (|Matrix| F))))
        (SPADCALL |f| |rsrc| |rdst| 'T |csrc| |cdst| 'T (QREFELT $ 165))) 

(SDEFUN |FDALG;toMatrix|
        ((|p| (|LinearMultivariateMatrixPencil| F))
         (|lst| (|List| (|FreeMonoid| VAR))) (|r_min| (|NonNegativeInteger|))
         (|r_max| (|NonNegativeInteger|)) (|c_min| (|NonNegativeInteger|))
         (|c_max| (|NonNegativeInteger|))
         ($ (|Matrix| (|XDistributedPolynomial| VAR F))))
        (SPROG
         ((#1=#:G1369 NIL) (|j| NIL) (#2=#:G1368 NIL) (|i| NIL)
          (|A_tmp| (|Matrix| F)) (#3=#:G1367 NIL) (|k| NIL)
          (|A_wrk| (|Matrix| (|XDistributedPolynomial| VAR F)))
          (|n| (|NonNegativeInteger|)) (#4=#:G1356 NIL)
          (|m| (|NonNegativeInteger|)) (#5=#:G1355 NIL))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |p| (QREFELT $ 40)) (LENGTH |lst|)
                      (QREFELT $ 39))
            (|error|
             "FDALG: toMatrix(p,lst) - number of elements do not agree."))
           ('T
            (SEQ
             (LETT |m|
                   (PROG1 (LETT #5# (- (+ |r_max| 1) |r_min|))
                     (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #5#)))
             (LETT |n|
                   (PROG1 (LETT #4# (- (+ |c_max| 1) |c_min|))
                     (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #4#)))
             (LETT |A_wrk| (MAKE_MATRIX1 |m| |n| (|spadConstant| $ 90)))
             (SEQ (LETT |k| 1) (LETT #3# (LENGTH |lst|)) G190
                  (COND ((|greater_SI| |k| #3#) (GO G191)))
                  (SEQ
                   (LETT |A_tmp|
                         (SPADCALL |p| |r_min| |r_max| |c_min| |c_max| |k|
                                   (QREFELT $ 20)))
                   (EXIT
                    (SEQ (LETT |i| 1) (LETT #2# |m|) G190
                         (COND ((|greater_SI| |i| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                                (COND ((|greater_SI| |j| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (QSETAREF2O |A_wrk| |i| |j|
                                              (SPADCALL
                                               (QAREF2O |A_wrk| |i| |j| 1 1)
                                               (SPADCALL
                                                (QAREF2O |A_tmp| |i| |j| 1 1)
                                                (SPADCALL
                                                 (SPADCALL |lst| |k|
                                                           (QREFELT $ 91))
                                                 (QREFELT $ 92))
                                                (QREFELT $ 93))
                                               (QREFELT $ 94))
                                              1 1)))
                                (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                (EXIT NIL))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))))
                  (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
             (EXIT |A_wrk|))))))) 

(SDEFUN |FDALG;display;$LOf;88|
        ((|f| ($)) (|sym| (|List| (|Symbol|))) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G1381 NIL) (|k| NIL) (|lst| (|List| (|List| (|OutputForm|))))
          (|sym_wrk| (|Symbol|)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0)) (LETT |sym_wrk| '|s|)
              (COND
               ((> (LENGTH |sym|) 0) (LETT |sym_wrk| (|SPADfirst| |sym|))))
              (LETT |lst| (SPADCALL |n| NIL (QREFELT $ 169)))
              (SEQ (LETT |k| 1) (LETT #1# |n|) G190
                   (COND ((|greater_SI| |k| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |lst| |k|
                               (LIST
                                (SPADCALL (SPADCALL |sym_wrk| (QREFELT $ 172))
                                          (SPADCALL |k| (QREFELT $ 173))
                                          (QREFELT $ 174)))
                               (QREFELT $ 175))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |f| (SPADCALL |lst| (QREFELT $ 177))
                         (QREFELT $ 178)))))) 

(SDEFUN |FDALG;display;$2Of;89|
        ((|f| ($)) (|sol| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG
         ((|als_of| (|OutputForm|))
          (|mtx_v| #1=(|Matrix| (|XDistributedPolynomial| VAR F)))
          (|mtx_A| #1#) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |mtx_A|
                    (|FDALG;toMatrix| (QVELT |f| 2) (QVELT |f| 1) (+ 1 1)
                     (+ 1 |n|) (+ 1 1) (+ 1 |n|) $))
              (LETT |mtx_v|
                    (|FDALG;toMatrix| (QVELT |f| 2) (QVELT |f| 1) (+ 1 1)
                     (+ 1 |n|) 1 1 $))
              (LETT |als_of|
                    (SPADCALL
                     (SPADCALL (SPADCALL |mtx_A| (QREFELT $ 181)) |sol|
                               (QREFELT $ 182))
                     (SPADCALL |mtx_v| (QREFELT $ 181)) (QREFELT $ 183)))
              (EXIT |als_of|)))) 

(SDEFUN |FDALG;admissibleLinearSystem;$Of;90| ((|f| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|als_of| (|OutputForm|)) (#1=#:G1401 NIL) (|j| NIL)
          (|row_a| (|List| (|OutputForm|))) (#2=#:G1400 NIL) (|i| NIL)
          (#3=#:G1399 NIL) (|k| NIL)
          (|blo_mtx| (|Matrix| (|NonNegativeInteger|)))
          (|lst_A| (|List| (|List| (|OutputForm|)))) (|sym_wrk| (|Symbol|))
          (|mtx_v| #4=(|Matrix| (|XDistributedPolynomial| VAR F)))
          (|mtx_A| #4#) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |mtx_A|
                    (|FDALG;toMatrix| (QVELT |f| 2) (QVELT |f| 1) (+ 1 1)
                     (+ 1 |n|) (+ 1 1) (+ 1 |n|) $))
              (LETT |mtx_v|
                    (|FDALG;toMatrix| (QVELT |f| 2) (QVELT |f| 1) (+ 1 1)
                     (+ 1 |n|) 1 1 $))
              (LETT |sym_wrk| '|s|)
              (LETT |lst_A| (SPADCALL (ANROWS |mtx_A|) NIL (QREFELT $ 169)))
              (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153)))
              (SEQ (LETT |k| 1) (LETT #3# (SPADCALL |blo_mtx| (QREFELT $ 154)))
                   G190 (COND ((|greater_SI| |k| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |i| (SPADCALL |blo_mtx| |k| 1 (QREFELT $ 184)))
                          (LETT #2# (SPADCALL |blo_mtx| |k| 2 (QREFELT $ 184)))
                          G190 (COND ((> |i| #2#) (GO G191)))
                          (SEQ
                           (LETT |row_a|
                                 (SPADCALL (ANCOLS |mtx_A|)
                                           (SPADCALL 1 (QREFELT $ 185))
                                           (QREFELT $ 186)))
                           (SEQ
                            (LETT |j|
                                  (SPADCALL |blo_mtx| |k| 1 (QREFELT $ 184)))
                            (LETT #1# |n|) G190 (COND ((> |j| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL |row_a| |j|
                                        (SPADCALL (QAREF2O |mtx_A| |i| |j| 1 1)
                                                  (QREFELT $ 187))
                                        (QREFELT $ 188))))
                            (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (SPADCALL |lst_A| |i| |row_a| (QREFELT $ 175))))
                          (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (LETT |als_of|
                    (SPADCALL
                     (SPADCALL (SPADCALL |lst_A| (QREFELT $ 177))
                               (SPADCALL |sym_wrk| (QREFELT $ 172))
                               (QREFELT $ 182))
                     (SPADCALL |mtx_v| (QREFELT $ 181)) (QREFELT $ 183)))
              (EXIT |als_of|)))) 

(SDEFUN |FDALG;linearization;$M;91|
        ((|f| ($)) ($ (|Matrix| (|XDistributedPolynomial| VAR F))))
        (SPROG
         ((#1=#:G1407 NIL) (|k| NIL)
          (|L_wrk| (|Matrix| (|XDistributedPolynomial| VAR F))))
         (SEQ
          (LETT |L_wrk|
                (|FDALG;toMatrix| (QVELT |f| 2) (QVELT |f| 1) 1
                 (+ 1 (QVELT |f| 0)) 1 (+ 1 (QVELT |f| 0)) $))
          (SEQ (LETT |k| 2) (LETT #1# (ANROWS |L_wrk|)) G190
               (COND ((|greater_SI| |k| #1#) (GO G191)))
               (SEQ
                (EXIT
                 (QSETAREF2O |L_wrk| |k| 1
                             (SPADCALL (QAREF2O |L_wrk| |k| 1 1 1)
                                       (QREFELT $ 190))
                             1 1)))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (EXIT |L_wrk|)))) 

(SDEFUN |FDALG;linearization;$M;92| ((|f| ($)) ($ (|Matrix| $)))
        (SPROG
         ((#1=#:G1421 NIL) (|l| NIL)
          (|lp_new| (|LinearMultivariateMatrixPencil| F)) (|als| ($))
          (|a_wrk| (F)) (#2=#:G1420 NIL) (|j| NIL) (#3=#:G1419 NIL) (|i| NIL)
          (|L_wrk| (|Matrix| $)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |L_wrk|
                    (SPADCALL (+ |n| 1) (+ |n| 1) (|spadConstant| $ 49)
                              (QREFELT $ 193)))
              (SEQ (LETT |i| 1) (LETT #3# (+ |n| 1)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #2# (+ |n| 1)) G190
                          (COND ((|greater_SI| |j| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((SPADCALL (QVELT |f| 2) |i| |i| |j| |j| 1
                                        (QREFELT $ 26))
                              (SEQ
                               (LETT |a_wrk|
                                     (SPADCALL (QVELT |f| 2) |i| |j| 1
                                               (QREFELT $ 13)))
                               (COND
                                ((EQL |j| 1)
                                 (LETT |a_wrk|
                                       (SPADCALL |a_wrk| (QREFELT $ 58)))))
                               (EXIT
                                (COND
                                 ((NULL (SPADCALL |a_wrk| (QREFELT $ 48)))
                                  (SPADCALL |L_wrk| |i| |j|
                                            (SPADCALL
                                             (SPADCALL (|spadConstant| $ 14)
                                                       |a_wrk| (QREFELT $ 62))
                                             (QREFELT $ 66))
                                            (QREFELT $ 194)))))))
                             ('T
                              (SEQ
                               (LETT |als|
                                     (SPADCALL 2 (QVELT |f| 1) (QREFELT $ 35)))
                               (LETT |lp_new| (QVELT |als| 2))
                               (|FDALG;qsetu!| |lp_new| 1 1
                                (|spadConstant| $ 15) $)
                               (|FDALG;qsetv!| |lp_new| 2 1
                                (|spadConstant| $ 15) $)
                               (|FDALG;qsetA!| |lp_new| 1 1 1
                                (|spadConstant| $ 15) $)
                               (|FDALG;qsetA!| |lp_new| 2 2 1
                                (|spadConstant| $ 15) $)
                               (SEQ (LETT |l| 1)
                                    (LETT #1# (LENGTH (QVELT |f| 1))) G190
                                    (COND ((|greater_SI| |l| #1#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (|FDALG;qsetA!| |lp_new| 1 2 |l|
                                       (SPADCALL
                                        (SPADCALL (QVELT |f| 2) |i| |j| |l|
                                                  (QREFELT $ 13))
                                        (QREFELT $ 58))
                                       $)))
                                    (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                    (EXIT NIL))
                               (QSETVELT |als| 3 'T) (QSETVELT |als| 4 'T)
                               (QSETVELT |als| 6 NIL)
                               (EXIT
                                (SPADCALL |L_wrk| |i| |j|
                                          (SPADCALL |als| (QREFELT $ 66))
                                          (QREFELT $ 194))))))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |L_wrk|)))) 

(SDEFUN |FDALG;representation;$L;93|
        ((|f| ($)) ($ (|List| (|Matrix| (|XDistributedPolynomial| VAR F)))))
        (SPROG
         ((|mtx_v| #1=(|Matrix| (|XDistributedPolynomial| VAR F)))
          (|mtx_A| #1#) (|mtx_u| #1#) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |mtx_u|
                    (|FDALG;toMatrix| (QVELT |f| 2) (QVELT |f| 1) 1 1 (+ 1 1)
                     (+ 1 |n|) $))
              (LETT |mtx_A|
                    (|FDALG;toMatrix| (QVELT |f| 2) (QVELT |f| 1) (+ 1 1)
                     (+ 1 |n|) (+ 1 1) (+ 1 |n|) $))
              (LETT |mtx_v|
                    (|FDALG;toMatrix| (QVELT |f| 2) (QVELT |f| 1) (+ 1 1)
                     (+ 1 |n|) 1 1 $))
              (EXIT (LIST |mtx_u| |mtx_A| |mtx_v|))))) 

(SDEFUN |FDALG;*;$M$;94| ((|f| ($)) (U (|Matrix| F)) ($ ($)))
        (SPROG ((|f_new| ($)))
               (SEQ (LETT |f_new| (SPADCALL |f| (QREFELT $ 51)))
                    (EXIT (SPADCALL |f_new| U (QREFELT $ 199)))))) 

(SDEFUN |FDALG;*;M2$;95| ((T$ (|Matrix| F)) (|f| ($)) ($ ($)))
        (SPROG ((|f_new| ($)))
               (SEQ (LETT |f_new| (SPADCALL |f| (QREFELT $ 51)))
                    (EXIT (SPADCALL |f_new| T$ (QREFELT $ 201)))))) 

(SDEFUN |FDALG;transformationMatrix;$M;96| ((|f| ($)) ($ (|Matrix| F)))
        (SPROG ((#1=#:G1432 NIL) (|k| NIL) (|trf_mtx| (|Matrix| F)))
               (SEQ
                (LETT |trf_mtx|
                      (MAKE_MATRIX1 (QVELT |f| 0) (QVELT |f| 0)
                                    (|spadConstant| $ 50)))
                (SEQ (LETT |k| 1) (LETT #1# (QVELT |f| 0)) G190
                     (COND ((|greater_SI| |k| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (QSETAREF2O |trf_mtx| |k| |k| (|spadConstant| $ 15) 1
                                   1)))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                (EXIT |trf_mtx|)))) 

(SDEFUN |FDALG;transformRows!;$M$;97| ((|f| ($)) (T$ (|Matrix| F)) ($ ($)))
        (SPROG ((|trf_mtx| (|Matrix| F)))
               (SEQ
                (COND
                 ((EQL (ANROWS T$) (ANCOLS T$))
                  (COND
                   ((NULL (EQL (ANROWS T$) (QVELT |f| 0)))
                    (EXIT
                     (|error|
                      #1="FDALG: transformRows!(%,T) - wrong matrix size.")))))
                 (#2='T (EXIT (|error| #1#))))
                (EXIT
                 (COND
                  ((< (SPADCALL T$ (QREFELT $ 82)) (QVELT |f| 0))
                   (|error|
                    "FDALG: transformRows!(%,T) - matrix not invertible."))
                  (#2#
                   (SEQ
                    (LETT |trf_mtx| (SPADCALL (QVELT |f| 2) (QREFELT $ 204)))
                    (SPADCALL |trf_mtx| 2 2 T$ (QREFELT $ 205))
                    (SPADCALL (QVELT |f| 2) |trf_mtx| (QREFELT $ 206))
                    (QSETVELT |f| 4 NIL) (EXIT |f|)))))))) 

(SDEFUN |FDALG;transformColumns!;$M$;98| ((|f| ($)) (U (|Matrix| F)) ($ ($)))
        (SPROG
         ((|trf_mtx| (|Matrix| F)) (#1=#:G1450 NIL) (|flg_wrk| (|Boolean|))
          (#2=#:G1451 NIL) (|j| NIL))
         (SEQ
          (COND
           ((EQL (ANROWS U) (ANCOLS U))
            (COND
             ((NULL (EQL (ANROWS U) (QVELT |f| 0)))
              (EXIT
               (|error|
                #3="FDALG: transformColumns!(%,U) - wrong matrix size.")))))
           (#4='T (EXIT (|error| #3#))))
          (LETT |flg_wrk| 'T)
          (SEQ
           (EXIT
            (SEQ (LETT |j| 2) (LETT #2# (QVELT |f| 0)) G190
                 (COND ((|greater_SI| |j| #2#) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((NULL (SPADCALL (QAREF2O U 1 |j| 1 1) (QREFELT $ 48)))
                     (SEQ (LETT |flg_wrk| NIL)
                          (EXIT
                           (PROGN (LETT #1# |$NoValue|) (GO #5=#:G1445))))))))
                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL)))
           #5# (EXIT #1#))
          (COND
           ((SPADCALL (QAREF2O U 1 1 1 1) (|spadConstant| $ 15) (QREFELT $ 76))
            (COND
             ((NULL |flg_wrk|)
              (EXIT
               (|error|
                #6="FDALG: transformColumns!(%,U) - first column must not be changed.")))))
           (#4# (EXIT (|error| #6#))))
          (EXIT
           (COND
            ((< (SPADCALL U (QREFELT $ 82)) (QVELT |f| 0))
             (|error|
              "FDALG: transformColumns!(%,U) - matrix not invertible."))
            (#4#
             (SEQ (LETT |trf_mtx| (SPADCALL (QVELT |f| 2) (QREFELT $ 207)))
                  (SPADCALL |trf_mtx| 2 2 U (QREFELT $ 205))
                  (SPADCALL (QVELT |f| 2) |trf_mtx| (QREFELT $ 208))
                  (QSETVELT |f| 4 NIL) (EXIT |f|)))))))) 

(SDEFUN |FDALG;normalizeRHS!;2$;99| ((|f| ($)) ($ ($)))
        (SPROG
         ((|i_ref| (|NonNegativeInteger|)) (|v_ref| (F)) (|v_wrk| (F))
          (|i| NIL))
         (SEQ (LETT |i_ref| 0) (LETT |v_ref| (|spadConstant| $ 50))
              (SEQ (LETT |i| (QVELT |f| 0)) G190 (COND ((< |i| 1) (GO G191)))
                   (SEQ (LETT |v_wrk| (|FDALG;qeltv| (QVELT |f| 2) |i| 1 $))
                        (EXIT
                         (COND
                          ((NULL (SPADCALL |v_wrk| (QREFELT $ 48)))
                           (COND
                            ((> |i_ref| 0)
                             (SPADCALL |f| |i_ref| |i|
                                       (SPADCALL
                                        (SPADCALL |v_wrk| |v_ref|
                                                  (QREFELT $ 209))
                                        (QREFELT $ 58))
                                       (QREFELT $ 118)))
                            ('T
                             (SEQ (LETT |v_ref| |v_wrk|)
                                  (EXIT (LETT |i_ref| |i|)))))))))
                   (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
              (EXIT |f|)))) 

(SDEFUN |FDALG;normalizePLS!;2$;100| ((|f| ($)) ($ ($)))
        (SPROG
         ((|a_wrk| (F)) (#1=#:G1476 NIL) (|i_wrk| NIL) (#2=#:G1473 NIL)
          (|i_ref| (|NonNegativeInteger|)) (#3=#:G1475 NIL) (#4=#:G1474 NIL)
          (|j_wrk| NIL) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (SEQ (LETT |j_wrk| 1) (LETT #4# |n|) G190
                   (COND ((|greater_SI| |j_wrk| #4#) (GO G191)))
                   (SEQ (LETT |i_ref| 0)
                        (SEQ
                         (EXIT
                          (SEQ (LETT |i_wrk| |j_wrk|) (LETT #3# |n|) G190
                               (COND ((> |i_wrk| #3#) (GO G191)))
                               (SEQ
                                (LETT |a_wrk|
                                      (|FDALG;qeltA| (QVELT |f| 2) |i_wrk|
                                       |j_wrk| 1 $))
                                (EXIT
                                 (COND
                                  ((NULL (SPADCALL |a_wrk| (QREFELT $ 48)))
                                   (COND
                                    ((ZEROP |i_ref|)
                                     (SEQ (LETT |i_ref| |i_wrk|)
                                          (|FDALG;qmultiplyRow!| |f| |i_ref|
                                           (SPADCALL (|spadConstant| $ 15)
                                                     |a_wrk| (QREFELT $ 209))
                                           $)
                                          (COND
                                           ((SPADCALL |i_ref| |j_wrk|
                                                      (QREFELT $ 39))
                                            (SPADCALL |f| |i_ref| |j_wrk|
                                                      (QREFELT $ 115))))
                                          (EXIT
                                           (PROGN
                                            (LETT #2# 1)
                                            (GO #5=#:G1464))))))))))
                               (LETT |i_wrk| (+ |i_wrk| 1)) (GO G190) G191
                               (EXIT NIL)))
                         #5# (EXIT #2#))
                        (EXIT
                         (COND
                          ((NULL (ZEROP |i_ref|))
                           (SEQ (LETT |i_wrk| 1) (LETT #1# |n|) G190
                                (COND ((|greater_SI| |i_wrk| #1#) (GO G191)))
                                (SEQ
                                 (LETT |a_wrk|
                                       (|FDALG;qeltA| (QVELT |f| 2) |i_wrk|
                                        |i_ref| 1 $))
                                 (EXIT
                                  (COND
                                   ((NULL (SPADCALL |a_wrk| (QREFELT $ 48)))
                                    (COND
                                     ((SPADCALL |i_wrk| |i_ref| (QREFELT $ 39))
                                      (SPADCALL |f| |i_ref| |i_wrk|
                                                (SPADCALL |a_wrk|
                                                          (QREFELT $ 58))
                                                (QREFELT $ 118))))))))
                                (LETT |i_wrk| (|inc_SI| |i_wrk|)) (GO G190)
                                G191 (EXIT NIL))))))
                   (LETT |j_wrk| (|inc_SI| |j_wrk|)) (GO G190) G191 (EXIT NIL))
              (EXIT |f|)))) 

(SDEFUN |FDALG;normalizeDIAG!;2$;101| ((|f| ($)) ($ ($)))
        (SPROG
         ((#1=#:G1487 NIL) (#2=#:G1489 NIL) (|l| NIL) (|a_lst| (|List| F))
          (#3=#:G1488 NIL) (|i| NIL))
         (SEQ
          (SEQ (LETT |i| 1) (LETT #3# (QVELT |f| 0)) G190
               (COND ((|greater_SI| |i| #3#) (GO G191)))
               (SEQ (LETT |a_lst| (|FDALG;qlstA| (QVELT |f| 2) |i| |i| $))
                    (EXIT
                     (SEQ
                      (EXIT
                       (SEQ (LETT |l| 1) (LETT #2# (LENGTH |a_lst|)) G190
                            (COND ((|greater_SI| |l| #2#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((NULL
                                 (SPADCALL
                                  (SPADCALL |a_lst| |l| (QREFELT $ 75))
                                  (QREFELT $ 48)))
                                (SEQ
                                 (|FDALG;qmultiplyRow!| |f| |i|
                                  (SPADCALL (|spadConstant| $ 15)
                                            (SPADCALL |a_lst| |l|
                                                      (QREFELT $ 75))
                                            (QREFELT $ 209))
                                  $)
                                 (EXIT
                                  (PROGN
                                   (LETT #1# |$NoValue|)
                                   (GO #4=#:G1482))))))))
                            (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                            (EXIT NIL)))
                      #4# (EXIT #1#))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |f|)))) 

(SDEFUN |FDALG;normalize!;2$;102| ((|f| ($)) ($ ($)))
        (SPROG
         ((#1=#:G1502 NIL) (|i_max| (|NonNegativeInteger|)) (#2=#:G1503 NIL)
          (|k| NIL) (|i_ref| (|NonNegativeInteger|))
          (|blo_mtx| (|Matrix| (|NonNegativeInteger|))))
         (SEQ (SPADCALL |f| (QREFELT $ 210)) (SPADCALL |f| (QREFELT $ 212))
              (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153))) (LETT |i_ref| 1)
              (SEQ G190
                   (COND
                    ((NULL
                      (COND
                       ((<= |i_ref| (QVELT |f| 0))
                        (SPADCALL (|FDALG;qeltv| (QVELT |f| 2) |i_ref| 1 $)
                                  (QREFELT $ 48)))
                       ('T NIL)))
                     (GO G191)))
                   (SEQ (EXIT (LETT |i_ref| (+ |i_ref| 1)))) NIL (GO G190) G191
                   (EXIT NIL))
              (COND
               ((< |i_ref| (QVELT |f| 0))
                (SEQ (LETT |i_max| 0)
                     (SEQ
                      (EXIT
                       (SEQ (LETT |k| 1)
                            (LETT #2# (SPADCALL |blo_mtx| (QREFELT $ 154)))
                            G190 (COND ((|greater_SI| |k| #2#) (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((>= (SPADCALL |blo_mtx| |k| 2 (QREFELT $ 184))
                                    |i_ref|)
                                (SEQ
                                 (LETT |i_max|
                                       (SPADCALL |blo_mtx| |k| 2
                                                 (QREFELT $ 184)))
                                 (EXIT
                                  (PROGN (LETT #1# 1) (GO #3=#:G1497))))))))
                            (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                            (EXIT NIL)))
                      #3# (EXIT #1#))
                     (EXIT
                      (COND
                       ((< |i_ref| |i_max|)
                        (SPADCALL |f| |i_ref| |i_max| (QREFELT $ 115))))))))
              (EXIT |f|)))) 

(SDEFUN |FDALG;regularMatrix|
        ((|f| ($)) ($ (|Matrix| (|XDistributedPolynomial| VAR F))))
        (SPROG
         ((#1=#:G1510 NIL) (|i| NIL)
          (|Q_wrk| (|Matrix| (|XDistributedPolynomial| VAR F)))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((NULL (SPADCALL |f| 1 (QVELT |f| 0) (QREFELT $ 77)))
            (|error| "FDALG: regularMatrix(f) - f is not regular."))
           ('T
            (SEQ (LETT |n| (QVELT |f| 0))
                 (LETT |Q_wrk|
                       (SPADCALL (SPADCALL |f| (QREFELT $ 109))
                                 (QREFELT $ 214)))
                 (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF2O |Q_wrk| |i| |i|
                                    (SPADCALL (QAREF2O |Q_wrk| |i| |i| 1 1)
                                              (|spadConstant| $ 215)
                                              (QREFELT $ 94))
                                    1 1)))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (EXIT |Q_wrk|))))))) 

(SDEFUN |FDALG;polynomial;$Xdp;104|
        ((|f| ($)) ($ (|XDistributedPolynomial| VAR F)))
        (SPROG
         ((|p_wrk| (|XDistributedPolynomial| VAR F))
          (|s_wrk| (|Matrix| (|XDistributedPolynomial| VAR F))))
         (SEQ (LETT |s_wrk| (SPADCALL |f| (QREFELT $ 216)))
              (EXIT (LETT |p_wrk| (QAREF2O |s_wrk| 1 1 1 1)))))) 

(SDEFUN |FDALG;solutionVector;$M;105|
        ((|f| ($)) ($ (|Matrix| (|XDistributedPolynomial| VAR F))))
        (SPROG
         ((|p_wrk| (|XDistributedPolynomial| VAR F)) (#1=#:G1522 NIL) (|j| NIL)
          (|i| NIL) (|s_wrk| (|Matrix| (|XDistributedPolynomial| VAR F)))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((NULL (|FDALG;polynomialForm?| |f| $))
            (|error| "FDALG: solutionVector(f) - f is not polynomial."))
           ('T
            (SEQ (LETT |n| (QVELT |f| 0))
                 (LETT |s_wrk| (MAKE_MATRIX1 |n| 1 (|spadConstant| $ 90)))
                 (SEQ (LETT |i| |n|) G190 (COND ((< |i| 1) (GO G191)))
                      (SEQ
                       (LETT |p_wrk|
                             (SPADCALL (SPADCALL |f| |i| (QREFELT $ 88))
                                       (QREFELT $ 105)))
                       (SEQ (LETT |j| (+ |i| 1)) (LETT #1# |n|) G190
                            (COND ((> |j| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |p_wrk|
                                    (SPADCALL |p_wrk|
                                              (SPADCALL
                                               (SPADCALL |f| |i| |j|
                                                         (QREFELT $ 96))
                                               (QAREF2O |s_wrk| |j| 1 1 1)
                                               (QREFELT $ 218))
                                              (QREFELT $ 219)))))
                            (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
                       (EXIT (QSETAREF2O |s_wrk| |i| 1 |p_wrk| 1 1)))
                      (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                 (EXIT |s_wrk|))))))) 

(SDEFUN |FDALG;solutionVector;$NniM;106|
        ((|f| ($)) (|k| (|NonNegativeInteger|))
         ($ (|Matrix| (|XDistributedPolynomial| VAR F))))
        (SPROG
         ((|s_wrk| (|Matrix| (|XDistributedPolynomial| VAR F)))
          (|v_wrk| (|Matrix| (|XDistributedPolynomial| VAR F)))
          (#1=#:G1528 NIL) (|i| NIL)
          (|Q_wrk| (|Matrix| (|XDistributedPolynomial| VAR F))) (|als| ($)))
         (SEQ (LETT |als| (SPADCALL |f| (QREFELT $ 51)))
              (SPADCALL |als| (QREFELT $ 211))
              (LETT |Q_wrk| (|FDALG;regularMatrix| |als| $))
              (LETT |v_wrk| (SPADCALL |als| (QREFELT $ 107)))
              (LETT |s_wrk| (SPADCALL |v_wrk| (QREFELT $ 220)))
              (SEQ (LETT |i| 1) (LETT #1# |k|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (LETT |v_wrk| (SPADCALL |Q_wrk| |v_wrk| (QREFELT $ 221)))
                    (EXIT
                     (LETT |s_wrk|
                           (SPADCALL |s_wrk| |v_wrk| (QREFELT $ 222)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |s_wrk|)))) 

(SDEFUN |FDALG;columnSpan;$S;107|
        ((|f| ($)) ($ (|Stream| (|Matrix| (|XDistributedPolynomial| VAR F)))))
        (SPROG
         ((|fnc|
           (|Mapping| (|Matrix| (|XDistributedPolynomial| VAR F))
                      (|Matrix| (|XDistributedPolynomial| VAR F))))
          (|v_wrk| (|Matrix| (|XDistributedPolynomial| VAR F)))
          (|Q_wrk| (|Matrix| (|XDistributedPolynomial| VAR F))) (|als| ($)))
         (SEQ (LETT |als| (SPADCALL |f| (QREFELT $ 51)))
              (SPADCALL |als| (QREFELT $ 211))
              (LETT |Q_wrk| (|FDALG;regularMatrix| |als| $))
              (LETT |v_wrk| (SPADCALL |als| (QREFELT $ 107)))
              (LETT |fnc|
                    (CONS #'|FDALG;columnSpan;$S;107!0| (VECTOR $ |Q_wrk|)))
              (EXIT (SPADCALL |fnc| |v_wrk| (QREFELT $ 226)))))) 

(SDEFUN |FDALG;columnSpan;$S;107!0| ((|v| NIL) ($$ NIL))
        (PROG (|Q_wrk| $)
          (LETT |Q_wrk| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |Q_wrk| |v| (QREFELT $ 221)))))) 

(SDEFUN |FDALG;rowSpan;$S;108|
        ((|f| ($)) ($ (|Stream| (|Matrix| (|XDistributedPolynomial| VAR F)))))
        (SPROG
         ((|fnc|
           (|Mapping| (|Matrix| (|XDistributedPolynomial| VAR F))
                      (|Matrix| (|XDistributedPolynomial| VAR F))))
          (|u_wrk| (|Matrix| (|XDistributedPolynomial| VAR F)))
          (|Q_wrk| (|Matrix| (|XDistributedPolynomial| VAR F))) (|als| ($)))
         (SEQ (LETT |als| (SPADCALL |f| (QREFELT $ 51)))
              (SPADCALL |als| (QREFELT $ 211))
              (LETT |Q_wrk| (|FDALG;regularMatrix| |als| $))
              (LETT |u_wrk|
                    (MAKE_MATRIX1 1 (QVELT |als| 0) (|spadConstant| $ 90)))
              (SPADCALL |u_wrk| 1 1 (|spadConstant| $ 215) (QREFELT $ 228))
              (LETT |fnc| (CONS #'|FDALG;rowSpan;$S;108!0| (VECTOR $ |Q_wrk|)))
              (EXIT (SPADCALL |fnc| |u_wrk| (QREFELT $ 226)))))) 

(SDEFUN |FDALG;rowSpan;$S;108!0| ((|u| NIL) ($$ NIL))
        (PROG (|Q_wrk| $)
          (LETT |Q_wrk| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |u| |Q_wrk| (QREFELT $ 221)))))) 

(SDEFUN |FDALG;scaleALS;$F$;109| ((|f| ($)) (|alpha| (F)) ($ ($)))
        (SPROG ((#1=#:G1540 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |alpha| (QREFELT $ 48))
                    (PROGN
                     (LETT #1# (SPADCALL (|spadConstant| $ 49) (QREFELT $ 51)))
                     (GO #2=#:G1539))))
                  (EXIT (SPADCALL |f| |alpha| (QREFELT $ 62)))))
                #2# (EXIT #1#)))) 

(SDEFUN |FDALG;addALS;3$;110| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPROG
         ((|pos| (|NonNegativeInteger|)) (#1=#:G1551 NIL)
          (|mon| (|FreeMonoid| VAR)) (#2=#:G1559 NIL) (|k| NIL)
          (#3=#:G1547 NIL) (#4=#:G1558 NIL)
          (|lp_new| #5=(|LinearMultivariateMatrixPencil| F)) (|lp_g| #5#)
          (|lp_f| #5#) (|als| ($)) (|lst| (|List| (|FreeMonoid| VAR)))
          (#6=#:G1557 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |f| (QREFELT $ 81))
              (COND
               ((SPADCALL (|FDALG;qeltv| (QVELT |f| 2) 1 1 $) (QREFELT $ 48))
                (PROGN
                 (LETT #6# (SPADCALL |g| (QREFELT $ 51)))
                 (GO #7=#:G1556))))))
            (COND
             ((SPADCALL |g| (QREFELT $ 81))
              (COND
               ((SPADCALL (|FDALG;qeltv| (QVELT |g| 2) 1 1 $) (QREFELT $ 48))
                (PROGN (LETT #6# (SPADCALL |f| (QREFELT $ 51))) (GO #7#))))))
            (LETT |lst|
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (QVELT |f| 1) (QVELT |g| 1) (QREFELT $ 231))
                    (QREFELT $ 232))
                   (QREFELT $ 233)))
            (LETT |als|
                  (SPADCALL (+ (QVELT |f| 0) (QVELT |g| 0)) |lst|
                            (QREFELT $ 35)))
            (LETT |lp_f| (QVELT |f| 2)) (LETT |lp_g| (QVELT |g| 2))
            (LETT |lp_new| (QVELT |als| 2))
            (SEQ (LETT |k| 1) (LETT #4# (LENGTH (QVELT |f| 1))) G190
                 (COND ((|greater_SI| |k| #4#) (GO G191)))
                 (SEQ (LETT |mon| (SPADCALL (QVELT |f| 1) |k| (QREFELT $ 91)))
                      (LETT |pos|
                            (PROG1
                                (LETT #3#
                                      (SPADCALL |mon| |lst| (QREFELT $ 57)))
                              (|check_subtype2| (>= #3# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #3#)))
                      (|FDALG;qsetmtxu!| |lp_new| 1 |pos|
                       (|FDALG;qmtxu| |lp_f| 1 (QVELT |f| 0) |k| $) $)
                      (|FDALG;qsetmtxA!| |lp_new| 1 1 |pos|
                       (|FDALG;qmtxA| |lp_f| 1 (QVELT |f| 0) 1 (QVELT |f| 0)
                        |k| $)
                       $)
                      (EXIT
                       (|FDALG;qsetmtxv!| |lp_new| 1 |pos|
                        (|FDALG;qmtxv| |lp_f| 1 (QVELT |f| 0) |k| $) $)))
                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
            (SEQ (LETT |k| 1) (LETT #2# (LENGTH (QVELT |g| 1))) G190
                 (COND ((|greater_SI| |k| #2#) (GO G191)))
                 (SEQ (LETT |mon| (SPADCALL (QVELT |g| 1) |k| (QREFELT $ 91)))
                      (LETT |pos|
                            (PROG1
                                (LETT #1#
                                      (SPADCALL |mon| |lst| (QREFELT $ 57)))
                              (|check_subtype2| (>= #1# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #1#)))
                      (|FDALG;qsetmtxu!| |lp_new| (+ (QVELT |f| 0) 1) |pos|
                       (|FDALG;qmtxu| |lp_g| 1 (QVELT |g| 0) |k| $) $)
                      (|FDALG;qsetmtxA!| |lp_new| (+ (QVELT |f| 0) 1)
                       (+ (QVELT |f| 0) 1) |pos|
                       (|FDALG;qmtxA| |lp_g| 1 (QVELT |g| 0) 1 (QVELT |g| 0)
                        |k| $)
                       $)
                      (EXIT
                       (|FDALG;qsetmtxv!| |lp_new| (+ (QVELT |f| 0) 1) |pos|
                        (|FDALG;qmtxv| |lp_g| 1 (QVELT |g| 0) |k| $) $)))
                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL |als| 1 (+ (QVELT |f| 0) 1)
                      (SPADCALL (|spadConstant| $ 15) (QREFELT $ 58))
                      (QREFELT $ 134))
            (QSETVELT |als| 4 (COND ((QVELT |f| 4) (QVELT |g| 4)) ('T NIL)))
            (EXIT |als|)))
          #7# (EXIT #6#)))) 

(SDEFUN |FDALG;multiplyALS;3$;111| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPROG
         ((|pos| (|NonNegativeInteger|)) (#1=#:G1568 NIL)
          (|mon| (|FreeMonoid| VAR)) (#2=#:G1576 NIL) (|k| NIL)
          (#3=#:G1564 NIL) (#4=#:G1575 NIL)
          (|lp_new| #5=(|LinearMultivariateMatrixPencil| F)) (|lp_g| #5#)
          (|lp_f| #5#) (|als| ($)) (|lst| (|List| (|FreeMonoid| VAR)))
          (#6=#:G1574 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |f| (QREFELT $ 81))
              (PROGN
               (LETT #6#
                     (SPADCALL |g| (|FDALG;qeltv| (QVELT |f| 2) 1 1 $)
                               (QREFELT $ 62)))
               (GO #7=#:G1573))))
            (COND
             ((SPADCALL |g| (QREFELT $ 81))
              (PROGN
               (LETT #6#
                     (SPADCALL |f| (|FDALG;qeltv| (QVELT |g| 2) 1 1 $)
                               (QREFELT $ 62)))
               (GO #7#))))
            (LETT |lst|
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (QVELT |f| 1) (QVELT |g| 1) (QREFELT $ 231))
                    (QREFELT $ 232))
                   (QREFELT $ 233)))
            (LETT |als|
                  (SPADCALL (+ (QVELT |f| 0) (QVELT |g| 0)) |lst|
                            (QREFELT $ 35)))
            (LETT |lp_f| (QVELT |f| 2)) (LETT |lp_g| (QVELT |g| 2))
            (LETT |lp_new| (QVELT |als| 2))
            (SEQ (LETT |k| 1) (LETT #4# (LENGTH (QVELT |f| 1))) G190
                 (COND ((|greater_SI| |k| #4#) (GO G191)))
                 (SEQ (LETT |mon| (SPADCALL (QVELT |f| 1) |k| (QREFELT $ 91)))
                      (LETT |pos|
                            (PROG1
                                (LETT #3#
                                      (SPADCALL |mon| |lst| (QREFELT $ 57)))
                              (|check_subtype2| (>= #3# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #3#)))
                      (|FDALG;qsetmtxA!| |lp_new| 1 (+ (QVELT |f| 0) 1) |pos|
                       (SPADCALL (|FDALG;qmtxv| |lp_f| 1 (QVELT |f| 0) |k| $)
                                 (QREFELT $ 235))
                       $)
                      (EXIT
                       (|FDALG;qsetmtxA!| |lp_new| 1 1 |pos|
                        (|FDALG;qmtxA| |lp_f| 1 (QVELT |f| 0) 1 (QVELT |f| 0)
                         |k| $)
                        $)))
                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
            (SEQ (LETT |k| 1) (LETT #2# (LENGTH (QVELT |g| 1))) G190
                 (COND ((|greater_SI| |k| #2#) (GO G191)))
                 (SEQ (LETT |mon| (SPADCALL (QVELT |g| 1) |k| (QREFELT $ 91)))
                      (LETT |pos|
                            (PROG1
                                (LETT #1#
                                      (SPADCALL |mon| |lst| (QREFELT $ 57)))
                              (|check_subtype2| (>= #1# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #1#)))
                      (|FDALG;qsetmtxv!| |lp_new| (+ (QVELT |f| 0) 1) |pos|
                       (|FDALG;qmtxv| |lp_g| 1 (QVELT |g| 0) |k| $) $)
                      (EXIT
                       (|FDALG;qsetmtxA!| |lp_new| (+ (QVELT |f| 0) 1)
                        (+ (QVELT |f| 0) 1) |pos|
                        (|FDALG;qmtxA| |lp_g| 1 (QVELT |g| 0) 1 (QVELT |g| 0)
                         |k| $)
                        $)))
                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
            (QSETVELT |als| 4 (COND ((QVELT |f| 4) (QVELT |g| 4)) ('T NIL)))
            (EXIT |als|)))
          #7# (EXIT #6#)))) 

(SDEFUN |FDALG;invertALS;2$;112| ((|f| ($)) ($ ($)))
        (SPROG
         ((#1=#:G1581 NIL) (|k| NIL) (|f_inv| ($))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |f_inv| (SPADCALL (+ |n| 1) (QVELT |f| 1) (QREFELT $ 35)))
              (|FDALG;qsetv!| (QVELT |f_inv| 2) (+ |n| 1) 1
               (|spadConstant| $ 15) $)
              (SPADCALL (QVELT |f_inv| 2) (+ |n| 2) 3 1
                        (SPADCALL (QVELT |f| 2) 1 1 2 (+ |n| 1) 1
                                  (QREFELT $ 20))
                        (QREFELT $ 22))
              (SPADCALL (QVELT |f_inv| 2) 2 2 1
                        (SPADCALL
                         (SPADCALL (QVELT |f| 2) 2 (+ |n| 1) 1 1 1
                                   (QREFELT $ 20))
                         (QREFELT $ 235))
                        (QREFELT $ 22))
              (SEQ (LETT |k| 1) (LETT #1# (LENGTH (QVELT |f_inv| 1))) G190
                   (COND ((|greater_SI| |k| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL (QVELT |f_inv| 2) 2 3 |k|
                               (SPADCALL (QVELT |f| 2) 2 (+ |n| 1) 2 (+ |n| 1)
                                         |k| (QREFELT $ 20))
                               (QREFELT $ 22))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (QSETVELT |f_inv| 4 NIL) (QSETVELT |f_inv| 3 NIL)
              (EXIT |f_inv|)))) 

(SDEFUN |FDALG;invertSTD;2$;113| ((|f| ($)) ($ ($)))
        (SPROG
         ((|blo_mtx| (|Matrix| (|NonNegativeInteger|))) (#1=#:G1587 NIL)
          (#2=#:G1586 NIL) (#3=#:G1594 NIL) (|k| NIL) (|U_wrk| #4=(|Matrix| F))
          (|T_wrk| #4#) (#5=#:G1593 NIL) (|f_inv| ($))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |f_inv| (SPADCALL (+ |n| 1) (QVELT |f| 1) (QREFELT $ 35)))
              (|FDALG;qsetv!| (QVELT |f_inv| 2) (+ |n| 1) 1
               (|spadConstant| $ 15) $)
              (SPADCALL (QVELT |f_inv| 2) (+ |n| 2) 3 1
                        (SPADCALL (QVELT |f| 2) 1 1 2 (+ |n| 1) 1
                                  (QREFELT $ 20))
                        (QREFELT $ 22))
              (SPADCALL (QVELT |f_inv| 2) 2 2 1
                        (SPADCALL
                         (SPADCALL (QVELT |f| 2) 2 (+ |n| 1) 1 1 1
                                   (QREFELT $ 20))
                         (QREFELT $ 235))
                        (QREFELT $ 22))
              (SEQ (LETT |k| 1) (LETT #5# (LENGTH (QVELT |f_inv| 1))) G190
                   (COND ((|greater_SI| |k| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL (QVELT |f_inv| 2) 2 3 |k|
                               (SPADCALL (QVELT |f| 2) 2 (+ |n| 1) 2 (+ |n| 1)
                                         |k| (QREFELT $ 20))
                               (QREFELT $ 22))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (LETT |T_wrk|
                    (MAKE_MATRIX1 (+ |n| 2) (+ |n| 2) (|spadConstant| $ 50)))
              (LETT |U_wrk|
                    (MAKE_MATRIX1 (+ |n| 2) (+ |n| 2) (|spadConstant| $ 50)))
              (QSETAREF2O |T_wrk| 1 1 (|spadConstant| $ 15) 1 1)
              (QSETAREF2O |T_wrk| (+ |n| 2) (+ |n| 2) (|spadConstant| $ 15) 1
                          1)
              (QSETAREF2O |U_wrk| 1 1 (|spadConstant| $ 15) 1 1)
              (QSETAREF2O |U_wrk| 2 2 (|spadConstant| $ 15) 1 1)
              (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                   (SEQ
                    (QSETAREF2O |T_wrk| (+ |k| 1)
                                (PROG1 (LETT #2# (- (+ |n| 2) |k|))
                                  (|check_subtype2| (>= #2# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #2#))
                                (SPADCALL (|spadConstant| $ 15) (QREFELT $ 58))
                                1 1)
                    (EXIT
                     (QSETAREF2O |U_wrk| (+ |k| 2)
                                 (PROG1 (LETT #1# (- (+ |n| 3) |k|))
                                   (|check_subtype2| (>= #1# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #1#))
                                 (|spadConstant| $ 15) 1 1)))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (SPADCALL (QVELT |f_inv| 2) |T_wrk| (QREFELT $ 206))
              (SPADCALL (QVELT |f_inv| 2) |U_wrk| (QREFELT $ 208))
              (LETT |blo_mtx| (SPADCALL |f_inv| (QREFELT $ 153)))
              (QSETVELT |f_inv| 3 NIL) (QSETVELT |f_inv| 4 NIL)
              (COND
               ((EQL (SPADCALL |blo_mtx| (QREFELT $ 154)) (QVELT |f_inv| 0))
                (QSETVELT |f_inv| 4 'T)))
              (EXIT |f_inv|)))) 

(SDEFUN |FDALG;factors;$L;114| ((|f| ($)) ($ (|List| $)))
        (SPROG
         ((|lst_fct| (|List| $)) (|n| (|NonNegativeInteger|)) (|als| ($))
          (#1=#:G1629 NIL) (|l| NIL) (|f_2| ($)) (|f_1| ($)) (#2=#:G1628 NIL)
          (#3=#:G1627 NIL) (|flg_01| #4=(|Boolean|)) (#5=#:G1604 NIL)
          (|flg_10| #4#) (|flg_00| #4#) (|flg_uv| (|Boolean|))
          (|flg_uc| (|Boolean|)) (|flg_ur| #4#) (|n_2| (|NonNegativeInteger|))
          (#6=#:G1601 NIL) (|n_1| (|NonNegativeInteger|)) (|k| NIL)
          (#7=#:G1599 NIL) (#8=#:G1626 NIL) (|m| (|NonNegativeInteger|))
          (|blo_mtx| (|Matrix| (|NonNegativeInteger|))))
         (SEQ
          (EXIT
           (SEQ (LETT |lst_fct| NIL) (LETT |als| (SPADCALL |f| (QREFELT $ 51)))
                (LETT |blo_mtx| (SPADCALL |als| (QREFELT $ 153)))
                (LETT |m| (SPADCALL |blo_mtx| (QREFELT $ 154)))
                (COND
                 ((EQL |m| 1)
                  (SEQ
                   (LETT |lst_fct| (SPADCALL |als| |lst_fct| (QREFELT $ 240)))
                   (EXIT (PROGN (LETT #8# |lst_fct|) (GO #9=#:G1625))))))
                (LETT |n| (QVELT |als| 0))
                (SEQ
                 (LETT |k|
                       (PROG1 (LETT #7# (- |m| 1))
                         (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #7#)))
                 G190 (COND ((< |k| 1) (GO G191)))
                 (SEQ (LETT |n_1| (SPADCALL |blo_mtx| |k| 2 (QREFELT $ 184)))
                      (LETT |n_2|
                            (PROG1 (LETT #6# (- |n| |n_1|))
                              (|check_subtype2| (>= #6# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #6#)))
                      (LETT |flg_ur| 'T)
                      (COND
                       ((< (+ |n_1| 1) |n|)
                        (LETT |flg_ur|
                              (SPADCALL |als| 1 |n_1| (+ |n_1| 2) |n|
                                        (QREFELT $ 146)))))
                      (LETT |flg_uc|
                            (|FDALG;qsemizeroA?| (QVELT |als| 2) 1 |n_1|
                             (+ |n_1| 1) (+ |n_1| 1) 1 $))
                      (LETT |flg_uv|
                            (|FDALG;qzerov?| (QVELT |als| 2) 1 |n_1| $))
                      (LETT |flg_00| NIL) (LETT |flg_10| NIL)
                      (LETT |flg_01| NIL)
                      (COND
                       (|flg_ur|
                        (COND
                         (|flg_uv|
                          (SEQ (COND (|flg_uc| (LETT |flg_00| 'T)))
                               (COND
                                ((NULL |flg_00|)
                                 (COND
                                  ((NULL
                                    (|FDALG;qsemizeroA?| (QVELT |als| 2)
                                     (+ |n_1| 1) |n| (+ |n_1| 1) |n| 1 $))
                                   (LETT |flg_10| 'T)))))
                               (EXIT
                                (COND
                                 ((NULL |flg_00|)
                                  (COND
                                   ((NULL |flg_10|)
                                    (COND
                                     ((> |n_1| 1)
                                      (COND
                                       ((SPADCALL |als| 1
                                                  (PROG1 (LETT #5# (- |n_1| 1))
                                                    (|check_subtype2|
                                                     (>= #5# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #5#))
                                                  (+ |n_1| 1) (+ |n_1| 1)
                                                  (QREFELT $ 146))
                                        (LETT |flg_01| 'T)))))))))))))))
                      (COND
                       (|flg_00|
                        (SEQ
                         (LETT |f_1|
                               (SPADCALL |n_1| (QVELT |als| 1) (QREFELT $ 35)))
                         (LETT |f_2|
                               (SPADCALL |n_2| (QVELT |als| 1) (QREFELT $ 35)))
                         (SEQ (LETT |l| 1) (LETT #3# (LENGTH (QVELT |als| 1)))
                              G190 (COND ((|greater_SI| |l| #3#) (GO G191)))
                              (SEQ
                               (|FDALG;qsetmtxA!| (QVELT |f_1| 2) 1 1 |l|
                                (|FDALG;qmtxA| (QVELT |als| 2) 1 |n_1| 1 |n_1|
                                 |l| $)
                                $)
                               (EXIT
                                (|FDALG;qsetmtxA!| (QVELT |f_2| 2) 1 1 |l|
                                 (|FDALG;qmtxA| (QVELT |als| 2) (+ |n_1| 1) |n|
                                  (+ |n_1| 1) |n| |l| $)
                                 $)))
                              (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                              (EXIT NIL))
                         (|FDALG;qsetmtxv!| (QVELT |f_1| 2) 1 1
                          (SPADCALL
                           (|FDALG;qmtxA| (QVELT |als| 2) 1 |n_1| (+ |n_1| 1)
                            (+ |n_1| 1) 1 $)
                           (QREFELT $ 235))
                          $)
                         (EXIT
                          (|FDALG;qsetmtxv!| (QVELT |f_2| 2) 1 1
                           (|FDALG;qmtxv| (QVELT |als| 2) (+ |n_1| 1) |n| 1 $)
                           $)))))
                      (COND
                       (|flg_01|
                        (SEQ
                         (LETT |f_1|
                               (SPADCALL |n_1| (QVELT |als| 1) (QREFELT $ 35)))
                         (LETT |f_2|
                               (SPADCALL (+ |n_2| 1) (QVELT |als| 1)
                                         (QREFELT $ 35)))
                         (SEQ (LETT |l| 1) (LETT #2# (LENGTH (QVELT |als| 1)))
                              G190 (COND ((|greater_SI| |l| #2#) (GO G191)))
                              (SEQ
                               (|FDALG;qsetmtxA!| (QVELT |f_1| 2) 1 1 |l|
                                (|FDALG;qmtxA| (QVELT |als| 2) 1 |n_1| 1 |n_1|
                                 |l| $)
                                $)
                               (EXIT
                                (|FDALG;qsetmtxA!| (QVELT |f_2| 2) 1 2 |l|
                                 (|FDALG;qmtxA| (QVELT |als| 2) |n_1| |n|
                                  (+ |n_1| 1) |n| |l| $)
                                 $)))
                              (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                              (EXIT NIL))
                         (|FDALG;qsetA!| (QVELT |f_2| 2) 1 1 1
                          (|spadConstant| $ 15) $)
                         (|FDALG;qsetv!| (QVELT |f_1| 2) |n_1| 1
                          (|spadConstant| $ 15) $)
                         (EXIT
                          (|FDALG;qsetmtxv!| (QVELT |f_2| 2) 1 1
                           (|FDALG;qmtxv| (QVELT |als| 2) |n_1| |n| 1 $) $)))))
                      (COND
                       (|flg_10|
                        (SEQ
                         (LETT |f_1|
                               (SPADCALL (+ |n_1| 1) (QVELT |als| 1)
                                         (QREFELT $ 35)))
                         (LETT |f_2|
                               (SPADCALL |n_2| (QVELT |als| 1) (QREFELT $ 35)))
                         (SEQ (LETT |l| 1) (LETT #1# (LENGTH (QVELT |als| 1)))
                              G190 (COND ((|greater_SI| |l| #1#) (GO G191)))
                              (SEQ
                               (|FDALG;qsetmtxA!| (QVELT |f_1| 2) 1 1 |l|
                                (|FDALG;qmtxA| (QVELT |als| 2) 1 |n_1| 1
                                 (+ |n_1| 1) |l| $)
                                $)
                               (EXIT
                                (|FDALG;qsetmtxA!| (QVELT |f_2| 2) 1 1 |l|
                                 (|FDALG;qmtxA| (QVELT |als| 2) (+ |n_1| 1) |n|
                                  (+ |n_1| 1) |n| |l| $)
                                 $)))
                              (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                              (EXIT NIL))
                         (|FDALG;qsetA!| (QVELT |f_1| 2) (+ |n_1| 1)
                          (+ |n_1| 1) 1 (|spadConstant| $ 15) $)
                         (|FDALG;qsetv!| (QVELT |f_1| 2) (+ |n_1| 1) 1
                          (|spadConstant| $ 15) $)
                         (EXIT
                          (|FDALG;qsetmtxv!| (QVELT |f_2| 2) 1 1
                           (|FDALG;qmtxv| (QVELT |als| 2) (+ |n_1| 1) |n| 1 $)
                           $)))))
                      (EXIT
                       (COND
                        ((OR (OR |flg_00| |flg_01|) |flg_10|)
                         (SEQ (QSETVELT |f_2| 4 (QVELT |f| 4))
                              (QSETVELT |f_2| 3 (QVELT |f| 3))
                              (LETT |lst_fct|
                                    (SPADCALL |f_2| |lst_fct| (QREFELT $ 240)))
                              (LETT |als| |f_1|)
                              (EXIT (LETT |n| (QVELT |als| 0))))))))
                 (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                (QSETVELT |als| 4 (QVELT |f| 4))
                (QSETVELT |als| 3 (QVELT |f| 3))
                (LETT |lst_fct| (SPADCALL |als| |lst_fct| (QREFELT $ 240)))
                (EXIT |lst_fct|)))
          #9# (EXIT #8#)))) 

(SDEFUN |FDALG;summands;$L;115| ((|f| ($)) ($ (|List| $)))
        (SPROG
         ((|lst_sum| (|List| $)) (|n| (|NonNegativeInteger|)) (|als| ($))
          (|u_tmp| (F)) (#1=#:G1663 NIL) (|j| NIL) (|f_2| ($)) (#2=#:G1659 NIL)
          (|idx_u| (|NonNegativeInteger|)) (|u_wrk| (F)) (#3=#:G1662 NIL)
          (#4=#:G1661 NIL) (|l| NIL) (|f_1| ($))
          (|trn_wrk| (|List| (|Matrix| F)))
          (|lst_4| #5=(|List| (|NonNegativeInteger|))) (|lst_3| #5#)
          (|lst_2| #5#) (|lst_1| #5#) (|n_2| (|NonNegativeInteger|))
          (#6=#:G1636 NIL) (|n_1| (|NonNegativeInteger|)) (|k| NIL)
          (#7=#:G1634 NIL) (#8=#:G1660 NIL) (|m| (|NonNegativeInteger|))
          (|blo_mtx| (|Matrix| (|NonNegativeInteger|))))
         (SEQ
          (EXIT
           (SEQ (LETT |lst_sum| NIL) (LETT |als| (SPADCALL |f| (QREFELT $ 51)))
                (LETT |blo_mtx| (SPADCALL |als| (QREFELT $ 153)))
                (LETT |m| (SPADCALL |blo_mtx| (QREFELT $ 154)))
                (COND
                 ((EQL |m| 1)
                  (SEQ
                   (LETT |lst_sum| (SPADCALL |als| |lst_sum| (QREFELT $ 240)))
                   (EXIT (PROGN (LETT #8# |lst_sum|) (GO #9=#:G1658))))))
                (LETT |n| (QVELT |als| 0))
                (SEQ
                 (LETT |k|
                       (PROG1 (LETT #7# (- |m| 1))
                         (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #7#)))
                 G190 (COND ((< |k| 1) (GO G191)))
                 (SEQ (LETT |n_1| (SPADCALL |blo_mtx| |k| 2 (QREFELT $ 184)))
                      (LETT |n_2|
                            (PROG1 (LETT #6# (- |n| |n_1|))
                              (|check_subtype2| (>= #6# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #6#)))
                      (LETT |lst_1| (SPADCALL (+ |n_1| 1) |n| (QREFELT $ 28)))
                      (LETT |lst_2| (SPADCALL 1 |n_1| (QREFELT $ 28)))
                      (LETT |lst_3| (SPADCALL 1 |n_1| (QREFELT $ 28)))
                      (LETT |lst_4| (SPADCALL (+ |n_1| 1) |n| (QREFELT $ 28)))
                      (LETT |trn_wrk|
                            (|FDALG;qblockElimination| |als| |lst_1| |lst_2|
                             NIL |lst_3| |lst_4| NIL $))
                      (EXIT
                       (COND
                        ((> (LENGTH |trn_wrk|) 0)
                         (SEQ
                          (SPADCALL (QVELT |als| 2)
                                    (SPADCALL |trn_wrk| 1 (QREFELT $ 162))
                                    (QREFELT $ 206))
                          (SPADCALL (QVELT |als| 2)
                                    (SPADCALL |trn_wrk| 2 (QREFELT $ 162))
                                    (QREFELT $ 208))
                          (LETT |f_1|
                                (SPADCALL |n_1| (QVELT |als| 1)
                                          (QREFELT $ 35)))
                          (LETT |f_2|
                                (SPADCALL |n_2| (QVELT |als| 1)
                                          (QREFELT $ 35)))
                          (SEQ (LETT |l| 1) (LETT #4# (LENGTH (QVELT |als| 1)))
                               G190 (COND ((|greater_SI| |l| #4#) (GO G191)))
                               (SEQ
                                (|FDALG;qsetmtxA!| (QVELT |f_1| 2) 1 1 |l|
                                 (|FDALG;qmtxA| (QVELT |als| 2) 1 |n_1| 1 |n_1|
                                  |l| $)
                                 $)
                                (EXIT
                                 (|FDALG;qsetmtxA!| (QVELT |f_2| 2) 1 1 |l|
                                  (|FDALG;qmtxA| (QVELT |als| 2) (+ |n_1| 1)
                                   |n| (+ |n_1| 1) |n| |l| $)
                                  $)))
                               (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                               (EXIT NIL))
                          (|FDALG;qsetmtxv!| (QVELT |f_1| 2) 1 1
                           (|FDALG;qmtxv| (QVELT |als| 2) 1 |n_1| 1 $) $)
                          (|FDALG;qsetmtxv!| (QVELT |f_2| 2) 1 1
                           (|FDALG;qmtxv| (QVELT |als| 2) (+ |n_1| 1) |n| 1 $)
                           $)
                          (|FDALG;qsetmtxu!| (QVELT |f_2| 2) 1 1
                           (|FDALG;qmtxu| (QVELT |als| 2) (+ |n_1| 1) |n| 1 $)
                           $)
                          (LETT |idx_u| 0) (LETT |u_wrk| (|spadConstant| $ 50))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |j| 1) (LETT #3# (QVELT |f_2| 0)) G190
                                 (COND ((|greater_SI| |j| #3#) (GO G191)))
                                 (SEQ
                                  (LETT |u_wrk|
                                        (|FDALG;qeltu| (QVELT |f_2| 2) |j| 1
                                         $))
                                  (EXIT
                                   (COND
                                    ((NULL (SPADCALL |u_wrk| (QREFELT $ 48)))
                                     (SEQ (LETT |idx_u| |j|)
                                          (EXIT
                                           (PROGN
                                            (LETT #2# 1)
                                            (GO #10=#:G1643))))))))
                                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                 (EXIT NIL)))
                           #10# (EXIT #2#))
                          (COND
                           ((SPADCALL |u_wrk| (QREFELT $ 48))
                            (LETT |f_2|
                                  (SPADCALL (|spadConstant| $ 49)
                                            (QREFELT $ 51))))
                           ('T
                            (SEQ
                             (COND
                              ((SPADCALL |idx_u| 1 (QREFELT $ 39))
                               (SPADCALL (QVELT |f_2| 2) (+ 1 1) (+ 1 |idx_u|)
                                         (QREFELT $ 128))))
                             (COND
                              ((NULL
                                (SPADCALL |u_wrk| (|spadConstant| $ 15)
                                          (QREFELT $ 76)))
                               (SEQ
                                (SPADCALL (QVELT |f_2| 2) (+ 1 1)
                                          (SPADCALL (|spadConstant| $ 15)
                                                    |u_wrk| (QREFELT $ 209))
                                          (QREFELT $ 126))
                                (EXIT
                                 (SEQ (LETT |j| 2) (LETT #1# |n_2|) G190
                                      (COND ((|greater_SI| |j| #1#) (GO G191)))
                                      (SEQ
                                       (LETT |u_tmp|
                                             (|FDALG;qeltu| (QVELT |f_2| 2) |j|
                                              1 $))
                                       (EXIT
                                        (COND
                                         ((NULL
                                           (SPADCALL |u_tmp| (QREFELT $ 48)))
                                          (SPADCALL (QVELT |f_2| 2) (+ 1 1)
                                                    (+ |j| 1)
                                                    (SPADCALL |u_tmp|
                                                              (QREFELT $ 58))
                                                    (QREFELT $ 119))))))
                                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                      (EXIT NIL))))))
                             (SPADCALL |f_2| (QREFELT $ 213))
                             (QSETVELT |f_2| 4 (QVELT |f| 4))
                             (EXIT (QSETVELT |f_2| 3 (QVELT |f| 3))))))
                          (LETT |lst_sum|
                                (SPADCALL |f_2| |lst_sum| (QREFELT $ 240)))
                          (LETT |als| |f_1|)
                          (EXIT (LETT |n| (QVELT |als| 0))))))))
                 (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((> (SPADCALL |lst_sum| (QREFELT $ 243)) 0)
                  (SEQ (SPADCALL |f_1| (QREFELT $ 213))
                       (QSETVELT |f_1| 4 (QVELT |f| 4))
                       (QSETVELT |f_1| 3 (QVELT |f| 3))
                       (EXIT
                        (LETT |lst_sum|
                              (SPADCALL |f_1| |lst_sum| (QREFELT $ 240))))))
                 ('T
                  (LETT |lst_sum|
                        (SPADCALL (SPADCALL |f| (QREFELT $ 51)) |lst_sum|
                                  (QREFELT $ 240)))))
                (EXIT |lst_sum|)))
          #9# (EXIT #8#)))) 

(SDEFUN |FDALG;ratexprPolynomial|
        ((|p| (|XDistributedPolynomial| VAR F)) ($ (|OutputForm|)))
        (SPROG
         ((|out_wrk| (|OutputForm|)) (|sup_wrk| (|List| (|FreeMonoid| VAR))))
         (SEQ (LETT |sup_wrk| (SPADCALL |p| (QREFELT $ 245)))
              (LETT |out_wrk| (SPADCALL |p| (QREFELT $ 187)))
              (COND
               ((OR (> (LENGTH |sup_wrk|) 1)
                    (OR (> (SPADCALL (|SPADfirst| |sup_wrk|) (QREFELT $ 36)) 1)
                        (SPADCALL (SPADCALL |p| (QREFELT $ 247))
                                  (|spadConstant| $ 15) (QREFELT $ 248))))
                (LETT |out_wrk| (SPADCALL |out_wrk| (QREFELT $ 246)))))
              (EXIT |out_wrk|)))) 

(SDEFUN |FDALG;leftFamily;$L;117| ((|f| ($)) ($ (|List| (|OutputForm|))))
        (SPROG
         ((#1=#:G1695 NIL) (|flg_wrk| (|Boolean|)) (|j| (|NonNegativeInteger|))
          (|i| NIL) (|s_lst| (|List| (|OutputForm|))) (#2=#:G1694 NIL)
          (#3=#:G1693 NIL) (|p_wrk| (|List| (|XDistributedPolynomial| VAR F)))
          (|a_idx| (|List| (|List| (|NonNegativeInteger|))))
          (|n| (|NonNegativeInteger|))
          (|blo_mtx| (|Matrix| (|NonNegativeInteger|))))
         (SEQ (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153)))
              (LETT |n| (QVELT |f| 0))
              (EXIT
               (COND
                ((< (SPADCALL |blo_mtx| (QREFELT $ 154)) |n|)
                 (|error| "FDALG: leftFamily(%) - not upper triangular."))
                ('T
                 (SEQ (LETT |a_idx| (SPADCALL |n| NIL (QREFELT $ 250)))
                      (LETT |p_wrk|
                            (SPADCALL |n| (|spadConstant| $ 90)
                                      (QREFELT $ 252)))
                      (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                           (COND ((|greater_SI| |i| #3#) (GO G191)))
                           (SEQ
                            (SPADCALL |p_wrk| |i|
                                      (SPADCALL |f| |i| |i| (QREFELT $ 96))
                                      (QREFELT $ 253))
                            (SPADCALL |p_wrk| |i|
                                      (SPADCALL |p_wrk| |i| (QREFELT $ 254))
                                      (QREFELT $ 253))
                            (EXIT
                             (SEQ (LETT |j| (+ |i| 1)) (LETT #2# |n|) G190
                                  (COND ((> |j| #2#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((NULL
                                       (|FDALG;qzeroA?| (QVELT |f| 2) |i| |j|
                                        $))
                                      (SPADCALL |a_idx| |i|
                                                (CONS |j|
                                                      (SPADCALL |a_idx| |i|
                                                                (QREFELT $
                                                                         255)))
                                                (QREFELT $ 256))))))
                                  (LETT |j| (+ |j| 1)) (GO G190) G191
                                  (EXIT NIL))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (LETT |s_lst|
                            (SPADCALL |n| (SPADCALL 0 (QREFELT $ 257))
                                      (QREFELT $ 186)))
                      (SEQ (LETT |i| |n|) G190 (COND ((< |i| 1) (GO G191)))
                           (SEQ (LETT |flg_wrk| NIL)
                                (SPADCALL |s_lst| |i|
                                          (SPADCALL
                                           (|FDALG;qeltv| (QVELT |f| 2) |i| 1
                                            $)
                                           (QREFELT $ 258))
                                          (QREFELT $ 259))
                                (COND
                                 ((< |i| |n|)
                                  (COND
                                   ((NULL
                                     (SPADCALL
                                      (|FDALG;qeltv| (QVELT |f| 2) |i| 1 $)
                                      (QREFELT $ 48)))
                                    (LETT |flg_wrk| 'T)))))
                                (COND
                                 ((>
                                   (SPADCALL
                                    (SPADCALL |a_idx| |i| (QREFELT $ 255))
                                    (QREFELT $ 140))
                                   0)
                                  (SEQ
                                   (LETT |j|
                                         (|SPADfirst|
                                          (SPADCALL |a_idx| |i|
                                                    (QREFELT $ 255))))
                                   (COND
                                    ((EQL |j| |n|)
                                     (COND
                                      ((SPADCALL
                                        (SPADCALL |p_wrk| |j| (QREFELT $ 254))
                                        (|spadConstant| $ 215) (QREFELT $ 260))
                                       (COND
                                        (|flg_wrk|
                                         (SPADCALL |s_lst| |i|
                                                   (SPADCALL
                                                    (SPADCALL |s_lst| |i|
                                                              (QREFELT $ 261))
                                                    (|FDALG;ratexprPolynomial|
                                                     (SPADCALL
                                                      (SPADCALL |f| |i| |j|
                                                                (QREFELT $ 96))
                                                      (QREFELT $ 190))
                                                     $)
                                                    (QREFELT $ 262))
                                                   (QREFELT $ 259)))
                                        ('T
                                         (SEQ
                                          (SPADCALL |s_lst| |i|
                                                    (|FDALG;ratexprPolynomial|
                                                     (SPADCALL
                                                      (SPADCALL |f| |i| |j|
                                                                (QREFELT $ 96))
                                                      (QREFELT $ 190))
                                                     $)
                                                    (QREFELT $ 259))
                                          (EXIT (LETT |flg_wrk| 'T))))))
                                      (|flg_wrk|
                                       (SPADCALL |s_lst| |i|
                                                 (SPADCALL
                                                  (SPADCALL |s_lst| |i|
                                                            (QREFELT $ 261))
                                                  (SPADCALL
                                                   (|FDALG;ratexprPolynomial|
                                                    (SPADCALL
                                                     (SPADCALL |f| |i| |j|
                                                               (QREFELT $ 96))
                                                     (QREFELT $ 190))
                                                    $)
                                                   (SPADCALL |s_lst| |j|
                                                             (QREFELT $ 261))
                                                   (QREFELT $ 182))
                                                  (QREFELT $ 262))
                                                 (QREFELT $ 259)))
                                      ('T
                                       (SEQ
                                        (SPADCALL |s_lst| |i|
                                                  (SPADCALL
                                                   (|FDALG;ratexprPolynomial|
                                                    (SPADCALL
                                                     (SPADCALL |f| |i| |j|
                                                               (QREFELT $ 96))
                                                     (QREFELT $ 190))
                                                    $)
                                                   (SPADCALL |s_lst| |j|
                                                             (QREFELT $ 261))
                                                   (QREFELT $ 182))
                                                  (QREFELT $ 259))
                                        (EXIT (LETT |flg_wrk| 'T))))))
                                    (|flg_wrk|
                                     (SPADCALL |s_lst| |i|
                                               (SPADCALL
                                                (SPADCALL |s_lst| |i|
                                                          (QREFELT $ 261))
                                                (SPADCALL
                                                 (|FDALG;ratexprPolynomial|
                                                  (SPADCALL
                                                   (SPADCALL |f| |i| |j|
                                                             (QREFELT $ 96))
                                                   (QREFELT $ 190))
                                                  $)
                                                 (SPADCALL |s_lst| |j|
                                                           (QREFELT $ 261))
                                                 (QREFELT $ 182))
                                                (QREFELT $ 262))
                                               (QREFELT $ 259)))
                                    ('T
                                     (SEQ
                                      (SPADCALL |s_lst| |i|
                                                (SPADCALL
                                                 (|FDALG;ratexprPolynomial|
                                                  (SPADCALL
                                                   (SPADCALL |f| |i| |j|
                                                             (QREFELT $ 96))
                                                   (QREFELT $ 190))
                                                  $)
                                                 (SPADCALL |s_lst| |j|
                                                           (QREFELT $ 261))
                                                 (QREFELT $ 182))
                                                (QREFELT $ 259))
                                      (EXIT (LETT |flg_wrk| 'T)))))
                                   (EXIT
                                    (SEQ
                                     (LETT #1#
                                           (CDR
                                            (SPADCALL |a_idx| |i|
                                                      (QREFELT $ 255))))
                                     G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |j| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (SPADCALL |s_lst| |i|
                                                 (SPADCALL
                                                  (SPADCALL |s_lst| |i|
                                                            (QREFELT $ 261))
                                                  (SPADCALL
                                                   (|FDALG;ratexprPolynomial|
                                                    (SPADCALL
                                                     (SPADCALL |f| |i| |j|
                                                               (QREFELT $ 96))
                                                     (QREFELT $ 190))
                                                    $)
                                                   (SPADCALL |s_lst| |j|
                                                             (QREFELT $ 261))
                                                   (QREFELT $ 182))
                                                  (QREFELT $ 262))
                                                 (QREFELT $ 259))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT NIL))))))
                                (COND
                                 ((NULL
                                   (SPADCALL
                                    (SPADCALL |p_wrk| |i| (QREFELT $ 254))
                                    (|spadConstant| $ 215) (QREFELT $ 260)))
                                  (SPADCALL |s_lst| |i|
                                            (SPADCALL
                                             (SPADCALL
                                              (|FDALG;ratexprPolynomial|
                                               (SPADCALL |p_wrk| |i|
                                                         (QREFELT $ 254))
                                               $)
                                              (SPADCALL -1 (QREFELT $ 257))
                                              (QREFELT $ 263))
                                             (SPADCALL |s_lst| |i|
                                                       (QREFELT $ 261))
                                             (QREFELT $ 182))
                                            (QREFELT $ 259))))
                                (EXIT
                                 (COND
                                  ((> |i| 1)
                                   (COND
                                    ((< |i| |n|)
                                     (SPADCALL |s_lst| |i|
                                               (SPADCALL
                                                (SPADCALL |s_lst| |i|
                                                          (QREFELT $ 261))
                                                (QREFELT $ 246))
                                               (QREFELT $ 259))))))))
                           (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                      (EXIT |s_lst|)))))))) 

(SDEFUN |FDALG;ratexprInverse;$BOf;118|
        ((|f| ($)) (|flg| (|Boolean|)) ($ (|OutputForm|)))
        (SPROG
         ((|o_wrk| (|OutputForm|)) (#1=#:G1717 NIL) (|g| NIL) (#2=#:G1716 NIL)
          (|sym_r| (|OutputForm|)) (|sym_d| (|OutputForm|))
          (|sum_f| (|List| $)) (|s_wrk| (|List| (|FreeMonoid| VAR)))
          (|p_wrk| (|XDistributedPolynomial| VAR F)) (|f_wrk| ($)))
         (SEQ
          (EXIT
           (SEQ (LETT |f_wrk| (SPADCALL |f| (QREFELT $ 51)))
                (SPADCALL |f_wrk| (QREFELT $ 211))
                (SPADCALL |f_wrk| (QREFELT $ 210))
                (COND
                 ((|FDALG;polynomialForm?| |f_wrk| $)
                  (SEQ (LETT |p_wrk| (SPADCALL |f_wrk| (QREFELT $ 217)))
                       (LETT |s_wrk| (SPADCALL |p_wrk| (QREFELT $ 245)))
                       (COND
                        ((EQL (LENGTH |s_wrk|) 1)
                         (COND
                          ((<= (SPADCALL (|SPADfirst| |s_wrk|) (QREFELT $ 36))
                               1)
                           (COND
                            ((SPADCALL (SPADCALL |p_wrk| (QREFELT $ 247))
                                       (|spadConstant| $ 15) (QREFELT $ 76))
                             (PROGN
                              (LETT #2# (SPADCALL |p_wrk| (QREFELT $ 187)))
                              (GO #3=#:G1715))))))))
                       (COND
                        (|flg|
                         (PROGN
                          (LETT #2#
                                (SPADCALL (SPADCALL |p_wrk| (QREFELT $ 187))
                                          (QREFELT $ 246)))
                          (GO #3#))))
                       (EXIT
                        (PROGN
                         (LETT #2# (SPADCALL |p_wrk| (QREFELT $ 187)))
                         (GO #3#))))))
                (LETT |f_wrk| (SPADCALL |f| (QREFELT $ 265)))
                (SPADCALL |f_wrk| (QREFELT $ 211))
                (SPADCALL |f_wrk| (QREFELT $ 210))
                (COND
                 ((|FDALG;polynomialForm?| |f_wrk| $)
                  (SEQ (LETT |p_wrk| (SPADCALL |f_wrk| (QREFELT $ 217)))
                       (LETT |s_wrk| (SPADCALL |p_wrk| (QREFELT $ 245)))
                       (COND
                        ((EQL (LENGTH (SPADCALL |p_wrk| (QREFELT $ 245))) 1)
                         (COND
                          ((<= (SPADCALL (|SPADfirst| |s_wrk|) (QREFELT $ 36))
                               1)
                           (COND
                            ((SPADCALL (SPADCALL |p_wrk| (QREFELT $ 247))
                                       (|spadConstant| $ 15) (QREFELT $ 76))
                             (PROGN
                              (LETT #2#
                                    (SPADCALL
                                     (SPADCALL |p_wrk| (QREFELT $ 187))
                                     (SPADCALL -1 (QREFELT $ 257))
                                     (QREFELT $ 263)))
                              (GO #3#))))))))
                       (EXIT
                        (PROGN
                         (LETT #2#
                               (SPADCALL
                                (SPADCALL (SPADCALL |p_wrk| (QREFELT $ 187))
                                          (QREFELT $ 246))
                                (SPADCALL -1 (QREFELT $ 257)) (QREFELT $ 263)))
                         (GO #3#))))))
                (LETT |sum_f| NIL)
                (LETT |sum_f| (SPADCALL |f| |sum_f| (QREFELT $ 240)))
                (LETT |sum_f| (SPADCALL |f| (QREFELT $ 244)))
                (COND
                 ((EQL (SPADCALL |sum_f| (QREFELT $ 243)) 1)
                  (SEQ
                   (COND
                    ((EQL
                      (SPADCALL (SPADCALL |f| (QREFELT $ 153)) (QREFELT $ 154))
                      (QVELT |f| 0))
                     (SEQ
                      (LETT |o_wrk|
                            (|SPADfirst| (SPADCALL |f| (QREFELT $ 264))))
                      (COND
                       (|flg|
                        (LETT |o_wrk| (SPADCALL |o_wrk| (QREFELT $ 246)))))
                      (EXIT (PROGN (LETT #2# |o_wrk|) (GO #3#))))))
                   (LETT |sym_d| (SPADCALL '|d| (QREFELT $ 172)))
                   (LETT |sym_r| (SPADCALL '|r| (QREFELT $ 172)))
                   (LETT |o_wrk|
                         (COND ((SPADCALL |f| (QREFELT $ 71)) |sym_r|)
                               ('T |sym_d|)))
                   (LETT |o_wrk|
                         (SPADCALL
                          (SPADCALL |o_wrk|
                                    (SPADCALL (QVELT |f| 0) (QREFELT $ 173))
                                    (QREFELT $ 266))
                          (QREFELT $ 246)))
                   (EXIT (PROGN (LETT #2# |o_wrk|) (GO #3#))))))
                (LETT |o_wrk|
                      (SPADCALL (SPADCALL |sum_f| (QREFELT $ 267)) NIL
                                (QREFELT $ 268)))
                (SEQ (LETT |g| NIL)
                     (LETT #1# (SPADCALL |sum_f| (QREFELT $ 269))) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |g| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |o_wrk|
                             (SPADCALL |o_wrk|
                                       (SPADCALL |g| NIL (QREFELT $ 268))
                                       (QREFELT $ 262)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (COND
                 (|flg| (LETT |o_wrk| (SPADCALL |o_wrk| (QREFELT $ 246)))))
                (EXIT |o_wrk|)))
          #3# (EXIT #2#)))) 

(SDEFUN |FDALG;ratexpr;$Of;119| ((|f| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|out_of| (|OutputForm|)) (#1=#:G1728 NIL) (#2=#:G1730 NIL)
          (|sum| NIL) (#3=#:G1729 NIL) (|fct| NIL) (|sum_f| (|List| $))
          (|fct_f| (|List| $)))
         (SEQ
          (EXIT
           (SEQ (LETT |fct_f| (SPADCALL |f| (QREFELT $ 242)))
                (LETT |sum_f| (SPADCALL |f| (QREFELT $ 244)))
                (COND
                 ((> (SPADCALL |fct_f| (QREFELT $ 243)) 1)
                  (SEQ
                   (LETT |out_of|
                         (SPADCALL (SPADCALL |fct_f| (QREFELT $ 267)) 'T
                                   (QREFELT $ 268)))
                   (SEQ (LETT |fct| NIL)
                        (LETT #3# (SPADCALL |fct_f| (QREFELT $ 269))) G190
                        (COND
                         ((OR (ATOM #3#) (PROGN (LETT |fct| (CAR #3#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT |out_of|
                                (SPADCALL |out_of|
                                          (SPADCALL |fct| 'T (QREFELT $ 268))
                                          (QREFELT $ 182)))))
                        (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                   (EXIT (PROGN (LETT #1# |out_of|) (GO #4=#:G1727))))))
                (COND
                 ((> (SPADCALL |sum_f| (QREFELT $ 243)) 1)
                  (SEQ
                   (LETT |out_of|
                         (SPADCALL (SPADCALL |sum_f| (QREFELT $ 267)) 'T
                                   (QREFELT $ 268)))
                   (SEQ (LETT |sum| NIL)
                        (LETT #2# (SPADCALL |sum_f| (QREFELT $ 269))) G190
                        (COND
                         ((OR (ATOM #2#) (PROGN (LETT |sum| (CAR #2#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT |out_of|
                                (SPADCALL |out_of|
                                          (SPADCALL |sum| NIL (QREFELT $ 268))
                                          (QREFELT $ 262)))))
                        (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                   (EXIT (PROGN (LETT #1# |out_of|) (GO #4#))))))
                (LETT |out_of|
                      (SPADCALL (SPADCALL |fct_f| (QREFELT $ 267)) NIL
                                (QREFELT $ 268)))
                (EXIT |out_of|)))
          #4# (EXIT #1#)))) 

(SDEFUN |FDALG;coerce;$Of;120| ((|f| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|lst_of| (|List| (|OutputForm|))) (|rex_of| (|OutputForm|))
          (|flg_of| (|OutputForm|)) (|sym_R| (|OutputForm|))
          (|sym_M| (|OutputForm|)) (|sym| (|OutputForm|)))
         (SEQ (LETT |lst_of| NIL)
              (COND
               ((QVELT |f| 7)
                (SEQ (LETT |rex_of| (SPADCALL |f| (QREFELT $ 270)))
                     (COND
                      ((QVELT |f| 6)
                       (LETT |rex_of|
                             (LETT |rex_of|
                                   (SPADCALL (SPADCALL 1 (QREFELT $ 185))
                                             |rex_of| (QREFELT $ 266))))))
                     (EXIT (LETT |lst_of| (CONS |rex_of| |lst_of|))))))
              (COND
               ((QVELT |f| 6)
                (SEQ (LETT |sym| (SPADCALL '? (QREFELT $ 172)))
                     (LETT |sym_M| (SPADCALL 'M (QREFELT $ 172)))
                     (LETT |sym_R| (SPADCALL 'R (QREFELT $ 172)))
                     (LETT |flg_of| (SPADCALL 1 (QREFELT $ 185)))
                     (LETT |flg_of|
                           (SPADCALL |flg_of|
                                     (COND
                                      ((SPADCALL |f| (QREFELT $ 71)) |sym_M|)
                                      (#1='T |sym|))
                                     (QREFELT $ 266)))
                     (LETT |flg_of|
                           (SPADCALL |flg_of|
                                     (COND
                                      ((SPADCALL |f| (QREFELT $ 155)) |sym_R|)
                                      (#1# |sym|))
                                     (QREFELT $ 266)))
                     (LETT |lst_of| (CONS |flg_of| |lst_of|))
                     (EXIT
                      (LETT |lst_of|
                            (CONS (SPADCALL |f| (QREFELT $ 189)) |lst_of|))))))
              (COND
               ((NULL (QVELT |f| 7))
                (COND
                 ((NULL (QVELT |f| 6))
                  (SEQ (LETT |rex_of| (SPADCALL |f| (QREFELT $ 270)))
                       (EXIT (LETT |lst_of| (CONS |rex_of| |lst_of|))))))))
              (EXIT (SPADCALL |lst_of| (QREFELT $ 271)))))) 

(SDEFUN |FDALG;leftFactor;$Nni$;121|
        ((|f| ($)) (|k| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((#1=#:G1758 NIL) (|l| NIL) (|f_1| ($)) (|f_wrk| ($)) (#2=#:G1757 NIL)
          (|trn_wrk| (|List| (|Matrix| F)))
          (|lst_3| #3=(|List| (|NonNegativeInteger|))) (|lst_1| #3#)
          (|lst_4| #3#) (|lst_2| #3#) (|i_max| (|NonNegativeInteger|))
          (#4=#:G1749 NIL) (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND
            ((OR (ZEROP |k|) (> |k| (QVELT |f| 0)))
             (|error| "FDALG: leftFactor(f, k) - invalid rank."))
            ((NULL (|FDALG;polynomialForm?| |f| $))
             (|error|
              "FDALG: leftFactor(f, k) - ALS is not in polynomial form."))
            ((NULL (SPADCALL |f| (QREFELT $ 71)))
             (|error| "FDALG: leftFactor(f, k) - ALS is not minimal."))
            ('T
             (SEQ
              (COND
               ((EQL |k| 1)
                (PROGN
                 (LETT #2# (SPADCALL (|spadConstant| $ 14) (QREFELT $ 51)))
                 (GO #5=#:G1756))))
              (COND
               ((EQL |k| (QVELT |f| 0))
                (PROGN (LETT #2# (SPADCALL |f| (QREFELT $ 51))) (GO #5#))))
              (LETT |n| (QVELT |f| 0))
              (LETT |i_max|
                    (PROG1 (LETT #4# (- |k| 1))
                      (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #4#)))
              (LETT |lst_1| (SPADCALL |k| |n| (QREFELT $ 28)))
              (LETT |lst_2| (SPADCALL 1 |i_max| (QREFELT $ 28)))
              (LETT |lst_3| (SPADCALL 1 |i_max| (QREFELT $ 28)))
              (LETT |lst_4| (SPADCALL (+ |k| 1) |n| (QREFELT $ 28)))
              (LETT |trn_wrk|
                    (|FDALG;qblockElimination| |f| |lst_1| |lst_2| 'T |lst_3|
                     |lst_4| 'T $))
              (COND
               ((ZEROP (LENGTH |trn_wrk|))
                (SEQ (LETT |lst_1| (SPADCALL (+ |k| 1) |n| (QREFELT $ 28)))
                     (LETT |lst_3| (SPADCALL 1 |k| (QREFELT $ 28)))
                     (EXIT
                      (LETT |trn_wrk|
                            (|FDALG;qblockElimination| |f| |lst_1| |lst_2| 'T
                             |lst_3| |lst_4| 'T $))))))
              (COND
               ((ZEROP (LENGTH |trn_wrk|))
                (PROGN
                 (LETT #2# (SPADCALL (|spadConstant| $ 14) (QREFELT $ 51)))
                 (GO #5#))))
              (LETT |f_wrk| (SPADCALL |f| (QREFELT $ 51)))
              (SPADCALL (QVELT |f_wrk| 2)
                        (SPADCALL |trn_wrk| 1 (QREFELT $ 162)) (QREFELT $ 206))
              (SPADCALL (QVELT |f_wrk| 2)
                        (SPADCALL |trn_wrk| 2 (QREFELT $ 162)) (QREFELT $ 208))
              (LETT |f_1| (SPADCALL |k| (QVELT |f_wrk| 1) (QREFELT $ 35)))
              (SEQ (LETT |l| 1) (LETT #1# (LENGTH (QVELT |f_wrk| 1))) G190
                   (COND ((|greater_SI| |l| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (|FDALG;qsetmtxA!| (QVELT |f_1| 2) 1 1 |l|
                      (|FDALG;qmtxA| (QVELT |f_wrk| 2) 1 |k| 1 |k| |l| $) $)))
                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
              (|FDALG;qsetv!| (QVELT |f_1| 2) |k| 1 (|spadConstant| $ 15) $)
              (QSETVELT |f_1| 4 (QVELT |f| 4)) (QSETVELT |f_1| 3 (QVELT |f| 3))
              (EXIT |f_1|)))))
          #5# (EXIT #2#)))) 

(SDEFUN |FDALG;rightFactor;$Nni$;122|
        ((|f| ($)) (|k| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((#1=#:G1775 NIL) (|l| NIL) (|m| (|NonNegativeInteger|))
          (#2=#:G1769 NIL) (|f_2| ($)) (|f_wrk| ($)) (#3=#:G1774 NIL)
          (|trn_wrk| (|List| (|Matrix| F)))
          (|lst_3| #4=(|List| (|NonNegativeInteger|))) (|lst_1| #4#)
          (|lst_4| #4#) (|lst_2| #4#) (|i_max| (|NonNegativeInteger|))
          (#5=#:G1765 NIL) (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND
            ((OR (ZEROP |k|) (> |k| (QVELT |f| 0)))
             (|error| "FDALG: rightFactor(f, k) - invalid rank."))
            ((NULL (|FDALG;polynomialForm?| |f| $))
             (|error|
              "FDALG: rightFactor(f, k) - ALS is not in polynomial form."))
            ((NULL (SPADCALL |f| (QREFELT $ 71)))
             (|error| "FDALG: rightFactor(f, k) - ALS is not minimal."))
            ('T
             (SEQ
              (COND
               ((EQL |k| 1)
                (PROGN
                 (LETT #3# (SPADCALL (|spadConstant| $ 14) (QREFELT $ 51)))
                 (GO #6=#:G1773))))
              (COND
               ((EQL |k| (QVELT |f| 0))
                (PROGN (LETT #3# (SPADCALL |f| (QREFELT $ 51))) (GO #6#))))
              (LETT |n| (QVELT |f| 0))
              (LETT |i_max|
                    (PROG1 (LETT #5# (- |n| |k|))
                      (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #5#)))
              (LETT |lst_1| (SPADCALL (+ |i_max| 1) |n| (QREFELT $ 28)))
              (LETT |lst_2| (SPADCALL 1 |i_max| (QREFELT $ 28)))
              (LETT |lst_3| (SPADCALL 1 |i_max| (QREFELT $ 28)))
              (LETT |lst_4| (SPADCALL (+ |i_max| 2) |n| (QREFELT $ 28)))
              (LETT |trn_wrk|
                    (|FDALG;qblockElimination| |f| |lst_1| |lst_2| 'T |lst_3|
                     |lst_4| 'T $))
              (COND
               ((ZEROP (LENGTH |trn_wrk|))
                (SEQ (LETT |lst_1| (SPADCALL (+ |i_max| 2) |n| (QREFELT $ 28)))
                     (LETT |lst_3| (SPADCALL 1 (+ |i_max| 1) (QREFELT $ 28)))
                     (EXIT
                      (LETT |trn_wrk|
                            (|FDALG;qblockElimination| |f| |lst_1| |lst_2| 'T
                             |lst_3| |lst_4| 'T $))))))
              (COND
               ((ZEROP (LENGTH |trn_wrk|))
                (PROGN
                 (LETT #3# (SPADCALL (|spadConstant| $ 14) (QREFELT $ 51)))
                 (GO #6#))))
              (LETT |f_wrk| (SPADCALL |f| (QREFELT $ 51)))
              (SPADCALL (QVELT |f_wrk| 2)
                        (SPADCALL |trn_wrk| 1 (QREFELT $ 162)) (QREFELT $ 206))
              (SPADCALL (QVELT |f_wrk| 2)
                        (SPADCALL |trn_wrk| 2 (QREFELT $ 162)) (QREFELT $ 208))
              (LETT |f_2| (SPADCALL |k| (QVELT |f_wrk| 1) (QREFELT $ 35)))
              (LETT |m|
                    (PROG1 (LETT #2# (- |n| |k|))
                      (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #2#)))
              (SEQ (LETT |l| 1) (LETT #1# (LENGTH (QVELT |f_wrk| 1))) G190
                   (COND ((|greater_SI| |l| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (|FDALG;qsetmtxA!| (QVELT |f_2| 2) 1 1 |l|
                      (|FDALG;qmtxA| (QVELT |f_wrk| 2) (+ |m| 1) |n| (+ |m| 1)
                       |n| |l| $)
                      $)))
                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
              (|FDALG;qsetmtxv!| (QVELT |f_2| 2) 1 1
               (|FDALG;qmtxv| (QVELT |f_wrk| 2) (+ |m| 1) |n| 1 $) $)
              (QSETVELT |f_2| 4 (QVELT |f| 4)) (QSETVELT |f_2| 3 (QVELT |f| 3))
              (EXIT |f_2|)))))
          #6# (EXIT #3#)))) 

(SDEFUN |FDALG;qfactorizationTransformations|
        ((|f| ($)) (|k_rows| (|NonNegativeInteger|))
         (|k_cols| (|NonNegativeInteger|))
         (|sol| (|List| (|Equation| (|Polynomial| F))))
         ($ (|List| (|Matrix| F))))
        (SPROG
         ((|col_Q| #1=(|List| (|NonNegativeInteger|))) (|row_Q| #1#)
          (|col_P| #1#) (#2=#:G1779 NIL) (#3=#:G1778 NIL) (|row_P| #1#)
          (|j_min| (|NonNegativeInteger|)) (#4=#:G1777 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |j_min|
                    (PROG1 (LETT #4# (+ (- |n| |k_cols|) 1))
                      (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #4#)))
              (LETT |row_P| (SPADCALL (+ 1 1) (+ 1 |k_rows|) (QREFELT $ 28)))
              (LETT |col_P|
                    (SPADCALL
                     (+ 1
                        (PROG1 (LETT #3# (- |j_min| 1))
                          (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #3#)))
                     (+ 1
                        (PROG1 (LETT #2# (- |n| 1))
                          (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #2#)))
                     (QREFELT $ 28)))
              (LETT |row_Q|
                    (SPADCALL (+ 1 2) (+ (+ 1 |k_rows|) 1) (QREFELT $ 28)))
              (LETT |col_Q| (SPADCALL (+ 1 |j_min|) (+ 1 |n|) (QREFELT $ 28)))
              (EXIT
               (SPADCALL (QVELT |f| 2) |row_P| |col_P| |row_Q| |col_Q| |sol|
                         (QREFELT $ 276)))))) 

(SDEFUN |FDALG;factorize;$NniL;124|
        ((|f| ($)) (|k| (|NonNegativeInteger|)) ($ (|List| $)))
        (SPROG
         ((#1=#:G1808 NIL) (|l| NIL) (|f_2| ($)) (|f_1| ($))
          (|n_2| (|NonNegativeInteger|)) (#2=#:G1801 NIL)
          (|n_1| (|NonNegativeInteger|)) (|trn_wrk| (|List| (|Matrix| F)))
          (#3=#:G1798 NIL) (#4=#:G1797 NIL) (#5=#:G1807 NIL)
          (|lst_sol| (|List| (|List| (|Equation| (|Polynomial| F)))))
          (#6=#:G1792 NIL) (#7=#:G1791 NIL)
          (|lst_3| #8=(|List| (|NonNegativeInteger|))) (|lst_1| #8#)
          (|lst_4| #8#) (|lst_2| #8#) (|i_max| (|NonNegativeInteger|))
          (#9=#:G1788 NIL) (|n| (|NonNegativeInteger|)) (|lst_fct| (|List| $))
          (|f_wrk| ($)))
         (SEQ
          (EXIT
           (COND
            ((OR (ZEROP |k|) (> |k| (QVELT |f| 0)))
             (|error| "FDALG: factorize(f, k) - invalid rank."))
            ((NULL (|FDALG;polynomialForm?| |f| $))
             (|error|
              "FDALG: factorize(f, k) - ALS is not in polynomial form."))
            ((NULL (SPADCALL |f| (QREFELT $ 71)))
             (|error| "FDALG: factorize(f, k) - ALS is not minimal."))
            ('T
             (SEQ (LETT |f_wrk| (SPADCALL |f| (QREFELT $ 51)))
                  (LETT |lst_fct| (LIST |f_wrk|))
                  (COND
                   ((OR (EQL |k| 1) (EQL |k| (QVELT |f| 0)))
                    (PROGN (LETT #5# |lst_fct|) (GO #10=#:G1806))))
                  (LETT |n| (QVELT |f| 0))
                  (LETT |i_max|
                        (PROG1 (LETT #9# (- |k| 1))
                          (|check_subtype2| (>= #9# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #9#)))
                  (LETT |lst_1| (SPADCALL |k| |n| (QREFELT $ 28)))
                  (LETT |lst_2| (SPADCALL 1 |i_max| (QREFELT $ 28)))
                  (LETT |lst_3| (SPADCALL 1 |i_max| (QREFELT $ 28)))
                  (LETT |lst_4| (SPADCALL (+ |k| 1) |n| (QREFELT $ 28)))
                  (LETT |trn_wrk|
                        (|FDALG;qblockElimination| |f| |lst_1| |lst_2| 'T
                         |lst_3| |lst_4| 'T $))
                  (COND
                   ((ZEROP (LENGTH |trn_wrk|))
                    (SEQ (LETT |lst_1| (SPADCALL (+ |k| 1) |n| (QREFELT $ 28)))
                         (LETT |lst_3| (SPADCALL 1 |k| (QREFELT $ 28)))
                         (EXIT
                          (LETT |trn_wrk|
                                (|FDALG;qblockElimination| |f| |lst_1| |lst_2|
                                 'T |lst_3| |lst_4| 'T $))))))
                  (COND
                   ((ZEROP (LENGTH |trn_wrk|))
                    (SEQ
                     (LETT |lst_sol|
                           (SPADCALL |f|
                                     (PROG1 (LETT #7# (- |k| 1))
                                       (|check_subtype2| (>= #7# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #7#))
                                     (PROG1 (LETT #6# (- |n| |k|))
                                       (|check_subtype2| (>= #6# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #6#))
                                     (QREFELT $ 278)))
                     (COND
                      ((ZEROP (LENGTH |lst_sol|))
                       (PROGN (LETT #5# |lst_fct|) (GO #10#))))
                     (EXIT
                      (LETT |trn_wrk|
                            (|FDALG;qfactorizationTransformations| |f|
                             (PROG1 (LETT #4# (- |k| 1))
                               (|check_subtype2| (>= #4# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #4#))
                             (PROG1 (LETT #3# (- |n| |k|))
                               (|check_subtype2| (>= #3# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #3#))
                             (|SPADfirst| |lst_sol|) $))))))
                  (SPADCALL (QVELT |f_wrk| 2)
                            (SPADCALL |trn_wrk| 1 (QREFELT $ 162))
                            (QREFELT $ 206))
                  (SPADCALL (QVELT |f_wrk| 2)
                            (SPADCALL |trn_wrk| 2 (QREFELT $ 162))
                            (QREFELT $ 208))
                  (LETT |n_1| |k|)
                  (LETT |n_2|
                        (PROG1 (LETT #2# (+ (- |n| |k|) 1))
                          (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #2#)))
                  (LETT |f_1|
                        (SPADCALL |n_1| (QVELT |f_wrk| 1) (QREFELT $ 35)))
                  (LETT |f_2|
                        (SPADCALL |n_2| (QVELT |f_wrk| 1) (QREFELT $ 35)))
                  (SEQ (LETT |l| 1) (LETT #1# (LENGTH (QVELT |f_wrk| 1))) G190
                       (COND ((|greater_SI| |l| #1#) (GO G191)))
                       (SEQ
                        (|FDALG;qsetmtxA!| (QVELT |f_1| 2) 1 1 |l|
                         (|FDALG;qmtxA| (QVELT |f_wrk| 2) 1 |k| 1 |k| |l| $) $)
                        (EXIT
                         (|FDALG;qsetmtxA!| (QVELT |f_2| 2) 1 1 |l|
                          (|FDALG;qmtxA| (QVELT |f_wrk| 2) |k| |n| |k| |n| |l|
                           $)
                          $)))
                       (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
                  (|FDALG;qsetv!| (QVELT |f_1| 2) |k| 1 (|spadConstant| $ 15)
                   $)
                  (|FDALG;qsetmtxv!| (QVELT |f_2| 2) 1 1
                   (|FDALG;qmtxv| (QVELT |f_wrk| 2) |k| |n| 1 $) $)
                  (QSETVELT |f_1| 4 (QVELT |f| 4))
                  (QSETVELT |f_1| 3 (QVELT |f| 3))
                  (QSETVELT |f_2| 4 (QVELT |f| 4))
                  (QSETVELT |f_2| 3 (QVELT |f| 3))
                  (EXIT (LIST |f_1| |f_2|))))))
          #10# (EXIT #5#)))) 

(SDEFUN |FDALG;factor;$L;125| ((|f| ($)) ($ (|List| $)))
        (SPROG
         ((|lst_fct| (|List| $)) (#1=#:G1827 NIL) (#2=#:G1826 NIL)
          (|elt_tmp| ($)) (|flg_irr| (|Boolean|)) (|lst_tmp| (|List| $))
          (#3=#:G1829 NIL) (#4=#:G1816 NIL) (|k| NIL) (#5=#:G1828 NIL)
          (|elt| NIL) (|lst_wrk| (|List| $)) (|f_wrk| ($)))
         (SEQ
          (COND
           ((NULL (|FDALG;polynomialForm?| |f| $))
            (|error| "FDALG: factor(f) - ALS is not in polynomial form."))
           ((NULL (SPADCALL |f| (QREFELT $ 71)))
            (|error| "FDALG: factor(f) - ALS is not minimal."))
           ('T
            (SEQ (LETT |f_wrk| (SPADCALL |f| (QREFELT $ 51)))
                 (SPADCALL |f_wrk| (QREFELT $ 280))
                 (LETT |lst_wrk| (SPADCALL |f_wrk| (QREFELT $ 242)))
                 (LETT |lst_fct| NIL)
                 (SEQ (LETT |elt| NIL) (LETT #5# |lst_wrk|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |elt| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ (LETT |elt_tmp| |elt|)
                           (SEQ
                            (EXIT
                             (SEQ G190
                                  (COND
                                   ((NULL (> (QVELT |elt_tmp| 0) 2))
                                    (GO G191)))
                                  (SEQ (LETT |flg_irr| 'T)
                                       (SEQ
                                        (EXIT
                                         (SEQ (LETT |k| 2)
                                              (LETT #3#
                                                    (PROG1
                                                        (LETT #4#
                                                              (-
                                                               (QVELT |elt_tmp|
                                                                      0)
                                                               1))
                                                      (|check_subtype2|
                                                       (>= #4# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #4#)))
                                              G190
                                              (COND
                                               ((|greater_SI| |k| #3#)
                                                (GO G191)))
                                              (SEQ
                                               (LETT |lst_tmp|
                                                     (SPADCALL |elt_tmp| |k|
                                                               (QREFELT $
                                                                        279)))
                                               (EXIT
                                                (COND
                                                 ((EQL
                                                   (SPADCALL |lst_tmp|
                                                             (QREFELT $ 243))
                                                   2)
                                                  (SEQ (LETT |flg_irr| NIL)
                                                       (LETT |lst_fct|
                                                             (SPADCALL
                                                              (SPADCALL
                                                               |lst_tmp| 1
                                                               (QREFELT $ 281))
                                                              |lst_fct|
                                                              (QREFELT $ 240)))
                                                       (LETT |elt_tmp|
                                                             (SPADCALL
                                                              |lst_tmp| 2
                                                              (QREFELT $ 281)))
                                                       (EXIT
                                                        (PROGN
                                                         (LETT #2# 1)
                                                         (GO #6=#:G1819))))))))
                                              (LETT |k| (|inc_SI| |k|))
                                              (GO G190) G191 (EXIT NIL)))
                                        #6# (EXIT #2#))
                                       (EXIT
                                        (COND
                                         (|flg_irr|
                                          (PROGN
                                           (LETT #1# |$NoValue|)
                                           (GO #7=#:G1821))))))
                                  NIL (GO G190) G191 (EXIT NIL)))
                            #7# (EXIT #1#))
                           (EXIT
                            (LETT |lst_fct|
                                  (SPADCALL |elt_tmp| |lst_fct|
                                            (QREFELT $ 240)))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (EXIT (SPADCALL |lst_fct| (QREFELT $ 282))))))))) 

(SDEFUN |FDALG;factorizationTransformations;$2NniLL;126|
        ((|f| ($)) (|k_rows| (|NonNegativeInteger|))
         (|k_cols| (|NonNegativeInteger|))
         (|sol| (|List| (|Equation| (|Polynomial| F))))
         ($ (|List| (|Matrix| F))))
        (SPROG
         ((|lst_trn| (|List| (|Matrix| F)))
          (|col_Q| #1=(|List| (|NonNegativeInteger|))) (|row_Q| #1#)
          (|col_P| #1#) (#2=#:G1833 NIL) (#3=#:G1832 NIL) (|row_P| #1#)
          (|j_min| (|NonNegativeInteger|)) (#4=#:G1831 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |j_min|
                    (PROG1 (LETT #4# (+ (- |n| |k_cols|) 1))
                      (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #4#)))
              (LETT |row_P| (SPADCALL (+ 1 1) (+ 1 |k_rows|) (QREFELT $ 28)))
              (LETT |col_P|
                    (SPADCALL
                     (+ 1
                        (PROG1 (LETT #3# (- |j_min| 1))
                          (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #3#)))
                     (+ 1
                        (PROG1 (LETT #2# (- |n| 1))
                          (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #2#)))
                     (QREFELT $ 28)))
              (LETT |row_Q|
                    (SPADCALL (+ 1 2) (+ (+ 1 |k_rows|) 1) (QREFELT $ 28)))
              (LETT |col_Q| (SPADCALL (+ 1 |j_min|) (+ 1 |n|) (QREFELT $ 28)))
              (LETT |lst_trn|
                    (SPADCALL (QVELT |f| 2) |row_P| |col_P| |row_Q| |col_Q|
                              |sol| (QREFELT $ 276)))
              (EXIT
               (LIST
                (SPADCALL (SPADCALL |lst_trn| 1 (QREFELT $ 162)) (+ 1 1)
                          (+ 1 |n|) (+ 1 1) (+ 1 |n|) (QREFELT $ 163))
                (SPADCALL (SPADCALL |lst_trn| 2 (QREFELT $ 162)) (+ 1 1)
                          (+ 1 |n|) (+ 1 1) (+ 1 |n|) (QREFELT $ 163))))))) 

(SDEFUN |FDALG;factorizationEquations;$2NniL;127|
        ((|f| ($)) (|k_rows| (|NonNegativeInteger|))
         (|k_cols| (|NonNegativeInteger|)) ($ (|List| (|Polynomial| F))))
        (SPROG
         ((|lst_eqn| (|List| (|Polynomial| F)))
          (|cex2| (|List| (|NonNegativeInteger|)))
          (|rex2| (|List| (|NonNegativeInteger|)))
          (|cex1| (|List| #1=(|NonNegativeInteger|))) (|rex1| (|List| #1#))
          (|cdst| #2=(|List| (|NonNegativeInteger|))) (|rdst| #2#)
          (|col_Q| #2#) (|row_Q| #2#) (|col_P| #2#) (#3=#:G1839 NIL)
          (#4=#:G1838 NIL) (|row_P| #2#) (|j_min| (|NonNegativeInteger|))
          (#5=#:G1837 NIL) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |j_min|
                    (PROG1 (LETT #5# (+ (- |n| |k_cols|) 1))
                      (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #5#)))
              (LETT |row_P| (SPADCALL (+ 1 1) (+ 1 |k_rows|) (QREFELT $ 28)))
              (LETT |col_P|
                    (SPADCALL
                     (+ 1
                        (PROG1 (LETT #4# (- |j_min| 1))
                          (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #4#)))
                     (+ 1
                        (PROG1 (LETT #3# (- |n| 1))
                          (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #3#)))
                     (QREFELT $ 28)))
              (LETT |row_Q|
                    (SPADCALL (+ 1 2) (+ (+ 1 |k_rows|) 1) (QREFELT $ 28)))
              (LETT |col_Q| (SPADCALL (+ 1 |j_min|) (+ 1 |n|) (QREFELT $ 28)))
              (LETT |rdst| (SPADCALL (+ 1 1) (+ 1 |k_rows|) (QREFELT $ 28)))
              (LETT |cdst| (SPADCALL (+ 1 |j_min|) (+ 1 |n|) (QREFELT $ 28)))
              (LETT |rex1| (LIST 1)) (LETT |cex1| (LIST 1)) (LETT |rex2| NIL)
              (LETT |cex2| NIL)
              (LETT |lst_eqn|
                    (SPADCALL (QVELT |f| 2) |row_P| |col_P| |row_Q| |col_Q|
                              |rdst| |cdst| |rex1| |cex1| |rex2| |cex2|
                              (QREFELT $ 286)))
              (EXIT |lst_eqn|)))) 

(SDEFUN |FDALG;factorizationGroebner;$2NniL;128|
        ((|f| ($)) (|k_rows| (|NonNegativeInteger|))
         (|k_cols| (|NonNegativeInteger|)) ($ (|List| (|Polynomial| F))))
        (SPROG
         ((|lst_gro| (|List| (|Polynomial| F))) (#1=#:G1854 NIL) (|eqn| NIL)
          (#2=#:G1853 NIL) (|bas_gro| (|List| |tDMP|))
          (|eqn_wrk| (|List| |tDMP|)) (#3=#:G1852 NIL) (#4=#:G1851 NIL)
          (|tPRD|
           (|DirectProductCategory| (|call| LENGTH |lst_var|)
                                    (|NonNegativeInteger|)))
          (|tDMP|
           (|Join|
            (|PolynomialCategory| F
                                  (|DirectProduct| (|#| |lst_var|)
                                                   (|NonNegativeInteger|))
                                  (|OrderedVariableList| |lst_var|))
            (CATEGORY |domain|
             (SIGNATURE |reorder| ($ $ (|List| (|Integer|)))))))
          (|lst_var| (|List| (|Symbol|)))
          (|tmp_var| (|List| (|List| (|Symbol|))))
          (|lst_eqn| (|List| (|Polynomial| F))))
         (SEQ (LETT |lst_eqn| (SPADCALL |f| |k_rows| |k_cols| (QREFELT $ 287)))
              (LETT |tmp_var| (SPADCALL (ELT $ 289) |lst_eqn| (QREFELT $ 293)))
              (LETT |lst_var|
                    (SPADCALL (SPADCALL |tmp_var| (QREFELT $ 294))
                              (QREFELT $ 295)))
              (LETT |tDMP|
                    (|DistributedMultivariatePolynomial| |lst_var|
                                                         (QREFELT $ 7)))
              (LETT |tPRD|
                    (|DirectProduct| (LENGTH |lst_var|)
                                     (|NonNegativeInteger|)))
              (LETT |eqn_wrk|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |eqn| NIL) (LETT #3# |lst_eqn|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |eqn| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (SPADCALL |eqn|
                                             (|compiledLookupCheck| '|pToDmp|
                                                                    (LIST
                                                                     (LIST
                                                                      '|DistributedMultivariatePolynomial|
                                                                      |lst_var|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            7)))
                                                                     (LIST
                                                                      '|Polynomial|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            7))))
                                                                    (|PolToPol|
                                                                     |lst_var|
                                                                     (ELT $
                                                                          7))))
                                   #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |bas_gro|
                    (SPADCALL |eqn_wrk|
                              (|compiledLookupCheck| '|groebner|
                                                     (LIST
                                                      (LIST '|List|
                                                            (|devaluate|
                                                             |tDMP|))
                                                      (LIST '|List|
                                                            (|devaluate|
                                                             |tDMP|)))
                                                     (|GroebnerPackage|
                                                      (ELT $ 7) |tPRD|
                                                      |tDMP|))))
              (LETT |lst_gro|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |eqn| NIL) (LETT #1# |bas_gro|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |eqn| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL |eqn|
                                             (|compiledLookupCheck| '|dmpToP|
                                                                    (LIST
                                                                     (LIST
                                                                      '|Polynomial|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            7)))
                                                                     (LIST
                                                                      '|DistributedMultivariatePolynomial|
                                                                      |lst_var|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            7))))
                                                                    (|PolToPol|
                                                                     |lst_var|
                                                                     (ELT $
                                                                          7))))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT |lst_gro|)))) 

(SDEFUN |FDALG;factorizationSolve;$2NniL;129|
        ((|f| ($)) (|k_rows| (|NonNegativeInteger|))
         (|k_cols| (|NonNegativeInteger|))
         ($ (|List| (|List| (|Equation| (|Polynomial| F))))))
        (SPROG
         ((|lst_sol| (|List| (|List| (|Equation| (|Polynomial| F)))))
          (#1=#:G1862 NIL)
          (|sol_wrk| (|List| (|List| (|Equation| (|Polynomial| F)))))
          (|lst_wrk| (|List| (|Polynomial| F))) (|k| NIL)
          (|lst_val| (|List| F)) (|lst_eqn| (|List| (|Polynomial| F))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |lst_eqn| (SPADCALL |f| |k_rows| |k_cols| (QREFELT $ 296)))
            (LETT |lst_val| (LIST (|spadConstant| $ 50))) (LETT |lst_wrk| NIL)
            (LETT |lst_sol| NIL)
            (SEQ (LETT |k| (LENGTH |lst_eqn|)) G190
                 (COND ((< |k| 1) (GO G191)))
                 (SEQ
                  (LETT |lst_wrk|
                        (CONS (SPADCALL |lst_eqn| |k| (QREFELT $ 297))
                              |lst_wrk|))
                  (LETT |sol_wrk|
                        (SPADCALL |lst_wrk| |lst_val| |lst_sol|
                                  (QREFELT $ 298)))
                  (COND
                   ((ZEROP (LENGTH |sol_wrk|))
                    (PROGN (LETT #1# NIL) (GO #2=#:G1861))))
                  (EXIT (LETT |lst_sol| (SPADCALL |sol_wrk| (QREFELT $ 299)))))
                 (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
            (EXIT |lst_sol|)))
          #2# (EXIT #1#)))) 

(SDEFUN |FDALG;refineUR!;$Nni$;130|
        ((|f| ($)) (|k_rows| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|trn_wrk| (|List| (|Matrix| F)))
          (|lst_3| #1=(|List| (|NonNegativeInteger|))) (|lst_1| #1#)
          (#2=#:G1877 NIL) (|rminb| #3=(|NonNegativeInteger|)) (|rmina| #3#)
          (|cmaxb| #4=(|NonNegativeInteger|)) (|cmaxa| #4#) (#5=#:G1865 NIL)
          (#6=#:G1879 NIL) (|k| NIL) (|j_ref| (|NonNegativeInteger|))
          (|blo_mtx| (|Matrix| (|NonNegativeInteger|))) (|lst_4| #1#)
          (|lst_2| #1#) (#7=#:G1878 NIL) (|n| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QVELT |f| 0))
                (COND ((<= |n| 2) (PROGN (LETT #7# |f|) (GO #8=#:G1876))))
                (LETT |lst_2| (SPADCALL 1 |k_rows| (QREFELT $ 28)))
                (LETT |lst_4| (SPADCALL (+ |k_rows| 2) |n| (QREFELT $ 28)))
                (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153)))
                (LETT |cmaxa| 1) (LETT |cmaxb| 1) (LETT |rmina| |n|)
                (LETT |rminb| |n|) (LETT |j_ref| (+ |k_rows| 2))
                (SEQ
                 (EXIT
                  (SEQ (LETT |k| 1)
                       (LETT #6# (SPADCALL |blo_mtx| (QREFELT $ 154))) G190
                       (COND ((|greater_SI| |k| #6#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((<= (SPADCALL |blo_mtx| |k| 1 (QREFELT $ 184))
                               |j_ref|)
                           (COND
                            ((>= (SPADCALL |blo_mtx| |k| 2 (QREFELT $ 184))
                                 |j_ref|)
                             (SEQ
                              (COND
                               ((> |k| 1)
                                (LETT |cmaxa|
                                      (SPADCALL |blo_mtx|
                                                (PROG1 (LETT #5# (- |k| 1))
                                                  (|check_subtype2| (>= #5# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #5#))
                                                2 (QREFELT $ 184)))))
                              (LETT |cmaxb|
                                    (SPADCALL |blo_mtx| |k| 2 (QREFELT $ 184)))
                              (LETT |rmina|
                                    (SPADCALL |blo_mtx| |k| 1 (QREFELT $ 184)))
                              (COND
                               ((< |k| (SPADCALL |blo_mtx| (QREFELT $ 154)))
                                (LETT |rminb|
                                      (SPADCALL |blo_mtx| (+ |k| 1) 1
                                                (QREFELT $ 184)))))
                              (EXIT
                               (PROGN (LETT #2# 1) (GO #9=#:G1870))))))))))
                       (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL)))
                 #9# (EXIT #2#))
                (LETT |lst_1|
                      (SPADCALL (MAX |rmina| (+ |k_rows| 1)) |n|
                                (QREFELT $ 28)))
                (LETT |lst_3| (SPADCALL 1 |cmaxa| (QREFELT $ 28)))
                (LETT |trn_wrk|
                      (|FDALG;qblockElimination| |f| |lst_1| |lst_2| 'T |lst_3|
                       |lst_4| 'T $))
                (COND
                 ((> (LENGTH |trn_wrk|) 0)
                  (SEQ
                   (SPADCALL (QVELT |f| 2)
                             (SPADCALL |trn_wrk| 1 (QREFELT $ 162))
                             (QREFELT $ 206))
                   (EXIT
                    (SPADCALL (QVELT |f| 2)
                              (SPADCALL |trn_wrk| 2 (QREFELT $ 162))
                              (QREFELT $ 208)))))
                 ('T
                  (SEQ (LETT |lst_1| (SPADCALL |rminb| |n| (QREFELT $ 28)))
                       (LETT |lst_3|
                             (SPADCALL 1 (MIN |cmaxb| (+ |k_rows| 1))
                                       (QREFELT $ 28)))
                       (LETT |trn_wrk|
                             (|FDALG;qblockElimination| |f| |lst_1| |lst_2| 'T
                              |lst_3| |lst_4| 'T $))
                       (EXIT
                        (COND
                         ((> (LENGTH |trn_wrk|) 0)
                          (SEQ
                           (SPADCALL (QVELT |f| 2)
                                     (SPADCALL |trn_wrk| 1 (QREFELT $ 162))
                                     (QREFELT $ 206))
                           (EXIT
                            (SPADCALL (QVELT |f| 2)
                                      (SPADCALL |trn_wrk| 2 (QREFELT $ 162))
                                      (QREFELT $ 208))))))))))
                (EXIT |f|)))
          #8# (EXIT #7#)))) 

(SDEFUN |FDALG;refineUR!;2$;131| ((|f| ($)) ($ ($)))
        (SPROG
         ((#1=#:G1888 NIL) (#2=#:G1883 NIL) (|k| NIL) (#3=#:G1887 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QVELT |f| 0))
                (COND ((<= |n| 2) (PROGN (LETT #3# |f|) (GO #4=#:G1886))))
                (SEQ (LETT |k| 1)
                     (LETT #1#
                           (PROG1 (LETT #2# (- |n| 2))
                             (|check_subtype2| (>= #2# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #2#)))
                     G190 (COND ((|greater_SI| |k| #1#) (GO G191)))
                     (SEQ (EXIT (SPADCALL |f| |k| (QREFELT $ 300))))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                (EXIT |f|)))
          #4# (EXIT #3#)))) 

(SDEFUN |FDALG;extendedALS;2$;132| ((|f| ($)) ($ ($)))
        (SPROG ((|f_new| ($)))
               (SEQ
                (LETT |f_new|
                      (SPADCALL
                       (SPADCALL (QVELT |f| 2) (LIST 1) (LIST 1)
                                 (QREFELT $ 143))
                       (QVELT |f| 1) (QREFELT $ 41)))
                (|FDALG;qsetA!| (QVELT |f_new| 2) 1 1 1 (|spadConstant| $ 15)
                 $)
                (|FDALG;qsetA!| (QVELT |f_new| 2) 1 2 1
                 (SPADCALL (|spadConstant| $ 15) (QREFELT $ 58)) $)
                (|FDALG;qsetu!| (QVELT |f_new| 2) 1 1 (|spadConstant| $ 15) $)
                (|FDALG;qsetu!| (QVELT |f_new| 2) 2 1 (|spadConstant| $ 50) $)
                (QSETVELT |f_new| 4 (QVELT |f| 4)) (EXIT |f_new|)))) 

(SDEFUN |FDALG;normalALS;2$;133| ((|f| ($)) ($ ($)))
        (SPROG
         ((|als| ($)) (#1=#:G1914 NIL) (|k| NIL) (|a_ref| (F))
          (|i_ref| (|NonNegativeInteger|)) (#2=#:G1905 NIL)
          (|n| (|NonNegativeInteger|))
          (|lst_tmp| (|List| (|NonNegativeInteger|))) (#3=#:G1913 NIL)
          (|i_max| (|NonNegativeInteger|)) (#4=#:G1910 NIL) (#5=#:G1912 NIL)
          (|i_min| (|NonNegativeInteger|)) (#6=#:G1911 NIL)
          (|a_flg| (|Boolean|)) (|blo_mtx| (|Matrix| (|NonNegativeInteger|))))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QVELT |f| 0))
                (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153)))
                (LETT |a_flg|
                      (|FDALG;qsemizeroA?| (QVELT |f| 2) 1 1 1 |n| 1 $))
                (COND
                 ((SPADCALL (|FDALG;qeltA| (QVELT |f| 2) 1 1 1 $)
                            (|spadConstant| $ 15) (QREFELT $ 76))
                  (COND
                   (|a_flg|
                    (COND
                     ((OR (EQL (SPADCALL |blo_mtx| (QREFELT $ 154)) 1)
                          (> (SPADCALL |blo_mtx| 1 3 (QREFELT $ 184)) 1))
                      (EXIT
                       (|error|
                        #7="FDALG: normalALS(f) - not in extended form.")))))
                   (#8='T (EXIT (|error| #7#)))))
                 (#8# (EXIT (|error| #7#))))
                (LETT |i_ref| 2)
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL (|FDALG;qeltA| (QVELT |f| 2) 1 |i_ref| 1 $)
                                  (QREFELT $ 48)))
                       (GO G191)))
                     (SEQ (LETT |i_ref| (+ |i_ref| 1))
                          (EXIT
                           (COND
                            ((> |i_ref| |n|)
                             (PROGN
                              (LETT #6#
                                    (SPADCALL (|spadConstant| $ 14)
                                              (|FDALG;qeltv| (QVELT |f| 2) 1 1
                                               $)
                                              (QREFELT $ 62)))
                              (GO #9=#:G1909))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (LETT |i_min| 2) (LETT |i_max| 0)
                (SEQ
                 (EXIT
                  (SEQ (LETT |k| 2)
                       (LETT #5# (SPADCALL |blo_mtx| (QREFELT $ 154))) G190
                       (COND ((|greater_SI| |k| #5#) (GO G191)))
                       (SEQ
                        (COND
                         ((>= (SPADCALL |blo_mtx| |k| 2 (QREFELT $ 184))
                              |i_ref|)
                          (PROGN (LETT #4# 1) (GO #10=#:G1901))))
                        (EXIT
                         (LETT |i_max|
                               (SPADCALL |blo_mtx| |k| 2 (QREFELT $ 184)))))
                       (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL)))
                 #10# (EXIT #4#))
                (LETT |lst_tmp| NIL)
                (SEQ (LETT |k| |i_max|) (LETT #3# |i_min|) G190
                     (COND ((< |k| #3#) (GO G191)))
                     (SEQ (EXIT (LETT |lst_tmp| (CONS |k| |lst_tmp|))))
                     (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                (LETT |als| (SPADCALL |f| (QREFELT $ 51)))
                (COND
                 ((> (SPADCALL |lst_tmp| (QREFELT $ 140)) 0)
                  (LETT |als|
                        (SPADCALL |f| |lst_tmp| |lst_tmp| (QREFELT $ 142)))))
                (LETT |n| (QVELT |als| 0))
                (LETT |i_ref|
                      (PROG1
                          (LETT #2#
                                (- |i_ref|
                                   (SPADCALL |lst_tmp| (QREFELT $ 140))))
                        (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #2#)))
                (LETT |a_ref| (|FDALG;qeltA| (QVELT |als| 2) 1 |i_ref| 1 $))
                (COND
                 ((NULL (EQL |i_ref| 2))
                  (SPADCALL |als| 2 |i_ref| (QREFELT $ 130))))
                (SPADCALL |als| 2
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 15) |a_ref|
                                     (QREFELT $ 209))
                           (QREFELT $ 58))
                          (QREFELT $ 127))
                (SEQ (LETT |k| 3) (LETT #1# |n|) G190
                     (COND ((> |k| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |als| 2 |k|
                                 (|FDALG;qeltA| (QVELT |als| 2) 1 |k| 1 $)
                                 (QREFELT $ 133))))
                     (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                (LETT |als| (SPADCALL |als| (LIST 1) (LIST 1) (QREFELT $ 142)))
                (|FDALG;qsetu!| (QVELT |als| 2) 1 1 (|spadConstant| $ 15) $)
                (QSETVELT |als| 4 (QVELT |f| 4)) (EXIT |als|)))
          #9# (EXIT #6#)))) 

(SDEFUN |FDALG;leftMinimization;$2Nni$;134|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((#1=#:G1924 NIL) (|g| ($)) (|trn_wrk| (|List| (|Matrix| F)))
          (|lst_2| (|List| (|NonNegativeInteger|))) (#2=#:G1926 NIL) (|i| NIL)
          (|lst_1| (|List| (|NonNegativeInteger|))) (#3=#:G1925 NIL))
         (SEQ
          (EXIT
           (COND
            ((OR (OR (> |i_min| |i_max|) (< |i_min| 1))
                 (>= |i_max| (QVELT |f| 0)))
             (|error|
              "FDALG: leftMinimization(f, i_min, i_max) - indices invalid."))
            ('T
             (SEQ (LETT |lst_1| NIL)
                  (SEQ (LETT |i| |i_max|) (LETT #3# |i_min|) G190
                       (COND ((< |i| #3#) (GO G191)))
                       (SEQ (EXIT (LETT |lst_1| (CONS |i| |lst_1|))))
                       (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                  (LETT |lst_2| NIL)
                  (SEQ (LETT |i| (QVELT |f| 0)) (LETT #2# (+ |i_max| 1)) G190
                       (COND ((< |i| #2#) (GO G191)))
                       (SEQ (EXIT (LETT |lst_2| (CONS |i| |lst_2|))))
                       (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                  (LETT |trn_wrk|
                        (SPADCALL |f| |lst_2| |lst_1| 'T |lst_1| |lst_2| 'T
                                  (QREFELT $ 165)))
                  (LETT |g| (SPADCALL |f| (QREFELT $ 51)))
                  (COND
                   ((> (LENGTH |trn_wrk|) 0)
                    (SEQ
                     (COND
                      ((EQL |i_min| 1)
                       (PROGN
                        (LETT #1# (|spadConstant| $ 49))
                        (GO #4=#:G1923))))
                     (SPADCALL |g| (SPADCALL |trn_wrk| 1 (QREFELT $ 162))
                               (QREFELT $ 201))
                     (SPADCALL |g| (SPADCALL |trn_wrk| 2 (QREFELT $ 162))
                               (QREFELT $ 199))
                     (LETT |g| (SPADCALL |g| |lst_1| |lst_1| (QREFELT $ 142)))
                     (QSETVELT |g| 4 (QVELT |f| 4))
                     (EXIT (PROGN (LETT #1# |g|) (GO #4#))))))
                  (EXIT |g|)))))
          #4# (EXIT #1#)))) 

(SDEFUN |FDALG;rightMinimization;$2Nni$;135|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((#1=#:G1940 NIL) (|g| ($)) (|trn_wrk| (|List| (|Matrix| F)))
          (|lst_2| (|List| (|NonNegativeInteger|))) (|i| NIL) (#2=#:G1933 NIL)
          (|lst_1| (|List| (|NonNegativeInteger|))) (#3=#:G1941 NIL))
         (SEQ
          (EXIT
           (COND
            ((OR (OR (> |i_min| |i_max|) (<= |i_min| 1))
                 (> |i_max| (QVELT |f| 0)))
             (|error|
              "FDALG: rightMinimization(f, i_min, i_max) - indices invalid."))
            ('T
             (SEQ (LETT |lst_1| NIL)
                  (SEQ (LETT |i| |i_max|) (LETT #3# |i_min|) G190
                       (COND ((< |i| #3#) (GO G191)))
                       (SEQ (EXIT (LETT |lst_1| (CONS |i| |lst_1|))))
                       (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                  (LETT |lst_2| NIL)
                  (SEQ
                   (LETT |i|
                         (PROG1 (LETT #2# (- |i_min| 1))
                           (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #2#)))
                   G190 (COND ((< |i| 1) (GO G191)))
                   (SEQ (EXIT (LETT |lst_2| (CONS |i| |lst_2|))))
                   (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
                  (LETT |trn_wrk|
                        (SPADCALL |f| |lst_1| |lst_2| 'T |lst_2| |lst_1| NIL
                                  (QREFELT $ 165)))
                  (LETT |g| (SPADCALL |f| (QREFELT $ 51)))
                  (COND
                   ((> (LENGTH |trn_wrk|) 0)
                    (SEQ
                     (SPADCALL |g| (SPADCALL |trn_wrk| 1 (QREFELT $ 162))
                               (QREFELT $ 201))
                     (SPADCALL |g| (SPADCALL |trn_wrk| 2 (QREFELT $ 162))
                               (QREFELT $ 199))
                     (LETT |g| (SPADCALL |g| |lst_1| |lst_1| (QREFELT $ 142)))
                     (SPADCALL |g| (QREFELT $ 210))
                     (QSETVELT |g| 4 (QVELT |f| 4))
                     (EXIT (PROGN (LETT #1# |g|) (GO #4=#:G1939))))))
                  (EXIT |g|)))))
          #4# (EXIT #1#)))) 

(SDEFUN |FDALG;minimize;2$;136| ((|f| ($)) ($ ($)))
        (SPROG
         ((|n| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
          (|blo_mtx| (|Matrix| (|NonNegativeInteger|)))
          (|k| (|NonNegativeInteger|)) (|flg_wrk| (|Boolean|)) (#1=#:G1954 NIL)
          (|als| ($)) (#2=#:G1949 NIL) (#3=#:G1945 NIL)
          (|k_l| (|NonNegativeInteger|)) (#4=#:G1944 NIL))
         (SEQ (LETT |als| (SPADCALL |f| (QREFELT $ 51)))
              (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153))) (LETT |k| 2)
              (LETT |n| (QVELT |als| 0))
              (LETT |m| (SPADCALL |blo_mtx| (QREFELT $ 154)))
              (SEQ G190 (COND ((NULL (<= |k| |m|)) (GO G191)))
                   (SEQ
                    (LETT |k_l|
                          (PROG1 (LETT #4# (- (+ |m| 1) |k|))
                            (|check_subtype2| (>= #4# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #4#)))
                    (LETT |flg_wrk| 'T)
                    (LETT |als|
                          (SPADCALL |als|
                                    (SPADCALL |blo_mtx| |k_l| 1
                                              (QREFELT $ 184))
                                    (SPADCALL |blo_mtx| |k_l| 2
                                              (QREFELT $ 184))
                                    (QREFELT $ 303)))
                    (COND
                     ((< (QVELT |als| 0) |n|)
                      (SEQ
                       (COND
                        ((> |k| 2)
                         (COND
                          ((> (* 2 |k|) (+ |m| 1))
                           (LETT |k|
                                 (PROG1 (LETT #3# (- |k| 1))
                                   (|check_subtype2| (>= #3# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #3#)))))))
                       (EXIT (LETT |flg_wrk| NIL)))))
                    (COND
                     (|flg_wrk|
                      (COND
                       ((EQL |k_l| 1)
                        (SEQ (LETT |als| (SPADCALL |als| (QREFELT $ 301)))
                             (LETT |als|
                                   (SPADCALL |als|
                                             (+
                                              (SPADCALL |blo_mtx| |k_l| 1
                                                        (QREFELT $ 184))
                                              1)
                                             (+
                                              (SPADCALL |blo_mtx| |k_l| 2
                                                        (QREFELT $ 184))
                                              1)
                                             (QREFELT $ 303)))
                             (LETT |als| (SPADCALL |als| (QREFELT $ 302)))
                             (EXIT
                              (COND
                               ((< (QVELT |als| 0) |n|)
                                (SEQ
                                 (COND
                                  ((> |k| 2)
                                   (COND
                                    ((> (* 2 |k|) (+ |m| 1))
                                     (LETT |k|
                                           (PROG1 (LETT #2# (- |k| 1))
                                             (|check_subtype2| (>= #2# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #2#)))))))
                                 (EXIT (LETT |flg_wrk| NIL)))))))))))
                    (COND
                     (|flg_wrk|
                      (SEQ
                       (LETT |als|
                             (SPADCALL |als|
                                       (SPADCALL |blo_mtx| |k| 1
                                                 (QREFELT $ 184))
                                       (SPADCALL |blo_mtx| |k| 2
                                                 (QREFELT $ 184))
                                       (QREFELT $ 304)))
                       (EXIT
                        (COND
                         ((< (QVELT |als| 0) |n|)
                          (SEQ
                           (COND
                            ((> |k| 2)
                             (COND
                              ((> (* 2 |k|) (+ |m| 1))
                               (LETT |k|
                                     (PROG1 (LETT #1# (- |k| 1))
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|)
                                                         #1#)))))))
                           (EXIT (LETT |flg_wrk| NIL)))))))))
                    (EXIT
                     (COND (|flg_wrk| (LETT |k| (+ |k| 1)))
                           ('T
                            (SEQ
                             (LETT |blo_mtx| (SPADCALL |als| (QREFELT $ 153)))
                             (LETT |m| (SPADCALL |blo_mtx| (QREFELT $ 154)))
                             (EXIT (LETT |n| (QVELT |als| 0))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND
               ((SPADCALL |f| (QREFELT $ 155))
                (SEQ (QSETVELT |als| 3 'T) (EXIT (QSETVELT |als| 4 'T)))))
              (EXIT |als|)))) 

(SDEFUN |FDALG;addMIN;3$;137| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPROG ((|als| ($)))
               (SEQ
                (LETT |als|
                      (SPADCALL (SPADCALL |f| |g| (QREFELT $ 234))
                                (QREFELT $ 305)))
                (SPADCALL |als| (QREFELT $ 213)) (EXIT |als|)))) 

(SDEFUN |FDALG;multiplyMIN;3$;138| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPROG ((|als| ($)))
               (SEQ
                (LETT |als|
                      (SPADCALL (SPADCALL |f| |g| (QREFELT $ 236))
                                (QREFELT $ 305)))
                (SPADCALL |als| (QREFELT $ 213)) (EXIT |als|)))) 

(SDEFUN |FDALG;*;I2$;139| ((|gamma| (|Integer|)) (|f| ($)) ($ ($)))
        (SPADCALL |f| (SPADCALL |gamma| (QREFELT $ 308)) (QREFELT $ 230))) 

(SDEFUN |FDALG;*;F2$;140| ((|alpha| (F)) (|f| ($)) ($ ($)))
        (SPADCALL |f| |alpha| (QREFELT $ 230))) 

(SDEFUN |FDALG;*;$F$;141| ((|f| ($)) (|alpha| (F)) ($ ($)))
        (SPADCALL |f| |alpha| (QREFELT $ 230))) 

(SDEFUN |FDALG;*;3$;142| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPADCALL |f| |g| (QREFELT $ 307))) 

(SDEFUN |FDALG;-;$F$;143| ((|f| ($)) (|alpha| (F)) ($ ($)))
        (SPADCALL |f|
                  (SPADCALL (SPADCALL |alpha| (QREFELT $ 64)) (QREFELT $ 313))
                  (QREFELT $ 306))) 

(SDEFUN |FDALG;+;$F$;144| ((|f| ($)) (|alpha| (F)) ($ ($)))
        (SPADCALL |f| (SPADCALL |alpha| (QREFELT $ 64)) (QREFELT $ 306))) 

(SDEFUN |FDALG;-;F2$;145| ((|alpha| (F)) (|f| ($)) ($ ($)))
        (SPADCALL (SPADCALL |alpha| (QREFELT $ 64))
                  (SPADCALL |f| (QREFELT $ 313)) (QREFELT $ 306))) 

(SDEFUN |FDALG;+;F2$;146| ((|alpha| (F)) (|f| ($)) ($ ($)))
        (SPADCALL (SPADCALL |alpha| (QREFELT $ 64)) |f| (QREFELT $ 306))) 

(SDEFUN |FDALG;-;3$;147| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPADCALL |f| (SPADCALL |g| (QREFELT $ 313)) (QREFELT $ 306))) 

(SDEFUN |FDALG;+;3$;148| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPADCALL |f| |g| (QREFELT $ 306))) 

(SDEFUN |FDALG;-;2$;149| ((|f| ($)) ($ ($)))
        (SPADCALL |f| (SPADCALL (|spadConstant| $ 15) (QREFELT $ 58))
                  (QREFELT $ 62))) 

(SDEFUN |FDALG;/;$F$;150| ((|f| ($)) (|alpha| (F)) ($ ($)))
        (COND
         ((SPADCALL |alpha| (QREFELT $ 48))
          (|error| "FDALG: f / alpha - division by zero."))
         ('T
          (SPADCALL |f|
                    (SPADCALL (|spadConstant| $ 15) |alpha| (QREFELT $ 209))
                    (QREFELT $ 62))))) 

(SDEFUN |FDALG;^;$Pi$;151| ((|f| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (SPROG ((|f_wrk| ($)) (#1=#:G1990 NIL) (|k| NIL))
               (SEQ (LETT |f_wrk| |f|)
                    (SEQ (LETT |k| 2) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |k| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |f_wrk|
                                 (SPADCALL |f_wrk| |f| (QREFELT $ 307)))))
                         (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |f_wrk|)))) 

(SDEFUN |FDALG;standardVector?| ((|f| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G1992 NIL))
               (|FDALG;qzerov?| (QVELT |f| 2) 1
                (PROG1 (LETT #1# (- (QVELT |f| 0) 1))
                  (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #1#))
                $))) 

(SDEFUN |FDALG;standardFirstColumn?| ((|f| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G2002 NIL) (#2=#:G2003 NIL) (|l| NIL) (|a_ref| (|List| F))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QVELT |f| 0))
                (LETT |a_ref| (|FDALG;qlstA| (QVELT |f| 2) 1 1 $))
                (SEQ (LETT |l| 2) (LETT #2# (LENGTH (QVELT |f| 1))) G190
                     (COND ((|greater_SI| |l| #2#) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((NULL
                          (SPADCALL (SPADCALL |a_ref| |l| (QREFELT $ 75))
                                    (QREFELT $ 48)))
                         (PROGN (LETT #1# NIL) (GO #3=#:G2001))))))
                     (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((SPADCALL (SPADCALL |a_ref| 1 (QREFELT $ 75))
                            (|spadConstant| $ 15) (QREFELT $ 76))
                  (COND
                   ((NULL (|FDALG;qsemizeroA?| (QVELT |f| 2) 2 |n| 1 1 1 $))
                    (PROGN (LETT #1# NIL) (GO #3#)))))
                 ('T (PROGN (LETT #1# NIL) (GO #3#))))
                (EXIT 'T)))
          #3# (EXIT #1#)))) 

(SDEFUN |FDALG;standardLastRow?| ((|f| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G2013 NIL) (#2=#:G2008 NIL) (#3=#:G2014 NIL) (|l| NIL)
          (|a_ref| (|List| F)) (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QVELT |f| 0))
                (LETT |a_ref| (|FDALG;qlstA| (QVELT |f| 2) |n| |n| $))
                (SEQ (LETT |l| 2) (LETT #3# (LENGTH (QVELT |f| 1))) G190
                     (COND ((|greater_SI| |l| #3#) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((NULL
                          (SPADCALL (SPADCALL |a_ref| |l| (QREFELT $ 75))
                                    (QREFELT $ 48)))
                         (PROGN (LETT #1# NIL) (GO #4=#:G2012))))))
                     (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((SPADCALL (SPADCALL |a_ref| 1 (QREFELT $ 75))
                            (|spadConstant| $ 15) (QREFELT $ 76))
                  (COND
                   ((NULL
                     (|FDALG;qsemizeroA?| (QVELT |f| 2) |n| |n| 1
                      (PROG1 (LETT #2# (- |n| 1))
                        (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #2#))
                      1 $))
                    (PROGN (LETT #1# NIL) (GO #4#)))))
                 ('T (PROGN (LETT #1# NIL) (GO #4#))))
                (EXIT 'T)))
          #4# (EXIT #1#)))) 

(SDEFUN |FDALG;invertMIN;2$;155| ((|f| ($)) ($ ($)))
        (SPROG
         ((|f_inv| ($)) (#1=#:G2048 NIL) (#2=#:G2042 NIL) (#3=#:G2056 NIL)
          (|k| NIL) (#4=#:G2039 NIL) (#5=#:G2055 NIL) (|U_wrk| #6=(|Matrix| F))
          (|T_wrk| #6#) (#7=#:G2054 NIL) (#8=#:G2033 NIL) (#9=#:G2053 NIL)
          (#10=#:G2030 NIL) (#11=#:G2052 NIL) (#12=#:G2051 NIL)
          (#13=#:G2023 NIL) (#14=#:G2022 NIL) (#15=#:G2050 NIL)
          (#16=#:G2049 NIL) (|m| #17=(|NonNegativeInteger|)) (#18=#:G2018 NIL)
          (|flg_row| (|Boolean|)) (|flg_col| (|Boolean|))
          (|flg_vec| (|Boolean|)) (|n| #17#) (|f_wrk| ($)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |f| (QREFELT $ 81))
              (COND
               ((SPADCALL (|FDALG;qeltv| (QVELT |f| 2) 1 1 $) (QREFELT $ 48))
                (|error|
                 "FDALG: invertMIN(f) - zero element is not invertible."))
               ('T
                (PROGN
                 (LETT #1#
                       (SPADCALL (|spadConstant| $ 14)
                                 (SPADCALL (|spadConstant| $ 15)
                                           (|FDALG;qeltv| (QVELT |f| 2) 1 1 $)
                                           (QREFELT $ 209))
                                 (QREFELT $ 62)))
                 (GO #19=#:G2047))))))
            (LETT |f_wrk| (SPADCALL |f| (QREFELT $ 51)))
            (SPADCALL |f_wrk| (QREFELT $ 280)) (LETT |n| (QVELT |f_wrk| 0))
            (LETT |m| (QVELT |f_wrk| 0))
            (LETT |flg_vec| (|FDALG;standardVector?| |f_wrk| $))
            (LETT |flg_col| (|FDALG;standardFirstColumn?| |f_wrk| $))
            (LETT |flg_row| (|FDALG;standardLastRow?| |f_wrk| $))
            (COND
             (|flg_vec|
              (COND
               (|flg_col|
                (COND
                 (|flg_row|
                  (SEQ
                   (LETT |m|
                         (PROG1 (LETT #18# (- (QVELT |f_wrk| 0) 1))
                           (|check_subtype2| (>= #18# 0)
                                             '(|NonNegativeInteger|)
                                             '(|Integer|) #18#)))
                   (LETT |f_inv|
                         (SPADCALL |m| (QVELT |f_wrk| 1) (QREFELT $ 35)))
                   (SEQ (LETT |k| 1) (LETT #16# (LENGTH (QVELT |f_inv| 1)))
                        G190 (COND ((|greater_SI| |k| #16#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SPADCALL (QVELT |f_inv| 2) 2 2 |k|
                                    (SPADCALL (QVELT |f_wrk| 2) 2 |n| 3
                                              (+ |n| 1) |k| (QREFELT $ 20))
                                    (QREFELT $ 22))))
                        (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                   (LETT |T_wrk|
                         (MAKE_MATRIX1 (+ |m| 1) (+ |m| 1)
                                       (|spadConstant| $ 50)))
                   (LETT |U_wrk|
                         (MAKE_MATRIX1 (+ |m| 1) (+ |m| 1)
                                       (|spadConstant| $ 50)))
                   (QSETAREF2O |T_wrk| 1 1 (|spadConstant| $ 15) 1 1)
                   (QSETAREF2O |U_wrk| 1 1 (|spadConstant| $ 15) 1 1)
                   (SEQ (LETT |k| 1) (LETT #15# |m|) G190
                        (COND ((|greater_SI| |k| #15#) (GO G191)))
                        (SEQ
                         (QSETAREF2O |T_wrk| (+ |k| 1)
                                     (PROG1 (LETT #14# (- (+ |m| 2) |k|))
                                       (|check_subtype2| (>= #14# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #14#))
                                     (SPADCALL (|spadConstant| $ 15)
                                               (QREFELT $ 58))
                                     1 1)
                         (EXIT
                          (QSETAREF2O |U_wrk| (+ |k| 1)
                                      (PROG1 (LETT #13# (- (+ |m| 2) |k|))
                                        (|check_subtype2| (>= #13# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #13#))
                                      (|spadConstant| $ 15) 1 1)))
                        (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                   (QSETAREF2O |U_wrk| (+ |m| 1) 2
                               (|FDALG;qeltv| (QVELT |f_wrk| 2) |n| 1 $) 1 1)
                   (SPADCALL (QVELT |f_inv| 2) |T_wrk| (QREFELT $ 206))
                   (SPADCALL (QVELT |f_inv| 2) |U_wrk| (QREFELT $ 208))
                   (|FDALG;qsetu!| (QVELT |f_inv| 2) |m| 1
                    (|spadConstant| $ 50) $)
                   (|FDALG;qsetu!| (QVELT |f_inv| 2) 1 1 (|spadConstant| $ 15)
                    $)
                   (|FDALG;qsetv!| (QVELT |f_inv| 2) |m| 1
                    (|spadConstant| $ 15) $)
                   (QSETVELT |f_inv| 4 NIL)
                   (QSETVELT |f_inv| 3 (QVELT |f_wrk| 3))
                   (SPADCALL |f_inv| NIL (QREFELT $ 323))
                   (SPADCALL |f_inv| (QREFELT $ 213))
                   (EXIT (PROGN (LETT #1# |f_inv|) (GO #19#))))))))))
            (COND
             (|flg_vec|
              (COND
               (|flg_col|
                (SEQ
                 (LETT |f_inv| (SPADCALL |m| (QVELT |f_wrk| 1) (QREFELT $ 35)))
                 (SEQ (LETT |k| 1) (LETT #12# (LENGTH (QVELT |f_inv| 1))) G190
                      (COND ((|greater_SI| |k| #12#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SPADCALL (QVELT |f_inv| 2) 2 3 |k|
                                  (SPADCALL (QVELT |f_wrk| 2) 2 (+ |n| 1) 3
                                            (+ |n| 1) |k| (QREFELT $ 20))
                                  (QREFELT $ 22))))
                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                 (LETT |T_wrk|
                       (MAKE_MATRIX1 (+ |m| 1) (+ |m| 1)
                                     (|spadConstant| $ 50)))
                 (LETT |U_wrk|
                       (MAKE_MATRIX1 (+ |m| 1) (+ |m| 1)
                                     (|spadConstant| $ 50)))
                 (QSETAREF2O |T_wrk| 1 1 (|spadConstant| $ 15) 1 1)
                 (QSETAREF2O |U_wrk| 1 1 (|spadConstant| $ 15) 1 1)
                 (QSETAREF2O |U_wrk| 2 2 (|spadConstant| $ 15) 1 1)
                 (SEQ (LETT |k| 1) (LETT #11# |m|) G190
                      (COND ((|greater_SI| |k| #11#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF2O |T_wrk| (+ |k| 1)
                                    (PROG1 (LETT #10# (- (+ |m| 2) |k|))
                                      (|check_subtype2| (>= #10# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #10#))
                                    (SPADCALL (|spadConstant| $ 15)
                                              (QREFELT $ 58))
                                    1 1)))
                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                 (SEQ (LETT |k| 2) (LETT #9# |m|) G190
                      (COND ((|greater_SI| |k| #9#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF2O |U_wrk| (+ |k| 1)
                                    (PROG1 (LETT #8# (- (+ |m| 3) |k|))
                                      (|check_subtype2| (>= #8# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #8#))
                                    (|spadConstant| $ 15) 1 1)))
                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                 (QSETAREF2O |T_wrk| 2 (+ |m| 1)
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 15)
                                        (|FDALG;qeltv| (QVELT |f_wrk| 2) |n| 1
                                         $)
                                        (QREFELT $ 209))
                              (QREFELT $ 58))
                             1 1)
                 (SPADCALL (QVELT |f_inv| 2) |T_wrk| (QREFELT $ 206))
                 (SPADCALL (QVELT |f_inv| 2) |U_wrk| (QREFELT $ 208))
                 (|FDALG;qsetu!| (QVELT |f_inv| 2) 1 1 (|spadConstant| $ 15) $)
                 (|FDALG;qsetv!| (QVELT |f_inv| 2) |m| 1 (|spadConstant| $ 15)
                  $)
                 (|FDALG;qsetA!| (QVELT |f_inv| 2) 1 1 1 (|spadConstant| $ 15)
                  $)
                 (LETT |f_inv| (SPADCALL |f_inv| (QREFELT $ 305)))
                 (QSETVELT |f_inv| 4 NIL)
                 (QSETVELT |f_inv| 3 (QVELT |f_wrk| 3))
                 (SPADCALL |f_inv| NIL (QREFELT $ 323))
                 (SPADCALL |f_inv| (QREFELT $ 213))
                 (EXIT (PROGN (LETT #1# |f_inv|) (GO #19#))))))))
            (COND
             (|flg_vec|
              (COND
               (|flg_row|
                (SEQ
                 (LETT |f_inv| (SPADCALL |m| (QVELT |f_wrk| 1) (QREFELT $ 35)))
                 (SEQ (LETT |k| 1) (LETT #7# (LENGTH (QVELT |f_inv| 1))) G190
                      (COND ((|greater_SI| |k| #7#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SPADCALL (QVELT |f_inv| 2) 2 2 |k|
                                  (SPADCALL (QVELT |f_wrk| 2) 2 |n| 2 (+ |n| 1)
                                            |k| (QREFELT $ 20))
                                  (QREFELT $ 22))))
                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                 (LETT |T_wrk|
                       (MAKE_MATRIX1 (+ |m| 1) (+ |m| 1)
                                     (|spadConstant| $ 50)))
                 (LETT |U_wrk|
                       (MAKE_MATRIX1 (+ |m| 1) (+ |m| 1)
                                     (|spadConstant| $ 50)))
                 (QSETAREF2O |T_wrk| 1 1 (|spadConstant| $ 15) 1 1)
                 (QSETAREF2O |T_wrk| (+ |m| 1) (+ |m| 1) (|spadConstant| $ 15)
                             1 1)
                 (QSETAREF2O |U_wrk| 1 1 (|spadConstant| $ 15) 1 1)
                 (SEQ (LETT |k| 2) (LETT #5# |m|) G190
                      (COND ((|greater_SI| |k| #5#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF2O |T_wrk| |k|
                                    (PROG1 (LETT #4# (- (+ |m| 2) |k|))
                                      (|check_subtype2| (>= #4# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #4#))
                                    (SPADCALL (|spadConstant| $ 15)
                                              (QREFELT $ 58))
                                    1 1)))
                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                 (SEQ (LETT |k| 1) (LETT #3# |m|) G190
                      (COND ((|greater_SI| |k| #3#) (GO G191)))
                      (SEQ
                       (QSETAREF2O |U_wrk| (+ |k| 1)
                                   (PROG1 (LETT #2# (- (+ |m| 2) |k|))
                                     (|check_subtype2| (>= #2# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #2#))
                                   (|spadConstant| $ 15) 1 1)
                       (EXIT
                        (QSETAREF2O |U_wrk| (+ |m| 1) 2
                                    (|FDALG;qeltv| (QVELT |f_wrk| 2) |n| 1 $) 1
                                    1)))
                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                 (SPADCALL (QVELT |f_inv| 2) |T_wrk| (QREFELT $ 206))
                 (SPADCALL (QVELT |f_inv| 2) |U_wrk| (QREFELT $ 208))
                 (|FDALG;qsetu!| (QVELT |f_inv| 2) |m| 1 (|spadConstant| $ 50)
                  $)
                 (|FDALG;qsetu!| (QVELT |f_inv| 2) 1 1 (|spadConstant| $ 15) $)
                 (|FDALG;qsetv!| (QVELT |f_inv| 2) |m| 1 (|spadConstant| $ 15)
                  $)
                 (|FDALG;qsetA!| (QVELT |f_inv| 2) |m| |m| 1
                  (|spadConstant| $ 15) $)
                 (LETT |f_inv| (SPADCALL |f_inv| (QREFELT $ 305)))
                 (QSETVELT |f_inv| 4 NIL)
                 (QSETVELT |f_inv| 3 (QVELT |f_wrk| 3))
                 (SPADCALL |f_inv| NIL (QREFELT $ 323))
                 (SPADCALL |f_inv| (QREFELT $ 213))
                 (EXIT (PROGN (LETT #1# |f_inv|) (GO #19#))))))))
            (LETT |f_inv|
                  (SPADCALL (SPADCALL |f_wrk| (QREFELT $ 238))
                            (QREFELT $ 305)))
            (QSETVELT |f_inv| 4 NIL) (QSETVELT |f_inv| 3 (QVELT |f_wrk| 3))
            (SPADCALL |f_inv| NIL (QREFELT $ 323))
            (SPADCALL |f_inv| (QREFELT $ 213)) (EXIT |f_inv|)))
          #19# (EXIT #1#)))) 

(SDEFUN |FDALG;inverse;2$;156| ((|f| ($)) ($ ($)))
        (SEQ
         (COND
          ((NULL (QVELT |f| 3))
           (|error| "FDALG: inverse(f) - system is not minimal."))
          ('T
           (SEQ (SPADCALL |f| NIL (QREFELT $ 323))
                (EXIT
                 (SPADCALL (SPADCALL |f| (QREFELT $ 265)) 4
                           (QREFELT $ 324)))))))) 

(SDEFUN |FDALG;inv;2$;157| ((|f| ($)) ($ ($)))
        (COND
         ((NULL (QVELT |f| 3))
          (|error| "FDALG: inv(f) - system is not minimal."))
         ('T (SPADCALL (SPADCALL |f| (QREFELT $ 265)) (QREFELT $ 326))))) 

(SDEFUN |FDALG;/;F2$;158| ((|alpha| (F)) (|f| ($)) ($ ($)))
        (SPROG ((|f_inv| ($)) (#1=#:G2066 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |alpha| (QREFELT $ 48))
                    (PROGN
                     (LETT #1# (SPADCALL (|spadConstant| $ 49) (QREFELT $ 51)))
                     (GO #2=#:G2065))))
                  (LETT |f_inv|
                        (SPADCALL (SPADCALL |f| (QREFELT $ 265))
                                  (QREFELT $ 326)))
                  (|FDALG;qscalev!| (QVELT |f_inv| 2) 1 (QVELT |f_inv| 0) 1
                   |alpha| $)
                  (EXIT |f_inv|)))
                #2# (EXIT #1#)))) 

(SDEFUN |FDALG;/;3$;159| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPROG ((|f_inv| ($)))
               (SEQ
                (COND
                 ((QVELT |g| 4)
                  (COND
                   ((NULL (QVELT |g| 3))
                    (EXIT
                     (|error|
                      #1="FDALG: f / g - g not in minimal refined form.")))))
                 ('T (EXIT (|error| #1#))))
                (LETT |f_inv|
                      (SPADCALL (SPADCALL |g| (QREFELT $ 265))
                                (QREFELT $ 326)))
                (EXIT (SPADCALL |f| |f_inv| (QREFELT $ 307)))))) 

(SDEFUN |FDALG;^;$I$;160| ((|f| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((#1=#:G2076 NIL) (#2=#:G2072 NIL) (|g| ($)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((ZEROP |n|)
                    (PROGN (LETT #1# (|spadConstant| $ 14)) (GO #3=#:G2075))))
                  (COND
                   ((< |n| 0)
                    (SEQ (LETT |g| (SPADCALL |f| (QREFELT $ 327)))
                         (EXIT
                          (PROGN
                           (LETT #1#
                                 (SPADCALL |g|
                                           (PROG1 (LETT #2# (- |n|))
                                             (|check_subtype2| (> #2# 0)
                                                               '(|PositiveInteger|)
                                                               '(|Integer|)
                                                               #2#))
                                           (QREFELT $ 322)))
                           (GO #3#))))))
                  (EXIT (SPADCALL |f| |n| (QREFELT $ 330)))))
                #3# (EXIT #1#)))) 

(SDEFUN |FDALG;qrefinementTransformations|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|))
         (|sol| (|List| (|Equation| (|Polynomial| F))))
         ($ (|List| (|Matrix| F))))
        (SPROG
         ((|col_Q| #1=(|List| (|NonNegativeInteger|))) (|row_Q| #1#)
          (|col_P| #1#) (#2=#:G2078 NIL) (|row_P| #1#)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |row_P|
                    (SPADCALL (+ 1 |i_min|) (+ 1 |i_max|) (QREFELT $ 28)))
              (LETT |col_P|
                    (SPADCALL (+ 1 |i_min|)
                              (+ 1
                                 (MIN |i_max|
                                      (PROG1 (LETT #2# (- |n| 1))
                                        (|check_subtype2| (>= #2# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #2#))))
                              (QREFELT $ 28)))
              (LETT |row_Q|
                    (SPADCALL (+ 1 (MAX |i_min| 2)) (+ 1 |i_max|)
                              (QREFELT $ 28)))
              (LETT |col_Q|
                    (SPADCALL (+ 1 |i_min|) (+ 1 |i_max|) (QREFELT $ 28)))
              (EXIT
               (SPADCALL (QVELT |f| 2) |row_P| |col_P| |row_Q| |col_Q| |sol|
                         (QREFELT $ 276)))))) 

(SDEFUN |FDALG;refinementTransformations;$2NniLL;162|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|))
         (|sol| (|List| (|Equation| (|Polynomial| F))))
         ($ (|List| (|Matrix| F))))
        (SPROG
         ((|lst_trn| (|List| (|Matrix| F)))
          (|col_Q| #1=(|List| (|NonNegativeInteger|))) (|row_Q| #1#)
          (|col_P| #1#) (#2=#:G2082 NIL) (|row_P| #1#)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0))
              (LETT |row_P|
                    (SPADCALL (+ 1 |i_min|) (+ 1 |i_max|) (QREFELT $ 28)))
              (LETT |col_P|
                    (SPADCALL (+ 1 |i_min|)
                              (+ 1
                                 (MIN |i_max|
                                      (PROG1 (LETT #2# (- |n| 1))
                                        (|check_subtype2| (>= #2# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #2#))))
                              (QREFELT $ 28)))
              (LETT |row_Q|
                    (SPADCALL (+ 1 (MAX |i_min| 2)) (+ 1 |i_max|)
                              (QREFELT $ 28)))
              (LETT |col_Q|
                    (SPADCALL (+ 1 |i_min|) (+ 1 |i_max|) (QREFELT $ 28)))
              (LETT |lst_trn|
                    (SPADCALL (QVELT |f| 2) |row_P| |col_P| |row_Q| |col_Q|
                              |sol| (QREFELT $ 276)))
              (EXIT
               (LIST
                (SPADCALL (SPADCALL |lst_trn| 1 (QREFELT $ 162)) (+ 1 1)
                          (+ 1 |n|) (+ 1 1) (+ 1 |n|) (QREFELT $ 163))
                (SPADCALL (SPADCALL |lst_trn| 2 (QREFELT $ 162)) (+ 1 1)
                          (+ 1 |n|) (+ 1 1) (+ 1 |n|) (QREFELT $ 163))))))) 

(SDEFUN |FDALG;refinementEquations;$3Nni2BL;163|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) (|k_rows| (|NonNegativeInteger|))
         (|flg_u| (|Boolean|)) (|flg_r| (|Boolean|))
         ($ (|List| (|Polynomial| F))))
        (SPROG
         ((|lst_eqn| (|List| (|Polynomial| F)))
          (|cex2| (|List| (|NonNegativeInteger|)))
          (|rex2| (|List| (|NonNegativeInteger|))) (#1=#:G2091 NIL)
          (|cex1| (|List| (|NonNegativeInteger|)))
          (|rex1| (|List| (|NonNegativeInteger|))) (#2=#:G2089 NIL)
          (|cdst| #3=(|List| (|NonNegativeInteger|))) (|rdst| #3#)
          (#4=#:G2088 NIL) (|j_max| (|NonNegativeInteger|)) (#5=#:G2087 NIL)
          (|j_min| (|NonNegativeInteger|)) (|col_Q| #3#) (|row_Q| #3#)
          (|col_P| #3#) (#6=#:G2086 NIL) (|row_P| #3#))
         (SEQ
          (LETT |row_P| (SPADCALL (+ 1 |i_min|) (+ 1 |i_max|) (QREFELT $ 28)))
          (LETT |col_P|
                (SPADCALL (+ 1 |i_min|)
                          (+ 1
                             (MIN |i_max|
                                  (PROG1 (LETT #6# (- (QVELT |f| 0) 1))
                                    (|check_subtype2| (>= #6# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #6#))))
                          (QREFELT $ 28)))
          (LETT |row_Q|
                (SPADCALL (+ 1 (MAX |i_min| 2)) (+ 1 |i_max|) (QREFELT $ 28)))
          (LETT |col_Q| (SPADCALL (+ 1 |i_min|) (+ 1 |i_max|) (QREFELT $ 28)))
          (LETT |j_min| |i_min|)
          (LETT |j_max|
                (PROG1 (LETT #5# (- |i_max| |k_rows|))
                  (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #5#)))
          (LETT |rdst|
                (SPADCALL
                 (+ 1
                    (PROG1 (LETT #4# (+ (- |i_max| |k_rows|) 1))
                      (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #4#)))
                 (+ 1 |i_max|) (QREFELT $ 28)))
          (LETT |cdst| (SPADCALL (+ 1 |j_min|) (+ 1 |j_max|) (QREFELT $ 28)))
          (LETT |rex1| NIL) (LETT |cex1| NIL)
          (COND
           (|flg_u|
            (SEQ
             (LETT |rex1|
                   (SPADCALL (+ 1 1)
                             (+ 1
                                (PROG1 (LETT #2# (- |i_min| 1))
                                  (|check_subtype2| (>= #2# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #2#)))
                             (QREFELT $ 28)))
             (EXIT
              (LETT |cex1|
                    (SPADCALL (+ (+ 1 |i_min|) 1) (+ 1 |i_max|)
                              (QREFELT $ 28)))))))
          (LETT |rex2| NIL) (LETT |cex2| NIL)
          (COND
           (|flg_r|
            (SEQ
             (LETT |rex2|
                   (SPADCALL (+ 1 |i_min|)
                             (+ 1
                                (PROG1 (LETT #1# (- |i_max| 1))
                                  (|check_subtype2| (>= #1# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #1#)))
                             (QREFELT $ 28)))
             (EXIT
              (LETT |cex2|
                    (SPADCALL (+ (+ 1 |i_max|) 1) (+ 1 (QVELT |f| 0))
                              (QREFELT $ 28)))))))
          (LETT |lst_eqn|
                (SPADCALL (QVELT |f| 2) |row_P| |col_P| |row_Q| |col_Q| |rdst|
                          |cdst| |rex1| |cex1| |rex2| |cex2| (QREFELT $ 286)))
          (EXIT |lst_eqn|)))) 

(SDEFUN |FDALG;refinementGroebner;$3Nni2BL;164|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) (|k_rows| (|NonNegativeInteger|))
         (|flg_1| (|Boolean|)) (|flg_2| (|Boolean|))
         ($ (|List| (|Polynomial| F))))
        (SPROG
         ((|lst_gro| (|List| (|Polynomial| F))) (#1=#:G2105 NIL) (|eqn| NIL)
          (#2=#:G2104 NIL) (|bas_gro| (|List| |tDMP|))
          (|eqn_wrk| (|List| |tDMP|)) (#3=#:G2103 NIL) (#4=#:G2102 NIL)
          (|tPRD|
           (|DirectProductCategory| (|#| |lst_var|) (|NonNegativeInteger|)))
          (|tDMP|
           (|Join|
            (|PolynomialCategory| F
                                  (|DirectProduct| (|#| |lst_var|)
                                                   (|NonNegativeInteger|))
                                  (|OrderedVariableList| |lst_var|))
            (CATEGORY |domain|
             (SIGNATURE |reorder| ($ $ (|List| (|Integer|)))))))
          (|lst_var| (|List| (|Symbol|)))
          (|tmp_var| (|List| (|List| (|Symbol|))))
          (|lst_eqn| (|List| (|Polynomial| F))))
         (SEQ
          (LETT |lst_eqn|
                (SPADCALL |f| |i_min| |i_max| |k_rows| |flg_1| |flg_2|
                          (QREFELT $ 332)))
          (LETT |tmp_var| (SPADCALL (ELT $ 289) |lst_eqn| (QREFELT $ 293)))
          (LETT |lst_var|
                (SPADCALL (SPADCALL |tmp_var| (QREFELT $ 294))
                          (QREFELT $ 295)))
          (LETT |tDMP|
                (|DistributedMultivariatePolynomial| |lst_var| (QREFELT $ 7)))
          (LETT |tPRD|
                (|DirectProduct| (LENGTH |lst_var|) (|NonNegativeInteger|)))
          (LETT |eqn_wrk|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |eqn| NIL) (LETT #3# |lst_eqn|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |eqn| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS
                               (SPADCALL |eqn|
                                         (|compiledLookupCheck| '|pToDmp|
                                                                (LIST
                                                                 (LIST
                                                                  '|DistributedMultivariatePolynomial|
                                                                  |lst_var|
                                                                  (|devaluate|
                                                                   (ELT $ 7)))
                                                                 (LIST
                                                                  '|Polynomial|
                                                                  (|devaluate|
                                                                   (ELT $ 7))))
                                                                (|PolToPol|
                                                                 |lst_var|
                                                                 (ELT $ 7))))
                               #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |bas_gro|
                (SPADCALL |eqn_wrk|
                          (|compiledLookupCheck| '|groebner|
                                                 (LIST
                                                  (LIST '|List|
                                                        (|devaluate| |tDMP|))
                                                  (LIST '|List|
                                                        (|devaluate| |tDMP|)))
                                                 (|GroebnerPackage| (ELT $ 7)
                                                                    |tPRD|
                                                                    |tDMP|))))
          (LETT |lst_gro|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |eqn| NIL) (LETT #1# |bas_gro|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |eqn| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL |eqn|
                                         (|compiledLookupCheck| '|dmpToP|
                                                                (LIST
                                                                 (LIST
                                                                  '|Polynomial|
                                                                  (|devaluate|
                                                                   (ELT $ 7)))
                                                                 (LIST
                                                                  '|DistributedMultivariatePolynomial|
                                                                  |lst_var|
                                                                  (|devaluate|
                                                                   (ELT $ 7))))
                                                                (|PolToPol|
                                                                 |lst_var|
                                                                 (ELT $ 7))))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT |lst_gro|)))) 

(SDEFUN |FDALG;refinementSolve;$3Nni2BL;165|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) (|k_rows| (|NonNegativeInteger|))
         (|flg_u| (|Boolean|)) (|flg_r| (|Boolean|))
         ($ (|List| (|List| (|Equation| (|Polynomial| F))))))
        (SPROG
         ((|lst_sol| (|List| (|List| (|Equation| (|Polynomial| F)))))
          (#1=#:G2113 NIL)
          (|sol_wrk| (|List| (|List| (|Equation| (|Polynomial| F)))))
          (|lst_wrk| (|List| (|Polynomial| F))) (|k| NIL)
          (|lst_val| (|List| F)) (|lst_eqn| (|List| (|Polynomial| F))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |lst_eqn|
                  (SPADCALL |f| |i_min| |i_max| |k_rows| |flg_u| |flg_r|
                            (QREFELT $ 333)))
            (LETT |lst_val| (LIST (|spadConstant| $ 50))) (LETT |lst_wrk| NIL)
            (LETT |lst_sol| NIL)
            (SEQ (LETT |k| (LENGTH |lst_eqn|)) G190
                 (COND ((< |k| 1) (GO G191)))
                 (SEQ
                  (LETT |lst_wrk|
                        (CONS (SPADCALL |lst_eqn| |k| (QREFELT $ 297))
                              |lst_wrk|))
                  (LETT |sol_wrk|
                        (SPADCALL |lst_wrk| |lst_val| |lst_sol|
                                  (QREFELT $ 298)))
                  (COND
                   ((ZEROP (LENGTH |sol_wrk|))
                    (PROGN (LETT #1# NIL) (GO #2=#:G2112))))
                  (EXIT (LETT |lst_sol| (SPADCALL |sol_wrk| (QREFELT $ 299)))))
                 (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
            (EXIT |lst_sol|)))
          #2# (EXIT #1#)))) 

(SDEFUN |FDALG;qrefinedGroebner?|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) (|i| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPROG ((#1=#:G2119 NIL) (|groe| (|List| (|Polynomial| F))))
               (SEQ
                (EXIT
                 (SEQ
                  (LETT |groe|
                        (SPADCALL |f| |i_min| |i_max| |i| NIL NIL
                                  (QREFELT $ 333)))
                  (COND
                   ((> (LENGTH |groe|) 1)
                    (PROGN (LETT #1# NIL) (GO #2=#:G2118))))
                  (COND
                   ((SPADCALL (|SPADfirst| |groe|) (|spadConstant| $ 335)
                              (QREFELT $ 336))
                    (PROGN (LETT #1# NIL) (GO #2#))))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |FDALG;qrefined?|
        ((|f| ($)) (|max_sze| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPROG
         ((|flg_ref| (|Boolean|)) (#1=#:G2131 NIL) (#2=#:G2133 NIL)
          (#3=#:G2124 NIL) (|i| NIL) (|m| (|NonNegativeInteger|))
          (#4=#:G2132 NIL) (|k| NIL)
          (|blo_mtx| (|Matrix| (|NonNegativeInteger|))))
         (SEQ
          (EXIT
           (SEQ (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153)))
                (LETT |flg_ref| 'T)
                (SEQ (LETT |k| 1)
                     (LETT #4# (SPADCALL |blo_mtx| (QREFELT $ 154))) G190
                     (COND ((|greater_SI| |k| #4#) (GO G191)))
                     (SEQ (LETT |m| (SPADCALL |blo_mtx| |k| 3 (QREFELT $ 184)))
                          (EXIT
                           (COND
                            ((<= |m| |max_sze|)
                             (SEQ (LETT |i| 1)
                                  (LETT #2#
                                        (PROG1 (LETT #3# (- |m| 1))
                                          (|check_subtype2| (>= #3# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #3#)))
                                  G190
                                  (COND ((|greater_SI| |i| #2#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((NULL
                                       (|FDALG;qrefinedGroebner?| |f|
                                        (SPADCALL |blo_mtx| |k| 1
                                                  (QREFELT $ 184))
                                        (SPADCALL |blo_mtx| |k| 2
                                                  (QREFELT $ 184))
                                        |i| $))
                                      (PROGN
                                       (LETT #1# NIL)
                                       (GO #5=#:G2130))))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT NIL)))
                            ('T (LETT |flg_ref| NIL)))))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                (EXIT |flg_ref|)))
          #5# (EXIT #1#)))) 

(SDEFUN |FDALG;setRefined!;$Nni$;168|
        ((|f| ($)) (|max_sze| (|NonNegativeInteger|)) ($ ($)))
        (SEQ (COND ((|FDALG;qrefined?| |f| |max_sze| $) (QSETVELT |f| 4 'T)))
             (EXIT |f|))) 

(SDEFUN |FDALG;refinePERM!|
        ((|f| ($)) (|i_min| (|NonNegativeInteger|))
         (|i_max| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((#1=#:G2150 NIL) (|flg_tmp| (|Boolean|)) (#2=#:G2153 NIL) (|j| NIL)
          (#3=#:G2151 NIL) (#4=#:G2140 NIL) (#5=#:G2152 NIL) (#6=#:G2139 NIL)
          (|i| NIL) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVELT |f| 0)) (LETT |flg_tmp| NIL)
              (COND
               ((< |i_max| |n|)
                (COND
                 ((NULL |flg_tmp|)
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| |i_min|)
                         (LETT #5#
                               (PROG1 (LETT #6# (- |i_max| 1))
                                 (|check_subtype2| (>= #6# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #6#)))
                         G190 (COND ((> |i| #5#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((|FDALG;qzeromtxA?| (QVELT |f| 2) |i| |i| |i_min|
                              (PROG1 (LETT #4# (- |i_max| 1))
                                (|check_subtype2| (>= #4# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #4#))
                              $)
                             (SEQ (SPADCALL |f| |i| |i_max| (QREFELT $ 115))
                                  (LETT |flg_tmp| 'T)
                                  (EXIT
                                   (PROGN (LETT #3# 1) (GO #7=#:G2143))))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #7# (EXIT #3#))))))
              (COND
               ((> |i_min| 1)
                (COND
                 ((NULL |flg_tmp|)
                  (SEQ
                   (EXIT
                    (SEQ (LETT |j| (+ |i_min| 1)) (LETT #2# |i_max|) G190
                         (COND ((> |j| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((|FDALG;qzeromtxA?| (QVELT |f| 2) (+ |i_min| 1)
                              |i_max| |j| |j| $)
                             (SEQ (SPADCALL |f| |j| |i_min| (QREFELT $ 129))
                                  (LETT |flg_tmp| 'T)
                                  (EXIT
                                   (PROGN (LETT #1# 1) (GO #8=#:G2147))))))))
                         (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                   #8# (EXIT #1#))))))
              (EXIT |f|)))) 

(SDEFUN |FDALG;refine!;$B$;170| ((|f| ($)) (|flg| (|Boolean|)) ($ ($)))
        (SPROG
         ((|blo_mtx| (|Matrix| (|NonNegativeInteger|))) (#1=#:G2185 NIL)
          (|lst_trn| (|List| (|Matrix| F)))
          (|lst_sol| (|List| (|List| (|Equation| (|Polynomial| F)))))
          (#2=#:G2189 NIL) (#3=#:G2172 NIL) (|i| NIL)
          (|i_max| #4=(|NonNegativeInteger|)) (|i_min| #4#) (|m| #4#)
          (#5=#:G2188 NIL) (|k| NIL) (|num_blo| (|NonNegativeInteger|))
          (#6=#:G2167 NIL) (#7=#:G2186 NIL) (#8=#:G2187 NIL) (#9=#:G2158 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (QVELT |f| 0))
                (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153)))
                (COND
                 ((OR (EQL |n| 1)
                      (EQL (SPADCALL |blo_mtx| (QREFELT $ 154)) |n|))
                  (SEQ (QSETVELT |f| 4 'T)
                       (EXIT (PROGN (LETT #7# |f|) (GO #10=#:G2184))))))
                (LETT |num_blo|
                      (PROG1
                          (LETT #9# (- (SPADCALL |blo_mtx| (QREFELT $ 154)) 1))
                        (|check_subtype2| (>= #9# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #9#)))
                (SEQ G190
                     (COND
                      ((NULL
                        (< |num_blo| (SPADCALL |blo_mtx| (QREFELT $ 154))))
                       (GO G191)))
                     (SEQ (LETT |num_blo| (SPADCALL |blo_mtx| (QREFELT $ 154)))
                          (SEQ (LETT |k| 1)
                               (LETT #8# (SPADCALL |blo_mtx| (QREFELT $ 154)))
                               G190 (COND ((|greater_SI| |k| #8#) (GO G191)))
                               (SEQ
                                (LETT |m|
                                      (SPADCALL |blo_mtx| |k| 3
                                                (QREFELT $ 184)))
                                (EXIT
                                 (COND
                                  ((>= |m| 2)
                                   (|FDALG;refinePERM!| |f|
                                    (SPADCALL |blo_mtx| |k| 1 (QREFELT $ 184))
                                    (SPADCALL |blo_mtx| |k| 2 (QREFELT $ 184))
                                    $)))))
                               (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT
                           (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153)))))
                     NIL (GO G190) G191 (EXIT NIL))
                (COND
                 ((NULL |flg|)
                  (SEQ
                   (COND
                    ((EQL (SPADCALL |blo_mtx| (QREFELT $ 154)) (QVELT |f| 0))
                     (QSETVELT |f| 4 'T)))
                   (EXIT (PROGN (LETT #7# |f|) (GO #10#))))))
                (LETT |num_blo|
                      (PROG1
                          (LETT #6# (- (SPADCALL |blo_mtx| (QREFELT $ 154)) 1))
                        (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #6#)))
                (SEQ G190
                     (COND
                      ((NULL
                        (< |num_blo| (SPADCALL |blo_mtx| (QREFELT $ 154))))
                       (GO G191)))
                     (SEQ (LETT |num_blo| (SPADCALL |blo_mtx| (QREFELT $ 154)))
                          (SEQ (LETT |k| 1)
                               (LETT #5# (SPADCALL |blo_mtx| (QREFELT $ 154)))
                               G190 (COND ((|greater_SI| |k| #5#) (GO G191)))
                               (SEQ
                                (LETT |m|
                                      (SPADCALL |blo_mtx| |k| 3
                                                (QREFELT $ 184)))
                                (LETT |i_min|
                                      (SPADCALL |blo_mtx| |k| 1
                                                (QREFELT $ 184)))
                                (LETT |i_max|
                                      (SPADCALL |blo_mtx| |k| 2
                                                (QREFELT $ 184)))
                                (EXIT
                                 (COND
                                  ((>= |m| 2)
                                   (SEQ
                                    (EXIT
                                     (SEQ (LETT |i| 1)
                                          (LETT #2#
                                                (PROG1 (LETT #3# (- |m| 1))
                                                  (|check_subtype2| (>= #3# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #3#)))
                                          G190
                                          (COND
                                           ((|greater_SI| |i| #2#) (GO G191)))
                                          (SEQ
                                           (LETT |lst_sol|
                                                 (SPADCALL |f| |i_min| |i_max|
                                                           |i| 'T 'T
                                                           (QREFELT $ 334)))
                                           (COND
                                            ((ZEROP (LENGTH |lst_sol|))
                                             (LETT |lst_sol|
                                                   (SPADCALL |f| |i_min|
                                                             |i_max| |i| 'T NIL
                                                             (QREFELT $
                                                                      334)))))
                                           (COND
                                            ((ZEROP (LENGTH |lst_sol|))
                                             (LETT |lst_sol|
                                                   (SPADCALL |f| |i_min|
                                                             |i_max| |i| NIL 'T
                                                             (QREFELT $
                                                                      334)))))
                                           (COND
                                            ((ZEROP (LENGTH |lst_sol|))
                                             (LETT |lst_sol|
                                                   (SPADCALL |f| |i_min|
                                                             |i_max| |i| NIL
                                                             NIL
                                                             (QREFELT $
                                                                      334)))))
                                           (EXIT
                                            (COND
                                             ((> (LENGTH |lst_sol|) 0)
                                              (SEQ
                                               (LETT |lst_trn|
                                                     (|FDALG;qrefinementTransformations|
                                                      |f| |i_min| |i_max|
                                                      (|SPADfirst| |lst_sol|)
                                                      $))
                                               (SPADCALL (QVELT |f| 2)
                                                         (SPADCALL |lst_trn| 1
                                                                   (QREFELT $
                                                                            162))
                                                         (QREFELT $ 206))
                                               (SPADCALL (QVELT |f| 2)
                                                         (SPADCALL |lst_trn| 2
                                                                   (QREFELT $
                                                                            162))
                                                         (QREFELT $ 208))
                                               (EXIT
                                                (PROGN
                                                 (LETT #1# 1)
                                                 (GO #11=#:G2178))))))))
                                          (LETT |i| (|inc_SI| |i|)) (GO G190)
                                          G191 (EXIT NIL)))
                                    #11# (EXIT #1#))))))
                               (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT
                           (LETT |blo_mtx| (SPADCALL |f| (QREFELT $ 153)))))
                     NIL (GO G190) G191 (EXIT NIL))
                (SPADCALL |f| (QREFELT $ 213)) (QSETVELT |f| 4 'T) (EXIT |f|)))
          #10# (EXIT #7#)))) 

(SDEFUN |FDALG;refine!;2$;171| ((|f| ($)) ($ ($)))
        (SPADCALL |f| 'T (QREFELT $ 323))) 

(SDEFUN |FDALG;rank;$Nni;172| ((|f| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G2200 NIL) (|als| ($)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |f| (QREFELT $ 71))
                    (SEQ
                     (COND
                      ((EQL (QVELT |f| 0) 1)
                       (COND
                        ((SPADCALL (|FDALG;qeltv| (QVELT |f| 2) 1 1 $)
                                   (QREFELT $ 48))
                         (PROGN (LETT #1# 0) (GO #2=#:G2199))))))
                     (EXIT (PROGN (LETT #1# (QVELT |f| 0)) (GO #2#))))))
                  (LETT |als| (SPADCALL |f| (QREFELT $ 305)))
                  (SPADCALL |als| (QREFELT $ 326))
                  (LETT |als| (SPADCALL |als| (QREFELT $ 305)))
                  (COND
                   ((EQL (QVELT |als| 0) 1)
                    (COND
                     ((SPADCALL (|FDALG;qeltv| (QVELT |als| 2) 1 1 $)
                                (QREFELT $ 48))
                      (PROGN (LETT #1# 0) (GO #2#))))))
                  (EXIT (QVELT |als| 0))))
                #2# (EXIT #1#)))) 

(SDEFUN |FDALG;zero?;$B;173| ((|f| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G2208 NIL) (|als| ($)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((|FDALG;qzerov?| (QVELT |f| 2) 1 (QVELT |f| 0) $)
                    (PROGN (LETT #1# 'T) (GO #2=#:G2207))))
                  (COND
                   ((NULL (SPADCALL |f| (QREFELT $ 71)))
                    (SEQ (LETT |als| (SPADCALL |f| (QREFELT $ 305)))
                         (COND
                          ((|FDALG;qzerov?| (QVELT |als| 2) 1 (QVELT |als| 0)
                            $)
                           (PROGN (LETT #1# 'T) (GO #2#))))
                         (EXIT
                          (COND
                           ((SPADCALL |als| (QREFELT $ 71))
                            (PROGN (LETT #1# NIL) (GO #2#)))
                           ('T
                            (SEQ (SPADCALL |als| (QREFELT $ 326))
                                 (LETT |als| (SPADCALL |als| (QREFELT $ 305)))
                                 (EXIT
                                  (COND
                                   ((|FDALG;qzerov?| (QVELT |als| 2) 1
                                     (QVELT |als| 0) $)
                                    (PROGN (LETT #1# 'T) (GO #2#))))))))))))
                  (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |FDALG;=;2$B;174| ((|f| ($)) (|g| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G2223 NIL) (|trn_wrk| (|List| (|Matrix| F)))
          (|lst_2| #2=(|List| (|NonNegativeInteger|))) (|lst_1| #2#)
          (|als| ($)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |f| (QREFELT $ 81))
              (COND
               ((SPADCALL (|FDALG;qeltv| (QVELT |f| 2) 1 1 $) (QREFELT $ 48))
                (EXIT (SPADCALL |g| (QREFELT $ 338)))))))
            (COND
             ((SPADCALL |g| (QREFELT $ 81))
              (COND
               ((SPADCALL (|FDALG;qeltv| (QVELT |g| 2) 1 1 $) (QREFELT $ 48))
                (EXIT (SPADCALL |f| (QREFELT $ 338)))))))
            (COND
             ((QVELT |f| 3)
              (COND ((< (QVELT |g| 0) (QVELT |f| 0)) (EXIT NIL)))))
            (COND
             ((QVELT |g| 3)
              (COND ((< (QVELT |f| 0) (QVELT |g| 0)) (EXIT NIL)))))
            (LETT |als|
                  (SPADCALL |f| (SPADCALL |g| (QREFELT $ 313))
                            (QREFELT $ 234)))
            (LETT |lst_1| (SPADCALL 1 (QVELT |f| 0) (QREFELT $ 28)))
            (LETT |lst_2|
                  (SPADCALL (+ (QVELT |f| 0) 1) (+ (QVELT |f| 0) (QVELT |g| 0))
                            (QREFELT $ 28)))
            (LETT |trn_wrk|
                  (SPADCALL |als| |lst_2| |lst_1| |lst_1| |lst_2|
                            (QREFELT $ 166)))
            (COND
             ((> (LENGTH |trn_wrk|) 0) (PROGN (LETT #1# 'T) (GO #3=#:G2222))))
            (COND ((QVELT |f| 3) (COND ((QVELT |g| 3) (EXIT NIL)))))
            (EXIT (SPADCALL |als| (QREFELT $ 338)))))
          #3# (EXIT #1#)))) 

(SDEFUN |FDALG;coerce;$Xdp;175|
        ((|f| ($)) ($ (|XDistributedPolynomial| VAR F)))
        (SPADCALL |f| (QREFELT $ 217))) 

(SDEFUN |FDALG;coerce;Xdp$;176|
        ((|p| (|XDistributedPolynomial| VAR F)) ($ ($)))
        (SPROG ((|f_wrk| ($)) (#1=#:G2230 NIL) (|trm| NIL))
               (SEQ (LETT |f_wrk| (|spadConstant| $ 49))
                    (SEQ (LETT |trm| NIL)
                         (LETT #1# (SPADCALL |p| (QREFELT $ 343))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |trm| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |f_wrk|
                                 (SPADCALL |f_wrk|
                                           (SPADCALL (QCAR |trm|) (QCDR |trm|)
                                                     (QREFELT $ 59))
                                           (QREFELT $ 306)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |f_wrk|)))) 

(DECLAIM (NOTINLINE |FreeDivisionAlgebra;|)) 

(DEFUN |FreeDivisionAlgebra| (&REST #1=#:G2235)
  (SPROG NIL
         (PROG (#2=#:G2236)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FreeDivisionAlgebra|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FreeDivisionAlgebra;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FreeDivisionAlgebra|)))))))))) 

(DEFUN |FreeDivisionAlgebra;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FreeDivisionAlgebra| DV$1 DV$2))
          (LETT $ (GETREFV 351))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FreeDivisionAlgebra|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8
                    (|Record| (|:| |size| (|NonNegativeInteger|))
                              (|:| |supp| (|List| (|FreeMonoid| |#1|)))
                              (|:| |lmmp|
                                   (|LinearMultivariateMatrixPencil| |#2|))
                              (|:| |flg_minimal| (|Boolean|))
                              (|:| |flg_refined| (|Boolean|))
                              (|:| |flg_mutable| (|Boolean|))
                              (|:| |flg_debug| (|Boolean|))
                              (|:| |flg_output| (|Boolean|))))
          $))) 

(MAKEPROP '|FreeDivisionAlgebra| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|NonNegativeInteger|) (0 . |characteristic|)
              |FDALG;characteristic;Nni;1| (|LinearMultivariateMatrixPencil| 7)
              (4 . |qelt|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |FDALG;One;$;29|) $))
              (12 . |One|) (|List| 7) (16 . |qelt|) (23 . |qsetelt!|)
              (|Matrix| 7) (32 . |subMatrix|) (42 . |qscaleBlock!|)
              (53 . |setsubMatrix!|) (|Boolean|) (62 . |qzero?|)
              (69 . |qzero?|) (78 . |qsemizero?|) (|List| 9)
              |FDALG;interval;2NniL;21| (|FreeMonoid| 6) (88 . |One|)
              (92 . |qnew|) |FDALG;qnew;Nni$;22| (|List| 29) (99 . |remove|)
              |FDALG;qnew;NniL$;23| (105 . |length|) (110 . |nrows|)
              (115 . |ncols|) (120 . ~=) (126 . |nelem|) |FDALG;new;LmmpL$;24|
              (131 . |new|) (|Integer|) (|List| 6) (137 . |elt|)
              (143 . |coerce|) (148 . |setelt!|) (155 . |zero?|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |FDALG;Zero;$;28|) $))
              (160 . |Zero|) |FDALG;copy;2$;30| |FDALG;new;F$;26|
              (164 . |varList|) (|Record| (|:| |gen| 6) (|:| |exp| 9))
              (|List| 54) (169 . |factors|) (174 . |position|) (180 . -)
              |FDALG;new;FmF$;27| (185 . |copy|) (190 . |copy|)
              |FDALG;copy;$F$;31| |FDALG;coerce;Fm$;32| |FDALG;coerce;F$;33|
              |FDALG;enableDebugOutput;2$;34| |FDALG;disableDebugOutput;2$;35|
              |FDALG;toggleDebugOutput;2$;36|
              |FDALG;enableAlternativeOutput;2$;37|
              |FDALG;disableAlternativeOutput;2$;38|
              |FDALG;toggleAlternativeOutput;2$;39| |FDALG;minimal?;$B;40|
              |FDALG;mutable?;$B;41| (195 . |qdiagonal?|) (203 . |qdiagonal|)
              (211 . |elt|) (217 . =) |FDALG;qregular?;$2NniB;42|
              |FDALG;scalar?;$2NniB;43| |FDALG;zero?;$2NniB;44|
              (223 . |qnilpotent?|) |FDALG;scalar?;$B;45| (231 . |rank|)
              |FDALG;regular?;$B;46| (236 . |quppertriangular?|)
              |FDALG;polynomial?;$B;48| |FDALG;dimension;$Nni;49|
              |FDALG;variables;$L;50| |FDALG;elt;$NniF;51|
              (|XDistributedPolynomial| 6 7) (244 . |Zero|) (248 . |elt|)
              (254 . |coerce|) (259 . *) (265 . +) |FDALG;qelt;$2NniXdp;52|
              |FDALG;elt;$2NniXdp;53| |FDALG;setelt!;$Nni2F;54| (271 . |zero?|)
              (276 . |degree|) (281 . |varList|) (286 . |coefficient|)
              (292 . =) |FDALG;setelt!;$2Nni2Xdp;55| |FDALG;vector;$M;56|
              (298 . |coerce|) (|Matrix| 89) |FDALG;vector;$M;57|
              |FDALG;matrix;$FmM;58| |FDALG;matrix;$M;59| (303 . |append!|)
              (309 . |append|) |FDALG;appendSupport!;$L$;60|
              |FDALG;pencil;$Lmmp;61| (315 . |qswapRows!|)
              |FDALG;qswapRows!;$2Nni$;62| |FDALG;swapRows!;$2Nni$;63|
              (322 . |qaddRows!|) |FDALG;qaddRows!;$2NniF$;64|
              (330 . |qaddColumns!|) |FDALG;addRowsColumns!;$2NniF$;65|
              |FDALG;addColumnsRows!;$2NniF$;66| (338 . |addRows!|)
              |FDALG;addRows!;$2NniF$;67| (346 . |qmultiplyRow!|)
              |FDALG;multiplyRow!;$NniF$;69| (353 . |qmultiplyColumn!|)
              |FDALG;multiplyColumn!;$NniF$;71| (360 . |qswapColumns!|)
              |FDALG;qswapColumns!;$2Nni$;72| |FDALG;swapColumns!;$2Nni$;73|
              |FDALG;swapRowsColumns!;$2Nni$;74| (367 . |addColumns!|)
              |FDALG;addColumns!;$2NniF$;75| |FDALG;qaddColumns!;$2NniF$;76|
              (375 . |One|) (379 . +) (385 . |removeDuplicates|)
              (|Mapping| 9 9) (390 . |map|) (396 . |#|)
              (401 . |removeRowsColumns|) |FDALG;removeRowsColumns;$2L$;77|
              (408 . |insertRowsColumns|) (415 . |elt|)
              |FDALG;insertRowsColumns;$2L$;78| |FDALG;qzero?;$4NniB;79|
              (421 . |qzero?|) |FDALG;qzero?;$5NniB;80|
              |FDALG;qzero?;$4NniFmB;81| (|Matrix| 9) (431 . |new|)
              (438 . |sort|) |FDALG;blockStructure;$M;82| (443 . |nrows|)
              |FDALG;refined?;$B;83| (|List| 19) (448 . |blockElimination|)
              (459 . |min|) (|Mapping| 9 9 9) (465 . |reduce|) (471 . |max|)
              (477 . |elt|) (483 . |subMatrix|) (492 . |setelt!|)
              |FDALG;blockElimination;$2LB2LBL;85|
              |FDALG;blockElimination;$4LL;86| (|List| 170) (|List| 167)
              (499 . |new|) (|OutputForm|) (|Symbol|) (505 . |coerce|)
              (510 . |coerce|) (515 . |sub|) (521 . |setelt!|) (|List| 241)
              (528 . |matrix|) |FDALG;display;$2Of;89| (|List| 171)
              |FDALG;display;$LOf;88| (533 . |coerce|) (538 . *) (544 . =)
              (550 . |elt|) (557 . |hspace|) (562 . |new|) (568 . |coerce|)
              (573 . |qsetelt!|) |FDALG;admissibleLinearSystem;$Of;90|
              (580 . -) |FDALG;linearization;$M;91| (|Matrix| $$) (585 . |new|)
              (592 . |qsetelt!|) (|Matrix| $) |FDALG;linearization;$M;92|
              (|List| 106) |FDALG;representation;$L;93|
              |FDALG;transformColumns!;$M$;98| |FDALG;*;$M$;94|
              |FDALG;transformRows!;$M$;97| |FDALG;*;M2$;95|
              |FDALG;transformationMatrix;$M;96| (600 . |leftIdentity|)
              (605 . |setsubMatrix!|) (613 . |transformRows!|)
              (619 . |rightIdentity|) (624 . |transformColumns!|) (630 . /)
              |FDALG;normalizeRHS!;2$;99| |FDALG;normalizePLS!;2$;100|
              |FDALG;normalizeDIAG!;2$;101| |FDALG;normalize!;2$;102| (636 . -)
              (641 . |One|) |FDALG;solutionVector;$M;105|
              |FDALG;polynomial;$Xdp;104| (645 . *) (651 . -) (657 . |copy|)
              (662 . *) (668 . +) |FDALG;solutionVector;$NniM;106|
              (|Mapping| 106 106) (|Stream| 106) (674 . |stream|)
              |FDALG;columnSpan;$S;107| (680 . |setelt!|)
              |FDALG;rowSpan;$S;108| |FDALG;scaleALS;$F$;109| (688 . |merge|)
              (694 . |removeDuplicates|) (699 . |sort|) |FDALG;addALS;3$;110|
              (704 . -) |FDALG;multiplyALS;3$;111| |FDALG;invertALS;2$;112|
              |FDALG;invertSTD;2$;113| (|List| $$) (709 . |cons|) (|List| $)
              |FDALG;factors;$L;114| (715 . |#|) |FDALG;summands;$L;115|
              (720 . |support|) (725 . |paren|) (730 . |leadingCoefficient|)
              (735 . ~=) (|List| 27) (741 . |new|) (|List| 89) (747 . |new|)
              (753 . |setelt!|) (760 . |elt|) (766 . |elt|) (772 . |setelt!|)
              (779 . |coerce|) (784 . |coerce|) (789 . |setelt!|) (796 . =)
              (802 . |elt|) (808 . +) (814 . |super|) |FDALG;leftFamily;$L;117|
              |FDALG;invertMIN;2$;155| (820 . |hconcat|) (826 . |first|)
              |FDALG;ratexprInverse;$BOf;118| (831 . |rest|)
              |FDALG;ratexpr;$Of;119| (836 . |semicolonSeparate|)
              |FDALG;coerce;$Of;120| |FDALG;leftFactor;$Nni$;121|
              |FDALG;rightFactor;$Nni$;122| (|List| (|Equation| 288))
              (841 . |eliminationTransformations|) (|List| 275)
              |FDALG;factorizationSolve;$2NniL;129| |FDALG;factorize;$NniL;124|
              |FDALG;refineUR!;2$;131| (851 . |elt|) (857 . |reverse|)
              |FDALG;factor;$L;125|
              |FDALG;factorizationTransformations;$2NniLL;126| (|List| 288)
              (862 . |eliminationEquations|)
              |FDALG;factorizationEquations;$2NniL;127| (|Polynomial| 7)
              (877 . |variables|) (|List| 179) (|Mapping| 179 288)
              (|ListFunctions2| 288 179) (882 . |map|) (888 . |concat|)
              (893 . |removeDuplicates|)
              |FDALG;factorizationGroebner;$2NniL;128| (898 . |elt|)
              (904 . |eliminationSolve|) (911 . |copy|)
              |FDALG;refineUR!;$Nni$;130| |FDALG;extendedALS;2$;132|
              |FDALG;normalALS;2$;133| |FDALG;leftMinimization;$2Nni$;134|
              |FDALG;rightMinimization;$2Nni$;135| |FDALG;minimize;2$;136|
              |FDALG;addMIN;3$;137| |FDALG;multiplyMIN;3$;138| (916 . |coerce|)
              |FDALG;*;I2$;139| |FDALG;*;F2$;140| |FDALG;*;$F$;141|
              |FDALG;*;3$;142| |FDALG;-;2$;149| |FDALG;-;$F$;143|
              |FDALG;+;$F$;144| |FDALG;-;F2$;145| |FDALG;+;F2$;146|
              |FDALG;-;3$;147| |FDALG;+;3$;148| |FDALG;/;$F$;150|
              (|PositiveInteger|) |FDALG;^;$Pi$;151| |FDALG;refine!;$B$;170|
              |FDALG;setRefined!;$Nni$;168| |FDALG;inverse;2$;156|
              |FDALG;refine!;2$;171| |FDALG;inv;2$;157| |FDALG;/;F2$;158|
              |FDALG;/;3$;159| |FDALG;^;$I$;160|
              |FDALG;refinementTransformations;$2NniLL;162|
              |FDALG;refinementEquations;$3Nni2BL;163|
              |FDALG;refinementGroebner;$3Nni2BL;164|
              |FDALG;refinementSolve;$3Nni2BL;165| (921 . |One|) (925 . ~=)
              |FDALG;rank;$Nni;172| |FDALG;zero?;$B;173| |FDALG;=;2$B;174|
              |FDALG;coerce;$Xdp;175| (|Record| (|:| |k| 29) (|:| |c| 7))
              (|List| 341) (931 . |listOfTerms|) |FDALG;coerce;Xdp$;176|
              (|Fraction| 43)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Union| $ '"failed") (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 936 |zero?| 942 |vector| 954 |variables| 964 |unitNormal| 969
              |unitCanonical| 974 |unit?| 979 |transformationMatrix| 984
              |transformRows!| 989 |transformColumns!| 995 |toggleDebugOutput|
              1001 |toggleAlternativeOutput| 1006 |swapRowsColumns!| 1011
              |swapRows!| 1018 |swapColumns!| 1025 |summands| 1032
              |subtractIfCan| 1037 |solutionVector| 1043 |setelt!| 1054
              |setRefined!| 1069 |scaleALS| 1075 |scalar?| 1081 |sample| 1093
              |rowSpan| 1097 |rightRecip| 1102 |rightPower| 1107
              |rightMinimization| 1119 |rightFamily| 1126 |rightFactor| 1131
              |representation| 1137 |removeRowsColumns| 1142 |regular?| 1149
              |refinementTransformations| 1154 |refinementSolve| 1162
              |refinementGroebner| 1172 |refinementEquations| 1182 |refined?|
              1192 |refineUR!| 1197 |refine!| 1208 |recip| 1219
              |ratexprInverse| 1224 |ratexpr| 1230 |rank| 1235 |qzero?| 1240
              |qswapRows!| 1269 |qswapColumns!| 1276 |qregular?| 1283 |qnew|
              1290 |qelt| 1301 |qaddRows!| 1308 |qaddColumns!| 1316
              |polynomial?| 1324 |polynomial| 1329 |pencil| 1334 |opposite?|
              1339 |one?| 1345 |normalizeRHS!| 1350 |normalizePLS!| 1355
              |normalizeDIAG!| 1360 |normalize!| 1365 |normalALS| 1370 |new|
              1375 |mutable?| 1392 |multiplyRow!| 1397 |multiplyMIN| 1404
              |multiplyColumn!| 1410 |multiplyALS| 1417 |minimize| 1423
              |minimal?| 1428 |matrix| 1433 |linearization| 1444 |leftRecip|
              1454 |leftPower| 1459 |leftMinimization| 1471 |leftFamily| 1478
              |leftFactor| 1483 |latex| 1489 |invertSTD| 1494 |invertMIN| 1499
              |invertALS| 1504 |inverse| 1509 |inv| 1514 |interval| 1519
              |insertRowsColumns| 1525 |hashUpdate!| 1532 |hash| 1538 |factors|
              1543 |factorize| 1548 |factorizationTransformations| 1554
              |factorizationSolve| 1562 |factorizationGroebner| 1569
              |factorizationEquations| 1576 |factor| 1583 |extendedALS| 1588
              |exquo| 1593 |enableDebugOutput| 1599 |enableAlternativeOutput|
              1604 |elt| 1609 |display| 1622 |disableDebugOutput| 1634
              |disableAlternativeOutput| 1639 |dimension| 1644 |copy| 1649
              |commutator| 1660 |columnSpan| 1666 |coerce| 1671
              |characteristic| 1706 |blockStructure| 1710 |blockElimination|
              1715 |associator| 1735 |associates?| 1742 |appendSupport!| 1748
              |antiCommutator| 1754 |annihilate?| 1760 |admissibleLinearSystem|
              1766 |addRowsColumns!| 1771 |addRows!| 1779 |addMIN| 1787
              |addColumnsRows!| 1793 |addColumns!| 1801 |addALS| 1809 ^ 1815
              |Zero| 1833 |One| 1837 = 1841 / 1847 - 1865 + 1888 * 1906)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|DivisionRing&| |EntireRing&| |Algebra&| |Algebra&| NIL |Rng&|
                NIL |Module&| |Module&| NIL NIL NIL |NonAssociativeRing&| NIL
                NIL NIL NIL NIL |NonAssociativeRng&| NIL NIL |AbelianGroup&|
                NIL NIL NIL NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| |Magma&| |AbelianSemiGroup&| |SetCategory&|
                NIL NIL NIL |BasicType&| NIL)
             (CONS
              '#((|DivisionRing|) (|EntireRing|) (|Algebra| 7) (|Algebra| 345)
                 (|Ring|) (|Rng|) (|SemiRing|) (|Module| 7) (|Module| 345)
                 (|SemiRng|) (|BiModule| 7 7) (|BiModule| 345 345)
                 (|NonAssociativeRing|) (|BiModule| $$ $$) (|RightModule| 7)
                 (|LeftModule| 7) (|RightModule| 345) (|LeftModule| 345)
                 (|NonAssociativeRng|) (|RightModule| $$) (|LeftModule| $$)
                 (|AbelianGroup|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|Magma|)
                 (|AbelianSemiGroup|) (|SetCategory|) (|TwoSidedRecip|)
                 (|noZeroDivisors|) (|unitsKnown|) (|BasicType|)
                 (|CoercibleTo| 170))
              (|makeByteWordVec2| 350
                                  '(0 7 9 10 4 12 7 0 9 9 9 13 0 7 0 15 3 12 16
                                    0 9 9 17 5 12 7 0 9 9 9 7 18 6 12 19 0 9 9
                                    9 9 9 20 7 12 0 0 9 9 9 9 9 7 21 5 12 19 0
                                    9 9 9 19 22 3 12 23 0 9 9 24 5 12 23 0 9 9
                                    9 9 25 6 12 23 0 9 9 9 9 9 26 0 29 0 30 3
                                    12 0 9 9 9 31 2 33 0 29 0 34 1 29 9 0 36 1
                                    12 9 0 37 1 12 9 0 38 2 9 23 0 0 39 1 12 9
                                    0 40 2 33 0 9 29 42 2 44 6 0 43 45 1 29 0 6
                                    46 3 33 29 0 43 29 47 1 7 23 0 48 0 7 0 50
                                    1 29 44 0 53 1 29 55 0 56 2 33 43 29 0 57 1
                                    7 0 0 58 1 12 0 0 60 1 33 0 0 61 4 12 23 0
                                    9 9 9 73 4 12 16 0 9 9 9 74 2 16 7 0 43 75
                                    2 7 23 0 0 76 4 12 23 0 9 9 9 80 1 19 9 0
                                    82 4 12 23 0 9 9 9 84 0 89 0 90 2 33 29 0
                                    43 91 1 89 0 29 92 2 89 0 7 0 93 2 89 0 0 0
                                    94 1 89 23 0 98 1 89 9 0 99 1 89 44 0 100 2
                                    89 7 0 29 101 2 16 23 0 0 102 1 89 0 7 105
                                    2 12 0 0 9 110 2 33 0 0 0 111 3 12 0 0 9 9
                                    114 4 12 0 0 9 9 7 117 4 12 0 0 9 9 7 119 4
                                    12 0 0 9 9 7 122 3 12 0 0 9 7 124 3 12 0 0
                                    9 7 126 3 12 0 0 9 9 128 4 12 0 0 9 9 7 132
                                    0 9 0 135 2 9 0 0 0 136 1 27 0 0 137 2 27 0
                                    138 0 139 1 27 9 0 140 3 12 0 0 27 27 141 3
                                    12 0 0 27 27 143 2 27 9 0 43 144 6 12 23 0
                                    9 9 9 9 9 147 3 150 0 9 9 9 151 1 27 0 0
                                    152 1 150 9 0 154 7 12 156 0 27 27 27 27 27
                                    27 157 2 9 0 0 0 158 2 27 9 159 0 160 2 9 0
                                    0 0 161 2 156 19 0 43 162 5 19 0 0 43 43 43
                                    43 163 3 156 19 0 43 19 164 2 168 0 9 167
                                    169 1 171 170 0 172 1 9 170 0 173 2 170 0 0
                                    0 174 3 168 167 0 43 167 175 1 170 0 176
                                    177 1 106 170 0 181 2 170 0 0 0 182 2 170 0
                                    0 0 183 3 150 9 0 43 43 184 1 170 0 43 185
                                    2 167 0 9 170 186 1 89 170 0 187 3 167 170
                                    0 43 170 188 1 89 0 0 190 3 192 0 9 9 2 193
                                    4 192 2 0 43 43 2 194 1 12 19 0 204 4 19 0
                                    0 43 43 0 205 2 12 0 0 19 206 1 12 19 0 207
                                    2 12 0 0 19 208 2 7 0 0 0 209 1 106 0 0 214
                                    0 89 0 215 2 89 0 0 0 218 2 89 0 0 0 219 1
                                    106 0 0 220 2 106 0 0 0 221 2 106 0 0 0 222
                                    2 225 0 224 106 226 4 106 89 0 43 43 89 228
                                    2 33 0 0 0 231 1 33 0 0 232 1 33 0 0 233 1
                                    19 0 0 235 2 239 0 2 0 240 1 239 9 0 243 1
                                    89 33 0 245 1 170 0 0 246 1 89 7 0 247 2 7
                                    23 0 0 248 2 249 0 9 27 250 2 251 0 9 89
                                    252 3 251 89 0 43 89 253 2 251 89 0 43 254
                                    2 249 27 0 43 255 3 249 27 0 43 27 256 1 43
                                    170 0 257 1 7 170 0 258 3 167 170 0 43 170
                                    259 2 89 23 0 0 260 2 167 170 0 43 261 2
                                    170 0 0 0 262 2 170 0 0 0 263 2 170 0 0 0
                                    266 1 239 2 0 267 1 239 0 0 269 1 170 0 241
                                    271 6 12 156 0 27 27 27 27 275 276 2 239 2
                                    0 43 281 1 239 0 0 282 11 12 285 0 27 27 27
                                    27 27 27 27 27 27 27 286 1 288 179 0 289 2
                                    292 290 291 285 293 1 179 0 241 294 1 179 0
                                    0 295 2 285 288 0 43 297 3 12 277 285 16
                                    277 298 1 277 0 0 299 1 7 0 43 308 0 288 0
                                    335 2 288 23 0 0 336 1 89 342 0 343 2 0 23
                                    0 0 1 3 0 23 0 9 9 79 1 0 23 0 338 1 0 106
                                    0 107 1 0 19 0 104 1 0 33 0 87 1 0 346 0 1
                                    1 0 0 0 1 1 0 23 0 1 1 0 19 0 203 2 0 0 0
                                    19 201 2 0 0 0 19 199 1 0 0 0 67 1 0 0 0 70
                                    3 0 0 0 9 9 131 3 0 0 0 9 9 116 3 0 0 0 9 9
                                    130 1 0 241 0 244 2 0 347 0 0 1 2 0 106 0 9
                                    223 1 0 106 0 216 4 0 89 0 9 9 89 103 3 0 7
                                    0 9 7 97 2 0 0 0 9 324 2 0 0 0 7 230 1 0 23
                                    0 81 3 0 23 0 9 9 78 0 0 0 1 1 0 225 0 229
                                    1 0 347 0 1 2 0 0 0 9 1 2 0 0 0 321 1 3 0 0
                                    0 9 9 304 1 0 167 0 1 2 0 0 0 9 274 1 0 197
                                    0 198 3 0 0 0 27 27 142 1 0 23 0 83 4 0 156
                                    0 9 9 275 331 6 0 277 0 9 9 9 23 23 334 6 0
                                    285 0 9 9 9 23 23 333 6 0 285 0 9 9 9 23 23
                                    332 1 0 23 0 155 1 0 0 0 280 2 0 0 0 9 300
                                    1 0 0 0 326 2 0 0 0 23 323 1 0 347 0 1 2 0
                                    170 0 23 268 1 0 170 0 270 1 0 9 0 337 6 0
                                    23 0 9 9 9 9 29 149 6 0 23 0 9 9 9 9 9 148
                                    5 0 23 0 9 9 9 9 146 3 0 0 0 9 9 115 3 0 0
                                    0 9 9 129 3 0 23 0 9 9 77 2 0 0 9 33 35 1 0
                                    0 9 32 3 0 89 0 9 9 95 4 0 0 0 9 9 7 118 4
                                    0 0 0 9 9 7 134 1 0 23 0 85 1 0 89 0 217 1
                                    0 12 0 113 2 0 23 0 0 1 1 0 23 0 1 1 0 0 0
                                    210 1 0 0 0 211 1 0 0 0 212 1 0 0 0 213 1 0
                                    0 0 302 2 0 0 29 7 59 1 0 0 7 52 2 0 0 12
                                    33 41 1 0 23 0 72 3 0 0 0 9 7 125 2 0 0 0 0
                                    307 3 0 0 0 9 7 127 2 0 0 0 0 236 1 0 0 0
                                    305 1 0 23 0 71 2 0 19 0 29 108 1 0 106 0
                                    109 1 0 106 0 191 1 0 195 0 196 1 0 347 0 1
                                    2 0 0 0 9 1 2 0 0 0 321 1 3 0 0 0 9 9 303 1
                                    0 167 0 264 2 0 0 0 9 273 1 0 348 0 1 1 0 0
                                    0 238 1 0 0 0 265 1 0 0 0 237 1 0 0 0 325 1
                                    0 0 0 327 2 0 27 9 9 28 3 0 0 0 27 27 145 2
                                    0 350 350 0 1 1 0 349 0 1 1 0 241 0 242 2 0
                                    241 0 9 279 4 0 156 0 9 9 275 284 3 0 277 0
                                    9 9 278 3 0 285 0 9 9 296 3 0 285 0 9 9 287
                                    1 0 241 0 283 1 0 0 0 301 2 0 347 0 0 1 1 0
                                    0 0 65 1 0 0 0 68 3 0 89 0 9 9 96 2 0 7 0 9
                                    88 2 0 170 0 179 180 2 0 170 0 170 178 1 0
                                    0 0 66 1 0 0 0 69 1 0 9 0 86 2 0 0 0 7 62 1
                                    0 0 0 51 2 0 0 0 0 1 1 0 225 0 227 1 0 89 0
                                    340 1 0 0 89 344 1 0 0 29 63 1 0 0 7 64 1 0
                                    0 345 1 1 0 0 43 1 1 0 170 0 272 0 0 9 11 1
                                    0 150 0 153 7 0 156 0 27 27 23 27 27 23 165
                                    5 0 156 0 27 27 27 27 166 3 0 0 0 0 0 1 2 0
                                    23 0 0 1 2 0 0 0 33 112 2 0 0 0 0 1 2 0 23
                                    0 0 1 1 0 170 0 189 4 0 0 0 9 9 7 120 4 0 0
                                    0 9 9 7 123 2 0 0 0 0 306 4 0 0 0 9 9 7 121
                                    4 0 0 0 9 9 7 133 2 0 0 0 0 234 2 0 0 0 43
                                    330 2 0 0 0 9 1 2 0 0 0 321 322 0 0 0 49 0
                                    0 0 14 2 0 23 0 0 339 2 0 0 7 0 328 2 0 0 0
                                    0 329 2 0 0 0 7 320 2 0 0 7 0 316 2 0 0 0 7
                                    314 2 0 0 0 0 318 1 0 0 0 313 2 0 0 7 0 317
                                    2 0 0 0 7 315 2 0 0 0 0 319 2 0 0 0 19 200
                                    2 0 0 19 0 202 2 0 0 0 7 311 2 0 0 7 0 310
                                    2 0 0 0 345 1 2 0 0 345 0 1 2 0 0 9 0 1 2 0
                                    0 43 0 309 2 0 0 0 0 312 2 0 0 321 0 1)))))
           '|lookupComplete|)) 

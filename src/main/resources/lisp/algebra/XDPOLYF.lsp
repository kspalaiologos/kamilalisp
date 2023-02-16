
(SDEFUN |XDPOLYF;hankelIndices;XdpL;1|
        ((|p| (|XDistributedPolynomial| VAR F))
         ($ (|List| (|FreeMonoid| VAR))))
        (SPROG
         ((|lst_col| (|List| #1=(|FreeMonoid| VAR))) (|u| #1#) (#2=#:G726 NIL)
          (|k| NIL) (#3=#:G725 NIL) (|f| NIL) (|lst_row| (|List| #1#))
          (#4=#:G724 NIL) (#5=#:G723 NIL) (#6=#:G722 NIL) (|m| NIL))
         (SEQ (LETT |lst_row| (LIST (|spadConstant| $ 9)))
              (LETT |lst_col| (LIST (|spadConstant| $ 9)))
              (SEQ (LETT |m| NIL) (LETT #6# (SPADCALL |p| (QREFELT $ 12))) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |m| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |u| (|spadConstant| $ 9))
                        (SEQ (LETT |f| NIL)
                             (LETT #5# (SPADCALL |m| (QREFELT $ 15))) G190
                             (COND
                              ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |k| 1) (LETT #4# (QCDR |f|)) G190
                                    (COND ((|greater_SI| |k| #4#) (GO G191)))
                                    (SEQ
                                     (LETT |u|
                                           (SPADCALL |u| (QCAR |f|)
                                                     (QREFELT $ 16)))
                                     (EXIT
                                      (LETT |lst_row| (CONS |u| |lst_row|))))
                                    (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                    (EXIT NIL))))
                             (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                        (LETT |u| (|spadConstant| $ 9))
                        (EXIT
                         (SEQ (LETT |f| NIL)
                              (LETT #3#
                                    (REVERSE (SPADCALL |m| (QREFELT $ 15))))
                              G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |f| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (SEQ (LETT |k| 1) (LETT #2# (QCDR |f|)) G190
                                     (COND ((|greater_SI| |k| #2#) (GO G191)))
                                     (SEQ
                                      (LETT |u|
                                            (SPADCALL (QCAR |f|) |u|
                                                      (QREFELT $ 17)))
                                      (EXIT
                                       (LETT |lst_col| (CONS |u| |lst_col|))))
                                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                     (EXIT NIL))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |lst_row| |lst_col| (QREFELT $ 18))
                          (QREFELT $ 19))
                (QREFELT $ 20)))))) 

(SDEFUN |XDPOLYF;hankelMatrix;XdpM;2|
        ((|p| (|XDistributedPolynomial| VAR F)) ($ (|Matrix| F)))
        (SPROG
         ((|j| #1=(|Integer|)) (|i| #1#) (|v| (|FreeMonoid| VAR))
          (#2=#:G741 NIL) (|u| (|FreeMonoid| VAR)) (#3=#:G752 NIL) (|k| NIL)
          (#4=#:G751 NIL) (|f| NIL) (|c| (F)) (|m| (|FreeMonoid| VAR))
          (#5=#:G750 NIL) (|l| NIL) (|lst_coe| (|List| F))
          (|lst_sup| (|List| (|FreeMonoid| VAR))) (|mtx_wrk| (|Matrix| F))
          (|n| (|NonNegativeInteger|)) (|lst_idx| (|List| (|FreeMonoid| VAR))))
         (SEQ (LETT |lst_idx| (SPADCALL |p| (QREFELT $ 21)))
              (LETT |n| (LENGTH |lst_idx|))
              (LETT |mtx_wrk| (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 22)))
              (LETT |lst_sup| (SPADCALL |p| (QREFELT $ 12)))
              (LETT |lst_coe| (SPADCALL |p| (QREFELT $ 25)))
              (SEQ (LETT |l| 1) (LETT #5# (LENGTH |lst_sup|)) G190
                   (COND ((|greater_SI| |l| #5#) (GO G191)))
                   (SEQ (LETT |m| (SPADCALL |lst_sup| |l| (QREFELT $ 27)))
                        (LETT |c| (SPADCALL |lst_coe| |l| (QREFELT $ 28)))
                        (LETT |u| (|spadConstant| $ 9))
                        (LETT |i| (SPADCALL |u| |lst_idx| (QREFELT $ 29)))
                        (LETT |j| (SPADCALL |m| |lst_idx| (QREFELT $ 29)))
                        (SPADCALL |mtx_wrk| |i| |j|
                                  (SPADCALL
                                   (SPADCALL |mtx_wrk| |i| |j| (QREFELT $ 31))
                                   |c| (QREFELT $ 32))
                                  (QREFELT $ 33))
                        (EXIT
                         (SEQ (LETT |f| NIL)
                              (LETT #4# (SPADCALL |m| (QREFELT $ 15))) G190
                              (COND
                               ((OR (ATOM #4#)
                                    (PROGN (LETT |f| (CAR #4#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (SEQ (LETT |k| 1) (LETT #3# (QCDR |f|)) G190
                                     (COND ((|greater_SI| |k| #3#) (GO G191)))
                                     (SEQ
                                      (LETT |u|
                                            (SPADCALL |u| (QCAR |f|)
                                                      (QREFELT $ 16)))
                                      (LETT |v|
                                            (PROG2
                                                (LETT #2#
                                                      (SPADCALL |m| |u|
                                                                (QREFELT $
                                                                         35)))
                                                (QCDR #2#)
                                              (|check_union2| (QEQCAR #2# 0)
                                                              (|FreeMonoid|
                                                               (QREFELT $ 6))
                                                              (|Union|
                                                               (|FreeMonoid|
                                                                (QREFELT $ 6))
                                                               "failed")
                                                              #2#)))
                                      (LETT |i|
                                            (SPADCALL |u| |lst_idx|
                                                      (QREFELT $ 29)))
                                      (LETT |j|
                                            (SPADCALL |v| |lst_idx|
                                                      (QREFELT $ 29)))
                                      (EXIT
                                       (SPADCALL |mtx_wrk| |i| |j|
                                                 (SPADCALL
                                                  (SPADCALL |mtx_wrk| |i| |j|
                                                            (QREFELT $ 31))
                                                  |c| (QREFELT $ 32))
                                                 (QREFELT $ 33))))
                                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                     (EXIT NIL))))
                              (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))))
                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
              (EXIT |mtx_wrk|)))) 

(SDEFUN |XDPOLYF;hankelMatrix;XdpVARM;3|
        ((|p| (|XDistributedPolynomial| VAR F)) (|x| (VAR)) ($ (|Matrix| F)))
        (SPROG
         ((|u| (|FreeMonoid| VAR)) (|j| #1=(|Integer|)) (|i| #1#)
          (|v| (|FreeMonoid| VAR)) (#2=#:G758 NIL) (#3=#:G771 NIL) (|k| NIL)
          (#4=#:G770 NIL) (|f| NIL) (|c| (F)) (|m| (|FreeMonoid| VAR))
          (#5=#:G769 NIL) (|l| NIL) (|lst_coe| (|List| F))
          (|lst_sup| (|List| (|FreeMonoid| VAR))) (|mtx_wrk| (|Matrix| F))
          (|n| (|NonNegativeInteger|)) (|lst_idx| (|List| (|FreeMonoid| VAR))))
         (SEQ (LETT |lst_idx| (SPADCALL |p| (QREFELT $ 21)))
              (LETT |n| (LENGTH |lst_idx|))
              (LETT |mtx_wrk| (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 22)))
              (LETT |lst_sup| (SPADCALL |p| (QREFELT $ 12)))
              (LETT |lst_coe| (SPADCALL |p| (QREFELT $ 25)))
              (SEQ (LETT |l| 1) (LETT #5# (LENGTH |lst_sup|)) G190
                   (COND ((|greater_SI| |l| #5#) (GO G191)))
                   (SEQ (LETT |m| (SPADCALL |lst_sup| |l| (QREFELT $ 27)))
                        (LETT |c| (SPADCALL |lst_coe| |l| (QREFELT $ 28)))
                        (LETT |u| (|spadConstant| $ 9))
                        (EXIT
                         (SEQ (LETT |f| NIL)
                              (LETT #4# (SPADCALL |m| (QREFELT $ 15))) G190
                              (COND
                               ((OR (ATOM #4#)
                                    (PROGN (LETT |f| (CAR #4#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (SEQ (LETT |k| 1) (LETT #3# (QCDR |f|)) G190
                                     (COND ((|greater_SI| |k| #3#) (GO G191)))
                                     (SEQ
                                      (COND
                                       ((SPADCALL (QCAR |f|) |x|
                                                  (QREFELT $ 38))
                                        (SEQ
                                         (LETT |v|
                                               (PROG2
                                                   (LETT #2#
                                                         (SPADCALL |m|
                                                                   (SPADCALL
                                                                    |u| |x|
                                                                    (QREFELT $
                                                                             16))
                                                                   (QREFELT $
                                                                            35)))
                                                   (QCDR #2#)
                                                 (|check_union2| (QEQCAR #2# 0)
                                                                 (|FreeMonoid|
                                                                  (QREFELT $
                                                                           6))
                                                                 (|Union|
                                                                  (|FreeMonoid|
                                                                   (QREFELT $
                                                                            6))
                                                                  "failed")
                                                                 #2#)))
                                         (LETT |i|
                                               (SPADCALL |u| |lst_idx|
                                                         (QREFELT $ 29)))
                                         (LETT |j|
                                               (SPADCALL |v| |lst_idx|
                                                         (QREFELT $ 29)))
                                         (EXIT
                                          (SPADCALL |mtx_wrk| |i| |j|
                                                    (SPADCALL
                                                     (SPADCALL |mtx_wrk| |i|
                                                               |j|
                                                               (QREFELT $ 31))
                                                     |c| (QREFELT $ 32))
                                                    (QREFELT $ 33))))))
                                      (EXIT
                                       (LETT |u|
                                             (SPADCALL |u| (QCAR |f|)
                                                       (QREFELT $ 16)))))
                                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                     (EXIT NIL))))
                              (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))))
                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
              (EXIT |mtx_wrk|)))) 

(SDEFUN |XDPOLYF;hankelSystem;XdpR;4|
        ((|p| (|XDistributedPolynomial| VAR F))
         ($
          (|Record| (|:| |rows| (|List| (|FreeMonoid| VAR)))
                    (|:| |cols| (|List| (|FreeMonoid| VAR)))
                    (|:| H (|Matrix| F)))))
        (SPROG
         ((|j| #1=(|Integer|)) (|i| #1#) (|v| (|FreeMonoid| VAR))
          (#2=#:G792 NIL) (|u| #3=(|FreeMonoid| VAR)) (#4=#:G809 NIL) (|k| NIL)
          (#5=#:G808 NIL) (|f| NIL) (|c| (F)) (|m| (|FreeMonoid| VAR))
          (#6=#:G807 NIL) (|l| NIL) (|lst_coe| (|List| F))
          (|lst_sup| (|List| (|FreeMonoid| VAR))) (|mtx_wrk| (|Matrix| F))
          (|lst_col| (|List| #3#)) (|lst_row| (|List| #3#)) (#7=#:G806 NIL)
          (#8=#:G805 NIL) (#9=#:G804 NIL) (#10=#:G803 NIL) (#11=#:G802 NIL))
         (SEQ (LETT |lst_row| (LIST (|spadConstant| $ 9)))
              (LETT |lst_col| (LIST (|spadConstant| $ 9)))
              (SEQ (LETT #11# (SPADCALL |p| (QREFELT $ 12))) G190
                   (COND
                    ((OR (ATOM #11#) (PROGN (LETT |m| (CAR #11#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |u| (|spadConstant| $ 9))
                        (SEQ (LETT |f| NIL)
                             (LETT #10# (SPADCALL |m| (QREFELT $ 15))) G190
                             (COND
                              ((OR (ATOM #10#)
                                   (PROGN (LETT |f| (CAR #10#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |k| 1) (LETT #9# (QCDR |f|)) G190
                                    (COND ((|greater_SI| |k| #9#) (GO G191)))
                                    (SEQ
                                     (LETT |u|
                                           (SPADCALL |u| (QCAR |f|)
                                                     (QREFELT $ 16)))
                                     (EXIT
                                      (LETT |lst_row| (CONS |u| |lst_row|))))
                                    (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                    (EXIT NIL))))
                             (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
                        (LETT |u| (|spadConstant| $ 9))
                        (EXIT
                         (SEQ (LETT |f| NIL)
                              (LETT #8#
                                    (REVERSE (SPADCALL |m| (QREFELT $ 15))))
                              G190
                              (COND
                               ((OR (ATOM #8#)
                                    (PROGN (LETT |f| (CAR #8#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (SEQ (LETT |k| 1) (LETT #7# (QCDR |f|)) G190
                                     (COND ((|greater_SI| |k| #7#) (GO G191)))
                                     (SEQ
                                      (LETT |u|
                                            (SPADCALL (QCAR |f|) |u|
                                                      (QREFELT $ 17)))
                                      (EXIT
                                       (LETT |lst_col| (CONS |u| |lst_col|))))
                                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                     (EXIT NIL))))
                              (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
              (LETT |lst_row|
                    (SPADCALL (SPADCALL |lst_row| (QREFELT $ 19))
                              (QREFELT $ 20)))
              (LETT |lst_col|
                    (SPADCALL (SPADCALL |lst_col| (QREFELT $ 19))
                              (QREFELT $ 20)))
              (LETT |mtx_wrk|
                    (MAKE_MATRIX1 (LENGTH |lst_row|) (LENGTH |lst_col|)
                                  (|spadConstant| $ 22)))
              (LETT |lst_sup| (SPADCALL |p| (QREFELT $ 12)))
              (LETT |lst_coe| (SPADCALL |p| (QREFELT $ 25)))
              (SEQ (LETT |l| 1) (LETT #6# (LENGTH |lst_sup|)) G190
                   (COND ((|greater_SI| |l| #6#) (GO G191)))
                   (SEQ (LETT |m| (SPADCALL |lst_sup| |l| (QREFELT $ 27)))
                        (LETT |c| (SPADCALL |lst_coe| |l| (QREFELT $ 28)))
                        (LETT |u| (|spadConstant| $ 9))
                        (LETT |i| (SPADCALL |u| |lst_row| (QREFELT $ 29)))
                        (LETT |j| (SPADCALL |m| |lst_col| (QREFELT $ 29)))
                        (SPADCALL |mtx_wrk| |i| |j|
                                  (SPADCALL
                                   (SPADCALL |mtx_wrk| |i| |j| (QREFELT $ 31))
                                   |c| (QREFELT $ 32))
                                  (QREFELT $ 33))
                        (EXIT
                         (SEQ (LETT |f| NIL)
                              (LETT #5# (SPADCALL |m| (QREFELT $ 15))) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |f| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (SEQ (LETT |k| 1) (LETT #4# (QCDR |f|)) G190
                                     (COND ((|greater_SI| |k| #4#) (GO G191)))
                                     (SEQ
                                      (LETT |u|
                                            (SPADCALL |u| (QCAR |f|)
                                                      (QREFELT $ 16)))
                                      (LETT |v|
                                            (PROG2
                                                (LETT #2#
                                                      (SPADCALL |m| |u|
                                                                (QREFELT $
                                                                         35)))
                                                (QCDR #2#)
                                              (|check_union2| (QEQCAR #2# 0)
                                                              (|FreeMonoid|
                                                               (QREFELT $ 6))
                                                              (|Union|
                                                               (|FreeMonoid|
                                                                (QREFELT $ 6))
                                                               "failed")
                                                              #2#)))
                                      (LETT |i|
                                            (SPADCALL |u| |lst_row|
                                                      (QREFELT $ 29)))
                                      (LETT |j|
                                            (SPADCALL |v| |lst_col|
                                                      (QREFELT $ 29)))
                                      (EXIT
                                       (SPADCALL |mtx_wrk| |i| |j|
                                                 (SPADCALL
                                                  (SPADCALL |mtx_wrk| |i| |j|
                                                            (QREFELT $ 31))
                                                  |c| (QREFELT $ 32))
                                                 (QREFELT $ 33))))
                                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                     (EXIT NIL))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))))
                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |lst_row| |lst_col| |mtx_wrk|))))) 

(SDEFUN |XDPOLYF;display;ROf;5|
        ((|sys|
          (|Record| (|:| |rows| (|List| (|FreeMonoid| VAR)))
                    (|:| |cols| (|List| (|FreeMonoid| VAR)))
                    (|:| H (|Matrix| F))))
         ($ (|OutputForm|)))
        (SPROG
         ((|lst_wrk| (|List| (|OutputForm|))) (#1=#:G822 NIL) (|j| NIL)
          (#2=#:G821 NIL) (|i| NIL) (#3=#:G820 NIL)
          (|mtx| (|List| (|List| (|OutputForm|))))
          (|lst_tmp| (|List| (|OutputForm|))) (|n| #4=(|NonNegativeInteger|))
          (|m| #4#))
         (SEQ (LETT |m| (LENGTH (QVELT |sys| 0)))
              (LETT |n| (LENGTH (QVELT |sys| 1))) (LETT |lst_tmp| NIL)
              (LETT |mtx| (SPADCALL (+ |m| 1) |lst_tmp| (QREFELT $ 46)))
              (LETT |lst_wrk| (LIST (SPADCALL 1 (QREFELT $ 48))))
              (SEQ (LETT |j| 1) (LETT #3# |n|) G190
                   (COND ((|greater_SI| |j| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |lst_wrk|
                           (CONS
                            (SPADCALL
                             (SPADCALL (QVELT |sys| 1) |j| (QREFELT $ 49))
                             (QREFELT $ 50))
                            |lst_wrk|))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (SPADCALL |mtx| 1 (REVERSE |lst_wrk|) (QREFELT $ 51))
              (SEQ (LETT |i| 1) (LETT #2# |m|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (LETT |lst_wrk|
                          (LIST
                           (SPADCALL
                            (SPADCALL (QVELT |sys| 0) |i| (QREFELT $ 49))
                            (QREFELT $ 50))))
                    (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |j| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |lst_wrk|
                                 (CONS
                                  (SPADCALL
                                   (QAREF2O (QVELT |sys| 2) |i| |j| 1 1)
                                   (QREFELT $ 52))
                                  |lst_wrk|))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL |mtx| (+ |i| 1) (REVERSE |lst_wrk|)
                               (QREFELT $ 51))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |mtx| (QREFELT $ 54)))))) 

(SDEFUN |XDPOLYF;findNonZeroEntry;M2NniL;6|
        ((A (|Matrix| F)) (|i| (|NonNegativeInteger|))
         (|j| (|NonNegativeInteger|)) ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((#1=#:G833 NIL) (#2=#:G832 NIL) (|col_nz| #3=(|NonNegativeInteger|))
          (|row_nz| #3#) (|flg_nz| (|Boolean|)) (#4=#:G835 NIL) (|k| NIL)
          (#5=#:G834 NIL) (|l| NIL))
         (SEQ (LETT |flg_nz| NIL) (LETT |row_nz| 0) (LETT |col_nz| 0)
              (SEQ
               (EXIT
                (SEQ (LETT |l| |j|) (LETT #5# (ANCOLS A)) G190
                     (COND ((> |l| #5#) (GO G191)))
                     (SEQ
                      (SEQ
                       (EXIT
                        (SEQ (LETT |k| |i|) (LETT #4# (ANROWS A)) G190
                             (COND ((> |k| #4#) (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((NULL
                                  (SPADCALL (QAREF2O A |k| |l| 1 1)
                                            (|spadConstant| $ 22)
                                            (QREFELT $ 56)))
                                 (SEQ (LETT |flg_nz| 'T) (LETT |row_nz| |k|)
                                      (LETT |col_nz| |l|)
                                      (EXIT
                                       (PROGN
                                        (LETT #2# |$NoValue|)
                                        (GO #6=#:G827))))))))
                             (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL)))
                       #6# (EXIT #2#))
                      (EXIT
                       (COND
                        (|flg_nz|
                         (PROGN (LETT #1# |$NoValue|) (GO #7=#:G829))))))
                     (LETT |l| (+ |l| 1)) (GO G190) G191 (EXIT NIL)))
               #7# (EXIT #1#))
              (EXIT (LIST |row_nz| |col_nz|))))) 

(SDEFUN |XDPOLYF;addRows!|
        ((A (|Matrix| F)) (|i| (|NonNegativeInteger|))
         (|j| (|NonNegativeInteger|)) (|alpha| (F)) ($ (|Matrix| F)))
        (SPROG ((#1=#:G840 NIL) (|k| NIL))
               (SEQ
                (SEQ (LETT |k| 1) (LETT #1# (ANCOLS A)) G190
                     (COND ((|greater_SI| |k| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (QSETAREF2O A |j| |k|
                                   (SPADCALL
                                    (SPADCALL |alpha| (QAREF2O A |i| |k| 1 1)
                                              (QREFELT $ 59))
                                    (QAREF2O A |j| |k| 1 1) (QREFELT $ 32))
                                   1 1)))
                     (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                (EXIT A)))) 

(SDEFUN |XDPOLYF;minimalMatrix;MNniM;8|
        ((A (|Matrix| F)) (|r| (|NonNegativeInteger|)) ($ (|Matrix| F)))
        (SPROG
         ((|n| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
          (#1=#:G855 NIL) (#2=#:G863 NIL) (|i| NIL) (#3=#:G862 NIL) (|j| NIL)
          (#4=#:G861 NIL) (#5=#:G845 NIL) (#6=#:G860 NIL) (B (|Matrix| F)))
         (SEQ (LETT |m| (ANROWS A)) (LETT |n| (ANCOLS A))
              (LETT B (SPADCALL A (QREFELT $ 60)))
              (SEQ G190
                   (COND
                    ((NULL (>= (SPADCALL B (QREFELT $ 61)) |r|)) (GO G191)))
                   (SEQ
                    (SEQ (LETT |j| 1) (LETT #6# (ANCOLS A)) G190
                         (COND ((|greater_SI| |j| #6#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL B |m| |j| (|spadConstant| $ 22)
                                     (QREFELT $ 33))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (LETT |m|
                           (PROG1 (LETT #5# (- |m| 1))
                             (|check_subtype2| (> #5# 0) '(|PositiveInteger|)
                                               '(|Integer|) #5#)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |i| |m|) (LETT #4# (ANROWS A)) G190
                   (COND ((> |i| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #3# (ANCOLS A)) G190
                          (COND ((|greater_SI| |j| #3#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL B |i| |j|
                                      (SPADCALL A |i| |j| (QREFELT $ 31))
                                      (QREFELT $ 33))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (SEQ G190
                   (COND
                    ((NULL (>= (SPADCALL B (QREFELT $ 61)) |r|)) (GO G191)))
                   (SEQ
                    (SEQ (LETT |i| 1) (LETT #2# (ANROWS A)) G190
                         (COND ((|greater_SI| |i| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL B |i| |n| (|spadConstant| $ 22)
                                     (QREFELT $ 33))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (LETT |n|
                           (PROG1 (LETT #1# (- |n| 1))
                             (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                               '(|Integer|) #1#)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |m| (+ |m| 1)) (LETT |n| (+ |n| 1))
              (EXIT (SPADCALL A 1 |m| 1 |n| (QREFELT $ 62)))))) 

(SDEFUN |XDPOLYF;transformationMatrices;ML;9|
        ((A (|Matrix| F)) ($ (|List| (|Matrix| F))))
        (SPROG
         ((#1=#:G889 NIL) (|k| NIL) (#2=#:G888 NIL) (#3=#:G887 NIL)
          (|beta| (F)) (|idx| (|List| (|NonNegativeInteger|))) (#4=#:G886 NIL)
          (|j| NIL) (B (|Matrix| F)) (#5=#:G885 NIL) (#6=#:G884 NIL) (|i| NIL)
          (Q #7=(|Matrix| F)) (P #7#) (|rnk_A| (|NonNegativeInteger|))
          (|n| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|)))
         (SEQ (LETT |m| (ANROWS A)) (LETT |n| (ANCOLS A))
              (LETT |rnk_A| (SPADCALL A (QREFELT $ 61)))
              (LETT P (MAKE_MATRIX1 |m| |m| (|spadConstant| $ 22)))
              (LETT Q (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 22)))
              (SEQ (LETT |i| 1) (LETT #6# |m|) G190
                   (COND ((|greater_SI| |i| #6#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL P |i| |i| (|spadConstant| $ 42)
                               (QREFELT $ 33))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |j| 1) (LETT #5# |n|) G190
                   (COND ((|greater_SI| |j| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL Q |j| |j| (|spadConstant| $ 42)
                               (QREFELT $ 33))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (LETT B (SPADCALL A (QREFELT $ 60)))
              (SEQ (LETT |j| 1) (LETT #4# |rnk_A|) G190
                   (COND ((|greater_SI| |j| #4#) (GO G191)))
                   (SEQ (LETT |idx| (SPADCALL B |j| |j| (QREFELT $ 58)))
                        (COND
                         ((NULL (EQL |j| (SPADCALL |idx| 1 (QREFELT $ 64))))
                          (SEQ
                           (SPADCALL B (SPADCALL |idx| 1 (QREFELT $ 64)) |j|
                                     (QREFELT $ 65))
                           (EXIT
                            (SPADCALL P (SPADCALL |idx| 1 (QREFELT $ 64)) |j|
                                      (QREFELT $ 65))))))
                        (COND
                         ((NULL (EQL |j| (SPADCALL |idx| 2 (QREFELT $ 64))))
                          (SEQ
                           (SPADCALL B (SPADCALL |idx| 2 (QREFELT $ 64)) |j|
                                     (QREFELT $ 66))
                           (EXIT
                            (SPADCALL Q (SPADCALL |idx| 2 (QREFELT $ 64)) |j|
                                      (QREFELT $ 66))))))
                        (LETT |beta|
                              (SPADCALL (|spadConstant| $ 42)
                                        (QAREF2O B |j| |j| 1 1)
                                        (QREFELT $ 67)))
                        (SEQ (LETT |k| 1) (LETT #3# |n|) G190
                             (COND ((|greater_SI| |k| #3#) (GO G191)))
                             (SEQ
                              (EXIT
                               (QSETAREF2O B |j| |k|
                                           (SPADCALL |beta|
                                                     (QAREF2O B |j| |k| 1 1)
                                                     (QREFELT $ 59))
                                           1 1)))
                             (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                             (EXIT NIL))
                        (SEQ (LETT |k| 1) (LETT #2# |m|) G190
                             (COND ((|greater_SI| |k| #2#) (GO G191)))
                             (SEQ
                              (EXIT
                               (QSETAREF2O P |j| |k|
                                           (SPADCALL |beta|
                                                     (QAREF2O P |j| |k| 1 1)
                                                     (QREFELT $ 59))
                                           1 1)))
                             (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT
                         (SEQ (LETT |k| 1) (LETT #1# |m|) G190
                              (COND ((|greater_SI| |k| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((NULL (EQL |k| |j|))
                                  (SEQ
                                   (|XDPOLYF;addRows!| P |j| |k|
                                    (SPADCALL
                                     (SPADCALL B |k| |j| (QREFELT $ 31))
                                     (QREFELT $ 68))
                                    $)
                                   (EXIT
                                    (|XDPOLYF;addRows!| B |j| |k|
                                     (SPADCALL
                                      (SPADCALL B |k| |j| (QREFELT $ 31))
                                      (QREFELT $ 68))
                                     $)))))))
                              (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                              (EXIT NIL))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (EXIT (LIST P Q))))) 

(SDEFUN |XDPOLYF;minimalRepresentation;XdpR;10|
        ((|p| (|XDistributedPolynomial| VAR F))
         ($
          (|Record| (|:| |alpha| (|Matrix| F)) (|:| |mu| (|List| (|Matrix| F)))
                    (|:| |var| (|List| VAR)) (|:| |beta| (|Matrix| F)))))
        (SPROG
         ((|mu_lst| (|List| (|Matrix| F))) (|mu_wrk| #1=(|Matrix| F))
          (H (|Matrix| F)) (#2=#:G905 NIL) (|sym| NIL) (|var_lst| (|List| VAR))
          (|b_wrk| #1#) (|a_wrk| #1#) (#3=#:G904 NIL) (|k| NIL)
          (V_2 #4=(|Matrix| F)) (V_1 #4#) (I_2 #4#) (I_1 #4#)
          (Q #5=(|Matrix| F)) (P #5#) (|lst_tr| (|List| (|Matrix| F)))
          (|n| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
          (|min_hankel| (|Matrix| F)) (|rnk_p| (|NonNegativeInteger|))
          (|mtx_hankel| (|Matrix| F)))
         (SEQ (LETT |mtx_hankel| (SPADCALL |p| (QREFELT $ 36)))
              (LETT |rnk_p| (SPADCALL |mtx_hankel| (QREFELT $ 61)))
              (LETT |min_hankel|
                    (SPADCALL |mtx_hankel| |rnk_p| (QREFELT $ 63)))
              (LETT |m| (ANROWS |min_hankel|)) (LETT |n| (ANCOLS |min_hankel|))
              (LETT |lst_tr| (SPADCALL |min_hankel| (QREFELT $ 70)))
              (LETT P (SPADCALL |lst_tr| 1 (QREFELT $ 72)))
              (LETT Q (SPADCALL |lst_tr| 2 (QREFELT $ 72)))
              (LETT I_1 (MAKE_MATRIX1 |rnk_p| |m| (|spadConstant| $ 22)))
              (LETT I_2 (MAKE_MATRIX1 |n| |rnk_p| (|spadConstant| $ 22)))
              (LETT V_1 (MAKE_MATRIX1 1 |m| (|spadConstant| $ 22)))
              (SPADCALL V_1 1 1 (|spadConstant| $ 42) (QREFELT $ 33))
              (LETT V_2 (MAKE_MATRIX1 |n| 1 (|spadConstant| $ 22)))
              (SPADCALL V_2 1 1 (|spadConstant| $ 42) (QREFELT $ 33))
              (SEQ (LETT |k| 1) (LETT #3# |rnk_p|) G190
                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                   (SEQ
                    (SPADCALL I_1 |k| |k| (|spadConstant| $ 42) (QREFELT $ 33))
                    (EXIT
                     (SPADCALL I_2 |k| |k| (|spadConstant| $ 42)
                               (QREFELT $ 33))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (LETT |a_wrk|
                    (SPADCALL
                     (SPADCALL (SPADCALL V_1 |min_hankel| (QREFELT $ 73)) Q
                               (QREFELT $ 73))
                     I_2 (QREFELT $ 73)))
              (LETT |b_wrk|
                    (SPADCALL
                     (SPADCALL (SPADCALL I_1 P (QREFELT $ 73)) |min_hankel|
                               (QREFELT $ 73))
                     V_2 (QREFELT $ 73)))
              (LETT |mu_lst| NIL)
              (LETT |var_lst| (SPADCALL |p| (QREFELT $ 75)))
              (SEQ (LETT |sym| NIL) (LETT #2# (REVERSE |var_lst|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |sym| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT H (SPADCALL |p| |sym| (QREFELT $ 39)))
                        (LETT |mu_wrk|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (SPADCALL I_1 P (QREFELT $ 73))
                                          (SPADCALL H 1 |m| 1 |n|
                                                    (QREFELT $ 62))
                                          (QREFELT $ 73))
                                Q (QREFELT $ 73))
                               I_2 (QREFELT $ 73)))
                        (EXIT (LETT |mu_lst| (CONS |mu_wrk| |mu_lst|))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |a_wrk| |mu_lst| |var_lst| |b_wrk|))))) 

(DECLAIM (NOTINLINE |XDistributedPolynomialFunctions;|)) 

(DEFUN |XDistributedPolynomialFunctions| (&REST #1=#:G906)
  (SPROG NIL
         (PROG (#2=#:G907)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|XDistributedPolynomialFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |XDistributedPolynomialFunctions;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|XDistributedPolynomialFunctions|)))))))))) 

(DEFUN |XDistributedPolynomialFunctions;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|XDistributedPolynomialFunctions| DV$1 DV$2))
          (LETT $ (GETREFV 78))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|XDistributedPolynomialFunctions|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|XDistributedPolynomialFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|FreeMonoid| 6) (0 . |One|) (|List| 8)
              (|XDistributedPolynomial| 6 7) (4 . |support|)
              (|Record| (|:| |gen| 6) (|:| |exp| 43)) (|List| 13)
              (9 . |factors|) (14 . *) (20 . *) (26 . |merge|)
              (32 . |removeDuplicates|) (37 . |sort|)
              |XDPOLYF;hankelIndices;XdpL;1| (42 . |Zero|) (46 . |Zero|)
              (|List| 7) (50 . |coefficients|) (|Integer|) (55 . |elt|)
              (61 . |elt|) (67 . |position|) (|Matrix| 7) (73 . |elt|) (80 . +)
              (86 . |setelt!|) (|Union| $ '"failed") (94 . |lquo|)
              |XDPOLYF;hankelMatrix;XdpM;2| (|Boolean|) (100 . =)
              |XDPOLYF;hankelMatrix;XdpVARM;3|
              (|Record| (|:| |rows| 10) (|:| |cols| 10) (|:| H 30))
              |XDPOLYF;hankelSystem;XdpR;4| (106 . |One|)
              (|NonNegativeInteger|) (|List| 47) (|List| 44) (110 . |new|)
              (|OutputForm|) (116 . |hspace|) (121 . |qelt|) (127 . |coerce|)
              (132 . |qsetelt!|) (139 . |coerce|) (|List| (|List| $))
              (144 . |matrix|) |XDPOLYF;display;ROf;5| (149 . =) (|List| 43)
              |XDPOLYF;findNonZeroEntry;M2NniL;6| (155 . *) (161 . |copy|)
              (166 . |rank|) (171 . |subMatrix|)
              |XDPOLYF;minimalMatrix;MNniM;8| (180 . |elt|) (186 . |swapRows!|)
              (193 . |swapColumns!|) (200 . /) (206 . -) (|List| 30)
              |XDPOLYF;transformationMatrices;ML;9| (211 . |One|) (215 . |elt|)
              (221 . *) (|List| 6) (227 . |varList|)
              (|Record| (|:| |alpha| 30) (|:| |mu| 69) (|:| |var| 74)
                        (|:| |beta| 30))
              |XDPOLYF;minimalRepresentation;XdpR;10|)
           '#(|transformationMatrices| 232 |minimalRepresentation| 237
              |minimalMatrix| 242 |hankelSystem| 248 |hankelMatrix| 253
              |hankelIndices| 264 |findNonZeroEntry| 269 |display| 276)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|hankelIndices|
                                 ((|List| (|FreeMonoid| |#1|))
                                  (|XDistributedPolynomial| |#1| |#2|)))
                                T)
                              '((|hankelMatrix|
                                 ((|Matrix| |#2|)
                                  (|XDistributedPolynomial| |#1| |#2|)))
                                T)
                              '((|hankelMatrix|
                                 ((|Matrix| |#2|)
                                  (|XDistributedPolynomial| |#1| |#2|) |#1|))
                                T)
                              '((|hankelSystem|
                                 ((|Record|
                                   (|:| |rows| (|List| (|FreeMonoid| |#1|)))
                                   (|:| |cols| (|List| (|FreeMonoid| |#1|)))
                                   (|:| H (|Matrix| |#2|)))
                                  (|XDistributedPolynomial| |#1| |#2|)))
                                T)
                              '((|display|
                                 ((|OutputForm|)
                                  (|Record|
                                   (|:| |rows| (|List| (|FreeMonoid| |#1|)))
                                   (|:| |cols| (|List| (|FreeMonoid| |#1|)))
                                   (|:| H (|Matrix| |#2|)))))
                                T)
                              '((|minimalMatrix|
                                 ((|Matrix| |#2|) (|Matrix| |#2|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|findNonZeroEntry|
                                 ((|List| (|NonNegativeInteger|))
                                  (|Matrix| |#2|) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|transformationMatrices|
                                 ((|List| (|Matrix| |#2|)) (|Matrix| |#2|)))
                                T)
                              '((|minimalRepresentation|
                                 ((|Record| (|:| |alpha| (|Matrix| |#2|))
                                            (|:| |mu| (|List| (|Matrix| |#2|)))
                                            (|:| |var| (|List| |#1|))
                                            (|:| |beta| (|Matrix| |#2|)))
                                  (|XDistributedPolynomial| |#1| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 77
                                            '(0 8 0 9 1 11 10 0 12 1 8 14 0 15
                                              2 8 0 0 6 16 2 8 0 6 0 17 2 10 0
                                              0 0 18 1 10 0 0 19 1 10 0 0 20 0
                                              7 0 22 0 11 0 23 1 11 24 0 25 2
                                              10 8 0 26 27 2 24 7 0 26 28 2 10
                                              26 8 0 29 3 30 7 0 26 26 31 2 7 0
                                              0 0 32 4 30 7 0 26 26 7 33 2 8 34
                                              0 0 35 2 6 37 0 0 38 0 7 0 42 2
                                              45 0 43 44 46 1 47 0 26 48 2 10 8
                                              0 26 49 1 8 47 0 50 3 45 44 0 26
                                              44 51 1 7 47 0 52 1 47 0 53 54 2
                                              7 37 0 0 56 2 7 0 0 0 59 1 30 0 0
                                              60 1 30 43 0 61 5 30 0 0 26 26 26
                                              26 62 2 57 43 0 26 64 3 30 0 0 26
                                              26 65 3 30 0 0 26 26 66 2 7 0 0 0
                                              67 1 7 0 0 68 0 11 0 71 2 69 30 0
                                              26 72 2 30 0 0 0 73 1 11 74 0 75
                                              1 0 69 30 70 1 0 76 11 77 2 0 30
                                              30 43 63 1 0 40 11 41 1 0 30 11
                                              36 2 0 30 11 6 39 1 0 10 11 21 3
                                              0 57 30 43 43 58 1 0 47 40
                                              55)))))
           '|lookupComplete|)) 

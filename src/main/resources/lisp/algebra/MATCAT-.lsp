
(SDEFUN |MATCAT-;square?;SB;1| ((|x| (S)) ($ (|Boolean|)))
        (EQL (SPADCALL |x| (QREFELT $ 11)) (SPADCALL |x| (QREFELT $ 12)))) 

(SDEFUN |MATCAT-;diagonal?;SB;2| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G745 NIL) (#2=#:G746 NIL) (#3=#:G748 NIL) (|j| NIL)
          (#4=#:G747 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (COND ((NULL (SPADCALL |x| (QREFELT $ 15))) NIL)
                 ('T
                  (SEQ
                   (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                        (LETT #4# (SPADCALL |x| (QREFELT $ 18))) G190
                        (COND ((> |i| #4#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 19)))
                               (LETT #3# (SPADCALL |x| (QREFELT $ 20))) G190
                               (COND ((> |j| #3#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL
                                    (- |j| (SPADCALL |x| (QREFELT $ 19)))
                                    (- |i| (SPADCALL |x| (QREFELT $ 17)))
                                    (QREFELT $ 21))
                                   (COND
                                    ((NULL
                                      (SPADCALL
                                       (SPADCALL |x| |i| |j| (QREFELT $ 22))
                                       (QREFELT $ 23)))
                                     (PROGN
                                      (LETT #1#
                                            (PROGN
                                             (LETT #2# NIL)
                                             (GO #5=#:G744)))
                                      (GO #6=#:G741))))))))
                               (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                         #6# (EXIT #1#))
                        (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                   (EXIT 'T)))))
          #5# (EXIT #2#)))) 

(SDEFUN |MATCAT-;symmetric?;SB;3| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G757 NIL) (#2=#:G758 NIL) (#3=#:G760 NIL) (|j| NIL)
          (#4=#:G759 NIL) (|i| NIL) (|mc| (|Integer|)) (|mr| (|Integer|))
          (|nRows| (|Integer|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |nRows| (SPADCALL |x| (QREFELT $ 11)))
                       (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 21))
             NIL)
            ('T
             (SEQ (LETT |mr| (SPADCALL |x| (QREFELT $ 17)))
                  (LETT |mc| (SPADCALL |x| (QREFELT $ 19)))
                  (SEQ (LETT |i| 0) (LETT #4# (- |nRows| 1)) G190
                       (COND ((|greater_SI| |i| #4#) (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |j| (+ |i| 1)) (LETT #3# (- |nRows| 1))
                              G190 (COND ((> |j| #3#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL
                                   (SPADCALL |x| (+ |mr| |i|) (+ |mc| |j|)
                                             (QREFELT $ 22))
                                   (SPADCALL |x| (+ |mr| |j|) (+ |mc| |i|)
                                             (QREFELT $ 22))
                                   (QREFELT $ 25))
                                  (PROGN
                                   (LETT #1#
                                         (PROGN (LETT #2# NIL) (GO #5=#:G756)))
                                   (GO #6=#:G752))))))
                              (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                        #6# (EXIT #1#))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))))
          #5# (EXIT #2#)))) 

(SDEFUN |MATCAT-;antisymmetric?;SB;4| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G769 NIL) (#2=#:G770 NIL) (#3=#:G772 NIL) (|j| NIL)
          (#4=#:G771 NIL) (|i| NIL) (|mc| (|Integer|)) (|mr| (|Integer|))
          (|nRows| (|Integer|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |nRows| (SPADCALL |x| (QREFELT $ 11)))
                       (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 21))
             NIL)
            ('T
             (SEQ (LETT |mr| (SPADCALL |x| (QREFELT $ 17)))
                  (LETT |mc| (SPADCALL |x| (QREFELT $ 19)))
                  (SEQ (LETT |i| 0) (LETT #4# (- |nRows| 1)) G190
                       (COND ((|greater_SI| |i| #4#) (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |j| |i|) (LETT #3# (- |nRows| 1)) G190
                              (COND ((> |j| #3#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL
                                   (SPADCALL |x| (+ |mr| |i|) (+ |mc| |j|)
                                             (QREFELT $ 22))
                                   (SPADCALL
                                    (SPADCALL |x| (+ |mr| |j|) (+ |mc| |i|)
                                              (QREFELT $ 22))
                                    (QREFELT $ 27))
                                   (QREFELT $ 25))
                                  (PROGN
                                   (LETT #1#
                                         (PROGN (LETT #2# NIL) (GO #5=#:G768)))
                                   (GO #6=#:G764))))))
                              (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                        #6# (EXIT #1#))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))))
          #5# (EXIT #2#)))) 

(SDEFUN |MATCAT-;zero;2NniS;5|
        ((|rows| (|NonNegativeInteger|)) (|cols| (|NonNegativeInteger|))
         ($ (S)))
        (SPADCALL |rows| |cols| (|spadConstant| $ 29) (QREFELT $ 30))) 

(SDEFUN |MATCAT-;matrix;LS;6| ((|l| (|List| (|List| R))) ($ (S)))
        (SPROG
         ((#1=#:G791 NIL) (|j| NIL) (#2=#:G792 NIL) (|r| NIL) (#3=#:G789 NIL)
          (|i| NIL) (#4=#:G790 NIL) (|ll| NIL) (|ans| (S))
          (|rows| (|NonNegativeInteger|)) (#5=#:G788 NIL)
          (|cols| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((NULL |l|) (SPADCALL 0 0 (|spadConstant| $ 29) (QREFELT $ 30)))
           ('T
            (SEQ (LETT |rows| 1) (LETT |cols| (LENGTH (|SPADfirst| |l|)))
                 (SEQ (LETT |ll| NIL) (LETT #5# (CDR |l|)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |ll| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL |cols| (LENGTH |ll|) (QREFELT $ 32))
                          (|error| "matrix: rows of different lengths"))
                         ('T (LETT |rows| (+ |rows| 1))))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (LETT |ans|
                       (SPADCALL |rows| |cols| (|spadConstant| $ 29)
                                 (QREFELT $ 30)))
                 (SEQ (LETT |ll| NIL) (LETT #4# |l|)
                      (LETT |i| (SPADCALL |ans| (QREFELT $ 17)))
                      (LETT #3# (SPADCALL |ans| (QREFELT $ 18))) G190
                      (COND
                       ((OR (> |i| #3#) (ATOM #4#)
                            (PROGN (LETT |ll| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (SEQ (LETT |r| NIL) (LETT #2# |ll|)
                             (LETT |j| (SPADCALL |ans| (QREFELT $ 19)))
                             (LETT #1# (SPADCALL |ans| (QREFELT $ 20))) G190
                             (COND
                              ((OR (> |j| #1#) (ATOM #2#)
                                   (PROGN (LETT |r| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |ans| |i| |j| |r| (QREFELT $ 33))))
                             (LETT |j| (PROG1 (+ |j| 1) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT NIL))))
                      (LETT |i| (PROG1 (+ |i| 1) (LETT #4# (CDR #4#))))
                      (GO G190) G191 (EXIT NIL))
                 (EXIT |ans|))))))) 

(SDEFUN |MATCAT-;matrix;2NniMS;7|
        ((|n| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
         (|f| (|Mapping| R (|Integer|) (|Integer|))) ($ (S)))
        (SPROG
         ((#1=#:G801 NIL) (|j| NIL) (#2=#:G800 NIL) (|i| NIL) (|mat| (S)))
         (SEQ
          (LETT |mat| (SPADCALL |n| |m| (|spadConstant| $ 29) (QREFELT $ 30)))
          (SEQ (LETT |i| (SPADCALL |mat| (QREFELT $ 17)))
               (LETT #2# (SPADCALL |mat| (QREFELT $ 18))) G190
               (COND ((> |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| (SPADCALL |mat| (QREFELT $ 19)))
                      (LETT #1# (SPADCALL |mat| (QREFELT $ 20))) G190
                      (COND ((> |j| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SPADCALL |mat| |i| |j| (SPADCALL |i| |j| |f|)
                                  (QREFELT $ 33))))
                      (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
          (EXIT |mat|)))) 

(SDEFUN |MATCAT-;get_dims|
        ((|l| (|List| S)) ($ (|List| (|List| (|NonNegativeInteger|)))))
        (SPROG ((#1=#:G809 NIL) (|a| NIL) (#2=#:G808 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |a| NIL) (LETT #1# |l|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (LIST (SPADCALL |a| (QREFELT $ 11))
                                     (SPADCALL |a| (QREFELT $ 12)))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |MATCAT-;zero?;SB;9| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G818 NIL) (#2=#:G820 NIL) (|j| NIL) (#3=#:G819 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| (PROGN |x| 1))
                 (LETT #3# (SPADCALL |x| (QREFELT $ 18))) G190
                 (COND ((> |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| (PROGN |x| 1))
                        (LETT #2# (SPADCALL |x| (QREFELT $ 20))) G190
                        (COND ((> |j| #2#) (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL (QAREF2O |x| |i| |j| 1 1)
                                      (|spadConstant| $ 29) (QREFELT $ 25))
                            (PROGN (LETT #1# NIL) (GO #4=#:G817))))))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #4# (EXIT #1#)))) 

(SDEFUN |MATCAT-;scalarMatrix;NniRS;10|
        ((|n| (|NonNegativeInteger|)) (|r| (R)) ($ (S)))
        (SPROG
         ((#1=#:G825 NIL) (|i| NIL) (#2=#:G826 NIL) (|j| NIL) (|ans| (S)))
         (SEQ (LETT |ans| (SPADCALL |n| |n| (QREFELT $ 41)))
              (SEQ (LETT |j| (PROGN |ans| 1))
                   (LETT #2# (SPADCALL |ans| (QREFELT $ 20)))
                   (LETT |i| (PROGN |ans| 1))
                   (LETT #1# (SPADCALL |ans| (QREFELT $ 18))) G190
                   (COND ((OR (> |i| #1#) (> |j| #2#)) (GO G191)))
                   (SEQ (EXIT (QSETAREF2O |ans| |i| |j| |r| 1 1)))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;diagonalMatrix;LS;11| ((|l| (|List| R)) ($ (S)))
        (SPROG
         ((#1=#:G831 NIL) (|i| NIL) (#2=#:G832 NIL) (|j| NIL) (#3=#:G833 NIL)
          (|r| NIL) (|ans| (S)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |l|))
              (LETT |ans| (SPADCALL |n| |n| (QREFELT $ 41)))
              (SEQ (LETT |r| NIL) (LETT #3# |l|) (LETT |j| (PROGN |ans| 1))
                   (LETT #2# (SPADCALL |ans| (QREFELT $ 20)))
                   (LETT |i| (PROGN |ans| 1))
                   (LETT #1# (SPADCALL |ans| (QREFELT $ 18))) G190
                   (COND
                    ((OR (> |i| #1#) (> |j| #2#) (ATOM #3#)
                         (PROGN (LETT |r| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (QSETAREF2O |ans| |i| |j| |r| 1 1)))
                   (LETT |i|
                         (PROG1 (+ |i| 1)
                           (LETT |j| (PROG1 (+ |j| 1) (LETT #3# (CDR #3#))))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;kronecker_prod1;SILL2NniUV;12|
        ((|res| (S)) (|k| (|Integer|))
         (|dl| (|List| (|List| (|NonNegativeInteger|)))) (|l| (|List| S))
         (|r_off| (|NonNegativeInteger|)) (|c_off| (|NonNegativeInteger|))
         (|mu| (|Union| R "one")) ($ (|Void|)))
        (SPROG
         ((|c_off1| (|NonNegativeInteger|)) (|mm| (R)) (|aij| (R))
          (#1=#:G882 NIL) (|j| NIL) (#2=#:G881 NIL) (|i| NIL)
          (|c_step| #3=(|NonNegativeInteger|)) (#4=#:G880 NIL) (|rc| NIL)
          (#5=#:G879 NIL) (|r_step| #3#) (#6=#:G878 NIL) (#7=#:G877 NIL)
          (|c_ind| (|NonNegativeInteger|)) (#8=#:G876 NIL) (#9=#:G875 NIL)
          (|m| (R)) (|a| (S)) (|nc| #10=(|NonNegativeInteger|)) (|nr| #10#)
          (|dp| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |dp| (|SPADfirst| |dl|))
              (LETT |nr| (SPADCALL |dp| 1 (QREFELT $ 46)))
              (LETT |nc| (SPADCALL |dp| 2 (QREFELT $ 46)))
              (LETT |a| (|SPADfirst| |l|))
              (EXIT
               (COND
                ((EQL |k| 1)
                 (COND
                  ((QEQCAR |mu| 1) (|error| "kronecker_prod1: impossible"))
                  (#11='T
                   (SEQ (LETT |m| (QCDR |mu|))
                        (EXIT
                         (SEQ (LETT |i| 1) (LETT #9# |nr|) G190
                              (COND ((|greater_SI| |i| #9#) (GO G191)))
                              (SEQ (LETT |r_off| (+ |r_off| 1))
                                   (LETT |c_ind| (+ |c_off| 1))
                                   (EXIT
                                    (SEQ (LETT |j| 1) (LETT #8# |nc|) G190
                                         (COND
                                          ((|greater_SI| |j| #8#) (GO G191)))
                                         (SEQ
                                          (QSETAREF2O |res| |r_off| |c_ind|
                                                      (SPADCALL |m|
                                                                (QAREF2O |a|
                                                                         |i|
                                                                         |j| 1
                                                                         1)
                                                                (QREFELT $ 47))
                                                      1 1)
                                          (EXIT (LETT |c_ind| (+ |c_ind| 1))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT NIL))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL)))))))
                (#11#
                 (SEQ (LETT |dl| (CDR |dl|)) (LETT |l| (CDR |l|))
                      (LETT |r_step|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #7# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #6# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #6#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #6#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #7#
                                                    (CONS
                                                     (SPADCALL |rc| 1
                                                               (QREFELT $ 46))
                                                     #7#))))
                                            (LETT #6# (CDR #6#)) (GO G190) G191
                                            (EXIT (NREVERSE #7#))))
                                      (QREFELT $ 50)))
                      (LETT |c_step|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #4# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #4#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #4#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |rc| 2
                                                               (QREFELT $ 46))
                                                     #5#))))
                                            (LETT #4# (CDR #4#)) (GO G190) G191
                                            (EXIT (NREVERSE #5#))))
                                      (QREFELT $ 50)))
                      (EXIT
                       (SEQ (LETT |i| 1) (LETT #2# |nr|) G190
                            (COND ((|greater_SI| |i| #2#) (GO G191)))
                            (SEQ (LETT |c_off1| |c_off|)
                                 (SEQ (LETT |j| 1) (LETT #1# |nc|) G190
                                      (COND ((|greater_SI| |j| #1#) (GO G191)))
                                      (SEQ
                                       (LETT |aij| (QAREF2O |a| |i| |j| 1 1))
                                       (LETT |mm|
                                             (COND ((QEQCAR |mu| 1) |aij|)
                                                   ('T
                                                    (SPADCALL (QCDR |mu|) |aij|
                                                              (QREFELT $
                                                                       47)))))
                                       (SPADCALL |res| (- |k| 1) |dl| |l|
                                                 |r_off| |c_off1| (CONS 0 |mm|)
                                                 (QREFELT $ 55))
                                       (EXIT
                                        (LETT |c_off1| (+ |c_off1| |c_step|))))
                                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT (LETT |r_off| (+ |r_off| |r_step|))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL)))))))))) 

(SDEFUN |MATCAT-;kroneckerProduct;LS;13| ((|l| (|List| S)) ($ (S)))
        (SPROG
         ((|res| (S)) (|nc| #1=(|NonNegativeInteger|)) (#2=#:G913 NIL)
          (|rc| NIL) (#3=#:G912 NIL) (|nr| #1#) (#4=#:G911 NIL) (#5=#:G910 NIL)
          (|dl| (|List| (|List| (|NonNegativeInteger|))))
          (|k| (|NonNegativeInteger|)))
         (SEQ (LETT |k| (LENGTH |l|))
              (EXIT
               (COND
                ((EQL |k| 0)
                 (COND
                  ((QEQCAR (QREFELT $ 39) 0)
                   (MAKE_MATRIX1 1 1 (QCDR (QREFELT $ 39))))
                  (#6='T (|error| "need 1"))))
                ((EQL |k| 1) (SPADCALL (|SPADfirst| |l|) (QREFELT $ 57)))
                (#6#
                 (SEQ (LETT |dl| (|MATCAT-;get_dims| |l| $))
                      (LETT |nr|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #4# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #4#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #4#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |rc| 1
                                                               (QREFELT $ 46))
                                                     #5#))))
                                            (LETT #4# (CDR #4#)) (GO G190) G191
                                            (EXIT (NREVERSE #5#))))
                                      (QREFELT $ 50)))
                      (LETT |nc|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #3# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #2# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #2#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #2#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #3#
                                                    (CONS
                                                     (SPADCALL |rc| 2
                                                               (QREFELT $ 46))
                                                     #3#))))
                                            (LETT #2# (CDR #2#)) (GO G190) G191
                                            (EXIT (NREVERSE #3#))))
                                      (QREFELT $ 50)))
                      (LETT |res| (SPADCALL |nr| |nc| (QREFELT $ 41)))
                      (SPADCALL |res| |k| |dl| |l| 0 0 (CONS 1 "one")
                                (QREFELT $ 55))
                      (EXIT |res|)))))))) 

(SDEFUN |MATCAT-;kroneckerProduct;3S;14| ((|a| (S)) (|b| (S)) ($ (S)))
        (SPADCALL (LIST |a| |b|) (QREFELT $ 59))) 

(SDEFUN |MATCAT-;kroneckerSum;LS;15| ((|l| (|List| S)) ($ (S)))
        (SPROG
         ((|n0| (|Integer|)) (|off0| (|NonNegativeInteger|))
          (|off_r| #1=(|NonNegativeInteger|)) (|ind_c| #1#) (|vv| (R))
          (#2=#:G960 NIL) (|j| NIL) (#3=#:G959 NIL) (#4=#:G958 NIL) (|i| NIL)
          (#5=#:G957 NIL) (|m| NIL) (|step0| (|NonNegativeInteger|))
          (|n2| (|NonNegativeInteger|)) (|dl| (|List| (|NonNegativeInteger|)))
          (|nr| (|NonNegativeInteger|)) (#6=#:G956 NIL) (|a| NIL) (|res| (S))
          (|nrs| (|NonNegativeInteger|)) (#7=#:G955 NIL) (#8=#:G954 NIL)
          (|nc| (|NonNegativeInteger|)) (#9=#:G953 NIL)
          (|k| (|NonNegativeInteger|)))
         (SEQ (LETT |k| (LENGTH |l|))
              (EXIT
               (COND ((EQL |k| 0) (SPADCALL 1 1 (QREFELT $ 41)))
                     ((EQL |k| 1) (SPADCALL (|SPADfirst| |l|) (QREFELT $ 57)))
                     ('T
                      (SEQ (LETT |dl| NIL)
                           (SEQ (LETT |a| NIL) (LETT #9# |l|) G190
                                (COND
                                 ((OR (ATOM #9#)
                                      (PROGN (LETT |a| (CAR #9#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |nr| (ANROWS |a|))
                                     (LETT |nc| (ANCOLS |a|))
                                     (EXIT
                                      (COND
                                       ((SPADCALL |nr| |nc| (QREFELT $ 32))
                                        (|error|
                                         "kroneckerSum: nonsquare matrix"))
                                       ('T (LETT |dl| (CONS |nr| |dl|))))))
                                (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                           (LETT |dl| (NREVERSE |dl|))
                           (LETT |nrs|
                                 (SPADCALL (ELT $ 48)
                                           (PROGN
                                            (LETT #8# NIL)
                                            (SEQ (LETT #7# |dl|) G190
                                                 (COND
                                                  ((OR (ATOM #7#)
                                                       (PROGN
                                                        (LETT |nr| (CAR #7#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #8# (CONS |nr| #8#))))
                                                 (LETT #7# (CDR #7#)) (GO G190)
                                                 G191 (EXIT (NREVERSE #8#))))
                                           (QREFELT $ 50)))
                           (LETT |res| (SPADCALL |nrs| |nrs| (QREFELT $ 41)))
                           (LETT |n0| 1)
                           (SEQ (LETT |a| NIL) (LETT #6# |l|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |a| (CAR #6#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |off0| 0)
                                     (LETT |nr|
                                           (SPADCALL |dl| 1 (QREFELT $ 46)))
                                     (LETT |dl| (CDR |dl|))
                                     (LETT |n2|
                                           (SPADCALL (ELT $ 48) |dl| 1
                                                     (QREFELT $ 61)))
                                     (LETT |step0| (* |nr| |n2|))
                                     (SEQ (LETT |m| 1) (LETT #5# |n0|) G190
                                          (COND
                                           ((|greater_SI| |m| #5#) (GO G191)))
                                          (SEQ (LETT |off_r| (+ |off0| 1))
                                               (SEQ (LETT |i| 1)
                                                    (LETT #4# |nr|) G190
                                                    (COND
                                                     ((|greater_SI| |i| #4#)
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (SEQ (LETT |l| 1)
                                                           (LETT #3# |n2|) G190
                                                           (COND
                                                            ((|greater_SI| |l|
                                                                           #3#)
                                                             (GO G191)))
                                                           (SEQ
                                                            (LETT |ind_c|
                                                                  (+ |off0|
                                                                     |l|))
                                                            (SEQ (LETT |j| 1)
                                                                 (LETT #2#
                                                                       |nr|)
                                                                 G190
                                                                 (COND
                                                                  ((|greater_SI|
                                                                    |j| #2#)
                                                                   (GO G191)))
                                                                 (SEQ
                                                                  (LETT |vv|
                                                                        (SPADCALL
                                                                         (QAREF2O
                                                                          |res|
                                                                          |off_r|
                                                                          |ind_c|
                                                                          1 1)
                                                                         (QAREF2O
                                                                          |a|
                                                                          |i|
                                                                          |j| 1
                                                                          1)
                                                                         (QREFELT
                                                                          $
                                                                          62)))
                                                                  (QSETAREF2O
                                                                   |res|
                                                                   |off_r|
                                                                   |ind_c| |vv|
                                                                   1 1)
                                                                  (EXIT
                                                                   (LETT
                                                                    |ind_c|
                                                                    (+ |ind_c|
                                                                       |n2|))))
                                                                 (LETT |j|
                                                                       (|inc_SI|
                                                                        |j|))
                                                                 (GO G190) G191
                                                                 (EXIT NIL))
                                                            (EXIT
                                                             (LETT |off_r|
                                                                   (+ |off_r|
                                                                      1))))
                                                           (LETT |l|
                                                                 (|inc_SI|
                                                                  |l|))
                                                           (GO G190) G191
                                                           (EXIT NIL))))
                                                    (LETT |i| (|inc_SI| |i|))
                                                    (GO G190) G191 (EXIT NIL))
                                               (EXIT
                                                (LETT |off0|
                                                      (+ |off0| |step0|))))
                                          (LETT |m| (|inc_SI| |m|)) (GO G190)
                                          G191 (EXIT NIL))
                                     (EXIT (LETT |n0| (* |n0| |nr|))))
                                (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                           (EXIT |res|)))))))) 

(SDEFUN |MATCAT-;kroneckerSum;3S;16| ((|a| (S)) (|b| (S)) ($ (S)))
        (SPADCALL (LIST |a| |b|) (QREFELT $ 64))) 

(SDEFUN |MATCAT-;diagonalMatrix;LS;17| ((|list| (|List| S)) ($ (S)))
        (SPROG
         ((|loC| (|Integer|)) (|loR| (|Integer|)) (#1=#:G978 NIL) (|j| NIL)
          (#2=#:G979 NIL) (|l| NIL) (#3=#:G976 NIL) (|i| NIL) (#4=#:G977 NIL)
          (|k| NIL) (|hiC| #5=(|Integer|)) (|hiR| #5#) (#6=#:G975 NIL)
          (|mat| NIL) (|ans| (S)) (|cols| #7=(|NonNegativeInteger|))
          (|rows| #7#) (#8=#:G974 NIL))
         (SEQ (LETT |rows| 0) (LETT |cols| 0)
              (SEQ (LETT |mat| NIL) (LETT #8# |list|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |mat| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |rows| (+ |rows| (ANROWS |mat|)))
                        (EXIT (LETT |cols| (+ |cols| (ANCOLS |mat|)))))
                   (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
              (LETT |ans| (SPADCALL |rows| |cols| (QREFELT $ 41)))
              (LETT |loR| (PROGN |ans| 1)) (LETT |loC| (PROGN |ans| 1))
              (SEQ (LETT |mat| NIL) (LETT #6# |list|) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |mat| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |hiR| (- (+ |loR| (ANROWS |mat|)) 1))
                        (LETT |hiC| (- (+ |loC| (ANROWS |mat|)) 1))
                        (SEQ (LETT |k| (PROGN |mat| 1))
                             (LETT #4# (SPADCALL |mat| (QREFELT $ 18)))
                             (LETT |i| |loR|) (LETT #3# |hiR|) G190
                             (COND ((OR (> |i| #3#) (> |k| #4#)) (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |l| (PROGN |mat| 1))
                                    (LETT #2# (SPADCALL |mat| (QREFELT $ 20)))
                                    (LETT |j| |loC|) (LETT #1# |hiC|) G190
                                    (COND
                                     ((OR (> |j| #1#) (> |l| #2#)) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (QSETAREF2O |ans| |i| |j|
                                                  (QAREF2O |mat| |k| |l| 1 1) 1
                                                  1)))
                                    (LETT |j|
                                          (PROG1 (+ |j| 1)
                                            (LETT |l| (+ |l| 1))))
                                    (GO G190) G191 (EXIT NIL))))
                             (LETT |i| (PROG1 (+ |i| 1) (LETT |k| (+ |k| 1))))
                             (GO G190) G191 (EXIT NIL))
                        (LETT |loR| (+ |hiR| 1))
                        (EXIT (LETT |loC| (+ |hiC| 1))))
                   (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;zero?;SB;18| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G991 NIL) (#2=#:G993 NIL) (|j| NIL) (#3=#:G992 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| (PROGN |x| 0))
                 (LETT #3# (SPADCALL |x| (QREFELT $ 18))) G190
                 (COND ((> |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| (PROGN |x| 0))
                        (LETT #2# (SPADCALL |x| (QREFELT $ 20))) G190
                        (COND ((> |j| #2#) (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 22)) 0.0
                                      (QREFELT $ 25))
                            (PROGN (LETT #1# NIL) (GO #4=#:G990))))))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #4# (EXIT #1#)))) 

(SDEFUN |MATCAT-;scalarMatrix;NniRS;19|
        ((|n| (|NonNegativeInteger|)) (|r| (R)) ($ (S)))
        (SPROG
         ((#1=#:G998 NIL) (|i| NIL) (#2=#:G999 NIL) (|j| NIL) (|ans| (S)))
         (SEQ (LETT |ans| (SPADCALL |n| |n| (QREFELT $ 41)))
              (SEQ (LETT |j| (PROGN |ans| 0))
                   (LETT #2# (SPADCALL |ans| (QREFELT $ 20)))
                   (LETT |i| (PROGN |ans| 0))
                   (LETT #1# (SPADCALL |ans| (QREFELT $ 18))) G190
                   (COND ((OR (> |i| #1#) (> |j| #2#)) (GO G191)))
                   (SEQ (EXIT (SPADCALL |ans| |i| |j| |r| (QREFELT $ 33))))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;diagonalMatrix;LS;20| ((|l| (|List| R)) ($ (S)))
        (SPROG
         ((#1=#:G1004 NIL) (|i| NIL) (#2=#:G1005 NIL) (|j| NIL)
          (#3=#:G1006 NIL) (|r| NIL) (|ans| (S)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |l|))
              (LETT |ans| (SPADCALL |n| |n| (QREFELT $ 41)))
              (SEQ (LETT |r| NIL) (LETT #3# |l|) (LETT |j| (PROGN |ans| 0))
                   (LETT #2# (SPADCALL |ans| (QREFELT $ 20)))
                   (LETT |i| (PROGN |ans| 0))
                   (LETT #1# (SPADCALL |ans| (QREFELT $ 18))) G190
                   (COND
                    ((OR (> |i| #1#) (> |j| #2#) (ATOM #3#)
                         (PROGN (LETT |r| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (SPADCALL |ans| |i| |j| |r| (QREFELT $ 33))))
                   (LETT |i|
                         (PROG1 (+ |i| 1)
                           (LETT |j| (PROG1 (+ |j| 1) (LETT #3# (CDR #3#))))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;kronecker_prod1;SILL2NniUV;21|
        ((|res| (S)) (|k| (|Integer|))
         (|dl| (|List| (|List| (|NonNegativeInteger|)))) (|l| (|List| S))
         (|r_off| (|NonNegativeInteger|)) (|c_off| (|NonNegativeInteger|))
         (|mu| (|Union| R "one")) ($ (|Void|)))
        (SPROG
         ((|c_off1| (|NonNegativeInteger|)) (|mm| (R)) (|aij| (R))
          (#1=#:G1046 NIL) (|j| NIL) (#2=#:G1045 NIL) (|i| NIL)
          (|c_step| #3=(|NonNegativeInteger|)) (#4=#:G1044 NIL) (|rc| NIL)
          (#5=#:G1043 NIL) (|r_step| #3#) (#6=#:G1042 NIL) (#7=#:G1041 NIL)
          (|c_ind| (|NonNegativeInteger|)) (#8=#:G1040 NIL) (#9=#:G1039 NIL)
          (|m| (R)) (|a| (S)) (|nc| #10=(|NonNegativeInteger|)) (|nr| #10#)
          (|dp| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |dp| (|SPADfirst| |dl|))
              (LETT |nr| (SPADCALL |dp| 1 (QREFELT $ 46)))
              (LETT |nc| (SPADCALL |dp| 2 (QREFELT $ 46)))
              (LETT |a| (|SPADfirst| |l|))
              (EXIT
               (COND
                ((EQL |k| 1)
                 (COND
                  ((QEQCAR |mu| 1) (|error| "kronecker_prod1: impossible"))
                  (#11='T
                   (SEQ (LETT |m| (QCDR |mu|))
                        (EXIT
                         (SEQ (LETT |i| 1) (LETT #9# |nr|) G190
                              (COND ((|greater_SI| |i| #9#) (GO G191)))
                              (SEQ (LETT |r_off| (+ |r_off| 1))
                                   (LETT |c_ind| (+ |c_off| 1))
                                   (EXIT
                                    (SEQ (LETT |j| 1) (LETT #8# |nc|) G190
                                         (COND
                                          ((|greater_SI| |j| #8#) (GO G191)))
                                         (SEQ
                                          (SPADCALL |res| |r_off| |c_ind|
                                                    (|mul_DF| |m|
                                                              (SPADCALL |a| |i|
                                                                        |j|
                                                                        (QREFELT
                                                                         $
                                                                         22)))
                                                    (QREFELT $ 33))
                                          (EXIT (LETT |c_ind| (+ |c_ind| 1))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT NIL))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL)))))))
                (#11#
                 (SEQ (LETT |dl| (CDR |dl|)) (LETT |l| (CDR |l|))
                      (LETT |r_step|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #7# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #6# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #6#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #6#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #7#
                                                    (CONS
                                                     (SPADCALL |rc| 1
                                                               (QREFELT $ 46))
                                                     #7#))))
                                            (LETT #6# (CDR #6#)) (GO G190) G191
                                            (EXIT (NREVERSE #7#))))
                                      (QREFELT $ 50)))
                      (LETT |c_step|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #4# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #4#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #4#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |rc| 2
                                                               (QREFELT $ 46))
                                                     #5#))))
                                            (LETT #4# (CDR #4#)) (GO G190) G191
                                            (EXIT (NREVERSE #5#))))
                                      (QREFELT $ 50)))
                      (EXIT
                       (SEQ (LETT |i| 1) (LETT #2# |nr|) G190
                            (COND ((|greater_SI| |i| #2#) (GO G191)))
                            (SEQ (LETT |c_off1| |c_off|)
                                 (SEQ (LETT |j| 1) (LETT #1# |nc|) G190
                                      (COND ((|greater_SI| |j| #1#) (GO G191)))
                                      (SEQ
                                       (LETT |aij|
                                             (SPADCALL |a| |i| |j|
                                                       (QREFELT $ 22)))
                                       (LETT |mm|
                                             (COND ((QEQCAR |mu| 1) |aij|)
                                                   ('T
                                                    (|mul_DF| (QCDR |mu|)
                                                              |aij|))))
                                       (SPADCALL |res| (- |k| 1) |dl| |l|
                                                 |r_off| |c_off1| (CONS 0 |mm|)
                                                 (QREFELT $ 55))
                                       (EXIT
                                        (LETT |c_off1| (+ |c_off1| |c_step|))))
                                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT (LETT |r_off| (+ |r_off| |r_step|))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL)))))))))) 

(SDEFUN |MATCAT-;kroneckerProduct;LS;22| ((|l| (|List| S)) ($ (S)))
        (SPROG
         ((|res| (S)) (|nc| #1=(|NonNegativeInteger|)) (#2=#:G1077 NIL)
          (|rc| NIL) (#3=#:G1076 NIL) (|nr| #1#) (#4=#:G1075 NIL)
          (#5=#:G1074 NIL) (|dl| (|List| (|List| (|NonNegativeInteger|))))
          (|k| (|NonNegativeInteger|)))
         (SEQ (LETT |k| (LENGTH |l|))
              (EXIT
               (COND
                ((EQL |k| 0)
                 (COND
                  ((QEQCAR (QREFELT $ 39) 0)
                   (SPADCALL 1 1 (QCDR (QREFELT $ 39)) (QREFELT $ 30)))
                  (#6='T (|error| "need 1"))))
                ((EQL |k| 1) (SPADCALL (|SPADfirst| |l|) (QREFELT $ 57)))
                (#6#
                 (SEQ (LETT |dl| (|MATCAT-;get_dims| |l| $))
                      (LETT |nr|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #4# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #4#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #4#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |rc| 1
                                                               (QREFELT $ 46))
                                                     #5#))))
                                            (LETT #4# (CDR #4#)) (GO G190) G191
                                            (EXIT (NREVERSE #5#))))
                                      (QREFELT $ 50)))
                      (LETT |nc|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #3# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #2# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #2#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #2#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #3#
                                                    (CONS
                                                     (SPADCALL |rc| 2
                                                               (QREFELT $ 46))
                                                     #3#))))
                                            (LETT #2# (CDR #2#)) (GO G190) G191
                                            (EXIT (NREVERSE #3#))))
                                      (QREFELT $ 50)))
                      (LETT |res| (SPADCALL |nr| |nc| (QREFELT $ 41)))
                      (SPADCALL |res| |k| |dl| |l| 0 0 (CONS 1 "one")
                                (QREFELT $ 55))
                      (EXIT |res|)))))))) 

(SDEFUN |MATCAT-;kroneckerProduct;3S;23| ((|a| (S)) (|b| (S)) ($ (S)))
        (SPADCALL (LIST |a| |b|) (QREFELT $ 59))) 

(SDEFUN |MATCAT-;kroneckerSum;LS;24| ((|l| (|List| S)) ($ (S)))
        (SPROG
         ((|n0| (|Integer|)) (|off0| (|NonNegativeInteger|))
          (|off_r| #1=(|NonNegativeInteger|)) (|ind_c| #1#) (|vv| (R))
          (#2=#:G1124 NIL) (|j| NIL) (#3=#:G1123 NIL) (#4=#:G1122 NIL)
          (|i| NIL) (#5=#:G1121 NIL) (|m| NIL) (|step0| (|NonNegativeInteger|))
          (|n2| (|NonNegativeInteger|)) (|dl| (|List| (|NonNegativeInteger|)))
          (|nr| (|NonNegativeInteger|)) (#6=#:G1120 NIL) (|a| NIL) (|res| (S))
          (|nrs| (|NonNegativeInteger|)) (#7=#:G1119 NIL) (#8=#:G1118 NIL)
          (|nc| (|NonNegativeInteger|)) (#9=#:G1117 NIL)
          (|k| (|NonNegativeInteger|)))
         (SEQ (LETT |k| (LENGTH |l|))
              (EXIT
               (COND ((EQL |k| 0) (SPADCALL 1 1 (QREFELT $ 41)))
                     ((EQL |k| 1) (SPADCALL (|SPADfirst| |l|) (QREFELT $ 57)))
                     ('T
                      (SEQ (LETT |dl| NIL)
                           (SEQ (LETT |a| NIL) (LETT #9# |l|) G190
                                (COND
                                 ((OR (ATOM #9#)
                                      (PROGN (LETT |a| (CAR #9#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |nr| (DANROWS |a|))
                                     (LETT |nc| (DANCOLS |a|))
                                     (EXIT
                                      (COND
                                       ((SPADCALL |nr| |nc| (QREFELT $ 32))
                                        (|error|
                                         "kroneckerSum: nonsquare matrix"))
                                       ('T (LETT |dl| (CONS |nr| |dl|))))))
                                (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                           (LETT |dl| (NREVERSE |dl|))
                           (LETT |nrs|
                                 (SPADCALL (ELT $ 48)
                                           (PROGN
                                            (LETT #8# NIL)
                                            (SEQ (LETT #7# |dl|) G190
                                                 (COND
                                                  ((OR (ATOM #7#)
                                                       (PROGN
                                                        (LETT |nr| (CAR #7#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #8# (CONS |nr| #8#))))
                                                 (LETT #7# (CDR #7#)) (GO G190)
                                                 G191 (EXIT (NREVERSE #8#))))
                                           (QREFELT $ 50)))
                           (LETT |res| (SPADCALL |nrs| |nrs| (QREFELT $ 41)))
                           (LETT |n0| 1)
                           (SEQ (LETT |a| NIL) (LETT #6# |l|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |a| (CAR #6#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |off0| 0)
                                     (LETT |nr|
                                           (SPADCALL |dl| 1 (QREFELT $ 46)))
                                     (LETT |dl| (CDR |dl|))
                                     (LETT |n2|
                                           (SPADCALL (ELT $ 48) |dl| 1
                                                     (QREFELT $ 61)))
                                     (LETT |step0| (* |nr| |n2|))
                                     (SEQ (LETT |m| 1) (LETT #5# |n0|) G190
                                          (COND
                                           ((|greater_SI| |m| #5#) (GO G191)))
                                          (SEQ (LETT |off_r| (+ |off0| 1))
                                               (SEQ (LETT |i| 1)
                                                    (LETT #4# |nr|) G190
                                                    (COND
                                                     ((|greater_SI| |i| #4#)
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (SEQ (LETT |l| 1)
                                                           (LETT #3# |n2|) G190
                                                           (COND
                                                            ((|greater_SI| |l|
                                                                           #3#)
                                                             (GO G191)))
                                                           (SEQ
                                                            (LETT |ind_c|
                                                                  (+ |off0|
                                                                     |l|))
                                                            (SEQ (LETT |j| 1)
                                                                 (LETT #2#
                                                                       |nr|)
                                                                 G190
                                                                 (COND
                                                                  ((|greater_SI|
                                                                    |j| #2#)
                                                                   (GO G191)))
                                                                 (SEQ
                                                                  (LETT |vv|
                                                                        (|add_DF|
                                                                         (SPADCALL
                                                                          |res|
                                                                          |off_r|
                                                                          |ind_c|
                                                                          (QREFELT
                                                                           $
                                                                           22))
                                                                         (SPADCALL
                                                                          |a|
                                                                          |i|
                                                                          |j|
                                                                          (QREFELT
                                                                           $
                                                                           22))))
                                                                  (SPADCALL
                                                                   |res|
                                                                   |off_r|
                                                                   |ind_c| |vv|
                                                                   (QREFELT $
                                                                            33))
                                                                  (EXIT
                                                                   (LETT
                                                                    |ind_c|
                                                                    (+ |ind_c|
                                                                       |n2|))))
                                                                 (LETT |j|
                                                                       (|inc_SI|
                                                                        |j|))
                                                                 (GO G190) G191
                                                                 (EXIT NIL))
                                                            (EXIT
                                                             (LETT |off_r|
                                                                   (+ |off_r|
                                                                      1))))
                                                           (LETT |l|
                                                                 (|inc_SI|
                                                                  |l|))
                                                           (GO G190) G191
                                                           (EXIT NIL))))
                                                    (LETT |i| (|inc_SI| |i|))
                                                    (GO G190) G191 (EXIT NIL))
                                               (EXIT
                                                (LETT |off0|
                                                      (+ |off0| |step0|))))
                                          (LETT |m| (|inc_SI| |m|)) (GO G190)
                                          G191 (EXIT NIL))
                                     (EXIT (LETT |n0| (* |n0| |nr|))))
                                (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                           (EXIT |res|)))))))) 

(SDEFUN |MATCAT-;kroneckerSum;3S;25| ((|a| (S)) (|b| (S)) ($ (S)))
        (SPADCALL (LIST |a| |b|) (QREFELT $ 64))) 

(SDEFUN |MATCAT-;diagonalMatrix;LS;26| ((|list| (|List| S)) ($ (S)))
        (SPROG
         ((|loC| (|Integer|)) (|loR| (|Integer|)) (#1=#:G1142 NIL) (|j| NIL)
          (#2=#:G1143 NIL) (|l| NIL) (#3=#:G1140 NIL) (|i| NIL)
          (#4=#:G1141 NIL) (|k| NIL) (|hiC| #5=(|Integer|)) (|hiR| #5#)
          (#6=#:G1139 NIL) (|mat| NIL) (|ans| (S))
          (|cols| #7=(|NonNegativeInteger|)) (|rows| #7#) (#8=#:G1138 NIL))
         (SEQ (LETT |rows| 0) (LETT |cols| 0)
              (SEQ (LETT |mat| NIL) (LETT #8# |list|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |mat| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |rows| (+ |rows| (DANROWS |mat|)))
                        (EXIT (LETT |cols| (+ |cols| (DANCOLS |mat|)))))
                   (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
              (LETT |ans| (SPADCALL |rows| |cols| (QREFELT $ 41)))
              (LETT |loR| (PROGN |ans| 0)) (LETT |loC| (PROGN |ans| 0))
              (SEQ (LETT |mat| NIL) (LETT #6# |list|) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |mat| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |hiR| (- (+ |loR| (DANROWS |mat|)) 1))
                        (LETT |hiC| (- (+ |loC| (DANROWS |mat|)) 1))
                        (SEQ (LETT |k| (PROGN |mat| 0))
                             (LETT #4# (SPADCALL |mat| (QREFELT $ 18)))
                             (LETT |i| |loR|) (LETT #3# |hiR|) G190
                             (COND ((OR (> |i| #3#) (> |k| #4#)) (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |l| (PROGN |mat| 0))
                                    (LETT #2# (SPADCALL |mat| (QREFELT $ 20)))
                                    (LETT |j| |loC|) (LETT #1# |hiC|) G190
                                    (COND
                                     ((OR (> |j| #1#) (> |l| #2#)) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (SPADCALL |ans| |i| |j|
                                                (SPADCALL |mat| |k| |l|
                                                          (QREFELT $ 22))
                                                (QREFELT $ 33))))
                                    (LETT |j|
                                          (PROG1 (+ |j| 1)
                                            (LETT |l| (+ |l| 1))))
                                    (GO G190) G191 (EXIT NIL))))
                             (LETT |i| (PROG1 (+ |i| 1) (LETT |k| (+ |k| 1))))
                             (GO G190) G191 (EXIT NIL))
                        (LETT |loR| (+ |hiR| 1))
                        (EXIT (LETT |loC| (+ |hiC| 1))))
                   (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;zero?;SB;27| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1151 NIL) (#2=#:G1153 NIL) (|j| NIL) (#3=#:G1152 NIL)
          (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| (PROGN |x| 0))
                 (LETT #3# (SPADCALL |x| (QREFELT $ 18))) G190
                 (COND ((> |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| (PROGN |x| 0))
                        (LETT #2# (SPADCALL |x| (QREFELT $ 20))) G190
                        (COND ((> |j| #2#) (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 22))
                                      (|spadConstant| $ 29) (QREFELT $ 25))
                            (PROGN (LETT #1# NIL) (GO #4=#:G1150))))))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #4# (EXIT #1#)))) 

(SDEFUN |MATCAT-;scalarMatrix;NniRS;28|
        ((|n| (|NonNegativeInteger|)) (|r| (R)) ($ (S)))
        (SPROG
         ((#1=#:G1158 NIL) (|i| NIL) (#2=#:G1159 NIL) (|j| NIL) (|ans| (S)))
         (SEQ (LETT |ans| (SPADCALL |n| |n| (QREFELT $ 41)))
              (SEQ (LETT |j| (PROGN |ans| 0))
                   (LETT #2# (SPADCALL |ans| (QREFELT $ 20)))
                   (LETT |i| (PROGN |ans| 0))
                   (LETT #1# (SPADCALL |ans| (QREFELT $ 18))) G190
                   (COND ((OR (> |i| #1#) (> |j| #2#)) (GO G191)))
                   (SEQ (EXIT (SPADCALL |ans| |i| |j| |r| (QREFELT $ 33))))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;diagonalMatrix;LS;29| ((|l| (|List| R)) ($ (S)))
        (SPROG
         ((#1=#:G1164 NIL) (|i| NIL) (#2=#:G1165 NIL) (|j| NIL)
          (#3=#:G1166 NIL) (|r| NIL) (|ans| (S)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |l|))
              (LETT |ans| (SPADCALL |n| |n| (QREFELT $ 41)))
              (SEQ (LETT |r| NIL) (LETT #3# |l|) (LETT |j| (PROGN |ans| 0))
                   (LETT #2# (SPADCALL |ans| (QREFELT $ 20)))
                   (LETT |i| (PROGN |ans| 0))
                   (LETT #1# (SPADCALL |ans| (QREFELT $ 18))) G190
                   (COND
                    ((OR (> |i| #1#) (> |j| #2#) (ATOM #3#)
                         (PROGN (LETT |r| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (SPADCALL |ans| |i| |j| |r| (QREFELT $ 33))))
                   (LETT |i|
                         (PROG1 (+ |i| 1)
                           (LETT |j| (PROG1 (+ |j| 1) (LETT #3# (CDR #3#))))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;kronecker_prod1;SILL2NniUV;30|
        ((|res| (S)) (|k| (|Integer|))
         (|dl| (|List| (|List| (|NonNegativeInteger|)))) (|l| (|List| S))
         (|r_off| (|NonNegativeInteger|)) (|c_off| (|NonNegativeInteger|))
         (|mu| (|Union| R "one")) ($ (|Void|)))
        (SPROG
         ((|c_off1| (|NonNegativeInteger|)) (|mm| (R)) (|aij| (R))
          (#1=#:G1206 NIL) (|j| NIL) (#2=#:G1205 NIL) (|i| NIL)
          (|c_step| #3=(|NonNegativeInteger|)) (#4=#:G1204 NIL) (|rc| NIL)
          (#5=#:G1203 NIL) (|r_step| #3#) (#6=#:G1202 NIL) (#7=#:G1201 NIL)
          (|c_ind| (|NonNegativeInteger|)) (#8=#:G1200 NIL) (#9=#:G1199 NIL)
          (|m| (R)) (|a| (S)) (|nc| #10=(|NonNegativeInteger|)) (|nr| #10#)
          (|dp| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |dp| (|SPADfirst| |dl|))
              (LETT |nr| (SPADCALL |dp| 1 (QREFELT $ 46)))
              (LETT |nc| (SPADCALL |dp| 2 (QREFELT $ 46)))
              (LETT |a| (|SPADfirst| |l|))
              (EXIT
               (COND
                ((EQL |k| 1)
                 (COND
                  ((QEQCAR |mu| 1) (|error| "kronecker_prod1: impossible"))
                  (#11='T
                   (SEQ (LETT |m| (QCDR |mu|))
                        (EXIT
                         (SEQ (LETT |i| 1) (LETT #9# |nr|) G190
                              (COND ((|greater_SI| |i| #9#) (GO G191)))
                              (SEQ (LETT |r_off| (+ |r_off| 1))
                                   (LETT |c_ind| (+ |c_off| 1))
                                   (EXIT
                                    (SEQ (LETT |j| 1) (LETT #8# |nc|) G190
                                         (COND
                                          ((|greater_SI| |j| #8#) (GO G191)))
                                         (SEQ
                                          (SPADCALL |res| |r_off| |c_ind|
                                                    (SPADCALL |m|
                                                              (SPADCALL |a| |i|
                                                                        |j|
                                                                        (QREFELT
                                                                         $ 22))
                                                              (QREFELT $ 47))
                                                    (QREFELT $ 33))
                                          (EXIT (LETT |c_ind| (+ |c_ind| 1))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT NIL))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL)))))))
                (#11#
                 (SEQ (LETT |dl| (CDR |dl|)) (LETT |l| (CDR |l|))
                      (LETT |r_step|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #7# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #6# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #6#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #6#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #7#
                                                    (CONS
                                                     (SPADCALL |rc| 1
                                                               (QREFELT $ 46))
                                                     #7#))))
                                            (LETT #6# (CDR #6#)) (GO G190) G191
                                            (EXIT (NREVERSE #7#))))
                                      (QREFELT $ 50)))
                      (LETT |c_step|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #4# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #4#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #4#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |rc| 2
                                                               (QREFELT $ 46))
                                                     #5#))))
                                            (LETT #4# (CDR #4#)) (GO G190) G191
                                            (EXIT (NREVERSE #5#))))
                                      (QREFELT $ 50)))
                      (EXIT
                       (SEQ (LETT |i| 1) (LETT #2# |nr|) G190
                            (COND ((|greater_SI| |i| #2#) (GO G191)))
                            (SEQ (LETT |c_off1| |c_off|)
                                 (SEQ (LETT |j| 1) (LETT #1# |nc|) G190
                                      (COND ((|greater_SI| |j| #1#) (GO G191)))
                                      (SEQ
                                       (LETT |aij|
                                             (SPADCALL |a| |i| |j|
                                                       (QREFELT $ 22)))
                                       (LETT |mm|
                                             (COND ((QEQCAR |mu| 1) |aij|)
                                                   ('T
                                                    (SPADCALL (QCDR |mu|) |aij|
                                                              (QREFELT $
                                                                       47)))))
                                       (SPADCALL |res| (- |k| 1) |dl| |l|
                                                 |r_off| |c_off1| (CONS 0 |mm|)
                                                 (QREFELT $ 55))
                                       (EXIT
                                        (LETT |c_off1| (+ |c_off1| |c_step|))))
                                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT (LETT |r_off| (+ |r_off| |r_step|))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL)))))))))) 

(SDEFUN |MATCAT-;kroneckerProduct;LS;31| ((|l| (|List| S)) ($ (S)))
        (SPROG
         ((|res| (S)) (|nc| #1=(|NonNegativeInteger|)) (#2=#:G1237 NIL)
          (|rc| NIL) (#3=#:G1236 NIL) (|nr| #1#) (#4=#:G1235 NIL)
          (#5=#:G1234 NIL) (|dl| (|List| (|List| (|NonNegativeInteger|))))
          (|k| (|NonNegativeInteger|)))
         (SEQ (LETT |k| (LENGTH |l|))
              (EXIT
               (COND
                ((EQL |k| 0)
                 (COND
                  ((QEQCAR (QREFELT $ 39) 0)
                   (SPADCALL 1 1 (QCDR (QREFELT $ 39)) (QREFELT $ 30)))
                  (#6='T (|error| "need 1"))))
                ((EQL |k| 1) (SPADCALL (|SPADfirst| |l|) (QREFELT $ 57)))
                (#6#
                 (SEQ (LETT |dl| (|MATCAT-;get_dims| |l| $))
                      (LETT |nr|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #4# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #4#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #4#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |rc| 1
                                                               (QREFELT $ 46))
                                                     #5#))))
                                            (LETT #4# (CDR #4#)) (GO G190) G191
                                            (EXIT (NREVERSE #5#))))
                                      (QREFELT $ 50)))
                      (LETT |nc|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #3# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #2# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #2#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #2#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #3#
                                                    (CONS
                                                     (SPADCALL |rc| 2
                                                               (QREFELT $ 46))
                                                     #3#))))
                                            (LETT #2# (CDR #2#)) (GO G190) G191
                                            (EXIT (NREVERSE #3#))))
                                      (QREFELT $ 50)))
                      (LETT |res| (SPADCALL |nr| |nc| (QREFELT $ 41)))
                      (SPADCALL |res| |k| |dl| |l| 0 0 (CONS 1 "one")
                                (QREFELT $ 55))
                      (EXIT |res|)))))))) 

(SDEFUN |MATCAT-;kroneckerProduct;3S;32| ((|a| (S)) (|b| (S)) ($ (S)))
        (SPADCALL (LIST |a| |b|) (QREFELT $ 59))) 

(SDEFUN |MATCAT-;kroneckerSum;LS;33| ((|l| (|List| S)) ($ (S)))
        (SPROG
         ((|n0| (|Integer|)) (|off0| (|NonNegativeInteger|))
          (|off_r| #1=(|NonNegativeInteger|)) (|ind_c| #1#) (|vv| (R))
          (#2=#:G1284 NIL) (|j| NIL) (#3=#:G1283 NIL) (#4=#:G1282 NIL)
          (|i| NIL) (#5=#:G1281 NIL) (|m| NIL) (|step0| (|NonNegativeInteger|))
          (|n2| (|NonNegativeInteger|)) (|dl| (|List| (|NonNegativeInteger|)))
          (|nr| (|NonNegativeInteger|)) (#6=#:G1280 NIL) (|a| NIL) (|res| (S))
          (|nrs| (|NonNegativeInteger|)) (#7=#:G1279 NIL) (#8=#:G1278 NIL)
          (|nc| (|NonNegativeInteger|)) (#9=#:G1277 NIL)
          (|k| (|NonNegativeInteger|)))
         (SEQ (LETT |k| (LENGTH |l|))
              (EXIT
               (COND ((EQL |k| 0) (SPADCALL 1 1 (QREFELT $ 41)))
                     ((EQL |k| 1) (SPADCALL (|SPADfirst| |l|) (QREFELT $ 57)))
                     ('T
                      (SEQ (LETT |dl| NIL)
                           (SEQ (LETT |a| NIL) (LETT #9# |l|) G190
                                (COND
                                 ((OR (ATOM #9#)
                                      (PROGN (LETT |a| (CAR #9#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |nr| (DANROWS |a|))
                                     (LETT |nc| (DANCOLS |a|))
                                     (EXIT
                                      (COND
                                       ((SPADCALL |nr| |nc| (QREFELT $ 32))
                                        (|error|
                                         "kroneckerSum: nonsquare matrix"))
                                       ('T (LETT |dl| (CONS |nr| |dl|))))))
                                (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                           (LETT |dl| (NREVERSE |dl|))
                           (LETT |nrs|
                                 (SPADCALL (ELT $ 48)
                                           (PROGN
                                            (LETT #8# NIL)
                                            (SEQ (LETT #7# |dl|) G190
                                                 (COND
                                                  ((OR (ATOM #7#)
                                                       (PROGN
                                                        (LETT |nr| (CAR #7#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #8# (CONS |nr| #8#))))
                                                 (LETT #7# (CDR #7#)) (GO G190)
                                                 G191 (EXIT (NREVERSE #8#))))
                                           (QREFELT $ 50)))
                           (LETT |res| (SPADCALL |nrs| |nrs| (QREFELT $ 41)))
                           (LETT |n0| 1)
                           (SEQ (LETT |a| NIL) (LETT #6# |l|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |a| (CAR #6#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |off0| 0)
                                     (LETT |nr|
                                           (SPADCALL |dl| 1 (QREFELT $ 46)))
                                     (LETT |dl| (CDR |dl|))
                                     (LETT |n2|
                                           (SPADCALL (ELT $ 48) |dl| 1
                                                     (QREFELT $ 61)))
                                     (LETT |step0| (* |nr| |n2|))
                                     (SEQ (LETT |m| 1) (LETT #5# |n0|) G190
                                          (COND
                                           ((|greater_SI| |m| #5#) (GO G191)))
                                          (SEQ (LETT |off_r| (+ |off0| 1))
                                               (SEQ (LETT |i| 1)
                                                    (LETT #4# |nr|) G190
                                                    (COND
                                                     ((|greater_SI| |i| #4#)
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (SEQ (LETT |l| 1)
                                                           (LETT #3# |n2|) G190
                                                           (COND
                                                            ((|greater_SI| |l|
                                                                           #3#)
                                                             (GO G191)))
                                                           (SEQ
                                                            (LETT |ind_c|
                                                                  (+ |off0|
                                                                     |l|))
                                                            (SEQ (LETT |j| 1)
                                                                 (LETT #2#
                                                                       |nr|)
                                                                 G190
                                                                 (COND
                                                                  ((|greater_SI|
                                                                    |j| #2#)
                                                                   (GO G191)))
                                                                 (SEQ
                                                                  (LETT |vv|
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          |res|
                                                                          |off_r|
                                                                          |ind_c|
                                                                          (QREFELT
                                                                           $
                                                                           22))
                                                                         (SPADCALL
                                                                          |a|
                                                                          |i|
                                                                          |j|
                                                                          (QREFELT
                                                                           $
                                                                           22))
                                                                         (QREFELT
                                                                          $
                                                                          62)))
                                                                  (SPADCALL
                                                                   |res|
                                                                   |off_r|
                                                                   |ind_c| |vv|
                                                                   (QREFELT $
                                                                            33))
                                                                  (EXIT
                                                                   (LETT
                                                                    |ind_c|
                                                                    (+ |ind_c|
                                                                       |n2|))))
                                                                 (LETT |j|
                                                                       (|inc_SI|
                                                                        |j|))
                                                                 (GO G190) G191
                                                                 (EXIT NIL))
                                                            (EXIT
                                                             (LETT |off_r|
                                                                   (+ |off_r|
                                                                      1))))
                                                           (LETT |l|
                                                                 (|inc_SI|
                                                                  |l|))
                                                           (GO G190) G191
                                                           (EXIT NIL))))
                                                    (LETT |i| (|inc_SI| |i|))
                                                    (GO G190) G191 (EXIT NIL))
                                               (EXIT
                                                (LETT |off0|
                                                      (+ |off0| |step0|))))
                                          (LETT |m| (|inc_SI| |m|)) (GO G190)
                                          G191 (EXIT NIL))
                                     (EXIT (LETT |n0| (* |n0| |nr|))))
                                (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                           (EXIT |res|)))))))) 

(SDEFUN |MATCAT-;kroneckerSum;3S;34| ((|a| (S)) (|b| (S)) ($ (S)))
        (SPADCALL (LIST |a| |b|) (QREFELT $ 64))) 

(SDEFUN |MATCAT-;diagonalMatrix;LS;35| ((|list| (|List| S)) ($ (S)))
        (SPROG
         ((|loC| (|Integer|)) (|loR| (|Integer|)) (#1=#:G1302 NIL) (|j| NIL)
          (#2=#:G1303 NIL) (|l| NIL) (#3=#:G1300 NIL) (|i| NIL)
          (#4=#:G1301 NIL) (|k| NIL) (|hiC| #5=(|Integer|)) (|hiR| #5#)
          (#6=#:G1299 NIL) (|mat| NIL) (|ans| (S))
          (|cols| #7=(|NonNegativeInteger|)) (|rows| #7#) (#8=#:G1298 NIL))
         (SEQ (LETT |rows| 0) (LETT |cols| 0)
              (SEQ (LETT |mat| NIL) (LETT #8# |list|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |mat| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |rows| (+ |rows| (DANROWS |mat|)))
                        (EXIT (LETT |cols| (+ |cols| (DANCOLS |mat|)))))
                   (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
              (LETT |ans| (SPADCALL |rows| |cols| (QREFELT $ 41)))
              (LETT |loR| (PROGN |ans| 0)) (LETT |loC| (PROGN |ans| 0))
              (SEQ (LETT |mat| NIL) (LETT #6# |list|) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |mat| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |hiR| (- (+ |loR| (DANROWS |mat|)) 1))
                        (LETT |hiC| (- (+ |loC| (DANROWS |mat|)) 1))
                        (SEQ (LETT |k| (PROGN |mat| 0))
                             (LETT #4# (SPADCALL |mat| (QREFELT $ 18)))
                             (LETT |i| |loR|) (LETT #3# |hiR|) G190
                             (COND ((OR (> |i| #3#) (> |k| #4#)) (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |l| (PROGN |mat| 0))
                                    (LETT #2# (SPADCALL |mat| (QREFELT $ 20)))
                                    (LETT |j| |loC|) (LETT #1# |hiC|) G190
                                    (COND
                                     ((OR (> |j| #1#) (> |l| #2#)) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (SPADCALL |ans| |i| |j|
                                                (SPADCALL |mat| |k| |l|
                                                          (QREFELT $ 22))
                                                (QREFELT $ 33))))
                                    (LETT |j|
                                          (PROG1 (+ |j| 1)
                                            (LETT |l| (+ |l| 1))))
                                    (GO G190) G191 (EXIT NIL))))
                             (LETT |i| (PROG1 (+ |i| 1) (LETT |k| (+ |k| 1))))
                             (GO G190) G191 (EXIT NIL))
                        (LETT |loR| (+ |hiR| 1))
                        (EXIT (LETT |loC| (+ |hiC| 1))))
                   (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;zero?;SB;36| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1311 NIL) (#2=#:G1313 NIL) (|j| NIL) (#3=#:G1312 NIL)
          (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                 (LETT #3# (SPADCALL |x| (QREFELT $ 18))) G190
                 (COND ((> |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 19)))
                        (LETT #2# (SPADCALL |x| (QREFELT $ 20))) G190
                        (COND ((> |j| #2#) (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 22))
                                      (|spadConstant| $ 29) (QREFELT $ 25))
                            (PROGN (LETT #1# NIL) (GO #4=#:G1310))))))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #4# (EXIT #1#)))) 

(SDEFUN |MATCAT-;scalarMatrix;NniRS;37|
        ((|n| (|NonNegativeInteger|)) (|r| (R)) ($ (S)))
        (SPROG
         ((#1=#:G1318 NIL) (|i| NIL) (#2=#:G1319 NIL) (|j| NIL) (|ans| (S)))
         (SEQ (LETT |ans| (SPADCALL |n| |n| (QREFELT $ 41)))
              (SEQ (LETT |j| (SPADCALL |ans| (QREFELT $ 19)))
                   (LETT #2# (SPADCALL |ans| (QREFELT $ 20)))
                   (LETT |i| (SPADCALL |ans| (QREFELT $ 17)))
                   (LETT #1# (SPADCALL |ans| (QREFELT $ 18))) G190
                   (COND ((OR (> |i| #1#) (> |j| #2#)) (GO G191)))
                   (SEQ (EXIT (SPADCALL |ans| |i| |j| |r| (QREFELT $ 33))))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;diagonalMatrix;LS;38| ((|l| (|List| R)) ($ (S)))
        (SPROG
         ((#1=#:G1324 NIL) (|i| NIL) (#2=#:G1325 NIL) (|j| NIL)
          (#3=#:G1326 NIL) (|r| NIL) (|ans| (S)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |l|))
              (LETT |ans| (SPADCALL |n| |n| (QREFELT $ 41)))
              (SEQ (LETT |r| NIL) (LETT #3# |l|)
                   (LETT |j| (SPADCALL |ans| (QREFELT $ 19)))
                   (LETT #2# (SPADCALL |ans| (QREFELT $ 20)))
                   (LETT |i| (SPADCALL |ans| (QREFELT $ 17)))
                   (LETT #1# (SPADCALL |ans| (QREFELT $ 18))) G190
                   (COND
                    ((OR (> |i| #1#) (> |j| #2#) (ATOM #3#)
                         (PROGN (LETT |r| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (SPADCALL |ans| |i| |j| |r| (QREFELT $ 33))))
                   (LETT |i|
                         (PROG1 (+ |i| 1)
                           (LETT |j| (PROG1 (+ |j| 1) (LETT #3# (CDR #3#))))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;kronecker_prod1;SILL2NniUV;39|
        ((|res| (S)) (|k| (|Integer|))
         (|dl| (|List| (|List| (|NonNegativeInteger|)))) (|l| (|List| S))
         (|r_off| (|NonNegativeInteger|)) (|c_off| (|NonNegativeInteger|))
         (|mu| (|Union| R "one")) ($ (|Void|)))
        (SPROG
         ((|c_off1| (|NonNegativeInteger|)) (|mm| (R)) (|aij| (R))
          (#1=#:G1366 NIL) (|j| NIL) (#2=#:G1365 NIL) (|i| NIL)
          (|c_step| #3=(|NonNegativeInteger|)) (#4=#:G1364 NIL) (|rc| NIL)
          (#5=#:G1363 NIL) (|r_step| #3#) (#6=#:G1362 NIL) (#7=#:G1361 NIL)
          (|c_ind| (|NonNegativeInteger|)) (#8=#:G1360 NIL) (#9=#:G1359 NIL)
          (|m| (R)) (|a| (S)) (|nc| #10=(|NonNegativeInteger|)) (|nr| #10#)
          (|dp| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |dp| (|SPADfirst| |dl|))
              (LETT |nr| (SPADCALL |dp| 1 (QREFELT $ 46)))
              (LETT |nc| (SPADCALL |dp| 2 (QREFELT $ 46)))
              (LETT |a| (|SPADfirst| |l|))
              (EXIT
               (COND
                ((EQL |k| 1)
                 (COND
                  ((QEQCAR |mu| 1) (|error| "kronecker_prod1: impossible"))
                  (#11='T
                   (SEQ (LETT |m| (QCDR |mu|))
                        (EXIT
                         (SEQ (LETT |i| 1) (LETT #9# |nr|) G190
                              (COND ((|greater_SI| |i| #9#) (GO G191)))
                              (SEQ (LETT |r_off| (+ |r_off| 1))
                                   (LETT |c_ind| (+ |c_off| 1))
                                   (EXIT
                                    (SEQ (LETT |j| 1) (LETT #8# |nc|) G190
                                         (COND
                                          ((|greater_SI| |j| #8#) (GO G191)))
                                         (SEQ
                                          (SPADCALL |res| |r_off| |c_ind|
                                                    (SPADCALL |m|
                                                              (SPADCALL |a| |i|
                                                                        |j|
                                                                        (QREFELT
                                                                         $ 22))
                                                              (QREFELT $ 47))
                                                    (QREFELT $ 33))
                                          (EXIT (LETT |c_ind| (+ |c_ind| 1))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT NIL))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL)))))))
                (#11#
                 (SEQ (LETT |dl| (CDR |dl|)) (LETT |l| (CDR |l|))
                      (LETT |r_step|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #7# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #6# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #6#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #6#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #7#
                                                    (CONS
                                                     (SPADCALL |rc| 1
                                                               (QREFELT $ 46))
                                                     #7#))))
                                            (LETT #6# (CDR #6#)) (GO G190) G191
                                            (EXIT (NREVERSE #7#))))
                                      (QREFELT $ 50)))
                      (LETT |c_step|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #4# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #4#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #4#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |rc| 2
                                                               (QREFELT $ 46))
                                                     #5#))))
                                            (LETT #4# (CDR #4#)) (GO G190) G191
                                            (EXIT (NREVERSE #5#))))
                                      (QREFELT $ 50)))
                      (EXIT
                       (SEQ (LETT |i| 1) (LETT #2# |nr|) G190
                            (COND ((|greater_SI| |i| #2#) (GO G191)))
                            (SEQ (LETT |c_off1| |c_off|)
                                 (SEQ (LETT |j| 1) (LETT #1# |nc|) G190
                                      (COND ((|greater_SI| |j| #1#) (GO G191)))
                                      (SEQ
                                       (LETT |aij|
                                             (SPADCALL |a| |i| |j|
                                                       (QREFELT $ 22)))
                                       (LETT |mm|
                                             (COND ((QEQCAR |mu| 1) |aij|)
                                                   ('T
                                                    (SPADCALL (QCDR |mu|) |aij|
                                                              (QREFELT $
                                                                       47)))))
                                       (SPADCALL |res| (- |k| 1) |dl| |l|
                                                 |r_off| |c_off1| (CONS 0 |mm|)
                                                 (QREFELT $ 55))
                                       (EXIT
                                        (LETT |c_off1| (+ |c_off1| |c_step|))))
                                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT (LETT |r_off| (+ |r_off| |r_step|))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL)))))))))) 

(SDEFUN |MATCAT-;kroneckerProduct;LS;40| ((|l| (|List| S)) ($ (S)))
        (SPROG
         ((|res| (S)) (|nc| #1=(|NonNegativeInteger|)) (#2=#:G1397 NIL)
          (|rc| NIL) (#3=#:G1396 NIL) (|nr| #1#) (#4=#:G1395 NIL)
          (#5=#:G1394 NIL) (|dl| (|List| (|List| (|NonNegativeInteger|))))
          (|k| (|NonNegativeInteger|)))
         (SEQ (LETT |k| (LENGTH |l|))
              (EXIT
               (COND
                ((EQL |k| 0)
                 (COND
                  ((QEQCAR (QREFELT $ 39) 0)
                   (SPADCALL 1 1 (QCDR (QREFELT $ 39)) (QREFELT $ 30)))
                  (#6='T (|error| "need 1"))))
                ((EQL |k| 1) (SPADCALL (|SPADfirst| |l|) (QREFELT $ 57)))
                (#6#
                 (SEQ (LETT |dl| (|MATCAT-;get_dims| |l| $))
                      (LETT |nr|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #4# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #4#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #4#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |rc| 1
                                                               (QREFELT $ 46))
                                                     #5#))))
                                            (LETT #4# (CDR #4#)) (GO G190) G191
                                            (EXIT (NREVERSE #5#))))
                                      (QREFELT $ 50)))
                      (LETT |nc|
                            (SPADCALL (ELT $ 48)
                                      (PROGN
                                       (LETT #3# NIL)
                                       (SEQ (LETT |rc| NIL) (LETT #2# |dl|)
                                            G190
                                            (COND
                                             ((OR (ATOM #2#)
                                                  (PROGN
                                                   (LETT |rc| (CAR #2#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #3#
                                                    (CONS
                                                     (SPADCALL |rc| 2
                                                               (QREFELT $ 46))
                                                     #3#))))
                                            (LETT #2# (CDR #2#)) (GO G190) G191
                                            (EXIT (NREVERSE #3#))))
                                      (QREFELT $ 50)))
                      (LETT |res| (SPADCALL |nr| |nc| (QREFELT $ 41)))
                      (SPADCALL |res| |k| |dl| |l| 0 0 (CONS 1 "one")
                                (QREFELT $ 55))
                      (EXIT |res|)))))))) 

(SDEFUN |MATCAT-;kroneckerProduct;3S;41| ((|a| (S)) (|b| (S)) ($ (S)))
        (SPADCALL (LIST |a| |b|) (QREFELT $ 59))) 

(SDEFUN |MATCAT-;kroneckerSum;LS;42| ((|l| (|List| S)) ($ (S)))
        (SPROG
         ((|n0| (|Integer|)) (|off0| (|NonNegativeInteger|))
          (|off_r| #1=(|NonNegativeInteger|)) (|ind_c| #1#) (|vv| (R))
          (#2=#:G1444 NIL) (|j| NIL) (#3=#:G1443 NIL) (#4=#:G1442 NIL)
          (|i| NIL) (#5=#:G1441 NIL) (|m| NIL) (|step0| (|NonNegativeInteger|))
          (|n2| (|NonNegativeInteger|)) (|dl| (|List| (|NonNegativeInteger|)))
          (|nr| (|NonNegativeInteger|)) (#6=#:G1440 NIL) (|a| NIL) (|res| (S))
          (|nrs| (|NonNegativeInteger|)) (#7=#:G1439 NIL) (#8=#:G1438 NIL)
          (|nc| (|NonNegativeInteger|)) (#9=#:G1437 NIL)
          (|k| (|NonNegativeInteger|)))
         (SEQ (LETT |k| (LENGTH |l|))
              (EXIT
               (COND ((EQL |k| 0) (SPADCALL 1 1 (QREFELT $ 41)))
                     ((EQL |k| 1) (SPADCALL (|SPADfirst| |l|) (QREFELT $ 57)))
                     ('T
                      (SEQ (LETT |dl| NIL)
                           (SEQ (LETT |a| NIL) (LETT #9# |l|) G190
                                (COND
                                 ((OR (ATOM #9#)
                                      (PROGN (LETT |a| (CAR #9#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |nr| (SPADCALL |a| (QREFELT $ 11)))
                                     (LETT |nc| (SPADCALL |a| (QREFELT $ 12)))
                                     (EXIT
                                      (COND
                                       ((SPADCALL |nr| |nc| (QREFELT $ 32))
                                        (|error|
                                         "kroneckerSum: nonsquare matrix"))
                                       ('T (LETT |dl| (CONS |nr| |dl|))))))
                                (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                           (LETT |dl| (NREVERSE |dl|))
                           (LETT |nrs|
                                 (SPADCALL (ELT $ 48)
                                           (PROGN
                                            (LETT #8# NIL)
                                            (SEQ (LETT #7# |dl|) G190
                                                 (COND
                                                  ((OR (ATOM #7#)
                                                       (PROGN
                                                        (LETT |nr| (CAR #7#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #8# (CONS |nr| #8#))))
                                                 (LETT #7# (CDR #7#)) (GO G190)
                                                 G191 (EXIT (NREVERSE #8#))))
                                           (QREFELT $ 50)))
                           (LETT |res| (SPADCALL |nrs| |nrs| (QREFELT $ 41)))
                           (LETT |n0| 1)
                           (SEQ (LETT |a| NIL) (LETT #6# |l|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |a| (CAR #6#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |off0| 0)
                                     (LETT |nr|
                                           (SPADCALL |dl| 1 (QREFELT $ 46)))
                                     (LETT |dl| (CDR |dl|))
                                     (LETT |n2|
                                           (SPADCALL (ELT $ 48) |dl| 1
                                                     (QREFELT $ 61)))
                                     (LETT |step0| (* |nr| |n2|))
                                     (SEQ (LETT |m| 1) (LETT #5# |n0|) G190
                                          (COND
                                           ((|greater_SI| |m| #5#) (GO G191)))
                                          (SEQ (LETT |off_r| (+ |off0| 1))
                                               (SEQ (LETT |i| 1)
                                                    (LETT #4# |nr|) G190
                                                    (COND
                                                     ((|greater_SI| |i| #4#)
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (SEQ (LETT |l| 1)
                                                           (LETT #3# |n2|) G190
                                                           (COND
                                                            ((|greater_SI| |l|
                                                                           #3#)
                                                             (GO G191)))
                                                           (SEQ
                                                            (LETT |ind_c|
                                                                  (+ |off0|
                                                                     |l|))
                                                            (SEQ (LETT |j| 1)
                                                                 (LETT #2#
                                                                       |nr|)
                                                                 G190
                                                                 (COND
                                                                  ((|greater_SI|
                                                                    |j| #2#)
                                                                   (GO G191)))
                                                                 (SEQ
                                                                  (LETT |vv|
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          |res|
                                                                          |off_r|
                                                                          |ind_c|
                                                                          (QREFELT
                                                                           $
                                                                           22))
                                                                         (SPADCALL
                                                                          |a|
                                                                          |i|
                                                                          |j|
                                                                          (QREFELT
                                                                           $
                                                                           22))
                                                                         (QREFELT
                                                                          $
                                                                          62)))
                                                                  (SPADCALL
                                                                   |res|
                                                                   |off_r|
                                                                   |ind_c| |vv|
                                                                   (QREFELT $
                                                                            33))
                                                                  (EXIT
                                                                   (LETT
                                                                    |ind_c|
                                                                    (+ |ind_c|
                                                                       |n2|))))
                                                                 (LETT |j|
                                                                       (|inc_SI|
                                                                        |j|))
                                                                 (GO G190) G191
                                                                 (EXIT NIL))
                                                            (EXIT
                                                             (LETT |off_r|
                                                                   (+ |off_r|
                                                                      1))))
                                                           (LETT |l|
                                                                 (|inc_SI|
                                                                  |l|))
                                                           (GO G190) G191
                                                           (EXIT NIL))))
                                                    (LETT |i| (|inc_SI| |i|))
                                                    (GO G190) G191 (EXIT NIL))
                                               (EXIT
                                                (LETT |off0|
                                                      (+ |off0| |step0|))))
                                          (LETT |m| (|inc_SI| |m|)) (GO G190)
                                          G191 (EXIT NIL))
                                     (EXIT (LETT |n0| (* |n0| |nr|))))
                                (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                           (EXIT |res|)))))))) 

(SDEFUN |MATCAT-;kroneckerSum;3S;43| ((|a| (S)) (|b| (S)) ($ (S)))
        (SPADCALL (LIST |a| |b|) (QREFELT $ 64))) 

(SDEFUN |MATCAT-;diagonalMatrix;LS;44| ((|list| (|List| S)) ($ (S)))
        (SPROG
         ((|loC| (|Integer|)) (|loR| (|Integer|)) (#1=#:G1462 NIL) (|j| NIL)
          (#2=#:G1463 NIL) (|l| NIL) (#3=#:G1460 NIL) (|i| NIL)
          (#4=#:G1461 NIL) (|k| NIL) (|hiC| #5=(|Integer|)) (|hiR| #5#)
          (#6=#:G1459 NIL) (|mat| NIL) (|ans| (S))
          (|cols| #7=(|NonNegativeInteger|)) (|rows| #7#) (#8=#:G1458 NIL))
         (SEQ (LETT |rows| 0) (LETT |cols| 0)
              (SEQ (LETT |mat| NIL) (LETT #8# |list|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |mat| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |rows| (+ |rows| (SPADCALL |mat| (QREFELT $ 11))))
                    (EXIT
                     (LETT |cols| (+ |cols| (SPADCALL |mat| (QREFELT $ 12))))))
                   (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
              (LETT |ans| (SPADCALL |rows| |cols| (QREFELT $ 41)))
              (LETT |loR| (SPADCALL |ans| (QREFELT $ 17)))
              (LETT |loC| (SPADCALL |ans| (QREFELT $ 19)))
              (SEQ (LETT |mat| NIL) (LETT #6# |list|) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |mat| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |hiR|
                          (- (+ |loR| (SPADCALL |mat| (QREFELT $ 11))) 1))
                    (LETT |hiC|
                          (- (+ |loC| (SPADCALL |mat| (QREFELT $ 11))) 1))
                    (SEQ (LETT |k| (SPADCALL |mat| (QREFELT $ 17)))
                         (LETT #4# (SPADCALL |mat| (QREFELT $ 18)))
                         (LETT |i| |loR|) (LETT #3# |hiR|) G190
                         (COND ((OR (> |i| #3#) (> |k| #4#)) (GO G191)))
                         (SEQ
                          (EXIT
                           (SEQ (LETT |l| (SPADCALL |mat| (QREFELT $ 19)))
                                (LETT #2# (SPADCALL |mat| (QREFELT $ 20)))
                                (LETT |j| |loC|) (LETT #1# |hiC|) G190
                                (COND ((OR (> |j| #1#) (> |l| #2#)) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SPADCALL |ans| |i| |j|
                                            (SPADCALL |mat| |k| |l|
                                                      (QREFELT $ 22))
                                            (QREFELT $ 33))))
                                (LETT |j|
                                      (PROG1 (+ |j| 1) (LETT |l| (+ |l| 1))))
                                (GO G190) G191 (EXIT NIL))))
                         (LETT |i| (PROG1 (+ |i| 1) (LETT |k| (+ |k| 1))))
                         (GO G190) G191 (EXIT NIL))
                    (LETT |loR| (+ |hiR| 1)) (EXIT (LETT |loC| (+ |hiC| 1))))
                   (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATCAT-;coerce;ColS;45| ((|v| (|Col|)) ($ (S)))
        (SPROG
         ((#1=#:G1468 NIL) (|i| NIL) (#2=#:G1469 NIL) (|k| NIL)
          (|one| (|Integer|)) (|x| (S)))
         (SEQ
          (LETT |x|
                (SPADCALL (SPADCALL |v| (QREFELT $ 67)) 1 (|spadConstant| $ 29)
                          (QREFELT $ 30)))
          (LETT |one| (SPADCALL |x| (QREFELT $ 19)))
          (SEQ (LETT |k| (SPADCALL |v| (QREFELT $ 68)))
               (LETT #2# (SPADCALL |v| (QREFELT $ 69)))
               (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
               (LETT #1# (SPADCALL |x| (QREFELT $ 18))) G190
               (COND ((OR (> |i| #1#) (> |k| #2#)) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |x| |i| |one| (SPADCALL |v| |k| (QREFELT $ 70))
                           (QREFELT $ 33))))
               (LETT |i| (PROG1 (+ |i| 1) (LETT |k| (+ |k| 1)))) (GO G190) G191
               (EXIT NIL))
          (EXIT |x|)))) 

(SDEFUN |MATCAT-;transpose;RowS;46| ((|v| (|Row|)) ($ (S)))
        (SPROG
         ((#1=#:G1474 NIL) (|j| NIL) (#2=#:G1475 NIL) (|k| NIL)
          (|one| (|Integer|)) (|x| (S)))
         (SEQ
          (LETT |x|
                (SPADCALL 1 (SPADCALL |v| (QREFELT $ 72)) (|spadConstant| $ 29)
                          (QREFELT $ 30)))
          (LETT |one| (SPADCALL |x| (QREFELT $ 17)))
          (SEQ (LETT |k| (SPADCALL |v| (QREFELT $ 73)))
               (LETT #2# (SPADCALL |v| (QREFELT $ 74)))
               (LETT |j| (SPADCALL |x| (QREFELT $ 19)))
               (LETT #1# (SPADCALL |x| (QREFELT $ 20))) G190
               (COND ((OR (> |j| #1#) (> |k| #2#)) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |x| |one| |j| (SPADCALL |v| |k| (QREFELT $ 75))
                           (QREFELT $ 33))))
               (LETT |j| (PROG1 (+ |j| 1) (LETT |k| (+ |k| 1)))) (GO G190) G191
               (EXIT NIL))
          (EXIT |x|)))) 

(SDEFUN |MATCAT-;+;3S;47| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPROG
         ((#1=#:G1487 NIL) (|j| NIL) (#2=#:G1486 NIL) (|i| NIL) (|ans| (S))
          (|c| (|NonNegativeInteger|)) (|r| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((OR
             (SPADCALL (LETT |r| (SPADCALL |x| (QREFELT $ 11)))
                       (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 32))
             (SPADCALL (LETT |c| (SPADCALL |x| (QREFELT $ 12)))
                       (SPADCALL |y| (QREFELT $ 12)) (QREFELT $ 32)))
            (|error| "can't add matrices of different dimensions"))
           ('T
            (SEQ
             (LETT |ans|
                   (SPADCALL |r| |c| (|spadConstant| $ 29) (QREFELT $ 30)))
             (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                  (LETT #2# (SPADCALL |x| (QREFELT $ 18))) G190
                  (COND ((> |i| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 19)))
                         (LETT #1# (SPADCALL |x| (QREFELT $ 20))) G190
                         (COND ((> |j| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL |ans| |i| |j|
                                     (SPADCALL
                                      (SPADCALL |x| |i| |j| (QREFELT $ 22))
                                      (SPADCALL |y| |i| |j| (QREFELT $ 22))
                                      (QREFELT $ 62))
                                     (QREFELT $ 33))))
                         (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                  (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
             (EXIT |ans|))))))) 

(SDEFUN |MATCAT-;-;3S;48| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPROG
         ((#1=#:G1499 NIL) (|j| NIL) (#2=#:G1498 NIL) (|i| NIL) (|ans| (S))
          (|c| (|NonNegativeInteger|)) (|r| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((OR
             (SPADCALL (LETT |r| (SPADCALL |x| (QREFELT $ 11)))
                       (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 32))
             (SPADCALL (LETT |c| (SPADCALL |x| (QREFELT $ 12)))
                       (SPADCALL |y| (QREFELT $ 12)) (QREFELT $ 32)))
            (|error| "can't subtract matrices of different dimensions"))
           ('T
            (SEQ
             (LETT |ans|
                   (SPADCALL |r| |c| (|spadConstant| $ 29) (QREFELT $ 30)))
             (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                  (LETT #2# (SPADCALL |x| (QREFELT $ 18))) G190
                  (COND ((> |i| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 19)))
                         (LETT #1# (SPADCALL |x| (QREFELT $ 20))) G190
                         (COND ((> |j| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL |ans| |i| |j|
                                     (SPADCALL
                                      (SPADCALL |x| |i| |j| (QREFELT $ 22))
                                      (SPADCALL |y| |i| |j| (QREFELT $ 22))
                                      (QREFELT $ 78))
                                     (QREFELT $ 33))))
                         (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                  (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
             (EXIT |ans|))))))) 

(SDEFUN |MATCAT-;-;2S;49| ((|x| (S)) ($ (S)))
        (SPADCALL (ELT $ 27) |x| (QREFELT $ 81))) 

(SDEFUN |MATCAT-;*;I2S;50| ((|m| (|Integer|)) (|x| (S)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|MATCAT-;*;I2S;50!0| (VECTOR $ |m|)) |x|
                         (QREFELT $ 81)))) 

(SDEFUN |MATCAT-;*;I2S;50!0| ((|r1| NIL) ($$ NIL))
        (PROG (|m| $)
          (LETT |m| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |m| |r1| (QREFELT $ 83)))))) 

(SDEFUN |MATCAT-;*;R2S;51| ((|a| (R)) (|x| (S)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|MATCAT-;*;R2S;51!0| (VECTOR $ |a|)) |x|
                         (QREFELT $ 81)))) 

(SDEFUN |MATCAT-;*;R2S;51!0| ((|r1| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |a| |r1| (QREFELT $ 47)))))) 

(SDEFUN |MATCAT-;*;SRS;52| ((|x| (S)) (|a| (R)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|MATCAT-;*;SRS;52!0| (VECTOR $ |a|)) |x|
                         (QREFELT $ 81)))) 

(SDEFUN |MATCAT-;*;SRS;52!0| ((|r1| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |r1| |a| (QREFELT $ 47)))))) 

(SDEFUN |MATCAT-;*;3S;53| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPROG
         ((|entry| (R)) (|sum| (R)) (#1=#:G1520 NIL) (|k| NIL) (#2=#:G1521 NIL)
          (|l| NIL) (#3=#:G1519 NIL) (|j| NIL) (#4=#:G1518 NIL) (|i| NIL)
          (|ans| (S)))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 12))
                      (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 21))
            (|error| "can't multiply matrices of incompatible dimensions"))
           ('T
            (SEQ
             (LETT |ans|
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                             (SPADCALL |y| (QREFELT $ 12))
                             (|spadConstant| $ 29) (QREFELT $ 30)))
             (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                  (LETT #4# (SPADCALL |x| (QREFELT $ 18))) G190
                  (COND ((> |i| #4#) (GO G191)))
                  (SEQ
                   (EXIT
                    (SEQ (LETT |j| (SPADCALL |y| (QREFELT $ 19)))
                         (LETT #3# (SPADCALL |y| (QREFELT $ 20))) G190
                         (COND ((> |j| #3#) (GO G191)))
                         (SEQ
                          (LETT |entry|
                                (SEQ (LETT |sum| (|spadConstant| $ 29))
                                     (SEQ
                                      (LETT |l| (SPADCALL |x| (QREFELT $ 19)))
                                      (LETT #2# (SPADCALL |x| (QREFELT $ 20)))
                                      (LETT |k| (SPADCALL |y| (QREFELT $ 17)))
                                      (LETT #1# (SPADCALL |y| (QREFELT $ 18)))
                                      G190
                                      (COND
                                       ((OR (> |k| #1#) (> |l| #2#))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT |sum|
                                              (SPADCALL |sum|
                                                        (SPADCALL
                                                         (SPADCALL |x| |i| |l|
                                                                   (QREFELT $
                                                                            22))
                                                         (SPADCALL |y| |k| |j|
                                                                   (QREFELT $
                                                                            22))
                                                         (QREFELT $ 47))
                                                        (QREFELT $ 62)))))
                                      (LETT |k|
                                            (PROG1 (+ |k| 1)
                                              (LETT |l| (+ |l| 1))))
                                      (GO G190) G191 (EXIT NIL))
                                     (EXIT |sum|)))
                          (EXIT
                           (SPADCALL |ans| |i| |j| |entry| (QREFELT $ 33))))
                         (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                  (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
             (EXIT |ans|))))))) 

(SDEFUN |MATCAT-;positivePower;SIS;54| ((|x| (S)) (|n| (|Integer|)) ($ (S)))
        (SPROG ((|y| (S)))
               (SEQ
                (COND ((EQL |n| 1) |x|)
                      ((ODDP |n|)
                       (SPADCALL |x| (SPADCALL |x| (- |n| 1) (QREFELT $ 88))
                                 (QREFELT $ 89)))
                      ('T
                       (SEQ
                        (LETT |y|
                              (SPADCALL |x| (QUOTIENT2 |n| 2) (QREFELT $ 88)))
                        (EXIT (SPADCALL |y| |y| (QREFELT $ 89))))))))) 

(SDEFUN |MATCAT-;^;SNniS;55| ((|x| (S)) (|n| (|NonNegativeInteger|)) ($ (S)))
        (SPROG ((|nn| (|NonNegativeInteger|)))
               (COND
                ((NULL
                  (EQL (LETT |nn| (SPADCALL |x| (QREFELT $ 11)))
                       (SPADCALL |x| (QREFELT $ 12))))
                 (|error| "^: matrix must be square"))
                ('T
                 (COND
                  ((ZEROP |n|)
                   (SPADCALL |nn| (|spadConstant| $ 38) (QREFELT $ 91)))
                  ('T (SPADCALL |x| |n| (QREFELT $ 88)))))))) 

(SDEFUN |MATCAT-;*;S2Col;56| ((|x| (S)) (|v| (|Col|)) ($ (|Col|)))
        (SPROG
         ((|sum| (R)) (#1=#:G1538 NIL) (|j| NIL) (#2=#:G1539 NIL) (|l| NIL)
          (#3=#:G1536 NIL) (|i| NIL) (#4=#:G1537 NIL) (|k| NIL) (|w| (|Col|)))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 12))
                      (SPADCALL |v| (QREFELT $ 67)) (QREFELT $ 21))
            (|error| "can't multiply matrix A and vector v if #cols A ~= #v"))
           ('T
            (SEQ
             (LETT |w|
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                             (|spadConstant| $ 29) (QREFELT $ 93)))
             (SEQ (LETT |k| (SPADCALL |w| (QREFELT $ 68)))
                  (LETT #4# (SPADCALL |w| (QREFELT $ 69)))
                  (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                  (LETT #3# (SPADCALL |x| (QREFELT $ 18))) G190
                  (COND ((OR (> |i| #3#) (> |k| #4#)) (GO G191)))
                  (SEQ
                   (EXIT
                    (SPADCALL |w| |k|
                              (SEQ (LETT |sum| (|spadConstant| $ 29))
                                   (SEQ
                                    (LETT |l| (SPADCALL |v| (QREFELT $ 68)))
                                    (LETT #2# (SPADCALL |v| (QREFELT $ 69)))
                                    (LETT |j| (SPADCALL |x| (QREFELT $ 19)))
                                    (LETT #1# (SPADCALL |x| (QREFELT $ 20)))
                                    G190
                                    (COND
                                     ((OR (> |j| #1#) (> |l| #2#)) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT |sum|
                                            (SPADCALL |sum|
                                                      (SPADCALL
                                                       (SPADCALL |x| |i| |j|
                                                                 (QREFELT $
                                                                          22))
                                                       (SPADCALL |v| |l|
                                                                 (QREFELT $
                                                                          94))
                                                       (QREFELT $ 47))
                                                      (QREFELT $ 62)))))
                                    (LETT |j|
                                          (PROG1 (+ |j| 1)
                                            (LETT |l| (+ |l| 1))))
                                    (GO G190) G191 (EXIT NIL))
                                   (EXIT |sum|))
                              (QREFELT $ 95))))
                  (LETT |i| (PROG1 (+ |i| 1) (LETT |k| (+ |k| 1)))) (GO G190)
                  G191 (EXIT NIL))
             (EXIT |w|))))))) 

(SDEFUN |MATCAT-;*;RowSRow;57| ((|v| (|Row|)) (|x| (S)) ($ (|Row|)))
        (SPROG
         ((|sum| (R)) (#1=#:G1550 NIL) (|i| NIL) (#2=#:G1551 NIL) (|l| NIL)
          (#3=#:G1548 NIL) (|j| NIL) (#4=#:G1549 NIL) (|k| NIL) (|w| (|Row|)))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 11))
                      (SPADCALL |v| (QREFELT $ 72)) (QREFELT $ 21))
            (|error| "can't multiply vector v and matrix A if #rows A ~= #v"))
           ('T
            (SEQ
             (LETT |w|
                   (SPADCALL (SPADCALL |x| (QREFELT $ 12))
                             (|spadConstant| $ 29) (QREFELT $ 97)))
             (SEQ (LETT |k| (SPADCALL |w| (QREFELT $ 73)))
                  (LETT #4# (SPADCALL |w| (QREFELT $ 74)))
                  (LETT |j| (SPADCALL |x| (QREFELT $ 19)))
                  (LETT #3# (SPADCALL |x| (QREFELT $ 20))) G190
                  (COND ((OR (> |j| #3#) (> |k| #4#)) (GO G191)))
                  (SEQ
                   (EXIT
                    (SPADCALL |w| |k|
                              (SEQ (LETT |sum| (|spadConstant| $ 29))
                                   (SEQ
                                    (LETT |l| (SPADCALL |v| (QREFELT $ 73)))
                                    (LETT #2# (SPADCALL |v| (QREFELT $ 74)))
                                    (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                                    (LETT #1# (SPADCALL |x| (QREFELT $ 18)))
                                    G190
                                    (COND
                                     ((OR (> |i| #1#) (> |l| #2#)) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT |sum|
                                            (SPADCALL |sum|
                                                      (SPADCALL
                                                       (SPADCALL |x| |i| |j|
                                                                 (QREFELT $
                                                                          22))
                                                       (SPADCALL |v| |l|
                                                                 (QREFELT $
                                                                          98))
                                                       (QREFELT $ 47))
                                                      (QREFELT $ 62)))))
                                    (LETT |i|
                                          (PROG1 (+ |i| 1)
                                            (LETT |l| (+ |l| 1))))
                                    (GO G190) G191 (EXIT NIL))
                                   (EXIT |sum|))
                              (QREFELT $ 99))))
                  (LETT |j| (PROG1 (+ |j| 1) (LETT |k| (+ |k| 1)))) (GO G190)
                  G191 (EXIT NIL))
             (EXIT |w|))))))) 

(SDEFUN |MATCAT-;columnSpace;SL;58| ((M (S)) ($ (|List| |Col|)))
        (SPROG
         ((|indRow| (|Integer|)) (|basis| (|List| |Col|)) (#1=#:G1558 NIL)
          (|k| NIL) (|m| (|Integer|)) (|n| (|Integer|)) (M2 (S)))
         (SEQ (LETT M2 (SPADCALL M (QREFELT $ 101))) (LETT |basis| NIL)
              (LETT |n| (SPADCALL M (QREFELT $ 12)))
              (LETT |m| (SPADCALL M (QREFELT $ 11))) (LETT |indRow| 1)
              (SEQ (LETT |k| 1) (LETT #1# |n|) G190
                   (COND
                    ((OR (|greater_SI| |k| #1#) (NULL (<= |indRow| |m|)))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL
                        (SPADCALL (SPADCALL M2 |indRow| |k| (QREFELT $ 102))
                                  (QREFELT $ 23)))
                       (SEQ
                        (LETT |basis|
                              (CONS (SPADCALL M |k| (QREFELT $ 103)) |basis|))
                        (EXIT (LETT |indRow| (+ |indRow| 1))))))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |basis|))))) 

(SDEFUN |MATCAT-;B0| ((|n| (|PositiveInteger|)) ($ (S)))
        (SPROG
         ((#1=#:G1573 NIL) (|j| NIL) (#2=#:G1572 NIL) (#3=#:G1571 NIL)
          (|i| NIL) (#4=#:G1570 NIL))
         (SEQ
          (SPADCALL
           (PROGN
            (LETT #4# NIL)
            (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                 (COND ((|greater_SI| |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #4#
                         (CONS
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                                (COND ((|greater_SI| |j| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (COND
                                          ((EQL |i| (+ |j| 1))
                                           (COND
                                            ((ODDP |j|)
                                             (SPADCALL (|spadConstant| $ 38)
                                                       (QREFELT $ 27)))
                                            ((EQL |i| (- |j| 1))
                                             (COND
                                              ((ODDP |i|)
                                               (|spadConstant| $ 38))
                                              ('T (|spadConstant| $ 29))))
                                            ('T (|spadConstant| $ 29))))
                                          ((EQL |i| (- |j| 1))
                                           (COND
                                            ((ODDP |i|) (|spadConstant| $ 38))
                                            ('T (|spadConstant| $ 29))))
                                          ('T (|spadConstant| $ 29)))
                                         #2#))))
                                (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          #4#))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                 (EXIT (NREVERSE #4#))))
           (QREFELT $ 106))))) 

(SDEFUN |MATCAT-;PfChar| ((A (S)) ($ #1=(|SparseUnivariatePolynomial| R)))
        (SPROG
         ((|res| (|SparseUnivariatePolynomial| R)) (#2=#:G1591 NIL) (|e| NIL)
          (#3=#:G1592 NIL) (|k| NIL) (|c| (R)) (#4=#:G1589 NIL) (|i| NIL)
          (#5=#:G1590 NIL) (|j| NIL) (|g| (|List| R)) (C (S)) (#6=#:G1588 NIL)
          (B (S)) (#7=#:G1575 NIL) (|d| (|NonNegativeInteger|)) (|p| #1#)
          (|s| (S)) (|r| (S)) (M (S)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL A (QREFELT $ 11)))
              (EXIT
               (COND
                ((EQL |n| 2)
                 (SPADCALL (SPADCALL (|spadConstant| $ 38) 2 (QREFELT $ 108))
                           (SPADCALL (SPADCALL A 1 2 (QREFELT $ 22))
                                     (QREFELT $ 109))
                           (QREFELT $ 110)))
                ('T
                 (SEQ (LETT M (SPADCALL A 3 |n| 3 |n| (QREFELT $ 111)))
                      (LETT |r| (SPADCALL A 1 1 3 |n| (QREFELT $ 111)))
                      (LETT |s| (SPADCALL A 3 |n| 2 2 (QREFELT $ 111)))
                      (LETT |p| (|MATCAT-;PfChar| M $))
                      (LETT |d| (SPADCALL |p| (QREFELT $ 112)))
                      (LETT B
                            (|MATCAT-;B0|
                             (PROG1 (LETT #7# (- |n| 2))
                               (|check_subtype2| (> #7# 0) '(|PositiveInteger|)
                                                 '(|Integer|) #7#))
                             $))
                      (LETT C (SPADCALL |r| B (QREFELT $ 89)))
                      (LETT |g|
                            (LIST
                             (SPADCALL (SPADCALL C |s| (QREFELT $ 89)) 1 1
                                       (QREFELT $ 22))
                             (SPADCALL A 1 2 (QREFELT $ 22))
                             (|spadConstant| $ 38)))
                      (COND
                       ((>= |d| 4)
                        (SEQ (LETT B (SPADCALL M B (QREFELT $ 89)))
                             (EXIT
                              (SEQ (LETT |i| 4) (LETT #6# |d|) G190
                                   (COND ((> |i| #6#) (GO G191)))
                                   (SEQ (LETT C (SPADCALL C B (QREFELT $ 89)))
                                        (EXIT
                                         (LETT |g|
                                               (CONS
                                                (SPADCALL
                                                 (SPADCALL C |s|
                                                           (QREFELT $ 89))
                                                 1 1 (QREFELT $ 22))
                                                |g|))))
                                   (LETT |i| (+ |i| 2)) (GO G190) G191
                                   (EXIT NIL))))))
                      (LETT |g| (NREVERSE |g|))
                      (LETT |res| (|spadConstant| $ 113))
                      (SEQ (LETT |j| 2) (LETT #5# (+ |d| 2)) (LETT |i| 0)
                           (LETT #4# |d|) G190
                           (COND
                            ((OR (> |i| #4#) (|greater_SI| |j| #5#))
                             (GO G191)))
                           (SEQ (LETT |c| (SPADCALL |p| |i| (QREFELT $ 114)))
                                (EXIT
                                 (SEQ (LETT |k| 2) (LETT #3# (- |d|))
                                      (LETT |e| NIL)
                                      (LETT #2#
                                            (SPADCALL |g| |j| (QREFELT $ 115)))
                                      G190
                                      (COND
                                       ((OR (ATOM #2#)
                                            (PROGN (LETT |e| (CAR #2#)) NIL)
                                            (< |k| #3#))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT |res|
                                              (SPADCALL |res|
                                                        (SPADCALL
                                                         (SPADCALL |c| |e|
                                                                   (QREFELT $
                                                                            47))
                                                         (+ |k| |i|)
                                                         (QREFELT $ 108))
                                                        (QREFELT $ 110)))))
                                      (LETT #2#
                                            (PROG1 (CDR #2#)
                                              (LETT |k| (+ |k| -2))))
                                      (GO G190) G191 (EXIT NIL))))
                           (LETT |i|
                                 (PROG1 (+ |i| 2) (LETT |j| (|inc_SI| |j|))))
                           (GO G190) G191 (EXIT NIL))
                      (EXIT |res|)))))))) 

(SDEFUN |MATCAT-;Pfaffian;SR;61| ((A (S)) ($ (R)))
        (COND
         ((SPADCALL A (QREFELT $ 116))
          (COND ((ODDP (SPADCALL A (QREFELT $ 11))) (|spadConstant| $ 29))
                (#1='T
                 (SPADCALL (|MATCAT-;PfChar| A $) (|spadConstant| $ 29)
                           (QREFELT $ 117)))))
         (#1#
          (|error|
           "Pfaffian: only defined for antisymmetric square matrices!")))) 

(SDEFUN |MATCAT-;exquo;SRU;62| ((|x| (S)) (|a| (R)) ($ (|Union| S "failed")))
        (SPROG
         ((|entry| (R)) (#1=#:G1614 NIL) (|r| (|Union| R "failed"))
          (#2=#:G1616 NIL) (|j| NIL) (#3=#:G1615 NIL) (|i| NIL) (|ans| (S)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |ans|
                  (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                            (SPADCALL |x| (QREFELT $ 12)) (|spadConstant| $ 29)
                            (QREFELT $ 30)))
            (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                 (LETT #3# (SPADCALL |x| (QREFELT $ 18))) G190
                 (COND ((> |i| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 19)))
                        (LETT #2# (SPADCALL |x| (QREFELT $ 20))) G190
                        (COND ((> |j| #2#) (GO G191)))
                        (SEQ
                         (LETT |entry|
                               (SEQ
                                (LETT |r|
                                      (SPADCALL
                                       (SPADCALL |x| |i| |j| (QREFELT $ 22))
                                       |a| (QREFELT $ 120)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |r| 1)
                                   (PROGN
                                    (LETT #1# (CONS 1 "failed"))
                                    (GO #4=#:G1613)))
                                  ('T (QCDR |r|))))))
                         (EXIT
                          (SPADCALL |ans| |i| |j| |entry| (QREFELT $ 33))))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 0 |ans|))))
          #4# (EXIT #1#)))) 

(SDEFUN |MATCAT-;/;SRS;63| ((|x| (S)) (|r| (R)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|MATCAT-;/;SRS;63!0| (VECTOR $ |r|)) |x|
                         (QREFELT $ 81)))) 

(SDEFUN |MATCAT-;/;SRS;63!0| ((|r1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |r1| |r| (QREFELT $ 122)))))) 

(SDEFUN |MATCAT-;^;SIS;64| ((|x| (S)) (|n| (|Integer|)) ($ (S)))
        (SPROG ((|xInv| (|Union| S "failed")) (|nn| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((NULL
                   (EQL (LETT |nn| (SPADCALL |x| (QREFELT $ 11)))
                        (SPADCALL |x| (QREFELT $ 12))))
                  (|error| "^: matrix must be square"))
                 ('T
                  (COND
                   ((ZEROP |n|)
                    (SPADCALL |nn| (|spadConstant| $ 38) (QREFELT $ 91)))
                   ((PLUSP |n|) (SPADCALL |x| |n| (QREFELT $ 88)))
                   (#1='T
                    (SEQ (LETT |xInv| (SPADCALL |x| (QREFELT $ 124)))
                         (EXIT
                          (COND
                           ((QEQCAR |xInv| 1)
                            (|error| "^: matrix must be invertible"))
                           (#1#
                            (SPADCALL (QCDR |xInv|) (- |n|)
                                      (QREFELT $ 88))))))))))))) 

(DECLAIM (NOTINLINE |MatrixCategory&;|)) 

(DEFUN |MatrixCategory&| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|MatrixCategory&| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 127))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#2|
                                                       '(|EuclideanDomain|))
                                        (|HasCategory| |#2| '(|Field|))
                                        (|HasCategory| |#2|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#2| '(|Monoid|))
                                        (|HasCategory| |#2| '(|SemiRng|))
                                        (|HasCategory| |#2|
                                                       '(|AbelianGroup|))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 7)
      (QSETREFV $ 28
                (CONS (|dispatchFunction| |MATCAT-;antisymmetric?;SB;4|) $))))
    (QSETREFV $ 39
              (COND
               ((|HasCategory| |#2| '(|SemiRing|))
                (CONS 0 (|spadConstant| $ 38)))
               ('T (CONS 1 "one"))))
    (COND
     ((|domainEqual| |#1| (|Matrix| |#2|))
      (PROGN
       (QSETREFV $ 40 (CONS (|dispatchFunction| |MATCAT-;zero?;SB;9|) $))
       (QSETREFV $ 42
                 (CONS (|dispatchFunction| |MATCAT-;scalarMatrix;NniRS;10|) $))
       (QSETREFV $ 44
                 (CONS (|dispatchFunction| |MATCAT-;diagonalMatrix;LS;11|) $))
       (COND
        ((|testBitVector| |pv$| 6)
         (PROGN
          (QSETREFV $ 56
                    (CONS
                     (|dispatchFunction|
                      |MATCAT-;kronecker_prod1;SILL2NniUV;12|)
                     $))
          (QSETREFV $ 58
                    (CONS (|dispatchFunction| |MATCAT-;kroneckerProduct;LS;13|)
                          $))
          (QSETREFV $ 60
                    (CONS (|dispatchFunction| |MATCAT-;kroneckerProduct;3S;14|)
                          $)))))
       (QSETREFV $ 63
                 (CONS (|dispatchFunction| |MATCAT-;kroneckerSum;LS;15|) $))
       (QSETREFV $ 65
                 (CONS (|dispatchFunction| |MATCAT-;kroneckerSum;3S;16|) $))
       (QSETREFV $ 66
                 (CONS (|dispatchFunction| |MATCAT-;diagonalMatrix;LS;17|)
                       $))))
     ((|domainEqual| |#1| (|DoubleFloatMatrix|))
      (COND
       ((|domainEqual| |#2| (|DoubleFloat|))
        (PROGN
         (QSETREFV $ 40 (CONS (|dispatchFunction| |MATCAT-;zero?;SB;18|) $))
         (QSETREFV $ 42
                   (CONS (|dispatchFunction| |MATCAT-;scalarMatrix;NniRS;19|)
                         $))
         (QSETREFV $ 44
                   (CONS (|dispatchFunction| |MATCAT-;diagonalMatrix;LS;20|)
                         $))
         (COND
          ((|testBitVector| |pv$| 6)
           (PROGN
            (QSETREFV $ 56
                      (CONS
                       (|dispatchFunction|
                        |MATCAT-;kronecker_prod1;SILL2NniUV;21|)
                       $))
            (QSETREFV $ 58
                      (CONS
                       (|dispatchFunction| |MATCAT-;kroneckerProduct;LS;22|)
                       $))
            (QSETREFV $ 60
                      (CONS
                       (|dispatchFunction| |MATCAT-;kroneckerProduct;3S;23|)
                       $)))))
         (QSETREFV $ 63
                   (CONS (|dispatchFunction| |MATCAT-;kroneckerSum;LS;24|) $))
         (QSETREFV $ 65
                   (CONS (|dispatchFunction| |MATCAT-;kroneckerSum;3S;25|) $))
         (QSETREFV $ 66
                   (CONS (|dispatchFunction| |MATCAT-;diagonalMatrix;LS;26|)
                         $))))
       ('T
        (PROGN
         (QSETREFV $ 40 (CONS (|dispatchFunction| |MATCAT-;zero?;SB;27|) $))
         (QSETREFV $ 42
                   (CONS (|dispatchFunction| |MATCAT-;scalarMatrix;NniRS;28|)
                         $))
         (QSETREFV $ 44
                   (CONS (|dispatchFunction| |MATCAT-;diagonalMatrix;LS;29|)
                         $))
         (COND
          ((|testBitVector| |pv$| 6)
           (PROGN
            (QSETREFV $ 56
                      (CONS
                       (|dispatchFunction|
                        |MATCAT-;kronecker_prod1;SILL2NniUV;30|)
                       $))
            (QSETREFV $ 58
                      (CONS
                       (|dispatchFunction| |MATCAT-;kroneckerProduct;LS;31|)
                       $))
            (QSETREFV $ 60
                      (CONS
                       (|dispatchFunction| |MATCAT-;kroneckerProduct;3S;32|)
                       $)))))
         (QSETREFV $ 63
                   (CONS (|dispatchFunction| |MATCAT-;kroneckerSum;LS;33|) $))
         (QSETREFV $ 65
                   (CONS (|dispatchFunction| |MATCAT-;kroneckerSum;3S;34|) $))
         (QSETREFV $ 66
                   (CONS (|dispatchFunction| |MATCAT-;diagonalMatrix;LS;35|)
                         $))))))
     ('T
      (PROGN
       (QSETREFV $ 40 (CONS (|dispatchFunction| |MATCAT-;zero?;SB;36|) $))
       (QSETREFV $ 42
                 (CONS (|dispatchFunction| |MATCAT-;scalarMatrix;NniRS;37|) $))
       (QSETREFV $ 44
                 (CONS (|dispatchFunction| |MATCAT-;diagonalMatrix;LS;38|) $))
       (COND
        ((|testBitVector| |pv$| 6)
         (PROGN
          (QSETREFV $ 56
                    (CONS
                     (|dispatchFunction|
                      |MATCAT-;kronecker_prod1;SILL2NniUV;39|)
                     $))
          (QSETREFV $ 58
                    (CONS (|dispatchFunction| |MATCAT-;kroneckerProduct;LS;40|)
                          $))
          (QSETREFV $ 60
                    (CONS (|dispatchFunction| |MATCAT-;kroneckerProduct;3S;41|)
                          $)))))
       (QSETREFV $ 63
                 (CONS (|dispatchFunction| |MATCAT-;kroneckerSum;LS;42|) $))
       (QSETREFV $ 65
                 (CONS (|dispatchFunction| |MATCAT-;kroneckerSum;3S;43|) $))
       (QSETREFV $ 66
                 (CONS (|dispatchFunction| |MATCAT-;diagonalMatrix;LS;44|)
                       $)))))
    (COND
     ((|testBitVector| |pv$| 7)
      (PROGN
       (QSETREFV $ 79 (CONS (|dispatchFunction| |MATCAT-;-;3S;48|) $))
       (QSETREFV $ 82 (CONS (|dispatchFunction| |MATCAT-;-;2S;49|) $))
       (QSETREFV $ 84 (CONS (|dispatchFunction| |MATCAT-;*;I2S;50|) $)))))
    (COND
     ((|testBitVector| |pv$| 6)
      (PROGN
       (QSETREFV $ 85 (CONS (|dispatchFunction| |MATCAT-;*;R2S;51|) $))
       (QSETREFV $ 86 (CONS (|dispatchFunction| |MATCAT-;*;SRS;52|) $))
       (QSETREFV $ 87 (CONS (|dispatchFunction| |MATCAT-;*;3S;53|) $))
       (QSETREFV $ 90
                 (CONS (|dispatchFunction| |MATCAT-;positivePower;SIS;54|)
                       $)))))
    (COND
     ((|testBitVector| |pv$| 5)
      (QSETREFV $ 92 (CONS (|dispatchFunction| |MATCAT-;^;SNniS;55|) $))))
    (COND
     ((|HasCategory| |#4| '(|shallowlyMutable|))
      (QSETREFV $ 96 (CONS (|dispatchFunction| |MATCAT-;*;S2Col;56|) $))))
    (COND
     ((|HasCategory| |#3| '(|shallowlyMutable|))
      (QSETREFV $ 100 (CONS (|dispatchFunction| |MATCAT-;*;RowSRow;57|) $))))
    (COND
     ((|testBitVector| |pv$| 2)
      (QSETREFV $ 105
                (CONS (|dispatchFunction| |MATCAT-;columnSpace;SL;58|) $))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 118
                 (CONS (|dispatchFunction| |MATCAT-;Pfaffian;SR;61|) $)))))
    (COND
     ((|testBitVector| |pv$| 4)
      (QSETREFV $ 121 (CONS (|dispatchFunction| |MATCAT-;exquo;SRU;62|) $))))
    (COND
     ((|testBitVector| |pv$| 3)
      (PROGN
       (QSETREFV $ 123 (CONS (|dispatchFunction| |MATCAT-;/;SRS;63|) $))
       (QSETREFV $ 125 (CONS (|dispatchFunction| |MATCAT-;^;SIS;64|) $)))))
    $))) 

(MAKEPROP '|MatrixCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|NonNegativeInteger|)
              (0 . |nrows|) (5 . |ncols|) (|Boolean|) |MATCAT-;square?;SB;1|
              (10 . |square?|) (|Integer|) (15 . |minRowIndex|)
              (20 . |maxRowIndex|) (25 . |minColIndex|) (30 . |maxColIndex|)
              (35 . ~=) (41 . |qelt|) (48 . |zero?|) |MATCAT-;diagonal?;SB;2|
              (53 . ~=) |MATCAT-;symmetric?;SB;3| (59 . -)
              (64 . |antisymmetric?|) (69 . |Zero|) (73 . |new|)
              |MATCAT-;zero;2NniS;5| (80 . ~=) (86 . |qsetelt!|) (|List| 43)
              |MATCAT-;matrix;LS;6| (|Mapping| 7 16 16)
              |MATCAT-;matrix;2NniMS;7| (94 . |One|) '|maybe_1| (98 . |zero?|)
              (103 . |zero|) (109 . |scalarMatrix|) (|List| 7)
              (115 . |diagonalMatrix|) (|List| 10) (120 . |elt|) (126 . *)
              (132 . *) (|Mapping| 10 10 10) (138 . |reduce|) (|Void|)
              (|List| 45) (|List| $) (|Union| 7 '#1="one")
              (144 . |kronecker_prod1|) (155 . |kronecker_prod1|)
              (166 . |copy|) (171 . |kroneckerProduct|)
              (176 . |kroneckerProduct|) (181 . |kroneckerProduct|)
              (187 . |reduce|) (194 . +) (200 . |kroneckerSum|)
              (205 . |kroneckerSum|) (210 . |kroneckerSum|)
              (216 . |diagonalMatrix|) (221 . |#|) (226 . |minIndex|)
              (231 . |maxIndex|) (236 . |qelt|) |MATCAT-;coerce;ColS;45|
              (242 . |#|) (247 . |minIndex|) (252 . |maxIndex|) (257 . |qelt|)
              |MATCAT-;transpose;RowS;46| |MATCAT-;+;3S;47| (263 . -) (269 . -)
              (|Mapping| 7 7) (275 . |map|) (281 . -) (286 . *) (292 . *)
              (298 . *) (304 . *) (310 . *) (316 . |positivePower|) (322 . *)
              (328 . |positivePower|) (334 . |scalarMatrix|) (340 . ^)
              (346 . |new|) (352 . |elt|) (358 . |setelt!|) (365 . *)
              (371 . |new|) (377 . |elt|) (383 . |setelt!|) (390 . *)
              (396 . |rowEchelon|) (401 . |elt|) (408 . |column|) (|List| 9)
              (414 . |columnSpace|) (419 . |matrix|)
              (|SparseUnivariatePolynomial| 7) (424 . |monomial|)
              (430 . |coerce|) (435 . +) (441 . |subMatrix|) (450 . |degree|)
              (455 . |Zero|) (459 . |coefficient|) (465 . |first|)
              (471 . |antisymmetric?|) (476 . |elt|) (482 . |Pfaffian|)
              (|Union| $ '"failed") (487 . |exquo|) (493 . |exquo|) (499 . /)
              (505 . /) (511 . |inverse|) (516 . ^) (|OutputForm|))
           '#(|zero?| 522 |zero| 527 |transpose| 533 |symmetric?| 538 |square?|
              543 |scalarMatrix| 548 |positivePower| 554 |matrix| 560
              |kronecker_prod1| 572 |kroneckerSum| 583 |kroneckerProduct| 594
              |exquo| 605 |diagonalMatrix| 611 |diagonal?| 621 |columnSpace|
              626 |coerce| 631 |antisymmetric?| 636 ^ 641 |Pfaffian| 653 / 658
              - 664 + 675 * 681)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|kronecker_prod1|
                                 ((|Void|) |#1| (|Integer|)
                                  (|List| (|List| (|NonNegativeInteger|)))
                                  (|List| |#1|) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|) (|Union| |#2| #1#)))
                                T)
                              '((^ (|#1| |#1| (|Integer|))) T)
                              '((|Pfaffian| (|#2| |#1|)) T)
                              '((|columnSpace| ((|List| |#4|) |#1|)) T)
                              '((/ (|#1| |#1| |#2|)) T)
                              '((|exquo| ((|Union| |#1| "failed") |#1| |#2|))
                                T)
                              '((^ (|#1| |#1| (|NonNegativeInteger|))) T)
                              '((|positivePower| (|#1| |#1| (|Integer|))) T)
                              '((* (|#3| |#3| |#1|)) T)
                              '((* (|#4| |#1| |#4|)) T)
                              '((* (|#1| |#1| |#2|)) T)
                              '((* (|#1| |#2| |#1|)) T)
                              '((* (|#1| |#1| |#1|)) T)
                              '((* (|#1| (|Integer|) |#1|)) T)
                              '((- (|#1| |#1|)) T) '((- (|#1| |#1| |#1|)) T)
                              '((+ (|#1| |#1| |#1|)) T)
                              '((|transpose| (|#1| |#3|)) T)
                              '((|coerce| (|#1| |#4|)) T)
                              '((|kroneckerSum| (|#1| (|List| |#1|))) T)
                              '((|kroneckerSum| (|#1| |#1| |#1|)) T)
                              '((|kroneckerProduct| (|#1| (|List| |#1|))) T)
                              '((|kroneckerProduct| (|#1| |#1| |#1|)) T)
                              '((|diagonalMatrix| (|#1| (|List| |#1|))) T)
                              '((|diagonalMatrix| (|#1| (|List| |#2|))) T)
                              '((|scalarMatrix|
                                 (|#1| (|NonNegativeInteger|) |#2|))
                                T)
                              '((|matrix|
                                 (|#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)
                                  (|Mapping| |#2| (|Integer|) (|Integer|))))
                                T)
                              '((|matrix| (|#1| (|List| (|List| |#2|)))) T)
                              '((|zero|
                                 (|#1| (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|zero?| ((|Boolean|) |#1|)) T)
                              '((|antisymmetric?| ((|Boolean|) |#1|)) T)
                              '((|symmetric?| ((|Boolean|) |#1|)) T)
                              '((|diagonal?| ((|Boolean|) |#1|)) T)
                              '((|square?| ((|Boolean|) |#1|)) T)
                              '((|coerce| ((|OutputForm|) |#1|)) T)
                              '((|transpose| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 125
                                            '(1 6 10 0 11 1 6 10 0 12 1 6 13 0
                                              15 1 6 16 0 17 1 6 16 0 18 1 6 16
                                              0 19 1 6 16 0 20 2 16 13 0 0 21 3
                                              6 7 0 16 16 22 1 7 13 0 23 2 7 13
                                              0 0 25 1 7 0 0 27 1 0 13 0 28 0 7
                                              0 29 3 6 0 10 10 7 30 2 10 13 0 0
                                              32 4 6 7 0 16 16 7 33 0 7 0 38 1
                                              0 13 0 40 2 6 0 10 10 41 2 0 0 10
                                              7 42 1 0 0 43 44 2 45 10 0 16 46
                                              2 7 0 0 0 47 2 10 0 0 0 48 2 45
                                              10 49 0 50 7 6 51 0 16 52 53 10
                                              10 54 55 7 0 51 0 16 52 53 10 10
                                              54 56 1 6 0 0 57 1 0 0 53 58 1 6
                                              0 53 59 2 0 0 0 0 60 3 45 10 49 0
                                              10 61 2 7 0 0 0 62 1 0 0 53 63 1
                                              6 0 53 64 2 0 0 0 0 65 1 0 0 53
                                              66 1 9 10 0 67 1 9 16 0 68 1 9 16
                                              0 69 2 9 7 0 16 70 1 8 10 0 72 1
                                              8 16 0 73 1 8 16 0 74 2 8 7 0 16
                                              75 2 7 0 0 0 78 2 0 0 0 0 79 2 6
                                              0 80 0 81 1 0 0 0 82 2 7 0 16 0
                                              83 2 0 0 16 0 84 2 0 0 7 0 85 2 0
                                              0 0 7 86 2 0 0 0 0 87 2 6 0 0 16
                                              88 2 6 0 0 0 89 2 0 0 0 16 90 2 6
                                              0 10 7 91 2 0 0 0 10 92 2 9 0 10
                                              7 93 2 9 7 0 16 94 3 9 7 0 16 7
                                              95 2 0 9 0 9 96 2 8 0 10 7 97 2 8
                                              7 0 16 98 3 8 7 0 16 7 99 2 0 8 8
                                              0 100 1 6 0 0 101 3 6 7 0 16 16
                                              102 2 6 9 0 16 103 1 0 104 0 105
                                              1 6 0 34 106 2 107 0 7 10 108 1
                                              107 0 7 109 2 107 0 0 0 110 5 6 0
                                              0 16 16 16 16 111 1 107 10 0 112
                                              0 107 0 113 2 107 7 0 10 114 2 43
                                              0 0 10 115 1 6 13 0 116 2 107 7 0
                                              7 117 1 0 7 0 118 2 7 119 0 0 120
                                              2 0 119 0 7 121 2 7 0 0 0 122 2 0
                                              0 0 7 123 1 6 119 0 124 2 0 0 0
                                              16 125 1 0 13 0 40 2 0 0 10 10 31
                                              1 0 0 8 76 1 0 13 0 26 1 0 13 0
                                              14 2 0 0 10 7 42 2 0 0 0 16 90 3
                                              0 0 10 10 36 37 1 0 0 34 35 7 0
                                              51 0 16 52 53 10 10 54 56 1 0 0
                                              53 63 2 0 0 0 0 65 1 0 0 53 58 2
                                              0 0 0 0 60 2 0 119 0 7 121 1 0 0
                                              53 66 1 0 0 43 44 1 0 13 0 24 1 0
                                              104 0 105 1 0 0 9 71 1 0 13 0 28
                                              2 0 0 0 16 125 2 0 0 0 10 92 1 0
                                              7 0 118 2 0 0 0 7 123 1 0 0 0 82
                                              2 0 0 0 0 79 2 0 0 0 0 77 2 0 8 8
                                              0 100 2 0 0 0 7 86 2 0 9 0 9 96 2
                                              0 0 0 0 87 2 0 0 7 0 85 2 0 0 16
                                              0 84)))))
           '|lookupComplete|)) 

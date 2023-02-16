
(SDEFUN |MODOP;One;$;1| (($ ($)))
        (SPADCALL (|spadConstant| $ 13) (|spadConstant| $ 15) (QREFELT $ 16))) 

(SDEFUN |MODOP;coerce;I$;2| ((|n| (|Integer|)) ($ ($)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 18)) (QREFELT $ 19))) 

(SDEFUN |MODOP;coerce;R$;3| ((|r| (R)) ($ ($)))
        (COND ((SPADCALL |r| (QREFELT $ 22)) (|spadConstant| $ 23))
              ('T (SPADCALL |r| (|spadConstant| $ 15) (QREFELT $ 16))))) 

(SDEFUN |MODOP;coerce;Bo$;4| ((|op| (|BasicOperator|)) ($ ($)))
        (|MODOP;nocopy| (SPADCALL |op| (QREFELT $ 25)) $)) 

(SDEFUN |MODOP;nocopy| ((|op| (|BasicOperator|)) ($ ($)))
        (SPADCALL (|spadConstant| $ 13) (SPADCALL |op| (QREFELT $ 27))
                  (QREFELT $ 16))) 

(SDEFUN |MODOP;elt;$2M;6| ((|x| ($)) (|r| (M)) ($ (M)))
        (SPROG
         ((#1=#:G722 NIL) (#2=#:G721 (M)) (#3=#:G723 (M)) (#4=#:G728 NIL)
          (|t| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |t| NIL) (LETT #4# (SPADCALL |x| (QREFELT $ 31))) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |t| (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (SPADCALL (QCDR |t|)
                                   (|MODOP;termeval| (QCAR |t|) |r| $)
                                   (QREFELT $ 32)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 33))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 34))))))) 

(SDEFUN |MODOP;rmeval|
        ((|t|
          (|Record| (|:| |coef| R)
                    (|:| |monom| (|FreeGroup| (|BasicOperator|)))))
         (|r| (M)) ($ (M)))
        (SPADCALL (QCAR |t|) (|MODOP;monomeval| (QCDR |t|) |r| $)
                  (QREFELT $ 36))) 

(SDEFUN |MODOP;termcopy|
        ((|t|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
         ($
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|)))))))
        (SPROG ((#1=#:G736 NIL) (|rm| NIL) (#2=#:G735 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |rm| NIL) (LETT #1# |t|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |rm| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (CONS (QCAR |rm|) (QCDR |rm|)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |MODOP;characteristic;Nni;9| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 38))) 

(SDEFUN |MODOP;mkop| ((|r| (R)) (|fg| (|FreeGroup| (|BasicOperator|))) ($ ($)))
        (SPADCALL 1 (LIST (CONS |r| |fg|)) (QREFELT $ 41))) 

(SDEFUN |MODOP;evaluate;$M$;11| ((|f| ($)) (|g| (|Mapping| M M)) ($ ($)))
        (|MODOP;nocopy|
         (SPADCALL (SPADCALL |f| (QREFELT $ 42)) (QREFELT $ 10) |g|
                   (QREFELT $ 45))
         $)) 

(SDEFUN |MODOP;makeop;RFg$;12|
        ((|r| (R)) (|fg| (|FreeGroup| (|BasicOperator|))) ($ ($)))
        (COND
         ((SPADCALL |r| (|spadConstant| $ 48) (QREFELT $ 49))
          (|MODOP;mkop| |r| |fg| $))
         ('T
          (SPADCALL (|MODOP;mkop| (SPADCALL |r| (QREFELT $ 50)) |fg| $)
                    (QREFELT $ 51))))) 

(SDEFUN |MODOP;makeop;RFg$;13|
        ((|r| (R)) (|fg| (|FreeGroup| (|BasicOperator|))) ($ ($)))
        (|MODOP;mkop| |r| |fg| $)) 

(SDEFUN |MODOP;inv|
        ((|t|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| #1=(|FreeGroup| (|BasicOperator|))))))
         ($ ($)))
        (SPROG ((#2=#:G746 NIL) (|m| #1#) (|c| (R)))
               (SEQ
                (COND ((NULL |t|) (|spadConstant| $ 12))
                      ('T
                       (SEQ (LETT |c| (QCAR (|SPADfirst| |t|)))
                            (LETT |m| (QCDR (|SPADfirst| |t|)))
                            (EXIT
                             (SPADCALL
                              (SPADCALL (|MODOP;inv| (CDR |t|) $)
                                        (SPADCALL (|spadConstant| $ 13)
                                                  (SPADCALL |m| (QREFELT $ 52))
                                                  (QREFELT $ 16))
                                        (QREFELT $ 53))
                              (SPADCALL
                               (PROG2 (LETT #2# (SPADCALL |c| (QREFELT $ 55)))
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 0) (QREFELT $ 6)
                                                 (|Union| (QREFELT $ 6)
                                                          "failed")
                                                 #2#))
                               (QREFELT $ 19))
                              (QREFELT $ 53))))))))) 

(SDEFUN |MODOP;^;$I$;15| ((|x| ($)) (|i| (|Integer|)) ($ ($)))
        (COND ((EQL |i| 0) (|spadConstant| $ 12))
              ((> |i| 0) (SPADCALL |x| |i| (QREFELT $ 58)))
              ('T
               (SPADCALL (|MODOP;inv| (SPADCALL |x| (QREFELT $ 59)) $) (- |i|)
                         (QREFELT $ 60))))) 

(SDEFUN |MODOP;evaluateInverse;$M$;16|
        ((|f| ($)) (|g| (|Mapping| M M)) ($ ($)))
        (|MODOP;nocopy|
         (SPADCALL (SPADCALL |f| (QREFELT $ 42)) (QREFELT $ 11) |g|
                   (QREFELT $ 45))
         $)) 

(SDEFUN |MODOP;coerce;$Of;17| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G763 NIL) (|t| NIL) (#2=#:G762 NIL))
               (SEQ
                (COND
                 ((SPADCALL |x| (QREFELT $ 62))
                  (SPADCALL (|spadConstant| $ 48) (QREFELT $ 64)))
                 ('T
                  (SPADCALL (ELT $ 65)
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |t| NIL)
                                  (LETT #1# (SPADCALL |x| (QREFELT $ 31))) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |t| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS
                                           (|MODOP;trm2O| (QCDR |t|) (QCAR |t|)
                                            $)
                                           #2#))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            (QREFELT $ 68))))))) 

(SDEFUN |MODOP;trm2O|
        ((|c| (|Integer|))
         (|t|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
         ($ (|OutputForm|)))
        (COND ((EQL |c| 1) (|MODOP;term2O| |t| $))
              ((EQL |c| -1) (SPADCALL (|MODOP;term2O| |t| $) (QREFELT $ 70)))
              ('T
               (SPADCALL (SPADCALL |c| (QREFELT $ 71)) (|MODOP;term2O| |t| $)
                         (QREFELT $ 72))))) 

(SDEFUN |MODOP;term2O|
        ((|t|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
         ($ (|OutputForm|)))
        (SPROG ((#1=#:G774 NIL) (|rm| NIL) (#2=#:G773 NIL))
               (SEQ
                (SPADCALL (ELT $ 72)
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |rm| NIL) (LETT #1# |t|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |rm| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (|MODOP;rm2O| (QCAR |rm|) (QCDR |rm|)
                                          $)
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 68))))) 

(SDEFUN |MODOP;rm2O|
        ((|c| (R)) (|m| (|FreeGroup| (|BasicOperator|))) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |c| (|spadConstant| $ 13) (QREFELT $ 73))
          (SPADCALL |m| (QREFELT $ 74)))
         ((SPADCALL |m| (|spadConstant| $ 15) (QREFELT $ 75))
          (SPADCALL |c| (QREFELT $ 64)))
         ('T
          (SPADCALL (SPADCALL |c| (QREFELT $ 64)) (SPADCALL |m| (QREFELT $ 74))
                    (QREFELT $ 72))))) 

(SDEFUN |MODOP;*;3$;21| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((#1=#:G778 NIL) (#2=#:G777 ($)) (#3=#:G779 ($)) (#4=#:G781 NIL)
          (#5=#:G780 ($)) (#6=#:G782 ($)) (#7=#:G786 NIL) (|s| NIL)
          (#8=#:G785 NIL) (|t| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |t| NIL) (LETT #8# (SPADCALL |x| (QREFELT $ 31))) G190
                (COND
                 ((OR (ATOM #8#) (PROGN (LETT |t| (CAR #8#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (PROGN
                          (LETT #4# NIL)
                          (SEQ (LETT |s| NIL)
                               (LETT #7# (SPADCALL |y| (QREFELT $ 31))) G190
                               (COND
                                ((OR (ATOM #7#)
                                     (PROGN (LETT |s| (CAR #7#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (PROGN
                                  (LETT #6#
                                        (|MODOP;termprod0|
                                         (* (QCDR |t|) (QCDR |s|)) (QCAR |t|)
                                         (QCAR |s|) $))
                                  (COND
                                   (#4#
                                    (LETT #5#
                                          (SPADCALL #5# #6# (QREFELT $ 76))))
                                   ('T
                                    (PROGN (LETT #5# #6#) (LETT #4# 'T)))))))
                               (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                          (COND (#4# #5#) ('T (|spadConstant| $ 23)))))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 76))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 23))))))) 

(SDEFUN |MODOP;termprod0|
        ((|n| (|Integer|))
         (|x|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
         (|y|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
         ($ ($)))
        (COND
         ((>= |n| 0)
          (SPADCALL 1 (|MODOP;termprod| |n| |x| |y| $) (QREFELT $ 41)))
         ('T
          (SPADCALL
           (SPADCALL 1 (|MODOP;termprod| (- |n|) |x| |y| $) (QREFELT $ 41))
           (QREFELT $ 51))))) 

(SDEFUN |MODOP;termprod|
        ((|n| (|Integer|))
         (|x|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
         (|y|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
         ($
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|)))))))
        (SPROG
         ((|rm|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|)))))
          (|lc|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|)))))
          (|xx|
           (|List|
            (|Record| (|:| |coef| R)
                      (|:| |monom| (|FreeGroup| (|BasicOperator|)))))))
         (SEQ (LETT |lc| (|SPADfirst| (LETT |xx| (|MODOP;termcopy| |x| $))))
              (PROGN
               (RPLACA |lc| (SPADCALL |n| (QCAR |lc|) (QREFELT $ 77)))
               (QCAR |lc|))
              (LETT |rm| (SPADCALL |xx| (QREFELT $ 78)))
              (EXIT
               (COND
                ((SPADCALL (QCAR (|SPADfirst| |y|)) (|spadConstant| $ 13)
                           (QREFELT $ 73))
                 (SEQ
                  (PROGN
                   (RPLACD |rm|
                           (SPADCALL (QCDR |rm|) (QCDR (|SPADfirst| |y|))
                                     (QREFELT $ 79)))
                   (QCDR |rm|))
                  (EXIT
                   (SPADCALL |xx| (|MODOP;termcopy| (CDR |y|) $)
                             (QREFELT $ 80)))))
                ((SPADCALL (QCDR |rm|) (|spadConstant| $ 15) (QREFELT $ 75))
                 (SEQ
                  (PROGN
                   (RPLACA |rm|
                           (SPADCALL (QCAR |rm|) (QCAR (|SPADfirst| |y|))
                                     (QREFELT $ 81)))
                   (QCAR |rm|))
                  (PROGN (RPLACD |rm| (QCDR (|SPADfirst| |y|))) (QCDR |rm|))
                  (EXIT
                   (SPADCALL |xx| (|MODOP;termcopy| (CDR |y|) $)
                             (QREFELT $ 80)))))
                ('T
                 (SPADCALL |xx| (|MODOP;termcopy| |y| $) (QREFELT $ 80)))))))) 

(SDEFUN |MODOP;opeval;Bo2M;24| ((|op| (|BasicOperator|)) (|r| (M)) ($ (M)))
        (SPROG ((|func| (|Union| (|None|) "failed")))
               (SEQ (LETT |func| (SPADCALL |op| (QREFELT $ 10) (QREFELT $ 83)))
                    (EXIT
                     (COND
                      ((QEQCAR |func| 1) (SPADCALL |op| |r| (QREFELT $ 84)))
                      ('T (SPADCALL |r| (QCDR |func|)))))))) 

(SDEFUN |MODOP;opeval;Bo2M;25| ((|op| (|BasicOperator|)) (|r| (M)) ($ (M)))
        (SPROG ((|func| (|Union| (|None|) "failed")))
               (SEQ (LETT |func| (SPADCALL |op| (QREFELT $ 10) (QREFELT $ 83)))
                    (EXIT
                     (COND
                      ((QEQCAR |func| 1)
                       (|error| "eval: operator has no evaluation function"))
                      ('T (SPADCALL |r| (QCDR |func|)))))))) 

(SDEFUN |MODOP;opInvEval| ((|op| (|BasicOperator|)) (|r| (M)) ($ (M)))
        (SPROG ((|func| (|Union| (|None|) "failed")))
               (SEQ (LETT |func| (SPADCALL |op| (QREFELT $ 11) (QREFELT $ 83)))
                    (EXIT
                     (COND
                      ((QEQCAR |func| 1)
                       (|error|
                        "eval: operator has no inverse evaluation function"))
                      ('T (SPADCALL |r| (QCDR |func|)))))))) 

(SDEFUN |MODOP;termeval|
        ((|t|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
         (|r| (M)) ($ (M)))
        (SPROG ((#1=#:G821 NIL) (|rm| NIL))
               (SEQ
                (SEQ (LETT |rm| NIL) (LETT #1# (REVERSE |t|)) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |rm| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT |r| (|MODOP;rmeval| |rm| |r| $))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |r|)))) 

(SDEFUN |MODOP;monomeval|
        ((|m| (|FreeGroup| (|BasicOperator|))) (|r| (M)) ($ (M)))
        (SPROG
         ((#1=#:G838 NIL) (|i| NIL) (#2=#:G837 NIL) (|g| (|BasicOperator|))
          (|e| (|Integer|)) (#3=#:G836 NIL) (|rec| NIL))
         (SEQ
          (SEQ (LETT |rec| NIL)
               (LETT #3# (NREVERSE (SPADCALL |m| (QREFELT $ 88)))) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |rec| (CAR #3#)) NIL)) (GO G191)))
               (SEQ (LETT |e| (QCDR |rec|)) (LETT |g| (QCAR |rec|))
                    (EXIT
                     (COND
                      ((> |e| 0)
                       (SEQ (LETT |i| 1) (LETT #2# |e|) G190
                            (COND ((|greater_SI| |i| #2#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |r| (SPADCALL |g| |r| (QREFELT $ 85)))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL)))
                      ((< |e| 0)
                       (SEQ (LETT |i| 1) (LETT #1# (- |e|)) G190
                            (COND ((|greater_SI| |i| #1#) (GO G191)))
                            (SEQ
                             (EXIT (LETT |r| (|MODOP;opInvEval| |g| |r| $))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT |r|)))) 

(SDEFUN |MODOP;recip;$U;29| ((|x| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|r1| (|Union| R #1#)) (|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 90)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                           (#2='T
                            (SEQ
                             (LETT |r1| (SPADCALL (QCDR |r|) (QREFELT $ 55)))
                             (EXIT
                              (COND ((QEQCAR |r1| 1) (CONS 1 "failed"))
                                    (#2#
                                     (CONS 0
                                           (SPADCALL (QCDR |r1|)
                                                     (QREFELT $ 19))))))))))))) 

(SDEFUN |MODOP;retractIfCan;$U;30| ((|x| ($)) ($ (|Union| R "failed")))
        (SPROG
         ((|rm|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|)))))
          (|t|
           (|List|
            (|Record| (|:| |coef| R)
                      (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
          (|r|
           (|Union|
            (|List|
             (|Record| (|:| |coef| R)
                       (|:| |monom| (|FreeGroup| (|BasicOperator|)))))
            "failed")))
         (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 93)))
              (EXIT
               (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                     ((NULL (LETT |t| (QCDR |r|)))
                      (CONS 0 (|spadConstant| $ 48)))
                     ((NULL (CDR |t|))
                      (SEQ (LETT |rm| (|SPADfirst| |t|))
                           (EXIT
                            (COND
                             ((SPADCALL (QCDR |rm|) (|spadConstant| $ 15)
                                        (QREFELT $ 75))
                              (CONS 0 (QCAR |rm|)))
                             (#1='T (CONS 1 "failed"))))))
                     (#1# (CONS 1 "failed"))))))) 

(SDEFUN |MODOP;retractIfCan;$U;31|
        ((|x| ($)) ($ (|Union| (|BasicOperator|) "failed")))
        (SPROG
         ((|rm|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|)))))
          (|t|
           (|List|
            (|Record| (|:| |coef| R)
                      (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
          (|r|
           (|Union|
            (|List|
             (|Record| (|:| |coef| R)
                       (|:| |monom| (|FreeGroup| (|BasicOperator|)))))
            "failed")))
         (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 93)))
              (EXIT
               (COND
                ((OR (QEQCAR |r| 1)
                     (OR (NULL (LETT |t| (QCDR |r|))) (NULL (NULL (CDR |t|)))))
                 (CONS 1 "failed"))
                ('T
                 (SEQ (LETT |rm| (|SPADfirst| |t|))
                      (EXIT
                       (COND
                        ((SPADCALL (QCAR |rm|) (|spadConstant| $ 13)
                                   (QREFELT $ 73))
                         (SPADCALL (QCDR |rm|) (QREFELT $ 95)))
                        ('T (CONS 1 "failed"))))))))))) 

(SDEFUN |MODOP;*;R2$;32| ((|r| (R)) (|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 19)) |x| (QREFELT $ 53))) 

(SDEFUN |MODOP;*;$R$;33| ((|x| ($)) (|r| (R)) ($ ($)))
        (SPADCALL |x| (SPADCALL |r| (QREFELT $ 19)) (QREFELT $ 53))) 

(SDEFUN |MODOP;adjoint;2$;34| ((|x| ($)) ($ ($)))
        (SPROG
         ((#1=#:G876 NIL) (#2=#:G875 ($)) (#3=#:G877 ($)) (#4=#:G880 NIL)
          (|t| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |t| NIL) (LETT #4# (SPADCALL |x| (QREFELT $ 31))) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |t| (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (SPADCALL (QCDR |t|) (|MODOP;termadj| (QCAR |t|) $)
                                   (QREFELT $ 99)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 76))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 23))))))) 

(SDEFUN |MODOP;rmadj|
        ((|t|
          (|Record| (|:| |coef| R)
                    (|:| |monom| (|FreeGroup| (|BasicOperator|)))))
         ($ ($)))
        (SPADCALL (SPADCALL (QCAR |t|) (QREFELT $ 101))
                  (|MODOP;monomadj| (QCDR |t|) $) (QREFELT $ 97))) 

(SDEFUN |MODOP;adjoint;3$;36| ((|op| ($)) (|adj| ($)) ($ ($)))
        (|MODOP;nocopy|
         (SPADCALL (SPADCALL |op| (QREFELT $ 42)) (QREFELT $ 9)
                   (SPADCALL |adj| (QREFELT $ 103)) (QREFELT $ 45))
         $)) 

(SDEFUN |MODOP;termadj|
        ((|t|
          (|List|
           (|Record| (|:| |coef| R)
                     (|:| |monom| (|FreeGroup| (|BasicOperator|))))))
         ($ ($)))
        (SPROG ((|ans| ($)) (#1=#:G889 NIL) (|rm| NIL))
               (SEQ (LETT |ans| (|spadConstant| $ 12))
                    (SEQ (LETT |rm| NIL) (LETT #1# |t|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |rm| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |ans|
                                 (SPADCALL (|MODOP;rmadj| |rm| $) |ans|
                                           (QREFELT $ 53)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |MODOP;monomadj| ((|m| (|FreeGroup| (|BasicOperator|))) ($ ($)))
        (SPROG ((|ans| ($)) (#1=#:G895 NIL) (|rec| NIL))
               (SEQ (LETT |ans| (|spadConstant| $ 12))
                    (SEQ (LETT |rec| NIL)
                         (LETT #1# (SPADCALL |m| (QREFELT $ 88))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |ans|
                                 (SPADCALL
                                  (SPADCALL (|MODOP;opadj| (QCAR |rec|) $)
                                            (QCDR |rec|) (QREFELT $ 60))
                                  |ans| (QREFELT $ 53)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |MODOP;opadj| ((|op| (|BasicOperator|)) ($ ($)))
        (SPROG ((|adj| (|Union| (|None|) "failed")))
               (SEQ (LETT |adj| (SPADCALL |op| (QREFELT $ 9) (QREFELT $ 83)))
                    (EXIT
                     (COND
                      ((QEQCAR |adj| 1)
                       (|error|
                        "adjoint: operator does not have a defined adjoint"))
                      ('T (QCDR |adj|))))))) 

(SDEFUN |MODOP;conjug;2R;40| ((|r| (R)) ($ (R))) (SPADCALL |r| (QREFELT $ 105))) 

(PUT '|MODOP;conjug;2R;41| '|SPADreplace| '(XLAM (|r|) |r|)) 

(SDEFUN |MODOP;conjug;2R;41| ((|r| (R)) ($ (R))) |r|) 

(DECLAIM (NOTINLINE |ModuleOperator;|)) 

(DEFUN |ModuleOperator| (&REST #1=#:G903)
  (SPROG NIL
         (PROG (#2=#:G904)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ModuleOperator|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ModuleOperator;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ModuleOperator|)))))))))) 

(DEFUN |ModuleOperator;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ModuleOperator| DV$1 DV$2))
          (LETT $ (GETREFV 109))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|))
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicZero|))))))
          (|haddProp| |$ConstructorCache| '|ModuleOperator| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8
                    (|FreeModule| (|Integer|)
                                  (|List|
                                   (|Record| (|:| |coef| |#1|)
                                             (|:| |monom|
                                                  (|FreeGroup|
                                                   (|BasicOperator|)))))))
          (QSETREFV $ 9 '|%opAdjoint|)
          (QSETREFV $ 10 '|%opEval|)
          (QSETREFV $ 11 '|%invEval|)
          (COND
           ((|HasCategory| |#1| '(|OrderedSet|))
            (QSETREFV $ 16
                      (CONS (|dispatchFunction| |MODOP;makeop;RFg$;12|) $)))
           ('T
            (QSETREFV $ 16
                      (CONS (|dispatchFunction| |MODOP;makeop;RFg$;13|) $))))
          (COND
           ((|HasCategory| |#2| '(|ExpressionSpace|))
            (QSETREFV $ 85
                      (CONS (|dispatchFunction| |MODOP;opeval;Bo2M;24|) $)))
           ('T
            (QSETREFV $ 85
                      (CONS (|dispatchFunction| |MODOP;opeval;Bo2M;25|) $))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 97 (CONS (|dispatchFunction| |MODOP;*;R2$;32|) $))
             (QSETREFV $ 98 (CONS (|dispatchFunction| |MODOP;*;$R$;33|) $))
             (QSETREFV $ 100
                       (CONS (|dispatchFunction| |MODOP;adjoint;2$;34|) $))
             (QSETREFV $ 104
                       (CONS (|dispatchFunction| |MODOP;adjoint;3$;36|) $))
             (COND
              ((|HasSignature| |#1|
                               (LIST '|conjugate|
                                     (LIST (|devaluate| |#1|)
                                           (|devaluate| |#1|))))
               (QSETREFV $ 101
                         (CONS (|dispatchFunction| |MODOP;conjug;2R;40|) $)))
              ('T
               (QSETREFV $ 101
                         (CONS (|dispatchFunction| |MODOP;conjug;2R;41|)
                               $)))))))
          $))) 

(MAKEPROP '|ModuleOperator| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|FreeModule| 17 40) (|local| |#1|)
              (|local| |#2|) '|Rep| 'OPADJ 'OPEVAL 'INVEVAL
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |MODOP;One;$;1|) $))
              (0 . |One|) (|FreeGroup| 24) (4 . |One|) (8 . |makeop|)
              (|Integer|) (14 . |coerce|) |MODOP;coerce;R$;3|
              |MODOP;coerce;I$;2| (|Boolean|) (19 . |zero?|) (24 . |Zero|)
              (|BasicOperator|) (28 . |copy|) |MODOP;coerce;Bo$;4|
              (33 . |coerce|) (|Record| (|:| |coef| 6) (|:| |monom| 14))
              (|Record| (|:| |k| 40) (|:| |c| 17)) (|List| 29)
              (38 . |listOfTerms|) (43 . *) (49 . +) (55 . |Zero|)
              |MODOP;elt;$2M;6| (59 . *) (|NonNegativeInteger|)
              (65 . |characteristic|) |MODOP;characteristic;Nni;9| (|List| 28)
              (69 . |monomial|) (75 . |retract|) (|Symbol|) (|None|)
              (80 . |setProperty|) (|Mapping| 7 7) |MODOP;evaluate;$M$;11|
              (87 . |Zero|) (91 . >=) (97 . -) (102 . -) (107 . |inv|)
              |MODOP;*;3$;21| (|Union| $ '"failed") (112 . |recip|)
              (|PositiveInteger|) (|RepeatedSquaring| $$) (117 . |expt|)
              (123 . |retract|) |MODOP;^;$I$;15| |MODOP;evaluateInverse;$M$;16|
              (128 . |zero?|) (|OutputForm|) (133 . |coerce|) (138 . +)
              (|Mapping| 63 63 63) (|List| 63) (144 . |reduce|)
              |MODOP;coerce;$Of;17| (150 . -) (155 . |coerce|) (160 . *)
              (166 . =) (172 . |coerce|) (177 . =) (183 . +) (189 . *)
              (195 . |last|) (200 . *) (206 . |concat!|) (212 . *)
              (|Union| 44 '"failed") (218 . |property|) (224 . |kernel|)
              (230 . |opeval|) (|Record| (|:| |gen| 24) (|:| |exp| 17))
              (|List| 86) (236 . |factors|) (|Union| 6 '"failed")
              |MODOP;retractIfCan;$U;30| |MODOP;recip;$U;29|
              (|Union| 40 '"failed") (241 . |retractIfCan|)
              (|Union| 24 '"failed") (246 . |retractIfCan|)
              |MODOP;retractIfCan;$U;31| (251 . *) (257 . *) (263 . *)
              (269 . |adjoint|) (274 . |conjug|) (|NoneFunctions1| $$)
              (279 . |coerce|) (284 . |adjoint|) (290 . |conjugate|)
              (|HashState|) (|String|) (|SingleInteger|))
           '#(~= 295 |zero?| 301 |subtractIfCan| 306 |sample| 312 |rightRecip|
              316 |rightPower| 321 |retractIfCan| 333 |retract| 343 |recip| 353
              |opposite?| 358 |opeval| 364 |one?| 370 |makeop| 375 |leftRecip|
              381 |leftPower| 386 |latex| 398 |hashUpdate!| 403 |hash| 409
              |evaluateInverse| 414 |evaluate| 420 |elt| 426 |conjug| 432
              |commutator| 437 |coerce| 443 |charthRoot| 463 |characteristic|
              468 |associator| 472 |antiCommutator| 479 |annihilate?| 485
              |adjoint| 491 ^ 502 |Zero| 520 |One| 524 = 528 - 534 + 545 * 551)
           'NIL
           (CONS
            (|makeByteWordVec2| 3
                                '(1 2 3 0 0 0 0 1 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|Algebra&| NIL NIL NIL |Rng&| NIL NIL |Module&|
                |NonAssociativeRing&| NIL NIL |NonAssociativeRng&| NIL NIL NIL
                NIL |AbelianGroup&| NIL NIL NIL NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| |Magma&|
                |AbelianSemiGroup&| |RetractableTo&| |RetractableTo&|
                |SetCategory&| NIL NIL NIL NIL |BasicType&| NIL)
             (CONS
              '#((|Algebra| 6) (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|Ring|) (|Rng|) (|SemiRing|) (|SemiRng|) (|Module| 6)
                 (|NonAssociativeRing|) (|BiModule| $$ $$) (|BiModule| 6 6)
                 (|NonAssociativeRng|) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 6) (|RightModule| 6) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Magma|) (|AbelianSemiGroup|)
                 (|RetractableTo| 24) (|RetractableTo| 6) (|SetCategory|)
                 (|Eltable| 7 7) (|CoercibleFrom| 24) (|CoercibleFrom| 6)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 63))
              (|makeByteWordVec2| 108
                                  '(0 6 0 13 0 14 0 15 2 0 0 6 14 16 1 6 0 17
                                    18 1 6 21 0 22 0 0 0 23 1 24 0 0 25 1 14 0
                                    24 27 1 8 30 0 31 2 7 0 17 0 32 2 7 0 0 0
                                    33 0 7 0 34 2 7 0 6 0 36 0 6 37 38 2 5 0 17
                                    40 41 1 0 24 0 42 3 24 0 0 43 44 45 0 6 0
                                    48 2 6 21 0 0 49 1 6 0 0 50 1 0 0 0 51 1 14
                                    0 0 52 1 6 54 0 55 2 57 2 2 56 58 1 8 40 0
                                    59 1 0 21 0 62 1 6 63 0 64 2 63 0 0 0 65 2
                                    67 63 66 0 68 1 63 0 0 70 1 17 63 0 71 2 63
                                    0 0 0 72 2 6 21 0 0 73 1 14 63 0 74 2 14 21
                                    0 0 75 2 0 0 0 0 76 2 6 0 17 0 77 1 40 28 0
                                    78 2 14 0 0 0 79 2 40 0 0 0 80 2 6 0 0 0 81
                                    2 24 82 0 43 83 2 7 0 24 0 84 2 0 7 24 7 85
                                    1 14 87 0 88 1 8 92 0 93 1 14 94 0 95 2 0 0
                                    6 0 97 2 0 0 0 6 98 2 0 0 17 0 99 1 0 0 0
                                    100 1 0 6 6 101 1 102 44 2 103 2 0 0 0 0
                                    104 1 6 0 0 105 2 0 21 0 0 1 1 0 21 0 62 2
                                    0 54 0 0 1 0 0 0 1 1 0 54 0 1 2 0 0 0 37 1
                                    2 0 0 0 56 1 1 0 94 0 96 1 0 89 0 90 1 0 24
                                    0 42 1 0 6 0 1 1 0 54 0 91 2 0 21 0 0 1 2 0
                                    7 24 7 85 1 0 21 0 1 2 0 0 6 14 16 1 0 54 0
                                    1 2 0 0 0 37 1 2 0 0 0 56 1 1 0 107 0 1 2 0
                                    106 106 0 1 1 0 108 0 1 2 0 0 0 46 61 2 0 0
                                    0 46 47 2 0 7 0 7 35 1 1 6 6 101 2 0 0 0 0
                                    1 1 0 0 24 26 1 0 0 6 19 1 0 0 17 20 1 0 63
                                    0 69 1 2 54 0 1 0 0 37 39 3 0 0 0 0 0 1 2 0
                                    0 0 0 1 2 0 21 0 0 1 2 1 0 0 0 104 1 1 0 0
                                    100 2 0 0 0 17 60 2 0 0 0 37 1 2 0 0 0 56 1
                                    0 0 0 23 0 0 0 12 2 0 21 0 0 1 2 0 0 0 0 1
                                    1 0 0 0 51 2 0 0 0 0 76 2 1 0 6 0 97 2 1 0
                                    0 6 98 2 0 0 37 0 1 2 0 0 17 0 99 2 0 0 0 0
                                    53 2 0 0 56 0 1)))))
           '|lookupComplete|)) 


(SDEFUN |ODEEF;solve;EBoSU;1|
        ((|diffeq| (|Equation| F)) (|y| (|BasicOperator|)) (|x| (|Symbol|))
         ($
          (|Union| (|Record| (|:| |particular| F) (|:| |basis| (|List| F))) F
                   "failed")))
        (SPADCALL
         (SPADCALL (SPADCALL |diffeq| (QREFELT $ 9))
                   (SPADCALL |diffeq| (QREFELT $ 10)) (QREFELT $ 11))
         |y| |x| (QREFELT $ 16))) 

(SDEFUN |ODEEF;solve;LLSU;2|
        ((|leq| (|List| (|Equation| F))) (|lop| (|List| (|BasicOperator|)))
         (|x| (|Symbol|))
         ($
          (|Union|
           (|Record| (|:| |particular| (|Vector| F))
                     (|:| |basis| (|List| (|Vector| F))))
           "failed")))
        (SPROG ((#1=#:G724 NIL) (|eq| NIL) (#2=#:G723 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |eq| NIL) (LETT #1# |leq|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |eq| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |eq| (QREFELT $ 9))
                                          (SPADCALL |eq| (QREFELT $ 10))
                                          (QREFELT $ 11))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 |lop| |x| (QREFELT $ 22))))) 

(SDEFUN |ODEEF;solve;EBoELU;3|
        ((|diffeq| (|Equation| F)) (|y| (|BasicOperator|))
         (|center| (|Equation| F)) (|y0| (|List| F)) ($ (|Union| F "failed")))
        (SPADCALL
         (SPADCALL (SPADCALL |diffeq| (QREFELT $ 9))
                   (SPADCALL |diffeq| (QREFELT $ 10)) (QREFELT $ 11))
         |y| |center| |y0| (QREFELT $ 26))) 

(SDEFUN |ODEEF;solve;MSU;4|
        ((|m| (|Matrix| F)) (|x| (|Symbol|))
         ($ (|Union| (|List| (|Vector| F)) "failed")))
        (SPROG
         ((|u|
           (|Union|
            (|Record| (|:| |particular| (|Vector| F))
                      (|:| |basis| (|List| (|Vector| F))))
            "failed")))
         (SEQ
          (LETT |u|
                (SPADCALL |m| (MAKEARR1 (ANROWS |m|) (|spadConstant| $ 28)) |x|
                          (QREFELT $ 31)))
          (EXIT
           (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                 ('T (CONS 0 (QCDR (QCDR |u|))))))))) 

(SDEFUN |ODEEF;solve;MVSU;5|
        ((|m| (|Matrix| F)) (|v| (|Vector| F)) (|x| (|Symbol|))
         ($
          (|Union|
           (|Record| (|:| |particular| (|Vector| F))
                     (|:| |basis| (|List| (|Vector| F))))
           "failed")))
        (SPROG
         ((#1=#:G770 NIL) (|i| NIL) (#2=#:G769 NIL)
          (|rec|
           (|Record| (|:| |particular| (|Vector| F))
                     (|:| |basis| (|Matrix| F))))
          (|uu|
           (|Union|
            (|Record| (|:| |particular| (|Vector| F))
                      (|:| |basis| (|Matrix| F)))
            #3="failed"))
          (|Lx| (|LinearOrdinaryDifferentialOperatorCategory| F)))
         (SEQ
          (LETT |Lx|
                (|LinearOrdinaryDifferentialOperator| (QREFELT $ 7)
                                                      (SPADCALL |x|
                                                                (QREFELT $
                                                                         36))))
          (LETT |uu|
                (SPADCALL |m| |v|
                          (CONS #'|ODEEF;solve;MVSU;5!0| (VECTOR |Lx| $ |x|))
                          (|compiledLookupCheck| '|solve|
                                                 (LIST
                                                  (LIST '|Union|
                                                        (LIST '|Record|
                                                              (LIST '|:|
                                                                    '|particular|
                                                                    (LIST
                                                                     '|Vector|
                                                                     (|devaluate|
                                                                      (ELT $
                                                                           7))))
                                                              (LIST '|:|
                                                                    '|basis|
                                                                    (LIST
                                                                     '|Matrix|
                                                                     (|devaluate|
                                                                      (ELT $
                                                                           7)))))
                                                        '#3#)
                                                  (LIST '|Matrix|
                                                        (|devaluate|
                                                         (ELT $ 7)))
                                                  (LIST '|Vector|
                                                        (|devaluate|
                                                         (ELT $ 7)))
                                                  (LIST '|Mapping|
                                                        (LIST '|Union|
                                                              (LIST '|Record|
                                                                    (LIST '|:|
                                                                          '|particular|
                                                                          (|devaluate|
                                                                           (ELT
                                                                            $
                                                                            7)))
                                                                    (LIST '|:|
                                                                          '|basis|
                                                                          (LIST
                                                                           '|List|
                                                                           (|devaluate|
                                                                            (ELT
                                                                             $
                                                                             7)))))
                                                              '"failed")
                                                        (|devaluate| |Lx|)
                                                        (|devaluate|
                                                         (ELT $ 7))))
                                                 (|SystemODESolver| (ELT $ 7)
                                                                    |Lx|))))
          (EXIT
           (COND ((QEQCAR |uu| 1) (CONS 1 "failed"))
                 ('T
                  (SEQ (LETT |rec| (QCDR |uu|))
                       (EXIT
                        (CONS 0
                              (CONS (QCAR |rec|)
                                    (PROGN
                                     (LETT #2# NIL)
                                     (SEQ (LETT |i| 1)
                                          (LETT #1# (ANCOLS (QCDR |rec|))) G190
                                          (COND
                                           ((|greater_SI| |i| #1#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #2#
                                                  (CONS
                                                   (SPADCALL (QCDR |rec|) |i|
                                                             (QREFELT $ 38))
                                                   #2#))))
                                          (LETT |i| (|inc_SI| |i|)) (GO G190)
                                          G191 (EXIT (NREVERSE #2#)))))))))))))) 

(SDEFUN |ODEEF;solve;MVSU;5!0| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|x| $ |Lx|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |Lx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |z1| |z2| |x|
                      (|compiledLookupCheck| '|solve|
                                             (LIST
                                              (LIST '|Union|
                                                    (LIST '|Record|
                                                          (LIST '|:|
                                                                '|particular|
                                                                (|devaluate|
                                                                 (ELT $ 7)))
                                                          (LIST '|:| '|basis|
                                                                (LIST '|List|
                                                                      (|devaluate|
                                                                       (ELT $
                                                                            7)))))
                                                    '"failed")
                                              (|devaluate| |Lx|)
                                              (|devaluate| (ELT $ 7))
                                              (LIST '|Symbol|))
                                             (|ElementaryFunctionLODESolver|
                                              (ELT $ 6) (ELT $ 7) |Lx|))))))) 

(SDEFUN |ODEEF;solve;FBoELU;6|
        ((|diffeq| (F)) (|y| (|BasicOperator|)) (|center| (|Equation| F))
         (|y0| (|List| F)) ($ (|Union| F "failed")))
        (SPROG
         ((|p| #1=(|SparseUnivariatePolynomial| F)) (|op| (|Lx|))
          (|Lx| (|LinearOrdinaryDifferentialOperatorCategory| F))
          (|rec|
           (|Record| (|:| |left| (|SparseUnivariatePolynomial| F))
                     (|:| |right| F)))
          (|u| (|Union| F "failed"))
          (|rc| (|Record| (|:| |dx| F) (|:| |dy| F)))
          (|ur|
           (|Union| (|Record| (|:| |left| #1#) (|:| |right| F))
                    (|Record| (|:| |dx| F) (|:| |dy| F))))
          (|kx| (|Kernel| F)) (|x| (|Symbol|)) (|a| (F)))
         (SEQ (LETT |a| (SPADCALL |center| (QREFELT $ 10)))
              (LETT |kx|
                    (SPADCALL
                     (LETT |x|
                           (SPADCALL (SPADCALL |center| (QREFELT $ 9))
                                     (QREFELT $ 39)))
                     (QREFELT $ 41)))
              (LETT |ur| (|ODEEF;parseODE| |diffeq| |y| |x| $))
              (EXIT
               (COND
                ((QEQCAR |ur| 1)
                 (COND
                  ((NULL (EQL (LENGTH |y0|) 1))
                   (|error| "solve: more than one initial condition!"))
                  ('T
                   (SEQ (LETT |rc| (QCDR |ur|))
                        (LETT |u|
                              (SPADCALL (QCAR |rc|) (QCDR |rc|) |y| |x|
                                        (QREFELT $ 44)))
                        (EXIT
                         (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                               (#2='T
                                (CONS 0
                                      (SPADCALL (QCDR |u|)
                                                (SPADCALL (QCDR |u|)
                                                          (LIST |kx|
                                                                (SPADCALL
                                                                 (SPADCALL |y|
                                                                           (SPADCALL
                                                                            |x|
                                                                            (QREFELT
                                                                             $
                                                                             45))
                                                                           (QREFELT
                                                                            $
                                                                            46))
                                                                 (QREFELT $
                                                                          48)))
                                                          (LIST |a|
                                                                (|SPADfirst|
                                                                 |y0|))
                                                          (QREFELT $ 51))
                                                (QREFELT $ 11))))))))))
                (#2#
                 (SEQ (LETT |rec| (QCDR |ur|)) (LETT |p| (QCAR |rec|))
                      (LETT |Lx|
                            (|LinearOrdinaryDifferentialOperator| (QREFELT $ 7)
                                                                  (SPADCALL |x|
                                                                            (QREFELT
                                                                             $
                                                                             36))))
                      (LETT |op|
                            (SPADCALL
                             (|compiledLookupCheck| '|Zero| (LIST '$) |Lx|)))
                      (SEQ G190
                           (COND
                            ((NULL
                              (SPADCALL |p| (|spadConstant| $ 54)
                                        (QREFELT $ 56)))
                             (GO G191)))
                           (SEQ
                            (LETT |op|
                                  (SPADCALL |op|
                                            (SPADCALL
                                             (SPADCALL |p| (QREFELT $ 57))
                                             (SPADCALL |p| (QREFELT $ 59))
                                             (|compiledLookupCheck| '|monomial|
                                                                    (LIST '$
                                                                          (|devaluate|
                                                                           (ELT
                                                                            $
                                                                            7))
                                                                          (LIST
                                                                           '|NonNegativeInteger|))
                                                                    |Lx|))
                                            (|compiledLookupCheck| '+
                                                                   (LIST '$ '$
                                                                         '$)
                                                                   |Lx|)))
                            (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 60)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (SPADCALL |op| (QCDR |rec|) |x| |a| |y0|
                                 (|compiledLookupCheck| '|solve|
                                                        (LIST
                                                         (LIST '|Union|
                                                               (|devaluate|
                                                                (ELT $ 7))
                                                               '"failed")
                                                         (|devaluate| |Lx|)
                                                         (|devaluate|
                                                          (ELT $ 7))
                                                         (LIST '|Symbol|)
                                                         (|devaluate|
                                                          (ELT $ 7))
                                                         (LIST '|List|
                                                               (|devaluate|
                                                                (ELT $ 7))))
                                                        (|ElementaryFunctionLODESolver|
                                                         (ELT $ 6) (ELT $ 7)
                                                         |Lx|))))))))))) 

(SDEFUN |ODEEF;solve;LLSU;7|
        ((|leq| (|List| F)) (|lop| (|List| (|BasicOperator|))) (|x| (|Symbol|))
         ($
          (|Union|
           (|Record| (|:| |particular| (|Vector| F))
                     (|:| |basis| (|List| (|Vector| F))))
           "failed")))
        (SPROG
         ((|rec| (|Record| (|:| |mat| (|Matrix| F)) (|:| |vec| (|Vector| F))))
          (|u|
           (|Union|
            (|Record| (|:| |mat| (|Matrix| F)) (|:| |vec| (|Vector| F)))
            "failed")))
         (SEQ (LETT |u| (|ODEEF;parseSYS| |leq| |lop| |x| $))
              (EXIT
               (COND
                ((QEQCAR |u| 0)
                 (SEQ (LETT |rec| (QCDR |u|))
                      (EXIT
                       (SPADCALL (QCAR |rec|) (QCDR |rec|) |x|
                                 (QREFELT $ 31)))))
                ('T (|error| "solve: not a first order linear system"))))))) 

(SDEFUN |ODEEF;solve;FBoSU;8|
        ((|diffeq| (F)) (|y| (|BasicOperator|)) (|x| (|Symbol|))
         ($
          (|Union| (|Record| (|:| |particular| F) (|:| |basis| (|List| F))) F
                   "failed")))
        (SPROG
         ((|uuu|
           (|Union| (|Record| (|:| |particular| F) (|:| |basis| (|List| F)))
                    #1="failed"))
          (|p| #2=(|SparseUnivariatePolynomial| F)) (|op| (|Lx|))
          (|Lx| (|LinearOrdinaryDifferentialOperatorCategory| F))
          (|rec|
           (|Record| (|:| |left| (|SparseUnivariatePolynomial| F))
                     (|:| |right| F)))
          (|uu| (|Union| F "failed"))
          (|rc| (|Record| (|:| |dx| F) (|:| |dy| F)))
          (|u|
           (|Union| (|Record| (|:| |left| #2#) (|:| |right| F))
                    (|Record| (|:| |dx| F) (|:| |dy| F)))))
         (SEQ (LETT |u| (|ODEEF;parseODE| |diffeq| |y| |x| $))
              (EXIT
               (COND
                ((QEQCAR |u| 1)
                 (SEQ (LETT |rc| (QCDR |u|))
                      (LETT |uu|
                            (SPADCALL (QCAR |rc|) (QCDR |rc|) |y| |x|
                                      (QREFELT $ 44)))
                      (EXIT
                       (COND ((QEQCAR |uu| 1) (CONS 2 "failed"))
                             (#3='T (CONS 1 (QCDR |uu|)))))))
                (#3#
                 (SEQ (LETT |rec| (QCDR |u|)) (LETT |p| (QCAR |rec|))
                      (LETT |Lx|
                            (|LinearOrdinaryDifferentialOperator| (QREFELT $ 7)
                                                                  (SPADCALL |x|
                                                                            (QREFELT
                                                                             $
                                                                             36))))
                      (LETT |op|
                            (SPADCALL
                             (|compiledLookupCheck| '|Zero| (LIST '$) |Lx|)))
                      (SEQ G190
                           (COND
                            ((NULL
                              (SPADCALL |p| (|spadConstant| $ 54)
                                        (QREFELT $ 56)))
                             (GO G191)))
                           (SEQ
                            (LETT |op|
                                  (SPADCALL |op|
                                            (SPADCALL
                                             (SPADCALL |p| (QREFELT $ 57))
                                             (SPADCALL |p| (QREFELT $ 59))
                                             (|compiledLookupCheck| '|monomial|
                                                                    (LIST '$
                                                                          (|devaluate|
                                                                           (ELT
                                                                            $
                                                                            7))
                                                                          (LIST
                                                                           '|NonNegativeInteger|))
                                                                    |Lx|))
                                            (|compiledLookupCheck| '+
                                                                   (LIST '$ '$
                                                                         '$)
                                                                   |Lx|)))
                            (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 60)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |uuu|
                            (SPADCALL |op| (QCDR |rec|) |x|
                                      (|compiledLookupCheck| '|solve|
                                                             (LIST
                                                              (LIST '|Union|
                                                                    (LIST
                                                                     '|Record|
                                                                     (LIST '|:|
                                                                           '|particular|
                                                                           (|devaluate|
                                                                            (ELT
                                                                             $
                                                                             7)))
                                                                     (LIST '|:|
                                                                           '|basis|
                                                                           (LIST
                                                                            '|List|
                                                                            (|devaluate|
                                                                             (ELT
                                                                              $
                                                                              7)))))
                                                                    '#1#)
                                                              (|devaluate|
                                                               |Lx|)
                                                              (|devaluate|
                                                               (ELT $ 7))
                                                              (LIST '|Symbol|))
                                                             (|ElementaryFunctionLODESolver|
                                                              (ELT $ 6)
                                                              (ELT $ 7)
                                                              |Lx|))))
                      (EXIT
                       (COND ((QEQCAR |uuu| 1) (CONS 2 "failed"))
                             (#3# (CONS 0 (QCDR |uuu|)))))))))))) 

(SDEFUN |ODEEF;parseSYS|
        ((|eqs| (|List| F)) (|ly| (|List| (|BasicOperator|))) (|x| (|Symbol|))
         ($
          (|Union| (|Record| (|:| |mat| (|Matrix| F)) (|:| |vec| (|Vector| F)))
                   "failed")))
        (SPROG
         ((|rec|
           (|Record| (|:| |index| (|Integer|)) (|:| |row| (|Vector| F))
                     (|:| |rh| F)))
          (#1=#:G845 NIL)
          (|u|
           (|Union|
            (|Record| (|:| |index| (|Integer|)) (|:| |row| (|Vector| F))
                      (|:| |rh| F))
            "failed"))
          (#2=#:G852 NIL) (|eq| NIL) (|lk1| (|List| (|Kernel| F)))
          (#3=#:G851 NIL) (|f| NIL) (#4=#:G850 NIL)
          (|lk0| (|List| (|Kernel| F))) (#5=#:G849 NIL) (#6=#:G848 NIL)
          (|lf| (|List| F)) (#7=#:G847 NIL) (|y| NIL) (#8=#:G846 NIL)
          (|xx| (F)) (|v| (|Vector| F)) (|m| (|Matrix| F))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |n| (LENGTH |eqs|)) (LENGTH |ly|) (QREFELT $ 61))
             (CONS 1 "failed"))
            ('T
             (SEQ (LETT |m| (MAKE_MATRIX1 |n| |n| (|spadConstant| $ 28)))
                  (LETT |v| (MAKEARR1 |n| (|spadConstant| $ 28)))
                  (LETT |xx| (SPADCALL |x| (QREFELT $ 45)))
                  (LETT |lf|
                        (PROGN
                         (LETT #8# NIL)
                         (SEQ (LETT |y| NIL) (LETT #7# |ly|) G190
                              (COND
                               ((OR (ATOM #7#)
                                    (PROGN (LETT |y| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #8#
                                      (CONS (SPADCALL |y| |xx| (QREFELT $ 46))
                                            #8#))))
                              (LETT #7# (CDR #7#)) (GO G190) G191
                              (EXIT (NREVERSE #8#)))))
                  (LETT |lk0|
                        (PROGN
                         (LETT #6# NIL)
                         (SEQ (LETT |f| NIL) (LETT #5# |lf|) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |f| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #6#
                                      (CONS (SPADCALL |f| (QREFELT $ 48))
                                            #6#))))
                              (LETT #5# (CDR #5#)) (GO G190) G191
                              (EXIT (NREVERSE #6#)))))
                  (LETT |lk1|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |f| NIL) (LETT #3# |lf|) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |f| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #4#
                                      (CONS
                                       (SPADCALL
                                        (SPADCALL |f| |x| (QREFELT $ 62))
                                        (QREFELT $ 48))
                                       #4#))))
                              (LETT #3# (CDR #3#)) (GO G190) G191
                              (EXIT (NREVERSE #4#)))))
                  (SEQ (LETT |eq| NIL) (LETT #2# |eqs|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |eq| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |u|
                              (|ODEEF;parseSYSeq| |eq| |lk0| |lk1| |lf| |x| $))
                        (EXIT
                         (COND
                          ((QEQCAR |u| 1)
                           (PROGN (LETT #1# (CONS 1 "failed")) (GO #9=#:G844)))
                          ('T
                           (SEQ (LETT |rec| (QCDR |u|))
                                (SPADCALL |m| (QVELT |rec| 0) (QVELT |rec| 1)
                                          (QREFELT $ 63))
                                (EXIT
                                 (SPADCALL |v| (QVELT |rec| 0) (QVELT |rec| 2)
                                           (QREFELT $ 64))))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT (CONS 0 (CONS |m| |v|)))))))
          #9# (EXIT #1#)))) 

(SDEFUN |ODEEF;parseSYSeq|
        ((|eq| (F)) (|l0| (|List| (|Kernel| F))) (|l1| (|List| (|Kernel| F)))
         (|lf| (|List| F)) (|x| (|Symbol|))
         ($
          (|Union|
           (|Record| (|:| |index| (|Integer|)) (|:| |row| (|Vector| F))
                     (|:| |rh| F))
           "failed")))
        (SPROG
         ((|ci| (F)) (#1=#:G879 NIL) (|y| NIL) (|i| NIL) (|v| (|Vector| F))
          (|c| (F)) (|n| (|Integer|)) (|k| (|Kernel| F))
          (|l| (|List| (|Kernel| F))) (#2=#:G878 NIL) (#3=#:G877 NIL))
         (SEQ
          (LETT |l|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ
                  (LETT #2#
                        (SPADCALL (SPADCALL |eq| (QREFELT $ 65)) |x|
                                  (QREFELT $ 68)))
                  G190
                  (COND
                   ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (COND
                     ((SPADCALL |k| '|%diff| (QREFELT $ 69))
                      (LETT #3# (CONS |k| #3#))))))
                  (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT (NREVERSE #3#)))))
          (COND
           ((OR (OR (NULL |l|) (NULL (NULL (CDR |l|))))
                (ZEROP
                 (LETT |n|
                       (SPADCALL (LETT |k| (|SPADfirst| |l|)) |l1|
                                 (QREFELT $ 71)))))
            (EXIT (CONS 1 "failed"))))
          (LETT |c| (|ODEEF;getfreelincoeff1| |eq| |k| |lf| $))
          (LETT |eq|
                (SPADCALL |eq|
                          (SPADCALL |c| (SPADCALL |k| (QREFELT $ 72))
                                    (QREFELT $ 73))
                          (QREFELT $ 11)))
          (LETT |v| (MAKEARR1 (LENGTH |l0|) (|spadConstant| $ 28)))
          (SEQ (LETT |i| 1) (LETT |y| NIL) (LETT #1# |l0|) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |y| (CAR #1#)) NIL)) (GO G191)))
               (SEQ (LETT |ci| (|ODEEF;getfreelincoeff1| |eq| |y| |lf| $))
                    (SPADCALL |v| |i|
                              (SPADCALL (SPADCALL |ci| |c| (QREFELT $ 74))
                                        (QREFELT $ 75))
                              (QREFELT $ 64))
                    (EXIT
                     (LETT |eq|
                           (SPADCALL |eq|
                                     (SPADCALL |ci|
                                               (SPADCALL |y| (QREFELT $ 72))
                                               (QREFELT $ 73))
                                     (QREFELT $ 11)))))
               (LETT #1# (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|)))) (GO G190)
               G191 (EXIT NIL))
          (EXIT (CONS 0 (VECTOR |n| |v| (SPADCALL |eq| (QREFELT $ 75)))))))) 

(SDEFUN |ODEEF;parseODE|
        ((|diffeq| (F)) (|y| (|BasicOperator|)) (|x| (|Symbol|))
         ($
          (|Union|
           (|Record| (|:| |left| (|SparseUnivariatePolynomial| F))
                     (|:| |right| F))
           (|Record| (|:| |dx| F) (|:| |dy| F)))))
        (SPROG
         ((|eqrhs| (F)) (|d| (F)) (|u| (|Union| F "failed")) (|k| (|Kernel| F))
          (|l| (|List| (|Kernel| F))) (|ny| (|Symbol|)) (|c| (F)) (|f| (F))
          (#1=#:G908 NIL) (|i| NIL) (|n| (|NonNegativeInteger|))
          (#2=#:G889 NIL) (|m| (|NonNegativeInteger|)) (#3=#:G907 NIL))
         (SEQ
          (LETT |f|
                (SPADCALL |y| (SPADCALL |x| (QREFELT $ 45)) (QREFELT $ 46)))
          (LETT |l| (LIST (SPADCALL |f| (QREFELT $ 48)))) (LETT |n| 2)
          (SEQ
           (LETT #3#
                 (SPADCALL (SPADCALL |diffeq| (QREFELT $ 65)) |x|
                           (QREFELT $ 68)))
           G190
           (COND ((OR (ATOM #3#) (PROGN (LETT |k| (CAR #3#)) NIL)) (GO G191)))
           (SEQ
            (EXIT
             (COND
              ((SPADCALL |k| '|%diff| (QREFELT $ 69))
               (SEQ (LETT |m| (SPADCALL |k| (QREFELT $ 76)))
                    (EXIT (COND ((> |m| |n|) (LETT |n| |m|)))))))))
           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (LETT |n|
                (PROG1 (LETT #2# (- |n| 2))
                  (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #2#)))
          (SEQ (LETT |i| 1) (LETT #1# |n|) G190
               (COND ((|greater_SI| |i| #1#) (GO G191)))
               (SEQ
                (EXIT
                 (LETT |l|
                       (CONS
                        (SPADCALL (LETT |f| (SPADCALL |f| |x| (QREFELT $ 62)))
                                  (QREFELT $ 48))
                        |l|))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (SEQ G190
               (COND
                ((NULL
                  (COND ((NULL |l|) NIL)
                        ('T
                         (SPADCALL
                          (LETT |c|
                                (|ODEEF;getlincoeff| |diffeq|
                                 (LETT |k| (|SPADfirst| |l|)) $))
                          (QREFELT $ 77)))))
                 (GO G191)))
               (SEQ (EXIT (LETT |l| (CDR |l|)))) NIL (GO G190) G191 (EXIT NIL))
          (COND
           ((OR (NULL |l|) (NULL (CDR |l|)))
            (EXIT (|error| "parseODE: equation has order 0"))))
          (LETT |diffeq|
                (SPADCALL |diffeq|
                          (SPADCALL |c| (SPADCALL |k| (QREFELT $ 72))
                                    (QREFELT $ 73))
                          (QREFELT $ 11)))
          (LETT |ny| (SPADCALL |y| (QREFELT $ 78))) (LETT |l| (CDR |l|))
          (EXIT
           (COND
            ((> (SPADCALL |k| (QREFELT $ 76)) 3)
             (CONS 0
                   (|ODEEF;parseLODE| |diffeq| |l|
                    (SPADCALL |c| (LENGTH |l|) (QREFELT $ 79)) |ny| $)))
            (#4='T
             (SEQ
              (LETT |u|
                    (|ODEEF;getcoeff| |diffeq| (LETT |k| (|SPADfirst| |l|)) $))
              (EXIT
               (COND ((QEQCAR |u| 1) (CONS 1 (CONS |diffeq| |c|)))
                     (#4#
                      (SEQ
                       (LETT |eqrhs|
                             (SPADCALL
                              (SPADCALL (LETT |d| (QCDR |u|))
                                        (SPADCALL |k| (QREFELT $ 72))
                                        (QREFELT $ 73))
                              |diffeq| (QREFELT $ 11)))
                       (COND
                        ((SPADCALL |eqrhs| |ny| (QREFELT $ 80))
                         (COND
                          ((SPADCALL |c| |ny| (QREFELT $ 80))
                           (COND
                            ((SPADCALL |d| |ny| (QREFELT $ 80))
                             (EXIT
                              (CONS 0
                                    (CONS
                                     (SPADCALL (SPADCALL |c| 1 (QREFELT $ 79))
                                               (SPADCALL |d| (QREFELT $ 82))
                                               (QREFELT $ 83))
                                     |eqrhs|)))))))))
                       (EXIT (CONS 1 (CONS |diffeq| |c|)))))))))))))) 

(SDEFUN |ODEEF;parseLODE|
        ((|diffeq| (F)) (|l| (|List| (|Kernel| F)))
         (|p| (|SparseUnivariatePolynomial| F)) (|y| (|Symbol|))
         ($
          (|Record| (|:| |left| (|SparseUnivariatePolynomial| F))
                    (|:| |right| F))))
        (SPROG
         ((|d| (|Integer|)) (#1=#:G912 NIL) (|c| (F)) (#2=#:G917 NIL)
          (|k| NIL))
         (SEQ
          (COND
           ((NULL (SPADCALL (SPADCALL |p| (QREFELT $ 57)) |y| (QREFELT $ 80)))
            (|error| "parseLODE: not a linear ordinary differential equation"))
           ('T
            (SEQ (LETT |d| (- (SPADCALL |p| (QREFELT $ 59)) 1))
                 (SEQ (LETT |k| NIL) (LETT #2# |l|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (LETT |p|
                             (SPADCALL |p|
                                       (SPADCALL
                                        (LETT |c|
                                              (|ODEEF;getfreelincoeff| |diffeq|
                                               |k| |y| $))
                                        (PROG1 (LETT #1# |d|)
                                          (|check_subtype2| (>= #1# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #1#))
                                        (QREFELT $ 79))
                                       (QREFELT $ 83)))
                       (LETT |d| (- |d| 1))
                       (EXIT
                        (LETT |diffeq|
                              (SPADCALL |diffeq|
                                        (SPADCALL |c|
                                                  (SPADCALL |k| (QREFELT $ 72))
                                                  (QREFELT $ 73))
                                        (QREFELT $ 11)))))
                      (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (COND
                   ((SPADCALL |diffeq| |y| (QREFELT $ 80))
                    (CONS |p| (SPADCALL |diffeq| (QREFELT $ 75))))
                   ('T
                    (|error|
                     "parseLODE: not a linear ordinary differential equation")))))))))) 

(SDEFUN |ODEEF;getfreelincoeff|
        ((|f| (F)) (|k| (|Kernel| F)) (|y| (|Symbol|)) ($ (F)))
        (SPROG ((|c| (F)))
               (COND
                ((SPADCALL (LETT |c| (|ODEEF;getlincoeff| |f| |k| $)) |y|
                           (QREFELT $ 80))
                 |c|)
                ('T
                 (|error|
                  "getfreelincoeff: not a linear ordinary differential equation"))))) 

(SDEFUN |ODEEF;getfreelincoeff1|
        ((|f| (F)) (|k| (|Kernel| F)) (|ly| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G925 NIL) (#2=#:G926 NIL) (|y| NIL) (|c| (F)))
               (SEQ (LETT |c| (|ODEEF;getlincoeff| |f| |k| $))
                    (SEQ
                     (EXIT
                      (SEQ (LETT |y| NIL) (LETT #2# |ly|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |y| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL (SPADCALL |c| |y| (QREFELT $ 84)))
                               (PROGN
                                (LETT #1#
                                      (|error|
                                       "getfreelincoeff: not a linear ordinary differential equation"))
                                (GO #3=#:G922))))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL)))
                     #3# (EXIT #1#))
                    (EXIT |c|)))) 

(SDEFUN |ODEEF;getlincoeff| ((|f| (F)) (|k| (|Kernel| F)) ($ (F)))
        (SPROG ((|u| (|Union| F "failed")))
               (SEQ (LETT |u| (|ODEEF;getcoeff| |f| |k| $))
                    (EXIT
                     (COND
                      ((QEQCAR |u| 1)
                       (|error|
                        "getlincoeff: not an appropriate ordinary differential equation"))
                      ('T (QCDR |u|))))))) 

(SDEFUN |ODEEF;getcoeff|
        ((|f| (F)) (|k| (|Kernel| F)) ($ (|Union| F "failed")))
        (SPROG
         ((#1=#:G945 NIL)
          (|p|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|r|
           (|Union| (|SparseMultivariatePolynomial| R (|Kernel| F)) "failed")))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (LETT |r|
                   (SPADCALL
                    (SPADCALL (SPADCALL |f| (QREFELT $ 86)) |k| (QREFELT $ 89))
                    (QREFELT $ 92)))
             (EXIT
              (COND
               ((OR (QEQCAR |r| 1)
                    (>
                     (SPADCALL
                      (LETT |p|
                            (SPADCALL (SPADCALL |f| (QREFELT $ 93)) |k|
                                      (QREFELT $ 89)))
                      (QREFELT $ 94))
                     1))
                (PROGN (LETT #1# (CONS 1 "failed")) (GO #2=#:G943))))))
            (EXIT
             (CONS 0
                   (SPADCALL (SPADCALL |p| 1 (QREFELT $ 95)) (QCDR |r|)
                             (QREFELT $ 96))))))
          #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |ElementaryFunctionODESolver;|)) 

(DEFUN |ElementaryFunctionODESolver| (&REST #1=#:G946)
  (SPROG NIL
         (PROG (#2=#:G947)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ElementaryFunctionODESolver|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |ElementaryFunctionODESolver;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ElementaryFunctionODESolver|)))))))))) 

(DEFUN |ElementaryFunctionODESolver;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ElementaryFunctionODESolver| DV$1 DV$2))
          (LETT $ (GETREFV 97))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ElementaryFunctionODESolver|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ElementaryFunctionODESolver| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Equation| 7) (0 . |lhs|) (5 . |rhs|) (10 . -)
              (|Record| (|:| |particular| 7) (|:| |basis| 20))
              (|Union| 12 7 '#1="failed") (|BasicOperator|) (|Symbol|)
              |ODEEF;solve;FBoSU;8| |ODEEF;solve;EBoSU;1|
              (|Record| (|:| |particular| 30) (|:| |basis| (|List| 30)))
              (|Union| 18 '#2="failed") (|List| 7) (|List| 14)
              |ODEEF;solve;LLSU;7| (|List| 8) |ODEEF;solve;LLSU;2|
              (|Union| 7 '#3="failed") |ODEEF;solve;FBoELU;6|
              |ODEEF;solve;EBoELU;3| (16 . |Zero|) (|Matrix| 7) (|Vector| 7)
              |ODEEF;solve;MVSU;5| (|Union| (|List| 30) '#4="failed")
              |ODEEF;solve;MSU;4| (|Mapping| 7 7) (|ODEIntegration| 6 7)
              (20 . |diff|) (|Integer|) (25 . |column|) (31 . |retract|)
              (|Kernel| 7) (36 . |kernel|) (41 . |One|)
              (|NonLinearFirstOrderODESolver| 6 7) (45 . |solve|)
              (53 . |coerce|) (58 . |elt|) (|Kernel| $) (64 . |retract|)
              (|List| 47) (|List| $) (69 . |eval|) (76 . |Zero|)
              (|SparseUnivariatePolynomial| 7) (80 . |Zero|) (|Boolean|)
              (84 . ~=) (90 . |leadingCoefficient|) (|NonNegativeInteger|)
              (95 . |degree|) (100 . |reductum|) (105 . ~=)
              (111 . |differentiate|) (117 . |setRow!|) (124 . |setelt!|)
              (131 . |kernels|) (|List| 40) (|IntegrationTools| 6 7)
              (136 . |varselect|) (142 . |is?|) (148 . |first|)
              (153 . |position|) (159 . |coerce|) (164 . *) (170 . /) (176 . -)
              (181 . |height|) (186 . |zero?|) (191 . |name|)
              (196 . |monomial|) (202 . |freeOf?|) (208 . |One|)
              (212 . |coerce|) (217 . +) (223 . |freeOf?|)
              (|SparseMultivariatePolynomial| 6 47) (229 . |denom|)
              (|SparseUnivariatePolynomial| $)
              (|SparseMultivariatePolynomial| 6 40) (234 . |univariate|)
              (|Union| 88 '"failed") (|SparseUnivariatePolynomial| 88)
              (240 . |retractIfCan|) (245 . |numer|) (250 . |degree|)
              (255 . |coefficient|) (261 . /))
           '#(|solve| 267) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solve|
                                 ((|Union|
                                   (|Record| (|:| |particular| (|Vector| |#2|))
                                             (|:| |basis|
                                                  (|List| (|Vector| |#2|))))
                                   "failed")
                                  (|Matrix| |#2|) (|Vector| |#2|) (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|Union| (|List| (|Vector| |#2|)) #4#)
                                  (|Matrix| |#2|) (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|Union|
                                   (|Record| (|:| |particular| (|Vector| |#2|))
                                             (|:| |basis|
                                                  (|List| (|Vector| |#2|))))
                                   "failed")
                                  (|List| (|Equation| |#2|))
                                  (|List| (|BasicOperator|)) (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|Union|
                                   (|Record| (|:| |particular| (|Vector| |#2|))
                                             (|:| |basis|
                                                  (|List| (|Vector| |#2|))))
                                   #2#)
                                  (|List| |#2|) (|List| (|BasicOperator|))
                                  (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|Union|
                                   (|Record| (|:| |particular| |#2|)
                                             (|:| |basis| (|List| |#2|)))
                                   |#2| #1#)
                                  (|Equation| |#2|) (|BasicOperator|)
                                  (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|Union|
                                   (|Record| (|:| |particular| |#2|)
                                             (|:| |basis| (|List| |#2|)))
                                   |#2| #1#)
                                  |#2| (|BasicOperator|) (|Symbol|)))
                                T)
                              '((|solve|
                                 ((|Union| |#2| #3#) (|Equation| |#2|)
                                  (|BasicOperator|) (|Equation| |#2|)
                                  (|List| |#2|)))
                                T)
                              '((|solve|
                                 ((|Union| |#2| #3#) |#2| (|BasicOperator|)
                                  (|Equation| |#2|) (|List| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 96
                                            '(1 8 7 0 9 1 8 7 0 10 2 7 0 0 0 11
                                              0 7 0 28 1 35 34 15 36 2 29 30 0
                                              37 38 1 7 15 0 39 1 40 0 15 41 0
                                              6 0 42 4 43 25 7 7 14 15 44 1 7 0
                                              15 45 2 7 0 14 0 46 1 7 47 0 48 3
                                              7 0 0 49 50 51 0 6 0 52 0 53 0 54
                                              2 53 55 0 0 56 1 53 7 0 57 1 53
                                              58 0 59 1 53 0 0 60 2 58 55 0 0
                                              61 2 7 0 0 15 62 3 29 0 0 37 30
                                              63 3 30 7 0 37 7 64 1 7 49 0 65 2
                                              67 66 66 15 68 2 40 55 0 15 69 1
                                              66 40 0 70 2 66 37 40 0 71 1 7 0
                                              47 72 2 7 0 0 0 73 2 7 0 0 0 74 1
                                              7 0 0 75 1 40 58 0 76 1 7 55 0 77
                                              1 14 15 0 78 2 53 0 7 58 79 2 7
                                              55 0 15 80 0 7 0 81 1 53 0 7 82 2
                                              53 0 0 0 83 2 7 55 0 0 84 1 7 85
                                              0 86 2 88 87 0 40 89 1 91 90 0 92
                                              1 7 85 0 93 1 91 58 0 94 2 91 88
                                              0 58 95 2 7 0 85 85 96 2 0 32 29
                                              15 33 3 0 19 29 30 15 31 3 0 19
                                              20 21 15 22 3 0 19 23 21 15 24 3
                                              0 13 7 14 15 16 3 0 13 8 14 15 17
                                              4 0 25 7 14 8 20 26 4 0 25 8 14 8
                                              20 27)))))
           '|lookupComplete|)) 


(SDEFUN |HEUGCD;myNextPrime|
        ((|val| (|Integer|)) (|bound| (|NonNegativeInteger|)) ($ (|Integer|)))
        (SPADCALL |val| (QREFELT $ 10))) 

(SDEFUN |HEUGCD;constNotZero| ((|f| (BP)) ($ (|Boolean|)))
        (COND
         ((EQL (SPADCALL |f| (QREFELT $ 12)) 0)
          (NULL (SPADCALL |f| (QREFELT $ 14))))
         ('T NIL))) 

(SDEFUN |HEUGCD;negShiftz|
        ((|n| (|Integer|)) (|Modulus| (|PositiveInteger|)) ($ (|Integer|)))
        (COND ((< |n| 0) (LETT |n| (+ |n| |Modulus|)))
              ((> |n| (QUOTIENT2 |Modulus| 2)) (- |n| |Modulus|)) ('T |n|))) 

(SDEFUN |HEUGCD;height| ((|f| (BP)) ($ (|PositiveInteger|)))
        (SPROG ((|k| (|PositiveInteger|)) (#1=#:G718 NIL))
               (SEQ (LETT |k| 1)
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |f| (|spadConstant| $ 15)
                                      (QREFELT $ 16)))
                           (GO G191)))
                         (SEQ
                          (LETT |k|
                                (MAX |k|
                                     (PROG1
                                         (LETT #1#
                                               (ABS
                                                (SPADCALL |f| (QREFELT $ 17))))
                                       (|check_subtype2| (> #1# 0)
                                                         '(|PositiveInteger|)
                                                         '(|Integer|) #1#))))
                          (EXIT (LETT |f| (SPADCALL |f| (QREFELT $ 18)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |k|)))) 

(SDEFUN |HEUGCD;genpoly|
        ((|dval| #1=(|Integer|)) (|value| (|PositiveInteger|)) ($ (BP)))
        (SPROG ((|val| #1#) (|d| (BP)) (|val1| (|Integer|)) (|i| NIL))
               (SEQ (LETT |d| (|spadConstant| $ 15)) (LETT |val| |dval|)
                    (SEQ (LETT |i| 0) G190
                         (COND
                          ((NULL (SPADCALL |val| 0 (QREFELT $ 19))) (GO G191)))
                         (SEQ
                          (LETT |val1|
                                (|HEUGCD;negShiftz| (REM |val| |value|) |value|
                                 $))
                          (LETT |d|
                                (SPADCALL |d|
                                          (SPADCALL |val1| |i| (QREFELT $ 20))
                                          (QREFELT $ 21)))
                          (EXIT
                           (LETT |val| (QUOTIENT2 (- |val| |val1|) |value|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |d|)))) 

(SDEFUN |HEUGCD;smallest_to_front|
        ((|l| (|List| (|Integer|))) ($ (|List| (|Integer|))))
        (SPROG
         ((|ress| (|List| (|Integer|))) (|smallest| (|Integer|))
          (#1=#:G739 NIL) (|p| NIL))
         (SEQ (LETT |ress| NIL) (LETT |smallest| (|SPADfirst| |l|))
              (SEQ (LETT |p| NIL) (LETT #1# (CDR |l|)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((< |p| |smallest|)
                       (SEQ (LETT |ress| (CONS |smallest| |ress|))
                            (EXIT (LETT |smallest| |p|))))
                      ('T (LETT |ress| (CONS |p| |ress|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |smallest| |ress|))))) 

(SDEFUN |HEUGCD;lintgcd;LI;7| ((|lval| (|List| (|Integer|))) ($ (|Integer|)))
        (SPROG ((|val| (|Integer|)) (#1=#:G746 NIL) (|val1| NIL))
               (SEQ
                (COND ((NULL |lval|) 0) ((SPADCALL 1 |lval| (QREFELT $ 24)) 1)
                      ('T
                       (SEQ (LETT |lval| (|HEUGCD;smallest_to_front| |lval| $))
                            (LETT |val| (|SPADfirst| |lval|))
                            (SEQ (LETT |val1| NIL) (LETT #1# (CDR |lval|)) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |val1| (CAR #1#)) NIL)
                                       (NULL
                                        (SPADCALL |val| 1 (QREFELT $ 19))))
                                   (GO G191)))
                                 (SEQ (EXIT (LETT |val| (GCD |val| |val1|))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |val|))))))) 

(SDEFUN |HEUGCD;content;LL;8| ((|listf| (|List| BP)) ($ (|List| (|Integer|))))
        (SPROG ((#1=#:G751 NIL) (|f| NIL) (#2=#:G750 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |f| NIL) (LETT #1# |listf|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL |f| (QREFELT $ 26))
                                         (QREFELT $ 25))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |HEUGCD;contprim|
        ((|listf| (|List| BP))
         ($ (|List| (|Record| (|:| |cont| (|Integer|)) (|:| |prim| BP)))))
        (SPROG
         ((#1=#:G755 NIL) (|c| (|Integer|)) (#2=#:G760 NIL) (|f| NIL)
          (#3=#:G759 NIL))
         (SEQ
          (PROGN
           (LETT #3# NIL)
           (SEQ (LETT |f| NIL) (LETT #2# |listf|) G190
                (COND
                 ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (LETT #3#
                        (CONS
                         (CONS
                          (LETT |c|
                                (SPADCALL (SPADCALL |f| (QREFELT $ 26))
                                          (QREFELT $ 25)))
                          (PROG2 (LETT #1# (SPADCALL |f| |c| (QREFELT $ 30)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                            (|Union| (QREFELT $ 6) "failed")
                                            #1#)))
                         #3#))))
                (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT (NREVERSE #3#))))))) 

(SDEFUN |HEUGCD;constcase|
        ((|listdeg| (|List| (|NonNegativeInteger|))) (|listf| (|List| BP))
         ($ (|List| BP)))
        (SPROG
         ((#1=#:G778 NIL) (|lcf| NIL) (#2=#:G777 NIL) (|d| (|Integer|))
          (|lclistf| (|List| (|Integer|))) (#3=#:G776 NIL) (|f| NIL)
          (#4=#:G775 NIL) (#5=#:G764 NIL) (#6=#:G763 #7=(|Boolean|))
          (#8=#:G765 #7#) (#9=#:G774 NIL) (|n| NIL) (|lind| (|List| BP)))
         (SEQ
          (LETT |lind|
                (SPADCALL (CONS (|function| |HEUGCD;constNotZero|) $) |listf|
                          (QREFELT $ 32)))
          (EXIT
           (COND
            ((NULL |lind|)
             (COND
              ((SPADCALL 1 |listdeg| (QREFELT $ 34))
               (|HEUGCD;lincase| |listdeg| |listf| $))
              (#10='T (|HEUGCD;localgcd| |listf| $))))
            ((PROGN
              (LETT #5# NIL)
              (SEQ (LETT |n| NIL) (LETT #9# |listdeg|) G190
                   (COND
                    ((OR (ATOM #9#) (PROGN (LETT |n| (CAR #9#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (PROGN
                      (LETT #8# (> |n| 0))
                      (COND (#5# (LETT #6# (COND (#6# 'T) ('T #8#))))
                            ('T (PROGN (LETT #6# #8#) (LETT #5# 'T)))))))
                   (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
              (COND (#5# #6#) (#10# NIL)))
             (CONS (|spadConstant| $ 22) |listf|))
            (#10#
             (SEQ
              (LETT |lclistf|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |f| NIL) (LETT #3# |listf|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |f| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS (SPADCALL |f| (QREFELT $ 17)) #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |d| (SPADCALL |lclistf| (QREFELT $ 25)))
              (EXIT
               (COND ((EQL |d| 1) (CONS (|spadConstant| $ 22) |listf|))
                     (#10#
                      (CONS (SPADCALL |d| (QREFELT $ 35))
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |lcf| NIL) (LETT #1# |lclistf|) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |lcf| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS
                                           (SPADCALL (QUOTIENT2 |lcf| |d|)
                                                     (QREFELT $ 35))
                                           #2#))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))))))))))))) 

(SDEFUN |HEUGCD;testDivide|
        ((|listf| (|List| BP)) (|g| (BP)) ($ (|Union| (|List| BP) "failed")))
        (SPROG
         ((|result| (|List| BP)) (#1=#:G791 NIL) (|f1| (|Union| BP "failed"))
          (#2=#:G792 NIL) (|f| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |result| NIL)
                (SEQ (LETT |f| NIL) (LETT #2# |listf|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (SEQ (LETT |f1| (SPADCALL |f| |g| (QREFELT $ 36)))
                           (EXIT
                            (COND
                             ((QEQCAR |f1| 1)
                              (PROGN
                               (LETT #1# (CONS 1 "failed"))
                               (GO #3=#:G790))))))
                      (EXIT (LETT |result| (CONS (QCDR |f1|) |result|))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (NREVERSE |result|)))))
          #3# (EXIT #1#)))) 

(SDEFUN |HEUGCD;lincase|
        ((|listdeg| (|List| (|NonNegativeInteger|))) (|listf| (|List| BP))
         ($ (|List| BP)))
        (SPROG
         ((|result| (|List| BP)) (#1=#:G815 NIL) (|f1| (|Union| BP "failed"))
          (#2=#:G816 NIL) (|f| NIL) (|g| (BP)) (|n| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL 1 |listdeg| (QREFELT $ 39)))
                (LETT |g| (SPADCALL |listf| |n| (QREFELT $ 40)))
                (LETT |result| (LIST |g|))
                (SEQ (LETT |f| NIL) (LETT #2# |listf|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (SEQ (LETT |f1| (SPADCALL |f| |g| (QREFELT $ 36)))
                           (EXIT
                            (COND
                             ((QEQCAR |f1| 1)
                              (PROGN
                               (LETT #1# (CONS (|spadConstant| $ 22) |listf|))
                               (GO #3=#:G814))))))
                      (EXIT (LETT |result| (CONS (QCDR |f1|) |result|))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (REVERSE |result|))))
          #3# (EXIT #1#)))) 

(SDEFUN |HEUGCD;mindegpol| ((|f| (BP)) (|g| (BP)) ($ (BP)))
        (COND
         ((< (SPADCALL |g| (QREFELT $ 12)) (SPADCALL |f| (QREFELT $ 12))) |g|)
         ('T |f|))) 

(SDEFUN |HEUGCD;localgcd| ((|listf| (|List| BP)) ($ (|List| BP)))
        (SPROG
         ((#1=#:G835 NIL) (#2=#:G860 NIL) (|f| NIL) (#3=#:G859 NIL) (|gg| (BP))
          (|answr| (|PositiveInteger|)) (#4=#:G845 NIL)
          (|nvalue| (|NonNegativeInteger|)) (#5=#:G853 NIL)
          (|result| (|List| BP)) (|flag| (|Boolean|))
          (|f1| (|Union| BP "failed")) (#6=#:G858 NIL) (|d| (BP))
          (|contd| (|Integer|)) (|dd| (BP)) (|dval| (|Integer|))
          (|listval| (|List| (|Integer|))) (#7=#:G857 NIL) (#8=#:G856 NIL)
          (|k| NIL) (|minf| (BP)) (#9=#:G829 NIL) (#10=#:G828 (BP))
          (#11=#:G830 (BP)) (#12=#:G855 NIL) (|hgt| #13=(|PositiveInteger|))
          (#14=#:G825 NIL) (#15=#:G824 #13#) (#16=#:G826 #13#)
          (#17=#:G854 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |hgt|
                  (PROGN
                   (LETT #14# NIL)
                   (SEQ (LETT |f| NIL) (LETT #17# |listf|) G190
                        (COND
                         ((OR (ATOM #17#) (PROGN (LETT |f| (CAR #17#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((NULL (SPADCALL |f| (QREFELT $ 14)))
                            (PROGN
                             (LETT #16# (|HEUGCD;height| |f| $))
                             (COND (#14# (LETT #15# (MIN #15# #16#)))
                                   ('T
                                    (PROGN
                                     (LETT #15# #16#)
                                     (LETT #14# 'T)))))))))
                        (LETT #17# (CDR #17#)) (GO G190) G191 (EXIT NIL))
                   (COND (#14# #15#) (#18='T (|IdentityError| '|min|)))))
            (LETT |answr| (+ 2 (* 2 |hgt|)))
            (LETT |minf|
                  (PROGN
                   (LETT #9# NIL)
                   (SEQ (LETT |f| NIL) (LETT #12# |listf|) G190
                        (COND
                         ((OR (ATOM #12#) (PROGN (LETT |f| (CAR #12#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((NULL (SPADCALL |f| (QREFELT $ 14)))
                            (PROGN
                             (LETT #11# |f|)
                             (COND
                              (#9#
                               (LETT #10# (|HEUGCD;mindegpol| #10# #11# $)))
                              ('T (PROGN (LETT #10# #11#) (LETT #9# 'T)))))))))
                        (LETT #12# (CDR #12#)) (GO G190) G191 (EXIT NIL))
                   (COND (#9# #10#) (#18# (|IdentityError| '|mindegpol|)))))
            (LETT |result| (|HEUGCD;testDivide| |listf| |minf| $))
            (EXIT
             (COND ((QEQCAR |result| 0) (CONS |minf| (QCDR |result|)))
                   (#18#
                    (SEQ
                     (SEQ (LETT |k| 1) G190
                          (COND ((|greater_SI| |k| 10) (GO G191)))
                          (SEQ
                           (LETT |listval|
                                 (PROGN
                                  (LETT #8# NIL)
                                  (SEQ (LETT |f| NIL) (LETT #7# |listf|) G190
                                       (COND
                                        ((OR (ATOM #7#)
                                             (PROGN (LETT |f| (CAR #7#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #8#
                                               (CONS
                                                (SPADCALL |f| |answr|
                                                          (QREFELT $ 42))
                                                #8#))))
                                       (LETT #7# (CDR #7#)) (GO G190) G191
                                       (EXIT (NREVERSE #8#)))))
                           (LETT |dval| (SPADCALL |listval| (QREFELT $ 25)))
                           (LETT |dd| (|HEUGCD;genpoly| |dval| |answr| $))
                           (LETT |contd| (SPADCALL |dd| (QREFELT $ 43)))
                           (LETT |d|
                                 (PROG2
                                     (LETT #1#
                                           (SPADCALL |dd| |contd|
                                                     (QREFELT $ 30)))
                                     (QCDR #1#)
                                   (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                                   (|Union| (QREFELT $ 6)
                                                            #19="failed")
                                                   #1#)))
                           (LETT |result| (LIST |d|)) (LETT |flag| 'T)
                           (SEQ (LETT |f| NIL) (LETT #6# |listf|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |f| (CAR #6#)) NIL)
                                      (NULL |flag|))
                                  (GO G191)))
                                (SEQ
                                 (LETT |f1| (SPADCALL |f| |d| (QREFELT $ 36)))
                                 (EXIT
                                  (COND ((QEQCAR |f1| 1) (LETT |flag| NIL))
                                        ('T
                                         (LETT |result|
                                               (CONS (QCDR |f1|) |result|))))))
                                (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                           (COND
                            (|flag|
                             (PROGN
                              (LETT #5# (REVERSE |result|))
                              (GO #20=#:G852))))
                           (LETT |nvalue|
                                 (QUOTIENT2 (* |answr| 832040) 317811))
                           (COND
                            ((EQL (REM (+ |nvalue| |answr|) 2) 0)
                             (LETT |nvalue| (+ |nvalue| 1))))
                           (EXIT
                            (LETT |answr|
                                  (PROG1 (LETT #4# |nvalue|)
                                    (|check_subtype2| (> #4# 0)
                                                      '(|PositiveInteger|)
                                                      '(|NonNegativeInteger|)
                                                      #4#)))))
                          (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                     (LETT |gg| (SPADCALL |listf| (QREFELT $ 44)))
                     (EXIT
                      (CONS |gg|
                            (PROGN
                             (LETT #3# NIL)
                             (SEQ (LETT |f| NIL) (LETT #2# |listf|) G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |f| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #3#
                                          (CONS
                                           (PROG2
                                               (LETT #1#
                                                     (SPADCALL |f| |gg|
                                                               (QREFELT $ 36)))
                                               (QCDR #1#)
                                             (|check_union2| (QEQCAR #1# 0)
                                                             (QREFELT $ 6)
                                                             (|Union|
                                                              (QREFELT $ 6)
                                                              #19#)
                                                             #1#))
                                           #3#))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT (NREVERSE #3#))))))))))))
          #20# (EXIT #5#)))) 

(SDEFUN |HEUGCD;internal|
        ((|flag| (|Union| "gcdprim" "gcd" "gcdcofactprim" "gcdcofact"))
         (|listf| (|List| BP)) ($ (|List| BP)))
        (SPROG
         ((|ans| (|List| BP)) (#1=#:G914 NIL) (|p| NIL) (#2=#:G915 NIL)
          (|q| NIL) (#3=#:G913 NIL) (|result| (BP)) (|#G53| (|List| BP))
          (|#G52| (BP)) (#4=#:G902 NIL) (|fa| #5=(|U32Vector|)) (|ga| #5#)
          (#6=#:G901 NIL) (|lcg| (|Integer|)) (#7=#:G912 NIL) (|g| NIL)
          (|f| (BP)) (|listdeg| (|List| (|NonNegativeInteger|)))
          (#8=#:G911 NIL) (#9=#:G910 NIL) (|minpol| (BP)) (#10=#:G909 NIL)
          (|term| NIL) (#11=#:G908 NIL) (|contgcd| (|Integer|))
          (|Cgcd| (|List| (|Integer|))) (#12=#:G907 NIL) (#13=#:G906 NIL)
          (|contlistf|
           (|List| (|Record| (|:| |cont| (|Integer|)) (|:| |prim| BP))))
          (#14=#:G871 NIL) (#15=#:G905 NIL) (#16=#:G904 NIL) (|minpol1| (BP))
          (|mdeg| #17=(|NonNegativeInteger|)) (#18=#:G867 NIL)
          (#19=#:G866 #17#) (#20=#:G868 #17#) (#21=#:G903 NIL)
          (|nlf| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |listf| NIL (QREFELT $ 45))
             (LIST (|spadConstant| $ 22)))
            (#22='T
             (SEQ (LETT |nlf| (LENGTH |listf|))
                  (EXIT
                   (COND
                    ((EQL |nlf| 1)
                     (LIST (|SPADfirst| |listf|) (|spadConstant| $ 22)))
                    (#22#
                     (SEQ (LETT |minpol| (|spadConstant| $ 22))
                          (LETT |mdeg|
                                (PROGN
                                 (LETT #18# NIL)
                                 (SEQ (LETT #21# |listf|) G190
                                      (COND
                                       ((OR (ATOM #21#)
                                            (PROGN (LETT |f| (CAR #21#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (PROGN
                                         (LETT #20#
                                               (SPADCALL |f| (QREFELT $ 46)))
                                         (COND
                                          (#18# (LETT #19# (MIN #19# #20#)))
                                          ('T
                                           (PROGN
                                            (LETT #19# #20#)
                                            (LETT #18# 'T)))))))
                                      (LETT #21# (CDR #21#)) (GO G190) G191
                                      (EXIT NIL))
                                 (COND (#18# #19#)
                                       (#22# (|IdentityError| '|min|)))))
                          (COND
                           ((> |mdeg| 0)
                            (SEQ
                             (LETT |minpol1|
                                   (SPADCALL 1 |mdeg| (QREFELT $ 20)))
                             (LETT |listf|
                                   (PROGN
                                    (LETT #16# NIL)
                                    (SEQ (LETT #15# |listf|) G190
                                         (COND
                                          ((OR (ATOM #15#)
                                               (PROGN
                                                (LETT |f| (CAR #15#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #16#
                                                 (CONS
                                                  (PROG2
                                                      (LETT #14#
                                                            (SPADCALL |f|
                                                                      |minpol1|
                                                                      (QREFELT
                                                                       $ 36)))
                                                      (QCDR #14#)
                                                    (|check_union2|
                                                     (QEQCAR #14# 0)
                                                     (QREFELT $ 6)
                                                     (|Union| (QREFELT $ 6)
                                                              "failed")
                                                     #14#))
                                                  #16#))))
                                         (LETT #15# (CDR #15#)) (GO G190) G191
                                         (EXIT (NREVERSE #16#)))))
                             (EXIT
                              (LETT |minpol|
                                    (SPADCALL |minpol| |minpol1|
                                              (QREFELT $ 47)))))))
                          (LETT |Cgcd| NIL) (LETT |contgcd| 1)
                          (COND
                           ((OR (QEQCAR |flag| 1) (QEQCAR |flag| 3))
                            (SEQ
                             (LETT |contlistf| (|HEUGCD;contprim| |listf| $))
                             (LETT |Cgcd|
                                   (PROGN
                                    (LETT #13# NIL)
                                    (SEQ (LETT |term| NIL)
                                         (LETT #12# |contlistf|) G190
                                         (COND
                                          ((OR (ATOM #12#)
                                               (PROGN
                                                (LETT |term| (CAR #12#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #13#
                                                 (CONS (QCAR |term|) #13#))))
                                         (LETT #12# (CDR #12#)) (GO G190) G191
                                         (EXIT (NREVERSE #13#)))))
                             (LETT |contgcd| (SPADCALL |Cgcd| (QREFELT $ 25)))
                             (LETT |listf|
                                   (PROGN
                                    (LETT #11# NIL)
                                    (SEQ (LETT |term| NIL)
                                         (LETT #10# |contlistf|) G190
                                         (COND
                                          ((OR (ATOM #10#)
                                               (PROGN
                                                (LETT |term| (CAR #10#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #11#
                                                 (CONS (QCDR |term|) #11#))))
                                         (LETT #10# (CDR #10#)) (GO G190) G191
                                         (EXIT (NREVERSE #11#)))))
                             (EXIT
                              (LETT |minpol|
                                    (SPADCALL |contgcd| |minpol|
                                              (QREFELT $ 48)))))))
                          (LETT |listdeg|
                                (PROGN
                                 (LETT #9# NIL)
                                 (SEQ (LETT #8# |listf|) G190
                                      (COND
                                       ((OR (ATOM #8#)
                                            (PROGN (LETT |f| (CAR #8#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #9#
                                              (CONS
                                               (SPADCALL |f| (QREFELT $ 12))
                                               #9#))))
                                      (LETT #8# (CDR #8#)) (GO G190) G191
                                      (EXIT (NREVERSE #9#)))))
                          (LETT |f| (|SPADfirst| |listf|))
                          (COND
                           ((SPADCALL
                             (SPADCALL (SPADCALL |f| (QREFELT $ 17))
                                       (QREFELT $ 7) (QREFELT $ 49))
                             0 (QREFELT $ 19))
                            (SEQ
                             (LETT |fa|
                                   (SPADCALL (SPADCALL |f| (QREFELT $ 51))
                                             (QREFELT $ 7) (QREFELT $ 54)))
                             (EXIT
                              (SEQ
                               (EXIT
                                (SEQ (LETT |g| NIL) (LETT #7# (CDR |listf|))
                                     G190
                                     (COND
                                      ((OR (ATOM #7#)
                                           (PROGN (LETT |g| (CAR #7#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |lcg|
                                            (SPADCALL |g| (QREFELT $ 17)))
                                      (COND
                                       ((EQL
                                         (SPADCALL |lcg| (QREFELT $ 7)
                                                   (QREFELT $ 49))
                                         0)
                                        (PROGN (LETT #6# 1) (GO #23=#:G891))))
                                      (LETT |ga|
                                            (SPADCALL
                                             (SPADCALL |g| (QREFELT $ 51))
                                             (QREFELT $ 7) (QREFELT $ 54)))
                                      (LETT |fa|
                                            (SPADCALL |fa| |ga| (QREFELT $ 7)
                                                      (QREFELT $ 55)))
                                      (EXIT
                                       (COND
                                        ((EQL (SPADCALL |fa| (QREFELT $ 56)) 0)
                                         (PROGN
                                          (LETT #4# (CONS |minpol| |listf|))
                                          (GO #24=#:G900))))))
                                     (LETT #7# (CDR #7#)) (GO G190) G191
                                     (EXIT NIL)))
                               #23# (EXIT #6#))))))
                          (LETT |ans|
                                (COND
                                 ((SPADCALL 0 |listdeg| (QREFELT $ 34))
                                  (|HEUGCD;constcase| |listdeg| |listf| $))
                                 ((SPADCALL 1 |listdeg| (QREFELT $ 34))
                                  (|HEUGCD;lincase| |listdeg| |listf| $))
                                 (#22# (|HEUGCD;localgcd| |listf| $))))
                          (PROGN
                           (LETT |#G52|
                                 (SPADCALL (|SPADfirst| |ans|) |minpol|
                                           (QREFELT $ 47)))
                           (LETT |#G53| (CDR |ans|))
                           (LETT |result| |#G52|)
                           (LETT |ans| |#G53|))
                          (COND
                           ((QEQCAR |flag| 3)
                            (LETT |ans|
                                  (PROGN
                                   (LETT #3# NIL)
                                   (SEQ (LETT |q| NIL) (LETT #2# |ans|)
                                        (LETT |p| NIL) (LETT #1# |Cgcd|) G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN (LETT |p| (CAR #1#)) NIL)
                                              (ATOM #2#)
                                              (PROGN (LETT |q| (CAR #2#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #3#
                                                (CONS
                                                 (SPADCALL
                                                  (QUOTIENT2 |p| |contgcd|) |q|
                                                  (QREFELT $ 48))
                                                 #3#))))
                                        (LETT #1#
                                              (PROG1 (CDR #1#)
                                                (LETT #2# (CDR #2#))))
                                        (GO G190) G191
                                        (EXIT (NREVERSE #3#)))))))
                          (EXIT (CONS |result| |ans|))))))))))
          #24# (EXIT #4#)))) 

(SDEFUN |HEUGCD;gcdprim;LBP;16| ((|listf| (|List| BP)) ($ (BP)))
        (|SPADfirst| (|HEUGCD;internal| (CONS 0 "gcdprim") |listf| $))) 

(SDEFUN |HEUGCD;gcdcofactprim;2L;17| ((|listf| (|List| BP)) ($ (|List| BP)))
        (|HEUGCD;internal| (CONS 2 "gcdcofactprim") |listf| $)) 

(SDEFUN |HEUGCD;gcd;LBP;18| ((|listf| (|List| BP)) ($ (BP)))
        (|SPADfirst| (|HEUGCD;internal| (CONS 1 "gcd") |listf| $))) 

(SDEFUN |HEUGCD;gcdcofact;2L;19| ((|listf| (|List| BP)) ($ (|List| BP)))
        (|HEUGCD;internal| (CONS 3 "gcdcofact") |listf| $)) 

(DECLAIM (NOTINLINE |HeuGcd;|)) 

(DEFUN |HeuGcd| (#1=#:G940)
  (SPROG NIL
         (PROG (#2=#:G941)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|HeuGcd|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|HeuGcd;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|HeuGcd|)))))))))) 

(DEFUN |HeuGcd;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|HeuGcd| DV$1))
          (LETT $ (GETREFV 61))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|HeuGcd| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 4010021)
          (QSETREFV $ 41
                    (|InnerModularGcd| (|Integer|) |#1| 67108859
                                       (CONS (|function| |HEUGCD;myNextPrime|)
                                             $)))
          $))) 

(MAKEPROP '|HeuGcd| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|bigPrime| (|Integer|)
              (|IntegerPrimesPackage| 8) (0 . |nextPrime|)
              (|NonNegativeInteger|) (5 . |degree|) (|Boolean|) (10 . |zero?|)
              (15 . |Zero|) (19 . ~=) (25 . |leadingCoefficient|)
              (30 . |reductum|) (35 . ~=) (41 . |monomial|) (47 . +)
              (53 . |One|) (|List| 8) (57 . |member?|) |HEUGCD;lintgcd;LI;7|
              (63 . |coefficients|) (|List| 6) |HEUGCD;content;LL;8|
              (|Union| $ '"failed") (68 . |exquo|) (|Mapping| 13 6)
              (74 . |select|) (|List| 11) (80 . |member?|) (86 . |coerce|)
              (91 . |exquo|) (|PositiveInteger|) (97 . |One|)
              (101 . |position|) (107 . |elt|) 'IMG (113 . |elt|)
              (119 . |content|) (124 . |modularGcdPrimitive|) (129 . =)
              (135 . |minimumDegree|) (140 . *) (146 . *)
              (152 . |positiveRemainder|) (|SparseUnivariatePolynomial| 8)
              (158 . |makeSUP|) (|U32Vector|) (|U32VectorPolynomialOperations|)
              (163 . |to_mod_pa|) (169 . |gcd|) (176 . |degree|)
              |HEUGCD;gcdprim;LBP;16| |HEUGCD;gcdcofactprim;2L;17|
              |HEUGCD;gcd;LBP;18| |HEUGCD;gcdcofact;2L;19|)
           '#(|lintgcd| 181 |gcdprim| 186 |gcdcofactprim| 191 |gcdcofact| 196
              |gcd| 201 |content| 206)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|gcd| (|#1| (|List| |#1|))) T)
                                   '((|gcdprim| (|#1| (|List| |#1|))) T)
                                   '((|gcdcofact|
                                      ((|List| |#1|) (|List| |#1|)))
                                     T)
                                   '((|gcdcofactprim|
                                      ((|List| |#1|) (|List| |#1|)))
                                     T)
                                   '((|content|
                                      ((|List| (|Integer|)) (|List| |#1|)))
                                     T)
                                   '((|lintgcd|
                                      ((|Integer|) (|List| (|Integer|))))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 60
                                            '(1 9 8 8 10 1 6 11 0 12 1 6 13 0
                                              14 0 6 0 15 2 6 13 0 0 16 1 6 8 0
                                              17 1 6 0 0 18 2 8 13 0 0 19 2 6 0
                                              8 11 20 2 6 0 0 0 21 0 6 0 22 2
                                              23 13 8 0 24 1 6 23 0 26 2 6 29 0
                                              8 30 2 27 0 31 0 32 2 33 13 11 0
                                              34 1 6 0 8 35 2 6 29 0 0 36 0 37
                                              0 38 2 33 8 11 0 39 2 27 6 0 8 40
                                              2 6 8 0 8 42 1 6 8 0 43 1 41 6 27
                                              44 2 27 13 0 0 45 1 6 11 0 46 2 6
                                              0 0 0 47 2 6 0 8 0 48 2 8 0 0 0
                                              49 1 6 50 0 51 2 53 52 50 8 54 3
                                              53 52 52 52 8 55 1 53 8 52 56 1 0
                                              8 23 25 1 0 6 27 57 1 0 27 27 58
                                              1 0 27 27 60 1 0 6 27 59 1 0 23
                                              27 28)))))
           '|lookupComplete|)) 

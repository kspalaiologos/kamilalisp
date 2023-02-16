
(SDEFUN |EFSTRUC;realElem| ((|f| (F)) (|l| (|List| (|Symbol|))) ($ (F)))
        (SPROG NIL
               (SPADCALL (CONS #'|EFSTRUC;realElem!0| (VECTOR $ |l|)) |f|
                         (QREFELT $ 18)))) 

(SDEFUN |EFSTRUC;realElem!0| ((|k| NIL) ($$ NIL))
        (PROG (|l| $)
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|EFSTRUC;k2Elem| |k| |l| $))))) 

(SDEFUN |EFSTRUC;realElementary;FSF;2| ((|f| (F)) (|x| (|Symbol|)) ($ (F)))
        (|EFSTRUC;realElem| |f| (LIST |x|) $)) 

(SDEFUN |EFSTRUC;realElementary;2F;3| ((|f| (F)) ($ (F)))
        (|EFSTRUC;realElem| |f| (SPADCALL |f| (QREFELT $ 22)) $)) 

(SDEFUN |EFSTRUC;realLiouvillian;2F;4| ((|f| (F)) ($ (F)))
        (SPADCALL (CONS (|function| |EFSTRUC;k_to_liou|) $) |f| (QREFELT $ 18))) 

(SDEFUN |EFSTRUC;realLiouvillian;FSF;5| ((|f| (F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|EFSTRUC;realLiouvillian;FSF;5!0| (VECTOR $ |x|)) |f|
                (QREFELT $ 18)))) 

(SDEFUN |EFSTRUC;realLiouvillian;FSF;5!0| ((|k| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|EFSTRUC;k_to_liou1| |k| |x| $))))) 

(SDEFUN |EFSTRUC;toY| ((|ker| (|List| (|Kernel| F))) ($ (|List| F)))
        (SPROG ((|func| (F)) (#1=#:G834 NIL) (|k| NIL) (#2=#:G833 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# |ker|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |func| (|EFSTRUC;ktoY| |k| $))
                                    (|spadConstant| $ 26) (QREFELT $ 28))
                          (LETT #2# (CONS |func| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |EFSTRUC;toZ| ((|ker| (|List| (|Kernel| F))) ($ (|List| F)))
        (SPROG ((|func| (F)) (#1=#:G839 NIL) (|k| NIL) (#2=#:G838 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# |ker|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |func| (|EFSTRUC;ktoZ| |k| $))
                                    (|spadConstant| $ 26) (QREFELT $ 28))
                          (LETT #2# (CONS |func| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |EFSTRUC;toU| ((|ker| (|List| (|Kernel| F))) ($ (|List| F)))
        (SPROG ((|func| (F)) (#1=#:G844 NIL) (|k| NIL) (#2=#:G843 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# |ker|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |func| (|EFSTRUC;ktoU| |k| $))
                                    (|spadConstant| $ 26) (QREFELT $ 28))
                          (LETT #2# (CONS |func| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |EFSTRUC;toV| ((|ker| (|List| (|Kernel| F))) ($ (|List| F)))
        (SPROG ((|func| (F)) (#1=#:G849 NIL) (|k| NIL) (#2=#:G848 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# |ker|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL (LETT |func| (|EFSTRUC;ktoV| |k| $))
                                    (|spadConstant| $ 26) (QREFELT $ 28))
                          (LETT #2# (CONS |func| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |EFSTRUC;toR|
        ((|ker| (|List| (|Kernel| F))) (|x| (F)) ($ (|List| (|Kernel| F))))
        (SPROG NIL
               (SPADCALL (CONS #'|EFSTRUC;toR!0| (VECTOR |x| $)) |ker|
                         (QREFELT $ 37)))) 

(SDEFUN |EFSTRUC;toR!0| ((|s| NIL) ($$ NIL))
        (PROG ($ |x|)
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((SPADCALL |s| '|nthRoot| (QREFELT $ 30))
              (SPADCALL (SPADCALL (SPADCALL |s| (QREFELT $ 32)) (QREFELT $ 33))
                        |x| (QREFELT $ 34)))
             ('T NIL)))))) 

(SDEFUN |EFSTRUC;tanQ;F2F;11|
        ((|c| (|Fraction| (|Integer|))) (|x| (F)) ($ (F)))
        (SPROG ((#1=#:G862 NIL))
               (SPADCALL
                (SPADCALL
                 (SPADCALL
                  (SPADCALL |x|
                            (PROG1 (LETT #1# (SPADCALL |c| (QREFELT $ 39)))
                              (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                                '(|Integer|) #1#))
                            (QREFELT $ 43))
                  (QREFELT $ 45))
                 (QREFELT $ 47))
                (SPADCALL |c| (QREFELT $ 48)) (QREFELT $ 49)))) 

(SDEFUN |EFSTRUC;tanQ;F2F;12|
        ((|c| (|Fraction| (|Integer|))) (|x| (F)) ($ (F)))
        (SPROG ((#1=#:G865 NIL))
               (SPADCALL
                (SPADCALL
                 (SPADCALL |x|
                           (PROG1 (LETT #1# (SPADCALL |c| (QREFELT $ 39)))
                             (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                               '(|Integer|) #1#))
                           (QREFELT $ 43))
                 (QREFELT $ 45))
                (SPADCALL |c| (QREFELT $ 48)) (QREFELT $ 49)))) 

(SDEFUN |EFSTRUC;tanSum| ((|c| (F)) (|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G874 NIL) (|r| (|Union| (|Integer|) "failed")) (|k| (F)))
               (SEQ
                (EXIT
                 (SEQ (LETT |k| (SPADCALL |c| (QREFELT $ 16) (QREFELT $ 15)))
                      (SEQ (LETT |r| (SPADCALL |k| (QREFELT $ 52)))
                           (EXIT
                            (COND
                             ((QEQCAR |r| 0)
                              (COND
                               ((ODDP (QCDR |r|))
                                (PROGN
                                 (LETT #1#
                                       (SPADCALL
                                        (SPADCALL (SPADCALL |l| (QREFELT $ 53))
                                                  (QREFELT $ 54))
                                        (QREFELT $ 14)))
                                 (GO #2=#:G872))))))))
                      (EXIT
                       (SPADCALL (CONS (SPADCALL |c| (QREFELT $ 55)) |l|)
                                 (QREFELT $ 53)))))
                #2# (EXIT #1#)))) 

(SDEFUN |EFSTRUC;findQRelation|
        ((|lv| #1=(|List| (|Symbol|))) (|lpar| (|List| (|Symbol|)))
         (|lk| (|List| F)) (|ker| (F))
         ($
          (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                   (|:| |func| F) (|:| |fail| (|Boolean|)))))
        (SPROG
         ((|u| (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
          (#2=#:G906 NIL) (|j| NIL) (#3=#:G907 NIL) (|k| NIL) (#4=#:G904 NIL)
          (|i| NIL) (#5=#:G905 NIL) (|var| NIL) (|mat| (|Matrix| F))
          (|isconstant| (|Boolean|)) (#6=#:G902 NIL) (#7=#:G903 NIL)
          (|v| (|Vector| F)) (|lvv| #1#) (|m| (|NonNegativeInteger|))
          (#8=#:G900 NIL) (#9=#:G901 NIL) (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND ((NULL |lk|) (CONS 2 'T))
                (#10='T
                 (SEQ (LETT |isconstant| 'T) (LETT |m| (LENGTH |lv|))
                      (LETT |lvv| |lv|) (LETT |n| (LENGTH |lk|))
                      (LETT |v| (MAKEARR1 |m| (|spadConstant| $ 26)))
                      (SEQ (LETT |var| NIL) (LETT #9# |lv|) (LETT |i| 1)
                           (LETT #8# |m|) G190
                           (COND
                            ((OR (|greater_SI| |i| #8#) (ATOM #9#)
                                 (PROGN (LETT |var| (CAR #9#)) NIL))
                             (GO G191)))
                           (SEQ
                            (SPADCALL |v| |i|
                                      (SPADCALL |ker| |var| (QREFELT $ 57))
                                      (QREFELT $ 59))
                            (EXIT
                             (COND
                              (|isconstant|
                               (LETT |isconstant|
                                     (SPADCALL
                                      (SPADCALL |v| |i| (QREFELT $ 60))
                                      (|spadConstant| $ 26)
                                      (QREFELT $ 34)))))))
                           (LETT |i|
                                 (PROG1 (|inc_SI| |i|) (LETT #9# (CDR #9#))))
                           (GO G190) G191 (EXIT NIL))
                      (COND
                       (|isconstant|
                        (SEQ (LETT |m| (LENGTH |lpar|)) (LETT |lvv| |lpar|)
                             (LETT |v| (MAKEARR1 |m| (|spadConstant| $ 26)))
                             (EXIT
                              (SEQ (LETT |var| NIL) (LETT #7# |lpar|)
                                   (LETT |i| 1) (LETT #6# |m|) G190
                                   (COND
                                    ((OR (|greater_SI| |i| #6#) (ATOM #7#)
                                         (PROGN (LETT |var| (CAR #7#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (SPADCALL |v| |i|
                                              (SPADCALL |ker| |var|
                                                        (QREFELT $ 57))
                                              (QREFELT $ 59))
                                    (EXIT
                                     (COND
                                      (|isconstant|
                                       (LETT |isconstant|
                                             (SPADCALL
                                              (SPADCALL |v| |i| (QREFELT $ 60))
                                              (|spadConstant| $ 26)
                                              (QREFELT $ 34)))))))
                                   (LETT |i|
                                         (PROG1 (|inc_SI| |i|)
                                           (LETT #7# (CDR #7#))))
                                   (GO G190) G191 (EXIT NIL))))))
                      (EXIT
                       (COND
                        (|isconstant|
                         (SEQ
                          (SPADCALL (SPADCALL |ker| (QREFELT $ 62))
                                    (QREFELT $ 64))
                          (EXIT (|error| "Hidden constant detected"))))
                        (#10#
                         (SEQ
                          (LETT |mat|
                                (MAKE_MATRIX1 |m| |n| (|spadConstant| $ 26)))
                          (SEQ (LETT |var| NIL) (LETT #5# |lvv|) (LETT |i| 1)
                               (LETT #4# |m|) G190
                               (COND
                                ((OR (|greater_SI| |i| #4#) (ATOM #5#)
                                     (PROGN (LETT |var| (CAR #5#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |k| NIL) (LETT #3# |lk|)
                                      (LETT |j| 1) (LETT #2# |n|) G190
                                      (COND
                                       ((OR (|greater_SI| |j| #2#) (ATOM #3#)
                                            (PROGN (LETT |k| (CAR #3#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SPADCALL |mat| |i| |j|
                                                  (SPADCALL |k| |var|
                                                            (QREFELT $ 57))
                                                  (QREFELT $ 66))))
                                      (LETT |j|
                                            (PROG1 (|inc_SI| |j|)
                                              (LETT #3# (CDR #3#))))
                                      (GO G190) G191 (EXIT NIL))))
                               (LETT |i|
                                     (PROG1 (|inc_SI| |i|)
                                       (LETT #5# (CDR #5#))))
                               (GO G190) G191 (EXIT NIL))
                          (LETT |u| (SPADCALL |mat| |v| (QREFELT $ 69)))
                          (EXIT
                           (COND ((QEQCAR |u| 0) (CONS 0 (QCDR |u|)))
                                 (#10# (CONS 2 'T)))))))))))))) 

(SDEFUN |EFSTRUC;findLinearRelation1|
        ((|lk| (|List| F)) (|ker| (F))
         ($
          (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                   (|:| |func| F) (|:| |fail| (|Boolean|)))))
        (SPROG
         ((|u| (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
          (#1=#:G917 NIL) (|j| NIL) (#2=#:G918 NIL) (|k| NIL)
          (|v| (|Vector| F)) (|mat| (|Matrix| F)) (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND ((NULL |lk|) (CONS 2 'T))
                (#3='T
                 (SEQ (LETT |n| (LENGTH |lk|))
                      (LETT |mat| (MAKE_MATRIX1 1 |n| (|spadConstant| $ 26)))
                      (LETT |v| (MAKEARR1 1 |ker|))
                      (SEQ (LETT |k| NIL) (LETT #2# |lk|) (LETT |j| 1)
                           (LETT #1# |n|) G190
                           (COND
                            ((OR (|greater_SI| |j| #1#) (ATOM #2#)
                                 (PROGN (LETT |k| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL (SPADCALL |k| (QREFELT $ 22)))
                               (SPADCALL |mat| 1 |j| |k| (QREFELT $ 66)))
                              ('T
                               (SPADCALL |mat| 1 |j| (|spadConstant| $ 26)
                                         (QREFELT $ 66))))))
                           (LETT |j|
                                 (PROG1 (|inc_SI| |j|) (LETT #2# (CDR #2#))))
                           (GO G190) G191 (EXIT NIL))
                      (LETT |u| (SPADCALL |mat| |v| (QREFELT $ 69)))
                      (EXIT
                       (COND ((QEQCAR |u| 0) (CONS 0 (QCDR |u|)))
                             (#3# (CONS 2 'T)))))))))) 

(SDEFUN |EFSTRUC;transkers|
        ((|x| (|List| (|Kernel| F))) ($ (|List| (|Kernel| F))))
        (SPROG ((#1=#:G924 NIL) (|k| NIL) (#2=#:G923 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# |x|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((NULL
                           (SPADCALL (SPADCALL |k| (QREFELT $ 74))
                                     (QREFELT $ 72) (QREFELT $ 75)))
                          (LETT #2# (CONS |k| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |EFSTRUC;ktoQ| ((|ker| (|Kernel| F)) ($ (|Fraction| (|Integer|))))
        (SPROG ((|qu| (|Union| (|Fraction| (|Integer|)) "failed")) (|z| (F)))
               (SEQ
                (COND
                 ((SPADCALL |ker| '|log| (QREFELT $ 30))
                  (COND
                   ((|HasCategory| (QREFELT $ 7)
                                   (LIST '|RetractableTo|
                                         (LIST '|Fraction| '(|Integer|))))
                    (EXIT
                     (SEQ
                      (LETT |z|
                            (SPADCALL (SPADCALL |ker| (QREFELT $ 32)) 1
                                      (QREFELT $ 76)))
                      (LETT |qu| (SPADCALL |z| (QREFELT $ 78)))
                      (EXIT
                       (COND ((QEQCAR |qu| 0) (QCDR |qu|))
                             ('T (|spadConstant| $ 79))))))))))
                (EXIT (|spadConstant| $ 79))))) 

(SDEFUN |EFSTRUC;toQ|
        ((|lk| (|List| (|Kernel| F))) ($ (|List| (|Fraction| (|Integer|)))))
        (SPROG ((#1=#:G945 NIL) (|k| NIL) (#2=#:G944 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# |lk|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((COND ((SPADCALL |k| '|log| (QREFELT $ 30)) 'T)
                                ('T (SPADCALL |k| '|exp| (QREFELT $ 30))))
                          (LETT #2# (CONS (|EFSTRUC;ktoQ| |k| $) #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |EFSTRUC;findLinearRelation2|
        ((|lk| (|List| (|Kernel| F))) (|lz| (|List| F)) (|ker| (|Kernel| F))
         ($
          (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                   (|:| |func| F) (|:| |fail| (|Boolean|)))))
        (SPROG
         ((|nz| (F)) (|ly| (|List| F)) (#1=#:G999 NIL) (|x| NIL)
          (#2=#:G998 NIL) (#3=#:G997 NIL) (#4=#:G996 NIL)
          (|lpars1f| (|List| F)) (#5=#:G995 NIL) (|s| NIL) (#6=#:G994 NIL)
          (|lpars1| (|List| (|Symbol|))) (#7=#:G993 NIL) (|k| NIL)
          (#8=#:G992 NIL) (|lpars0| #9=(|List| (|Kernel| F))) (#10=#:G989 NIL)
          (|vv| (|Vector| (|Fraction| (|Integer|)))) (|lz1tonq| (F))
          (|kertond| (F)) (|nd| (|Integer|)) (|nq| (|Integer|))
          (|qratio| (|Fraction| (|Integer|)))
          (|fratio| (|Union| (|Float|) "failed")) (|Fratio| (F))
          (#11=#:G990 NIL) (|z1| NIL) (#12=#:G991 NIL) (|i| NIL)
          (|m| (|NonNegativeInteger|)) (|kerF| (F))
          (|u| (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
          (|q| (|Fraction| (|Integer|))) (|zkers| #9#) (|z| (F)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |z|
                  (SPADCALL (SPADCALL |ker| (QREFELT $ 32)) 1 (QREFELT $ 76)))
            (LETT |zkers|
                  (|EFSTRUC;transkers| (SPADCALL |z| (QREFELT $ 81)) $))
            (EXIT
             (COND
              ((NULL |zkers|)
               (SEQ (LETT |q| (|EFSTRUC;ktoQ| |ker| $))
                    (COND
                     ((NULL
                       (SPADCALL |q| (|spadConstant| $ 79) (QREFELT $ 82)))
                      (COND
                       ((NULL
                         (SPADCALL |q|
                                   (SPADCALL (|spadConstant| $ 79)
                                             (QREFELT $ 83))
                                   (QREFELT $ 82)))
                        (EXIT
                         (SEQ
                          (LETT |u|
                                (SPADCALL (|EFSTRUC;toQ| |lk| $) |q|
                                          (QREFELT $ 86)))
                          (EXIT
                           (COND ((QEQCAR |u| 0) (CONS 0 (QCDR |u|)))
                                 (#13='T (CONS 2 'T))))))))))
                    (LETT |kerF| (SPADCALL |ker| (QREFELT $ 88)))
                    (COND
                     ((|domainEqual| (QREFELT $ 7)
                                     (|Expression| (QREFELT $ 6)))
                      (COND
                       ((|HasCategory| (QREFELT $ 6)
                                       (LIST '|ConvertibleTo| '(|Float|)))
                        (COND
                         ((|HasCategory| (QREFELT $ 6) '(|IntegralDomain|))
                          (COND
                           ((|HasCategory| (QREFELT $ 6) '(|OrderedSet|))
                            (EXIT
                             (SEQ (LETT |m| (LENGTH |lz|))
                                  (SEQ (LETT |i| 1) (LETT #12# |m|)
                                       (LETT |z1| NIL) (LETT #11# |lz|) G190
                                       (COND
                                        ((OR (ATOM #11#)
                                             (PROGN (LETT |z1| (CAR #11#)) NIL)
                                             (|greater_SI| |i| #12#))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |Fratio|
                                              (SPADCALL |kerF|
                                                        (SPADCALL |z1|
                                                                  (QREFELT $
                                                                           89))
                                                        (QREFELT $ 15)))
                                        (LETT |fratio|
                                              (SPADCALL |Fratio| 20
                                                        (QREFELT $ 93)))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |fratio| 0)
                                           (SEQ
                                            (LETT |qratio|
                                                  (SPADCALL (QCDR |fratio|) 8
                                                            (QREFELT $ 96)))
                                            (COND
                                             ((OR
                                               (SPADCALL |qratio|
                                                         (|spadConstant| $ 97)
                                                         (QREFELT $ 82))
                                               (OR
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL (QCDR |fratio|)
                                                             (SPADCALL |qratio|
                                                                       (QREFELT
                                                                        $ 98))
                                                             (QREFELT $ 99))
                                                   (SPADCALL 1 0 10
                                                             (QREFELT $ 100))
                                                   (QREFELT $ 101))
                                                  (QREFELT $ 102))
                                                 (SPADCALL 1 -16 10
                                                           (QREFELT $ 100))
                                                 (QREFELT $ 103))
                                                (OR
                                                 (>
                                                  (ABS
                                                   (LETT |nq|
                                                         (SPADCALL |qratio|
                                                                   (QREFELT $
                                                                            48))))
                                                  100)
                                                 (>
                                                  (ABS
                                                   (LETT |nd|
                                                         (SPADCALL |qratio|
                                                                   (QREFELT $
                                                                            39))))
                                                  100))))
                                              (EXIT "iterate")))
                                            (LETT |kertond|
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL |ker|
                                                              (QREFELT $ 32))
                                                    1 (QREFELT $ 76))
                                                   |nd| (QREFELT $ 104)))
                                            (EXIT
                                             (COND
                                              ((> |nq| 0)
                                               (SEQ
                                                (LETT |lz1tonq|
                                                      (SPADCALL |z1| |nq|
                                                                (QREFELT $
                                                                         104)))
                                                (EXIT
                                                 (COND
                                                  ((SPADCALL |kertond|
                                                             |lz1tonq|
                                                             (QREFELT $ 34))
                                                   (SEQ
                                                    (LETT |vv|
                                                          (SPADCALL |m|
                                                                    (QREFELT $
                                                                             106)))
                                                    (QSETAREF1O |vv| |i|
                                                                |qratio| 1)
                                                    (EXIT
                                                     (PROGN
                                                      (LETT #10# (CONS 0 |vv|))
                                                      (GO #14=#:G988)))))))))
                                              ('T
                                               (SEQ
                                                (LETT |lz1tonq|
                                                      (SPADCALL |z1| (- |nq|)
                                                                (QREFELT $
                                                                         104)))
                                                (EXIT
                                                 (COND
                                                  ((SPADCALL
                                                    (SPADCALL |kertond|
                                                              |lz1tonq|
                                                              (QREFELT $ 107))
                                                    (|spadConstant| $ 71)
                                                    (QREFELT $ 34))
                                                   (SEQ
                                                    (LETT |vv|
                                                          (SPADCALL |m|
                                                                    (QREFELT $
                                                                             106)))
                                                    (QSETAREF1O |vv| |i|
                                                                |qratio| 1)
                                                    (EXIT
                                                     (PROGN
                                                      (LETT #10# (CONS 0 |vv|))
                                                      (GO #14#))))))))))))))))
                                       (LETT #11#
                                             (PROG1 (CDR #11#)
                                               (LETT |i| (|inc_SI| |i|))))
                                       (GO G190) G191 (EXIT NIL))
                                  (EXIT (CONS 2 'T))))))))))))
                    (EXIT (CONS 2 'T))))
              (#13#
               (SEQ (LETT |lpars0| (|EFSTRUC;transkers| |lk| $))
                    (LETT |lpars1|
                          (PROGN
                           (LETT #8# NIL)
                           (SEQ (LETT |k| NIL) (LETT #7# |lpars0|) G190
                                (COND
                                 ((OR (ATOM #7#)
                                      (PROGN (LETT |k| (CAR #7#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #8#
                                        (CONS (SPADCALL (QREFELT $ 108))
                                              #8#))))
                                (LETT #7# (CDR #7#)) (GO G190) G191
                                (EXIT (NREVERSE #8#)))))
                    (LETT |lpars1f|
                          (PROGN
                           (LETT #6# NIL)
                           (SEQ (LETT |s| NIL) (LETT #5# |lpars1|) G190
                                (COND
                                 ((OR (ATOM #5#)
                                      (PROGN (LETT |s| (CAR #5#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #6#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL |s| (QREFELT $ 109))
                                          (QREFELT $ 88))
                                         #6#))))
                                (LETT #5# (CDR #5#)) (GO G190) G191
                                (EXIT (NREVERSE #6#)))))
                    (COND
                     ((SPADCALL |ker| '|log| (QREFELT $ 30))
                      (SEQ
                       (LETT |ly|
                             (PROGN
                              (LETT #4# NIL)
                              (SEQ (LETT |x| NIL) (LETT #3# |lz|) G190
                                   (COND
                                    ((OR (ATOM #3#)
                                         (PROGN (LETT |x| (CAR #3#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #4#
                                           (CONS
                                            (SPADCALL
                                             (SPADCALL |x| |lpars0| |lpars1f|
                                                       (QREFELT $ 111))
                                             (QREFELT $ 89))
                                            #4#))))
                                   (LETT #3# (CDR #3#)) (GO G190) G191
                                   (EXIT (NREVERSE #4#)))))
                       (EXIT
                        (LETT |nz|
                              (SPADCALL
                               (SPADCALL |z| |lpars0| |lpars1f|
                                         (QREFELT $ 111))
                               (QREFELT $ 89))))))
                     ((NULL (SPADCALL |ker| '|atan| (QREFELT $ 30)))
                      (|error|
                       "findLinearRelation2: kernel should be log or atan"))
                     ('T
                      (SEQ
                       (LETT |ly|
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |x| NIL) (LETT #1# |lz|) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |x| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS
                                            (SPADCALL
                                             (SPADCALL |x| |lpars0| |lpars1f|
                                                       (QREFELT $ 111))
                                             (QREFELT $ 112))
                                            #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#)))))
                       (EXIT
                        (LETT |nz|
                              (SPADCALL
                               (SPADCALL |z| |lpars0| |lpars1f|
                                         (QREFELT $ 111))
                               (QREFELT $ 112)))))))
                    (EXIT
                     (|EFSTRUC;findQRelation| NIL |lpars1| |ly| |nz| $))))))))
          #14# (EXIT #10#)))) 

(SDEFUN |EFSTRUC;findRelation|
        ((|lv| (|List| (|Symbol|))) (|lpar| (|List| (|Symbol|)))
         (|lk| (|List| (|Kernel| F))) (|ker| (|Kernel| F))
         ($
          (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                   (|:| |func| F) (|:| |fail| (|Boolean|)))))
        (SPROG ((#1=#:G1020 NIL) (|x| NIL) (#2=#:G1019 NIL))
               (SEQ
                (COND
                 ((OR (SPADCALL |ker| '|log| (QREFELT $ 30))
                      (SPADCALL |ker| '|exp| (QREFELT $ 30)))
                  (COND
                   ((NULL
                     (SPADCALL (SPADCALL |ker| (QREFELT $ 88)) (QREFELT $ 22)))
                    (COND
                     ((SPADCALL |ker| '|exp| (QREFELT $ 30))
                      (|EFSTRUC;findLinearRelation1| (|EFSTRUC;toY| |lk| $)
                       (|EFSTRUC;ktoY| |ker| $) $))
                     (#3='T
                      (|EFSTRUC;findLinearRelation2| |lk|
                       (|EFSTRUC;toZ| |lk| $) |ker| $))))
                   (#3#
                    (|EFSTRUC;findQRelation| |lv| |lpar| (|EFSTRUC;toY| |lk| $)
                     (|EFSTRUC;ktoY| |ker| $) $))))
                 ((OR (SPADCALL |ker| '|atan| (QREFELT $ 30))
                      (SPADCALL |ker| '|tan| (QREFELT $ 30)))
                  (COND
                   ((NULL
                     (SPADCALL (SPADCALL |ker| (QREFELT $ 88)) (QREFELT $ 22)))
                    (COND
                     ((SPADCALL |ker| '|tan| (QREFELT $ 30))
                      (|EFSTRUC;findLinearRelation1| (|EFSTRUC;toU| |lk| $)
                       (|EFSTRUC;ktoU| |ker| $) $))
                     (#3#
                      (|EFSTRUC;findLinearRelation2| |lk|
                       (|EFSTRUC;toV| |lk| $) |ker| $))))
                   (#3#
                    (|EFSTRUC;findQRelation| |lv| |lpar| (|EFSTRUC;toU| |lk| $)
                     (|EFSTRUC;ktoU| |ker| $) $))))
                 ('T
                  (COND
                   ((SPADCALL |ker| '|nthRoot| (QREFELT $ 30))
                    (|EFSTRUC;rootDep| |lk| |ker| $))
                   (#3#
                    (SEQ
                     (COND
                      ((QREFELT $ 10)
                       (COND
                        ((SPADCALL |ker| '|factorial| (QREFELT $ 30))
                         (EXIT
                          (|EFSTRUC;factdeprel|
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |x| NIL) (LETT #1# |lk|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |x| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((COND
                                      ((SPADCALL |x| '|factorial|
                                                 (QREFELT $ 30))
                                       (SPADCALL |x| |ker| (QREFELT $ 113)))
                                      (#3# NIL))
                                     (LETT #2# (CONS |x| #2#))))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           |ker| $))))))
                     (EXIT (CONS 2 'T)))))))))) 

(SDEFUN |EFSTRUC;ktoY| ((|k| (|Kernel| F)) ($ (F)))
        (COND
         ((SPADCALL |k| '|log| (QREFELT $ 30)) (SPADCALL |k| (QREFELT $ 88)))
         ((SPADCALL |k| '|exp| (QREFELT $ 30))
          (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
         ((SPADCALL |k| '|lambertW| (QREFELT $ 30))
          (SPADCALL |k| (QREFELT $ 88)))
         ('T (|spadConstant| $ 26)))) 

(SDEFUN |EFSTRUC;ktoZ| ((|k| (|Kernel| F)) ($ (F)))
        (COND
         ((SPADCALL |k| '|log| (QREFELT $ 30))
          (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
         ((SPADCALL |k| '|exp| (QREFELT $ 30)) (SPADCALL |k| (QREFELT $ 88)))
         ((SPADCALL |k| '|lambertW| (QREFELT $ 30))
          (SPADCALL (|SPADfirst| (SPADCALL |k| (QREFELT $ 32)))
                    (SPADCALL |k| (QREFELT $ 88)) (QREFELT $ 15)))
         ('T (|spadConstant| $ 26)))) 

(SDEFUN |EFSTRUC;ktoU| ((|k| (|Kernel| F)) ($ (F)))
        (COND
         ((SPADCALL |k| '|atan| (QREFELT $ 30)) (SPADCALL |k| (QREFELT $ 88)))
         ((SPADCALL |k| '|tan| (QREFELT $ 30))
          (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
         ('T (|spadConstant| $ 26)))) 

(SDEFUN |EFSTRUC;ktoV| ((|k| (|Kernel| F)) ($ (F)))
        (COND
         ((SPADCALL |k| '|tan| (QREFELT $ 30)) (SPADCALL |k| (QREFELT $ 88)))
         ((SPADCALL |k| '|atan| (QREFELT $ 30))
          (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
         ('T (|spadConstant| $ 26)))) 

(SDEFUN |EFSTRUC;smp_map|
        ((|f| (|Mapping| F (|Kernel| F)))
         (|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) ($ (F)))
        (SPADCALL |f| (ELT $ 114) |p| (QREFELT $ 118))) 

(SDEFUN |EFSTRUC;rmap;M2F;26|
        ((|f| (|Mapping| F (|Kernel| F))) (|e| (F)) ($ (F)))
        (SPADCALL (|EFSTRUC;smp_map| |f| (SPADCALL |e| (QREFELT $ 120)) $)
                  (|EFSTRUC;smp_map| |f| (SPADCALL |e| (QREFELT $ 121)) $)
                  (QREFELT $ 15))) 

(SDEFUN |EFSTRUC;k2Elem0|
        ((|k| (|Kernel| F)) (|op| (|BasicOperator|)) (|args| (|List| F))
         ($ (F)))
        (SPROG ((|tz2| (F)) (|iez| (F)) (|ez| (F)) (|z| (F)))
               (SEQ (LETT |z| (|SPADfirst| |args|))
                    (EXIT
                     (COND
                      ((SPADCALL |op| '|%power| (QREFELT $ 127))
                       (COND
                        ((SPADCALL |z| (QREFELT $ 128)) (|spadConstant| $ 26))
                        (#1='T
                         (SPADCALL
                          (SPADCALL (SPADCALL |args| (QREFELT $ 129))
                                    (SPADCALL |z| (QREFELT $ 89))
                                    (QREFELT $ 107))
                          (QREFELT $ 130)))))
                      ((SPADCALL |op| '|cot| (QREFELT $ 127))
                       (SPADCALL (SPADCALL |z| (QREFELT $ 55)) (QREFELT $ 54)))
                      ((SPADCALL |op| '|acot| (QREFELT $ 127))
                       (COND
                        ((SPADCALL |z| (|spadConstant| $ 26) (QREFELT $ 34))
                         (SPADCALL |z| (QREFELT $ 131)))
                        (#1#
                         (SPADCALL (SPADCALL |z| (QREFELT $ 54))
                                   (QREFELT $ 112)))))
                      ((SPADCALL |op| '|asin| (QREFELT $ 127))
                       (COND
                        ((SPADCALL (SPADCALL |z| 2 (QREFELT $ 132))
                                   (|spadConstant| $ 71) (QREFELT $ 34))
                         (SPADCALL |z| (QREFELT $ 133)))
                        (#1#
                         (SPADCALL
                          (SPADCALL |z|
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 71)
                                               (SPADCALL |z| 2 (QREFELT $ 132))
                                               (QREFELT $ 134))
                                     (QREFELT $ 135))
                                    (QREFELT $ 15))
                          (QREFELT $ 112)))))
                      ((SPADCALL |op| '|acos| (QREFELT $ 127))
                       (COND
                        ((SPADCALL |z| (|spadConstant| $ 26) (QREFELT $ 34))
                         (SPADCALL |z| (QREFELT $ 136)))
                        (#1#
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 71)
                                      (SPADCALL |z| 2 (QREFELT $ 132))
                                      (QREFELT $ 134))
                            (QREFELT $ 135))
                           |z| (QREFELT $ 15))
                          (QREFELT $ 112)))))
                      ((SPADCALL |op| '|asec| (QREFELT $ 127))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL |z| 2 (QREFELT $ 132))
                                   (|spadConstant| $ 71) (QREFELT $ 134))
                         (QREFELT $ 135))
                        (QREFELT $ 112)))
                      ((SPADCALL |op| '|acsc| (QREFELT $ 127))
                       (COND
                        ((SPADCALL (SPADCALL |z| 2 (QREFELT $ 132))
                                   (|spadConstant| $ 71) (QREFELT $ 34))
                         (SPADCALL |z| (QREFELT $ 137)))
                        (#1#
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |z| 2 (QREFELT $ 132))
                                      (|spadConstant| $ 71) (QREFELT $ 134))
                            (QREFELT $ 135))
                           (QREFELT $ 54))
                          (QREFELT $ 112)))))
                      ((SPADCALL |op| '|asinh| (QREFELT $ 127))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 71)
                                    (SPADCALL |z| 2 (QREFELT $ 132))
                                    (QREFELT $ 138))
                          (QREFELT $ 135))
                         |z| (QREFELT $ 138))
                        (QREFELT $ 89)))
                      ((SPADCALL |op| '|acosh| (QREFELT $ 127))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |z| 2 (QREFELT $ 132))
                                    (|spadConstant| $ 71) (QREFELT $ 134))
                          (QREFELT $ 135))
                         |z| (QREFELT $ 138))
                        (QREFELT $ 89)))
                      ((SPADCALL |op| '|atanh| (QREFELT $ 127))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL |z| (|spadConstant| $ 71) (QREFELT $ 138))
                          (SPADCALL (|spadConstant| $ 71) |z| (QREFELT $ 134))
                          (QREFELT $ 15))
                         (QREFELT $ 89))
                        (SPADCALL 2 (QREFELT $ 13)) (QREFELT $ 15)))
                      ((SPADCALL |op| '|acoth| (QREFELT $ 127))
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL |z| (|spadConstant| $ 71) (QREFELT $ 138))
                          (SPADCALL |z| (|spadConstant| $ 71) (QREFELT $ 134))
                          (QREFELT $ 15))
                         (QREFELT $ 89))
                        (SPADCALL 2 (QREFELT $ 13)) (QREFELT $ 15)))
                      ((SPADCALL |op| '|asech| (QREFELT $ 127))
                       (SPADCALL
                        (SPADCALL (SPADCALL |z| (QREFELT $ 54))
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |z| 2 (QREFELT $ 132))
                                              (QREFELT $ 54))
                                    (|spadConstant| $ 71) (QREFELT $ 134))
                                   (QREFELT $ 135))
                                  (QREFELT $ 138))
                        (QREFELT $ 89)))
                      ((SPADCALL |op| '|acsch| (QREFELT $ 127))
                       (SPADCALL
                        (SPADCALL (SPADCALL |z| (QREFELT $ 54))
                                  (SPADCALL
                                   (SPADCALL (|spadConstant| $ 71)
                                             (SPADCALL
                                              (SPADCALL |z| 2 (QREFELT $ 132))
                                              (QREFELT $ 54))
                                             (QREFELT $ 138))
                                   (QREFELT $ 135))
                                  (QREFELT $ 138))
                        (QREFELT $ 89)))
                      ((OR (SPADCALL |op| '|%paren| (QREFELT $ 127))
                           (SPADCALL |op| '|%box| (QREFELT $ 127)))
                       (COND ((NULL (CDR |args|)) |z|)
                             (#1# (SPADCALL |k| (QREFELT $ 88)))))
                      ('T
                       (SEQ
                        (COND
                         ((SPADCALL |op| (QREFELT $ 8) (QREFELT $ 75))
                          (LETT |iez|
                                (SPADCALL
                                 (LETT |ez| (SPADCALL |z| (QREFELT $ 130)))
                                 (QREFELT $ 54)))))
                        (EXIT
                         (COND
                          ((SPADCALL |op| '|sinh| (QREFELT $ 127))
                           (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 134))
                                     (SPADCALL 2 (QREFELT $ 13))
                                     (QREFELT $ 15)))
                          ((SPADCALL |op| '|cosh| (QREFELT $ 127))
                           (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 138))
                                     (SPADCALL 2 (QREFELT $ 13))
                                     (QREFELT $ 15)))
                          ((SPADCALL |op| '|tanh| (QREFELT $ 127))
                           (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 134))
                                     (SPADCALL |ez| |iez| (QREFELT $ 138))
                                     (QREFELT $ 15)))
                          ((SPADCALL |op| '|coth| (QREFELT $ 127))
                           (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 138))
                                     (SPADCALL |ez| |iez| (QREFELT $ 134))
                                     (QREFELT $ 15)))
                          ((SPADCALL |op| '|sech| (QREFELT $ 127))
                           (SPADCALL 2
                                     (SPADCALL
                                      (SPADCALL |ez| |iez| (QREFELT $ 138))
                                      (QREFELT $ 54))
                                     (QREFELT $ 139)))
                          ((SPADCALL |op| '|csch| (QREFELT $ 127))
                           (SPADCALL 2
                                     (SPADCALL
                                      (SPADCALL |ez| |iez| (QREFELT $ 134))
                                      (QREFELT $ 54))
                                     (QREFELT $ 139)))
                          (#1#
                           (SEQ
                            (COND
                             ((SPADCALL |op| (QREFELT $ 9) (QREFELT $ 75))
                              (LETT |tz2|
                                    (SPADCALL
                                     (SPADCALL |z| (SPADCALL 2 (QREFELT $ 13))
                                               (QREFELT $ 15))
                                     (QREFELT $ 55)))))
                            (EXIT
                             (COND
                              ((SPADCALL |op| '|sin| (QREFELT $ 127))
                               (SPADCALL (SPADCALL 2 |tz2| (QREFELT $ 139))
                                         (SPADCALL (|spadConstant| $ 71)
                                                   (SPADCALL |tz2| 2
                                                             (QREFELT $ 132))
                                                   (QREFELT $ 138))
                                         (QREFELT $ 15)))
                              ((SPADCALL |op| '|cos| (QREFELT $ 127))
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 71)
                                          (SPADCALL |tz2| 2 (QREFELT $ 132))
                                          (QREFELT $ 134))
                                (SPADCALL (|spadConstant| $ 71)
                                          (SPADCALL |tz2| 2 (QREFELT $ 132))
                                          (QREFELT $ 138))
                                (QREFELT $ 15)))
                              ((SPADCALL |op| '|sec| (QREFELT $ 127))
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 71)
                                          (SPADCALL |tz2| 2 (QREFELT $ 132))
                                          (QREFELT $ 138))
                                (SPADCALL (|spadConstant| $ 71)
                                          (SPADCALL |tz2| 2 (QREFELT $ 132))
                                          (QREFELT $ 134))
                                (QREFELT $ 15)))
                              ((SPADCALL |op| '|csc| (QREFELT $ 127))
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 71)
                                          (SPADCALL |tz2| 2 (QREFELT $ 132))
                                          (QREFELT $ 138))
                                (SPADCALL 2 |tz2| (QREFELT $ 139))
                                (QREFELT $ 15)))
                              (#1#
                               (SPADCALL |op| |args|
                                         (QREFELT $ 141)))))))))))))))) 

(SDEFUN |EFSTRUC;do_int| ((|op| (|BasicOperator|)) (|args| (|List| F)) ($ (F)))
        (SPROG
         ((|dvs| (|List| F)) (#1=#:G1091 NIL) (|v| NIL) (#2=#:G1090 NIL)
          (|vfs| (|List| F)) (#3=#:G1089 NIL) (#4=#:G1088 NIL)
          (|vars| (|List| (|Symbol|))) (|kf1| (F)))
         (SEQ (LETT |kf1| (SPADCALL |op| |args| (QREFELT $ 141)))
              (LETT |vars| (SPADCALL |kf1| (QREFELT $ 22)))
              (LETT |vfs|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |v| NIL) (LETT #3# |vars|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |v| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS (SPADCALL |v| (QREFELT $ 142)) #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |dvs|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |v| NIL) (LETT #1# |vars|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL
                                    (SPADCALL |kf1| |v| (QREFELT $ 143))
                                    (QREFELT $ 24))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (COND ((SPADCALL (ELT $ 128) |dvs| (QREFELT $ 146)) |kf1|)
                     ('T
                      (SPADCALL (QREFELT $ 126)
                                (SPADCALL |vfs| |dvs| (QREFELT $ 147))
                                (QREFELT $ 148)))))))) 

(SDEFUN |EFSTRUC;k_to_liou| ((|k| (|Kernel| F)) ($ (F)))
        (SPROG
         ((#1=#:G1107 NIL) (#2=#:G1106 NIL) (|i| (|Integer|))
          (|iu| (|Union| (|Integer|) "failed")) (|nm| (|Symbol|))
          (|args| (|List| F)) (#3=#:G1109 NIL) (|a| NIL) (#4=#:G1108 NIL)
          (|op| (|BasicOperator|)))
         (SEQ (LETT |op| (SPADCALL |k| (QREFELT $ 74)))
              (LETT |args|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |a| NIL)
                          (LETT #3# (SPADCALL |k| (QREFELT $ 32))) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |a| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS (SPADCALL |a| (QREFELT $ 24)) #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (EXIT
               (COND ((NULL |args|) (SPADCALL |k| (QREFELT $ 88)))
                     ('T
                      (SEQ
                       (EXIT
                        (SEQ
                         (COND
                          ((SPADCALL |op| '|prim| (QREFELT $ 75))
                           (COND
                            ((NULL (SPADCALL |op| '|%iint| (QREFELT $ 127)))
                             (EXIT (|EFSTRUC;do_int| |op| |args| $))))))
                         (LETT |nm| (SPADCALL |op| (QREFELT $ 149)))
                         (COND
                          ((EQUAL |nm| '|polylog|)
                           (SEQ
                            (LETT |iu|
                                  (SPADCALL (|SPADfirst| |args|)
                                            (QREFELT $ 52)))
                            (EXIT
                             (COND
                              ((QEQCAR |iu| 0)
                               (PROGN
                                (LETT #1#
                                      (SEQ
                                       (EXIT
                                        (SEQ
                                         (SEQ (LETT |i| (QCDR |iu|))
                                              (EXIT
                                               (COND
                                                ((> |i| 0)
                                                 (COND
                                                  ((< |i| 10)
                                                   (PROGN
                                                    (LETT #2#
                                                          (|EFSTRUC;do_int|
                                                           |op| |args| $))
                                                    (GO #5=#:G1100))))))))
                                         (EXIT
                                          (|EFSTRUC;k2Elem0| |k| |op| |args|
                                           $))))
                                       #5# (EXIT #2#)))
                                (GO #6=#:G1103))))))))
                         (EXIT (|EFSTRUC;k2Elem0| |k| |op| |args| $))))
                       #6# (EXIT #1#)))))))) 

(SDEFUN |EFSTRUC;do_int1|
        ((|op| (|BasicOperator|)) (|args| (|List| F)) (|x| #1=(|Symbol|))
         ($ (F)))
        (SPROG
         ((|dvs| (|List| F)) (#2=#:G1123 NIL) (|v| NIL) (#3=#:G1122 NIL)
          (|vfs| (|List| F)) (#4=#:G1121 NIL) (#5=#:G1120 NIL)
          (|vars| (|List| #1#)) (|kf1| (F)))
         (SEQ (LETT |kf1| (SPADCALL |op| |args| (QREFELT $ 141)))
              (LETT |vars| (LIST |x|))
              (LETT |vfs|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |v| NIL) (LETT #4# |vars|) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |v| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #5#
                                  (CONS (SPADCALL |v| (QREFELT $ 142)) #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (LETT |dvs|
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |v| NIL) (LETT #2# |vars|) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #3#
                                  (CONS
                                   (SPADCALL
                                    (SPADCALL |kf1| |v| (QREFELT $ 143)) |x|
                                    (QREFELT $ 25))
                                   #3#))))
                          (LETT #2# (CDR #2#)) (GO G190) G191
                          (EXIT (NREVERSE #3#)))))
              (EXIT
               (COND ((SPADCALL (ELT $ 128) |dvs| (QREFELT $ 146)) |kf1|)
                     ('T
                      (SPADCALL (QREFELT $ 126)
                                (SPADCALL |vfs| |dvs| (QREFELT $ 147))
                                (QREFELT $ 148)))))))) 

(SDEFUN |EFSTRUC;k_to_liou1| ((|k| (|Kernel| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG
         ((#1=#:G1148 NIL) (#2=#:G1147 NIL) (|i| (|Integer|))
          (|iu| (|Union| (|Integer|) "failed")) (|nm| (|Symbol|))
          (|args| (|List| F)) (#3=#:G1150 NIL) (|a| NIL) (#4=#:G1149 NIL)
          (|op| (|BasicOperator|)))
         (SEQ (LETT |op| (SPADCALL |k| (QREFELT $ 74)))
              (LETT |args|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |a| NIL)
                          (LETT #3# (SPADCALL |k| (QREFELT $ 32))) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |a| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS (SPADCALL |a| |x| (QREFELT $ 25))
                                        #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (EXIT
               (COND ((NULL |args|) (SPADCALL |k| (QREFELT $ 88)))
                     ('T
                      (SEQ
                       (EXIT
                        (SEQ
                         (COND
                          ((SPADCALL |op| '|prim| (QREFELT $ 75))
                           (COND
                            ((NULL (SPADCALL |op| '|%iint| (QREFELT $ 127)))
                             (EXIT (|EFSTRUC;do_int1| |op| |args| |x| $))))))
                         (LETT |nm| (SPADCALL |op| (QREFELT $ 149)))
                         (COND
                          ((EQUAL |nm| '|Gamma2|)
                           (COND
                            ((SPADCALL
                              (SPADCALL (|SPADfirst| |args|) |x|
                                        (QREFELT $ 143))
                              (|spadConstant| $ 26) (QREFELT $ 34))
                             (EXIT (|EFSTRUC;do_int1| |op| |args| |x| $))))))
                         (COND
                          ((EQUAL |nm| '|polylog|)
                           (SEQ
                            (LETT |iu|
                                  (SPADCALL (|SPADfirst| |args|)
                                            (QREFELT $ 52)))
                            (EXIT
                             (COND
                              ((QEQCAR |iu| 0)
                               (PROGN
                                (LETT #1#
                                      (SEQ
                                       (EXIT
                                        (SEQ
                                         (SEQ (LETT |i| (QCDR |iu|))
                                              (EXIT
                                               (COND
                                                ((> |i| 0)
                                                 (COND
                                                  ((< |i| 10)
                                                   (PROGN
                                                    (LETT #2#
                                                          (|EFSTRUC;do_int|
                                                           |op| |args| $))
                                                    (GO #5=#:G1134))))))))
                                         (EXIT
                                          (|EFSTRUC;k2Elem0| |k| |op| |args|
                                           $))))
                                       #5# (EXIT #2#)))
                                (GO #6=#:G1144))))))))
                         (COND
                          ((OR (EQUAL |nm| '|ellipticE2|)
                               (EQUAL |nm| '|ellipticF|))
                           (COND
                            ((SPADCALL
                              (SPADCALL (SPADCALL |args| 2 (QREFELT $ 76)) |x|
                                        (QREFELT $ 143))
                              (|spadConstant| $ 26) (QREFELT $ 34))
                             (EXIT (|EFSTRUC;do_int1| |op| |args| |x| $))))))
                         (COND
                          ((EQUAL |nm| '|ellipticPi|)
                           (COND
                            ((SPADCALL
                              (SPADCALL (SPADCALL |args| 2 (QREFELT $ 76)) |x|
                                        (QREFELT $ 143))
                              (|spadConstant| $ 26) (QREFELT $ 34))
                             (COND
                              ((SPADCALL
                                (SPADCALL (SPADCALL |args| 3 (QREFELT $ 76))
                                          |x| (QREFELT $ 143))
                                (|spadConstant| $ 26) (QREFELT $ 34))
                               (EXIT
                                (|EFSTRUC;do_int1| |op| |args| |x| $))))))))
                         (EXIT (|EFSTRUC;k2Elem0| |k| |op| |args| $))))
                       #6# (EXIT #1#)))))))) 

(SDEFUN |EFSTRUC;k2Elem| ((|k| (|Kernel| F)) (|l| (|List| (|Symbol|))) ($ (F)))
        (SPROG
         ((|args| (|List| F)) (#1=#:G1156 NIL) (|a| NIL) (#2=#:G1155 NIL)
          (|op| (|BasicOperator|)))
         (SEQ (LETT |op| (SPADCALL |k| (QREFELT $ 74)))
              (LETT |args|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |a| NIL)
                          (LETT #1# (SPADCALL |k| (QREFELT $ 32))) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (|EFSTRUC;realElem| |a| |l| $) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (COND ((NULL |args|) (SPADCALL |k| (QREFELT $ 88)))
                     ('T (|EFSTRUC;k2Elem0| |k| |op| |args| $))))))) 

(SDEFUN |EFSTRUC;depeval|
        ((|lf| (|List| F)) (|lk| (|List| (|Kernel| F))) (|k| (|Kernel| F))
         (|v| (|Vector| (|Fraction| (|Integer|))))
         ($
          (|Record| (|:| |funcs| (|List| F)) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (COND
         ((SPADCALL |k| '|log| (QREFELT $ 30))
          (|EFSTRUC;logeval| |lf| |lk| |k| |v| $))
         ((SPADCALL |k| '|exp| (QREFELT $ 30))
          (|EFSTRUC;expeval| |lf| |lk| |k| |v| $))
         ((SPADCALL |k| '|tan| (QREFELT $ 30))
          (|EFSTRUC;taneval| |lf| |lk| |k| |v| $))
         ((SPADCALL |k| '|atan| (QREFELT $ 30))
          (|EFSTRUC;ataneval| |lf| |lk| |k| |v| $))
         ((SPADCALL |k| '|nthRoot| (QREFELT $ 30))
          (|EFSTRUC;rooteval| |lf| |lk| |k|
           (SPADCALL |v| (SPADCALL |v| (QREFELT $ 150)) (QREFELT $ 151)) $))
         ('T (VECTOR |lf| NIL NIL)))) 

(SDEFUN |EFSTRUC;rooteval|
        ((|lf| (|List| F)) (|lk| (|List| (|Kernel| F))) (|k| (|Kernel| F))
         (|n| (|Fraction| (|Integer|)))
         ($
          (|Record| (|:| |funcs| (|List| F)) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPROG
         ((|nlf| (|List| F)) (#1=#:G1178 NIL) (|f| NIL) (#2=#:G1177 NIL)
          (|lv| (|List| F)) (#3=#:G1176 NIL) (|r| NIL) (#4=#:G1175 NIL)
          (|l| (|List| (|Kernel| F))) (#5=#:G1174 NIL) (#6=#:G1173 NIL)
          (|nv| (F)) (|m| (|Integer|)) (|x| (F)))
         (SEQ
          (LETT |nv|
                (SPADCALL
                 (LETT |x| (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
                 (LETT |m| (SPADCALL |n| (QREFELT $ 152))) (QREFELT $ 153)))
          (LETT |l|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |r| NIL)
                      (LETT #5# (CONS |k| (|EFSTRUC;toR| |lk| |x| $))) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |r| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |r| (QREFELT $ 32))
                                      (QREFELT $ 154))
                            (QREFELT $ 155))
                           |m| (QREFELT $ 156))
                          (LETT #6# (CONS |r| #6#))))))
                      (LETT #5# (CDR #5#)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (LETT |lv|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |r| NIL) (LETT #3# |l|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |r| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS
                               (SPADCALL |nv|
                                         (SPADCALL |n|
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL |r|
                                                                (QREFELT $ 32))
                                                      (QREFELT $ 154))
                                                     (QREFELT $ 155))
                                                    (QREFELT $ 157))
                                                   (QREFELT $ 158))
                                         (QREFELT $ 159))
                               #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |nlf|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |f| NIL) (LETT #1# |lf|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |f| |l| |lv| (QREFELT $ 111))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (VECTOR |nlf| |l| |lv|))))) 

(SDEFUN |EFSTRUC;ataneval|
        ((|lf| (|List| F)) (|lk| (|List| (|Kernel| F))) (|k| (|Kernel| F))
         (|v| (|Vector| (|Fraction| (|Integer|))))
         ($
          (|Record| (|:| |funcs| (|List| F)) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPROG
         ((|nlf| (|List| F)) (#1=#:G1196 NIL) (|f| NIL) (#2=#:G1195 NIL)
          (|g| (F)) (|h| (F)) (|d| (F)) (#3=#:G1183 NIL) (#4=#:G1182 (F))
          (#5=#:G1184 (F)) (#6=#:G1193 NIL) (|i| NIL) (#7=#:G1194 NIL)
          (|x| NIL) (|s| (F)) (#8=#:G1191 NIL) (#9=#:G1192 NIL)
          (#10=#:G1190 NIL) (|w| (F)))
         (SEQ (LETT |w| (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
              (LETT |s|
                    (SPADCALL
                     (PROGN
                      (LETT #10# NIL)
                      (SEQ (LETT |x| NIL) (LETT #9# (|EFSTRUC;toV| |lk| $))
                           (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                           (LETT #8# (QVSIZE |v|)) G190
                           (COND
                            ((OR (> |i| #8#) (ATOM #9#)
                                 (PROGN (LETT |x| (CAR #9#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #10#
                                   (CONS
                                    (SPADCALL (QAREF1O |v| |i| 1) |x|
                                              (QREFELT $ 50))
                                    #10#))))
                           (LETT |i| (PROG1 (+ |i| 1) (LETT #9# (CDR #9#))))
                           (GO G190) G191 (EXIT (NREVERSE #10#))))
                     (QREFELT $ 53)))
              (LETT |g|
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |x| NIL) (LETT #7# (|EFSTRUC;toU| |lk| $))
                          (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                          (LETT #6# (QVSIZE |v|)) G190
                          (COND
                           ((OR (> |i| #6#) (ATOM #7#)
                                (PROGN (LETT |x| (CAR #7#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #5#
                                   (SPADCALL (QAREF1O |v| |i| 1) |x|
                                             (QREFELT $ 160)))
                             (COND
                              (#3#
                               (LETT #4# (SPADCALL #4# #5# (QREFELT $ 138))))
                              ('T (PROGN (LETT #4# #5#) (LETT #3# 'T)))))))
                          (LETT |i| (PROG1 (+ |i| 1) (LETT #7# (CDR #7#))))
                          (GO G190) G191 (EXIT NIL))
                     (COND (#3# #4#) (#11='T (|spadConstant| $ 26)))))
              (LETT |h|
                    (COND
                     ((SPADCALL
                       (LETT |d|
                             (SPADCALL (|spadConstant| $ 71)
                                       (SPADCALL |s| |w| (QREFELT $ 107))
                                       (QREFELT $ 138)))
                       (QREFELT $ 128))
                      (QREFELT $ 16))
                     (#11#
                      (SPADCALL
                       (SPADCALL (SPADCALL |w| |s| (QREFELT $ 134)) |d|
                                 (QREFELT $ 15))
                       (QREFELT $ 112)))))
              (LETT |g| (SPADCALL |g| |h| (QREFELT $ 138)))
              (LETT |nlf|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |f| NIL) (LETT #1# |lf|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL |f| (LIST |k|) (LIST |g|)
                                             (QREFELT $ 111))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (VECTOR |nlf| (LIST |k|) (LIST |g|)))))) 

(SDEFUN |EFSTRUC;gdCoef?|
        ((|c| (|Fraction| (|Integer|)))
         (|v| (|Vector| (|Fraction| (|Integer|)))) ($ (|Boolean|)))
        (SPROG ((#1=#:G1205 NIL) (#2=#:G1206 NIL) (#3=#:G1207 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                         (LETT #3# (QVSIZE |v|)) G190
                         (COND ((> |i| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((QEQCAR
                              (SPADCALL
                               (SPADCALL (QAREF1O |v| |i| 1) |c|
                                         (QREFELT $ 158))
                               (QREFELT $ 161))
                              1)
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# NIL) (GO #4=#:G1204)))
                              (GO #5=#:G1202))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |EFSTRUC;goodCoef|
        ((|v| (|Vector| (|Fraction| (|Integer|)))) (|l| (|List| (|Kernel| F)))
         (|s| (|Symbol|))
         ($
          (|Union|
           (|Record| (|:| |index| (|Integer|)) (|:| |ker| (|Kernel| F)))
           "failed")))
        (SPROG
         ((#1=#:G1241 NIL) (#2=#:G1242 NIL)
          (|r| (|Union| (|Fraction| (|Integer|)) "failed")) (#3=#:G1246 NIL)
          (|i| NIL) (#4=#:G1247 NIL) (|k| NIL) (|h| (|NonNegativeInteger|))
          (|j| (|Integer|)) (|h1| (|NonNegativeInteger|)) (#5=#:G1244 NIL)
          (#6=#:G1245 NIL) (|ll| (|List| (|Kernel| F))) (#7=#:G1243 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |h| 0) (LETT |j| 0) (LETT |ll| NIL)
                (SEQ (LETT |k| NIL) (LETT #7# |l|) G190
                     (COND
                      ((OR (ATOM #7#) (PROGN (LETT |k| (CAR #7#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((OR (SPADCALL |k| '|log| (QREFELT $ 30))
                             (OR (SPADCALL |k| '|exp| (QREFELT $ 30))
                                 (OR (SPADCALL |k| '|tan| (QREFELT $ 30))
                                     (SPADCALL |k| '|atan| (QREFELT $ 30)))))
                         (SEQ (LETT |ll| (CONS |k| |ll|))
                              (EXIT (LETT |h| (+ |h| 1))))))))
                     (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((NULL
                   (EQL |h|
                        (+ (- (QVSIZE |v|) (SPADCALL |v| (QREFELT $ 150))) 1)))
                  (EXIT (CONS 1 "failed"))))
                (LETT |h| 0) (LETT |ll| (REVERSE |ll|))
                (SEQ (LETT |k| NIL) (LETT #6# |ll|)
                     (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                     (LETT #5# (QVSIZE |v|)) G190
                     (COND
                      ((OR (> |i| #5#) (ATOM #6#)
                           (PROGN (LETT |k| (CAR #6#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |h1| (SPADCALL |k| (QREFELT $ 162)))
                          (EXIT
                           (COND
                            ((> |h1| |h|)
                             (SEQ (LETT |j| |i|) (EXIT (LETT |h| |h1|)))))))
                     (LETT |i| (PROG1 (+ |i| 1) (LETT #6# (CDR #6#))))
                     (GO G190) G191 (EXIT NIL))
                (SEQ
                 (EXIT
                  (SEQ (LETT |k| NIL) (LETT #4# |ll|)
                       (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                       (LETT #3# (QVSIZE |v|)) G190
                       (COND
                        ((OR (> |i| #3#) (ATOM #4#)
                             (PROGN (LETT |k| (CAR #4#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |k| |s| (QREFELT $ 30))
                           (COND
                            ((>= |i| |j|)
                             (SEQ
                              (LETT |r|
                                    (SPADCALL (QAREF1O |v| |i| 1)
                                              (QREFELT $ 164)))
                              (EXIT
                               (COND
                                ((QEQCAR |r| 0)
                                 (COND
                                  ((QEQCAR
                                    (SPADCALL (QCDR |r|) (QREFELT $ 161)) 0)
                                   (COND
                                    ((|EFSTRUC;gdCoef?| (QAREF1O |v| |i| 1) |v|
                                      $)
                                     (PROGN
                                      (LETT #1#
                                            (PROGN
                                             (LETT #2# (CONS 0 (CONS |i| |k|)))
                                             (GO #8=#:G1240)))
                                      (GO #9=#:G1238))))))))))))))))
                       (LETT |i| (PROG1 (+ |i| 1) (LETT #4# (CDR #4#))))
                       (GO G190) G191 (EXIT NIL)))
                 #9# (EXIT #1#))
                (EXIT (CONS 1 "failed"))))
          #8# (EXIT #2#)))) 

(SDEFUN |EFSTRUC;taneval|
        ((|lf| (|List| F)) (|lk| (|List| #1=(|Kernel| F))) (|k| (|Kernel| F))
         (|v| (|Vector| (|Fraction| (|Integer|))))
         ($
          (|Record| (|:| |funcs| (|List| F)) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPROG
         ((|nlf| (|List| F)) (#2=#:G1277 NIL) (|f| NIL) (#3=#:G1276 NIL)
          (|g| (F)) (#4=#:G1274 NIL) (|a| NIL) (#5=#:G1275 NIL) (|x| NIL)
          (#6=#:G1273 NIL) (|l| (|List| #1#)) (#7=#:G1272 NIL) (|kk| NIL)
          (#8=#:G1271 NIL) (|lv| (|List| (|Fraction| (|Integer|))))
          (#9=#:G1270 NIL) (|i| NIL) (#10=#:G1269 NIL) (|v0| (|Integer|))
          (|rec|
           (|Union|
            (|Record| (|:| |index| (|Integer|)) (|:| |ker| (|Kernel| F)))
            "failed"))
          (|c| (F)) (#11=#:G1250 NIL) (#12=#:G1249 (F)) (#13=#:G1251 (F))
          (#14=#:G1267 NIL) (#15=#:G1268 NIL) (|fns| (|List| F)) (|u| (F)))
         (SEQ (LETT |u| (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
              (LETT |fns| (|EFSTRUC;toU| |lk| $))
              (LETT |c|
                    (SPADCALL |u|
                              (PROGN
                               (LETT #11# NIL)
                               (SEQ (LETT |x| NIL) (LETT #15# |fns|)
                                    (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                                    (LETT #14# (QVSIZE |v|)) G190
                                    (COND
                                     ((OR (> |i| #14#) (ATOM #15#)
                                          (PROGN (LETT |x| (CAR #15#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #13#
                                             (SPADCALL (QAREF1O |v| |i| 1) |x|
                                                       (QREFELT $ 160)))
                                       (COND
                                        (#11#
                                         (LETT #12#
                                               (SPADCALL #12# #13#
                                                         (QREFELT $ 138))))
                                        ('T
                                         (PROGN
                                          (LETT #12# #13#)
                                          (LETT #11# 'T)))))))
                                    (LETT |i|
                                          (PROG1 (+ |i| 1)
                                            (LETT #15# (CDR #15#))))
                                    (GO G190) G191 (EXIT NIL))
                               (COND (#11# #12#)
                                     (#16='T (|spadConstant| $ 26))))
                              (QREFELT $ 134)))
              (LETT |rec| (|EFSTRUC;goodCoef| |v| |lk| '|tan| $))
              (EXIT
               (COND
                ((QEQCAR |rec| 1)
                 (|EFSTRUC;tannosimp| |lf| |lk| |k| |v| |fns| |c| $))
                (#16#
                 (SEQ
                  (LETT |v0|
                        (SPADCALL
                         (SPADCALL (QAREF1O |v| (QCAR (QCDR |rec|)) 1)
                                   (QREFELT $ 165))
                         (QREFELT $ 152)))
                  (LETT |lv|
                        (PROGN
                         (LETT #10# NIL)
                         (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                              (LETT #9# (QVSIZE |v|)) G190
                              (COND ((> |i| #9#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |i| (QCAR (QCDR |rec|))
                                            (QREFELT $ 156))
                                  (LETT #10#
                                        (CONS (QAREF1O |v| |i| 1) #10#))))))
                              (LETT |i| (+ |i| 1)) (GO G190) G191
                              (EXIT (NREVERSE #10#)))))
                  (LETT |l|
                        (PROGN
                         (LETT #8# NIL)
                         (SEQ (LETT |kk| NIL) (LETT #7# |lk|) G190
                              (COND
                               ((OR (ATOM #7#)
                                    (PROGN (LETT |kk| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |kk| (QCDR (QCDR |rec|))
                                            (QREFELT $ 113))
                                  (LETT #8# (CONS |kk| #8#))))))
                              (LETT #7# (CDR #7#)) (GO G190) G191
                              (EXIT (NREVERSE #8#)))))
                  (LETT |g|
                        (|EFSTRUC;tanSum|
                         (SPADCALL (SPADCALL |v0| |c| (QREFELT $ 166))
                                   (QREFELT $ 14))
                         (CONS
                          (SPADCALL (SPADCALL |k| (QREFELT $ 88)) |v0|
                                    (QREFELT $ 49))
                          (PROGN
                           (LETT #6# NIL)
                           (SEQ (LETT |x| NIL) (LETT #5# (|EFSTRUC;toV| |l| $))
                                (LETT |a| NIL) (LETT #4# |lv|) G190
                                (COND
                                 ((OR (ATOM #4#)
                                      (PROGN (LETT |a| (CAR #4#)) NIL)
                                      (ATOM #5#)
                                      (PROGN (LETT |x| (CAR #5#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #6#
                                        (CONS
                                         (SPADCALL |x|
                                                   (-
                                                    (SPADCALL
                                                     (SPADCALL |a| |v0|
                                                               (QREFELT $ 167))
                                                     (QREFELT $ 152)))
                                                   (QREFELT $ 49))
                                         #6#))))
                                (LETT #4#
                                      (PROG1 (CDR #4#) (LETT #5# (CDR #5#))))
                                (GO G190) G191 (EXIT (NREVERSE #6#)))))
                         $))
                  (LETT |nlf|
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |f| NIL) (LETT #2# |lf|) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |f| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #3#
                                      (CONS
                                       (SPADCALL |f| (LIST (QCDR (QCDR |rec|)))
                                                 (LIST |g|) (QREFELT $ 111))
                                       #3#))))
                              (LETT #2# (CDR #2#)) (GO G190) G191
                              (EXIT (NREVERSE #3#)))))
                  (EXIT
                   (VECTOR |nlf| (LIST (QCDR (QCDR |rec|))) (LIST |g|)))))))))) 

(SDEFUN |EFSTRUC;tannosimp|
        ((|lf| (|List| F)) (|lk| (|List| #1=(|Kernel| F))) (|k| (|Kernel| F))
         (|v| (|Vector| (|Fraction| (|Integer|)))) (|fns| (|List| F)) (|c| (F))
         ($
          (|Record| (|:| |funcs| (|List| F)) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPROG
         ((|nlf| (|List| F)) (#2=#:G1329 NIL) (|f| NIL) (#3=#:G1328 NIL)
          (|h| (F)) (#4=#:G1326 NIL) (|i| NIL) (#5=#:G1327 NIL) (|x| NIL)
          (#6=#:G1325 NIL) (#7=#:G1324 NIL) (#8=#:G1323 NIL)
          (|lk1| (|List| #1#)) (|newtan| (|List| F)) (#9=#:G1321 NIL)
          (#10=#:G1322 NIL) (|t| NIL) (#11=#:G1320 NIL)
          (|li| (|List| (|NonNegativeInteger|))) (#12=#:G1319 NIL)
          (#13=#:G1318 NIL) (#14=#:G1317 NIL) (#15=#:G1316 NIL)
          (|newt| (|List| F)) (#16=#:G1314 NIL) (|u| NIL) (#17=#:G1315 NIL)
          (#18=#:G1313 NIL) (|dd| (F)) (|d| #19=(|Integer|))
          (|cd| (|Record| (|:| |num| (|Vector| (|Integer|))) (|:| |den| #19#)))
          (#20=#:G1311 NIL) (#21=#:G1312 NIL) (#22=#:G1310 NIL)
          (#23=#:G1309 NIL) (#24=#:G1308 NIL) (|n| (|Integer|)))
         (SEQ (LETT |n| (QVSIZE |v|))
              (LETT |lk|
                    (PROGN
                     (LETT #24# NIL)
                     (SEQ (LETT |x| NIL) (LETT #23# |lk|) G190
                          (COND
                           ((OR (ATOM #23#) (PROGN (LETT |x| (CAR #23#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((COND ((SPADCALL |x| '|tan| (QREFELT $ 30)) 'T)
                                    (#25='T
                                     (SPADCALL |x| '|atan| (QREFELT $ 30))))
                              (LETT #24# (CONS |x| #24#))))))
                          (LETT #23# (CDR #23#)) (GO G190) G191
                          (EXIT (NREVERSE #24#)))))
              (LETT |lk1|
                    (PROGN
                     (LETT #22# NIL)
                     (SEQ (LETT |i| 1) (LETT #21# |n|) (LETT |x| NIL)
                          (LETT #20# |lk|) G190
                          (COND
                           ((OR (ATOM #20#) (PROGN (LETT |x| (CAR #20#)) NIL)
                                (|greater_SI| |i| #21#))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((NULL
                               (SPADCALL (QAREF1O |v| |i| 1)
                                         (|spadConstant| $ 97) (QREFELT $ 82)))
                              (LETT #22# (CONS |x| #22#))))))
                          (LETT #20#
                                (PROG1 (CDR #20#) (LETT |i| (|inc_SI| |i|))))
                          (GO G190) G191 (EXIT (NREVERSE #22#)))))
              (EXIT
               (COND
                ((SPADCALL (CONS #'|EFSTRUC;tannosimp!0| $) |lk1|
                           (QREFELT $ 168))
                 (SEQ
                  (LETT |dd|
                        (SPADCALL
                         (LETT |d|
                               (QCDR
                                (LETT |cd| (SPADCALL |v| (QREFELT $ 171)))))
                         (QREFELT $ 13)))
                  (LETT |newt|
                        (PROGN
                         (LETT #18# NIL)
                         (SEQ (LETT |i| 1) (LETT #17# |n|) (LETT |u| NIL)
                              (LETT #16# |fns|) G190
                              (COND
                               ((OR (ATOM #16#)
                                    (PROGN (LETT |u| (CAR #16#)) NIL)
                                    (|greater_SI| |i| #17#))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((NULL
                                   (SPADCALL (QAREF1O |v| |i| 1)
                                             (|spadConstant| $ 97)
                                             (QREFELT $ 82)))
                                  (LETT #18#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL |u| |dd| (QREFELT $ 15))
                                          (QREFELT $ 55))
                                         #18#))))))
                              (LETT #16#
                                    (PROG1 (CDR #16#)
                                      (LETT |i| (|inc_SI| |i|))))
                              (GO G190) G191 (EXIT (NREVERSE #18#)))))
                  (LETT |newtan|
                        (PROGN
                         (LETT #15# NIL)
                         (SEQ (LETT |t| NIL) (LETT #14# |newt|) G190
                              (COND
                               ((OR (ATOM #14#)
                                    (PROGN (LETT |t| (CAR #14#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #15#
                                      (CONS (SPADCALL |t| |d| (QREFELT $ 49))
                                            #15#))))
                              (LETT #14# (CDR #14#)) (GO G190) G191
                              (EXIT (NREVERSE #15#)))))
                  (LETT |li|
                        (PROGN
                         (LETT #13# NIL)
                         (SEQ (LETT |i| 1) (LETT #12# |n|) G190
                              (COND ((|greater_SI| |i| #12#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((NULL
                                   (SPADCALL (QAREF1O |v| |i| 1)
                                             (|spadConstant| $ 97)
                                             (QREFELT $ 82)))
                                  (LETT #13# (CONS |i| #13#))))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT (NREVERSE #13#)))))
                  (LETT |h|
                        (|EFSTRUC;tanSum| |c|
                         (PROGN
                          (LETT #11# NIL)
                          (SEQ (LETT |t| NIL) (LETT #10# |newt|) (LETT |i| NIL)
                               (LETT #9# |li|) G190
                               (COND
                                ((OR (ATOM #9#)
                                     (PROGN (LETT |i| (CAR #9#)) NIL)
                                     (ATOM #10#)
                                     (PROGN (LETT |t| (CAR #10#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #11#
                                       (CONS
                                        (SPADCALL |t|
                                                  (QAREF1O (QCAR |cd|) |i| 1)
                                                  (QREFELT $ 49))
                                        #11#))))
                               (LETT #9#
                                     (PROG1 (CDR #9#) (LETT #10# (CDR #10#))))
                               (GO G190) G191 (EXIT (NREVERSE #11#))))
                         $))
                  (LETT |newtan| (CONS |h| |newtan|))
                  (LETT |lk1| (CONS |k| |lk1|))
                  (LETT |nlf|
                        (PROGN
                         (LETT #8# NIL)
                         (SEQ (LETT |f| NIL) (LETT #7# |lf|) G190
                              (COND
                               ((OR (ATOM #7#)
                                    (PROGN (LETT |f| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #8#
                                      (CONS
                                       (SPADCALL |f| |lk1| |newtan|
                                                 (QREFELT $ 111))
                                       #8#))))
                              (LETT #7# (CDR #7#)) (GO G190) G191
                              (EXIT (NREVERSE #8#)))))
                  (EXIT (VECTOR |nlf| |lk1| |newtan|))))
                (#25#
                 (SEQ
                  (LETT |h|
                        (|EFSTRUC;tanSum| |c|
                         (PROGN
                          (LETT #6# NIL)
                          (SEQ (LETT |x| NIL) (LETT #5# (|EFSTRUC;toV| |lk| $))
                               (LETT |i| 1) (LETT #4# |n|) G190
                               (COND
                                ((OR (|greater_SI| |i| #4#) (ATOM #5#)
                                     (PROGN (LETT |x| (CAR #5#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #6#
                                       (CONS
                                        (SPADCALL (QAREF1O |v| |i| 1) |x|
                                                  (QREFELT $ 50))
                                        #6#))))
                               (LETT |i|
                                     (PROG1 (|inc_SI| |i|)
                                       (LETT #5# (CDR #5#))))
                               (GO G190) G191 (EXIT (NREVERSE #6#))))
                         $))
                  (LETT |nlf|
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |f| NIL) (LETT #2# |lf|) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |f| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #3#
                                      (CONS
                                       (SPADCALL |f| (LIST |k|) (LIST |h|)
                                                 (QREFELT $ 111))
                                       #3#))))
                              (LETT #2# (CDR #2#)) (GO G190) G191
                              (EXIT (NREVERSE #3#)))))
                  (EXIT (VECTOR |nlf| (LIST |k|) (LIST |h|)))))))))) 

(SDEFUN |EFSTRUC;tannosimp!0| ((|x| NIL) ($ NIL))
        (SPADCALL |x| '|tan| (QREFELT $ 30))) 

(SDEFUN |EFSTRUC;expnosimp|
        ((|lf| (|List| F)) (|lk| (|List| (|Kernel| F))) (|k| (|Kernel| F))
         (|v| (|Vector| (|Fraction| (|Integer|)))) (|fns| (|List| F)) (|g| (F))
         ($
          (|Record| (|:| |funcs| (|List| F)) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPROG
         ((|nlf| (|List| F)) (#1=#:G1350 NIL) (|f| NIL) (#2=#:G1349 NIL)
          (|lexp| (|List| F)) (|lke| (|List| (|Kernel| F))) (|h| (F))
          (|nui| (F)) (|di| (|Integer|)) (|vi| (|Fraction| (|Integer|)))
          (#3=#:G1346 NIL) (|i| NIL) (#4=#:G1347 NIL) (|k1| NIL)
          (#5=#:G1348 NIL) (|y| NIL) (#6=#:G1345 NIL) (|x| NIL)
          (#7=#:G1344 NIL) (|n| (|Integer|)))
         (SEQ (LETT |n| (QVSIZE |v|))
              (LETT |lk|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |x| NIL) (LETT #6# |lk|) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |x| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((COND
                               ((OR (SPADCALL |x| '|exp| (QREFELT $ 30))
                                    (SPADCALL |x| '|log| (QREFELT $ 30)))
                                'T)
                               ('T (SPADCALL |x| '|lambertW| (QREFELT $ 30))))
                              (LETT #7# (CONS |x| #7#))))))
                          (LETT #6# (CDR #6#)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |h| |g|) (LETT |lke| NIL) (LETT |lexp| NIL)
              (SEQ (LETT |y| NIL) (LETT #5# |fns|) (LETT |k1| NIL)
                   (LETT #4# |lk|) (LETT |i| 1) (LETT #3# |n|) G190
                   (COND
                    ((OR (|greater_SI| |i| #3#) (ATOM #4#)
                         (PROGN (LETT |k1| (CAR #4#)) NIL) (ATOM #5#)
                         (PROGN (LETT |y| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |vi| (QAREF1O |v| |i| 1))
                        (EXIT
                         (COND
                          ((SPADCALL |vi| (|spadConstant| $ 97) (QREFELT $ 82))
                           "iterate")
                          ('T
                           (SEQ (LETT |di| (SPADCALL |vi| (QREFELT $ 39)))
                                (COND
                                 ((OR (SPADCALL |k1| '|log| (QREFELT $ 30))
                                      (EQL |di| 1))
                                  (EXIT
                                   (LETT |h|
                                         (SPADCALL |h|
                                                   (SPADCALL
                                                    (SPADCALL |y|
                                                              (QREFELT $ 130))
                                                    |vi| (QREFELT $ 159))
                                                   (QREFELT $ 107))))))
                                (LETT |lke| (CONS |k1| |lke|))
                                (LETT |nui|
                                      (SPADCALL
                                       (SPADCALL |y|
                                                 (SPADCALL |di| (QREFELT $ 13))
                                                 (QREFELT $ 15))
                                       (QREFELT $ 130)))
                                (LETT |lexp|
                                      (CONS
                                       (SPADCALL |nui| |di| (QREFELT $ 104))
                                       |lexp|))
                                (EXIT
                                 (LETT |h|
                                       (SPADCALL |h|
                                                 (SPADCALL |nui|
                                                           (SPADCALL |vi|
                                                                     (QREFELT $
                                                                              48))
                                                           (QREFELT $ 104))
                                                 (QREFELT $ 107)))))))))
                   (LETT |i|
                         (PROG1 (|inc_SI| |i|)
                           (LETT #4# (PROG1 (CDR #4#) (LETT #5# (CDR #5#))))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |lke| (CONS |k| |lke|)) (LETT |lexp| (CONS |h| |lexp|))
              (LETT |nlf|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |f| NIL) (LETT #1# |lf|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL |f| |lke| |lexp| (QREFELT $ 111))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (VECTOR |nlf| |lke| |lexp|))))) 

(SDEFUN |EFSTRUC;logeval|
        ((|lf| (|List| F)) (|lk| (|List| (|Kernel| F))) (|k| (|Kernel| F))
         (|v| (|Vector| (|Fraction| (|Integer|))))
         ($
          (|Record| (|:| |funcs| (|List| F)) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPROG
         ((|nlf| (|List| F)) (#1=#:G1377 NIL) (|f| NIL) (#2=#:G1376 NIL)
          (|g| (F)) (#3=#:G1364 NIL) (#4=#:G1363 (F)) (#5=#:G1365 (F))
          (#6=#:G1374 NIL) (|i| NIL) (#7=#:G1375 NIL) (|x| NIL) (|c| (F))
          (#8=#:G1355 NIL) (#9=#:G1354 (F)) (#10=#:G1356 (F)) (#11=#:G1372 NIL)
          (#12=#:G1373 NIL) (|dd| (|Integer|)) (#13=#:G1371 NIL)
          (#14=#:G1370 NIL) (|z| (F)))
         (SEQ (LETT |z| (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
              (LETT |dd|
                    (SPADCALL
                     (PROGN
                      (LETT #14# NIL)
                      (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                           (LETT #13# (QVSIZE |v|)) G190
                           (COND ((> |i| #13#) (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #14#
                                   (CONS
                                    (SPADCALL (QAREF1O |v| |i| 1)
                                              (QREFELT $ 39))
                                    #14#))))
                           (LETT |i| (+ |i| 1)) (GO G190) G191
                           (EXIT (NREVERSE #14#))))
                     (QREFELT $ 172)))
              (LETT |c|
                    (SPADCALL (SPADCALL |z| |dd| (QREFELT $ 104))
                              (PROGN
                               (LETT #8# NIL)
                               (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                                    (LETT #12# (QVSIZE |v|)) (LETT |x| NIL)
                                    (LETT #11# (|EFSTRUC;toZ| |lk| $)) G190
                                    (COND
                                     ((OR (ATOM #11#)
                                          (PROGN (LETT |x| (CAR #11#)) NIL)
                                          (> |i| #12#))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #10#
                                             (SPADCALL |x|
                                                       (SPADCALL |dd|
                                                                 (QAREF1O |v|
                                                                          |i|
                                                                          1)
                                                                 (QREFELT $
                                                                          173))
                                                       (QREFELT $ 159)))
                                       (COND
                                        (#8#
                                         (LETT #9#
                                               (SPADCALL #9# #10#
                                                         (QREFELT $ 107))))
                                        ('T
                                         (PROGN
                                          (LETT #9# #10#)
                                          (LETT #8# 'T)))))))
                                    (LETT #11#
                                          (PROG1 (CDR #11#)
                                            (LETT |i| (+ |i| 1))))
                                    (GO G190) G191 (EXIT NIL))
                               (COND (#8# #9#) (#15='T (|spadConstant| $ 71))))
                              (QREFELT $ 15)))
              (LETT |g|
                    (SPADCALL
                     (PROGN
                      (LETT #3# NIL)
                      (SEQ (LETT |x| NIL) (LETT #7# (|EFSTRUC;toY| |lk| $))
                           (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                           (LETT #6# (QVSIZE |v|)) G190
                           (COND
                            ((OR (> |i| #6#) (ATOM #7#)
                                 (PROGN (LETT |x| (CAR #7#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (PROGN
                              (LETT #5#
                                    (SPADCALL (QAREF1O |v| |i| 1) |x|
                                              (QREFELT $ 160)))
                              (COND
                               (#3#
                                (LETT #4# (SPADCALL #4# #5# (QREFELT $ 138))))
                               ('T (PROGN (LETT #4# #5#) (LETT #3# 'T)))))))
                           (LETT |i| (PROG1 (+ |i| 1) (LETT #7# (CDR #7#))))
                           (GO G190) G191 (EXIT NIL))
                      (COND (#3# #4#) (#15# (|spadConstant| $ 26))))
                     (SPADCALL (SPADCALL |c| (QREFELT $ 89))
                               (SPADCALL (SPADCALL |dd| (QREFELT $ 174))
                                         (QREFELT $ 114))
                               (QREFELT $ 15))
                     (QREFELT $ 138)))
              (LETT |nlf|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |f| NIL) (LETT #1# |lf|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL |f| (LIST |k|) (LIST |g|)
                                             (QREFELT $ 111))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (VECTOR |nlf| (LIST |k|) (LIST |g|)))))) 

(SDEFUN |EFSTRUC;rischNormalize;LLR;42|
        ((|lf| (|List| F)) (|vars| (|List| (|Symbol|)))
         ($
          (|Record| (|:| |funcs| (|List| F)) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPROG
         ((#1=#:G1392 NIL)
          (|rn|
           (|Record| (|:| |funcs| (|List| F))
                     (|:| |kers| (|List| (|Kernel| F)))
                     (|:| |vals| (|List| F))))
          (|nlf| (|List| F)) (#2=#:G1396 NIL) (|f| NIL) (#3=#:G1395 NIL)
          (#4=#:G1391 NIL)
          (|rec|
           (|Record| (|:| |funcs| (|List| F))
                     (|:| |kers| (|List| (|Kernel| F)))
                     (|:| |vals| (|List| F))))
          (|c|
           (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                    (|:| |func| F) (|:| |fail| (|Boolean|))))
          (|klist| (|List| (|Kernel| F))) (#5=#:G1393 NIL) (|i| NIL)
          (#6=#:G1394 NIL) (|kk| NIL) (|n| (|NonNegativeInteger|))
          (|pars| (|List| (|Symbol|))) (|funs| (|List| (|Kernel| F))))
         (SEQ
          (EXIT
           (SEQ (LETT |funs| (SPADCALL |lf| (QREFELT $ 175)))
                (LETT |pars| (SPADCALL |lf| (QREFELT $ 176)))
                (LETT |pars| (SPADCALL |pars| |vars| (QREFELT $ 177)))
                (EXIT
                 (COND ((NULL |funs|) (VECTOR |lf| NIL NIL))
                       ('T
                        (SEQ (LETT |n| (LENGTH |funs|))
                             (SEQ (LETT |kk| NIL) (LETT #6# (CDR |funs|))
                                  (LETT |i| 1) (LETT #5# |n|) G190
                                  (COND
                                   ((OR (|greater_SI| |i| #5#) (ATOM #6#)
                                        (PROGN (LETT |kk| (CAR #6#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (SEQ
                                     (LETT |klist|
                                           (SPADCALL |funs| |i|
                                                     (QREFELT $ 178)))
                                     (SEQ
                                      (LETT |c|
                                            (|EFSTRUC;findRelation| |vars|
                                             |pars| |klist| |kk| $))
                                      (EXIT
                                       (COND
                                        ((QEQCAR |c| 0)
                                         (COND
                                          ((NULL
                                            (SPADCALL (CDR |c|)
                                                      (QREFELT $ 179)))
                                           (PROGN
                                            (LETT #4#
                                                  (SEQ
                                                   (LETT |rec|
                                                         (|EFSTRUC;depeval|
                                                          |lf| |klist| |kk|
                                                          (CDR |c|) $))
                                                   (LETT |rn|
                                                         (SPADCALL
                                                          (QVELT |rec| 0)
                                                          |vars|
                                                          (QREFELT $ 181)))
                                                   (EXIT
                                                    (PROGN
                                                     (LETT #1#
                                                           (VECTOR
                                                            (QVELT |rn| 0)
                                                            (SPADCALL
                                                             (QVELT |rec| 1)
                                                             (QVELT |rn| 1)
                                                             (QREFELT $ 182))
                                                            (SPADCALL
                                                             (QVELT |rec| 2)
                                                             (QVELT |rn| 2)
                                                             (QREFELT $ 147))))
                                                     (GO #7=#:G1390)))))
                                            (GO #8=#:G1386))))))))
                                     (EXIT
                                      (COND
                                       ((QEQCAR |c| 1)
                                        (SEQ
                                         (LETT |nlf|
                                               (PROGN
                                                (LETT #3# NIL)
                                                (SEQ (LETT |f| NIL)
                                                     (LETT #2# |lf|) G190
                                                     (COND
                                                      ((OR (ATOM #2#)
                                                           (PROGN
                                                            (LETT |f|
                                                                  (CAR #2#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #3#
                                                             (CONS
                                                              (SPADCALL |f|
                                                                        (LIST
                                                                         |kk|)
                                                                        (LIST
                                                                         (CDR
                                                                          |c|))
                                                                        (QREFELT
                                                                         $
                                                                         111))
                                                              #3#))))
                                                     (LETT #2# (CDR #2#))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #3#)))))
                                         (LETT |rn|
                                               (SPADCALL |nlf| |vars|
                                                         (QREFELT $ 181)))
                                         (EXIT
                                          (PROGN
                                           (LETT #1#
                                                 (VECTOR (QVELT |rn| 0)
                                                         (CONS |kk|
                                                               (QVELT |rn| 1))
                                                         (CONS (CDR |c|)
                                                               (QVELT |rn|
                                                                      2))))
                                           (GO #7#)))))))))
                                   #8# (EXIT #4#))
                                  (LETT |i|
                                        (PROG1 (|inc_SI| |i|)
                                          (LETT #6# (CDR #6#))))
                                  (GO G190) G191 (EXIT NIL))
                             (EXIT (VECTOR |lf| NIL NIL))))))))
          #7# (EXIT #1#)))) 

(SDEFUN |EFSTRUC;rischNormalize;FLR;43|
        ((|f| (F)) (|vars| (|List| (|Symbol|)))
         ($
          (|Record| (|:| |func| F) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPROG
         ((|rn|
           (|Record| (|:| |funcs| (|List| F))
                     (|:| |kers| (|List| (|Kernel| F)))
                     (|:| |vals| (|List| F)))))
         (SEQ (LETT |rn| (SPADCALL (LIST |f|) |vars| (QREFELT $ 181)))
              (EXIT
               (VECTOR (|SPADfirst| (QVELT |rn| 0)) (QVELT |rn| 1)
                       (QVELT |rn| 2)))))) 

(SDEFUN |EFSTRUC;rischNormalize;FSR;44|
        ((|f| (F)) (|v| (|Symbol|))
         ($
          (|Record| (|:| |func| F) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPADCALL |f| (LIST |v|) (QREFELT $ 184))) 

(SDEFUN |EFSTRUC;rootNormalize;FKF;45| ((|f| (F)) (|k| (|Kernel| F)) ($ (F)))
        (SPROG
         ((|u|
           (|Union|
            (|Record| (|:| |funcs| (|List| F))
                      (|:| |kers| (|List| (|Kernel| F)))
                      (|:| |vals| (|List| F)))
            "failed")))
         (SEQ
          (LETT |u|
                (|EFSTRUC;rootKernelNormalize| (LIST |f|)
                 (|EFSTRUC;toR| (SPADCALL |f| (QREFELT $ 186))
                  (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))) $)
                 |k| $))
          (EXIT
           (COND ((QEQCAR |u| 1) |f|)
                 ('T (|SPADfirst| (QVELT (QCDR |u|) 0)))))))) 

(SDEFUN |EFSTRUC;rootKernelNormalize|
        ((|lf| (|List| F)) (|l| (|List| (|Kernel| F))) (|k| (|Kernel| F))
         ($
          (|Union|
           (|Record| (|:| |funcs| (|List| F))
                     (|:| |kers| (|List| (|Kernel| F)))
                     (|:| |vals| (|List| F)))
           "failed")))
        (SPROG
         ((|c|
           (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                    (|:| |func| F) (|:| |fail| (|Boolean|)))))
         (SEQ (LETT |c| (|EFSTRUC;rootDep| |l| |k| $))
              (EXIT
               (COND
                ((QEQCAR |c| 0)
                 (CONS 0
                       (|EFSTRUC;rooteval| |lf| |l| |k|
                        (SPADCALL (CDR |c|)
                                  (SPADCALL (CDR |c|) (QREFELT $ 150))
                                  (QREFELT $ 151))
                        $)))
                ('T (CONS 1 "failed"))))))) 

(SDEFUN |EFSTRUC;validExponential;LFSU;47|
        ((|twr| (|List| (|Kernel| F))) (|eta| (F)) (|x| (|Symbol|))
         ($ (|Union| F "failed")))
        (SPROG
         ((#1=#:G1452 NIL) (#2=#:G1451 (F)) (#3=#:G1453 (F)) (#4=#:G1464 NIL)
          (|i| NIL) (#5=#:G1465 NIL) (|yy| NIL) (|g| (F)) (#6=#:G1425 NIL)
          (#7=#:G1424 (F)) (#8=#:G1426 (F)) (#9=#:G1462 NIL) (#10=#:G1463 NIL)
          (|v| (|Vector| (|Fraction| (|Integer|))))
          (|c| (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
          (#11=#:G1461 NIL) (|fns| (|List| F)) (#12=#:G1460 NIL))
         (SEQ
          (LETT |c|
                (SPADCALL
                 (SPADCALL
                  (PROGN
                   (LETT #12# NIL)
                   (SEQ (LETT #11# (LETT |fns| (|EFSTRUC;toY| |twr| $))) G190
                        (COND
                         ((OR (ATOM #11#) (PROGN (LETT |g| (CAR #11#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #12#
                                (CONS (SPADCALL |g| |x| (QREFELT $ 57))
                                      #12#))))
                        (LETT #11# (CDR #11#)) (GO G190) G191
                        (EXIT (NREVERSE #12#))))
                  (QREFELT $ 188))
                 (SPADCALL |eta| |x| (QREFELT $ 57)) (QREFELT $ 189)))
          (EXIT
           (COND ((QEQCAR |c| 1) (CONS 1 "failed"))
                 (#13='T
                  (SEQ (LETT |v| (QCDR |c|))
                       (LETT |g|
                             (SPADCALL |eta|
                                       (PROGN
                                        (LETT #6# NIL)
                                        (SEQ (LETT |yy| NIL) (LETT #10# |fns|)
                                             (LETT |i|
                                                   (SPADCALL |v|
                                                             (QREFELT $ 150)))
                                             (LETT #9# (QVSIZE |v|)) G190
                                             (COND
                                              ((OR (> |i| #9#) (ATOM #10#)
                                                   (PROGN
                                                    (LETT |yy| (CAR #10#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (PROGN
                                                (LETT #8#
                                                      (SPADCALL
                                                       (QAREF1O |v| |i| 1) |yy|
                                                       (QREFELT $ 160)))
                                                (COND
                                                 (#6#
                                                  (LETT #7#
                                                        (SPADCALL #7# #8#
                                                                  (QREFELT $
                                                                           138))))
                                                 ('T
                                                  (PROGN
                                                   (LETT #7# #8#)
                                                   (LETT #6# 'T)))))))
                                             (LETT |i|
                                                   (PROG1 (+ |i| 1)
                                                     (LETT #10# (CDR #10#))))
                                             (GO G190) G191 (EXIT NIL))
                                        (COND (#6# #7#)
                                              (#13# (|spadConstant| $ 26))))
                                       (QREFELT $ 134)))
                       (EXIT
                        (CONS 0
                              (SPADCALL
                               (PROGN
                                (LETT #1# NIL)
                                (SEQ (LETT |yy| NIL) (LETT #5# |fns|)
                                     (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                                     (LETT #4# (QVSIZE |v|)) G190
                                     (COND
                                      ((OR (> |i| #4#) (ATOM #5#)
                                           (PROGN (LETT |yy| (CAR #5#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (PROGN
                                        (LETT #3#
                                              (SPADCALL
                                               (SPADCALL |yy| (QREFELT $ 130))
                                               (QAREF1O |v| |i| 1)
                                               (QREFELT $ 159)))
                                        (COND
                                         (#1#
                                          (LETT #2#
                                                (SPADCALL #2# #3#
                                                          (QREFELT $ 107))))
                                         ('T
                                          (PROGN
                                           (LETT #2# #3#)
                                           (LETT #1# 'T)))))))
                                     (LETT |i|
                                           (PROG1 (+ |i| 1)
                                             (LETT #5# (CDR #5#))))
                                     (GO G190) G191 (EXIT NIL))
                                (COND (#1# #2#) (#13# (|spadConstant| $ 71))))
                               (SPADCALL |g| (QREFELT $ 130))
                               (QREFELT $ 107))))))))))) 

(SDEFUN |EFSTRUC;irootDep;KU;48|
        ((|k| (|Kernel| F))
         ($
          (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                   (|:| |func| F) (|:| |fail| (|Boolean|)))))
        (SPROG
         ((|nv| (F)) (|nk| (F)) (|nr| (F)) (|nf| (F))
          (|pr|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                     (|:| |radicand| F)))
          (|n| (|NonNegativeInteger|)) (#1=#:G1466 NIL))
         (SEQ
          (LETT |n|
                (PROG1
                    (LETT #1#
                          (SPADCALL
                           (SPADCALL (SPADCALL |k| (QREFELT $ 32))
                                     (QREFELT $ 154))
                           (QREFELT $ 155)))
                  (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #1#)))
          (LETT |pr|
                (SPADCALL (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))) |n|
                          (QREFELT $ 194)))
          (COND
           ((SPADCALL (QVELT |pr| 1) (|spadConstant| $ 71) (QREFELT $ 34))
            (COND
             ((NULL (EQL (QVELT |pr| 0) |n|))
              (EXIT
               (COND
                ((EQL (QVELT |pr| 0) 1)
                 (CONS 1
                       (SPADCALL (QVELT |pr| 1) (QVELT |pr| 2)
                                 (QREFELT $ 107))))
                (#2='T
                 (SEQ (LETT |nf| (SPADCALL (QVELT |pr| 0) (QREFELT $ 13)))
                      (LETT |nr| (QVELT |pr| 2))
                      (LETT |nk|
                            (SPADCALL (SPADCALL |k| (QREFELT $ 74))
                                      (LIST |nr| |nf|) (QREFELT $ 148)))
                      (LETT |nv|
                            (SPADCALL (QVELT |pr| 1) |nk| (QREFELT $ 107)))
                      (EXIT (CONS 1 |nv|)))))))))
           (#2#
            (EXIT
             (COND
              ((EQL (QVELT |pr| 0) 1)
               (CONS 1
                     (SPADCALL (QVELT |pr| 1) (QVELT |pr| 2) (QREFELT $ 107))))
              (#2#
               (SEQ (LETT |nf| (SPADCALL (QVELT |pr| 0) (QREFELT $ 13)))
                    (LETT |nr| (QVELT |pr| 2))
                    (LETT |nk|
                          (SPADCALL (SPADCALL |k| (QREFELT $ 74))
                                    (LIST |nr| |nf|) (QREFELT $ 148)))
                    (LETT |nv| (SPADCALL (QVELT |pr| 1) |nk| (QREFELT $ 107)))
                    (EXIT (CONS 1 |nv|))))))))
          (EXIT (CONS 2 'T))))) 

(SDEFUN |EFSTRUC;irootDep;KU;49|
        ((|k| (|Kernel| F))
         ($
          (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                   (|:| |func| F) (|:| |fail| (|Boolean|)))))
        (CONS 2 'T)) 

(SDEFUN |EFSTRUC;rootDep|
        ((|ker| (|List| (|Kernel| F))) (|k| (|Kernel| F))
         ($
          (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                   (|:| |func| F) (|:| |fail| (|Boolean|)))))
        (SPROG
         ((#1=#:G1502 NIL) (#2=#:G1501 #3=(|Integer|)) (#4=#:G1503 #3#)
          (#5=#:G1506 NIL) (|r| NIL))
         (SEQ
          (COND
           ((NULL
             (LETT |ker|
                   (|EFSTRUC;toR| |ker|
                    (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))) $)))
            (SPADCALL |k| (QREFELT $ 196)))
           (#6='T
            (CONS 0
                  (MAKEARR1 1
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (SPADCALL |k| (QREFELT $ 32))
                                         (QREFELT $ 154))
                               (QREFELT $ 155))
                              (PROGN
                               (LETT #1# NIL)
                               (SEQ (LETT |r| NIL) (LETT #5# |ker|) G190
                                    (COND
                                     ((OR (ATOM #5#)
                                          (PROGN (LETT |r| (CAR #5#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #4#
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL |r| (QREFELT $ 32))
                                               (QREFELT $ 154))
                                              (QREFELT $ 155)))
                                       (COND
                                        (#1#
                                         (LETT #2#
                                               (SPADCALL #2# #4#
                                                         (QREFELT $ 197))))
                                        ('T
                                         (PROGN
                                          (LETT #2# #4#)
                                          (LETT #1# 'T)))))))
                                    (LETT #5# (CDR #5#)) (GO G190) G191
                                    (EXIT NIL))
                               (COND (#1# #2#) (#6# 1)))
                              (QREFELT $ 197))
                             (QREFELT $ 157))))))))) 

(SDEFUN |EFSTRUC;expeval|
        ((|lf| (|List| F)) (|lk| (|List| #1=(|Kernel| F))) (|k| (|Kernel| F))
         (|v| (|Vector| (|Fraction| (|Integer|))))
         ($
          (|Record| (|:| |funcs| (|List| F)) (|:| |kers| (|List| (|Kernel| F)))
                    (|:| |vals| (|List| F)))))
        (SPROG
         ((|nlf| (|List| F)) (#2=#:G1536 NIL) (|f| NIL) (#3=#:G1535 NIL)
          (|h| (F)) (#4=#:G1520 NIL) (#5=#:G1519 (F)) (#6=#:G1521 (F))
          (#7=#:G1533 NIL) (|a| NIL) (#8=#:G1534 NIL) (|z| NIL)
          (|l| (|List| #1#)) (#9=#:G1532 NIL) (|kk| NIL) (#10=#:G1531 NIL)
          (|lv| (|List| (|Fraction| (|Integer|)))) (#11=#:G1530 NIL) (|i| NIL)
          (#12=#:G1529 NIL) (|v0| (|Integer|))
          (|rec|
           (|Union|
            (|Record| (|:| |index| (|Integer|)) (|:| |ker| (|Kernel| F)))
            "failed"))
          (|g| (F)) (#13=#:G1509 NIL) (#14=#:G1508 (F)) (#15=#:G1510 (F))
          (#16=#:G1527 NIL) (#17=#:G1528 NIL) (|fns| (|List| F)) (|y| (F)))
         (SEQ (LETT |y| (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
              (LETT |fns| (|EFSTRUC;toY| |lk| $))
              (LETT |g|
                    (SPADCALL |y|
                              (PROGN
                               (LETT #13# NIL)
                               (SEQ (LETT |z| NIL) (LETT #17# |fns|)
                                    (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                                    (LETT #16# (QVSIZE |v|)) G190
                                    (COND
                                     ((OR (> |i| #16#) (ATOM #17#)
                                          (PROGN (LETT |z| (CAR #17#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #15#
                                             (SPADCALL (QAREF1O |v| |i| 1) |z|
                                                       (QREFELT $ 160)))
                                       (COND
                                        (#13#
                                         (LETT #14#
                                               (SPADCALL #14# #15#
                                                         (QREFELT $ 138))))
                                        ('T
                                         (PROGN
                                          (LETT #14# #15#)
                                          (LETT #13# 'T)))))))
                                    (LETT |i|
                                          (PROG1 (+ |i| 1)
                                            (LETT #17# (CDR #17#))))
                                    (GO G190) G191 (EXIT NIL))
                               (COND (#13# #14#)
                                     (#18='T (|spadConstant| $ 26))))
                              (QREFELT $ 134)))
              (LETT |rec| (|EFSTRUC;goodCoef| |v| |lk| '|exp| $))
              (EXIT
               (COND
                ((QEQCAR |rec| 1)
                 (|EFSTRUC;expnosimp| |lf| |lk| |k| |v| |fns|
                  (SPADCALL |g| (QREFELT $ 130)) $))
                (#18#
                 (SEQ
                  (LETT |v0|
                        (SPADCALL
                         (SPADCALL (QAREF1O |v| (QCAR (QCDR |rec|)) 1)
                                   (QREFELT $ 165))
                         (QREFELT $ 152)))
                  (LETT |lv|
                        (PROGN
                         (LETT #12# NIL)
                         (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 150)))
                              (LETT #11# (QVSIZE |v|)) G190
                              (COND ((> |i| #11#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |i| (QCAR (QCDR |rec|))
                                            (QREFELT $ 156))
                                  (LETT #12#
                                        (CONS (QAREF1O |v| |i| 1) #12#))))))
                              (LETT |i| (+ |i| 1)) (GO G190) G191
                              (EXIT (NREVERSE #12#)))))
                  (LETT |l|
                        (PROGN
                         (LETT #10# NIL)
                         (SEQ (LETT |kk| NIL) (LETT #9# |lk|) G190
                              (COND
                               ((OR (ATOM #9#)
                                    (PROGN (LETT |kk| (CAR #9#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |kk| (QCDR (QCDR |rec|))
                                            (QREFELT $ 113))
                                  (LETT #10# (CONS |kk| #10#))))))
                              (LETT #9# (CDR #9#)) (GO G190) G191
                              (EXIT (NREVERSE #10#)))))
                  (LETT |h|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |z| NIL) (LETT #8# (|EFSTRUC;toY| |l| $))
                              (LETT |a| NIL) (LETT #7# |lv|) G190
                              (COND
                               ((OR (ATOM #7#) (PROGN (LETT |a| (CAR #7#)) NIL)
                                    (ATOM #8#)
                                    (PROGN (LETT |z| (CAR #8#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #6#
                                       (SPADCALL (SPADCALL |z| (QREFELT $ 130))
                                                 (-
                                                  (SPADCALL
                                                   (SPADCALL |a| |v0|
                                                             (QREFELT $ 167))
                                                   (QREFELT $ 152)))
                                                 (QREFELT $ 104)))
                                 (COND
                                  (#4#
                                   (LETT #5#
                                         (SPADCALL #5# #6# (QREFELT $ 107))))
                                  ('T (PROGN (LETT #5# #6#) (LETT #4# 'T)))))))
                              (LETT #7# (PROG1 (CDR #7#) (LETT #8# (CDR #8#))))
                              (GO G190) G191 (EXIT NIL))
                         (COND (#4# #5#) (#18# (|spadConstant| $ 71)))))
                  (LETT |h|
                        (SPADCALL
                         (SPADCALL |h|
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL |v0| |g| (QREFELT $ 166))
                                     (QREFELT $ 14))
                                    (QREFELT $ 130))
                                   (QREFELT $ 107))
                         (SPADCALL (SPADCALL |k| (QREFELT $ 88)) |v0|
                                   (QREFELT $ 104))
                         (QREFELT $ 107)))
                  (LETT |nlf|
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |f| NIL) (LETT #2# |lf|) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |f| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #3#
                                      (CONS
                                       (SPADCALL |f| (LIST (QCDR (QCDR |rec|)))
                                                 (LIST |h|) (QREFELT $ 111))
                                       #3#))))
                              (LETT #2# (CDR #2#)) (GO G190) G191
                              (EXIT (NREVERSE #3#)))))
                  (EXIT
                   (VECTOR |nlf| (LIST (QCDR (QCDR |rec|))) (LIST |h|)))))))))) 

(SDEFUN |EFSTRUC;normalize;2F;52| ((|f| (F)) ($ (F)))
        (|SPADfirst| (SPADCALL (LIST |f|) NIL (QREFELT $ 198)))) 

(SDEFUN |EFSTRUC;normalize;2L;53| ((|lf| (|List| F)) ($ (|List| F)))
        (SPADCALL |lf| NIL (QREFELT $ 198))) 

(SDEFUN |EFSTRUC;normalize;FSF;54| ((|f| (F)) (|x| (|Symbol|)) ($ (F)))
        (|SPADfirst| (SPADCALL (LIST |f|) (LIST |x|) (QREFELT $ 198)))) 

(SDEFUN |EFSTRUC;normalize;LLL;55|
        ((|lf| (|List| F)) (|lx| (|List| (|Symbol|))) ($ (|List| F)))
        (SPROG ((|lf2| (|List| F)) (#1=#:G1546 NIL) (|f| NIL) (#2=#:G1545 NIL))
               (SEQ
                (LETT |lf2|
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |f| NIL) (LETT #1# |lf|) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS
                                     (SPADCALL (SPADCALL |f| (QREFELT $ 23))
                                               (QREFELT $ 202))
                                     #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#)))))
                (EXIT (QVELT (SPADCALL |lf2| |lx| (QREFELT $ 181)) 0))))) 

(SDEFUN |EFSTRUC;factdeprel|
        ((|l| (|List| (|Kernel| F))) (|k| (|Kernel| F))
         ($
          (|Union| (|:| |vec| (|Vector| (|Fraction| (|Integer|))))
                   (|:| |func| F) (|:| |fail| (|Boolean|)))))
        (SPROG
         ((#1=#:G1588 NIL) (#2=#:G1590 NIL) (#3=#:G1581 NIL) (#4=#:G1580 (F))
          (#5=#:G1582 (F)) (#6=#:G1592 NIL) (|i| NIL)
          (|r| (|Union| (|Integer|) "failed")) (|m| (F)) (#7=#:G1591 NIL)
          (|x| NIL) (#8=#:G1589 NIL) (|n| (F)))
         (SEQ
          (EXIT
           (SEQ
            (EXIT
             (SEQ
              (SEQ
               (LETT |r|
                     (SPADCALL
                      (LETT |n| (|SPADfirst| (SPADCALL |k| (QREFELT $ 32))))
                      (QREFELT $ 52)))
               (EXIT
                (COND
                 ((QEQCAR |r| 0)
                  (COND
                   ((> (QCDR |r|) 0)
                    (PROGN
                     (LETT #8#
                           (CONS 1
                                 (SPADCALL
                                  (SPADCALL (QCDR |r|) (QREFELT $ 203))
                                  (QREFELT $ 13))))
                     (GO #9=#:G1586))))))))
              (SEQ (LETT |x| NIL) (LETT #7# |l|) G190
                   (COND
                    ((OR (ATOM #7#) (PROGN (LETT |x| (CAR #7#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ
                      (LETT |m| (|SPADfirst| (SPADCALL |x| (QREFELT $ 32))))
                      (LETT |r|
                            (SPADCALL (SPADCALL |n| |m| (QREFELT $ 134))
                                      (QREFELT $ 52)))
                      (EXIT
                       (COND
                        ((QEQCAR |r| 0)
                         (PROGN
                          (LETT #1#
                                (COND
                                 ((> (QCDR |r|) 0)
                                  (PROGN
                                   (LETT #2#
                                         (CONS 1
                                               (SPADCALL
                                                (PROGN
                                                 (LETT #3# NIL)
                                                 (SEQ (LETT |i| 1)
                                                      (LETT #6# (QCDR |r|))
                                                      G190
                                                      (COND
                                                       ((|greater_SI| |i| #6#)
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (PROGN
                                                         (LETT #5#
                                                               (SPADCALL |m|
                                                                         (SPADCALL
                                                                          |i|
                                                                          (QREFELT
                                                                           $
                                                                           13))
                                                                         (QREFELT
                                                                          $
                                                                          138)))
                                                         (COND
                                                          (#3#
                                                           (LETT #4#
                                                                 (SPADCALL #4#
                                                                           #5#
                                                                           (QREFELT
                                                                            $
                                                                            107))))
                                                          ('T
                                                           (PROGN
                                                            (LETT #4# #5#)
                                                            (LETT #3# 'T)))))))
                                                      (LETT |i| (|inc_SI| |i|))
                                                      (GO G190) G191
                                                      (EXIT NIL))
                                                 (COND (#3# #4#)
                                                       ('T
                                                        (|spadConstant| $
                                                                        71))))
                                                (SPADCALL |x| (QREFELT $ 88))
                                                (QREFELT $ 107))))
                                   (GO #10=#:G1587)))
                                 ('T (|error| "bad order of factorials"))))
                          (GO #11=#:G1584)))))))
                    #11# (EXIT #1#))
                   (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS 2 'T))))
            #9# (EXIT #8#)))
          #10# (EXIT #2#)))) 

(SDEFUN |EFSTRUC;normalize;LLL;57|
        ((|lf| (|List| F)) (|lx| (|List| (|Symbol|))) ($ (|List| F)))
        (SPROG ((|lf2| (|List| F)) (#1=#:G1599 NIL) (|f| NIL) (#2=#:G1598 NIL))
               (SEQ
                (LETT |lf2|
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |f| NIL) (LETT #1# |lf|) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS (SPADCALL |f| (QREFELT $ 23)) #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#)))))
                (EXIT (QVELT (SPADCALL |lf2| |lx| (QREFELT $ 181)) 0))))) 

(DECLAIM (NOTINLINE |ElementaryFunctionStructurePackage;|)) 

(DEFUN |ElementaryFunctionStructurePackage| (&REST #1=#:G1600)
  (SPROG NIL
         (PROG (#2=#:G1601)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ElementaryFunctionStructurePackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |ElementaryFunctionStructurePackage;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ElementaryFunctionStructurePackage|)))))))))) 

(DEFUN |ElementaryFunctionStructurePackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ElementaryFunctionStructurePackage| DV$1 DV$2))
          (LETT $ (GETREFV 204))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ElementaryFunctionStructurePackage|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|htrig|)
          (QSETREFV $ 9 '|trig|)
          (QSETREFV $ 10 (|HasCategory| |#2| '(|CombinatorialOpsCategory|)))
          (QSETREFV $ 16
                    (SPADCALL (SPADCALL (QREFELT $ 11))
                              (SPADCALL (SPADCALL 2 (QREFELT $ 13))
                                        (QREFELT $ 14))
                              (QREFELT $ 15)))
          (COND
           ((|HasCategory| |#1| '(|GcdDomain|))
            (QSETREFV $ 50
                      (CONS (|dispatchFunction| |EFSTRUC;tanQ;F2F;11|) $)))
           ('T
            (QSETREFV $ 50
                      (CONS (|dispatchFunction| |EFSTRUC;tanQ;F2F;12|) $))))
          (QSETREFV $ 72 '|%alg|)
          (QSETREFV $ 126
                    (SPADCALL (SPADCALL '|%iint| (QREFELT $ 123))
                              (QREFELT $ 125)))
          (COND
           ((|HasCategory| |#1| '(|GcdDomain|))
            (PROGN
             (QSETREFV $ 196
                       (CONS (|dispatchFunction| |EFSTRUC;irootDep;KU;48|)
                             $))))
           ('T
            (QSETREFV $ 196
                      (CONS (|dispatchFunction| |EFSTRUC;irootDep;KU;49|) $))))
          (COND
           ((|HasCategory| |#2| '(|CombinatorialOpsCategory|))
            (PROGN
             (QSETREFV $ 198
                       (CONS (|dispatchFunction| |EFSTRUC;normalize;LLL;55|)
                             $))))
           ('T
            (QSETREFV $ 198
                      (CONS (|dispatchFunction| |EFSTRUC;normalize;LLL;57|)
                            $))))
          $))) 

(MAKEPROP '|ElementaryFunctionStructurePackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'HTRIG
              'TRIG '|comb?| (0 . |pi|) (|Integer|) (4 . |coerce|) (9 . -)
              (14 . /) '|mpiover2| (|Mapping| 7 29) |EFSTRUC;rmap;M2F;26|
              (|Symbol|) |EFSTRUC;realElementary;FSF;2| (|List| 19)
              (20 . |variables|) |EFSTRUC;realElementary;2F;3|
              |EFSTRUC;realLiouvillian;2F;4| |EFSTRUC;realLiouvillian;FSF;5|
              (25 . |Zero|) (|Boolean|) (29 . ~=) (|Kernel| 7) (35 . |is?|)
              (|List| 7) (41 . |argument|) (46 . |first|) (51 . =)
              (|Mapping| 27 29) (|List| 29) (57 . |select|) (|Fraction| 12)
              (63 . |denom|) (|SparseUnivariatePolynomial| 7)
              (|PositiveInteger|) (|TangentExpansions| 7) (68 . |tanAn|)
              (|SparseUnivariatePolynomial| $) (74 . |zeroOf|)
              (|AlgebraicManipulations| 6 7) (79 . |rootSimp|) (84 . |numer|)
              (89 . |tanNa|) (95 . |tanQ|) (|Union| 12 '#1="failed")
              (101 . |retractIfCan|) (106 . |tanSum|) (111 . |inv|)
              (116 . |tan|) (121 . |Zero|) (125 . |differentiate|) (|Vector| 7)
              (131 . |setelt!|) (138 . |elt|) (|OutputForm|) (144 . |coerce|)
              (|Void|) (149 . |print|) (|Matrix| 7) (154 . |setelt!|)
              (|Union| 105 '"failed") (|IntegerLinearDependence| 7)
              (162 . |particularSolutionOverQ|) (168 . |One|) (172 . |One|)
              'ALGOP (|BasicOperator|) (176 . |operator|) (181 . |has?|)
              (187 . |elt|) (|Union| 38 '#1#) (193 . |retractIfCan|)
              (198 . |One|) (|List| 87) (202 . |kernels|) (207 . =) (213 . -)
              (|List| 38) (|MultiplicativeDependence|) (218 . |logDependenceQ|)
              (|Kernel| $) (224 . |coerce|) (229 . |log|)
              (|Union| 95 '"failed") (|Expression| 6) (|Numeric| 6)
              (234 . |numericIfCan|) (|NonNegativeInteger|) (|Float|)
              (240 . |rationalApproximation|) (246 . |Zero|) (250 . |coerce|)
              (255 . /) (261 . |float|) (268 . -) (274 . |abs|) (279 . >)
              (285 . ^) (|Vector| 38) (291 . |zero|) (296 . *) (302 . |new|)
              (306 . |kernel|) (|List| $) (311 . |eval|) (318 . |atan|)
              (323 . ~=) (329 . |coerce|) (|Mapping| 7 6)
              (|SparseMultivariatePolynomial| 6 29)
              (|PolynomialCategoryLifting| (|IndexedExponents| 29) 29 6 116 7)
              (334 . |map|) (|SparseMultivariatePolynomial| 6 87)
              (341 . |numer|) (346 . |denom|) (|CommonOperators|)
              (351 . |operator|) (|LiouvillianFunction| 6 7) (356 . |operator|)
              '|opint| (361 . |is?|) (367 . |zero?|) (372 . |last|)
              (377 . |exp|) (382 . |acot|) (387 . ^) (393 . |asin|) (398 . -)
              (404 . |sqrt|) (409 . |acos|) (414 . |acsc|) (419 . +) (425 . *)
              (431 . |One|) (435 . |elt|) (441 . |coerce|) (446 . D)
              (452 . |zero?|) (|Mapping| 27 7) (457 . |every?|)
              (463 . |concat|) (469 . |kernel|) (475 . |name|)
              (480 . |minIndex|) (485 . |elt|) (491 . |retract|)
              (496 . |nthRoot|) (502 . |second|) (507 . |retract|) (512 . ~=)
              (518 . |coerce|) (523 . /) (529 . ^) (535 . *)
              (541 . |retractIfCan|) (546 . |height|) (|Union| $ '"failed")
              (551 . |recip|) (556 . |inv|) (561 . *) (567 . *)
              (573 . |every?|)
              (|Record| (|:| |num| (|Vector| 12)) (|:| |den| 12))
              (|InnerCommonDenominator| 12 38 (|Vector| 12) 105)
              (579 . |splitDenominator|) (584 . |lcm|) (589 . *)
              (595 . |coerce|) (600 . |tower|) (605 . |variables|)
              (610 . |setDifference|) (616 . |first|) (622 . |empty?|)
              (|Record| (|:| |funcs| 31) (|:| |kers| 36) (|:| |vals| 31))
              |EFSTRUC;rischNormalize;LLR;42| (627 . |concat|)
              (|Record| (|:| |func| 7) (|:| |kers| 36) (|:| |vals| 31))
              |EFSTRUC;rischNormalize;FLR;43| |EFSTRUC;rischNormalize;FSR;44|
              (633 . |tower|) |EFSTRUC;rootNormalize;FKF;45|
              (638 . |construct|) (643 . |particularSolutionOverQ|)
              (|Union| 7 '#2="failed") |EFSTRUC;validExponential;LFSU;47|
              (|Record| (|:| |exponent| 94) (|:| |coef| 7) (|:| |radicand| 7))
              (|PolynomialRoots| (|IndexedExponents| 29) 29 6 116 7)
              (649 . |froot|)
              (|Union| (|:| |vec| 105) (|:| |func| 7) (|:| |fail| 27))
              (655 . |irootDep|) (660 . |lcm|) (666 . |normalize|)
              |EFSTRUC;normalize;2F;52| |EFSTRUC;normalize;2L;53|
              |EFSTRUC;normalize;FSF;54| (672 . |factorials|)
              (677 . |factorial|))
           '#(|validExponential| 682 |tanQ| 689 |rootNormalize| 695 |rmap| 701
              |rischNormalize| 707 |realLiouvillian| 725 |realElementary| 736
              |normalize| 747 |irootDep| 769)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|normalize| (|#2| |#2|)) T)
                                   '((|normalize|
                                      ((|List| |#2|) (|List| |#2|)))
                                     T)
                                   '((|normalize| (|#2| |#2| (|Symbol|))) T)
                                   '((|normalize|
                                      ((|List| |#2|) (|List| |#2|)
                                       (|List| (|Symbol|))))
                                     T)
                                   '((|rischNormalize|
                                      ((|Record| (|:| |func| |#2|)
                                                 (|:| |kers|
                                                      (|List| (|Kernel| |#2|)))
                                                 (|:| |vals| (|List| |#2|)))
                                       |#2| (|Symbol|)))
                                     T)
                                   '((|rischNormalize|
                                      ((|Record| (|:| |func| |#2|)
                                                 (|:| |kers|
                                                      (|List| (|Kernel| |#2|)))
                                                 (|:| |vals| (|List| |#2|)))
                                       |#2| (|List| (|Symbol|))))
                                     T)
                                   '((|rischNormalize|
                                      ((|Record| (|:| |funcs| (|List| |#2|))
                                                 (|:| |kers|
                                                      (|List| (|Kernel| |#2|)))
                                                 (|:| |vals| (|List| |#2|)))
                                       (|List| |#2|) (|List| (|Symbol|))))
                                     T)
                                   '((|realElementary| (|#2| |#2|)) T)
                                   '((|realLiouvillian| (|#2| |#2|)) T)
                                   '((|realLiouvillian| (|#2| |#2| (|Symbol|)))
                                     T)
                                   '((|realElementary| (|#2| |#2| (|Symbol|)))
                                     T)
                                   '((|validExponential|
                                      ((|Union| |#2| #2#)
                                       (|List| (|Kernel| |#2|)) |#2|
                                       (|Symbol|)))
                                     T)
                                   '((|rootNormalize|
                                      (|#2| |#2| (|Kernel| |#2|)))
                                     T)
                                   '((|rmap|
                                      (|#2| (|Mapping| |#2| (|Kernel| |#2|))
                                       |#2|))
                                     T)
                                   '((|tanQ|
                                      (|#2| (|Fraction| (|Integer|)) |#2|))
                                     T)
                                   '((|irootDep|
                                      ((|Union|
                                        (|:| |vec|
                                             (|Vector|
                                              (|Fraction| (|Integer|))))
                                        (|:| |func| |#2|)
                                        (|:| |fail| (|Boolean|)))
                                       (|Kernel| |#2|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 203
                                            '(0 7 0 11 1 7 0 12 13 1 7 0 0 14 2
                                              7 0 0 0 15 1 7 21 0 22 0 7 0 26 2
                                              7 27 0 0 28 2 29 27 0 19 30 1 29
                                              31 0 32 1 31 7 0 33 2 7 27 0 0 34
                                              2 36 0 35 0 37 1 38 12 0 39 2 42
                                              40 7 41 43 1 7 0 44 45 1 46 7 7
                                              47 1 38 12 0 48 2 42 7 7 12 49 2
                                              0 7 38 7 50 1 7 51 0 52 1 42 7 31
                                              53 1 7 0 0 54 1 7 0 0 55 0 6 0 56
                                              2 7 0 0 19 57 3 58 7 0 12 7 59 2
                                              58 7 0 12 60 1 7 61 0 62 1 61 63
                                              0 64 4 65 7 0 12 12 7 66 2 68 67
                                              65 58 69 0 6 0 70 0 7 0 71 1 29
                                              73 0 74 2 73 27 0 19 75 2 31 7 0
                                              12 76 1 7 77 0 78 0 38 0 79 1 7
                                              80 0 81 2 38 27 0 0 82 1 38 0 0
                                              83 2 85 67 84 38 86 1 7 0 87 88 1
                                              7 0 0 89 2 92 90 91 41 93 2 95 38
                                              0 94 96 0 38 0 97 1 95 0 38 98 2
                                              95 0 0 0 99 3 95 0 12 12 41 100 2
                                              95 0 0 0 101 1 95 0 0 102 2 95 27
                                              0 0 103 2 7 0 0 12 104 1 105 0 94
                                              106 2 7 0 0 0 107 0 19 0 108 1 29
                                              0 19 109 3 7 0 0 80 110 111 1 7 0
                                              0 112 2 29 27 0 0 113 1 7 0 6 114
                                              3 117 7 17 115 116 118 1 7 119 0
                                              120 1 7 119 0 121 1 122 73 19 123
                                              1 124 73 73 125 2 73 27 0 19 127
                                              1 7 27 0 128 1 31 7 0 129 1 7 0 0
                                              130 1 7 0 0 131 2 7 0 0 41 132 1
                                              7 0 0 133 2 7 0 0 0 134 1 7 0 0
                                              135 1 7 0 0 136 1 7 0 0 137 2 7 0
                                              0 0 138 2 7 0 41 0 139 0 116 0
                                              140 2 7 0 73 110 141 1 7 0 19 142
                                              2 7 0 0 19 143 1 38 27 0 144 2 31
                                              27 145 0 146 2 31 0 0 0 147 2 7 0
                                              73 110 148 1 73 19 0 149 1 105 12
                                              0 150 2 105 38 0 12 151 1 38 12 0
                                              152 2 7 0 0 12 153 1 31 7 0 154 1
                                              7 12 0 155 2 12 27 0 0 156 1 38 0
                                              12 157 2 38 0 0 0 158 2 7 0 0 38
                                              159 2 7 0 38 0 160 1 38 51 0 161
                                              1 29 94 0 162 1 38 163 0 164 1 38
                                              0 0 165 2 7 0 12 0 166 2 38 0 0
                                              12 167 2 36 27 35 0 168 1 170 169
                                              105 171 1 12 0 110 172 2 38 0 12
                                              0 173 1 6 0 12 174 1 7 80 110 175
                                              1 7 21 110 176 2 21 0 0 0 177 2
                                              36 0 0 94 178 1 105 27 0 179 2 36
                                              0 0 0 182 1 7 80 0 186 1 58 0 31
                                              188 2 68 67 58 7 189 2 193 192 7
                                              94 194 1 0 195 29 196 2 12 0 0 0
                                              197 2 0 31 31 21 198 1 7 0 0 202
                                              1 12 0 0 203 3 0 190 36 7 19 191
                                              2 0 7 38 7 50 2 0 7 7 29 187 2 0
                                              7 17 7 18 2 0 183 7 21 184 2 0
                                              183 7 19 185 2 0 180 31 21 181 2
                                              0 7 7 19 25 1 0 7 7 24 1 0 7 7 23
                                              2 0 7 7 19 20 1 0 31 31 200 1 0 7
                                              7 199 2 0 31 31 21 198 2 0 7 7 19
                                              201 1 0 195 29 196)))))
           '|lookupComplete|)) 

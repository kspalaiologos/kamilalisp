
(SDEFUN |MRVLIM;var_kers|
        ((|e| (|Expression| (|Integer|)))
         ($ (|List| (|Kernel| (|Expression| (|Integer|))))))
        (SPROG ((#1=#:G752 NIL) (|kk| NIL) (#2=#:G751 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |kk| NIL) (LETT #1# (SPADCALL |e| (QREFELT $ 21)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |kk| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL
                           (SPADCALL (SPADCALL |kk| (QREFELT $ 23))
                                     (QREFELT $ 11) (QREFELT $ 24))
                           (|spadConstant| $ 7) (QREFELT $ 26))
                          (LETT #2# (CONS |kk| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |MRVLIM;mrv_normalize;ESRE;2|
        ((|f| (|Expression| (|Integer|))) (|x| (|Symbol|))
         (|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($ (|Expression| (|Integer|))))
        (SPROG
         ((#1=#:G804 NIL) (|nk| (|Expression| (|Integer|))) (|ss| (|Integer|))
          (|la| (|OrderedCompletion| (|Expression| (|Integer|))))
          (|l_ts| (|List| (|Symbol|)))
          (|l_tan| (|List| (|Kernel| (|Expression| (|Integer|)))))
          (|ns| (|Symbol|)) (|need_subst| (|Boolean|))
          (|l_as| (|List| (|Symbol|)))
          (|l_atan| (|List| (|Kernel| (|Expression| (|Integer|)))))
          (|lau|
           (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) "failed"))
          (|arg1| (|Expression| (|Integer|))) (|nm| (|Symbol|))
          (|ntf| (|List| (|Expression| (|Integer|))))
          (|rtf| (|List| (|Kernel| (|Expression| (|Integer|)))))
          (|nargs| (|List| (|Expression| (|Integer|)))) (#2=#:G807 NIL)
          (|arg| NIL) (#3=#:G806 NIL)
          (|args| (|List| (|Expression| (|Integer|)))) (|op| (|BasicOperator|))
          (#4=#:G805 NIL) (|k| NIL)
          (|tf| (|List| (|Kernel| (|Expression| (|Integer|))))))
         (SEQ (LETT |f| (SPADCALL |f| (QREFELT $ 28)))
              (LETT |tf| (SPADCALL |f| (QREFELT $ 21))) (LETT |rtf| NIL)
              (LETT |ntf| NIL) (LETT |l_atan| NIL) (LETT |l_as| NIL)
              (LETT |l_tan| NIL) (LETT |l_ts| NIL)
              (SEQ (LETT |k| NIL) (LETT #4# |tf|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |k| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL
                        (SPADCALL (SPADCALL |k| (QREFELT $ 23)) |x|
                                  (QREFELT $ 24))
                        (|spadConstant| $ 7) (QREFELT $ 29))
                       "iterate")
                      ('T
                       (SEQ (LETT |op| (SPADCALL |k| (QREFELT $ 31)))
                            (LETT |args| (SPADCALL |k| (QREFELT $ 33)))
                            (LETT |nargs|
                                  (PROGN
                                   (LETT #3# NIL)
                                   (SEQ (LETT |arg| NIL) (LETT #2# |args|) G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN
                                               (LETT |arg| (CAR #2#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #3#
                                                (CONS
                                                 (SPADCALL |arg| |rtf| |ntf|
                                                           (QREFELT $ 35))
                                                 #3#))))
                                        (LETT #2# (CDR #2#)) (GO G190) G191
                                        (EXIT (NREVERSE #3#)))))
                            (LETT |nk|
                                  (COND
                                   ((SPADCALL |args| |nargs| (QREFELT $ 36))
                                    (SPADCALL |op| |nargs| (QREFELT $ 37)))
                                   ('T (SPADCALL |k| (QREFELT $ 23)))))
                            (LETT |rtf| (CONS |k| |rtf|))
                            (LETT |ntf| (CONS |nk| |ntf|))
                            (LETT |nm| (SPADCALL |op| (QREFELT $ 38)))
                            (EXIT
                             (COND
                              ((OR (EQUAL |nm| '|exp|) (EQUAL |nm| '|log|))
                               "iterate")
                              ('T
                               (SEQ
                                (EXIT
                                 (COND
                                  ((EQL (LENGTH |args|) 1)
                                   (PROGN
                                    (LETT #1#
                                          (SEQ
                                           (LETT |lau|
                                                 (SPADCALL
                                                  (LETT |arg1|
                                                        (SPADCALL |nargs| 1
                                                                  (QREFELT $
                                                                           41)))
                                                  |x| |state| (QREFELT $ 44)))
                                           (EXIT
                                            (COND
                                             ((EQUAL |nm| '|atan|)
                                              (COND
                                               ((QEQCAR |lau| 1)
                                                (SEQ
                                                 (LETT |ns|
                                                       (SPADCALL
                                                        (QREFELT $ 10)))
                                                 (LETT |nk|
                                                       (SPADCALL |ns|
                                                                 (QREFELT $
                                                                          45)))
                                                 (LETT |l_atan|
                                                       (CONS
                                                        (SPADCALL
                                                         (SPADCALL |nk|
                                                                   (QREFELT $
                                                                            46))
                                                         1 (QREFELT $ 48))
                                                        |l_atan|))
                                                 (LETT |l_as|
                                                       (CONS |ns| |l_as|))
                                                 (EXIT
                                                  (SPADCALL |ntf| 1 |nk|
                                                            (QREFELT $ 49)))))
                                               ('T
                                                (SEQ (LETT |la| (QCDR |lau|))
                                                     (LETT |ss|
                                                           (SPADCALL |la|
                                                                     (QREFELT $
                                                                              52)))
                                                     (EXIT
                                                      (COND
                                                       ((EQL |ss| 0) "iterate")
                                                       ('T
                                                        (SEQ
                                                         (LETT |nk|
                                                               (COND
                                                                ((EQL |ss| 1)
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (QREFELT $
                                                                             53))
                                                                   (SPADCALL 2
                                                                             (QREFELT
                                                                              $
                                                                              54))
                                                                   (QREFELT $
                                                                            55))
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (|spadConstant|
                                                                     $ 39)
                                                                    |arg1|
                                                                    (QREFELT $
                                                                             55))
                                                                   (QREFELT $
                                                                            56))
                                                                  (QREFELT $
                                                                           57)))
                                                                ('T
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     (QREFELT $
                                                                              53))
                                                                    (SPADCALL 2
                                                                              (QREFELT
                                                                               $
                                                                               54))
                                                                    (QREFELT $
                                                                             55))
                                                                   (QREFELT $
                                                                            58))
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    (|spadConstant|
                                                                     $ 39)
                                                                    |arg1|
                                                                    (QREFELT $
                                                                             55))
                                                                   (QREFELT $
                                                                            56))
                                                                  (QREFELT $
                                                                           57)))))
                                                         (EXIT
                                                          (SPADCALL |ntf| 1
                                                                    |nk|
                                                                    (QREFELT $
                                                                             49)))))))))))
                                             ((EQUAL |nm| '|tan|)
                                              (SEQ
                                               (LETT |need_subst|
                                                     (COND
                                                      ((QEQCAR |lau| 1) 'T)
                                                      ('T
                                                       (SEQ
                                                        (LETT |la|
                                                              (QCDR |lau|))
                                                        (LETT |ss|
                                                              (SPADCALL |la|
                                                                        (QREFELT
                                                                         $
                                                                         52)))
                                                        (EXIT
                                                         (NULL
                                                          (EQL |ss| 0)))))))
                                               (EXIT
                                                (COND
                                                 (|need_subst|
                                                  (SEQ
                                                   (LETT |ns|
                                                         (SPADCALL
                                                          (QREFELT $ 10)))
                                                   (LETT |nk|
                                                         (SPADCALL |ns|
                                                                   (QREFELT $
                                                                            45)))
                                                   (LETT |l_tan|
                                                         (CONS
                                                          (SPADCALL
                                                           (SPADCALL |nk|
                                                                     (QREFELT $
                                                                              46))
                                                           1 (QREFELT $ 48))
                                                          |l_tan|))
                                                   (LETT |l_ts|
                                                         (CONS |ns| |l_ts|))
                                                   (EXIT
                                                    (SPADCALL |ntf| 1 |nk|
                                                              (QREFELT $
                                                                       49)))))
                                                 ('T "iterate")))))
                                             ((QEQCAR |lau| 1) "iterate")
                                             ('T
                                              (SEQ (LETT |la| (QCDR |lau|))
                                                   (LETT |ss|
                                                         (SPADCALL |la|
                                                                   (QREFELT $
                                                                            52)))
                                                   (EXIT
                                                    (COND
                                                     ((EQUAL |nm| '|Gamma|)
                                                      (COND
                                                       ((EQL |ss| 1)
                                                        (SEQ
                                                         (LETT |nk|
                                                               (SPADCALL
                                                                (SPADCALL
                                                                 (QREFELT $ 16)
                                                                 |arg1|
                                                                 (QREFELT $
                                                                          59))
                                                                (QREFELT $
                                                                         60)))
                                                         (EXIT
                                                          (SPADCALL |ntf| 1
                                                                    |nk|
                                                                    (QREFELT $
                                                                             49)))))))
                                                     ((EQUAL |nm| '|Ei|)
                                                      (COND
                                                       ((EQL |ss| 1)
                                                        (SEQ
                                                         (LETT |nk|
                                                               (SPADCALL
                                                                (SPADCALL
                                                                 |arg1|
                                                                 (QREFELT $
                                                                          60))
                                                                (SPADCALL
                                                                 (QREFELT $ 17)
                                                                 |arg1|
                                                                 (QREFELT $
                                                                          59))
                                                                (QREFELT $
                                                                         61)))
                                                         (EXIT
                                                          (SPADCALL |ntf| 1
                                                                    |nk|
                                                                    (QREFELT $
                                                                             49)))))))
                                                     ((EQUAL |nm| '|li|)
                                                      (COND
                                                       ((EQL |ss| 1)
                                                        (SEQ
                                                         (LETT |nk|
                                                               (SPADCALL |arg1|
                                                                         (SPADCALL
                                                                          (QREFELT
                                                                           $
                                                                           17)
                                                                          (SPADCALL
                                                                           |arg1|
                                                                           (QREFELT
                                                                            $
                                                                            62))
                                                                          (QREFELT
                                                                           $
                                                                           59))
                                                                         (QREFELT
                                                                          $
                                                                          61)))
                                                         (EXIT
                                                          (SPADCALL |ntf| 1
                                                                    |nk|
                                                                    (QREFELT $
                                                                             49)))))))
                                                     ((EQUAL |nm| '|erf|)
                                                      (COND
                                                       ((EQL |ss| 1)
                                                        (SEQ
                                                         (LETT |nk|
                                                               (SPADCALL
                                                                (|spadConstant|
                                                                 $ 39)
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    |arg1| 2
                                                                    (QREFELT $
                                                                             64))
                                                                   (QREFELT $
                                                                            58))
                                                                  (QREFELT $
                                                                           60))
                                                                 (SPADCALL
                                                                  (QREFELT $
                                                                           18)
                                                                  |arg1|
                                                                  (QREFELT $
                                                                           59))
                                                                 (QREFELT $
                                                                          61))
                                                                (QREFELT $
                                                                         57)))
                                                         (EXIT
                                                          (SPADCALL |ntf| 1
                                                                    |nk|
                                                                    (QREFELT $
                                                                             49)))))
                                                       ((EQL |ss| -1)
                                                        (SEQ
                                                         (LETT |nk|
                                                               (SPADCALL
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    |arg1| 2
                                                                    (QREFELT $
                                                                             64))
                                                                   (QREFELT $
                                                                            58))
                                                                  (QREFELT $
                                                                           60))
                                                                 (SPADCALL
                                                                  (QREFELT $
                                                                           18)
                                                                  (SPADCALL
                                                                   |arg1|
                                                                   (QREFELT $
                                                                            58))
                                                                  (QREFELT $
                                                                           59))
                                                                 (QREFELT $
                                                                          61))
                                                                (|spadConstant|
                                                                 $ 39)
                                                                (QREFELT $
                                                                         57)))
                                                         (EXIT
                                                          (SPADCALL |ntf| 1
                                                                    |nk|
                                                                    (QREFELT $
                                                                             49)))))))
                                                     ((EQUAL |nm| '|erfi|)
                                                      (COND
                                                       ((EQL |ss| 1)
                                                        (SEQ
                                                         (LETT |nk|
                                                               (SPADCALL
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  |arg1| 2
                                                                  (QREFELT $
                                                                           64))
                                                                 (QREFELT $
                                                                          60))
                                                                (SPADCALL
                                                                 (QREFELT $ 19)
                                                                 |arg1|
                                                                 (QREFELT $
                                                                          59))
                                                                (QREFELT $
                                                                         61)))
                                                         (EXIT
                                                          (SPADCALL |ntf| 1
                                                                    |nk|
                                                                    (QREFELT $
                                                                             49)))))
                                                       ((EQL |ss| -1)
                                                        (SEQ
                                                         (LETT |nk|
                                                               (SPADCALL
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   |arg1| 2
                                                                   (QREFELT $
                                                                            64))
                                                                  (QREFELT $
                                                                           60))
                                                                 (SPADCALL
                                                                  (QREFELT $
                                                                           19)
                                                                  (SPADCALL
                                                                   |arg1|
                                                                   (QREFELT $
                                                                            58))
                                                                  (QREFELT $
                                                                           59))
                                                                 (QREFELT $
                                                                          61))
                                                                (QREFELT $
                                                                         58)))
                                                         (EXIT
                                                          (SPADCALL |ntf| 1
                                                                    |nk|
                                                                    (QREFELT $
                                                                             49)))))))))))))))
                                    (GO #5=#:G797)))))
                                #5# (EXIT #1#))))))))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (QSETVELT |state| 0 |l_ts|) (QSETVELT |state| 1 |l_as|)
              (QSETVELT |state| 2 |l_tan|) (QSETVELT |state| 3 |l_atan|)
              (EXIT (SPADCALL |f| |rtf| |ntf| (QREFELT $ 35)))))) 

(SDEFUN |MRVLIM;mrv_bounded1|
        ((|e| (|Expression| (|Integer|)))
         (|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($ (|Boolean|)))
        (SPROG
         ((|vde| (|List| (|Symbol|))) (|sde| (|Union| (|Integer|) "failed"))
          (|kk| (|Kernel| (|Expression| (|Integer|))))
          (|de|
           (|SparseMultivariatePolynomial| (|Integer|)
                                           (|Kernel|
                                            (|Expression| (|Integer|)))))
          (|ne|
           (|SparseMultivariatePolynomial| (|Integer|)
                                           (|Kernel|
                                            (|Expression| (|Integer|)))))
          (|ke| (|List| (|Kernel| (|Expression| (|Integer|))))))
         (SEQ (LETT |ke| (SPADCALL |e| (QREFELT $ 46)))
              (LETT |ne| (SPADCALL |e| (QREFELT $ 72)))
              (LETT |de| (SPADCALL |e| (QREFELT $ 73)))
              (EXIT
               (COND
                ((EQL (LENGTH |ke|) 1)
                 (SEQ (LETT |kk| (|SPADfirst| |ke|))
                      (EXIT
                       (COND
                        ((SPADCALL |kk| (QVELT |state| 2) (QREFELT $ 74))
                         (COND
                          ((> (SPADCALL |ne| |kk| (QREFELT $ 77))
                              (SPADCALL |de| |kk| (QREFELT $ 77)))
                           NIL)
                          (#1='T
                           (SEQ
                            (LETT |sde|
                                  (SPADCALL (SPADCALL |de| (QREFELT $ 78))
                                            (QREFELT $ 81)))
                            (EXIT
                             (COND
                              ((QEQCAR |sde| 0)
                               (SPADCALL (QCDR |sde|) 0 (QREFELT $ 82)))
                              (#1# NIL)))))))
                        ((SPADCALL |kk| (QVELT |state| 3) (QREFELT $ 74))
                         (SEQ
                          (LETT |sde|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |de| (QREFELT $ 78)) |kk|
                                           (SPADCALL
                                            (SPADCALL |kk| (QREFELT $ 23))
                                            (QREFELT $ 56))
                                           (QREFELT $ 83))
                                 (QREFELT $ 81)))
                          (EXIT
                           (COND
                            ((QEQCAR |sde| 0)
                             (SPADCALL (QCDR |sde|) 0 (QREFELT $ 82)))
                            (#1# NIL)))))
                        (#1# 'T)))))
                (#1#
                 (SEQ
                  (LETT |vde|
                        (SPADCALL (SPADCALL |de| (QREFELT $ 78))
                                  (QREFELT $ 85)))
                  (COND
                   ((NULL (SPADCALL |vde| (QVELT |state| 0) (QREFELT $ 86)))
                    (COND
                     ((NULL
                       (NULL
                        (SPADCALL |vde| (QVELT |state| 1) (QREFELT $ 86))))
                      (EXIT NIL))))
                   (#1# (EXIT NIL)))
                  (EXIT
                   (NULL
                    (SPADCALL
                     (SPADCALL (SPADCALL |ne| (QREFELT $ 78)) (QREFELT $ 46))
                     (QVELT |state| 2) (QREFELT $ 87))))))))))) 

(SDEFUN |MRVLIM;mrv_bounded|
        ((|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($ (|Mapping| (|Boolean|) (|Expression| (|Integer|)))))
        (SPROG NIL (CONS #'|MRVLIM;mrv_bounded!0| (VECTOR $ |state|)))) 

(SDEFUN |MRVLIM;mrv_bounded!0| ((|e| NIL) ($$ NIL))
        (PROG (|state| $)
          (LETT |state| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MRVLIM;mrv_bounded1| |e| |state| $))))) 

(SDEFUN |MRVLIM;mrv_invertible|
        ((|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($ (|Mapping| (|Boolean|) (|Expression| (|Integer|)))))
        (SPROG ((|var_syms| (|List| (|Symbol|))))
               (SEQ
                (LETT |var_syms|
                      (SPADCALL (QVELT |state| 0) (QVELT |state| 1)
                                (QREFELT $ 88)))
                (EXIT
                 (CONS #'|MRVLIM;mrv_invertible!0|
                       (VECTOR |state| |var_syms| $)))))) 

(SDEFUN |MRVLIM;mrv_invertible!0| ((|e| NIL) ($$ NIL))
        (PROG ($ |var_syms| |state|)
          (LETT $ (QREFELT $$ 2))
          (LETT |var_syms| (QREFELT $$ 1))
          (LETT |state| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|sde| NIL) (|de| NIL) (|ne| NIL) (|kk| NIL) (|ke| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL
                       (SPADCALL (SPADCALL |e| (QREFELT $ 85)) |var_syms|
                                 (QREFELT $ 86))
                       (QREFELT $ 89))
                      'T)
                     ('T
                      (SEQ (LETT |ke| (SPADCALL |e| (QREFELT $ 46)))
                           (EXIT
                            (COND
                             ((SPADCALL (SPADCALL |ke| (QREFELT $ 90))
                                        (|spadConstant| $ 91) (QREFELT $ 92))
                              NIL)
                             ('T
                              (SEQ (LETT |kk| (SPADCALL |ke| (QREFELT $ 93)))
                                   (LETT |ne| (SPADCALL |e| (QREFELT $ 72)))
                                   (LETT |de| (SPADCALL |e| (QREFELT $ 73)))
                                   (EXIT
                                    (COND
                                     ((SPADCALL |kk| (QVELT |state| 2)
                                                (QREFELT $ 74))
                                      (COND
                                       ((SPADCALL
                                         (SPADCALL |ne| |kk| (QREFELT $ 77))
                                         (SPADCALL |de| |kk| (QREFELT $ 77))
                                         (QREFELT $ 94))
                                        NIL)
                                       ('T
                                        (SEQ
                                         (LETT |sde|
                                               (SPADCALL
                                                (SPADCALL |de| (QREFELT $ 78))
                                                (QREFELT $ 81)))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |sde| 0)
                                            (SPADCALL (QCDR |sde|)
                                                      (|spadConstant| $ 95)
                                                      (QREFELT $ 82)))
                                           ('T NIL)))))))
                                     ((SPADCALL |kk| (QVELT |state| 3)
                                                (QREFELT $ 74))
                                      (SEQ
                                       (LETT |sde|
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL |de| (QREFELT $ 78))
                                               |kk|
                                               (SPADCALL
                                                (SPADCALL |kk| (QREFELT $ 23))
                                                (QREFELT $ 56))
                                               (QREFELT $ 83))
                                              (QREFELT $ 81)))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |sde| 0)
                                          (SPADCALL (QCDR |sde|)
                                                    (|spadConstant| $ 95)
                                                    (QREFELT $ 82)))
                                         ('T NIL)))))
                                     ('T NIL)))))))))))))))) 

(SDEFUN |MRVLIM;mrv_zero| ((|e| (|Expression| (|Integer|))) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |e| (QREFELT $ 28)) (|spadConstant| $ 7)
                  (QREFELT $ 29))) 

(SDEFUN |MRVLIM;expr_to_series;EKRU;7|
        ((|e| (|Expression| (|Integer|)))
         (|k| (|Kernel| (|Expression| (|Integer|))))
         (|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($
          (|Union|
           (|Record| (|:| |degree| (|OrderedExpression|))
                     (|:| |coeff| (|Expression| (|Integer|))))
           "failed")))
        (SPROG
         ((#1=#:G892 NIL)
          (|vkers| (|List| (|Kernel| (|Expression| (|Integer|)))))
          (|ssl| (|Upg|)) (|kk| (|Integer|)) (#2=#:G891 NIL)
          (|lc| (|Expression| (|Integer|))) (|ssll| (|Upg|))
          (|deg| (|OrderedExpression|)) (|ssl0| (|Upg|)) (#3=#:G877 NIL)
          (|ss|
           (|Union| (|:| |%series| |Upg|)
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|))))))
          (|h| (|Expression| (|Integer|))) (|ex| (|Expression| (|Integer|))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |ex|
                  (SPADCALL |e| (LIST |k|)
                            (LIST (SPADCALL (QREFELT $ 11) (QREFELT $ 45)))
                            (QREFELT $ 35)))
            (COND
             ((NULL (SPADCALL |k| '|exp| (QREFELT $ 96)))
              (EXIT (|error| "Can only expand with respect to exp"))))
            (LETT |h|
                  (SPADCALL (SPADCALL |k| (QREFELT $ 33)) 1 (QREFELT $ 41)))
            (LETT |ss|
                  (SPADCALL |ex| NIL (CONS 0 "complex") 'T |h|
                            (|MRVLIM;mrv_bounded| |state| $)
                            (|MRVLIM;mrv_invertible| |state| $)
                            (CONS (|function| |MRVLIM;mrv_zero|) $)
                            (QREFELT $ 101)))
            (EXIT
             (COND ((QEQCAR |ss| 1) (CONS 1 "failed"))
                   (#4='T
                    (SEQ
                     (LETT |ssl|
                           (PROG2 (LETT #3# |ss|)
                               (QCDR #3#)
                             (|check_union2| (QEQCAR #3# 0) (QREFELT $ 67)
                                             (|Union|
                                              (|:| |%series| (QREFELT $ 67))
                                              (|:| |%problem|
                                                   (|Record|
                                                    (|:| |func| (|String|))
                                                    (|:| |prob| (|String|)))))
                                             #3#)))
                     (LETT |kk| 0) (LETT |ssl0| |ssl|)
                     (SEQ
                      (EXIT
                       (SEQ G190 NIL
                            (SEQ (LETT |deg| (SPADCALL |ssl| (QREFELT $ 102)))
                                 (LETT |ssll|
                                       (SPADCALL |ssl| |deg| (QREFELT $ 103)))
                                 (LETT |lc|
                                       (SPADCALL
                                        (SPADCALL |ssll| (QREFELT $ 104))
                                        (QREFELT $ 28)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |lc| (|spadConstant| $ 7)
                                              (QREFELT $ 26))
                                    (PROGN (LETT #2# 1) (GO #5=#:G883)))
                                   ('T
                                    (SEQ (LETT |kk| (+ |kk| 1))
                                         (EXIT
                                          (COND
                                           ((> |kk| 100)
                                            (SEQ
                                             (SPADCALL
                                              (SPADCALL |ssl0| (QREFELT $ 108))
                                              (QREFELT $ 111))
                                             (EXIT
                                              (|error|
                                               "Series with many zero terms"))))
                                           ('T
                                            (LETT |ssl|
                                                  (SPADCALL |ssl|
                                                            (QREFELT $
                                                                     112)))))))))))
                            NIL (GO G190) G191 (EXIT NIL)))
                      #5# (EXIT #2#))
                     (LETT |vkers| (|MRVLIM;var_kers| |lc| $))
                     (EXIT
                      (COND
                       ((NULL |vkers|)
                        (PROGN
                         (LETT #1# (CONS 0 (CONS |deg| |lc|)))
                         (GO #6=#:G890)))
                       (#4# (|error| "Too many variable kernels"))))))))))
          #6# (EXIT #1#)))) 

(SDEFUN |MRVLIM;mrv_cmp;2KSRU;8|
        ((|x| (|Kernel| (|Expression| (|Integer|))))
         (|y| (|Kernel| (|Expression| (|Integer|)))) (|v| (|Symbol|))
         (|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($
          (|Union|
           (|Record| (|:| |sign| (|Integer|))
                     (|:| |coeff| (|Expression| (|Integer|))))
           "failed")))
        (SPROG
         ((|pp1| (|OrderedCompletion| (|Expression| (|Integer|))))
          (|ppu|
           (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) "failed"))
          (|y1| (|Expression| (|Integer|))) (|x1| (|Expression| (|Integer|))))
         (SEQ
          (LETT |x1|
                (COND
                 ((SPADCALL |x| '|exp| (QREFELT $ 96))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 33)) 1 (QREFELT $ 41)))
                 (#1='T
                  (SPADCALL (SPADCALL |x| (QREFELT $ 23)) (QREFELT $ 62)))))
          (LETT |y1|
                (COND
                 ((SPADCALL |y| '|exp| (QREFELT $ 96))
                  (SPADCALL (SPADCALL |y| (QREFELT $ 33)) 1 (QREFELT $ 41)))
                 (#1#
                  (SPADCALL (SPADCALL |y| (QREFELT $ 23)) (QREFELT $ 62)))))
          (LETT |ppu|
                (SPADCALL (SPADCALL |x1| |y1| (QREFELT $ 55)) |v| |state|
                          (QREFELT $ 44)))
          (EXIT
           (COND
            ((QEQCAR |ppu| 0)
             (SEQ (LETT |pp1| (QCDR |ppu|))
                  (EXIT
                   (COND
                    ((SPADCALL |pp1|
                               (SPADCALL (|spadConstant| $ 7) (QREFELT $ 116))
                               (QREFELT $ 117))
                     (CONS 0 (CONS -1 (|spadConstant| $ 7))))
                    ((SPADCALL |pp1| (QREFELT $ 118))
                     (CONS 0 (CONS 0 (SPADCALL |pp1| (QREFELT $ 119)))))
                    (#1# (CONS 0 (CONS 1 (|spadConstant| $ 7))))))))
            (#1# (CONS 1 "failed"))))))) 

(SDEFUN |MRVLIM;mrv_set;ESRU;9|
        ((|e| (|Expression| (|Integer|))) (|x| (|Symbol|))
         (|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($
          (|Union|
           (|Record| (|:| |lk| (|List| (|Kernel| (|Expression| (|Integer|)))))
                     (|:| |lc| (|List| (|Expression| (|Integer|)))))
           "failed")))
        (SPROG
         ((|res_c| (|List| (|Expression| (|Integer|))))
          (|res| (|List| #1=(|Kernel| (|Expression| (|Integer|)))))
          (|res_k| #1#) (|c| #2=(|Expression| (|Integer|)))
          (|i| #3=(|Integer|))
          (|ic|
           (|Record| (|:| |sign| (|Integer|))
                     (|:| |coeff| (|Expression| (|Integer|)))))
          (#4=#:G933 NIL)
          (|icu|
           (|Union| (|Record| (|:| |sign| #3#) (|:| |coeff| #2#)) "failed"))
          (#5=#:G934 NIL) (|y| NIL)
          (|kers| (|List| (|Kernel| (|Expression| (|Integer|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |kers| (SPADCALL |e| (QREFELT $ 21)))
                (LETT |res_k|
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| (QREFELT $ 45)) (QREFELT $ 46))
                       1 (QREFELT $ 48)))
                (LETT |res| (LIST |res_k|))
                (LETT |res_c| (LIST (|spadConstant| $ 39)))
                (SEQ (LETT |y| NIL) (LETT #5# |kers|) G190
                     (COND
                      ((OR (ATOM #5#) (PROGN (LETT |y| (CAR #5#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |y| '|exp| (QREFELT $ 96))
                         (SEQ
                          (LETT |icu|
                                (SPADCALL |y| |res_k| |x| |state|
                                          (QREFELT $ 122)))
                          (EXIT
                           (COND
                            ((QEQCAR |icu| 1)
                             (PROGN
                              (LETT #4# (CONS 1 "failed"))
                              (GO #6=#:G932)))
                            ('T
                             (SEQ (LETT |ic| (QCDR |icu|))
                                  (LETT |i| (QCAR |ic|)) (LETT |c| (QCDR |ic|))
                                  (EXIT
                                   (COND
                                    ((> |i| 0)
                                     (SEQ (LETT |res_k| |y|)
                                          (LETT |res| (LIST |y|))
                                          (EXIT
                                           (LETT |res_c|
                                                 (LIST
                                                  (|spadConstant| $ 39))))))
                                    ((EQL |i| 0)
                                     (SEQ (LETT |res| (CONS |y| |res|))
                                          (EXIT
                                           (LETT |res_c|
                                                 (CONS |c| |res_c|)))))))))))))
                        ('T (|spadConstant| $ 7)))))
                     (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (CONS (REVERSE |res|) (REVERSE |res_c|))))))
          #6# (EXIT #4#)))) 

(SDEFUN |MRVLIM;mrv_rewrite1|
        ((|e| (|Expression| (|Integer|)))
         (|lx| (|List| (|Kernel| (|Expression| (|Integer|)))))
         (|ly| (|List| (|Expression| (|Integer|))))
         ($ (|Expression| (|Integer|))))
        (SPROG
         ((#1=#:G939 NIL) (|x| NIL) (#2=#:G940 NIL) (|y| NIL)
          (|rly| (|List| (|Expression| (|Integer|))))
          (|rlx| (|List| (|Kernel| (|Expression| (|Integer|))))))
         (SEQ (LETT |rlx| (REVERSE |lx|)) (LETT |rly| (REVERSE |ly|))
              (SEQ (LETT |y| NIL) (LETT #2# |rly|) (LETT |x| NIL)
                   (LETT #1# |rlx|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL) (ATOM #2#)
                         (PROGN (LETT |y| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |e|
                           (SPADCALL |e| (LIST |x|) (LIST |y|)
                                     (QREFELT $ 35)))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |e|)))) 

(SDEFUN |MRVLIM;mrv_rewrite0;ELL2E;11|
        ((|e| (|Expression| (|Integer|)))
         (|lx| (|List| (|Kernel| (|Expression| (|Integer|)))))
         (|lc| (|List| (|Expression| (|Integer|))))
         (|x00| (|Expression| (|Integer|))) ($ (|Expression| (|Integer|))))
        (SPROG
         ((|lxx| (|List| (|Kernel| (|Expression| (|Integer|)))))
          (|ly| (|List| (|Expression| (|Integer|))))
          (|yi| (|Expression| (|Integer|)))
          (|ei| #1=(|Expression| (|Integer|))) (#2=#:G948 NIL) (|xi| NIL)
          (#3=#:G949 NIL) (|ci| NIL) (|e0| #1#)
          (|c0| (|Expression| (|Integer|))))
         (SEQ (LETT |c0| (|SPADfirst| |lc|))
              (COND
               ((EQL (LENGTH |lx|) 1)
                (COND
                 ((SPADCALL |c0| (|spadConstant| $ 39) (QREFELT $ 29))
                  (EXIT |e|)))))
              (LETT |e0|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |x00| (QREFELT $ 46)) 1
                                (QREFELT $ 48))
                      (QREFELT $ 33))
                     1 (QREFELT $ 41)))
              (LETT |ly| NIL)
              (SEQ (LETT |ci| NIL) (LETT #3# (CDR |lc|)) (LETT |xi| NIL)
                   (LETT #2# (CDR |lx|)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |xi| (CAR #2#)) NIL)
                         (ATOM #3#) (PROGN (LETT |ci| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |ei|
                          (SPADCALL (SPADCALL |xi| (QREFELT $ 33)) 1
                                    (QREFELT $ 41)))
                    (LETT |yi|
                          (SPADCALL (SPADCALL |x00| |ci| (QREFELT $ 126))
                                    (SPADCALL
                                     (SPADCALL |ei|
                                               (SPADCALL |ci| |e0|
                                                         (QREFELT $ 61))
                                               (QREFELT $ 57))
                                     (QREFELT $ 60))
                                    (QREFELT $ 61)))
                    (EXIT (LETT |ly| (CONS |yi| |ly|))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#)))) (GO G190)
                   G191 (EXIT NIL))
              (LETT |ly| (REVERSE |ly|))
              (COND
               ((SPADCALL |c0| (|spadConstant| $ 39) (QREFELT $ 29))
                (LETT |lxx| (CDR |lx|)))
               ('T
                (SEQ
                 (LETT |ly| (CONS (SPADCALL |x00| |c0| (QREFELT $ 126)) |ly|))
                 (EXIT (LETT |lxx| |lx|)))))
              (EXIT (|MRVLIM;mrv_rewrite1| |e| |lxx| |ly| $))))) 

(SDEFUN |MRVLIM;mrv_rewrite;ELLSRU;12|
        ((|e| (|Expression| (|Integer|)))
         (|lx| (|List| (|Kernel| (|Expression| (|Integer|)))))
         (|lc| (|List| (|Expression| (|Integer|)))) (|v| (|Symbol|))
         (|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($
          (|Union|
           (|Record| (|:| |degree| (|OrderedExpression|))
                     (|:| |coeff| (|Expression| (|Integer|))))
           "failed")))
        (SPROG
         ((|lxx| (|List| (|Kernel| (|Expression| (|Integer|)))))
          (|x00| (|Expression| (|Integer|)))
          (|lcc| (|List| (|Expression| (|Integer|)))) (#1=#:G976 NIL)
          (|ci| NIL) (#2=#:G975 NIL) (|ss| (|Integer|))
          (|lipp| (|OrderedCompletion| (|Expression| (|Integer|))))
          (|lip|
           (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) "failed"))
          (|e0| (|Expression| (|Integer|))) (#3=#:G974 NIL) (|ei| NIL)
          (#4=#:G973 NIL) (|x0| (|Kernel| (|Expression| (|Integer|)))))
         (SEQ (LETT |x0| (|SPADfirst| |lx|))
              (EXIT
               (COND
                ((SPADCALL |x0| |v| (QREFELT $ 96))
                 (SEQ
                  (LETT |lxx|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |ei| NIL) (LETT #3# |lx|) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |ei| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #4#
                                      (CONS
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |ei| (QREFELT $ 23))
                                          (LIST |x0|)
                                          (LIST
                                           (SPADCALL
                                            (SPADCALL |v| (QREFELT $ 45))
                                            (QREFELT $ 60)))
                                          (QREFELT $ 35))
                                         (QREFELT $ 46))
                                        1 (QREFELT $ 48))
                                       #4#))))
                              (LETT #3# (CDR #3#)) (GO G190) G191
                              (EXIT (NREVERSE #4#)))))
                  (EXIT
                   (SPADCALL
                    (SPADCALL |e| (LIST |x0|)
                              (LIST
                               (SPADCALL (SPADCALL |v| (QREFELT $ 45))
                                         (QREFELT $ 60)))
                              (QREFELT $ 35))
                    |lxx| |lc| |v| |state| (QREFELT $ 128)))))
                ((NOT (SPADCALL |x0| '|exp| (QREFELT $ 96)))
                 (|error| "mrv is not exp, need substitution"))
                (#5='T
                 (SEQ
                  (LETT |e0|
                        (SPADCALL (SPADCALL |x0| (QREFELT $ 33)) 1
                                  (QREFELT $ 41)))
                  (LETT |lip|
                        (COND
                         ((SPADCALL |e0| (SPADCALL |v| (QREFELT $ 45))
                                    (QREFELT $ 29))
                          (CONS 0 (SPADCALL (QREFELT $ 129))))
                         (#5# (SPADCALL |e0| |v| |state| (QREFELT $ 44)))))
                  (EXIT
                   (COND
                    ((QEQCAR |lip| 0)
                     (SEQ (LETT |lipp| (QCDR |lip|))
                          (LETT |ss| (SPADCALL |lipp| (QREFELT $ 52)))
                          (EXIT
                           (COND ((EQL |ss| 0) (|error| "Wrong mrv element"))
                                 (#5#
                                  (SEQ
                                   (COND
                                    ((> |ss| 0)
                                     (SEQ
                                      (LETT |lcc|
                                            (CONS (|spadConstant| $ 39)
                                                  (PROGN
                                                   (LETT #2# NIL)
                                                   (SEQ (LETT |ci| NIL)
                                                        (LETT #1# |lc|) G190
                                                        (COND
                                                         ((OR (ATOM #1#)
                                                              (PROGN
                                                               (LETT |ci|
                                                                     (CAR #1#))
                                                               NIL))
                                                          (GO G191)))
                                                        (SEQ
                                                         (EXIT
                                                          (LETT #2#
                                                                (CONS
                                                                 (SPADCALL |ci|
                                                                           (QREFELT
                                                                            $
                                                                            58))
                                                                 #2#))))
                                                        (LETT #1# (CDR #1#))
                                                        (GO G190) G191
                                                        (EXIT
                                                         (NREVERSE #2#))))))
                                      (LETT |x00|
                                            (SPADCALL
                                             (SPADCALL |e0| (QREFELT $ 58))
                                             (QREFELT $ 60)))
                                      (EXIT
                                       (LETT |lxx|
                                             (CONS
                                              (SPADCALL
                                               (SPADCALL |x00| (QREFELT $ 46))
                                               1 (QREFELT $ 48))
                                              |lx|)))))
                                    (#5#
                                     (SEQ (LETT |lcc| |lc|)
                                          (LETT |x00|
                                                (SPADCALL |x0| (QREFELT $ 23)))
                                          (EXIT (LETT |lxx| |lx|)))))
                                   (LETT |e|
                                         (SPADCALL |e| |lxx| |lcc| |x00|
                                                   (QREFELT $ 127)))
                                   (EXIT
                                    (SPADCALL |e|
                                              (SPADCALL
                                               (SPADCALL |x00| (QREFELT $ 46))
                                               1 (QREFELT $ 48))
                                              |state| (QREFELT $ 115)))))))))
                    (#5# (|error| "limit failed"))))))))))) 

(SDEFUN |MRVLIM;mrv_sign;ESRU;13|
        ((|e| (|Expression| (|Integer|))) (|v| (|Symbol|))
         (|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($ (|Union| (|Integer|) "failed")))
        (SPROG
         ((|ss|
           (|Record| (|:| |degree| (|OrderedExpression|))
                     (|:| |coeff| (|Expression| (|Integer|)))))
          (|ssu|
           (|Union|
            (|Record| (|:| |degree| (|OrderedExpression|))
                      (|:| |coeff| (|Expression| (|Integer|))))
            "failed"))
          (|lcc| #1=(|List| (|Expression| (|Integer|))))
          (|lx| #2=(|List| (|Kernel| (|Expression| (|Integer|)))))
          (|rkc|
           (|Record| (|:| |lk| (|List| (|Kernel| (|Expression| (|Integer|)))))
                     (|:| |lc| (|List| (|Expression| (|Integer|))))))
          (|rkcu| (|Union| (|Record| (|:| |lk| #2#) (|:| |lc| #1#)) "failed")))
         (SEQ
          (COND
           ((NOT (SPADCALL |v| (SPADCALL |e| (QREFELT $ 85)) (QREFELT $ 130)))
            (SPADCALL |e| (QREFELT $ 81)))
           (#3='T
            (SEQ (LETT |rkcu| (SPADCALL |e| |v| |state| (QREFELT $ 125)))
                 (EXIT
                  (COND ((QEQCAR |rkcu| 1) (CONS 1 "failed"))
                        (#3#
                         (SEQ (LETT |rkc| (QCDR |rkcu|))
                              (LETT |lx| (QCAR |rkc|))
                              (LETT |lcc| (QCDR |rkc|))
                              (LETT |ssu|
                                    (SPADCALL |e| |lx| |lcc| |v| |state|
                                              (QREFELT $ 128)))
                              (EXIT
                               (COND ((QEQCAR |ssu| 1) (CONS 1 "failed"))
                                     (#3#
                                      (SEQ (LETT |ss| (QCDR |ssu|))
                                           (EXIT
                                            (SPADCALL (QCDR |ss|) |v| |state|
                                                      (QREFELT $
                                                               131))))))))))))))))) 

(SDEFUN |MRVLIM;mrv_limit;ESRU;14|
        ((|e| (|Expression| (|Integer|))) (|v| (|Symbol|))
         (|state|
          (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                    (|:| |atan_syms| (|List| (|Symbol|)))
                    (|:| |tan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))
                    (|:| |atan_kers|
                         (|List| (|Kernel| (|Expression| (|Integer|)))))))
         ($
          (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) "failed")))
        (SPROG
         ((|s| (|Integer|)) (|su| (|Union| (|Integer|) "failed"))
          (|deg| (|OrderedExpression|))
          (|ss|
           (|Record| (|:| |degree| (|OrderedExpression|))
                     (|:| |coeff| (|Expression| (|Integer|)))))
          (|ssu|
           (|Union|
            (|Record| (|:| |degree| (|OrderedExpression|))
                      (|:| |coeff| (|Expression| (|Integer|))))
            "failed"))
          (|lcc| #1=(|List| (|Expression| (|Integer|))))
          (|lx| #2=(|List| (|Kernel| (|Expression| (|Integer|)))))
          (|rkc|
           (|Record| (|:| |lk| (|List| (|Kernel| (|Expression| (|Integer|)))))
                     (|:| |lc| (|List| (|Expression| (|Integer|))))))
          (|rkcu| (|Union| (|Record| (|:| |lk| #2#) (|:| |lc| #1#)) "failed"))
          (|ve| (|List| (|Symbol|))))
         (SEQ
          (COND
           ((NOT
             (SPADCALL |v| (LETT |ve| (SPADCALL |e| (QREFELT $ 85)))
                       (QREFELT $ 130)))
            (SEQ
             (COND
              ((NULL (SPADCALL |ve| (QVELT |state| 0) (QREFELT $ 86)))
               (COND
                ((NULL (SPADCALL |ve| (QVELT |state| 1) (QREFELT $ 86)))
                 (EXIT (CONS 0 (SPADCALL |e| (QREFELT $ 116))))))))
             (EXIT (CONS 1 "failed"))))
           (#3='T
            (SEQ (LETT |rkcu| (SPADCALL |e| |v| |state| (QREFELT $ 125)))
                 (EXIT
                  (COND ((QEQCAR |rkcu| 1) (CONS 1 "failed"))
                        (#3#
                         (SEQ (LETT |rkc| (QCDR |rkcu|))
                              (LETT |lx| (QCAR |rkc|))
                              (LETT |lcc| (QCDR |rkc|))
                              (LETT |ssu|
                                    (SPADCALL |e| |lx| |lcc| |v| |state|
                                              (QREFELT $ 128)))
                              (EXIT
                               (COND ((QEQCAR |ssu| 1) (CONS 1 "failed"))
                                     (#3#
                                      (SEQ (LETT |ss| (QCDR |ssu|))
                                           (LETT |deg| (QCAR |ss|))
                                           (EXIT
                                            (COND
                                             ((SPADCALL |deg|
                                                        (|spadConstant| $ 132)
                                                        (QREFELT $ 133))
                                              (CONS 0
                                                    (SPADCALL
                                                     (|spadConstant| $ 7)
                                                     (QREFELT $ 116))))
                                             ((SPADCALL |deg|
                                                        (|spadConstant| $ 132)
                                                        (QREFELT $ 134))
                                              (SPADCALL (QCDR |ss|) |v| |state|
                                                        (QREFELT $ 44)))
                                             ((SPADCALL |deg|
                                                        (|spadConstant| $ 132)
                                                        (QREFELT $ 135))
                                              (SEQ
                                               (LETT |su|
                                                     (SPADCALL (QCDR |ss|) |v|
                                                               |state|
                                                               (QREFELT $
                                                                        131)))
                                               (EXIT
                                                (COND
                                                 ((QEQCAR |su| 1)
                                                  (CONS 1 "failed"))
                                                 (#3#
                                                  (SEQ (LETT |s| (QCDR |su|))
                                                       (EXIT
                                                        (COND
                                                         ((EQL |s| 1)
                                                          (CONS 0
                                                                (SPADCALL
                                                                 (QREFELT $
                                                                          129))))
                                                         ((EQL |s| -1)
                                                          (CONS 0
                                                                (SPADCALL
                                                                 (QREFELT $
                                                                          136))))
                                                         (#3#
                                                          (|error|
                                                           "Nonzero term has no sign")))))))))))))))))))))))))) 

(SDEFUN |MRVLIM;mrv_limit1;ESU;15|
        ((|e| (|Expression| (|Integer|))) (|x| (|Symbol|))
         ($
          (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) "failed")))
        (SPROG
         ((|state|
           (|Record| (|:| |tan_syms| (|List| (|Symbol|)))
                     (|:| |atan_syms| (|List| (|Symbol|)))
                     (|:| |tan_kers|
                          (|List| (|Kernel| (|Expression| (|Integer|)))))
                     (|:| |atan_kers|
                          (|List| (|Kernel| (|Expression| (|Integer|))))))))
         (SEQ (LETT |state| (VECTOR NIL NIL NIL NIL))
              (LETT |e| (SPADCALL |e| |x| |state| (QREFELT $ 65)))
              (EXIT (SPADCALL |e| |x| |state| (QREFELT $ 44)))))) 

(SDEFUN |MRVLIM;mrv_limit;EEU;16|
        ((|e| (|Expression| (|Integer|)))
         (|eq| (|Equation| (|OrderedCompletion| (|Expression| (|Integer|)))))
         ($
          (|Union| (|OrderedCompletion| (|Expression| (|Integer|)))
                   (|Record|
                    (|:| |leftHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Expression| (|Integer|)))
                          #1="failed"))
                    (|:| |rightHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Expression| (|Integer|)))
                          #1#)))
                   "failed")))
        (SPROG
         ((|var| (|Union| (|Symbol|) "failed"))
          (|f| (|Union| (|Expression| (|Integer|)) "failed")))
         (SEQ
          (LETT |f| (SPADCALL (SPADCALL |eq| (QREFELT $ 139)) (QREFELT $ 141)))
          (EXIT
           (COND
            ((QEQCAR |f| 1)
             (|error| "limit:left hand side must be a variable"))
            (#2='T
             (SEQ (LETT |var| (SPADCALL (QCDR |f|) (QREFELT $ 143)))
                  (EXIT
                   (COND
                    ((QEQCAR |var| 1)
                     (|error| "limit:left hand side must be a variable"))
                    (#2#
                     (SPADCALL |e| (QCDR |var|) (SPADCALL |eq| (QREFELT $ 144))
                               (QREFELT $ 147)))))))))))) 

(SDEFUN |MRVLIM;mrv_limit2|
        ((|e| (|Expression| (|Integer|))) (|v| (|Symbol|))
         (|a| (|OrderedCompletion| (|Expression| (|Integer|))))
         ($
          (|Union| (|OrderedCompletion| (|Expression| (|Integer|)))
                   (|Record|
                    (|:| |leftHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Expression| (|Integer|)))
                          #1="failed"))
                    (|:| |rightHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Expression| (|Integer|)))
                          #1#)))
                   "failed")))
        (SPROG
         ((|lr|
           #2=(|Union| (|OrderedCompletion| (|Expression| (|Integer|))) #1#))
          (|et| (|Expression| (|Integer|))) (|ll| #2#)
          (|vK| (|Kernel| (|Expression| (|Integer|)))) (|resu| #2#)
          (|ii| (|SingleInteger|)))
         (SEQ (LETT |ii| (SPADCALL |a| (QREFELT $ 52)))
              (EXIT
               (COND
                ((|eql_SI| |ii| 1)
                 (SEQ (LETT |resu| (SPADCALL |e| |v| (QREFELT $ 137)))
                      (EXIT
                       (COND ((QEQCAR |resu| 1) (CONS 2 "failed"))
                             (#3='T (CONS 0 (QCDR |resu|)))))))
                ((|eql_SI| |ii| -1)
                 (SEQ
                  (LETT |vK|
                        (SPADCALL (SPADCALL |v| (QREFELT $ 45))
                                  (QREFELT $ 149)))
                  (LETT |et|
                        (SPADCALL |e| |vK|
                                  (SPADCALL (SPADCALL |vK| (QREFELT $ 23))
                                            (QREFELT $ 58))
                                  (QREFELT $ 83)))
                  (LETT |resu| (SPADCALL |et| |v| (QREFELT $ 137)))
                  (EXIT
                   (COND ((QEQCAR |resu| 1) (CONS 2 "failed"))
                         (#3# (CONS 0 (QCDR |resu|)))))))
                ((|eql_SI| |ii| 0)
                 (SEQ
                  (LETT |vK|
                        (SPADCALL (SPADCALL |v| (QREFELT $ 45))
                                  (QREFELT $ 149)))
                  (LETT |et|
                        (SPADCALL |e| |vK|
                                  (SPADCALL (SPADCALL |a| (QREFELT $ 119))
                                            (SPADCALL
                                             (SPADCALL |vK| (QREFELT $ 23))
                                             (QREFELT $ 150))
                                            (QREFELT $ 57))
                                  (QREFELT $ 83)))
                  (LETT |ll| (SPADCALL |et| |v| (QREFELT $ 137)))
                  (LETT |et|
                        (SPADCALL |e| |vK|
                                  (SPADCALL (SPADCALL |a| (QREFELT $ 119))
                                            (SPADCALL
                                             (SPADCALL |vK| (QREFELT $ 23))
                                             (QREFELT $ 150))
                                            (QREFELT $ 151))
                                  (QREFELT $ 83)))
                  (LETT |lr| (SPADCALL |et| |v| (QREFELT $ 137)))
                  (EXIT
                   (COND
                    ((SPADCALL |ll| |lr| (QREFELT $ 152))
                     (COND ((QEQCAR |lr| 1) (CONS 2 "failed"))
                           (#3# (CONS 0 (QCDR |lr|)))))
                    (#3# (CONS 1 (CONS |ll| |lr|)))))))))))) 

(SDEFUN |MRVLIM;subst_in_result|
        ((|r|
          (|Union| (|OrderedCompletion| (|Expression| (|Integer|)))
                   #1="failed"))
         (|k| (|Kernel| (|Expression| (|Integer|))))
         (|f| (|Expression| (|Integer|)))
         ($ (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) #1#)))
        (SPROG ((|ru| (|Union| (|Expression| (|Integer|)) "failed")))
               (SEQ
                (COND ((QEQCAR |r| 1) |r|)
                      (#2='T
                       (SEQ (LETT |ru| (SPADCALL (QCDR |r|) (QREFELT $ 141)))
                            (EXIT
                             (COND ((QEQCAR |ru| 1) |r|)
                                   (#2#
                                    (CONS 0
                                          (SPADCALL
                                           (SPADCALL (QCDR |ru|) (LIST |k|)
                                                     (LIST |f|)
                                                     (QREFELT $ 153))
                                           (QREFELT $ 116)))))))))))) 

(SDEFUN |MRVLIM;mrv_limit;ESOcU;19|
        ((|e| (|Expression| (|Integer|))) (|v| (|Symbol|))
         (|a| (|OrderedCompletion| (|Expression| (|Integer|))))
         ($
          (|Union| (|OrderedCompletion| (|Expression| (|Integer|)))
                   (|Record|
                    (|:| |leftHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Expression| (|Integer|)))
                          #1="failed"))
                    (|:| |rightHandLimit|
                         (|Union|
                          (|OrderedCompletion| (|Expression| (|Integer|)))
                          #1#)))
                   #2="failed")))
        (SPROG
         ((#3=#:G1073 NIL)
          (|res2|
           (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) #1#))
          (|res1|
           (|Union| (|OrderedCompletion| (|Expression| (|Integer|)))
                    (|Record|
                     (|:| |leftHandLimit|
                          (|Union|
                           (|OrderedCompletion| (|Expression| (|Integer|)))
                           #1#))
                     (|:| |rightHandLimit|
                          (|Union|
                           (|OrderedCompletion| (|Expression| (|Integer|)))
                           #1#)))
                    #2#))
          (|a1| (|Expression| (|Integer|)))
          (|kv| #4=(|Kernel| (|Expression| (|Integer|)))) (|knv| #4#)
          (|ae| (|Union| (|Expression| (|Integer|)) "failed")))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |ae| (SPADCALL |a| (QREFELT $ 141)))
                 (EXIT
                  (COND
                   ((QEQCAR |ae| 0)
                    (COND
                     ((SPADCALL |v| (SPADCALL (QCDR |ae|) (QREFELT $ 85))
                                (QREFELT $ 130))
                      (PROGN
                       (LETT #3#
                             (SEQ
                              (LETT |knv|
                                    (SPADCALL (SPADCALL (QREFELT $ 10))
                                              (QREFELT $ 154)))
                              (LETT |kv| (SPADCALL |v| (QREFELT $ 154)))
                              (LETT |a1|
                                    (SPADCALL (QCDR |ae|) (LIST |kv|)
                                              (LIST
                                               (SPADCALL |knv| (QREFELT $ 23)))
                                              (QREFELT $ 153)))
                              (LETT |res1|
                                    (|MRVLIM;mrv_limit2| |e| |v|
                                     (SPADCALL |a1| (QREFELT $ 116)) $))
                              (EXIT
                               (COND ((QEQCAR |res1| 2) |res1|)
                                     ((QEQCAR |res1| 1) (|error| "impossible"))
                                     (#5='T
                                      (SEQ
                                       (LETT |res2|
                                             (|MRVLIM;subst_in_result|
                                              (CONS 0 (QCDR |res1|)) |knv|
                                              (SPADCALL |kv| (QREFELT $ 23))
                                              $))
                                       (EXIT
                                        (COND
                                         ((QEQCAR |res2| 1)
                                          (|error| "impossible"))
                                         (#5# (CONS 0 (QCDR |res2|)))))))))))
                       (GO #6=#:G1071))))))))
            (EXIT (|MRVLIM;mrv_limit2| |e| |v| |a| $))))
          #6# (EXIT #3#)))) 

(SDEFUN |MRVLIM;mrv_limit;EESU;20|
        ((|e| (|Expression| (|Integer|)))
         (|eq| (|Equation| (|Expression| (|Integer|)))) (|s| (|String|))
         ($
          (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) "failed")))
        (SPROG ((|f| (|Union| (|Symbol|) "failed")))
               (SEQ
                (LETT |f|
                      (SPADCALL (SPADCALL |eq| (QREFELT $ 156))
                                (QREFELT $ 143)))
                (EXIT
                 (COND
                  ((QEQCAR |f| 1)
                   (|error| "limit:left hand side must be a variable"))
                  ('T
                   (SPADCALL |e| (QCDR |f|) (SPADCALL |eq| (QREFELT $ 157)) |s|
                             (QREFELT $ 159)))))))) 

(SDEFUN |MRVLIM;mrv_limit3|
        ((|e| (|Expression| (|Integer|))) (|v| (|Symbol|))
         (|a| (|Expression| (|Integer|))) (|s| (|String|))
         ($
          (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) "failed")))
        (SPROG
         ((|et| (|Expression| (|Integer|)))
          (|delta| (|Expression| (|Integer|)))
          (|vK| (|Kernel| (|Expression| (|Integer|)))))
         (SEQ (LETT |vK| (SPADCALL |v| (QREFELT $ 154)))
              (LETT |delta|
                    (COND
                     ((EQL (SPADCALL |s| (QREFELT $ 162)) 1)
                      (SPADCALL (SPADCALL |vK| (QREFELT $ 23))
                                (QREFELT $ 150)))
                     ('T
                      (SPADCALL
                       (SPADCALL (SPADCALL |vK| (QREFELT $ 23))
                                 (QREFELT $ 150))
                       (QREFELT $ 58)))))
              (LETT |et|
                    (SPADCALL |e| |vK| (SPADCALL |a| |delta| (QREFELT $ 151))
                              (QREFELT $ 83)))
              (EXIT (SPADCALL |et| |v| (QREFELT $ 137)))))) 

(SDEFUN |MRVLIM;mrv_limit;ESESU;22|
        ((|e| (|Expression| (|Integer|))) (|v| (|Symbol|))
         (|a| (|Expression| (|Integer|))) (|s| (|String|))
         ($
          (|Union| (|OrderedCompletion| (|Expression| (|Integer|)))
                   #1="failed")))
        (SPROG
         ((|res1|
           (|Union| (|OrderedCompletion| (|Expression| (|Integer|))) #1#))
          (|a1| (|Expression| (|Integer|)))
          (|kv| #2=(|Kernel| (|Expression| (|Integer|)))) (|knv| #2#))
         (SEQ
          (COND
           ((SPADCALL |v| (SPADCALL |a| (QREFELT $ 85)) (QREFELT $ 130))
            (SEQ
             (LETT |knv| (SPADCALL (SPADCALL (QREFELT $ 10)) (QREFELT $ 154)))
             (LETT |kv| (SPADCALL |v| (QREFELT $ 154)))
             (LETT |a1|
                   (SPADCALL |a| (LIST |kv|)
                             (LIST (SPADCALL |knv| (QREFELT $ 23)))
                             (QREFELT $ 153)))
             (LETT |res1| (|MRVLIM;mrv_limit3| |e| |v| |a1| |s| $))
             (EXIT
              (|MRVLIM;subst_in_result| |res1| |knv|
               (SPADCALL |kv| (QREFELT $ 23)) $))))
           ('T (|MRVLIM;mrv_limit3| |e| |v| |a| |s| $)))))) 

(DECLAIM (NOTINLINE |MrvLimitPackage;|)) 

(DEFUN |MrvLimitPackage| ()
  (SPROG NIL
         (PROG (#1=#:G1086)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|MrvLimitPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|MrvLimitPackage|
                             (LIST (CONS NIL (CONS 1 (|MrvLimitPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|MrvLimitPackage|)))))))))) 

(DEFUN |MrvLimitPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|MrvLimitPackage|))
          (LETT $ (GETREFV 163))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MrvLimitPackage| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|spadConstant| $ 7))
          (QSETREFV $ 11 (SPADCALL (QREFELT $ 10)))
          (QSETREFV $ 16
                    (SPADCALL (SPADCALL '|%logGamma| (QREFELT $ 14))
                              (QREFELT $ 15)))
          (QSETREFV $ 17
                    (SPADCALL (SPADCALL '|%eis| (QREFELT $ 14))
                              (QREFELT $ 15)))
          (QSETREFV $ 18
                    (SPADCALL (SPADCALL '|%erfs| (QREFELT $ 14))
                              (QREFELT $ 15)))
          (QSETREFV $ 19
                    (SPADCALL (SPADCALL '|%erfis| (QREFELT $ 14))
                              (QREFELT $ 15)))
          (QSETREFV $ 66
                    (|UnivariateTaylorSeries| (|Expression| (|Integer|))
                                              (QREFELT $ 11) (QREFELT $ 8)))
          (QSETREFV $ 67
                    (|GeneralizedUnivariatePowerSeries|
                     (|Expression| (|Integer|)) (|OrderedExpression|)
                     (QREFELT $ 11) (QREFELT $ 8)))
          (QSETREFV $ 70
                    (|FunctionSpaceToUnivariatePowerSeries2| (|Integer|)
                                                             (|Expression|
                                                              (|Integer|))
                                                             (|OrderedExpression|)
                                                             (QREFELT $ 67)
                                                             (|ElementaryFunctionsGeneralizedUnivariatePowerSeries|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (|OrderedExpression|)
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 66)
                                                             (|TaylorSeriesExpansionGeneralized|
                                                              (|Expression|
                                                               (|Integer|))
                                                              (|OrderedExpression|)
                                                              (QREFELT $ 67)
                                                              (QREFELT $ 66))
                                                             (ELT $ 69)
                                                             (QREFELT $ 11)))
          $))) 

(MAKEPROP '|MrvLimitPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Expression| 40) (0 . |Zero|) '|zeroFE|
              (|Symbol|) (4 . |new|) '|series_x| (|BasicOperator|)
              (|CommonOperators|) (8 . |operator|) (13 . |operator|)
              '|op_log_gamma| '|op_eis| '|op_erfs| '|op_erfis| (|List| 22)
              (18 . |tower|) (|Kernel| $) (23 . |coerce|)
              (28 . |differentiate|) (|Boolean|) (34 . ~=)
              (|ElementaryFunctionStructurePackage| 40 6) (40 . |normalize|)
              (45 . =) (|Kernel| 6) (51 . |operator|) (|List| 6)
              (56 . |argument|) (|List| $) (61 . |eval|) (68 . ~=) (74 . |elt|)
              (80 . |name|) (85 . |One|) (|Integer|) (89 . |elt|)
              (|Union| 51 '#1="failed")
              (|Record| (|:| |tan_syms| 84) (|:| |atan_syms| 84)
                        (|:| |tan_kers| 47) (|:| |atan_kers| 47))
              |MRVLIM;mrv_limit;ESRU;14| (95 . |coerce|) (100 . |kernels|)
              (|List| 30) (105 . |elt|) (111 . |setelt!|) (|SingleInteger|)
              (|OrderedCompletion| 6) (118 . |whatInfinity|) (123 . |pi|)
              (127 . |coerce|) (132 . /) (138 . |atan|) (143 . -) (149 . -)
              (154 . |kernel|) (160 . |exp|) (165 . *) (171 . |log|)
              (|PositiveInteger|) (176 . ^) |MRVLIM;mrv_normalize;ESRE;2|
              '|Uts| '|Upg| (|OrderedExpression|) (182 . |coerce|) '|ppack|
              (|SparseMultivariatePolynomial| 40 22) (187 . |numer|)
              (192 . |denom|) (197 . |member?|) (|NonNegativeInteger|)
              (|SparseMultivariatePolynomial| 40 30) (203 . |degree|)
              (209 . |coerce|) (|Union| 40 '"failed")
              (|ElementaryFunctionSign| 40 6) (214 . |sign|) (219 . ~=)
              (225 . |eval|) (|List| 9) (232 . |variables|)
              (237 . |setIntersection|) (243 . |setIntersection|)
              (249 . |concat|) (255 . |empty?|) (260 . |#|) (265 . |One|)
              (269 . ~=) (275 . |first|) (280 . <) (286 . |Zero|) (290 . |is?|)
              (|Record| (|:| |func| 158) (|:| |prob| 158))
              (|Union| (|:| |%series| 67) (|:| |%problem| 97))
              (|Union| '"complex" '"real: two sides" '"real: left side"
                       '"real: right side" '"just do it")
              (|Mapping| 25 6) (296 . |exprToPS|) (308 . |order|)
              (313 . |removeZeros|) (319 . |leadingCoefficient|) (324 . |Zero|)
              (328 . |One|) (|OutputForm|) (332 . |coerce|) (|Void|)
              (|PrintPackage|) (337 . |print|) (342 . |reductum|)
              (|Record| (|:| |degree| 68) (|:| |coeff| 6))
              (|Union| 113 '#2="failed") |MRVLIM;expr_to_series;EKRU;7|
              (347 . |coerce|) (352 . =) (358 . |finite?|) (363 . |retract|)
              (|Record| (|:| |sign| 40) (|:| |coeff| 6))
              (|Union| 120 '#3="failed") |MRVLIM;mrv_cmp;2KSRU;8|
              (|Record| (|:| |lk| 47) (|:| |lc| 32)) (|Union| 123 '#4="failed")
              |MRVLIM;mrv_set;ESRU;9| (368 . ^) |MRVLIM;mrv_rewrite0;ELL2E;11|
              |MRVLIM;mrv_rewrite;ELLSRU;12| (374 . |plusInfinity|)
              (378 . |member?|) |MRVLIM;mrv_sign;ESRU;13| (384 . |Zero|)
              (388 . >) (394 . =) (400 . <) (406 . |minusInfinity|)
              |MRVLIM;mrv_limit1;ESU;15| (|Equation| 51) (410 . |lhs|)
              (|Union| 6 '"failed") (415 . |retractIfCan|)
              (|Union| 9 '"failed") (420 . |retractIfCan|) (425 . |rhs|)
              (|Record| (|:| |leftHandLimit| 42) (|:| |rightHandLimit| 42))
              (|Union| 51 145 '#5="failed") |MRVLIM;mrv_limit;ESOcU;19|
              |MRVLIM;mrv_limit;EEU;16| (430 . |retract|) (435 . |inv|)
              (440 . +) (446 . =) (452 . |subst|) (459 . |kernel|)
              (|Equation| 6) (464 . |lhs|) (469 . |rhs|) (|String|)
              |MRVLIM;mrv_limit;ESESU;22| |MRVLIM;mrv_limit;EESU;20|
              (|ToolsForSign| 40) (474 . |direction|))
           '#(|mrv_sign| 479 |mrv_set| 486 |mrv_rewrite0| 493 |mrv_rewrite| 501
              |mrv_normalize| 510 |mrv_limit1| 517 |mrv_limit| 523 |mrv_cmp|
              558 |expr_to_series| 566)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|mrv_limit|
                                 ((|Union|
                                   (|OrderedCompletion|
                                    (|Expression| (|Integer|)))
                                   (|Record|
                                    (|:| |leftHandLimit|
                                         (|Union|
                                          (|OrderedCompletion|
                                           (|Expression| (|Integer|)))
                                          #1#))
                                    (|:| |rightHandLimit|
                                         (|Union|
                                          (|OrderedCompletion|
                                           (|Expression| (|Integer|)))
                                          #1#)))
                                   #5#)
                                  (|Expression| (|Integer|))
                                  (|Equation|
                                   (|OrderedCompletion|
                                    (|Expression| (|Integer|))))))
                                T)
                              '((|mrv_limit|
                                 ((|Union|
                                   (|OrderedCompletion|
                                    (|Expression| (|Integer|)))
                                   (|Record|
                                    (|:| |leftHandLimit|
                                         (|Union|
                                          (|OrderedCompletion|
                                           (|Expression| (|Integer|)))
                                          #1#))
                                    (|:| |rightHandLimit|
                                         (|Union|
                                          (|OrderedCompletion|
                                           (|Expression| (|Integer|)))
                                          #1#)))
                                   #5#)
                                  (|Expression| (|Integer|)) (|Symbol|)
                                  (|OrderedCompletion|
                                   (|Expression| (|Integer|)))))
                                T)
                              '((|mrv_limit|
                                 ((|Union|
                                   (|OrderedCompletion|
                                    (|Expression| (|Integer|)))
                                   #1#)
                                  (|Expression| (|Integer|))
                                  (|Equation| (|Expression| (|Integer|)))
                                  (|String|)))
                                T)
                              '((|mrv_limit|
                                 ((|Union|
                                   (|OrderedCompletion|
                                    (|Expression| (|Integer|)))
                                   #1#)
                                  (|Expression| (|Integer|)) (|Symbol|)
                                  (|Expression| (|Integer|)) (|String|)))
                                T)
                              '((|mrv_normalize|
                                 ((|Expression| (|Integer|))
                                  (|Expression| (|Integer|)) (|Symbol|)
                                  (|Record|
                                   (|:| |tan_syms| (|List| (|Symbol|)))
                                   (|:| |atan_syms| (|List| (|Symbol|)))
                                   (|:| |tan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|)))))
                                   (|:| |atan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|))))))))
                                T)
                              '((|mrv_limit|
                                 ((|Union|
                                   (|OrderedCompletion|
                                    (|Expression| (|Integer|)))
                                   #1#)
                                  (|Expression| (|Integer|)) (|Symbol|)
                                  (|Record|
                                   (|:| |tan_syms| (|List| (|Symbol|)))
                                   (|:| |atan_syms| (|List| (|Symbol|)))
                                   (|:| |tan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|)))))
                                   (|:| |atan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|))))))))
                                T)
                              '((|mrv_limit1|
                                 ((|Union|
                                   (|OrderedCompletion|
                                    (|Expression| (|Integer|)))
                                   #1#)
                                  (|Expression| (|Integer|)) (|Symbol|)))
                                T)
                              '((|mrv_sign|
                                 ((|Union| (|Integer|) "failed")
                                  (|Expression| (|Integer|)) (|Symbol|)
                                  (|Record|
                                   (|:| |tan_syms| (|List| (|Symbol|)))
                                   (|:| |atan_syms| (|List| (|Symbol|)))
                                   (|:| |tan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|)))))
                                   (|:| |atan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|))))))))
                                T)
                              '((|mrv_cmp|
                                 ((|Union|
                                   (|Record| (|:| |sign| (|Integer|))
                                             (|:| |coeff|
                                                  (|Expression| (|Integer|))))
                                   #3#)
                                  (|Kernel| (|Expression| (|Integer|)))
                                  (|Kernel| (|Expression| (|Integer|)))
                                  (|Symbol|)
                                  (|Record|
                                   (|:| |tan_syms| (|List| (|Symbol|)))
                                   (|:| |atan_syms| (|List| (|Symbol|)))
                                   (|:| |tan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|)))))
                                   (|:| |atan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|))))))))
                                T)
                              '((|mrv_set|
                                 ((|Union|
                                   (|Record|
                                    (|:| |lk|
                                         (|List|
                                          (|Kernel|
                                           (|Expression| (|Integer|)))))
                                    (|:| |lc|
                                         (|List| (|Expression| (|Integer|)))))
                                   #4#)
                                  (|Expression| (|Integer|)) (|Symbol|)
                                  (|Record|
                                   (|:| |tan_syms| (|List| (|Symbol|)))
                                   (|:| |atan_syms| (|List| (|Symbol|)))
                                   (|:| |tan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|)))))
                                   (|:| |atan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|))))))))
                                T)
                              '((|expr_to_series|
                                 ((|Union|
                                   (|Record|
                                    (|:| |degree| (|OrderedExpression|))
                                    (|:| |coeff| (|Expression| (|Integer|))))
                                   #2#)
                                  (|Expression| (|Integer|))
                                  (|Kernel| (|Expression| (|Integer|)))
                                  (|Record|
                                   (|:| |tan_syms| (|List| (|Symbol|)))
                                   (|:| |atan_syms| (|List| (|Symbol|)))
                                   (|:| |tan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|)))))
                                   (|:| |atan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|))))))))
                                T)
                              '((|mrv_rewrite|
                                 ((|Union|
                                   (|Record|
                                    (|:| |degree| (|OrderedExpression|))
                                    (|:| |coeff| (|Expression| (|Integer|))))
                                   #2#)
                                  (|Expression| (|Integer|))
                                  (|List|
                                   (|Kernel| (|Expression| (|Integer|))))
                                  (|List| (|Expression| (|Integer|)))
                                  (|Symbol|)
                                  (|Record|
                                   (|:| |tan_syms| (|List| (|Symbol|)))
                                   (|:| |atan_syms| (|List| (|Symbol|)))
                                   (|:| |tan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|)))))
                                   (|:| |atan_kers|
                                        (|List|
                                         (|Kernel|
                                          (|Expression| (|Integer|))))))))
                                T)
                              '((|mrv_rewrite0|
                                 ((|Expression| (|Integer|))
                                  (|Expression| (|Integer|))
                                  (|List|
                                   (|Kernel| (|Expression| (|Integer|))))
                                  (|List| (|Expression| (|Integer|)))
                                  (|Expression| (|Integer|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 162
                                            '(0 6 0 7 0 9 0 10 1 13 12 9 14 1 6
                                              12 12 15 1 6 20 0 21 1 6 0 22 23
                                              2 6 0 0 9 24 2 6 25 0 0 26 1 27 6
                                              6 28 2 6 25 0 0 29 1 30 12 0 31 1
                                              30 32 0 33 3 6 0 0 20 34 35 2 32
                                              25 0 0 36 2 6 0 12 34 37 1 12 9 0
                                              38 0 6 0 39 2 32 6 0 40 41 1 6 0
                                              9 45 1 6 20 0 46 2 47 30 0 40 48
                                              3 32 6 0 40 6 49 1 51 50 0 52 0 6
                                              0 53 1 6 0 40 54 2 6 0 0 0 55 1 6
                                              0 0 56 2 6 0 0 0 57 1 6 0 0 58 2
                                              6 0 12 0 59 1 6 0 0 60 2 6 0 0 0
                                              61 1 6 0 0 62 2 6 0 0 63 64 1 68
                                              6 0 69 1 6 71 0 72 1 6 71 0 73 2
                                              47 25 30 0 74 2 76 75 0 30 77 1 6
                                              0 71 78 1 80 79 6 81 2 40 25 0 0
                                              82 3 6 0 0 22 0 83 1 6 84 0 85 2
                                              84 0 0 0 86 2 47 0 0 0 87 2 84 0
                                              0 0 88 1 84 25 0 89 1 47 75 0 90
                                              0 75 0 91 2 75 25 0 0 92 1 47 30
                                              0 93 2 75 25 0 0 94 0 75 0 95 2
                                              30 25 0 9 96 8 70 98 6 25 99 25 6
                                              100 100 100 101 1 67 68 0 102 2
                                              67 0 0 68 103 1 67 6 0 104 0 66 0
                                              105 0 66 0 106 1 67 107 0 108 1
                                              110 109 107 111 1 67 0 0 112 1 51
                                              0 6 116 2 51 25 0 0 117 1 51 25 0
                                              118 1 51 6 0 119 2 6 0 0 0 126 0
                                              51 0 129 2 84 25 9 0 130 0 68 0
                                              132 2 68 25 0 0 133 2 68 25 0 0
                                              134 2 68 25 0 0 135 0 51 0 136 1
                                              138 51 0 139 1 51 140 0 141 1 6
                                              142 0 143 1 138 51 0 144 1 6 22 0
                                              149 1 6 0 0 150 2 6 0 0 0 151 2
                                              42 25 0 0 152 3 6 0 0 20 34 153 1
                                              30 0 9 154 1 155 6 0 156 1 155 6
                                              0 157 1 161 40 158 162 3 0 79 6 9
                                              43 131 3 0 124 6 9 43 125 4 0 6 6
                                              47 32 6 127 5 0 114 6 47 32 9 43
                                              128 3 0 6 6 9 43 65 2 0 42 6 9
                                              137 2 0 146 6 138 148 3 0 42 6
                                              155 158 160 3 0 146 6 9 51 147 4
                                              0 42 6 9 6 158 159 3 0 42 6 9 43
                                              44 4 0 121 30 30 9 43 122 3 0 114
                                              6 30 43 115)))))
           '|lookupComplete|)) 

(MAKEPROP '|MrvLimitPackage| 'NILADIC T) 

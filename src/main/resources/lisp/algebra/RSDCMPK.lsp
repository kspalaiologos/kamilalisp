
(SDEFUN |RSDCMPK;KrullNumber;LLNni;1|
        ((|lp| (|List| P)) (|lts| (|List| TS)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|n| (|NonNegativeInteger|)) (|ln| (|List| (|NonNegativeInteger|)))
          (#1=#:G749 NIL) (|ts| NIL) (#2=#:G748 NIL))
         (SEQ
          (LETT |ln|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |ts| NIL) (LETT #1# |lts|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |ts| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |ts| (QREFELT $ 12)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (LETT |n|
                 (+ (LENGTH |lp|)
                    (SPADCALL (ELT $ 13) |ln| (QREFELT $ 16)))))))) 

(SDEFUN |RSDCMPK;numberOfVariables;LLNni;2|
        ((|lp| (|List| P)) (|lts| (|List| TS)) ($ (|NonNegativeInteger|)))
        (SPROG ((|lv| (|List| V)) (#1=#:G762 NIL) (|ts| NIL))
               (SEQ
                (LETT |lv|
                      (SPADCALL (SPADCALL |lp| (QREFELT $ 21)) (QREFELT $ 23)))
                (SEQ (LETT |ts| NIL) (LETT #1# |lts|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |ts| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |lv|
                             (SPADCALL (SPADCALL |ts| (QREFELT $ 24)) |lv|
                                       (QREFELT $ 25)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT (LENGTH (SPADCALL |lv| (QREFELT $ 26))))))) 

(SDEFUN |RSDCMPK;algebraicDecompose;PTSBR;3|
        ((|p| (P)) (|ts| (TS)) (|clos?| (|Boolean|))
         ($
          (|Record| (|:| |done| (|List| TS))
                    (|:| |todo|
                         (|List|
                          (|Record| (|:| |val| (|List| P))
                                    (|:| |tower| TS)))))))
        (SPROG
         ((|llpwt| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (#1=#:G790 NIL) (|vs| NIL) (#2=#:G789 NIL) (|f| NIL)
          (|lus| (|List| TS)) (|lsfp| (|List| P)) (|b| (|Boolean|)) (|h| (P))
          (|lts| (|List| TS)) (|us| (TS)) (|g| (P)) (#3=#:G788 NIL) (|gwt| NIL)
          (|lgwt| (|List| (|Record| (|:| |val| P) (|:| |tower| TS))))
          (|ts_v| (P)) (#4=#:G765 NIL) (|ts_v+| (TS)) (|ts_v-| (TS)) (|v| (V)))
         (SEQ
          (COND
           ((SPADCALL |p| (QREFELT $ 29))
            (|error| " in algebraicDecompose$REGSET: should never happen !"))
           (#5='T
            (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 30)))
                 (LETT |ts_v-| (SPADCALL |ts| |v| (QREFELT $ 31)))
                 (LETT |ts_v+| (SPADCALL |ts| |v| (QREFELT $ 32)))
                 (LETT |ts_v|
                       (PROG2 (LETT #4# (SPADCALL |ts| |v| (QREFELT $ 34)))
                           (QCDR #4#)
                         (|check_union2| (QEQCAR #4# 0) (QREFELT $ 9)
                                         (|Union| (QREFELT $ 9) "failed")
                                         #4#)))
                 (COND
                  ((< (SPADCALL |p| (QREFELT $ 35))
                      (SPADCALL |ts_v| (QREFELT $ 35)))
                   (LETT |lgwt|
                         (SPADCALL |ts_v| |p| |ts_v-| 'T NIL (QREFELT $ 39))))
                  (#5#
                   (LETT |lgwt|
                         (SPADCALL |p| |ts_v| |ts_v-| 'T NIL (QREFELT $ 39)))))
                 (LETT |lts| NIL) (LETT |llpwt| NIL)
                 (SEQ (LETT |gwt| NIL) (LETT #3# |lgwt|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |gwt| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ (LETT |g| (QCAR |gwt|)) (LETT |us| (QCDR |gwt|))
                           (EXIT
                            (COND
                             ((SPADCALL |g| (QREFELT $ 40))
                              (|error|
                               " in algebraicDecompose$REGSET: should never happen !!"))
                             ((SPADCALL |g| (QREFELT $ 29)) "leave")
                             ('T
                              (SEQ
                               (COND
                                ((SPADCALL (SPADCALL |g| (QREFELT $ 30)) |v|
                                           (QREFELT $ 41))
                                 (LETT |lts|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |ts_v+| (QREFELT $ 42))
                                         (SPADCALL |g| |us| (QREFELT $ 44))
                                         (QREFELT $ 45))
                                        |lts| (QREFELT $ 46)))))
                               (LETT |h| (SPADCALL |g| |v| (QREFELT $ 47)))
                               (LETT |b| (SPADCALL |us| (QREFELT $ 48)))
                               (LETT |lsfp| (SPADCALL |h| (QREFELT $ 50)))
                               (LETT |lus|
                                     (SPADCALL
                                      (SPADCALL |ts_v+| (QREFELT $ 42))
                                      (SPADCALL |ts_v| |us| (QREFELT $ 44))
                                      (QREFELT $ 45)))
                               (EXIT
                                (SEQ (LETT |f| NIL) (LETT #2# |lsfp|) G190
                                     (COND
                                      ((OR (ATOM #2#)
                                           (PROGN (LETT |f| (CAR #2#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((SPADCALL |f| (QREFELT $ 29)) "leave")
                                        ('T
                                         (SEQ
                                          (COND
                                           (|b|
                                            (COND
                                             ((SPADCALL |f| |us|
                                                        (QREFELT $ 51))
                                              (EXIT "leave")))))
                                          (EXIT
                                           (SEQ (LETT |vs| NIL)
                                                (LETT #1# |lus|) G190
                                                (COND
                                                 ((OR (ATOM #1#)
                                                      (PROGN
                                                       (LETT |vs| (CAR #1#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT |llpwt|
                                                        (CONS
                                                         (CONS (LIST |f| |p|)
                                                               |vs|)
                                                         |llpwt|))))
                                                (LETT #1# (CDR #1#)) (GO G190)
                                                G191 (EXIT NIL))))))))
                                     (LETT #2# (CDR #2#)) (GO G190) G191
                                     (EXIT NIL))))))))
                      (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                 (EXIT (CONS |lts| |llpwt|)))))))) 

(SDEFUN |RSDCMPK;transcendentalDecompose;PTSNniR;4|
        ((|p| (P)) (|ts| (TS)) (|bound| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |done| (|List| TS))
                    (|:| |todo|
                         (|List|
                          (|Record| (|:| |val| (|List| P))
                                    (|:| |tower| TS)))))))
        (SPROG
         ((|llpwt| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|lts| (|List| TS)))
         (SEQ
          (COND
           ((< (SPADCALL |ts| (QREFELT $ 12)) |bound|)
            (LETT |lts| (SPADCALL |p| |ts| (QREFELT $ 44))))
           ('T (LETT |lts| NIL)))
          (LETT |llpwt| NIL) (EXIT (CONS |lts| |llpwt|))))) 

(SDEFUN |RSDCMPK;transcendentalDecompose;PTSR;5|
        ((|p| (P)) (|ts| (TS))
         ($
          (|Record| (|:| |done| (|List| TS))
                    (|:| |todo|
                         (|List|
                          (|Record| (|:| |val| (|List| P))
                                    (|:| |tower| TS)))))))
        (SPROG
         ((|llpwt| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|lts| (|List| TS)))
         (SEQ (LETT |lts| (SPADCALL |p| |ts| (QREFELT $ 44)))
              (LETT |llpwt| NIL) (EXIT (CONS |lts| |llpwt|))))) 

(SDEFUN |RSDCMPK;internalDecompose;PTSNniBR;6|
        ((|p| (P)) (|ts| (TS)) (|bound| (|NonNegativeInteger|))
         (|clos?| (|Boolean|))
         ($
          (|Record| (|:| |done| (|List| TS))
                    (|:| |todo|
                         (|List|
                          (|Record| (|:| |val| (|List| P))
                                    (|:| |tower| TS)))))))
        (COND (|clos?| (SPADCALL |p| |ts| |bound| (QREFELT $ 57)))
              ('T (SPADCALL |p| |ts| (QREFELT $ 58))))) 

(SDEFUN |RSDCMPK;internalDecompose;PTSNniR;7|
        ((|p| (P)) (|ts| (TS)) (|bound| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |done| (|List| TS))
                    (|:| |todo|
                         (|List|
                          (|Record| (|:| |val| (|List| P))
                                    (|:| |tower| TS)))))))
        (SPROG
         ((|llpwt| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|lts| (|List| TS)) (|riv| (P))
          (|rsl|
           (|Record| (|:| |done| (|List| TS))
                     (|:| |todo|
                          (|List|
                           (|Record| (|:| |val| (|List| P))
                                     (|:| |tower| TS))))))
          (#1=#:G826 NIL) (|bwt| NIL)
          (|lbwt| (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (|tp| (P)) (|ip| (P)) (#2=#:G805 NIL) (|lmp| (P)))
         (SEQ (LETT |llpwt| NIL) (LETT |lts| NIL)
              (COND
               ((NULL (SPADCALL (SPADCALL |p| (QREFELT $ 60)) (QREFELT $ 40)))
                (COND
                 ((NULL
                   (SPADCALL (LETT |lmp| (SPADCALL |p| (QREFELT $ 61)))
                             (QREFELT $ 29)))
                  (SEQ
                   (LETT |llpwt|
                         (CONS
                          (CONS
                           (LIST
                            (SPADCALL (SPADCALL |p| (QREFELT $ 30))
                                      (QREFELT $ 62)))
                           |ts|)
                          |llpwt|))
                   (EXIT
                    (LETT |p|
                          (PROG2 (LETT #2# (SPADCALL |p| |lmp| (QREFELT $ 64)))
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 0) (QREFELT $ 9)
                                            (|Union| (QREFELT $ 9) "failed")
                                            #2#)))))))))
              (LETT |ip|
                    (SPADCALL (SPADCALL |p| (QREFELT $ 65)) (QREFELT $ 66)))
              (LETT |tp| (SPADCALL |p| (QREFELT $ 60)))
              (LETT |p| (SPADCALL |p| (QREFELT $ 67)))
              (LETT |lbwt| (SPADCALL |ip| |ts| (QREFELT $ 70)))
              (SEQ (LETT |bwt| NIL) (LETT #1# |lbwt|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |bwt| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((QCAR |bwt|)
                       (SEQ
                        (COND
                         ((SPADCALL (SPADCALL |p| (QREFELT $ 30)) (QCDR |bwt|)
                                    (QREFELT $ 71))
                          (LETT |rsl|
                                (SPADCALL |p| (QCDR |bwt|) 'T (QREFELT $ 54))))
                         ('T
                          (LETT |rsl|
                                (SPADCALL |p| (QCDR |bwt|) |bound|
                                          (QREFELT $ 55)))))
                        (LETT |lts|
                              (SPADCALL (QCAR |rsl|) |lts| (QREFELT $ 46)))
                        (LETT |llpwt|
                              (SPADCALL (QCDR |rsl|) |llpwt| (QREFELT $ 73)))
                        (COND
                         ((SPADCALL |ip| (QCDR |bwt|) (QREFELT $ 51))
                          (COND
                           ((SPADCALL (QCDR |bwt|) (QREFELT $ 48))
                            (EXIT "leave")))))
                        (EXIT
                         (COND
                          ((NULL (SPADCALL |ip| (QREFELT $ 29)))
                           (COND
                            ((SPADCALL |tp| (QREFELT $ 40))
                             (LETT |llpwt|
                                   (CONS (CONS (LIST |ip|) (QCDR |bwt|))
                                         |llpwt|)))
                            ((NULL (SPADCALL |tp| (QREFELT $ 29)))
                             (LETT |llpwt|
                                   (CONS (CONS (LIST |ip| |tp|) (QCDR |bwt|))
                                         |llpwt|)))))))))
                      ('T
                       (SEQ
                        (LETT |riv|
                              (SPADCALL |ip| (QCDR |bwt|) (QREFELT $ 74)))
                        (EXIT
                         (COND
                          ((SPADCALL |riv| (QREFELT $ 40))
                           (COND
                            ((SPADCALL |tp| (QREFELT $ 40))
                             (LETT |lts| (CONS (QCDR |bwt|) |lts|)))
                            ((NULL (SPADCALL |tp| (QREFELT $ 29)))
                             (LETT |llpwt|
                                   (CONS (CONS (LIST |tp|) (QCDR |bwt|))
                                         |llpwt|)))))
                          ('T
                           (LETT |llpwt|
                                 (CONS
                                  (CONS
                                   (LIST
                                    (SPADCALL
                                     (SPADCALL |riv|
                                               (SPADCALL |p| (QREFELT $ 75))
                                               (QREFELT $ 76))
                                     |tp| (QREFELT $ 77)))
                                   (QCDR |bwt|))
                                  |llpwt|))))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |lts| |llpwt|))))) 

(SDEFUN |RSDCMPK;internalDecompose;PTSR;8|
        ((|p| (P)) (|ts| (TS))
         ($
          (|Record| (|:| |done| (|List| TS))
                    (|:| |todo|
                         (|List|
                          (|Record| (|:| |val| (|List| P))
                                    (|:| |tower| TS)))))))
        (SPROG
         ((|llpwt| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|lts| (|List| TS)) (|riv| (P))
          (|rsl|
           (|Record| (|:| |done| (|List| TS))
                     (|:| |todo|
                          (|List|
                           (|Record| (|:| |val| (|List| P))
                                     (|:| |tower| TS))))))
          (#1=#:G850 NIL) (|bwt| NIL)
          (|lbwt| (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (|tp| (P)) (|ip| (P)) (#2=#:G830 NIL) (|lmp| (P)))
         (SEQ (LETT |llpwt| NIL) (LETT |lts| NIL)
              (COND
               ((NULL (SPADCALL (SPADCALL |p| (QREFELT $ 60)) (QREFELT $ 40)))
                (COND
                 ((NULL
                   (SPADCALL (LETT |lmp| (SPADCALL |p| (QREFELT $ 61)))
                             (QREFELT $ 29)))
                  (SEQ
                   (LETT |llpwt|
                         (CONS
                          (CONS
                           (LIST
                            (SPADCALL (SPADCALL |p| (QREFELT $ 30))
                                      (QREFELT $ 62)))
                           |ts|)
                          |llpwt|))
                   (EXIT
                    (LETT |p|
                          (PROG2 (LETT #2# (SPADCALL |p| |lmp| (QREFELT $ 64)))
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 0) (QREFELT $ 9)
                                            (|Union| (QREFELT $ 9) "failed")
                                            #2#)))))))))
              (LETT |ip|
                    (SPADCALL (SPADCALL |p| (QREFELT $ 65)) (QREFELT $ 66)))
              (LETT |tp| (SPADCALL |p| (QREFELT $ 60)))
              (LETT |p| (SPADCALL |p| (QREFELT $ 67)))
              (LETT |lbwt| (SPADCALL |ip| |ts| (QREFELT $ 70)))
              (SEQ (LETT |bwt| NIL) (LETT #1# |lbwt|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |bwt| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((QCAR |bwt|)
                       (SEQ
                        (COND
                         ((SPADCALL (SPADCALL |p| (QREFELT $ 30)) (QCDR |bwt|)
                                    (QREFELT $ 71))
                          (LETT |rsl|
                                (SPADCALL |p| (QCDR |bwt|) NIL
                                          (QREFELT $ 54))))
                         ('T
                          (LETT |rsl|
                                (SPADCALL |p| (QCDR |bwt|) (QREFELT $ 56)))))
                        (LETT |lts|
                              (SPADCALL (QCAR |rsl|) |lts| (QREFELT $ 46)))
                        (LETT |llpwt|
                              (SPADCALL (QCDR |rsl|) |llpwt| (QREFELT $ 73)))
                        (COND
                         ((SPADCALL |ip| (QCDR |bwt|) (QREFELT $ 51))
                          (COND
                           ((SPADCALL (QCDR |bwt|) (QREFELT $ 48))
                            (EXIT "leave")))))
                        (EXIT
                         (COND
                          ((NULL (SPADCALL |ip| (QREFELT $ 29)))
                           (COND
                            ((SPADCALL |tp| (QREFELT $ 40))
                             (LETT |llpwt|
                                   (CONS (CONS (LIST |ip|) (QCDR |bwt|))
                                         |llpwt|)))
                            ((NULL (SPADCALL |tp| (QREFELT $ 29)))
                             (LETT |llpwt|
                                   (CONS (CONS (LIST |ip| |tp|) (QCDR |bwt|))
                                         |llpwt|)))))))))
                      ('T
                       (SEQ
                        (LETT |riv|
                              (SPADCALL |ip| (QCDR |bwt|) (QREFELT $ 74)))
                        (EXIT
                         (COND
                          ((SPADCALL |riv| (QREFELT $ 40))
                           (COND
                            ((SPADCALL |tp| (QREFELT $ 40))
                             (LETT |lts| (CONS (QCDR |bwt|) |lts|)))
                            ((NULL (SPADCALL |tp| (QREFELT $ 29)))
                             (LETT |llpwt|
                                   (CONS (CONS (LIST |tp|) (QCDR |bwt|))
                                         |llpwt|)))))
                          ('T
                           (LETT |llpwt|
                                 (CONS
                                  (CONS
                                   (LIST
                                    (SPADCALL
                                     (SPADCALL |riv|
                                               (SPADCALL |p| (QREFELT $ 75))
                                               (QREFELT $ 76))
                                     |tp| (QREFELT $ 77)))
                                   (QCDR |bwt|))
                                  |llpwt|))))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |lts| |llpwt|))))) 

(SDEFUN |RSDCMPK;decompose;LL2BL;9|
        ((|lp| (|List| P)) (|lts| (|List| TS)) (|clos?| (|Boolean|))
         (|info?| (|Boolean|)) ($ (|List| TS)))
        (SPADCALL |lp| |lts| NIL NIL |clos?| 'T |info?| (QREFELT $ 78))) 

(SDEFUN |RSDCMPK;convert;RS;10|
        ((|lpwt| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))
         ($ (|String|)))
        (SPROG ((|ls| (|List| (|String|))))
               (SEQ
                (LETT |ls|
                      (LIST "<" (STRINGIMAGE (LENGTH (QCAR |lpwt|))) ","
                            (STRINGIMAGE
                             (SPADCALL (QCDR |lpwt|) (QREFELT $ 12)))
                            ">"))
                (EXIT (SPADCALL |ls| (QREFELT $ 81)))))) 

(SDEFUN |RSDCMPK;printInfo;LNniV;11|
        ((|toSee| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
         (|n| (|NonNegativeInteger|)) ($ (|Void|)))
        (SPROG
         ((|s| (|String|)) (|m| (|NonNegativeInteger|)) (#1=#:G864 NIL)
          (|lpwt| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
         (SEQ (LETT |lpwt| (|SPADfirst| |toSee|))
              (LETT |s|
                    (SPADCALL
                     (LIST "[" (STRINGIMAGE (LENGTH |toSee|)) " "
                           (SPADCALL |lpwt| (QREFELT $ 82)))
                     (QREFELT $ 81)))
              (LETT |m| (LENGTH (QCAR |lpwt|))) (LETT |toSee| (CDR |toSee|))
              (SEQ (LETT #1# |toSee|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |lpwt| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |m| (+ |m| (LENGTH (QCAR |lpwt|))))
                        (EXIT
                         (LETT |s|
                               (SPADCALL
                                (LIST |s| "," (SPADCALL |lpwt| (QREFELT $ 82)))
                                (QREFELT $ 81)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |s|
                    (SPADCALL
                     (LIST |s| " -> |" (STRINGIMAGE |m|) "|; {"
                           (STRINGIMAGE |n|) "}]")
                     (QREFELT $ 81)))
              (SPADCALL |s| (QREFELT $ 85)) (EXIT (SPADCALL (QREFELT $ 86)))))) 

(SDEFUN |RSDCMPK;decompose;LL5BL;12|
        ((|lp| (|List| P)) (|lts| (|List| TS)) (|cleanW?| (|Boolean|))
         (|sqfr?| (|Boolean|)) (|clos?| (|Boolean|)) (|rem?| (|Boolean|))
         (|info?| (|Boolean|)) ($ (|List| TS)))
        (SPROG
         ((|toSee| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|rsl|
           (|Record| (|:| |done| (|List| TS))
                     (|:| |todo|
                          (|List|
                           (|Record| (|:| |val| (|List| P))
                                     (|:| |tower| TS))))))
          (|p| (P)) (|toSave| (|List| TS)) (|ts| (TS))
          (|lpwt| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))
          (|bound| (|NonNegativeInteger|)) (#1=#:G885 NIL) (|br| NIL)
          (#2=#:G884 NIL)
          (|branches|
           (|List|
            (|Record| (|:| |eq| (|List| P)) (|:| |tower| TS)
                      (|:| |ineq| (|List| P))))))
         (SEQ
          (COND ((NULL |lp|) |lts|)
                (#3='T
                 (SEQ
                  (LETT |branches|
                        (SPADCALL |lp| |lts| |cleanW?| |sqfr?| (QREFELT $ 91)))
                  (EXIT
                   (COND ((NULL |branches|) NIL)
                         (#3#
                          (SEQ
                           (LETT |toSee|
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |br| NIL) (LETT #1# |branches|)
                                       G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |br| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS
                                                (CONS (QVELT |br| 0)
                                                      (QVELT |br| 1))
                                                #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#)))))
                           (LETT |toSave| NIL)
                           (COND
                            (|clos?|
                             (LETT |bound|
                                   (SPADCALL |lp| |lts| (QREFELT $ 19))))
                            (#3#
                             (LETT |bound|
                                   (SPADCALL |lp| |lts| (QREFELT $ 27)))))
                           (SEQ G190
                                (COND ((NULL (NULL (NULL |toSee|))) (GO G191)))
                                (SEQ
                                 (COND
                                  (|info?|
                                   (SPADCALL |toSee| (LENGTH |toSave|)
                                             (QREFELT $ 87))))
                                 (LETT |lpwt| (|SPADfirst| |toSee|))
                                 (LETT |toSee| (CDR |toSee|))
                                 (LETT |lp| (QCAR |lpwt|))
                                 (LETT |ts| (QCDR |lpwt|))
                                 (EXIT
                                  (COND
                                   ((NULL |lp|)
                                    (LETT |toSave| (CONS |ts| |toSave|)))
                                   ('T
                                    (SEQ (LETT |p| (|SPADfirst| |lp|))
                                         (LETT |lp| (CDR |lp|))
                                         (COND
                                          (|rem?|
                                           (COND
                                            ((NULL
                                              (SPADCALL |p| (QREFELT $ 29)))
                                             (COND
                                              ((NULL
                                                (SPADCALL |ts| (QREFELT $ 92)))
                                               (LETT |p|
                                                     (QVELT
                                                      (SPADCALL |p| |ts|
                                                                (QREFELT $ 94))
                                                      1))))))))
                                         (LETT |p|
                                               (SPADCALL |p| |ts|
                                                         (QREFELT $ 74)))
                                         (EXIT
                                          (COND
                                           ((SPADCALL |p| (QREFELT $ 40))
                                            (LETT |toSee|
                                                  (CONS (CONS |lp| |ts|)
                                                        |toSee|)))
                                           ((SPADCALL |p| (QREFELT $ 29))
                                            "leave")
                                           ('T
                                            (SEQ
                                             (LETT |rsl|
                                                   (SPADCALL |p| |ts| |bound|
                                                             |clos?|
                                                             (QREFELT $ 59)))
                                             (EXIT
                                              (LETT |toSee|
                                                    (SPADCALL |lp| |toSave|
                                                              |toSee| |rsl|
                                                              |bound|
                                                              (QREFELT $
                                                                       95)))))))))))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT (SPADCALL |toSave| (QREFELT $ 96))))))))))))) 

(SDEFUN |RSDCMPK;upDateBranches;LLLRNniL;13|
        ((|leq| (|List| P)) (|lts| (|List| TS))
         (|current|
          (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
         (|wip|
          (|Record| (|:| |done| (|List| TS))
                    (|:| |todo|
                         (|List|
                          (|Record| (|:| |val| (|List| P))
                                    (|:| |tower| TS))))))
         (|n| (|NonNegativeInteger|))
         ($ (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))))
        (SPROG
         ((|branches|
           (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|branches2|
           (|List| #1=(|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (#2=#:G903 NIL) (|branches1| (|List| #1#)) (|newleq| (|List| P))
          (|us| (TS)) (#3=#:G902 NIL) (|branch| NIL)
          (|newComponents| (|List| TS))
          (|newBranches|
           (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))))
         (SEQ (LETT |newBranches| (QCDR |wip|))
              (LETT |newComponents| (QCAR |wip|)) (LETT |branches1| NIL)
              (LETT |branches2| NIL)
              (SEQ (LETT |branch| NIL) (LETT #3# |newBranches|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |branch| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |us| (QCDR |branch|))
                        (EXIT
                         (COND ((> (SPADCALL |us| (QREFELT $ 12)) |n|) "leave")
                               ('T
                                (SEQ
                                 (LETT |newleq|
                                       (SPADCALL (ELT $ 97)
                                                 (SPADCALL |leq|
                                                           (QCAR |branch|)
                                                           (QREFELT $ 98))
                                                 (QREFELT $ 100)))
                                 (EXIT
                                  (LETT |branches1|
                                        (CONS (CONS |newleq| |us|)
                                              |branches1|))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT #2# |newComponents|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |us| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((OR (> (SPADCALL |us| (QREFELT $ 12)) |n|)
                           (SPADCALL |us| |lts| (QREFELT $ 101)))
                       "leave")
                      ('T
                       (LETT |branches2|
                             (CONS (CONS |leq| |us|) |branches2|))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((NULL |branches1|)
                 (COND ((NULL |branches2|) |current|)
                       (#4='T
                        (SPADCALL |branches2| |current| (QREFELT $ 73)))))
                (#4#
                 (SEQ
                  (LETT |branches|
                        (SPADCALL (LIST |branches2| |branches1| |current|)
                                  (QREFELT $ 102)))
                  (EXIT (SPADCALL |branches| (QREFELT $ 103)))))))))) 

(DECLAIM (NOTINLINE |RegularSetDecompositionPackage;|)) 

(DEFUN |RegularSetDecompositionPackage| (&REST #1=#:G904)
  (SPROG NIL
         (PROG (#2=#:G905)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RegularSetDecompositionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |RegularSetDecompositionPackage;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|RegularSetDecompositionPackage|)))))))))) 

(DEFUN |RegularSetDecompositionPackage;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$|
          (LIST '|RegularSetDecompositionPackage| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 104))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|RegularSetDecompositionPackage|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|RegularSetDecompositionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|NonNegativeInteger|) (0 . |#|) (5 . |max|) (|Mapping| 11 11 11)
              (|List| 11) (11 . |reduce|) (|List| 9) (|List| 10)
              |RSDCMPK;KrullNumber;LLNni;1| (|GeneralPolynomialSet| 6 7 8 9)
              (17 . |construct|) (|List| 8) (22 . |variables|)
              (27 . |variables|) (32 . |concat|) (38 . |removeDuplicates|)
              |RSDCMPK;numberOfVariables;LLNni;2| (|Boolean|) (43 . |ground?|)
              (48 . |mvar|) (53 . |collectUnder|) (59 . |collectUpper|)
              (|Union| 9 '"failed") (65 . |select|) (71 . |mdeg|)
              (|Record| (|:| |val| 9) (|:| |tower| 10)) (|List| 36)
              (|RegularTriangularSetGcdPackage| 6 7 8 9 10)
              (76 . |internalLastSubResultant|) (85 . |zero?|) (90 . =)
              (96 . |members|) (|List| $) (101 . |augment|) (107 . |augment|)
              (113 . |concat|) (119 . |leadingCoefficient|)
              (125 . |purelyAlgebraic?|)
              (|PolynomialSetUtilitiesPackage| 6 7 8 9)
              (130 . |squareFreeFactors|) (135 . |purelyAlgebraic?|)
              (|Record| (|:| |val| 17) (|:| |tower| 10))
              (|Record| (|:| |done| 18) (|:| |todo| 72))
              |RSDCMPK;algebraicDecompose;PTSBR;3|
              |RSDCMPK;transcendentalDecompose;PTSNniR;4|
              |RSDCMPK;transcendentalDecompose;PTSR;5|
              |RSDCMPK;internalDecompose;PTSNniR;7|
              |RSDCMPK;internalDecompose;PTSR;8|
              |RSDCMPK;internalDecompose;PTSNniBR;6| (141 . |tail|)
              (146 . |leastMonomial|) (151 . |coerce|) (|Union| $ '"failed")
              (156 . |exquo|) (162 . |init|) (167 . |squareFreePart|)
              (172 . |mainPrimitivePart|)
              (|Record| (|:| |val| 28) (|:| |tower| $)) (|List| 68)
              (177 . |invertible?|) (183 . |algebraic?|) (|List| 52)
              (189 . |concat|) (195 . |removeZero|) (201 . |mainMonomial|)
              (206 . *) (212 . +) |RSDCMPK;decompose;LL5BL;12|
              |RSDCMPK;decompose;LL2BL;9| (|String|) (218 . |concat|)
              |RSDCMPK;convert;RS;10| (|Void|) (|InternalPrintPackage|)
              (223 . |iprint|) (228 . |void|) |RSDCMPK;printInfo;LNniV;11|
              (|Record| (|:| |eq| 17) (|:| |tower| 10) (|:| |ineq| 17))
              (|List| 88) (|QuasiComponentPackage| 6 7 8 9 10)
              (232 . |prepareDecompose|) (240 . |empty?|)
              (|Record| (|:| |rnum| 6) (|:| |polnum| 9) (|:| |den| 6))
              (245 . |remainder|) |RSDCMPK;upDateBranches;LLLRNniL;13|
              (251 . |removeSuperfluousQuasiComponents|) (256 . |infRittWu?|)
              (262 . |concat|) (|Mapping| 28 9 9) (268 . |sort|)
              (274 . |subQuasiComponent?|) (280 . |concat|)
              (285 . |removeSuperfluousCases|))
           '#(|upDateBranches| 290 |transcendentalDecompose| 299 |printInfo|
              312 |numberOfVariables| 318 |internalDecompose| 324 |decompose|
              345 |convert| 364 |algebraicDecompose| 369 |KrullNumber| 376)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|KrullNumber|
                                 ((|NonNegativeInteger|) (|List| |#4|)
                                  (|List| |#5|)))
                                T)
                              '((|numberOfVariables|
                                 ((|NonNegativeInteger|) (|List| |#4|)
                                  (|List| |#5|)))
                                T)
                              '((|algebraicDecompose|
                                 ((|Record| (|:| |done| (|List| |#5|))
                                            (|:| |todo|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |val| (|List| |#4|))
                                                   (|:| |tower| |#5|)))))
                                  |#4| |#5| (|Boolean|)))
                                T)
                              '((|transcendentalDecompose|
                                 ((|Record| (|:| |done| (|List| |#5|))
                                            (|:| |todo|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |val| (|List| |#4|))
                                                   (|:| |tower| |#5|)))))
                                  |#4| |#5| (|NonNegativeInteger|)))
                                T)
                              '((|transcendentalDecompose|
                                 ((|Record| (|:| |done| (|List| |#5|))
                                            (|:| |todo|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |val| (|List| |#4|))
                                                   (|:| |tower| |#5|)))))
                                  |#4| |#5|))
                                T)
                              '((|internalDecompose|
                                 ((|Record| (|:| |done| (|List| |#5|))
                                            (|:| |todo|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |val| (|List| |#4|))
                                                   (|:| |tower| |#5|)))))
                                  |#4| |#5| (|NonNegativeInteger|)
                                  (|Boolean|)))
                                T)
                              '((|internalDecompose|
                                 ((|Record| (|:| |done| (|List| |#5|))
                                            (|:| |todo|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |val| (|List| |#4|))
                                                   (|:| |tower| |#5|)))))
                                  |#4| |#5| (|NonNegativeInteger|)))
                                T)
                              '((|internalDecompose|
                                 ((|Record| (|:| |done| (|List| |#5|))
                                            (|:| |todo|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |val| (|List| |#4|))
                                                   (|:| |tower| |#5|)))))
                                  |#4| |#5|))
                                T)
                              '((|decompose|
                                 ((|List| |#5|) (|List| |#4|) (|List| |#5|)
                                  (|Boolean|) (|Boolean|)))
                                T)
                              '((|decompose|
                                 ((|List| |#5|) (|List| |#4|) (|List| |#5|)
                                  (|Boolean|) (|Boolean|) (|Boolean|)
                                  (|Boolean|) (|Boolean|)))
                                T)
                              '((|upDateBranches|
                                 ((|List|
                                   (|Record| (|:| |val| (|List| |#4|))
                                             (|:| |tower| |#5|)))
                                  (|List| |#4|) (|List| |#5|)
                                  (|List|
                                   (|Record| (|:| |val| (|List| |#4|))
                                             (|:| |tower| |#5|)))
                                  (|Record| (|:| |done| (|List| |#5|))
                                            (|:| |todo|
                                                 (|List|
                                                  (|Record|
                                                   (|:| |val| (|List| |#4|))
                                                   (|:| |tower| |#5|)))))
                                  (|NonNegativeInteger|)))
                                T)
                              '((|convert|
                                 ((|String|)
                                  (|Record| (|:| |val| (|List| |#4|))
                                            (|:| |tower| |#5|))))
                                T)
                              '((|printInfo|
                                 ((|Void|)
                                  (|List|
                                   (|Record| (|:| |val| (|List| |#4|))
                                             (|:| |tower| |#5|)))
                                  (|NonNegativeInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 103
                                            '(1 10 11 0 12 2 11 0 0 0 13 2 15
                                              11 14 0 16 1 20 0 17 21 1 20 22 0
                                              23 1 10 22 0 24 2 22 0 0 0 25 1
                                              22 0 0 26 1 9 28 0 29 1 9 8 0 30
                                              2 10 0 0 8 31 2 10 0 0 8 32 2 10
                                              33 0 8 34 1 9 11 0 35 5 38 37 9 9
                                              10 28 28 39 1 9 28 0 40 2 8 28 0
                                              0 41 1 10 17 0 42 2 10 43 9 0 44
                                              2 10 43 17 43 45 2 18 0 0 0 46 2
                                              9 0 0 8 47 1 10 28 0 48 1 49 17 9
                                              50 2 10 28 9 0 51 1 9 0 0 60 1 9
                                              0 0 61 1 9 0 8 62 2 9 63 0 0 64 1
                                              9 0 0 65 1 9 0 0 66 1 9 0 0 67 2
                                              10 69 9 0 70 2 10 28 8 0 71 2 72
                                              0 0 0 73 2 10 9 9 0 74 1 9 0 0 75
                                              2 9 0 0 0 76 2 9 0 0 0 77 1 80 0
                                              43 81 1 84 83 80 85 0 83 0 86 4
                                              90 89 17 18 28 28 91 1 10 28 0 92
                                              2 10 93 9 0 94 1 90 18 18 96 2 9
                                              28 0 0 97 2 17 0 0 0 98 2 17 0 99
                                              0 100 2 90 28 10 18 101 1 72 0 43
                                              102 1 90 72 72 103 5 0 72 17 18
                                              72 53 11 95 3 0 53 9 10 11 55 2 0
                                              53 9 10 56 2 0 83 72 11 87 2 0 11
                                              17 18 27 4 0 53 9 10 11 28 59 3 0
                                              53 9 10 11 57 2 0 53 9 10 58 4 0
                                              18 17 18 28 28 79 7 0 18 17 18 28
                                              28 28 28 28 78 1 0 80 52 82 3 0
                                              53 9 10 28 54 2 0 11 17 18
                                              19)))))
           '|lookupComplete|)) 

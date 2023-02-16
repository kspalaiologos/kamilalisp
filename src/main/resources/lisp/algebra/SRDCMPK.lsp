
(SDEFUN |SRDCMPK;KrullNumber;LLNni;1|
        ((|lp| (|List| P)) (|lts| (|List| TS)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|n| (|NonNegativeInteger|)) (|ln| (|List| (|NonNegativeInteger|)))
          (#1=#:G745 NIL) (|ts| NIL) (#2=#:G744 NIL))
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

(SDEFUN |SRDCMPK;numberOfVariables;LLNni;2|
        ((|lp| (|List| P)) (|lts| (|List| TS)) ($ (|NonNegativeInteger|)))
        (SPROG ((|lv| (|List| V)) (#1=#:G758 NIL) (|ts| NIL))
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

(SDEFUN |SRDCMPK;algebraicDecompose;PTSR;3|
        ((|p| (P)) (|ts| (TS))
         ($
          (|Record| (|:| |done| (|List| TS))
                    (|:| |todo|
                         (|List|
                          (|Record| (|:| |val| (|List| P))
                                    (|:| |tower| TS)))))))
        (SPROG
         ((#1=#:G782 NIL) (|lts| (|List| TS))
          (|llpwt| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (#2=#:G785 NIL) (|vs| NIL) (#3=#:G784 NIL) (|f| NIL)
          (|lsfp| (|List| P)) (|lus| (|List| TS)) (|h| (P)) (|us| (TS))
          (|g| (P)) (#4=#:G783 NIL) (|gwt| NIL)
          (|lgwt| (|List| (|Record| (|:| |val| P) (|:| |tower| TS))))
          (|ts_v| (P)) (#5=#:G761 NIL) (|ts_v+| (TS)) (|ts_v-| (TS))
          (|n| (|NonNegativeInteger|)) (|v| (V)))
         (SEQ
          (COND
           ((SPADCALL |p| (QREFELT $ 29))
            (|error| " in algebraicDecompose$REGSET: should never happen !"))
           (#6='T
            (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 30)))
                 (LETT |n| (SPADCALL |ts| (QREFELT $ 12)))
                 (LETT |ts_v-| (SPADCALL |ts| |v| (QREFELT $ 31)))
                 (LETT |ts_v+| (SPADCALL |ts| |v| (QREFELT $ 32)))
                 (LETT |ts_v|
                       (PROG2 (LETT #5# (SPADCALL |ts| |v| (QREFELT $ 34)))
                           (QCDR #5#)
                         (|check_union2| (QEQCAR #5# 0) (QREFELT $ 9)
                                         (|Union| (QREFELT $ 9) "failed")
                                         #5#)))
                 (COND
                  ((< (SPADCALL |p| (QREFELT $ 35))
                      (SPADCALL |ts_v| (QREFELT $ 35)))
                   (LETT |lgwt|
                         (SPADCALL |ts_v| |p| |ts_v-| 'T NIL (QREFELT $ 39))))
                  (#6#
                   (LETT |lgwt|
                         (SPADCALL |p| |ts_v| |ts_v-| 'T NIL (QREFELT $ 39)))))
                 (LETT |lts| NIL) (LETT |llpwt| NIL)
                 (SEQ (LETT |gwt| NIL) (LETT #4# |lgwt|) G190
                      (COND
                       ((OR (ATOM #4#) (PROGN (LETT |gwt| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ (LETT |g| (QCAR |gwt|)) (LETT |us| (QCDR |gwt|))
                           (EXIT
                            (COND
                             ((SPADCALL |g| (QREFELT $ 40))
                              (|error|
                               " in algebraicDecompose$REGSET: should never happen !!"))
                             ((SPADCALL |g| (QREFELT $ 29)) "leave")
                             ('T
                              (SEQ (LETT |h| (SPADCALL |g| |v| (QREFELT $ 41)))
                                   (LETT |lus|
                                         (SPADCALL
                                          (SPADCALL |ts_v+| (QREFELT $ 42))
                                          (SPADCALL |ts_v| |us| (QREFELT $ 44))
                                          (QREFELT $ 45)))
                                   (LETT |lsfp| (SPADCALL |h| (QREFELT $ 47)))
                                   (SEQ (LETT |f| NIL) (LETT #3# |lsfp|) G190
                                        (COND
                                         ((OR (ATOM #3#)
                                              (PROGN (LETT |f| (CAR #3#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((SPADCALL |f| (QREFELT $ 29))
                                            "leave")
                                           ('T
                                            (SEQ (LETT |vs| NIL)
                                                 (LETT #2# |lus|) G190
                                                 (COND
                                                  ((OR (ATOM #2#)
                                                       (PROGN
                                                        (LETT |vs| (CAR #2#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT |llpwt|
                                                         (CONS
                                                          (CONS (LIST |f| |p|)
                                                                |vs|)
                                                          |llpwt|))))
                                                 (LETT #2# (CDR #2#)) (GO G190)
                                                 G191 (EXIT NIL))))))
                                        (LETT #3# (CDR #3#)) (GO G190) G191
                                        (EXIT NIL))
                                   (EXIT
                                    (COND
                                     ((< |n| (SPADCALL |us| (QREFELT $ 12)))
                                      (|error|
                                       " in algebraicDecompose$REGSET: should never happen !!!"))
                                     ('T
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((SPADCALL
                                           (SPADCALL |g| (QREFELT $ 30)) |v|
                                           (QREFELT $ 48))
                                          (PROGN
                                           (LETT #1#
                                                 (LETT |lts|
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL |ts_v+|
                                                                   (QREFELT $
                                                                            42))
                                                         (SPADCALL |g| |us|
                                                                   (QREFELT $
                                                                            44))
                                                         (QREFELT $ 45))
                                                        |lts| (QREFELT $ 49))))
                                           (GO #7=#:G772)))))
                                       #7# (EXIT #1#))))))))))
                      (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                 (EXIT (CONS |lts| |llpwt|)))))))) 

(SDEFUN |SRDCMPK;transcendentalDecompose;PTSNniR;4|
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

(SDEFUN |SRDCMPK;transcendentalDecompose;PTSR;5|
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

(SDEFUN |SRDCMPK;internalDecompose;PTSNniBR;6|
        ((|p| (P)) (|ts| (TS)) (|bound| (|NonNegativeInteger|))
         (|clos?| (|Boolean|))
         ($
          (|Record| (|:| |done| (|List| TS))
                    (|:| |todo|
                         (|List|
                          (|Record| (|:| |val| (|List| P))
                                    (|:| |tower| TS)))))))
        (COND (|clos?| (SPADCALL |p| |ts| |bound| (QREFELT $ 55)))
              ('T (SPADCALL |p| |ts| (QREFELT $ 56))))) 

(SDEFUN |SRDCMPK;internalDecompose;PTSNniR;7|
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
          (#1=#:G819 NIL) (|bwt| NIL)
          (|lbwt| (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (|tp| (P)) (|ip| (P)) (#2=#:G800 NIL) (|lmp| (P)))
         (SEQ (LETT |llpwt| NIL) (LETT |lts| NIL)
              (COND
               ((NULL (SPADCALL (SPADCALL |p| (QREFELT $ 58)) (QREFELT $ 40)))
                (COND
                 ((NULL
                   (SPADCALL (LETT |lmp| (SPADCALL |p| (QREFELT $ 59)))
                             (QREFELT $ 29)))
                  (SEQ
                   (LETT |llpwt|
                         (CONS
                          (CONS
                           (LIST
                            (SPADCALL (SPADCALL |p| (QREFELT $ 30))
                                      (QREFELT $ 60)))
                           |ts|)
                          |llpwt|))
                   (EXIT
                    (LETT |p|
                          (PROG2 (LETT #2# (SPADCALL |p| |lmp| (QREFELT $ 62)))
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 0) (QREFELT $ 9)
                                            (|Union| (QREFELT $ 9) "failed")
                                            #2#)))))))))
              (LETT |ip|
                    (SPADCALL (SPADCALL |p| (QREFELT $ 63)) (QREFELT $ 64)))
              (LETT |tp| (SPADCALL |p| (QREFELT $ 58)))
              (LETT |p| (SPADCALL |p| (QREFELT $ 65)))
              (LETT |lbwt| (SPADCALL |ip| |ts| (QREFELT $ 68)))
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
                                    (QREFELT $ 69))
                          (LETT |rsl|
                                (SPADCALL |p| (QCDR |bwt|) (QREFELT $ 52))))
                         ('T
                          (LETT |rsl|
                                (SPADCALL |p| (QCDR |bwt|) |bound|
                                          (QREFELT $ 53)))))
                        (LETT |lts|
                              (SPADCALL (QCAR |rsl|) |lts| (QREFELT $ 49)))
                        (LETT |llpwt|
                              (SPADCALL (QCDR |rsl|) |llpwt| (QREFELT $ 71)))
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
                              (SPADCALL |ip| (QCDR |bwt|) (QREFELT $ 72)))
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
                                               (SPADCALL |p| (QREFELT $ 73))
                                               (QREFELT $ 74))
                                     |tp| (QREFELT $ 75)))
                                   (QCDR |bwt|))
                                  |llpwt|))))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |lts| |llpwt|))))) 

(SDEFUN |SRDCMPK;internalDecompose;PTSR;8|
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
          (#1=#:G841 NIL) (|bwt| NIL)
          (|lbwt| (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (|tp| (P)) (|ip| (P)) (#2=#:G823 NIL) (|lmp| (P)))
         (SEQ (LETT |llpwt| NIL) (LETT |lts| NIL)
              (COND
               ((NULL (SPADCALL (SPADCALL |p| (QREFELT $ 58)) (QREFELT $ 40)))
                (COND
                 ((NULL
                   (SPADCALL (LETT |lmp| (SPADCALL |p| (QREFELT $ 59)))
                             (QREFELT $ 29)))
                  (SEQ
                   (LETT |llpwt|
                         (CONS
                          (CONS
                           (LIST
                            (SPADCALL (SPADCALL |p| (QREFELT $ 30))
                                      (QREFELT $ 60)))
                           |ts|)
                          |llpwt|))
                   (EXIT
                    (LETT |p|
                          (PROG2 (LETT #2# (SPADCALL |p| |lmp| (QREFELT $ 62)))
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 0) (QREFELT $ 9)
                                            (|Union| (QREFELT $ 9) "failed")
                                            #2#)))))))))
              (LETT |ip|
                    (SPADCALL (SPADCALL |p| (QREFELT $ 63)) (QREFELT $ 64)))
              (LETT |tp| (SPADCALL |p| (QREFELT $ 58)))
              (LETT |p| (SPADCALL |p| (QREFELT $ 65)))
              (LETT |lbwt| (SPADCALL |ip| |ts| (QREFELT $ 68)))
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
                                    (QREFELT $ 69))
                          (LETT |rsl|
                                (SPADCALL |p| (QCDR |bwt|) (QREFELT $ 52))))
                         ('T
                          (LETT |rsl|
                                (SPADCALL |p| (QCDR |bwt|) (QREFELT $ 54)))))
                        (LETT |lts|
                              (SPADCALL (QCAR |rsl|) |lts| (QREFELT $ 49)))
                        (LETT |llpwt|
                              (SPADCALL (QCDR |rsl|) |llpwt| (QREFELT $ 71)))
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
                              (SPADCALL |ip| (QCDR |bwt|) (QREFELT $ 72)))
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
                                               (SPADCALL |p| (QREFELT $ 73))
                                               (QREFELT $ 74))
                                     |tp| (QREFELT $ 75)))
                                   (QCDR |bwt|))
                                  |llpwt|))))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |lts| |llpwt|))))) 

(SDEFUN |SRDCMPK;decompose;LL2BL;9|
        ((|lp| (|List| P)) (|lts| (|List| TS)) (|clos?| (|Boolean|))
         (|info?| (|Boolean|)) ($ (|List| TS)))
        (SPADCALL |lp| |lts| NIL NIL |clos?| 'T |info?| (QREFELT $ 76))) 

(SDEFUN |SRDCMPK;convert;RS;10|
        ((|lpwt| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))
         ($ (|String|)))
        (SPROG ((|ls| (|List| (|String|))))
               (SEQ
                (LETT |ls|
                      (LIST "<" (STRINGIMAGE (LENGTH (QCAR |lpwt|))) ","
                            (STRINGIMAGE
                             (SPADCALL (QCDR |lpwt|) (QREFELT $ 12)))
                            ">"))
                (EXIT (SPADCALL |ls| (QREFELT $ 79)))))) 

(SDEFUN |SRDCMPK;printInfo;LNniV;11|
        ((|toSee| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
         (|n| (|NonNegativeInteger|)) ($ (|Void|)))
        (SPROG
         ((|s| (|String|)) (|m| (|NonNegativeInteger|)) (#1=#:G855 NIL)
          (|lpwt| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
         (SEQ (LETT |lpwt| (|SPADfirst| |toSee|))
              (LETT |s|
                    (SPADCALL
                     (LIST "[" (STRINGIMAGE (LENGTH |toSee|)) " "
                           (SPADCALL |lpwt| (QREFELT $ 80)))
                     (QREFELT $ 79)))
              (LETT |m| (LENGTH (QCAR |lpwt|))) (LETT |toSee| (CDR |toSee|))
              (SEQ (LETT #1# |toSee|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |lpwt| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |m| (+ |m| (LENGTH (QCAR |lpwt|))))
                        (EXIT
                         (LETT |s|
                               (SPADCALL
                                (LIST |s| "," (SPADCALL |lpwt| (QREFELT $ 80)))
                                (QREFELT $ 79)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |s|
                    (SPADCALL
                     (LIST |s| " -> |" (STRINGIMAGE |m|) "|; {"
                           (STRINGIMAGE |n|) "}]")
                     (QREFELT $ 79)))
              (SPADCALL |s| (QREFELT $ 83)) (EXIT (SPADCALL (QREFELT $ 84)))))) 

(SDEFUN |SRDCMPK;decompose;LL5BL;12|
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
          (|bound| (|NonNegativeInteger|)) (#1=#:G876 NIL) (|br| NIL)
          (#2=#:G875 NIL)
          (|branches|
           (|List|
            (|Record| (|:| |eq| (|List| P)) (|:| |tower| TS)
                      (|:| |ineq| (|List| P))))))
         (SEQ
          (COND ((NULL |lp|) |lts|)
                (#3='T
                 (SEQ
                  (LETT |branches|
                        (SPADCALL |lp| |lts| |cleanW?| |sqfr?| (QREFELT $ 89)))
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
                                             (QREFELT $ 85))))
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
                                                (SPADCALL |ts| (QREFELT $ 90)))
                                               (LETT |p|
                                                     (QVELT
                                                      (SPADCALL |p| |ts|
                                                                (QREFELT $ 92))
                                                      1))))))))
                                         (LETT |p|
                                               (SPADCALL |p| |ts|
                                                         (QREFELT $ 72)))
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
                                                             (QREFELT $ 57)))
                                             (EXIT
                                              (LETT |toSee|
                                                    (SPADCALL |lp| |toSave|
                                                              |toSee| |rsl|
                                                              |bound|
                                                              (QREFELT $
                                                                       93)))))))))))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT (SPADCALL |toSave| (QREFELT $ 94))))))))))))) 

(SDEFUN |SRDCMPK;upDateBranches;LLLRNniL;13|
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
          (#2=#:G894 NIL) (|branches1| (|List| #1#)) (|newleq| (|List| P))
          (|us| (TS)) (#3=#:G893 NIL) (|branch| NIL)
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
                                       (SPADCALL (ELT $ 95)
                                                 (SPADCALL |leq|
                                                           (QCAR |branch|)
                                                           (QREFELT $ 96))
                                                 (QREFELT $ 98)))
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
                           (SPADCALL |us| |lts| (QREFELT $ 99)))
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
                        (SPADCALL |branches2| |current| (QREFELT $ 71)))))
                (#4#
                 (SEQ
                  (LETT |branches|
                        (SPADCALL (LIST |branches2| |branches1| |current|)
                                  (QREFELT $ 100)))
                  (EXIT (SPADCALL |branches| (QREFELT $ 101)))))))))) 

(DECLAIM (NOTINLINE |SquareFreeRegularSetDecompositionPackage;|)) 

(DEFUN |SquareFreeRegularSetDecompositionPackage| (&REST #1=#:G895)
  (SPROG NIL
         (PROG (#2=#:G896)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SquareFreeRegularSetDecompositionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |SquareFreeRegularSetDecompositionPackage;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SquareFreeRegularSetDecompositionPackage|)))))))))) 

(DEFUN |SquareFreeRegularSetDecompositionPackage;| (|#1| |#2| |#3| |#4| |#5|)
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
          (LIST '|SquareFreeRegularSetDecompositionPackage| DV$1 DV$2 DV$3 DV$4
                DV$5))
    (LETT $ (GETREFV 102))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|SquareFreeRegularSetDecompositionPackage|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|SquareFreeRegularSetDecompositionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|NonNegativeInteger|) (0 . |#|) (5 . |max|) (|Mapping| 11 11 11)
              (|List| 11) (11 . |reduce|) (|List| 9) (|List| 10)
              |SRDCMPK;KrullNumber;LLNni;1| (|GeneralPolynomialSet| 6 7 8 9)
              (17 . |construct|) (|List| 8) (22 . |variables|)
              (27 . |variables|) (32 . |concat|) (38 . |removeDuplicates|)
              |SRDCMPK;numberOfVariables;LLNni;2| (|Boolean|) (43 . |ground?|)
              (48 . |mvar|) (53 . |collectUnder|) (59 . |collectUpper|)
              (|Union| 9 '"failed") (65 . |select|) (71 . |mdeg|)
              (|Record| (|:| |val| 9) (|:| |tower| 10)) (|List| 36)
              (|SquareFreeRegularTriangularSetGcdPackage| 6 7 8 9 10)
              (76 . |stoseInternalLastSubResultant|) (85 . |zero?|)
              (90 . |leadingCoefficient|) (96 . |members|) (|List| $)
              (101 . |augment|) (107 . |augment|)
              (|PolynomialSetUtilitiesPackage| 6 7 8 9)
              (113 . |squareFreeFactors|) (118 . =) (124 . |concat|)
              (|Record| (|:| |val| 17) (|:| |tower| 10))
              (|Record| (|:| |done| 18) (|:| |todo| 70))
              |SRDCMPK;algebraicDecompose;PTSR;3|
              |SRDCMPK;transcendentalDecompose;PTSNniR;4|
              |SRDCMPK;transcendentalDecompose;PTSR;5|
              |SRDCMPK;internalDecompose;PTSNniR;7|
              |SRDCMPK;internalDecompose;PTSR;8|
              |SRDCMPK;internalDecompose;PTSNniBR;6| (130 . |tail|)
              (135 . |leastMonomial|) (140 . |coerce|) (|Union| $ '"failed")
              (145 . |exquo|) (151 . |init|) (156 . |squareFreePart|)
              (161 . |mainPrimitivePart|)
              (|Record| (|:| |val| 28) (|:| |tower| 10)) (|List| 66)
              (166 . |stoseInvertible?_sqfreg|) (172 . |algebraic?|)
              (|List| 50) (178 . |concat|) (184 . |removeZero|)
              (190 . |mainMonomial|) (195 . *) (201 . +)
              |SRDCMPK;decompose;LL5BL;12| |SRDCMPK;decompose;LL2BL;9|
              (|String|) (207 . |concat|) |SRDCMPK;convert;RS;10| (|Void|)
              (|InternalPrintPackage|) (212 . |iprint|) (217 . |void|)
              |SRDCMPK;printInfo;LNniV;11|
              (|Record| (|:| |eq| 17) (|:| |tower| 10) (|:| |ineq| 17))
              (|List| 86) (|SquareFreeQuasiComponentPackage| 6 7 8 9 10)
              (221 . |prepareDecompose|) (229 . |empty?|)
              (|Record| (|:| |rnum| 6) (|:| |polnum| 9) (|:| |den| 6))
              (234 . |remainder|) |SRDCMPK;upDateBranches;LLLRNniL;13|
              (240 . |removeSuperfluousQuasiComponents|) (245 . |infRittWu?|)
              (251 . |concat|) (|Mapping| 28 9 9) (257 . |sort|)
              (263 . |subQuasiComponent?|) (269 . |concat|)
              (274 . |removeSuperfluousCases|))
           '#(|upDateBranches| 279 |transcendentalDecompose| 288 |printInfo|
              301 |numberOfVariables| 307 |internalDecompose| 313 |decompose|
              334 |convert| 353 |algebraicDecompose| 358 |KrullNumber| 364)
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
                                  |#4| |#5|))
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
                        (|makeByteWordVec2| 101
                                            '(1 10 11 0 12 2 11 0 0 0 13 2 15
                                              11 14 0 16 1 20 0 17 21 1 20 22 0
                                              23 1 10 22 0 24 2 22 0 0 0 25 1
                                              22 0 0 26 1 9 28 0 29 1 9 8 0 30
                                              2 10 0 0 8 31 2 10 0 0 8 32 2 10
                                              33 0 8 34 1 9 11 0 35 5 38 37 9 9
                                              10 28 28 39 1 9 28 0 40 2 9 0 0 8
                                              41 1 10 17 0 42 2 10 43 9 0 44 2
                                              10 43 17 43 45 1 46 17 9 47 2 8
                                              28 0 0 48 2 18 0 0 0 49 1 9 0 0
                                              58 1 9 0 0 59 1 9 0 8 60 2 9 61 0
                                              0 62 1 9 0 0 63 1 9 0 0 64 1 9 0
                                              0 65 2 38 67 9 10 68 2 10 28 8 0
                                              69 2 70 0 0 0 71 2 10 9 9 0 72 1
                                              9 0 0 73 2 9 0 0 0 74 2 9 0 0 0
                                              75 1 78 0 43 79 1 82 81 78 83 0
                                              81 0 84 4 88 87 17 18 28 28 89 1
                                              10 28 0 90 2 10 91 9 0 92 1 88 18
                                              18 94 2 9 28 0 0 95 2 17 0 0 0 96
                                              2 17 0 97 0 98 2 88 28 10 18 99 1
                                              70 0 43 100 1 88 70 70 101 5 0 70
                                              17 18 70 51 11 93 3 0 51 9 10 11
                                              53 2 0 51 9 10 54 2 0 81 70 11 85
                                              2 0 11 17 18 27 4 0 51 9 10 11 28
                                              57 3 0 51 9 10 11 55 2 0 51 9 10
                                              56 4 0 18 17 18 28 28 77 7 0 18
                                              17 18 28 28 28 28 28 76 1 0 78 50
                                              80 2 0 51 9 10 52 2 0 11 17 18
                                              19)))))
           '|lookupComplete|)) 


(SDEFUN |RSETGCD;startTableGcd!;3SV;1|
        ((|ok| (|String|)) (|ko| (|String|)) (|domainName| (|String|))
         ($ (|Void|)))
        (SEQ (SPADCALL (QREFELT $ 15)) (SPADCALL |ok| |ko| (QREFELT $ 17))
             (SPADCALL |domainName| (QREFELT $ 18))
             (EXIT (SPADCALL (QREFELT $ 19))))) 

(SDEFUN |RSETGCD;stopTableGcd!;V;2| (($ (|Void|)))
        (SEQ (COND ((SPADCALL (QREFELT $ 22)) (SPADCALL (QREFELT $ 23))))
             (EXIT (SPADCALL (QREFELT $ 24))))) 

(SDEFUN |RSETGCD;startTableInvSet!;3SV;3|
        ((|ok| (|String|)) (|ko| (|String|)) (|domainName| (|String|))
         ($ (|Void|)))
        (SEQ (SPADCALL (QREFELT $ 28)) (SPADCALL |ok| |ko| (QREFELT $ 29))
             (SPADCALL |domainName| (QREFELT $ 30))
             (EXIT (SPADCALL (QREFELT $ 19))))) 

(SDEFUN |RSETGCD;stopTableInvSet!;V;4| (($ (|Void|)))
        (SEQ (COND ((SPADCALL (QREFELT $ 32)) (SPADCALL (QREFELT $ 33))))
             (EXIT (SPADCALL (QREFELT $ 34))))) 

(SDEFUN |RSETGCD;toseInvertible?;PTSB;5|
        ((|p| (P)) (|ts| (TS)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G775 NIL) (#2=#:G777 NIL) (|g| (P)) (#3=#:G779 NIL) (|gwt| NIL)
          (|lgwt| (|List| (|Record| (|:| |val| P) (|:| |tower| TS))))
          (|ts_v-| (TS)) (|ts_v| (P)) (#4=#:G764 NIL) (#5=#:G776 NIL)
          (#6=#:G778 NIL) (|bwt| NIL)
          (|toCheck|
           (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (|v| (V)) (|q| (P)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |q|
                  (SPADCALL (SPADCALL |p| |ts| (QREFELT $ 36)) (QREFELT $ 37)))
            (EXIT
             (COND ((SPADCALL |q| (QREFELT $ 38)) NIL)
                   ((SPADCALL |q| |ts| (QREFELT $ 39)) 'T)
                   ('T
                    (SEQ (LETT |v| (SPADCALL |q| (QREFELT $ 40)))
                         (COND
                          ((NULL (SPADCALL |v| |ts| (QREFELT $ 41)))
                           (EXIT
                            (SEQ
                             (LETT |toCheck|
                                   (SPADCALL |p| |ts| (QREFELT $ 44)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |bwt| NIL) (LETT #6# |toCheck|) G190
                                    (COND
                                     ((OR (ATOM #6#)
                                          (PROGN (LETT |bwt| (CAR #6#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((|BooleanEquality| (QCAR |bwt|) NIL)
                                        (PROGN
                                         (LETT #5#
                                               (PROGN
                                                (LETT #2# NIL)
                                                (GO #7=#:G774)))
                                         (GO #8=#:G760))))))
                                    (LETT #6# (CDR #6#)) (GO G190) G191
                                    (EXIT NIL)))
                              #8# (EXIT #5#))
                             (EXIT (PROGN (LETT #2# 'T) (GO #7#)))))))
                         (LETT |ts_v|
                               (PROG2
                                   (LETT #4#
                                         (SPADCALL |ts| |v| (QREFELT $ 46)))
                                   (QCDR #4#)
                                 (|check_union2| (QEQCAR #4# 0) (QREFELT $ 9)
                                                 (|Union| (QREFELT $ 9)
                                                          "failed")
                                                 #4#)))
                         (LETT |ts_v-| (SPADCALL |ts| |v| (QREFELT $ 47)))
                         (LETT |lgwt|
                               (SPADCALL |ts_v| |q| |ts_v-| NIL 'T
                                         (QREFELT $ 49)))
                         (SEQ (LETT |gwt| NIL) (LETT #3# |lgwt|) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |gwt| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (SEQ (LETT |g| (QCAR |gwt|))
                                     (EXIT
                                      (COND
                                       ((NULL (SPADCALL |g| (QREFELT $ 50)))
                                        (COND
                                         ((SPADCALL
                                           (SPADCALL |g| (QREFELT $ 40)) |v|
                                           (QREFELT $ 51))
                                          (PROGN
                                           (LETT #1#
                                                 (PROGN
                                                  (LETT #2# NIL)
                                                  (GO #7#)))
                                           (GO #9=#:G769)))))))))
                               #9# (EXIT #1#))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                         (EXIT 'T)))))))
          #7# (EXIT #2#)))) 

(SDEFUN |RSETGCD;toseInvertible?;PTSL;6|
        ((|p| (P)) (|ts| (TS))
         ($ (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS)))))
        (SPROG
         ((|lbwt| (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (#1=#:G826 NIL) (|bwt| NIL) (#2=#:G825 NIL)
          (|inv|
           #3=(|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (|ts_h| (TS)) (|h| (P)) (|ts_g| (TS)) (|g| (P)) (#4=#:G824 NIL)
          (|gwt| NIL)
          (|lgwt| (|List| (|Record| (|:| |val| P) (|:| |tower| TS))))
          (|ts_v+| (TS)) (|ts_v-| (TS)) (|ts_v| (P)) (#5=#:G799 NIL)
          (#6=#:G822 NIL) (|newq| (P)) (#7=#:G823 NIL) (|toCheck| #3#)
          (|v| (V)) (|q| (P)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |q|
                  (SPADCALL (SPADCALL |p| |ts| (QREFELT $ 36)) (QREFELT $ 37)))
            (EXIT
             (COND ((SPADCALL |q| (QREFELT $ 38)) (LIST (CONS NIL |ts|)))
                   ((SPADCALL |q| |ts| (QREFELT $ 39)) (LIST (CONS 'T |ts|)))
                   ('T
                    (SEQ (LETT |v| (SPADCALL |q| (QREFELT $ 40)))
                         (COND
                          ((NULL (SPADCALL |v| |ts| (QREFELT $ 41)))
                           (EXIT
                            (SEQ (LETT |lbwt| NIL)
                                 (LETT |toCheck|
                                       (SPADCALL (SPADCALL |q| (QREFELT $ 53))
                                                 |ts| (QREFELT $ 44)))
                                 (SEQ (LETT |bwt| NIL) (LETT #7# |toCheck|)
                                      G190
                                      (COND
                                       ((OR (ATOM #7#)
                                            (PROGN (LETT |bwt| (CAR #7#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((QCAR |bwt|)
                                          (LETT |lbwt| (CONS |bwt| |lbwt|)))
                                         ('T
                                          (SEQ
                                           (LETT |newq|
                                                 (SPADCALL |q| (QCDR |bwt|)
                                                           (QREFELT $ 54)))
                                           (EXIT
                                            (COND
                                             ((SPADCALL |newq| (QREFELT $ 38))
                                              (LETT |lbwt|
                                                    (CONS |bwt| |lbwt|)))
                                             ('T
                                              (LETT |lbwt|
                                                    (SPADCALL
                                                     (SPADCALL |newq|
                                                               (QCDR |bwt|)
                                                               (QREFELT $ 44))
                                                     |lbwt|
                                                     (QREFELT $ 55)))))))))))
                                      (LETT #7# (CDR #7#)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT
                                  (PROGN (LETT #6# |lbwt|) (GO #8=#:G821)))))))
                         (LETT |ts_v|
                               (PROG2
                                   (LETT #5#
                                         (SPADCALL |ts| |v| (QREFELT $ 46)))
                                   (QCDR #5#)
                                 (|check_union2| (QEQCAR #5# 0) (QREFELT $ 9)
                                                 (|Union| (QREFELT $ 9)
                                                          "failed")
                                                 #5#)))
                         (LETT |ts_v-| (SPADCALL |ts| |v| (QREFELT $ 47)))
                         (LETT |ts_v+| (SPADCALL |ts| |v| (QREFELT $ 56)))
                         (LETT |lgwt|
                               (SPADCALL |ts_v| |q| |ts_v-| NIL NIL
                                         (QREFELT $ 49)))
                         (LETT |lbwt| NIL)
                         (SEQ (LETT |gwt| NIL) (LETT #4# |lgwt|) G190
                              (COND
                               ((OR (ATOM #4#)
                                    (PROGN (LETT |gwt| (CAR #4#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |g| (QCAR |gwt|))
                                   (LETT |ts| (QCDR |gwt|))
                                   (COND
                                    ((OR (SPADCALL |g| (QREFELT $ 50))
                                         (SPADCALL
                                          (SPADCALL |g| (QREFELT $ 40)) |v|
                                          (QREFELT $ 61)))
                                     (EXIT
                                      (SEQ
                                       (LETT |ts|
                                             (SPADCALL |ts_v| |ts|
                                                       (QREFELT $ 57)))
                                       (LETT |ts|
                                             (SPADCALL
                                              (SPADCALL |ts_v+| (QREFELT $ 59))
                                              |ts| (QREFELT $ 60)))
                                       (EXIT
                                        (LETT |lbwt|
                                              (CONS (CONS 'T |ts|)
                                                    |lbwt|)))))))
                                   (LETT |g| (SPADCALL |g| (QREFELT $ 62)))
                                   (LETT |ts_g|
                                         (SPADCALL |g| |ts| (QREFELT $ 57)))
                                   (LETT |ts_g|
                                         (SPADCALL
                                          (SPADCALL |ts_v+| (QREFELT $ 59))
                                          |ts_g| (QREFELT $ 60)))
                                   (LETT |lbwt|
                                         (CONS (CONS NIL |ts_g|) |lbwt|))
                                   (LETT |h|
                                         (SPADCALL |ts_v| |g| (QREFELT $ 63)))
                                   (COND
                                    ((OR (SPADCALL |h| (QREFELT $ 50))
                                         (SPADCALL
                                          (SPADCALL |h| (QREFELT $ 40)) |v|
                                          (QREFELT $ 61)))
                                     (EXIT "leave")))
                                   (LETT |h| (SPADCALL |h| (QREFELT $ 62)))
                                   (LETT |ts_h|
                                         (SPADCALL |h| |ts| (QREFELT $ 57)))
                                   (LETT |ts_h|
                                         (SPADCALL
                                          (SPADCALL |ts_v+| (QREFELT $ 59))
                                          |ts_h| (QREFELT $ 60)))
                                   (LETT |inv|
                                         (SPADCALL |q| |ts_h| (QREFELT $ 44)))
                                   (EXIT
                                    (LETT |lbwt|
                                          (SPADCALL
                                           (PROGN
                                            (LETT #2# NIL)
                                            (SEQ (LETT |bwt| NIL)
                                                 (LETT #1# |inv|) G190
                                                 (COND
                                                  ((OR (ATOM #1#)
                                                       (PROGN
                                                        (LETT |bwt| (CAR #1#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (COND
                                                    ((QCAR |bwt|)
                                                     (LETT #2#
                                                           (CONS |bwt|
                                                                 #2#))))))
                                                 (LETT #1# (CDR #1#)) (GO G190)
                                                 G191 (EXIT (NREVERSE #2#))))
                                           |lbwt| (QREFELT $ 55)))))
                              (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                         (EXIT
                          (SPADCALL
                           (CONS #'|RSETGCD;toseInvertible?;PTSL;6!0| $) |lbwt|
                           (QREFELT $ 66)))))))))
          #8# (EXIT #6#)))) 

(SDEFUN |RSETGCD;toseInvertible?;PTSL;6!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 64))) 

(SDEFUN |RSETGCD;toseInvertibleSet;PTSL;7|
        ((|p| (P)) (|ts| (TS)) ($ (|List| TS)))
        (SPROG
         ((|toSave| (|List| TS)) (|inv| (|List| TS)) (|ts_h| (TS)) (|h| (P))
          (|g| (P)) (#1=#:G858 NIL) (|gwt| NIL)
          (|lgwt| (|List| (|Record| (|:| |val| P) (|:| |tower| TS))))
          (|ts_v+| (TS)) (|ts_v-| (TS)) (|ts_v| (P)) (#2=#:G839 NIL)
          (#3=#:G856 NIL) (|newq| (P)) (#4=#:G857 NIL) (|bwt| NIL)
          (|toCheck|
           (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (|v| (V)) (|q| (P)) (|e| (|Union| (|List| TS) "failed"))
          (|k| (|Record| (|:| |arg1| P) (|:| |arg3| TS))))
         (SEQ
          (EXIT
           (SEQ (LETT |k| (CONS |p| |ts|))
                (LETT |e| (SPADCALL |k| (QREFELT $ 68)))
                (EXIT
                 (COND ((QEQCAR |e| 0) (QCDR |e|))
                       (#5='T
                        (SEQ
                         (LETT |q|
                               (SPADCALL (SPADCALL |p| |ts| (QREFELT $ 36))
                                         (QREFELT $ 37)))
                         (EXIT
                          (COND ((SPADCALL |q| (QREFELT $ 38)) NIL)
                                ((SPADCALL |q| |ts| (QREFELT $ 39))
                                 (LIST |ts|))
                                (#5#
                                 (SEQ (LETT |v| (SPADCALL |q| (QREFELT $ 40)))
                                      (LETT |toSave| NIL)
                                      (COND
                                       ((NULL
                                         (SPADCALL |v| |ts| (QREFELT $ 41)))
                                        (EXIT
                                         (SEQ
                                          (LETT |toCheck|
                                                (SPADCALL
                                                 (SPADCALL |q| (QREFELT $ 53))
                                                 |ts| (QREFELT $ 44)))
                                          (SEQ (LETT |bwt| NIL)
                                               (LETT #4# |toCheck|) G190
                                               (COND
                                                ((OR (ATOM #4#)
                                                     (PROGN
                                                      (LETT |bwt| (CAR #4#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (COND
                                                  ((QCAR |bwt|)
                                                   (LETT |toSave|
                                                         (CONS (QCDR |bwt|)
                                                               |toSave|)))
                                                  ('T
                                                   (SEQ
                                                    (LETT |newq|
                                                          (SPADCALL |q|
                                                                    (QCDR
                                                                     |bwt|)
                                                                    (QREFELT $
                                                                             54)))
                                                    (EXIT
                                                     (COND
                                                      ((SPADCALL |newq|
                                                                 (QREFELT $
                                                                          38))
                                                       "leave")
                                                      ('T
                                                       (LETT |toSave|
                                                             (SPADCALL
                                                              (SPADCALL |newq|
                                                                        (QCDR
                                                                         |bwt|)
                                                                        (QREFELT
                                                                         $ 70))
                                                              |toSave|
                                                              (QREFELT $
                                                                       71)))))))))))
                                               (LETT #4# (CDR #4#)) (GO G190)
                                               G191 (EXIT NIL))
                                          (LETT |toSave|
                                                (SPADCALL |toSave|
                                                          (QREFELT $ 72)))
                                          (EXIT
                                           (PROGN
                                            (LETT #3#
                                                  (SPADCALL |toSave|
                                                            (QREFELT $ 74)))
                                            (GO #6=#:G855)))))))
                                      (LETT |ts_v|
                                            (PROG2
                                                (LETT #2#
                                                      (SPADCALL |ts| |v|
                                                                (QREFELT $
                                                                         46)))
                                                (QCDR #2#)
                                              (|check_union2| (QEQCAR #2# 0)
                                                              (QREFELT $ 9)
                                                              (|Union|
                                                               (QREFELT $ 9)
                                                               "failed")
                                                              #2#)))
                                      (LETT |ts_v-|
                                            (SPADCALL |ts| |v| (QREFELT $ 47)))
                                      (LETT |ts_v+|
                                            (SPADCALL |ts| |v| (QREFELT $ 56)))
                                      (LETT |lgwt|
                                            (SPADCALL |ts_v| |q| |ts_v-| NIL
                                                      NIL (QREFELT $ 49)))
                                      (SEQ (LETT |gwt| NIL) (LETT #1# |lgwt|)
                                           G190
                                           (COND
                                            ((OR (ATOM #1#)
                                                 (PROGN
                                                  (LETT |gwt| (CAR #1#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ (LETT |g| (QCAR |gwt|))
                                                (LETT |ts| (QCDR |gwt|))
                                                (COND
                                                 ((OR
                                                   (SPADCALL |g|
                                                             (QREFELT $ 50))
                                                   (SPADCALL
                                                    (SPADCALL |g|
                                                              (QREFELT $ 40))
                                                    |v| (QREFELT $ 61)))
                                                  (EXIT
                                                   (SEQ
                                                    (LETT |ts|
                                                          (SPADCALL |ts_v| |ts|
                                                                    (QREFELT $
                                                                             57)))
                                                    (LETT |ts|
                                                          (SPADCALL
                                                           (SPADCALL |ts_v+|
                                                                     (QREFELT $
                                                                              59))
                                                           |ts|
                                                           (QREFELT $ 60)))
                                                    (EXIT
                                                     (LETT |toSave|
                                                           (CONS |ts|
                                                                 |toSave|)))))))
                                                (LETT |g|
                                                      (SPADCALL |g|
                                                                (QREFELT $
                                                                         62)))
                                                (LETT |h|
                                                      (SPADCALL |ts_v| |g|
                                                                (QREFELT $
                                                                         63)))
                                                (LETT |h|
                                                      (SPADCALL |h|
                                                                (QREFELT $
                                                                         62)))
                                                (COND
                                                 ((OR
                                                   (SPADCALL |h|
                                                             (QREFELT $ 50))
                                                   (SPADCALL
                                                    (SPADCALL |h|
                                                              (QREFELT $ 40))
                                                    |v| (QREFELT $ 61)))
                                                  (EXIT "leave")))
                                                (LETT |ts_h|
                                                      (SPADCALL |h| |ts|
                                                                (QREFELT $
                                                                         57)))
                                                (LETT |ts_h|
                                                      (SPADCALL
                                                       (SPADCALL |ts_v+|
                                                                 (QREFELT $
                                                                          59))
                                                       |ts_h| (QREFELT $ 60)))
                                                (LETT |inv|
                                                      (SPADCALL |q| |ts_h|
                                                                (QREFELT $
                                                                         70)))
                                                (EXIT
                                                 (LETT |toSave|
                                                       (SPADCALL
                                                        (SPADCALL |inv|
                                                                  |toSave|
                                                                  (QREFELT $
                                                                           71))
                                                        (QREFELT $ 72)))))
                                           (LETT #1# (CDR #1#)) (GO G190) G191
                                           (EXIT NIL))
                                      (LETT |toSave|
                                            (SPADCALL |toSave| (QREFELT $ 74)))
                                      (SPADCALL |k| |toSave| (QREFELT $ 75))
                                      (EXIT |toSave|)))))))))))
          #6# (EXIT #3#)))) 

(SDEFUN |RSETGCD;toseSquareFreePart_wip|
        ((|p| (P)) (|ts| (TS))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))))
        (SPROG
         ((|lpwt| (|List| (|Record| (|:| |val| P) (|:| |tower| TS))))
          (|sfp| (P)) (|g| (P)) (|us| (TS)) (#1=#:G869 NIL) (|gwt| NIL)
          (|lgwt| (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))) (|q| (P))
          (|v| (V)))
         (SEQ
          (COND ((EQL (SPADCALL |p| (QREFELT $ 77)) 1) (LIST (CONS |p| |ts|)))
                ('T
                 (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 40)))
                      (LETT |q|
                            (SPADCALL (SPADCALL |p| |v| (QREFELT $ 79))
                                      (QREFELT $ 62)))
                      (LETT |lgwt|
                            (SPADCALL |p| |q| |ts| 'T NIL (QREFELT $ 49)))
                      (LETT |lpwt| NIL)
                      (SEQ (LETT |gwt| NIL) (LETT #1# |lgwt|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |gwt| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |g| (QCAR |gwt|))
                                (LETT |us| (QCDR |gwt|))
                                (COND
                                 ((OR (SPADCALL |g| (QREFELT $ 50))
                                      (SPADCALL (SPADCALL |g| (QREFELT $ 40))
                                                |v| (QREFELT $ 61)))
                                  (EXIT
                                   (LETT |lpwt|
                                         (CONS (CONS |p| |us|) |lpwt|)))))
                                (LETT |g| (SPADCALL |g| (QREFELT $ 62)))
                                (LETT |sfp| (SPADCALL |p| |g| (QREFELT $ 63)))
                                (LETT |sfp|
                                      (SPADCALL
                                       (SPADCALL |sfp| |us| (QREFELT $ 80))
                                       (QREFELT $ 62)))
                                (EXIT
                                 (LETT |lpwt|
                                       (CONS (CONS |sfp| |us|) |lpwt|))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |lpwt|))))))) 

(SDEFUN |RSETGCD;toseSquareFreePart_base|
        ((|p| (P)) (|ts| (TS))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))))
        (LIST (CONS |p| |ts|))) 

(SDEFUN |RSETGCD;toseSquareFreePart;PTSL;10|
        ((|p| (P)) (|ts| (TS))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))))
        (|RSETGCD;toseSquareFreePart_wip| |p| |ts| $)) 

(SDEFUN |RSETGCD;prepareSubResAlgo;2PTSL;11|
        ((|p1| (P)) (|p2| (P)) (|ts| (TS))
         ($ (|List| #1=(|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))))
        (SPROG
         ((|toSee| (|List| #1#))
          (|toSave|
           (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|newp2| (P)) (|s| (P)) (#2=#:G879 NIL) (|p3| (P)) (#3=#:G892 NIL)
          (|bwt| NIL)
          (|lbwt| (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (|lpwt| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))
          (|v| (V)))
         (SEQ (LETT |toSee| (LIST (CONS (LIST |p1| |p2|) |ts|)))
              (LETT |toSave| NIL) (LETT |v| (SPADCALL |p1| (QREFELT $ 40)))
              (SEQ G190 (COND ((NULL (NULL (NULL |toSee|))) (GO G191)))
                   (SEQ (LETT |lpwt| (|SPADfirst| |toSee|))
                        (LETT |toSee| (CDR |toSee|))
                        (LETT |p1| (SPADCALL (QCAR |lpwt|) 1 (QREFELT $ 83)))
                        (LETT |p2| (SPADCALL (QCAR |lpwt|) 2 (QREFELT $ 83)))
                        (LETT |ts| (QCDR |lpwt|))
                        (LETT |lbwt|
                              (SPADCALL (SPADCALL |p2| |v| (QREFELT $ 84)) |ts|
                                        (QREFELT $ 44)))
                        (EXIT
                         (SEQ (LETT |bwt| NIL) (LETT #3# |lbwt|) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |bwt| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (COND
                                ((|BooleanEquality| (QCAR |bwt|) 'T)
                                 (COND
                                  ((> (SPADCALL |p2| |v| (QREFELT $ 85)) 0)
                                   (EXIT
                                    (SEQ
                                     (LETT |p3|
                                           (SPADCALL |p1|
                                                     (SPADCALL |p2|
                                                               (QREFELT $ 86))
                                                     (QREFELT $ 87)))
                                     (LETT |s|
                                           (SPADCALL
                                            (SPADCALL |p2| (QREFELT $ 53))
                                            (PROG1
                                                (LETT #2#
                                                      (-
                                                       (SPADCALL |p1|
                                                                 (QREFELT $
                                                                          77))
                                                       (SPADCALL |p2|
                                                                 (QREFELT $
                                                                          77))))
                                              (|check_subtype2| (>= #2# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #2#))
                                            (QREFELT $ 88)))
                                     (EXIT
                                      (LETT |toSave|
                                            (CONS
                                             (CONS (LIST |p2| |p3| |s|)
                                                   (QCDR |bwt|))
                                             |toSave|)))))))))
                               (LETT |newp2|
                                     (SPADCALL
                                      (SPADCALL |p2| (QCDR |bwt|)
                                                (QREFELT $ 36))
                                      (QREFELT $ 37)))
                               (EXIT
                                (COND
                                 ((|BooleanEquality| (QCAR |bwt|) 'T)
                                  (LETT |toSave|
                                        (CONS
                                         (CONS
                                          (LIST |p2| (|spadConstant| $ 89)
                                                (|spadConstant| $ 90))
                                          (QCDR |bwt|))
                                         |toSave|)))
                                 ((SPADCALL |newp2| (QREFELT $ 38))
                                  (LETT |toSave|
                                        (CONS
                                         (CONS
                                          (LIST |p1| (|spadConstant| $ 89)
                                                (|spadConstant| $ 90))
                                          (QCDR |bwt|))
                                         |toSave|)))
                                 ('T
                                  (LETT |toSee|
                                        (CONS
                                         (CONS (LIST |p1| |newp2|)
                                               (QCDR |bwt|))
                                         |toSee|))))))
                              (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |toSave|)))) 

(SDEFUN |RSETGCD;integralLastSubResultant;2PTSL;12|
        ((|p1| (P)) (|p2| (P)) (|ts| (TS))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))))
        (SPROG ((|ex| (|Union| P "failed")) (|gi1i2| (P)) (|lsr| (P)))
               (SEQ (LETT |lsr| (SPADCALL |p1| |p2| (QREFELT $ 94)))
                    (EXIT
                     (COND
                      ((OR (SPADCALL |lsr| (QREFELT $ 50))
                           (SPADCALL (SPADCALL |lsr| (QREFELT $ 40))
                                     (SPADCALL |p1| (QREFELT $ 40))
                                     (QREFELT $ 61)))
                       (LIST (CONS |lsr| |ts|)))
                      ('T
                       (SEQ
                        (LETT |gi1i2|
                              (SPADCALL (SPADCALL |p1| (QREFELT $ 53))
                                        (SPADCALL |p2| (QREFELT $ 53))
                                        (QREFELT $ 95)))
                        (LETT |ex|
                              (SPADCALL (SPADCALL |gi1i2| |lsr| (QREFELT $ 96))
                                        (SPADCALL |lsr| (QREFELT $ 53))
                                        (QREFELT $ 98)))
                        (EXIT
                         (COND ((QEQCAR |ex| 1) (LIST (CONS |lsr| |ts|)))
                               ('T (LIST (CONS (QCDR |ex|) |ts|)))))))))))) 

(SDEFUN |RSETGCD;internalLastSubResultant;2PTS2BL;13|
        ((|p1| (P)) (|p2| (P)) (|ts| (TS)) (|b1| (|Boolean|))
         (|b2| (|Boolean|))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))))
        (SPROG
         ((|toSave| (|List| (|Record| (|:| |val| P) (|:| |tower| TS))))
          (|toSee| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|s| (P)) (#1=#:G907 NIL) (|p3| (P)) (#2=#:G913 NIL)
          (|e|
           (|Union| (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))
                    "failed"))
          (|k|
           (|Record| (|:| |arg1| P) (|:| |arg2| P) (|:| |arg3| TS)
                     (|:| |arg4| (|Boolean|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |k| (VECTOR |p1| |p2| |ts| |b2|))
                (LETT |e| (SPADCALL |k| (QREFELT $ 101)))
                (EXIT
                 (COND ((QEQCAR |e| 0) (QCDR |e|))
                       ((SPADCALL |ts| (QREFELT $ 102))
                        (SEQ
                         (LETT |toSave|
                               (SPADCALL |p1| |p2| |ts| (QREFELT $ 99)))
                         (SPADCALL |k| |toSave| (QREFELT $ 103))
                         (EXIT (PROGN (LETT #2# |toSave|) (GO #3=#:G912)))))
                       (#4='T
                        (SEQ
                         (COND
                          (|b1|
                           (SEQ
                            (LETT |p3|
                                  (SPADCALL |p1| (SPADCALL |p2| (QREFELT $ 86))
                                            (QREFELT $ 87)))
                            (LETT |s|
                                  (SPADCALL (SPADCALL |p2| (QREFELT $ 53))
                                            (PROG1
                                                (LETT #1#
                                                      (-
                                                       (SPADCALL |p1|
                                                                 (QREFELT $
                                                                          77))
                                                       (SPADCALL |p2|
                                                                 (QREFELT $
                                                                          77))))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 88)))
                            (EXIT
                             (LETT |toSee|
                                   (LIST (CONS (LIST |p2| |p3| |s|) |ts|))))))
                          (#4#
                           (LETT |toSee|
                                 (SPADCALL |p1| |p2| |ts| (QREFELT $ 93)))))
                         (LETT |toSave|
                               (SPADCALL |toSee| (SPADCALL |p1| (QREFELT $ 40))
                                         |b2| (QREFELT $ 104)))
                         (SPADCALL |k| |toSave| (QREFELT $ 103))
                         (EXIT |toSave|)))))))
          #3# (EXIT #2#)))) 

(SDEFUN |RSETGCD;internalLastSubResultant;LVBL;14|
        ((|llpwt| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
         (|v| (V)) (|b2| (|Boolean|))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))))
        (SPROG
         ((#1=#:G942 NIL) (|s| (P)) (|p2| (P)) (|p1| (P)) (|#G80| (P))
          (|#G79| (P))
          (|toReturn| (|List| (|Record| (|:| |val| P) (|:| |tower| TS))))
          (#2=#:G941 NIL) (|p3| (P)) (|delta| (|NonNegativeInteger|))
          (#3=#:G926 NIL)
          (|toSee| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|lpwt| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))
          (#4=#:G938 NIL) (#5=#:G940 NIL) (|bwt| NIL)
          (|lbwt| (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS))))
          (|ts| (TS)) (#6=#:G939 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |toReturn| NIL)
                (SEQ G190 (COND ((NULL (NULL (NULL |llpwt|))) (GO G191)))
                     (SEQ (LETT |toSee| |llpwt|) (LETT |llpwt| NIL)
                          (SEQ (LETT #6# |toSee|) G190
                               (COND
                                ((OR (ATOM #6#)
                                     (PROGN (LETT |lpwt| (CAR #6#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (LETT |p1|
                                      (SPADCALL (QCAR |lpwt|) 1
                                                (QREFELT $ 83)))
                                (LETT |p2|
                                      (SPADCALL (QCAR |lpwt|) 2
                                                (QREFELT $ 83)))
                                (LETT |s|
                                      (SPADCALL (QCAR |lpwt|) 3
                                                (QREFELT $ 83)))
                                (LETT |ts| (QCDR |lpwt|))
                                (LETT |lbwt|
                                      (SPADCALL
                                       (SPADCALL |p2| |v| (QREFELT $ 84)) |ts|
                                       (QREFELT $ 44)))
                                (EXIT
                                 (SEQ (LETT |bwt| NIL) (LETT #5# |lbwt|) G190
                                      (COND
                                       ((OR (ATOM #5#)
                                            (PROGN (LETT |bwt| (CAR #5#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((|BooleanEquality| (QCAR |bwt|) NIL)
                                          (SEQ
                                           (LETT |toReturn|
                                                 (CONS (CONS |p1| (QCDR |bwt|))
                                                       |toReturn|))
                                           (EXIT
                                            (COND
                                             (|b2|
                                              (COND
                                               ((PLUSP
                                                 (SPADCALL |p1| |v|
                                                           (QREFELT $ 85)))
                                                (PROGN
                                                 (LETT #4# |toReturn|)
                                                 (GO #7=#:G937)))))))))
                                         ('T
                                          (LETT |llpwt|
                                                (CONS
                                                 (CONS (LIST |p1| |p2| |s|)
                                                       (QCDR |bwt|))
                                                 |llpwt|))))))
                                      (LETT #5# (CDR #5#)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                          (EXIT
                           (COND ((NULL |llpwt|) "leave")
                                 ('T
                                  (SEQ (LETT |toSee| |llpwt|)
                                       (LETT |llpwt| NIL)
                                       (LETT |lpwt| (|SPADfirst| |toSee|))
                                       (LETT |toSee| (CDR |toSee|))
                                       (LETT |p1|
                                             (SPADCALL (QCAR |lpwt|) 1
                                                       (QREFELT $ 83)))
                                       (LETT |p2|
                                             (SPADCALL (QCAR |lpwt|) 2
                                                       (QREFELT $ 83)))
                                       (LETT |s|
                                             (SPADCALL (QCAR |lpwt|) 3
                                                       (QREFELT $ 83)))
                                       (LETT |delta|
                                             (PROG1
                                                 (LETT #3#
                                                       (-
                                                        (SPADCALL |p1|
                                                                  (QREFELT $
                                                                           77))
                                                        (SPADCALL |p2| |v|
                                                                  (QREFELT $
                                                                           85))))
                                               (|check_subtype2| (>= #3# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #3#)))
                                       (LETT |p3|
                                             (SPADCALL |p2|
                                                       (SPADCALL |p2| |v|
                                                                 (QREFELT $
                                                                          84))
                                                       |s| |delta|
                                                       (QREFELT $ 105)))
                                       (EXIT
                                        (COND
                                         ((ZEROP
                                           (SPADCALL |p3| |v| (QREFELT $ 85)))
                                          (SEQ
                                           (LETT |toReturn|
                                                 (CONS
                                                  (CONS |p3| (QCDR |lpwt|))
                                                  |toReturn|))
                                           (EXIT
                                            (SEQ (LETT #2# |toSee|) G190
                                                 (COND
                                                  ((OR (ATOM #2#)
                                                       (PROGN
                                                        (LETT |lpwt| (CAR #2#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT |toReturn|
                                                         (CONS
                                                          (CONS |p3|
                                                                (QCDR |lpwt|))
                                                          |toReturn|))))
                                                 (LETT #2# (CDR #2#)) (GO G190)
                                                 G191 (EXIT NIL)))))
                                         ('T
                                          (SEQ
                                           (PROGN
                                            (LETT |#G79| |p3|)
                                            (LETT |#G80|
                                                  (SPADCALL |p1| |p2| |p3| |s|
                                                            (QREFELT $ 106)))
                                            (LETT |p1| |#G79|)
                                            (LETT |p2| |#G80|))
                                           (LETT |s|
                                                 (SPADCALL |p1| |v|
                                                           (QREFELT $ 84)))
                                           (LETT |llpwt|
                                                 (CONS
                                                  (CONS (LIST |p1| |p2| |s|)
                                                        (QCDR |lpwt|))
                                                  |llpwt|))
                                           (EXIT
                                            (SEQ (LETT #1# |toSee|) G190
                                                 (COND
                                                  ((OR (ATOM #1#)
                                                       (PROGN
                                                        (LETT |lpwt| (CAR #1#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT |llpwt|
                                                         (CONS
                                                          (CONS
                                                           (LIST |p1| |p2| |s|)
                                                           (QCDR |lpwt|))
                                                          |llpwt|))))
                                                 (LETT #1# (CDR #1#)) (GO G190)
                                                 G191 (EXIT NIL))))))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT |toReturn|)))
          #7# (EXIT #4#)))) 

(SDEFUN |RSETGCD;toseLastSubResultant;2PTSL;15|
        ((|p1| (P)) (|p2| (P)) (|ts| (TS))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))))
        (SPROG ((|#G87| (P)) (|#G86| (P)))
               (SEQ
                (COND
                 ((SPADCALL |p1| (QREFELT $ 50))
                  (|error|
                   "in toseLastSubResultantElseSplit$TOSEGCD  : bad #1"))
                 ((OR (SPADCALL |p2| (QREFELT $ 50))
                      (NULL
                       (SPADCALL (SPADCALL |p2| (QREFELT $ 40))
                                 (SPADCALL |p1| (QREFELT $ 40))
                                 (QREFELT $ 51))))
                  (|error|
                   "in toseLastSubResultantElseSplit$TOSEGCD : bad #2"))
                 ((OR
                   (SPADCALL (SPADCALL |p1| (QREFELT $ 40)) |ts|
                             (QREFELT $ 41))
                   (NULL (SPADCALL |p1| |ts| (QREFELT $ 107))))
                  (|error|
                   "in toseLastSubResultantElseSplit$TOSEGCD : bad #1"))
                 ((NULL (SPADCALL |p2| |ts| (QREFELT $ 107)))
                  (|error|
                   "in toseLastSubResultantElseSplit$TOSEGCD : bad #2"))
                 ('T
                  (SEQ
                   (COND
                    ((SPADCALL |p1| |ts| (QREFELT $ 108))
                     (COND
                      ((SPADCALL |p2| |ts| (QREFELT $ 108))
                       (EXIT (SPADCALL |p1| |p2| |ts| (QREFELT $ 99)))))))
                   (COND
                    ((< (SPADCALL |p1| (QREFELT $ 77))
                        (SPADCALL |p2| (QREFELT $ 77)))
                     (SEQ
                      (PROGN
                       (LETT |#G86| |p2|)
                       (LETT |#G87| |p1|)
                       (LETT |p1| |#G86|)
                       (LETT |p2| |#G87|))
                      (EXIT
                       (COND
                        ((ODDP (SPADCALL |p1| (QREFELT $ 77)))
                         (COND
                          ((ODDP (SPADCALL |p2| (QREFELT $ 77)))
                           (LETT |p2| (SPADCALL |p2| (QREFELT $ 86)))))))))))
                   (EXIT (SPADCALL |p1| |p2| |ts| NIL NIL (QREFELT $ 49))))))))) 

(DECLAIM (NOTINLINE |RegularTriangularSetGcdPackage;|)) 

(DEFUN |RegularTriangularSetGcdPackage| (&REST #1=#:G956)
  (SPROG NIL
         (PROG (#2=#:G957)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RegularTriangularSetGcdPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |RegularTriangularSetGcdPackage;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|RegularTriangularSetGcdPackage|)))))))))) 

(DEFUN |RegularTriangularSetGcdPackage;| (|#1| |#2| |#3| |#4| |#5|)
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
          (LIST '|RegularTriangularSetGcdPackage| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 110))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|RegularTriangularSetGcdPackage|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|RegularTriangularSetGcdPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|Void|)
              (|Record| (|:| |arg1| 9) (|:| |arg2| 9) (|:| |arg3| 10)
                        (|:| |arg4| 21))
              (|Record| (|:| |val| 9) (|:| |tower| 10))
              (|TabulatedComputationPackage| 12 48) (0 . |initTable!|)
              (|String|) (4 . |printInfo!|) (10 . |startStats!|) (15 . |void|)
              |RSETGCD;startTableGcd!;3SV;1| (|Boolean|) (19 . |makingStats?|)
              (23 . |printStats!|) (27 . |clearTable!|)
              |RSETGCD;stopTableGcd!;V;2|
              (|Record| (|:| |arg1| 9) (|:| |arg3| 10))
              (|TabulatedComputationPackage| 26 69) (31 . |initTable!|)
              (35 . |printInfo!|) (41 . |startStats!|)
              |RSETGCD;startTableInvSet!;3SV;3| (46 . |makingStats?|)
              (50 . |printStats!|) (54 . |clearTable!|)
              |RSETGCD;stopTableInvSet!;V;4| (58 . |initiallyReduce|)
              (64 . |primitivePart|) (69 . |zero?|) (74 . |normalized?|)
              (80 . |mvar|) (85 . |algebraic?|)
              (|Record| (|:| |val| 21) (|:| |tower| 10)) (|List| 42)
              |RSETGCD;toseInvertible?;PTSL;6| (|Union| 9 '"failed")
              (91 . |select|) (97 . |collectUnder|) (|List| 13)
              |RSETGCD;internalLastSubResultant;2PTS2BL;13| (103 . |ground?|)
              (108 . =) |RSETGCD;toseInvertible?;PTSB;5| (114 . |init|)
              (119 . |removeZero|) (125 . |concat|) (131 . |collectUpper|)
              (137 . |internalAugment|) (|List| 9) (143 . |members|)
              (148 . |internalAugment|) (154 . <) (160 . |mainPrimitivePart|)
              (165 . |lazyPquo|) (171 . <) (|Mapping| 21 42 42) (177 . |sort|)
              (|Union| 69 '#1="failed") (183 . |extractIfCan|) (|List| 10)
              |RSETGCD;toseInvertibleSet;PTSL;7| (188 . |concat|)
              (194 . |removeDuplicates|) (|QuasiComponentPackage| 6 7 8 9 10)
              (199 . |algebraicSort|) (204 . |insert!|) (|NonNegativeInteger|)
              (210 . |mdeg|) (215 . |One|) (219 . D) (225 . |stronglyReduce|)
              |RSETGCD;toseSquareFreePart;PTSL;10| (|Integer|) (231 . |elt|)
              (237 . |leadingCoefficient|) (243 . |degree|) (249 . -)
              (254 . |prem|) (260 . ^) (266 . |Zero|) (270 . |One|)
              (|Record| (|:| |val| 58) (|:| |tower| 10)) (|List| 91)
              |RSETGCD;prepareSubResAlgo;2PTSL;11| (274 . |lastSubResultant|)
              (280 . |gcd|) (286 . *) (|Union| $ '"failed") (292 . |exquo|)
              |RSETGCD;integralLastSubResultant;2PTSL;12| (|Union| 48 '#1#)
              (298 . |extractIfCan|) (303 . |empty?|) (308 . |insert!|)
              |RSETGCD;internalLastSubResultant;LVBL;14|
              (314 . |LazardQuotient2|) (322 . |next_subResultant2|)
              (330 . |initiallyReduced?|) (336 . |purelyTranscendental?|)
              |RSETGCD;toseLastSubResultant;2PTSL;15|)
           '#(|toseSquareFreePart| 342 |toseLastSubResultant| 348
              |toseInvertibleSet| 355 |toseInvertible?| 361 |stopTableInvSet!|
              373 |stopTableGcd!| 377 |startTableInvSet!| 381 |startTableGcd!|
              388 |prepareSubResAlgo| 395 |internalLastSubResultant| 402
              |integralLastSubResultant| 418)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|startTableGcd!|
                                 ((|Void|) (|String|) (|String|) (|String|)))
                                T)
                              '((|stopTableGcd!| ((|Void|))) T)
                              '((|startTableInvSet!|
                                 ((|Void|) (|String|) (|String|) (|String|)))
                                T)
                              '((|stopTableInvSet!| ((|Void|))) T)
                              '((|prepareSubResAlgo|
                                 ((|List|
                                   (|Record| (|:| |val| (|List| |#4|))
                                             (|:| |tower| |#5|)))
                                  |#4| |#4| |#5|))
                                T)
                              '((|internalLastSubResultant|
                                 ((|List|
                                   (|Record| (|:| |val| |#4|)
                                             (|:| |tower| |#5|)))
                                  |#4| |#4| |#5| (|Boolean|) (|Boolean|)))
                                T)
                              '((|internalLastSubResultant|
                                 ((|List|
                                   (|Record| (|:| |val| |#4|)
                                             (|:| |tower| |#5|)))
                                  (|List|
                                   (|Record| (|:| |val| (|List| |#4|))
                                             (|:| |tower| |#5|)))
                                  |#3| (|Boolean|)))
                                T)
                              '((|integralLastSubResultant|
                                 ((|List|
                                   (|Record| (|:| |val| |#4|)
                                             (|:| |tower| |#5|)))
                                  |#4| |#4| |#5|))
                                T)
                              '((|toseLastSubResultant|
                                 ((|List|
                                   (|Record| (|:| |val| |#4|)
                                             (|:| |tower| |#5|)))
                                  |#4| |#4| |#5|))
                                T)
                              '((|toseInvertible?| ((|Boolean|) |#4| |#5|)) T)
                              '((|toseInvertible?|
                                 ((|List|
                                   (|Record| (|:| |val| (|Boolean|))
                                             (|:| |tower| |#5|)))
                                  |#4| |#5|))
                                T)
                              '((|toseInvertibleSet| ((|List| |#5|) |#4| |#5|))
                                T)
                              '((|toseSquareFreePart|
                                 ((|List|
                                   (|Record| (|:| |val| |#4|)
                                             (|:| |tower| |#5|)))
                                  |#4| |#5|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 109
                                            '(0 14 11 15 2 14 11 16 16 17 1 14
                                              11 16 18 0 11 0 19 0 14 21 22 0
                                              14 11 23 0 14 11 24 0 27 11 28 2
                                              27 11 16 16 29 1 27 11 16 30 0 27
                                              21 32 0 27 11 33 0 27 11 34 2 10
                                              9 9 0 36 1 9 0 0 37 1 9 21 0 38 2
                                              10 21 9 0 39 1 9 8 0 40 2 10 21 8
                                              0 41 2 10 45 0 8 46 2 10 0 0 8 47
                                              1 9 21 0 50 2 8 21 0 0 51 1 9 0 0
                                              53 2 10 9 9 0 54 2 43 0 0 0 55 2
                                              10 0 0 8 56 2 10 0 9 0 57 1 10 58
                                              0 59 2 10 0 58 0 60 2 8 21 0 0 61
                                              1 9 0 0 62 2 9 0 0 0 63 2 21 21 0
                                              0 64 2 43 0 65 0 66 1 27 67 26 68
                                              2 69 0 0 0 71 1 69 0 0 72 1 73 69
                                              69 74 2 27 11 26 69 75 1 9 76 0
                                              77 0 6 0 78 2 9 0 0 8 79 2 10 9 9
                                              0 80 2 58 9 0 82 83 2 9 0 0 8 84
                                              2 9 76 0 8 85 1 9 0 0 86 2 9 0 0
                                              0 87 2 9 0 0 76 88 0 9 0 89 0 9 0
                                              90 2 9 0 0 0 94 2 9 0 0 0 95 2 9
                                              0 0 0 96 2 9 97 0 0 98 1 14 100
                                              12 101 1 10 21 0 102 2 14 11 12
                                              48 103 4 9 0 0 0 0 76 105 4 9 0 0
                                              0 0 0 106 2 10 21 9 0 107 2 10 21
                                              9 0 108 2 0 48 9 10 81 3 0 48 9 9
                                              10 109 2 0 69 9 10 70 2 0 43 9 10
                                              44 2 0 21 9 10 52 0 0 11 35 0 0
                                              11 25 3 0 11 16 16 16 31 3 0 11
                                              16 16 16 20 3 0 92 9 9 10 93 5 0
                                              48 9 9 10 21 21 49 3 0 48 92 8 21
                                              104 3 0 48 9 9 10 99)))))
           '|lookupComplete|)) 

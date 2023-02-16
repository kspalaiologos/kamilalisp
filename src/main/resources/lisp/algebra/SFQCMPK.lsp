
(SDEFUN |SFQCMPK;squareFreeFactors| ((|lp| (|List| P)) ($ (|List| P)))
        (SPROG
         ((|lsflp| (|List| P)) (|lsfp| (|List| P)) (#1=#:G774 NIL) (|p| NIL))
         (SEQ (LETT |lsflp| NIL)
              (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |lsfp| (SPADCALL |p| (QREFELT $ 13)))
                        (EXIT
                         (LETT |lsflp|
                               (SPADCALL |lsfp| |lsflp| (QREFELT $ 14)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL (ELT $ 16) (SPADCALL |lsflp| (QREFELT $ 17))
                         (QREFELT $ 19)))))) 

(SDEFUN |SFQCMPK;startTable!;3SV;2|
        ((|ok| (|String|)) (|ko| (|String|)) (|domainName| (|String|))
         ($ (|Void|)))
        (SEQ (SPADCALL (QREFELT $ 23))
             (COND
              ((NULL (SPADCALL |ok| (QREFELT $ 25)))
               (COND
                ((NULL (SPADCALL |ko| (QREFELT $ 25)))
                 (SPADCALL |ok| |ko| (QREFELT $ 26))))))
             (COND
              ((NULL (SPADCALL |domainName| (QREFELT $ 25)))
               (SPADCALL |domainName| (QREFELT $ 27))))
             (EXIT (SPADCALL (QREFELT $ 28))))) 

(SDEFUN |SFQCMPK;stopTable!;V;3| (($ (|Void|)))
        (SEQ (COND ((SPADCALL (QREFELT $ 30)) (SPADCALL (QREFELT $ 31))))
             (EXIT (SPADCALL (QREFELT $ 32))))) 

(SDEFUN |SFQCMPK;supDimElseRittWu?;2TSB;4|
        ((|ts| (TS)) (|us| (TS)) ($ (|Boolean|)))
        (SPROG ((|lp2| #1=(|List| P)) (|lp1| #1#))
               (SEQ
                (COND
                 ((< (SPADCALL |ts| (QREFELT $ 35))
                     (SPADCALL |us| (QREFELT $ 35)))
                  'T)
                 ((> (SPADCALL |ts| (QREFELT $ 35))
                     (SPADCALL |us| (QREFELT $ 35)))
                  NIL)
                 ('T
                  (SEQ (LETT |lp1| (SPADCALL |ts| (QREFELT $ 36)))
                       (LETT |lp2| (SPADCALL |us| (QREFELT $ 36)))
                       (SEQ G190
                            (COND
                             ((NULL
                               (COND ((NULL |lp1|) NIL)
                                     ('T
                                      (NULL
                                       (SPADCALL (|SPADfirst| |lp2|)
                                                 (|SPADfirst| |lp1|)
                                                 (QREFELT $ 16))))))
                              (GO G191)))
                            (SEQ (LETT |lp1| (CDR |lp1|))
                                 (EXIT (LETT |lp2| (CDR |lp2|))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT (NULL (NULL |lp1|))))))))) 

(SDEFUN |SFQCMPK;algebraicSort;2L;5| ((|lts| (|List| TS)) ($ (|List| TS)))
        (SEQ (LETT |lts| (SPADCALL |lts| (QREFELT $ 39)))
             (EXIT (SPADCALL (ELT $ 37) |lts| (QREFELT $ 41))))) 

(SDEFUN |SFQCMPK;moreAlgebraic?;2TSB;6|
        ((|ts| (TS)) (|us| (TS)) ($ (|Boolean|)))
        (SPROG ((#1=#:G807 NIL) (#2=#:G808 NIL) (#3=#:G809 NIL) (|p| NIL))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL |ts| (QREFELT $ 43))
                   (SPADCALL |us| (QREFELT $ 43)))
                  ((SPADCALL |us| (QREFELT $ 43)) 'T)
                  ((< (SPADCALL |ts| (QREFELT $ 35))
                      (SPADCALL |us| (QREFELT $ 35)))
                   NIL)
                  ('T
                   (SEQ
                    (SEQ
                     (EXIT
                      (SEQ (LETT |p| NIL)
                           (LETT #3# (SPADCALL |us| (QREFELT $ 36))) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL
                                (SPADCALL (SPADCALL |p| (QREFELT $ 44)) |ts|
                                          (QREFELT $ 45)))
                               (PROGN
                                (LETT #1#
                                      (PROGN (LETT #2# NIL) (GO #4=#:G806)))
                                (GO #5=#:G801))))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                     #5# (EXIT #1#))
                    (EXIT 'T)))))
                #4# (EXIT #2#)))) 

(SDEFUN |SFQCMPK;subTriSet?;2TSB;7| ((|ts| (TS)) (|us| (TS)) ($ (|Boolean|)))
        (SPROG ((#1=#:G811 NIL) (#2=#:G814 NIL))
               (COND ((SPADCALL |ts| (QREFELT $ 43)) 'T)
                     ((OR (SPADCALL |us| (QREFELT $ 43))
                          (SPADCALL (SPADCALL |ts| (QREFELT $ 47))
                                    (SPADCALL |us| (QREFELT $ 47))
                                    (QREFELT $ 48)))
                      NIL)
                     ((SPADCALL (SPADCALL |ts| (QREFELT $ 47))
                                (SPADCALL |us| (QREFELT $ 47)) (QREFELT $ 49))
                      (SPADCALL |ts|
                                (PROG2
                                    (LETT #1# (SPADCALL |us| (QREFELT $ 51)))
                                    (QCDR #1#)
                                  (|check_union2| (QEQCAR #1# 0) (QREFELT $ 10)
                                                  (|Union| (QREFELT $ 10)
                                                           #3="failed")
                                                  #1#))
                                (QREFELT $ 52)))
                     ((SPADCALL
                       (PROG2 (LETT #2# (SPADCALL |ts| (QREFELT $ 54)))
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0) (QREFELT $ 9)
                                         (|Union| (QREFELT $ 9) #3#) #2#))
                       (PROG2 (LETT #2# (SPADCALL |us| (QREFELT $ 54)))
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0) (QREFELT $ 9)
                                         (|Union| (QREFELT $ 9) #3#) #2#))
                       (QREFELT $ 55))
                      (SPADCALL
                       (PROG2 (LETT #1# (SPADCALL |ts| (QREFELT $ 51)))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0) (QREFELT $ 10)
                                         (|Union| (QREFELT $ 10) #3#) #1#))
                       (PROG2 (LETT #1# (SPADCALL |us| (QREFELT $ 51)))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0) (QREFELT $ 10)
                                         (|Union| (QREFELT $ 10) #3#) #1#))
                       (QREFELT $ 52)))
                     ('T NIL)))) 

(SDEFUN |SFQCMPK;internalSubPolSet?;2LB;8|
        ((|lp1| (|List| P)) (|lp2| (|List| P)) ($ (|Boolean|)))
        (COND ((NULL |lp1|) 'T) ((NULL |lp2|) NIL)
              ((SPADCALL (|SPADfirst| |lp1|) (|SPADfirst| |lp2|)
                         (QREFELT $ 56))
               (SPADCALL (CDR |lp1|) (CDR |lp2|) (QREFELT $ 57)))
              ((SPADCALL (|SPADfirst| |lp1|) (|SPADfirst| |lp2|)
                         (QREFELT $ 16))
               NIL)
              ('T (SPADCALL |lp1| (CDR |lp2|) (QREFELT $ 57))))) 

(SDEFUN |SFQCMPK;subPolSet?;2LB;9|
        ((|lp1| (|List| P)) (|lp2| (|List| P)) ($ (|Boolean|)))
        (SEQ (LETT |lp1| (SPADCALL (ELT $ 16) |lp1| (QREFELT $ 19)))
             (LETT |lp2| (SPADCALL (ELT $ 16) |lp2| (QREFELT $ 19)))
             (EXIT (SPADCALL |lp1| |lp2| (QREFELT $ 57))))) 

(SDEFUN |SFQCMPK;infRittWu?;2LB;10|
        ((|lp1| (|List| P)) (|lp2| (|List| P)) ($ (|Boolean|)))
        (SEQ (LETT |lp1| (SPADCALL (ELT $ 16) |lp1| (QREFELT $ 19)))
             (LETT |lp2| (SPADCALL (ELT $ 16) |lp2| (QREFELT $ 19)))
             (EXIT (SPADCALL |lp1| |lp2| (QREFELT $ 59))))) 

(SDEFUN |SFQCMPK;internalInfRittWu?;2LB;11|
        ((|lp1| (|List| P)) (|lp2| (|List| P)) ($ (|Boolean|)))
        (COND ((NULL |lp1|) (NULL (NULL |lp2|))) ((NULL |lp2|) NIL)
              ((SPADCALL (|SPADfirst| |lp1|) (|SPADfirst| |lp2|)
                         (QREFELT $ 16))
               'T)
              ((SPADCALL (|SPADfirst| |lp2|) (|SPADfirst| |lp1|)
                         (QREFELT $ 16))
               NIL)
              ('T (SPADCALL (CDR |lp1|) (CDR |lp2|) (QREFELT $ 60))))) 

(SDEFUN |SFQCMPK;subCase?;2RB;12|
        ((|lpwt1| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))
         (|lpwt2| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))
         ($ (|Boolean|)))
        (COND
         ((NULL (SPADCALL (QCAR |lpwt2|) (QCAR |lpwt1|) (QREFELT $ 57))) NIL)
         ('T (SPADCALL (QCDR |lpwt1|) (QCDR |lpwt2|) (QREFELT $ 61))))) 

(SDEFUN |SFQCMPK;internalSubQuasiComponent?;2TSU;13|
        ((|ts| (TS)) (|us| (TS)) ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((#1=#:G874 NIL) (|b| (|Boolean|)) (#2=#:G877 NIL) (|p| NIL)
          (|lsfp| (|List| P)) (#3=#:G872 NIL) (#4=#:G876 NIL) (#5=#:G873 NIL)
          (#6=#:G856 NIL) (#7=#:G875 NIL))
         (SEQ
          (EXIT
           (COND ((SPADCALL |us| |ts| (QREFELT $ 52)) (CONS 0 'T))
                 ((NULL (SPADCALL |ts| |us| (QREFELT $ 46))) (CONS 0 NIL))
                 ('T
                  (SEQ
                   (SEQ
                    (EXIT
                     (SEQ (LETT |p| NIL)
                          (LETT #7# (SPADCALL |us| (QREFELT $ 36))) G190
                          (COND
                           ((OR (ATOM #7#) (PROGN (LETT |p| (CAR #7#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((< (SPADCALL |p| (QREFELT $ 64))
                                 (SPADCALL
                                  (PROG2
                                      (LETT #6#
                                            (SPADCALL |ts|
                                                      (SPADCALL |p|
                                                                (QREFELT $ 44))
                                                      (QREFELT $ 65)))
                                      (QCDR #6#)
                                    (|check_union2| (QEQCAR #6# 0)
                                                    (QREFELT $ 9)
                                                    (|Union| (QREFELT $ 9)
                                                             "failed")
                                                    #6#))
                                  (QREFELT $ 64)))
                              (PROGN
                               (LETT #5#
                                     (PROGN
                                      (LETT #1# (CONS 1 "failed"))
                                      (GO #8=#:G871)))
                               (GO #9=#:G859))))))
                          (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL)))
                    #9# (EXIT #5#))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |p| NIL)
                          (LETT #4# (SPADCALL |us| (QREFELT $ 36))) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |p| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((NULL
                               (SPADCALL (SPADCALL |p| |ts| (QREFELT $ 66))
                                         (QREFELT $ 67)))
                              (PROGN
                               (LETT #3#
                                     (PROGN
                                      (LETT #1# (CONS 1 "failed"))
                                      (GO #8#)))
                               (GO #10=#:G862))))))
                          (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL)))
                    #10# (EXIT #3#))
                   (LETT |lsfp|
                         (|SFQCMPK;squareFreeFactors|
                          (SPADCALL |us| (QREFELT $ 68)) $))
                   (SEQ (LETT |p| NIL) (LETT #2# |lsfp|) G190
                        (COND
                         ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                          (GO G191)))
                        (SEQ (LETT |b| (SPADCALL |p| |ts| (QREFELT $ 69)))
                             (EXIT
                              (COND
                               ((NULL |b|)
                                (PROGN (LETT #1# (CONS 0 NIL)) (GO #8#))))))
                        (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                   (EXIT (CONS 0 'T))))))
          #8# (EXIT #1#)))) 

(SDEFUN |SFQCMPK;internalSubQuasiComponent?;2TSU;14|
        ((|ts| (TS)) (|us| (TS)) ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((#1=#:G894 NIL) (#2=#:G896 NIL) (#3=#:G898 NIL) (|p| NIL)
          (#4=#:G895 NIL) (#5=#:G884 NIL) (#6=#:G897 NIL))
         (SEQ
          (EXIT
           (COND ((SPADCALL |us| |ts| (QREFELT $ 52)) (CONS 0 'T))
                 ((NULL (SPADCALL |ts| |us| (QREFELT $ 46))) (CONS 0 NIL))
                 ('T
                  (SEQ
                   (SEQ
                    (EXIT
                     (SEQ (LETT |p| NIL)
                          (LETT #6# (SPADCALL |us| (QREFELT $ 36))) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |p| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((< (SPADCALL |p| (QREFELT $ 64))
                                 (SPADCALL
                                  (PROG2
                                      (LETT #5#
                                            (SPADCALL |ts|
                                                      (SPADCALL |p|
                                                                (QREFELT $ 44))
                                                      (QREFELT $ 65)))
                                      (QCDR #5#)
                                    (|check_union2| (QEQCAR #5# 0)
                                                    (QREFELT $ 9)
                                                    (|Union| (QREFELT $ 9)
                                                             "failed")
                                                    #5#))
                                  (QREFELT $ 64)))
                              (PROGN
                               (LETT #4#
                                     (PROGN
                                      (LETT #2# (CONS 1 "failed"))
                                      (GO #7=#:G893)))
                               (GO #8=#:G887))))))
                          (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL)))
                    #8# (EXIT #4#))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |p| NIL)
                          (LETT #3# (SPADCALL |us| (QREFELT $ 36))) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((NULL
                               (SPADCALL (SPADCALL |p| |ts| (QREFELT $ 72))
                                         (QREFELT $ 67)))
                              (PROGN
                               (LETT #1#
                                     (PROGN
                                      (LETT #2# (CONS 1 "failed"))
                                      (GO #7#)))
                               (GO #9=#:G890))))))
                          (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                    #9# (EXIT #1#))
                   (EXIT (CONS 0 'T))))))
          #7# (EXIT #2#)))) 

(SDEFUN |SFQCMPK;subQuasiComponent?;2TSB;15|
        ((|ts| (TS)) (|us| (TS)) ($ (|Boolean|)))
        (SPROG
         ((|b| (|Boolean|)) (|ubf| (|Union| (|Boolean|) "failed"))
          (|e| (|Union| (|Boolean|) "failed"))
          (|k| (|Record| (|:| |left| TS) (|:| |right| TS))))
         (SEQ (LETT |k| (CONS |ts| |us|))
              (LETT |e| (SPADCALL |k| (QREFELT $ 73)))
              (EXIT
               (COND ((QEQCAR |e| 0) (QCDR |e|))
                     (#1='T
                      (SEQ (LETT |ubf| (SPADCALL |ts| |us| (QREFELT $ 71)))
                           (LETT |b|
                                 (COND ((QEQCAR |ubf| 0) (QCDR |ubf|))
                                       (#1# NIL)))
                           (SPADCALL |k| |b| (QREFELT $ 74)) (EXIT |b|)))))))) 

(SDEFUN |SFQCMPK;subQuasiComponent?;TSLB;16|
        ((|ts| (TS)) (|lus| (|List| TS)) ($ (|Boolean|)))
        (SPROG ((#1=#:G911 NIL) (#2=#:G912 NIL) (#3=#:G913 NIL) (|us| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |us| NIL) (LETT #3# |lus|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |us| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |ts| |us| (QREFELT $ 61))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G910)))
                              (GO #5=#:G908))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |SFQCMPK;removeSuperfluousCases;2L;17|
        ((|cases| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
         ($ (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))))
        (SPROG
         ((|toSee| (|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|headmaxcases|
           #1=(|List| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|copymaxcases|
           (|List| #2=(|Record| (|:| |val| (|List| P)) (|:| |tower| TS))))
          (|maxcases| #1#) (|toSave| (|List| #2#))
          (|lpwt1| (|Record| (|:| |val| (|List| P)) (|:| |tower| TS)))
          (#3=#:G946 NIL) (|lpwt2| NIL))
         (SEQ
          (COND ((< (LENGTH |cases|) 2) |cases|)
                ('T
                 (SEQ
                  (LETT |toSee|
                        (SPADCALL
                         (CONS #'|SFQCMPK;removeSuperfluousCases;2L;17!0| $)
                         |cases| (QREFELT $ 78)))
                  (SEQ G190 (COND ((NULL (NULL (NULL |toSee|))) (GO G191)))
                       (SEQ (LETT |lpwt1| (|SPADfirst| |toSee|))
                            (LETT |toSee| (CDR |toSee|)) (LETT |toSave| NIL)
                            (SEQ (LETT |lpwt2| NIL) (LETT #3# |toSee|) G190
                                 (COND
                                  ((OR (ATOM #3#)
                                       (PROGN (LETT |lpwt2| (CAR #3#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((SPADCALL |lpwt1| |lpwt2| (QREFELT $ 63))
                                     (LETT |lpwt1| |lpwt2|))
                                    ((NULL
                                      (SPADCALL |lpwt2| |lpwt1|
                                                (QREFELT $ 63)))
                                     (LETT |toSave|
                                           (CONS |lpwt2| |toSave|))))))
                                 (LETT #3# (CDR #3#)) (GO G190) G191
                                 (EXIT NIL))
                            (COND
                             ((NULL |maxcases|)
                              (SEQ (LETT |headmaxcases| (LIST |lpwt1|))
                                   (EXIT (LETT |maxcases| |headmaxcases|))))
                             ('T
                              (SEQ (LETT |copymaxcases| |maxcases|)
                                   (SEQ G190
                                        (COND
                                         ((NULL
                                           (COND ((NULL |copymaxcases|) NIL)
                                                 ('T
                                                  (NULL
                                                   (SPADCALL |lpwt1|
                                                             (|SPADfirst|
                                                              |copymaxcases|)
                                                             (QREFELT $
                                                                      63))))))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT |copymaxcases|
                                                (CDR |copymaxcases|))))
                                        NIL (GO G190) G191 (EXIT NIL))
                                   (EXIT
                                    (COND
                                     ((NULL |copymaxcases|)
                                      (SEQ
                                       (SPADCALL |headmaxcases| (LIST |lpwt1|)
                                                 (QREFELT $ 79))
                                       (EXIT
                                        (LETT |headmaxcases|
                                              (CDR |headmaxcases|))))))))))
                            (EXIT (LETT |toSee| (REVERSE |toSave|))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT |maxcases|))))))) 

(SDEFUN |SFQCMPK;removeSuperfluousCases;2L;17!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 37))) 

(SDEFUN |SFQCMPK;removeSuperfluousQuasiComponents;2L;18|
        ((|lts| (|List| TS)) ($ (|List| TS)))
        (SPROG
         ((|toSee| (|List| TS)) (|headmaxlts| #1=(|List| TS))
          (|copymaxlts| (|List| TS)) (|maxlts| #1#) (|toSave| (|List| TS))
          (|ts| (TS)) (#2=#:G966 NIL) (|us| NIL))
         (SEQ (LETT |lts| (SPADCALL |lts| (QREFELT $ 39)))
              (EXIT
               (COND ((< (LENGTH |lts|) 2) |lts|)
                     ('T
                      (SEQ (LETT |toSee| (SPADCALL |lts| (QREFELT $ 42)))
                           (SEQ G190
                                (COND ((NULL (NULL (NULL |toSee|))) (GO G191)))
                                (SEQ (LETT |ts| (|SPADfirst| |toSee|))
                                     (LETT |toSee| (CDR |toSee|))
                                     (LETT |toSave| NIL)
                                     (SEQ (LETT |us| NIL) (LETT #2# |toSee|)
                                          G190
                                          (COND
                                           ((OR (ATOM #2#)
                                                (PROGN
                                                 (LETT |us| (CAR #2#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (COND
                                             ((SPADCALL |ts| |us|
                                                        (QREFELT $ 61))
                                              (LETT |ts| |us|))
                                             ((NULL
                                               (SPADCALL |us| |ts|
                                                         (QREFELT $ 61)))
                                              (LETT |toSave|
                                                    (CONS |us| |toSave|))))))
                                          (LETT #2# (CDR #2#)) (GO G190) G191
                                          (EXIT NIL))
                                     (COND
                                      ((NULL |maxlts|)
                                       (SEQ (LETT |headmaxlts| (LIST |ts|))
                                            (EXIT
                                             (LETT |maxlts| |headmaxlts|))))
                                      ('T
                                       (SEQ (LETT |copymaxlts| |maxlts|)
                                            (SEQ G190
                                                 (COND
                                                  ((NULL
                                                    (COND
                                                     ((NULL |copymaxlts|) NIL)
                                                     ('T
                                                      (NULL
                                                       (SPADCALL |ts|
                                                                 (|SPADfirst|
                                                                  |copymaxlts|)
                                                                 (QREFELT $
                                                                          61))))))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT |copymaxlts|
                                                         (CDR |copymaxlts|))))
                                                 NIL (GO G190) G191 (EXIT NIL))
                                            (EXIT
                                             (COND
                                              ((NULL |copymaxlts|)
                                               (SEQ
                                                (SPADCALL |headmaxlts|
                                                          (LIST |ts|)
                                                          (QREFELT $ 81))
                                                (EXIT
                                                 (LETT |headmaxlts|
                                                       (CDR
                                                        |headmaxlts|))))))))))
                                     (EXIT (LETT |toSee| (REVERSE |toSave|))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT (SPADCALL |maxlts| (QREFELT $ 42)))))))))) 

(SDEFUN |SFQCMPK;removeAssociates| ((|lp| (|List| P)) ($ (|List| P)))
        (SPROG ((#1=#:G971 NIL) (|p| NIL) (#2=#:G970 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |p| (QREFELT $ 83)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 17))))) 

(SDEFUN |SFQCMPK;branchIfCan;LTSL5BU;20|
        ((|leq| (|List| P)) (|ts| (TS)) (|lineq| (|List| P)) (|b1| (|Boolean|))
         (|b2| (|Boolean|)) (|b3| (|Boolean|)) (|b4| (|Boolean|))
         (|b5| (|Boolean|))
         ($
          (|Union|
           (|Record| (|:| |eq| (|List| P)) (|:| |tower| TS)
                     (|:| |ineq| (|List| P)))
           "failed")))
        (SPROG
         ((|newleq| (|List| P)) (#1=#:G1014 NIL) (|newp| (P)) (#2=#:G996 NIL)
          (|g| (P)) (#3=#:G1018 NIL) (|q| NIL) (#4=#:G1017 NIL) (|p| NIL)
          (#5=#:G1011 NIL) (#6=#:G1016 NIL) (#7=#:G1012 NIL) (#8=#:G1015 NIL)
          (|ps| (|GeneralPolynomialSet| R E V P)) (#9=#:G1013 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             (|b1|
              (SEQ
               (EXIT
                (SEQ (LETT |leq| (|SFQCMPK;removeAssociates| |leq| $))
                     (LETT |leq| (SPADCALL (ELT $ 67) |leq| (QREFELT $ 85)))
                     (EXIT
                      (COND
                       ((SPADCALL (ELT $ 86) |leq| (QREFELT $ 87))
                        (PROGN
                         (LETT #9#
                               (PROGN
                                (LETT #1# (CONS 1 "failed"))
                                (GO #10=#:G1010)))
                         (GO #11=#:G979)))))))
               #11# (EXIT #9#))))
            (COND
             (|b2|
              (COND
               ((SPADCALL (ELT $ 67) |lineq| (QREFELT $ 87))
                (PROGN (LETT #1# (CONS 1 "failed")) (GO #10#)))
               ('T (LETT |lineq| (SPADCALL |lineq| (QREFELT $ 88)))))))
            (COND
             (|b3|
              (SEQ (LETT |ps| (SPADCALL |leq| (QREFELT $ 90)))
                   (EXIT
                    (SEQ
                     (EXIT
                      (SEQ (LETT |q| NIL) (LETT #8# |lineq|) G190
                           (COND
                            ((OR (ATOM #8#) (PROGN (LETT |q| (CAR #8#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL
                                (QVELT (SPADCALL |q| |ps| (QREFELT $ 92)) 1)
                                (QREFELT $ 67))
                               (PROGN
                                (LETT #7#
                                      (PROGN
                                       (LETT #1# (CONS 1 "failed"))
                                       (GO #10#)))
                                (GO #12=#:G986))))))
                           (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL)))
                     #12# (EXIT #7#))))))
            (COND
             ((OR (NULL |leq|) (NULL |lineq|))
              (EXIT (CONS 0 (VECTOR |leq| |ts| |lineq|)))))
            (COND
             (|b4|
              (SEQ
               (EXIT
                (SEQ (LETT |q| NIL) (LETT #6# |lineq|) G190
                     (COND
                      ((OR (ATOM #6#) (PROGN (LETT |q| (CAR #6#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL (SPADCALL |q| |ts| (QREFELT $ 66))
                                   (QREFELT $ 67))
                         (PROGN
                          (LETT #5#
                                (PROGN (LETT #1# (CONS 1 "failed")) (GO #10#)))
                          (GO #13=#:G992))))))
                     (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL)))
               #13# (EXIT #5#))))
            (COND
             (|b5|
              (SEQ (LETT |newleq| NIL)
                   (SEQ (LETT |p| NIL) (LETT #4# |leq|) G190
                        (COND
                         ((OR (ATOM #4#) (PROGN (LETT |p| (CAR #4#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |q| NIL) (LETT #3# |lineq|) G190
                               (COND
                                ((OR (ATOM #3#)
                                     (PROGN (LETT |q| (CAR #3#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL (SPADCALL |p| (QREFELT $ 44))
                                             (SPADCALL |q| (QREFELT $ 44))
                                             (QREFELT $ 93))
                                   (SEQ
                                    (LETT |g|
                                          (SPADCALL |p| |q| (QREFELT $ 94)))
                                    (LETT |newp|
                                          (PROG2
                                              (LETT #2#
                                                    (SPADCALL |p| |g|
                                                              (QREFELT $ 95)))
                                              (QCDR #2#)
                                            (|check_union2| (QEQCAR #2# 0)
                                                            (QREFELT $ 9)
                                                            (|Union|
                                                             (QREFELT $ 9)
                                                             "failed")
                                                            #2#)))
                                    (EXIT
                                     (COND
                                      ((SPADCALL |newp| (QREFELT $ 86))
                                       (PROGN
                                        (LETT #1# (CONS 1 "failed"))
                                        (GO #10#)))
                                      ('T
                                       (LETT |newleq|
                                             (CONS |newp| |newleq|)))))))
                                  ('T (LETT |newleq| (CONS |p| |newleq|))))))
                               (LETT #3# (CDR #3#)) (GO G190) G191
                               (EXIT NIL))))
                        (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                   (EXIT (LETT |leq| |newleq|)))))
            (LETT |leq|
                  (SPADCALL (ELT $ 16) (SPADCALL |leq| (QREFELT $ 17))
                            (QREFELT $ 19)))
            (EXIT (CONS 0 (VECTOR |leq| |ts| |lineq|)))))
          #10# (EXIT #1#)))) 

(SDEFUN |SFQCMPK;prepareDecompose;LL2BL;21|
        ((|lp| (|List| P)) (|lts| (|List| TS)) (|b1| (|Boolean|))
         (|b2| (|Boolean|))
         ($
          (|List|
           (|Record| (|:| |eq| #1=(|List| P)) (|:| |tower| TS)
                     (|:| |ineq| #2=(|List| P))))))
        (SPROG
         ((#3=#:G1062 NIL) (#4=#:G1061 NIL)
          (|toSee|
           (|List|
            (|Record| (|:| |eq| (|List| P)) (|:| |tower| TS)
                      (|:| |ineq| (|List| P)))))
          (|lq| (|List| P))
          (|branches|
           (|List|
            (|Record| (|:| |eq| (|List| P)) (|:| |tower| TS)
                      (|:| |ineq| (|List| P)))))
          (#5=#:G1031 NIL)
          (|newBranch|
           #6=(|Union|
               (|Record| (|:| |eq| (|List| P)) (|:| |tower| TS)
                         (|:| |ineq| (|List| P)))
               "failed"))
          (|lineq| #2#) (|leq| #1#) (|ubf2| #6#) (|ubf1| #6#) (|ts| (TS))
          (#7=#:G1060 NIL) (|branch| NIL) (#8=#:G1059 NIL) (|f| NIL)
          (|lsfp| (|List| P)) (#9=#:G1058 NIL) (|p| NIL) (#10=#:G1057 NIL)
          (#11=#:G1056 NIL))
         (SEQ
          (LETT |lp|
                (SPADCALL (ELT $ 16)
                          (SPADCALL (ELT $ 67)
                                    (|SFQCMPK;removeAssociates| |lp| $)
                                    (QREFELT $ 85))
                          (QREFELT $ 19)))
          (EXIT
           (COND
            ((OR (SPADCALL (ELT $ 86) |lp| (QREFELT $ 87)) (NULL |lts|)) NIL)
            ('T
             (SEQ (COND (|b1| (LETT |lts| (SPADCALL |lts| (QREFELT $ 82)))))
                  (EXIT
                   (COND
                    (|b2|
                     (SEQ (LETT |lq| NIL)
                          (LETT |toSee|
                                (PROGN
                                 (LETT #11# NIL)
                                 (SEQ (LETT #10# |lts|) G190
                                      (COND
                                       ((OR (ATOM #10#)
                                            (PROGN (LETT |ts| (CAR #10#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #11#
                                              (CONS
                                               (VECTOR |lq| |ts|
                                                       (|SFQCMPK;squareFreeFactors|
                                                        (SPADCALL |ts|
                                                                  (QREFELT $
                                                                           68))
                                                        $))
                                               #11#))))
                                      (LETT #10# (CDR #10#)) (GO G190) G191
                                      (EXIT (NREVERSE #11#)))))
                          (EXIT
                           (COND ((NULL |lp|) |toSee|)
                                 (#12='T
                                  (SEQ
                                   (SEQ (LETT |p| NIL) (LETT #9# |lp|) G190
                                        (COND
                                         ((OR (ATOM #9#)
                                              (PROGN (LETT |p| (CAR #9#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (LETT |lsfp|
                                               (SPADCALL |p| (QREFELT $ 13)))
                                         (LETT |branches| NIL) (LETT |lq| NIL)
                                         (SEQ (LETT |f| NIL) (LETT #8# |lsfp|)
                                              G190
                                              (COND
                                               ((OR (ATOM #8#)
                                                    (PROGN
                                                     (LETT |f| (CAR #8#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (SEQ (LETT |branch| NIL)
                                                    (LETT #7# |toSee|) G190
                                                    (COND
                                                     ((OR (ATOM #7#)
                                                          (PROGN
                                                           (LETT |branch|
                                                                 (CAR #7#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (LETT |leq|
                                                           (QVELT |branch| 0))
                                                     (LETT |ts|
                                                           (QVELT |branch| 1))
                                                     (LETT |lineq|
                                                           (QVELT |branch| 2))
                                                     (LETT |ubf1|
                                                           (SPADCALL |leq| |ts|
                                                                     |lq| NIL
                                                                     NIL 'T 'T
                                                                     'T
                                                                     (QREFELT $
                                                                              98)))
                                                     (EXIT
                                                      (COND
                                                       ((QEQCAR |ubf1| 1)
                                                        "leave")
                                                       ('T
                                                        (SEQ
                                                         (LETT |ubf2|
                                                               (SPADCALL
                                                                (LIST |f|) |ts|
                                                                |lineq| NIL NIL
                                                                'T 'T 'T
                                                                (QREFELT $
                                                                         98)))
                                                         (EXIT
                                                          (COND
                                                           ((QEQCAR |ubf2| 1)
                                                            "leave")
                                                           ('T
                                                            (SEQ
                                                             (LETT |leq|
                                                                   (SPADCALL
                                                                    (ELT $ 16)
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (QVELT
                                                                       (QCDR
                                                                        |ubf1|)
                                                                       0)
                                                                      (QVELT
                                                                       (QCDR
                                                                        |ubf2|)
                                                                       0)
                                                                      (QREFELT
                                                                       $ 14))
                                                                     (QREFELT $
                                                                              17))
                                                                    (QREFELT $
                                                                             19)))
                                                             (LETT |lineq|
                                                                   (SPADCALL
                                                                    (ELT $ 16)
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (QVELT
                                                                       (QCDR
                                                                        |ubf1|)
                                                                       2)
                                                                      (QVELT
                                                                       (QCDR
                                                                        |ubf2|)
                                                                       2)
                                                                      (QREFELT
                                                                       $ 14))
                                                                     (QREFELT $
                                                                              17))
                                                                    (QREFELT $
                                                                             19)))
                                                             (LETT |newBranch|
                                                                   (SPADCALL
                                                                    |leq| |ts|
                                                                    |lineq| NIL
                                                                    NIL NIL NIL
                                                                    NIL
                                                                    (QREFELT $
                                                                             98)))
                                                             (EXIT
                                                              (LETT |branches|
                                                                    (CONS
                                                                     (PROG2
                                                                         (LETT
                                                                          #5#
                                                                          |newBranch|)
                                                                         (QCDR
                                                                          #5#)
                                                                       (|check_union2|
                                                                        (QEQCAR
                                                                         #5# 0)
                                                                        (|Record|
                                                                         (|:|
                                                                          |eq|
                                                                          (|List|
                                                                           (QREFELT
                                                                            $
                                                                            9)))
                                                                         (|:|
                                                                          |tower|
                                                                          (QREFELT
                                                                           $
                                                                           10))
                                                                         (|:|
                                                                          |ineq|
                                                                          (|List|
                                                                           (QREFELT
                                                                            $
                                                                            9))))
                                                                        (|Union|
                                                                         (|Record|
                                                                          (|:|
                                                                           |eq|
                                                                           (|List|
                                                                            (QREFELT
                                                                             $
                                                                             9)))
                                                                          (|:|
                                                                           |tower|
                                                                           (QREFELT
                                                                            $
                                                                            10))
                                                                          (|:|
                                                                           |ineq|
                                                                           (|List|
                                                                            (QREFELT
                                                                             $
                                                                             9))))
                                                                         "failed")
                                                                        #5#))
                                                                     |branches|))))))))))))
                                                    (LETT #7# (CDR #7#))
                                                    (GO G190) G191 (EXIT NIL))
                                               (EXIT
                                                (LETT |lq| (CONS |f| |lq|))))
                                              (LETT #8# (CDR #8#)) (GO G190)
                                              G191 (EXIT NIL))
                                         (EXIT (LETT |toSee| |branches|)))
                                        (LETT #9# (CDR #9#)) (GO G190) G191
                                        (EXIT NIL))
                                   (EXIT
                                    (SPADCALL
                                     (CONS
                                      #'|SFQCMPK;prepareDecompose;LL2BL;21!0|
                                      $)
                                     |toSee| (QREFELT $ 101)))))))))
                    (#12#
                     (PROGN
                      (LETT #4# NIL)
                      (SEQ (LETT #3# |lts|) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |ts| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #4#
                                   (CONS
                                    (VECTOR |lp| |ts|
                                            (|SFQCMPK;squareFreeFactors|
                                             (SPADCALL |ts| (QREFELT $ 68)) $))
                                    #4#))))
                           (LETT #3# (CDR #3#)) (GO G190) G191
                           (EXIT (NREVERSE #4#)))))))))))))) 

(SDEFUN |SFQCMPK;prepareDecompose;LL2BL;21!0| ((|x| NIL) (|y| NIL) ($ NIL))
        (SPADCALL (QVELT |x| 1) (QVELT |y| 1) (QREFELT $ 37))) 

(DECLAIM (NOTINLINE |SquareFreeQuasiComponentPackage;|)) 

(DEFUN |SquareFreeQuasiComponentPackage| (&REST #1=#:G1063)
  (SPROG NIL
         (PROG (#2=#:G1064)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SquareFreeQuasiComponentPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |SquareFreeQuasiComponentPackage;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SquareFreeQuasiComponentPackage|)))))))))) 

(DEFUN |SquareFreeQuasiComponentPackage;| (|#1| |#2| |#3| |#4| |#5|)
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
          (LIST '|SquareFreeQuasiComponentPackage| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 103))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|SquareFreeQuasiComponentPackage|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#5|
                     (LIST '|SquareFreeRegularTriangularSetCategory|
                           (|devaluate| |#1|) (|devaluate| |#2|)
                           (|devaluate| |#3|) (|devaluate| |#4|)))
      (QSETREFV $ 71
                (CONS
                 (|dispatchFunction|
                  |SFQCMPK;internalSubQuasiComponent?;2TSU;13|)
                 $)))
     ('T
      (QSETREFV $ 71
                (CONS
                 (|dispatchFunction|
                  |SFQCMPK;internalSubQuasiComponent?;2TSU;14|)
                 $))))
    $))) 

(MAKEPROP '|SquareFreeQuasiComponentPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|List| 9)
              (|PolynomialSetUtilitiesPackage| 6 7 8 9)
              (0 . |squareFreeFactors|) (5 . |concat|) (|Boolean|)
              (11 . |infRittWu?|) (17 . |removeDuplicates|) (|Mapping| 15 9 9)
              (22 . |sort|) (|Void|)
              (|Record| (|:| |left| 10) (|:| |right| 10))
              (|TabulatedComputationPackage| 21 15) (28 . |initTable!|)
              (|String|) (32 . |empty?|) (37 . |printInfo!|)
              (43 . |startStats!|) (48 . |void|) |SFQCMPK;startTable!;3SV;2|
              (52 . |makingStats?|) (56 . |printStats!|) (60 . |clearTable!|)
              |SFQCMPK;stopTable!;V;3| (|NonNegativeInteger|) (64 . |#|)
              (69 . |members|) |SFQCMPK;supDimElseRittWu?;2TSB;4| (|List| 10)
              (74 . |removeDuplicates|) (|Mapping| 15 10 10) (79 . |sort|)
              |SFQCMPK;algebraicSort;2L;5| (85 . |empty?|) (90 . |mvar|)
              (95 . |algebraic?|) |SFQCMPK;moreAlgebraic?;2TSB;6|
              (101 . |mvar|) (106 . >) (112 . <) (|Union| $ '#1="failed")
              (118 . |rest|) |SFQCMPK;subTriSet?;2TSB;7| (|Union| 9 '#1#)
              (123 . |first|) (128 . =) (134 . |associates?|)
              |SFQCMPK;internalSubPolSet?;2LB;8| |SFQCMPK;subPolSet?;2LB;9|
              |SFQCMPK;internalInfRittWu?;2LB;11| |SFQCMPK;infRittWu?;2LB;10|
              |SFQCMPK;subQuasiComponent?;2TSB;15|
              (|Record| (|:| |val| 11) (|:| |tower| 10))
              |SFQCMPK;subCase?;2RB;12| (140 . |mdeg|) (145 . |select|)
              (151 . |initiallyReduce|) (157 . |zero?|) (162 . |initials|)
              (167 . |invertible?|) (|Union| 15 '"failed")
              (173 . |internalSubQuasiComponent?|) (179 . |reduceByQuasiMonic|)
              (185 . |extractIfCan|) (190 . |insert!|)
              |SFQCMPK;subQuasiComponent?;TSLB;16| (|Mapping| 15 62 62)
              (|List| 62) (196 . |sort|) (202 . |setrest!|)
              |SFQCMPK;removeSuperfluousCases;2L;17| (208 . |setrest!|)
              |SFQCMPK;removeSuperfluousQuasiComponents;2L;18|
              (214 . |primitivePart|) (|Mapping| 15 9) (219 . |remove|)
              (225 . |ground?|) (230 . |any?|) (236 . |removeRedundantFactors|)
              (|GeneralPolynomialSet| 6 7 8 9) (241 . |construct|)
              (|Record| (|:| |rnum| 6) (|:| |polnum| 9) (|:| |den| 6))
              (246 . |remainder|) (252 . =) (258 . |gcd|) (264 . |exquo|)
              (|Record| (|:| |eq| 11) (|:| |tower| 10) (|:| |ineq| 11))
              (|Union| 96 '"failed") |SFQCMPK;branchIfCan;LTSL5BU;20|
              (|Mapping| 15 96 96) (|List| 96) (270 . |sort|)
              |SFQCMPK;prepareDecompose;LL2BL;21|)
           '#(|supDimElseRittWu?| 276 |subTriSet?| 282 |subQuasiComponent?| 288
              |subPolSet?| 300 |subCase?| 306 |stopTable!| 312 |startTable!|
              316 |removeSuperfluousQuasiComponents| 323
              |removeSuperfluousCases| 328 |prepareDecompose| 333
              |moreAlgebraic?| 341 |internalSubQuasiComponent?| 347
              |internalSubPolSet?| 353 |internalInfRittWu?| 359 |infRittWu?|
              365 |branchIfCan| 371 |algebraicSort| 383)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|startTable!|
                                 ((|Void|) (|String|) (|String|) (|String|)))
                                T)
                              '((|stopTable!| ((|Void|))) T)
                              '((|supDimElseRittWu?| ((|Boolean|) |#5| |#5|))
                                T)
                              '((|algebraicSort| ((|List| |#5|) (|List| |#5|)))
                                T)
                              '((|moreAlgebraic?| ((|Boolean|) |#5| |#5|)) T)
                              '((|subTriSet?| ((|Boolean|) |#5| |#5|)) T)
                              '((|subPolSet?|
                                 ((|Boolean|) (|List| |#4|) (|List| |#4|)))
                                T)
                              '((|internalSubPolSet?|
                                 ((|Boolean|) (|List| |#4|) (|List| |#4|)))
                                T)
                              '((|internalInfRittWu?|
                                 ((|Boolean|) (|List| |#4|) (|List| |#4|)))
                                T)
                              '((|infRittWu?|
                                 ((|Boolean|) (|List| |#4|) (|List| |#4|)))
                                T)
                              '((|internalSubQuasiComponent?|
                                 ((|Union| (|Boolean|) "failed") |#5| |#5|))
                                T)
                              '((|subQuasiComponent?| ((|Boolean|) |#5| |#5|))
                                T)
                              '((|subQuasiComponent?|
                                 ((|Boolean|) |#5| (|List| |#5|)))
                                T)
                              '((|removeSuperfluousQuasiComponents|
                                 ((|List| |#5|) (|List| |#5|)))
                                T)
                              '((|subCase?|
                                 ((|Boolean|)
                                  (|Record| (|:| |val| (|List| |#4|))
                                            (|:| |tower| |#5|))
                                  (|Record| (|:| |val| (|List| |#4|))
                                            (|:| |tower| |#5|))))
                                T)
                              '((|removeSuperfluousCases|
                                 ((|List|
                                   (|Record| (|:| |val| (|List| |#4|))
                                             (|:| |tower| |#5|)))
                                  (|List|
                                   (|Record| (|:| |val| (|List| |#4|))
                                             (|:| |tower| |#5|)))))
                                T)
                              '((|prepareDecompose|
                                 ((|List|
                                   (|Record| (|:| |eq| (|List| |#4|))
                                             (|:| |tower| |#5|)
                                             (|:| |ineq| (|List| |#4|))))
                                  (|List| |#4|) (|List| |#5|) (|Boolean|)
                                  (|Boolean|)))
                                T)
                              '((|branchIfCan|
                                 ((|Union|
                                   (|Record| (|:| |eq| (|List| |#4|))
                                             (|:| |tower| |#5|)
                                             (|:| |ineq| (|List| |#4|)))
                                   "failed")
                                  (|List| |#4|) |#5| (|List| |#4|) (|Boolean|)
                                  (|Boolean|) (|Boolean|) (|Boolean|)
                                  (|Boolean|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 102
                                            '(1 12 11 9 13 2 11 0 0 0 14 2 9 15
                                              0 0 16 1 11 0 0 17 2 11 0 18 0 19
                                              0 22 20 23 1 24 15 0 25 2 22 20
                                              24 24 26 1 22 20 24 27 0 20 0 28
                                              0 22 15 30 0 22 20 31 0 22 20 32
                                              1 10 34 0 35 1 10 11 0 36 1 38 0
                                              0 39 2 38 0 40 0 41 1 10 15 0 43
                                              1 9 8 0 44 2 10 15 8 0 45 1 10 8
                                              0 47 2 8 15 0 0 48 2 8 15 0 0 49
                                              1 10 50 0 51 1 10 53 0 54 2 9 15
                                              0 0 55 2 9 15 0 0 56 1 9 34 0 64
                                              2 10 53 0 8 65 2 10 9 9 0 66 1 9
                                              15 0 67 1 10 11 0 68 2 10 15 9 0
                                              69 2 0 70 10 10 71 2 10 9 9 0 72
                                              1 22 70 21 73 2 22 20 21 15 74 2
                                              77 0 76 0 78 2 77 0 0 0 79 2 38 0
                                              0 0 81 1 9 0 0 83 2 11 0 84 0 85
                                              1 9 15 0 86 2 11 15 84 0 87 1 12
                                              11 11 88 1 89 0 11 90 2 89 91 9 0
                                              92 2 8 15 0 0 93 2 9 0 0 0 94 2 9
                                              50 0 0 95 2 100 0 99 0 101 2 0 15
                                              10 10 37 2 0 15 10 10 52 2 0 15
                                              10 38 75 2 0 15 10 10 61 2 0 15
                                              11 11 58 2 0 15 62 62 63 0 0 20
                                              33 3 0 20 24 24 24 29 1 0 38 38
                                              82 1 0 77 77 80 4 0 100 11 38 15
                                              15 102 2 0 15 10 10 46 2 0 70 10
                                              10 71 2 0 15 11 11 57 2 0 15 11
                                              11 59 2 0 15 11 11 60 8 0 97 11
                                              10 11 15 15 15 15 15 98 1 0 38 38
                                              42)))))
           '|lookupComplete|)) 

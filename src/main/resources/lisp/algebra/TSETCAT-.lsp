
(SDEFUN |TSETCAT-;=;2SB;1| ((|ts| (S)) (|us| (S)) ($ (|Boolean|)))
        (SPROG ((#1=#:G775 NIL) (#2=#:G772 NIL))
               (COND
                ((SPADCALL |ts| (QREFELT $ 12)) (SPADCALL |us| (QREFELT $ 12)))
                ((OR (SPADCALL |us| (QREFELT $ 12))
                     (NULL
                      (SPADCALL
                       (PROG2 (LETT #2# (SPADCALL |ts| (QREFELT $ 14)))
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0) (QREFELT $ 10)
                                         (|Union| (QREFELT $ 10) #3="failed")
                                         #2#))
                       (PROG2 (LETT #2# (SPADCALL |us| (QREFELT $ 14)))
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0) (QREFELT $ 10)
                                         (|Union| (QREFELT $ 10) #3#) #2#))
                       (QREFELT $ 15))))
                 NIL)
                ('T
                 (SPADCALL
                  (PROG2 (LETT #1# (SPADCALL |ts| (QREFELT $ 17)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                    (|Union| (QREFELT $ 6) #4="failed") #1#))
                  (PROG2 (LETT #1# (SPADCALL |us| (QREFELT $ 17)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                    (|Union| (QREFELT $ 6) #4#) #1#))
                  (QREFELT $ 18)))))) 

(SDEFUN |TSETCAT-;infRittWu?;2SB;2| ((|ts| (S)) (|us| (S)) ($ (|Boolean|)))
        (SPROG ((|v| (V)) (|q| (P)) (#1=#:G783 NIL) (|p| (P)))
               (SEQ
                (COND
                 ((SPADCALL |us| (QREFELT $ 12))
                  (NULL (SPADCALL |ts| (QREFELT $ 12))))
                 ((SPADCALL |ts| (QREFELT $ 12)) NIL)
                 (#2='T
                  (SEQ
                   (LETT |p|
                         (PROG2 (LETT #1# (SPADCALL |ts| (QREFELT $ 20)))
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0) (QREFELT $ 10)
                                           (|Union| (QREFELT $ 10) #3="failed")
                                           #1#)))
                   (LETT |q|
                         (PROG2 (LETT #1# (SPADCALL |us| (QREFELT $ 20)))
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0) (QREFELT $ 10)
                                           (|Union| (QREFELT $ 10) #3#) #1#)))
                   (EXIT
                    (COND ((SPADCALL |p| |q| (QREFELT $ 21)) 'T)
                          ((SPADCALL |p| |q| (QREFELT $ 22)) NIL)
                          (#2#
                           (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 23)))
                                (EXIT
                                 (SPADCALL (SPADCALL |ts| |v| (QREFELT $ 24))
                                           (SPADCALL |us| |v| (QREFELT $ 24))
                                           (QREFELT $ 25))))))))))))) 

(SDEFUN |TSETCAT-;reduced?;PSMB;3|
        ((|p| (P)) (|ts| (S)) (|redOp?| (|Mapping| (|Boolean|) P P))
         ($ (|Boolean|)))
        (SPROG ((|lp| (|List| P)))
               (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 28)))
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((NULL |lp|) NIL)
                                  ('T
                                   (SPADCALL |p| (|SPADfirst| |lp|)
                                             |redOp?|))))
                           (GO G191)))
                         (SEQ (EXIT (LETT |lp| (CDR |lp|)))) NIL (GO G190) G191
                         (EXIT NIL))
                    (EXIT (NULL |lp|))))) 

(SDEFUN |TSETCAT-;basicSet;LMU;4|
        ((|ps| (|List| P)) (|redOp?| (|Mapping| (|Boolean|) P P))
         ($
          (|Union| (|Record| (|:| |bas| S) (|:| |top| (|List| P))) "failed")))
        (SPROG ((|ts| (|List| P)) (|p| (P)) (|bs| (S)) (|b| (P)))
               (SEQ (LETT |ps| (SPADCALL (ELT $ 31) |ps| (QREFELT $ 33)))
                    (EXIT
                     (COND
                      ((SPADCALL (ELT $ 34) |ps| (QREFELT $ 35))
                       (CONS 1 "failed"))
                      ('T
                       (SEQ
                        (LETT |ps| (SPADCALL (ELT $ 21) |ps| (QREFELT $ 36)))
                        (LETT |bs| (SPADCALL (QREFELT $ 37))) (LETT |ts| NIL)
                        (SEQ G190 (COND ((NULL (NULL (NULL |ps|))) (GO G191)))
                             (SEQ (LETT |b| (|SPADfirst| |ps|))
                                  (LETT |bs|
                                        (SPADCALL |bs| |b| (QREFELT $ 38)))
                                  (LETT |ps| (CDR |ps|))
                                  (EXIT
                                   (SEQ G190
                                        (COND
                                         ((NULL
                                           (COND ((NULL |ps|) NIL)
                                                 ('T
                                                  (NULL
                                                   (SPADCALL
                                                    (LETT |p|
                                                          (|SPADfirst| |ps|))
                                                    |bs| |redOp?|
                                                    (QREFELT $ 39))))))
                                          (GO G191)))
                                        (SEQ (LETT |ts| (CONS |p| |ts|))
                                             (EXIT (LETT |ps| (CDR |ps|))))
                                        NIL (GO G190) G191 (EXIT NIL))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (EXIT (CONS 0 (CONS |bs| |ts|)))))))))) 

(SDEFUN |TSETCAT-;basicSet;LMMU;5|
        ((|ps| (|List| P)) (|pred?| (|Mapping| (|Boolean|) P))
         (|redOp?| (|Mapping| (|Boolean|) P P))
         ($
          (|Union| (|Record| (|:| |bas| S) (|:| |top| (|List| P))) "failed")))
        (SPROG
         ((|ts| (|List| P)) (|gps| (|List| P)) (|p| (P)) (|bs| (S)) (|b| (P))
          (|bps| (|List| P)))
         (SEQ (LETT |ps| (SPADCALL (ELT $ 31) |ps| (QREFELT $ 33)))
              (EXIT
               (COND
                ((SPADCALL (ELT $ 34) |ps| (QREFELT $ 35)) (CONS 1 "failed"))
                ('T
                 (SEQ (LETT |gps| NIL) (LETT |bps| NIL)
                      (SEQ G190 (COND ((NULL (NULL (NULL |ps|))) (GO G191)))
                           (SEQ (LETT |p| (|SPADfirst| |ps|))
                                (LETT |ps| (CDR |ps|))
                                (EXIT
                                 (COND
                                  ((SPADCALL |p| |pred?|)
                                   (LETT |gps| (CONS |p| |gps|)))
                                  ('T (LETT |bps| (CONS |p| |bps|))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |gps| (SPADCALL (ELT $ 21) |gps| (QREFELT $ 36)))
                      (LETT |bs| (SPADCALL (QREFELT $ 37))) (LETT |ts| NIL)
                      (SEQ G190 (COND ((NULL (NULL (NULL |gps|))) (GO G191)))
                           (SEQ (LETT |b| (|SPADfirst| |gps|))
                                (LETT |bs| (SPADCALL |bs| |b| (QREFELT $ 38)))
                                (LETT |gps| (CDR |gps|))
                                (EXIT
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (COND ((NULL |gps|) NIL)
                                               ('T
                                                (NULL
                                                 (SPADCALL
                                                  (LETT |p|
                                                        (|SPADfirst| |gps|))
                                                  |bs| |redOp?|
                                                  (QREFELT $ 39))))))
                                        (GO G191)))
                                      (SEQ (LETT |ts| (CONS |p| |ts|))
                                           (EXIT (LETT |gps| (CDR |gps|))))
                                      NIL (GO G190) G191 (EXIT NIL))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |ts|
                            (SPADCALL (ELT $ 21)
                                      (SPADCALL |ts| |bps| (QREFELT $ 43))
                                      (QREFELT $ 36)))
                      (EXIT (CONS 0 (CONS |bs| |ts|)))))))))) 

(SDEFUN |TSETCAT-;initials;SL;6| ((|ts| (S)) ($ (|List| P)))
        (SPROG ((|lp| (|List| P)) (|lip| (|List| P)) (|ip| (P)) (|p| (P)))
               (SEQ (LETT |lip| NIL)
                    (EXIT
                     (COND ((SPADCALL |ts| (QREFELT $ 12)) |lip|)
                           ('T
                            (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 28)))
                                 (SEQ G190
                                      (COND
                                       ((NULL (NULL (NULL |lp|))) (GO G191)))
                                      (SEQ (LETT |p| (|SPADfirst| |lp|))
                                           (COND
                                            ((NULL
                                              (SPADCALL
                                               (LETT |ip|
                                                     (SPADCALL |p|
                                                               (QREFELT $ 45)))
                                               (QREFELT $ 34)))
                                             (LETT |lip|
                                                   (CONS
                                                    (SPADCALL |ip|
                                                              (QREFELT $ 46))
                                                    |lip|))))
                                           (EXIT (LETT |lp| (CDR |lp|))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (EXIT (SPADCALL |lip| (QREFELT $ 47)))))))))) 

(SDEFUN |TSETCAT-;degree;SNni;7| ((|ts| (S)) ($ (|NonNegativeInteger|)))
        (SPROG ((|d| (|NonNegativeInteger|)) (|lp| (|List| P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 12)) 0)
                      ('T
                       (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 28)))
                            (LETT |d|
                                  (SPADCALL (|SPADfirst| |lp|) (QREFELT $ 50)))
                            (SEQ G190
                                 (COND
                                  ((NULL (NULL (NULL (LETT |lp| (CDR |lp|)))))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |d|
                                         (* |d|
                                            (SPADCALL (|SPADfirst| |lp|)
                                                      (QREFELT $ 50))))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT |d|))))))) 

(SDEFUN |TSETCAT-;quasiComponent;SR;8|
        ((|ts| (S))
         ($ (|Record| (|:| |close| (|List| P)) (|:| |open| (|List| P)))))
        (CONS (SPADCALL |ts| (QREFELT $ 28)) (SPADCALL |ts| (QREFELT $ 52)))) 

(SDEFUN |TSETCAT-;normalized?;PSB;9| ((|p| (P)) (|ts| (S)) ($ (|Boolean|)))
        (SPADCALL |p| (SPADCALL |ts| (QREFELT $ 28)) (QREFELT $ 56))) 

(SDEFUN |TSETCAT-;stronglyReduced?;PSB;10|
        ((|p| (P)) (|ts| (S)) ($ (|Boolean|)))
        (SPADCALL |p| (SPADCALL |ts| (QREFELT $ 28)) (QREFELT $ 58))) 

(SDEFUN |TSETCAT-;headReduced?;PSB;11| ((|p| (P)) (|ts| (S)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 60)) |ts| (QREFELT $ 61))) 

(SDEFUN |TSETCAT-;initiallyReduced?;PSB;12|
        ((|p| (P)) (|ts| (S)) ($ (|Boolean|)))
        (SPROG ((|red| (|Boolean|)) (|lp| (|List| P)))
               (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 28))) (LETT |red| 'T)
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND
                             ((OR (NULL |lp|) (SPADCALL |p| (QREFELT $ 34)))
                              NIL)
                             ('T |red|)))
                           (GO G191)))
                         (SEQ
                          (SEQ G190
                               (COND
                                ((NULL
                                  (COND ((NULL |lp|) NIL)
                                        ('T
                                         (SPADCALL
                                          (SPADCALL (|SPADfirst| |lp|)
                                                    (QREFELT $ 23))
                                          (SPADCALL |p| (QREFELT $ 23))
                                          (QREFELT $ 63)))))
                                 (GO G191)))
                               (SEQ (EXIT (LETT |lp| (CDR |lp|)))) NIL
                               (GO G190) G191 (EXIT NIL))
                          (EXIT
                           (COND
                            ((NULL (NULL |lp|))
                             (COND
                              ((SPADCALL
                                (SPADCALL (|SPADfirst| |lp|) (QREFELT $ 23))
                                (SPADCALL |p| (QREFELT $ 23)) (QREFELT $ 64))
                               (COND
                                ((SPADCALL |p| (|SPADfirst| |lp|)
                                           (QREFELT $ 65))
                                 (SEQ (LETT |lp| (CDR |lp|))
                                      (EXIT
                                       (LETT |p|
                                             (SPADCALL |p| (QREFELT $ 45))))))
                                ('T (LETT |red| NIL))))
                              ('T
                               (LETT |p| (SPADCALL |p| (QREFELT $ 45)))))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |red|)))) 

(SDEFUN |TSETCAT-;reduce;PSMMP;13|
        ((|p| (P)) (|ts| (S)) (|redOp| (|Mapping| P P P))
         (|redOp?| (|Mapping| (|Boolean|) P P)) ($ (P)))
        (SPROG ((#1=#:G906 NIL) (|reductor| (P)) (#2=#:G903 NIL) (|ts0| (S)))
               (SEQ
                (COND
                 ((OR (SPADCALL |ts| (QREFELT $ 12))
                      (SPADCALL |p| (QREFELT $ 34)))
                  |p|)
                 ('T
                  (SEQ (LETT |ts0| |ts|)
                       (SEQ G190
                            (COND
                             ((NULL
                               (COND ((SPADCALL |ts| (QREFELT $ 12)) NIL)
                                     ('T
                                      (NULL (SPADCALL |p| (QREFELT $ 34))))))
                              (GO G191)))
                            (SEQ
                             (LETT |reductor|
                                   (PROG2
                                       (LETT #2#
                                             (SPADCALL |ts| (QREFELT $ 14)))
                                       (QCDR #2#)
                                     (|check_union2| (QEQCAR #2# 0)
                                                     (QREFELT $ 10)
                                                     (|Union| (QREFELT $ 10)
                                                              "failed")
                                                     #2#)))
                             (LETT |ts|
                                   (PROG2
                                       (LETT #1#
                                             (SPADCALL |ts| (QREFELT $ 17)))
                                       (QCDR #1#)
                                     (|check_union2| (QEQCAR #1# 0)
                                                     (QREFELT $ 6)
                                                     (|Union| (QREFELT $ 6)
                                                              "failed")
                                                     #1#)))
                             (EXIT
                              (COND
                               ((NULL (SPADCALL |p| |reductor| |redOp?|))
                                (SEQ
                                 (LETT |p| (SPADCALL |p| |reductor| |redOp|))
                                 (EXIT (LETT |ts| |ts0|)))))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT |p|))))))) 

(SDEFUN |TSETCAT-;rewriteSetWithReduction;LSMML;14|
        ((|lp| (|List| P)) (|ts| (S)) (|redOp| (|Mapping| P P P))
         (|redOp?| (|Mapping| (|Boolean|) P P)) ($ (|List| P)))
        (SPROG ((|rs| (|List| P)) (|p| (P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 69)) |lp|)
                      (#1='T
                       (SEQ
                        (LETT |lp| (SPADCALL (ELT $ 31) |lp| (QREFELT $ 33)))
                        (EXIT
                         (COND ((NULL |lp|) |lp|)
                               ((SPADCALL (ELT $ 34) |lp| (QREFELT $ 35))
                                (LIST (|spadConstant| $ 70)))
                               (#1#
                                (SEQ (LETT |rs| NIL)
                                     (SEQ G190
                                          (COND
                                           ((NULL (NULL (NULL |lp|)))
                                            (GO G191)))
                                          (SEQ (LETT |p| (|SPADfirst| |lp|))
                                               (LETT |lp| (CDR |lp|))
                                               (LETT |p|
                                                     (SPADCALL
                                                      (SPADCALL |p| |ts|
                                                                |redOp|
                                                                |redOp?|
                                                                (QREFELT $ 71))
                                                      (QREFELT $ 46)))
                                               (EXIT
                                                (COND
                                                 ((NULL
                                                   (SPADCALL |p|
                                                             (QREFELT $ 31)))
                                                  (COND
                                                   ((SPADCALL |p|
                                                              (QREFELT $ 34))
                                                    (SEQ (LETT |lp| NIL)
                                                         (EXIT
                                                          (LETT |rs|
                                                                (LIST
                                                                 (|spadConstant|
                                                                  $ 70))))))
                                                   ('T
                                                    (LETT |rs|
                                                          (CONS |p|
                                                                |rs|))))))))
                                          NIL (GO G190) G191 (EXIT NIL))
                                     (EXIT
                                      (SPADCALL |rs| (QREFELT $ 47))))))))))))) 

(SDEFUN |TSETCAT-;stronglyReduce;PSP;15| ((|p| (P)) (|ts| (S)) ($ (P)))
        (SPADCALL |p| |ts| (ELT $ 73) (ELT $ 65) (QREFELT $ 71))) 

(SDEFUN |TSETCAT-;headReduce;PSP;16| ((|p| (P)) (|ts| (S)) ($ (P)))
        (SPADCALL |p| |ts| (ELT $ 75) (ELT $ 76) (QREFELT $ 71))) 

(SDEFUN |TSETCAT-;initiallyReduce;PSP;17| ((|p| (P)) (|ts| (S)) ($ (P)))
        (SPADCALL |p| |ts| (ELT $ 78) (ELT $ 79) (QREFELT $ 71))) 

(SDEFUN |TSETCAT-;removeZero;PSP;18| ((|p| (P)) (|ts| (S)) ($ (P)))
        (SPROG
         ((|q| (P)) (#1=#:G963 NIL) (#2=#:G951 NIL) (|ts_v-| (S)) (|v| (V)))
         (SEQ
          (EXIT
           (COND
            ((OR (SPADCALL |p| (QREFELT $ 34)) (SPADCALL |ts| (QREFELT $ 12)))
             |p|)
            ('T
             (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 23)))
                  (LETT |ts_v-| (SPADCALL |ts| |v| (QREFELT $ 81)))
                  (COND
                   ((SPADCALL |v| |ts| (QREFELT $ 82))
                    (SEQ
                     (LETT |q|
                           (SPADCALL |p|
                                     (PROG2
                                         (LETT #2#
                                               (SPADCALL |ts| |v|
                                                         (QREFELT $ 83)))
                                         (QCDR #2#)
                                       (|check_union2| (QEQCAR #2# 0)
                                                       (QREFELT $ 10)
                                                       (|Union| (QREFELT $ 10)
                                                                "failed")
                                                       #2#))
                                     (QREFELT $ 73)))
                     (EXIT
                      (COND
                       ((SPADCALL |q| (QREFELT $ 31))
                        (PROGN (LETT #1# |q|) (GO #3=#:G962)))
                       ((SPADCALL (SPADCALL |q| |ts_v-| (QREFELT $ 84))
                                  (QREFELT $ 31))
                        (PROGN (LETT #1# (|spadConstant| $ 85)) (GO #3#))))))))
                  (EXIT
                   (COND ((SPADCALL |ts_v-| (QREFELT $ 12)) |p|)
                         ('T
                          (SEQ (LETT |q| (|spadConstant| $ 85))
                               (SEQ G190
                                    (COND
                                     ((NULL
                                       (PLUSP
                                        (SPADCALL |p| |v| (QREFELT $ 86))))
                                      (GO G191)))
                                    (SEQ
                                     (LETT |q|
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |p| (QREFELT $ 45))
                                              |ts_v-| (QREFELT $ 84))
                                             (SPADCALL |p| (QREFELT $ 87))
                                             (QREFELT $ 88))
                                            |q| (QREFELT $ 89)))
                                     (EXIT
                                      (LETT |p|
                                            (SPADCALL |p| (QREFELT $ 90)))))
                                    NIL (GO G190) G191 (EXIT NIL))
                               (EXIT
                                (SPADCALL |q|
                                          (SPADCALL |p| |ts_v-| (QREFELT $ 84))
                                          (QREFELT $ 89)))))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |TSETCAT-;reduceByQuasiMonic;PSP;19| ((|p| (P)) (|ts| (S)) ($ (P)))
        (COND
         ((OR (SPADCALL |p| (QREFELT $ 34)) (SPADCALL |ts| (QREFELT $ 12)))
          |p|)
         ('T
          (QVELT (SPADCALL |p| (SPADCALL |ts| (QREFELT $ 92)) (QREFELT $ 94))
                 1)))) 

(SDEFUN |TSETCAT-;autoReduced?;SMB;20|
        ((|ts| (S)) (|redOp?| (|Mapping| (|Boolean|) P (|List| P)))
         ($ (|Boolean|)))
        (SPROG ((|lp| (|List| P)) (|p| (P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 12)) 'T)
                      ('T
                       (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 28)))
                            (LETT |p| (|SPADfirst| |lp|))
                            (LETT |lp| (CDR |lp|))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND ((NULL |lp|) NIL)
                                          ('T (SPADCALL |p| |lp| |redOp?|))))
                                   (GO G191)))
                                 (SEQ (LETT |p| (|SPADfirst| |lp|))
                                      (EXIT (LETT |lp| (CDR |lp|))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT (NULL |lp|)))))))) 

(SDEFUN |TSETCAT-;stronglyReduced?;SB;21| ((|ts| (S)) ($ (|Boolean|)))
        (SPADCALL |ts| (ELT $ 58) (QREFELT $ 98))) 

(SDEFUN |TSETCAT-;normalized?;SB;22| ((|ts| (S)) ($ (|Boolean|)))
        (SPADCALL |ts| (ELT $ 56) (QREFELT $ 98))) 

(SDEFUN |TSETCAT-;headReduced?;SB;23| ((|ts| (S)) ($ (|Boolean|)))
        (SPADCALL |ts| (ELT $ 101) (QREFELT $ 98))) 

(SDEFUN |TSETCAT-;initiallyReduced?;SB;24| ((|ts| (S)) ($ (|Boolean|)))
        (SPADCALL |ts| (ELT $ 103) (QREFELT $ 98))) 

(SDEFUN |TSETCAT-;mvar;SV;25| ((|ts| (S)) ($ (V)))
        (SPROG ((#1=#:G990 NIL))
               (COND
                ((SPADCALL |ts| (QREFELT $ 12))
                 (|error| "Error from TSETCAT in mvar : #1 is empty"))
                ('T
                 (SPADCALL
                  (PROG2 (LETT #1# (SPADCALL |ts| (QREFELT $ 14)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0) (QREFELT $ 10)
                                    (|Union| (QREFELT $ 10) "failed") #1#))
                  (QREFELT $ 23)))))) 

(SDEFUN |TSETCAT-;first;SU;26| ((|ts| (S)) ($ (|Union| P "failed")))
        (SPROG ((|lp| (|List| P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 12)) (CONS 1 "failed"))
                      ('T
                       (SEQ
                        (LETT |lp|
                              (SPADCALL (ELT $ 22)
                                        (SPADCALL |ts| (QREFELT $ 28))
                                        (QREFELT $ 36)))
                        (EXIT (CONS 0 (|SPADfirst| |lp|))))))))) 

(SDEFUN |TSETCAT-;last;SU;27| ((|ts| (S)) ($ (|Union| P "failed")))
        (SPROG ((|lp| (|List| P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 12)) (CONS 1 "failed"))
                      ('T
                       (SEQ
                        (LETT |lp|
                              (SPADCALL (ELT $ 21)
                                        (SPADCALL |ts| (QREFELT $ 28))
                                        (QREFELT $ 36)))
                        (EXIT (CONS 0 (|SPADfirst| |lp|))))))))) 

(SDEFUN |TSETCAT-;rest;SU;28| ((|ts| (S)) ($ (|Union| S "failed")))
        (SPROG ((|lp| (|List| P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 12)) (CONS 1 "failed"))
                      ('T
                       (SEQ
                        (LETT |lp|
                              (SPADCALL (ELT $ 22)
                                        (SPADCALL |ts| (QREFELT $ 28))
                                        (QREFELT $ 36)))
                        (EXIT
                         (CONS 0 (SPADCALL (CDR |lp|) (QREFELT $ 108)))))))))) 

(SDEFUN |TSETCAT-;coerce;SL;29| ((|ts| (S)) ($ (|List| P)))
        (SPADCALL (ELT $ 22) (SPADCALL |ts| (QREFELT $ 28)) (QREFELT $ 36))) 

(SDEFUN |TSETCAT-;algebraicVariables;SL;30| ((|ts| (S)) ($ (|List| V)))
        (SPROG ((#1=#:G1025 NIL) (|p| NIL) (#2=#:G1024 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |p| NIL) (LETT #1# (SPADCALL |ts| (QREFELT $ 28)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |p| (QREFELT $ 23)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |TSETCAT-;algebraic?;VSB;31| ((|v| (V)) (|ts| (S)) ($ (|Boolean|)))
        (SPADCALL |v| (SPADCALL |ts| (QREFELT $ 113)) (QREFELT $ 114))) 

(SDEFUN |TSETCAT-;select;SVU;32|
        ((|ts| (S)) (|v| (V)) ($ (|Union| P "failed")))
        (SPROG ((|lp| (|List| P)))
               (SEQ
                (LETT |lp|
                      (SPADCALL (ELT $ 22) (SPADCALL |ts| (QREFELT $ 28))
                                (QREFELT $ 36)))
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((NULL |lp|) NIL)
                              ('T
                               (NULL
                                (SPADCALL |v|
                                          (SPADCALL (|SPADfirst| |lp|)
                                                    (QREFELT $ 23))
                                          (QREFELT $ 64))))))
                       (GO G191)))
                     (SEQ (EXIT (LETT |lp| (CDR |lp|)))) NIL (GO G190) G191
                     (EXIT NIL))
                (EXIT
                 (COND ((NULL |lp|) (CONS 1 "failed"))
                       ('T (CONS 0 (|SPADfirst| |lp|)))))))) 

(SDEFUN |TSETCAT-;collectQuasiMonic;2S;33| ((|ts| (S)) ($ (S)))
        (SPROG ((|lp| (|List| P)) (|newlp| (|List| P)))
               (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 28)))
                    (LETT |newlp| NIL)
                    (SEQ G190 (COND ((NULL (NULL (NULL |lp|))) (GO G191)))
                         (SEQ
                          (COND
                           ((SPADCALL
                             (SPADCALL (|SPADfirst| |lp|) (QREFELT $ 45))
                             (QREFELT $ 34))
                            (LETT |newlp| (CONS (|SPADfirst| |lp|) |newlp|))))
                          (EXIT (LETT |lp| (CDR |lp|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |newlp| (QREFELT $ 108)))))) 

(SDEFUN |TSETCAT-;collectUnder;SVS;34| ((|ts| (S)) (|v| (V)) ($ (S)))
        (SPROG ((|lp| (|List| P)))
               (SEQ
                (LETT |lp|
                      (SPADCALL (ELT $ 22) (SPADCALL |ts| (QREFELT $ 28))
                                (QREFELT $ 36)))
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((NULL |lp|) NIL)
                              ('T
                               (NULL
                                (SPADCALL |v|
                                          (SPADCALL (|SPADfirst| |lp|)
                                                    (QREFELT $ 23))
                                          (QREFELT $ 63))))))
                       (GO G191)))
                     (SEQ (EXIT (LETT |lp| (CDR |lp|)))) NIL (GO G190) G191
                     (EXIT NIL))
                (EXIT (SPADCALL |lp| (QREFELT $ 108)))))) 

(SDEFUN |TSETCAT-;collectUpper;SVS;35| ((|ts| (S)) (|v| (V)) ($ (S)))
        (SPROG ((|lp1| (|List| P)) (|lp2| (|List| P)))
               (SEQ
                (LETT |lp1|
                      (SPADCALL (ELT $ 22) (SPADCALL |ts| (QREFELT $ 28))
                                (QREFELT $ 36)))
                (LETT |lp2| NIL)
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((NULL |lp1|) NIL)
                              ('T
                               (SPADCALL
                                (SPADCALL (|SPADfirst| |lp1|) (QREFELT $ 23))
                                |v| (QREFELT $ 63)))))
                       (GO G191)))
                     (SEQ (LETT |lp2| (CONS (|SPADfirst| |lp1|) |lp2|))
                          (EXIT (LETT |lp1| (CDR |lp1|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (SPADCALL (REVERSE |lp2|) (QREFELT $ 108)))))) 

(SDEFUN |TSETCAT-;construct;LS;36| ((|lp| (|List| P)) ($ (S)))
        (SPROG ((|rif| (|Union| S "failed")))
               (SEQ (LETT |rif| (SPADCALL |lp| (QREFELT $ 120)))
                    (EXIT
                     (COND ((QEQCAR |rif| 0) (QCDR |rif|))
                           ('T
                            (|error|
                             "in construct : LP -> % from TSETCAT : bad arg"))))))) 

(SDEFUN |TSETCAT-;retractIfCan;LU;37|
        ((|lp| (|List| P)) ($ (|Union| S #1="failed")))
        (SPROG ((|rif| (|Union| S #1#)))
               (SEQ
                (COND ((NULL |lp|) (CONS 0 (SPADCALL (QREFELT $ 37))))
                      (#2='T
                       (SEQ
                        (LETT |lp| (SPADCALL (ELT $ 22) |lp| (QREFELT $ 36)))
                        (LETT |rif| (SPADCALL (CDR |lp|) (QREFELT $ 120)))
                        (EXIT
                         (COND
                          ((QEQCAR |rif| 0)
                           (SPADCALL (QCDR |rif|) (|SPADfirst| |lp|)
                                     (QREFELT $ 122)))
                          (#2#
                           (|error|
                            "in retractIfCan : LP -> ... from TSETCAT : bad arg")))))))))) 

(SDEFUN |TSETCAT-;extend;SPS;38| ((|ts| (S)) (|p| (P)) ($ (S)))
        (SPROG ((|eif| (|Union| S "failed")))
               (SEQ (LETT |eif| (SPADCALL |ts| |p| (QREFELT $ 122)))
                    (EXIT
                     (COND ((QEQCAR |eif| 0) (QCDR |eif|))
                           ('T
                            (|error|
                             "in extend : (%, P) -> % from TSETCAT : bad args"))))))) 

(SDEFUN |TSETCAT-;coHeight;SNni;39| ((|ts| (S)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G1080 NIL) (|m| (|NonNegativeInteger|))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL (QREFELT $ 125)))
              (LETT |m| (LENGTH (SPADCALL |ts| (QREFELT $ 28))))
              (EXIT
               (PROG2 (LETT #1# (SPADCALL |n| |m| (QREFELT $ 126)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (|NonNegativeInteger|)
                                 (|Union| (|NonNegativeInteger|) "failed")
                                 #1#)))))) 

(DECLAIM (NOTINLINE |TriangularSetCategory&;|)) 

(DEFUN |TriangularSetCategory&| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|TriangularSetCategory&| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 129))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#4| '(|Finite|))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 127
                (CONS (|dispatchFunction| |TSETCAT-;coHeight;SNni;39|) $))))
    $))) 

(MAKEPROP '|TriangularSetCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|Boolean|)
              (0 . |empty?|) (|Union| 10 '#1="failed") (5 . |first|) (10 . =)
              (|Union| $ '#2="failed") (16 . |rest|) (21 . =)
              |TSETCAT-;=;2SB;1| (27 . |last|) (32 . |infRittWu?|)
              (38 . |supRittWu?|) (44 . |mvar|) (49 . |collectUpper|)
              (55 . |infRittWu?|) |TSETCAT-;infRittWu?;2SB;2| (|List| 10)
              (61 . |members|) (|Mapping| 11 10 10) |TSETCAT-;reduced?;PSMB;3|
              (66 . |zero?|) (|Mapping| 11 10) (71 . |remove|) (77 . |ground?|)
              (82 . |any?|) (88 . |sort|) (94 . |empty|) (98 . |extend|)
              (104 . |reduced?|) (|Record| (|:| |bas| $) (|:| |top| 27))
              (|Union| 40 '#3="failed") |TSETCAT-;basicSet;LMU;4|
              (111 . |concat|) |TSETCAT-;basicSet;LMMU;5| (117 . |init|)
              (122 . |primPartElseUnitCanonical|) (127 . |removeDuplicates|)
              |TSETCAT-;initials;SL;6| (|NonNegativeInteger|) (132 . |mdeg|)
              |TSETCAT-;degree;SNni;7| (137 . |initials|)
              (|Record| (|:| |close| 27) (|:| |open| 27))
              |TSETCAT-;quasiComponent;SR;8| (|List| $) (142 . |normalized?|)
              |TSETCAT-;normalized?;PSB;9| (148 . |reduced?|)
              |TSETCAT-;stronglyReduced?;PSB;10| (154 . |head|)
              (159 . |stronglyReduced?|) |TSETCAT-;headReduced?;PSB;11|
              (165 . >) (171 . =) (177 . |reduced?|)
              |TSETCAT-;initiallyReduced?;PSB;12| (|Mapping| 10 10 10)
              |TSETCAT-;reduce;PSMMP;13| (183 . |trivialIdeal?|) (188 . |One|)
              (192 . |reduce|) |TSETCAT-;rewriteSetWithReduction;LSMML;14|
              (200 . |lazyPrem|) |TSETCAT-;stronglyReduce;PSP;15|
              (206 . |headReduce|) (212 . |headReduced?|)
              |TSETCAT-;headReduce;PSP;16| (218 . |initiallyReduce|)
              (224 . |initiallyReduced?|) |TSETCAT-;initiallyReduce;PSP;17|
              (230 . |collectUnder|) (236 . |algebraic?|) (242 . |select|)
              (248 . |removeZero|) (254 . |Zero|) (258 . |degree|)
              (264 . |mainMonomial|) (269 . *) (275 . +) (281 . |tail|)
              |TSETCAT-;removeZero;PSP;18| (286 . |collectQuasiMonic|)
              (|Record| (|:| |rnum| 7) (|:| |polnum| 10) (|:| |den| 7))
              (291 . |remainder|) |TSETCAT-;reduceByQuasiMonic;PSP;19|
              (|Mapping| 11 10 27) |TSETCAT-;autoReduced?;SMB;20|
              (297 . |autoReduced?|) |TSETCAT-;stronglyReduced?;SB;21|
              |TSETCAT-;normalized?;SB;22| (303 . |headReduced?|)
              |TSETCAT-;headReduced?;SB;23| (309 . |initiallyReduced?|)
              |TSETCAT-;initiallyReduced?;SB;24| |TSETCAT-;mvar;SV;25|
              |TSETCAT-;first;SU;26| |TSETCAT-;last;SU;27| (315 . |construct|)
              |TSETCAT-;rest;SU;28| |TSETCAT-;coerce;SL;29| (|List| 9)
              |TSETCAT-;algebraicVariables;SL;30| (320 . |algebraicVariables|)
              (325 . |member?|) |TSETCAT-;algebraic?;VSB;31|
              |TSETCAT-;select;SVU;32| |TSETCAT-;collectQuasiMonic;2S;33|
              |TSETCAT-;collectUnder;SVS;34| |TSETCAT-;collectUpper;SVS;35|
              (331 . |retractIfCan|) |TSETCAT-;construct;LS;36|
              (336 . |extendIfCan|) |TSETCAT-;retractIfCan;LU;37|
              |TSETCAT-;extend;SPS;38| (342 . |size|) (346 . |subtractIfCan|)
              (352 . |coHeight|) (|OutputForm|))
           '#(|stronglyReduced?| 357 |stronglyReduce| 368 |select| 374
              |rewriteSetWithReduction| 380 |retractIfCan| 388 |rest| 393
              |removeZero| 398 |reduced?| 404 |reduceByQuasiMonic| 411 |reduce|
              417 |quasiComponent| 425 |normalized?| 430 |mvar| 441 |last| 446
              |initials| 451 |initiallyReduced?| 456 |initiallyReduce| 467
              |infRittWu?| 473 |headReduced?| 479 |headReduce| 490 |first| 496
              |extend| 501 |degree| 507 |construct| 512 |collectUpper| 517
              |collectUnder| 523 |collectQuasiMonic| 529 |coerce| 534
              |coHeight| 539 |basicSet| 544 |autoReduced?| 557
              |algebraicVariables| 563 |algebraic?| 568 = 574)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|coHeight| ((|NonNegativeInteger|) |#1|)) T)
                              '((|extend| (|#1| |#1| |#5|)) T)
                              '((|select| ((|Union| |#5| "failed") |#1| |#4|))
                                T)
                              '((|algebraic?| ((|Boolean|) |#4| |#1|)) T)
                              '((|algebraicVariables| ((|List| |#4|) |#1|)) T)
                              '((|rest| ((|Union| |#1| #2#) |#1|)) T)
                              '((|last| ((|Union| |#5| "failed") |#1|)) T)
                              '((|first| ((|Union| |#5| #1#) |#1|)) T)
                              '((|reduceByQuasiMonic| (|#5| |#5| |#1|)) T)
                              '((|collectQuasiMonic| (|#1| |#1|)) T)
                              '((|removeZero| (|#5| |#5| |#1|)) T)
                              '((|initiallyReduce| (|#5| |#5| |#1|)) T)
                              '((|headReduce| (|#5| |#5| |#1|)) T)
                              '((|stronglyReduce| (|#5| |#5| |#1|)) T)
                              '((|rewriteSetWithReduction|
                                 ((|List| |#5|) (|List| |#5|) |#1|
                                  (|Mapping| |#5| |#5| |#5|)
                                  (|Mapping| (|Boolean|) |#5| |#5|)))
                                T)
                              '((|reduce|
                                 (|#5| |#5| |#1| (|Mapping| |#5| |#5| |#5|)
                                  (|Mapping| (|Boolean|) |#5| |#5|)))
                                T)
                              '((|initiallyReduced?| ((|Boolean|) |#1|)) T)
                              '((|headReduced?| ((|Boolean|) |#1|)) T)
                              '((|stronglyReduced?| ((|Boolean|) |#1|)) T)
                              '((|autoReduced?|
                                 ((|Boolean|) |#1|
                                  (|Mapping| (|Boolean|) |#5| (|List| |#5|))))
                                T)
                              '((|initiallyReduced?| ((|Boolean|) |#5| |#1|))
                                T)
                              '((|headReduced?| ((|Boolean|) |#5| |#1|)) T)
                              '((|stronglyReduced?| ((|Boolean|) |#5| |#1|)) T)
                              '((|reduced?|
                                 ((|Boolean|) |#5| |#1|
                                  (|Mapping| (|Boolean|) |#5| |#5|)))
                                T)
                              '((|normalized?| ((|Boolean|) |#1|)) T)
                              '((|normalized?| ((|Boolean|) |#5| |#1|)) T)
                              '((|quasiComponent|
                                 ((|Record| (|:| |close| (|List| |#5|))
                                            (|:| |open| (|List| |#5|)))
                                  |#1|))
                                T)
                              '((|degree| ((|NonNegativeInteger|) |#1|)) T)
                              '((|initials| ((|List| |#5|) |#1|)) T)
                              '((|basicSet|
                                 ((|Union|
                                   (|Record| (|:| |bas| |#1|)
                                             (|:| |top| (|List| |#5|)))
                                   "failed")
                                  (|List| |#5|) (|Mapping| (|Boolean|) |#5|)
                                  (|Mapping| (|Boolean|) |#5| |#5|)))
                                T)
                              '((|basicSet|
                                 ((|Union|
                                   (|Record| (|:| |bas| |#1|)
                                             (|:| |top| (|List| |#5|)))
                                   #3#)
                                  (|List| |#5|)
                                  (|Mapping| (|Boolean|) |#5| |#5|)))
                                T)
                              '((|infRittWu?| ((|Boolean|) |#1| |#1|)) T)
                              '((|collectUpper| (|#1| |#1| |#4|)) T)
                              '((|collectUnder| (|#1| |#1| |#4|)) T)
                              '((|mvar| (|#4| |#1|)) T)
                              '((|coerce| ((|List| |#5|) |#1|)) T)
                              '((|retractIfCan|
                                 ((|Union| |#1| "failed") (|List| |#5|)))
                                T)
                              '((|coerce| ((|List| |#5|) |#1|)) T)
                              '((|construct| (|#1| (|List| |#5|))) T)
                              '((|reduce|
                                 (|#5| (|Mapping| |#5| |#5| |#5|) |#1|))
                                T)
                              '((|reduce|
                                 (|#5| (|Mapping| |#5| |#5| |#5|) |#1| |#5|))
                                T)
                              '((|select|
                                 (|#1| (|Mapping| (|Boolean|) |#5|) |#1|))
                                T)
                              '((|reduce|
                                 (|#5| (|Mapping| |#5| |#5| |#5|) |#1| |#5|
                                  |#5|))
                                T)
                              '((|coerce| ((|OutputForm|) |#1|)) T)
                              '((= ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 127
                                            '(1 6 11 0 12 1 6 13 0 14 2 10 11 0
                                              0 15 1 6 16 0 17 2 6 11 0 0 18 1
                                              6 13 0 20 2 10 11 0 0 21 2 10 11
                                              0 0 22 1 10 9 0 23 2 6 0 0 9 24 2
                                              6 11 0 0 25 1 6 27 0 28 1 10 11 0
                                              31 2 27 0 32 0 33 1 10 11 0 34 2
                                              27 11 32 0 35 2 27 0 29 0 36 0 6
                                              0 37 2 6 0 0 10 38 3 6 11 10 0 29
                                              39 2 27 0 0 0 43 1 10 0 0 45 1 10
                                              0 0 46 1 27 0 0 47 1 10 49 0 50 1
                                              6 27 0 52 2 10 11 0 55 56 2 10 11
                                              0 55 58 1 10 0 0 60 2 6 11 10 0
                                              61 2 9 11 0 0 63 2 9 11 0 0 64 2
                                              10 11 0 0 65 1 6 11 0 69 0 10 0
                                              70 4 6 10 10 0 67 29 71 2 10 0 0
                                              0 73 2 10 0 0 0 75 2 10 11 0 0 76
                                              2 10 0 0 0 78 2 10 11 0 0 79 2 6
                                              0 0 9 81 2 6 11 9 0 82 2 6 13 0 9
                                              83 2 6 10 10 0 84 0 10 0 85 2 10
                                              49 0 9 86 1 10 0 0 87 2 10 0 0 0
                                              88 2 10 0 0 0 89 1 10 0 0 90 1 6
                                              0 0 92 2 6 93 10 0 94 2 6 11 0 96
                                              98 2 10 11 0 55 101 2 10 11 0 55
                                              103 1 6 0 27 108 1 6 111 0 113 2
                                              111 11 9 0 114 1 6 16 27 120 2 6
                                              16 0 10 122 0 9 49 125 2 49 16 0
                                              0 126 1 0 49 0 127 1 0 11 0 99 2
                                              0 11 10 0 59 2 0 10 10 0 74 2 0
                                              13 0 9 116 4 0 27 27 0 67 29 72 1
                                              0 16 27 123 1 0 16 0 109 2 0 10
                                              10 0 91 3 0 11 10 0 29 30 2 0 10
                                              10 0 95 4 0 10 10 0 67 29 68 1 0
                                              53 0 54 1 0 11 0 100 2 0 11 10 0
                                              57 1 0 9 0 105 1 0 13 0 107 1 0
                                              27 0 48 1 0 11 0 104 2 0 11 10 0
                                              66 2 0 10 10 0 80 2 0 11 0 0 26 1
                                              0 11 0 102 2 0 11 10 0 62 2 0 10
                                              10 0 77 1 0 13 0 106 2 0 0 0 10
                                              124 1 0 49 0 51 1 0 0 27 121 2 0
                                              0 0 9 119 2 0 0 0 9 118 1 0 0 0
                                              117 1 0 27 0 110 1 0 49 0 127 3 0
                                              41 27 32 29 44 2 0 41 27 29 42 2
                                              0 11 0 96 97 1 0 111 0 112 2 0 11
                                              9 0 115 2 0 11 0 0 19)))))
           '|lookupComplete|)) 

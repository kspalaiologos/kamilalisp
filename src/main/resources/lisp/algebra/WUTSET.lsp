
(PUT '|WUTSET;rep| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |WUTSET;rep| ((|s| ($)) ($ (|List| P))) |s|) 

(PUT '|WUTSET;per| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |WUTSET;per| ((|l| (|List| P)) ($ ($))) |l|) 

(SDEFUN |WUTSET;removeAssociates| ((|lp| (|List| P)) ($ (|List| P)))
        (SPROG ((#1=#:G720 NIL) (|p| NIL) (#2=#:G719 NIL))
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
                         (LETT #2# (CONS (SPADCALL |p| (QREFELT $ 10)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 12))))) 

(SDEFUN |WUTSET;medialSetWithTrace|
        ((|ps| (|List| P)) (|redOp?| (|Mapping| (|Boolean|) P P))
         (|redOp| (|Mapping| P P P))
         ($
          (|Union| (|Record| (|:| |bas| $) (|:| |top| (|List| P)))
                   #1="failed")))
        (SPROG
         ((|contradiction| (|Boolean|)) (|rs| #2=(|List| P)) (#3=#:G723 NIL)
          (|bs| ($))
          (|rec|
           (|Union| (|Record| (|:| |bas| $) (|:| |top| (|List| P))) "failed"))
          (|qs| #2#))
         (SEQ (LETT |qs| (SPADCALL |ps| |redOp?| |redOp| (QREFELT $ 16)))
              (LETT |contradiction| (SPADCALL (ELT $ 18) |ps| (QREFELT $ 20)))
              (EXIT
               (COND (|contradiction| (CONS 1 "failed"))
                     (#4='T
                      (SEQ (LETT |rs| |qs|)
                           (SEQ G190
                                (COND
                                 ((NULL
                                   (NULL (OR (NULL |rs|) |contradiction|)))
                                  (GO G191)))
                                (SEQ
                                 (LETT |rec|
                                       (SPADCALL |rs| |redOp?| (QREFELT $ 23)))
                                 (LETT |contradiction| (QEQCAR |rec| 1))
                                 (COND
                                  ((NULL |contradiction|)
                                   (SEQ
                                    (LETT |bs|
                                          (QCAR
                                           (PROG2 (LETT #3# |rec|)
                                               (QCDR #3#)
                                             (|check_union2| (QEQCAR #3# 0)
                                                             (|Record|
                                                              (|:| |bas| $)
                                                              (|:| |top|
                                                                   (|List|
                                                                    (QREFELT $
                                                                             9))))
                                                             (|Union|
                                                              (|Record|
                                                               (|:| |bas| $)
                                                               (|:| |top|
                                                                    (|List|
                                                                     (QREFELT $
                                                                              9))))
                                                              #1#)
                                                             #3#))))
                                    (LETT |rs|
                                          (QCDR
                                           (PROG2 (LETT #3# |rec|)
                                               (QCDR #3#)
                                             (|check_union2| (QEQCAR #3# 0)
                                                             (|Record|
                                                              (|:| |bas| $)
                                                              (|:| |top|
                                                                   (|List|
                                                                    (QREFELT $
                                                                             9))))
                                                             (|Union|
                                                              (|Record|
                                                               (|:| |bas| $)
                                                               (|:| |top|
                                                                    (|List|
                                                                     (QREFELT $
                                                                              9))))
                                                              #1#)
                                                             #3#))))
                                    (LETT |rs|
                                          (SPADCALL |rs| |bs| (QREFELT $ 24)))
                                    (LETT |contradiction|
                                          (COND ((NULL |rs|) NIL)
                                                ('T
                                                 (SPADCALL (|SPADfirst| |rs|)
                                                           (|spadConstant| $
                                                                           25)
                                                           (QREFELT $ 26)))))
                                    (EXIT
                                     (COND
                                      ((NULL (NULL |rs|))
                                       (COND
                                        ((NULL |contradiction|)
                                         (SEQ
                                          (LETT |rs|
                                                (SPADCALL |rs| |bs| |redOp|
                                                          |redOp?|
                                                          (QREFELT $ 27)))
                                          (EXIT
                                           (LETT |contradiction|
                                                 (COND ((NULL |rs|) NIL)
                                                       ('T
                                                        (SPADCALL
                                                         (|SPADfirst| |rs|)
                                                         (|spadConstant| $ 25)
                                                         (QREFELT $
                                                                  26)))))))))))))))
                                 (EXIT
                                  (COND
                                   ((NULL (NULL |rs|))
                                    (COND
                                     ((NULL |contradiction|)
                                      (SEQ
                                       (LETT |rs|
                                             (SPADCALL
                                              (SPADCALL |rs|
                                                        (SPADCALL |bs|
                                                                  (QREFELT $
                                                                           28))
                                                        (QREFELT $ 29))
                                              (QREFELT $ 12)))
                                       (LETT |rs|
                                             (SPADCALL |rs| |redOp?| |redOp|
                                                       (QREFELT $ 16)))
                                       (EXIT
                                        (LETT |contradiction|
                                              (COND ((NULL |rs|) NIL)
                                                    ('T
                                                     (SPADCALL
                                                      (|SPADfirst| |rs|)
                                                      (|spadConstant| $ 25)
                                                      (QREFELT $
                                                               26)))))))))))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (COND (|contradiction| (CONS 1 "failed"))
                                  (#4# (CONS 0 (CONS |bs| |qs|)))))))))))) 

(SDEFUN |WUTSET;medialSet;LMMU;5|
        ((|ps| (|List| P)) (|redOp?| (|Mapping| (|Boolean|) P P))
         (|redOp| (|Mapping| P P P)) ($ (|Union| $ "failed")))
        (SPROG
         ((|foo|
           (|Union| (|Record| (|:| |bas| $) (|:| |top| (|List| P))) "failed")))
         (SEQ
          (LETT |foo| (|WUTSET;medialSetWithTrace| |ps| |redOp?| |redOp| $))
          (EXIT
           (COND ((QEQCAR |foo| 1) (CONS 1 "failed"))
                 ('T (CONS 0 (QCAR (QCDR |foo|))))))))) 

(SDEFUN |WUTSET;medialSet;LU;6| ((|ps| (|List| P)) ($ (|Union| $ "failed")))
        (SPADCALL |ps| (ELT $ 32) (ELT $ 33) (QREFELT $ 31))) 

(SDEFUN |WUTSET;characteristicSetUsingTrace|
        ((|ps| (|List| P)) (|redOp?| (|Mapping| (|Boolean|) P P))
         (|redOp| (|Mapping| P P P)) ($ (|Union| $ "failed")))
        (SPROG
         ((|qs| #1=(|List| P)) (|contradiction| (|Boolean|)) (|rs| #1#)
          (#2=#:G723 NIL) (|ms| ($))
          (|rec|
           (|Union| (|Record| (|:| |bas| $) (|:| |top| (|List| P)))
                    #3="failed")))
         (SEQ (LETT |ps| (|WUTSET;removeAssociates| |ps| $))
              (LETT |ps| (SPADCALL (ELT $ 35) |ps| (QREFELT $ 36)))
              (LETT |contradiction| (SPADCALL (ELT $ 18) |ps| (QREFELT $ 20)))
              (EXIT
               (COND (|contradiction| (CONS 1 "failed"))
                     (#4='T
                      (SEQ (LETT |rs| |ps|) (LETT |qs| |ps|)
                           (SEQ G190
                                (COND
                                 ((NULL
                                   (NULL (OR (NULL |rs|) |contradiction|)))
                                  (GO G191)))
                                (SEQ
                                 (LETT |rec|
                                       (|WUTSET;medialSetWithTrace| |qs|
                                        |redOp?| |redOp| $))
                                 (LETT |contradiction| (QEQCAR |rec| 1))
                                 (EXIT
                                  (COND
                                   ((NULL |contradiction|)
                                    (SEQ
                                     (LETT |ms|
                                           (QCAR
                                            (PROG2 (LETT #2# |rec|)
                                                (QCDR #2#)
                                              (|check_union2| (QEQCAR #2# 0)
                                                              (|Record|
                                                               (|:| |bas| $)
                                                               (|:| |top|
                                                                    (|List|
                                                                     (QREFELT $
                                                                              9))))
                                                              (|Union|
                                                               (|Record|
                                                                (|:| |bas| $)
                                                                (|:| |top|
                                                                     (|List|
                                                                      (QREFELT
                                                                       $ 9))))
                                                               #3#)
                                                              #2#))))
                                     (LETT |qs|
                                           (QCDR
                                            (PROG2 (LETT #2# |rec|)
                                                (QCDR #2#)
                                              (|check_union2| (QEQCAR #2# 0)
                                                              (|Record|
                                                               (|:| |bas| $)
                                                               (|:| |top|
                                                                    (|List|
                                                                     (QREFELT $
                                                                              9))))
                                                              (|Union|
                                                               (|Record|
                                                                (|:| |bas| $)
                                                                (|:| |top|
                                                                     (|List|
                                                                      (QREFELT
                                                                       $ 9))))
                                                               #3#)
                                                              #2#))))
                                     (LETT |qs|
                                           (SPADCALL |qs| |ms| (QREFELT $ 24)))
                                     (LETT |contradiction|
                                           (COND ((NULL |qs|) NIL)
                                                 ('T
                                                  (SPADCALL (|SPADfirst| |qs|)
                                                            (|spadConstant| $
                                                                            25)
                                                            (QREFELT $ 26)))))
                                     (COND
                                      ((NULL |contradiction|)
                                       (SEQ
                                        (LETT |rs|
                                              (SPADCALL |qs| |ms| (ELT $ 37)
                                                        (ELT $ 38)
                                                        (QREFELT $ 27)))
                                        (EXIT
                                         (LETT |contradiction|
                                               (COND ((NULL |rs|) NIL)
                                                     ('T
                                                      (SPADCALL
                                                       (|SPADfirst| |rs|)
                                                       (|spadConstant| $ 25)
                                                       (QREFELT $ 26)))))))))
                                     (EXIT
                                      (COND
                                       ((NULL |contradiction|)
                                        (COND
                                         ((NULL (NULL |rs|))
                                          (LETT |qs|
                                                (SPADCALL
                                                 (SPADCALL |rs|
                                                           (SPADCALL
                                                            (SPADCALL |ms|
                                                                      (QREFELT
                                                                       $ 28))
                                                            |qs|
                                                            (QREFELT $ 29))
                                                           (QREFELT $ 29))
                                                 (QREFELT $ 12)))))))))))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (COND (|contradiction| (CONS 1 "failed"))
                                  (#4# (CONS 0 |ms|))))))))))) 

(SDEFUN |WUTSET;characteristicSet;LMMU;8|
        ((|ps| (|List| P)) (|redOp?| (|Mapping| (|Boolean|) P P))
         (|redOp| (|Mapping| P P P)) ($ (|Union| $ "failed")))
        (|WUTSET;characteristicSetUsingTrace| |ps| |redOp?| |redOp| $)) 

(SDEFUN |WUTSET;characteristicSet;LU;9|
        ((|ps| (|List| P)) ($ (|Union| $ "failed")))
        (SPADCALL |ps| (ELT $ 32) (ELT $ 33) (QREFELT $ 39))) 

(SDEFUN |WUTSET;characteristicSerie;LMML;10|
        ((|ps| (|List| P)) (|redOp?| (|Mapping| (|Boolean|) P P))
         (|redOp| (|Mapping| P P P)) ($ (|List| $)))
        (SPROG
         ((#1=#:G821 NIL) (|ln| (|List| (|SplittingNode| (|List| P) $)))
          (|newps| (|List| P)) (|lics| (|List| P)) (|cs| ($))
          (|charSet?| (|Union| $ "failed"))
          (|esl| (|Union| (|SplittingTree| (|List| P) $) #2="failed"))
          (|a| (|SplittingTree| (|List| P) $)))
         (SEQ
          (LETT |a|
                (SPADCALL
                 (SPADCALL |ps| (SPADCALL (QREFELT $ 41)) (QREFELT $ 43))
                 (QREFELT $ 45)))
          (SEQ G190
               (COND
                ((NULL (QEQCAR (LETT |esl| (SPADCALL |a| (QREFELT $ 46))) 0))
                 (GO G191)))
               (SEQ
                (LETT |ps|
                      (SPADCALL
                       (SPADCALL
                        (PROG2 (LETT #1# |esl|)
                            (QCDR #1#)
                          (|check_union2| (QEQCAR #1# 0)
                                          (|SplittingTree|
                                           (|List| (QREFELT $ 9)) $)
                                          (|Union|
                                           (|SplittingTree|
                                            (|List| (QREFELT $ 9)) $)
                                           #2#)
                                          #1#))
                        (QREFELT $ 47))
                       (QREFELT $ 48)))
                (LETT |charSet?|
                      (|WUTSET;characteristicSetUsingTrace| |ps| |redOp?|
                       |redOp| $))
                (EXIT
                 (COND
                  ((QEQCAR |charSet?| 0)
                   (SEQ (LETT |cs| (QCDR |charSet?|))
                        (LETT |lics| (SPADCALL |cs| (QREFELT $ 49)))
                        (LETT |lics| (SPADCALL |lics| (QREFELT $ 50)))
                        (LETT |lics|
                              (SPADCALL (ELT $ 51) |lics| (QREFELT $ 52)))
                        (EXIT
                         (COND
                          ((NULL |lics|)
                           (SEQ
                            (SPADCALL
                             (PROG2 (LETT #1# |esl|)
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 0)
                                               (|SplittingTree|
                                                (|List| (QREFELT $ 9)) $)
                                               (|Union|
                                                (|SplittingTree|
                                                 (|List| (QREFELT $ 9)) $)
                                                #2#)
                                               #1#))
                             (SPADCALL |ps| |cs| 'T (QREFELT $ 53))
                             (QREFELT $ 54))
                            (EXIT (SPADCALL |a| (QREFELT $ 55)))))
                          ('T
                           (SEQ
                            (LETT |ln|
                                  (LIST (SPADCALL NIL |cs| 'T (QREFELT $ 53))))
                            (SEQ G190
                                 (COND ((NULL (NULL (NULL |lics|))) (GO G191)))
                                 (SEQ
                                  (LETT |newps|
                                        (CONS (|SPADfirst| |lics|)
                                              (SPADCALL
                                               (SPADCALL |cs| (QREFELT $ 56))
                                               |ps| (QREFELT $ 29))))
                                  (LETT |lics| (CDR |lics|))
                                  (LETT |newps|
                                        (SPADCALL |newps| (QREFELT $ 12)))
                                  (LETT |newps|
                                        (SPADCALL (ELT $ 51) |newps|
                                                  (QREFELT $ 52)))
                                  (EXIT
                                   (LETT |ln|
                                         (SPADCALL
                                          (SPADCALL |newps|
                                                    (SPADCALL (QREFELT $ 41))
                                                    NIL (QREFELT $ 53))
                                          |ln| (QREFELT $ 58)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT
                             (SPADCALL
                              (PROG2 (LETT #1# |esl|)
                                  (QCDR #1#)
                                (|check_union2| (QEQCAR #1# 0)
                                                (|SplittingTree|
                                                 (|List| (QREFELT $ 9)) $)
                                                (|Union|
                                                 (|SplittingTree|
                                                  (|List| (QREFELT $ 9)) $)
                                                 #2#)
                                                #1#))
                              |a| |ln| (QREFELT $ 59)))))))))
                  ('T
                   (SEQ
                    (SPADCALL
                     (PROG2 (LETT #1# |esl|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 0)
                                       (|SplittingTree| (|List| (QREFELT $ 9))
                                                        $)
                                       (|Union|
                                        (|SplittingTree| (|List| (QREFELT $ 9))
                                                         $)
                                        #2#)
                                       #1#))
                     (SPADCALL NIL (SPADCALL (QREFELT $ 41)) 'T (QREFELT $ 53))
                     (QREFELT $ 54))
                    (EXIT (SPADCALL |a| (QREFELT $ 55))))))))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT
           (SPADCALL (SPADCALL (QREFELT $ 41)) (SPADCALL |a| (QREFELT $ 61))
                     (QREFELT $ 62)))))) 

(SDEFUN |WUTSET;characteristicSerie;LL;11| ((|ps| (|List| P)) ($ (|List| $)))
        (SPADCALL |ps| (ELT $ 32) (ELT $ 33) (QREFELT $ 64))) 

(SDEFUN |WUTSET;removeSquares| ((|ts| ($)) ($ #1=(|Union| $ "failed")))
        (SPROG
         ((|p| (P)) (|newts| ($)) (|rsts| #1#) (#2=#:G783 NIL) (#3=#:G849 NIL))
         (SEQ
          (COND ((SPADCALL |ts| (QREFELT $ 66)) (CONS 0 |ts|))
                (#4='T
                 (SEQ
                  (LETT |p|
                        (PROG2 (LETT #3# (SPADCALL |ts| (QREFELT $ 68)))
                            (QCDR #3#)
                          (|check_union2| (QEQCAR #3# 0) (QREFELT $ 9)
                                          (|Union| (QREFELT $ 9) "failed")
                                          #3#)))
                  (LETT |rsts|
                        (|WUTSET;removeSquares|
                         (PROG2 (LETT #2# (SPADCALL |ts| (QREFELT $ 69)))
                             (QCDR #2#)
                           (|check_union2| (QEQCAR #2# 0) $
                                           (|Union| $ "failed") #2#))
                         $))
                  (EXIT
                   (COND
                    ((QEQCAR |rsts| 0)
                     (SEQ (LETT |newts| (QCDR |rsts|))
                          (EXIT
                           (COND
                            ((SPADCALL |newts| (QREFELT $ 66))
                             (SEQ (LETT |p| (SPADCALL |p| (QREFELT $ 70)))
                                  (EXIT
                                   (CONS 0
                                         (|WUTSET;per|
                                          (LIST (SPADCALL |p| (QREFELT $ 71)))
                                          $)))))
                            ((SPADCALL
                              (SPADCALL (SPADCALL |p| (QREFELT $ 72)) |newts|
                                        (QREFELT $ 73))
                              (QREFELT $ 35))
                             (CONS 1 "failed"))
                            (#4#
                             (SEQ
                              (LETT |p|
                                    (SPADCALL
                                     (SPADCALL |p| |newts| (QREFELT $ 74))
                                     (QREFELT $ 71)))
                              (EXIT
                               (COND
                                ((OR (SPADCALL |p| (QREFELT $ 18))
                                     (NULL
                                      (SPADCALL
                                       (SPADCALL |newts| (QREFELT $ 75))
                                       (SPADCALL |p| (QREFELT $ 76))
                                       (QREFELT $ 77))))
                                 (CONS 1 "failed"))
                                ('T
                                 (SEQ (LETT |p| (SPADCALL |p| (QREFELT $ 70)))
                                      (EXIT
                                       (CONS 0
                                             (|WUTSET;per|
                                              (CONS
                                               (SPADCALL |p| (QREFELT $ 78))
                                               (|WUTSET;rep| |newts| $))
                                              $)))))))))))))
                    (#4# (CONS 1 "failed")))))))))) 

(SDEFUN |WUTSET;zeroSetSplit;LL;13| ((|lp| (|List| P)) ($ (|List| $)))
        (SPROG
         ((|newlts| (|List| $)) (|iic| (|Union| $ "failed")) (|lts| (|List| $))
          (|ts| ($)))
         (SEQ (LETT |lts| (SPADCALL |lp| (ELT $ 32) (ELT $ 33) (QREFELT $ 64)))
              (LETT |lts| (SPADCALL |lts| (QREFELT $ 79))) (LETT |newlts| NIL)
              (SEQ G190
                   (COND
                    ((NULL (NULL (SPADCALL |lts| (QREFELT $ 80)))) (GO G191)))
                   (SEQ (LETT |ts| (SPADCALL |lts| (QREFELT $ 81)))
                        (LETT |lts| (SPADCALL |lts| (QREFELT $ 82)))
                        (LETT |iic| (|WUTSET;removeSquares| |ts| $))
                        (EXIT
                         (COND
                          ((QEQCAR |iic| 0)
                           (LETT |newlts|
                                 (SPADCALL (QCDR |iic|) |newlts|
                                           (QREFELT $ 83)))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |newlts| (SPADCALL |newlts| (QREFELT $ 79)))
              (EXIT (SPADCALL (ELT $ 84) |newlts| (QREFELT $ 86)))))) 

(SDEFUN |WUTSET;zeroSetSplit;LL;14| ((|lp| (|List| P)) ($ (|List| $)))
        (SPROG ((|lts| (|List| $)))
               (SEQ
                (LETT |lts|
                      (SPADCALL |lp| (ELT $ 32) (ELT $ 33) (QREFELT $ 64)))
                (EXIT
                 (SPADCALL (ELT $ 84) (SPADCALL |lts| (QREFELT $ 79))
                           (QREFELT $ 86)))))) 

(DECLAIM (NOTINLINE |WuWenTsunTriangularSet;|)) 

(DEFUN |WuWenTsunTriangularSet| (&REST #1=#:G892)
  (SPROG NIL
         (PROG (#2=#:G893)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|WuWenTsunTriangularSet|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |WuWenTsunTriangularSet;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|WuWenTsunTriangularSet|)))))))))) 

(DEFUN |WuWenTsunTriangularSet;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((#1=#:G891 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|WuWenTsunTriangularSet| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 105))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (AND
                                         (|HasCategory| |#4|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#4|)))
                                         (|HasCategory| |#4| '(|SetCategory|)))
                                        (|HasCategory| |#4|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#4| '(|BasicType|))
                                        (|HasCategory| |#4| '(|OrderedSet|))
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#3| '(|Finite|))))))
    (|haddProp| |$ConstructorCache| '|WuWenTsunTriangularSet|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 64))
    (AND (LETT #1# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 128))
    (AND (|HasCategory| |#4| '(|BasicType|)) #1# (|augmentPredVector| $ 256))
    (AND (|HasCategory| |#4| '(|OrderedSet|)) #1# (|augmentPredVector| $ 512))
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#1| '(|GcdDomain|))
      (PROGN
       (QSETREFV $ 87
                 (CONS (|dispatchFunction| |WUTSET;zeroSetSplit;LL;13|) $))))
     ('T
      (QSETREFV $ 87
                (CONS (|dispatchFunction| |WUTSET;zeroSetSplit;LL;14|) $))))
    $))) 

(MAKEPROP '|WuWenTsunTriangularSet| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|GeneralTriangularSet| 6 7 8 9)
              (|local| |#1|) (|local| |#2|) (|local| |#3|) (|local| |#4|)
              (0 . |primPartElseUnitCanonical|) (|List| 9)
              (5 . |removeDuplicates|) (|Mapping| 17 9 9) (|Mapping| 9 9 9)
              (|PolynomialSetUtilitiesPackage| 6 7 8 9)
              (10 . |rewriteIdealWithQuasiMonicGenerators|) (|Boolean|)
              (17 . |ground?|) (|Mapping| 17 9) (22 . |any?|)
              (|Record| (|:| |bas| $) (|:| |top| 11)) (|Union| 21 '#1="failed")
              (28 . |basicSet|) (34 . |rewriteIdealWithRemainder|) (40 . |One|)
              (44 . =) (50 . |rewriteSetWithReduction|) (58 . |members|)
              (63 . |concat|) (|Union| $ '"failed") |WUTSET;medialSet;LMMU;5|
              (69 . |initiallyReduced?|) (75 . |initiallyReduce|)
              |WUTSET;medialSet;LU;6| (81 . |zero?|) (86 . |remove|)
              (92 . |lazyPrem|) (98 . |reduced?|)
              |WUTSET;characteristicSet;LMMU;8| |WUTSET;characteristicSet;LU;9|
              (104 . |empty|) (|SplittingNode| 11 $$) (108 . |construct|)
              (|SplittingTree| 11 $$) (114 . |construct|)
              (119 . |extractSplittingLeaf|) (124 . |value|) (129 . |value|)
              (134 . |initials|) (139 . |removeRedundantFactors|)
              (144 . |infRittWu?|) (150 . |sort|) (156 . |construct|)
              (163 . |setvalue!|) (169 . |updateStatus!|) (174 . |coerce|)
              (|List| 42) (179 . |cons|) (185 . |splitNodeOf!|) (|List| $$)
              (192 . |conditions|) (197 . |remove|) (|List| $)
              |WUTSET;characteristicSerie;LMML;10|
              |WUTSET;characteristicSerie;LL;11| (203 . |empty?|)
              (|Union| 9 '#1#) (208 . |first|) (213 . |rest|)
              (218 . |squareFreePart|) (223 . |primitivePart|) (228 . |init|)
              (233 . |initiallyReduce|) (239 . |removeZero|) (245 . |mvar|)
              (250 . |mvar|) (255 . <) (261 . |unitCanonical|)
              (266 . |removeDuplicates|) (271 . |empty?|) (276 . |first|)
              (281 . |rest|) (286 . |cons|) (292 . |infRittWu?|)
              (|Mapping| 17 $$ $$) (298 . |sort|) (304 . |zeroSetSplit|)
              (|NonNegativeInteger|) (|Equation| 9) (|List| 89) (|Mapping| 9 9)
              (|InputForm|)
              (|Record| (|:| |rnum| 6) (|:| |polnum| 9) (|:| |den| 6))
              (|Record| (|:| |num| 9) (|:| |den| 6)) (|List| 8)
              (|Record| (|:| |close| $) (|:| |open| 11)) (|List| 96)
              (|Mapping| 17 9 11) (|Record| (|:| |close| 11) (|:| |open| 11))
              (|Record| (|:| |under| $) (|:| |floor| $) (|:| |upper| $))
              (|HashState|) (|String|) (|OutputForm|) (|SingleInteger|))
           '#(|zeroSetSplit| 309 |rewriteSetWithReduction| 314
              |rewriteIdealWithRemainder| 322 |rest| 328 |removeZero| 333
              |mvar| 339 |members| 344 |medialSet| 349 |initials| 361
              |initiallyReduce| 366 |infRittWu?| 372 |first| 378 |empty?| 383
              |empty| 388 |coerce| 392 |characteristicSet| 397
              |characteristicSerie| 409 |basicSet| 421)
           'NIL
           (CONS (|makeByteWordVec2| 2 '(0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 2))
                 (CONS
                  '#(|TriangularSetCategory&| |PolynomialSetCategory&|
                     |Collection&| |HomogeneousAggregate&| |SetCategory&|
                     |RetractableFrom&| |Aggregate&| |Evalable&| |BasicType&|
                     NIL NIL NIL NIL NIL |InnerEvalable&| NIL)
                  (CONS
                   '#((|TriangularSetCategory| 6 7 8 9)
                      (|PolynomialSetCategory| 6 7 8 9) (|Collection| 9)
                      (|HomogeneousAggregate| 9) (|SetCategory|)
                      (|RetractableFrom| (|List| 9)) (|Aggregate|)
                      (|Evalable| 9) (|BasicType|) (|shallowlyMutable|)
                      (|finiteAggregate|) (|CoercibleTo| (|List| 9)) (|Type|)
                      (|CoercibleTo| 103) (|InnerEvalable| 9 9)
                      (|ConvertibleTo| 92))
                   (|makeByteWordVec2| 87
                                       '(1 9 0 0 10 1 11 0 0 12 3 15 11 11 13
                                         14 16 1 9 17 0 18 2 11 17 19 0 20 2 0
                                         22 11 13 23 2 0 11 11 0 24 0 9 0 25 2
                                         9 17 0 0 26 4 0 11 11 0 14 13 27 1 0
                                         11 0 28 2 11 0 0 0 29 2 9 17 0 0 32 2
                                         9 0 0 0 33 1 9 17 0 35 2 11 0 19 0 36
                                         2 9 0 0 0 37 2 9 17 0 0 38 0 0 0 41 2
                                         42 0 11 2 43 1 44 0 42 45 1 44 30 0 46
                                         1 44 42 0 47 1 42 11 0 48 1 0 11 0 49
                                         1 15 11 11 50 2 9 17 0 0 51 2 11 0 13
                                         0 52 3 42 0 11 2 17 53 2 44 42 0 42 54
                                         1 44 0 0 55 1 0 11 0 56 2 57 0 42 0 58
                                         3 44 0 0 0 57 59 1 44 60 0 61 2 60 0 2
                                         0 62 1 0 17 0 66 1 0 67 0 68 1 0 30 0
                                         69 1 9 0 0 70 1 9 0 0 71 1 9 0 0 72 2
                                         0 9 9 0 73 2 0 9 9 0 74 1 0 8 0 75 1 9
                                         8 0 76 2 8 17 0 0 77 1 9 0 0 78 1 60 0
                                         0 79 1 60 17 0 80 1 60 2 0 81 1 60 0 0
                                         82 2 60 0 2 0 83 2 0 17 0 0 84 2 60 0
                                         85 0 86 1 0 63 11 87 1 0 63 11 87 4 0
                                         11 11 0 14 13 27 2 5 11 11 0 24 1 0 30
                                         0 69 2 0 9 9 0 74 1 0 8 0 75 1 8 11 0
                                         28 3 0 30 11 13 14 31 1 0 30 11 34 1 0
                                         11 0 49 2 0 9 9 0 73 2 0 17 0 0 84 1 0
                                         67 0 68 1 0 17 0 66 0 0 0 41 1 0 11 0
                                         56 1 0 30 11 40 3 0 30 11 13 14 39 1 0
                                         63 11 65 3 0 63 11 13 14 64 2 0 22 11
                                         13 23)))))
           '|lookupIncomplete|)) 

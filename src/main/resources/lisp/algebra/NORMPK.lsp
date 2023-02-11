
(SDEFUN |NORMPK;normInvertible?;PTSL;1|
        ((|p| (P)) (|ts| (TS))
         ($ (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS)))))
        (SPADCALL |p| |ts| (QREFELT $ 14))) 

(SDEFUN |NORMPK;normInvertible?;PTSL;2|
        ((|p| (P)) (|ts| (TS))
         ($ (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS)))))
        (SPADCALL |p| |ts| (QREFELT $ 16))) 

(SDEFUN |NORMPK;outputArgs;2SPTSV;3|
        ((|s1| (|String|)) (|s2| (|String|)) (|p| (P)) (|ts| (TS))
         ($ (|Void|)))
        (SPROG ((#1=#:G729 NIL) (|q| NIL) (|lp| (|List| P)))
               (SEQ
                (COND
                 ((NULL (SPADCALL |s1| (QREFELT $ 19)))
                  (SPADCALL |s1| (SPADCALL |p| (QREFELT $ 21))
                            (QREFELT $ 24))))
                (COND
                 ((NULL (SPADCALL |s1| (QREFELT $ 19)))
                  (SPADCALL |s1|
                            (SPADCALL (SPADCALL |p| (QREFELT $ 25))
                                      (QREFELT $ 26))
                            (QREFELT $ 24))))
                (SPADCALL " " (QREFELT $ 27))
                (COND
                 ((NULL (SPADCALL |s2| (QREFELT $ 19)))
                  (SPADCALL |s2| (SPADCALL |ts| (QREFELT $ 28))
                            (QREFELT $ 24))))
                (EXIT
                 (COND
                  ((SPADCALL |s2| (QREFELT $ 19)) (SPADCALL (QREFELT $ 29)))
                  ('T
                   (SEQ
                    (SPADCALL |s2| (SPADCALL "[" (QREFELT $ 30))
                              (QREFELT $ 24))
                    (LETT |lp| (SPADCALL |ts| (QREFELT $ 32)))
                    (SEQ (LETT |q| NIL) (LETT #1# |lp|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |q| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL
                            (SPADCALL (SPADCALL |q| (QREFELT $ 25))
                                      (QREFELT $ 26))
                            (QREFELT $ 33))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (SPADCALL (SPADCALL "]" (QREFELT $ 30)) (QREFELT $ 33))
                    (EXIT
                     (SPADCALL (SPADCALL " " (QREFELT $ 30))
                               (QREFELT $ 33)))))))))) 

(SDEFUN |NORMPK;outputArgs;2SPTSV;4|
        ((|s1| (|String|)) (|s2| (|String|)) (|p| (P)) (|ts| (TS))
         ($ (|Void|)))
        (SEQ
         (COND
          ((NULL (SPADCALL |s1| (QREFELT $ 19)))
           (SPADCALL |s1| (SPADCALL |p| (QREFELT $ 21)) (QREFELT $ 24))))
         (SPADCALL (SPADCALL " " (QREFELT $ 30)) (QREFELT $ 33))
         (COND
          ((NULL (SPADCALL |s2| (QREFELT $ 19)))
           (SPADCALL |s2| (SPADCALL |ts| (QREFELT $ 28)) (QREFELT $ 24))))
         (EXIT (SPADCALL (SPADCALL " " (QREFELT $ 30)) (QREFELT $ 33))))) 

(SDEFUN |NORMPK;outputArgs;2SPTSV;5|
        ((|s1| (|String|)) (|s2| (|String|)) (|p| (P)) (|ts| (TS))
         ($ (|Void|)))
        (SEQ
         (COND
          ((NULL (SPADCALL |s1| (QREFELT $ 19)))
           (SPADCALL |s1| (SPADCALL |p| (QREFELT $ 21)) (QREFELT $ 24))))
         (SPADCALL (SPADCALL " " (QREFELT $ 30)) (QREFELT $ 33))
         (COND
          ((NULL (SPADCALL |s2| (QREFELT $ 19)))
           (SPADCALL |s2| (SPADCALL |ts| (QREFELT $ 28)) (QREFELT $ 24))))
         (EXIT (SPADCALL (SPADCALL " " (QREFELT $ 30)) (QREFELT $ 33))))) 

(SDEFUN |NORMPK;recip;PTSR;6|
        ((|p| (P)) (|ts| (TS)) ($ (|Record| (|:| |num| P) (|:| |den| P))))
        (SPROG
         ((|pd| (P)) (|pn| (P)) (|k| (|Fraction| R)) (|dp| (R)) (|cd| (R))
          (|dn| (R)) (|cn| (R))
          (|remd| #1=(|Record| (|:| |rnum| R) (|:| |polnum| P) (|:| |den| R)))
          (|remn| #1#) (|d| (P)) (|n| (P)) (|#G28| (P)) (#2=#:G740 NIL)
          (|#G27| (P)) (|g| (P))
          (|hesrg| (|Record| (|:| |gcd| P) (|:| |coef1| P))) (|ts_v| (P))
          (|v| (V)))
         (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 35)))
              (LETT |ts_v|
                    (PROG2 (LETT #2# (SPADCALL |ts| |v| (QREFELT $ 37)))
                        (QCDR #2#)
                      (|check_union2| (QEQCAR #2# 0) (QREFELT $ 9)
                                      (|Union| (QREFELT $ 9) #3="failed")
                                      #2#)))
              (COND
               ((< (SPADCALL |p| (QREFELT $ 39))
                   (SPADCALL |ts_v| (QREFELT $ 39)))
                (SEQ (LETT |hesrg| (SPADCALL |ts_v| |p| (QREFELT $ 41)))
                     (LETT |d| (QCAR |hesrg|))
                     (EXIT (LETT |n| (QCDR |hesrg|)))))
               ('T
                (SEQ (LETT |hesrg| (SPADCALL |p| |ts_v| (QREFELT $ 43)))
                     (LETT |d| (QCAR |hesrg|))
                     (EXIT (LETT |n| (QCDR |hesrg|))))))
              (LETT |g| (SPADCALL |n| |d| (QREFELT $ 44)))
              (PROGN
               (LETT |#G27|
                     (PROG2 (LETT #2# (SPADCALL |n| |g| (QREFELT $ 46)))
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 0) (QREFELT $ 9)
                                       (|Union| (QREFELT $ 9) #3#) #2#)))
               (LETT |#G28|
                     (PROG2 (LETT #2# (SPADCALL |d| |g| (QREFELT $ 46)))
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 0) (QREFELT $ 9)
                                       (|Union| (QREFELT $ 9) #3#) #2#)))
               (LETT |n| |#G27|)
               (LETT |d| |#G28|))
              (LETT |remn| (SPADCALL |n| |ts| (QREFELT $ 48)))
              (LETT |remd| (SPADCALL |d| |ts| (QREFELT $ 48)))
              (LETT |cn| (QVELT |remn| 0)) (LETT |pn| (QVELT |remn| 1))
              (LETT |dn| (QVELT |remn| 2)) (LETT |cd| (QVELT |remd| 0))
              (LETT |pd| (QVELT |remd| 1)) (LETT |dp| (QVELT |remd| 2))
              (LETT |k|
                    (SPADCALL (SPADCALL |cn| |cd| (QREFELT $ 50))
                              (SPADCALL |dp| |dn| (QREFELT $ 50))
                              (QREFELT $ 51)))
              (LETT |pn| (SPADCALL |pn| |ts| (QREFELT $ 52)))
              (LETT |pd| (SPADCALL |pd| |ts| (QREFELT $ 52)))
              (EXIT
               (CONS
                (SPADCALL (SPADCALL |k| (QREFELT $ 53)) |pn| (QREFELT $ 54))
                (SPADCALL (SPADCALL |k| (QREFELT $ 55)) |pd|
                          (QREFELT $ 54))))))) 

(SDEFUN |NORMPK;normalizedAssociate;PTSP;7| ((|p| (P)) (|ts| (TS)) ($ (P)))
        (SPROG
         ((|r| (P)) (|ip| (P)) (|mp| (P)) (|tp| (P))
          (|qr| (|Record| (|:| |num| P) (|:| |den| P))) (|ts_v| (P))
          (#1=#:G760 NIL) (|v| (V)) (|vp| (V)))
         (SEQ
          (COND
           ((OR (SPADCALL |ts| (QREFELT $ 58)) (SPADCALL |p| (QREFELT $ 59)))
            |p|)
           ((SPADCALL |p| (QREFELT $ 60)) (|spadConstant| $ 61))
           ((SPADCALL
             (SPADCALL (SPADCALL |p| (QREFELT $ 62)) |ts| (QREFELT $ 63))
             (QREFELT $ 59))
            (|error| "in normalizedAssociate$NORMPK: bad #1"))
           ('T
            (SEQ (LETT |vp| (SPADCALL |p| (QREFELT $ 35))) (LETT |ip| |p|)
                 (LETT |mp| (|spadConstant| $ 61))
                 (LETT |tp| (|spadConstant| $ 64))
                 (SEQ G190
                      (COND
                       ((NULL (NULL (SPADCALL |ip| (QREFELT $ 60))))
                        (GO G191)))
                      (SEQ (LETT |v| (SPADCALL |ip| (QREFELT $ 35)))
                           (EXIT
                            (COND
                             ((SPADCALL |v| |ts| (QREFELT $ 65))
                              (COND
                               ((SPADCALL |v| |vp| (QREFELT $ 66))
                                (SEQ
                                 (LETT |ts_v|
                                       (PROG2
                                           (LETT #1#
                                                 (SPADCALL |ts| |v|
                                                           (QREFELT $ 37)))
                                           (QCDR #1#)
                                         (|check_union2| (QEQCAR #1# 0)
                                                         (QREFELT $ 9)
                                                         (|Union| (QREFELT $ 9)
                                                                  "failed")
                                                         #1#)))
                                 (LETT |ip|
                                       (SPADCALL |ip| |ts_v| (QREFELT $ 67)))
                                 (LETT |ip|
                                       (QVELT
                                        (SPADCALL |ip| |ts| (QREFELT $ 48)) 1))
                                 (EXIT
                                  (LETT |ip|
                                        (SPADCALL
                                         (SPADCALL |ip| |ts| (QREFELT $ 63))
                                         (QREFELT $ 68))))))
                               ('T
                                (SEQ
                                 (LETT |qr|
                                       (SPADCALL |ip| |ts| (QREFELT $ 57)))
                                 (LETT |ip| (QCDR |qr|))
                                 (LETT |tp|
                                       (SPADCALL (QCAR |qr|) |tp|
                                                 (QREFELT $ 69)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |ip| (QREFELT $ 59))
                                    (SEQ
                                     (SPADCALL "p = " " ts = " |p| |ts|
                                               (QREFELT $ 34))
                                     (EXIT
                                      (|error|
                                       "in normalizedAssociate$NORMPK: should never happen !"))))))))))
                             ('T
                              (SEQ
                               (LETT |tp|
                                     (SPADCALL
                                      (SPADCALL (SPADCALL |ip| (QREFELT $ 70))
                                                |mp| (QREFELT $ 69))
                                      |tp| (QREFELT $ 71)))
                               (LETT |mp|
                                     (SPADCALL (SPADCALL |ip| (QREFELT $ 72))
                                               |mp| (QREFELT $ 69)))
                               (EXIT
                                (LETT |ip|
                                      (SPADCALL |ip| (QREFELT $ 62)))))))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (LETT |r|
                       (SPADCALL (SPADCALL |ip| |mp| (QREFELT $ 69)) |tp|
                                 (QREFELT $ 71)))
                 (LETT |r| (QVELT (SPADCALL |r| |ts| (QREFELT $ 48)) 1))
                 (EXIT
                  (SPADCALL (SPADCALL |r| |ts| (QREFELT $ 63))
                            (QREFELT $ 68))))))))) 

(SDEFUN |NORMPK;normalize;PTSL;8|
        ((|p| (P)) (|ts| (TS))
         ($ (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))))
        (SPROG
         ((|lpwt| (|List| (|Record| (|:| |val| P) (|:| |tower| TS)))) (|q| (P))
          (|us| (TS)) (#1=#:G796 NIL) (|bwt| NIL)
          (|lbwt|
           (|List| (|Record| (|:| |val| (|Boolean|)) (|:| |tower| TS)))))
         (SEQ
          (COND ((SPADCALL |p| (QREFELT $ 59)) (LIST (CONS |p| |ts|)))
                ((SPADCALL |p| (QREFELT $ 60))
                 (LIST (CONS (|spadConstant| $ 61) |ts|)))
                ((SPADCALL
                  (SPADCALL (SPADCALL |p| (QREFELT $ 62)) |ts| (QREFELT $ 63))
                  (QREFELT $ 59))
                 (|error|
                  "in normalize$NORMPK: init(#1) reduces to 0 w.r.t. #2"))
                ('T
                 (SEQ (LETT |lbwt| (SPADCALL |p| |ts| (QREFELT $ 15)))
                      (LETT |lpwt| NIL)
                      (SEQ (LETT |bwt| NIL) (LETT #1# |lbwt|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |bwt| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |us| (QCDR |bwt|))
                                (LETT |q|
                                      (QVELT (SPADCALL |p| |us| (QREFELT $ 48))
                                             1))
                                (LETT |q| (SPADCALL |q| |us| (QREFELT $ 52)))
                                (EXIT
                                 (COND
                                  ((QCAR |bwt|)
                                   (LETT |lpwt|
                                         (CONS
                                          (CONS
                                           (SPADCALL |q| |us| (QREFELT $ 73))
                                           |us|)
                                          |lpwt|)))
                                  ((SPADCALL |q| (QREFELT $ 59))
                                   (LETT |lpwt|
                                         (CONS
                                          (CONS (|spadConstant| $ 64) |us|)
                                          |lpwt|)))
                                  ('T
                                   (LETT |lpwt|
                                         (SPADCALL
                                          (SPADCALL |q| |us| (QREFELT $ 77))
                                          |lpwt| (QREFELT $ 78)))))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |lpwt|))))))) 

(DECLAIM (NOTINLINE |NormalizationPackage;|)) 

(DEFUN |NormalizationPackage| (&REST #1=#:G797)
  (SPROG NIL
         (PROG (#2=#:G798)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|NormalizationPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |NormalizationPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|NormalizationPackage|)))))))))) 

(DEFUN |NormalizationPackage;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|NormalizationPackage| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 79))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|NormalizationPackage|
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
      (QSETREFV $ 15
                (CONS (|dispatchFunction| |NORMPK;normInvertible?;PTSL;1|) $)))
     ('T
      (QSETREFV $ 15
                (CONS (|dispatchFunction| |NORMPK;normInvertible?;PTSL;2|)
                      $))))
    (COND
     ((|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
      (COND
       ((|HasCategory| |#3| '(|ConvertibleTo| (|Symbol|)))
        (QSETREFV $ 34
                  (CONS (|dispatchFunction| |NORMPK;outputArgs;2SPTSV;3|) $)))
       ('T
        (QSETREFV $ 34
                  (CONS (|dispatchFunction| |NORMPK;outputArgs;2SPTSV;4|)
                        $)))))
     ('T
      (QSETREFV $ 34
                (CONS (|dispatchFunction| |NORMPK;outputArgs;2SPTSV;5|) $))))
    $))) 

(MAKEPROP '|NormalizationPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|Record| (|:| |val| 17) (|:| |tower| 10)) (|List| 11)
              (|SquareFreeRegularTriangularSetGcdPackage| 6 7 8 9 10)
              (0 . |stoseInvertible?_sqfreg|) (6 . |normInvertible?|)
              (12 . |stoseInvertible?_reg|) (|Boolean|) (|String|)
              (18 . |empty?|) (|OutputForm|) (23 . |coerce|) (|Void|)
              (|OutputPackage|) (28 . |output|) (34 . |convert|)
              (39 . |coerce|) (44 . |output|) (49 . |coerce|) (54 . |void|)
              (58 . |message|) (|List| 9) (63 . |members|) (68 . |output|)
              (73 . |outputArgs|) (81 . |mvar|) (|Union| 9 '"failed")
              (86 . |select|) (|NonNegativeInteger|) (92 . |mdeg|)
              (|Record| (|:| |gcd| $) (|:| |coef2| $))
              (97 . |halfExtendedSubResultantGcd2|)
              (|Record| (|:| |gcd| $) (|:| |coef1| $))
              (103 . |halfExtendedSubResultantGcd1|) (109 . |gcd|)
              (|Union| $ '"failed") (115 . |exquo|)
              (|Record| (|:| |rnum| 6) (|:| |polnum| 9) (|:| |den| 6))
              (121 . |remainder|) (|Fraction| 6) (127 . /) (133 . *)
              (139 . |removeZero|) (145 . |numer|) (150 . *) (156 . |denom|)
              (|Record| (|:| |num| 9) (|:| |den| 9)) |NORMPK;recip;PTSR;6|
              (161 . |empty?|) (166 . |zero?|) (171 . |ground?|) (176 . |One|)
              (180 . |init|) (185 . |initiallyReduce|) (191 . |Zero|)
              (195 . |algebraic?|) (201 . =) (207 . |lastSubResultant|)
              (213 . |primitivePart|) (218 . *) (224 . |tail|) (229 . +)
              (235 . |mainMonomial|) |NORMPK;normalizedAssociate;PTSP;7|
              (240 . |One|) (|Record| (|:| |val| 9) (|:| |tower| 10))
              (|List| 75) |NORMPK;normalize;PTSL;8| (244 . |concat|))
           '#(|recip| 250 |outputArgs| 256 |normalizedAssociate| 264
              |normalize| 270 |normInvertible?| 276)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|recip|
                                 ((|Record| (|:| |num| |#4|) (|:| |den| |#4|))
                                  |#4| |#5|))
                                T)
                              '((|normalizedAssociate| (|#4| |#4| |#5|)) T)
                              '((|normalize|
                                 ((|List|
                                   (|Record| (|:| |val| |#4|)
                                             (|:| |tower| |#5|)))
                                  |#4| |#5|))
                                T)
                              '((|outputArgs|
                                 ((|Void|) (|String|) (|String|) |#4| |#5|))
                                T)
                              '((|normInvertible?|
                                 ((|List|
                                   (|Record| (|:| |val| (|Boolean|))
                                             (|:| |tower| |#5|)))
                                  |#4| |#5|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 78
                                            '(2 13 12 9 10 14 2 0 12 9 10 15 2
                                              13 12 9 10 16 1 18 17 0 19 1 9 20
                                              0 21 2 23 22 18 20 24 1 9 18 0 25
                                              1 18 20 0 26 1 23 22 18 27 1 10
                                              20 0 28 0 22 0 29 1 20 0 18 30 1
                                              10 31 0 32 1 23 22 20 33 4 0 22
                                              18 18 9 10 34 1 9 8 0 35 2 10 36
                                              0 8 37 1 9 38 0 39 2 9 40 0 0 41
                                              2 9 42 0 0 43 2 9 0 0 0 44 2 9 45
                                              0 0 46 2 10 47 9 0 48 2 49 0 6 6
                                              50 2 49 0 0 0 51 2 10 9 9 0 52 1
                                              49 6 0 53 2 9 0 6 0 54 1 49 6 0
                                              55 1 10 17 0 58 1 9 17 0 59 1 9
                                              17 0 60 0 9 0 61 1 9 0 0 62 2 10
                                              9 9 0 63 0 9 0 64 2 10 17 8 0 65
                                              2 8 17 0 0 66 2 9 0 0 0 67 1 9 0
                                              0 68 2 9 0 0 0 69 1 9 0 0 70 2 9
                                              0 0 0 71 1 9 0 0 72 0 6 0 74 2 76
                                              0 0 0 78 2 0 56 9 10 57 4 0 22 18
                                              18 9 10 34 2 0 9 9 10 73 2 0 76 9
                                              10 77 2 0 12 9 10 15)))))
           '|lookupComplete|)) 

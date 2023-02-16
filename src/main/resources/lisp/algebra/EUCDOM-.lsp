
(SDEFUN |EUCDOM-;sizeLess?;2SB;1| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND ((SPADCALL |y| (QREFELT $ 8)) NIL)
              ((SPADCALL |x| (QREFELT $ 8)) 'T)
              ('T
               (< (SPADCALL |x| (QREFELT $ 10))
                  (SPADCALL |y| (QREFELT $ 10)))))) 

(SDEFUN |EUCDOM-;quo;3S;2| ((|x| (S)) (|y| (S)) ($ (S)))
        (QCAR (SPADCALL |x| |y| (QREFELT $ 13)))) 

(SDEFUN |EUCDOM-;rem;3S;3| ((|x| (S)) (|y| (S)) ($ (S)))
        (QCDR (SPADCALL |x| |y| (QREFELT $ 13)))) 

(SDEFUN |EUCDOM-;exquo;2SU;4| ((|x| (S)) (|y| (S)) ($ (|Union| S "failed")))
        (SPROG ((|qr| (|Record| (|:| |quotient| S) (|:| |remainder| S))))
               (SEQ
                (COND ((SPADCALL |y| (QREFELT $ 8)) (CONS 1 "failed"))
                      (#1='T
                       (SEQ (LETT |qr| (SPADCALL |x| |y| (QREFELT $ 13)))
                            (EXIT
                             (COND
                              ((SPADCALL (QCDR |qr|) (QREFELT $ 8))
                               (CONS 0 (QCAR |qr|)))
                              (#1# (CONS 1 "failed")))))))))) 

(SDEFUN |EUCDOM-;gcd;3S;5| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPROG ((|#G14| (S)) (|#G13| (S)))
               (SEQ (LETT |x| (SPADCALL |x| (QREFELT $ 18)))
                    (LETT |y| (SPADCALL |y| (QREFELT $ 18)))
                    (SEQ G190
                         (COND
                          ((NULL (NULL (SPADCALL |y| (QREFELT $ 8))))
                           (GO G191)))
                         (SEQ
                          (PROGN
                           (LETT |#G13| |y|)
                           (LETT |#G14| (SPADCALL |x| |y| (QREFELT $ 19)))
                           (LETT |x| |#G13|)
                           (LETT |y| |#G14|))
                          (EXIT (LETT |y| (SPADCALL |y| (QREFELT $ 18)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |x|)))) 

(SDEFUN |EUCDOM-;unitNormalizeIdealElt|
        ((|s| (|Record| (|:| |coef1| S) (|:| |coef2| S) (|:| |generator| S)))
         ($ (|Record| (|:| |coef1| S) (|:| |coef2| S) (|:| |generator| S))))
        (SPROG
         ((|a| (S)) (|c| (S)) (|u| (S))
          (|#G16|
           (|Record| (|:| |unit| S) (|:| |canonical| S) (|:| |associate| S))))
         (SEQ
          (PROGN
           (LETT |#G16| (SPADCALL (QVELT |s| 2) (QREFELT $ 22)))
           (LETT |u| (QVELT |#G16| 0))
           (LETT |c| (QVELT |#G16| 1))
           (LETT |a| (QVELT |#G16| 2))
           |#G16|)
          (EXIT
           (COND ((SPADCALL |a| (|spadConstant| $ 23) (QREFELT $ 24)) |s|)
                 ('T
                  (VECTOR (SPADCALL |a| (QVELT |s| 0) (QREFELT $ 25))
                          (SPADCALL |a| (QVELT |s| 1) (QREFELT $ 25)) |c|))))))) 

(SDEFUN |EUCDOM-;extendedEuclidean;2SR;7|
        ((|x| (S)) (|y| (S))
         ($ #1=(|Record| (|:| |coef1| S) (|:| |coef2| S) (|:| |generator| S))))
        (SPROG
         ((|s1|
           #2=(|Record| (|:| |coef1| S) (|:| |coef2| S) (|:| |generator| S)))
          (|qr| (|Record| (|:| |quotient| S) (|:| |remainder| S))) (|s2| #2#)
          (|s3| #1#))
         (SEQ
          (LETT |s1|
                (|EUCDOM-;unitNormalizeIdealElt|
                 (VECTOR (|spadConstant| $ 23) (|spadConstant| $ 26) |x|) $))
          (LETT |s2|
                (|EUCDOM-;unitNormalizeIdealElt|
                 (VECTOR (|spadConstant| $ 26) (|spadConstant| $ 23) |y|) $))
          (EXIT
           (COND ((SPADCALL |y| (QREFELT $ 8)) |s1|)
                 ((SPADCALL |x| (QREFELT $ 8)) |s2|)
                 ('T
                  (SEQ
                   (SEQ G190
                        (COND
                         ((NULL (NULL (SPADCALL (QVELT |s2| 2) (QREFELT $ 8))))
                          (GO G191)))
                        (SEQ
                         (LETT |qr|
                               (SPADCALL (QVELT |s1| 2) (QVELT |s2| 2)
                                         (QREFELT $ 13)))
                         (LETT |s3|
                               (VECTOR
                                (SPADCALL (QVELT |s1| 0)
                                          (SPADCALL (QCAR |qr|) (QVELT |s2| 0)
                                                    (QREFELT $ 25))
                                          (QREFELT $ 27))
                                (SPADCALL (QVELT |s1| 1)
                                          (SPADCALL (QCAR |qr|) (QVELT |s2| 1)
                                                    (QREFELT $ 25))
                                          (QREFELT $ 27))
                                (QCDR |qr|)))
                         (LETT |s1| |s2|)
                         (EXIT
                          (LETT |s2|
                                (|EUCDOM-;unitNormalizeIdealElt| |s3| $))))
                        NIL (GO G190) G191 (EXIT NIL))
                   (COND
                    ((NULL (SPADCALL (QVELT |s1| 0) (QREFELT $ 8)))
                     (COND
                      ((NULL (SPADCALL (QVELT |s1| 0) |y| (QREFELT $ 28)))
                       (SEQ
                        (LETT |qr|
                              (SPADCALL (QVELT |s1| 0) |y| (QREFELT $ 13)))
                        (QSETVELT |s1| 0 (QCDR |qr|))
                        (QSETVELT |s1| 1
                                  (SPADCALL (QVELT |s1| 1)
                                            (SPADCALL (QCAR |qr|) |x|
                                                      (QREFELT $ 25))
                                            (QREFELT $ 29)))
                        (EXIT
                         (LETT |s1|
                               (|EUCDOM-;unitNormalizeIdealElt| |s1| $))))))))
                   (EXIT |s1|)))))))) 

(SDEFUN |EUCDOM-;extendedEuclidean;3SU;8|
        ((|x| (S)) (|y| (S)) (|z| (S))
         ($ (|Union| (|Record| (|:| |coef1| S) (|:| |coef2| S)) "failed")))
        (SPROG
         ((|qr| (|Record| (|:| |quotient| S) (|:| |remainder| S)))
          (|w| (|Union| S "failed"))
          (|s| (|Record| (|:| |coef1| S) (|:| |coef2| S) (|:| |generator| S))))
         (SEQ
          (COND
           ((SPADCALL |z| (QREFELT $ 8))
            (CONS 0 (CONS (|spadConstant| $ 26) (|spadConstant| $ 26))))
           (#1='T
            (SEQ (LETT |s| (SPADCALL |x| |y| (QREFELT $ 32)))
                 (LETT |w| (SPADCALL |z| (QVELT |s| 2) (QREFELT $ 33)))
                 (EXIT
                  (COND ((QEQCAR |w| 1) (CONS 1 "failed"))
                        ((SPADCALL |y| (QREFELT $ 8))
                         (CONS 0
                               (CONS
                                (SPADCALL (QVELT |s| 0) (QCDR |w|)
                                          (QREFELT $ 25))
                                (SPADCALL (QVELT |s| 1) (QCDR |w|)
                                          (QREFELT $ 25)))))
                        (#1#
                         (SEQ
                          (LETT |qr|
                                (SPADCALL
                                 (SPADCALL (QVELT |s| 0) (QCDR |w|)
                                           (QREFELT $ 25))
                                 |y| (QREFELT $ 13)))
                          (EXIT
                           (CONS 0
                                 (CONS (QCDR |qr|)
                                       (SPADCALL
                                        (SPADCALL (QVELT |s| 1) (QCDR |w|)
                                                  (QREFELT $ 25))
                                        (SPADCALL (QCAR |qr|) |x|
                                                  (QREFELT $ 25))
                                        (QREFELT $ 29))))))))))))))) 

(SDEFUN |EUCDOM-;principalIdeal;LR;9|
        ((|l| (|List| S))
         ($ (|Record| (|:| |coef| (|List| S)) (|:| |generator| S))))
        (SPROG
         ((#1=#:G798 NIL) (|vv| NIL) (#2=#:G797 NIL)
          (|u| (|Record| (|:| |coef1| S) (|:| |coef2| S) (|:| |generator| S)))
          (|v| (|Record| (|:| |coef| (|List| S)) (|:| |generator| S)))
          (|uca|
           (|Record| (|:| |unit| S) (|:| |canonical| S) (|:| |associate| S))))
         (SEQ
          (COND
           ((SPADCALL |l| NIL (QREFELT $ 38))
            (|error| "empty list passed to principalIdeal"))
           ((SPADCALL (CDR |l|) NIL (QREFELT $ 38))
            (SEQ (LETT |uca| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 22)))
                 (EXIT (CONS (LIST (QVELT |uca| 0)) (QVELT |uca| 1)))))
           ((SPADCALL (CDR (CDR |l|)) NIL (QREFELT $ 38))
            (SEQ
             (LETT |u|
                   (SPADCALL (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 39))
                             (QREFELT $ 32)))
             (EXIT (CONS (LIST (QVELT |u| 0) (QVELT |u| 1)) (QVELT |u| 2)))))
           ('T
            (SEQ (LETT |v| (SPADCALL (CDR |l|) (QREFELT $ 42)))
                 (LETT |u|
                       (SPADCALL (|SPADfirst| |l|) (QCDR |v|) (QREFELT $ 32)))
                 (EXIT
                  (CONS
                   (CONS (QVELT |u| 0)
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |vv| NIL) (LETT #1# (QCAR |v|)) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |vv| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS
                                        (SPADCALL (QVELT |u| 1) |vv|
                                                  (QREFELT $ 25))
                                        #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#)))))
                   (QVELT |u| 2))))))))) 

(SDEFUN |EUCDOM-;expressIdealMember;LSU;10|
        ((|l| (|List| S)) (|z| (S)) ($ (|Union| (|List| S) "failed")))
        (SPROG
         ((#1=#:G818 NIL) (|v| NIL) (#2=#:G817 NIL) (|q| (|Union| S "failed"))
          (|pid| (|Record| (|:| |coef| (|List| S)) (|:| |generator| S)))
          (#3=#:G816 NIL) (#4=#:G815 NIL))
         (SEQ
          (COND
           ((SPADCALL |z| (|spadConstant| $ 26) (QREFELT $ 24))
            (CONS 0
                  (PROGN
                   (LETT #4# NIL)
                   (SEQ (LETT |v| NIL) (LETT #3# |l|) G190
                        (COND
                         ((OR (ATOM #3#) (PROGN (LETT |v| (CAR #3#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT (LETT #4# (CONS (|spadConstant| $ 26) #4#))))
                        (LETT #3# (CDR #3#)) (GO G190) G191
                        (EXIT (NREVERSE #4#))))))
           (#5='T
            (SEQ (LETT |pid| (SPADCALL |l| (QREFELT $ 42)))
                 (LETT |q| (SPADCALL |z| (QCDR |pid|) (QREFELT $ 33)))
                 (EXIT
                  (COND ((QEQCAR |q| 1) (CONS 1 "failed"))
                        (#5#
                         (CONS 0
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |v| NIL) (LETT #1# (QCAR |pid|))
                                     G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |v| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #2#
                                             (CONS
                                              (SPADCALL (QCDR |q|) |v|
                                                        (QREFELT $ 25))
                                              #2#))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT (NREVERSE #2#)))))))))))))) 

(SDEFUN |EUCDOM-;multiEuclidean;LSU;11|
        ((|l| (|List| S)) (|z| (S)) ($ (|Union| (|List| S) #1="failed")))
        (SPROG
         ((|v2| #2=(|Union| (|List| S) #1#)) (|v1| #2#)
          (|u| (|Union| (|Record| (|:| |coef1| S) (|:| |coef2| S)) "failed"))
          (#3=#:G826 NIL) (#4=#:G825 (S)) (#5=#:G827 (S)) (#6=#:G846 NIL)
          (#7=#:G690 NIL) (#8=#:G823 NIL) (#9=#:G822 (S)) (#10=#:G824 (S))
          (#11=#:G845 NIL) (#12=#:G689 NIL) (|l2| (|List| S)) (|l1| (|List| S))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |l|))
              (EXIT
               (COND
                ((ZEROP |n|) (|error| "empty list passed to multiEuclidean"))
                ((EQL |n| 1) (CONS 0 (LIST |z|)))
                (#13='T
                 (SEQ (LETT |l1| (SPADCALL |l| (QREFELT $ 46)))
                      (LETT |l2|
                            (SPADCALL |l1| (QUOTIENT2 |n| 2) (QREFELT $ 47)))
                      (LETT |u|
                            (SPADCALL
                             (PROGN
                              (LETT #8# NIL)
                              (SEQ (LETT #12# NIL) (LETT #11# |l1|) G190
                                   (COND
                                    ((OR (ATOM #11#)
                                         (PROGN (LETT #12# (CAR #11#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (PROGN
                                      (LETT #10# #12#)
                                      (COND
                                       (#8#
                                        (LETT #9#
                                              (SPADCALL #9# #10#
                                                        (QREFELT $ 25))))
                                       ('T
                                        (PROGN
                                         (LETT #9# #10#)
                                         (LETT #8# 'T)))))))
                                   (LETT #11# (CDR #11#)) (GO G190) G191
                                   (EXIT NIL))
                              (COND (#8# #9#) (#13# (|spadConstant| $ 23))))
                             (PROGN
                              (LETT #3# NIL)
                              (SEQ (LETT #7# NIL) (LETT #6# |l2|) G190
                                   (COND
                                    ((OR (ATOM #6#)
                                         (PROGN (LETT #7# (CAR #6#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (PROGN
                                      (LETT #5# #7#)
                                      (COND
                                       (#3#
                                        (LETT #4#
                                              (SPADCALL #4# #5#
                                                        (QREFELT $ 25))))
                                       ('T
                                        (PROGN
                                         (LETT #4# #5#)
                                         (LETT #3# 'T)))))))
                                   (LETT #6# (CDR #6#)) (GO G190) G191
                                   (EXIT NIL))
                              (COND (#3# #4#) (#13# (|spadConstant| $ 23))))
                             |z| (QREFELT $ 48)))
                      (EXIT
                       (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                             (#13#
                              (SEQ
                               (LETT |v1|
                                     (SPADCALL |l1| (QCDR (QCDR |u|))
                                               (QREFELT $ 49)))
                               (EXIT
                                (COND ((QEQCAR |v1| 1) (CONS 1 "failed"))
                                      (#13#
                                       (SEQ
                                        (LETT |v2|
                                              (SPADCALL |l2| (QCAR (QCDR |u|))
                                                        (QREFELT $ 49)))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |v2| 1) (CONS 1 "failed"))
                                          (#13#
                                           (CONS 0
                                                 (SPADCALL (QCDR |v1|)
                                                           (QCDR |v2|)
                                                           (QREFELT $
                                                                    50))))))))))))))))))))) 

(DECLAIM (NOTINLINE |EuclideanDomain&;|)) 

(DEFUN |EuclideanDomain&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|EuclideanDomain&| DV$1))
          (LETT $ (GETREFV 52))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|EuclideanDomain&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (0 . |zero?|)
              (|NonNegativeInteger|) (5 . |euclideanSize|)
              |EUCDOM-;sizeLess?;2SB;1|
              (|Record| (|:| |quotient| $) (|:| |remainder| $)) (10 . |divide|)
              |EUCDOM-;quo;3S;2| |EUCDOM-;rem;3S;3| (|Union| $ '#1="failed")
              |EUCDOM-;exquo;2SU;4| (16 . |unitCanonical|) (21 . |rem|)
              |EUCDOM-;gcd;3S;5|
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (27 . |unitNormal|) (32 . |One|) (36 . =) (42 . *) (48 . |Zero|)
              (52 . -) (58 . |sizeLess?|) (64 . +)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              |EUCDOM-;extendedEuclidean;2SR;7| (70 . |extendedEuclidean|)
              (76 . |exquo|) (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 34 '#2="failed") |EUCDOM-;extendedEuclidean;3SU;8|
              (|List| 6) (82 . =) (88 . |second|)
              (|Record| (|:| |coef| 41) (|:| |generator| $)) (|List| $)
              (93 . |principalIdeal|) |EUCDOM-;principalIdeal;LR;9|
              (|Union| 41 '#3="failed") |EUCDOM-;expressIdealMember;LSU;10|
              (98 . |copy|) (103 . |split!|) (109 . |extendedEuclidean|)
              (116 . |multiEuclidean|) (122 . |concat|)
              |EUCDOM-;multiEuclidean;LSU;11|)
           '#(|sizeLess?| 128 |rem| 134 |quo| 140 |principalIdeal| 146
              |multiEuclidean| 151 |gcd| 157 |extendedEuclidean| 163 |exquo|
              176 |expressIdealMember| 182)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|multiEuclidean|
                                 ((|Union| (|List| |#1|) "failed")
                                  (|List| |#1|) |#1|))
                                T)
                              '((|extendedEuclidean|
                                 ((|Union|
                                   (|Record| (|:| |coef1| |#1|)
                                             (|:| |coef2| |#1|))
                                   #2#)
                                  |#1| |#1| |#1|))
                                T)
                              '((|extendedEuclidean|
                                 ((|Record| (|:| |coef1| |#1|)
                                            (|:| |coef2| |#1|)
                                            (|:| |generator| |#1|))
                                  |#1| |#1|))
                                T)
                              '((|rem| (|#1| |#1| |#1|)) T)
                              '((|quo| (|#1| |#1| |#1|)) T)
                              '((|sizeLess?| ((|Boolean|) |#1| |#1|)) T)
                              '((|expressIdealMember|
                                 ((|Union| (|List| |#1|) #3#) (|List| |#1|)
                                  |#1|))
                                T)
                              '((|principalIdeal|
                                 ((|Record| (|:| |coef| (|List| |#1|))
                                            (|:| |generator| |#1|))
                                  (|List| |#1|)))
                                T)
                              '((|gcd| (|#1| (|List| |#1|))) T)
                              '((|gcd| (|#1| |#1| |#1|)) T)
                              '((|exquo| ((|Union| |#1| #1#) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 51
                                            '(1 6 7 0 8 1 6 9 0 10 2 6 12 0 0
                                              13 1 6 0 0 18 2 6 0 0 0 19 1 6 21
                                              0 22 0 6 0 23 2 6 7 0 0 24 2 6 0
                                              0 0 25 0 6 0 26 2 6 0 0 0 27 2 6
                                              7 0 0 28 2 6 0 0 0 29 2 6 30 0 0
                                              32 2 6 16 0 0 33 2 37 7 0 0 38 1
                                              37 6 0 39 1 6 40 41 42 1 37 0 0
                                              46 2 37 0 0 9 47 3 6 35 0 0 0 48
                                              2 6 44 41 0 49 2 37 0 0 0 50 2 0
                                              7 0 0 11 2 0 0 0 0 15 2 0 0 0 0
                                              14 1 0 40 41 43 2 0 44 41 0 51 2
                                              0 0 0 0 20 3 0 35 0 0 0 36 2 0 30
                                              0 0 31 2 0 16 0 0 17 2 0 44 41 0
                                              45)))))
           '|lookupComplete|)) 

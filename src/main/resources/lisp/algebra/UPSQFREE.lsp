
(SDEFUN |UPSQFREE;squareFreePart;2P;1| ((|p| (P)) ($ (P)))
        (SPROG ((#1=#:G703 NIL))
               (PROG2
                   (LETT #1#
                         (SPADCALL |p|
                                   (SPADCALL |p| (SPADCALL |p| (QREFELT $ 8))
                                             (QREFELT $ 9))
                                   (QREFELT $ 11)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                 (|Union| (QREFELT $ 7) "failed") #1#)))) 

(SDEFUN |UPSQFREE;squareFreePart;2P;2| ((|p| (P)) ($ (P)))
        (SPROG
         ((#1=#:G726 NIL) (#2=#:G725 (P)) (#3=#:G727 (P)) (#4=#:G729 NIL)
          (|f| NIL) (|s| (|Factored| P)))
         (SEQ
          (SPADCALL
           (SPADCALL (LETT |s| (SPADCALL |p| (QREFELT $ 14))) (QREFELT $ 15))
           (PROGN
            (LETT #1# NIL)
            (SEQ (LETT |f| NIL) (LETT #4# (SPADCALL |s| (QREFELT $ 19))) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |f| (CAR #4#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (PROGN
                    (LETT #3# (QVELT |f| 1))
                    (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 20))))
                          ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (COND (#1# #2#) ('T (|spadConstant| $ 21))))
           (QREFELT $ 20))))) 

(SDEFUN |UPSQFREE;BumInSepFFE;2R;3|
        ((|ffe|
          (|Record|
           (|:| |flag| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
           (|:| |factor| P) (|:| |exponent| (|NonNegativeInteger|))))
         ($
          (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#)) (|:| |factor| P)
                    (|:| |exponent| (|NonNegativeInteger|)))))
        (VECTOR (CONS 1 "sqfr")
                (SPADCALL (ELT $ 22) (QVELT |ffe| 1) (QREFELT $ 24))
                (* (SPADCALL (QREFELT $ 26)) (QVELT |ffe| 2)))) 

(SDEFUN |UPSQFREE;BumInSepFFE;2R;4|
        ((|ffe|
          (|Record|
           (|:| |flag| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
           (|:| |factor| P) (|:| |exponent| (|NonNegativeInteger|))))
         ($
          (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#)) (|:| |factor| P)
                    (|:| |exponent| (|NonNegativeInteger|)))))
        (SPROG ((|nthrp| (|Union| P "failed")) (|np| (P)))
               (SEQ
                (LETT |np|
                      (SPADCALL (QVELT |ffe| 1) (SPADCALL (QREFELT $ 26))
                                (QREFELT $ 28)))
                (LETT |nthrp| (SPADCALL |np| (QREFELT $ 29)))
                (EXIT
                 (COND
                  ((QEQCAR |nthrp| 1)
                   (VECTOR (CONS 0 "nil") |np| (QVELT |ffe| 2)))
                  ('T
                   (VECTOR (CONS 1 "sqfr") (QCDR |nthrp|)
                           (* (SPADCALL (QREFELT $ 26)) (QVELT |ffe| 2))))))))) 

(SDEFUN |UPSQFREE;BumInSepFFE;2R;5|
        ((|ffe|
          (|Record|
           (|:| |flag| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
           (|:| |factor| P) (|:| |exponent| (|NonNegativeInteger|))))
         ($
          (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#)) (|:| |factor| P)
                    (|:| |exponent| (|NonNegativeInteger|)))))
        (VECTOR (CONS 0 "nil")
                (SPADCALL (QVELT |ffe| 1) (SPADCALL (QREFELT $ 26))
                          (QREFELT $ 28))
                (QVELT |ffe| 2))) 

(SDEFUN |UPSQFREE;squareFree;PF;6| ((|p| (P)) ($ (|Factored| P)))
        (SPROG
         ((#1=#:G777 NIL)
          (|lffe|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| P)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|lcp| (RC)) (#2=#:G769 NIL) (|i| (|NonNegativeInteger|)) (|pi| (P))
          (|di| (P)) (#3=#:G766 NIL) (|ci| (P)) (|a| (P)) (|c| (P)) (|u| (P))
          (|#G11|
           (|Record| (|:| |unit| P) (|:| |canonical| P) (|:| |associate| P))))
         (SEQ (LETT |ci| |p|) (LETT |di| (SPADCALL |p| (QREFELT $ 8)))
              (LETT |pi| (SPADCALL |ci| |di| (QREFELT $ 9)))
              (EXIT
               (COND
                ((EQL (SPADCALL |pi| (QREFELT $ 30)) 0)
                 (SEQ
                  (PROGN
                   (LETT |#G11| (SPADCALL |p| (QREFELT $ 33)))
                   (LETT |u| (QVELT |#G11| 0))
                   (LETT |c| (QVELT |#G11| 1))
                   (LETT |a| (QVELT |#G11| 2))
                   |#G11|)
                  (EXIT
                   (SPADCALL |u| (LIST (VECTOR (CONS 1 "sqfr") |c| 1))
                             (QREFELT $ 35)))))
                ('T
                 (SEQ (LETT |i| 0) (LETT |lffe| NIL)
                      (LETT |lcp| (SPADCALL |p| (QREFELT $ 36)))
                      (SEQ G190
                           (COND
                            ((NULL
                              (SPADCALL (SPADCALL |ci| (QREFELT $ 30)) 0
                                        (QREFELT $ 38)))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (SEQ
                              (LETT |ci|
                                    (PROG2
                                        (LETT #3#
                                              (SPADCALL |ci| |pi|
                                                        (QREFELT $ 11)))
                                        (QCDR #3#)
                                      (|check_union2| (QEQCAR #3# 0)
                                                      (QREFELT $ 7)
                                                      (|Union| (QREFELT $ 7)
                                                               #4="failed")
                                                      #3#)))
                              (LETT |di|
                                    (SPADCALL
                                     (PROG2
                                         (LETT #3#
                                               (SPADCALL |di| |pi|
                                                         (QREFELT $ 11)))
                                         (QCDR #3#)
                                       (|check_union2| (QEQCAR #3# 0)
                                                       (QREFELT $ 7)
                                                       (|Union| (QREFELT $ 7)
                                                                #4#)
                                                       #3#))
                                     (SPADCALL |ci| (QREFELT $ 8))
                                     (QREFELT $ 39)))
                              (LETT |pi| (SPADCALL |ci| |di| (QREFELT $ 9)))
                              (LETT |i| (+ |i| 1))
                              (EXIT
                               (COND
                                ((> (SPADCALL |pi| (QREFELT $ 30)) 0)
                                 (PROGN
                                  (LETT #1#
                                        (SEQ
                                         (LETT |lcp|
                                               (PROG2
                                                   (LETT #2#
                                                         (SPADCALL |lcp|
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     |pi|
                                                                     (QREFELT $
                                                                              36))
                                                                    |i|
                                                                    (QREFELT $
                                                                             40))
                                                                   (QREFELT $
                                                                            41)))
                                                   (QCDR #2#)
                                                 (|check_union2| (QEQCAR #2# 0)
                                                                 (QREFELT $ 6)
                                                                 (|Union|
                                                                  (QREFELT $ 6)
                                                                  #4#)
                                                                 #2#)))
                                         (EXIT
                                          (LETT |lffe|
                                                (CONS
                                                 (VECTOR (CONS 1 "sqfr") |pi|
                                                         |i|)
                                                 |lffe|)))))
                                  (GO #5=#:G772)))))))
                            #5# (EXIT #1#))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (SPADCALL (SPADCALL |lcp| (QREFELT $ 42)) |lffe|
                                 (QREFELT $ 35)))))))))) 

(SDEFUN |UPSQFREE;squareFree1|
        ((|p| (P))
         ($
          #1=(|Record| (|:| |f_list| (|List| P))
                       (|:| |e_list| (|List| (|NonNegativeInteger|))))))
        (SPROG
         ((|res_le| (|List| (|NonNegativeInteger|))) (|res_lf| (|List| P))
          (#2=#:G813 NIL) (|f| NIL) (#3=#:G814 NIL) (|e| NIL)
          (|le| (|List| (|NonNegativeInteger|))) (|lf| (|List| P))
          (|nle| (|List| (|NonNegativeInteger|))) (|nlf| (|List| P)) (|nf| (P))
          (|rec_f| (P)) (#4=#:G780 NIL) (|f1| (P)) (#5=#:G811 NIL)
          (#6=#:G812 NIL) (#7=#:G809 NIL) (#8=#:G810 NIL) (|rec_e| NIL)
          (|rec_el| (|List| (|NonNegativeInteger|))) (|rec_fl| (|List| P))
          (|res1| #1#) (|facs_pow| (P)) (|i| (|NonNegativeInteger|)) (|di| (P))
          (|facs| (P)) (|fac_i| (P)) (|dp| (P)))
         (SEQ (LETT |dp| (SPADCALL |p| (QREFELT $ 8)))
              (LETT |facs_pow| (SPADCALL |p| |dp| (QREFELT $ 9)))
              (EXIT
               (COND
                ((EQL (SPADCALL |facs_pow| (QREFELT $ 30)) 0)
                 (CONS (LIST |p|) (LIST 1)))
                (#9='T
                 (SEQ
                  (LETT |facs|
                        (PROG2
                            (LETT #4# (SPADCALL |p| |facs_pow| (QREFELT $ 11)))
                            (QCDR #4#)
                          (|check_union2| (QEQCAR #4# 0) (QREFELT $ 7)
                                          (|Union| (QREFELT $ 7) #10="failed")
                                          #4#)))
                  (LETT |i| 1) (LETT |lf| NIL) (LETT |le| NIL)
                  (LETT |di|
                        (SPADCALL
                         (PROG2
                             (LETT #4#
                                   (SPADCALL |dp| |facs_pow| (QREFELT $ 11)))
                             (QCDR #4#)
                           (|check_union2| (QEQCAR #4# 0) (QREFELT $ 7)
                                           (|Union| (QREFELT $ 7) #10#) #4#))
                         (SPADCALL |facs| (QREFELT $ 8)) (QREFELT $ 39)))
                  (SEQ G190
                       (COND
                        ((NULL
                          (COND
                           ((< |i| (- (QREFELT $ 44) 1))
                            (SPADCALL |di| (|spadConstant| $ 45)
                                      (QREFELT $ 46)))
                           ('T NIL)))
                         (GO G191)))
                       (SEQ (LETT |fac_i| (SPADCALL |facs| |di| (QREFELT $ 9)))
                            (COND
                             ((> (SPADCALL |fac_i| (QREFELT $ 30)) 0)
                              (SEQ (LETT |lf| (CONS |fac_i| |lf|))
                                   (EXIT (LETT |le| (CONS |i| |le|))))))
                            (LETT |facs|
                                  (PROG2
                                      (LETT #4#
                                            (SPADCALL |facs| |fac_i|
                                                      (QREFELT $ 11)))
                                      (QCDR #4#)
                                    (|check_union2| (QEQCAR #4# 0)
                                                    (QREFELT $ 7)
                                                    (|Union| (QREFELT $ 7)
                                                             #10#)
                                                    #4#)))
                            (LETT |facs_pow|
                                  (PROG2
                                      (LETT #4#
                                            (SPADCALL |facs_pow| |facs|
                                                      (QREFELT $ 11)))
                                      (QCDR #4#)
                                    (|check_union2| (QEQCAR #4# 0)
                                                    (QREFELT $ 7)
                                                    (|Union| (QREFELT $ 7)
                                                             #10#)
                                                    #4#)))
                            (LETT |di|
                                  (SPADCALL
                                   (PROG2
                                       (LETT #4#
                                             (SPADCALL |di| |fac_i|
                                                       (QREFELT $ 11)))
                                       (QCDR #4#)
                                     (|check_union2| (QEQCAR #4# 0)
                                                     (QREFELT $ 7)
                                                     (|Union| (QREFELT $ 7)
                                                              #10#)
                                                     #4#))
                                   (SPADCALL |facs| (QREFELT $ 8))
                                   (QREFELT $ 39)))
                            (EXIT (LETT |i| (+ |i| 1))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (COND
                   ((> (SPADCALL |facs| (QREFELT $ 30)) 0)
                    (SEQ (LETT |lf| (CONS |facs| |lf|))
                         (EXIT (LETT |le| (CONS |i| |le|))))))
                  (EXIT
                   (COND
                    ((EQL (SPADCALL |facs_pow| (QREFELT $ 30)) 0)
                     (CONS |lf| |le|))
                    (#9#
                     (SEQ
                      (LETT |facs_pow|
                            (SPADCALL (ELT $ 22)
                                      (PROG2
                                          (LETT #4#
                                                (SPADCALL |facs_pow|
                                                          (QREFELT $ 44)
                                                          (QREFELT $ 47)))
                                          (QCDR #4#)
                                        (|check_union2| (QEQCAR #4# 0)
                                                        (QREFELT $ 7)
                                                        (|Union| (QREFELT $ 7)
                                                                 #10#)
                                                        #4#))
                                      (QREFELT $ 24)))
                      (LETT |res1| (|UPSQFREE;squareFree1| |facs_pow| $))
                      (LETT |rec_fl| (QCAR |res1|))
                      (LETT |rec_el| (QCDR |res1|)) (LETT |res_lf| NIL)
                      (LETT |res_le| NIL)
                      (SEQ (LETT |rec_e| NIL) (LETT #8# |rec_el|)
                           (LETT #7# |rec_fl|) G190
                           (COND
                            ((OR (ATOM #7#)
                                 (PROGN (LETT |rec_f| (CAR #7#)) NIL)
                                 (ATOM #8#)
                                 (PROGN (LETT |rec_e| (CAR #8#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |nlf| NIL) (LETT |nle| NIL)
                                (SEQ (LETT |e| NIL) (LETT #6# |le|)
                                     (LETT |f| NIL) (LETT #5# |lf|) G190
                                     (COND
                                      ((OR (ATOM #5#)
                                           (PROGN (LETT |f| (CAR #5#)) NIL)
                                           (ATOM #6#)
                                           (PROGN (LETT |e| (CAR #6#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |f1|
                                            (SPADCALL |f| |rec_f|
                                                      (QREFELT $ 9)))
                                      (COND
                                       ((> (SPADCALL |f1| (QREFELT $ 30)) 0)
                                        (SEQ
                                         (LETT |res_lf| (CONS |f1| |res_lf|))
                                         (LETT |res_le|
                                               (CONS
                                                (+ (* (QREFELT $ 44) |rec_e|)
                                                   |e|)
                                                |res_le|))
                                         (LETT |nf|
                                               (PROG2
                                                   (LETT #4#
                                                         (SPADCALL |f| |f1|
                                                                   (QREFELT $
                                                                            11)))
                                                   (QCDR #4#)
                                                 (|check_union2| (QEQCAR #4# 0)
                                                                 (QREFELT $ 7)
                                                                 (|Union|
                                                                  (QREFELT $ 7)
                                                                  #10#)
                                                                 #4#)))
                                         (EXIT
                                          (LETT |rec_f|
                                                (PROG2
                                                    (LETT #4#
                                                          (SPADCALL |rec_f|
                                                                    |f1|
                                                                    (QREFELT $
                                                                             11)))
                                                    (QCDR #4#)
                                                  (|check_union2|
                                                   (QEQCAR #4# 0) (QREFELT $ 7)
                                                   (|Union| (QREFELT $ 7) #10#)
                                                   #4#))))))
                                       ('T (LETT |nf| |f|)))
                                      (EXIT
                                       (COND
                                        ((> (SPADCALL |nf| (QREFELT $ 30)) 0)
                                         (SEQ (LETT |nlf| (CONS |nf| |nlf|))
                                              (EXIT
                                               (LETT |nle|
                                                     (CONS |e| |nle|))))))))
                                     (LETT #5#
                                           (PROG1 (CDR #5#)
                                             (LETT #6# (CDR #6#))))
                                     (GO G190) G191 (EXIT NIL))
                                (COND
                                 ((> (SPADCALL |rec_f| (QREFELT $ 30)) 0)
                                  (SEQ (LETT |res_lf| (CONS |rec_f| |res_lf|))
                                       (EXIT
                                        (LETT |res_le|
                                              (CONS (* (QREFELT $ 44) |rec_e|)
                                                    |res_le|))))))
                                (LETT |lf| (NREVERSE |nlf|))
                                (EXIT (LETT |le| (NREVERSE |nle|))))
                           (LETT #7# (PROG1 (CDR #7#) (LETT #8# (CDR #8#))))
                           (GO G190) G191 (EXIT NIL))
                      (SEQ (LETT |e| NIL) (LETT #3# |le|) (LETT |f| NIL)
                           (LETT #2# |lf|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL)
                                 (ATOM #3#) (PROGN (LETT |e| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |res_lf| (CONS |f| |res_lf|))
                                (EXIT (LETT |res_le| (CONS |e| |res_le|))))
                           (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#))))
                           (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (CONS (NREVERSE |res_lf|)
                             (NREVERSE |res_le|)))))))))))))) 

(SDEFUN |UPSQFREE;squareFree;PF;8| ((|p| (P)) ($ (|Factored| P)))
        (SPROG
         ((|fl|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| P)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#1=#:G825 NIL) (|f| NIL) (#2=#:G826 NIL) (|e| NIL)
          (|res1|
           (|Record| (|:| |f_list| (|List| P))
                     (|:| |e_list| (|List| (|NonNegativeInteger|)))))
          (|u| (RC)))
         (SEQ (LETT |u| (SPADCALL |p| (QREFELT $ 36)))
              (LETT |res1|
                    (|UPSQFREE;squareFree1|
                     (SPADCALL
                      (SPADCALL (|spadConstant| $ 21) |u| (QREFELT $ 48)) |p|
                      (QREFELT $ 20))
                     $))
              (LETT |fl| NIL)
              (SEQ (LETT |e| NIL) (LETT #2# (QCDR |res1|)) (LETT |f| NIL)
                   (LETT #1# (QCAR |res1|)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL) (ATOM #2#)
                         (PROGN (LETT |e| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |fl| (CONS (VECTOR (CONS 1 "sqfr") |f| |e|) |fl|))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT
               (SPADCALL (SPADCALL |u| (QREFELT $ 42)) |fl| (QREFELT $ 35)))))) 

(SDEFUN |UPSQFREE;squareFree;PF;9| ((|p| (P)) ($ (|Factored| P)))
        (SPROG
         ((|lffe|
           (|List|
            (|Record|
             (|:| |flag| (|Union| #1="nil" #2="sqfr" #3="irred" #4="prime"))
             (|:| |factor| P) (|:| |exponent| (|NonNegativeInteger|)))))
          (|lsnil|
           (|List|
            (|Record| (|:| |flag| (|Union| #1# #2# #3# #4#)) (|:| |factor| P)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#5=#:G853 NIL) (|ffe| NIL) (#6=#:G852 NIL)
          (|redSqfr| (|Factored| P)) (#7=#:G836 NIL) (|dunit| (P)) (|pi| (P))
          (|lc| (RC)) (#8=#:G840 NIL) (|i| (|NonNegativeInteger|)) (|ci| (P))
          (|di| (P)) (|diprev| (P)) (|a| (P)) (|c| (P)) (|u| (P))
          (|#G24|
           (|Record| (|:| |unit| P) (|:| |canonical| P) (|:| |associate| P))))
         (SEQ
          (LETT |ci| (SPADCALL |p| (SPADCALL |p| (QREFELT $ 8)) (QREFELT $ 9)))
          (EXIT
           (COND
            ((EQL (SPADCALL |ci| (QREFELT $ 30)) 0)
             (SEQ
              (PROGN
               (LETT |#G24| (SPADCALL |p| (QREFELT $ 33)))
               (LETT |u| (QVELT |#G24| 0))
               (LETT |c| (QVELT |#G24| 1))
               (LETT |a| (QVELT |#G24| 2))
               |#G24|)
              (EXIT
               (SPADCALL |u| (LIST (VECTOR (CONS 1 "sqfr") |c| 1))
                         (QREFELT $ 35)))))
            (#9='T
             (SEQ
              (LETT |di|
                    (PROG2 (LETT #7# (SPADCALL |p| |ci| (QREFELT $ 11)))
                        (QCDR #7#)
                      (|check_union2| (QEQCAR #7# 0) (QREFELT $ 7)
                                      (|Union| (QREFELT $ 7) #10="failed")
                                      #7#)))
              (LETT |i| 0) (LETT |lffe| NIL)
              (LETT |dunit| (|spadConstant| $ 21))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL (SPADCALL |di| (QREFELT $ 30)) 0
                                (QREFELT $ 38)))
                     (GO G191)))
                   (SEQ (LETT |diprev| |di|)
                        (LETT |di| (SPADCALL |ci| |di| (QREFELT $ 9)))
                        (LETT |ci|
                              (PROG2
                                  (LETT #7#
                                        (SPADCALL |ci| |di| (QREFELT $ 11)))
                                  (QCDR #7#)
                                (|check_union2| (QEQCAR #7# 0) (QREFELT $ 7)
                                                (|Union| (QREFELT $ 7) #10#)
                                                #7#)))
                        (LETT |i| (+ |i| 1))
                        (EXIT
                         (COND
                          ((EQL (SPADCALL |diprev| (QREFELT $ 30))
                                (SPADCALL |di| (QREFELT $ 30)))
                           (SEQ
                            (LETT |lc|
                                  (PROG2
                                      (LETT #8#
                                            (SPADCALL
                                             (SPADCALL |diprev| (QREFELT $ 36))
                                             (SPADCALL |di| (QREFELT $ 36))
                                             (QREFELT $ 41)))
                                      (QCDR #8#)
                                    (|check_union2| (QEQCAR #8# 0)
                                                    (QREFELT $ 6)
                                                    (|Union| (QREFELT $ 6)
                                                             #10#)
                                                    #8#)))
                            (EXIT
                             (LETT |dunit|
                                   (SPADCALL (SPADCALL |lc| |i| (QREFELT $ 40))
                                             |dunit| (QREFELT $ 49))))))
                          ('T
                           (SEQ
                            (LETT |pi|
                                  (PROG2
                                      (LETT #7#
                                            (SPADCALL |diprev| |di|
                                                      (QREFELT $ 11)))
                                      (QCDR #7#)
                                    (|check_union2| (QEQCAR #7# 0)
                                                    (QREFELT $ 7)
                                                    (|Union| (QREFELT $ 7)
                                                             #10#)
                                                    #7#)))
                            (EXIT
                             (LETT |lffe|
                                   (CONS (VECTOR (CONS 1 "sqfr") |pi| |i|)
                                         |lffe|))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |dunit|
                    (SPADCALL |dunit| (SPADCALL |di| (+ |i| 1) (QREFELT $ 50))
                              (QREFELT $ 20)))
              (EXIT
               (COND
                ((EQL (SPADCALL |ci| (QREFELT $ 30)) 0)
                 (SPADCALL (SPADCALL |dunit| |ci| (QREFELT $ 20)) |lffe|
                           (QREFELT $ 35)))
                (#9#
                 (SEQ
                  (LETT |redSqfr|
                        (SPADCALL
                         (PROG2
                             (LETT #7#
                                   (SPADCALL |ci| (SPADCALL (QREFELT $ 26))
                                             (QREFELT $ 47)))
                             (QCDR #7#)
                           (|check_union2| (QEQCAR #7# 0) (QREFELT $ 7)
                                           (|Union| (QREFELT $ 7) #10#) #7#))
                         (QREFELT $ 14)))
                  (LETT |lsnil|
                        (PROGN
                         (LETT #6# NIL)
                         (SEQ (LETT |ffe| NIL)
                              (LETT #5# (SPADCALL |redSqfr| (QREFELT $ 19)))
                              G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |ffe| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #6#
                                      (CONS (SPADCALL |ffe| (QREFELT $ 27))
                                            #6#))))
                              (LETT #5# (CDR #5#)) (GO G190) G191
                              (EXIT (NREVERSE #6#)))))
                  (LETT |lffe| (SPADCALL |lsnil| |lffe| (QREFELT $ 51)))
                  (EXIT
                   (SPADCALL
                    (SPADCALL |dunit| (SPADCALL |redSqfr| (QREFELT $ 15))
                              (QREFELT $ 20))
                    |lffe| (QREFELT $ 35)))))))))))))) 

(DECLAIM (NOTINLINE |UnivariatePolynomialSquareFree;|)) 

(DEFUN |UnivariatePolynomialSquareFree| (&REST #1=#:G854)
  (SPROG NIL
         (PROG (#2=#:G855)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariatePolynomialSquareFree|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |UnivariatePolynomialSquareFree;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariatePolynomialSquareFree|)))))))))) 

(DEFUN |UnivariatePolynomialSquareFree;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|UnivariatePolynomialSquareFree| DV$1 DV$2))
          (LETT $ (GETREFV 52))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|UnivariatePolynomialSquareFree|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|CharacteristicZero|))
            (QSETREFV $ 12
                      (CONS (|dispatchFunction| |UPSQFREE;squareFreePart;2P;1|)
                            $)))
           ('T
            (QSETREFV $ 12
                      (CONS (|dispatchFunction| |UPSQFREE;squareFreePart;2P;2|)
                            $))))
          (COND
           ((|HasCategory| |#1| '(|FiniteFieldCategory|))
            (QSETREFV $ 27
                      (CONS (|dispatchFunction| |UPSQFREE;BumInSepFFE;2R;3|)
                            $)))
           ((|HasCategory| |#1| '(|CharacteristicNonZero|))
            (QSETREFV $ 27
                      (CONS (|dispatchFunction| |UPSQFREE;BumInSepFFE;2R;4|)
                            $)))
           ('T
            (QSETREFV $ 27
                      (CONS (|dispatchFunction| |UPSQFREE;BumInSepFFE;2R;5|)
                            $))))
          (COND
           ((|HasCategory| |#1| '(|CharacteristicZero|))
            (QSETREFV $ 14
                      (CONS (|dispatchFunction| |UPSQFREE;squareFree;PF;6|)
                            $)))
           ((|HasCategory| |#1| '(|FiniteFieldCategory|))
            (PROGN
             (QSETREFV $ 44 (SPADCALL (QREFELT $ 43)))
             (QSETREFV $ 14
                       (CONS (|dispatchFunction| |UPSQFREE;squareFree;PF;8|)
                             $))))
           ('T
            (QSETREFV $ 14
                      (CONS (|dispatchFunction| |UPSQFREE;squareFree;PF;9|)
                            $))))
          $))) 

(MAKEPROP '|UnivariatePolynomialSquareFree| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |differentiate|) (5 . |gcd|) (|Union| $ '"failed")
              (11 . |exquo|) (17 . |squareFreePart|) (|Factored| 7)
              (22 . |squareFree|) (27 . |unit|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 16) (|:| |factor| 7) (|:| |exponent| 25))
              (|List| 17) (32 . |factorList|) (37 . *) (43 . |One|)
              (47 . |charthRoot|) (|Mapping| 6 6) (52 . |map|)
              (|NonNegativeInteger|) (58 . |characteristic|)
              (62 . |BumInSepFFE|) (67 . |multiplyExponents|)
              (73 . |charthRoot|) (78 . |degree|) (83 . |Zero|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (87 . |unitNormal|) (92 . |One|) (96 . |makeFR|)
              (102 . |leadingCoefficient|) (|Boolean|) (107 . ~=) (113 . -)
              (119 . ^) (125 . |exquo|) (131 . |coerce|)
              (136 . |characteristic|) '|char_RC| (140 . |Zero|) (144 . ~=)
              (150 . |divideExponents|) (156 . /) (162 . *) (168 . ^)
              (174 . |append|))
           '#(|squareFreePart| 180 |squareFree| 185 |BumInSepFFE| 190) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|squareFree| ((|Factored| |#2|) |#2|)) T)
                                   '((|squareFreePart| (|#2| |#2|)) T)
                                   '((|BumInSepFFE|
                                      ((|Record|
                                        (|:| |flag|
                                             (|Union| #1="nil" #2="sqfr"
                                                      #3="irred" #4="prime"))
                                        (|:| |factor| |#2|)
                                        (|:| |exponent|
                                             (|NonNegativeInteger|)))
                                       (|Record|
                                        (|:| |flag| (|Union| #1# #2# #3# #4#))
                                        (|:| |factor| |#2|)
                                        (|:| |exponent|
                                             (|NonNegativeInteger|)))))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 51
                                            '(1 7 0 0 8 2 7 0 0 0 9 2 7 10 0 0
                                              11 1 0 7 7 12 1 0 13 7 14 1 13 7
                                              0 15 1 13 18 0 19 2 7 0 0 0 20 0
                                              7 0 21 1 6 0 0 22 2 7 0 23 0 24 0
                                              7 25 26 1 0 17 17 27 2 7 0 0 25
                                              28 1 7 10 0 29 1 7 25 0 30 0 6 0
                                              31 1 7 32 0 33 0 6 0 34 2 13 0 7
                                              18 35 1 7 6 0 36 2 25 37 0 0 38 2
                                              7 0 0 0 39 2 6 0 0 25 40 2 6 10 0
                                              0 41 1 7 0 6 42 0 6 25 43 0 7 0
                                              45 2 7 37 0 0 46 2 7 10 0 25 47 2
                                              7 0 0 6 48 2 7 0 6 0 49 2 7 0 0
                                              25 50 2 18 0 0 0 51 1 0 7 7 12 1
                                              0 13 7 14 1 0 17 17 27)))))
           '|lookupComplete|)) 

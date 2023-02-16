
(SDEFUN |CRAPACK;modTree;R2L;1| ((|a| (R)) (|lm| (|List| R)) ($ (|List| R)))
        (SPROG ((|t| (BB)))
               (SEQ
                (LETT |t|
                      (SPADCALL (LENGTH |lm|) (|spadConstant| $ 8)
                                (QREFELT $ 10)))
                (SPADCALL |t| |lm| (QREFELT $ 12))
                (SPADCALL |t| (ELT $ 13) (QREFELT $ 15))
                (EXIT
                 (SPADCALL (SPADCALL |t| |a| (ELT $ 16) (QREFELT $ 17))
                           (QREFELT $ 18)))))) 

(SDEFUN |CRAPACK;chineseRemainder;2LR;2|
        ((|lv| (|List| R)) (|lm| (|List| R)) ($ (R)))
        (SPROG
         ((|y| (BB)) (|l| (|List| R)) (#1=#:G722 NIL) (|v| NIL) (#2=#:G723 NIL)
          (#3=#:G724 NIL) (|m| NIL) (#4=#:G721 NIL) (|linv| (|List| R))
          (|inv| (R))
          (|u| (|Union| (|Record| (|:| |coef1| R) (|:| |coef2| R)) "failed"))
          (|x| (BB)))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |lm|) (LENGTH |lv|) (QREFELT $ 21))
            (|error| "lists of moduli and values not of same length"))
           (#5='T
            (SEQ
             (LETT |x|
                   (SPADCALL (LENGTH |lm|) (|spadConstant| $ 8)
                             (QREFELT $ 10)))
             (LETT |x| (SPADCALL |x| |lm| (QREFELT $ 12)))
             (SPADCALL |x| (ELT $ 13) (QREFELT $ 15))
             (LETT |y|
                   (SPADCALL (LENGTH |lm|) (|spadConstant| $ 22)
                             (QREFELT $ 10)))
             (LETT |y|
                   (SPADCALL (SPADCALL |y| (QREFELT $ 23)) |x|
                             (CONS #'|CRAPACK;chineseRemainder;2LR;2!0| $)
                             (QREFELT $ 26)))
             (LETT |u|
                   (SPADCALL (SPADCALL |y| (QREFELT $ 27))
                             (SPADCALL |x| (QREFELT $ 27))
                             (|spadConstant| $ 22) (QREFELT $ 30)))
             (EXIT
              (COND ((QEQCAR |u| 1) (|error| "moduli not relatively prime"))
                    (#5#
                     (SEQ (LETT |inv| (QCAR (QCDR |u|)))
                          (LETT |linv| (SPADCALL |inv| |lm| (QREFELT $ 19)))
                          (LETT |l|
                                (PROGN
                                 (LETT #4# NIL)
                                 (SEQ (LETT |m| NIL) (LETT #3# |lm|)
                                      (LETT #2# |linv|) (LETT |v| NIL)
                                      (LETT #1# |lv|) G190
                                      (COND
                                       ((OR (ATOM #1#)
                                            (PROGN (LETT |v| (CAR #1#)) NIL)
                                            (ATOM #2#)
                                            (PROGN (LETT |u| (CAR #2#)) NIL)
                                            (ATOM #3#)
                                            (PROGN (LETT |m| (CAR #3#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #4#
                                              (CONS
                                               (SPADCALL
                                                (SPADCALL |u| |v|
                                                          (QREFELT $ 13))
                                                |m| (QREFELT $ 16))
                                               #4#))))
                                      (LETT #1#
                                            (PROG1 (CDR #1#)
                                              (LETT #2#
                                                    (PROG1 (CDR #2#)
                                                      (LETT #3# (CDR #3#))))))
                                      (GO G190) G191 (EXIT (NREVERSE #4#)))))
                          (LETT |y| (SPADCALL |y| |l| (QREFELT $ 12)))
                          (EXIT
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL |y| |x|
                                       (CONS
                                        #'|CRAPACK;chineseRemainder;2LR;2!1| $)
                                       (QREFELT $ 26))
                             (QREFELT $ 27))
                            (SPADCALL |x| (QREFELT $ 27))
                            (QREFELT $ 16))))))))))))) 

(SDEFUN |CRAPACK;chineseRemainder;2LR;2!1|
        ((|x1| NIL) (|x2| NIL) (|x3| NIL) (|x4| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x1| |x4| (QREFELT $ 13))
                  (SPADCALL |x2| |x3| (QREFELT $ 13)) (QREFELT $ 24))) 

(SDEFUN |CRAPACK;chineseRemainder;2LR;2!0|
        ((|x1| NIL) (|x2| NIL) (|x3| NIL) (|x4| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x1| |x4| (QREFELT $ 13))
                  (SPADCALL |x2| |x3| (QREFELT $ 13)) (QREFELT $ 24))) 

(SDEFUN |CRAPACK;chineseRemainder;L2L;3|
        ((|llv| (|List| (|List| R))) (|lm| (|List| R)) ($ (|List| R)))
        (SPROG
         ((|retVal| (|List| R)) (|y| (BB)) (|l| (|List| R)) (#1=#:G743 NIL)
          (|v| NIL) (#2=#:G744 NIL) (|u3| NIL) (#3=#:G745 NIL) (|m| NIL)
          (#4=#:G742 NIL) (#5=#:G741 NIL) (|lv| NIL) (|linv| (|List| R))
          (|inv| (R))
          (|u| (|Union| (|Record| (|:| |coef1| R) (|:| |coef2| R)) "failed"))
          (|x| (BB)))
         (SEQ
          (LETT |x|
                (SPADCALL (LENGTH |lm|) (|spadConstant| $ 8) (QREFELT $ 10)))
          (LETT |x| (SPADCALL |x| |lm| (QREFELT $ 12)))
          (SPADCALL |x| (ELT $ 13) (QREFELT $ 15))
          (LETT |y|
                (SPADCALL (LENGTH |lm|) (|spadConstant| $ 22) (QREFELT $ 10)))
          (LETT |y|
                (SPADCALL (SPADCALL |y| (QREFELT $ 23)) |x|
                          (CONS #'|CRAPACK;chineseRemainder;L2L;3!0| $)
                          (QREFELT $ 26)))
          (LETT |u|
                (SPADCALL (SPADCALL |y| (QREFELT $ 27))
                          (SPADCALL |x| (QREFELT $ 27)) (|spadConstant| $ 22)
                          (QREFELT $ 30)))
          (EXIT
           (COND ((QEQCAR |u| 1) (|error| "moduli not relatively prime"))
                 ('T
                  (SEQ (LETT |inv| (QCAR (QCDR |u|)))
                       (LETT |linv| (SPADCALL |inv| |lm| (QREFELT $ 19)))
                       (LETT |retVal| NIL)
                       (SEQ (LETT |lv| NIL) (LETT #5# |llv|) G190
                            (COND
                             ((OR (ATOM #5#) (PROGN (LETT |lv| (CAR #5#)) NIL))
                              (GO G191)))
                            (SEQ
                             (LETT |l|
                                   (PROGN
                                    (LETT #4# NIL)
                                    (SEQ (LETT |m| NIL) (LETT #3# |lm|)
                                         (LETT |u3| NIL) (LETT #2# |linv|)
                                         (LETT |v| NIL) (LETT #1# |lv|) G190
                                         (COND
                                          ((OR (ATOM #1#)
                                               (PROGN (LETT |v| (CAR #1#)) NIL)
                                               (ATOM #2#)
                                               (PROGN
                                                (LETT |u3| (CAR #2#))
                                                NIL)
                                               (ATOM #3#)
                                               (PROGN
                                                (LETT |m| (CAR #3#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #4#
                                                 (CONS
                                                  (SPADCALL
                                                   (SPADCALL |u3| |v|
                                                             (QREFELT $ 13))
                                                   |m| (QREFELT $ 16))
                                                  #4#))))
                                         (LETT #1#
                                               (PROG1 (CDR #1#)
                                                 (LETT #2#
                                                       (PROG1 (CDR #2#)
                                                         (LETT #3#
                                                               (CDR #3#))))))
                                         (GO G190) G191
                                         (EXIT (NREVERSE #4#)))))
                             (LETT |y| (SPADCALL |y| |l| (QREFELT $ 12)))
                             (EXIT
                              (LETT |retVal|
                                    (CONS
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |y| |x|
                                                 (CONS
                                                  #'|CRAPACK;chineseRemainder;L2L;3!1|
                                                  $)
                                                 (QREFELT $ 26))
                                       (QREFELT $ 27))
                                      (SPADCALL |x| (QREFELT $ 27))
                                      (QREFELT $ 16))
                                     |retVal|))))
                            (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                       (EXIT (REVERSE |retVal|))))))))) 

(SDEFUN |CRAPACK;chineseRemainder;L2L;3!1|
        ((|x1| NIL) (|x2| NIL) (|x3| NIL) (|x4| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x1| |x4| (QREFELT $ 13))
                  (SPADCALL |x2| |x3| (QREFELT $ 13)) (QREFELT $ 24))) 

(SDEFUN |CRAPACK;chineseRemainder;L2L;3!0|
        ((|x1| NIL) (|x2| NIL) (|x3| NIL) (|x4| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x1| |x4| (QREFELT $ 13))
                  (SPADCALL |x2| |x3| (QREFELT $ 13)) (QREFELT $ 24))) 

(SDEFUN |CRAPACK;extEuclidean| ((|a| (R)) (|b| (R)) (|c| (R)) ($ (|List| R)))
        (SPROG
         ((|u| (|Union| (|Record| (|:| |coef1| R) (|:| |coef2| R)) "failed")))
         (SEQ (LETT |u| (SPADCALL |a| |b| |c| (QREFELT $ 30)))
              (EXIT
               (COND
                ((QEQCAR |u| 1)
                 (|error|
                  (LIST '|mathprint|
                        (LIST 'CONCAT (SPADCALL |c| (QREFELT $ 35))
                              (SPADCALL " not spanned by " (QREFELT $ 37))
                              (SPADCALL |a| (QREFELT $ 35))
                              (SPADCALL " and " (QREFELT $ 37))
                              (SPADCALL |b| (QREFELT $ 35))))))
                ('T (LIST (QCDR (QCDR |u|)) (QCAR (QCDR |u|))))))))) 

(SDEFUN |CRAPACK;multiEuclideanTree;LRL;5|
        ((|fl| (|List| R)) (|rhs| (R)) ($ (|List| R)))
        (SPROG ((|x| (BB)))
               (SEQ (LETT |x| (SPADCALL (LENGTH |fl|) |rhs| (QREFELT $ 10)))
                    (LETT |x| (SPADCALL |x| |fl| (QREFELT $ 12)))
                    (SPADCALL |x| (ELT $ 13) (QREFELT $ 15))
                    (EXIT
                     (SPADCALL
                      (SPADCALL |x| |rhs|
                                (CONS (|function| |CRAPACK;extEuclidean|) $)
                                (QREFELT $ 39))
                      (QREFELT $ 18)))))) 

(DECLAIM (NOTINLINE |CRApackage;|)) 

(DEFUN |CRApackage| (#1=#:G761)
  (SPROG NIL
         (PROG (#2=#:G762)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|CRApackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|CRApackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|CRApackage|)))))))))) 

(DEFUN |CRApackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|CRApackage| DV$1))
          (LETT $ (GETREFV 41))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CRApackage| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|BalancedBinaryTree| |#1|))
          $))) 

(MAKEPROP '|CRApackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) 'BB (0 . |Zero|)
              (|NonNegativeInteger|) (4 . |balancedBinaryTree|) (|List| 6)
              (10 . |setleaves!|) (16 . *) (|Mapping| 6 6 6) (22 . |mapUp!|)
              (28 . |rem|) (34 . |mapDown!|) (41 . |leaves|)
              |CRAPACK;modTree;R2L;1| (|Boolean|) (46 . ~=) (52 . |One|)
              (56 . |copy|) (61 . +) (|Mapping| 6 6 6 6 6) (67 . |mapUp!|)
              (74 . |value|) (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 28 '"failed") (79 . |extendedEuclidean|)
              |CRAPACK;chineseRemainder;2LR;2| (|List| 11)
              |CRAPACK;chineseRemainder;L2L;3| (|OutputForm|) (86 . |coerce|)
              (|String|) (91 . |coerce|) (|Mapping| 11 6 6 6) (96 . |mapDown!|)
              |CRAPACK;multiEuclideanTree;LRL;5|)
           '#(|multiEuclideanTree| 103 |modTree| 109 |chineseRemainder| 115)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|modTree| ((|List| |#1|) |#1| (|List| |#1|)))
                                T)
                              '((|chineseRemainder|
                                 (|#1| (|List| |#1|) (|List| |#1|)))
                                T)
                              '((|chineseRemainder|
                                 ((|List| |#1|) (|List| (|List| |#1|))
                                  (|List| |#1|)))
                                T)
                              '((|multiEuclideanTree|
                                 ((|List| |#1|) (|List| |#1|) |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 40
                                            '(0 6 0 8 2 7 0 9 6 10 2 7 0 0 11
                                              12 2 6 0 0 0 13 2 7 6 0 14 15 2 6
                                              0 0 0 16 3 7 0 0 6 14 17 1 7 11 0
                                              18 2 9 20 0 0 21 0 6 0 22 1 7 0 0
                                              23 2 6 0 0 0 24 3 7 0 0 0 25 26 1
                                              7 6 0 27 3 6 29 0 0 0 30 1 6 34 0
                                              35 1 36 34 0 37 3 7 0 0 6 38 39 2
                                              0 11 11 6 40 2 0 11 6 11 19 2 0 6
                                              11 11 31 2 0 11 32 11 33)))))
           '|lookupComplete|)) 

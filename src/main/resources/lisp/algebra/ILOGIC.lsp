
(SDEFUN |ILOGIC;proposition;S$;1| ((|s| (|String|)) ($ ($)))
        (CONS 1 (LIST |s|))) 

(SDEFUN |ILOGIC;logicT;$;2| (($ ($))) (CONS 0 (LIST 'T))) 

(SDEFUN |ILOGIC;logicF;$;3| (($ ($))) (CONS 0 (LIST 'F))) 

(SDEFUN |ILOGIC;~;2$;4| ((|b| ($)) ($ ($)))
        (SPROG ((#1=#:G807 NIL) (|d| ($)) (|c| ($)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |b| 0)
                    (COND
                     ((EQUAL (QCAR (CDR |b|)) 'T)
                      (PROGN (LETT #1# (CONS 0 (LIST 'F))) (GO #2=#:G806))))))
                  (COND
                   ((QEQCAR |b| 3)
                    (SEQ (LETT |c| (QCDR (CDR |b|)))
                         (EXIT
                          (COND
                           ((QEQCAR |c| 3)
                            (SEQ (LETT |d| (QCDR (CDR |c|)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |d| 0)
                                    (COND
                                     ((EQUAL (QCAR (CDR |d|)) 'T)
                                      (PROGN
                                       (LETT #1# (CONS 0 (LIST 'F)))
                                       (GO #2#))))))))))))))
                  (EXIT (CONS 3 (CONS 'NOT |b|)))))
                #2# (EXIT #1#)))) 

(SDEFUN |ILOGIC;/\\;3$;5| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((#1=#:G824 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |a| 0)
                    (COND
                     ((EQUAL (QCAR (CDR |a|)) 'F)
                      (PROGN (LETT #1# (CONS 0 (LIST 'F))) (GO #2=#:G823))))))
                  (COND
                   ((QEQCAR |b| 0)
                    (COND
                     ((EQUAL (QCAR (CDR |b|)) 'F)
                      (PROGN (LETT #1# (CONS 0 (LIST 'F))) (GO #2#))))))
                  (COND
                   ((SPADCALL |a| |b| (QREFELT $ 13))
                    (PROGN (LETT #1# |a|) (GO #2#))))
                  (COND
                   ((SPADCALL |a| (SPADCALL |b| (QREFELT $ 11)) (QREFELT $ 13))
                    (PROGN (LETT #1# (CONS 0 (LIST 'F))) (GO #2#))))
                  (COND
                   ((SPADCALL (SPADCALL |a| (QREFELT $ 11)) |b| (QREFELT $ 13))
                    (PROGN (LETT #1# (CONS 0 (LIST 'F))) (GO #2#))))
                  (COND
                   ((QEQCAR |b| 0)
                    (COND
                     ((EQUAL (QCAR (CDR |b|)) 'T)
                      (PROGN (LETT #1# |a|) (GO #2#))))))
                  (COND
                   ((QEQCAR |a| 0)
                    (COND
                     ((EQUAL (QCAR (CDR |a|)) 'T)
                      (PROGN (LETT #1# |b|) (GO #2#))))))
                  (EXIT (CONS 2 (VECTOR 'AND |a| |b|)))))
                #2# (EXIT #1#)))) 

(SDEFUN |ILOGIC;\\/;3$;6| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((#1=#:G839 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |a| 0)
                    (COND
                     ((EQUAL (QCAR (CDR |a|)) 'T)
                      (PROGN (LETT #1# (CONS 0 (LIST 'T))) (GO #2=#:G838))))))
                  (COND
                   ((QEQCAR |b| 0)
                    (COND
                     ((EQUAL (QCAR (CDR |b|)) 'T)
                      (PROGN (LETT #1# (CONS 0 (LIST 'T))) (GO #2#))))))
                  (COND
                   ((SPADCALL |a| |b| (QREFELT $ 13))
                    (PROGN (LETT #1# |a|) (GO #2#))))
                  (COND
                   ((QEQCAR |b| 0)
                    (COND
                     ((EQUAL (QCAR (CDR |b|)) 'F)
                      (PROGN (LETT #1# |a|) (GO #2#))))))
                  (COND
                   ((QEQCAR |a| 0)
                    (COND
                     ((EQUAL (QCAR (CDR |a|)) 'F)
                      (PROGN (LETT #1# |b|) (GO #2#))))))
                  (EXIT (CONS 2 (VECTOR 'OR |a| |b|)))))
                #2# (EXIT #1#)))) 

(SDEFUN |ILOGIC;implies;3$;7| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((#1=#:G853 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |a| 0)
                    (COND
                     ((QEQCAR |b| 0)
                      (SEQ
                       (COND
                        ((SPADCALL (QCAR (CDR |a|)) 'F (QREFELT $ 17))
                         (COND
                          ((EQUAL (QCAR (CDR |b|)) 'F)
                           (PROGN
                            (LETT #1# (CONS 0 (LIST 'F)))
                            (GO #2=#:G852))))))
                       (EXIT
                        (PROGN (LETT #1# (CONS 0 (LIST 'T))) (GO #2#))))))))
                  (EXIT (CONS 2 (VECTOR 'IMPLY |a| |b|)))))
                #2# (EXIT #1#)))) 

(SDEFUN |ILOGIC;redux;2$;8| ((|n| ($)) ($ ($)))
        (SPROG ((#1=#:G867 NIL) (#2=#:G763 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND ((QEQCAR |n| 0) (PROGN (LETT #1# |n|) (GO #3=#:G866))))
                  (COND ((QEQCAR |n| 1) (PROGN (LETT #1# |n|) (GO #3#))))
                  (COND
                   ((QEQCAR |n| 2)
                    (SEQ
                     (COND
                      ((EQUAL
                        (QVELT
                         (PROG2 (LETT #2# |n|)
                             (QCDR #2#)
                           (|check_union2| (QEQCAR #2# 2)
                                           (|Record| (|:| |typ| (|Symbol|))
                                                     (|:| |c1| $) (|:| |c2| $))
                                           (|Union|
                                            (|:| |const|
                                                 (|Record|
                                                  (|:| |val| (|Symbol|))))
                                            (|:| |var|
                                                 (|Record|
                                                  (|:| |str| (|String|))))
                                            (|:| |binaryOp|
                                                 (|Record|
                                                  (|:| |typ| (|Symbol|))
                                                  (|:| |c1| $) (|:| |c2| $)))
                                            (|:| |unaryOp|
                                                 (|Record|
                                                  (|:| |typ| (|Symbol|))
                                                  (|:| |c1| $))))
                                           #2#))
                         0)
                        'IMPLY)
                       (PROGN
                        (LETT #1#
                              (SPADCALL
                               (SPADCALL
                                (QVELT
                                 (PROG2 (LETT #2# |n|)
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 2)
                                                   (|Record|
                                                    (|:| |typ| (|Symbol|))
                                                    (|:| |c1| $) (|:| |c2| $))
                                                   (|Union|
                                                    (|:| |const|
                                                         (|Record|
                                                          (|:| |val|
                                                               (|Symbol|))))
                                                    (|:| |var|
                                                         (|Record|
                                                          (|:| |str|
                                                               (|String|))))
                                                    (|:| |binaryOp|
                                                         (|Record|
                                                          (|:| |typ|
                                                               (|Symbol|))
                                                          (|:| |c1| $)
                                                          (|:| |c2| $)))
                                                    (|:| |unaryOp|
                                                         (|Record|
                                                          (|:| |typ|
                                                               (|Symbol|))
                                                          (|:| |c1| $))))
                                                   #2#))
                                 1)
                                (QREFELT $ 19))
                               (SPADCALL
                                (QVELT
                                 (PROG2 (LETT #2# |n|)
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 2)
                                                   (|Record|
                                                    (|:| |typ| (|Symbol|))
                                                    (|:| |c1| $) (|:| |c2| $))
                                                   (|Union|
                                                    (|:| |const|
                                                         (|Record|
                                                          (|:| |val|
                                                               (|Symbol|))))
                                                    (|:| |var|
                                                         (|Record|
                                                          (|:| |str|
                                                               (|String|))))
                                                    (|:| |binaryOp|
                                                         (|Record|
                                                          (|:| |typ|
                                                               (|Symbol|))
                                                          (|:| |c1| $)
                                                          (|:| |c2| $)))
                                                    (|:| |unaryOp|
                                                         (|Record|
                                                          (|:| |typ|
                                                               (|Symbol|))
                                                          (|:| |c1| $))))
                                                   #2#))
                                 2)
                                (QREFELT $ 19))
                               (QREFELT $ 18)))
                        (GO #3#))))
                     (COND
                      ((EQUAL
                        (QVELT
                         (PROG2 (LETT #2# |n|)
                             (QCDR #2#)
                           (|check_union2| (QEQCAR #2# 2)
                                           (|Record| (|:| |typ| (|Symbol|))
                                                     (|:| |c1| $) (|:| |c2| $))
                                           (|Union|
                                            (|:| |const|
                                                 (|Record|
                                                  (|:| |val| (|Symbol|))))
                                            (|:| |var|
                                                 (|Record|
                                                  (|:| |str| (|String|))))
                                            (|:| |binaryOp|
                                                 (|Record|
                                                  (|:| |typ| (|Symbol|))
                                                  (|:| |c1| $) (|:| |c2| $)))
                                            (|:| |unaryOp|
                                                 (|Record|
                                                  (|:| |typ| (|Symbol|))
                                                  (|:| |c1| $))))
                                           #2#))
                         0)
                        'AND)
                       (PROGN
                        (LETT #1#
                              (SPADCALL
                               (SPADCALL
                                (QVELT
                                 (PROG2 (LETT #2# |n|)
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 2)
                                                   (|Record|
                                                    (|:| |typ| (|Symbol|))
                                                    (|:| |c1| $) (|:| |c2| $))
                                                   (|Union|
                                                    (|:| |const|
                                                         (|Record|
                                                          (|:| |val|
                                                               (|Symbol|))))
                                                    (|:| |var|
                                                         (|Record|
                                                          (|:| |str|
                                                               (|String|))))
                                                    (|:| |binaryOp|
                                                         (|Record|
                                                          (|:| |typ|
                                                               (|Symbol|))
                                                          (|:| |c1| $)
                                                          (|:| |c2| $)))
                                                    (|:| |unaryOp|
                                                         (|Record|
                                                          (|:| |typ|
                                                               (|Symbol|))
                                                          (|:| |c1| $))))
                                                   #2#))
                                 1)
                                (QREFELT $ 19))
                               (SPADCALL
                                (QVELT
                                 (PROG2 (LETT #2# |n|)
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 2)
                                                   (|Record|
                                                    (|:| |typ| (|Symbol|))
                                                    (|:| |c1| $) (|:| |c2| $))
                                                   (|Union|
                                                    (|:| |const|
                                                         (|Record|
                                                          (|:| |val|
                                                               (|Symbol|))))
                                                    (|:| |var|
                                                         (|Record|
                                                          (|:| |str|
                                                               (|String|))))
                                                    (|:| |binaryOp|
                                                         (|Record|
                                                          (|:| |typ|
                                                               (|Symbol|))
                                                          (|:| |c1| $)
                                                          (|:| |c2| $)))
                                                    (|:| |unaryOp|
                                                         (|Record|
                                                          (|:| |typ|
                                                               (|Symbol|))
                                                          (|:| |c1| $))))
                                                   #2#))
                                 2)
                                (QREFELT $ 19))
                               (QREFELT $ 14)))
                        (GO #3#))))
                     (EXIT
                      (COND
                       ((EQUAL
                         (QVELT
                          (PROG2 (LETT #2# |n|)
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 2)
                                            (|Record| (|:| |typ| (|Symbol|))
                                                      (|:| |c1| $)
                                                      (|:| |c2| $))
                                            (|Union|
                                             (|:| |const|
                                                  (|Record|
                                                   (|:| |val| (|Symbol|))))
                                             (|:| |var|
                                                  (|Record|
                                                   (|:| |str| (|String|))))
                                             (|:| |binaryOp|
                                                  (|Record|
                                                   (|:| |typ| (|Symbol|))
                                                   (|:| |c1| $) (|:| |c2| $)))
                                             (|:| |unaryOp|
                                                  (|Record|
                                                   (|:| |typ| (|Symbol|))
                                                   (|:| |c1| $))))
                                            #2#))
                          0)
                         'OR)
                        (PROGN
                         (LETT #1#
                               (SPADCALL
                                (SPADCALL
                                 (QVELT
                                  (PROG2 (LETT #2# |n|)
                                      (QCDR #2#)
                                    (|check_union2| (QEQCAR #2# 2)
                                                    (|Record|
                                                     (|:| |typ| (|Symbol|))
                                                     (|:| |c1| $) (|:| |c2| $))
                                                    (|Union|
                                                     (|:| |const|
                                                          (|Record|
                                                           (|:| |val|
                                                                (|Symbol|))))
                                                     (|:| |var|
                                                          (|Record|
                                                           (|:| |str|
                                                                (|String|))))
                                                     (|:| |binaryOp|
                                                          (|Record|
                                                           (|:| |typ|
                                                                (|Symbol|))
                                                           (|:| |c1| $)
                                                           (|:| |c2| $)))
                                                     (|:| |unaryOp|
                                                          (|Record|
                                                           (|:| |typ|
                                                                (|Symbol|))
                                                           (|:| |c1| $))))
                                                    #2#))
                                  1)
                                 (QREFELT $ 19))
                                (SPADCALL
                                 (QVELT
                                  (PROG2 (LETT #2# |n|)
                                      (QCDR #2#)
                                    (|check_union2| (QEQCAR #2# 2)
                                                    (|Record|
                                                     (|:| |typ| (|Symbol|))
                                                     (|:| |c1| $) (|:| |c2| $))
                                                    (|Union|
                                                     (|:| |const|
                                                          (|Record|
                                                           (|:| |val|
                                                                (|Symbol|))))
                                                     (|:| |var|
                                                          (|Record|
                                                           (|:| |str|
                                                                (|String|))))
                                                     (|:| |binaryOp|
                                                          (|Record|
                                                           (|:| |typ|
                                                                (|Symbol|))
                                                           (|:| |c1| $)
                                                           (|:| |c2| $)))
                                                     (|:| |unaryOp|
                                                          (|Record|
                                                           (|:| |typ|
                                                                (|Symbol|))
                                                           (|:| |c1| $))))
                                                    #2#))
                                  2)
                                 (QREFELT $ 19))
                                (QREFELT $ 15)))
                         (GO #3#))))))))
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (SPADCALL (SPADCALL (QCDR (CDR |n|)) (QREFELT $ 19))
                                     (QREFELT $ 11)))
                     (GO #3#))))
                  (EXIT |n|)))
                #3# (EXIT #1#)))) 

(SDEFUN |ILOGIC;factor;$L;9| ((|n| ($)) ($ (|List| $)))
        (SPROG ((|ch| (|List| $)) (#1=#:G890 NIL) (#2=#:G763 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((NOT (QEQCAR |n| 2))
                    (PROGN (LETT #1# (LIST |n|)) (GO #3=#:G889))))
                  (COND
                   ((NOT
                     (EQUAL
                      (QVELT
                       (PROG2 (LETT #2# |n|)
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 2)
                                         (|Record| (|:| |typ| (|Symbol|))
                                                   (|:| |c1| $) (|:| |c2| $))
                                         (|Union|
                                          (|:| |const|
                                               (|Record|
                                                (|:| |val| (|Symbol|))))
                                          (|:| |var|
                                               (|Record|
                                                (|:| |str| (|String|))))
                                          (|:| |binaryOp|
                                               (|Record| (|:| |typ| (|Symbol|))
                                                         (|:| |c1| $)
                                                         (|:| |c2| $)))
                                          (|:| |unaryOp|
                                               (|Record| (|:| |typ| (|Symbol|))
                                                         (|:| |c1| $))))
                                         #2#))
                       0)
                      'AND))
                    (PROGN (LETT #1# (LIST |n|)) (GO #3#))))
                  (LETT |ch| (SPADCALL |n| (QREFELT $ 21)))
                  (EXIT
                   (SPADCALL
                    (SPADCALL (SPADCALL |ch| (QREFELT $ 23)) (QREFELT $ 24))
                    (SPADCALL (SPADCALL |ch| (QREFELT $ 25)) (QREFELT $ 24))
                    (QREFELT $ 26)))))
                #3# (EXIT #1#)))) 

(SDEFUN |ILOGIC;removeDup| ((|a| (|List| $)) (|b| (|List| $)) ($ (|List| $)))
        (SPROG
         ((|res| (|List| $)) (|fnd| (|Boolean|)) (#1=#:G899 NIL) (|a1| NIL)
          (#2=#:G898 NIL) (|b1| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |b1| NIL) (LETT #2# |b|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |b1| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |fnd| 'NIL)
                        (SEQ (LETT |a1| NIL) (LETT #1# |a|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |a1| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |a1| |b1| (QREFELT $ 13))
                                 (LETT |fnd| 'T)))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((NULL |fnd|)
                           (LETT |res|
                                 (SPADCALL |res| |b1| (QREFELT $ 27)))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |ILOGIC;deductions1| ((|ln| (|List| $)) ($ (|List| $)))
        (SPROG
         ((|res| (|List| $)) (#1=#:G918 NIL) (|n2| NIL) (|ch| (|List| $))
          (#2=#:G917 NIL) (|n| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |n| NIL) (LETT #2# |ln|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |n| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((QEQCAR |n| 2)
                       (COND
                        ((EQUAL (QVELT (CDR |n|) 0) 'IMPLY)
                         (SEQ (LETT |ch| (SPADCALL |n| (QREFELT $ 21)))
                              (EXIT
                               (SEQ (LETT |n2| NIL) (LETT #1# |ln|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |n2| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL
                                         (SPADCALL |ch| (QREFELT $ 23)) |n2|
                                         (QREFELT $ 13))
                                        (LETT |res|
                                              (SPADCALL |res|
                                                        (SPADCALL |ch|
                                                                  (QREFELT $
                                                                           25))
                                                        (QREFELT $ 27)))))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT NIL))))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |ILOGIC;deductions;2L;12| ((|ln| (|List| $)) ($ (|List| $)))
        (SPROG
         ((|loopbreaker| (|NonNegativeInteger|)) (|emptyres| (|Boolean|))
          (|res| (|List| $)) (|thisres| (|List| $)) (|allres| (|List| $)))
         (SEQ (LETT |res| NIL) (LETT |thisres| (|ILOGIC;deductions1| |ln| $))
              (LETT |res| (SPADCALL |res| |thisres| (QREFELT $ 26)))
              (LETT |emptyres| (SPADCALL |thisres| (QREFELT $ 28)))
              (LETT |loopbreaker| 1)
              (SEQ G190
                   (COND
                    ((NULL (COND (|emptyres| NIL) ('T (< |loopbreaker| 20))))
                     (GO G191)))
                   (SEQ (LETT |allres| (SPADCALL |ln| |res| (QREFELT $ 26)))
                        (LETT |thisres| (|ILOGIC;deductions1| |allres| $))
                        (LETT |thisres| (|ILOGIC;removeDup| |res| |thisres| $))
                        (LETT |thisres|
                              (|ILOGIC;removeDup| |allres| |thisres| $))
                        (LETT |res| (SPADCALL |res| |thisres| (QREFELT $ 26)))
                        (LETT |emptyres| (SPADCALL |thisres| (QREFELT $ 28)))
                        (EXIT (LETT |loopbreaker| (+ |loopbreaker| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |ILOGIC;opType;$S;13| ((|n| ($)) ($ (|Symbol|)))
        (SPROG ((#1=#:G929 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 2)
                    (PROGN (LETT #1# (QVELT (CDR |n|) 0)) (GO #2=#:G928))))
                  (COND ((QEQCAR |n| 3) (PROGN (LETT #1# 'NOT) (GO #2#))))
                  (EXIT 'OTHER)))
                #2# (EXIT #1#)))) 

(SDEFUN |ILOGIC;atom?;$B;14| ((|n| ($)) ($ (|Boolean|)))
        (COND ((QEQCAR |n| 1) 'T) ('T (QEQCAR |n| 0)))) 

(SDEFUN |ILOGIC;value;$S;15| ((|n| ($)) ($ (|Symbol|)))
        (SPROG ((#1=#:G944 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 0)
                    (SEQ
                     (COND
                      ((EQUAL (QCAR (CDR |n|)) 'F)
                       (PROGN (LETT #1# 'F) (GO #2=#:G943))))
                     (COND
                      ((EQUAL (QCAR (CDR |n|)) 'T)
                       (PROGN (LETT #1# 'T) (GO #2#))))
                     (EXIT (PROGN (LETT #1# 'E) (GO #2#))))))
                  (COND ((QEQCAR |n| 1) (PROGN (LETT #1# 'P) (GO #2#))))
                  (EXIT 'C)))
                #2# (EXIT #1#)))) 

(SDEFUN |ILOGIC;getChildren;$L;16| ((|n| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G950 NIL) (#2=#:G764 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |n| (QREFELT $ 31))
                    (PROGN (LETT #1# NIL) (GO #3=#:G949))))
                  (COND
                   ((QEQCAR |n| 2)
                    (PROGN
                     (LETT #1# (LIST (QVELT (CDR |n|) 1) (QVELT (CDR |n|) 2)))
                     (GO #3#))))
                  (EXIT
                   (COND
                    ((QEQCAR |n| 3)
                     (PROGN
                      (LETT #1#
                            (LIST
                             (QCDR
                              (PROG2 (LETT #2# |n|)
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 3)
                                                (|Record|
                                                 (|:| |typ| (|Symbol|))
                                                 (|:| |c1| $))
                                                (|Union|
                                                 (|:| |const|
                                                      (|Record|
                                                       (|:| |val| (|Symbol|))))
                                                 (|:| |var|
                                                      (|Record|
                                                       (|:| |str| (|String|))))
                                                 (|:| |binaryOp|
                                                      (|Record|
                                                       (|:| |typ| (|Symbol|))
                                                       (|:| |c1| $)
                                                       (|:| |c2| $)))
                                                 (|:| |unaryOp|
                                                      (|Record|
                                                       (|:| |typ| (|Symbol|))
                                                       (|:| |c1| $))))
                                                #2#)))))
                      (GO #3#)))))))
                #3# (EXIT #1#)))) 

(SDEFUN |ILOGIC;=;2$B;17| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SEQ
         (COND
          ((QEQCAR |a| 0)
           (COND
            ((QEQCAR |b| 0)
             (EXIT
              (SEQ
               (COND
                ((EQUAL (QCAR (CDR |a|)) 'F)
                 (COND ((EQUAL (QCAR (CDR |b|)) 'F) (EXIT 'T)))))
               (COND
                ((EQUAL (QCAR (CDR |a|)) 'T)
                 (COND ((EQUAL (QCAR (CDR |b|)) 'T) (EXIT 'T)))))
               (EXIT NIL)))))))
         (COND
          ((QEQCAR |a| 1)
           (COND
            ((QEQCAR |b| 1)
             (EXIT
              (COND ((EQUAL (QCAR (CDR |a|)) (QCAR (CDR |b|))) 'T)
                    (#1='T NIL)))))))
         (COND
          ((QEQCAR |a| 2)
           (COND
            ((QEQCAR |b| 2)
             (EXIT
              (COND
               ((SPADCALL (QVELT (CDR |a|) 0) (QVELT (CDR |b|) 0)
                          (QREFELT $ 17))
                NIL)
               (#1#
                (SEQ
                 (COND
                  ((SPADCALL (QVELT (CDR |a|) 1) (QVELT (CDR |b|) 1)
                             (QREFELT $ 13))
                   (COND
                    ((SPADCALL (QVELT (CDR |a|) 2) (QVELT (CDR |b|) 2)
                               (QREFELT $ 13))
                     (EXIT 'T)))))
                 (EXIT NIL)))))))))
         (COND
          ((QEQCAR |a| 3)
           (COND
            ((QEQCAR |b| 3)
             (EXIT
              (NULL
               (OR (SPADCALL (QCAR (CDR |a|)) (QCAR (CDR |b|)) (QREFELT $ 17))
                   (NULL
                    (SPADCALL (QCDR (CDR |a|)) (QCDR (CDR |b|))
                              (QREFELT $ 13))))))))))
         (EXIT NIL))) 

(SDEFUN |ILOGIC;parseBracketTerm|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| #1#) (#2=#:G982 NIL) (|ch| (|Character|)) (|trm| ($))
          (|r2| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |trm| (SPADCALL (QREFELT $ 9)))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| "(")))
                  (SEQ (|error| "bracket term must start with (")
                       (EXIT
                        (PROGN (LETT #2# (CONS |trm| |p1|)) (GO #3=#:G981))))))
                (LETT |p1| (+ |p1| 1))
                (COND
                 ((> |p1| (SPADCALL |t1| (QREFELT $ 34)))
                  (SEQ (|error| "opening but no closing bracket")
                       (EXIT (PROGN (LETT #2# (CONS |trm| |p1|)) (GO #3#))))))
                (LETT |r2| (SPADCALL |t1| |p1| (QREFELT $ 37)))
                (LETT |trm| (QCAR |r2|)) (LETT |p1| (QCDR |r2|))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| ")")))
                  (SEQ (|error| "can't find closing bracket")
                       (EXIT (PROGN (LETT #2# (CONS |trm| |p1|)) (GO #3#))))))
                (LETT |p1| (+ |p1| 1)) (EXIT (CONS |trm| |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |ILOGIC;parseILand|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|)) (|firstTerm| ($))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| #1#) (|secondTerm| ($))
          (|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (#2=#:G989 NIL) (|ch| (|Character|)) (|trm| ($)))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |trm| (SPADCALL (QREFELT $ 9)))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| "/")))
                  (SEQ (|error| "expecting /\\")
                       (EXIT
                        (PROGN (LETT #2# (CONS |trm| |p1|)) (GO #3=#:G988))))))
                (LETT |p1| (+ |p1| 1)) (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| "\\")))
                  (SEQ (|error| "expecting /\\")
                       (EXIT (PROGN (LETT #2# (CONS |trm| |p1|)) (GO #3#))))))
                (LETT |p1| (+ |p1| 1))
                (LETT |r| (SPADCALL |t1| |p1| (QREFELT $ 37)))
                (LETT |secondTerm| (QCAR |r|)) (LETT |p1| (QCDR |r|))
                (EXIT
                 (CONS (SPADCALL |firstTerm| |secondTerm| (QREFELT $ 14))
                       |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |ILOGIC;parseILor|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|)) (|firstTerm| ($))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| #1#) (|secondTerm| ($))
          (|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (#2=#:G996 NIL) (|ch| (|Character|)) (|trm| ($)))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |trm| (SPADCALL (QREFELT $ 9)))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| "\\")))
                  (SEQ (|error| "expecting \\/")
                       (EXIT
                        (PROGN (LETT #2# (CONS |trm| |p1|)) (GO #3=#:G995))))))
                (LETT |p1| (+ |p1| 1)) (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| "/")))
                  (SEQ (|error| "expecting \\/")
                       (EXIT (PROGN (LETT #2# (CONS |trm| |p1|)) (GO #3#))))))
                (LETT |p1| (+ |p1| 1))
                (LETT |r| (SPADCALL |t1| |p1| (QREFELT $ 37)))
                (LETT |secondTerm| (QCAR |r|)) (LETT |p1| (QCDR |r|))
                (EXIT
                 (CONS (SPADCALL |firstTerm| |secondTerm| (QREFELT $ 15))
                       |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |ILOGIC;parseILfn|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|)) (|firstTerm| ($))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| #1#) (|secondTerm| ($))
          (|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (#2=#:G1003 NIL) (|ch| (|Character|)) (|trm| ($)))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |trm| (SPADCALL (QREFELT $ 9)))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| "-")))
                  (SEQ (|error| "expecting ->")
                       (EXIT
                        (PROGN
                         (LETT #2# (CONS |trm| |p1|))
                         (GO #3=#:G1002))))))
                (LETT |p1| (+ |p1| 1)) (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| ">")))
                  (SEQ (|error| "expecting ->")
                       (EXIT (PROGN (LETT #2# (CONS |trm| |p1|)) (GO #3#))))))
                (LETT |p1| (+ |p1| 1))
                (LETT |r| (SPADCALL |t1| |p1| (QREFELT $ 37)))
                (LETT |secondTerm| (QCAR |r|)) (LETT |p1| (QCDR |r|))
                (EXIT
                 (CONS (SPADCALL |firstTerm| |secondTerm| (QREFELT $ 18))
                       |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |ILOGIC;parseILName|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|ch| (|Character|)) (#2=#:G1010 NIL) (|pt| #1#) (|vnm| (|String|)))
         (SEQ
          (EXIT
           (SEQ (LETT |vnm| "") (LETT |pt| |pin|)
                (LETT |ch| (STR_ELT1 |t1| |pt|))
                (SEQ G190
                     (COND ((NULL (SPADCALL |ch| (QREFELT $ 39))) (GO G191)))
                     (SEQ (LETT |vnm| (SPADCALL |vnm| |ch| (QREFELT $ 40)))
                          (LETT |pt| (+ |pt| 1))
                          (COND
                           ((> |pt| (SPADCALL |t1| (QREFELT $ 34)))
                            (PROGN
                             (LETT #2#
                                   (CONS (SPADCALL |vnm| (QREFELT $ 8)) |pt|))
                             (GO #3=#:G1009))))
                          (EXIT (LETT |ch| (STR_ELT1 |t1| |pt|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS (SPADCALL |vnm| (QREFELT $ 8)) |pt|))))
          #3# (EXIT #2#)))) 

(SDEFUN |ILOGIC;parseILTerm;SNniR;23|
        ((|t1| (|String|)) (|pin| (|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| (|NonNegativeInteger|)) (|res| ($))
          (|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (|ch| (|Character|)) (#1=#:G1028 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |res| (SPADCALL (QREFELT $ 9)))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (SEQ G190
                     (COND
                      ((NULL (|eql_SI| |ch| (|STR_to_CHAR| " "))) (GO G191)))
                     (SEQ (LETT |p1| (+ |p1| 1))
                          (COND
                           ((> |p1| (SPADCALL |t1| (QREFELT $ 34)))
                            (PROGN
                             (LETT #1# (CONS |res| |p1|))
                             (GO #2=#:G1027))))
                          (EXIT (LETT |ch| (STR_ELT1 |t1| |p1|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (LETT |r| (CONS |res| |p1|))
                (COND
                 ((SPADCALL |ch| (QREFELT $ 41))
                  (LETT |r| (|ILOGIC;parseILName| |t1| |p1| $))))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| "("))
                  (LETT |r| (|ILOGIC;parseBracketTerm| |t1| |p1| $))))
                (LETT |res| (QCAR |r|)) (LETT |p1| (QCDR |r|))
                (COND
                 ((> |p1| (SPADCALL |t1| (QREFELT $ 34)))
                  (PROGN (LETT #1# (CONS |res| |p1|)) (GO #2#))))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| " "))
                  (SEQ (LETT |p1| (+ |p1| 1))
                       (EXIT
                        (COND
                         ((> |p1| (SPADCALL |t1| (QREFELT $ 34)))
                          (PROGN (LETT #1# (CONS |res| |p1|)) (GO #2#))))))))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| "/"))
                  (SEQ (LETT |r| (|ILOGIC;parseILand| |t1| |p1| |res| $))
                       (LETT |res| (QCAR |r|)) (EXIT (LETT |p1| (QCDR |r|))))))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| "\\"))
                  (SEQ (LETT |r| (|ILOGIC;parseILor| |t1| |p1| |res| $))
                       (LETT |res| (QCAR |r|)) (EXIT (LETT |p1| (QCDR |r|))))))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| "-"))
                  (SEQ (LETT |r| (|ILOGIC;parseILfn| |t1| |p1| |res| $))
                       (LETT |res| (QCAR |r|)) (EXIT (LETT |p1| (QCDR |r|))))))
                (EXIT (CONS |res| |p1|))))
          #2# (EXIT #1#)))) 

(SDEFUN |ILOGIC;parseIL2;SNniR;24|
        ((|t1| (|String|)) (|pin| (|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| (|NonNegativeInteger|)) (|res| ($))
          (|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (|ch| (|Character|)) (#1=#:G1037 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |res| (SPADCALL (QREFELT $ 9)))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (SEQ G190
                     (COND
                      ((NULL (|eql_SI| |ch| (|STR_to_CHAR| " "))) (GO G191)))
                     (SEQ (LETT |p1| (+ |p1| 1))
                          (COND
                           ((> |p1| (SPADCALL |t1| (QREFELT $ 34)))
                            (PROGN
                             (LETT #1# (CONS |res| |p1|))
                             (GO #2=#:G1036))))
                          (EXIT (LETT |ch| (STR_ELT1 |t1| |p1|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (LETT |r| (CONS |res| |p1|))
                (COND
                 ((SPADCALL |ch| (QREFELT $ 41))
                  (LETT |r| (|ILOGIC;parseILName| |t1| |p1| $))))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| "("))
                  (LETT |r| (|ILOGIC;parseBracketTerm| |t1| |p1| $))))
                (LETT |res| (QCAR |r|)) (LETT |p1| (QCDR |r|))
                (EXIT (CONS |res| |p1|))))
          #2# (EXIT #1#)))) 

(SDEFUN |ILOGIC;parseIL;S$;25| ((|t1| (|String|)) ($ ($)))
        (SPROG
         ((|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (#1=#:G1038 NIL))
         (SEQ
          (LETT |r|
                (SPADCALL |t1|
                          (PROG1 (LETT #1# (SPADCALL |t1| (QREFELT $ 43)))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#))
                          (QREFELT $ 37)))
          (EXIT (QCAR |r|))))) 

(SDEFUN |ILOGIC;toString;$S;26| ((|n| ($)) ($ (|String|)))
        (SPROG ((#1=#:G1057 NIL) (#2=#:G763 NIL) (|s1| (|String|)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 0)
                    (SEQ
                     (COND
                      ((EQUAL (QCAR (CDR |n|)) 'F)
                       (PROGN (LETT #1# "_|_") (GO #3=#:G1056))))
                     (COND
                      ((EQUAL (QCAR (CDR |n|)) 'T)
                       (PROGN (LETT #1# "T") (GO #3#))))
                     (EXIT (PROGN (LETT #1# "?") (GO #3#))))))
                  (COND
                   ((QEQCAR |n| 1)
                    (PROGN (LETT #1# (QCAR (CDR |n|))) (GO #3#))))
                  (COND
                   ((QEQCAR |n| 2)
                    (SEQ (LETT |s1| "->")
                         (COND
                          ((EQUAL
                            (QVELT
                             (PROG2 (LETT #2# |n|)
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 2)
                                               (|Record| (|:| |typ| (|Symbol|))
                                                         (|:| |c1| $)
                                                         (|:| |c2| $))
                                               (|Union|
                                                (|:| |const|
                                                     (|Record|
                                                      (|:| |val| (|Symbol|))))
                                                (|:| |var|
                                                     (|Record|
                                                      (|:| |str| (|String|))))
                                                (|:| |binaryOp|
                                                     (|Record|
                                                      (|:| |typ| (|Symbol|))
                                                      (|:| |c1| $)
                                                      (|:| |c2| $)))
                                                (|:| |unaryOp|
                                                     (|Record|
                                                      (|:| |typ| (|Symbol|))
                                                      (|:| |c1| $))))
                                               #2#))
                             0)
                            'AND)
                           (LETT |s1| "/\\")))
                         (COND
                          ((EQUAL
                            (QVELT
                             (PROG2 (LETT #2# |n|)
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 2)
                                               (|Record| (|:| |typ| (|Symbol|))
                                                         (|:| |c1| $)
                                                         (|:| |c2| $))
                                               (|Union|
                                                (|:| |const|
                                                     (|Record|
                                                      (|:| |val| (|Symbol|))))
                                                (|:| |var|
                                                     (|Record|
                                                      (|:| |str| (|String|))))
                                                (|:| |binaryOp|
                                                     (|Record|
                                                      (|:| |typ| (|Symbol|))
                                                      (|:| |c1| $)
                                                      (|:| |c2| $)))
                                                (|:| |unaryOp|
                                                     (|Record|
                                                      (|:| |typ| (|Symbol|))
                                                      (|:| |c1| $))))
                                               #2#))
                             0)
                            'OR)
                           (LETT |s1| "\\/")))
                         (EXIT
                          (PROGN
                           (LETT #1#
                                 (SPADCALL
                                  (LIST "("
                                        (SPADCALL
                                         (QVELT
                                          (PROG2 (LETT #2# |n|)
                                              (QCDR #2#)
                                            (|check_union2| (QEQCAR #2# 2)
                                                            (|Record|
                                                             (|:| |typ|
                                                                  (|Symbol|))
                                                             (|:| |c1| $)
                                                             (|:| |c2| $))
                                                            (|Union|
                                                             (|:| |const|
                                                                  (|Record|
                                                                   (|:| |val|
                                                                        (|Symbol|))))
                                                             (|:| |var|
                                                                  (|Record|
                                                                   (|:| |str|
                                                                        (|String|))))
                                                             (|:| |binaryOp|
                                                                  (|Record|
                                                                   (|:| |typ|
                                                                        (|Symbol|))
                                                                   (|:| |c1| $)
                                                                   (|:| |c2|
                                                                        $)))
                                                             (|:| |unaryOp|
                                                                  (|Record|
                                                                   (|:| |typ|
                                                                        (|Symbol|))
                                                                   (|:| |c1|
                                                                        $))))
                                                            #2#))
                                          1)
                                         (QREFELT $ 45))
                                        |s1|
                                        (SPADCALL
                                         (QVELT
                                          (PROG2 (LETT #2# |n|)
                                              (QCDR #2#)
                                            (|check_union2| (QEQCAR #2# 2)
                                                            (|Record|
                                                             (|:| |typ|
                                                                  (|Symbol|))
                                                             (|:| |c1| $)
                                                             (|:| |c2| $))
                                                            (|Union|
                                                             (|:| |const|
                                                                  (|Record|
                                                                   (|:| |val|
                                                                        (|Symbol|))))
                                                             (|:| |var|
                                                                  (|Record|
                                                                   (|:| |str|
                                                                        (|String|))))
                                                             (|:| |binaryOp|
                                                                  (|Record|
                                                                   (|:| |typ|
                                                                        (|Symbol|))
                                                                   (|:| |c1| $)
                                                                   (|:| |c2|
                                                                        $)))
                                                             (|:| |unaryOp|
                                                                  (|Record|
                                                                   (|:| |typ|
                                                                        (|Symbol|))
                                                                   (|:| |c1|
                                                                        $))))
                                                            #2#))
                                          2)
                                         (QREFELT $ 45))
                                        ")")
                                  (QREFELT $ 46)))
                           (GO #3#))))))
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (SPADCALL
                            (LIST "~("
                                  (SPADCALL (QCDR (CDR |n|)) (QREFELT $ 45))
                                  ")")
                            (QREFELT $ 46)))
                     (GO #3#))))
                  (EXIT (|error| "toString: unexpected representation"))))
                #3# (EXIT #1#)))) 

(SDEFUN |ILOGIC;toStringUnwrapped;$S;27| ((|n| ($)) ($ (|String|)))
        (SPROG ((#1=#:G1074 NIL) (#2=#:G763 NIL) (|s1| (|String|)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 0)
                    (SEQ
                     (COND
                      ((EQUAL (QCAR (CDR |n|)) 'F)
                       (PROGN (LETT #1# "_|_") (GO #3=#:G1073))))
                     (COND
                      ((EQUAL (QCAR (CDR |n|)) 'T)
                       (PROGN (LETT #1# "T") (GO #3#))))
                     (EXIT (PROGN (LETT #1# "?") (GO #3#))))))
                  (COND
                   ((QEQCAR |n| 1)
                    (PROGN (LETT #1# (QCAR (CDR |n|))) (GO #3#))))
                  (COND
                   ((QEQCAR |n| 2)
                    (SEQ (LETT |s1| "->")
                         (COND
                          ((EQUAL
                            (QVELT
                             (PROG2 (LETT #2# |n|)
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 2)
                                               (|Record| (|:| |typ| (|Symbol|))
                                                         (|:| |c1| $)
                                                         (|:| |c2| $))
                                               (|Union|
                                                (|:| |const|
                                                     (|Record|
                                                      (|:| |val| (|Symbol|))))
                                                (|:| |var|
                                                     (|Record|
                                                      (|:| |str| (|String|))))
                                                (|:| |binaryOp|
                                                     (|Record|
                                                      (|:| |typ| (|Symbol|))
                                                      (|:| |c1| $)
                                                      (|:| |c2| $)))
                                                (|:| |unaryOp|
                                                     (|Record|
                                                      (|:| |typ| (|Symbol|))
                                                      (|:| |c1| $))))
                                               #2#))
                             0)
                            'AND)
                           (LETT |s1| "/\\")))
                         (COND
                          ((EQUAL
                            (QVELT
                             (PROG2 (LETT #2# |n|)
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 2)
                                               (|Record| (|:| |typ| (|Symbol|))
                                                         (|:| |c1| $)
                                                         (|:| |c2| $))
                                               (|Union|
                                                (|:| |const|
                                                     (|Record|
                                                      (|:| |val| (|Symbol|))))
                                                (|:| |var|
                                                     (|Record|
                                                      (|:| |str| (|String|))))
                                                (|:| |binaryOp|
                                                     (|Record|
                                                      (|:| |typ| (|Symbol|))
                                                      (|:| |c1| $)
                                                      (|:| |c2| $)))
                                                (|:| |unaryOp|
                                                     (|Record|
                                                      (|:| |typ| (|Symbol|))
                                                      (|:| |c1| $))))
                                               #2#))
                             0)
                            'OR)
                           (LETT |s1| "\\/")))
                         (EXIT
                          (PROGN
                           (LETT #1#
                                 (SPADCALL
                                  (LIST
                                   (SPADCALL
                                    (QVELT
                                     (PROG2 (LETT #2# |n|)
                                         (QCDR #2#)
                                       (|check_union2| (QEQCAR #2# 2)
                                                       (|Record|
                                                        (|:| |typ| (|Symbol|))
                                                        (|:| |c1| $)
                                                        (|:| |c2| $))
                                                       (|Union|
                                                        (|:| |const|
                                                             (|Record|
                                                              (|:| |val|
                                                                   (|Symbol|))))
                                                        (|:| |var|
                                                             (|Record|
                                                              (|:| |str|
                                                                   (|String|))))
                                                        (|:| |binaryOp|
                                                             (|Record|
                                                              (|:| |typ|
                                                                   (|Symbol|))
                                                              (|:| |c1| $)
                                                              (|:| |c2| $)))
                                                        (|:| |unaryOp|
                                                             (|Record|
                                                              (|:| |typ|
                                                                   (|Symbol|))
                                                              (|:| |c1| $))))
                                                       #2#))
                                     1)
                                    (QREFELT $ 45))
                                   |s1|
                                   (SPADCALL
                                    (QVELT
                                     (PROG2 (LETT #2# |n|)
                                         (QCDR #2#)
                                       (|check_union2| (QEQCAR #2# 2)
                                                       (|Record|
                                                        (|:| |typ| (|Symbol|))
                                                        (|:| |c1| $)
                                                        (|:| |c2| $))
                                                       (|Union|
                                                        (|:| |const|
                                                             (|Record|
                                                              (|:| |val|
                                                                   (|Symbol|))))
                                                        (|:| |var|
                                                             (|Record|
                                                              (|:| |str|
                                                                   (|String|))))
                                                        (|:| |binaryOp|
                                                             (|Record|
                                                              (|:| |typ|
                                                                   (|Symbol|))
                                                              (|:| |c1| $)
                                                              (|:| |c2| $)))
                                                        (|:| |unaryOp|
                                                             (|Record|
                                                              (|:| |typ|
                                                                   (|Symbol|))
                                                              (|:| |c1| $))))
                                                       #2#))
                                     2)
                                    (QREFELT $ 45)))
                                  (QREFELT $ 46)))
                           (GO #3#))))))
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (SPADCALL
                            (LIST "~("
                                  (SPADCALL (QCDR (CDR |n|)) (QREFELT $ 45))
                                  ")")
                            (QREFELT $ 46)))
                     (GO #3#))))
                  (EXIT
                   (|error| "toStringUnwrapped: unexpected representation"))))
                #3# (EXIT #1#)))) 

(SDEFUN |ILOGIC;coerce;$Of;28| ((|n| ($)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G764 NIL) (#2=#:G763 NIL) (|s1| (|OutputForm|))
          (#3=#:G762 NIL))
         (SEQ
          (COND
           ((QEQCAR |n| 0)
            (COND ((EQUAL (QCAR (CDR |n|)) 'F) (SPADCALL "_|_" (QREFELT $ 49)))
                  ((EQUAL (QCAR (CDR |n|)) 'T) (SPADCALL "T" (QREFELT $ 49)))
                  (#4='T (SPADCALL "?" (QREFELT $ 49)))))
           ((QEQCAR |n| 1)
            (SPADCALL
             (QCAR
              (PROG2 (LETT #3# |n|)
                  (QCDR #3#)
                (|check_union2| (QEQCAR #3# 1)
                                (|Record| (|:| |str| (|String|)))
                                (|Union|
                                 (|:| |const|
                                      (|Record| (|:| |val| (|Symbol|))))
                                 (|:| |var| (|Record| (|:| |str| (|String|))))
                                 (|:| |binaryOp|
                                      (|Record| (|:| |typ| (|Symbol|))
                                                (|:| |c1| $) (|:| |c2| $)))
                                 (|:| |unaryOp|
                                      (|Record| (|:| |typ| (|Symbol|))
                                                (|:| |c1| $))))
                                #3#)))
             (QREFELT $ 49)))
           ((QEQCAR |n| 2)
            (SEQ (LETT |s1| (SPADCALL "->" (QREFELT $ 49)))
                 (COND
                  ((EQUAL
                    (QVELT
                     (PROG2 (LETT #2# |n|)
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 2)
                                       (|Record| (|:| |typ| (|Symbol|))
                                                 (|:| |c1| $) (|:| |c2| $))
                                       (|Union|
                                        (|:| |const|
                                             (|Record| (|:| |val| (|Symbol|))))
                                        (|:| |var|
                                             (|Record| (|:| |str| (|String|))))
                                        (|:| |binaryOp|
                                             (|Record| (|:| |typ| (|Symbol|))
                                                       (|:| |c1| $)
                                                       (|:| |c2| $)))
                                        (|:| |unaryOp|
                                             (|Record| (|:| |typ| (|Symbol|))
                                                       (|:| |c1| $))))
                                       #2#))
                     0)
                    'AND)
                   (LETT |s1| (SPADCALL "/\\" (QREFELT $ 49)))))
                 (COND
                  ((EQUAL
                    (QVELT
                     (PROG2 (LETT #2# |n|)
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 2)
                                       (|Record| (|:| |typ| (|Symbol|))
                                                 (|:| |c1| $) (|:| |c2| $))
                                       (|Union|
                                        (|:| |const|
                                             (|Record| (|:| |val| (|Symbol|))))
                                        (|:| |var|
                                             (|Record| (|:| |str| (|String|))))
                                        (|:| |binaryOp|
                                             (|Record| (|:| |typ| (|Symbol|))
                                                       (|:| |c1| $)
                                                       (|:| |c2| $)))
                                        (|:| |unaryOp|
                                             (|Record| (|:| |typ| (|Symbol|))
                                                       (|:| |c1| $))))
                                       #2#))
                     0)
                    'OR)
                   (LETT |s1| (SPADCALL "\\/" (QREFELT $ 49)))))
                 (EXIT
                  (SPADCALL
                   (SPADCALL |s1|
                             (SPADCALL
                              (QVELT
                               (PROG2 (LETT #2# |n|)
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 2)
                                                 (|Record|
                                                  (|:| |typ| (|Symbol|))
                                                  (|:| |c1| $) (|:| |c2| $))
                                                 (|Union|
                                                  (|:| |const|
                                                       (|Record|
                                                        (|:| |val|
                                                             (|Symbol|))))
                                                  (|:| |var|
                                                       (|Record|
                                                        (|:| |str|
                                                             (|String|))))
                                                  (|:| |binaryOp|
                                                       (|Record|
                                                        (|:| |typ| (|Symbol|))
                                                        (|:| |c1| $)
                                                        (|:| |c2| $)))
                                                  (|:| |unaryOp|
                                                       (|Record|
                                                        (|:| |typ| (|Symbol|))
                                                        (|:| |c1| $))))
                                                 #2#))
                               1)
                              (QREFELT $ 50))
                             (SPADCALL
                              (QVELT
                               (PROG2 (LETT #2# |n|)
                                   (QCDR #2#)
                                 (|check_union2| (QEQCAR #2# 2)
                                                 (|Record|
                                                  (|:| |typ| (|Symbol|))
                                                  (|:| |c1| $) (|:| |c2| $))
                                                 (|Union|
                                                  (|:| |const|
                                                       (|Record|
                                                        (|:| |val|
                                                             (|Symbol|))))
                                                  (|:| |var|
                                                       (|Record|
                                                        (|:| |str|
                                                             (|String|))))
                                                  (|:| |binaryOp|
                                                       (|Record|
                                                        (|:| |typ| (|Symbol|))
                                                        (|:| |c1| $)
                                                        (|:| |c2| $)))
                                                  (|:| |unaryOp|
                                                       (|Record|
                                                        (|:| |typ| (|Symbol|))
                                                        (|:| |c1| $))))
                                                 #2#))
                               2)
                              (QREFELT $ 50))
                             (QREFELT $ 51))
                   (QREFELT $ 52)))))
           ((QEQCAR |n| 3)
            (SPADCALL
             (LIST (SPADCALL "~(" (QREFELT $ 49))
                   (SPADCALL
                    (QCDR
                     (PROG2 (LETT #1# |n|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 3)
                                       (|Record| (|:| |typ| (|Symbol|))
                                                 (|:| |c1| $))
                                       (|Union|
                                        (|:| |const|
                                             (|Record| (|:| |val| (|Symbol|))))
                                        (|:| |var|
                                             (|Record| (|:| |str| (|String|))))
                                        (|:| |binaryOp|
                                             (|Record| (|:| |typ| (|Symbol|))
                                                       (|:| |c1| $)
                                                       (|:| |c2| $)))
                                        (|:| |unaryOp|
                                             (|Record| (|:| |typ| (|Symbol|))
                                                       (|:| |c1| $))))
                                       #1#)))
                    (QREFELT $ 50))
                   (SPADCALL ")" (QREFELT $ 49)))
             (QREFELT $ 53)))
           (#4# (|error| "coerce: unexpected representation")))))) 

(DECLAIM (NOTINLINE |ILogic;|)) 

(DEFUN |ILogic| ()
  (SPROG NIL
         (PROG (#1=#:G1090)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ILogic|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ILogic|
                             (LIST (CONS NIL (CONS 1 (|ILogic;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|ILogic|)))))))))) 

(DEFUN |ILogic;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ILogic|))
          (LETT $ (GETREFV 56))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ILogic| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Union| (|:| |const| (|Record| (|:| |val| (|Symbol|))))
                             (|:| |var| (|Record| (|:| |str| (|String|))))
                             (|:| |binaryOp|
                                  (|Record| (|:| |typ| (|Symbol|)) (|:| |c1| $)
                                            (|:| |c2| $)))
                             (|:| |unaryOp|
                                  (|Record| (|:| |typ| (|Symbol|))
                                            (|:| |c1| $)))))
          $))) 

(MAKEPROP '|ILogic| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|String|)
              |ILOGIC;proposition;S$;1| |ILOGIC;logicT;$;2| |ILOGIC;logicF;$;3|
              |ILOGIC;~;2$;4| (|Boolean|) |ILOGIC;=;2$B;17| |ILOGIC;/\\;3$;5|
              |ILOGIC;\\/;3$;6| (|Symbol|) (0 . ~=) |ILOGIC;implies;3$;7|
              |ILOGIC;redux;2$;8| (|List| $) |ILOGIC;getChildren;$L;16|
              (|List| $$) (6 . |first|) |ILOGIC;factor;$L;9| (11 . |second|)
              (16 . |concat|) (22 . |concat|) (28 . |empty?|)
              |ILOGIC;deductions;2L;12| |ILOGIC;opType;$S;13|
              |ILOGIC;atom?;$B;14| |ILOGIC;value;$S;15| (|Integer|)
              (33 . |maxIndex|) (|Record| (|:| |rft| $) (|:| |pout| 36))
              (|NonNegativeInteger|) |ILOGIC;parseILTerm;SNniR;23|
              (|Character|) (38 . |alphanumeric?|) (43 . |concat|)
              (49 . |alphabetic?|) |ILOGIC;parseIL2;SNniR;24| (54 . |minIndex|)
              |ILOGIC;parseIL;S$;25| |ILOGIC;toString;$S;26| (59 . |concat|)
              |ILOGIC;toStringUnwrapped;$S;27| (|OutputForm|) (64 . |message|)
              |ILOGIC;coerce;$Of;28| (69 . |infix|) (76 . |paren|)
              (81 . |hconcat|) (|HashState|) (|SingleInteger|))
           '#(~= 86 ~ 92 |value| 97 |toStringUnwrapped| 102 |toString| 107
              |redux| 112 |proposition| 117 |parseILTerm| 122 |parseIL2| 128
              |parseIL| 134 |opType| 139 |logicT| 144 |logicF| 148 |latex| 152
              |implies| 157 |hashUpdate!| 163 |hash| 169 |getChildren| 174
              |factor| 179 |deductions| 184 |coerce| 189 |atom?| 194 |_\|_| 199
              |\\/| 203 T$ 209 = 213 |/\\| 219)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0))
                 (CONS '#(NIL NIL NIL NIL NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|BoundedLattice|) (|BoundedMeetSemilattice|)
                           (|BoundedJoinSemilattice|) (|MeetSemilattice|)
                           (|JoinSemilattice|) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 48))
                        (|makeByteWordVec2| 55
                                            '(2 16 12 0 0 17 1 22 2 0 23 1 22 2
                                              0 25 2 22 0 0 0 26 2 22 0 0 2 27
                                              1 22 12 0 28 1 7 33 0 34 1 38 12
                                              0 39 2 7 0 0 38 40 1 38 12 0 41 1
                                              7 33 0 43 1 7 0 20 46 1 48 0 7 49
                                              3 48 0 0 0 0 51 1 48 0 0 52 1 48
                                              0 20 53 2 0 12 0 0 1 1 0 0 0 11 1
                                              0 16 0 32 1 0 7 0 47 1 0 7 0 45 1
                                              0 0 0 19 1 0 0 7 8 2 0 35 7 36 37
                                              2 0 35 7 36 42 1 0 0 7 44 1 0 16
                                              0 30 0 0 0 9 0 0 0 10 1 0 7 0 1 2
                                              0 0 0 0 18 2 0 54 54 0 1 1 0 55 0
                                              1 1 0 20 0 21 1 0 20 0 24 1 0 20
                                              20 29 1 0 48 0 50 1 0 12 0 31 0 0
                                              0 1 2 0 0 0 0 15 0 0 0 1 2 0 12 0
                                              0 13 2 0 0 0 0 14)))))
           '|lookupComplete|)) 

(MAKEPROP '|ILogic| 'NILADIC T) 


(SDEFUN |HB;lfunc;3I;1| ((|d| (|Integer|)) (|n| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|res| (|Integer|)) (#1=#:G723 NIL) (|sum| (|Integer|))
          (#2=#:G726 NIL) (|m| NIL))
         (SEQ
          (COND ((< |n| 0) 0) ((EQL |n| 0) 1) ((EQL |n| 1) |d|)
                ('T
                 (SEQ (LETT |sum| 0)
                      (SEQ (LETT |m| 1) (LETT #2# (- |n| 1)) G190
                           (COND ((|greater_SI| |m| #2#) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((EQL (REM |n| |m|) 0)
                               (LETT |sum|
                                     (+ |sum|
                                        (* |m|
                                           (SPADCALL |d| |m|
                                                     (QREFELT $ 7)))))))))
                           (LETT |m| (|inc_SI| |m|)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (LETT |res|
                             (QUOTIENT2
                              (-
                               (EXPT |d|
                                     (PROG1 (LETT #1# |n|)
                                       (|check_subtype2| (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#)))
                               |sum|)
                              |n|))))))))) 

(SDEFUN |HB;inHallBasis?;4IB;2|
        ((|n| (|Integer|)) (|i| (|Integer|)) (|j| (|Integer|))
         (|l| (|Integer|)) ($ (|Boolean|)))
        (COND ((>= |i| |j|) NIL) ((OR (<= |j| |n|) (<= |l| |i|)) 'T) ('T NIL))) 

(SDEFUN |HB;basis;2NniV;3|
        ((|n| (|NonNegativeInteger|)) (|c| (|NonNegativeInteger|))
         ($ (|Vector| (|List| (|Integer|)))))
        (SPROG
         ((|numComms| #1=(|Integer|)) (|cW| (|Integer|))
          (|leftIndex| (|NonNegativeInteger|)) (|newNumComms| #1#)
          (#2=#:G762 NIL) (|rightIndex| NIL) (|done| (|Boolean|))
          (|wt| (|Integer|)) (|firstindex| (|Vector| (|Integer|)))
          (#3=#:G761 NIL) (|i| NIL) (|v| (|Vector| (|List| (|Integer|))))
          (#4=#:G735 NIL) (|siz| (|Integer|)) (#5=#:G760 NIL)
          (|maxweight| (|NonNegativeInteger|)) (|gens| (|NonNegativeInteger|)))
         (SEQ (LETT |gens| |n|) (LETT |maxweight| |c|) (LETT |siz| 0)
              (SEQ (LETT |i| 1) (LETT #5# |maxweight|) G190
                   (COND ((|greater_SI| |i| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |siz|
                           (+ |siz| (SPADCALL |gens| |i| (QREFELT $ 7))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |v|
                    (MAKEARR1
                     (PROG1 (LETT #4# |siz|)
                       (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #4#))
                     NIL))
              (SEQ (LETT |i| 1) (LETT #3# |gens|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT (SPADCALL |v| |i| (LIST 0 1 |i|) (QREFELT $ 12))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |firstindex| (MAKEARR1 |maxweight| 0)) (LETT |wt| 1)
              (SPADCALL |firstindex| 1 1 (QREFELT $ 14))
              (LETT |numComms| |gens|) (LETT |newNumComms| |numComms|)
              (LETT |done| NIL)
              (SEQ G190 (COND ((NULL (NULL |done|)) (GO G191)))
                   (SEQ (LETT |wt| (+ |wt| 1))
                        (EXIT
                         (COND ((> |wt| |maxweight|) (LETT |done| 'T))
                               ('T
                                (SEQ
                                 (SPADCALL |firstindex| |wt|
                                           (+ |newNumComms| 1) (QREFELT $ 14))
                                 (LETT |leftIndex| 1) (LETT |cW| (- |wt| 1))
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (COND
                                          ((<= |leftIndex| |numComms|)
                                           (<=
                                            (SPADCALL
                                             (SPADCALL |v| |leftIndex|
                                                       (QREFELT $ 15))
                                             2 (QREFELT $ 16))
                                            |cW|))
                                          ('T NIL)))
                                        (GO G191)))
                                      (SEQ
                                       (SEQ
                                        (LETT |rightIndex|
                                              (SPADCALL |firstindex| |cW|
                                                        (QREFELT $ 17)))
                                        (LETT #2#
                                              (-
                                               (SPADCALL |firstindex|
                                                         (+ |cW| 1)
                                                         (QREFELT $ 17))
                                               1))
                                        G190
                                        (COND ((> |rightIndex| #2#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((SPADCALL |gens| |leftIndex|
                                                      |rightIndex|
                                                      (SPADCALL
                                                       (SPADCALL |v|
                                                                 |rightIndex|
                                                                 (QREFELT $
                                                                          15))
                                                       1 (QREFELT $ 16))
                                                      (QREFELT $ 9))
                                            (SEQ
                                             (LETT |newNumComms|
                                                   (+ |newNumComms| 1))
                                             (EXIT
                                              (SPADCALL |v| |newNumComms|
                                                        (LIST |leftIndex| |wt|
                                                              |rightIndex|)
                                                        (QREFELT $ 12))))))))
                                        (LETT |rightIndex| (+ |rightIndex| 1))
                                        (GO G190) G191 (EXIT NIL))
                                       (LETT |leftIndex| (+ |leftIndex| 1))
                                       (EXIT
                                        (LETT |cW|
                                              (- |wt|
                                                 (SPADCALL
                                                  (SPADCALL |v| |leftIndex|
                                                            (QREFELT $ 15))
                                                  2 (QREFELT $ 16))))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (EXIT (LETT |numComms| |newNumComms|)))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |v|)))) 

(DECLAIM (NOTINLINE |HallBasis;|)) 

(DEFUN |HallBasis| ()
  (SPROG NIL
         (PROG (#1=#:G764)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|HallBasis|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|HallBasis|
                             (LIST (CONS NIL (CONS 1 (|HallBasis;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|HallBasis|)))))))))) 

(DEFUN |HallBasis;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|HallBasis|))
          (LETT $ (GETREFV 20))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|HallBasis| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|HallBasis| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Integer|) |HB;lfunc;3I;1| (|Boolean|)
              |HB;inHallBasis?;4IB;2| (|List| 6) (|Vector| 10) (0 . |setelt!|)
              (|Vector| 6) (7 . |setelt!|) (14 . |elt|) (20 . |elt|)
              (26 . |elt|) (|NonNegativeInteger|) |HB;basis;2NniV;3|)
           '#(|lfunc| 32 |inHallBasis?| 38 |basis| 46) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|lfunc| ((|Integer|) (|Integer|) (|Integer|)))
                                T)
                              '((|inHallBasis?|
                                 ((|Boolean|) (|Integer|) (|Integer|)
                                  (|Integer|) (|Integer|)))
                                T)
                              '((|basis|
                                 ((|Vector| (|List| (|Integer|)))
                                  (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(3 11 10 0 6 10 12 3 13 6 0 6 6 14
                                              2 11 10 0 6 15 2 10 6 0 6 16 2 13
                                              6 0 6 17 2 0 6 6 6 7 4 0 8 6 6 6
                                              6 9 2 0 11 18 18 19)))))
           '|lookupComplete|)) 

(MAKEPROP '|HallBasis| 'NILADIC T) 

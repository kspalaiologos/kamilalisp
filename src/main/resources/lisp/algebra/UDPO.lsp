
(SDEFUN |UDPO;userOrdered?;B;1| (($ (|Boolean|)))
        (COND ((NULL (QREFELT $ 7)) (NULL (NULL (QREFELT $ 8)))) ('T 'T))) 

(SDEFUN |UDPO;getOrder;R;2|
        (($ (|Record| (|:| |low| (|List| S)) (|:| |high| (|List| S)))))
        (CONS (QREFELT $ 7) (QREFELT $ 8))) 

(SDEFUN |UDPO;setOrder;LV;3| ((|l| (|List| S)) ($ (|Void|)))
        (SPADCALL NIL |l| (QREFELT $ 15))) 

(SDEFUN |UDPO;setOrder;2LV;4| ((|l| (|List| S)) (|h| (|List| S)) ($ (|Void|)))
        (SEQ (SETELT $ 7 (SPADCALL |l| (QREFELT $ 17)))
             (SETELT $ 8 (SPADCALL |h| (QREFELT $ 17)))
             (EXIT (SPADCALL (QREFELT $ 18))))) 

(SDEFUN |UDPO;less?;2SMB;5|
        ((|a| (S)) (|b| (S)) (|f| (|Mapping| (|Boolean|) S S)) ($ (|Boolean|)))
        (SPROG ((|u| (|Union| (|Boolean|) "failed")))
               (SEQ (LETT |u| (SPADCALL |a| |b| (QREFELT $ 20)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (SPADCALL |a| |b| |f|))
                           ('T (QCDR |u|))))))) 

(SDEFUN |UDPO;largest;LMS;6|
        ((|x| (|List| S)) (|f| (|Mapping| (|Boolean|) S S)) ($ (S)))
        (SPROG ((|a| (S)))
               (SEQ
                (COND ((NULL |x|) (|error| "largest: empty list"))
                      ((NULL (CDR |x|)) (|SPADfirst| |x|))
                      (#1='T
                       (SEQ (LETT |a| (SPADCALL (CDR |x|) |f| (QREFELT $ 23)))
                            (EXIT
                             (COND
                              ((SPADCALL (|SPADfirst| |x|) |a| |f|
                                         (QREFELT $ 22))
                               |a|)
                              (#1# (|SPADfirst| |x|)))))))))) 

(SDEFUN |UDPO;less?;2SU;7|
        ((|a| (S)) (|b| (S)) ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((|bb| #1=(|Boolean|)) (#2=#:G735 NIL) (|aa| #1#) (#3=#:G737 NIL)
          (|x| NIL) (#4=#:G736 NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |x| NIL) (LETT #4# (QREFELT $ 7)) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((SPADCALL |x| |a| (QREFELT $ 24))
                     (PROGN
                      (LETT #2# (CONS 0 (SPADCALL |a| |b| (QREFELT $ 25))))
                      (GO #5=#:G734)))
                    ((SPADCALL |x| |b| (QREFELT $ 24))
                     (PROGN (LETT #2# (CONS 0 NIL)) (GO #5#))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (LETT |aa| (LETT |bb| 'NIL))
            (SEQ (LETT |x| NIL) (LETT #3# (QREFELT $ 8)) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL)) (GO G191)))
                 (SEQ
                  (COND
                   ((SPADCALL |x| |a| (QREFELT $ 24))
                    (COND (|bb| (PROGN (LETT #2# (CONS 0 NIL)) (GO #5#)))
                          ('T (LETT |aa| 'T)))))
                  (EXIT
                   (COND
                    ((SPADCALL |x| |b| (QREFELT $ 24))
                     (COND
                      (|aa|
                       (PROGN
                        (LETT #2# (CONS 0 (SPADCALL |a| |b| (QREFELT $ 25))))
                        (GO #5#)))
                      ('T (LETT |bb| 'T)))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (EXIT
             (COND (|aa| (CONS 0 NIL)) (|bb| (CONS 0 'T))
                   ('T (CONS 1 "failed"))))))
          #5# (EXIT #2#)))) 

(SDEFUN |UDPO;more?;2SB;8| ((|a| (S)) (|b| (S)) ($ (|Boolean|)))
        (NULL (SPADCALL |a| |b| (ELT $ 26) (QREFELT $ 22)))) 

(SDEFUN |UDPO;largest;LS;9| ((|x| (|List| S)) ($ (S)))
        (SPADCALL |x| (ELT $ 26) (QREFELT $ 23))) 

(DECLAIM (NOTINLINE |UserDefinedPartialOrdering;|)) 

(DEFUN |UserDefinedPartialOrdering| (#1=#:G741)
  (SPROG NIL
         (PROG (#2=#:G742)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|UserDefinedPartialOrdering|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|UserDefinedPartialOrdering;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UserDefinedPartialOrdering|)))))))))) 

(DEFUN |UserDefinedPartialOrdering;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|UserDefinedPartialOrdering| DV$1))
          (LETT $ (GETREFV 29))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|OrderedSet|))))))
          (|haddProp| |$ConstructorCache| '|UserDefinedPartialOrdering|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 NIL)
          (QSETREFV $ 8 NIL)
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 27 (CONS (|dispatchFunction| |UDPO;more?;2SB;8|) $))
             (QSETREFV $ 28
                       (CONS (|dispatchFunction| |UDPO;largest;LS;9|) $)))))
          $))) 

(MAKEPROP '|UserDefinedPartialOrdering| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|llow| '|lhigh|
              (|Boolean|) |UDPO;userOrdered?;B;1|
              (|Record| (|:| |low| 14) (|:| |high| 14)) |UDPO;getOrder;R;2|
              (|Void|) (|List| 6) |UDPO;setOrder;2LV;4| |UDPO;setOrder;LV;3|
              (0 . |removeDuplicates|) (5 . |void|) (|Union| 9 '#1="failed")
              |UDPO;less?;2SU;7| (|Mapping| 9 6 6) |UDPO;less?;2SMB;5|
              |UDPO;largest;LMS;6| (9 . =) (15 . ~=) (21 . <) (27 . |more?|)
              (33 . |largest|))
           '#(|userOrdered?| 38 |setOrder| 42 |more?| 53 |less?| 59 |largest|
              72 |getOrder| 83)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|setOrder| ((|Void|) (|List| |#1|))) T)
                                   '((|setOrder|
                                      ((|Void|) (|List| |#1|) (|List| |#1|)))
                                     T)
                                   '((|getOrder|
                                      ((|Record| (|:| |low| (|List| |#1|))
                                                 (|:| |high| (|List| |#1|)))))
                                     T)
                                   '((|less?|
                                      ((|Union| (|Boolean|) #1#) |#1| |#1|))
                                     T)
                                   '((|less?|
                                      ((|Boolean|) |#1| |#1|
                                       (|Mapping| (|Boolean|) |#1| |#1|)))
                                     T)
                                   '((|largest|
                                      (|#1| (|List| |#1|)
                                       (|Mapping| (|Boolean|) |#1| |#1|)))
                                     T)
                                   '((|userOrdered?| ((|Boolean|))) T)
                                   '((|largest| (|#1| (|List| |#1|)))
                                     (|has| 6 (|OrderedSet|)))
                                   '((|more?| ((|Boolean|) |#1| |#1|))
                                     (|has| 6 (|OrderedSet|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 28
                                            '(1 14 0 0 17 0 13 0 18 2 6 9 0 0
                                              24 2 6 9 0 0 25 2 6 9 0 0 26 2 0
                                              9 6 6 27 1 0 6 14 28 0 0 9 10 2 0
                                              13 14 14 15 1 0 13 14 16 2 1 9 6
                                              6 27 2 0 19 6 6 20 3 0 9 6 6 21
                                              22 1 1 6 14 28 2 0 6 14 21 23 0 0
                                              11 12)))))
           '|lookupComplete|)) 

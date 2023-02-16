
(SDEFUN |RIDIST;uniform;SM;1|
        ((|aTob| (|Segment| (|Integer|))) ($ (|Mapping| (|Integer|))))
        (SPROG NIL (SEQ (CONS #'|RIDIST;uniform;SM;1!0| (VECTOR $ |aTob|))))) 

(SDEFUN |RIDIST;uniform;SM;1!0| (($$ NIL))
        (PROG (|aTob| $)
          (LETT |aTob| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|a| NIL) (|b| NIL) (|l| NIL) (|m| NIL) (#1=#:G706 NIL) (|w| NIL)
              (|mqnext| NIL) (|n| NIL) (|mq| NIL))
             (SEQ (LETT |a| (SPADCALL |aTob| (QREFELT $ 8)))
                  (LETT |b| (SPADCALL |aTob| (QREFELT $ 9)))
                  (LETT |l| (SPADCALL |a| |b| (QREFELT $ 10)))
                  (LETT |m|
                        (SPADCALL
                         (SPADCALL (SPADCALL |a| |b| (QREFELT $ 11))
                                   (QREFELT $ 12))
                         (|spadConstant| $ 25) (QREFELT $ 14)))
                  (LETT |w|
                        (SPADCALL 2
                                  (PROG1
                                      (LETT #1#
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL (QREFELT $ 16))
                                              (QREFELT $ 17))
                                             2 (QREFELT $ 18)))
                                    (|check_subtype2| (>= #1# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #1#))
                                  (QREFELT $ 29)))
                  (LETT |n| (|spadConstant| $ 21)) (LETT |mq| |m|)
                  (SEQ G190
                       (COND
                        ((NULL
                          (SPADCALL
                           (LETT |mqnext| (SPADCALL |mq| |w| (QREFELT $ 18)))
                           (|spadConstant| $ 21) (QREFELT $ 23)))
                         (GO G191)))
                       (SEQ
                        (LETT |n|
                              (SPADCALL |n| (|spadConstant| $ 25)
                                        (QREFELT $ 27)))
                        (EXIT (LETT |mq| |mqnext|)))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT (SPADCALL |mq| |n| |w| |l| (QREFELT $ 28))))))))) 

(SDEFUN |RIDIST;ridHack1;5I;2|
        ((|mq| (|Integer|)) (|n| (|Integer|)) (|w| (|Integer|))
         (|l| (|Integer|)) ($ (|Integer|)))
        (SPROG ((|r| (|Integer|)) (#1=#:G720 NIL) (|i| NIL))
               (SEQ (LETT |r| (SPADCALL |mq| (QREFELT $ 32)))
                    (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |r|
                                 (+ (* |r| |w|)
                                    (SPADCALL |w| (QREFELT $ 32))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (+ |r| |l|))))) 

(DECLAIM (NOTINLINE |RandomIntegerDistributions;|)) 

(DEFUN |RandomIntegerDistributions| ()
  (SPROG NIL
         (PROG (#1=#:G726)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|RandomIntegerDistributions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|RandomIntegerDistributions|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|RandomIntegerDistributions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|RandomIntegerDistributions|)))))))))) 

(DEFUN |RandomIntegerDistributions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|RandomIntegerDistributions|))
          (LETT $ (GETREFV 34))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RandomIntegerDistributions| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RandomIntegerDistributions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Integer|) (|Segment| 6) (0 . |low|)
              (5 . |high|) (10 . |min|) (16 . -) (22 . |abs|) (27 . |One|)
              (31 . +) (|RandomNumberSource|) (37 . |size|) (41 . |length|)
              (46 . |quo|) (|NonNegativeInteger|) (52 . ^) (58 . |Zero|)
              (|Boolean|) (62 . >) (|PositiveInteger|) (68 . |One|)
              (72 . |One|) (76 . +) |RIDIST;ridHack1;5I;2| (82 . ^)
              (|Mapping| 6) |RIDIST;uniform;SM;1| (88 . |randnum|)
              (|Fraction| 6))
           '#(|uniform| 93 |ridHack1| 98 |poisson| 106 |geometric| 111
              |binomial| 116)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|uniform|
                                 ((|Mapping| (|Integer|))
                                  (|Segment| (|Integer|))))
                                T)
                              '((|binomial|
                                 ((|Mapping| (|Integer|)) (|Integer|)
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|poisson|
                                 ((|Mapping| (|Integer|))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|geometric|
                                 ((|Mapping| (|Integer|))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|ridHack1|
                                 ((|Integer|) (|Integer|) (|Integer|)
                                  (|Integer|) (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 33
                                            '(1 7 6 0 8 1 7 6 0 9 2 6 0 0 0 10
                                              2 6 0 0 0 11 1 6 0 0 12 0 6 0 13
                                              2 6 0 0 0 14 0 15 6 16 1 6 0 0 17
                                              2 6 0 0 0 18 2 6 0 0 19 20 0 19 0
                                              21 2 6 22 0 0 23 0 24 0 25 0 19 0
                                              26 2 19 0 0 0 27 2 24 0 0 19 29 1
                                              15 6 6 32 1 0 30 7 31 4 0 6 6 6 6
                                              6 28 1 0 30 33 1 1 0 30 33 1 2 0
                                              30 6 33 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|RandomIntegerDistributions| 'NILADIC T) 

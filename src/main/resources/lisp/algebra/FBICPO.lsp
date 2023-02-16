
(SDEFUN |FBICPO;join;$3Nni;1|
        ((|s| ($)) (|a| #1=(|NonNegativeInteger|)) (|b| #1#)
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#2=#:G694 NIL) (|res| (|Union| (|NonNegativeInteger|) "failed")))
         (SEQ (LETT |res| (SPADCALL |s| |a| |b| (QREFELT $ 9)))
              (COND
               ((SPADCALL |res| (CONS 1 "failed") (QREFELT $ 11))
                (|error| "This POSET does not have join")))
              (EXIT
               (PROG2 (LETT #2# |res|)
                   (QCDR #2#)
                 (|check_union2| (QEQCAR #2# 0) (|NonNegativeInteger|)
                                 (|Union| (|NonNegativeInteger|) "failed")
                                 #2#)))))) 

(SDEFUN |FBICPO;meet;$3Nni;2|
        ((|s| ($)) (|a| #1=(|NonNegativeInteger|)) (|b| #1#)
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#2=#:G699 NIL) (|res| (|Union| (|NonNegativeInteger|) "failed")))
         (SEQ (LETT |res| (SPADCALL |s| |a| |b| (QREFELT $ 13)))
              (COND
               ((SPADCALL |res| (CONS 1 "failed") (QREFELT $ 11))
                (|error| "This POSET does not have meet")))
              (EXIT
               (PROG2 (LETT #2# |res|)
                   (QCDR #2#)
                 (|check_union2| (QEQCAR #2# 0) (|NonNegativeInteger|)
                                 (|Union| (|NonNegativeInteger|) "failed")
                                 #2#)))))) 

(DECLAIM (NOTINLINE |FiniteBiCPO;|)) 

(DEFUN |FiniteBiCPO| (#1=#:G717)
  (SPROG NIL
         (PROG (#2=#:G718)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FiniteBiCPO|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FiniteBiCPO;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|FiniteBiCPO|)))))))))) 

(DEFUN |FiniteBiCPO;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FiniteBiCPO| DV$1))
          (LETT $ (GETREFV 38))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FiniteBiCPO| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FiniteBiCPO| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|FinitePoset| 6) (|local| |#1|)
              (|Union| 8 '"failed") (|NonNegativeInteger|) (0 . |joinIfCan|)
              (|Boolean|) (7 . =) |FBICPO;join;$3Nni;1| (13 . |meetIfCan|)
              |FBICPO;meet;$3Nni;2| (|IncidenceAlgebra| 21 6) (|List| 8)
              (|Void|) (|List| (|List| 10)) (|List| 6) (|Mapping| 10 6 6)
              (|Integer|) (|String|) (|List| $) (|Scene| (|SCartesian| '2))
              (|Matrix| 21) (|Matrix| 8) (|List| (|Loop|)) (|List| 29)
              (|Tree| 21) (|DirectedGraph| $)
              (|Record| (|:| |name| 22) (|:| |arrType| 8) (|:| |fromOb| 8)
                        (|:| |toOb| 8) (|:| |xOffset| 21) (|:| |yOffset| 21)
                        (|:| |map| 16))
              (|List| 31)
              (|Record| (|:| |value| 6) (|:| |posX| 8) (|:| |posY| 8))
              (|List| 33) (|HashState|) (|OutputForm|) (|SingleInteger|))
           '#(|meetIfCan| 20 |meet| 27 |joinIfCan| 34 |join| 41) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(NIL NIL NIL |Poset&| NIL |FiniteGraph&| |SetCategory&|
                     |BasicType&| NIL)
                  (CONS
                   '#((|BiCPO| 6) (|Dcpo| 6) (|CoDcpo| 6) (|Poset| 6)
                      (|Preorder| 6) (|FiniteGraph| 6) (|SetCategory|)
                      (|BasicType|) (|CoercibleTo| 36))
                   (|makeByteWordVec2| 14
                                       '(3 0 7 0 8 8 9 2 7 10 0 0 11 3 0 7 0 8
                                         8 13 3 0 7 0 8 8 13 3 0 8 0 8 8 14 3 0
                                         7 0 8 8 9 3 0 8 0 8 8 12)))))
           '|lookupIncomplete|)) 


(SDEFUN |FCDCPO;meet;$3Nni;1|
        ((|s| ($)) (|a| #1=(|NonNegativeInteger|)) (|b| #1#)
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#2=#:G694 NIL) (|res| (|Union| (|NonNegativeInteger|) "failed")))
         (SEQ (LETT |res| (SPADCALL |s| |a| |b| (QREFELT $ 9)))
              (COND
               ((SPADCALL |res| (CONS 1 "failed") (QREFELT $ 11))
                (|error| "This POSET does not have meet")))
              (EXIT
               (PROG2 (LETT #2# |res|)
                   (QCDR #2#)
                 (|check_union2| (QEQCAR #2# 0) (|NonNegativeInteger|)
                                 (|Union| (|NonNegativeInteger|) "failed")
                                 #2#)))))) 

(DECLAIM (NOTINLINE |FiniteCoDcpo;|)) 

(DEFUN |FiniteCoDcpo| (#1=#:G712)
  (SPROG NIL
         (PROG (#2=#:G713)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FiniteCoDcpo|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FiniteCoDcpo;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|FiniteCoDcpo|)))))))))) 

(DEFUN |FiniteCoDcpo;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FiniteCoDcpo| DV$1))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FiniteCoDcpo| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FiniteCoDcpo| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|FinitePoset| 6) (|local| |#1|)
              (|Union| 8 '"failed") (|NonNegativeInteger|) (0 . |meetIfCan|)
              (|Boolean|) (7 . =) |FCDCPO;meet;$3Nni;1|
              (|IncidenceAlgebra| 19 6) (|List| 8) (|Void|) (|List| 6)
              (|List| (|List| 10)) (|Mapping| 10 6 6) (|Integer|) (|String|)
              (|List| $) (|Scene| (|SCartesian| '2)) (|Matrix| 19) (|Matrix| 8)
              (|List| (|Loop|)) (|Tree| 19) (|List| 26) (|DirectedGraph| $)
              (|Record| (|:| |name| 20) (|:| |arrType| 8) (|:| |fromOb| 8)
                        (|:| |toOb| 8) (|:| |xOffset| 19) (|:| |yOffset| 19)
                        (|:| |map| 14))
              (|List| 29)
              (|Record| (|:| |value| 6) (|:| |posX| 8) (|:| |posY| 8))
              (|List| 31) (|HashState|) (|OutputForm|) (|SingleInteger|))
           '#(|meetIfCan| 13 |meet| 20) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0))
                 (CONS
                  '#(NIL |Poset&| NIL |FiniteGraph&| |SetCategory&|
                     |BasicType&| NIL)
                  (CONS
                   '#((|CoDcpo| 6) (|Poset| 6) (|Preorder| 6) (|FiniteGraph| 6)
                      (|SetCategory|) (|BasicType|) (|CoercibleTo| 34))
                   (|makeByteWordVec2| 12
                                       '(3 0 7 0 8 8 9 2 7 10 0 0 11 3 0 7 0 8
                                         8 9 3 0 8 0 8 8 12)))))
           '|lookupIncomplete|)) 

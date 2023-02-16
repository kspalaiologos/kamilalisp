
(PUT '|SPLNODE;rep| '|SPADreplace| '(XLAM (|n|) |n|)) 

(SDEFUN |SPLNODE;rep|
        ((|n| ($))
         ($ (|Record| (|:| |val| V) (|:| |tower| C) (|:| |flag| (|Boolean|)))))
        |n|) 

(PUT '|SPLNODE;per| '|SPADreplace| '(XLAM (|r|) |r|)) 

(SDEFUN |SPLNODE;per|
        ((|r|
          (|Record| (|:| |val| V) (|:| |tower| C) (|:| |flag| (|Boolean|))))
         ($ ($)))
        |r|) 

(SDEFUN |SPLNODE;empty;$;3| (($ ($)))
        (|SPLNODE;per|
         (VECTOR (SPADCALL (QREFELT $ 8)) (SPADCALL (QREFELT $ 9)) NIL) $)) 

(SDEFUN |SPLNODE;empty?;$B;4| ((|n| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QVELT (|SPLNODE;rep| |n| $) 0) (QREFELT $ 12))
          (SPADCALL (QVELT (|SPLNODE;rep| |n| $) 1) (QREFELT $ 13)))
         ('T NIL))) 

(SDEFUN |SPLNODE;value;$V;5| ((|n| ($)) ($ (V)))
        (QVELT (|SPLNODE;rep| |n| $) 0)) 

(SDEFUN |SPLNODE;condition;$C;6| ((|n| ($)) ($ (C)))
        (QVELT (|SPLNODE;rep| |n| $) 1)) 

(SDEFUN |SPLNODE;status;$B;7| ((|n| ($)) ($ (|Boolean|)))
        (QVELT (|SPLNODE;rep| |n| $) 2)) 

(SDEFUN |SPLNODE;construct;VCB$;8|
        ((|v| (V)) (|t| (C)) (|b| (|Boolean|)) ($ ($)))
        (|SPLNODE;per| (VECTOR |v| |t| |b|) $)) 

(SDEFUN |SPLNODE;construct;VC$;9| ((|v| (V)) (|t| (C)) ($ ($)))
        (SPADCALL |v| |t| NIL (QREFELT $ 18))) 

(SDEFUN |SPLNODE;construct;R$;10|
        ((|vt| (|Record| (|:| |val| V) (|:| |tower| C))) ($ ($)))
        (SPADCALL (QCAR |vt|) (QCDR |vt|) (QREFELT $ 19))) 

(SDEFUN |SPLNODE;construct;LL;11|
        ((|lvt| (|List| (|Record| (|:| |val| V) (|:| |tower| C))))
         ($ (|List| $)))
        (SPROG ((#1=#:G720 NIL) (|vt| NIL) (#2=#:G719 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |vt| NIL) (LETT #1# |lvt|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |vt| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |vt| (QREFELT $ 21)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SPLNODE;construct;VLL;12| ((|v| (V)) (|lt| (|List| C)) ($ (|List| $)))
        (SPROG ((#1=#:G725 NIL) (|t| NIL) (#2=#:G724 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |t| NIL) (LETT #1# |lt|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |t| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |v| |t| (QREFELT $ 19)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SPLNODE;copy;2$;13| ((|n| ($)) ($ ($)))
        (|SPLNODE;per| (MOVEVEC (MAKE_VEC 3) (|SPLNODE;rep| |n| $)) $)) 

(SDEFUN |SPLNODE;setValue!;$V$;14| ((|n| ($)) (|v| (V)) ($ ($)))
        (SEQ (QSETVELT (|SPLNODE;rep| |n| $) 0 |v|) (EXIT |n|))) 

(SDEFUN |SPLNODE;setCondition!;$C$;15| ((|n| ($)) (|t| (C)) ($ ($)))
        (SEQ (QSETVELT (|SPLNODE;rep| |n| $) 1 |t|) (EXIT |n|))) 

(SDEFUN |SPLNODE;setStatus!;$B$;16| ((|n| ($)) (|b| (|Boolean|)) ($ ($)))
        (SEQ (QSETVELT (|SPLNODE;rep| |n| $) 2 |b|) (EXIT |n|))) 

(SDEFUN |SPLNODE;setEmpty!;2$;17| ((|n| ($)) ($ ($)))
        (SEQ (QSETVELT (|SPLNODE;rep| |n| $) 0 (SPADCALL (QREFELT $ 8)))
             (QSETVELT (|SPLNODE;rep| |n| $) 1 (SPADCALL (QREFELT $ 9)))
             (EXIT |n|))) 

(SDEFUN |SPLNODE;infLex?;2$MMB;18|
        ((|n1| ($)) (|n2| ($)) (|o1| (|Mapping| (|Boolean|) V V))
         (|o2| (|Mapping| (|Boolean|) C C)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QVELT (|SPLNODE;rep| |n1| $) 0)
                    (QVELT (|SPLNODE;rep| |n2| $) 0) |o1|)
          'T)
         ((SPADCALL (QVELT (|SPLNODE;rep| |n1| $) 0)
                    (QVELT (|SPLNODE;rep| |n2| $) 0) (QREFELT $ 32))
          (SPADCALL (QVELT (|SPLNODE;rep| |n1| $) 1)
                    (QVELT (|SPLNODE;rep| |n2| $) 1) |o2|))
         ('T NIL))) 

(SDEFUN |SPLNODE;subNode?;2$MB;19|
        ((|n1| ($)) (|n2| ($)) (|o2| (|Mapping| (|Boolean|) C C))
         ($ (|Boolean|)))
        (COND
         ((SPADCALL (QVELT (|SPLNODE;rep| |n1| $) 0)
                    (QVELT (|SPLNODE;rep| |n2| $) 0) (QREFELT $ 32))
          (SPADCALL (QVELT (|SPLNODE;rep| |n1| $) 1)
                    (QVELT (|SPLNODE;rep| |n2| $) 1) |o2|))
         ('T NIL))) 

(SDEFUN |SPLNODE;=;2$B;20| ((|n1| ($)) (|n2| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QVELT (|SPLNODE;rep| |n1| $) 0)
                    (QVELT (|SPLNODE;rep| |n2| $) 0) (QREFELT $ 37))
          NIL)
         ('T
          (SPADCALL (QVELT (|SPLNODE;rep| |n1| $) 1)
                    (QVELT (|SPLNODE;rep| |n2| $) 1) (QREFELT $ 38))))) 

(SDEFUN |SPLNODE;~=;2$B;21| ((|n1| ($)) (|n2| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QVELT (|SPLNODE;rep| |n1| $) 0)
                    (QVELT (|SPLNODE;rep| |n2| $) 0) (QREFELT $ 32))
          NIL)
         ('T
          (SPADCALL (QVELT (|SPLNODE;rep| |n1| $) 1)
                    (QVELT (|SPLNODE;rep| |n2| $) 1) (QREFELT $ 40))))) 

(SDEFUN |SPLNODE;coerce;$Of;22| ((|n| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| #1=(|OutputForm|))) (|o3| #1#) (|o2| #2=(|OutputForm|))
          (|l2| (|List| (|OutputForm|))) (|o1| #2#)
          (|l1| (|List| (|OutputForm|))))
         (SEQ
          (LETT |l1|
                (LIST (SPADCALL "value == " (QREFELT $ 44))
                      (SPADCALL (QVELT (|SPLNODE;rep| |n| $) 0)
                                (QREFELT $ 45))))
          (LETT |o1| (SPADCALL |l1| (QREFELT $ 46)))
          (LETT |l2|
                (LIST (SPADCALL " tower == " (QREFELT $ 44))
                      (SPADCALL (QVELT (|SPLNODE;rep| |n| $) 1)
                                (QREFELT $ 47))))
          (LETT |o2| (SPADCALL |l2| (QREFELT $ 46)))
          (COND
           ((QVELT (|SPLNODE;rep| |n| $) 2)
            (LETT |o3| (SPADCALL " closed == true" (QREFELT $ 44))))
           ('T (LETT |o3| (SPADCALL " closed == false" (QREFELT $ 44)))))
          (LETT |l| (LIST |o1| |o2| |o3|))
          (EXIT (SPADCALL |l| (QREFELT $ 48)))))) 

(DECLAIM (NOTINLINE |SplittingNode;|)) 

(DEFUN |SplittingNode| (&REST #1=#:G751)
  (SPROG NIL
         (PROG (#2=#:G752)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SplittingNode|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SplittingNode;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|SplittingNode|)))))))))) 

(DEFUN |SplittingNode;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|SplittingNode| DV$1 DV$2))
          (LETT $ (GETREFV 52))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SplittingNode| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SplittingNode| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |empty|) (4 . |empty|) |SPLNODE;empty;$;3| (|Boolean|)
              (8 . |empty?|) (13 . |empty?|) |SPLNODE;empty?;$B;4|
              |SPLNODE;value;$V;5| |SPLNODE;condition;$C;6|
              |SPLNODE;status;$B;7| |SPLNODE;construct;VCB$;8|
              |SPLNODE;construct;VC$;9|
              (|Record| (|:| |val| 6) (|:| |tower| 7))
              |SPLNODE;construct;R$;10| (|List| $) (|List| 20)
              |SPLNODE;construct;LL;11| (|List| 7) |SPLNODE;construct;VLL;12|
              |SPLNODE;copy;2$;13| |SPLNODE;setValue!;$V$;14|
              |SPLNODE;setCondition!;$C$;15| |SPLNODE;setStatus!;$B$;16|
              |SPLNODE;setEmpty!;2$;17| (18 . =) (|Mapping| 11 6 6)
              (|Mapping| 11 7 7) |SPLNODE;infLex?;2$MMB;18|
              |SPLNODE;subNode?;2$MB;19| (24 . ~=) (30 . =) |SPLNODE;=;2$B;20|
              (36 . ~=) |SPLNODE;~=;2$B;21| (|String|) (|OutputForm|)
              (42 . |message|) (47 . |coerce|) (52 . |blankSeparate|)
              (57 . |coerce|) (62 . |bracket|) |SPLNODE;coerce;$Of;22|
              (|SingleInteger|) (|HashState|))
           '#(~= 67 |value| 73 |subNode?| 78 |status| 85 |setValue!| 90
              |setStatus!| 96 |setEmpty!| 102 |setCondition!| 107 |latex| 113
              |infLex?| 118 |hashUpdate!| 126 |hash| 132 |empty?| 137 |empty|
              142 |copy| 146 |construct| 151 |condition| 180 |coerce| 185 =
              190)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 43))
                        (|makeByteWordVec2| 51
                                            '(0 6 0 8 0 7 0 9 1 6 11 0 12 1 7
                                              11 0 13 2 6 11 0 0 32 2 6 11 0 0
                                              37 2 7 11 0 0 38 2 7 11 0 0 40 1
                                              43 0 42 44 1 6 43 0 45 1 43 0 22
                                              46 1 7 43 0 47 1 43 0 22 48 2 0
                                              11 0 0 41 1 0 6 0 15 3 0 11 0 0
                                              34 36 1 0 11 0 17 2 0 0 0 6 28 2
                                              0 0 0 11 30 1 0 0 0 31 2 0 0 0 7
                                              29 1 0 42 0 1 4 0 11 0 0 33 34 35
                                              2 0 51 51 0 1 1 0 50 0 1 1 0 11 0
                                              14 0 0 0 10 1 0 0 0 27 2 0 22 6
                                              25 26 1 0 22 23 24 2 0 0 6 7 19 1
                                              0 0 20 21 3 0 0 6 7 11 18 1 0 7 0
                                              16 1 0 43 0 49 2 0 11 0 0 39)))))
           '|lookupComplete|)) 

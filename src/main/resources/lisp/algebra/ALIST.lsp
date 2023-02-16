
(SDEFUN |ALIST;dictionary;$;1| (($ ($))) (SPADCALL NIL (QREFELT $ 11))) 

(SDEFUN |ALIST;empty;$;2| (($ ($))) (SPADCALL (QREFELT $ 12))) 

(SDEFUN |ALIST;empty?;$B;3| ((|t| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |t| (QREFELT $ 14)))) 

(SDEFUN |ALIST;entries;$L;4|
        ((|t| ($))
         ($ (|List| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|)))))
        (SPADCALL |t| (QREFELT $ 14))) 

(SDEFUN |ALIST;parts;$L;5|
        ((|t| ($))
         ($ (|List| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|)))))
        (SPADCALL |t| (QREFELT $ 14))) 

(SDEFUN |ALIST;keys;$L;6| ((|t| ($)) ($ (|List| |Key|)))
        (SPROG ((#1=#:G719 NIL) (|k| NIL) (#2=#:G718 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |t| (QREFELT $ 14)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QCAR |k|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |ALIST;#;$Nni;7| ((|t| ($)) ($ (|NonNegativeInteger|)))
        (LENGTH (SPADCALL |t| (QREFELT $ 14)))) 

(SDEFUN |ALIST;first;$R;8|
        ((|t| ($)) ($ (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
        (|SPADfirst| (SPADCALL |t| (QREFELT $ 14)))) 

(SDEFUN |ALIST;rest;2$;9| ((|t| ($)) ($ ($)))
        (SPADCALL (CDR (SPADCALL |t| (QREFELT $ 14))) (QREFELT $ 11))) 

(SDEFUN |ALIST;concat;R2$;10|
        ((|p| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))) (|t| ($))
         ($ ($)))
        (SPADCALL (SPADCALL |p| (SPADCALL |t| (QREFELT $ 14)) (QREFELT $ 25))
                  (QREFELT $ 11))) 

(SDEFUN |ALIST;setrest!;3$;11| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |a| (QREFELT $ 14)) (SPADCALL |b| (QREFELT $ 14))
                   (QREFELT $ 27))
         (QREFELT $ 11))) 

(SDEFUN |ALIST;setfirst!;$2R;12|
        ((|a| ($)) (|p| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|)))
         ($ (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
        (SPADCALL (SPADCALL |a| (QREFELT $ 14)) |p| (QREFELT $ 29))) 

(SDEFUN |ALIST;minIndex;$I;13| ((|a| ($)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 14)) (QREFELT $ 32))) 

(SDEFUN |ALIST;maxIndex;$I;14| ((|a| ($)) ($ (|Integer|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 14)) (QREFELT $ 34))) 

(SDEFUN |ALIST;search;Key$U;15|
        ((|k| (|Key|)) (|t| ($)) ($ (|Union| |Entry| "failed")))
        (SPROG ((#1=#:G743 NIL) (#2=#:G744 NIL) (#3=#:G745 NIL) (|r| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |r| NIL)
                         (LETT #3# (SPADCALL |t| (QREFELT $ 14))) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |r| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |k| (QCAR |r|) (QREFELT $ 36))
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2# (CONS 0 (QCDR |r|)))
                                     (GO #4=#:G742)))
                              (GO #5=#:G737))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (CONS 1 "failed"))))
                #4# (EXIT #2#)))) 

(SDEFUN |ALIST;latex;$S;16| ((|a| ($)) ($ (|String|)))
        (SPROG
         ((|s| (|String|))
          (|l| (|List| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
          (|r| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
         (SEQ (LETT |l| (SPADCALL |a| (QREFELT $ 17))) (LETT |s| "\\left[")
              (SEQ G190 (COND ((NULL (NULL (NULL |l|))) (GO G191)))
                   (SEQ (LETT |r| (|SPADfirst| |l|)) (LETT |l| (CDR |l|))
                        (LETT |s|
                              (STRCONC |s|
                                       (STRCONC
                                        (SPADCALL (QCAR |r|) (QREFELT $ 40))
                                        (STRCONC " = "
                                                 (SPADCALL (QCDR |r|)
                                                           (QREFELT $ 41))))))
                        (EXIT
                         (COND
                          ((NULL (NULL |l|)) (LETT |s| (STRCONC |s| ", "))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (STRCONC |s| " \\right]"))))) 

(SDEFUN |ALIST;assoc;Key$U;17|
        ((|k| (|Key|)) (|t| ($))
         ($
          (|Union| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))
                   "failed")))
        (SPROG ((#1=#:G766 NIL) (#2=#:G767 NIL) (#3=#:G768 NIL) (|r| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |r| NIL)
                         (LETT #3# (SPADCALL |t| (QREFELT $ 14))) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |r| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |k| (QCAR |r|) (QREFELT $ 36))
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2# (CONS 0 |r|))
                                     (GO #4=#:G765)))
                              (GO #5=#:G760))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (CONS 1 "failed"))))
                #4# (EXIT #2#)))) 

(SDEFUN |ALIST;setelt!;$Key2Entry;18|
        ((|t| ($)) (|k| (|Key|)) (|e| (|Entry|)) ($ (|Entry|)))
        (SPROG
         ((|r|
           (|Union| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))
                    "failed")))
         (SEQ (LETT |r| (SPADCALL |k| |t| (QREFELT $ 44)))
              (EXIT
               (COND
                ((QEQCAR |r| 0) (PROGN (RPLACD #1=(QCDR |r|) |e|) (QCDR #1#)))
                ('T
                 (SEQ
                  (SPADCALL |t|
                            (SPADCALL (CONS |k| |e|)
                                      (SPADCALL |t| (QREFELT $ 14))
                                      (QREFELT $ 25))
                            (QREFELT $ 45))
                  (EXIT |e|)))))))) 

(SDEFUN |ALIST;remove!;Key$U;19|
        ((|k| (|Key|)) (|t| ($)) ($ (|Union| |Entry| "failed")))
        (SPROG
         ((|curr| (|List| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
          (|prev|
           #1=(|List| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
          (|l| #1#))
         (SEQ
          (COND
           ((NULL (LETT |l| (SPADCALL |t| (QREFELT $ 14)))) (CONS 1 "failed"))
           ((SPADCALL |k| (QCAR (|SPADfirst| |l|)) (QREFELT $ 36))
            (SEQ (SPADCALL |t| (CDR |l|) (QREFELT $ 45))
                 (EXIT (CONS 0 (QCDR (|SPADfirst| |l|))))))
           (#2='T
            (SEQ (LETT |prev| |l|) (LETT |curr| (CDR |l|))
                 (SEQ G190
                      (COND
                       ((NULL
                         (COND ((NULL |curr|) NIL)
                               ('T
                                (SPADCALL (QCAR (|SPADfirst| |curr|)) |k|
                                          (QREFELT $ 47)))))
                        (GO G191)))
                      (SEQ (LETT |prev| |curr|)
                           (EXIT (LETT |curr| (CDR |curr|))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (COND ((NULL |curr|) (CONS 1 "failed"))
                        (#2#
                         (SEQ (SPADCALL |prev| (CDR |curr|) (QREFELT $ 27))
                              (EXIT
                               (CONS 0 (QCDR (|SPADfirst| |curr|)))))))))))))) 

(DECLAIM (NOTINLINE |AssociationList;|)) 

(DEFUN |AssociationList| (&REST #1=#:G859)
  (SPROG NIL
         (PROG (#2=#:G860)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|AssociationList|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |AssociationList;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|AssociationList|)))))))))) 

(DEFUN |AssociationList;| (|#1| |#2|)
  (SPROG
   ((#1=#:G856 NIL) (#2=#:G858 NIL) (#3=#:G857 NIL) (|pv$| NIL) (#4=#:G851 NIL)
    (#5=#:G852 NIL) (#6=#:G853 NIL) (#7=#:G854 NIL) (#8=#:G855 NIL) ($ NIL)
    (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|AssociationList| DV$1 DV$2))
    (LETT $ (GETREFV 74))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory|
                                         (|Record| (|:| |key| |#1|)
                                                   (|:| |entry| |#2|))
                                         '(|OrderedSet|))
                                        (|HasCategory|
                                         (|Record| (|:| |key| |#1|)
                                                   (|:| |entry| |#2|))
                                         '(|ConvertibleTo| (|InputForm|)))
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (|HasCategory| |#2| '(|BasicType|))
                                        (|HasCategory| |#2| '(|OrderedSet|))
                                        (|HasCategory| (|Integer|)
                                                       '(|OrderedSet|))
                                        (LETT #8#
                                              (|HasCategory|
                                               (|Record| (|:| |key| |#1|)
                                                         (|:| |entry| |#2|))
                                               '(|Comparable|)))
                                        (OR #8#
                                            (|HasCategory|
                                             (|Record| (|:| |key| |#1|)
                                                       (|:| |entry| |#2|))
                                             '(|OrderedSet|)))
                                        (LETT #7#
                                              (|HasCategory| |#2|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#2|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#2|)))
                                         #7#)
                                        (LETT #6#
                                              (|HasCategory|
                                               (|Record| (|:| |key| |#1|)
                                                         (|:| |entry| |#2|))
                                               '(|SetCategory|)))
                                        (AND
                                         (|HasCategory|
                                          (|Record| (|:| |key| |#1|)
                                                    (|:| |entry| |#2|))
                                          (LIST '|Evalable|
                                                (LIST '|Record|
                                                      (LIST '|:| '|key|
                                                            (|devaluate| |#1|))
                                                      (LIST '|:| '|entry|
                                                            (|devaluate|
                                                             |#2|)))))
                                         #6#)
                                        (OR #7# #8#
                                            (|HasCategory|
                                             (|Record| (|:| |key| |#1|)
                                                       (|:| |entry| |#2|))
                                             '(|OrderedSet|))
                                            #6#)
                                        (|HasCategory| |#2|
                                                       '(|CoercibleTo|
                                                         (|OutputForm|)))
                                        (LETT #5#
                                              (|HasCategory|
                                               (|Record| (|:| |key| |#1|)
                                                         (|:| |entry| |#2|))
                                               '(|CoercibleTo|
                                                 (|OutputForm|))))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CoercibleTo|
                                                          (|OutputForm|)))
                                         #7# #5# #8#
                                         (|HasCategory|
                                          (|Record| (|:| |key| |#1|)
                                                    (|:| |entry| |#2|))
                                          '(|OrderedSet|))
                                         #6#)
                                        (LETT #4#
                                              (|HasCategory|
                                               (|Record| (|:| |key| |#1|)
                                                         (|:| |entry| |#2|))
                                               '(|BasicType|)))
                                        (OR (|HasCategory| |#2| '(|BasicType|))
                                            #7# #4# #8#
                                            (|HasCategory|
                                             (|Record| (|:| |key| |#1|)
                                                       (|:| |entry| |#2|))
                                             '(|OrderedSet|))
                                            #6#)))))
    (|haddProp| |$ConstructorCache| '|AssociationList| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (LETT #3# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 262144))
    (AND (|HasCategory| |#2| '(|BasicType|)) #3#
         (|augmentPredVector| $ 524288))
    (AND (|HasCategory| |#2| '(|OrderedSet|)) #3#
         (|augmentPredVector| $ 1048576))
    (AND #3# #4# (|augmentPredVector| $ 2097152))
    (AND
     (LETT #2#
           (AND (|HasCategory| $ '(|finiteAggregate|))
                (|HasCategory| (|Record| (|:| |key| |#1|) (|:| |entry| |#2|))
                               '(|OrderedSet|))))
     (|augmentPredVector| $ 4194304))
    (AND (OR (AND #3# #8#) #2#) (|augmentPredVector| $ 8388608))
    (AND (OR #7# (AND #3# #8#) #2# #6#) (|augmentPredVector| $ 16777216))
    (AND
     (OR (|HasCategory| |#2| '(|CoercibleTo| (|OutputForm|))) (AND #3# #8#) #2#
         #5#)
     (|augmentPredVector| $ 33554432))
    (AND
     (OR (AND (|HasCategory| |#2| '(|BasicType|)) #3#) #7# (AND #3# #4#)
         (AND #3# #8#) #2# #6#)
     (|augmentPredVector| $ 67108864))
    (AND (LETT #1# (|HasCategory| $ '(|shallowlyMutable|)))
         (|augmentPredVector| $ 134217728))
    (AND #3# #1# (|augmentPredVector| $ 268435456))
    (AND #3# #1#
         (|HasCategory| (|Record| (|:| |key| |#1|) (|:| |entry| |#2|))
                        '(|OrderedSet|))
         (|augmentPredVector| $ 536870912))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8
              (|Reference|
               (|List| (|Record| (|:| |key| |#1|) (|:| |entry| |#2|)))))
    (COND
     ((|testBitVector| |pv$| 9)
      (QSETREFV $ 42 (CONS (|dispatchFunction| |ALIST;latex;$S;16|) $))))
    $))) 

(MAKEPROP '|AssociationList| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|Record| (|:| |key| 6) (|:| |entry| 7)) (|List| 9) (0 . |ref|)
              |ALIST;dictionary;$;1| |ALIST;empty;$;2| (5 . |deref|)
              (|Boolean|) |ALIST;empty?;$B;3| |ALIST;entries;$L;4|
              |ALIST;parts;$L;5| (|List| 6) |ALIST;keys;$L;6|
              (|NonNegativeInteger|) |ALIST;#;$Nni;7| |ALIST;first;$R;8|
              |ALIST;rest;2$;9| (10 . |concat|) |ALIST;concat;R2$;10|
              (16 . |setrest!|) |ALIST;setrest!;3$;11| (22 . |setfirst!|)
              |ALIST;setfirst!;$2R;12| (|Integer|) (28 . |minIndex|)
              |ALIST;minIndex;$I;13| (33 . |maxIndex|) |ALIST;maxIndex;$I;14|
              (38 . =) (|Union| 7 '"failed") |ALIST;search;Key$U;15| (|String|)
              (44 . |latex|) (49 . |latex|) (54 . |latex|)
              (|Union| 9 '"failed") |ALIST;assoc;Key$U;17| (59 . |setref|)
              |ALIST;setelt!;$Key2Entry;18| (65 . ~=) |ALIST;remove!;Key$U;19|
              (|List| 50) (|Equation| 9) (|Mapping| 9 9 9) (|Mapping| 15 9 9)
              (|List| 54) (|Equation| 7) (|List| 7) (|OutputForm|)
              (|SingleInteger|) (|HashState|) (|InputForm|) (|Mapping| 15 9)
              (|Mapping| 15 7) (|Mapping| 15 7 7) (|Mapping| 9 9) '"value"
              (|List| $) '"first" '"rest" '"last" (|UniversalSegment| 31)
              (|Void|) (|Mapping| 7 7) (|List| 31) (|Mapping| 7 7 7))
           '#(~= 71 |value| 77 |trim| 82 |third| 88 |tail| 93 |table| 98
              |swap!| 107 |split!| 121 |sorted?| 127 |sort!| 138 |sort| 149
              |smaller?| 160 |size?| 166 |setvalue!| 172 |setrest!| 178
              |setlast!| 184 |setfirst!| 190 |setelt!| 196 |setchildren!| 245
              |select!| 251 |select| 263 |second| 269 |search| 274 |sample| 280
              |rightTrim| 284 |reverse!| 290 |reverse| 295 |rest| 300
              |removeDuplicates!| 311 |removeDuplicates| 316 |remove!| 321
              |remove| 351 |reduce| 363 |qsetrest!| 384 |qsetfirst!| 390
              |qsetelt!| 396 |qelt| 410 |possiblyInfinite?| 422 |position| 427
              |parts| 446 |nodes| 456 |node?| 461 |new| 467 |more?| 473
              |minIndex| 479 |min| 489 |merge!| 505 |merge| 518 |members| 531
              |member?| 541 |maxIndex| 553 |max| 563 |map!| 591 |map| 603
              |list| 629 |less?| 634 |leftTrim| 640 |leaves| 646 |leaf?| 651
              |latex| 656 |last| 661 |keys| 672 |key?| 677 |inspect| 683
              |insert!| 688 |insert| 708 |indices| 722 |index?| 732
              |hashUpdate!| 744 |hash| 750 |first| 755 |find| 771 |fill!| 777
              |extract!| 789 |explicitlyFinite?| 794 |every?| 799 |eval| 811
              |eq?| 863 |entry?| 869 |entries| 881 |empty?| 891 |empty| 896
              |elt| 900 |distance| 956 |dictionary| 962 |delete!| 971 |delete|
              983 |cyclic?| 995 |cycleTail| 1000 |cycleSplit!| 1005
              |cycleLength| 1010 |cycleEntry| 1015 |count| 1020 |copyInto!|
              1044 |copy| 1051 |convert| 1056 |construct| 1061 |concat!| 1066
              |concat| 1083 |coerce| 1106 |children| 1111 |child?| 1116 |assoc|
              1122 |any?| 1128 >= 1140 > 1146 = 1152 <= 1158 < 1164 |#| 1170)
           'NIL
           (CONS
            (|makeByteWordVec2| 18
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 8 0 0 0
                                  12 10 13 0 0 0 0 0 0 12 10 18 16 1 2))
            (CONS
             '#(|AssociationListAggregate&| |TableAggregate&|
                |KeyedDictionary&| |Dictionary&| |ListAggregate&|
                |DictionaryOperations&| |ExtensibleLinearAggregate&| NIL
                |StreamAggregate&| |BagAggregate&| |LinearAggregate&|
                |UnaryRecursiveAggregate&| |IndexedAggregate&| |Collection&|
                |RecursiveAggregate&| |IndexedAggregate&| |OrderedSet&|
                |HomogeneousAggregate&| |HomogeneousAggregate&| NIL
                |EltableAggregate&| |EltableAggregate&| |Aggregate&|
                |Evalable&| |Evalable&| |SetCategory&| NIL NIL NIL NIL NIL NIL
                |InnerEvalable&| |InnerEvalable&| |BasicType&| NIL
                |PartialOrder&| NIL)
             (CONS
              '#((|AssociationListAggregate| 6 7) (|TableAggregate| 6 7)
                 (|KeyedDictionary| 6 7)
                 (|Dictionary| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|ListAggregate| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|DictionaryOperations|
                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|ExtensibleLinearAggregate|
                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|FiniteLinearAggregate|
                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|StreamAggregate| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|BagAggregate| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|LinearAggregate| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|UnaryRecursiveAggregate|
                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|IndexedAggregate| 31
                                     (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|Collection| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|RecursiveAggregate|
                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|IndexedAggregate| 6 7) (|OrderedSet|)
                 (|HomogeneousAggregate|
                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|HomogeneousAggregate| 7) (|Comparable|)
                 (|EltableAggregate| 31
                                     (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|EltableAggregate| 6 7) (|Aggregate|)
                 (|Evalable| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|Evalable| 7) (|SetCategory|) (|finiteAggregate|)
                 (|Eltable| 69 $$)
                 (|Eltable| 31 (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|Eltable| 6 7) (|Type|) (|shallowlyMutable|)
                 (|InnerEvalable| (|Record| (|:| |key| 6) (|:| |entry| 7))
                                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|InnerEvalable| 7 7) (|BasicType|) (|CoercibleTo| 56)
                 (|PartialOrder|) (|ConvertibleTo| 59))
              (|makeByteWordVec2| 73
                                  '(1 8 0 10 11 1 8 10 0 14 2 10 0 9 0 25 2 10
                                    0 0 0 27 2 10 9 0 9 29 1 10 31 0 32 1 10 31
                                    0 34 2 6 15 0 0 36 1 6 39 0 40 1 7 39 0 41
                                    1 0 39 0 42 2 8 10 0 10 45 2 6 15 0 0 47 2
                                    27 15 0 0 1 1 0 9 0 1 2 22 0 0 9 1 1 0 9 0
                                    1 1 0 0 0 1 0 0 0 1 1 0 0 10 1 3 28 70 0 31
                                    31 1 3 28 70 0 6 6 1 2 28 0 0 21 1 1 23 15
                                    0 1 2 19 15 52 0 1 1 30 0 0 1 2 29 0 52 0 1
                                    1 23 0 0 1 2 19 0 52 0 1 2 24 15 0 0 1 2 0
                                    15 0 21 1 2 28 9 0 9 1 2 28 0 0 0 28 2 28 9
                                    0 9 1 2 28 9 0 9 30 3 28 9 0 64 9 1 3 28 9
                                    0 66 9 1 3 28 0 0 67 0 1 3 28 9 0 68 9 1 3
                                    28 9 0 69 9 1 3 28 9 0 31 9 1 3 0 7 0 6 7
                                    46 2 28 0 0 65 1 2 19 0 60 0 1 2 0 0 60 0 1
                                    2 19 0 60 0 1 1 0 9 0 1 2 0 37 6 0 38 0 0 0
                                    1 2 22 0 0 9 1 1 29 0 0 1 1 19 0 0 1 1 0 0
                                    0 24 2 0 0 0 21 1 1 17 0 0 1 1 22 0 0 1 2
                                    22 0 9 0 1 2 17 0 9 0 1 2 19 0 60 0 1 2 0 0
                                    60 0 1 2 0 37 6 0 48 2 22 0 9 0 1 2 19 0 60
                                    0 1 4 22 9 51 0 9 9 1 2 19 9 51 0 1 3 19 9
                                    51 0 9 1 2 28 0 0 0 1 2 28 9 0 9 1 3 28 9 0
                                    31 9 1 3 28 7 0 6 7 1 2 0 9 0 31 1 2 0 7 0
                                    6 1 1 0 15 0 1 2 22 31 9 0 1 3 22 31 9 0 31
                                    1 2 19 31 60 0 1 1 19 10 0 18 1 19 55 0 1 1
                                    0 65 0 1 2 17 15 0 0 1 2 0 0 21 9 1 2 0 15
                                    0 21 1 1 6 31 0 33 1 3 6 0 1 1 23 9 0 1 2
                                    23 0 0 0 1 1 21 7 0 1 2 1 0 0 0 1 3 0 0 52
                                    0 0 1 2 23 0 0 0 1 3 19 0 52 0 0 1 1 19 10
                                    0 1 1 19 55 0 1 2 22 15 9 0 1 2 20 15 7 0 1
                                    1 6 31 0 35 1 3 6 0 1 1 23 9 0 1 2 23 0 0 0
                                    1 1 21 7 0 1 2 19 9 52 0 1 2 19 7 62 0 1 2
                                    28 0 63 0 1 2 28 0 71 0 1 2 0 0 63 0 1 3 0
                                    0 51 0 0 1 3 0 0 73 0 0 1 2 0 0 71 0 1 1 0
                                    0 9 1 2 0 15 0 21 1 2 22 0 0 9 1 1 0 10 0 1
                                    1 0 15 0 1 1 25 39 0 42 1 0 9 0 1 2 0 0 0
                                    21 1 1 0 19 0 20 2 0 15 6 0 1 1 0 9 0 1 3 0
                                    0 0 0 31 1 3 0 0 9 0 31 1 2 0 0 9 0 1 3 0 0
                                    9 0 31 1 3 0 0 0 0 31 1 1 0 72 0 1 1 0 19 0
                                    1 2 0 15 31 0 1 2 0 15 6 0 1 2 25 58 58 0 1
                                    1 25 57 0 1 1 3 7 0 1 1 0 9 0 23 2 0 0 0 21
                                    1 2 0 43 60 0 1 2 28 0 0 9 1 2 28 0 0 7 1 1
                                    0 9 0 1 1 0 15 0 1 2 19 15 60 0 1 2 19 15
                                    61 0 1 2 12 0 0 49 1 3 12 0 0 9 9 1 2 12 0
                                    0 50 1 3 12 0 0 10 10 1 2 10 0 0 53 1 2 10
                                    0 0 54 1 3 10 0 0 55 55 1 3 10 0 0 7 7 1 2
                                    0 15 0 0 1 2 22 15 9 0 1 2 20 15 7 0 1 1 0
                                    10 0 17 1 0 55 0 1 1 0 15 0 16 0 0 0 13 2 0
                                    9 0 64 1 2 0 9 0 66 1 2 0 0 0 67 1 2 0 9 0
                                    68 1 2 0 0 0 69 1 3 0 9 0 31 9 1 2 0 9 0 31
                                    1 2 0 7 0 6 1 3 0 7 0 6 7 1 2 0 31 0 0 1 0
                                    0 0 12 1 0 0 10 1 2 0 0 0 31 1 2 0 0 0 69 1
                                    2 0 0 0 31 1 2 0 0 0 69 1 1 0 15 0 1 1 0 0
                                    0 1 1 28 0 0 1 1 0 21 0 1 1 0 0 0 1 2 22 21
                                    9 0 1 2 20 21 7 0 1 2 19 21 60 0 1 2 19 21
                                    61 0 1 3 29 0 0 0 31 1 1 0 0 0 1 1 2 59 0 1
                                    1 0 0 10 1 1 28 0 65 1 2 0 0 0 0 1 2 0 0 0
                                    9 1 2 0 0 9 0 26 2 0 0 0 0 1 2 0 0 0 9 1 1
                                    0 0 65 1 1 26 56 0 1 1 0 65 0 1 2 17 15 0 0
                                    1 2 0 43 6 0 44 2 19 15 60 0 1 2 19 15 61 0
                                    1 2 23 15 0 0 1 2 23 15 0 0 1 2 27 15 0 0 1
                                    2 23 15 0 0 1 2 23 15 0 0 1 1 19 21 0
                                    22)))))
           '|lookupComplete|)) 

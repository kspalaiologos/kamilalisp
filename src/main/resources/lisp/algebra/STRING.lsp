
(PUT '|STRING;ucodeToString;I$;1| '|SPADreplace| 'NUM2USTR) 

(SDEFUN |STRING;ucodeToString;I$;1| ((|n| (|Integer|)) ($ ($))) (NUM2USTR |n|)) 

(PUT '|STRING;uentries;$L;2| '|SPADreplace| 'UENTRIES) 

(SDEFUN |STRING;uentries;$L;2| ((|s| ($)) ($ (|List| (|SingleInteger|))))
        (UENTRIES |s|)) 

(PUT '|STRING;string;I$;3| '|SPADreplace| 'STRINGIMAGE) 

(SDEFUN |STRING;string;I$;3| ((|n| (|Integer|)) ($ ($))) (STRINGIMAGE |n|)) 

(SDEFUN |STRING;OMwrite;Omd$BV;4|
        ((|dev| (|OpenMathDevice|)) (|x| ($)) (|wholeObj| (|Boolean|))
         ($ (|Void|)))
        (SEQ (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 13))))
             (SPADCALL |dev| |x| (QREFELT $ 15))
             (EXIT (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 16))))))) 

(PUT '|STRING;convert;$If;5| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |STRING;convert;$If;5| ((|x| ($)) ($ (|InputForm|))) |x|) 

(PUT '|STRING;qelt;$IC;6| '|SPADreplace| 'STR_ELT1) 

(SDEFUN |STRING;qelt;$IC;6| ((|s| ($)) (|i| (|Integer|)) ($ (|Character|)))
        (STR_ELT1 |s| |i|)) 

(PUT '|STRING;qsetelt!;$I2C;7| '|SPADreplace| 'STR_SETELT1) 

(SDEFUN |STRING;qsetelt!;$I2C;7|
        ((|s| ($)) (|i| (|Integer|)) (|c| #1=(|Character|)) ($ #1#))
        (STR_SETELT1 |s| |i| |c|)) 

(DECLAIM (NOTINLINE |String;|)) 

(DEFUN |String| ()
  (SPROG NIL
         (PROG (#1=#:G2712)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|String|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|String|
                             (LIST (CONS NIL (CONS 1 (|String;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|String|)))))))))) 

(DEFUN |String;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (#1=#:G2710 NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|String|))
          (LETT $ (GETREFV 40))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (AND
                                               (|HasCategory| (|Character|)
                                                              '(|Evalable|
                                                                (|Character|)))
                                               (|HasCategory| (|Character|)
                                                              '(|SetCategory|)))
                                              (|HasCategory| (|Character|)
                                                             '(|OrderedSet|))
                                              (|HasCategory| (|Character|)
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|OrderedSet|))
                                              (|HasCategory| (|Character|)
                                                             '(|BasicType|))
                                              (LETT #1#
                                                    (|HasCategory|
                                                     (|Character|)
                                                     '(|Comparable|)))
                                              (OR #1#
                                                  (|HasCategory| (|Character|)
                                                                 '(|OrderedSet|)))))))
          (|haddProp| |$ConstructorCache| '|String| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (AND (|HasCategory| $ '(|shallowlyMutable|))
               (|augmentPredVector| $ 128))
          (AND (|HasCategory| $ '(|finiteAggregate|))
               (|augmentPredVector| $ 256))
          (AND (|HasCategory| $ '(|finiteAggregate|))
               (|HasCategory| (|Character|) '(|BasicType|))
               (|augmentPredVector| $ 512))
          (AND (|HasCategory| $ '(|finiteAggregate|))
               (|HasCategory| $ '(|shallowlyMutable|))
               (|augmentPredVector| $ 1024))
          (AND (|HasCategory| $ '(|finiteAggregate|))
               (|HasCategory| $ '(|shallowlyMutable|))
               (|HasCategory| (|Character|) '(|OrderedSet|))
               (|augmentPredVector| $ 2048))
          (AND (|HasCategory| $ '(|finiteAggregate|))
               (|HasCategory| (|Character|) '(|OrderedSet|))
               (|augmentPredVector| $ 4096))
          (AND
           (OR (AND (|HasCategory| $ '(|finiteAggregate|)) #1#)
               (AND (|HasCategory| $ '(|finiteAggregate|))
                    (|HasCategory| (|Character|) '(|OrderedSet|))))
           (|augmentPredVector| $ 8192))
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|String| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|IndexedString| (NRTEVAL 1)) (|Integer|)
              |STRING;ucodeToString;I$;1| (|List| 35) |STRING;uentries;$L;2|
              |STRING;string;I$;3| (|Void|) (|OpenMathDevice|)
              (0 . |OMputObject|) (|String|) (5 . |OMputString|)
              (11 . |OMputEndObject|) (|Boolean|) |STRING;OMwrite;Omd$BV;4|
              (|InputForm|) |STRING;convert;$If;5| (|Character|)
              |STRING;qelt;$IC;6| |STRING;qsetelt!;$I2C;7| (|List| 21)
              (|List| 26) (|Equation| 21) (|Mapping| 21 21 21)
              (|NonNegativeInteger|) (|Mapping| 17 21 21) (|Mapping| 17 21)
              (|UniversalSegment| 6) (|Mapping| 21 21) (|OutputForm|)
              (|HashState|) (|SingleInteger|) (|CharacterClass|) (|List| $)
              (|Union| 21 '"failed") (|List| 6))
           '#(|uentries| 16 |ucodeToString| 21 |string| 26 |qsetelt!| 31 |qelt|
              38 |convert| 44 |OMwrite| 49)
           'NIL
           (CONS
            (|makeByteWordVec2| 7
                                '(0 0 0 0 0 0 0 2 0 7 0 0 0 1 0 0 0 0 0 0 0 0 1
                                  2 3))
            (CONS
             '#(NIL |StringAggregate&| |OneDimensionalArrayAggregate&| NIL
                |LinearAggregate&| |IndexedAggregate&| |Collection&|
                |OrderedSet&| |HomogeneousAggregate&| NIL |SetCategory&|
                |Aggregate&| |EltableAggregate&| |Evalable&| |OpenMath&| NIL
                |BasicType&| NIL NIL NIL NIL NIL |InnerEvalable&|
                |PartialOrder&| NIL)
             (CONS
              '#((|StringCategory|) (|StringAggregate|)
                 (|OneDimensionalArrayAggregate| 21)
                 (|FiniteLinearAggregate| 21) (|LinearAggregate| 21)
                 (|IndexedAggregate| 6 21) (|Collection| 21) (|OrderedSet|)
                 (|HomogeneousAggregate| 21) (|Comparable|) (|SetCategory|)
                 (|Aggregate|) (|EltableAggregate| 6 21) (|Evalable| 21)
                 (|OpenMath|) (|CoercibleTo| 33) (|BasicType|)
                 (|shallowlyMutable|) (|finiteAggregate|) (|Eltable| 31 $$)
                 (|Type|) (|Eltable| 6 21) (|InnerEvalable| 21 21)
                 (|PartialOrder|) (|ConvertibleTo| 19))
              (|makeByteWordVec2| 23
                                  '(1 12 11 0 13 2 12 11 0 14 15 1 12 11 0 16 1
                                    0 8 0 9 1 0 0 6 7 1 0 0 6 10 3 8 21 0 6 21
                                    23 2 0 21 0 6 22 1 3 19 0 20 3 0 11 12 0 17
                                    18)))))
           '|lookupIncomplete|)) 

(MAKEPROP '|String| 'NILADIC T) 

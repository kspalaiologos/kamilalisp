
(SDEFUN |OVAR;convert;$S;1| ((|s1| ($)) ($ (|Symbol|)))
        (SPADCALL (QREFELT $ 6) |s1| (QREFELT $ 12))) 

(SDEFUN |OVAR;coerce;$Of;2| ((|s1| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |s1| (QREFELT $ 13)) (QREFELT $ 15))) 

(SDEFUN |OVAR;convert;$If;3| ((|s1| ($)) ($ (|InputForm|)))
        (SPADCALL (SPADCALL |s1| (QREFELT $ 13)) (QREFELT $ 18))) 

(SDEFUN |OVAR;convert;$P;4| ((|s1| ($)) ($ (|Pattern| (|Integer|))))
        (SPADCALL (SPADCALL |s1| (QREFELT $ 13)) (QREFELT $ 21))) 

(SDEFUN |OVAR;convert;$P;5| ((|s1| ($)) ($ (|Pattern| (|Float|))))
        (SPADCALL (SPADCALL |s1| (QREFELT $ 13)) (QREFELT $ 24))) 

(PUT '|OVAR;index;Pi$;6| '|SPADreplace| '(XLAM (|i|) |i|)) 

(SDEFUN |OVAR;index;Pi$;6| ((|i| (|PositiveInteger|)) ($ ($))) |i|) 

(PUT '|OVAR;lookup;$Pi;7| '|SPADreplace| '(XLAM (|j|) |j|)) 

(SDEFUN |OVAR;lookup;$Pi;7| ((|j| ($)) ($ (|PositiveInteger|))) |j|) 

(SDEFUN |OVAR;size;Nni;8| (($ (|NonNegativeInteger|))) (LENGTH (QREFELT $ 6))) 

(SDEFUN |OVAR;variable;SU;9| ((|exp| (|Symbol|)) ($ (|Union| $ "failed")))
        (SPROG
         ((#1=#:G735 NIL) (#2=#:G728 NIL) (|i| NIL) (#3=#:G736 NIL)
          (|exp2| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |exp2| NIL) (LETT #3# (QREFELT $ 6)) (LETT |i| 1) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |exp2| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((EQUAL |exp| |exp2|)
                     (PROGN
                      (LETT #1#
                            (CONS 0
                                  (PROG1 (LETT #2# |i|)
                                    (|check_subtype2| (> #2# 0)
                                                      '(|PositiveInteger|)
                                                      '(|NonNegativeInteger|)
                                                      #2#))))
                      (GO #4=#:G734))))))
                 (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #3# (CDR #3#))))
                 (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 1 "failed"))))
          #4# (EXIT #1#)))) 

(PUT '|OVAR;<;2$B;10| '|SPADreplace| '(XLAM (|s1| |s2|) (< |s2| |s1|))) 

(SDEFUN |OVAR;<;2$B;10| ((|s1| ($)) (|s2| ($)) ($ (|Boolean|))) (< |s2| |s1|)) 

(PUT '|OVAR;=;2$B;11| '|SPADreplace| 'EQL) 

(SDEFUN |OVAR;=;2$B;11| ((|s1| ($)) (|s2| ($)) ($ (|Boolean|))) (EQL |s1| |s2|)) 

(SDEFUN |OVAR;latex;$S;12| ((|x| ($)) ($ (|String|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 37))) 

(SDEFUN |OVAR;hashUpdate!;Hs$Hs;13| ((|hs| #1=(|HashState|)) (|s| ($)) ($ #1#))
        (HASHSTATEUPDATE |hs| (SXHASH |s|))) 

(DECLAIM (NOTINLINE |OrderedVariableList;|)) 

(DEFUN |OrderedVariableList| (#1=#:G741)
  (SPROG NIL
         (PROG (#2=#:G742)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|OrderedVariableList|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|OrderedVariableList;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|OrderedVariableList|)))))))))) 

(DEFUN |OrderedVariableList;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|OrderedVariableList| DV$1))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OrderedVariableList| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (SETELT $ 6 (SPADCALL |#1| (QREFELT $ 8)))
          (QSETREFV $ 9 (|PositiveInteger|))
          $))) 

(MAKEPROP '|OrderedVariableList| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|List| 10)
              (0 . |removeDuplicates|) '|Rep| (|Symbol|) (|Integer|)
              (5 . |elt|) |OVAR;convert;$S;1| (|OutputForm|) (11 . |coerce|)
              |OVAR;coerce;$Of;2| (|InputForm|) (16 . |convert|)
              |OVAR;convert;$If;3| (|Pattern| 11) (21 . |convert|)
              |OVAR;convert;$P;4| (|Pattern| (|Float|)) (26 . |convert|)
              |OVAR;convert;$P;5| (|PositiveInteger|) |OVAR;index;Pi$;6|
              |OVAR;lookup;$Pi;7| (|NonNegativeInteger|) |OVAR;size;Nni;8|
              (|Union| $ '"failed") |OVAR;variable;SU;9| (|Boolean|)
              |OVAR;<;2$B;10| |OVAR;=;2$B;11| (|String|) (31 . |latex|)
              |OVAR;latex;$S;12| (|HashState|) |OVAR;hashUpdate!;Hs$Hs;13|
              (|List| $) (|SingleInteger|))
           '#(~= 36 |variable| 42 |smaller?| 47 |size| 53 |random| 57 |min| 61
              |max| 67 |lookup| 73 |latex| 78 |index| 83 |hashUpdate!| 88
              |hash| 94 |enumerate| 99 |convert| 103 |coerce| 123 >= 128 > 134
              = 140 <= 146 < 152)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(NIL |OrderedSet&| |Finite&| NIL |SetCategory&| NIL NIL NIL
                     NIL |BasicType&| |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedFinite|) (|OrderedSet|) (|Finite|)
                      (|Comparable|) (|SetCategory|) (|ConvertibleTo| 20)
                      (|ConvertibleTo| 23) (|ConvertibleTo| 10)
                      (|ConvertibleTo| 17) (|BasicType|) (|PartialOrder|)
                      (|CoercibleTo| 14))
                   (|makeByteWordVec2| 42
                                       '(1 7 0 0 8 2 7 10 0 11 12 1 10 14 0 15
                                         1 10 17 0 18 1 10 20 0 21 1 10 23 0 24
                                         1 10 36 0 37 2 0 33 0 0 1 1 0 31 10 32
                                         2 0 33 0 0 1 0 0 29 30 0 0 0 1 2 0 0 0
                                         0 1 2 0 0 0 0 1 1 0 26 0 28 1 0 36 0
                                         38 1 0 0 26 27 2 0 39 39 0 40 1 0 42 0
                                         1 0 0 41 1 1 0 20 0 22 1 0 23 0 25 1 0
                                         17 0 19 1 0 10 0 13 1 0 14 0 16 2 0 33
                                         0 0 1 2 0 33 0 0 1 2 0 33 0 0 35 2 0
                                         33 0 0 1 2 0 33 0 0 34)))))
           '|lookupComplete|)) 

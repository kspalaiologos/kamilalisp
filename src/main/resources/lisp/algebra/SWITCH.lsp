
(SDEFUN |SWITCH;coerce;$Of;1| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|ran| (|List| (|OutputForm|))) (#1=#:G717 NIL) (|u| NIL)
          (#2=#:G716 NIL) (|rat| (|OutputForm|)))
         (SEQ (LETT |rat| (SPADCALL (QCAR |s|) (QREFELT $ 12)))
              (LETT |ran|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |u| NIL) (LETT #1# (QCDR |s|)) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |u| (QREFELT $ 14)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT
               (COND
                ((SPADCALL (QCAR |s|) (QREFELT $ 10) (QREFELT $ 16))
                 (|SPADfirst| |ran|))
                ((EQL (LENGTH |ran|) 1) (SPADCALL |rat| |ran| (QREFELT $ 20)))
                ('T (SPADCALL |rat| |ran| (QREFELT $ 21)))))))) 

(SDEFUN |SWITCH;coerce;S$;2| ((|s| (|Symbol|)) ($ ($)))
        (CONS (QREFELT $ 10) (LIST (CONS 0 (SPADCALL |s| (QREFELT $ 23)))))) 

(SDEFUN |SWITCH;NOT;U$;3|
        ((|r|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         ($ ($)))
        (CONS (SPADCALL '~ (QREFELT $ 9)) (LIST |r|))) 

(SDEFUN |SWITCH;NOT;2$;4| ((|r| ($)) ($ ($)))
        (CONS (SPADCALL '~ (QREFELT $ 9)) (LIST (CONS 3 |r|)))) 

(SDEFUN |SWITCH;LT;2U$;5|
        ((|r1|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         (|r2|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         ($ ($)))
        (CONS (SPADCALL '< (QREFELT $ 9)) (LIST |r1| |r2|))) 

(SDEFUN |SWITCH;GT;2U$;6|
        ((|r1|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         (|r2|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         ($ ($)))
        (CONS (SPADCALL '> (QREFELT $ 9)) (LIST |r1| |r2|))) 

(SDEFUN |SWITCH;LE;2U$;7|
        ((|r1|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         (|r2|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         ($ ($)))
        (CONS (SPADCALL '<= (QREFELT $ 9)) (LIST |r1| |r2|))) 

(SDEFUN |SWITCH;GE;2U$;8|
        ((|r1|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         (|r2|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         ($ ($)))
        (CONS (SPADCALL '>= (QREFELT $ 9)) (LIST |r1| |r2|))) 

(SDEFUN |SWITCH;AND;2U$;9|
        ((|r1|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         (|r2|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         ($ ($)))
        (CONS (SPADCALL '|and| (QREFELT $ 9)) (LIST |r1| |r2|))) 

(SDEFUN |SWITCH;OR;2U$;10|
        ((|r1|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         (|r2|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         ($ ($)))
        (CONS (SPADCALL '|or| (QREFELT $ 9)) (LIST |r1| |r2|))) 

(SDEFUN |SWITCH;EQ;2U$;11|
        ((|r1|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         (|r2|
          (|Union| (|:| I (|Expression| (|Integer|)))
                   (|:| F (|Expression| (|Float|)))
                   (|:| CF (|Expression| (|Complex| (|Float|))))
                   (|:| |switch| $)))
         ($ ($)))
        (CONS (SPADCALL 'EQ (QREFELT $ 9)) (LIST |r1| |r2|))) 

(DECLAIM (NOTINLINE |Switch;|)) 

(DEFUN |Switch| ()
  (SPROG NIL
         (PROG (#1=#:G773)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Switch|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Switch|
                             (LIST (CONS NIL (CONS 1 (|Switch;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Switch|)))))))))) 

(DEFUN |Switch;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Switch|))
          (LETT $ (GETREFV 35))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Switch| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |op| (|BasicOperator|))
                              (|:| |rands|
                                   (|List|
                                    (|Union| (|:| I (|Expression| (|Integer|)))
                                             (|:| F (|Expression| (|Float|)))
                                             (|:| CF
                                                  (|Expression|
                                                   (|Complex| (|Float|))))
                                             (|:| |switch| $))))))
          (QSETREFV $ 10 (SPADCALL 'NULL (QREFELT $ 9)))
          $))) 

(MAKEPROP '|Switch| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Symbol|) (|BasicOperator|)
              (0 . |operator|) '|nullOp| (|OutputForm|) (5 . |coerce|)
              (|Union| (|:| I 17) (|:| F (|Expression| (|Float|)))
                       (|:| CF (|Expression| (|Complex| (|Float|))))
                       (|:| |switch| $$))
              (10 . |coerce|) (|Boolean|) (15 . =) (|Expression| (|Integer|))
              (21 . |One|) (|List| $) (25 . |prefix|) (31 . |infix|)
              |SWITCH;coerce;$Of;1| (37 . |coerce|) |SWITCH;coerce;S$;2|
              (|Union| (|:| I 17) (|:| F (|Expression| (|Float|)))
                       (|:| CF (|Expression| (|Complex| (|Float|))))
                       (|:| |switch| $))
              |SWITCH;NOT;U$;3| |SWITCH;NOT;2$;4| |SWITCH;LT;2U$;5|
              |SWITCH;GT;2U$;6| |SWITCH;LE;2U$;7| |SWITCH;GE;2U$;8|
              |SWITCH;AND;2U$;9| |SWITCH;OR;2U$;10| |SWITCH;EQ;2U$;11|)
           '#(|coerce| 42 OR 52 NOT 58 LT 68 LE 74 GT 80 GE 86 EQ 92 AND 98)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|CoercibleTo| 11))
                             (|makeByteWordVec2| 34
                                                 '(1 8 0 7 9 1 8 11 0 12 1 13
                                                   11 0 14 2 8 15 0 0 16 0 17 0
                                                   18 2 11 0 0 19 20 2 11 0 0
                                                   19 21 1 17 0 7 23 1 0 11 0
                                                   22 1 0 0 7 24 2 0 0 25 25 33
                                                   1 0 0 25 26 1 0 0 0 27 2 0 0
                                                   25 25 28 2 0 0 25 25 30 2 0
                                                   0 25 25 29 2 0 0 25 25 31 2
                                                   0 0 25 25 34 2 0 0 25 25
                                                   32)))))
           '|lookupComplete|)) 

(MAKEPROP '|Switch| 'NILADIC T) 


(PUT '|ICARD;<;2$B;1| '|SPADreplace| '(XLAM (|x| |y|) (CGREATERP |y| |x|))) 

(SDEFUN |ICARD;<;2$B;1| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (CGREATERP |y| |x|)) 

(PUT '|ICARD;=;2$B;2| '|SPADreplace| 'EQUAL) 

(SDEFUN |ICARD;=;2$B;2| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (EQUAL |x| |y|)) 

(PUT '|ICARD;db_part| '|SPADreplace| '|dbPart|) 

(SDEFUN |ICARD;db_part|
        ((|x| ($)) (|n| (|Integer|)) (|k| (|Integer|)) ($ (|String|)))
        (|dbPart| |x| |n| |k|)) 

(SDEFUN |ICARD;alql_get_kind| ((|x| ($)) ($ (|String|)))
        (SPROG ((|xs| (|String|)))
               (SEQ (LETT |xs| |x|)
                    (COND
                     ((OR
                       (|eql_SI| (SPADCALL |xs| 1 (QREFELT $ 12))
                                 (|STR_to_CHAR| "a"))
                       (|eql_SI| (SPADCALL |xs| 1 (QREFELT $ 12))
                                 (|STR_to_CHAR| "o")))
                      (EXIT
                       (SPADCALL (|ICARD;db_part| |x| 5 1 $)
                                 (SPADCALL 1 1 (QREFELT $ 14))
                                 (QREFELT $ 15)))))
                    (EXIT
                     (SPADCALL |xs| (SPADCALL 1 1 (QREFELT $ 14))
                               (QREFELT $ 15)))))) 

(SDEFUN |ICARD;alql_get_origin| ((|x| ($)) ($ (|String|)))
        (SPROG ((|k| (|Integer|)) (|field| (|String|)))
               (SEQ (LETT |field| (|ICARD;db_part| |x| 5 1 $))
                    (LETT |k|
                          (SPADCALL (|STR_to_CHAR| "(") |field| 3
                                    (QREFELT $ 16)))
                    (EXIT
                     (COND
                      ((< |k| 1)
                       (SPADCALL |field| (SPADCALL 2 (QREFELT $ 17))
                                 (QREFELT $ 15)))
                      ('T
                       (SPADCALL |field| (SPADCALL 2 (- |k| 1) (QREFELT $ 14))
                                 (QREFELT $ 15)))))))) 

(SDEFUN |ICARD;alql_get_params| ((|x| ($)) ($ (|String|)))
        (SPROG ((|k| (|Integer|)) (|field| (|String|)))
               (SEQ (LETT |field| (|ICARD;db_part| |x| 5 1 $))
                    (LETT |k|
                          (SPADCALL (|STR_to_CHAR| "(") |field|
                                    (QREFELT $ 18)))
                    (EXIT
                     (COND ((< |k| 1) "")
                           ('T
                            (SPADCALL |field| (SPADCALL |k| (QREFELT $ 17))
                                      (QREFELT $ 15)))))))) 

(SDEFUN |ICARD;display;$V;7| ((|x| ($)) ($ (|Void|)))
        (SPROG ((|type| (|OutputForm|)) (|name| (|OutputForm|)))
               (SEQ (LETT |name| (|dbName| |x|))
                    (LETT |type|
                          (SPADCALL (|ICARD;db_part| |x| 4 1 $)
                                    (QREFELT $ 20)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL |name|
                                (SPADCALL (SPADCALL " : " (QREFELT $ 20))
                                          |type| (QREFELT $ 21))
                                (QREFELT $ 21))
                      (QREFELT $ 24)))))) 

(SDEFUN |ICARD;fullDisplay;$V;8| ((|x| ($)) ($ (|Void|)))
        (SPROG
         ((|secondPart| #1=(|OutputForm|)) (|firstPart| #1#)
          (|exposedPart| (|OutputForm|)) (|exposed?| (|String|)) (|ifPart| #1#)
          (|condition| (|String|)) (|fromPart| #1#) (|origin| #1#)
          (|type| (|OutputForm|)) (|name| (|OutputForm|)))
         (SEQ (LETT |name| (|dbName| |x|))
              (LETT |type|
                    (SPADCALL (|ICARD;db_part| |x| 4 1 $) (QREFELT $ 20)))
              (LETT |origin|
                    (SPADCALL
                     (SPADCALL (|ICARD;alql_get_origin| |x| $) (QREFELT $ 20))
                     (SPADCALL (|ICARD;alql_get_params| |x| $) (QREFELT $ 20))
                     (QREFELT $ 21)))
              (LETT |fromPart|
                    (SPADCALL (SPADCALL " from " (QREFELT $ 20)) |origin|
                              (QREFELT $ 21)))
              (LETT |condition| (|ICARD;db_part| |x| 6 1 $))
              (LETT |ifPart|
                    (COND ((EQUAL |condition| "") (SPADCALL (QREFELT $ 26)))
                          (#2='T
                           (SPADCALL (SPADCALL " if " (QREFELT $ 20))
                                     (SPADCALL |condition| (QREFELT $ 20))
                                     (QREFELT $ 21)))))
              (LETT |exposed?|
                    (SPADCALL (|ICARD;db_part| |x| 3 1 $)
                              (SPADCALL 1 1 (QREFELT $ 14)) (QREFELT $ 15)))
              (LETT |exposedPart|
                    (COND
                     ((EQUAL |exposed?| "n")
                      (SPADCALL " (unexposed)" (QREFELT $ 20)))
                     (#2# (SPADCALL (QREFELT $ 26)))))
              (LETT |firstPart|
                    (SPADCALL |name|
                              (SPADCALL (SPADCALL " : " (QREFELT $ 20)) |type|
                                        (QREFELT $ 21))
                              (QREFELT $ 21)))
              (LETT |secondPart|
                    (SPADCALL |fromPart|
                              (SPADCALL |ifPart| |exposedPart| (QREFELT $ 21))
                              (QREFELT $ 21)))
              (EXIT
               (SPADCALL (SPADCALL |firstPart| |secondPart| (QREFELT $ 21))
                         (QREFELT $ 24)))))) 

(PUT '|ICARD;coerce;S$;9| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |ICARD;coerce;S$;9| ((|s| (|String|)) ($ ($))) |s|) 

(SDEFUN |ICARD;coerce;$Of;10| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL |x| (QREFELT $ 29))) 

(SDEFUN |ICARD;elt;$SS;11| ((|x| ($)) (|s| (|Symbol|)) ($ (|String|)))
        (COND ((EQUAL |s| '|name|) (|dbName| |x|))
              ((EQUAL |s| '|nargs|) (|ICARD;db_part| |x| 2 1 $))
              ((EQUAL |s| '|exposed|)
               (SPADCALL (|ICARD;db_part| |x| 3 1 $)
                         (SPADCALL 1 1 (QREFELT $ 14)) (QREFELT $ 15)))
              ((EQUAL |s| '|type|) (|ICARD;db_part| |x| 4 1 $))
              ((EQUAL |s| '|abbreviation|) (|ICARD;db_part| |x| 5 1 $))
              ((EQUAL |s| '|kind|) (|ICARD;alql_get_kind| |x| $))
              ((EQUAL |s| '|origin|) (|ICARD;alql_get_origin| |x| $))
              ((EQUAL |s| '|params|) (|ICARD;alql_get_params| |x| $))
              ((EQUAL |s| '|condition|) (|ICARD;db_part| |x| 6 1 $))
              ((EQUAL |s| '|doc|) (|dbComments| |x|))
              ('T (|error| "unknown selector")))) 

(DECLAIM (NOTINLINE |IndexCard;|)) 

(DEFUN |IndexCard| ()
  (SPROG NIL
         (PROG (#1=#:G746)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|IndexCard|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|IndexCard|
                             (LIST (CONS NIL (CONS 1 (|IndexCard;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|IndexCard|)))))))))) 

(DEFUN |IndexCard;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|IndexCard|))
          (LETT $ (GETREFV 35))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IndexCard| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IndexCard| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Boolean|) |ICARD;<;2$B;1|
              |ICARD;=;2$B;2| (|Character|) (|Integer|) (|String|) (0 . |elt|)
              (|UniversalSegment| 10) (6 . SEGMENT) (12 . |elt|)
              (18 . |position|) (25 . SEGMENT) (30 . |position|) (|OutputForm|)
              (36 . |message|) (41 . |hconcat|) (|Void|) (|OutputPackage|)
              (47 . |output|) |ICARD;display;$V;7| (52 . |empty|)
              |ICARD;fullDisplay;$V;8| |ICARD;coerce;S$;9| (56 . |coerce|)
              |ICARD;coerce;$Of;10| (|Symbol|) |ICARD;elt;$SS;11|
              (|SingleInteger|) (|HashState|))
           '#(~= 61 |smaller?| 67 |min| 73 |max| 79 |latex| 85 |hashUpdate!| 90
              |hash| 96 |fullDisplay| 101 |elt| 106 |display| 112 |coerce| 117
              >= 127 > 133 = 139 <= 145 < 151)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0))
                 (CONS
                  '#(|OrderedSet&| NIL |SetCategory&| |BasicType&|
                     |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedSet|) (|Comparable|) (|SetCategory|)
                      (|BasicType|) (|PartialOrder|) (|CoercibleTo| 19))
                   (|makeByteWordVec2| 34
                                       '(2 11 9 0 10 12 2 13 0 10 10 14 2 11 0
                                         0 13 15 3 11 10 9 0 10 16 1 13 0 10 17
                                         2 11 10 9 0 18 1 19 0 11 20 2 19 0 0 0
                                         21 1 23 22 19 24 0 19 0 26 1 11 19 0
                                         29 2 0 6 0 0 1 2 0 6 0 0 1 2 0 0 0 0 1
                                         2 0 0 0 0 1 1 0 11 0 1 2 0 34 34 0 1 1
                                         0 33 0 1 1 0 22 0 27 2 0 11 0 31 32 1
                                         0 22 0 25 1 0 0 11 28 1 0 19 0 30 2 0
                                         6 0 0 1 2 0 6 0 0 1 2 0 6 0 0 8 2 0 6
                                         0 0 1 2 0 6 0 0 7)))))
           '|lookupComplete|)) 

(MAKEPROP '|IndexCard| 'NILADIC T) 

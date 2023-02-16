
(SDEFUN |TYPED;var;S$;1| ((|n| (|String|)) ($ ($)))
        (CONS |n| (SPADCALL (QREFELT $ 8)))) 

(PUT '|TYPED;var;SIl$;2| '|SPADreplace| 'CONS) 

(SDEFUN |TYPED;var;SIl$;2| ((|n| (|String|)) (|t| (|ILogic|)) ($ ($)))
        (CONS |n| |t|)) 

(PUT '|TYPED;getName;$S;3| '|SPADreplace| 'QCAR) 

(SDEFUN |TYPED;getName;$S;3| ((|v| ($)) ($ (|String|))) (QCAR |v|)) 

(PUT '|TYPED;getType;$Il;4| '|SPADreplace| 'QCDR) 

(SDEFUN |TYPED;getType;$Il;4| ((|v| ($)) ($ (|ILogic|))) (QCDR |v|)) 

(SDEFUN |TYPED;toString;$S;5| ((|v| ($)) ($ (|String|)))
        (SPROG ((|s| (|String|)))
               (SEQ
                (LETT |s|
                      (SPADCALL
                       (LIST (QCAR |v|) ":"
                             (SPADCALL (QCDR |v|) (QREFELT $ 14)))
                       (QREFELT $ 16)))
                (EXIT |s|)))) 

(SDEFUN |TYPED;parseVarTerm;SNniR;6|
        ((|t1| (|String|)) (|pin| (|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((#1=#:G723 NIL) (|pt| (|NonNegativeInteger|))
          (|r|
           (|Record| (|:| |rft| (|ILogic|))
                     (|:| |pout| (|NonNegativeInteger|))))
          (|ch| (|Character|)) (|vnm| (|String|)))
         (SEQ
          (EXIT
           (SEQ (LETT |vnm| "") (LETT |pt| |pin|)
                (LETT |ch| (STR_ELT1 |t1| |pt|))
                (SEQ G190
                     (COND ((NULL (SPADCALL |ch| (QREFELT $ 20))) (GO G191)))
                     (SEQ (LETT |vnm| (SPADCALL |vnm| |ch| (QREFELT $ 21)))
                          (LETT |pt| (+ |pt| 1))
                          (COND
                           ((> |pt| (SPADCALL |t1| (QREFELT $ 23)))
                            (PROGN
                             (LETT #1#
                                   (CONS (SPADCALL |vnm| (QREFELT $ 10)) |pt|))
                             (GO #2=#:G722))))
                          (EXIT (LETT |ch| (STR_ELT1 |t1| |pt|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| ":"))
                  (SEQ (LETT |pt| (+ |pt| 1))
                       (COND
                        ((> |pt| (SPADCALL |t1| (QREFELT $ 23)))
                         (PROGN
                          (LETT #1#
                                (CONS (SPADCALL |vnm| (QREFELT $ 10)) |pt|))
                          (GO #2#))))
                       (LETT |r| (SPADCALL |t1| |pt| (QREFELT $ 26)))
                       (LETT |pt| (QCDR |r|))
                       (EXIT
                        (PROGN
                         (LETT #1#
                               (CONS (SPADCALL |vnm| (QCAR |r|) (QREFELT $ 11))
                                     |pt|))
                         (GO #2#))))))
                (EXIT (CONS (SPADCALL |vnm| (QREFELT $ 10)) |pt|))))
          #2# (EXIT #1#)))) 

(SDEFUN |TYPED;parseVar;S$;7| ((|t1| (|String|)) ($ ($)))
        (SPROG
         ((|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
         (SEQ (LETT |r| (SPADCALL |t1| 1 (QREFELT $ 27))) (EXIT (QCAR |r|))))) 

(SDEFUN |TYPED;=;2$B;8| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((EQUAL (QCAR |x|) (QCAR |y|))
          (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 29)))
         ('T NIL))) 

(SDEFUN |TYPED;coerce;$Of;9| ((|n| ($)) ($ (|OutputForm|)))
        (SPADCALL
         (LIST (SPADCALL (QCAR |n|) (QREFELT $ 32))
               (SPADCALL ":" (QREFELT $ 32))
               (SPADCALL (QCDR |n|) (QREFELT $ 33)))
         (QREFELT $ 34))) 

(DECLAIM (NOTINLINE |Typed;|)) 

(DEFUN |Typed| ()
  (SPROG NIL
         (PROG (#1=#:G732)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Typed|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Typed|
                             (LIST (CONS NIL (CONS 1 (|Typed;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Typed|)))))))))) 

(DEFUN |Typed;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Typed|))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Typed| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |nme| (|String|)) (|:| |typ| (|ILogic|))))
          $))) 

(MAKEPROP '|Typed| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|ILogic|) (0 . |logicT|)
              (|String|) |TYPED;var;S$;1| |TYPED;var;SIl$;2|
              |TYPED;getName;$S;3| |TYPED;getType;$Il;4| (4 . |toString|)
              (|List| $) (9 . |concat|) |TYPED;toString;$S;5| (|Boolean|)
              (|Character|) (14 . |alphanumeric?|) (19 . |concat|) (|Integer|)
              (25 . |maxIndex|) (|Record| (|:| |rft| $) (|:| |pout| 25))
              (|NonNegativeInteger|) (30 . |parseIL2|)
              |TYPED;parseVarTerm;SNniR;6| |TYPED;parseVar;S$;7| (36 . =)
              |TYPED;=;2$B;8| (|OutputForm|) (42 . |message|) (47 . |coerce|)
              (52 . |hconcat|) |TYPED;coerce;$Of;9|)
           '#(|var| 57 |toString| 68 |parseVarTerm| 73 |parseVar| 79 |getType|
              84 |getName| 89 |coerce| 94 = 99)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(NIL NIL NIL)
                       (CONS '#((|VarCat|) (|Type|) (|CoercibleTo| 31))
                             (|makeByteWordVec2| 35
                                                 '(0 7 0 8 1 7 9 0 14 1 9 0 15
                                                   16 1 19 18 0 20 2 9 0 0 19
                                                   21 1 9 22 0 23 2 7 24 9 25
                                                   26 2 7 18 0 0 29 1 31 0 9 32
                                                   1 7 31 0 33 1 31 0 15 34 2 0
                                                   0 9 7 11 1 0 0 9 10 1 0 9 0
                                                   17 2 0 24 9 25 27 1 0 0 9 28
                                                   1 0 7 0 13 1 0 9 0 12 1 0 31
                                                   0 35 2 0 18 0 0 30)))))
           '|lookupComplete|)) 

(MAKEPROP '|Typed| 'NILADIC T) 

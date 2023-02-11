
(PUT '|UNTYPED;var;S$;1| '|SPADreplace| 'LIST) 

(SDEFUN |UNTYPED;var;S$;1| ((|n| (|String|)) ($ ($))) (LIST |n|)) 

(PUT '|UNTYPED;var;SIl$;2| '|SPADreplace| '(XLAM (|n| |t|) (LIST |n|))) 

(SDEFUN |UNTYPED;var;SIl$;2| ((|n| (|String|)) (|t| (|ILogic|)) ($ ($)))
        (LIST |n|)) 

(PUT '|UNTYPED;getName;$S;3| '|SPADreplace| 'QCAR) 

(SDEFUN |UNTYPED;getName;$S;3| ((|v| ($)) ($ (|String|))) (QCAR |v|)) 

(SDEFUN |UNTYPED;getType;$Il;4| ((|v| ($)) ($ (|ILogic|)))
        (SPADCALL (QREFELT $ 12))) 

(PUT '|UNTYPED;toString;$S;5| '|SPADreplace| 'QCAR) 

(SDEFUN |UNTYPED;toString;$S;5| ((|v| ($)) ($ (|String|))) (QCAR |v|)) 

(SDEFUN |UNTYPED;parseVarTerm;SNniR;6|
        ((|t1| (|String|)) (|pin| (|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|pt| (|NonNegativeInteger|))
          (|r|
           (|Record| (|:| |rft| (|ILogic|))
                     (|:| |pout| (|NonNegativeInteger|))))
          (|ch| (|Character|)) (#1=#:G714 NIL) (|vnm| (|String|)))
         (SEQ
          (EXIT
           (SEQ (LETT |vnm| "") (LETT |pt| |pin|)
                (LETT |ch| (STR_ELT1 |t1| |pt|))
                (SEQ G190
                     (COND ((NULL (SPADCALL |ch| (QREFELT $ 17))) (GO G191)))
                     (SEQ (LETT |vnm| (SPADCALL |vnm| |ch| (QREFELT $ 18)))
                          (LETT |pt| (+ |pt| 1))
                          (COND
                           ((> |pt| (SPADCALL |t1| (QREFELT $ 20)))
                            (PROGN
                             (LETT #1#
                                   (CONS (SPADCALL |vnm| (QREFELT $ 8)) |pt|))
                             (GO #2=#:G713))))
                          (EXIT (LETT |ch| (STR_ELT1 |t1| |pt|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| ":"))
                  (SEQ (LETT |r| (SPADCALL |t1| |pt| (QREFELT $ 23)))
                       (EXIT (LETT |pt| (QCDR |r|))))))
                (EXIT (CONS (SPADCALL |vnm| (QREFELT $ 8)) |pt|))))
          #2# (EXIT #1#)))) 

(SDEFUN |UNTYPED;parseVar;S$;7| ((|t1| (|String|)) ($ ($)))
        (SPROG
         ((|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
         (SEQ (LETT |r| (SPADCALL |t1| 1 (QREFELT $ 24))) (EXIT (QCAR |r|))))) 

(SDEFUN |UNTYPED;=;2$B;8| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (EQUAL (QCAR |x|) (QCAR |y|))) 

(SDEFUN |UNTYPED;coerce;$Of;9| ((|n| ($)) ($ (|OutputForm|)))
        (SPADCALL (QCAR |n|) (QREFELT $ 28))) 

(DECLAIM (NOTINLINE |Untyped;|)) 

(DEFUN |Untyped| ()
  (SPROG NIL
         (PROG (#1=#:G722)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Untyped|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Untyped|
                             (LIST (CONS NIL (CONS 1 (|Untyped;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Untyped|)))))))))) 

(DEFUN |Untyped;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Untyped|))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Untyped| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|Record| (|:| |nme| (|String|))))
          $))) 

(MAKEPROP '|Untyped| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|String|) |UNTYPED;var;S$;1|
              (|ILogic|) |UNTYPED;var;SIl$;2| |UNTYPED;getName;$S;3|
              (0 . |logicT|) |UNTYPED;getType;$Il;4| |UNTYPED;toString;$S;5|
              (|Boolean|) (|Character|) (4 . |alphanumeric?|) (9 . |concat|)
              (|Integer|) (15 . |maxIndex|)
              (|Record| (|:| |rft| $) (|:| |pout| 22)) (|NonNegativeInteger|)
              (20 . |parseIL2|) |UNTYPED;parseVarTerm;SNniR;6|
              |UNTYPED;parseVar;S$;7| |UNTYPED;=;2$B;8| (|OutputForm|)
              (26 . |message|) |UNTYPED;coerce;$Of;9|)
           '#(|var| 31 |toString| 42 |parseVarTerm| 47 |parseVar| 53 |getType|
              58 |getName| 63 |coerce| 68 = 73)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(NIL NIL NIL)
                       (CONS '#((|VarCat|) (|Type|) (|CoercibleTo| 27))
                             (|makeByteWordVec2| 29
                                                 '(0 9 0 12 1 16 15 0 17 2 7 0
                                                   0 16 18 1 7 19 0 20 2 9 21 7
                                                   22 23 1 27 0 7 28 2 0 0 7 9
                                                   10 1 0 0 7 8 1 0 7 0 14 2 0
                                                   21 7 22 24 1 0 0 7 25 1 0 9
                                                   0 13 1 0 7 0 11 1 0 27 0 29
                                                   2 0 15 0 0 26)))))
           '|lookupComplete|)) 

(MAKEPROP '|Untyped| 'NILADIC T) 

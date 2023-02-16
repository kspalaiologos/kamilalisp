
(PUT '|ANY;obj;$N;1| '|SPADreplace| 'QCDR) 

(SDEFUN |ANY;obj;$N;1| ((|x| ($)) ($ (|None|))) (QCDR |x|)) 

(PUT '|ANY;dom;$Se;2| '|SPADreplace| 'QCAR) 

(SDEFUN |ANY;dom;$Se;2| ((|x| ($)) ($ (|SExpression|))) (QCAR |x|)) 

(SDEFUN |ANY;domainOf;$Of;3| ((|x| ($)) ($ (|OutputForm|)))
        (|typeToOutputForm| (QCAR |x|))) 

(SDEFUN |ANY;=;2$B;4| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((|Dx| (|Type|)) (|dy| #1=(|SExpression|)) (|dx| #1#))
               (SEQ (LETT |dx| (SPADCALL |x| (QREFELT $ 11)))
                    (LETT |dy| (SPADCALL |y| (QREFELT $ 11)))
                    (EXIT
                     (COND ((SPADCALL |dx| |dy| (QREFELT $ 15)) NIL)
                           (#2='T
                            (SEQ (LETT |Dx| (|evalType| |dx|))
                                 (EXIT
                                  (COND
                                   ((|HasCategory| |Dx| '(|BasicType|))
                                    (SPADCALL (SPADCALL |x| (QREFELT $ 9))
                                              (SPADCALL |y| (QREFELT $ 9))
                                              (|compiledLookupCheck| '=
                                                                     (LIST
                                                                      (LIST
                                                                       '|Boolean|)
                                                                      '$ '$)
                                                                     |Dx|)))
                                   (#2#
                                    (EQ (SPADCALL |x| (QREFELT $ 9))
                                        (SPADCALL |y| (QREFELT $ 9))))))))))))) 

(SDEFUN |ANY;objectOf;$Of;5| ((|x| ($)) ($ (|OutputForm|)))
        (|spad2BootCoerce| (QCDR |x|) (QCAR |x|)
                           (SPADCALL '|OutputForm| (QREFELT $ 19)))) 

(SDEFUN |ANY;showTypeInOutput;BS;6| ((|b| (|Boolean|)) ($ (|String|)))
        (SEQ (SETELT $ 7 |b|)
             (EXIT
              (COND
               (|b|
                "Type of object will be displayed in output of a member of Any")
               ('T
                "Type of object will not be displayed in output of a member of Any"))))) 

(SDEFUN |ANY;coerce;$Of;7| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|dom1| (|List| (|OutputForm|))) (|p| (|SExpression|))
          (|obj1| (|OutputForm|)))
         (SEQ (LETT |obj1| (SPADCALL |x| (QREFELT $ 20)))
              (EXIT
               (COND
                ((QREFELT $ 7)
                 (SEQ
                  (LETT |dom1|
                        (SEQ
                         (LETT |p| (|prefix2String| (|devaluate| (QCAR |x|))))
                         (EXIT
                          (COND
                           ((SPADCALL |p| (QREFELT $ 23))
                            (SPADCALL |p| (QREFELT $ 25)))
                           (#1='T |p|)))))
                  (EXIT
                   (SPADCALL
                    (CONS |obj1| (CONS (SPADCALL ":" (QREFELT $ 26)) |dom1|))
                    (QREFELT $ 28)))))
                (#1# |obj1|)))))) 

(SDEFUN |ANY;any;SeN$;8|
        ((|domain| (|SExpression|)) (|object| (|None|)) ($ ($)))
        (SEQ
         (COND ((|isValidType| |domain|) (CONS |domain| |object|))
               (#1='T
                (SEQ (LETT |domain| (|devaluate| |domain|))
                     (EXIT
                      (COND ((|isValidType| |domain|) (CONS |domain| |object|))
                            (#1#
                             (|error|
                              "function any must have a domain as first argument"))))))))) 

(DECLAIM (NOTINLINE |Any;|)) 

(DEFUN |Any| ()
  (SPROG NIL
         (PROG (#1=#:G722)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Any|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Any|
                             (LIST (CONS NIL (CONS 1 (|Any;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Any|)))))))))) 

(DEFUN |Any;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Any|))
          (LETT $ (GETREFV 33))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Any| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |dm| (|SExpression|)) (|:| |ob| (|None|))))
          (QSETREFV $ 7 NIL)
          $))) 

(MAKEPROP '|Any| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| '|printTypeInOutputP| (|None|)
              |ANY;obj;$N;1| (|SExpression|) |ANY;dom;$Se;2| (|OutputForm|)
              |ANY;domainOf;$Of;3| (|Boolean|) (0 . ~=) |ANY;=;2$B;4|
              (|Symbol|) (|List| 17) (6 . |list|) |ANY;objectOf;$Of;5|
              (|String|) |ANY;showTypeInOutput;BS;6| (11 . |atom?|) (|List| 12)
              (16 . |list|) (21 . |message|) (|List| $) (26 . |hconcat|)
              |ANY;coerce;$Of;7| |ANY;any;SeN$;8| (|SingleInteger|)
              (|HashState|))
           '#(~= 31 |showTypeInOutput| 37 |objectOf| 42 |obj| 47 |latex| 52
              |hashUpdate!| 57 |hash| 63 |domainOf| 68 |dom| 73 |coerce| 78
              |any| 83 = 89)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 12))
                        (|makeByteWordVec2| 32
                                            '(2 10 14 0 0 15 1 18 0 17 19 1 10
                                              14 0 23 1 24 0 12 25 1 12 0 21 26
                                              1 12 0 27 28 2 0 14 0 0 1 1 0 21
                                              14 22 1 0 12 0 20 1 0 8 0 9 1 0
                                              21 0 1 2 0 32 32 0 1 1 0 31 0 1 1
                                              0 12 0 13 1 0 10 0 11 1 0 12 0 29
                                              2 0 0 10 8 30 2 0 14 0 0 16)))))
           '|lookupComplete|)) 

(MAKEPROP '|Any| 'NILADIC T) 

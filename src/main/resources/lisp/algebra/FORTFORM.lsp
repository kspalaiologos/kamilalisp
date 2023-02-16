
(SDEFUN |FORTFORM;assignable_form?| ((|o| (|OutputForm|)) ($ (|Boolean|)))
        (SPROG ((|sop| (|Symbol|)) (|op| (|OutputForm|)))
               (SEQ
                (COND ((SPADCALL |o| (QREFELT $ 10)) 'T)
                      (#1='T
                       (SEQ (LETT |op| (SPADCALL |o| (QREFELT $ 11)))
                            (EXIT
                             (COND
                              ((SPADCALL |op| (QREFELT $ 12))
                               (SEQ (LETT |sop| (SPADCALL |op| (QREFELT $ 14)))
                                    (COND
                                     ((OR (EQUAL |sop| '=)
                                          (OR (EQUAL |sop| 'MATRIX)
                                              (EQUAL |sop| '|construct|)))
                                      (EXIT NIL)))
                                    (EXIT 'T)))
                              (#1# 'T))))))))) 

(SDEFUN |FORTFORM;convert;OfI$;2|
        ((|o| (|OutputForm|)) (|i| (|Integer|)) ($ ($)))
        (SPROG ((|var| ($)))
               (SEQ
                (COND ((NULL (|FORTFORM;assignable_form?| |o| $)) |o|)
                      ('T
                       (SEQ
                        (LETT |var|
                              (SPADCALL
                               (SPADCALL (STRCONC "R" (STRINGIMAGE |i|))
                                         (QREFELT $ 16))
                               (QREFELT $ 17)))
                        (EXIT
                         (SPADCALL (SPADCALL '= (QREFELT $ 18))
                                   (LIST |var| |o|) (QREFELT $ 20))))))))) 

(SDEFUN |FORTFORM;display;$V;3| ((|x| ($)) ($ (|Void|)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 25)) (QREFELT $ 26))
                  (QREFELT $ 28))) 

(DECLAIM (NOTINLINE |FortranFormat;|)) 

(DEFUN |FortranFormat| ()
  (SPROG NIL
         (PROG (#1=#:G719)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FortranFormat|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FortranFormat|
                             (LIST (CONS NIL (CONS 1 (|FortranFormat;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|FortranFormat|)))))))))) 

(DEFUN |FortranFormat;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FortranFormat|))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FortranFormat| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|OutputForm|))
          $))) 

(MAKEPROP '|FortranFormat| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Boolean|) (|OutputForm|)
              (|OutputFormTools|) (0 . |atom?|) (5 . |operator|)
              (10 . |symbol?|) (|Symbol|) (15 . |symbol|) (|String|)
              (20 . |coerce|) (25 . |coerce|) (30 . |outputForm|) (|List| $)
              (35 . |elt|) (|Integer|) |FORTFORM;convert;OfI$;2| (|List| 15)
              (|FortranCodeTools|) (41 . |expression2Fortran|)
              (46 . |fort_clean_lines|) (|Void|) (51 . |displayLines|)
              |FORTFORM;display;$V;3|)
           '#(|display| 56 |convert| 61) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|OutputFormatterCategory|))
                             (|makeByteWordVec2| 29
                                                 '(1 9 7 8 10 1 9 8 8 11 1 9 7
                                                   8 12 1 9 13 8 14 1 13 0 15
                                                   16 1 13 8 0 17 1 6 0 13 18 2
                                                   6 0 0 19 20 1 24 23 8 25 1
                                                   24 23 23 26 1 24 27 23 28 1
                                                   0 27 0 29 2 0 0 8 21 22)))))
           '|lookupComplete|)) 

(MAKEPROP '|FortranFormat| 'NILADIC T) 

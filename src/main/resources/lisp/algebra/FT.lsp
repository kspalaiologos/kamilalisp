
(SDEFUN |FT;coerce;$Of;1| ((|a| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G715 NIL) (|u| NIL) (#2=#:G714 NIL) (|t| (|OutputForm|)))
               (SEQ
                (COND
                 ((SPADCALL |a| (QREFELT $ 8))
                  (COND
                   ((QEQCAR (SPADCALL |a| (QREFELT $ 10)) 1)
                    (LETT |t| (SPADCALL "EXTERNAL" (QREFELT $ 13))))
                   (#3='T
                    (LETT |t|
                          (SPADCALL
                           (LIST (SPADCALL "EXTERNAL" (QREFELT $ 13))
                                 (SPADCALL (SPADCALL |a| (QREFELT $ 10))
                                           (QREFELT $ 14)))
                           (QREFELT $ 16))))))
                 (#3#
                  (LETT |t|
                        (SPADCALL (SPADCALL |a| (QREFELT $ 10))
                                  (QREFELT $ 14)))))
                (EXIT
                 (COND ((NULL (SPADCALL |a| (QREFELT $ 18))) |t|)
                       (#3#
                        (SPADCALL |t|
                                  (SPADCALL
                                   (PROGN
                                    (LETT #2# NIL)
                                    (SEQ (LETT |u| NIL)
                                         (LETT #1#
                                               (SPADCALL |a| (QREFELT $ 18)))
                                         G190
                                         (COND
                                          ((OR (ATOM #1#)
                                               (PROGN
                                                (LETT |u| (CAR #1#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #2#
                                                 (CONS
                                                  (SPADCALL |u| (QREFELT $ 20))
                                                  #2#))))
                                         (LETT #1# (CDR #1#)) (GO G190) G191
                                         (EXIT (NREVERSE #2#))))
                                   (QREFELT $ 21))
                                  (QREFELT $ 22)))))))) 

(PUT '|FT;scalarTypeOf;$U;2| '|SPADreplace| '(XLAM (|u|) (QVELT |u| 0))) 

(SDEFUN |FT;scalarTypeOf;$U;2|
        ((|u| ($))
         ($ (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| "void"))))
        (QVELT |u| 0)) 

(PUT '|FT;dimensionsOf;$L;3| '|SPADreplace| '(XLAM (|u|) (QVELT |u| 1))) 

(SDEFUN |FT;dimensionsOf;$L;3|
        ((|u| ($)) ($ (|List| (|Polynomial| (|Integer|))))) (QVELT |u| 1)) 

(PUT '|FT;external?;$B;4| '|SPADreplace| '(XLAM (|u|) (QVELT |u| 2))) 

(SDEFUN |FT;external?;$B;4| ((|u| ($)) ($ (|Boolean|))) (QVELT |u| 2)) 

(SDEFUN |FT;construct;ULB$;5|
        ((|t| (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| "void")))
         (|d| (|List| (|Symbol|))) (|e| (|Boolean|)) ($ ($)))
        (SPROG ((#1=#:G729 NIL) (|l| NIL) (#2=#:G728 NIL))
               (SEQ
                (COND
                 (|e|
                  (COND
                   ((NULL (NULL |d|))
                    (EXIT
                     (|error| "EXTERNAL objects cannot have dimensions"))))))
                (COND
                 ((NULL |e|)
                  (COND
                   ((QEQCAR |t| 1)
                    (EXIT (|error| "VOID objects must be EXTERNAL"))))))
                (EXIT
                 (VECTOR |t|
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |l| NIL) (LETT #1# |d|) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |l| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS (SPADCALL |l| (QREFELT $ 25))
                                             #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         |e|))))) 

(SDEFUN |FT;construct;ULB$;6|
        ((|t| (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| "void")))
         (|d| (|List| (|Polynomial| (|Integer|)))) (|e| (|Boolean|)) ($ ($)))
        (SEQ
         (COND
          (|e|
           (COND
            ((NULL (NULL |d|))
             (EXIT (|error| "EXTERNAL objects cannot have dimensions"))))))
         (COND
          ((NULL |e|)
           (COND
            ((QEQCAR |t| 1)
             (EXIT (|error| "VOID objects must be EXTERNAL"))))))
         (EXIT (VECTOR |t| |d| |e|)))) 

(SDEFUN |FT;coerce;Fst$;7| ((|u| (|FortranScalarType|)) ($ ($)))
        (SPADCALL (CONS 0 |u|) NIL NIL (QREFELT $ 28))) 

(SDEFUN |FT;fortranReal;$;8| (($ ($)))
        (SPADCALL (SPADCALL "real" (QREFELT $ 31)) (QREFELT $ 30))) 

(SDEFUN |FT;fortranDouble;$;9| (($ ($)))
        (SPADCALL (SPADCALL "double precision" (QREFELT $ 31)) (QREFELT $ 30))) 

(SDEFUN |FT;fortranInteger;$;10| (($ ($)))
        (SPADCALL (SPADCALL "integer" (QREFELT $ 31)) (QREFELT $ 30))) 

(SDEFUN |FT;fortranComplex;$;11| (($ ($)))
        (SPADCALL (SPADCALL "complex" (QREFELT $ 31)) (QREFELT $ 30))) 

(SDEFUN |FT;fortranDoubleComplex;$;12| (($ ($)))
        (SPADCALL (SPADCALL "double complex" (QREFELT $ 31)) (QREFELT $ 30))) 

(SDEFUN |FT;fortranCharacter;$;13| (($ ($)))
        (SPADCALL (SPADCALL "character" (QREFELT $ 31)) (QREFELT $ 30))) 

(SDEFUN |FT;fortranLogical;$;14| (($ ($)))
        (SPADCALL (SPADCALL "logical" (QREFELT $ 31)) (QREFELT $ 30))) 

(DECLAIM (NOTINLINE |FortranType;|)) 

(DEFUN |FortranType| ()
  (SPROG NIL
         (PROG (#1=#:G755)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FortranType|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FortranType|
                             (LIST (CONS NIL (CONS 1 (|FortranType;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|FortranType|)))))))))) 

(DEFUN |FortranType;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FortranType|))
          (LETT $ (GETREFV 41))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FortranType| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record|
                     (|:| |type|
                          (|Union| (|:| |fst| (|FortranScalarType|))
                                   (|:| |void| "void")))
                     (|:| |dimensions| (|List| (|Polynomial| (|Integer|))))
                     (|:| |external| (|Boolean|))))
          $))) 

(MAKEPROP '|FortranType| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Boolean|) |FT;external?;$B;4|
              (|Union| (|:| |fst| 29) (|:| |void| '"void"))
              |FT;scalarTypeOf;$U;2| (|String|) (|OutputForm|) (0 . |message|)
              (5 . |coerce|) (|List| $) (10 . |blankSeparate|) (|List| 19)
              |FT;dimensionsOf;$L;3| (|Polynomial| (|Integer|)) (15 . |coerce|)
              (20 . |paren|) (25 . |sub|) |FT;coerce;$Of;1| (|Symbol|)
              (31 . |coerce|) (|List| 24) |FT;construct;ULB$;5|
              |FT;construct;ULB$;6| (|FortranScalarType|) |FT;coerce;Fst$;7|
              (36 . |coerce|) |FT;fortranReal;$;8| |FT;fortranDouble;$;9|
              |FT;fortranInteger;$;10| |FT;fortranComplex;$;11|
              |FT;fortranDoubleComplex;$;12| |FT;fortranCharacter;$;13|
              |FT;fortranLogical;$;14| (|SingleInteger|) (|HashState|))
           '#(~= 41 |scalarTypeOf| 47 |latex| 52 |hashUpdate!| 57 |hash| 63
              |fortranReal| 68 |fortranLogical| 72 |fortranInteger| 76
              |fortranDoubleComplex| 80 |fortranDouble| 84 |fortranComplex| 88
              |fortranCharacter| 92 |external?| 96 |dimensionsOf| 101
              |construct| 106 |coerce| 120 = 130)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 12))
                        (|makeByteWordVec2| 40
                                            '(1 12 0 11 13 1 9 12 0 14 1 12 0
                                              15 16 1 19 12 0 20 1 12 0 15 21 2
                                              12 0 0 0 22 1 19 0 24 25 1 29 0
                                              11 31 2 0 7 0 0 1 1 0 9 0 10 1 0
                                              11 0 1 2 0 40 40 0 1 1 0 39 0 1 0
                                              0 0 32 0 0 0 38 0 0 0 34 0 0 0 36
                                              0 0 0 33 0 0 0 35 0 0 0 37 1 0 7
                                              0 8 1 0 17 0 18 3 0 0 9 26 7 27 3
                                              0 0 9 17 7 28 1 0 0 29 30 1 0 12
                                              0 23 2 0 7 0 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|FortranType| 'NILADIC T) 

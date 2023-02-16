
(PUT '|SFORT;fortran;SFstFS$;1| '|SPADreplace| 'VECTOR) 

(SDEFUN |SFORT;fortran;SFstFS$;1|
        ((|fname| (|Symbol|)) (|ftype| (|FortranScalarType|)) (|res| (FS))
         ($ ($)))
        (VECTOR |fname| |ftype| |res|)) 

(PUT '|SFORT;nameOf| '|SPADreplace| '(XLAM (|u|) (QVELT |u| 0))) 

(SDEFUN |SFORT;nameOf| ((|u| ($)) ($ (|Symbol|))) (QVELT |u| 0)) 

(SDEFUN |SFORT;typeOf| ((|u| ($)) ($ (|Union| (|FortranScalarType|) "void")))
        (CONS 0 (QVELT |u| 1))) 

(PUT '|SFORT;bodyOf| '|SPADreplace| '(XLAM (|u|) (QVELT |u| 2))) 

(SDEFUN |SFORT;bodyOf| ((|u| ($)) ($ (FS))) (QVELT |u| 2)) 

(SDEFUN |SFORT;argumentsOf| ((|u| ($)) ($ (|List| (|Symbol|))))
        (SPADCALL (|SFORT;bodyOf| |u| $) (QREFELT $ 13))) 

(SDEFUN |SFORT;coerce;$Of;6| ((|u| ($)) ($ (|OutputForm|)))
        (SPADCALL (|SFORT;nameOf| |u| $) (QREFELT $ 15))) 

(SDEFUN |SFORT;outputAsFortran;$V;7| ((|u| ($)) ($ (|Void|)))
        (SPROG
         ((|val| (|OutputForm|)) (|nargs| (|List| (|OutputForm|)))
          (#1=#:G721 NIL) (|arg| NIL) (#2=#:G720 NIL)
          (|args| (|List| (|Symbol|))) (|fname| (|Symbol|))
          (|ftype_s| (|String|)) (|ftype| (|FortranScalarType|)))
         (SEQ (LETT |ftype| (QVELT |u| 1))
              (LETT |ftype_s|
                    (SPADCALL (SPADCALL |ftype| (QREFELT $ 18))
                              (QREFELT $ 20)))
              (LETT |fname| (|SFORT;nameOf| |u| $))
              (LETT |args| (|SFORT;argumentsOf| |u| $))
              (LETT |nargs|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |arg| NIL) (LETT #1# |args|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |arg| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |arg| (QREFELT $ 15)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (LETT |val| (SPADCALL (|SFORT;bodyOf| |u| $) (QREFELT $ 21)))
              (SPADCALL |fname| (CONS 0 |ftype|) |args| (QREFELT $ 24))
              (SPADCALL |ftype_s| |nargs| (QREFELT $ 26))
              (|dispfortexp1|
               (LIST (SPADCALL "=" (QREFELT $ 27))
                     (SPADCALL |fname| (QREFELT $ 15)) |val|))
              (|dispfortexp1| "RETURN") (|dispfortexp1| "END")
              (EXIT (SPADCALL (QREFELT $ 28)))))) 

(DECLAIM (NOTINLINE |SimpleFortranProgram;|)) 

(DEFUN |SimpleFortranProgram| (&REST #1=#:G722)
  (SPROG NIL
         (PROG (#2=#:G723)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SimpleFortranProgram|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SimpleFortranProgram;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|SimpleFortranProgram|)))))))))) 

(DEFUN |SimpleFortranProgram;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|SimpleFortranProgram| DV$1 DV$2))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SimpleFortranProgram|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8
                    (|Record| (|:| |name| (|Symbol|))
                              (|:| |type| (|FortranScalarType|))
                              (|:| |body| |#2|)))
          $))) 

(MAKEPROP '|SimpleFortranProgram| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|Symbol|) (|FortranScalarType|) |SFORT;fortran;SFstFS$;1|
              (|List| 9) (0 . |variables|) (|OutputForm|) (5 . |coerce|)
              |SFORT;coerce;$Of;6| (|String|) (10 . |coerce|)
              (|FortranCodeTools|) (15 . |checkType|) (20 . |coerce|) (|Void|)
              (|Union| (|:| |fst| 10) (|:| |void| '"void"))
              (25 . |fortFormatHead|) (|List| 14) (32 . |fort_format_types|)
              (38 . |coerce|) (43 . |void|) |SFORT;outputAsFortran;$V;7|)
           '#(|outputAsFortran| 47 |fortran| 52 |coerce| 59) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(NIL NIL NIL)
                       (CONS
                        '#((|FortranProgramCategory|) (|Type|)
                           (|CoercibleTo| 14))
                        (|makeByteWordVec2| 29
                                            '(1 7 12 0 13 1 9 14 0 15 1 10 17 0
                                              18 1 19 17 17 20 1 7 14 0 21 3 19
                                              22 9 23 12 24 2 19 22 17 25 26 1
                                              17 14 0 27 0 22 0 28 1 0 22 0 29
                                              3 0 0 9 10 7 11 1 0 14 0 16)))))
           '|lookupComplete|)) 

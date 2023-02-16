
(SDEFUN |SYMS;newEntry| (($ (|Entry|)))
        (VECTOR (SPADCALL (QREFELT $ 12)) (CONS 1 "void") NIL)) 

(SDEFUN |SYMS;checkIfEntryExists|
        ((|name| (|Symbol|)) (|tab| ($)) ($ (|Void|)))
        (SEQ
         (COND
          ((SPADCALL |name| |tab| (QREFELT $ 15)) (SPADCALL (QREFELT $ 17)))
          ('T
           (SEQ (SPADCALL |tab| |name| (|SYMS;newEntry| $) (QREFELT $ 18))
                (EXIT (SPADCALL (QREFELT $ 17)))))))) 

(SDEFUN |SYMS;returnTypeOf;S$U;3|
        ((|name| (|Symbol|)) (|tab| ($))
         ($ (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| "void"))))
        (QVELT (SPADCALL |tab| |name| (QREFELT $ 19)) 1)) 

(SDEFUN |SYMS;argumentListOf;S$L;4|
        ((|name| (|Symbol|)) (|tab| ($)) ($ (|List| (|Symbol|))))
        (QVELT (SPADCALL |tab| |name| (QREFELT $ 19)) 2)) 

(SDEFUN |SYMS;symbolTableOf;S$St;5|
        ((|name| (|Symbol|)) (|tab| ($)) ($ (|SymbolTable|)))
        (QVELT (SPADCALL |tab| |name| (QREFELT $ 19)) 0)) 

(SDEFUN |SYMS;coerce;$Of;6| ((|u| ($)) ($ (|OutputForm|)))
        (SPADCALL |u| (QREFELT $ 26))) 

(SDEFUN |SYMS;showTheSymbolTable;$;7| (($ ($))) (QREFELT $ 9)) 

(SDEFUN |SYMS;clearTheSymbolTable;V;8| (($ (|Void|)))
        (SEQ (SETELT $ 9 (SPADCALL (QREFELT $ 8)))
             (EXIT (SPADCALL (QREFELT $ 17))))) 

(SDEFUN |SYMS;clearTheSymbolTable;SV;9| ((|u| (|Symbol|)) ($ (|Void|)))
        (SEQ (SPADCALL |u| (QREFELT $ 9) (QREFELT $ 31))
             (EXIT (SPADCALL (QREFELT $ 17))))) 

(SDEFUN |SYMS;empty;$;10| (($ ($))) (SPADCALL (QREFELT $ 8))) 

(SDEFUN |SYMS;currentSubProgram;S;11| (($ (|Symbol|))) (QREFELT $ 10)) 

(SDEFUN |SYMS;endSubProgram;S;12| (($ (|Symbol|))) (SETELT $ 10 'MAIN)) 

(SDEFUN |SYMS;newSubProgram;SV;13| ((|u| (|Symbol|)) ($ (|Void|)))
        (SEQ (SPADCALL (QREFELT $ 9) |u| (|SYMS;newEntry| $) (QREFELT $ 18))
             (SETELT $ 10 |u|) (EXIT (SPADCALL (QREFELT $ 17))))) 

(SDEFUN |SYMS;argumentList!;SL$V;14|
        ((|u| (|Symbol|)) (|args| (|List| (|Symbol|))) (|symbols| ($))
         ($ (|Void|)))
        (SEQ (|SYMS;checkIfEntryExists| |u| |symbols| $)
             (EXIT
              (QSETVELT (SPADCALL |symbols| |u| (QREFELT $ 19)) 2 |args|)))) 

(SDEFUN |SYMS;argumentList!;SLV;15|
        ((|u| (|Symbol|)) (|args| (|List| (|Symbol|))) ($ (|Void|)))
        (SPADCALL |u| |args| (QREFELT $ 9) (QREFELT $ 37))) 

(SDEFUN |SYMS;argumentList!;LV;16| ((|args| (|List| (|Symbol|))) ($ (|Void|)))
        (SEQ (|SYMS;checkIfEntryExists| (QREFELT $ 10) (QREFELT $ 9) $)
             (EXIT
              (QSETVELT (SPADCALL (QREFELT $ 9) (QREFELT $ 10) (QREFELT $ 19))
                        2 |args|)))) 

(SDEFUN |SYMS;returnType!;SU$V;17|
        ((|u| (|Symbol|))
         (|type|
          (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| "void")))
         (|symbols| ($)) ($ (|Void|)))
        (SEQ (|SYMS;checkIfEntryExists| |u| |symbols| $)
             (EXIT
              (QSETVELT (SPADCALL |symbols| |u| (QREFELT $ 19)) 1 |type|)))) 

(SDEFUN |SYMS;returnType!;SUV;18|
        ((|u| (|Symbol|))
         (|type|
          (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| "void")))
         ($ (|Void|)))
        (SPADCALL |u| |type| (QREFELT $ 9) (QREFELT $ 40))) 

(SDEFUN |SYMS;returnType!;UV;19|
        ((|type|
          (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| "void")))
         ($ (|Void|)))
        (SEQ (|SYMS;checkIfEntryExists| (QREFELT $ 10) (QREFELT $ 9) $)
             (EXIT
              (QSETVELT (SPADCALL (QREFELT $ 9) (QREFELT $ 10) (QREFELT $ 19))
                        1 |type|)))) 

(SDEFUN |SYMS;declare!;S2Ft;20|
        ((|u| (|Symbol|)) (|type| (|FortranType|)) ($ (|FortranType|)))
        (SPADCALL |u| |type| (QREFELT $ 10) (QREFELT $ 9) (QREFELT $ 44))) 

(SDEFUN |SYMS;declare!;SFtS$Ft;21|
        ((|u| (|Symbol|)) (|type| (|FortranType|)) (|asp| (|Symbol|))
         (|symbols| ($)) ($ (|FortranType|)))
        (SEQ (|SYMS;checkIfEntryExists| |asp| |symbols| $)
             (EXIT
              (SPADCALL |u| |type|
                        (QVELT (SPADCALL |symbols| |asp| (QREFELT $ 19)) 0)
                        (QREFELT $ 46))))) 

(SDEFUN |SYMS;declare!;LFtS$Ft;22|
        ((|u| (|List| (|Symbol|))) (|type| (|FortranType|)) (|asp| (|Symbol|))
         (|syms| ($)) ($ (|FortranType|)))
        (SEQ (|SYMS;checkIfEntryExists| |asp| |syms| $)
             (EXIT
              (SPADCALL |u| |type|
                        (QVELT (SPADCALL |syms| |asp| (QREFELT $ 19)) 0)
                        (QREFELT $ 47))))) 

(SDEFUN |SYMS;declare!;SFtSFt;23|
        ((|u| (|Symbol|)) (|type| (|FortranType|)) (|asp| (|Symbol|))
         ($ (|FortranType|)))
        (SEQ (|SYMS;checkIfEntryExists| |asp| (QREFELT $ 9) $)
             (EXIT
              (SPADCALL |u| |type|
                        (QVELT (SPADCALL (QREFELT $ 9) |asp| (QREFELT $ 19)) 0)
                        (QREFELT $ 46))))) 

(SDEFUN |SYMS;printHeader;S$V;24|
        ((|u| (|Symbol|)) (|symbols| ($)) ($ (|Void|)))
        (SPROG ((|entry| (|Entry|)))
               (SEQ (LETT |entry| (SPADCALL |symbols| |u| (QREFELT $ 19)))
                    (SPADCALL |u| (QVELT |entry| 1) (QVELT |entry| 2)
                              (QREFELT $ 51))
                    (EXIT (SPADCALL (QVELT |entry| 0) (QREFELT $ 52)))))) 

(SDEFUN |SYMS;printHeader;SV;25| ((|u| (|Symbol|)) ($ (|Void|)))
        (SPADCALL |u| (QREFELT $ 9) (QREFELT $ 53))) 

(SDEFUN |SYMS;printHeader;V;26| (($ (|Void|)))
        (SPADCALL (QREFELT $ 10) (QREFELT $ 9) (QREFELT $ 53))) 

(SDEFUN |SYMS;printTypes;SV;27| ((|u| (|Symbol|)) ($ (|Void|)))
        (SPADCALL (QVELT (SPADCALL (QREFELT $ 9) |u| (QREFELT $ 19)) 0)
                  (QREFELT $ 52))) 

(DECLAIM (NOTINLINE |TheSymbolTable;|)) 

(DEFUN |TheSymbolTable| ()
  (SPROG NIL
         (PROG (#1=#:G753)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|TheSymbolTable|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|TheSymbolTable|
                             (LIST (CONS NIL (CONS 1 (|TheSymbolTable;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|TheSymbolTable|)))))))))) 

(DEFUN |TheSymbolTable;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|TheSymbolTable|))
          (LETT $ (GETREFV 57))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TheSymbolTable| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |symtab| (|SymbolTable|))
                              (|:| |returnType|
                                   (|Union| (|:| |fst| (|FortranScalarType|))
                                            (|:| |void| "void")))
                              (|:| |argList| (|List| (|Symbol|)))))
          (QSETREFV $ 7 (|Table| (|Symbol|) (QREFELT $ 6)))
          (QSETREFV $ 9 (SPADCALL (QREFELT $ 8)))
          (QSETREFV $ 10 'MAIN)
          $))) 

(MAKEPROP '|TheSymbolTable| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Entry| '|Rep| (0 . |empty|)
              '|theSymbolTable| '|currentSubProgramName| (|SymbolTable|)
              (4 . |empty|) (|Boolean|) (|Symbol|) (8 . |key?|) (|Void|)
              (14 . |void|) (18 . |setelt!|) (25 . |elt|)
              (|Union| (|:| |fst| (|FortranScalarType|)) (|:| |void| '"void"))
              |SYMS;returnTypeOf;S$U;3| (|List| 14) |SYMS;argumentListOf;S$L;4|
              |SYMS;symbolTableOf;S$St;5| (|OutputForm|) (31 . |coerce|)
              |SYMS;coerce;$Of;6| |SYMS;showTheSymbolTable;$;7|
              |SYMS;clearTheSymbolTable;V;8| (|Union| 6 '"failed")
              (36 . |remove!|) |SYMS;clearTheSymbolTable;SV;9|
              |SYMS;empty;$;10| |SYMS;currentSubProgram;S;11|
              |SYMS;endSubProgram;S;12| |SYMS;newSubProgram;SV;13|
              |SYMS;argumentList!;SL$V;14| |SYMS;argumentList!;SLV;15|
              |SYMS;argumentList!;LV;16| |SYMS;returnType!;SU$V;17|
              |SYMS;returnType!;SUV;18| |SYMS;returnType!;UV;19|
              (|FortranType|) |SYMS;declare!;SFtS$Ft;21|
              |SYMS;declare!;S2Ft;20| (42 . |declare!|) (49 . |declare!|)
              |SYMS;declare!;LFtS$Ft;22| |SYMS;declare!;SFtSFt;23|
              (|FortranCodeTools|) (56 . |fortFormatHead|) (63 . |printTypes|)
              |SYMS;printHeader;S$V;24| |SYMS;printHeader;SV;25|
              |SYMS;printHeader;V;26| |SYMS;printTypes;SV;27|)
           '#(|symbolTableOf| 68 |showTheSymbolTable| 74 |returnTypeOf| 78
              |returnType!| 84 |printTypes| 102 |printHeader| 107
              |newSubProgram| 122 |endSubProgram| 127 |empty| 131 |declare!|
              135 |currentSubProgram| 164 |coerce| 168 |clearTheSymbolTable|
              173 |argumentListOf| 182 |argumentList!| 188)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|CoercibleTo| 25))
                             (|makeByteWordVec2| 56
                                                 '(0 7 0 8 0 11 0 12 2 7 13 14
                                                   0 15 0 16 0 17 3 7 6 0 14 6
                                                   18 2 7 6 0 14 19 1 7 25 0 26
                                                   2 7 30 14 0 31 3 11 43 14 43
                                                   0 46 3 11 43 22 43 0 47 3 50
                                                   16 14 20 22 51 1 11 16 0 52
                                                   2 0 11 14 0 24 0 0 0 28 2 0
                                                   20 14 0 21 1 0 16 20 42 2 0
                                                   16 14 20 41 3 0 16 14 20 0
                                                   40 1 0 16 14 56 0 0 16 55 1
                                                   0 16 14 54 2 0 16 14 0 53 1
                                                   0 16 14 36 0 0 14 35 0 0 0
                                                   33 3 0 43 14 43 14 49 2 0 43
                                                   14 43 45 4 0 43 14 43 14 0
                                                   44 4 0 43 22 43 14 0 48 0 0
                                                   14 34 1 0 25 0 27 0 0 16 29
                                                   1 0 16 14 32 2 0 22 14 0 23
                                                   1 0 16 22 39 2 0 16 14 22 38
                                                   3 0 16 14 22 0 37)))))
           '|lookupComplete|)) 

(MAKEPROP '|TheSymbolTable| 'NILADIC T) 

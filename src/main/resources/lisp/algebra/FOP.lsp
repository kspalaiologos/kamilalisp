
(PUT '|FOP;topFortranOutputStack;S;1| '|SPADreplace|
     '(XLAM NIL (STRINGIMAGE |$fortranOutputFile|))) 

(SDEFUN |FOP;topFortranOutputStack;S;1| (($ (|String|)))
        (STRINGIMAGE |$fortranOutputFile|)) 

(SDEFUN |FOP;pushFortranOutputStack;FnV;2| ((|fn| (|FileName|)) ($ (|Void|)))
        (SPADCALL (SPADCALL |fn| (QREFELT $ 12)) (QREFELT $ 14))) 

(SDEFUN |FOP;pushFortranOutputStack;SV;3| ((|fn| (|String|)) ($ (|Void|)))
        (SEQ
         (COND
          ((SPADCALL (QREFELT $ 8) (QREFELT $ 17))
           (SPADCALL (STRINGIMAGE |$fortranOutputFile|) (QREFELT $ 8)
                     (QREFELT $ 18)))
          ((NULL
            (EQUAL (SPADCALL (QREFELT $ 8) (QREFELT $ 19))
                   (STRINGIMAGE |$fortranOutputFile|)))
           (SEQ (SPADCALL (QREFELT $ 8) (QREFELT $ 20))
                (EXIT
                 (SPADCALL (STRINGIMAGE |$fortranOutputFile|) (QREFELT $ 8)
                           (QREFELT $ 18))))))
         (SPADCALL |fn| (QREFELT $ 8) (QREFELT $ 18))
         (SPADCALL
          (SPADCALL (LIST "set output fortran quiet " |fn|) (QREFELT $ 22))
          (QREFELT $ 24))
         (EXIT (SPADCALL (QREFELT $ 25))))) 

(SDEFUN |FOP;popFortranOutputStack;V;4| (($ (|Void|)))
        (SEQ
         (COND
          ((NULL (SPADCALL (QREFELT $ 8) (QREFELT $ 17)))
           (SPADCALL (QREFELT $ 8) (QREFELT $ 20))))
         (COND
          ((SPADCALL (QREFELT $ 8) (QREFELT $ 17))
           (SPADCALL "CONSOLE" (QREFELT $ 8) (QREFELT $ 18))))
         (SPADCALL
          (SPADCALL
           (LIST "set output fortran quiet append "
                 (SPADCALL (QREFELT $ 8) (QREFELT $ 19)))
           (QREFELT $ 22))
          (QREFELT $ 24))
         (EXIT (SPADCALL (QREFELT $ 25))))) 

(SDEFUN |FOP;clearFortranOutputStack;S;5| (($ (|Stack| (|String|))))
        (SETELT $ 8 (SPADCALL (QREFELT $ 7)))) 

(SDEFUN |FOP;showFortranOutputStack;S;6| (($ (|Stack| (|String|))))
        (QREFELT $ 8)) 

(DECLAIM (NOTINLINE |FortranOutputStackPackage;|)) 

(DEFUN |FortranOutputStackPackage| ()
  (SPROG NIL
         (PROG (#1=#:G716)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|FortranOutputStackPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FortranOutputStackPackage|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|FortranOutputStackPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|FortranOutputStackPackage|)))))))))) 

(DEFUN |FortranOutputStackPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FortranOutputStackPackage|))
          (LETT $ (GETREFV 29))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FortranOutputStackPackage| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (SPADCALL (QREFELT $ 7)))
          $))) 

(MAKEPROP '|FortranOutputStackPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Stack| 9) (0 . |empty|)
              '|fortranOutputStack| (|String|) |FOP;topFortranOutputStack;S;1|
              (|FileName|) (4 . |coerce|) (|Void|)
              |FOP;pushFortranOutputStack;SV;3|
              |FOP;pushFortranOutputStack;FnV;2| (|Boolean|) (9 . |empty?|)
              (14 . |push!|) (20 . |top|) (25 . |pop!|) (|List| $)
              (30 . |concat|) (|MoreSystemCommands|) (35 . |systemCommand|)
              (40 . |void|) |FOP;popFortranOutputStack;V;4|
              |FOP;clearFortranOutputStack;S;5|
              |FOP;showFortranOutputStack;S;6|)
           '#(|topFortranOutputStack| 44 |showFortranOutputStack| 48
              |pushFortranOutputStack| 52 |popFortranOutputStack| 62
              |clearFortranOutputStack| 66)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|clearFortranOutputStack|
                                 ((|Stack| (|String|))))
                                T)
                              '((|showFortranOutputStack|
                                 ((|Stack| (|String|))))
                                T)
                              '((|popFortranOutputStack| ((|Void|))) T)
                              '((|pushFortranOutputStack|
                                 ((|Void|) (|FileName|)))
                                T)
                              '((|pushFortranOutputStack|
                                 ((|Void|) (|String|)))
                                T)
                              '((|topFortranOutputStack| ((|String|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 28
                                            '(0 6 0 7 1 11 9 0 12 1 6 16 0 17 2
                                              6 9 9 0 18 1 6 9 0 19 1 6 9 0 20
                                              1 9 0 21 22 1 23 13 9 24 0 13 0
                                              25 0 0 9 10 0 0 6 28 1 0 13 11 15
                                              1 0 13 9 14 0 0 13 26 0 0 6
                                              27)))))
           '|lookupComplete|)) 

(MAKEPROP '|FortranOutputStackPackage| 'NILADIC T) 

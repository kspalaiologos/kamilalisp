
(SDEFUN |OMPKG;OMunhandledSymbol;2SE;1|
        ((|u| (|String|)) (|v| (|String|)) ($ (|Exit|)))
        (|error|
         (SPADCALL
          (LIST "FriCAS is unable to process the symbol " |u| " from CD " |v|
                ".")
          (QREFELT $ 8)))) 

(SDEFUN |OMPKG;OMread;OmdA;2| ((|dev| (|OpenMathDevice|)) ($ (|Any|)))
        (SPADCALL (OM-READ |dev|) (QREFELT $ 13))) 

(SDEFUN |OMPKG;OMreadFile;SA;3| ((|filename| (|String|)) ($ (|Any|)))
        (SPROG ((|res| (|Any|)) (|dev| (|OpenMathDevice|)))
               (SEQ
                (LETT |dev|
                      (SPADCALL |filename| "r" (SPADCALL (QREFELT $ 17))
                                (QREFELT $ 18)))
                (LETT |res| (SPADCALL (OM-READ |dev|) (QREFELT $ 13)))
                (SPADCALL |dev| (QREFELT $ 20)) (EXIT |res|)))) 

(SDEFUN |OMPKG;OMreadStr;SA;4| ((|str| (|String|)) ($ (|Any|)))
        (SPROG ((|res| (|Any|)) (|dev| (|OpenMathDevice|)) (|strp| (|None|)))
               (SEQ (LETT |strp| (OM-STRINGTOSTRINGPTR |str|))
                    (LETT |dev|
                          (SPADCALL |strp| (SPADCALL (QREFELT $ 17))
                                    (QREFELT $ 22)))
                    (LETT |res| (SPADCALL (OM-READ |dev|) (QREFELT $ 13)))
                    (SPADCALL |dev| (QREFELT $ 20)) (EXIT |res|)))) 

(PUT '|OMPKG;OMlistCDs;L;5| '|SPADreplace| 'OM-LISTCDS) 

(SDEFUN |OMPKG;OMlistCDs;L;5| (($ (|List| (|String|)))) (OM-LISTCDS)) 

(PUT '|OMPKG;OMlistSymbols;SL;6| '|SPADreplace| 'OM-LISTSYMBOLS) 

(SDEFUN |OMPKG;OMlistSymbols;SL;6| ((|cd| (|String|)) ($ (|List| (|String|))))
        (OM-LISTSYMBOLS |cd|)) 

(SDEFUN |OMPKG;OMsupportsCD?;SB;7| ((|cd| (|String|)) ($ (|Boolean|)))
        (NULL (SPADCALL (OM-SUPPORTSCD |cd|) (QREFELT $ 29)))) 

(SDEFUN |OMPKG;OMsupportsSymbol?;2SB;8|
        ((|cd| (|String|)) (|name| (|String|)) ($ (|Boolean|)))
        (NULL (SPADCALL (OM-SUPPORTSSYMBOL |cd| |name|) (QREFELT $ 29)))) 

(DECLAIM (NOTINLINE |OpenMathPackage;|)) 

(DEFUN |OpenMathPackage| ()
  (SPROG NIL
         (PROG (#1=#:G713)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OpenMathPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OpenMathPackage|
                             (LIST (CONS NIL (CONS 1 (|OpenMathPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|OpenMathPackage|)))))))))) 

(DEFUN |OpenMathPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OpenMathPackage|))
          (LETT $ (GETREFV 32))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OpenMathPackage| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OpenMathPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| $) (|String|) (0 . |concat|)
              (|Exit|) |OMPKG;OMunhandledSymbol;2SE;1| (|Any|) (|InputForm|)
              (5 . |interpret|) (|OpenMathDevice|) |OMPKG;OMread;OmdA;2|
              (|OpenMathEncoding|) (10 . |OMencodingUnknown|)
              (14 . |OMopenFile|) (|Void|) (21 . |OMclose|)
              |OMPKG;OMreadFile;SA;3| (26 . |OMopenString|)
              |OMPKG;OMreadStr;SA;4| (|List| 7) |OMPKG;OMlistCDs;L;5|
              |OMPKG;OMlistSymbols;SL;6| (|Boolean|) (|SExpression|)
              (32 . |null?|) |OMPKG;OMsupportsCD?;SB;7|
              |OMPKG;OMsupportsSymbol?;2SB;8|)
           '#(|OMunhandledSymbol| 37 |OMsupportsSymbol?| 43 |OMsupportsCD?| 49
              |OMreadStr| 54 |OMreadFile| 59 |OMread| 64 |OMlistSymbols| 69
              |OMlistCDs| 74)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|OMread| ((|Any|) (|OpenMathDevice|))) T)
                                   '((|OMreadFile| ((|Any|) (|String|))) T)
                                   '((|OMreadStr| ((|Any|) (|String|))) T)
                                   '((|OMlistCDs| ((|List| (|String|)))) T)
                                   '((|OMlistSymbols|
                                      ((|List| (|String|)) (|String|)))
                                     T)
                                   '((|OMsupportsCD?| ((|Boolean|) (|String|)))
                                     T)
                                   '((|OMsupportsSymbol?|
                                      ((|Boolean|) (|String|) (|String|)))
                                     T)
                                   '((|OMunhandledSymbol|
                                      ((|Exit|) (|String|) (|String|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 31
                                            '(1 7 0 6 8 1 12 11 0 13 0 16 0 17
                                              3 14 0 7 7 16 18 1 14 19 0 20 2
                                              14 0 7 16 22 1 28 27 0 29 2 0 9 7
                                              7 10 2 0 27 7 7 31 1 0 27 7 30 1
                                              0 11 7 23 1 0 11 7 21 1 0 11 14
                                              15 1 0 24 7 26 0 0 24 25)))))
           '|lookupComplete|)) 

(MAKEPROP '|OpenMathPackage| 'NILADIC T) 

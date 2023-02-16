
(SDEFUN |OMSERVER;OMreceive;OmcA;1|
        ((|conn| (|OpenMathConnection|)) ($ (|Any|)))
        (SPROG ((|dev| (|OpenMathDevice|)))
               (SEQ (LETT |dev| (SPADCALL |conn| (QREFELT $ 8)))
                    (SPADCALL |dev| (SPADCALL (QREFELT $ 10)) (QREFELT $ 12))
                    (EXIT (SPADCALL |dev| (QREFELT $ 15)))))) 

(SDEFUN |OMSERVER;OMsend;OmcAV;2|
        ((|conn| (|OpenMathConnection|)) (|value| (|Any|)) ($ (|Void|)))
        (SPROG ((#1=#:G711 NIL) (|dev| (|OpenMathDevice|)))
               (SEQ (LETT |dev| (SPADCALL |conn| (QREFELT $ 17)))
                    (SPADCALL |dev| (SPADCALL (QREFELT $ 18)) (QREFELT $ 12))
                    (EXIT
                     (COND
                      ((SPADCALL |value| (QREFELT $ 21))
                       (SPADCALL |dev| (SPADCALL |value| (QREFELT $ 23)) 'T
                                 (QREFELT $ 24)))
                      ((SPADCALL |value| (QREFELT $ 26))
                       (SPADCALL |dev| (SPADCALL |value| (QREFELT $ 28)) 'T
                                 (QREFELT $ 29)))
                      ((SPADCALL |value| (QREFELT $ 31))
                       (SPADCALL |dev| (SPADCALL |value| (QREFELT $ 33)) 'T
                                 (QREFELT $ 24)))
                      ((SPADCALL |value| (QREFELT $ 35))
                       (SPADCALL |dev| (SPADCALL |value| (QREFELT $ 37)) 'T
                                 (QREFELT $ 38)))
                      ('T
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |value| (QREFELT $ 40))
                           (PROGN
                            (LETT #1#
                                  (SPADCALL |dev|
                                            (SPADCALL |value| (QREFELT $ 42))
                                            'T (QREFELT $ 43)))
                            (GO #2=#:G705)))))
                        #2# (EXIT #1#)))))))) 

(SDEFUN |OMSERVER;OMserve;2SiV;3|
        ((|portNum| (|SingleInteger|)) (|timeout| (|SingleInteger|))
         ($ (|Void|)))
        (SPROG ((|val| (|Any|)) (|conn| (|OpenMathConnection|)))
               (SEQ (LETT |conn| (SPADCALL |timeout| (QREFELT $ 45)))
                    (SPADCALL |conn| |portNum| (QREFELT $ 46))
                    (EXIT
                     (SEQ G190 (COND ((NULL 'T) (GO G191)))
                          (SEQ (LETT |val| (SPADCALL |conn| (QREFELT $ 16)))
                               (EXIT (SPADCALL |conn| |val| (QREFELT $ 44))))
                          NIL (GO G190) G191 (EXIT NIL)))))) 

(DECLAIM (NOTINLINE |OpenMathServerPackage;|)) 

(DEFUN |OpenMathServerPackage| ()
  (SPROG NIL
         (PROG (#1=#:G718)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OpenMathServerPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OpenMathServerPackage|
                             (LIST
                              (CONS NIL (CONS 1 (|OpenMathServerPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|OpenMathServerPackage|)))))))))) 

(DEFUN |OpenMathServerPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OpenMathServerPackage|))
          (LETT $ (GETREFV 48))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OpenMathServerPackage| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OpenMathServerPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|OpenMathDevice|) (|OpenMathConnection|)
              (0 . |OMconnInDevice|) (|OpenMathEncoding|)
              (5 . |OMencodingUnknown|) (|Void|) (9 . |OMsetEncoding|) (|Any|)
              (|OpenMathPackage|) (15 . |OMread|) |OMSERVER;OMreceive;OmcA;1|
              (20 . |OMconnOutDevice|) (25 . |OMencodingXML|) (|Boolean|)
              (|AnyFunctions1| 22) (29 . |retractable?|) (|Integer|)
              (34 . |retract|) (39 . |OMwrite|) (|AnyFunctions1| 27)
              (46 . |retractable?|) (|Float|) (51 . |retract|) (56 . |OMwrite|)
              (|AnyFunctions1| 32) (63 . |retractable?|) (|SingleInteger|)
              (68 . |retract|) (|AnyFunctions1| 36) (73 . |retractable?|)
              (|DoubleFloat|) (78 . |retract|) (83 . |OMwrite|)
              (|AnyFunctions1| 41) (90 . |retractable?|) (|String|)
              (95 . |retract|) (100 . |OMwrite|) |OMSERVER;OMsend;OmcAV;2|
              (107 . |OMmakeConn|) (112 . |OMbindTCP|)
              |OMSERVER;OMserve;2SiV;3|)
           '#(|OMserve| 118 |OMsend| 124 |OMreceive| 130) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|OMreceive| ((|Any|) (|OpenMathConnection|)))
                                T)
                              '((|OMsend|
                                 ((|Void|) (|OpenMathConnection|) (|Any|)))
                                T)
                              '((|OMserve|
                                 ((|Void|) (|SingleInteger|)
                                  (|SingleInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 47
                                            '(1 7 6 0 8 0 9 0 10 2 6 11 0 9 12
                                              1 14 13 6 15 1 7 6 0 17 0 9 0 18
                                              1 20 19 13 21 1 20 22 13 23 3 22
                                              11 6 0 19 24 1 25 19 13 26 1 25
                                              27 13 28 3 27 11 6 0 19 29 1 30
                                              19 13 31 1 30 32 13 33 1 34 19 13
                                              35 1 34 36 13 37 3 36 11 6 0 19
                                              38 1 39 19 13 40 1 39 41 13 42 3
                                              41 11 6 0 19 43 1 7 0 32 45 2 7
                                              19 0 32 46 2 0 11 32 32 47 2 0 11
                                              7 13 44 1 0 13 7 16)))))
           '|lookupComplete|)) 

(MAKEPROP '|OpenMathServerPackage| 'NILADIC T) 

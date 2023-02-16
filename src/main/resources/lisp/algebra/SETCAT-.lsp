
(SDEFUN |SETCAT-;hash;SSi;1| ((|s| (S)) ($ (|SingleInteger|)))
        (HASHSTATEMAKEFIXNUM (SPADCALL HASHSTATEBASIS |s| (QREFELT $ 8)))) 

(SDEFUN |SETCAT-;latex;SS;2| ((|s| (S)) ($ (|String|)))
        (SPROG
         ((|sl| (|List| (|String|))) (|tf| (|TexFormat|))
          (|of| (|OutputForm|)))
         (SEQ (LETT |of| (SPADCALL |s| (QREFELT $ 12)))
              (LETT |tf| (SPADCALL |of| (QREFELT $ 14)))
              (LETT |sl| (SPADCALL |tf| (QREFELT $ 16)))
              (EXIT (SPADCALL (ELT $ 18) |sl| (QREFELT $ 20)))))) 

(DECLAIM (NOTINLINE |SetCategory&;|)) 

(DEFUN |SetCategory&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|SetCategory&| DV$1))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SetCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|HashState|)
              (0 . |hashUpdate!|) (|SingleInteger|) |SETCAT-;hash;SSi;1|
              (|OutputForm|) (6 . |coerce|) (|TexFormat|) (11 . |coerce|)
              (|List| 17) (16 . |tex|) (|String|) (21 . |concat|)
              (|Mapping| 17 17 17) (27 . |reduce|) |SETCAT-;latex;SS;2|)
           '#(|latex| 33 |hash| 38) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|latex| ((|String|) |#1|)) T)
                                   '((|hash| ((|SingleInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(2 6 7 7 0 8 1 6 11 0 12 1 13 0 11
                                              14 1 13 15 0 16 2 17 0 0 0 18 2
                                              15 17 19 0 20 1 0 17 0 21 1 0 9 0
                                              10)))))
           '|lookupComplete|)) 

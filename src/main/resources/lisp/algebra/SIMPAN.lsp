
(SDEFUN |SIMPAN;simplify;AnE;1|
        ((|a| (|AlgebraicNumber|)) ($ (|Expression| (|Integer|))))
        (SPADCALL (SPADCALL |a| (QREFELT $ 8)) (QREFELT $ 10))) 

(DECLAIM (NOTINLINE |SimplifyAlgebraicNumberConvertPackage;|)) 

(DEFUN |SimplifyAlgebraicNumberConvertPackage| ()
  (SPROG NIL
         (PROG (#1=#:G696)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache|
                          '|SimplifyAlgebraicNumberConvertPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|SimplifyAlgebraicNumberConvertPackage|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|SimplifyAlgebraicNumberConvertPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|SimplifyAlgebraicNumberConvertPackage|)))))))))) 

(DEFUN |SimplifyAlgebraicNumberConvertPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|SimplifyAlgebraicNumberConvertPackage|))
          (LETT $ (GETREFV 12))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|SimplifyAlgebraicNumberConvertPackage| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SimplifyAlgebraicNumberConvertPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|AlgebraicNumber|)
              (|Expression| (|Integer|)) (0 . |coerce|)
              (|TranscendentalManipulations| (|Integer|) 7) (5 . |simplify|)
              |SIMPAN;simplify;AnE;1|)
           '#(|simplify| 10) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|simplify|
                                 ((|Expression| (|Integer|))
                                  (|AlgebraicNumber|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 11
                                            '(1 7 0 6 8 1 9 7 7 10 1 0 7 6
                                              11)))))
           '|lookupComplete|)) 

(MAKEPROP '|SimplifyAlgebraicNumberConvertPackage| 'NILADIC T) 

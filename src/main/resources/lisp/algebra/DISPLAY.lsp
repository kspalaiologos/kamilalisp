
(SDEFUN |DISPLAY;bright;SL;1| ((|s| (|String|)) ($ (|List| (|String|))))
        (LIST (QREFELT $ 6) |s| (QREFELT $ 7))) 

(SDEFUN |DISPLAY;bright;2L;2|
        ((|l| (|List| (|String|))) ($ (|List| (|String|))))
        (CONS (QREFELT $ 6)
              (SPADCALL |l| (SPADCALL (QREFELT $ 7) (QREFELT $ 12))
                        (QREFELT $ 13)))) 

(SDEFUN |DISPLAY;newLine;S;3| (($ (|String|))) (QREFELT $ 8)) 

(SDEFUN |DISPLAY;copies;I2S;4|
        ((|n| (|Integer|)) (|s| (|String|)) ($ (|String|)))
        (SPROG ((|t| (|String|)))
               (SEQ
                (COND ((< |n| 1) "") ((EQL |n| 1) |s|)
                      (#1='T
                       (SEQ
                        (LETT |t|
                              (SPADCALL (QUOTIENT2 |n| 2) |s| (QREFELT $ 17)))
                        (EXIT
                         (COND
                          ((ODDP |n|)
                           (SPADCALL (LIST |s| |t| |t|) (QREFELT $ 19)))
                          (#1# (SPADCALL (LIST |t| |t|) (QREFELT $ 19))))))))))) 

(SDEFUN |DISPLAY;center0|
        ((|len| (|Integer|)) (|wid| (|Integer|)) (|fill| (|String|))
         ($ (|Record| (|:| |lhs| (|String|)) (|:| |rhs| (|String|)))))
        (SPROG ((|t| (|String|)) (|m| (|Integer|)))
               (SEQ
                (COND ((OR (< |wid| 1) (>= |len| |wid|)) (CONS "" ""))
                      ('T
                       (SEQ (LETT |m| (QUOTIENT2 (- |wid| |len|) 2))
                            (LETT |t|
                                  (SPADCALL
                                   (+ 1
                                      (QUOTIENT2 |m|
                                                 (SPADCALL |fill|
                                                           (QREFELT $ 20))))
                                   |fill| (QREFELT $ 17)))
                            (EXIT
                             (CONS
                              (SPADCALL |t| (SPADCALL 1 |m| (QREFELT $ 22))
                                        (QREFELT $ 23))
                              (SPADCALL |t|
                                        (SPADCALL 1 (- (- |wid| |len|) |m|)
                                                  (QREFELT $ 22))
                                        (QREFELT $ 23)))))))))) 

(SDEFUN |DISPLAY;center;SI2S;6|
        ((|s| (|String|)) (|wid| (|Integer|)) (|fill| (|String|))
         ($ (|String|)))
        (SPROG
         ((|rec| (|Record| (|:| |lhs| (|String|)) (|:| |rhs| (|String|))))
          (|len| (|Integer|)))
         (SEQ
          (COND ((< |wid| 1) "")
                (#1='T
                 (SEQ (LETT |len| (SPADCALL |s| (QREFELT $ 20)))
                      (EXIT
                       (COND ((EQL |len| |wid|) |s|)
                             ((> |len| |wid|)
                              (SPADCALL |s| (SPADCALL 1 |wid| (QREFELT $ 22))
                                        (QREFELT $ 23)))
                             (#1#
                              (SEQ
                               (LETT |rec|
                                     (|DISPLAY;center0| |len| |wid| |fill| $))
                               (EXIT
                                (SPADCALL (LIST (QCAR |rec|) |s| (QCDR |rec|))
                                          (QREFELT $ 19))))))))))))) 

(SDEFUN |DISPLAY;center;LISL;7|
        ((|l| (|List| (|String|))) (|wid| (|Integer|)) (|fill| (|String|))
         ($ (|List| (|String|))))
        (SPROG
         ((|rec| (|Record| (|:| |lhs| (|String|)) (|:| |rhs| (|String|))))
          (|len| (|Integer|)))
         (SEQ
          (COND ((< |wid| 1) (LIST ""))
                (#1='T
                 (SEQ (LETT |len| (SPADCALL |l| (QREFELT $ 25)))
                      (EXIT
                       (COND ((EQL |len| |wid|) |l|)
                             (#1#
                              (SEQ
                               (LETT |rec|
                                     (|DISPLAY;center0| |len| |wid| |fill| $))
                               (EXIT
                                (CONS (QCAR |rec|)
                                      (SPADCALL |l|
                                                (SPADCALL (QCDR |rec|)
                                                          (QREFELT $ 12))
                                                (QREFELT $ 13)))))))))))))) 

(SDEFUN |DISPLAY;say;SV;8| ((|s| (|String|)) ($ (|Void|)))
        (SEQ (|sayBrightly| |s|) (EXIT (SPADCALL (QREFELT $ 28))))) 

(SDEFUN |DISPLAY;say;LV;9| ((|l| (|List| (|String|))) ($ (|Void|)))
        (SEQ (|sayBrightly| |l|) (EXIT (SPADCALL (QREFELT $ 28))))) 

(PUT '|DISPLAY;sayLength;SI;10| '|SPADreplace| 'QCSIZE) 

(SDEFUN |DISPLAY;sayLength;SI;10| ((|s| (|String|)) ($ (|Integer|)))
        (QCSIZE |s|)) 

(SDEFUN |DISPLAY;sayLength;LI;11| ((|l| (|List| (|String|))) ($ (|Integer|)))
        (SPROG ((|sum| (|Integer|)) (#1=#:G724 NIL) (|s| NIL))
               (SEQ (LETT |sum| 0)
                    (SEQ (LETT |s| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((OR (EQUAL |s| (QREFELT $ 6))
                                 (EQUAL |s| (QREFELT $ 7)))
                             (LETT |sum| (+ |sum| 1)))
                            ((EQUAL |s| (QREFELT $ 8)) |sum|)
                            ('T
                             (LETT |sum|
                                   (+ |sum| (SPADCALL |s| (QREFELT $ 20))))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |sum|)))) 

(DECLAIM (NOTINLINE |DisplayPackage;|)) 

(DEFUN |DisplayPackage| ()
  (SPROG NIL
         (PROG (#1=#:G726)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|DisplayPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|DisplayPackage|
                             (LIST (CONS NIL (CONS 1 (|DisplayPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|DisplayPackage|)))))))))) 

(DEFUN |DisplayPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|DisplayPackage|))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DisplayPackage| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 "%b")
          (QSETREFV $ 7 "%d")
          (QSETREFV $ 8 "%l")
          $))) 

(MAKEPROP '|DisplayPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL 'HION 'HIOFF 'NEWLINE (|List| 10)
              (|String|) |DISPLAY;bright;SL;1| (0 . |list|) (5 . |append|)
              |DISPLAY;bright;2L;2| |DISPLAY;newLine;S;3| (|Integer|)
              |DISPLAY;copies;I2S;4| (|List| $) (11 . |concat|)
              |DISPLAY;sayLength;SI;10| (|UniversalSegment| 16) (16 . SEGMENT)
              (22 . |elt|) |DISPLAY;center;SI2S;6| |DISPLAY;sayLength;LI;11|
              |DISPLAY;center;LISL;7| (|Void|) (28 . |void|) |DISPLAY;say;SV;8|
              |DISPLAY;say;LV;9|)
           '#(|sayLength| 32 |say| 42 |newLine| 52 |copies| 56 |center| 62
              |bright| 76)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|bright| ((|List| (|String|)) (|String|))) T)
                              '((|bright|
                                 ((|List| (|String|)) (|List| (|String|))))
                                T)
                              '((|newLine| ((|String|))) T)
                              '((|copies| ((|String|) (|Integer|) (|String|)))
                                T)
                              '((|center|
                                 ((|String|) (|String|) (|Integer|)
                                  (|String|)))
                                T)
                              '((|center|
                                 ((|List| (|String|)) (|List| (|String|))
                                  (|Integer|) (|String|)))
                                T)
                              '((|say| ((|Void|) (|String|))) T)
                              '((|say| ((|Void|) (|List| (|String|)))) T)
                              '((|sayLength| ((|Integer|) (|String|))) T)
                              '((|sayLength| ((|Integer|) (|List| (|String|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(1 9 0 10 12 2 9 0 0 0 13 1 10 0
                                              18 19 2 21 0 16 16 22 2 10 0 0 21
                                              23 0 27 0 28 1 0 16 9 25 1 0 16
                                              10 20 1 0 27 10 29 1 0 27 9 30 0
                                              0 10 15 2 0 10 16 10 17 3 0 10 10
                                              16 10 24 3 0 9 9 16 10 26 1 0 9 9
                                              14 1 0 9 10 11)))))
           '|lookupComplete|)) 

(MAKEPROP '|DisplayPackage| 'NILADIC T) 

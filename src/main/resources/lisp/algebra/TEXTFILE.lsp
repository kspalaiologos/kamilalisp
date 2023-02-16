
(SDEFUN |TEXTFILE;read!;$S;1| ((|f| ($)) ($ (|String|)))
        (SPADCALL |f| (QREFELT $ 8))) 

(SDEFUN |TEXTFILE;readIfCan!;$U;2|
        ((|f| ($)) ($ (|Union| (|String|) "failed")))
        (SPADCALL |f| (QREFELT $ 11))) 

(SDEFUN |TEXTFILE;readLine!;$S;3| ((|f| ($)) ($ (|String|)))
        (SPROG ((|s| (|None|)))
               (SEQ
                (COND
                 ((SPADCALL (QVELT |f| 2) "input" (QREFELT $ 14))
                  (|error| "File not in read state"))
                 (#1='T
                  (SEQ (LETT |s| (|read_line| (QVELT |f| 1)))
                       (EXIT
                        (COND ((NULL |s|) (|error| "End of file"))
                              (#1# |s|))))))))) 

(SDEFUN |TEXTFILE;readLineIfCan!;$U;4|
        ((|f| ($)) ($ (|Union| (|String|) "failed")))
        (SPROG ((|s| (|None|)))
               (SEQ
                (COND
                 ((SPADCALL (QVELT |f| 2) "input" (QREFELT $ 14))
                  (|error| "File not in read state"))
                 (#1='T
                  (SEQ (LETT |s| (|read_line| (QVELT |f| 1)))
                       (EXIT
                        (COND ((NULL |s|) (CONS 1 "failed"))
                              (#1# (CONS 0 |s|)))))))))) 

(SDEFUN |TEXTFILE;write!;$2S;5| ((|f| ($)) (|x| #1=(|String|)) ($ #1#))
        (SEQ
         (COND
          ((SPADCALL (QVELT |f| 2) "output" (QREFELT $ 14))
           (|error| "File not in write state"))
          ('T (SEQ (PRINTEXP |x| (QVELT |f| 1)) (EXIT |x|)))))) 

(SDEFUN |TEXTFILE;writeLine!;$S;6| ((|f| ($)) ($ (|String|)))
        (SEQ
         (COND
          ((SPADCALL (QVELT |f| 2) "output" (QREFELT $ 14))
           (|error| "File not in write state"))
          ('T (SEQ (TERPRI (QVELT |f| 1)) (EXIT "")))))) 

(SDEFUN |TEXTFILE;writeLine!;$2S;7| ((|f| ($)) (|x| (|String|)) ($ (|String|)))
        (SEQ
         (COND
          ((SPADCALL (QVELT |f| 2) "output" (QREFELT $ 14))
           (|error| "File not in write state"))
          ('T
           (SEQ (PRINTEXP |x| (QVELT |f| 1)) (TERPRI (QVELT |f| 1))
                (EXIT |x|)))))) 

(SDEFUN |TEXTFILE;endOfFile?;$B;8| ((|f| ($)) ($ (|Boolean|)))
        (NULL (OR (EQUAL (QVELT |f| 2) "output") (NULL (EOFP (QVELT |f| 1)))))) 

(DECLAIM (NOTINLINE |TextFile;|)) 

(DEFUN |TextFile| ()
  (SPROG NIL
         (PROG (#1=#:G738)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|TextFile|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|TextFile|
                             (LIST (CONS NIL (CONS 1 (|TextFile;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|TextFile|)))))))))) 

(DEFUN |TextFile;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|TextFile|))
          (LETT $ (GETREFV 24))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TextFile| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |fileName| (|FileName|))
                              (|:| |fileState| (|SExpression|))
                              (|:| |fileIOmode| (|String|))))
          $))) 

(MAKEPROP '|TextFile| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|File| 7) '|Rep| (|String|)
              |TEXTFILE;readLine!;$S;3| |TEXTFILE;read!;$S;1|
              (|Union| 7 '"failed") |TEXTFILE;readLineIfCan!;$U;4|
              |TEXTFILE;readIfCan!;$U;2| (|Boolean|) (0 . ~=)
              |TEXTFILE;write!;$2S;5| |TEXTFILE;writeLine!;$S;6|
              |TEXTFILE;writeLine!;$2S;7| |TEXTFILE;endOfFile?;$B;8| (|Void|)
              (|FileName|) (|SingleInteger|) (|HashState|) (|OutputForm|))
           '#(|writeLine!| 6 |write!| 17 |readLineIfCan!| 23 |readLine!| 28
              |readIfCan!| 33 |read!| 38 |endOfFile?| 43)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|FileCategory| 20 7) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 23))
                        (|makeByteWordVec2| 18
                                            '(2 7 13 0 0 14 1 0 7 0 16 2 0 7 0
                                              7 17 2 0 7 0 7 15 1 0 10 0 11 1 0
                                              7 0 8 1 0 10 0 12 1 0 7 0 9 1 0
                                              13 0 18)))))
           '|lookupIncomplete|)) 

(MAKEPROP '|TextFile| 'NILADIC T) 

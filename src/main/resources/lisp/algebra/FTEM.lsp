
(SDEFUN |FTEM;fortranLiteralLine;SV;1| ((|s| (|String|)) ($ (|Void|)))
        (SEQ (|sayString| |s| (|get_fortran_stream|))
             (EXIT (TERPRI (|get_fortran_stream|))))) 

(SDEFUN |FTEM;fortranLiteral;SV;2| ((|s| (|String|)) ($ (|Void|)))
        (|sayString| |s| (|get_fortran_stream|))) 

(SDEFUN |FTEM;fortranCarriageReturn;V;3| (($ (|Void|)))
        (TERPRI (|get_fortran_stream|))) 

(SDEFUN |FTEM;writePassiveLine!| ((|line| (|String|)) ($ (|Void|)))
        (SPADCALL |line| (QREFELT $ 9))) 

(SDEFUN |FTEM;processTemplate;3Fn;5|
        ((|tp| (|FileName|)) (|fn| (|FileName|)) ($ (|FileName|)))
        (SEQ (SPADCALL |fn| (QREFELT $ 14)) (SPADCALL |tp| (QREFELT $ 15))
             (SPADCALL (QREFELT $ 16)) (EXIT |fn|))) 

(SDEFUN |FTEM;getLine| ((|fp| (|TextFile|)) ($ (|String|)))
        (SPROG ((|line| (|String|)))
               (SEQ
                (LETT |line|
                      (SPADCALL (SPADCALL |fp| (QREFELT $ 18)) (QREFELT $ 20)))
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((SPADCALL |line| (QREFELT $ 22)) NIL)
                              ('T
                               (|eql_SI|
                                (SPADCALL |line|
                                          (SPADCALL |line| (QREFELT $ 24))
                                          (QREFELT $ 26))
                                (|STR_to_CHAR| "_")))))
                       (GO G191)))
                     (SEQ
                      (SPADCALL |line| (SPADCALL |line| (QREFELT $ 24))
                                (|STR_to_CHAR| " ") (QREFELT $ 27))
                      (EXIT
                       (LETT |line|
                             (STRCONC |line|
                                      (SPADCALL (SPADCALL |fp| (QREFELT $ 18))
                                                (QREFELT $ 20))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT |line|)))) 

(SDEFUN |FTEM;processTemplate;2Fn;7| ((|tp| (|FileName|)) ($ (|FileName|)))
        (SPROG
         ((|active| #1=(|Boolean|)) (|line| (|String|)) (#2=#:G722 NIL)
          (|endInput| #1#) (|fp| (|TextFile|)))
         (SEQ (LETT |fp| (SPADCALL |tp| "input" (QREFELT $ 28)))
              (LETT |active| 'T) (LETT |endInput| NIL)
              (SEQ G190
                   (COND
                    ((NULL
                      (COND (|endInput| NIL)
                            ('T (NULL (SPADCALL |fp| (QREFELT $ 29))))))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      (|active|
                       (SEQ (LETT |line| (|FTEM;getLine| |fp| $))
                            (EXIT
                             (COND
                              ((EQUAL |line| "endInput") (LETT |endInput| 'T))
                              ((EQUAL |line| "beginVerbatim")
                               (LETT |active| NIL))
                              ('T
                               (SEQ
                                (EXIT
                                 (COND
                                  ((NULL (SPADCALL |line| (QREFELT $ 22)))
                                   (PROGN
                                    (LETT #2# (SPADCALL |line| (QREFELT $ 31)))
                                    (GO #3=#:G712)))))
                                #3# (EXIT #2#)))))))
                      ('T
                       (SEQ (LETT |line| (SPADCALL |fp| (QREFELT $ 18)))
                            (EXIT
                             (COND
                              ((EQUAL |line| "endVerbatim") (LETT |active| 'T))
                              ('T (|FTEM;writePassiveLine!| |line| $)))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (SPADCALL |fp| (QREFELT $ 32))
              (COND
               ((NULL |active|)
                (|error|
                 (SPADCALL
                  (LIST "Missing `endVerbatim' line in "
                        (SPADCALL |tp| (QREFELT $ 33)))
                  (QREFELT $ 35)))))
              (EXIT
               (SPADCALL (STRINGIMAGE |$fortranOutputFile|) (QREFELT $ 36)))))) 

(DECLAIM (NOTINLINE |FortranTemplate;|)) 

(DEFUN |FortranTemplate| ()
  (SPROG NIL
         (PROG (#1=#:G724)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FortranTemplate|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FortranTemplate|
                             (LIST (CONS NIL (CONS 1 (|FortranTemplate;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|FortranTemplate|)))))))))) 

(DEFUN |FortranTemplate;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FortranTemplate|))
          (LETT $ (GETREFV 40))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FortranTemplate| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|TextFile|))
          $))) 

(MAKEPROP '|FortranTemplate| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|TextFile|) '|Rep| (|Void|) (|String|)
              |FTEM;fortranLiteralLine;SV;1| |FTEM;fortranLiteral;SV;2|
              |FTEM;fortranCarriageReturn;V;3| (|FileName|)
              (|FortranOutputStackPackage|) (0 . |pushFortranOutputStack|)
              |FTEM;processTemplate;2Fn;7| (5 . |popFortranOutputStack|)
              |FTEM;processTemplate;3Fn;5| (9 . |readLine!|)
              (|TemplateUtilities|) (14 . |stripCommentsAndBlanks|) (|Boolean|)
              (19 . |empty?|) (|Integer|) (24 . |maxIndex|) (|Character|)
              (29 . |elt|) (35 . |setelt!|) (42 . |open|) (48 . |endOfFile?|)
              (|Any|) (53 . |interpretString|) (58 . |close!|) (63 . |coerce|)
              (|List| $) (68 . |concat|) (73 . |coerce|) (|SingleInteger|)
              (|HashState|) (|OutputForm|))
           '#(~= 78 |write!| 84 |reopen!| 90 |read!| 96 |processTemplate| 101
              |open| 112 |name| 123 |latex| 128 |iomode| 133 |hashUpdate!| 138
              |hash| 144 |fortranLiteralLine| 149 |fortranLiteral| 154
              |fortranCarriageReturn| 159 |flush| 163 |coerce| 168 |close!| 173
              = 178)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|FileCategory| 12 8) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 39))
                        (|makeByteWordVec2| 39
                                            '(1 13 7 12 14 0 13 7 16 1 6 8 0 18
                                              1 19 8 8 20 1 8 21 0 22 1 8 23 0
                                              24 2 8 25 0 23 26 3 8 25 0 23 25
                                              27 2 5 0 12 8 28 1 6 21 0 29 1 19
                                              30 8 31 1 0 0 0 32 1 12 8 0 33 1
                                              8 0 34 35 1 12 0 8 36 2 0 21 0 0
                                              1 2 0 8 0 8 1 2 0 0 0 8 1 1 0 8 0
                                              1 2 0 12 12 12 17 1 0 12 12 15 2
                                              0 0 12 8 1 1 0 0 12 1 1 0 12 0 1
                                              1 0 8 0 1 1 0 8 0 1 2 0 38 38 0 1
                                              1 0 37 0 1 1 0 7 8 9 1 0 7 8 10 0
                                              0 7 11 1 0 7 0 1 1 0 39 0 1 1 0 0
                                              0 32 2 0 21 0 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|FortranTemplate| 'NILADIC T) 

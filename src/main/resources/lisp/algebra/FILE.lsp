
(SDEFUN |FILE;defstream|
        ((|fn| (|FileName|)) (|mode| (|String|)) ($ (|SExpression|)))
        (COND
         ((EQUAL |mode| "input")
          (COND
           ((NULL (SPADCALL |fn| (QREFELT $ 10)))
            (|error|
             (LIST '|mathprint|
                   (LIST 'CONCAT
                         (SPADCALL "File is not readable" (QREFELT $ 13))
                         (SPADCALL |fn| (QREFELT $ 14))))))
           (#1='T (MAKE_INSTREAM (SPADCALL |fn| (QREFELT $ 15))))))
         ((EQUAL |mode| "output")
          (COND
           ((NULL (SPADCALL |fn| (QREFELT $ 16)))
            (|error|
             (LIST '|mathprint|
                   (LIST 'CONCAT
                         (SPADCALL "File is not writable" (QREFELT $ 13))
                         (SPADCALL |fn| (QREFELT $ 14))))))
           (#1# (MAKE_OUTSTREAM (SPADCALL |fn| (QREFELT $ 15))))))
         ('T
          (|error|
           (LIST '|mathprint|
                 (LIST 'CONCAT
                       (SPADCALL "IO mode must be input or output"
                                 (QREFELT $ 13))
                       (SPADCALL |mode| (QREFELT $ 13)))))))) 

(SDEFUN |FILE;=;2$B;2| ((|f1| ($)) (|f2| ($)) ($ (|Boolean|)))
        (SPADCALL (QVELT |f1| 0) (QVELT |f2| 0) (QREFELT $ 17))) 

(SDEFUN |FILE;coerce;$Of;3| ((|f| ($)) ($ (|OutputForm|)))
        (SPADCALL (QVELT |f| 0) (QREFELT $ 14))) 

(SDEFUN |FILE;open;Fn$;4| ((|fname| (|FileName|)) ($ ($)))
        (SPADCALL |fname| "input" (QREFELT $ 20))) 

(SDEFUN |FILE;open;FnS$;5| ((|fname| (|FileName|)) (|mode| (|String|)) ($ ($)))
        (SPROG ((|fstream| (|SExpression|)))
               (SEQ (LETT |fstream| (|FILE;defstream| |fname| |mode| $))
                    (EXIT (VECTOR |fname| |fstream| |mode|))))) 

(SDEFUN |FILE;reopen!;$S$;6| ((|f| ($)) (|mode| (|String|)) ($ ($)))
        (SPROG ((|fname| (|FileName|)))
               (SEQ
                (COND
                 ((EQUAL (QVELT |f| 2) "output")
                  (SPADCALL |f| (QREFELT $ 23))))
                (LETT |fname| (QVELT |f| 0))
                (QSETVELT |f| 1 (|FILE;defstream| |fname| |mode| $))
                (QSETVELT |f| 2 |mode|) (EXIT |f|)))) 

(SDEFUN |FILE;close!;2$;7| ((|f| ($)) ($ ($)))
        (SEQ (SHUT (QVELT |f| 1)) (QSETVELT |f| 2 "closed") (EXIT |f|))) 

(PUT '|FILE;name;$Fn;8| '|SPADreplace| '(XLAM (|f|) (QVELT |f| 0))) 

(SDEFUN |FILE;name;$Fn;8| ((|f| ($)) ($ (|FileName|))) (QVELT |f| 0)) 

(PUT '|FILE;iomode;$S;9| '|SPADreplace| '(XLAM (|f|) (QVELT |f| 2))) 

(SDEFUN |FILE;iomode;$S;9| ((|f| ($)) ($ (|String|))) (QVELT |f| 2)) 

(SDEFUN |FILE;read!;$S;10| ((|f| ($)) ($ (S)))
        (SPROG ((|x| (|None|)))
               (SEQ
                (COND
                 ((SPADCALL (QVELT |f| 2) "input" (QREFELT $ 28))
                  (|error| "File not in read state"))
                 (#1='T
                  (SEQ (LETT |x| (VMREAD (QVELT |f| 1)))
                       (EXIT
                        (COND ((PLACEP |x|) (|error| "End of file"))
                              (#1# |x|))))))))) 

(SDEFUN |FILE;readIfCan!;$U;11| ((|f| ($)) ($ (|Union| S "failed")))
        (SPROG ((|x| (|None|)))
               (SEQ
                (COND
                 ((SPADCALL (QVELT |f| 2) "input" (QREFELT $ 28))
                  (|error| "File not in read state"))
                 (#1='T
                  (SEQ (LETT |x| (VMREAD (QVELT |f| 1)))
                       (EXIT
                        (COND ((PLACEP |x|) (CONS 1 "failed"))
                              (#1# (CONS 0 |x|)))))))))) 

(SDEFUN |FILE;write!;$2S;12| ((|f| ($)) (|x| (S)) ($ (S)))
        (SEQ
         (COND
          ((SPADCALL (QVELT |f| 2) "output" (QREFELT $ 28))
           (|error| "File not in write state"))
          ('T
           (SEQ (|print_full2| |x| (QVELT |f| 1)) (TERPRI (QVELT |f| 1))
                (EXIT |x|)))))) 

(SDEFUN |FILE;flush;$V;13| ((|f| ($)) ($ (|Void|)))
        (COND
         ((SPADCALL (QVELT |f| 2) "output" (QREFELT $ 28))
          (|error| "File not in write state"))
         ('T (FORCE-OUTPUT (QVELT |f| 1))))) 

(DECLAIM (NOTINLINE |File;|)) 

(DEFUN |File| (#1=#:G746)
  (SPROG NIL
         (PROG (#2=#:G747)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|File|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|File;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|File|)))))))))) 

(DEFUN |File;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|File| DV$1))
          (LETT $ (GETREFV 35))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|File| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |fileName| (|FileName|))
                              (|:| |fileState| (|SExpression|))
                              (|:| |fileIOmode| (|String|))))
          $))) 

(MAKEPROP '|File| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Boolean|)
              (|FileName|) (0 . |readable?|) (|OutputForm|) (|String|)
              (5 . |coerce|) (10 . |coerce|) (15 . |coerce|) (20 . |writable?|)
              (25 . =) |FILE;=;2$B;2| |FILE;coerce;$Of;3| |FILE;open;FnS$;5|
              |FILE;open;Fn$;4| (|Void|) |FILE;flush;$V;13|
              |FILE;reopen!;$S$;6| |FILE;close!;2$;7| |FILE;name;$Fn;8|
              |FILE;iomode;$S;9| (31 . ~=) |FILE;read!;$S;10|
              (|Union| 6 '"failed") |FILE;readIfCan!;$U;11|
              |FILE;write!;$2S;12| (|HashState|) (|SingleInteger|))
           '#(~= 37 |write!| 43 |reopen!| 49 |readIfCan!| 55 |read!| 60 |open|
              65 |name| 76 |latex| 81 |iomode| 86 |hashUpdate!| 91 |hash| 97
              |flush| 102 |coerce| 107 |close!| 112 = 117)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|FileCategory| 9 6) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 11))
                        (|makeByteWordVec2| 34
                                            '(1 9 8 0 10 1 12 11 0 13 1 9 11 0
                                              14 1 9 12 0 15 1 9 8 0 16 2 9 8 0
                                              0 17 2 12 8 0 0 28 2 0 8 0 0 1 2
                                              0 6 0 6 32 2 0 0 0 12 24 1 0 30 0
                                              31 1 0 6 0 29 1 0 0 9 21 2 0 0 9
                                              12 20 1 0 9 0 26 1 0 12 0 1 1 0
                                              12 0 27 2 0 33 33 0 1 1 0 34 0 1
                                              1 0 22 0 23 1 0 11 0 19 1 0 0 0
                                              25 2 0 8 0 0 18)))))
           '|lookupComplete|)) 

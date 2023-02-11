
(SDEFUN |PMASSFS;mkk| ((|op| (|BasicOperator|)) ($ (F)))
        (SPADCALL |op| NIL (QREFELT $ 10))) 

(SDEFUN |PMASSFS;ass| ((|k| (|Kernel| F)) (|s| (|Symbol|)) ($ (F)))
        (SPROG ((|op| (|BasicOperator|)))
               (COND
                ((SPADCALL (LETT |op| (SPADCALL |k| (QREFELT $ 12))) |s|
                           (QREFELT $ 15))
                 (SPADCALL |k| (QREFELT $ 17)))
                ('T
                 (|PMASSFS;mkk|
                  (SPADCALL (SPADCALL |op| (QREFELT $ 18)) |s| (QREFELT $ 19))
                  $))))) 

(SDEFUN |PMASSFS;constant;2F;3| ((|x| (F)) ($ (F)))
        (COND
         ((QEQCAR (SPADCALL |x| (QREFELT $ 21)) 0)
          (|PMASSFS;ass| (SPADCALL |x| (QREFELT $ 22)) '|%pmconstant| $))
         ('T (|error| "constant must be applied to symbols only")))) 

(SDEFUN |PMASSFS;optional;2F;4| ((|x| (F)) ($ (F)))
        (COND
         ((QEQCAR (SPADCALL |x| (QREFELT $ 21)) 0)
          (|PMASSFS;ass| (SPADCALL |x| (QREFELT $ 22)) '|%pmoptional| $))
         ('T (|error| "optional must be applied to symbols only")))) 

(SDEFUN |PMASSFS;multiple;2F;5| ((|x| (F)) ($ (F)))
        (COND
         ((QEQCAR (SPADCALL |x| (QREFELT $ 21)) 0)
          (|PMASSFS;ass| (SPADCALL |x| (QREFELT $ 22)) '|%pmmultiple| $))
         ('T (|error| "multiple must be applied to symbols only")))) 

(DECLAIM (NOTINLINE |FunctionSpaceAssertions;|)) 

(DEFUN |FunctionSpaceAssertions| (&REST #1=#:G718)
  (SPROG NIL
         (PROG (#2=#:G719)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionSpaceAssertions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FunctionSpaceAssertions;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FunctionSpaceAssertions|)))))))))) 

(DEFUN |FunctionSpaceAssertions;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FunctionSpaceAssertions| DV$1 DV$2))
          (LETT $ (GETREFV 26))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FunctionSpaceAssertions|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FunctionSpaceAssertions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|BasicOperator|) (|List| $) (0 . |kernel|) (|Kernel| 7)
              (6 . |operator|) (|Boolean|) (|Symbol|) (11 . |has?|)
              (|Kernel| $) (17 . |coerce|) (22 . |copy|) (27 . |assert|)
              (|Union| 14 '"failed") (33 . |retractIfCan|) (38 . |retract|)
              |PMASSFS;constant;2F;3| |PMASSFS;optional;2F;4|
              |PMASSFS;multiple;2F;5|)
           '#(|optional| 43 |multiple| 48 |constant| 53) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|constant| (|#2| |#2|)) T)
                                   '((|optional| (|#2| |#2|)) T)
                                   '((|multiple| (|#2| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 25
                                            '(2 7 0 8 9 10 1 11 8 0 12 2 8 13 0
                                              14 15 1 7 0 16 17 1 8 0 0 18 2 8
                                              0 0 14 19 1 7 20 0 21 1 7 16 0 22
                                              1 0 7 7 24 1 0 7 7 25 1 0 7 7
                                              23)))))
           '|lookupComplete|)) 

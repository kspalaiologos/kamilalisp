
(SDEFUN |TBCMPPK;initTable!;V;1| (($ (|Void|)))
        (SEQ (SETELT $ 8 'T) (SETELT $ 11 (SPADCALL (QREFELT $ 10)))
             (EXIT (SPADCALL (QREFELT $ 19))))) 

(SDEFUN |TBCMPPK;printInfo!;2SV;2|
        ((|s1| (|String|)) (|s2| (|String|)) ($ (|Void|)))
        (SEQ
         (COND
          ((OR (SPADCALL |s1| (QREFELT $ 23)) (SPADCALL |s2| (QREFELT $ 23)))
           (SPADCALL (QREFELT $ 19)))
          ('T
           (COND
            ((SPADCALL (QREFELT $ 24))
             (SEQ (SETELT $ 12 'T) (SETELT $ 15 |s1|) (SETELT $ 16 |s2|)
                  (EXIT (SPADCALL (QREFELT $ 19)))))
            ('T
             (|error|
              "in printInfo!()$TBCMPPK: not allowed to use hashtable"))))))) 

(SDEFUN |TBCMPPK;startStats!;SV;3| ((|s| (|String|)) ($ (|Void|)))
        (SEQ
         (COND ((SPADCALL |s| (QREFELT $ 23)) (SPADCALL (QREFELT $ 19)))
               ((QREFELT $ 8)
                (SEQ (SETELT $ 13 'T) (SETELT $ 14 0) (SETELT $ 17 |s|)
                     (EXIT (SPADCALL (QREFELT $ 19)))))
               ('T
                (|error|
                 "in startStats!()$TBCMPPK: not allowed to use hashtable"))))) 

(SDEFUN |TBCMPPK;printStats!;V;4| (($ (|Void|)))
        (SPROG ((|n| (|NonNegativeInteger|)) (|title| (|String|)))
               (SEQ
                (COND
                 ((QREFELT $ 8)
                  (COND
                   ((QREFELT $ 13)
                    (SEQ (SPADCALL " " (QREFELT $ 28))
                         (LETT |title|
                               (STRCONC "*** "
                                        (STRCONC (QREFELT $ 17)
                                                 " Statistics ***")))
                         (SPADCALL |title| (QREFELT $ 28))
                         (LETT |n| (SPADCALL (QREFELT $ 11) (QREFELT $ 30)))
                         (SPADCALL "   Table     size: "
                                   (SPADCALL |n| (QREFELT $ 32))
                                   (QREFELT $ 33))
                         (EXIT
                          (SPADCALL "   Entries reused: "
                                    (SPADCALL (QREFELT $ 14) (QREFELT $ 32))
                                    (QREFELT $ 33)))))
                   (#1='T
                    (|error|
                     "in printStats!()$TBCMPPK: statistics not started"))))
                 (#1#
                  (|error|
                   "in printStats!()$TBCMPPK: not allowed to use hashtable")))))) 

(SDEFUN |TBCMPPK;clearTable!;V;5| (($ (|Void|)))
        (SEQ
         (COND
          ((QREFELT $ 8)
           (SEQ (SETELT $ 11 (SPADCALL (QREFELT $ 10))) (SETELT $ 8 NIL)
                (SETELT $ 12 NIL) (SETELT $ 13 NIL)
                (SETELT $ 17 (|make_full_CVEC| 0))
                (EXIT (SPADCALL (QREFELT $ 19)))))
          ('T
           (|error|
            "in clearTable!()$TBCMPPK: not allowed to use hashtable"))))) 

(SDEFUN |TBCMPPK;usingTable?;B;6| (($ (|Boolean|))) (QREFELT $ 8)) 

(SDEFUN |TBCMPPK;printingInfo?;B;7| (($ (|Boolean|))) (QREFELT $ 12)) 

(SDEFUN |TBCMPPK;makingStats?;B;8| (($ (|Boolean|))) (QREFELT $ 13)) 

(SDEFUN |TBCMPPK;extractIfCan;KeyU;9|
        ((|k| (|Key|)) ($ (|Union| |Entry| "failed")))
        (SPROG ((#1=#:G721 NIL) (|s| (|Union| |Entry| "failed")))
               (SEQ
                (EXIT
                 (COND
                  ((QREFELT $ 8)
                   (SEQ (LETT |s| (SPADCALL |k| (QREFELT $ 11) (QREFELT $ 39)))
                        (EXIT
                         (COND
                          ((QEQCAR |s| 0)
                           (SEQ
                            (COND
                             ((QREFELT $ 12)
                              (SPADCALL (QREFELT $ 15) (QREFELT $ 41))))
                            (COND
                             ((QREFELT $ 13)
                              (SETELT $ 14 (+ (QREFELT $ 14) 1))))
                            (EXIT (PROGN (LETT #1# |s|) (GO #2=#:G720)))))
                          (#3='T (CONS 1 "failed"))))))
                  (#3# (CONS 1 "failed"))))
                #2# (EXIT #1#)))) 

(SDEFUN |TBCMPPK;insert!;KeyEntryV;10|
        ((|k| (|Key|)) (|e| (|Entry|)) ($ (|Void|)))
        (SEQ
         (COND
          ((QREFELT $ 8)
           (SEQ (SPADCALL (QREFELT $ 11) |k| |e| (QREFELT $ 43))
                (COND
                 ((QREFELT $ 12) (SPADCALL (QREFELT $ 16) (QREFELT $ 41))))
                (EXIT (SPADCALL (QREFELT $ 19)))))
          ('T (SPADCALL (QREFELT $ 19)))))) 

(DECLAIM (NOTINLINE |TabulatedComputationPackage;|)) 

(DEFUN |TabulatedComputationPackage| (&REST #1=#:G724)
  (SPROG NIL
         (PROG (#2=#:G725)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TabulatedComputationPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |TabulatedComputationPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TabulatedComputationPackage|)))))))))) 

(DEFUN |TabulatedComputationPackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|TabulatedComputationPackage| DV$1 DV$2))
          (LETT $ (GETREFV 45))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TabulatedComputationPackage|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 NIL)
          (QSETREFV $ 11 (SPADCALL (QREFELT $ 10)))
          (QSETREFV $ 12 NIL)
          (QSETREFV $ 13 NIL)
          (QSETREFV $ 14 0)
          (QSETREFV $ 15 "o")
          (QSETREFV $ 16 "+")
          (QSETREFV $ 17 (|make_full_CVEC| 0))
          $))) 

(MAKEPROP '|TabulatedComputationPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|table?|
              (|HashTable| 6 7 '"UEQUAL") (0 . |empty|) '|t| '|info?| '|stats?|
              '|used| '|ok| '|ko| '|domainName| (|Void|) (4 . |void|)
              |TBCMPPK;initTable!;V;1| (|Boolean|) (|String|) (8 . |empty?|)
              |TBCMPPK;usingTable?;B;6| |TBCMPPK;printInfo!;2SV;2|
              |TBCMPPK;startStats!;SV;3| (|OutputPackage|) (13 . |output|)
              (|NonNegativeInteger|) (18 . |#|) (|OutputForm|) (23 . |coerce|)
              (28 . |output|) |TBCMPPK;printStats!;V;4|
              |TBCMPPK;clearTable!;V;5| |TBCMPPK;printingInfo?;B;7|
              |TBCMPPK;makingStats?;B;8| (|Union| 7 '"failed") (34 . |search|)
              (|InternalPrintPackage|) (40 . |iprint|)
              |TBCMPPK;extractIfCan;KeyU;9| (45 . |setelt!|)
              |TBCMPPK;insert!;KeyEntryV;10|)
           '#(|usingTable?| 52 |startStats!| 56 |printingInfo?| 61
              |printStats!| 65 |printInfo!| 69 |makingStats?| 75 |insert!| 79
              |initTable!| 85 |extractIfCan| 89 |clearTable!| 94)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|initTable!| ((|Void|))) T)
                                   '((|printInfo!|
                                      ((|Void|) (|String|) (|String|)))
                                     T)
                                   '((|startStats!| ((|Void|) (|String|))) T)
                                   '((|printStats!| ((|Void|))) T)
                                   '((|clearTable!| ((|Void|))) T)
                                   '((|usingTable?| ((|Boolean|))) T)
                                   '((|printingInfo?| ((|Boolean|))) T)
                                   '((|makingStats?| ((|Boolean|))) T)
                                   '((|extractIfCan|
                                      ((|Union| |#2| "failed") |#1|))
                                     T)
                                   '((|insert!| ((|Void|) |#1| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 44
                                            '(0 9 0 10 0 18 0 19 1 22 21 0 23 1
                                              27 18 22 28 1 9 29 0 30 1 29 31 0
                                              32 2 27 18 22 31 33 2 9 38 6 0 39
                                              1 40 18 22 41 3 9 7 0 6 7 43 0 0
                                              21 24 1 0 18 22 26 0 0 21 36 0 0
                                              18 34 2 0 18 22 22 25 0 0 21 37 2
                                              0 18 6 7 44 0 0 18 20 1 0 38 6 42
                                              0 0 18 35)))))
           '|lookupComplete|)) 

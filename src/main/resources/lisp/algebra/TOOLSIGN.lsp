
(SDEFUN |TOOLSIGN;nonQsign;RU;1| ((|r| (R)) ($ (|Union| (|Integer|) "failed")))
        (SPADCALL (SPADCALL |r| (QREFELT $ 9)) (QREFELT $ 12))) 

(PUT '|TOOLSIGN;nonQsign;RU;2| '|SPADreplace| '(XLAM (|r|) (CONS 1 "failed"))) 

(SDEFUN |TOOLSIGN;nonQsign;RU;2| ((|r| (R)) ($ (|Union| (|Integer|) "failed")))
        (CONS 1 "failed")) 

(SDEFUN |TOOLSIGN;sign;RU;3| ((|r| (R)) ($ (|Union| (|Integer|) "failed")))
        (SPROG ((|u| (|Union| (|Fraction| (|Integer|)) "failed")))
               (SEQ (LETT |u| (SPADCALL |r| (QREFELT $ 15)))
                    (EXIT
                     (COND
                      ((QEQCAR |u| 0)
                       (CONS 0 (SPADCALL (QCDR |u|) (QREFELT $ 18))))
                      ('T (SPADCALL |r| (QREFELT $ 13)))))))) 

(SDEFUN |TOOLSIGN;sign;RU;4| ((|r| (R)) ($ (|Union| (|Integer|) "failed")))
        (SPROG ((|u| (|Union| (|Integer|) "failed")))
               (SEQ (LETT |u| (SPADCALL |r| (QREFELT $ 20)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0 (SPADCALL (QCDR |u|) (QREFELT $ 21))))))))) 

(SDEFUN |TOOLSIGN;sign;RU;5| ((|r| (R)) ($ (|Union| (|Integer|) "failed")))
        (COND ((SPADCALL |r| (QREFELT $ 23)) (CONS 0 0))
              ((SPADCALL |r| (|spadConstant| $ 24) (QREFELT $ 25)) (CONS 0 1))
              (#1='T
               (COND
                ((SPADCALL |r| (SPADCALL (|spadConstant| $ 24) (QREFELT $ 26))
                           (QREFELT $ 25))
                 (CONS 0 -1))
                (#1# (CONS 1 "failed")))))) 

(SDEFUN |TOOLSIGN;direction;SI;6| ((|st| (|String|)) ($ (|Integer|)))
        (COND ((EQUAL |st| "right") 1) ((EQUAL |st| "left") -1)
              ('T (|error| "Unknown option")))) 

(DECLAIM (NOTINLINE |ToolsForSign;|)) 

(DEFUN |ToolsForSign| (#1=#:G732)
  (SPROG NIL
         (PROG (#2=#:G733)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|ToolsForSign|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|ToolsForSign;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|ToolsForSign|)))))))))) 

(DEFUN |ToolsForSign;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ToolsForSign| DV$1))
          (LETT $ (GETREFV 29))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ToolsForSign| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|domainEqual| |#1| (|AlgebraicNumber|))
            (QSETREFV $ 13
                      (CONS (|dispatchFunction| |TOOLSIGN;nonQsign;RU;1|) $)))
           ('T
            (QSETREFV $ 13
                      (CONS (|dispatchFunction| |TOOLSIGN;nonQsign;RU;2|) $))))
          (COND
           ((|HasCategory| |#1| '(|RetractableTo| (|Fraction| (|Integer|))))
            (QSETREFV $ 19 (CONS (|dispatchFunction| |TOOLSIGN;sign;RU;3|) $)))
           ((|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
            (QSETREFV $ 19 (CONS (|dispatchFunction| |TOOLSIGN;sign;RU;4|) $)))
           ('T
            (QSETREFV $ 19
                      (CONS (|dispatchFunction| |TOOLSIGN;sign;RU;5|) $))))
          $))) 

(MAKEPROP '|ToolsForSign| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|AlgebraicNumber|)
              (|Expression| 16) (0 . |coerce|) (|Union| 16 '"failed")
              (|ElementaryFunctionSign| 16 8) (5 . |sign|) (10 . |nonQsign|)
              (|Union| 17 '"failed") (15 . |retractIfCan|) (|Integer|)
              (|Fraction| 16) (20 . |sign|) (25 . |sign|) (30 . |retractIfCan|)
              (35 . |sign|) (|Boolean|) (40 . |zero?|) (45 . |One|) (49 . =)
              (55 . -) (|String|) |TOOLSIGN;direction;SI;6|)
           '#(|sign| 60 |nonQsign| 65 |direction| 70) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|sign| ((|Union| (|Integer|) "failed") |#1|))
                                T)
                              '((|nonQsign|
                                 ((|Union| (|Integer|) "failed") |#1|))
                                T)
                              '((|direction| ((|Integer|) (|String|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 28
                                            '(1 8 0 7 9 1 11 10 8 12 1 0 10 6
                                              13 1 6 14 0 15 1 17 16 0 18 1 0
                                              10 6 19 1 6 10 0 20 1 16 16 0 21
                                              1 6 22 0 23 0 6 0 24 2 6 22 0 0
                                              25 1 6 0 0 26 1 0 10 6 19 1 0 10
                                              6 13 1 0 16 27 28)))))
           '|lookupComplete|)) 

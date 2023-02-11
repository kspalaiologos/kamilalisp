
(SDEFUN |MAGMAWU-;one?;SB;1| ((|x| (S)) ($ (|Boolean|)))
        (SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 9))) 

(SDEFUN |MAGMAWU-;sample;S;2| (($ (S))) (|spadConstant| $ 7)) 

(SDEFUN |MAGMAWU-;^;SNniS;3| ((|x| (S)) (|n| (|NonNegativeInteger|)) ($ (S)))
        (COND ((ZEROP |n|) (|spadConstant| $ 7))
              ('T (SPADCALL |x| |n| (QREFELT $ 14))))) 

(SDEFUN |MAGMAWU-;rightPower;SNniS;4|
        ((|a| (S)) (|n| (|NonNegativeInteger|)) ($ (S)))
        (SPROG ((|res| (S)) (#1=#:G717 NIL) (|i| NIL))
               (SEQ
                (COND ((ZEROP |n|) (|spadConstant| $ 7))
                      ('T
                       (SEQ (LETT |res| (|spadConstant| $ 7))
                            (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |res|
                                         (SPADCALL |res| |a| (QREFELT $ 17)))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |res|))))))) 

(SDEFUN |MAGMAWU-;leftPower;SNniS;5|
        ((|a| (S)) (|n| (|NonNegativeInteger|)) ($ (S)))
        (SPROG ((|res| (S)) (#1=#:G723 NIL) (|i| NIL))
               (SEQ
                (COND ((ZEROP |n|) (|spadConstant| $ 7))
                      ('T
                       (SEQ (LETT |res| (|spadConstant| $ 7))
                            (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |res|
                                         (SPADCALL |a| |res| (QREFELT $ 17)))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |res|))))))) 

(SDEFUN |MAGMAWU-;recip;SU;6| ((|x| (S)) ($ (|Union| S "failed")))
        (COND ((SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 9)) (CONS 0 |x|))
              ('T (CONS 1 "failed")))) 

(SDEFUN |MAGMAWU-;leftRecip;SU;7| ((|x| (S)) ($ (|Union| S "failed")))
        (SPADCALL |x| (QREFELT $ 22))) 

(SDEFUN |MAGMAWU-;rightRecip;SU;8| ((|x| (S)) ($ (|Union| S "failed")))
        (SPADCALL |x| (QREFELT $ 22))) 

(DECLAIM (NOTINLINE |MagmaWithUnit&;|)) 

(DEFUN |MagmaWithUnit&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|MagmaWithUnit&| DV$1))
          (LETT $ (GETREFV 25))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|TwoSidedRecip|))
            (PROGN
             (QSETREFV $ 23
                       (CONS (|dispatchFunction| |MAGMAWU-;leftRecip;SU;7|) $))
             (QSETREFV $ 24
                       (CONS (|dispatchFunction| |MAGMAWU-;rightRecip;SU;8|)
                             $)))))
          $))) 

(MAKEPROP '|MagmaWithUnit&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|) (|Boolean|)
              (4 . =) |MAGMAWU-;one?;SB;1| |MAGMAWU-;sample;S;2|
              (|PositiveInteger|) (|RepeatedSquaring| 6) (10 . |expt|)
              (|NonNegativeInteger|) |MAGMAWU-;^;SNniS;3| (16 . *)
              |MAGMAWU-;rightPower;SNniS;4| |MAGMAWU-;leftPower;SNniS;5|
              (|Union| $ '#1="failed") |MAGMAWU-;recip;SU;6| (22 . |recip|)
              (27 . |leftRecip|) (32 . |rightRecip|))
           '#(|sample| 37 |rightRecip| 41 |rightPower| 46 |recip| 52 |one?| 57
              |leftRecip| 62 |leftPower| 67 ^ 73)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rightRecip| ((|Union| |#1| "failed") |#1|))
                                T)
                              '((|leftRecip| ((|Union| |#1| "failed") |#1|)) T)
                              '((|recip| ((|Union| |#1| #1#) |#1|)) T)
                              '((^ (|#1| |#1| (|NonNegativeInteger|))) T)
                              '((|leftPower|
                                 (|#1| |#1| (|NonNegativeInteger|)))
                                T)
                              '((|rightPower|
                                 (|#1| |#1| (|NonNegativeInteger|)))
                                T)
                              '((|one?| ((|Boolean|) |#1|)) T)
                              '((|sample| (|#1|)) T)
                              '((^ (|#1| |#1| (|PositiveInteger|))) T)
                              '((|leftPower| (|#1| |#1| (|PositiveInteger|)))
                                T)
                              '((|rightPower| (|#1| |#1| (|PositiveInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 24
                                            '(0 6 0 7 2 6 8 0 0 9 2 13 6 6 12
                                              14 2 6 0 0 0 17 1 6 20 0 22 1 0
                                              20 0 23 1 0 20 0 24 0 0 0 11 1 0
                                              20 0 24 2 0 0 0 15 18 1 0 20 0 21
                                              1 0 8 0 10 1 0 20 0 23 2 0 0 0 15
                                              19 2 0 0 0 15 16)))))
           '|lookupComplete|)) 

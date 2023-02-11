
(PUT '|RNS-;characteristic;Nni;1| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |RNS-;characteristic;Nni;1| (($ (|NonNegativeInteger|))) 0) 

(SDEFUN |RNS-;fractionPart;2S;2| ((|x| (S)) ($ (S)))
        (SPADCALL |x| (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 10))) 

(SDEFUN |RNS-;truncate;2S;3| ((|x| (S)) ($ (S)))
        (COND
         ((SPADCALL |x| (QREFELT $ 13))
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 15))
                    (QREFELT $ 14)))
         ('T (SPADCALL |x| (QREFELT $ 15))))) 

(SDEFUN |RNS-;round;2S;4| ((|x| (S)) ($ (S)))
        (COND
         ((SPADCALL |x| (QREFELT $ 13))
          (SPADCALL
           (SPADCALL |x|
                     (SPADCALL (|spadConstant| $ 17)
                               (SPADCALL 2 (QREFELT $ 19)) (QREFELT $ 20))
                     (QREFELT $ 10))
           (QREFELT $ 9)))
         ('T
          (SPADCALL
           (SPADCALL |x|
                     (SPADCALL (|spadConstant| $ 17)
                               (SPADCALL 2 (QREFELT $ 19)) (QREFELT $ 20))
                     (QREFELT $ 21))
           (QREFELT $ 9))))) 

(SDEFUN |RNS-;norm;2S;5| ((|x| (S)) ($ (S))) (SPADCALL |x| (QREFELT $ 23))) 

(SDEFUN |RNS-;coerce;FS;6| ((|x| (|Fraction| (|Integer|))) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 26)) (QREFELT $ 19))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (QREFELT $ 19))
                  (QREFELT $ 20))) 

(SDEFUN |RNS-;convert;SP;7| ((|x| (S)) ($ (|Pattern| (|Float|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 30)) (QREFELT $ 32))) 

(SDEFUN |RNS-;floor;2S;8| ((|x| (S)) ($ (S)))
        (SPROG ((|x1| (S)))
               (SEQ
                (LETT |x1|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 34)) (QREFELT $ 19)))
                (EXIT
                 (COND ((SPADCALL |x| |x1| (QREFELT $ 35)) |x|)
                       ((SPADCALL |x| (|spadConstant| $ 36) (QREFELT $ 37))
                        (SPADCALL |x1| (|spadConstant| $ 17) (QREFELT $ 10)))
                       ('T |x1|)))))) 

(SDEFUN |RNS-;ceiling;2S;9| ((|x| (S)) ($ (S)))
        (SPROG ((|x1| (S)))
               (SEQ
                (LETT |x1|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 34)) (QREFELT $ 19)))
                (EXIT
                 (COND ((SPADCALL |x| |x1| (QREFELT $ 35)) |x|)
                       ((SPADCALL |x| (|spadConstant| $ 36) (QREFELT $ 39))
                        (SPADCALL |x1| (|spadConstant| $ 17) (QREFELT $ 21)))
                       ('T |x1|)))))) 

(SDEFUN |RNS-;patternMatch;SP2Pmr;10|
        ((|x| (S)) (|p| (|Pattern| (|Float|)))
         (|l| (|PatternMatchResult| (|Float|) S))
         ($ (|PatternMatchResult| (|Float|) S)))
        (SPROG ((|r| (|Union| (|Float|) "failed")))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 41))
                  (SPADCALL |p| |x| |l| (QREFELT $ 43)))
                 ((SPADCALL |p| (QREFELT $ 44))
                  (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 46)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 0)
                          (COND
                           ((SPADCALL (SPADCALL |x| (QREFELT $ 30)) (QCDR |r|)
                                      (QREFELT $ 47))
                            |l|)
                           (#1='T (SPADCALL (QREFELT $ 48)))))
                         (#1# (SPADCALL (QREFELT $ 48)))))))
                 (#1# (SPADCALL (QREFELT $ 48))))))) 

(DECLAIM (NOTINLINE |RealNumberSystem&;|)) 

(DEFUN |RealNumberSystem&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RealNumberSystem&| DV$1))
          (LETT $ (GETREFV 53))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RealNumberSystem&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              |RNS-;characteristic;Nni;1| (0 . |truncate|) (5 . -)
              |RNS-;fractionPart;2S;2| (|Boolean|) (11 . |negative?|) (16 . -)
              (21 . |floor|) |RNS-;truncate;2S;3| (26 . |One|) (|Integer|)
              (30 . |coerce|) (35 . /) (41 . +) |RNS-;round;2S;4| (47 . |abs|)
              |RNS-;norm;2S;5| (|Fraction| 18) (52 . |numer|) (57 . |denom|)
              |RNS-;coerce;FS;6| (|Float|) (62 . |convert|) (|Pattern| 29)
              (67 . |coerce|) |RNS-;convert;SP;7| (72 . |wholePart|) (77 . =)
              (83 . |Zero|) (87 . <) |RNS-;floor;2S;8| (93 . >=)
              |RNS-;ceiling;2S;9| (99 . |generic?|) (|PatternMatchResult| 29 6)
              (104 . |addMatch|) (111 . |constant?|) (|Union| 29 '"failed")
              (116 . |retractIfCan|) (121 . =) (127 . |failed|)
              (|PatternMatchResult| 29 $) |RNS-;patternMatch;SP2Pmr;10|
              (|DoubleFloat|) (|OutputForm|))
           '#(|truncate| 131 |round| 136 |patternMatch| 141 |norm| 148
              |fractionPart| 153 |floor| 158 |convert| 163 |coerce| 168
              |characteristic| 173 |ceiling| 177)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|round| (|#1| |#1|)) T)
                                   '((|truncate| (|#1| |#1|)) T)
                                   '((|fractionPart| (|#1| |#1|)) T)
                                   '((|floor| (|#1| |#1|)) T)
                                   '((|ceiling| (|#1| |#1|)) T)
                                   '((|norm| (|#1| |#1|)) T)
                                   '((|patternMatch|
                                      ((|PatternMatchResult| (|Float|) |#1|)
                                       |#1| (|Pattern| (|Float|))
                                       (|PatternMatchResult| (|Float|) |#1|)))
                                     T)
                                   '((|convert| ((|Pattern| (|Float|)) |#1|))
                                     T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|convert| ((|DoubleFloat|) |#1|)) T)
                                   '((|convert| ((|Float|) |#1|)) T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|coerce| (|#1| |#1|)) T)
                                   '((|characteristic|
                                      ((|NonNegativeInteger|)))
                                     T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 50
                                            '(1 6 0 0 9 2 6 0 0 0 10 1 6 12 0
                                              13 1 6 0 0 14 1 6 0 0 15 0 6 0 17
                                              1 6 0 18 19 2 6 0 0 0 20 2 6 0 0
                                              0 21 1 6 0 0 23 1 25 18 0 26 1 25
                                              18 0 27 1 6 29 0 30 1 31 0 29 32
                                              1 6 18 0 34 2 6 12 0 0 35 0 6 0
                                              36 2 6 12 0 0 37 2 6 12 0 0 39 1
                                              31 12 0 41 3 42 0 31 6 0 43 1 31
                                              12 0 44 1 31 45 0 46 2 29 12 0 0
                                              47 0 42 0 48 1 0 0 0 16 1 0 0 0
                                              22 3 0 49 0 31 49 50 1 0 0 0 24 1
                                              0 0 0 11 1 0 0 0 38 1 0 31 0 33 1
                                              0 0 25 28 0 0 7 8 1 0 0 0 40)))))
           '|lookupComplete|)) 

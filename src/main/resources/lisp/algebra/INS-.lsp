
(PUT '|INS-;characteristic;Nni;1| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |INS-;characteristic;Nni;1| (($ (|NonNegativeInteger|))) 0) 

(SDEFUN |INS-;differentiate;2S;2| ((|x| (S)) ($ (S))) (|spadConstant| $ 9)) 

(SDEFUN |INS-;even?;SB;3| ((|x| (S)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| (QREFELT $ 12)))) 

(SDEFUN |INS-;positive?;SB;4| ((|x| (S)) ($ (|Boolean|)))
        (SPADCALL |x| (|spadConstant| $ 9) (QREFELT $ 14))) 

(PUT '|INS-;copy;2S;5| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |INS-;copy;2S;5| ((|x| (S)) ($ (S))) |x|) 

(SDEFUN |INS-;bit?;2SB;6| ((|x| (S)) (|i| (S)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |x| (SPADCALL |i| (QREFELT $ 17)) (QREFELT $ 18))
                  (QREFELT $ 12))) 

(SDEFUN |INS-;mask;2S;7| ((|n| (S)) ($ (S)))
        (SPADCALL (SPADCALL (|spadConstant| $ 20) |n| (QREFELT $ 18))
                  (QREFELT $ 21))) 

(PUT '|INS-;rational?;SB;8| '|SPADreplace| '(XLAM (|x|) 'T)) 

(SDEFUN |INS-;rational?;SB;8| ((|x| (S)) ($ (|Boolean|))) 'T) 

(SDEFUN |INS-;euclideanSize;SNni;9| ((|x| (S)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G728 NIL) (#2=#:G727 NIL))
               (COND
                ((SPADCALL |x| (|spadConstant| $ 9) (QREFELT $ 24))
                 (|error| "euclideanSize called on zero"))
                ((SPADCALL |x| (|spadConstant| $ 9) (QREFELT $ 25))
                 (PROG1 (LETT #2# (- (SPADCALL |x| (QREFELT $ 27))))
                   (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #2#)))
                ('T
                 (PROG1 (LETT #1# (SPADCALL |x| (QREFELT $ 27)))
                   (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #1#)))))) 

(SDEFUN |INS-;convert;SF;10| ((|x| (S)) ($ (|Float|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (QREFELT $ 30))) 

(SDEFUN |INS-;convert;SDf;11| ((|x| (S)) ($ (|DoubleFloat|)))
        (FLOAT (SPADCALL |x| (QREFELT $ 27)) MOST-POSITIVE-DOUBLE-FLOAT)) 

(SDEFUN |INS-;convert;SIf;12| ((|x| (S)) ($ (|InputForm|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (QREFELT $ 35))) 

(SDEFUN |INS-;retract;SI;13| ((|x| (S)) ($ (|Integer|)))
        (SPADCALL |x| (QREFELT $ 27))) 

(SDEFUN |INS-;convert;SP;14| ((|x| (S)) ($ (|Pattern| (|Integer|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (QREFELT $ 39))) 

(SDEFUN |INS-;factor;SF;15| ((|x| (S)) ($ (|Factored| S)))
        (SPADCALL |x| (QREFELT $ 43))) 

(SDEFUN |INS-;squareFree;SF;16| ((|x| (S)) ($ (|Factored| S)))
        (SPADCALL |x| (QREFELT $ 46))) 

(SDEFUN |INS-;prime?;SB;17| ((|x| (S)) ($ (|Boolean|)))
        (SPADCALL |x| (QREFELT $ 49))) 

(SDEFUN |INS-;factorial;2S;18| ((|x| (S)) ($ (S)))
        (SPADCALL |x| (QREFELT $ 52))) 

(SDEFUN |INS-;binomial;3S;19| ((|n| (S)) (|m| (S)) ($ (S)))
        (SPADCALL |n| |m| (QREFELT $ 54))) 

(SDEFUN |INS-;permutation;3S;20| ((|n| (S)) (|m| (S)) ($ (S)))
        (SPADCALL |n| |m| (QREFELT $ 56))) 

(SDEFUN |INS-;retractIfCan;SU;21|
        ((|x| (S)) ($ (|Union| (|Integer|) "failed")))
        (CONS 0 (SPADCALL |x| (QREFELT $ 27)))) 

(SDEFUN |INS-;init;S;22| (($ (S))) (|spadConstant| $ 9)) 

(SDEFUN |INS-;nextItem;SU;23| ((|n| (S)) ($ (|Union| S "failed")))
        (COND ((SPADCALL |n| (QREFELT $ 61)) (CONS 0 (|spadConstant| $ 20)))
              ((SPADCALL |n| (|spadConstant| $ 9) (QREFELT $ 14))
               (CONS 0 (SPADCALL |n| (QREFELT $ 17))))
              ('T
               (CONS 0 (SPADCALL (|spadConstant| $ 20) |n| (QREFELT $ 62)))))) 

(SDEFUN |INS-;patternMatch;SP2Pmr;24|
        ((|x| (S)) (|p| (|Pattern| (|Integer|)))
         (|l| (|PatternMatchResult| (|Integer|) S))
         ($ (|PatternMatchResult| (|Integer|) S)))
        (SPADCALL |x| |p| |l| (QREFELT $ 67))) 

(SDEFUN |INS-;rational;SF;25| ((|x| (S)) ($ (|Fraction| (|Integer|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (QREFELT $ 71))) 

(SDEFUN |INS-;rationalIfCan;SU;26|
        ((|x| (S)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (CONS 0 (SPADCALL (SPADCALL |x| (QREFELT $ 27)) (QREFELT $ 71)))) 

(SDEFUN |INS-;symmetricRemainder;3S;27| ((|x| (S)) (|n| (S)) ($ (S)))
        (SPROG ((|r| (S)))
               (SEQ (LETT |r| (SPADCALL |x| |n| (QREFELT $ 75)))
                    (EXIT
                     (COND
                      ((SPADCALL |r| (|spadConstant| $ 9) (QREFELT $ 24)) |r|)
                      (#1='T
                       (SEQ
                        (COND
                         ((SPADCALL |n| (|spadConstant| $ 9) (QREFELT $ 25))
                          (LETT |n| (SPADCALL |n| (QREFELT $ 17)))))
                        (EXIT
                         (COND
                          ((SPADCALL |r| (|spadConstant| $ 9) (QREFELT $ 14))
                           (COND
                            ((SPADCALL (SPADCALL 2 |r| (QREFELT $ 77)) |n|
                                       (QREFELT $ 14))
                             (SPADCALL |r| |n| (QREFELT $ 62)))
                            (#1# |r|)))
                          ((SPADCALL
                            (SPADCALL (SPADCALL 2 |r| (QREFELT $ 77)) |n|
                                      (QREFELT $ 78))
                            (|spadConstant| $ 9) (QREFELT $ 79))
                           (SPADCALL |r| |n| (QREFELT $ 78)))
                          (#1# |r|)))))))))) 

(SDEFUN |INS-;invmod;3S;28| ((|a| (S)) (|b| (S)) ($ (S)))
        (SPROG
         ((|d1| (S)) (|d| (S)) (|c1| (S)) (|c| (S)) (|r1| (S)) (|r| (S))
          (|q| (S)))
         (SEQ
          (COND
           ((SPADCALL |a| (QREFELT $ 81))
            (LETT |a| (SPADCALL |a| |b| (QREFELT $ 82)))))
          (LETT |c| |a|) (LETT |c1| (|spadConstant| $ 20)) (LETT |d| |b|)
          (LETT |d1| (|spadConstant| $ 9))
          (SEQ G190
               (COND ((NULL (NULL (SPADCALL |d| (QREFELT $ 61)))) (GO G191)))
               (SEQ (LETT |q| (SPADCALL |c| |d| (QREFELT $ 83)))
                    (LETT |r|
                          (SPADCALL |c| (SPADCALL |q| |d| (QREFELT $ 84))
                                    (QREFELT $ 62)))
                    (LETT |r1|
                          (SPADCALL |c1| (SPADCALL |q| |d1| (QREFELT $ 84))
                                    (QREFELT $ 62)))
                    (LETT |c| |d|) (LETT |c1| |d1|) (LETT |d| |r|)
                    (EXIT (LETT |d1| |r1|)))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT
           (COND
            ((SPADCALL |c| (|spadConstant| $ 20) (QREFELT $ 24))
             (COND
              ((SPADCALL |c1| (QREFELT $ 81))
               (SPADCALL |c1| |b| (QREFELT $ 78)))
              (#1='T |c1|)))
            (#1# (|error| "inverse does not exist"))))))) 

(SDEFUN |INS-;powmod;4S;29| ((|x| (S)) (|n| (S)) (|p| (S)) ($ (S)))
        (SPROG ((|z| (S)) (#1=#:G809 NIL) (|y| (S)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |x| (QREFELT $ 81))
                    (LETT |x| (SPADCALL |x| |p| (QREFELT $ 82)))))
                  (EXIT
                   (COND ((SPADCALL |x| (QREFELT $ 61)) (|spadConstant| $ 9))
                         ((SPADCALL |n| (QREFELT $ 61)) (|spadConstant| $ 20))
                         ('T
                          (SEQ (LETT |y| (|spadConstant| $ 20)) (LETT |z| |x|)
                               (EXIT
                                (SEQ G190 NIL
                                     (SEQ
                                      (COND
                                       ((SPADCALL |n| (QREFELT $ 12))
                                        (LETT |y|
                                              (SPADCALL |y| |z| |p|
                                                        (QREFELT $ 86)))))
                                      (EXIT
                                       (COND
                                        ((SPADCALL
                                          (LETT |n|
                                                (SPADCALL |n|
                                                          (SPADCALL
                                                           (|spadConstant| $
                                                                           20)
                                                           (QREFELT $ 17))
                                                          (QREFELT $ 18)))
                                          (QREFELT $ 61))
                                         (PROGN (LETT #1# |y|) (GO #2=#:G808)))
                                        ('T
                                         (LETT |z|
                                               (SPADCALL |z| |z| |p|
                                                         (QREFELT $ 86)))))))
                                     NIL (GO G190) G191 (EXIT NIL)))))))))
                #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |IntegerNumberSystem&;|)) 

(DEFUN |IntegerNumberSystem&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IntegerNumberSystem&| DV$1))
          (LETT $ (GETREFV 88))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IntegerNumberSystem&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              |INS-;characteristic;Nni;1| (0 . |Zero|)
              |INS-;differentiate;2S;2| (|Boolean|) (4 . |odd?|)
              |INS-;even?;SB;3| (9 . >) |INS-;positive?;SB;4| |INS-;copy;2S;5|
              (15 . -) (20 . |shift|) |INS-;bit?;2SB;6| (26 . |One|)
              (30 . |dec|) |INS-;mask;2S;7| |INS-;rational?;SB;8| (35 . =)
              (41 . <) (|Integer|) (47 . |convert|) |INS-;euclideanSize;SNni;9|
              (|Float|) (52 . |coerce|) |INS-;convert;SF;10| (|DoubleFloat|)
              |INS-;convert;SDf;11| (|InputForm|) (57 . |convert|)
              |INS-;convert;SIf;12| |INS-;retract;SI;13| (|Pattern| 26)
              (62 . |coerce|) |INS-;convert;SP;14| (|Factored| 6)
              (|IntegerFactorizationPackage| 6) (67 . |factor|) (|Factored| $)
              |INS-;factor;SF;15| (72 . |squareFree|) |INS-;squareFree;SF;16|
              (|IntegerPrimesPackage| 6) (77 . |prime?|) |INS-;prime?;SB;17|
              (|IntegerCombinatoricFunctions| 6) (82 . |factorial|)
              |INS-;factorial;2S;18| (87 . |binomial|) |INS-;binomial;3S;19|
              (93 . |permutation|) |INS-;permutation;3S;20|
              (|Union| 26 '"failed") |INS-;retractIfCan;SU;21| |INS-;init;S;22|
              (99 . |zero?|) (104 . -) (|Union| $ '#1="failed")
              |INS-;nextItem;SU;23| (|PatternMatchResult| 26 6)
              (|PatternMatchIntegerNumberSystem| 6) (110 . |patternMatch|)
              (|PatternMatchResult| 26 $) |INS-;patternMatch;SP2Pmr;24|
              (|Fraction| 26) (117 . |coerce|) |INS-;rational;SF;25|
              (|Union| 70 '"failed") |INS-;rationalIfCan;SU;26| (122 . |rem|)
              (|PositiveInteger|) (128 . *) (134 . +) (140 . <=)
              |INS-;symmetricRemainder;3S;27| (146 . |negative?|)
              (151 . |positiveRemainder|) (157 . |quo|) (163 . *)
              |INS-;invmod;3S;28| (169 . |mulmod|) |INS-;powmod;4S;29|)
           '#(|symmetricRemainder| 176 |squareFree| 182 |retractIfCan| 187
              |retract| 192 |rationalIfCan| 197 |rational?| 202 |rational| 207
              |prime?| 212 |powmod| 217 |positive?| 224 |permutation| 229
              |patternMatch| 235 |nextItem| 242 |mask| 247 |invmod| 252 |init|
              258 |factorial| 262 |factor| 267 |even?| 272 |euclideanSize| 277
              |differentiate| 282 |copy| 287 |convert| 292 |characteristic| 312
              |bit?| 316 |binomial| 322)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|invmod| (|#1| |#1| |#1|)) T)
                                   '((|powmod| (|#1| |#1| |#1| |#1|)) T)
                                   '((|mask| (|#1| |#1|)) T)
                                   '((|copy| (|#1| |#1|)) T)
                                   '((|rationalIfCan|
                                      ((|Union| (|Fraction| (|Integer|))
                                                "failed")
                                       |#1|))
                                     T)
                                   '((|rational|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|rational?| ((|Boolean|) |#1|)) T)
                                   '((|symmetricRemainder| (|#1| |#1| |#1|)) T)
                                   '((|bit?| ((|Boolean|) |#1| |#1|)) T)
                                   '((|even?| ((|Boolean|) |#1|)) T)
                                   '((|init| (|#1|)) T)
                                   '((|nextItem| ((|Union| |#1| #1#) |#1|)) T)
                                   '((|convert| ((|DoubleFloat|) |#1|)) T)
                                   '((|convert| ((|Float|) |#1|)) T)
                                   '((|permutation| (|#1| |#1| |#1|)) T)
                                   '((|factorial| (|#1| |#1|)) T)
                                   '((|binomial| (|#1| |#1| |#1|)) T)
                                   '((|patternMatch|
                                      ((|PatternMatchResult| (|Integer|) |#1|)
                                       |#1| (|Pattern| (|Integer|))
                                       (|PatternMatchResult| (|Integer|)
                                                             |#1|)))
                                     T)
                                   '((|convert| ((|Pattern| (|Integer|)) |#1|))
                                     T)
                                   '((|convert| ((|InputForm|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) "failed") |#1|))
                                     T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|convert| ((|Integer|) |#1|)) T)
                                   '((|differentiate| (|#1| |#1|)) T)
                                   '((|differentiate|
                                      (|#1| |#1| (|NonNegativeInteger|)))
                                     T)
                                   '((|positive?| ((|Boolean|) |#1|)) T)
                                   '((|euclideanSize|
                                      ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((|factor| ((|Factored| |#1|) |#1|)) T)
                                   '((|squareFree| ((|Factored| |#1|) |#1|)) T)
                                   '((|prime?| ((|Boolean|) |#1|)) T)
                                   '((|characteristic|
                                      ((|NonNegativeInteger|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 87
                                            '(0 6 0 9 1 6 11 0 12 2 6 11 0 0 14
                                              1 6 0 0 17 2 6 0 0 0 18 0 6 0 20
                                              1 6 0 0 21 2 6 11 0 0 24 2 6 11 0
                                              0 25 1 6 26 0 27 1 29 0 26 30 1
                                              34 0 26 35 1 38 0 26 39 1 42 41 6
                                              43 1 42 41 6 46 1 48 11 6 49 1 51
                                              6 6 52 2 51 6 6 6 54 2 51 6 6 6
                                              56 1 6 11 0 61 2 6 0 0 0 62 3 66
                                              65 6 38 65 67 1 70 0 26 71 2 6 0
                                              0 0 75 2 6 0 76 0 77 2 6 0 0 0 78
                                              2 6 11 0 0 79 1 6 11 0 81 2 6 0 0
                                              0 82 2 6 0 0 0 83 2 6 0 0 0 84 3
                                              6 0 0 0 0 86 2 0 0 0 0 80 1 0 44
                                              0 47 1 0 58 0 59 1 0 26 0 37 1 0
                                              73 0 74 1 0 11 0 23 1 0 70 0 72 1
                                              0 11 0 50 3 0 0 0 0 0 87 1 0 11 0
                                              15 2 0 0 0 0 57 3 0 68 0 38 68 69
                                              1 0 63 0 64 1 0 0 0 22 2 0 0 0 0
                                              85 0 0 0 60 1 0 0 0 53 1 0 44 0
                                              45 1 0 11 0 13 1 0 7 0 28 1 0 0 0
                                              10 1 0 0 0 16 1 0 32 0 33 1 0 29
                                              0 31 1 0 38 0 40 1 0 34 0 36 0 0
                                              7 8 2 0 11 0 0 19 2 0 0 0 0
                                              55)))))
           '|lookupComplete|)) 

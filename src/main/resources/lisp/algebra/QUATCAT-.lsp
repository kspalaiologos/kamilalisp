
(SDEFUN |QUATCAT-;characteristic;Nni;1| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 9))) 

(SDEFUN |QUATCAT-;conjugate;2S;2| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 13))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 13))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 13))
                  (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;map;M2S;3| ((|fn| (|Mapping| R R)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 11)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 12)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 14)) |fn|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 15)) |fn|) (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;norm;SR;4| ((|x| (S)) ($ (R)))
        (SPADCALL (SPADCALL |x| (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 21))
                  (QREFELT $ 22))) 

(SDEFUN |QUATCAT-;=;2SB;5| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) (SPADCALL |y| (QREFELT $ 11))
                    (QREFELT $ 25))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 12))
                      (SPADCALL |y| (QREFELT $ 12)) (QREFELT $ 25))
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 14))
                        (SPADCALL |y| (QREFELT $ 14)) (QREFELT $ 25))
              (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                        (SPADCALL |y| (QREFELT $ 15)) (QREFELT $ 25)))
             (#1='T NIL)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |QUATCAT-;+;3S;6| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (SPADCALL |y| (QREFELT $ 11))
                   (QREFELT $ 27))
         (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (SPADCALL |y| (QREFELT $ 12))
                   (QREFELT $ 27))
         (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (SPADCALL |y| (QREFELT $ 14))
                   (QREFELT $ 27))
         (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (SPADCALL |y| (QREFELT $ 15))
                   (QREFELT $ 27))
         (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;-;3S;7| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (SPADCALL |y| (QREFELT $ 11))
                   (QREFELT $ 29))
         (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (SPADCALL |y| (QREFELT $ 12))
                   (QREFELT $ 29))
         (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (SPADCALL |y| (QREFELT $ 14))
                   (QREFELT $ 29))
         (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (SPADCALL |y| (QREFELT $ 15))
                   (QREFELT $ 29))
         (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;-;2S;8| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 13))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 13))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 13))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 13))
                  (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;*;R2S;9| ((|r| (R)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |r| (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 32))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 32))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 32))
                  (SPADCALL |r| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 32))
                  (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;*;I2S;10| ((|n| (|Integer|)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |n| (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 35))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 35))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 35))
                  (SPADCALL |n| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 35))
                  (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;differentiate;SMS;11|
        ((|x| (S)) (|d| (|Mapping| R R)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 11)) |d|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 12)) |d|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 14)) |d|)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 15)) |d|) (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;coerce;RS;12| ((|r| (R)) ($ (S)))
        (SPADCALL |r| (|spadConstant| $ 38) (|spadConstant| $ 38)
                  (|spadConstant| $ 38) (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;coerce;IS;13| ((|n| (|Integer|)) ($ (S)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 40)) (|spadConstant| $ 38)
                  (|spadConstant| $ 38) (|spadConstant| $ 38) (QREFELT $ 16))) 

(SDEFUN |QUATCAT-;one?;SB;14| ((|x| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) (|spadConstant| $ 42)
                    (QREFELT $ 25))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 43))
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 43))
              (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 43)))
             (#1='T NIL)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |QUATCAT-;zero?;SB;15| ((|x| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 43))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 43))
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 43))
              (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 43)))
             (#1='T NIL)))
           (#1# NIL)))
         (#1# NIL))) 

(SDEFUN |QUATCAT-;retract;SR;16| ((|x| (S)) ($ (R)))
        (SEQ
         (COND
          ((SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 43))
           (COND
            ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 43))
             (COND
              ((NULL (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 43)))
               (EXIT (|error| #1="Cannot retract quaternion.")))))
            (#2='T (EXIT (|error| #1#)))))
          (#2# (EXIT (|error| #1#))))
         (EXIT (SPADCALL |x| (QREFELT $ 11))))) 

(SDEFUN |QUATCAT-;retractIfCan;SU;17| ((|x| (S)) ($ (|Union| R "failed")))
        (SEQ
         (COND
          ((SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 43))
           (COND
            ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 43))
             (COND
              ((NULL (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 43)))
               (EXIT (CONS 1 #1="failed")))))
            (#2='T (EXIT (CONS 1 #1#)))))
          (#2# (EXIT (CONS 1 #1#))))
         (EXIT (CONS 0 (SPADCALL |x| (QREFELT $ 11)))))) 

(SDEFUN |QUATCAT-;coerce;SOf;18| ((|x| (S)) ($ (|OutputForm|)))
        (SPROG ((|part| (|OutputForm|)) (|z| (|OutputForm|)) (|y| (S)))
               (SEQ
                (COND
                 ((SPADCALL |x| (QREFELT $ 49))
                  (SPADCALL (|spadConstant| $ 38) (QREFELT $ 51)))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 43)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 38)
                                   (SPADCALL |x| (QREFELT $ 12))
                                   (SPADCALL |x| (QREFELT $ 14))
                                   (SPADCALL |x| (QREFELT $ 15))
                                   (QREFELT $ 16)))
                   (EXIT
                    (COND
                     ((SPADCALL |y| (QREFELT $ 49))
                      (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 51)))
                     (#1='T
                      (SPADCALL
                       (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 51))
                       (SPADCALL |y| (QREFELT $ 52)) (QREFELT $ 53)))))))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 43)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 38) (|spadConstant| $ 38)
                                   (SPADCALL |x| (QREFELT $ 14))
                                   (SPADCALL |x| (QREFELT $ 15))
                                   (QREFELT $ 16)))
                   (LETT |z|
                         (SEQ (LETT |part| (SPADCALL '|i| (QREFELT $ 55)))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |x| (QREFELT $ 12))
                                           (|spadConstant| $ 42)
                                           (QREFELT $ 25))
                                 |part|)
                                (#1#
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 12))
                                            (QREFELT $ 51))
                                  |part| (QREFELT $ 56)))))))
                   (EXIT
                    (COND ((SPADCALL |y| (QREFELT $ 49)) |z|)
                          (#1#
                           (SPADCALL |z| (SPADCALL |y| (QREFELT $ 52))
                                     (QREFELT $ 53)))))))
                 ((NULL
                   (SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 43)))
                  (SEQ
                   (LETT |y|
                         (SPADCALL (|spadConstant| $ 38) (|spadConstant| $ 38)
                                   (|spadConstant| $ 38)
                                   (SPADCALL |x| (QREFELT $ 15))
                                   (QREFELT $ 16)))
                   (LETT |z|
                         (SEQ (LETT |part| (SPADCALL '|j| (QREFELT $ 55)))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |x| (QREFELT $ 14))
                                           (|spadConstant| $ 42)
                                           (QREFELT $ 25))
                                 |part|)
                                (#1#
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 14))
                                            (QREFELT $ 51))
                                  |part| (QREFELT $ 56)))))))
                   (EXIT
                    (COND ((SPADCALL |y| (QREFELT $ 49)) |z|)
                          (#1#
                           (SPADCALL |z| (SPADCALL |y| (QREFELT $ 52))
                                     (QREFELT $ 53)))))))
                 ('T
                  (SEQ (LETT |part| (SPADCALL '|k| (QREFELT $ 55)))
                       (EXIT
                        (COND
                         ((SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                    (|spadConstant| $ 42) (QREFELT $ 25))
                          |part|)
                         (#1#
                          (SPADCALL
                           (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                     (QREFELT $ 51))
                           |part| (QREFELT $ 56))))))))))) 

(SDEFUN |QUATCAT-;inv;2S;19| ((|x| (S)) ($ (S)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 58)) (|spadConstant| $ 38)
                    (QREFELT $ 25))
          (|error| "This quaternion is not invertible."))
         ('T
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 58)) (QREFELT $ 59))
                    (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 60))))) 

(SDEFUN |QUATCAT-;convert;SIf;20| ((|x| (S)) ($ (|InputForm|)))
        (SPROG ((|l| (|List| (|InputForm|))))
               (SEQ
                (LETT |l|
                      (LIST (SPADCALL '|quatern| (QREFELT $ 63))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 11))
                                      (QREFELT $ 64))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 12))
                                      (QREFELT $ 64))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 14))
                                      (QREFELT $ 64))
                            (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                                      (QREFELT $ 64))))
                (EXIT (SPADCALL |l| (QREFELT $ 66)))))) 

(SDEFUN |QUATCAT-;<;2SB;21| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 11)) (SPADCALL |y| (QREFELT $ 11))
                    (QREFELT $ 25))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 12))
                      (SPADCALL |y| (QREFELT $ 12)) (QREFELT $ 25))
            (COND
             ((SPADCALL (SPADCALL |x| (QREFELT $ 14))
                        (SPADCALL |y| (QREFELT $ 14)) (QREFELT $ 25))
              (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                        (SPADCALL |y| (QREFELT $ 15)) (QREFELT $ 68)))
             (#1='T
              (SPADCALL (SPADCALL |x| (QREFELT $ 14))
                        (SPADCALL |y| (QREFELT $ 14)) (QREFELT $ 68)))))
           (#1#
            (SPADCALL (SPADCALL |x| (QREFELT $ 12))
                      (SPADCALL |y| (QREFELT $ 12)) (QREFELT $ 68)))))
         (#1#
          (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (SPADCALL |y| (QREFELT $ 11))
                    (QREFELT $ 68))))) 

(SDEFUN |QUATCAT-;abs;SR;22| ((|x| (S)) ($ (R)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 58)) (QREFELT $ 70))) 

(SDEFUN |QUATCAT-;rational?;SB;23| ((|x| (S)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 43))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 43))
            (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 43)))
           (#1='T NIL)))
         (#1# NIL))) 

(SDEFUN |QUATCAT-;rational;SF;24| ((|x| (S)) ($ (|Fraction| (|Integer|))))
        (COND
         ((SPADCALL |x| (QREFELT $ 73))
          (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 75)))
         ('T (|error| "Not a rational number")))) 

(SDEFUN |QUATCAT-;rationalIfCan;SU;25|
        ((|x| (S)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (COND
         ((SPADCALL |x| (QREFELT $ 73))
          (CONS 0 (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 75))))
         ('T (CONS 1 "failed")))) 

(DECLAIM (NOTINLINE |QuaternionCategory&;|)) 

(DEFUN |QuaternionCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|QuaternionCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 83))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|IntegerNumberSystem|))
                                              (|HasCategory| |#2|
                                                             '(|RealNumberSystem|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| |#2|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#2| '(|Field|))
                                              (|HasCategory| |#2|
                                                             '(|OrderedSet|))
                                              (|HasCategory| |#2|
                                                             '(|EntireRing|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 6)
            (QSETREFV $ 61
                      (CONS (|dispatchFunction| |QUATCAT-;inv;2S;19|) $))))
          (COND
           ((|testBitVector| |pv$| 5)
            (QSETREFV $ 67
                      (CONS (|dispatchFunction| |QUATCAT-;convert;SIf;20|)
                            $))))
          (COND
           ((|testBitVector| |pv$| 7)
            (QSETREFV $ 69 (CONS (|dispatchFunction| |QUATCAT-;<;2SB;21|) $))))
          (COND
           ((|testBitVector| |pv$| 2)
            (QSETREFV $ 71
                      (CONS (|dispatchFunction| |QUATCAT-;abs;SR;22|) $))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 72
                       (CONS (|dispatchFunction| |QUATCAT-;rational?;SB;23|)
                             $))
             (QSETREFV $ 76
                       (CONS (|dispatchFunction| |QUATCAT-;rational;SF;24|) $))
             (QSETREFV $ 78
                       (CONS
                        (|dispatchFunction| |QUATCAT-;rationalIfCan;SU;25|)
                        $)))))
          $))) 

(MAKEPROP '|QuaternionCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|NonNegativeInteger|) (0 . |characteristic|)
              |QUATCAT-;characteristic;Nni;1| (4 . |real|) (9 . |imagI|)
              (14 . -) (19 . |imagJ|) (24 . |imagK|) (29 . |quatern|)
              |QUATCAT-;conjugate;2S;2| (|Mapping| 7 7) |QUATCAT-;map;M2S;3|
              (37 . |conjugate|) (42 . *) (48 . |retract|) |QUATCAT-;norm;SR;4|
              (|Boolean|) (53 . =) |QUATCAT-;=;2SB;5| (59 . +)
              |QUATCAT-;+;3S;6| (65 . -) |QUATCAT-;-;3S;7| |QUATCAT-;-;2S;8|
              (71 . *) |QUATCAT-;*;R2S;9| (|Integer|) (77 . *)
              |QUATCAT-;*;I2S;10| |QUATCAT-;differentiate;SMS;11| (83 . |Zero|)
              |QUATCAT-;coerce;RS;12| (87 . |coerce|) |QUATCAT-;coerce;IS;13|
              (92 . |One|) (96 . |zero?|) |QUATCAT-;one?;SB;14|
              |QUATCAT-;zero?;SB;15| |QUATCAT-;retract;SR;16|
              (|Union| 7 '"failed") |QUATCAT-;retractIfCan;SU;17|
              (101 . |zero?|) (|OutputForm|) (106 . |coerce|) (111 . |coerce|)
              (116 . +) (|Symbol|) (122 . |coerce|) (127 . *)
              |QUATCAT-;coerce;SOf;18| (133 . |norm|) (138 . |inv|) (143 . *)
              (149 . |inv|) (|InputForm|) (154 . |convert|) (159 . |convert|)
              (|List| $) (164 . |convert|) (169 . |convert|) (174 . <)
              (180 . <) (186 . |sqrt|) (191 . |abs|) (196 . |rational?|)
              (201 . |rational?|) (|Fraction| 34) (206 . |rational|)
              (211 . |rational|) (|Union| 74 '#1="failed")
              (216 . |rationalIfCan|) (|List| 54) (|List| 8)
              (|Union| 34 '#2="failed") (|PositiveInteger|))
           '#(|zero?| 221 |retractIfCan| 226 |retract| 231 |rationalIfCan| 236
              |rational?| 241 |rational| 246 |one?| 251 |norm| 256 |map| 261
              |inv| 267 |differentiate| 272 |convert| 278 |conjugate| 283
              |coerce| 288 |characteristic| 303 |abs| 307 = 312 < 318 - 324 +
              335 * 341)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((< ((|Boolean|) |#1| |#1|)) T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((* (|#1| (|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((* (|#1| |#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|inv| (|#1| |#1|)) T)
                                   '((|convert| ((|InputForm|) |#1|)) T)
                                   '((|rationalIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #1#)
                                       |#1|))
                                     T)
                                   '((|rational|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|rational?| ((|Boolean|) |#1|)) T)
                                   '((|abs| (|#2| |#1|)) T)
                                   '((|norm| (|#2| |#1|)) T)
                                   '((|conjugate| (|#1| |#1|)) T)
                                   '((|map| (|#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Mapping| |#2| |#2|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Mapping| |#2| |#2|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Symbol|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))))
                                     T)
                                   '((|differentiate| (|#1| |#1| (|Symbol|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate| (|#1| |#1|)) T)
                                   '((|retractIfCan| ((|Union| |#2| #2#) |#1|))
                                     T)
                                   '((|retract| (|#2| |#1|)) T)
                                   '((|retract|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #2#)
                                       |#1|))
                                     T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) #2#) |#1|))
                                     T)
                                   '((|coerce| (|#1| |#2|)) T)
                                   '((* (|#1| |#2| |#1|)) T)
                                   '((* (|#1| |#1| |#2|)) T)
                                   '((|characteristic|
                                      ((|NonNegativeInteger|)))
                                     T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|one?| ((|Boolean|) |#1|)) T)
                                   '((|zero?| ((|Boolean|) |#1|)) T)
                                   '((* (|#1| (|NonNegativeInteger|) |#1|)) T)
                                   '((- (|#1| |#1|)) T)
                                   '((- (|#1| |#1| |#1|)) T)
                                   '((* (|#1| (|Integer|) |#1|)) T)
                                   '((* (|#1| |#1| |#1|)) T)
                                   '((* (|#1| (|PositiveInteger|) |#1|)) T)
                                   '((+ (|#1| |#1| |#1|)) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((= ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 78
                                            '(0 7 8 9 1 6 7 0 11 1 6 7 0 12 1 7
                                              0 0 13 1 6 7 0 14 1 6 7 0 15 4 6
                                              0 7 7 7 7 16 1 6 0 0 20 2 6 0 0 0
                                              21 1 6 7 0 22 2 7 24 0 0 25 2 7 0
                                              0 0 27 2 7 0 0 0 29 2 7 0 0 0 32
                                              2 7 0 34 0 35 0 7 0 38 1 7 0 34
                                              40 0 7 0 42 1 7 24 0 43 1 6 24 0
                                              49 1 7 50 0 51 1 6 50 0 52 2 50 0
                                              0 0 53 1 54 50 0 55 2 50 0 0 0 56
                                              1 6 7 0 58 1 7 0 0 59 2 6 0 7 0
                                              60 1 0 0 0 61 1 62 0 54 63 1 7 62
                                              0 64 1 62 0 65 66 1 0 62 0 67 2 7
                                              24 0 0 68 2 0 24 0 0 69 1 7 0 0
                                              70 1 0 7 0 71 1 0 24 0 72 1 6 24
                                              0 73 1 7 74 0 75 1 0 74 0 76 1 0
                                              77 0 78 1 0 24 0 45 1 0 47 0 48 1
                                              0 7 0 46 1 0 77 0 78 1 0 24 0 72
                                              1 0 74 0 76 1 0 24 0 44 1 0 7 0
                                              23 2 0 0 18 0 19 1 0 0 0 61 2 0 0
                                              0 18 37 1 0 62 0 67 1 0 0 0 17 1
                                              0 0 7 39 1 0 0 34 41 1 0 50 0 57
                                              0 0 8 10 1 0 7 0 71 2 0 24 0 0 26
                                              2 0 24 0 0 69 2 0 0 0 0 30 1 0 0
                                              0 31 2 0 0 0 0 28 2 0 0 7 0 33 2
                                              0 0 34 0 36)))))
           '|lookupComplete|)) 

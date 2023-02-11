
(SDEFUN |ORDCOMP;convert;$If;1| ((|x| ($)) ($ (|InputForm|)))
        (COND ((QEQCAR |x| 0) (SPADCALL (CDR |x|) (QREFELT $ 9)))
              ((CDR |x|)
               (SPADCALL (LIST (SPADCALL '|plusInfinity| (QREFELT $ 11)))
                         (QREFELT $ 13)))
              ('T
               (SPADCALL (LIST (SPADCALL '|minusInfinity| (QREFELT $ 11)))
                         (QREFELT $ 13))))) 

(PUT '|ORDCOMP;coerce;R$;2| '|SPADreplace| '(XLAM (|r|) (CONS 0 |r|))) 

(SDEFUN |ORDCOMP;coerce;R$;2| ((|r| (R)) ($ ($))) (CONS 0 |r|)) 

(SDEFUN |ORDCOMP;retract;$R;3| ((|x| ($)) ($ (R)))
        (COND ((QEQCAR |x| 0) (CDR |x|)) ('T (|error| "Not finite")))) 

(PUT '|ORDCOMP;finite?;$B;4| '|SPADreplace| '(XLAM (|x|) (QEQCAR |x| 0))) 

(SDEFUN |ORDCOMP;finite?;$B;4| ((|x| ($)) ($ (|Boolean|))) (QEQCAR |x| 0)) 

(PUT '|ORDCOMP;infinite?;$B;5| '|SPADreplace| '(XLAM (|x|) (QEQCAR |x| 1))) 

(SDEFUN |ORDCOMP;infinite?;$B;5| ((|x| ($)) ($ (|Boolean|))) (QEQCAR |x| 1)) 

(SDEFUN |ORDCOMP;plusInfinity;$;6| (($ ($))) (CONS 1 'T)) 

(PUT '|ORDCOMP;minusInfinity;$;7| '|SPADreplace| '(XLAM NIL (CONS 1 NIL))) 

(SDEFUN |ORDCOMP;minusInfinity;$;7| (($ ($))) (CONS 1 NIL)) 

(SDEFUN |ORDCOMP;retractIfCan;$U;8| ((|x| ($)) ($ (|Union| R "failed")))
        (COND ((QEQCAR |x| 0) (CONS 0 (CDR |x|))) ('T (CONS 1 "failed")))) 

(SDEFUN |ORDCOMP;coerce;$Of;9| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG ((|e| (|OutputForm|)))
               (SEQ
                (COND ((QEQCAR |x| 0) (SPADCALL (CDR |x|) (QREFELT $ 25)))
                      (#1='T
                       (SEQ (LETT |e| (SPADCALL '|infinity| (QREFELT $ 26)))
                            (EXIT
                             (COND
                              ((CDR |x|)
                               (SPADCALL (SPADCALL (QREFELT $ 27)) |e|
                                         (QREFELT $ 28)))
                              (#1# (SPADCALL |e| (QREFELT $ 29))))))))))) 

(SDEFUN |ORDCOMP;whatInfinity;$Si;10| ((|x| ($)) ($ (|SingleInteger|)))
        (COND ((QEQCAR |x| 0) 0) ((CDR |x|) 1) ('T -1))) 

(SDEFUN |ORDCOMP;=;2$B;11| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((QEQCAR |x| 1)
          (COND
           ((QEQCAR |y| 1)
            (NULL (SPADCALL (CDR |x|) (CDR |y|) (QREFELT $ 33))))
           (#1='T NIL)))
         ((QEQCAR |y| 1) NIL)
         (#1# (SPADCALL (CDR |x|) (CDR |y|) (QREFELT $ 34))))) 

(SDEFUN |ORDCOMP;-;2$;12| ((|x| ($)) ($ ($)))
        (COND ((QEQCAR |x| 1) (CONS 1 (NULL (CDR |x|))))
              ('T (CONS 0 (SPADCALL (CDR |x|) (QREFELT $ 36)))))) 

(SDEFUN |ORDCOMP;+;3$;13| ((|x| ($)) (|y| ($)) ($ ($)))
        (COND
         ((QEQCAR |x| 1)
          (COND
           ((OR (QEQCAR |y| 0)
                (NULL (SPADCALL (CDR |x|) (CDR |y|) (QREFELT $ 33))))
            |x|)
           ('T (|error| "Undefined sum"))))
         ((QEQCAR |y| 1) |y|)
         ('T (CONS 0 (SPADCALL (CDR |x|) (CDR |y|) (QREFELT $ 38)))))) 

(SDEFUN |ORDCOMP;<;2$B;14| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((QEQCAR |x| 1)
          (COND
           ((QEQCAR |y| 1)
            (COND ((SPADCALL (CDR |x|) (CDR |y|) (QREFELT $ 33)) (CDR |y|))
                  (#1='T NIL)))
           (#1# (NULL (CDR |x|)))))
         ((QEQCAR |y| 1) (CDR |y|))
         (#1# (SPADCALL (CDR |x|) (CDR |y|) (QREFELT $ 40))))) 

(SDEFUN |ORDCOMP;rational?;$B;15| ((|x| ($)) ($ (|Boolean|)))
        (SPADCALL |x| (QREFELT $ 18))) 

(SDEFUN |ORDCOMP;rational;$F;16| ((|x| ($)) ($ (|Fraction| (|Integer|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 44))) 

(SDEFUN |ORDCOMP;rationalIfCan;$U;17|
        ((|x| ($)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 23)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0 (SPADCALL (QCDR |r|) (QREFELT $ 44))))))))) 

(DECLAIM (NOTINLINE |OrderedCompletion;|)) 

(DEFUN |OrderedCompletion| (#1=#:G776)
  (SPROG NIL
         (PROG (#2=#:G777)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|OrderedCompletion|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|OrderedCompletion;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|OrderedCompletion|)))))))))) 

(DEFUN |OrderedCompletion;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|OrderedCompletion| DV$1))
          (LETT $ (GETREFV 52))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| |#1|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#1|
                                                             '(|OrderedSet|))
                                              (|HasCategory| |#1|
                                                             '(|AbelianMonoid|))
                                              (|HasCategory| |#1|
                                                             '(|AbelianGroup|))
                                              (|HasCategory| |#1|
                                                             '(|IntegerNumberSystem|))))))
          (|haddProp| |$ConstructorCache| '|OrderedCompletion| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|Union| (|:| |fin| |#1|) (|:| |inf| (|Boolean|))))
          (COND
           ((|testBitVector| |pv$| 3)
            (QSETREFV $ 14
                      (CONS (|dispatchFunction| |ORDCOMP;convert;$If;1|) $))))
          (COND
           ((|testBitVector| |pv$| 6)
            (QSETREFV $ 37 (CONS (|dispatchFunction| |ORDCOMP;-;2$;12|) $))))
          (COND
           ((|testBitVector| |pv$| 5)
            (QSETREFV $ 39 (CONS (|dispatchFunction| |ORDCOMP;+;3$;13|) $))))
          (COND
           ((|testBitVector| |pv$| 4)
            (QSETREFV $ 41 (CONS (|dispatchFunction| |ORDCOMP;<;2$B;14|) $))))
          (COND
           ((|testBitVector| |pv$| 7)
            (PROGN
             (QSETREFV $ 42
                       (CONS (|dispatchFunction| |ORDCOMP;rational?;$B;15|) $))
             (QSETREFV $ 45
                       (CONS (|dispatchFunction| |ORDCOMP;rational;$F;16|) $))
             (QSETREFV $ 47
                       (CONS (|dispatchFunction| |ORDCOMP;rationalIfCan;$U;17|)
                             $)))))
          $))) 

(MAKEPROP '|OrderedCompletion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|InputForm|)
              (0 . |convert|) (|Symbol|) (5 . |convert|) (|List| $)
              (10 . |convert|) (15 . |convert|) |ORDCOMP;coerce;R$;2|
              |ORDCOMP;retract;$R;3| (|Boolean|) |ORDCOMP;finite?;$B;4|
              |ORDCOMP;infinite?;$B;5| |ORDCOMP;plusInfinity;$;6|
              |ORDCOMP;minusInfinity;$;7| (|Union| 6 '"failed")
              |ORDCOMP;retractIfCan;$U;8| (|OutputForm|) (20 . |coerce|)
              (25 . |coerce|) (30 . |empty|) (34 . +) (40 . -)
              |ORDCOMP;coerce;$Of;9| (|SingleInteger|)
              |ORDCOMP;whatInfinity;$Si;10| (45 . |xor|) (51 . =)
              |ORDCOMP;=;2$B;11| (57 . -) (62 . -) (67 . +) (73 . +) (79 . <)
              (85 . <) (91 . |rational?|) (|Fraction| 49) (96 . |rational|)
              (101 . |rational|) (|Union| 43 '"failed") (106 . |rationalIfCan|)
              (|Union| 49 '"failed") (|Integer|) (|String|) (|HashState|))
           '#(~= 111 |whatInfinity| 117 |smaller?| 122 |retractIfCan| 128
              |retract| 143 |rationalIfCan| 158 |rational?| 163 |rational| 168
              |plusInfinity| 173 |minusInfinity| 177 |min| 181 |max| 187
              |latex| 193 |infinite?| 198 |hashUpdate!| 203 |hash| 209
              |finite?| 214 |convert| 219 |coerce| 224 >= 244 > 250 = 256 <=
              262 < 268 - 274 + 279)
           'NIL
           (CONS (|makeByteWordVec2| 4 '(4 0 4 0 0 1 2 0 0 0 1 2 3 4))
                 (CONS
                  '#(|OrderedSet&| |FullyRetractableTo&| NIL |SetCategory&|
                     |RetractableTo&| |RetractableTo&| |RetractableTo&|
                     |BasicType&| NIL NIL NIL NIL NIL |PartialOrder&|)
                  (CONS
                   '#((|OrderedSet|) (|FullyRetractableTo| 6) (|Comparable|)
                      (|SetCategory|) (|RetractableTo| 6) (|RetractableTo| 43)
                      (|RetractableTo| 49) (|BasicType|) (|CoercibleFrom| 6)
                      (|CoercibleTo| 24) (|CoercibleFrom| 43)
                      (|CoercibleFrom| 49) (|ConvertibleTo| 8)
                      (|PartialOrder|))
                   (|makeByteWordVec2| 51
                                       '(1 6 8 0 9 1 8 0 10 11 1 8 0 12 13 1 0
                                         8 0 14 1 6 24 0 25 1 10 24 0 26 0 24 0
                                         27 2 24 0 0 0 28 1 24 0 0 29 2 17 0 0
                                         0 33 2 6 17 0 0 34 1 6 0 0 36 1 0 0 0
                                         37 2 6 0 0 0 38 2 0 0 0 0 39 2 6 17 0
                                         0 40 2 0 17 0 0 41 1 0 17 0 42 1 6 43
                                         0 44 1 0 43 0 45 1 0 46 0 47 2 0 17 0
                                         0 1 1 0 31 0 32 2 4 17 0 0 1 1 1 46 0
                                         1 1 2 48 0 1 1 0 22 0 23 1 1 43 0 1 1
                                         2 49 0 1 1 0 6 0 16 1 7 46 0 47 1 7 17
                                         0 42 1 7 43 0 45 0 0 0 20 0 0 0 21 2 4
                                         0 0 0 1 2 4 0 0 0 1 1 0 50 0 1 1 0 17
                                         0 19 2 0 51 51 0 1 1 0 31 0 1 1 0 17 0
                                         18 1 3 8 0 14 1 1 0 43 1 1 2 0 49 1 1
                                         0 0 6 15 1 0 24 0 30 2 4 17 0 0 1 2 4
                                         17 0 0 1 2 0 17 0 0 35 2 4 17 0 0 1 2
                                         4 17 0 0 41 1 6 0 0 37 2 5 0 0 0
                                         39)))))
           '|lookupComplete|)) 

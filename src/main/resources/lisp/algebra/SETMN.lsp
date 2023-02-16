
(SDEFUN |SETMN;=;2$B;1| ((|s1| ($)) (|s2| ($)) ($ (|Boolean|)))
        (SPADCALL (QCAR |s1|) (QCAR |s2|) (QREFELT $ 15))) 

(SDEFUN |SETMN;coerce;$Of;2| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G722 NIL) (|i| NIL) (#2=#:G721 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |i| NIL) (LETT #1# (SPADCALL |s| (QREFELT $ 18)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |i| (QREFELT $ 21)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 23))))) 

(SDEFUN |SETMN;reallyEnumerate| (($ (|Vector| $)))
        (SPROG
         ((#1=#:G728 NIL) (|i| NIL) (#2=#:G730 NIL) (|b| NIL) (#3=#:G729 NIL))
         (SEQ
          (PROGN
           (LETT #3#
                 (GETREFV
                  (SIZE
                   #4=(|SETMN;enum| (QREFELT $ 6) (QREFELT $ 7) (QREFELT $ 7)
                       $))))
           (SEQ (LETT |b| NIL) (LETT #2# #4#) (LETT |i| 1) (LETT #1# 0) G190
                (COND
                 ((OR (ATOM #2#) (PROGN (LETT |b| (CAR #2#)) NIL)) (GO G191)))
                (SEQ (EXIT (SETELT #3# #1# (CONS |b| |i|))))
                (LETT #1#
                      (PROG1 (|inc_SI| #1#)
                        (LETT |i|
                              (PROG1 (|inc_SI| |i|) (LETT #2# (CDR #2#))))))
                (GO G190) G191 (EXIT NIL))
           #3#)))) 

(SDEFUN |SETMN;member?;Pi$B;4|
        ((|p| (|PositiveInteger|)) (|s| ($)) ($ (|Boolean|)))
        (SPADCALL (QCAR |s|) |p| (QREFELT $ 26))) 

(SDEFUN |SETMN;enumerate;V;5| (($ (|Vector| $)))
        (SEQ
         (COND
          ((SPADCALL (QREFELT $ 11) (QREFELT $ 28))
           (SETELT $ 11 (|SETMN;reallyEnumerate| $))))
         (EXIT (QREFELT $ 11)))) 

(SDEFUN |SETMN;enum|
        ((|p| (|NonNegativeInteger|)) (|q| (|NonNegativeInteger|))
         (|n| (|PositiveInteger|)) ($ (|List| (|Bits|))))
        (SPROG
         ((#1=#:G750 NIL) (|s| NIL) (|l| (|List| (|Bits|))) (#2=#:G742 NIL)
          (|q1| (|NonNegativeInteger|)) (#3=#:G741 NIL) (#4=#:G749 NIL)
          (|i| NIL) (|b| (|Bits|)))
         (SEQ
          (COND ((OR (ZEROP |p|) (ZEROP |q|)) NIL)
                ('T
                 (COND
                  ((EQL |p| |q|)
                   (SEQ (LETT |b| (SPADCALL (QREFELT $ 7) NIL (QREFELT $ 32)))
                        (SEQ (LETT |i| 1) (LETT #4# |p|) G190
                             (COND ((|greater_SI| |i| #4#) (GO G191)))
                             (SEQ (EXIT (SPADCALL |b| |i| 'T (QREFELT $ 33))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT (LIST |b|))))
                  ('T
                   (SEQ
                    (LETT |q1|
                          (PROG1 (LETT #3# (- |q| 1))
                            (|check_subtype2| (>= #3# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #3#)))
                    (LETT |l|
                          (|SETMN;enum|
                           (PROG1 (LETT #2# (- |p| 1))
                             (|check_subtype2| (>= #2# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #2#))
                           |q1| (QREFELT $ 7) $))
                    (COND
                     ((NULL |l|)
                      (LETT |l|
                            (LIST
                             (SPADCALL (QREFELT $ 7) NIL (QREFELT $ 32))))))
                    (SEQ (LETT |s| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ (EXIT (SPADCALL |s| |q| 'T (QREFELT $ 33))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL (|SETMN;enum| |p| |q1| (QREFELT $ 7) $) |l|
                               (QREFELT $ 35))))))))))) 

(SDEFUN |SETMN;size;Nni;7| (($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G751 NIL))
               (SEQ
                (COND
                 ((ZEROP (QREFELT $ 12))
                  (SETELT $ 12
                          (PROG1
                              (LETT #1#
                                    (SPADCALL (QREFELT $ 7) (QREFELT $ 6)
                                              (QREFELT $ 37)))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#)))))
                (EXIT (QREFELT $ 12))))) 

(SDEFUN |SETMN;lookup;$Pi;8| ((|s| ($)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G758 NIL) (#2=#:G756 NIL))
               (SEQ
                (COND
                 ((SPADCALL (QREFELT $ 11) (QREFELT $ 28))
                  (SETELT $ 11 (|SETMN;reallyEnumerate| $))))
                (COND
                 ((ZEROP (QCDR |s|))
                  (PROGN
                   (RPLACD |s|
                           (PROG1
                               (LETT #2#
                                     (SPADCALL |s| (QREFELT $ 11)
                                               (QREFELT $ 39)))
                             (|check_subtype2| (>= #2# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #2#)))
                   (QCDR |s|))))
                (EXIT
                 (PROG1 (LETT #1# (QCDR |s|))
                   (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                     '(|NonNegativeInteger|) #1#)))))) 

(SDEFUN |SETMN;index;Pi$;9| ((|p| (|PositiveInteger|)) ($ ($)))
        (SEQ
         (COND
          ((> |p| (SPADCALL (QREFELT $ 38)))
           (|error| "index: argument too large"))
          ('T
           (SEQ
            (COND
             ((SPADCALL (QREFELT $ 11) (QREFELT $ 28))
              (SETELT $ 11 (|SETMN;reallyEnumerate| $))))
            (EXIT (SPADCALL (QREFELT $ 11) |p| (QREFELT $ 41)))))))) 

(SDEFUN |SETMN;setOfMinN;L$;10| ((|l| (|List| (|PositiveInteger|))) ($ ($)))
        (SPROG
         ((|count| (|NonNegativeInteger|)) (#1=#:G772 NIL) (|i| NIL)
          (|s| (|Bits|)))
         (SEQ (LETT |s| (SPADCALL (QREFELT $ 7) NIL (QREFELT $ 32)))
              (LETT |count| 0)
              (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |count| (+ |count| 1))
                        (COND
                         ((OR (> |count| (QREFELT $ 6))
                              (OR (OR (ZEROP |i|) (> |i| (QREFELT $ 7)))
                                  (SPADCALL |s| |i| (QREFELT $ 26))))
                          (EXIT
                           (|error| "setOfMinN: improper set of integers"))))
                        (EXIT (SPADCALL |s| |i| 'T (QREFELT $ 33))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((< |count| (QREFELT $ 6))
                 (|error| "setOfMinN: improper set of integers"))
                ('T (CONS |s| 0))))))) 

(SDEFUN |SETMN;elements;$L;11| ((|s| ($)) ($ (|List| (|PositiveInteger|))))
        (SPROG
         ((|i| (|PositiveInteger|)) (|found| (|NonNegativeInteger|))
          (|l| (|List| (|PositiveInteger|))) (|b| (|Bits|)))
         (SEQ (LETT |b| (QCAR |s|)) (LETT |l| NIL) (LETT |found| 0)
              (LETT |i| 1)
              (SEQ G190 (COND ((NULL (< |found| (QREFELT $ 6))) (GO G191)))
                   (SEQ
                    (COND
                     ((SPADCALL |b| |i| (QREFELT $ 26))
                      (SEQ (LETT |l| (CONS |i| |l|))
                           (EXIT (LETT |found| (+ |found| 1))))))
                    (EXIT (LETT |i| (+ |i| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |l|))))) 

(SDEFUN |SETMN;incrementKthElement;$PiU;12|
        ((|s| ($)) (|k| (|PositiveInteger|)) ($ (|Union| $ "failed")))
        (SPROG
         ((#1=#:G789 NIL) (|newb| (|Bits|)) (|i| (|NonNegativeInteger|))
          (|found| (|NonNegativeInteger|)) (|b| (|Bits|)))
         (SEQ (LETT |b| (QCAR |s|)) (LETT |found| 0) (LETT |i| 1)
              (SEQ G190 (COND ((NULL (< |found| |k|)) (GO G191)))
                   (SEQ
                    (COND
                     ((SPADCALL |b| |i| (QREFELT $ 26))
                      (LETT |found| (+ |found| 1))))
                    (EXIT (LETT |i| (+ |i| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND
               ((OR (> |i| (QREFELT $ 7)) (SPADCALL |b| |i| (QREFELT $ 26)))
                (EXIT (CONS 1 "failed"))))
              (LETT |newb| (SPADCALL |b| (QREFELT $ 44)))
              (SPADCALL |newb| |i| 'T (QREFELT $ 33))
              (SPADCALL |newb|
                        (PROG1 (LETT #1# (- |i| 1))
                          (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #1#))
                        NIL (QREFELT $ 33))
              (EXIT (CONS 0 (CONS |newb| 0)))))) 

(SDEFUN |SETMN;delta;$2PiNni;13|
        ((|s| ($)) (|k| (|PositiveInteger|)) (|p| (|PositiveInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((|i| (|PositiveInteger|)) (|count| #1=(|NonNegativeInteger|))
          (|found| #1#) (|b| (|Bits|)))
         (SEQ (LETT |b| (QCAR |s|)) (LETT |count| (LETT |found| 0))
              (LETT |i| 1)
              (SEQ G190 (COND ((NULL (< |found| |k|)) (GO G191)))
                   (SEQ
                    (COND
                     ((SPADCALL |b| |i| (QREFELT $ 26))
                      (SEQ (LETT |found| (+ |found| 1))
                           (EXIT
                            (COND
                             ((> |i| |p|)
                              (COND
                               ((< |found| |k|)
                                (LETT |count| (+ |count| 1))))))))))
                    (EXIT (LETT |i| (+ |i| 1))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |count|)))) 

(SDEFUN |SETMN;replaceKthElement;$2PiU;14|
        ((|s| ($)) (|k| (|PositiveInteger|)) (|p| (|PositiveInteger|))
         ($ (|Union| $ "failed")))
        (SPROG
         ((|newb| (|Bits|)) (|i| (|PositiveInteger|))
          (|found| (|NonNegativeInteger|)) (|b| (|Bits|)))
         (SEQ (LETT |b| (QCAR |s|)) (LETT |found| 0) (LETT |i| 1)
              (SEQ G190 (COND ((NULL (< |found| |k|)) (GO G191)))
                   (SEQ
                    (COND
                     ((SPADCALL |b| |i| (QREFELT $ 26))
                      (LETT |found| (+ |found| 1))))
                    (EXIT (COND ((< |found| |k|) (LETT |i| (+ |i| 1))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (COND
               ((SPADCALL |b| |p| (QREFELT $ 26))
                (COND
                 ((SPADCALL |i| |p| (QREFELT $ 48))
                  (EXIT (CONS 1 "failed"))))))
              (LETT |newb| (SPADCALL |b| (QREFELT $ 44)))
              (SPADCALL |newb| |p| 'T (QREFELT $ 33))
              (SPADCALL |newb| |i| NIL (QREFELT $ 33))
              (EXIT
               (CONS 0
                     (CONS |newb| (COND ((EQL |i| |p|) (QCDR |s|)) ('T 0)))))))) 

(DECLAIM (NOTINLINE |SetOfMIntegersInOneToN;|)) 

(DEFUN |SetOfMIntegersInOneToN| (&REST #1=#:G814)
  (SPROG NIL
         (PROG (#2=#:G815)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL NIL))
                                               (HGET |$ConstructorCache|
                                                     '|SetOfMIntegersInOneToN|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SetOfMIntegersInOneToN;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|SetOfMIntegersInOneToN|)))))))))) 

(DEFUN |SetOfMIntegersInOneToN;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 |#2|)
          (LETT |dv$| (LIST '|SetOfMIntegersInOneToN| DV$1 DV$2))
          (LETT $ (GETREFV 54))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SetOfMIntegersInOneToN|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8
                    (|Record| (|:| |bits| (|Bits|))
                              (|:| |pos| (|NonNegativeInteger|))))
          (QSETREFV $ 11 (SPADCALL (QREFELT $ 10)))
          (QSETREFV $ 12 0)
          $))) 

(MAKEPROP '|SetOfMIntegersInOneToN| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|Vector| $$) (0 . |empty|) '|all| '|sz| (|Boolean|) (|Bits|)
              (4 . =) |SETMN;=;2$B;1| (|List| 20) |SETMN;elements;$L;11|
              (|OutputForm|) (|PositiveInteger|) (10 . |coerce|) (|List| $)
              (15 . |brace|) |SETMN;coerce;$Of;2| (|Integer|) (20 . |elt|)
              |SETMN;member?;Pi$B;4| (26 . |empty?|) (|Vector| $)
              |SETMN;enumerate;V;5| (|NonNegativeInteger|) (31 . |new|)
              (37 . |setelt!|) (|List| 14) (44 . |concat!|)
              (|IntegerCombinatoricFunctions| 25) (50 . |binomial|)
              |SETMN;size;Nni;7| (56 . |position|) |SETMN;lookup;$Pi;8|
              (62 . |elt|) |SETMN;index;Pi$;9| |SETMN;setOfMinN;L$;10|
              (68 . |copy|) (|Union| $ '"failed")
              |SETMN;incrementKthElement;$PiU;12| |SETMN;delta;$2PiNni;13|
              (73 . ~=) |SETMN;replaceKthElement;$2PiU;14| (|String|)
              (|InputForm|) (|SingleInteger|) (|HashState|))
           '#(~= 79 |smaller?| 85 |size| 91 |setOfMinN| 95 |replaceKthElement|
              100 |random| 107 |member?| 111 |lookup| 117 |latex| 122 |index|
              127 |incrementKthElement| 132 |hashUpdate!| 138 |hash| 144
              |enumerate| 149 |elements| 157 |delta| 162 |convert| 169 |coerce|
              174 = 179)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0))
                 (CONS '#(|Finite&| NIL |SetCategory&| |BasicType&| NIL NIL)
                       (CONS
                        '#((|Finite|) (|Comparable|) (|SetCategory|)
                           (|BasicType|) (|ConvertibleTo| 51)
                           (|CoercibleTo| 19))
                        (|makeByteWordVec2| 53
                                            '(0 9 0 10 2 14 13 0 0 15 1 20 19 0
                                              21 1 19 0 22 23 2 14 13 0 25 26 1
                                              9 13 0 28 2 14 0 31 13 32 3 14 13
                                              0 25 13 33 2 34 0 0 0 35 2 36 25
                                              25 25 37 2 9 25 2 0 39 2 9 2 0 25
                                              41 1 14 0 0 44 2 20 13 0 0 48 2 0
                                              13 0 0 1 2 0 13 0 0 1 0 0 31 38 1
                                              0 0 17 43 3 0 45 0 20 20 49 0 0 0
                                              1 2 0 13 20 0 27 1 0 20 0 40 1 0
                                              50 0 1 1 0 0 20 42 2 0 45 0 20 46
                                              2 0 53 53 0 1 1 0 52 0 1 0 0 29
                                              30 0 0 22 1 1 0 17 0 18 3 0 31 0
                                              20 20 47 1 0 51 0 1 1 0 19 0 24 2
                                              0 13 0 0 16)))))
           '|lookupComplete|)) 

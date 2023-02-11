
(SDEFUN |SCACHE;expandCache| ((|x| (S)) ($ (|Void|)))
        (SPROG ((#1=#:G713 NIL) (|k| NIL) (|ocache| (|PrimitiveArray| S)))
               (SEQ
                (COND
                 ((EQL (QREFELT $ 8) (QREFELT $ 9))
                  (SEQ (LETT |ocache| (QREFELT $ 7))
                       (SETELT $ 8 (+ (* 2 (QREFELT $ 8)) 10))
                       (SETELT $ 7 (MAKEARR1 (QREFELT $ 8) |x|))
                       (EXIT
                        (SEQ (LETT |k| 0) (LETT #1# (- (QREFELT $ 9) 1)) G190
                             (COND ((|greater_SI| |k| #1#) (GO G191)))
                             (SEQ
                              (EXIT
                               (QSETAREF1 (QREFELT $ 7) |k|
                                          (QAREF1 |ocache| |k|))))
                             (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                             (EXIT NIL))))))
                (EXIT (SPADCALL (QREFELT $ 11)))))) 

(SDEFUN |SCACHE;insertBefore|
        ((|l| (|NonNegativeInteger|)) (|x| (S)) ($ (|Void|)))
        (SPROG ((#1=#:G718 NIL) (|k| NIL) (|vscan| (|PrimitiveArray| S)))
               (SEQ (|SCACHE;expandCache| |x| $) (LETT |vscan| (QREFELT $ 7))
                    (SEQ (LETT |k| 0) (LETT #1# (- (- (QREFELT $ 9) |l|) 1))
                         G190 (COND ((|greater_SI| |k| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 |vscan| (- (QREFELT $ 9) |k|)
                                      (QAREF1 |vscan|
                                              (- (- (QREFELT $ 9) |k|) 1)))))
                         (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 |vscan| |l| |x|)
                    (SETELT $ 9 (+ (QREFELT $ 9) 1))
                    (EXIT (SPADCALL (QREFELT $ 11)))))) 

(SDEFUN |SCACHE;shiftCache|
        ((|l| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|))
         ($ (|Void|)))
        (SPROG
         ((|x| (S)) (#1=#:G724 NIL) (|k| NIL) (|vscan| (|PrimitiveArray| S)))
         (SEQ (LETT |vscan| (QREFELT $ 7))
              (SEQ (LETT |k| |l|) (LETT #1# (- (QREFELT $ 9) 1)) G190
                   (COND ((> |k| #1#) (GO G191)))
                   (SEQ (LETT |x| (QAREF1 |vscan| |k|))
                        (EXIT
                         (SPADCALL |x| (+ |n| (SPADCALL |x| (QREFELT $ 13)))
                                   (QREFELT $ 14))))
                   (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL (QREFELT $ 11)))))) 

(SDEFUN |SCACHE;clearCache;V;4| (($ (|Void|)))
        (SPROG
         ((|x| (S)) (#1=#:G730 NIL) (|k| NIL) (|vscan| (|PrimitiveArray| S)))
         (SEQ (LETT |vscan| (QREFELT $ 7))
              (SEQ (LETT |k| 0) (LETT #1# (- (QREFELT $ 9) 1)) G190
                   (COND ((|greater_SI| |k| #1#) (GO G191)))
                   (SEQ (LETT |x| (QAREF1 |vscan| |k|))
                        (EXIT (SPADCALL |x| 0 (QREFELT $ 14))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (SETELT $ 7 (MAKE-ARRAY 0)) (SETELT $ 8 0) (SETELT $ 9 0)
              (EXIT (SPADCALL (QREFELT $ 11)))))) 

(SDEFUN |SCACHE;insertAtEnd| ((|x| (S)) ($ (|Void|)))
        (SEQ (|SCACHE;expandCache| |x| $)
             (QSETAREF1 (QREFELT $ 7) (QREFELT $ 9) |x|)
             (SETELT $ 9 (+ (QREFELT $ 9) 1)) (EXIT (SPADCALL (QREFELT $ 11))))) 

(SDEFUN |SCACHE;linearSearch;SMU;6|
        ((|x| (S)) (|equal?| (|Mapping| (|Boolean|) S))
         ($ (|Union| S "failed")))
        (SPROG
         ((#1=#:G749 NIL) (|k| (|Integer|)) (|vscan| (|PrimitiveArray| S))
          (|y| (S)))
         (SEQ
          (EXIT
           (SEQ (LETT |k| 0)
                (SEQ G190 (COND ((NULL (< |k| (QREFELT $ 9))) (GO G191)))
                     (SEQ (LETT |vscan| (QREFELT $ 7))
                          (LETT |y| (QAREF1 |vscan| |k|))
                          (EXIT
                           (COND
                            ((SPADCALL |y| |equal?|)
                             (PROGN (LETT #1# (CONS 0 |y|)) (GO #2=#:G748)))
                            ('T
                             (SEQ (LETT |vscan| (QREFELT $ 7))
                                  (SEQ G190
                                       (COND
                                        ((NULL
                                          (NULL (EQ |y| (QAREF1 |vscan| |k|))))
                                         (GO G191)))
                                       (SEQ (EXIT (LETT |k| (+ |k| 1)))) NIL
                                       (GO G190) G191 (EXIT NIL))
                                  (EXIT (LETT |k| (+ |k| 1))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (PROGN (LETT #1# (CONS 1 "failed")) (GO #2#)))))
          #2# (EXIT #1#)))) 

(SDEFUN |SCACHE;enterInCache;SMS;7|
        ((|x| (S)) (|equal?| (|Mapping| (|Boolean|) S)) ($ (S)))
        (SPROG ((|res| (|Union| S "failed")))
               (SEQ (LETT |res| (SPADCALL |x| |equal?| (QREFELT $ 18)))
                    (EXIT
                     (COND ((QEQCAR |res| 0) (QCDR |res|))
                           ('T
                            (SEQ
                             (SPADCALL |x| (+ 1 (QREFELT $ 9)) (QREFELT $ 14))
                             (|SCACHE;insertAtEnd| |x| $) (EXIT |x|)))))))) 

(SDEFUN |SCACHE;binarySearch;SMU;8|
        ((|x| (S)) (|triage| (|Mapping| (|Integer|) S S))
         ($ (|Union| S "failed")))
        (SPROG
         ((|l| #1=(|Integer|)) (|m| #2=(|Integer|)) (|i| #3=(|Integer|))
          (|i0| #3#) (|l0| #1#) (|vscan| (|PrimitiveArray| S)) (#4=#:G784 NIL)
          (|cp| (|Integer|)) (|y| (S)) (|has_vm| (|Boolean|)) (|vm| (S))
          (|vl| (S)) (|m0| #2#))
         (SEQ
          (EXIT
           (COND ((ZEROP (QREFELT $ 9)) (CONS 1 "failed"))
                 ('T
                  (SEQ
                   (SEQ (LETT |vscan| (QREFELT $ 7)) (LETT |l| -1)
                        (LETT |m| (QREFELT $ 9)) (LETT |m0| |m|)
                        (EXIT
                         (SEQ G190 (COND ((NULL (< (+ |l| 1) |m|)) (GO G191)))
                              (SEQ (LETT |m0| (QREFELT $ 9))
                                   (COND
                                    ((NULL (< |l| 0))
                                     (LETT |vl| (QAREF1 |vscan| |l|))))
                                   (LETT |has_vm| NIL)
                                   (COND
                                    ((< |m| |m0|)
                                     (SEQ (LETT |vm| (QAREF1 |vscan| |m|))
                                          (EXIT (LETT |has_vm| 'T)))))
                                   (LETT |i| (ASH (+ |l| |m|) -1))
                                   (LETT |cp|
                                         (SPADCALL |x|
                                                   (LETT |y|
                                                         (QAREF1 |vscan| |i|))
                                                   |triage|))
                                   (EXIT
                                    (COND
                                     ((ZEROP |cp|)
                                      (PROGN
                                       (LETT #4# (CONS 0 |y|))
                                       (GO #5=#:G783)))
                                     ('T
                                      (SEQ (LETT |vscan| (QREFELT $ 7))
                                           (COND
                                            ((NULL (< |l| 0))
                                             (COND
                                              ((NULL
                                                (EQ |vl| (QAREF1 |vscan| |l|)))
                                               (SEQ (LETT |l0| |l|)
                                                    (SEQ G190
                                                         (COND
                                                          ((NULL
                                                            (NULL
                                                             (EQ |vl|
                                                                 (QAREF1
                                                                  |vscan|
                                                                  |l|))))
                                                           (GO G191)))
                                                         (SEQ
                                                          (EXIT
                                                           (LETT |l|
                                                                 (+ |l| 1))))
                                                         NIL (GO G190) G191
                                                         (EXIT NIL))
                                                    (LETT |i|
                                                          (- (+ |i| |l|) |l0|))
                                                    (EXIT
                                                     (LETT |m|
                                                           (- (+ |m| |l|)
                                                              |l0|))))))))
                                           (COND
                                            ((NULL
                                              (EQ |y| (QAREF1 |vscan| |i|)))
                                             (SEQ (LETT |i0| |i|)
                                                  (SEQ G190
                                                       (COND
                                                        ((NULL
                                                          (NULL
                                                           (EQ |y|
                                                               (QAREF1 |vscan|
                                                                       |i|))))
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (LETT |i| (+ |i| 1))))
                                                       NIL (GO G190) G191
                                                       (EXIT NIL))
                                                  (EXIT
                                                   (LETT |m|
                                                         (- (+ |m| |i|)
                                                            |i0|))))))
                                           (COND
                                            (|has_vm|
                                             (COND
                                              ((NULL
                                                (EQ |vm| (QAREF1 |vscan| |m|)))
                                               (SEQ G190
                                                    (COND
                                                     ((NULL
                                                       (NULL
                                                        (EQ |vm|
                                                            (QAREF1 |vscan|
                                                                    |m|))))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (LETT |m| (+ |m| 1))))
                                                    NIL (GO G190) G191
                                                    (EXIT NIL))))))
                                           (EXIT
                                            (COND ((< |cp| 0) (LETT |m| |i|))
                                                  ('T (LETT |l| |i|)))))))))
                              NIL (GO G190) G191 (EXIT NIL))))
                   (EXIT (CONS 1 "failed"))))))
          #5# (EXIT #4#)))) 

(SDEFUN |SCACHE;enterInCache;SMS;9|
        ((|x| (S)) (|triage| (|Mapping| (|Integer|) S S)) ($ (S)))
        (SPROG
         ((#1=#:G807 NIL) (|pos| (|NonNegativeInteger|)) (#2=#:G812 NIL)
          (|l| #3=(|Integer|)) (|m| #4=(|Integer|)) (|i| #5=(|Integer|))
          (|i0| #5#) (|l0| #3#) (|vscan| (|PrimitiveArray| S))
          (|cp| (|Integer|)) (|y| (S)) (|has_vm| (|Boolean|)) (|vm| (S))
          (|vl| (S)) (|m0| #4#))
         (SEQ
          (EXIT
           (COND
            ((ZEROP (QREFELT $ 9))
             (SEQ (SPADCALL |x| 1024 (QREFELT $ 14))
                  (|SCACHE;insertAtEnd| |x| $)
                  (EXIT (PROGN (LETT #2# |x|) (GO #6=#:G811)))))
            (#7='T
             (SEQ
              (SEQ (LETT |vscan| (QREFELT $ 7)) (LETT |l| -1)
                   (LETT |m| (QREFELT $ 9)) (LETT |m0| |m|)
                   (EXIT
                    (SEQ G190 (COND ((NULL (< (+ |l| 1) |m|)) (GO G191)))
                         (SEQ (LETT |m0| (QREFELT $ 9))
                              (COND
                               ((NULL (< |l| 0))
                                (LETT |vl| (QAREF1 |vscan| |l|))))
                              (LETT |has_vm| NIL)
                              (COND
                               ((< |m| |m0|)
                                (SEQ (LETT |vm| (QAREF1 |vscan| |m|))
                                     (EXIT (LETT |has_vm| 'T)))))
                              (LETT |i| (ASH (+ |l| |m|) -1))
                              (LETT |cp|
                                    (SPADCALL |x|
                                              (LETT |y| (QAREF1 |vscan| |i|))
                                              |triage|))
                              (EXIT
                               (COND
                                ((ZEROP |cp|) (PROGN (LETT #2# |y|) (GO #6#)))
                                ('T
                                 (SEQ (LETT |vscan| (QREFELT $ 7))
                                      (COND
                                       ((NULL (< |l| 0))
                                        (COND
                                         ((NULL (EQ |vl| (QAREF1 |vscan| |l|)))
                                          (SEQ (LETT |l0| |l|)
                                               (SEQ G190
                                                    (COND
                                                     ((NULL
                                                       (NULL
                                                        (EQ |vl|
                                                            (QAREF1 |vscan|
                                                                    |l|))))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (LETT |l| (+ |l| 1))))
                                                    NIL (GO G190) G191
                                                    (EXIT NIL))
                                               (LETT |i| (- (+ |i| |l|) |l0|))
                                               (EXIT
                                                (LETT |m|
                                                      (- (+ |m| |l|)
                                                         |l0|))))))))
                                      (COND
                                       ((NULL (EQ |y| (QAREF1 |vscan| |i|)))
                                        (SEQ (LETT |i0| |i|)
                                             (SEQ G190
                                                  (COND
                                                   ((NULL
                                                     (NULL
                                                      (EQ |y|
                                                          (QAREF1 |vscan|
                                                                  |i|))))
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT (LETT |i| (+ |i| 1))))
                                                  NIL (GO G190) G191
                                                  (EXIT NIL))
                                             (EXIT
                                              (LETT |m|
                                                    (- (+ |m| |i|) |i0|))))))
                                      (COND
                                       (|has_vm|
                                        (COND
                                         ((NULL (EQ |vm| (QAREF1 |vscan| |m|)))
                                          (SEQ G190
                                               (COND
                                                ((NULL
                                                  (NULL
                                                   (EQ |vm|
                                                       (QAREF1 |vscan| |m|))))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT (LETT |m| (+ |m| 1))))
                                               NIL (GO G190) G191
                                               (EXIT NIL))))))
                                      (EXIT
                                       (COND ((< |cp| 0) (LETT |m| |i|))
                                             ('T (LETT |l| |i|)))))))))
                         NIL (GO G190) G191 (EXIT NIL))))
              (EXIT
               (COND
                ((EQL |m| (QREFELT $ 9))
                 (SEQ
                  (SPADCALL |x|
                            (+
                             (SPADCALL (QAREF1 |vscan| (- |m| 1))
                                       (QREFELT $ 13))
                             1024)
                            (QREFELT $ 14))
                  (|SCACHE;insertAtEnd| |x| $)
                  (EXIT (PROGN (LETT #2# |x|) (GO #6#)))))
                (#7#
                 (SEQ
                  (LETT |pos|
                        (COND ((< |l| 0) 0)
                              (#7#
                               (SPADCALL (QAREF1 |vscan| |l|)
                                         (QREFELT $ 13)))))
                  (EXIT
                   (|SCACHE;insertInCache|
                    (PROG1 (LETT #1# (+ |l| 1))
                      (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #1#))
                    |x| |pos| $))))))))))
          #6# (EXIT #2#)))) 

(SDEFUN |SCACHE;insertInCache|
        ((|before| (|NonNegativeInteger|)) (|x| (S))
         (|pos| (|NonNegativeInteger|)) ($ (S)))
        (SPROG ((#1=#:G814 NIL) (|y| (S)))
               (SEQ (LETT |y| (QAREF1 (QREFELT $ 7) |before|))
                    (COND
                     ((EQL (+ |pos| 1) (SPADCALL |y| (QREFELT $ 13)))
                      (|SCACHE;shiftCache| |before| 1024 $)))
                    (SPADCALL |x|
                              (+ |pos|
                                 (QUOTIENT2
                                  (PROG1
                                      (LETT #1#
                                            (- (SPADCALL |y| (QREFELT $ 13))
                                               |pos|))
                                    (|check_subtype2| (>= #1# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #1#))
                                  2))
                              (QREFELT $ 14))
                    (|SCACHE;insertBefore| |before| |x| $) (EXIT |x|)))) 

(DECLAIM (NOTINLINE |SortedCache;|)) 

(DEFUN |SortedCache| (#1=#:G817)
  (SPROG NIL
         (PROG (#2=#:G818)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|SortedCache|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|SortedCache;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|SortedCache|)))))))))) 

(DEFUN |SortedCache;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|SortedCache| DV$1))
          (LETT $ (GETREFV 23))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SortedCache| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (MAKE-ARRAY 0))
          (QSETREFV $ 8 0)
          (QSETREFV $ 9 0)
          $))) 

(MAKEPROP '|SortedCache| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|cache| '|cache_size|
              '|cache_use| (|Void|) (0 . |void|) (|NonNegativeInteger|)
              (4 . |position|) (9 . |setPosition|) |SCACHE;clearCache;V;4|
              (|Union| 6 '#1="failed") (|Mapping| (|Boolean|) 6)
              |SCACHE;linearSearch;SMU;6| |SCACHE;enterInCache;SMS;7|
              (|Mapping| (|Integer|) 6 6) |SCACHE;binarySearch;SMU;8|
              |SCACHE;enterInCache;SMS;9|)
           '#(|linearSearch| 15 |enterInCache| 21 |clearCache| 33
              |binarySearch| 37)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|clearCache| ((|Void|))) T)
                                   '((|enterInCache|
                                      (|#1| |#1| (|Mapping| (|Boolean|) |#1|)))
                                     T)
                                   '((|linearSearch|
                                      ((|Union| |#1| #1#) |#1|
                                       (|Mapping| (|Boolean|) |#1|)))
                                     T)
                                   '((|enterInCache|
                                      (|#1| |#1|
                                       (|Mapping| (|Integer|) |#1| |#1|)))
                                     T)
                                   '((|binarySearch|
                                      ((|Union| |#1| "failed") |#1|
                                       (|Mapping| (|Integer|) |#1| |#1|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 22
                                            '(0 10 0 11 1 6 12 0 13 2 6 10 0 12
                                              14 2 0 16 6 17 18 2 0 6 6 17 19 2
                                              0 6 6 20 22 0 0 10 15 2 0 16 6 20
                                              21)))))
           '|lookupComplete|)) 

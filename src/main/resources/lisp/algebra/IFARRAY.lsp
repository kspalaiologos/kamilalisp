
(PUT '|IFARRAY;physicalLength;$Nni;1| '|SPADreplace|
     '(XLAM (|r|) (QVELT |r| 0))) 

(SDEFUN |IFARRAY;physicalLength;$Nni;1| ((|r| ($)) ($ (|NonNegativeInteger|)))
        (QVELT |r| 0)) 

(SDEFUN |IFARRAY;physicalLength!;$I$;2| ((|r| ($)) (|n| (|Integer|)) ($ ($)))
        (COND
         ((EQL (QVELT |r| 0) 0) (|error| "flexible array must be non-empty"))
         ('T (|IFARRAY;growWith| |r| |n| (QAREF1 (QVELT |r| 2) 0) $)))) 

(SDEFUN |IFARRAY;empty;$;3| (($ ($))) (VECTOR 0 0 (MAKE-ARRAY 0))) 

(SDEFUN |IFARRAY;#;$Nni;4| ((|r| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G722 NIL))
               (PROG1 (LETT #1# (QVELT |r| 1))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))) 

(SDEFUN |IFARRAY;fill!;$S$;5| ((|r| ($)) (|x| (S)) ($ ($)))
        (SEQ (SPADCALL (QVELT |r| 2) |x| (QREFELT $ 17)) (EXIT |r|))) 

(SDEFUN |IFARRAY;maxIndex;$I;6| ((|r| ($)) ($ (|Integer|)))
        (+ (- (QVELT |r| 1) 1) (QREFELT $ 7))) 

(SDEFUN |IFARRAY;minIndex;$I;7| ((|r| ($)) ($ (|Integer|))) (QREFELT $ 7)) 

(SDEFUN |IFARRAY;new;NniS$;8| ((|n| (|NonNegativeInteger|)) (|a| (S)) ($ ($)))
        (VECTOR |n| |n| (MAKEARR1 |n| |a|))) 

(SDEFUN |IFARRAY;shrinkable;2B;9| ((|b| (|Boolean|)) ($ (|Boolean|)))
        (SPROG ((|oldval| (|Boolean|)))
               (SEQ (LETT |oldval| (QREFELT $ 9)) (SETELT $ 9 |b|)
                    (EXIT |oldval|)))) 

(SDEFUN |IFARRAY;flexibleArray;L$;10| ((|l| (|List| S)) ($ ($)))
        (SPROG
         ((#1=#:G751 NIL) (|i| NIL) (#2=#:G752 NIL) (|y| NIL) (|a| ($))
          (|x| (S)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |l|))
              (EXIT
               (COND ((EQL |n| 0) (SPADCALL (QREFELT $ 14)))
                     ('T
                      (SEQ (LETT |x| (SPADCALL |l| 1 (QREFELT $ 25)))
                           (LETT |a| (SPADCALL |n| |x| (QREFELT $ 21)))
                           (SEQ (LETT |y| NIL) (LETT #2# (CDR |l|))
                                (LETT |i| (+ (QREFELT $ 7) 1))
                                (LETT #1# (- (+ (QREFELT $ 7) |n|) 1)) G190
                                (COND
                                 ((OR (> |i| #1#) (ATOM #2#)
                                      (PROGN (LETT |y| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT (SPADCALL |a| |i| |y| (QREFELT $ 26))))
                                (LETT |i|
                                      (PROG1 (+ |i| 1) (LETT #2# (CDR #2#))))
                                (GO G190) G191 (EXIT NIL))
                           (EXIT |a|)))))))) 

(SDEFUN |IFARRAY;newa|
        ((|n| (|NonNegativeInteger|)) (|a| (|PrimitiveArray| S))
         ($ (|PrimitiveArray| S)))
        (COND ((ZEROP |n|) (MAKE-ARRAY 0)) ('T (MAKEARR1 |n| (QAREF1 |a| 0))))) 

(SDEFUN |IFARRAY;growAdding| ((|r| ($)) (|b| (|Integer|)) (|s| ($)) ($ ($)))
        (COND ((EQL |b| 0) |r|)
              ((> (SPADCALL |r| (QREFELT $ 15)) 0)
               (|IFARRAY;growAndFill| |r| |b| (QAREF1 (QVELT |r| 2) 0) $))
              ((> (SPADCALL |s| (QREFELT $ 15)) 0)
               (|IFARRAY;growAndFill| |r| |b| (QAREF1 (QVELT |s| 2) 0) $))
              ('T (|error| "no default filler element")))) 

(SDEFUN |IFARRAY;growAndFill| ((|r| ($)) (|b| (|Integer|)) (|x| (S)) ($ ($)))
        (SPROG ((|n| (|Integer|)))
               (SEQ
                (COND
                 ((<= (QSETVELT |r| 1 (+ (QVELT |r| 1) |b|)) (QVELT |r| 0))
                  |r|)
                 ('T
                  (SEQ
                   (LETT |n|
                         (+ (+ (QVELT |r| 0) (QUOTIENT2 (QVELT |r| 0) 2)) 1))
                   (COND ((> (QVELT |r| 1) |n|) (LETT |n| (QVELT |r| 1))))
                   (EXIT (|IFARRAY;growWith| |r| |n| |x| $)))))))) 

(SDEFUN |IFARRAY;growWith| ((|r| ($)) (|n| (|Integer|)) (|x| (S)) ($ ($)))
        (SPROG
         ((#1=#:G770 NIL) (|k| NIL) (|a| (|PrimitiveArray| S))
          (|y| (|PrimitiveArray| S)) (#2=#:G764 NIL))
         (SEQ
          (LETT |y|
                (MAKEARR1
                 (PROG1 (LETT #2# |n|)
                   (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #2#))
                 |x|))
          (LETT |a| (QVELT |r| 2))
          (SEQ (LETT |k| 0) (LETT #1# (- (QVELT |r| 0) 1)) G190
               (COND ((|greater_SI| |k| #1#) (GO G191)))
               (SEQ (EXIT (QSETAREF1 |y| |k| (QAREF1 |a| |k|))))
               (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
          (QSETVELT |r| 0 |n|) (QSETVELT |r| 2 |y|) (EXIT |r|)))) 

(SDEFUN |IFARRAY;shrink| ((|r| ($)) (|i| (|Integer|)) ($ ($)))
        (SPROG
         ((#1=#:G782 NIL) (|k| NIL) (|y| (|PrimitiveArray| S))
          (|a| (|PrimitiveArray| S)) (#2=#:G773 NIL) (|n| (|Integer|)))
         (SEQ (QSETVELT |r| 1 (- (QVELT |r| 1) |i|))
              (EXIT
               (COND
                ((MINUSP (LETT |n| (QVELT |r| 1)))
                 (|error| "internal bug in flexible array"))
                ((OR (> (+ (* 2 |n|) 2) (QVELT |r| 0)) (NULL (QREFELT $ 9)))
                 |r|)
                ('T
                 (SEQ
                  (COND
                   ((< |n| (QVELT |r| 1))
                    (|error|
                     "cannot shrink flexible array to indicated size")))
                  (EXIT
                   (COND ((EQL |n| 0) (SPADCALL (QREFELT $ 14)))
                         ('T
                          (SEQ (QSETVELT |r| 0 |n|)
                               (LETT |y|
                                     (|IFARRAY;newa|
                                      (PROG1 (LETT #2# |n|)
                                        (|check_subtype2| (>= #2# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #2#))
                                      (LETT |a| (QVELT |r| 2)) $))
                               (SEQ (LETT |k| 0) (LETT #1# (- |n| 1)) G190
                                    (COND ((|greater_SI| |k| #1#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (QSETAREF1 |y| |k| (QAREF1 |a| |k|))))
                                    (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                    (EXIT NIL))
                               (QSETVELT |r| 2 |y|) (EXIT |r|)))))))))))) 

(SDEFUN |IFARRAY;copy;2$;16| ((|r| ($)) ($ ($)))
        (SPROG
         ((#1=#:G788 NIL) (|k| NIL) (|v| (|PrimitiveArray| S))
          (|a| (|PrimitiveArray| S)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |r| (QREFELT $ 15))) (LETT |a| (QVELT |r| 2))
              (LETT |v| (|IFARRAY;newa| |n| (LETT |a| (QVELT |r| 2)) $))
              (SEQ (LETT |k| 0) (LETT #1# (- |n| 1)) G190
                   (COND ((|greater_SI| |k| #1#) (GO G191)))
                   (SEQ (EXIT (QSETAREF1 |v| |k| (QAREF1 |a| |k|))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |n| |n| |v|))))) 

(SDEFUN |IFARRAY;elt;$IS;17| ((|r| ($)) (|i| (|Integer|)) ($ (S)))
        (COND
         ((OR (< |i| (QREFELT $ 7)) (>= |i| (+ (QVELT |r| 1) (QREFELT $ 7))))
          (|error| "index out of range"))
         ('T (QAREF1 (QVELT |r| 2) (- |i| (QREFELT $ 7)))))) 

(SDEFUN |IFARRAY;setelt!;$I2S;18|
        ((|r| ($)) (|i| (|Integer|)) (|x| (S)) ($ (S)))
        (COND
         ((OR (< |i| (QREFELT $ 7)) (>= |i| (+ (QVELT |r| 1) (QREFELT $ 7))))
          (|error| "index out of range"))
         ('T (QSETAREF1 (QVELT |r| 2) (- |i| (QREFELT $ 7)) |x|)))) 

(SDEFUN |IFARRAY;merge;M3$;19|
        ((|g| (|Mapping| (|Boolean|) S S)) (|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL |g| (SPADCALL |a| (QREFELT $ 28)) |b| (QREFELT $ 31))) 

(SDEFUN |IFARRAY;concat!;$S$;20| ((|r| ($)) (|x| (S)) ($ ($)))
        (SEQ (|IFARRAY;growAndFill| |r| 1 |x| $)
             (QSETAREF1 (QVELT |r| 2) (- (QVELT |r| 1) 1) |x|) (EXIT |r|))) 

(SDEFUN |IFARRAY;concat!;3$;21| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((SPADCALL |a| |b| (QREFELT $ 34))
                  (LETT |b| (SPADCALL |b| (QREFELT $ 28)))))
                (LETT |n| (SPADCALL |a| (QREFELT $ 15)))
                (|IFARRAY;growAdding| |a| (SPADCALL |b| (QREFELT $ 15)) |b| $)
                (EXIT
                 (SPADCALL |a| |b| (+ |n| (QREFELT $ 7)) (QREFELT $ 35)))))) 

(SDEFUN |IFARRAY;remove!;M2$;22|
        ((|g| (|Mapping| (|Boolean|) S)) (|a| ($)) ($ ($)))
        (SPROG ((|k| (|Integer|)) (#1=#:G813 NIL) (|i| NIL))
               (SEQ (LETT |k| 0)
                    (SEQ (LETT |i| 0)
                         (LETT #1#
                               (- (SPADCALL |a| (QREFELT $ 19)) (QREFELT $ 7)))
                         G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((NULL
                              (SPADCALL (SPADCALL |a| |i| (QREFELT $ 29)) |g|))
                             (SEQ
                              (SPADCALL |a| |k|
                                        (SPADCALL |a| |i| (QREFELT $ 29))
                                        (QREFELT $ 26))
                              (EXIT (LETT |k| (+ |k| 1))))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (|IFARRAY;shrink| |a|
                      (- (SPADCALL |a| (QREFELT $ 15)) |k|) $))))) 

(SDEFUN |IFARRAY;delete!;$I$;23| ((|r| ($)) (|i1| (|Integer|)) ($ ($)))
        (SPROG ((#1=#:G820 NIL) (|k| NIL) (|i| (|Integer|)))
               (SEQ (LETT |i| (- |i1| (QREFELT $ 7)))
                    (COND
                     ((OR (< |i| 0) (> |i| (QVELT |r| 1)))
                      (EXIT (|error| "index out of range"))))
                    (SEQ (LETT |k| |i|) (LETT #1# (- (QVELT |r| 1) 2)) G190
                         (COND ((> |k| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 (QVELT |r| 2) |k|
                                      (QAREF1 (QVELT |r| 2) (+ |k| 1)))))
                         (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT (|IFARRAY;shrink| |r| 1 $))))) 

(SDEFUN |IFARRAY;delete!;$Us$;24|
        ((|r| ($)) (|i| (|UniversalSegment| (|Integer|))) ($ ($)))
        (SPROG
         ((|j| NIL) (#1=#:G827 NIL) (|k| NIL) (|h| #2=(|Integer|)) (|m| #2#)
          (|l| #2#))
         (SEQ (LETT |l| (- (SPADCALL |i| (QREFELT $ 41)) (QREFELT $ 7)))
              (LETT |m| (- (SPADCALL |r| (QREFELT $ 19)) (QREFELT $ 7)))
              (LETT |h|
                    (COND
                     ((SPADCALL |i| (QREFELT $ 42))
                      (- (SPADCALL |i| (QREFELT $ 43)) (QREFELT $ 7)))
                     ('T |m|)))
              (COND
               ((OR (< |l| 0) (> |h| |m|))
                (EXIT (|error| "index out of range"))))
              (SEQ (LETT |k| (+ |h| 1)) (LETT #1# |m|) (LETT |j| |l|) G190
                   (COND ((> |k| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1 (QVELT |r| 2) |j| (QAREF1 (QVELT |r| 2) |k|))))
                   (LETT |j| (PROG1 (+ |j| 1) (LETT |k| (+ |k| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT (|IFARRAY;shrink| |r| (MAX 0 (+ (- |h| |l|) 1)) $))))) 

(SDEFUN |IFARRAY;insert!;S$I$;25|
        ((|x| (S)) (|r| ($)) (|i1| (|Integer|)) ($ ($)))
        (SPROG ((#1=#:G833 NIL) (|k| NIL) (|n| (|Integer|)) (|i| (|Integer|)))
               (SEQ (LETT |i| (- |i1| (QREFELT $ 7))) (LETT |n| (QVELT |r| 1))
                    (COND
                     ((OR (< |i| 0) (> |i| |n|))
                      (EXIT (|error| "index out of range"))))
                    (|IFARRAY;growAndFill| |r| 1 |x| $)
                    (SEQ (LETT |k| (- |n| 1)) (LETT #1# |i|) G190
                         (COND ((< |k| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (QSETAREF1 (QVELT |r| 2) (+ |k| 1)
                                      (QAREF1 (QVELT |r| 2) |k|))))
                         (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                    (QSETAREF1 (QVELT |r| 2) |i| |x|) (EXIT |r|)))) 

(SDEFUN |IFARRAY;insert!;2$I$;26|
        ((|a| ($)) (|b| ($)) (|i1| (|Integer|)) ($ ($)))
        (SPROG
         ((|k| NIL) (#1=#:G842 NIL) (|n| #2=(|NonNegativeInteger|)) (|m| #2#)
          (|i| (|Integer|)))
         (SEQ (LETT |i| (- |i1| (QREFELT $ 7)))
              (COND
               ((SPADCALL |a| |b| (QREFELT $ 34))
                (LETT |b| (SPADCALL |b| (QREFELT $ 28)))))
              (LETT |m| (SPADCALL |a| (QREFELT $ 15)))
              (LETT |n| (SPADCALL |b| (QREFELT $ 15)))
              (COND
               ((OR (< |i| 0) (> |i| |n|))
                (EXIT (|error| "index out of range"))))
              (|IFARRAY;growAdding| |b| |m| |a| $)
              (SEQ (LETT |k| (- |n| 1)) (LETT #1# |i|) G190
                   (COND ((< |k| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1 (QVELT |b| 2) (+ |m| |k|)
                                (QAREF1 (QVELT |b| 2) |k|))))
                   (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |k| (- |m| 1)) G190 (COND ((< |k| 0) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1 (QVELT |b| 2) (+ |i| |k|)
                                (QAREF1 (QVELT |a| 2) |k|))))
                   (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
              (EXIT |b|)))) 

(SDEFUN |IFARRAY;merge!;M3$;27|
        ((|g| (|Mapping| (|Boolean|) S S)) (|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|k| NIL) (#1=#:G856 NIL) (|j| #2=(|Integer|)) (|i| #2#)
          (|n| #3=(|NonNegativeInteger|)) (|m| #3#))
         (SEQ (LETT |m| (SPADCALL |a| (QREFELT $ 15)))
              (LETT |n| (SPADCALL |b| (QREFELT $ 15)))
              (|IFARRAY;growAdding| |a| |n| |b| $)
              (SEQ (LETT |j| (- (+ |m| |n|) 1)) (LETT |i| (- |m| 1)) G190
                   (COND ((< |i| 0) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1 (QVELT |a| 2) |j| (QAREF1 (QVELT |a| 2) |i|))))
                   (LETT |i| (PROG1 (+ |i| -1) (LETT |j| (+ |j| -1))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |i| |n|) (LETT |j| 0)
              (SEQ (LETT |k| 0) G190
                   (COND
                    ((NULL (COND ((< |i| (+ |n| |m|)) (< |j| |n|)) ('T NIL)))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (QAREF1 (QVELT |a| 2) |i|)
                                 (QAREF1 (QVELT |b| 2) |j|) |g|)
                       (SEQ
                        (QSETAREF1 (QVELT |a| 2) |k|
                                   (QAREF1 (QVELT |a| 2) |i|))
                        (EXIT (LETT |i| (+ |i| 1)))))
                      ('T
                       (SEQ
                        (QSETAREF1 (QVELT |a| 2) |k|
                                   (QAREF1 (QVELT |b| 2) |j|))
                        (EXIT (LETT |j| (+ |j| 1))))))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |j| |j|) (LETT #1# (- |n| 1)) (LETT |k| |k|) G190
                   (COND ((> |j| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1 (QVELT |a| 2) |k| (QAREF1 (QVELT |b| 2) |j|))))
                   (LETT |k| (PROG1 (+ |k| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |a|)))) 

(SDEFUN |IFARRAY;select!;M2$;28|
        ((|g| (|Mapping| (|Boolean|) S)) (|a| ($)) ($ ($)))
        (SPROG ((|k| (|Integer|)) (#1=#:G864 NIL) (|i| NIL))
               (SEQ (LETT |k| 0)
                    (SEQ (LETT |i| 0)
                         (LETT #1#
                               (- (SPADCALL |a| (QREFELT $ 19)) (QREFELT $ 7)))
                         G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (QAREF1 (QVELT |a| 2) |i|) |g|)
                             (SEQ
                              (QSETAREF1 (QVELT |a| 2) |k|
                                         (QAREF1 (QVELT |a| 2) |i|))
                              (EXIT (LETT |k| (+ |k| 1))))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (|IFARRAY;shrink| |a|
                      (- (SPADCALL |a| (QREFELT $ 15)) |k|) $))))) 

(SDEFUN |IFARRAY;removeDuplicates!;2$;29| ((|a| ($)) ($ ($)))
        (SPROG
         ((|i| (|Integer|)) (|nlim| #1=(|Integer|)) (|j| #1#) (#2=#:G875 NIL)
          (|k| NIL) (|nlim0| #1#) (|ct| (|NonNegativeInteger|)))
         (SEQ (LETT |ct| (SPADCALL |a| (QREFELT $ 15)))
              (EXIT
               (COND ((< |ct| 2) |a|)
                     (#3='T
                      (SEQ (LETT |i| (QREFELT $ 7))
                           (LETT |nlim| (+ (QREFELT $ 7) |ct|))
                           (LETT |nlim0| |nlim|)
                           (SEQ G190 (COND ((NULL (< |i| |nlim|)) (GO G191)))
                                (SEQ (LETT |j| (+ |i| 1))
                                     (SEQ (LETT |k| |j|)
                                          (LETT #2# (- |nlim| 1)) G190
                                          (COND ((> |k| #2#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (COND
                                             ((SPADCALL
                                               (SPADCALL |a| |k|
                                                         (QREFELT $ 29))
                                               (SPADCALL |a| |i|
                                                         (QREFELT $ 29))
                                               (QREFELT $ 48))
                                              (SEQ
                                               (SPADCALL |a| |j|
                                                         (SPADCALL |a| |k|
                                                                   (QREFELT $
                                                                            29))
                                                         (QREFELT $ 26))
                                               (EXIT (LETT |j| (+ |j| 1))))))))
                                          (LETT |k| (+ |k| 1)) (GO G190) G191
                                          (EXIT NIL))
                                     (LETT |nlim| |j|)
                                     (EXIT (LETT |i| (+ |i| 1))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (COND
                             ((SPADCALL |nlim| |nlim0| (QREFELT $ 49))
                              (SPADCALL |a| (SPADCALL |i| (QREFELT $ 50))
                                        (QREFELT $ 44)))
                             (#3# |a|)))))))))) 

(SDEFUN |IFARRAY;removeRepeats!;2$;30| ((|a| ($)) ($ ($)))
        (SPROG
         ((|i| #1=(|Integer|)) (|t| (S)) (|j| (|Integer|)) (|s| (S))
          (|nlim| #1#) (|ct| (|NonNegativeInteger|)))
         (SEQ (LETT |ct| (SPADCALL |a| (QREFELT $ 15)))
              (EXIT
               (COND ((< |ct| 2) |a|)
                     (#2='T
                      (SEQ (LETT |j| (QREFELT $ 7))
                           (LETT |nlim| (+ (QREFELT $ 7) |ct|))
                           (LETT |t| (SPADCALL |a| |j| (QREFELT $ 29)))
                           (LETT |i| (+ |j| 1))
                           (SEQ G190 (COND ((NULL (< |i| |nlim|)) (GO G191)))
                                (SEQ
                                 (LETT |s| (SPADCALL |a| |i| (QREFELT $ 29)))
                                 (COND
                                  ((SPADCALL |s| |t| (QREFELT $ 48))
                                   (SEQ (LETT |j| (+ |j| 1))
                                        (EXIT
                                         (SPADCALL |a| |j| (LETT |t| |s|)
                                                   (QREFELT $ 26))))))
                                 (EXIT (LETT |i| (+ |i| 1))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (COND
                             ((< (+ |j| 1) |nlim|)
                              (SPADCALL |a| (SPADCALL (+ |j| 1) (QREFELT $ 50))
                                        (QREFELT $ 44)))
                             (#2# |a|)))))))))) 

(DECLAIM (NOTINLINE |IndexedFlexibleArray;|)) 

(DEFUN |IndexedFlexibleArray| (&REST #1=#:G892)
  (SPROG NIL
         (PROG (#2=#:G893)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|IndexedFlexibleArray|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |IndexedFlexibleArray;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|IndexedFlexibleArray|)))))))))) 

(DEFUN |IndexedFlexibleArray;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G889 NIL) (#2=#:G890 NIL) (#3=#:G891 NIL) ($ NIL)
    (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT |dv$| (LIST '|IndexedFlexibleArray| DV$1 DV$2))
    (LETT $ (GETREFV 66))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| (|Integer|)
                                                       '(|OrderedSet|))
                                        (|HasCategory| |#1| '(|BasicType|))
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|Comparable|)))
                                        (OR #3#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|)))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #2#)
                                        (OR (|HasCategory| |#1| '(|BasicType|))
                                            #3#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #2#)
                                        (OR #3#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #2#)
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #1# #3#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #2#)))))
    (|haddProp| |$ConstructorCache| '|IndexedFlexibleArray| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 4096))
    (AND (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 8192))
    (AND (|HasCategory| |#1| '(|BasicType|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 16384))
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 32768))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 65536))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 131072))
    (AND
     (OR (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
         (AND (|HasCategory| |#1| '(|OrderedSet|))
              (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 262144))
    (AND
     (OR (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
         (AND (|HasCategory| |#1| '(|OrderedSet|))
              (|HasCategory| $ '(|finiteAggregate|)))
         #2#)
     (|augmentPredVector| $ 524288))
    (AND
     (OR #1# (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
         (AND (|HasCategory| |#1| '(|OrderedSet|))
              (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 1048576))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|BasicType|))
           (|HasCategory| $ '(|finiteAggregate|)))
      (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
      (AND (|HasCategory| |#1| '(|OrderedSet|))
           (|HasCategory| $ '(|finiteAggregate|)))
      #2#)
     (|augmentPredVector| $ 2097152))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8
              (|Record| (|:| |physLen| (|Integer|)) (|:| |logLen| (|Integer|))
                        (|:| |f| (|PrimitiveArray| |#1|))))
    (QSETREFV $ 9 'T)
    (COND
     ((|testBitVector| |pv$| 4)
      (PROGN
       (QSETREFV $ 51
                 (CONS (|dispatchFunction| |IFARRAY;removeDuplicates!;2$;29|)
                       $))
       (QSETREFV $ 52
                 (CONS (|dispatchFunction| |IFARRAY;removeRepeats!;2$;30|)
                       $)))))
    $))) 

(MAKEPROP '|IndexedFlexibleArray| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              '|shrinkable?| (|NonNegativeInteger|)
              |IFARRAY;physicalLength;$Nni;1| (|Integer|)
              |IFARRAY;physicalLength!;$I$;2| |IFARRAY;empty;$;3|
              |IFARRAY;#;$Nni;4| (|PrimitiveArray| 6) (0 . |fill!|)
              |IFARRAY;fill!;$S$;5| |IFARRAY;maxIndex;$I;6|
              |IFARRAY;minIndex;$I;7| |IFARRAY;new;NniS$;8| (|Boolean|)
              |IFARRAY;shrinkable;2B;9| (|List| 6) (6 . |elt|)
              |IFARRAY;setelt!;$I2S;18| |IFARRAY;flexibleArray;L$;10|
              |IFARRAY;copy;2$;16| |IFARRAY;elt;$IS;17| (|Mapping| 22 6 6)
              |IFARRAY;merge!;M3$;27| |IFARRAY;merge;M3$;19|
              |IFARRAY;concat!;$S$;20| (12 . |eq?|) (18 . |copyInto!|)
              |IFARRAY;concat!;3$;21| (|Mapping| 22 6) |IFARRAY;remove!;M2$;22|
              |IFARRAY;delete!;$I$;23| (|UniversalSegment| 12) (25 . |low|)
              (30 . |hasHi|) (35 . |high|) |IFARRAY;delete!;$Us$;24|
              |IFARRAY;insert!;S$I$;25| |IFARRAY;insert!;2$I$;26|
              |IFARRAY;select!;M2$;28| (40 . ~=) (46 . ~=) (52 . SEGMENT)
              (57 . |removeDuplicates!|) (62 . |removeRepeats!|)
              (|Mapping| 6 6 6) (|List| 55) (|Equation| 6) (|OutputForm|)
              (|SingleInteger|) (|String|) (|HashState|) (|Void|)
              (|Mapping| 6 6) (|InputForm|) (|List| $) (|Union| 6 '"failed")
              (|List| 12))
           '#(~= 67 |trim| 73 |swap!| 79 |sorted?| 86 |sort!| 97 |sort| 108
              |smaller?| 119 |size?| 125 |shrinkable| 131 |setelt!| 136
              |select!| 150 |select| 156 |sample| 162 |rightTrim| 166
              |reverse!| 172 |reverse| 177 |removeRepeats!| 182
              |removeDuplicates!| 187 |removeDuplicates| 192 |remove!| 197
              |remove| 209 |reduce| 221 |qsetelt!| 242 |qelt| 249 |position|
              255 |physicalLength!| 274 |physicalLength| 280 |parts| 285 |new|
              290 |more?| 296 |minIndex| 302 |min| 307 |merge!| 318 |merge| 331
              |members| 344 |member?| 349 |maxIndex| 355 |max| 360 |map!| 377
              |map| 383 |less?| 396 |leftTrim| 402 |latex| 408 |insert!| 413
              |insert| 427 |indices| 441 |index?| 446 |hashUpdate!| 452 |hash|
              458 |flexibleArray| 463 |first| 468 |find| 479 |fill!| 485
              |every?| 491 |eval| 497 |eq?| 523 |entry?| 529 |entries| 535
              |empty?| 540 |empty| 545 |elt| 549 |delete!| 568 |delete| 580
              |count| 592 |copyInto!| 604 |copy| 611 |convert| 616 |construct|
              621 |concat!| 626 |concat| 638 |coerce| 661 |any?| 666 >= 672 >
              678 = 684 <= 690 < 696 |#| 702)
           'NIL
           (CONS
            (|makeByteWordVec2| 12
                                '(0 0 0 0 0 0 1 0 6 0 0 8 10 0 0 0 0 0 8 9 12 1
                                  2))
            (CONS
             '#(|OneDimensionalArrayAggregate&| NIL
                |ExtensibleLinearAggregate&| |LinearAggregate&|
                |IndexedAggregate&| |Collection&| |OrderedSet&|
                |HomogeneousAggregate&| NIL |Aggregate&| |EltableAggregate&|
                |Evalable&| |SetCategory&| NIL NIL NIL NIL NIL |InnerEvalable&|
                |BasicType&| NIL |PartialOrder&| NIL)
             (CONS
              '#((|OneDimensionalArrayAggregate| 6) (|FiniteLinearAggregate| 6)
                 (|ExtensibleLinearAggregate| 6) (|LinearAggregate| 6)
                 (|IndexedAggregate| 12 6) (|Collection| 6) (|OrderedSet|)
                 (|HomogeneousAggregate| 6) (|Comparable|) (|Aggregate|)
                 (|EltableAggregate| 12 6) (|Evalable| 6) (|SetCategory|)
                 (|shallowlyMutable|) (|finiteAggregate|) (|Eltable| 40 $$)
                 (|Type|) (|Eltable| 12 6) (|InnerEvalable| 6 6) (|BasicType|)
                 (|CoercibleTo| 56) (|PartialOrder|) (|ConvertibleTo| 62))
              (|makeByteWordVec2| 65
                                  '(2 16 0 0 6 17 2 24 6 0 12 25 2 0 22 0 0 34
                                    3 0 0 0 0 12 35 1 40 12 0 41 1 40 22 0 42 1
                                    40 12 0 43 2 6 22 0 0 48 2 12 22 0 0 49 1
                                    40 0 12 50 1 0 0 0 51 1 0 0 0 52 2 22 22 0
                                    0 1 2 15 0 0 6 1 3 13 60 0 12 12 1 1 18 22
                                    0 1 2 14 22 30 0 1 1 17 0 0 1 2 16 0 30 0 1
                                    1 18 0 0 1 2 14 0 30 0 1 2 19 22 0 0 1 2 0
                                    22 0 10 1 1 0 22 22 23 3 13 6 0 40 6 1 3 13
                                    6 0 12 6 26 2 0 0 37 0 47 2 14 0 37 0 1 0 0
                                    0 1 2 15 0 0 6 1 1 16 0 0 1 1 14 0 0 1 1 0
                                    0 0 52 1 4 0 0 51 1 15 0 0 1 2 4 0 6 0 1 2
                                    0 0 37 0 38 2 15 0 6 0 1 2 14 0 37 0 1 4 15
                                    6 53 0 6 6 1 2 14 6 53 0 1 3 14 6 53 0 6 1
                                    3 13 6 0 12 6 1 2 0 6 0 12 1 3 15 12 6 0 12
                                    1 2 15 12 6 0 1 2 14 12 37 0 1 2 0 0 0 12
                                    13 1 0 10 0 11 1 14 24 0 1 2 0 0 10 6 21 2
                                    0 22 0 10 1 1 3 12 0 20 2 18 0 0 0 1 1 18 6
                                    0 1 2 1 0 0 0 1 3 0 0 30 0 0 31 2 18 0 0 0
                                    1 3 14 0 30 0 0 32 1 14 24 0 1 2 15 22 6 0
                                    1 1 3 12 0 19 2 18 0 0 0 1 1 18 6 0 1 2 14
                                    6 30 0 1 2 13 0 61 0 1 3 0 0 53 0 0 1 2 0 0
                                    61 0 1 2 0 22 0 10 1 2 15 0 0 6 1 1 20 58 0
                                    1 3 0 0 6 0 12 45 3 0 0 0 0 12 46 3 0 0 6 0
                                    12 1 3 0 0 0 0 12 1 1 0 65 0 1 2 0 22 12 0
                                    1 2 20 59 59 0 1 1 20 57 0 1 1 0 0 24 27 1
                                    3 6 0 1 2 0 0 0 10 1 2 0 64 37 0 1 2 13 0 0
                                    6 18 2 14 22 37 0 1 3 8 0 0 6 6 1 3 8 0 0
                                    24 24 1 2 8 0 0 54 1 2 8 0 0 55 1 2 0 22 0
                                    0 34 2 15 22 6 0 1 1 0 24 0 1 1 0 22 0 1 0
                                    0 0 14 2 0 0 0 40 1 3 0 6 0 12 6 1 2 0 6 0
                                    12 29 2 0 0 0 40 44 2 0 0 0 12 39 2 0 0 0
                                    40 1 2 0 0 0 12 1 2 15 10 6 0 1 2 14 10 37
                                    0 1 3 16 0 0 0 12 35 1 0 0 0 28 1 2 62 0 1
                                    1 0 0 24 1 2 0 0 0 6 33 2 0 0 0 0 36 1 0 0
                                    63 1 2 0 0 6 0 1 2 0 0 0 0 1 2 0 0 0 6 1 1
                                    21 56 0 1 2 14 22 37 0 1 2 18 22 0 0 1 2 18
                                    22 0 0 1 2 22 22 0 0 1 2 18 22 0 0 1 2 18
                                    22 0 0 1 1 14 10 0 15)))))
           '|lookupComplete|)) 

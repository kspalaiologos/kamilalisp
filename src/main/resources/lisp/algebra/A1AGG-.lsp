
(SDEFUN |A1AGG-;parts;AL;1| ((|x| (A)) ($ (|List| S)))
        (SPROG ((#1=#:G745 NIL) (|i| NIL) (#2=#:G744 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 9)))
                      (LETT #1# (SPADCALL |x| (QREFELT $ 10))) G190
                      (COND ((> |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |x| |i| (QREFELT $ 11)) #2#))))
                      (LETT |i| (+ |i| 1)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |A1AGG-;sort!;M2A;2|
        ((|f| (|Mapping| (|Boolean|) S S)) (|a| (A)) ($ (A)))
        (SPADCALL |f| |a| (QREFELT $ 16))) 

(SDEFUN |A1AGG-;any?;MAB;3|
        ((|f| (|Mapping| (|Boolean|) S)) (|a| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G755 NIL) (#2=#:G756 NIL) (#3=#:G757 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                         (LETT #3# (SPADCALL |a| (QREFELT $ 10))) G190
                         (COND ((> |i| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |a| |i| (QREFELT $ 11)) |f|)
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G754)))
                              (GO #5=#:G751))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |A1AGG-;every?;MAB;4|
        ((|f| (|Mapping| (|Boolean|) S)) (|a| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G763 NIL) (#2=#:G764 NIL) (#3=#:G765 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                         (LETT #3# (SPADCALL |a| (QREFELT $ 10))) G190
                         (COND ((> |i| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((NULL
                              (SPADCALL (SPADCALL |a| |i| (QREFELT $ 11)) |f|))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# NIL) (GO #4=#:G762)))
                              (GO #5=#:G760))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |A1AGG-;position;MAI;5|
        ((|f| (|Mapping| (|Boolean|) S)) (|a| (A)) ($ (|Integer|)))
        (SPROG ((#1=#:G771 NIL) (#2=#:G772 NIL) (#3=#:G773 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                         (LETT #3# (SPADCALL |a| (QREFELT $ 10))) G190
                         (COND ((> |i| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |a| |i| (QREFELT $ 11)) |f|)
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# |i|) (GO #4=#:G770)))
                              (GO #5=#:G768))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (- (SPADCALL |a| (QREFELT $ 9)) 1))))
                #4# (EXIT #2#)))) 

(SDEFUN |A1AGG-;find;MAU;6|
        ((|f| (|Mapping| (|Boolean|) S)) (|a| (A)) ($ (|Union| S "failed")))
        (SPROG ((#1=#:G785 NIL) (#2=#:G786 NIL) (#3=#:G787 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                         (LETT #3# (SPADCALL |a| (QREFELT $ 10))) G190
                         (COND ((> |i| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |a| |i| (QREFELT $ 11)) |f|)
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2#
                                           (CONS 0
                                                 (SPADCALL |a| |i|
                                                           (QREFELT $ 11))))
                                     (GO #4=#:G784)))
                              (GO #5=#:G779))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (CONS 1 "failed"))))
                #4# (EXIT #2#)))) 

(SDEFUN |A1AGG-;count;MANni;7|
        ((|f| (|Mapping| (|Boolean|) S)) (|a| (A)) ($ (|NonNegativeInteger|)))
        (SPROG ((|n| (|NonNegativeInteger|)) (#1=#:G793 NIL) (|i| NIL))
               (SEQ (LETT |n| 0)
                    (SEQ (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                         (LETT #1# (SPADCALL |a| (QREFELT $ 10))) G190
                         (COND ((> |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |a| |i| (QREFELT $ 11)) |f|)
                             (LETT |n| (+ |n| 1))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT |n|)))) 

(SDEFUN |A1AGG-;map!;M2A;8| ((|f| (|Mapping| S S)) (|a| (A)) ($ (A)))
        (SPROG ((#1=#:G799 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                     (LETT #1# (SPADCALL |a| (QREFELT $ 10))) G190
                     (COND ((> |i| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |a| |i|
                                 (SPADCALL (SPADCALL |a| |i| (QREFELT $ 11))
                                           |f|)
                                 (QREFELT $ 27))))
                     (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                (EXIT |a|)))) 

(SDEFUN |A1AGG-;setelt!;AUs2S;9|
        ((|a| (A)) (|s| (|UniversalSegment| (|Integer|))) (|x| (S)) ($ (S)))
        (SPROG ((#1=#:G807 NIL) (|k| NIL) (|h| (|Integer|)) (|l| (|Integer|)))
               (SEQ (LETT |l| (SPADCALL |s| (QREFELT $ 31)))
                    (LETT |h|
                          (COND
                           ((SPADCALL |s| (QREFELT $ 32))
                            (SPADCALL |s| (QREFELT $ 33)))
                           ('T (SPADCALL |a| (QREFELT $ 10)))))
                    (COND
                     ((OR (< |l| (SPADCALL |a| (QREFELT $ 9)))
                          (> |h| (SPADCALL |a| (QREFELT $ 10))))
                      (EXIT (|error| "index out of range"))))
                    (SEQ (LETT |k| |l|) (LETT #1# |h|) G190
                         (COND ((> |k| #1#) (GO G191)))
                         (SEQ (EXIT (SPADCALL |a| |k| |x| (QREFELT $ 27))))
                         (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT |x|)))) 

(SDEFUN |A1AGG-;reduce;MAS;10| ((|f| (|Mapping| S S S)) (|a| (A)) ($ (S)))
        (SPROG ((|r| (S)) (#1=#:G814 NIL) (|k| NIL) (|m| (|Integer|)))
               (SEQ
                (COND
                 ((SPADCALL |a| (QREFELT $ 35))
                  (|error| "cannot reduce an empty aggregate"))
                 ('T
                  (SEQ
                   (LETT |r|
                         (SPADCALL |a| (LETT |m| (SPADCALL |a| (QREFELT $ 9)))
                                   (QREFELT $ 11)))
                   (SEQ (LETT |k| (+ |m| 1))
                        (LETT #1# (SPADCALL |a| (QREFELT $ 10))) G190
                        (COND ((> |k| #1#) (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT |r|
                                (SPADCALL |r| (SPADCALL |a| |k| (QREFELT $ 11))
                                          |f|))))
                        (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                   (EXIT |r|))))))) 

(SDEFUN |A1AGG-;reduce;MA2S;11|
        ((|f| (|Mapping| S S S)) (|a| (A)) (|identity| (S)) ($ (S)))
        (SPROG ((#1=#:G819 NIL) (|k| NIL))
               (SEQ
                (SEQ (LETT |k| (SPADCALL |a| (QREFELT $ 9)))
                     (LETT #1# (SPADCALL |a| (QREFELT $ 10))) G190
                     (COND ((> |k| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |identity|
                             (SPADCALL |identity|
                                       (SPADCALL |a| |k| (QREFELT $ 11))
                                       |f|))))
                     (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                (EXIT |identity|)))) 

(SDEFUN |A1AGG-;reduce;MA3S;12|
        ((|f| (|Mapping| S S S)) (|a| (A)) (|identity| (S)) (|absorber| (S))
         ($ (S)))
        (SPROG ((#1=#:G824 NIL) (|k| NIL))
               (SEQ
                (SEQ (LETT |k| (SPADCALL |a| (QREFELT $ 9)))
                     (LETT #1# (SPADCALL |a| (QREFELT $ 10))) G190
                     (COND
                      ((OR (> |k| #1#)
                           (NULL
                            (SPADCALL |identity| |absorber| (QREFELT $ 39))))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |identity|
                             (SPADCALL |identity|
                                       (SPADCALL |a| |k| (QREFELT $ 11))
                                       |f|))))
                     (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                (EXIT |identity|)))) 

(SDEFUN |A1AGG-;stupidnew|
        ((|n| (|NonNegativeInteger|)) (|a| (A)) (|b| (A)) ($ (A)))
        (COND ((ZEROP |n|) (SPADCALL (QREFELT $ 41)))
              (#1='T
               (SPADCALL |n|
                         (COND
                          ((SPADCALL |a| (QREFELT $ 35))
                           (SPADCALL |b| (SPADCALL |b| (QREFELT $ 9))
                                     (QREFELT $ 11)))
                          (#1#
                           (SPADCALL |a| (SPADCALL |a| (QREFELT $ 9))
                                     (QREFELT $ 11))))
                         (QREFELT $ 42))))) 

(SDEFUN |A1AGG-;stupidget| ((|l| (|List| A)) ($ (S)))
        (SPROG ((#1=#:G833 NIL) (#2=#:G834 NIL) (#3=#:G835 NIL) (|a| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |a| NIL) (LETT #3# |l|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |a| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((NULL (SPADCALL |a| (QREFELT $ 35)))
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2# (SPADCALL |a| (QREFELT $ 43)))
                                     (GO #4=#:G832)))
                              (GO #5=#:G830))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (|error| "Should not happen"))))
                #4# (EXIT #2#)))) 

(SDEFUN |A1AGG-;map;M3A;15|
        ((|f| (|Mapping| S S S)) (|a| (A)) (|b| (A)) ($ (A)))
        (SPROG
         ((|i| NIL) (#1=#:G845 NIL) (|j| NIL) (|c| (A))
          (|l| (|NonNegativeInteger|)) (#2=#:G840 NIL) (|n| (|Integer|))
          (|m| (|Integer|)))
         (SEQ
          (LETT |m|
                (MAX (SPADCALL |a| (QREFELT $ 9))
                     (SPADCALL |b| (QREFELT $ 9))))
          (LETT |n|
                (MIN (SPADCALL |a| (QREFELT $ 10))
                     (SPADCALL |b| (QREFELT $ 10))))
          (LETT |l|
                (PROG1 (LETT #2# (MAX 0 (+ (- |n| |m|) 1)))
                  (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #2#)))
          (LETT |c| (|A1AGG-;stupidnew| |l| |a| |b| $))
          (SEQ (LETT |j| |m|) (LETT #1# |n|)
               (LETT |i| (SPADCALL |c| (QREFELT $ 9))) G190
               (COND ((> |j| #1#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |c| |i|
                           (SPADCALL (SPADCALL |a| |j| (QREFELT $ 11))
                                     (SPADCALL |b| |j| (QREFELT $ 11)) |f|)
                           (QREFELT $ 27))))
               (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190) G191
               (EXIT NIL))
          (EXIT |c|)))) 

(SDEFUN |A1AGG-;merge;M3A;16|
        ((|f| (|Mapping| (|Boolean|) S S)) (|a| (A)) (|b| (A)) ($ (A)))
        (SPROG
         ((|k| NIL) (#1=#:G858 NIL) (|j| #2=(|Integer|)) (#3=#:G857 NIL)
          (|i| #2#) (|n| #4=(|Integer|)) (|m| #4#) (|r| (A)))
         (SEQ
          (LETT |r|
                (|A1AGG-;stupidnew|
                 (+ (SPADCALL |a| (QREFELT $ 47))
                    (SPADCALL |b| (QREFELT $ 47)))
                 |a| |b| $))
          (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
          (LETT |m| (SPADCALL |a| (QREFELT $ 10)))
          (LETT |j| (SPADCALL |b| (QREFELT $ 9)))
          (LETT |n| (SPADCALL |b| (QREFELT $ 10)))
          (SEQ (LETT |k| (SPADCALL |r| (QREFELT $ 9))) G190
               (COND
                ((NULL (COND ((<= |i| |m|) (<= |j| |n|)) ('T NIL))) (GO G191)))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL (SPADCALL |a| |i| (QREFELT $ 11))
                             (SPADCALL |b| |j| (QREFELT $ 11)) |f|)
                   (SEQ
                    (SPADCALL |r| |k| (SPADCALL |a| |i| (QREFELT $ 11))
                              (QREFELT $ 27))
                    (EXIT (LETT |i| (+ |i| 1)))))
                  ('T
                   (SEQ
                    (SPADCALL |r| |k| (SPADCALL |b| |j| (QREFELT $ 11))
                              (QREFELT $ 27))
                    (EXIT (LETT |j| (+ |j| 1))))))))
               (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
          (SEQ (LETT |i| |i|) (LETT #3# |m|) (LETT |k| |k|) G190
               (COND ((> |i| #3#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |r| |k| (SPADCALL |a| |i| (QREFELT $ 48))
                           (QREFELT $ 27))))
               (LETT |k| (PROG1 (+ |k| 1) (LETT |i| (+ |i| 1)))) (GO G190) G191
               (EXIT NIL))
          (SEQ (LETT |j| |j|) (LETT #1# |n|) (LETT |k| |k|) G190
               (COND ((> |j| #1#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |r| |k| (SPADCALL |b| |j| (QREFELT $ 48))
                           (QREFELT $ 27))))
               (LETT |k| (PROG1 (+ |k| 1) (LETT |j| (+ |j| 1)))) (GO G190) G191
               (EXIT NIL))
          (EXIT |r|)))) 

(SDEFUN |A1AGG-;elt;AUsA;17|
        ((|x| (A)) (|seg| (|UniversalSegment| (|Integer|))) ($ (A)))
        (SPROG
         ((#1=#:G868 NIL) (#2=#:G869 NIL) (|i| NIL) (|j| NIL) (|z| (A))
          (#3=#:G861 NIL) (|n| (|Integer|)) (|hi| #4=(|Integer|)) (|bound| #4#)
          (|lo| (|Integer|)) (|mx| #4#) (|mn| (|Integer|))
          (|step| (|Integer|)))
         (SEQ (LETT |step| (SPADCALL |seg| (QREFELT $ 50)))
              (EXIT
               (COND ((ZEROP |step|) (|error| "zero step size"))
                     (#5='T
                      (SEQ (LETT |mn| (SPADCALL |x| (QREFELT $ 9)))
                           (LETT |mx| (SPADCALL |x| (QREFELT $ 10)))
                           (LETT |lo| (SPADCALL |seg| (QREFELT $ 31)))
                           (LETT |bound| (COND ((< |step| 0) |mn|) (#5# |mx|)))
                           (LETT |hi|
                                 (COND
                                  ((SPADCALL |seg| (QREFELT $ 32))
                                   (SPADCALL |seg| (QREFELT $ 33)))
                                  (#5# |bound|)))
                           (LETT |n|
                                 (* (SPADCALL |step| (QREFELT $ 51))
                                    (- |hi| |lo|)))
                           (EXIT
                            (COND ((< |n| 0) (SPADCALL (QREFELT $ 41)))
                                  (#5#
                                   (SEQ
                                    (LETT |n|
                                          (+ 1
                                             (QUOTIENT2 (- |hi| |lo|) |step|)))
                                    (LETT |z|
                                          (SPADCALL
                                           (PROG1 (LETT #3# |n|)
                                             (|check_subtype2| (>= #3# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #3#))
                                           (SPADCALL |x| |mn| (QREFELT $ 11))
                                           (QREFELT $ 42)))
                                    (SEQ (LETT |j| |mn|) (LETT |i| |lo|)
                                         (LETT #2# |hi|) (LETT #1# |step|) G190
                                         (COND
                                          ((IF (MINUSP #1#)
                                               (< |i| #2#)
                                               (> |i| #2#))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (SPADCALL |z| |j|
                                                     (SPADCALL |x| |i|
                                                               (QREFELT $ 11))
                                                     (QREFELT $ 27))))
                                         (LETT |i|
                                               (PROG1 (+ |i| #1#)
                                                 (LETT |j| (+ |j| 1))))
                                         (GO G190) G191 (EXIT NIL))
                                    (EXIT |z|)))))))))))) 

(SDEFUN |A1AGG-;insert;2AIA;18| ((|a| (A)) (|b| (A)) (|i| (|Integer|)) ($ (A)))
        (SPROG
         ((|k| NIL) (#1=#:G880 NIL) (|j| NIL) (#2=#:G879 NIL) (#3=#:G878 NIL)
          (|y| (A)) (|n| (|Integer|)) (|m| (|Integer|)))
         (SEQ (LETT |m| (SPADCALL |b| (QREFELT $ 9)))
              (LETT |n| (SPADCALL |b| (QREFELT $ 10)))
              (COND
               ((OR (< |i| |m|) (> |i| |n|))
                (EXIT (|error| "index out of range"))))
              (LETT |y|
                    (|A1AGG-;stupidnew|
                     (+ (SPADCALL |a| (QREFELT $ 47))
                        (SPADCALL |b| (QREFELT $ 47)))
                     |a| |b| $))
              (SEQ (LETT |j| |m|) (LETT #3# (- |i| 1))
                   (LETT |k| (SPADCALL |y| (QREFELT $ 9))) G190
                   (COND ((> |j| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |y| |k| (SPADCALL |b| |j| (QREFELT $ 11))
                               (QREFELT $ 27))))
                   (LETT |k| (PROG1 (+ |k| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (SEQ (LETT |j| (SPADCALL |a| (QREFELT $ 9)))
                   (LETT #2# (SPADCALL |a| (QREFELT $ 10))) (LETT |k| |k|) G190
                   (COND ((> |j| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |y| |k| (SPADCALL |a| |j| (QREFELT $ 11))
                               (QREFELT $ 27))))
                   (LETT |k| (PROG1 (+ |k| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (SEQ (LETT |j| |i|) (LETT #1# |n|) (LETT |k| |k|) G190
                   (COND ((> |j| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |y| |k| (SPADCALL |b| |j| (QREFELT $ 11))
                               (QREFELT $ 27))))
                   (LETT |k| (PROG1 (+ |k| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |y|)))) 

(SDEFUN |A1AGG-;copy;2A;19| ((|x| (A)) ($ (A)))
        (SPROG ((#1=#:G885 NIL) (|i| NIL) (|j| NIL) (|y| (A)))
               (SEQ
                (LETT |y|
                      (|A1AGG-;stupidnew| (SPADCALL |x| (QREFELT $ 47)) |x| |x|
                       $))
                (SEQ (LETT |j| (SPADCALL |y| (QREFELT $ 9)))
                     (LETT |i| (SPADCALL |x| (QREFELT $ 9)))
                     (LETT #1# (SPADCALL |x| (QREFELT $ 10))) G190
                     (COND ((> |i| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |y| |j| (SPADCALL |x| |i| (QREFELT $ 11))
                                 (QREFELT $ 27))))
                     (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT |y|)))) 

(SDEFUN |A1AGG-;copyInto!;2AIA;20|
        ((|y| (A)) (|x| (A)) (|s| (|Integer|)) ($ (A)))
        (SPROG ((#1=#:G892 NIL) (|i| NIL) (|j| NIL))
               (SEQ
                (COND
                 ((OR (< |s| (SPADCALL |y| (QREFELT $ 9)))
                      (> (+ |s| (SPADCALL |x| (QREFELT $ 47)))
                         (+ (SPADCALL |y| (QREFELT $ 10)) 1)))
                  (|error| "index out of range"))
                 ('T
                  (SEQ
                   (SEQ (LETT |j| |s|) (LETT |i| (SPADCALL |x| (QREFELT $ 9)))
                        (LETT #1# (SPADCALL |x| (QREFELT $ 10))) G190
                        (COND ((> |i| #1#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SPADCALL |y| |j| (SPADCALL |x| |i| (QREFELT $ 11))
                                    (QREFELT $ 27))))
                        (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1))))
                        (GO G190) G191 (EXIT NIL))
                   (EXIT |y|))))))) 

(SDEFUN |A1AGG-;construct;LA;21| ((|l| (|List| S)) ($ (A)))
        (SPROG ((|i| NIL) (#1=#:G898 NIL) (|x| NIL) (|a| (A)))
               (SEQ
                (COND ((NULL |l|) (SPADCALL (QREFELT $ 41)))
                      ('T
                       (SEQ
                        (LETT |a|
                              (SPADCALL (LENGTH |l|) (|SPADfirst| |l|)
                                        (QREFELT $ 42)))
                        (SEQ (LETT |x| NIL) (LETT #1# |l|)
                             (LETT |i| (SPADCALL |a| (QREFELT $ 9))) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ (EXIT (SPADCALL |a| |i| |x| (QREFELT $ 27))))
                             (LETT |i| (PROG1 (+ |i| 1) (LETT #1# (CDR #1#))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT |a|))))))) 

(SDEFUN |A1AGG-;delete;AUsA;22|
        ((|a| (A)) (|s| (|UniversalSegment| (|Integer|))) ($ (A)))
        (SPROG
         ((|k| NIL) (#1=#:G911 NIL) (|i| NIL) (#2=#:G910 NIL) (|r| (A))
          (#3=#:G902 NIL) (|h| (|Integer|)) (|l| (|Integer|)))
         (SEQ (LETT |l| (SPADCALL |s| (QREFELT $ 31)))
              (LETT |h|
                    (COND
                     ((SPADCALL |s| (QREFELT $ 32))
                      (SPADCALL |s| (QREFELT $ 33)))
                     (#4='T (SPADCALL |a| (QREFELT $ 10)))))
              (COND
               ((OR (< |l| (SPADCALL |a| (QREFELT $ 9)))
                    (> |h| (SPADCALL |a| (QREFELT $ 10))))
                (EXIT (|error| "index out of range"))))
              (EXIT
               (COND ((< |h| |l|) (SPADCALL |a| (QREFELT $ 57)))
                     (#4#
                      (SEQ
                       (LETT |r|
                             (|A1AGG-;stupidnew|
                              (PROG1
                                  (LETT #3#
                                        (-
                                         (+
                                          (- (SPADCALL |a| (QREFELT $ 47)) |h|)
                                          |l|)
                                         1))
                                (|check_subtype2| (>= #3# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #3#))
                              |a| |a| $))
                       (SEQ (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                            (LETT #2# (- |l| 1))
                            (LETT |k| (SPADCALL |r| (QREFELT $ 9))) G190
                            (COND ((> |i| #2#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL |r| |k|
                                        (SPADCALL |a| |i| (QREFELT $ 11))
                                        (QREFELT $ 27))))
                            (LETT |k| (PROG1 (+ |k| 1) (LETT |i| (+ |i| 1))))
                            (GO G190) G191 (EXIT NIL))
                       (SEQ (LETT |i| (+ |h| 1))
                            (LETT #1# (SPADCALL |a| (QREFELT $ 10)))
                            (LETT |k| |k|) G190 (COND ((> |i| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL |r| |k|
                                        (SPADCALL |a| |i| (QREFELT $ 11))
                                        (QREFELT $ 27))))
                            (LETT |k| (PROG1 (+ |k| 1) (LETT |i| (+ |i| 1))))
                            (GO G190) G191 (EXIT NIL))
                       (EXIT |r|)))))))) 

(SDEFUN |A1AGG-;delete;AIA;23| ((|x| (A)) (|i| (|Integer|)) ($ (A)))
        (SPROG
         ((#1=#:G922 NIL) (|j| NIL) (#2=#:G921 NIL) (|y| (A)) (#3=#:G914 NIL))
         (SEQ
          (COND
           ((OR (< |i| (SPADCALL |x| (QREFELT $ 9)))
                (> |i| (SPADCALL |x| (QREFELT $ 10))))
            (|error| "index out of range"))
           ('T
            (SEQ
             (LETT |y|
                   (|A1AGG-;stupidnew|
                    (PROG1 (LETT #3# (- (SPADCALL |x| (QREFELT $ 47)) 1))
                      (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #3#))
                    |x| |x| $))
             (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 9))) (LETT #2# (- |i| 1))
                  (LETT |i| (SPADCALL |y| (QREFELT $ 9))) G190
                  (COND ((> |j| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (SPADCALL |y| |i| (SPADCALL |x| |j| (QREFELT $ 11))
                              (QREFELT $ 27))))
                  (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                  G191 (EXIT NIL))
             (SEQ (LETT |j| (+ |i| 1)) (LETT #1# (SPADCALL |x| (QREFELT $ 10)))
                  (LETT |i| |i|) G190 (COND ((> |j| #1#) (GO G191)))
                  (SEQ
                   (EXIT
                    (SPADCALL |y| |i| (SPADCALL |x| |j| (QREFELT $ 11))
                              (QREFELT $ 27))))
                  (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                  G191 (EXIT NIL))
             (EXIT |y|))))))) 

(SDEFUN |A1AGG-;reverse!;2A;24| ((|x| (A)) ($ (A)))
        (SPROG ((#1=#:G928 NIL) (|i| NIL) (|n| (|Integer|)) (|m| (|Integer|)))
               (SEQ (LETT |m| (SPADCALL |x| (QREFELT $ 9)))
                    (LETT |n| (SPADCALL |x| (QREFELT $ 10)))
                    (SEQ (LETT |i| 0) (LETT #1# (QUOTIENT2 (- |n| |m|) 2)) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL |x| (+ |m| |i|) (- |n| |i|)
                                     (QREFELT $ 61))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |x|)))) 

(SDEFUN |A1AGG-;concat;LA;25| ((|l| (|List| A)) ($ (A)))
        (SPROG
         ((|i| (|Integer|)) (#1=#:G940 NIL) (|a| NIL) (|r| (A))
          (|n| #2=(|NonNegativeInteger|)) (#3=#:G930 NIL) (#4=#:G929 #2#)
          (#5=#:G931 #2#) (#6=#:G939 NIL))
         (SEQ
          (COND ((NULL |l|) (SPADCALL (QREFELT $ 41)))
                (#7='T
                 (SEQ
                  (LETT |n|
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |a| NIL) (LETT #6# |l|) G190
                              (COND
                               ((OR (ATOM #6#)
                                    (PROGN (LETT |a| (CAR #6#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #5# (SPADCALL |a| (QREFELT $ 47)))
                                 (COND (#3# (LETT #4# (+ #4# #5#)))
                                       ('T
                                        (PROGN
                                         (LETT #4# #5#)
                                         (LETT #3# 'T)))))))
                              (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                         (COND (#3# #4#) (#7# 0))))
                  (EXIT
                   (COND ((EQL |n| 0) (SPADCALL (QREFELT $ 41)))
                         (#7#
                          (SEQ
                           (LETT |i|
                                 (SPADCALL
                                  (LETT |r|
                                        (SPADCALL |n|
                                                  (|A1AGG-;stupidget| |l| $)
                                                  (QREFELT $ 42)))
                                  (QREFELT $ 9)))
                           (SEQ (LETT |a| NIL) (LETT #1# |l|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |a| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ (SPADCALL |r| |a| |i| (QREFELT $ 63))
                                     (EXIT
                                      (LETT |i|
                                            (+ |i|
                                               (SPADCALL |a|
                                                         (QREFELT $ 47))))))
                                (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                           (EXIT |r|))))))))))) 

(SDEFUN |A1AGG-;sorted?;MAB;26|
        ((|f| (|Mapping| (|Boolean|) S S)) (|a| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G946 NIL) (#2=#:G947 NIL) (#3=#:G948 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                         (LETT #3# (- (SPADCALL |a| (QREFELT $ 10)) 1)) G190
                         (COND ((> |i| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((NULL
                              (SPADCALL (SPADCALL |a| |i| (QREFELT $ 11))
                                        (SPADCALL |a| (+ |i| 1) (QREFELT $ 11))
                                        |f|))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# NIL) (GO #4=#:G945)))
                              (GO #5=#:G943))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |A1AGG-;concat;3A;27| ((|x| (A)) (|y| (A)) ($ (A)))
        (SPROG ((|i| (|Integer|)) (|z| (A)))
               (SEQ
                (LETT |z|
                      (|A1AGG-;stupidnew|
                       (+ (SPADCALL |x| (QREFELT $ 47))
                          (SPADCALL |y| (QREFELT $ 47)))
                       |x| |y| $))
                (SPADCALL |z| |x| (LETT |i| (SPADCALL |z| (QREFELT $ 9)))
                          (QREFELT $ 63))
                (SPADCALL |z| |y| (+ |i| (SPADCALL |x| (QREFELT $ 47)))
                          (QREFELT $ 63))
                (EXIT |z|)))) 

(SDEFUN |A1AGG-;coerce;AOf;28| ((|r| (A)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G955 NIL) (|k| NIL) (#2=#:G954 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |k| (SPADCALL |r| (QREFELT $ 9)))
                       (LETT #1# (SPADCALL |r| (QREFELT $ 10))) G190
                       (COND ((> |k| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |r| |k| (QREFELT $ 11))
                                          (QREFELT $ 69))
                                #2#))))
                       (LETT |k| (+ |k| 1)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 70))))) 

(SDEFUN |A1AGG-;=;2AB;29| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G962 NIL) (#2=#:G963 NIL) (#3=#:G964 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL (SPADCALL |x| (QREFELT $ 47))
                             (SPADCALL |y| (QREFELT $ 47)) (QREFELT $ 72))
                   NIL)
                  ('T
                   (SEQ
                    (SEQ
                     (EXIT
                      (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 9)))
                           (LETT #3# (SPADCALL |x| (QREFELT $ 10))) G190
                           (COND ((> |i| #3#) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL
                                (SPADCALL (SPADCALL |x| |i| (QREFELT $ 11))
                                          (SPADCALL |y| |i| (QREFELT $ 11))
                                          (QREFELT $ 73)))
                               (PROGN
                                (LETT #1#
                                      (PROGN (LETT #2# NIL) (GO #4=#:G961)))
                                (GO #5=#:G958))))))
                           (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                     #5# (EXIT #1#))
                    (EXIT 'T)))))
                #4# (EXIT #2#)))) 

(SDEFUN |A1AGG-;position;SA2I;30|
        ((|x| (S)) (|t| (A)) (|s| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((#1=#:G971 NIL) (#2=#:G972 NIL) (#3=#:G973 NIL) (|k| NIL)
          (|n| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL |t| (QREFELT $ 10)))
                (COND
                 ((OR (< |s| (SPADCALL |t| (QREFELT $ 9))) (> |s| |n|))
                  (EXIT (|error| "index out of range"))))
                (SEQ
                 (EXIT
                  (SEQ (LETT |k| |s|) (LETT #3# |n|) G190
                       (COND ((> |k| #3#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (SPADCALL |t| |k| (QREFELT $ 11)) |x|
                                     (QREFELT $ 73))
                           (PROGN
                            (LETT #1# (PROGN (LETT #2# |k|) (GO #4=#:G970)))
                            (GO #5=#:G968))))))
                       (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL)))
                 #5# (EXIT #1#))
                (EXIT (- (SPADCALL |t| (QREFELT $ 9)) 1))))
          #4# (EXIT #2#)))) 

(SDEFUN |A1AGG-;<;2AB;31| ((|a| (A)) (|b| (A)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G979 NIL) (#2=#:G980 NIL) (#3=#:G981 NIL) (|i| NIL)
          (#4=#:G982 NIL) (|j| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (EXIT
              (SEQ (LETT |j| (SPADCALL |b| (QREFELT $ 9)))
                   (LETT #4# (SPADCALL |b| (QREFELT $ 10)))
                   (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                   (LETT #3# (SPADCALL |a| (QREFELT $ 10))) G190
                   (COND ((OR (> |i| #3#) (> |j| #4#)) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |a| |i| (QREFELT $ 11))
                                 (SPADCALL |b| |j| (QREFELT $ 11))
                                 (QREFELT $ 39))
                       (PROGN
                        (LETT #1#
                              (PROGN
                               (LETT #2#
                                     (SPADCALL
                                      (SPADCALL |a| |i| (QREFELT $ 48))
                                      (SPADCALL |b| |j| (QREFELT $ 48))
                                      (QREFELT $ 76)))
                               (GO #5=#:G978)))
                        (GO #6=#:G976))))))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL)))
             #6# (EXIT #1#))
            (EXIT
             (< (SPADCALL |a| (QREFELT $ 47)) (SPADCALL |b| (QREFELT $ 47))))))
          #5# (EXIT #2#)))) 

(SDEFUN |A1AGG-;smaller?;2AB;32| ((|a| (A)) (|b| (A)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G988 NIL) (#2=#:G989 NIL) (#3=#:G990 NIL) (|i| NIL)
          (#4=#:G991 NIL) (|j| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (EXIT
              (SEQ (LETT |j| (SPADCALL |b| (QREFELT $ 9)))
                   (LETT #4# (SPADCALL |b| (QREFELT $ 10)))
                   (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                   (LETT #3# (SPADCALL |a| (QREFELT $ 10))) G190
                   (COND ((OR (> |i| #3#) (> |j| #4#)) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |a| |i| (QREFELT $ 11))
                                 (SPADCALL |b| |j| (QREFELT $ 11))
                                 (QREFELT $ 39))
                       (PROGN
                        (LETT #1#
                              (PROGN
                               (LETT #2#
                                     (SPADCALL
                                      (SPADCALL |a| |i| (QREFELT $ 11))
                                      (SPADCALL |b| |j| (QREFELT $ 11))
                                      (QREFELT $ 78)))
                               (GO #5=#:G987)))
                        (GO #6=#:G985))))))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL)))
             #6# (EXIT #1#))
            (EXIT
             (< (SPADCALL |a| (QREFELT $ 47)) (SPADCALL |b| (QREFELT $ 47))))))
          #5# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |OneDimensionalArrayAggregate&;|)) 

(DEFUN |OneDimensionalArrayAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|OneDimensionalArrayAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 80))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#2| '(|BasicType|))
            (QSETREFV $ 40
                      (CONS (|dispatchFunction| |A1AGG-;reduce;MA3S;12|) $))))
          (COND
           ((|HasCategory| |#2| '(|CoercibleTo| (|OutputForm|)))
            (QSETREFV $ 71
                      (CONS (|dispatchFunction| |A1AGG-;coerce;AOf;28|) $))))
          (COND
           ((|HasCategory| |#2| '(|BasicType|))
            (PROGN
             (QSETREFV $ 74 (CONS (|dispatchFunction| |A1AGG-;=;2AB;29|) $))
             (QSETREFV $ 75
                       (CONS (|dispatchFunction| |A1AGG-;position;SA2I;30|)
                             $)))))
          (COND
           ((|HasCategory| |#2| '(|OrderedSet|))
            (QSETREFV $ 77 (CONS (|dispatchFunction| |A1AGG-;<;2AB;31|) $))))
          (COND
           ((|HasCategory| |#2| '(|Comparable|))
            (QSETREFV $ 79
                      (CONS (|dispatchFunction| |A1AGG-;smaller?;2AB;32|) $))))
          $))) 

(MAKEPROP '|OneDimensionalArrayAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Integer|)
              (0 . |minIndex|) (5 . |maxIndex|) (10 . |qelt|) (|List| 7)
              |A1AGG-;parts;AL;1| (|Mapping| 18 7 7)
              (|FiniteLinearAggregateSort| 7 6) (16 . |quickSort|)
              |A1AGG-;sort!;M2A;2| (|Boolean|) (|Mapping| 18 7)
              |A1AGG-;any?;MAB;3| |A1AGG-;every?;MAB;4| |A1AGG-;position;MAI;5|
              (|Union| 7 '#1="failed") |A1AGG-;find;MAU;6|
              (|NonNegativeInteger|) |A1AGG-;count;MANni;7| (22 . |qsetelt!|)
              (|Mapping| 7 7) |A1AGG-;map!;M2A;8| (|UniversalSegment| 8)
              (29 . |low|) (34 . |hasHi|) (39 . |high|)
              |A1AGG-;setelt!;AUs2S;9| (44 . |empty?|) (|Mapping| 7 7 7)
              |A1AGG-;reduce;MAS;10| |A1AGG-;reduce;MA2S;11| (49 . ~=)
              (55 . |reduce|) (63 . |empty|) (67 . |new|) (73 . |first|)
              (78 . |Zero|) (82 . |Zero|) |A1AGG-;map;M3A;15| (86 . |#|)
              (91 . |elt|) |A1AGG-;merge;M3A;16| (97 . |incr|) (102 . |sign|)
              |A1AGG-;elt;AUsA;17| |A1AGG-;insert;2AIA;18| |A1AGG-;copy;2A;19|
              |A1AGG-;copyInto!;2AIA;20| |A1AGG-;construct;LA;21|
              (107 . |copy|) |A1AGG-;delete;AUsA;22| |A1AGG-;delete;AIA;23|
              (|Void|) (112 . |swap!|) |A1AGG-;reverse!;2A;24|
              (119 . |copyInto!|) (|List| $) |A1AGG-;concat;LA;25|
              |A1AGG-;sorted?;MAB;26| |A1AGG-;concat;3A;27| (|OutputForm|)
              (126 . |coerce|) (131 . |bracket|) (136 . |coerce|) (141 . ~=)
              (147 . =) (153 . =) (159 . |position|) (166 . <) (172 . <)
              (178 . |smaller?|) (184 . |smaller?|))
           '#(|sorted?| 190 |sort!| 196 |smaller?| 202 |setelt!| 208 |reverse!|
              215 |reduce| 220 |position| 241 |parts| 254 |merge| 259 |map!|
              266 |map| 272 |insert| 279 |find| 286 |every?| 292 |elt| 298
              |delete| 304 |count| 316 |copyInto!| 322 |copy| 329 |construct|
              334 |concat| 339 |coerce| 350 |any?| 355 = 361 < 367)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((= ((|Boolean|) |#1| |#1|)) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((|smaller?| ((|Boolean|) |#1| |#1|)) T)
                                   '((< ((|Boolean|) |#1| |#1|)) T)
                                   '((|sort!| (|#1| |#1|)) T)
                                   '((|sort!|
                                      (|#1| (|Mapping| (|Boolean|) |#2| |#2|)
                                       |#1|))
                                     T)
                                   '((|reverse!| (|#1| |#1|)) T)
                                   '((|copyInto!| (|#1| |#1| |#1| (|Integer|)))
                                     T)
                                   '((|sorted?| ((|Boolean|) |#1|)) T)
                                   '((|merge| (|#1| |#1| |#1|)) T)
                                   '((|position|
                                      ((|Integer|) |#2| |#1| (|Integer|)))
                                     T)
                                   '((|position| ((|Integer|) |#2| |#1|)) T)
                                   '((|position|
                                      ((|Integer|) (|Mapping| (|Boolean|) |#2|)
                                       |#1|))
                                     T)
                                   '((|sorted?|
                                      ((|Boolean|)
                                       (|Mapping| (|Boolean|) |#2| |#2|) |#1|))
                                     T)
                                   '((|merge|
                                      (|#1| (|Mapping| (|Boolean|) |#2| |#2|)
                                       |#1| |#1|))
                                     T)
                                   '((|setelt!|
                                      (|#2| |#1|
                                       (|UniversalSegment| (|Integer|)) |#2|))
                                     T)
                                   '((|insert| (|#1| |#1| |#1| (|Integer|))) T)
                                   '((|insert| (|#1| |#2| |#1| (|Integer|))) T)
                                   '((|delete|
                                      (|#1| |#1|
                                       (|UniversalSegment| (|Integer|))))
                                     T)
                                   '((|delete| (|#1| |#1| (|Integer|))) T)
                                   '((|map|
                                      (|#1| (|Mapping| |#2| |#2| |#2|) |#1|
                                       |#1|))
                                     T)
                                   '((|concat| (|#1| (|List| |#1|))) T)
                                   '((|concat| (|#1| |#1| |#1|)) T)
                                   '((|concat| (|#1| |#2| |#1|)) T)
                                   '((|concat| (|#1| |#1| |#2|)) T)
                                   '((|elt|
                                      (|#1| |#1|
                                       (|UniversalSegment| (|Integer|))))
                                     T)
                                   '((|construct| (|#1| (|List| |#2|))) T)
                                   '((|find|
                                      ((|Union| |#2| #1#)
                                       (|Mapping| (|Boolean|) |#2|) |#1|))
                                     T)
                                   '((|reduce|
                                      (|#2| (|Mapping| |#2| |#2| |#2|) |#1|))
                                     T)
                                   '((|reduce|
                                      (|#2| (|Mapping| |#2| |#2| |#2|) |#1|
                                       |#2|))
                                     T)
                                   '((|reduce|
                                      (|#2| (|Mapping| |#2| |#2| |#2|) |#1|
                                       |#2| |#2|))
                                     T)
                                   '((|elt| (|#2| |#1| (|Integer|))) T)
                                   '((|elt| (|#2| |#1| (|Integer|) |#2|)) T)
                                   '((|setelt!| (|#2| |#1| (|Integer|) |#2|))
                                     T)
                                   '((|count|
                                      ((|NonNegativeInteger|) |#2| |#1|))
                                     T)
                                   '((|parts| ((|List| |#2|) |#1|)) T)
                                   '((|count|
                                      ((|NonNegativeInteger|)
                                       (|Mapping| (|Boolean|) |#2|) |#1|))
                                     T)
                                   '((|every?|
                                      ((|Boolean|) (|Mapping| (|Boolean|) |#2|)
                                       |#1|))
                                     T)
                                   '((|any?|
                                      ((|Boolean|) (|Mapping| (|Boolean|) |#2|)
                                       |#1|))
                                     T)
                                   '((|map!| (|#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|map| (|#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|copy| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 79
                                            '(1 6 8 0 9 1 6 8 0 10 2 6 7 0 8 11
                                              2 15 6 14 6 16 3 6 7 0 8 7 27 1
                                              30 8 0 31 1 30 18 0 32 1 30 8 0
                                              33 1 6 18 0 35 2 7 18 0 0 39 4 0
                                              7 36 0 7 7 40 0 6 0 41 2 6 0 25 7
                                              42 1 6 7 0 43 0 25 0 44 0 8 0 45
                                              1 6 25 0 47 2 6 7 0 8 48 1 30 8 0
                                              50 1 8 8 0 51 1 6 0 0 57 3 6 60 0
                                              8 8 61 3 6 0 0 0 8 63 1 7 68 0 69
                                              1 68 0 64 70 1 0 68 0 71 2 8 18 0
                                              0 72 2 7 18 0 0 73 2 0 18 0 0 74
                                              3 0 8 7 0 8 75 2 7 18 0 0 76 2 0
                                              18 0 0 77 2 7 18 0 0 78 2 0 18 0
                                              0 79 2 0 18 14 0 66 2 0 0 14 0 17
                                              2 0 18 0 0 79 3 0 7 0 30 7 34 1 0
                                              0 0 62 2 0 7 36 0 37 4 0 7 36 0 7
                                              7 40 3 0 7 36 0 7 38 3 0 8 7 0 8
                                              75 2 0 8 19 0 22 1 0 12 0 13 3 0
                                              0 14 0 0 49 2 0 0 28 0 29 3 0 0
                                              36 0 0 46 3 0 0 0 0 8 53 2 0 23
                                              19 0 24 2 0 18 19 0 21 2 0 0 0 30
                                              52 2 0 0 0 30 58 2 0 0 0 8 59 2 0
                                              25 19 0 26 3 0 0 0 0 8 55 1 0 0 0
                                              54 1 0 0 12 56 2 0 0 0 0 67 1 0 0
                                              64 65 1 0 68 0 71 2 0 18 19 0 20
                                              2 0 18 0 0 74 2 0 18 0 0 77)))))
           '|lookupComplete|)) 

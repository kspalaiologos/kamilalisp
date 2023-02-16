
(SDEFUN |CFACET;cubicalFacet;IL$;1|
        ((|mul1| (|Integer|)) (|fac1| (|List| (|Segment| (|Integer|))))
         ($ ($)))
        (SPROG
         ((|mul2| (|Integer|)) (|fac2| (|List| (|Segment| (|Integer|))))
          (|invert| (|Boolean|)) (|interv| (|Segment| (|Integer|)))
          (|hi| (|Integer|)) (|lo| (|Integer|)) (#1=#:G734 NIL) (|x| NIL))
         (SEQ (LETT |mul2| |mul1|) (LETT |fac2| NIL) (LETT |invert| NIL)
              (SEQ (LETT |x| NIL) (LETT #1# |fac1|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |interv| |x|)
                        (LETT |lo| (SPADCALL |x| (QREFELT $ 9)))
                        (LETT |hi| (SPADCALL |x| (QREFELT $ 10)))
                        (COND
                         ((> |lo| |hi|)
                          (SEQ
                           (LETT |interv| (SPADCALL |hi| |lo| (QREFELT $ 11)))
                           (EXIT (LETT |invert| (NULL |invert|))))))
                        (EXIT
                         (LETT |fac2|
                               (SPADCALL |fac2| |interv| (QREFELT $ 13)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (COND (|invert| (LETT |mul2| (- |mul2|))))
              (EXIT (CONS |mul2| |fac2|))))) 

(SDEFUN |CFACET;cubicalFacet;IL$;2|
        ((|mul1| (|Integer|)) (|fac1| (|List| (|List| (|Integer|)))) ($ ($)))
        (SPROG
         ((|fac2| (|List| (|Segment| (|Integer|))))
          (|interv| (|Segment| (|Integer|))) (#1=#:G744 NIL) (|x| NIL))
         (SEQ (LETT |fac2| NIL)
              (SEQ (LETT |x| NIL) (LETT #1# |fac1|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     ((SPADCALL (LENGTH |x|) 2 (QREFELT $ 16))
                      (|error| "inner list should contain low, high")))
                    (LETT |interv|
                          (SPADCALL (|SPADfirst| |x|)
                                    (SPADCALL |x| (QREFELT $ 18))
                                    (QREFELT $ 11)))
                    (EXIT
                     (LETT |fac2| (SPADCALL |fac2| |interv| (QREFELT $ 13)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |mul1| |fac2|))))) 

(SDEFUN |CFACET;cubicalFacet;I2$;3|
        ((|mul1| (|Integer|)) (|fac1| (|CubicalFacet|)) ($ ($)))
        (SPROG ((|fac2| (|List| (|Segment| (|Integer|)))))
               (SEQ (LETT |fac2| (SPADCALL |fac1| (QREFELT $ 22)))
                    (EXIT (CONS |mul1| |fac2|))))) 

(PUT '|CFACET;getIntervals;$L;4| '|SPADreplace| 'QCDR) 

(SDEFUN |CFACET;getIntervals;$L;4|
        ((|orf| ($)) ($ (|List| (|Segment| (|Integer|))))) (QCDR |orf|)) 

(SDEFUN |CFACET;order;$Nni;5| ((|f| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|value| (|NonNegativeInteger|)) (#1=#:G750 NIL) (|hi| (|Integer|))
          (|lo| (|Integer|)) (#2=#:G755 NIL) (|seg| NIL)
          (|facet| (|List| (|Segment| (|Integer|)))))
         (SEQ (LETT |value| 0) (LETT |facet| (QCDR |f|))
              (SEQ (LETT |seg| NIL) (LETT #2# |facet|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |seg| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |lo| (SPADCALL |seg| (QREFELT $ 9)))
                        (LETT |hi| (SPADCALL |seg| (QREFELT $ 10)))
                        (EXIT
                         (LETT |value|
                               (+ |value|
                                  (PROG1 (LETT #1# (ABS (- |hi| |lo|)))
                                    (|check_subtype2| (>= #1# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #1#))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |value|)))) 

(PUT '|CFACET;getMult;$I;6| '|SPADreplace| 'QCAR) 

(SDEFUN |CFACET;getMult;$I;6| ((|orf| ($)) ($ (|Integer|))) (QCAR |orf|)) 

(SDEFUN |CFACET;setMult;$I$;7| ((|orf| ($)) (|m| (|Integer|)) ($ ($)))
        (SPROG ((|fac2| (|List| (|Segment| (|Integer|)))))
               (SEQ (LETT |fac2| (SPADCALL |orf| (QREFELT $ 24)))
                    (EXIT (SPADCALL |m| |fac2| (QREFELT $ 14)))))) 

(SDEFUN |CFACET;position;$LI;8| ((|e| ($)) (|lst| (|List| $)) ($ (|Integer|)))
        (SPROG ((#1=#:G768 NIL) (|res| (|Integer|)) (#2=#:G769 NIL) (|x| NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |res| 1)
                      (SEQ (LETT |x| NIL) (LETT #2# |lst|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (COND
                             ((SPADCALL (QCDR |e|) (QCDR |x|) (QREFELT $ 29))
                              (SEQ
                               (COND
                                ((EQL (QCAR |e|) (QCAR |x|))
                                 (PROGN (LETT #1# |res|) (GO #3=#:G767))))
                               (EXIT (PROGN (LETT #1# (- |res|)) (GO #3#))))))
                            (EXIT (LETT |res| (+ |res| 1))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (PROGN (LETT #1# 0) (GO #3#)))))
                #3# (EXIT #1#)))) 

(SDEFUN |CFACET;product;3$;9| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((|bint| #1=(|List| (|Segment| (|Integer|)))) (|aint| #1#))
               (SEQ (LETT |aint| (SPADCALL |a| (QREFELT $ 24)))
                    (LETT |bint| (SPADCALL |b| (QREFELT $ 24)))
                    (EXIT
                     (SPADCALL 1 (SPADCALL |aint| |bint| (QREFELT $ 32))
                               (QREFELT $ 14)))))) 

(SDEFUN |CFACET;boundaryOneDimension|
        ((|orf| ($)) (|dim| (|NonNegativeInteger|)) (|invert| (|Boolean|))
         ($ (|List| $)))
        (SPROG
         ((|res| (|List| $)) (|r2| ($)) (|r1| ($)) (|mult| (|Integer|))
          (|subFacet2| (|List| (|Segment| (|Integer|))))
          (|subFacet1| (|List| (|Segment| (|Integer|)))) (|hi| (|Integer|))
          (|lo| (|Integer|)) (#1=#:G781 NIL) (|seg| NIL) (#2=#:G782 NIL)
          (|segn| NIL) (|facet| (|List| (|Segment| (|Integer|)))))
         (SEQ (LETT |facet| (QCDR |orf|)) (LETT |mult| (QCAR |orf|))
              (LETT |subFacet1| NIL) (LETT |subFacet2| NIL)
              (SEQ (LETT |segn| 1) (LETT #2# (LENGTH |facet|)) (LETT |seg| NIL)
                   (LETT #1# |facet|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |seg| (CAR #1#)) NIL)
                         (|greater_SI| |segn| #2#))
                     (GO G191)))
                   (SEQ (LETT |lo| (SPADCALL |seg| (QREFELT $ 9)))
                        (LETT |hi| (SPADCALL |seg| (QREFELT $ 10)))
                        (EXIT
                         (COND
                          ((EQL |segn| |dim|)
                           (SEQ
                            (LETT |subFacet1|
                                  (SPADCALL |subFacet1|
                                            (SPADCALL |lo| |lo| (QREFELT $ 11))
                                            (QREFELT $ 13)))
                            (EXIT
                             (LETT |subFacet2|
                                   (SPADCALL |subFacet2|
                                             (SPADCALL |hi| |hi|
                                                       (QREFELT $ 11))
                                             (QREFELT $ 13))))))
                          ('T
                           (SEQ
                            (LETT |subFacet1|
                                  (SPADCALL |subFacet1| |seg| (QREFELT $ 13)))
                            (EXIT
                             (LETT |subFacet2|
                                   (SPADCALL |subFacet2| |seg|
                                             (QREFELT $ 13)))))))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |segn| (|inc_SI| |segn|))))
                   (GO G190) G191 (EXIT NIL))
              (COND (|invert| (LETT |mult| (- |mult|)))) (LETT |res| NIL)
              (LETT |r1| (SPADCALL (- |mult|) |subFacet1| (QREFELT $ 14)))
              (LETT |res| (SPADCALL |res| |r1| (QREFELT $ 35)))
              (LETT |r2| (SPADCALL |mult| |subFacet2| (QREFELT $ 14)))
              (LETT |res| (SPADCALL |res| |r2| (QREFELT $ 35))) (EXIT |res|)))) 

(SDEFUN |CFACET;boundary;$L;11| ((|orf| ($)) ($ (|List| $)))
        (SPROG
         ((|invert| (|Boolean|)) (|res| (|List| $)) (#1=#:G794 NIL) (|dim| NIL)
          (|dims| (|List| (|NonNegativeInteger|))) (|hi| (|Integer|))
          (|lo| (|Integer|)) (#2=#:G792 NIL) (|seg| NIL) (#3=#:G793 NIL)
          (|segn| NIL) (|facet| (|List| (|Segment| (|Integer|)))))
         (SEQ (LETT |facet| (QCDR |orf|)) (LETT |dims| NIL)
              (SEQ (LETT |segn| 1) (LETT #3# (LENGTH |facet|)) (LETT |seg| NIL)
                   (LETT #2# |facet|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |seg| (CAR #2#)) NIL)
                         (|greater_SI| |segn| #3#))
                     (GO G191)))
                   (SEQ (LETT |lo| (SPADCALL |seg| (QREFELT $ 9)))
                        (LETT |hi| (SPADCALL |seg| (QREFELT $ 10)))
                        (EXIT
                         (COND
                          ((SPADCALL |lo| |hi| (QREFELT $ 16))
                           (LETT |dims|
                                 (SPADCALL |dims| |segn| (QREFELT $ 37)))))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT |segn| (|inc_SI| |segn|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |res| NIL) (LETT |invert| NIL)
              (SEQ (LETT |dim| NIL) (LETT #1# |dims|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |dim| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |res|
                          (SPADCALL |res|
                                    (|CFACET;boundaryOneDimension| |orf| |dim|
                                     |invert| $)
                                    (QREFELT $ 38)))
                    (EXIT (LETT |invert| (NULL |invert|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |CFACET;addIfNew| ((|lst| (|List| $)) (|orf| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G799 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((NULL (SPADCALL |orf| (QREFELT $ 40)))
                    (COND
                     ((SPADCALL |orf| |lst| (QREFELT $ 41))
                      (PROGN (LETT #1# |lst|) (GO #2=#:G798))))))
                  (EXIT (SPADCALL |lst| |orf| (QREFELT $ 35)))))
                #2# (EXIT #1#)))) 

(SDEFUN |CFACET;addIfNew2|
        ((|lst| (|List| $)) (|orfs| (|List| $)) ($ (|List| $)))
        (SPROG ((|res| (|List| $)) (#1=#:G808 NIL) (|orf| NIL) (#2=#:G807 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |orfs| (QREFELT $ 42))
                    (PROGN (LETT #2# |lst|) (GO #3=#:G806))))
                  (LETT |res| (SPADCALL |lst| (QREFELT $ 43)))
                  (SEQ (LETT |orf| NIL) (LETT #1# |orfs|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |orf| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL (SPADCALL |orf| (QREFELT $ 40)))
                           (COND
                            ((NULL (SPADCALL |orf| |res| (QREFELT $ 41)))
                             (LETT |res|
                                   (SPADCALL |res| |orf| (QREFELT $ 35)))))))))
                       (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                  (EXIT |res|)))
                #3# (EXIT #2#)))) 

(SDEFUN |CFACET;allSubsets;$NniL;14|
        ((|orf| ($)) (|minDim| (|NonNegativeInteger|)) ($ (|List| $)))
        (SPROG
         ((|res| (|List| $)) (|sub| (|List| $)) (|rHi1| ($))
          (|rHi| #1=(|List| (|Segment| (|Integer|)))) (|rLo1| ($)) (|rLo| #1#)
          (|segHi| #2=(|Segment| (|Integer|))) (|segLo| #2#) (|hi| (|Integer|))
          (|lo| (|Integer|)) (#3=#:G821 NIL) (|x| NIL) (#4=#:G822 NIL)
          (|xn| NIL) (#5=#:G820 NIL)
          (|facet| (|List| (|Segment| (|Integer|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |facet| (QCDR |orf|)) (LETT |res| NIL)
                (COND
                 ((<= (SPADCALL |orf| (QREFELT $ 26)) |minDim|)
                  (PROGN (LETT #5# |res|) (GO #6=#:G819))))
                (SEQ (LETT |xn| 1) (LETT #4# (LENGTH |facet|)) (LETT |x| NIL)
                     (LETT #3# |facet|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL)
                           (|greater_SI| |xn| #4#))
                       (GO G191)))
                     (SEQ (LETT |lo| (SPADCALL |x| (QREFELT $ 9)))
                          (LETT |hi| (SPADCALL |x| (QREFELT $ 10)))
                          (EXIT
                           (COND
                            ((SPADCALL |lo| |hi| (QREFELT $ 16))
                             (SEQ
                              (LETT |segLo|
                                    (SPADCALL |lo| |lo| (QREFELT $ 11)))
                              (LETT |segHi|
                                    (SPADCALL |hi| |hi| (QREFELT $ 11)))
                              (LETT |rLo| (SPADCALL |facet| (QREFELT $ 44)))
                              (SPADCALL |rLo| |xn| |segLo| (QREFELT $ 45))
                              (LETT |rLo1| (SPADCALL 1 |rLo| (QREFELT $ 14)))
                              (LETT |res| (|CFACET;addIfNew| |res| |rLo1| $))
                              (LETT |rHi| (SPADCALL |facet| (QREFELT $ 44)))
                              (SPADCALL |rHi| |xn| |segHi| (QREFELT $ 45))
                              (LETT |rHi1| (SPADCALL 1 |rHi| (QREFELT $ 14)))
                              (LETT |res| (|CFACET;addIfNew| |res| |rHi1| $))
                              (COND
                               ((> (SPADCALL |rLo1| (QREFELT $ 26)) |minDim|)
                                (SEQ
                                 (LETT |sub|
                                       (SPADCALL |rLo1| |minDim|
                                                 (QREFELT $ 46)))
                                 (EXIT
                                  (COND
                                   ((NULL (SPADCALL |sub| (QREFELT $ 42)))
                                    (LETT |res|
                                          (|CFACET;addIfNew2| |res| |sub|
                                           $))))))))
                              (EXIT
                               (COND
                                ((> (SPADCALL |rHi1| (QREFELT $ 26)) |minDim|)
                                 (SEQ
                                  (LETT |sub|
                                        (SPADCALL |rHi1| |minDim|
                                                  (QREFELT $ 46)))
                                  (EXIT
                                   (COND
                                    ((NULL (SPADCALL |sub| (QREFELT $ 42)))
                                     (LETT |res|
                                           (|CFACET;addIfNew2| |res| |sub|
                                            $))))))))))))))
                     (LETT #3# (PROG1 (CDR #3#) (LETT |xn| (|inc_SI| |xn|))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #6# (EXIT #5#)))) 

(SDEFUN |CFACET;allSubsets;$2NniL;15|
        ((|orf| ($)) (|minDim| (|NonNegativeInteger|))
         (|maxDim| (|NonNegativeInteger|)) ($ (|List| $)))
        (SPROG
         ((|res2| (|List| $)) (#1=#:G829 NIL) (|y| NIL) (|res| (|List| $)))
         (SEQ (LETT |res| (SPADCALL |orf| |minDim| (QREFELT $ 46)))
              (LETT |res2| NIL)
              (SEQ (LETT |y| NIL) (LETT #1# |res|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |y| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((<= (SPADCALL |y| (QREFELT $ 26)) |maxDim|)
                       (LETT |res2| (SPADCALL |res2| |y| (QREFELT $ 35)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res2|)))) 

(SDEFUN |CFACET;sameFace?;2$B;16| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG ((|vertsb| #1=(|List| (|Segment| (|Integer|)))) (|vertsa| #1#))
               (SEQ (LETT |vertsa| (QCDR |a|)) (LETT |vertsb| (QCDR |b|))
                    (EXIT (NULL (SPADCALL |vertsa| |vertsb| (QREFELT $ 48))))))) 

(SDEFUN |CFACET;ltLocal|
        ((|a| (|List| (|Segment| (|Integer|))))
         (|b| (|List| (|Segment| (|Integer|)))) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G840 NIL) (|hib| #2=(|Integer|)) (|lob| #3=(|Integer|))
          (|hia| #2#) (|loa| #3#) (#4=#:G841 NIL) (|a1| NIL) (#5=#:G842 NIL)
          (|b1| NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |a| |b| (QREFELT $ 29))
              (PROGN (LETT #1# NIL) (GO #6=#:G839))))
            (COND ((< (LENGTH |a|) 1) (PROGN (LETT #1# 'T) (GO #6#))))
            (COND ((< (LENGTH |b|) 1) (PROGN (LETT #1# NIL) (GO #6#))))
            (SEQ (LETT |b1| NIL) (LETT #5# |b|) (LETT |a1| NIL) (LETT #4# |a|)
                 G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |a1| (CAR #4#)) NIL) (ATOM #5#)
                       (PROGN (LETT |b1| (CAR #5#)) NIL))
                   (GO G191)))
                 (SEQ (LETT |loa| (SPADCALL |a1| (QREFELT $ 9)))
                      (LETT |hia| (SPADCALL |a1| (QREFELT $ 10)))
                      (LETT |lob| (SPADCALL |b1| (QREFELT $ 9)))
                      (LETT |hib| (SPADCALL |b1| (QREFELT $ 10)))
                      (COND ((< |loa| |lob|) (PROGN (LETT #1# 'T) (GO #6#))))
                      (COND ((> |loa| |lob|) (PROGN (LETT #1# NIL) (GO #6#))))
                      (COND ((< |hia| |hib|) (PROGN (LETT #1# 'T) (GO #6#))))
                      (EXIT
                       (COND
                        ((> |hia| |hib|) (PROGN (LETT #1# NIL) (GO #6#))))))
                 (LETT #4# (PROG1 (CDR #4#) (LETT #5# (CDR #5#)))) (GO G190)
                 G191 (EXIT NIL))
            (EXIT NIL)))
          #6# (EXIT #1#)))) 

(SDEFUN |CFACET;<;2$B;18| ((|ain| ($)) (|bin| ($)) ($ (|Boolean|)))
        (SPROG ((|b| #1=(|List| (|Segment| (|Integer|)))) (|a| #1#))
               (SEQ (LETT |a| (QCDR |ain|)) (LETT |b| (QCDR |bin|))
                    (EXIT (|CFACET;ltLocal| |a| |b| $))))) 

(SDEFUN |CFACET;<=;2$B;19| ((|ain| ($)) (|bin| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G847 NIL) (|b| #2=(|List| (|Segment| (|Integer|)))) (|a| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |a| (QCDR |ain|)) (LETT |b| (QCDR |bin|))
                (COND
                 ((SPADCALL |a| |b| (QREFELT $ 29))
                  (PROGN (LETT #1# 'T) (GO #3=#:G846))))
                (EXIT (|CFACET;ltLocal| |a| |b| $))))
          #3# (EXIT #1#)))) 

(SDEFUN |CFACET;=;2$B;20| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G852 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL (QCAR |a|) (QCAR |b|) (QREFELT $ 16))
                    (PROGN (LETT #1# NIL) (GO #2=#:G851))))
                  (EXIT (SPADCALL (QCDR |a|) (QCDR |b|) (QREFELT $ 29)))))
                #2# (EXIT #1#)))) 

(SDEFUN |CFACET;coerce;$Of;21| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|body| (|OutputForm|)) (|elements| (|List| (|OutputForm|)))
          (#1=#:G861 NIL) (|x| NIL) (#2=#:G860 NIL) (|prefix| (|OutputForm|))
          (|m| (|Integer|)))
         (SEQ (LETT |prefix| (SPADCALL "" (QREFELT $ 55)))
              (LETT |m| (QCAR |s|))
              (COND
               ((SPADCALL (ABS |m|) 1 (QREFELT $ 16))
                (LETT |prefix|
                      (SPADCALL (SPADCALL |m| (QREFELT $ 56))
                                (SPADCALL "*" (QREFELT $ 55))
                                (QREFELT $ 57)))))
              (COND
               ((EQL |m| -1) (LETT |prefix| (SPADCALL "-" (QREFELT $ 55)))))
              (LETT |elements|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |x| NIL) (LETT #1# (QCDR |s|)) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |x| (QREFELT $ 58)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (LETT |body| (SPADCALL |elements| (QREFELT $ 59)))
              (EXIT (SPADCALL |prefix| |body| (QREFELT $ 57)))))) 

(DECLAIM (NOTINLINE |CubicalFacet;|)) 

(DEFUN |CubicalFacet| ()
  (SPROG NIL
         (PROG (#1=#:G863)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|CubicalFacet|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|CubicalFacet|
                             (LIST (CONS NIL (CONS 1 (|CubicalFacet;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|CubicalFacet|)))))))))) 

(DEFUN |CubicalFacet;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|CubicalFacet|))
          (LETT $ (GETREFV 63))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CubicalFacet| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |mul| (|Integer|))
                              (|:| |fac| (|List| (|Segment| (|Integer|))))))
          $))) 

(MAKEPROP '|CubicalFacet| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Integer|) (|Segment| 7)
              (0 . |low|) (5 . |high|) (10 . |segment|) (|List| 8)
              (16 . |concat|) |CFACET;cubicalFacet;IL$;1| (|Boolean|) (22 . ~=)
              (|List| 7) (28 . |second|) (|List| 17)
              |CFACET;cubicalFacet;IL$;2| (|CubicalFacet|)
              (33 . |getIntervals|) |CFACET;cubicalFacet;I2$;3|
              |CFACET;getIntervals;$L;4| (|NonNegativeInteger|)
              |CFACET;order;$Nni;5| |CFACET;getMult;$I;6|
              |CFACET;setMult;$I$;7| (38 . =) (|List| $)
              |CFACET;position;$LI;8| (44 . |concat|) |CFACET;product;3$;9|
              (|List| $$) (50 . |concat|) (|List| 25) (56 . |concat|)
              (62 . |concat|) |CFACET;boundary;$L;11| (68 . |empty?|)
              (73 . |member?|) (79 . |empty?|) (84 . |copy|) (89 . |copy|)
              (94 . |setelt!|) |CFACET;allSubsets;$NniL;14|
              |CFACET;allSubsets;$2NniL;15| (101 . ~=)
              |CFACET;sameFace?;2$B;16| |CFACET;<;2$B;18| |CFACET;<=;2$B;19|
              |CFACET;=;2$B;20| (|String|) (|OutputForm|) (107 . |message|)
              (112 . |coerce|) (117 . |hconcat|) (123 . |coerce|)
              (128 . |paren|) |CFACET;coerce;$Of;21| (|HashState|)
              (|SingleInteger|))
           '#(~= 133 |smaller?| 139 |setMult| 145 |sameFace?| 151 |product| 157
              |position| 163 |order| 169 |min| 174 |max| 180 |latex| 186
              |hashUpdate!| 191 |hash| 197 |getMult| 202 |getIntervals| 207
              |empty?| 212 |cubicalFacet| 217 |coerce| 235 |boundary| 240
              |allSubsets| 245 >= 258 > 264 = 270 <= 276 < 282)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0))
                 (CONS
                  '#(|FacetCategory&| |OrderedSet&| NIL |SetCategory&|
                     |PartialOrder&| |BasicType&| NIL)
                  (CONS
                   '#((|FacetCategory|) (|OrderedSet|) (|Comparable|)
                      (|SetCategory|) (|PartialOrder|) (|BasicType|)
                      (|CoercibleTo| 54))
                   (|makeByteWordVec2| 62
                                       '(1 8 7 0 9 1 8 7 0 10 2 8 0 7 7 11 2 12
                                         0 0 8 13 2 7 15 0 0 16 1 17 7 0 18 1
                                         21 12 0 22 2 12 15 0 0 29 2 12 0 0 0
                                         32 2 34 0 0 2 35 2 36 0 0 25 37 2 34 0
                                         0 0 38 1 0 15 0 40 2 34 15 2 0 41 1 34
                                         15 0 42 1 34 0 0 43 1 12 0 0 44 3 12 8
                                         0 7 8 45 2 12 15 0 0 48 1 54 0 53 55 1
                                         7 54 0 56 2 54 0 0 0 57 1 8 54 0 58 1
                                         54 0 30 59 2 0 15 0 0 1 2 0 15 0 0 1 2
                                         0 0 0 7 28 2 0 15 0 0 49 2 0 0 0 0 33
                                         2 0 7 0 30 31 1 0 25 0 26 2 0 0 0 0 1
                                         2 0 0 0 0 1 1 0 53 0 1 2 0 61 61 0 1 1
                                         0 62 0 1 1 0 7 0 27 1 0 12 0 24 1 0 15
                                         0 40 2 0 0 7 21 23 2 0 0 7 12 14 2 0 0
                                         7 19 20 1 0 54 0 60 1 0 30 0 39 3 0 30
                                         0 25 25 47 2 0 30 0 25 46 2 0 15 0 0 1
                                         2 0 15 0 0 1 2 0 15 0 0 52 2 0 15 0 0
                                         51 2 0 15 0 0 50)))))
           '|lookupComplete|)) 

(MAKEPROP '|CubicalFacet| 'NILADIC T) 

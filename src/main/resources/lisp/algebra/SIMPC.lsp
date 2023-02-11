
(SDEFUN |SIMPC;simplicialComplex;LNniL$;1|
        ((|v| (|List| VS)) (|numPoints| (|NonNegativeInteger|))
         (|fs| (|List| (|List| (|NonNegativeInteger|)))) ($ ($)))
        (SPROG ((|res| (|List| (|OrientedFacet|))) (#1=#:G735 NIL) (|f| NIL))
               (SEQ (LETT |res| NIL)
                    (SEQ (LETT |f| NIL) (LETT #1# |fs|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (SPADCALL |res|
                                           (SPADCALL 1 |f| (QREFELT $ 11))
                                           (QREFELT $ 13)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (VECTOR |v| |numPoints| |res|))))) 

(SDEFUN |SIMPC;simplicialComplex;LL$;2|
        ((|v| (|List| VS)) (|fs| (|List| (|List| (|NonNegativeInteger|))))
         ($ ($)))
        (SPROG
         ((|numPoints| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
          (#1=#:G744 NIL) (|fac| NIL) (|facs| (|List| (|OrientedFacet|)))
          (#2=#:G743 NIL) (|f| NIL))
         (SEQ (LETT |facs| NIL)
              (SEQ (LETT |f| NIL) (LETT #2# |fs|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |facs|
                           (SPADCALL |facs| (SPADCALL 1 |f| (QREFELT $ 11))
                                     (QREFELT $ 13)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |numPoints| 0)
              (SEQ (LETT |fac| NIL) (LETT #1# |facs|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |fac| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |m| (SPADCALL |fac| (QREFELT $ 18)))
                        (EXIT
                         (COND ((> |m| |numPoints|) (LETT |numPoints| |m|)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |v| |numPoints| |facs|))))) 

(SDEFUN |SIMPC;simplicialComplex;L$;3| ((|v| (|List| VS)) ($ ($)))
        (SPROG ((|res| (|List| (|OrientedFacet|))))
               (SEQ (LETT |res| NIL) (EXIT (VECTOR |v| 0 |res|))))) 

(SDEFUN |SIMPC;simplicialComplexIfCan;DcU;4|
        ((|dc| (|DeltaComplex| VS)) ($ (|Union| $ "failed")))
        (SPADCALL |dc| NIL (QREFELT $ 25))) 

(SDEFUN |SIMPC;simplicialComplexIfCan;DcBU;5|
        ((|dc| (|DeltaComplex| VS)) (|trace| (|Boolean|))
         ($ (|Union| $ "failed")))
        (SPROG
         ((|res| (|List| (|OrientedFacet|))) (#1=#:G786 NIL) (|r| NIL)
          (|orf| (|OrientedFacet|)) (#2=#:G780 NIL)
          (|orfx| (|Union| (|OrientedFacet|) "failed"))
          (|subFacets| (|List| (|OrientedFacet|)))
          (|deleteList| (|List| (|OrientedFacet|)))
          (|subFacet2| (|OrientedFacet|)) (|m| (|Integer|))
          (|subFacet| (|OrientedFacet|)) (|ind| (|NonNegativeInteger|))
          (#3=#:G766 NIL) (#4=#:G785 NIL) (|i| NIL) (#5=#:G784 NIL)
          (|facet| NIL) (|thisPoint| #6=(|NonNegativeInteger|)) (#7=#:G783 NIL)
          (|NumPoints| #6#) (|lastMap| (|List| (|List| (|OrientedFacet|))))
          (#8=#:G781 NIL) (|map| NIL) (#9=#:G782 NIL) (|grade| NIL)
          (|maps| (|List| (|List| (|List| (|Integer|)))))
          (|vertset| #10=(|List| VS))
          (|dcrep|
           (|Record| (|:| VERTSET #10#)
                     (|:| MAPS (|List| (|List| (|List| (|Integer|))))))))
         (SEQ
          (EXIT
           (SEQ
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL
                (SPADCALL (SPADCALL "simplicialComplex(" (QREFELT $ 29))
                          (SPADCALL |dc| (QREFELT $ 30)) (QREFELT $ 31))
                (SPADCALL ")" (QREFELT $ 29)) (QREFELT $ 31))
               (QREFELT $ 33))))
            (LETT |dcrep| |dc|) (LETT |NumPoints| 0)
            (LETT |vertset| (QCAR |dcrep|))
            (LETT |maps| (REVERSE (QCDR |dcrep|))) (LETT |res| NIL)
            (LETT |deleteList| NIL) (LETT |lastMap| NIL)
            (SEQ (LETT |grade| 1) (LETT #9# (LENGTH |maps|)) (LETT |map| NIL)
                 (LETT #8# |maps|) G190
                 (COND
                  ((OR (ATOM #8#) (PROGN (LETT |map| (CAR #8#)) NIL)
                       (|greater_SI| |grade| #9#))
                   (GO G191)))
                 (SEQ (LETT |lastMap| (SPADCALL |lastMap| NIL (QREFELT $ 35)))
                      (COND
                       (|trace|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL "simplicialComplex map="
                                        (QREFELT $ 36))
                              (SPADCALL |map| (QREFELT $ 38)) (QREFELT $ 31))
                             (SPADCALL " grade=" (QREFELT $ 36))
                             (QREFELT $ 31))
                            (SPADCALL |grade| (QREFELT $ 39)) (QREFELT $ 31))
                           (SPADCALL " lastMap=" (QREFELT $ 36))
                           (QREFELT $ 31))
                          (SPADCALL |lastMap| (QREFELT $ 40)) (QREFELT $ 31))
                         (QREFELT $ 33))))
                      (COND
                       ((EQL |grade| 1)
                        (SEQ (LETT |NumPoints| (LENGTH |map|))
                             (LETT |thisPoint| 0)
                             (EXIT
                              (SEQ (LETT |facet| NIL) (LETT #7# |map|) G190
                                   (COND
                                    ((OR (ATOM #7#)
                                         (PROGN (LETT |facet| (CAR #7#)) NIL))
                                     (GO G191)))
                                   (SEQ (LETT |thisPoint| (+ |thisPoint| 1))
                                        (EXIT
                                         (COND
                                          ((NULL (NULL |facet|))
                                           (SEQ
                                            (LETT |orf|
                                                  (SPADCALL (LIST |thisPoint|)
                                                            (QREFELT $ 42)))
                                            (COND
                                             (|trace|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL
                                                   "simplicialComplex add point="
                                                   (QREFELT $ 29))
                                                  (SPADCALL |orf|
                                                            (QREFELT $ 43))
                                                  (QREFELT $ 31))
                                                 (SPADCALL " from face="
                                                           (QREFELT $ 29))
                                                 (QREFELT $ 31))
                                                (SPADCALL |facet|
                                                          (QREFELT $ 44))
                                                (QREFELT $ 31))
                                               (QREFELT $ 33))))
                                            (LETT |res|
                                                  (SPADCALL |res| |orf|
                                                            (QREFELT $ 13)))
                                            (EXIT
                                             (SPADCALL |lastMap| |grade|
                                                       (SPADCALL
                                                        (SPADCALL |lastMap|
                                                                  |grade|
                                                                  (QREFELT $
                                                                           45))
                                                        |orf| (QREFELT $ 13))
                                                       (QREFELT $ 46))))))))
                                   (LETT #7# (CDR #7#)) (GO G190) G191
                                   (EXIT NIL))))))
                      (EXIT
                       (COND
                        ((> |grade| 1)
                         (SEQ (LETT |facet| NIL) (LETT #5# |map|) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |facet| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |subFacets| NIL)
                                   (SEQ (LETT |i| NIL) (LETT #4# |facet|) G190
                                        (COND
                                         ((OR (ATOM #4#)
                                              (PROGN (LETT |i| (CAR #4#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (LETT |ind|
                                               (PROG1 (LETT #3# (ABS |i|))
                                                 (|check_subtype2| (>= #3# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #3#)))
                                         (LETT |subFacet|
                                               (SPADCALL
                                                (SPADCALL |lastMap|
                                                          (- |grade| 1)
                                                          (QREFELT $ 45))
                                                |ind| (QREFELT $ 47)))
                                         (LETT |m|
                                               (COND ((< |i| 1) -1) ('T 1)))
                                         (LETT |subFacet2|
                                               (SPADCALL |m| |subFacet|
                                                         (QREFELT $ 48)))
                                         (LETT |deleteList|
                                               (SPADCALL |deleteList|
                                                         |subFacet|
                                                         (QREFELT $ 13)))
                                         (EXIT
                                          (LETT |subFacets|
                                                (SPADCALL |subFacets|
                                                          |subFacet2|
                                                          (QREFELT $ 13)))))
                                        (LETT #4# (CDR #4#)) (GO G190) G191
                                        (EXIT NIL))
                                   (LETT |orfx|
                                         (SPADCALL |subFacets| (QREFELT $ 50)))
                                   (COND
                                    ((QEQCAR |orfx| 1)
                                     (PROGN
                                      (LETT #2# (CONS 1 "failed"))
                                      (GO #11=#:G779))))
                                   (LETT |orf| (QCDR |orfx|))
                                   (LETT |res|
                                         (SPADCALL |res| |orf| (QREFELT $ 13)))
                                   (EXIT
                                    (SPADCALL |lastMap| |grade|
                                              (SPADCALL
                                               (SPADCALL |lastMap| |grade|
                                                         (QREFELT $ 45))
                                               |orf| (QREFELT $ 13))
                                              (QREFELT $ 46))))
                              (LETT #5# (CDR #5#)) (GO G190) G191
                              (EXIT NIL))))))
                 (LETT #8# (PROG1 (CDR #8#) (LETT |grade| (|inc_SI| |grade|))))
                 (GO G190) G191 (EXIT NIL))
            (SEQ (LETT |r| NIL) (LETT #1# |deleteList|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL)) (GO G191)))
                 (SEQ (EXIT (LETT |res| (SPADCALL |r| |res| (QREFELT $ 51)))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL
                (SPADCALL "simplicialComplex construct res=" (QREFELT $ 29))
                (SPADCALL |res| (QREFELT $ 52)) (QREFELT $ 31))
               (QREFELT $ 33))))
            (EXIT (CONS 0 (VECTOR |vertset| |NumPoints| |res|)))))
          #11# (EXIT #2#)))) 

(SDEFUN |SIMPC;addSimplex;$Of$;6| ((|a| ($)) (|f| (|OrientedFacet|)) ($ ($)))
        (SPROG
         ((|numPoints| (|NonNegativeInteger|)) (|max| (|NonNegativeInteger|))
          (#1=#:G802 NIL) (|orf2| NIL) (|res2| (|List| (|OrientedFacet|)))
          (#2=#:G801 NIL) (|orf| NIL) (|res| (|List| (|OrientedFacet|)))
          (|found| (|Boolean|)) (|m| (|Integer|)) (#3=#:G800 NIL))
         (SEQ (LETT |res| (QVELT |a| 2)) (LETT |found| NIL)
              (SEQ (LETT |orf| NIL) (LETT #3# |res|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |orf| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |orf| (QREFELT $ 53))
                                 (SPADCALL |f| (QREFELT $ 53)) (QREFELT $ 54))
                       (SEQ
                        (LETT |m|
                              (+ (SPADCALL |orf| (QREFELT $ 55))
                                 (SPADCALL |f| (QREFELT $ 55))))
                        (SPADCALL |orf| |m| (QREFELT $ 56))
                        (EXIT (LETT |found| 'T)))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (COND
               ((NULL |found|)
                (LETT |res| (SPADCALL |res| |f| (QREFELT $ 13)))))
              (LETT |res2| NIL)
              (SEQ (LETT |orf| NIL) (LETT #2# |res|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |orf| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |orf| (QREFELT $ 55)) 0
                                 (QREFELT $ 57))
                       (LETT |res2| (SPADCALL |res2| |orf| (QREFELT $ 13)))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |numPoints| 0)
              (SEQ (LETT |orf2| NIL) (LETT #1# |res2|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |orf2| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |max| (SPADCALL |orf2| (QREFELT $ 18)))
                        (EXIT
                         (COND
                          ((> |max| |numPoints|) (LETT |numPoints| |max|)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR (QVELT |a| 0) |numPoints| |res2|))))) 

(SDEFUN |SIMPC;maxIndex;$Nni;7| ((|s| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|res| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
          (#1=#:G808 NIL) (|fac| NIL) (|facs| (|List| (|OrientedFacet|))))
         (SEQ (LETT |res| 0) (LETT |facs| (QVELT |s| 2))
              (SEQ (LETT |fac| NIL) (LETT #1# |facs|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |fac| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |m| (SPADCALL |fac| (QREFELT $ 18)))
                        (EXIT (COND ((> |m| |res|) (LETT |res| |m|)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |SIMPC;minIndex;$Nni;8| ((|s| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|res| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
          (#1=#:G817 NIL) (|fac| NIL) (#2=#:G816 NIL)
          (|facs| (|List| (|OrientedFacet|))))
         (SEQ
          (EXIT
           (SEQ (LETT |res| 10000) (LETT |facs| (QVELT |s| 2))
                (COND
                 ((EQL (LENGTH |facs|) 0) (PROGN (LETT #2# 0) (GO #3=#:G815))))
                (SEQ (LETT |fac| NIL) (LETT #1# |facs|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |fac| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |m| (SPADCALL |fac| (QREFELT $ 60)))
                          (EXIT (COND ((< |m| |res|) (LETT |res| |m|)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #3# (EXIT #2#)))) 

(SDEFUN |SIMPC;grade;$L;9| ((|s| ($)) ($ (|List| (|List| (|OrientedFacet|)))))
        (SPROG
         ((|gr| (|Integer|)) (#1=#:G831 NIL) (|face| NIL)
          (|res| (|List| (|List| (|OrientedFacet|)))) (#2=#:G830 NIL) (|a| NIL)
          (#3=#:G828 NIL) (|maxGrade| (|NonNegativeInteger|)) (#4=#:G829 NIL)
          (|simp| (|List| (|OrientedFacet|))))
         (SEQ
          (EXIT
           (SEQ (LETT |simp| (QVELT |s| 2)) (LETT |maxGrade| 0)
                (SEQ (LETT |face| NIL) (LETT #4# |simp|) G190
                     (COND
                      ((OR (ATOM #4#) (PROGN (LETT |face| (CAR #4#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((> (SPADCALL |face| (QREFELT $ 62)) |maxGrade|)
                         (LETT |maxGrade| (SPADCALL |face| (QREFELT $ 62)))))))
                     (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                (LETT |res| NIL)
                (COND
                 ((< |maxGrade| 1) (PROGN (LETT #3# |res|) (GO #5=#:G827))))
                (SEQ (LETT |a| 1) (LETT #2# |maxGrade|) G190
                     (COND ((|greater_SI| |a| #2#) (GO G191)))
                     (SEQ
                      (EXIT (LETT |res| (SPADCALL |res| NIL (QREFELT $ 35)))))
                     (LETT |a| (|inc_SI| |a|)) (GO G190) G191 (EXIT NIL))
                (SEQ (LETT |face| NIL) (LETT #1# |simp|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |face| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |gr| (SPADCALL |face| (QREFELT $ 62)))
                          (EXIT
                           (COND
                            ((> |gr| 0)
                             (SPADCALL |res| |gr|
                                       (SPADCALL
                                        (SPADCALL |res| |gr| (QREFELT $ 45))
                                        |face| (QREFELT $ 13))
                                       (QREFELT $ 46))))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #5# (EXIT #3#)))) 

(SDEFUN |SIMPC;sort;2$;10| ((|s| ($)) ($ ($)))
        (SPROG ((|fs| (|List| (|OrientedFacet|))) (|v| (|List| VS)))
               (SEQ (LETT |v| (QVELT |s| 0)) (LETT |fs| (QVELT |s| 2))
                    (EXIT
                     (VECTOR |v| (QVELT |s| 1)
                             (SPADCALL |fs| (QREFELT $ 64))))))) 

(SDEFUN |SIMPC;orderedPermutation|
        ((|lst| (|List| (|Integer|))) (|len| (|NonNegativeInteger|))
         ($ (|List| (|List| (|Integer|)))))
        (SPROG
         ((|reslt| (|List| (|List| (|Integer|)))) (|r1| (|List| (|Integer|)))
          (#1=#:G849 NIL) (#2=#:G841 NIL) (|x| NIL)
          (|rst| (|List| (|Integer|))) (|fst| (|Integer|)) (#3=#:G847 NIL)
          (#4=#:G848 NIL) (|y| NIL))
         (SEQ
          (EXIT
           (SEQ (COND ((< |len| 1) (PROGN (LETT #3# NIL) (GO #5=#:G846))))
                (COND
                 ((> |len| (LENGTH |lst|)) (PROGN (LETT #3# NIL) (GO #5#))))
                (COND
                 ((EQL |len| (LENGTH |lst|))
                  (PROGN (LETT #3# (LIST |lst|)) (GO #5#))))
                (LETT |reslt| NIL)
                (COND
                 ((EQL |len| 1)
                  (SEQ
                   (SEQ (LETT |y| NIL) (LETT #4# |lst|) G190
                        (COND
                         ((OR (ATOM #4#) (PROGN (LETT |y| (CAR #4#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT |reslt|
                                (SPADCALL |reslt| (LIST |y|) (QREFELT $ 66)))))
                        (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                   (EXIT (PROGN (LETT #3# |reslt|) (GO #5#))))))
                (LETT |fst| (|SPADfirst| |lst|)) (LETT |rst| (CDR |lst|))
                (SEQ (LETT |x| NIL)
                     (LETT #1#
                           (|SIMPC;orderedPermutation| |rst|
                            (PROG2 (LETT #2# (SPADCALL |len| 1 (QREFELT $ 67)))
                                (QCDR #2#)
                              (|check_union2| (QEQCAR #2# 0)
                                              (|NonNegativeInteger|)
                                              (|Union| (|NonNegativeInteger|)
                                                       "failed")
                                              #2#))
                            $))
                     G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |r1| (CONS |fst| |x|))
                          (EXIT
                           (LETT |reslt|
                                 (SPADCALL |reslt| |r1| (QREFELT $ 66)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (LETT |reslt|
                      (SPADCALL |reslt|
                                (|SIMPC;orderedPermutation| |rst| |len| $)
                                (QREFELT $ 68)))
                (EXIT |reslt|)))
          #5# (EXIT #3#)))) 

(SDEFUN |SIMPC;isNewFace?|
        ((|lst| (|List| (|OrientedFacet|))) (|b| (|OrientedFacet|))
         ($ (|Boolean|)))
        (SPROG ((#1=#:G855 NIL) (#2=#:G856 NIL) (|a| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |a| NIL) (LETT #2# |lst|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |a| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |a| |b| (QREFELT $ 69))
                           (PROGN (LETT #1# NIL) (GO #3=#:G854))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |SIMPC;unorientedUnion|
        ((|a| #1=(|List| (|OrientedFacet|))) (|b| (|List| (|OrientedFacet|)))
         ($ (|List| (|OrientedFacet|))))
        (SPROG ((|res| #1#) (#2=#:G862 NIL) (|b1| NIL))
               (SEQ (LETT |res| |a|)
                    (SEQ (LETT |b1| NIL) (LETT #2# |b|) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |b1| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((|SIMPC;isNewFace?| |a| |b1| $)
                             (LETT |res| (CONS |b1| |res|))))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |SIMPC;addImpliedFaces;$L;14|
        ((|s| ($)) ($ (|List| (|List| (|OrientedFacet|)))))
        (SPROG
         ((|newFaces| (|List| (|OrientedFacet|)))
          (|len| (|NonNegativeInteger|)) (#1=#:G874 NIL) (|face| NIL)
          (|res| (|List| (|List| (|OrientedFacet|))))
          (|all_faces| (|List| (|OrientedFacet|))) (#2=#:G873 NIL) (|gr| NIL)
          (#3=#:G872 NIL) (|maxGrade| (|NonNegativeInteger|))
          (|inputList| (|List| (|List| (|OrientedFacet|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |inputList| (REVERSE (SPADCALL |s| (QREFELT $ 63))))
                (LETT |res| NIL) (LETT |maxGrade| (LENGTH |inputList|))
                (COND
                 ((< |maxGrade| 1)
                  (SEQ
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL "addImpliedFaces return because empty"
                               (QREFELT $ 29))
                     (SPADCALL |maxGrade| (QREFELT $ 39)) (QREFELT $ 31))
                    (QREFELT $ 33))
                   (EXIT (PROGN (LETT #3# |res|) (GO #4=#:G871))))))
                (LETT |res| NIL) (LETT |newFaces| NIL)
                (SEQ (LETT |gr| NIL) (LETT #2# |inputList|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |gr| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |all_faces|
                            (|SIMPC;unorientedUnion| |newFaces| |gr| $))
                      (LETT |res| (CONS |all_faces| |res|))
                      (LETT |newFaces| NIL)
                      (EXIT
                       (SEQ (LETT |face| NIL) (LETT #1# |all_faces|) G190
                            (COND
                             ((OR (ATOM #1#)
                                  (PROGN (LETT |face| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (LETT |len|
                                   (- (SPADCALL |face| (QREFELT $ 62)) 1))
                             (EXIT
                              (COND
                               ((> |len| 0)
                                (LETT |newFaces|
                                      (|SIMPC;unorientedUnion| |newFaces|
                                       (SPADCALL |face| |len| |len|
                                                 (QREFELT $ 70))
                                       $))))))
                            (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #4# (EXIT #3#)))) 

(SDEFUN |SIMPC;boundary;2$;15| ((|s| ($)) ($ ($)))
        (SPROG
         ((|res| ($)) (#1=#:G883 NIL) (|y| NIL)
          (|x| (|List| (|OrientedFacet|))) (#2=#:G882 NIL) (|facet| NIL))
         (SEQ (LETT |res| (SPADCALL (QVELT |s| 0) (QREFELT $ 21)))
              (SEQ (LETT |facet| NIL) (LETT #2# (QVELT |s| 2)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |facet| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |x| (SPADCALL |facet| (QREFELT $ 72)))
                        (EXIT
                         (SEQ (LETT |y| NIL) (LETT #1# |x|) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |y| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT |res|
                                      (SPADCALL |res| |y| (QREFELT $ 58)))))
                              (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |SIMPC;star;$Of$;16| ((|s| ($)) (|simplex| (|OrientedFacet|)) ($ ($)))
        (SPROG
         ((|res| (|List| (|OrientedFacet|))) (#1=#:G889 NIL) (|simp| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |simp| NIL) (LETT #1# (QVELT |s| 2)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |simp| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |simplex| |simp| (QREFELT $ 74))
                       (LETT |res| (SPADCALL |res| |simp| (QREFELT $ 13)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR (QVELT |s| 0) (QVELT |s| 1) |res|))))) 

(SDEFUN |SIMPC;link;$Of$;17| ((|s| ($)) (|simplex| (|OrientedFacet|)) ($ ($)))
        (SPROG
         ((|res| (|List| (|OrientedFacet|))) (|x| (|List| (|OrientedFacet|)))
          (#1=#:G896 NIL) (|facet| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |facet| NIL) (LETT #1# (QVELT |s| 2)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |facet| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |simplex| |facet| (QREFELT $ 74))
                       (SEQ (LETT |x| (SPADCALL |facet| (QREFELT $ 72)))
                            (EXIT
                             (LETT |res|
                                   (SPADCALL |res| |x| (QREFELT $ 76)))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR (QVELT |s| 0) (QVELT |s| 1) |res|))))) 

(SDEFUN |SIMPC;cone;$Nni$;18|
        ((|s| ($)) (|vertex| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|res| (|List| (|OrientedFacet|))) (|x| (|OrientedFacet|))
          (#1=#:G902 NIL) (|facet| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |facet| NIL) (LETT #1# (QVELT |s| 2)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |facet| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |x| (SPADCALL |facet| |vertex| (QREFELT $ 78)))
                        (EXIT
                         (LETT |res| (SPADCALL |res| |x| (QREFELT $ 13)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR (QVELT |s| 0) (QVELT |s| 1) |res|))))) 

(SDEFUN |SIMPC;refactorIndexes;$Nni$;19|
        ((|a| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|res| (|List| (|OrientedFacet|))) (|r| (|OrientedFacet|))
          (#1=#:G908 NIL) (|facet| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |facet| NIL) (LETT #1# (QVELT |a| 2)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |facet| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |r| (SPADCALL |facet| |n| (QREFELT $ 80)))
                        (EXIT
                         (LETT |res| (SPADCALL |res| |r| (QREFELT $ 13)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR (QVELT |a| 0) (QVELT |a| 1) |res|))))) 

(SDEFUN |SIMPC;makeDisjoint;3$;20| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((#1=#:G911 NIL) (|maxb| #2=(|NonNegativeInteger|))
          (|minb| #3=(|NonNegativeInteger|)) (|maxa| #2#) (|mina| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |mina| (SPADCALL |a| (QREFELT $ 61)))
                (LETT |maxa| (SPADCALL |a| (QREFELT $ 59)))
                (LETT |minb| (SPADCALL |b| (QREFELT $ 61)))
                (LETT |maxb| (SPADCALL |b| (QREFELT $ 59)))
                (COND
                 ((< |maxa| |minb|) (PROGN (LETT #1# |b|) (GO #4=#:G910))))
                (COND ((< |maxb| |mina|) (PROGN (LETT #1# |b|) (GO #4#))))
                (EXIT (SPADCALL |b| |maxa| (QREFELT $ 81)))))
          #4# (EXIT #1#)))) 

(SDEFUN |SIMPC;simplicialJoin;2$B$;21|
        ((|a| ($)) (|b| ($)) (|enforceDisjoint| (|Boolean|)) ($ ($)))
        (SPROG
         ((|numPoints| (|NonNegativeInteger|)) (|verts| (|List| VS))
          (|res| (|List| (|OrientedFacet|))) (|fac| (|OrientedFacet|))
          (#1=#:G923 NIL) (|y| NIL) (#2=#:G922 NIL) (|x| NIL) (|b2| ($))
          (#3=#:G921 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND ((NULL (QVELT |a| 2)) (PROGN (LETT #3# |b|) (GO #4=#:G920))))
            (COND ((NULL (QVELT |b| 2)) (PROGN (LETT #3# |a|) (GO #4#))))
            (LETT |b2|
                  (COND (|enforceDisjoint| (SPADCALL |a| |b| (QREFELT $ 82)))
                        ('T |b|)))
            (LETT |res| NIL)
            (SEQ (LETT |x| NIL) (LETT #2# (QVELT |a| 2)) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |y| NIL) (LETT #1# (QVELT |b2| 2)) G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |y| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ (LETT |fac| (SPADCALL |x| |y| (QREFELT $ 83)))
                             (EXIT
                              (LETT |res|
                                    (SPADCALL |res| |fac| (QREFELT $ 13)))))
                        (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
            (LETT |verts|
                  (SPADCALL (QVELT |a| 0) (QVELT |b| 0) (QREFELT $ 84)))
            (LETT |numPoints| (+ (QVELT |a| 1) (QVELT |b| 1)))
            (EXIT (VECTOR |verts| |numPoints| |res|))))
          #4# (EXIT #3#)))) 

(SDEFUN |SIMPC;merge;3$;22| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((|res| ($)) (#1=#:G928 NIL) (|x| NIL))
               (SEQ (LETT |res| (MOVEVEC (MAKE_VEC 3) |a|))
                    (SEQ (LETT |x| NIL) (LETT #1# (QVELT |b| 2)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res| (SPADCALL |res| |x| (QREFELT $ 58)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |SIMPC;concatIfNew|
        ((|a|
          (|List|
           (|Record| (|:| |value| (|NonNegativeInteger|))
                     (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|)))))
         (|b| (|NonNegativeInteger|))
         ($
          (|List|
           (|Record| (|:| |value| (|NonNegativeInteger|))
                     (|:| |posX| (|NonNegativeInteger|))
                     (|:| |posY| (|NonNegativeInteger|))))))
        (SPROG ((#1=#:G936 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL (VECTOR |b| 0 0) |a| (QREFELT $ 89))
                    (PROGN (LETT #1# |a|) (GO #2=#:G935))))
                  (EXIT (SPADCALL |a| (VECTOR |b| 0 0) (QREFELT $ 90)))))
                #2# (EXIT #1#)))) 

(SDEFUN |SIMPC;concatIfNewArrow|
        ((|a|
          (|List|
           (|Record| (|:| |name| (|String|))
                     (|:| |arrType| (|NonNegativeInteger|))
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|))))))
         (|p| (|NonNegativeInteger|)) (|m| (|NonNegativeInteger|))
         ($
          (|List|
           (|Record| (|:| |name| (|String|))
                     (|:| |arrType| (|NonNegativeInteger|))
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))))
        (SPROG ((#1=#:G947 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL (VECTOR "x" 0 |p| |m| 0 0 NIL) |a|
                              (QREFELT $ 93))
                    (PROGN (LETT #1# |a|) (GO #2=#:G946))))
                  (COND
                   ((SPADCALL (VECTOR "x" 0 |m| |p| 0 0 NIL) |a|
                              (QREFELT $ 93))
                    (PROGN (LETT #1# |a|) (GO #2#))))
                  (EXIT
                   (SPADCALL |a| (VECTOR "x" 0 |p| |m| 0 0 NIL)
                             (QREFELT $ 94)))))
                #2# (EXIT #1#)))) 

(SDEFUN |SIMPC;oneSkeleton;$Dg;25|
        ((|s| ($)) ($ (|DirectedGraph| (|NonNegativeInteger|))))
        (SPROG
         ((|edges|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (#1=#:G963 NIL) (|p| NIL)
          (|nodes|
           (|List|
            (|Record| (|:| |value| (|NonNegativeInteger|))
                      (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (#2=#:G962 NIL) (|m| NIL)
          (|y|
           (|Record| (|:| |name| (|String|))
                     (|:| |arrType| (|NonNegativeInteger|))
                     (|:| |fromOb| (|NonNegativeInteger|))
                     (|:| |toOb| (|NonNegativeInteger|))
                     (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                     (|:| |map| (|List| (|NonNegativeInteger|)))))
          (|indexes| (|List| (|NonNegativeInteger|)))
          (|n| (|NonNegativeInteger|)) (#3=#:G961 NIL) (|x| NIL)
          (GS
           (|Join| (|FiniteGraph| #4=(|NonNegativeInteger|))
                   (CATEGORY |domain|
                    (SIGNATURE |directedGraph| ($ (|List| #4#)))
                    (SIGNATURE |directedGraph|
                     ($
                      (|List|
                       (|Record| (|:| |value| #4#)
                                 (|:| |posX| (|NonNegativeInteger|))
                                 (|:| |posY| (|NonNegativeInteger|))))))
                    (SIGNATURE |directedGraph|
                     ($
                      (|List|
                       (|Record| (|:| |value| #4#)
                                 (|:| |posX| (|NonNegativeInteger|))
                                 (|:| |posY| (|NonNegativeInteger|))))
                      (|List|
                       (|Record| (|:| |name| (|String|))
                                 (|:| |arrType| (|NonNegativeInteger|))
                                 (|:| |fromOb| (|NonNegativeInteger|))
                                 (|:| |toOb| (|NonNegativeInteger|))
                                 (|:| |xOffset| (|Integer|))
                                 (|:| |yOffset| (|Integer|))
                                 (|:| |map|
                                      (|List| (|NonNegativeInteger|)))))))
                    (SIGNATURE |directedGraph|
                     ($ (|List| #4#)
                      (|List|
                       (|Record| (|:| |fromOb| (|NonNegativeInteger|))
                                 (|:| |toOb| (|NonNegativeInteger|))))))
                    (SIGNATURE |directedGraph|
                     ($ (|List| #4#) (|List| (|List| (|NonNegativeInteger|)))))
                    (SIGNATURE |directedGraph|
                     ($ (|List| (|Permutation| #4#))))
                    (SIGNATURE |directedGraph| ($ (|FinitePoset| #4#)))
                    (SIGNATURE * ((|DirectedGraph| (|Product| #4# #4#)) $ $))
                    (SIGNATURE |cartesian|
                     ((|DirectedGraph| (|Product| #4# #4#)) $ $))
                    (SIGNATURE |closedTensor| ($ $ $ (|Mapping| #4# #4# #4#)))
                    (SIGNATURE |closedCartesian|
                     ($ $ $ (|Mapping| #4# #4# #4#)))
                    (SIGNATURE ~ ($ $))
                    (SIGNATURE |coerce| ($ (|PermutationGroup| #4#)))
                    (SIGNATURE |coerce| ($ (|FinitePoset| #4#)))
                    (SIGNATURE |coerce| ($ (|List| #4#)))))))
         (SEQ (LETT GS (|DirectedGraph| (|NonNegativeInteger|)))
              (LETT |nodes| NIL) (LETT |edges| NIL)
              (SEQ (LETT |x| NIL) (LETT #3# (QVELT |s| 2)) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |n| (SPADCALL |x| (QREFELT $ 62)))
                        (LETT |indexes| (SPADCALL |x| (QREFELT $ 53)))
                        (COND
                         ((EQL |n| 2)
                          (SEQ
                           (LETT |nodes|
                                 (|SIMPC;concatIfNew| |nodes|
                                  (SPADCALL |indexes| 1 (QREFELT $ 95)) $))
                           (LETT |nodes|
                                 (|SIMPC;concatIfNew| |nodes|
                                  (SPADCALL |indexes| 2 (QREFELT $ 95)) $))
                           (LETT |y|
                                 (VECTOR "x" 0
                                         (SPADCALL |indexes| 1 (QREFELT $ 95))
                                         (SPADCALL |indexes| 2 (QREFELT $ 95))
                                         0 0 NIL))
                           (EXIT
                            (LETT |edges|
                                  (SPADCALL |edges| |y| (QREFELT $ 94)))))))
                        (EXIT
                         (COND
                          ((> |n| 2)
                           (SEQ (LETT |m| NIL) (LETT #2# |indexes|) G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |m| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (LETT |nodes|
                                       (|SIMPC;concatIfNew| |nodes| |m| $))
                                 (EXIT
                                  (SEQ (LETT |p| NIL) (LETT #1# |indexes|) G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |p| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (COND
                                          ((< |p| |m|)
                                           (LETT |edges|
                                                 (|SIMPC;concatIfNewArrow|
                                                  |edges| |p| |m| $))))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT NIL))))
                                (LETT #2# (CDR #2#)) (GO G190) G191
                                (EXIT NIL))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |nodes| |edges|
                         (|compiledLookupCheck| '|directedGraph|
                                                (LIST '$
                                                      (LIST '|List|
                                                            (LIST '|Record|
                                                                  (LIST '|:|
                                                                        '|value|
                                                                        (LIST
                                                                         '|NonNegativeInteger|))
                                                                  (LIST '|:|
                                                                        '|posX|
                                                                        (LIST
                                                                         '|NonNegativeInteger|))
                                                                  (LIST '|:|
                                                                        '|posY|
                                                                        (LIST
                                                                         '|NonNegativeInteger|))))
                                                      (LIST '|List|
                                                            (LIST '|Record|
                                                                  (LIST '|:|
                                                                        '|name|
                                                                        (LIST
                                                                         '|String|))
                                                                  (LIST '|:|
                                                                        '|arrType|
                                                                        (LIST
                                                                         '|NonNegativeInteger|))
                                                                  (LIST '|:|
                                                                        '|fromOb|
                                                                        (LIST
                                                                         '|NonNegativeInteger|))
                                                                  (LIST '|:|
                                                                        '|toOb|
                                                                        (LIST
                                                                         '|NonNegativeInteger|))
                                                                  (LIST '|:|
                                                                        '|xOffset|
                                                                        (LIST
                                                                         '|Integer|))
                                                                  (LIST '|:|
                                                                        '|yOffset|
                                                                        (LIST
                                                                         '|Integer|))
                                                                  (LIST '|:|
                                                                        '|map|
                                                                        (LIST
                                                                         '|List|
                                                                         (LIST
                                                                          '|NonNegativeInteger|))))))
                                                GS)))))) 

(SDEFUN |SIMPC;fundamentalGroup;$Gp;26| ((|s| ($)) ($ (|GroupPresentation|)))
        (SPADCALL |s| 'T NIL (QREFELT $ 99))) 

(SDEFUN |SIMPC;fundamentalGroup;$2BGp;27|
        ((|s| ($)) (|simplify| (|Boolean|)) (|trace| (|Boolean|))
         ($ (|GroupPresentation|)))
        (SPROG ((|dc| (|DeltaComplex| VS)))
               (SEQ (LETT |dc| (SPADCALL |s| (QREFELT $ 102)))
                    (EXIT (SPADCALL |dc| |simplify| |trace| (QREFELT $ 103)))))) 

(SDEFUN |SIMPC;chain;$Cc;28| ((|s| ($)) ($ (|ChainComplex|)))
        (SPROG ((|dc| (|DeltaComplex| VS)))
               (SEQ (LETT |dc| (SPADCALL |s| (QREFELT $ 102)))
                    (EXIT (SPADCALL |dc| (QREFELT $ 105)))))) 

(SDEFUN |SIMPC;coChain;$Ccc;29| ((|s| ($)) ($ (|CoChainComplex| VS)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 106)) (QREFELT $ 108))) 

(SDEFUN |SIMPC;homology;$L;30| ((|s| ($)) ($ (|List| (|Homology|))))
        (SPROG ((|dc| (|DeltaComplex| VS)))
               (SEQ (LETT |dc| (SPADCALL |s| (QREFELT $ 102)))
                    (EXIT (SPADCALL |dc| (QREFELT $ 111)))))) 

(SDEFUN |SIMPC;coHomology;$L;31| ((|s| ($)) ($ (|List| (|Homology|))))
        (SPROG ((|dc| (|DeltaComplex| VS)))
               (SEQ (LETT |dc| (SPADCALL |s| (QREFELT $ 102)))
                    (EXIT (SPADCALL |dc| (QREFELT $ 113)))))) 

(SDEFUN |SIMPC;product;3$;32| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|numPoints| (|NonNegativeInteger|))
          (|res3| (|List| (|OrientedFacet|)))
          (|inds2| (|List| (|NonNegativeInteger|)))
          (|newIndex| (|NonNegativeInteger|)) (|r| (|NonNegativeInteger|))
          (#1=#:G993 NIL) (|l| (|NonNegativeInteger|)) (#2=#:G1008 NIL)
          (|y| NIL) (|mul| (|Integer|))
          (|inds|
           (|List|
            (|Record| (|:| |left| (|NonNegativeInteger|))
                      (|:| |right| (|NonNegativeInteger|)))))
          (#3=#:G1007 NIL) (|x| NIL) (|dimb| #4=(|NonNegativeInteger|))
          (|bz| (|NonNegativeInteger|)) (|dima| #4#)
          (|az| (|NonNegativeInteger|)) (#5=#:G1006 NIL) (|z| NIL)
          (|res2| (|List| (|ProductFacet|))) (#6=#:G1005 NIL) (|e| NIL)
          (|res| (|List| (|ProductFacet|))) (#7=#:G1004 NIL) (|simpb| NIL)
          (#8=#:G1003 NIL) (|simpa| NIL) (|vs| (|List| VS)) (|pp| (VS))
          (#9=#:G1002 NIL) (|pb| NIL) (#10=#:G1001 NIL) (|pa| NIL)
          (|simpsb| #11=(|List| (|OrientedFacet|))) (|simpsa| #11#))
         (SEQ (LETT |simpsa| (QVELT |a| 2)) (LETT |simpsb| (QVELT |b| 2))
              (LETT |vs| NIL)
              (SEQ (LETT |pa| NIL) (LETT #10# (QVELT |a| 0)) G190
                   (COND
                    ((OR (ATOM #10#) (PROGN (LETT |pa| (CAR #10#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |pb| NIL) (LETT #9# (QVELT |b| 0)) G190
                          (COND
                           ((OR (ATOM #9#) (PROGN (LETT |pb| (CAR #9#)) NIL))
                            (GO G191)))
                          (SEQ (LETT |pp| (SPADCALL |pa| |pb| (QREFELT $ 115)))
                               (EXIT
                                (LETT |vs|
                                      (SPADCALL |vs| |pp| (QREFELT $ 116)))))
                          (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
              (LETT |res| NIL)
              (SEQ (LETT |simpa| NIL) (LETT #8# |simpsa|) G190
                   (COND
                    ((OR (ATOM #8#) (PROGN (LETT |simpa| (CAR #8#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |simpb| NIL) (LETT #7# |simpsb|) G190
                          (COND
                           ((OR (ATOM #7#)
                                (PROGN (LETT |simpb| (CAR #7#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT |res|
                                  (SPADCALL |res|
                                            (SPADCALL |simpa| |simpb|
                                                      (QREFELT $ 118))
                                            (QREFELT $ 119)))))
                          (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
              (LETT |res2| NIL)
              (SEQ (LETT |e| NIL) (LETT #6# |res|) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |e| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL (SPADCALL |e| |res2| (QREFELT $ 121)))
                       (LETT |res2| (SPADCALL |res2| |e| (QREFELT $ 122)))))))
                   (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
              (LETT |res3| NIL) (LETT |dima| 0) (LETT |dimb| 0)
              (SEQ (LETT |z| NIL) (LETT #5# |res2|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |z| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |az| (SPADCALL |z| (QREFELT $ 123)))
                        (COND ((> |az| |dima|) (LETT |dima| |az|)))
                        (LETT |bz| (SPADCALL |z| (QREFELT $ 124)))
                        (EXIT (COND ((> |bz| |dimb|) (LETT |dimb| |bz|)))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |x| NIL) (LETT #3# |res2|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |inds| (SPADCALL |x| (QREFELT $ 127)))
                        (LETT |inds2| NIL)
                        (LETT |mul| (SPADCALL |x| (QREFELT $ 128)))
                        (SEQ (LETT |y| NIL) (LETT #2# |inds|) G190
                             (COND
                              ((OR (ATOM #2#) (PROGN (LETT |y| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |l|
                                    (PROG2
                                        (LETT #1#
                                              (SPADCALL (QCAR |y|) 1
                                                        (QREFELT $ 67)))
                                        (QCDR #1#)
                                      (|check_union2| (QEQCAR #1# 0)
                                                      (|NonNegativeInteger|)
                                                      (|Union|
                                                       (|NonNegativeInteger|)
                                                       #12="failed")
                                                      #1#)))
                              (LETT |r|
                                    (PROG2
                                        (LETT #1#
                                              (SPADCALL (QCDR |y|) 1
                                                        (QREFELT $ 67)))
                                        (QCDR #1#)
                                      (|check_union2| (QEQCAR #1# 0)
                                                      (|NonNegativeInteger|)
                                                      (|Union|
                                                       (|NonNegativeInteger|)
                                                       #12#)
                                                      #1#)))
                              (LETT |newIndex| (+ (+ (* |l| |dimb|) |r|) 1))
                              (EXIT
                               (LETT |inds2|
                                     (SPADCALL |inds2| |newIndex|
                                               (QREFELT $ 129)))))
                             (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (LETT |res3|
                               (SPADCALL |res3|
                                         (SPADCALL |mul| |inds2|
                                                   (QREFELT $ 11))
                                         (QREFELT $ 13)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (LETT |numPoints| (* (QVELT |a| 1) (QVELT |b| 1)))
              (EXIT (VECTOR |vs| |numPoints| |res3|))))) 

(SDEFUN |SIMPC;equalSimplex|
        ((|a| (|List| (|NonNegativeInteger|)))
         (|b| (|List| (|NonNegativeInteger|))) ($ (|Boolean|)))
        (SPROG
         ((|offset| (|Integer|)) (#1=#:G1019 NIL) (#2=#:G1020 NIL) (|n| NIL)
          (|fst| (|NonNegativeInteger|)) (|len| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |len| (SPADCALL |a| (QREFELT $ 131)))
                (COND
                 ((SPADCALL |len| (SPADCALL |b| (QREFELT $ 131))
                            (QREFELT $ 132))
                  (PROGN (LETT #1# NIL) (GO #3=#:G1018))))
                (COND ((EQL |len| 0) (PROGN (LETT #1# 'T) (GO #3#))))
                (LETT |fst| (|SPADfirst| |a|))
                (LETT |offset| (SPADCALL |fst| |b| (QREFELT $ 133)))
                (COND ((< |offset| 1) (PROGN (LETT #1# NIL) (GO #3#))))
                (SEQ (LETT |n| 1) (LETT #2# (SPADCALL |a| (QREFELT $ 131)))
                     G190 (COND ((|greater_SI| |n| #2#) (GO G191)))
                     (SEQ
                      (COND
                       ((SPADCALL (SPADCALL |a| |n| (QREFELT $ 95))
                                  (SPADCALL |b| |offset| (QREFELT $ 95))
                                  (QREFELT $ 132))
                        (PROGN (LETT #1# NIL) (GO #3#))))
                      (LETT |offset| (+ |offset| 1))
                      (EXIT
                       (COND
                        ((> |offset| (SPADCALL |b| (QREFELT $ 131)))
                         (LETT |offset| 1)))))
                     (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                (EXIT 'T)))
          #3# (EXIT #1#)))) 

(SDEFUN |SIMPC;=;2$B;34| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1036 NIL) (#2=#:G1040 NIL) (|f| NIL)
          (|x| (|NonNegativeInteger|)) (#3=#:G1039 NIL) (|a1| NIL)
          (|flags| (|List| (|Boolean|))) (#4=#:G1038 NIL) (#5=#:G1037 NIL)
          (|len| (|NonNegativeInteger|)) (|bs| #6=(|List| (|OrientedFacet|)))
          (|as| #6#))
         (SEQ
          (EXIT
           (SEQ (LETT |as| (QVELT |a| 2)) (LETT |bs| (QVELT |b| 2))
                (LETT |len| (LENGTH |as|))
                (COND
                 ((SPADCALL |len| (LENGTH |bs|) (QREFELT $ 132))
                  (PROGN (LETT #1# NIL) (GO #7=#:G1035))))
                (LETT |flags|
                      (PROGN
                       (LETT #5# NIL)
                       (SEQ (LETT #4# |as|) G190
                            (COND
                             ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                              (GO G191)))
                            (SEQ (EXIT (LETT #5# (CONS NIL #5#))))
                            (LETT #4# (CDR #4#)) (GO G190) G191
                            (EXIT (NREVERSE #5#)))))
                (SEQ (LETT |a1| NIL) (LETT #3# |as|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |a1| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |x| 1)
                          (SEQ G190
                               (COND
                                ((NULL
                                  (COND
                                   ((SPADCALL |a1|
                                              (SPADCALL |bs| |x|
                                                        (QREFELT $ 47))
                                              (QREFELT $ 134))
                                    'T)
                                   ('T
                                    (SPADCALL |flags| |x| (QREFELT $ 136)))))
                                 (GO G191)))
                               (SEQ (LETT |x| (+ |x| 1))
                                    (EXIT
                                     (COND
                                      ((> |x| (LENGTH |as|))
                                       (PROGN (LETT #1# NIL) (GO #7#))))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (EXIT (SPADCALL |flags| |x| 'T (QREFELT $ 137))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (SEQ (LETT |f| NIL) (LETT #2# |flags|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((|BooleanEquality| |f| NIL)
                         (PROGN (LETT #1# NIL) (GO #7#))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT 'T)))
          #7# (EXIT #1#)))) 

(SDEFUN |SIMPC;coerce;$Of;35| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|res| (|OutputForm|)) (#1=#:G1047 NIL) (|a| NIL) (#2=#:G1046 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |res|
                  (SPADCALL
                   (LIST (SPADCALL "points 1.." (QREFELT $ 29))
                         (SPADCALL (QVELT |s| 1) (QREFELT $ 39)))
                   (QREFELT $ 139)))
            (COND
             ((NULL (QVELT |s| 2))
              (PROGN
               (LETT #2#
                     (SPADCALL (SPADCALL "empty" (QREFELT $ 29))
                               (QREFELT $ 140)))
               (GO #3=#:G1045))))
            (SEQ (LETT |a| NIL) (LETT #1# (QVELT |s| 2)) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT |res|
                         (SPADCALL |res| (SPADCALL |a| (QREFELT $ 43))
                                   (QREFELT $ 141)))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
            (EXIT |res|)))
          #3# (EXIT #2#)))) 

(SDEFUN |SIMPC;coerce;$Dc;36| ((|s| ($)) ($ (|DeltaComplex| VS)))
        (SPADCALL |s| (QREFELT $ 102))) 

(DECLAIM (NOTINLINE |FiniteSimplicialComplex;|)) 

(DEFUN |FiniteSimplicialComplex| (#1=#:G1049)
  (SPROG NIL
         (PROG (#2=#:G1050)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FiniteSimplicialComplex|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|FiniteSimplicialComplex;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FiniteSimplicialComplex|)))))))))) 

(DEFUN |FiniteSimplicialComplex;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FiniteSimplicialComplex| DV$1))
          (LETT $ (GETREFV 146))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FiniteSimplicialComplex|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| VERTSET (|List| |#1|))
                              (|:| NUMPOINTS (|NonNegativeInteger|))
                              (|:| SIMP (|List| (|OrientedFacet|)))))
          $))) 

(MAKEPROP '|FiniteSimplicialComplex| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Integer|)
              (|List| 15) (|OrientedFacet|) (0 . |orientedFacet|) (|List| 10)
              (6 . |concat|) (|List| 6) (|NonNegativeInteger|) (|List| 9)
              |SIMPC;simplicialComplex;LNniL$;1| (12 . |maxIndex|)
              |SIMPC;simplicialComplex;LL$;2| (17 . |Zero|)
              |SIMPC;simplicialComplex;L$;3| (|Union| $ '"failed")
              (|DeltaComplex| 6) (|Boolean|)
              |SIMPC;simplicialComplexIfCan;DcBU;5|
              |SIMPC;simplicialComplexIfCan;DcU;4| (|String|) (|OutputForm|)
              (21 . |message|) (26 . |coerce|) (31 . |hconcat|) (|Void|)
              (37 . |print|) (|List| 12) (42 . |concat|) (48 . |coerce|)
              (|List| 41) (53 . |coerce|) (58 . |coerce|) (63 . |coerce|)
              (|List| 8) (68 . |orientedFacetSigned|) (73 . |coerce|)
              (78 . |coerce|) (83 . |elt|) (89 . |setelt!|) (96 . |elt|)
              (102 . |orientedFacet|) (|List| $) (108 . |orientedFacetIfCan|)
              (113 . |remove|) (119 . |coerce|) (124 . |getIndexes|) (129 . =)
              (135 . |getMult|) (140 . |setMult!|) (146 . ~=)
              |SIMPC;addSimplex;$Of$;6| |SIMPC;maxIndex;$Nni;7|
              (152 . |minIndex|) |SIMPC;minIndex;$Nni;8| (157 . |order|)
              |SIMPC;grade;$L;9| (162 . |sort|) |SIMPC;sort;2$;10|
              (167 . |concat|) (173 . |subtractIfCan|) (179 . |concat|)
              (185 . |sameFace?|) (191 . |allSubsets|)
              |SIMPC;addImpliedFaces;$L;14| (198 . |boundary|)
              |SIMPC;boundary;2$;15| (203 . |isSubsetOf?|) |SIMPC;star;$Of$;16|
              (209 . |concat|) |SIMPC;link;$Of$;17| (215 . |addVertex|)
              |SIMPC;cone;$Nni$;18| (221 . |refactorIndexes|)
              |SIMPC;refactorIndexes;$Nni$;19| |SIMPC;makeDisjoint;3$;20|
              (227 . |join|) (233 . |concat|) |SIMPC;simplicialJoin;2$B$;21|
              |SIMPC;merge;3$;22|
              (|Record| (|:| |value| 15) (|:| |posX| 15) (|:| |posY| 15))
              (|List| 87) (239 . |member?|) (245 . |concat|)
              (|Record| (|:| |name| 27) (|:| |arrType| 15) (|:| |fromOb| 15)
                        (|:| |toOb| 15) (|:| |xOffset| 8) (|:| |yOffset| 8)
                        (|:| |map| 9))
              (|List| 91) (251 . |member?|) (257 . |concat|) (263 . |elt|)
              (|DirectedGraph| 15) |SIMPC;oneSkeleton;$Dg;25|
              (|GroupPresentation|) |SIMPC;fundamentalGroup;$2BGp;27|
              |SIMPC;fundamentalGroup;$Gp;26| (|FiniteSimplicialComplex| 6)
              (269 . |deltaComplex|) (274 . |fundamentalGroup|)
              (|ChainComplex|) (281 . |chain|) |SIMPC;chain;$Cc;28|
              (|CoChainComplex| 6) (286 . |coChainComplex|)
              |SIMPC;coChain;$Ccc;29| (|List| (|Homology|)) (291 . |homology|)
              |SIMPC;homology;$L;30| (296 . |coHomology|)
              |SIMPC;coHomology;$L;31| (301 . +) (307 . |concat|) (|List| 120)
              (313 . |product|) (319 . |concat|) (|ProductFacet|)
              (325 . |member?|) (331 . |concat|) (337 . |getMaxLeft|)
              (342 . |getMaxRight|) (|Record| (|:| |left| 15) (|:| |right| 15))
              (|List| 125) (347 . |getIndexs|) (352 . |getMult|)
              (357 . |concat|) |SIMPC;product;3$;32| (363 . |#|) (368 . ~=)
              (374 . |position|) (380 . ~=) (|List| 24) (386 . |elt|)
              (392 . |setelt!|) |SIMPC;=;2$B;34| (399 . |hconcat|)
              (404 . |bracket|) (409 . |vconcat|) |SIMPC;coerce;$Of;35|
              |SIMPC;coerce;$Dc;36| (|SingleInteger|) (|HashState|))
           '#(~= 415 |star| 421 |sort| 427 |simplicialJoin| 432
              |simplicialComplexIfCan| 439 |simplicialComplex| 450
              |refactorIndexes| 468 |product| 474 |oneSkeleton| 480 |minIndex|
              485 |merge| 490 |maxIndex| 496 |makeDisjoint| 501 |link| 507
              |latex| 513 |homology| 518 |hashUpdate!| 523 |hash| 529 |grade|
              534 |fundamentalGroup| 539 |cone| 551 |coerce| 557 |coHomology|
              567 |coChain| 572 |chain| 577 |boundary| 582 |addSimplex| 587
              |addImpliedFaces| 593 = 598)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 28))
                        (|makeByteWordVec2| 145
                                            '(2 10 0 8 9 11 2 12 0 0 10 13 1 10
                                              15 0 18 0 6 0 20 1 28 0 27 29 1
                                              23 28 0 30 2 28 0 0 0 31 1 28 32
                                              0 33 2 34 0 0 12 35 1 27 28 0 36
                                              1 37 28 0 38 1 15 28 0 39 1 34 28
                                              0 40 1 10 0 41 42 1 10 28 0 43 1
                                              41 28 0 44 2 34 12 0 8 45 3 34 12
                                              0 8 12 46 2 12 10 0 8 47 2 10 0 8
                                              10 48 1 10 22 49 50 2 12 0 10 0
                                              51 1 12 28 0 52 1 10 9 0 53 2 9
                                              24 0 0 54 1 10 8 0 55 2 10 0 0 8
                                              56 2 8 24 0 0 57 1 10 15 0 60 1
                                              10 15 0 62 1 12 0 0 64 2 37 0 0
                                              41 66 2 15 22 0 0 67 2 37 0 0 0
                                              68 2 10 24 0 0 69 3 10 49 0 15 15
                                              70 1 10 49 0 72 2 10 24 0 0 74 2
                                              12 0 0 0 76 2 10 0 0 15 78 2 10 0
                                              0 15 80 2 10 0 0 0 83 2 14 0 0 0
                                              84 2 88 24 87 0 89 2 88 0 0 87 90
                                              2 92 24 91 0 93 2 92 0 0 91 94 2
                                              9 15 0 8 95 1 23 0 101 102 3 23
                                              98 0 24 24 103 1 23 104 0 105 1
                                              107 0 104 108 1 23 110 0 111 1 23
                                              110 0 113 2 6 0 0 0 115 2 14 0 0
                                              6 116 2 10 117 0 0 118 2 117 0 0
                                              0 119 2 117 24 120 0 121 2 117 0
                                              0 120 122 1 120 15 0 123 1 120 15
                                              0 124 1 120 126 0 127 1 120 8 0
                                              128 2 9 0 0 15 129 1 9 15 0 131 2
                                              15 24 0 0 132 2 9 8 15 0 133 2 10
                                              24 0 0 134 2 135 24 0 8 136 3 135
                                              24 0 8 24 137 1 28 0 49 139 1 28
                                              0 0 140 2 28 0 0 0 141 2 0 24 0 0
                                              1 2 0 0 0 10 75 1 0 0 0 65 3 0 0
                                              0 0 24 85 2 0 22 23 24 25 1 0 22
                                              23 26 2 0 0 14 16 19 1 0 0 14 21
                                              3 0 0 14 15 16 17 2 0 0 0 15 81 2
                                              0 0 0 0 130 1 0 96 0 97 1 0 15 0
                                              61 2 0 0 0 0 86 1 0 15 0 59 2 0 0
                                              0 0 82 2 0 0 0 10 77 1 0 27 0 1 1
                                              0 110 0 112 2 0 145 145 0 1 1 0
                                              144 0 1 1 0 34 0 63 3 0 98 0 24
                                              24 99 1 0 98 0 100 2 0 0 0 15 79
                                              1 0 23 0 143 1 0 28 0 142 1 0 110
                                              0 114 1 0 107 0 109 1 0 104 0 106
                                              1 0 0 0 73 2 0 0 0 10 58 1 0 34 0
                                              71 2 0 24 0 0 138)))))
           '|lookupComplete|)) 


(SDEFUN |DELTAC;dim1todim0|
        ((|dim1| (|List| (|List| (|Integer|)))) (|n| #1=(|NonNegativeInteger|))
         ($ (|List| (|List| (|Integer|)))))
        (SPROG
         ((|res| (|List| (|List| (|Integer|)))) (#2=#:G746 NIL) (|x| NIL)
          (#3=#:G745 NIL) (|m3| (|NonNegativeInteger|)) (#4=#:G724 NIL)
          (#5=#:G744 NIL) (|m2| NIL) (#6=#:G743 NIL) (|smp| NIL)
          (|pointsUsed| (|List| (|Boolean|))) (|m| #1#) (#7=#:G718 NIL)
          (#8=#:G742 NIL) (#9=#:G741 NIL))
         (SEQ (LETT |m| |n|)
              (SEQ (LETT |smp| NIL) (LETT #9# |dim1|) G190
                   (COND
                    ((OR (ATOM #9#) (PROGN (LETT |smp| (CAR #9#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |m2| NIL) (LETT #8# |smp|) G190
                          (COND
                           ((OR (ATOM #8#) (PROGN (LETT |m2| (CAR #8#)) NIL))
                            (GO G191)))
                          (SEQ
                           (LETT |m3|
                                 (PROG1 (LETT #7# (ABS |m2|))
                                   (|check_subtype2| (>= #7# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #7#)))
                           (EXIT (COND ((> |m3| |m|) (LETT |m| |m3|)))))
                          (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
              (LETT |pointsUsed| (SPADCALL |m| NIL (QREFELT $ 11)))
              (SEQ (LETT |smp| NIL) (LETT #6# |dim1|) G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |smp| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |m2| NIL) (LETT #5# |smp|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |m2| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (LETT |m3|
                                 (PROG1 (LETT #4# (ABS |m2|))
                                   (|check_subtype2| (>= #4# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #4#)))
                           (EXIT
                            (SPADCALL |pointsUsed| |m3| 'T (QREFELT $ 13))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
              (LETT |res|
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |x| NIL) (LETT #2# |pointsUsed|) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #3#
                                  (CONS (COND (|x| (LIST 0)) ('T NIL)) #3#))))
                          (LETT #2# (CDR #2#)) (GO G190) G191
                          (EXIT (NREVERSE #3#)))))
              (EXIT |res|)))) 

(SDEFUN |DELTAC;deltaComplex;LNniL$;2|
        ((|v| (|List| VS)) (|numPoints| (|NonNegativeInteger|))
         (|f| (|List| (|List| (|List| (|Integer|))))) ($ ($)))
        (SPROG
         ((|fp| (|List| (|List| (|List| (|Integer|)))))
          (|f0| (|List| (|List| (|Integer|)))))
         (SEQ
          (LETT |f0|
                (|DELTAC;dim1todim0| (SPADCALL |f| '|last| (QREFELT $ 17))
                 |numPoints| $))
          (LETT |fp| (SPADCALL |f| |f0| (QREFELT $ 18)))
          (EXIT (CONS |v| |fp|))))) 

(SDEFUN |DELTAC;deltaComplex;Fsc$;3|
        ((|fsc| (|FiniteSimplicialComplex| VS)) ($ ($)))
        (SPADCALL |fsc| NIL (QREFELT $ 22))) 

(SDEFUN |DELTAC;deltaComplex;FscB$;4|
        ((|fsc| (|FiniteSimplicialComplex| VS)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|vs| #1=(|List| VS)) (|previousFaceList| (|List| (|OrientedFacet|)))
          (|faceMaps| (|List| (|List| (|List| (|Integer|)))))
          (|map1| (|List| (|List| (|Integer|))))
          (|newIndexes| (|List| (|Integer|))) (|i| (|Integer|)) (#2=#:G800 NIL)
          (|oldFaceLow| NIL) (|oldFacesLow| (|List| (|OrientedFacet|)))
          (#3=#:G799 NIL) (|oldFaceHigh| NIL) (#4=#:G798 NIL) (|x| NIL)
          (#5=#:G797 NIL) (|m3| (|NonNegativeInteger|)) (#6=#:G769 NIL)
          (#7=#:G796 NIL) (|m2| NIL) (#8=#:G795 NIL) (|smp| NIL)
          (|pointsUsed| (|List| (|Boolean|))) (|m| #9=(|NonNegativeInteger|))
          (#10=#:G763 NIL) (#11=#:G794 NIL) (#12=#:G793 NIL)
          (|map2| (|List| (|List| (|Integer|)))) (|fm| (|List| (|Integer|)))
          (#13=#:G792 NIL) (#14=#:G790 NIL) (|gradeList| NIL) (#15=#:G791 NIL)
          (|grn| NIL) (|allFacetsGraded| (|List| (|List| (|OrientedFacet|))))
          (#16=#:G789 NIL) (|l| NIL) (#17=#:G788 NIL)
          (|allFacets| (|List| (|List| (|OrientedFacet|))))
          (|fscRep|
           (|Record| (|:| VERTSET #1#) (|:| NUMPOINTS #9#)
                     (|:| SIMP (|List| (|OrientedFacet|))))))
         (SEQ (LETT |fscRep| |fsc|)
              (LETT |allFacets| (SPADCALL |fsc| (QREFELT $ 25)))
              (COND
               (|trace|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL (SPADCALL "deltaComplex(" (QREFELT $ 28))
                             (SPADCALL |fsc| (QREFELT $ 29)) (QREFELT $ 30))
                   (SPADCALL ") allFacets=" (QREFELT $ 28)) (QREFELT $ 30))
                  (SPADCALL |allFacets| (QREFELT $ 31)) (QREFELT $ 30))
                 (QREFELT $ 33))))
              (LETT |allFacetsGraded|
                    (PROGN
                     (LETT #17# NIL)
                     (SEQ (LETT |l| NIL) (LETT #16# |allFacets|) G190
                          (COND
                           ((OR (ATOM #16#) (PROGN (LETT |l| (CAR #16#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #17#
                                  (CONS (SPADCALL |l| (QREFELT $ 35)) #17#))))
                          (LETT #16# (CDR #16#)) (GO G190) G191
                          (EXIT (NREVERSE #17#)))))
              (COND
               (|trace|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL "deltaComplex allFacetsGraded=" (QREFELT $ 28))
                  (SPADCALL |allFacetsGraded| (QREFELT $ 31)) (QREFELT $ 30))
                 (QREFELT $ 33))))
              (LETT |faceMaps| NIL) (LETT |previousFaceList| NIL)
              (SEQ (LETT |grn| 1) (LETT #15# (LENGTH |allFacetsGraded|))
                   (LETT |gradeList| NIL) (LETT #14# |allFacetsGraded|) G190
                   (COND
                    ((OR (ATOM #14#) (PROGN (LETT |gradeList| (CAR #14#)) NIL)
                         (|greater_SI| |grn| #15#))
                     (GO G191)))
                   (SEQ
                    (COND
                     (|trace|
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL "deltaComplex grad num=" (QREFELT $ 28))
                          (SPADCALL |grn| (QREFELT $ 36)) (QREFELT $ 30))
                         (SPADCALL "=" (QREFELT $ 28)) (QREFELT $ 30))
                        (SPADCALL |gradeList| (QREFELT $ 37)) (QREFELT $ 30))
                       (QREFELT $ 33))))
                    (LETT |map1| NIL)
                    (COND
                     ((EQL |grn| 1)
                      (SEQ (LETT |map2| NIL)
                           (SEQ (LETT |x| NIL) (LETT #13# |gradeList|) G190
                                (COND
                                 ((OR (ATOM #13#)
                                      (PROGN (LETT |x| (CAR #13#)) NIL))
                                  (GO G191)))
                                (SEQ (LETT |fm| (SPADCALL |x| (QREFELT $ 40)))
                                     (LETT |map2| (CONS |fm| |map2|))
                                     (EXIT
                                      (COND
                                       (|trace|
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL
                                               "  deltaComplex getIndexesSigned("
                                               (QREFELT $ 28))
                                              (SPADCALL |x| (QREFELT $ 41))
                                              (QREFELT $ 30))
                                             (SPADCALL ") fm=" (QREFELT $ 28))
                                             (QREFELT $ 30))
                                            (SPADCALL |fm| (QREFELT $ 42))
                                            (QREFELT $ 30))
                                           (SPADCALL " map2=" (QREFELT $ 28))
                                           (QREFELT $ 30))
                                          (SPADCALL |map2| (QREFELT $ 43))
                                          (QREFELT $ 30))
                                         (QREFELT $ 33))))))
                                (LETT #13# (CDR #13#)) (GO G190) G191
                                (EXIT NIL))
                           (LETT |m| (QVELT |fscRep| 1))
                           (SEQ (LETT |smp| NIL) (LETT #12# |map2|) G190
                                (COND
                                 ((OR (ATOM #12#)
                                      (PROGN (LETT |smp| (CAR #12#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SEQ (LETT |m2| NIL) (LETT #11# |smp|) G190
                                       (COND
                                        ((OR (ATOM #11#)
                                             (PROGN
                                              (LETT |m2| (CAR #11#))
                                              NIL))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |m3|
                                              (PROG1 (LETT #10# (ABS |m2|))
                                                (|check_subtype2| (>= #10# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #10#)))
                                        (EXIT
                                         (COND
                                          ((> |m3| |m|) (LETT |m| |m3|)))))
                                       (LETT #11# (CDR #11#)) (GO G190) G191
                                       (EXIT NIL))))
                                (LETT #12# (CDR #12#)) (GO G190) G191
                                (EXIT NIL))
                           (COND
                            (|trace|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL "  deltaComplex m=" (QREFELT $ 28))
                               (SPADCALL |m| (QREFELT $ 36)) (QREFELT $ 30))
                              (QREFELT $ 33))))
                           (LETT |pointsUsed|
                                 (SPADCALL |m| NIL (QREFELT $ 11)))
                           (SEQ (LETT |smp| NIL) (LETT #8# |map2|) G190
                                (COND
                                 ((OR (ATOM #8#)
                                      (PROGN (LETT |smp| (CAR #8#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SEQ (LETT |m2| NIL) (LETT #7# |smp|) G190
                                       (COND
                                        ((OR (ATOM #7#)
                                             (PROGN (LETT |m2| (CAR #7#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |m3|
                                              (PROG1 (LETT #6# (ABS |m2|))
                                                (|check_subtype2| (>= #6# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #6#)))
                                        (EXIT
                                         (SPADCALL |pointsUsed| |m3| 'T
                                                   (QREFELT $ 13))))
                                       (LETT #7# (CDR #7#)) (GO G190) G191
                                       (EXIT NIL))))
                                (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                           (LETT |map1|
                                 (PROGN
                                  (LETT #5# NIL)
                                  (SEQ (LETT |x| NIL) (LETT #4# |pointsUsed|)
                                       G190
                                       (COND
                                        ((OR (ATOM #4#)
                                             (PROGN (LETT |x| (CAR #4#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #5#
                                               (CONS
                                                (COND (|x| (LIST 0)) ('T NIL))
                                                #5#))))
                                       (LETT #4# (CDR #4#)) (GO G190) G191
                                       (EXIT (NREVERSE #5#)))))
                           (COND
                            (|trace|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL "  deltaComplex m="
                                             (QREFELT $ 28))
                                   (SPADCALL |m| (QREFELT $ 36))
                                   (QREFELT $ 30))
                                  (SPADCALL " map2=" (QREFELT $ 28))
                                  (QREFELT $ 30))
                                 (SPADCALL |map2| (QREFELT $ 43))
                                 (QREFELT $ 30))
                                (SPADCALL " map1=" (QREFELT $ 28))
                                (QREFELT $ 30))
                               (SPADCALL |map1| (QREFELT $ 43)) (QREFELT $ 30))
                              (QREFELT $ 33))))
                           (EXIT (LETT |map1| (REVERSE |map1|)))))
                     ('T
                      (SEQ (LETT |oldFaceHigh| NIL) (LETT #3# |gradeList|) G190
                           (COND
                            ((OR (ATOM #3#)
                                 (PROGN (LETT |oldFaceHigh| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |oldFacesLow|
                                  (SPADCALL |oldFaceHigh| (QREFELT $ 45)))
                            (LETT |newIndexes| NIL)
                            (SEQ (LETT |oldFaceLow| NIL)
                                 (LETT #2# |oldFacesLow|) G190
                                 (COND
                                  ((OR (ATOM #2#)
                                       (PROGN
                                        (LETT |oldFaceLow| (CAR #2#))
                                        NIL))
                                   (GO G191)))
                                 (SEQ
                                  (COND
                                   (|trace|
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           "    deltaComplex oldFaceLow="
                                           (QREFELT $ 28))
                                          (SPADCALL |oldFaceLow|
                                                    (QREFELT $ 41))
                                          (QREFELT $ 30))
                                         (SPADCALL " previousFaceList="
                                                   (QREFELT $ 28))
                                         (QREFELT $ 30))
                                        (SPADCALL |previousFaceList|
                                                  (QREFELT $ 37))
                                        (QREFELT $ 30))
                                       (SPADCALL " allFacetsGraded.1="
                                                 (QREFELT $ 28))
                                       (QREFELT $ 30))
                                      (SPADCALL
                                       (SPADCALL |allFacetsGraded| 1
                                                 (QREFELT $ 46))
                                       (QREFELT $ 37))
                                      (QREFELT $ 30))
                                     (QREFELT $ 33))))
                                  (LETT |i|
                                        (SPADCALL |oldFaceLow|
                                                  |previousFaceList|
                                                  (QREFELT $ 47)))
                                  (COND
                                   ((EQL |i| 0)
                                    (SEQ
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL "  deltaComplex oldFaceLow="
                                                   (QREFELT $ 28))
                                         (SPADCALL |oldFaceLow| (QREFELT $ 41))
                                         (QREFELT $ 30))
                                        (SPADCALL
                                         " not found in previousFaceList="
                                         (QREFELT $ 28))
                                        (QREFELT $ 30))
                                       (SPADCALL |previousFaceList|
                                                 (QREFELT $ 37))
                                       (QREFELT $ 30))
                                      (QREFELT $ 33))
                                     (EXIT
                                      (|error|
                                       (STRCONC "can not find index:"
                                                (STRINGIMAGE |i|)))))))
                                  (EXIT
                                   (LETT |newIndexes|
                                         (CONS |i| |newIndexes|))))
                                 (LETT #2# (CDR #2#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT
                             (LETT |map1|
                                   (CONS (NREVERSE |newIndexes|) |map1|))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))))
                    (LETT |faceMaps| (CONS (NREVERSE |map1|) |faceMaps|))
                    (EXIT (LETT |previousFaceList| |gradeList|)))
                   (LETT #14# (PROG1 (CDR #14#) (LETT |grn| (|inc_SI| |grn|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |vs| (QVELT |fscRep| 0))
              (COND
               (|trace|
                (SPADCALL
                 (SPADCALL (SPADCALL "deltaComplex faceMaps=" (QREFELT $ 28))
                           (SPADCALL |faceMaps| (QREFELT $ 49)) (QREFELT $ 30))
                 (QREFELT $ 33))))
              (EXIT (CONS |vs| |faceMaps|))))) 

(SDEFUN |DELTAC;deltaComplex;Fcc$;5|
        ((|fsc| (|FiniteCubicalComplex| VS)) ($ ($)))
        (SPROG
         ((|fp| (|List| (|List| (|List| (|Integer|)))))
          (|f0| (|List| (|List| (|Integer|)))) (|m| (|NonNegativeInteger|))
          (|vs| (|List| VS)) (|previousFaceList| (|List| (|CubicalFacet|)))
          (|faceMaps| (|List| (|List| (|List| (|Integer|)))))
          (|map1| (|List| (|List| (|Integer|))))
          (|newIndexes| (|List| (|Integer|))) (|i| (|Integer|)) (#1=#:G821 NIL)
          (|oldFaceLow| NIL) (|oldFacesLow| (|List| (|CubicalFacet|)))
          (#2=#:G820 NIL) (|oldFaceHigh| NIL) (#3=#:G818 NIL) (|gradeList| NIL)
          (#4=#:G819 NIL) (|grn| NIL)
          (|allFacetsGraded| (|List| (|List| (|CubicalFacet|))))
          (#5=#:G817 NIL) (|gradedList| NIL)
          (|allFacets| (|List| (|List| (|CubicalFacet|)))))
         (SEQ (LETT |allFacets| (SPADCALL |fsc| (QREFELT $ 52)))
              (LETT |allFacetsGraded| NIL)
              (SEQ (LETT |gradedList| NIL) (LETT #5# |allFacets|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |gradedList| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |allFacetsGraded|
                           (SPADCALL |allFacetsGraded|
                                     (SPADCALL |gradedList| (QREFELT $ 54))
                                     (QREFELT $ 55)))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (LETT |faceMaps| NIL)
              (LETT |previousFaceList| (|SPADfirst| |allFacetsGraded|))
              (SEQ (LETT |grn| 1) (LETT #4# (LENGTH |allFacetsGraded|))
                   (LETT |gradeList| NIL) (LETT #3# |allFacetsGraded|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |gradeList| (CAR #3#)) NIL)
                         (|greater_SI| |grn| #4#))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND ((EQL |grn| 1) "iterate")
                           ('T
                            (SEQ (LETT |map1| NIL)
                                 (SEQ (LETT |oldFaceHigh| NIL)
                                      (LETT #2# |gradeList|) G190
                                      (COND
                                       ((OR (ATOM #2#)
                                            (PROGN
                                             (LETT |oldFaceHigh| (CAR #2#))
                                             NIL))
                                        (GO G191)))
                                      (SEQ
                                       (LETT |oldFacesLow|
                                             (SPADCALL |oldFaceHigh|
                                                       (QREFELT $ 57)))
                                       (LETT |newIndexes| NIL)
                                       (SEQ (LETT |oldFaceLow| NIL)
                                            (LETT #1# |oldFacesLow|) G190
                                            (COND
                                             ((OR (ATOM #1#)
                                                  (PROGN
                                                   (LETT |oldFaceLow|
                                                         (CAR #1#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (LETT |i|
                                                   (SPADCALL |oldFaceLow|
                                                             |previousFaceList|
                                                             (QREFELT $ 58)))
                                             (COND
                                              ((EQL |i| 0)
                                               (SEQ
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     "  deltaComplex oldFaceLow="
                                                     (QREFELT $ 28))
                                                    (SPADCALL |oldFaceLow|
                                                              (QREFELT $ 59))
                                                    (QREFELT $ 30))
                                                   (SPADCALL
                                                    " not found in previousFaceList="
                                                    (QREFELT $ 28))
                                                   (QREFELT $ 30))
                                                  (SPADCALL |previousFaceList|
                                                            (QREFELT $ 60))
                                                  (QREFELT $ 30))
                                                 (QREFELT $ 33))
                                                (EXIT
                                                 (|error|
                                                  (STRCONC
                                                   "deltaComplex: can not find index:"
                                                   (STRINGIMAGE |i|)))))))
                                             (EXIT
                                              (LETT |newIndexes|
                                                    (CONS |i| |newIndexes|))))
                                            (LETT #1# (CDR #1#)) (GO G190) G191
                                            (EXIT NIL))
                                       (EXIT
                                        (LETT |map1|
                                              (CONS (NREVERSE |newIndexes|)
                                                    |map1|))))
                                      (LETT #2# (CDR #2#)) (GO G190) G191
                                      (EXIT NIL))
                                 (LETT |faceMaps|
                                       (CONS (NREVERSE |map1|) |faceMaps|))
                                 (EXIT
                                  (LETT |previousFaceList| |gradeList|)))))))
                   (LETT #3# (PROG1 (CDR #3#) (LETT |grn| (|inc_SI| |grn|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |vs| (QCAR |fsc|))
              (LETT |m| (SPADCALL |fsc| (QREFELT $ 61)))
              (LETT |f0|
                    (|DELTAC;dim1todim0|
                     (SPADCALL |faceMaps| '|last| (QREFELT $ 17)) |m| $))
              (LETT |fp| (SPADCALL |faceMaps| |f0| (QREFELT $ 18)))
              (EXIT (CONS |vs| |fp|))))) 

(SDEFUN |DELTAC;link;2Nni$;6|
        ((|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|simp| (|List| (|List| (|List| (|Integer|)))))
          (|points| (|List| (|List| (|Integer|)))) (|vs| (|List| VS)))
         (SEQ (LETT |vs| NIL) (LETT |simp| (LIST (LIST (LIST |a| |b|))))
              (LETT |points| (|DELTAC;dim1todim0| (|SPADfirst| |simp|) 2 $))
              (LETT |simp| (SPADCALL |simp| |points| (QREFELT $ 18)))
              (EXIT (CONS |vs| |simp|))))) 

(SDEFUN |DELTAC;triangle;3Nni$;7|
        ((|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         (|c| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|simp| (|List| #1=(|List| (|List| (|Integer|))))) (|points| #1#)
          (|triangles| (|List| (|List| (|Integer|))))
          (|edges| (|List| (|List| (|Integer|)))) (|vs| (|List| VS)))
         (SEQ (LETT |vs| NIL)
              (LETT |edges|
                    (LIST (LIST |a| |b|) (LIST |a| |c|) (LIST |b| |c|)))
              (LETT |triangles| (LIST (LIST 1 -2 3)))
              (LETT |points| (|DELTAC;dim1todim0| |edges| 3 $))
              (LETT |simp| (LIST |triangles| |edges| |points|))
              (EXIT (CONS |vs| |simp|))))) 

(SDEFUN |DELTAC;faceMap;$NniL;8|
        ((|s| ($)) (|n| (|NonNegativeInteger|))
         ($ (|List| (|List| (|Integer|)))))
        (SPROG
         ((#1=#:G830 NIL) (|maps1| (|List| (|List| (|List| (|Integer|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |maps1| (REVERSE (QCDR |s|)))
                (COND
                 ((> |n| (LENGTH |maps1|))
                  (PROGN (LETT #1# NIL) (GO #2=#:G829))))
                (EXIT (SPADCALL |maps1| |n| (QREFELT $ 65)))))
          #2# (EXIT #1#)))) 

(SDEFUN |DELTAC;chain;$Cc;9| ((|s| ($)) ($ (|ChainComplex|)))
        (SPROG
         ((|res| (|List| (|Matrix| (|Integer|)))) (|m| (|Matrix| (|Integer|)))
          (|n_rows| (|NonNegativeInteger|)) (|ele| (|Integer|))
          (|v2| (|Integer|)) (#1=#:G846 NIL) (|v| NIL) (#2=#:G844 NIL)
          (|u| NIL) (#3=#:G845 NIL) (|nu| NIL)
          (|n_cols| (|NonNegativeInteger|)) (#4=#:G843 NIL) (|faces| NIL)
          (|maps1| (|List| (|List| (|List| (|Integer|))))))
         (SEQ (LETT |res| NIL) (LETT |maps1| (REVERSE (QCDR |s|)))
              (LETT |n_rows| 1)
              (SEQ (LETT |faces| NIL) (LETT #4# |maps1|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |faces| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |n_cols| (LENGTH |faces|))
                        (LETT |m| (SPADCALL |n_rows| |n_cols| (QREFELT $ 68)))
                        (SEQ (LETT |nu| 1) (LETT #3# (LENGTH |faces|))
                             (LETT |u| NIL) (LETT #2# |faces|) G190
                             (COND
                              ((OR (ATOM #2#) (PROGN (LETT |u| (CAR #2#)) NIL)
                                   (|greater_SI| |nu| #3#))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |v| NIL) (LETT #1# |u|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |v| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ (LETT |v2| (ABS |v|))
                                         (EXIT
                                          (COND
                                           ((> |v2| 0)
                                            (SEQ
                                             (LETT |ele|
                                                   (COND ((> |v| 0) 1)
                                                         ('T -1)))
                                             (EXIT
                                              (SPADCALL |m| |v2| |nu|
                                                        (+
                                                         (QAREF2O |m| |v2| |nu|
                                                                  1 1)
                                                         |ele|)
                                                        (QREFELT $ 69))))))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT NIL))))
                             (LETT #2#
                                   (PROG1 (CDR #2#)
                                     (LETT |nu| (|inc_SI| |nu|))))
                             (GO G190) G191 (EXIT NIL))
                        (LETT |res| (CONS |m| |res|))
                        (EXIT (LETT |n_rows| |n_cols|)))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (LETT |m| (MAKE_MATRIX1 |n_rows| 0 0))
              (LETT |res| (CONS |m| |res|))
              (EXIT (SPADCALL (NREVERSE |res|) (QREFELT $ 72)))))) 

(SDEFUN |DELTAC;coChain;$Ccc;10| ((|s| ($)) ($ (|CoChainComplex| VS)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 73)) (QREFELT $ 75))) 

(SDEFUN |DELTAC;homology;$L;11| ((|a| ($)) ($ (|List| (|Homology|))))
        (SPROG ((|cc| (|ChainComplex|)))
               (SEQ (LETT |cc| (SPADCALL |a| (QREFELT $ 73)))
                    (SPADCALL |cc| (QREFELT $ 77))
                    (EXIT (SPADCALL |cc| (QREFELT $ 79)))))) 

(SDEFUN |DELTAC;coHomology;$L;12| ((|a| ($)) ($ (|List| (|Homology|))))
        (SPROG ((|cc| (|CoChainComplex| VS)))
               (SEQ (LETT |cc| (SPADCALL |a| (QREFELT $ 76)))
                    (SPADCALL |cc| (QREFELT $ 81))
                    (EXIT (SPADCALL |cc| (QREFELT $ 82)))))) 

(SDEFUN |DELTAC;oneSkeleton;$Ug;13|
        ((|s| ($)) ($ (|UndirectedGraph| (|NonNegativeInteger|))))
        (SPROG
         ((|nodes|
           (|List|
            (|Record| (|:| |value| (|NonNegativeInteger|))
                      (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (#1=#:G866 NIL) (|m1| NIL)
          (|edges|
           (|List|
            #2=(|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|y| #2#) (|m| (|NonNegativeInteger|))
          (|to1| #3=(|NonNegativeInteger|)) (|from1| #3#) (#4=#:G865 NIL)
          (|x| NIL) (|edgeIndexes| (|List| (|List| (|Integer|))))
          (#5=#:G864 NIL)
          (GS
           (|Join| (|FiniteGraph| #6=(|NonNegativeInteger|))
                   (CATEGORY |domain|
                    (SIGNATURE |undirectedGraph| ($ (|List| #6#)))
                    (SIGNATURE |undirectedGraph|
                     ($
                      (|List|
                       (|Record| (|:| |value| #6#)
                                 (|:| |posX| (|NonNegativeInteger|))
                                 (|:| |posY| (|NonNegativeInteger|))))))
                    (SIGNATURE |undirectedGraph|
                     ($
                      (|List|
                       (|Record| (|:| |value| #6#)
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
                    (SIGNATURE |undirectedGraph|
                     ($ (|List| #6#)
                      (|List|
                       (|Record| (|:| |fromOb| (|NonNegativeInteger|))
                                 (|:| |toOb| (|NonNegativeInteger|))))))
                    (SIGNATURE |undirectedGraph| ($ (|FinitePoset| #6#)))
                    (SIGNATURE |undirectedGraph|
                     ($ (|List| #6#) (|List| (|List| (|NonNegativeInteger|)))))
                    (SIGNATURE * ((|UndirectedGraph| (|Product| #6# #6#)) $ $))
                    (SIGNATURE |cartesian|
                     ((|UndirectedGraph| (|Product| #6# #6#)) $ $))
                    (SIGNATURE |closedTensor| ($ $ $ (|Mapping| #6# #6# #6#)))
                    (SIGNATURE |closedCartesian|
                     ($ $ $ (|Mapping| #6# #6# #6#)))
                    (SIGNATURE |diagramSvg2|
                     ((|Void|) (|String|) $ (|Boolean|)))
                    (SIGNATURE |coerce| ($ (|FinitePoset| #6#)))))))
         (SEQ
          (EXIT
           (SEQ (LETT GS (|UndirectedGraph| (|NonNegativeInteger|)))
                (LETT |nodes| NIL) (LETT |edges| NIL)
                (COND
                 ((< (LENGTH (QCDR |s|)) 2)
                  (PROGN
                   (LETT #5#
                         (SPADCALL
                          (|compiledLookupCheck| '|initial| (LIST '$) GS)))
                   (GO #7=#:G863))))
                (LETT |m|
                      (LENGTH (SPADCALL (REVERSE (QCDR |s|)) (QREFELT $ 84))))
                (LETT |edgeIndexes|
                      (SPADCALL (REVERSE (QCDR |s|)) (QREFELT $ 84)))
                (SEQ (LETT |x| NIL) (LETT #4# |edgeIndexes|) G190
                     (COND
                      ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |from1| (ABS (SPADCALL |x| 1 (QREFELT $ 85))))
                          (COND ((> |from1| |m|) (LETT |m| |from1|)))
                          (LETT |to1| (ABS (SPADCALL |x| 2 (QREFELT $ 85))))
                          (COND ((> |to1| |m|) (LETT |m| |to1|)))
                          (LETT |y| (VECTOR "x" 0 |from1| |to1| 0 0 NIL))
                          (EXIT
                           (LETT |edges|
                                 (SPADCALL |edges| |y| (QREFELT $ 88)))))
                     (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                (SEQ (LETT |m1| 1) (LETT #1# |m|) G190
                     (COND ((|greater_SI| |m1| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |nodes|
                             (SPADCALL |nodes| (VECTOR |m1| 0 0)
                                       (QREFELT $ 91)))))
                     (LETT |m1| (|inc_SI| |m1|)) (GO G190) G191 (EXIT NIL))
                (EXIT
                 (SPADCALL |nodes| |edges|
                           (|compiledLookupCheck| '|undirectedGraph|
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
                                                  GS)))))
          #7# (EXIT #5#)))) 

(SDEFUN |DELTAC;linksInTree|
        ((|res| (|List| (|List| (|Integer|)))) (|a| (|Tree| (|Integer|)))
         ($ (|List| (|List| (|Integer|)))))
        (SPROG
         ((#1=#:G876 NIL) (|x| NIL) (|newLink| (|List| #2=(|Integer|)))
          (|toNode| #2#) (#3=#:G875 NIL) (|fromNode| #2#))
         (SEQ (LETT |fromNode| (SPADCALL |a| (QREFELT $ 95)))
              (SEQ (LETT |x| NIL) (LETT #3# (SPADCALL |a| (QREFELT $ 96))) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |toNode| (SPADCALL |x| (QREFELT $ 95)))
                        (LETT |newLink| (LIST |fromNode| |toNode|))
                        (EXIT
                         (LETT |res|
                               (SPADCALL |res| |newLink| (QREFELT $ 97)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |x| NIL) (LETT #1# (SPADCALL |a| (QREFELT $ 96))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (LETT |res| (|DELTAC;linksInTree| |res| |x| $))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |DELTAC;containsEdge?|
        ((|edge| (|List| (|Integer|))) (|edges| (|List| (|List| (|Integer|))))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G888 NIL) (|t2| #2=(|Integer|)) (|s2| #2#) (#3=#:G889 NIL)
          (|e| NIL) (|t| #2#) (|s| #2#))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((< (LENGTH |edge|) 2) (PROGN (LETT #1# NIL) (GO #4=#:G887))))
            (LETT |s| (SPADCALL |edge| 1 (QREFELT $ 85)))
            (LETT |t| (SPADCALL |edge| 2 (QREFELT $ 85)))
            (SEQ (LETT |e| NIL) (LETT #3# |edges|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |e| (CAR #3#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((> (LENGTH |e|) 1)
                     (SEQ (LETT |s2| (SPADCALL |e| 1 (QREFELT $ 85)))
                          (LETT |t2| (SPADCALL |e| 2 (QREFELT $ 85)))
                          (COND
                           ((EQL (ABS |s|) (ABS |s2|))
                            (COND
                             ((EQL (ABS |t|) (ABS |t2|))
                              (PROGN (LETT #1# 'T) (GO #4#))))))
                          (EXIT
                           (COND
                            ((EQL (ABS |s|) (ABS |t2|))
                             (COND
                              ((EQL (ABS |t|) (ABS |s2|))
                               (PROGN (LETT #1# 'T) (GO #4#))))))))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (EXIT NIL)))
          #4# (EXIT #1#)))) 

(SDEFUN |DELTAC;fundamentalGroup;$Gp;16| ((|s| ($)) ($ (|GroupPresentation|)))
        (SPADCALL |s| 'T NIL (QREFELT $ 99))) 

(SDEFUN |DELTAC;fundamentalGroup;$2BGp;17|
        ((|s| ($)) (|simplify| (|Boolean|)) (|trace| (|Boolean|))
         ($ (|GroupPresentation|)))
        (SPROG
         ((#1=#:G908 NIL) (|gp| (|GroupPresentation|))
          (|generators| (|List| (|NonNegativeInteger|))) (#2=#:G915 NIL)
          (|x| NIL) (|m| (|NonNegativeInteger|))
          (|rules| (|List| (|List| (|Integer|)))) (|rule| (|List| (|Integer|)))
          (#3=#:G914 NIL) (|vertn| NIL) (#4=#:G913 NIL) (|t| NIL)
          (|polygons| #5=(|List| (|List| (|Integer|)))) (#6=#:G911 NIL)
          (|edge| NIL) (#7=#:G912 NIL) (|edgen| NIL)
          (|edgesInTree| (|List| (|Boolean|))) (#8=#:G910 NIL) (|y| NIL)
          (#9=#:G909 NIL) (|res| (|List| (|List| (|Integer|)))) (|edges| #5#)
          (|span| (|Tree| (|Integer|)))
          (|graph| (|UndirectedGraph| (|NonNegativeInteger|))))
         (SEQ
          (EXIT
           (SEQ
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL
                (SPADCALL (SPADCALL "fundamentalGroup(" (QREFELT $ 28))
                          (SPADCALL |s| (QREFELT $ 101)) (QREFELT $ 30))
                (SPADCALL ")" (QREFELT $ 28)) (QREFELT $ 30))
               (QREFELT $ 33))))
            (LETT |graph| (SPADCALL |s| (QREFELT $ 93)))
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL (SPADCALL "fundamentalGroup graph=" (QREFELT $ 102))
                         (SPADCALL |graph| (QREFELT $ 103)) (QREFELT $ 30))
               (QREFELT $ 33))))
            (LETT |span| (SPADCALL |graph| 1 (QREFELT $ 104)))
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL (SPADCALL "fundamentalGroup span=" (QREFELT $ 28))
                         (SPADCALL |span| (QREFELT $ 105)) (QREFELT $ 30))
               (QREFELT $ 33))))
            (LETT |edges| (SPADCALL |s| 2 (QREFELT $ 66)))
            (LETT |res| (|DELTAC;linksInTree| |res| |span| $))
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL "fundamentalGroup edges=" (QREFELT $ 28))
                           (SPADCALL |edges| (QREFELT $ 43)) (QREFELT $ 30))
                 (SPADCALL " res=" (QREFELT $ 28)) (QREFELT $ 30))
                (SPADCALL |res| (QREFELT $ 43)) (QREFELT $ 30))
               (QREFELT $ 33))))
            (LETT |edgesInTree|
                  (PROGN
                   (LETT #9# NIL)
                   (SEQ (LETT |y| NIL) (LETT #8# |edges|) G190
                        (COND
                         ((OR (ATOM #8#) (PROGN (LETT |y| (CAR #8#)) NIL))
                          (GO G191)))
                        (SEQ (EXIT (LETT #9# (CONS NIL #9#))))
                        (LETT #8# (CDR #8#)) (GO G190) G191
                        (EXIT (NREVERSE #9#)))))
            (SEQ (LETT |edgen| 1) (LETT #7# (LENGTH |edges|)) (LETT |edge| NIL)
                 (LETT #6# |edges|) G190
                 (COND
                  ((OR (ATOM #6#) (PROGN (LETT |edge| (CAR #6#)) NIL)
                       (|greater_SI| |edgen| #7#))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((|DELTAC;containsEdge?| |edge| |res| $)
                     (SPADCALL |edgesInTree| |edgen| 'T (QREFELT $ 13))))))
                 (LETT #6# (PROG1 (CDR #6#) (LETT |edgen| (|inc_SI| |edgen|))))
                 (GO G190) G191 (EXIT NIL))
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL
                (SPADCALL
                 (SPADCALL
                  (SPADCALL "fundamentalGroup linksInTree=" (QREFELT $ 28))
                  (SPADCALL |res| (QREFELT $ 43)) (QREFELT $ 30))
                 (SPADCALL " edgesInTree=" (QREFELT $ 28)) (QREFELT $ 30))
                (SPADCALL |edgesInTree| (QREFELT $ 106)) (QREFELT $ 30))
               (QREFELT $ 33))))
            (LETT |polygons| (SPADCALL |s| 3 (QREFELT $ 66)))
            (LETT |rules| NIL)
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL (SPADCALL "fundamentalGroup polygons=" (QREFELT $ 28))
                         (SPADCALL |polygons| (QREFELT $ 43)) (QREFELT $ 30))
               (QREFELT $ 33))))
            (SEQ (LETT |t| NIL) (LETT #4# |polygons|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |t| (CAR #4#)) NIL)) (GO G191)))
                 (SEQ (LETT |rule| NIL)
                      (SEQ (LETT |vertn| 1) (LETT #3# (LENGTH |t|)) G190
                           (COND ((|greater_SI| |vertn| #3#) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL
                                (SPADCALL |edgesInTree|
                                          (ABS
                                           (SPADCALL |t| |vertn|
                                                     (QREFELT $ 85)))
                                          (QREFELT $ 107)))
                               (LETT |rule|
                                     (SPADCALL |rule|
                                               (SPADCALL |t| |vertn|
                                                         (QREFELT $ 85))
                                               (QREFELT $ 108)))))))
                           (LETT |vertn| (|inc_SI| |vertn|)) (GO G190) G191
                           (EXIT NIL))
                      (EXIT
                       (COND
                        ((NULL (NULL |rule|))
                         (LETT |rules|
                               (SPADCALL |rules| |rule| (QREFELT $ 97)))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL (SPADCALL "fundamentalGroup rules=" (QREFELT $ 28))
                         (SPADCALL |rules| (QREFELT $ 43)) (QREFELT $ 30))
               (QREFELT $ 33))))
            (LETT |m| (LENGTH |edges|)) (LETT |generators| NIL)
            (SEQ (LETT |x| 1) (LETT #2# |m|) G190
                 (COND ((|greater_SI| |x| #2#) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((NULL (SPADCALL |edgesInTree| |x| (QREFELT $ 107)))
                     (LETT |generators|
                           (SPADCALL |generators| |x| (QREFELT $ 110)))))))
                 (LETT |x| (|inc_SI| |x|)) (GO G190) G191 (EXIT NIL))
            (LETT |gp| (SPADCALL |generators| |rules| (QREFELT $ 111)))
            (COND ((NULL |simplify|) (PROGN (LETT #1# |gp|) (GO #10=#:G907))))
            (EXIT (SPADCALL |gp| |trace| (QREFELT $ 112)))))
          #10# (EXIT #1#)))) 

(SDEFUN |DELTAC;equalSimplex|
        ((|a| (|List| (|Integer|))) (|b| (|List| (|Integer|))) ($ (|Boolean|)))
        (SPROG
         ((|offset| (|Integer|)) (#1=#:G924 NIL) (#2=#:G925 NIL) (|n| NIL)
          (|fst| (|Integer|)) (|len| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |len| (LENGTH |a|))
                (COND
                 ((SPADCALL |len| (LENGTH |b|) (QREFELT $ 113))
                  (PROGN (LETT #1# NIL) (GO #3=#:G923))))
                (COND ((EQL |len| 0) (PROGN (LETT #1# 'T) (GO #3#))))
                (LETT |fst| (|SPADfirst| |a|))
                (LETT |offset| (SPADCALL |fst| |b| (QREFELT $ 114)))
                (COND ((< |offset| 1) (PROGN (LETT #1# NIL) (GO #3#))))
                (SEQ (LETT |n| 1) (LETT #2# (LENGTH |a|)) G190
                     (COND ((|greater_SI| |n| #2#) (GO G191)))
                     (SEQ
                      (COND
                       ((SPADCALL (SPADCALL |a| |n| (QREFELT $ 85))
                                  (SPADCALL |b| |offset| (QREFELT $ 85))
                                  (QREFELT $ 115))
                        (PROGN (LETT #1# NIL) (GO #3#))))
                      (LETT |offset| (+ |offset| 1))
                      (EXIT
                       (COND ((> |offset| (LENGTH |b|)) (LETT |offset| 1)))))
                     (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
                (EXIT 'T)))
          #3# (EXIT #1#)))) 

(SDEFUN |DELTAC;=;2$B;19| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G929 NIL) (|len| (|NonNegativeInteger|))
          (|bs| #2=(|List| (|List| (|List| (|Integer|))))) (|as| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |as| (QCDR |a|)) (LETT |bs| (QCDR |b|))
                (LETT |len| (LENGTH |as|))
                (COND
                 ((SPADCALL |len| (LENGTH |bs|) (QREFELT $ 113))
                  (PROGN (LETT #1# NIL) (GO #3=#:G928))))
                (EXIT 'T)))
          #3# (EXIT #1#)))) 

(SDEFUN |DELTAC;coerce;$Of;20| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|tabNum| (|Integer|)) (|res| (|OutputForm|)) (|row| (|OutputForm|))
          (#1=#:G937 NIL) (|a| NIL) (#2=#:G936 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |res| (SPADCALL (QREFELT $ 117)))
                (COND
                 ((NULL (QCDR |s|))
                  (PROGN
                   (LETT #2#
                         (SPADCALL
                          (LIST (SPADCALL "1D: points 1.." (QREFELT $ 28)))
                          (QREFELT $ 118)))
                   (GO #3=#:G935))))
                (LETT |tabNum| (- (LENGTH (QCDR |s|)) 1))
                (SEQ (LETT |a| NIL) (LETT #1# (QCDR |s|)) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |row|
                            (SPADCALL
                             (LIST (SPADCALL " " (QREFELT $ 28))
                                   (SPADCALL |tabNum| (QREFELT $ 119))
                                   (SPADCALL "D:" (QREFELT $ 28))
                                   (SPADCALL |a| (QREFELT $ 43)))
                             (QREFELT $ 118)))
                      (LETT |res| (SPADCALL |res| |row| (QREFELT $ 120)))
                      (EXIT (LETT |tabNum| (- |tabNum| 1))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #3# (EXIT #2#)))) 

(SDEFUN |DELTAC;coerce;$Fsc;21| ((|s| ($)) ($ (|FiniteSimplicialComplex| VS)))
        (SPROG ((#1=#:G939 NIL))
               (PROG2 (LETT #1# (SPADCALL |s| (QREFELT $ 123)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0)
                                 (|FiniteSimplicialComplex| (QREFELT $ 6))
                                 (|Union|
                                  (|FiniteSimplicialComplex| (QREFELT $ 6))
                                  "failed")
                                 #1#)))) 

(DECLAIM (NOTINLINE |DeltaComplex;|)) 

(DEFUN |DeltaComplex| (#1=#:G942)
  (SPROG NIL
         (PROG (#2=#:G943)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|DeltaComplex|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|DeltaComplex;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|DeltaComplex|)))))))))) 

(DEFUN |DeltaComplex;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|DeltaComplex| DV$1))
          (LETT $ (GETREFV 127))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DeltaComplex| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| VERTSET (|List| |#1|))
                              (|:| MAPS
                                   (|List| (|List| (|List| (|Integer|)))))))
          $))) 

(MAKEPROP '|DeltaComplex| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (|NonNegativeInteger|) (|Boolean|) (|List| 9) (0 . |new|)
              (|Integer|) (6 . |setelt!|) (|List| 38) '"last" (|List| 14)
              (13 . |elt|) (19 . |concat|) (|List| 6)
              |DELTAC;deltaComplex;LNniL$;2| (|FiniteSimplicialComplex| 6)
              |DELTAC;deltaComplex;FscB$;4| |DELTAC;deltaComplex;Fsc$;3|
              (|List| 34) (25 . |addImpliedFaces|) (|String|) (|OutputForm|)
              (30 . |message|) (35 . |coerce|) (40 . |hconcat|) (46 . |coerce|)
              (|Void|) (51 . |print|) (|List| 39) (56 . |sort|) (61 . |coerce|)
              (66 . |coerce|) (|List| 12) (|OrientedFacet|)
              (71 . |getIndexesSigned|) (76 . |coerce|) (81 . |coerce|)
              (86 . |coerce|) (|List| $) (91 . |boundary|) (96 . |elt|)
              (102 . |position|) (108 . |Zero|) (112 . |coerce|) (|List| 53)
              (|FiniteCubicalComplex| 6) (117 . |addImpliedFaces|) (|List| 56)
              (122 . |sort|) (127 . |concat|) (|CubicalFacet|)
              (133 . |boundary|) (138 . |position|) (144 . |coerce|)
              (149 . |coerce|) (154 . |maxIndex|) |DELTAC;deltaComplex;Fcc$;5|
              |DELTAC;link;2Nni$;6| |DELTAC;triangle;3Nni$;7| (159 . |elt|)
              |DELTAC;faceMap;$NniL;8| (|Matrix| 12) (165 . |zero|)
              (171 . |setelt!|) (|List| 67) (|ChainComplex|)
              (179 . |chainComplex|) |DELTAC;chain;$Cc;9| (|CoChainComplex| 6)
              (184 . |coChainComplex|) |DELTAC;coChain;$Ccc;10|
              (189 . |validate|) (|List| (|Homology|)) (194 . |homology|)
              |DELTAC;homology;$L;11| (199 . |validate|) (204 . |coHomology|)
              |DELTAC;coHomology;$L;12| (209 . |second|) (214 . |elt|)
              (|Record| (|:| |name| 26) (|:| |arrType| 8) (|:| |fromOb| 8)
                        (|:| |toOb| 8) (|:| |xOffset| 12) (|:| |yOffset| 12)
                        (|:| |map| 109))
              (|List| 86) (220 . |concat|)
              (|Record| (|:| |value| 8) (|:| |posX| 8) (|:| |posY| 8))
              (|List| 89) (226 . |concat|) (|UndirectedGraph| 8)
              |DELTAC;oneSkeleton;$Ug;13| (|Tree| 12) (232 . |value|)
              (237 . |children|) (242 . |concat|) (|GroupPresentation|)
              |DELTAC;fundamentalGroup;$2BGp;17|
              |DELTAC;fundamentalGroup;$Gp;16| |DELTAC;coerce;$Of;20|
              (248 . |coerce|) (253 . |coerce|) (258 . |spanningTreeNode|)
              (264 . |coerce|) (269 . |coerce|) (274 . |elt|) (280 . |concat|)
              (|List| 8) (286 . |concat|) (292 . |groupPresentation|)
              (298 . |simplify|) (304 . ~=) (310 . |position|) (316 . ~=)
              |DELTAC;=;2$B;19| (322 . |empty|) (326 . |hconcat|)
              (331 . |coerce|) (336 . |vconcat|) (|Union| $ '"failed")
              (|DeltaComplex| 6) (342 . |simplicialComplexIfCan|)
              |DELTAC;coerce;$Fsc;21| (|SingleInteger|) (|HashState|))
           '#(~= 347 |triangle| 353 |oneSkeleton| 360 |link| 365 |latex| 371
              |homology| 376 |hashUpdate!| 381 |hash| 387 |fundamentalGroup|
              392 |faceMap| 404 |deltaComplex| 410 |coerce| 433 |coHomology|
              443 |coChain| 448 |chain| 453 = 458)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 27))
                        (|makeByteWordVec2| 126
                                            '(2 10 0 8 9 11 3 10 9 0 12 9 13 2
                                              16 14 0 15 17 2 16 0 0 14 18 1 21
                                              24 0 25 1 27 0 26 28 1 21 27 0 29
                                              2 27 0 0 0 30 1 24 27 0 31 1 27
                                              32 0 33 1 34 0 0 35 1 8 27 0 36 1
                                              34 27 0 37 1 39 38 0 40 1 39 27 0
                                              41 1 38 27 0 42 1 14 27 0 43 1 39
                                              44 0 45 2 24 34 0 12 46 2 39 12 0
                                              44 47 0 6 0 48 1 16 27 0 49 1 51
                                              50 0 52 1 53 0 0 54 2 50 0 0 53
                                              55 1 56 44 0 57 2 56 12 0 44 58 1
                                              56 27 0 59 1 53 27 0 60 1 51 8 0
                                              61 2 16 14 0 12 65 2 67 0 8 8 68
                                              4 67 12 0 12 12 12 69 1 71 0 70
                                              72 1 74 0 71 75 1 71 9 0 77 1 71
                                              78 0 79 1 74 9 0 81 1 74 78 0 82
                                              1 16 14 0 84 2 38 12 0 12 85 2 87
                                              0 0 86 88 2 90 0 0 89 91 1 94 12
                                              0 95 1 94 44 0 96 2 14 0 0 38 97
                                              1 26 27 0 102 1 92 27 0 103 2 92
                                              94 0 8 104 1 94 27 0 105 1 10 27
                                              0 106 2 10 9 0 12 107 2 38 0 0 12
                                              108 2 109 0 0 8 110 2 98 0 109 14
                                              111 2 98 0 0 9 112 2 8 9 0 0 113
                                              2 38 12 12 0 114 2 12 9 0 0 115 0
                                              27 0 117 1 27 0 44 118 1 12 27 0
                                              119 2 27 0 0 0 120 1 21 121 122
                                              123 2 0 9 0 0 1 3 0 0 8 8 8 64 1
                                              0 92 0 93 2 0 0 8 8 63 1 0 26 0 1
                                              1 0 78 0 80 2 0 126 126 0 1 1 0
                                              125 0 1 1 0 98 0 100 3 0 98 0 9 9
                                              99 2 0 14 0 8 66 1 0 0 51 62 2 0
                                              0 21 9 22 3 0 0 19 8 16 20 1 0 0
                                              21 23 1 0 21 0 124 1 0 27 0 101 1
                                              0 78 0 83 1 0 74 0 76 1 0 71 0 73
                                              2 0 9 0 0 116)))))
           '|lookupComplete|)) 

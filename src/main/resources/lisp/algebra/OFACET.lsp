
(SDEFUN |OFACET;orientedFacet;IL$;1|
        ((|mul1| (|Integer|)) (|fac1| (|List| (|NonNegativeInteger|))) ($ ($)))
        (SPROG
         ((|mul2| (|Integer|)) (|diff| (|NonNegativeInteger|)) (#1=#:G733 NIL)
          (|x| NIL) (#2=#:G734 NIL) (|y| NIL)
          (|fac2| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |mul2| |mul1|)
              (LETT |fac2| (SPADCALL |fac1| (QREFELT $ 8))) (LETT |diff| 0)
              (SEQ (LETT |y| NIL) (LETT #2# |fac2|) (LETT |x| NIL)
                   (LETT #1# |fac1|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL) (ATOM #2#)
                         (PROGN (LETT |y| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |x| |y| (QREFELT $ 11))
                       (LETT |diff| (+ |diff| 1))))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (COND
               ((EQL |diff| 1) (|error| "can not construct orientedFacet")))
              (COND
               ((EVENP |diff|) (COND ((> |diff| 1) (LETT |mul2| (- |mul2|))))))
              (EXIT (CONS |mul2| |fac2|))))) 

(SDEFUN |OFACET;orientedFacetUnsigned;L$;2|
        ((|fac1| (|List| (|Integer|))) ($ ($)))
        (SPROG
         ((|lst| (|List| (|NonNegativeInteger|))) (#1=#:G736 NIL)
          (#2=#:G741 NIL) (|x| NIL) (#3=#:G740 NIL))
         (SEQ
          (LETT |lst|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |x| NIL) (LETT #2# |fac1|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (PROG1 (LETT #1# (ABS |x|))
                                 (|check_subtype2| (>= #1# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #1#))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (LETT |lst| (SPADCALL |lst| (QREFELT $ 14)))
          (EXIT (CONS 1 (SPADCALL |lst| (QREFELT $ 8))))))) 

(SDEFUN |OFACET;orientedFacetSigned;L$;3|
        ((|fac1| (|List| (|Integer|))) ($ ($)))
        (SPROG
         ((|sig| (|Integer|)) (|lst| (|List| (|NonNegativeInteger|)))
          (#1=#:G743 NIL) (#2=#:G751 NIL) (|x| NIL) (#3=#:G750 NIL))
         (SEQ
          (LETT |lst|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |x| NIL) (LETT #2# |fac1|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (PROG1 (LETT #1# (ABS |x|))
                                 (|check_subtype2| (>= #1# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #1#))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (LETT |lst| (SPADCALL |lst| (QREFELT $ 14))) (LETT |sig| 1)
          (COND
           ((< (LENGTH |fac1|) 1)
            (|error| "attempt to construct empty facet")))
          (COND ((< (|SPADfirst| |fac1|) 0) (LETT |sig| -1)))
          (EXIT (CONS |sig| (SPADCALL |lst| (QREFELT $ 8))))))) 

(SDEFUN |OFACET;orientedFacet;I2$;4|
        ((|mul| (|Integer|)) (|fac1| (|OrientedFacet|)) ($ ($)))
        (CONS |mul| (SPADCALL |fac1| (QREFELT $ 19)))) 

(SDEFUN |OFACET;orientedFacetIfCan;LU;5|
        ((|boundary| (|List| $)) ($ (|Union| $ "failed")))
        (SPROG
         ((#1=#:G784 NIL) (|mm| (|Integer|)) (#2=#:G788 NIL) (|e| NIL)
          (#3=#:G787 NIL) (|expected| (|List| $)) (|res| ($))
          (|indexes| (|List| (|NonNegativeInteger|))) (#4=#:G786 NIL) (|i| NIL)
          (|indexLst| (|List| (|List| (|NonNegativeInteger|)))) (#5=#:G785 NIL)
          (|subFacet| NIL) (|b| (|List| $)))
         (SEQ
          (EXIT
           (SEQ (LETT |indexLst| NIL)
                (COND
                 ((< (SPADCALL |boundary| (QREFELT $ 22)) 1)
                  (PROGN (LETT #1# (CONS 1 "failed")) (GO #6=#:G783))))
                (LETT |b| (SPADCALL |boundary| (QREFELT $ 23)))
                (SEQ (LETT |subFacet| NIL) (LETT #5# |b|) G190
                     (COND
                      ((OR (ATOM #5#) (PROGN (LETT |subFacet| (CAR #5#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |indexLst|
                             (SPADCALL |indexLst|
                                       (SPADCALL |subFacet| (QREFELT $ 24))
                                       (QREFELT $ 26)))))
                     (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                (LETT |indexes| NIL)
                (SEQ (LETT |i| NIL) (LETT #4# |indexLst|) G190
                     (COND
                      ((OR (ATOM #4#) (PROGN (LETT |i| (CAR #4#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |indexes|
                             (SPADCALL |indexes| |i| (QREFELT $ 27)))))
                     (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                (LETT |indexes| (SPADCALL |indexes| (QREFELT $ 14)))
                (LETT |indexes| (SPADCALL |indexes| (QREFELT $ 8)))
                (LETT |res| (SPADCALL 1 |indexes| (QREFELT $ 13)))
                (LETT |expected| (SPADCALL |res| (QREFELT $ 29)))
                (LETT |mm|
                      (SPADCALL (SPADCALL |boundary| (QREFELT $ 30)) |expected|
                                (QREFELT $ 31)))
                (COND
                 ((< |mm| 0)
                  (SEQ (LETT |res| (SPADCALL -1 |indexes| (QREFELT $ 13)))
                       (EXIT
                        (LETT |expected| (SPADCALL |res| (QREFELT $ 29)))))))
                (SEQ (LETT |e| NIL) (LETT #3# |expected|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |e| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |mm| (SPADCALL |e| |boundary| (QREFELT $ 31)))
                          (EXIT
                           (COND
                            ((<= |mm| 0)
                             (PROGN (LETT #1# (CONS 1 "failed")) (GO #6#))))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (SEQ (LETT |e| NIL) (LETT #2# |boundary|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |e| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |mm| (SPADCALL |e| |expected| (QREFELT $ 31)))
                          (EXIT
                           (COND
                            ((<= |mm| 0)
                             (PROGN (LETT #1# (CONS 1 "failed")) (GO #6#))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |res|))))
          #6# (EXIT #1#)))) 

(SDEFUN |OFACET;order;$Nni;6| ((|f| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((|facet| (|List| (|NonNegativeInteger|))))
               (SEQ (LETT |facet| (SPADCALL |f| (QREFELT $ 24)))
                    (EXIT (SPADCALL |facet| (QREFELT $ 34)))))) 

(PUT '|OFACET;getIndexes;$L;7| '|SPADreplace| 'QCDR) 

(SDEFUN |OFACET;getIndexes;$L;7|
        ((|orf| ($)) ($ (|List| (|NonNegativeInteger|)))) (QCDR |orf|)) 

(SDEFUN |OFACET;minIndex;$Nni;8| ((|orf| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|m| (|NonNegativeInteger|)) (#1=#:G796 NIL) (|i| NIL)
          (|inds| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |m| 0) (LETT |inds| (SPADCALL |orf| (QREFELT $ 24)))
              (SEQ (LETT |i| NIL) (LETT #1# |inds|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND ((OR (EQL |m| 0) (< |i| |m|)) (LETT |m| |i|)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |m|)))) 

(SDEFUN |OFACET;maxIndex;$Nni;9| ((|orf| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|m| (|NonNegativeInteger|)) (#1=#:G801 NIL) (|i| NIL)
          (|inds| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |m| 0) (LETT |inds| (SPADCALL |orf| (QREFELT $ 24)))
              (SEQ (LETT |i| NIL) (LETT #1# |inds|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (COND ((> |i| |m|) (LETT |m| |i|)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |m|)))) 

(SDEFUN |OFACET;getIndexesSigned;$L;10| ((|orf| ($)) ($ (|List| (|Integer|))))
        (SPROG
         ((|neg| (|Boolean|)) (|res| (|List| (|Integer|))) (|i2| (|Integer|))
          (#1=#:G808 NIL) (|i| NIL))
         (SEQ (LETT |res| NIL)
              (LETT |neg| (EQL (SPADCALL (QCAR |orf|) (QREFELT $ 38)) -1))
              (SEQ (LETT |i| NIL) (LETT #1# (QCDR |orf|)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |i2| (COND (|neg| (- |i|)) ('T |i|)))
                        (LETT |res| (SPADCALL |res| |i2| (QREFELT $ 39)))
                        (EXIT (LETT |neg| (NULL |neg|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(PUT '|OFACET;getMult;$I;11| '|SPADreplace| 'QCAR) 

(SDEFUN |OFACET;getMult;$I;11| ((|orf| ($)) ($ (|Integer|))) (QCAR |orf|)) 

(SDEFUN |OFACET;setMult!;$I$;12| ((|orf| ($)) (|m| (|Integer|)) ($ ($)))
        (SEQ (PROGN (RPLACA |orf| |m|) (QCAR |orf|)) (EXIT |orf|))) 

(SDEFUN |OFACET;boundary;$L;13| ((|orf| ($)) ($ (|List| $)))
        (SPROG
         ((|res| (|List| $)) (|r1| ($)) (|even| (|Boolean|))
          (|m| #1=(|Integer|)) (|r| (|List| (|NonNegativeInteger|)))
          (#2=#:G817 NIL) (|x| NIL) (|mult| #1#)
          (|revFacet| (|List| (|NonNegativeInteger|)))
          (|facet| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |facet| (QCDR |orf|)) (LETT |revFacet| (REVERSE |facet|))
              (LETT |mult| (QCAR |orf|)) (LETT |res| NIL) (LETT |even| NIL)
              (SEQ (LETT |x| NIL) (LETT #2# |revFacet|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |r| (SPADCALL |x| |facet| (QREFELT $ 43)))
                        (LETT |m| (COND (|even| (- |mult|)) ('T |mult|)))
                        (LETT |even| (NULL |even|))
                        (LETT |r1| (SPADCALL |m| |r| (QREFELT $ 13)))
                        (EXIT
                         (LETT |res| (SPADCALL |res| |r1| (QREFELT $ 44)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |OFACET;addIfNew| ((|lst| (|List| $)) (|orf| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G822 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((NULL (SPADCALL |orf| (QREFELT $ 45)))
                    (COND
                     ((SPADCALL |orf| |lst| (QREFELT $ 46))
                      (PROGN (LETT #1# |lst|) (GO #2=#:G821))))))
                  (EXIT (SPADCALL |lst| |orf| (QREFELT $ 44)))))
                #2# (EXIT #1#)))) 

(SDEFUN |OFACET;addIfNew2|
        ((|lst| (|List| $)) (|orfs| (|List| $)) ($ (|List| $)))
        (SPROG ((|res| (|List| $)) (#1=#:G831 NIL) (|orf| NIL) (#2=#:G830 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |orfs| (QREFELT $ 47))
                    (PROGN (LETT #2# |lst|) (GO #3=#:G829))))
                  (LETT |res| (SPADCALL |lst| (QREFELT $ 48)))
                  (SEQ (LETT |orf| NIL) (LETT #1# |orfs|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |orf| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL (SPADCALL |orf| (QREFELT $ 45)))
                           (COND
                            ((NULL (SPADCALL |orf| |res| (QREFELT $ 46)))
                             (LETT |res|
                                   (SPADCALL |res| |orf| (QREFELT $ 44)))))))))
                       (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                  (EXIT |res|)))
                #3# (EXIT #2#)))) 

(SDEFUN |OFACET;allSubsets;$NniL;16|
        ((|orf| ($)) (|minDim| (|NonNegativeInteger|)) ($ (|List| $)))
        (SPROG
         ((|res| (|List| $)) (|sub| (|List| $)) (|r1| ($))
          (|r| (|List| (|NonNegativeInteger|))) (#1=#:G841 NIL) (|x| NIL)
          (#2=#:G840 NIL) (|facet| (|List| (|NonNegativeInteger|))))
         (SEQ
          (EXIT
           (SEQ (LETT |facet| (QCDR |orf|)) (LETT |res| NIL)
                (COND
                 ((<= (SPADCALL |orf| (QREFELT $ 35)) |minDim|)
                  (PROGN (LETT #2# |res|) (GO #3=#:G839))))
                (SEQ (LETT |x| NIL) (LETT #1# |facet|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |r| (SPADCALL |x| |facet| (QREFELT $ 43)))
                          (LETT |r1| (SPADCALL 1 |r| (QREFELT $ 13)))
                          (LETT |res| (|OFACET;addIfNew| |res| |r1| $))
                          (EXIT
                           (COND
                            ((> (SPADCALL |r1| (QREFELT $ 35)) |minDim|)
                             (SEQ
                              (LETT |sub|
                                    (SPADCALL |r1| |minDim| (QREFELT $ 49)))
                              (EXIT
                               (COND
                                ((NULL (SPADCALL |sub| (QREFELT $ 47)))
                                 (LETT |res|
                                       (|OFACET;addIfNew2| |res| |sub|
                                        $))))))))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #3# (EXIT #2#)))) 

(SDEFUN |OFACET;allSubsets;$2NniL;17|
        ((|orf| ($)) (|minDim| (|NonNegativeInteger|))
         (|maxDim| (|NonNegativeInteger|)) ($ (|List| $)))
        (SPROG
         ((|res2| (|List| $)) (#1=#:G848 NIL) (|y| NIL) (|res| (|List| $)))
         (SEQ (LETT |res| (SPADCALL |orf| |minDim| (QREFELT $ 49)))
              (LETT |res2| NIL)
              (SEQ (LETT |y| NIL) (LETT #1# |res|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |y| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((<= (SPADCALL |y| (QREFELT $ 35)) |maxDim|)
                       (LETT |res2| (SPADCALL |res2| |y| (QREFELT $ 44)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res2|)))) 

(SDEFUN |OFACET;isSubsetOf?;2$B;18| ((|sa| ($)) (|sb| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G853 NIL) (#2=#:G854 NIL) (|vertex| NIL) (|all| (|List| $)))
         (SEQ
          (EXIT
           (SEQ (LETT |all| (SPADCALL |sb| 1 (QREFELT $ 49)))
                (SEQ (LETT |vertex| NIL) (LETT #2# |all|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |vertex| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |vertex| |sa| (QREFELT $ 51))
                         (PROGN (LETT #1# 'T) (GO #3=#:G852))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT NIL)))
          #3# (EXIT #1#)))) 

(SDEFUN |OFACET;join;3$;19| ((|sa| ($)) (|sb| ($)) ($ ($)))
        (SPROG
         ((|mult| (|Integer|)) (|lst2| (|List| (|NonNegativeInteger|)))
          (|lst| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |lst| (SPADCALL (QCDR |sa|) (QCDR |sb|) (QREFELT $ 27)))
              (LETT |lst2|
                    (SPADCALL (SPADCALL |lst| (QREFELT $ 14)) (QREFELT $ 8)))
              (LETT |mult| (* (QCAR |sa|) (QCAR |sb|)))
              (EXIT (CONS |mult| |lst2|))))) 

(SDEFUN |OFACET;subtract;3$;20| ((|sa| ($)) (|sb| ($)) ($ ($)))
        (SPROG ((|lst| (|List| (|NonNegativeInteger|))))
               (SEQ
                (LETT |lst| (SPADCALL (QCDR |sb|) (QCDR |sa|) (QREFELT $ 54)))
                (EXIT (CONS 1 |lst|))))) 

(SDEFUN |OFACET;reindex;2$;21| ((|sa| ($)) ($ ($)))
        (SPROG
         ((|res| (|List| (|NonNegativeInteger|))) (|ptr| (|Integer|))
          (#1=#:G869 NIL) (|v| NIL) (|i| (|NonNegativeInteger|))
          (|newval| (|List| (|NonNegativeInteger|)))
          (|oldval| (|List| (|NonNegativeInteger|))) (#2=#:G868 NIL)
          (|facet| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |facet| (QCDR |sa|)) (LETT |oldval| NIL)
              (LETT |newval| NIL) (LETT |i| 1)
              (SEQ (LETT |v| NIL) (LETT #2# |facet|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |oldval| (SPADCALL |oldval| |v| (QREFELT $ 56)))
                        (LETT |newval| (SPADCALL |newval| |i| (QREFELT $ 56)))
                        (EXIT (LETT |i| (+ |i| 1))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |res| NIL)
              (SEQ (LETT |v| NIL) (LETT #1# |facet|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ptr| (SPADCALL |v| |oldval| (QREFELT $ 57)))
                        (COND ((< |ptr| 1) (|error| "error in reindex")))
                        (EXIT
                         (LETT |res|
                               (SPADCALL |res|
                                         (SPADCALL |newval| |ptr|
                                                   (QREFELT $ 58))
                                         (QREFELT $ 56)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS 1 |res|))))) 

(SDEFUN |OFACET;boolWordPermute;2NniL;22|
        ((|numZeros| (|NonNegativeInteger|)) (|numOnes| (|NonNegativeInteger|))
         ($ (|List| (|List| (|Boolean|)))))
        (SPADCALL NIL |numZeros| |numOnes| (QREFELT $ 61))) 

(SDEFUN |OFACET;boolWordPermute;L2NniL;23|
        ((|wordIn| (|List| (|List| (|Boolean|))))
         (|numZeros| (|NonNegativeInteger|)) (|numOnes| (|NonNegativeInteger|))
         ($ (|List| (|List| (|Boolean|)))))
        (SPROG
         ((|res| (|List| (|List| (|Boolean|))))
          (|word1| (|List| (|List| (|Boolean|))))
          (|subWord| (|List| (|Boolean|))) (#1=#:G888 NIL) (|x| NIL)
          (|z| (|NonNegativeInteger|)) (#2=#:G872 NIL)
          (|word0| (|List| (|List| (|Boolean|)))) (#3=#:G887 NIL)
          (#4=#:G886 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((< |numZeros| 1)
              (COND
               ((< |numOnes| 1) (PROGN (LETT #4# |wordIn|) (GO #5=#:G885))))))
            (LETT |res| NIL)
            (COND
             ((> |numZeros| 0)
              (SEQ
               (LETT |z|
                     (PROG2 (LETT #2# (SPADCALL |numZeros| 1 (QREFELT $ 63)))
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 0) (|NonNegativeInteger|)
                                       (|Union| (|NonNegativeInteger|)
                                                #6="failed")
                                       #2#)))
               (LETT |word0| NIL)
               (COND ((NULL |wordIn|) (LETT |word0| (LIST (LIST NIL)))))
               (SEQ (LETT |x| NIL) (LETT #3# |wordIn|) G190
                    (COND
                     ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                      (GO G191)))
                    (SEQ (LETT |subWord| (SPADCALL |x| NIL (QREFELT $ 65)))
                         (EXIT
                          (LETT |word0|
                                (SPADCALL |word0| |subWord| (QREFELT $ 66)))))
                    (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
               (EXIT
                (LETT |res|
                      (SPADCALL |res|
                                (SPADCALL |word0| |z| |numOnes| (QREFELT $ 61))
                                (QREFELT $ 67)))))))
            (COND
             ((> |numOnes| 0)
              (SEQ
               (LETT |z|
                     (PROG2 (LETT #2# (SPADCALL |numOnes| 1 (QREFELT $ 63)))
                         (QCDR #2#)
                       (|check_union2| (QEQCAR #2# 0) (|NonNegativeInteger|)
                                       (|Union| (|NonNegativeInteger|) #6#)
                                       #2#)))
               (LETT |word1| NIL)
               (COND ((NULL |wordIn|) (LETT |word1| (LIST (LIST 'T)))))
               (SEQ (LETT |x| NIL) (LETT #1# |wordIn|) G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ (LETT |subWord| (SPADCALL |x| 'T (QREFELT $ 65)))
                         (EXIT
                          (LETT |word1|
                                (SPADCALL |word1| |subWord| (QREFELT $ 66)))))
                    (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
               (EXIT
                (LETT |res|
                      (SPADCALL |res|
                                (SPADCALL |word1| |numZeros| |z|
                                          (QREFELT $ 61))
                                (QREFELT $ 67)))))))
            (EXIT |res|)))
          #5# (EXIT #4#)))) 

(SDEFUN |OFACET;product;2$L;24|
        ((|a| ($)) (|b| ($)) ($ (|List| (|ProductFacet|))))
        (SPROG
         ((|res| (|List| (|ProductFacet|))) (|pf| (|ProductFacet|))
          (|i2|
           (|List|
            #1=(|Record| (|:| |left| (|NonNegativeInteger|))
                         (|:| |right| (|NonNegativeInteger|)))))
          (|i| #1#) (|leftIndex| #2=(|NonNegativeInteger|)) (|rightIndex| #2#)
          (#3=#:G905 NIL) (#4=#:G904 NIL) (|perm| NIL)
          (|perms| (|List| (|List| (|Boolean|))))
          (|lenB| (|NonNegativeInteger|)) (#5=#:G890 NIL)
          (|lenA| (|NonNegativeInteger|))
          (|indB| #6=(|List| (|NonNegativeInteger|))) (|indA| #6#))
         (SEQ (LETT |res| NIL) (LETT |indA| (SPADCALL |a| (QREFELT $ 24)))
              (LETT |indB| (SPADCALL |b| (QREFELT $ 24)))
              (LETT |lenA|
                    (PROG2
                        (LETT #5#
                              (SPADCALL (SPADCALL |indA| (QREFELT $ 34)) 1
                                        (QREFELT $ 63)))
                        (QCDR #5#)
                      (|check_union2| (QEQCAR #5# 0) (|NonNegativeInteger|)
                                      (|Union| (|NonNegativeInteger|)
                                               #7="failed")
                                      #5#)))
              (LETT |lenB|
                    (PROG2
                        (LETT #5#
                              (SPADCALL (SPADCALL |indB| (QREFELT $ 34)) 1
                                        (QREFELT $ 63)))
                        (QCDR #5#)
                      (|check_union2| (QEQCAR #5# 0) (|NonNegativeInteger|)
                                      (|Union| (|NonNegativeInteger|) #7#)
                                      #5#)))
              (LETT |perms| (REVERSE (SPADCALL |lenA| |lenB| (QREFELT $ 62))))
              (SEQ (LETT |perm| NIL) (LETT #4# |perms|) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |perm| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |leftIndex| 1) (LETT |rightIndex| 1)
                        (LETT |i|
                              (CONS
                               (SPADCALL |indA| |leftIndex| (QREFELT $ 68))
                               (SPADCALL |indB| |rightIndex| (QREFELT $ 68))))
                        (LETT |i2| (LIST |i|))
                        (SEQ (LETT #3# |perm|) G190
                             (COND
                              ((OR (ATOM #3#) (PROGN (LETT |b| (CAR #3#)) NIL))
                               (GO G191)))
                             (SEQ
                              (COND
                               (|b| (LETT |rightIndex| (+ |rightIndex| 1)))
                               ('T (LETT |leftIndex| (+ |leftIndex| 1))))
                              (COND
                               ((> |leftIndex|
                                   (SPADCALL |indA| (QREFELT $ 34)))
                                (|error| "leftIndex too high in product")))
                              (COND
                               ((> |rightIndex|
                                   (SPADCALL |indB| (QREFELT $ 34)))
                                (|error| "rightIndex too high in product")))
                              (LETT |i|
                                    (CONS
                                     (SPADCALL |indA| |leftIndex|
                                               (QREFELT $ 68))
                                     (SPADCALL |indB| |rightIndex|
                                               (QREFELT $ 68))))
                              (EXIT
                               (LETT |i2| (SPADCALL |i2| |i| (QREFELT $ 71)))))
                             (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                        (LETT |pf| (SPADCALL 1 |i2| (QREFELT $ 73)))
                        (EXIT
                         (LETT |res| (SPADCALL |res| |pf| (QREFELT $ 75)))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |OFACET;position;$LI;25| ((|e| ($)) (|lst| (|List| $)) ($ (|Integer|)))
        (SPROG ((#1=#:G915 NIL) (|res| (|Integer|)) (#2=#:G916 NIL) (|x| NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |res| 1)
                      (SEQ (LETT |x| NIL) (LETT #2# |lst|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (COND
                             ((SPADCALL (QCDR |e|) (QCDR |x|) (QREFELT $ 77))
                              (SEQ
                               (COND
                                ((EQL (QCAR |e|) (QCAR |x|))
                                 (PROGN (LETT #1# |res|) (GO #3=#:G914))))
                               (EXIT (PROGN (LETT #1# (- |res|)) (GO #3#))))))
                            (EXIT (LETT |res| (+ |res| 1))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (PROGN (LETT #1# 0) (GO #3#)))))
                #3# (EXIT #1#)))) 

(SDEFUN |OFACET;addVertex;$Nni$;26|
        ((|sa| ($)) (|v| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|f| (|List| (|NonNegativeInteger|))))
               (SEQ (LETT |f| (QCDR |sa|))
                    (LETT |f| (SPADCALL |f| |v| (QREFELT $ 56)))
                    (EXIT (SPADCALL 1 |f| (QREFELT $ 13)))))) 

(SDEFUN |OFACET;refactorIndexes;$Nni$;27|
        ((|a| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|newval| (|List| (|NonNegativeInteger|))) (#1=#:G923 NIL) (|v| NIL)
          (|facet| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |facet| (QCDR |a|)) (LETT |newval| NIL)
              (SEQ (LETT |v| NIL) (LETT #1# |facet|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |newval|
                           (SPADCALL |newval| (+ |v| |n|) (QREFELT $ 56)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS (QCAR |a|) |newval|))))) 

(SDEFUN |OFACET;sameFace?;2$B;28| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG ((|vertsb| #1=(|List| (|NonNegativeInteger|))) (|vertsa| #1#))
               (SEQ (LETT |vertsa| (QCDR |a|)) (LETT |vertsb| (QCDR |b|))
                    (EXIT (NULL (SPADCALL |vertsa| |vertsb| (QREFELT $ 80))))))) 

(SDEFUN |OFACET;ltLocal|
        ((|a| (|List| (|NonNegativeInteger|)))
         (|b| (|List| (|NonNegativeInteger|))) ($ (|Boolean|)))
        (SPROG ((#1=#:G933 NIL) (|b1| #2=(|NonNegativeInteger|)) (|a1| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |a| |b| (QREFELT $ 77))
                    (PROGN (LETT #1# NIL) (GO #3=#:G932))))
                  (COND
                   ((< (SPADCALL |a| (QREFELT $ 34)) 1)
                    (PROGN (LETT #1# 'T) (GO #3#))))
                  (COND
                   ((< (SPADCALL |b| (QREFELT $ 34)) 1)
                    (PROGN (LETT #1# NIL) (GO #3#))))
                  (LETT |a1| (|SPADfirst| |a|)) (LETT |b1| (|SPADfirst| |b|))
                  (COND ((< |a1| |b1|) (PROGN (LETT #1# 'T) (GO #3#))))
                  (COND ((> |a1| |b1|) (PROGN (LETT #1# NIL) (GO #3#))))
                  (COND
                   ((< (SPADCALL |a| (QREFELT $ 34)) 2)
                    (PROGN (LETT #1# 'T) (GO #3#))))
                  (COND
                   ((< (SPADCALL |b| (QREFELT $ 34)) 2)
                    (PROGN (LETT #1# NIL) (GO #3#))))
                  (EXIT (|OFACET;ltLocal| (CDR |a|) (CDR |b|) $))))
                #3# (EXIT #1#)))) 

(SDEFUN |OFACET;<;2$B;30| ((|ain| ($)) (|bin| ($)) ($ (|Boolean|)))
        (SPROG ((|b| #1=(|List| (|NonNegativeInteger|))) (|a| #1#))
               (SEQ (LETT |a| (QCDR |ain|)) (LETT |b| (QCDR |bin|))
                    (EXIT (|OFACET;ltLocal| |a| |b| $))))) 

(SDEFUN |OFACET;<=;2$B;31| ((|ain| ($)) (|bin| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G938 NIL) (|b| #2=(|List| (|NonNegativeInteger|))) (|a| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |a| (QCDR |ain|)) (LETT |b| (QCDR |bin|))
                (COND
                 ((SPADCALL |a| |b| (QREFELT $ 77))
                  (PROGN (LETT #1# 'T) (GO #3=#:G937))))
                (EXIT (|OFACET;ltLocal| |a| |b| $))))
          #3# (EXIT #1#)))) 

(SDEFUN |OFACET;=;2$B;32| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G943 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL (QCAR |a|) (QCAR |b|) (QREFELT $ 84))
                    (PROGN (LETT #1# NIL) (GO #2=#:G942))))
                  (EXIT (SPADCALL (QCDR |a|) (QCDR |b|) (QREFELT $ 77)))))
                #2# (EXIT #1#)))) 

(SDEFUN |OFACET;coerce;$Of;33| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|body| (|OutputForm|)) (|elements| (|List| (|OutputForm|)))
          (#1=#:G952 NIL) (|x| NIL) (#2=#:G951 NIL) (|prefix| (|OutputForm|))
          (|m| (|Integer|)))
         (SEQ (LETT |prefix| (SPADCALL "" (QREFELT $ 87)))
              (LETT |m| (QCAR |s|))
              (COND
               ((SPADCALL (ABS |m|) 1 (QREFELT $ 84))
                (LETT |prefix|
                      (SPADCALL (SPADCALL |m| (QREFELT $ 88))
                                (SPADCALL "*" (QREFELT $ 87))
                                (QREFELT $ 89)))))
              (COND
               ((EQL |m| -1) (LETT |prefix| (SPADCALL "-" (QREFELT $ 87)))))
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
                                  (CONS (SPADCALL |x| (QREFELT $ 90)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (LETT |body| (SPADCALL |elements| (QREFELT $ 91)))
              (EXIT (SPADCALL |prefix| |body| (QREFELT $ 89)))))) 

(DECLAIM (NOTINLINE |OrientedFacet;|)) 

(DEFUN |OrientedFacet| ()
  (SPROG NIL
         (PROG (#1=#:G956)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OrientedFacet|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OrientedFacet|
                             (LIST (CONS NIL (CONS 1 (|OrientedFacet;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|OrientedFacet|)))))))))) 

(DEFUN |OrientedFacet;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OrientedFacet|))
          (LETT $ (GETREFV 95))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OrientedFacet| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |mul| (|Integer|))
                              (|:| |fac| (|List| (|NonNegativeInteger|)))))
          $))) 

(MAKEPROP '|OrientedFacet| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|List| 10) (0 . |sort|)
              (|Boolean|) (|NonNegativeInteger|) (5 . ~=) (|Integer|)
              |OFACET;orientedFacet;IL$;1| (11 . |removeDuplicates|)
              (|List| 12) |OFACET;orientedFacetUnsigned;L$;2|
              |OFACET;orientedFacetSigned;L$;3| (|OrientedFacet|)
              (16 . |getIndexes|) |OFACET;orientedFacet;I2$;4| (|List| $$)
              (21 . |#|) (26 . |sort|) |OFACET;getIndexes;$L;7| (|List| 7)
              (31 . |concat|) (37 . |concat|) (|List| $)
              |OFACET;boundary;$L;13| (43 . |first|) |OFACET;position;$LI;25|
              (|Union| $ '"failed") |OFACET;orientedFacetIfCan;LU;5| (48 . |#|)
              |OFACET;order;$Nni;6| |OFACET;minIndex;$Nni;8|
              |OFACET;maxIndex;$Nni;9| (53 . |sign|) (58 . |concat|)
              |OFACET;getIndexesSigned;$L;10| |OFACET;getMult;$I;11|
              |OFACET;setMult!;$I$;12| (64 . |remove|) (70 . |concat|)
              (76 . |empty?|) (81 . |member?|) (87 . |empty?|) (92 . |copy|)
              |OFACET;allSubsets;$NniL;16| |OFACET;allSubsets;$2NniL;17|
              |OFACET;=;2$B;32| |OFACET;isSubsetOf?;2$B;18| |OFACET;join;3$;19|
              (97 . |setDifference|) |OFACET;subtract;3$;20| (103 . |concat|)
              (109 . |position|) (115 . |qelt|) |OFACET;reindex;2$;21|
              (|List| 64) |OFACET;boolWordPermute;L2NniL;23|
              |OFACET;boolWordPermute;2NniL;22| (121 . |subtractIfCan|)
              (|List| 9) (127 . |concat|) (133 . |concat|) (139 . |concat|)
              (145 . |elt|) (|Record| (|:| |left| 10) (|:| |right| 10))
              (|List| 69) (151 . |concat|) (|ProductFacet|)
              (157 . |productFacet|) (|List| 72) (163 . |concat|)
              |OFACET;product;2$L;24| (169 . =) |OFACET;addVertex;$Nni$;26|
              |OFACET;refactorIndexes;$Nni$;27| (175 . ~=)
              |OFACET;sameFace?;2$B;28| |OFACET;<;2$B;30| |OFACET;<=;2$B;31|
              (181 . ~=) (|String|) (|OutputForm|) (187 . |message|)
              (192 . |coerce|) (197 . |hconcat|) (203 . |coerce|)
              (208 . |paren|) |OFACET;coerce;$Of;33| (|SingleInteger|)
              (|HashState|))
           '#(~= 213 |subtract| 219 |smaller?| 225 |setMult!| 231 |sameFace?|
              237 |reindex| 243 |refactorIndexes| 248 |product| 254 |position|
              260 |orientedFacetUnsigned| 266 |orientedFacetSigned| 271
              |orientedFacetIfCan| 276 |orientedFacet| 281 |order| 293
              |minIndex| 298 |min| 303 |maxIndex| 309 |max| 314 |latex| 320
              |join| 325 |isSubsetOf?| 331 |hashUpdate!| 337 |hash| 343
              |getMult| 348 |getIndexesSigned| 353 |getIndexes| 358 |empty?|
              363 |coerce| 368 |boundary| 373 |boolWordPermute| 378
              |allSubsets| 391 |addVertex| 404 >= 410 > 416 = 422 <= 428 < 434)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0))
                 (CONS
                  '#(|FacetCategory&| |OrderedSet&| NIL |SetCategory&|
                     |PartialOrder&| |BasicType&| NIL)
                  (CONS
                   '#((|FacetCategory|) (|OrderedSet|) (|Comparable|)
                      (|SetCategory|) (|PartialOrder|) (|BasicType|)
                      (|CoercibleTo| 86))
                   (|makeByteWordVec2| 94
                                       '(1 7 0 0 8 2 10 9 0 0 11 1 7 0 0 14 1
                                         18 7 0 19 1 21 10 0 22 1 21 0 0 23 2
                                         25 0 0 7 26 2 7 0 0 0 27 1 21 2 0 30 1
                                         7 10 0 34 1 12 12 0 38 2 15 0 0 12 39
                                         2 7 0 10 0 43 2 21 0 0 2 44 1 0 9 0 45
                                         2 21 9 2 0 46 1 21 9 0 47 1 21 0 0 48
                                         2 7 0 0 0 54 2 7 0 0 10 56 2 7 12 10 0
                                         57 2 7 10 0 12 58 2 10 32 0 0 63 2 64
                                         0 0 9 65 2 60 0 0 64 66 2 60 0 0 0 67
                                         2 7 10 0 12 68 2 70 0 0 69 71 2 72 0
                                         12 70 73 2 74 0 0 72 75 2 7 9 0 0 77 2
                                         7 9 0 0 80 2 12 9 0 0 84 1 86 0 85 87
                                         1 12 86 0 88 2 86 0 0 0 89 1 10 86 0
                                         90 1 86 0 28 91 2 0 9 0 0 1 2 0 0 0 0
                                         55 2 0 9 0 0 1 2 0 0 0 12 42 2 0 9 0 0
                                         81 1 0 0 0 59 2 0 0 0 10 79 2 0 74 0 0
                                         76 2 0 12 0 28 31 1 0 0 15 16 1 0 0 15
                                         17 1 0 32 28 33 2 0 0 12 18 20 2 0 0
                                         12 7 13 1 0 10 0 35 1 0 10 0 36 2 0 0
                                         0 0 1 1 0 10 0 37 2 0 0 0 0 1 1 0 85 0
                                         1 2 0 0 0 0 53 2 0 9 0 0 52 2 0 94 94
                                         0 1 1 0 93 0 1 1 0 12 0 41 1 0 15 0 40
                                         1 0 7 0 24 1 0 9 0 45 1 0 86 0 92 1 0
                                         28 0 29 2 0 60 10 10 62 3 0 60 60 10
                                         10 61 3 0 28 0 10 10 50 2 0 28 0 10 49
                                         2 0 0 0 10 78 2 0 9 0 0 1 2 0 9 0 0 1
                                         2 0 9 0 0 51 2 0 9 0 0 83 2 0 9 0 0
                                         82)))))
           '|lookupComplete|)) 

(MAKEPROP '|OrientedFacet| 'NILADIC T) 

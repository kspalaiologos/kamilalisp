
(SDEFUN |FGRPH-;getVertexIndex;ASNni;1|
        ((|s| (A)) (|o| (S)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G770 NIL) (|i| NIL) (#2=#:G771 NIL) (|v| NIL)
          (|lv|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |lv| (SPADCALL |s| (QREFELT $ 10)))
                (SEQ (LETT |v| NIL) (LETT #2# |lv|) (LETT |i| 1) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL (QVELT |v| 0) |o| (QREFELT $ 12))
                         (PROGN (LETT #1# |i|) (GO #3=#:G769))))))
                     (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT 0)))
          #3# (EXIT #1#)))) 

(SDEFUN |FGRPH-;addArrow!;AS2SA;2|
        ((|s| (A)) (|aname| (|String|)) (|o1| (S)) (|o2| (S)) ($ (A)))
        (SPADCALL |s| |aname| (SPADCALL |s| |o1| (QREFELT $ 15))
                  (SPADCALL |s| |o2| (QREFELT $ 15)) (QREFELT $ 17))) 

(PUT '|FGRPH-;isDirected?;B;3| '|SPADreplace| '(XLAM NIL 'T)) 

(SDEFUN |FGRPH-;isDirected?;B;3| (($ (|Boolean|))) 'T) 

(SDEFUN |FGRPH-;incidenceMatrix;AM;4| ((|s| (A)) ($ (|Matrix| (|Integer|))))
        (SPROG
         ((#1=#:G782 NIL) (|ar| NIL) (|j| NIL) (|ss| (|Integer|))
          (|res| (|Matrix| (|Integer|)))
          (|al|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|vl|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ (LETT |vl| (SPADCALL |s| (QREFELT $ 10)))
              (LETT |al| (SPADCALL |s| (QREFELT $ 22)))
              (LETT |res|
                    (SPADCALL (LENGTH |vl|) (LENGTH |al|) (QREFELT $ 24)))
              (LETT |ss| (COND ((SPADCALL (QREFELT $ 25)) -1) ('T 1)))
              (SEQ (LETT |j| 1) (LETT |ar| NIL) (LETT #1# |al|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |ar| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (SPADCALL |res| (QVELT |ar| 2) |j| |ss| (QREFELT $ 27))
                        (EXIT
                         (SPADCALL |res| (QVELT |ar| 3) |j| 1 (QREFELT $ 27))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |j| (|inc_SI| |j|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FGRPH-;adjacencyMatrix;AM;5|
        ((|s| (A)) ($ (|Matrix| (|NonNegativeInteger|))))
        (SPROG
         ((|m| (|List| (|List| (|NonNegativeInteger|)))) (#1=#:G794 NIL)
          (|u| NIL) (#2=#:G793 NIL) (#3=#:G792 NIL) (|v| NIL) (#4=#:G791 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH (SPADCALL |s| (QREFELT $ 10))))
              (LETT |m|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |v| 1) (LETT #3# |n|) G190
                          (COND ((|greater_SI| |v| #3#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (PROGN
                                    (LETT #2# NIL)
                                    (SEQ (LETT |u| 1) (LETT #1# |n|) G190
                                         (COND
                                          ((|greater_SI| |u| #1#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #2#
                                                 (CONS
                                                  (COND
                                                   ((SPADCALL |s| |u| |v|
                                                              (QREFELT $ 29))
                                                    1)
                                                   ('T 0))
                                                  #2#))))
                                         (LETT |u| (|inc_SI| |u|)) (GO G190)
                                         G191 (EXIT (NREVERSE #2#))))
                                   #4#))))
                          (LETT |v| (|inc_SI| |v|)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (EXIT (SPADCALL |m| (QREFELT $ 32)))))) 

(SDEFUN |FGRPH-;laplacianEntry|
        ((|s| (A)) (|i| (|NonNegativeInteger|)) (|j| (|NonNegativeInteger|))
         ($ (|Integer|)))
        (SPROG ((#1=#:G798 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((EQL |i| |j|)
                    (PROGN
                     (LETT #1# (SPADCALL |s| |i| (QREFELT $ 34)))
                     (GO #2=#:G797))))
                  (COND
                   ((SPADCALL |s| |i| |j| (QREFELT $ 29))
                    (PROGN (LETT #1# -1) (GO #2#))))
                  (EXIT 0)))
                #2# (EXIT #1#)))) 

(SDEFUN |FGRPH-;laplacianMatrix;AM;7| ((|s| (A)) ($ (|Matrix| (|Integer|))))
        (SPROG
         ((|m| (|List| (|List| (|Integer|)))) (#1=#:G810 NIL) (|u| NIL)
          (#2=#:G809 NIL) (#3=#:G808 NIL) (|v| NIL) (#4=#:G807 NIL))
         (SEQ
          (LETT |m|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |v| 1)
                      (LETT #3# (LENGTH (SPADCALL |s| (QREFELT $ 10)))) G190
                      (COND ((|greater_SI| |v| #3#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |u| 1)
                                     (LETT #1#
                                           (LENGTH
                                            (SPADCALL |s| (QREFELT $ 10))))
                                     G190
                                     (COND ((|greater_SI| |u| #1#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #2#
                                             (CONS
                                              (|FGRPH-;laplacianEntry| |s| |u|
                                               |v| $)
                                              #2#))))
                                     (LETT |u| (|inc_SI| |u|)) (GO G190) G191
                                     (EXIT (NREVERSE #2#))))
                               #4#))))
                      (LETT |v| (|inc_SI| |v|)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (EXIT (SPADCALL |m| (QREFELT $ 36)))))) 

(SDEFUN |FGRPH-;distanceMatrix;AM;8| ((|s| (A)) ($ (|Matrix| (|Integer|))))
        (SPROG
         ((|m| (|List| (|List| (|Integer|)))) (#1=#:G822 NIL) (|u| NIL)
          (#2=#:G821 NIL) (#3=#:G820 NIL) (|v| NIL) (#4=#:G819 NIL))
         (SEQ
          (LETT |m|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |v| 1)
                      (LETT #3# (LENGTH (SPADCALL |s| (QREFELT $ 10)))) G190
                      (COND ((|greater_SI| |v| #3#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |u| 1)
                                     (LETT #1#
                                           (LENGTH
                                            (SPADCALL |s| (QREFELT $ 10))))
                                     G190
                                     (COND ((|greater_SI| |u| #1#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #2#
                                             (CONS
                                              (SPADCALL |s| |u| |v|
                                                        (QREFELT $ 38))
                                              #2#))))
                                     (LETT |u| (|inc_SI| |u|)) (GO G190) G191
                                     (EXIT (NREVERSE #2#))))
                               #4#))))
                      (LETT |v| (|inc_SI| |v|)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (EXIT (SPADCALL |m| (QREFELT $ 36)))))) 

(SDEFUN |FGRPH-;spanningTreeArrowRecursive|
        ((|s| (A)) (|i| (|NonNegativeInteger|))
         (|visited| (|Reference| (|List| (|NonNegativeInteger|))))
         ($ (|Tree| (|Integer|))))
        (SPROG
         ((|ch| (|List| (|Tree| (|Integer|))))
          (|visited1| (|List| (|NonNegativeInteger|))) (#1=#:G838 NIL)
          (|x| NIL) (|aa| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |aa| (SPADCALL |s| |i| (QREFELT $ 41))) (LETT |ch| NIL)
              (LETT |visited1| (SPADCALL |visited| (QREFELT $ 43)))
              (SEQ (LETT |x| NIL) (LETT #1# |aa|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |x| |visited1| (QREFELT $ 44))
                       (LETT |ch|
                             (SPADCALL |ch| (SPADCALL (- |x|) (QREFELT $ 46))
                                       (QREFELT $ 48))))
                      ('T
                       (SEQ
                        (LETT |visited1|
                              (SPADCALL |visited1| |x| (QREFELT $ 49)))
                        (SPADCALL |visited| |visited1| (QREFELT $ 50))
                        (EXIT
                         (LETT |ch|
                               (SPADCALL |ch|
                                         (|FGRPH-;spanningTreeArrowRecursive|
                                          |s| |x| |visited| $)
                                         (QREFELT $ 48)))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |i| |ch| (QREFELT $ 52)))))) 

(SDEFUN |FGRPH-;spanningTreeArrow;ANniT;10|
        ((|s| (A)) (|i| (|NonNegativeInteger|)) ($ (|Tree| (|Integer|))))
        (|FGRPH-;spanningTreeArrowRecursive| |s| |i|
         (SPADCALL (LIST |i|) (QREFELT $ 53)) $)) 

(SDEFUN |FGRPH-;spanningForestArrow;AL;11|
        ((|s| (A)) ($ (|List| (|Tree| (|Integer|)))))
        (SPROG ((#1=#:G845 NIL) (|i| NIL) (#2=#:G844 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 1)
                      (LETT #1# (LENGTH (SPADCALL |s| (QREFELT $ 22)))) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |s| |i| (QREFELT $ 55)) #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FGRPH-;spanningTreeNodeRecursive|
        ((|s| (A)) (|i| (|NonNegativeInteger|))
         (|visited| (|Reference| (|List| (|NonNegativeInteger|))))
         ($ (|Tree| (|Integer|))))
        (SPROG
         ((|ch| (|List| (|Tree| (|Integer|)))) (#1=#:G855 NIL) (|n| NIL)
          (#2=#:G856 NIL) (|flag| NIL)
          (|visited1| (|List| (|NonNegativeInteger|)))
          (|flags| (|List| (|Boolean|))) (#3=#:G854 NIL)
          (|oa| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |oa| (SPADCALL |s| |i| (QREFELT $ 57))) (LETT |ch| NIL)
              (LETT |flags| NIL)
              (LETT |visited1| (SPADCALL |visited| (QREFELT $ 43)))
              (SEQ (LETT |n| NIL) (LETT #3# |oa|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |n| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |n| |visited1| (QREFELT $ 44))
                       (LETT |flags| (SPADCALL |flags| NIL (QREFELT $ 59))))
                      ('T
                       (SEQ (LETT |flags| (SPADCALL |flags| 'T (QREFELT $ 59)))
                            (EXIT
                             (LETT |visited1|
                                   (SPADCALL |visited1| |n|
                                             (QREFELT $ 49)))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (SPADCALL |visited| |visited1| (QREFELT $ 50))
              (SEQ (LETT |flag| NIL) (LETT #2# |flags|) (LETT |n| NIL)
                   (LETT #1# |oa|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |n| (CAR #1#)) NIL) (ATOM #2#)
                         (PROGN (LETT |flag| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      (|flag|
                       (LETT |ch|
                             (SPADCALL |ch|
                                       (|FGRPH-;spanningTreeNodeRecursive| |s|
                                        |n| |visited| $)
                                       (QREFELT $ 48)))))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT (SPADCALL |i| |ch| (QREFELT $ 52)))))) 

(SDEFUN |FGRPH-;spanningTreeNode;ANniT;13|
        ((|s| (A)) (|i| (|NonNegativeInteger|)) ($ (|Tree| (|Integer|))))
        (|FGRPH-;spanningTreeNodeRecursive| |s| |i|
         (SPADCALL (LIST |i|) (QREFELT $ 53)) $)) 

(SDEFUN |FGRPH-;spanningForestNode;AL;14|
        ((|s| (A)) ($ (|List| (|Tree| (|Integer|)))))
        (SPROG ((#1=#:G863 NIL) (|i| NIL) (#2=#:G862 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 1)
                      (LETT #1# (LENGTH (SPADCALL |s| (QREFELT $ 10)))) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |s| |i| (QREFELT $ 61)) #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FGRPH-;loopsNodesRecursive|
        ((|t| (|Tree| (|Integer|))) (|visited| (|List| (|NonNegativeInteger|)))
         ($ #1=(|List| (|Loop|))))
        (SPROG
         ((|res| (|List| (|Loop|))) (|ll| #1#) (#2=#:G872 NIL) (#3=#:G878 NIL)
          (|x| NIL) (#4=#:G877 NIL) (#5=#:G868 NIL) (|afterIndex| (|Integer|))
          (|i| (|Integer|)) (|v2| (|NonNegativeInteger|)) (#6=#:G864 NIL)
          (|v| (|Integer|)) (|c| (|List| (|Tree| (|Integer|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |c| (SPADCALL |t| (QREFELT $ 63)))
                (LETT |v| (SPADCALL |t| (QREFELT $ 64)))
                (COND
                 ((< |v| 0)
                  (SEQ
                   (LETT |v2|
                         (PROG1 (LETT #6# (- |v|))
                           (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #6#)))
                   (LETT |i| (SPADCALL |v2| |visited| (QREFELT $ 65)))
                   (COND
                    ((< |i| 1)
                     (PROGN
                      (LETT #4# (LIST (SPADCALL |visited| (QREFELT $ 67))))
                      (GO #7=#:G876))))
                   (LETT |afterIndex|
                         (- (+ (SPADCALL |visited| (QREFELT $ 68)) 1) |i|))
                   (COND
                    ((< |afterIndex| 1)
                     (PROGN
                      (LETT #4# (LIST (SPADCALL |visited| (QREFELT $ 67))))
                      (GO #7#))))
                   (EXIT
                    (PROGN
                     (LETT #4#
                           (LIST
                            (SPADCALL
                             (SPADCALL |visited|
                                       (PROG1 (LETT #5# |afterIndex|)
                                         (|check_subtype2| (>= #5# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #5#))
                                       (QREFELT $ 69))
                             (QREFELT $ 67))))
                     (GO #7#))))))
                (LETT |res| NIL)
                (SEQ (LETT |x| NIL) (LETT #3# |c|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |ll|
                            (|FGRPH-;loopsNodesRecursive| |x|
                             (SPADCALL |visited|
                                       (PROG1 (LETT #2# |v|)
                                         (|check_subtype2| (>= #2# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #2#))
                                       (QREFELT $ 49))
                             $))
                      (EXIT (LETT |res| (SPADCALL |res| |ll| (QREFELT $ 71)))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #7# (EXIT #4#)))) 

(SDEFUN |FGRPH-;loopsNodes;AL;16| ((|s| (A)) ($ (|List| (|Loop|))))
        (SPROG
         ((|res| (|List| (|Loop|))) (#1=#:G883 NIL) (|x| NIL)
          (|sf| (|List| (|Tree| (|Integer|)))))
         (SEQ (LETT |res| NIL) (LETT |sf| (SPADCALL |s| (QREFELT $ 72)))
              (SEQ (LETT |x| NIL) (LETT #1# |sf|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res|
                                     (|FGRPH-;loopsNodesRecursive| |x| NIL $)
                                     (QREFELT $ 71)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |res| (QREFELT $ 73)))))) 

(SDEFUN |FGRPH-;loopsAtNode;ANniL;17|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) ($ (|List| (|Loop|))))
        (SPROG ((|st| (|Tree| (|Integer|))))
               (SEQ (LETT |st| (SPADCALL |s| |a| (QREFELT $ 61)))
                    (EXIT
                     (SPADCALL (|FGRPH-;loopsNodesRecursive| |st| NIL $)
                               (QREFELT $ 73)))))) 

(SDEFUN |FGRPH-;loopsArrowsRecursive|
        ((|t| (|Tree| (|Integer|))) (|visited| (|List| (|NonNegativeInteger|)))
         ($ #1=(|List| (|Loop|))))
        (SPROG
         ((|res| (|List| (|Loop|))) (|ll| #1#) (#2=#:G892 NIL) (#3=#:G898 NIL)
          (|x| NIL) (#4=#:G897 NIL) (#5=#:G888 NIL) (|afterIndex| (|Integer|))
          (|i| (|Integer|)) (|v2| (|NonNegativeInteger|)) (#6=#:G886 NIL)
          (|v| (|Integer|)) (|c| (|List| (|Tree| (|Integer|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |c| (SPADCALL |t| (QREFELT $ 63)))
                (LETT |v| (SPADCALL |t| (QREFELT $ 64)))
                (COND
                 ((< |v| 0)
                  (SEQ
                   (LETT |v2|
                         (PROG1 (LETT #6# (- |v|))
                           (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #6#)))
                   (LETT |i| (SPADCALL |v2| |visited| (QREFELT $ 65)))
                   (COND
                    ((< |i| 1)
                     (PROGN
                      (LETT #4# (LIST (SPADCALL |visited| (QREFELT $ 67))))
                      (GO #7=#:G896))))
                   (LETT |afterIndex|
                         (- (+ (SPADCALL |visited| (QREFELT $ 68)) 1) |i|))
                   (COND
                    ((< |afterIndex| 1)
                     (PROGN
                      (LETT #4# (LIST (SPADCALL |visited| (QREFELT $ 67))))
                      (GO #7#))))
                   (EXIT
                    (PROGN
                     (LETT #4#
                           (LIST
                            (SPADCALL
                             (SPADCALL |visited|
                                       (PROG1 (LETT #5# |afterIndex|)
                                         (|check_subtype2| (>= #5# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #5#))
                                       (QREFELT $ 69))
                             (QREFELT $ 67))))
                     (GO #7#))))))
                (LETT |res| NIL)
                (SEQ (LETT |x| NIL) (LETT #3# |c|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |ll|
                            (|FGRPH-;loopsArrowsRecursive| |x|
                             (SPADCALL |visited|
                                       (PROG1 (LETT #2# |v|)
                                         (|check_subtype2| (>= #2# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #2#))
                                       (QREFELT $ 49))
                             $))
                      (EXIT (LETT |res| (SPADCALL |res| |ll| (QREFELT $ 71)))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (EXIT |res|)))
          #7# (EXIT #4#)))) 

(SDEFUN |FGRPH-;loopsArrows;AL;19| ((|s| (A)) ($ (|List| (|Loop|))))
        (SPROG
         ((|res| (|List| (|Loop|))) (#1=#:G903 NIL) (|x| NIL)
          (|sf| (|List| (|Tree| (|Integer|)))))
         (SEQ (LETT |res| NIL) (LETT |sf| (SPADCALL |s| (QREFELT $ 76)))
              (SEQ (LETT |x| NIL) (LETT #1# |sf|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res|
                                     (|FGRPH-;loopsArrowsRecursive| |x| NIL $)
                                     (QREFELT $ 71)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |res| (QREFELT $ 73)))))) 

(SDEFUN |FGRPH-;isAcyclic?;AB;20| ((|s| (A)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 78)) NIL (QREFELT $ 79))) 

(SDEFUN |FGRPH-;isDirectSuccessor?;A2NniB;21|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPROG ((#1=#:G911 NIL) (#2=#:G912 NIL) (|arr| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |arr| NIL)
                       (LETT #2# (SPADCALL |s| (QREFELT $ 22))) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |arr| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((EQL (QVELT |arr| 2) |a|)
                           (COND
                            ((EQL (QVELT |arr| 3) |b|)
                             (PROGN (LETT #1# 'T) (GO #3=#:G910))))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT NIL)))
                #3# (EXIT #1#)))) 

(SDEFUN |FGRPH-;isFixPoint?;ANniB;22|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPROG ((#1=#:G919 NIL) (#2=#:G920 NIL) (|arr| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |arr| NIL)
                       (LETT #2# (SPADCALL |s| (QREFELT $ 22))) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |arr| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((EQL (QVELT |arr| 2) |a|)
                           (COND
                            ((EQL (QVELT |arr| 3) |a|)
                             (PROGN (LETT #1# 'T) (GO #3=#:G918))))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT NIL)))
                #3# (EXIT #1#)))) 

(SDEFUN |FGRPH-;getArrowIndex;A3Nni;23|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G928 NIL) (#2=#:G929 NIL) (|arrn| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ
          (EXIT
           (SEQ (LETT |arrs| (SPADCALL |s| (QREFELT $ 22)))
                (SEQ (LETT |arrn| 1) (LETT #2# (LENGTH |arrs|)) G190
                     (COND ((|greater_SI| |arrn| #2#) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((EQL (QVELT (SPADCALL |arrs| |arrn| (QREFELT $ 83)) 2)
                              |a|)
                         (COND
                          ((EQL
                            (QVELT (SPADCALL |arrs| |arrn| (QREFELT $ 83)) 3)
                            |b|)
                           (PROGN (LETT #1# |arrn|) (GO #3=#:G927))))))))
                     (LETT |arrn| (|inc_SI| |arrn|)) (GO G190) G191 (EXIT NIL))
                (EXIT 0)))
          #3# (EXIT #1#)))) 

(SDEFUN |FGRPH-;arrowName;A2NniS;24|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|String|)))
        (SPROG ((#1=#:G936 NIL) (#2=#:G937 NIL) (|arr| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |arr| NIL)
                       (LETT #2# (SPADCALL |s| (QREFELT $ 22))) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |arr| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((EQL (QVELT |arr| 2) |a|)
                           (COND
                            ((EQL (QVELT |arr| 3) |b|)
                             (PROGN
                              (LETT #1# (QVELT |arr| 0))
                              (GO #3=#:G935))))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT "?")))
                #3# (EXIT #1#)))) 

(SDEFUN |FGRPH-;inDegree;A2Nni;25|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((|count| (|NonNegativeInteger|)) (#1=#:G943 NIL) (|arr| NIL))
               (SEQ (LETT |count| 0)
                    (SEQ (LETT |arr| NIL)
                         (LETT #1# (SPADCALL |s| (QREFELT $ 22))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |arr| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((EQL (QVELT |arr| 3) |a|)
                             (LETT |count| (+ |count| 1))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |count|)))) 

(SDEFUN |FGRPH-;outDegree;A2Nni;26|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((|count| (|NonNegativeInteger|)) (#1=#:G949 NIL) (|arr| NIL))
               (SEQ (LETT |count| 0)
                    (SEQ (LETT |arr| NIL)
                         (LETT #1# (SPADCALL |s| (QREFELT $ 22))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |arr| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((EQL (QVELT |arr| 2) |a|)
                             (LETT |count| (+ |count| 1))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |count|)))) 

(SDEFUN |FGRPH-;nodeFromNode;ANniL;27|
        ((|s| (A)) (|v| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|i| (|List| (|NonNegativeInteger|))) (#1=#:G955 NIL) (|arr| NIL))
         (SEQ (LETT |i| NIL)
              (SEQ (LETT |arr| NIL) (LETT #1# (SPADCALL |s| (QREFELT $ 22)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |arr| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL (QVELT |arr| 3) |v|)
                       (LETT |i|
                             (SPADCALL |i| (QVELT |arr| 2) (QREFELT $ 49)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |i|)))) 

(SDEFUN |FGRPH-;nodeToNode;ANniL;28|
        ((|s| (A)) (|v| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|i| (|List| (|NonNegativeInteger|))) (#1=#:G961 NIL) (|arr| NIL))
         (SEQ (LETT |i| NIL)
              (SEQ (LETT |arr| NIL) (LETT #1# (SPADCALL |s| (QREFELT $ 22)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |arr| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL (QVELT |arr| 2) |v|)
                       (LETT |i|
                             (SPADCALL |i| (QVELT |arr| 3) (QREFELT $ 49)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |i|)))) 

(SDEFUN |FGRPH-;arrowsFromNode;ANniL;29|
        ((|s| (A)) (|v| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|i| (|List| (|NonNegativeInteger|))) (#1=#:G968 NIL) (|arrn| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |i| NIL) (LETT |arrs| (SPADCALL |s| (QREFELT $ 22)))
              (SEQ (LETT |arrn| 1) (LETT #1# (LENGTH |arrs|)) G190
                   (COND ((|greater_SI| |arrn| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL (QVELT (SPADCALL |arrs| |arrn| (QREFELT $ 83)) 3)
                            |v|)
                       (LETT |i| (SPADCALL |i| |arrn| (QREFELT $ 49)))))))
                   (LETT |arrn| (|inc_SI| |arrn|)) (GO G190) G191 (EXIT NIL))
              (EXIT |i|)))) 

(SDEFUN |FGRPH-;arrowsToNode;ANniL;30|
        ((|s| (A)) (|v| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|i| (|List| (|NonNegativeInteger|))) (#1=#:G975 NIL) (|arrn| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |i| NIL) (LETT |arrs| (SPADCALL |s| (QREFELT $ 22)))
              (SEQ (LETT |arrn| 1) (LETT #1# (LENGTH |arrs|)) G190
                   (COND ((|greater_SI| |arrn| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL (QVELT (SPADCALL |arrs| |arrn| (QREFELT $ 83)) 2)
                            |v|)
                       (LETT |i| (SPADCALL |i| |arrn| (QREFELT $ 49)))))))
                   (LETT |arrn| (|inc_SI| |arrn|)) (GO G190) G191 (EXIT NIL))
              (EXIT |i|)))) 

(SDEFUN |FGRPH-;nodeFromArrow;ANniL;31|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |arrs| (SPADCALL |s| (QREFELT $ 22)))
              (EXIT (LIST (QVELT (SPADCALL |arrs| |a| (QREFELT $ 83)) 3)))))) 

(SDEFUN |FGRPH-;nodeToArrow;ANniL;32|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |arrs| (SPADCALL |s| (QREFELT $ 22)))
              (EXIT (LIST (QVELT (SPADCALL |arrs| |a| (QREFELT $ 83)) 2)))))) 

(SDEFUN |FGRPH-;arrowsFromArrow;ANniL;33|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|i| (|List| (|NonNegativeInteger|))) (#1=#:G986 NIL) (|arrn| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |i| NIL) (LETT |arrs| (SPADCALL |s| (QREFELT $ 22)))
              (SEQ (LETT |arrn| 1) (LETT #1# (LENGTH |arrs|)) G190
                   (COND ((|greater_SI| |arrn| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL (QVELT (SPADCALL |arrs| |arrn| (QREFELT $ 83)) 3)
                            (QVELT (SPADCALL |arrs| |a| (QREFELT $ 83)) 2))
                       (LETT |i| (SPADCALL |i| |arrn| (QREFELT $ 49)))))))
                   (LETT |arrn| (|inc_SI| |arrn|)) (GO G190) G191 (EXIT NIL))
              (EXIT |i|)))) 

(SDEFUN |FGRPH-;arrowsToArrow;ANniL;34|
        ((|s| (A)) (|a| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|i| (|List| (|NonNegativeInteger|))) (#1=#:G993 NIL) (|arrn| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|)))))))
         (SEQ (LETT |i| NIL) (LETT |arrs| (SPADCALL |s| (QREFELT $ 22)))
              (SEQ (LETT |arrn| 1) (LETT #1# (LENGTH |arrs|)) G190
                   (COND ((|greater_SI| |arrn| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((EQL (QVELT (SPADCALL |arrs| |arrn| (QREFELT $ 83)) 2)
                            (QVELT (SPADCALL |arrs| |a| (QREFELT $ 83)) 3))
                       (LETT |i| (SPADCALL |i| |arrn| (QREFELT $ 49)))))))
                   (LETT |arrn| (|inc_SI| |arrn|)) (GO G190) G191 (EXIT NIL))
              (EXIT |i|)))) 

(SDEFUN |FGRPH-;routeNodeRecursive|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         (|visited| (|List| (|NonNegativeInteger|)))
         ($ #1=(|List| (|NonNegativeInteger|))))
        (SPROG
         ((#2=#:G1005 NIL) (|shortest| (|List| (|NonNegativeInteger|)))
          (|d| #1#) (#3=#:G1006 NIL) (|arr| NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((> (SPADCALL |visited| (QREFELT $ 68))
                 (LENGTH (SPADCALL |s| (QREFELT $ 10))))
              (PROGN (LETT #2# NIL) (GO #4=#:G1004))))
            (LETT |shortest| NIL)
            (COND ((EQL |a| |b|) (PROGN (LETT #2# (LIST |a|)) (GO #4#))))
            (COND
             ((SPADCALL |s| |a| |b| (QREFELT $ 29))
              (PROGN (LETT #2# (LIST |a| |b|)) (GO #4#))))
            (SEQ (LETT |arr| NIL) (LETT #3# (SPADCALL |s| (QREFELT $ 22))) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |arr| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((SPADCALL |s| |a| (QVELT |arr| 2) (QREFELT $ 29))
                     (SEQ
                      (LETT |d|
                            (|FGRPH-;routeNodeRecursive| |s| (QVELT |arr| 2)
                             |b| (SPADCALL |visited| |a| (QREFELT $ 49)) $))
                      (EXIT
                       (COND
                        ((SPADCALL |shortest| NIL (QREFELT $ 96))
                         (LETT |shortest| |d|))
                        ((SPADCALL |d| NIL (QREFELT $ 97))
                         (COND
                          ((< (SPADCALL |d| (QREFELT $ 68))
                              (SPADCALL |shortest| (QREFELT $ 68)))
                           (LETT |shortest| |d|)))))))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (COND
             ((SPADCALL |shortest| NIL (QREFELT $ 96))
              (PROGN (LETT #2# NIL) (GO #4#))))
            (EXIT (CONS |a| |shortest|))))
          #4# (EXIT #2#)))) 

(SDEFUN |FGRPH-;routeNodes;A2NniL;36|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (|FGRPH-;routeNodeRecursive| |s| |a| |b| NIL $)) 

(SDEFUN |FGRPH-;routeArrowRecursive|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         (|visited| (|List| (|NonNegativeInteger|)))
         ($ #1=(|List| (|NonNegativeInteger|))))
        (SPROG
         ((#2=#:G1022 NIL)
          (|shortestFullPath| (|List| #3=(|NonNegativeInteger|)))
          (|shortest| (|List| #3#))
          (|fullPath| (|List| (|NonNegativeInteger|))) (|d| #1#) (|aa| #3#)
          (#4=#:G1023 NIL) (|arr| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arrn| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((> (SPADCALL |visited| (QREFELT $ 68))
                 (LENGTH (SPADCALL |s| (QREFELT $ 10))))
              (PROGN (LETT #2# (LIST 0)) (GO #5=#:G1021))))
            (LETT |shortest| (LIST 0))
            (COND ((EQL |a| |b|) (PROGN (LETT #2# NIL) (GO #5#))))
            (LETT |arrn| (SPADCALL |s| |a| |b| (QREFELT $ 99)))
            (COND
             ((SPADCALL |arrn| 0 (QREFELT $ 100))
              (PROGN (LETT #2# (LIST |arrn|)) (GO #5#))))
            (LETT |aa| 0) (LETT |shortestFullPath| (LIST 0))
            (LETT |arrs| (SPADCALL |s| (QREFELT $ 22)))
            (SEQ (LETT |arr| NIL) (LETT #4# |arrs|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |arr| (CAR #4#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((SPADCALL |s| |a| (QVELT |arr| 2) (QREFELT $ 29))
                     (SEQ
                      (LETT |aa|
                            (SPADCALL |s| |a| (QVELT |arr| 2) (QREFELT $ 99)))
                      (LETT |d|
                            (|FGRPH-;routeArrowRecursive| |s| (QVELT |arr| 2)
                             |b| (SPADCALL |visited| |a| (QREFELT $ 49)) $))
                      (LETT |fullPath| (CONS |aa| |d|))
                      (EXIT
                       (COND
                        ((SPADCALL |shortest| (LIST 0) (QREFELT $ 96))
                         (SEQ (LETT |shortest| |d|)
                              (EXIT (LETT |shortestFullPath| |fullPath|))))
                        ((SPADCALL |d| (LIST 0) (QREFELT $ 97))
                         (COND
                          ((< (SPADCALL |fullPath| (QREFELT $ 68))
                              (SPADCALL |shortestFullPath| (QREFELT $ 68)))
                           (SEQ (LETT |shortest| |d|)
                                (EXIT
                                 (LETT |shortestFullPath|
                                       |fullPath|)))))))))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (COND
             ((SPADCALL |shortest| (LIST 0) (QREFELT $ 96))
              (PROGN (LETT #2# (LIST 0)) (GO #5#))))
            (EXIT |shortestFullPath|)))
          #5# (EXIT #2#)))) 

(SDEFUN |FGRPH-;routeArrows;A2NniL;38|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (|FGRPH-;routeArrowRecursive| |s| |a| |b| NIL $)) 

(SDEFUN |FGRPH-;isGreaterThan?;A2NniB;39|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Boolean|)))
        (SPROG ((#1=#:G1029 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL (|FGRPH-;routeNodeRecursive| |s| |a| |b| NIL $)
                              NIL (QREFELT $ 96))
                    (PROGN (LETT #1# NIL) (GO #2=#:G1028))))
                  (COND
                   ((SPADCALL (|FGRPH-;routeNodeRecursive| |s| |b| |a| NIL $)
                              NIL (QREFELT $ 97))
                    (PROGN (LETT #1# NIL) (GO #2#))))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |FGRPH-;max;ANni;40| ((|s| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G1041 NIL) (|fail| (|Boolean|)) (#2=#:G1043 NIL) (|j| NIL)
          (#3=#:G1042 NIL) (|i| NIL)
          (|ls|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |ls| (SPADCALL |s| (QREFELT $ 10)))
                (SEQ (LETT |i| 1) (LETT #3# (LENGTH |ls|)) G190
                     (COND ((|greater_SI| |i| #3#) (GO G191)))
                     (SEQ (LETT |fail| NIL)
                          (SEQ (LETT |j| 1) (LETT #2# (LENGTH |ls|)) G190
                               (COND ((|greater_SI| |j| #2#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL |i| |j| (QREFELT $ 100))
                                   (COND
                                    ((NULL
                                      (SPADCALL |s| |j| |i| (QREFELT $ 103)))
                                     (LETT |fail| 'T)))))))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT
                           (COND
                            ((NULL |fail|)
                             (PROGN (LETT #1# |i|) (GO #4=#:G1040))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT 0)))
          #4# (EXIT #1#)))) 

(SDEFUN |FGRPH-;max;ALNni;41|
        ((|s| (A)) (|sub| (|List| (|NonNegativeInteger|)))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G1053 NIL) (|fail| (|Boolean|)) (#2=#:G1055 NIL) (|j| NIL)
          (#3=#:G1054 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| NIL) (LETT #3# |sub|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |i| (CAR #3#)) NIL)) (GO G191)))
                 (SEQ (LETT |fail| NIL)
                      (SEQ (LETT |j| NIL) (LETT #2# |sub|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |j| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |i| |j| (QREFELT $ 100))
                               (COND
                                ((NULL (SPADCALL |s| |j| |i| (QREFELT $ 103)))
                                 (LETT |fail| 'T)))))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((NULL |fail|)
                         (PROGN (LETT #1# |i|) (GO #4=#:G1052))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (EXIT 0)))
          #4# (EXIT #1#)))) 

(SDEFUN |FGRPH-;min;ANni;42| ((|s| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G1067 NIL) (|fail| (|Boolean|)) (#2=#:G1069 NIL) (|j| NIL)
          (#3=#:G1068 NIL) (|i| NIL)
          (|ls|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |ls| (SPADCALL |s| (QREFELT $ 10)))
                (SEQ (LETT |i| 1) (LETT #3# (LENGTH |ls|)) G190
                     (COND ((|greater_SI| |i| #3#) (GO G191)))
                     (SEQ (LETT |fail| NIL)
                          (SEQ (LETT |j| 1) (LETT #2# (LENGTH |ls|)) G190
                               (COND ((|greater_SI| |j| #2#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL |i| |j| (QREFELT $ 100))
                                   (COND
                                    ((NULL
                                      (SPADCALL |s| |i| |j| (QREFELT $ 103)))
                                     (LETT |fail| 'T)))))))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT
                           (COND
                            ((NULL |fail|)
                             (PROGN (LETT #1# |i|) (GO #4=#:G1066))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT 0)))
          #4# (EXIT #1#)))) 

(SDEFUN |FGRPH-;min;ALNni;43|
        ((|s| (A)) (|sub| (|List| (|NonNegativeInteger|)))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G1079 NIL) (|fail| (|Boolean|)) (#2=#:G1081 NIL) (|j| NIL)
          (#3=#:G1080 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| NIL) (LETT #3# |sub|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |i| (CAR #3#)) NIL)) (GO G191)))
                 (SEQ (LETT |fail| NIL)
                      (SEQ (LETT |j| NIL) (LETT #2# |sub|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |j| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |i| |j| (QREFELT $ 100))
                               (COND
                                ((NULL (SPADCALL |s| |i| |j| (QREFELT $ 103)))
                                 (LETT |fail| 'T)))))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((NULL |fail|)
                         (PROGN (LETT #1# |i|) (GO #4=#:G1078))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (EXIT 0)))
          #4# (EXIT #1#)))) 

(SDEFUN |FGRPH-;distance;A2NniI;44|
        ((|s| (A)) (|a| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         ($ (|Integer|)))
        (-
         (SPADCALL (|FGRPH-;routeNodeRecursive| |s| |a| |b| NIL $)
                   (QREFELT $ 68))
         1)) 

(SDEFUN |FGRPH-;isFunctional?;AB;45| ((|s| (A)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1092 NIL) (#2=#:G1096 NIL) (|x| NIL)
          (|fromI| (|NonNegativeInteger|)) (#3=#:G1095 NIL) (|arr| NIL)
          (|counts| (|List| (|NonNegativeInteger|))) (#4=#:G1094 NIL)
          (#5=#:G1093 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |counts|
                  (PROGN
                   (LETT #5# NIL)
                   (SEQ (LETT |x| NIL) (LETT #4# (SPADCALL |s| (QREFELT $ 10)))
                        G190
                        (COND
                         ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                          (GO G191)))
                        (SEQ (EXIT (LETT #5# (CONS 0 #5#))))
                        (LETT #4# (CDR #4#)) (GO G190) G191
                        (EXIT (NREVERSE #5#)))))
            (SEQ (LETT |arr| NIL) (LETT #3# (SPADCALL |s| (QREFELT $ 22))) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |arr| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ (LETT |fromI| (QVELT |arr| 2))
                      (EXIT
                       (SPADCALL |counts| |fromI|
                                 (+ (SPADCALL |counts| |fromI| (QREFELT $ 109))
                                    1)
                                 (QREFELT $ 110))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (SEQ (LETT |x| NIL) (LETT #2# |counts|) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((NULL (EQL |x| 1))
                     (PROGN (LETT #1# NIL) (GO #6=#:G1091))))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #6# (EXIT #1#)))) 

(SDEFUN |FGRPH-;createWidth;2Nni;46|
        ((|x| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G1102 NIL) (|w| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |w| 1) G190
                       (COND ((|greater_SI| |w| 100) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((>= (* |w| |w|) |x|)
                           (PROGN (LETT #1# |w|) (GO #2=#:G1101))))))
                       (LETT |w| (|inc_SI| |w|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 100)))
                #2# (EXIT #1#)))) 

(SDEFUN |FGRPH-;createX;3Nni;47|
        ((|x| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G1110 NIL) (#2=#:G1104 NIL)
          (|d|
           (|Record| (|:| |quotient| (|NonNegativeInteger|))
                     (|:| |remainder| (|NonNegativeInteger|))))
          (|r| (|Union| (|NonNegativeInteger|) #3="failed"))
          (|w| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |w| (SPADCALL |x| (QREFELT $ 113)))
                (LETT |r| (SPADCALL |n| 1 (QREFELT $ 115)))
                (LETT |d|
                      (DIVIDE2
                       (PROG2 (LETT #2# |r|)
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0) (|NonNegativeInteger|)
                                         (|Union| (|NonNegativeInteger|) #3#)
                                         #2#))
                       |w|))
                (COND
                 ((ODDP (QCAR |d|))
                  (PROGN
                   (LETT #1#
                         (*
                          (PROG2
                              (LETT #2#
                                    (SPADCALL |w| (QCDR |d|) (QREFELT $ 115)))
                              (QCDR #2#)
                            (|check_union2| (QEQCAR #2# 0)
                                            (|NonNegativeInteger|)
                                            (|Union| (|NonNegativeInteger|)
                                                     #3#)
                                            #2#))
                          2))
                   (GO #4=#:G1109))))
                (EXIT (* (+ (QCDR |d|) 1) 2))))
          #4# (EXIT #1#)))) 

(SDEFUN |FGRPH-;createY;3Nni;48|
        ((|x| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((|d|
           (|Record| (|:| |quotient| (|NonNegativeInteger|))
                     (|:| |remainder| (|NonNegativeInteger|))))
          (#1=#:G1112 NIL) (|r| (|Union| (|NonNegativeInteger|) #2="failed"))
          (|w| (|NonNegativeInteger|)))
         (SEQ (LETT |w| (SPADCALL |x| (QREFELT $ 113)))
              (LETT |r| (SPADCALL |n| 1 (QREFELT $ 115)))
              (LETT |d|
                    (DIVIDE2
                     (PROG2 (LETT #1# |r|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 0) (|NonNegativeInteger|)
                                       (|Union| (|NonNegativeInteger|) #2#)
                                       #1#))
                     |w|))
              (EXIT (* (+ (QCAR |d|) 1) 2))))) 

(SDEFUN |FGRPH-;subdiagramSvg;SA2BV;49|
        ((|sc| (|Scene| (|SCartesian| 2))) (|n| (A))
         (|dispArrowName| (|Boolean|)) (|deep| (|Boolean|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G1156 NIL) (|s| (|String|))
          (|arrNode| (|Scene| (|SCartesian| 2))) (|offset| (|SCartesian| 2))
          (|tnode| #2=(|Scene| (|SCartesian| 2))) (|fnode| #2#)
          (|subArrNode| (|Scene| (|SCartesian| 2)))
          (|subToY| #3=(|DoubleFloat|)) (|subFromY| #3#) (|subToX| #3#)
          (|subFromX| #3#)
          (|innerObTo|
           #4=(|Record| (|:| |value| (|DirectedGraph| (|String|)))
                        (|:| |posX| (|NonNegativeInteger|))
                        (|:| |posY| (|NonNegativeInteger|))))
          (|innerObFrom| #4#) (#5=#:G1161 NIL) (|subArrow| NIL)
          (#6=#:G1162 NIL) (|subArrowN| NIL)
          (|mp| (|List| (|NonNegativeInteger|)))
          (|mt| #7=(|Scene| (|SCartesian| 2))) (|rema| (|Integer|))
          (|arrNumber| (|Integer|))
          (|arrIndex| (|List| (|NonNegativeInteger|)))
          (|midY| #8=(|NonNegativeInteger|)) (|midX| #8#)
          (|toY| #9=(|NonNegativeInteger|)) (#10=#:G1140 NIL) (|fromY| #9#)
          (#11=#:G1139 NIL) (|toX| #9#) (#12=#:G1138 NIL) (|fromX| #9#)
          (#13=#:G1137 NIL) (#14=#:G1159 NIL) (|arrow| NIL) (#15=#:G1160 NIL)
          (|arrn| NIL)
          (|innerOb|
           (|List|
            (|List|
             (|Record| (|:| |value| (|DirectedGraph| (|String|)))
                       (|:| |posX| (|NonNegativeInteger|))
                       (|:| |posY| (|NonNegativeInteger|))))))
          (|innerObs|
           (|List|
            (|Record| (|:| |value| (|DirectedGraph| (|String|)))
                      (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|subNd| (|DirectedGraph| (|String|))) (#16=#:G1158 NIL) (|nd| NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|indexBounds| (|List| (|Scene| (|SCartesian| 2))))
          (|tn| (|Scene| (|SCartesian| 2)))
          (|ellip| (|Scene| (|SCartesian| 2)))
          (|sh|
           (|Record| (|:| |shptype| (|Symbol|)) (|:| |centre| (|SCartesian| 2))
                     (|:| |size| (|SCartesian| 2)) (|:| |fill| (|Boolean|))))
          (|subgraph| (|DirectedGraph| (|String|)))
          (|indexPointy| (|List| (|NonNegativeInteger|)))
          (|indexPointx| (|List| (|NonNegativeInteger|)))
          (|y| (|NonNegativeInteger|)) (|x| (|NonNegativeInteger|))
          (|indexNodes| (|List| S)) (#17=#:G1157 NIL) (|i| NIL)
          (|ls|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|)))))
          (|mt8| #7#) (|mt7| #7#) (|mt6| #7#) (|mt5| #7#) (|mt4| #7#)
          (|mt3| #7#) (|mt2| #7#) (|mt1| #7#))
         (SEQ
          (EXIT
           (SEQ
            (LETT |mt1|
                  (SPADCALL |sc| (FLOAT 3 MOST-POSITIVE-DOUBLE-FLOAT) "black"
                            "black" (QREFELT $ 120)))
            (LETT |mt2|
                  (SPADCALL |sc| (FLOAT 3 MOST-POSITIVE-DOUBLE-FLOAT) "blue"
                            "blue" (QREFELT $ 120)))
            (LETT |mt3|
                  (SPADCALL |sc| (FLOAT 3 MOST-POSITIVE-DOUBLE-FLOAT) "orange"
                            "orange" (QREFELT $ 120)))
            (LETT |mt4|
                  (SPADCALL |sc| (FLOAT 3 MOST-POSITIVE-DOUBLE-FLOAT) "green"
                            "green" (QREFELT $ 120)))
            (LETT |mt5|
                  (SPADCALL |sc| (FLOAT 3 MOST-POSITIVE-DOUBLE-FLOAT) "brown"
                            "brown" (QREFELT $ 120)))
            (LETT |mt6|
                  (SPADCALL |sc| (FLOAT 3 MOST-POSITIVE-DOUBLE-FLOAT) "grey"
                            "grey" (QREFELT $ 120)))
            (LETT |mt7|
                  (SPADCALL |sc| (FLOAT 3 MOST-POSITIVE-DOUBLE-FLOAT) "red"
                            "red" (QREFELT $ 120)))
            (LETT |mt8|
                  (SPADCALL |sc| (FLOAT 3 MOST-POSITIVE-DOUBLE-FLOAT) "purple"
                            "purple" (QREFELT $ 120)))
            (LETT |ls| (SPADCALL |n| (QREFELT $ 10))) (LETT |indexPointx| NIL)
            (LETT |indexPointy| NIL) (LETT |indexBounds| NIL)
            (LETT |indexNodes| NIL)
            (SEQ (LETT |i| NIL) (LETT #17# |ls|) G190
                 (COND
                  ((OR (ATOM #17#) (PROGN (LETT |i| (CAR #17#)) NIL))
                   (GO G191)))
                 (SEQ
                  (LETT |indexNodes|
                        (SPADCALL |indexNodes| (QVELT |i| 0) (QREFELT $ 122)))
                  (LETT |s| (|mathObject2String| (QVELT |i| 0)))
                  (LETT |x| (QVELT |i| 1)) (LETT |y| (QVELT |i| 2))
                  (LETT |indexPointx|
                        (SPADCALL |indexPointx| |x| (QREFELT $ 49)))
                  (LETT |indexPointy|
                        (SPADCALL |indexPointy| |y| (QREFELT $ 49)))
                  (EXIT
                   (COND
                    ((EQUAL (QREFELT $ 7) (|DirectedGraph| (|String|)))
                     (SEQ (LETT |subgraph| (QVELT |i| 0))
                          (LETT |sh|
                                (VECTOR '|ellipse|
                                        (SPADCALL
                                         (SPADCALL |x| |y| (QREFELT $ 124))
                                         (SPADCALL (|mk_DF| 7 -1)
                                                   (|mk_DF| 7 -1)
                                                   (QREFELT $ 125))
                                         (QREFELT $ 126))
                                        (SPADCALL (|mk_DF| 7 -1) (|mk_DF| 7 -1)
                                                  (QREFELT $ 125))
                                        NIL))
                          (LETT |ellip| (SPADCALL |sc| |sh| (QREFELT $ 128)))
                          (LETT |tn|
                                (SPADCALL |sc| |subgraph| |x| |y|
                                          |dispArrowName| (QREFELT $ 130)))
                          (EXIT
                           (LETT |indexBounds|
                                 (SPADCALL |indexBounds| |ellip|
                                           (QREFELT $ 132))))))
                    ('T
                     (SEQ
                      (LETT |tn|
                            (SPADCALL |sc| |s| 32
                                      (SPADCALL |x| |y| (QREFELT $ 124))
                                      (QREFELT $ 133)))
                      (EXIT
                       (LETT |indexBounds|
                             (SPADCALL |indexBounds| |tn|
                                       (QREFELT $ 132)))))))))
                 (LETT #17# (CDR #17#)) (GO G190) G191 (EXIT NIL))
            (LETT |arrs| (SPADCALL |n| (QREFELT $ 22)))
            (COND
             ((SPADCALL |arrs| NIL (QREFELT $ 134))
              (PROGN (LETT #1# (SPADCALL (QREFELT $ 136))) (GO #18=#:G1155))))
            (LETT |innerOb| NIL)
            (COND
             (|deep|
              (COND
               ((EQUAL (QREFELT $ 7) (|DirectedGraph| (|String|)))
                (SEQ (LETT |nd| NIL) (LETT #16# |indexNodes|) G190
                     (COND
                      ((OR (ATOM #16#) (PROGN (LETT |nd| (CAR #16#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |subNd| |nd|)
                          (LETT |innerObs| (SPADCALL |subNd| (QREFELT $ 139)))
                          (EXIT
                           (LETT |innerOb|
                                 (SPADCALL |innerOb| |innerObs|
                                           (QREFELT $ 143)))))
                     (LETT #16# (CDR #16#)) (GO G190) G191 (EXIT NIL))))))
            (SEQ (LETT |arrn| 1) (LETT #15# (LENGTH |arrs|)) (LETT |arrow| NIL)
                 (LETT #14# |arrs|) G190
                 (COND
                  ((OR (ATOM #14#) (PROGN (LETT |arrow| (CAR #14#)) NIL)
                       (|greater_SI| |arrn| #15#))
                   (GO G191)))
                 (SEQ
                  (LETT |fromX|
                        (SPADCALL |indexPointx| (QVELT |arrow| 2)
                                  (QREFELT $ 109)))
                  (LETT |toX|
                        (SPADCALL |indexPointx| (QVELT |arrow| 3)
                                  (QREFELT $ 109)))
                  (LETT |fromX|
                        (PROG1 (LETT #13# (+ |fromX| (QVELT |arrow| 4)))
                          (|check_subtype2| (>= #13# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #13#)))
                  (LETT |toX|
                        (PROG1 (LETT #12# (+ |toX| (QVELT |arrow| 4)))
                          (|check_subtype2| (>= #12# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #12#)))
                  (LETT |fromY|
                        (SPADCALL |indexPointy| (QVELT |arrow| 2)
                                  (QREFELT $ 109)))
                  (LETT |toY|
                        (SPADCALL |indexPointy| (QVELT |arrow| 3)
                                  (QREFELT $ 109)))
                  (LETT |fromY|
                        (PROG1 (LETT #11# (+ |fromY| (QVELT |arrow| 5)))
                          (|check_subtype2| (>= #11# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #11#)))
                  (LETT |toY|
                        (PROG1 (LETT #10# (+ |toY| (QVELT |arrow| 5)))
                          (|check_subtype2| (>= #10# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #10#)))
                  (LETT |midX| (ASH (+ |toX| |fromX|) -1))
                  (LETT |midY| (ASH (+ |toY| |fromY|) -1))
                  (LETT |arrIndex|
                        (SPADCALL |n| (QVELT |arrow| 2) (QREFELT $ 144)))
                  (LETT |arrNumber|
                        (SPADCALL |arrn| |arrIndex| (QREFELT $ 65)))
                  (LETT |rema| (QCDR (DIVIDE2 |arrNumber| 8)))
                  (LETT |mt| |mt1|) (COND ((EQL |rema| 0) (LETT |mt| |mt1|)))
                  (COND ((EQL |rema| 1) (LETT |mt| |mt2|)))
                  (COND ((EQL |rema| 2) (LETT |mt| |mt3|)))
                  (COND ((EQL |rema| 3) (LETT |mt| |mt4|)))
                  (COND ((EQL |rema| 4) (LETT |mt| |mt5|)))
                  (COND ((EQL |rema| 5) (LETT |mt| |mt6|)))
                  (COND ((EQL |rema| 6) (LETT |mt| |mt7|)))
                  (COND ((EQL |rema| 7) (LETT |mt| |mt8|)))
                  (COND
                   (|deep|
                    (COND
                     ((EQUAL (QREFELT $ 7) (|DirectedGraph| (|String|)))
                      (SEQ (LETT |mp| (QVELT |arrow| 6))
                           (EXIT
                            (SEQ (LETT |subArrowN| 1)
                                 (LETT #6# (SPADCALL |mp| (QREFELT $ 68)))
                                 (LETT |subArrow| NIL) (LETT #5# |mp|) G190
                                 (COND
                                  ((OR (ATOM #5#)
                                       (PROGN (LETT |subArrow| (CAR #5#)) NIL)
                                       (|greater_SI| |subArrowN| #6#))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |innerObFrom|
                                        (SPADCALL
                                         (SPADCALL |innerOb| (QVELT |arrow| 2)
                                                   (QREFELT $ 145))
                                         |subArrowN| (QREFELT $ 146)))
                                  (LETT |innerObTo|
                                        (SPADCALL
                                         (SPADCALL |innerOb| (QVELT |arrow| 3)
                                                   (QREFELT $ 145))
                                         |subArrow| (QREFELT $ 146)))
                                  (LETT |subFromX|
                                        (|add_DF|
                                         (FLOAT |fromX|
                                                MOST-POSITIVE-DOUBLE-FLOAT)
                                         (|mul_DF|
                                          (FLOAT (QVELT |innerObFrom| 1)
                                                 MOST-POSITIVE-DOUBLE-FLOAT)
                                          (|mk_DF| 25 -2))))
                                  (LETT |subToX|
                                        (|add_DF|
                                         (FLOAT |toX|
                                                MOST-POSITIVE-DOUBLE-FLOAT)
                                         (|mul_DF|
                                          (FLOAT (QVELT |innerObFrom| 2)
                                                 MOST-POSITIVE-DOUBLE-FLOAT)
                                          (|mk_DF| 25 -2))))
                                  (LETT |subFromY|
                                        (|add_DF|
                                         (FLOAT |fromY|
                                                MOST-POSITIVE-DOUBLE-FLOAT)
                                         (|mul_DF|
                                          (FLOAT (QVELT |innerObTo| 1)
                                                 MOST-POSITIVE-DOUBLE-FLOAT)
                                          (|mk_DF| 25 -2))))
                                  (LETT |subToY|
                                        (|add_DF|
                                         (FLOAT |toY|
                                                MOST-POSITIVE-DOUBLE-FLOAT)
                                         (|mul_DF|
                                          (FLOAT (QVELT |innerObTo| 2)
                                                 MOST-POSITIVE-DOUBLE-FLOAT)
                                          (|mk_DF| 25 -2))))
                                  (EXIT
                                   (LETT |subArrNode|
                                         (SPADCALL |mt|
                                                   (LIST
                                                    (LIST
                                                     (SPADCALL |subFromX|
                                                               |subFromY|
                                                               (QREFELT $ 147))
                                                     (SPADCALL |subToX|
                                                               |subToY|
                                                               (QREFELT $
                                                                        147))))
                                                   '|fixed| (|mk_DF| 1 -1)
                                                   (QREFELT $ 150)))))
                                 (LETT #5#
                                       (PROG1 (CDR #5#)
                                         (LETT |subArrowN|
                                               (|inc_SI| |subArrowN|))))
                                 (GO G190) G191 (EXIT NIL))))))))
                  (EXIT
                   (COND
                    ((NULL |deep|)
                     (SEQ
                      (LETT |fnode|
                            (SPADCALL |indexBounds| (QVELT |arrow| 2)
                                      (QREFELT $ 151)))
                      (LETT |tnode|
                            (SPADCALL |indexBounds| (QVELT |arrow| 3)
                                      (QREFELT $ 151)))
                      (LETT |offset|
                            (SPADCALL (QVELT |arrow| 4) (QVELT |arrow| 5)
                                      (QREFELT $ 124)))
                      (COND
                       ((EQUAL (QREFELT $ 7) (|DirectedGraph| (|String|)))
                        (LETT |arrNode|
                              (SPADCALL |mt| |fnode| |tnode| |offset| '|fixed|
                                        (|mk_DF| 1 -1)
                                        (FLOAT
                                         (+ (SPADCALL |n| (QREFELT $ 152)) 10)
                                         MOST-POSITIVE-DOUBLE-FLOAT)
                                        (QREFELT $ 153))))
                       ('T
                        (LETT |arrNode|
                              (SPADCALL |mt| |fnode| |tnode| |offset|
                                        '|proportional| (|mk_DF| 1 -1)
                                        (FLOAT
                                         (+ (SPADCALL |n| (QREFELT $ 152)) 10)
                                         MOST-POSITIVE-DOUBLE-FLOAT)
                                        (QREFELT $ 153)))))
                      (EXIT
                       (COND
                        (|dispArrowName|
                         (SEQ (LETT |s| (QVELT |arrow| 0))
                              (EXIT
                               (SPADCALL |mt| |s| 32
                                         (SPADCALL |midX| |midY|
                                                   (QREFELT $ 124))
                                         (QREFELT $ 133))))))))))))
                 (LETT #14# (PROG1 (CDR #14#) (LETT |arrn| (|inc_SI| |arrn|))))
                 (GO G190) G191 (EXIT NIL))
            (EXIT (PROGN (LETT #1# (SPADCALL (QREFELT $ 136))) (GO #18#)))))
          #18# (EXIT #1#)))) 

(SDEFUN |FGRPH-;diagramSvg;SABV;50|
        ((|fileName| (|String|)) (|n| (A)) (|dispArrowName| (|Boolean|))
         ($ (|Void|)))
        (SPROG
         ((|sc| (|Scene| (|SCartesian| 2)))
          (|view| (|SBoundary| (|SCartesian| 2))))
         (SEQ
          (LETT |view|
                (SPADCALL (SPADCALL 0 0 (QREFELT $ 124))
                          (SPADCALL (+ (SPADCALL |n| (QREFELT $ 152)) 10)
                                    (+ (SPADCALL |n| (QREFELT $ 155)) 10)
                                    (QREFELT $ 124))
                          (QREFELT $ 157)))
          (LETT |sc| (SPADCALL |view| (QREFELT $ 158)))
          (SPADCALL |sc| |n| |dispArrowName| NIL (QREFELT $ 159))
          (EXIT (SPADCALL |sc| |fileName| (QREFELT $ 160)))))) 

(SDEFUN |FGRPH-;diagramsSvg;SLBV;51|
        ((|fileName| (|String|)) (|ln| (|List| A))
         (|dispArrowName| (|Boolean|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G1172 NIL) (|n| NIL) (|sc| (|Scene| (|SCartesian| 2)))
          (|view| (|SBoundary| (|SCartesian| 2))) (|dW| (|NonNegativeInteger|))
          (#2=#:G1171 NIL))
         (SEQ (LETT |dW| 0)
              (SEQ (LETT |n| NIL) (LETT #2# |ln|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |n| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |dW|
                           (+ (+ |dW| (SPADCALL |n| (QREFELT $ 152))) 10))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |view|
                    (SPADCALL (SPADCALL 0 0 (QREFELT $ 124))
                              (SPADCALL |dW|
                                        (+
                                         (SPADCALL (|SPADfirst| |ln|)
                                                   (QREFELT $ 155))
                                         10)
                                        (QREFELT $ 124))
                              (QREFELT $ 157)))
              (LETT |sc| (SPADCALL |view| (QREFELT $ 158)))
              (SEQ (LETT |n| NIL) (LETT #1# |ln|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |n| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |sc| |n| |dispArrowName| NIL (QREFELT $ 159))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |sc| |fileName| (QREFELT $ 160)))))) 

(SDEFUN |FGRPH-;deepDiagramSvg;SABV;52|
        ((|fileName| (|String|)) (|n| (A)) (|dispArrowName| (|Boolean|))
         ($ (|Void|)))
        (SPROG
         ((|sc| (|Scene| (|SCartesian| 2)))
          (|view| (|SBoundary| (|SCartesian| 2))))
         (SEQ
          (LETT |view|
                (SPADCALL (SPADCALL 0 0 (QREFELT $ 124))
                          (SPADCALL (+ (SPADCALL |n| (QREFELT $ 152)) 10)
                                    (+ (SPADCALL |n| (QREFELT $ 155)) 10)
                                    (QREFELT $ 124))
                          (QREFELT $ 157)))
          (LETT |sc| (SPADCALL |view| (QREFELT $ 158)))
          (SPADCALL |sc| |n| |dispArrowName| 'T (QREFELT $ 159))
          (EXIT (SPADCALL |sc| |fileName| (QREFELT $ 160)))))) 

(SDEFUN |FGRPH-;diagramWidth;ANni;53| ((|s| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|maxx| (|NonNegativeInteger|)) (#1=#:G1180 NIL) (|i| NIL)
          (|ls|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ (LETT |maxx| 0) (LETT |ls| (SPADCALL |s| (QREFELT $ 10)))
              (SEQ (LETT |i| NIL) (LETT #1# |ls|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> (QVELT |i| 1) |maxx|) (LETT |maxx| (QVELT |i| 1))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |maxx|)))) 

(SDEFUN |FGRPH-;diagramHeight;ANni;54| ((|s| (A)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|maxy| (|NonNegativeInteger|)) (#1=#:G1186 NIL) (|i| NIL)
          (|ls|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ (LETT |maxy| 0) (LETT |ls| (SPADCALL |s| (QREFELT $ 10)))
              (SEQ (LETT |i| NIL) (LETT #1# |ls|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> (QVELT |i| 2) |maxy|) (LETT |maxy| (QVELT |i| 2))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |maxy|)))) 

(SDEFUN |FGRPH-;looseEquals;2AB;55| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1200 NIL) (#2=#:G1201 NIL) (|i| NIL)
          (|ary|
           #3=(|List|
               (|Record| (|:| |name| (|String|))
                         (|:| |arrType| (|NonNegativeInteger|))
                         (|:| |fromOb| (|NonNegativeInteger|))
                         (|:| |toOb| (|NonNegativeInteger|))
                         (|:| |xOffset| (|Integer|))
                         (|:| |yOffset| (|Integer|))
                         (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|arx| #3#))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL (LENGTH (SPADCALL |x| (QREFELT $ 10)))
                        (LENGTH (SPADCALL |y| (QREFELT $ 10))) (QREFELT $ 100))
              (PROGN (LETT #1# NIL) (GO #4=#:G1199))))
            (LETT |arx| (SPADCALL |x| (QREFELT $ 22)))
            (LETT |ary| (SPADCALL |y| (QREFELT $ 22)))
            (COND
             ((SPADCALL (LENGTH |arx|) (LENGTH |ary|) (QREFELT $ 100))
              (PROGN (LETT #1# NIL) (GO #4#))))
            (SEQ (LETT |i| 1) (LETT #2# (LENGTH |arx|)) G190
                 (COND ((|greater_SI| |i| #2#) (GO G191)))
                 (SEQ
                  (COND
                   ((SPADCALL (QVELT (SPADCALL |arx| |i| (QREFELT $ 83)) 2)
                              (QVELT (SPADCALL |ary| |i| (QREFELT $ 83)) 2)
                              (QREFELT $ 100))
                    (PROGN (LETT #1# NIL) (GO #4#))))
                  (EXIT
                   (COND
                    ((SPADCALL (QVELT (SPADCALL |arx| |i| (QREFELT $ 83)) 3)
                               (QVELT (SPADCALL |ary| |i| (QREFELT $ 83)) 3)
                               (QREFELT $ 100))
                     (PROGN (LETT #1# NIL) (GO #4#))))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (EXIT 'T)))
          #4# (EXIT #1#)))) 

(PUT '|FGRPH-;hash;ASi;56| '|SPADreplace| '(XLAM (|s|) 0)) 

(SDEFUN |FGRPH-;hash;ASi;56| ((|s| (A)) ($ (|SingleInteger|))) 0) 

(SDEFUN |FGRPH-;latex;AS;57| ((|n| (A)) ($ (|String|)))
        (SPROG
         ((|fst| (|Boolean|)) (|s| (|String|)) (#1=#:G1216 NIL) (|arrow| NIL)
          (|arrStr| (|String|)) (#2=#:G1214 NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (#3=#:G1215 NIL) (|i| NIL)
          (|ls|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |s| "") (LETT |ls| (SPADCALL |n| (QREFELT $ 10)))
                (SEQ (LETT |i| NIL) (LETT #3# |ls|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |i| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((EQUAL |s| "")
                         (LETT |s| (SPADCALL (QVELT |i| 0) (QREFELT $ 169))))
                        ('T
                         (LETT |s|
                               (SPADCALL
                                (LIST |s| ","
                                      (SPADCALL (QVELT |i| 0) (QREFELT $ 169)))
                                (QREFELT $ 170)))))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (LETT |arrs| (SPADCALL |n| (QREFELT $ 22)))
                (COND
                 ((SPADCALL |arrs| NIL (QREFELT $ 134))
                  (PROGN (LETT #2# |s|) (GO #4=#:G1213))))
                (COND
                 ((SPADCALL |arrs| NIL (QREFELT $ 134))
                  (PROGN (LETT #2# |s|) (GO #4#))))
                (LETT |s| (SPADCALL (LIST |s| "|") (QREFELT $ 170)))
                (LETT |fst| 'T) (LETT |arrStr| "->")
                (SEQ (LETT |arrow| NIL) (LETT #1# |arrs|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |arrow| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (COND ((NULL |fst|) (LETT |s| (STRCONC |s| ","))))
                          (LETT |s|
                                (SPADCALL
                                 (LIST |s| (QVELT |arrow| 0) ":"
                                       (SPADCALL
                                        (QVELT
                                         (SPADCALL |ls| (QVELT |arrow| 2)
                                                   (QREFELT $ 171))
                                         0)
                                        (QREFELT $ 169))
                                       |arrStr|
                                       (SPADCALL
                                        (QVELT
                                         (SPADCALL |ls| (QVELT |arrow| 3)
                                                   (QREFELT $ 171))
                                         0)
                                        (QREFELT $ 169)))
                                 (QREFELT $ 170)))
                          (EXIT (LETT |fst| 'NIL)))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |s|)))
          #4# (EXIT #2#)))) 

(SDEFUN |FGRPH-;=;2AB;58| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (SPROG ((#1=#:G1225 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 10))
                              (SPADCALL |y| (QREFELT $ 10)) (QREFELT $ 173))
                    (PROGN (LETT #1# NIL) (GO #2=#:G1224))))
                  (COND
                   ((SPADCALL (SPADCALL |x| (QREFELT $ 22))
                              (SPADCALL |y| (QREFELT $ 22)) (QREFELT $ 174))
                    (PROGN (LETT #1# NIL) (GO #2#))))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |FGRPH-;~=;2AB;59| ((|x| (A)) (|y| (A)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| |y| (QREFELT $ 176)))) 

(SDEFUN |FGRPH-;coerceSubgraph| ((|n| (A)) ($ (|OutputForm|)))
        (SPROG
         ((|fst| (|Boolean|)) (|s| (|OutputForm|)) (|stTo| (|OutputForm|))
          (|stFrom| (|OutputForm|)) (#1=#:G1242 NIL) (|arrow| NIL)
          (|arrStr| (|OutputForm|)) (#2=#:G1240 NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|st| (|OutputForm|)) (#3=#:G1241 NIL) (|i| NIL)
          (|ls|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |s| (SPADCALL (QREFELT $ 179)))
                (LETT |ls| (SPADCALL |n| (QREFELT $ 10)))
                (SEQ (LETT |i| 1) (LETT #3# (LENGTH |ls|)) G190
                     (COND ((|greater_SI| |i| #3#) (GO G191)))
                     (SEQ (LETT |st| (SPADCALL |i| (QREFELT $ 180)))
                          (EXIT
                           (COND
                            ((SPADCALL |s| (SPADCALL (QREFELT $ 179))
                                       (QREFELT $ 181))
                             (LETT |s| |st|))
                            ('T
                             (LETT |s|
                                   (SPADCALL
                                    (LIST |s| (SPADCALL "," (QREFELT $ 182))
                                          |st|)
                                    (QREFELT $ 183)))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (LETT |arrs| (SPADCALL |n| (QREFELT $ 22)))
                (COND
                 ((SPADCALL |arrs| NIL (QREFELT $ 134))
                  (PROGN (LETT #2# |s|) (GO #4=#:G1239))))
                (COND
                 ((SPADCALL |arrs| NIL (QREFELT $ 134))
                  (PROGN (LETT #2# |s|) (GO #4#))))
                (LETT |s|
                      (SPADCALL (LIST |s| (SPADCALL "|" (QREFELT $ 182)))
                                (QREFELT $ 183)))
                (LETT |fst| 'T) (LETT |arrStr| (SPADCALL "->" (QREFELT $ 182)))
                (SEQ (LETT |arrow| NIL) (LETT #1# |arrs|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |arrow| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |stFrom|
                            (SPADCALL (QVELT |arrow| 2) (QREFELT $ 180)))
                      (LETT |stTo|
                            (SPADCALL (QVELT |arrow| 3) (QREFELT $ 180)))
                      (COND
                       ((NULL |fst|)
                        (LETT |s|
                              (SPADCALL |s| (SPADCALL "," (QREFELT $ 182))
                                        (QREFELT $ 184)))))
                      (LETT |s|
                            (SPADCALL
                             (LIST |s|
                                   (SPADCALL (QVELT |arrow| 0) (QREFELT $ 185))
                                   (SPADCALL ":" (QREFELT $ 182)) |stFrom|
                                   |arrStr| |stTo|)
                             (QREFELT $ 183)))
                      (EXIT (LETT |fst| 'NIL)))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |s|)))
          #4# (EXIT #2#)))) 

(SDEFUN |FGRPH-;coerce;AOf;61| ((|n| (A)) ($ (|OutputForm|)))
        (SPROG
         ((|fst| (|Boolean|)) (|s| (|OutputForm|)) (|stTo| (|OutputForm|))
          (|stFrom| (|OutputForm|)) (#1=#:G1257 NIL) (|arrow| NIL)
          (|arrStr| (|OutputForm|)) (#2=#:G1255 NIL)
          (|arrs|
           (|List|
            (|Record| (|:| |name| (|String|))
                      (|:| |arrType| (|NonNegativeInteger|))
                      (|:| |fromOb| (|NonNegativeInteger|))
                      (|:| |toOb| (|NonNegativeInteger|))
                      (|:| |xOffset| (|Integer|)) (|:| |yOffset| (|Integer|))
                      (|:| |map| (|List| (|NonNegativeInteger|))))))
          (|st| (|OutputForm|)) (#3=#:G1256 NIL) (|i| NIL)
          (|ls|
           (|List|
            (|Record| (|:| |value| S) (|:| |posX| (|NonNegativeInteger|))
                      (|:| |posY| (|NonNegativeInteger|))))))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((EQUAL (QREFELT $ 7) (|DirectedGraph| (|String|)))
              (PROGN
               (LETT #2# (|FGRPH-;coerceSubgraph| |n| $))
               (GO #4=#:G1254))))
            (LETT |s| (SPADCALL (QREFELT $ 179)))
            (LETT |ls| (SPADCALL |n| (QREFELT $ 10)))
            (SEQ (LETT |i| NIL) (LETT #3# |ls|) G190
                 (COND
                  ((OR (ATOM #3#) (PROGN (LETT |i| (CAR #3#)) NIL)) (GO G191)))
                 (SEQ (LETT |st| (SPADCALL (QVELT |i| 0) (QREFELT $ 186)))
                      (EXIT
                       (COND
                        ((SPADCALL |s| (SPADCALL (QREFELT $ 179))
                                   (QREFELT $ 181))
                         (LETT |s| |st|))
                        ('T
                         (LETT |s|
                               (SPADCALL
                                (LIST |s| (SPADCALL "," (QREFELT $ 182)) |st|)
                                (QREFELT $ 183)))))))
                 (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
            (LETT |arrs| (SPADCALL |n| (QREFELT $ 22)))
            (COND
             ((SPADCALL |arrs| NIL (QREFELT $ 134))
              (PROGN (LETT #2# |s|) (GO #4#))))
            (COND
             ((SPADCALL |arrs| NIL (QREFELT $ 134))
              (PROGN (LETT #2# |s|) (GO #4#))))
            (LETT |s|
                  (SPADCALL (LIST |s| (SPADCALL "|" (QREFELT $ 182)))
                            (QREFELT $ 183)))
            (LETT |fst| 'T) (LETT |arrStr| (SPADCALL "->" (QREFELT $ 182)))
            (SEQ (LETT |arrow| NIL) (LETT #1# |arrs|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |arrow| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (LETT |stFrom|
                        (SPADCALL
                         (QVELT
                          (SPADCALL |ls| (QVELT |arrow| 2) (QREFELT $ 171)) 0)
                         (QREFELT $ 186)))
                  (LETT |stTo|
                        (SPADCALL
                         (QVELT
                          (SPADCALL |ls| (QVELT |arrow| 3) (QREFELT $ 171)) 0)
                         (QREFELT $ 186)))
                  (COND
                   ((NULL |fst|)
                    (LETT |s|
                          (SPADCALL |s| (SPADCALL "," (QREFELT $ 182))
                                    (QREFELT $ 184)))))
                  (LETT |s|
                        (SPADCALL
                         (LIST |s| (SPADCALL (QVELT |arrow| 0) (QREFELT $ 185))
                               (SPADCALL ":" (QREFELT $ 182)) |stFrom| |arrStr|
                               |stTo|)
                         (QREFELT $ 183)))
                  (EXIT (LETT |fst| 'NIL)))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
            (EXIT |s|)))
          #4# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |FiniteGraph&;|)) 

(DEFUN |FiniteGraph&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FiniteGraph&| DV$1 DV$2))
          (LETT $ (GETREFV 188))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FiniteGraph&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Record| (|:| |value| 7) (|:| |posX| 13) (|:| |posY| 13))
              (|List| 8) (0 . |getVertices|) (|Boolean|) (5 . =)
              (|NonNegativeInteger|) |FGRPH-;getVertexIndex;ASNni;1|
              (11 . |getVertexIndex|) (|String|) (17 . |addArrow!|)
              |FGRPH-;addArrow!;AS2SA;2| |FGRPH-;isDirected?;B;3|
              (|Record| (|:| |name| 16) (|:| |arrType| 13) (|:| |fromOb| 13)
                        (|:| |toOb| 13) (|:| |xOffset| 26) (|:| |yOffset| 26)
                        (|:| |map| 40))
              (|List| 20) (25 . |getArrows|) (|Matrix| 26) (30 . |zero|)
              (36 . |isDirected?|) (|Integer|) (40 . |setelt!|)
              |FGRPH-;incidenceMatrix;AM;4| (48 . |isDirectSuccessor?|)
              (|List| 40) (|Matrix| 13) (55 . |matrix|)
              |FGRPH-;adjacencyMatrix;AM;5| (60 . |inDegree|)
              (|List| (|List| 26)) (66 . |matrix|)
              |FGRPH-;laplacianMatrix;AM;7| (71 . |distance|)
              |FGRPH-;distanceMatrix;AM;8| (|List| 13) (78 . |arrowsToArrow|)
              (|Reference| 40) (84 . |deref|) (89 . |entry?|) (|Tree| 26)
              (95 . |tree|) (|List| 45) (100 . |concat|) (106 . |concat|)
              (112 . |setref|) (|List| $) (118 . |tree|) (124 . |ref|)
              |FGRPH-;spanningTreeArrow;ANniT;10| (129 . |spanningTreeArrow|)
              |FGRPH-;spanningForestArrow;AL;11| (135 . |nodeToNode|)
              (|List| 11) (141 . |concat|) |FGRPH-;spanningTreeNode;ANniT;13|
              (147 . |spanningTreeNode|) |FGRPH-;spanningForestNode;AL;14|
              (153 . |children|) (158 . |value|) (163 . |position|) (|Loop|)
              (169 . |loop|) (174 . |#|) (179 . |last|) (|List| 66)
              (185 . |concat|) (191 . |spanningForestNode|)
              (196 . |removeDuplicates|) |FGRPH-;loopsNodes;AL;16|
              |FGRPH-;loopsAtNode;ANniL;17| (201 . |spanningForestArrow|)
              |FGRPH-;loopsArrows;AL;19| (206 . |loopsNodes|) (211 . =)
              |FGRPH-;isAcyclic?;AB;20| |FGRPH-;isDirectSuccessor?;A2NniB;21|
              |FGRPH-;isFixPoint?;ANniB;22| (217 . |elt|)
              |FGRPH-;getArrowIndex;A3Nni;23| |FGRPH-;arrowName;A2NniS;24|
              |FGRPH-;inDegree;A2Nni;25| |FGRPH-;outDegree;A2Nni;26|
              |FGRPH-;nodeFromNode;ANniL;27| |FGRPH-;nodeToNode;ANniL;28|
              |FGRPH-;arrowsFromNode;ANniL;29| |FGRPH-;arrowsToNode;ANniL;30|
              |FGRPH-;nodeFromArrow;ANniL;31| |FGRPH-;nodeToArrow;ANniL;32|
              |FGRPH-;arrowsFromArrow;ANniL;33| |FGRPH-;arrowsToArrow;ANniL;34|
              (223 . =) (229 . ~=) |FGRPH-;routeNodes;A2NniL;36|
              (235 . |getArrowIndex|) (242 . ~=) |FGRPH-;routeArrows;A2NniL;38|
              |FGRPH-;isGreaterThan?;A2NniB;39| (248 . |isGreaterThan?|)
              |FGRPH-;max;ANni;40| |FGRPH-;max;ALNni;41| |FGRPH-;min;ANni;42|
              |FGRPH-;min;ALNni;43| |FGRPH-;distance;A2NniI;44| (255 . |elt|)
              (261 . |setelt!|) |FGRPH-;isFunctional?;AB;45|
              |FGRPH-;createWidth;2Nni;46| (268 . |createWidth|)
              (|Union| $ '"failed") (273 . |subtractIfCan|)
              |FGRPH-;createX;3Nni;47| |FGRPH-;createY;3Nni;48| (|DoubleFloat|)
              (|Scene| 123) (279 . |addSceneMaterial|) (|List| 7)
              (287 . |concat|) (|SCartesian| '2) (293 . |sipnt|) (299 . |svec|)
              (305 . +)
              (|Record| (|:| |shptype| 149) (|:| |centre| 123) (|:| |size| 123)
                        (|:| |fill| 11))
              (311 . |addSceneShape|) (|DirectedGraph| 16)
              (317 . |addSceneGraph|) (|List| 119) (326 . |concat|)
              (332 . |addSceneText|) (340 . =) (|Void|) (346 . |void|)
              (|Record| (|:| |value| 16) (|:| |posX| 13) (|:| |posY| 13))
              (|List| 137) (350 . |getVertices|)
              (|Record| (|:| |value| 129) (|:| |posX| 13) (|:| |posY| 13))
              (|List| 140) (|List| 141) (355 . |concat|) (361 . |arrowsToNode|)
              (367 . |elt|) (373 . |elt|) (379 . |spnt|) (|List| (|List| 123))
              (|Symbol|) (385 . |addSceneArrows|) (393 . |elt|)
              (399 . |diagramWidth|) (404 . |addSceneArrow|)
              |FGRPH-;subdiagramSvg;SA2BV;49| (415 . |diagramHeight|)
              (|SBoundary| 123) (420 . |boxBoundary|) (426 . |createSceneRoot|)
              (431 . |subdiagramSvg|) (439 . |writeSvg|)
              |FGRPH-;diagramSvg;SABV;50| |FGRPH-;diagramsSvg;SLBV;51|
              |FGRPH-;deepDiagramSvg;SABV;52| |FGRPH-;diagramWidth;ANni;53|
              |FGRPH-;diagramHeight;ANni;54| |FGRPH-;looseEquals;2AB;55|
              (|SingleInteger|) |FGRPH-;hash;ASi;56| (445 . |latex|)
              (450 . |concat|) (455 . |elt|) |FGRPH-;latex;AS;57| (461 . ~=)
              (467 . ~=) |FGRPH-;=;2AB;58| (473 . =) |FGRPH-;~=;2AB;59|
              (|OutputForm|) (479 . |empty|) (483 . |coerce|) (488 . =)
              (494 . |message|) (499 . |hconcat|) (504 . |hconcat|)
              (510 . |coerce|) (515 . |coerce|) |FGRPH-;coerce;AOf;61|)
           '#(~= 520 |subdiagramSvg| 526 |spanningTreeNode| 534
              |spanningTreeArrow| 540 |spanningForestNode| 546
              |spanningForestArrow| 551 |routeNodes| 556 |routeArrows| 563
              |outDegree| 570 |nodeToNode| 576 |nodeToArrow| 582 |nodeFromNode|
              588 |nodeFromArrow| 594 |min| 600 |max| 611 |looseEquals| 622
              |loopsNodes| 628 |loopsAtNode| 633 |loopsArrows| 639 |latex| 644
              |laplacianMatrix| 649 |isGreaterThan?| 654 |isFunctional?| 661
              |isFixPoint?| 666 |isDirected?| 672 |isDirectSuccessor?| 676
              |isAcyclic?| 683 |incidenceMatrix| 688 |inDegree| 693 |hash| 699
              |getVertexIndex| 704 |getArrowIndex| 710 |distanceMatrix| 717
              |distance| 722 |diagramsSvg| 729 |diagramWidth| 736 |diagramSvg|
              741 |diagramHeight| 748 |deepDiagramSvg| 753 |createY| 760
              |createX| 766 |createWidth| 772 |coerce| 777 |arrowsToNode| 782
              |arrowsToArrow| 788 |arrowsFromNode| 794 |arrowsFromArrow| 800
              |arrowName| 806 |adjacencyMatrix| 813 |addArrow!| 818 = 826)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|looseEquals| ((|Boolean|) |#1| |#1|)) T)
                                   '((|createY|
                                      ((|NonNegativeInteger|)
                                       (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|createX|
                                      ((|NonNegativeInteger|)
                                       (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|createWidth|
                                      ((|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|diagramHeight|
                                      ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((|diagramWidth|
                                      ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((|deepDiagramSvg|
                                      ((|Void|) (|String|) |#1| (|Boolean|)))
                                     T)
                                   '((|diagramsSvg|
                                      ((|Void|) (|String|) (|List| |#1|)
                                       (|Boolean|)))
                                     T)
                                   '((|diagramSvg|
                                      ((|Void|) (|String|) |#1| (|Boolean|)))
                                     T)
                                   '((|subdiagramSvg|
                                      ((|Void|) (|Scene| (|SCartesian| 2)) |#1|
                                       (|Boolean|) (|Boolean|)))
                                     T)
                                   '((|isDirected?| ((|Boolean|))) T)
                                   '((|isFunctional?| ((|Boolean|) |#1|)) T)
                                   '((|distanceMatrix|
                                      ((|Matrix| (|Integer|)) |#1|))
                                     T)
                                   '((|laplacianMatrix|
                                      ((|Matrix| (|Integer|)) |#1|))
                                     T)
                                   '((|adjacencyMatrix|
                                      ((|Matrix| (|NonNegativeInteger|)) |#1|))
                                     T)
                                   '((|incidenceMatrix|
                                      ((|Matrix| (|Integer|)) |#1|))
                                     T)
                                   '((|isAcyclic?| ((|Boolean|) |#1|)) T)
                                   '((|loopsArrows| ((|List| (|Loop|)) |#1|))
                                     T)
                                   '((|loopsAtNode|
                                      ((|List| (|Loop|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|loopsNodes| ((|List| (|Loop|)) |#1|)) T)
                                   '((|spanningForestNode|
                                      ((|List| (|Tree| (|Integer|))) |#1|))
                                     T)
                                   '((|spanningTreeNode|
                                      ((|Tree| (|Integer|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|spanningForestArrow|
                                      ((|List| (|Tree| (|Integer|))) |#1|))
                                     T)
                                   '((|spanningTreeArrow|
                                      ((|Tree| (|Integer|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|distance|
                                      ((|Integer|) |#1| (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|routeArrows|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|routeNodes|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|arrowsToArrow|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|arrowsFromArrow|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|nodeToArrow|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|nodeFromArrow|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|arrowsToNode|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|arrowsFromNode|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|nodeToNode|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|nodeFromNode|
                                      ((|List| (|NonNegativeInteger|)) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|outDegree|
                                      ((|NonNegativeInteger|) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|inDegree|
                                      ((|NonNegativeInteger|) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|getArrowIndex|
                                      ((|NonNegativeInteger|) |#1|
                                       (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|arrowName|
                                      ((|String|) |#1| (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|isFixPoint?|
                                      ((|Boolean|) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|min|
                                      ((|NonNegativeInteger|) |#1|
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|min| ((|NonNegativeInteger|) |#1|)) T)
                                   '((|max|
                                      ((|NonNegativeInteger|) |#1|
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|max| ((|NonNegativeInteger|) |#1|)) T)
                                   '((|isGreaterThan?|
                                      ((|Boolean|) |#1| (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|isDirectSuccessor?|
                                      ((|Boolean|) |#1| (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|getVertexIndex|
                                      ((|NonNegativeInteger|) |#1| |#2|))
                                     T)
                                   '((|addArrow!|
                                      (|#1| |#1| (|String|) |#2| |#2|))
                                     T)
                                   '((|addArrow!|
                                      (|#1| |#1| (|String|)
                                       (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|addArrow!|
                                      (|#1| |#1| (|String|)
                                       (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|addArrow!|
                                      (|#1| |#1|
                                       (|Record| (|:| |name| (|String|))
                                                 (|:| |arrType|
                                                      (|NonNegativeInteger|))
                                                 (|:| |fromOb|
                                                      (|NonNegativeInteger|))
                                                 (|:| |toOb|
                                                      (|NonNegativeInteger|))
                                                 (|:| |xOffset| (|Integer|))
                                                 (|:| |yOffset| (|Integer|))
                                                 (|:| |map|
                                                      (|List|
                                                       (|NonNegativeInteger|))))))
                                     T)
                                   '((|latex| ((|String|) |#1|)) T)
                                   '((|hash| ((|SingleInteger|) |#1|)) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((= ((|Boolean|) |#1| |#1|)) T)
                                   '((~= ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 187
                                            '(1 6 9 0 10 2 7 11 0 0 12 2 6 13 0
                                              7 15 4 6 0 0 16 13 13 17 1 6 21 0
                                              22 2 23 0 13 13 24 0 6 11 25 4 23
                                              26 0 26 26 26 27 3 6 11 0 13 13
                                              29 1 31 0 30 32 2 6 13 0 13 34 1
                                              23 0 35 36 3 6 26 0 13 13 38 2 6
                                              40 0 13 41 1 42 40 0 43 2 40 11
                                              13 0 44 1 45 0 26 46 2 47 0 0 45
                                              48 2 40 0 0 13 49 2 42 40 0 40 50
                                              2 45 0 26 51 52 1 42 0 40 53 2 6
                                              45 0 13 55 2 6 40 0 13 57 2 58 0
                                              0 11 59 2 6 45 0 13 61 1 45 51 0
                                              63 1 45 26 0 64 2 40 26 13 0 65 1
                                              66 0 40 67 1 40 13 0 68 2 40 0 0
                                              13 69 2 70 0 0 0 71 1 6 47 0 72 1
                                              70 0 0 73 1 6 47 0 76 1 6 70 0 78
                                              2 70 11 0 0 79 2 21 20 0 26 83 2
                                              40 11 0 0 96 2 40 11 0 0 97 3 6
                                              13 0 13 13 99 2 13 11 0 0 100 3 6
                                              11 0 13 13 103 2 40 13 0 26 109 3
                                              40 13 0 26 13 110 1 6 13 13 113 2
                                              13 114 0 0 115 4 119 0 0 118 16
                                              16 120 2 121 0 0 7 122 2 123 0 26
                                              26 124 2 123 0 118 118 125 2 123
                                              0 0 0 126 2 119 0 0 127 128 5 119
                                              0 0 129 13 13 11 130 2 131 0 0
                                              119 132 4 119 0 0 16 13 123 133 2
                                              21 11 0 0 134 0 135 0 136 1 129
                                              138 0 139 2 142 0 0 141 143 2 6
                                              40 0 13 144 2 142 141 0 26 145 2
                                              141 140 0 26 146 2 123 0 118 118
                                              147 4 119 0 0 148 149 118 150 2
                                              131 119 0 26 151 1 6 13 0 152 7
                                              119 0 0 0 0 123 149 118 118 153 1
                                              6 13 0 155 2 156 0 123 123 157 1
                                              119 0 156 158 4 6 135 119 0 11 11
                                              159 2 119 135 0 16 160 1 7 16 0
                                              169 1 16 0 51 170 2 9 8 0 26 171
                                              2 9 11 0 0 173 2 21 11 0 0 174 2
                                              6 11 0 0 176 0 178 0 179 1 13 178
                                              0 180 2 178 11 0 0 181 1 178 0 16
                                              182 1 178 0 51 183 2 178 0 0 0
                                              184 1 16 178 0 185 1 7 178 0 186
                                              2 0 11 0 0 177 4 0 135 119 0 11
                                              11 154 2 0 45 0 13 60 2 0 45 0 13
                                              54 1 0 47 0 62 1 0 47 0 56 3 0 40
                                              0 13 13 98 3 0 40 0 13 13 101 2 0
                                              13 0 13 87 2 0 40 0 13 89 2 0 40
                                              0 13 93 2 0 40 0 13 88 2 0 40 0
                                              13 92 1 0 13 0 106 2 0 13 0 40
                                              107 2 0 13 0 40 105 1 0 13 0 104
                                              2 0 11 0 0 166 1 0 70 0 74 2 0 70
                                              0 13 75 1 0 70 0 77 1 0 16 0 172
                                              1 0 23 0 37 3 0 11 0 13 13 102 1
                                              0 11 0 111 2 0 11 0 13 82 0 0 11
                                              19 3 0 11 0 13 13 81 1 0 11 0 80
                                              1 0 23 0 28 2 0 13 0 13 86 1 0
                                              167 0 168 2 0 13 0 7 14 3 0 13 0
                                              13 13 84 1 0 23 0 39 3 0 26 0 13
                                              13 108 3 0 135 16 51 11 162 1 0
                                              13 0 164 3 0 135 16 0 11 161 1 0
                                              13 0 165 3 0 135 16 0 11 163 2 0
                                              13 13 13 117 2 0 13 13 13 116 1 0
                                              13 13 112 1 0 178 0 187 2 0 40 0
                                              13 91 2 0 40 0 13 95 2 0 40 0 13
                                              90 2 0 40 0 13 94 3 0 16 0 13 13
                                              85 1 0 31 0 33 4 0 0 0 16 7 7 18
                                              2 0 11 0 0 175)))))
           '|lookupComplete|)) 


(SDEFUN |PERM;smallerElement?| ((|a| (S)) (|b| (S)) ($ (|Boolean|)))
        (COND
         ((|HasCategory| (QREFELT $ 6) '(|OrderedSet|))
          (SPADCALL |a| |b| (QREFELT $ 9)))
         ((|HasCategory| (QREFELT $ 6) '(|Finite|))
          (< (SPADCALL |a| (QREFELT $ 11)) (SPADCALL |b| (QREFELT $ 11))))
         ('T NIL))) 

(SDEFUN |PERM;rotateCycle| ((|cyc| (|List| S)) ($ (|List| S)))
        (SPROG
         ((#1=#:G742 NIL) (#2=#:G741 NIL) (|minpos| (|Integer|)) (|min| (S))
          (#3=#:G745 NIL) (|i| NIL))
         (SEQ (LETT |min| (|SPADfirst| |cyc|)) (LETT |minpos| 1)
              (SEQ (LETT |i| 2) (LETT #3# (LENGTH |cyc|)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((|PERM;smallerElement?|
                        (SPADCALL |cyc| |i| (QREFELT $ 14)) |min| $)
                       (SEQ (LETT |min| (SPADCALL |cyc| |i| (QREFELT $ 14)))
                            (EXIT (LETT |minpos| |i|)))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND ((EQL |minpos| 1) |cyc|)
                     ('T
                      (SPADCALL
                       (SPADCALL |cyc|
                                 (PROG1
                                     (LETT #2#
                                           (+ (- (LENGTH |cyc|) |minpos|) 1))
                                   (|check_subtype2| (>= #2# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #2#))
                                 (QREFELT $ 17))
                       (SPADCALL |cyc|
                                 (PROG1 (LETT #1# (- |minpos| 1))
                                   (|check_subtype2| (>= #1# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #1#))
                                 (QREFELT $ 18))
                       (QREFELT $ 19)))))))) 

(SDEFUN |PERM;coerceCycle| ((|lls| (|List| (|List| S))) ($ ($)))
        (SPROG ((|perm| ($)) (#1=#:G750 NIL) (|lists| NIL))
               (SEQ (LETT |perm| (|spadConstant| $ 15))
                    (SEQ (LETT |lists| NIL) (LETT #1# (REVERSE |lls|)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |lists| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |perm|
                                 (SPADCALL (SPADCALL |lists| (QREFELT $ 20))
                                           |perm| (QREFELT $ 21)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |perm|)))) 

(SDEFUN |PERM;smallerCycle?|
        ((|cyca| (|List| S)) (|cycb| (|List| S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G757 NIL) (#2=#:G758 NIL) (#3=#:G759 NIL) (|i| NIL)
          (#4=#:G760 NIL) (|j| NIL))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LENGTH |cyca|) (LENGTH |cycb|) (QREFELT $ 22))
             (< (LENGTH |cyca|) (LENGTH |cycb|)))
            ('T
             (SEQ
              (SEQ
               (EXIT
                (SEQ (LETT |j| NIL) (LETT #4# |cycb|) (LETT |i| NIL)
                     (LETT #3# |cyca|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |i| (CAR #3#)) NIL)
                           (ATOM #4#) (PROGN (LETT |j| (CAR #4#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |i| |j| (QREFELT $ 23))
                         (PROGN
                          (LETT #1#
                                (PROGN
                                 (LETT #2# (|PERM;smallerElement?| |i| |j| $))
                                 (GO #5=#:G756)))
                          (GO #6=#:G753))))))
                     (LETT #3# (PROG1 (CDR #3#) (LETT #4# (CDR #4#))))
                     (GO G190) G191 (EXIT NIL)))
               #6# (EXIT #1#))
              (EXIT NIL)))))
          #5# (EXIT #2#)))) 

(SDEFUN |PERM;shorterCycle?|
        ((|cyca| (|List| S)) (|cycb| (|List| S)) ($ (|Boolean|)))
        (< (LENGTH |cyca|) (LENGTH |cycb|))) 

(SDEFUN |PERM;permord|
        ((|pa| (|Record| (|:| |cycl| (|List| (|List| S))) (|:| |permut| $)))
         (|pb| (|Record| (|:| |cycl| (|List| (|List| S))) (|:| |permut| $)))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G768 NIL) (#2=#:G769 NIL) (#3=#:G770 NIL) (|i| NIL)
          (#4=#:G771 NIL) (|j| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (EXIT
              (SEQ (LETT |j| NIL) (LETT #4# (QCAR |pb|)) (LETT |i| NIL)
                   (LETT #3# (QCAR |pa|)) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |i| (CAR #3#)) NIL) (ATOM #4#)
                         (PROGN (LETT |j| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |i| |j| (QREFELT $ 24))
                       (PROGN
                        (LETT #1#
                              (PROGN
                               (LETT #2# (|PERM;smallerCycle?| |i| |j| $))
                               (GO #5=#:G767)))
                        (GO #6=#:G765))))))
                   (LETT #3# (PROG1 (CDR #3#) (LETT #4# (CDR #4#)))) (GO G190)
                   G191 (EXIT NIL)))
             #6# (EXIT #1#))
            (EXIT (< (LENGTH (QCAR |pa|)) (LENGTH (QCAR |pb|))))))
          #5# (EXIT #2#)))) 

(SDEFUN |PERM;coerceToCycle|
        ((|p| ($)) (|doSorting?| (|Boolean|)) ($ (|List| (|List| S))))
        (SPROG
         ((|cycles| (|List| (|List| S))) (|nextCycle| (|List| S))
          (|im| #1=(|List| S)) (|nextEltInCycle| (S)) (|preim| #1#)
          (|i| (|Integer|)) (|firstEltInCycle| (S)))
         (SEQ (LETT |preim| (SPADCALL |p| 1 (QREFELT $ 25)))
              (LETT |im| (SPADCALL |p| 2 (QREFELT $ 25))) (LETT |cycles| NIL)
              (SEQ G190 (COND ((NULL (NULL (NULL |preim|))) (GO G191)))
                   (SEQ (LETT |firstEltInCycle| (|SPADfirst| |preim|))
                        (LETT |nextCycle|
                              (SPADCALL |firstEltInCycle| (QREFELT $ 26)))
                        (LETT |preim| (CDR |preim|))
                        (LETT |nextEltInCycle| (|SPADfirst| |im|))
                        (LETT |im| (CDR |im|))
                        (SEQ G190
                             (COND
                              ((NULL
                                (SPADCALL |nextEltInCycle| |firstEltInCycle|
                                          (QREFELT $ 23)))
                               (GO G191)))
                             (SEQ
                              (LETT |nextCycle|
                                    (CONS |nextEltInCycle| |nextCycle|))
                              (LETT |i|
                                    (SPADCALL |nextEltInCycle| |preim|
                                              (QREFELT $ 27)))
                              (LETT |preim|
                                    (SPADCALL |preim| |i| (QREFELT $ 28)))
                              (LETT |nextEltInCycle|
                                    (SPADCALL |im| |i| (QREFELT $ 14)))
                              (EXIT
                               (LETT |im| (SPADCALL |im| |i| (QREFELT $ 28)))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (LETT |nextCycle| (REVERSE |nextCycle|))
                        (EXIT
                         (COND
                          ((NULL (NULL (CDR |nextCycle|)))
                           (SEQ
                            (COND
                             (|doSorting?|
                              (COND
                               ((OR
                                 (|HasCategory| (QREFELT $ 6) '(|OrderedSet|))
                                 (|HasCategory| (QREFELT $ 6) '(|Finite|)))
                                (LETT |nextCycle|
                                      (|PERM;rotateCycle| |nextCycle| $))))))
                            (EXIT
                             (LETT |cycles| (CONS |nextCycle| |cycles|))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                (|doSorting?|
                 (COND
                  ((OR (|HasCategory| (QREFELT $ 6) '(|OrderedSet|))
                       (|HasCategory| (QREFELT $ 6) '(|Finite|)))
                   (SPADCALL (CONS (|function| |PERM;smallerCycle?|) $)
                             |cycles| (QREFELT $ 31)))
                  ('T
                   (SPADCALL (CONS (|function| |PERM;shorterCycle?|) $)
                             |cycles| (QREFELT $ 31)))))
                ('T |cycles|)))))) 

(SDEFUN |PERM;duplicates?| ((|ls| (|List| S)) ($ (|Boolean|)))
        (SPROG ((|x| (|List| S)) (#1=#:G796 NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |x| (SPADCALL |ls| (QREFELT $ 32)))
                      (SEQ G190 (COND ((NULL (NULL (NULL |x|))) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL (|SPADfirst| |x|) (CDR |x|)
                                         (QREFELT $ 33))
                               (PROGN (LETT #1# 'T) (GO #2=#:G795)))
                              ('T (LETT |x| (CDR |x|))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |PERM;listRepresentation;$R;9|
        ((|p| ($))
         ($
          #1=(|Record| (|:| |preimage| (|List| S)) (|:| |image| (|List| S)))))
        (SPROG ((|s| #1#))
               (LETT |s|
                     (CONS (SPADCALL |p| 1 (QREFELT $ 25))
                           (SPADCALL |p| 2 (QREFELT $ 25)))))) 

(SDEFUN |PERM;coercePreimagesImages;L$;10|
        ((|preImageAndImage| (|List| (|List| S))) ($ ($)))
        (SPROG
         ((|image| (|List| S)) (|preImage| (|List| S)) (#1=#:G806 NIL)
          (|i| NIL) (#2=#:G807 NIL) (|pi| NIL))
         (SEQ (LETT |preImage| NIL) (LETT |image| NIL)
              (SEQ (LETT |pi| NIL)
                   (LETT #2# (SPADCALL |preImageAndImage| 2 (QREFELT $ 36)))
                   (LETT |i| NIL)
                   (LETT #1# (SPADCALL |preImageAndImage| 1 (QREFELT $ 36)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL) (ATOM #2#)
                         (PROGN (LETT |pi| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |i| |pi| (QREFELT $ 23))
                       (SEQ (LETT |preImage| (CONS |i| |preImage|))
                            (EXIT (LETT |image| (CONS |pi| |image|))))))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT (VECTOR |preImage| |image|))))) 

(SDEFUN |PERM;movedPoints;$S;11| ((|p| ($)) ($ (|Set| S)))
        (SPADCALL (SPADCALL |p| 1 (QREFELT $ 25)) (QREFELT $ 39))) 

(SDEFUN |PERM;degree;$Nni;12| ((|p| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 40)) (QREFELT $ 41))) 

(SDEFUN |PERM;=;2$B;13| ((|p| ($)) (|q| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G819 NIL) (#2=#:G820 NIL) (|pos| (|Integer|)) (#3=#:G821 NIL)
          (|i| NIL) (|preimq| #4=(|List| S)) (|preimp| #4#))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LENGTH (LETT |preimp| (SPADCALL |p| 1 (QREFELT $ 25))))
                       (LENGTH (LETT |preimq| (SPADCALL |q| 1 (QREFELT $ 25))))
                       (QREFELT $ 22))
             NIL)
            ('T
             (SEQ
              (SEQ (LETT |i| 1) (LETT #3# (LENGTH |preimp|)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (LETT |pos|
                          (SPADCALL (SPADCALL |preimp| |i| (QREFELT $ 14))
                                    |preimq| (QREFELT $ 27)))
                    (EXIT
                     (COND
                      ((EQL |pos| 0) (PROGN (LETT #2# NIL) (GO #5=#:G818)))
                      ('T
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL
                            (SPADCALL (SPADCALL |p| 2 (QREFELT $ 25)) |i|
                                      (QREFELT $ 14))
                            (SPADCALL (SPADCALL |q| 2 (QREFELT $ 25)) |pos|
                                      (QREFELT $ 14))
                            (QREFELT $ 23))
                           (PROGN
                            (LETT #1# (PROGN (LETT #2# NIL) (GO #5#)))
                            (GO #6=#:G813)))))
                        #6# (EXIT #1#))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT 'T)))))
          #5# (EXIT #2#)))) 

(SDEFUN |PERM;orbit;$SS;14| ((|p| ($)) (|el| (S)) ($ (|Set| S)))
        (SPROG ((|el2| (S)) (|out| (|Set| S)))
               (SEQ
                (LETT |out|
                      (SPADCALL (SPADCALL |el| (QREFELT $ 26)) (QREFELT $ 44)))
                (LETT |el2| (SPADCALL |p| |el| (QREFELT $ 45)))
                (SEQ G190
                     (COND
                      ((NULL (SPADCALL |el2| |el| (QREFELT $ 23))) (GO G191)))
                     (SEQ (SPADCALL |el2| |out| (QREFELT $ 46))
                          (EXIT
                           (LETT |el2| (SPADCALL |p| |el2| (QREFELT $ 45)))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT |out|)))) 

(SDEFUN |PERM;cyclePartition;$P;15| ((|p| ($)) ($ (|Partition|)))
        (SPROG ((#1=#:G831 NIL) (|c| NIL) (#2=#:G830 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |c| NIL)
                       (LETT #1# (|PERM;coerceToCycle| |p| NIL $)) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ (EXIT (LETT #2# (CONS (LENGTH |c|) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 50))))) 

(SDEFUN |PERM;order;$Nni;16| ((|p| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G832 NIL) (|ord| (|Integer|)))
               (SEQ
                (LETT |ord|
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (SPADCALL |p| (QREFELT $ 51)) (QREFELT $ 52))
                        (QREFELT $ 53))
                       (QREFELT $ 55)))
                (EXIT
                 (PROG1 (LETT #1# |ord|)
                   (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #1#)))))) 

(SDEFUN |PERM;sign;$I;17| ((|p| ($)) ($ (|Integer|)))
        (COND ((SPADCALL |p| (QREFELT $ 57)) 1) ('T -1))) 

(SDEFUN |PERM;even?;$B;18| ((|p| ($)) ($ (|Boolean|)))
        (EVENP
         (- (LENGTH (SPADCALL |p| 1 (QREFELT $ 25)))
            (SPADCALL |p| (QREFELT $ 59))))) 

(SDEFUN |PERM;odd?;$B;19| ((|p| ($)) ($ (|Boolean|)))
        (ODDP
         (- (LENGTH (SPADCALL |p| 1 (QREFELT $ 25)))
            (SPADCALL |p| (QREFELT $ 59))))) 

(SDEFUN |PERM;<;2$B;20| ((|pa| ($)) (|pb| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G844 NIL) (#2=#:G845 NIL) (#3=#:G846 NIL) (|i| NIL)
          (#4=#:G847 NIL) (|j| NIL) (|pbcyc| #5=(|List| (|List| S)))
          (|pacyc| #5#))
         (SEQ
          (EXIT
           (SEQ (LETT |pacyc| (|PERM;coerceToCycle| |pa| 'T $))
                (LETT |pbcyc| (|PERM;coerceToCycle| |pb| 'T $))
                (SEQ
                 (EXIT
                  (SEQ (LETT |j| NIL) (LETT #4# |pbcyc|) (LETT |i| NIL)
                       (LETT #3# |pacyc|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |i| (CAR #3#)) NIL)
                             (ATOM #4#) (PROGN (LETT |j| (CAR #4#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |i| |j| (QREFELT $ 24))
                           (PROGN
                            (LETT #1#
                                  (PROGN
                                   (LETT #2# (|PERM;smallerCycle?| |i| |j| $))
                                   (GO #6=#:G843)))
                            (GO #7=#:G841))))))
                       (LETT #3# (PROG1 (CDR #3#) (LETT #4# (CDR #4#))))
                       (GO G190) G191 (EXIT NIL)))
                 #7# (EXIT #1#))
                (EXIT (< (LENGTH |pacyc|) (LENGTH |pbcyc|)))))
          #6# (EXIT #2#)))) 

(SDEFUN |PERM;coerce;L$;21| ((|lls| (|List| (|List| S))) ($ ($)))
        (|PERM;coerceCycle| |lls| $)) 

(SDEFUN |PERM;coerce;L$;22| ((|ls| (|List| S)) ($ ($)))
        (SPADCALL |ls| (QREFELT $ 20))) 

(SDEFUN |PERM;sort;2L;23| ((|inList| (|List| $)) ($ (|List| $)))
        (SPROG
         ((|outList| (|List| $)) (#1=#:G862 NIL) (|rec| NIL)
          (|ownList|
           (|List|
            (|Record| (|:| |cycl| (|List| (|List| S))) (|:| |permut| $))))
          (#2=#:G861 NIL) (|sigma| NIL))
         (SEQ
          (COND
           ((NULL (|HasCategory| (QREFELT $ 6) '(|OrderedSet|)))
            (COND
             ((NULL (|HasCategory| (QREFELT $ 6) '(|Finite|)))
              (EXIT |inList|)))))
          (LETT |ownList| NIL)
          (SEQ (LETT |sigma| NIL) (LETT #2# |inList|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |sigma| (CAR #2#)) NIL))
                 (GO G191)))
               (SEQ
                (EXIT
                 (LETT |ownList|
                       (SPADCALL
                        (CONS (|PERM;coerceToCycle| |sigma| 'T $) |sigma|)
                        |ownList| (QREFELT $ 66)))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (LETT |ownList|
                (SPADCALL (CONS (|function| |PERM;permord|) $) |ownList|
                          (QREFELT $ 68)))
          (LETT |outList| NIL)
          (SEQ (LETT |rec| NIL) (LETT #1# |ownList|) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL)) (GO G191)))
               (SEQ
                (EXIT
                 (LETT |outList|
                       (SPADCALL (QCDR |rec|) |outList| (QREFELT $ 70)))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |outList| (QREFELT $ 71)))))) 

(SDEFUN |PERM;coerce;$Of;24| ((|p| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|outfmL| (|List| (|OutputForm|)))
          (|outcycL| (|List| (|OutputForm|))) (#1=#:G872 NIL) (|elt| NIL)
          (#2=#:G871 NIL) (|cycle| NIL) (|cycles| (|List| (|List| S))))
         (SEQ (LETT |cycles| (|PERM;coerceToCycle| |p| 'T $))
              (LETT |outfmL| NIL)
              (SEQ (LETT |cycle| NIL) (LETT #2# |cycles|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |cycle| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |outcycL| NIL)
                        (SEQ (LETT |elt| NIL) (LETT #1# |cycle|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |elt| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |outcycL|
                                     (CONS (SPADCALL |elt| (QREFELT $ 74))
                                           |outcycL|))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (LETT |outfmL|
                               (CONS
                                (SPADCALL
                                 (SPADCALL (REVERSE |outcycL|) (QREFELT $ 75))
                                 (QREFELT $ 76))
                                |outfmL|))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND ((NULL |outfmL|) (SPADCALL 1 (QREFELT $ 77)))
                     ((NULL (CDR |outfmL|)) (|SPADfirst| |outfmL|))
                     ('T (SPADCALL (REVERSE |outfmL|) (QREFELT $ 78)))))))) 

(SDEFUN |PERM;cycles;L$;25| ((|vs| (|List| (|List| S))) ($ ($)))
        (|PERM;coerceCycle| |vs| $)) 

(SDEFUN |PERM;cycle;L$;26| ((|ls| (|List| S)) ($ ($)))
        (COND ((< (LENGTH |ls|) 2) (|spadConstant| $ 15))
              ((|PERM;duplicates?| |ls| $)
               (|error| "cycle: the input contains duplicates"))
              ('T
               (VECTOR |ls|
                       (SPADCALL (CDR |ls|)
                                 (SPADCALL (|SPADfirst| |ls|) (QREFELT $ 26))
                                 (QREFELT $ 81)))))) 

(SDEFUN |PERM;coerceListOfPairs;L$;27| ((|loP| (|List| (|List| S))) ($ ($)))
        (SPROG
         ((|im| (|List| S)) (|preim| (|List| S)) (#1=#:G886 NIL) (|pair| NIL))
         (SEQ (LETT |preim| NIL) (LETT |im| NIL)
              (SEQ (LETT |pair| NIL) (LETT #1# |loP|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |pair| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (|SPADfirst| |pair|)
                                 (SPADCALL |pair| (QREFELT $ 82))
                                 (QREFELT $ 23))
                       (SEQ (LETT |preim| (CONS (|SPADfirst| |pair|) |preim|))
                            (EXIT
                             (LETT |im|
                                   (CONS (SPADCALL |pair| (QREFELT $ 82))
                                         |im|))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (COND
               ((OR (|PERM;duplicates?| |preim| $)
                    (OR (|PERM;duplicates?| |im| $)
                        (SPADCALL (SPADCALL |preim| (QREFELT $ 44))
                                  (SPADCALL |im| (QREFELT $ 44))
                                  (QREFELT $ 83))))
                (EXIT
                 (|error|
                  "coerceListOfPairs: the input cannot be interpreted as a permutation"))))
              (EXIT (VECTOR |preim| |im|))))) 

(SDEFUN |PERM;*;3$;28| ((|q| ($)) (|p| ($)) ($ ($)))
        (SPROG
         ((|imOfq| #1=(|List| S)) (|preimOfq| #1#) (|imOfqp| (|List| S))
          (|preimOfqp| (|List| S)) (|el| (S)) (|j| (|Integer|)) (#2=#:G898 NIL)
          (|i| NIL) (|imOfp| #3=(|Vector| S)) (|preimOfp| #3#))
         (SEQ
          (LETT |preimOfp|
                (SPADCALL (SPADCALL |p| 1 (QREFELT $ 25)) (QREFELT $ 86)))
          (LETT |imOfp|
                (SPADCALL (SPADCALL |p| 2 (QREFELT $ 25)) (QREFELT $ 86)))
          (LETT |preimOfq| (SPADCALL |q| 1 (QREFELT $ 25)))
          (LETT |imOfq| (SPADCALL |q| 2 (QREFELT $ 25))) (LETT |preimOfqp| NIL)
          (LETT |imOfqp| NIL)
          (SEQ (LETT |i| 1) (LETT #2# (QVSIZE |preimOfp|)) G190
               (COND ((|greater_SI| |i| #2#) (GO G191)))
               (SEQ
                (LETT |j|
                      (SPADCALL (SPADCALL |imOfp| |i| (QREFELT $ 87))
                                |preimOfq| (QREFELT $ 27)))
                (EXIT
                 (COND
                  ((EQL |j| 0)
                   (SEQ
                    (LETT |preimOfqp|
                          (CONS (SPADCALL |preimOfp| |i| (QREFELT $ 87))
                                |preimOfqp|))
                    (EXIT
                     (LETT |imOfqp|
                           (CONS (SPADCALL |imOfp| |i| (QREFELT $ 87))
                                 |imOfqp|)))))
                  ('T
                   (SEQ (LETT |el| (SPADCALL |imOfq| |j| (QREFELT $ 14)))
                        (COND
                         ((SPADCALL |el|
                                    (SPADCALL |preimOfp| |i| (QREFELT $ 87))
                                    (QREFELT $ 23))
                          (SEQ
                           (LETT |preimOfqp|
                                 (CONS (SPADCALL |preimOfp| |i| (QREFELT $ 87))
                                       |preimOfqp|))
                           (EXIT (LETT |imOfqp| (CONS |el| |imOfqp|))))))
                        (LETT |preimOfq|
                              (SPADCALL |preimOfq| |j| (QREFELT $ 28)))
                        (EXIT
                         (LETT |imOfq|
                               (SPADCALL |imOfq| |j| (QREFELT $ 28)))))))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (VECTOR (SPADCALL |preimOfqp| |preimOfq| (QREFELT $ 81))
                   (SPADCALL |imOfqp| |imOfq| (QREFELT $ 81))))))) 

(PUT '|PERM;One;$;29| '|SPADreplace| '(XLAM NIL (MAKEARR1 2 NIL))) 

(SDEFUN |PERM;One;$;29| (($ ($))) (MAKEARR1 2 NIL)) 

(SDEFUN |PERM;inv;2$;30| ((|p| ($)) ($ ($)))
        (VECTOR (SPADCALL |p| 2 (QREFELT $ 25))
                (SPADCALL |p| 1 (QREFELT $ 25)))) 

(SDEFUN |PERM;eval;$2S;31| ((|p| ($)) (|el| (S)) ($ (S)))
        (SPROG ((|pos| (|Integer|)))
               (SEQ
                (LETT |pos|
                      (SPADCALL |el| (SPADCALL |p| 1 (QREFELT $ 25))
                                (QREFELT $ 27)))
                (EXIT
                 (COND ((EQL |pos| 0) |el|)
                       ('T
                        (SPADCALL (SPADCALL |p| 2 (QREFELT $ 25)) |pos|
                                  (QREFELT $ 14)))))))) 

(SDEFUN |PERM;elt;$2S;32| ((|p| ($)) (|el| (S)) ($ (S)))
        (SPADCALL |p| |el| (QREFELT $ 45))) 

(SDEFUN |PERM;numberOfCycles;$Nni;33| ((|p| ($)) ($ (|NonNegativeInteger|)))
        (LENGTH (|PERM;coerceToCycle| |p| NIL $))) 

(SDEFUN |PERM;coerceImages;L$;34| ((|image| (|List| S)) ($ ($)))
        (SPROG
         ((|preImage| (|List| S)) (#1=#:G910 NIL) (|i| NIL) (#2=#:G909 NIL))
         (SEQ
          (LETT |preImage|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 1) (LETT #1# (LENGTH |image|)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |i| (QREFELT $ 90)) #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL (LIST |preImage| |image|) (QREFELT $ 37)))))) 

(SDEFUN |PERM;coerceImages;L$;35| ((|image| (|List| S)) ($ ($)))
        (SPROG
         ((|preImage| (|List| S)) (#1=#:G913 NIL) (#2=#:G918 NIL) (|i| NIL)
          (#3=#:G917 NIL))
         (SEQ
          (LETT |preImage|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |i| 1) (LETT #2# (LENGTH |image|)) G190
                      (COND ((|greater_SI| |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (SPADCALL
                                (PROG1 (LETT #1# |i|)
                                  (|check_subtype2| (> #1# 0)
                                                    '(|PositiveInteger|)
                                                    '(|NonNegativeInteger|)
                                                    #1#))
                                (QREFELT $ 92))
                               #3#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (EXIT (SPADCALL (LIST |preImage| |image|) (QREFELT $ 37)))))) 

(SDEFUN |PERM;fixedPoints;$S;36| ((|p| ($)) ($ (|Set| S)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 40)) (QREFELT $ 93))) 

(SDEFUN |PERM;cyclePartition;$P;37| ((|p| ($)) ($ (|Partition|)))
        (SPROG ((|pt| (|Partition|)) (#1=#:G925 NIL) (|c| NIL) (#2=#:G924 NIL))
               (SEQ
                (LETT |pt|
                      (SPADCALL
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |c| NIL)
                             (LETT #1# (|PERM;coerceToCycle| |p| NIL $)) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ (EXIT (LETT #2# (CONS (LENGTH |c|) #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))
                       (QREFELT $ 50)))
                (EXIT
                 (SPADCALL |pt|
                           (SPADCALL
                            (SPADCALL
                             (LIST
                              (SPADCALL (SPADCALL |p| (QREFELT $ 94))
                                        (QREFELT $ 41)))
                             (QREFELT $ 50))
                            (QREFELT $ 95))
                           (QREFELT $ 96)))))) 

(DECLAIM (NOTINLINE |Permutation;|)) 

(DEFUN |Permutation| (#1=#:G930)
  (SPROG NIL
         (PROG (#2=#:G931)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Permutation|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Permutation;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|Permutation|)))))))))) 

(DEFUN |Permutation;| (|#1|)
  (SPROG ((|pv$| NIL) (#1=#:G929 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Permutation| DV$1))
          (LETT $ (GETREFV 101))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (LETT #1#
                                                    (|HasCategory| |#1|
                                                                   '(|Finite|)))
                                              (OR #1#
                                                  (|HasCategory| |#1|
                                                                 '(|OrderedSet|)))
                                              (OR #1#
                                                  (|HasCategory| |#1|
                                                                 '(|IntegerNumberSystem|)))))))
          (|haddProp| |$ConstructorCache| '|Permutation| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|Vector| (|List| |#1|)))
          (COND
           ((|HasCategory| |#1| '(|IntegerNumberSystem|))
            (QSETREFV $ 91
                      (CONS (|dispatchFunction| |PERM;coerceImages;L$;34|)
                            $))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 91
                       (CONS (|dispatchFunction| |PERM;coerceImages;L$;35|) $))
             (QSETREFV $ 94
                       (CONS (|dispatchFunction| |PERM;fixedPoints;$S;36|) $))
             (QSETREFV $ 51
                       (CONS (|dispatchFunction| |PERM;cyclePartition;$P;37|)
                             $)))))
          $))) 

(MAKEPROP '|Permutation| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Boolean|) (0 . <)
              (|PositiveInteger|) (6 . |lookup|) (|Integer|) (|List| 6)
              (11 . |elt|)
              (CONS IDENTITY (FUNCALL (|dispatchFunction| |PERM;One;$;29|) $))
              (|NonNegativeInteger|) (17 . |last|) (23 . |first|)
              (29 . |concat|) |PERM;cycle;L$;26| |PERM;*;3$;28| (35 . ~=)
              (41 . ~=) (47 . ~=) (53 . |elt|) (59 . |list|) (64 . |position|)
              (70 . |delete|) (|Mapping| 8 13 13) (|List| 13) (76 . |sort|)
              (82 . |copy|) (87 . |member?|)
              (|Record| (|:| |preimage| 13) (|:| |image| 13))
              |PERM;listRepresentation;$R;9| (93 . |elt|)
              |PERM;coercePreimagesImages;L$;10| (|Set| 6) (99 . |construct|)
              |PERM;movedPoints;$S;11| (104 . |#|) |PERM;degree;$Nni;12|
              |PERM;=;2$B;13| (109 . |set|) |PERM;eval;$2S;31|
              (114 . |insert!|) |PERM;orbit;$SS;14| (|List| 12) (|Partition|)
              (120 . |partition|) |PERM;cyclePartition;$P;15| (125 . |convert|)
              (130 . |removeDuplicates|) (|List| $) (135 . |lcm|)
              |PERM;order;$Nni;16| |PERM;even?;$B;18| |PERM;sign;$I;17|
              |PERM;numberOfCycles;$Nni;33| |PERM;odd?;$B;19| |PERM;<;2$B;20|
              |PERM;coerce;L$;21| |PERM;coerce;L$;22|
              (|Record| (|:| |cycl| 30) (|:| |permut| $$)) (|List| 64)
              (140 . |cons|) (|Mapping| 8 64 64) (146 . |sort|) (|List| $$)
              (152 . |cons|) (158 . |reverse|) |PERM;sort;2L;23| (|OutputForm|)
              (163 . |coerce|) (168 . |blankSeparate|) (173 . |paren|)
              (178 . |outputForm|) (183 . |hconcat|) |PERM;coerce;$Of;24|
              |PERM;cycles;L$;25| (188 . |append|) (194 . |second|) (199 . ~=)
              |PERM;coerceListOfPairs;L$;27| (|Vector| 6) (205 . |construct|)
              (210 . |elt|) |PERM;inv;2$;30| |PERM;elt;$2S;32| (216 . |coerce|)
              (221 . |coerceImages|) (226 . |index|) (231 . |complement|)
              (236 . |fixedPoints|) (241 . |conjugate|) (246 . +)
              (|Union| $ '"failed") (|HashState|) (|String|) (|SingleInteger|))
           '#(~= 252 |sort| 258 |smaller?| 263 |sign| 269 |sample| 274
              |rightRecip| 278 |rightPower| 283 |recip| 295 |order| 300 |orbit|
              305 |one?| 311 |odd?| 316 |numberOfCycles| 321 |movedPoints| 326
              |min| 331 |max| 337 |listRepresentation| 343 |leftRecip| 348
              |leftPower| 353 |latex| 365 |inv| 370 |hashUpdate!| 375 |hash|
              381 |fixedPoints| 386 |even?| 391 |eval| 396 |elt| 402 |degree|
              408 |cycles| 413 |cyclePartition| 418 |cycle| 423 |conjugate| 428
              |commutator| 434 |coercePreimagesImages| 440 |coerceListOfPairs|
              445 |coerceImages| 450 |coerce| 455 ^ 470 |One| 488 >= 492 > 498
              = 504 <= 510 < 516 / 522 * 528)
           'NIL
           (CONS (|makeByteWordVec2| 2 '(0 0 0 0 0 2 0 2 0 0 0 0 0 2))
                 (CONS
                  '#(NIL |Group&| NIL NIL |MagmaWithUnit&| |OrderedSet&|
                     |Magma&| NIL |SetCategory&| NIL NIL |BasicType&| NIL
                     |PartialOrder&|)
                  (CONS
                   '#((|PermutationCategory| 6) (|Group|) (|Monoid|)
                      (|SemiGroup|) (|MagmaWithUnit|) (|OrderedSet|) (|Magma|)
                      (|Comparable|) (|SetCategory|) (|unitsKnown|)
                      (|TwoSidedRecip|) (|BasicType|) (|CoercibleTo| 73)
                      (|PartialOrder|))
                   (|makeByteWordVec2| 100
                                       '(2 6 8 0 0 9 1 6 10 0 11 2 13 6 0 12 14
                                         2 13 0 0 16 17 2 13 0 0 16 18 2 13 0 0
                                         0 19 2 12 8 0 0 22 2 6 8 0 0 23 2 13 8
                                         0 0 24 2 7 13 0 12 25 1 13 0 6 26 2 13
                                         12 6 0 27 2 13 0 0 12 28 2 30 0 29 0
                                         31 1 13 0 0 32 2 13 8 6 0 33 2 30 13 0
                                         12 36 1 38 0 13 39 1 38 16 0 41 1 38 0
                                         13 44 2 38 0 6 0 46 1 49 0 48 50 1 49
                                         48 0 52 1 48 0 0 53 1 12 0 54 55 2 65
                                         0 64 0 66 2 65 0 67 0 68 2 69 0 2 0 70
                                         1 69 0 0 71 1 6 73 0 74 1 73 0 54 75 1
                                         73 0 0 76 1 73 0 12 77 1 73 0 54 78 2
                                         13 0 0 0 81 1 13 6 0 82 2 38 8 0 0 83
                                         1 85 0 13 86 2 85 6 0 12 87 1 6 0 12
                                         90 1 0 0 13 91 1 6 0 10 92 1 38 0 0 93
                                         1 0 38 0 94 1 49 0 0 95 2 49 0 0 0 96
                                         2 0 8 0 0 1 1 0 54 54 72 2 2 8 0 0 1 1
                                         0 12 0 58 0 0 0 1 1 0 97 0 1 2 0 0 0
                                         16 1 2 0 0 0 10 1 1 0 97 0 1 1 0 16 0
                                         56 2 0 38 0 6 47 1 0 8 0 1 1 0 8 0 60
                                         1 0 16 0 59 1 0 38 0 40 2 2 0 0 0 1 2
                                         2 0 0 0 1 1 0 34 0 35 1 0 97 0 1 2 0 0
                                         0 16 1 2 0 0 0 10 1 1 0 99 0 1 1 0 0 0
                                         88 2 0 98 98 0 1 1 0 100 0 1 1 1 38 0
                                         94 1 0 8 0 57 2 0 6 0 6 45 2 0 6 0 6
                                         89 1 0 16 0 42 1 0 0 30 80 1 0 49 0 51
                                         1 0 0 13 20 2 0 0 0 0 1 2 0 0 0 0 1 1
                                         0 0 30 37 1 0 0 30 84 1 3 0 13 91 1 0
                                         0 13 63 1 0 0 30 62 1 0 73 0 79 2 0 0
                                         0 12 1 2 0 0 0 16 1 2 0 0 0 10 1 0 0 0
                                         15 2 2 8 0 0 1 2 2 8 0 0 1 2 0 8 0 0
                                         43 2 2 8 0 0 1 2 0 8 0 0 61 2 0 0 0 0
                                         1 2 0 0 0 0 21)))))
           '|lookupComplete|)) 

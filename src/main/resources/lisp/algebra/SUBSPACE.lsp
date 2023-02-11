
(SDEFUN |SUBSPACE;leaf?;$B;1| ((|space| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |space| (QREFELT $ 11)) (QREFELT $ 14))) 

(SDEFUN |SUBSPACE;root?;$B;2| ((|space| ($)) ($ (|Boolean|)))
        (EQL (QVELT |space| 5) 0)) 

(SDEFUN |SUBSPACE;internal?;$B;3| ((|space| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL |space| (QREFELT $ 16))
          (NULL (SPADCALL |space| (QREFELT $ 15))))
         ('T 'T))) 

(SDEFUN |SUBSPACE;new;$;4| (($ ($)))
        (VECTOR (SPADCALL NIL (QREFELT $ 20)) 0 (SPADCALL (QREFELT $ 22)) NIL
                NIL 0 NIL NIL 0 0 NIL)) 

(SDEFUN |SUBSPACE;subspace;$;5| (($ ($))) (SPADCALL (QREFELT $ 23))) 

(SDEFUN |SUBSPACE;birth;2$;6| ((|momma| ($)) ($ ($)))
        (SPROG ((|lastKid| (|List| $)) (|baby| ($)))
               (SEQ (LETT |baby| (SPADCALL (QREFELT $ 23)))
                    (QSETVELT |baby| 5 (+ (QVELT |momma| 5) 1))
                    (QSETVELT |baby| 10 (LIST |momma|))
                    (COND
                     ((NULL
                       (SPADCALL (LETT |lastKid| (QVELT |momma| 4))
                                 (QREFELT $ 14)))
                      (COND
                       ((NULL
                         (SPADCALL (SPADCALL |lastKid| (QREFELT $ 25))
                                   (QREFELT $ 14)))
                        (EXIT (|error| (QREFELT $ 9)))))))
                    (COND
                     ((SPADCALL |lastKid| (QREFELT $ 14))
                      (SEQ (QSETVELT |momma| 3 (LIST |baby|))
                           (QSETVELT |momma| 4 (QVELT |momma| 3))
                           (EXIT (QSETVELT |momma| 9 1))))
                     ('T
                      (SEQ (SPADCALL |lastKid| (LIST |baby|) (QREFELT $ 26))
                           (QSETVELT |momma| 4
                                     (SPADCALL |lastKid| (QREFELT $ 25)))
                           (EXIT
                            (QSETVELT |momma| 9 (+ (QVELT |momma| 9) 1))))))
                    (EXIT |baby|)))) 

(SDEFUN |SUBSPACE;child;$Nni$;7|
        ((|space| ($)) (|num| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL (QVELT |space| 3) |num| (QREFELT $ 29))) 

(PUT '|SUBSPACE;children;$L;8| '|SPADreplace|
     '(XLAM (|space|) (QVELT |space| 3))) 

(SDEFUN |SUBSPACE;children;$L;8| ((|space| ($)) ($ (|List| $)))
        (QVELT |space| 3)) 

(PUT '|SUBSPACE;numberOfChildren;$Nni;9| '|SPADreplace|
     '(XLAM (|space|) (QVELT |space| 9))) 

(SDEFUN |SUBSPACE;numberOfChildren;$Nni;9|
        ((|space| ($)) ($ (|NonNegativeInteger|))) (QVELT |space| 9)) 

(SDEFUN |SUBSPACE;shallowCopy;2$;10| ((|space| ($)) ($ ($)))
        (SPROG ((|node| ($)))
               (SEQ (LETT |node| (SPADCALL (QREFELT $ 23)))
                    (QSETVELT |node| 0 (QVELT |space| 0))
                    (QSETVELT |node| 1 (QVELT |space| 1))
                    (QSETVELT |node| 2
                              (SPADCALL (QVELT |space| 2) (QREFELT $ 33)))
                    (QSETVELT |node| 5 (QVELT |space| 5))
                    (QSETVELT |node| 10 NIL)
                    (COND
                     ((SPADCALL |space| (QREFELT $ 16))
                      (SEQ
                       (QSETVELT |node| 6
                                 (SPADCALL (QVELT |space| 6) (QREFELT $ 35)))
                       (QSETVELT |node| 7
                                 (SPADCALL (QVELT |node| 6) (QREFELT $ 36)))
                       (EXIT (QSETVELT |node| 8 (QVELT |space| 8))))))
                    (EXIT |node|)))) 

(SDEFUN |SUBSPACE;deepCopy;2$;11| ((|space| ($)) ($ ($)))
        (SPROG ((|cc| ($)) (#1=#:G771 NIL) (|c| NIL) (|node| ($)))
               (SEQ (LETT |node| (SPADCALL |space| (QREFELT $ 37)))
                    (EXIT
                     (COND ((SPADCALL |space| (QREFELT $ 15)) |node|)
                           ('T
                            (SEQ
                             (SEQ (LETT |c| NIL)
                                  (LETT #1# (SPADCALL |space| (QREFELT $ 11)))
                                  G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |c| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |cc| (SPADCALL |c| (QREFELT $ 38)))
                                   (QSETVELT |cc| 10 (LIST |node|))
                                   (EXIT
                                    (QSETVELT |node| 3
                                              (SPADCALL |cc| (QVELT |node| 3)
                                                        (QREFELT $ 39)))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT NIL))
                             (QSETVELT |node| 3
                                       (SPADCALL (QVELT |node| 3)
                                                 (QREFELT $ 40)))
                             (QSETVELT |node| 4
                                       (SPADCALL (QVELT |node| 3)
                                                 (QREFELT $ 41)))
                             (EXIT |node|)))))))) 

(SDEFUN |SUBSPACE;merge;3$;12| ((|s1| ($)) (|s2| ($)) ($ ($)))
        (SPROG ((|n2| (|Rep|)) (|n1| (|Rep|)))
               (SEQ (LETT |n1| (SPADCALL |s1| (QREFELT $ 38)))
                    (LETT |n2| (SPADCALL |s2| (QREFELT $ 38)))
                    (QSETVELT |n1| 3
                              (SPADCALL (SPADCALL |n1| (QREFELT $ 11))
                                        (SPADCALL |n2| (QREFELT $ 11))
                                        (QREFELT $ 42)))
                    (EXIT |n1|)))) 

(SDEFUN |SUBSPACE;merge;L$;13| ((|listOfSpaces| (|List| $)) ($ ($)))
        (SPROG
         ((#1=#:G783 NIL) (|c| NIL) (#2=#:G782 NIL) (#3=#:G781 NIL) (|s| NIL)
          (|space| ($)))
         (SEQ
          (COND
           ((SPADCALL |listOfSpaces| (QREFELT $ 14))
            (|error| "empty list passed as argument to merge"))
           ('T
            (SEQ
             (LETT |space|
                   (SPADCALL (SPADCALL |listOfSpaces| (QREFELT $ 44))
                             (QREFELT $ 38)))
             (SEQ (LETT |s| NIL)
                  (LETT #3# (SPADCALL |listOfSpaces| (QREFELT $ 25))) G190
                  (COND
                   ((OR (ATOM #3#) (PROGN (LETT |s| (CAR #3#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (QSETVELT |space| 3
                              (SPADCALL (QVELT |space| 3)
                                        (PROGN
                                         (LETT #2# NIL)
                                         (SEQ (LETT |c| NIL)
                                              (LETT #1# (QVELT |s| 3)) G190
                                              (COND
                                               ((OR (ATOM #1#)
                                                    (PROGN
                                                     (LETT |c| (CAR #1#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #2#
                                                      (CONS
                                                       (SPADCALL |c|
                                                                 (QREFELT $
                                                                          38))
                                                       #2#))))
                                              (LETT #1# (CDR #1#)) (GO G190)
                                              G191 (EXIT (NREVERSE #2#))))
                                        (QREFELT $ 42)))))
                  (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
             (EXIT |space|))))))) 

(SDEFUN |SUBSPACE;separate;$L;14| ((|space| ($)) ($ (|List| $)))
        (SPROG ((|spaceList| (|List| $)) (|spc| ($)) (#1=#:G789 NIL) (|s| NIL))
               (SEQ (LETT |spaceList| NIL)
                    (SEQ (LETT |s| NIL) (LETT #1# (QVELT |space| 3)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |spc| (SPADCALL |space| (QREFELT $ 37)))
                              (QSETVELT |spc| 3
                                        (LIST (SPADCALL |s| (QREFELT $ 38))))
                              (EXIT
                               (LETT |spaceList|
                                     (SPADCALL |spc| |spaceList|
                                               (QREFELT $ 39)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |spaceList|)))) 

(SDEFUN |SUBSPACE;addPoint;$LP$;15|
        ((|space| ($)) (|path| (|List| (|NonNegativeInteger|)))
         (|point| (|Point| R)) ($ ($)))
        (SPROG
         ((|node| ($)) (#1=#:G805 NIL) (|more| NIL)
          (|depth| (|NonNegativeInteger|)) (#2=#:G804 NIL) (|i| NIL)
          (|which| (|NonNegativeInteger|)) (|lastPt| (|List| (|Point| R))))
         (SEQ
          (COND
           ((NULL (NULL (LETT |lastPt| (QVELT |space| 7))))
            (COND
             ((NULL (NULL (CDR |lastPt|))) (EXIT (|error| (QREFELT $ 9)))))))
          (COND
           ((NULL |lastPt|)
            (SEQ (QSETVELT |space| 6 (LIST |point|))
                 (EXIT (QSETVELT |space| 7 (QVELT |space| 6)))))
           ('T
            (SEQ (SPADCALL |lastPt| (LIST |point|) (QREFELT $ 47))
                 (EXIT (QSETVELT |space| 7 (CDR |lastPt|))))))
          (QSETVELT |space| 8 (+ (QVELT |space| 8) 1))
          (LETT |which| (QVELT |space| 8)) (LETT |node| |space|)
          (LETT |depth| 0)
          (SEQ (LETT |i| NIL) (LETT #2# |path|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL)) (GO G191)))
               (SEQ (LETT |node| (SPADCALL |node| |i| (QREFELT $ 31)))
                    (EXIT (LETT |depth| (+ |depth| 1))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (SEQ (LETT |more| |depth|) (LETT #1# (- (QREFELT $ 6) 1)) G190
               (COND ((> |more| #1#) (GO G191)))
               (SEQ (EXIT (LETT |node| (SPADCALL |node| (QREFELT $ 27)))))
               (LETT |more| (+ |more| 1)) (GO G190) G191 (EXIT NIL))
          (QSETVELT |node| 0 |point|) (QSETVELT |node| 1 |which|)
          (EXIT |space|)))) 

(SDEFUN |SUBSPACE;addPoint2;$P$;16|
        ((|space| ($)) (|point| (|Point| R)) ($ ($)))
        (SPROG
         ((|node| ($)) (#1=#:G815 NIL) (|more| NIL) (|first| ($))
          (|which| (|NonNegativeInteger|)) (|lastPt| (|List| (|Point| R))))
         (SEQ
          (COND
           ((NULL (NULL (LETT |lastPt| (QVELT |space| 7))))
            (COND
             ((NULL (NULL (CDR |lastPt|))) (EXIT (|error| (QREFELT $ 9)))))))
          (COND
           ((NULL |lastPt|)
            (SEQ (QSETVELT |space| 6 (LIST |point|))
                 (EXIT (QSETVELT |space| 7 (QVELT |space| 6)))))
           ('T
            (SEQ (SPADCALL |lastPt| (LIST |point|) (QREFELT $ 47))
                 (EXIT (QSETVELT |space| 7 (CDR |lastPt|))))))
          (QSETVELT |space| 8 (+ (QVELT |space| 8) 1))
          (LETT |which| (QVELT |space| 8)) (LETT |node| |space|)
          (LETT |node| (SPADCALL |node| (QREFELT $ 27))) (LETT |first| |node|)
          (SEQ (LETT |more| 1) (LETT #1# (- (QREFELT $ 6) 1)) G190
               (COND ((|greater_SI| |more| #1#) (GO G191)))
               (SEQ (EXIT (LETT |node| (SPADCALL |node| (QREFELT $ 27)))))
               (LETT |more| (|inc_SI| |more|)) (GO G190) G191 (EXIT NIL))
          (QSETVELT |node| 0 |point|) (QSETVELT |node| 1 |which|)
          (EXIT |first|)))) 

(SDEFUN |SUBSPACE;addPointLast;2$PNni$;17|
        ((|space| ($)) (|node| ($)) (|point| (|Point| R))
         (|depth| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((#1=#:G825 NIL) (|more| NIL) (|which| (|NonNegativeInteger|))
          (|lastPt| (|List| (|Point| R))))
         (SEQ
          (COND
           ((NULL (NULL (LETT |lastPt| (QVELT |space| 7))))
            (COND
             ((NULL (NULL (CDR |lastPt|))) (EXIT (|error| (QREFELT $ 9)))))))
          (COND
           ((NULL |lastPt|)
            (SEQ (QSETVELT |space| 6 (LIST |point|))
                 (EXIT (QSETVELT |space| 7 (QVELT |space| 6)))))
           ('T
            (SEQ (SPADCALL |lastPt| (LIST |point|) (QREFELT $ 47))
                 (EXIT (QSETVELT |space| 7 (CDR |lastPt|))))))
          (QSETVELT |space| 8 (+ (QVELT |space| 8) 1))
          (LETT |which| (QVELT |space| 8))
          (COND
           ((EQL |depth| 2) (LETT |node| (SPADCALL |node| 2 (QREFELT $ 31)))))
          (SEQ (LETT |more| |depth|) (LETT #1# (- (QREFELT $ 6) 1)) G190
               (COND ((> |more| #1#) (GO G191)))
               (SEQ (EXIT (LETT |node| (SPADCALL |node| (QREFELT $ 27)))))
               (LETT |more| (+ |more| 1)) (GO G190) G191 (EXIT NIL))
          (QSETVELT |node| 0 |point|) (QSETVELT |node| 1 |which|)
          (EXIT |node|)))) 

(SDEFUN |SUBSPACE;addPoint;$LNni$;18|
        ((|space| ($)) (|path| (|List| (|NonNegativeInteger|)))
         (|which| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|node| ($)) (#1=#:G835 NIL) (|more| NIL)
          (|depth| (|NonNegativeInteger|)) (#2=#:G834 NIL) (|i| NIL))
         (SEQ (LETT |node| |space|) (LETT |depth| 0)
              (SEQ (LETT |i| NIL) (LETT #2# |path|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |node| (SPADCALL |node| |i| (QREFELT $ 31)))
                        (EXIT (LETT |depth| (+ |depth| 1))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |more| |depth|) (LETT #1# (- (QREFELT $ 6) 1)) G190
                   (COND ((> |more| #1#) (GO G191)))
                   (SEQ (EXIT (LETT |node| (SPADCALL |node| (QREFELT $ 27)))))
                   (LETT |more| (+ |more| 1)) (GO G190) G191 (EXIT NIL))
              (QSETVELT |node| 0
                        (SPADCALL (QVELT |space| 6) |which| (QREFELT $ 52)))
              (QSETVELT |node| 1 |which|) (EXIT |space|)))) 

(SDEFUN |SUBSPACE;addPoint;$PNni;19|
        ((|space| ($)) (|point| (|Point| R)) ($ (|NonNegativeInteger|)))
        (SPROG ((|lastPt| (|List| (|Point| R))))
               (SEQ
                (COND
                 ((SPADCALL |space| (QREFELT $ 16))
                  (SEQ
                   (COND
                    ((NULL (NULL (LETT |lastPt| (QVELT |space| 7))))
                     (COND
                      ((NULL (NULL (CDR |lastPt|)))
                       (EXIT (|error| (QREFELT $ 9)))))))
                   (COND
                    ((NULL |lastPt|)
                     (SEQ (QSETVELT |space| 6 (LIST |point|))
                          (EXIT (QSETVELT |space| 7 (QVELT |space| 6)))))
                    (#1='T
                     (SEQ (SPADCALL |lastPt| (LIST |point|) (QREFELT $ 47))
                          (EXIT (QSETVELT |space| 7 (CDR |lastPt|))))))
                   (EXIT (QSETVELT |space| 8 (+ (QVELT |space| 8) 1)))))
                 (#1#
                  (|error|
                   "You need to pass a top level SubSpace (level should be zero)")))))) 

(SDEFUN |SUBSPACE;modifyPoint;$LP$;20|
        ((|space| ($)) (|path| (|List| (|NonNegativeInteger|)))
         (|point| (|Point| R)) ($ ($)))
        (SPROG
         ((|node| ($)) (#1=#:G853 NIL) (|i| NIL)
          (|which| (|NonNegativeInteger|)) (|lastPt| (|List| (|Point| R))))
         (SEQ
          (COND
           ((NULL (NULL (LETT |lastPt| (QVELT |space| 7))))
            (COND
             ((NULL (NULL (CDR |lastPt|))) (EXIT (|error| (QREFELT $ 9)))))))
          (COND
           ((NULL |lastPt|)
            (SEQ (QSETVELT |space| 6 (LIST |point|))
                 (EXIT (QSETVELT |space| 7 (QVELT |space| 6)))))
           ('T
            (SEQ (SPADCALL |lastPt| (LIST |point|) (QREFELT $ 47))
                 (EXIT (QSETVELT |space| 7 (CDR |lastPt|))))))
          (QSETVELT |space| 8 (+ (QVELT |space| 8) 1))
          (LETT |which| (QVELT |space| 8)) (LETT |node| |space|)
          (SEQ (LETT |i| NIL) (LETT #1# |path|) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL)) (GO G191)))
               (SEQ (EXIT (LETT |node| (SPADCALL |node| |i| (QREFELT $ 31)))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (QSETVELT |node| 0 |point|) (QSETVELT |node| 1 |which|)
          (EXIT |space|)))) 

(SDEFUN |SUBSPACE;modifyPoint;$LNni$;21|
        ((|space| ($)) (|path| (|List| (|NonNegativeInteger|)))
         (|which| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|node| ($)) (#1=#:G859 NIL) (|i| NIL))
               (SEQ (LETT |node| |space|)
                    (SEQ (LETT |i| NIL) (LETT #1# |path|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |node| (SPADCALL |node| |i| (QREFELT $ 31)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (QSETVELT |node| 0
                              (SPADCALL (QVELT |space| 6) |which|
                                        (QREFELT $ 52)))
                    (QSETVELT |node| 1 |which|) (EXIT |space|)))) 

(SDEFUN |SUBSPACE;modifyPoint;$NniP$;22|
        ((|space| ($)) (|which| (|NonNegativeInteger|)) (|point| (|Point| R))
         ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |space| (QREFELT $ 16))
           (SEQ (SPADCALL (QVELT |space| 6) |which| |point| (QREFELT $ 57))
                (EXIT |space|)))
          ('T
           (|error|
            "You need to pass a top level SubSpace (level should be zero)"))))) 

(SDEFUN |SUBSPACE;closeComponent;$LB$;23|
        ((|space| ($)) (|path| (|List| (|NonNegativeInteger|)))
         (|val| (|Boolean|)) ($ ($)))
        (SPROG ((|node| ($)) (#1=#:G868 NIL) (|i| NIL))
               (SEQ (LETT |node| |space|)
                    (SEQ (LETT |i| NIL) (LETT #1# |path|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |node| (SPADCALL |node| |i| (QREFELT $ 31)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (SPADCALL (QVELT |node| 2) |val| (QREFELT $ 59))
                    (EXIT |space|)))) 

(SDEFUN |SUBSPACE;defineProperty;$LSscp$;24|
        ((|space| ($)) (|path| (|List| (|NonNegativeInteger|)))
         (|prop| (|SubSpaceComponentProperty|)) ($ ($)))
        (SPROG ((|node| ($)) (#1=#:G873 NIL) (|i| NIL))
               (SEQ (LETT |node| |space|)
                    (SEQ (LETT |i| NIL) (LETT #1# |path|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |node| (SPADCALL |node| |i| (QREFELT $ 31)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (QSETVELT |node| 2 |prop|) (EXIT |space|)))) 

(SDEFUN |SUBSPACE;traverse;$L$;25|
        ((|space| ($)) (|path| (|List| (|NonNegativeInteger|))) ($ ($)))
        (SPROG ((#1=#:G878 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| NIL) (LETT #1# |path|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |space| (SPADCALL |space| |i| (QREFELT $ 31)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |space|)))) 

(SDEFUN |SUBSPACE;extractPoint;$P;26| ((|space| ($)) ($ (|Point| R)))
        (SPROG ((|node| ($)))
               (SEQ (LETT |node| |space|)
                    (SEQ G190
                         (COND
                          ((NULL (NULL (SPADCALL |node| (QREFELT $ 16))))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |node| (SPADCALL |node| (QREFELT $ 63)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL (QVELT |node| 6) (QVELT |space| 1)
                               (QREFELT $ 52)))))) 

(PUT '|SUBSPACE;extractIndex;$Nni;27| '|SPADreplace|
     '(XLAM (|space|) (QVELT |space| 1))) 

(SDEFUN |SUBSPACE;extractIndex;$Nni;27|
        ((|space| ($)) ($ (|NonNegativeInteger|))) (QVELT |space| 1)) 

(SDEFUN |SUBSPACE;extractClosed;$B;28| ((|space| ($)) ($ (|Boolean|)))
        (SPADCALL (QVELT |space| 2) (QREFELT $ 66))) 

(PUT '|SUBSPACE;extractProperty;$Sscp;29| '|SPADreplace|
     '(XLAM (|space|) (QVELT |space| 2))) 

(SDEFUN |SUBSPACE;extractProperty;$Sscp;29|
        ((|space| ($)) ($ (|SubSpaceComponentProperty|))) (QVELT |space| 2)) 

(SDEFUN |SUBSPACE;parent;2$;30| ((|space| ($)) ($ ($)))
        (COND
         ((SPADCALL (QVELT |space| 10) (QREFELT $ 14))
          (|error| "This is a top level SubSpace - it does not have a parent"))
         ('T (SPADCALL (QVELT |space| 10) (QREFELT $ 44))))) 

(PUT '|SUBSPACE;pointData;$L;31| '|SPADreplace|
     '(XLAM (|space|) (QVELT |space| 6))) 

(SDEFUN |SUBSPACE;pointData;$L;31| ((|space| ($)) ($ (|List| (|Point| R))))
        (QVELT |space| 6)) 

(PUT '|SUBSPACE;level;$Nni;32| '|SPADreplace|
     '(XLAM (|space|) (QVELT |space| 5))) 

(SDEFUN |SUBSPACE;level;$Nni;32| ((|space| ($)) ($ (|NonNegativeInteger|)))
        (QVELT |space| 5)) 

(SDEFUN |SUBSPACE;=;2$B;33| ((|s1| ($)) (|s2| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G898 NIL) (#2=#:G897 #3=(|Boolean|)) (#4=#:G899 #3#)
          (#5=#:G904 NIL) (|c1| NIL) (#6=#:G905 NIL) (|c2| NIL))
         (SEQ
          (COND
           ((SPADCALL |s1| (QREFELT $ 15))
            (COND
             ((SPADCALL |s2| (QREFELT $ 15))
              (EXIT
               (COND
                ((SPADCALL (QVELT |s1| 0) (QVELT |s2| 0) (QREFELT $ 71))
                 (COND
                  ((SPADCALL (QVELT |s1| 2) (QVELT |s2| 2) (QREFELT $ 72))
                   (EQL (QVELT |s1| 5) (QVELT |s2| 5)))
                  (#7='T NIL)))
                (#7# NIL)))))))
          (EXIT
           (COND
            ((OR
              (OR
               (SPADCALL (SPADCALL (QVELT |s1| 3) (QREFELT $ 73))
                         (SPADCALL (QVELT |s2| 3) (QREFELT $ 73))
                         (QREFELT $ 74))
               (NULL
                (PROGN
                 (LETT #1# NIL)
                 (SEQ (LETT |c2| NIL) (LETT #6# (QVELT |s2| 3)) (LETT |c1| NIL)
                      (LETT #5# (QVELT |s1| 3)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |c1| (CAR #5#)) NIL)
                            (ATOM #6#) (PROGN (LETT |c2| (CAR #6#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #4# (SPADCALL |c1| |c2| (QREFELT $ 75)))
                         (COND (#1# (LETT #2# (COND (#2# #4#) ('T NIL))))
                               ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                      (LETT #5# (PROG1 (CDR #5#) (LETT #6# (CDR #6#))))
                      (GO G190) G191 (EXIT NIL))
                 (COND (#1# #2#) (#7# 'T)))))
              (NULL (SPADCALL (QVELT |s1| 2) (QVELT |s2| 2) (QREFELT $ 72))))
             NIL)
            ('T (EQL (QVELT |s1| 5) (QVELT |s2| 5)))))))) 

(SDEFUN |SUBSPACE;coerce;$Of;34| ((|space| ($)) ($ (|OutputForm|)))
        (SPROG ((|s| (|NonNegativeInteger|)))
               (SPADCALL
                (LIST (SPADCALL (QREFELT $ 6) (QREFELT $ 78))
                      (SPADCALL "-Space with depth of " (QREFELT $ 80))
                      (SPADCALL (- (QREFELT $ 6) (QVELT |space| 5))
                                (QREFELT $ 81))
                      (SPADCALL " and " (QREFELT $ 80))
                      (SPADCALL
                       (LETT |s| (SPADCALL (QVELT |space| 3) (QREFELT $ 73)))
                       (QREFELT $ 82))
                      (SPADCALL
                       (COND ((EQL |s| 1) " component") ('T " components"))
                       (QREFELT $ 80)))
                (QREFELT $ 83)))) 

(DECLAIM (NOTINLINE |SubSpace;|)) 

(DEFUN |SubSpace| (&REST #1=#:G907)
  (SPROG NIL
         (PROG (#2=#:G908)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|SubSpace|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SubSpace;|) #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|SubSpace|)))))))))) 

(DEFUN |SubSpace;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|SubSpace| DV$1 DV$2))
          (LETT $ (GETREFV 87))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SubSpace| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8
                    (|Record| (|:| |pt| (|Point| |#2|))
                              (|:| |index| (|NonNegativeInteger|))
                              (|:| |property| (|SubSpaceComponentProperty|))
                              (|:| |childrenField| (|List| $))
                              (|:| |lastChild| (|List| $))
                              (|:| |levelField| (|NonNegativeInteger|))
                              (|:| |pointDataField| (|List| (|Point| |#2|)))
                              (|:| |lastPoint| (|List| (|Point| |#2|)))
                              (|:| |noPoints| (|NonNegativeInteger|))
                              (|:| |noChildren| (|NonNegativeInteger|))
                              (|:| |parentField| (|List| $))))
          (QSETREFV $ 9 "Non-null list: Please inform Stephen Watt")
          $))) 

(MAKEPROP '|SubSpace| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              'TELLWATT (|List| $) |SUBSPACE;children;$L;8| (|Boolean|)
              (|List| $$) (0 . |empty?|) |SUBSPACE;leaf?;$B;1|
              |SUBSPACE;root?;$B;2| |SUBSPACE;internal?;$B;3| (|List| 7)
              (|Point| 7) (5 . |point|) (|SubSpaceComponentProperty|)
              (10 . |new|) |SUBSPACE;new;$;4| |SUBSPACE;subspace;$;5|
              (14 . |rest|) (19 . |setrest!|) |SUBSPACE;birth;2$;6| (|Integer|)
              (25 . |elt|) (|NonNegativeInteger|) |SUBSPACE;child;$Nni$;7|
              |SUBSPACE;numberOfChildren;$Nni;9| (31 . |copy|) (|List| 19)
              (36 . |copy|) (41 . |tail|) |SUBSPACE;shallowCopy;2$;10|
              |SUBSPACE;deepCopy;2$;11| (46 . |cons|) (52 . |reverse!|)
              (57 . |tail|) (62 . |append|) |SUBSPACE;merge;3$;12|
              (68 . |first|) |SUBSPACE;merge;L$;13| |SUBSPACE;separate;$L;14|
              (73 . |setrest!|) (|List| 30) |SUBSPACE;addPoint;$LP$;15|
              |SUBSPACE;addPoint2;$P$;16| |SUBSPACE;addPointLast;2$PNni$;17|
              (79 . |elt|) |SUBSPACE;addPoint;$LNni$;18|
              |SUBSPACE;addPoint;$PNni;19| |SUBSPACE;modifyPoint;$LP$;20|
              |SUBSPACE;modifyPoint;$LNni$;21| (85 . |setelt!|)
              |SUBSPACE;modifyPoint;$NniP$;22| (92 . |close|)
              |SUBSPACE;closeComponent;$LB$;23|
              |SUBSPACE;defineProperty;$LSscp$;24| |SUBSPACE;traverse;$L$;25|
              |SUBSPACE;parent;2$;30| |SUBSPACE;extractPoint;$P;26|
              |SUBSPACE;extractIndex;$Nni;27| (98 . |closed?|)
              |SUBSPACE;extractClosed;$B;28|
              |SUBSPACE;extractProperty;$Sscp;29| |SUBSPACE;pointData;$L;31|
              |SUBSPACE;level;$Nni;32| (103 . =) (109 . =) (115 . |#|)
              (120 . ~=) |SUBSPACE;=;2$B;33| (|OutputForm|) (|PositiveInteger|)
              (126 . |coerce|) (|String|) (131 . |message|) (136 . |coerce|)
              (141 . |coerce|) (146 . |hconcat|) |SUBSPACE;coerce;$Of;34|
              (|SingleInteger|) (|HashState|))
           '#(~= 151 |traverse| 157 |subspace| 163 |shallowCopy| 167 |separate|
              172 |root?| 177 |pointData| 182 |parent| 187 |numberOfChildren|
              192 |new| 197 |modifyPoint| 201 |merge| 222 |level| 233 |leaf?|
              238 |latex| 243 |internal?| 248 |hashUpdate!| 253 |hash| 259
              |extractProperty| 264 |extractPoint| 269 |extractIndex| 274
              |extractClosed| 279 |defineProperty| 284 |deepCopy| 291 |coerce|
              296 |closeComponent| 301 |children| 308 |child| 313 |birth| 319
              |addPointLast| 324 |addPoint2| 332 |addPoint| 338 = 358)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 76))
                        (|makeByteWordVec2| 86
                                            '(1 13 12 0 14 1 19 0 18 20 0 21 0
                                              22 1 13 0 0 25 2 13 0 0 0 26 2 13
                                              2 0 28 29 1 21 0 0 33 1 34 0 0 35
                                              1 34 0 0 36 2 13 0 2 0 39 1 13 0
                                              0 40 1 13 0 0 41 2 13 0 0 0 42 1
                                              13 2 0 44 2 34 0 0 0 47 2 34 19 0
                                              28 52 3 34 19 0 28 19 57 2 21 12
                                              0 12 59 1 21 12 0 66 2 19 12 0 0
                                              71 2 21 12 0 0 72 1 13 30 0 73 2
                                              30 12 0 0 74 1 77 76 0 78 1 76 0
                                              79 80 1 28 76 0 81 1 30 76 0 82 1
                                              76 0 10 83 2 0 12 0 0 1 2 0 0 0
                                              48 62 0 0 0 24 1 0 0 0 37 1 0 10
                                              0 46 1 0 12 0 16 1 0 34 0 69 1 0
                                              0 0 63 1 0 30 0 32 0 0 0 23 3 0 0
                                              0 30 19 58 3 0 0 0 48 30 56 3 0 0
                                              0 48 19 55 2 0 0 0 0 43 1 0 0 10
                                              45 1 0 30 0 70 1 0 12 0 15 1 0 79
                                              0 1 1 0 12 0 17 2 0 86 86 0 1 1 0
                                              85 0 1 1 0 21 0 68 1 0 19 0 64 1
                                              0 30 0 65 1 0 12 0 67 3 0 0 0 48
                                              21 61 1 0 0 0 38 1 0 76 0 84 3 0
                                              0 0 48 12 60 1 0 10 0 11 2 0 0 0
                                              30 31 1 0 0 0 27 4 0 0 0 0 19 30
                                              51 2 0 0 0 19 50 2 0 30 0 19 54 3
                                              0 0 0 48 30 53 3 0 0 0 48 19 49 2
                                              0 12 0 0 75)))))
           '|lookupComplete|)) 

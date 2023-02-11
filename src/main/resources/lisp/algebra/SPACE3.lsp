
(SDEFUN |SPACE3;convertSpace| ((|space| ($)) ($ ($)))
        (SPROG
         ((|lllipt| (|List| (|List| (|List| (|NonNegativeInteger|)))))
          (|llprop| (|List| (|List| (|SubSpaceComponentProperty|))))
          (|tmpllipt| (|List| (|List| (|NonNegativeInteger|))))
          (|tmplipt| (|List| (|NonNegativeInteger|))) (#1=#:G745 NIL)
          (|point| NIL) (|tmplprop| (|List| (|SubSpaceComponentProperty|)))
          (#2=#:G744 NIL) (|curve| NIL)
          (|lprop| (|List| (|SubSpaceComponentProperty|))) (#3=#:G743 NIL)
          (|component| NIL))
         (SEQ
          (COND ((QVELT |space| 4) |space|)
                ('T
                 (SEQ (QSETVELT |space| 4 'T) (LETT |lllipt| NIL)
                      (LETT |llprop| NIL) (LETT |lprop| NIL)
                      (SEQ (LETT |component| NIL)
                           (LETT #3#
                                 (SPADCALL (QVELT |space| 0) (QREFELT $ 10)))
                           G190
                           (COND
                            ((OR (ATOM #3#)
                                 (PROGN (LETT |component| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |lprop|
                                  (CONS (SPADCALL |component| (QREFELT $ 12))
                                        |lprop|))
                            (LETT |tmpllipt| NIL) (LETT |tmplprop| NIL)
                            (SEQ (LETT |curve| NIL)
                                 (LETT #2#
                                       (SPADCALL |component| (QREFELT $ 10)))
                                 G190
                                 (COND
                                  ((OR (ATOM #2#)
                                       (PROGN (LETT |curve| (CAR #2#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |tmplprop|
                                        (CONS (SPADCALL |curve| (QREFELT $ 12))
                                              |tmplprop|))
                                  (LETT |tmplipt| NIL)
                                  (SEQ (LETT |point| NIL)
                                       (LETT #1#
                                             (SPADCALL |curve| (QREFELT $ 10)))
                                       G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN
                                              (LETT |point| (CAR #1#))
                                              NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT |tmplipt|
                                               (CONS
                                                (SPADCALL |point|
                                                          (QREFELT $ 14))
                                                |tmplipt|))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT NIL))
                                  (EXIT
                                   (LETT |tmpllipt|
                                         (CONS (NREVERSE |tmplipt|)
                                               |tmpllipt|))))
                                 (LETT #2# (CDR #2#)) (GO G190) G191
                                 (EXIT NIL))
                            (LETT |llprop|
                                  (CONS (NREVERSE |tmplprop|) |llprop|))
                            (EXIT
                             (LETT |lllipt|
                                   (CONS (NREVERSE |tmpllipt|) |lllipt|))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                      (QSETVELT |space| 2
                                (VECTOR
                                 (SPADCALL (QVELT |space| 0) (QREFELT $ 16))
                                 (NREVERSE |lllipt|) (NREVERSE |llprop|)
                                 (NREVERSE |lprop|)))
                      (EXIT |space|))))))) 

(SDEFUN |SPACE3;polygon;$L$;2|
        ((|space| ($)) (|points| (|List| (|Point| R))) ($ ($)))
        (SPROG ((#1=#:G751 NIL) (|p| NIL) (|pt| (|SubSpace| 3 R)))
               (SEQ
                (COND
                 ((< (LENGTH |points|) 3)
                  (|error| "You need at least 3 points to define a polygon"))
                 ('T
                  (SEQ
                   (LETT |pt|
                         (SPADCALL (QVELT |space| 0) (|SPADfirst| |points|)
                                   (QREFELT $ 18)))
                   (LETT |points| (CDR |points|))
                   (SPADCALL (QVELT |space| 0) |pt| (|SPADfirst| |points|) 1
                             (QREFELT $ 19))
                   (SEQ (LETT |p| NIL) (LETT #1# (CDR |points|)) G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (SPADCALL (QVELT |space| 0) |pt| |p| 2
                                    (QREFELT $ 19))))
                        (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                   (QSETVELT |space| 4 NIL) (EXIT |space|))))))) 

(SDEFUN |SPACE3;create3Space;$;3| (($ ($)))
        (VECTOR (SPADCALL (QREFELT $ 21)) NIL (VECTOR NIL NIL NIL NIL)
                (VECTOR 0 0 0 0) NIL)) 

(SDEFUN |SPACE3;create3Space;Ss$;4| ((|s| (|SubSpace| 3 R)) ($ ($)))
        (VECTOR |s| NIL (VECTOR NIL NIL NIL NIL) (VECTOR 0 0 0 0) NIL)) 

(SDEFUN |SPACE3;numberOfComponents;$Nni;5|
        ((|space| ($)) ($ (|NonNegativeInteger|)))
        (LENGTH (SPADCALL (QVELT |space| 0) (QREFELT $ 10)))) 

(SDEFUN |SPACE3;numberOfComposites;$Nni;6|
        ((|space| ($)) ($ (|NonNegativeInteger|))) (LENGTH (QVELT |space| 1))) 

(SDEFUN |SPACE3;merge;L$;7| ((|listOfThreeSpaces| (|List| $)) ($ ($)))
        (SPROG
         ((#1=#:G768 NIL) (|ts| NIL) (|newspace| ($)) (#2=#:G767 NIL)
          (#3=#:G766 NIL))
         (SEQ
          (LETT |newspace|
                (SPADCALL
                 (SPADCALL
                  (PROGN
                   (LETT #3# NIL)
                   (SEQ (LETT |ts| NIL) (LETT #2# |listOfThreeSpaces|) G190
                        (COND
                         ((OR (ATOM #2#) (PROGN (LETT |ts| (CAR #2#)) NIL))
                          (GO G191)))
                        (SEQ (EXIT (LETT #3# (CONS (QVELT |ts| 0) #3#))))
                        (LETT #2# (CDR #2#)) (GO G190) G191
                        (EXIT (NREVERSE #3#))))
                  (QREFELT $ 27))
                 (QREFELT $ 24)))
          (SEQ (LETT |ts| NIL) (LETT #1# |listOfThreeSpaces|) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |ts| (CAR #1#)) NIL)) (GO G191)))
               (SEQ
                (EXIT
                 (QSETVELT |newspace| 1
                           (SPADCALL (QVELT |ts| 1) (QVELT |newspace| 1)
                                     (QREFELT $ 29)))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (EXIT |newspace|)))) 

(SDEFUN |SPACE3;merge;3$;8| ((|s1| ($)) (|s2| ($)) ($ ($)))
        (SPADCALL (LIST |s1| |s2|) (QREFELT $ 30))) 

(SDEFUN |SPACE3;composite;L$;9| ((|listOfThreeSpaces| (|List| $)) ($ ($)))
        (SPROG ((#1=#:G775 NIL) (|s| NIL) (#2=#:G774 NIL) (|space| ($)))
               (SEQ (LETT |space| (SPADCALL (QREFELT $ 23)))
                    (QSETVELT |space| 0
                              (SPADCALL
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |s| NIL)
                                     (LETT #1# |listOfThreeSpaces|) G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |s| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #2# (CONS (QVELT |s| 0) #2#))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT (NREVERSE #2#))))
                               (QREFELT $ 27)))
                    (QSETVELT |space| 1
                              (LIST
                               (SPADCALL (QVELT |space| 0) (QREFELT $ 32))))
                    (EXIT |space|)))) 

(SDEFUN |SPACE3;components;$L;10| ((|space| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G780 NIL) (|s| NIL) (#2=#:G779 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |s| NIL)
                      (LETT #1# (SPADCALL (QVELT |space| 0) (QREFELT $ 34)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |s| (QREFELT $ 24)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SPACE3;composites;$L;11| ((|space| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G785 NIL) (|s| NIL) (#2=#:G784 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |s| NIL) (LETT #1# (QVELT |space| 1)) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |s| (QREFELT $ 24)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SPACE3;copy;2$;12| ((|space| ($)) ($ ($)))
        (SPROG ((#1=#:G791 NIL) (|s| NIL) (#2=#:G790 NIL) (|spc| ($)))
               (SEQ
                (LETT |spc|
                      (SPADCALL (SPADCALL (QVELT |space| 0) (QREFELT $ 32))
                                (QREFELT $ 24)))
                (QSETVELT |spc| 1
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |s| NIL) (LETT #1# (QVELT |space| 1))
                                G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |s| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |s| (QREFELT $ 32))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#)))))
                (EXIT |spc|)))) 

(SDEFUN |SPACE3;enterPointData;$LNni;13|
        ((|space| ($)) (|listOfPoints| (|List| (|Point| R)))
         ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G796 NIL) (|p| NIL))
               (SEQ
                (SEQ (LETT |p| NIL) (LETT #1# |listOfPoints|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT (SPADCALL (QVELT |space| 0) |p| (QREFELT $ 38))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT (LENGTH (SPADCALL (QVELT |space| 0) (QREFELT $ 16))))))) 

(SDEFUN |SPACE3;modifyPointData;$NniP$;14|
        ((|space| ($)) (|i| (|NonNegativeInteger|)) (|p| (|Point| R)) ($ ($)))
        (SEQ (SPADCALL (QVELT |space| 0) |i| |p| (QREFELT $ 40))
             (EXIT |space|))) 

(SDEFUN |SPACE3;point?;$B;15| ((|space| ($)) ($ (|Boolean|)))
        (SPROG ((|kid| #1=(|List| (|SubSpace| 3 R))) (|c| #1#))
               (COND
                ((>
                  (LENGTH
                   (LETT |c| (SPADCALL (QVELT |space| 0) (QREFELT $ 10))))
                  1)
                 (|error| "This ThreeSpace has more than one component"))
                ((EQL
                  (LENGTH
                   (LETT |kid| (SPADCALL (|SPADfirst| |c|) (QREFELT $ 10))))
                  1)
                 (EQL (LENGTH (SPADCALL (|SPADfirst| |kid|) (QREFELT $ 10)))
                      1))
                ('T NIL)))) 

(SDEFUN |SPACE3;point;$P;16| ((|space| ($)) ($ (|Point| R)))
        (COND
         ((SPADCALL |space| (QREFELT $ 43))
          (SPADCALL (SPADCALL (QVELT |space| 0) (LIST 1 1 1) (QREFELT $ 45))
                    (QREFELT $ 46)))
         ('T
          (|error|
           "This ThreeSpace holds something other than a single point - try the objects() command")))) 

(SDEFUN |SPACE3;point;P$;17| ((|aPoint| (|Point| R)) ($ ($)))
        (SPADCALL (SPADCALL (QREFELT $ 23)) |aPoint| (QREFELT $ 48))) 

(SDEFUN |SPACE3;point;$P$;18| ((|space| ($)) (|aPoint| (|Point| R)) ($ ($)))
        (SEQ (SPADCALL (QVELT |space| 0) NIL |aPoint| (QREFELT $ 50))
             (QSETVELT |space| 4 NIL) (EXIT |space|))) 

(SDEFUN |SPACE3;point;$L$;19| ((|space| ($)) (|l| (|List| R)) ($ ($)))
        (SPROG ((|pt| (|Point| R)))
               (SEQ (LETT |pt| (SPADCALL |l| (QREFELT $ 52)))
                    (EXIT (SPADCALL |space| |pt| (QREFELT $ 48)))))) 

(SDEFUN |SPACE3;point;$Nni$;20|
        ((|space| ($)) (|i| (|NonNegativeInteger|)) ($ ($)))
        (SEQ (SPADCALL (QVELT |space| 0) NIL |i| (QREFELT $ 54))
             (QSETVELT |space| 4 NIL) (EXIT |space|))) 

(SDEFUN |SPACE3;curve?;$B;21| ((|space| ($)) ($ (|Boolean|)))
        (SPROG ((|c| (|List| (|SubSpace| 3 R))))
               (COND
                ((>
                  (LENGTH
                   (LETT |c| (SPADCALL (QVELT |space| 0) (QREFELT $ 10))))
                  1)
                 (|error| "This ThreeSpace has more than one component"))
                ('T
                 (EQL (LENGTH (SPADCALL (|SPADfirst| |c|) (QREFELT $ 10)))
                      1))))) 

(SDEFUN |SPACE3;curve;$L;22| ((|space| ($)) ($ (|List| (|Point| R))))
        (SPROG
         ((#1=#:G821 NIL) (|s| NIL) (#2=#:G820 NIL) (|spc| (|SubSpace| 3 R)))
         (SEQ
          (COND
           ((SPADCALL |space| (QREFELT $ 56))
            (SEQ
             (LETT |spc|
                   (|SPADfirst|
                    (SPADCALL
                     (|SPADfirst| (SPADCALL (QVELT |space| 0) (QREFELT $ 10)))
                     (QREFELT $ 10))))
             (EXIT
              (PROGN
               (LETT #2# NIL)
               (SEQ (LETT |s| NIL) (LETT #1# (SPADCALL |spc| (QREFELT $ 10)))
                    G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (LETT #2# (CONS (SPADCALL |s| (QREFELT $ 46)) #2#))))
                    (LETT #1# (CDR #1#)) (GO G190) G191
                    (EXIT (NREVERSE #2#)))))))
           ('T
            (|error|
             "This ThreeSpace holds something other than a curve - try the objects() command")))))) 

(SDEFUN |SPACE3;curve;L$;23| ((|points| (|List| (|Point| R))) ($ ($)))
        (SPADCALL (SPADCALL (QREFELT $ 23)) |points| (QREFELT $ 58))) 

(SDEFUN |SPACE3;curve;$L$;24|
        ((|space| ($)) (|points| (|List| (|Point| R))) ($ ($)))
        (SPROG
         ((#1=#:G827 NIL) (|p| NIL) (|path| (|List| (|NonNegativeInteger|))))
         (SEQ
          (SPADCALL (QVELT |space| 0) NIL (|SPADfirst| |points|)
                    (QREFELT $ 50))
          (LETT |path|
                (LIST (LENGTH (SPADCALL (QVELT |space| 0) (QREFELT $ 10))) 1))
          (SEQ (LETT |p| NIL) (LETT #1# (CDR |points|)) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL)) (GO G191)))
               (SEQ
                (EXIT (SPADCALL (QVELT |space| 0) |path| |p| (QREFELT $ 50))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (QSETVELT |space| 4 NIL) (EXIT |space|)))) 

(SDEFUN |SPACE3;curve;$L$;25|
        ((|space| ($)) (|points| (|List| (|List| R))) ($ ($)))
        (SPROG ((|pts| (|List| (|Point| R))))
               (SEQ (LETT |pts| (SPADCALL (ELT $ 52) |points| (QREFELT $ 63)))
                    (EXIT (SPADCALL |space| |pts| (QREFELT $ 58)))))) 

(SDEFUN |SPACE3;closedCurve?;$B;26| ((|space| ($)) ($ (|Boolean|)))
        (SPROG ((|kid| #1=(|List| (|SubSpace| 3 R))) (|c| #1#))
               (COND
                ((>
                  (LENGTH
                   (LETT |c| (SPADCALL (QVELT |space| 0) (QREFELT $ 10))))
                  1)
                 (|error| "This ThreeSpace has more than one component"))
                ((EQL
                  (LENGTH
                   (LETT |kid| (SPADCALL (|SPADfirst| |c|) (QREFELT $ 10))))
                  1)
                 (SPADCALL (|SPADfirst| |kid|) (QREFELT $ 65)))
                ('T NIL)))) 

(SDEFUN |SPACE3;closedCurve;$L;27| ((|space| ($)) ($ (|List| (|Point| R))))
        (SPROG
         ((#1=#:G842 NIL) (|s| NIL) (#2=#:G841 NIL) (|spc| (|SubSpace| 3 R)))
         (SEQ
          (COND
           ((SPADCALL |space| (QREFELT $ 66))
            (SEQ
             (LETT |spc|
                   (|SPADfirst|
                    (SPADCALL
                     (|SPADfirst| (SPADCALL (QVELT |space| 0) (QREFELT $ 10)))
                     (QREFELT $ 10))))
             (EXIT
              (PROGN
               (LETT #2# NIL)
               (SEQ (LETT |s| NIL) (LETT #1# (SPADCALL |spc| (QREFELT $ 10)))
                    G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (LETT #2# (CONS (SPADCALL |s| (QREFELT $ 46)) #2#))))
                    (LETT #1# (CDR #1#)) (GO G190) G191
                    (EXIT (NREVERSE #2#)))))))
           ('T
            (|error|
             "This ThreeSpace holds something other than a curve - try the objects() command")))))) 

(SDEFUN |SPACE3;closedCurve;L$;28| ((|points| (|List| (|Point| R))) ($ ($)))
        (SPADCALL (SPADCALL (QREFELT $ 23)) |points| (QREFELT $ 68))) 

(SDEFUN |SPACE3;closedCurve;$L$;29|
        ((|space| ($)) (|points| (|List| (|Point| R))) ($ ($)))
        (SPROG
         ((#1=#:G848 NIL) (|p| NIL) (|path| (|List| (|NonNegativeInteger|))))
         (SEQ
          (SPADCALL (QVELT |space| 0) NIL (|SPADfirst| |points|)
                    (QREFELT $ 50))
          (LETT |path|
                (LIST (LENGTH (SPADCALL (QVELT |space| 0) (QREFELT $ 10))) 1))
          (SPADCALL (QVELT |space| 0) |path| 'T (QREFELT $ 70))
          (SEQ (LETT |p| NIL) (LETT #1# (CDR |points|)) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL)) (GO G191)))
               (SEQ
                (EXIT (SPADCALL (QVELT |space| 0) |path| |p| (QREFELT $ 50))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (QSETVELT |space| 4 NIL) (EXIT |space|)))) 

(SDEFUN |SPACE3;closedCurve;$L$;30|
        ((|space| ($)) (|points| (|List| (|List| R))) ($ ($)))
        (SPROG ((|pts| (|List| (|Point| R))))
               (SEQ (LETT |pts| (SPADCALL (ELT $ 52) |points| (QREFELT $ 63)))
                    (EXIT (SPADCALL |space| |pts| (QREFELT $ 68)))))) 

(SDEFUN |SPACE3;polygon?;$B;31| ((|space| ($)) ($ (|Boolean|)))
        (SPROG ((|kid| #1=(|List| (|SubSpace| 3 R))) (|c| #1#))
               (COND
                ((>
                  (LENGTH
                   (LETT |c| (SPADCALL (QVELT |space| 0) (QREFELT $ 10))))
                  1)
                 (|error| "This ThreeSpace has more than one component"))
                ((EQL
                  (LENGTH
                   (LETT |kid| (SPADCALL (|SPADfirst| |c|) (QREFELT $ 10))))
                  2)
                 (COND
                  ((EQL (LENGTH (SPADCALL (|SPADfirst| |kid|) (QREFELT $ 10)))
                        1)
                   (>
                    (LENGTH
                     (SPADCALL (SPADCALL |kid| (QREFELT $ 72)) (QREFELT $ 10)))
                    2))
                  (#2='T NIL)))
                (#2# NIL)))) 

(SDEFUN |SPACE3;polygon;$L;32| ((|space| ($)) ($ (|List| (|Point| R))))
        (SPROG
         ((#1=#:G866 NIL) (|s| NIL) (#2=#:G865 NIL)
          (|cs| (|List| (|SubSpace| 3 R))))
         (SEQ
          (COND
           ((SPADCALL |space| (QREFELT $ 73))
            (SEQ
             (LETT |cs|
                   (SPADCALL
                    (|SPADfirst| (SPADCALL (QVELT |space| 0) (QREFELT $ 10)))
                    (QREFELT $ 10)))
             (EXIT
              (PROGN
               (LETT #2# NIL)
               (SEQ (LETT |s| NIL)
                    (LETT #1#
                          (SPADCALL (SPADCALL |cs| (QREFELT $ 72))
                                    (QREFELT $ 10)))
                    G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (LETT #2# (CONS (SPADCALL |s| (QREFELT $ 46)) #2#))))
                    (LETT #1# (CDR #1#)) (GO G190) G191
                    (EXIT (NREVERSE #2#)))))))
           ('T
            (|error|
             "This ThreeSpace holds something other than a polygon - try the objects() command")))))) 

(SDEFUN |SPACE3;polygon;L$;33| ((|points| (|List| (|Point| R))) ($ ($)))
        (SPADCALL (SPADCALL (QREFELT $ 23)) |points| (QREFELT $ 20))) 

(SDEFUN |SPACE3;polygon;$L$;34|
        ((|space| ($)) (|points| (|List| (|List| R))) ($ ($)))
        (SPROG ((|pts| (|List| (|Point| R))))
               (SEQ (LETT |pts| (SPADCALL (ELT $ 52) |points| (QREFELT $ 63)))
                    (EXIT (SPADCALL |space| |pts| (QREFELT $ 20)))))) 

(SDEFUN |SPACE3;mesh?;$B;35| ((|space| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G879 NIL) (|eachCurve| NIL)
          (|whatSizes| (|Set| (|NonNegativeInteger|)))
          (|kid| #2=(|List| (|SubSpace| 3 R))) (|c| #2#))
         (SEQ
          (COND
           ((> (LENGTH (LETT |c| (SPADCALL (QVELT |space| 0) (QREFELT $ 10))))
               1)
            (|error| "This ThreeSpace has more than one component"))
           ((>
             (LENGTH (LETT |kid| (SPADCALL (|SPADfirst| |c|) (QREFELT $ 10))))
             1)
            (SEQ (LETT |whatSizes| (SPADCALL (QREFELT $ 78)))
                 (SEQ (LETT |eachCurve| NIL) (LETT #1# |kid|) G190
                      (COND
                       ((OR (ATOM #1#)
                            (PROGN (LETT |eachCurve| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (SPADCALL
                         (LENGTH (SPADCALL |eachCurve| (QREFELT $ 10)))
                         |whatSizes| (QREFELT $ 79))))
                      (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (COND
                   ((> (SPADCALL |whatSizes| (QREFELT $ 80)) 1)
                    (|error| "Mesh defined with curves of different sizes"))
                   ((< (|SPADfirst| (SPADCALL |whatSizes| (QREFELT $ 81))) 2)
                    (|error|
                     "Mesh defined with single point curves (use curve())"))
                   (#3='T 'T)))))
           (#3# NIL))))) 

(SDEFUN |SPACE3;mesh;$L;36| ((|space| ($)) ($ (|List| (|List| (|Point| R)))))
        (SPROG
         ((|llp| (|List| (|List| (|Point| R)))) (#1=#:G889 NIL) (|s| NIL)
          (#2=#:G888 NIL) (#3=#:G887 NIL) (|lpSpace| NIL))
         (SEQ
          (COND
           ((SPADCALL |space| (QREFELT $ 82))
            (SEQ (LETT |llp| NIL)
                 (SEQ (LETT |lpSpace| NIL)
                      (LETT #3#
                            (SPADCALL
                             (|SPADfirst|
                              (SPADCALL (QVELT |space| 0) (QREFELT $ 10)))
                             (QREFELT $ 10)))
                      G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |lpSpace| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT |llp|
                              (CONS
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |s| NIL)
                                     (LETT #1#
                                           (SPADCALL |lpSpace| (QREFELT $ 10)))
                                     G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |s| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #2#
                                             (CONS
                                              (SPADCALL |s| (QREFELT $ 46))
                                              #2#))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT (NREVERSE #2#))))
                               |llp|))))
                      (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                 (EXIT |llp|)))
           ('T
            (|error|
             "This ThreeSpace holds something other than a mesh - try the objects() command")))))) 

(SDEFUN |SPACE3;mesh;L$;37| ((|points| (|List| (|List| (|Point| R)))) ($ ($)))
        (SPADCALL (SPADCALL (QREFELT $ 23)) |points| NIL NIL (QREFELT $ 85))) 

(SDEFUN |SPACE3;mesh;L2B$;38|
        ((|points| (|List| (|List| (|Point| R)))) (|prop1| #1=(|Boolean|))
         (|prop2| #1#) ($ ($)))
        (SPADCALL (SPADCALL (QREFELT $ 23)) |points| |prop1| |prop2|
                  (QREFELT $ 85))) 

(SDEFUN |SPACE3;mesh;$LLSscp$;39|
        ((|space| ($)) (|llpoints| (|List| (|List| (|List| R))))
         (|lprops| (|List| #1=(|SubSpaceComponentProperty|))) (|prop| #1#)
         ($ ($)))
        (SPROG
         ((|pts| (|List| (|List| (|Point| R)))) (#2=#:G899 NIL) (|points| NIL)
          (#3=#:G898 NIL))
         (SEQ
          (LETT |pts|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |points| NIL) (LETT #2# |llpoints|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |points| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (SPADCALL (ELT $ 52) |points| (QREFELT $ 63))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (EXIT (SPADCALL |space| |pts| |lprops| |prop| (QREFELT $ 89)))))) 

(SDEFUN |SPACE3;mesh;$LLSscp$;40|
        ((|space| ($)) (|llp| (|List| (|List| (|Point| R))))
         (|lprops| (|List| #1=(|SubSpaceComponentProperty|))) (|prop| #1#)
         ($ ($)))
        (SPROG
         ((#2=#:G914 NIL) (|p| NIL) (|path| (|List| (|NonNegativeInteger|)))
          (#3=#:G912 NIL) (|lp| NIL) (#4=#:G913 NIL) (|aProp| NIL)
          (|count| NIL) (#5=#:G911 NIL))
         (SEQ
          (SPADCALL (QVELT |space| 0) NIL (|SPADfirst| (|SPADfirst| |llp|))
                    (QREFELT $ 50))
          (SPADCALL (QVELT |space| 0)
                    (LETT |path|
                          (LIST
                           (LENGTH
                            (SPADCALL (QVELT |space| 0) (QREFELT $ 10)))))
                    |prop| (QREFELT $ 92))
          (LETT |path| (SPADCALL |path| (LIST 1) (QREFELT $ 93)))
          (SPADCALL (QVELT |space| 0) |path| (|SPADfirst| |lprops|)
                    (QREFELT $ 92))
          (SEQ (LETT |p| NIL) (LETT #5# (CDR (|SPADfirst| |llp|))) G190
               (COND
                ((OR (ATOM #5#) (PROGN (LETT |p| (CAR #5#)) NIL)) (GO G191)))
               (SEQ
                (EXIT (SPADCALL (QVELT |space| 0) |path| |p| (QREFELT $ 50))))
               (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
          (SEQ (LETT |count| 2) (LETT |aProp| NIL) (LETT #4# (CDR |lprops|))
               (LETT |lp| NIL) (LETT #3# (CDR |llp|)) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |lp| (CAR #3#)) NIL) (ATOM #4#)
                     (PROGN (LETT |aProp| (CAR #4#)) NIL))
                 (GO G191)))
               (SEQ
                (SPADCALL (QVELT |space| 0)
                          (LETT |path| (LIST (|SPADfirst| |path|)))
                          (|SPADfirst| |lp|) (QREFELT $ 50))
                (LETT |path| (SPADCALL |path| (LIST |count|) (QREFELT $ 93)))
                (SPADCALL (QVELT |space| 0) |path| |aProp| (QREFELT $ 92))
                (EXIT
                 (SEQ (LETT |p| NIL) (LETT #2# (CDR |lp|)) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (SPADCALL (QVELT |space| 0) |path| |p|
                                  (QREFELT $ 50))))
                      (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
               (LETT #3#
                     (PROG1 (CDR #3#)
                       (LETT #4#
                             (PROG1 (CDR #4#)
                               (LETT |count| (|inc_SI| |count|))))))
               (GO G190) G191 (EXIT NIL))
          (QSETVELT |space| 4 NIL) (EXIT |space|)))) 

(SDEFUN |SPACE3;mesh;$L2B$;41|
        ((|space| ($)) (|llpoints| (|List| (|List| (|List| R))))
         (|prop1| #1=(|Boolean|)) (|prop2| #1#) ($ ($)))
        (SPROG
         ((|pts| (|List| (|List| (|Point| R)))) (#2=#:G922 NIL) (|points| NIL)
          (#3=#:G921 NIL))
         (SEQ
          (LETT |pts|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |points| NIL) (LETT #2# |llpoints|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |points| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (SPADCALL (ELT $ 52) |points| (QREFELT $ 63))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (EXIT (SPADCALL |space| |pts| |prop1| |prop2| (QREFELT $ 85)))))) 

(SDEFUN |SPACE3;mesh;$L2B$;42|
        ((|space| ($)) (|llp| (|List| (|List| (|Point| R))))
         (|prop1| #1=(|Boolean|)) (|prop2| #1#) ($ ($)))
        (SPROG
         ((#2=#:G934 NIL) (|p| NIL) (|path| (|List| (|NonNegativeInteger|)))
          (#3=#:G933 NIL) (|lp| NIL) (|count| NIL) (#4=#:G932 NIL)
          (|propB| #5=(|SubSpaceComponentProperty|)) (|propA| #5#))
         (SEQ (LETT |propA| (SPADCALL (QREFELT $ 95)))
              (SPADCALL |propA| |prop1| (QREFELT $ 96))
              (LETT |propB| (SPADCALL (QREFELT $ 95)))
              (SPADCALL |propB| |prop2| (QREFELT $ 96))
              (SPADCALL (QVELT |space| 0) NIL (|SPADfirst| (|SPADfirst| |llp|))
                        (QREFELT $ 50))
              (SPADCALL (QVELT |space| 0)
                        (LETT |path|
                              (LIST
                               (LENGTH
                                (SPADCALL (QVELT |space| 0) (QREFELT $ 10)))))
                        |propB| (QREFELT $ 92))
              (LETT |path| (SPADCALL |path| (LIST 1) (QREFELT $ 93)))
              (SPADCALL (QVELT |space| 0) |path| |propA| (QREFELT $ 92))
              (SEQ (LETT |p| NIL) (LETT #4# (CDR (|SPADfirst| |llp|))) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |p| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL (QVELT |space| 0) |path| |p| (QREFELT $ 50))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |count| 2) (LETT |lp| NIL) (LETT #3# (CDR |llp|)) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |lp| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (SPADCALL (QVELT |space| 0)
                              (LETT |path| (LIST (|SPADfirst| |path|)))
                              (|SPADfirst| |lp|) (QREFELT $ 50))
                    (LETT |path|
                          (SPADCALL |path| (LIST |count|) (QREFELT $ 93)))
                    (SPADCALL (QVELT |space| 0) |path| |propA| (QREFELT $ 92))
                    (EXIT
                     (SEQ (LETT |p| NIL) (LETT #2# (CDR |lp|)) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL (QVELT |space| 0) |path| |p|
                                      (QREFELT $ 50))))
                          (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #3#
                         (PROG1 (CDR #3#) (LETT |count| (|inc_SI| |count|))))
                   (GO G190) G191 (EXIT NIL))
              (QSETVELT |space| 4 NIL) (EXIT |space|)))) 

(SDEFUN |SPACE3;lp;$L;43| ((|space| ($)) ($ (|List| (|Point| R))))
        (SEQ
         (COND
          ((NULL (QVELT |space| 4))
           (LETT |space| (|SPACE3;convertSpace| |space| $))))
         (EXIT (QVELT (QVELT |space| 2) 0)))) 

(SDEFUN |SPACE3;lllip;$L;44|
        ((|space| ($)) ($ (|List| (|List| (|List| (|NonNegativeInteger|))))))
        (SEQ
         (COND
          ((NULL (QVELT |space| 4))
           (LETT |space| (|SPACE3;convertSpace| |space| $))))
         (EXIT (QVELT (QVELT |space| 2) 1)))) 

(SDEFUN |SPACE3;llprop;$L;45|
        ((|space| ($)) ($ (|List| (|List| (|SubSpaceComponentProperty|)))))
        (SEQ
         (COND
          ((NULL (QVELT |space| 4))
           (LETT |space| (|SPACE3;convertSpace| |space| $))))
         (EXIT (QVELT (QVELT |space| 2) 2)))) 

(SDEFUN |SPACE3;lprop;$L;46|
        ((|space| ($)) ($ (|List| (|SubSpaceComponentProperty|))))
        (SEQ
         (COND
          ((NULL (QVELT |space| 4))
           (LETT |space| (|SPACE3;convertSpace| |space| $))))
         (EXIT (QVELT (QVELT |space| 2) 3)))) 

(SDEFUN |SPACE3;objects;$R;47|
        ((|space| ($))
         ($
          (|Record| (|:| |points| #1=(|NonNegativeInteger|)) (|:| |curves| #1#)
                    (|:| |polygons| #1#) (|:| |constructs| #1#))))
        (SPROG
         ((|numConstructs| #2=(|NonNegativeInteger|)) (|numPolys| #2#)
          (|numCurves| #2#) (|numPts| #2#) (|kid| (|List| (|SubSpace| 3 R)))
          (#3=#:G965 NIL) (|component| NIL))
         (SEQ
          (COND
           ((NULL (QVELT |space| 4))
            (LETT |space| (|SPACE3;convertSpace| |space| $))))
          (LETT |numPts| 0) (LETT |numCurves| 0) (LETT |numPolys| 0)
          (LETT |numConstructs| 0)
          (SEQ (LETT |component| NIL)
               (LETT #3# (SPADCALL (QVELT |space| 0) (QREFELT $ 10))) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |component| (CAR #3#)) NIL))
                 (GO G191)))
               (SEQ
                (EXIT
                 (COND
                  ((EQL
                    (LENGTH (LETT |kid| (SPADCALL |component| (QREFELT $ 10))))
                    1)
                   (COND
                    ((EQL
                      (LENGTH (SPADCALL (|SPADfirst| |kid|) (QREFELT $ 10))) 1)
                     (LETT |numPts| (+ |numPts| 1)))
                    ('T (LETT |numCurves| (+ |numCurves| 1)))))
                  ('T
                   (SEQ
                    (COND
                     ((EQL (LENGTH |kid|) 2)
                      (COND
                       ((EQL
                         (LENGTH (SPADCALL (|SPADfirst| |kid|) (QREFELT $ 10)))
                         1)
                        (COND
                         ((SPADCALL
                           (LENGTH
                            (SPADCALL (|SPADfirst| (CDR |kid|))
                                      (QREFELT $ 10)))
                           1 (QREFELT $ 104))
                          (EXIT (LETT |numPolys| (+ |numPolys| 1)))))))))
                    (EXIT (LETT |numConstructs| (+ |numConstructs| 1))))))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (EXIT (VECTOR |numPts| |numCurves| |numPolys| |numConstructs|))))) 

(SDEFUN |SPACE3;check;2$;48| ((|s| ($)) ($ ($)))
        (COND ((NULL (QVELT |s| 4)) (|SPACE3;convertSpace| |s| $)) ('T |s|))) 

(PUT '|SPACE3;subspace;$Ss;49| '|SPADreplace| '(XLAM (|s|) (QVELT |s| 0))) 

(SDEFUN |SPACE3;subspace;$Ss;49| ((|s| ($)) ($ (|SubSpace| 3 R))) (QVELT |s| 0)) 

(SDEFUN |SPACE3;coerce;$Of;50| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG ((|sizo| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((NULL (QVELT |s| 4))
                  (LETT |s| (|SPACE3;convertSpace| |s| $))))
                (EXIT
                 (SPADCALL
                  (LIST (SPADCALL "3-Space with " (QREFELT $ 111))
                        (SPADCALL
                         (LETT |sizo| (LENGTH (QVELT (QVELT |s| 2) 1)))
                         (QREFELT $ 112))
                        (SPADCALL
                         (COND ((EQL |sizo| 1) " component")
                               ('T " components"))
                         (QREFELT $ 111)))
                  (QREFELT $ 113)))))) 

(DECLAIM (NOTINLINE |ThreeSpace;|)) 

(DEFUN |ThreeSpace| (#1=#:G974)
  (SPROG NIL
         (PROG (#2=#:G975)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|ThreeSpace|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|ThreeSpace;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|ThreeSpace|)))))))))) 

(DEFUN |ThreeSpace;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ThreeSpace| DV$1))
          (LETT $ (GETREFV 118))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ThreeSpace| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |subspaceField| (|SubSpace| 3 |#1|))
                              (|:| |compositesField|
                                   (|List| (|SubSpace| 3 |#1|)))
                              (|:| |rep3DField|
                                   (|Record| (|:| |lp| (|List| (|Point| |#1|)))
                                             (|:| |llliPt|
                                                  (|List|
                                                   (|List|
                                                    (|List|
                                                     (|NonNegativeInteger|)))))
                                             (|:| |llProp|
                                                  (|List|
                                                   (|List|
                                                    (|SubSpaceComponentProperty|))))
                                             (|:| |lProp|
                                                  (|List|
                                                   (|SubSpaceComponentProperty|)))))
                              (|:| |objectsField|
                                   (|Record|
                                    (|:| |points| (|NonNegativeInteger|))
                                    (|:| |curves| (|NonNegativeInteger|))
                                    (|:| |polygons| (|NonNegativeInteger|))
                                    (|:| |constructs| (|NonNegativeInteger|))))
                              (|:| |converted| (|Boolean|))))
          $))) 

(MAKEPROP '|ThreeSpace| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|List| $)
              (|SubSpace| '3 6) (0 . |children|) (|SubSpaceComponentProperty|)
              (5 . |extractProperty|) (|NonNegativeInteger|)
              (10 . |extractIndex|) (|List| 17) (15 . |pointData|) (|Point| 6)
              (20 . |addPoint2|) (26 . |addPointLast|) |SPACE3;polygon;$L$;2|
              (34 . |new|) (38 . |Zero|) |SPACE3;create3Space;$;3|
              |SPACE3;create3Space;Ss$;4| |SPACE3;numberOfComponents;$Nni;5|
              |SPACE3;numberOfComposites;$Nni;6| (42 . |merge|) (|List| 9)
              (47 . |append|) |SPACE3;merge;L$;7| |SPACE3;merge;3$;8|
              (53 . |deepCopy|) |SPACE3;composite;L$;9| (58 . |separate|)
              |SPACE3;components;$L;10| |SPACE3;composites;$L;11|
              |SPACE3;copy;2$;12| (63 . |addPoint|)
              |SPACE3;enterPointData;$LNni;13| (69 . |modifyPoint|)
              |SPACE3;modifyPointData;$NniP$;14| (|Boolean|)
              |SPACE3;point?;$B;15| (|List| 13) (76 . |traverse|)
              (82 . |extractPoint|) |SPACE3;point;$P;16| |SPACE3;point;$P$;18|
              |SPACE3;point;P$;17| (87 . |addPoint|) (|List| 6) (94 . |point|)
              |SPACE3;point;$L$;19| (99 . |addPoint|) |SPACE3;point;$Nni$;20|
              |SPACE3;curve?;$B;21| |SPACE3;curve;$L;22| |SPACE3;curve;$L$;24|
              |SPACE3;curve;L$;23| (|Mapping| 17 51) (|List| 51)
              (|ListFunctions2| 51 17) (106 . |map|) |SPACE3;curve;$L$;25|
              (112 . |extractClosed|) |SPACE3;closedCurve?;$B;26|
              |SPACE3;closedCurve;$L;27| |SPACE3;closedCurve;$L$;29|
              |SPACE3;closedCurve;L$;28| (117 . |closeComponent|)
              |SPACE3;closedCurve;$L$;30| (124 . |second|)
              |SPACE3;polygon?;$B;31| |SPACE3;polygon;$L;32|
              |SPACE3;polygon;L$;33| |SPACE3;polygon;$L$;34| (|Set| 13)
              (129 . |empty|) (133 . |insert!|) (139 . |#|) (144 . |parts|)
              |SPACE3;mesh?;$B;35| (|List| 15) |SPACE3;mesh;$L;36|
              |SPACE3;mesh;$L2B$;42| |SPACE3;mesh;L$;37| |SPACE3;mesh;L2B$;38|
              (|List| 11) |SPACE3;mesh;$LLSscp$;40| (|List| 61)
              |SPACE3;mesh;$LLSscp$;39| (149 . |defineProperty|)
              (156 . |append|) |SPACE3;mesh;$L2B$;41| (162 . |new|)
              (166 . |close|) |SPACE3;lp;$L;43| (|List| (|List| 44))
              |SPACE3;lllip;$L;44| (|List| 88) |SPACE3;llprop;$L;45|
              |SPACE3;lprop;$L;46| (172 . |One|) (176 . ~=)
              (|Record| (|:| |points| 13) (|:| |curves| 13) (|:| |polygons| 13)
                        (|:| |constructs| 13))
              |SPACE3;objects;$R;47| |SPACE3;check;2$;48|
              |SPACE3;subspace;$Ss;49| (|String|) (|OutputForm|)
              (182 . |message|) (187 . |coerce|) (192 . |hconcat|)
              |SPACE3;coerce;$Of;50| (|List| 83) (|HashState|)
              (|SingleInteger|))
           '#(~= 197 |subspace| 203 |polygon?| 208 |polygon| 213 |point?| 235
              |point| 240 |objects| 268 |numberOfComposites| 273
              |numberOfComponents| 278 |modifyPointData| 283 |mesh?| 290 |mesh|
              295 |merge| 344 |lprop| 355 |lp| 360 |llprop| 365 |lllp| 370
              |lllip| 375 |latex| 380 |hashUpdate!| 385 |hash| 391
              |enterPointData| 396 |curve?| 402 |curve| 407 |create3Space| 429
              |copy| 438 |composites| 443 |composite| 448 |components| 453
              |coerce| 458 |closedCurve?| 463 |closedCurve| 468 |check| 490 =
              495)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|ThreeSpaceCategory| 6) (|SetCategory|)
                           (|BasicType|) (|CoercibleTo| 110))
                        (|makeByteWordVec2| 117
                                            '(1 9 8 0 10 1 9 11 0 12 1 9 13 0
                                              14 1 9 15 0 16 2 9 0 0 17 18 4 9
                                              0 0 0 17 13 19 0 9 0 21 0 6 0 22
                                              1 9 0 8 27 2 28 0 0 0 29 1 9 0 0
                                              32 1 9 8 0 34 2 9 13 0 17 38 3 9
                                              0 0 13 17 40 2 9 0 0 44 45 1 9 17
                                              0 46 3 9 0 0 44 17 50 1 17 0 51
                                              52 3 9 0 0 44 13 54 2 62 15 60 61
                                              63 1 9 42 0 65 3 9 0 0 44 42 70 1
                                              28 9 0 72 0 77 0 78 2 77 0 13 0
                                              79 1 77 13 0 80 1 77 44 0 81 3 9
                                              0 0 44 11 92 2 44 0 0 0 93 0 11 0
                                              95 2 11 42 0 42 96 0 6 0 103 2 13
                                              42 0 0 104 1 110 0 109 111 1 13
                                              110 0 112 1 110 0 8 113 2 0 42 0
                                              0 1 1 0 9 0 108 1 0 42 0 73 1 0
                                              15 0 74 2 0 0 0 61 76 1 0 0 15 75
                                              2 0 0 0 15 20 1 0 42 0 43 1 0 0
                                              17 49 1 0 17 0 47 2 0 0 0 13 55 2
                                              0 0 0 17 48 2 0 0 0 51 53 1 0 105
                                              0 106 1 0 13 0 26 1 0 13 0 25 3 0
                                              0 0 13 17 41 1 0 42 0 82 3 0 0 83
                                              42 42 87 1 0 83 0 84 4 0 0 0 90
                                              42 42 94 1 0 0 83 86 4 0 0 0 83
                                              42 42 85 4 0 0 0 83 88 11 89 4 0
                                              0 0 90 88 11 91 2 0 0 0 0 31 1 0
                                              0 8 30 1 0 88 0 102 1 0 15 0 97 1
                                              0 100 0 101 1 0 115 0 1 1 0 98 0
                                              99 1 0 109 0 1 2 0 116 116 0 1 1
                                              0 117 0 1 2 0 13 0 15 39 1 0 42 0
                                              56 1 0 15 0 57 2 0 0 0 61 64 1 0
                                              0 15 59 2 0 0 0 15 58 1 0 0 9 24
                                              0 0 0 23 1 0 0 0 37 1 0 8 0 36 1
                                              0 0 8 33 1 0 8 0 35 1 0 110 0 114
                                              1 0 42 0 66 1 0 15 0 67 2 0 0 0
                                              61 71 1 0 0 15 69 2 0 0 0 15 68 1
                                              0 0 0 107 2 0 42 0 0 1)))))
           '|lookupComplete|)) 

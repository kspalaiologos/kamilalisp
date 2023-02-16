
(SDEFUN |GROUPP;groupPresentation;LL$;1|
        ((|gens1| (|List| (|NonNegativeInteger|)))
         (|rels1| (|List| (|List| (|Integer|)))) ($ ($)))
        (SPROG
         ((#1=#:G757 NIL) (|r| NIL) (#2=#:G756 NIL)
          (|g| (|PrimitiveArray| (|NonNegativeInteger|))))
         (SEQ (LETT |g| (SPADCALL |gens1| (QREFELT $ 9)))
              (EXIT
               (CONS |g|
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |r| NIL) (LETT #1# |rels1|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL (NULL |r|)) (LETT #2# (CONS |r| #2#))))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |GROUPP;groupPresentation;L$;2|
        ((|gens1| (|List| (|NonNegativeInteger|))) ($ ($)))
        (SPROG
         ((|rels2| (|List| (|List| (|Integer|))))
          (|g| (|PrimitiveArray| (|NonNegativeInteger|))))
         (SEQ (LETT |g| (SPADCALL |gens1| (QREFELT $ 9))) (LETT |rels2| NIL)
              (EXIT (CONS |g| |rels2|))))) 

(SDEFUN |GROUPP;groupPresentation;$;3| (($ ($)))
        (SPROG
         ((|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |gens1| NIL) (LETT |rels1| NIL)
              (EXIT (SPADCALL |gens1| |rels1| (QREFELT $ 11)))))) 

(SDEFUN |GROUPP;mapGen|
        ((|a| (|Integer|))
         (|ms|
          (|List|
           (|Record| (|:| |OldGen| (|NonNegativeInteger|))
                     (|:| |NewGen| (|NonNegativeInteger|)))))
         ($ (|Integer|)))
        (SPROG ((#1=#:G772 NIL) (#2=#:G773 NIL) (|m| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |m| NIL) (LETT #2# |ms|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |m| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (COND
                         ((EQL (ABS |a|) (QCAR |m|))
                          (PROGN (LETT #1# (QCDR |m|)) (GO #3=#:G771))))
                        (EXIT
                         (COND
                          ((EQL (ABS |a|) (- (QCAR |m|)))
                           (PROGN (LETT #1# (- (QCDR |m|))) (GO #3#))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (|error|
                   (SPADCALL
                    (LIST "cant map " (STRINGIMAGE |a|) " in refactor")
                    (QREFELT $ 16)))
                  (EXIT |a|)))
                #3# (EXIT #1#)))) 

(SDEFUN |GROUPP;refactor;2$;5| ((|a| ($)) ($ ($)))
        (SPROG
         ((|gens1| (|List| (|NonNegativeInteger|))) (#1=#:G802 NIL) (|gn| NIL)
          (#2=#:G801 NIL) (|rels1| (|List| (|List| (|Integer|))))
          (|newRel| (|List| (|Integer|))) (|newEle| (|Integer|))
          (#3=#:G800 NIL) (|ele| NIL) (#4=#:G799 NIL) (|rel| NIL)
          (|gms|
           (|List|
            (|Record| (|:| |OldGen| (|NonNegativeInteger|))
                      (|:| |NewGen| (|NonNegativeInteger|)))))
          (|gm|
           (|Record| (|:| |OldGen| (|NonNegativeInteger|))
                     (|:| |NewGen| (|NonNegativeInteger|))))
          (#5=#:G797 NIL) (|g| NIL) (#6=#:G798 NIL))
         (SEQ (LETT |gms| NIL)
              (SEQ (LETT |gn| 1)
                   (LETT #6# (SPADCALL (QCAR |a|) (QREFELT $ 19)))
                   (LETT |g| NIL)
                   (LETT #5# (SPADCALL (QCAR |a|) (QREFELT $ 17))) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |g| (CAR #5#)) NIL)
                         (|greater_SI| |gn| #6#))
                     (GO G191)))
                   (SEQ (LETT |gm| (CONS |g| |gn|))
                        (EXIT
                         (LETT |gms| (SPADCALL |gms| |gm| (QREFELT $ 22)))))
                   (LETT #5# (PROG1 (CDR #5#) (LETT |gn| (|inc_SI| |gn|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |rels1| NIL)
              (SEQ (LETT |rel| NIL) (LETT #4# (QCDR |a|)) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |rel| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |newRel| NIL)
                        (SEQ (LETT |ele| NIL) (LETT #3# |rel|) G190
                             (COND
                              ((OR (ATOM #3#)
                                   (PROGN (LETT |ele| (CAR #3#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |newEle| (|GROUPP;mapGen| |ele| |gms| $))
                              (EXIT
                               (LETT |newRel|
                                     (SPADCALL |newRel| |newEle|
                                               (QREFELT $ 25)))))
                             (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (LETT |rels1|
                               (SPADCALL |rels1| |newRel| (QREFELT $ 26)))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (LETT |gens1|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |gn| 1)
                          (LETT #1# (SPADCALL (QCAR |a|) (QREFELT $ 19))) G190
                          (COND ((|greater_SI| |gn| #1#) (GO G191)))
                          (SEQ (EXIT (LETT #2# (CONS |gn| #2#))))
                          (LETT |gn| (|inc_SI| |gn|)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (SPADCALL |gens1| |rels1| (QREFELT $ 11)))))) 

(SDEFUN |GROUPP;=;2$B;6| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG
         ((|brs| #1=(|List| (|List| (|Integer|)))) (|ars| #1#) (#2=#:G807 NIL)
          (|bgs| #3=(|List| (|NonNegativeInteger|))) (|ags| #3#) (|br| ($))
          (|ar| ($)))
         (SEQ
          (EXIT
           (SEQ (LETT |ar| (SPADCALL |a| (QREFELT $ 27)))
                (LETT |br| (SPADCALL |b| (QREFELT $ 27)))
                (LETT |ags| (SPADCALL (QCAR |ar|) (QREFELT $ 17)))
                (LETT |bgs| (SPADCALL (QCAR |br|) (QREFELT $ 17)))
                (COND
                 ((SPADCALL (SPADCALL |ags| (QREFELT $ 29))
                            (SPADCALL |bgs| (QREFELT $ 29)) (QREFELT $ 31))
                  (PROGN (LETT #2# NIL) (GO #4=#:G806))))
                (LETT |ars| (SPADCALL (QCDR |ar|) (QREFELT $ 32)))
                (LETT |brs| (SPADCALL (QCDR |br|) (QREFELT $ 32)))
                (EXIT
                 (SPADCALL (SPADCALL |ars| (QREFELT $ 34))
                           (SPADCALL |brs| (QREFELT $ 34)) (QREFELT $ 35)))))
          #4# (EXIT #2#)))) 

(SDEFUN |GROUPP;outputGen| ((|i2| (|Integer|)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G811 NIL) (|n| (|OutputForm|)) (|letters| (|String|))
          (|i| #2=(|Integer|)) (|suffix| #3=(|Integer|))
          (|#G18| (|Record| (|:| |quotient| #3#) (|:| |remainder| #2#))))
         (SEQ
          (EXIT
           (SEQ
            (PROGN
             (LETT |#G18| (DIVIDE2 (ABS |i2|) 25))
             (LETT |suffix| (QCAR |#G18|))
             (LETT |i| (QCDR |#G18|))
             |#G18|)
            (LETT |letters| "eabcdfghijklmnopqrstuvwxyz")
            (LETT |n|
                  (SPADCALL (SPADCALL |letters| (+ |i| 1) (QREFELT $ 38))
                            (QREFELT $ 40)))
            (COND
             ((> |suffix| 0)
              (LETT |n|
                    (SPADCALL |n| (SPADCALL (+ |suffix| 1) (QREFELT $ 41))
                              (QREFELT $ 42)))))
            (COND
             ((< |i2| 0)
              (PROGN
               (LETT #1#
                     (SPADCALL (SPADCALL "-" (QREFELT $ 43)) |n|
                               (QREFELT $ 42)))
               (GO #4=#:G810))))
            (EXIT |n|)))
          #4# (EXIT #1#)))) 

(SDEFUN |GROUPP;outputRel| ((|r| (|List| (|Integer|))) ($ (|OutputForm|)))
        (SPROG
         ((|seperator| #1=(|OutputForm|)) (|eleout| #1#)
          (|newterm| (|OutputForm|)) (#2=#:G817 NIL) (|ele| NIL))
         (SEQ (LETT |eleout| (SPADCALL "" (QREFELT $ 43)))
              (LETT |seperator| (SPADCALL " " (QREFELT $ 43)))
              (SEQ (LETT |ele| NIL) (LETT #2# |r|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |ele| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |newterm| (|GROUPP;outputGen| |ele| $))
                        (LETT |eleout|
                              (SPADCALL (LIST |eleout| |seperator| |newterm|)
                                        (QREFELT $ 44)))
                        (EXIT
                         (LETT |seperator| (SPADCALL "*" (QREFELT $ 43)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |eleout|)))) 

(SDEFUN |GROUPP;outputRelList|
        ((|i2| (|List| (|List| (|Integer|)))) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G823 NIL) (|rels1| (|List| (|OutputForm|))) (#2=#:G824 NIL)
          (|r| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |rels1| NIL)
                (SEQ (LETT |r| NIL) (LETT #2# |i2|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |r| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |rels1|
                             (SPADCALL |rels1| (|GROUPP;outputRel| |r| $)
                                       (QREFELT $ 46)))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((> (LENGTH |rels1|) 0)
                  (PROGN
                   (LETT #1# (SPADCALL |rels1| (QREFELT $ 47)))
                   (GO #3=#:G822))))
                (EXIT (SPADCALL " " (QREFELT $ 43)))))
          #3# (EXIT #1#)))) 

(SDEFUN |GROUPP;outputGenList|
        ((|ps| (|List| (|NonNegativeInteger|))) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G830 NIL) (|gens1| (|List| (|OutputForm|))) (#2=#:G831 NIL)
          (|p| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |gens1| NIL)
                (SEQ (LETT |p| NIL) (LETT #2# |ps|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |gens1|
                             (SPADCALL |gens1| (|GROUPP;outputGen| |p| $)
                                       (QREFELT $ 46)))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((> (LENGTH |gens1|) 0)
                  (PROGN
                   (LETT #1# (SPADCALL |gens1| (QREFELT $ 48)))
                   (GO #3=#:G829))))
                (EXIT (SPADCALL " " (QREFELT $ 43)))))
          #3# (EXIT #1#)))) 

(SDEFUN |GROUPP;indexesOfRelUsingGen|
        ((|s| ($)) (|gen| (|NonNegativeInteger|))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|res| (|List| (|NonNegativeInteger|))) (#1=#:G839 NIL) (|rel| NIL)
          (#2=#:G840 NIL) (|reln| NIL) (|r| (|List| (|List| (|Integer|)))))
         (SEQ (LETT |res| NIL) (LETT |r| (QCDR |s|))
              (SEQ (LETT |reln| 1) (LETT #2# (LENGTH |r|)) (LETT |rel| NIL)
                   (LETT #1# |r|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |rel| (CAR #1#)) NIL)
                         (|greater_SI| |reln| #2#))
                     (GO G191)))
                   (SEQ
                    (COND
                     ((SPADCALL |gen| |rel| (QREFELT $ 49))
                      (LETT |res| (SPADCALL |res| |reln| (QREFELT $ 50)))))
                    (EXIT
                     (COND
                      ((> |gen| 0)
                       (COND
                        ((SPADCALL (- |gen|) |rel| (QREFELT $ 49))
                         (LETT |res|
                               (SPADCALL |res| |reln| (QREFELT $ 50)))))))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |reln| (|inc_SI| |reln|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |GROUPP;removeGen|
        ((|gens1| (|PrimitiveArray| (|NonNegativeInteger|)))
         (|val| (|NonNegativeInteger|))
         ($ (|PrimitiveArray| (|NonNegativeInteger|))))
        (SPADCALL |val| |gens1| (QREFELT $ 51))) 

(SDEFUN |GROUPP;removeGen2|
        ((|rels1| (|List| (|List| (|Integer|)))) (|val| (|NonNegativeInteger|))
         ($ (|List| (|List| (|Integer|)))))
        (SPROG ((#1=#:G846 NIL) (|rel| NIL) (#2=#:G845 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |rel| NIL) (LETT #1# |rels1|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |rel| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (- |val|)
                                         (SPADCALL |val| |rel| (QREFELT $ 52))
                                         (QREFELT $ 52))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |GROUPP;replaceGen|
        ((|rels1| (|List| (|List| (|Integer|))))
         (|val1| (|NonNegativeInteger|)) (|val2| (|Integer|))
         ($ (|List| (|List| (|Integer|)))))
        (SPROG
         ((|rels2| (|List| (|List| (|Integer|)))) (|rel2| (|List| (|Integer|)))
          (|e| (|Integer|)) (#1=#:G857 NIL) (|ele| NIL) (#2=#:G856 NIL)
          (|rel| NIL))
         (SEQ (LETT |rels2| NIL)
              (SEQ (LETT |rel| NIL) (LETT #2# |rels1|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |rel| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |rel2| NIL)
                        (SEQ (LETT |ele| NIL) (LETT #1# |rel|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |ele| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ (LETT |e| (ABS |ele|))
                                  (COND ((EQL |e| |val1|) (LETT |e| |val2|)))
                                  (COND ((< |ele| 0) (LETT |e| (- |e|))))
                                  (EXIT
                                   (LETT |rel2|
                                         (SPADCALL |rel2| |e|
                                                   (QREFELT $ 25)))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (LETT |rels2|
                               (SPADCALL |rels2| |rel2| (QREFELT $ 26)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |rels2|)))) 

(SDEFUN |GROUPP;TTRemoveGeneratorIfIdentity|
        ((|s| ($)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|PrimitiveArray| (|NonNegativeInteger|))) (#1=#:G864 NIL)
          (|toBeRemoved| (|NonNegativeInteger|)) (#2=#:G865 NIL) (|rel| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |gens1| (QCAR |s|)) (LETT |rels1| (QCDR |s|))
                (LETT |toBeRemoved| 0)
                (SEQ (LETT |rel| NIL) (LETT #2# |rels1|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |rel| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((EQL (LENGTH |rel|) 1)
                         (COND
                          ((EQL |toBeRemoved| 0)
                           (LETT |toBeRemoved| (ABS (|SPADfirst| |rel|)))))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((EQL |toBeRemoved| 0) (PROGN (LETT #1# |s|) (GO #3=#:G863))))
                (COND
                 (|trace|
                  (SPADCALL
                   (SPADCALL
                    (LIST (SPADCALL "simplify: generator '" (QREFELT $ 43))
                          (|GROUPP;outputGen| |toBeRemoved| $)
                          (SPADCALL "' is identity so remove it"
                                    (QREFELT $ 43)))
                    (QREFELT $ 44))
                   (QREFELT $ 54))))
                (LETT |gens1| (|GROUPP;removeGen| |gens1| |toBeRemoved| $))
                (LETT |rels1| (|GROUPP;removeGen2| |rels1| |toBeRemoved| $))
                (COND
                 (|trace|
                  (SPADCALL (|GROUPP;outputRelList| |rels1| $)
                            (QREFELT $ 54))))
                (EXIT (CONS |gens1| |rels1|))))
          #3# (EXIT #1#)))) 

(SDEFUN |GROUPP;TTRenameGenerator| ((|s| ($)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|PrimitiveArray| (|NonNegativeInteger|))) (#1=#:G876 NIL)
          (|replaceFrom| (|NonNegativeInteger|)) (|replaceTo| (|Integer|))
          (#2=#:G877 NIL) (|rel| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |gens1| (QCAR |s|)) (LETT |rels1| (QCDR |s|))
                (LETT |replaceFrom| 0) (LETT |replaceTo| 0)
                (SEQ (LETT |rel| NIL) (LETT #2# |rels1|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |rel| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((EQL (LENGTH |rel|) 2)
                         (COND
                          ((EQL |replaceFrom| 0)
                           (SEQ
                            (LETT |replaceTo| (SPADCALL |rel| (QREFELT $ 55)))
                            (LETT |replaceFrom| (ABS (|SPADfirst| |rel|)))
                            (COND
                             ((> (|SPADfirst| |rel|) 0)
                              (LETT |replaceTo| (- |replaceTo|))))
                            (EXIT
                             (COND
                              ((EQL |replaceFrom| (ABS |replaceTo|))
                               (LETT |replaceFrom| 0)))))))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((EQL |replaceFrom| 0) (PROGN (LETT #1# |s|) (GO #3=#:G875))))
                (COND
                 (|trace|
                  (SPADCALL
                   (SPADCALL
                    (LIST (SPADCALL "simplify: generator '" (QREFELT $ 43))
                          (|GROUPP;outputGen| |replaceFrom| $)
                          (SPADCALL "' is replaced by '" (QREFELT $ 43))
                          (|GROUPP;outputGen| |replaceTo| $)
                          (SPADCALL "'" (QREFELT $ 43)))
                    (QREFELT $ 44))
                   (QREFELT $ 54))))
                (LETT |gens1| (|GROUPP;removeGen| |gens1| |replaceFrom| $))
                (LETT |rels1|
                      (|GROUPP;replaceGen| |rels1| |replaceFrom| |replaceTo|
                       $))
                (COND
                 (|trace|
                  (SPADCALL (|GROUPP;outputRelList| |rels1| $)
                            (QREFELT $ 54))))
                (EXIT (CONS |gens1| |rels1|))))
          #3# (EXIT #1#)))) 

(SDEFUN |GROUPP;TTRemoveEmpty| ((|s| ($)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|rels2| (|List| (|List| (|Integer|)))) (#1=#:G883 NIL) (|rel| NIL)
          (|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|PrimitiveArray| (|NonNegativeInteger|))))
         (SEQ (LETT |gens1| (QCAR |s|)) (LETT |rels1| (QCDR |s|))
              (LETT |rels2| NIL)
              (SEQ (LETT |rel| NIL) (LETT #1# |rels1|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |rel| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL (NULL |rel|))
                       (LETT |rels2|
                             (SPADCALL |rels2| |rel| (QREFELT $ 26)))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |gens1| |rels2|))))) 

(SDEFUN |GROUPP;TTRemoveZero| ((|s| ($)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|PrimitiveArray| (|NonNegativeInteger|))))
         (SEQ (LETT |gens1| (QCAR |s|)) (LETT |rels1| (QCDR |s|))
              (LETT |gens1| (|GROUPP;removeGen| |gens1| 0 $))
              (LETT |rels1| (|GROUPP;removeGen2| |rels1| 0 $))
              (EXIT (CONS |gens1| |rels1|))))) 

(SDEFUN |GROUPP;TTRemoveEleTimesInverse|
        ((|s| ($)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|rels2| (|List| (|List| (|Integer|)))) (|rel2| (|List| (|Integer|)))
          (|lastele| (|Integer|)) (|changed| (|Boolean|)) (#1=#:G903 NIL)
          (|ele| NIL) (#2=#:G902 NIL) (|rel| NIL)
          (|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|PrimitiveArray| (|NonNegativeInteger|))))
         (SEQ (LETT |gens1| (QCAR |s|)) (LETT |rels1| (QCDR |s|))
              (LETT |rels2| NIL) (LETT |changed| NIL)
              (SEQ (LETT |rel| NIL) (LETT #2# |rels1|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |rel| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |rel2| NIL) (LETT |lastele| 0)
                        (SEQ (LETT |ele| NIL) (LETT #1# |rel|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |ele| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((EQL (ABS |ele|) (ABS |lastele|))
                                 (COND
                                  ((SPADCALL (SPADCALL |ele| (QREFELT $ 56))
                                             (SPADCALL |lastele|
                                                       (QREFELT $ 56))
                                             (QREFELT $ 57))
                                   (SEQ
                                    (COND
                                     (|trace|
                                      (SPADCALL
                                       (SPADCALL
                                        (LIST
                                         (SPADCALL "simplify: generator '"
                                                   (QREFELT $ 43))
                                         (|GROUPP;outputGen| |ele| $)
                                         (SPADCALL
                                          "' is adjacent to its inverse"
                                          (QREFELT $ 43)))
                                        (QREFELT $ 44))
                                       (QREFELT $ 54))))
                                    (LETT |changed| 'T)
                                    (EXIT (LETT |lastele| 0))))
                                  ('T
                                   (SEQ
                                    (COND
                                     ((SPADCALL |lastele| 0 (QREFELT $ 57))
                                      (LETT |rel2|
                                            (SPADCALL |rel2| |lastele|
                                                      (QREFELT $ 25)))))
                                    (EXIT (LETT |lastele| |ele|))))))
                                ('T
                                 (SEQ
                                  (COND
                                   ((SPADCALL |lastele| 0 (QREFELT $ 57))
                                    (LETT |rel2|
                                          (SPADCALL |rel2| |lastele|
                                                    (QREFELT $ 25)))))
                                  (EXIT (LETT |lastele| |ele|)))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (COND
                         ((SPADCALL |lastele| 0 (QREFELT $ 57))
                          (LETT |rel2|
                                (SPADCALL |rel2| |lastele| (QREFELT $ 25)))))
                        (EXIT
                         (COND
                          ((NULL (NULL |rel2|))
                           (LETT |rels2|
                                 (SPADCALL |rels2| |rel2| (QREFELT $ 26)))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (COND
               (|trace|
                (COND
                 (|changed|
                  (SPADCALL (|GROUPP;outputRelList| |rels2| $)
                            (QREFELT $ 54))))))
              (EXIT (CONS |gens1| |rels2|))))) 

(SDEFUN |GROUPP;invertRelation|
        ((|relationIn| (|List| (|Integer|))) ($ (|List| (|Integer|))))
        (SPROG
         ((|relationOut| (|List| (|Integer|))) (#1=#:G908 NIL) (|ele| NIL))
         (SEQ (LETT |relationOut| NIL)
              (SEQ (LETT |ele| NIL) (LETT #1# |relationIn|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |ele| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT (LETT |relationOut| (CONS (- |ele|) |relationOut|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |relationOut|)))) 

(SDEFUN |GROUPP;cycleRelation|
        ((|relationIn| (|List| (|Integer|))) ($ (|List| (|Integer|))))
        (SPROG ((|relationOut| (|List| (|Integer|))))
               (SEQ
                (LETT |relationOut|
                      (SPADCALL (CDR |relationIn|) (|SPADfirst| |relationIn|)
                                (QREFELT $ 25)))
                (EXIT |relationOut|)))) 

(SDEFUN |GROUPP;relationEquivalent|
        ((|relA| (|List| (|Integer|))) (|relB| (|List| (|Integer|)))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G919 NIL) (|relBCycle| (|List| (|Integer|))) (#2=#:G920 NIL)
          (|n| NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL (LENGTH |relA|) (LENGTH |relB|) (QREFELT $ 58))
              (PROGN (LETT #1# NIL) (GO #3=#:G918))))
            (COND
             ((SPADCALL |relA| |relB| (QREFELT $ 59))
              (PROGN (LETT #1# 'T) (GO #3#))))
            (COND
             ((SPADCALL |relA| (|GROUPP;invertRelation| |relB| $)
                        (QREFELT $ 59))
              (PROGN (LETT #1# 'T) (GO #3#))))
            (LETT |relBCycle| (SPADCALL |relB| (QREFELT $ 60)))
            (SEQ (LETT |n| 1) (LETT #2# (LENGTH |relA|)) G190
                 (COND ((|greater_SI| |n| #2#) (GO G191)))
                 (SEQ (LETT |relBCycle| (|GROUPP;cycleRelation| |relBCycle| $))
                      (COND
                       ((SPADCALL |relA| |relBCycle| (QREFELT $ 59))
                        (PROGN (LETT #1# 'T) (GO #3#))))
                      (EXIT
                       (COND
                        ((SPADCALL |relA|
                                   (|GROUPP;invertRelation| |relBCycle| $)
                                   (QREFELT $ 59))
                         (PROGN (LETT #1# 'T) (GO #3#))))))
                 (LETT |n| (|inc_SI| |n|)) (GO G190) G191 (EXIT NIL))
            (EXIT NIL)))
          #3# (EXIT #1#)))) 

(SDEFUN |GROUPP;TTRemoveDuplicateRelation|
        ((|s| ($)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|rels2| (|List| (|List| (|Integer|)))) (|include| (|Boolean|))
          (#1=#:G933 NIL) (|relb| NIL) (#2=#:G934 NIL) (|nrelb| NIL)
          (#3=#:G931 NIL) (|rela| NIL) (#4=#:G932 NIL) (|nrela| NIL)
          (|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|PrimitiveArray| (|NonNegativeInteger|))))
         (SEQ (LETT |gens1| (QCAR |s|)) (LETT |rels1| (QCDR |s|))
              (LETT |rels2| NIL)
              (SEQ (LETT |nrela| 1) (LETT #4# (LENGTH |rels1|))
                   (LETT |rela| NIL) (LETT #3# |rels1|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |rela| (CAR #3#)) NIL)
                         (|greater_SI| |nrela| #4#))
                     (GO G191)))
                   (SEQ (LETT |include| 'T)
                        (SEQ (LETT |nrelb| 1) (LETT #2# (LENGTH |rels1|))
                             (LETT |relb| NIL) (LETT #1# |rels1|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |relb| (CAR #1#)) NIL)
                                   (|greater_SI| |nrelb| #2#))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((> |nrela| |nrelb|)
                                 (COND
                                  ((|GROUPP;relationEquivalent| |rela| |relb|
                                    $)
                                   (SEQ (LETT |include| NIL)
                                        (EXIT
                                         (COND
                                          (|trace|
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL
                                                "TTRemoveDuplicateRelation duplicate found "
                                                (QREFELT $ 43))
                                               (SPADCALL |rela| (QREFELT $ 61))
                                               (QREFELT $ 42))
                                              (SPADCALL "=" (QREFELT $ 43))
                                              (QREFELT $ 42))
                                             (SPADCALL |relb| (QREFELT $ 61))
                                             (QREFELT $ 42))
                                            (QREFELT $ 54))))))))))))
                             (LETT #1#
                                   (PROG1 (CDR #1#)
                                     (LETT |nrelb| (|inc_SI| |nrelb|))))
                             (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          (|include|
                           (LETT |rels2|
                                 (SPADCALL |rels2| |rela| (QREFELT $ 26)))))))
                   (LETT #3#
                         (PROG1 (CDR #3#) (LETT |nrela| (|inc_SI| |nrela|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |gens1| |rels2|))))) 

(SDEFUN |GROUPP;TTMinimiseInverses| ((|s| ($)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|rels2| (|List| (|List| (|Integer|))))
          (|numNonInverts| #1=(|NonNegativeInteger|)) (|numInverts| #1#)
          (#2=#:G943 NIL) (|ele| NIL) (#3=#:G942 NIL) (|rel| NIL)
          (|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|PrimitiveArray| (|NonNegativeInteger|))))
         (SEQ (LETT |gens1| (QCAR |s|)) (LETT |rels1| (QCDR |s|))
              (LETT |rels2| NIL)
              (SEQ (LETT |rel| NIL) (LETT #3# |rels1|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |rel| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |numInverts| 0) (LETT |numNonInverts| 0)
                        (SEQ (LETT |ele| NIL) (LETT #2# |rel|) G190
                             (COND
                              ((OR (ATOM #2#)
                                   (PROGN (LETT |ele| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((< |ele| 0)
                                 (LETT |numInverts| (+ |numInverts| 1)))
                                ('T
                                 (LETT |numNonInverts|
                                       (+ |numNonInverts| 1))))))
                             (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((> |numInverts| |numNonInverts|)
                           (LETT |rels2|
                                 (SPADCALL |rels2|
                                           (|GROUPP;invertRelation| |rel| $)
                                           (QREFELT $ 26))))
                          ('T
                           (LETT |rels2|
                                 (SPADCALL |rels2| |rel| (QREFELT $ 26)))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |gens1| |rels2|))))) 

(SDEFUN |GROUPP;generatorOccurrences|
        ((|rel| (|List| (|Integer|))) (|gen| (|NonNegativeInteger|))
         ($ (|NonNegativeInteger|)))
        (SPROG ((|res| (|NonNegativeInteger|)) (#1=#:G951 NIL) (|g| NIL))
               (SEQ (LETT |res| 0)
                    (SEQ (LETT |g| NIL) (LETT #1# |rel|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |g| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ (COND ((EQL |g| |gen|) (LETT |res| (+ |res| 1))))
                              (EXIT
                               (COND
                                ((> |gen| 0)
                                 (COND
                                  ((EQL |g| (- |gen|))
                                   (LETT |res| (+ |res| 1))))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(SDEFUN |GROUPP;removeRelations|
        ((|rels1| (|List| (|List| (|Integer|)))) (|val| (|NonNegativeInteger|))
         ($ (|List| (|List| (|Integer|)))))
        (SPROG
         ((|res| (|List| (|List| (|Integer|)))) (#1=#:G958 NIL) (|rel| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |rel| NIL) (LETT #1# |rels1|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |rel| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL (SPADCALL |val| |rel| (QREFELT $ 49)))
                       (COND
                        ((NULL (SPADCALL (- |val|) |rel| (QREFELT $ 49)))
                         (LETT |res|
                               (SPADCALL |res| |rel| (QREFELT $ 26)))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |GROUPP;TTSubstitute| ((|s| ($)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|rels1| #1=(|List| (|List| (|Integer|))))
          (|gens1| (|PrimitiveArray| (|NonNegativeInteger|)))
          (|newRel| (|List| (|Integer|))) (#2=#:G987 NIL)
          (|replacement| (|List| (|Integer|))) (|postr| (|List| (|Integer|)))
          (|restr| (|List| #3=(|Integer|))) (|x| (|Integer|))
          (|prer| (|List| (|Integer|))) (|genInverted| #4=(|Boolean|))
          (|found| #4#) (#5=#:G985 NIL)
          (|genToBeRemoved| #6=(|NonNegativeInteger|)) (|n2| #6#)
          (|r2| (|List| (|Integer|))) (|n1| #6#) (|r1| (|List| #3#))
          (|n3| (|NonNegativeInteger|)) (|r3| (|List| (|Integer|)))
          (|indexes| (|List| (|NonNegativeInteger|))) (#7=#:G986 NIL) (|g| NIL)
          (|rs| #1#) (|gs| (|List| (|NonNegativeInteger|))))
         (SEQ
          (EXIT
           (SEQ (LETT |gs| (SPADCALL (QCAR |s|) (QREFELT $ 17)))
                (LETT |rs| (QCDR |s|)) (LETT |r1| NIL) (LETT |r2| NIL)
                (LETT |n1| 0) (LETT |n2| 0) (LETT |genToBeRemoved| 0)
                (SEQ (LETT |g| NIL) (LETT #7# |gs|) G190
                     (COND
                      ((OR (ATOM #7#) (PROGN (LETT |g| (CAR #7#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |indexes|
                            (|GROUPP;indexesOfRelUsingGen| |s| |g| $))
                      (EXIT
                       (COND
                        ((EQL (SPADCALL |indexes| (QREFELT $ 62)) 2)
                         (COND
                          ((EQL |genToBeRemoved| 0)
                           (SEQ (LETT |genToBeRemoved| |g|)
                                (LETT |r1|
                                      (SPADCALL |rs|
                                                (SPADCALL |indexes| 1
                                                          (QREFELT $ 63))
                                                (QREFELT $ 64)))
                                (LETT |r2|
                                      (SPADCALL |rs|
                                                (SPADCALL |indexes| 2
                                                          (QREFELT $ 63))
                                                (QREFELT $ 64)))
                                (LETT |n1|
                                      (|GROUPP;generatorOccurrences| |r1| |g|
                                       $))
                                (LETT |n2|
                                      (|GROUPP;generatorOccurrences| |r2| |g|
                                       $))
                                (COND
                                 ((SPADCALL |n1| 1 (QREFELT $ 58))
                                  (SEQ (LETT |r3| |r1|) (LETT |n3| |n1|)
                                       (LETT |r1| |r2|) (LETT |n1| |n2|)
                                       (LETT |r2| |r3|)
                                       (EXIT (LETT |n2| |n3|)))))
                                (EXIT
                                 (COND
                                  ((SPADCALL |n1| 1 (QREFELT $ 58))
                                   (LETT |genToBeRemoved| 0)))))))))))
                     (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((SPADCALL |n1| 1 (QREFELT $ 58))
                  (PROGN (LETT #5# |s|) (GO #8=#:G984))))
                (COND
                 (|trace|
                  (SEQ
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL "simplify: TTSubstitute (" (QREFELT $ 43))
                      (SPADCALL |s| (QREFELT $ 65)) (QREFELT $ 42))
                     (SPADCALL ")" (QREFELT $ 43)) (QREFELT $ 42))
                    (QREFELT $ 54))
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (SPADCALL "genToBeRemoved=" (QREFELT $ 43))
                                  (|GROUPP;outputGen| |genToBeRemoved| $)
                                  (QREFELT $ 42))
                        (SPADCALL " r1=" (QREFELT $ 43)) (QREFELT $ 42))
                       (|GROUPP;outputRel| |r1| $) (QREFELT $ 42))
                      (SPADCALL " r2=" (QREFELT $ 43)) (QREFELT $ 42))
                     (|GROUPP;outputRel| |r2| $) (QREFELT $ 42))
                    (QREFELT $ 54))
                   (EXIT
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (SPADCALL "n1=" (QREFELT $ 43))
                                 (SPADCALL |n1| (QREFELT $ 66)) (QREFELT $ 42))
                       (SPADCALL " n2=" (QREFELT $ 43)) (QREFELT $ 42))
                      (SPADCALL |n2| (QREFELT $ 66)) (QREFELT $ 42))
                     (QREFELT $ 54))))))
                (LETT |restr| |r1|) (LETT |prer| NIL) (LETT |found| NIL)
                (LETT |genInverted| NIL)
                (SEQ G190
                     (COND
                      ((NULL (NULL (OR (NULL |restr|) |found|))) (GO G191)))
                     (SEQ (LETT |x| (|SPADfirst| |restr|))
                          (LETT |restr| (CDR |restr|))
                          (EXIT
                           (COND
                            ((OR (EQL |x| |genToBeRemoved|)
                                 (EQL |x| (- |genToBeRemoved|)))
                             (SEQ (LETT |found| 'T)
                                  (EXIT
                                   (COND
                                    ((< |x| 0) (LETT |genInverted| 'T))))))
                            ('T
                             (LETT |prer|
                                   (SPADCALL |prer| |x| (QREFELT $ 25)))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (LETT |postr| NIL)
                (SEQ G190 (COND ((NULL (NULL (NULL |restr|))) (GO G191)))
                     (SEQ (LETT |x| (|SPADfirst| |restr|))
                          (LETT |restr| (CDR |restr|))
                          (EXIT
                           (LETT |postr|
                                 (SPADCALL |postr| |x| (QREFELT $ 25)))))
                     NIL (GO G190) G191 (EXIT NIL))
                (LETT |replacement|
                      (SPADCALL (|GROUPP;invertRelation| |prer| $)
                                (|GROUPP;invertRelation| |postr| $)
                                (QREFELT $ 67)))
                (COND
                 (|trace|
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL "we will substitute " (QREFELT $ 43))
                        (|GROUPP;outputRel| |replacement| $) (QREFELT $ 42))
                       (SPADCALL " for " (QREFELT $ 43)) (QREFELT $ 42))
                      (|GROUPP;outputGen| |genToBeRemoved| $) (QREFELT $ 42))
                     (SPADCALL " in " (QREFELT $ 43)) (QREFELT $ 42))
                    (|GROUPP;outputRel| |r2| $) (QREFELT $ 42))
                   (QREFELT $ 54))))
                (LETT |newRel| NIL)
                (SEQ (LETT #2# |r2|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((EQL (ABS |x|) (ABS |genToBeRemoved|))
                         (COND
                          (|genInverted|
                           (LETT |newRel|
                                 (SPADCALL |newRel|
                                           (|GROUPP;invertRelation|
                                            |replacement| $)
                                           (QREFELT $ 67))))
                          ('T
                           (LETT |newRel|
                                 (SPADCALL |newRel| |replacement|
                                           (QREFELT $ 67))))))
                        ('T
                         (LETT |newRel|
                               (SPADCALL |newRel| |x| (QREFELT $ 25)))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (COND
                 (|trace|
                  (SPADCALL
                   (SPADCALL (SPADCALL "newRel=" (QREFELT $ 43))
                             (|GROUPP;outputRel| |newRel| $) (QREFELT $ 42))
                   (QREFELT $ 54))))
                (LETT |gens1| (QCAR |s|)) (LETT |rels1| (QCDR |s|))
                (LETT |gens1| (|GROUPP;removeGen| |gens1| |genToBeRemoved| $))
                (LETT |rels1|
                      (|GROUPP;removeRelations| |rels1| |genToBeRemoved| $))
                (LETT |rels1| (SPADCALL |rels1| |newRel| (QREFELT $ 26)))
                (COND
                 (|trace|
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL (SPADCALL "gens=" (QREFELT $ 43))
                               (|GROUPP;outputGenList|
                                (SPADCALL |gens1| (QREFELT $ 17)) $)
                               (QREFELT $ 42))
                     (SPADCALL " rels=" (QREFELT $ 43)) (QREFELT $ 42))
                    (|GROUPP;outputRelList| |rels1| $) (QREFELT $ 42))
                   (QREFELT $ 54))))
                (EXIT (CONS |gens1| |rels1|))))
          #8# (EXIT #5#)))) 

(SDEFUN |GROUPP;isSimpler?| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G996 NIL) (|relationCompleityB| #2=(|NonNegativeInteger|))
          (#3=#:G998 NIL) (|rel| NIL) (|relationCompleityA| #2#)
          (#4=#:G997 NIL) (|relsb| #5=(|List| (|List| (|Integer|))))
          (|gensb| #6=(|PrimitiveArray| (|NonNegativeInteger|))) (|relsa| #5#)
          (|gensa| #6#))
         (SEQ
          (EXIT
           (SEQ (LETT |gensa| (QCAR |a|)) (LETT |relsa| (QCDR |a|))
                (LETT |gensb| (QCAR |b|)) (LETT |relsb| (QCDR |b|))
                (COND
                 ((< (SPADCALL |gensa| (QREFELT $ 19))
                     (SPADCALL |gensb| (QREFELT $ 19)))
                  (PROGN (LETT #1# 'T) (GO #7=#:G995))))
                (COND
                 ((< (LENGTH |relsa|) (LENGTH |relsb|))
                  (PROGN (LETT #1# 'T) (GO #7#))))
                (LETT |relationCompleityA| 0)
                (SEQ (LETT |rel| NIL) (LETT #4# |relsa|) G190
                     (COND
                      ((OR (ATOM #4#) (PROGN (LETT |rel| (CAR #4#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |relationCompleityA|
                             (+ |relationCompleityA| (LENGTH |rel|)))))
                     (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                (LETT |relationCompleityB| 0)
                (SEQ (LETT |rel| NIL) (LETT #3# |relsb|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |rel| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |relationCompleityB|
                             (+ |relationCompleityB| (LENGTH |rel|)))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((< |relationCompleityA| |relationCompleityB|)
                  (PROGN (LETT #1# 'T) (GO #7#))))
                (EXIT NIL)))
          #7# (EXIT #1#)))) 

(SDEFUN |GROUPP;simplify;2$;29| ((|s| ($)) ($ ($)))
        (SPADCALL |s| NIL (QREFELT $ 68))) 

(SDEFUN |GROUPP;simplify;$B$;30| ((|s| ($)) (|trace| (|Boolean|)) ($ ($)))
        (SPROG
         ((|lastpass| ($)) (|level| #1=(|NonNegativeInteger|)) (#2=#:G1007 NIL)
          (|res| ($)) (|loopBreaker| #1#))
         (SEQ
          (EXIT
           (SEQ
            (COND
             (|trace|
              (SPADCALL
               (SPADCALL
                (SPADCALL (SPADCALL "simplify(" (QREFELT $ 43))
                          (SPADCALL |s| (QREFELT $ 65)) (QREFELT $ 42))
                (SPADCALL ")" (QREFELT $ 43)) (QREFELT $ 42))
               (QREFELT $ 54))))
            (LETT |res| |s|) (LETT |lastpass| |s|) (LETT |level| 0)
            (LETT |loopBreaker| 0)
            (SEQ G190 (COND ((NULL (< |loopBreaker| 10000)) (GO G191)))
                 (SEQ (LETT |loopBreaker| (+ |loopBreaker| 1))
                      (COND
                       ((EQL |level| 0)
                        (LETT |res| (|GROUPP;TTRemoveEmpty| |res| |trace| $))))
                      (COND
                       ((EQL |level| 1)
                        (LETT |res| (|GROUPP;TTRemoveZero| |res| |trace| $))))
                      (COND
                       ((EQL |level| 2)
                        (LETT |res|
                              (|GROUPP;TTRemoveGeneratorIfIdentity| |res|
                               |trace| $))))
                      (COND
                       ((EQL |level| 3)
                        (LETT |res|
                              (|GROUPP;TTRenameGenerator| |res| |trace| $))))
                      (COND
                       ((EQL |level| 4)
                        (LETT |res|
                              (|GROUPP;TTRemoveEleTimesInverse| |res| |trace|
                               $))))
                      (COND
                       ((EQL |level| 5)
                        (LETT |res|
                              (|GROUPP;TTRemoveDuplicateRelation| |res| |trace|
                               $))))
                      (COND
                       ((EQL |level| 6)
                        (LETT |res| (|GROUPP;TTSubstitute| |res| |trace| $))))
                      (COND
                       ((EQL |level| 7)
                        (PROGN
                         (LETT #2#
                               (|GROUPP;TTMinimiseInverses| |res| |trace| $))
                         (GO #3=#:G1006))))
                      (COND
                       ((|GROUPP;isSimpler?| |res| |lastpass| $)
                        (LETT |level| 0))
                       ('T (LETT |level| (+ |level| 1))))
                      (COND
                       (|trace|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (SPADCALL " level=" (QREFELT $ 43))
                                       (SPADCALL |level| (QREFELT $ 66))
                                       (QREFELT $ 42))
                             (SPADCALL " loop=" (QREFELT $ 43)) (QREFELT $ 42))
                            (SPADCALL |loopBreaker| (QREFELT $ 66))
                            (QREFELT $ 42))
                           (SPADCALL " res=" (QREFELT $ 43)) (QREFELT $ 42))
                          (SPADCALL |res| (QREFELT $ 65)) (QREFELT $ 42))
                         (QREFELT $ 54))))
                      (EXIT (LETT |lastpass| |res|)))
                 NIL (GO G190) G191 (EXIT NIL))
            (SPADCALL
             (SPADCALL
              (SPADCALL "simplify excessive time - loop suspected"
                        (QREFELT $ 43))
              (SPADCALL |s| (QREFELT $ 65)) (QREFELT $ 42))
             (QREFELT $ 54))
            (EXIT |res|)))
          #3# (EXIT #2#)))) 

(SDEFUN |GROUPP;offsetIndexes|
        ((|a| ($)) (|offset| (|NonNegativeInteger|)) ($ ($)))
        (SPROG
         ((|rb| (|List| (|List| (|Integer|)))) (#1=#:G1021 NIL) (|y| NIL)
          (#2=#:G1020 NIL) (#3=#:G1019 NIL) (|z| NIL) (#4=#:G1018 NIL)
          (|gb| (|List| (|NonNegativeInteger|))) (#5=#:G1017 NIL) (|x| NIL)
          (#6=#:G1016 NIL) (|ra| (|List| (|List| (|Integer|))))
          (|ga| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |ga| (SPADCALL (QCAR |a|) (QREFELT $ 17)))
              (LETT |ra| (QCDR |a|))
              (LETT |gb|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |x| NIL) (LETT #5# |ga|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |x| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #6# (CONS (+ |x| |offset|) #6#))))
                          (LETT #5# (CDR #5#)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (LETT |rb|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |z| NIL) (LETT #3# |ra|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |z| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (PROGN
                                    (LETT #2# NIL)
                                    (SEQ (LETT |y| NIL) (LETT #1# |z|) G190
                                         (COND
                                          ((OR (ATOM #1#)
                                               (PROGN
                                                (LETT |y| (CAR #1#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #2#
                                                 (CONS
                                                  (COND
                                                   ((> |y| 0) (+ |y| |offset|))
                                                   ('T (- |y| |offset|)))
                                                  #2#))))
                                         (LETT #1# (CDR #1#)) (GO G190) G191
                                         (EXIT (NREVERSE #2#))))
                                   #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (EXIT (SPADCALL |gb| |rb| (QREFELT $ 11)))))) 

(SDEFUN |GROUPP;quotient;$L$;32|
        ((|a| ($)) (|remgen| (|List| (|NonNegativeInteger|))) ($ ($)))
        (SPROG
         ((|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|PrimitiveArray| (|NonNegativeInteger|))) (#1=#:G1027 NIL)
          (|toBeRemoved| NIL))
         (SEQ (LETT |gens1| (QCAR |a|)) (LETT |rels1| (QCDR |a|))
              (SEQ (LETT |toBeRemoved| NIL) (LETT #1# |remgen|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |toBeRemoved| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |gens1| (|GROUPP;removeGen| |gens1| |toBeRemoved| $))
                    (EXIT
                     (LETT |rels1|
                           (|GROUPP;removeGen2| |rels1| |toBeRemoved| $))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |gens1| (QREFELT $ 17)) |rels1|
                          (QREFELT $ 11))
                (QREFELT $ 69)))))) 

(SDEFUN |GROUPP;quotient;$L$;33|
        ((|a| ($)) (|addrel| (|List| (|List| (|Integer|)))) ($ ($)))
        (SPROG
         ((|rels1| (|List| (|List| (|Integer|))))
          (|gens1| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |gens1| (SPADCALL (QCAR |a|) (QREFELT $ 17)))
              (LETT |rels1| (QCDR |a|))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |gens1| (QREFELT $ 71))
                          (SPADCALL |rels1| |addrel| (QREFELT $ 72))
                          (QREFELT $ 11))
                (QREFELT $ 69)))))) 

(SDEFUN |GROUPP;directProduct;3$;34| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPROG
         ((|rc| (|List| (|List| (|Integer|)))) (|gcx| (|List| (|Integer|)))
          (#1=#:G1038 NIL) (|gbx| NIL) (#2=#:G1037 NIL) (|gax| NIL)
          (|rb| #3=(|List| (|List| (|Integer|))))
          (|gb| #4=(|List| (|NonNegativeInteger|))) (|b2| ($))
          (|sa| (|NonNegativeInteger|)) (|ra| #3#) (|ga| #4#) (|a2| ($)))
         (SEQ (LETT |a2| (SPADCALL |a| (QREFELT $ 27)))
              (LETT |ga| (SPADCALL (QCAR |a2|) (QREFELT $ 17)))
              (LETT |ra| (QCDR |a2|))
              (LETT |sa| (SPADCALL |ga| (QREFELT $ 62)))
              (LETT |b2|
                    (|GROUPP;offsetIndexes| (SPADCALL |b| (QREFELT $ 27)) |sa|
                     $))
              (LETT |gb| (SPADCALL (QCAR |b2|) (QREFELT $ 17)))
              (LETT |rb| (QCDR |b2|)) (LETT |rc| NIL)
              (SEQ (LETT |gax| NIL) (LETT #2# |ga|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |gax| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |gbx| NIL) (LETT #1# |gb|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |gbx| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ (LETT |gcx| (LIST |gax| |gbx| |gax| |gbx|))
                               (EXIT
                                (LETT |rc|
                                      (SPADCALL |rc| |gcx| (QREFELT $ 26)))))
                          (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |ga| (QREFELT $ 71)) |gb| (QREFELT $ 74))
                (SPADCALL (LIST |ra| |rb| |rc|) (QREFELT $ 75))
                (QREFELT $ 11)))))) 

(SDEFUN |GROUPP;cyclicGroup;Pi$;35| ((|n| (|PositiveInteger|)) ($ ($)))
        (SPROG
         ((|ra| (|List| (|List| (|Integer|)))) (#1=#:G1044 NIL) (|x| NIL)
          (#2=#:G1043 NIL) (|ga| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |ga| (LIST 1))
              (LETT |ra|
                    (LIST
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |x| 1) (LETT #1# |n|) G190
                           (COND ((|greater_SI| |x| #1#) (GO G191)))
                           (SEQ (EXIT (LETT #2# (CONS 1 #2#))))
                           (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))))
              (EXIT (SPADCALL |ga| |ra| (QREFELT $ 11)))))) 

(SDEFUN |GROUPP;dihedralGroup;Pi$;36| ((|n| (|PositiveInteger|)) ($ ($)))
        (SPROG ((|c2| ($)) (|c1| ($)))
               (SEQ (LETT |c1| (SPADCALL |n| (QREFELT $ 78)))
                    (LETT |c2| (SPADCALL 2 (QREFELT $ 78)))
                    (EXIT (SPADCALL |c1| |c2| (QREFELT $ 76)))))) 

(SDEFUN |GROUPP;symmetricGroup;Pi$;37| ((|n| (|PositiveInteger|)) ($ ($)))
        (SPROG
         ((|r| (|List| (|List| (|Integer|)))) (|y| (|List| (|Integer|)))
          (#1=#:G1066 NIL) (|b| NIL) (#2=#:G1065 NIL) (|a| NIL)
          (|ga| (|List| (|NonNegativeInteger|))) (#3=#:G1064 NIL) (|x| NIL)
          (#4=#:G1063 NIL) (|m| (|PositiveInteger|)) (#5=#:G1047 NIL)
          (#6=#:G1062 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((< |n| 2)
              (PROGN
               (LETT #6# (SPADCALL NIL (QREFELT $ 12)))
               (GO #7=#:G1061))))
            (LETT |m|
                  (PROG1 (LETT #5# (- |n| 1))
                    (|check_subtype2| (> #5# 0) '(|PositiveInteger|)
                                      '(|Integer|) #5#)))
            (LETT |ga|
                  (PROGN
                   (LETT #4# NIL)
                   (SEQ (LETT |x| 1) (LETT #3# |m|) G190
                        (COND ((|greater_SI| |x| #3#) (GO G191)))
                        (SEQ (EXIT (LETT #4# (CONS |x| #4#))))
                        (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                        (EXIT (NREVERSE #4#)))))
            (LETT |r| NIL)
            (SEQ (LETT |a| 1) (LETT #2# |m|) G190
                 (COND ((|greater_SI| |a| #2#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |b| 1) (LETT #1# |m|) G190
                        (COND ((|greater_SI| |b| #1#) (GO G191)))
                        (SEQ
                         (COND
                          ((EQL |a| |b|)
                           (SEQ (LETT |y| (LIST |a| |a|))
                                (EXIT (LETT |r| (CONS |y| |r|))))))
                         (COND
                          ((< (+ |a| 1) |b|)
                           (SEQ (LETT |y| (LIST |a| |b| (- |a|) (- |b|)))
                                (EXIT (LETT |r| (CONS |y| |r|))))))
                         (EXIT
                          (COND
                           ((EQL (+ |a| 1) |b|)
                            (SEQ (LETT |y| (LIST |a| |b| |a| |b| |a| |b|))
                                 (EXIT (LETT |r| (CONS |y| |r|))))))))
                        (LETT |b| (|inc_SI| |b|)) (GO G190) G191 (EXIT NIL))))
                 (LETT |a| (|inc_SI| |a|)) (GO G190) G191 (EXIT NIL))
            (EXIT (SPADCALL |ga| (NREVERSE |r|) (QREFELT $ 11)))))
          #7# (EXIT #6#)))) 

(SDEFUN |GROUPP;outCosetTable|
        ((|ct| (|TwoDimensionalArray| (|NonNegativeInteger|)))
         (|np| #1=(|NonNegativeInteger|)) ($ (|OutputForm|)))
        (SPROG
         ((|cts| (|List| (|TwoDimensionalArray| (|NonNegativeInteger|))))
          (|part2| (|NonNegativeInteger|)) (#2=#:G1068 NIL) (|part1| #1#)
          (#3=#:G1074 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((< |np| 1)
              (PROGN
               (LETT #3# (SPADCALL |ct| (QREFELT $ 82)))
               (GO #4=#:G1073))))
            (COND
             ((> (SPADCALL |ct| (QREFELT $ 83)) |np|)
              (SEQ (LETT |part1| |np|)
                   (LETT |part2|
                         (PROG2
                             (LETT #2#
                                   (SPADCALL (SPADCALL |ct| (QREFELT $ 83))
                                             |np| (QREFELT $ 85)))
                             (QCDR #2#)
                           (|check_union2| (QEQCAR #2# 0)
                                           (|NonNegativeInteger|)
                                           (|Union| (|NonNegativeInteger|)
                                                    "failed")
                                           #2#)))
                   (LETT |cts|
                         (SPADCALL |ct| (LIST |part1| |part2|) (QREFELT $ 86)))
                   (EXIT (LETT |ct| (SPADCALL |cts| 1 (QREFELT $ 88)))))))
            (EXIT (SPADCALL |ct| (QREFELT $ 82)))))
          #4# (EXIT #3#)))) 

(SDEFUN |GROUPP;outStatus|
        ((|state|
          (|Record|
           (|:| |coset_table|
                #1=(|TwoDimensionalArray| (|NonNegativeInteger|)))
           (|:| |equiv_table| (|OneDimensionalArray| (|NonNegativeInteger|)))
           (|:| |inverse_table| (|OneDimensionalArray| (|NonNegativeInteger|)))
           (|:| |closed_point| (|NonNegativeInteger|))
           (|:| |number_of_generators| (|NonNegativeInteger|))
           (|:| |number_of_indices| #2=(|NonNegativeInteger|))
           (|:| |number_of_points| (|NonNegativeInteger|))
           (|:| |max_number_of_indices| (|NonNegativeInteger|))))
         ($ (|OutputForm|)))
        (SPROG ((|np| #2#) (|ct| #1#))
               (SEQ (LETT |ct| (QVELT |state| 0)) (LETT |np| (QVELT |state| 5))
                    (EXIT (|GROUPP;outCosetTable| |ct| |np| $))))) 

(SDEFUN |GROUPP;find|
        ((|et| (|OneDimensionalArray| (|NonNegativeInteger|)))
         (|ind| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|j| (|NonNegativeInteger|)) (|nj| (|NonNegativeInteger|))
          (|pj| (|NonNegativeInteger|)))
         (SEQ
          (COND ((OR (EQL |ind| 0) (EQL (QAREF1O |et| |ind| 1) |ind|)) |ind|)
                ('T
                 (SEQ (LETT |j| |ind|) (LETT |pj| 0)
                      (SEQ G190 (COND ((NULL (NULL (EQL |j| |pj|))) (GO G191)))
                           (SEQ (LETT |pj| |j|)
                                (EXIT (LETT |j| (QAREF1O |et| |j| 1))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |j| |ind|)
                      (SEQ G190 (COND ((NULL (NULL (EQL |j| |pj|))) (GO G191)))
                           (SEQ (LETT |nj| (QAREF1O |et| |j| 1))
                                (QSETAREF1O |et| |j| |pj| 1)
                                (EXIT (LETT |j| |nj|)))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT |pj|))))))) 

(SDEFUN |GROUPP;infer_coincidencies|
        ((|ct| (|TwoDimensionalArray| (|NonNegativeInteger|)))
         (|et| (|OneDimensionalArray| (|NonNegativeInteger|)))
         (|pb| #1=(|NonNegativeInteger|)) (|pe| #2=(|NonNegativeInteger|))
         (|trace| (|Boolean|)) ($ (|Void|)))
        (SPROG
         ((|i2| #3=(|NonNegativeInteger|)) (|i1| #3#) (#4=#:G1099 NIL)
          (|i| NIL) (#5=#:G1098 NIL) (|nn| (|Integer|)) (|#G135| #1#)
          (|#G134| #2#))
         (SEQ
          (COND
           (|trace|
            (SPADCALL
             (SPADCALL
              (SPADCALL
               (SPADCALL (SPADCALL "coincidence: begin=" (QREFELT $ 43))
                         (SPADCALL |pb| (QREFELT $ 66)) (QREFELT $ 42))
               (SPADCALL " end=" (QREFELT $ 43)) (QREFELT $ 42))
              (SPADCALL |pe| (QREFELT $ 66)) (QREFELT $ 42))
             (QREFELT $ 54))))
          (COND
           ((< |pe| |pb|)
            (PROGN
             (LETT |#G134| |pe|)
             (LETT |#G135| |pb|)
             (LETT |pb| |#G134|)
             (LETT |pe| |#G135|))))
          (QSETAREF1O |et| |pe| |pb| 1)
          (LETT |nn| (SPADCALL |ct| (QREFELT $ 89)))
          (SEQ (LETT |i| 1) (LETT #5# |nn|) G190
               (COND ((|greater_SI| |i| #5#) (GO G191)))
               (SEQ (LETT |i1| (QAREF2O |ct| |pb| |i| 1 1))
                    (LETT |i2| (QAREF2O |ct| |pe| |i| 1 1))
                    (EXIT
                     (COND ((EQL |i2| 0) "skip")
                           ((EQL |i1| 0)
                            (QSETAREF2O |ct| |pb| |i| |i2| 1 1)))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (SEQ (LETT |i| 1) (LETT #4# |nn|) G190
                (COND ((|greater_SI| |i| #4#) (GO G191)))
                (SEQ (LETT |i1| (QAREF2O |ct| |pb| |i| 1 1))
                     (EXIT
                      (COND ((EQL |i1| 0) "skip")
                            ('T
                             (SEQ (LETT |i2| (QAREF2O |ct| |pe| |i| 1 1))
                                  (EXIT
                                   (COND ((EQL |i2| 0) "skip")
                                         ('T
                                          (SEQ
                                           (LETT |i1|
                                                 (|GROUPP;find| |et| |i1| $))
                                           (LETT |i2|
                                                 (|GROUPP;find| |et| |i2| $))
                                           (EXIT
                                            (COND ((EQL |i1| |i2|) "skip")
                                                  ('T
                                                   (|GROUPP;infer_coincidencies|
                                                    |ct| |et| |i1| |i2| |trace|
                                                    $)))))))))))))
                (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |GROUPP;inferFromRelations|
        ((|state|
          (|Record|
           (|:| |coset_table|
                #1=(|TwoDimensionalArray| (|NonNegativeInteger|)))
           (|:| |equiv_table|
                #2=(|OneDimensionalArray| (|NonNegativeInteger|)))
           (|:| |inverse_table|
                #3=(|OneDimensionalArray| (|NonNegativeInteger|)))
           (|:| |closed_point| (|NonNegativeInteger|))
           (|:| |number_of_generators| (|NonNegativeInteger|))
           (|:| |number_of_indices| #4=(|NonNegativeInteger|))
           (|:| |number_of_points| (|NonNegativeInteger|))
           (|:| |max_number_of_indices| (|NonNegativeInteger|))))
         (|rels| (|List| #5=(|List| (|NonNegativeInteger|))))
         (|rrels| (|List| (|List| (|NonNegativeInteger|))))
         (|rel_lens| (|List| (|NonNegativeInteger|))) (|trace| (|Boolean|))
         ($ (|Boolean|)))
        (SPROG
         ((#6=#:G1154 NIL) (|npb| #7=(|NonNegativeInteger|)) (|npe| #7#)
          (|genIn| (|Integer|)) (|pb| #8=(|NonNegativeInteger|))
          (|gb| #9=(|NonNegativeInteger|)) (|gap| (|Integer|))
          (|add_gen| (|Integer|)) (|n_ind| #4#) (|o_size| (|Integer|))
          (|et| #2#) (|ct| #1#) (#10=#:G1170 NIL) (|i| #8#) (#11=#:G1169 NIL)
          (|j| NIL) (#12=#:G1168 NIL)
          (|net| (|OneDimensionalArray| (|NonNegativeInteger|)))
          (|nct| (|TwoDimensionalArray| (|NonNegativeInteger|)))
          (|n_ct_cols| (|Integer|)) (|n_size| (|NonNegativeInteger|))
          (#13=#:G1158 NIL) (|prel| #5#) (|add_to| #9#) (#14=#:G1167 NIL)
          (#15=#:G1166 NIL) (#16=#:G1165 NIL) (#17=#:G1164 NIL) (|pe| #8#)
          (|ge| #9#) (#18=#:G1155 NIL) (|genInv| (|Integer|)) (#19=#:G1163 NIL)
          (|genIndex| NIL) (#20=#:G1156 NIL) (#21=#:G1162 NIL)
          (#22=#:G1159 NIL) (|rel| NIL) (#23=#:G1160 NIL) (|rrel| NIL)
          (#24=#:G1161 NIL) (|r_len| NIL) (#25=#:G1157 NIL)
          (|closed| (|Boolean|)) (|pn| #8#) (|inv_tab| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |ct| (QVELT |state| 0)) (LETT |et| (QVELT |state| 1))
                (LETT |n_ind| (QVELT |state| 5))
                (LETT |inv_tab| (QVELT |state| 2))
                (COND
                 (|trace|
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL "inferFromRelations rels=" (QREFELT $ 43))
                    (SPADCALL |rels| (QREFELT $ 91)) (QREFELT $ 42))
                   (QREFELT $ 54))))
                (LETT |add_to| 0) (LETT |add_gen| 0)
                (LETT |pn| (+ (QVELT |state| 3) 1))
                (EXIT
                 (COND ((> |pn| |n_ind|) NIL)
                       ('T
                        (SEQ (QSETVELT |state| 3 |pn|)
                             (COND
                              ((NULL (EQL (QAREF1O |et| |pn| 1) |pn|))
                               (EXIT 'T)))
                             (LETT |o_size| (SPADCALL |ct| (QREFELT $ 92)))
                             (LETT |closed| NIL)
                             (SEQ
                              (EXIT
                               (SEQ G190
                                    (COND ((NULL (NULL |closed|)) (GO G191)))
                                    (SEQ (LETT |closed| 'T)
                                         (COND
                                          ((NULL
                                            (EQL (QAREF1O |et| |pn| 1) |pn|))
                                           (EXIT
                                            (PROGN
                                             (LETT #25# |$NoValue|)
                                             (GO #26=#:G1150)))))
                                         (SEQ (LETT |r_len| NIL)
                                              (LETT #24# |rel_lens|)
                                              (LETT |rrel| NIL)
                                              (LETT #23# |rrels|)
                                              (LETT |rel| NIL)
                                              (LETT #22# |rels|) G190
                                              (COND
                                               ((OR (ATOM #22#)
                                                    (PROGN
                                                     (LETT |rel| (CAR #22#))
                                                     NIL)
                                                    (ATOM #23#)
                                                    (PROGN
                                                     (LETT |rrel| (CAR #23#))
                                                     NIL)
                                                    (ATOM #24#)
                                                    (PROGN
                                                     (LETT |r_len| (CAR #24#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ (LETT |gb| 0)
                                                   (LETT |pb| |pn|)
                                                   (LETT |i| |pn|)
                                                   (LETT |genIn| 0)
                                                   (SEQ
                                                    (EXIT
                                                     (SEQ (LETT |genIndex| NIL)
                                                          (LETT #21# |rel|)
                                                          G190
                                                          (COND
                                                           ((OR (ATOM #21#)
                                                                (PROGN
                                                                 (LETT
                                                                  |genIndex|
                                                                  (CAR #21#))
                                                                 NIL))
                                                            (GO G191)))
                                                          (SEQ
                                                           (LETT |genIn|
                                                                 |genIndex|)
                                                           (LETT |i|
                                                                 (QAREF2O |ct|
                                                                          |i|
                                                                          |genIndex|
                                                                          1 1))
                                                           (EXIT
                                                            (COND
                                                             ((EQL |i| 0)
                                                              (PROGN
                                                               (LETT #20#
                                                                     |$NoValue|)
                                                               (GO
                                                                #27=#:G1109)))
                                                             ('T
                                                              (SEQ
                                                               (LETT |i|
                                                                     (|GROUPP;find|
                                                                      |et| |i|
                                                                      $))
                                                               (LETT |gb|
                                                                     (+ |gb|
                                                                        1))
                                                               (EXIT
                                                                (LETT |pb|
                                                                      |i|)))))))
                                                          (LETT #21#
                                                                (CDR #21#))
                                                          (GO G190) G191
                                                          (EXIT NIL)))
                                                    #27# (EXIT #20#))
                                                   (LETT |gap|
                                                         (- |r_len| |gb|))
                                                   (LETT |ge| 0)
                                                   (LETT |pe| |pn|)
                                                   (LETT |i| |pn|)
                                                   (LETT |genInv| 0)
                                                   (SEQ
                                                    (EXIT
                                                     (SEQ (LETT |genIndex| NIL)
                                                          (LETT #19# |rrel|)
                                                          G190
                                                          (COND
                                                           ((OR (ATOM #19#)
                                                                (PROGN
                                                                 (LETT
                                                                  |genIndex|
                                                                  (CAR #19#))
                                                                 NIL)
                                                                (NULL
                                                                 (< |ge|
                                                                    |gap|)))
                                                            (GO G191)))
                                                          (SEQ
                                                           (LETT |genInv|
                                                                 |genIndex|)
                                                           (LETT |i|
                                                                 (QAREF2O |ct|
                                                                          |i|
                                                                          |genIndex|
                                                                          1 1))
                                                           (EXIT
                                                            (COND
                                                             ((EQL |i| 0)
                                                              (PROGN
                                                               (LETT #18#
                                                                     |$NoValue|)
                                                               (GO
                                                                #28=#:G1113)))
                                                             ('T
                                                              (SEQ
                                                               (LETT |i|
                                                                     (|GROUPP;find|
                                                                      |et| |i|
                                                                      $))
                                                               (LETT |ge|
                                                                     (+ |ge|
                                                                        1))
                                                               (EXIT
                                                                (LETT |pe|
                                                                      |i|)))))))
                                                          (LETT #19#
                                                                (CDR #19#))
                                                          (GO G190) G191
                                                          (EXIT NIL)))
                                                    #28# (EXIT #18#))
                                                   (LETT |gap| (- |gap| |ge|))
                                                   (COND
                                                    ((> |gap| 1)
                                                     (SEQ (LETT |add_to| |pb|)
                                                          (LETT |add_gen|
                                                                |genIn|)
                                                          (SEQ
                                                           (COND
                                                            ((>= |n_ind|
                                                                 |o_size|)
                                                             (COND
                                                              ((EQL |n_ind|
                                                                    (QVELT
                                                                     |state|
                                                                     7))
                                                               (PROGN
                                                                (LETT #13# 'T)
                                                                (GO
                                                                 #29=#:G1153)))
                                                              ('T
                                                               (SEQ
                                                                (LETT |n_size|
                                                                      (MIN
                                                                       (* 2
                                                                          |o_size|)
                                                                       (QVELT
                                                                        |state|
                                                                        7)))
                                                                (LETT
                                                                 |n_ct_cols|
                                                                 (SPADCALL |ct|
                                                                           (QREFELT
                                                                            $
                                                                            89)))
                                                                (LETT |nct|
                                                                      (SPADCALL
                                                                       |n_size|
                                                                       |n_ct_cols|
                                                                       0
                                                                       (QREFELT
                                                                        $ 93)))
                                                                (LETT |net|
                                                                      (SPADCALL
                                                                       |n_size|
                                                                       0
                                                                       (QREFELT
                                                                        $ 95)))
                                                                (SEQ
                                                                 (LETT |i| 1)
                                                                 (LETT #17#
                                                                       |o_size|)
                                                                 G190
                                                                 (COND
                                                                  ((|greater_SI|
                                                                    |i| #17#)
                                                                   (GO G191)))
                                                                 (SEQ
                                                                  (QSETAREF1O
                                                                   |net| |i|
                                                                   (QAREF1O
                                                                    |et| |i| 1)
                                                                   1)
                                                                  (EXIT
                                                                   (SEQ
                                                                    (LETT |j|
                                                                          1)
                                                                    (LETT #16#
                                                                          |n_ct_cols|)
                                                                    G190
                                                                    (COND
                                                                     ((|greater_SI|
                                                                       |j|
                                                                       #16#)
                                                                      (GO
                                                                       G191)))
                                                                    (SEQ
                                                                     (EXIT
                                                                      (QSETAREF2O
                                                                       |nct|
                                                                       |i| |j|
                                                                       (QAREF2O
                                                                        |ct|
                                                                        |i| |j|
                                                                        1 1)
                                                                       1 1)))
                                                                    (LETT |j|
                                                                          (|inc_SI|
                                                                           |j|))
                                                                    (GO G190)
                                                                    G191
                                                                    (EXIT
                                                                     NIL))))
                                                                 (LETT |i|
                                                                       (|inc_SI|
                                                                        |i|))
                                                                 (GO G190) G191
                                                                 (EXIT NIL))
                                                                (SEQ
                                                                 (LETT |i|
                                                                       (+
                                                                        |o_size|
                                                                        1))
                                                                 (LETT #15#
                                                                       |n_size|)
                                                                 G190
                                                                 (COND
                                                                  ((> |i| #15#)
                                                                   (GO G191)))
                                                                 (SEQ
                                                                  (EXIT
                                                                   (QSETAREF1O
                                                                    |net| |i|
                                                                    |i| 1)))
                                                                 (LETT |i|
                                                                       (+ |i|
                                                                          1))
                                                                 (GO G190) G191
                                                                 (EXIT NIL))
                                                                (LETT |ct|
                                                                      |nct|)
                                                                (LETT |et|
                                                                      |net|)
                                                                (LETT |o_size|
                                                                      |n_size|)
                                                                (QSETVELT
                                                                 |state| 0
                                                                 |ct|)
                                                                (EXIT
                                                                 (QSETVELT
                                                                  |state| 1
                                                                  |et|)))))))
                                                           (LETT |n_ind|
                                                                 (+ |n_ind| 1))
                                                           (COND
                                                            (|trace|
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    #30="adding action of "
                                                                    (QREFELT $
                                                                             43))
                                                                   (SPADCALL
                                                                    |add_gen|
                                                                    (QREFELT $
                                                                             96))
                                                                   (QREFELT $
                                                                            42))
                                                                  (SPADCALL
                                                                   #31=" on "
                                                                   (QREFELT $
                                                                            43))
                                                                  (QREFELT $
                                                                           42))
                                                                 (SPADCALL
                                                                  |add_to|
                                                                  (QREFELT $
                                                                           66))
                                                                 (QREFELT $
                                                                          42))
                                                                (SPADCALL
                                                                 #32=" to be "
                                                                 (QREFELT $
                                                                          43))
                                                                (QREFELT $ 42))
                                                               (SPADCALL
                                                                |n_ind|
                                                                (QREFELT $ 66))
                                                               (QREFELT $ 42))
                                                              (QREFELT $ 54))))
                                                           (QSETAREF2O |ct|
                                                                       |add_to|
                                                                       |add_gen|
                                                                       |n_ind|
                                                                       1 1)
                                                           (LETT |add_gen|
                                                                 (SPADCALL
                                                                  |inv_tab|
                                                                  |add_gen|
                                                                  (QREFELT $
                                                                           97)))
                                                           (QSETAREF2O |ct|
                                                                       |n_ind|
                                                                       |add_gen|
                                                                       |add_to|
                                                                       1 1)
                                                           (COND
                                                            (|trace|
                                                             (SPADCALL
                                                              (|GROUPP;outStatus|
                                                               |state| $)
                                                              (QREFELT $ 54))))
                                                           (EXIT
                                                            (QSETVELT |state| 5
                                                                      |n_ind|)))
                                                          (LETT |gap|
                                                                (- |gap| 1))
                                                          (LETT |prel| |rel|)
                                                          (SEQ (LETT |i| 0)
                                                               (LETT #14# |gb|)
                                                               G190
                                                               (COND
                                                                ((|greater_SI|
                                                                  |i| #14#)
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT |prel|
                                                                       (CDR
                                                                        |prel|))))
                                                               (LETT |i|
                                                                     (|inc_SI|
                                                                      |i|))
                                                               (GO G190) G191
                                                               (EXIT NIL))
                                                          (LETT |gb|
                                                                (+ |gb| 1))
                                                          (SEQ G190
                                                               (COND
                                                                ((NULL
                                                                  (> |gap| 1))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (LETT |add_to|
                                                                      |n_ind|)
                                                                (LETT |add_gen|
                                                                      (|SPADfirst|
                                                                       |prel|))
                                                                (LETT |prel|
                                                                      (CDR
                                                                       |prel|))
                                                                (SEQ
                                                                 (COND
                                                                  ((>= |n_ind|
                                                                       |o_size|)
                                                                   (COND
                                                                    ((EQL
                                                                      |n_ind|
                                                                      (QVELT
                                                                       |state|
                                                                       7))
                                                                     (PROGN
                                                                      (LETT
                                                                       #13# 'T)
                                                                      (GO
                                                                       #29#)))
                                                                    ('T
                                                                     (SEQ
                                                                      (LETT
                                                                       |n_size|
                                                                       (MIN
                                                                        (* 2
                                                                           |o_size|)
                                                                        (QVELT
                                                                         |state|
                                                                         7)))
                                                                      (LETT
                                                                       |n_ct_cols|
                                                                       (SPADCALL
                                                                        |ct|
                                                                        (QREFELT
                                                                         $
                                                                         89)))
                                                                      (LETT
                                                                       |nct|
                                                                       (SPADCALL
                                                                        |n_size|
                                                                        |n_ct_cols|
                                                                        0
                                                                        (QREFELT
                                                                         $
                                                                         93)))
                                                                      (LETT
                                                                       |net|
                                                                       (SPADCALL
                                                                        |n_size|
                                                                        0
                                                                        (QREFELT
                                                                         $
                                                                         95)))
                                                                      (SEQ
                                                                       (LETT
                                                                        |i| 1)
                                                                       (LETT
                                                                        #12#
                                                                        |o_size|)
                                                                       G190
                                                                       (COND
                                                                        ((|greater_SI|
                                                                          |i|
                                                                          #12#)
                                                                         (GO
                                                                          G191)))
                                                                       (SEQ
                                                                        (QSETAREF1O
                                                                         |net|
                                                                         |i|
                                                                         (QAREF1O
                                                                          |et|
                                                                          |i|
                                                                          1)
                                                                         1)
                                                                        (EXIT
                                                                         (SEQ
                                                                          (LETT
                                                                           |j|
                                                                           1)
                                                                          (LETT
                                                                           #11#
                                                                           |n_ct_cols|)
                                                                          G190
                                                                          (COND
                                                                           ((|greater_SI|
                                                                             |j|
                                                                             #11#)
                                                                            (GO
                                                                             G191)))
                                                                          (SEQ
                                                                           (EXIT
                                                                            (QSETAREF2O
                                                                             |nct|
                                                                             |i|
                                                                             |j|
                                                                             (QAREF2O
                                                                              |ct|
                                                                              |i|
                                                                              |j|
                                                                              1
                                                                              1)
                                                                             1
                                                                             1)))
                                                                          (LETT
                                                                           |j|
                                                                           (|inc_SI|
                                                                            |j|))
                                                                          (GO
                                                                           G190)
                                                                          G191
                                                                          (EXIT
                                                                           NIL))))
                                                                       (LETT
                                                                        |i|
                                                                        (|inc_SI|
                                                                         |i|))
                                                                       (GO
                                                                        G190)
                                                                       G191
                                                                       (EXIT
                                                                        NIL))
                                                                      (SEQ
                                                                       (LETT
                                                                        |i|
                                                                        (+
                                                                         |o_size|
                                                                         1))
                                                                       (LETT
                                                                        #10#
                                                                        |n_size|)
                                                                       G190
                                                                       (COND
                                                                        ((> |i|
                                                                            #10#)
                                                                         (GO
                                                                          G191)))
                                                                       (SEQ
                                                                        (EXIT
                                                                         (QSETAREF1O
                                                                          |net|
                                                                          |i|
                                                                          |i|
                                                                          1)))
                                                                       (LETT
                                                                        |i|
                                                                        (+ |i|
                                                                           1))
                                                                       (GO
                                                                        G190)
                                                                       G191
                                                                       (EXIT
                                                                        NIL))
                                                                      (LETT
                                                                       |ct|
                                                                       |nct|)
                                                                      (LETT
                                                                       |et|
                                                                       |net|)
                                                                      (LETT
                                                                       |o_size|
                                                                       |n_size|)
                                                                      (QSETVELT
                                                                       |state|
                                                                       0 |ct|)
                                                                      (EXIT
                                                                       (QSETVELT
                                                                        |state|
                                                                        1
                                                                        |et|)))))))
                                                                 (LETT |n_ind|
                                                                       (+
                                                                        |n_ind|
                                                                        1))
                                                                 (COND
                                                                  (|trace|
                                                                   (SPADCALL
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          #30#
                                                                          (QREFELT
                                                                           $
                                                                           43))
                                                                         (SPADCALL
                                                                          |add_gen|
                                                                          (QREFELT
                                                                           $
                                                                           96))
                                                                         (QREFELT
                                                                          $
                                                                          42))
                                                                        (SPADCALL
                                                                         #31#
                                                                         (QREFELT
                                                                          $
                                                                          43))
                                                                        (QREFELT
                                                                         $ 42))
                                                                       (SPADCALL
                                                                        |add_to|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       (QREFELT
                                                                        $ 42))
                                                                      (SPADCALL
                                                                       #32#
                                                                       (QREFELT
                                                                        $ 43))
                                                                      (QREFELT
                                                                       $ 42))
                                                                     (SPADCALL
                                                                      |n_ind|
                                                                      (QREFELT
                                                                       $ 66))
                                                                     (QREFELT $
                                                                              42))
                                                                    (QREFELT $
                                                                             54))))
                                                                 (QSETAREF2O
                                                                  |ct| |add_to|
                                                                  |add_gen|
                                                                  |n_ind| 1 1)
                                                                 (LETT
                                                                  |add_gen|
                                                                  (SPADCALL
                                                                   |inv_tab|
                                                                   |add_gen|
                                                                   (QREFELT $
                                                                            97)))
                                                                 (QSETAREF2O
                                                                  |ct| |n_ind|
                                                                  |add_gen|
                                                                  |add_to| 1 1)
                                                                 (COND
                                                                  (|trace|
                                                                   (SPADCALL
                                                                    (|GROUPP;outStatus|
                                                                     |state| $)
                                                                    (QREFELT $
                                                                             54))))
                                                                 (EXIT
                                                                  (QSETVELT
                                                                   |state| 5
                                                                   |n_ind|)))
                                                                (LETT |gap|
                                                                      (- |gap|
                                                                         1))
                                                                (EXIT
                                                                 (LETT |gb|
                                                                       (+ |gb|
                                                                          1))))
                                                               NIL (GO G190)
                                                               G191 (EXIT NIL))
                                                          (LETT |pb| |n_ind|)
                                                          (EXIT
                                                           (LETT |genIn|
                                                                 (|SPADfirst|
                                                                  |prel|))))))
                                                   (EXIT
                                                    (COND
                                                     ((EQL |gap| 1)
                                                      (SEQ
                                                       (EXIT
                                                        (SEQ
                                                         (SEQ
                                                          (LETT |npe|
                                                                (QAREF2O |ct|
                                                                         |pb|
                                                                         |genIn|
                                                                         1 1))
                                                          (EXIT
                                                           (COND
                                                            ((NULL
                                                              (EQL |npe| 0))
                                                             (PROGN
                                                              (LETT #6#
                                                                    (COND
                                                                     ((EQL
                                                                       |npe|
                                                                       |pe|)
                                                                      "skip")
                                                                     ('T
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
                                                                                (SPADCALL
                                                                                 (SPADCALL
                                                                                  "coincidence: "
                                                                                  (QREFELT
                                                                                   $
                                                                                   43))
                                                                                 (SPADCALL
                                                                                  |pe|
                                                                                  (QREFELT
                                                                                   $
                                                                                   66))
                                                                                 (QREFELT
                                                                                  $
                                                                                  42))
                                                                                (SPADCALL
                                                                                 " "
                                                                                 (QREFELT
                                                                                  $
                                                                                  43))
                                                                                (QREFELT
                                                                                 $
                                                                                 42))
                                                                               (SPADCALL
                                                                                |npe|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               (QREFELT
                                                                                $
                                                                                42))
                                                                              (SPADCALL
                                                                               " rel = "
                                                                               (QREFELT
                                                                                $
                                                                                43))
                                                                              (QREFELT
                                                                               $
                                                                               42))
                                                                             (SPADCALL
                                                                              |rel|
                                                                              (QREFELT
                                                                               $
                                                                               98))
                                                                             (QREFELT
                                                                              $
                                                                              42))
                                                                            (SPADCALL
                                                                             " pn = "
                                                                             (QREFELT
                                                                              $
                                                                              43))
                                                                            (QREFELT
                                                                             $
                                                                             42))
                                                                           (SPADCALL
                                                                            |pn|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           (QREFELT
                                                                            $
                                                                            42))
                                                                          (QREFELT
                                                                           $
                                                                           54))))
                                                                       (EXIT
                                                                        (|GROUPP;infer_coincidencies|
                                                                         |ct|
                                                                         |et|
                                                                         |pe|
                                                                         |npe|
                                                                         |trace|
                                                                         $))))))
                                                              (GO
                                                               #33=#:G1145))))))
                                                         (COND
                                                          (|trace|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (SPADCALL
                                                                "inferFromRelations genIn="
                                                                (QREFELT $ 43))
                                                               (SPADCALL
                                                                |genIn|
                                                                (QREFELT $ 96))
                                                               (QREFELT $ 42))
                                                              (SPADCALL " gb="
                                                                        (QREFELT
                                                                         $ 43))
                                                              (QREFELT $ 42))
                                                             (SPADCALL |gb|
                                                                       (QREFELT
                                                                        $ 66))
                                                             (QREFELT $ 42))
                                                            (QREFELT $ 54))))
                                                         (COND
                                                          ((NULL
                                                            (EQL
                                                             (QAREF1O |inv_tab|
                                                                      |genIn|
                                                                      1)
                                                             |genInv|))
                                                           (EXIT
                                                            (|error|
                                                             "impossible 3"))))
                                                         (QSETAREF2O |ct| |pb|
                                                                     |genIn|
                                                                     |pe| 1 1)
                                                         (SEQ
                                                          (LETT |npb|
                                                                (QAREF2O |ct|
                                                                         |pe|
                                                                         |genInv|
                                                                         1 1))
                                                          (EXIT
                                                           (COND
                                                            ((NULL
                                                              (EQL |npb| 0))
                                                             (PROGN
                                                              (LETT #6#
                                                                    (COND
                                                                     ((EQL
                                                                       |npb|
                                                                       |pb|)
                                                                      "skip")
                                                                     ('T
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
                                                                                (SPADCALL
                                                                                 (SPADCALL
                                                                                  "coincidence: "
                                                                                  (QREFELT
                                                                                   $
                                                                                   43))
                                                                                 (SPADCALL
                                                                                  |npb|
                                                                                  (QREFELT
                                                                                   $
                                                                                   66))
                                                                                 (QREFELT
                                                                                  $
                                                                                  42))
                                                                                (SPADCALL
                                                                                 " "
                                                                                 (QREFELT
                                                                                  $
                                                                                  43))
                                                                                (QREFELT
                                                                                 $
                                                                                 42))
                                                                               (SPADCALL
                                                                                |pb|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               (QREFELT
                                                                                $
                                                                                42))
                                                                              (SPADCALL
                                                                               " rel = "
                                                                               (QREFELT
                                                                                $
                                                                                43))
                                                                              (QREFELT
                                                                               $
                                                                               42))
                                                                             (SPADCALL
                                                                              |rel|
                                                                              (QREFELT
                                                                               $
                                                                               98))
                                                                             (QREFELT
                                                                              $
                                                                              42))
                                                                            (SPADCALL
                                                                             " pn = "
                                                                             (QREFELT
                                                                              $
                                                                              43))
                                                                            (QREFELT
                                                                             $
                                                                             42))
                                                                           (SPADCALL
                                                                            |pn|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           (QREFELT
                                                                            $
                                                                            42))
                                                                          (QREFELT
                                                                           $
                                                                           54))))
                                                                       (EXIT
                                                                        (|GROUPP;infer_coincidencies|
                                                                         |ct|
                                                                         |et|
                                                                         |pb|
                                                                         |npb|
                                                                         |trace|
                                                                         $))))))
                                                              (GO #33#))))))
                                                         (EXIT
                                                          (QSETAREF2O |ct| |pe|
                                                                      |genInv|
                                                                      |pb| 1
                                                                      1))))
                                                       #33# (EXIT #6#)))
                                                     ((EQL |gap| 0)
                                                      (COND
                                                       ((EQL |pb| |pe|) "skip")
                                                       ('T
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
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    "coincidence: "
                                                                    (QREFELT $
                                                                             43))
                                                                   (SPADCALL
                                                                    |pb|
                                                                    (QREFELT $
                                                                             66))
                                                                   (QREFELT $
                                                                            42))
                                                                  (SPADCALL " "
                                                                            (QREFELT
                                                                             $
                                                                             43))
                                                                  (QREFELT $
                                                                           42))
                                                                 (SPADCALL |pe|
                                                                           (QREFELT
                                                                            $
                                                                            66))
                                                                 (QREFELT $
                                                                          42))
                                                                (SPADCALL
                                                                 " rel = "
                                                                 (QREFELT $
                                                                          43))
                                                                (QREFELT $ 42))
                                                               (SPADCALL |rel|
                                                                         (QREFELT
                                                                          $
                                                                          98))
                                                               (QREFELT $ 42))
                                                              (SPADCALL
                                                               " pn = "
                                                               (QREFELT $ 43))
                                                              (QREFELT $ 42))
                                                             (SPADCALL |pn|
                                                                       (QREFELT
                                                                        $ 66))
                                                             (QREFELT $ 42))
                                                            (QREFELT $ 54))))
                                                         (EXIT
                                                          (|GROUPP;infer_coincidencies|
                                                           |ct| |et| |pb| |pe|
                                                           |trace| $))))))
                                                     ('T
                                                      (|error|
                                                       "impossible 4")))))
                                              (LETT #22#
                                                    (PROG1 (CDR #22#)
                                                      (LETT #23#
                                                            (PROG1 (CDR #23#)
                                                              (LETT #24#
                                                                    (CDR
                                                                     #24#))))))
                                              (GO G190) G191 (EXIT NIL))
                                         (EXIT
                                          (COND
                                           ((NULL |closed|)
                                            (|error| "impossible 5")))))
                                    NIL (GO G190) G191 (EXIT NIL)))
                              #26# (EXIT #25#))
                             (EXIT 'T)))))))
          #29# (EXIT #13#)))) 

(SDEFUN |GROUPP;invertMap|
        ((|a| (|TwoDimensionalArray| (|NonNegativeInteger|)))
         ($ (|TwoDimensionalArray| (|NonNegativeInteger|))))
        (SPROG
         ((|i| (|NonNegativeInteger|)) (#1=#:G1176 NIL) (|x| NIL)
          (|invm| (|TwoDimensionalArray| (|NonNegativeInteger|))))
         (SEQ
          (LETT |invm|
                (SPADCALL (SPADCALL |a| (QREFELT $ 83))
                          (SPADCALL |a| (QREFELT $ 99)) 0 (QREFELT $ 93)))
          (SEQ (LETT |x| 1) (LETT #1# (SPADCALL |a| (QREFELT $ 83))) G190
               (COND ((|greater_SI| |x| #1#) (GO G191)))
               (SEQ (LETT |i| (SPADCALL |a| |x| 1 (QREFELT $ 100)))
                    (EXIT
                     (COND
                      ((SPADCALL |i| 0 (QREFELT $ 58))
                       (SPADCALL |invm| |i| 1 |x| (QREFELT $ 101))))))
               (LETT |x| (|inc_SI| |x|)) (GO G190) G191 (EXIT NIL))
          (EXIT |invm|)))) 

(SDEFUN |GROUPP;relatorTables|
        ((|state|
          (|Record|
           (|:| |coset_table|
                #1=(|TwoDimensionalArray| (|NonNegativeInteger|)))
           (|:| |equiv_table| (|OneDimensionalArray| (|NonNegativeInteger|)))
           (|:| |inverse_table| (|OneDimensionalArray| (|NonNegativeInteger|)))
           (|:| |closed_point| (|NonNegativeInteger|))
           (|:| |number_of_generators| (|NonNegativeInteger|))
           (|:| |number_of_indices| #2=(|NonNegativeInteger|))
           (|:| |number_of_points| (|NonNegativeInteger|))
           (|:| |max_number_of_indices| (|NonNegativeInteger|))))
         (|rels| (|List| (|List| (|Integer|))))
         ($ (|List| (|TwoDimensionalArray| (|NonNegativeInteger|)))))
        (SPROG
         ((|relators| (|List| (|TwoDimensionalArray| (|NonNegativeInteger|))))
          (|relatorTrim| #3=(|TwoDimensionalArray| (|NonNegativeInteger|)))
          (|cts| (|List| (|TwoDimensionalArray| (|NonNegativeInteger|))))
          (|part2| (|NonNegativeInteger|)) (#4=#:G1189 NIL) (|part1| #2#)
          (|relator| (|TwoDimensionalArray| (|NonNegativeInteger|)))
          (|fst| (|Boolean|)) (|relatorn| #3#) (|gNum| (|NonNegativeInteger|))
          (#5=#:G1184 NIL) (#6=#:G1200 NIL) (|g| NIL) (#7=#:G1199 NIL)
          (|r| NIL)
          (|invGenLists|
           (|List| (|TwoDimensionalArray| (|NonNegativeInteger|))))
          (#8=#:G1198 NIL) (|a| NIL) (#9=#:G1197 NIL)
          (|genLists| (|List| (|TwoDimensionalArray| (|NonNegativeInteger|))))
          (#10=#:G1179 NIL) (|np| #2#) (|ct| #1#))
         (SEQ (LETT |ct| (QVELT |state| 0)) (LETT |np| (QVELT |state| 5))
              (LETT |genLists|
                    (SPADCALL |ct|
                              (PROG1 (LETT #10# (SPADCALL |ct| (QREFELT $ 99)))
                                (|check_subtype2| (> #10# 0)
                                                  '(|PositiveInteger|)
                                                  '(|NonNegativeInteger|)
                                                  #10#))
                              (QREFELT $ 102)))
              (LETT |invGenLists|
                    (PROGN
                     (LETT #9# NIL)
                     (SEQ (LETT |a| NIL) (LETT #8# |genLists|) G190
                          (COND
                           ((OR (ATOM #8#) (PROGN (LETT |a| (CAR #8#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #9# (CONS (|GROUPP;invertMap| |a| $) #9#))))
                          (LETT #8# (CDR #8#)) (GO G190) G191
                          (EXIT (NREVERSE #9#)))))
              (LETT |relators| NIL)
              (SEQ (LETT |r| NIL) (LETT #7# |rels|) G190
                   (COND
                    ((OR (ATOM #7#) (PROGN (LETT |r| (CAR #7#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |relator| (SPADCALL 0 0 0 (QREFELT $ 93)))
                        (LETT |fst| 'T)
                        (SEQ (LETT |g| NIL) (LETT #6# |r|) G190
                             (COND
                              ((OR (ATOM #6#) (PROGN (LETT |g| (CAR #6#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |gNum|
                                    (PROG1 (LETT #5# (ABS |g|))
                                      (|check_subtype2| (>= #5# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #5#)))
                              (LETT |relatorn|
                                    (COND
                                     ((> |g| 0)
                                      (SPADCALL |genLists| |gNum|
                                                (QREFELT $ 88)))
                                     ('T
                                      (SPADCALL |invGenLists| |gNum|
                                                (QREFELT $ 88)))))
                              (EXIT
                               (COND
                                (|fst|
                                 (SEQ (LETT |relator| |relatorn|)
                                      (EXIT (LETT |fst| NIL))))
                                ('T
                                 (LETT |relator|
                                       (SPADCALL |relator| |relatorn|
                                                 (QREFELT $ 103)))))))
                             (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                        (LETT |relatorTrim| |relator|)
                        (COND
                         ((> (SPADCALL |relatorTrim| (QREFELT $ 83)) |np|)
                          (SEQ (LETT |part1| |np|)
                               (LETT |part2|
                                     (PROG2
                                         (LETT #4#
                                               (SPADCALL
                                                (SPADCALL |relatorTrim|
                                                          (QREFELT $ 83))
                                                |np| (QREFELT $ 85)))
                                         (QCDR #4#)
                                       (|check_union2| (QEQCAR #4# 0)
                                                       (|NonNegativeInteger|)
                                                       (|Union|
                                                        (|NonNegativeInteger|)
                                                        "failed")
                                                       #4#)))
                               (LETT |cts|
                                     (SPADCALL |relatorTrim|
                                               (LIST |part1| |part2|)
                                               (QREFELT $ 86)))
                               (EXIT
                                (LETT |relatorTrim|
                                      (SPADCALL |cts| 1 (QREFELT $ 88)))))))
                        (EXIT
                         (LETT |relators|
                               (SPADCALL |relators| |relatorTrim|
                                         (QREFELT $ 104)))))
                   (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
              (EXIT |relators|)))) 

(SDEFUN |GROUPP;generators2Permutation|
        ((|state|
          (|Record|
           (|:| |coset_table|
                #1=(|TwoDimensionalArray| (|NonNegativeInteger|)))
           (|:| |equiv_table|
                #2=(|OneDimensionalArray| (|NonNegativeInteger|)))
           (|:| |inverse_table| (|OneDimensionalArray| (|NonNegativeInteger|)))
           (|:| |closed_point| (|NonNegativeInteger|))
           (|:| |number_of_generators| #3=(|NonNegativeInteger|))
           (|:| |number_of_indices| #4=(|NonNegativeInteger|))
           (|:| |number_of_points| (|NonNegativeInteger|))
           (|:| |max_number_of_indices| (|NonNegativeInteger|))))
         (|trace| (|Boolean|)) ($ (|PermutationGroup| (|Integer|))))
        (SPROG
         ((|pl| (|List| (|Permutation| (|Integer|))))
          (|p| (|Permutation| (|Integer|))) (|gl| (|List| (|Integer|)))
          (#5=#:G1225 NIL) (|j| (|SingleInteger|))
          (|kk| (|NonNegativeInteger|)) (#6=#:G1224 NIL) (#7=#:G1223 NIL)
          (|i| NIL) (|perm_lists| (|Vector| (|List| (|Integer|))))
          (#8=#:G1222 NIL)
          (|net| (|OneDimensionalArray| (|NonNegativeInteger|))) (|et| #2#)
          (|n_inds| #4#) (|n_gens| #3#) (|ct| #1#))
         (SEQ (LETT |ct| (QVELT |state| 0))
              (COND
               (|trace|
                (SPADCALL
                 (SPADCALL "generators2Permutation generators=" (QREFELT $ 43))
                 (QREFELT $ 54))))
              (LETT |n_gens| (QVELT |state| 4))
              (LETT |n_inds| (QVELT |state| 5)) (LETT |et| (QVELT |state| 1))
              (LETT |net| (SPADCALL |n_inds| 0 (QREFELT $ 95))) (LETT |j| 0)
              (SEQ (LETT |i| 1) (LETT #8# |n_inds|) G190
                   (COND ((|greater_SI| |i| #8#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND ((NULL (EQL (QAREF1O |et| |i| 1) |i|)) "skip")
                           ('T
                            (SEQ (LETT |j| (|add_SI| |j| 1))
                                 (EXIT (QSETAREF1O |net| |i| |j| 1)))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |perm_lists| (MAKEARR1 |n_gens| NIL))
              (SEQ (LETT |i| 1) (LETT #7# |n_inds|) G190
                   (COND ((|greater_SI| |i| #7#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND ((NULL (EQL (QAREF1O |et| |i| 1) |i|)) "skip")
                           ('T
                            (SEQ (LETT |j| 1) (LETT #6# |n_gens|) G190
                                 (COND ((|greater_SI| |j| #6#) (GO G191)))
                                 (SEQ (LETT |kk| (QAREF2O |ct| |i| |j| 1 1))
                                      (EXIT
                                       (COND
                                        ((EQL |kk| 0)
                                         (SEQ
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL "i = "
                                                          (QREFELT $ 43))
                                                (SPADCALL |i| (QREFELT $ 66))
                                                (QREFELT $ 42))
                                               (SPADCALL " j = "
                                                         (QREFELT $ 43))
                                               (QREFELT $ 42))
                                              (SPADCALL |j| (QREFELT $ 66))
                                              (QREFELT $ 42))
                                             (SPADCALL " ct(i) = "
                                                       (QREFELT $ 43))
                                             (QREFELT $ 42))
                                            (SPADCALL
                                             (SPADCALL |ct| |i|
                                                       (QREFELT $ 105))
                                             (QREFELT $ 106))
                                            (QREFELT $ 42))
                                           (QREFELT $ 54))
                                          (EXIT
                                           (|error|
                                            "incomplete coset table"))))
                                        ('T
                                         (SEQ
                                          (LETT |kk|
                                                (QAREF1O |net|
                                                         (|GROUPP;find| |et|
                                                          |kk| $)
                                                         1))
                                          (EXIT
                                           (QSETAREF1O |perm_lists| |j|
                                                       (CONS |kk|
                                                             (QAREF1O
                                                              |perm_lists| |j|
                                                              1))
                                                       1)))))))
                                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                 (EXIT NIL))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |pl| NIL)
              (COND
               (|trace|
                (SPADCALL (SPADCALL |perm_lists| (QREFELT $ 108))
                          (QREFELT $ 54))))
              (SEQ (LETT |j| 1) (LETT #5# |n_gens|) G190
                   (COND ((|greater_SI| |j| #5#) (GO G191)))
                   (SEQ
                    (LETT |gl|
                          (NREVERSE
                           (SPADCALL |perm_lists| |j| (QREFELT $ 109))))
                    (LETT |p| (SPADCALL |gl| (QREFELT $ 111)))
                    (EXIT (LETT |pl| (CONS |p| |pl|))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (LETT |pl| (NREVERSE |pl|))
              (EXIT (SPADCALL |pl| (QREFELT $ 114)))))) 

(SDEFUN |GROUPP;toPermutationIfCan;$U;46|
        ((|a| ($)) ($ (|Union| (|PermutationGroup| (|Integer|)) "failed")))
        (SPADCALL |a| NIL (QREFELT $ 116))) 

(SDEFUN |GROUPP;toPermutationIfCan;$BU;47|
        ((|a| ($)) (|trace| (|Boolean|))
         ($ (|Union| (|PermutationGroup| (|Integer|)) "failed")))
        (SPADCALL |a| NIL |trace| (QREFELT $ 118))) 

(SDEFUN |GROUPP;convert_words|
        ((|words| (|List| (|List| #1=(|Integer|))))
         (|inv_tab| (|OneDimensionalArray| (|NonNegativeInteger|)))
         ($ (|List| (|List| (|List| (|NonNegativeInteger|))))))
        (SPROG
         ((|nrwords| (|List| (|List| (|NonNegativeInteger|))))
          (|nwords| (|List| (|List| (|NonNegativeInteger|)))) (#2=#:G1247 NIL)
          (|i| NIL) (#3=#:G1246 NIL) (|nword| (|List| (|NonNegativeInteger|)))
          (|gen| #1#) (#4=#:G1245 NIL) (#5=#:G1244 NIL) (|word| NIL))
         (SEQ (LETT |nwords| NIL) (LETT |nrwords| NIL)
              (SEQ (LETT |word| NIL) (LETT #5# |words|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |word| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |nword| NIL)
                        (SEQ (LETT |i| NIL) (LETT #4# |word|) G190
                             (COND
                              ((OR (ATOM #4#) (PROGN (LETT |i| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |gen|
                                    (COND ((> |i| 0) |i|)
                                          ('T
                                           (SPADCALL |inv_tab| (- |i|)
                                                     (QREFELT $ 97)))))
                              (EXIT (LETT |nword| (CONS |gen| |nword|))))
                             (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                        (LETT |nwords| (CONS |nword| |nwords|))
                        (EXIT
                         (LETT |nrwords|
                               (CONS
                                (NREVERSE
                                 (PROGN
                                  (LETT #3# NIL)
                                  (SEQ (LETT |i| NIL) (LETT #2# |nword|) G190
                                       (COND
                                        ((OR (ATOM #2#)
                                             (PROGN (LETT |i| (CAR #2#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #3#
                                               (CONS
                                                (SPADCALL |inv_tab| |i|
                                                          (QREFELT $ 97))
                                                #3#))))
                                       (LETT #2# (CDR #2#)) (GO G190) G191
                                       (EXIT (NREVERSE #3#)))))
                                |nrwords|))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (LETT |nwords| (NREVERSE |nwords|))
              (LETT |nrwords| (NREVERSE |nrwords|))
              (EXIT (LIST |nwords| |nrwords|))))) 

(SDEFUN |GROUPP;toPermutationIfCan;$LBU;49|
        ((|a| ($)) (|sg| (|List| (|List| (|Integer|)))) (|trace| (|Boolean|))
         ($ (|Union| (|PermutationGroup| (|Integer|)) "failed")))
        (SPROG
         ((#1=#:G1272 NIL) (#2=#:G1273 NIL) (#3=#:G1274 NIL)
          (|changedByDeduction| (|Boolean|))
          (|sgens_lens| (|List| #4=(|NonNegativeInteger|))) (#5=#:G1279 NIL)
          (|word| NIL) (#6=#:G1278 NIL) (|nrsgens| NIL)
          (|#G191| #7=(|List| (|List| (|List| (|NonNegativeInteger|)))))
          (|nsgens| NIL) (|#G190| #7#)
          (|state|
           (|Record|
            (|:| |coset_table| (|TwoDimensionalArray| (|NonNegativeInteger|)))
            (|:| |equiv_table| (|OneDimensionalArray| (|NonNegativeInteger|)))
            (|:| |inverse_table|
                 (|OneDimensionalArray| (|NonNegativeInteger|)))
            (|:| |closed_point| (|NonNegativeInteger|))
            (|:| |number_of_generators| (|NonNegativeInteger|))
            (|:| |number_of_indices| (|NonNegativeInteger|))
            (|:| |number_of_points| (|NonNegativeInteger|))
            (|:| |max_number_of_indices| (|NonNegativeInteger|))))
          (|loopLimit| (|NonNegativeInteger|))
          (|rel_lens| (|List| (|NonNegativeInteger|))) (#8=#:G1277 NIL)
          (|rel| NIL) (#9=#:G1276 NIL) (|nrrels| NIL) (|#G186| #7#)
          (|nrels| NIL) (|#G185| #7#) (#10=#:G1275 NIL) (|i| NIL)
          (|inv_tab| #11=(|OneDimensionalArray| (|NonNegativeInteger|)))
          (|et| #11#) (|ct| (|TwoDimensionalArray| (|NonNegativeInteger|)))
          (|numGens| #4#) (|unit| (|Permutation| (|Integer|)))
          (|rs| (|List| (|List| (|Integer|))))
          (|gs| (|List| (|NonNegativeInteger|))))
         (SEQ
          (EXIT
           (SEQ (LETT |gs| (SPADCALL (QCAR |a|) (QREFELT $ 17)))
                (LETT |rs| (QCDR |a|))
                (COND
                 ((EQL (SPADCALL |gs| (QREFELT $ 62)) 0)
                  (COND
                   ((EQL (LENGTH |rs|) 0)
                    (SEQ (LETT |unit| (|spadConstant| $ 119))
                         (EXIT
                          (PROGN
                           (LETT #3#
                                 (CONS 0
                                       (SPADCALL (LIST |unit|)
                                                 (QREFELT $ 114))))
                           (GO #12=#:G1271))))))))
                (COND
                 ((> (SPADCALL |gs| (QREFELT $ 62)) (LENGTH |rs|))
                  (PROGN (LETT #3# (CONS 1 "failed")) (GO #12#))))
                (LETT |numGens| (SPADCALL |gs| (QREFELT $ 62)))
                (LETT |ct| (SPADCALL 10 (* 2 |numGens|) 0 (QREFELT $ 93)))
                (LETT |et| (SPADCALL 10 0 (QREFELT $ 95)))
                (SEQ (LETT |i| 1) G190 (COND ((|greater_SI| |i| 10) (GO G191)))
                     (SEQ (EXIT (QSETAREF1O |et| |i| |i| 1)))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (LETT |inv_tab| (SPADCALL (* 2 |numGens|) 0 (QREFELT $ 95)))
                (SEQ (LETT |i| 1) (LETT #10# |numGens|) G190
                     (COND ((|greater_SI| |i| #10#) (GO G191)))
                     (SEQ (QSETAREF1O |inv_tab| |i| (+ |i| |numGens|) 1)
                          (EXIT
                           (QSETAREF1O |inv_tab| (+ |i| |numGens|) |i| 1)))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (PROGN
                 (LETT |#G185| (|GROUPP;convert_words| |rs| |inv_tab| $))
                 (LETT |#G186| |#G185|)
                 (LETT |nrels| (|SPADfirst| |#G186|))
                 (LETT |#G186| (CDR |#G186|))
                 (LETT |nrrels| (|SPADfirst| |#G186|))
                 |#G185|)
                (LETT |rel_lens|
                      (PROGN
                       (LETT #9# NIL)
                       (SEQ (LETT |rel| NIL) (LETT #8# |nrels|) G190
                            (COND
                             ((OR (ATOM #8#)
                                  (PROGN (LETT |rel| (CAR #8#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #9#
                                    (CONS (SPADCALL |rel| (QREFELT $ 62))
                                          #9#))))
                            (LETT #8# (CDR #8#)) (GO G190) G191
                            (EXIT (NREVERSE #9#)))))
                (LETT |loopLimit| (QUOTIENT2 5000000 |numGens|))
                (LETT |state|
                      (VECTOR |ct| |et| |inv_tab| 0 |numGens| 1 1 |loopLimit|))
                (PROGN
                 (LETT |#G190| (|GROUPP;convert_words| |sg| |inv_tab| $))
                 (LETT |#G191| |#G190|)
                 (LETT |nsgens| (|SPADfirst| |#G191|))
                 (LETT |#G191| (CDR |#G191|))
                 (LETT |nrsgens| (|SPADfirst| |#G191|))
                 |#G190|)
                (LETT |sgens_lens|
                      (PROGN
                       (LETT #6# NIL)
                       (SEQ (LETT |word| NIL) (LETT #5# |nsgens|) G190
                            (COND
                             ((OR (ATOM #5#)
                                  (PROGN (LETT |word| (CAR #5#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #6#
                                    (CONS (SPADCALL |word| (QREFELT $ 62))
                                          #6#))))
                            (LETT #5# (CDR #5#)) (GO G190) G191
                            (EXIT (NREVERSE #6#)))))
                (|GROUPP;inferFromRelations| |state|
                 (SPADCALL |nsgens| |nrels| (QREFELT $ 120))
                 (SPADCALL |nrsgens| |nrrels| (QREFELT $ 120))
                 (SPADCALL |sgens_lens| |rel_lens| (QREFELT $ 74)) |trace| $)
                (SEQ
                 (EXIT
                  (SEQ G190 (COND ((NULL 'T) (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ
                          (LETT |changedByDeduction|
                                (|GROUPP;inferFromRelations| |state| |nrels|
                                 |nrrels| |rel_lens| |trace| $))
                          (COND
                           ((NULL |changedByDeduction|)
                            (SEQ
                             (COND
                              (|trace|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL "finished using " (QREFELT $ 43))
                                 (SPADCALL (QVELT |state| 5) (QREFELT $ 66))
                                 (QREFELT $ 42))
                                (QREFELT $ 54))))
                             (EXIT
                              (PROGN
                               (LETT #3#
                                     (CONS 0
                                           (|GROUPP;generators2Permutation|
                                            |state| |trace| $)))
                               (GO #12#))))))
                          (COND
                           (|trace|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL "relatorTables=" (QREFELT $ 43))
                              (SPADCALL (|GROUPP;relatorTables| |state| |rs| $)
                                        (QREFELT $ 121))
                              (QREFELT $ 42))
                             (QREFELT $ 54))))
                          (EXIT
                           (COND
                            ((>= (QVELT |state| 5) |loopLimit|)
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 1) (GO #13=#:G1269)))
                              (GO #14=#:G1268)))))))
                        #14# (EXIT #1#))
                       NIL (GO G190) G191 (EXIT NIL)))
                 #13# (EXIT #2#))
                (EXIT (CONS 1 "failed"))))
          #12# (EXIT #3#)))) 

(SDEFUN |GROUPP;coerce;$Of;50| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|r| (|OutputForm|)) (|rs| (|List| (|List| (|Integer|))))
          (|g| (|OutputForm|)) (|ps| (|List| (|NonNegativeInteger|))))
         (SEQ (LETT |ps| (SPADCALL (QCAR |s|) (QREFELT $ 122)))
              (LETT |g| (|GROUPP;outputGenList| |ps| $)) (LETT |rs| (QCDR |s|))
              (LETT |r| (|GROUPP;outputRelList| |rs| $))
              (EXIT
               (SPADCALL
                (LIST (SPADCALL "<" (QREFELT $ 43)) |g|
                      (SPADCALL " | " (QREFELT $ 43)) |r|
                      (SPADCALL ">" (QREFELT $ 43)))
                (QREFELT $ 44)))))) 

(DECLAIM (NOTINLINE |GroupPresentation;|)) 

(DEFUN |GroupPresentation| ()
  (SPROG NIL
         (PROG (#1=#:G1283)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|GroupPresentation|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|GroupPresentation|
                             (LIST
                              (CONS NIL (CONS 1 (|GroupPresentation;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|GroupPresentation|)))))))))) 

(DEFUN |GroupPresentation;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|GroupPresentation|))
          (LETT $ (GETREFV 125))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GroupPresentation| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record|
                     (|:| |gens| (|PrimitiveArray| (|NonNegativeInteger|)))
                     (|:| |rels| (|List| (|List| (|Integer|))))))
          $))) 

(MAKEPROP '|GroupPresentation| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|List| 18) (|PrimitiveArray| 18)
              (0 . |construct|) (|List| 24) |GROUPP;groupPresentation;LL$;1|
              |GROUPP;groupPresentation;L$;2| |GROUPP;groupPresentation;$;3|
              (|List| $) (|String|) (5 . |concat|) (10 . |entries|)
              (|NonNegativeInteger|) (15 . |#|)
              (|Record| (|:| |OldGen| 18) (|:| |NewGen| 18)) (|List| 20)
              (20 . |concat|) (|Integer|) (|List| 23) (26 . |concat|)
              (32 . |concat|) |GROUPP;refactor;2$;5| (|Set| 18) (38 . |set|)
              (|Boolean|) (43 . ~=) (49 . |entries|) (|Set| 24) (54 . |set|)
              (59 . =) |GROUPP;=;2$B;6| (|Character|) (65 . |elt|)
              (|OutputForm|) (71 . |coerce|) (76 . |outputForm|)
              (81 . |hconcat|) (87 . |message|) (92 . |hconcat|) (|List| 39)
              (97 . |concat|) (103 . |commaSeparate|) (108 . |blankSeparate|)
              (113 . |member?|) (119 . |concat|) (125 . |remove|)
              (131 . |remove|) (|Void|) (137 . |print|) (142 . |second|)
              (147 . |sign|) (152 . ~=) (158 . ~=) (164 . =) (170 . |copy|)
              (175 . |coerce|) (180 . |#|) (185 . |elt|) (191 . |elt|)
              |GROUPP;coerce;$Of;50| (197 . |coerce|) (202 . |concat|)
              |GROUPP;simplify;$B$;30| |GROUPP;simplify;2$;29|
              |GROUPP;quotient;$L$;32| (208 . |entries|) (213 . |concat|)
              |GROUPP;quotient;$L$;33| (219 . |concat|) (225 . |concat|)
              |GROUPP;directProduct;3$;34| (|PositiveInteger|)
              |GROUPP;cyclicGroup;Pi$;35| |GROUPP;dihedralGroup;Pi$;36|
              |GROUPP;symmetricGroup;Pi$;37| (|TwoDimensionalArray| 18)
              (230 . |coerce|) (235 . |nrows|) (|Union| $ '"failed")
              (240 . |subtractIfCan|) (246 . |vertSplit|) (|List| 81)
              (252 . |elt|) (258 . |maxColIndex|) (|List| 7) (263 . |coerce|)
              (268 . |maxRowIndex|) (273 . |new|) (|OneDimensionalArray| 18)
              (280 . |new|) (286 . |coerce|) (291 . |elt|) (297 . |coerce|)
              (302 . |ncols|) (307 . |elt|) (314 . |setelt!|)
              (322 . |horizSplit|) (328 . |horizConcat|) (334 . |concat|)
              (340 . |row|) (346 . |coerce|) (|Vector| 24) (351 . |coerce|)
              (356 . |elt|) (|Permutation| 23) (362 . |coerceImages|)
              (|List| 110) (|PermutationGroup| 23) (367 . |permutationGroup|)
              (|Union| 113 '"failed") |GROUPP;toPermutationIfCan;$BU;47|
              |GROUPP;toPermutationIfCan;$U;46|
              |GROUPP;toPermutationIfCan;$LBU;49| (372 . |One|)
              (376 . |concat|) (382 . |coerce|) (387 . |parts|)
              (|SingleInteger|) (|HashState|))
           '#(~= 392 |toPermutationIfCan| 398 |symmetricGroup| 416 |simplify|
              421 |refactor| 432 |quotient| 437 |latex| 449 |hashUpdate!| 454
              |hash| 460 |groupPresentation| 465 |directProduct| 480
              |dihedralGroup| 486 |cyclicGroup| 491 |coerce| 496 = 501)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 39))
                        (|makeByteWordVec2| 124
                                            '(1 8 0 7 9 1 15 0 14 16 1 8 7 0 17
                                              1 8 18 0 19 2 21 0 0 20 22 2 24 0
                                              0 23 25 2 10 0 0 24 26 1 28 0 7
                                              29 2 28 30 0 0 31 1 10 10 0 32 1
                                              33 0 10 34 2 33 30 0 0 35 2 15 37
                                              0 23 38 1 37 39 0 40 1 39 0 23 41
                                              2 39 0 0 0 42 1 39 0 15 43 1 39 0
                                              14 44 2 45 0 0 39 46 1 39 0 14 47
                                              1 39 0 14 48 2 24 30 23 0 49 2 7
                                              0 0 18 50 2 8 0 18 0 51 2 24 0 23
                                              0 52 1 39 53 0 54 1 24 23 0 55 1
                                              23 23 0 56 2 23 30 0 0 57 2 18 30
                                              0 0 58 2 24 30 0 0 59 1 24 0 0 60
                                              1 24 39 0 61 1 7 18 0 62 2 7 18 0
                                              23 63 2 10 24 0 23 64 1 18 39 0
                                              66 2 24 0 0 0 67 1 7 7 0 71 2 10
                                              0 0 0 72 2 7 0 0 0 74 1 10 0 14
                                              75 1 81 39 0 82 1 81 18 0 83 2 18
                                              84 0 0 85 2 81 14 0 7 86 2 87 81
                                              0 23 88 1 81 23 0 89 1 90 39 0 91
                                              1 81 23 0 92 3 81 0 18 18 18 93 2
                                              94 0 18 18 95 1 23 39 0 96 2 94
                                              18 0 23 97 1 7 39 0 98 1 81 18 0
                                              99 3 81 18 0 23 23 100 4 81 18 0
                                              23 23 18 101 2 81 14 0 77 102 2
                                              81 0 0 0 103 2 87 0 0 81 104 2 81
                                              94 0 23 105 1 94 39 0 106 1 107
                                              39 0 108 2 107 24 0 23 109 1 110
                                              0 24 111 1 113 0 112 114 0 110 0
                                              119 2 90 0 0 0 120 1 87 39 0 121
                                              1 8 7 0 122 2 0 30 0 0 1 2 0 115
                                              0 30 116 3 0 115 0 10 30 118 1 0
                                              115 0 117 1 0 0 77 80 1 0 0 0 69
                                              2 0 0 0 30 68 1 0 0 0 27 2 0 0 0
                                              10 73 2 0 0 0 7 70 1 0 15 0 1 2 0
                                              124 124 0 1 1 0 123 0 1 0 0 0 13
                                              2 0 0 7 10 11 1 0 0 7 12 2 0 0 0
                                              0 76 1 0 0 77 79 1 0 0 77 78 1 0
                                              39 0 65 2 0 30 0 0 36)))))
           '|lookupComplete|)) 

(MAKEPROP '|GroupPresentation| 'NILADIC T) 

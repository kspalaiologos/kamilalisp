
(SDEFUN |EXP3D;faceIndex|
        ((|subSp| (|SubSpace| 3 (|DoubleFloat|)))
         ($ (|List| (|NonNegativeInteger|))))
        (SPROG
         ((|faceIndexList| (|List| (|NonNegativeInteger|))) (#1=#:G710 NIL)
          (|poly| NIL))
         (SEQ (LETT |faceIndexList| NIL)
              (SEQ (LETT |poly| NIL)
                   (LETT #1# (SPADCALL |subSp| (QREFELT $ 8))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |poly| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |faceIndexList|
                           (CONS (SPADCALL |poly| (QREFELT $ 10))
                                 |faceIndexList|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (REVERSE |faceIndexList|))))) 

(SDEFUN |EXP3D;writePolygon|
        ((|f1| (|TextFile|)) (|curves| (|List| (|SubSpace| 3 (|DoubleFloat|))))
         ($ (|Void|)))
        (SPROG
         ((|s| (|String|)) (#1=#:G721 NIL) (|i| NIL)
          (|faceIndexList| (|List| (|NonNegativeInteger|))) (#2=#:G720 NIL)
          (|curve| NIL))
         (SEQ (LETT |faceIndexList| NIL)
              (SEQ (LETT |curve| NIL) (LETT #2# |curves|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |curve| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |faceIndexList|
                           (SPADCALL |faceIndexList|
                                     (|EXP3D;faceIndex| |curve| $)
                                     (QREFELT $ 12)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |s| "f ")
              (SEQ (LETT |i| NIL) (LETT #1# |faceIndexList|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |s| (STRCONC |s| (STRINGIMAGE |i|)))
                        (EXIT (LETT |s| (STRCONC |s| " "))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |f1| |s| (QREFELT $ 15)))))) 

(SDEFUN |EXP3D;writeMesh|
        ((|f1| (|TextFile|)) (|curves| (|List| (|SubSpace| 3 (|DoubleFloat|))))
         ($ (|Void|)))
        (SPROG
         ((|s| (|String|)) (#1=#:G743 NIL) (|j| NIL) (#2=#:G742 NIL) (|i| NIL)
          (|colLength| (|NonNegativeInteger|))
          (|rowLength| (|NonNegativeInteger|))
          (|meshIndexArray| (|List| (|List| (|NonNegativeInteger|))))
          (#3=#:G741 NIL) (|curve| NIL))
         (SEQ (LETT |meshIndexArray| NIL)
              (SEQ (LETT |curve| NIL) (LETT #3# |curves|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |curve| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |meshIndexArray|
                           (CONS (|EXP3D;faceIndex| |curve| $)
                                 |meshIndexArray|))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (LETT |meshIndexArray| (REVERSE |meshIndexArray|))
              (LETT |rowLength| (LENGTH |meshIndexArray|))
              (LETT |colLength|
                    (SPADCALL (SPADCALL |meshIndexArray| 1 (QREFELT $ 18))
                              (QREFELT $ 19)))
              (EXIT
               (SEQ (LETT |i| 1) (LETT #2# (- |rowLength| 1)) G190
                    (COND ((|greater_SI| |i| #2#) (GO G191)))
                    (SEQ
                     (EXIT
                      (SEQ (LETT |j| 1) (LETT #1# (- |colLength| 1)) G190
                           (COND ((|greater_SI| |j| #1#) (GO G191)))
                           (SEQ
                            (LETT |s|
                                  (SPADCALL
                                   (LIST "f "
                                         (STRINGIMAGE
                                          (SPADCALL
                                           (SPADCALL |meshIndexArray| |i|
                                                     (QREFELT $ 18))
                                           |j| (QREFELT $ 20)))
                                         " "
                                         (STRINGIMAGE
                                          (SPADCALL
                                           (SPADCALL |meshIndexArray| (+ |i| 1)
                                                     (QREFELT $ 18))
                                           |j| (QREFELT $ 20)))
                                         " "
                                         (STRINGIMAGE
                                          (SPADCALL
                                           (SPADCALL |meshIndexArray| (+ |i| 1)
                                                     (QREFELT $ 18))
                                           (+ |j| 1) (QREFELT $ 20)))
                                         " "
                                         (STRINGIMAGE
                                          (SPADCALL
                                           (SPADCALL |meshIndexArray| |i|
                                                     (QREFELT $ 18))
                                           (+ |j| 1) (QREFELT $ 20))))
                                   (QREFELT $ 21)))
                            (EXIT (SPADCALL |f1| |s| (QREFELT $ 15))))
                           (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                           (EXIT NIL))))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |EXP3D;toString| ((|d| (|DoubleFloat|)) ($ (|String|)))
        (SPADCALL (SPADCALL |d| (QREFELT $ 24)) (QREFELT $ 25))) 

(SDEFUN |EXP3D;writeObj;SsSV;5|
        ((|subSp| (|SubSpace| 3 (|DoubleFloat|))) (|filename| (|String|))
         ($ (|Void|)))
        (SPROG
         ((|curves| (|List| (|SubSpace| 3 (|DoubleFloat|)))) (#1=#:G757 NIL)
          (|component| NIL) (#2=#:G756 NIL) (|v| NIL)
          (|verts| (|List| (|Point| (|DoubleFloat|)))) (|f1| (|TextFile|)))
         (SEQ
          (LETT |f1|
                (SPADCALL (SPADCALL |filename| (QREFELT $ 27)) "output"
                          (QREFELT $ 28)))
          (SPADCALL |f1| "# mesh generated by fricas" (QREFELT $ 15))
          (LETT |verts| (SPADCALL |subSp| (QREFELT $ 30)))
          (SEQ (LETT |v| NIL) (LETT #2# |verts|) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL)) (GO G191)))
               (SEQ
                (EXIT
                 (COND
                  ((< (SPADCALL |v| (QREFELT $ 32)) 3)
                   (|error| "Can't write OBJ file from 2D points"))
                  ('T
                   (SPADCALL |f1|
                             (SPADCALL
                              (LIST "v "
                                    (|EXP3D;toString|
                                     (SPADCALL |v| 1 (QREFELT $ 33)) $)
                                    " "
                                    (|EXP3D;toString|
                                     (SPADCALL |v| 2 (QREFELT $ 33)) $)
                                    " "
                                    (|EXP3D;toString|
                                     (SPADCALL |v| 3 (QREFELT $ 33)) $))
                              (QREFELT $ 21))
                             (QREFELT $ 15))))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (SEQ (LETT |component| NIL)
               (LETT #1# (SPADCALL |subSp| (QREFELT $ 8))) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |component| (CAR #1#)) NIL))
                 (GO G191)))
               (SEQ (LETT |curves| (SPADCALL |component| (QREFELT $ 8)))
                    (COND
                     ((< (LENGTH |curves|) 2)
                      (SPADCALL "Can't write point or curve to OBJ file"
                                (QREFELT $ 36))))
                    (EXIT
                     (COND
                      ((> (LENGTH |curves|) 1)
                       (SEQ
                        (COND
                         ((EQL
                           (SPADCALL (SPADCALL |curves| 1 (QREFELT $ 38))
                                     (QREFELT $ 39))
                           1)
                          (|EXP3D;writePolygon| |f1| |curves| $)))
                        (EXIT
                         (COND
                          ((>
                            (SPADCALL (SPADCALL |curves| 1 (QREFELT $ 38))
                                      (QREFELT $ 39))
                            1)
                           (|EXP3D;writeMesh| |f1| |curves| $)))))))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |f1| (QREFELT $ 40)))))) 

(DECLAIM (NOTINLINE |Export3D;|)) 

(DEFUN |Export3D| ()
  (SPROG NIL
         (PROG (#1=#:G759)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Export3D|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Export3D|
                             (LIST (CONS NIL (CONS 1 (|Export3D;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Export3D|)))))))))) 

(DEFUN |Export3D;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Export3D|))
          (LETT $ (GETREFV 42))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Export3D| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Export3D| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|List| $) (|SubSpace| '3 23)
              (0 . |children|) (|NonNegativeInteger|) (5 . |extractIndex|)
              (|List| 9) (10 . |append|) (|String|) (|TextFile|)
              (16 . |writeLine!|) (|Integer|) (|List| 11) (22 . |elt|)
              (28 . |#|) (33 . |elt|) (39 . |concat|) (|InputForm|)
              (|DoubleFloat|) (44 . |convert|) (49 . |unparse|) (|FileName|)
              (54 . |coerce|) (59 . |open|) (|List| 31) (65 . |pointData|)
              (|Point| 23) (70 . |#|) (75 . |elt|) (|Void|) (|DisplayPackage|)
              (81 . |say|) (|List| 7) (86 . |elt|) (92 . |numberOfChildren|)
              (97 . |close!|) |EXP3D;writeObj;SsSV;5|)
           '#(|writeObj| 102) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|writeObj|
                                 ((|Void|) (|SubSpace| 3 (|DoubleFloat|))
                                  (|String|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 41
                                            '(1 7 6 0 8 1 7 9 0 10 2 11 0 0 0
                                              12 2 14 13 0 13 15 2 17 11 0 16
                                              18 1 11 9 0 19 2 11 9 0 16 20 1
                                              13 0 6 21 1 23 22 0 24 1 22 13 0
                                              25 1 26 0 13 27 2 14 0 26 13 28 1
                                              7 29 0 30 1 31 9 0 32 2 31 23 0
                                              16 33 1 35 34 13 36 2 37 7 0 16
                                              38 1 7 9 0 39 1 14 0 0 40 2 0 34
                                              7 13 41)))))
           '|lookupComplete|)) 

(MAKEPROP '|Export3D| 'NILADIC T) 

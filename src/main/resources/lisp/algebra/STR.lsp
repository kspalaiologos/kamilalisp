
(SDEFUN |STR;qelt|
        ((|m| ($)) (|i| (|Integer|)) (|j| (|Integer|)) ($ (|DoubleFloat|)))
        (SPROG ((#1=#:G693 NIL))
               (QAREF1
                (QAREF1
                 (PROG2 (LETT #1# |m|)
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0)
                                   (|PrimitiveArray|
                                    (|PrimitiveArray| (|DoubleFloat|)))
                                   (|Union|
                                    (|:| |mtx|
                                         (|PrimitiveArray|
                                          (|PrimitiveArray| (|DoubleFloat|))))
                                    (|:| |general|
                                         (|Mapping| (QREFELT $ 6)
                                                    (QREFELT $ 6)))
                                    (|:| |multiv|
                                         (|PrimitiveArray| (|DoubleFloat|)))
                                    (|:| |iden| "iden"))
                                   #1#))
                 |i|)
                |j|))) 

(SDEFUN |STR;stransform;L$;2| ((|m| (|List| (|List| (|DoubleFloat|)))) ($ ($)))
        (SPROG
         ((|j| NIL) (|i| NIL)
          (|arr| (|PrimitiveArray| (|PrimitiveArray| (|DoubleFloat|)))))
         (SEQ
          (COND
           ((EQUAL (QREFELT $ 6) (|SCartesian| 2))
            (SEQ (LETT |arr| (MAKEARR1 3 (MAKE-ARRAY 0)))
                 (SEQ (LETT |i| 0) G190 (COND ((|greater_SI| |i| 2) (GO G191)))
                      (SEQ (QSETAREF1 |arr| |i| (MAKEARR1 3 0.0))
                           (EXIT
                            (SEQ (LETT |j| 0) G190
                                 (COND ((|greater_SI| |j| 2) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (QSETAREF1 (QAREF1 |arr| |i|) |j|
                                              (SPADCALL
                                               (SPADCALL |m| (+ |i| 1)
                                                         (QREFELT $ 11))
                                               (+ |j| 1) (QREFELT $ 13)))))
                                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                 (EXIT NIL))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (EXIT (CONS 0 |arr|))))
           ((EQUAL (QREFELT $ 6) (|SCartesian| 3))
            (SEQ (LETT |arr| (MAKEARR1 4 (MAKE-ARRAY 0)))
                 (SEQ (LETT |i| 0) G190 (COND ((|greater_SI| |i| 3) (GO G191)))
                      (SEQ (QSETAREF1 |arr| |i| (MAKEARR1 4 0.0))
                           (EXIT
                            (SEQ (LETT |j| 0) G190
                                 (COND ((|greater_SI| |j| 3) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (QSETAREF1 (QAREF1 |arr| |i|) |j|
                                              (SPADCALL
                                               (SPADCALL |m| (+ |i| 1)
                                                         (QREFELT $ 11))
                                               (+ |j| 1) (QREFELT $ 13)))))
                                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                 (EXIT NIL))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (EXIT (CONS 0 |arr|))))
           ('T
            (SEQ (|error| "invalid point type in transform constructor")
                 (EXIT (SPADCALL (QREFELT $ 14))))))))) 

(PUT '|STR;stransform;M$;3| '|SPADreplace| '(XLAM (|gen|) (CONS 1 |gen|))) 

(SDEFUN |STR;stransform;M$;3| ((|gen| (|Mapping| PT PT)) ($ ($)))
        (CONS 1 |gen|)) 

(SDEFUN |STR;stransform;M$;4|
        ((|cpx|
          (|Mapping| (|Complex| (|DoubleFloat|)) (|Complex| (|DoubleFloat|))))
         ($ ($)))
        (SPROG ((|pp| (|Mapping| PT PT)))
               (SEQ
                (LETT |pp| (CONS #'|STR;stransform;M$;4!0| (VECTOR |cpx| $)))
                (EXIT (CONS 1 |pp|))))) 

(SDEFUN |STR;stransform;M$;4!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |cpx|)
          (LETT $ (QREFELT $$ 1))
          (LETT |cpx| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 20)) |cpx|)
                      (QREFELT $ 21)))))) 

(SDEFUN |STR;stransform;L$;5| ((|m| (|List| (|DoubleFloat|))) ($ ($)))
        (CONS 2 (SPADCALL |m| (QREFELT $ 25)))) 

(SDEFUN |STR;stranslate;6Df$;6|
        ((|offsetx| (|DoubleFloat|)) (|offsety| (|DoubleFloat|))
         (|offsetz| (|DoubleFloat|)) (|scalex| (|DoubleFloat|))
         (|scaley| (|DoubleFloat|)) (|scalez| (|DoubleFloat|)) ($ ($)))
        (SPROG
         ((#1=#:G768 NIL) (|pp| (|Mapping| PT PT)) (|trConf| (CA))
          (CA
           (|Join| (|Ring|) (|Algebra| #2=(|DoubleFloat|))
                   (CATEGORY |domain| (SIGNATURE |e| ($ (|PositiveInteger|)))
                    (SIGNATURE |ee| ($ (|List| (|PositiveInteger|))))
                    (SIGNATURE |multivector| ($ (|List| #2#)))
                    (SIGNATURE |eFromBinaryMap| ($ (|NonNegativeInteger|)))
                    (SIGNATURE |ePseudoscalar| ($))
                    (SIGNATURE |grade| ((|NonNegativeInteger|) $))
                    (SIGNATURE |monomial| ($ #2# (|List| (|PositiveInteger|))))
                    (SIGNATURE |coefficient|
                     (#2# $ (|List| (|PositiveInteger|))))
                    (SIGNATURE |recip| ((|Union| $ "failed") $))
                    (SIGNATURE |toTable| ((|Matrix| $) (|Mapping| $ $ $)))
                    (SIGNATURE |toTable| ((|Matrix| $) (|Mapping| $ $)))
                    (SIGNATURE |/\\| ($ $ $)) (SIGNATURE |\\/| ($ $ $))
                    (SIGNATURE |lc| ($ $ $)) (SIGNATURE |rc| ($ $ $))
                    (SIGNATURE ~ ($ $)) (SIGNATURE |gradeInvolution| ($ $))
                    (SIGNATURE |reverse| ($ $)) (SIGNATURE |conj| ($ $))
                    (SIGNATURE |setMode|
                     ((|Boolean|) (|String|) (|Boolean|))))))
          (|m| (|Matrix| (|DoubleFloat|))))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((EQUAL (QREFELT $ 6) (|SCartesian| 2))
              (PROGN
               (LETT #1#
                     (SPADCALL
                      (LIST (LIST |scalex| 0.0 |offsetx|)
                            (LIST 0.0 |scaley| |offsety|) (LIST 0.0 0.0 1.0))
                      (QREFELT $ 15)))
               (GO #3=#:G767))))
            (COND
             ((EQUAL (QREFELT $ 6) (|SCartesian| 3))
              (PROGN
               (LETT #1#
                     (SPADCALL
                      (LIST (LIST |scalex| 0.0 0.0 |offsetx|)
                            (LIST 0.0 |scaley| 0.0 |offsety|)
                            (LIST 0.0 0.0 |scalez| |offsetz|)
                            (LIST 0.0 0.0 0.0 1.0))
                      (QREFELT $ 15)))
               (GO #3#))))
            (COND
             ((EQUAL (QREFELT $ 6) (|SConformal| 2))
              (SEQ
               (LETT |m|
                     (SPADCALL
                      (LIST (LIST 0.0 1.0 0.0 0.0) (LIST 1.0 0.0 0.0 0.0)
                            (LIST 0.0 0.0 1.0 0.0) (LIST 0.0 0.0 0.0 1.0))
                      (QREFELT $ 30)))
               (LETT CA
                     (|CliffordAlgebra| 4 (|DoubleFloat|)
                                        (SPADCALL |m| (QREFELT $ 32))))
               (LETT |trConf|
                     (SPADCALL
                      (LIST 1.0 0.0 0.0 0.0 0.0 0.0
                            (|mul_DF| |offsetx| (|mk_DF| 5 -1)) 0.0 0.0 0.0
                            (|mul_DF| |offsety| (|mk_DF| 5 -1)) 0.0 0.0 0.0 0.0
                            0.0)
                      (|compiledLookupCheck| '|multivector|
                                             (LIST '$
                                                   (LIST '|List|
                                                         (LIST
                                                          '|DoubleFloat|)))
                                             CA)))
               (EXIT (PROGN (LETT #1# (CONS 2 |trConf|)) (GO #3#))))))
            (COND
             ((EQUAL (QREFELT $ 6) (|SArgand|))
              (SEQ
               (LETT |pp|
                     (CONS #'|STR;stranslate;6Df$;6!0|
                           (VECTOR |offsety| |offsetx| $)))
               (EXIT (PROGN (LETT #1# (CONS 1 |pp|)) (GO #3#))))))
            (EXIT (SPADCALL (QREFELT $ 14)))))
          #3# (EXIT #1#)))) 

(SDEFUN |STR;stranslate;6Df$;6!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |offsetx| |offsety|)
          (LETT $ (QREFELT $$ 2))
          (LETT |offsetx| (QREFELT $$ 1))
          (LETT |offsety| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |x| (QREFELT $ 20))
                       (SPADCALL |offsetx| |offsety| (QREFELT $ 33))
                       (QREFELT $ 34))
             (QREFELT $ 21)))))) 

(PUT '|STR;identity;$;7| '|SPADreplace| '(XLAM NIL (CONS 3 "iden"))) 

(SDEFUN |STR;identity;$;7| (($ ($))) (CONS 3 "iden")) 

(SDEFUN |STR;applyTransPt2|
        ((|tr| ($)) (|inpt| (|SCartesian| 2)) ($ (|SCartesian| 2)))
        (SPROG
         ((|b| #1=(|DoubleFloat|)) (#2=#:G693 NIL) (|a| #1#)
          (|vin| (|List| (|DoubleFloat|))) (#3=#:G777 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND ((QEQCAR |tr| 3) (PROGN (LETT #3# |inpt|) (GO #4=#:G776))))
            (COND
             ((QEQCAR |tr| 1)
              (SEQ
               (SPADCALL
                (SPADCALL
                 "can't transform Euclidean point using general function"
                 (QREFELT $ 38))
                (QREFELT $ 40))
               (EXIT (PROGN (LETT #3# |inpt|) (GO #4#))))))
            (LETT |vin| (SPADCALL |inpt| (QREFELT $ 42)))
            (LETT |a|
                  (|add_DF|
                   (|add_DF|
                    (|mul_DF|
                     (QAREF1
                      (QAREF1
                       (PROG2 (LETT #2# |tr|)
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0)
                                         (|PrimitiveArray|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                         (|Union|
                                          (|:| |mtx|
                                               (|PrimitiveArray|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|))))
                                          (|:| |general|
                                               (|Mapping| (QREFELT $ 6)
                                                          (QREFELT $ 6)))
                                          (|:| |multiv|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|)))
                                          (|:| |iden| #5="iden"))
                                         #2#))
                       0)
                      0)
                     (SPADCALL |vin| 1 (QREFELT $ 13)))
                    (|mul_DF|
                     (QAREF1
                      (QAREF1
                       (PROG2 (LETT #2# |tr|)
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0)
                                         (|PrimitiveArray|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                         (|Union|
                                          (|:| |mtx|
                                               (|PrimitiveArray|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|))))
                                          (|:| |general|
                                               (|Mapping| (QREFELT $ 6)
                                                          (QREFELT $ 6)))
                                          (|:| |multiv|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|)))
                                          (|:| |iden| #5#))
                                         #2#))
                       0)
                      1)
                     (SPADCALL |vin| 2 (QREFELT $ 13))))
                   (|mul_DF|
                    (QAREF1
                     (QAREF1
                      (PROG2 (LETT #2# |tr|)
                          (QCDR #2#)
                        (|check_union2| (QEQCAR #2# 0)
                                        (|PrimitiveArray|
                                         (|PrimitiveArray| (|DoubleFloat|)))
                                        (|Union|
                                         (|:| |mtx|
                                              (|PrimitiveArray|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|))))
                                         (|:| |general|
                                              (|Mapping| (QREFELT $ 6)
                                                         (QREFELT $ 6)))
                                         (|:| |multiv|
                                              (|PrimitiveArray|
                                               (|DoubleFloat|)))
                                         (|:| |iden| #5#))
                                        #2#))
                      0)
                     2)
                    (SPADCALL |vin| 3 (QREFELT $ 13)))))
            (LETT |b|
                  (|add_DF|
                   (|add_DF|
                    (|mul_DF|
                     (QAREF1
                      (QAREF1
                       (PROG2 (LETT #2# |tr|)
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0)
                                         (|PrimitiveArray|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                         (|Union|
                                          (|:| |mtx|
                                               (|PrimitiveArray|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|))))
                                          (|:| |general|
                                               (|Mapping| (QREFELT $ 6)
                                                          (QREFELT $ 6)))
                                          (|:| |multiv|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|)))
                                          (|:| |iden| #5#))
                                         #2#))
                       1)
                      0)
                     (SPADCALL |vin| 1 (QREFELT $ 13)))
                    (|mul_DF|
                     (QAREF1
                      (QAREF1
                       (PROG2 (LETT #2# |tr|)
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0)
                                         (|PrimitiveArray|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                         (|Union|
                                          (|:| |mtx|
                                               (|PrimitiveArray|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|))))
                                          (|:| |general|
                                               (|Mapping| (QREFELT $ 6)
                                                          (QREFELT $ 6)))
                                          (|:| |multiv|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|)))
                                          (|:| |iden| #5#))
                                         #2#))
                       1)
                      1)
                     (SPADCALL |vin| 2 (QREFELT $ 13))))
                   (|mul_DF|
                    (QAREF1
                     (QAREF1
                      (PROG2 (LETT #2# |tr|)
                          (QCDR #2#)
                        (|check_union2| (QEQCAR #2# 0)
                                        (|PrimitiveArray|
                                         (|PrimitiveArray| (|DoubleFloat|)))
                                        (|Union|
                                         (|:| |mtx|
                                              (|PrimitiveArray|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|))))
                                         (|:| |general|
                                              (|Mapping| (QREFELT $ 6)
                                                         (QREFELT $ 6)))
                                         (|:| |multiv|
                                              (|PrimitiveArray|
                                               (|DoubleFloat|)))
                                         (|:| |iden| #5#))
                                        #2#))
                      1)
                     2)
                    (SPADCALL |vin| 3 (QREFELT $ 13)))))
            (EXIT (SPADCALL |a| |b| (QREFELT $ 43)))))
          #4# (EXIT #3#)))) 

(SDEFUN |STR;applyTransPt3|
        ((|tr| ($)) (|inpt| (|SCartesian| 3)) ($ (|SCartesian| 3)))
        (SPROG
         ((|c| #1=(|DoubleFloat|)) (#2=#:G693 NIL) (|b| #1#) (|a| #1#)
          (|vin| (|List| (|DoubleFloat|))) (#3=#:G785 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND ((QEQCAR |tr| 3) (PROGN (LETT #3# |inpt|) (GO #4=#:G784))))
            (COND
             ((QEQCAR |tr| 1)
              (SEQ
               (SPADCALL
                (SPADCALL
                 "can't transform Euclidean point using general function"
                 (QREFELT $ 38))
                (QREFELT $ 40))
               (EXIT (PROGN (LETT #3# |inpt|) (GO #4#))))))
            (LETT |vin| (SPADCALL |inpt| (QREFELT $ 45)))
            (LETT |a|
                  (|add_DF|
                   (|add_DF|
                    (|add_DF|
                     (|mul_DF|
                      (QAREF1
                       (QAREF1
                        (PROG2 (LETT #2# |tr|)
                            (QCDR #2#)
                          (|check_union2| (QEQCAR #2# 0)
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|)))
                                          (|Union|
                                           (|:| |mtx|
                                                (|PrimitiveArray|
                                                 (|PrimitiveArray|
                                                  (|DoubleFloat|))))
                                           (|:| |general|
                                                (|Mapping| (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                           (|:| |multiv|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|)))
                                           (|:| |iden| #5="iden"))
                                          #2#))
                        0)
                       0)
                      (SPADCALL |vin| 1 (QREFELT $ 13)))
                     (|mul_DF|
                      (QAREF1
                       (QAREF1
                        (PROG2 (LETT #2# |tr|)
                            (QCDR #2#)
                          (|check_union2| (QEQCAR #2# 0)
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|)))
                                          (|Union|
                                           (|:| |mtx|
                                                (|PrimitiveArray|
                                                 (|PrimitiveArray|
                                                  (|DoubleFloat|))))
                                           (|:| |general|
                                                (|Mapping| (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                           (|:| |multiv|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|)))
                                           (|:| |iden| #5#))
                                          #2#))
                        0)
                       1)
                      (SPADCALL |vin| 2 (QREFELT $ 13))))
                    (|mul_DF|
                     (QAREF1
                      (QAREF1
                       (PROG2 (LETT #2# |tr|)
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0)
                                         (|PrimitiveArray|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                         (|Union|
                                          (|:| |mtx|
                                               (|PrimitiveArray|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|))))
                                          (|:| |general|
                                               (|Mapping| (QREFELT $ 6)
                                                          (QREFELT $ 6)))
                                          (|:| |multiv|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|)))
                                          (|:| |iden| #5#))
                                         #2#))
                       0)
                      2)
                     (SPADCALL |vin| 3 (QREFELT $ 13))))
                   (|mul_DF|
                    (QAREF1
                     (QAREF1
                      (PROG2 (LETT #2# |tr|)
                          (QCDR #2#)
                        (|check_union2| (QEQCAR #2# 0)
                                        (|PrimitiveArray|
                                         (|PrimitiveArray| (|DoubleFloat|)))
                                        (|Union|
                                         (|:| |mtx|
                                              (|PrimitiveArray|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|))))
                                         (|:| |general|
                                              (|Mapping| (QREFELT $ 6)
                                                         (QREFELT $ 6)))
                                         (|:| |multiv|
                                              (|PrimitiveArray|
                                               (|DoubleFloat|)))
                                         (|:| |iden| #5#))
                                        #2#))
                      0)
                     3)
                    (SPADCALL |vin| 4 (QREFELT $ 13)))))
            (LETT |b|
                  (|add_DF|
                   (|add_DF|
                    (|add_DF|
                     (|mul_DF|
                      (QAREF1
                       (QAREF1
                        (PROG2 (LETT #2# |tr|)
                            (QCDR #2#)
                          (|check_union2| (QEQCAR #2# 0)
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|)))
                                          (|Union|
                                           (|:| |mtx|
                                                (|PrimitiveArray|
                                                 (|PrimitiveArray|
                                                  (|DoubleFloat|))))
                                           (|:| |general|
                                                (|Mapping| (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                           (|:| |multiv|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|)))
                                           (|:| |iden| #5#))
                                          #2#))
                        1)
                       0)
                      (SPADCALL |vin| 1 (QREFELT $ 13)))
                     (|mul_DF|
                      (QAREF1
                       (QAREF1
                        (PROG2 (LETT #2# |tr|)
                            (QCDR #2#)
                          (|check_union2| (QEQCAR #2# 0)
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|)))
                                          (|Union|
                                           (|:| |mtx|
                                                (|PrimitiveArray|
                                                 (|PrimitiveArray|
                                                  (|DoubleFloat|))))
                                           (|:| |general|
                                                (|Mapping| (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                           (|:| |multiv|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|)))
                                           (|:| |iden| #5#))
                                          #2#))
                        1)
                       1)
                      (SPADCALL |vin| 2 (QREFELT $ 13))))
                    (|mul_DF|
                     (QAREF1
                      (QAREF1
                       (PROG2 (LETT #2# |tr|)
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0)
                                         (|PrimitiveArray|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                         (|Union|
                                          (|:| |mtx|
                                               (|PrimitiveArray|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|))))
                                          (|:| |general|
                                               (|Mapping| (QREFELT $ 6)
                                                          (QREFELT $ 6)))
                                          (|:| |multiv|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|)))
                                          (|:| |iden| #5#))
                                         #2#))
                       1)
                      2)
                     (SPADCALL |vin| 3 (QREFELT $ 13))))
                   (|mul_DF|
                    (QAREF1
                     (QAREF1
                      (PROG2 (LETT #2# |tr|)
                          (QCDR #2#)
                        (|check_union2| (QEQCAR #2# 0)
                                        (|PrimitiveArray|
                                         (|PrimitiveArray| (|DoubleFloat|)))
                                        (|Union|
                                         (|:| |mtx|
                                              (|PrimitiveArray|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|))))
                                         (|:| |general|
                                              (|Mapping| (QREFELT $ 6)
                                                         (QREFELT $ 6)))
                                         (|:| |multiv|
                                              (|PrimitiveArray|
                                               (|DoubleFloat|)))
                                         (|:| |iden| #5#))
                                        #2#))
                      1)
                     3)
                    (SPADCALL |vin| 4 (QREFELT $ 13)))))
            (LETT |c|
                  (|add_DF|
                   (|add_DF|
                    (|add_DF|
                     (|mul_DF|
                      (QAREF1
                       (QAREF1
                        (PROG2 (LETT #2# |tr|)
                            (QCDR #2#)
                          (|check_union2| (QEQCAR #2# 0)
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|)))
                                          (|Union|
                                           (|:| |mtx|
                                                (|PrimitiveArray|
                                                 (|PrimitiveArray|
                                                  (|DoubleFloat|))))
                                           (|:| |general|
                                                (|Mapping| (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                           (|:| |multiv|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|)))
                                           (|:| |iden| #5#))
                                          #2#))
                        2)
                       0)
                      (SPADCALL |vin| 1 (QREFELT $ 13)))
                     (|mul_DF|
                      (QAREF1
                       (QAREF1
                        (PROG2 (LETT #2# |tr|)
                            (QCDR #2#)
                          (|check_union2| (QEQCAR #2# 0)
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|)))
                                          (|Union|
                                           (|:| |mtx|
                                                (|PrimitiveArray|
                                                 (|PrimitiveArray|
                                                  (|DoubleFloat|))))
                                           (|:| |general|
                                                (|Mapping| (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                           (|:| |multiv|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|)))
                                           (|:| |iden| #5#))
                                          #2#))
                        2)
                       1)
                      (SPADCALL |vin| 2 (QREFELT $ 13))))
                    (|mul_DF|
                     (QAREF1
                      (QAREF1
                       (PROG2 (LETT #2# |tr|)
                           (QCDR #2#)
                         (|check_union2| (QEQCAR #2# 0)
                                         (|PrimitiveArray|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                         (|Union|
                                          (|:| |mtx|
                                               (|PrimitiveArray|
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|))))
                                          (|:| |general|
                                               (|Mapping| (QREFELT $ 6)
                                                          (QREFELT $ 6)))
                                          (|:| |multiv|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|)))
                                          (|:| |iden| #5#))
                                         #2#))
                       2)
                      2)
                     (SPADCALL |vin| 3 (QREFELT $ 13))))
                   (|mul_DF|
                    (QAREF1
                     (QAREF1
                      (PROG2 (LETT #2# |tr|)
                          (QCDR #2#)
                        (|check_union2| (QEQCAR #2# 0)
                                        (|PrimitiveArray|
                                         (|PrimitiveArray| (|DoubleFloat|)))
                                        (|Union|
                                         (|:| |mtx|
                                              (|PrimitiveArray|
                                               (|PrimitiveArray|
                                                (|DoubleFloat|))))
                                         (|:| |general|
                                              (|Mapping| (QREFELT $ 6)
                                                         (QREFELT $ 6)))
                                         (|:| |multiv|
                                              (|PrimitiveArray|
                                               (|DoubleFloat|)))
                                         (|:| |iden| #5#))
                                        #2#))
                      2)
                     3)
                    (SPADCALL |vin| 4 (QREFELT $ 13)))))
            (EXIT (SPADCALL |a| |b| |c| (QREFELT $ 46)))))
          #4# (EXIT #3#)))) 

(SDEFUN |STR;applyTransCx| ((|tr| ($)) (|inpt| (|SArgand|)) ($ (|SArgand|)))
        (SPROG
         ((|res| (PT)) (|f| (|Mapping| PT PT)) (#1=#:G694 NIL) (#2=#:G789 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND ((QEQCAR |tr| 3) (PROGN (LETT #2# |inpt|) (GO #3=#:G788))))
            (COND
             ((QEQCAR |tr| 0)
              (SEQ
               (SPADCALL
                (SPADCALL "can't transform complex using matrix"
                          (QREFELT $ 38))
                (QREFELT $ 40))
               (SPADCALL (SPADCALL |tr| (QREFELT $ 47)) (QREFELT $ 40))
               (EXIT (PROGN (LETT #2# |inpt|) (GO #3#))))))
            (LETT |f|
                  (PROG2 (LETT #1# |tr|)
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 1)
                                    (|Mapping| (QREFELT $ 6) (QREFELT $ 6))
                                    (|Union|
                                     (|:| |mtx|
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|))))
                                     (|:| |general|
                                          (|Mapping| (QREFELT $ 6)
                                                     (QREFELT $ 6)))
                                     (|:| |multiv|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                     (|:| |iden| "iden"))
                                    #1#)))
            (LETT |res| (SPADCALL |inpt| |f|)) (EXIT |res|)))
          #3# (EXIT #2#)))) 

(SDEFUN |STR;applyTransConf2|
        ((|tr| ($)) (|inpt| (|SConformal| 2)) ($ (|SConformal| 2)))
        (SPROG
         ((|res| (|SConformal| 2)) (|conjugation| (CA)) (|trConf| (CA))
          (#1=#:G695 NIL) (|ptConf| (CA))
          (CA
           (|Join| (|Ring|) (|Algebra| #2=(|DoubleFloat|))
                   (CATEGORY |domain| (SIGNATURE |e| ($ (|PositiveInteger|)))
                    (SIGNATURE |ee| ($ (|List| (|PositiveInteger|))))
                    (SIGNATURE |multivector| ($ (|List| #2#)))
                    (SIGNATURE |eFromBinaryMap| ($ (|NonNegativeInteger|)))
                    (SIGNATURE |ePseudoscalar| ($))
                    (SIGNATURE |grade| ((|NonNegativeInteger|) $))
                    (SIGNATURE |monomial| ($ #2# (|List| (|PositiveInteger|))))
                    (SIGNATURE |coefficient|
                     (#2# $ (|List| (|PositiveInteger|))))
                    (SIGNATURE |recip| ((|Union| $ "failed") $))
                    (SIGNATURE |toTable| ((|Matrix| $) (|Mapping| $ $ $)))
                    (SIGNATURE |toTable| ((|Matrix| $) (|Mapping| $ $)))
                    (SIGNATURE |/\\| ($ $ $)) (SIGNATURE |\\/| ($ $ $))
                    (SIGNATURE |lc| ($ $ $)) (SIGNATURE |rc| ($ $ $))
                    (SIGNATURE ~ ($ $)) (SIGNATURE |gradeInvolution| ($ $))
                    (SIGNATURE |reverse| ($ $)) (SIGNATURE |conj| ($ $))
                    (SIGNATURE |setMode|
                     ((|Boolean|) (|String|) (|Boolean|))))))
          (|m| (|Matrix| (|DoubleFloat|))) (#3=#:G794 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND ((QEQCAR |tr| 3) (PROGN (LETT #3# |inpt|) (GO #4=#:G793))))
            (COND
             ((NULL (QEQCAR |tr| 2))
              (SEQ
               (SPADCALL
                (SPADCALL "this transform not compatible with conformal"
                          (QREFELT $ 38))
                (QREFELT $ 40))
               (SPADCALL (SPADCALL |tr| (QREFELT $ 47)) (QREFELT $ 40))
               (EXIT (PROGN (LETT #3# |inpt|) (GO #4#))))))
            (LETT |m|
                  (SPADCALL
                   (LIST (LIST 0.0 1.0 0.0 0.0) (LIST 1.0 0.0 0.0 0.0)
                         (LIST 0.0 0.0 1.0 0.0) (LIST 0.0 0.0 0.0 1.0))
                   (QREFELT $ 30)))
            (LETT CA
                  (|CliffordAlgebra| 4 (|DoubleFloat|)
                                     (SPADCALL |m| (QREFELT $ 32))))
            (LETT |ptConf| |inpt|)
            (LETT |trConf|
                  (PROG2 (LETT #1# |tr|)
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 2)
                                    (|PrimitiveArray| (|DoubleFloat|))
                                    (|Union|
                                     (|:| |mtx|
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|))))
                                     (|:| |general|
                                          (|Mapping| (QREFELT $ 6)
                                                     (QREFELT $ 6)))
                                     (|:| |multiv|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                     (|:| |iden| "iden"))
                                    #1#)))
            (LETT |conjugation|
                  (SPADCALL
                   (SPADCALL |trConf| |ptConf|
                             (|compiledLookupCheck| '* (LIST '$ '$ '$) CA))
                   (SPADCALL |trConf|
                             (|compiledLookupCheck| '|reverse| (LIST '$ '$)
                                                    CA))
                   (|compiledLookupCheck| '* (LIST '$ '$ '$) CA)))
            (LETT |res| |conjugation|) (EXIT (SPADCALL |res| (QREFELT $ 49)))))
          #4# (EXIT #3#)))) 

(SDEFUN |STR;xform;$2PT;12| ((|tr| ($)) (|inpt| (PT)) ($ (PT)))
        (SEQ
         (COND
          ((EQUAL (QREFELT $ 6) (|SCartesian| 2))
           (|STR;applyTransPt2| |tr| |inpt| $))
          ((EQUAL (QREFELT $ 6) (|SCartesian| 3))
           (|STR;applyTransPt3| |tr| |inpt| $))
          ((EQUAL (QREFELT $ 6) (|SArgand|))
           (|STR;applyTransCx| |tr| |inpt| $))
          ((EQUAL (QREFELT $ 6) (|SConformal| 2))
           (|STR;applyTransConf2| |tr| |inpt| $))
          ('T
           (SEQ (|error| "invalid point type in transform")
                (EXIT (SPADCALL 0.0 0.0 (QREFELT $ 43)))))))) 

(SDEFUN |STR;compound2| ((|tr| ($)) (|inpt| ($)) ($ ($)))
        (SPROG
         ((#1=#:G808 NIL) (#2=#:G693 NIL) (|j| NIL) (|i| NIL)
          (|arr| (|PrimitiveArray| (|PrimitiveArray| (|DoubleFloat|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |arr| (MAKEARR1 3 (MAKE-ARRAY 0)))
                (SEQ (LETT |i| 0) G190 (COND ((|greater_SI| |i| 2) (GO G191)))
                     (SEQ (QSETAREF1 |arr| |i| (MAKEARR1 3 0.0))
                          (EXIT
                           (SEQ (LETT |j| 0) G190
                                (COND ((|greater_SI| |j| 2) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (QSETAREF1 (QAREF1 |arr| |i|) |j|
                                             (|add_DF|
                                              (|add_DF|
                                               (|mul_DF|
                                                (QAREF1
                                                 (QAREF1
                                                  (PROG2 (LETT #2# |tr|)
                                                      (QCDR #2#)
                                                    (|check_union2|
                                                     (QEQCAR #2# 0)
                                                     (|PrimitiveArray|
                                                      (|PrimitiveArray|
                                                       (|DoubleFloat|)))
                                                     (|Union|
                                                      (|:| |mtx|
                                                           (|PrimitiveArray|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|))))
                                                      (|:| |general|
                                                           (|Mapping|
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 6)))
                                                      (|:| |multiv|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|)))
                                                      (|:| |iden| #3="iden"))
                                                     #2#))
                                                  0)
                                                 |j|)
                                                (QAREF1
                                                 (QAREF1
                                                  (PROG2 (LETT #2# |inpt|)
                                                      (QCDR #2#)
                                                    (|check_union2|
                                                     (QEQCAR #2# 0)
                                                     (|PrimitiveArray|
                                                      (|PrimitiveArray|
                                                       (|DoubleFloat|)))
                                                     (|Union|
                                                      (|:| |mtx|
                                                           (|PrimitiveArray|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|))))
                                                      (|:| |general|
                                                           (|Mapping|
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 6)))
                                                      (|:| |multiv|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|)))
                                                      (|:| |iden| #3#))
                                                     #2#))
                                                  |i|)
                                                 0))
                                               (|mul_DF|
                                                (QAREF1
                                                 (QAREF1
                                                  (PROG2 (LETT #2# |tr|)
                                                      (QCDR #2#)
                                                    (|check_union2|
                                                     (QEQCAR #2# 0)
                                                     (|PrimitiveArray|
                                                      (|PrimitiveArray|
                                                       (|DoubleFloat|)))
                                                     (|Union|
                                                      (|:| |mtx|
                                                           (|PrimitiveArray|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|))))
                                                      (|:| |general|
                                                           (|Mapping|
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 6)))
                                                      (|:| |multiv|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|)))
                                                      (|:| |iden| #3#))
                                                     #2#))
                                                  1)
                                                 |j|)
                                                (QAREF1
                                                 (QAREF1
                                                  (PROG2 (LETT #2# |inpt|)
                                                      (QCDR #2#)
                                                    (|check_union2|
                                                     (QEQCAR #2# 0)
                                                     (|PrimitiveArray|
                                                      (|PrimitiveArray|
                                                       (|DoubleFloat|)))
                                                     (|Union|
                                                      (|:| |mtx|
                                                           (|PrimitiveArray|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|))))
                                                      (|:| |general|
                                                           (|Mapping|
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 6)))
                                                      (|:| |multiv|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|)))
                                                      (|:| |iden| #3#))
                                                     #2#))
                                                  |i|)
                                                 1)))
                                              (|mul_DF|
                                               (QAREF1
                                                (QAREF1
                                                 (PROG2 (LETT #2# |tr|)
                                                     (QCDR #2#)
                                                   (|check_union2|
                                                    (QEQCAR #2# 0)
                                                    (|PrimitiveArray|
                                                     (|PrimitiveArray|
                                                      (|DoubleFloat|)))
                                                    (|Union|
                                                     (|:| |mtx|
                                                          (|PrimitiveArray|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|))))
                                                     (|:| |general|
                                                          (|Mapping|
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                                     (|:| |multiv|
                                                          (|PrimitiveArray|
                                                           (|DoubleFloat|)))
                                                     (|:| |iden| #3#))
                                                    #2#))
                                                 2)
                                                |j|)
                                               (QAREF1
                                                (QAREF1
                                                 (PROG2 (LETT #2# |inpt|)
                                                     (QCDR #2#)
                                                   (|check_union2|
                                                    (QEQCAR #2# 0)
                                                    (|PrimitiveArray|
                                                     (|PrimitiveArray|
                                                      (|DoubleFloat|)))
                                                    (|Union|
                                                     (|:| |mtx|
                                                          (|PrimitiveArray|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|))))
                                                     (|:| |general|
                                                          (|Mapping|
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                                     (|:| |multiv|
                                                          (|PrimitiveArray|
                                                           (|DoubleFloat|)))
                                                     (|:| |iden| #3#))
                                                    #2#))
                                                 |i|)
                                                2))))))
                                (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT (PROGN (LETT #1# (CONS 0 |arr|)) (GO #4=#:G807)))))
          #4# (EXIT #1#)))) 

(SDEFUN |STR;compound3| ((|tr| ($)) (|inpt| ($)) ($ ($)))
        (SPROG
         ((#1=#:G820 NIL) (#2=#:G693 NIL) (|j| NIL) (|i| NIL)
          (|arr| (|PrimitiveArray| (|PrimitiveArray| (|DoubleFloat|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |arr| (MAKEARR1 4 (MAKE-ARRAY 0)))
                (SEQ (LETT |i| 0) G190 (COND ((|greater_SI| |i| 3) (GO G191)))
                     (SEQ (QSETAREF1 |arr| |i| (MAKEARR1 4 0.0))
                          (EXIT
                           (SEQ (LETT |j| 0) G190
                                (COND ((|greater_SI| |j| 3) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (QSETAREF1 (QAREF1 |arr| |i|) |j|
                                             (|add_DF|
                                              (|add_DF|
                                               (|add_DF|
                                                (|mul_DF|
                                                 (QAREF1
                                                  (QAREF1
                                                   (PROG2 (LETT #2# |tr|)
                                                       (QCDR #2#)
                                                     (|check_union2|
                                                      (QEQCAR #2# 0)
                                                      (|PrimitiveArray|
                                                       (|PrimitiveArray|
                                                        (|DoubleFloat|)))
                                                      (|Union|
                                                       (|:| |mtx|
                                                            (|PrimitiveArray|
                                                             (|PrimitiveArray|
                                                              (|DoubleFloat|))))
                                                       (|:| |general|
                                                            (|Mapping|
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 6)))
                                                       (|:| |multiv|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|)))
                                                       (|:| |iden| #3="iden"))
                                                      #2#))
                                                   0)
                                                  |j|)
                                                 (QAREF1
                                                  (QAREF1
                                                   (PROG2 (LETT #2# |inpt|)
                                                       (QCDR #2#)
                                                     (|check_union2|
                                                      (QEQCAR #2# 0)
                                                      (|PrimitiveArray|
                                                       (|PrimitiveArray|
                                                        (|DoubleFloat|)))
                                                      (|Union|
                                                       (|:| |mtx|
                                                            (|PrimitiveArray|
                                                             (|PrimitiveArray|
                                                              (|DoubleFloat|))))
                                                       (|:| |general|
                                                            (|Mapping|
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 6)))
                                                       (|:| |multiv|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|)))
                                                       (|:| |iden| #3#))
                                                      #2#))
                                                   |i|)
                                                  0))
                                                (|mul_DF|
                                                 (QAREF1
                                                  (QAREF1
                                                   (PROG2 (LETT #2# |tr|)
                                                       (QCDR #2#)
                                                     (|check_union2|
                                                      (QEQCAR #2# 0)
                                                      (|PrimitiveArray|
                                                       (|PrimitiveArray|
                                                        (|DoubleFloat|)))
                                                      (|Union|
                                                       (|:| |mtx|
                                                            (|PrimitiveArray|
                                                             (|PrimitiveArray|
                                                              (|DoubleFloat|))))
                                                       (|:| |general|
                                                            (|Mapping|
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 6)))
                                                       (|:| |multiv|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|)))
                                                       (|:| |iden| #3#))
                                                      #2#))
                                                   1)
                                                  |j|)
                                                 (QAREF1
                                                  (QAREF1
                                                   (PROG2 (LETT #2# |inpt|)
                                                       (QCDR #2#)
                                                     (|check_union2|
                                                      (QEQCAR #2# 0)
                                                      (|PrimitiveArray|
                                                       (|PrimitiveArray|
                                                        (|DoubleFloat|)))
                                                      (|Union|
                                                       (|:| |mtx|
                                                            (|PrimitiveArray|
                                                             (|PrimitiveArray|
                                                              (|DoubleFloat|))))
                                                       (|:| |general|
                                                            (|Mapping|
                                                             (QREFELT $ 6)
                                                             (QREFELT $ 6)))
                                                       (|:| |multiv|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|)))
                                                       (|:| |iden| #3#))
                                                      #2#))
                                                   |i|)
                                                  1)))
                                               (|mul_DF|
                                                (QAREF1
                                                 (QAREF1
                                                  (PROG2 (LETT #2# |tr|)
                                                      (QCDR #2#)
                                                    (|check_union2|
                                                     (QEQCAR #2# 0)
                                                     (|PrimitiveArray|
                                                      (|PrimitiveArray|
                                                       (|DoubleFloat|)))
                                                     (|Union|
                                                      (|:| |mtx|
                                                           (|PrimitiveArray|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|))))
                                                      (|:| |general|
                                                           (|Mapping|
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 6)))
                                                      (|:| |multiv|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|)))
                                                      (|:| |iden| #3#))
                                                     #2#))
                                                  2)
                                                 |j|)
                                                (QAREF1
                                                 (QAREF1
                                                  (PROG2 (LETT #2# |inpt|)
                                                      (QCDR #2#)
                                                    (|check_union2|
                                                     (QEQCAR #2# 0)
                                                     (|PrimitiveArray|
                                                      (|PrimitiveArray|
                                                       (|DoubleFloat|)))
                                                     (|Union|
                                                      (|:| |mtx|
                                                           (|PrimitiveArray|
                                                            (|PrimitiveArray|
                                                             (|DoubleFloat|))))
                                                      (|:| |general|
                                                           (|Mapping|
                                                            (QREFELT $ 6)
                                                            (QREFELT $ 6)))
                                                      (|:| |multiv|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|)))
                                                      (|:| |iden| #3#))
                                                     #2#))
                                                  |i|)
                                                 2)))
                                              (|mul_DF|
                                               (QAREF1
                                                (QAREF1
                                                 (PROG2 (LETT #2# |tr|)
                                                     (QCDR #2#)
                                                   (|check_union2|
                                                    (QEQCAR #2# 0)
                                                    (|PrimitiveArray|
                                                     (|PrimitiveArray|
                                                      (|DoubleFloat|)))
                                                    (|Union|
                                                     (|:| |mtx|
                                                          (|PrimitiveArray|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|))))
                                                     (|:| |general|
                                                          (|Mapping|
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                                     (|:| |multiv|
                                                          (|PrimitiveArray|
                                                           (|DoubleFloat|)))
                                                     (|:| |iden| #3#))
                                                    #2#))
                                                 3)
                                                |j|)
                                               (QAREF1
                                                (QAREF1
                                                 (PROG2 (LETT #2# |inpt|)
                                                     (QCDR #2#)
                                                   (|check_union2|
                                                    (QEQCAR #2# 0)
                                                    (|PrimitiveArray|
                                                     (|PrimitiveArray|
                                                      (|DoubleFloat|)))
                                                    (|Union|
                                                     (|:| |mtx|
                                                          (|PrimitiveArray|
                                                           (|PrimitiveArray|
                                                            (|DoubleFloat|))))
                                                     (|:| |general|
                                                          (|Mapping|
                                                           (QREFELT $ 6)
                                                           (QREFELT $ 6)))
                                                     (|:| |multiv|
                                                          (|PrimitiveArray|
                                                           (|DoubleFloat|)))
                                                     (|:| |iden| #3#))
                                                    #2#))
                                                 |i|)
                                                3))))))
                                (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                (EXIT NIL))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT (PROGN (LETT #1# (CONS 0 |arr|)) (GO #4=#:G819)))))
          #4# (EXIT #1#)))) 

(SDEFUN |STR;compoundConf2| ((|tr| ($)) (|inpt| ($)) ($ ($)))
        (SPROG
         ((#1=#:G823 NIL) (|resConf| (CA)) (|inptConf| (CA)) (#2=#:G695 NIL)
          (|trConf| (CA))
          (CA
           (|Join| (|Ring|) (|Algebra| #3=(|DoubleFloat|))
                   (CATEGORY |domain| (SIGNATURE |e| ($ (|PositiveInteger|)))
                    (SIGNATURE |ee| ($ (|List| (|PositiveInteger|))))
                    (SIGNATURE |multivector| ($ (|List| #3#)))
                    (SIGNATURE |eFromBinaryMap| ($ (|NonNegativeInteger|)))
                    (SIGNATURE |ePseudoscalar| ($))
                    (SIGNATURE |grade| ((|NonNegativeInteger|) $))
                    (SIGNATURE |monomial| ($ #3# (|List| (|PositiveInteger|))))
                    (SIGNATURE |coefficient|
                     (#3# $ (|List| (|PositiveInteger|))))
                    (SIGNATURE |recip| ((|Union| $ "failed") $))
                    (SIGNATURE |toTable| ((|Matrix| $) (|Mapping| $ $ $)))
                    (SIGNATURE |toTable| ((|Matrix| $) (|Mapping| $ $)))
                    (SIGNATURE |/\\| ($ $ $)) (SIGNATURE |\\/| ($ $ $))
                    (SIGNATURE |lc| ($ $ $)) (SIGNATURE |rc| ($ $ $))
                    (SIGNATURE ~ ($ $)) (SIGNATURE |gradeInvolution| ($ $))
                    (SIGNATURE |reverse| ($ $)) (SIGNATURE |conj| ($ $))
                    (SIGNATURE |setMode|
                     ((|Boolean|) (|String|) (|Boolean|))))))
          (|m| (|Matrix| (|DoubleFloat|))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |m|
                  (SPADCALL
                   (LIST (LIST 0.0 1.0 0.0 0.0) (LIST 1.0 0.0 0.0 0.0)
                         (LIST 0.0 0.0 1.0 0.0) (LIST 0.0 0.0 0.0 1.0))
                   (QREFELT $ 30)))
            (LETT CA
                  (|CliffordAlgebra| 4 (|DoubleFloat|)
                                     (SPADCALL |m| (QREFELT $ 32))))
            (LETT |trConf|
                  (PROG2 (LETT #2# |tr|)
                      (QCDR #2#)
                    (|check_union2| (QEQCAR #2# 2)
                                    (|PrimitiveArray| (|DoubleFloat|))
                                    (|Union|
                                     (|:| |mtx|
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|))))
                                     (|:| |general|
                                          (|Mapping| (QREFELT $ 6)
                                                     (QREFELT $ 6)))
                                     (|:| |multiv|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                     (|:| |iden| #4="iden"))
                                    #2#)))
            (LETT |inptConf|
                  (PROG2 (LETT #2# |inpt|)
                      (QCDR #2#)
                    (|check_union2| (QEQCAR #2# 2)
                                    (|PrimitiveArray| (|DoubleFloat|))
                                    (|Union|
                                     (|:| |mtx|
                                          (|PrimitiveArray|
                                           (|PrimitiveArray| (|DoubleFloat|))))
                                     (|:| |general|
                                          (|Mapping| (QREFELT $ 6)
                                                     (QREFELT $ 6)))
                                     (|:| |multiv|
                                          (|PrimitiveArray| (|DoubleFloat|)))
                                     (|:| |iden| #4#))
                                    #2#)))
            (LETT |resConf|
                  (SPADCALL |trConf| |inptConf|
                            (|compiledLookupCheck| '* (LIST '$ '$ '$) CA)))
            (EXIT (PROGN (LETT #1# (CONS 2 |resConf|)) (GO #5=#:G822)))))
          #5# (EXIT #1#)))) 

(SDEFUN |STR;compound;3$;16| ((|tr| ($)) (|inpt| ($)) ($ ($)))
        (SPROG
         ((#1=#:G834 NIL) (|fn| (|Mapping| PT PT)) (|in2| (|Mapping| PT PT))
          (|in1| (|Mapping| PT PT)))
         (SEQ
          (EXIT
           (SEQ
            (COND ((QEQCAR |tr| 3) (PROGN (LETT #1# |inpt|) (GO #2=#:G833))))
            (COND ((QEQCAR |inpt| 3) (PROGN (LETT #1# |tr|) (GO #2#))))
            (COND
             ((QEQCAR |tr| 0)
              (COND
               ((QEQCAR |inpt| 0)
                (SEQ
                 (COND
                  ((EQUAL (QREFELT $ 6) (|SCartesian| 2))
                   (PROGN
                    (LETT #1# (|STR;compound2| |tr| |inpt| $))
                    (GO #2#))))
                 (EXIT
                  (COND
                   ((EQUAL (QREFELT $ 6) (|SCartesian| 3))
                    (PROGN
                     (LETT #1# (|STR;compound3| |tr| |inpt| $))
                     (GO #2#))))))))))
            (COND
             ((QEQCAR |tr| 1)
              (COND
               ((QEQCAR |inpt| 1)
                (SEQ (LETT |in1| (CDR |tr|)) (LETT |in2| (CDR |inpt|))
                     (LETT |fn| (SPADCALL |in1| |in2| (QREFELT $ 52)))
                     (EXIT (PROGN (LETT #1# (CONS 1 |fn|)) (GO #2#))))))))
            (COND
             ((QEQCAR |tr| 2)
              (COND
               ((QEQCAR |inpt| 2)
                (PROGN
                 (LETT #1# (|STR;compoundConf2| |tr| |inpt| $))
                 (GO #2#))))))
            (EXIT (SPADCALL (QREFELT $ 14)))))
          #2# (EXIT #1#)))) 

(SDEFUN |STR;outputArray|
        ((|x| (|PrimitiveArray| (|DoubleFloat|))) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G844 NIL) (|i| NIL) (#2=#:G843 NIL)
          (|m| (|NonNegativeInteger|)))
         (SEQ (LETT |m| (QVSIZE |x|))
              (EXIT
               (SPADCALL
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# (- |m| 1)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL (QAREF1 |x| |i|) (QREFELT $ 54))
                                    #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))
                (QREFELT $ 56)))))) 

(SDEFUN |STR;outputMatrix|
        ((|x| (|PrimitiveArray| (|PrimitiveArray| (|DoubleFloat|))))
         ($ (|OutputForm|)))
        (SPROG
         ((|l| (|List| (|List| (|OutputForm|)))) (#1=#:G858 NIL) (|j| NIL)
          (#2=#:G857 NIL) (#3=#:G856 NIL) (|i| NIL) (#4=#:G855 NIL)
          (|m| (|NonNegativeInteger|)))
         (SEQ (LETT |m| (QVSIZE |x|))
              (LETT |l|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |i| 0) (LETT #3# (- |m| 1)) G190
                          (COND ((|greater_SI| |i| #3#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (PROGN
                                    (LETT #2# NIL)
                                    (SEQ (LETT |j| 0) (LETT #1# (- |m| 1)) G190
                                         (COND
                                          ((|greater_SI| |j| #1#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #2#
                                                 (CONS
                                                  (SPADCALL
                                                   (QAREF1 (QAREF1 |x| |i|)
                                                           |j|)
                                                   (QREFELT $ 54))
                                                  #2#))))
                                         (LETT |j| (|inc_SI| |j|)) (GO G190)
                                         G191 (EXIT (NREVERSE #2#))))
                                   #4#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (EXIT (SPADCALL |l| (QREFELT $ 58)))))) 

(SDEFUN |STR;coerce;$Of;19| ((|tr| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G695 NIL) (#2=#:G861 NIL) (#3=#:G693 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |tr| 3)
                    (PROGN
                     (LETT #2# (SPADCALL "iden" (QREFELT $ 38)))
                     (GO #4=#:G860))))
                  (COND
                   ((QEQCAR |tr| 1)
                    (PROGN
                     (LETT #2#
                           (SPADCALL "function as transform" (QREFELT $ 38)))
                     (GO #4#))))
                  (COND
                   ((QEQCAR |tr| 0)
                    (PROGN
                     (LETT #2#
                           (SPADCALL (SPADCALL "mtx" (QREFELT $ 38))
                                     (|STR;outputMatrix|
                                      (PROG2 (LETT #3# |tr|)
                                          (QCDR #3#)
                                        (|check_union2| (QEQCAR #3# 0)
                                                        (|PrimitiveArray|
                                                         (|PrimitiveArray|
                                                          (|DoubleFloat|)))
                                                        (|Union|
                                                         (|:| |mtx|
                                                              (|PrimitiveArray|
                                                               (|PrimitiveArray|
                                                                (|DoubleFloat|))))
                                                         (|:| |general|
                                                              (|Mapping|
                                                               (QREFELT $ 6)
                                                               (QREFELT $ 6)))
                                                         (|:| |multiv|
                                                              (|PrimitiveArray|
                                                               (|DoubleFloat|)))
                                                         (|:| |iden|
                                                              #5="iden"))
                                                        #3#))
                                      $)
                                     (QREFELT $ 59)))
                     (GO #4#))))
                  (EXIT
                   (SPADCALL (SPADCALL "multiv" (QREFELT $ 38))
                             (|STR;outputArray|
                              (PROG2 (LETT #1# |tr|)
                                  (QCDR #1#)
                                (|check_union2| (QEQCAR #1# 2)
                                                (|PrimitiveArray|
                                                 (|DoubleFloat|))
                                                (|Union|
                                                 (|:| |mtx|
                                                      (|PrimitiveArray|
                                                       (|PrimitiveArray|
                                                        (|DoubleFloat|))))
                                                 (|:| |general|
                                                      (|Mapping| (QREFELT $ 6)
                                                                 (QREFELT $
                                                                          6)))
                                                 (|:| |multiv|
                                                      (|PrimitiveArray|
                                                       (|DoubleFloat|)))
                                                 (|:| |iden| #5#))
                                                #1#))
                              $)
                             (QREFELT $ 59)))))
                #4# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |STransform;|)) 

(DEFUN |STransform| (#1=#:G862)
  (SPROG NIL
         (PROG (#2=#:G863)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|STransform|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|STransform;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|STransform|)))))))))) 

(DEFUN |STransform;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|STransform| DV$1))
          (LETT $ (GETREFV 60))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|STransform| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Union|
                     (|:| |mtx|
                          (|PrimitiveArray|
                           (|PrimitiveArray| (|DoubleFloat|))))
                     (|:| |general| (|Mapping| |#1| |#1|))
                     (|:| |multiv| (|PrimitiveArray| (|DoubleFloat|)))
                     (|:| |iden| "iden")))
          $))) 

(MAKEPROP '|STransform| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|List| 12)
              (|Integer|) (|List| 8) (0 . |elt|) (|DoubleFloat|) (6 . |elt|)
              |STR;identity;$;7| |STR;stransform;L$;2| (|Mapping| 6 6)
              |STR;stransform;M$;3| (|Complex| 12) (|SArgand|) (12 . |coerce|)
              (17 . |coerce|) (|Mapping| 18 18) |STR;stransform;M$;4|
              (|PrimitiveArray| 12) (22 . |construct|) |STR;stransform;L$;5|
              (27 . |Zero|) (31 . |One|) (|Matrix| 12) (35 . |matrix|)
              (|SquareMatrix| '4 12) (40 . |squareMatrix|) (45 . |complex|)
              (51 . +) |STR;stranslate;6Df$;6| (|String|) (|OutputForm|)
              (57 . |message|) (|Void|) (62 . |print|) (|SCartesian| '2)
              (67 . |extendedCoords|) (72 . |spnt|) (|SCartesian| '3)
              (78 . |extendedCoords|) (83 . |spnt|) |STR;coerce;$Of;19|
              (|SConformal| '2) (90 . |normalisePoint|) |STR;xform;$2PT;12|
              (|MappingPackage3| 6 6 6) (95 . *) |STR;compound;3$;16|
              (101 . |coerce|) (|List| $) (106 . |bracket|) (|List| 55)
              (111 . |matrix|) (116 . |hconcat|))
           '#(|xform| 122 |stranslate| 128 |stransform| 138 |identity| 158
              |compound| 162 |coerce| 168)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|stransform|
                                 ($$ (|List| (|List| (|DoubleFloat|)))))
                                T)
                              '((|stransform| ($$ (|Mapping| |#1| |#1|))) T)
                              '((|stransform|
                                 ($$
                                  (|Mapping| (|Complex| (|DoubleFloat|))
                                             (|Complex| (|DoubleFloat|)))))
                                T)
                              '((|stransform| ($$ (|List| (|DoubleFloat|)))) T)
                              '((|stranslate|
                                 ($$ (|DoubleFloat|) (|DoubleFloat|)
                                  (|DoubleFloat|) (|DoubleFloat|)
                                  (|DoubleFloat|) (|DoubleFloat|)))
                                T)
                              '((|identity| ($$)) T)
                              '((|xform| (|#1| $$ |#1|)) T)
                              '((|compound| ($$ $$ $$)) T)
                              '((|coerce| ((|OutputForm|) $$)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 59
                                            '(2 10 8 0 9 11 2 8 12 0 9 13 1 19
                                              18 0 20 1 19 0 18 21 1 24 0 8 25
                                              0 12 0 27 0 12 0 28 1 29 0 10 30
                                              1 31 0 29 32 2 18 0 12 12 33 2 18
                                              0 0 0 34 1 37 0 36 38 1 37 39 0
                                              40 1 41 8 0 42 2 41 0 12 12 43 1
                                              44 8 0 45 3 44 0 12 12 12 46 1 48
                                              0 0 49 2 51 16 16 16 52 1 12 37 0
                                              54 1 37 0 55 56 1 37 0 57 58 2 37
                                              0 0 0 59 2 0 6 0 6 50 6 0 0 12 12
                                              12 12 12 12 35 1 0 0 16 17 1 0 0
                                              10 15 1 0 0 8 26 1 0 0 22 23 0 0
                                              0 14 2 0 0 0 0 53 1 0 37 0
                                              47)))))
           '|lookupComplete|)) 

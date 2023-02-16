
(SDEFUN |AUTOMOR;One;$;1| (($ ($))) (CONS (|function| |AUTOMOR;ident|) $)) 

(PUT '|AUTOMOR;err| '|SPADreplace|
     '(XLAM (|r|) (|error| "Morphism is not invertible"))) 

(SDEFUN |AUTOMOR;err| ((|r| (R)) ($ (R)))
        (|error| "Morphism is not invertible")) 

(PUT '|AUTOMOR;ident| '|SPADreplace| '(XLAM (|r| |n|) |r|)) 

(SDEFUN |AUTOMOR;ident| ((|r| (R)) (|n| (|Integer|)) ($ (R))) |r|) 

(PUT '|AUTOMOR;=;2$B;4| '|SPADreplace| 'EQ) 

(SDEFUN |AUTOMOR;=;2$B;4| ((|f| ($)) (|g| ($)) ($ (|Boolean|))) (EQ |f| |g|)) 

(SDEFUN |AUTOMOR;elt;$2R;5| ((|f| ($)) (|r| (R)) ($ (R)))
        (|AUTOMOR;apply| |f| |r| 1 $)) 

(SDEFUN |AUTOMOR;inv;2$;6| ((|f| ($)) ($ ($)))
        (SPROG NIL (CONS #'|AUTOMOR;inv;2$;6!0| (VECTOR $ |f|)))) 

(SDEFUN |AUTOMOR;inv;2$;6!0| ((|r1| NIL) (|i2| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|AUTOMOR;apply| |f| |r1| (SPADCALL |i2| (QREFELT $ 13)) $))))) 

(SDEFUN |AUTOMOR;^;$I$;7| ((|f| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG NIL (CONS #'|AUTOMOR;^;$I$;7!0| (VECTOR $ |n| |f|)))) 

(SDEFUN |AUTOMOR;^;$I$;7!0| ((|r1| NIL) (|i2| NIL) ($$ NIL))
        (PROG (|f| |n| $)
          (LETT |f| (QREFELT $$ 2))
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|AUTOMOR;apply| |f| |r1| (SPADCALL |n| |i2| (QREFELT $ 15)) $))))) 

(SDEFUN |AUTOMOR;coerce;$Of;8| ((|f| ($)) ($ (|OutputForm|)))
        (SPADCALL "R -> R" (QREFELT $ 19))) 

(PUT '|AUTOMOR;morphism;M$;9| '|SPADreplace| '(XLAM (|f|) |f|)) 

(SDEFUN |AUTOMOR;morphism;M$;9| ((|f| (|Mapping| R R (|Integer|))) ($ ($))) |f|) 

(SDEFUN |AUTOMOR;morphism;M$;10| ((|f| (|Mapping| R R)) ($ ($)))
        (SPADCALL |f| (CONS (|function| |AUTOMOR;err|) $) (QREFELT $ 24))) 

(SDEFUN |AUTOMOR;morphism;2M$;11|
        ((|f| (|Mapping| R R)) (|g| (|Mapping| R R)) ($ ($)))
        (SPROG NIL (CONS #'|AUTOMOR;morphism;2M$;11!0| (VECTOR $ |g| |f|)))) 

(SDEFUN |AUTOMOR;morphism;2M$;11!0| ((|r1| NIL) (|i2| NIL) ($$ NIL))
        (PROG (|f| |g| $)
          (LETT |f| (QREFELT $$ 2))
          (LETT |g| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|AUTOMOR;iterat| |f| |g| |i2| |r1| $))))) 

(SDEFUN |AUTOMOR;apply| ((|f| ($)) (|r| (R)) (|n| (|Integer|)) ($ (R)))
        (SPROG ((|g| (|Mapping| R R (|Integer|))))
               (SEQ (LETT |g| |f|) (EXIT (SPADCALL |r| |n| |g|))))) 

(SDEFUN |AUTOMOR;iterat|
        ((|f| (|Mapping| R R)) (|g| (|Mapping| R R)) (|n| (|Integer|))
         (|r| (R)) ($ (R)))
        (SPROG ((#1=#:G729 NIL) (#2=#:G727 NIL))
               (COND
                ((< |n| 0)
                 (|AUTOMOR;iter| |g|
                  (PROG1 (LETT #2# (- |n|))
                    (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #2#))
                  |r| $))
                ('T
                 (|AUTOMOR;iter| |f|
                  (PROG1 (LETT #1# |n|)
                    (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                      '(|Integer|) #1#))
                  |r| $))))) 

(SDEFUN |AUTOMOR;iter|
        ((|f| (|Mapping| R R)) (|n| (|NonNegativeInteger|)) (|r| (R)) ($ (R)))
        (SPROG ((#1=#:G737 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ (EXIT (LETT |r| (SPADCALL |r| |f|))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |r|)))) 

(SDEFUN |AUTOMOR;*;3$;15| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPROG NIL
               (COND
                ((SPADCALL |f| |g| (QREFELT $ 10))
                 (SPADCALL |f| 2 (QREFELT $ 28)))
                ('T (CONS #'|AUTOMOR;*;3$;15!2| (VECTOR |f| |g| $)))))) 

(SDEFUN |AUTOMOR;*;3$;15!2| ((|r1| NIL) (|i2| NIL) ($$ NIL))
        (PROG ($ |g| |f|)
          (LETT $ (QREFELT $$ 2))
          (LETT |g| (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (|AUTOMOR;iterat|
                    (CONS #'|AUTOMOR;*;3$;15!0| (VECTOR $ |g| |f|))
                    (CONS #'|AUTOMOR;*;3$;15!1| (VECTOR |f| $ |g|)) |i2| |r1|
                    $)))))) 

(SDEFUN |AUTOMOR;*;3$;15!1| ((|v1| NIL) ($$ NIL))
        (PROG (|g| $ |f|)
          (LETT |g| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |g| (QREFELT $ 14))
                      (SPADCALL (SPADCALL |f| (QREFELT $ 14)) |v1|
                                (QREFELT $ 11))
                      (QREFELT $ 11)))))) 

(SDEFUN |AUTOMOR;*;3$;15!0| ((|u1| NIL) ($$ NIL))
        (PROG (|f| |g| $)
          (LETT |f| (QREFELT $$ 2))
          (LETT |g| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |f| (SPADCALL |g| |u1| (QREFELT $ 11)) (QREFELT $ 11)))))) 

(DECLAIM (NOTINLINE |Automorphism;|)) 

(DEFUN |Automorphism| (#1=#:G749)
  (SPROG NIL
         (PROG (#2=#:G750)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Automorphism|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Automorphism;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|Automorphism|)))))))))) 

(DEFUN |Automorphism;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Automorphism| DV$1))
          (LETT $ (GETREFV 34))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Automorphism| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|Mapping| |#1| |#1| (|Integer|)))
          $))) 

(MAKEPROP '|Automorphism| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |AUTOMOR;One;$;1|) $))
              (|Boolean|) |AUTOMOR;=;2$B;4| |AUTOMOR;elt;$2R;5| (|Integer|)
              (0 . -) |AUTOMOR;inv;2$;6| (5 . *) |AUTOMOR;^;$I$;7| (|String|)
              (|OutputForm|) (11 . |message|) |AUTOMOR;coerce;$Of;8|
              (|Mapping| 6 6 12) |AUTOMOR;morphism;M$;9| (|Mapping| 6 6)
              |AUTOMOR;morphism;2M$;11| |AUTOMOR;morphism;M$;10| (16 . |Zero|)
              (|PositiveInteger|) (20 . ^) |AUTOMOR;*;3$;15|
              (|NonNegativeInteger|) (|Union| $ '"failed") (|HashState|)
              (|SingleInteger|))
           '#(~= 26 |sample| 32 |rightRecip| 36 |rightPower| 41 |recip| 53
              |one?| 58 |morphism| 63 |leftRecip| 79 |leftPower| 84 |latex| 96
              |inv| 101 |hashUpdate!| 106 |hash| 112 |elt| 117 |conjugate| 123
              |commutator| 129 |coerce| 135 ^ 140 |One| 158 = 162 / 168 * 174)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|Group&| NIL NIL |MagmaWithUnit&| |Magma&| |SetCategory&|
                     NIL NIL NIL |BasicType&| NIL)
                  (CONS
                   '#((|Group|) (|Monoid|) (|SemiGroup|) (|MagmaWithUnit|)
                      (|Magma|) (|SetCategory|) (|Eltable| 6 6) (|unitsKnown|)
                      (|TwoSidedRecip|) (|BasicType|) (|CoercibleTo| 18))
                   (|makeByteWordVec2| 33
                                       '(1 12 0 0 13 2 12 0 0 0 15 1 18 0 17 19
                                         0 6 0 26 2 0 0 0 27 28 2 0 9 0 0 1 0 0
                                         0 1 1 0 31 0 1 2 0 0 0 30 1 2 0 0 0 27
                                         1 1 0 31 0 1 1 0 9 0 1 1 0 0 21 22 1 0
                                         0 23 25 2 0 0 23 23 24 1 0 31 0 1 2 0
                                         0 0 30 1 2 0 0 0 27 1 1 0 17 0 1 1 0 0
                                         0 14 2 0 32 32 0 1 1 0 33 0 1 2 0 6 0
                                         6 11 2 0 0 0 0 1 2 0 0 0 0 1 1 0 18 0
                                         20 2 0 0 0 12 16 2 0 0 0 30 1 2 0 0 0
                                         27 28 0 0 0 8 2 0 9 0 0 10 2 0 0 0 0 1
                                         2 0 0 0 0 29)))))
           '|lookupComplete|)) 

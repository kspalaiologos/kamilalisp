
(SDEFUN |BOP;is?;$SB;1| ((|op| ($)) (|s| (|Symbol|)) ($ (|Boolean|)))
        (EQUAL (SPADCALL |op| (QREFELT $ 13)) |s|)) 

(PUT '|BOP;name;$S;2| '|SPADreplace| '(XLAM (|op|) (QVELT |op| 0))) 

(SDEFUN |BOP;name;$S;2| ((|op| ($)) ($ (|Symbol|))) (QVELT |op| 0)) 

(PUT '|BOP;properties;$Al;3| '|SPADreplace| '(XLAM (|op|) (QVELT |op| 2))) 

(SDEFUN |BOP;properties;$Al;3|
        ((|op| ($)) ($ (|AssociationList| (|Symbol|) (|None|)))) (QVELT |op| 2)) 

(SDEFUN |BOP;setProperties;$Al$;4|
        ((|op| ($)) (|l| (|AssociationList| (|Symbol|) (|None|))) ($ ($)))
        (SEQ (QSETVELT |op| 2 |l|) (EXIT |op|))) 

(SDEFUN |BOP;operator;S$;5| ((|s| (|Symbol|)) ($ ($)))
        (|BOP;oper| |s| -1 (SPADCALL (QREFELT $ 19)) $)) 

(SDEFUN |BOP;operator;SNni$;6|
        ((|s| (|Symbol|)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (|BOP;oper| |s| (SPADCALL |n| (QREFELT $ 23)) (SPADCALL (QREFELT $ 19))
         $)) 

(SDEFUN |BOP;property;$SU;7|
        ((|op| ($)) (|name| (|Symbol|)) ($ (|Union| (|None|) "failed")))
        (SPADCALL |name| (QVELT |op| 2) (QREFELT $ 27))) 

(SDEFUN |BOP;assert;$S$;8| ((|op| ($)) (|s| (|Symbol|)) ($ ($)))
        (SPADCALL |op| |s| NIL (QREFELT $ 30))) 

(SDEFUN |BOP;has?;$SB;9| ((|op| ($)) (|name| (|Symbol|)) ($ (|Boolean|)))
        (SPADCALL |name| (QVELT |op| 2) (QREFELT $ 32))) 

(PUT '|BOP;oper| '|SPADreplace| 'VECTOR) 

(SDEFUN |BOP;oper|
        ((|se| (|Symbol|)) (|n| (|SingleInteger|))
         (|prop| (|AssociationList| (|Symbol|) (|None|))) ($ ($)))
        (VECTOR |se| |n| |prop|)) 

(SDEFUN |BOP;weight;$Nni$;11| ((|op| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |op| (QREFELT $ 9) |n| (QREFELT $ 30))) 

(SDEFUN |BOP;nullary?;$B;12| ((|op| ($)) ($ (|Boolean|)))
        (|zero?_SI| (QVELT |op| 1))) 

(SDEFUN |BOP;unary?;$B;13| ((|op| ($)) ($ (|Boolean|)))
        (|eql_SI| (QVELT |op| 1) 1)) 

(SDEFUN |BOP;nary?;$B;14| ((|op| ($)) ($ (|Boolean|)))
        (|negative?_SI| (QVELT |op| 1))) 

(SDEFUN |BOP;equality;$M$;15|
        ((|op| ($)) (|func| (|Mapping| (|Boolean|) $ $)) ($ ($)))
        (SPADCALL |op| (QREFELT $ 8) |func| (QREFELT $ 30))) 

(SDEFUN |BOP;comparison;$M$;16|
        ((|op| ($)) (|func| (|Mapping| (|Boolean|) $ $)) ($ ($)))
        (SPADCALL |op| (QREFELT $ 7) |func| (QREFELT $ 30))) 

(SDEFUN |BOP;display;$M$;17|
        ((|op| ($)) (|f| (|Mapping| (|OutputForm|) (|OutputForm|))) ($ ($)))
        (SPROG NIL
               (SPADCALL |op| (CONS #'|BOP;display;$M$;17!0| (VECTOR |f| $))
                         (QREFELT $ 45)))) 

(SDEFUN |BOP;display;$M$;17!0| ((|l1| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |l1| (QREFELT $ 43)) |f|))))) 

(SDEFUN |BOP;deleteProperty!;$S$;18| ((|op| ($)) (|name| (|Symbol|)) ($ ($)))
        (SEQ (SPADCALL |name| (SPADCALL |op| (QREFELT $ 17)) (QREFELT $ 48))
             (EXIT |op|))) 

(SDEFUN |BOP;setProperty;$SN$;19|
        ((|op| ($)) (|name| (|Symbol|)) (|valu| (|None|)) ($ ($)))
        (SEQ (SPADCALL (QVELT |op| 2) |name| |valu| (QREFELT $ 50))
             (EXIT |op|))) 

(SDEFUN |BOP;coerce;$Of;20| ((|op| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |op| (QREFELT $ 13)) (QREFELT $ 51))) 

(SDEFUN |BOP;input;$M$;21|
        ((|op| ($)) (|f| (|Mapping| (|InputForm|) (|List| (|InputForm|))))
         ($ ($)))
        (SPADCALL |op| (QREFELT $ 11) |f| (QREFELT $ 30))) 

(SDEFUN |BOP;display;$M$;22|
        ((|op| ($)) (|f| (|Mapping| (|OutputForm|) (|List| (|OutputForm|))))
         ($ ($)))
        (SPADCALL |op| (QREFELT $ 10) |f| (QREFELT $ 30))) 

(SDEFUN |BOP;display;$U;23|
        ((|op| ($))
         ($
          (|Union| (|Mapping| (|OutputForm|) (|List| (|OutputForm|)))
                   "failed")))
        (SPROG ((|u| (|Union| (|None|) "failed")))
               (SEQ (LETT |u| (SPADCALL |op| (QREFELT $ 10) (QREFELT $ 28)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (CONS 0 (QCDR |u|)))))))) 

(SDEFUN |BOP;input;$U;24|
        ((|op| ($))
         ($
          (|Union| (|Mapping| (|InputForm|) (|List| (|InputForm|))) "failed")))
        (SPROG ((|u| (|Union| (|None|) "failed")))
               (SEQ (LETT |u| (SPADCALL |op| (QREFELT $ 11) (QREFELT $ 28)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (CONS 0 (QCDR |u|)))))))) 

(SDEFUN |BOP;arity;$U;25|
        ((|op| ($)) ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG ((#1=#:G780 NIL) (|n| (|SingleInteger|)))
               (COND
                ((|negative?_SI| (LETT |n| (QVELT |op| 1))) (CONS 1 "failed"))
                ('T
                 (CONS 0
                       (PROG1 (LETT #1# |n|)
                         (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #1#))))))) 

(SDEFUN |BOP;copy;2$;26| ((|op| ($)) ($ ($)))
        (SPROG ((#1=#:G791 NIL) (|r| NIL) (#2=#:G790 NIL))
               (SEQ
                (|BOP;oper| (SPADCALL |op| (QREFELT $ 13)) (QVELT |op| 1)
                 (SPADCALL
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |r| NIL)
                        (LETT #1#
                              (SPADCALL (SPADCALL |op| (QREFELT $ 17))
                                        (QREFELT $ 63)))
                        G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2# (CONS (CONS (QCAR |r|) (QCDR |r|)) #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#))))
                  (QREFELT $ 64))
                 $)))) 

(SDEFUN |BOP;=;2$B;27| ((|op1| ($)) (|op2| ($)) ($ (|Boolean|)))
        (SPROG ((|func| (|Union| (|None|) "failed")))
               (SEQ
                (COND ((EQ |op1| |op2|) 'T)
                      ((OR
                        (SPADCALL (SPADCALL |op1| (QREFELT $ 13))
                                  (SPADCALL |op2| (QREFELT $ 13))
                                  (QREFELT $ 66))
                        (OR
                         (SPADCALL (QVELT |op1| 1) (QVELT |op2| 1)
                                   (QREFELT $ 67))
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (SPADCALL |op1| (QREFELT $ 17))
                                     (QREFELT $ 69))
                           (QREFELT $ 71))
                          (SPADCALL
                           (SPADCALL (SPADCALL |op2| (QREFELT $ 17))
                                     (QREFELT $ 69))
                           (QREFELT $ 71))
                          (QREFELT $ 72))))
                       NIL)
                      ('T
                       (SEQ
                        (LETT |func|
                              (SPADCALL |op1| (QREFELT $ 8) (QREFELT $ 28)))
                        (EXIT
                         (COND
                          ((QEQCAR |func| 0)
                           (SPADCALL |op1| |op2| (QCDR |func|)))
                          ('T 'T))))))))) 

(SDEFUN |BOP;weight;$Nni;28| ((|op| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((|w| (|Union| (|None|) "failed")))
               (SEQ (LETT |w| (SPADCALL |op| (QREFELT $ 9) (QREFELT $ 28)))
                    (EXIT (COND ((QEQCAR |w| 1) 1) ('T (QCDR |w|))))))) 

(SDEFUN |BOP;<;2$B;29| ((|op1| ($)) (|op2| ($)) ($ (|Boolean|)))
        (SPROG
         ((|func| (|Union| (|None|) "failed")) (|n2| #1=(|NonNegativeInteger|))
          (|d2| #2=(|Set| (|Symbol|))) (|n1| #1#) (|d1| #2#)
          (|k2| #3=(|Set| (|Symbol|))) (|k1| #3#)
          (|w2| #4=(|NonNegativeInteger|)) (|w1| #4#))
         (SEQ
          (COND
           ((SPADCALL (LETT |w1| (SPADCALL |op1| (QREFELT $ 74)))
                      (LETT |w2| (SPADCALL |op2| (QREFELT $ 74)))
                      (QREFELT $ 75))
            (< |w1| |w2|))
           ((SPADCALL (QVELT |op1| 1) (QVELT |op2| 1) (QREFELT $ 67))
            (|less_SI| (QVELT |op1| 1) (QVELT |op2| 1)))
           ((SPADCALL (SPADCALL |op1| (QREFELT $ 13))
                      (SPADCALL |op2| (QREFELT $ 13)) (QREFELT $ 66))
            (GGREATERP (SPADCALL |op2| (QREFELT $ 13))
                       (SPADCALL |op1| (QREFELT $ 13))))
           (#5='T
            (SEQ
             (LETT |n1|
                   (SPADCALL
                    (LETT |k1|
                          (SPADCALL
                           (SPADCALL (SPADCALL |op1| (QREFELT $ 17))
                                     (QREFELT $ 69))
                           (QREFELT $ 71)))
                    (QREFELT $ 76)))
             (LETT |n2|
                   (SPADCALL
                    (LETT |k2|
                          (SPADCALL
                           (SPADCALL (SPADCALL |op2| (QREFELT $ 17))
                                     (QREFELT $ 69))
                           (QREFELT $ 71)))
                    (QREFELT $ 76)))
             (EXIT
              (COND ((SPADCALL |n1| |n2| (QREFELT $ 75)) (< |n1| |n2|))
                    ((NULL
                      (ZEROP
                       (LETT |n1|
                             (SPADCALL
                              (LETT |d1| (SPADCALL |k1| |k2| (QREFELT $ 77)))
                              (QREFELT $ 76)))))
                     (COND
                      ((SPADCALL |n1|
                                 (LETT |n2|
                                       (SPADCALL
                                        (LETT |d2|
                                              (SPADCALL |k2| |k1|
                                                        (QREFELT $ 77)))
                                        (QREFELT $ 76)))
                                 (QREFELT $ 75))
                       (< |n1| |n2|))
                      (#5#
                       (GGREATERP (SPADCALL |d2| (QREFELT $ 78))
                                  (SPADCALL |d1| (QREFELT $ 78))))))
                    ('T
                     (SEQ
                      (LETT |func|
                            (SPADCALL |op1| (QREFELT $ 7) (QREFELT $ 28)))
                      (EXIT
                       (COND
                        ((QEQCAR |func| 0)
                         (SPADCALL |op1| |op2| (QCDR |func|)))
                        (#5#
                         (SEQ
                          (LETT |func|
                                (SPADCALL |op1| (QREFELT $ 8) (QREFELT $ 28)))
                          (EXIT
                           (COND
                            ((QEQCAR |func| 0)
                             (NULL (SPADCALL |op1| |op2| (QCDR |func|))))
                            (#5# NIL))))))))))))))))) 

(DECLAIM (NOTINLINE |BasicOperator;|)) 

(DEFUN |BasicOperator| ()
  (SPROG NIL
         (PROG (#1=#:G828)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|BasicOperator|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|BasicOperator|
                             (LIST (CONS NIL (CONS 1 (|BasicOperator;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|BasicOperator|)))))))))) 

(DEFUN |BasicOperator;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|BasicOperator|))
          (LETT $ (GETREFV 82))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|BasicOperator| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |opname| (|Symbol|))
                              (|:| |narg| (|SingleInteger|))
                              (|:| |props|
                                   (|AssociationList| (|Symbol|) (|None|)))))
          (QSETREFV $ 7 '|%less?|)
          (QSETREFV $ 8 '|%equal?|)
          (QSETREFV $ 9 '|%weight|)
          (QSETREFV $ 10 '|%display|)
          (QSETREFV $ 11 '|%input|)
          $))) 

(MAKEPROP '|BasicOperator| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| 'LESS? 'EQUAL? 'WEIGHT 'DISPLAY
              'SEXPR (|Symbol|) |BOP;name;$S;2| (|Boolean|) |BOP;is?;$SB;1|
              (|AssociationList| 12 29) |BOP;properties;$Al;3|
              |BOP;setProperties;$Al$;4| (0 . |table|) |BOP;operator;S$;5|
              (|Integer|) (|SingleInteger|) (4 . |coerce|)
              (|NonNegativeInteger|) |BOP;operator;SNni$;6|
              (|Union| 29 '"failed") (9 . |search|) |BOP;property;$SU;7|
              (|None|) |BOP;setProperty;$SN$;19| |BOP;assert;$S$;8|
              (15 . |key?|) |BOP;has?;$SB;9| |BOP;weight;$Nni$;11|
              |BOP;nullary?;$B;12| |BOP;unary?;$B;13| |BOP;nary?;$B;14|
              (|Mapping| 14 $ $) |BOP;equality;$M$;15| |BOP;comparison;$M$;16|
              (|OutputForm|) (|List| 41) (21 . |first|) (|Mapping| 41 42)
              |BOP;display;$M$;22| (|Mapping| 41 41) |BOP;display;$M$;17|
              (26 . |remove!|) |BOP;deleteProperty!;$S$;18| (32 . |setelt!|)
              (39 . |coerce|) |BOP;coerce;$Of;20|
              (|Mapping| (|InputForm|) (|List| (|InputForm|)))
              |BOP;input;$M$;21| (|Union| 44 '"failed") |BOP;display;$U;23|
              (|Union| 53 '"failed") |BOP;input;$U;24| (|Union| 24 '"failed")
              |BOP;arity;$U;25| (|Record| (|:| |key| 12) (|:| |entry| 29))
              (|List| 61) (44 . |entries|) (49 . |table|) |BOP;copy;2$;26|
              (54 . ~=) (60 . ~=) (|List| 12) (66 . |keys|) (|Set| 12)
              (71 . |set|) (76 . ~=) |BOP;=;2$B;27| |BOP;weight;$Nni;28|
              (82 . ~=) (88 . |#|) (93 . |difference|) (99 . |inspect|)
              |BOP;<;2$B;29| (|String|) (|HashState|))
           '#(~= 104 |weight| 110 |unary?| 121 |smaller?| 126 |setProperty| 132
              |setProperties| 139 |property| 145 |properties| 151 |operator|
              156 |nullary?| 167 |nary?| 172 |name| 177 |min| 182 |max| 188
              |latex| 194 |is?| 199 |input| 205 |hashUpdate!| 216 |hash| 222
              |has?| 227 |equality| 233 |display| 239 |deleteProperty!| 256
              |copy| 262 |comparison| 267 |coerce| 273 |assert| 278 |arity| 284
              >= 289 > 295 = 301 <= 307 < 313)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0))
                 (CONS
                  '#(|OrderedSet&| NIL |SetCategory&| |BasicType&|
                     |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedSet|) (|Comparable|) (|SetCategory|)
                      (|BasicType|) (|PartialOrder|) (|CoercibleTo| 41))
                   (|makeByteWordVec2| 81
                                       '(0 16 0 19 1 22 0 21 23 2 16 26 12 0 27
                                         2 16 14 12 0 32 1 42 41 0 43 2 16 26
                                         12 0 48 3 16 29 0 12 29 50 1 12 41 0
                                         51 1 16 62 0 63 1 16 0 62 64 2 12 14 0
                                         0 66 2 22 14 0 0 67 1 16 68 0 69 1 70
                                         0 68 71 2 70 14 0 0 72 2 24 14 0 0 75
                                         1 70 24 0 76 2 70 0 0 0 77 1 70 12 0
                                         78 2 0 14 0 0 1 1 0 24 0 74 2 0 0 0 24
                                         34 1 0 14 0 36 2 0 14 0 0 1 3 0 0 0 12
                                         29 30 2 0 0 0 16 18 2 0 26 0 12 28 1 0
                                         16 0 17 2 0 0 12 24 25 1 0 0 12 20 1 0
                                         14 0 35 1 0 14 0 37 1 0 12 0 13 2 0 0
                                         0 0 1 2 0 0 0 0 1 1 0 80 0 1 2 0 14 0
                                         12 15 2 0 0 0 53 54 1 0 57 0 58 2 0 81
                                         81 0 1 1 0 22 0 1 2 0 14 0 12 33 2 0 0
                                         0 38 39 2 0 0 0 44 45 2 0 0 0 46 47 1
                                         0 55 0 56 2 0 0 0 12 49 1 0 0 0 65 2 0
                                         0 0 38 40 1 0 41 0 52 2 0 0 0 12 31 1
                                         0 59 0 60 2 0 14 0 0 1 2 0 14 0 0 1 2
                                         0 14 0 0 73 2 0 14 0 0 1 2 0 14 0 0
                                         79)))))
           '|lookupComplete|)) 

(MAKEPROP '|BasicOperator| 'NILADIC T) 

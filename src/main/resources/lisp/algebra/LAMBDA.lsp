
(SDEFUN |LAMBDA;lambda;Nni$;1| ((|n1| (|NonNegativeInteger|)) ($ ($)))
        (CONS 0 (LIST |n1|))) 

(PUT '|LAMBDA;lambda;UT$;2| '|SPADreplace| '(XLAM (|var|) (CONS 1 |var|))) 

(SDEFUN |LAMBDA;lambda;UT$;2| ((|var| (UT)) ($ ($))) (CONS 1 |var|)) 

(SDEFUN |LAMBDA;lambda;3$;3| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS 2 (CONS |x| |y|))) 

(SDEFUN |LAMBDA;lambda;$UT$;4| ((|x| ($)) (|t1| (UT)) ($ ($)))
        (SPROG ((|lt| ($)))
               (SEQ (LETT |lt| (CONS 3 (CONS |x| |t1|)))
                    (EXIT (SPADCALL |lt| (QREFELT $ 12)))))) 

(SDEFUN |LAMBDA;getChildren;$L;5| ((|n| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G767 NIL) (#2=#:G742 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |n| (QREFELT $ 15))
                    (PROGN (LETT #1# NIL) (GO #3=#:G766))))
                  (COND
                   ((QEQCAR |n| 2)
                    (PROGN
                     (LETT #1# (LIST (QCAR (CDR |n|)) (QCDR (CDR |n|))))
                     (GO #3#))))
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (LIST
                            (QCAR
                             (PROG2 (LETT #2# |n|)
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 3)
                                               (|Record| (|:| |c3| $)
                                                         (|:| |nm|
                                                              (QREFELT $ 6)))
                                               (|Union|
                                                (|:| |boundTerm|
                                                     (|Record|
                                                      (|:| |varBound|
                                                           (|NonNegativeInteger|))))
                                                (|:| |freeTerm| (QREFELT $ 6))
                                                (|:| |compoundTerm|
                                                     (|Record| (|:| |c1| $)
                                                               (|:| |c2| $)))
                                                (|:| |lambdaTerm|
                                                     (|Record| (|:| |c3| $)
                                                               (|:| |nm|
                                                                    (QREFELT $
                                                                             6)))))
                                               #2#)))))
                     (GO #3#))))
                  (EXIT NIL)))
                #3# (EXIT #1#)))) 

(SDEFUN |LAMBDA;atom?;$B;6| ((|n| ($)) ($ (|Boolean|)))
        (COND ((QEQCAR |n| 0) 'T) ('T (QEQCAR |n| 1)))) 

(PUT '|LAMBDA;isCompound?;$B;7| '|SPADreplace| '(XLAM (|n|) (QEQCAR |n| 2))) 

(SDEFUN |LAMBDA;isCompound?;$B;7| ((|n| ($)) ($ (|Boolean|))) (QEQCAR |n| 2)) 

(PUT '|LAMBDA;isLambda?;$B;8| '|SPADreplace| '(XLAM (|n|) (QEQCAR |n| 3))) 

(SDEFUN |LAMBDA;isLambda?;$B;8| ((|n| ($)) ($ (|Boolean|))) (QEQCAR |n| 3)) 

(PUT '|LAMBDA;isBoundNode?;$B;9| '|SPADreplace| '(XLAM (|n|) (QEQCAR |n| 0))) 

(SDEFUN |LAMBDA;isBoundNode?;$B;9| ((|n| ($)) ($ (|Boolean|))) (QEQCAR |n| 0)) 

(PUT '|LAMBDA;isFreeNode?;$B;10| '|SPADreplace| '(XLAM (|n|) (QEQCAR |n| 1))) 

(SDEFUN |LAMBDA;isFreeNode?;$B;10| ((|n| ($)) ($ (|Boolean|))) (QEQCAR |n| 1)) 

(SDEFUN |LAMBDA;getBoundValue;$Nni;11| ((|n| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G776 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 0)
                    (PROGN (LETT #1# (QCAR (CDR |n|))) (GO #2=#:G775))))
                  (EXIT 0)))
                #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;getVariable;$UT;12| ((|n| ($)) ($ (UT)))
        (SPROG ((#1=#:G780 NIL) (#2=#:G742 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 1)
                    (PROGN (LETT #1# (CDR |n|)) (GO #3=#:G779))))
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (QCDR
                            (PROG2 (LETT #2# |n|)
                                (QCDR #2#)
                              (|check_union2| (QEQCAR #2# 3)
                                              (|Record| (|:| |c3| $)
                                                        (|:| |nm|
                                                             (QREFELT $ 6)))
                                              (|Union|
                                               (|:| |boundTerm|
                                                    (|Record|
                                                     (|:| |varBound|
                                                          (|NonNegativeInteger|))))
                                               (|:| |freeTerm| (QREFELT $ 6))
                                               (|:| |compoundTerm|
                                                    (|Record| (|:| |c1| $)
                                                              (|:| |c2| $)))
                                               (|:| |lambdaTerm|
                                                    (|Record| (|:| |c3| $)
                                                              (|:| |nm|
                                                                   (QREFELT $
                                                                            6)))))
                                              #2#))))
                     (GO #3#))))
                  (EXIT (SPADCALL "error" (QREFELT $ 24)))))
                #3# (EXIT #1#)))) 

(SDEFUN |LAMBDA;freeVariable?| ((|n| ($)) (|s| (UT)) ($ (|Boolean|)))
        (SPROG ((#1=#:G794 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 1)
                    (COND
                     ((SPADCALL (CDR |n|) |s| (QREFELT $ 26))
                      (PROGN (LETT #1# NIL) (GO #2=#:G793))))))
                  (COND
                   ((QEQCAR |n| 3)
                    (COND
                     ((NULL (|LAMBDA;freeVariable?| (QCAR (CDR |n|)) |s| $))
                      (PROGN (LETT #1# NIL) (GO #2#))))))
                  (COND
                   ((QEQCAR |n| 2)
                    (COND
                     ((|LAMBDA;freeVariable?| (QCAR (CDR |n|)) |s| $)
                      (COND
                       ((NULL (|LAMBDA;freeVariable?| (QCDR (CDR |n|)) |s| $))
                        (PROGN (LETT #1# NIL) (GO #2#)))))
                     ('T (PROGN (LETT #1# NIL) (GO #2#))))))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;freeVariable?|
        ((|n| ($)) (|i| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (SPROG ((#1=#:G808 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 0)
                    (COND
                     ((EQL (QCAR (CDR |n|)) |i|)
                      (PROGN (LETT #1# NIL) (GO #2=#:G807))))))
                  (COND
                   ((QEQCAR |n| 3)
                    (COND
                     ((NULL
                       (|LAMBDA;freeVariable?| (QCAR (CDR |n|)) (+ |i| 1) $))
                      (PROGN (LETT #1# NIL) (GO #2#))))))
                  (COND
                   ((QEQCAR |n| 2)
                    (COND
                     ((|LAMBDA;freeVariable?| (QCAR (CDR |n|)) |i| $)
                      (COND
                       ((NULL (|LAMBDA;freeVariable?| (QCDR (CDR |n|)) |i| $))
                        (PROGN (LETT #1# NIL) (GO #2#)))))
                     ('T (PROGN (LETT #1# NIL) (GO #2#))))))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;free?;$B;15| ((|n| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G812 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1# (|LAMBDA;freeVariable?| (QCAR (CDR |n|)) 0 $))
                     (GO #2=#:G811))))
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL "warning free called on non-lambda term"
                              (QREFELT $ 28))
                    (SPADCALL |n| (QREFELT $ 29)) (QREFELT $ 30))
                   (QREFELT $ 32))
                  (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;parseLambdaTerm|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| #1#) (|ex| ($))
          (|r2| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (#2=#:G834 NIL) (|ch| (|Character|))
          (|r| (|Record| (|:| |rft| UT) (|:| |pout| (|NonNegativeInteger|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| "\\")))
                  (SEQ (|error| "lambda term must start with \\")
                       (EXIT
                        (PROGN
                         (LETT #2# (CONS (CONS 0 (LIST 0)) |p1|))
                         (GO #3=#:G833))))))
                (LETT |p1| (+ |p1| 1))
                (COND
                 ((> |p1| (SPADCALL |t1| (QREFELT $ 35)))
                  (SEQ (|error| "lambda term not complete")
                       (EXIT
                        (PROGN
                         (LETT #2# (CONS (CONS 0 (LIST 0)) |p1|))
                         (GO #3#))))))
                (LETT |r| (SPADCALL |t1| |p1| (QREFELT $ 37)))
                (LETT |p1| (QCDR |r|)) (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| ".")))
                  (SEQ (|error| "lambda term must have .")
                       (EXIT
                        (PROGN
                         (LETT #2# (CONS (CONS 0 (LIST 0)) |p1|))
                         (GO #3#))))))
                (LETT |p1| (+ |p1| 1))
                (COND
                 ((> |p1| (SPADCALL |t1| (QREFELT $ 35)))
                  (SEQ (|error| "lambda term must contain something")
                       (EXIT
                        (PROGN
                         (LETT #2# (CONS (CONS 0 (LIST 0)) |p1|))
                         (GO #3#))))))
                (LETT |r2| (SPADCALL |t1| |p1| (QREFELT $ 38)))
                (LETT |ex| (QCAR |r2|)) (LETT |p1| (QCDR |r2|))
                (EXIT (CONS (SPADCALL |ex| (QCAR |r|) (QREFELT $ 13)) |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |LAMBDA;parseBracketTerm|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| #1#) (#2=#:G846 NIL) (|ch| (|Character|)) (|trm| ($))
          (|r2| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| "(")))
                  (SEQ (|error| "bracket term must start with (")
                       (EXIT
                        (PROGN
                         (LETT #2# (CONS (CONS 0 (LIST 0)) |p1|))
                         (GO #3=#:G845))))))
                (LETT |p1| (+ |p1| 1))
                (COND
                 ((> |p1| (SPADCALL |t1| (QREFELT $ 35)))
                  (SEQ (|error| "opening but no closing bracket")
                       (EXIT
                        (PROGN
                         (LETT #2# (CONS (CONS 0 (LIST 0)) |p1|))
                         (GO #3#))))))
                (LETT |r2| (SPADCALL |t1| |p1| (QREFELT $ 38)))
                (LETT |trm| (QCAR |r2|)) (LETT |p1| (QCDR |r2|))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| ")")))
                  (SEQ (|error| "can't find closing bracket")
                       (EXIT
                        (PROGN
                         (LETT #2# (CONS (CONS 0 (LIST 0)) |p1|))
                         (GO #3#))))))
                (LETT |p1| (+ |p1| 1)) (EXIT (CONS |trm| |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |LAMBDA;parseVariableTerm|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|ch| (|Character|)) (#2=#:G864 NIL) (|p1| #1#)
          (|inx| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |inx| 0)
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (SEQ G190
                     (COND ((NULL (SPADCALL |ch| (QREFELT $ 40))) (GO G191)))
                     (SEQ
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "0"))
                        (LETT |inx| (* |inx| 10))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "1"))
                        (LETT |inx| (+ (* |inx| 10) 1))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "2"))
                        (LETT |inx| (+ (* |inx| 10) 2))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "3"))
                        (LETT |inx| (+ (* |inx| 10) 3))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "4"))
                        (LETT |inx| (+ (* |inx| 10) 4))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "5"))
                        (LETT |inx| (+ (* |inx| 10) 5))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "6"))
                        (LETT |inx| (+ (* |inx| 10) 6))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "7"))
                        (LETT |inx| (+ (* |inx| 10) 7))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "8"))
                        (LETT |inx| (+ (* |inx| 10) 8))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "9"))
                        (LETT |inx| (+ (* |inx| 10) 9))))
                      (LETT |p1| (+ |p1| 1))
                      (COND
                       ((> |p1| (SPADCALL |t1| (QREFELT $ 35)))
                        (PROGN
                         (LETT #2# (CONS (SPADCALL |inx| (QREFELT $ 9)) |p1|))
                         (GO #3=#:G863))))
                      (EXIT (LETT |ch| (STR_ELT1 |t1| |p1|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS (SPADCALL |inx| (QREFELT $ 9)) |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |LAMBDA;parseTerm;SNniR;19|
        ((|t1| (|String|)) (|pin| (|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|res| ($)) (|p1| (|NonNegativeInteger|))
          (|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (#1=#:G884 NIL) (|ch| (|Character|))
          (|r2| (|Record| (|:| |rft| UT) (|:| |pout| (|NonNegativeInteger|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |res| (CONS 0 (LIST 0)))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (SEQ G190
                     (COND
                      ((NULL (|eql_SI| |ch| (|STR_to_CHAR| " "))) (GO G191)))
                     (SEQ (LETT |p1| (+ |p1| 1))
                          (COND
                           ((> |p1| (SPADCALL |t1| (QREFELT $ 35)))
                            (PROGN
                             (LETT #1# (CONS |res| |p1|))
                             (GO #2=#:G883))))
                          (EXIT (LETT |ch| (STR_ELT1 |t1| |p1|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (LETT |r| (CONS |res| |p1|))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| "\\"))
                  (LETT |r| (|LAMBDA;parseLambdaTerm| |t1| |p1| $))))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| "("))
                  (LETT |r| (|LAMBDA;parseBracketTerm| |t1| |p1| $))))
                (COND
                 ((SPADCALL |ch| (QREFELT $ 40))
                  (LETT |r| (|LAMBDA;parseVariableTerm| |t1| |p1| $))))
                (LETT |res| (QCAR |r|)) (LETT |p1| (QCDR |r|))
                (COND
                 ((SPADCALL |ch| (QREFELT $ 41))
                  (SEQ (LETT |r2| (SPADCALL |t1| |p1| (QREFELT $ 37)))
                       (LETT |res| (SPADCALL (QCAR |r2|) (QREFELT $ 10)))
                       (EXIT (LETT |p1| (QCDR |r2|))))))
                (COND
                 ((> |p1| (SPADCALL |t1| (QREFELT $ 35)))
                  (PROGN (LETT #1# (CONS |res| |p1|)) (GO #2#))))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| " "))
                  (SEQ (LETT |p1| (+ |p1| 1))
                       (COND
                        ((> |p1| (SPADCALL |t1| (QREFELT $ 35)))
                         (PROGN (LETT #1# (CONS |res| |p1|)) (GO #2#))))
                       (LETT |r| (SPADCALL |t1| |p1| (QREFELT $ 38)))
                       (LETT |p1| (QCDR |r|))
                       (EXIT
                        (LETT |res|
                              (SPADCALL |res| (QCAR |r|) (QREFELT $ 11)))))))
                (EXIT (CONS |res| |p1|))))
          #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;parseLambda;S$;20| ((|t1| (|String|)) ($ ($)))
        (SPROG
         ((|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (#1=#:G885 NIL))
         (SEQ
          (LETT |r|
                (SPADCALL |t1|
                          (PROG1 (LETT #1# (SPADCALL |t1| (QREFELT $ 42)))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#))
                          (QREFELT $ 38)))
          (EXIT (QCAR |r|))))) 

(SDEFUN |LAMBDA;toStringConven;$LS;21|
        ((|n| ($)) (|boundL| (|List| (|String|))) ($ (|String|)))
        (SPROG
         ((|s| (|String|)) (|boundL2| (|List| (|String|)))
          (|varName| (|String|)) (#1=#:G906 NIL) (|i| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |s| "")
                (COND
                 ((QEQCAR |n| 0)
                  (SEQ (LETT |i| (+ (QCAR (CDR |n|)) 1))
                       (COND
                        ((> |i| 0)
                         (COND
                          ((<= |i| (LENGTH |boundL|))
                           (PROGN
                            (LETT #1# (SPADCALL |boundL| |i| (QREFELT $ 45)))
                            (GO #2=#:G905))))))
                       (EXIT (LETT |s| (STRINGIMAGE (QCAR (CDR |n|))))))))
                (COND
                 ((QEQCAR |n| 1)
                  (LETT |s| (SPADCALL (CDR |n|) (QREFELT $ 46)))))
                (COND
                 ((QEQCAR |n| 2)
                  (LETT |s|
                        (SPADCALL
                         (LIST "("
                               (SPADCALL (QCAR (CDR |n|)) |boundL|
                                         (QREFELT $ 47))
                               " "
                               (SPADCALL (QCDR (CDR |n|)) |boundL|
                                         (QREFELT $ 47))
                               ")")
                         (QREFELT $ 48)))))
                (COND
                 ((QEQCAR |n| 3)
                  (SEQ
                   (LETT |varName| (SPADCALL (QCDR (CDR |n|)) (QREFELT $ 46)))
                   (SEQ G190
                        (COND
                         ((NULL (SPADCALL |varName| |boundL| (QREFELT $ 49)))
                          (GO G191)))
                        (SEQ (EXIT (LETT |varName| (STRCONC |varName| "'"))))
                        NIL (GO G190) G191 (EXIT NIL))
                   (LETT |boundL2|
                         (SPADCALL |boundL| |varName| (QREFELT $ 50)))
                   (EXIT
                    (LETT |s|
                          (SPADCALL
                           (LIST "(\\" |varName| "."
                                 (SPADCALL (QCAR (CDR |n|)) |boundL2|
                                           (QREFELT $ 47))
                                 ")")
                           (QREFELT $ 48)))))))
                (EXIT |s|)))
          #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;toString;$S;22| ((|n| ($)) ($ (|String|)))
        (SPROG ((|s| (|String|)))
               (SEQ (LETT |s| "")
                    (COND
                     ((QEQCAR |n| 0)
                      (LETT |s| (STRINGIMAGE (QCAR (CDR |n|))))))
                    (COND
                     ((QEQCAR |n| 1)
                      (LETT |s| (SPADCALL (CDR |n|) (QREFELT $ 51)))))
                    (COND
                     ((QEQCAR |n| 2)
                      (LETT |s|
                            (SPADCALL
                             (LIST "("
                                   (SPADCALL (QCAR (CDR |n|)) (QREFELT $ 52))
                                   " "
                                   (SPADCALL (QCDR (CDR |n|)) (QREFELT $ 52))
                                   ")")
                             (QREFELT $ 48)))))
                    (COND
                     ((QEQCAR |n| 3)
                      (LETT |s|
                            (SPADCALL
                             (LIST "(\\"
                                   (SPADCALL (QCDR (CDR |n|)) (QREFELT $ 51))
                                   "."
                                   (SPADCALL (QCAR (CDR |n|)) (QREFELT $ 52))
                                   ")")
                             (QREFELT $ 48)))))
                    (EXIT |s|)))) 

(SDEFUN |LAMBDA;subst;4$;23| ((|n| ($)) (|a| ($)) (|b| ($)) ($ ($)))
        (SPROG ((#1=#:G921 NIL) (#2=#:G742 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |n| |b| (QREFELT $ 53))
                    (PROGN (LETT #1# |a|) (GO #3=#:G920))))
                  (COND
                   ((QEQCAR |n| 2)
                    (PROGN
                     (LETT #1#
                           (SPADCALL
                            (SPADCALL (QCAR (CDR |n|)) |a| |b| (QREFELT $ 54))
                            (SPADCALL (QCDR (CDR |n|)) |a| |b| (QREFELT $ 54))
                            (QREFELT $ 11)))
                     (GO #3#))))
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (SPADCALL
                            (SPADCALL
                             (QCAR
                              (PROG2 (LETT #2# |n|)
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 3)
                                                (|Record| (|:| |c3| $)
                                                          (|:| |nm|
                                                               (QREFELT $ 6)))
                                                (|Union|
                                                 (|:| |boundTerm|
                                                      (|Record|
                                                       (|:| |varBound|
                                                            (|NonNegativeInteger|))))
                                                 (|:| |freeTerm| (QREFELT $ 6))
                                                 (|:| |compoundTerm|
                                                      (|Record| (|:| |c1| $)
                                                                (|:| |c2| $)))
                                                 (|:| |lambdaTerm|
                                                      (|Record| (|:| |c3| $)
                                                                (|:| |nm|
                                                                     (QREFELT $
                                                                              6)))))
                                                #2#)))
                             |a| |b| (QREFELT $ 54))
                            (QCDR
                             (PROG2 (LETT #2# |n|)
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 3)
                                               (|Record| (|:| |c3| $)
                                                         (|:| |nm|
                                                              (QREFELT $ 6)))
                                               (|Union|
                                                (|:| |boundTerm|
                                                     (|Record|
                                                      (|:| |varBound|
                                                           (|NonNegativeInteger|))))
                                                (|:| |freeTerm| (QREFELT $ 6))
                                                (|:| |compoundTerm|
                                                     (|Record| (|:| |c1| $)
                                                               (|:| |c2| $)))
                                                (|:| |lambdaTerm|
                                                     (|Record| (|:| |c3| $)
                                                               (|:| |nm|
                                                                    (QREFELT $
                                                                             6)))))
                                               #2#)))
                            (QREFELT $ 13)))
                     (GO #3#))))
                  (EXIT |n|)))
                #3# (EXIT #1#)))) 

(SDEFUN |LAMBDA;bindTerm|
        ((|n| ($)) (|i| (|NonNegativeInteger|)) (|s| (UT)) ($ ($)))
        (SPROG ((#1=#:G933 NIL) (#2=#:G741 NIL) (#3=#:G740 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 0)
                    (PROGN
                     (LETT #1# (SPADCALL (QCAR (CDR |n|)) (QREFELT $ 9)))
                     (GO #4=#:G932))))
                  (COND
                   ((QEQCAR |n| 1)
                    (SEQ
                     (COND
                      ((SPADCALL
                        (PROG2 (LETT #3# |n|)
                            (QCDR #3#)
                          (|check_union2| (QEQCAR #3# 1) (QREFELT $ 6)
                                          (|Union|
                                           (|:| |boundTerm|
                                                (|Record|
                                                 (|:| |varBound|
                                                      (|NonNegativeInteger|))))
                                           (|:| |freeTerm| (QREFELT $ 6))
                                           (|:| |compoundTerm|
                                                (|Record| (|:| |c1| $)
                                                          (|:| |c2| $)))
                                           (|:| |lambdaTerm|
                                                (|Record| (|:| |c3| $)
                                                          (|:| |nm|
                                                               (QREFELT $
                                                                        6)))))
                                          #3#))
                        |s| (QREFELT $ 26))
                       (PROGN
                        (LETT #1# (SPADCALL |i| (QREFELT $ 9)))
                        (GO #4#))))
                     (EXIT
                      (PROGN
                       (LETT #1#
                             (SPADCALL
                              (PROG2 (LETT #3# |n|)
                                  (QCDR #3#)
                                (|check_union2| (QEQCAR #3# 1) (QREFELT $ 6)
                                                (|Union|
                                                 (|:| |boundTerm|
                                                      (|Record|
                                                       (|:| |varBound|
                                                            (|NonNegativeInteger|))))
                                                 (|:| |freeTerm| (QREFELT $ 6))
                                                 (|:| |compoundTerm|
                                                      (|Record| (|:| |c1| $)
                                                                (|:| |c2| $)))
                                                 (|:| |lambdaTerm|
                                                      (|Record| (|:| |c3| $)
                                                                (|:| |nm|
                                                                     (QREFELT $
                                                                              6)))))
                                                #3#))
                              (QREFELT $ 10)))
                       (GO #4#))))))
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (CONS 3
                                 (CONS
                                  (|LAMBDA;bindTerm| (QCAR (CDR |n|)) (+ |i| 1)
                                   |s| $)
                                  (QCDR (CDR |n|)))))
                     (GO #4#))))
                  (COND
                   ((QEQCAR |n| 2)
                    (PROGN
                     (LETT #1#
                           (SPADCALL
                            (|LAMBDA;bindTerm|
                             (QCAR
                              (PROG2 (LETT #2# |n|)
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 2)
                                                (|Record| (|:| |c1| $)
                                                          (|:| |c2| $))
                                                (|Union|
                                                 (|:| |boundTerm|
                                                      (|Record|
                                                       (|:| |varBound|
                                                            (|NonNegativeInteger|))))
                                                 (|:| |freeTerm| (QREFELT $ 6))
                                                 (|:| |compoundTerm|
                                                      (|Record| (|:| |c1| $)
                                                                (|:| |c2| $)))
                                                 (|:| |lambdaTerm|
                                                      (|Record| (|:| |c3| $)
                                                                (|:| |nm|
                                                                     (QREFELT $
                                                                              6)))))
                                                #2#)))
                             |i| |s| $)
                            (|LAMBDA;bindTerm|
                             (QCDR
                              (PROG2 (LETT #2# |n|)
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 2)
                                                (|Record| (|:| |c1| $)
                                                          (|:| |c2| $))
                                                (|Union|
                                                 (|:| |boundTerm|
                                                      (|Record|
                                                       (|:| |varBound|
                                                            (|NonNegativeInteger|))))
                                                 (|:| |freeTerm| (QREFELT $ 6))
                                                 (|:| |compoundTerm|
                                                      (|Record| (|:| |c1| $)
                                                                (|:| |c2| $)))
                                                 (|:| |lambdaTerm|
                                                      (|Record| (|:| |c3| $)
                                                                (|:| |nm|
                                                                     (QREFELT $
                                                                              6)))))
                                                #2#)))
                             |i| |s| $)
                            (QREFELT $ 11)))
                     (GO #4#))))
                  (EXIT |n|)))
                #4# (EXIT #1#)))) 

(SDEFUN |LAMBDA;bind;2$;25| ((|n| ($)) ($ ($)))
        (SPROG ((#1=#:G937 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (CONS 3
                                 (CONS
                                  (|LAMBDA;bindTerm| (QCAR (CDR |n|)) 0
                                   (QCDR (CDR |n|)) $)
                                  (QCDR (CDR |n|)))))
                     (GO #2=#:G936))))
                  (EXIT |n|)))
                #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;unbindTerm|
        ((|n| ($)) (|i| (|NonNegativeInteger|)) (|s| (UT)) ($ ($)))
        (SPROG ((#1=#:G949 NIL) (#2=#:G741 NIL) (#3=#:G742 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 0)
                    (SEQ
                     (COND
                      ((EQL (QCAR (CDR |n|)) |i|)
                       (PROGN
                        (LETT #1# (SPADCALL |s| (QREFELT $ 10)))
                        (GO #4=#:G948))))
                     (EXIT
                      (PROGN
                       (LETT #1# (SPADCALL (QCAR (CDR |n|)) (QREFELT $ 9)))
                       (GO #4#))))))
                  (COND
                   ((QEQCAR |n| 1)
                    (PROGN
                     (LETT #1# (SPADCALL (CDR |n|) (QREFELT $ 10)))
                     (GO #4#))))
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (CONS 3
                                 (CONS
                                  (|LAMBDA;unbindTerm|
                                   (QCAR
                                    (PROG2 (LETT #3# |n|)
                                        (QCDR #3#)
                                      (|check_union2| (QEQCAR #3# 3)
                                                      (|Record| (|:| |c3| $)
                                                                (|:| |nm|
                                                                     (QREFELT $
                                                                              6)))
                                                      (|Union|
                                                       (|:| |boundTerm|
                                                            (|Record|
                                                             (|:| |varBound|
                                                                  (|NonNegativeInteger|))))
                                                       (|:| |freeTerm|
                                                            (QREFELT $ 6))
                                                       (|:| |compoundTerm|
                                                            (|Record|
                                                             (|:| |c1| $)
                                                             (|:| |c2| $)))
                                                       (|:| |lambdaTerm|
                                                            (|Record|
                                                             (|:| |c3| $)
                                                             (|:| |nm|
                                                                  (QREFELT $
                                                                           6)))))
                                                      #3#)))
                                   (+ |i| 1) |s| $)
                                  (QCDR
                                   (PROG2 (LETT #3# |n|)
                                       (QCDR #3#)
                                     (|check_union2| (QEQCAR #3# 3)
                                                     (|Record| (|:| |c3| $)
                                                               (|:| |nm|
                                                                    (QREFELT $
                                                                             6)))
                                                     (|Union|
                                                      (|:| |boundTerm|
                                                           (|Record|
                                                            (|:| |varBound|
                                                                 (|NonNegativeInteger|))))
                                                      (|:| |freeTerm|
                                                           (QREFELT $ 6))
                                                      (|:| |compoundTerm|
                                                           (|Record|
                                                            (|:| |c1| $)
                                                            (|:| |c2| $)))
                                                      (|:| |lambdaTerm|
                                                           (|Record|
                                                            (|:| |c3| $)
                                                            (|:| |nm|
                                                                 (QREFELT $
                                                                          6)))))
                                                     #3#))))))
                     (GO #4#))))
                  (COND
                   ((QEQCAR |n| 2)
                    (PROGN
                     (LETT #1#
                           (SPADCALL
                            (|LAMBDA;unbindTerm|
                             (QCAR
                              (PROG2 (LETT #2# |n|)
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 2)
                                                (|Record| (|:| |c1| $)
                                                          (|:| |c2| $))
                                                (|Union|
                                                 (|:| |boundTerm|
                                                      (|Record|
                                                       (|:| |varBound|
                                                            (|NonNegativeInteger|))))
                                                 (|:| |freeTerm| (QREFELT $ 6))
                                                 (|:| |compoundTerm|
                                                      (|Record| (|:| |c1| $)
                                                                (|:| |c2| $)))
                                                 (|:| |lambdaTerm|
                                                      (|Record| (|:| |c3| $)
                                                                (|:| |nm|
                                                                     (QREFELT $
                                                                              6)))))
                                                #2#)))
                             |i| |s| $)
                            (|LAMBDA;unbindTerm|
                             (QCDR
                              (PROG2 (LETT #2# |n|)
                                  (QCDR #2#)
                                (|check_union2| (QEQCAR #2# 2)
                                                (|Record| (|:| |c1| $)
                                                          (|:| |c2| $))
                                                (|Union|
                                                 (|:| |boundTerm|
                                                      (|Record|
                                                       (|:| |varBound|
                                                            (|NonNegativeInteger|))))
                                                 (|:| |freeTerm| (QREFELT $ 6))
                                                 (|:| |compoundTerm|
                                                      (|Record| (|:| |c1| $)
                                                                (|:| |c2| $)))
                                                 (|:| |lambdaTerm|
                                                      (|Record| (|:| |c3| $)
                                                                (|:| |nm|
                                                                     (QREFELT $
                                                                              6)))))
                                                #2#)))
                             |i| |s| $)
                            (QREFELT $ 11)))
                     (GO #4#))))
                  (EXIT |n|)))
                #4# (EXIT #1#)))) 

(SDEFUN |LAMBDA;unbind;2$;27| ((|n| ($)) ($ ($)))
        (SPROG ((#1=#:G953 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (CONS 3
                                 (CONS
                                  (|LAMBDA;unbindTerm| (QCAR (CDR |n|)) 0
                                   (QCDR (CDR |n|)) $)
                                  (QCDR (CDR |n|)))))
                     (GO #2=#:G952))))
                  (EXIT |n|)))
                #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;redux;2$;28| ((|n| ($)) ($ ($)))
        (SPROG ((#1=#:G966 NIL) (|term2| ($)) (|term1| ($)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |n| (QREFELT $ 15))
                    (PROGN (LETT #1# |n|) (GO #2=#:G965))))
                  (COND
                   ((QEQCAR |n| 2)
                    (SEQ (LETT |term1| (QCAR (CDR |n|)))
                         (LETT |term2| (QCDR (CDR |n|)))
                         (COND
                          ((SPADCALL |term1| (QREFELT $ 19))
                           (PROGN
                            (LETT #1#
                                  (SPADCALL |term1| |term2|
                                            (SPADCALL 0 (QREFELT $ 9))
                                            (QREFELT $ 54)))
                            (GO #2#))))
                         (EXIT
                          (PROGN
                           (LETT #1#
                                 (SPADCALL (SPADCALL |term1| (QREFELT $ 56))
                                           (SPADCALL |term2| (QREFELT $ 56))
                                           (QREFELT $ 11)))
                           (GO #2#))))))
                  (COND
                   ((QEQCAR |n| 3)
                    (PROGN
                     (LETT #1#
                           (SPADCALL (SPADCALL (QCAR (CDR |n|)) (QREFELT $ 56))
                                     (QCDR (CDR |n|)) (QREFELT $ 13)))
                     (GO #2#))))
                  (EXIT |n|)))
                #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;=;2$B;29| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G985 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |x| 0)
                    (COND
                     ((QEQCAR |y| 0)
                      (SEQ
                       (COND
                        ((EQL (QCAR (CDR |x|)) (QCAR (CDR |y|)))
                         (PROGN (LETT #1# 'T) (GO #2=#:G984))))
                       (EXIT (PROGN (LETT #1# NIL) (GO #2#))))))))
                  (COND
                   ((QEQCAR |x| 1)
                    (COND
                     ((QEQCAR |y| 1)
                      (SEQ
                       (COND
                        ((SPADCALL (CDR |x|) (CDR |y|) (QREFELT $ 26))
                         (PROGN (LETT #1# 'T) (GO #2#))))
                       (EXIT (PROGN (LETT #1# NIL) (GO #2#))))))))
                  (COND
                   ((QEQCAR |x| 2)
                    (COND
                     ((QEQCAR |y| 2)
                      (SEQ
                       (COND
                        ((SPADCALL (QCAR (CDR |x|)) (QCAR (CDR |y|))
                                   (QREFELT $ 53))
                         (COND
                          ((SPADCALL (QCDR (CDR |x|)) (QCDR (CDR |y|))
                                     (QREFELT $ 53))
                           (PROGN (LETT #1# 'T) (GO #2#))))))
                       (EXIT (PROGN (LETT #1# NIL) (GO #2#))))))))
                  (COND
                   ((QEQCAR |x| 3)
                    (COND
                     ((QEQCAR |y| 3)
                      (SEQ
                       (COND
                        ((SPADCALL (QCAR (CDR |x|)) (QCAR (CDR |y|))
                                   (QREFELT $ 53))
                         (PROGN (LETT #1# 'T) (GO #2#))))
                       (EXIT (PROGN (LETT #1# NIL) (GO #2#))))))))
                  (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;toOutputFormConven|
        ((|n| ($)) (|boundL| (|List| (|String|))) ($ (|OutputForm|)))
        (SPROG
         ((|s| (|OutputForm|)) (|boundL2| (|List| (|String|)))
          (|varName| (|String|)) (#1=#:G996 NIL) (|i| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |s| (SPADCALL (QREFELT $ 57)))
                (COND
                 ((QEQCAR |n| 0)
                  (SEQ (LETT |i| (+ (QCAR (CDR |n|)) 1))
                       (COND
                        ((> |i| 0)
                         (COND
                          ((<= |i| (LENGTH |boundL|))
                           (PROGN
                            (LETT #1#
                                  (SPADCALL
                                   (SPADCALL |boundL| |i| (QREFELT $ 45))
                                   (QREFELT $ 28)))
                            (GO #2=#:G995))))))
                       (EXIT
                        (LETT |s|
                              (SPADCALL (QCAR (CDR |n|)) (QREFELT $ 58)))))))
                (COND
                 ((QEQCAR |n| 1)
                  (LETT |s| (SPADCALL (CDR |n|) (QREFELT $ 59)))))
                (COND
                 ((QEQCAR |n| 2)
                  (LETT |s|
                        (SPADCALL
                         (LIST (SPADCALL "(" (QREFELT $ 28))
                               (|LAMBDA;toOutputFormConven| (QCAR (CDR |n|))
                                |boundL| $)
                               (SPADCALL " " (QREFELT $ 28))
                               (|LAMBDA;toOutputFormConven| (QCDR (CDR |n|))
                                |boundL| $)
                               (SPADCALL ")" (QREFELT $ 28)))
                         (QREFELT $ 60)))))
                (COND
                 ((QEQCAR |n| 3)
                  (SEQ
                   (LETT |varName| (SPADCALL (QCDR (CDR |n|)) (QREFELT $ 46)))
                   (SEQ G190
                        (COND
                         ((NULL (SPADCALL |varName| |boundL| (QREFELT $ 49)))
                          (GO G191)))
                        (SEQ (EXIT (LETT |varName| (STRCONC |varName| "'"))))
                        NIL (GO G190) G191 (EXIT NIL))
                   (LETT |boundL2|
                         (SPADCALL |boundL| |varName| (QREFELT $ 50)))
                   (EXIT
                    (LETT |s|
                          (SPADCALL
                           (LIST (SPADCALL "(\\" (QREFELT $ 28))
                                 (SPADCALL |varName| (QREFELT $ 28))
                                 (SPADCALL "." (QREFELT $ 28))
                                 (|LAMBDA;toOutputFormConven| (QCAR (CDR |n|))
                                  |boundL2| $)
                                 (SPADCALL ")" (QREFELT $ 28)))
                           (QREFELT $ 60)))))))
                (EXIT |s|)))
          #2# (EXIT #1#)))) 

(SDEFUN |LAMBDA;coerce;$Of;31| ((|n| ($)) ($ (|OutputForm|)))
        (|LAMBDA;toOutputFormConven| |n| NIL $)) 

(DECLAIM (NOTINLINE |Lambda;|)) 

(DEFUN |Lambda| (#1=#:G998)
  (SPROG NIL
         (PROG (#2=#:G999)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Lambda|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Lambda;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Lambda|)))))))))) 

(DEFUN |Lambda;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Lambda| DV$1))
          (LETT $ (GETREFV 61))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Lambda| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Union|
                     (|:| |boundTerm|
                          (|Record| (|:| |varBound| (|NonNegativeInteger|))))
                     (|:| |freeTerm| |#1|)
                     (|:| |compoundTerm| (|Record| (|:| |c1| $) (|:| |c2| $)))
                     (|:| |lambdaTerm|
                          (|Record| (|:| |c3| $) (|:| |nm| |#1|)))))
          $))) 

(MAKEPROP '|Lambda| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (|NonNegativeInteger|) |LAMBDA;lambda;Nni$;1|
              |LAMBDA;lambda;UT$;2| |LAMBDA;lambda;3$;3| |LAMBDA;bind;2$;25|
              |LAMBDA;lambda;$UT$;4| (|Boolean|) |LAMBDA;atom?;$B;6| (|List| $)
              |LAMBDA;getChildren;$L;5| |LAMBDA;isCompound?;$B;7|
              |LAMBDA;isLambda?;$B;8| |LAMBDA;isBoundNode?;$B;9|
              |LAMBDA;isFreeNode?;$B;10| |LAMBDA;getBoundValue;$Nni;11|
              (|String|) (0 . |var|) |LAMBDA;getVariable;$UT;12| (5 . =)
              (|OutputForm|) (11 . |message|) |LAMBDA;coerce;$Of;31|
              (16 . |hconcat|) (|Void|) (22 . |print|) |LAMBDA;free?;$B;15|
              (|Integer|) (27 . |maxIndex|)
              (|Record| (|:| |rft| $) (|:| |pout| 8)) (32 . |parseVarTerm|)
              |LAMBDA;parseTerm;SNniR;19| (|Character|) (38 . |digit?|)
              (43 . |alphabetic?|) (48 . |minIndex|) |LAMBDA;parseLambda;S$;20|
              (|List| 23) (53 . |elt|) (59 . |getName|)
              |LAMBDA;toStringConven;$LS;21| (64 . |concat|) (69 . |member?|)
              (75 . |concat|) (81 . |toString|) |LAMBDA;toString;$S;22|
              |LAMBDA;=;2$B;29| |LAMBDA;subst;4$;23| |LAMBDA;unbind;2$;27|
              |LAMBDA;redux;2$;28| (86 . |empty|) (90 . |coerce|)
              (95 . |coerce|) (100 . |hconcat|))
           '#(|unbind| 105 |toStringConven| 110 |toString| 116 |subst| 121
              |redux| 128 |parseTerm| 133 |parseLambda| 139 |lambda| 144
              |isLambda?| 166 |isFreeNode?| 171 |isCompound?| 176
              |isBoundNode?| 181 |getVariable| 186 |getChildren| 191
              |getBoundValue| 196 |free?| 201 |coerce| 206 |bind| 211 |atom?|
              216 = 221)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|CoercibleTo| 27))
                             (|makeByteWordVec2| 60
                                                 '(1 6 0 23 24 2 6 14 0 0 26 1
                                                   27 0 23 28 2 27 0 0 0 30 1
                                                   27 31 0 32 1 23 34 0 35 2 6
                                                   36 23 8 37 1 39 14 0 40 1 39
                                                   14 0 41 1 23 34 0 42 2 44 23
                                                   0 34 45 1 6 23 0 46 1 23 0
                                                   16 48 2 44 14 23 0 49 2 44 0
                                                   0 23 50 1 6 23 0 51 0 27 0
                                                   57 1 8 27 0 58 1 6 27 0 59 1
                                                   27 0 16 60 1 0 0 0 55 2 0 23
                                                   0 44 47 1 0 23 0 52 3 0 0 0
                                                   0 0 54 1 0 0 0 56 2 0 36 23
                                                   8 38 1 0 0 23 43 2 0 0 0 0
                                                   11 2 0 0 0 6 13 1 0 0 6 10 1
                                                   0 0 8 9 1 0 14 0 19 1 0 14 0
                                                   21 1 0 14 0 18 1 0 14 0 20 1
                                                   0 6 0 25 1 0 16 0 17 1 0 8 0
                                                   22 1 0 14 0 33 1 0 27 0 29 1
                                                   0 0 0 12 1 0 14 0 15 2 0 14
                                                   0 0 53)))))
           '|lookupComplete|)) 


(PUT '|LIST;#;$Nni;1| '|SPADreplace| 'LENGTH) 

(SDEFUN |LIST;#;$Nni;1| ((|x| ($)) ($ (|NonNegativeInteger|))) (LENGTH |x|)) 

(PUT '|LIST;cons;S2$;2| '|SPADreplace| 'CONS) 

(SDEFUN |LIST;cons;S2$;2| ((|s| (S)) (|x| ($)) ($ ($))) (CONS |s| |x|)) 

(PUT '|LIST;concat;S2$;3| '|SPADreplace| 'CONS) 

(SDEFUN |LIST;concat;S2$;3| ((|s| (S)) (|x| ($)) ($ ($))) (CONS |s| |x|)) 

(PUT '|LIST;eq?;2$B;4| '|SPADreplace| 'EQ) 

(SDEFUN |LIST;eq?;2$B;4| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (EQ |x| |y|)) 

(PUT '|LIST;first;$S;5| '|SPADreplace| '|SPADfirst|) 

(SDEFUN |LIST;first;$S;5| ((|x| ($)) ($ (S))) (|SPADfirst| |x|)) 

(PUT '|LIST;elt;$firstS;6| '|SPADreplace|
     '(XLAM (|x| "first") (|SPADfirst| |x|))) 

(SDEFUN |LIST;elt;$firstS;6| ((|x| ($)) (T1 ("first")) ($ (S)))
        (|SPADfirst| |x|)) 

(PUT '|LIST;empty;$;7| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |LIST;empty;$;7| (($ ($))) NIL) 

(PUT '|LIST;empty?;$B;8| '|SPADreplace| 'NULL) 

(SDEFUN |LIST;empty?;$B;8| ((|x| ($)) ($ (|Boolean|))) (NULL |x|)) 

(PUT '|LIST;rest;2$;9| '|SPADreplace| 'CDR) 

(SDEFUN |LIST;rest;2$;9| ((|x| ($)) ($ ($))) (CDR |x|)) 

(PUT '|LIST;elt;$rest$;10| '|SPADreplace| '(XLAM (|x| "rest") (CDR |x|))) 

(SDEFUN |LIST;elt;$rest$;10| ((|x| ($)) (T2 ("rest")) ($ ($))) (CDR |x|)) 

(PUT '|LIST;qsetfirst!;$2S;11| '|SPADreplace| '|qset_first|) 

(SDEFUN |LIST;qsetfirst!;$2S;11| ((|x| ($)) (|s| (S)) ($ (S)))
        (|qset_first| |x| |s|)) 

(SDEFUN |LIST;setfirst!;$2S;12| ((|x| ($)) (|s| (S)) ($ (S)))
        (COND ((NULL |x|) (|error| "Cannot update an empty list"))
              ('T (|qset_first| |x| |s|)))) 

(SDEFUN |LIST;setelt!;$first2S;13|
        ((|x| ($)) (T11 ("first")) (|s| (S)) ($ (S)))
        (COND ((NULL |x|) (|error| "Cannot update an empty list"))
              ('T (|qset_first| |x| |s|)))) 

(PUT '|LIST;qsetrest!;3$;14| '|SPADreplace| '|qset_rest|) 

(SDEFUN |LIST;qsetrest!;3$;14| ((|x| ($)) (|y| ($)) ($ ($)))
        (|qset_rest| |x| |y|)) 

(SDEFUN |LIST;setrest!;3$;15| ((|x| ($)) (|y| ($)) ($ ($)))
        (COND ((NULL |x|) (|error| "Cannot update an empty list"))
              ('T (|qset_rest| |x| |y|)))) 

(SDEFUN |LIST;setelt!;$rest2$;16| ((|x| ($)) (T12 ("rest")) (|y| ($)) ($ ($)))
        (COND ((NULL |x|) (|error| "Cannot update an empty list"))
              ('T (|qset_rest| |x| |y|)))) 

(PUT '|LIST;construct;2$;17| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |LIST;construct;2$;17| ((|l| (|List| S)) ($ ($))) |l|) 

(PUT '|LIST;parts;2$;18| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |LIST;parts;2$;18| ((|s| ($)) ($ (|List| S))) |s|) 

(PUT '|LIST;reverse!;2$;19| '|SPADreplace| 'NREVERSE) 

(SDEFUN |LIST;reverse!;2$;19| ((|x| ($)) ($ ($))) (NREVERSE |x|)) 

(PUT '|LIST;reverse;2$;20| '|SPADreplace| 'REVERSE) 

(SDEFUN |LIST;reverse;2$;20| ((|x| ($)) ($ ($))) (REVERSE |x|)) 

(PUT '|LIST;minIndex;$I;21| '|SPADreplace| '(XLAM (|x|) 1)) 

(SDEFUN |LIST;minIndex;$I;21| ((|x| ($)) ($ (|Integer|))) 1) 

(PUT '|LIST;maxIndex;$I;22| '|SPADreplace| 'LENGTH) 

(SDEFUN |LIST;maxIndex;$I;22| ((|x| ($)) ($ (|Integer|))) (LENGTH |x|)) 

(SDEFUN |LIST;first;$Nni$;23| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|l| ($)) (#1=#:G2171 NIL) (|i| NIL))
               (SEQ (LETT |l| NIL)
                    (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND ((NULL |x|) (|error| "Index out of range"))
                                 ('T
                                  (SEQ
                                   (LETT |l|
                                         (SPADCALL (|SPADfirst| |x|) |l|
                                                   (QREFELT $ 10)))
                                   (EXIT (LETT |x| (CDR |x|))))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (NREVERSE |l|))))) 

(SDEFUN |LIST;rest;$Nni$;24| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((#1=#:G2178 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ (COND ((NULL |x|) (|error| "index out of range")))
                          (EXIT (LETT |x| (QCDR |x|))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |x|)))) 

(SDEFUN |LIST;copy;2$;25| ((|x| ($)) ($ ($)))
        (SPROG ((|y| ($)) (|i| NIL))
               (SEQ (LETT |y| NIL)
                    (SEQ (LETT |i| 0) G190
                         (COND ((NULL (NULL (NULL |x|))) (GO G191)))
                         (SEQ
                          (COND
                           ((EQL |i| 1000)
                            (COND
                             ((SPADCALL |x| (QREFELT $ 37))
                              (|error| "cyclic list")))))
                          (LETT |y| (CONS (QCAR |x|) |y|))
                          (EXIT (LETT |x| (QCDR |x|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (NREVERSE |y|))))) 

(SDEFUN |LIST;leaves;2$;26| ((|x| ($)) ($ (|List| S)))
        (SPROG ((#1=#:G2193 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (COND ((NULL |x|) NIL)
                       ('T
                        (SEQ (LETT |i| 0) G190
                             (COND ((NULL (NULL (NULL |x|))) (GO G191)))
                             (SEQ
                              (COND
                               ((EQL |i| 1000)
                                (COND
                                 ((SPADCALL |x| (QREFELT $ 37))
                                  (EXIT (|error| "cyclic list"))))))
                              (EXIT
                               (COND
                                ((SPADCALL |x| (QREFELT $ 39))
                                 (PROGN
                                  (LETT #1#
                                        (LIST (SPADCALL |x| (QREFELT $ 40))))
                                  (GO #2=#:G2192)))
                                ('T (LETT |x| (QCDR |x|))))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL)))))
                #2# (EXIT #1#)))) 

(SDEFUN |LIST;coerce;$Of;27| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|z| (|List| (|OutputForm|))) (|y| (|List| (|OutputForm|)))
          (|s| ($)))
         (SEQ (LETT |y| NIL) (LETT |s| (SPADCALL |x| (QREFELT $ 42)))
              (SEQ G190 (COND ((NULL (NULL (EQ |x| |s|))) (GO G191)))
                   (SEQ
                    (LETT |y|
                          (SPADCALL (SPADCALL (|SPADfirst| |x|) (QREFELT $ 44))
                                    |y| (QREFELT $ 46)))
                    (EXIT (LETT |x| (CDR |x|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |y| (NREVERSE |y|))
              (EXIT
               (COND ((NULL |s|) (SPADCALL |y| (QREFELT $ 48)))
                     ('T
                      (SEQ
                       (LETT |z|
                             (SPADCALL
                              (SPADCALL (|SPADfirst| |x|) (QREFELT $ 44))
                              (QREFELT $ 49)))
                       (SEQ G190
                            (COND ((NULL (NULL (EQ |s| (CDR |x|)))) (GO G191)))
                            (SEQ (LETT |x| (CDR |x|))
                                 (EXIT
                                  (LETT |z|
                                        (SPADCALL
                                         (SPADCALL (|SPADfirst| |x|)
                                                   (QREFELT $ 44))
                                         |z| (QREFELT $ 46)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (SPADCALL
                         (SPADCALL |y|
                                   (SPADCALL
                                    (SPADCALL (NREVERSE |z|) (QREFELT $ 50))
                                    (QREFELT $ 51))
                                   (QREFELT $ 52))
                         (QREFELT $ 48)))))))))) 

(SDEFUN |LIST;=;2$B;28| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G2214 NIL))
               (SEQ
                (EXIT
                 (COND ((EQ |x| |y|) 'T)
                       (#2='T
                        (SEQ
                         (SEQ G190
                              (COND
                               ((NULL
                                 (COND ((NULL |x|) NIL)
                                       ('T (NULL (NULL |y|)))))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL (QCAR |x|) (QCAR |y|)
                                            (QREFELT $ 54))
                                  (PROGN (LETT #1# NIL) (GO #3=#:G2213)))
                                 ('T
                                  (SEQ (LETT |x| (QCDR |x|))
                                       (EXIT (LETT |y| (QCDR |y|))))))))
                              NIL (GO G190) G191 (EXIT NIL))
                         (EXIT (COND ((NULL |x|) (NULL |y|)) (#2# NIL)))))))
                #3# (EXIT #1#)))) 

(SDEFUN |LIST;member?;S$B;29| ((|s| (S)) (|x| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G2221 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ G190 (COND ((NULL (NULL (NULL |x|))) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |s| (QCAR |x|) (QREFELT $ 56))
                           (PROGN (LETT #1# 'T) (GO #2=#:G2220)))
                          ('T (LETT |x| (QCDR |x|))))))
                       NIL (GO G190) G191 (EXIT NIL))
                  (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |LIST;latex;$S;30| ((|x| ($)) ($ (|String|)))
        (SPROG ((|s| (|String|)))
               (SEQ (LETT |s| "\\left[")
                    (SEQ G190 (COND ((NULL (NULL (NULL |x|))) (GO G191)))
                         (SEQ
                          (LETT |s|
                                (STRCONC |s|
                                         (SPADCALL (QCAR |x|) (QREFELT $ 59))))
                          (LETT |x| (QCDR |x|))
                          (EXIT
                           (COND
                            ((NULL (NULL |x|))
                             (LETT |s| (STRCONC |s| ", "))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (STRCONC |s| " \\right]"))))) 

(SDEFUN |LIST;hashUpdate!;Hs$Hs;31|
        ((|s| (|HashState|)) (|x| ($)) ($ (|HashState|)))
        (SEQ
         (SEQ G190 (COND ((NULL (NULL (NULL |x|))) (GO G191)))
              (SEQ (LETT |s| (SPADCALL |s| (QCAR |x|) (QREFELT $ 62)))
                   (EXIT (LETT |x| (QCDR |x|))))
              NIL (GO G190) G191 (EXIT NIL))
         (EXIT |s|))) 

(SDEFUN |LIST;concat!;3$;32| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|z| ($)))
               (SEQ
                (COND ((NULL |x|) |y|)
                      ('T
                       (SEQ (LETT |z| |x|)
                            (SEQ G190
                                 (COND
                                  ((NULL (NULL (NULL (QCDR |z|)))) (GO G191)))
                                 (SEQ (EXIT (LETT |z| (QCDR |z|)))) NIL
                                 (GO G190) G191 (EXIT NIL))
                            (|qset_rest| |z| |y|) (EXIT |x|))))))) 

(SDEFUN |LIST;removeDuplicates!;2$;33| ((|l| ($)) ($ ($)))
        (SPROG ((|pp| ($)) (|pr| ($)) (|p| ($)) (|f| (S)))
               (SEQ (LETT |p| |l|)
                    (SEQ G190 (COND ((NULL (NULL (NULL |p|))) (GO G191)))
                         (SEQ (LETT |pp| |p|) (LETT |f| (QCAR |p|))
                              (LETT |p| (QCDR |p|))
                              (EXIT
                               (SEQ G190
                                    (COND
                                     ((NULL
                                       (NULL (NULL (LETT |pr| (QCDR |pp|)))))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL (QCAR |pr|) |f|
                                                  (QREFELT $ 56))
                                        (|qset_rest| |pp| (QCDR |pr|)))
                                       ('T (LETT |pp| |pr|)))))
                                    NIL (GO G190) G191 (EXIT NIL))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |l|)))) 

(SDEFUN |LIST;sort!;M2$;34|
        ((|f| (|Mapping| (|Boolean|) S S)) (|l| ($)) ($ ($)))
        (|LIST;mergeSort| |f| |l| (LENGTH |l|) $)) 

(SDEFUN |LIST;merge!;M3$;35|
        ((|f| (|Mapping| (|Boolean|) S S)) (|p| ($)) (|q| ($)) ($ ($)))
        (SPROG ((|t| ($)) (|r| ($)))
               (SEQ
                (COND ((NULL |p|) |q|) ((NULL |q|) |p|)
                      ((EQ |p| |q|)
                       (|error| "cannot merge a list into itself"))
                      (#1='T
                       (SEQ
                        (COND
                         ((SPADCALL (QCAR |p|) (QCAR |q|) |f|)
                          (SEQ (LETT |r| (LETT |t| |p|))
                               (EXIT (LETT |p| (QCDR |p|)))))
                         (#1#
                          (SEQ (LETT |r| (LETT |t| |q|))
                               (EXIT (LETT |q| (QCDR |q|))))))
                        (SEQ G190
                             (COND
                              ((NULL
                                (COND ((NULL |p|) NIL) ('T (NULL (NULL |q|)))))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL (QCAR |p|) (QCAR |q|) |f|)
                                 (SEQ (|qset_rest| |t| |p|) (LETT |t| |p|)
                                      (EXIT (LETT |p| (QCDR |p|)))))
                                ('T
                                 (SEQ (|qset_rest| |t| |q|) (LETT |t| |q|)
                                      (EXIT (LETT |q| (QCDR |q|))))))))
                             NIL (GO G190) G191 (EXIT NIL))
                        (|qset_rest| |t| (COND ((NULL |p|) |q|) (#1# |p|)))
                        (EXIT |r|))))))) 

(SDEFUN |LIST;split!;$Nni$;36| ((|p| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((|q| ($)) (#1=#:G2271 NIL))
               (SEQ
                (COND ((< |n| 1) (|error| "index out of range"))
                      ('T
                       (SEQ
                        (LETT |p|
                              (SPADCALL |p|
                                        (PROG1 (LETT #1# (- |n| 1))
                                          (|check_subtype2| (>= #1# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #1#))
                                        (QREFELT $ 36)))
                        (LETT |q| (QCDR |p|)) (|qset_rest| |p| NIL)
                        (EXIT |q|))))))) 

(SDEFUN |LIST;mergeSort|
        ((|f| (|Mapping| (|Boolean|) S S)) (|p| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((|q| ($)) (|l| (|NonNegativeInteger|)) (#1=#:G2275 NIL))
               (SEQ
                (COND
                 ((EQL |n| 2)
                  (COND
                   ((SPADCALL (|SPADfirst| (CDR |p|)) (|SPADfirst| |p|) |f|)
                    (LETT |p| (NREVERSE |p|))))))
                (EXIT
                 (COND ((< |n| 3) |p|)
                       ('T
                        (SEQ
                         (LETT |l|
                               (PROG1 (LETT #1# (QUOTIENT2 |n| 2))
                                 (|check_subtype2| (>= #1# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #1#)))
                         (LETT |q| (SPADCALL |p| |l| (QREFELT $ 69)))
                         (LETT |p| (|LIST;mergeSort| |f| |p| |l| $))
                         (LETT |q| (|LIST;mergeSort| |f| |q| (- |n| |l|) $))
                         (EXIT (SPADCALL |f| |p| |q| (QREFELT $ 68)))))))))) 

(SDEFUN |LIST;append;3$;38| ((|l| ($)) (|t| ($)) ($ ($)))
        (SPADCALL |l| |t| (QREFELT $ 70))) 

(SDEFUN |LIST;tails;$L;39| ((|x| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G2290 NIL) (|i| NIL) (#2=#:G2289 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# (- (LENGTH |x|) 1)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |x| |i| (QREFELT $ 36)) #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |LIST;writeOMList| ((|dev| (|OpenMathDevice|)) (|x| ($)) ($ (|Void|)))
        (SEQ (SPADCALL |dev| (QREFELT $ 75))
             (SPADCALL |dev| "list1" "list" (QREFELT $ 76))
             (SEQ G190 (COND ((NULL (NULL (NULL |x|))) (GO G191)))
                  (SEQ (SPADCALL |dev| (|SPADfirst| |x|) NIL (QREFELT $ 77))
                       (EXIT (LETT |x| (CDR |x|))))
                  NIL (GO G190) G191 (EXIT NIL))
             (EXIT (SPADCALL |dev| (QREFELT $ 78))))) 

(SDEFUN |LIST;OMwrite;Omd$BV;41|
        ((|dev| (|OpenMathDevice|)) (|x| ($)) (|wholeObj| (|Boolean|))
         ($ (|Void|)))
        (SEQ (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 79))))
             (|LIST;writeOMList| |dev| |x| $)
             (EXIT (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 80))))))) 

(SDEFUN |LIST;setUnion;3$;42| ((|l1| ($)) (|l2| ($)) ($ ($)))
        (SPADCALL (SPADCALL |l1| |l2| (QREFELT $ 70)) (QREFELT $ 82))) 

(SDEFUN |LIST;setIntersection;3$;43| ((|l1| ($)) (|l2| ($)) ($ ($)))
        (SPROG ((|u| ($)))
               (SEQ (LETT |u| NIL) (LETT |l1| (SPADCALL |l1| (QREFELT $ 82)))
                    (SEQ G190 (COND ((NULL (NULL (NULL |l1|))) (GO G191)))
                         (SEQ
                          (COND
                           ((SPADCALL (|SPADfirst| |l1|) |l2| (QREFELT $ 57))
                            (LETT |u| (CONS (|SPADfirst| |l1|) |u|))))
                          (EXIT (LETT |l1| (CDR |l1|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |u|)))) 

(SDEFUN |LIST;setDifference;3$;44| ((|l1| ($)) (|l2| ($)) ($ ($)))
        (SPROG ((|lu| ($)) (|l11| (S)))
               (SEQ (LETT |l1| (SPADCALL |l1| (QREFELT $ 82)))
                    (EXIT
                     (COND ((NULL |l2|) |l1|)
                           ('T
                            (SEQ (LETT |lu| NIL)
                                 (SEQ G190
                                      (COND
                                       ((NULL (NULL (NULL |l1|))) (GO G191)))
                                      (SEQ
                                       (LETT |l11|
                                             (SPADCALL |l1| 1 (QREFELT $ 85)))
                                       (COND
                                        ((NULL
                                          (SPADCALL |l11| |l2| (QREFELT $ 57)))
                                         (LETT |lu|
                                               (SPADCALL |l11| |lu|
                                                         (QREFELT $ 10)))))
                                       (EXIT (LETT |l1| (CDR |l1|))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (EXIT |lu|)))))))) 

(SDEFUN |LIST;map!;M2$;45| ((|f| (|Mapping| S S)) (|l| ($)) ($ ($)))
        (SPROG ((|y| ($)))
               (SEQ (LETT |y| |l|)
                    (SEQ G190 (COND ((NULL (NULL (NULL |l|))) (GO G191)))
                         (SEQ
                          (SPADCALL |l| (SPADCALL (|SPADfirst| |l|) |f|)
                                    (QREFELT $ 22))
                          (EXIT (LETT |l| (CDR |l|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |y|)))) 

(SDEFUN |LIST;convert;$If;46| ((|x| ($)) ($ (|InputForm|)))
        (SPROG ((#1=#:G2344 NIL) (|a| NIL) (#2=#:G2343 NIL))
               (SEQ
                (SPADCALL
                 (SPADCALL (SPADCALL '|construct| (QREFELT $ 91))
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |a| NIL) (LETT #1# |x|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |a| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS (SPADCALL |a| (QREFELT $ 92))
                                               #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           (QREFELT $ 94))
                 (QREFELT $ 95))))) 

(DECLAIM (NOTINLINE |List;|)) 

(DEFUN |List| (#1=#:G2357)
  (SPROG NIL
         (PROG (#2=#:G2358)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|List|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|List;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|List|)))))))))) 

(DEFUN |List;| (|#1|)
  (SPROG
   ((#1=#:G2353 NIL) (#2=#:G2354 NIL) (#3=#:G2356 NIL) (#4=#:G2355 NIL)
    (|pv$| NIL) (#5=#:G2350 NIL) (#6=#:G2351 NIL) (#7=#:G2352 NIL) ($ NIL)
    (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|List| DV$1))
    (LETT $ (GETREFV 107))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#1| '(|OpenMath|))
                                        (|HasCategory| |#1| '(|BasicType|))
                                        (LETT #7#
                                              (|HasCategory| |#1|
                                                             '(|Comparable|)))
                                        (OR #7#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|)))
                                        (LETT #6#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #6#)
                                        (OR (|HasCategory| |#1| '(|BasicType|))
                                            #7#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #6#)
                                        (OR #7#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #6#)
                                        (LETT #5#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #5# #7#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #6#)
                                        (|HasCategory| (|Integer|)
                                                       '(|OrderedSet|))))))
    (|haddProp| |$ConstructorCache| '|List| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (LETT #4# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 8192))
    (AND
     (LETT #3#
           (AND (|HasCategory| |#1| '(|OrderedSet|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 16384))
    (AND (OR #5# (AND #7# #4#) #3#) (|augmentPredVector| $ 32768))
    (AND (OR (AND #7# #4#) #3# #6#) (|augmentPredVector| $ 65536))
    (AND (OR (AND #7# #4#) #3#) (|augmentPredVector| $ 131072))
    (AND
     (LETT #2#
           (AND (|HasCategory| |#1| '(|BasicType|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 262144))
    (AND (OR #2# (AND #7# #4#) #3# #6#) (|augmentPredVector| $ 524288))
    (AND (LETT #1# (|HasCategory| $ '(|shallowlyMutable|)))
         (|augmentPredVector| $ 1048576))
    (AND (|HasCategory| |#1| '(|OrderedSet|)) #4# #1#
         (|augmentPredVector| $ 2097152))
    (AND #4# #1# (|augmentPredVector| $ 4194304))
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 11)
      (QSETREFV $ 53 (CONS (|dispatchFunction| |LIST;coerce;$Of;27|) $))))
    (COND
     ((|testBitVector| |pv$| 4)
      (PROGN
       (QSETREFV $ 55 (CONS (|dispatchFunction| |LIST;=;2$B;28|) $))
       (QSETREFV $ 57 (CONS (|dispatchFunction| |LIST;member?;S$B;29|) $)))))
    (COND
     ((|testBitVector| |pv$| 7)
      (PROGN
       (QSETREFV $ 60 (CONS (|dispatchFunction| |LIST;latex;$S;30|) $))
       (QSETREFV $ 63
                 (CONS (|dispatchFunction| |LIST;hashUpdate!;Hs$Hs;31|) $)))))
    (COND
     ((|testBitVector| |pv$| 4)
      (QSETREFV $ 65
                (CONS (|dispatchFunction| |LIST;removeDuplicates!;2$;33|) $))))
    (COND
     ((|testBitVector| |pv$| 3)
      (PROGN
       (QSETREFV $ 81
                 (CONS (|dispatchFunction| |LIST;OMwrite;Omd$BV;41|) $)))))
    (COND
     ((|testBitVector| |pv$| 4)
      (PROGN
       (QSETREFV $ 83 (CONS (|dispatchFunction| |LIST;setUnion;3$;42|) $))
       (QSETREFV $ 84
                 (CONS (|dispatchFunction| |LIST;setIntersection;3$;43|) $))
       (QSETREFV $ 86
                 (CONS (|dispatchFunction| |LIST;setDifference;3$;44|) $)))))
    (COND
     ((|testBitVector| |pv$| 2)
      (QSETREFV $ 96 (CONS (|dispatchFunction| |LIST;convert;$If;46|) $))))
    $))) 

(MAKEPROP '|List| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              |LIST;#;$Nni;1| |LIST;cons;S2$;2| |LIST;concat;S2$;3| (|Boolean|)
              |LIST;eq?;2$B;4| |LIST;first;$S;5| '"first" |LIST;elt;$firstS;6|
              |LIST;empty;$;7| |LIST;empty?;$B;8| |LIST;rest;2$;9| '"rest"
              |LIST;elt;$rest$;10| |LIST;qsetfirst!;$2S;11|
              |LIST;setfirst!;$2S;12| |LIST;setelt!;$first2S;13|
              |LIST;qsetrest!;3$;14| |LIST;setrest!;3$;15|
              |LIST;setelt!;$rest2$;16| (|List| 6) |LIST;construct;2$;17|
              |LIST;parts;2$;18| |LIST;reverse!;2$;19| |LIST;reverse;2$;20|
              (|Integer|) |LIST;minIndex;$I;21| |LIST;maxIndex;$I;22|
              |LIST;first;$Nni$;23| |LIST;rest;$Nni$;24| (0 . |cyclic?|)
              |LIST;copy;2$;25| (5 . |leaf?|) (10 . |value|)
              |LIST;leaves;2$;26| (15 . |cycleEntry|) (|OutputForm|)
              (20 . |coerce|) (|List| 43) (25 . |concat|) (|List| $)
              (31 . |bracket|) (36 . |list|) (41 . |commaSeparate|)
              (46 . |overbar|) (51 . |concat!|) (57 . |coerce|) (62 . ~=)
              (68 . =) (74 . =) (80 . |member?|) (|String|) (86 . |latex|)
              (91 . |latex|) (|HashState|) (96 . |hashUpdate!|)
              (102 . |hashUpdate!|) |LIST;concat!;3$;32|
              (108 . |removeDuplicates!|) (|Mapping| 11 6 6)
              |LIST;sort!;M2$;34| |LIST;merge!;M3$;35| |LIST;split!;$Nni$;36|
              (113 . |concat|) |LIST;append;3$;38| |LIST;tails;$L;39| (|Void|)
              (|OpenMathDevice|) (119 . |OMputApp|) (124 . |OMputSymbol|)
              (131 . |OMwrite|) (138 . |OMputEndApp|) (143 . |OMputObject|)
              (148 . |OMputEndObject|) (153 . |OMwrite|)
              (160 . |removeDuplicates|) (165 . |setUnion|)
              (171 . |setIntersection|) (177 . |elt|) (183 . |setDifference|)
              (|Mapping| 6 6) |LIST;map!;M2$;45| (|Symbol|) (|InputForm|)
              (189 . |convert|) (194 . |convert|) (|List| 90) (199 . |concat|)
              (205 . |convert|) (210 . |convert|) (|Mapping| 6 6 6)
              (|Equation| 6) (|List| 98) (|SingleInteger|) (|Mapping| 11 6)
              (|UniversalSegment| 32) '"last" '"value" (|List| 32)
              (|Union| 6 '"failed"))
           '#(~= 215 |value| 221 |trim| 226 |third| 232 |tails| 237 |tail| 242
              |swap!| 247 |split!| 254 |sorted?| 260 |sort!| 271 |sort| 282
              |smaller?| 293 |size?| 299 |setvalue!| 305 |setrest!| 311
              |setlast!| 317 |setfirst!| 323 |setelt!| 329 |setchildren!| 371
              |setUnion| 377 |setIntersection| 383 |setDifference| 389
              |select!| 395 |select| 401 |second| 407 |sample| 412 |rightTrim|
              416 |reverse!| 422 |reverse| 427 |rest| 432 |removeDuplicates!|
              443 |removeDuplicates| 448 |remove!| 453 |remove| 465 |reduce|
              477 |qsetrest!| 498 |qsetfirst!| 504 |qsetelt!| 510 |qelt| 517
              |possiblyInfinite?| 523 |position| 528 |parts| 547 |nodes| 552
              |node?| 557 |new| 563 |more?| 569 |minIndex| 575 |min| 580
              |merge!| 591 |merge| 604 |members| 617 |member?| 622 |maxIndex|
              628 |max| 633 |map!| 650 |map| 656 |list| 669 |less?| 674
              |leftTrim| 680 |leaves| 686 |leaf?| 691 |latex| 696 |last| 701
              |insert!| 712 |insert| 726 |indices| 740 |index?| 745
              |hashUpdate!| 751 |hash| 757 |first| 762 |find| 773 |fill!| 779
              |explicitlyFinite?| 785 |every?| 790 |eval| 796 |eq?| 822
              |entry?| 828 |entries| 834 |empty?| 839 |empty| 844 |elt| 848
              |distance| 891 |delete!| 897 |delete| 909 |cyclic?| 921
              |cycleTail| 926 |cycleSplit!| 931 |cycleLength| 936 |cycleEntry|
              941 |count| 946 |copyInto!| 958 |copy| 965 |convert| 970
              |construct| 975 |cons| 980 |concat!| 986 |concat| 1003 |coerce|
              1026 |children| 1031 |child?| 1036 |append| 1042 |any?| 1048
              |OMwrite| 1054 >= 1078 > 1084 = 1090 <= 1096 < 1102 |#| 1108)
           'NIL
           (CONS
            (|makeByteWordVec2| 12
                                '(0 0 0 0 0 0 0 0 0 1 0 6 0 0 8 10 0 0 0 0 0 8
                                  9 12 1 2 3))
            (CONS
             '#(|ListAggregate&| |StreamAggregate&|
                |ExtensibleLinearAggregate&| NIL |UnaryRecursiveAggregate&|
                |LinearAggregate&| |RecursiveAggregate&| |IndexedAggregate&|
                |Collection&| |OrderedSet&| |HomogeneousAggregate&| NIL
                |Aggregate&| |EltableAggregate&| |Evalable&| |SetCategory&| NIL
                NIL NIL NIL NIL |InnerEvalable&| |BasicType&| NIL
                |PartialOrder&| NIL |OpenMath&|)
             (CONS
              '#((|ListAggregate| 6) (|StreamAggregate| 6)
                 (|ExtensibleLinearAggregate| 6) (|FiniteLinearAggregate| 6)
                 (|UnaryRecursiveAggregate| 6) (|LinearAggregate| 6)
                 (|RecursiveAggregate| 6) (|IndexedAggregate| 32 6)
                 (|Collection| 6) (|OrderedSet|) (|HomogeneousAggregate| 6)
                 (|Comparable|) (|Aggregate|) (|EltableAggregate| 32 6)
                 (|Evalable| 6) (|SetCategory|) (|shallowlyMutable|)
                 (|finiteAggregate|) (|Eltable| 102 $$) (|Type|)
                 (|Eltable| 32 6) (|InnerEvalable| 6 6) (|BasicType|)
                 (|CoercibleTo| 43) (|PartialOrder|) (|ConvertibleTo| 90)
                 (|OpenMath|))
              (|makeByteWordVec2| 106
                                  '(1 0 11 0 37 1 0 11 0 39 1 0 6 0 40 1 0 0 0
                                    42 1 6 43 0 44 2 45 0 43 0 46 1 43 0 47 48
                                    1 45 0 43 49 1 43 0 47 50 1 43 0 0 51 2 45
                                    0 0 43 52 1 0 43 0 53 2 6 11 0 0 54 2 0 11
                                    0 0 55 2 6 11 0 0 56 2 0 11 6 0 57 1 6 58 0
                                    59 1 0 58 0 60 2 6 61 61 0 62 2 0 61 61 0
                                    63 1 0 0 0 65 2 0 0 0 0 70 1 74 73 0 75 3
                                    74 73 0 58 58 76 3 6 73 74 0 11 77 1 74 73
                                    0 78 1 74 73 0 79 1 74 73 0 80 3 0 73 74 0
                                    11 81 1 0 0 0 82 2 0 0 0 0 83 2 0 0 0 0 84
                                    2 0 6 0 32 85 2 0 0 0 0 86 1 90 0 89 91 1 6
                                    90 0 92 2 93 0 90 0 94 1 90 0 47 95 1 0 90
                                    0 96 2 20 11 0 0 1 1 0 6 0 40 2 19 0 0 6 1
                                    1 0 6 0 1 1 0 47 0 72 1 0 0 0 1 3 21 73 0
                                    32 32 1 2 21 0 0 7 69 1 15 11 0 1 2 14 11
                                    66 0 1 1 22 0 0 1 2 23 0 66 0 67 1 15 0 0 1
                                    2 14 0 66 0 1 2 18 11 0 0 1 2 0 11 0 7 1 2
                                    21 6 0 6 1 2 21 0 0 0 25 2 21 6 0 6 1 2 21
                                    6 0 6 22 3 21 6 0 32 6 1 3 21 6 0 102 6 1 3
                                    21 6 0 103 6 1 3 21 0 0 19 0 26 3 21 6 0 14
                                    6 23 3 21 6 0 104 6 1 2 21 0 0 47 1 2 4 0 0
                                    0 83 2 4 0 0 0 84 2 4 0 0 0 86 2 0 0 101 0
                                    1 2 14 0 101 0 1 1 0 6 0 1 0 0 0 1 2 19 0 0
                                    6 1 1 23 0 0 30 1 14 0 0 31 2 0 0 0 7 36 1
                                    0 0 0 18 1 4 0 0 65 1 19 0 0 82 2 4 0 6 0 1
                                    2 0 0 101 0 1 2 19 0 6 0 1 2 14 0 101 0 1 4
                                    19 6 97 0 6 6 1 3 14 6 97 0 6 1 2 14 6 97 0
                                    1 2 21 0 0 0 24 2 21 6 0 6 21 3 21 6 0 32 6
                                    1 2 0 6 0 32 1 1 0 11 0 1 2 19 32 6 0 1 3
                                    19 32 6 0 32 1 2 14 32 101 0 1 1 14 27 0 29
                                    1 0 47 0 1 2 4 11 0 0 1 2 0 0 7 6 1 2 0 11
                                    0 7 1 1 13 32 0 33 2 15 0 0 0 1 1 15 6 0 1
                                    2 1 0 0 0 1 3 0 0 66 0 0 68 2 15 0 0 0 1 3
                                    14 0 66 0 0 1 1 14 27 0 1 2 19 11 6 0 57 1
                                    13 32 0 34 2 15 0 0 0 1 1 15 6 0 1 2 14 6
                                    66 0 1 2 21 0 87 0 88 3 0 0 97 0 0 1 2 0 0
                                    87 0 1 1 0 0 6 1 2 0 11 0 7 1 2 19 0 0 6 1
                                    1 0 27 0 41 1 0 11 0 39 1 17 58 0 60 2 0 0
                                    0 7 1 1 0 6 0 1 3 0 0 6 0 32 1 3 0 0 0 0 32
                                    1 3 0 0 0 0 32 1 3 0 0 6 0 32 1 1 0 105 0 1
                                    2 0 11 32 0 1 2 17 61 61 0 63 1 17 100 0 1
                                    2 0 0 0 7 35 1 0 6 0 13 2 0 106 101 0 1 2
                                    21 0 0 6 1 1 0 11 0 1 2 14 11 101 0 1 3 8 0
                                    0 6 6 1 3 8 0 0 27 27 1 2 8 0 0 98 1 2 8 0
                                    0 99 1 2 0 11 0 0 12 2 19 11 6 0 1 1 0 27 0
                                    1 1 0 11 0 17 0 0 0 16 2 0 6 0 32 85 3 0 6
                                    0 32 6 1 2 0 0 0 102 1 2 0 6 0 103 1 2 0 0
                                    0 19 20 2 0 6 0 14 15 2 0 6 0 104 1 2 0 32
                                    0 0 1 2 0 0 0 32 1 2 0 0 0 102 1 2 0 0 0 32
                                    1 2 0 0 0 102 1 1 0 11 0 37 1 0 0 0 1 1 21
                                    0 0 1 1 0 7 0 1 1 0 0 0 42 2 19 7 6 0 1 2
                                    14 7 101 0 1 3 23 0 0 0 32 1 1 0 0 0 38 1 2
                                    90 0 96 1 0 0 27 28 2 0 0 6 0 9 1 21 0 47 1
                                    2 0 0 0 6 1 2 0 0 0 0 64 1 0 0 47 1 2 0 0 0
                                    6 1 2 0 0 6 0 10 2 0 0 0 0 70 1 16 43 0 53
                                    1 0 47 0 1 2 4 11 0 0 1 2 0 0 0 0 71 2 14
                                    11 101 0 1 1 3 58 0 1 2 3 73 74 0 1 2 3 58
                                    0 11 1 3 3 73 74 0 11 81 2 15 11 0 0 1 2 15
                                    11 0 0 1 2 20 11 0 0 55 2 15 11 0 0 1 2 15
                                    11 0 0 1 1 14 7 0 8)))))
           '|lookupComplete|)) 


(SDEFUN |SKICOMB;ski;3$;1| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS 1 (CONS |x| |y|))) 

(PUT '|SKICOMB;ski;UT$;2| '|SPADreplace| '(XLAM (|t1|) (CONS 2 |t1|))) 

(SDEFUN |SKICOMB;ski;UT$;2| ((|t1| (UT)) ($ ($))) (CONS 2 |t1|)) 

(SDEFUN |SKICOMB;I;$;3| (($ ($))) (CONS 0 'I)) 

(SDEFUN |SKICOMB;K;$;4| (($ ($))) (CONS 0 'K)) 

(SDEFUN |SKICOMB;S;$;5| (($ ($))) (CONS 0 'S)) 

(SDEFUN |SKICOMB;parseBracketTerm|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| #1#) (#2=#:G753 NIL) (|ch| (|Character|)) (|trm| ($))
          (|r2| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| "(")))
                  (SEQ (|error| "bracket term must start with (")
                       (EXIT
                        (PROGN
                         (LETT #2# (CONS (CONS 0 'I) |p1|))
                         (GO #3=#:G752))))))
                (LETT |p1| (+ |p1| 1))
                (COND
                 ((> |p1| (SPADCALL |t1| (QREFELT $ 15)))
                  (SEQ (|error| "opening but no closing bracket")
                       (EXIT
                        (PROGN (LETT #2# (CONS (CONS 0 'I) |p1|)) (GO #3#))))))
                (LETT |r2| (SPADCALL |t1| |p1| (QREFELT $ 18)))
                (LETT |trm| (QCAR |r2|)) (LETT |p1| (QCDR |r2|))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (COND
                 ((NULL (|eql_SI| |ch| (|STR_to_CHAR| ")")))
                  (SEQ (|error| "can't find closing bracket")
                       (EXIT
                        (PROGN (LETT #2# (CONS (CONS 0 'I) |p1|)) (GO #3#))))))
                (LETT |p1| (+ |p1| 1)) (EXIT (CONS |trm| |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |SKICOMB;parseCombinatorTerm|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG ((#2=#:G759 NIL) (|ch| (|Character|)) (|p1| #1#))
               (SEQ
                (EXIT
                 (SEQ (LETT |p1| |pin|) (LETT |ch| (STR_ELT1 |t1| |p1|))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "I"))
                        (PROGN
                         (LETT #2# (CONS (CONS 0 'I) (+ |p1| 1)))
                         (GO #3=#:G758))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "K"))
                        (PROGN
                         (LETT #2# (CONS (CONS 0 'K) (+ |p1| 1)))
                         (GO #3#))))
                      (COND
                       ((|eql_SI| |ch| (|STR_to_CHAR| "S"))
                        (PROGN
                         (LETT #2# (CONS (CONS 0 'S) (+ |p1| 1)))
                         (GO #3#))))
                      (|error| "invalid combinator")
                      (EXIT (CONS (CONS 0 'I) (+ |p1| 1)))))
                #3# (EXIT #2#)))) 

(SDEFUN |SKICOMB;parseOneTerm|
        ((|t1| (|String|)) (|pin| #1=(|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|p1| #1#) (|res| ($))
          (|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (|r2| (|Record| (|:| |rft| UT) (|:| |pout| (|NonNegativeInteger|))))
          (|ch| (|Character|)) (#2=#:G774 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|) (LETT |res| (CONS 0 'I))
                (LETT |ch| (STR_ELT1 |t1| |p1|))
                (SEQ G190
                     (COND
                      ((NULL (|eql_SI| |ch| (|STR_to_CHAR| " "))) (GO G191)))
                     (SEQ (LETT |p1| (+ |p1| 1))
                          (COND
                           ((> |p1| (SPADCALL |t1| (QREFELT $ 15)))
                            (PROGN
                             (LETT #2# (CONS |res| |p1|))
                             (GO #3=#:G773))))
                          (EXIT (LETT |ch| (STR_ELT1 |t1| |p1|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (COND
                 ((SPADCALL |ch| (QREFELT $ 21))
                  (SEQ
                   (COND
                    ((SPADCALL |ch| (QREFELT $ 22))
                     (SEQ
                      (LETT |r| (|SKICOMB;parseCombinatorTerm| |t1| |p1| $))
                      (LETT |res| (QCAR |r|)) (EXIT (LETT |p1| (QCDR |r|))))))
                   (EXIT
                    (COND
                     ((SPADCALL |ch| (QREFELT $ 23))
                      (SEQ (LETT |r2| (SPADCALL |t1| |p1| (QREFELT $ 24)))
                           (LETT |res| (SPADCALL (QCAR |r2|) (QREFELT $ 9)))
                           (EXIT (LETT |p1| (QCDR |r2|))))))))))
                (COND
                 ((|eql_SI| |ch| (|STR_to_CHAR| "("))
                  (SEQ (LETT |r| (|SKICOMB;parseBracketTerm| |t1| |p1| $))
                       (LETT |res| (QCAR |r|)) (EXIT (LETT |p1| (QCDR |r|))))))
                (EXIT (CONS |res| |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |SKICOMB;parseTerm;SNniR;9|
        ((|t1| (|String|)) (|pin| (|NonNegativeInteger|))
         ($ (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|)))))
        (SPROG
         ((|res| ($)) (#1=#:G800 NIL) (|i| NIL) (|ch| (|Character|))
          (|stck| (|List| $)) (|p1| (|NonNegativeInteger|))
          (|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (#2=#:G799 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |p1| |pin|)
                (LETT |r| (|SKICOMB;parseOneTerm| |t1| |p1| $))
                (LETT |res| (QCAR |r|)) (LETT |p1| (QCDR |r|))
                (COND
                 ((> |p1| (SPADCALL |t1| (QREFELT $ 15)))
                  (PROGN (LETT #2# (CONS |res| |p1|)) (GO #3=#:G798))))
                (LETT |ch| (STR_ELT1 |t1| |p1|)) (LETT |stck| NIL)
                (SEQ G190
                     (COND
                      ((NULL
                        (COND
                         ((OR (SPADCALL |ch| (QREFELT $ 21))
                              (|eql_SI| |ch| (|STR_to_CHAR| " ")))
                          'T)
                         ('T (|eql_SI| |ch| (|STR_to_CHAR| "(")))))
                       (GO G191)))
                     (SEQ (LETT |r| (|SKICOMB;parseOneTerm| |t1| |p1| $))
                          (LETT |p1| (QCDR |r|))
                          (LETT |stck|
                                (SPADCALL |stck| (QCAR |r|) (QREFELT $ 26)))
                          (EXIT
                           (COND
                            ((> |p1| (SPADCALL |t1| (QREFELT $ 15)))
                             (LETT |ch| (|STR_to_CHAR| "*")))
                            ('T (LETT |ch| (STR_ELT1 |t1| |p1|))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (SEQ (LETT |i| 1) (LETT #1# (SPADCALL |stck| (QREFELT $ 27)))
                     G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |res|
                             (SPADCALL |res|
                                       (SPADCALL |stck| |i| (QREFELT $ 28))
                                       (QREFELT $ 8)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS |res| |p1|))))
          #3# (EXIT #2#)))) 

(SDEFUN |SKICOMB;parseSki;S$;10| ((|t1| (|String|)) ($ ($)))
        (SPROG
         ((|r| (|Record| (|:| |rft| $) (|:| |pout| (|NonNegativeInteger|))))
          (#1=#:G801 NIL))
         (SEQ
          (LETT |r|
                (SPADCALL |t1|
                          (PROG1 (LETT #1# (SPADCALL |t1| (QREFELT $ 29)))
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#))
                          (QREFELT $ 18)))
          (EXIT (QCAR |r|))))) 

(SDEFUN |SKICOMB;getChildren;$L;11| ((|n| ($)) ($ (|List| $)))
        (SPROG ((#1=#:G730 NIL) (#2=#:G808 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |n| (QREFELT $ 31))
                    (PROGN (LETT #2# NIL) (GO #3=#:G807))))
                  (EXIT
                   (LIST
                    (QCAR
                     (PROG2 (LETT #1# |n|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |c1| $) (|:| |c2| $))
                                       (|Union| (|:| |lf| (|Symbol|))
                                                (|:| |nd|
                                                     (|Record| (|:| |c1| $)
                                                               (|:| |c2| $)))
                                                (|:| |vr| (QREFELT $ 6)))
                                       #1#)))
                    (QCDR
                     (PROG2 (LETT #1# |n|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 1)
                                       (|Record| (|:| |c1| $) (|:| |c2| $))
                                       (|Union| (|:| |lf| (|Symbol|))
                                                (|:| |nd|
                                                     (|Record| (|:| |c1| $)
                                                               (|:| |c2| $)))
                                                (|:| |vr| (QREFELT $ 6)))
                                       #1#)))))))
                #3# (EXIT #2#)))) 

(SDEFUN |SKICOMB;atom?;$B;12| ((|n| ($)) ($ (|Boolean|)))
        (COND ((QEQCAR |n| 0) 'T) ('T (QEQCAR |n| 2)))) 

(PUT '|SKICOMB;variable?;$B;13| '|SPADreplace| '(XLAM (|n|) (QEQCAR |n| 2))) 

(SDEFUN |SKICOMB;variable?;$B;13| ((|n| ($)) ($ (|Boolean|))) (QEQCAR |n| 2)) 

(SDEFUN |SKICOMB;isI?;$B;14| ((|n| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G823 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((NULL (QEQCAR |n| 0))
                    (PROGN (LETT #1# NIL) (GO #2=#:G822))))
                  (COND ((EQUAL (CDR |n|) 'I) (PROGN (LETT #1# 'T) (GO #2#))))
                  (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |SKICOMB;isK?;$B;15| ((|n| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G831 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((NULL (QEQCAR |n| 0))
                    (PROGN (LETT #1# NIL) (GO #2=#:G830))))
                  (COND ((EQUAL (CDR |n|) 'K) (PROGN (LETT #1# 'T) (GO #2#))))
                  (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |SKICOMB;isS?;$B;16| ((|n| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G839 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((NULL (QEQCAR |n| 0))
                    (PROGN (LETT #1# NIL) (GO #2=#:G838))))
                  (COND ((EQUAL (CDR |n|) 'S) (PROGN (LETT #1# 'T) (GO #2#))))
                  (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |SKICOMB;getVariable;$UT;17| ((|n| ($)) ($ (UT)))
        (SPROG ((#1=#:G842 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 2)
                    (PROGN (LETT #1# (CDR |n|)) (GO #2=#:G841))))
                  (EXIT (SPADCALL " " (QREFELT $ 38)))))
                #2# (EXIT #1#)))) 

(SDEFUN |SKICOMB;freeVariable?;$UTB;18| ((|n| ($)) (|s| (UT)) ($ (|Boolean|)))
        (SPROG ((#1=#:G852 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |n| 2)
                    (COND
                     ((SPADCALL (CDR |n|) |s| (QREFELT $ 40))
                      (PROGN (LETT #1# NIL) (GO #2=#:G851))))))
                  (COND
                   ((QEQCAR |n| 1)
                    (COND
                     ((SPADCALL (QCAR (CDR |n|)) |s| (QREFELT $ 41))
                      (COND
                       ((NULL (SPADCALL (QCDR (CDR |n|)) |s| (QREFELT $ 41)))
                        (PROGN (LETT #1# NIL) (GO #2#)))))
                     ('T (PROGN (LETT #1# NIL) (GO #2#))))))
                  (EXIT 'T)))
                #2# (EXIT #1#)))) 

(SDEFUN |SKICOMB;toString;$S;19| ((|n| ($)) ($ (|String|)))
        (SPROG ((|s| (|String|)))
               (SEQ (LETT |s| "")
                    (COND
                     ((QEQCAR |n| 0)
                      (SEQ (COND ((EQUAL (CDR |n|) 'I) (LETT |s| "I")))
                           (COND ((EQUAL (CDR |n|) 'K) (LETT |s| "K")))
                           (EXIT
                            (COND ((EQUAL (CDR |n|) 'S) (LETT |s| "S")))))))
                    (COND
                     ((QEQCAR |n| 1)
                      (COND
                       ((SPADCALL (QCDR (CDR |n|)) (QREFELT $ 31))
                        (COND
                         ((SPADCALL (QCDR (CDR |n|)) (QREFELT $ 34))
                          (LETT |s|
                                (SPADCALL
                                 (LIST |s|
                                       (SPADCALL (QCAR (CDR |n|))
                                                 (QREFELT $ 42))
                                       " "
                                       (SPADCALL (QCDR (CDR |n|))
                                                 (QREFELT $ 42)))
                                 (QREFELT $ 43))))
                         (#1='T
                          (LETT |s|
                                (SPADCALL
                                 (LIST |s|
                                       (SPADCALL (QCAR (CDR |n|))
                                                 (QREFELT $ 42))
                                       (SPADCALL (QCDR (CDR |n|))
                                                 (QREFELT $ 42)))
                                 (QREFELT $ 43))))))
                       (#1#
                        (LETT |s|
                              (SPADCALL
                               (LIST |s|
                                     (SPADCALL (QCAR (CDR |n|)) (QREFELT $ 42))
                                     "("
                                     (SPADCALL (QCDR (CDR |n|)) (QREFELT $ 42))
                                     ")")
                               (QREFELT $ 43)))))))
                    (COND
                     ((QEQCAR |n| 2)
                      (LETT |s| (SPADCALL (CDR |n|) (QREFELT $ 44)))))
                    (EXIT |s|)))) 

(SDEFUN |SKICOMB;redux1| ((|n| ($)) ($ ($)))
        (SPROG
         ((#1=#:G871 NIL) (|leftleftright| ($)) (|leftleftleft| ($))
          (|leftright| ($)) (|leftleft| ($)) (|right| ($)) (|left| ($)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((QEQCAR |n| 1)
              (SEQ (LETT |left| (|SKICOMB;redux1| (QCAR (CDR |n|)) $))
                   (LETT |right| (|SKICOMB;redux1| (QCDR (CDR |n|)) $))
                   (COND
                    ((SPADCALL |left| (QREFELT $ 35))
                     (PROGN (LETT #1# |right|) (GO #2=#:G870))))
                   (COND
                    ((NULL (QEQCAR |left| 1))
                     (PROGN
                      (LETT #1# (SPADCALL |left| |right| (QREFELT $ 8)))
                      (GO #2#))))
                   (LETT |leftleft| (QCAR (CDR |left|)))
                   (LETT |leftright| (QCDR (CDR |left|)))
                   (COND
                    ((SPADCALL |leftleft| (QREFELT $ 36))
                     (PROGN (LETT #1# |leftright|) (GO #2#))))
                   (COND
                    ((NULL (QEQCAR |leftleft| 1))
                     (PROGN
                      (LETT #1# (SPADCALL |left| |right| (QREFELT $ 8)))
                      (GO #2#))))
                   (LETT |leftleftleft| (QCAR (CDR |leftleft|)))
                   (LETT |leftleftright| (QCDR (CDR |leftleft|)))
                   (COND
                    ((SPADCALL |leftleftleft| (QREFELT $ 37))
                     (PROGN
                      (LETT #1#
                            (SPADCALL
                             (SPADCALL |leftleftright| |right| (QREFELT $ 8))
                             (SPADCALL |leftright| |right| (QREFELT $ 8))
                             (QREFELT $ 8)))
                      (GO #2#))))
                   (EXIT
                    (PROGN
                     (LETT #1# (SPADCALL |left| |right| (QREFELT $ 8)))
                     (GO #2#))))))
            (EXIT |n|)))
          #2# (EXIT #1#)))) 

(SDEFUN |SKICOMB;redux;2$;21| ((|n| ($)) ($ ($)))
        (SPROG
         ((|triesLeft| (|NonNegativeInteger|)) (#1=#:G874 NIL)
          (|thisResult| ($)) (|lastResult| ($)))
         (SEQ (LETT |lastResult| (CONS 0 'I))
              (LETT |thisResult| (|SKICOMB;redux1| |n| $))
              (LETT |triesLeft| 20)
              (SEQ G190
                   (COND
                    ((NULL
                      (COND
                       ((SPADCALL |lastResult| |thisResult| (QREFELT $ 45))
                        (> |triesLeft| 1))
                       ('T NIL)))
                     (GO G191)))
                   (SEQ (LETT |lastResult| |thisResult|)
                        (LETT |thisResult| (|SKICOMB;redux1| |lastResult| $))
                        (LETT |triesLeft|
                              (PROG1 (LETT #1# (- |triesLeft| 1))
                                (|check_subtype2| (>= #1# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #1#)))
                        (EXIT
                         (SPADCALL (SPADCALL |lastResult| (QREFELT $ 47))
                                   (QREFELT $ 49))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |thisResult|)))) 

(SDEFUN |SKICOMB;=;2$B;22| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((#1=#:G892 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((QEQCAR |x| 0)
                    (COND
                     ((QEQCAR |y| 0)
                      (SEQ
                       (COND
                        ((EQUAL (CDR |x|) (CDR |y|))
                         (PROGN (LETT #1# 'T) (GO #2=#:G891))))
                       (EXIT (PROGN (LETT #1# NIL) (GO #2#))))))))
                  (COND
                   ((QEQCAR |x| 2)
                    (COND
                     ((QEQCAR |y| 2)
                      (SEQ
                       (COND
                        ((SPADCALL (CDR |x|) (CDR |y|) (QREFELT $ 40))
                         (PROGN (LETT #1# 'T) (GO #2#))))
                       (EXIT (PROGN (LETT #1# NIL) (GO #2#))))))))
                  (COND
                   ((QEQCAR |x| 1)
                    (COND
                     ((QEQCAR |y| 1)
                      (SEQ
                       (COND
                        ((SPADCALL (QCAR (CDR |x|)) (QCAR (CDR |y|))
                                   (QREFELT $ 51))
                         (COND
                          ((SPADCALL (QCDR (CDR |x|)) (QCDR (CDR |y|))
                                     (QREFELT $ 51))
                           (PROGN (LETT #1# 'T) (GO #2#))))))
                       (EXIT (PROGN (LETT #1# NIL) (GO #2#))))))))
                  (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |SKICOMB;coerce;$Of;23| ((|n| ($)) ($ (|OutputForm|)))
        (SPROG ((|s| (|OutputForm|)))
               (SEQ (LETT |s| (SPADCALL (QREFELT $ 52)))
                    (COND
                     ((QEQCAR |n| 0)
                      (LETT |s| (SPADCALL (CDR |n|) (QREFELT $ 54)))))
                    (COND
                     ((QEQCAR |n| 1)
                      (COND
                       ((SPADCALL (QCDR (CDR |n|)) (QREFELT $ 31))
                        (COND
                         ((SPADCALL (QCDR (CDR |n|)) (QREFELT $ 34))
                          (LETT |s|
                                (SPADCALL
                                 (LIST |s|
                                       (SPADCALL (QCAR (CDR |n|))
                                                 (QREFELT $ 47))
                                       (SPADCALL " " (QREFELT $ 55))
                                       (SPADCALL (QCDR (CDR |n|))
                                                 (QREFELT $ 47)))
                                 (QREFELT $ 56))))
                         (#1='T
                          (LETT |s|
                                (SPADCALL
                                 (LIST |s|
                                       (SPADCALL (QCAR (CDR |n|))
                                                 (QREFELT $ 47))
                                       (SPADCALL (QCDR (CDR |n|))
                                                 (QREFELT $ 47)))
                                 (QREFELT $ 56))))))
                       (#1#
                        (LETT |s|
                              (SPADCALL
                               (LIST |s|
                                     (SPADCALL (QCAR (CDR |n|)) (QREFELT $ 47))
                                     (SPADCALL "(" (QREFELT $ 55))
                                     (SPADCALL (QCDR (CDR |n|)) (QREFELT $ 47))
                                     (SPADCALL ")" (QREFELT $ 55)))
                               (QREFELT $ 56)))))))
                    (COND
                     ((QEQCAR |n| 2)
                      (LETT |s| (SPADCALL (CDR |n|) (QREFELT $ 57)))))
                    (EXIT |s|)))) 

(DECLAIM (NOTINLINE |SKICombinators;|)) 

(DEFUN |SKICombinators| (#1=#:G898)
  (SPROG NIL
         (PROG (#2=#:G899)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|SKICombinators|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|SKICombinators;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|SKICombinators|)))))))))) 

(DEFUN |SKICombinators;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|SKICombinators| DV$1))
          (LETT $ (GETREFV 60))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SKICombinators| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Union| (|:| |lf| (|Symbol|))
                             (|:| |nd| (|Record| (|:| |c1| $) (|:| |c2| $)))
                             (|:| |vr| |#1|)))
          $))) 

(MAKEPROP '|SKICombinators| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| |SKICOMB;ski;3$;1|
              |SKICOMB;ski;UT$;2| |SKICOMB;I;$;3| |SKICOMB;K;$;4|
              |SKICOMB;S;$;5| (|Integer|) (|String|) (0 . |maxIndex|)
              (|Record| (|:| |rft| $) (|:| |pout| 17)) (|NonNegativeInteger|)
              |SKICOMB;parseTerm;SNniR;9| (|Boolean|) (|Character|)
              (5 . |alphabetic?|) (10 . |upperCase?|) (15 . |lowerCase?|)
              (20 . |parseVarTerm|) (|List| $$) (26 . |concat|) (32 . |#|)
              (37 . |elt|) (43 . |minIndex|) |SKICOMB;parseSki;S$;10|
              |SKICOMB;atom?;$B;12| (|List| $) |SKICOMB;getChildren;$L;11|
              |SKICOMB;variable?;$B;13| |SKICOMB;isI?;$B;14|
              |SKICOMB;isK?;$B;15| |SKICOMB;isS?;$B;16| (48 . |var|)
              |SKICOMB;getVariable;$UT;17| (53 . =)
              |SKICOMB;freeVariable?;$UTB;18| |SKICOMB;toString;$S;19|
              (59 . |concat|) (64 . |toString|) (69 . ~=) (|OutputForm|)
              |SKICOMB;coerce;$Of;23| (|Void|) (75 . |print|)
              |SKICOMB;redux;2$;21| |SKICOMB;=;2$B;22| (80 . |empty|)
              (|Symbol|) (84 . |coerce|) (89 . |message|) (94 . |hconcat|)
              (99 . |coerce|) (|SingleInteger|) (|HashState|))
           '#(~= 104 |variable?| 110 |toString| 115 |ski| 120 |redux| 131
              |parseTerm| 136 |parseSki| 142 |latex| 147 |isS?| 152 |isK?| 157
              |isI?| 162 |hashUpdate!| 167 |hash| 173 |getVariable| 178
              |getChildren| 183 |freeVariable?| 188 |coerce| 194 |atom?| 199 S
              204 K 208 I 212 = 216)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 46))
                        (|makeByteWordVec2| 59
                                            '(1 14 13 0 15 1 20 19 0 21 1 20 19
                                              0 22 1 20 19 0 23 2 6 16 14 17 24
                                              2 25 0 0 2 26 1 25 17 0 27 2 25 2
                                              0 13 28 1 14 13 0 29 1 6 0 14 38
                                              2 6 19 0 0 40 1 14 0 32 43 1 6 14
                                              0 44 2 0 19 0 0 45 1 46 48 0 49 0
                                              46 0 52 1 53 46 0 54 1 46 0 14 55
                                              1 46 0 32 56 1 6 46 0 57 2 0 19 0
                                              0 45 1 0 19 0 34 1 0 14 0 42 2 0
                                              0 0 0 8 1 0 0 6 9 1 0 0 0 50 2 0
                                              16 14 17 18 1 0 0 14 30 1 0 14 0
                                              1 1 0 19 0 37 1 0 19 0 36 1 0 19
                                              0 35 2 0 59 59 0 1 1 0 58 0 1 1 0
                                              6 0 39 1 0 32 0 33 2 0 19 0 6 41
                                              1 0 46 0 47 1 0 19 0 31 0 0 0 12
                                              0 0 0 11 0 0 0 10 2 0 19 0 0
                                              51)))))
           '|lookupComplete|)) 

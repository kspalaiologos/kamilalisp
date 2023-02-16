
(SDEFUN |FC;get_assignment|
        ((|name| (|OutputForm|)) (|e| (|OutputForm|))
         (|int_to_floats?| (|Boolean|)) ($ (|List| (|String|))))
        (SPADCALL
         (SPADCALL (SPADCALL '= (QREFELT $ 8)) (LIST |name| |e|)
                   (QREFELT $ 10))
         |int_to_floats?| (QREFELT $ 14))) 

(SDEFUN |FC;format_switch|
        ((|switch1| (|OutputForm|)) (|l| (|List| (|String|)))
         ($ (|List| (|List| (|String|)))))
        (SPROG ((|r| (|List| (|String|))) (|l1| (|List| (|OutputForm|))))
               (SEQ
                (COND
                 ((LISTP |switch1|)
                  (SEQ (LETT |l1| |switch1|)
                       (EXIT
                        (COND
                         ((EQ (|SPADfirst| |l1|) 'NULL)
                          (LETT |switch1| (|SPADfirst| (CDR |l1|)))))))))
                (LETT |r| (NREVERSE (SPADCALL |switch1| (QREFELT $ 15))))
                (SEQ G190
                     (COND
                      ((NULL
                        (COND ((NULL |r|) NIL)
                              ('T (NULL (EQUAL (|SPADfirst| |r|) "%l")))))
                       (GO G191)))
                     (SEQ (LETT |l| (CONS (|SPADfirst| |r|) |l|))
                          (EXIT (LETT |r| (CDR |r|))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (LIST |l| |r|))))) 

(SDEFUN |FC;fortFormatIf1|
        ((|switch1| (|OutputForm|)) (|i| (|Integer|)) (|kind| (|String|))
         ($ (|List| (|String|))))
        (SPROG
         ((|r| NIL) (|#G11| #1=(|List| (|List| (|String|))))
          (|l| (|List| (|String|))) (|#G10| #1#))
         (SEQ (LETT |l| (LIST ")THEN")) (SPADCALL (- |i|) (QREFELT $ 18))
              (PROGN
               (LETT |#G10| (|FC;format_switch| |switch1| |l| $))
               (LETT |#G11| |#G10|)
               (LETT |l| (|SPADfirst| |#G11|))
               (LETT |#G11| (CDR |#G11|))
               (LETT |r| (|SPADfirst| |#G11|))
               |#G10|)
              (SPADCALL |i| (QREFELT $ 18))
              (EXIT
               (NREVERSE
                (SPADCALL (NREVERSE |l|) (CONS |kind| |r|) (QREFELT $ 19))))))) 

(SDEFUN |FC;fortFormatIf| ((|switch1| (|OutputForm|)) ($ (|List| (|String|))))
        (SPROG NIL
               (SPADCALL (CONS #'|FC;fortFormatIf!0| (VECTOR $ |switch1|))
                         (QREFELT $ 21)))) 

(SDEFUN |FC;fortFormatIf!0| (($$ NIL))
        (PROG (|switch1| $)
          (LETT |switch1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|FC;fortFormatIf1| |switch1| 8 "IF(" $))))) 

(SDEFUN |FC;fortFormatElseIf|
        ((|switch1| (|OutputForm|)) ($ (|List| (|String|))))
        (SPROG NIL
               (SPADCALL (CONS #'|FC;fortFormatElseIf!0| (VECTOR $ |switch1|))
                         (QREFELT $ 21)))) 

(SDEFUN |FC;fortFormatElseIf!0| (($$ NIL))
        (PROG (|switch1| $)
          (LETT |switch1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|FC;fortFormatIf1| |switch1| 12 "ELSEIF(" $))))) 

(SDEFUN |FC;fortFormatIfGoto1|
        ((|switch1| (|OutputForm|)) (|lab| (|SingleInteger|))
         ($ (|List| (|String|))))
        (SPROG
         ((|r| NIL) (|#G19| #1=(|List| (|List| (|String|))))
          (|l| (|List| (|String|))) (|#G18| #1#))
         (SEQ (LETT |l| (LIST ")GOTO " (STRINGIMAGE |lab|)))
              (SPADCALL -8 (QREFELT $ 18))
              (PROGN
               (LETT |#G18| (|FC;format_switch| |switch1| |l| $))
               (LETT |#G19| |#G18|)
               (LETT |l| (|SPADfirst| |#G19|))
               (LETT |#G19| (CDR |#G19|))
               (LETT |r| (|SPADfirst| |#G19|))
               |#G18|)
              (SPADCALL 8 (QREFELT $ 18))
              (EXIT
               (NREVERSE
                (SPADCALL (NREVERSE |l|) (CONS "IF(" |r|) (QREFELT $ 19))))))) 

(SDEFUN |FC;fortFormatIfGoto|
        ((|switch1| (|OutputForm|)) (|lab| (|SingleInteger|))
         ($ (|List| (|String|))))
        (SPROG NIL
               (SPADCALL
                (CONS #'|FC;fortFormatIfGoto!0| (VECTOR $ |lab| |switch1|))
                (QREFELT $ 21)))) 

(SDEFUN |FC;fortFormatIfGoto!0| (($$ NIL))
        (PROG (|switch1| |lab| $)
          (LETT |switch1| (QREFELT $$ 2))
          (LETT |lab| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|FC;fortFormatIfGoto1| |switch1| |lab| $))))) 

(SDEFUN |FC;fortFormatLabelledIfGoto1|
        ((|switch1| (|OutputForm|)) (|lab1| (|SingleInteger|))
         (|lab2| (|SingleInteger|)) ($ (|List| (|String|))))
        (SPROG ((|l| (|List| (|String|))) (|labString| (|String|)) (|i| NIL))
               (SEQ (LETT |l| (|FC;fortFormatIfGoto1| |switch1| |lab2| $))
                    (LETT |labString| (STRINGIMAGE |lab1|))
                    (SEQ (LETT |i| (QCSIZE |labString|)) G190
                         (COND ((> |i| 5) (GO G191)))
                         (SEQ
                          (EXIT (LETT |labString| (STRCONC |labString| " "))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                    (LETT |l| (SPADCALL |l| (QREFELT $ 22)))
                    (EXIT
                     (CONS
                      (STRCONC |labString|
                               (SPADCALL (|SPADfirst| |l|)
                                         (SPADCALL 7 (QREFELT $ 24))
                                         (QREFELT $ 26)))
                      (CDR |l|)))))) 

(SDEFUN |FC;fortFormatLabelledIfGoto|
        ((|switch1| (|OutputForm|)) (|lab1| (|SingleInteger|))
         (|lab2| (|SingleInteger|)) ($ (|List| (|String|))))
        (|FC;fortFormatLabelledIfGoto1| |switch1| |lab1| |lab2| $)) 

(SDEFUN |FC;getfortarrayexp1|
        ((|name| (|Symbol|)) (|of| (|OutputForm|))
         (|int_to_floats?| (|Boolean|)) ($ (|List| (|String|))))
        (SPROG ((#1=#:G755 NIL) (|l| (|List| (|String|))))
               (SEQ
                (LETT |l|
                      (SPADCALL (CONS #'|FC;getfortarrayexp1!0| |name|) |of|
                                |int_to_floats?| (QREFELT $ 28)))
                (EXIT
                 (SPADCALL |l|
                           (PROG1 (LETT #1# (- (LENGTH |l|) 2))
                             (|check_subtype2| (>= #1# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #1#))
                           (QREFELT $ 30)))))) 

(SDEFUN |FC;getfortarrayexp1!0| ((|name| NIL)) |name|) 

(SDEFUN |FC;getfortarrayexp|
        ((|name| (|Symbol|)) (|of| (|OutputForm|))
         (|int_to_floats?| (|Boolean|)) ($ (|List| (|String|))))
        (SPROG NIL
               (SPADCALL |int_to_floats?|
                         (CONS #'|FC;getfortarrayexp!0|
                               (VECTOR $ |int_to_floats?| |of| |name|))
                         (QREFELT $ 31)))) 

(SDEFUN |FC;getfortarrayexp!0| (($$ NIL))
        (PROG (|name| |of| |int_to_floats?| $)
          (LETT |name| (QREFELT $$ 3))
          (LETT |of| (QREFELT $$ 2))
          (LETT |int_to_floats?| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|FC;getfortarrayexp1| |name| |of| |int_to_floats?| $))))) 

(SDEFUN |FC;fortFormatDo1|
        ((|var1| (|Symbol|)) (|lo| (|OutputForm|)) (|hi| (|OutputForm|))
         (|incr| (|OutputForm|)) (|lab| (|SingleInteger|))
         ($ (|List| (|String|))))
        (SPROG
         ((|il| (|List| (|String|))) (|incl| (|List| (|String|)))
          (|hil| #1=(|List| (|String|))) (|lol| #1#))
         (SEQ (LETT |lol| (SPADCALL |lo| (QREFELT $ 15)))
              (LETT |hil| (SPADCALL |hi| (QREFELT $ 15)))
              (LETT |incl|
                    (COND
                     ((EQUAL |incr| 1)
                      (CONS "," (SPADCALL |incr| (QREFELT $ 15))))
                     ('T NIL)))
              (LETT |il|
                    (SPADCALL |lol|
                              (CONS "," (SPADCALL |hil| |incl| (QREFELT $ 19)))
                              (QREFELT $ 19)))
              (EXIT
               (SPADCALL
                (LIST "DO " (STRINGIMAGE |lab|) " "
                      (SPADCALL |var1| (QREFELT $ 32)) "=")
                |il| (QREFELT $ 19)))))) 

(SDEFUN |FC;fortFormatDo|
        ((|var1| (|Symbol|)) (|lo| (|OutputForm|)) (|hi| (|OutputForm|))
         (|inc| (|OutputForm|)) (|lab| (|SingleInteger|))
         ($ (|List| (|String|))))
        (SPROG NIL
               (SPADCALL NIL
                         (CONS #'|FC;fortFormatDo!0|
                               (VECTOR $ |lab| |inc| |hi| |lo| |var1|))
                         (QREFELT $ 31)))) 

(SDEFUN |FC;fortFormatDo!0| (($$ NIL))
        (PROG (|var1| |lo| |hi| |inc| |lab| $)
          (LETT |var1| (QREFELT $$ 5))
          (LETT |lo| (QREFELT $$ 4))
          (LETT |hi| (QREFELT $$ 3))
          (LETT |inc| (QREFELT $$ 2))
          (LETT |lab| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|FC;fortFormatDo1| |var1| |lo| |hi| |inc| |lab| $))))) 

(SDEFUN |FC;addCommas| ((|l| (|List| (|Symbol|))) ($ (|List| (|String|))))
        (SPROG ((|r| (|List| (|String|))) (#1=#:G771 NIL) (|e| NIL))
               (SEQ
                (COND ((NULL |l|) NIL)
                      ('T
                       (SEQ
                        (LETT |r|
                              (LIST
                               (SPADCALL (|SPADfirst| |l|) (QREFELT $ 32))))
                        (SEQ (LETT |e| NIL) (LETT #1# (CDR |l|)) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |r|
                                     (CONS (SPADCALL |e| (QREFELT $ 32))
                                           (CONS "," |r|)))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT (NREVERSE |r|)))))))) 

(SDEFUN |FC;setLabelValue;2Si;15|
        ((|u| (|SingleInteger|)) ($ (|SingleInteger|))) (SETELT $ 34 |u|)) 

(SDEFUN |FC;newLabel| (($ (|SingleInteger|)))
        (SEQ (SETELT $ 34 (|add_SI| (QREFELT $ 34) 1)) (EXIT (QREFELT $ 34)))) 

(SDEFUN |FC;commaSep| ((|l| (|List| (|String|))) ($ (|List| (|String|))))
        (SPROG
         ((#1=#:G786 NIL) (#2=#:G785 #3=(|List| (|String|))) (#4=#:G787 #3#)
          (#5=#:G789 NIL) (|u| NIL))
         (SEQ
          (CONS (SPADCALL |l| 1 (QREFELT $ 39))
                (PROGN
                 (LETT #1# NIL)
                 (SEQ (LETT |u| NIL) (LETT #5# (CDR |l|)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |u| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #4# (LIST "," |u|))
                         (COND
                          (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 19))))
                          ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (COND (#1# #2#) ('T NIL))))))) 

(SDEFUN |FC;getReturn|
        ((|rec|
          (|Record| (|:| |empty?| (|Boolean|))
                    (|:| |value|
                         (|Record| (|:| |ints2Floats?| (|Boolean|))
                                   (|:| |expr| (|OutputForm|))))))
         ($ (|List| (|String|))))
        (SPROG
         ((|rv| (|OutputForm|))
          (|rt|
           (|Record| (|:| |ints2Floats?| (|Boolean|))
                     (|:| |expr| (|OutputForm|))))
          (|returnToken| (|OutputForm|)))
         (SEQ (LETT |returnToken| (SPADCALL 'RETURN (QREFELT $ 8)))
              (EXIT
               (COND ((QCAR |rec|) (SPADCALL |returnToken| NIL (QREFELT $ 14)))
                     ('T
                      (SEQ (LETT |rt| (QCDR |rec|)) (LETT |rv| (QCDR |rt|))
                           (EXIT
                            (SPADCALL
                             (SPADCALL |returnToken| (LIST |rv|)
                                       (QREFELT $ 10))
                             (QCAR |rt|) (QREFELT $ 14)))))))))) 

(SDEFUN |FC;getStop| (($ (|List| (|String|))))
        (SPADCALL (LIST "STOP") (QREFELT $ 22))) 

(SDEFUN |FC;getSave| (($ (|List| (|String|))))
        (SPADCALL (LIST "SAVE") (QREFELT $ 22))) 

(SDEFUN |FC;getCommon|
        ((|u|
          (|Record| (|:| |name| (|Symbol|))
                    (|:| |contents| (|List| (|Symbol|)))))
         ($ (|List| (|String|))))
        (SPADCALL
         (SPADCALL
          (LIST "COMMON" " /" (SPADCALL (QCAR |u|) (QREFELT $ 32)) "/ ")
          (|FC;addCommas| (QCDR |u|) $) (QREFELT $ 19))
         (QREFELT $ 22))) 

(SDEFUN |FC;getPrint| ((|l| (|List| (|OutputForm|))) ($ (|List| (|String|))))
        (SPROG ((|ll| (|List| (|String|))) (#1=#:G802 NIL) (|i| NIL))
               (SEQ (LETT |ll| (LIST "PRINT*"))
                    (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |ll|
                                 (SPADCALL |ll|
                                           (CONS ","
                                                 (SPADCALL |i| (QREFELT $ 40)))
                                           (QREFELT $ 19)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |ll| (QREFELT $ 22)))))) 

(SDEFUN |FC;getBlock| ((|rec| (|List| $)) ($ (|List| (|String|))))
        (SPROG ((|expr| (|List| (|String|))) (#1=#:G807 NIL) (|u| NIL))
               (SEQ (SPADCALL 1 (QREFELT $ 41)) (LETT |expr| NIL)
                    (SEQ (LETT |u| NIL) (LETT #1# |rec|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |u| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |expr|
                                 (SPADCALL |expr| (SPADCALL |u| (QREFELT $ 42))
                                           (QREFELT $ 19)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (SPADCALL -1 (QREFELT $ 41)) (EXIT |expr|)))) 

(SDEFUN |FC;getBody| ((|f| ($)) ($ (|List| (|String|))))
        (SPROG ((|expr| (|List| (|String|))))
               (SEQ
                (COND
                 ((QEQCAR (SPADCALL |f| (QREFELT $ 44)) 4)
                  (SPADCALL |f| (QREFELT $ 42)))
                 ('T
                  (SEQ (SPADCALL 1 (QREFELT $ 41))
                       (LETT |expr| (SPADCALL |f| (QREFELT $ 42)))
                       (SPADCALL -1 (QREFELT $ 41)) (EXIT |expr|))))))) 

(SDEFUN |FC;getElseIf| ((|f| ($)) ($ (|List| (|String|))))
        (SPROG
         ((|expr| (|List| (|String|))) (|elseBranch| ($)) (#1=#:G835 NIL)
          (|rec|
           (|Union| (|:| |nullBranch| #2="null")
                    (|:| |assignmentBranch|
                         (|Record| (|:| |var| (|Symbol|))
                                   (|:| |arrayIndex|
                                        (|List| (|Polynomial| (|Integer|))))
                                   (|:| |rand|
                                        (|Record|
                                         (|:| |ints2Floats?| (|Boolean|))
                                         (|:| |expr| (|OutputForm|))))))
                    (|:| |arrayAssignmentBranch|
                         (|Record| (|:| |var| (|Symbol|))
                                   (|:| |rand| (|OutputForm|))
                                   (|:| |ints2Floats?| (|Boolean|))))
                    (|:| |conditionalBranch|
                         (|Record| (|:| |switch| (|Switch|))
                                   (|:| |thenClause| $) (|:| |elseClause| $)))
                    (|:| |returnBranch|
                         (|Record| (|:| |empty?| (|Boolean|))
                                   (|:| |value|
                                        (|Record|
                                         (|:| |ints2Floats?| (|Boolean|))
                                         (|:| |expr| (|OutputForm|))))))
                    (|:| |blockBranch| (|List| $))
                    (|:| |commentBranch| (|List| (|String|)))
                    (|:| |callBranch| (|String|))
                    (|:| |forBranch|
                         (|Record|
                          (|:| |range|
                               (|SegmentBinding| (|Polynomial| (|Integer|))))
                          (|:| |span| (|Polynomial| (|Integer|)))
                          (|:| |body| $)))
                    (|:| |labelBranch| (|SingleInteger|))
                    (|:| |loopBranch|
                         (|Record| (|:| |switch| (|Switch|)) (|:| |body| $)))
                    (|:| |commonBranch|
                         (|Record| (|:| |name| (|Symbol|))
                                   (|:| |contents| (|List| (|Symbol|)))))
                    (|:| |printBranch| (|List| (|OutputForm|))))))
         (SEQ (LETT |rec| (SPADCALL |f| (QREFELT $ 54)))
              (LETT |expr|
                    (|FC;fortFormatElseIf|
                     (SPADCALL
                      (QVELT
                       (PROG2 (LETT #1# |rec|)
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 3)
                                         (|Record| (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $))
                                         (|Union| (|:| |nullBranch| #2#)
                                                  (|:| |assignmentBranch|
                                                       (|Record|
                                                        (|:| |var| (|Symbol|))
                                                        (|:| |arrayIndex|
                                                             (|List|
                                                              (|Polynomial|
                                                               (|Integer|))))
                                                        (|:| |rand|
                                                             (|Record|
                                                              (|:|
                                                               |ints2Floats?|
                                                               (|Boolean|))
                                                              (|:| |expr|
                                                                   (|OutputForm|))))))
                                                  (|:| |arrayAssignmentBranch|
                                                       (|Record|
                                                        (|:| |var| (|Symbol|))
                                                        (|:| |rand|
                                                             (|OutputForm|))
                                                        (|:| |ints2Floats?|
                                                             (|Boolean|))))
                                                  (|:| |conditionalBranch|
                                                       (|Record|
                                                        (|:| |switch|
                                                             (|Switch|))
                                                        (|:| |thenClause| $)
                                                        (|:| |elseClause| $)))
                                                  (|:| |returnBranch|
                                                       (|Record|
                                                        (|:| |empty?|
                                                             (|Boolean|))
                                                        (|:| |value|
                                                             (|Record|
                                                              (|:|
                                                               |ints2Floats?|
                                                               (|Boolean|))
                                                              (|:| |expr|
                                                                   (|OutputForm|))))))
                                                  (|:| |blockBranch|
                                                       (|List| $))
                                                  (|:| |commentBranch|
                                                       (|List| (|String|)))
                                                  (|:| |callBranch| (|String|))
                                                  (|:| |forBranch|
                                                       (|Record|
                                                        (|:| |range|
                                                             (|SegmentBinding|
                                                              (|Polynomial|
                                                               (|Integer|))))
                                                        (|:| |span|
                                                             (|Polynomial|
                                                              (|Integer|)))
                                                        (|:| |body| $)))
                                                  (|:| |labelBranch|
                                                       (|SingleInteger|))
                                                  (|:| |loopBranch|
                                                       (|Record|
                                                        (|:| |switch|
                                                             (|Switch|))
                                                        (|:| |body| $)))
                                                  (|:| |commonBranch|
                                                       (|Record|
                                                        (|:| |name| (|Symbol|))
                                                        (|:| |contents|
                                                             (|List|
                                                              (|Symbol|)))))
                                                  (|:| |printBranch|
                                                       (|List|
                                                        (|OutputForm|))))
                                         #1#))
                       0)
                      (QREFELT $ 56))
                     $))
              (LETT |expr|
                    (SPADCALL |expr|
                              (|FC;getBody|
                               (QVELT
                                (PROG2 (LETT #1# |rec|)
                                    (QCDR #1#)
                                  (|check_union2| (QEQCAR #1# 3)
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $))
                                                  (|Union|
                                                   (|:| |nullBranch| #2#)
                                                   (|:| |assignmentBranch|
                                                        (|Record|
                                                         (|:| |var| (|Symbol|))
                                                         (|:| |arrayIndex|
                                                              (|List|
                                                               (|Polynomial|
                                                                (|Integer|))))
                                                         (|:| |rand|
                                                              (|Record|
                                                               (|:|
                                                                |ints2Floats?|
                                                                (|Boolean|))
                                                               (|:| |expr|
                                                                    (|OutputForm|))))))
                                                   (|:| |arrayAssignmentBranch|
                                                        (|Record|
                                                         (|:| |var| (|Symbol|))
                                                         (|:| |rand|
                                                              (|OutputForm|))
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))))
                                                   (|:| |conditionalBranch|
                                                        (|Record|
                                                         (|:| |switch|
                                                              (|Switch|))
                                                         (|:| |thenClause| $)
                                                         (|:| |elseClause| $)))
                                                   (|:| |returnBranch|
                                                        (|Record|
                                                         (|:| |empty?|
                                                              (|Boolean|))
                                                         (|:| |value|
                                                              (|Record|
                                                               (|:|
                                                                |ints2Floats?|
                                                                (|Boolean|))
                                                               (|:| |expr|
                                                                    (|OutputForm|))))))
                                                   (|:| |blockBranch|
                                                        (|List| $))
                                                   (|:| |commentBranch|
                                                        (|List| (|String|)))
                                                   (|:| |callBranch|
                                                        (|String|))
                                                   (|:| |forBranch|
                                                        (|Record|
                                                         (|:| |range|
                                                              (|SegmentBinding|
                                                               (|Polynomial|
                                                                (|Integer|))))
                                                         (|:| |span|
                                                              (|Polynomial|
                                                               (|Integer|)))
                                                         (|:| |body| $)))
                                                   (|:| |labelBranch|
                                                        (|SingleInteger|))
                                                   (|:| |loopBranch|
                                                        (|Record|
                                                         (|:| |switch|
                                                              (|Switch|))
                                                         (|:| |body| $)))
                                                   (|:| |commonBranch|
                                                        (|Record|
                                                         (|:| |name|
                                                              (|Symbol|))
                                                         (|:| |contents|
                                                              (|List|
                                                               (|Symbol|)))))
                                                   (|:| |printBranch|
                                                        (|List|
                                                         (|OutputForm|))))
                                                  #1#))
                                1)
                               $)
                              (QREFELT $ 19)))
              (LETT |elseBranch|
                    (QVELT
                     (PROG2 (LETT #1# |rec|)
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 3)
                                       (|Record| (|:| |switch| (|Switch|))
                                                 (|:| |thenClause| $)
                                                 (|:| |elseClause| $))
                                       (|Union| (|:| |nullBranch| #2#)
                                                (|:| |assignmentBranch|
                                                     (|Record|
                                                      (|:| |var| (|Symbol|))
                                                      (|:| |arrayIndex|
                                                           (|List|
                                                            (|Polynomial|
                                                             (|Integer|))))
                                                      (|:| |rand|
                                                           (|Record|
                                                            (|:| |ints2Floats?|
                                                                 (|Boolean|))
                                                            (|:| |expr|
                                                                 (|OutputForm|))))))
                                                (|:| |arrayAssignmentBranch|
                                                     (|Record|
                                                      (|:| |var| (|Symbol|))
                                                      (|:| |rand|
                                                           (|OutputForm|))
                                                      (|:| |ints2Floats?|
                                                           (|Boolean|))))
                                                (|:| |conditionalBranch|
                                                     (|Record|
                                                      (|:| |switch| (|Switch|))
                                                      (|:| |thenClause| $)
                                                      (|:| |elseClause| $)))
                                                (|:| |returnBranch|
                                                     (|Record|
                                                      (|:| |empty?|
                                                           (|Boolean|))
                                                      (|:| |value|
                                                           (|Record|
                                                            (|:| |ints2Floats?|
                                                                 (|Boolean|))
                                                            (|:| |expr|
                                                                 (|OutputForm|))))))
                                                (|:| |blockBranch| (|List| $))
                                                (|:| |commentBranch|
                                                     (|List| (|String|)))
                                                (|:| |callBranch| (|String|))
                                                (|:| |forBranch|
                                                     (|Record|
                                                      (|:| |range|
                                                           (|SegmentBinding|
                                                            (|Polynomial|
                                                             (|Integer|))))
                                                      (|:| |span|
                                                           (|Polynomial|
                                                            (|Integer|)))
                                                      (|:| |body| $)))
                                                (|:| |labelBranch|
                                                     (|SingleInteger|))
                                                (|:| |loopBranch|
                                                     (|Record|
                                                      (|:| |switch| (|Switch|))
                                                      (|:| |body| $)))
                                                (|:| |commonBranch|
                                                     (|Record|
                                                      (|:| |name| (|Symbol|))
                                                      (|:| |contents|
                                                           (|List|
                                                            (|Symbol|)))))
                                                (|:| |printBranch|
                                                     (|List| (|OutputForm|))))
                                       #1#))
                     2))
              (COND
               ((NULL (QEQCAR (SPADCALL |elseBranch| (QREFELT $ 44)) 0))
                (EXIT
                 (COND
                  ((QEQCAR (SPADCALL |elseBranch| (QREFELT $ 44)) 2)
                   (SPADCALL |expr| (|FC;getElseIf| |elseBranch| $)
                             (QREFELT $ 19)))
                  ('T
                   (SEQ
                    (LETT |expr|
                          (SPADCALL |expr|
                                    (SPADCALL (SPADCALL 'ELSE (QREFELT $ 8))
                                              NIL (QREFELT $ 14))
                                    (QREFELT $ 19)))
                    (EXIT
                     (LETT |expr|
                           (SPADCALL |expr| (|FC;getBody| |elseBranch| $)
                                     (QREFELT $ 19))))))))))
              (EXIT |expr|)))) 

(SDEFUN |FC;getContinue| ((|label| (|SingleInteger|)) ($ (|List| (|String|))))
        (SPROG
         ((|sp| (|OutputForm|)) (|cnt| (#1="CONTINUE")) (|lab| (|String|)))
         (SEQ (LETT |lab| (STRINGIMAGE |label|))
              (COND ((> (QCSIZE |lab|) 6) (|error| "Label too big")))
              (LETT |cnt| #1#)
              (LETT |sp|
                    (SPADCALL (- (SPADCALL (QREFELT $ 57)) (QCSIZE |lab|))
                              (QREFELT $ 58)))
              (EXIT (STRCONC |lab| |sp| |cnt|))))) 

(SDEFUN |FC;getGoto| ((|label| (|SingleInteger|)) ($ (|List| (|String|))))
        (SPADCALL (LIST (STRCONC "GOTO " (STRINGIMAGE |label|)))
                  (QREFELT $ 22))) 

(SDEFUN |FC;getRepeat|
        ((|repRec| (|Record| (|:| |switch| (|Switch|)) (|:| |body| $)))
         ($ (|List| (|String|))))
        (SPROG ((|bod| ($)) (|lab| (|SingleInteger|)) (|sw| (|Switch|)))
               (SEQ (LETT |sw| (SPADCALL (QCAR |repRec|) (QREFELT $ 59)))
                    (LETT |lab| (|FC;newLabel| $)) (LETT |bod| (QCDR |repRec|))
                    (EXIT
                     (SPADCALL (|FC;getContinue| |lab| $)
                               (SPADCALL (|FC;getBody| |bod| $)
                                         (|FC;fortFormatIfGoto|
                                          (SPADCALL |sw| (QREFELT $ 56)) |lab|
                                          $)
                                         (QREFELT $ 19))
                               (QREFELT $ 19)))))) 

(SDEFUN |FC;getWhile|
        ((|whileRec| (|Record| (|:| |switch| (|Switch|)) (|:| |body| $)))
         ($ (|List| (|String|))))
        (SPROG
         ((|rl1| (|List| (|List| (|String|)))) (|ig| (|List| (|String|)))
          (|bod| ($)) (|lab2| #1=(|SingleInteger|)) (|lab1| #1#)
          (|sw| (|Switch|)))
         (SEQ (LETT |sw| (SPADCALL (QCAR |whileRec|) (QREFELT $ 59)))
              (LETT |lab1| (|FC;newLabel| $)) (LETT |lab2| (|FC;newLabel| $))
              (LETT |bod| (QCDR |whileRec|))
              (LETT |ig|
                    (|FC;fortFormatLabelledIfGoto|
                     (SPADCALL |sw| (QREFELT $ 56)) |lab1| |lab2| $))
              (LETT |rl1|
                    (LIST |ig| (|FC;getBody| |bod| $)
                          (|FC;getBody| (SPADCALL |lab1| (QREFELT $ 60)) $)
                          (|FC;getContinue| |lab2| $)))
              (EXIT (SPADCALL |rl1| (QREFELT $ 61)))))) 

(SDEFUN |FC;getArrayAssign|
        ((|rec|
          (|Record| (|:| |var| (|Symbol|)) (|:| |rand| (|OutputForm|))
                    (|:| |ints2Floats?| (|Boolean|))))
         ($ (|List| (|String|))))
        (|FC;getfortarrayexp| (QVELT |rec| 0) (QVELT |rec| 1) (QVELT |rec| 2)
         $)) 

(SDEFUN |FC;getAssign|
        ((|rec|
          (|Record| (|:| |var| (|Symbol|))
                    (|:| |arrayIndex| (|List| (|Polynomial| (|Integer|))))
                    (|:| |rand|
                         (|Record| (|:| |ints2Floats?| (|Boolean|))
                                   (|:| |expr| (|OutputForm|))))))
         ($ (|List| (|String|))))
        (SPROG
         ((|ex| #1=(|OutputForm|))
          (|ass| (|Record| (|:| |ints2Floats?| (|Boolean|)) (|:| |expr| #1#)))
          (|lhs| (|OutputForm|))
          (|indices| (|List| (|Polynomial| (|Integer|)))))
         (SEQ (LETT |indices| (QVELT |rec| 1))
              (LETT |lhs| (SPADCALL (QVELT |rec| 0) (QREFELT $ 8)))
              (COND
               ((NULL (NULL |indices|))
                (LETT |lhs|
                      (SPADCALL |lhs|
                                (SPADCALL (ELT $ 62) |indices| (QREFELT $ 67))
                                (QREFELT $ 10)))))
              (LETT |ass| (QVELT |rec| 2)) (LETT |ex| (QCDR |ass|))
              (EXIT (|FC;get_assignment| |lhs| |ex| (QCAR |ass|) $))))) 

(SDEFUN |FC;getCond|
        ((|rec|
          (|Record| (|:| |switch| (|Switch|)) (|:| |thenClause| $)
                    (|:| |elseClause| $)))
         ($ (|List| (|String|))))
        (SPROG ((|expr| (|List| (|String|))) (|elseBranch| ($)))
               (SEQ
                (LETT |expr|
                      (SPADCALL
                       (|FC;fortFormatIf|
                        (SPADCALL (QVELT |rec| 0) (QREFELT $ 56)) $)
                       (|FC;getBody| (QVELT |rec| 1) $) (QREFELT $ 19)))
                (LETT |elseBranch| (QVELT |rec| 2))
                (COND
                 ((NULL (QEQCAR (SPADCALL |elseBranch| (QREFELT $ 44)) 0))
                  (COND
                   ((QEQCAR (SPADCALL |elseBranch| (QREFELT $ 44)) 2)
                    (LETT |expr|
                          (SPADCALL |expr| (|FC;getElseIf| |elseBranch| $)
                                    (QREFELT $ 19))))
                   ('T
                    (LETT |expr|
                          (SPADCALL |expr|
                                    (SPADCALL
                                     (SPADCALL (SPADCALL 'ELSE (QREFELT $ 8))
                                               NIL (QREFELT $ 14))
                                     (|FC;getBody| |elseBranch| $)
                                     (QREFELT $ 19))
                                    (QREFELT $ 19)))))))
                (EXIT
                 (SPADCALL |expr|
                           (SPADCALL (SPADCALL 'ENDIF (QREFELT $ 8)) NIL
                                     (QREFELT $ 14))
                           (QREFELT $ 19)))))) 

(SDEFUN |FC;getComment| ((|rec| (|List| (|String|))) ($ (|List| (|String|))))
        (SPROG ((#1=#:G908 NIL) (|c| NIL) (#2=#:G907 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |c| NIL) (LETT #1# |rec|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (STRCONC "C     " |c|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FC;getCall| ((|rec| (|String|)) ($ (|List| (|String|))))
        (SPROG ((|expr| (|String|)))
               (SEQ (LETT |expr| (STRCONC "CALL " |rec|))
                    (EXIT
                     (COND
                      ((> (QCSIZE |expr|) 1320)
                       (|error| "Fortran CALL too large"))
                      ('T (SPADCALL (LIST |expr|) (QREFELT $ 22)))))))) 

(SDEFUN |FC;getFor|
        ((|rec|
          (|Record|
           (|:| |range| #1=(|SegmentBinding| (|Polynomial| (|Integer|))))
           (|:| |span| #2=(|Polynomial| (|Integer|))) (|:| |body| $)))
         ($ (|List| (|String|))))
        (SPROG
         ((|expr| (|List| (|String|))) (|lab| (|SingleInteger|))
          (|increment| #2#) (|rnge| #1#))
         (SEQ (LETT |rnge| (QVELT |rec| 0)) (LETT |increment| (QVELT |rec| 1))
              (LETT |lab| (|FC;newLabel| $))
              (SPADCALL (SPADCALL |rnge| (QREFELT $ 69))
                        (SPADCALL (QREFELT $ 71)) (QREFELT $ 73))
              (LETT |expr|
                    (|FC;fortFormatDo| (SPADCALL |rnge| (QREFELT $ 69))
                     (SPADCALL
                      (SPADCALL (SPADCALL |rnge| (QREFELT $ 75))
                                (QREFELT $ 76))
                      (QREFELT $ 62))
                     (SPADCALL
                      (SPADCALL (SPADCALL |rnge| (QREFELT $ 75))
                                (QREFELT $ 77))
                      (QREFELT $ 62))
                     (SPADCALL |increment| (QREFELT $ 62)) |lab| $))
              (EXIT
               (SPADCALL |expr|
                         (SPADCALL (|FC;getBody| (QVELT |rec| 2) $)
                                   (|FC;getContinue| |lab| $) (QREFELT $ 19))
                         (QREFELT $ 19)))))) 

(SDEFUN |FC;getCode;$L;36| ((|f| ($)) ($ (|List| (|String|))))
        (SPROG
         ((#1=#:G946 NIL) (#2=#:G947 NIL) (#3=#:G945 NIL) (#4=#:G944 NIL)
          (#5=#:G943 NIL) (#6=#:G942 NIL) (#7=#:G941 NIL) (#8=#:G940 NIL)
          (#9=#:G939 NIL) (#10=#:G938 NIL) (#11=#:G937 NIL) (#12=#:G936 NIL)
          (|rec|
           (|Union| (|:| |nullBranch| #13="null")
                    (|:| |assignmentBranch|
                         (|Record| (|:| |var| (|Symbol|))
                                   (|:| |arrayIndex|
                                        (|List| (|Polynomial| (|Integer|))))
                                   (|:| |rand|
                                        (|Record|
                                         (|:| |ints2Floats?| (|Boolean|))
                                         (|:| |expr| (|OutputForm|))))))
                    (|:| |arrayAssignmentBranch|
                         (|Record| (|:| |var| (|Symbol|))
                                   (|:| |rand| (|OutputForm|))
                                   (|:| |ints2Floats?| (|Boolean|))))
                    (|:| |conditionalBranch|
                         (|Record| (|:| |switch| (|Switch|))
                                   (|:| |thenClause| $) (|:| |elseClause| $)))
                    (|:| |returnBranch|
                         (|Record| (|:| |empty?| (|Boolean|))
                                   (|:| |value|
                                        (|Record|
                                         (|:| |ints2Floats?| (|Boolean|))
                                         (|:| |expr| (|OutputForm|))))))
                    (|:| |blockBranch| (|List| $))
                    (|:| |commentBranch| (|List| (|String|)))
                    (|:| |callBranch| (|String|))
                    (|:| |forBranch|
                         (|Record|
                          (|:| |range|
                               (|SegmentBinding| (|Polynomial| (|Integer|))))
                          (|:| |span| (|Polynomial| (|Integer|)))
                          (|:| |body| $)))
                    (|:| |labelBranch| (|SingleInteger|))
                    (|:| |loopBranch|
                         (|Record| (|:| |switch| (|Switch|)) (|:| |body| $)))
                    (|:| |commonBranch|
                         (|Record| (|:| |name| (|Symbol|))
                                   (|:| |contents| (|List| (|Symbol|)))))
                    (|:| |printBranch| (|List| (|OutputForm|)))))
          (|opp|
           (|Union| (|:| |Null| "null") (|:| |Assignment| "assignment")
                    (|:| |Conditional| "conditional") (|:| |Return| "return")
                    (|:| |Block| "block") (|:| |Comment| "comment")
                    (|:| |Call| "call") (|:| |For| "for") (|:| |While| "while")
                    (|:| |Repeat| "repeat") (|:| |Goto| "goto")
                    (|:| |Continue| "continue")
                    (|:| |ArrayAssignment| "arrayAssignment")
                    (|:| |Save| "save") (|:| |Stop| "stop")
                    (|:| |Common| "common") (|:| |Print| "print"))))
         (SEQ (LETT |opp| (SPADCALL |f| (QREFELT $ 44)))
              (LETT |rec| (SPADCALL |f| (QREFELT $ 54)))
              (EXIT
               (COND
                ((QEQCAR |opp| 1)
                 (|FC;getAssign|
                  (PROG2 (LETT #12# |rec|)
                      (QCDR #12#)
                    (|check_union2| (QEQCAR #12# 1)
                                    (|Record| (|:| |var| (|Symbol|))
                                              (|:| |arrayIndex|
                                                   (|List|
                                                    (|Polynomial|
                                                     (|Integer|))))
                                              (|:| |rand|
                                                   (|Record|
                                                    (|:| |ints2Floats?|
                                                         (|Boolean|))
                                                    (|:| |expr|
                                                         (|OutputForm|)))))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #12#))
                  $))
                ((QEQCAR |opp| 12)
                 (|FC;getArrayAssign|
                  (PROG2 (LETT #11# |rec|)
                      (QCDR #11#)
                    (|check_union2| (QEQCAR #11# 2)
                                    (|Record| (|:| |var| (|Symbol|))
                                              (|:| |rand| (|OutputForm|))
                                              (|:| |ints2Floats?| (|Boolean|)))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #11#))
                  $))
                ((QEQCAR |opp| 2)
                 (|FC;getCond|
                  (PROG2 (LETT #10# |rec|)
                      (QCDR #10#)
                    (|check_union2| (QEQCAR #10# 3)
                                    (|Record| (|:| |switch| (|Switch|))
                                              (|:| |thenClause| $)
                                              (|:| |elseClause| $))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #10#))
                  $))
                ((QEQCAR |opp| 3)
                 (|FC;getReturn|
                  (PROG2 (LETT #9# |rec|)
                      (QCDR #9#)
                    (|check_union2| (QEQCAR #9# 4)
                                    (|Record| (|:| |empty?| (|Boolean|))
                                              (|:| |value|
                                                   (|Record|
                                                    (|:| |ints2Floats?|
                                                         (|Boolean|))
                                                    (|:| |expr|
                                                         (|OutputForm|)))))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #9#))
                  $))
                ((QEQCAR |opp| 4)
                 (|FC;getBlock|
                  (PROG2 (LETT #8# |rec|)
                      (QCDR #8#)
                    (|check_union2| (QEQCAR #8# 5) (|List| $)
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #8#))
                  $))
                ((QEQCAR |opp| 5)
                 (|FC;getComment|
                  (PROG2 (LETT #7# |rec|)
                      (QCDR #7#)
                    (|check_union2| (QEQCAR #7# 6) (|List| (|String|))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #7#))
                  $))
                ((QEQCAR |opp| 6)
                 (|FC;getCall|
                  (PROG2 (LETT #6# |rec|)
                      (QCDR #6#)
                    (|check_union2| (QEQCAR #6# 7) (|String|)
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #6#))
                  $))
                ((QEQCAR |opp| 7)
                 (|FC;getFor|
                  (PROG2 (LETT #5# |rec|)
                      (QCDR #5#)
                    (|check_union2| (QEQCAR #5# 8)
                                    (|Record|
                                     (|:| |range|
                                          (|SegmentBinding|
                                           (|Polynomial| (|Integer|))))
                                     (|:| |span| (|Polynomial| (|Integer|)))
                                     (|:| |body| $))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #5#))
                  $))
                ((QEQCAR |opp| 11)
                 (|FC;getContinue|
                  (PROG2 (LETT #4# |rec|)
                      (QCDR #4#)
                    (|check_union2| (QEQCAR #4# 9) (|SingleInteger|)
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #4#))
                  $))
                ((QEQCAR |opp| 10)
                 (|FC;getGoto|
                  (PROG2 (LETT #4# |rec|)
                      (QCDR #4#)
                    (|check_union2| (QEQCAR #4# 9) (|SingleInteger|)
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #4#))
                  $))
                ((QEQCAR |opp| 9)
                 (|FC;getRepeat|
                  (PROG2 (LETT #3# |rec|)
                      (QCDR #3#)
                    (|check_union2| (QEQCAR #3# 10)
                                    (|Record| (|:| |switch| (|Switch|))
                                              (|:| |body| $))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #3#))
                  $))
                ((QEQCAR |opp| 8)
                 (|FC;getWhile|
                  (PROG2 (LETT #3# |rec|)
                      (QCDR #3#)
                    (|check_union2| (QEQCAR #3# 10)
                                    (|Record| (|:| |switch| (|Switch|))
                                              (|:| |body| $))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #3#))
                  $))
                ((QEQCAR |opp| 13) (|FC;getSave| $))
                ((QEQCAR |opp| 14) (|FC;getStop| $))
                ((QEQCAR |opp| 16)
                 (|FC;getPrint|
                  (PROG2 (LETT #2# |rec|)
                      (QCDR #2#)
                    (|check_union2| (QEQCAR #2# 12) (|List| (|OutputForm|))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #2#))
                  $))
                ((QEQCAR |opp| 15)
                 (|FC;getCommon|
                  (PROG2 (LETT #1# |rec|)
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 11)
                                    (|Record| (|:| |name| (|Symbol|))
                                              (|:| |contents|
                                                   (|List| (|Symbol|))))
                                    (|Union| (|:| |nullBranch| #13#)
                                             (|:| |assignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |arrayIndex|
                                                        (|List|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |rand|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |arrayAssignmentBranch|
                                                  (|Record|
                                                   (|:| |var| (|Symbol|))
                                                   (|:| |rand| (|OutputForm|))
                                                   (|:| |ints2Floats?|
                                                        (|Boolean|))))
                                             (|:| |conditionalBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |thenClause| $)
                                                   (|:| |elseClause| $)))
                                             (|:| |returnBranch|
                                                  (|Record|
                                                   (|:| |empty?| (|Boolean|))
                                                   (|:| |value|
                                                        (|Record|
                                                         (|:| |ints2Floats?|
                                                              (|Boolean|))
                                                         (|:| |expr|
                                                              (|OutputForm|))))))
                                             (|:| |blockBranch| (|List| $))
                                             (|:| |commentBranch|
                                                  (|List| (|String|)))
                                             (|:| |callBranch| (|String|))
                                             (|:| |forBranch|
                                                  (|Record|
                                                   (|:| |range|
                                                        (|SegmentBinding|
                                                         (|Polynomial|
                                                          (|Integer|))))
                                                   (|:| |span|
                                                        (|Polynomial|
                                                         (|Integer|)))
                                                   (|:| |body| $)))
                                             (|:| |labelBranch|
                                                  (|SingleInteger|))
                                             (|:| |loopBranch|
                                                  (|Record|
                                                   (|:| |switch| (|Switch|))
                                                   (|:| |body| $)))
                                             (|:| |commonBranch|
                                                  (|Record|
                                                   (|:| |name| (|Symbol|))
                                                   (|:| |contents|
                                                        (|List| (|Symbol|)))))
                                             (|:| |printBranch|
                                                  (|List| (|OutputForm|))))
                                    #1#))
                  $))
                ('T (|error| "Unsupported program construct."))))))) 

(SDEFUN |FC;printCode;$V;37| ((|f| ($)) ($ (|Void|)))
        (SEQ (SPADCALL (SPADCALL |f| (QREFELT $ 42)) (QREFELT $ 78))
             (EXIT (SPADCALL (QREFELT $ 79))))) 

(PUT '|FC;code;$U;38| '|SPADreplace| 'QCDR) 

(SDEFUN |FC;code;$U;38|
        ((|f| ($))
         ($
          (|Union| (|:| |nullBranch| "null")
                   (|:| |assignmentBranch|
                        (|Record| (|:| |var| (|Symbol|))
                                  (|:| |arrayIndex|
                                       (|List| (|Polynomial| (|Integer|))))
                                  (|:| |rand|
                                       (|Record|
                                        (|:| |ints2Floats?| (|Boolean|))
                                        (|:| |expr| (|OutputForm|))))))
                   (|:| |arrayAssignmentBranch|
                        (|Record| (|:| |var| (|Symbol|))
                                  (|:| |rand| (|OutputForm|))
                                  (|:| |ints2Floats?| (|Boolean|))))
                   (|:| |conditionalBranch|
                        (|Record| (|:| |switch| (|Switch|))
                                  (|:| |thenClause| $) (|:| |elseClause| $)))
                   (|:| |returnBranch|
                        (|Record| (|:| |empty?| (|Boolean|))
                                  (|:| |value|
                                       (|Record|
                                        (|:| |ints2Floats?| (|Boolean|))
                                        (|:| |expr| (|OutputForm|))))))
                   (|:| |blockBranch| (|List| $))
                   (|:| |commentBranch| (|List| (|String|)))
                   (|:| |callBranch| (|String|))
                   (|:| |forBranch|
                        (|Record|
                         (|:| |range|
                              (|SegmentBinding| (|Polynomial| (|Integer|))))
                         (|:| |span| (|Polynomial| (|Integer|)))
                         (|:| |body| $)))
                   (|:| |labelBranch| (|SingleInteger|))
                   (|:| |loopBranch|
                        (|Record| (|:| |switch| (|Switch|)) (|:| |body| $)))
                   (|:| |commonBranch|
                        (|Record| (|:| |name| (|Symbol|))
                                  (|:| |contents| (|List| (|Symbol|)))))
                   (|:| |printBranch| (|List| (|OutputForm|))))))
        (QCDR |f|)) 

(PUT '|FC;operation;$U;39| '|SPADreplace| 'QCAR) 

(SDEFUN |FC;operation;$U;39|
        ((|f| ($))
         ($
          (|Union| (|:| |Null| "null") (|:| |Assignment| "assignment")
                   (|:| |Conditional| "conditional") (|:| |Return| "return")
                   (|:| |Block| "block") (|:| |Comment| "comment")
                   (|:| |Call| "call") (|:| |For| "for") (|:| |While| "while")
                   (|:| |Repeat| "repeat") (|:| |Goto| "goto")
                   (|:| |Continue| "continue")
                   (|:| |ArrayAssignment| "arrayAssignment")
                   (|:| |Save| "save") (|:| |Stop| "stop")
                   (|:| |Common| "common") (|:| |Print| "print"))))
        (QCAR |f|)) 

(SDEFUN |FC;common;SL$;40|
        ((|name| (|Symbol|)) (|contents| (|List| (|Symbol|))) ($ ($)))
        (CONS (CONS 15 "common") (CONS 11 (CONS |name| |contents|)))) 

(SDEFUN |FC;stop;$;41| (($ ($))) (CONS (CONS 14 "stop") (CONS 0 "null"))) 

(SDEFUN |FC;save;$;42| (($ ($))) (CONS (CONS 13 "save") (CONS 0 "null"))) 

(SDEFUN |FC;printStatement;L$;43| ((|l| (|List| (|OutputForm|))) ($ ($)))
        (CONS (CONS 16 "print") (CONS 12 |l|))) 

(SDEFUN |FC;comment;L$;44| ((|s| (|List| (|String|))) ($ ($)))
        (CONS (CONS 5 "comment") (CONS 6 |s|))) 

(SDEFUN |FC;comment;S$;45| ((|s| (|String|)) ($ ($)))
        (CONS (CONS 5 "comment") (CONS 6 (SPADCALL |s| (QREFELT $ 87))))) 

(SDEFUN |FC;forLoop;Sb2$;46|
        ((|r| (|SegmentBinding| (|Polynomial| (|Integer|)))) (|body| ($))
         ($ ($)))
        (CONS (CONS 7 "for")
              (CONS 8
                    (VECTOR |r|
                            (SPADCALL
                             (SPADCALL (SPADCALL |r| (QREFELT $ 75))
                                       (QREFELT $ 89))
                             (QREFELT $ 90))
                            |body|)))) 

(SDEFUN |FC;forLoop;SbP2$;47|
        ((|r| (|SegmentBinding| (|Polynomial| (|Integer|))))
         (|increment| (|Polynomial| (|Integer|))) (|body| ($)) ($ ($)))
        (CONS (CONS 7 "for") (CONS 8 (VECTOR |r| |increment| |body|)))) 

(SDEFUN |FC;gotoJump;Si$;48| ((|l| (|SingleInteger|)) ($ ($)))
        (CONS (CONS 10 "goto") (CONS 9 |l|))) 

(SDEFUN |FC;continue;Si$;49| ((|l| (|SingleInteger|)) ($ ($)))
        (CONS (CONS 11 "continue") (CONS 9 |l|))) 

(SDEFUN |FC;whileLoop;S2$;50| ((|sw| (|Switch|)) (|b| ($)) ($ ($)))
        (CONS (CONS 8 "while") (CONS 10 (CONS |sw| |b|)))) 

(SDEFUN |FC;repeatUntilLoop;S2$;51| ((|sw| (|Switch|)) (|b| ($)) ($ ($)))
        (CONS (CONS 9 "repeat") (CONS 10 (CONS |sw| |b|)))) 

(SDEFUN |FC;returns;$;52| (($ ($)))
        (SPROG
         ((|v|
           (|Record| (|:| |ints2Floats?| (|Boolean|))
                     (|:| |expr| (|OutputForm|)))))
         (SEQ
          (LETT |v| (CONS NIL (SPADCALL (|spadConstant| $ 96) (QREFELT $ 62))))
          (EXIT (CONS (CONS 3 "return") (CONS 4 (CONS 'T |v|))))))) 

(SDEFUN |FC;returns;E$;53| ((|v| (|Expression| (|MachineInteger|))) ($ ($)))
        (CONS (CONS 3 "return")
              (CONS 4 (CONS NIL (CONS NIL (SPADCALL |v| (QREFELT $ 99))))))) 

(SDEFUN |FC;returns;E$;54| ((|v| (|Expression| (|MachineFloat|))) ($ ($)))
        (CONS (CONS 3 "return")
              (CONS 4 (CONS NIL (CONS NIL (SPADCALL |v| (QREFELT $ 102))))))) 

(SDEFUN |FC;returns;E$;55| ((|v| (|Expression| (|MachineComplex|))) ($ ($)))
        (CONS (CONS 3 "return")
              (CONS 4 (CONS NIL (CONS NIL (SPADCALL |v| (QREFELT $ 105))))))) 

(SDEFUN |FC;returns;E$;56| ((|v| (|Expression| (|Integer|))) ($ ($)))
        (CONS (CONS 3 "return")
              (CONS 4 (CONS NIL (CONS NIL (SPADCALL |v| (QREFELT $ 108))))))) 

(SDEFUN |FC;returns;E$;57| ((|v| (|Expression| (|Float|))) ($ ($)))
        (CONS (CONS 3 "return")
              (CONS 4 (CONS NIL (CONS NIL (SPADCALL |v| (QREFELT $ 111))))))) 

(SDEFUN |FC;returns;E$;58| ((|v| (|Expression| (|Complex| (|Float|)))) ($ ($)))
        (CONS (CONS 3 "return")
              (CONS 4 (CONS NIL (CONS NIL (SPADCALL |v| (QREFELT $ 114))))))) 

(SDEFUN |FC;block;L$;59| ((|l| (|List| $)) ($ ($)))
        (CONS (CONS 4 "block") (CONS 5 |l|))) 

(SDEFUN |FC;cond;S2$;60| ((|sw| (|Switch|)) (|thenC| ($)) ($ ($)))
        (CONS (CONS 2 "conditional")
              (CONS 3
                    (VECTOR |sw| |thenC|
                            (CONS (CONS 0 "null") (CONS 0 "null")))))) 

(SDEFUN |FC;cond;S3$;61|
        ((|sw| (|Switch|)) (|thenC| ($)) (|elseC| ($)) ($ ($)))
        (CONS (CONS 2 "conditional") (CONS 3 (VECTOR |sw| |thenC| |elseC|)))) 

(SDEFUN |FC;coerce;$Of;62| ((|f| ($)) ($ (|OutputForm|)))
        (SPADCALL (QCAR |f|) (QREFELT $ 119))) 

(SDEFUN |FC;assign;SS$;63| ((|v| (|Symbol|)) (|rhs| (|String|)) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| NIL
                            (CONS NIL (SPADCALL |rhs| (QREFELT $ 121))))))) 

(SDEFUN |FC;assign;SM$;64|
        ((|v| (|Symbol|)) (|rhs| (|Matrix| (|MachineInteger|))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 124)) NIL)))) 

(SDEFUN |FC;assign;SM$;65|
        ((|v| (|Symbol|)) (|rhs| (|Matrix| (|MachineFloat|))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 127)) 'T)))) 

(SDEFUN |FC;assign;SM$;66|
        ((|v| (|Symbol|)) (|rhs| (|Matrix| (|MachineComplex|))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 130)) 'T)))) 

(SDEFUN |FC;assign;SV$;67|
        ((|v| (|Symbol|)) (|rhs| (|Vector| (|MachineInteger|))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 133)) NIL)))) 

(SDEFUN |FC;assign;SV$;68|
        ((|v| (|Symbol|)) (|rhs| (|Vector| (|MachineFloat|))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 136)) 'T)))) 

(SDEFUN |FC;assign;SV$;69|
        ((|v| (|Symbol|)) (|rhs| (|Vector| (|MachineComplex|))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 139)) 'T)))) 

(SDEFUN |FC;assign;SM$;70|
        ((|v| (|Symbol|)) (|rhs| (|Matrix| (|Expression| (|MachineInteger|))))
         ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 142)) NIL)))) 

(SDEFUN |FC;assign;SM$;71|
        ((|v| (|Symbol|)) (|rhs| (|Matrix| (|Expression| (|MachineFloat|))))
         ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 145)) 'T)))) 

(SDEFUN |FC;assign;SM$;72|
        ((|v| (|Symbol|)) (|rhs| (|Matrix| (|Expression| (|MachineComplex|))))
         ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 148)) 'T)))) 

(SDEFUN |FC;assign;SV$;73|
        ((|v| (|Symbol|)) (|rhs| (|Vector| (|Expression| (|MachineInteger|))))
         ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 151)) NIL)))) 

(SDEFUN |FC;assign;SV$;74|
        ((|v| (|Symbol|)) (|rhs| (|Vector| (|Expression| (|MachineFloat|))))
         ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 154)) 'T)))) 

(SDEFUN |FC;assign;SV$;75|
        ((|v| (|Symbol|)) (|rhs| (|Vector| (|Expression| (|MachineComplex|))))
         ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 157)) 'T)))) 

(SDEFUN |FC;assign;SLE$;76|
        ((|v| (|Symbol|)) (|index| (|List| (|Polynomial| (|Integer|))))
         (|rhs| (|Expression| (|MachineInteger|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| |index|
                            (CONS NIL (SPADCALL |rhs| (QREFELT $ 99))))))) 

(SDEFUN |FC;assign;SLE$;77|
        ((|v| (|Symbol|)) (|index| (|List| (|Polynomial| (|Integer|))))
         (|rhs| (|Expression| (|MachineFloat|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| |index|
                            (CONS 'T (SPADCALL |rhs| (QREFELT $ 102))))))) 

(SDEFUN |FC;assign;SLE$;78|
        ((|v| (|Symbol|)) (|index| (|List| (|Polynomial| (|Integer|))))
         (|rhs| (|Expression| (|MachineComplex|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| |index|
                            (CONS 'T (SPADCALL |rhs| (QREFELT $ 105))))))) 

(SDEFUN |FC;assign;SE$;79|
        ((|v| (|Symbol|)) (|rhs| (|Expression| (|MachineInteger|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| NIL
                            (CONS NIL (SPADCALL |rhs| (QREFELT $ 99))))))) 

(SDEFUN |FC;assign;SE$;80|
        ((|v| (|Symbol|)) (|rhs| (|Expression| (|MachineFloat|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| NIL
                            (CONS 'T (SPADCALL |rhs| (QREFELT $ 102))))))) 

(SDEFUN |FC;assign;SE$;81|
        ((|v| (|Symbol|)) (|rhs| (|Expression| (|MachineComplex|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| NIL
                            (CONS 'T (SPADCALL |rhs| (QREFELT $ 105))))))) 

(SDEFUN |FC;assign;SM$;82|
        ((|v| (|Symbol|)) (|rhs| (|Matrix| (|Expression| (|Integer|))))
         ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 166)) NIL)))) 

(SDEFUN |FC;assign;SM$;83|
        ((|v| (|Symbol|)) (|rhs| (|Matrix| (|Expression| (|Float|)))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 169)) 'T)))) 

(SDEFUN |FC;assign;SM$;84|
        ((|v| (|Symbol|))
         (|rhs| (|Matrix| (|Expression| (|Complex| (|Float|))))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 172)) 'T)))) 

(SDEFUN |FC;assign;SV$;85|
        ((|v| (|Symbol|)) (|rhs| (|Vector| (|Expression| (|Integer|))))
         ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 175)) NIL)))) 

(SDEFUN |FC;assign;SV$;86|
        ((|v| (|Symbol|)) (|rhs| (|Vector| (|Expression| (|Float|)))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 178)) 'T)))) 

(SDEFUN |FC;assign;SV$;87|
        ((|v| (|Symbol|))
         (|rhs| (|Vector| (|Expression| (|Complex| (|Float|))))) ($ ($)))
        (CONS (CONS 12 "arrayAssignment")
              (CONS 2 (VECTOR |v| (SPADCALL |rhs| (QREFELT $ 181)) 'T)))) 

(SDEFUN |FC;assign;SLE$;88|
        ((|v| (|Symbol|)) (|index| (|List| (|Polynomial| (|Integer|))))
         (|rhs| (|Expression| (|Integer|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| |index|
                            (CONS NIL (SPADCALL |rhs| (QREFELT $ 108))))))) 

(SDEFUN |FC;assign;SLE$;89|
        ((|v| (|Symbol|)) (|index| (|List| (|Polynomial| (|Integer|))))
         (|rhs| (|Expression| (|Float|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| |index|
                            (CONS 'T (SPADCALL |rhs| (QREFELT $ 111))))))) 

(SDEFUN |FC;assign;SLE$;90|
        ((|v| (|Symbol|)) (|index| (|List| (|Polynomial| (|Integer|))))
         (|rhs| (|Expression| (|Complex| (|Float|)))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| |index|
                            (CONS 'T (SPADCALL |rhs| (QREFELT $ 114))))))) 

(SDEFUN |FC;assign;SE$;91|
        ((|v| (|Symbol|)) (|rhs| (|Expression| (|Integer|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| NIL
                            (CONS NIL (SPADCALL |rhs| (QREFELT $ 108))))))) 

(SDEFUN |FC;assign;SE$;92|
        ((|v| (|Symbol|)) (|rhs| (|Expression| (|Float|))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| NIL
                            (CONS 'T (SPADCALL |rhs| (QREFELT $ 111))))))) 

(SDEFUN |FC;assign;SE$;93|
        ((|v| (|Symbol|)) (|rhs| (|Expression| (|Complex| (|Float|)))) ($ ($)))
        (CONS (CONS 1 "assignment")
              (CONS 1
                    (VECTOR |v| NIL
                            (CONS 'T (SPADCALL |rhs| (QREFELT $ 114))))))) 

(SDEFUN |FC;call;S$;94| ((|s| (|String|)) ($ ($)))
        (CONS (CONS 6 "call") (CONS 7 |s|))) 

(DECLAIM (NOTINLINE |FortranCode;|)) 

(DEFUN |FortranCode| ()
  (SPROG NIL
         (PROG (#1=#:G2931)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FortranCode|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FortranCode|
                             (LIST (CONS NIL (CONS 1 (|FortranCode;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|FortranCode|)))))))))) 

(DEFUN |FortranCode;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FortranCode|))
          (LETT $ (GETREFV 191))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FortranCode| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 33
                    (|Record|
                     (|:| |op|
                          (|Union| (|:| |Null| #1="null")
                                   (|:| |Assignment| "assignment")
                                   (|:| |Conditional| "conditional")
                                   (|:| |Return| "return")
                                   (|:| |Block| "block")
                                   (|:| |Comment| "comment")
                                   (|:| |Call| "call") (|:| |For| "for")
                                   (|:| |While| "while")
                                   (|:| |Repeat| "repeat") (|:| |Goto| "goto")
                                   (|:| |Continue| "continue")
                                   (|:| |ArrayAssignment| "arrayAssignment")
                                   (|:| |Save| "save") (|:| |Stop| "stop")
                                   (|:| |Common| "common")
                                   (|:| |Print| "print")))
                     (|:| |data|
                          (|Union| (|:| |nullBranch| #1#)
                                   (|:| |assignmentBranch|
                                        (|Record| (|:| |var| (|Symbol|))
                                                  (|:| |arrayIndex|
                                                       (|List|
                                                        (|Polynomial|
                                                         (|Integer|))))
                                                  (|:| |rand|
                                                       (|Record|
                                                        (|:| |ints2Floats?|
                                                             (|Boolean|))
                                                        (|:| |expr|
                                                             (|OutputForm|))))))
                                   (|:| |arrayAssignmentBranch|
                                        (|Record| (|:| |var| (|Symbol|))
                                                  (|:| |rand| (|OutputForm|))
                                                  (|:| |ints2Floats?|
                                                       (|Boolean|))))
                                   (|:| |conditionalBranch|
                                        (|Record| (|:| |switch| (|Switch|))
                                                  (|:| |thenClause| $)
                                                  (|:| |elseClause| $)))
                                   (|:| |returnBranch|
                                        (|Record| (|:| |empty?| (|Boolean|))
                                                  (|:| |value|
                                                       (|Record|
                                                        (|:| |ints2Floats?|
                                                             (|Boolean|))
                                                        (|:| |expr|
                                                             (|OutputForm|))))))
                                   (|:| |blockBranch| (|List| $))
                                   (|:| |commentBranch| (|List| (|String|)))
                                   (|:| |callBranch| (|String|))
                                   (|:| |forBranch|
                                        (|Record|
                                         (|:| |range|
                                              (|SegmentBinding|
                                               (|Polynomial| (|Integer|))))
                                         (|:| |span|
                                              (|Polynomial| (|Integer|)))
                                         (|:| |body| $)))
                                   (|:| |labelBranch| (|SingleInteger|))
                                   (|:| |loopBranch|
                                        (|Record| (|:| |switch| (|Switch|))
                                                  (|:| |body| $)))
                                   (|:| |commonBranch|
                                        (|Record| (|:| |name| (|Symbol|))
                                                  (|:| |contents|
                                                       (|List| (|Symbol|)))))
                                   (|:| |printBranch|
                                        (|List| (|OutputForm|)))))))
          (QSETREFV $ 34 25000)
          $))) 

(MAKEPROP '|FortranCode| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|OutputForm|) (|Symbol|) (0 . |coerce|)
              (|List| $) (5 . |elt|) (|List| 25) (|Boolean|)
              (|FortranCodeTools|) (11 . |getStatement|)
              (17 . |statement2Fortran|) (|Void|) (|Integer|)
              (22 . |changeExprLength|) (27 . |append|) (|Mapping| 11)
              (33 . |do_with_error_env1|) (38 . |fort_clean_lines|)
              (|UniversalSegment| 17) (43 . SEGMENT) (|String|) (48 . |elt|)
              (|Mapping| 7) (54 . |expression2Fortran1|) (|NonNegativeInteger|)
              (61 . |first|) (67 . |do_with_error_env2|) (73 . |string|) '|Rep|
              '|labelValue| (|SingleInteger|) |FC;setLabelValue;2Si;15|
              (|Polynomial| 17) (78 . |One|) (82 . |elt|)
              (88 . |expression2Fortran|) (93 . |indentFortLevel|)
              |FC;getCode;$L;36|
              (|Union| (|:| |Null| '"null") (|:| |Assignment| '"assignment")
                       (|:| |Conditional| '"conditional")
                       (|:| |Return| '"return") (|:| |Block| '"block")
                       (|:| |Comment| '"comment") (|:| |Call| '"call")
                       (|:| |For| '"for") (|:| |While| '"while")
                       (|:| |Repeat| '"repeat") (|:| |Goto| '"goto")
                       (|:| |Continue| '"continue")
                       (|:| |ArrayAssignment| '"arrayAssignment")
                       (|:| |Save| '"save") (|:| |Stop| '"stop")
                       (|:| |Common| '"common") (|:| |Print| '"print"))
              |FC;operation;$U;39|
              (|Record| (|:| |ints2Floats?| 12) (|:| |expr| 6))
              (|Record| (|:| |var| 7) (|:| |arrayIndex| 65) (|:| |rand| 45))
              (|Record| (|:| |var| 7) (|:| |rand| 6) (|:| |ints2Floats?| 12))
              (|Record| (|:| |switch| 55) (|:| |thenClause| $)
                        (|:| |elseClause| $))
              (|Record| (|:| |empty?| 12) (|:| |value| 45))
              (|Record| (|:| |range| 68) (|:| |span| 37) (|:| |body| $))
              (|Record| (|:| |switch| 55) (|:| |body| $))
              (|Record| (|:| |name| 7) (|:| |contents| 81))
              (|Union| (|:| |nullBranch| '"null") (|:| |assignmentBranch| 46)
                       (|:| |arrayAssignmentBranch| 47)
                       (|:| |conditionalBranch| 48) (|:| |returnBranch| 49)
                       (|:| |blockBranch| 9) (|:| |commentBranch| 11)
                       (|:| |callBranch| 25) (|:| |forBranch| 50)
                       (|:| |labelBranch| 35) (|:| |loopBranch| 51)
                       (|:| |commonBranch| 52) (|:| |printBranch| 63))
              |FC;code;$U;38| (|Switch|) (98 . |coerce|)
              (103 . |get_fort_indent|) (107 . |hspace|) (112 . NOT)
              |FC;gotoJump;Si$;48| (117 . |concat|) (122 . |coerce|) (|List| 6)
              (|Mapping| 6 37) (|List| 37) (|ListFunctions2| 37 6)
              (127 . |map|) (|SegmentBinding| 37) (133 . |variable|)
              (|FortranType|) (138 . |fortranInteger|) (|TheSymbolTable|)
              (142 . |declare!|) (|Segment| 37) (148 . |segment|) (153 . |low|)
              (158 . |high|) (163 . |displayLines|) (168 . |void|)
              |FC;printCode;$V;37| (|List| 7) |FC;common;SL$;40| |FC;stop;$;41|
              |FC;save;$;42| |FC;printStatement;L$;43| |FC;comment;L$;44|
              (172 . |list|) |FC;comment;S$;45| (177 . |incr|) (182 . |coerce|)
              |FC;forLoop;Sb2$;46| |FC;forLoop;SbP2$;47| |FC;continue;Si$;49|
              |FC;whileLoop;S2$;50| |FC;repeatUntilLoop;S2$;51| (187 . |Zero|)
              |FC;returns;$;52| (|Expression| (|MachineInteger|))
              (191 . |coerce|) |FC;returns;E$;53|
              (|Expression| (|MachineFloat|)) (196 . |coerce|)
              |FC;returns;E$;54| (|Expression| (|MachineComplex|))
              (201 . |coerce|) |FC;returns;E$;55| (|Expression| 17)
              (206 . |coerce|) |FC;returns;E$;56| (|Expression| (|Float|))
              (211 . |coerce|) |FC;returns;E$;57|
              (|Expression| (|Complex| (|Float|))) (216 . |coerce|)
              |FC;returns;E$;58| |FC;block;L$;59| |FC;cond;S2$;60|
              |FC;cond;S3$;61| (221 . |coerce|) |FC;coerce;$Of;62|
              (226 . |coerce|) |FC;assign;SS$;63| (|Matrix| (|MachineInteger|))
              (231 . |coerce|) |FC;assign;SM$;64| (|Matrix| (|MachineFloat|))
              (236 . |coerce|) |FC;assign;SM$;65| (|Matrix| (|MachineComplex|))
              (241 . |coerce|) |FC;assign;SM$;66| (|Vector| (|MachineInteger|))
              (246 . |coerce|) |FC;assign;SV$;67| (|Vector| (|MachineFloat|))
              (251 . |coerce|) |FC;assign;SV$;68| (|Vector| (|MachineComplex|))
              (256 . |coerce|) |FC;assign;SV$;69| (|Matrix| 98)
              (261 . |coerce|) |FC;assign;SM$;70| (|Matrix| 101)
              (266 . |coerce|) |FC;assign;SM$;71| (|Matrix| 104)
              (271 . |coerce|) |FC;assign;SM$;72| (|Vector| 98)
              (276 . |coerce|) |FC;assign;SV$;73| (|Vector| 101)
              (281 . |coerce|) |FC;assign;SV$;74| (|Vector| 104)
              (286 . |coerce|) |FC;assign;SV$;75| |FC;assign;SLE$;76|
              |FC;assign;SLE$;77| |FC;assign;SLE$;78| |FC;assign;SE$;79|
              |FC;assign;SE$;80| |FC;assign;SE$;81| (|Matrix| 107)
              (291 . |coerce|) |FC;assign;SM$;82| (|Matrix| 110)
              (296 . |coerce|) |FC;assign;SM$;83| (|Matrix| 113)
              (301 . |coerce|) |FC;assign;SM$;84| (|Vector| 107)
              (306 . |coerce|) |FC;assign;SV$;85| (|Vector| 110)
              (311 . |coerce|) |FC;assign;SV$;86| (|Vector| 113)
              (316 . |coerce|) |FC;assign;SV$;87| |FC;assign;SLE$;88|
              |FC;assign;SLE$;89| |FC;assign;SLE$;90| |FC;assign;SE$;91|
              |FC;assign;SE$;92| |FC;assign;SE$;93| |FC;call;S$;94|
              (|HashState|))
           '#(~= 321 |whileLoop| 327 |stop| 333 |setLabelValue| 337 |save| 342
              |returns| 346 |repeatUntilLoop| 380 |printStatement| 386
              |printCode| 391 |operation| 396 |latex| 401 |hashUpdate!| 406
              |hash| 412 |gotoJump| 417 |getCode| 422 |forLoop| 427 |continue|
              440 |cond| 445 |common| 458 |comment| 464 |coerce| 474 |code| 479
              |call| 484 |block| 489 |assign| 494 = 686)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 6))
                        (|makeByteWordVec2| 190
                                            '(1 7 6 0 8 2 6 0 0 9 10 2 13 11 6
                                              12 14 1 13 11 6 15 1 13 16 17 18
                                              2 11 0 0 0 19 1 13 11 20 21 1 13
                                              11 11 22 1 23 0 17 24 2 25 0 0 23
                                              26 3 13 11 27 6 12 28 2 11 0 0 29
                                              30 2 13 11 12 20 31 1 7 25 0 32 0
                                              37 0 38 2 11 25 0 17 39 1 13 11 6
                                              40 1 13 16 17 41 1 55 6 0 56 0 13
                                              17 57 1 6 0 17 58 1 55 0 0 59 1
                                              11 0 9 61 1 37 6 0 62 2 66 63 64
                                              65 67 1 68 7 0 69 0 70 0 71 2 72
                                              70 7 70 73 1 68 74 0 75 1 74 37 0
                                              76 1 74 37 0 77 1 13 16 11 78 0
                                              16 0 79 1 11 0 25 87 1 74 17 0 89
                                              1 37 0 17 90 0 37 0 96 1 98 6 0
                                              99 1 101 6 0 102 1 104 6 0 105 1
                                              107 6 0 108 1 110 6 0 111 1 113 6
                                              0 114 1 43 6 0 119 1 25 6 0 121 1
                                              123 6 0 124 1 126 6 0 127 1 129 6
                                              0 130 1 132 6 0 133 1 135 6 0 136
                                              1 138 6 0 139 1 141 6 0 142 1 144
                                              6 0 145 1 147 6 0 148 1 150 6 0
                                              151 1 153 6 0 154 1 156 6 0 157 1
                                              165 6 0 166 1 168 6 0 169 1 171 6
                                              0 172 1 174 6 0 175 1 177 6 0 178
                                              1 180 6 0 181 2 0 12 0 0 1 2 0 0
                                              55 0 94 0 0 0 83 1 0 35 35 36 0 0
                                              0 84 1 0 0 113 115 1 0 0 110 112
                                              1 0 0 107 109 1 0 0 98 100 1 0 0
                                              104 106 0 0 0 97 1 0 0 101 103 2
                                              0 0 55 0 95 1 0 0 63 85 1 0 16 0
                                              80 1 0 43 0 44 1 0 25 0 1 2 0 190
                                              190 0 1 1 0 35 0 1 1 0 0 35 60 1
                                              0 11 0 42 3 0 0 68 37 0 92 2 0 0
                                              68 0 91 1 0 0 35 93 3 0 0 55 0 0
                                              118 2 0 0 55 0 117 2 0 0 7 81 82
                                              1 0 0 11 86 1 0 0 25 88 1 0 6 0
                                              120 1 0 53 0 54 1 0 0 25 189 1 0
                                              0 9 116 3 0 0 7 65 110 184 3 0 0
                                              7 65 113 185 2 0 0 7 180 182 3 0
                                              0 7 65 107 183 2 0 0 7 174 176 2
                                              0 0 7 177 179 2 0 0 7 168 170 2 0
                                              0 7 171 173 2 0 0 7 113 188 2 0 0
                                              7 165 167 2 0 0 7 107 186 2 0 0 7
                                              110 187 3 0 0 7 65 101 160 3 0 0
                                              7 65 104 161 2 0 0 7 156 158 3 0
                                              0 7 65 98 159 2 0 0 7 150 152 2 0
                                              0 7 153 155 2 0 0 7 144 146 2 0 0
                                              7 147 149 2 0 0 7 138 140 2 0 0 7
                                              141 143 2 0 0 7 132 134 2 0 0 7
                                              135 137 2 0 0 7 126 128 2 0 0 7
                                              129 131 2 0 0 7 104 164 2 0 0 7
                                              123 125 2 0 0 7 98 162 2 0 0 7
                                              101 163 2 0 0 7 25 122 2 0 12 0 0
                                              1)))))
           '|lookupComplete|)) 

(MAKEPROP '|FortranCode| 'NILADIC T) 

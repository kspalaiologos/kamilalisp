
(PUT '|OFTOOL;atom?;OfB;1| '|SPADreplace| 'ATOM) 

(SDEFUN |OFTOOL;atom?;OfB;1| ((|x| (|OutputForm|)) ($ (|Boolean|))) (ATOM |x|)) 

(SDEFUN |OFTOOL;atom_to_string;OfS;2| ((|x| (|OutputForm|)) ($ (|String|)))
        (COND ((SPADCALL |x| (QREFELT $ 9)) (SPADCALL |x| (QREFELT $ 12)))
              ((SPADCALL |x| (QREFELT $ 13)) (STRINGIMAGE |x|))
              ((SPADCALL |x| (QREFELT $ 14)) |x|)
              ('T (|error| "unrecognized kind of atom")))) 

(SDEFUN |OFTOOL;empty?;OfB;3| ((|x| (|OutputForm|)) ($ (|Boolean|)))
        (SPROG ((|op| (|OutputForm|)))
               (SEQ
                (COND
                 ((OR (SPADCALL |x| (QREFELT $ 8))
                      (NULL (NULL (SPADCALL |x| (QREFELT $ 17)))))
                  NIL)
                 ('T
                  (SEQ (LETT |op| (SPADCALL |x| (QREFELT $ 18)))
                       (EXIT
                        (COND
                         ((SPADCALL |op| (QREFELT $ 9)) (EQUAL |op| 'NOTHING))
                         ('T NIL))))))))) 

(PUT '|OFTOOL;integer?;OfB;4| '|SPADreplace| 'INTEGERP) 

(SDEFUN |OFTOOL;integer?;OfB;4| ((|x| (|OutputForm|)) ($ (|Boolean|)))
        (INTEGERP |x|)) 

(SDEFUN |OFTOOL;integer;OfI;5| ((|x| (|OutputForm|)) ($ (|Integer|)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) |x|)
              ('T (|error| "not an integer")))) 

(PUT '|OFTOOL;symbol?;OfB;6| '|SPADreplace| 'SYMBOLP) 

(SDEFUN |OFTOOL;symbol?;OfB;6| ((|x| (|OutputForm|)) ($ (|Boolean|)))
        (SYMBOLP |x|)) 

(SDEFUN |OFTOOL;symbol;OfS;7| ((|x| (|OutputForm|)) ($ (|Symbol|)))
        (COND ((SPADCALL |x| (QREFELT $ 9)) |x|) ('T (|error| "not a symbol")))) 

(PUT '|OFTOOL;string?;OfB;8| '|SPADreplace| 'STRINGP) 

(SDEFUN |OFTOOL;string?;OfB;8| ((|x| (|OutputForm|)) ($ (|Boolean|)))
        (STRINGP |x|)) 

(SDEFUN |OFTOOL;string;OfS;9| ((|x| (|OutputForm|)) ($ (|String|)))
        (COND ((SPADCALL |x| (QREFELT $ 14)) |x|)
              ('T (|error| "not a string")))) 

(SDEFUN |OFTOOL;operator;2Of;10| ((|x| (|OutputForm|)) ($ (|OutputForm|)))
        (COND ((SPADCALL |x| (QREFELT $ 8)) (|error| "is an atom"))
              ('T (|SPADfirst| |x|)))) 

(SDEFUN |OFTOOL;arguments;OfL;11|
        ((|x| (|OutputForm|)) ($ (|List| (|OutputForm|))))
        (COND ((SPADCALL |x| (QREFELT $ 8)) (|error| "is an atom"))
              ('T (CDR |x|)))) 

(SDEFUN |OFTOOL;has_op?;OfSB;12|
        ((|expr| (|OutputForm|)) (|op| (|Symbol|)) ($ (|Boolean|)))
        (SPROG ((|e1| (|OutputForm|)))
               (SEQ
                (COND ((SPADCALL |expr| (QREFELT $ 8)) NIL)
                      ('T
                       (SEQ (LETT |e1| (|SPADfirst| |expr|))
                            (EXIT (EQ |e1| |op|)))))))) 

(SDEFUN |OFTOOL;is_symbol?;OfSB;13|
        ((|expr| (|OutputForm|)) (|op| (|Symbol|)) ($ (|Boolean|)))
        (COND ((NULL (SPADCALL |expr| (QREFELT $ 9))) NIL)
              ('T (EQUAL (SPADCALL |expr| (QREFELT $ 22)) |op|)))) 

(SDEFUN |OFTOOL;flaten_op|
        ((|s| (|Symbol|)) (|l| #1=(|List| (|OutputForm|)))
         ($ (|List| (|OutputForm|))))
        (SPROG
         ((|res| (|List| (|OutputForm|))) (|ll| (|List| #1#))
          (|t1| (|OutputForm|)) (|t| (|OutputForm|)))
         (SEQ (LETT |ll| (LIST |l|)) (LETT |res| NIL)
              (SEQ G190 (COND ((NULL (NULL (NULL |ll|))) (GO G191)))
                   (SEQ (LETT |l| (|SPADfirst| |ll|)) (LETT |ll| (CDR |ll|))
                        (EXIT
                         (SEQ G190 (COND ((NULL (NULL (NULL |l|))) (GO G191)))
                              (SEQ (LETT |t| (|SPADfirst| |l|))
                                   (LETT |l| (CDR |l|))
                                   (EXIT
                                    (COND
                                     ((SPADCALL |t| (QREFELT $ 8))
                                      (LETT |res| (CONS |t| |res|)))
                                     ('T
                                      (SEQ
                                       (LETT |t1|
                                             (SPADCALL |t| (QREFELT $ 18)))
                                       (EXIT
                                        (COND
                                         ((SPADCALL |t1| |s| (QREFELT $ 25))
                                          (SEQ (LETT |ll| (CONS |l| |ll|))
                                               (EXIT
                                                (LETT |l|
                                                      (SPADCALL |t|
                                                                (QREFELT $
                                                                         17))))))
                                         ('T
                                          (LETT |res| (CONS |t| |res|))))))))))
                              NIL (GO G190) G191 (EXIT NIL))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |res|))))) 

(PUT '|OFTOOL;construct;OfLOf;15| '|SPADreplace| 'CONS) 

(SDEFUN |OFTOOL;construct;OfLOf;15|
        ((|op| (|OutputForm|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputForm|)))
        (CONS |op| |args|)) 

(SDEFUN |OFTOOL;precondition;2Of;16| ((|x| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG
         ((|a11| #1=(|OutputForm|)) (|args1| #2=(|List| (|OutputForm|)))
          (|op1| #3=(|OutputForm|)) (|op| #3#) (|a2| (|OutputForm|)) (|a1| #1#)
          (|nargs| (|List| (|OutputForm|))) (|args2| #2#)
          (|n| (|NonNegativeInteger|)) (|args| #2#) (#4=#:G851 NIL) (|arg| NIL)
          (#5=#:G850 NIL) (|xi| (|Integer|)))
         (SEQ
          (COND ((SPADCALL |x| (QREFELT $ 14)) |x|)
                ((SPADCALL |x| (QREFELT $ 13))
                 (SEQ (LETT |xi| (SPADCALL |x| (QREFELT $ 21)))
                      (EXIT
                       (COND
                        ((< |xi| 0)
                         (SPADCALL (SPADCALL '- (QREFELT $ 27))
                                   (LIST (SPADCALL (- |xi|) (QREFELT $ 28)))
                                   (QREFELT $ 26)))
                        (#6='T |x|)))))
                ((SPADCALL |x| (QREFELT $ 8)) |x|)
                (#6#
                 (SEQ (LETT |op| (SPADCALL |x| (QREFELT $ 18)))
                      (LETT |args| (SPADCALL |x| (QREFELT $ 17)))
                      (COND
                       ((SPADCALL |op| '+ (QREFELT $ 25))
                        (LETT |args| (|OFTOOL;flaten_op| '+ |args| $))))
                      (COND
                       ((SPADCALL |op| '* (QREFELT $ 25))
                        (LETT |args| (|OFTOOL;flaten_op| '* |args| $))))
                      (LETT |args|
                            (PROGN
                             (LETT #5# NIL)
                             (SEQ (LETT |arg| NIL) (LETT #4# |args|) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |arg| (CAR #4#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #5#
                                          (CONS (SPADCALL |arg| (QREFELT $ 29))
                                                #5#))))
                                  (LETT #4# (CDR #4#)) (GO G190) G191
                                  (EXIT (NREVERSE #5#)))))
                      (EXIT
                       (COND
                        ((SPADCALL |op| '|construct| (QREFELT $ 25))
                         (SPADCALL |args| (QREFELT $ 31)))
                        (#6#
                         (SEQ (LETT |n| (LENGTH |args|))
                              (COND
                               ((SPADCALL |op| 'SEGMENT (QREFELT $ 25))
                                (COND
                                 ((> |n| 0)
                                  (COND
                                   ((<= |n| 2)
                                    (EXIT
                                     (SEQ (LETT |a1| (|SPADfirst| |args|))
                                          (LETT |a1|
                                                (COND
                                                 ((SPADCALL |a1| (QREFELT $ 8))
                                                  |a1|)
                                                 (#6#
                                                  (SPADCALL |a1|
                                                            (QREFELT $ 32)))))
                                          (EXIT
                                           (COND
                                            ((EQL |n| 2)
                                             (SEQ
                                              (LETT |a2|
                                                    (SPADCALL |args| 2
                                                              (QREFELT $ 33)))
                                              (LETT |a2|
                                                    (COND
                                                     ((SPADCALL |a2|
                                                                (QREFELT $ 8))
                                                      |a2|)
                                                     (#6#
                                                      (SPADCALL |a2|
                                                                (QREFELT $
                                                                         32)))))
                                              (EXIT
                                               (SPADCALL |a1| |a2|
                                                         (QREFELT $ 34)))))
                                            (#6#
                                             (SPADCALL |a1|
                                                       (QREFELT $
                                                                35)))))))))))))
                              (COND
                               ((SPADCALL |op| '- (QREFELT $ 25))
                                (COND
                                 ((EQL |n| 2)
                                  (EXIT
                                   (SEQ (LETT |a1| (|SPADfirst| |args|))
                                        (LETT |a2|
                                              (SPADCALL |args| 2
                                                        (QREFELT $ 33)))
                                        (COND
                                         ((NULL (SPADCALL |a2| (QREFELT $ 8)))
                                          (COND
                                           ((SPADCALL
                                             (SPADCALL |a2| (QREFELT $ 18)) '-
                                             (QREFELT $ 25))
                                            (COND
                                             ((EQL
                                               (LENGTH
                                                (LETT |args2|
                                                      (SPADCALL |a2|
                                                                (QREFELT $
                                                                         17))))
                                               1)
                                              (EXIT
                                               (SPADCALL
                                                (SPADCALL '+ (QREFELT $ 27))
                                                (LIST |a1|
                                                      (|SPADfirst| |args2|))
                                                (QREFELT $ 26)))))))))
                                        (LETT |a2|
                                              (SPADCALL
                                               (SPADCALL '- (QREFELT $ 27))
                                               (LIST |a2|) (QREFELT $ 26)))
                                        (EXIT
                                         (SPADCALL (SPADCALL '+ (QREFELT $ 27))
                                                   (LIST |a1| |a2|)
                                                   (QREFELT $ 26)))))))))
                              (COND
                               ((SPADCALL |op| '- (QREFELT $ 25))
                                (COND
                                 ((EQL |n| 1)
                                  (EXIT
                                   (SEQ (LETT |a1| (|SPADfirst| |args|))
                                        (COND
                                         ((NULL (SPADCALL |a1| (QREFELT $ 8)))
                                          (COND
                                           ((SPADCALL
                                             (LETT |op1|
                                                   (SPADCALL |a1|
                                                             (QREFELT $ 18)))
                                             '- (QREFELT $ 25))
                                            (COND
                                             ((EQL
                                               (LENGTH
                                                (LETT |args1|
                                                      (SPADCALL |a1|
                                                                (QREFELT $
                                                                         17))))
                                               1)
                                              (EXIT
                                               (|SPADfirst| |args1|))))))))
                                        (EXIT
                                         (SPADCALL |op| |args|
                                                   (QREFELT $ 26)))))))))
                              (EXIT
                               (COND
                                ((SPADCALL |op| '+ (QREFELT $ 25))
                                 (COND ((EQL |n| 1) (|SPADfirst| |args|))
                                       (#6#
                                        (SPADCALL |op|
                                                  (|OFTOOL;flaten_op| '+ |args|
                                                   $)
                                                  (QREFELT $ 26)))))
                                ((SPADCALL |op| '* (QREFELT $ 25))
                                 (SEQ (LETT |a1| (|SPADfirst| |args|))
                                      (EXIT
                                       (COND ((EQL |n| 1) |a1|)
                                             (#6#
                                              (SEQ
                                               (COND
                                                ((NULL
                                                  (SPADCALL |a1|
                                                            (QREFELT $ 8)))
                                                 (COND
                                                  ((SPADCALL
                                                    (LETT |op1|
                                                          (SPADCALL |a1|
                                                                    (QREFELT $
                                                                             18)))
                                                    '- (QREFELT $ 25))
                                                   (COND
                                                    ((EQL
                                                      (LENGTH
                                                       (LETT |args1|
                                                             (SPADCALL |a1|
                                                                       (QREFELT
                                                                        $
                                                                        17))))
                                                      1)
                                                     (EXIT
                                                      (SEQ
                                                       (LETT |a11|
                                                             (|SPADfirst|
                                                              |args1|))
                                                       (LETT |nargs|
                                                             (SEQ
                                                              (COND
                                                               ((SPADCALL |a11|
                                                                          (QREFELT
                                                                           $
                                                                           13))
                                                                (COND
                                                                 ((EQL
                                                                   (SPADCALL
                                                                    |a11|
                                                                    (QREFELT $
                                                                             21))
                                                                   1)
                                                                  (EXIT
                                                                   (CDR
                                                                    |args|))))))
                                                              (EXIT
                                                               (CONS |a11|
                                                                     (CDR
                                                                      |args|)))))
                                                       (EXIT
                                                        (SPADCALL
                                                         (SPADCALL |op1|
                                                                   (LIST
                                                                    (SPADCALL
                                                                     |op|
                                                                     |nargs|
                                                                     (QREFELT $
                                                                              26)))
                                                                   (QREFELT $
                                                                            26))
                                                         (QREFELT $
                                                                  29)))))))))))
                                               (EXIT
                                                (SPADCALL |op|
                                                          (|OFTOOL;flaten_op|
                                                           '* |args| $)
                                                          (QREFELT $
                                                                   26)))))))))
                                ((SPADCALL |op| '/ (QREFELT $ 25))
                                 (COND
                                  ((SPADCALL |n| 2 (QREFELT $ 37))
                                   (|error|
                                    "precodition: division must have two arguments"))
                                  (#6#
                                   (SEQ (LETT |a1| (|SPADfirst| |args|))
                                        (LETT |a2|
                                              (SPADCALL |args| 2
                                                        (QREFELT $ 33)))
                                        (EXIT
                                         (COND
                                          ((EQUAL |$fractionDisplayType|
                                                  '|horizontal|)
                                           (SEQ
                                            (LETT |a1|
                                                  (COND
                                                   ((SPADCALL |a1|
                                                              (QREFELT $ 8))
                                                    |a1|)
                                                   (#6#
                                                    (SPADCALL |a1|
                                                              (QREFELT $
                                                                       32)))))
                                            (LETT |a2|
                                                  (COND
                                                   ((SPADCALL |a2|
                                                              (QREFELT $ 8))
                                                    |a2|)
                                                   (#6#
                                                    (SPADCALL |a2|
                                                              (QREFELT $
                                                                       32)))))
                                            (EXIT
                                             (SPADCALL
                                              (SPADCALL 'SLASH (QREFELT $ 27))
                                              (LIST |a1| |a2|)
                                              (QREFELT $ 26)))))
                                          (#6#
                                           (SEQ
                                            (LETT |op|
                                                  (SPADCALL 'OVER
                                                            (QREFELT $ 27)))
                                            (COND
                                             ((NULL
                                               (SPADCALL |a1| (QREFELT $ 8)))
                                              (COND
                                               ((SPADCALL
                                                 (LETT |op1|
                                                       (SPADCALL |a1|
                                                                 (QREFELT $
                                                                          18)))
                                                 '- (QREFELT $ 25))
                                                (COND
                                                 ((EQL
                                                   (LENGTH
                                                    (LETT |args1|
                                                          (SPADCALL |a1|
                                                                    (QREFELT $
                                                                             17))))
                                                   1)
                                                  (EXIT
                                                   (SEQ
                                                    (LETT |a11|
                                                          (|SPADfirst|
                                                           |args1|))
                                                    (EXIT
                                                     (SPADCALL |op1|
                                                               (LIST
                                                                (SPADCALL |op|
                                                                          (LIST
                                                                           |a11|
                                                                           |a2|)
                                                                          (QREFELT
                                                                           $
                                                                           26)))
                                                               (QREFELT $
                                                                        26)))))))))))
                                            (EXIT
                                             (SPADCALL |op| |args|
                                                       (QREFELT $ 26)))))))))))
                                (#6#
                                 (SPADCALL (SPADCALL |op| (QREFELT $ 29))
                                           |args| (QREFELT $ 26))))))))))))))) 

(DECLAIM (NOTINLINE |OutputFormTools;|)) 

(DEFUN |OutputFormTools| ()
  (SPROG NIL
         (PROG (#1=#:G853)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OutputFormTools|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OutputFormTools|
                             (LIST (CONS NIL (CONS 1 (|OutputFormTools;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|OutputFormTools|)))))))))) 

(DEFUN |OutputFormTools;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OutputFormTools|))
          (LETT $ (GETREFV 38))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OutputFormTools| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OutputFormTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Boolean|) (|OutputForm|)
              |OFTOOL;atom?;OfB;1| |OFTOOL;symbol?;OfB;6| (|String|) (|Symbol|)
              (0 . |string|) |OFTOOL;integer?;OfB;4| |OFTOOL;string?;OfB;8|
              |OFTOOL;atom_to_string;OfS;2| (|List| 7)
              |OFTOOL;arguments;OfL;11| |OFTOOL;operator;2Of;10|
              |OFTOOL;empty?;OfB;3| (|Integer|) |OFTOOL;integer;OfI;5|
              |OFTOOL;symbol;OfS;7| |OFTOOL;string;OfS;9|
              |OFTOOL;has_op?;OfSB;12| |OFTOOL;is_symbol?;OfSB;13|
              |OFTOOL;construct;OfLOf;15| (5 . |outputForm|)
              (10 . |outputForm|) |OFTOOL;precondition;2Of;16| (|List| $)
              (15 . |bracket|) (20 . |paren|) (25 . |elt|) (31 . SEGMENT)
              (37 . SEGMENT) (|NonNegativeInteger|) (42 . ~=))
           '#(|symbol?| 48 |symbol| 53 |string?| 58 |string| 63 |precondition|
              68 |operator| 73 |is_symbol?| 78 |integer?| 84 |integer| 89
              |has_op?| 94 |empty?| 100 |construct| 105 |atom_to_string| 111
              |atom?| 116 |arguments| 121)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|atom?| ((|Boolean|) (|OutputForm|))) T)
                                   '((|atom_to_string|
                                      ((|String|) (|OutputForm|)))
                                     T)
                                   '((|empty?| ((|Boolean|) (|OutputForm|))) T)
                                   '((|integer?| ((|Boolean|) (|OutputForm|)))
                                     T)
                                   '((|integer| ((|Integer|) (|OutputForm|)))
                                     T)
                                   '((|symbol?| ((|Boolean|) (|OutputForm|)))
                                     T)
                                   '((|symbol| ((|Symbol|) (|OutputForm|))) T)
                                   '((|string?| ((|Boolean|) (|OutputForm|)))
                                     T)
                                   '((|string| ((|String|) (|OutputForm|))) T)
                                   '((|operator|
                                      ((|OutputForm|) (|OutputForm|)))
                                     T)
                                   '((|arguments|
                                      ((|List| (|OutputForm|)) (|OutputForm|)))
                                     T)
                                   '((|has_op?|
                                      ((|Boolean|) (|OutputForm|) (|Symbol|)))
                                     T)
                                   '((|is_symbol?|
                                      ((|Boolean|) (|OutputForm|) (|Symbol|)))
                                     T)
                                   '((|construct|
                                      ((|OutputForm|) (|OutputForm|)
                                       (|List| (|OutputForm|))))
                                     T)
                                   '((|precondition|
                                      ((|OutputForm|) (|OutputForm|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 37
                                            '(1 11 10 0 12 1 7 0 11 27 1 7 0 20
                                              28 1 7 0 30 31 1 7 0 0 32 2 16 7
                                              0 20 33 2 7 0 0 0 34 1 7 0 0 35 2
                                              36 6 0 0 37 1 0 6 7 9 1 0 11 7 22
                                              1 0 6 7 14 1 0 10 7 23 1 0 7 7 29
                                              1 0 7 7 18 2 0 6 7 11 25 1 0 6 7
                                              13 1 0 20 7 21 2 0 6 7 11 24 1 0
                                              6 7 19 2 0 7 7 16 26 1 0 10 7 15
                                              1 0 6 7 8 1 0 16 7 17)))))
           '|lookupComplete|)) 

(MAKEPROP '|OutputFormTools| 'NILADIC T) 

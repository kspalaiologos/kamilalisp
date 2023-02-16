
(SDEFUN |FIELD-;unitNormal;SR;1|
        ((|x| (S))
         ($ (|Record| (|:| |unit| S) (|:| |canonical| S) (|:| |associate| S))))
        (COND
         ((SPADCALL |x| (QREFELT $ 8))
          (VECTOR (|spadConstant| $ 9) (|spadConstant| $ 10)
                  (|spadConstant| $ 9)))
         ('T (VECTOR |x| (|spadConstant| $ 9) (SPADCALL |x| (QREFELT $ 11)))))) 

(SDEFUN |FIELD-;unitCanonical;2S;2| ((|x| (S)) ($ (S)))
        (COND ((SPADCALL |x| (QREFELT $ 8)) |x|) ('T (|spadConstant| $ 9)))) 

(SDEFUN |FIELD-;associates?;2SB;3| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 8)) (SPADCALL |y| (QREFELT $ 8)))
              ('T (NULL (SPADCALL |y| (QREFELT $ 8)))))) 

(SDEFUN |FIELD-;inv;2S;4| ((|x| (S)) ($ (S)))
        (SPROG ((|u| (|Union| S "failed")))
               (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 17)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (|error| "not invertible"))
                           ('T (QCDR |u|))))))) 

(SDEFUN |FIELD-;exquo;2SU;5| ((|x| (S)) (|y| (S)) ($ (|Union| S "failed")))
        (COND
         ((SPADCALL |y| (|spadConstant| $ 10) (QREFELT $ 19))
          (CONS 1 "failed"))
         ('T (CONS 0 (SPADCALL |x| |y| (QREFELT $ 20)))))) 

(SDEFUN |FIELD-;gcd;3S;6| ((|x| (S)) (|y| (S)) ($ (S)))
        (SEQ
         (COND
          ((SPADCALL |x| (|spadConstant| $ 10) (QREFELT $ 19))
           (COND
            ((SPADCALL |y| (|spadConstant| $ 10) (QREFELT $ 19))
             (EXIT (|spadConstant| $ 10))))))
         (EXIT (|spadConstant| $ 9)))) 

(PUT '|FIELD-;euclideanSize;SNni;7| '|SPADreplace| '(XLAM (|x|) 0)) 

(SDEFUN |FIELD-;euclideanSize;SNni;7| ((|x| (S)) ($ (|NonNegativeInteger|))) 0) 

(PUT '|FIELD-;prime?;SB;8| '|SPADreplace| '(XLAM (|x|) NIL)) 

(SDEFUN |FIELD-;prime?;SB;8| ((|x| (S)) ($ (|Boolean|))) NIL) 

(SDEFUN |FIELD-;squareFree;SF;9| ((|x| (S)) ($ (|Factored| S)))
        (SPADCALL |x| (QREFELT $ 27))) 

(SDEFUN |FIELD-;factor;SF;10| ((|x| (S)) ($ (|Factored| S)))
        (SPADCALL |x| (QREFELT $ 27))) 

(SDEFUN |FIELD-;/;3S;11| ((|x| (S)) (|y| (S)) ($ (S)))
        (COND
         ((SPADCALL |y| (QREFELT $ 8)) (|error| "catdef: division by zero"))
         ('T (SPADCALL |x| (SPADCALL |y| (QREFELT $ 11)) (QREFELT $ 31))))) 

(SDEFUN |FIELD-;divide;2SR;12|
        ((|x| (S)) (|y| (S))
         ($ (|Record| (|:| |quotient| S) (|:| |remainder| S))))
        (CONS (SPADCALL |x| |y| (QREFELT $ 20)) (|spadConstant| $ 10))) 

(DECLAIM (NOTINLINE |Field&;|)) 

(DEFUN |Field&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Field&| DV$1))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Field&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (0 . |zero?|)
              (5 . |One|) (9 . |Zero|) (13 . |inv|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              |FIELD-;unitNormal;SR;1| |FIELD-;unitCanonical;2S;2|
              |FIELD-;associates?;2SB;3| (|Union| $ '"failed") (18 . |recip|)
              |FIELD-;inv;2S;4| (23 . =) (29 . /) |FIELD-;exquo;2SU;5|
              |FIELD-;gcd;3S;6| (|NonNegativeInteger|)
              |FIELD-;euclideanSize;SNni;7| |FIELD-;prime?;SB;8| (|Factored| 6)
              (35 . |coerce|) (|Factored| $) |FIELD-;squareFree;SF;9|
              |FIELD-;factor;SF;10| (40 . *) |FIELD-;/;3S;11|
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              |FIELD-;divide;2SR;12| (|List| $))
           '#(|unitNormal| 46 |unitCanonical| 51 |squareFree| 56 |prime?| 61
              |inv| 66 |gcd| 71 |factor| 77 |exquo| 82 |euclideanSize| 88
              |divide| 93 |associates?| 99 / 105)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((/ (|#1| |#1| |#1|)) T)
                                   '((|inv| (|#1| |#1|)) T)
                                   '((|prime?| ((|Boolean|) |#1|)) T)
                                   '((|squareFree| ((|Factored| |#1|) |#1|)) T)
                                   '((|factor| ((|Factored| |#1|) |#1|)) T)
                                   '((|divide|
                                      ((|Record| (|:| |quotient| |#1|)
                                                 (|:| |remainder| |#1|))
                                       |#1| |#1|))
                                     T)
                                   '((|euclideanSize|
                                      ((|NonNegativeInteger|) |#1|))
                                     T)
                                   '((|gcd| (|#1| (|List| |#1|))) T)
                                   '((|gcd| (|#1| |#1| |#1|)) T)
                                   '((|exquo|
                                      ((|Union| |#1| "failed") |#1| |#1|))
                                     T)
                                   '((|unitNormal|
                                      ((|Record| (|:| |unit| |#1|)
                                                 (|:| |canonical| |#1|)
                                                 (|:| |associate| |#1|))
                                       |#1|))
                                     T)
                                   '((|unitCanonical| (|#1| |#1|)) T)
                                   '((|associates?| ((|Boolean|) |#1| |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 34
                                            '(1 6 7 0 8 0 6 0 9 0 6 0 10 1 6 0
                                              0 11 1 6 16 0 17 2 6 7 0 0 19 2 6
                                              0 0 0 20 1 26 0 6 27 2 6 0 0 0 31
                                              1 0 12 0 13 1 0 0 0 14 1 0 28 0
                                              29 1 0 7 0 25 1 0 0 0 18 2 0 0 0
                                              0 22 1 0 28 0 30 2 0 16 0 0 21 1
                                              0 23 0 24 2 0 33 0 0 34 2 0 7 0 0
                                              15 2 0 0 0 0 32)))))
           '|lookupComplete|)) 


(SDEFUN |ENTIRER-;unitNormal;SR;1|
        ((|x| (S))
         ($ (|Record| (|:| |unit| S) (|:| |canonical| S) (|:| |associate| S))))
        (VECTOR (|spadConstant| $ 7) |x| (|spadConstant| $ 7))) 

(SDEFUN |ENTIRER-;unitCanonical;2S;2| ((|x| (S)) ($ (S)))
        (QVELT (SPADCALL |x| (QREFELT $ 10)) 1)) 

(SDEFUN |ENTIRER-;recip;SU;3| ((|x| (S)) ($ (|Union| S "failed")))
        (COND ((SPADCALL |x| (QREFELT $ 13)) (CONS 1 "failed"))
              ('T (SPADCALL (|spadConstant| $ 7) |x| (QREFELT $ 15))))) 

(SDEFUN |ENTIRER-;unit?;SB;4| ((|x| (S)) ($ (|Boolean|)))
        (NULL (QEQCAR (SPADCALL |x| (QREFELT $ 17)) 1))) 

(SDEFUN |ENTIRER-;associates?;2SB;5| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (SPADCALL (QVELT (SPADCALL |x| (QREFELT $ 10)) 1)
                  (QVELT (SPADCALL |y| (QREFELT $ 10)) 1) (QREFELT $ 19))) 

(SDEFUN |ENTIRER-;associates?;2SB;6| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) (SPADCALL |y| (QREFELT $ 13)))
              ((OR (SPADCALL |y| (QREFELT $ 13))
                   (QEQCAR (SPADCALL |x| |y| (QREFELT $ 15)) 1))
               NIL)
              ('T (NULL (QEQCAR (SPADCALL |y| |x| (QREFELT $ 15)) 1))))) 

(SDEFUN |ENTIRER-;annihilate?;2SB;7| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) 'T)
              ('T (SPADCALL |y| (QREFELT $ 13))))) 

(DECLAIM (NOTINLINE |EntireRing&;|)) 

(DEFUN |EntireRing&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|EntireRing&| DV$1))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND ((|HasCategory| |#1| '(|Field|)))
                ('T
                 (QSETREFV $ 9
                           (CONS
                            (|dispatchFunction| |ENTIRER-;unitNormal;SR;1|)
                            $))))
          (COND
           ((|HasCategory| |#1| '(|canonicalUnitNormal|))
            (QSETREFV $ 20
                      (CONS (|dispatchFunction| |ENTIRER-;associates?;2SB;5|)
                            $)))
           ('T
            (QSETREFV $ 20
                      (CONS (|dispatchFunction| |ENTIRER-;associates?;2SB;6|)
                            $))))
          $))) 

(MAKEPROP '|EntireRing&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (4 . |unitNormal|) (9 . |unitNormal|)
              |ENTIRER-;unitCanonical;2S;2| (|Boolean|) (14 . |zero?|)
              (|Union| $ '"failed") (19 . |exquo|) |ENTIRER-;recip;SU;3|
              (25 . |recip|) |ENTIRER-;unit?;SB;4| (30 . =)
              (36 . |associates?|) |ENTIRER-;annihilate?;2SB;7|)
           '#(|unitNormal| 42 |unitCanonical| 47 |unit?| 52 |recip| 57
              |associates?| 62 |annihilate?| 68)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|unit?| ((|Boolean|) |#1|)) T)
                                   '((|associates?| ((|Boolean|) |#1| |#1|)) T)
                                   '((|unitCanonical| (|#1| |#1|)) T)
                                   '((|unitNormal|
                                      ((|Record| (|:| |unit| |#1|)
                                                 (|:| |canonical| |#1|)
                                                 (|:| |associate| |#1|))
                                       |#1|))
                                     T)
                                   '((|recip| ((|Union| |#1| "failed") |#1|))
                                     T)
                                   '((|annihilate?| ((|Boolean|) |#1| |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(0 6 0 7 1 0 8 0 9 1 6 8 0 10 1 6
                                              12 0 13 2 6 14 0 0 15 1 6 14 0 17
                                              2 6 12 0 0 19 2 0 12 0 0 20 1 0 8
                                              0 9 1 0 0 0 11 1 0 12 0 18 1 0 14
                                              0 16 2 0 12 0 0 20 2 0 12 0 0
                                              21)))))
           '|lookupComplete|)) 


(SDEFUN |BTCAT-;copy;2A;1| ((|t| (A)) ($ (A)))
        (COND ((SPADCALL |t| (QREFELT $ 9)) (SPADCALL (QREFELT $ 10)))
              ('T
               (SPADCALL
                (SPADCALL (SPADCALL |t| (QREFELT $ 11)) (QREFELT $ 12))
                (SPADCALL |t| (QREFELT $ 13))
                (SPADCALL (SPADCALL |t| (QREFELT $ 14)) (QREFELT $ 12))
                (QREFELT $ 15))))) 

(SDEFUN |BTCAT-;map;M2A;2| ((|f| (|Mapping| S S)) (|t| (A)) ($ (A)))
        (COND ((SPADCALL |t| (QREFELT $ 9)) (SPADCALL (QREFELT $ 10)))
              ('T
               (SPADCALL
                (SPADCALL |f| (SPADCALL |t| (QREFELT $ 11)) (QREFELT $ 18))
                (SPADCALL (SPADCALL |t| (QREFELT $ 13)) |f|)
                (SPADCALL |f| (SPADCALL |t| (QREFELT $ 14)) (QREFELT $ 18))
                (QREFELT $ 15))))) 

(SDEFUN |BTCAT-;map!;M2A;3| ((|f| (|Mapping| S S)) (|t| (A)) ($ (A)))
        (SEQ
         (COND ((SPADCALL |t| (QREFELT $ 9)) |t|)
               ('T
                (SEQ
                 (SPADCALL |t| '|value|
                           (SPADCALL (SPADCALL |t| '|value| (QREFELT $ 21))
                                     |f|)
                           (QREFELT $ 22))
                 (SPADCALL |f| (SPADCALL |t| (QREFELT $ 11)) (QREFELT $ 23))
                 (SPADCALL |f| (SPADCALL |t| (QREFELT $ 14)) (QREFELT $ 23))
                 (EXIT |t|)))))) 

(SDEFUN |BTCAT-;#;ANni;4| ((|t| (A)) ($ (|NonNegativeInteger|)))
        (COND ((SPADCALL |t| (QREFELT $ 9)) 0)
              ('T
               (+ (+ 1 (SPADCALL (SPADCALL |t| (QREFELT $ 11)) (QREFELT $ 26)))
                  (SPADCALL (SPADCALL |t| (QREFELT $ 14)) (QREFELT $ 26)))))) 

(SDEFUN |BTCAT-;distance1| ((|t1| (A)) (|t2| (A)) ($ #1=(|Integer|)))
        (SPROG
         ((#2=#:G732 NIL) (#3=#:G731 #1#) (#4=#:G733 #1#) (#5=#:G739 NIL)
          (#6=#:G689 NIL) (|u| (|List| #1#)) (|n| #1#) (#7=#:G738 NIL)
          (|t| NIL) (#8=#:G737 NIL))
         (SEQ
          (COND ((SPADCALL |t1| |t2| (QREFELT $ 28)) 0)
                ((SPADCALL |t2| (QREFELT $ 9)) -1)
                (#9='T
                 (SEQ
                  (LETT |u|
                        (PROGN
                         (LETT #8# NIL)
                         (SEQ (LETT |t| NIL)
                              (LETT #7# (SPADCALL |t2| (QREFELT $ 30))) G190
                              (COND
                               ((OR (ATOM #7#)
                                    (PROGN (LETT |t| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((>=
                                   (LETT |n| (|BTCAT-;distance1| |t1| |t| $))
                                   0)
                                  (LETT #8# (CONS |n| #8#))))))
                              (LETT #7# (CDR #7#)) (GO G190) G191
                              (EXIT (NREVERSE #8#)))))
                  (EXIT
                   (COND
                    ((> (LENGTH |u|) 0)
                     (+ 1
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT #6# NIL) (LETT #5# |u|) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT #6# (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #4# #6#)
                                 (COND (#2# (LETT #3# (MIN #3# #4#)))
                                       ('T
                                        (PROGN
                                         (LETT #3# #4#)
                                         (LETT #2# 'T)))))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                         (COND (#2# #3#) (#9# (|IdentityError| '|min|))))))
                    (#9# -1))))))))) 

(SDEFUN |BTCAT-;distance;2AI;6| ((|t1| (A)) (|t2| (A)) ($ (|Integer|)))
        (SPROG ((|n| (|Integer|)))
               (SEQ (LETT |n| (|BTCAT-;distance1| |t1| |t2| $))
                    (EXIT
                     (COND ((>= |n| 0) |n|)
                           ('T (|BTCAT-;distance1| |t2| |t1| $))))))) 

(SDEFUN |BTCAT-;hashUpdate!;HsAHs;7|
        ((|s| (|HashState|)) (|t| (A)) ($ (|HashState|)))
        (SEQ
         (COND ((SPADCALL |t| (QREFELT $ 9)) |s|)
               ('T
                (SEQ
                 (LETT |s|
                       (SPADCALL |s| (SPADCALL |t| (QREFELT $ 13))
                                 (QREFELT $ 34)))
                 (LETT |s|
                       (SPADCALL |s| (SPADCALL |t| (QREFELT $ 11))
                                 (QREFELT $ 35)))
                 (EXIT
                  (SPADCALL |s| (SPADCALL |t| (QREFELT $ 14))
                            (QREFELT $ 35)))))))) 

(DECLAIM (NOTINLINE |BinaryTreeCategory&;|)) 

(DEFUN |BinaryTreeCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|BinaryTreeCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 37))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|BinaryTreeCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (0 . |empty?|) (5 . |empty|) (9 . |left|) (14 . |copy|)
              (19 . |value|) (24 . |right|) (29 . |node|) |BTCAT-;copy;2A;1|
              (|Mapping| 7 7) (36 . |map|) |BTCAT-;map;M2A;2| '"value"
              (42 . |elt|) (48 . |setelt!|) (55 . |map!|) |BTCAT-;map!;M2A;3|
              (|NonNegativeInteger|) (61 . |#|) |BTCAT-;#;ANni;4| (66 . =)
              (|List| $) (72 . |children|) (|Integer|) |BTCAT-;distance;2AI;6|
              (|HashState|) (77 . |hashUpdate!|) (83 . |hashUpdate!|)
              |BTCAT-;hashUpdate!;HsAHs;7|)
           '#(|map!| 89 |map| 95 |hashUpdate!| 101 |distance| 107 |copy| 113
              |#| 118)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|distance| ((|Integer|) |#1| |#1|)) T)
                                   '((|hashUpdate!|
                                      ((|HashState|) (|HashState|) |#1|))
                                     T)
                                   '((|map!| (|#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|map| (|#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|#| ((|NonNegativeInteger|) |#1|)) T)
                                   '((|copy| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 36
                                            '(1 6 8 0 9 0 6 0 10 1 6 0 0 11 1 6
                                              0 0 12 1 6 7 0 13 1 6 0 0 14 3 6
                                              0 0 7 0 15 2 6 0 17 0 18 2 6 7 0
                                              20 21 3 6 7 0 20 7 22 2 6 0 17 0
                                              23 1 6 25 0 26 2 6 8 0 0 28 1 6
                                              29 0 30 2 7 33 33 0 34 2 6 33 33
                                              0 35 2 0 0 17 0 24 2 0 0 17 0 19
                                              2 0 33 33 0 36 2 0 31 0 0 32 1 0
                                              0 0 16 1 0 25 0 27)))))
           '|lookupComplete|)) 

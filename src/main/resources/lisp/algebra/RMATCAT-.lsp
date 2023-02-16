
(SDEFUN |RMATCAT-;size;Nni;1| (($ (|NonNegativeInteger|)))
        (EXPT (SPADCALL (QREFELT $ 13)) (* (QREFELT $ 7) (QREFELT $ 8)))) 

(SDEFUN |RMATCAT-;random;S;2| (($ (S)))
        (SPROG
         ((#1=#:G726 NIL) (|i| NIL) (#2=#:G725 NIL) (#3=#:G724 NIL) (|j| NIL)
          (#4=#:G723 NIL))
         (SEQ
          (SPADCALL
           (PROGN
            (LETT #4# NIL)
            (SEQ (LETT |j| 1) (LETT #3# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |j| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #4#
                         (CONS
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |i| 1) (LETT #1# (QREFELT $ 8)) G190
                                (COND ((|greater_SI| |i| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL (QREFELT $ 15)) #2#))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          #4#))))
                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                 (EXIT (NREVERSE #4#))))
           (QREFELT $ 17))))) 

(SDEFUN |RMATCAT-;lookup;SPi;3| ((|x| (S)) ($ (|PositiveInteger|)))
        (SPROG
         ((#1=#:G732 NIL) (|pow| (|Integer|)) (|res| (|Integer|))
          (#2=#:G736 NIL) (|c| NIL) (#3=#:G735 NIL) (|r| NIL)
          (|l| (|List| (|List| R))) (|s| (|NonNegativeInteger|)))
         (SEQ (LETT |s| (SPADCALL (QREFELT $ 13))) (LETT |pow| 1)
              (LETT |l| (SPADCALL |x| (QREFELT $ 19))) (LETT |res| 1)
              (SEQ (LETT |r| NIL) (LETT #3# |l|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |r| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |c| NIL) (LETT #2# |r|) G190
                          (COND
                           ((OR (ATOM #2#) (PROGN (LETT |c| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (LETT |res|
                                 (+ |res|
                                    (* (- (SPADCALL |c| (QREFELT $ 21)) 1)
                                       |pow|)))
                           (EXIT (LETT |pow| (* |pow| |s|))))
                          (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (PROG1 (LETT #1# |res|)
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|) '(|Integer|)
                                   #1#)))))) 

(SDEFUN |RMATCAT-;index;PiS;4| ((|i| (|PositiveInteger|)) ($ (S)))
        (SPROG
         ((|res| (|List| (|List| R)))
          (|old|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|))))
          (|row| (|List| R)) (|el| (R)) (#1=#:G740 NIL) (#2=#:G748 NIL)
          (|j| NIL) (#3=#:G747 NIL) (|s| (|NonNegativeInteger|)))
         (SEQ (LETT |s| (SPADCALL (QREFELT $ 13)))
              (LETT |old| (DIVIDE2 (- |i| 1) |s|)) (LETT |res| NIL)
              (SEQ (LETT |i| 1) (LETT #3# (QREFELT $ 7)) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ (LETT |row| NIL)
                        (SEQ (LETT |j| 1) (LETT #2# (QREFELT $ 8)) G190
                             (COND ((|greater_SI| |j| #2#) (GO G191)))
                             (SEQ
                              (LETT |el|
                                    (SPADCALL
                                     (PROG1 (LETT #1# (+ (QCDR |old|) 1))
                                       (|check_subtype2| (> #1# 0)
                                                         '(|PositiveInteger|)
                                                         '(|Integer|) #1#))
                                     (QREFELT $ 23)))
                              (LETT |row| (CONS |el| |row|))
                              (EXIT (LETT |old| (DIVIDE2 (QCAR |old|) |s|))))
                             (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT (LETT |res| (CONS (NREVERSE |row|) |res|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL (NREVERSE |res|) (QREFELT $ 17)))))) 

(SDEFUN |RMATCAT-;nrows;SNni;5| ((|x| (S)) ($ (|NonNegativeInteger|)))
        (QREFELT $ 7)) 

(SDEFUN |RMATCAT-;ncols;SNni;6| ((|x| (S)) ($ (|NonNegativeInteger|)))
        (QREFELT $ 8)) 

(SDEFUN |RMATCAT-;square?;SB;7| ((|x| (S)) ($ (|Boolean|)))
        (EQL (QREFELT $ 7) (QREFELT $ 8))) 

(SDEFUN |RMATCAT-;diagonal?;SB;8| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G760 NIL) (#2=#:G761 NIL) (#3=#:G763 NIL) (|j| NIL)
          (#4=#:G762 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (COND ((NULL (SPADCALL |x| (QREFELT $ 29))) NIL)
                 ('T
                  (SEQ
                   (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 31)))
                        (LETT #4# (SPADCALL |x| (QREFELT $ 32))) G190
                        (COND ((> |i| #4#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 33)))
                               (LETT #3# (SPADCALL |x| (QREFELT $ 34))) G190
                               (COND ((> |j| #3#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL
                                    (- |j| (SPADCALL |x| (QREFELT $ 33)))
                                    (- |i| (SPADCALL |x| (QREFELT $ 31)))
                                    (QREFELT $ 35))
                                   (COND
                                    ((NULL
                                      (SPADCALL
                                       (SPADCALL |x| |i| |j| (QREFELT $ 36))
                                       (QREFELT $ 37)))
                                     (PROGN
                                      (LETT #1#
                                            (PROGN
                                             (LETT #2# NIL)
                                             (GO #5=#:G759)))
                                      (GO #6=#:G756))))))))
                               (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                         #6# (EXIT #1#))
                        (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                   (EXIT 'T)))))
          #5# (EXIT #2#)))) 

(SDEFUN |RMATCAT-;symmetric?;SB;9| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G772 NIL) (#2=#:G773 NIL) (#3=#:G775 NIL) (|j| NIL)
          (#4=#:G774 NIL) (|i| NIL) (|mc| (|Integer|)) (|mr| (|Integer|)))
         (SEQ
          (EXIT
           (COND ((SPADCALL (QREFELT $ 7) (QREFELT $ 8) (QREFELT $ 39)) NIL)
                 ('T
                  (SEQ (LETT |mr| (SPADCALL |x| (QREFELT $ 31)))
                       (LETT |mc| (SPADCALL |x| (QREFELT $ 33)))
                       (SEQ (LETT |i| 0) (LETT #4# (- (QREFELT $ 8) 1)) G190
                            (COND ((|greater_SI| |i| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |j| (+ |i| 1))
                                   (LETT #3# (- (QREFELT $ 8) 1)) G190
                                   (COND ((> |j| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((SPADCALL
                                        (SPADCALL |x| (+ |mr| |i|) (+ |mc| |j|)
                                                  (QREFELT $ 36))
                                        (SPADCALL |x| (+ |mr| |j|) (+ |mc| |i|)
                                                  (QREFELT $ 36))
                                        (QREFELT $ 40))
                                       (PROGN
                                        (LETT #1#
                                              (PROGN
                                               (LETT #2# NIL)
                                               (GO #5=#:G771)))
                                        (GO #6=#:G767))))))
                                   (LETT |j| (+ |j| 1)) (GO G190) G191
                                   (EXIT NIL)))
                             #6# (EXIT #1#))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (EXIT 'T)))))
          #5# (EXIT #2#)))) 

(SDEFUN |RMATCAT-;antisymmetric?;SB;10| ((|x| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G784 NIL) (#2=#:G785 NIL) (#3=#:G787 NIL) (|j| NIL)
          (#4=#:G786 NIL) (|i| NIL) (|mc| (|Integer|)) (|mr| (|Integer|))
          (|nRows| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (LETT |nRows| (SPADCALL |x| (QREFELT $ 42)))
                       (SPADCALL |x| (QREFELT $ 43)) (QREFELT $ 39))
             NIL)
            ('T
             (SEQ (LETT |mr| (SPADCALL |x| (QREFELT $ 31)))
                  (LETT |mc| (SPADCALL |x| (QREFELT $ 33)))
                  (SEQ (LETT |i| 0) (LETT #4# (- |nRows| 1)) G190
                       (COND ((|greater_SI| |i| #4#) (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |j| |i|) (LETT #3# (- |nRows| 1)) G190
                              (COND ((> |j| #3#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL
                                   (SPADCALL |x| (+ |mr| |i|) (+ |mc| |j|)
                                             (QREFELT $ 36))
                                   (SPADCALL
                                    (SPADCALL |x| (+ |mr| |j|) (+ |mc| |i|)
                                              (QREFELT $ 36))
                                    (QREFELT $ 44))
                                   (QREFELT $ 40))
                                  (PROGN
                                   (LETT #1#
                                         (PROGN (LETT #2# NIL) (GO #5=#:G783)))
                                   (GO #6=#:G779))))))
                              (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                        #6# (EXIT #1#))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))))
          #5# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |RectangularMatrixCategory&;|)) 

(DEFUN |RectangularMatrixCategory&| (|#1| |#2| |#3| |#4| |#5| |#6|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$6 NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT |dv$|
          (LIST '|RectangularMatrixCategory&| DV$1 DV$2 DV$3 DV$4 DV$5 DV$6))
    (LETT $ (GETREFV 46))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#4|
                                                       '(|EuclideanDomain|))
                                        (|HasCategory| |#4| '(|Field|))
                                        (|HasCategory| |#4|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#4| '(|AbelianGroup|))
                                        (|HasCategory| |#4|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#4| '(|Finite|))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 6)
      (PROGN
       (QSETREFV $ 14 (CONS (|dispatchFunction| |RMATCAT-;size;Nni;1|) $))
       (QSETREFV $ 18 (CONS (|dispatchFunction| |RMATCAT-;random;S;2|) $))
       (QSETREFV $ 22 (CONS (|dispatchFunction| |RMATCAT-;lookup;SPi;3|) $))
       (QSETREFV $ 24 (CONS (|dispatchFunction| |RMATCAT-;index;PiS;4|) $)))))
    (COND
     ((|testBitVector| |pv$| 4)
      (QSETREFV $ 45
                (CONS (|dispatchFunction| |RMATCAT-;antisymmetric?;SB;10|)
                      $))))
    $))) 

(MAKEPROP '|RectangularMatrixCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|NonNegativeInteger|) (0 . |size|) (4 . |size|) (8 . |random|)
              (|List| (|List| 9)) (12 . |matrix|) (17 . |random|)
              (21 . |listOfLists|) (|PositiveInteger|) (26 . |lookup|)
              (31 . |lookup|) (36 . |index|) (41 . |index|)
              |RMATCAT-;nrows;SNni;5| |RMATCAT-;ncols;SNni;6| (|Boolean|)
              |RMATCAT-;square?;SB;7| (46 . |square?|) (|Integer|)
              (51 . |minRowIndex|) (56 . |maxRowIndex|) (61 . |minColIndex|)
              (66 . |maxColIndex|) (71 . ~=) (77 . |qelt|) (84 . |zero?|)
              |RMATCAT-;diagonal?;SB;8| (89 . ~=) (95 . ~=)
              |RMATCAT-;symmetric?;SB;9| (101 . |nrows|) (106 . |ncols|)
              (111 . -) (116 . |antisymmetric?|))
           '#(|symmetric?| 121 |square?| 126 |size| 131 |random| 135 |nrows|
              139 |ncols| 144 |lookup| 149 |index| 154 |diagonal?| 159
              |antisymmetric?| 164)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|size| ((|NonNegativeInteger|))) T)
                                   '((|index| (|#1| (|PositiveInteger|))) T)
                                   '((|lookup| ((|PositiveInteger|) |#1|)) T)
                                   '((|random| (|#1|)) T)
                                   '((|ncols| ((|NonNegativeInteger|) |#1|)) T)
                                   '((|nrows| ((|NonNegativeInteger|) |#1|)) T)
                                   '((|antisymmetric?| ((|Boolean|) |#1|)) T)
                                   '((|symmetric?| ((|Boolean|) |#1|)) T)
                                   '((|diagonal?| ((|Boolean|) |#1|)) T)
                                   '((|square?| ((|Boolean|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 45
                                            '(0 9 12 13 0 0 12 14 0 9 0 15 1 6
                                              0 16 17 0 0 0 18 1 6 16 0 19 1 9
                                              20 0 21 1 0 20 0 22 1 9 0 20 23 1
                                              0 0 20 24 1 6 27 0 29 1 6 30 0 31
                                              1 6 30 0 32 1 6 30 0 33 1 6 30 0
                                              34 2 30 27 0 0 35 3 6 9 0 30 30
                                              36 1 9 27 0 37 2 12 27 0 0 39 2 9
                                              27 0 0 40 1 6 12 0 42 1 6 12 0 43
                                              1 9 0 0 44 1 0 27 0 45 1 0 27 0
                                              41 1 0 27 0 28 0 0 12 14 0 0 0 18
                                              1 0 12 0 25 1 0 12 0 26 1 0 20 0
                                              22 1 0 0 20 24 1 0 27 0 38 1 0 27
                                              0 45)))))
           '|lookupComplete|)) 

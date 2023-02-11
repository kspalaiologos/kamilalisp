
(SDEFUN |LWORD;lyndon?;FmB;1| ((|w| (|FreeMonoid| |VarSet|)) ($ (|Boolean|)))
        (SPROG ((|f| (|FreeMonoid| |VarSet|)) (#1=#:G708 NIL))
               (SEQ
                (EXIT
                 (COND ((SPADCALL |w| (|spadConstant| $ 9) (QREFELT $ 11)) NIL)
                       ('T
                        (SEQ (LETT |f| (SPADCALL |w| (QREFELT $ 12)))
                             (SEQ G190
                                  (COND
                                   ((NULL
                                     (SPADCALL |f| (|spadConstant| $ 9)
                                               (QREFELT $ 13)))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((NULL (SPADCALL |w| |f| (QREFELT $ 14)))
                                      (PROGN (LETT #1# NIL) (GO #2=#:G707)))
                                     ('T
                                      (LETT |f|
                                            (SPADCALL |f| (QREFELT $ 12)))))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT 'T)))))
                #2# (EXIT #1#)))) 

(SDEFUN |LWORD;lyndonIfCan;FmU;2|
        ((|w| (|FreeMonoid| |VarSet|)) ($ (|Union| $ "failed")))
        (SPROG ((|l| (|List| $)))
               (SEQ (LETT |l| (SPADCALL |w| (QREFELT $ 17)))
                    (EXIT
                     (COND
                      ((EQL (SPADCALL |l| (QREFELT $ 20)) 1)
                       (CONS 0 (SPADCALL |l| (QREFELT $ 21))))
                      ('T (CONS 1 "failed"))))))) 

(SDEFUN |LWORD;lyndon;Fm$;3| ((|w| (|FreeMonoid| |VarSet|)) ($ ($)))
        (SPROG ((|l| (|List| $)))
               (SEQ (LETT |l| (SPADCALL |w| (QREFELT $ 17)))
                    (EXIT
                     (COND
                      ((EQL (SPADCALL |l| (QREFELT $ 20)) 1)
                       (SPADCALL |l| (QREFELT $ 21)))
                      ('T (|error| "This word is not a Lyndon word"))))))) 

(SDEFUN |LWORD;LetterList|
        ((|w| (|FreeMonoid| |VarSet|)) ($ (|List| |VarSet|)))
        (COND ((SPADCALL |w| (|spadConstant| $ 9) (QREFELT $ 11)) NIL)
              ('T
               (CONS (SPADCALL |w| (QREFELT $ 25))
                     (|LWORD;LetterList| (SPADCALL |w| (QREFELT $ 12)) $))))) 

(SDEFUN |LWORD;factor1|
        ((|gauche| #1=(|List| $)) (|x| ($)) (|droite| #2=(|List| $))
         ($ (|List| $)))
        (SPROG ((#3=#:G747 NIL) (|g| #1#) (|d| #2#))
               (SEQ
                (EXIT
                 (SEQ (LETT |g| |gauche|) (LETT |d| |droite|)
                      (SEQ G190
                           (COND
                            ((NULL (NULL (SPADCALL |g| (QREFELT $ 26))))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL (SPADCALL |g| '|first| (QREFELT $ 28))
                                         |x| (QREFELT $ 29))
                               (SEQ
                                (LETT |x|
                                      (SPADCALL
                                       (SPADCALL |g| '|first| (QREFELT $ 28))
                                       |x| (QREFELT $ 30)))
                                (EXIT
                                 (COND
                                  ((SPADCALL |d| (QREFELT $ 26))
                                   (LETT |g| (SPADCALL |g| (QREFELT $ 31))))
                                  ('T
                                   (SEQ
                                    (LETT |g|
                                          (SPADCALL |x|
                                                    (SPADCALL |g|
                                                              (QREFELT $ 31))
                                                    (QREFELT $ 32)))
                                    (LETT |x| (SPADCALL |d| (QREFELT $ 21)))
                                    (EXIT
                                     (LETT |d|
                                           (SPADCALL |d|
                                                     (QREFELT $ 31))))))))))
                              ('T
                               (SEQ
                                (LETT |d| (SPADCALL |x| |d| (QREFELT $ 32)))
                                (LETT |x| (SPADCALL |g| (QREFELT $ 21)))
                                (EXIT
                                 (LETT |g| (SPADCALL |g| (QREFELT $ 31)))))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (PROGN
                        (LETT #3# (SPADCALL |x| |d| (QREFELT $ 32)))
                        (GO #4=#:G746)))))
                #4# (EXIT #3#)))) 

(SDEFUN |LWORD;factor;FmL;6| ((|w| (|FreeMonoid| |VarSet|)) ($ (|List| $)))
        (SPROG ((|l| (|List| $)) (#1=#:G753 NIL) (|u| NIL) (#2=#:G752 NIL))
               (SEQ
                (COND ((SPADCALL |w| (|spadConstant| $ 9) (QREFELT $ 11)) NIL)
                      ('T
                       (SEQ
                        (LETT |l|
                              (SPADCALL
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |u| NIL)
                                     (LETT #1# (|LWORD;LetterList| |w| $)) G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |u| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #2#
                                             (CONS
                                              (SPADCALL |u| (QREFELT $ 33))
                                              #2#))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT (NREVERSE #2#))))
                               (QREFELT $ 34)))
                        (EXIT
                         (|LWORD;factor1| (SPADCALL |l| (QREFELT $ 31))
                          (SPADCALL |l| (QREFELT $ 21)) NIL $)))))))) 

(SDEFUN |LWORD;<;2$B;7| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG ((|ly| #1=(|PositiveInteger|)) (|lx| #1#))
               (SEQ (LETT |lx| (SPADCALL |x| (QREFELT $ 36)))
                    (LETT |ly| (SPADCALL |y| (QREFELT $ 36)))
                    (EXIT
                     (COND ((EQL |lx| |ly|) (SPADCALL |x| |y| (QREFELT $ 29)))
                           ('T (< |lx| |ly|))))))) 

(SDEFUN |LWORD;coerce;$Of;8| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 38)) (QREFELT $ 40))
                  (QREFELT $ 41))) 

(PUT '|LWORD;coerce;$Fm;9| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |LWORD;coerce;$Fm;9| ((|x| ($)) ($ (|FreeMagma| |VarSet|))) |x|) 

(SDEFUN |LWORD;LyndonWordsList1;LPiOda;10|
        ((|vl| (|List| |VarSet|)) (|n| (|PositiveInteger|))
         ($ (|OneDimensionalArray| (|List| $))))
        (SPROG
         ((#1=#:G787 NIL) (|lbase1| (|List| $)) (#2=#:G795 NIL) (|b| NIL)
          (#3=#:G794 NIL) (|a| NIL) (#4=#:G793 NIL) (|i| NIL) (#5=#:G792 NIL)
          (#6=#:G791 NIL) (#7=#:G790 NIL) (|ll| NIL) (#8=#:G789 NIL) (|w| NIL)
          (#9=#:G788 NIL) (|base| (|OneDimensionalArray| (|List| $)))
          (#10=#:G760 NIL))
         (SEQ
          (EXIT
           (COND ((NULL |vl|) (|error| "empty list"))
                 ('T
                  (SEQ
                   (LETT |base|
                         (SPADCALL
                          (PROG1 (LETT #10# |n|)
                            (|check_subtype2| (>= #10# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #10#))
                          NIL (QREFELT $ 45)))
                   (LETT |lbase1|
                         (PROGN
                          (LETT #9# NIL)
                          (SEQ (LETT |w| NIL)
                               (LETT #8# (SPADCALL |vl| (QREFELT $ 47))) G190
                               (COND
                                ((OR (ATOM #8#)
                                     (PROGN (LETT |w| (CAR #8#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #9#
                                       (CONS (SPADCALL |w| (QREFELT $ 33))
                                             #9#))))
                               (LETT #8# (CDR #8#)) (GO G190) G191
                               (EXIT (NREVERSE #9#)))))
                   (SPADCALL |base| 1 |lbase1| (QREFELT $ 49))
                   (SEQ (LETT |ll| 2) (LETT #7# |n|) G190
                        (COND ((|greater_SI| |ll| #7#) (GO G191)))
                        (SEQ (LETT |lbase1| NIL)
                             (SEQ (LETT |a| NIL)
                                  (LETT #6# (SPADCALL |base| 1 (QREFELT $ 50)))
                                  G190
                                  (COND
                                   ((OR (ATOM #6#)
                                        (PROGN (LETT |a| (CAR #6#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (SEQ (LETT |b| NIL)
                                         (LETT #5#
                                               (SPADCALL |base| (- |ll| 1)
                                                         (QREFELT $ 50)))
                                         G190
                                         (COND
                                          ((OR (ATOM #5#)
                                               (PROGN
                                                (LETT |b| (CAR #5#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((SPADCALL |a| |b| (QREFELT $ 29))
                                             (LETT |lbase1|
                                                   (SPADCALL
                                                    (SPADCALL |a| |b|
                                                              (QREFELT $ 30))
                                                    |lbase1|
                                                    (QREFELT $ 32)))))))
                                         (LETT #5# (CDR #5#)) (GO G190) G191
                                         (EXIT NIL))))
                                  (LETT #6# (CDR #6#)) (GO G190) G191
                                  (EXIT NIL))
                             (SEQ (LETT |i| 2) (LETT #4# (- |ll| 1)) G190
                                  (COND ((|greater_SI| |i| #4#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (SEQ (LETT |a| NIL)
                                         (LETT #3#
                                               (SPADCALL |base| |i|
                                                         (QREFELT $ 50)))
                                         G190
                                         (COND
                                          ((OR (ATOM #3#)
                                               (PROGN
                                                (LETT |a| (CAR #3#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (SEQ (LETT |b| NIL)
                                                (LETT #2#
                                                      (SPADCALL |base|
                                                                (- |ll| |i|)
                                                                (QREFELT $
                                                                         50)))
                                                G190
                                                (COND
                                                 ((OR (ATOM #2#)
                                                      (PROGN
                                                       (LETT |b| (CAR #2#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (COND
                                                   ((SPADCALL |a| |b|
                                                              (QREFELT $ 29))
                                                    (COND
                                                     ((OR
                                                       (SPADCALL |b|
                                                                 (SPADCALL |a|
                                                                           (QREFELT
                                                                            $
                                                                            51))
                                                                 (QREFELT $
                                                                          29))
                                                       (SPADCALL |b|
                                                                 (SPADCALL |a|
                                                                           (QREFELT
                                                                            $
                                                                            51))
                                                                 (QREFELT $
                                                                          52)))
                                                      (LETT |lbase1|
                                                            (SPADCALL
                                                             (SPADCALL |a| |b|
                                                                       (QREFELT
                                                                        $ 30))
                                                             |lbase1|
                                                             (QREFELT $
                                                                      32)))))))))
                                                (LETT #2# (CDR #2#)) (GO G190)
                                                G191 (EXIT NIL))))
                                         (LETT #3# (CDR #3#)) (GO G190) G191
                                         (EXIT NIL))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT
                              (SPADCALL |base| |ll|
                                        (SPADCALL (ELT $ 29) |lbase1|
                                                  (QREFELT $ 54))
                                        (QREFELT $ 49))))
                        (LETT |ll| (|inc_SI| |ll|)) (GO G190) G191 (EXIT NIL))
                   (EXIT (PROGN (LETT #1# |base|) (GO #11=#:G786)))))))
          #11# (EXIT #1#)))) 

(SDEFUN |LWORD;LyndonWordsList;LPiL;11|
        ((|vl| (|List| |VarSet|)) (|n| (|PositiveInteger|)) ($ (|List| $)))
        (SPROG
         ((#1=#:G797 NIL) (#2=#:G796 #3=(|List| $)) (#4=#:G798 #3#)
          (#5=#:G801 NIL) (|i| NIL) (|v| (|OneDimensionalArray| (|List| $))))
         (SEQ (LETT |v| (SPADCALL |vl| |n| (QREFELT $ 56)))
              (EXIT
               (PROGN
                (LETT #1# NIL)
                (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                     (COND ((|greater_SI| |i| #5#) (GO G191)))
                     (SEQ
                      (EXIT
                       (PROGN
                        (LETT #4# (SPADCALL |v| |i| (QREFELT $ 50)))
                        (COND
                         (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 57))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (COND (#1# #2#) ('T NIL))))))) 

(DECLAIM (NOTINLINE |LyndonWord;|)) 

(DEFUN |LyndonWord| (#1=#:G805)
  (SPROG NIL
         (PROG (#2=#:G806)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|LyndonWord|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|LyndonWord;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|LyndonWord|)))))))))) 

(DEFUN |LyndonWord;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|LyndonWord| DV$1))
          (LETT $ (GETREFV 63))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|LyndonWord| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|FreeMagma| |#1|))
          $))) 

(MAKEPROP '|LyndonWord| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|FreeMagma| 6) (|local| |#1|) '|Rep|
              (|FreeMonoid| 6) (0 . |One|) (|Boolean|) (4 . =) (10 . |rest|)
              (15 . ~=) (21 . |lexico|) |LWORD;lyndon?;FmB;1| (|List| $)
              |LWORD;factor;FmL;6| (|NonNegativeInteger|) (|List| $$)
              (27 . |#|) (32 . |first|) (|Union| $ '"failed")
              |LWORD;lyndonIfCan;FmU;2| |LWORD;lyndon;Fm$;3| (37 . |first|)
              (42 . |empty?|) '"first" (47 . |elt|) (53 . |lexico|) (59 . *)
              (65 . |rest|) (70 . |cons|) (76 . |coerce|) (81 . |reverse|)
              (|PositiveInteger|) (86 . |length|) |LWORD;<;2$B;7|
              (91 . |coerce|) (|OutputForm|) (96 . |coerce|) (101 . |bracket|)
              |LWORD;coerce;$Of;8| |LWORD;coerce;$Fm;9|
              (|OneDimensionalArray| 19) (106 . |new|) (|List| 6)
              (112 . |sort|) (|Integer|) (117 . |setelt!|) (124 . |elt|)
              (130 . |right|) (135 . =) (|Mapping| 10 $$ $$) (141 . |sort!|)
              (|OneDimensionalArray| 16) |LWORD;LyndonWordsList1;LPiOda;10|
              (147 . |append|) |LWORD;LyndonWordsList;LPiL;11|
              (|Union| 6 '"failed") (|HashState|) (|String|) (|SingleInteger|))
           '#(~= 153 |varList| 159 |smaller?| 164 |right| 170 |retractable?|
              175 |retractIfCan| 180 |retract| 185 |min| 190 |max| 196
              |lyndonIfCan| 202 |lyndon?| 207 |lyndon| 212 |lexico| 217
              |length| 223 |left| 228 |latex| 233 |hashUpdate!| 238 |hash| 244
              |factor| 249 |coerce| 254 |LyndonWordsList1| 274
              |LyndonWordsList| 280 >= 286 > 292 = 298 <= 304 < 310)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|OrderedSet&| NIL |SetCategory&| |RetractableTo&|
                     |BasicType&| NIL |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedSet|) (|Comparable|) (|SetCategory|)
                      (|RetractableTo| 6) (|BasicType|) (|CoercibleFrom| 6)
                      (|PartialOrder|) (|CoercibleTo| 39))
                   (|makeByteWordVec2| 62
                                       '(0 8 0 9 2 8 10 0 0 11 1 8 0 0 12 2 8
                                         10 0 0 13 2 8 10 0 0 14 1 19 18 0 20 1
                                         19 2 0 21 1 8 6 0 25 1 19 10 0 26 2 19
                                         2 0 27 28 2 0 10 0 0 29 2 7 0 0 0 30 1
                                         19 0 0 31 2 19 0 2 0 32 1 0 0 6 33 1
                                         19 0 0 34 1 0 35 0 36 1 0 8 0 38 1 8
                                         39 0 40 1 39 0 0 41 2 44 0 18 19 45 1
                                         46 0 0 47 3 44 19 0 48 19 49 2 44 19 0
                                         48 50 1 0 0 0 51 2 0 10 0 0 52 2 19 0
                                         53 0 54 2 19 0 0 0 57 2 0 10 0 0 1 1 0
                                         46 0 1 2 0 10 0 0 1 1 0 0 0 51 1 0 10
                                         0 1 1 0 59 0 1 1 0 6 0 1 2 0 0 0 0 1 2
                                         0 0 0 0 1 1 0 22 8 23 1 0 10 8 15 1 0
                                         0 8 24 2 0 10 0 0 29 1 0 35 0 36 1 0 0
                                         0 1 1 0 61 0 1 2 0 60 60 0 1 1 0 62 0
                                         1 1 0 16 8 17 1 0 8 0 38 1 0 5 0 43 1
                                         0 0 6 33 1 0 39 0 42 2 0 55 46 35 56 2
                                         0 16 46 35 58 2 0 10 0 0 1 2 0 10 0 0
                                         1 2 0 10 0 0 52 2 0 10 0 0 1 2 0 10 0
                                         0 37)))))
           '|lookupComplete|)) 

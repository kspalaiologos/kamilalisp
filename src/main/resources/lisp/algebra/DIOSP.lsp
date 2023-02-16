
(SDEFUN |DIOSP;dioSolve;ER;1|
        ((|eq| (|Equation| (|Polynomial| (|Integer|))))
         ($
          (|Record| (|:| |varOrder| (|List| (|Symbol|)))
                    (|:| |inhom|
                         (|Union| (|List| (|Vector| (|NonNegativeInteger|)))
                                  "failed"))
                    (|:| |hom| (|List| (|Vector| (|NonNegativeInteger|)))))))
        (SPROG
         ((|vars| (|List| (|Symbol|))) (#1=#:G733 NIL) (|x| NIL)
          (#2=#:G732 NIL) (|ihs| #3=(|List| (|Vector| (|NonNegativeInteger|))))
          (|hs| #3#) (|sol| (|Vector| (|NonNegativeInteger|)))
          (|graph|
           (|Record|
            (|:| |vn|
                 (|Vector|
                  (|Record| (|:| |vert| (|Vector| (|Integer|)))
                            (|:| |is_free| (|Boolean|)))))
            (|:| |dim| (|NonNegativeInteger|)) (|:| |zeroNode| (|Integer|))))
          (|mon| (|List| (|Polynomial| (|Integer|)))) (|c| (|Integer|))
          (#4=#:G731 NIL) (|n| (|NonNegativeInteger|))
          (|p| (|Polynomial| (|Integer|))))
         (SEQ
          (LETT |p|
                (SPADCALL (SPADCALL |eq| (QREFELT $ 8))
                          (SPADCALL |eq| (QREFELT $ 9)) (QREFELT $ 10)))
          (LETT |n| (SPADCALL |p| (QREFELT $ 12)))
          (COND
           ((OR (EQL |n| 0) (> |n| 1))
            (EXIT (|error| "a linear Diophantine equation is expected"))))
          (LETT |mon| NIL) (LETT |c| 0)
          (SEQ (LETT |x| NIL) (LETT #4# (SPADCALL |p| (QREFELT $ 14))) G190
               (COND
                ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL)) (GO G191)))
               (SEQ
                (EXIT
                 (COND
                  ((SPADCALL |x| (QREFELT $ 16))
                   (LETT |c| (SPADCALL |x| (QREFELT $ 18))))
                  ('T (LETT |mon| (CONS |x| |mon|))))))
               (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
          (LETT |graph| (|DIOSP;initializeGraph| |mon| |c| $))
          (LETT |sol| (SPADCALL (QVELT |graph| 1) (QREFELT $ 20)))
          (LETT |hs|
                (|DIOSP;findSolutions| |sol| (QVELT |graph| 2) 1 1 |graph| 'T
                 $))
          (LETT |ihs|
                (COND ((EQL |c| 0) (LIST |sol|))
                      (#5='T
                       (|DIOSP;findSolutions| |sol| (+ (QVELT |graph| 2) |c|) 1
                        1 |graph| NIL $))))
          (LETT |vars|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |x| NIL) (LETT #1# |mon|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (|SPADfirst| (SPADCALL |x| (QREFELT $ 22)))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (VECTOR |vars|
                   (COND ((NULL |ihs|) (CONS 1 "failed")) (#5# (CONS 0 |ihs|)))
                   |hs|))))) 

(SDEFUN |DIOSP;initializeGraph|
        ((|mon| (|List| (|Polynomial| (|Integer|)))) (|c| (|Integer|))
         ($
          (|Record|
           (|:| |vn|
                (|Vector|
                 (|Record| (|:| |vert| (|Vector| (|Integer|)))
                           (|:| |is_free| (|Boolean|)))))
           (|:| |dim| (|NonNegativeInteger|)) (|:| |zeroNode| (|Integer|)))))
        (SPROG
         ((#1=#:G750 NIL) (#2=#:G752 NIL) (|i| NIL) (#3=#:G751 NIL)
          (|n| (|Integer|)) (|m| (|Integer|)) (|k| (|NonNegativeInteger|))
          (|coeffs| (|Vector| (|Integer|))) (#4=#:G749 NIL) (|x| NIL)
          (#5=#:G748 NIL))
         (SEQ
          (LETT |coeffs|
                (SPADCALL
                 (PROGN
                  (LETT #5# NIL)
                  (SEQ (LETT |x| NIL) (LETT #4# |mon|) G190
                       (COND
                        ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #5#
                               (CONS
                                (|SPADfirst| (SPADCALL |x| (QREFELT $ 27)))
                                #5#))))
                       (LETT #4# (CDR #4#)) (GO G190) G191
                       (EXIT (NREVERSE #5#))))
                 (QREFELT $ 29)))
          (LETT |k| (QVSIZE |coeffs|))
          (LETT |m| (MIN |c| (SPADCALL (ELT $ 30) |coeffs| (QREFELT $ 32))))
          (LETT |n| (MAX |c| (SPADCALL (ELT $ 33) |coeffs| (QREFELT $ 32))))
          (EXIT
           (VECTOR
            (PROGN
             (LETT #3# (GETREFV (|inc_SI| (- |n| |m|))))
             (SEQ (LETT |i| |m|) (LETT #2# |n|) (LETT #1# 0) G190
                  (COND ((> |i| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (SETELT #3# #1#
                            (|DIOSP;createNode| |i| |coeffs| |k| (- 1 |m|)
                             $))))
                  (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |i| (+ |i| 1))))
                  (GO G190) G191 (EXIT NIL))
             #3#)
            |k| (- 1 |m|)))))) 

(SDEFUN |DIOSP;createNode|
        ((|ind| (|Integer|)) (|coeffs| (|Vector| (|Integer|)))
         (|k| (|NonNegativeInteger|)) (|zeroNode| (|Integer|))
         ($
          (|Record| (|:| |vert| (|Vector| (|Integer|)))
                    (|:| |is_free| (|Boolean|)))))
        (SPROG
         ((#1=#:G761 NIL) (#2=#:G760 NIL) (#3=#:G762 NIL) (|i| NIL)
          (|v| (|Vector| (|Integer|))))
         (SEQ (LETT |v| (SPADCALL |k| (QREFELT $ 34)))
              (SEQ (LETT |i| 1) (LETT #3# |k|) G190
                   (COND ((|greater_SI| |i| #3#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> |ind| 0)
                       (SEQ
                        (EXIT
                         (COND
                          ((< (SPADCALL |coeffs| |i| (QREFELT $ 35)) 0)
                           (PROGN
                            (LETT #2#
                                  (SPADCALL |v| |i|
                                            (+ (+ |zeroNode| |ind|)
                                               (SPADCALL |coeffs| |i|
                                                         (QREFELT $ 35)))
                                            (QREFELT $ 36)))
                            (GO #4=#:G755)))))
                        #4# (EXIT #2#)))
                      ('T
                       (SEQ
                        (EXIT
                         (COND
                          ((> (SPADCALL |coeffs| |i| (QREFELT $ 35)) 0)
                           (PROGN
                            (LETT #1#
                                  (SPADCALL |v| |i|
                                            (+ (+ |zeroNode| |ind|)
                                               (SPADCALL |coeffs| |i|
                                                         (QREFELT $ 35)))
                                            (QREFELT $ 36)))
                            (GO #5=#:G756)))))
                        #5# (EXIT #1#))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |v| 'T))))) 

(SDEFUN |DIOSP;findSolutions|
        ((|sol| (|Vector| (|NonNegativeInteger|))) (|ind| (|Integer|))
         (|m| (|Integer|)) (|n| #1=(|Integer|))
         (|graph|
          (|Record|
           (|:| |vn|
                (|Vector|
                 (|Record| (|:| |vert| #2=(|Vector| (|Integer|)))
                           (|:| |is_free| (|Boolean|)))))
           (|:| |dim| (|NonNegativeInteger|)) (|:| |zeroNode| (|Integer|))))
         (|flag| (|Boolean|)) ($ (|List| (|Vector| (|NonNegativeInteger|)))))
        (SPROG
         ((|sols| (|List| (|Vector| (|NonNegativeInteger|))))
          (|s| (|List| (|Vector| (|NonNegativeInteger|))))
          (|x| (|NonNegativeInteger|)) (#3=#:G778 NIL) (|i| NIL) (|k| #1#)
          (|v| #2#)
          (|node|
           (|Record| (|:| |vert| (|Vector| (|Integer|)))
                     (|:| |is_free| (|Boolean|)))))
         (SEQ (LETT |sols| NIL)
              (LETT |node| (SPADCALL (QVELT |graph| 0) |ind| (QREFELT $ 39)))
              (EXIT
               (COND
                ((QCDR |node|)
                 (SEQ (PROGN (RPLACD |node| NIL) (QCDR |node|))
                      (LETT |v| (QCAR |node|))
                      (LETT |k|
                            (COND ((< |ind| (QVELT |graph| 2)) |m|)
                                  (#4='T |n|)))
                      (SEQ (LETT |i| |k|) (LETT #3# (QVELT |graph| 1)) G190
                           (COND ((> |i| #3#) (GO G191)))
                           (SEQ (LETT |x| (SPADCALL |sol| |i| (QREFELT $ 40)))
                                (EXIT
                                 (COND
                                  ((> (SPADCALL |v| |i| (QREFELT $ 35)) 0)
                                   (SEQ
                                    (SPADCALL |sol| |i| (+ |x| 1)
                                              (QREFELT $ 41))
                                    (EXIT
                                     (COND
                                      ((EQL (SPADCALL |v| |i| (QREFELT $ 35))
                                            (QVELT |graph| 2))
                                       (COND
                                        ((|DIOSP;verifyMinimality| |sol|
                                          |graph| |flag| $)
                                         (SEQ
                                          (LETT |sols|
                                                (CONS
                                                 (SPADCALL |sol|
                                                           (QREFELT $ 42))
                                                 |sols|))
                                          (EXIT
                                           (SPADCALL |sol| |i| |x|
                                                     (QREFELT $ 41)))))
                                        ('T
                                         (SPADCALL |sol| |i| |x|
                                                   (QREFELT $ 41)))))
                                      ('T
                                       (SEQ
                                        (LETT |s|
                                              (COND
                                               ((< |ind| (QVELT |graph| 2))
                                                (|DIOSP;findSolutions| |sol|
                                                 (SPADCALL |v| |i|
                                                           (QREFELT $ 35))
                                                 |i| |n| |graph| |flag| $))
                                               ('T
                                                (|DIOSP;findSolutions| |sol|
                                                 (SPADCALL |v| |i|
                                                           (QREFELT $ 35))
                                                 |m| |i| |graph| |flag| $))))
                                        (LETT |sols|
                                              (SPADCALL |s| |sols|
                                                        (QREFELT $ 44)))
                                        (EXIT
                                         (SPADCALL |sol| |i| |x|
                                                   (QREFELT $ 41))))))))))))
                           (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                      (PROGN (RPLACD |node| 'T) (QCDR |node|)) (EXIT |sols|)))
                (#4# |sols|)))))) 

(SDEFUN |DIOSP;verifyMinimality|
        ((|sol| (|Vector| (|NonNegativeInteger|)))
         (|graph|
          (|Record|
           (|:| |vn|
                (|Vector|
                 (|Record| (|:| |vert| (|Vector| (|Integer|)))
                           (|:| |is_free| (|Boolean|)))))
           (|:| |dim| (|NonNegativeInteger|)) (|:| |zeroNode| (|Integer|))))
         (|flag| (|Boolean|)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G782 NIL) (|x| (|NonNegativeInteger|))
          (|i| (|NonNegativeInteger|)))
         (SEQ
          (COND
           (|flag|
            (SEQ (LETT |i| 1)
                 (SEQ G190
                      (COND
                       ((NULL (EQL (SPADCALL |sol| |i| (QREFELT $ 40)) 0))
                        (GO G191)))
                      (SEQ (EXIT (LETT |i| (+ |i| 1)))) NIL (GO G190) G191
                      (EXIT NIL))
                 (LETT |x| (SPADCALL |sol| |i| (QREFELT $ 40)))
                 (SPADCALL |sol| |i|
                           (PROG1 (LETT #1# (- |x| 1))
                             (|check_subtype2| (>= #1# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #1#))
                           (QREFELT $ 41))
                 (LETT |flag|
                       (|DIOSP;verifySolution| |sol| (QVELT |graph| 2) 1 1
                        |graph| $))
                 (SPADCALL |sol| |i| |x| (QREFELT $ 41)) (EXIT |flag|)))
           ('T
            (|DIOSP;verifySolution| |sol| (QVELT |graph| 2) 1 1 |graph| $)))))) 

(SDEFUN |DIOSP;verifySolution|
        ((|sol| (|Vector| (|NonNegativeInteger|))) (|ind| (|Integer|))
         (|m| (|Integer|)) (|n| #1=(|Integer|))
         (|graph|
          (|Record|
           (|:| |vn|
                (|Vector|
                 (|Record| (|:| |vert| #2=(|Vector| (|Integer|)))
                           (|:| |is_free| (|Boolean|)))))
           (|:| |dim| (|NonNegativeInteger|)) (|:| |zeroNode| (|Integer|))))
         ($ (|Boolean|)))
        (SPROG
         ((#3=#:G799 NIL) (|flag| (|Boolean|)) (#4=#:G789 NIL)
          (|x| (|NonNegativeInteger|)) (#5=#:G800 NIL) (|i| NIL) (|k| #1#)
          (|v| #2#)
          (|node|
           (|Record| (|:| |vert| (|Vector| (|Integer|)))
                     (|:| |is_free| (|Boolean|)))))
         (SEQ (LETT |flag| 'T)
              (LETT |node| (SPADCALL (QVELT |graph| 0) |ind| (QREFELT $ 39)))
              (LETT |v| (QCAR |node|))
              (LETT |k| (COND ((< |ind| (QVELT |graph| 2)) |m|) ('T |n|)))
              (SEQ (LETT |i| |k|) (LETT #5# (QVELT |graph| 1)) G190
                   (COND ((OR (> |i| #5#) (NULL |flag|)) (GO G191)))
                   (SEQ (LETT |x| (SPADCALL |sol| |i| (QREFELT $ 40)))
                        (EXIT
                         (COND
                          ((> |x| 0)
                           (SEQ
                            (EXIT
                             (COND
                              ((> (SPADCALL |v| |i| (QREFELT $ 35)) 0)
                               (PROGN
                                (LETT #3#
                                      (SEQ
                                       (SPADCALL |sol| |i|
                                                 (PROG1 (LETT #4# (- |x| 1))
                                                   (|check_subtype2| (>= #4# 0)
                                                                     '(|NonNegativeInteger|)
                                                                     '(|Integer|)
                                                                     #4#))
                                                 (QREFELT $ 41))
                                       (EXIT
                                        (COND
                                         ((EQL
                                           (SPADCALL |v| |i| (QREFELT $ 35))
                                           (QVELT |graph| 2))
                                          (SEQ (LETT |flag| NIL)
                                               (EXIT
                                                (SPADCALL |sol| |i| |x|
                                                          (QREFELT $ 41)))))
                                         ('T
                                          (SEQ
                                           (LETT |flag|
                                                 (COND
                                                  ((< |ind| (QVELT |graph| 2))
                                                   (|DIOSP;verifySolution|
                                                    |sol|
                                                    (SPADCALL |v| |i|
                                                              (QREFELT $ 35))
                                                    |i| |n| |graph| $))
                                                  ('T
                                                   (|DIOSP;verifySolution|
                                                    |sol|
                                                    (SPADCALL |v| |i|
                                                              (QREFELT $ 35))
                                                    |m| |i| |graph| $))))
                                           (EXIT
                                            (SPADCALL |sol| |i| |x|
                                                      (QREFELT $ 41)))))))))
                                (GO #6=#:G794)))))
                            #6# (EXIT #3#))))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT |flag|)))) 

(DECLAIM (NOTINLINE |DiophantineSolutionPackage;|)) 

(DEFUN |DiophantineSolutionPackage| ()
  (SPROG NIL
         (PROG (#1=#:G802)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|DiophantineSolutionPackage|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|DiophantineSolutionPackage|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|DiophantineSolutionPackage;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|DiophantineSolutionPackage|)))))))))) 

(DEFUN |DiophantineSolutionPackage;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|DiophantineSolutionPackage|))
          (LETT $ (GETREFV 45))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DiophantineSolutionPackage| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DiophantineSolutionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Polynomial| 17) (|Equation| 6)
              (0 . |lhs|) (5 . |rhs|) (10 . -) (|NonNegativeInteger|)
              (16 . |totalDegree|) (|List| $) (21 . |monomials|) (|Boolean|)
              (26 . |ground?|) (|Integer|) (31 . |ground|) (|Vector| 11)
              (36 . |zero|) (|List| (|Symbol|)) (41 . |variables|)
              (|Union| 43 '#1="failed")
              (|Record| (|:| |varOrder| 21) (|:| |inhom| 23) (|:| |hom| 43))
              |DIOSP;dioSolve;ER;1| (|List| 17) (46 . |coefficients|)
              (|Vector| 17) (51 . |vector|) (56 . |min|) (|Mapping| 17 17 17)
              (62 . |reduce|) (68 . |max|) (74 . |zero|) (79 . |elt|)
              (85 . |setelt!|) (|Record| (|:| |vert| 28) (|:| |is_free| 15))
              (|Vector| 37) (92 . |elt|) (98 . |elt|) (104 . |setelt!|)
              (111 . |copy|) (|List| 19) (116 . |append|))
           '#(|dioSolve| 122) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|dioSolve|
                                 ((|Record|
                                   (|:| |varOrder| (|List| (|Symbol|)))
                                   (|:| |inhom|
                                        (|Union|
                                         (|List|
                                          (|Vector| (|NonNegativeInteger|)))
                                         #1#))
                                   (|:| |hom|
                                        (|List|
                                         (|Vector| (|NonNegativeInteger|)))))
                                  (|Equation| (|Polynomial| (|Integer|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 44
                                            '(1 7 6 0 8 1 7 6 0 9 2 6 0 0 0 10
                                              1 6 11 0 12 1 6 13 0 14 1 6 15 0
                                              16 1 6 17 0 18 1 19 0 11 20 1 6
                                              21 0 22 1 6 26 0 27 1 28 0 26 29
                                              2 17 0 0 0 30 2 28 17 31 0 32 2
                                              17 0 0 0 33 1 28 0 11 34 2 28 17
                                              0 17 35 3 28 17 0 17 17 36 2 38
                                              37 0 17 39 2 19 11 0 17 40 3 19
                                              11 0 17 11 41 1 19 0 0 42 2 43 0
                                              0 0 44 1 0 24 7 25)))))
           '|lookupComplete|)) 

(MAKEPROP '|DiophantineSolutionPackage| 'NILADIC T) 

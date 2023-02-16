
(SDEFUN |RINTERP;interpolate;2L2NniF;1|
        ((|xlist| (|List| F)) (|ylist| (|List| F)) (|m| (|NonNegativeInteger|))
         (|k| (|NonNegativeInteger|)) ($ (|Fraction| (|Polynomial| F))))
        (SPROG
         ((|reslist| (|List| (|List| (|Polynomial| F)))) (#1=#:G759 NIL)
          (|i| NIL) (#2=#:G758 NIL) (#3=#:G757 NIL) (#4=#:G756 NIL)
          (|res| (|List| (|Vector| F))) (|collist| (|List| (|List| F)))
          (#5=#:G755 NIL) (#6=#:G754 NIL) (#7=#:G753 NIL) (|j| NIL)
          (#8=#:G752 NIL) (#9=#:G751 NIL) (#10=#:G750 NIL)
          (|tempvec| (|List| F)) (#11=#:G749 NIL) (#12=#:G748 NIL)
          (#13=#:G747 NIL) (#14=#:G746 NIL) (#15=#:G745 NIL) (#16=#:G744 NIL))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |xlist|) (LENGTH |ylist|) (QREFELT $ 10))
            (|error| "Different number of points and values."))
           ((SPADCALL (LENGTH |xlist|) (+ (+ |m| |k|) 1) (QREFELT $ 10))
            (|error| "wrong number of points"))
           ('T
            (SEQ
             (LETT |tempvec|
                   (PROGN
                    (LETT #16# NIL)
                    (SEQ (LETT |i| 1) (LETT #15# (+ (+ |m| |k|) 1)) G190
                         (COND ((|greater_SI| |i| #15#) (GO G191)))
                         (SEQ
                          (EXIT (LETT #16# (CONS (|spadConstant| $ 11) #16#))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                         (EXIT (NREVERSE #16#)))))
             (LETT |collist|
                   (CONS |tempvec|
                         (PROGN
                          (LETT #14# NIL)
                          (SEQ (LETT |j| 1) (LETT #13# (MAX |m| |k|)) G190
                               (COND ((|greater_SI| |j| #13#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #14#
                                       (CONS
                                        (LETT |tempvec|
                                              (PROGN
                                               (LETT #12# NIL)
                                               (SEQ (LETT |i| 1)
                                                    (LETT #11#
                                                          (+ (+ |m| |k|) 1))
                                                    G190
                                                    (COND
                                                     ((|greater_SI| |i| #11#)
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (LETT #12#
                                                            (CONS
                                                             (SPADCALL
                                                              (SPADCALL
                                                               |tempvec| |i|
                                                               (QREFELT $ 14))
                                                              (SPADCALL |xlist|
                                                                        |i|
                                                                        (QREFELT
                                                                         $ 14))
                                                              (QREFELT $ 15))
                                                             #12#))))
                                                    (LETT |i| (|inc_SI| |i|))
                                                    (GO G190) G191
                                                    (EXIT (NREVERSE #12#)))))
                                        #14#))))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT (NREVERSE #14#))))))
             (LETT |collist|
                   (SPADCALL
                    (PROGN
                     (LETT #10# NIL)
                     (SEQ (LETT |j| 1) (LETT #9# (+ |m| 1)) G190
                          (COND ((|greater_SI| |j| #9#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #10#
                                  (CONS (SPADCALL |collist| |j| (QREFELT $ 19))
                                        #10#))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT (NREVERSE #10#))))
                    (PROGN
                     (LETT #8# NIL)
                     (SEQ (LETT |j| 1) (LETT #7# (+ |k| 1)) G190
                          (COND ((|greater_SI| |j| #7#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #8#
                                  (CONS
                                   (PROGN
                                    (LETT #6# NIL)
                                    (SEQ (LETT |i| 1)
                                         (LETT #5# (+ (+ |m| |k|) 1)) G190
                                         (COND
                                          ((|greater_SI| |i| #5#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #6#
                                                 (CONS
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |collist| |j|
                                                               (QREFELT $ 19))
                                                     |i| (QREFELT $ 14))
                                                    (SPADCALL |ylist| |i|
                                                              (QREFELT $ 14))
                                                    (QREFELT $ 15))
                                                   (QREFELT $ 20))
                                                  #6#))))
                                         (LETT |i| (|inc_SI| |i|)) (GO G190)
                                         G191 (EXIT (NREVERSE #6#))))
                                   #8#))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT (NREVERSE #8#))))
                    (QREFELT $ 21)))
             (LETT |res|
                   (SPADCALL
                    (SPADCALL (SPADCALL |collist| (QREFELT $ 23))
                              (QREFELT $ 24))
                    (QREFELT $ 26)))
             (COND
              ((SPADCALL (LENGTH |res|) 1 (QREFELT $ 10))
               (SPADCALL "Warning: unattainable points!" (QREFELT $ 30))))
             (LETT |reslist|
                   (LIST
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |i| 0) (LETT #3# |m|) G190
                          (COND ((|greater_SI| |i| #3#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |res| 1 (QREFELT $ 32))
                                              (+ |i| 1) (QREFELT $ 33))
                                    (SPADCALL
                                     (SPADCALL (QREFELT $ 6) (QREFELT $ 36))
                                     |i| (QREFELT $ 37))
                                    (QREFELT $ 38))
                                   #4#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #4#))))
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |i| 0) (LETT #1# |k|) G190
                          (COND ((|greater_SI| |i| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |res| 1 (QREFELT $ 32))
                                              (+ (+ |i| |m|) 2) (QREFELT $ 33))
                                    (SPADCALL
                                     (SPADCALL (QREFELT $ 6) (QREFELT $ 36))
                                     |i| (QREFELT $ 37))
                                    (QREFELT $ 38))
                                   #2#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #2#))))))
             (EXIT
              (SPADCALL
               (SPADCALL (ELT $ 39) (SPADCALL |reslist| 1 (QREFELT $ 42))
                         (QREFELT $ 44))
               (SPADCALL (ELT $ 39) (SPADCALL |reslist| 2 (QREFELT $ 42))
                         (QREFELT $ 44))
               (QREFELT $ 45))))))))) 

(DECLAIM (NOTINLINE |RationalInterpolation;|)) 

(DEFUN |RationalInterpolation| (&REST #1=#:G760)
  (SPROG NIL
         (PROG (#2=#:G761)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|RationalInterpolation|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RationalInterpolation;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RationalInterpolation|)))))))))) 

(DEFUN |RationalInterpolation;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|RationalInterpolation| DV$1 DV$2))
          (LETT $ (GETREFV 47))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalInterpolation|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RationalInterpolation| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (|NonNegativeInteger|) (0 . ~=) (6 . |One|) (|Integer|)
              (|List| 7) (10 . |elt|) (16 . *) (|Fraction| 35) (22 . |One|)
              (|List| 13) (26 . |elt|) (32 . -) (37 . |append|) (|Matrix| 7)
              (43 . |matrix|) (48 . |transpose|) (|List| 31) (53 . |nullSpace|)
              (|Void|) (|String|) (|OutputPackage|) (58 . |output|)
              (|Vector| 7) (63 . |elt|) (69 . |elt|) (|Symbol|)
              (|Polynomial| 7) (75 . |coerce|) (80 . ^) (86 . *) (92 . +)
              (|List| 35) (|List| 40) (98 . |elt|) (|Mapping| 35 35 35)
              (104 . |reduce|) (110 . /) |RINTERP;interpolate;2L2NniF;1|)
           '#(|interpolate| 116) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|interpolate|
                                 ((|Fraction| (|Polynomial| |#2|))
                                  (|List| |#2|) (|List| |#2|)
                                  (|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 46
                                            '(2 9 8 0 0 10 0 7 0 11 2 13 7 0 12
                                              14 2 7 0 0 0 15 0 16 0 17 2 18 13
                                              0 12 19 1 7 0 0 20 2 18 0 0 0 21
                                              1 22 0 18 23 1 22 0 0 24 1 22 25
                                              0 26 1 29 27 28 30 2 25 31 0 12
                                              32 2 31 7 0 12 33 1 35 0 34 36 2
                                              35 0 0 9 37 2 35 0 7 0 38 2 35 0
                                              0 0 39 2 41 40 0 12 42 2 40 35 43
                                              0 44 2 16 0 35 35 45 4 0 16 13 13
                                              9 9 46)))))
           '|lookupComplete|)) 

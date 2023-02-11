
(SDEFUN |FFCAT-;Q2RF| ((|q| (|Fraction| F)) ($ (|Fraction| UP)))
        (SPADCALL (SPADCALL (SPADCALL |q| (QREFELT $ 11)) (QREFELT $ 12))
                  (SPADCALL (SPADCALL |q| (QREFELT $ 13)) (QREFELT $ 12))
                  (QREFELT $ 15))) 

(SDEFUN |FFCAT-;infOrder| ((|f| (|Fraction| UP)) ($ (|Integer|)))
        (- (SPADCALL (SPADCALL |f| (QREFELT $ 16)) (QREFELT $ 18))
           (SPADCALL (SPADCALL |f| (QREFELT $ 19)) (QREFELT $ 18)))) 

(SDEFUN |FFCAT-;integral?;SB;3| ((|f| (S)) ($ (|Boolean|)))
        (SPADCALL (QCDR (SPADCALL |f| (QREFELT $ 21))) (QREFELT $ 23))) 

(SDEFUN |FFCAT-;integral?;SFB;4| ((|f| (S)) (|a| (F)) ($ (|Boolean|)))
        (SPADCALL
         (SPADCALL (QCDR (SPADCALL |f| (QREFELT $ 21))) |a| (QREFELT $ 25))
         (|spadConstant| $ 26) (QREFELT $ 27))) 

(SDEFUN |FFCAT-;absolutelyIrreducible?;B;5| (($ (|Boolean|)))
        (EQL (SPADCALL (QREFELT $ 29)) 1)) 

(SDEFUN |FFCAT-;yCoordinates;SR;6|
        ((|f| (S)) ($ (|Record| (|:| |num| (|Vector| UP)) (|:| |den| UP))))
        (SPADCALL (SPADCALL |f| (QREFELT $ 32)) (QREFELT $ 34))) 

(SDEFUN |FFCAT-;hyperelliptic;U;7| (($ (|Union| UP "failed")))
        (SPROG
         ((|p| (UP)) (|v| (|Union| UP "failed"))
          (|u| (|Union| (|Fraction| UP) "failed")) (|f| (UPUP)))
         (SEQ
          (COND
           ((SPADCALL
             (SPADCALL (LETT |f| (SPADCALL (QREFELT $ 36))) (QREFELT $ 37)) 2
             (QREFELT $ 38))
            (CONS 1 "failed"))
           (#1='T
            (SEQ
             (LETT |u| (SPADCALL (SPADCALL |f| (QREFELT $ 39)) (QREFELT $ 41)))
             (EXIT
              (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                    (#1#
                     (SEQ
                      (LETT |v|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (QCDR |u|)
                                        (SPADCALL |f| (QREFELT $ 42))
                                        (QREFELT $ 43))
                              (QREFELT $ 44))
                             (QREFELT $ 46)))
                      (EXIT
                       (COND
                        ((OR (QEQCAR |v| 1)
                             (NULL
                              (ODDP
                               (SPADCALL (LETT |p| (QCDR |v|))
                                         (QREFELT $ 18)))))
                         (CONS 1 "failed"))
                        ('T (CONS 0 |p|)))))))))))))) 

(SDEFUN |FFCAT-;algSplitSimple;SMR;8|
        ((|f| (S)) (|derivation| (|Mapping| UP UP))
         ($
          (|Record| (|:| |num| S) (|:| |den| UP) (|:| |derivden| UP)
                    (|:| |gd| UP))))
        (SPROG
         ((|dd| (UP)) (#1=#:G749 NIL) (|g| (UP))
          (|cd| (|Record| (|:| |num| UPUP) (|:| |den| UP))))
         (SEQ
          (LETT |cd| (SPADCALL (SPADCALL |f| (QREFELT $ 48)) (QREFELT $ 51)))
          (LETT |dd|
                (PROG2
                    (LETT #1#
                          (SPADCALL (QCDR |cd|)
                                    (LETT |g|
                                          (SPADCALL (QCDR |cd|)
                                                    (SPADCALL (QCDR |cd|)
                                                              |derivation|)
                                                    (QREFELT $ 52)))
                                    (QREFELT $ 54)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (QREFELT $ 8)
                                  (|Union| (QREFELT $ 8) "failed") #1#)))
          (EXIT
           (VECTOR
            (SPADCALL
             (SPADCALL (SPADCALL (SPADCALL |g| (QREFELT $ 55)) (QREFELT $ 56))
                       (QCAR |cd|) (QREFELT $ 57))
             (QREFELT $ 58))
            |dd| (SPADCALL |dd| |derivation|)
            (SPADCALL |dd| (SPADCALL (SPADCALL (QREFELT $ 59)) (QREFELT $ 60))
                      (QREFELT $ 52))))))) 

(SDEFUN |FFCAT-;elliptic;U;9| (($ (|Union| UP "failed")))
        (SPROG ((|p| (UP)) (|u| (|Union| UP "failed")))
               (SEQ (LETT |u| (SPADCALL (QREFELT $ 64)))
                    (EXIT
                     (COND
                      ((OR (QEQCAR |u| 1)
                           (NULL
                            (EQL
                             (SPADCALL (LETT |p| (QCDR |u|)) (QREFELT $ 18))
                             3)))
                       (CONS 1 "failed"))
                      ('T (CONS 0 |p|))))))) 

(SDEFUN |FFCAT-;rationalPoint?;2FB;10| ((|x| (F)) (|y| (F)) ($ (|Boolean|)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (SPADCALL (QREFELT $ 36))
                    (SPADCALL (SPADCALL |y| (QREFELT $ 12)) (QREFELT $ 55))
                    (QREFELT $ 66))
          (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 55))
          (QREFELT $ 68))
         (QREFELT $ 69))) 

(SDEFUN |FFCAT-;UP2P| ((|p| (UP)) (|x| (|Polynomial| F)) ($ (|Polynomial| F)))
        (SPADCALL (SPADCALL (ELT $ 72) |p| (QREFELT $ 76)) |x| (QREFELT $ 77))) 

(SDEFUN |FFCAT-;UPUP2P|
        ((|p| (UPUP)) (|x| (|Polynomial| F)) (|y| (|Polynomial| F))
         ($ (|Polynomial| F)))
        (SPROG NIL
               (SPADCALL
                (SPADCALL (CONS #'|FFCAT-;UPUP2P!0| (VECTOR |x| $)) |p|
                          (QREFELT $ 80))
                |y| (QREFELT $ 77)))) 

(SDEFUN |FFCAT-;UPUP2P!0| ((|s| NIL) ($$ NIL))
        (PROG ($ |x|)
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN (PROGN (|FFCAT-;UP2P| (SPADCALL |s| (QREFELT $ 60)) |x| $))))) 

(SDEFUN |FFCAT-;nonSingularModel;SL;13|
        ((|u| (|Symbol|)) ($ (|List| (|Polynomial| F))))
        (SPROG
         ((#1=#:G802 NIL) (|v| NIL) (#2=#:G803 NIL) (|i| NIL) (#3=#:G801 NIL)
          (|y| (|Symbol|)) (|x| (|Symbol|)) (|vars| (|List| (|Symbol|)))
          (#4=#:G800 NIL) (|n| (|Integer|)) (#5=#:G799 NIL)
          (|d| (|Fraction| UP)) (|w| (|Vector| S)))
         (SEQ
          (LETT |d|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (LETT |w| (SPADCALL (QREFELT $ 82)))
                            (QREFELT $ 84))
                  (QREFELT $ 86))
                 (QREFELT $ 55)))
          (LETT |vars|
                (PROGN
                 (LETT #5# NIL)
                 (SEQ (LETT |i| 1) (LETT #4# (LETT |n| (QVSIZE |w|))) G190
                      (COND ((|greater_SI| |i| #4#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #5#
                              (CONS
                               (SPADCALL
                                (STRCONC (SPADCALL |u| (QREFELT $ 89))
                                         (STRINGIMAGE |i|))
                                (QREFELT $ 90))
                               #5#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #5#)))))
          (LETT |x| '|%%dummy1|) (LETT |y| '|%%dummy2|)
          (EXIT
           (SPADCALL
            (CONS #'|FFCAT-;nonSingularModel;SL;13!0| (VECTOR |y| $ |x|))
            (SPADCALL
             (PROGN
              (LETT #3# NIL)
              (SEQ (LETT |i| 1) (LETT #2# |n|) (LETT |v| NIL) (LETT #1# |vars|)
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL)
                         (|greater_SI| |i| #2#))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT #3#
                           (CONS
                            (SPADCALL (SPADCALL |v| (QREFELT $ 93))
                                      (|FFCAT-;UPUP2P|
                                       (SPADCALL
                                        (SPADCALL |d|
                                                  (SPADCALL |w| |i|
                                                            (QREFELT $ 96))
                                                  (QREFELT $ 97))
                                        (QREFELT $ 48))
                                       (SPADCALL |x| (QREFELT $ 93))
                                       (SPADCALL |y| (QREFELT $ 93)) $)
                                      (QREFELT $ 98))
                            #3#))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|))))
                   (GO G190) G191 (EXIT (NREVERSE #3#))))
             (SPADCALL (LIST |x| |y|) |vars| (QREFELT $ 100)) (QREFELT $ 103))
            (QREFELT $ 105)))))) 

(SDEFUN |FFCAT-;nonSingularModel;SL;13!0| ((|s| NIL) ($$ NIL))
        (PROG (|x| $ |y|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |y| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((SPADCALL (SPADCALL |s| |x| (QREFELT $ 91)) (QREFELT $ 92))
              (SPADCALL (SPADCALL |s| |y| (QREFELT $ 91)) (QREFELT $ 92)))
             ('T NIL)))))) 

(SDEFUN |FFCAT-;ispoint| ((|p| (UPUP)) (|x| (F)) (|y| (F)) ($ (|List| F)))
        (SPROG ((|jhd| (|Fraction| UP)))
               (SEQ
                (LETT |jhd|
                      (SPADCALL |p|
                                (SPADCALL (SPADCALL |y| (QREFELT $ 12))
                                          (QREFELT $ 55))
                                (QREFELT $ 66)))
                (EXIT
                 (COND
                  ((SPADCALL
                    (SPADCALL |jhd|
                              (SPADCALL (SPADCALL |x| (QREFELT $ 12))
                                        (QREFELT $ 55))
                              (QREFELT $ 68))
                    (QREFELT $ 69))
                   (LIST |x| |y|))
                  ('T NIL)))))) 

(SDEFUN |FFCAT-;rationalPoints;L;15| (($ (|List| (|List| F))))
        (SPROG
         ((|pt| (|List| F)) (#1=#:G811 NIL) (#2=#:G809 NIL) (#3=#:G820 NIL)
          (|y| NIL) (#4=#:G819 NIL) (#5=#:G818 NIL) (|x| NIL) (#6=#:G817 NIL)
          (|p| (UPUP)))
         (SEQ (LETT |p| (SPADCALL (QREFELT $ 36)))
              (EXIT
               (SPADCALL
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |x| 1) (LETT #5# (SPADCALL (QREFELT $ 107))) G190
                      (COND ((|greater_SI| |x| #5#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6#
                              (CONS
                               (PROGN
                                (LETT #4# NIL)
                                (SEQ (LETT |y| 1)
                                     (LETT #3# (SPADCALL (QREFELT $ 107))) G190
                                     (COND ((|greater_SI| |y| #3#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((NULL
                                          (NULL
                                           (LETT |pt|
                                                 (|FFCAT-;ispoint| |p|
                                                  (SPADCALL
                                                   (PROG1 (LETT #2# |x|)
                                                     (|check_subtype2|
                                                      (> #2# 0)
                                                      '(|PositiveInteger|)
                                                      '(|NonNegativeInteger|)
                                                      #2#))
                                                   (QREFELT $ 109))
                                                  (SPADCALL
                                                   (PROG1 (LETT #1# |y|)
                                                     (|check_subtype2|
                                                      (> #1# 0)
                                                      '(|PositiveInteger|)
                                                      '(|NonNegativeInteger|)
                                                      #1#))
                                                   (QREFELT $ 109))
                                                  $))))
                                         (LETT #4# (CONS |pt| #4#))))))
                                     (LETT |y| (|inc_SI| |y|)) (GO G190) G191
                                     (EXIT (NREVERSE #4#))))
                               #6#))))
                      (LETT |x| (|inc_SI| |x|)) (GO G190) G191
                      (EXIT (NREVERSE #6#))))
                (QREFELT $ 112)))))) 

(SDEFUN |FFCAT-;intvalue| ((|v| (|Vector| UP)) (|x| (F)) (|y| (F)) ($ (F)))
        (SPROG
         ((#1=#:G832 NIL) (|d| (F)) (|n| (F)) (#2=#:G826 NIL) (#3=#:G825 (F))
          (#4=#:G827 (F)) (#5=#:G829 NIL) (#6=#:G838 NIL) (|i| NIL)
          (|rec| (|Record| (|:| |num| (|Vector| UP)) (|:| |den| UP)))
          (#7=#:G822 NIL) (#8=#:G821 (S)) (#9=#:G823 (S)) (#10=#:G837 NIL)
          (|mini| (|Integer|)) (|w| (|Vector| S)))
         (SEQ
          (COND ((SPADCALL |x| (QREFELT $ 114)) (|error| "Point is singular"))
                (#11='T
                 (SEQ
                  (LETT |mini|
                        (SPADCALL (LETT |w| (SPADCALL (QREFELT $ 82)))
                                  (QREFELT $ 115)))
                  (LETT |rec|
                        (SPADCALL
                         (PROGN
                          (LETT #7# NIL)
                          (SEQ (LETT |i| |mini|) (LETT #10# (QVSIZE |w|)) G190
                               (COND ((> |i| #10#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (PROGN
                                  (LETT #9#
                                        (SPADCALL
                                         (SPADCALL (QAREF1O |v| |i| 1)
                                                   (QREFELT $ 55))
                                         (QAREF1O |w| |i| 1) (QREFELT $ 97)))
                                  (COND
                                   (#7#
                                    (LETT #8#
                                          (SPADCALL #8# #9# (QREFELT $ 116))))
                                   ('T
                                    (PROGN (LETT #8# #9#) (LETT #7# 'T)))))))
                               (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                          (COND (#7# #8#) (#11# (|spadConstant| $ 117))))
                         (QREFELT $ 118)))
                  (LETT |n|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |i| |mini|) (LETT #6# (QVSIZE |w|)) G190
                              (COND ((> |i| #6#) (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #4#
                                       (SPADCALL
                                        (SPADCALL (QAREF1O (QCAR |rec|) |i| 1)
                                                  |x| (QREFELT $ 25))
                                        (SPADCALL |y|
                                                  (PROG1
                                                      (LETT #5# (- |i| |mini|))
                                                    (|check_subtype2|
                                                     (>= #5# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #5#))
                                                  (QREFELT $ 119))
                                        (QREFELT $ 120)))
                                 (COND
                                  (#2#
                                   (LETT #3#
                                         (SPADCALL #3# #4# (QREFELT $ 121))))
                                  ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                              (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                         (COND (#2# #3#) (#11# (|spadConstant| $ 26)))))
                  (EXIT
                   (COND
                    ((SPADCALL
                      (LETT |d| (SPADCALL (QCDR |rec|) |x| (QREFELT $ 25)))
                      (QREFELT $ 122))
                     (COND
                      ((SPADCALL |n| (QREFELT $ 122))
                       (|error| "0/0 -- cannot compute value yet"))
                      (#11# (|error| "Shouldn't happen"))))
                    (#11#
                     (PROG2 (LETT #1# (SPADCALL |n| |d| (QREFELT $ 123)))
                         (QCDR #1#)
                       (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                       (|Union| (QREFELT $ 7) "failed")
                                       #1#))))))))))) 

(SDEFUN |FFCAT-;elt;S3F;17| ((|f| (S)) (|x| (F)) (|y| (F)) ($ (F)))
        (SPROG
         ((#1=#:G842 NIL) (|d| (F)) (|n| (F))
          (|rec| (|Record| (|:| |num| (|Vector| UP)) (|:| |den| UP))))
         (SEQ (LETT |rec| (SPADCALL |f| (QREFELT $ 21)))
              (LETT |n| (|FFCAT-;intvalue| (QCAR |rec|) |x| |y| $))
              (EXIT
               (COND
                ((SPADCALL
                  (LETT |d| (SPADCALL (QCDR |rec|) |x| (QREFELT $ 25)))
                  (QREFELT $ 122))
                 (COND
                  ((SPADCALL |n| (QREFELT $ 122))
                   (|error| "0/0 -- cannot compute value yet"))
                  (#2='T (|error| "Function has a pole at the given point"))))
                (#2#
                 (PROG2 (LETT #1# (SPADCALL |n| |d| (QREFELT $ 123)))
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                   (|Union| (QREFELT $ 7) "failed") #1#)))))))) 

(SDEFUN |FFCAT-;primitivePart;2S;18| ((|f| (S)) ($ (S)))
        (SPROG
         ((#1=#:G857 NIL) (#2=#:G859 NIL) (|i| NIL) (#3=#:G858 NIL) (|d| (UP))
          (#4=#:G856 NIL) (#5=#:G855 NIL)
          (|cd| (|Record| (|:| |num| (|Vector| UP)) (|:| |den| UP))))
         (SEQ (LETT |cd| (SPADCALL |f| (QREFELT $ 118)))
              (LETT |d|
                    (SPADCALL
                     (SPADCALL
                      (PROGN
                       (LETT #5# NIL)
                       (SEQ (LETT |i| (SPADCALL (QCAR |cd|) (QREFELT $ 126)))
                            (LETT #4# (QVSIZE (QCAR |cd|))) G190
                            (COND ((> |i| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #5#
                                    (CONS
                                     (SPADCALL (QAREF1O (QCAR |cd|) |i| 1)
                                               (QREFELT $ 127))
                                     #5#))))
                            (LETT |i| (+ |i| 1)) (GO G190) G191
                            (EXIT (NREVERSE #5#))))
                      (QREFELT $ 128))
                     (SPADCALL (QCDR |cd|) (QREFELT $ 129)) (QREFELT $ 130)))
              (EXIT
               (SPADCALL
                (PROGN
                 (LETT #3#
                       (GETREFV
                        (|inc_SI|
                         (- #6=(QVSIZE (QCAR |cd|))
                            #7=(SPADCALL (QCAR |cd|) (QREFELT $ 126))))))
                 (SEQ (LETT |i| #7#) (LETT #2# #6#) (LETT #1# 0) G190
                      (COND ((> |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #3# #1#
                                (SPADCALL (QAREF1O (QCAR |cd|) |i| 1) |d|
                                          (QREFELT $ 15)))))
                      (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |i| (+ |i| 1))))
                      (GO G190) G191 (EXIT NIL))
                 #3#)
                (QREFELT $ 131)))))) 

(SDEFUN |FFCAT-;reduceBasisAtInfinity;2V;19|
        ((|b| (|Vector| S)) ($ (|Vector| S)))
        (SPROG
         ((|f| (S)) (|j| NIL) (#1=#:G868 NIL) (#2=#:G867 NIL) (|i| NIL)
          (#3=#:G866 NIL) (|x| (|Fraction| UP)))
         (SEQ
          (LETT |x|
                (SPADCALL (SPADCALL (|spadConstant| $ 134) 1 (QREFELT $ 135))
                          (QREFELT $ 55)))
          (EXIT
           (SPADCALL
            (PROGN
             (LETT #3# NIL)
             (SEQ (LETT |i| (SPADCALL |b| (QREFELT $ 115)))
                  (LETT #2# (QVSIZE |b|)) G190 (COND ((> |i| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #3#
                          (CONS
                           (LIST2VEC
                            (PROGN
                             (LETT #1# NIL)
                             (SEQ (LETT |j| 0) G190
                                  (COND
                                   ((NULL
                                     (SPADCALL
                                      (LETT |f|
                                            (SPADCALL
                                             (SPADCALL |x| |j| (QREFELT $ 136))
                                             (QAREF1O |b| |i| 1)
                                             (QREFELT $ 97)))
                                      (QREFELT $ 137)))
                                    (GO G191)))
                                  (SEQ (EXIT (LETT #1# (CONS |f| #1#))))
                                  (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                  (EXIT (NREVERSE #1#)))))
                           #3#))))
                  (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT (NREVERSE #3#))))
            (QREFELT $ 138)))))) 

(SDEFUN |FFCAT-;complementaryBasis;2V;20| ((|b| (|Vector| S)) ($ (|Vector| S)))
        (SPROG
         ((#1=#:G876 NIL) (#2=#:G878 NIL) (|i| NIL) (#3=#:G877 NIL)
          (|m| (|Matrix| (|Fraction| UP))) (#4=#:G870 NIL))
         (SEQ
          (LETT |m|
                (PROG2
                    (LETT #4#
                          (SPADCALL (SPADCALL |b| (QREFELT $ 140))
                                    (QREFELT $ 141)))
                    (QCDR #4#)
                  (|check_union2| (QEQCAR #4# 0)
                                  (|Matrix| (|Fraction| (QREFELT $ 8)))
                                  (|Union|
                                   (|Matrix| (|Fraction| (QREFELT $ 8)))
                                   "failed")
                                  #4#)))
          (EXIT
           (PROGN
            (LETT #3#
                  (GETREFV
                   (|inc_SI|
                    (- #5=(SPADCALL |m| (QREFELT $ 142)) #6=(PROGN |m| 1)))))
            (SEQ (LETT |i| #6#) (LETT #2# #5#) (LETT #1# 0) G190
                 (COND ((> |i| #2#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SETELT #3# #1#
                           (SPADCALL (SPADCALL |m| |i| (QREFELT $ 143))
                                     (QREFELT $ 131)))))
                 (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |i| (+ |i| 1))))
                 (GO G190) G191 (EXIT NIL))
            #3#))))) 

(SDEFUN |FFCAT-;integralAtInfinity?;SB;21| ((|f| (S)) ($ (|Boolean|)))
        (NULL
         (SPADCALL (CONS #'|FFCAT-;integralAtInfinity?;SB;21!0| $)
                   (SPADCALL (SPADCALL |f| (QREFELT $ 32))
                             (SPADCALL (QREFELT $ 147)) (QREFELT $ 148))
                   (QREFELT $ 150)))) 

(SDEFUN |FFCAT-;integralAtInfinity?;SB;21!0| ((|s| NIL) ($ NIL))
        (SPADCALL (|FFCAT-;infOrder| |s| $) (|spadConstant| $ 145)
                  (QREFELT $ 146))) 

(SDEFUN |FFCAT-;pol_order_at_p| ((|f| (UP)) (|p| (UP)) ($ (|Integer|)))
        (SPROG
         ((|k1| (|Integer|)) (#1=#:G894 NIL) (|k| (|Integer|)) (#2=#:G885 NIL)
          (|qu| (|Union| UP #3="failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |k| 0) (LETT |k1| (SPADCALL |p| (QREFELT $ 18)))
                (SEQ G190 (COND ((NULL (> |k1| 0)) (GO G191)))
                     (SEQ
                      (SEQ G190
                           (COND
                            ((NULL
                              (QEQCAR
                               (LETT |qu| (SPADCALL |f| |p| (QREFELT $ 54)))
                               0))
                             (GO G191)))
                           (SEQ
                            (LETT |f|
                                  (PROG2 (LETT #2# |qu|)
                                      (QCDR #2#)
                                    (|check_union2| (QEQCAR #2# 0)
                                                    (QREFELT $ 8)
                                                    (|Union| (QREFELT $ 8) #3#)
                                                    #2#)))
                            (EXIT (LETT |k| (+ |k| |k1|))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((EQL |k1| 1) (PROGN (LETT #1# |k|) (GO #4=#:G893)))
                        ('T
                         (SEQ (LETT |p| (SPADCALL |f| |p| (QREFELT $ 52)))
                              (EXIT
                               (LETT |k1| (SPADCALL |p| (QREFELT $ 18)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT |k|)))
          #4# (EXIT #1#)))) 

(SDEFUN |FFCAT-;rf_order_at_p|
        ((|f| (|Fraction| UP)) (|p| (UP)) ($ (|Integer|)))
        (- (|FFCAT-;pol_order_at_p| (SPADCALL |f| (QREFELT $ 19)) |p| $)
           (|FFCAT-;pol_order_at_p| (SPADCALL |f| (QREFELT $ 16)) |p| $))) 

(SDEFUN |FFCAT-;special_order;SLI;24|
        ((|f| (S)) (|lp| (|List| UP)) ($ (|Integer|)))
        (SPROG
         ((|k| (|Integer|)) (#1=#:G900 NIL) (|p| NIL) (|nf| (|Fraction| UP)))
         (SEQ (LETT |nf| (SPADCALL |f| (QREFELT $ 152))) (LETT |k| 0)
              (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |k| (+ |k| (|FFCAT-;rf_order_at_p| |nf| |p| $)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (+ |k| (|FFCAT-;infOrder| |nf| $)))))) 

(SDEFUN |FFCAT-;numberOfComponents;Nni;25| (($ (|NonNegativeInteger|)))
        (SPADCALL (ELT $ 137) (SPADCALL (QREFELT $ 82)) (QREFELT $ 156))) 

(SDEFUN |FFCAT-;represents;VUPS;26| ((|v| (|Vector| UP)) (|d| (UP)) ($ (S)))
        (SPROG ((#1=#:G906 NIL) (#2=#:G908 NIL) (|i| NIL) (#3=#:G907 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #3#
                        (GETREFV
                         (|inc_SI|
                          (- #4=(QVSIZE |v|)
                             #5=(SPADCALL |v| (QREFELT $ 126))))))
                  (SEQ (LETT |i| #5#) (LETT #2# #4#) (LETT #1# 0) G190
                       (COND ((> |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (SETELT #3# #1#
                                 (SPADCALL (QAREF1O |v| |i| 1) |d|
                                           (QREFELT $ 15)))))
                       (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |i| (+ |i| 1))))
                       (GO G190) G191 (EXIT NIL))
                  #3#)
                 (QREFELT $ 131))))) 

(SDEFUN |FFCAT-;genus;Nni;27| (($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G912 NIL) (|dd| (|Integer|)) (#2=#:G910 NIL) (|d| (|Integer|))
          (|ds| (|Fraction| UP)))
         (SEQ (LETT |ds| (SPADCALL (QREFELT $ 59)))
              (LETT |d|
                    (+ (SPADCALL (SPADCALL |ds| (QREFELT $ 60)) (QREFELT $ 18))
                       (|FFCAT-;infOrder|
                        (SPADCALL |ds|
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL (SPADCALL (QREFELT $ 159))
                                              (SPADCALL (QREFELT $ 160))
                                              (QREFELT $ 161))
                                    (QREFELT $ 162))
                                   2 (QREFELT $ 163))
                                  (QREFELT $ 164))
                        $)))
              (LETT |dd|
                    (PROG2
                        (LETT #2#
                              (SPADCALL
                               (-
                                (PROG2
                                    (LETT #2# (SPADCALL |d| 2 (QREFELT $ 165)))
                                    (QCDR #2#)
                                  (|check_union2| (QEQCAR #2# 0) (|Integer|)
                                                  (|Union| (|Integer|)
                                                           #3="failed")
                                                  #2#))
                                (SPADCALL (QREFELT $ 166)))
                               (SPADCALL (QREFELT $ 29)) (QREFELT $ 165)))
                        (QCDR #2#)
                      (|check_union2| (QEQCAR #2# 0) (|Integer|)
                                      (|Union| (|Integer|) #3#) #2#)))
              (EXIT
               (PROG1 (LETT #1# (+ |dd| 1))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))))) 

(SDEFUN |FFCAT-;repOrder|
        ((|m| (|Matrix| (|Fraction| UP))) (|i| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|ans| (|Integer|)) (|nostart| (|Boolean|)) (#1=#:G920 NIL) (|j| NIL)
          (|r| (|Vector| (|Fraction| UP))))
         (SEQ (LETT |nostart| 'T) (LETT |ans| 0)
              (LETT |r| (SPADCALL |m| |i| (QREFELT $ 143)))
              (SEQ (LETT |j| (SPADCALL |r| (QREFELT $ 168)))
                   (LETT #1# (QVSIZE |r|)) G190 (COND ((> |j| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (QAREF1O |r| |j| 1) (|spadConstant| $ 169)
                                 (QREFELT $ 170))
                       (LETT |ans|
                             (COND
                              (|nostart|
                               (SEQ (LETT |nostart| NIL)
                                    (EXIT
                                     (|FFCAT-;infOrder| (QAREF1O |r| |j| 1)
                                      $))))
                              ('T
                               (MIN |ans|
                                    (|FFCAT-;infOrder| (QAREF1O |r| |j| 1)
                                     $)))))))))
                   (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT (COND (|nostart| (|error| "Null row")) ('T |ans|)))))) 

(SDEFUN |FFCAT-;infValue| ((|f| (|Fraction| UP)) ($ (|Fraction| F)))
        (SPROG ((|n| (|Integer|)))
               (SEQ
                (COND ((SPADCALL |f| (QREFELT $ 69)) (|spadConstant| $ 171))
                      (#1='T
                       (SEQ (LETT |n| (|FFCAT-;infOrder| |f| $))
                            (EXIT
                             (COND ((> |n| 0) (|spadConstant| $ 171))
                                   ((ZEROP |n|)
                                    (SPADCALL
                                     (SPADCALL (SPADCALL |f| (QREFELT $ 19))
                                               (QREFELT $ 172))
                                     (SPADCALL (SPADCALL |f| (QREFELT $ 16))
                                               (QREFELT $ 172))
                                     (QREFELT $ 173)))
                                   (#1#
                                    (|error|
                                     "f not locally integral at infinity")))))))))) 

(SDEFUN |FFCAT-;rfmonom| ((|n| (|Integer|)) ($ (|Fraction| UP)))
        (SPROG ((#1=#:G926 NIL) (#2=#:G925 NIL))
               (COND
                ((< |n| 0)
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL (|spadConstant| $ 134)
                             (PROG1 (LETT #2# (- |n|))
                               (|check_subtype2| (>= #2# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #2#))
                             (QREFELT $ 135))
                   (QREFELT $ 55))
                  (QREFELT $ 56)))
                ('T
                 (SPADCALL
                  (SPADCALL (|spadConstant| $ 134)
                            (PROG1 (LETT #1# |n|)
                              (|check_subtype2| (>= #1# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #1#))
                            (QREFELT $ 135))
                  (QREFELT $ 55)))))) 

(SDEFUN |FFCAT-;kmin|
        ((|m| (|Matrix| (|Fraction| UP))) (|v| (|Vector| (|Fraction| F)))
         ($ (|Record| (|:| |pos| (|Integer|)) (|:| |km| (|Integer|)))))
        (SPROG
         ((|i0| (|Integer|)) (|k| (|Integer|)) (|nostart| (|Boolean|))
          (|nk| (|Integer|)) (#1=#:G936 NIL) (|i| NIL) (|ii| (|Integer|)))
         (SEQ (LETT |nostart| 'T) (LETT |k| 0)
              (LETT |ii|
                    (- (PROGN |m| 1)
                       (LETT |i0| (SPADCALL |v| (QREFELT $ 175)))))
              (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 175)))
                   (LETT #1# (QVSIZE |v|)) G190 (COND ((> |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (QAREF1O |v| |i| 1) (|spadConstant| $ 171)
                                 (QREFELT $ 176))
                       (SEQ (LETT |nk| (|FFCAT-;repOrder| |m| (+ |i| |ii|) $))
                            (EXIT
                             (COND
                              (|nostart|
                               (SEQ (LETT |nostart| NIL) (LETT |k| |nk|)
                                    (EXIT (LETT |i0| |i|))))
                              ((< |nk| |k|)
                               (SEQ (LETT |k| |nk|)
                                    (EXIT (LETT |i0| |i|)))))))))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND (|nostart| (|error| "vector v has only zero entries"))
                     ('T (CONS |i0| |k|))))))) 

(SDEFUN |FFCAT-;normalizeAtInfinity;2V;32|
        ((|w| (|Vector| S)) ($ (|Vector| S)))
        (SPROG
         ((#1=#:G947 NIL) (#2=#:G946 (S)) (#3=#:G948 (S)) (#4=#:G960 NIL)
          (|i| NIL)
          (|pr| (|Record| (|:| |pos| (|Integer|)) (|:| |km| (|Integer|))))
          (|sol| (|Vector| (|Fraction| F))) (#5=#:G954 NIL)
          (|solList| (|List| (|Vector| (|Fraction| F)))) (#6=#:G959 NIL)
          (|j| NIL) (#7=#:G958 NIL) (|r| (|Vector| (|Fraction| UP)))
          (#8=#:G955 NIL) (#9=#:G957 NIL) (#10=#:G956 NIL)
          (|m| (|Matrix| (|Fraction| UP))) (|ii| (|Integer|))
          (|mhat| (|Matrix| (|Fraction| UP)))
          (|infm| (|Matrix| (|Fraction| UP))) (|ans| (|Vector| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |ans| (SPADCALL |w| (QREFELT $ 177)))
                (LETT |infm| (SPADCALL (QREFELT $ 147)))
                (LETT |mhat|
                      (SPADCALL (SPADCALL (QREFELT $ 166))
                                (SPADCALL (QREFELT $ 166)) (QREFELT $ 178)))
                (LETT |ii| (- (SPADCALL |w| (QREFELT $ 115)) (PROGN |mhat| 1)))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (LETT |m|
                             (SPADCALL (SPADCALL |ans| (QREFELT $ 84)) |infm|
                                       (QREFELT $ 161)))
                       (LETT |r|
                             (PROGN
                              (LETT #10#
                                    (GETREFV
                                     (|inc_SI|
                                      (- #11=(SPADCALL |m| (QREFELT $ 142))
                                         #12=(PROGN |m| 1)))))
                              (SEQ (LETT |i| #12#) (LETT #9# #11#) (LETT #8# 0)
                                   G190 (COND ((> |i| #9#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (SETELT #10# #8#
                                             (|FFCAT-;rfmonom|
                                              (|FFCAT-;repOrder| |m| |i| $)
                                              $))))
                                   (LETT #8#
                                         (PROG1 (|inc_SI| #8#)
                                           (LETT |i| (+ |i| 1))))
                                   (GO G190) G191 (EXIT NIL))
                              #10#))
                       (SEQ (LETT |i| (PROGN |m| 1))
                            (LETT #7# (SPADCALL |m| (QREFELT $ 142))) G190
                            (COND ((> |i| #7#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |j| (PROGN |m| 1))
                                   (LETT #6# (SPADCALL |m| (QREFELT $ 179)))
                                   G190 (COND ((> |j| #6#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (QSETAREF2O |mhat| |i| |j|
                                                 (SPADCALL
                                                  (QAREF1O |r| (+ |i| |ii|) 1)
                                                  (QAREF2O |m| |i| |j| 1 1)
                                                  (QREFELT $ 164))
                                                 1 1)))
                                   (LETT |j| (+ |j| 1)) (GO G190) G191
                                   (EXIT NIL))))
                            (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                       (LETT |solList|
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (CONS (|function| |FFCAT-;infValue|) $) |mhat|
                                (QREFELT $ 183))
                               (QREFELT $ 184))
                              (QREFELT $ 186)))
                       (EXIT
                        (COND
                         ((NULL |solList|)
                          (PROGN (LETT #5# |ans|) (GO #13=#:G953)))
                         ('T
                          (SEQ (LETT |sol| (|SPADfirst| |solList|))
                               (LETT |pr| (|FFCAT-;kmin| |m| |sol| $))
                               (EXIT
                                (QSETAREF1O |ans| (QCAR |pr|)
                                            (PROGN
                                             (LETT #1# NIL)
                                             (SEQ
                                              (LETT |i|
                                                    (SPADCALL |sol|
                                                              (QREFELT $ 175)))
                                              (LETT #4# (QVSIZE |sol|)) G190
                                              (COND ((> |i| #4#) (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (PROGN
                                                 (LETT #3#
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (|FFCAT-;Q2RF|
                                                          (QAREF1O |sol| |i| 1)
                                                          $)
                                                         (|FFCAT-;rfmonom|
                                                          (-
                                                           (|FFCAT-;repOrder|
                                                            |m| (- |i| |ii|) $)
                                                           (QCDR |pr|))
                                                          $)
                                                         (QREFELT $ 164))
                                                        (QAREF1O |ans| |i| 1)
                                                        (QREFELT $ 97)))
                                                 (COND
                                                  (#1#
                                                   (LETT #2#
                                                         (SPADCALL #2# #3#
                                                                   (QREFELT $
                                                                            116))))
                                                  ('T
                                                   (PROGN
                                                    (LETT #2# #3#)
                                                    (LETT #1# 'T)))))))
                                              (LETT |i| (+ |i| 1)) (GO G190)
                                              G191 (EXIT NIL))
                                             (COND (#1# #2#)
                                                   ('T
                                                    (|spadConstant| $ 117))))
                                            1)))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #13# (EXIT #5#)))) 

(SDEFUN |FFCAT-;integral?;SUPB;33| ((|f| (S)) (|p| (UP)) ($ (|Boolean|)))
        (SPROG ((|r| (|Union| F "failed")))
               (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 189)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 0)
                       (SPADCALL |f| (QCDR |r|) (QREFELT $ 190)))
                      ('T
                       (QEQCAR
                        (SPADCALL (QCDR (SPADCALL |f| (QREFELT $ 21))) |p|
                                  (QREFELT $ 54))
                        1))))))) 

(SDEFUN |FFCAT-;differentiate;SMS;34|
        ((|f| (S)) (|d| (|Mapping| UP UP)) ($ (S)))
        (SPROG NIL
               (SPADCALL |f|
                         (CONS #'|FFCAT-;differentiate;SMS;34!0|
                               (VECTOR $ |d|))
                         (QREFELT $ 194)))) 

(SDEFUN |FFCAT-;differentiate;SMS;34!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |d| (QREFELT $ 192)))))) 

(DECLAIM (NOTINLINE |FunctionFieldCategory&;|)) 

(DEFUN |FunctionFieldCategory&| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|FunctionFieldCategory&| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 197))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST (|HasCategory| |#2| '(|Finite|))
                                             (|HasCategory| |#2|
                                                            '(|Field|))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 2)
      (PROGN
       (QSETREFV $ 106
                 (CONS (|dispatchFunction| |FFCAT-;nonSingularModel;SL;13|)
                       $)))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 113
                 (CONS (|dispatchFunction| |FFCAT-;rationalPoints;L;15|) $)))))
    $))) 

(MAKEPROP '|FunctionFieldCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Fraction| 7) (0 . |numer|)
              (5 . |coerce|) (10 . |denom|) (|Fraction| 8) (15 . /)
              (21 . |denom|) (|NonNegativeInteger|) (26 . |degree|)
              (31 . |numer|) (|Record| (|:| |num| 125) (|:| |den| 8))
              (36 . |integralCoordinates|) (|Boolean|) (41 . |ground?|)
              |FFCAT-;integral?;SB;3| (46 . |elt|) (52 . |Zero|) (56 . ~=)
              |FFCAT-;integral?;SFB;4| (62 . |numberOfComponents|)
              |FFCAT-;absolutelyIrreducible?;B;5| (|Vector| 14)
              (66 . |coordinates|) (|InnerCommonDenominator| 8 14 125 31)
              (71 . |splitDenominator|) |FFCAT-;yCoordinates;SR;6|
              (76 . |definingPolynomial|) (80 . |degree|) (85 . ~=)
              (91 . |reductum|) (|Union| 14 '#1="failed") (96 . |retractIfCan|)
              (101 . |leadingCoefficient|) (106 . /) (112 . -)
              (|Union| 8 '"failed") (117 . |retractIfCan|)
              |FFCAT-;hyperelliptic;U;7| (122 . |lift|)
              (|Record| (|:| |num| 9) (|:| |den| 8))
              (|UnivariatePolynomialCommonDenominator| 8 14 9)
              (127 . |splitDenominator|) (132 . |gcd|) (|Union| $ '"failed")
              (138 . |exquo|) (144 . |coerce|) (149 . |inv|) (154 . *)
              (160 . |reduce|) (165 . |discriminant|) (169 . |retract|)
              (|Record| (|:| |num| $) (|:| |den| 8) (|:| |derivden| 8)
                        (|:| |gd| 8))
              (|Mapping| 8 8) |FFCAT-;algSplitSimple;SMR;8|
              (174 . |hyperelliptic|) |FFCAT-;elliptic;U;9| (178 . |elt|)
              (|Fraction| $) (184 . |elt|) (190 . |zero?|)
              |FFCAT-;rationalPoint?;2FB;10| (|Polynomial| 7) (195 . |coerce|)
              (|SparseUnivariatePolynomial| 71) (|Mapping| 71 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 8 71 73)
              (200 . |map|) (206 . |elt|) (|Mapping| 71 14)
              (|UnivariatePolynomialCategoryFunctions2| 14 9 71 73)
              (212 . |map|) (|Vector| $) (218 . |integralBasis|) (|Matrix| 14)
              (222 . |coordinates|) (|MatrixCommonDenominator| 8 14)
              (227 . |commonDenominator|) (|String|) (|Symbol|)
              (232 . |string|) (237 . |coerce|) (242 . |degree|)
              (248 . |zero?|) (253 . |coerce|) (|Integer|) (|Vector| 6)
              (258 . |elt|) (264 . *) (270 . -) (|List| 88) (276 . |concat|)
              (|List| 71) (|PolyGroebner| 7) (282 . |lexGroebner|)
              (|Mapping| 22 71) (288 . |select!|) (294 . |nonSingularModel|)
              (299 . |size|) (|PositiveInteger|) (303 . |index|) (|List| $)
              (|List| (|List| 7)) (308 . |concat|) (313 . |rationalPoints|)
              (317 . |singular?|) (322 . |minIndex|) (327 . +) (333 . |Zero|)
              (337 . |yCoordinates|) (342 . ^) (348 . *) (354 . +)
              (360 . |zero?|) (365 . |exquo|) |FFCAT-;elt;S3F;17| (|Vector| 8)
              (371 . |minIndex|) (376 . |content|) (381 . |gcd|)
              (386 . |primitivePart|) (391 . *) (397 . |represents|)
              |FFCAT-;primitivePart;2S;18| (402 . |One|) (406 . |One|)
              (410 . |monomial|) (416 . ^) (422 . |integralAtInfinity?|)
              (427 . |concat|) |FFCAT-;reduceBasisAtInfinity;2V;19|
              (432 . |traceMatrix|) (437 . |inverse|) (442 . |maxRowIndex|)
              (447 . |row|) |FFCAT-;complementaryBasis;2V;20| (453 . |Zero|)
              (457 . <) (463 . |inverseIntegralMatrixAtInfinity|) (467 . *)
              (|Mapping| 22 14) (473 . |any?|)
              |FFCAT-;integralAtInfinity?;SB;21| (479 . |norm|) (|List| 8)
              |FFCAT-;special_order;SLI;24| (|Mapping| 22 6) (484 . |count|)
              |FFCAT-;numberOfComponents;Nni;25| |FFCAT-;represents;VUPS;26|
              (490 . |integralMatrixAtInfinity|)
              (494 . |inverseIntegralMatrix|) (498 . *) (504 . |determinant|)
              (509 . ^) (515 . *) (521 . |exquo|) (527 . |rank|)
              |FFCAT-;genus;Nni;27| (531 . |minIndex|) (536 . |Zero|)
              (540 . ~=) (546 . |Zero|) (550 . |leadingCoefficient|) (555 . /)
              (|Vector| 10) (561 . |minIndex|) (566 . ~=) (572 . |copy|)
              (577 . |zero|) (583 . |maxColIndex|) (|Matrix| 10)
              (|Mapping| 10 14)
              (|MatrixCategoryFunctions2| 14 31 31 83 10 174 174 180)
              (588 . |map|) (594 . |transpose|) (|List| 174)
              (599 . |nullSpace|) |FFCAT-;normalizeAtInfinity;2V;32|
              (|Union| 7 '#1#) (604 . |retractIfCan|) (609 . |integral?|)
              |FFCAT-;integral?;SUPB;33| (615 . |differentiate|)
              (|Mapping| 14 14) (621 . |differentiate|)
              |FFCAT-;differentiate;SMS;34| (|List| 17))
           '#(|yCoordinates| 627 |special_order| 632 |represents| 638
              |reduceBasisAtInfinity| 644 |rationalPoints| 649 |rationalPoint?|
              653 |primitivePart| 659 |numberOfComponents| 664
              |normalizeAtInfinity| 668 |nonSingularModel| 673
              |integralAtInfinity?| 678 |integral?| 683 |hyperelliptic| 700
              |genus| 704 |elt| 708 |elliptic| 715 |differentiate| 719
              |complementaryBasis| 725 |algSplitSimple| 730
              |absolutelyIrreducible?| 736)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rationalPoints| ((|List| (|List| |#2|)))) T)
                              '((|nonSingularModel|
                                 ((|List| (|Polynomial| |#2|)) (|Symbol|)))
                                T)
                              '((|algSplitSimple|
                                 ((|Record| (|:| |num| |#1|) (|:| |den| |#3|)
                                            (|:| |derivden| |#3|)
                                            (|:| |gd| |#3|))
                                  |#1| (|Mapping| |#3| |#3|)))
                                T)
                              '((|hyperelliptic| ((|Union| |#3| "failed"))) T)
                              '((|elliptic| ((|Union| |#3| "failed"))) T)
                              '((|elt| (|#2| |#1| |#2| |#2|)) T)
                              '((|primitivePart| (|#1| |#1|)) T)
                              '((|represents| (|#1| (|Vector| |#3|) |#3|)) T)
                              '((|differentiate|
                                 (|#1| |#1| (|Mapping| |#3| |#3|)))
                                T)
                              '((|integral?| ((|Boolean|) |#1| |#3|)) T)
                              '((|integral?| ((|Boolean|) |#1| |#2|)) T)
                              '((|yCoordinates|
                                 ((|Record| (|:| |num| (|Vector| |#3|))
                                            (|:| |den| |#3|))
                                  |#1|))
                                T)
                              '((|reduceBasisAtInfinity|
                                 ((|Vector| |#1|) (|Vector| |#1|)))
                                T)
                              '((|normalizeAtInfinity|
                                 ((|Vector| |#1|) (|Vector| |#1|)))
                                T)
                              '((|complementaryBasis|
                                 ((|Vector| |#1|) (|Vector| |#1|)))
                                T)
                              '((|integral?| ((|Boolean|) |#1|)) T)
                              '((|special_order|
                                 ((|Integer|) |#1| (|List| |#3|)))
                                T)
                              '((|integralAtInfinity?| ((|Boolean|) |#1|)) T)
                              '((|rationalPoint?| ((|Boolean|) |#2| |#2|)) T)
                              '((|absolutelyIrreducible?| ((|Boolean|))) T)
                              '((|genus| ((|NonNegativeInteger|))) T)
                              '((|numberOfComponents| ((|NonNegativeInteger|)))
                                T)
                              '((|differentiate|
                                 (|#1| |#1|
                                  (|Mapping| (|Fraction| |#3|)
                                             (|Fraction| |#3|))))
                                T)
                              '((|differentiate|
                                 (|#1| |#1|
                                  (|Mapping| (|Fraction| |#3|)
                                             (|Fraction| |#3|))
                                  (|NonNegativeInteger|)))
                                T)
                              '((|differentiate|
                                 (|#1| |#1| (|List| (|Symbol|))
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|differentiate|
                                 (|#1| |#1| (|Symbol|) (|NonNegativeInteger|)))
                                T)
                              '((|differentiate|
                                 (|#1| |#1| (|List| (|Symbol|))))
                                T)
                              '((|differentiate| (|#1| |#1| (|Symbol|))) T)
                              '((|differentiate|
                                 (|#1| |#1| (|NonNegativeInteger|)))
                                T)
                              '((|differentiate| (|#1| |#1|)) T)
                              '((|represents|
                                 (|#1| (|Vector| (|Fraction| |#3|))))
                                T)
                              '((|represents|
                                 (|#1| (|Vector| (|Fraction| |#3|))
                                  (|Vector| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 195
                                            '(1 10 7 0 11 1 8 0 7 12 1 10 7 0
                                              13 2 14 0 8 8 15 1 14 8 0 16 1 8
                                              17 0 18 1 14 8 0 19 1 6 20 0 21 1
                                              8 22 0 23 2 8 7 0 7 25 0 7 0 26 2
                                              7 22 0 0 27 0 6 17 29 1 6 31 0 32
                                              1 33 20 31 34 0 6 9 36 1 9 17 0
                                              37 2 17 22 0 0 38 1 9 0 0 39 1 9
                                              40 0 41 1 9 14 0 42 2 14 0 0 0 43
                                              1 14 0 0 44 1 14 45 0 46 1 6 9 0
                                              48 1 50 49 9 51 2 8 0 0 0 52 2 8
                                              53 0 0 54 1 14 0 8 55 1 14 0 0 56
                                              2 9 0 14 0 57 1 6 0 9 58 0 6 14
                                              59 1 14 8 0 60 0 6 45 64 2 9 14 0
                                              14 66 2 8 67 67 67 68 1 14 22 0
                                              69 1 71 0 7 72 2 75 73 74 8 76 2
                                              73 71 0 71 77 2 79 73 78 9 80 0 6
                                              81 82 1 6 83 81 84 1 85 8 83 86 1
                                              88 87 0 89 1 88 0 87 90 2 71 17 0
                                              88 91 1 17 22 0 92 1 71 0 88 93 2
                                              95 6 0 94 96 2 6 0 14 0 97 2 71 0
                                              0 0 98 2 99 0 0 0 100 2 102 101
                                              101 99 103 2 101 0 104 0 105 1 0
                                              101 88 106 0 7 17 107 1 7 0 108
                                              109 1 111 0 110 112 0 0 111 113 1
                                              6 22 7 114 1 95 94 0 115 2 6 0 0
                                              0 116 0 6 0 117 1 6 20 0 118 2 7
                                              0 0 17 119 2 7 0 0 0 120 2 7 0 0
                                              0 121 1 7 22 0 122 2 7 53 0 0 123
                                              1 125 94 0 126 1 8 7 0 127 1 7 0
                                              110 128 1 8 0 0 129 2 8 0 7 0 130
                                              1 6 0 31 131 0 6 0 133 0 7 0 134
                                              2 8 0 7 17 135 2 14 0 0 17 136 1
                                              6 22 0 137 1 95 0 110 138 1 6 83
                                              81 140 1 83 53 0 141 1 83 94 0
                                              142 2 83 31 0 94 143 0 17 0 145 2
                                              94 22 0 0 146 0 6 83 147 2 83 31
                                              31 0 148 2 31 22 149 0 150 1 6 14
                                              0 152 2 95 17 155 0 156 0 6 83
                                              159 0 6 83 160 2 83 0 0 0 161 1
                                              83 14 0 162 2 14 0 0 94 163 2 14
                                              0 0 0 164 2 94 53 0 0 165 0 6 108
                                              166 1 31 94 0 168 0 14 0 169 2 14
                                              22 0 0 170 0 10 0 171 1 8 7 0 172
                                              2 10 0 7 7 173 1 174 94 0 175 2
                                              10 22 0 0 176 1 95 0 0 177 2 83 0
                                              17 17 178 1 83 94 0 179 2 182 180
                                              181 83 183 1 180 0 0 184 1 180
                                              185 0 186 1 8 188 0 189 2 6 22 0
                                              7 190 2 14 0 0 62 192 2 6 0 0 193
                                              194 1 0 20 0 35 2 0 94 0 153 154
                                              2 0 0 125 8 158 1 0 81 81 139 0 0
                                              111 113 2 0 22 7 7 70 1 0 0 0 132
                                              0 0 17 157 1 0 81 81 187 1 0 101
                                              88 106 1 0 22 0 151 2 0 22 0 8
                                              191 2 0 22 0 7 28 1 0 22 0 24 0 0
                                              45 47 0 0 17 167 3 0 7 0 7 7 124
                                              0 0 45 65 2 0 0 0 62 195 1 0 81
                                              81 144 2 0 61 0 62 63 0 0 22
                                              30)))))
           '|lookupComplete|)) 

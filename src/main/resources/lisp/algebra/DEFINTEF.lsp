
(SDEFUN |DEFINTEF;innerint;FS2OcBU;1|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) (|ignor?| (|Boolean|))
         ($
          (|Union| (|:| |f1| (|OrderedCompletion| F))
                   (|:| |f2| (|List| (|OrderedCompletion| F)))
                   (|:| |fail| #1="failed") (|:| |pole| #2="potentialPole"))))
        (SPROG
         ((#3=#:G764 NIL) (|v| (|Union| F "failed"))
          (|u|
           (|Union| (|:| |f1| (|OrderedCompletion| F))
                    (|:| |f2| (|List| (|OrderedCompletion| F)))
                    (|:| |fail| #1#) (|:| |pole| #2#))))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |u| (|DEFINTEF;int| |f| |x| |a| |b| |ignor?| $))
                 (EXIT
                  (COND
                   ((OR (QEQCAR |u| 0) (QEQCAR |u| 1))
                    (PROGN (LETT #3# |u|) (GO #4=#:G758)))
                   ('T
                    (SEQ (LETT |v| (SPADCALL |f| |x| |a| |b| (QREFELT $ 12)))
                         (EXIT
                          (COND
                           ((QEQCAR |v| 1)
                            (PROGN (LETT #3# |u|) (GO #4#))))))))))
            (EXIT (CONS 0 (SPADCALL (QCDR |v|) (QREFELT $ 13))))))
          #4# (EXIT #3#)))) 

(SDEFUN |DEFINTEF;innerint;FS2OcBU;2|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) (|ignor?| (|Boolean|))
         ($
          (|Union| (|:| |f1| (|OrderedCompletion| F))
                   (|:| |f2| (|List| (|OrderedCompletion| F)))
                   (|:| |fail| "failed") (|:| |pole| "potentialPole"))))
        (|DEFINTEF;int| |f| |x| |a| |b| |ignor?| $)) 

(SDEFUN |DEFINTEF;innerint;FS2OcBU;3|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) (|ignor?| (|Boolean|))
         ($
          (|Union| (|:| |f1| (|OrderedCompletion| F))
                   (|:| |f2| (|List| (|OrderedCompletion| F)))
                   (|:| |fail| "failed") (|:| |pole| "potentialPole"))))
        (|DEFINTEF;int| |f| |x| |a| |b| |ignor?| $)) 

(SDEFUN |DEFINTEF;innerint;FS2OcBU;4|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) (|ignor?| (|Boolean|))
         ($
          (|Union| (|:| |f1| (|OrderedCompletion| F))
                   (|:| |f2| (|List| (|OrderedCompletion| F)))
                   (|:| |fail| "failed") (|:| |pole| "potentialPole"))))
        (|DEFINTEF;int| |f| |x| |a| |b| |ignor?| $)) 

(SDEFUN |DEFINTEF;integrate;FSbU;5|
        ((|f| (F)) (|s| (|SegmentBinding| (|OrderedCompletion| F)))
         ($
          (|Union| (|:| |f1| (|OrderedCompletion| F))
                   (|:| |f2| (|List| (|OrderedCompletion| F)))
                   (|:| |fail| "failed") (|:| |pole| "potentialPole"))))
        (SPADCALL |f| (SPADCALL |s| (QREFELT $ 18))
                  (SPADCALL (SPADCALL |s| (QREFELT $ 20)) (QREFELT $ 21))
                  (SPADCALL (SPADCALL |s| (QREFELT $ 20)) (QREFELT $ 22)) NIL
                  (QREFELT $ 16))) 

(SDEFUN |DEFINTEF;integrate;FSbSU;6|
        ((|f| (F)) (|s| (|SegmentBinding| (|OrderedCompletion| F)))
         (|str| (|String|))
         ($
          (|Union| (|:| |f1| (|OrderedCompletion| F))
                   (|:| |f2| (|List| (|OrderedCompletion| F)))
                   (|:| |fail| "failed") (|:| |pole| "potentialPole"))))
        (SPADCALL |f| (SPADCALL |s| (QREFELT $ 18))
                  (SPADCALL (SPADCALL |s| (QREFELT $ 20)) (QREFELT $ 21))
                  (SPADCALL (SPADCALL |s| (QREFELT $ 20)) (QREFELT $ 22))
                  (SPADCALL |str| (QREFELT $ 26)) (QREFELT $ 16))) 

(SDEFUN |DEFINTEF;int|
        ((|f| (F)) (|x| (|Symbol|)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) (|ignor?| (|Boolean|))
         ($
          (|Union| (|:| |f1| (|OrderedCompletion| F))
                   (|:| |f2| (|List| (|OrderedCompletion| F)))
                   (|:| |fail| "failed") (|:| |pole| #1="potentialPole"))))
        (SPROG ((|z| (|Union| (|Boolean|) "failed")) (|k| (|Kernel| F)))
               (SEQ
                (COND
                 ((SPADCALL |a| |b| (QREFELT $ 28))
                  (CONS 0 (SPADCALL (|spadConstant| $ 29) (QREFELT $ 13))))
                 (#2='T
                  (SEQ (LETT |k| (SPADCALL |x| (QREFELT $ 31)))
                       (LETT |z|
                             (|DEFINTEF;checkForPole| |f| |x| |k| |a| |b| $))
                       (EXIT
                        (COND
                         ((QEQCAR |z| 1)
                          (COND
                           (|ignor?| (|DEFINTEF;nopole| |f| |x| |k| |a| |b| $))
                           (#2# (CONS 3 #1#))))
                         ((QCDR |z|)
                          (|error| "integrate: pole in path of integration"))
                         (#2# (|DEFINTEF;nopole| |f| |x| |k| |a| |b| $)))))))))) 

(SDEFUN |DEFINTEF;checkForPole|
        ((|f| (F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         (|a| (|OrderedCompletion| F)) (|b| (|OrderedCompletion| F))
         ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((#1=#:G812 NIL) (|u| (|Union| (|Boolean|) "failed"))
          (|d| (|SparseMultivariatePolynomial| R (|Kernel| F))))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (LETT |u|
                   (|DEFINTEF;checkFor0|
                    (LETT |d| (SPADCALL |f| (QREFELT $ 33))) |k| |a| |b| $))
             (EXIT
              (COND
               ((OR (QEQCAR |u| 1) (QCDR |u|))
                (PROGN (LETT #1# |u|) (GO #2=#:G810))))))
            (SEQ (LETT |u| (|DEFINTEF;checkSMP| |d| |x| |k| |a| |b| $))
                 (EXIT
                  (COND
                   ((OR (QEQCAR |u| 1) (QCDR |u|))
                    (PROGN (LETT #1# |u|) (GO #2#))))))
            (EXIT
             (|DEFINTEF;checkSMP| (SPADCALL |f| (QREFELT $ 34)) |x| |k| |a| |b|
              $))))
          #2# (EXIT #1#)))) 

(SDEFUN |DEFINTEF;checkFor0|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         (|x| (|Kernel| F)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) ($ (|Union| (|Boolean|) #1="failed")))
        (SPROG
         ((#2=#:G851 NIL) (|w| (|Union| (|Boolean|) #1#)) (|k| #3=(|Kernel| F))
          (|z|
           (|Union|
            (|Record| (|:| |var| #3#) (|:| |exponent| (|NonNegativeInteger|)))
            #4="failed"))
          (#5=#:G850 NIL) (#6=#:G852 NIL) (#7=#:G853 NIL) (|t| NIL)
          (|v|
           (|Union| (|List| (|SparseMultivariatePolynomial| R (|Kernel| F)))
                    #4#))
          (|u| (|Union| (|SparseUnivariatePolynomial| F) "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |u| (|DEFINTEF;polyIfCan| |p| |x| $))
                (EXIT
                 (COND
                  ((QEQCAR |u| 0)
                   (SPADCALL (QCDR |u|) |a| |b| NIL (QREFELT $ 37)))
                  (#8='T
                   (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 40)))
                        (EXIT
                         (COND
                          ((QEQCAR |v| 0)
                           (SEQ
                            (SEQ
                             (EXIT
                              (SEQ (LETT |t| NIL) (LETT #7# (QCDR |v|)) G190
                                   (COND
                                    ((OR (ATOM #7#)
                                         (PROGN (LETT |t| (CAR #7#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (LETT |w|
                                          (|DEFINTEF;checkFor0| |t| |x| |a| |b|
                                           $))
                                    (EXIT
                                     (COND
                                      ((OR (QEQCAR |w| 1) (QCDR |w|))
                                       (PROGN
                                        (LETT #5#
                                              (PROGN
                                               (LETT #6# |w|)
                                               (GO #9=#:G849)))
                                        (GO #10=#:G826))))))
                                   (LETT #7# (CDR #7#)) (GO G190) G191
                                   (EXIT NIL)))
                             #10# (EXIT #5#))
                            (EXIT (CONS 0 NIL))))
                          (#8#
                           (SEQ (LETT |z| (SPADCALL |p| (QREFELT $ 43)))
                                (EXIT
                                 (COND ((QEQCAR |z| 1) (CONS 1 "failed"))
                                       (#8#
                                        (SEQ (LETT |k| (QCAR (QCDR |z|)))
                                             (COND
                                              ((OR
                                                (SPADCALL |k| '|exp|
                                                          (QREFELT $ 44))
                                                (OR
                                                 (SPADCALL |k| '|acot|
                                                           (QREFELT $ 44))
                                                 (SPADCALL |k| '|cosh|
                                                           (QREFELT $ 44))))
                                               (EXIT (CONS 0 NIL))))
                                             (EXIT
                                              (COND
                                               ((SPADCALL |k| '|log|
                                                          (QREFELT $ 44))
                                                (SEQ
                                                 (EXIT
                                                  (SEQ
                                                   (SEQ
                                                    (LETT |w|
                                                          (|DEFINTEF;moreThan|
                                                           |b|
                                                           (|spadConstant| $
                                                                           46)
                                                           $))
                                                    (EXIT
                                                     (COND
                                                      ((OR (QEQCAR |w| 1)
                                                           (NULL (QCDR |w|)))
                                                       (PROGN
                                                        (LETT #2# |w|)
                                                        (GO #11=#:G844))))))
                                                   (EXIT
                                                    (|DEFINTEF;moreThan|
                                                     (SPADCALL |a|
                                                               (QREFELT $ 47))
                                                     (SPADCALL
                                                      (|spadConstant| $ 46)
                                                      (QREFELT $ 50))
                                                     $))))
                                                 #11# (EXIT #2#)))
                                               (#8#
                                                (CONS 1
                                                      "failed"))))))))))))))))))
          #9# (EXIT #6#)))) 

(SDEFUN |DEFINTEF;moreThan|
        ((|a| (|OrderedCompletion| F)) (|b| (|Fraction| (|Integer|)))
         ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((|u| (|Union| (|Fraction| (|Integer|)) "failed"))
          (|r| (|Union| F "failed")))
         (SEQ (LETT |r| (SPADCALL |a| (QREFELT $ 51)))
              (EXIT
               (COND
                ((QEQCAR |r| 1)
                 (CONS 0
                       (SPADCALL (SPADCALL |a| (QREFELT $ 53)) 0
                                 (QREFELT $ 55))))
                (#1='T
                 (SEQ (LETT |u| (SPADCALL (QCDR |r|) (QREFELT $ 57)))
                      (EXIT
                       (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                             (#1#
                              (CONS 0
                                    (SPADCALL (QCDR |u|) |b|
                                              (QREFELT $ 58))))))))))))) 

(SDEFUN |DEFINTEF;checkSMP|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) (|x| (|Symbol|))
         (|k| (|Kernel| F)) (|a| (|OrderedCompletion| F))
         (|b| (|OrderedCompletion| F)) ($ (|Union| (|Boolean|) #1="failed")))
        (SPROG
         ((#2=#:G983 NIL) (|w| (|Union| (|Boolean|) #1#)) (|f2| (F))
          (#3=#:G984 NIL) (#4=#:G985 NIL) (#5=#:G982 NIL) (#6=#:G991 NIL)
          (|f| (F)) (|ak| (|List| F)) (|kk| #7=(|Kernel| F))
          (|z|
           (|Union|
            (|Record| (|:| |var| #7#) (|:| |exponent| (|NonNegativeInteger|)))
            #8="failed"))
          (|n| (R)) (#9=#:G994 NIL) (#10=#:G996 NIL) (|t| NIL)
          (|v|
           (|Union| (|List| (|SparseMultivariatePolynomial| R (|Kernel| F)))
                    #8#))
          (#11=#:G981 NIL) (#12=#:G995 NIL)
          (|u| (|Union| (|SparseUnivariatePolynomial| F) "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |u| (|DEFINTEF;polyIfCan| |p| |k| $))
                (EXIT
                 (COND ((QEQCAR |u| 0) (CONS 0 NIL))
                       (#13='T
                        (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 40)))
                             (EXIT
                              (COND
                               ((QEQCAR |v| 0)
                                (SEQ
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |t| NIL) (LETT #12# (QCDR |v|))
                                        G190
                                        (COND
                                         ((OR (ATOM #12#)
                                              (PROGN
                                               (LETT |t| (CAR #12#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (LETT |w|
                                               (|DEFINTEF;checkSMP| |t| |x| |k|
                                                |a| |b| $))
                                         (EXIT
                                          (COND
                                           ((OR (QEQCAR |w| 1) (QCDR |w|))
                                            (PROGN
                                             (LETT #11#
                                                   (PROGN
                                                    (LETT #9# |w|)
                                                    (GO #14=#:G980)))
                                             (GO #15=#:G880))))))
                                        (LETT #12# (CDR #12#)) (GO G190) G191
                                        (EXIT NIL)))
                                  #15# (EXIT #11#))
                                 (EXIT (CONS 0 NIL))))
                               (#13#
                                (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 59)))
                                     (EXIT
                                      (COND
                                       ((QEQCAR |v| 0)
                                        (SEQ (LETT |n| (|spadConstant| $ 54))
                                             (SEQ (LETT |t| NIL)
                                                  (LETT #10# (QCDR |v|)) G190
                                                  (COND
                                                   ((OR (ATOM #10#)
                                                        (PROGN
                                                         (LETT |t| (CAR #10#))
                                                         NIL))
                                                    (GO G191)))
                                                  (SEQ
                                                   (LETT |w|
                                                         (|DEFINTEF;checkSMP|
                                                          |t| |x| |k| |a| |b|
                                                          $))
                                                   (EXIT
                                                    (COND
                                                     ((QEQCAR |w| 1)
                                                      (PROGN
                                                       (LETT #9# |w|)
                                                       (GO #14#)))
                                                     ((QCDR |w|)
                                                      (LETT |n|
                                                            (SPADCALL |n|
                                                                      (|spadConstant|
                                                                       $ 48)
                                                                      (QREFELT
                                                                       $
                                                                       60)))))))
                                                  (LETT #10# (CDR #10#))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((SPADCALL |n| (QREFELT $ 61))
                                                (CONS 0 NIL))
                                               ((SPADCALL |n|
                                                          (|spadConstant| $ 48)
                                                          (QREFELT $ 62))
                                                (CONS 0 'T))
                                               (#13# (CONS 1 "failed"))))))
                                       (#13#
                                        (SEQ
                                         (LETT |z|
                                               (SPADCALL |p| (QREFELT $ 43)))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |z| 1) (CONS 1 "failed"))
                                           (#13#
                                            (SEQ (LETT |kk| (QCAR (QCDR |z|)))
                                                 (EXIT
                                                  (COND
                                                   ((SPADCALL
                                                     (SPADCALL |kk|
                                                               (QREFELT $ 64))
                                                     (QREFELT $ 65))
                                                    (CONS 0 NIL))
                                                   (#13#
                                                    (SEQ
                                                     (LETT |ak|
                                                           (SPADCALL |kk|
                                                                     (QREFELT $
                                                                              67)))
                                                     (LETT |f|
                                                           (|SPADfirst| |ak|))
                                                     (COND
                                                      ((OR
                                                        (SPADCALL |kk| '|exp|
                                                                  (QREFELT $
                                                                           44))
                                                        (OR
                                                         (SPADCALL |kk| '|sin|
                                                                   (QREFELT $
                                                                            44))
                                                         (OR
                                                          (SPADCALL |kk| '|cos|
                                                                    (QREFELT $
                                                                             44))
                                                          (OR
                                                           (SPADCALL |kk|
                                                                     '|sinh|
                                                                     (QREFELT $
                                                                              44))
                                                           (OR
                                                            (SPADCALL |kk|
                                                                      '|cosh|
                                                                      (QREFELT
                                                                       $ 44))
                                                            (OR
                                                             (SPADCALL |kk|
                                                                       '|tanh|
                                                                       (QREFELT
                                                                        $ 44))
                                                             (OR
                                                              (SPADCALL |kk|
                                                                        '|sech|
                                                                        (QREFELT
                                                                         $ 44))
                                                              (OR
                                                               (SPADCALL |kk|
                                                                         '|atan|
                                                                         (QREFELT
                                                                          $
                                                                          44))
                                                               (OR
                                                                (SPADCALL |kk|
                                                                          '|acot|
                                                                          (QREFELT
                                                                           $
                                                                           44))
                                                                (OR
                                                                 (SPADCALL |kk|
                                                                           '|asinh|
                                                                           (QREFELT
                                                                            $
                                                                            44))
                                                                 (OR
                                                                  (SPADCALL
                                                                   |kk| '|erf|
                                                                   (QREFELT $
                                                                            44))
                                                                  (OR
                                                                   (SPADCALL
                                                                    |kk|
                                                                    '|erfi|
                                                                    (QREFELT $
                                                                             44))
                                                                   (OR
                                                                    (SPADCALL
                                                                     |kk|
                                                                     '|fresnelC|
                                                                     (QREFELT $
                                                                              44))
                                                                    (OR
                                                                     (SPADCALL
                                                                      |kk|
                                                                      '|fresnelS|
                                                                      (QREFELT
                                                                       $ 44))
                                                                     (OR
                                                                      (SPADCALL
                                                                       |kk|
                                                                       '|Si|
                                                                       (QREFELT
                                                                        $ 44))
                                                                      (SPADCALL
                                                                       |kk|
                                                                       '|Shi|
                                                                       (QREFELT
                                                                        $
                                                                        44)))))))))))))))))
                                                       (EXIT
                                                        (|DEFINTEF;checkForPole|
                                                         |f| |x| |k| |a| |b|
                                                         $))))
                                                     (COND
                                                      ((OR
                                                        (SPADCALL |kk| '|asin|
                                                                  (QREFELT $
                                                                           44))
                                                        (OR
                                                         (SPADCALL |kk| '|acos|
                                                                   (QREFELT $
                                                                            44))
                                                         (SPADCALL |kk|
                                                                   '|atanh|
                                                                   (QREFELT $
                                                                            44))))
                                                       (EXIT
                                                        (SEQ
                                                         (EXIT
                                                          (SEQ
                                                           (SEQ
                                                            (LETT |w|
                                                                  (|DEFINTEF;checkForPole|
                                                                   |f| |x| |k|
                                                                   |a| |b| $))
                                                            (EXIT
                                                             (COND
                                                              ((OR
                                                                (QEQCAR |w| 1)
                                                                (QCDR |w|))
                                                               (PROGN
                                                                (LETT #6# |w|)
                                                                (GO
                                                                 #16=#:G911))))))
                                                           (SEQ
                                                            (LETT |w|
                                                                  (|DEFINTEF;posit|
                                                                   (SPADCALL
                                                                    |f|
                                                                    (|spadConstant|
                                                                     $ 49)
                                                                    (QREFELT $
                                                                             68))
                                                                   |x| |k| |a|
                                                                   |b| $))
                                                            (EXIT
                                                             (COND
                                                              ((OR
                                                                (QEQCAR |w| 1)
                                                                (QCDR |w|))
                                                               (PROGN
                                                                (LETT #6# |w|)
                                                                (GO #16#))))))
                                                           (EXIT
                                                            (|DEFINTEF;negat|
                                                             (SPADCALL |f|
                                                                       (|spadConstant|
                                                                        $ 49)
                                                                       (QREFELT
                                                                        $ 69))
                                                             |x| |k| |a| |b|
                                                             $))))
                                                         #16# (EXIT #6#)))))
                                                     (EXIT
                                                      (COND
                                                       ((SPADCALL |kk| '|acosh|
                                                                  (QREFELT $
                                                                           44))
                                                        (SEQ
                                                         (EXIT
                                                          (SEQ
                                                           (SEQ
                                                            (LETT |w|
                                                                  (|DEFINTEF;checkForPole|
                                                                   |f| |x| |k|
                                                                   |a| |b| $))
                                                            (EXIT
                                                             (COND
                                                              ((OR
                                                                (QEQCAR |w| 1)
                                                                (QCDR |w|))
                                                               (PROGN
                                                                (LETT #5# |w|)
                                                                (GO
                                                                 #17=#:G927))))))
                                                           (EXIT
                                                            (|DEFINTEF;negat|
                                                             (SPADCALL |f|
                                                                       (|spadConstant|
                                                                        $ 49)
                                                                       (QREFELT
                                                                        $ 68))
                                                             |x| |k| |a| |b|
                                                             $))))
                                                         #17# (EXIT #5#)))
                                                       ((OR
                                                         (SPADCALL |kk| '|log|
                                                                   (QREFELT $
                                                                            44))
                                                         (OR
                                                          (SPADCALL |kk|
                                                                    '|nthRoot|
                                                                    (QREFELT $
                                                                             44))
                                                          (OR
                                                           (SPADCALL |kk| '|Ei|
                                                                     (QREFELT $
                                                                              44))
                                                           (OR
                                                            (SPADCALL |kk|
                                                                      '|Ci|
                                                                      (QREFELT
                                                                       $ 44))
                                                            (OR
                                                             (SPADCALL |kk|
                                                                       '|Chi|
                                                                       (QREFELT
                                                                        $ 44))
                                                             (SPADCALL |kk|
                                                                       '|dilog|
                                                                       (QREFELT
                                                                        $
                                                                        44)))))))
                                                        (SEQ
                                                         (EXIT
                                                          (SEQ
                                                           (SEQ
                                                            (LETT |w|
                                                                  (|DEFINTEF;checkForPole|
                                                                   |f| |x| |k|
                                                                   |a| |b| $))
                                                            (EXIT
                                                             (COND
                                                              ((OR
                                                                (QEQCAR |w| 1)
                                                                (QCDR |w|))
                                                               (PROGN
                                                                (LETT #4# |w|)
                                                                (GO
                                                                 #18=#:G930))))))
                                                           (EXIT
                                                            (|DEFINTEF;negat|
                                                             |f| |x| |k| |a|
                                                             |b| $))))
                                                         #18# (EXIT #4#)))
                                                       ('T
                                                        (SEQ
                                                         (COND
                                                          ((SPADCALL |kk|
                                                                     '|Gamma|
                                                                     (QREFELT $
                                                                              44))
                                                           (COND
                                                            ((EQL (LENGTH |ak|)
                                                                  2)
                                                             (COND
                                                              ((SPADCALL
                                                                (SPADCALL |f|
                                                                          |x|
                                                                          (QREFELT
                                                                           $
                                                                           70))
                                                                (|spadConstant|
                                                                 $ 29)
                                                                (QREFELT $ 71))
                                                               (EXIT
                                                                (SEQ
                                                                 (EXIT
                                                                  (SEQ
                                                                   (LETT |f2|
                                                                         (SPADCALL
                                                                          |ak|
                                                                          2
                                                                          (QREFELT
                                                                           $
                                                                           73)))
                                                                   (SEQ
                                                                    (LETT |w|
                                                                          (|DEFINTEF;checkForPole|
                                                                           |f2|
                                                                           |x|
                                                                           |k|
                                                                           |a|
                                                                           |b|
                                                                           $))
                                                                    (EXIT
                                                                     (COND
                                                                      ((OR
                                                                        (QEQCAR
                                                                         |w| 1)
                                                                        (QCDR
                                                                         |w|))
                                                                       (PROGN
                                                                        (LETT
                                                                         #3#
                                                                         |w|)
                                                                        (GO
                                                                         #19=#:G964))))))
                                                                   (EXIT
                                                                    (|DEFINTEF;negat|
                                                                     |f2| |x|
                                                                     |k| |a|
                                                                     |b| $))))
                                                                 #19#
                                                                 (EXIT
                                                                  #3#)))))))))
                                                         (COND
                                                          ((SPADCALL |kk|
                                                                     '|polylog|
                                                                     (QREFELT $
                                                                              44))
                                                           (COND
                                                            ((SPADCALL
                                                              (SPADCALL |f| |x|
                                                                        (QREFELT
                                                                         $ 70))
                                                              (|spadConstant| $
                                                                              29)
                                                              (QREFELT $ 71))
                                                             (EXIT
                                                              (SEQ
                                                               (EXIT
                                                                (SEQ
                                                                 (LETT |f2|
                                                                       (SPADCALL
                                                                        |ak| 2
                                                                        (QREFELT
                                                                         $
                                                                         73)))
                                                                 (SEQ
                                                                  (LETT |w|
                                                                        (|DEFINTEF;checkForPole|
                                                                         |f2|
                                                                         |x|
                                                                         |k|
                                                                         |a|
                                                                         |b|
                                                                         $))
                                                                  (EXIT
                                                                   (COND
                                                                    ((OR
                                                                      (QEQCAR
                                                                       |w| 1)
                                                                      (QCDR
                                                                       |w|))
                                                                     (PROGN
                                                                      (LETT #2#
                                                                            |w|)
                                                                      (GO
                                                                       #20=#:G970))))))
                                                                 (EXIT
                                                                  (|DEFINTEF;posit|
                                                                   (SPADCALL
                                                                    |f|
                                                                    (|spadConstant|
                                                                     $ 49)
                                                                    (QREFELT $
                                                                             68))
                                                                   |x| |k| |a|
                                                                   |b| $))))
                                                               #20#
                                                               (EXIT #2#)))))))
                                                         (EXIT
                                                          (CONS 1
                                                                "failed"))))))))))))))))))))))))))))
          #14# (EXIT #9#)))) 

(SDEFUN |DEFINTEF;posit|
        ((|f| (F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         (|a| (|OrderedCompletion| F)) (|b| (|OrderedCompletion| F))
         ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((#1=#:G1015 NIL) (|w| (|Union| (|Boolean|) "failed"))
          (#2=#:G1016 NIL) (#3=#:G1004 NIL) (|b2| #4=(|Boolean|))
          (|z| (|Union| (|Integer|) #5="failed")) (|r| (|Union| F "failed"))
          (|b1| #4#))
         (SEQ
          (EXIT
           (SEQ
            (LETT |z|
                  (SEQ (LETT |r| (SPADCALL |a| (QREFELT $ 51)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1) (SPADCALL |f| |x| |a| (QREFELT $ 76)))
                         (#6='T
                          (SPADCALL |f| |x| (QCDR |r|) "right"
                                    (QREFELT $ 77)))))))
            (SEQ (LETT |b1| (QEQCAR |z| 0))
                 (EXIT
                  (COND
                   (|b1|
                    (COND
                     ((>
                       (PROG2 (LETT #3# |z|)
                           (QCDR #3#)
                         (|check_union2| (QEQCAR #3# 0) (|Integer|)
                                         (|Union| (|Integer|) #5#) #3#))
                       0)
                      (PROGN (LETT #2# (CONS 0 'T)) (GO #7=#:G1013))))))))
            (LETT |z|
                  (SEQ (LETT |r| (SPADCALL |b| (QREFELT $ 51)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1) (SPADCALL |f| |x| |b| (QREFELT $ 76)))
                         (#6#
                          (SPADCALL |f| |x| (QCDR |r|) "left"
                                    (QREFELT $ 77)))))))
            (SEQ (LETT |b2| (QEQCAR |z| 0))
                 (EXIT
                  (COND
                   (|b2|
                    (COND
                     ((>
                       (PROG2 (LETT #3# |z|)
                           (QCDR #3#)
                         (|check_union2| (QEQCAR #3# 0) (|Integer|)
                                         (|Union| (|Integer|) #5#) #3#))
                       0)
                      (PROGN (LETT #2# (CONS 0 'T)) (GO #7#))))))))
            (COND
             (|b1|
              (COND
               (|b2|
                (EXIT
                 (SEQ
                  (EXIT
                   (SEQ
                    (SEQ
                     (LETT |w|
                           (|DEFINTEF;checkFor0| (SPADCALL |f| (QREFELT $ 34))
                            |k| |a| |b| $))
                     (EXIT
                      (COND
                       ((OR (QEQCAR |w| 1) (QCDR |w|))
                        (PROGN
                         (LETT #1# (CONS 1 "failed"))
                         (GO #8=#:G1012))))))
                    (EXIT (CONS 0 NIL))))
                  #8# (EXIT #1#)))))))
            (EXIT (CONS 1 "failed"))))
          #7# (EXIT #2#)))) 

(SDEFUN |DEFINTEF;negat|
        ((|f| (F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         (|a| (|OrderedCompletion| F)) (|b| (|OrderedCompletion| F))
         ($ (|Union| (|Boolean|) "failed")))
        (SPROG
         ((#1=#:G1035 NIL) (|w| (|Union| (|Boolean|) "failed"))
          (#2=#:G1036 NIL) (#3=#:G1024 NIL) (|b2| #4=(|Boolean|))
          (|z| (|Union| (|Integer|) #5="failed")) (|r| (|Union| F "failed"))
          (|b1| #4#))
         (SEQ
          (EXIT
           (SEQ
            (LETT |z|
                  (SEQ (LETT |r| (SPADCALL |a| (QREFELT $ 51)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1) (SPADCALL |f| |x| |a| (QREFELT $ 76)))
                         (#6='T
                          (SPADCALL |f| |x| (QCDR |r|) "right"
                                    (QREFELT $ 77)))))))
            (SEQ (LETT |b1| (QEQCAR |z| 0))
                 (EXIT
                  (COND
                   (|b1|
                    (COND
                     ((<
                       (PROG2 (LETT #3# |z|)
                           (QCDR #3#)
                         (|check_union2| (QEQCAR #3# 0) (|Integer|)
                                         (|Union| (|Integer|) #5#) #3#))
                       0)
                      (PROGN (LETT #2# (CONS 0 'T)) (GO #7=#:G1033))))))))
            (LETT |z|
                  (SEQ (LETT |r| (SPADCALL |b| (QREFELT $ 51)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1) (SPADCALL |f| |x| |b| (QREFELT $ 76)))
                         (#6#
                          (SPADCALL |f| |x| (QCDR |r|) "left"
                                    (QREFELT $ 77)))))))
            (SEQ (LETT |b2| (QEQCAR |z| 0))
                 (EXIT
                  (COND
                   (|b2|
                    (COND
                     ((<
                       (PROG2 (LETT #3# |z|)
                           (QCDR #3#)
                         (|check_union2| (QEQCAR #3# 0) (|Integer|)
                                         (|Union| (|Integer|) #5#) #3#))
                       0)
                      (PROGN (LETT #2# (CONS 0 'T)) (GO #7#))))))))
            (COND
             (|b1|
              (COND
               (|b2|
                (EXIT
                 (SEQ
                  (EXIT
                   (SEQ
                    (SEQ
                     (LETT |w|
                           (|DEFINTEF;checkFor0| (SPADCALL |f| (QREFELT $ 34))
                            |k| |a| |b| $))
                     (EXIT
                      (COND
                       ((OR (QEQCAR |w| 1) (QCDR |w|))
                        (PROGN
                         (LETT #1# (CONS 1 "failed"))
                         (GO #8=#:G1032))))))
                    (EXIT (CONS 0 NIL))))
                  #8# (EXIT #1#)))))))
            (EXIT (CONS 1 "failed"))))
          #7# (EXIT #2#)))) 

(SDEFUN |DEFINTEF;polyIfCan|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         (|x| (|Kernel| F))
         ($ (|Union| (|SparseUnivariatePolynomial| F) "failed")))
        (SPROG
         ((|q|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|ans| (|SparseUnivariatePolynomial| F)) (#1=#:G1046 NIL) (|c| (F)))
         (SEQ
          (EXIT
           (SEQ (LETT |q| (SPADCALL |p| |x| (QREFELT $ 79)))
                (LETT |ans| (|spadConstant| $ 80))
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL |q| (|spadConstant| $ 82) (QREFELT $ 83)))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |x|
                                   (SPADCALL
                                    (LETT |c|
                                          (SPADCALL
                                           (SPADCALL |q| (QREFELT $ 84))
                                           (QREFELT $ 85)))
                                    (QREFELT $ 87))
                                   (QREFELT $ 89))
                         (PROGN (LETT #1# (CONS 1 "failed")) (GO #2=#:G1045)))
                        ('T
                         (SEQ
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (SPADCALL |c|
                                                    (SPADCALL |q|
                                                              (QREFELT $ 91))
                                                    (QREFELT $ 92))
                                          (QREFELT $ 93)))
                          (EXIT (LETT |q| (SPADCALL |q| (QREFELT $ 94)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |ans|))))
          #2# (EXIT #1#)))) 

(SDEFUN |DEFINTEF;nopole|
        ((|f| (F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         (|a| (|OrderedCompletion| F)) (|b| (|OrderedCompletion| F))
         ($
          (|Union| (|:| |f1| (|OrderedCompletion| F))
                   (|:| |f2| (|List| (|OrderedCompletion| F)))
                   (|:| |fail| #1="failed") (|:| |pole| "potentialPole"))))
        (SPROG
         ((|ans| (|List| (|OrderedCompletion| F))) (#2=#:G1064 NIL)
          (|v| (|Union| (|OrderedCompletion| F) "failed")) (#3=#:G1065 NIL)
          (|g| NIL) (|u| (|Union| F (|List| F))))
         (SEQ
          (EXIT
           (SEQ (LETT |u| (SPADCALL |f| |x| (QREFELT $ 97)))
                (EXIT
                 (COND
                  ((QEQCAR |u| 0)
                   (SEQ
                    (LETT |v|
                          (SPADCALL |k| (QCDR |u|) |a| |b| NIL (QREFELT $ 99)))
                    (EXIT
                     (COND ((QEQCAR |v| 1) (CONS 2 #1#))
                           (#4='T (CONS 0 (QCDR |v|)))))))
                  (#4#
                   (SEQ (LETT |ans| NIL)
                        (SEQ (LETT |g| NIL) (LETT #3# (QCDR |u|)) G190
                             (COND
                              ((OR (ATOM #3#) (PROGN (LETT |g| (CAR #3#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |v|
                                    (SPADCALL |k| |g| |a| |b| NIL
                                              (QREFELT $ 99)))
                              (EXIT
                               (COND
                                ((QEQCAR |v| 1)
                                 (PROGN
                                  (LETT #2# (CONS 2 #1#))
                                  (GO #5=#:G1063)))
                                ('T
                                 (LETT |ans|
                                       (SPADCALL |ans| (LIST (QCDR |v|))
                                                 (QREFELT $ 101)))))))
                             (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                        (EXIT (CONS 1 |ans|))))))))
          #5# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |ElementaryFunctionDefiniteIntegration;|)) 

(DEFUN |ElementaryFunctionDefiniteIntegration| (&REST #1=#:G1066)
  (SPROG NIL
         (PROG (#2=#:G1067)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ElementaryFunctionDefiniteIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |ElementaryFunctionDefiniteIntegration;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ElementaryFunctionDefiniteIntegration|)))))))))) 

(DEFUN |ElementaryFunctionDefiniteIntegration;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$|
                (LIST '|ElementaryFunctionDefiniteIntegration| DV$1 DV$2))
          (LETT $ (GETREFV 102))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|ElementaryFunctionDefiniteIntegration| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|ConvertibleTo| (|Pattern| (|Integer|))))
            (COND
             ((|HasCategory| |#1| '(|PatternMatchable| (|Integer|)))
              (COND
               ((|HasCategory| |#2| '(|SpecialFunctionCategory|))
                (PROGN
                 (QSETREFV $ 16
                           (CONS
                            (|dispatchFunction| |DEFINTEF;innerint;FS2OcBU;1|)
                            $))))
               ('T
                (QSETREFV $ 16
                          (CONS
                           (|dispatchFunction| |DEFINTEF;innerint;FS2OcBU;2|)
                           $)))))
             ('T
              (QSETREFV $ 16
                        (CONS
                         (|dispatchFunction| |DEFINTEF;innerint;FS2OcBU;3|)
                         $)))))
           ('T
            (QSETREFV $ 16
                      (CONS (|dispatchFunction| |DEFINTEF;innerint;FS2OcBU;4|)
                            $))))
          $))) 

(MAKEPROP '|ElementaryFunctionDefiniteIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Union| 7 '"failed") (|Symbol|) (|OrderedCompletion| 7)
              (|PatternMatchIntegration| 6 7) (0 . |pmintegrate|)
              (8 . |coerce|)
              (|Union| (|:| |f1| 10) (|:| |f2| 100) (|:| |fail| '#1="failed")
                       (|:| |pole| '#2="potentialPole"))
              (|Boolean|) (13 . |innerint|) (|SegmentBinding| 10)
              (22 . |variable|) (|Segment| 10) (27 . |segment|) (32 . |low|)
              (37 . |high|) |DEFINTEF;integrate;FSbU;5| (|String|)
              (|DefiniteIntegrationTools| 6 7) (42 . |ignore?|)
              |DEFINTEF;integrate;FSbSU;6| (47 . =) (53 . |Zero|) (|Kernel| 7)
              (57 . |kernel|) (|SparseMultivariatePolynomial| 6 (|Kernel| $))
              (62 . |denom|) (67 . |numer|) (|Union| 15 '"failed")
              (|SparseUnivariatePolynomial| 7) (72 . |checkForZero|)
              (|Union| (|List| $) '#3="failed")
              (|SparseMultivariatePolynomial| 6 30) (80 . |isTimes|)
              (|Record| (|:| |var| 30) (|:| |exponent| 90)) (|Union| 41 '#3#)
              (85 . |isExpt|) (90 . |is?|) (|Fraction| 72) (96 . |One|)
              (100 . -) (105 . |One|) (109 . |One|) (113 . -)
              (118 . |retractIfCan|) (|SingleInteger|) (123 . |whatInfinity|)
              (128 . |Zero|) (132 . >) (|Union| 45 '"failed")
              (138 . |retractIfCan|) (143 . >) (149 . |isPlus|) (154 . +)
              (160 . |zero?|) (165 . =) (|BasicOperator|) (171 . |operator|)
              (176 . |nullary?|) (|List| 7) (181 . |argument|) (186 . -)
              (192 . +) (198 . D) (204 . =) (|Integer|) (210 . |elt|)
              (|Union| 72 '"failed") (|ElementaryFunctionSign| 6 7)
              (216 . |sign|) (223 . |sign|) (|SparseUnivariatePolynomial| $)
              (231 . |univariate|) (237 . |Zero|)
              (|SparseUnivariatePolynomial| 39) (241 . |Zero|) (245 . ~=)
              (251 . |leadingCoefficient|) (256 . |coerce|)
              (|List| (|Kernel| $)) (261 . |tower|) (|List| 30)
              (266 . |member?|) (|NonNegativeInteger|) (272 . |degree|)
              (277 . |monomial|) (283 . +) (289 . |reductum|) (|Union| 7 66)
              (|FunctionSpaceIntegration| 6 7) (294 . |integrate|)
              (|Union| 10 '"failed") (300 . |computeInt|) (|List| 10)
              (309 . |concat!|))
           '#(|integrate| 315 |innerint| 328) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|integrate|
                                 ((|Union|
                                   (|:| |f1| (|OrderedCompletion| |#2|))
                                   (|:| |f2|
                                        (|List| (|OrderedCompletion| |#2|)))
                                   (|:| |fail| #1#) (|:| |pole| #2#))
                                  |#2|
                                  (|SegmentBinding|
                                   (|OrderedCompletion| |#2|))))
                                T)
                              '((|integrate|
                                 ((|Union|
                                   (|:| |f1| (|OrderedCompletion| |#2|))
                                   (|:| |f2|
                                        (|List| (|OrderedCompletion| |#2|)))
                                   (|:| |fail| #1#) (|:| |pole| #2#))
                                  |#2|
                                  (|SegmentBinding| (|OrderedCompletion| |#2|))
                                  (|String|)))
                                T)
                              '((|innerint|
                                 ((|Union|
                                   (|:| |f1| (|OrderedCompletion| |#2|))
                                   (|:| |f2|
                                        (|List| (|OrderedCompletion| |#2|)))
                                   (|:| |fail| #1#) (|:| |pole| #2#))
                                  |#2| (|Symbol|) (|OrderedCompletion| |#2|)
                                  (|OrderedCompletion| |#2|) (|Boolean|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 101
                                            '(4 11 8 7 9 10 10 12 1 10 0 7 13 5
                                              0 14 7 9 10 10 15 16 1 17 9 0 18
                                              1 17 19 0 20 1 19 10 0 21 1 19 10
                                              0 22 1 25 15 24 26 2 10 15 0 0 28
                                              0 7 0 29 1 30 0 9 31 1 7 32 0 33
                                              1 7 32 0 34 4 25 35 36 10 10 15
                                              37 1 39 38 0 40 1 39 42 0 43 2 30
                                              15 0 9 44 0 45 0 46 1 10 0 0 47 0
                                              6 0 48 0 7 0 49 1 45 0 0 50 1 10
                                              8 0 51 1 10 52 0 53 0 6 0 54 2 52
                                              15 0 0 55 1 7 56 0 57 2 45 15 0 0
                                              58 1 39 38 0 59 2 6 0 0 0 60 1 6
                                              15 0 61 2 6 15 0 0 62 1 30 63 0
                                              64 1 63 15 0 65 1 30 66 0 67 2 7
                                              0 0 0 68 2 7 0 0 0 69 2 7 0 0 9
                                              70 2 7 15 0 0 71 2 66 7 0 72 73 3
                                              75 74 7 9 10 76 4 75 74 7 9 7 24
                                              77 2 39 78 0 30 79 0 36 0 80 0 81
                                              0 82 2 81 15 0 0 83 1 81 39 0 84
                                              1 7 0 32 85 1 7 86 0 87 2 88 15
                                              30 0 89 1 81 90 0 91 2 36 0 7 90
                                              92 2 36 0 0 0 93 1 81 0 0 94 2 96
                                              95 7 9 97 5 25 98 30 7 10 10 15
                                              99 2 100 0 0 0 101 2 0 14 7 17 23
                                              3 0 14 7 17 24 27 5 0 14 7 9 10
                                              10 15 16)))))
           '|lookupComplete|)) 

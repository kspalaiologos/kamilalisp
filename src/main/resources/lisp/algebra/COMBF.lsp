
(SDEFUN |COMBF;factorial;2F;1| ((|x| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 13) |x| (QREFELT $ 23))) 

(SDEFUN |COMBF;binomial;3F;2| ((|x| (F)) (|y| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 15) (LIST |x| |y|) (QREFELT $ 26))) 

(SDEFUN |COMBF;permutation;3F;3| ((|x| (F)) (|y| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 14) (LIST |x| |y|) (QREFELT $ 26))) 

(SDEFUN |COMBF;number?| ((|x| (F)) ($ (|Boolean|)))
        (COND
         ((|HasCategory| (QREFELT $ 6) (LIST '|RetractableTo| '(|Integer|)))
          (COND ((SPADCALL |x| (QREFELT $ 30)) 'T)
                (#1='T (QEQCAR (SPADCALL |x| (QREFELT $ 32)) 0))))
         (#1# (SPADCALL |x| (QREFELT $ 30))))) 

(SDEFUN |COMBF;^;3F;5| ((|x| (F)) (|y| (F)) ($ (F)))
        (SPADCALL (QREFELT $ 20) (LIST |x| |y|) (QREFELT $ 26))) 

(SDEFUN |COMBF;belong?;BoB;6| ((|op| (|BasicOperator|)) ($ (|Boolean|)))
        (SPADCALL |op| (QREFELT $ 8) (QREFELT $ 34))) 

(SDEFUN |COMBF;fourth| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (CDR |l|) (QREFELT $ 37))) 

(SDEFUN |COMBF;dvpow1| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                  (SPADCALL (|SPADfirst| |l|)
                            (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                                      (|spadConstant| $ 39) (QREFELT $ 40))
                            (QREFELT $ 33))
                  (QREFELT $ 41))) 

(SDEFUN |COMBF;factorials;2F;9| ((|x| (F)) ($ (F)))
        (|COMBF;facts| |x| (SPADCALL |x| (QREFELT $ 43)) $)) 

(SDEFUN |COMBF;factorials;FSF;10| ((|x| (F)) (|v| (|Symbol|)) ($ (F)))
        (|COMBF;facts| |x| (LIST |v|) $)) 

(SDEFUN |COMBF;facts| ((|x| (F)) (|l| (|List| (|Symbol|))) ($ (F)))
        (SPADCALL (|COMBF;smpfact| (SPADCALL |x| (QREFELT $ 47)) |l| $)
                  (|COMBF;smpfact| (SPADCALL |x| (QREFELT $ 48)) |l| $)
                  (QREFELT $ 49))) 

(SDEFUN |COMBF;summand| ((|l| (|List| F)) ($ (F)))
        (SPADCALL (|SPADfirst| |l|)
                  (SPADCALL (SPADCALL |l| (QREFELT $ 38)) (QREFELT $ 51))
                  (SPADCALL |l| (QREFELT $ 37)) (QREFELT $ 52))) 

(SDEFUN |COMBF;product;FSF;13| ((|x| (F)) (|i| (|Symbol|)) ($ (F)))
        (SPROG ((|k| (|Kernel| F)) (|dm| (F)))
               (SEQ
                (LETT |dm| (SPADCALL (SPADCALL (QREFELT $ 53)) (QREFELT $ 54)))
                (EXIT
                 (SPADCALL (QREFELT $ 18)
                           (LIST
                            (SPADCALL |x|
                                      (LETT |k| (SPADCALL |i| (QREFELT $ 56)))
                                      |dm| (QREFELT $ 52))
                            |dm| (SPADCALL |k| (QREFELT $ 57)))
                           (QREFELT $ 26)))))) 

(SDEFUN |COMBF;summation;FSF;14| ((|x| (F)) (|i| (|Symbol|)) ($ (F)))
        (SPROG ((|k| (|Kernel| F)) (|dm| (F)))
               (SEQ
                (LETT |dm| (SPADCALL (SPADCALL (QREFELT $ 53)) (QREFELT $ 54)))
                (EXIT
                 (SPADCALL (QREFELT $ 16)
                           (LIST
                            (SPADCALL |x|
                                      (LETT |k| (SPADCALL |i| (QREFELT $ 56)))
                                      |dm| (QREFELT $ 52))
                            |dm| (SPADCALL |k| (QREFELT $ 57)))
                           (QREFELT $ 26)))))) 

(SDEFUN |COMBF;dvsum| ((|l| (|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPADCALL (QREFELT $ 16)
                  (LIST (SPADCALL (|SPADfirst| |l|) |x| (QREFELT $ 60))
                        (SPADCALL |l| (QREFELT $ 38))
                        (SPADCALL |l| (QREFELT $ 37)))
                  (QREFELT $ 26))) 

(SDEFUN |COMBF;dvdsum| ((|l| (|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG
         ((|dh| (F)) (|dg| (F)) (|dm| (F)) (|r1| (F)) (|h| (F)) (|g| (F))
          (|v| (F)) (|f| (F)) (|y| (F)))
         (SEQ
          (COND
           ((EQUAL |x|
                   (SPADCALL (LETT |y| (SPADCALL |l| (QREFELT $ 37)))
                             (QREFELT $ 61)))
            (|spadConstant| $ 62))
           ('T
            (SEQ (LETT |f| (|SPADfirst| |l|))
                 (LETT |v| (SPADCALL |l| (QREFELT $ 38)))
                 (LETT |g| (SPADCALL |l| 4 (QREFELT $ 64)))
                 (LETT |h| (SPADCALL |l| 5 (QREFELT $ 64)))
                 (LETT |r1|
                       (SPADCALL (QREFELT $ 17)
                                 (LIST (SPADCALL |f| |x| (QREFELT $ 60)) |v|
                                       |y| |g| |h|)
                                 (QREFELT $ 26)))
                 (COND
                  ((OR
                    (SPADCALL |x| (SPADCALL |h| (QREFELT $ 43)) (QREFELT $ 65))
                    (SPADCALL |x| (SPADCALL |g| (QREFELT $ 43))
                              (QREFELT $ 65)))
                   (EXIT
                    (SEQ
                     (LETT |dm|
                           (SPADCALL (SPADCALL (QREFELT $ 53)) (QREFELT $ 54)))
                     (LETT |dg|
                           (SPADCALL (QREFELT $ 22)
                                     (LIST
                                      (SPADCALL (QREFELT $ 17)
                                                (LIST |f| |v| |y| |dm| |h|)
                                                (QREFELT $ 26))
                                      |dm| |g|)
                                     (QREFELT $ 66)))
                     (LETT |dh|
                           (SPADCALL (QREFELT $ 22)
                                     (LIST
                                      (SPADCALL (QREFELT $ 17)
                                                (LIST |f| |v| |y| |g| |dm|)
                                                (QREFELT $ 26))
                                      |dm| |h|)
                                     (QREFELT $ 66)))
                     (EXIT
                      (SPADCALL
                       (SPADCALL |r1|
                                 (SPADCALL (SPADCALL |g| |x| (QREFELT $ 60))
                                           |dg| (QREFELT $ 41))
                                 (QREFELT $ 67))
                       (SPADCALL (SPADCALL |h| |x| (QREFELT $ 60)) |dh|
                                 (QREFELT $ 41))
                       (QREFELT $ 67)))))))
                 (EXIT |r1|))))))) 

(SDEFUN |COMBF;dvprod| ((|l| (|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG ((|p| (F)) (|f| (F)) (|dm| (|Symbol|)))
               (SEQ
                (LETT |dm|
                      (SPADCALL
                       (SPADCALL (SPADCALL (QREFELT $ 53)) (QREFELT $ 54))
                       (QREFELT $ 61)))
                (LETT |f|
                      (SPADCALL (|SPADfirst| |l|)
                                (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                                          (QREFELT $ 51))
                                (SPADCALL |dm| (QREFELT $ 54)) (QREFELT $ 52)))
                (LETT |p| (SPADCALL |f| |dm| (QREFELT $ 58)))
                (EXIT
                 (SPADCALL (QREFELT $ 16)
                           (LIST
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (|SPADfirst| |l|) |x| (QREFELT $ 60))
                              (|SPADfirst| |l|) (QREFELT $ 49))
                             |p| (QREFELT $ 41))
                            (SPADCALL |l| (QREFELT $ 38))
                            (SPADCALL |l| (QREFELT $ 37)))
                           (QREFELT $ 26)))))) 

(SDEFUN |COMBF;dvdprod| ((|l| (|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG ((|g| (F)) (|h| (F)) (|y| (F)))
               (COND
                ((EQUAL |x|
                        (SPADCALL (LETT |y| (SPADCALL |l| (QREFELT $ 37)))
                                  (QREFELT $ 61)))
                 (|spadConstant| $ 62))
                ((OR
                  (SPADCALL |x|
                            (SPADCALL
                             (LETT |h|
                                   (SPADCALL (CDR (CDR |l|)) (QREFELT $ 37)))
                             (QREFELT $ 43))
                            (QREFELT $ 65))
                  (SPADCALL |x|
                            (SPADCALL
                             (LETT |g| (SPADCALL (CDR |l|) (QREFELT $ 37)))
                             (QREFELT $ 43))
                            (QREFELT $ 65)))
                 (|error|
                  "a product cannot be differentiated with respect to a bound"))
                ('T
                 (SPADCALL
                  (SPADCALL (QREFELT $ 17)
                            (CONS
                             (SPADCALL
                              (SPADCALL (|SPADfirst| |l|) |x| (QREFELT $ 60))
                              (|SPADfirst| |l|) (QREFELT $ 49))
                             (CDR |l|))
                            (QREFELT $ 26))
                  (SPADCALL (QREFELT $ 19) |l| (QREFELT $ 26))
                  (QREFELT $ 41)))))) 

(SDEFUN |COMBF;dprod| ((|l| (|List| F)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (|COMBF;summand| |l| $) (QREFELT $ 69))
                  (SPADCALL (SPADCALL |l| (QREFELT $ 37)) (QREFELT $ 69))
                  (QREFELT $ 70))) 

(SDEFUN |COMBF;ddprod| ((|l| (|List| F)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (|COMBF;summand| |l| $) (QREFELT $ 69))
                  (SPADCALL
                   (SPADCALL (SPADCALL |l| (QREFELT $ 37)) (QREFELT $ 69))
                   (SPADCALL (|COMBF;fourth| |l| $) (QREFELT $ 69))
                   (QREFELT $ 71))
                  (SPADCALL (|COMBF;fourth| (CDR |l|) $) (QREFELT $ 69))
                  (QREFELT $ 72))) 

(SDEFUN |COMBF;dsum| ((|l| (|List| F)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (|COMBF;summand| |l| $) (QREFELT $ 69))
                  (SPADCALL (SPADCALL |l| (QREFELT $ 37)) (QREFELT $ 69))
                  (QREFELT $ 73))) 

(SDEFUN |COMBF;ddsum| ((|l| (|List| F)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (|COMBF;summand| |l| $) (QREFELT $ 69))
                  (SPADCALL
                   (SPADCALL (SPADCALL |l| (QREFELT $ 37)) (QREFELT $ 69))
                   (SPADCALL (|COMBF;fourth| |l| $) (QREFELT $ 69))
                   (QREFELT $ 71))
                  (SPADCALL (|COMBF;fourth| (CDR |l|) $) (QREFELT $ 69))
                  (QREFELT $ 74))) 

(SDEFUN |COMBF;equalsumprod|
        ((|s1| (|Kernel| F)) (|s2| (|Kernel| F)) ($ (|Boolean|)))
        (SPROG ((|l2| #1=(|List| F)) (|l1| #1#))
               (SEQ (LETT |l1| (SPADCALL |s1| (QREFELT $ 75)))
                    (LETT |l2| (SPADCALL |s2| (QREFELT $ 75)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (|SPADfirst| |l1|)
                                (SPADCALL (SPADCALL |l1| (QREFELT $ 38))
                                          (QREFELT $ 51))
                                (SPADCALL |l2| (QREFELT $ 38)) (QREFELT $ 52))
                      (|SPADfirst| |l2|) (QREFELT $ 76)))))) 

(SDEFUN |COMBF;equaldsumprod|
        ((|s1| (|Kernel| F)) (|s2| (|Kernel| F)) ($ (|Boolean|)))
        (SPROG ((|l2| #1=(|List| F)) (|l1| #1#))
               (SEQ (LETT |l1| (SPADCALL |s1| (QREFELT $ 75)))
                    (LETT |l2| (SPADCALL |s2| (QREFELT $ 75)))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL (CDR |l1|) (QREFELT $ 37))
                                 (SPADCALL (CDR |l2|) (QREFELT $ 37))
                                 (QREFELT $ 76))
                       (COND
                        ((SPADCALL (SPADCALL (CDR (CDR |l1|)) (QREFELT $ 37))
                                   (SPADCALL (CDR (CDR |l2|)) (QREFELT $ 37))
                                   (QREFELT $ 76))
                         (SPADCALL
                          (SPADCALL (|SPADfirst| |l1|)
                                    (SPADCALL (SPADCALL |l1| (QREFELT $ 38))
                                              (QREFELT $ 51))
                                    (SPADCALL |l2| (QREFELT $ 38))
                                    (QREFELT $ 52))
                          (|SPADfirst| |l2|) (QREFELT $ 76)))
                        (#2='T NIL)))
                      (#2# NIL)))))) 

(SDEFUN |COMBF;product;FSbF;25| ((|x| (F)) (|s| (|SegmentBinding| F)) ($ (F)))
        (SPROG ((|dm| (F)) (|k| (|Kernel| F)))
               (SEQ
                (LETT |k|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 78)) (QREFELT $ 56)))
                (LETT |dm| (SPADCALL (SPADCALL (QREFELT $ 53)) (QREFELT $ 54)))
                (EXIT
                 (SPADCALL (QREFELT $ 19)
                           (LIST (SPADCALL |x| |k| |dm| (QREFELT $ 52)) |dm|
                                 (SPADCALL |k| (QREFELT $ 57))
                                 (SPADCALL (SPADCALL |s| (QREFELT $ 80))
                                           (QREFELT $ 81))
                                 (SPADCALL (SPADCALL |s| (QREFELT $ 80))
                                           (QREFELT $ 82)))
                           (QREFELT $ 26)))))) 

(SDEFUN |COMBF;summation;FSbF;26|
        ((|x| (F)) (|s| (|SegmentBinding| F)) ($ (F)))
        (SPROG ((|dm| (F)) (|k| (|Kernel| F)))
               (SEQ
                (LETT |k|
                      (SPADCALL (SPADCALL |s| (QREFELT $ 78)) (QREFELT $ 56)))
                (LETT |dm| (SPADCALL (SPADCALL (QREFELT $ 53)) (QREFELT $ 54)))
                (EXIT
                 (SPADCALL (QREFELT $ 17)
                           (LIST (SPADCALL |x| |k| |dm| (QREFELT $ 52)) |dm|
                                 (SPADCALL |k| (QREFELT $ 57))
                                 (SPADCALL (SPADCALL |s| (QREFELT $ 80))
                                           (QREFELT $ 81))
                                 (SPADCALL (SPADCALL |s| (QREFELT $ 80))
                                           (QREFELT $ 82)))
                           (QREFELT $ 26)))))) 

(SDEFUN |COMBF;smpfact|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         (|l| (|List| (|Symbol|))) ($ (F)))
        (SPROG NIL
               (SPADCALL (CONS #'|COMBF;smpfact!0| (VECTOR $ |l|)) (ELT $ 85)
                         |p| (QREFELT $ 90)))) 

(SDEFUN |COMBF;smpfact!0| ((|x| NIL) ($$ NIL))
        (PROG (|l| $)
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|COMBF;K2fact| |x| |l| $))))) 

(SDEFUN |COMBF;K2fact| ((|k| (|Kernel| F)) (|l| (|List| (|Symbol|))) ($ (F)))
        (SPROG
         ((|p| (F)) (|n| (F)) (|args| (|List| F)) (#1=#:G824 NIL) (|a| NIL)
          (#2=#:G823 NIL) (#3=#:G822 NIL) (|kf| (F)) (|v| NIL) (#4=#:G821 NIL))
         (SEQ
          (COND
           ((OR
             (NULL
              (PROGN
               (LETT #4# NIL)
               (SEQ (LETT |v| NIL)
                    (LETT #3#
                          (SPADCALL (LETT |kf| (SPADCALL |k| (QREFELT $ 57)))
                                    (QREFELT $ 43)))
                    G190
                    (COND
                     ((OR (ATOM #3#) (PROGN (LETT |v| (CAR #3#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (COND
                       ((SPADCALL |v| |l| (QREFELT $ 65))
                        (LETT #4# (CONS |v| #4#))))))
                    (LETT #3# (CDR #3#)) (GO G190) G191
                    (EXIT (NREVERSE #4#)))))
             (NULL
              (LETT |args|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |a| NIL)
                          (LETT #1# (SPADCALL |k| (QREFELT $ 75))) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2# (CONS (|COMBF;facts| |a| |l| $) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))))
            |kf|)
           ((SPADCALL |k| (QREFELT $ 14) (QREFELT $ 91))
            (SPADCALL (SPADCALL (LETT |n| (|SPADfirst| |args|)) (QREFELT $ 24))
                      (SPADCALL
                       (SPADCALL |n| (SPADCALL |args| (QREFELT $ 38))
                                 (QREFELT $ 40))
                       (QREFELT $ 24))
                      (QREFELT $ 49)))
           ((SPADCALL |k| (QREFELT $ 15) (QREFELT $ 91))
            (SEQ (LETT |n| (|SPADfirst| |args|))
                 (LETT |p| (SPADCALL |args| (QREFELT $ 38)))
                 (EXIT
                  (SPADCALL (SPADCALL |n| (QREFELT $ 24))
                            (SPADCALL (SPADCALL |p| (QREFELT $ 24))
                                      (SPADCALL
                                       (SPADCALL |n| |p| (QREFELT $ 40))
                                       (QREFELT $ 24))
                                      (QREFELT $ 41))
                            (QREFELT $ 49)))))
           ('T
            (SPADCALL (SPADCALL |k| (QREFELT $ 92)) |args| (QREFELT $ 26))))))) 

(SDEFUN |COMBF;operator;2Bo;29|
        ((|op| (|BasicOperator|)) ($ (|BasicOperator|)))
        (COND ((SPADCALL |op| '|factorial| (QREFELT $ 93)) (QREFELT $ 13))
              ((SPADCALL |op| '|permutation| (QREFELT $ 93)) (QREFELT $ 14))
              ((SPADCALL |op| '|binomial| (QREFELT $ 93)) (QREFELT $ 15))
              ((SPADCALL |op| '|summation| (QREFELT $ 93)) (QREFELT $ 16))
              ((SPADCALL |op| '|%defsum| (QREFELT $ 93)) (QREFELT $ 17))
              ((SPADCALL |op| '|product| (QREFELT $ 93)) (QREFELT $ 18))
              ((SPADCALL |op| '|%defprod| (QREFELT $ 93)) (QREFELT $ 19))
              ((SPADCALL |op| '|%power| (QREFELT $ 93)) (QREFELT $ 20))
              ('T (|error| "Not a combinatorial operator")))) 

(SDEFUN |COMBF;iprod| ((|l| (|List| F)) ($ (F)))
        (COND
         ((SPADCALL (|SPADfirst| |l|) (QREFELT $ 95)) (|spadConstant| $ 62))
         ((SPADCALL (|SPADfirst| |l|) (|spadConstant| $ 39) (QREFELT $ 76))
          (|spadConstant| $ 39))
         ('T (SPADCALL (QREFELT $ 18) |l| (QREFELT $ 66))))) 

(SDEFUN |COMBF;isum| ((|l| (|List| F)) ($ (F)))
        (COND
         ((SPADCALL (|SPADfirst| |l|) (QREFELT $ 95)) (|spadConstant| $ 62))
         ('T (SPADCALL (QREFELT $ 16) |l| (QREFELT $ 66))))) 

(SDEFUN |COMBF;idprod| ((|l| (|List| F)) ($ (F)))
        (COND
         ((SPADCALL (SPADCALL (SPADCALL |l| (QREFELT $ 38)) (QREFELT $ 61))
                    (SPADCALL (|SPADfirst| |l|) (QREFELT $ 43)) (QREFELT $ 65))
          (SPADCALL (QREFELT $ 19) |l| (QREFELT $ 66)))
         ('T
          (SPADCALL (|SPADfirst| |l|)
                    (SPADCALL
                     (SPADCALL (|COMBF;fourth| (CDR |l|) $)
                               (|COMBF;fourth| |l| $) (QREFELT $ 40))
                     (|spadConstant| $ 39) (QREFELT $ 67))
                    (QREFELT $ 33))))) 

(SDEFUN |COMBF;idsum| ((|l| (|List| F)) ($ (F)))
        (COND
         ((SPADCALL (SPADCALL (SPADCALL |l| (QREFELT $ 38)) (QREFELT $ 61))
                    (SPADCALL (|SPADfirst| |l|) (QREFELT $ 43)) (QREFELT $ 65))
          (SPADCALL (QREFELT $ 17) |l| (QREFELT $ 66)))
         ('T
          (SPADCALL (|SPADfirst| |l|)
                    (SPADCALL
                     (SPADCALL (|COMBF;fourth| (CDR |l|) $)
                               (|COMBF;fourth| |l| $) (QREFELT $ 40))
                     (|spadConstant| $ 39) (QREFELT $ 67))
                    (QREFELT $ 41))))) 

(SDEFUN |COMBF;ifact| ((|x| (F)) ($ (F)))
        (COND
         ((OR (SPADCALL |x| (QREFELT $ 95))
              (SPADCALL |x| (|spadConstant| $ 39) (QREFELT $ 76)))
          (|spadConstant| $ 39))
         ('T (SPADCALL (QREFELT $ 13) |x| (QREFELT $ 97))))) 

(SDEFUN |COMBF;ibinom| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G850 NIL) (|p| (F)) (|n| (F)))
               (SEQ
                (EXIT
                 (SEQ (LETT |n| (|SPADfirst| |l|))
                      (SEQ (LETT |p| (SPADCALL |l| (QREFELT $ 38)))
                           (EXIT
                            (COND
                             ((OR
                               (SPADCALL |p| (|spadConstant| $ 62)
                                         (QREFELT $ 76))
                               (SPADCALL |p| |n| (QREFELT $ 76)))
                              (PROGN
                               (LETT #1# (|spadConstant| $ 39))
                               (GO #2=#:G848))))))
                      (COND
                       ((OR (SPADCALL |p| (|spadConstant| $ 39) (QREFELT $ 76))
                            (SPADCALL |p|
                                      (SPADCALL |n| (|spadConstant| $ 39)
                                                (QREFELT $ 40))
                                      (QREFELT $ 76)))
                        (EXIT |n|)))
                      (EXIT (SPADCALL (QREFELT $ 15) |l| (QREFELT $ 66)))))
                #2# (EXIT #1#)))) 

(SDEFUN |COMBF;iperm| ((|l| (|List| F)) ($ (F)))
        (COND
         ((SPADCALL (SPADCALL |l| (QREFELT $ 38)) (QREFELT $ 95))
          (|spadConstant| $ 39))
         ('T (SPADCALL (QREFELT $ 14) |l| (QREFELT $ 66))))) 

(SDEFUN |COMBF;iidsum;LF;37| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((#1=#:G863 NIL) (#2=#:G862 (F)) (#3=#:G864 (F)) (#4=#:G868 NIL)
          (|i| NIL) (#5=#:G867 NIL) (|k| (|Union| (|Kernel| F) #6="failed"))
          (|r2| #7=(|Union| (|Integer|) #6#)) (|r1| #7#))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |r1| (SPADCALL (|COMBF;fourth| |l| $) (QREFELT $ 100)))
                 (EXIT
                  (COND
                   ((QEQCAR |r1| 1)
                    (PROGN (LETT #5# (|COMBF;idsum| |l| $)) (GO #8=#:G865)))
                   (#9='T
                    (SEQ
                     (LETT |r2|
                           (SPADCALL (|COMBF;fourth| (CDR |l|) $)
                                     (QREFELT $ 100)))
                     (EXIT
                      (COND
                       ((QEQCAR |r2| 1)
                        (PROGN (LETT #5# (|COMBF;idsum| |l| $)) (GO #8#)))
                       (#9#
                        (SEQ
                         (LETT |k|
                               (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                                         (QREFELT $ 102)))
                         (EXIT
                          (COND
                           ((QEQCAR |k| 1)
                            (PROGN
                             (LETT #5# (|COMBF;idsum| |l| $))
                             (GO #8#))))))))))))))
            (EXIT
             (PROGN
              (LETT #1# NIL)
              (SEQ (LETT |i| (QCDR |r1|)) (LETT #4# (QCDR |r2|)) G190
                   (COND ((> |i| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (PROGN
                      (LETT #3#
                            (SPADCALL (|SPADfirst| |l|) (QCDR |k|)
                                      (SPADCALL |i| (QREFELT $ 103))
                                      (QREFELT $ 52)))
                      (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 67))))
                            ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (COND (#1# #2#) (#9# (|spadConstant| $ 62)))))))
          #8# (EXIT #5#)))) 

(SDEFUN |COMBF;iidprod;LF;38| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((#1=#:G879 NIL) (#2=#:G878 (F)) (#3=#:G880 (F)) (#4=#:G884 NIL)
          (|i| NIL) (#5=#:G883 NIL) (|k| (|Union| (|Kernel| F) #6="failed"))
          (|r2| #7=(|Union| (|Integer|) #6#)) (|r1| #7#))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |r1| (SPADCALL (|COMBF;fourth| |l| $) (QREFELT $ 100)))
                 (EXIT
                  (COND
                   ((QEQCAR |r1| 1)
                    (PROGN (LETT #5# (|COMBF;idprod| |l| $)) (GO #8=#:G881)))
                   (#9='T
                    (SEQ
                     (LETT |r2|
                           (SPADCALL (|COMBF;fourth| (CDR |l|) $)
                                     (QREFELT $ 100)))
                     (EXIT
                      (COND
                       ((QEQCAR |r2| 1)
                        (PROGN (LETT #5# (|COMBF;idprod| |l| $)) (GO #8#)))
                       (#9#
                        (SEQ
                         (LETT |k|
                               (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                                         (QREFELT $ 102)))
                         (EXIT
                          (COND
                           ((QEQCAR |k| 1)
                            (PROGN
                             (LETT #5# (|COMBF;idprod| |l| $))
                             (GO #8#))))))))))))))
            (EXIT
             (PROGN
              (LETT #1# NIL)
              (SEQ (LETT |i| (QCDR |r1|)) (LETT #4# (QCDR |r2|)) G190
                   (COND ((> |i| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (PROGN
                      (LETT #3#
                            (SPADCALL (|SPADfirst| |l|) (QCDR |k|)
                                      (SPADCALL |i| (QREFELT $ 103))
                                      (QREFELT $ 52)))
                      (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 41))))
                            ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (COND (#1# #2#) (#9# (|spadConstant| $ 39)))))))
          #8# (EXIT #5#)))) 

(SDEFUN |COMBF;iiipow| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|r| (|Union| (|Fraction| (|Integer|)) "failed")) (|y| (F))
          (|rec|
           (|Record| (|:| |var| (|Kernel| F)) (|:| |exponent| (|Integer|))))
          (|u|
           (|Union|
            (|Record| (|:| |var| (|Kernel| F)) (|:| |exponent| (|Integer|)))
            "failed"))
          (|x| (F)))
         (SEQ
          (LETT |u|
                (SPADCALL (LETT |x| (|SPADfirst| |l|)) '|exp| (QREFELT $ 108)))
          (EXIT
           (COND ((QEQCAR |u| 1) (SPADCALL (QREFELT $ 20) |l| (QREFELT $ 66)))
                 (#1='T
                  (SEQ (LETT |rec| (QCDR |u|))
                       (LETT |y|
                             (|SPADfirst|
                              (SPADCALL (QCAR |rec|) (QREFELT $ 75))))
                       (LETT |r| (SPADCALL |y| (QREFELT $ 32)))
                       (EXIT
                        (COND
                         ((QEQCAR |r| 1)
                          (SPADCALL (QREFELT $ 20) |l| (QREFELT $ 66)))
                         (#1#
                          (SPADCALL (SPADCALL (QCAR |rec|) (QREFELT $ 92))
                                    (SPADCALL
                                     (SPADCALL (QCDR |rec|) |y|
                                               (QREFELT $ 109))
                                     (SPADCALL |l| (QREFELT $ 38))
                                     (QREFELT $ 41))
                                    (QREFELT $ 23)))))))))))) 

(SDEFUN |COMBF;ipow;LF;40| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|r| (|Union| (|Fraction| (|Integer|)) "failed")))
               (SEQ
                (LETT |r|
                      (SPADCALL (SPADCALL |l| (QREFELT $ 38)) (QREFELT $ 32)))
                (EXIT
                 (COND ((QEQCAR |r| 1) (|COMBF;iiipow| |l| $))
                       ('T
                        (SPADCALL (|SPADfirst| |l|) (QCDR |r|)
                                  (QREFELT $ 111)))))))) 

(SDEFUN |COMBF;ipow;LF;41| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|r| (|Union| (|Integer|) "failed")))
               (SEQ
                (LETT |r|
                      (SPADCALL (SPADCALL |l| (QREFELT $ 38)) (QREFELT $ 100)))
                (EXIT
                 (COND ((QEQCAR |r| 1) (|COMBF;iiipow| |l| $))
                       ('T
                        (SPADCALL (|SPADfirst| |l|) (QCDR |r|)
                                  (QREFELT $ 113)))))))) 

(SDEFUN |COMBF;ipow;LF;42| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((#1=#:G918 NIL) (|y| (F))
          (|rec|
           (|Record| (|:| |var| (|Kernel| F)) (|:| |exponent| (|Integer|))))
          (|u|
           (|Union|
            (|Record| (|:| |var| (|Kernel| F)) (|:| |exponent| (|Integer|)))
            "failed"))
          (|n| (F)) (|x| (F)))
         (SEQ
          (COND
           ((SPADCALL (LETT |x| (|SPADfirst| |l|)) (QREFELT $ 95))
            (COND
             ((SPADCALL (SPADCALL |l| (QREFELT $ 38)) (QREFELT $ 95))
              (|error| "0 ^ 0"))
             (#2='T (|spadConstant| $ 62))))
           ((OR (SPADCALL |x| (|spadConstant| $ 39) (QREFELT $ 76))
                (SPADCALL (LETT |n| (SPADCALL |l| (QREFELT $ 38)))
                          (QREFELT $ 95)))
            (|spadConstant| $ 39))
           ('T
            (COND ((SPADCALL |n| (|spadConstant| $ 39) (QREFELT $ 76)) |x|)
                  (#2#
                   (SEQ (LETT |u| (SPADCALL |x| '|exp| (QREFELT $ 108)))
                        (EXIT
                         (COND
                          ((QEQCAR |u| 1)
                           (SPADCALL (QREFELT $ 20) |l| (QREFELT $ 66)))
                          (#2#
                           (SEQ
                            (EXIT
                             (SEQ (LETT |rec| (QCDR |u|))
                                  (SEQ
                                   (LETT |y|
                                         (|SPADfirst|
                                          (SPADCALL (QCAR |rec|)
                                                    (QREFELT $ 75))))
                                   (EXIT
                                    (COND
                                     ((OR
                                       (SPADCALL |y| (|spadConstant| $ 39)
                                                 (QREFELT $ 76))
                                       (SPADCALL |y|
                                                 (SPADCALL
                                                  (|spadConstant| $ 39)
                                                  (QREFELT $ 114))
                                                 (QREFELT $ 76)))
                                      (PROGN
                                       (LETT #1#
                                             (SPADCALL
                                              (SPADCALL (QCAR |rec|)
                                                        (QREFELT $ 92))
                                              (SPADCALL
                                               (SPADCALL (QCDR |rec|) |y|
                                                         (QREFELT $ 109))
                                               |n| (QREFELT $ 41))
                                              (QREFELT $ 23)))
                                       (GO #3=#:G913))))))
                                  (EXIT
                                   (SPADCALL (QREFELT $ 20) |l|
                                             (QREFELT $ 66)))))
                            #3# (EXIT #1#))))))))))))) 

(SDEFUN |COMBF;iifact;2F;43| ((|x| (F)) ($ (F)))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 116)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (|COMBF;ifact| |x| $))
                           ('T
                            (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 117))
                                      (QREFELT $ 85)))))))) 

(SDEFUN |COMBF;iiperm;LF;44| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G931 NIL) (|r2| #2=(|Union| R "failed")) (|r1| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r1| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 116)))
                       (EXIT
                        (COND
                         ((QEQCAR |r1| 1)
                          (PROGN
                           (LETT #1# (|COMBF;iperm| |l| $))
                           (GO #3=#:G929)))
                         ('T
                          (SEQ
                           (LETT |r2|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                                           (QREFELT $ 116)))
                           (EXIT
                            (COND
                             ((QEQCAR |r2| 1)
                              (PROGN
                               (LETT #1# (|COMBF;iperm| |l| $))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |r1|) (QCDR |r2|) (QREFELT $ 119))
                             (QREFELT $ 85)))))
                #3# (EXIT #1#)))) 

(SDEFUN |COMBF;iibinom;LF;45| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((#1=#:G952 NIL) (|r2| #2=(|Union| R #3="failed")) (|r1| #2#)
          (|ans| (F)) (#4=#:G954 NIL) (|i| NIL) (|t| (|Union| (|Integer|) #3#))
          (|s| #2#) (#5=#:G953 NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (LETT |s|
                   (SPADCALL (SPADCALL |l| (QREFELT $ 38)) (QREFELT $ 116)))
             (EXIT
              (COND
               ((QEQCAR |s| 0)
                (SEQ (LETT |t| (SPADCALL (QCDR |s|) (QREFELT $ 121)))
                     (EXIT
                      (COND
                       ((QEQCAR |t| 0)
                        (COND
                         ((> (QCDR |t|) 0)
                          (PROGN
                           (LETT #1#
                                 (SEQ (LETT |ans| (|spadConstant| $ 39))
                                      (SEQ (LETT |i| 0)
                                           (LETT #5# (- (QCDR |t|) 1)) G190
                                           (COND
                                            ((|greater_SI| |i| #5#) (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT |ans|
                                                   (SPADCALL |ans|
                                                             (SPADCALL
                                                              (|SPADfirst| |l|)
                                                              (SPADCALL
                                                               (SPADCALL |i|
                                                                         (QREFELT
                                                                          $
                                                                          122))
                                                               (QREFELT $ 85))
                                                              (QREFELT $ 40))
                                                             (QREFELT $ 41)))))
                                           (LETT |i| (|inc_SI| |i|)) (GO G190)
                                           G191 (EXIT NIL))
                                      (EXIT
                                       (SPADCALL
                                        (SPADCALL 1
                                                  (SPADCALL (QCDR |t|)
                                                            (QREFELT $ 123))
                                                  (QREFELT $ 124))
                                        |ans| (QREFELT $ 125)))))
                           (GO #6=#:G950))))))))))))
            (SEQ
             (LETT |s|
                   (SPADCALL
                    (SPADCALL (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 38))
                              (QREFELT $ 40))
                    (QREFELT $ 116)))
             (EXIT
              (COND
               ((QEQCAR |s| 0)
                (SEQ (LETT |t| (SPADCALL (QCDR |s|) (QREFELT $ 121)))
                     (EXIT
                      (COND
                       ((QEQCAR |t| 0)
                        (COND
                         ((> (QCDR |t|) 0)
                          (PROGN
                           (LETT #1#
                                 (SEQ (LETT |ans| (|spadConstant| $ 39))
                                      (SEQ (LETT |i| 1) (LETT #4# (QCDR |t|))
                                           G190
                                           (COND
                                            ((|greater_SI| |i| #4#) (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT |ans|
                                                   (SPADCALL |ans|
                                                             (SPADCALL
                                                              (SPADCALL |l|
                                                                        (QREFELT
                                                                         $ 38))
                                                              (SPADCALL
                                                               (SPADCALL |i|
                                                                         (QREFELT
                                                                          $
                                                                          122))
                                                               (QREFELT $ 85))
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 41)))))
                                           (LETT |i| (|inc_SI| |i|)) (GO G190)
                                           G191 (EXIT NIL))
                                      (EXIT
                                       (SPADCALL
                                        (SPADCALL 1
                                                  (SPADCALL (QCDR |t|)
                                                            (QREFELT $ 123))
                                                  (QREFELT $ 124))
                                        |ans| (QREFELT $ 125)))))
                           (GO #6#))))))))))))
            (SEQ (LETT |r1| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 116)))
                 (EXIT
                  (COND
                   ((QEQCAR |r1| 1)
                    (PROGN (LETT #1# (|COMBF;ibinom| |l| $)) (GO #6#)))
                   ('T
                    (SEQ
                     (LETT |r2|
                           (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                                     (QREFELT $ 116)))
                     (EXIT
                      (COND
                       ((QEQCAR |r2| 1)
                        (PROGN
                         (LETT #1# (|COMBF;ibinom| |l| $))
                         (GO #6#))))))))))
            (EXIT
             (SPADCALL (SPADCALL (QCDR |r1|) (QCDR |r2|) (QREFELT $ 126))
                       (QREFELT $ 85)))))
          #6# (EXIT #1#)))) 

(SDEFUN |COMBF;iibinom;LF;46| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G962 NIL) (|r2| #2=(|Union| R "failed")) (|r1| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r1| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 116)))
                       (EXIT
                        (COND
                         ((QEQCAR |r1| 1)
                          (PROGN
                           (LETT #1# (|COMBF;ibinom| |l| $))
                           (GO #3=#:G960)))
                         ('T
                          (SEQ
                           (LETT |r2|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                                           (QREFELT $ 116)))
                           (EXIT
                            (COND
                             ((QEQCAR |r2| 1)
                              (PROGN
                               (LETT #1# (|COMBF;ibinom| |l| $))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |r1|) (QCDR |r2|) (QREFELT $ 126))
                             (QREFELT $ 85)))))
                #3# (EXIT #1#)))) 

(SDEFUN |COMBF;iibinom;LF;47| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G970 NIL) (|r2| #2=(|Union| R "failed")) (|r1| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r1| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 116)))
                       (EXIT
                        (COND
                         ((QEQCAR |r1| 1)
                          (PROGN
                           (LETT #1# (|COMBF;ibinom| |l| $))
                           (GO #3=#:G968)))
                         ('T
                          (SEQ
                           (LETT |r2|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                                           (QREFELT $ 116)))
                           (EXIT
                            (COND
                             ((QEQCAR |r2| 1)
                              (PROGN
                               (LETT #1# (|COMBF;ibinom| |l| $))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |r1|) (QCDR |r2|) (QREFELT $ 126))
                             (QREFELT $ 85)))))
                #3# (EXIT #1#)))) 

(SDEFUN |COMBF;iifact;2F;48| ((|x| (F)) ($ (F))) (|COMBF;ifact| |x| $)) 

(SDEFUN |COMBF;iibinom;LF;49| ((|l| (|List| F)) ($ (F))) (|COMBF;ibinom| |l| $)) 

(SDEFUN |COMBF;iiperm;LF;50| ((|l| (|List| F)) ($ (F))) (|COMBF;iperm| |l| $)) 

(SDEFUN |COMBF;iipow;LF;51| ((|l| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G981 NIL) (|r2| #2=(|Union| R "failed")) (|r1| #2#))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |r1| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 116)))
                       (EXIT
                        (COND
                         ((QEQCAR |r1| 1)
                          (PROGN
                           (LETT #1# (SPADCALL |l| (QREFELT $ 112)))
                           (GO #3=#:G979)))
                         ('T
                          (SEQ
                           (LETT |r2|
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 38))
                                           (QREFELT $ 116)))
                           (EXIT
                            (COND
                             ((QEQCAR |r2| 1)
                              (PROGN
                               (LETT #1# (SPADCALL |l| (QREFELT $ 112)))
                               (GO #3#))))))))))
                  (EXIT
                   (SPADCALL (SPADCALL (QCDR |r1|) (QCDR |r2|) (QREFELT $ 128))
                             (QREFELT $ 85)))))
                #3# (EXIT #1#)))) 

(SDEFUN |COMBF;iipow;LF;52| ((|l| (|List| F)) ($ (F)))
        (SPADCALL |l| (QREFELT $ 112))) 

(SDEFUN |COMBF;dvpow2| ((|l| (|List| F)) ($ (F)))
        (COND
         ((SPADCALL (|SPADfirst| |l|) (QREFELT $ 95)) (|spadConstant| $ 62))
         ('T
          (SPADCALL (SPADCALL (|SPADfirst| |l|) (QREFELT $ 130))
                    (SPADCALL (|SPADfirst| |l|) (SPADCALL |l| (QREFELT $ 38))
                              (QREFELT $ 33))
                    (QREFELT $ 41))))) 

(DECLAIM (NOTINLINE |CombinatorialFunction;|)) 

(DEFUN |CombinatorialFunction| (&REST #1=#:G1036)
  (SPROG NIL
         (PROG (#2=#:G1037)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|CombinatorialFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |CombinatorialFunction;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|CombinatorialFunction|)))))))))) 

(DEFUN |CombinatorialFunction;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|CombinatorialFunction| DV$1 DV$2))
          (LETT $ (GETREFV 140))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CombinatorialFunction|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|comb|)
          (QSETREFV $ 13 (SPADCALL '|factorial| (QREFELT $ 12)))
          (QSETREFV $ 14 (SPADCALL '|permutation| (QREFELT $ 12)))
          (QSETREFV $ 15 (SPADCALL '|binomial| (QREFELT $ 12)))
          (QSETREFV $ 16 (SPADCALL '|summation| (QREFELT $ 12)))
          (QSETREFV $ 17 (SPADCALL '|%defsum| (QREFELT $ 12)))
          (QSETREFV $ 18 (SPADCALL '|product| (QREFELT $ 12)))
          (QSETREFV $ 19 (SPADCALL '|%defprod| (QREFELT $ 12)))
          (QSETREFV $ 20 (SPADCALL '|%power| (QREFELT $ 12)))
          (QSETREFV $ 22
                    (SPADCALL (SPADCALL '|%diff| (QREFELT $ 12))
                              (QREFELT $ 21)))
          (COND
           ((|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
            (PROGN
             (QSETREFV $ 104
                       (CONS (|dispatchFunction| |COMBF;iidsum;LF;37|) $))
             (QSETREFV $ 105
                       (CONS (|dispatchFunction| |COMBF;iidprod;LF;38|) $))
             (COND
              ((|HasCategory| |#2| '(|RadicalCategory|))
               (QSETREFV $ 112
                         (CONS (|dispatchFunction| |COMBF;ipow;LF;40|) $)))
              ('T
               (QSETREFV $ 112
                         (CONS (|dispatchFunction| |COMBF;ipow;LF;41|) $))))))
           ('T
            (QSETREFV $ 112 (CONS (|dispatchFunction| |COMBF;ipow;LF;42|) $))))
          (COND
           ((|HasCategory| |#1| '(|CombinatorialFunctionCategory|))
            (PROGN
             (QSETREFV $ 118
                       (CONS (|dispatchFunction| |COMBF;iifact;2F;43|) $))
             (QSETREFV $ 120
                       (CONS (|dispatchFunction| |COMBF;iiperm;LF;44|) $))
             (COND
              ((|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
               (COND
                ((|HasCategory| |#2| '(|Algebra| (|Fraction| (|Integer|))))
                 (QSETREFV $ 127
                           (CONS (|dispatchFunction| |COMBF;iibinom;LF;45|)
                                 $)))
                ('T
                 (QSETREFV $ 127
                           (CONS (|dispatchFunction| |COMBF;iibinom;LF;46|)
                                 $)))))
              ('T
               (QSETREFV $ 127
                         (CONS (|dispatchFunction| |COMBF;iibinom;LF;47|)
                               $))))))
           ('T
            (PROGN
             (QSETREFV $ 118
                       (CONS (|dispatchFunction| |COMBF;iifact;2F;48|) $))
             (QSETREFV $ 127
                       (CONS (|dispatchFunction| |COMBF;iibinom;LF;49|) $))
             (QSETREFV $ 120
                       (CONS (|dispatchFunction| |COMBF;iiperm;LF;50|) $)))))
          (COND
           ((|HasCategory| |#1| '(|ElementaryFunctionCategory|))
            (QSETREFV $ 129 (CONS (|dispatchFunction| |COMBF;iipow;LF;51|) $)))
           ('T
            (QSETREFV $ 129
                      (CONS (|dispatchFunction| |COMBF;iipow;LF;52|) $))))
          (SPADCALL (QREFELT $ 13) (ELT $ 118) (QREFELT $ 133))
          (SPADCALL (QREFELT $ 20) (ELT $ 129) (QREFELT $ 135))
          (SPADCALL (QREFELT $ 14) (ELT $ 120) (QREFELT $ 135))
          (SPADCALL (QREFELT $ 15) (ELT $ 127) (QREFELT $ 135))
          (SPADCALL (QREFELT $ 16) (CONS (|function| |COMBF;isum|) $)
                    (QREFELT $ 135))
          (SPADCALL (QREFELT $ 17) (ELT $ 104) (QREFELT $ 135))
          (SPADCALL (QREFELT $ 18) (CONS (|function| |COMBF;iprod|) $)
                    (QREFELT $ 135))
          (SPADCALL (QREFELT $ 19) (ELT $ 105) (QREFELT $ 135))
          (SPADCALL (QREFELT $ 20)
                    (LIST (CONS (|function| |COMBF;dvpow1|) $)
                          (CONS (|function| |COMBF;dvpow2|) $))
                    (QREFELT $ 137))
          (SPADCALL (QREFELT $ 16) '|%specialDiff|
                    (CONS (|function| |COMBF;dvsum|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 17) '|%specialDiff|
                    (CONS (|function| |COMBF;dvdsum|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 18) '|%specialDiff|
                    (CONS (|function| |COMBF;dvprod|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 19) '|%specialDiff|
                    (CONS (|function| |COMBF;dvdprod|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 16) '|%specialDisp|
                    (CONS (|function| |COMBF;dsum|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 17) '|%specialDisp|
                    (CONS (|function| |COMBF;ddsum|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 18) '|%specialDisp|
                    (CONS (|function| |COMBF;dprod|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 19) '|%specialDisp|
                    (CONS (|function| |COMBF;ddprod|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 16) '|%specialEqual|
                    (CONS (|function| |COMBF;equalsumprod|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 17) '|%specialEqual|
                    (CONS (|function| |COMBF;equaldsumprod|) $)
                    (QREFELT $ 139))
          (SPADCALL (QREFELT $ 18) '|%specialEqual|
                    (CONS (|function| |COMBF;equalsumprod|) $) (QREFELT $ 139))
          (SPADCALL (QREFELT $ 19) '|%specialEqual|
                    (CONS (|function| |COMBF;equaldsumprod|) $)
                    (QREFELT $ 139))
          $))) 

(MAKEPROP '|CombinatorialFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'COMB
              (|BasicOperator|) (|Symbol|) (|CommonOperators|) (0 . |operator|)
              '|opfact| '|opperm| '|opbinom| '|opsum| '|opdsum| '|opprod|
              '|opdprod| '|oppow| (5 . |operator|) '|opdiff| (10 . |elt|)
              |COMBF;factorial;2F;1| (|List| $) (16 . |elt|)
              |COMBF;binomial;3F;2| |COMBF;permutation;3F;3| (|Boolean|)
              (22 . |ground?|) (|Union| 110 '#1="failed") (27 . |retractIfCan|)
              |COMBF;^;3F;5| (32 . |has?|) |COMBF;belong?;BoB;6| (|List| 7)
              (38 . |third|) (43 . |second|) (48 . |One|) (52 . -) (58 . *)
              (|List| 10) (64 . |variables|) |COMBF;factorials;2F;9|
              |COMBF;factorials;FSF;10| (|SparseMultivariatePolynomial| 6 50)
              (69 . |numer|) (74 . |denom|) (79 . /) (|Kernel| $)
              (85 . |retract|) (90 . |eval|) (97 . |new|) (101 . |coerce|)
              (|Kernel| 7) (106 . |kernel|) (111 . |coerce|)
              |COMBF;product;FSF;13| |COMBF;summation;FSF;14|
              (116 . |differentiate|) (122 . |retract|) (127 . |Zero|)
              (|Integer|) (131 . |elt|) (137 . |member?|) (143 . |kernel|)
              (149 . +) (|OutputForm|) (155 . |coerce|) (160 . |prod|)
              (166 . =) (172 . |prod|) (179 . |sum|) (185 . |sum|)
              (192 . |argument|) (197 . =) (|SegmentBinding| 7)
              (203 . |variable|) (|Segment| 7) (208 . |segment|) (213 . |low|)
              (218 . |high|) |COMBF;product;FSbF;25| |COMBF;summation;FSbF;26|
              (223 . |coerce|) (|Mapping| 7 55) (|Mapping| 7 6)
              (|SparseMultivariatePolynomial| 6 55)
              (|PolynomialCategoryLifting| (|IndexedExponents| 55) 55 6 88 7)
              (228 . |map|) (235 . |is?|) (241 . |operator|) (246 . |is?|)
              |COMBF;operator;2Bo;29| (252 . |zero?|) (257 . |One|)
              (261 . |kernel|) (267 . |Zero|) (|Union| 63 '#1#)
              (271 . |retractIfCan|) (|Union| 50 '#1#) (276 . |retractIfCan|)
              (281 . |coerce|) (286 . |iidsum|) (291 . |iidprod|)
              (|Record| (|:| |var| 50) (|:| |exponent| 63))
              (|Union| 106 '"failed") (296 . |isExpt|) (302 . *)
              (|Fraction| 63) (308 . ^) (314 . |ipow|) (319 . ^) (325 . -)
              (|Union| 6 '#1#) (330 . |retractIfCan|) (335 . |factorial|)
              (340 . |iifact|) (345 . |permutation|) (351 . |iiperm|)
              (356 . |retractIfCan|) (361 . |coerce|) (366 . |factorial|)
              (371 . /) (377 . *) (383 . |binomial|) (389 . |iibinom|)
              (394 . ^) (400 . |iipow|) (405 . |log|) (|Mapping| 7 7)
              (|BasicOperatorFunctions1| 7) (410 . |evaluate|) (|Mapping| 7 36)
              (416 . |evaluate|) (|List| 134) (422 . |derivative|) (|None|)
              (428 . |setProperty|))
           '#(|summation| 435 |product| 447 |permutation| 459 |operator| 465
              |ipow| 470 |iipow| 475 |iiperm| 480 |iifact| 485 |iidsum| 490
              |iidprod| 495 |iibinom| 500 |factorials| 505 |factorial| 516
              |binomial| 521 |belong?| 527 ^ 532)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|belong?| ((|Boolean|) (|BasicOperator|))) T)
                              '((|operator|
                                 ((|BasicOperator|) (|BasicOperator|)))
                                T)
                              '((^ (|#2| |#2| |#2|)) T)
                              '((|binomial| (|#2| |#2| |#2|)) T)
                              '((|permutation| (|#2| |#2| |#2|)) T)
                              '((|factorial| (|#2| |#2|)) T)
                              '((|factorials| (|#2| |#2|)) T)
                              '((|factorials| (|#2| |#2| (|Symbol|))) T)
                              '((|summation| (|#2| |#2| (|Symbol|))) T)
                              '((|summation|
                                 (|#2| |#2| (|SegmentBinding| |#2|)))
                                T)
                              '((|product| (|#2| |#2| (|Symbol|))) T)
                              '((|product| (|#2| |#2| (|SegmentBinding| |#2|)))
                                T)
                              '((|iifact| (|#2| |#2|)) T)
                              '((|iibinom| (|#2| (|List| |#2|))) T)
                              '((|iiperm| (|#2| (|List| |#2|))) T)
                              '((|iipow| (|#2| (|List| |#2|))) T)
                              '((|iidsum| (|#2| (|List| |#2|))) T)
                              '((|iidprod| (|#2| (|List| |#2|))) T)
                              '((|ipow| (|#2| (|List| |#2|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 139
                                            '(1 11 9 10 12 1 7 9 9 21 2 7 0 9 0
                                              23 2 7 0 9 25 26 1 7 29 0 30 1 7
                                              31 0 32 2 9 29 0 10 34 1 36 7 0
                                              37 1 36 7 0 38 0 7 0 39 2 7 0 0 0
                                              40 2 7 0 0 0 41 1 7 42 0 43 1 7
                                              46 0 47 1 7 46 0 48 2 7 0 0 0 49
                                              1 7 50 0 51 3 7 0 0 50 0 52 0 10
                                              0 53 1 7 0 10 54 1 55 0 10 56 1 7
                                              0 50 57 2 7 0 0 10 60 1 7 10 0 61
                                              0 7 0 62 2 36 7 0 63 64 2 42 29
                                              10 0 65 2 7 0 9 25 66 2 7 0 0 0
                                              67 1 7 68 0 69 2 68 0 0 0 70 2 68
                                              0 0 0 71 3 68 0 0 0 0 72 2 68 0 0
                                              0 73 3 68 0 0 0 0 74 1 55 36 0 75
                                              2 7 29 0 0 76 1 77 10 0 78 1 77
                                              79 0 80 1 79 7 0 81 1 79 7 0 82 1
                                              7 0 6 85 3 89 7 86 87 88 90 2 55
                                              29 0 9 91 1 55 9 0 92 2 9 29 0 10
                                              93 1 7 29 0 95 0 6 0 96 2 7 0 9 0
                                              97 0 6 0 98 1 7 99 0 100 1 7 101
                                              0 102 1 7 0 63 103 1 0 7 36 104 1
                                              0 7 36 105 2 7 107 0 10 108 2 7 0
                                              63 0 109 2 7 0 0 110 111 1 0 7 36
                                              112 2 7 0 0 63 113 1 7 0 0 114 1
                                              7 115 0 116 1 6 0 0 117 1 0 7 7
                                              118 2 6 0 0 0 119 1 0 7 36 120 1
                                              6 99 0 121 1 6 0 63 122 1 63 0 0
                                              123 2 110 0 63 63 124 2 7 0 110 0
                                              125 2 6 0 0 0 126 1 0 7 36 127 2
                                              6 0 0 0 128 1 0 7 36 129 1 7 0 0
                                              130 2 132 9 9 131 133 2 132 9 9
                                              134 135 2 132 9 9 136 137 3 9 0 0
                                              10 138 139 2 0 7 7 10 59 2 0 7 7
                                              77 84 2 0 7 7 10 58 2 0 7 7 77 83
                                              2 0 7 7 7 28 1 0 9 9 94 1 0 7 36
                                              112 1 0 7 36 129 1 0 7 36 120 1 0
                                              7 7 118 1 0 7 36 104 1 0 7 36 105
                                              1 0 7 36 127 1 0 7 7 44 2 0 7 7
                                              10 45 1 0 7 7 24 2 0 7 7 7 27 1 0
                                              29 9 35 2 0 7 7 7 33)))))
           '|lookupComplete|)) 

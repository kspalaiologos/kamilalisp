
(SDEFUN |FMT2D;coerce;$Of;1| ((|x| ($)) ($ (|OutputForm|)))
        (|coerceRe2E| |x|
                      (ELT
                       (|Record| (|:| |prolog| (|OutputBox|))
                                 (|:| |fmt| (|OutputBox|))
                                 (|:| |epilog| (|OutputBox|)))
                       0))) 

(SDEFUN |FMT2D;defaultPrologue;SOb;2| ((|label| (|String|)) ($ (|OutputBox|)))
        (SPADCALL (QREFELT $ 9))) 

(SDEFUN |FMT2D;defaultEpilogue;SOb;3| ((|label| (|String|)) ($ (|OutputBox|)))
        (SPADCALL (QREFELT $ 9))) 

(SDEFUN |FMT2D;formatFloat;SOb;4| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL (SPADCALL (|STR_to_CHAR| "_") |s| (QREFELT $ 15))
                  (QREFELT $ 16))) 

(SDEFUN |FMT2D;formatString;SOb;5| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL |s| (QREFELT $ 16))) 

(SDEFUN |FMT2D;formatSymbol;SOb;6| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL |s| (QREFELT $ 16))) 

(SDEFUN |FMT2D;formatFunctionSymbol;SOb;7| ((|s| (|String|)) ($ (|OutputBox|)))
        (SPADCALL |s| (QREFELT $ 16))) 

(SDEFUN |FMT2D;parenthesize;2S2Ob;8|
        ((|left| #1=(|String|)) (|right| #1#) (|b| (|OutputBox|))
         ($ (|OutputBox|)))
        (SPROG
         ((|bxr| #2=(|OutputBox|)) (#3=#:G740 NIL) (|i| NIL) (#4=#:G739 NIL)
          (|bxl| #2#) (#5=#:G738 NIL) (#6=#:G737 NIL) (|br| #7=(|OutputBox|))
          (|bl| #7#) (|t| (|NonNegativeInteger|)) (|h| (|NonNegativeInteger|)))
         (SEQ (LETT |h| (SPADCALL |b| (QREFELT $ 22)))
              (LETT |t| (+ |h| (SPADCALL |b| (QREFELT $ 23))))
              (LETT |bl| (SPADCALL |left| (QREFELT $ 16)))
              (LETT |br| (SPADCALL |right| (QREFELT $ 16)))
              (LETT |bxl|
                    (SPADCALL
                     (PROGN
                      (LETT #6# NIL)
                      (SEQ (LETT |i| 1) (LETT #5# |t|) G190
                           (COND ((|greater_SI| |i| #5#) (GO G191)))
                           (SEQ (EXIT (LETT #6# (CONS |bl| #6#))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                           (EXIT (NREVERSE #6#))))
                     |h| (QREFELT $ 25)))
              (LETT |bxr|
                    (SPADCALL
                     (PROGN
                      (LETT #4# NIL)
                      (SEQ (LETT |i| 1) (LETT #3# |t|) G190
                           (COND ((|greater_SI| |i| #3#) (GO G191)))
                           (SEQ (EXIT (LETT #4# (CONS |br| #4#))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                           (EXIT (NREVERSE #4#))))
                     |h| (QREFELT $ 25)))
              (EXIT (SPADCALL (LIST |bxl| |b| |bxr|) (QREFELT $ 26)))))) 

(SDEFUN |FMT2D;fbox| ((|bx| (|OutputBox|)) ($ (|OutputBox|)))
        (SPROG
         ((|bar| #1=(|OutputBox|)) (|r| #1#) (#2=#:G754 NIL) (|i| NIL)
          (#3=#:G753 NIL) (|l| #1#) (#4=#:G752 NIL) (#5=#:G751 NIL)
          (|w| (|NonNegativeInteger|)) (|d| (|NonNegativeInteger|))
          (|h| (|NonNegativeInteger|)))
         (SEQ (LETT |h| (SPADCALL |bx| (QREFELT $ 22)))
              (LETT |d| (SPADCALL |bx| (QREFELT $ 23)))
              (LETT |w| (SPADCALL |bx| (QREFELT $ 28)))
              (LETT |l| (SPADCALL "| " (QREFELT $ 16)))
              (LETT |l|
                    (SPADCALL
                     (PROGN
                      (LETT #5# NIL)
                      (SEQ (LETT |i| 1) (LETT #4# (+ |h| |d|)) G190
                           (COND ((|greater_SI| |i| #4#) (GO G191)))
                           (SEQ (EXIT (LETT #5# (CONS |l| #5#))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                           (EXIT (NREVERSE #5#))))
                     |h| (QREFELT $ 25)))
              (LETT |r| (SPADCALL " |" (QREFELT $ 16)))
              (LETT |r|
                    (SPADCALL
                     (PROGN
                      (LETT #3# NIL)
                      (SEQ (LETT |i| 1) (LETT #2# (+ |h| |d|)) G190
                           (COND ((|greater_SI| |i| #2#) (GO G191)))
                           (SEQ (EXIT (LETT #3# (CONS |r| #3#))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                           (EXIT (NREVERSE #3#))))
                     |h| (QREFELT $ 25)))
              (LETT |bar|
                    (SPADCALL
                     (SPADCALL
                      (LIST "+-" (|make_full_CVEC2| |w| (|STR_to_CHAR| "-"))
                            "-+")
                      (QREFELT $ 29))
                     (QREFELT $ 16)))
              (EXIT
               (SPADCALL
                (LIST |bar| (SPADCALL (LIST |l| |bx| |r|) (QREFELT $ 26))
                      |bar|)
                (+ |h| 1) (QREFELT $ 25)))))) 

(SDEFUN |FMT2D;integralArgument| ((|a| (|OutputForm|)) ($ (|OutputForm|)))
        (SPROG
         ((|op3| (|OutputForm|)) (|op2| #1=(|OutputForm|))
          (|args| (|List| (|OutputForm|))) (|op| #1#))
         (SEQ
          (COND ((SPADCALL |a| (QREFELT $ 32)) |a|)
                (#2='T
                 (SEQ (LETT |op| (SPADCALL |a| (QREFELT $ 33)))
                      (COND
                       ((NULL (SPADCALL |op| '* (QREFELT $ 35))) (EXIT |a|)))
                      (LETT |args| (SPADCALL |a| (QREFELT $ 37)))
                      (EXIT
                       (COND ((SPADCALL (LENGTH |args|) 2 (QREFELT $ 38)) |a|)
                             (#2#
                              (SEQ
                               (LETT |op2|
                                     (SPADCALL
                                      (SPADCALL |args| 2 (QREFELT $ 40))
                                      (QREFELT $ 33)))
                               (COND
                                ((NULL (SPADCALL |op2| 'CONCAT (QREFELT $ 35)))
                                 (EXIT |a|)))
                               (LETT |op3|
                                     (|SPADfirst|
                                      (SPADCALL
                                       (SPADCALL |args| 2 (QREFELT $ 40))
                                       (QREFELT $ 37))))
                               (COND
                                ((NULL (SPADCALL |op3| '|d| (QREFELT $ 35)))
                                 (EXIT |a|)))
                               (EXIT
                                (SPADCALL (SPADCALL 'INTSEP (QREFELT $ 41))
                                          (LIST
                                           (SPADCALL |args| 1 (QREFELT $ 40))
                                           (SPADCALL |args| 2 (QREFELT $ 40)))
                                          (QREFELT $ 42))))))))))))) 

(SDEFUN |FMT2D;integral;IM;11|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMT2D;integral;IM;11!0| (VECTOR |p| $))))) 

(SDEFUN |FMT2D;integral;IM;11!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|bx| NIL) (|ba| NIL) (|a| NIL) (|bu| NIL) (|bl| NIL) (|op| NIL))
             (SEQ
              (LETT |op|
                    (SPADCALL
                     (LIST (SPADCALL " ++" (QREFELT $ 16))
                           (SPADCALL " | " (QREFELT $ 16))
                           (SPADCALL "++ " (QREFELT $ 16)))
                     2 (QREFELT $ 25)))
              (LETT |bl|
                    (SPADCALL
                     (SPADCALL |args| (|spadConstant| $ 43) (QREFELT $ 40))
                     (SPADCALL (QREFELT $ 45)) (QREFELT $ 46)))
              (LETT |bu|
                    (SPADCALL (SPADCALL |args| 2 (QREFELT $ 40))
                              (SPADCALL (QREFELT $ 45)) (QREFELT $ 46)))
              (LETT |a|
                    (|FMT2D;integralArgument|
                     (SPADCALL |args| 3 (QREFELT $ 40)) $))
              (LETT |ba|
                    (SPADCALL |a| (SPADCALL (QREFELT $ 45)) (QREFELT $ 46)))
              (LETT |bx|
                    (SPADCALL (LIST |bu| |op| |bl|)
                              (SPADCALL
                               (SPADCALL (SPADCALL |op| (QREFELT $ 22))
                                         (SPADCALL |bu| (QREFELT $ 22))
                                         (QREFELT $ 47))
                               (SPADCALL |bu| (QREFELT $ 23)) (QREFELT $ 47))
                              (QREFELT $ 25)))
              (EXIT
               (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 48))
                         (SPADCALL
                          (LIST |bx| (SPADCALL " " (QREFELT $ 16)) |ba|)
                          (QREFELT $ 26))
                         (QREFELT $ 49))))))))) 

(SDEFUN |FMT2D;operatorWithLimits|
        ((|op| (|OutputBox|)) (|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ (CONS #'|FMT2D;operatorWithLimits!0| (VECTOR |p| |op| $))))) 

(SDEFUN |FMT2D;operatorWithLimits!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |op| |p|)
          (LETT $ (QREFELT $$ 2))
          (LETT |op| (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|bx| NIL) (|b3| NIL) (|b2| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (SPADCALL
                           (SPADCALL |args| (|spadConstant| $ 44)
                                     (QREFELT $ 40))
                           (SPADCALL (QREFELT $ 45)) (QREFELT $ 46)))
                    (LETT |b2|
                          (SPADCALL (SPADCALL |args| 2 (QREFELT $ 40))
                                    (SPADCALL (QREFELT $ 45)) (QREFELT $ 46)))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |args| (QREFELT $ 52)) 2
                                 (QREFELT $ 53))
                       (SPADCALL
                        (LIST
                         (SPADCALL (LIST |op| |b1|)
                                   (SPADCALL |op| (QREFELT $ 22))
                                   (QREFELT $ 25))
                         (SPADCALL " " (QREFELT $ 16)) |b2|)
                        (QREFELT $ 26)))
                      ('T
                       (SEQ
                        (LETT |b3|
                              (SPADCALL (SPADCALL |args| 3 (QREFELT $ 40))
                                        (SPADCALL (QREFELT $ 45))
                                        (QREFELT $ 46)))
                        (LETT |bx|
                              (SPADCALL (LIST |b2| |op| |b1|)
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |op| (QREFELT $ 22))
                                          (SPADCALL |b2| (QREFELT $ 22))
                                          (QREFELT $ 47))
                                         (SPADCALL |b2| (QREFELT $ 23))
                                         (QREFELT $ 47))
                                        (QREFELT $ 25)))
                        (EXIT
                         (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 48))
                                   (SPADCALL
                                    (LIST |bx| (SPADCALL " " (QREFELT $ 16))
                                          |b3|)
                                    (QREFELT $ 26))
                                   (QREFELT $ 49))))))))))))) 

(SDEFUN |FMT2D;sum;IM;13|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG ((|op| (|OutputBox|)))
               (SEQ
                (LETT |op|
                      (SPADCALL
                       (LIST (SPADCALL "--+" (QREFELT $ 16))
                             (SPADCALL ">  " (QREFELT $ 16))
                             (SPADCALL "--+" (QREFELT $ 16)))
                       2 (QREFELT $ 25)))
                (EXIT (|FMT2D;operatorWithLimits| |op| |p| $))))) 

(SDEFUN |FMT2D;product;IM;14|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG ((|op| (|OutputBox|)))
               (SEQ
                (LETT |op|
                      (SPADCALL
                       (LIST (SPADCALL "++-++" (QREFELT $ 16))
                             (SPADCALL " | | " (QREFELT $ 16))
                             (SPADCALL " | | " (QREFELT $ 16)))
                       2 (QREFELT $ 25)))
                (EXIT (|FMT2D;operatorWithLimits| |op| |p| $))))) 

(SDEFUN |FMT2D;theMap;ILOb;15|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG
         ((|p2| (|Integer|)) (|p1| (|Integer|)) (|s| (|String|))
          (|b| (|OutputBox|)) (|a| (|OutputForm|)))
         (SEQ (LETT |a| (|SPADfirst| |args|))
              (LETT |s|
                    (SEQ
                     (COND
                      ((SPADCALL |a| (QREFELT $ 32))
                       (COND
                        ((NULL (SPADCALL |a| (QREFELT $ 56)))
                         (COND
                          ((NULL (SPADCALL |a| (QREFELT $ 57)))
                           (EXIT ";?;")))))))
                     (LETT |b|
                           (SPADCALL |a| (SPADCALL (QREFELT $ 45))
                                     (QREFELT $ 46)))
                     (EXIT (|SPADfirst| (SPADCALL |b| (QREFELT $ 59))))))
              (LETT |p1| (SPADCALL (|STR_to_CHAR| ";") |s| (QREFELT $ 60)))
              (LETT |p2|
                    (SPADCALL (|STR_to_CHAR| ";") |s| (+ |p1| 1)
                              (QREFELT $ 61)))
              (EXIT
               (SPADCALL "theMap(" ")"
                         (SPADCALL
                          (SPADCALL |s|
                                    (SPADCALL (+ |p1| 1) (- |p2| 1)
                                              (QREFELT $ 63))
                                    (QREFELT $ 64))
                          (QREFELT $ 16))
                         (QREFELT $ 27)))))) 

(SDEFUN |FMT2D;overbar;I2M;16|
        ((|p| #1=(|Integer|))
         (|hh| (|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMT2D;overbar;I2M;16!0| (VECTOR |p| |hh| $))))) 

(SDEFUN |FMT2D;overbar;I2M;16!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |hh| |p|)
          (LETT $ (QREFELT $$ 2))
          (LETT |hh| (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|bar| NIL) (|bx| NIL))
                   (SEQ
                    (LETT |bx|
                          (SPADCALL (SPADCALL (QREFELT $ 45))
                                    (LIST (SPADCALL |args| (QREFELT $ 66)))
                                    |hh|))
                    (LETT |bar|
                          (SPADCALL
                           (SPADCALL (SPADCALL |bx| (QREFELT $ 28))
                                     (SPADCALL "_" (QREFELT $ 14))
                                     (QREFELT $ 67))
                           (QREFELT $ 16)))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 48))
                               (SPADCALL (LIST |bar| |bx|)
                                         (SPADCALL (|spadConstant| $ 43)
                                                   (SPADCALL |bx|
                                                             (QREFELT $ 22))
                                                   (QREFELT $ 47))
                                         (QREFELT $ 25))
                               (QREFELT $ 49))))))))) 

(SDEFUN |FMT2D;box;2M;17|
        ((|hh| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (CONS #'|FMT2D;box;2M;17!0| (VECTOR |hh| $)))) 

(SDEFUN |FMT2D;box;2M;17!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |hh|)
          (LETT $ (QREFELT $$ 1))
          (LETT |hh| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|FMT2D;fbox|
             (SPADCALL (SPADCALL (QREFELT $ 45))
                       (LIST (SPADCALL |args| (QREFELT $ 66))) |hh|)
             $))))) 

(SDEFUN |FMT2D;nthRoot;I3M;18|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMT2D;nthRoot;I3M;18!0| (VECTOR |h2| |h1| $ |p|))))) 

(SDEFUN |FMT2D;nthRoot;I3M;18!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| $ |h1| |h2|)
          (LETT |p| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |h1| (QREFELT $$ 1))
          (LETT |h2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|lb| NIL) (#1=#:G827 NIL) (|i| NIL) (#2=#:G826 NIL) (|br| NIL)
              (|hdn| NIL) (|bv| NIL) (|bn| NIL) (|bspace| NIL) (|bar| NIL)
              (|r| NIL) (#3=#:G825 NIL) (#4=#:G824 NIL) (|l| NIL)
              (#5=#:G823 NIL) (#6=#:G822 NIL) (|w| NIL) (|d| NIL) (|h| NIL)
              (|bx| NIL))
             (SEQ
              (LETT |bx|
                    (SPADCALL |p| (LIST (SPADCALL |args| (QREFELT $ 66)))
                              |h1|))
              (LETT |h| (SPADCALL |bx| (QREFELT $ 22)))
              (LETT |d| (SPADCALL |bx| (QREFELT $ 23)))
              (LETT |w| (SPADCALL |bx| (QREFELT $ 28)))
              (LETT |l| (SPADCALL "|" (QREFELT $ 16)))
              (LETT |l|
                    (SPADCALL
                     (PROGN
                      (LETT #6# NIL)
                      (SEQ (LETT |i| (|spadConstant| $ 43))
                           (LETT #5# (SPADCALL |h| |d| (QREFELT $ 47))) G190
                           (COND ((> |i| #5#) (GO G191)))
                           (SEQ (EXIT (LETT #6# (CONS |l| #6#))))
                           (LETT |i| (+ |i| 1)) (GO G190) G191
                           (EXIT (NREVERSE #6#))))
                     |h| (QREFELT $ 25)))
              (LETT |r| (SPADCALL " " (QREFELT $ 16)))
              (LETT |r|
                    (SPADCALL
                     (PROGN
                      (LETT #4# NIL)
                      (SEQ (LETT |i| (|spadConstant| $ 43))
                           (LETT #3# (SPADCALL |h| |d| (QREFELT $ 47))) G190
                           (COND ((> |i| #3#) (GO G191)))
                           (SEQ (EXIT (LETT #4# (CONS |r| #4#))))
                           (LETT |i| (+ |i| 1)) (GO G190) G191
                           (EXIT (NREVERSE #4#))))
                     |h| (QREFELT $ 25)))
              (LETT |bar|
                    (SPADCALL
                     (SPADCALL
                      (LIST "+"
                            (SPADCALL |w| (SPADCALL "-" (QREFELT $ 14))
                                      (QREFELT $ 67))
                            "+")
                      (QREFELT $ 29))
                     (QREFELT $ 16)))
              (LETT |br|
                    (SPADCALL
                     (LIST |bar| (SPADCALL (LIST |l| |bx| |r|) (QREFELT $ 26)))
                     (SPADCALL |h| (|spadConstant| $ 43) (QREFELT $ 47))
                     (QREFELT $ 25)))
              (LETT |bspace| (SPADCALL " " (QREFELT $ 16)))
              (LETT |bn| |bspace|) (LETT |bv| (SPADCALL "\\" (QREFELT $ 16)))
              (COND
               ((SPADCALL (SPADCALL |args| (QREFELT $ 52))
                          (|spadConstant| $ 43) (QREFELT $ 72))
                (SEQ
                 (LETT |bn|
                       (SPADCALL |p| (LIST (SPADCALL |args| 2 (QREFELT $ 40)))
                                 |h2|))
                 (EXIT
                  (LETT |bv|
                        (SPADCALL |bv|
                                  (SPADCALL (|spadConstant| $ 73)
                                            (|spadConstant| $ 73)
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |bn| (QREFELT $ 28))
                                              (|spadConstant| $ 76)
                                              (QREFELT $ 77))
                                             (QREFELT $ 78))
                                            (|spadConstant| $ 73)
                                            (QREFELT $ 80))))))))
              (LETT |hdn|
                    (SPADCALL (SPADCALL |bn| (QREFELT $ 22))
                              (SPADCALL |bn| (QREFELT $ 23)) (QREFELT $ 47)))
              (LETT |lb| (LIST |bn| |bv|))
              (COND
               ((SPADCALL |hdn| (SPADCALL |h| |d| (QREFELT $ 47))
                          (QREFELT $ 72))
                (LETT |br|
                      (SPADCALL |br|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |hdn| |h| (QREFELT $ 77))
                                            |d| (QREFELT $ 77))
                                  (QREFELT $ 78))
                                 (|spadConstant| $ 73) (|spadConstant| $ 73)
                                 (|spadConstant| $ 73) (QREFELT $ 80)))))
               ('T
                (LETT |lb|
                      (SPADCALL
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |i| (|spadConstant| $ 76))
                             (LETT #1#
                                   (SPADCALL (SPADCALL |h| |d| (QREFELT $ 47))
                                             |hdn| (QREFELT $ 77)))
                             G190 (COND ((> |i| #1#) (GO G191)))
                             (SEQ (EXIT (LETT #2# (CONS |bspace| #2#))))
                             (LETT |i| (+ |i| 1)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))
                       |lb| (QREFELT $ 82)))))
              (EXIT
               (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 48))
                         (SPADCALL
                          (LIST
                           (SPADCALL |lb| (SPADCALL |br| (QREFELT $ 22))
                                     (QREFELT $ 25))
                           |br|)
                          (QREFELT $ 26))
                         (QREFELT $ 49))))))))) 

(SDEFUN |FMT2D;normalizeBox| ((|b| (|OutputBox|)) ($ (|OutputBox|)))
        (SPROG ((|l| (|String|)))
               (SEQ
                (COND
                 ((OR (> (SPADCALL |b| (QREFELT $ 22)) 1)
                      (> (SPADCALL |b| (QREFELT $ 23)) 1))
                  |b|)
                 ('T
                  (COND
                   ((ZEROP (SPADCALL |b| (QREFELT $ 22)))
                    (SPADCALL (QREFELT $ 9)))
                   ('T
                    (SEQ (LETT |l| (|SPADfirst| (SPADCALL |b| (QREFELT $ 59))))
                         (COND
                          ((OR (EQUAL |l| "") (EQUAL |l| " "))
                           (EXIT (SPADCALL (QREFELT $ 9)))))
                         (EXIT |b|))))))))) 

(SDEFUN |FMT2D;scripts;IM;20|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMT2D;scripts;IM;20!0| (VECTOR |p| $))))) 

(SDEFUN |FMT2D;scripts;IM;20!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|left| NIL) (|ll| NIL) (|ul| NIL) (|wl| NIL) (|right| NIL)
              (|lr| NIL) (|ur| NIL) (|wr| NIL) (|hspace| NIL) (#1=#:G847 NIL)
              (|i| NIL) (#2=#:G846 NIL) (|h| NIL) (|lb| NIL) (#3=#:G845 NIL)
              (#4=#:G844 NIL) (|a| NIL) (#5=#:G843 NIL) (|bx| NIL))
             (SEQ
              (LETT |bx|
                    (SPADCALL (SPADCALL |args| (QREFELT $ 66)) |p|
                              (QREFELT $ 46)))
              (LETT |lb|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |a| NIL)
                          (LETT #4# (SPADCALL |args| (QREFELT $ 84))) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |a| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #5#
                                  (CONS
                                   (SPADCALL |a| (SPADCALL (QREFELT $ 45))
                                             (QREFELT $ 46))
                                   #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (LETT |lb|
                    (SPADCALL |lb|
                              (PROGN
                               (LETT #3# NIL)
                               (SEQ (LETT |i| (|spadConstant| $ 71)) G190
                                    (COND ((|greater_SI| |i| 4) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #3#
                                            (CONS (SPADCALL (QREFELT $ 9))
                                                  #3#))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT (NREVERSE #3#))))
                              (QREFELT $ 82)))
              (LETT |lr|
                    (|FMT2D;normalizeBox|
                     (SPADCALL |lb| (|spadConstant| $ 71) (QREFELT $ 85)) $))
              (LETT |ur|
                    (|FMT2D;normalizeBox| (SPADCALL |lb| 2 (QREFELT $ 85)) $))
              (LETT |ul|
                    (|FMT2D;normalizeBox| (SPADCALL |lb| 3 (QREFELT $ 85)) $))
              (LETT |ll|
                    (|FMT2D;normalizeBox| (SPADCALL |lb| 4 (QREFELT $ 85)) $))
              (LETT |h| (SPADCALL |bx| (QREFELT $ 22)))
              (LETT |hspace|
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |i| (|spadConstant| $ 71))
                           (LETT #1#
                                 (SPADCALL |h| (SPADCALL |bx| (QREFELT $ 23))
                                           (QREFELT $ 47)))
                           G190 (COND ((> |i| #1#) (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS (SPADCALL "" (QREFELT $ 16)) #2#))))
                           (LETT |i| (+ |i| 1)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     |h| (QREFELT $ 25)))
              (LETT |wr|
                    (SPADCALL (SPADCALL |ur| (QREFELT $ 28))
                              (SPADCALL |lr| (QREFELT $ 28)) (QREFELT $ 86)))
              (LETT |ur|
                    (SPADCALL |ur|
                              (SPADCALL (|spadConstant| $ 73)
                                        (|spadConstant| $ 73)
                                        (|spadConstant| $ 73)
                                        (SPADCALL
                                         (SPADCALL |wr|
                                                   (SPADCALL |ur|
                                                             (QREFELT $ 28))
                                                   (QREFELT $ 77))
                                         (QREFELT $ 78))
                                        (QREFELT $ 80))))
              (LETT |lr|
                    (SPADCALL |lr|
                              (SPADCALL (|spadConstant| $ 73)
                                        (|spadConstant| $ 73)
                                        (|spadConstant| $ 73)
                                        (SPADCALL
                                         (SPADCALL |wr|
                                                   (SPADCALL |lr|
                                                             (QREFELT $ 28))
                                                   (QREFELT $ 77))
                                         (QREFELT $ 78))
                                        (QREFELT $ 80))))
              (LETT |right|
                    (SPADCALL (LIST |ur| |hspace| |lr|)
                              (SPADCALL
                               (SPADCALL (SPADCALL |ur| (QREFELT $ 22))
                                         (SPADCALL |ur| (QREFELT $ 23))
                                         (QREFELT $ 47))
                               |h| (QREFELT $ 47))
                              (QREFELT $ 25)))
              (LETT |wl|
                    (SPADCALL (SPADCALL |ul| (QREFELT $ 28))
                              (SPADCALL |ll| (QREFELT $ 28)) (QREFELT $ 86)))
              (LETT |ul|
                    (SPADCALL |ul|
                              (SPADCALL (|spadConstant| $ 73)
                                        (|spadConstant| $ 73)
                                        (SPADCALL
                                         (SPADCALL |wl|
                                                   (SPADCALL |ul|
                                                             (QREFELT $ 28))
                                                   (QREFELT $ 77))
                                         (QREFELT $ 78))
                                        (|spadConstant| $ 73) (QREFELT $ 80))))
              (LETT |ll|
                    (SPADCALL |ll|
                              (SPADCALL (|spadConstant| $ 73)
                                        (|spadConstant| $ 73)
                                        (SPADCALL
                                         (SPADCALL |wl|
                                                   (SPADCALL |ll|
                                                             (QREFELT $ 28))
                                                   (QREFELT $ 77))
                                         (QREFELT $ 78))
                                        (|spadConstant| $ 73) (QREFELT $ 80))))
              (LETT |left|
                    (SPADCALL (LIST |ul| |hspace| |ll|)
                              (SPADCALL
                               (SPADCALL (SPADCALL |ul| (QREFELT $ 22))
                                         (SPADCALL |ul| (QREFELT $ 23))
                                         (QREFELT $ 47))
                               |h| (QREFELT $ 47))
                              (QREFELT $ 25)))
              (EXIT
               (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 48))
                         (SPADCALL (LIST |left| |bx| |right|) (QREFELT $ 26))
                         (QREFELT $ 49))))))))) 

(SDEFUN |FMT2D;subscript;IM;21|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMT2D;subscript;IM;21!0| (VECTOR |p| $))))) 

(SDEFUN |FMT2D;subscript;IM;21!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|sb| NIL) (|bspace| NIL) (|bx| NIL))
                   (SEQ
                    (LETT |bx|
                          (SPADCALL (SPADCALL |args| (QREFELT $ 66)) |p|
                                    (QREFELT $ 46)))
                    (LETT |sb|
                          (SPADCALL (SPADCALL (QREFELT $ 45))
                                    (SPADCALL |args| (QREFELT $ 84))
                                    (SPADCALL ", " (SPADCALL (QREFELT $ 88))
                                              (SPADCALL
                                               (SPADCALL (QREFELT $ 45))
                                               (QREFELT $ 89))
                                              (QREFELT $ 90))))
                    (LETT |bspace| (SPADCALL " " (QREFELT $ 16)))
                    (LETT |sb|
                          (SPADCALL (LIST |bspace| |sb|) (|spadConstant| $ 43)
                                    (QREFELT $ 25)))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 48))
                               (SPADCALL (LIST |bx| |sb|) (QREFELT $ 26))
                               (QREFELT $ 49))))))))) 

(SDEFUN |FMT2D;altsupersub;IM;22|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMT2D;altsupersub;IM;22!0| (VECTOR |p| $))))) 

(SDEFUN |FMT2D;altsupersub;IM;22!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|bx| NIL) (|right| NIL) (|bu| NIL) (|bl| NIL) (|w| NIL)
              (|wu| NIL) (|lb| NIL) (|wl| NIL) (|hspace| NIL) (#1=#:G868 NIL)
              (|i| NIL) (#2=#:G867 NIL) (|h| NIL) (#3=#:G866 NIL) (|a| NIL)
              (#4=#:G865 NIL))
             (SEQ
              (LETT |bx|
                    (SPADCALL (SPADCALL |args| (QREFELT $ 66)) |p|
                              (QREFELT $ 46)))
              (LETT |lb|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |a| NIL)
                          (LETT #3# (SPADCALL |args| (QREFELT $ 84))) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |a| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (SPADCALL |a| (SPADCALL (QREFELT $ 45))
                                             (QREFELT $ 46))
                                   #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (COND
               ((SPADCALL (SPADCALL |lb| (QREFELT $ 92)) (QREFELT $ 93))
                (LETT |lb|
                      (SPADCALL |lb| (SPADCALL (QREFELT $ 9))
                                (QREFELT $ 94)))))
              (LETT |h| (SPADCALL |bx| (QREFELT $ 22)))
              (LETT |hspace|
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |i| (|spadConstant| $ 43))
                           (LETT #1#
                                 (SPADCALL |h| (SPADCALL |bx| (QREFELT $ 23))
                                           (QREFELT $ 47)))
                           G190 (COND ((> |i| #1#) (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS (SPADCALL "" (QREFELT $ 16)) #2#))))
                           (LETT |i| (+ |i| 1)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     |h| (QREFELT $ 25)))
              (SEQ G190
                   (COND
                    ((NULL (NULL (SPADCALL |lb| (QREFELT $ 95)))) (GO G191)))
                   (SEQ (LETT |bl| (SPADCALL |lb| (QREFELT $ 96)))
                        (LETT |lb| (SPADCALL |lb| (QREFELT $ 97)))
                        (LETT |wl| (SPADCALL |bl| (QREFELT $ 28)))
                        (LETT |bu| (SPADCALL |lb| (QREFELT $ 96)))
                        (LETT |lb| (SPADCALL |lb| (QREFELT $ 97)))
                        (LETT |wu| (SPADCALL |bu| (QREFELT $ 28)))
                        (LETT |w|
                              (SPADCALL (SPADCALL |wl| |wu| (QREFELT $ 86))
                                        (|spadConstant| $ 43) (QREFELT $ 47)))
                        (LETT |bl|
                              (SPADCALL |bl|
                                        (SPADCALL (|spadConstant| $ 73)
                                                  (|spadConstant| $ 73)
                                                  (|spadConstant| $ 73)
                                                  (SPADCALL
                                                   (SPADCALL |w| |wl|
                                                             (QREFELT $ 77))
                                                   (QREFELT $ 98))
                                                  (QREFELT $ 80))))
                        (LETT |bu|
                              (SPADCALL |bu|
                                        (SPADCALL (|spadConstant| $ 73)
                                                  (|spadConstant| $ 73)
                                                  (|spadConstant| $ 73)
                                                  (SPADCALL
                                                   (SPADCALL |w| |wu|
                                                             (QREFELT $ 77))
                                                   (QREFELT $ 98))
                                                  (QREFELT $ 80))))
                        (LETT |right|
                              (SPADCALL (LIST |bu| |hspace| |bl|)
                                        (SPADCALL
                                         (SPADCALL |h|
                                                   (SPADCALL |bu|
                                                             (QREFELT $ 22))
                                                   (QREFELT $ 47))
                                         (SPADCALL |bu| (QREFELT $ 23))
                                         (QREFELT $ 47))
                                        (QREFELT $ 25)))
                        (EXIT
                         (LETT |bx|
                               (SPADCALL (LIST |bx| |right|) (QREFELT $ 26)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |bx|))))))) 

(SDEFUN |FMT2D;prime;IM;23|
        ((|p| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMT2D;prime;IM;23!0| (VECTOR |p| $))))) 

(SDEFUN |FMT2D;prime;IM;23!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |p|)
          (LETT $ (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|b| NIL) (|raise| NIL) (#1=#:G886 NIL) (|i| NIL) (#2=#:G885 NIL)
              (|h| NIL) (#3=#:G884 NIL) (|n| NIL) (|s2| NIL) (|b1| NIL)
              (|a2| NIL))
             (SEQ (LETT |a2| (SPADCALL |args| 2 (QREFELT $ 40)))
                  (COND
                   ((NULL (SPADCALL |a2| (QREFELT $ 32)))
                    (EXIT
                     (SPADCALL |prec| |args|
                               (SPADCALL |p|
                                         (SPADCALL
                                          (SPADCALL |p| (|spadConstant| $ 76)
                                                    (QREFELT $ 100))
                                          (QREFELT $ 89))
                                         (SPADCALL (SPADCALL (QREFELT $ 45))
                                                   (QREFELT $ 89))
                                         (QREFELT $ 101))))))
                  (LETT |b1|
                        (SPADCALL (SPADCALL |args| (QREFELT $ 66)) |p|
                                  (QREFELT $ 46)))
                  (COND
                   ((NULL (SPADCALL |a2| (QREFELT $ 56)))
                    (EXIT (|error| "prime: second argument error"))))
                  (LETT |s2| (SPADCALL |a2| (QREFELT $ 102)))
                  (LETT |n| (SPADCALL |s2| (QREFELT $ 103)))
                  (SEQ (LETT |i| (|spadConstant| $ 76)) (LETT #3# |n|) G190
                       (COND ((> |i| #3#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (SPADCALL |s2| |i| (QREFELT $ 104))
                                     (SPADCALL "," (QREFELT $ 14))
                                     (QREFELT $ 105))
                           (|error| "prime: no comma")))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                  (LETT |b|
                        (SPADCALL
                         (SPADCALL |n| (SPADCALL "'" (QREFELT $ 14))
                                   (QREFELT $ 67))
                         (QREFELT $ 16)))
                  (LETT |h| (SPADCALL |b1| (QREFELT $ 22)))
                  (COND
                   ((SPADCALL |h| (|spadConstant| $ 76) (QREFELT $ 72))
                    (SEQ
                     (LETT |raise|
                           (SPADCALL
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |i| (|spadConstant| $ 76))
                                  (LETT #1#
                                        (SPADCALL |h| (|spadConstant| $ 76)
                                                  (QREFELT $ 77)))
                                  G190 (COND ((> |i| #1#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS (SPADCALL " " (QREFELT $ 16))
                                                #2#))))
                                  (LETT |i| (+ |i| 1)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            (SPADCALL
                             (SPADCALL |h| (|spadConstant| $ 76)
                                       (QREFELT $ 77))
                             (QREFELT $ 78))
                            (QREFELT $ 25)))
                     (EXIT
                      (LETT |b|
                            (SPADCALL (LIST |b| |raise|) |h|
                                      (QREFELT $ 25)))))))
                  (EXIT
                   (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 48))
                             (SPADCALL (LIST |b1| |b|) (QREFELT $ 26))
                             (QREFELT $ 49))))))))) 

(SDEFUN |FMT2D;power;I3M;24|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ (CONS #'|FMT2D;power;I3M;24!0| (VECTOR |h2| |h1| $ |p|))))) 

(SDEFUN |FMT2D;power;I3M;24!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG (|p| $ |h1| |h2|)
          (LETT |p| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |h1| (QREFELT $$ 1))
          (LETT |h2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|bx2| NIL) (|raise| NIL) (#1=#:G893 NIL) (|i| NIL)
              (#2=#:G892 NIL) (|bx1| NIL) (|ht2| NIL) (|ht1| NIL) (|b2| NIL)
              (|b1| NIL))
             (SEQ
              (LETT |b1|
                    (SPADCALL
                     (SPADCALL |p| (|spadConstant| $ 44) (QREFELT $ 100))
                     (LIST
                      (SPADCALL |args| (|spadConstant| $ 44) (QREFELT $ 40)))
                     |h1|))
              (LETT |b2|
                    (SPADCALL (SPADCALL (QREFELT $ 45))
                              (LIST (SPADCALL |args| 2 (QREFELT $ 40))) |h2|))
              (LETT |ht1| (SPADCALL |b1| (QREFELT $ 22)))
              (LETT |ht2| (SPADCALL |b2| (QREFELT $ 22)))
              (LETT |bx1|
                    (SPADCALL |b1|
                              (SPADCALL |ht2| (|spadConstant| $ 73)
                                        (|spadConstant| $ 73)
                                        (|spadConstant| $ 73) (QREFELT $ 80))))
              (LETT |raise|
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |i| (|spadConstant| $ 76)) (LETT #1# |ht1|)
                           G190 (COND ((> |i| #1#) (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS (SPADCALL " " (QREFELT $ 16)) #2#))))
                           (LETT |i| (+ |i| 1)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     |ht1| (QREFELT $ 25)))
              (LETT |bx2|
                    (SPADCALL (LIST |b2| |raise|)
                              (SPADCALL (SPADCALL |ht1| |ht2| (QREFELT $ 47))
                                        (SPADCALL |b2| (QREFELT $ 23))
                                        (QREFELT $ 47))
                              (QREFELT $ 25)))
              (EXIT
               (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 48))
                         (SPADCALL (LIST |bx1| |bx2|) (QREFELT $ 26))
                         (QREFELT $ 49))))))))) 

(SDEFUN |FMT2D;fraction;I3M;25|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMT2D;fraction;I3M;25!0| (VECTOR |p| |h2| |h1| $))))) 

(SDEFUN |FMT2D;fraction;I3M;25!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |h1| |h2| |p|)
          (LETT $ (QREFELT $$ 3))
          (LETT |h1| (QREFELT $$ 2))
          (LETT |h2| (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|bar| NIL) (|hd| NIL) (|b2| NIL) (|b1| NIL))
                   (SEQ
                    (LETT |b1|
                          (SPADCALL (SPADCALL (QREFELT $ 45))
                                    (LIST
                                     (SPADCALL |args| (|spadConstant| $ 44)
                                               (QREFELT $ 40)))
                                    |h1|))
                    (LETT |b2|
                          (SPADCALL (SPADCALL (QREFELT $ 45))
                                    (LIST (SPADCALL |args| 2 (QREFELT $ 40)))
                                    |h2|))
                    (LETT |hd|
                          (SPADCALL (SPADCALL |b1| (QREFELT $ 22))
                                    (SPADCALL |b1| (QREFELT $ 23))
                                    (QREFELT $ 47)))
                    (LETT |bar|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |b1| (QREFELT $ 28))
                                      (SPADCALL |b2| (QREFELT $ 28))
                                      (QREFELT $ 86))
                            (SPADCALL "-" (QREFELT $ 14)) (QREFELT $ 67))
                           (QREFELT $ 16)))
                    (EXIT
                     (SPADCALL (SPADCALL |p| |prec| (QREFELT $ 48))
                               (SPADCALL (LIST |b1| |bar| |b2|)
                                         (SPADCALL |hd| (|spadConstant| $ 76)
                                                   (QREFELT $ 47))
                                         (QREFELT $ 25))
                               (QREFELT $ 49))))))))) 

(SDEFUN |FMT2D;slash;I3M;26|
        ((|p| #1=(|Integer|))
         (|h1| #2=(|Mapping| (|OutputBox|) #1# (|List| (|OutputForm|))))
         (|h2| #2#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPADCALL " / " |p| |h1| |h2| (QREFELT $ 109))) 

(SDEFUN |FMT2D;binomial;ILOb;27|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG
         ((|bspace| (|OutputBox|)) (|hd| (|NonNegativeInteger|))
          (|b2| #1=(|OutputBox|)) (|b1| #1#))
         (SEQ
          (LETT |b1|
                (SPADCALL (SPADCALL |args| 1 (QREFELT $ 40))
                          (SPADCALL (QREFELT $ 45)) (QREFELT $ 46)))
          (LETT |b2|
                (SPADCALL (SPADCALL |args| 2 (QREFELT $ 40))
                          (SPADCALL (QREFELT $ 45)) (QREFELT $ 46)))
          (LETT |hd|
                (+ (SPADCALL |b1| (QREFELT $ 22))
                   (SPADCALL |b1| (QREFELT $ 23))))
          (LETT |bspace|
                (SPADCALL
                 (|make_full_CVEC2|
                  (MAX (SPADCALL |b1| (QREFELT $ 28))
                       (SPADCALL |b2| (QREFELT $ 28)))
                  (|STR_to_CHAR| " "))
                 (QREFELT $ 16)))
          (EXIT
           (SPADCALL "(" ")"
                     (SPADCALL (LIST |b1| |bspace| |b2|) (+ |hd| 1)
                               (QREFELT $ 25))
                     (QREFELT $ 27)))))) 

(SDEFUN |FMT2D;zag;ILOb;28|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|OutputBox|)))
        (SPROG ((|br| #1=(|OutputBox|)) (|bl| #1#) (|bx| (|OutputBox|)))
               (SEQ
                (LETT |bx|
                      (SPADCALL |prec| |args|
                                (SPADCALL (SPADCALL (QREFELT $ 88))
                                          (SPADCALL (SPADCALL (QREFELT $ 45))
                                                    (QREFELT $ 89))
                                          (SPADCALL (SPADCALL (QREFELT $ 45))
                                                    (QREFELT $ 89))
                                          (QREFELT $ 108))))
                (LETT |bl|
                      (SPADCALL
                       (LIST (SPADCALL "+-" (QREFELT $ 16))
                             (SPADCALL "| " (QREFELT $ 16)))
                       1 (QREFELT $ 25)))
                (LETT |br|
                      (SPADCALL
                       (LIST (SPADCALL " |" (QREFELT $ 16))
                             (SPADCALL "-+" (QREFELT $ 16)))
                       2 (QREFELT $ 25)))
                (EXIT (SPADCALL (LIST |bl| |bx| |br|) (QREFELT $ 26)))))) 

(SDEFUN |FMT2D;formatList|
        ((|prec| (|Integer|)) (|args| (|List| (|OutputForm|)))
         ($ (|List| (|OutputBox|))))
        (SPROG ((#1=#:G917 NIL) (|a| NIL) (#2=#:G916 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |a| NIL) (LETT #1# |args|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |a| |prec| (QREFELT $ 46))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |FMT2D;vconcatAligned|
        ((|align| (|Integer|))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL (SEQ (CONS #'|FMT2D;vconcatAligned!0| (VECTOR |align| $))))) 

(SDEFUN |FMT2D;vconcatAligned!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |align|)
          (LETT $ (QREFELT $$ 1))
          (LETT |align| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((#1=#:G939 NIL) (|b| NIL) (#2=#:G938 NIL) (#3=#:G937 NIL)
              (#4=#:G936 NIL) (#5=#:G935 NIL) (#6=#:G934 NIL) (|h| NIL)
              (|w| NIL) (#7=#:G933 NIL) (#8=#:G932 NIL) (|boxes| NIL))
             (SEQ
              (COND
               ((SPADCALL |args| (QREFELT $ 113)) (SPADCALL (QREFELT $ 9)))
               ('T
                (SEQ (LETT |boxes| (|FMT2D;formatList| |prec| |args| $))
                     (LETT |w|
                           (SPADCALL
                            (PROGN
                             (LETT #8# NIL)
                             (SEQ (LETT |b| NIL) (LETT #7# |boxes|) G190
                                  (COND
                                   ((OR (ATOM #7#)
                                        (PROGN (LETT |b| (CAR #7#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #8#
                                          (CONS (SPADCALL |b| (QREFELT $ 28))
                                                #8#))))
                                  (LETT #7# (CDR #7#)) (GO G190) G191
                                  (EXIT (NREVERSE #8#))))
                            (QREFELT $ 115)))
                     (LETT |h|
                           (SPADCALL (SPADCALL |boxes| (QREFELT $ 96))
                                     (QREFELT $ 22)))
                     (EXIT
                      (COND
                       ((SPADCALL |align| (QREFELT $ 116))
                        (SPADCALL
                         (PROGN
                          (LETT #6# NIL)
                          (SEQ (LETT |b| NIL) (LETT #5# |boxes|) G190
                               (COND
                                ((OR (ATOM #5#)
                                     (PROGN (LETT |b| (CAR #5#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #6#
                                       (CONS
                                        (SPADCALL |b|
                                                  (SPADCALL |w|
                                                            (QREFELT $ 117)))
                                        #6#))))
                               (LETT #5# (CDR #5#)) (GO G190) G191
                               (EXIT (NREVERSE #6#))))
                         |h| (QREFELT $ 25)))
                       ((SPADCALL |align| (QREFELT $ 118))
                        (SPADCALL
                         (PROGN
                          (LETT #4# NIL)
                          (SEQ (LETT |b| NIL) (LETT #3# |boxes|) G190
                               (COND
                                ((OR (ATOM #3#)
                                     (PROGN (LETT |b| (CAR #3#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #4#
                                       (CONS
                                        (SPADCALL |b|
                                                  (SPADCALL
                                                   (|spadConstant| $ 73)
                                                   (|spadConstant| $ 73)
                                                   (|spadConstant| $ 73)
                                                   (SPADCALL
                                                    (SPADCALL |w|
                                                              (SPADCALL |b|
                                                                        (QREFELT
                                                                         $ 28))
                                                              (QREFELT $ 77))
                                                    (QREFELT $ 98))
                                                   (QREFELT $ 80)))
                                        #4#))))
                               (LETT #3# (CDR #3#)) (GO G190) G191
                               (EXIT (NREVERSE #4#))))
                         |h| (QREFELT $ 25)))
                       ('T
                        (SPADCALL
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |b| NIL) (LETT #1# |boxes|) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |b| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS
                                        (SPADCALL |b|
                                                  (SPADCALL
                                                   (|spadConstant| $ 73)
                                                   (|spadConstant| $ 73)
                                                   (SPADCALL
                                                    (SPADCALL |w|
                                                              (SPADCALL |b|
                                                                        (QREFELT
                                                                         $ 28))
                                                              (QREFELT $ 77))
                                                    (QREFELT $ 98))
                                                   (|spadConstant| $ 73)
                                                   (QREFELT $ 80)))
                                        #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         |h| (QREFELT $ 25)))))))))))))) 

(SDEFUN |FMT2D;vconcat;2M;31|
        ((|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMT2D;vconcatAligned| (|spadConstant| $ 107) $)) 

(SDEFUN |FMT2D;pile;2M;32|
        ((|h| (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (|FMT2D;vconcatAligned| (|spadConstant| $ 44) $)) 

(SDEFUN |FMT2D;matrix;2SM;33|
        ((|left| #1=(|String|)) (|right| #1#)
         ($ (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
        (SPROG NIL
               (SEQ
                (CONS #'|FMT2D;matrix;2SM;33!0| (VECTOR |right| |left| $))))) 

(SDEFUN |FMT2D;matrix;2SM;33!0| ((|prec| NIL) (|args| NIL) ($$ NIL))
        (PROG ($ |left| |right|)
          (LETT $ (QREFELT $$ 2))
          (LETT |left| (QREFELT $$ 1))
          (LETT |right| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|t| NIL) (|rb| NIL) (#1=#:G987 NIL) (|b| NIL) (#2=#:G984 NIL)
              (#3=#:G986 NIL) (#4=#:G985 NIL) (|rowBoxes| NIL) (|rrow| NIL)
              (#5=#:G982 NIL) (#6=#:G983 NIL) (|i| NIL) (#7=#:G981 NIL)
              (|row| NIL) (|sep| NIL) (#8=#:G979 NIL) (#9=#:G980 NIL)
              (#10=#:G978 NIL) (|wd| NIL) (|n| NIL) (|rows| NIL)
              (#11=#:G977 NIL) (|a| NIL) (#12=#:G976 NIL))
             (SEQ
              (COND
               ((SPADCALL |args| (QREFELT $ 113)) (SPADCALL (QREFELT $ 9)))
               ('T
                (SEQ
                 (LETT |rows|
                       (PROGN
                        (LETT #12# NIL)
                        (SEQ (LETT |a| NIL)
                             (LETT #11# (SPADCALL |args| (QREFELT $ 84))) G190
                             (COND
                              ((OR (ATOM #11#)
                                   (PROGN (LETT |a| (CAR #11#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #12#
                                     (CONS
                                      (|FMT2D;formatList| |prec|
                                       (SPADCALL |a| (QREFELT $ 37)) $)
                                      #12#))))
                             (LETT #11# (CDR #11#)) (GO G190) G191
                             (EXIT (NREVERSE #12#)))))
                 (LETT |n|
                       (SPADCALL (SPADCALL |rows| (QREFELT $ 122))
                                 (QREFELT $ 92)))
                 (LETT |wd|
                       (SPADCALL |n| (|spadConstant| $ 73) (QREFELT $ 124)))
                 (SEQ (LETT |row| NIL) (LETT #10# |rows|) G190
                      (COND
                       ((OR (ATOM #10#) (PROGN (LETT |row| (CAR #10#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (SEQ (LETT |i| (|spadConstant| $ 43)) (LETT #9# |n|)
                             (LETT |b| NIL) (LETT #8# |row|) G190
                             (COND
                              ((OR (ATOM #8#) (PROGN (LETT |b| (CAR #8#)) NIL)
                                   (> |i| #9#))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |wd| |i|
                                         (SPADCALL
                                          (SPADCALL |wd| |i| (QREFELT $ 125))
                                          (SPADCALL |b| (QREFELT $ 28))
                                          (QREFELT $ 86))
                                         (QREFELT $ 126))))
                             (LETT #8# (PROG1 (CDR #8#) (LETT |i| (+ |i| 1))))
                             (GO G190) G191 (EXIT NIL))))
                      (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
                 (LETT |sep| (SPADCALL "  " (QREFELT $ 16)))
                 (LETT |rowBoxes| (SPADCALL (QREFELT $ 127)))
                 (SEQ (LETT |row| NIL) (LETT #7# |rows|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |row| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (LETT |rrow|
                             (LIST
                              (SPADCALL (SPADCALL |row| (QREFELT $ 96))
                                        (SPADCALL
                                         (SPADCALL |wd| (|spadConstant| $ 43)
                                                   (QREFELT $ 125))
                                         (QREFELT $ 117)))))
                       (SEQ (LETT |i| 2) (LETT #6# |n|) (LETT |b| NIL)
                            (LETT #5# (SPADCALL |row| (QREFELT $ 97))) G190
                            (COND
                             ((OR (ATOM #5#) (PROGN (LETT |b| (CAR #5#)) NIL)
                                  (|greater_SI| |i| #6#))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |rrow|
                                    (SPADCALL
                                     (SPADCALL |b|
                                               (SPADCALL
                                                (SPADCALL |wd| |i|
                                                          (QREFELT $ 125))
                                                (QREFELT $ 117)))
                                     (SPADCALL |sep| |rrow| (QREFELT $ 128))
                                     (QREFELT $ 128)))))
                            (LETT #5#
                                  (PROG1 (CDR #5#) (LETT |i| (|inc_SI| |i|))))
                            (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (LETT |rowBoxes|
                              (SPADCALL
                               (SPADCALL (SPADCALL |rrow| (QREFELT $ 129))
                                         (QREFELT $ 26))
                               |rowBoxes| (QREFELT $ 128)))))
                      (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                 (LETT |t|
                       (SPADCALL (ELT $ 47)
                                 (PROGN
                                  (LETT #4# (GETREFV (SIZE |rowBoxes|)))
                                  (SEQ (LETT |b| NIL) (LETT #3# |rowBoxes|)
                                       (LETT #2# 0) G190
                                       (COND
                                        ((OR (ATOM #3#)
                                             (PROGN (LETT |b| (CAR #3#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (SETELT #4# #2#
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL |b|
                                                             (QREFELT $ 22))
                                                   (SPADCALL |b|
                                                             (QREFELT $ 23))
                                                   (QREFELT $ 47))
                                                  (|spadConstant| $ 43)
                                                  (QREFELT $ 47)))))
                                       (LETT #2#
                                             (PROG1 (|inc_SI| #2#)
                                               (LETT #3# (CDR #3#))))
                                       (GO G190) G191 (EXIT NIL))
                                  #4#)
                                 (QREFELT $ 132)))
                 (LETT |rb| (LIST (SPADCALL |rowBoxes| (QREFELT $ 96))))
                 (SEQ (LETT |b| NIL)
                      (LETT #1# (SPADCALL |rowBoxes| (QREFELT $ 97))) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |b| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT |rb|
                              (SPADCALL |b|
                                        (SPADCALL |sep| |rb| (QREFELT $ 128))
                                        (QREFELT $ 128)))))
                      (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                 (LETT |t|
                       (SPADCALL
                        (SPADCALL |t| (|spadConstant| $ 43) (QREFELT $ 47))
                        (SPADCALL (|spadConstant| $ 71) (QREFELT $ 133))
                        (QREFELT $ 134)))
                 (EXIT
                  (SPADCALL |left| |right|
                            (SPADCALL |rb| (SPADCALL |t| (QREFELT $ 98))
                                      (QREFELT $ 25))
                            (QREFELT $ 27)))))))))))) 

(SDEFUN |FMT2D;setOperatorHandlers!|
        ((|oh|
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|)))))
         ($
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
        (SPROG ((#1=#:G1370 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SPADCALL |oh| 0 "NOTHING" (SPADCALL (QREFELT $ 136))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 0 "%pi" (SPADCALL "%pi" (QREFELT $ 139))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 0 "%e" (SPADCALL "%e" (QREFELT $ 139))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 0 "%i" (SPADCALL "%i" (QREFELT $ 139))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 0 "%Infinity"
                            (SPADCALL "%Infinity" (QREFELT $ 139))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 0 "infinity"
                            (SPADCALL "infinity" (QREFELT $ 139))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 0 "..." (SPADCALL "..." (QREFELT $ 139))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "cos"
                            (SPADCALL "cos" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2="(" #3=")"
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "cot"
                            (SPADCALL "cot" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "csc"
                            (SPADCALL "csc" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "log"
                            (SPADCALL "log" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "sec"
                            (SPADCALL "sin" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "sin"
                            (SPADCALL "sin" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "tan"
                            (SPADCALL "tan" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "cosh"
                            (SPADCALL "cosh" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "coth"
                            (SPADCALL "coth" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "csch"
                            (SPADCALL "csch" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "sech"
                            (SPADCALL "sech" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "sinh"
                            (SPADCALL "sinh" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "tanh"
                            (SPADCALL "tanh" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "acos"
                            (SPADCALL "acos" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "asin"
                            (SPADCALL "asin" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "atan"
                            (SPADCALL "atan" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "erf"
                            (SPADCALL "erf" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "-"
                            (SPADCALL "-" 710 (SPADCALL 715 (QREFELT $ 89))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "not"
                            (SPADCALL "not " 710 (SPADCALL 715 (QREFELT $ 89))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "QUOTE"
                            (SPADCALL "'" 720 (SPADCALL 960 (QREFELT $ 89))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "OVERBAR"
                            (SPADCALL (SPADCALL (QREFELT $ 88))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 68))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "BOX"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 45))
                                       (QREFELT $ 89))
                             (QREFELT $ 69))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "Aleph"
                            (SPADCALL "Aleph" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "BRACE"
                            (SPADCALL "{" "}"
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 140))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "BRACKET"
                            (SPADCALL "[" "]"
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 140))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "PAREN"
                            (SPADCALL "(" ")"
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 140))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "Gamma"
                            (SPADCALL "Gamma" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #2# #3#
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 45))
                                                 (QREFELT $ 89))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "ROOT"
                            (SPADCALL 970
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 83))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "SEGMENT"
                            (SPADCALL "" " .. " (SPADCALL 990 (QREFELT $ 89))
                                      (QREFELT $ 140))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 1 "STRING"
                            (SPADCALL "\"" "\""
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 140))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "rem"
                            (SPADCALL " rem " 810 (SPADCALL 811 (QREFELT $ 89))
                                      (SPADCALL 811 (QREFELT $ 89))
                                      (QREFELT $ 109))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "quo"
                            (SPADCALL " quo " 810 (SPADCALL 811 (QREFELT $ 89))
                                      (SPADCALL 811 (QREFELT $ 89))
                                      (QREFELT $ 109))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "exquo"
                            (SPADCALL " exquo " 810
                                      (SPADCALL 811 (QREFELT $ 89))
                                      (SPADCALL 811 (QREFELT $ 89))
                                      (QREFELT $ 109))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "^"
                            (SPADCALL 950 (SPADCALL 960 (QREFELT $ 89))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 101))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "/"
                            (SPADCALL 910
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 108))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "OVER"
                            (SPADCALL 910
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 108))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "SLASH"
                            (SPADCALL 880 (SPADCALL 881 (QREFELT $ 89))
                                      (SPADCALL 882 (QREFELT $ 89))
                                      (QREFELT $ 110))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "ZAG" (ELT $ 112) (QREFELT $ 138))
                  (SPADCALL |oh| 2 "BINOMIAL" (ELT $ 111) (QREFELT $ 138))
                  (SPADCALL |oh| 2 "PRIME" (SPADCALL 950 (QREFELT $ 106))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "ROOT"
                            (SPADCALL 970
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (SPADCALL 850 (QREFELT $ 89))
                                      (QREFELT $ 83))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "SUB" (SPADCALL 950 (QREFELT $ 91))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "SEGMENT"
                            (SPADCALL " .. " 100 (SPADCALL 100 (QREFELT $ 89))
                                      (SPADCALL 100 (QREFELT $ 89))
                                      (QREFELT $ 109))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "TENSOR"
                            (SPADCALL " # " 850 (SPADCALL 850 (QREFELT $ 89))
                                      (SPADCALL 850 (QREFELT $ 89))
                                      (QREFELT $ 109))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "EQUATNUM"
                            (SPADCALL "\\EQUATNUM" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #4="(" #5=")"
                                                (SPADCALL #6=", "
                                                          (SPADCALL
                                                           (QREFELT $ 88))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 45))
                                                           (QREFELT $ 89))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 45))
                                                           (QREFELT $ 89))
                                                          (QREFELT $ 109))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "OVERLABEL"
                            (SPADCALL "\\OVERLABEL" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL #4# #5#
                                                (SPADCALL #6#
                                                          (SPADCALL
                                                           (QREFELT $ 88))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 45))
                                                           (QREFELT $ 89))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QREFELT $ 45))
                                                           (QREFELT $ 89))
                                                          (QREFELT $ 109))
                                                (QREFELT $ 140))
                                      (QREFELT $ 141))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "=="
                            (SPADCALL " == " 400 (SPADCALL 401 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "="
                            (SPADCALL " = " 400 (SPADCALL 400 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "~="
                            (SPADCALL " ~= " 400 (SPADCALL 400 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "<"
                            (SPADCALL " < " 400 (SPADCALL 400 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 ">"
                            (SPADCALL " > " 400 (SPADCALL 400 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "<="
                            (SPADCALL " <= " 400 (SPADCALL 400 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 ">="
                            (SPADCALL " >= " 400 (SPADCALL 400 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "and"
                            (SPADCALL " and " 300 (SPADCALL 300 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "or"
                            (SPADCALL " or " 200 (SPADCALL 200 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "LET"
                            (SPADCALL " := " 125 (SPADCALL 125 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "TAG"
                            (SPADCALL " -> " 100 (SPADCALL 100 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "+->"
                            (SPADCALL " +-> " 100 (SPADCALL 100 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "|"
                            (SPADCALL " | " 100 (SPADCALL 100 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "SIGMA" (SPADCALL 750 (QREFELT $ 54))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "PI" (SPADCALL 750 (QREFELT $ 55))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 3 "SIGMA2" (SPADCALL 750 (QREFELT $ 54))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 3 "PI2" (SPADCALL 750 (QREFELT $ 55))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 3 "INTSIGN" (SPADCALL 700 (QREFELT $ 51))
                            (QREFELT $ 138))
                  (SPADCALL |oh| 2 "INTSEP"
                            (SPADCALL "" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 109))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "+"
                            (SPADCALL " + " " - " 700
                                      (SPADCALL 700 (QREFELT $ 89))
                                      (QREFELT $ 142))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "-"
                            (SPADCALL "+" "-" 700 (SPADCALL 700 (QREFELT $ 89))
                                      (QREFELT $ 142))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "*"
                            (SPADCALL "*" 800 (SPADCALL 800 (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "AGGLST"
                            (SPADCALL ", " (SPADCALL (QREFELT $ 88))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "AGGSET"
                            (SPADCALL "; " (SPADCALL (QREFELT $ 88))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "CONCAT"
                            (SPADCALL "" (SPADCALL (QREFELT $ 88))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "CONCATB"
                            (SPADCALL " " (SPADCALL (QREFELT $ 88))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "ALTSUPERSUB" (SPADCALL 900 (QREFELT $ 99))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "SUPERSUB" (SPADCALL 900 (QREFELT $ 87))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "SC"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 45))
                                       (QREFELT $ 89))
                             (QREFELT $ 120))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "VCONCAT"
                            (SPADCALL
                             (SPADCALL (SPADCALL (QREFELT $ 45))
                                       (QREFELT $ 89))
                             (QREFELT $ 119))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "ROW"
                            (SPADCALL "  " (SPADCALL (QREFELT $ 88))
                                      (SPADCALL (SPADCALL (QREFELT $ 45))
                                                (QREFELT $ 89))
                                      (QREFELT $ 90))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "MATRIX" (SPADCALL "[" "]" (QREFELT $ 135))
                            (QREFELT $ 138))
                  (SPADCALL |oh| -1 "theMap" (ELT $ 65) (QREFELT $ 138))
                  (EXIT (PROGN (LETT #1# |oh|) (GO #7=#:G1369)))))
                #7# (EXIT #1#)))) 

(SDEFUN |FMT2D;operatorHandlers;Oh;35|
        (($
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
        (QREFELT $ 144)) 

(DECLAIM (NOTINLINE |Format2D;|)) 

(DEFUN |Format2D| ()
  (SPROG NIL
         (PROG (#1=#:G1373)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Format2D|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Format2D|
                             (LIST (CONS NIL (CONS 1 (|Format2D;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Format2D|)))))))))) 

(DEFUN |Format2D;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Format2D|))
          (LETT $ (GETREFV 146))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Format2D| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 144
                    (|FMT2D;setOperatorHandlers!| (SPADCALL (QREFELT $ 143))
                     $))
          $))) 

(MAKEPROP '|Format2D| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|OutputForm|) |FMT2D;coerce;$Of;1|
              (|OutputBox|) (0 . |empty|) (|String|)
              |FMT2D;defaultPrologue;SOb;2| |FMT2D;defaultEpilogue;SOb;3|
              (|Character|) (4 . |char|) (9 . |remove|) (15 . |box|)
              |FMT2D;formatFloat;SOb;4| |FMT2D;formatString;SOb;5|
              |FMT2D;formatSymbol;SOb;6| |FMT2D;formatFunctionSymbol;SOb;7|
              (|NonNegativeInteger|) (20 . |height|) (25 . |depth|) (|List| $)
              (30 . |vconcat|) (36 . |hconcat|) |FMT2D;parenthesize;2S2Ob;8|
              (41 . |width|) (46 . |concat|) (|Boolean|) (|OutputFormTools|)
              (51 . |atom?|) (56 . |operator|) (|Symbol|) (61 . |is_symbol?|)
              (|List| 6) (67 . |arguments|) (72 . ~=) (|Integer|) (78 . |elt|)
              (84 . |coerce|) (89 . |elt|) (95 . |One|) (99 . |One|)
              (103 . |minPrecedence|) (107 . |formatExpression|) (113 . +)
              (119 . <) (125 . |parenthesizeIf|) (|Mapping| 8 39 36)
              |FMT2D;integral;IM;11| (131 . |#|) (136 . =) |FMT2D;sum;IM;13|
              |FMT2D;product;IM;14| (142 . |string?|) (147 . |symbol?|)
              (|List| 10) (152 . |lines|) (157 . |position|) (163 . |position|)
              (|UniversalSegment| 39) (170 . SEGMENT) (176 . |elt|)
              |FMT2D;theMap;ILOb;15| (182 . |first|) (187 . |new|)
              |FMT2D;overbar;I2M;16| |FMT2D;box;2M;17| (|SingleInteger|)
              (193 . |One|) (197 . >) (203 . |Zero|) (207 . |Zero|)
              (|PositiveInteger|) (211 . |One|) (215 . -) (221 . |qcoerce|)
              (|Mapping| $ $) (226 . |pad|) (|List| 8) (234 . |concat|)
              |FMT2D;nthRoot;I3M;18| (240 . |rest|) (245 . |elt|) (251 . |max|)
              |FMT2D;scripts;IM;20| (257 . |maxPrecedence|)
              (261 . |formatExpression|) (266 . |nary|) |FMT2D;subscript;IM;21|
              (273 . |#|) (278 . |odd?|) (283 . |concat|) (289 . |empty?|)
              (294 . |first|) (299 . |rest|) (304 . |qcoerce|)
              |FMT2D;altsupersub;IM;22| (309 . +) |FMT2D;power;I3M;24|
              (315 . |string|) (320 . |#|) (325 . |elt|) (331 . ~=)
              |FMT2D;prime;IM;23| (337 . |Zero|) |FMT2D;fraction;I3M;25|
              (341 . |infix|) |FMT2D;slash;I3M;26| |FMT2D;binomial;ILOb;27|
              |FMT2D;zag;ILOb;28| (349 . |empty?|) (|List| 21) (354 . |max|)
              (359 . |zero?|) (364 . |hcenter|) (369 . |one?|)
              |FMT2D;vconcat;2M;31| |FMT2D;pile;2M;32| (|List| 81)
              (374 . |first|) (|Vector| 21) (379 . |new|) (385 . |elt|)
              (391 . |setelt!|) (398 . |empty|) (402 . |cons|)
              (408 . |reverse!|) (413 . +) (|Mapping| 21 21 21)
              (419 . |reduce|) (425 . -) (430 . |shift|) |FMT2D;matrix;2SM;33|
              (436 . |nothing|) (|OperatorHandlers| 50) (440 . |setHandler!|)
              (448 . |formatConstant|) (453 . |bracket|) (460 . |prefix|)
              (467 . |naryPlus|) (475 . |new|) '|operatorData|
              |FMT2D;operatorHandlers;Oh;35|)
           '#(|zag| 479 |vconcat| 485 |theMap| 490 |sum| 496 |subscript| 501
              |slash| 506 |scripts| 513 |product| 518 |prime| 523 |prefix| 528
              |precedence| 535 |power| 541 |pile| 548 |parenthesizeIf| 553
              |parenthesize| 559 |overbar| 566 |operatorHandlers| 572
              |numberOfPrimes| 576 |nthRoot| 581 |nothing| 588 |naryPlus| 592
              |nary| 600 |minPrecedence| 607 |maxPrecedence| 611 |matrix| 615
              |integral| 621 |infix| 626 |fraction| 634 |formatSymbol| 641
              |formatString| 646 |formatInteger| 651 |formatFunctionSymbol| 656
              |formatFloat| 661 |formatExpression| 666 |formatConstant| 682
              |defaultPrologue| 687 |defaultEpilogue| 692 |coerce| 697
              |bracket| 702 |box| 709 |binomial| 714 |binary| 720 |altsupersub|
              726)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0))
                 (CONS '#(|FormatterCategory&| NIL)
                       (CONS '#((|FormatterCategory|) (|CoercibleTo| 6))
                             (|makeByteWordVec2| 145
                                                 '(0 8 0 9 1 13 0 10 14 2 10 0
                                                   13 0 15 1 8 0 10 16 1 8 21 0
                                                   22 1 8 21 0 23 2 8 0 24 21
                                                   25 1 8 0 24 26 1 8 21 0 28 1
                                                   10 0 24 29 1 31 30 6 32 1 31
                                                   6 6 33 2 31 30 6 34 35 1 31
                                                   36 6 37 2 21 30 0 0 38 2 36
                                                   6 0 39 40 1 34 6 0 41 2 6 0
                                                   0 24 42 0 21 0 43 0 39 0 44
                                                   0 0 39 45 2 0 8 6 39 46 2 21
                                                   0 0 0 47 2 39 30 0 0 48 2 0
                                                   8 30 8 49 1 36 21 0 52 2 21
                                                   30 0 0 53 1 31 30 6 56 1 31
                                                   30 6 57 1 8 58 0 59 2 10 39
                                                   13 0 60 3 10 39 13 0 39 61 2
                                                   62 0 39 39 63 2 10 0 0 62 64
                                                   1 36 6 0 66 2 10 0 21 13 67
                                                   0 70 0 71 2 21 30 0 0 72 0
                                                   21 0 73 0 70 0 74 0 75 0 76
                                                   2 39 0 0 0 77 1 75 0 39 78 4
                                                   8 79 21 21 21 21 80 2 81 0 0
                                                   0 82 1 36 0 0 84 2 81 8 0 39
                                                   85 2 21 0 0 0 86 0 0 39 88 1
                                                   0 50 39 89 3 0 50 10 39 50
                                                   90 1 81 21 0 92 1 39 30 0 93
                                                   2 81 0 0 8 94 1 81 30 0 95 1
                                                   81 8 0 96 1 81 0 0 97 1 21 0
                                                   39 98 2 39 0 0 0 100 1 31 10
                                                   6 102 1 10 21 0 103 2 10 13
                                                   0 39 104 2 13 30 0 0 105 0
                                                   39 0 107 4 0 50 10 39 50 50
                                                   109 1 36 30 0 113 1 114 21 0
                                                   115 1 39 30 0 116 1 8 79 21
                                                   117 1 39 30 0 118 1 121 81 0
                                                   122 2 123 0 21 21 124 2 123
                                                   21 0 39 125 3 123 21 0 39 21
                                                   126 0 81 0 127 2 81 0 8 0
                                                   128 1 81 0 0 129 2 6 0 0 0
                                                   130 2 123 21 131 0 132 1 70
                                                   0 0 133 2 21 0 0 39 134 0 0
                                                   50 136 4 137 50 0 39 10 50
                                                   138 1 0 50 10 139 3 0 50 10
                                                   10 50 140 3 0 50 10 39 50
                                                   141 4 0 50 10 10 39 50 142 0
                                                   137 0 143 2 0 8 39 36 112 1
                                                   0 50 50 119 2 0 8 39 36 65 1
                                                   0 50 39 54 1 0 50 39 91 3 0
                                                   50 39 50 50 110 1 0 50 39 87
                                                   1 0 50 39 55 1 0 50 39 106 3
                                                   0 50 10 39 50 141 2 0 50 39
                                                   50 1 3 0 50 39 50 50 101 1 0
                                                   50 50 120 2 0 8 30 8 49 3 0
                                                   8 10 10 8 27 2 0 50 39 50 68
                                                   0 0 137 145 1 0 39 6 1 3 0
                                                   50 39 50 50 83 0 0 50 136 4
                                                   0 50 10 10 39 50 142 3 0 50
                                                   10 39 50 90 0 0 39 45 0 0 39
                                                   88 2 0 50 10 10 135 1 0 50
                                                   39 51 4 0 50 10 39 50 50 109
                                                   3 0 50 39 50 50 108 1 0 8 10
                                                   19 1 0 8 10 18 1 0 8 39 1 1
                                                   0 8 10 20 1 0 8 10 17 1 0 50
                                                   39 89 1 0 8 6 1 2 0 8 6 39
                                                   46 1 0 50 10 139 1 0 8 10 11
                                                   1 0 8 10 12 1 0 6 0 7 3 0 50
                                                   10 10 50 140 1 0 50 50 69 2
                                                   0 8 39 36 111 2 0 50 50 50 1
                                                   1 0 50 39 99)))))
           '|lookupComplete|)) 

(MAKEPROP '|Format2D| 'NILADIC T) 


(SDEFUN |SYMBOL;writeOMSym| ((|dev| (|OpenMathDevice|)) (|x| ($)) ($ (|Void|)))
        (COND
         ((SPADCALL |x| (QREFELT $ 18))
          (|error| "Cannot convert a scripted symbol to OpenMath"))
         ('T (SPADCALL |dev| |x| (QREFELT $ 22))))) 

(SDEFUN |SYMBOL;OMwrite;Omd$BV;2|
        ((|dev| (|OpenMathDevice|)) (|x| ($)) (|wholeObj| (|Boolean|))
         ($ (|Void|)))
        (SEQ (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 23))))
             (|SYMBOL;writeOMSym| |dev| |x| $)
             (EXIT (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 24))))))) 

(SDEFUN |SYMBOL;convert;$If;3| ((|s| ($)) ($ (|InputForm|)))
        (SPROG
         ((|d| (|InputForm|)) (G (|List| (|InputForm|))) (#1=#:G2789 NIL)
          (F NIL) (#2=#:G2788 NIL) (FF (|List| (|List| (|InputForm|))))
          (#3=#:G2787 NIL) (|e| NIL) (#4=#:G2786 NIL) (|b| #5=(|InputForm|))
          (|a| #5#) (E (|List| (|InputForm|))) (#6=#:G2785 NIL)
          (#7=#:G2784 NIL) (D (|List| (|InputForm|))) (#8=#:G2783 NIL)
          (#9=#:G2782 NIL) (C (|List| (|InputForm|))) (#10=#:G2781 NIL)
          (#11=#:G2780 NIL) (B (|List| (|InputForm|))) (#12=#:G2779 NIL)
          (#13=#:G2778 NIL) (A (|List| (|InputForm|))) (#14=#:G2777 NIL)
          (#15=#:G2776 NIL)
          (|ls|
           (|Record| (|:| |sub| (|List| (|OutputForm|)))
                     (|:| |sup| (|List| (|OutputForm|)))
                     (|:| |presup| (|List| (|OutputForm|)))
                     (|:| |presub| (|List| (|OutputForm|)))
                     (|:| |args| (|List| (|OutputForm|)))))
          (|n| (|InputForm|)))
         (SEQ (LETT |n| (SPADCALL |s| (QREFELT $ 29)))
              (COND ((NULL (SPADCALL |s| (QREFELT $ 18))) (EXIT |n|)))
              (LETT |ls| (SPADCALL |s| (QREFELT $ 31)))
              (LETT A
                    (PROGN
                     (LETT #15# NIL)
                     (SEQ (LETT |e| NIL) (LETT #14# (QVELT |ls| 0)) G190
                          (COND
                           ((OR (ATOM #14#) (PROGN (LETT |e| (CAR #14#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #15#
                                  (CONS (SPADCALL |e| (QREFELT $ 34)) #15#))))
                          (LETT #14# (CDR #14#)) (GO G190) G191
                          (EXIT (NREVERSE #15#)))))
              (LETT B
                    (PROGN
                     (LETT #13# NIL)
                     (SEQ (LETT |e| NIL) (LETT #12# (QVELT |ls| 1)) G190
                          (COND
                           ((OR (ATOM #12#) (PROGN (LETT |e| (CAR #12#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #13#
                                  (CONS (SPADCALL |e| (QREFELT $ 34)) #13#))))
                          (LETT #12# (CDR #12#)) (GO G190) G191
                          (EXIT (NREVERSE #13#)))))
              (LETT C
                    (PROGN
                     (LETT #11# NIL)
                     (SEQ (LETT |e| NIL) (LETT #10# (QVELT |ls| 2)) G190
                          (COND
                           ((OR (ATOM #10#) (PROGN (LETT |e| (CAR #10#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #11#
                                  (CONS (SPADCALL |e| (QREFELT $ 34)) #11#))))
                          (LETT #10# (CDR #10#)) (GO G190) G191
                          (EXIT (NREVERSE #11#)))))
              (LETT D
                    (PROGN
                     (LETT #9# NIL)
                     (SEQ (LETT |e| NIL) (LETT #8# (QVELT |ls| 3)) G190
                          (COND
                           ((OR (ATOM #8#) (PROGN (LETT |e| (CAR #8#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #9#
                                  (CONS (SPADCALL |e| (QREFELT $ 34)) #9#))))
                          (LETT #8# (CDR #8#)) (GO G190) G191
                          (EXIT (NREVERSE #9#)))))
              (LETT E
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |e| NIL) (LETT #6# (QVELT |ls| 4)) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |e| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #7#
                                  (CONS (SPADCALL |e| (QREFELT $ 34)) #7#))))
                          (LETT #6# (CDR #6#)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |a| (SPADCALL '|script| (QREFELT $ 35)))
              (LETT |b| (SPADCALL '|construct| (QREFELT $ 35)))
              (LETT FF
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |e| NIL) (LETT #3# (LIST A B C D E)) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |e| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #4# (CONS (CONS |b| |e|) #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT G
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT F NIL) (LETT #1# FF) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT F (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2# (CONS (SPADCALL F (QREFELT $ 37)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (LETT |d| (SPADCALL (CONS |b| G) (QREFELT $ 37)))
              (EXIT (SPADCALL (LIST |a| |n| |d|) (QREFELT $ 37)))))) 

(PUT '|SYMBOL;convert;2$;4| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |SYMBOL;convert;2$;4| ((|s| ($)) ($ (|Symbol|))) |s|) 

(SDEFUN |SYMBOL;coerce;S$;5| ((|s| (|String|)) ($ ($))) (VALUES (INTERN |s|))) 

(PUT '|SYMBOL;=;2$B;6| '|SPADreplace| 'EQUAL) 

(SDEFUN |SYMBOL;=;2$B;6| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (EQUAL |x| |y|)) 

(SDEFUN |SYMBOL;hashUpdate!;Hs$Hs;7|
        ((|hs| #1=(|HashState|)) (|s| ($)) ($ #1#))
        (HASHSTATEUPDATE |hs| (SXHASH |s|))) 

(PUT '|SYMBOL;<;2$B;8| '|SPADreplace| '(XLAM (|x| |y|) (GGREATERP |y| |x|))) 

(SDEFUN |SYMBOL;<;2$B;8| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (GGREATERP |y| |x|)) 

(SDEFUN |SYMBOL;coerce;$Of;9| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|a| (|List| (|OutputForm|))) (|x0| (|OutputForm|))
          (|sl| (|List| (|OutputForm|))) (|se| (|OutputForm|)) (#1=#:G2805 NIL)
          (|si| NIL) (|rsl| (|List| (|List| (|OutputForm|))))
          (|ss|
           (|Record| (|:| |sub| (|List| (|OutputForm|)))
                     (|:| |sup| (|List| (|OutputForm|)))
                     (|:| |presup| (|List| (|OutputForm|)))
                     (|:| |presub| (|List| (|OutputForm|)))
                     (|:| |args| (|List| (|OutputForm|))))))
         (SEQ
          (COND
           ((NULL (SPADCALL |x| (QREFELT $ 18))) (SPADCALL |x| (QREFELT $ 46)))
           ('T
            (SEQ (LETT |ss| (SPADCALL |x| (QREFELT $ 31)))
                 (LETT |rsl|
                       (LIST (QVELT |ss| 3) (QVELT |ss| 2) (QVELT |ss| 1)
                             (QVELT |ss| 0)))
                 (LETT |sl| NIL)
                 (SEQ (LETT |si| NIL) (LETT #1# |rsl|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |si| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (COND
                        ((NULL |sl|) (COND ((NULL |si|) (EXIT "iterate")))))
                       (LETT |se|
                             (COND ((EQL (LENGTH |si|) 1) (|SPADfirst| |si|))
                                   ('T (SPADCALL |si| (QREFELT $ 47)))))
                       (EXIT (LETT |sl| (CONS |se| |sl|))))
                      (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                 (LETT |x0|
                       (SPADCALL
                        (SPADCALL (SPADCALL |x| (QREFELT $ 29)) (QREFELT $ 46))
                        |sl| (QREFELT $ 48)))
                 (LETT |a| (QVELT |ss| 4))
                 (EXIT
                  (COND ((NULL |a|) |x0|)
                        ('T (SPADCALL |x0| |a| (QREFELT $ 49))))))))))) 

(SDEFUN |SYMBOL;subscript;$L$;10|
        ((|sy| ($)) (|lx| (|List| (|OutputForm|))) ($ ($)))
        (SPADCALL |sy| (LIST |lx| NIL NIL NIL NIL) (QREFELT $ 52))) 

(SDEFUN |SYMBOL;elt;$L$;11| ((|sy| ($)) (|lx| (|List| (|OutputForm|))) ($ ($)))
        (SPADCALL |sy| |lx| (QREFELT $ 54))) 

(SDEFUN |SYMBOL;superscript;$L$;12|
        ((|sy| ($)) (|lx| (|List| (|OutputForm|))) ($ ($)))
        (SPADCALL |sy| (LIST NIL |lx| NIL NIL NIL) (QREFELT $ 52))) 

(SDEFUN |SYMBOL;argscript;$L$;13|
        ((|sy| ($)) (|lx| (|List| (|OutputForm|))) ($ ($)))
        (SPADCALL |sy| (LIST NIL NIL NIL NIL |lx|) (QREFELT $ 52))) 

(SDEFUN |SYMBOL;patternMatch;$P2Pmr;14|
        ((|x| ($)) (|p| (|Pattern| #1=(|Integer|)))
         (|l| (|PatternMatchResult| #1# . #2=($)))
         ($ (|PatternMatchResult| #1# . #2#)))
        (SPADCALL |x| |p| |l| (QREFELT $ 61))) 

(SDEFUN |SYMBOL;patternMatch;$P2Pmr;15|
        ((|x| ($)) (|p| (|Pattern| #1=(|Float|)))
         (|l| (|PatternMatchResult| #1# . #2=($)))
         ($ (|PatternMatchResult| #1# . #2#)))
        (SPADCALL |x| |p| |l| (QREFELT $ 67))) 

(SDEFUN |SYMBOL;convert;$P;16| ((|x| ($)) ($ (|Pattern| (|Float|))))
        (SPADCALL |x| (QREFELT $ 70))) 

(SDEFUN |SYMBOL;convert;$P;17| ((|x| ($)) ($ (|Pattern| (|Integer|))))
        (SPADCALL |x| (QREFELT $ 72))) 

(SDEFUN |SYMBOL;syprefix|
        ((|sc|
          (|Record| (|:| |sub| (|List| (|OutputForm|)))
                    (|:| |sup| (|List| (|OutputForm|)))
                    (|:| |presup| (|List| (|OutputForm|)))
                    (|:| |presub| (|List| (|OutputForm|)))
                    (|:| |args| (|List| (|OutputForm|)))))
         ($ (|String|)))
        (SPROG
         ((#1=#:G2820 NIL) (|n| NIL) (#2=#:G2819 NIL)
          (|ns| (|List| (|Integer|))))
         (SEQ
          (LETT |ns|
                (LIST (LENGTH (QVELT |sc| 0)) (LENGTH (QVELT |sc| 1))
                      (LENGTH (QVELT |sc| 2)) (LENGTH (QVELT |sc| 3))))
          (EXIT
           (SPADCALL
            (CONS
             (STRCONC (QREFELT $ 26)
                      (|SYMBOL;istring| (LENGTH (QVELT |sc| 4)) $))
             (PROGN
              (LETT #2# NIL)
              (SEQ (LETT |n| NIL) (LETT #1# |ns|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |n| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (LETT #2# (CONS (|SYMBOL;istring| |n| $) #2#))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))
            (QREFELT $ 74)))))) 

(SDEFUN |SYMBOL;syscripts|
        ((|sc|
          (|Record| (|:| |sub| (|List| (|OutputForm|)))
                    (|:| |sup| (|List| (|OutputForm|)))
                    (|:| |presup| (|List| (|OutputForm|)))
                    (|:| |presub| #1=(|List| (|OutputForm|)))
                    (|:| |args| (|List| (|OutputForm|)))))
         ($ (|List| (|OutputForm|))))
        (SPROG ((|all| #1#))
               (SEQ (LETT |all| (QVELT |sc| 3))
                    (LETT |all| (SPADCALL (QVELT |sc| 2) |all| (QREFELT $ 75)))
                    (LETT |all| (SPADCALL (QVELT |sc| 1) |all| (QREFELT $ 75)))
                    (LETT |all| (SPADCALL (QVELT |sc| 0) |all| (QREFELT $ 75)))
                    (EXIT (SPADCALL |all| (QVELT |sc| 4) (QREFELT $ 75)))))) 

(SDEFUN |SYMBOL;script;$L$;20|
        ((|sy| ($)) (|ls| (|List| (|List| (|OutputForm|)))) ($ ($)))
        (SPROG
         ((|sc|
           (|Record| (|:| |sub| (|List| (|OutputForm|)))
                     (|:| |sup| (|List| (|OutputForm|)))
                     (|:| |presup| (|List| (|OutputForm|)))
                     (|:| |presub| (|List| (|OutputForm|)))
                     (|:| |args| (|List| (|OutputForm|))))))
         (SEQ (LETT |sc| (VECTOR NIL NIL NIL NIL NIL))
              (COND
               ((NULL (NULL |ls|))
                (SEQ (QSETVELT |sc| 0 (|SPADfirst| |ls|))
                     (EXIT (LETT |ls| (CDR |ls|))))))
              (COND
               ((NULL (NULL |ls|))
                (SEQ (QSETVELT |sc| 1 (|SPADfirst| |ls|))
                     (EXIT (LETT |ls| (CDR |ls|))))))
              (COND
               ((NULL (NULL |ls|))
                (SEQ (QSETVELT |sc| 2 (|SPADfirst| |ls|))
                     (EXIT (LETT |ls| (CDR |ls|))))))
              (COND
               ((NULL (NULL |ls|))
                (SEQ (QSETVELT |sc| 3 (|SPADfirst| |ls|))
                     (EXIT (LETT |ls| (CDR |ls|))))))
              (COND
               ((NULL (NULL |ls|))
                (SEQ (QSETVELT |sc| 4 (|SPADfirst| |ls|))
                     (EXIT (LETT |ls| (CDR |ls|))))))
              (EXIT (SPADCALL |sy| |sc| (QREFELT $ 76)))))) 

(SDEFUN |SYMBOL;script;$R$;21|
        ((|sy| ($))
         (|sc|
          (|Record| (|:| |sub| (|List| (|OutputForm|)))
                    (|:| |sup| (|List| (|OutputForm|)))
                    (|:| |presup| (|List| (|OutputForm|)))
                    (|:| |presub| (|List| (|OutputForm|)))
                    (|:| |args| (|List| (|OutputForm|)))))
         ($ ($)))
        (COND
         ((SPADCALL |sy| (QREFELT $ 18))
          (|error| "Cannot add scripts to a scripted symbol"))
         ('T
          (CONS
           (SPADCALL
            (SPADCALL
             (STRCONC (|SYMBOL;syprefix| |sc| $)
                      (SPADCALL (SPADCALL |sy| (QREFELT $ 29)) (QREFELT $ 77)))
             (QREFELT $ 41))
            (QREFELT $ 50))
           (|SYMBOL;syscripts| |sc| $))))) 

(SDEFUN |SYMBOL;string;$S;22| ((|e| ($)) ($ (|String|)))
        (COND ((NULL (SPADCALL |e| (QREFELT $ 18))) (PNAME |e|))
              ('T (|error| "Cannot form string from non-atomic symbols.")))) 

(SDEFUN |SYMBOL;latex;$S;23| ((|e| ($)) ($ (|String|)))
        (SPROG
         ((|s| (|String|)) (|sc| (|String|)) (|lo| (|List| (|OutputForm|)))
          (|ss|
           (|Record| (|:| |sub| (|List| (|OutputForm|)))
                     (|:| |sup| (|List| (|OutputForm|)))
                     (|:| |presup| (|List| (|OutputForm|)))
                     (|:| |presub| (|List| (|OutputForm|)))
                     (|:| |args| (|List| (|OutputForm|))))))
         (SEQ (LETT |s| (PNAME (SPADCALL |e| (QREFELT $ 29))))
              (COND
               ((> (QCSIZE |s|) 1)
                (COND
                 ((SPADCALL (SPADCALL |s| 1 (QREFELT $ 80))
                            (|STR_to_CHAR| "\\") (QREFELT $ 81))
                  (LETT |s| (STRCONC "\\mbox{\\it " (STRCONC |s| "}")))))))
              (COND ((NULL (SPADCALL |e| (QREFELT $ 18))) (EXIT |s|)))
              (LETT |ss| (SPADCALL |e| (QREFELT $ 31)))
              (LETT |lo| (QVELT |ss| 0))
              (COND
               ((NULL (NULL |lo|))
                (SEQ (LETT |sc| "_{")
                     (SEQ G190 (COND ((NULL (NULL (NULL |lo|))) (GO G191)))
                          (SEQ
                           (LETT |sc|
                                 (STRCONC |sc|
                                          (SPADCALL (|SPADfirst| |lo|)
                                                    (QREFELT $ 82))))
                           (LETT |lo| (CDR |lo|))
                           (EXIT
                            (COND
                             ((NULL (NULL |lo|))
                              (LETT |sc| (STRCONC |sc| ", "))))))
                          NIL (GO G190) G191 (EXIT NIL))
                     (LETT |sc| (STRCONC |sc| "}"))
                     (EXIT (LETT |s| (STRCONC |s| |sc|))))))
              (LETT |lo| (QVELT |ss| 1))
              (COND
               ((NULL (NULL |lo|))
                (SEQ (LETT |sc| "^{")
                     (SEQ G190 (COND ((NULL (NULL (NULL |lo|))) (GO G191)))
                          (SEQ
                           (LETT |sc|
                                 (STRCONC |sc|
                                          (SPADCALL (|SPADfirst| |lo|)
                                                    (QREFELT $ 82))))
                           (LETT |lo| (CDR |lo|))
                           (EXIT
                            (COND
                             ((NULL (NULL |lo|))
                              (LETT |sc| (STRCONC |sc| ", "))))))
                          NIL (GO G190) G191 (EXIT NIL))
                     (LETT |sc| (STRCONC |sc| "}"))
                     (EXIT (LETT |s| (STRCONC |s| |sc|))))))
              (LETT |lo| (QVELT |ss| 2))
              (COND
               ((NULL (NULL |lo|))
                (SEQ (LETT |sc| "{}^{")
                     (SEQ G190 (COND ((NULL (NULL (NULL |lo|))) (GO G191)))
                          (SEQ
                           (LETT |sc|
                                 (STRCONC |sc|
                                          (SPADCALL (|SPADfirst| |lo|)
                                                    (QREFELT $ 82))))
                           (LETT |lo| (CDR |lo|))
                           (EXIT
                            (COND
                             ((NULL (NULL |lo|))
                              (LETT |sc| (STRCONC |sc| ", "))))))
                          NIL (GO G190) G191 (EXIT NIL))
                     (LETT |sc| (STRCONC |sc| "}"))
                     (EXIT (LETT |s| (STRCONC |sc| |s|))))))
              (LETT |lo| (QVELT |ss| 3))
              (COND
               ((NULL (NULL |lo|))
                (SEQ (LETT |sc| "{}_{")
                     (SEQ G190 (COND ((NULL (NULL (NULL |lo|))) (GO G191)))
                          (SEQ
                           (LETT |sc|
                                 (STRCONC |sc|
                                          (SPADCALL (|SPADfirst| |lo|)
                                                    (QREFELT $ 82))))
                           (LETT |lo| (CDR |lo|))
                           (EXIT
                            (COND
                             ((NULL (NULL |lo|))
                              (LETT |sc| (STRCONC |sc| ", "))))))
                          NIL (GO G190) G191 (EXIT NIL))
                     (LETT |sc| (STRCONC |sc| "}"))
                     (EXIT (LETT |s| (STRCONC |sc| |s|))))))
              (LETT |lo| (QVELT |ss| 4))
              (COND
               ((NULL (NULL |lo|))
                (SEQ (LETT |sc| "\\left( {")
                     (SEQ G190 (COND ((NULL (NULL (NULL |lo|))) (GO G191)))
                          (SEQ
                           (LETT |sc|
                                 (STRCONC |sc|
                                          (SPADCALL (|SPADfirst| |lo|)
                                                    (QREFELT $ 82))))
                           (LETT |lo| (CDR |lo|))
                           (EXIT
                            (COND
                             ((NULL (NULL |lo|))
                              (LETT |sc| (STRCONC |sc| ", "))))))
                          NIL (GO G190) G191 (EXIT NIL))
                     (LETT |sc| (STRCONC |sc| "} \\right)"))
                     (EXIT (LETT |s| (STRCONC |s| |sc|))))))
              (EXIT |s|)))) 

(SDEFUN |SYMBOL;anyRadix| ((|n| (|Integer|)) (|s| (|String|)) ($ (|String|)))
        (SPROG
         ((#1=#:G2886 NIL) (|ns| (|String|))
          (|qr|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |ns| "")
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (LETT |qr| (DIVIDE2 |n| (QCSIZE |s|)))
                           (LETT |n| (QCAR |qr|))
                           (LETT |ns|
                                 (SPADCALL
                                  (SPADCALL |s|
                                            (+ (QCDR |qr|)
                                               (SPADCALL |s| (QREFELT $ 84)))
                                            (QREFELT $ 80))
                                  |ns| (QREFELT $ 85)))
                           (EXIT
                            (COND
                             ((ZEROP |n|)
                              (PROGN (LETT #1# |ns|) (GO #2=#:G2885))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #2# (EXIT #1#)))) 

(SDEFUN |SYMBOL;new;$;25| (($ ($)))
        (SPROG ((|sym| (|String|)))
               (SEQ
                (LETT |sym| (|SYMBOL;anyRadix| (QREFELT $ 6) (QREFELT $ 15) $))
                (SETELT $ 6 (+ (QREFELT $ 6) 1))
                (EXIT (SPADCALL (STRCONC "%" |sym|) (QREFELT $ 41)))))) 

(SDEFUN |SYMBOL;new;2$;26| ((|x| ($)) ($ ($)))
        (SPROG
         ((|xx| (|String|)) (|n| (|Integer|))
          (|u| (|Union| (|Integer|) "failed")))
         (SEQ
          (LETT |n|
                (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 9) (QREFELT $ 88)))
                     (EXIT
                      (COND ((QEQCAR |u| 1) 0) (#1='T (+ (QCDR |u|) 1))))))
          (SPADCALL (QREFELT $ 9) |x| |n| (QREFELT $ 89))
          (LETT |xx|
                (COND
                 ((NULL (SPADCALL |x| (QREFELT $ 18)))
                  (SPADCALL |x| (QREFELT $ 77)))
                 ('T (SPADCALL (SPADCALL |x| (QREFELT $ 29)) (QREFELT $ 77)))))
          (LETT |xx| (STRCONC "%" |xx|))
          (LETT |xx|
                (COND
                 ((>=
                   (SPADCALL
                    (SPADCALL |xx| (SPADCALL |xx| (QREFELT $ 90))
                              (QREFELT $ 80))
                    (QREFELT $ 14) (QREFELT $ 91))
                   (SPADCALL (QREFELT $ 14) (QREFELT $ 84)))
                  (STRCONC |xx| (|SYMBOL;anyRadix| |n| (QREFELT $ 16) $)))
                 (#1#
                  (STRCONC |xx| (|SYMBOL;anyRadix| |n| (QREFELT $ 14) $)))))
          (COND
           ((NULL (SPADCALL |x| (QREFELT $ 18)))
            (EXIT (SPADCALL |xx| (QREFELT $ 41)))))
          (EXIT
           (SPADCALL (SPADCALL |xx| (QREFELT $ 41))
                     (SPADCALL |x| (QREFELT $ 31)) (QREFELT $ 76)))))) 

(SDEFUN |SYMBOL;resetNew;V;27| (($ (|Void|)))
        (SPROG ((#1=#:G2909 NIL) (|k| NIL))
               (SEQ (SETELT $ 6 0)
                    (SEQ (LETT |k| NIL)
                         (LETT #1# (SPADCALL (QREFELT $ 9) (QREFELT $ 94)))
                         G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT (SPADCALL |k| (QREFELT $ 9) (QREFELT $ 95))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL (QREFELT $ 96)))))) 

(SDEFUN |SYMBOL;scripted?;$B;28| ((|sy| ($)) ($ (|Boolean|)))
        (NULL (ATOM |sy|))) 

(PUT '|SYMBOL;of_list| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |SYMBOL;of_list| ((|x| ($)) ($ (|List| (|OutputForm|)))) |x|) 

(SDEFUN |SYMBOL;name;2$;30| ((|sy| ($)) ($ ($)))
        (SPROG ((|si| (|NonNegativeInteger|)) (|str| (|String|)))
               (SEQ
                (COND ((NULL (SPADCALL |sy| (QREFELT $ 18))) |sy|)
                      ('T
                       (SEQ
                        (LETT |str|
                              (SPADCALL (|SPADfirst| (|SYMBOL;of_list| |sy| $))
                                        (QREFELT $ 77)))
                        (LETT |si| (+ (+ (QREFELT $ 27) 4) 2))
                        (EXIT
                         (SPADCALL
                          (SPADCALL |str|
                                    (SPADCALL |si| (QCSIZE |str|)
                                              (QREFELT $ 99))
                                    (QREFELT $ 100))
                          (QREFELT $ 41))))))))) 

(SDEFUN |SYMBOL;scripts;$R;31|
        ((|sy| ($))
         ($
          (|Record| (|:| |sub| (|List| (|OutputForm|)))
                    (|:| |sup| (|List| (|OutputForm|)))
                    (|:| |presup| (|List| (|OutputForm|)))
                    (|:| |presub| (|List| (|OutputForm|)))
                    (|:| |args| (|List| (|OutputForm|))))))
        (SPROG
         ((|allscripts| (|List| (|OutputForm|))) (|i| NIL) (#1=#:G2927 NIL)
          (|n| NIL) (|m| (|Integer|))
          (|nscripts| (|List| (|NonNegativeInteger|))) (#2=#:G2918 NIL)
          (#3=#:G2926 NIL) (|j| NIL) (|str| (|String|))
          (|lscripts| (|List| (|List| (|OutputForm|)))))
         (SEQ
          (COND
           ((NULL (SPADCALL |sy| (QREFELT $ 18))) (VECTOR NIL NIL NIL NIL NIL))
           ('T
            (SEQ (LETT |nscripts| (LIST 0 0 0 0 0))
                 (LETT |lscripts| (LIST NIL NIL NIL NIL NIL))
                 (LETT |str|
                       (SPADCALL (|SPADfirst| (|SYMBOL;of_list| |sy| $))
                                 (QREFELT $ 77)))
                 (LETT |m| (PROGN |nscripts| 1))
                 (SEQ (LETT |j| (+ (QREFELT $ 27) 1))
                      (LETT #3# (+ (+ (QREFELT $ 27) 4) 1)) (LETT |i| |m|) G190
                      (COND ((> |j| #3#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SPADCALL |nscripts| |i|
                                  (PROG1
                                      (LETT #2#
                                            (-
                                             (SPADCALL |str| |j|
                                                       (QREFELT $ 80))
                                             (QREFELT $ 28)))
                                    (|check_subtype2| (>= #2# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #2#))
                                  (QREFELT $ 103))))
                      (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1))))
                      (GO G190) G191 (EXIT NIL))
                 (LETT |nscripts|
                       (SPADCALL (CDR |nscripts|) (|SPADfirst| |nscripts|)
                                 (QREFELT $ 104)))
                 (LETT |allscripts| (CDR (|SYMBOL;of_list| |sy| $)))
                 (LETT |m| (PROGN |lscripts| 1))
                 (SEQ (LETT |n| NIL) (LETT #1# |nscripts|) (LETT |i| |m|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |n| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((< (LENGTH |allscripts|) |n|)
                          (|error| "Improper script count in symbol"))
                         ('T
                          (SEQ
                           (SPADCALL |lscripts| |i|
                                     (SPADCALL |allscripts| |n|
                                               (QREFELT $ 105))
                                     (QREFELT $ 106))
                           (EXIT
                            (LETT |allscripts|
                                  (SPADCALL |allscripts| |n|
                                            (QREFELT $ 107)))))))))
                      (LETT |i| (PROG1 (+ |i| 1) (LETT #1# (CDR #1#))))
                      (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (VECTOR (SPADCALL |lscripts| |m| (QREFELT $ 108))
                          (SPADCALL |lscripts| (+ |m| 1) (QREFELT $ 108))
                          (SPADCALL |lscripts| (+ |m| 2) (QREFELT $ 108))
                          (SPADCALL |lscripts| (+ |m| 3) (QREFELT $ 108))
                          (SPADCALL |lscripts| (+ |m| 4)
                                    (QREFELT $ 108)))))))))) 

(SDEFUN |SYMBOL;istring| ((|n| (|Integer|)) ($ (|String|)))
        (COND ((> |n| 9) (|error| "Can have at most 9 scripts of each kind"))
              ('T (QAREF1 (QREFELT $ 13) (+ |n| (PROGN (QREFELT $ 13) 0)))))) 

(SDEFUN |SYMBOL;sample;$;33| (($ ($))) (SPADCALL "aSymbol" (QREFELT $ 41))) 

(DECLAIM (NOTINLINE |Symbol;|)) 

(DEFUN |Symbol| ()
  (SPROG NIL
         (PROG (#1=#:G2931)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Symbol|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Symbol|
                             (LIST (CONS NIL (CONS 1 (|Symbol;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Symbol|)))))))))) 

(DEFUN |Symbol;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Symbol|))
          (LETT $ (GETREFV 111))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Symbol| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 0)
          (QSETREFV $ 9 (SPADCALL (QREFELT $ 8)))
          (QSETREFV $ 13
                    (SPADCALL (LIST #1="0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
                              (QREFELT $ 12)))
          (QSETREFV $ 14 "0123456789")
          (QSETREFV $ 15 "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
          (QSETREFV $ 16 "abcdefghijklmnopqrstuvwxyz")
          (QSETREFV $ 26 "*")
          (QSETREFV $ 27 (QCSIZE (QREFELT $ 26)))
          (QSETREFV $ 28 (|STR_to_CHAR| #1#))
          $))) 

(MAKEPROP '|Symbol| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|count| (|AssociationList| $$ 79)
              (0 . |empty|) '|xcount| (|List| 40) (|PrimitiveArray| 40)
              (4 . |construct|) '|istrings| '|nums| 'ALPHAS '|alphas|
              (|Boolean|) |SYMBOL;scripted?;$B;28| (|Void|) (|Symbol|)
              (|OpenMathDevice|) (9 . |OMputVariable|) (15 . |OMputObject|)
              (20 . |OMputEndObject|) |SYMBOL;OMwrite;Omd$BV;2| '|hd| '|lhd|
              '|ord0| |SYMBOL;name;2$;30|
              (|Record| (|:| |sub| 53) (|:| |sup| 53) (|:| |presup| 53)
                        (|:| |presub| 53) (|:| |args| 53))
              |SYMBOL;scripts;$R;31| (|InputForm|) (|OutputForm|)
              (25 . |convert|) (30 . |convert|) (|List| $) (35 . |convert|)
              |SYMBOL;convert;$If;3| |SYMBOL;convert;2$;4| (|String|)
              |SYMBOL;coerce;S$;5| |SYMBOL;=;2$B;6| (|HashState|)
              |SYMBOL;hashUpdate!;Hs$Hs;7| |SYMBOL;<;2$B;8| (40 . |outputForm|)
              (45 . |commaSeparate|) (50 . |scripts|) (56 . |prefix|)
              |SYMBOL;coerce;$Of;9| (|List| 53) |SYMBOL;script;$L$;20|
              (|List| 33) |SYMBOL;subscript;$L$;10| |SYMBOL;elt;$L$;11|
              |SYMBOL;superscript;$L$;12| |SYMBOL;argscript;$L$;13|
              (|PatternMatchResult| 79 20) (|Pattern| 79)
              (|PatternMatchSymbol| 79) (62 . |patternMatch|)
              (|PatternMatchResult| 79 $) |SYMBOL;patternMatch;$P2Pmr;14|
              (|PatternMatchResult| (|Float|) 20) (|Pattern| (|Float|))
              (|PatternMatchSymbol| (|Float|)) (69 . |patternMatch|)
              (|PatternMatchResult| (|Float|) $)
              |SYMBOL;patternMatch;$P2Pmr;15| (76 . |coerce|)
              |SYMBOL;convert;$P;16| (81 . |coerce|) |SYMBOL;convert;$P;17|
              (86 . |concat|) (91 . |concat|) |SYMBOL;script;$R$;21|
              |SYMBOL;string;$S;22| (|Character|) (|Integer|) (97 . |elt|)
              (103 . ~=) (109 . |latex|) |SYMBOL;latex;$S;23|
              (114 . |minIndex|) (119 . |concat|) |SYMBOL;new;$;25|
              (|Union| 79 '"failed") (125 . |search|) (131 . |setelt!|)
              (138 . |maxIndex|) (143 . |position|) |SYMBOL;new;2$;26|
              (|List| $$) (149 . |keys|) (154 . |remove!|) (160 . |void|)
              |SYMBOL;resetNew;V;27| (|UniversalSegment| 79) (164 . SEGMENT)
              (170 . |elt|) (|NonNegativeInteger|) (|List| 101)
              (176 . |setelt!|) (183 . |concat|) (189 . |first|)
              (195 . |setelt!|) (202 . |rest|) (208 . |elt|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |SYMBOL;sample;$;33|) $))
              (|SingleInteger|))
           '#(~= 214 |superscript| 220 |subscript| 226 |string| 232 |smaller?|
              237 |scripts| 243 |scripted?| 248 |script| 253 |sample| 265
              |resetNew| 269 |patternMatch| 273 |new| 287 |name| 296 |min| 301
              |max| 307 |latex| 313 |hashUpdate!| 318 |hash| 324 |elt| 329
              |convert| 335 |coerce| 355 |argscript| 365 |OMwrite| 371 >= 395 >
              401 = 407 <= 413 < 419)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|OrderedSet&| NIL NIL NIL |SetCategory&| |BasicType&| NIL
                     NIL NIL |OpenMath&| NIL |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedSet|) (|Comparable|)
                      (|PatternMatchable| (|Float|)) (|PatternMatchable| 79)
                      (|SetCategory|) (|BasicType|) (|ConvertibleTo| 65)
                      (|ConvertibleTo| 59) (|ConvertibleTo| 20) (|OpenMath|)
                      (|ConvertibleTo| 32) (|PartialOrder|) (|CoercibleTo| 33))
                   (|makeByteWordVec2| 110
                                       '(0 7 0 8 1 11 0 10 12 2 21 19 0 20 22 1
                                         21 19 0 23 1 21 19 0 24 1 33 32 0 34 1
                                         32 0 20 35 1 32 0 36 37 1 33 0 20 46 1
                                         33 0 36 47 2 33 0 0 36 48 2 33 0 0 36
                                         49 3 60 58 20 59 58 61 3 66 64 20 65
                                         64 67 1 65 0 20 70 1 59 0 20 72 1 40 0
                                         36 74 2 53 0 0 0 75 2 40 78 0 79 80 2
                                         78 17 0 0 81 1 33 40 0 82 1 40 79 0 84
                                         2 40 0 78 0 85 2 7 87 2 0 88 3 7 79 0
                                         2 79 89 1 40 79 0 90 2 40 79 78 0 91 1
                                         7 93 0 94 2 7 87 2 0 95 0 19 0 96 2 98
                                         0 79 79 99 2 40 0 0 98 100 3 102 101 0
                                         79 101 103 2 102 0 0 101 104 2 53 0 0
                                         101 105 3 51 53 0 79 53 106 2 53 0 0
                                         101 107 2 51 53 0 79 108 2 0 17 0 0 1
                                         2 0 0 0 53 56 2 0 0 0 53 54 1 0 40 0
                                         77 2 0 17 0 0 1 1 0 30 0 31 1 0 17 0
                                         18 2 0 0 0 30 76 2 0 0 0 51 52 0 0 0
                                         109 0 0 19 97 3 0 68 0 65 68 69 3 0 62
                                         0 59 62 63 1 0 0 0 92 0 0 0 86 1 0 0 0
                                         29 2 0 0 0 0 1 2 0 0 0 0 1 1 0 40 0 83
                                         2 0 43 43 0 44 1 0 110 0 1 2 0 0 0 53
                                         55 1 0 59 0 73 1 0 65 0 71 1 0 20 0 39
                                         1 0 32 0 38 1 0 0 40 41 1 0 33 0 50 2
                                         0 0 0 53 57 3 0 19 21 0 17 25 2 0 40 0
                                         17 1 2 0 19 21 0 1 1 0 40 0 1 2 0 17 0
                                         0 1 2 0 17 0 0 1 2 0 17 0 0 42 2 0 17
                                         0 0 1 2 0 17 0 0 45)))))
           '|lookupComplete|)) 

(MAKEPROP '|Symbol| 'NILADIC T) 

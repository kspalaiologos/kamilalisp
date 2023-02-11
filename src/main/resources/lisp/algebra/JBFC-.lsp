
(SDEFUN |JBFC-;X;PiS;1| ((|i| (|PositiveInteger|)) ($ (S)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 11)) (QREFELT $ 12))) 

(SDEFUN |JBFC-;U;PiS;2| ((|i| (|PositiveInteger|)) ($ (S)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 14)) (QREFELT $ 12))) 

(SDEFUN |JBFC-;P;PiLS;3|
        ((|i| (|PositiveInteger|)) (|l| (|List| (|NonNegativeInteger|)))
         ($ (S)))
        (SPADCALL (SPADCALL |i| |l| (QREFELT $ 17)) (QREFELT $ 12))) 

(SDEFUN |JBFC-;X;S;4| (($ (S)))
        (SPADCALL (SPADCALL (QREFELT $ 19)) (QREFELT $ 12))) 

(SDEFUN |JBFC-;U;S;5| (($ (S)))
        (SPADCALL (SPADCALL (QREFELT $ 21)) (QREFELT $ 12))) 

(SDEFUN |JBFC-;P;LS;6| ((|l| (|List| (|NonNegativeInteger|))) ($ (S)))
        (SPADCALL (SPADCALL |l| (QREFELT $ 23)) (QREFELT $ 12))) 

(SDEFUN |JBFC-;P;PiNniS;7|
        ((|i| (|PositiveInteger|)) (|l| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL (SPADCALL |i| |l| (QREFELT $ 26)) (QREFELT $ 12))) 

(SDEFUN |JBFC-;P;NniS;8| ((|i| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL (SPADCALL |i| (QREFELT $ 28)) (QREFELT $ 12))) 

(SDEFUN |JBFC-;setNotation;SV;9| ((|s| (|Symbol|)) ($ (|Void|)))
        (SPADCALL |s| (QREFELT $ 31))) 

(SDEFUN |JBFC-;getNotation;S;10| (($ (|Symbol|))) (SPADCALL (QREFELT $ 34))) 

(SDEFUN |JBFC-;numIndVar;Pi;11| (($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 9))) 

(SDEFUN |JBFC-;numDepVar;Pi;12| (($ (|PositiveInteger|)))
        (SPADCALL (QREFELT $ 37))) 

(SDEFUN |JBFC-;gcd;3S;13| ((|f1| (S)) (|f2| (S)) ($ (S))) (|spadConstant| $ 39)) 

(SDEFUN |JBFC-;retractIfCan;SU;14| ((|f| (S)) ($ (|Union| JB "failed")))
        (SPROG ((|jv| (JB)) (JV (|List| JB)))
               (SEQ (LETT JV (SPADCALL |f| (QREFELT $ 42)))
                    (EXIT
                     (COND
                      ((EQL (LENGTH JV) 1)
                       (SEQ (LETT |jv| (|SPADfirst| JV))
                            (EXIT
                             (COND
                              ((SPADCALL (SPADCALL |f| |jv| (QREFELT $ 43))
                                         (QREFELT $ 45))
                               (CONS 0 |jv|))
                              (#1='T (CONS 1 "failed"))))))
                      (#1# (CONS 1 "failed"))))))) 

(SDEFUN |JBFC-;const?;SB;15| ((|Phi| (S)) ($ (|Boolean|)))
        (SPROG ((JV (|List| JB)))
               (SEQ (LETT JV (SPADCALL |Phi| (QREFELT $ 42)))
                    (EXIT
                     (COND ((NULL JV) 'T) ((> (LENGTH JV) 1) NIL)
                           ('T
                            (SPADCALL (|SPADfirst| JV) (|spadConstant| $ 48)
                                      (QREFELT $ 49)))))))) 

(SDEFUN |JBFC-;order;SNni;16| ((|Phi| (S)) ($ (|NonNegativeInteger|)))
        (SPADCALL (SPADCALL |Phi| (QREFELT $ 51)) (QREFELT $ 52))) 

(SDEFUN |JBFC-;class;SNni;17| ((|Phi| (S)) ($ (|NonNegativeInteger|)))
        (SPADCALL (SPADCALL |Phi| (QREFELT $ 51)) (QREFELT $ 54))) 

(SDEFUN |JBFC-;leadingDer;SJB;18| ((|fun| (S)) ($ (JB)))
        (SPROG ((JV (|List| JB)))
               (SEQ (LETT JV (SPADCALL |fun| (QREFELT $ 42)))
                    (EXIT
                     (COND ((NULL JV) (|spadConstant| $ 48))
                           ('T (|SPADfirst| JV))))))) 

(SDEFUN |JBFC-;freeOf?;SJBB;19| ((|fun| (S)) (|jv| (JB)) ($ (|Boolean|)))
        (NULL (SPADCALL |jv| (SPADCALL |fun| (QREFELT $ 42)) (QREFELT $ 57)))) 

(PUT '|JBFC-;characteristic;Nni;20| '|SPADreplace| '(XLAM NIL 0)) 

(SDEFUN |JBFC-;characteristic;Nni;20| (($ (|NonNegativeInteger|))) 0) 

(SDEFUN |JBFC-;dSubst;SJB2S;21| ((|f| (S)) (|jv| (JB)) (|exp| (S)) ($ (S)))
        (SPROG
         ((|nf| (S)) (|dexp| (S)) (|d| (|List| (|NonNegativeInteger|)))
          (#1=#:G805 NIL) (|jvar| NIL) (#2=#:G806 NIL) (|JVar| (|List| JB))
          (|of| (S)))
         (SEQ (LETT |of| (|spadConstant| $ 60)) (LETT |nf| |f|)
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |nf| |of| (QREFELT $ 61))) (GO G191)))
                   (SEQ (LETT |of| |nf|)
                        (LETT |JVar| (SPADCALL |of| (QREFELT $ 42)))
                        (EXIT
                         (SEQ (LETT #2# NIL) (LETT |jvar| NIL)
                              (LETT #1# |JVar|) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |jvar| (CAR #1#)) NIL) #2#)
                                (GO G191)))
                              (SEQ
                               (LETT |d| (SPADCALL |jvar| |jv| (QREFELT $ 62)))
                               (EXIT
                                (COND
                                 ((NULL (NULL |d|))
                                  (SEQ
                                   (LETT |dexp|
                                         (SPADCALL |exp| |d| (QREFELT $ 63)))
                                   (EXIT
                                    (LETT |nf|
                                          (SPADCALL |nf| |jvar| |dexp|
                                                    (QREFELT $ 64)))))))))
                              (LETT #1#
                                    (PROG1 (CDR #1#)
                                      (LETT #2#
                                            (SPADCALL |jvar| |jv|
                                                      (QREFELT $ 65)))))
                              (GO G190) G191 (EXIT NIL))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |nf|)))) 

(SDEFUN |JBFC-;dimension;LSem2Nni;22|
        ((|sys| (|List| S)) (|jm| (|SparseEchelonMatrix| JB S))
         (|q| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G807 NIL))
               (PROG1
                   (LETT #1# (- (SPADCALL |q| (QREFELT $ 67)) (LENGTH |sys|)))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))) 

(SDEFUN |JBFC-;orderDim;LSem2Nni;23|
        ((|sys| (|List| S)) (|jm| (|SparseEchelonMatrix| JB S))
         (|q| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G809 NIL))
               (PROG1
                   (LETT #1# (- (SPADCALL |q| (QREFELT $ 71)) (LENGTH |sys|)))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))) 

(SDEFUN |JBFC-;jacobiMatrix;LSem;24|
        ((|funs| (|List| S)) ($ (|SparseEchelonMatrix| JB S)))
        (SPROG ((#1=#:G815 NIL) (|fun| NIL) (#2=#:G814 NIL))
               (SEQ
                (SPADCALL |funs|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |fun| NIL) (LETT #1# |funs|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |fun| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |fun| (QREFELT $ 42))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 75))))) 

(SDEFUN |JBFC-;jacobiMatrix;LLSem;25|
        ((|funs| (|List| S)) (|varlist| (|List| (|List| JB)))
         ($ (|SparseEchelonMatrix| JB S)))
        (SPROG
         ((|inds| (|List| JB)) (|ents| (|List| S)) (|df| (S)) (#1=#:G836 NIL)
          (|jv| NIL) (#2=#:G834 NIL) (|f| NIL) (#3=#:G835 NIL) (|vars| NIL)
          (|i| NIL) (JM (|SparseEchelonMatrix| JB S)) (|JvList| (|List| JB))
          (#4=#:G833 NIL))
         (SEQ (LETT |JvList| (|SPADfirst| |varlist|))
              (SEQ (LETT |vars| NIL) (LETT #4# (CDR |varlist|)) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |vars| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |JvList|
                           (SPADCALL
                            (SPADCALL (ELT $ 77) |JvList| |vars|
                                      (QREFELT $ 79))
                            (QREFELT $ 80)))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (LETT JM (SPADCALL |JvList| (LENGTH |funs|) (QREFELT $ 83)))
              (SEQ (LETT |i| 1) (LETT |vars| NIL) (LETT #3# |varlist|)
                   (LETT |f| NIL) (LETT #2# |funs|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL) (ATOM #3#)
                         (PROGN (LETT |vars| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ents| NIL) (LETT |inds| NIL)
                        (SEQ (LETT |jv| NIL) (LETT #1# |vars|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |jv| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |df| (SPADCALL |f| |jv| (QREFELT $ 43)))
                              (EXIT
                               (COND
                                ((OR (QREFELT $ 73)
                                     (NULL (SPADCALL |df| (QREFELT $ 84))))
                                 (SEQ (LETT |ents| (CONS |df| |ents|))
                                      (EXIT
                                       (LETT |inds| (CONS |jv| |inds|))))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (SPADCALL JM |i| (NREVERSE |inds|) (NREVERSE |ents|)
                                   (QREFELT $ 86))))
                   (LETT #2#
                         (PROG1 (CDR #2#)
                           (LETT #3#
                                 (PROG1 (CDR #3#) (LETT |i| (|inc_SI| |i|))))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT JM)))) 

(SDEFUN |JBFC-;symbol;LSem;26|
        ((|funs| (|List| S)) ($ (|SparseEchelonMatrix| JB S)))
        (SPROG
         ((|inds| (|List| JB)) (|ents| (|List| S)) (|df| (S)) (#1=#:G885 NIL)
          (|jv| NIL) (#2=#:G883 NIL) (|f| NIL) (#3=#:G884 NIL) (|i| NIL)
          (|symb| (|SparseEchelonMatrix| JB S)) (|oJV| (|List| (|List| JB)))
          (|allJV| (|List| JB)) (|ojl| (|List| JB)) (|jl| (|List| JB))
          (#4=#:G882 NIL) (|ord| (|NonNegativeInteger|))
          (|ol| (|List| (|NonNegativeInteger|))) (#5=#:G881 NIL)
          (#6=#:G880 NIL) (JVL (|List| (|List| JB))) (#7=#:G879 NIL)
          (|fun| NIL) (#8=#:G878 NIL))
         (SEQ
          (LETT JVL
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |fun| NIL) (LETT #7# |funs|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |fun| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #8# (CONS (SPADCALL |fun| (QREFELT $ 42)) #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (LETT |ol|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT #5# JVL) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |jl| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6#
                              (CONS
                               (SPADCALL (|SPADfirst| |jl|) (QREFELT $ 52))
                               #6#))))
                      (LETT #5# (CDR #5#)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (LETT |ord| (SPADCALL (ELT $ 90) |ol| 0 (QREFELT $ 92)))
          (LETT |oJV| NIL) (LETT |allJV| NIL)
          (SEQ (LETT #4# JVL) G190
               (COND
                ((OR (ATOM #4#) (PROGN (LETT |jl| (CAR #4#)) NIL)) (GO G191)))
               (SEQ (LETT |ojl| NIL)
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((NULL |jl|) NIL)
                                  ('T
                                   (NULL
                                    (<
                                     (SPADCALL (|SPADfirst| |jl|)
                                               (QREFELT $ 52))
                                     |ord|)))))
                           (GO G191)))
                         (SEQ (LETT |ojl| (CONS (|SPADfirst| |jl|) |ojl|))
                              (EXIT (LETT |jl| (CDR |jl|))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (LETT |ojl| (NREVERSE |ojl|))
                    (LETT |oJV| (CONS |ojl| |oJV|))
                    (EXIT
                     (LETT |allJV|
                           (SPADCALL
                            (SPADCALL (ELT $ 77) |allJV| |ojl| (QREFELT $ 79))
                            (QREFELT $ 80)))))
               (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
          (LETT |oJV| (NREVERSE |oJV|))
          (LETT |symb| (SPADCALL |allJV| (LENGTH |funs|) (QREFELT $ 83)))
          (SEQ (LETT |i| 1) (LETT #3# |oJV|) (LETT |f| NIL) (LETT #2# |funs|)
               G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL) (ATOM #3#)
                     (PROGN (LETT |ojl| (CAR #3#)) NIL))
                 (GO G191)))
               (SEQ (LETT |ents| NIL) (LETT |inds| NIL)
                    (SEQ (LETT |jv| NIL) (LETT #1# |ojl|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |jv| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |df| (SPADCALL |f| |jv| (QREFELT $ 43)))
                              (EXIT
                               (COND
                                ((OR (QREFELT $ 73)
                                     (NULL (SPADCALL |df| (QREFELT $ 84))))
                                 (SEQ (LETT |ents| (CONS |df| |ents|))
                                      (EXIT
                                       (LETT |inds| (CONS |jv| |inds|))))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (SPADCALL |symb| |i| (NREVERSE |inds|) (NREVERSE |ents|)
                               (QREFELT $ 86))))
               (LETT #2#
                     (PROG1 (CDR #2#)
                       (LETT #3# (PROG1 (CDR #3#) (LETT |i| (|inc_SI| |i|))))))
               (GO G190) G191 (EXIT NIL))
          (EXIT |symb|)))) 

(SDEFUN |JBFC-;extractSymbol;2Sem;27|
        ((|jm| (|SparseEchelonMatrix| JB S)) ($ (|SparseEchelonMatrix| JB S)))
        (SPROG ((|inds| (|List| JB)) (|o| (|NonNegativeInteger|)))
               (SEQ (LETT |inds| (SPADCALL |jm| (QREFELT $ 94)))
                    (LETT |o| (SPADCALL (|SPADfirst| |inds|) (QREFELT $ 52)))
                    (LETT |inds| (CDR |inds|))
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND ((NULL |inds|) NIL)
                                  ('T
                                   (EQL
                                    (SPADCALL (|SPADfirst| |inds|)
                                              (QREFELT $ 52))
                                    |o|))))
                           (GO G191)))
                         (SEQ (EXIT (LETT |inds| (CDR |inds|)))) NIL (GO G190)
                         G191 (EXIT NIL))
                    (EXIT
                     (COND ((NULL |inds|) |jm|)
                           ('T
                            (QCAR
                             (SPADCALL |jm| (|SPADfirst| |inds|)
                                       (QREFELT $ 96))))))))) 

(SDEFUN |JBFC-;formalDiff;LPiL;28|
        ((|Sys| (|List| S)) (|i| (|PositiveInteger|)) ($ (|List| S)))
        (SPROG ((JM (|SparseEchelonMatrix| JB S)))
               (SEQ (LETT JM (SPADCALL |Sys| (QREFELT $ 98)))
                    (EXIT (QCAR (SPADCALL |Sys| |i| JM (QREFELT $ 100))))))) 

(SDEFUN |JBFC-;formalDiff;SPiS;29|
        ((|Eq| (S)) (|i| (|PositiveInteger|)) ($ (S)))
        (|SPADfirst| (SPADCALL (LIST |Eq|) |i| (QREFELT $ 102)))) 

(SDEFUN |JBFC-;formalDiff;SLS;30|
        ((|f| (S)) (|mu| (|List| (|NonNegativeInteger|))) ($ (S)))
        (SPROG
         ((JV (|List| JB)) (|df| (S))
          (|tmp| (|Record| (|:| |DPhi| S) (|:| |JVars| (|List| JB))))
          (#1=#:G899 NIL) (|jm| (|SparseEchelonMatrix| JB S)) (#2=#:G908 NIL)
          (|k| NIL) (#3=#:G906 NIL) (|i| NIL) (#4=#:G907 NIL) (|j| NIL))
         (SEQ (LETT JV (SPADCALL |f| (QREFELT $ 42))) (LETT |df| |f|)
              (SEQ (LETT |j| NIL) (LETT #4# |mu|) (LETT |i| 1)
                   (LETT #3# (QREFELT $ 10)) G190
                   (COND
                    ((OR (|greater_SI| |i| #3#) (ATOM #4#)
                         (PROGN (LETT |j| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |k| 1) (LETT #2# |j|) G190
                          (COND ((|greater_SI| |k| #2#) (GO G191)))
                          (SEQ
                           (LETT |jm|
                                 (SPADCALL (LIST |df|) (LIST JV)
                                           (QREFELT $ 75)))
                           (LETT |tmp|
                                 (SPADCALL |df|
                                           (PROG1 (LETT #1# |i|)
                                             (|check_subtype2| (> #1# 0)
                                                               '(|PositiveInteger|)
                                                               '(|NonNegativeInteger|)
                                                               #1#))
                                           |jm| (QREFELT $ 105)))
                           (LETT |df| (QCAR |tmp|))
                           (EXIT (LETT JV (QCDR |tmp|))))
                          (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #4# (CDR #4#))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |df|)))) 

(SDEFUN |JBFC-;formalDiff2;LPiSemR;31|
        ((|Sys| (|List| S)) (|i| (|PositiveInteger|))
         (JM (|SparseEchelonMatrix| JB S))
         ($
          (|Record| (|:| |DSys| (|List| S))
                    (|:| |JVars| (|List| (|List| JB))))))
        (SPROG
         ((LJV (|List| (|List| JB))) (JV (|List| JB)) (|LRes| (|List| S))
          (|res| (S)) (|djv| (|Union| JB "0")) (#1=#:G943 NIL) (|df| NIL)
          (#2=#:G944 NIL) (|jv| NIL)
          (|r|
           (|Record| (|:| |Indices| (|List| JB)) (|:| |Entries| (|List| S))))
          (#3=#:G942 NIL) (|l| NIL) (#4=#:G941 NIL) (|eq| NIL) (#5=#:G940 NIL)
          (#6=#:G939 NIL) (#7=#:G938 NIL) (|inds| (|List| JB)))
         (SEQ (LETT |inds| (SPADCALL JM (QREFELT $ 94)))
              (EXIT
               (COND
                ((NULL |inds|)
                 (CONS
                  (PROGN
                   (LETT #7# NIL)
                   (SEQ (LETT |eq| NIL) (LETT #6# |Sys|) G190
                        (COND
                         ((OR (ATOM #6#) (PROGN (LETT |eq| (CAR #6#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT (LETT #7# (CONS (|spadConstant| $ 60) #7#))))
                        (LETT #6# (CDR #6#)) (GO G190) G191
                        (EXIT (NREVERSE #7#))))
                  (PROGN
                   (LETT #5# NIL)
                   (SEQ (LETT |eq| NIL) (LETT #4# |Sys|) G190
                        (COND
                         ((OR (ATOM #4#) (PROGN (LETT |eq| (CAR #4#)) NIL))
                          (GO G191)))
                        (SEQ (EXIT (LETT #5# (CONS NIL #5#))))
                        (LETT #4# (CDR #4#)) (GO G190) G191
                        (EXIT (NREVERSE #5#))))))
                ('T
                 (SEQ (LETT |LRes| NIL) (LETT LJV NIL)
                      (SEQ (LETT |l| 1)
                           (LETT #3# (SPADCALL JM (QREFELT $ 107))) G190
                           (COND ((|greater_SI| |l| #3#) (GO G191)))
                           (SEQ (LETT |r| (SPADCALL JM |l| (QREFELT $ 109)))
                                (LETT |res| (|spadConstant| $ 60))
                                (LETT JV NIL)
                                (SEQ (LETT |jv| NIL)
                                     (LETT #2# (REVERSE (QCAR |r|)))
                                     (LETT |df| NIL)
                                     (LETT #1# (REVERSE (QCDR |r|))) G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |df| (CAR #1#)) NIL)
                                           (ATOM #2#)
                                           (PROGN (LETT |jv| (CAR #2#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((OR (QREFELT $ 73)
                                             (NULL
                                              (SPADCALL |df| (QREFELT $ 84))))
                                         (SEQ
                                          (LETT |djv|
                                                (SPADCALL |jv| |i|
                                                          (QREFELT $ 111)))
                                          (EXIT
                                           (COND
                                            ((QEQCAR |djv| 1)
                                             (LETT JV (CONS |jv| JV)))
                                            ((SPADCALL |djv|
                                                       (CONS 0
                                                             (|spadConstant| $
                                                                             48))
                                                       (QREFELT $ 113))
                                             (SEQ
                                              (LETT |res|
                                                    (SPADCALL |res| |df|
                                                              (QREFELT $ 114)))
                                              (EXIT (LETT JV (CONS |jv| JV)))))
                                            ('T
                                             (SEQ
                                              (LETT |res|
                                                    (SPADCALL |res|
                                                              (SPADCALL |df|
                                                                        (SPADCALL
                                                                         (QCDR
                                                                          |djv|)
                                                                         (QREFELT
                                                                          $
                                                                          12))
                                                                        (QREFELT
                                                                         $
                                                                         115))
                                                              (QREFELT $ 114)))
                                              (EXIT
                                               (LETT JV
                                                     (CONS (QCDR |djv|)
                                                           (CONS |jv|
                                                                 JV)))))))))))))
                                     (LETT #1#
                                           (PROG1 (CDR #1#)
                                             (LETT #2# (CDR #2#))))
                                     (GO G190) G191 (EXIT NIL))
                                (LETT |LRes| (CONS |res| |LRes|))
                                (LETT JV
                                      (SPADCALL (ELT $ 77)
                                                (SPADCALL JV (QREFELT $ 80))
                                                (QREFELT $ 116)))
                                (EXIT (LETT LJV (CONS JV LJV))))
                           (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
                      (EXIT (CONS (NREVERSE |LRes|) (NREVERSE LJV)))))))))) 

(SDEFUN |JBFC-;formalDiff2;SPiSemR;32|
        ((|Eq| (S)) (|i| (|PositiveInteger|)) (JM (|SparseEchelonMatrix| JB S))
         ($ (|Record| (|:| |DPhi| S) (|:| |JVars| (|List| JB)))))
        (SPROG
         ((|tmp|
           (|Record| (|:| |DSys| (|List| S))
                     (|:| |JVars| (|List| (|List| JB))))))
         (SEQ (LETT |tmp| (SPADCALL (LIST |Eq|) |i| JM (QREFELT $ 100)))
              (EXIT
               (CONS (|SPADfirst| (QCAR |tmp|)) (|SPADfirst| (QCDR |tmp|))))))) 

(SDEFUN |JBFC-;greater|
        ((|r1|
          (|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                    (|:| |Dep| (|List| (|NonNegativeInteger|))) (|:| |Fun| S)))
         (|r2|
          (|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                    (|:| |Dep| (|List| (|NonNegativeInteger|))) (|:| |Fun| S)))
         ($ (|Boolean|)))
        (SPADCALL (QVELT |r1| 0) (QVELT |r2| 0) (QREFELT $ 77))) 

(SDEFUN |JBFC-;sortLD;2L;34| ((|sys| (|List| S)) ($ (|List| S)))
        (SPROG
         ((#1=#:G966 NIL) (|l| NIL) (#2=#:G965 NIL)
          (|sl|
           (|List|
            (|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                      (|:| |Dep| (|List| (|NonNegativeInteger|)))
                      (|:| |Fun| S))))
          (#3=#:G964 NIL) (|f| NIL) (#4=#:G963 NIL))
         (SEQ
          (LETT |sl|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |f| NIL) (LETT #3# |sys|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |f| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS
                               (VECTOR (SPADCALL |f| (QREFELT $ 51)) NIL
                                       (LIST 1) |f|)
                               #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |sl|
                (SPADCALL (CONS (|function| |JBFC-;greater|) $) |sl|
                          (QREFELT $ 122)))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |l| NIL) (LETT #1# |sl|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |l| (CAR #1#)) NIL)) (GO G191)))
                 (SEQ (EXIT (LETT #2# (CONS (QVELT |l| 3) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |JBFC-;simpLD|
        ((|l|
          (|List|
           (|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                     (|:| |Dep| (|List| (|NonNegativeInteger|)))
                     (|:| |Fun| S))))
         ($
          (|List|
           (|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                     (|:| |Dep| (|List| (|NonNegativeInteger|)))
                     (|:| |Fun| S)))))
        (SPROG
         ((|newL|
           (|List|
            (|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                      (|:| |Dep| (|List| (|NonNegativeInteger|)))
                      (|:| |Fun| S))))
          (|newld| (JB)) (#1=#:G1020 NIL) (|eq| NIL) (#2=#:G1021 NIL)
          (|sjv| (JB)) (#3=#:G1018 NIL) (#4=#:G1019 NIL)
          (|lJV| (|List| #5=(|List| JB))) (|minlen| #6=(|NonNegativeInteger|))
          (|sj| #5#)
          (|seq|
           (|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                     (|:| |Dep| (|List| (|NonNegativeInteger|)))
                     (|:| |Fun| S)))
          (|len| #6#) (JV #5#) (#7=#:G1017 NIL) (|neweq| (S)) (#8=#:G976 NIL)
          (#9=#:G1016 NIL) (|solvable?| (|Boolean|))
          (|s| (|Union| S #10="failed")) (#11=#:G1014 NIL) (#12=#:G1015 NIL)
          (|eqLD|
           (|List|
            #13=(|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                          (|:| |Dep| (|List| (|NonNegativeInteger|)))
                          (|:| |Fun| S))))
          (|fl| #13#) (|cur| #13#))
         (SEQ
          (COND ((< (LENGTH |l|) 2) |l|)
                (#14='T
                 (SEQ (LETT |cur| (|SPADfirst| |l|)) (LETT |l| (CDR |l|))
                      (EXIT
                       (COND
                        ((SPADCALL (QVELT |cur| 0) (QVELT (|SPADfirst| |l|) 0)
                                   (QREFELT $ 124))
                         (CONS |cur| (|JBFC-;simpLD| |l| $)))
                        (#14#
                         (SEQ (LETT |eqLD| (LIST |cur|))
                              (SEQ G190
                                   (COND
                                    ((NULL
                                      (COND ((NULL |l|) NIL)
                                            ('T
                                             (SPADCALL (QVELT |cur| 0)
                                                       (QVELT
                                                        (LETT |fl|
                                                              (|SPADfirst|
                                                               |l|))
                                                        0)
                                                       (QREFELT $ 49)))))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((QVELT |fl| 1)
                                       (|error| #15="cannot simplify"))
                                      ('T
                                       (SEQ (LETT |eqLD| (CONS |fl| |eqLD|))
                                            (EXIT (LETT |l| (CDR |l|))))))))
                                   NIL (GO G190) G191 (EXIT NIL))
                              (LETT |solvable?| NIL)
                              (SEQ (LETT #12# NIL) (LETT |eq| NIL)
                                   (LETT #11# |eqLD|) G190
                                   (COND
                                    ((OR (ATOM #11#)
                                         (PROGN (LETT |eq| (CAR #11#)) NIL)
                                         #12#)
                                     (GO G191)))
                                   (SEQ
                                    (LETT |s|
                                          (SPADCALL (QVELT |eq| 3)
                                                    (QVELT |cur| 0)
                                                    (QREFELT $ 126)))
                                    (LETT |solvable?| (QEQCAR |s| 0))
                                    (EXIT (LETT |seq| |eq|)))
                                   (LETT #11#
                                         (PROG1 (CDR #11#)
                                           (LETT #12# |solvable?|)))
                                   (GO G190) G191 (EXIT NIL))
                              (LETT |newL| NIL)
                              (COND
                               (|solvable?|
                                (SEQ (LETT |eq| NIL) (LETT #9# |eqLD|) G190
                                     (COND
                                      ((OR (ATOM #9#)
                                           (PROGN (LETT |eq| (CAR #9#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((SPADCALL |eq| |seq| (QREFELT $ 127))
                                         (SEQ
                                          (LETT |neweq|
                                                (SPADCALL
                                                 (SPADCALL (QVELT |eq| 3)
                                                           (QVELT |cur| 0)
                                                           (PROG2
                                                               (LETT #8# |s|)
                                                               (QCDR #8#)
                                                             (|check_union2|
                                                              (QEQCAR #8# 0)
                                                              (QREFELT $ 6)
                                                              (|Union|
                                                               (QREFELT $ 6)
                                                               #10#)
                                                              #8#))
                                                           (QREFELT $ 64))
                                                 (QREFELT $ 128)))
                                          (EXIT
                                           (COND
                                            ((NULL
                                              (SPADCALL |neweq|
                                                        (QREFELT $ 84)))
                                             (SEQ
                                              (LETT |newld|
                                                    (SPADCALL |neweq|
                                                              (QREFELT $ 51)))
                                              (EXIT
                                               (LETT |newL|
                                                     (SPADCALL
                                                      (CONS
                                                       (|function|
                                                        |JBFC-;greater|)
                                                       $)
                                                      |newL|
                                                      (LIST
                                                       (VECTOR |newld| NIL
                                                               (SPADCALL
                                                                (QVELT |eq| 2)
                                                                (QVELT |seq| 2)
                                                                (QREFELT $
                                                                         129))
                                                               |neweq|))
                                                      (QREFELT $
                                                               130)))))))))))))
                                     (LETT #9# (CDR #9#)) (GO G190) G191
                                     (EXIT NIL)))
                               (#14#
                                (SEQ (LETT |seq| (|SPADfirst| |eqLD|))
                                     (LETT |sj|
                                           (SPADCALL (QVELT |seq| 3)
                                                     (QREFELT $ 42)))
                                     (LETT |minlen| (LENGTH |sj|))
                                     (LETT |lJV| (LIST |sj|))
                                     (SEQ (LETT |eq| NIL)
                                          (LETT #7# (CDR |eqLD|)) G190
                                          (COND
                                           ((OR (ATOM #7#)
                                                (PROGN
                                                 (LETT |eq| (CAR #7#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (LETT JV
                                                 (SPADCALL (QVELT |eq| 3)
                                                           (QREFELT $ 42)))
                                           (LETT |len| (LENGTH JV))
                                           (LETT |lJV| (CONS JV |lJV|))
                                           (EXIT
                                            (COND
                                             ((< |len| |minlen|)
                                              (SEQ (LETT |seq| |eq|)
                                                   (LETT |sj| JV)
                                                   (EXIT
                                                    (LETT |minlen| |len|)))))))
                                          (LETT #7# (CDR #7#)) (GO G190) G191
                                          (EXIT NIL))
                                     (LETT |lJV| (NREVERSE |lJV|))
                                     (EXIT
                                      (COND
                                       ((EQL |minlen| 1)
                                        (SEQ (LETT #4# |lJV|) (LETT |eq| NIL)
                                             (LETT #3# |eqLD|) G190
                                             (COND
                                              ((OR (ATOM #3#)
                                                   (PROGN
                                                    (LETT |eq| (CAR #3#))
                                                    NIL)
                                                   (ATOM #4#)
                                                   (PROGN
                                                    (LETT JV (CAR #4#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((SPADCALL |eq| |seq|
                                                           (QREFELT $ 127))
                                                 (COND
                                                  ((EQL (LENGTH JV) 1)
                                                   (|error| #15#))
                                                  ('T
                                                   (LETT |newL|
                                                         (SPADCALL
                                                          (CONS
                                                           (|function|
                                                            |JBFC-;greater|)
                                                           $)
                                                          |newL|
                                                          (LIST
                                                           (VECTOR
                                                            (SPADCALL JV
                                                                      (QREFELT
                                                                       $ 131))
                                                            'T (QVELT |eq| 2)
                                                            (QVELT |eq| 3)))
                                                          (QREFELT $
                                                                   130)))))))))
                                             (LETT #3#
                                                   (PROG1 (CDR #3#)
                                                     (LETT #4# (CDR #4#))))
                                             (GO G190) G191 (EXIT NIL)))
                                       (#14#
                                        (SEQ
                                         (LETT |sjv|
                                               (SPADCALL |sj| (QREFELT $ 131)))
                                         (EXIT
                                          (SEQ (LETT #2# |lJV|) (LETT |eq| NIL)
                                               (LETT #1# |eqLD|) G190
                                               (COND
                                                ((OR (ATOM #1#)
                                                     (PROGN
                                                      (LETT |eq| (CAR #1#))
                                                      NIL)
                                                     (ATOM #2#)
                                                     (PROGN
                                                      (LETT JV (CAR #2#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (COND
                                                  ((SPADCALL |eq| |seq|
                                                             (QREFELT $ 127))
                                                   (SEQ
                                                    (LETT |newld|
                                                          (SPADCALL
                                                           (SPADCALL JV
                                                                     (QREFELT $
                                                                              131))
                                                           |sjv|
                                                           (QREFELT $ 88)))
                                                    (EXIT
                                                     (LETT |newL|
                                                           (SPADCALL
                                                            (CONS
                                                             (|function|
                                                              |JBFC-;greater|)
                                                             $)
                                                            |newL|
                                                            (LIST
                                                             (VECTOR |newld| 'T
                                                                     (QVELT
                                                                      |eq| 2)
                                                                     (QVELT
                                                                      |eq| 3)))
                                                            (QREFELT $
                                                                     130)))))))))
                                               (LETT #1#
                                                     (PROG1 (CDR #1#)
                                                       (LETT #2# (CDR #2#))))
                                               (GO G190) G191
                                               (EXIT NIL))))))))))
                              (EXIT
                               (CONS |seq|
                                     (|JBFC-;simpLD|
                                      (SPADCALL
                                       (CONS (|function| |JBFC-;greater|) $)
                                       |l| |newL| (QREFELT $ 130))
                                      $))))))))))))) 

(SDEFUN |JBFC-;simplify;LSemR;36|
        ((|sys| (|List| S)) (|jm| (|SparseEchelonMatrix| JB S))
         ($
          (|Record| (|:| |Sys| (|List| S))
                    (|:| JM (|SparseEchelonMatrix| JB S))
                    (|:| |Depend|
                         (|Union| "failed"
                                  (|List| (|List| (|NonNegativeInteger|))))))))
        (SPROG
         ((|r|
           (|Record| (|:| |Indices| (|List| JB)) (|:| |Entries| (|List| S))))
          (|tmp| (|SparseEchelonMatrix| JB S)) (#1=#:G1062 NIL) (|eq| NIL)
          (#2=#:G1063 NIL) (|dep| NIL) (|i| NIL)
          (|resJM| (|SparseEchelonMatrix| JB S)) (|inds| (|List| JB))
          (|resDep| (|List| #3=(|List| (|NonNegativeInteger|))))
          (#4=#:G1061 NIL) (|l| NIL) (#5=#:G1060 NIL) (|resSys| (|List| S))
          (#6=#:G1059 NIL) (#7=#:G1058 NIL)
          (|sl|
           (|List|
            (|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|)) (|:| |Dep| #3#)
                      (|:| |Fun| S))))
          (#8=#:G1057 NIL) (|f| NIL) (#9=#:G1056 NIL) (|newSys| (|List| S))
          (|jmi| (|SparseEchelonMatrix| JB S)) (|neq| (S)) (#10=#:G1055 NIL))
         (SEQ (LETT |newSys| NIL)
              (SEQ (LETT |i| 1) (LETT |eq| NIL) (LETT #10# |sys|) G190
                   (COND
                    ((OR (ATOM #10#) (PROGN (LETT |eq| (CAR #10#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |neq| (SPADCALL |eq| (QREFELT $ 128)))
                        (COND
                         ((SPADCALL |neq| |eq| (QREFELT $ 61))
                          (SEQ
                           (LETT |jmi| (SPADCALL (LIST |neq|) (QREFELT $ 98)))
                           (EXIT
                            (SPADCALL |jm| |i|
                                      (SPADCALL |jmi| 1 (QREFELT $ 109))
                                      (QREFELT $ 132))))))
                        (EXIT (LETT |newSys| (CONS |neq| |newSys|))))
                   (LETT #10# (PROG1 (CDR #10#) (LETT |i| (|inc_SI| |i|))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |newSys| (NREVERSE |newSys|))
              (LETT |sl|
                    (PROGN
                     (LETT #9# NIL)
                     (SEQ (LETT |i| 1) (LETT |f| NIL) (LETT #8# |newSys|) G190
                          (COND
                           ((OR (ATOM #8#) (PROGN (LETT |f| (CAR #8#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #9#
                                  (CONS
                                   (VECTOR
                                    (|SPADfirst|
                                     (QCAR
                                      (SPADCALL |jm| |i| (QREFELT $ 109))))
                                    NIL (LIST |i|) |f|)
                                   #9#))))
                          (LETT #8#
                                (PROG1 (CDR #8#) (LETT |i| (|inc_SI| |i|))))
                          (GO G190) G191 (EXIT (NREVERSE #9#)))))
              (LETT |sl|
                    (|JBFC-;simpLD|
                     (SPADCALL (CONS (|function| |JBFC-;greater|) $) |sl|
                               (QREFELT $ 122))
                     $))
              (LETT |resSys|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |l| NIL) (LETT #6# |sl|) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |l| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #7# (CONS (QVELT |l| 3) #7#))))
                          (LETT #6# (CDR #6#)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |resDep|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |l| NIL) (LETT #4# |sl|) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |l| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #5# (CONS (QVELT |l| 2) #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (LETT |inds| (SPADCALL |jm| (QREFELT $ 94)))
              (LETT |resJM| (SPADCALL |inds| (LENGTH |sl|) (QREFELT $ 83)))
              (SEQ (LETT |i| 1) (LETT |dep| NIL) (LETT #2# |resDep|)
                   (LETT |eq| NIL) (LETT #1# |resSys|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |eq| (CAR #1#)) NIL)
                         (ATOM #2#) (PROGN (LETT |dep| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     ((EQL (SPADCALL |dep| (QREFELT $ 133)) 1)
                      (LETT |r|
                            (SPADCALL |jm| (|SPADfirst| |dep|)
                                      (QREFELT $ 109))))
                     ('T
                      (SEQ
                       (LETT |tmp|
                             (SPADCALL (LIST |eq|) (LIST |inds|)
                                       (QREFELT $ 75)))
                       (EXIT (LETT |r| (SPADCALL |tmp| 1 (QREFELT $ 109)))))))
                    (EXIT (SPADCALL |resJM| |i| |r| (QREFELT $ 132))))
                   (LETT #1#
                         (PROG1 (CDR #1#)
                           (LETT #2#
                                 (PROG1 (CDR #2#) (LETT |i| (|inc_SI| |i|))))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |resSys| |resJM| (CONS 1 |resDep|)))))) 

(SDEFUN |JBFC-;simpOne;2S;37| ((|f| (S)) ($ (S)))
        (SPADCALL |f| (QREFELT $ 137))) 

(SDEFUN |JBFC-;simpMod;3L;38|
        ((|sys1| (|List| S)) (|sys2| (|List| S)) ($ (|List| S)))
        (SPROG
         ((|res| (|List| S)) (|neq| (S)) (LS1 (|List| S)) (LD1 (|List| JB))
          (|ld| (JB)) (#1=#:G1096 NIL) (#2=#:G1095 NIL) (|eq1| NIL)
          (|newSys| (|List| S)) (LS (|List| S)) (LD (|List| JB))
          (|i| (|NonNegativeInteger|)) (#3=#:G1094 NIL) (|jv| NIL)
          (|ls| (|Union| S "failed")) (#4=#:G1093 NIL) (|eq2| NIL))
         (SEQ
          (COND ((OR (NULL |sys1|) (NULL |sys2|)) |sys1|)
                ('T
                 (SEQ (LETT LD NIL) (LETT LS NIL)
                      (SEQ (LETT |eq2| NIL) (LETT #4# |sys2|) G190
                           (COND
                            ((OR (ATOM #4#) (PROGN (LETT |eq2| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |ld| (SPADCALL |eq2| (QREFELT $ 51)))
                                (LETT |ls|
                                      (SPADCALL |eq2| |ld| (QREFELT $ 126)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |ls| 0)
                                   (SEQ (LETT |i| 1)
                                        (SEQ (LETT |jv| NIL) (LETT #3# LD) G190
                                             (COND
                                              ((OR (ATOM #3#)
                                                   (PROGN
                                                    (LETT |jv| (CAR #3#))
                                                    NIL)
                                                   (NULL
                                                    (SPADCALL |jv| |ld|
                                                              (QREFELT $ 77))))
                                               (GO G191)))
                                             (SEQ (EXIT (LETT |i| (+ |i| 1))))
                                             (LETT #3# (CDR #3#)) (GO G190)
                                             G191 (EXIT NIL))
                                        (LETT LD
                                              (SPADCALL |ld| LD |i|
                                                        (QREFELT $ 139)))
                                        (EXIT
                                         (LETT LS
                                               (SPADCALL (QCDR |ls|) LS |i|
                                                         (QREFELT $
                                                                  140)))))))))
                           (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                      (LETT |newSys|
                            (SPADCALL (ELT $ 128) |sys1| (QREFELT $ 142)))
                      (EXIT
                       (COND ((NULL LD) |newSys|)
                             ('T
                              (SEQ (LETT |res| NIL)
                                   (SEQ (LETT |eq1| NIL) (LETT #2# |newSys|)
                                        G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN
                                               (LETT |eq1| (CAR #2#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ (LETT |neq| |eq1|) (LETT LD1 LD)
                                             (LETT LS1 LS)
                                             (SEQ (LETT #1# NIL) G190
                                                  (COND (#1# (GO G191)))
                                                  (SEQ
                                                   (LETT |ld|
                                                         (SPADCALL |neq|
                                                                   (QREFELT $
                                                                            51)))
                                                   (SEQ G190
                                                        (COND
                                                         ((NULL
                                                           (COND
                                                            ((NULL LD1) NIL)
                                                            ('T
                                                             (SPADCALL
                                                              (|SPADfirst| LD1)
                                                              |ld|
                                                              (QREFELT $
                                                                       77)))))
                                                          (GO G191)))
                                                        (SEQ
                                                         (LETT LD1 (CDR LD1))
                                                         (EXIT
                                                          (LETT LS1
                                                                (CDR LS1))))
                                                        NIL (GO G190) G191
                                                        (EXIT NIL))
                                                   (EXIT
                                                    (COND
                                                     ((NULL (NULL LD1))
                                                      (SEQ
                                                       (LETT |neq|
                                                             (SPADCALL |neq|
                                                                       (|SPADfirst|
                                                                        LD1)
                                                                       (|SPADfirst|
                                                                        LS1)
                                                                       (QREFELT
                                                                        $ 64)))
                                                       (LETT LD1 (CDR LD1))
                                                       (EXIT
                                                        (LETT LS1
                                                              (CDR LS1))))))))
                                                  (LETT #1# (NULL LD1))
                                                  (GO G190) G191 (EXIT NIL))
                                             (COND
                                              ((SPADCALL |neq| |eq1|
                                                         (QREFELT $ 61))
                                               (LETT |neq|
                                                     (SPADCALL |neq|
                                                               (QREFELT $
                                                                        128)))))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |neq|
                                                           (QREFELT $ 84)))
                                                (LETT |res|
                                                      (CONS |neq| |res|))))))
                                        (LETT #2# (CDR #2#)) (GO G190) G191
                                        (EXIT NIL))
                                   (EXIT
                                    (SPADCALL (NREVERSE |res|)
                                              (QREFELT $ 143))))))))))))) 

(SDEFUN |JBFC-;simpMod;LSemLR;39|
        ((|sys1| (|List| S)) (|jm| (|SparseEchelonMatrix| JB S))
         (|sys2| (|List| S))
         ($
          (|Record| (|:| |Sys| (|List| S))
                    (|:| JM (|SparseEchelonMatrix| JB S))
                    (|:| |Depend|
                         (|Union| "failed"
                                  (|List| (|List| (|NonNegativeInteger|))))))))
        (SPROG
         ((#1=#:G1148 NIL) (|i| (|NonNegativeInteger|)) (#2=#:G1147 NIL)
          (|resSys| (|List| S)) (|njm| (|SparseEchelonMatrix| JB S))
          (#3=#:G1145 NIL) (#4=#:G1146 NIL) (|oeq| NIL)
          (|resJM| (|SparseEchelonMatrix| JB S)) (|res| (|List| S)) (|neq| (S))
          (LS1 (|List| S)) (LD1 (|List| JB)) (|ld| (JB)) (#5=#:G1144 NIL)
          (#6=#:G1143 NIL) (|eq1| NIL) (|newSys| (|List| S)) (LS (|List| S))
          (LD (|List| JB)) (#7=#:G1142 NIL) (|jv| NIL)
          (|ls| (|Union| S "failed")) (#8=#:G1141 NIL) (|eq2| NIL)
          (|osys| (|List| S)) (#9=#:G1140 NIL) (#10=#:G1139 NIL))
         (SEQ
          (COND
           ((OR (NULL |sys1|) (NULL |sys2|))
            (VECTOR |sys1| |jm|
                    (CONS 1
                          (PROGN
                           (LETT #10# NIL)
                           (SEQ (LETT |i| 1) (LETT #9# (LENGTH |sys1|)) G190
                                (COND ((|greater_SI| |i| #9#) (GO G191)))
                                (SEQ (EXIT (LETT #10# (CONS (LIST |i|) #10#))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT (NREVERSE #10#)))))))
           ('T
            (SEQ (LETT |osys| |sys1|) (LETT LD NIL) (LETT LS NIL)
                 (SEQ (LETT |eq2| NIL) (LETT #8# |sys2|) G190
                      (COND
                       ((OR (ATOM #8#) (PROGN (LETT |eq2| (CAR #8#)) NIL))
                        (GO G191)))
                      (SEQ (LETT |ld| (SPADCALL |eq2| (QREFELT $ 51)))
                           (LETT |ls| (SPADCALL |eq2| |ld| (QREFELT $ 126)))
                           (EXIT
                            (COND
                             ((QEQCAR |ls| 0)
                              (SEQ (LETT |i| 1)
                                   (SEQ (LETT |jv| NIL) (LETT #7# LD) G190
                                        (COND
                                         ((OR (ATOM #7#)
                                              (PROGN (LETT |jv| (CAR #7#)) NIL)
                                              (NULL
                                               (SPADCALL |jv| |ld|
                                                         (QREFELT $ 77))))
                                          (GO G191)))
                                        (SEQ (EXIT (LETT |i| (+ |i| 1))))
                                        (LETT #7# (CDR #7#)) (GO G190) G191
                                        (EXIT NIL))
                                   (LETT LD
                                         (SPADCALL |ld| LD |i|
                                                   (QREFELT $ 139)))
                                   (EXIT
                                    (LETT LS
                                          (SPADCALL (QCDR |ls|) LS |i|
                                                    (QREFELT $ 140)))))))))
                      (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                 (LETT |newSys| (SPADCALL (ELT $ 128) |sys1| (QREFELT $ 142)))
                 (LETT |res| NIL)
                 (SEQ (LETT |eq1| NIL) (LETT #6# |newSys|) G190
                      (COND
                       ((OR (ATOM #6#) (PROGN (LETT |eq1| (CAR #6#)) NIL))
                        (GO G191)))
                      (SEQ (LETT |neq| |eq1|) (LETT LD1 LD) (LETT LS1 LS)
                           (SEQ (LETT #5# NIL) G190 (COND (#5# (GO G191)))
                                (SEQ
                                 (LETT |ld| (SPADCALL |neq| (QREFELT $ 51)))
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (COND ((NULL LD1) NIL)
                                               ('T
                                                (SPADCALL (|SPADfirst| LD1)
                                                          |ld|
                                                          (QREFELT $ 77)))))
                                        (GO G191)))
                                      (SEQ (LETT LD1 (CDR LD1))
                                           (EXIT (LETT LS1 (CDR LS1))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (EXIT
                                  (COND
                                   ((NULL (NULL LD1))
                                    (SEQ
                                     (LETT |neq|
                                           (SPADCALL |neq| (|SPADfirst| LD1)
                                                     (|SPADfirst| LS1)
                                                     (QREFELT $ 64)))
                                     (LETT LD1 (CDR LD1))
                                     (EXIT (LETT LS1 (CDR LS1))))))))
                                (LETT #5# (NULL LD1)) (GO G190) G191
                                (EXIT NIL))
                           (COND
                            ((SPADCALL |neq| |eq1| (QREFELT $ 61))
                             (LETT |neq| (SPADCALL |neq| (QREFELT $ 128)))))
                           (EXIT (LETT |res| (CONS |neq| |res|))))
                      (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                 (LETT |resSys| NIL) (LETT |resJM| |jm|)
                 (SEQ (LETT |i| (LENGTH |res|)) (LETT |oeq| NIL)
                      (LETT #4# (NREVERSE |osys|)) (LETT #3# |res|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |neq| (CAR #3#)) NIL)
                            (ATOM #4#) (PROGN (LETT |oeq| (CAR #4#)) NIL)
                            (< |i| 1))
                        (GO G191)))
                      (SEQ
                       (COND
                        ((SPADCALL |neq| |oeq| (QREFELT $ 61))
                         (SEQ
                          (LETT |njm| (SPADCALL (LIST |neq|) (QREFELT $ 98)))
                          (EXIT
                           (SPADCALL |resJM| |i|
                                     (SPADCALL |njm| 1 (QREFELT $ 109))
                                     (QREFELT $ 132))))))
                       (EXIT (LETT |resSys| (CONS |neq| |resSys|))))
                      (LETT #3#
                            (PROG1 (CDR #3#)
                              (LETT #4#
                                    (PROG1 (CDR #4#) (LETT |i| (+ |i| -1))))))
                      (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (VECTOR |resSys| |resJM|
                          (CONS 1
                                (PROGN
                                 (LETT #2# NIL)
                                 (SEQ (LETT |i| 1) (LETT #1# (LENGTH |resSys|))
                                      G190
                                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                                      (SEQ
                                       (EXIT (LETT #2# (CONS (LIST |i|) #2#))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT (NREVERSE #2#))))))))))))) 

(SDEFUN |JBFC-;reduceMod;3L;40|
        ((|sys1| (|List| S)) (|sys2| (|List| S)) ($ (|List| S)))
        (SPROG
         ((|res| (|List| S)) (LS1 (|List| S)) (LD1 (|List| JB)) (|neq| (S))
          (|ld| (JB)) (#1=#:G1181 NIL) (|oeq| (S)) (|eq| (S)) (#2=#:G1180 NIL)
          (|eq1| NIL) (|newSys| (|List| S)) (LS (|List| S)) (LD (|List| JB))
          (|i| (|NonNegativeInteger|)) (#3=#:G1179 NIL) (|jv| NIL)
          (|ls| (|Union| S "failed")) (#4=#:G1178 NIL) (|eq2| NIL))
         (SEQ
          (COND ((OR (NULL |sys1|) (NULL |sys2|)) |sys1|)
                ('T
                 (SEQ (LETT LD NIL) (LETT LS NIL)
                      (SEQ (LETT |eq2| NIL) (LETT #4# |sys2|) G190
                           (COND
                            ((OR (ATOM #4#) (PROGN (LETT |eq2| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |ld| (SPADCALL |eq2| (QREFELT $ 51)))
                                (LETT |ls|
                                      (SPADCALL |eq2| |ld| (QREFELT $ 126)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |ls| 0)
                                   (SEQ (LETT |i| 1)
                                        (SEQ (LETT |jv| NIL) (LETT #3# LD) G190
                                             (COND
                                              ((OR (ATOM #3#)
                                                   (PROGN
                                                    (LETT |jv| (CAR #3#))
                                                    NIL)
                                                   (NULL
                                                    (SPADCALL |jv| |ld|
                                                              (QREFELT $ 77))))
                                               (GO G191)))
                                             (SEQ (EXIT (LETT |i| (+ |i| 1))))
                                             (LETT #3# (CDR #3#)) (GO G190)
                                             G191 (EXIT NIL))
                                        (LETT LD
                                              (SPADCALL |ld| LD |i|
                                                        (QREFELT $ 139)))
                                        (EXIT
                                         (LETT LS
                                               (SPADCALL (QCDR |ls|) LS |i|
                                                         (QREFELT $
                                                                  140)))))))))
                           (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                      (LETT |newSys|
                            (SPADCALL (ELT $ 128) |sys1| (QREFELT $ 142)))
                      (EXIT
                       (COND ((NULL LD) |newSys|)
                             ('T
                              (SEQ (LETT |res| NIL)
                                   (SEQ (LETT |eq1| NIL) (LETT #2# |newSys|)
                                        G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN
                                               (LETT |eq1| (CAR #2#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ (LETT |eq| |eq1|)
                                             (LETT |oeq| (|spadConstant| $ 60))
                                             (LETT |neq| |eq1|)
                                             (SEQ G190
                                                  (COND
                                                   ((NULL
                                                     (SPADCALL |neq| |oeq|
                                                               (QREFELT $ 61)))
                                                    (GO G191)))
                                                  (SEQ (LETT |oeq| |neq|)
                                                       (LETT LD1 LD)
                                                       (LETT LS1 LS)
                                                       (EXIT
                                                        (SEQ (LETT #1# NIL)
                                                             G190
                                                             (COND
                                                              (#1# (GO G191)))
                                                             (SEQ
                                                              (LETT |ld|
                                                                    (SPADCALL
                                                                     |neq|
                                                                     (QREFELT $
                                                                              51)))
                                                              (SEQ G190
                                                                   (COND
                                                                    ((NULL
                                                                      (COND
                                                                       ((NULL
                                                                         LD1)
                                                                        NIL)
                                                                       ('T
                                                                        (SPADCALL
                                                                         (|SPADfirst|
                                                                          LD1)
                                                                         |ld|
                                                                         (QREFELT
                                                                          $
                                                                          77)))))
                                                                     (GO
                                                                      G191)))
                                                                   (SEQ
                                                                    (LETT LD1
                                                                          (CDR
                                                                           LD1))
                                                                    (EXIT
                                                                     (LETT LS1
                                                                           (CDR
                                                                            LS1))))
                                                                   NIL
                                                                   (GO G190)
                                                                   G191
                                                                   (EXIT NIL))
                                                              (EXIT
                                                               (COND
                                                                ((NULL
                                                                  (NULL LD1))
                                                                 (SEQ
                                                                  (LETT |neq|
                                                                        (SPADCALL
                                                                         |neq|
                                                                         (|SPADfirst|
                                                                          LD1)
                                                                         (|SPADfirst|
                                                                          LS1)
                                                                         (QREFELT
                                                                          $
                                                                          146)))
                                                                  (LETT LD1
                                                                        (CDR
                                                                         LD1))
                                                                  (EXIT
                                                                   (LETT LS1
                                                                         (CDR
                                                                          LS1))))))))
                                                             (LETT #1#
                                                                   (NULL LD1))
                                                             (GO G190) G191
                                                             (EXIT NIL))))
                                                  NIL (GO G190) G191
                                                  (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |neq|
                                                           (QREFELT $ 84)))
                                                (COND
                                                 ((SPADCALL |neq| |eq|
                                                            (QREFELT $ 147))
                                                  (LETT |res|
                                                        (CONS |neq| |res|)))
                                                 ('T
                                                  (LETT |res|
                                                        (CONS
                                                         (SPADCALL |neq|
                                                                   (QREFELT $
                                                                            128))
                                                         |res|))))))))
                                        (LETT #2# (CDR #2#)) (GO G190) G191
                                        (EXIT NIL))
                                   (EXIT
                                    (SPADCALL (NREVERSE |res|)
                                              (QREFELT $ 143))))))))))))) 

(SDEFUN |JBFC-;autoReduce;2L;41| ((|sys| (|List| S)) ($ (|List| S)))
        (SPROG
         ((#1=#:G1251 NIL) (#2=#:G1250 NIL)
          (|tmp1|
           (|List|
            #3=(|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                         (|:| |Dep| (|List| (|NonNegativeInteger|)))
                         (|:| |Fun| S))))
          (|tmp2| (|List| #3#)) (#4=#:G1249 NIL) (#5=#:G1248 NIL)
          (#6=#:G1247 NIL) (|eq| NIL) (#7=#:G1246 NIL) (|nl| (|List| S))
          (|ol| (|List| S)) (|seq| (S)) (#8=#:G1245 NIL) (#9=#:G1244 NIL)
          (|nsl| (|List| S)) (#10=#:G1243 NIL) (#11=#:G1242 NIL)
          (|sl| #12=(|List| #3#)) (|ic| (S))
          (|tmp|
           (|List|
            (|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                      (|:| |Dep| (|List| (|NonNegativeInteger|)))
                      (|:| |Fun| S))))
          (|d| (|List| (|NonNegativeInteger|))) (#13=#:G1241 NIL)
          (#14=#:G1239 NIL)
          (|rec|
           #15=(|Record| (|:| LD JB) (|:| |Fake?| (|Boolean|))
                         (|:| |Dep| (|List| (|NonNegativeInteger|)))
                         (|:| |Fun| S)))
          (|osl| #12#) (|sub| #15#) (|su| (|Union| S "failed")) (|ld| (JB))
          (#16=#:G1240 NIL))
         (SEQ
          (COND ((NULL |sys|) NIL) ((EQL (LENGTH |sys|) 1) |sys|)
                ('T
                 (SEQ (LETT |nl| (SPADCALL (ELT $ 128) |sys| (QREFELT $ 142)))
                      (LETT |nsl| NIL) (LETT |sl| NIL) (LETT |osl| |sl|)
                      (SEQ G190 (COND ((NULL (NULL (NULL |nl|))) (GO G191)))
                           (SEQ
                            (SEQ (LETT |eq| NIL) (LETT #16# |nl|) G190
                                 (COND
                                  ((OR (ATOM #16#)
                                       (PROGN (LETT |eq| (CAR #16#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |ld| (SPADCALL |eq| (QREFELT $ 51)))
                                  (LETT |su|
                                        (SPADCALL |eq| |ld| (QREFELT $ 126)))
                                  (EXIT
                                   (COND
                                    ((QEQCAR |su| 1)
                                     (LETT |nsl| (CONS |eq| |nsl|)))
                                    ('T
                                     (LETT |sl|
                                           (SPADCALL
                                            (CONS (|function| |JBFC-;greater|)
                                                  $)
                                            |sl|
                                            (LIST
                                             (VECTOR |ld| 'T NIL (QCDR |su|)))
                                            (QREFELT $ 149)))))))
                                 (LETT #16# (CDR #16#)) (GO G190) G191
                                 (EXIT NIL))
                            (LETT |nl| NIL) (LETT |osl| NIL)
                            (LETT |sl| (NREVERSE |sl|))
                            (SEQ G190
                                 (COND ((NULL (NULL (NULL |sl|))) (GO G191)))
                                 (SEQ (LETT |sub| (|SPADfirst| |sl|))
                                      (LETT |osl| (CONS |sub| |osl|))
                                      (LETT |sl| (CDR |sl|))
                                      (SEQ
                                       (EXIT
                                        (SEQ G190
                                             (COND
                                              ((NULL (NULL (NULL |sl|)))
                                               (GO G191)))
                                             (SEQ
                                              (LETT |rec| (|SPADfirst| |sl|))
                                              (EXIT
                                               (COND
                                                ((SPADCALL (QVELT |rec| 0)
                                                           (QVELT |sub| 0)
                                                           (QREFELT $ 77))
                                                 (PROGN
                                                  (LETT #14# 1)
                                                  (GO #17=#:G1202)))
                                                ('T
                                                 (SEQ (LETT |sl| (CDR |sl|))
                                                      (LETT |ic|
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QVELT |rec| 3)
                                                              (QVELT |sub| 3)
                                                              (QREFELT $ 150))
                                                             (QREFELT $ 128)))
                                                      (EXIT
                                                       (COND
                                                        ((NULL
                                                          (SPADCALL |ic|
                                                                    (QREFELT $
                                                                             84)))
                                                         (LETT |nl|
                                                               (CONS |ic|
                                                                     |nl|))))))))))
                                             NIL (GO G190) G191 (EXIT NIL)))
                                       #17# (EXIT #14#))
                                      (LETT |tmp| NIL)
                                      (SEQ (LETT #13# |sl|) G190
                                           (COND
                                            ((OR (ATOM #13#)
                                                 (PROGN
                                                  (LETT |rec| (CAR #13#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (LETT |d|
                                                  (SPADCALL (QVELT |rec| 0)
                                                            (QVELT |sub| 0)
                                                            (QREFELT $ 62)))
                                            (EXIT
                                             (COND
                                              ((NULL |d|)
                                               (SEQ
                                                (LETT |seq|
                                                      (SPADCALL (QVELT |rec| 3)
                                                                (QVELT |sub| 0)
                                                                (QVELT |sub| 3)
                                                                (QREFELT $
                                                                         146)))
                                                (EXIT
                                                 (LETT |tmp|
                                                       (CONS
                                                        (VECTOR (QVELT |rec| 0)
                                                                'T NIL |seq|)
                                                        |tmp|)))))
                                              ('T
                                               (SEQ
                                                (LETT |ic|
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (QVELT |sub| 3) |d|
                                                         (QREFELT $ 63))
                                                        (QVELT |rec| 3)
                                                        (QREFELT $ 150))
                                                       (QVELT |sub| 0)
                                                       (QVELT |sub| 3)
                                                       (QREFELT $ 146)))
                                                (LETT |ic|
                                                      (SPADCALL |ic|
                                                                (QREFELT $
                                                                         128)))
                                                (EXIT
                                                 (COND
                                                  ((NULL
                                                    (SPADCALL |ic|
                                                              (QREFELT $ 84)))
                                                   (LETT |nl|
                                                         (CONS |ic|
                                                               |nl|))))))))))
                                           (LETT #13# (CDR #13#)) (GO G190)
                                           G191 (EXIT NIL))
                                      (EXIT (LETT |sl| (NREVERSE |tmp|))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (LETT |sl| |osl|) (LETT |ol| NIL)
                            (SEQ (LETT |eq| NIL) (LETT #11# |nsl|) G190
                                 (COND
                                  ((OR (ATOM #11#)
                                       (PROGN (LETT |eq| (CAR #11#)) NIL))
                                   (GO G191)))
                                 (SEQ (LETT |seq| |eq|)
                                      (SEQ (LETT #10# |sl|) G190
                                           (COND
                                            ((OR (ATOM #10#)
                                                 (PROGN
                                                  (LETT |sub| (CAR #10#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT |seq|
                                                   (SPADCALL |seq|
                                                             (QVELT |sub| 0)
                                                             (QVELT |sub| 3)
                                                             (QREFELT $
                                                                      146)))))
                                           (LETT #10# (CDR #10#)) (GO G190)
                                           G191 (EXIT NIL))
                                      (EXIT
                                       (COND
                                        ((SPADCALL |seq| |eq| (QREFELT $ 147))
                                         (LETT |ol| (CONS |eq| |ol|)))
                                        ((NULL (SPADCALL |seq| (QREFELT $ 84)))
                                         (LETT |nl|
                                               (CONS
                                                (SPADCALL |seq|
                                                          (QREFELT $ 128))
                                                |nl|))))))
                                 (LETT #11# (CDR #11#)) (GO G190) G191
                                 (EXIT NIL))
                            (LETT |nsl| |ol|) (LETT |ol| NIL)
                            (SEQ (LETT |eq| NIL) (LETT #9# |nl|) G190
                                 (COND
                                  ((OR (ATOM #9#)
                                       (PROGN (LETT |eq| (CAR #9#)) NIL))
                                   (GO G191)))
                                 (SEQ (LETT |seq| |eq|)
                                      (SEQ (LETT #8# |sl|) G190
                                           (COND
                                            ((OR (ATOM #8#)
                                                 (PROGN
                                                  (LETT |sub| (CAR #8#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT |seq|
                                                   (SPADCALL |seq|
                                                             (QVELT |sub| 0)
                                                             (QVELT |sub| 3)
                                                             (QREFELT $
                                                                      146)))))
                                           (LETT #8# (CDR #8#)) (GO G190) G191
                                           (EXIT NIL))
                                      (EXIT
                                       (COND
                                        ((NULL (SPADCALL |seq| (QREFELT $ 84)))
                                         (LETT |ol|
                                               (CONS
                                                (SPADCALL |seq|
                                                          (QREFELT $ 128))
                                                |ol|))))))
                                 (LETT #9# (CDR #9#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT (LETT |nl| |ol|)))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |tmp1|
                            (PROGN
                             (LETT #7# NIL)
                             (SEQ (LETT |eq| NIL) (LETT #6# |nsl|) G190
                                  (COND
                                   ((OR (ATOM #6#)
                                        (PROGN (LETT |eq| (CAR #6#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #7#
                                          (CONS
                                           (VECTOR
                                            (SPADCALL |eq| (QREFELT $ 51)) 'T
                                            NIL |eq|)
                                           #7#))))
                                  (LETT #6# (CDR #6#)) (GO G190) G191
                                  (EXIT (NREVERSE #7#)))))
                      (LETT |tmp2|
                            (PROGN
                             (LETT #5# NIL)
                             (SEQ (LETT #4# |sl|) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |rec| (CAR #4#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #5#
                                          (CONS
                                           (VECTOR (QVELT |rec| 0) 'T NIL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL (QVELT |rec| 0)
                                                               (QREFELT $ 12))
                                                     (QVELT |rec| 3)
                                                     (QREFELT $ 150))
                                                    (QREFELT $ 128)))
                                           #5#))))
                                  (LETT #4# (CDR #4#)) (GO G190) G191
                                  (EXIT (NREVERSE #5#)))))
                      (LETT |tmp1|
                            (SPADCALL (CONS (|function| |JBFC-;greater|) $)
                                      (SPADCALL |tmp1| |tmp2| (QREFELT $ 151))
                                      (QREFELT $ 122)))
                      (EXIT
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT #1# |tmp1|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |rec| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ (EXIT (LETT #2# (CONS (QVELT |rec| 3) #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))))) 

(DECLAIM (NOTINLINE |JetBundleFunctionCategory&;|)) 

(DEFUN |JetBundleFunctionCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|JetBundleFunctionCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 153))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
          (QSETREFV $ 73 (|HasCategory| |#1| '(|lazyRepresentation|)))
          $))) 

(MAKEPROP '|JetBundleFunctionCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|PositiveInteger|) (0 . |numIndVar|) '|nn| (4 . X)
              (9 . |coerce|) |JBFC-;X;PiS;1| (14 . U) |JBFC-;U;PiS;2|
              (|List| 25) (19 . P) |JBFC-;P;PiLS;3| (25 . X) |JBFC-;X;S;4|
              (29 . U) |JBFC-;U;S;5| (33 . P) |JBFC-;P;LS;6|
              (|NonNegativeInteger|) (38 . P) |JBFC-;P;PiNniS;7| (44 . P)
              |JBFC-;P;NniS;8| (|Symbol|) (49 . |setNotation|) (|Void|)
              |JBFC-;setNotation;SV;9| (54 . |getNotation|)
              |JBFC-;getNotation;S;10| |JBFC-;numIndVar;Pi;11|
              (58 . |numDepVar|) |JBFC-;numDepVar;Pi;12| (62 . |One|)
              |JBFC-;gcd;3S;13| (|List| 7) (66 . |jetVariables|)
              (71 . |differentiate|) (|Boolean|) (77 . |one?|)
              (|Union| 7 '"failed") |JBFC-;retractIfCan;SU;14| (82 . |One|)
              (86 . =) |JBFC-;const?;SB;15| (92 . |leadingDer|) (97 . |order|)
              |JBFC-;order;SNni;16| (102 . |class|) |JBFC-;class;SNni;17|
              |JBFC-;leadingDer;SJB;18| (107 . |member?|)
              |JBFC-;freeOf?;SJBB;19| |JBFC-;characteristic;Nni;20|
              (113 . |Zero|) (117 . ~=) (123 . |derivativeOf?|)
              (129 . |formalDiff|) (135 . |subst|) (142 . <)
              |JBFC-;dSubst;SJB2S;21| (148 . |dimJ|) (|List| $)
              (|SparseEchelonMatrix| 7 $) |JBFC-;dimension;LSem2Nni;22|
              (153 . |dimS|) |JBFC-;orderDim;LSem2Nni;23| '|noChecks?|
              (|List| 41) (158 . |jacobiMatrix|) |JBFC-;jacobiMatrix;LSem;24|
              (164 . >) (|Mapping| 44 7 7) (170 . |merge|)
              (177 . |removeDuplicates!|) (|Integer|)
              (|SparseEchelonMatrix| 7 6) (182 . |new|) (188 . |zero?|)
              (|List| 6) (193 . |setRow!|) |JBFC-;jacobiMatrix;LLSem;25|
              (201 . |max|) (207 . |max|) (213 . |max|) (|Mapping| 25 25 25)
              (219 . |reduce|) |JBFC-;symbol;LSem;26| (226 . |allIndices|)
              (|Record| (|:| |Left| $) (|:| |Right| $)) (231 . |horizSplit|)
              |JBFC-;extractSymbol;2Sem;27| (237 . |jacobiMatrix|)
              (|Record| (|:| |DSys| 68) (|:| |JVars| 74)) (242 . |formalDiff2|)
              |JBFC-;formalDiff;LPiL;28| (249 . |formalDiff|)
              |JBFC-;formalDiff;SPiS;29|
              (|Record| (|:| |DPhi| $) (|:| |JVars| 41)) (255 . |formalDiff2|)
              |JBFC-;formalDiff;SLS;30| (262 . |nrows|)
              (|Record| (|:| |Indices| 41) (|:| |Entries| 85)) (267 . |row|)
              (|Union| $ '#1="0") (273 . |differentiate|) (|Union| 7 '#1#)
              (279 . =) (285 . +) (291 . *) (297 . |sort!|)
              |JBFC-;formalDiff2;LPiSemR;31| |JBFC-;formalDiff2;SPiSemR;32|
              (|Record| (|:| LD 7) (|:| |Fake?| 44) (|:| |Dep| 16)
                        (|:| |Fun| 6))
              (|Mapping| 44 119 119) (|List| 119) (303 . |sort!|)
              |JBFC-;sortLD;2L;34| (309 . ~=) (|Union| $ '"failed")
              (315 . |solveFor|) (321 . ~=) (327 . |simpOne|) (332 . |append|)
              (338 . |merge|) (345 . |second|) (350 . |setRow!|) (357 . |#|)
              (|Union| '#2="failed" (|List| 16))
              (|Record| (|:| |Sys| 68) (|:| JM 69) (|:| |Depend| 134))
              |JBFC-;simplify;LSemR;36| (362 . |numerator|)
              |JBFC-;simpOne;2S;37| (367 . |insert|) (374 . |insert|)
              (|Mapping| 6 6) (381 . |map|) (387 . |sortLD|)
              |JBFC-;simpMod;3L;38| |JBFC-;simpMod;LSemLR;39| (392 . |dSubst|)
              (399 . =) |JBFC-;reduceMod;3L;40| (405 . |merge!|) (412 . -)
              (418 . |concat!|) |JBFC-;autoReduce;2L;41|)
           '#(|symbol| 424 |sortLD| 429 |simplify| 434 |simpOne| 440 |simpMod|
              445 |setNotation| 458 |retractIfCan| 463 |reduceMod| 468
              |orderDim| 474 |order| 481 |numIndVar| 486 |numDepVar| 490
              |leadingDer| 494 |jacobiMatrix| 499 |getNotation| 510 |gcd| 514
              |freeOf?| 520 |formalDiff2| 526 |formalDiff| 540 |extractSymbol|
              558 |dimension| 563 |dSubst| 570 |const?| 577 |class| 582
              |characteristic| 587 |autoReduce| 591 X 596 U 605 P 614)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|autoReduce| ((|List| |#1|) (|List| |#1|))) T)
                              '((|reduceMod|
                                 ((|List| |#1|) (|List| |#1|) (|List| |#1|)))
                                T)
                              '((|simpMod|
                                 ((|Record| (|:| |Sys| (|List| |#1|))
                                            (|:| JM
                                                 (|SparseEchelonMatrix| |#2|
                                                                        |#1|))
                                            (|:| |Depend|
                                                 (|Union| #2#
                                                          (|List|
                                                           (|List|
                                                            (|NonNegativeInteger|))))))
                                  (|List| |#1|)
                                  (|SparseEchelonMatrix| |#2| |#1|)
                                  (|List| |#1|)))
                                T)
                              '((|simpMod|
                                 ((|List| |#1|) (|List| |#1|) (|List| |#1|)))
                                T)
                              '((|simpOne| (|#1| |#1|)) T)
                              '((|simplify|
                                 ((|Record| (|:| |Sys| (|List| |#1|))
                                            (|:| JM
                                                 (|SparseEchelonMatrix| |#2|
                                                                        |#1|))
                                            (|:| |Depend|
                                                 (|Union| #2#
                                                          (|List|
                                                           (|List|
                                                            (|NonNegativeInteger|))))))
                                  (|List| |#1|)
                                  (|SparseEchelonMatrix| |#2| |#1|)))
                                T)
                              '((|dSubst| (|#1| |#1| |#2| |#1|)) T)
                              '((|sortLD| ((|List| |#1|) (|List| |#1|))) T)
                              '((|leadingDer| (|#2| |#1|)) T)
                              '((|freeOf?| ((|Boolean|) |#1| |#2|)) T)
                              '((|orderDim|
                                 ((|NonNegativeInteger|) (|List| |#1|)
                                  (|SparseEchelonMatrix| |#2| |#1|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|dimension|
                                 ((|NonNegativeInteger|) (|List| |#1|)
                                  (|SparseEchelonMatrix| |#2| |#1|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|formalDiff2|
                                 ((|Record| (|:| |DSys| (|List| |#1|))
                                            (|:| |JVars|
                                                 (|List| (|List| |#2|))))
                                  (|List| |#1|) (|PositiveInteger|)
                                  (|SparseEchelonMatrix| |#2| |#1|)))
                                T)
                              '((|formalDiff2|
                                 ((|Record| (|:| |DPhi| |#1|)
                                            (|:| |JVars| (|List| |#2|)))
                                  |#1| (|PositiveInteger|)
                                  (|SparseEchelonMatrix| |#2| |#1|)))
                                T)
                              '((|formalDiff|
                                 ((|List| |#1|) (|List| |#1|)
                                  (|PositiveInteger|)))
                                T)
                              '((|formalDiff|
                                 (|#1| |#1| (|List| (|NonNegativeInteger|))))
                                T)
                              '((|formalDiff| (|#1| |#1| (|PositiveInteger|)))
                                T)
                              '((|symbol|
                                 ((|SparseEchelonMatrix| |#2| |#1|)
                                  (|List| |#1|)))
                                T)
                              '((|extractSymbol|
                                 ((|SparseEchelonMatrix| |#2| |#1|)
                                  (|SparseEchelonMatrix| |#2| |#1|)))
                                T)
                              '((|jacobiMatrix|
                                 ((|SparseEchelonMatrix| |#2| |#1|)
                                  (|List| |#1|) (|List| (|List| |#2|))))
                                T)
                              '((|jacobiMatrix|
                                 ((|SparseEchelonMatrix| |#2| |#1|)
                                  (|List| |#1|)))
                                T)
                              '((|class| ((|NonNegativeInteger|) |#1|)) T)
                              '((|order| ((|NonNegativeInteger|) |#1|)) T)
                              '((|const?| ((|Boolean|) |#1|)) T)
                              '((|numDepVar| ((|PositiveInteger|))) T)
                              '((|numIndVar| ((|PositiveInteger|))) T)
                              '((|getNotation| ((|Symbol|))) T)
                              '((|setNotation| ((|Void|) (|Symbol|))) T)
                              '((P (|#1| (|NonNegativeInteger|))) T)
                              '((P
                                 (|#1| (|PositiveInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((P (|#1| (|List| (|NonNegativeInteger|)))) T)
                              '((U (|#1|)) T) '((X (|#1|)) T)
                              '((P
                                 (|#1| (|PositiveInteger|)
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((U (|#1| (|PositiveInteger|))) T)
                              '((X (|#1| (|PositiveInteger|))) T)
                              '((|retractIfCan| ((|Union| |#2| "failed") |#1|))
                                T)
                              '((|gcd| (|#1| |#1| |#1|)) T)
                              '((|gcd| (|#1| (|List| |#1|))) T)
                              '((|characteristic| ((|NonNegativeInteger|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 152
                                            '(0 7 8 9 1 7 0 8 11 1 6 0 7 12 1 7
                                              0 8 14 2 7 0 8 16 17 0 7 0 19 0 7
                                              0 21 1 7 0 16 23 2 7 0 8 25 26 1
                                              7 0 25 28 1 7 30 30 31 0 7 30 34
                                              0 7 8 37 0 6 0 39 1 6 41 0 42 2 6
                                              0 0 7 43 1 6 44 0 45 0 7 0 48 2 7
                                              44 0 0 49 1 6 7 0 51 1 7 25 0 52
                                              1 7 25 0 54 2 41 44 7 0 57 0 6 0
                                              60 2 6 44 0 0 61 2 7 16 0 0 62 2
                                              6 0 0 16 63 3 6 0 0 7 0 64 2 7 44
                                              0 0 65 1 7 25 25 67 1 7 25 25 71
                                              2 6 69 68 74 75 2 7 44 0 0 77 3
                                              41 0 78 0 0 79 1 41 0 0 80 2 82 0
                                              41 81 83 1 6 44 0 84 4 82 32 0 81
                                              41 85 86 2 7 0 0 0 88 2 41 0 0 0
                                              89 2 25 0 0 0 90 3 16 25 91 0 25
                                              92 1 82 41 0 94 2 82 95 0 7 96 1
                                              6 69 68 98 3 6 99 68 8 69 100 2 6
                                              68 68 8 102 3 6 104 0 8 69 105 1
                                              82 25 0 107 2 82 108 0 81 109 2 7
                                              110 0 8 111 2 112 44 0 0 113 2 6
                                              0 0 0 114 2 6 0 0 0 115 2 41 0 78
                                              0 116 2 121 0 120 0 122 2 7 44 0
                                              0 124 2 6 125 0 7 126 2 119 44 0
                                              0 127 1 6 0 0 128 2 16 0 0 0 129
                                              3 121 0 120 0 0 130 1 41 7 0 131
                                              3 82 32 0 81 108 132 1 16 25 0
                                              133 1 6 0 0 137 3 41 0 7 0 81 139
                                              3 85 0 6 0 81 140 2 85 0 141 0
                                              142 1 6 68 68 143 3 6 0 0 7 0 146
                                              2 6 44 0 0 147 3 121 0 120 0 0
                                              149 2 6 0 0 0 150 2 121 0 0 0 151
                                              1 0 69 68 93 1 0 68 68 123 2 0
                                              135 68 69 136 1 0 0 0 138 3 0 135
                                              68 69 68 145 2 0 68 68 68 144 1 0
                                              32 30 33 1 0 46 0 47 2 0 68 68 68
                                              148 3 0 25 68 69 25 72 1 0 25 0
                                              53 0 0 8 36 0 0 8 38 1 0 7 0 56 2
                                              0 69 68 74 87 1 0 69 68 76 0 0 30
                                              35 2 0 0 0 0 40 2 0 44 0 7 58 3 0
                                              99 68 8 69 117 3 0 104 0 8 69 118
                                              2 0 68 68 8 101 2 0 0 0 8 103 2 0
                                              0 0 16 106 1 0 69 69 97 3 0 25 68
                                              69 25 70 3 0 0 0 7 0 66 1 0 44 0
                                              50 1 0 25 0 55 0 0 25 59 1 0 68
                                              68 152 0 0 0 20 1 0 0 8 13 0 0 0
                                              22 1 0 0 8 15 2 0 0 8 25 27 1 0 0
                                              25 29 1 0 0 16 24 2 0 0 8 16
                                              18)))))
           '|lookupComplete|)) 

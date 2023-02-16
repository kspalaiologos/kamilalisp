
(SDEFUN |OUTBOX;coerce;$Of;1| ((|x| ($)) ($ (|OutputForm|)))
        (|coerceRe2E| |x|
                      (ELT
                       (|Record| (|:| |ht| (|NonNegativeInteger|))
                                 (|:| |dp| (|NonNegativeInteger|))
                                 (|:| |wd| (|NonNegativeInteger|))
                                 (|:| |ct| (|List| (|String|))))
                       0))) 

(PUT '|OUTBOX;empty;$;2| '|SPADreplace| '(XLAM NIL (VECTOR 0 0 0 NIL))) 

(SDEFUN |OUTBOX;empty;$;2| (($ ($))) (VECTOR 0 0 0 NIL)) 

(SDEFUN |OUTBOX;box;S$;3| ((|s| (|String|)) ($ ($)))
        (VECTOR 1 0 (QCSIZE |s|) (LIST |s|))) 

(PUT '|OUTBOX;height;$Nni;4| '|SPADreplace| '(XLAM (|box|) (QVELT |box| 0))) 

(SDEFUN |OUTBOX;height;$Nni;4| ((|box| ($)) ($ (|NonNegativeInteger|)))
        (QVELT |box| 0)) 

(PUT '|OUTBOX;depth;$Nni;5| '|SPADreplace| '(XLAM (|box|) (QVELT |box| 1))) 

(SDEFUN |OUTBOX;depth;$Nni;5| ((|box| ($)) ($ (|NonNegativeInteger|)))
        (QVELT |box| 1)) 

(PUT '|OUTBOX;width;$Nni;6| '|SPADreplace| '(XLAM (|box|) (QVELT |box| 2))) 

(SDEFUN |OUTBOX;width;$Nni;6| ((|box| ($)) ($ (|NonNegativeInteger|)))
        (QVELT |box| 2)) 

(PUT '|OUTBOX;lines;$L;7| '|SPADreplace| '(XLAM (|box|) (QVELT |box| 3))) 

(SDEFUN |OUTBOX;lines;$L;7| ((|box| ($)) ($ (|List| (|String|))))
        (QVELT |box| 3)) 

(SDEFUN |OUTBOX;empty?;$B;8| ((|box| ($)) ($ (|Boolean|)))
        (COND
         ((ZEROP (SPADCALL |box| (QREFELT $ 12)))
          (ZEROP (SPADCALL |box| (QREFELT $ 13))))
         ('T NIL))) 

(SDEFUN |OUTBOX;pad;4NniM;9|
        ((|t| (|NonNegativeInteger|)) (|b| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) (|r| (|NonNegativeInteger|))
         ($ (|Mapping| $ $)))
        (SPROG NIL
               (SEQ
                (CONS #'|OUTBOX;pad;4NniM;9!0| (VECTOR |b| |t| |r| |l| $))))) 

(SDEFUN |OUTBOX;pad;4NniM;9!0| ((|box| NIL) ($$ NIL))
        (PROG ($ |l| |r| |t| |b|)
          (LETT $ (QREFELT $$ 4))
          (LETT |l| (QREFELT $$ 3))
          (LETT |r| (QREFELT $$ 2))
          (LETT |t| (QREFELT $$ 1))
          (LETT |b| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|newLines| NIL) (#1=#:G728 NIL) (|i| NIL) (#2=#:G727 NIL)
              (|line| NIL) (#3=#:G726 NIL) (|boxline| NIL) (#4=#:G725 NIL)
              (|emptyLine| NIL) (|nd| NIL) (|nh| NIL) (|nw| NIL) (|w| NIL))
             (SEQ (LETT |w| (SPADCALL |box| (QREFELT $ 14)))
                  (LETT |nw|
                        (SPADCALL (SPADCALL |l| |w| (QREFELT $ 19)) |r|
                                  (QREFELT $ 19)))
                  (LETT |nh|
                        (SPADCALL |t| (SPADCALL |box| (QREFELT $ 12))
                                  (QREFELT $ 19)))
                  (LETT |nd|
                        (SPADCALL |b| (SPADCALL |box| (QREFELT $ 13))
                                  (QREFELT $ 19)))
                  (LETT |emptyLine|
                        (SPADCALL |nw| (SPADCALL " " (QREFELT $ 21))
                                  (QREFELT $ 22)))
                  (LETT |newLines| (SPADCALL (QREFELT $ 23)))
                  (SEQ (LETT |i| (|spadConstant| $ 26)) (LETT #4# |t|) G190
                       (COND ((> |i| #4#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |newLines|
                               (SPADCALL (SPADCALL |emptyLine| (QREFELT $ 27))
                                         |newLines| (QREFELT $ 28)))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                  (SEQ (LETT |boxline| NIL)
                       (LETT #3# (SPADCALL |box| (QREFELT $ 16))) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |boxline| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ (LETT |line| (SPADCALL |emptyLine| (QREFELT $ 27)))
                            (SEQ (LETT |i| (|spadConstant| $ 26))
                                 (LETT #2# |w|) G190
                                 (COND ((> |i| #2#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SPADCALL |line|
                                             (SPADCALL |i| |l| (QREFELT $ 19))
                                             (SPADCALL |boxline| |i|
                                                       (QREFELT $ 30))
                                             (QREFELT $ 31))))
                                 (LETT |i| (+ |i| 1)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT
                             (LETT |newLines|
                                   (SPADCALL |line| |newLines|
                                             (QREFELT $ 28)))))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (SEQ (LETT |i| (|spadConstant| $ 26)) (LETT #1# |b|) G190
                       (COND ((> |i| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |newLines|
                               (SPADCALL (SPADCALL |emptyLine| (QREFELT $ 27))
                                         |newLines| (QREFELT $ 28)))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (VECTOR |nh| |nd| |nw|
                           (SPADCALL |newLines| (QREFELT $ 32)))))))))) 

(SDEFUN |OUTBOX;hcenter;NniM;10|
        ((|w| (|NonNegativeInteger|)) ($ (|Mapping| $ $)))
        (SPROG NIL (SEQ (CONS #'|OUTBOX;hcenter;NniM;10!0| (VECTOR $ |w|))))) 

(SDEFUN |OUTBOX;hcenter;NniM;10!0| ((|box| NIL) ($$ NIL))
        (PROG (|w| $)
          (LETT |w| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|l| NIL) (|r| NIL) (|d| NIL))
                   (SEQ
                    (LETT |d|
                          (SPADCALL |w| (SPADCALL |box| (QREFELT $ 14))
                                    (QREFELT $ 35)))
                    (EXIT
                     (COND
                      ((SPADCALL |d| (|spadConstant| $ 36) (QREFELT $ 38))
                       (|error| "cannot fit into box"))
                      ('T
                       (SEQ
                        (LETT |l|
                              (SPADCALL
                               (SPADCALL |d|
                                         (SPADCALL (|spadConstant| $ 26)
                                                   (QREFELT $ 40))
                                         (QREFELT $ 41))
                               (QREFELT $ 42)))
                        (LETT |r| |l|)
                        (COND
                         ((SPADCALL |d| (QREFELT $ 43))
                          (LETT |l|
                                (SPADCALL |l| (|spadConstant| $ 26)
                                          (QREFELT $ 19)))))
                        (EXIT
                         (SPADCALL |box|
                                   (SPADCALL (|spadConstant| $ 36)
                                             (|spadConstant| $ 36) |l| |r|
                                             (QREFELT $ 34)))))))))))))) 

(SDEFUN |OUTBOX;vconcat;LNniI$;11|
        ((|lb| (|List| $)) (|h| (|NonNegativeInteger|)) (|adjust| (|Integer|))
         ($ ($)))
        (SPROG
         ((|d| (|Integer|)) (|newLines| (|List| (|String|))) (#1=#:G766 NIL)
          (|b| NIL) (#2=#:G765 NIL) (#3=#:G752 NIL) (#4=#:G764 NIL)
          (#5=#:G763 NIL) (#6=#:G741 NIL) (#7=#:G762 NIL) (#8=#:G761 NIL)
          (|w| (|NonNegativeInteger|)) (#9=#:G760 NIL) (#10=#:G759 NIL))
         (SEQ
          (COND ((SPADCALL |lb| (QREFELT $ 46)) (SPADCALL (QREFELT $ 8)))
                (#11='T
                 (SEQ
                  (LETT |w|
                        (SPADCALL
                         (PROGN
                          (LETT #10# NIL)
                          (SEQ (LETT |b| NIL) (LETT #9# |lb|) G190
                               (COND
                                ((OR (ATOM #9#)
                                     (PROGN (LETT |b| (CAR #9#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #10#
                                       (CONS (SPADCALL |b| (QREFELT $ 14))
                                             #10#))))
                               (LETT #9# (CDR #9#)) (GO G190) G191
                               (EXIT (NREVERSE #10#))))
                         (QREFELT $ 48)))
                  (LETT |newLines|
                        (COND
                         ((< |adjust| 0)
                          (SPADCALL
                           (PROGN
                            (LETT #8# NIL)
                            (SEQ (LETT |b| NIL) (LETT #7# |lb|) G190
                                 (COND
                                  ((OR (ATOM #7#)
                                       (PROGN (LETT |b| (CAR #7#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #8#
                                         (CONS
                                          (SPADCALL
                                           (SPADCALL |b|
                                                     (SPADCALL 0 0 0
                                                               (PROG1
                                                                   (LETT #6#
                                                                         (- |w|
                                                                            (SPADCALL
                                                                             |b|
                                                                             (QREFELT
                                                                              $
                                                                              14))))
                                                                 (|check_subtype2|
                                                                  (>= #6# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #6#))
                                                               (QREFELT $ 34)))
                                           (QREFELT $ 16))
                                          #8#))))
                                 (LETT #7# (CDR #7#)) (GO G190) G191
                                 (EXIT (NREVERSE #8#))))
                           (QREFELT $ 50)))
                         ((> |adjust| 0)
                          (SPADCALL
                           (PROGN
                            (LETT #5# NIL)
                            (SEQ (LETT |b| NIL) (LETT #4# |lb|) G190
                                 (COND
                                  ((OR (ATOM #4#)
                                       (PROGN (LETT |b| (CAR #4#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #5#
                                         (CONS
                                          (SPADCALL
                                           (SPADCALL |b|
                                                     (SPADCALL 0 0
                                                               (PROG1
                                                                   (LETT #3#
                                                                         (- |w|
                                                                            (SPADCALL
                                                                             |b|
                                                                             (QREFELT
                                                                              $
                                                                              14))))
                                                                 (|check_subtype2|
                                                                  (>= #3# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #3#))
                                                               0
                                                               (QREFELT $ 34)))
                                           (QREFELT $ 16))
                                          #5#))))
                                 (LETT #4# (CDR #4#)) (GO G190) G191
                                 (EXIT (NREVERSE #5#))))
                           (QREFELT $ 50)))
                         (#11#
                          (SPADCALL
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |b| NIL) (LETT #1# |lb|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |b| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS
                                          (SPADCALL
                                           (SPADCALL |b|
                                                     (SPADCALL |w|
                                                               (QREFELT $ 44)))
                                           (QREFELT $ 16))
                                          #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           (QREFELT $ 50)))))
                  (LETT |d| (- (LENGTH |newLines|) |h|))
                  (EXIT
                   (COND ((< |d| 0) (|error| "vconcat: negative depth"))
                         (#11# (VECTOR |h| |d| |w| |newLines|)))))))))) 

(SDEFUN |OUTBOX;vconcat;LNni$;12|
        ((|lb| (|List| $)) (|h| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |lb| |h| 0 (QREFELT $ 51))) 

(SDEFUN |OUTBOX;hconcat;L$;13| ((|lb| (|List| $)) ($ ($)))
        (SPROG
         ((|newLines| (|List| (|String|))) (|wx| (|NonNegativeInteger|))
          (#1=#:G799 NIL) (|j| NIL) (|line| (|String|)) (|ix| (|Integer|))
          (|hb| (|NonNegativeInteger|)) (|wb| (|NonNegativeInteger|))
          (#2=#:G798 NIL) (|b| NIL) (|newLine| (|String|)) (#3=#:G797 NIL)
          (|i| NIL) (|emptyLine| (|String|)) (|w| (|NonNegativeInteger|))
          (#4=#:G796 NIL) (#5=#:G795 NIL) (|d| #6=(|NonNegativeInteger|))
          (#7=#:G794 NIL) (#8=#:G793 NIL) (|h| #6#) (#9=#:G792 NIL)
          (#10=#:G791 NIL))
         (SEQ
          (COND ((SPADCALL |lb| (QREFELT $ 46)) (SPADCALL (QREFELT $ 8)))
                ('T
                 (SEQ
                  (LETT |h|
                        (SPADCALL
                         (PROGN
                          (LETT #10# NIL)
                          (SEQ (LETT |b| NIL) (LETT #9# |lb|) G190
                               (COND
                                ((OR (ATOM #9#)
                                     (PROGN (LETT |b| (CAR #9#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #10#
                                       (CONS (SPADCALL |b| (QREFELT $ 12))
                                             #10#))))
                               (LETT #9# (CDR #9#)) (GO G190) G191
                               (EXIT (NREVERSE #10#))))
                         (QREFELT $ 48)))
                  (LETT |d|
                        (SPADCALL
                         (PROGN
                          (LETT #8# NIL)
                          (SEQ (LETT |b| NIL) (LETT #7# |lb|) G190
                               (COND
                                ((OR (ATOM #7#)
                                     (PROGN (LETT |b| (CAR #7#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #8#
                                       (CONS (SPADCALL |b| (QREFELT $ 13))
                                             #8#))))
                               (LETT #7# (CDR #7#)) (GO G190) G191
                               (EXIT (NREVERSE #8#))))
                         (QREFELT $ 48)))
                  (LETT |w|
                        (SPADCALL (ELT $ 19)
                                  (PROGN
                                   (LETT #5# NIL)
                                   (SEQ (LETT |b| NIL) (LETT #4# |lb|) G190
                                        (COND
                                         ((OR (ATOM #4#)
                                              (PROGN (LETT |b| (CAR #4#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #5#
                                                (CONS
                                                 (SPADCALL |b| (QREFELT $ 14))
                                                 #5#))))
                                        (LETT #4# (CDR #4#)) (GO G190) G191
                                        (EXIT (NREVERSE #5#))))
                                  (QREFELT $ 54)))
                  (LETT |emptyLine|
                        (|make_full_CVEC2| |w| (|STR_to_CHAR| " ")))
                  (LETT |newLines| NIL)
                  (SEQ (LETT |i| 1) (LETT #3# (+ |h| |d|)) G190
                       (COND ((|greater_SI| |i| #3#) (GO G191)))
                       (SEQ (LETT |newLine| (COPY-SEQ |emptyLine|))
                            (LETT |wx| 0)
                            (SEQ (LETT |b| NIL) (LETT #2# |lb|) G190
                                 (COND
                                  ((OR (ATOM #2#)
                                       (PROGN (LETT |b| (CAR #2#)) NIL))
                                   (GO G191)))
                                 (SEQ (LETT |wb| (SPADCALL |b| (QREFELT $ 14)))
                                      (LETT |hb| (SPADCALL |b| (QREFELT $ 12)))
                                      (LETT |ix| (+ (- |hb| |h|) |i|))
                                      (COND
                                       ((< 0 |ix|)
                                        (COND
                                         ((<= |ix|
                                              (+ |hb|
                                                 (SPADCALL |b|
                                                           (QREFELT $ 13))))
                                          (SEQ
                                           (LETT |line|
                                                 (SPADCALL
                                                  (SPADCALL |b| (QREFELT $ 16))
                                                  |ix| (QREFELT $ 55)))
                                           (EXIT
                                            (SEQ (LETT |j| 1) (LETT #1# |wb|)
                                                 G190
                                                 (COND
                                                  ((|greater_SI| |j| #1#)
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (SPADCALL |newLine|
                                                             (+ |wx| |j|)
                                                             (SPADCALL |line|
                                                                       |j|
                                                                       (QREFELT
                                                                        $ 30))
                                                             (QREFELT $ 31))))
                                                 (LETT |j| (|inc_SI| |j|))
                                                 (GO G190) G191
                                                 (EXIT NIL))))))))
                                      (EXIT (LETT |wx| (+ |wx| |wb|))))
                                 (LETT #2# (CDR #2#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT
                             (LETT |newLines| (CONS |newLine| |newLines|))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT (VECTOR |h| |d| |w| (NREVERSE |newLines|))))))))) 

(DECLAIM (NOTINLINE |OutputBox;|)) 

(DEFUN |OutputBox| ()
  (SPROG NIL
         (PROG (#1=#:G801)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OutputBox|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OutputBox|
                             (LIST (CONS NIL (CONS 1 (|OutputBox;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|OutputBox|)))))))))) 

(DEFUN |OutputBox;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OutputBox|))
          (LETT $ (GETREFV 57))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OutputBox| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OutputBox| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|OutputForm|) |OUTBOX;coerce;$Of;1|
              |OUTBOX;empty;$;2| (|String|) |OUTBOX;box;S$;3|
              (|NonNegativeInteger|) |OUTBOX;height;$Nni;4|
              |OUTBOX;depth;$Nni;5| |OUTBOX;width;$Nni;6| (|List| 9)
              |OUTBOX;lines;$L;7| (|Boolean|) |OUTBOX;empty?;$B;8| (0 . +)
              (|Character|) (6 . |char|) (11 . |new|) (17 . |empty|)
              (|SingleInteger|) (21 . |One|) (25 . |One|) (29 . |copy|)
              (34 . |cons|) (|Integer|) (40 . |elt|) (46 . |setelt!|)
              (53 . |reverse!|) (|Mapping| $ $) |OUTBOX;pad;4NniM;9| (58 . -)
              (64 . |Zero|) (68 . |Zero|) (72 . <) (78 . |One|) (82 . -)
              (87 . |shift|) (93 . |qcoerce|) (98 . |odd?|)
              |OUTBOX;hcenter;NniM;10| (|List| $$) (103 . |empty?|) (|List| 11)
              (108 . |max|) (|List| $) (113 . |concat|)
              |OUTBOX;vconcat;LNniI$;11| |OUTBOX;vconcat;LNni$;12|
              (|Mapping| 11 11 11) (118 . |reduce|) (124 . |elt|)
              |OUTBOX;hconcat;L$;13|)
           '#(|width| 130 |vconcat| 135 |pad| 148 |lines| 156 |height| 161
              |hconcat| 166 |hcenter| 171 |empty?| 176 |empty| 181 |depth| 185
              |coerce| 190 |box| 195)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|CoercibleTo| 6))
                             (|makeByteWordVec2| 56
                                                 '(2 11 0 0 0 19 1 20 0 9 21 2
                                                   9 0 11 20 22 0 15 0 23 0 24
                                                   0 25 0 11 0 26 1 9 0 0 27 2
                                                   15 0 9 0 28 2 9 20 0 29 30 3
                                                   9 20 0 29 20 31 1 15 0 0 32
                                                   2 29 0 0 0 35 0 11 0 36 0 29
                                                   0 37 2 29 17 0 0 38 0 29 0
                                                   39 1 29 0 0 40 2 29 0 0 0 41
                                                   1 11 0 29 42 1 29 17 0 43 1
                                                   45 17 0 46 1 47 11 0 48 1 15
                                                   0 49 50 2 47 11 53 0 54 2 15
                                                   9 0 29 55 1 0 11 0 14 3 0 0
                                                   49 11 29 51 2 0 0 49 11 52 4
                                                   0 33 11 11 11 11 34 1 0 15 0
                                                   16 1 0 11 0 12 1 0 0 49 56 1
                                                   0 33 11 44 1 0 17 0 18 0 0 0
                                                   8 1 0 11 0 13 1 0 6 0 7 1 0
                                                   0 9 10)))))
           '|lookupComplete|)) 

(MAKEPROP '|OutputBox| 'NILADIC T) 


(SDEFUN |TBAGG-;table;S;1| (($ (S))) (SPADCALL (QREFELT $ 9))) 

(SDEFUN |TBAGG-;table;LS;2|
        ((|l| (|List| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
         ($ (S)))
        (SPADCALL |l| (QREFELT $ 13))) 

(SDEFUN |TBAGG-;insert!;R2S;3|
        ((|p| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))) (|t| (S))
         ($ (S)))
        (SEQ (SPADCALL |t| (QCAR |p|) (QCDR |p|) (QREFELT $ 15)) (EXIT |t|))) 

(SDEFUN |TBAGG-;indices;SL;4| ((|t| (S)) ($ (|List| |Key|)))
        (SPADCALL |t| (QREFELT $ 18))) 

(SDEFUN |TBAGG-;coerce;SOf;5| ((|t| (S)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G725 NIL) (|k| NIL) (#2=#:G724 NIL))
               (SEQ
                (SPADCALL (SPADCALL "table" (QREFELT $ 22))
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |k| NIL)
                                (LETT #1# (SPADCALL |t| (QREFELT $ 18))) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |k| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL |k| (QREFELT $ 23))
                                          (SPADCALL
                                           (SPADCALL |t| |k| (QREFELT $ 24))
                                           (QREFELT $ 25))
                                          (QREFELT $ 26))
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 28))))) 

(SDEFUN |TBAGG-;elt;SKeyEntry;6| ((|t| (S)) (|k| (|Key|)) ($ (|Entry|)))
        (SPROG ((|r| (|Union| |Entry| "failed")))
               (SEQ (LETT |r| (SPADCALL |k| |t| (QREFELT $ 31)))
                    (EXIT
                     (COND ((QEQCAR |r| 0) (QCDR |r|))
                           ('T (|error| "key not in table"))))))) 

(SDEFUN |TBAGG-;elt;SKey2Entry;7|
        ((|t| (S)) (|k| (|Key|)) (|e| (|Entry|)) ($ (|Entry|)))
        (SPROG ((|r| (|Union| |Entry| "failed")))
               (SEQ (LETT |r| (SPADCALL |k| |t| (QREFELT $ 31)))
                    (EXIT (COND ((QEQCAR |r| 0) (QCDR |r|)) ('T |e|)))))) 

(SDEFUN |TBAGG-;map!;M2S;8|
        ((|f| (|Mapping| |Entry| |Entry|)) (|t| (S)) ($ (S)))
        (SPROG ((#1=#:G741 NIL) (|k| NIL))
               (SEQ
                (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |t| (QREFELT $ 18)))
                     G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |t| |k|
                                 (SPADCALL (SPADCALL |t| |k| (QREFELT $ 24))
                                           |f|)
                                 (QREFELT $ 15))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |t|)))) 

(SDEFUN |TBAGG-;map;M3S;9|
        ((|f| (|Mapping| |Entry| |Entry| |Entry|)) (|s| (S)) (|t| (S)) ($ (S)))
        (SPROG ((#1=#:G747 NIL) (|k| NIL) (|z| (S)))
               (SEQ (LETT |z| (SPADCALL (QREFELT $ 36)))
                    (SEQ (LETT |k| NIL)
                         (LETT #1# (SPADCALL |s| (QREFELT $ 18))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |k| |t| (QREFELT $ 38))
                             (SPADCALL |z| |k|
                                       (SPADCALL
                                        (SPADCALL |s| |k| (QREFELT $ 24))
                                        (SPADCALL |t| |k| (QREFELT $ 24)) |f|)
                                       (QREFELT $ 15))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |z|)))) 

(SDEFUN |TBAGG-;parts;SL;10|
        ((|t| (S))
         ($ (|List| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|)))))
        (SPROG ((#1=#:G753 NIL) (|k| NIL) (#2=#:G752 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |t| (QREFELT $ 18)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (CONS |k| (SPADCALL |t| |k| (QREFELT $ 24)))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |TBAGG-;parts;SL;11| ((|t| (S)) ($ (|List| |Entry|)))
        (SPROG ((#1=#:G758 NIL) (|k| NIL) (#2=#:G757 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |t| (QREFELT $ 18)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |t| |k| (QREFELT $ 24)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |TBAGG-;entries;SL;12| ((|t| (S)) ($ (|List| |Entry|)))
        (SPADCALL |t| (QREFELT $ 44))) 

(SDEFUN |TBAGG-;=;2SB;13| ((|s| (S)) (|t| (S)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G771 NIL) (#2=#:G772 NIL) (|e| (|Union| |Entry| "failed"))
          (#3=#:G773 NIL) (|k| NIL))
         (SEQ
          (EXIT
           (COND ((SPADCALL |s| |t| (QREFELT $ 46)) 'T)
                 ((SPADCALL (SPADCALL |s| (QREFELT $ 48))
                            (SPADCALL |t| (QREFELT $ 48)) (QREFELT $ 50))
                  NIL)
                 ('T
                  (SEQ
                   (SEQ
                    (EXIT
                     (SEQ (LETT |k| NIL)
                          (LETT #3# (SPADCALL |s| (QREFELT $ 18))) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |k| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ (LETT |e| (SPADCALL |k| |t| (QREFELT $ 31)))
                               (EXIT
                                (COND
                                 ((OR (QEQCAR |e| 1)
                                      (SPADCALL (QCDR |e|)
                                                (SPADCALL |s| |k|
                                                          (QREFELT $ 24))
                                                (QREFELT $ 51)))
                                  (PROGN
                                   (LETT #1#
                                         (PROGN (LETT #2# NIL) (GO #4=#:G770)))
                                   (GO #5=#:G766))))))
                          (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                    #5# (EXIT #1#))
                   (EXIT 'T)))))
          #4# (EXIT #2#)))) 

(SDEFUN |TBAGG-;map;M2S;14|
        ((|f|
          (|Mapping| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))
                     (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
         (|t| (S)) ($ (S)))
        (SPROG
         ((|ke| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|)))
          (#1=#:G781 NIL) (|k| NIL) (|z| (S)))
         (SEQ (LETT |z| (SPADCALL (QREFELT $ 36)))
              (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |t| (QREFELT $ 18))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |ke|
                          (SPADCALL
                           (CONS |k| (SPADCALL |t| |k| (QREFELT $ 24))) |f|))
                    (EXIT
                     (SPADCALL |z| (QCAR |ke|) (QCDR |ke|) (QREFELT $ 15))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |z|)))) 

(SDEFUN |TBAGG-;map!;M2S;15|
        ((|f|
          (|Mapping| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))
                     (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
         (|t| (S)) ($ (S)))
        (SPROG
         ((#1=#:G793 NIL) (|ke| NIL)
          (|lke| (|List| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
          (#2=#:G785 NIL) (#3=#:G792 NIL) (|k| NIL))
         (SEQ (LETT |lke| NIL)
              (SEQ (LETT |k| NIL) (LETT #3# (SPADCALL |t| (QREFELT $ 18))) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |k| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |lke|
                           (CONS
                            (SPADCALL
                             (CONS |k|
                                   (PROG2
                                       (LETT #2#
                                             (SPADCALL |k| |t| (QREFELT $ 55)))
                                       (QCDR #2#)
                                     (|check_union2| (QEQCAR #2# 0)
                                                     (QREFELT $ 8)
                                                     (|Union| (QREFELT $ 8)
                                                              "failed")
                                                     #2#)))
                             |f|)
                            |lke|))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |ke| NIL) (LETT #1# |lke|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |ke| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |t| (QCAR |ke|) (QCDR |ke|) (QREFELT $ 15))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |t|)))) 

(SDEFUN |TBAGG-;inspect;SR;16|
        ((|t| (S)) ($ (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
        (SPROG ((|ks| (|List| |Key|)))
               (SEQ (LETT |ks| (SPADCALL |t| (QREFELT $ 18)))
                    (EXIT
                     (COND
                      ((NULL |ks|)
                       (|error| "Cannot extract from an empty aggregate"))
                      ('T
                       (CONS (|SPADfirst| |ks|)
                             (SPADCALL |t| (|SPADfirst| |ks|)
                                       (QREFELT $ 24))))))))) 

(SDEFUN |TBAGG-;find;MSU;17|
        ((|f|
          (|Mapping| (|Boolean|)
                     (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
         (|t| (S))
         ($
          (|Union| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))
                   "failed")))
        (SPROG ((#1=#:G810 NIL) (#2=#:G811 NIL) (|ke| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |ke| NIL) (LETT #2# (SPADCALL |t| (QREFELT $ 58)))
                       G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |ke| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |ke| |f|)
                           (PROGN (LETT #1# (CONS 0 |ke|)) (GO #3=#:G809))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT (CONS 1 "failed"))))
                #3# (EXIT #1#)))) 

(SDEFUN |TBAGG-;index?;KeySB;18| ((|k| (|Key|)) (|t| (S)) ($ (|Boolean|)))
        (QEQCAR (SPADCALL |k| |t| (QREFELT $ 31)) 0)) 

(SDEFUN |TBAGG-;remove!;R2S;19|
        ((|x| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))) (|t| (S))
         ($ (S)))
        (SEQ
         (COND
          ((SPADCALL |x| |t| (QREFELT $ 63))
           (SPADCALL (QCAR |x|) |t| (QREFELT $ 55))))
         (EXIT |t|))) 

(SDEFUN |TBAGG-;extract!;SR;20|
        ((|t| (S)) ($ (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
        (SPROG ((|k| (|Record| (|:| |key| |Key|) (|:| |entry| |Entry|))))
               (SEQ (LETT |k| (SPADCALL |t| (QREFELT $ 65)))
                    (SPADCALL (QCAR |k|) |t| (QREFELT $ 55)) (EXIT |k|)))) 

(SDEFUN |TBAGG-;any?;MSB;21|
        ((|f| (|Mapping| (|Boolean|) |Entry|)) (|t| (S)) ($ (|Boolean|)))
        (SPROG ((#1=#:G831 NIL) (#2=#:G832 NIL) (|k| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |k| NIL) (LETT #2# (SPADCALL |t| (QREFELT $ 18)))
                       G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (SPADCALL |t| |k| (QREFELT $ 24)) |f|)
                           (PROGN (LETT #1# 'T) (GO #3=#:G830))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT NIL)))
                #3# (EXIT #1#)))) 

(SDEFUN |TBAGG-;every?;MSB;22|
        ((|f| (|Mapping| (|Boolean|) |Entry|)) (|t| (S)) ($ (|Boolean|)))
        (SPROG ((#1=#:G838 NIL) (#2=#:G839 NIL) (|k| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |k| NIL) (LETT #2# (SPADCALL |t| (QREFELT $ 18)))
                       G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((NULL
                            (SPADCALL (SPADCALL |t| |k| (QREFELT $ 24)) |f|))
                           (PROGN (LETT #1# NIL) (GO #3=#:G837))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |TBAGG-;count;MSNni;23|
        ((|f| (|Mapping| (|Boolean|) |Entry|)) (|t| (S))
         ($ (|NonNegativeInteger|)))
        (SPROG ((|tally| (|NonNegativeInteger|)) (#1=#:G845 NIL) (|k| NIL))
               (SEQ (LETT |tally| 0)
                    (SEQ (LETT |k| NIL)
                         (LETT #1# (SPADCALL |t| (QREFELT $ 18))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |t| |k| (QREFELT $ 24)) |f|)
                             (LETT |tally| (+ |tally| 1))))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |tally|)))) 

(DECLAIM (NOTINLINE |TableAggregate&;|)) 

(DEFUN |TableAggregate&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|TableAggregate&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 71))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#2| '(|CoercibleTo| (|OutputForm|)))
            (COND
             ((|HasCategory| |#3| '(|CoercibleTo| (|OutputForm|)))
              (QSETREFV $ 29
                        (CONS (|dispatchFunction| |TBAGG-;coerce;SOf;5|)
                              $))))))
          (COND
           ((|HasCategory| |#1| '(|finiteAggregate|))
            (PROGN
             (QSETREFV $ 41 (CONS (|dispatchFunction| |TBAGG-;parts;SL;10|) $))
             (QSETREFV $ 43 (CONS (|dispatchFunction| |TBAGG-;parts;SL;11|) $))
             (QSETREFV $ 45
                       (CONS (|dispatchFunction| |TBAGG-;entries;SL;12|) $))
             (COND
              ((|HasCategory| |#3| '(|BasicType|))
               (QSETREFV $ 52
                         (CONS (|dispatchFunction| |TBAGG-;=;2SB;13|) $))))
             (QSETREFV $ 54 (CONS (|dispatchFunction| |TBAGG-;map;M2S;14|) $))
             (COND
              ((|HasCategory| |#3| '(|BasicType|))
               (QSETREFV $ 56
                         (CONS (|dispatchFunction| |TBAGG-;map!;M2S;15|) $))))
             (QSETREFV $ 57
                       (CONS (|dispatchFunction| |TBAGG-;inspect;SR;16|) $))
             (QSETREFV $ 61 (CONS (|dispatchFunction| |TBAGG-;find;MSU;17|) $))
             (QSETREFV $ 62
                       (CONS (|dispatchFunction| |TBAGG-;index?;KeySB;18|) $))
             (COND
              ((|HasCategory| |#3| '(|BasicType|))
               (QSETREFV $ 64
                         (CONS (|dispatchFunction| |TBAGG-;remove!;R2S;19|)
                               $))))
             (QSETREFV $ 66
                       (CONS (|dispatchFunction| |TBAGG-;extract!;SR;20|) $))
             (QSETREFV $ 68 (CONS (|dispatchFunction| |TBAGG-;any?;MSB;21|) $))
             (QSETREFV $ 69
                       (CONS (|dispatchFunction| |TBAGG-;every?;MSB;22|) $))
             (QSETREFV $ 70
                       (CONS (|dispatchFunction| |TBAGG-;count;MSNni;23|)
                             $)))))
          $))) 

(MAKEPROP '|TableAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |empty|) |TBAGG-;table;S;1|
              (|Record| (|:| |key| 7) (|:| |entry| 8)) (|List| 11)
              (4 . |dictionary|) |TBAGG-;table;LS;2| (9 . |setelt!|)
              |TBAGG-;insert!;R2S;3| (|List| 7) (16 . |keys|)
              |TBAGG-;indices;SL;4| (|String|) (|OutputForm|) (21 . |message|)
              (26 . |coerce|) (31 . |elt|) (37 . |coerce|) (42 . =) (|List| $)
              (48 . |prefix|) (54 . |coerce|) (|Union| 8 '#1="failed")
              (59 . |search|) |TBAGG-;elt;SKeyEntry;6|
              |TBAGG-;elt;SKey2Entry;7| (|Mapping| 8 8) |TBAGG-;map!;M2S;8|
              (65 . |table|) (|Boolean|) (69 . |key?|) (|Mapping| 8 8 8)
              |TBAGG-;map;M3S;9| (75 . |parts|) (|List| 8) (80 . |parts|)
              (85 . |parts|) (90 . |entries|) (95 . |eq?|)
              (|NonNegativeInteger|) (101 . |#|) (|Integer|) (106 . ~=)
              (112 . ~=) (118 . =) (|Mapping| 11 11) (124 . |map|)
              (130 . |remove!|) (136 . |map!|) (142 . |inspect|)
              (147 . |parts|) (|Union| 11 '"failed") (|Mapping| 37 11)
              (152 . |find|) (158 . |index?|) (164 . |member?|)
              (170 . |remove!|) (176 . |inspect|) (181 . |extract!|)
              (|Mapping| 37 8) (186 . |any?|) (192 . |every?|) (198 . |count|))
           '#(|table| 204 |remove!| 213 |parts| 219 |map!| 229 |map| 241
              |inspect| 254 |insert!| 259 |indices| 265 |index?| 270 |find| 276
              |extract!| 282 |every?| 287 |entries| 293 |elt| 298 |count| 311
              |coerce| 317 |any?| 322 = 328)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 (|#1| (|Mapping| |#3| |#3| |#3|) |#1| |#1|))
                                T)
                              '((|table|
                                 (|#1|
                                  (|List|
                                   (|Record| (|:| |key| |#2|)
                                             (|:| |entry| |#3|)))))
                                T)
                              '((|table| (|#1|)) T)
                              '((|map| (|#1| (|Mapping| |#3| |#3|) |#1|)) T)
                              '((|map!| (|#1| (|Mapping| |#3| |#3|) |#1|)) T)
                              '((|any?|
                                 ((|Boolean|) (|Mapping| (|Boolean|) |#3|)
                                  |#1|))
                                T)
                              '((|every?|
                                 ((|Boolean|) (|Mapping| (|Boolean|) |#3|)
                                  |#1|))
                                T)
                              '((|count|
                                 ((|NonNegativeInteger|)
                                  (|Mapping| (|Boolean|) |#3|) |#1|))
                                T)
                              '((|parts| ((|List| |#3|) |#1|)) T)
                              '((|count| ((|NonNegativeInteger|) |#3| |#1|)) T)
                              '((= ((|Boolean|) |#1| |#1|)) T)
                              '((|coerce| ((|OutputForm|) |#1|)) T)
                              '((|elt| (|#3| |#1| |#2| |#3|)) T)
                              '((|elt| (|#3| |#1| |#2|)) T)
                              '((|entries| ((|List| |#3|) |#1|)) T)
                              '((|index?| ((|Boolean|) |#2| |#1|)) T)
                              '((|indices| ((|List| |#2|) |#1|)) T)
                              '((|remove!| ((|Union| |#3| #1#) |#2| |#1|)) T)
                              '((|remove!|
                                 (|#1|
                                  (|Mapping| (|Boolean|)
                                             (|Record| (|:| |key| |#2|)
                                                       (|:| |entry| |#3|)))
                                  |#1|))
                                T)
                              '((|remove!|
                                 (|#1|
                                  (|Record| (|:| |key| |#2|)
                                            (|:| |entry| |#3|))
                                  |#1|))
                                T)
                              '((|inspect|
                                 ((|Record| (|:| |key| |#2|)
                                            (|:| |entry| |#3|))
                                  |#1|))
                                T)
                              '((|insert!|
                                 (|#1|
                                  (|Record| (|:| |key| |#2|)
                                            (|:| |entry| |#3|))
                                  |#1|))
                                T)
                              '((|extract!|
                                 ((|Record| (|:| |key| |#2|)
                                            (|:| |entry| |#3|))
                                  |#1|))
                                T)
                              '((|find|
                                 ((|Union|
                                   (|Record| (|:| |key| |#2|)
                                             (|:| |entry| |#3|))
                                   "failed")
                                  (|Mapping| (|Boolean|)
                                             (|Record| (|:| |key| |#2|)
                                                       (|:| |entry| |#3|)))
                                  |#1|))
                                T)
                              '((|count|
                                 ((|NonNegativeInteger|)
                                  (|Record| (|:| |key| |#2|)
                                            (|:| |entry| |#3|))
                                  |#1|))
                                T)
                              '((|parts|
                                 ((|List|
                                   (|Record| (|:| |key| |#2|)
                                             (|:| |entry| |#3|)))
                                  |#1|))
                                T)
                              '((|count|
                                 ((|NonNegativeInteger|)
                                  (|Mapping| (|Boolean|)
                                             (|Record| (|:| |key| |#2|)
                                                       (|:| |entry| |#3|)))
                                  |#1|))
                                T)
                              '((|every?|
                                 ((|Boolean|)
                                  (|Mapping| (|Boolean|)
                                             (|Record| (|:| |key| |#2|)
                                                       (|:| |entry| |#3|)))
                                  |#1|))
                                T)
                              '((|any?|
                                 ((|Boolean|)
                                  (|Mapping| (|Boolean|)
                                             (|Record| (|:| |key| |#2|)
                                                       (|:| |entry| |#3|)))
                                  |#1|))
                                T)
                              '((|map!|
                                 (|#1|
                                  (|Mapping|
                                   (|Record| (|:| |key| |#2|)
                                             (|:| |entry| |#3|))
                                   (|Record| (|:| |key| |#2|)
                                             (|:| |entry| |#3|)))
                                  |#1|))
                                T)
                              '((|map|
                                 (|#1|
                                  (|Mapping|
                                   (|Record| (|:| |key| |#2|)
                                             (|:| |entry| |#3|))
                                   (|Record| (|:| |key| |#2|)
                                             (|:| |entry| |#3|)))
                                  |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 70
                                            '(0 6 0 9 1 6 0 12 13 3 6 8 0 7 8
                                              15 1 6 17 0 18 1 21 0 20 22 1 7
                                              21 0 23 2 6 8 0 7 24 1 8 21 0 25
                                              2 21 0 0 0 26 2 21 0 0 27 28 1 0
                                              21 0 29 2 6 30 7 0 31 0 6 0 36 2
                                              6 37 7 0 38 1 0 12 0 41 1 0 42 0
                                              43 1 6 42 0 44 1 0 42 0 45 2 6 37
                                              0 0 46 1 6 47 0 48 2 49 37 0 0 50
                                              2 8 37 0 0 51 2 0 37 0 0 52 2 0 0
                                              53 0 54 2 6 30 7 0 55 2 0 0 53 0
                                              56 1 0 11 0 57 1 6 12 0 58 2 0 59
                                              60 0 61 2 0 37 7 0 62 2 6 37 11 0
                                              63 2 0 0 11 0 64 1 6 11 0 65 1 0
                                              11 0 66 2 0 37 67 0 68 2 0 37 67
                                              0 69 2 0 47 67 0 70 0 0 0 10 1 0
                                              0 12 14 2 0 0 11 0 64 1 0 42 0 43
                                              1 0 12 0 41 2 0 0 34 0 35 2 0 0
                                              53 0 56 3 0 0 39 0 0 40 2 0 0 53
                                              0 54 1 0 11 0 57 2 0 0 11 0 16 1
                                              0 17 0 19 2 0 37 7 0 62 2 0 59 60
                                              0 61 1 0 11 0 66 2 0 37 67 0 69 1
                                              0 42 0 45 3 0 8 0 7 8 33 2 0 8 0
                                              7 32 2 0 47 67 0 70 1 0 21 0 29 2
                                              0 37 67 0 68 2 0 37 0 0 52)))))
           '|lookupComplete|)) 

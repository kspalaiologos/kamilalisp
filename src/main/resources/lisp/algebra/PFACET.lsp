
(PUT '|PFACET;productFacet;IL$;1| '|SPADreplace| 'CONS) 

(SDEFUN |PFACET;productFacet;IL$;1|
        ((|mul1| (|Integer|))
         (|ind1|
          (|List|
           (|Record| (|:| |left| (|NonNegativeInteger|))
                     (|:| |right| (|NonNegativeInteger|)))))
         ($ ($)))
        (CONS |mul1| |ind1|)) 

(SDEFUN |PFACET;productFacet;I2$;2|
        ((|mul1| (|Integer|)) (|other| (|ProductFacet|)) ($ ($)))
        (CONS |mul1| (SPADCALL |other| (QREFELT $ 12)))) 

(PUT '|PFACET;getIndexs;$L;3| '|SPADreplace| 'QCDR) 

(SDEFUN |PFACET;getIndexs;$L;3|
        ((|orf| ($))
         ($
          (|List|
           (|Record| (|:| |left| (|NonNegativeInteger|))
                     (|:| |right| (|NonNegativeInteger|))))))
        (QCDR |orf|)) 

(SDEFUN |PFACET;getMaxLeft;$Nni;4| ((|orf| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|m| (|NonNegativeInteger|)) (#1=#:G722 NIL) (|index| NIL)
          (|indexes|
           (|List|
            (|Record| (|:| |left| (|NonNegativeInteger|))
                      (|:| |right| (|NonNegativeInteger|))))))
         (SEQ (LETT |m| 0) (LETT |indexes| (SPADCALL |orf| (QREFELT $ 14)))
              (SEQ (LETT |index| NIL) (LETT #1# |indexes|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |index| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> (QCAR |index|) |m|) (LETT |m| (QCAR |index|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |m|)))) 

(SDEFUN |PFACET;getMaxRight;$Nni;5| ((|orf| ($)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|m| (|NonNegativeInteger|)) (#1=#:G730 NIL) (|index| NIL)
          (|indexes|
           (|List|
            (|Record| (|:| |left| (|NonNegativeInteger|))
                      (|:| |right| (|NonNegativeInteger|))))))
         (SEQ (LETT |m| 0) (LETT |indexes| (SPADCALL |orf| (QREFELT $ 14)))
              (SEQ (LETT |index| NIL) (LETT #1# |indexes|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |index| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> (QCDR |index|) |m|) (LETT |m| (QCDR |index|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |m|)))) 

(SDEFUN |PFACET;order;$Nni;6| ((|f| ($)) ($ (|NonNegativeInteger|)))
        (LENGTH (SPADCALL |f| (QREFELT $ 14)))) 

(PUT '|PFACET;getMult;$I;7| '|SPADreplace| 'QCAR) 

(SDEFUN |PFACET;getMult;$I;7| ((|orf| ($)) ($ (|Integer|))) (QCAR |orf|)) 

(SDEFUN |PFACET;setMult!;$I$;8| ((|orf| ($)) (|m| (|Integer|)) ($ ($)))
        (SEQ (PROGN (RPLACA |orf| |m|) (QCAR |orf|)) (EXIT |orf|))) 

(SDEFUN |PFACET;addVertex2;$R$;9|
        ((|sa| ($))
         (|v|
          (|Record| (|:| |left| (|NonNegativeInteger|))
                    (|:| |right| (|NonNegativeInteger|))))
         ($ ($)))
        (SPROG
         ((|f|
           (|List|
            (|Record| (|:| |left| (|NonNegativeInteger|))
                      (|:| |right| (|NonNegativeInteger|))))))
         (SEQ (LETT |f| (SPADCALL |sa| (QREFELT $ 14)))
              (LETT |f| (SPADCALL |f| |v| (QREFELT $ 21)))
              (EXIT (SPADCALL 1 |f| (QREFELT $ 10)))))) 

(SDEFUN |PFACET;=;2$B;10| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G760 NIL) (#2=#:G761 NIL) (|inda| NIL) (#3=#:G762 NIL)
          (|indb| NIL)
          (|indbs|
           #4=(|List|
               (|Record| (|:| |left| (|NonNegativeInteger|))
                         (|:| |right| (|NonNegativeInteger|)))))
          (|indas| #4#))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL (QCAR |a|) (QCAR |b|) (QREFELT $ 24))
              (PROGN (LETT #1# NIL) (GO #5=#:G759))))
            (LETT |indas| (SPADCALL |a| (QREFELT $ 14)))
            (LETT |indbs| (SPADCALL |b| (QREFELT $ 14)))
            (COND
             ((SPADCALL (LENGTH |indas|) (LENGTH |indbs|) (QREFELT $ 24))
              (PROGN (LETT #1# NIL) (GO #5#))))
            (SEQ (LETT |indb| NIL) (LETT #3# |indbs|) (LETT |inda| NIL)
                 (LETT #2# |indas|) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |inda| (CAR #2#)) NIL)
                       (ATOM #3#) (PROGN (LETT |indb| (CAR #3#)) NIL))
                   (GO G191)))
                 (SEQ
                  (COND
                   ((SPADCALL (QCAR |inda|) (QCAR |indb|) (QREFELT $ 24))
                    (PROGN (LETT #1# NIL) (GO #5#))))
                  (EXIT
                   (COND
                    ((SPADCALL (QCDR |inda|) (QCDR |indb|) (QREFELT $ 24))
                     (PROGN (LETT #1# NIL) (GO #5#))))))
                 (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#)))) (GO G190)
                 G191 (EXIT NIL))
            (EXIT 'T)))
          #5# (EXIT #1#)))) 

(SDEFUN |PFACET;coerce;$Of;11| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|body| (|OutputForm|)) (|elements| (|List| (|OutputForm|)))
          (|element| (|OutputForm|)) (|r| (|NonNegativeInteger|))
          (|l| (|NonNegativeInteger|)) (#1=#:G772 NIL) (|x| NIL)
          (|prefix| (|OutputForm|)) (|m| (|Integer|)))
         (SEQ (LETT |prefix| (SPADCALL "" (QREFELT $ 28)))
              (LETT |m| (QCAR |s|))
              (COND
               ((SPADCALL (ABS |m|) 1 (QREFELT $ 24))
                (LETT |prefix|
                      (SPADCALL (SPADCALL |m| (QREFELT $ 29))
                                (SPADCALL "*" (QREFELT $ 28))
                                (QREFELT $ 30)))))
              (COND
               ((EQL |m| -1) (LETT |prefix| (SPADCALL "-" (QREFELT $ 28)))))
              (LETT |elements| NIL)
              (SEQ (LETT |x| NIL) (LETT #1# (QCDR |s|)) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |l| (QCAR |x|)) (LETT |r| (QCDR |x|))
                        (LETT |element|
                              (SPADCALL
                               (LIST (SPADCALL |l| (QREFELT $ 31))
                                     (SPADCALL |r| (QREFELT $ 31)))
                               (QREFELT $ 33)))
                        (EXIT
                         (LETT |elements|
                               (SPADCALL |elements| |element|
                                         (QREFELT $ 35)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (LETT |body| (SPADCALL |elements| (QREFELT $ 36)))
              (EXIT (SPADCALL |prefix| |body| (QREFELT $ 30)))))) 

(DECLAIM (NOTINLINE |ProductFacet;|)) 

(DEFUN |ProductFacet| ()
  (SPROG NIL
         (PROG (#1=#:G776)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ProductFacet|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ProductFacet|
                             (LIST (CONS NIL (CONS 1 (|ProductFacet;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|ProductFacet|)))))))))) 

(DEFUN |ProductFacet;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ProductFacet|))
          (LETT $ (GETREFV 40))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ProductFacet| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |mul| (|Integer|))
                              (|:| |ind|
                                   (|List|
                                    (|Record|
                                     (|:| |left| (|NonNegativeInteger|))
                                     (|:| |right| (|NonNegativeInteger|)))))))
          $))) 

(MAKEPROP '|ProductFacet| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Integer|)
              (|Record| (|:| |left| 15) (|:| |right| 15)) (|List| 8)
              |PFACET;productFacet;IL$;1| (|ProductFacet|) (0 . |getIndexs|)
              |PFACET;productFacet;I2$;2| |PFACET;getIndexs;$L;3|
              (|NonNegativeInteger|) |PFACET;getMaxLeft;$Nni;4|
              |PFACET;getMaxRight;$Nni;5| |PFACET;order;$Nni;6|
              |PFACET;getMult;$I;7| |PFACET;setMult!;$I$;8| (5 . |concat|)
              |PFACET;addVertex2;$R$;9| (|Boolean|) (11 . ~=) |PFACET;=;2$B;10|
              (|String|) (|OutputForm|) (17 . |message|) (22 . |coerce|)
              (27 . |hconcat|) (33 . |coerce|) (|List| $) (38 . |bracket|)
              (|List| 27) (43 . |concat|) (49 . |paren|) |PFACET;coerce;$Of;11|
              (|SingleInteger|) (|HashState|))
           '#(~= 54 |smaller?| 60 |setMult!| 66 |productFacet| 72 |order| 84
              |min| 89 |max| 95 |latex| 101 |hashUpdate!| 106 |hash| 112
              |getMult| 117 |getMaxRight| 122 |getMaxLeft| 127 |getIndexs| 132
              |empty?| 137 |coerce| 142 |addVertex2| 147 >= 153 > 159 = 165 <=
              171 < 177)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0))
                 (CONS
                  '#(|FacetCategory&| |OrderedSet&| NIL |SetCategory&|
                     |PartialOrder&| |BasicType&| NIL)
                  (CONS
                   '#((|FacetCategory|) (|OrderedSet|) (|Comparable|)
                      (|SetCategory|) (|PartialOrder|) (|BasicType|)
                      (|CoercibleTo| 27))
                   (|makeByteWordVec2| 39
                                       '(1 11 9 0 12 2 9 0 0 8 21 2 7 23 0 0 24
                                         1 27 0 26 28 1 7 27 0 29 2 27 0 0 0 30
                                         1 15 27 0 31 1 27 0 32 33 2 34 0 0 27
                                         35 1 27 0 32 36 2 0 23 0 0 1 2 0 23 0
                                         0 1 2 0 0 0 7 20 2 0 0 7 11 13 2 0 0 7
                                         9 10 1 0 15 0 18 2 0 0 0 0 1 2 0 0 0 0
                                         1 1 0 26 0 1 2 0 39 39 0 1 1 0 38 0 1
                                         1 0 7 0 19 1 0 15 0 17 1 0 15 0 16 1 0
                                         9 0 14 1 0 23 0 1 1 0 27 0 37 2 0 0 0
                                         8 22 2 0 23 0 0 1 2 0 23 0 0 1 2 0 23
                                         0 0 25 2 0 23 0 0 1 2 0 23 0 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|ProductFacet| 'NILADIC T) 

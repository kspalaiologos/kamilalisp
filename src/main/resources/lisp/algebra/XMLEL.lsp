
(PUT '|XMLEL;xmlElement;SLL$;1| '|SPADreplace|
     '(XLAM (|name| |elements| |attributes|)
       (VECTOR |name| |elements| |attributes| ""))) 

(SDEFUN |XMLEL;xmlElement;SLL$;1|
        ((|name| (|String|)) (|elements| (|List| $))
         (|attributes| (|List| (|XmlAttribute|))) ($ ($)))
        (VECTOR |name| |elements| |attributes| "")) 

(PUT '|XMLEL;xmlElement;2SL$;2| '|SPADreplace|
     '(XLAM (|name| |txt| |attributes|) (VECTOR |name| NIL |attributes| |txt|))) 

(SDEFUN |XMLEL;xmlElement;2SL$;2|
        ((|name| (|String|)) (|txt| (|String|))
         (|attributes| (|List| (|XmlAttribute|))) ($ ($)))
        (VECTOR |name| NIL |attributes| |txt|)) 

(SDEFUN |XMLEL;outputStructured| ((|rp| ($)) ($ (|List| (|String|))))
        (SPROG
         ((|res| (|List| #1=(|String|))) (#2=#:G731 NIL) (|el| NIL)
          (|atts| #1#) (#3=#:G730 NIL) (|s| NIL) (#4=#:G729 NIL))
         (SEQ
          (LETT |atts|
                (SPADCALL
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |s| NIL) (LETT #3# (QVELT |rp| 2)) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |s| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #4# (CONS (SPADCALL |s| (QREFELT $ 13)) #4#))))
                       (LETT #3# (CDR #3#)) (GO G190) G191
                       (EXIT (NREVERSE #4#))))
                 (QREFELT $ 14)))
          (EXIT
           (COND
            ((< (SPADCALL (QVELT |rp| 1) (QREFELT $ 17)) 1)
             (LIST
              (SPADCALL (LIST "<" (QVELT |rp| 0) |atts| " />")
                        (QREFELT $ 14))))
            ('T
             (SEQ
              (LETT |res|
                    (LIST
                     (SPADCALL (LIST "<" (QVELT |rp| 0) |atts| ">")
                               (QREFELT $ 14))))
              (SEQ (LETT |el| NIL) (LETT #2# (QVELT |rp| 1)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |el| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res| (SPADCALL |el| (QREFELT $ 19))
                                     (QREFELT $ 20)))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |res|
                         (SPADCALL (LIST "</" (QVELT |rp| 0) ">")
                                   (QREFELT $ 14))
                         (QREFELT $ 21)))))))))) 

(SDEFUN |XMLEL;outputUnstructured| ((|rp| ($)) ($ (|List| (|String|))))
        (SPROG
         ((|res| (|List| #1=(|String|))) (|atts| #1#) (#2=#:G737 NIL) (|s| NIL)
          (#3=#:G736 NIL))
         (SEQ
          (LETT |atts|
                (SPADCALL
                 (PROGN
                  (LETT #3# NIL)
                  (SEQ (LETT |s| NIL) (LETT #2# (QVELT |rp| 2)) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |s| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #3# (CONS (SPADCALL |s| (QREFELT $ 13)) #3#))))
                       (LETT #2# (CDR #2#)) (GO G190) G191
                       (EXIT (NREVERSE #3#))))
                 (QREFELT $ 14)))
          (LETT |res|
                (LIST
                 (SPADCALL (LIST "<" (QVELT |rp| 0) |atts| ">")
                           (QREFELT $ 14))))
          (LETT |res| (SPADCALL |res| (QVELT |rp| 3) (QREFELT $ 21)))
          (EXIT
           (SPADCALL |res|
                     (SPADCALL (LIST "</" (QVELT |rp| 0) ">") (QREFELT $ 14))
                     (QREFELT $ 21)))))) 

(SDEFUN |XMLEL;coerce;$L;5| ((|rp| ($)) ($ (|List| (|String|))))
        (COND ((EQUAL (QVELT |rp| 3) "") (|XMLEL;outputStructured| |rp| $))
              ('T (|XMLEL;outputUnstructured| |rp| $)))) 

(SDEFUN |XMLEL;empty?;$B;6| ((|el| ($)) ($ (|Boolean|)))
        (COND ((EQUAL (QVELT |el| 0) "") 'T) ('T NIL))) 

(SDEFUN |XMLEL;outputVRML;$TfV;7| ((|rp| ($)) (|f1| (|TextFile|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G766 NIL) (|el| NIL) (#2=#:G765 NIL) (|att| NIL)
          (#3=#:G763 NIL) (#4=#:G764 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((OR (EQUAL (QVELT |rp| 0) "X3D") (EQUAL (QVELT |rp| 0) "Scene"))
              (SEQ
               (SEQ (LETT |el| NIL) (LETT #4# (QVELT |rp| 1)) G190
                    (COND
                     ((OR (ATOM #4#) (PROGN (LETT |el| (CAR #4#)) NIL))
                      (GO G191)))
                    (SEQ (EXIT (SPADCALL |el| |f1| (QREFELT $ 26))))
                    (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
               (EXIT (PROGN (LETT #3# (|Void|)) (GO #5=#:G762))))))
            (SPADCALL |f1| (STRCONC (QVELT |rp| 0) "{") (QREFELT $ 27))
            (COND
             ((EQUAL (QVELT |rp| 0) "Shape")
              (SPADCALL |f1| "geometry" (QREFELT $ 27))))
            (SEQ (LETT |att| NIL) (LETT #2# (QVELT |rp| 2)) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |att| (CAR #2#)) NIL))
                   (GO G191)))
                 (SEQ (EXIT (SPADCALL |att| |f1| (QREFELT $ 28))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
            (COND
             ((> (SPADCALL (QVELT |rp| 1) (QREFELT $ 17)) 0)
              (SEQ
               (COND
                ((EQUAL (QVELT |rp| 0) "Transform")
                 (SPADCALL |f1| "children[" (QREFELT $ 27))))
               (SEQ (LETT |el| NIL) (LETT #1# (QVELT |rp| 1)) G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |el| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ (EXIT (SPADCALL |el| |f1| (QREFELT $ 26))))
                    (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
               (EXIT
                (COND
                 ((EQUAL (QVELT |rp| 0) "Transform")
                  (SPADCALL |f1| "]" (QREFELT $ 27))))))))
            (SPADCALL |f1| "}" (QREFELT $ 27)) (EXIT (|Void|))))
          #5# (EXIT #3#)))) 

(DECLAIM (NOTINLINE |XmlElement;|)) 

(DEFUN |XmlElement| ()
  (SPROG NIL
         (PROG (#1=#:G768)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|XmlElement|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|XmlElement|
                             (LIST (CONS NIL (CONS 1 (|XmlElement;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|XmlElement|)))))))))) 

(DEFUN |XmlElement;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|XmlElement|))
          (LETT $ (GETREFV 29))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|XmlElement| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |n| (|String|)) (|:| |e| (|List| $))
                              (|:| |a| (|List| (|XmlAttribute|)))
                              (|:| |content| (|String|))))
          $))) 

(MAKEPROP '|XmlElement| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|String|) (|List| $) (|List| 12)
              |XMLEL;xmlElement;SLL$;1| |XMLEL;xmlElement;2SL$;2|
              (|XmlAttribute|) (0 . |coerce|) (5 . |concat|)
              (|NonNegativeInteger|) (|List| $$) (10 . |#|) (|List| 7)
              |XMLEL;coerce;$L;5| (15 . |concat|) (21 . |concat|) (|Boolean|)
              |XMLEL;empty?;$B;6| (|Void|) (|TextFile|)
              |XMLEL;outputVRML;$TfV;7| (27 . |writeLine!|)
              (33 . |outputVRML|))
           '#(|xmlElement| 39 |outputVRML| 53 |empty?| 59 |coerce| 64) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|xmlElement|
                                 ($$ (|String|) (|List| $$)
                                  (|List| (|XmlAttribute|))))
                                T)
                              '((|xmlElement|
                                 ($$ (|String|) (|String|)
                                  (|List| (|XmlAttribute|))))
                                T)
                              '((|empty?| ((|Boolean|) $$)) T)
                              '((|coerce| ((|List| (|String|)) $$)) T)
                              '((|outputVRML| ((|Void|) $$ (|TextFile|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 28
                                            '(1 12 7 0 13 1 7 0 8 14 1 16 15 0
                                              17 2 18 0 0 0 20 2 18 0 0 7 21 2
                                              25 7 0 7 27 2 12 24 0 25 28 3 0 0
                                              7 7 9 11 3 0 0 7 8 9 10 2 0 24 0
                                              25 26 1 0 22 0 23 1 0 18 0
                                              19)))))
           '|lookupComplete|)) 

(MAKEPROP '|XmlElement| 'NILADIC T) 

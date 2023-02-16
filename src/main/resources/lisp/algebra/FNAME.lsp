
(PUT '|FNAME;=;2$B;1| '|SPADreplace| 'EQUAL) 

(SDEFUN |FNAME;=;2$B;1| ((|f1| ($)) (|f2| ($)) ($ (|Boolean|)))
        (EQUAL |f1| |f2|)) 

(SDEFUN |FNAME;coerce;$Of;2| ((|f| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |f| (QREFELT $ 9)) (QREFELT $ 11))) 

(PUT '|FNAME;coerce;$S;3| '|SPADreplace| 'NAMESTRING) 

(SDEFUN |FNAME;coerce;$S;3| ((|f| ($)) ($ (|String|))) (NAMESTRING |f|)) 

(PUT '|FNAME;coerce;S$;4| '|SPADreplace| 'PARSE-NAMESTRING) 

(SDEFUN |FNAME;coerce;S$;4| ((|s| (|String|)) ($ ($))) (PARSE-NAMESTRING |s|)) 

(PUT '|FNAME;filename;3S$;5| '|SPADreplace| '|fnameMake|) 

(SDEFUN |FNAME;filename;3S$;5|
        ((|d| #1=(|String|)) (|n| #1#) (|e| #1#) ($ ($)))
        (|fnameMake| |d| |n| |e|)) 

(PUT '|FNAME;directory;$S;6| '|SPADreplace| '|fnameDirectory|) 

(SDEFUN |FNAME;directory;$S;6| ((|f| ($)) ($ (|String|)))
        (|fnameDirectory| |f|)) 

(PUT '|FNAME;name;$S;7| '|SPADreplace| '|fnameName|) 

(SDEFUN |FNAME;name;$S;7| ((|f| ($)) ($ (|String|))) (|fnameName| |f|)) 

(PUT '|FNAME;extension;$S;8| '|SPADreplace| '|fnameType|) 

(SDEFUN |FNAME;extension;$S;8| ((|f| ($)) ($ (|String|))) (|fnameType| |f|)) 

(PUT '|FNAME;exists?;$B;9| '|SPADreplace| '|fnameExists?|) 

(SDEFUN |FNAME;exists?;$B;9| ((|f| ($)) ($ (|Boolean|))) (|fnameExists?| |f|)) 

(PUT '|FNAME;readable?;$B;10| '|SPADreplace| '|fnameReadable?|) 

(SDEFUN |FNAME;readable?;$B;10| ((|f| ($)) ($ (|Boolean|)))
        (|fnameReadable?| |f|)) 

(PUT '|FNAME;writable?;$B;11| '|SPADreplace| '|fnameWritable?|) 

(SDEFUN |FNAME;writable?;$B;11| ((|f| ($)) ($ (|Boolean|)))
        (|fnameWritable?| |f|)) 

(PUT '|FNAME;new;3S$;12| '|SPADreplace| '|fnameNew|) 

(SDEFUN |FNAME;new;3S$;12| ((|d| #1=(|String|)) (|pref| #1#) (|e| #1#) ($ ($)))
        (|fnameNew| |d| |pref| |e|)) 

(DECLAIM (NOTINLINE |FileName;|)) 

(DEFUN |FileName| ()
  (SPROG NIL
         (PROG (#1=#:G707)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|FileName|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|FileName|
                             (LIST (CONS NIL (CONS 1 (|FileName;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|FileName|)))))))))) 

(DEFUN |FileName;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|FileName|))
          (LETT $ (GETREFV 24))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FileName| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FileName| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Boolean|) |FNAME;=;2$B;1| (|String|)
              |FNAME;coerce;$S;3| (|OutputForm|) (0 . |coerce|)
              |FNAME;coerce;$Of;2| |FNAME;coerce;S$;4| |FNAME;filename;3S$;5|
              |FNAME;directory;$S;6| |FNAME;name;$S;7| |FNAME;extension;$S;8|
              |FNAME;exists?;$B;9| |FNAME;readable?;$B;10|
              |FNAME;writable?;$B;11| |FNAME;new;3S$;12| (|HashState|)
              (|SingleInteger|))
           '#(~= 5 |writable?| 11 |readable?| 16 |new| 21 |name| 28 |latex| 33
              |hashUpdate!| 38 |hash| 44 |filename| 49 |extension| 56 |exists?|
              61 |directory| 66 |coerce| 71 = 86)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|FileNameCategory|) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 10))
                        (|makeByteWordVec2| 23
                                            '(1 8 10 0 11 2 0 6 0 0 1 1 0 6 0
                                              20 1 0 6 0 19 3 0 0 8 8 8 21 1 0
                                              8 0 16 1 0 8 0 1 2 0 22 22 0 1 1
                                              0 23 0 1 3 0 0 8 8 8 14 1 0 8 0
                                              17 1 0 6 0 18 1 0 8 0 15 1 0 0 8
                                              13 1 0 8 0 9 1 0 10 0 12 2 0 6 0
                                              0 7)))))
           '|lookupComplete|)) 

(MAKEPROP '|FileName| 'NILADIC T) 

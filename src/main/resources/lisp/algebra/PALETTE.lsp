
(PUT '|PALETTE;dark;C$;1| '|SPADreplace| '(XLAM (|c|) (CONS 1 |c|))) 

(SDEFUN |PALETTE;dark;C$;1| ((|c| (|Color|)) ($ ($))) (CONS 1 |c|)) 

(PUT '|PALETTE;dim;C$;2| '|SPADreplace| '(XLAM (|c|) (CONS 2 |c|))) 

(SDEFUN |PALETTE;dim;C$;2| ((|c| (|Color|)) ($ ($))) (CONS 2 |c|)) 

(PUT '|PALETTE;bright;C$;3| '|SPADreplace| '(XLAM (|c|) (CONS 3 |c|))) 

(SDEFUN |PALETTE;bright;C$;3| ((|c| (|Color|)) ($ ($))) (CONS 3 |c|)) 

(PUT '|PALETTE;pastel;C$;4| '|SPADreplace| '(XLAM (|c|) (CONS 4 |c|))) 

(SDEFUN |PALETTE;pastel;C$;4| ((|c| (|Color|)) ($ ($))) (CONS 4 |c|)) 

(PUT '|PALETTE;light;C$;5| '|SPADreplace| '(XLAM (|c|) (CONS 5 |c|))) 

(SDEFUN |PALETTE;light;C$;5| ((|c| (|Color|)) ($ ($))) (CONS 5 |c|)) 

(PUT '|PALETTE;hue;$C;6| '|SPADreplace| 'QCDR) 

(SDEFUN |PALETTE;hue;$C;6| ((|p| ($)) ($ (|Color|))) (QCDR |p|)) 

(PUT '|PALETTE;shade;$I;7| '|SPADreplace| 'QCAR) 

(SDEFUN |PALETTE;shade;$I;7| ((|p| ($)) ($ (|Integer|))) (QCAR |p|)) 

(SDEFUN |PALETTE;coerce;C$;8| ((|c| (|Color|)) ($ ($)))
        (SPADCALL |c| (QREFELT $ 10))) 

(SDEFUN |PALETTE;coerce;$Of;9| ((|p| ($)) ($ (|OutputForm|)))
        (SPADCALL
         (LIST (SPADCALL "[" (QREFELT $ 19))
               (SPADCALL (QCDR |p|) (QREFELT $ 20))
               (SPADCALL "] from the " (QREFELT $ 19))
               (SPADCALL
                (SPADCALL (LIST "Dark" "Dim" "Bright" "Pastel" "Light")
                          (QCAR |p|) (QREFELT $ 22))
                (QREFELT $ 19))
               (SPADCALL " palette" (QREFELT $ 19)))
         (QREFELT $ 24))) 

(DECLAIM (NOTINLINE |Palette;|)) 

(DEFUN |Palette| ()
  (SPROG NIL
         (PROG (#1=#:G721)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Palette|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Palette|
                             (LIST (CONS NIL (CONS 1 (|Palette;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Palette|)))))))))) 

(DEFUN |Palette;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Palette|))
          (LETT $ (GETREFV 29))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Palette| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |shadeField| (|Integer|))
                              (|:| |hueField| (|Color|))))
          $))) 

(MAKEPROP '|Palette| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Color|) |PALETTE;dark;C$;1|
              |PALETTE;dim;C$;2| |PALETTE;bright;C$;3| |PALETTE;pastel;C$;4|
              |PALETTE;light;C$;5| |PALETTE;hue;$C;6| (|Integer|)
              |PALETTE;shade;$I;7| |PALETTE;coerce;C$;8| (|String|)
              (|OutputForm|) (0 . |message|) (5 . |coerce|) (|List| 17)
              (10 . |elt|) (|List| $) (16 . |hconcat|) |PALETTE;coerce;$Of;9|
              (|HashState|) (|SingleInteger|) (|Boolean|))
           '#(~= 21 |shade| 27 |pastel| 32 |light| 37 |latex| 42 |hue| 47
              |hashUpdate!| 52 |hash| 58 |dim| 63 |dark| 68 |coerce| 73
              |bright| 83 = 88)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 18))
                        (|makeByteWordVec2| 28
                                            '(1 18 0 17 19 1 7 18 0 20 2 21 17
                                              0 14 22 1 18 0 23 24 2 0 28 0 0 1
                                              1 0 14 0 15 1 0 0 7 11 1 0 0 7 12
                                              1 0 17 0 1 1 0 7 0 13 2 0 26 26 0
                                              1 1 0 27 0 1 1 0 0 7 9 1 0 0 7 8
                                              1 0 0 7 16 1 0 18 0 25 1 0 0 7 10
                                              2 0 28 0 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|Palette| 'NILADIC T) 

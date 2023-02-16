
(PUT '|OMCONN;OMmakeConn;Si$;1| '|SPADreplace| 'OM-MAKECONN) 

(SDEFUN |OMCONN;OMmakeConn;Si$;1| ((|timeout| (|SingleInteger|)) ($ ($)))
        (OM-MAKECONN |timeout|)) 

(PUT '|OMCONN;OMcloseConn;$V;2| '|SPADreplace| 'OM-CLOSECONN) 

(SDEFUN |OMCONN;OMcloseConn;$V;2| ((|conn| ($)) ($ (|Void|)))
        (OM-CLOSECONN |conn|)) 

(PUT '|OMCONN;OMconnInDevice;$Omd;3| '|SPADreplace| 'OM-GETCONNINDEV) 

(SDEFUN |OMCONN;OMconnInDevice;$Omd;3| ((|conn| ($)) ($ (|OpenMathDevice|)))
        (OM-GETCONNINDEV |conn|)) 

(PUT '|OMCONN;OMconnOutDevice;$Omd;4| '|SPADreplace| 'OM-GETCONNOUTDEV) 

(SDEFUN |OMCONN;OMconnOutDevice;$Omd;4| ((|conn| ($)) ($ (|OpenMathDevice|)))
        (OM-GETCONNOUTDEV |conn|)) 

(PUT '|OMCONN;OMconnectTCP;$SSiB;5| '|SPADreplace| 'OM-CONNECTTCP) 

(SDEFUN |OMCONN;OMconnectTCP;$SSiB;5|
        ((|conn| ($)) (|host| (|String|)) (|port| (|SingleInteger|))
         ($ (|Boolean|)))
        (OM-CONNECTTCP |conn| |host| |port|)) 

(PUT '|OMCONN;OMbindTCP;$SiB;6| '|SPADreplace| 'OM-BINDTCP) 

(SDEFUN |OMCONN;OMbindTCP;$SiB;6|
        ((|conn| ($)) (|port| (|SingleInteger|)) ($ (|Boolean|)))
        (OM-BINDTCP |conn| |port|)) 

(DECLAIM (NOTINLINE |OpenMathConnection;|)) 

(DEFUN |OpenMathConnection| ()
  (SPROG NIL
         (PROG (#1=#:G698)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OpenMathConnection|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OpenMathConnection|
                             (LIST
                              (CONS NIL (CONS 1 (|OpenMathConnection;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|OpenMathConnection|)))))))))) 

(DEFUN |OpenMathConnection;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OpenMathConnection|))
          (LETT $ (GETREFV 17))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OpenMathConnection| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OpenMathConnection| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|SingleInteger|)
              |OMCONN;OMmakeConn;Si$;1| (|Void|) |OMCONN;OMcloseConn;$V;2|
              (|OpenMathDevice|) |OMCONN;OMconnInDevice;$Omd;3|
              |OMCONN;OMconnOutDevice;$Omd;4| (|Boolean|) (|String|)
              |OMCONN;OMconnectTCP;$SSiB;5| |OMCONN;OMbindTCP;$SiB;6|)
           '#(|OMmakeConn| 0 |OMconnectTCP| 5 |OMconnOutDevice| 12
              |OMconnInDevice| 17 |OMcloseConn| 22 |OMbindTCP| 27)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|OMmakeConn| ($$ (|SingleInteger|))) T)
                                   '((|OMcloseConn| ((|Void|) $$)) T)
                                   '((|OMconnInDevice| ((|OpenMathDevice|) $$))
                                     T)
                                   '((|OMconnOutDevice|
                                      ((|OpenMathDevice|) $$))
                                     T)
                                   '((|OMconnectTCP|
                                      ((|Boolean|) $$ (|String|)
                                       (|SingleInteger|)))
                                     T)
                                   '((|OMbindTCP|
                                      ((|Boolean|) $$ (|SingleInteger|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 16
                                            '(1 0 0 6 7 3 0 13 0 14 6 15 1 0 10
                                              0 12 1 0 10 0 11 1 0 8 0 9 2 0 13
                                              0 6 16)))))
           '|lookupComplete|)) 

(MAKEPROP '|OpenMathConnection| 'NILADIC T) 

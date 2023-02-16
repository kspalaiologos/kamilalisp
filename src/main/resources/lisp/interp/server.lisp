
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFCONSTANT($SessionManager, 1)

(DEFCONSTANT |$SessionManager| 1)

; DEFCONSTANT($ViewportServer, 2)

(DEFCONSTANT |$ViewportServer| 2)

; DEFCONSTANT($MenuServer, 3)

(DEFCONSTANT |$MenuServer| 3)

; DEFCONSTANT($SessionIO, 4)

(DEFCONSTANT |$SessionIO| 4)

; DEFCONSTANT($MessageServer, 5)

(DEFCONSTANT |$MessageServer| 5)

; DEFCONSTANT($InterpWindow, 6)

(DEFCONSTANT |$InterpWindow| 6)

; DEFCONSTANT($KillSpad, 7)

(DEFCONSTANT |$KillSpad| 7)

; DEFCONSTANT($DebugWindow, 8)

(DEFCONSTANT |$DebugWindow| 8)

; DEFCONSTANT($Forker, 9)

(DEFCONSTANT |$Forker| 9)

; DEFCONSTANT($CreateFrame, 1)

(DEFCONSTANT |$CreateFrame| 1)

; DEFCONSTANT($SwitchFrames, 2)

(DEFCONSTANT |$SwitchFrames| 2)

; DEFCONSTANT($EndOfOutput, 3)

(DEFCONSTANT |$EndOfOutput| 3)

; DEFCONSTANT($CallInterp, 4)

(DEFCONSTANT |$CallInterp| 4)

; DEFCONSTANT($EndSession, 5)

(DEFCONSTANT |$EndSession| 5)

; DEFCONSTANT($LispCommand, 6)

(DEFCONSTANT |$LispCommand| 6)

; DEFCONSTANT($SpadCommand, 7)

(DEFCONSTANT |$SpadCommand| 7)

; DEFCONSTANT($SendXEventToHyperTeX, 8)

(DEFCONSTANT |$SendXEventToHyperTeX| 8)

; DEFCONSTANT($QuietSpadCommand, 9)

(DEFCONSTANT |$QuietSpadCommand| 9)

; DEFCONSTANT($CloseClient, 10)

(DEFCONSTANT |$CloseClient| 10)

; DEFCONSTANT($QueryClients, 11)

(DEFCONSTANT |$QueryClients| 11)

; DEFCONSTANT($QuerySpad, 12)

(DEFCONSTANT |$QuerySpad| 12)

; DEFCONSTANT($NonSmanSession, 13)

(DEFCONSTANT |$NonSmanSession| 13)

; DEFCONSTANT($KillLispSystem, 14)

(DEFCONSTANT |$KillLispSystem| 14)

; DEFCONSTANT($CreateFrameAnswer, 50)

(DEFCONSTANT |$CreateFrameAnswer| 50)

; DEFPARAMETER($frameAlist, nil)

(DEFPARAMETER |$frameAlist| NIL)

; DEFPARAMETER($frameNumber, 0)

(DEFPARAMETER |$frameNumber| 0)

; DEFPARAMETER($currentFrameNum, 0)

(DEFPARAMETER |$currentFrameNum| 0)

; DEFPARAMETER($EndServerSession, false)

(DEFPARAMETER |$EndServerSession| NIL)

; DEFPARAMETER($NeedToSignalSessionManager, false)

(DEFPARAMETER |$NeedToSignalSessionManager| NIL)

; serverReadLine(stream) ==
; -- used in place of read_-line in a scratchpad server system.
;   FORCE_-OUTPUT()
;   not $SpadServer =>
;       read_line(stream)
;   _*EOF_*: fluid := NIL
;   line :=
;    while not $EndServerSession and not _*EOF_* repeat
;     if $NeedToSignalSessionManager then
;       sockSendInt($SessionManager, $EndOfOutput)
;     $NeedToSignalSessionManager := false
;     action := serverSwitch()
;     action = $CallInterp =>
;       l := read_line(stream)
;       $NeedToSignalSessionManager := true
;       return l
;     action = $CreateFrame =>
;       frameName := GENTEMP('"frame")
;       addNewInterpreterFrame(frameName)
;       $frameAlist := [[$frameNumber,:frameName], :$frameAlist]
;       $currentFrameNum := $frameNumber
;       sockSendInt($SessionManager, $CreateFrameAnswer)
;       sockSendInt($SessionManager, $frameNumber)
;       $frameNumber := $frameNumber + 1
; --  MRX I'm not sure whether I should call ioHook("startPrompt")/ioHook("endOfPrompt") here
;       sockSendString($SessionManager, MKPROMPT())
;     action = $SwitchFrames =>
;       $currentFrameNum := sockGetInt($SessionManager)
;       currentFrame := LASSOC($currentFrameNum, $frameAlist)
;       changeToNamedInterpreterFrame currentFrame
;     action = $EndSession =>
;       $EndServerSession := true
;     action = $LispCommand =>
;       $NeedToSignalSessionManager := true
;       stringBuf := sockGetStringFrom($MenuServer)
;       form := unescapeStringsInForm READ_-FROM_-STRING stringBuf
;       protectedEVAL form
;     action = $QuietSpadCommand =>
;       $NeedToSignalSessionManager := true
;       executeQuietCommand()
;     action = $SpadCommand =>
;       $NeedToSignalSessionManager := true
;       stringBuf := sockGetStringFrom($MenuServer)
;       CATCH('coerceFailure, CATCH('top_level, CATCH('SPAD_READER,
;         parseAndInterpret stringBuf)))
; --  MRX I'm not sure whether I should call ioHook("startPrompt")/ioHook("endOfPrompt") here
;       princPrompt()
;       FORCE_-OUTPUT()
;     action = $NonSmanSession =>
;       $SpadServer := nil
;     action = $KillLispSystem =>
;       QUIT()
;     NIL
;   line => line
;   ""

(DEFUN |serverReadLine| (|stream|)
  (PROG (*EOF* |line| |form| |stringBuf| |currentFrame| |frameName| |l|
         |action|)
    (DECLARE (SPECIAL *EOF*))
    (RETURN
     (PROGN
      (FORCE-OUTPUT)
      (COND ((NULL |$SpadServer|) (|read_line| |stream|))
            (#1='T
             (PROGN
              (SETQ *EOF* NIL)
              (SETQ |line|
                      ((LAMBDA ()
                         (LOOP
                          (COND
                           ((NOT (AND (NULL |$EndServerSession|) (NULL *EOF*)))
                            (RETURN NIL))
                           (#1#
                            (PROGN
                             (COND
                              (|$NeedToSignalSessionManager|
                               (|sockSendInt| |$SessionManager|
                                              |$EndOfOutput|)))
                             (SETQ |$NeedToSignalSessionManager| NIL)
                             (SETQ |action| (|serverSwitch|))
                             (COND
                              ((EQUAL |action| |$CallInterp|)
                               (PROGN
                                (SETQ |l| (|read_line| |stream|))
                                (SETQ |$NeedToSignalSessionManager| T)
                                (RETURN |l|)))
                              ((EQUAL |action| |$CreateFrame|)
                               (PROGN
                                (SETQ |frameName| (GENTEMP "frame"))
                                (|addNewInterpreterFrame| |frameName|)
                                (SETQ |$frameAlist|
                                        (CONS (CONS |$frameNumber| |frameName|)
                                              |$frameAlist|))
                                (SETQ |$currentFrameNum| |$frameNumber|)
                                (|sockSendInt| |$SessionManager|
                                               |$CreateFrameAnswer|)
                                (|sockSendInt| |$SessionManager|
                                               |$frameNumber|)
                                (SETQ |$frameNumber| (+ |$frameNumber| 1))
                                (|sockSendString| |$SessionManager|
                                                  (MKPROMPT))))
                              ((EQUAL |action| |$SwitchFrames|)
                               (PROGN
                                (SETQ |$currentFrameNum|
                                        (|sockGetInt| |$SessionManager|))
                                (SETQ |currentFrame|
                                        (LASSOC |$currentFrameNum|
                                         |$frameAlist|))
                                (|changeToNamedInterpreterFrame|
                                 |currentFrame|)))
                              ((EQUAL |action| |$EndSession|)
                               (SETQ |$EndServerSession| T))
                              ((EQUAL |action| |$LispCommand|)
                               (PROGN
                                (SETQ |$NeedToSignalSessionManager| T)
                                (SETQ |stringBuf|
                                        (|sockGetStringFrom| |$MenuServer|))
                                (SETQ |form|
                                        (|unescapeStringsInForm|
                                         (READ-FROM-STRING |stringBuf|)))
                                (|protectedEVAL| |form|)))
                              ((EQUAL |action| |$QuietSpadCommand|)
                               (PROGN
                                (SETQ |$NeedToSignalSessionManager| T)
                                (|executeQuietCommand|)))
                              ((EQUAL |action| |$SpadCommand|)
                               (PROGN
                                (SETQ |$NeedToSignalSessionManager| T)
                                (SETQ |stringBuf|
                                        (|sockGetStringFrom| |$MenuServer|))
                                (CATCH '|coerceFailure|
                                  (CATCH '|top_level|
                                    (CATCH 'SPAD_READER
                                      (|parseAndInterpret| |stringBuf|))))
                                (|princPrompt|)
                                (FORCE-OUTPUT)))
                              ((EQUAL |action| |$NonSmanSession|)
                               (SETQ |$SpadServer| NIL))
                              ((EQUAL |action| |$KillLispSystem|) (QUIT))
                              (#1# NIL)))))))))
              (COND (|line| |line|) (#1# '||)))))))))

; parseAndInterpret str ==
;   $InteractiveMode :fluid := true
;   $e:fluid := $InteractiveFrame
;   ncParseAndInterpretString str

(DEFUN |parseAndInterpret| (|str|)
  (PROG (|$e| |$InteractiveMode|)
    (DECLARE (SPECIAL |$e| |$InteractiveMode|))
    (RETURN
     (PROGN
      (SETQ |$InteractiveMode| T)
      (SETQ |$e| |$InteractiveFrame|)
      (|ncParseAndInterpretString| |str|)))))

; executeQuietCommand() ==
;   $QuietCommand: fluid := true
;   sockGetStringFrom($MenuServer)
;   CATCH('coerceFailure, CATCH('top_level, CATCH('SPAD_READER,
;     parseAndInterpret stringBuf)))

(DEFUN |executeQuietCommand| ()
  (PROG (|$QuietCommand|)
    (DECLARE (SPECIAL |$QuietCommand|))
    (RETURN
     (PROGN
      (SETQ |$QuietCommand| T)
      (|sockGetStringFrom| |$MenuServer|)
      (CATCH '|coerceFailure|
        (CATCH '|top_level|
          (CATCH 'SPAD_READER (|parseAndInterpret| |stringBuf|))))))))

; parseAndEvalToHypertex str ==
;   lines := parseAndEvalToStringEqNum(str)
;   len := LENGTH lines
;   sockSendInt($MenuServer, len)
;   for s in lines repeat
;     sockSendString($MenuServer, s)

(DEFUN |parseAndEvalToHypertex| (|str|)
  (PROG (|lines| |len|)
    (RETURN
     (PROGN
      (SETQ |lines| (|parseAndEvalToStringEqNum| |str|))
      (SETQ |len| (LENGTH |lines|))
      (|sockSendInt| |$MenuServer| |len|)
      ((LAMBDA (|bfVar#1| |s|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |s| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           ('T (|sockSendString| |$MenuServer| |s|)))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       |lines| NIL)))))

; parseAndEvalToString str ==
;   $collectOutput:local := true
;   $outputLines: local := nil
;   $IOindex: local := nil
;   v := CATCH('SPAD_READER, CATCH('top_level, parseAndEvalStr str))
;   v = 'restart => ['"error"]
;   NREVERSE $outputLines

(DEFUN |parseAndEvalToString| (|str|)
  (PROG (|$IOindex| |$outputLines| |$collectOutput| |v|)
    (DECLARE (SPECIAL |$IOindex| |$outputLines| |$collectOutput|))
    (RETURN
     (PROGN
      (SETQ |$collectOutput| T)
      (SETQ |$outputLines| NIL)
      (SETQ |$IOindex| NIL)
      (SETQ |v|
              (CATCH 'SPAD_READER
                (CATCH '|top_level| (|parseAndEvalStr| |str|))))
      (COND ((EQ |v| '|restart|) (LIST "error"))
            ('T (NREVERSE |$outputLines|)))))))

; parseAndEvalToStringEqNum str ==
;   $collectOutput:local := true
;   $outputLines: local := nil
;   v := CATCH('SPAD_READER, CATCH('top_level, parseAndEvalStr str))
;   v = 'restart => ['"error"]
;   NREVERSE $outputLines

(DEFUN |parseAndEvalToStringEqNum| (|str|)
  (PROG (|$outputLines| |$collectOutput| |v|)
    (DECLARE (SPECIAL |$outputLines| |$collectOutput|))
    (RETURN
     (PROGN
      (SETQ |$collectOutput| T)
      (SETQ |$outputLines| NIL)
      (SETQ |v|
              (CATCH 'SPAD_READER
                (CATCH '|top_level| (|parseAndEvalStr| |str|))))
      (COND ((EQ |v| '|restart|) (LIST "error"))
            ('T (NREVERSE |$outputLines|)))))))

; parseAndInterpToString str ==
;   v := applyWithOutputToString('parseAndEvalStr, [str])
;   breakIntoLines rest v

(DEFUN |parseAndInterpToString| (|str|)
  (PROG (|v|)
    (RETURN
     (PROGN
      (SETQ |v| (|applyWithOutputToString| '|parseAndEvalStr| (LIST |str|)))
      (|breakIntoLines| (CDR |v|))))))

; parseAndEvalStr string ==
;   $InteractiveMode :fluid := true
;   $e:fluid := $InteractiveFrame
;   parseAndEvalStr1 string

(DEFUN |parseAndEvalStr| (|string|)
  (PROG (|$e| |$InteractiveMode|)
    (DECLARE (SPECIAL |$e| |$InteractiveMode|))
    (RETURN
     (PROGN
      (SETQ |$InteractiveMode| T)
      (SETQ |$e| |$InteractiveFrame|)
      (|parseAndEvalStr1| |string|)))))

; parseAndEvalStr1 string ==
;   string.0 = char '")" =>
;     doSystemCommand SUBSEQ(string, 1)
;   sform := ncParseFromString string
;   $QuietCommand : local := $QuietCommand_tmp
;   processInteractive(sform, NIL)

(DEFUN |parseAndEvalStr1| (|string|)
  (PROG (|$QuietCommand| |sform|)
    (DECLARE (SPECIAL |$QuietCommand|))
    (RETURN
     (COND
      ((EQUAL (ELT |string| 0) (|char| ")"))
       (|doSystemCommand| (SUBSEQ |string| 1)))
      ('T
       (PROGN
        (SETQ |sform| (|ncParseFromString| |string|))
        (SETQ |$QuietCommand| |$QuietCommand_tmp|)
        (|processInteractive| |sform| NIL)))))))

; protectedEVAL x ==
;   error := true
;   val := NIL
;   UNWIND_-PROTECT((val := EVAL x; error := NIL),
;                    error => (resetStackLimits(); sendHTErrorSignal()))
;   val

(DEFUN |protectedEVAL| (|x|)
  (PROG (|error| |val|)
    (RETURN
     (PROGN
      (SETQ |error| T)
      (SETQ |val| NIL)
      (UNWIND-PROTECT (PROGN (SETQ |val| (EVAL |x|)) (SETQ |error| NIL))
        (COND
         (|error|
          (IDENTITY (PROGN (|resetStackLimits|) (|sendHTErrorSignal|))))))
      |val|))))

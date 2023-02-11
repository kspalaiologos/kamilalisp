
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($ioHook, nil)

(DEFPARAMETER |$ioHook| NIL)

; DEFPARAMETER($erMsgToss, false)

(DEFPARAMETER |$erMsgToss| NIL)

; ioHook(x, :args) ==
;    if $ioHook then FUNCALL($ioHook, x, args)

(DEFUN |ioHook| (|x| &REST |args|)
  (PROG () (RETURN (COND (|$ioHook| (FUNCALL |$ioHook| |x| |args|))))))

; $ncmMacro :=            NIL

(EVAL-WHEN (EVAL LOAD) (SETQ |$ncmMacro| NIL))

; $ncmPhase :=      NIL

(EVAL-WHEN (EVAL LOAD) (SETQ |$ncmPhase| NIL))

; evalInlineCode() ==
;   args := getCLArgs()
;   while args repeat
;     arg := first args
;     args := rest args
;     if arg = '"-eval" and args then
;       CATCH('SPAD_READER, CATCH('top_level, parseAndEvalStr first(args)))
;       args := rest args

(DEFUN |evalInlineCode| ()
  (PROG (|arg| |args|)
    (RETURN
     (PROGN
      (SETQ |args| (|getCLArgs|))
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |args|) (RETURN NIL))
                ('T
                 (PROGN
                  (SETQ |arg| (CAR |args|))
                  (SETQ |args| (CDR |args|))
                  (COND
                   ((AND (EQUAL |arg| "-eval") |args|)
                    (CATCH 'SPAD_READER
                      (CATCH '|top_level| (|parseAndEvalStr| (CAR |args|))))
                    (SETQ |args| (CDR |args|))))))))))))))

; spad() ==
;   -- starts the interpreter, read in profiles, etc.
;   $PrintCompilerMessageIfTrue: local
;   setOutputAlgebra "%initialize%"
;   readSpadProfileIfThere()
;   evalInlineCode()
;   runspad()
;   'EndOfSpad

(DEFUN |spad| ()
  (PROG (|$PrintCompilerMessageIfTrue|)
    (DECLARE (SPECIAL |$PrintCompilerMessageIfTrue|))
    (RETURN
     (PROGN
      (SETQ |$PrintCompilerMessageIfTrue| NIL)
      (|setOutputAlgebra| '|%initialize%|)
      (|readSpadProfileIfThere|)
      (|evalInlineCode|)
      (|runspad|)
      '|EndOfSpad|))))

; runspad() ==
;   mode:='restart
;   while mode='restart repeat
;     resetStackLimits()
;     CATCH('coerceFailure,
;                   mode:=CATCH('top_level, ncTopLevel()))

(DEFUN |runspad| ()
  (PROG (|mode|)
    (RETURN
     (PROGN
      (SETQ |mode| '|restart|)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (EQ |mode| '|restart|)) (RETURN NIL))
                ('T
                 (PROGN
                  (|resetStackLimits|)
                  (CATCH '|coerceFailure|
                    (SETQ |mode| (CATCH '|top_level| (|ncTopLevel|))))))))))))))

; ncTopLevel() ==
; -- Top-level read-parse-eval-print loop for the interpreter.  Uses
; -- the Bill Burge's parser.
;   _*EOF_*: fluid := NIL
;   $InteractiveMode :fluid := true
;   $e:fluid := $InteractiveFrame
;   int_loop()

(DEFUN |ncTopLevel| ()
  (PROG (|$e| |$InteractiveMode| *EOF*)
    (DECLARE (SPECIAL |$e| |$InteractiveMode| *EOF*))
    (RETURN
     (PROGN
      (SETQ *EOF* NIL)
      (SETQ |$InteractiveMode| T)
      (SETQ |$e| |$InteractiveFrame|)
      (|int_loop|)))))

; printFirstPrompt?() ==
;     $interpreterFrameName ~= "initial" or not($SpadServer)

(DEFUN |printFirstPrompt?| ()
  (PROG ()
    (RETURN
     (OR (NOT (EQ |$interpreterFrameName| '|initial|)) (NULL |$SpadServer|)))))

; int_loop () ==
;     mode := "restart"
;     while mode = "restart" repeat
;       resetStackLimits()
;       mode := CATCH("top_level",
;                     SpadInterpretStream(1, [], true))

(DEFUN |int_loop| ()
  (PROG (|mode|)
    (RETURN
     (PROGN
      (SETQ |mode| '|restart|)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (EQ |mode| '|restart|)) (RETURN NIL))
                ('T
                 (PROGN
                  (|resetStackLimits|)
                  (SETQ |mode|
                          (CATCH '|top_level|
                            (|SpadInterpretStream| 1 NIL T)))))))))))))

; SpadInterpretStream(step_num, source, interactive?) ==
;     pile?                    := not interactive?
;
;     $newcompErrorCount: local := 0 -- SMW Feb 2/90.
;                                    -- Used in highComplete, ncHardError etc.
;
;     $inclAssertions: local := ["AIX", "CommonLisp"] -- Jan 28/90
;
;
;     $lastPos               : local := $nopos   ------------>!!!
;     $erMsgToss             : local := false --------------->!!!
;     $ncMsgList             : local := nil
;
;     interactive? =>
;         if printFirstPrompt?() then
;             princPrompt()
;         intloopReadConsole([], step_num)
;         []
;     intloopInclude (source,0)
;     []

(DEFUN |SpadInterpretStream| (|step_num| |source| |interactive?|)
  (PROG (|$ncMsgList| |$erMsgToss| |$lastPos| |$inclAssertions|
         |$newcompErrorCount| |pile?|)
    (DECLARE
     (SPECIAL |$ncMsgList| |$erMsgToss| |$lastPos| |$inclAssertions|
      |$newcompErrorCount|))
    (RETURN
     (PROGN
      (SETQ |pile?| (NULL |interactive?|))
      (SETQ |$newcompErrorCount| 0)
      (SETQ |$inclAssertions| (LIST 'AIX '|CommonLisp|))
      (SETQ |$lastPos| |$nopos|)
      (SETQ |$erMsgToss| NIL)
      (SETQ |$ncMsgList| NIL)
      (COND
       (|interactive?|
        (PROGN
         (COND ((|printFirstPrompt?|) (|princPrompt|)))
         (|intloopReadConsole| NIL |step_num|)
         NIL))
       ('T (PROGN (|intloopInclude| |source| 0) NIL)))))))

; ncINTERPFILE(file, echo) ==
;   $EchoLines : local := echo
;   $ReadingFile : local := true
;   SpadInterpretStream(1, file, false)

(DEFUN |ncINTERPFILE| (|file| |echo|)
  (PROG (|$ReadingFile| |$EchoLines|)
    (DECLARE (SPECIAL |$ReadingFile| |$EchoLines|))
    (RETURN
     (PROGN
      (SETQ |$EchoLines| |echo|)
      (SETQ |$ReadingFile| T)
      (|SpadInterpretStream| 1 |file| NIL)))))

; setCurrentLine s ==
;   v := $currentLine
;   $currentLine :=
;      NULL(v) => s
;      u :=
;         STRINGP(s) => [s]
;         s
;      STRINGP(v) => [v, :u]
;      RPLACD(LASTNODE(v), u)
;      v

(DEFUN |setCurrentLine| (|s|)
  (PROG (|v| |u|)
    (RETURN
     (PROGN
      (SETQ |v| |$currentLine|)
      (SETQ |$currentLine|
              (COND ((NULL |v|) |s|)
                    (#1='T
                     (PROGN
                      (SETQ |u| (COND ((STRINGP |s|) (LIST |s|)) (#1# |s|)))
                      (COND ((STRINGP |v|) (CONS |v| |u|))
                            (#1#
                             (PROGN (RPLACD (LASTNODE |v|) |u|) |v|)))))))))))

; intloopReadConsole(b, n)==
;     repeat
;         ioHook("startReadLine")
;         a := serverReadLine(_*STANDARD_-INPUT_*)
;         ioHook("endOfReadLine")
;         not STRINGP a => leaveScratchpad()
;         b = [] and #a=0 =>
;              princPrompt()
;         $DALYMODE and intloopPrefix?('"(",a) =>
;             intnplisp(a)
;             princPrompt()
;         pfx := stripSpaces intloopPrefix?('")fi",a)
;         pfx and ((pfx = '")fi") or (pfx = '")fin")) => return []
;         b = [] and (d := intloopPrefix?('")", a)) =>
;              setCurrentLine d
;              n := ncloopCommand(d, n)
;              princPrompt()
;         b := CONS(a, b)
;         ncloopEscaped a => "iterate"
;         n := intloopProcessStrings(nreverse b, n)
;         princPrompt()
;         b := []

(DEFUN |intloopReadConsole| (|b| |n|)
  (PROG (|a| |pfx| |d|)
    (RETURN
     ((LAMBDA ()
        (LOOP
         (COND (NIL (RETURN NIL))
               (#1='T
                (PROGN
                 (|ioHook| '|startReadLine|)
                 (SETQ |a| (|serverReadLine| *STANDARD-INPUT*))
                 (|ioHook| '|endOfReadLine|)
                 (COND ((NULL (STRINGP |a|)) (|leaveScratchpad|))
                       ((AND (NULL |b|) (EQL (LENGTH |a|) 0)) (|princPrompt|))
                       ((AND $DALYMODE (|intloopPrefix?| "(" |a|))
                        (PROGN (|intnplisp| |a|) (|princPrompt|)))
                       (#1#
                        (PROGN
                         (SETQ |pfx|
                                 (|stripSpaces| (|intloopPrefix?| ")fi" |a|)))
                         (COND
                          ((AND |pfx|
                                (OR (EQUAL |pfx| ")fi") (EQUAL |pfx| ")fin")))
                           (RETURN NIL))
                          ((AND (NULL |b|)
                                (SETQ |d| (|intloopPrefix?| ")" |a|)))
                           (PROGN
                            (|setCurrentLine| |d|)
                            (SETQ |n| (|ncloopCommand| |d| |n|))
                            (|princPrompt|)))
                          (#1#
                           (PROGN
                            (SETQ |b| (CONS |a| |b|))
                            (COND ((|ncloopEscaped| |a|) '|iterate|)
                                  (#1#
                                   (PROGN
                                    (SETQ |n|
                                            (|intloopProcessStrings|
                                             (NREVERSE |b|) |n|))
                                    (|princPrompt|)
                                    (SETQ |b| NIL)))))))))))))))))))

; intloopPrefix?(prefix,whole) ==
;      #prefix > #whole => false
;      good := true
;      leading := true
;      spaces := 0
;      i := 0
;      len := #prefix
;      wlen := #whole
;      for j in 0.. while (good and i < len and j < wlen) repeat
;        good := (prefix.i = whole.j) or (leading and (whole.j = char " "))
;        if prefix.i = whole.j then i := i+1
;        if (whole.j = char " ") and leading then
;          spaces := spaces + 1
;        else leading := false
;      spaces = wlen => nil
;      if good then SUBSTRING(whole,spaces,nil) else good

(DEFUN |intloopPrefix?| (|prefix| |whole|)
  (PROG (|good| |leading| |spaces| |i| |len| |wlen|)
    (RETURN
     (COND ((< (LENGTH |whole|) (LENGTH |prefix|)) NIL)
           (#1='T
            (PROGN
             (SETQ |good| T)
             (SETQ |leading| T)
             (SETQ |spaces| 0)
             (SETQ |i| 0)
             (SETQ |len| (LENGTH |prefix|))
             (SETQ |wlen| (LENGTH |whole|))
             ((LAMBDA (|j|)
                (LOOP
                 (COND
                  ((NOT (AND |good| (< |i| |len|) (< |j| |wlen|)))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |good|
                            (OR (EQUAL (ELT |prefix| |i|) (ELT |whole| |j|))
                                (AND |leading|
                                     (EQUAL (ELT |whole| |j|) (|char| '| |)))))
                    (COND
                     ((EQUAL (ELT |prefix| |i|) (ELT |whole| |j|))
                      (SETQ |i| (+ |i| 1))))
                    (COND
                     ((AND (EQUAL (ELT |whole| |j|) (|char| '| |)) |leading|)
                      (SETQ |spaces| (+ |spaces| 1)))
                     (#1# (SETQ |leading| NIL))))))
                 (SETQ |j| (+ |j| 1))))
              0)
             (COND ((EQUAL |spaces| |wlen|) NIL)
                   (#1#
                    (COND (|good| (SUBSTRING |whole| |spaces| NIL))
                          (#1# |good|))))))))))

; intloopProcess(n,interactive,s)==
;      StreamNull s => n
;      [lines, ptree] := first s
;      pfAbSynOp?(ptree,"command")=>
;             if interactive then setCurrentLine tokPart ptree
;             InterpExecuteSpadSystemCommand(tokPart ptree)
;             intloopProcess(n, interactive, rest s)
;      intloopProcess(intloopSpadProcess(n, lines, ptree, interactive),
;                  interactive, rest s)

(DEFUN |intloopProcess| (|n| |interactive| |s|)
  (PROG (|LETTMP#1| |lines| |ptree|)
    (RETURN
     (COND ((|StreamNull| |s|) |n|)
           (#1='T
            (PROGN
             (SETQ |LETTMP#1| (CAR |s|))
             (SETQ |lines| (CAR |LETTMP#1|))
             (SETQ |ptree| (CADR |LETTMP#1|))
             (COND
              ((|pfAbSynOp?| |ptree| '|command|)
               (PROGN
                (COND (|interactive| (|setCurrentLine| (|tokPart| |ptree|))))
                (|InterpExecuteSpadSystemCommand| (|tokPart| |ptree|))
                (|intloopProcess| |n| |interactive| (CDR |s|))))
              (#1#
               (|intloopProcess|
                (|intloopSpadProcess| |n| |lines| |ptree| |interactive|)
                |interactive| (CDR |s|))))))))))

; intloopEchoParse s==
;          [dq, stream] := first s
;          [lines, restl] := ncloopDQlines(dq, $lines)
;          setCurrentLine(mkLineList(lines))
;          if $EchoLines then ncloopPrintLines lines
;          $lines := restl
;          cons([[lines, npParse dqToList dq]], rest s)

(DEFUN |intloopEchoParse| (|s|)
  (PROG (|LETTMP#1| |dq| |stream| |lines| |restl|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (CAR |s|))
      (SETQ |dq| (CAR |LETTMP#1|))
      (SETQ |stream| (CADR |LETTMP#1|))
      (SETQ |LETTMP#1| (|ncloopDQlines| |dq| |$lines|))
      (SETQ |lines| (CAR |LETTMP#1|))
      (SETQ |restl| (CADR |LETTMP#1|))
      (|setCurrentLine| (|mkLineList| |lines|))
      (COND (|$EchoLines| (|ncloopPrintLines| |lines|)))
      (SETQ |$lines| |restl|)
      (CONS (LIST (LIST |lines| (|npParse| (|dqToList| |dq|)))) (CDR |s|))))))

; intloopInclude0(st, name, n) ==
;     $lines:local:=incStream(st,name)
;     intloopProcess(n,false,
;       next(function intloopEchoParse,
;         next(function insertpile,
;           next(function lineoftoks,$lines))))

(DEFUN |intloopInclude0| (|st| |name| |n|)
  (PROG (|$lines|)
    (DECLARE (SPECIAL |$lines|))
    (RETURN
     (PROGN
      (SETQ |$lines| (|incStream| |st| |name|))
      (|intloopProcess| |n| NIL
       (|next| #'|intloopEchoParse|
        (|next| #'|insertpile| (|next| #'|lineoftoks| |$lines|))))))))

; intloopInclude(name, n) ==
;     handle_input_file(name, function intloopInclude0, [name, n])
;       or error('"File not found")

(DEFUN |intloopInclude| (|name| |n|)
  (PROG ()
    (RETURN
     (OR (|handle_input_file| |name| #'|intloopInclude0| (LIST |name| |n|))
         (|error| "File not found")))))

; fakepile(s) ==
;     if npNull s then [false, 0, [], s]
;     else
;         [h, t] := [car s, cdr s]
;         ss := cdr(h)
;         ress := car h
;         while not npNull t repeat
;             h := car (car t)
;             t := cdr t
;             ress := dqAppend(ress, h)
;         cons([[ress, :ss]], t)

(DEFUN |fakepile| (|s|)
  (PROG (|LETTMP#1| |h| |t| |ss| |ress|)
    (RETURN
     (COND ((|npNull| |s|) (LIST NIL 0 NIL |s|))
           (#1='T (SETQ |LETTMP#1| (LIST (CAR |s|) (CDR |s|)))
            (SETQ |h| (CAR |LETTMP#1|)) (SETQ |t| (CADR |LETTMP#1|))
            (SETQ |ss| (CDR |h|)) (SETQ |ress| (CAR |h|))
            ((LAMBDA ()
               (LOOP
                (COND ((|npNull| |t|) (RETURN NIL))
                      (#1#
                       (PROGN
                        (SETQ |h| (CAR (CAR |t|)))
                        (SETQ |t| (CDR |t|))
                        (SETQ |ress| (|dqAppend| |ress| |h|))))))))
            (CONS (LIST (CONS |ress| |ss|)) |t|))))))

; intloopProcessStrings(s, n) ==
;      setCurrentLine s
;      intloopProcess(n, true,
;          next(function ncloopParse,
;              next(function fakepile,
;                  next(function lineoftoks, incStrings s))))

(DEFUN |intloopProcessStrings| (|s| |n|)
  (PROG ()
    (RETURN
     (PROGN
      (|setCurrentLine| |s|)
      (|intloopProcess| |n| T
       (|next| #'|ncloopParse|
        (|next| #'|fakepile| (|next| #'|lineoftoks| (|incStrings| |s|)))))))))

; $pfMacros := []

(EVAL-WHEN (EVAL LOAD) (SETQ |$pfMacros| NIL))

; clearMacroTable() ==
;    SETF($pfMacros, nil)

(DEFUN |clearMacroTable| () (PROG () (RETURN (SETF |$pfMacros| NIL))))

; getParserMacros() == $pfMacros

(DEFUN |getParserMacros| () (PROG () (RETURN |$pfMacros|)))

; displayParserMacro m ==
;    m := ASSQ(m, $pfMacros)
;    NULL m => nil
;    pfPrintSrcLines(CADDR(m))

(DEFUN |displayParserMacro| (|m|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |m| (ASSQ |m| |$pfMacros|))
      (COND ((NULL |m|) NIL) ('T (|pfPrintSrcLines| (CADDR |m|))))))))

; intSetNeedToSignalSessionManager() ==
;     $NeedToSignalSessionManager := true

(DEFUN |intSetNeedToSignalSessionManager| ()
  (PROG () (RETURN (SETQ |$NeedToSignalSessionManager| T))))

; intloopSpadProcess(stepNo,lines,ptree,interactive?)==
;     $stepNo:local := stepNo
;     $currentCarrier := cc := ['carrier]
;     ncPutQ(cc, 'stepNumber, stepNo)
;     ncPutQ(cc, 'messages, $ncMsgList)
;     ncPutQ(cc, 'lines, lines)
;     $ncMsgList := nil
;     result := CATCH("SpadCompileItem",
;      CATCH("coerceFailure", CATCH("SPAD_READER",
;        interp(cc, ptree, interactive?)))) where
;
;         interp(cc, ptree, interactive?) ==
;             ncConversationPhase(function phParse,            [cc, ptree])
;             ncConversationPhase(function phMacro,            [cc])
;             ncConversationPhase(function phIntReportMsgs,[cc, interactive?])
;             ncConversationPhase(function phInterpret,        [cc])
;
;             #ncEltQ(cc, 'messages) ~= 0 => ncError()
;
;     intSetNeedToSignalSessionManager()
;     $prevCarrier := $currentCarrier
;     result = 'ncEnd     => stepNo
;     result = 'ncError   => stepNo
;     result = 'ncEndItem => stepNo
;     stepNo+1

(DEFUN |intloopSpadProcess| (|stepNo| |lines| |ptree| |interactive?|)
  (PROG (|$stepNo| |result| |cc|)
    (DECLARE (SPECIAL |$stepNo|))
    (RETURN
     (PROGN
      (SETQ |$stepNo| |stepNo|)
      (SETQ |$currentCarrier| (SETQ |cc| (LIST '|carrier|)))
      (|ncPutQ| |cc| '|stepNumber| |stepNo|)
      (|ncPutQ| |cc| '|messages| |$ncMsgList|)
      (|ncPutQ| |cc| '|lines| |lines|)
      (SETQ |$ncMsgList| NIL)
      (SETQ |result|
              (CATCH '|SpadCompileItem|
                (CATCH '|coerceFailure|
                  (CATCH 'SPAD_READER
                    (|intloopSpadProcess,interp| |cc| |ptree|
                     |interactive?|)))))
      (|intSetNeedToSignalSessionManager|)
      (SETQ |$prevCarrier| |$currentCarrier|)
      (COND ((EQ |result| '|ncEnd|) |stepNo|)
            ((EQ |result| '|ncError|) |stepNo|)
            ((EQ |result| '|ncEndItem|) |stepNo|) ('T (+ |stepNo| 1)))))))
(DEFUN |intloopSpadProcess,interp| (|cc| |ptree| |interactive?|)
  (PROG ()
    (RETURN
     (PROGN
      (|ncConversationPhase| #'|phParse| (LIST |cc| |ptree|))
      (|ncConversationPhase| #'|phMacro| (LIST |cc|))
      (|ncConversationPhase| #'|phIntReportMsgs| (LIST |cc| |interactive?|))
      (|ncConversationPhase| #'|phInterpret| (LIST |cc|))
      (COND
       ((NOT (EQL (LENGTH (|ncEltQ| |cc| '|messages|)) 0)) (|ncError|)))))))

; phInterpret carrier ==
;   ptree := ncEltQ(carrier, 'ptree)
;   val := intInterpretPform(ptree)
;   ncPutQ(carrier, 'value, val)

(DEFUN |phInterpret| (|carrier|)
  (PROG (|ptree| |val|)
    (RETURN
     (PROGN
      (SETQ |ptree| (|ncEltQ| |carrier| '|ptree|))
      (SETQ |val| (|intInterpretPform| |ptree|))
      (|ncPutQ| |carrier| '|value| |val|)))))

; intInterpretPform pf ==
;     sform := pf2Sex(pf)
;     $QuietCommand : local := $QuietCommand_tmp
;     processInteractive(sform, pf)

(DEFUN |intInterpretPform| (|pf|)
  (PROG (|$QuietCommand| |sform|)
    (DECLARE (SPECIAL |$QuietCommand|))
    (RETURN
     (PROGN
      (SETQ |sform| (|pf2Sex| |pf|))
      (SETQ |$QuietCommand| |$QuietCommand_tmp|)
      (|processInteractive| |sform| |pf|)))))

; phIntReportMsgs(carrier, interactive?) ==
;     $erMsgToss => 'OK
;     lines := ncEltQ(carrier, 'lines)
;     msgs  := ncEltQ(carrier, 'messages)
;     nerr  := #msgs
;     ncPutQ(carrier, 'ok?, nerr = 0)
;     nerr = 0 => 'OK
;     processMsgList(msgs, lines)
;     intSayKeyedMsg ('S2CTP010,[nerr])
;     'OK

(DEFUN |phIntReportMsgs| (|carrier| |interactive?|)
  (PROG (|lines| |msgs| |nerr|)
    (RETURN
     (COND (|$erMsgToss| 'OK)
           (#1='T
            (PROGN
             (SETQ |lines| (|ncEltQ| |carrier| '|lines|))
             (SETQ |msgs| (|ncEltQ| |carrier| '|messages|))
             (SETQ |nerr| (LENGTH |msgs|))
             (|ncPutQ| |carrier| '|ok?| (EQL |nerr| 0))
             (COND ((EQL |nerr| 0) 'OK)
                   (#1#
                    (PROGN
                     (|processMsgList| |msgs| |lines|)
                     (|intSayKeyedMsg| 'S2CTP010 (LIST |nerr|))
                     'OK)))))))))

; intSayKeyedMsg(key, args) ==
;   sayKeyedMsg(key, args)

(DEFUN |intSayKeyedMsg| (|key| |args|)
  (PROG () (RETURN (|sayKeyedMsg| |key| |args|))))

; mkLineList lines ==
;   l := [rest line for line in lines | nonBlank rest line]
;   #l = 1 => first l
;   l

(DEFUN |mkLineList| (|lines|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l|
              ((LAMBDA (|bfVar#2| |bfVar#1| |line|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#1|)
                        (PROGN (SETQ |line| (CAR |bfVar#1|)) NIL))
                    (RETURN (NREVERSE |bfVar#2|)))
                   (#1='T
                    (AND (|nonBlank| (CDR |line|))
                         (SETQ |bfVar#2| (CONS (CDR |line|) |bfVar#2|)))))
                  (SETQ |bfVar#1| (CDR |bfVar#1|))))
               NIL |lines| NIL))
      (COND ((EQL (LENGTH |l|) 1) (CAR |l|)) (#1# |l|))))))

; nonBlank str ==
;   value := false
;   for i in 0..MAXINDEX str repeat
;     str.i ~= char " " =>
;       value := true
;       return value
;   value

(DEFUN |nonBlank| (|str|)
  (PROG (|value|)
    (RETURN
     (PROGN
      (SETQ |value| NIL)
      ((LAMBDA (|bfVar#3| |i|)
         (LOOP
          (COND ((> |i| |bfVar#3|) (RETURN NIL))
                ('T
                 (COND
                  ((NOT (EQUAL (ELT |str| |i|) (|char| '| |)))
                   (IDENTITY (PROGN (SETQ |value| T) (RETURN |value|)))))))
          (SETQ |i| (+ |i| 1))))
       (MAXINDEX |str|) 0)
      |value|))))

; ncloopCommand (line,n) ==
;     InterpExecuteSpadSystemCommand(line)
;     n

(DEFUN |ncloopCommand| (|line| |n|)
  (PROG () (RETURN (PROGN (|InterpExecuteSpadSystemCommand| |line|) |n|))))

; ncloopEscaped x == #x > 0 and x.(#x - 1) = '"__".0

(DEFUN |ncloopEscaped| (|x|)
  (PROG ()
    (RETURN
     (AND (< 0 (LENGTH |x|))
          (EQUAL (ELT |x| (- (LENGTH |x|) 1)) (ELT "_" 0))))))

; ncloopDQlines (dq,stream)==
;         StreamNull stream
;         a:= poGlobalLinePosn tokPosn CADR dq
;         b:= poGlobalLinePosn CAAR stream
;         streamChop (a-b+1,stream)

(DEFUN |ncloopDQlines| (|dq| |stream|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (|StreamNull| |stream|)
      (SETQ |a| (|poGlobalLinePosn| (|tokPosn| (CADR |dq|))))
      (SETQ |b| (|poGlobalLinePosn| (CAAR |stream|)))
      (|streamChop| (+ (- |a| |b|) 1) |stream|)))))

; streamChop(n,s)==
;     if StreamNull s
;     then [nil,nil]
;     else if EQL(n,0)
;          then [nil,s]
;          else
;             [a,b]:= streamChop(n-1,cdr s)
;             line:=car s
;             c := ncloopPrefix?('")command", rest line)
;             d:= cons(car line,if c then c else cdr line)
;             [cons(d,a),b]

(DEFUN |streamChop| (|n| |s|)
  (PROG (|LETTMP#1| |a| |b| |line| |c| |d|)
    (RETURN
     (COND ((|StreamNull| |s|) (LIST NIL NIL)) ((EQL |n| 0) (LIST NIL |s|))
           (#1='T (SETQ |LETTMP#1| (|streamChop| (- |n| 1) (CDR |s|)))
            (SETQ |a| (CAR |LETTMP#1|)) (SETQ |b| (CADR |LETTMP#1|))
            (SETQ |line| (CAR |s|))
            (SETQ |c| (|ncloopPrefix?| ")command" (CDR |line|)))
            (SETQ |d| (CONS (CAR |line|) (COND (|c| |c|) (#1# (CDR |line|)))))
            (LIST (CONS |d| |a|) |b|))))))

; ncloopPrintLines lines ==
;         for line in lines repeat WRITE_-LINE rest line
;         WRITE_-LINE '" "

(DEFUN |ncloopPrintLines| (|lines|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#4| |line|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#4|) (PROGN (SETQ |line| (CAR |bfVar#4|)) NIL))
            (RETURN NIL))
           ('T (WRITE-LINE (CDR |line|))))
          (SETQ |bfVar#4| (CDR |bfVar#4|))))
       |lines| NIL)
      (WRITE-LINE " ")))))

; ncloopIncFileName string==
;                 fn := incFileName string
;                 not fn =>
;                     WRITE_-LINE (CONCAT(string, '" not found"))
;                     []
;                 fn

(DEFUN |ncloopIncFileName| (|string|)
  (PROG (|fn|)
    (RETURN
     (PROGN
      (SETQ |fn| (|incFileName| |string|))
      (COND
       ((NULL |fn|) (PROGN (WRITE-LINE (CONCAT |string| " not found")) NIL))
       ('T |fn|))))))

; ncloopParse s==
;          [dq, stream] := first s
;          [lines, .] := ncloopDQlines(dq, stream)
;          cons([[lines, npParse dqToList dq]], rest s)

(DEFUN |ncloopParse| (|s|)
  (PROG (|LETTMP#1| |dq| |stream| |lines|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (CAR |s|))
      (SETQ |dq| (CAR |LETTMP#1|))
      (SETQ |stream| (CADR |LETTMP#1|))
      (SETQ |LETTMP#1| (|ncloopDQlines| |dq| |stream|))
      (SETQ |lines| (CAR |LETTMP#1|))
      (CONS (LIST (LIST |lines| (|npParse| (|dqToList| |dq|)))) (CDR |s|))))))

; incString s== incRenumber incLude(0,[s],0,['"strings"] ,[Top])

(DEFUN |incString| (|s|)
  (PROG ()
    (RETURN
     (|incRenumber| (|incLude| 0 (LIST |s|) 0 (LIST "strings") (LIST |Top|))))))

; incStrings(s) == incRenumber incLude(0, s, 0, ['"strings"], [Top])

(DEFUN |incStrings| (|s|)
  (PROG ()
    (RETURN (|incRenumber| (|incLude| 0 |s| 0 (LIST "strings") (LIST |Top|))))))

; ncError() ==
;     THROW("SpadCompileItem",'ncError)

(DEFUN |ncError| () (PROG () (RETURN (THROW '|SpadCompileItem| '|ncError|))))

; phParse(carrier,ptree) ==
;     phBegin 'Parsing
;     ncPutQ(carrier, 'ptree, ptree)
;     'OK

(DEFUN |phParse| (|carrier| |ptree|)
  (PROG ()
    (RETURN
     (PROGN (|phBegin| '|Parsing|) (|ncPutQ| |carrier| '|ptree| |ptree|) 'OK))))

; phMacro carrier ==
;     phBegin 'Macroing
;     ptree  := ncEltQ(carrier, 'ptree)
;     ncPutQ(carrier, 'ptreePremacro, ptree)
;
;     ptree  := macroExpanded ptree
;     if $ncmMacro then
;         intSayKeyedMsg ('S2CTP007,[%pform ptree] )
;
;     ncPutQ(carrier, 'ptree, ptree)
;     'OK

(DEFUN |phMacro| (|carrier|)
  (PROG (|ptree|)
    (RETURN
     (PROGN
      (|phBegin| '|Macroing|)
      (SETQ |ptree| (|ncEltQ| |carrier| '|ptree|))
      (|ncPutQ| |carrier| '|ptreePremacro| |ptree|)
      (SETQ |ptree| (|macroExpanded| |ptree|))
      (COND
       (|$ncmMacro| (|intSayKeyedMsg| 'S2CTP007 (LIST (|%pform| |ptree|)))))
      (|ncPutQ| |carrier| '|ptree| |ptree|)
      'OK))))

; ncConversationPhase(fn, args) ==
;     carrier := first args
;
;     $ncMsgList: local := []
;     $convPhase: local := 'NoPhase
;
;     UNWIND_-PROTECT( APPLY(fn, args), wrapup(carrier) ) where
;         wrapup(carrier) ==
;             for m in $ncMsgList repeat
;                 ncPutQ(carrier, 'messages, [m, :ncEltQ(carrier, 'messages)])

(DEFUN |ncConversationPhase| (|fn| |args|)
  (PROG (|$convPhase| |$ncMsgList| |carrier|)
    (DECLARE (SPECIAL |$convPhase| |$ncMsgList|))
    (RETURN
     (PROGN
      (SETQ |carrier| (CAR |args|))
      (SETQ |$ncMsgList| NIL)
      (SETQ |$convPhase| '|NoPhase|)
      (UNWIND-PROTECT (APPLY |fn| |args|)
        (|ncConversationPhase,wrapup| |carrier|))))))
(DEFUN |ncConversationPhase,wrapup| (|carrier|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#5| |m|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#5|) (PROGN (SETQ |m| (CAR |bfVar#5|)) NIL))
           (RETURN NIL))
          ('T
           (|ncPutQ| |carrier| '|messages|
            (CONS |m| (|ncEltQ| |carrier| '|messages|)))))
         (SETQ |bfVar#5| (CDR |bfVar#5|))))
      |$ncMsgList| NIL))))

; ncloopPrefix?(prefix,whole) ==
;      #prefix > #whole => false
;      good:=true
;      for i in 0..#prefix-1 for j in 0.. while good repeat
;                 good:= prefix.i = whole.j
;      if good then SUBSTRING(whole,#prefix,nil) else good

(DEFUN |ncloopPrefix?| (|prefix| |whole|)
  (PROG (|good|)
    (RETURN
     (COND ((< (LENGTH |whole|) (LENGTH |prefix|)) NIL)
           (#1='T
            (PROGN
             (SETQ |good| T)
             ((LAMBDA (|bfVar#6| |i| |j|)
                (LOOP
                 (COND ((OR (> |i| |bfVar#6|) (NOT |good|)) (RETURN NIL))
                       (#1#
                        (SETQ |good|
                                (EQUAL (ELT |prefix| |i|) (ELT |whole| |j|)))))
                 (SETQ |i| (+ |i| 1))
                 (SETQ |j| (+ |j| 1))))
              (- (LENGTH |prefix|) 1) 0 0)
             (COND (|good| (SUBSTRING |whole| (LENGTH |prefix|) NIL))
                   (#1# |good|))))))))

; phBegin id ==
;     $convPhase := id
;     if $ncmPhase then intSayKeyedMsg('S2CTP021,[id])

(DEFUN |phBegin| (|id|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$convPhase| |id|)
      (COND (|$ncmPhase| (|intSayKeyedMsg| 'S2CTP021 (LIST |id|))))))))

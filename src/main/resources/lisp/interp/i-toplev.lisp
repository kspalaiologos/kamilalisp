
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($QuietCommand, NIL)

(DEFPARAMETER |$QuietCommand| NIL)

; DEFPARAMETER($ProcessInteractiveValue, NIL)

(DEFPARAMETER |$ProcessInteractiveValue| NIL)

; DEFPARAMETER($QuietCommand_tmp, nil)

(DEFPARAMETER |$QuietCommand_tmp| NIL)

; intSetQuiet() ==
;   $QuietCommand_tmp := true

(DEFUN |intSetQuiet| () (PROG () (RETURN (SETQ |$QuietCommand_tmp| T))))

; intUnsetQuiet() ==
;   $QuietCommand_tmp := nil

(DEFUN |intUnsetQuiet| () (PROG () (RETURN (SETQ |$QuietCommand_tmp| NIL))))

; interpsysInitialization() ==
;   -- The function  start  begins the interpreter process, reading in
;   -- the profile and printing start-up messages.
;   $PrintCompilerMessageIfTrue: local := nil
;   resetWorkspaceVariables()
;   initHist()
;   initNewWorld()
;   compressOpen()
;   interpOpen()
;   createInitializers()
;   if $displayStartMsgs then sayKeyedMsg("S2IZ0053",['"interpreter"])
;   initializeTimedNames($interpreterTimedNames,$interpreterTimedClasses)
;   statisticsInitialization()
;   $InteractiveFrame := makeInitialModemapFrame()
;   initializeSystemCommands()
;   initializeInterpreterFrameRing()
;   setOutputAlgebra "%initialize%"
;   loadExposureGroupData()
;   if $displayStartMsgs then sayKeyedMsg("S2IZ0053",['"database"])
;   mkLowerCaseConTable()
;   if not $ruleSetsInitialized then initializeRuleSets()
;   if $displayStartMsgs then sayKeyedMsg("S2IZ0053",['"constructors"])
;   makeConstructorsAutoLoad()
;   GCMSG(NIL)
;   SETQ($IOindex,1)
;   if $displayStartMsgs then sayKeyedMsg("S2IZ0053",['"history"])
;   initHist()
;   if $displayStartMsgs then spadStartUpMsgs()
;   $superHash := MAKE_HASHTABLE('UEQUAL)

(DEFUN |interpsysInitialization| ()
  (PROG (|$PrintCompilerMessageIfTrue|)
    (DECLARE (SPECIAL |$PrintCompilerMessageIfTrue|))
    (RETURN
     (PROGN
      (SETQ |$PrintCompilerMessageIfTrue| NIL)
      (|resetWorkspaceVariables|)
      (|initHist|)
      (|initNewWorld|)
      (|compressOpen|)
      (|interpOpen|)
      (|createInitializers|)
      (COND
       (|$displayStartMsgs| (|sayKeyedMsg| 'S2IZ0053 (LIST "interpreter"))))
      (|initializeTimedNames| |$interpreterTimedNames|
       |$interpreterTimedClasses|)
      (|statisticsInitialization|)
      (SETQ |$InteractiveFrame| (|makeInitialModemapFrame|))
      (|initializeSystemCommands|)
      (|initializeInterpreterFrameRing|)
      (|setOutputAlgebra| '|%initialize%|)
      (|loadExposureGroupData|)
      (COND (|$displayStartMsgs| (|sayKeyedMsg| 'S2IZ0053 (LIST "database"))))
      (|mkLowerCaseConTable|)
      (COND ((NULL |$ruleSetsInitialized|) (|initializeRuleSets|)))
      (COND
       (|$displayStartMsgs| (|sayKeyedMsg| 'S2IZ0053 (LIST "constructors"))))
      (|makeConstructorsAutoLoad|)
      (GCMSG NIL)
      (SETQ |$IOindex| 1)
      (COND (|$displayStartMsgs| (|sayKeyedMsg| 'S2IZ0053 (LIST "history"))))
      (|initHist|)
      (COND (|$displayStartMsgs| (|spadStartUpMsgs|)))
      (SETQ |$superHash| (MAKE_HASHTABLE 'UEQUAL))))))

; interpsys_restart() ==
;   $IOindex := 1
;   $InteractiveFrame := makeInitialModemapFrame()
;   loadExposureGroupData()
;   statisticsInitialization()
;   initHist()
;   initializeInterpreterFrameRing()
;
;   if $displayStartMsgs then spadStartUpMsgs()
;   $currentLine := nil
;   compressOpen() -- set up the compression tables
;   interpOpen() -- open up the interpreter database
;   operationOpen() -- all of the operations known to the system
;   categoryOpen() -- answer hasCategory question
;   browseOpen()
;   makeConstructorsAutoLoad()
;   createInitializers2()

(DEFUN |interpsys_restart| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$IOindex| 1)
      (SETQ |$InteractiveFrame| (|makeInitialModemapFrame|))
      (|loadExposureGroupData|)
      (|statisticsInitialization|)
      (|initHist|)
      (|initializeInterpreterFrameRing|)
      (COND (|$displayStartMsgs| (|spadStartUpMsgs|)))
      (SETQ |$currentLine| NIL)
      (|compressOpen|)
      (|interpOpen|)
      (|operationOpen|)
      (|categoryOpen|)
      (|browseOpen|)
      (|makeConstructorsAutoLoad|)
      (|createInitializers2|)))))

; readSpadProfileIfThere() ==
;   -- reads SPADPROF INPUT if it exists
;   file := getEnv('"FRICAS_INITFILE")
;   file = '"" => nil
;   efile :=
;     make_input_filename(file) => file
;     file := ['_.fricas, 'input]
;     make_input_filename(file) => file
;     file := ['_.axiom, 'input]
;     make_input_filename(file) => file
;     NIL
;   efile =>
;     $edit_file := efile
;     read_or_compile(true, false)
;   NIL

(DEFUN |readSpadProfileIfThere| ()
  (PROG (|efile| |file|)
    (RETURN
     (PROGN
      (SETQ |file| (|getEnv| "FRICAS_INITFILE"))
      (COND ((EQUAL |file| "") NIL)
            (#1='T
             (PROGN
              (SETQ |efile|
                      (COND ((|make_input_filename| |file|) |file|)
                            (#1#
                             (PROGN
                              (SETQ |file| (LIST '|.fricas| '|input|))
                              (COND ((|make_input_filename| |file|) |file|)
                                    (#1#
                                     (PROGN
                                      (SETQ |file| (LIST '|.axiom| '|input|))
                                      (COND
                                       ((|make_input_filename| |file|) |file|)
                                       (#1# NIL)))))))))
              (COND
               (|efile|
                (PROGN (SETQ |$edit_file| |efile|) (|read_or_compile| T NIL)))
               (#1# NIL)))))))))

; DEFPARAMETER($inRetract, nil)

(DEFPARAMETER |$inRetract| NIL)

; processInteractive(form, posnForm) ==
;   --  Top-level dispatcher for the interpreter.  It sets local variables
;   --  and then calls processInteractive1 to do most of the work.
;   --  This function receives the output from the parser.
;
;   initializeTimedNames($interpreterTimedNames,$interpreterTimedClasses)
;
;   $op: local:= (form is [op,:.] => op; form) --name of operator
;   $Coerce: local := NIL
;   $compErrorMessageStack:local := nil
;   $freeVars : local := NIL
;   $mapList:local := NIL            --list of maps being type analyzed
;   $compilingMap:local:= NIL        --true when compiling a map
;   $compilingLoop:local:= NIL       --true when compiling a loop body
;   $interpOnly: local := NIL        --true when in interpret only mode
;   $whereCacheList: local := NIL    --maps compiled because of where
;   $timeGlobalName: local := '$compTimeSum  --see incrementTimeSum
;   $declaredMode: local := NIL      --Weak type propagation for symbols
;   $localVars:local := NIL          --list of local variables in function
;   $analyzingMapList:local := NIL   --names of maps currently being
;                                    --analyzed
;   $instantCoerceCount: local := 0
;   $instantCanCoerceCount: local := 0
;   $instantMmCondCount: local := 0
;   $minivector: local := NIL
;   $domPvar: local := NIL
;   $inRetract: local := NIL
;   object := processInteractive1(form, posnForm)
;   if not($ProcessInteractiveValue) then
;     if $reportInstantiations = true then
;       reportInstantiations()
;       CLRHASH $instantRecord
;     writeHistModesAndValues()
;     updateHist()
;   object

(DEFUN |processInteractive| (|form| |posnForm|)
  (PROG (|$inRetract| |$domPvar| |$minivector| |$instantMmCondCount|
         |$instantCanCoerceCount| |$instantCoerceCount| |$analyzingMapList|
         |$localVars| |$declaredMode| |$timeGlobalName| |$whereCacheList|
         |$interpOnly| |$compilingLoop| |$compilingMap| |$mapList| |$freeVars|
         |$compErrorMessageStack| |$Coerce| |$op| |object| |op|)
    (DECLARE
     (SPECIAL |$inRetract| |$domPvar| |$minivector| |$instantMmCondCount|
      |$instantCanCoerceCount| |$instantCoerceCount| |$analyzingMapList|
      |$localVars| |$declaredMode| |$timeGlobalName| |$whereCacheList|
      |$interpOnly| |$compilingLoop| |$compilingMap| |$mapList| |$freeVars|
      |$compErrorMessageStack| |$Coerce| |$op|))
    (RETURN
     (PROGN
      (|initializeTimedNames| |$interpreterTimedNames|
       |$interpreterTimedClasses|)
      (SETQ |$op|
              (COND
               ((AND (CONSP |form|) (PROGN (SETQ |op| (CAR |form|)) #1='T))
                |op|)
               (#1# |form|)))
      (SETQ |$Coerce| NIL)
      (SETQ |$compErrorMessageStack| NIL)
      (SETQ |$freeVars| NIL)
      (SETQ |$mapList| NIL)
      (SETQ |$compilingMap| NIL)
      (SETQ |$compilingLoop| NIL)
      (SETQ |$interpOnly| NIL)
      (SETQ |$whereCacheList| NIL)
      (SETQ |$timeGlobalName| '|$compTimeSum|)
      (SETQ |$declaredMode| NIL)
      (SETQ |$localVars| NIL)
      (SETQ |$analyzingMapList| NIL)
      (SETQ |$instantCoerceCount| 0)
      (SETQ |$instantCanCoerceCount| 0)
      (SETQ |$instantMmCondCount| 0)
      (SETQ |$minivector| NIL)
      (SETQ |$domPvar| NIL)
      (SETQ |$inRetract| NIL)
      (SETQ |object| (|processInteractive1| |form| |posnForm|))
      (COND
       ((NULL |$ProcessInteractiveValue|)
        (COND
         ((EQUAL |$reportInstantiations| T) (|reportInstantiations|)
          (CLRHASH |$instantRecord|)))
        (|writeHistModesAndValues|) (|updateHist|)))
      |object|))))

; processInteractive1(form, posnForm) ==
;   -- calls the analysis and output printing routines
;   $e : local := $InteractiveFrame
;   recordFrame 'system
;
;   startTimingProcess 'analysis
;   object   := interpretTopLevel(form, posnForm)
;   stopTimingProcess 'analysis
;
;   startTimingProcess 'print
;   if not($ProcessInteractiveValue) then
;     recordAndPrint(objValUnwrap object,objMode object)
;   recordFrame 'normal
;   stopTimingProcess 'print
;
;   object

(DEFUN |processInteractive1| (|form| |posnForm|)
  (PROG (|$e| |object|)
    (DECLARE (SPECIAL |$e|))
    (RETURN
     (PROGN
      (SETQ |$e| |$InteractiveFrame|)
      (|recordFrame| '|system|)
      (|startTimingProcess| '|analysis|)
      (SETQ |object| (|interpretTopLevel| |form| |posnForm|))
      (|stopTimingProcess| '|analysis|)
      (|startTimingProcess| '|print|)
      (COND
       ((NULL |$ProcessInteractiveValue|)
        (|recordAndPrint| (|objValUnwrap| |object|) (|objMode| |object|))))
      (|recordFrame| '|normal|)
      (|stopTimingProcess| '|print|)
      |object|))))

; ncParseAndInterpretString s ==
;    processInteractive(parseFromString(s), nil)

(DEFUN |ncParseAndInterpretString| (|s|)
  (PROG () (RETURN (|processInteractive| (|parseFromString| |s|) NIL))))

; recordAndPrint(x,md) ==
;   --  Prints out the value x which is of type m, and records the changes
;   --  in environment $e into $InteractiveFrame
;   --  $printAnyIfTrue  is documented in setvart.boot. controlled with )se me any
;   if md = '(Any) and $printAnyIfTrue  then
;     md' := first  x
;     x' := rest x
;   else
;     x' := x
;     md' := md
;   mode:= (md=$EmptyMode => quadSch(); md)
;   if (md ~= $Void) or $printVoidIfTrue then
;     if null $collectOutput then TERPRI(get_algebra_stream())
;     if $QuietCommand = false then
;       output(x',md')
;   putHist('%,'value,objNewWrap(x,md),$e)
;   if $printTimeIfTrue or $printTypeIfTrue then printTypeAndTime(x',md')
;   if $printStorageIfTrue then printStorage()
;   if $printStatisticsSummaryIfTrue then printStatisticsSummary()
;   'done

(DEFUN |recordAndPrint| (|x| |md|)
  (PROG (|md'| |x'| |mode|)
    (RETURN
     (PROGN
      (COND
       ((AND (EQUAL |md| '(|Any|)) |$printAnyIfTrue|) (SETQ |md'| (CAR |x|))
        (SETQ |x'| (CDR |x|)))
       (#1='T (SETQ |x'| |x|) (SETQ |md'| |md|)))
      (SETQ |mode| (COND ((EQUAL |md| |$EmptyMode|) (|quadSch|)) (#1# |md|)))
      (COND
       ((OR (NOT (EQUAL |md| |$Void|)) |$printVoidIfTrue|)
        (COND ((NULL |$collectOutput|) (TERPRI (|get_algebra_stream|))))
        (COND ((NULL |$QuietCommand|) (|output| |x'| |md'|)))))
      (|putHist| '% '|value| (|objNewWrap| |x| |md|) |$e|)
      (COND
       ((OR |$printTimeIfTrue| |$printTypeIfTrue|)
        (|printTypeAndTime| |x'| |md'|)))
      (COND (|$printStorageIfTrue| (|printStorage|)))
      (COND (|$printStatisticsSummaryIfTrue| (|printStatisticsSummary|)))
      '|done|))))

; printTypeAndTime(x,m) ==  --m is the mode/type of the result
;   printTypeAndTimeNormal(x, m)

(DEFUN |printTypeAndTime| (|x| |m|)
  (PROG () (RETURN (|printTypeAndTimeNormal| |x| |m|))))

; printTypeAndTimeNormal(x,m) ==
;   -- called only if either type or time is to be displayed
;   if m is ['Union, :argl] then
;     x' := retract(objNewWrap(x,m))
;     m' := objMode x'
;     m := ['Union, :[arg for arg in argl | sameUnionBranch(arg, m')], '"..."]
;   if $printTimeIfTrue then
;     timeString := makeLongTimeString($interpreterTimedNames,
;       $interpreterTimedClasses)
;   if $printTypeIfTrue then
;       type_string := outputDomainConstructor(m)
;   $printTimeIfTrue and $printTypeIfTrue =>
;     $collectOutput =>
;       $outputLines := [msgText("S2GL0012", [type_string]), :$outputLines]
;     sayKeyedMsg("S2GL0014", [type_string, timeString])
;   $printTimeIfTrue =>
;     $collectOutput => nil
;     sayKeyedMsg("S2GL0013",[timeString])
;   $printTypeIfTrue =>
;     $collectOutput =>
;         $outputLines :=
;             [justifyMyType msgText("S2GL0012", [type_string]), :$outputLines]
;     sayKeyedMsg("S2GL0012", [type_string])

(DEFUN |printTypeAndTimeNormal| (|x| |m|)
  (PROG (|argl| |x'| |m'| |timeString| |type_string|)
    (RETURN
     (PROGN
      (COND
       ((AND (CONSP |m|) (EQ (CAR |m|) '|Union|)
             (PROGN (SETQ |argl| (CDR |m|)) #1='T))
        (SETQ |x'| (|retract| (|objNewWrap| |x| |m|)))
        (SETQ |m'| (|objMode| |x'|))
        (SETQ |m|
                (CONS '|Union|
                      (APPEND
                       ((LAMBDA (|bfVar#2| |bfVar#1| |arg|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#1|)
                                 (PROGN (SETQ |arg| (CAR |bfVar#1|)) NIL))
                             (RETURN (NREVERSE |bfVar#2|)))
                            (#1#
                             (AND (|sameUnionBranch| |arg| |m'|)
                                  (SETQ |bfVar#2| (CONS |arg| |bfVar#2|)))))
                           (SETQ |bfVar#1| (CDR |bfVar#1|))))
                        NIL |argl| NIL)
                       (CONS "..." NIL))))))
      (COND
       (|$printTimeIfTrue|
        (SETQ |timeString|
                (|makeLongTimeString| |$interpreterTimedNames|
                 |$interpreterTimedClasses|))))
      (COND
       (|$printTypeIfTrue|
        (SETQ |type_string| (|outputDomainConstructor| |m|))))
      (COND
       ((AND |$printTimeIfTrue| |$printTypeIfTrue|)
        (COND
         (|$collectOutput|
          (SETQ |$outputLines|
                  (CONS (|msgText| 'S2GL0012 (LIST |type_string|))
                        |$outputLines|)))
         (#1# (|sayKeyedMsg| 'S2GL0014 (LIST |type_string| |timeString|)))))
       (|$printTimeIfTrue|
        (COND (|$collectOutput| NIL)
              (#1# (|sayKeyedMsg| 'S2GL0013 (LIST |timeString|)))))
       (|$printTypeIfTrue|
        (COND
         (|$collectOutput|
          (SETQ |$outputLines|
                  (CONS
                   (|justifyMyType| (|msgText| 'S2GL0012 (LIST |type_string|)))
                   |$outputLines|)))
         (#1# (|sayKeyedMsg| 'S2GL0012 (LIST |type_string|))))))))))

; sameUnionBranch(uArg, m) ==
;   uArg is [":", ., t] => t = m
;   uArg = m

(DEFUN |sameUnionBranch| (|uArg| |m|)
  (PROG (|ISTMP#1| |ISTMP#2| |t|)
    (RETURN
     (COND
      ((AND (CONSP |uArg|) (EQ (CAR |uArg|) '|:|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |uArg|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |t| (CAR |ISTMP#2|)) #1='T))))))
       (EQUAL |t| |m|))
      (#1# (EQUAL |uArg| |m|))))))

; msgText(key, args) ==
;   msg := segmentKeyedMsg getKeyedMsg key
;   msg := substituteSegmentedMsg(msg,args)
;   msg := flowSegmentedMsg(msg,$LINELENGTH,$MARGIN)
;   concatenateStringList([STRINGIMAGE x for x in CDAR msg])

(DEFUN |msgText| (|key| |args|)
  (PROG (|msg|)
    (RETURN
     (PROGN
      (SETQ |msg| (|segmentKeyedMsg| (|getKeyedMsg| |key|)))
      (SETQ |msg| (|substituteSegmentedMsg| |msg| |args|))
      (SETQ |msg| (|flowSegmentedMsg| |msg| $LINELENGTH $MARGIN))
      (|concatenateStringList|
       ((LAMBDA (|bfVar#4| |bfVar#3| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#3|) (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL))
             (RETURN (NREVERSE |bfVar#4|)))
            ('T (SETQ |bfVar#4| (CONS (STRINGIMAGE |x|) |bfVar#4|))))
           (SETQ |bfVar#3| (CDR |bfVar#3|))))
        NIL (CDAR |msg|) NIL))))))

; justifyMyType(t) ==
;   len := #t
;   len > $LINELENGTH => t
;   CONCAT(fillerSpaces($LINELENGTH-len, '" "), t)

(DEFUN |justifyMyType| (|t|)
  (PROG (|len|)
    (RETURN
     (PROGN
      (SETQ |len| (LENGTH |t|))
      (COND ((< $LINELENGTH |len|) |t|)
            ('T (CONCAT (|fillerSpaces| (- $LINELENGTH |len|) " ") |t|)))))))

; typeTimePrin x ==
;   $highlightDelta: local:= 0
;   maprinSpecial(x,0,79)

(DEFUN |typeTimePrin| (|x|)
  (PROG (|$highlightDelta|)
    (DECLARE (SPECIAL |$highlightDelta|))
    (RETURN (PROGN (SETQ |$highlightDelta| 0) (|maprinSpecial| |x| 0 79)))))

; printStorage() ==
;   $collectOutput => nil
;   storeString :=
;     makeLongSpaceString($interpreterTimedNames, $interpreterTimedClasses)
;   sayKeyedMsg("S2GL0016",[storeString])

(DEFUN |printStorage| ()
  (PROG (|storeString|)
    (RETURN
     (COND (|$collectOutput| NIL)
           ('T
            (PROGN
             (SETQ |storeString|
                     (|makeLongSpaceString| |$interpreterTimedNames|
                      |$interpreterTimedClasses|))
             (|sayKeyedMsg| 'S2GL0016 (LIST |storeString|))))))))

; printStatisticsSummary() ==
;   $collectOutput => nil
;   summary := statisticsSummary()
;   sayKeyedMsg("S2GL0017",[summary])

(DEFUN |printStatisticsSummary| ()
  (PROG (|summary|)
    (RETURN
     (COND (|$collectOutput| NIL)
           ('T
            (PROGN
             (SETQ |summary| (|statisticsSummary|))
             (|sayKeyedMsg| 'S2GL0017 (LIST |summary|))))))))

; interpretTopLevel(x, posnForm) ==
;   --  Top level entry point from processInteractive1.  Sets up catch
;   --  for a thrown result
;   savedTimerStack := COPY $timedNameStack
;   c := CATCH('interpreter,interpret(x, posnForm))
;   while savedTimerStack ~= $timedNameStack repeat
;     stopTimingProcess peekTimedName()
;   c = 'tryAgain => interpretTopLevel(x, posnForm)
;   c

(DEFUN |interpretTopLevel| (|x| |posnForm|)
  (PROG (|savedTimerStack| |c|)
    (RETURN
     (PROGN
      (SETQ |savedTimerStack| (COPY |$timedNameStack|))
      (SETQ |c| (CATCH '|interpreter| (|interpret| |x| |posnForm|)))
      ((LAMBDA ()
         (LOOP
          (COND ((EQUAL |savedTimerStack| |$timedNameStack|) (RETURN NIL))
                (#1='T (|stopTimingProcess| (|peekTimedName|)))))))
      (COND ((EQ |c| '|tryAgain|) (|interpretTopLevel| |x| |posnForm|))
            (#1# |c|))))))

; interpret(x, posnForm) ==
;   --type analyzes and evaluates expression x, returns object
;   $env:local := [[NIL]]
;   $genValue:local := true       --evaluate all generated code
;   -- counter used to limit recursion depth during resolve
;   $resolve_level : local := 0
;   interpret1(x,nil,posnForm)

(DEFUN |interpret| (|x| |posnForm|)
  (PROG (|$resolve_level| |$genValue| |$env|)
    (DECLARE (SPECIAL |$resolve_level| |$genValue| |$env|))
    (RETURN
     (PROGN
      (SETQ |$env| (LIST (LIST NIL)))
      (SETQ |$genValue| T)
      (SETQ |$resolve_level| 0)
      (|interpret1| |x| NIL |posnForm|)))))

; interpret1(x,rootMode,posnForm) ==
;   -- dispatcher for the type analysis routines.  type analyzes and
;   -- evaluates the expression x in the rootMode (if non-nil)
;   -- which may be $EmptyMode.  returns an object if evaluating, and a
;   -- modeset otherwise
;
;   -- create the attributed tree
;
;   node := mkAtreeWithSrcPos(x, posnForm)
;   if rootMode then putTarget(node,rootMode)
;
;   -- do type analysis and evaluation of expression.  The real guts
;
;   modeSet:= bottomUp node
;   newRootMode := (null rootMode => first modeSet ; rootMode)
;   argVal := getArgValue(node, newRootMode)
;   argVal and not $genValue => objNew(argVal, newRootMode)
;   argVal and (val:=getValue node) => interpret2(val,newRootMode,posnForm)
;   keyedSystemError("S2IS0053",[x])

(DEFUN |interpret1| (|x| |rootMode| |posnForm|)
  (PROG (|node| |modeSet| |newRootMode| |argVal| |val|)
    (RETURN
     (PROGN
      (SETQ |node| (|mkAtreeWithSrcPos| |x| |posnForm|))
      (COND (|rootMode| (|putTarget| |node| |rootMode|)))
      (SETQ |modeSet| (|bottomUp| |node|))
      (SETQ |newRootMode|
              (COND ((NULL |rootMode|) (CAR |modeSet|)) (#1='T |rootMode|)))
      (SETQ |argVal| (|getArgValue| |node| |newRootMode|))
      (COND
       ((AND |argVal| (NULL |$genValue|)) (|objNew| |argVal| |newRootMode|))
       ((AND |argVal| (SETQ |val| (|getValue| |node|)))
        (|interpret2| |val| |newRootMode| |posnForm|))
       (#1# (|keyedSystemError| 'S2IS0053 (LIST |x|))))))))

; interpret2(object,m1,posnForm) ==
;   x := objVal object
;   m := objMode object
;   m=$EmptyMode =>
;     x is [op, :.]  and op in '(SPADMAP STREAM) => objNew(x, m1)
;     m1 = $EmptyMode => objNew(x,m)
;     systemErrorHere '"interpret2"
;   m1 =>
;     if (ans := coerceInteractive(object,m1)) then ans
;     else throwKeyedMsgCannotCoerceWithValue(x,m,m1)
;   object

(DEFUN |interpret2| (|object| |m1| |posnForm|)
  (PROG (|x| |m| |op| |ans|)
    (RETURN
     (PROGN
      (SETQ |x| (|objVal| |object|))
      (SETQ |m| (|objMode| |object|))
      (COND
       ((EQUAL |m| |$EmptyMode|)
        (COND
         ((AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) #1='T)
               (|member| |op| '(SPADMAP STREAM)))
          (|objNew| |x| |m1|))
         ((EQUAL |m1| |$EmptyMode|) (|objNew| |x| |m|))
         (#1# (|systemErrorHere| "interpret2"))))
       (|m1|
        (COND ((SETQ |ans| (|coerceInteractive| |object| |m1|)) |ans|)
              (#1# (|throwKeyedMsgCannotCoerceWithValue| |x| |m| |m1|))))
       (#1# |object|))))))

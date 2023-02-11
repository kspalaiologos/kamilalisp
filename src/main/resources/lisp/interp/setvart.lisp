
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($setOptions, '(
;   (breakmode
;    "execute break processing on error"
;    interpreter
;    LITERALS
;    $BreakMode
;    (nobreak break query resume quit)
;    nobreak)         -- needed to avoid possible startup looping
;    (compiler
;     "Library compiler options"
;     interpreter
;     TREE
;     novar
;     (
;       (output
;        "library in which to place compiled code"
;        interpreter
;        FUNCTION
;        setOutputLibrary
;        NIL
;        htSetOutputLibrary
;         )
;       (input
;        "controls libraries from which to load compiled code"
;        interpreter
;        FUNCTION
;        setInputLibrary
;        NIL
;        htSetInputLibrary)
;       (args
;        "arguments for compiling FriCAS code"
;        interpreter
;        FUNCTION
;        setAsharpArgs
;        (("enter compiler options "
;           STRING
;           $asharpCmdlineFlags
;           chkDirectory
;           "-O -Fasy -Fao -Flsp -lfricas -Mno-ALDOR__W__WillObsolete -DFriCAS -Y $FRICAS/algebra -I $FRICAS/algebra"))
;        NIL)
;     ))
;   (expose
;    "control interpreter constructor exposure"
;    interpreter
;    FUNCTION
;    setExpose
;    NIL
;    htSetExpose)
;   (functions
;    "some interpreter function options"
;    interpreter
;    TREE
;    novar
;    (
;      (cache
;       "number of function results to cache"
;       interpreter
;       FUNCTION
;       setFunctionsCache
;       NIL
;       htSetCache)
;      (compile
;       "compile, don't just define function bodies"
;       interpreter
;       LITERALS
;       $compileDontDefineFunctions
;       (on off)
;       on)
;      (recurrence
;       "specially compile recurrence relations"
;       interpreter
;       LITERALS
;       $compileRecurrence
;       (on off)
;       on)
;   ))
;   (fortran
;    "view and set options for FORTRAN output"
;    interpreter
;    TREE
;    novar
;     (
;      (ints2floats
;       "where sensible, coerce integers to reals"
;       interpreter
;       LITERALS
;       $fortInts2Floats
;       (on off)
;       on)
;      (fortindent
;       "the number of characters indented"
;       interpreter
;       INTEGER
;       $fortIndent
;       (0 NIL)
;       6)
;      (fortlength
;       "the number of characters on a line"
;       interpreter
;       INTEGER
;       $fortLength
;       (1 NIL)
;       72)
;      (typedecs
;       "print type and dimension lines"
;       interpreter
;       LITERALS
;       $printFortranDecs
;       (on off)
;       on)
;      (defaulttype
;       "default generic type for FORTRAN object"
;       interpreter
;       LITERALS
;       $defaultFortranType
;       (REAL INTEGER COMPLEX LOGICAL CHARACTER)
;       REAL)
;       (precision
;       "precision of generated FORTRAN objects"
;        interpreter
;        LITERALS
;        $fortranPrecision
;        (single double)
;        double)
;       (intrinsic
;        "whether to use INTRINSIC FORTRAN functions"
;        interpreter
;        LITERALS
;        $useIntrinsicFunctions
;        (on off)
;        off)
;       (explength
;        "character limit for FORTRAN expressions"
;        interpreter
;        INTEGER
;        $maximumFortranExpressionLength
;        (0 NIL)
;        1320)
;       (segment
;        "split long FORTRAN expressions"
;        interpreter
;        LITERALS
;        $fortranSegment
;        (on off)
;        on)
;       (optlevel
;        "FORTRAN optimisation level"
;        interpreter
;        INTEGER
;        $fortranOptimizationLevel
;        (0 2)
;        0)
;       (startindex
;        "starting index for FORTRAN arrays"
;        interpreter
;        INTEGER
;        $fortranArrayStartingIndex
;        (0 1)
;        1)
;   ))
;   (hyperdoc
;    "options in using HyperDoc"
;    interpreter
;    TREE
;    novar
;    (
;      (fullscreen
;       "use full screen for this facility"
;       interpreter
;       LITERALS
;       $fullScreenSysVars
;       (on off)
;       off)
;      (mathwidth
;       "screen width for history output"
;       interpreter
;       INTEGER
;       $historyDisplayWidth
;       (0 NIL)
;       120)
;    ))
;   (help
;    "view and set some help options"
;    interpreter
;    TREE
;    novar
;    (
;     (fullscreen
;      "use fullscreen facility, if possible"
;      interpreter
;      LITERALS
;      $useFullScreenHelp
;      (on off)
;      off)
;    ))
;   (history
;    "save workspace values in a history file"
;    interpreter
;    LITERALS
;    $HiFiAccess
;    (on off)
;    on)
;   (messages
;    "show messages for various system features"
;    interpreter
;    TREE
;    novar
;    (
;      (any
;       "print the internal type of objects of domain Any"
;       interpreter
;       LITERALS
;       $printAnyIfTrue
;       (on off)
;       on)
;      (autoload
;       "print file auto-load messages"
;       interpreter
;       LITERALS
;       $printLoadMsgs
;       (on off)
;       off)
;      (bottomup
;       "display bottom up modemap selection"
;       development
;       LITERALS
;       $reportBottomUpFlag
;       (on off)
;       off)
;      (dropmap
;       "display old map defn when replaced"
;       interpreter
;       LITERALS
;       $displayDroppedMap
;       (on off)
;       off)
;      (expose
;       "warning for unexposed functions"
;       interpreter
;       LITERALS
;       $giveExposureWarning
;       (on off)
;       off)
;      (file
;       "print msgs also to SPADMSG LISTING"
;       development
;       LITERALS
;       $printMsgsToFile
;       (on off)
;       off)
;      (frame
;       "display messages about frames"
;       interpreter
;       LITERALS
;       $frameMessages
;       (on off)
;       off)
;      (highlighting
;       "use highlighting in system messages"
;       interpreter
;       LITERALS
;       $highlightAllowed
;       (on off)
;       off)
;      (instant
;       "present instantiation summary"
;       development
;       LITERALS
;       $reportInstantiations
;       (on off)
;       off)
;      (insteach
;       "present instantiation info"
;       development
;       LITERALS
;       $reportEachInstantiation
;       (on off)
;       off)
;      (interponly
;       "say when function code is interpreted"
;       interpreter
;       LITERALS
;       $reportInterpOnly
;       (on off)
;       on)
;      (prompt
;       "set type of input prompt to display"
;       interpreter
;       LITERALS
;       $inputPromptType
;       (none frame plain step verbose)
;       step)
;      (selection
;       "display function selection msgs"
;       interpreter
;       LITERALS
;       $reportBottomUpFlag
;       (on off)
;       off)
;      (set
;       "show )set setting after assignment"
;       interpreter
;       LITERALS
;       $displaySetValue
;       (on off)
;       off)
;      (startup
;       "display messages on start-up"
;       interpreter
;       LITERALS
;       $displayStartMsgs
;       (on off)
;       on)
;      (summary
;       "print statistics after computation"
;       interpreter
;       LITERALS
;       $printStatisticsSummaryIfTrue
;       (on off)
;       off)
;      (testing
;       "print system testing header"
;       development
;       LITERALS
;       $testingSystem
;       (on off)
;       off)
;      (time
;       "print timings after computation"
;       interpreter
;       LITERALS
;       $printTimeIfTrue
;       (on off long)
;       off)
;      (type
;       "print type after computation"
;       interpreter
;       LITERALS
;       $printTypeIfTrue
;       (on off)
;       on)
;      (void
;       "print Void value when it occurs"
;       interpreter
;       LITERALS
;       $printVoidIfTrue
;       (on off)
;       off)
;    ))
;   (output
;    "view and set some output options"
;    interpreter
;    TREE
;    novar
;     (
;      (abbreviate
;       "abbreviate type names"
;       interpreter
;       LITERALS
;       $abbreviateTypes
;       (on off)
;       off)
;      (algebra
;       "display output in algebraic form"
;       interpreter
;       FUNCTION
;       setOutputAlgebra
;       (("display output in algebraic form"
;         LITERALS
;         $algebraFormat
;         (off on)
;         on)
;        (break $algebraFormat)
;        ("where algebra printing goes (enter {\em console} or a pathname)?"
;         FILENAME
;         $algebraOutputFile
;         chkOutputFileName
;         "console"))
;       NIL)
;      (characters
;       "choose special output character set"
;       interpreter
;       FUNCTION
;       setOutputCharacters
;       NIL
;       htSetOutputCharacters)
;      (fortran
;       "create output in FORTRAN format"
;       interpreter
;       FUNCTION
;       setOutputFortran
;       (("create output in FORTRAN format"
;         LITERALS
;         $fortranFormat
;         (off on)
;         off)
;        (break $fortranFormat)
;        ("where FORTRAN output goes (enter {\em console} or a a pathname)"
;         FILENAME
;         $fortranOutputFile
;         chkOutputFileName
;         "console"))
;       NIL)
;      (fraction
;       "how fractions are formatted"
;       interpreter
;       LITERALS
;       $fractionDisplayType
;       (vertical horizontal)
;       vertical)
;      (length
;       "line length of output displays"
;       interpreter
;       INTEGER
;       $LINELENGTH
;       (10 245)
;       77)
;      (openmath
;       "create output in OpenMath style"
;       interpreter
;       FUNCTION
;       setOutputOpenMath
;       (("create output in OpenMath format"
;         LITERALS
;         $openMathFormat
;         (off on)
;         off)
;        (break $openMathFormat)
;        ("where TeX output goes (enter {\em console} or a pathname)"
;         FILENAME
;         $openMathOutputFile
;         chkOutputFileName
;         "console"))
;       NIL)
;      (scripts
;       "show subscripts,... linearly"
;       interpreter
;       LITERALS
;       $linearFormatScripts
;       (yes no)
;       no)
;      (showeditor
;       "view output of )show in editor"
;       interpreter
;       LITERALS
;       $useEditorForShowOutput
;       (on off)
;       off)
;      (tex
;       "create output in TeX style"
;       interpreter
;       FUNCTION
;       setOutputTex
;       (("create output in TeX format"
;         LITERALS
;         $texFormat
;         (off on)
;         off)
;        (break $texFormat)
;        ("where TeX output goes (enter {\em console} or a pathname)"
;         FILENAME
;         $texOutputFile
;         chkOutputFileName
;         "console"))
;       NIL)
;      (mathml
;       "create output in MathML style"
;       interpreter
;       FUNCTION
;       setOutputMathml
;       (("create output in MathML format"
;         LITERALS
;         $mathmlFormat
;         (off on)
;         off)
;        (break $mathmlFormat)
;        ("where MathML output goes (enter {\em console} or a pathname)"
;         FILENAME
;         $mathmlOutputFile
;         chkOutputFileName
;         "console"))
;       NIL)
;      (texmacs
;       "create output in Texmacs style"
;       interpreter
;       FUNCTION
;       setOutputTexmacs
;       (("create output in Texmacs format"
;         LITERALS
;         $texmacsFormat
;         (off on)
;         off)
;        (break $texmacsFormat)
;        ("where Texmacs output goes (enter {\em console} or a pathname)"
;         FILENAME
;         $texmacsOutputFile
;         chkOutputFileName
;         "console"))
;       NIL)
;      (html
;       "create output in HTML style"
;       interpreter
;       FUNCTION
;       setOutputHtml
;       (("create output in HTML format"
;         LITERALS
;         $htmlFormat
;         (off on)
;         off)
;        (break $htmlFormat)
;        ("where HTML output goes (enter {\em console} or a pathname)"
;         FILENAME
;         $htmlOutputFile
;         chkOutputFileName
;         "console"))
;       NIL)
;      (formatted
;       "create output in formatted style"
;       interpreter
;       FUNCTION
;       setOutputFormatted
;       (("create output via format engine"
;         LITERALS
;         $formattedFormat
;         (off on)
;         off)
;        (break $formattedFormat)
;        ("where formatted output goes (enter {\em console} or a pathname)"
;         FILENAME
;         $formattedOutputFile
;         chkOutputFileName
;         "console"))
;       NIL)
;  ))
;   (quit
;    "protected or unprotected quit"
;    interpreter
;    LITERALS
;    $quitCommandType
;    (protected unprotected)
;    unprotected)
;   (streams
;    "set some options for working with streams"
;    interpreter
;    TREE
;    novar
;    (
;      (calculate
;       "specify number of elements to calculate"
;       interpreter
;       FUNCTION
;       setStreamsCalculate
;       (("number of initial stream elements you want calculated"
;        INTEGER
;        $streamCount
;        (0 NIL)
;        10))
;       NIL)
;     (showall
;      "display all stream elements computed"
;      interpreter
;      LITERALS
;      $streamsShowAll
;      (on off)
;      off)
;   ))
;   (system
;    "set some system development variables"
;    development
;    TREE
;    novar
;    (
;      (functioncode
;       "show gen. LISP for functions when compiled"
;       development
;       LITERALS
;       $reportCompilation
;       (on off)
;       off)
;      (optimization
;       "show optimized LISP code"
;       development
;       LITERALS
;       $reportOptimization
;       (on off)
;       off)
;      (prettyprint
;       "prettyprint BOOT func's as they compile"
;       development
;       LITERALS
;       $PRETTYPRINT
;       (on off)
;       off)
;    ))
;   (userlevel
;    "operation access level of system user"
;    interpreter
;    LITERALS
;    $UserLevel
;    (interpreter compiler development)
;    development)
;  ))

(DEFPARAMETER |$setOptions|
  '((|breakmode| "execute break processing on error" |interpreter| LITERALS
     |$BreakMode| (|nobreak| |break| |query| |resume| |quit|) |nobreak|)
    (|compiler| "Library compiler options" |interpreter| TREE |novar|
     ((|output| "library in which to place compiled code" |interpreter|
       FUNCTION |setOutputLibrary| NIL |htSetOutputLibrary|)
      (|input| "controls libraries from which to load compiled code"
       |interpreter| FUNCTION |setInputLibrary| NIL |htSetInputLibrary|)
      (|args| "arguments for compiling FriCAS code" |interpreter| FUNCTION
       |setAsharpArgs|
       (("enter compiler options " STRING |$asharpCmdlineFlags| |chkDirectory|
         "-O -Fasy -Fao -Flsp -lfricas -Mno-ALDOR_W_WillObsolete -DFriCAS -Y $FRICAS/algebra -I $FRICAS/algebra"))
       NIL)))
    (|expose| "control interpreter constructor exposure" |interpreter| FUNCTION
     |setExpose| NIL |htSetExpose|)
    (|functions| "some interpreter function options" |interpreter| TREE |novar|
     ((|cache| "number of function results to cache" |interpreter| FUNCTION
       |setFunctionsCache| NIL |htSetCache|)
      (|compile| "compile, don't just define function bodies" |interpreter|
       LITERALS |$compileDontDefineFunctions| (|on| |off|) |on|)
      (|recurrence| "specially compile recurrence relations" |interpreter|
       LITERALS |$compileRecurrence| (|on| |off|) |on|)))
    (|fortran| "view and set options for FORTRAN output" |interpreter| TREE
     |novar|
     ((|ints2floats| "where sensible, coerce integers to reals" |interpreter|
       LITERALS |$fortInts2Floats| (|on| |off|) |on|)
      (|fortindent| "the number of characters indented" |interpreter| INTEGER
       |$fortIndent| (0 NIL) 6)
      (|fortlength| "the number of characters on a line" |interpreter| INTEGER
       |$fortLength| (1 NIL) 72)
      (|typedecs| "print type and dimension lines" |interpreter| LITERALS
       |$printFortranDecs| (|on| |off|) |on|)
      (|defaulttype| "default generic type for FORTRAN object" |interpreter|
       LITERALS |$defaultFortranType| (REAL INTEGER COMPLEX LOGICAL CHARACTER)
       REAL)
      (|precision| "precision of generated FORTRAN objects" |interpreter|
       LITERALS |$fortranPrecision| (|single| |double|) |double|)
      (|intrinsic| "whether to use INTRINSIC FORTRAN functions" |interpreter|
       LITERALS |$useIntrinsicFunctions| (|on| |off|) |off|)
      (|explength| "character limit for FORTRAN expressions" |interpreter|
       INTEGER |$maximumFortranExpressionLength| (0 NIL) 1320)
      (|segment| "split long FORTRAN expressions" |interpreter| LITERALS
       |$fortranSegment| (|on| |off|) |on|)
      (|optlevel| "FORTRAN optimisation level" |interpreter| INTEGER
       |$fortranOptimizationLevel| (0 2) 0)
      (|startindex| "starting index for FORTRAN arrays" |interpreter| INTEGER
       |$fortranArrayStartingIndex| (0 1) 1)))
    (|hyperdoc| "options in using HyperDoc" |interpreter| TREE |novar|
     ((|fullscreen| "use full screen for this facility" |interpreter| LITERALS
       |$fullScreenSysVars| (|on| |off|) |off|)
      (|mathwidth| "screen width for history output" |interpreter| INTEGER
       |$historyDisplayWidth| (0 NIL) 120)))
    (|help| "view and set some help options" |interpreter| TREE |novar|
     ((|fullscreen| "use fullscreen facility, if possible" |interpreter|
       LITERALS |$useFullScreenHelp| (|on| |off|) |off|)))
    (|history| "save workspace values in a history file" |interpreter| LITERALS
     |$HiFiAccess| (|on| |off|) |on|)
    (|messages| "show messages for various system features" |interpreter| TREE
     |novar|
     ((|any| "print the internal type of objects of domain Any" |interpreter|
       LITERALS |$printAnyIfTrue| (|on| |off|) |on|)
      (|autoload| "print file auto-load messages" |interpreter| LITERALS
       |$printLoadMsgs| (|on| |off|) |off|)
      (|bottomup| "display bottom up modemap selection" |development| LITERALS
       |$reportBottomUpFlag| (|on| |off|) |off|)
      (|dropmap| "display old map defn when replaced" |interpreter| LITERALS
       |$displayDroppedMap| (|on| |off|) |off|)
      (|expose| "warning for unexposed functions" |interpreter| LITERALS
       |$giveExposureWarning| (|on| |off|) |off|)
      (|file| "print msgs also to SPADMSG LISTING" |development| LITERALS
       |$printMsgsToFile| (|on| |off|) |off|)
      (|frame| "display messages about frames" |interpreter| LITERALS
       |$frameMessages| (|on| |off|) |off|)
      (|highlighting| "use highlighting in system messages" |interpreter|
       LITERALS |$highlightAllowed| (|on| |off|) |off|)
      (|instant| "present instantiation summary" |development| LITERALS
       |$reportInstantiations| (|on| |off|) |off|)
      (|insteach| "present instantiation info" |development| LITERALS
       |$reportEachInstantiation| (|on| |off|) |off|)
      (|interponly| "say when function code is interpreted" |interpreter|
       LITERALS |$reportInterpOnly| (|on| |off|) |on|)
      (|prompt| "set type of input prompt to display" |interpreter| LITERALS
       |$inputPromptType| (|none| |frame| |plain| |step| |verbose|) |step|)
      (|selection| "display function selection msgs" |interpreter| LITERALS
       |$reportBottomUpFlag| (|on| |off|) |off|)
      (|set| "show )set setting after assignment" |interpreter| LITERALS
       |$displaySetValue| (|on| |off|) |off|)
      (|startup| "display messages on start-up" |interpreter| LITERALS
       |$displayStartMsgs| (|on| |off|) |on|)
      (|summary| "print statistics after computation" |interpreter| LITERALS
       |$printStatisticsSummaryIfTrue| (|on| |off|) |off|)
      (|testing| "print system testing header" |development| LITERALS
       |$testingSystem| (|on| |off|) |off|)
      (|time| "print timings after computation" |interpreter| LITERALS
       |$printTimeIfTrue| (|on| |off| |long|) |off|)
      (|type| "print type after computation" |interpreter| LITERALS
       |$printTypeIfTrue| (|on| |off|) |on|)
      (|void| "print Void value when it occurs" |interpreter| LITERALS
       |$printVoidIfTrue| (|on| |off|) |off|)))
    (|output| "view and set some output options" |interpreter| TREE |novar|
     ((|abbreviate| "abbreviate type names" |interpreter| LITERALS
       |$abbreviateTypes| (|on| |off|) |off|)
      (|algebra| "display output in algebraic form" |interpreter| FUNCTION
       |setOutputAlgebra|
       (("display output in algebraic form" LITERALS |$algebraFormat|
         (|off| |on|) |on|)
        (|break| |$algebraFormat|)
        ("where algebra printing goes (enter {\\em console} or a pathname)?"
         FILENAME |$algebraOutputFile| |chkOutputFileName| "console"))
       NIL)
      (|characters| "choose special output character set" |interpreter|
       FUNCTION |setOutputCharacters| NIL |htSetOutputCharacters|)
      (|fortran| "create output in FORTRAN format" |interpreter| FUNCTION
       |setOutputFortran|
       (("create output in FORTRAN format" LITERALS |$fortranFormat|
         (|off| |on|) |off|)
        (|break| |$fortranFormat|)
        ("where FORTRAN output goes (enter {\\em console} or a a pathname)"
         FILENAME |$fortranOutputFile| |chkOutputFileName| "console"))
       NIL)
      (|fraction| "how fractions are formatted" |interpreter| LITERALS
       |$fractionDisplayType| (|vertical| |horizontal|) |vertical|)
      (|length| "line length of output displays" |interpreter| INTEGER
       $LINELENGTH (10 245) 77)
      (|openmath| "create output in OpenMath style" |interpreter| FUNCTION
       |setOutputOpenMath|
       (("create output in OpenMath format" LITERALS |$openMathFormat|
         (|off| |on|) |off|)
        (|break| |$openMathFormat|)
        ("where TeX output goes (enter {\\em console} or a pathname)" FILENAME
         |$openMathOutputFile| |chkOutputFileName| "console"))
       NIL)
      (|scripts| "show subscripts,... linearly" |interpreter| LITERALS
       |$linearFormatScripts| (|yes| |no|) |no|)
      (|showeditor| "view output of )show in editor" |interpreter| LITERALS
       |$useEditorForShowOutput| (|on| |off|) |off|)
      (|tex| "create output in TeX style" |interpreter| FUNCTION |setOutputTex|
       (("create output in TeX format" LITERALS |$texFormat| (|off| |on|)
         |off|)
        (|break| |$texFormat|)
        ("where TeX output goes (enter {\\em console} or a pathname)" FILENAME
         |$texOutputFile| |chkOutputFileName| "console"))
       NIL)
      (|mathml| "create output in MathML style" |interpreter| FUNCTION
       |setOutputMathml|
       (("create output in MathML format" LITERALS |$mathmlFormat| (|off| |on|)
         |off|)
        (|break| |$mathmlFormat|)
        ("where MathML output goes (enter {\\em console} or a pathname)"
         FILENAME |$mathmlOutputFile| |chkOutputFileName| "console"))
       NIL)
      (|texmacs| "create output in Texmacs style" |interpreter| FUNCTION
       |setOutputTexmacs|
       (("create output in Texmacs format" LITERALS |$texmacsFormat|
         (|off| |on|) |off|)
        (|break| |$texmacsFormat|)
        ("where Texmacs output goes (enter {\\em console} or a pathname)"
         FILENAME |$texmacsOutputFile| |chkOutputFileName| "console"))
       NIL)
      (|html| "create output in HTML style" |interpreter| FUNCTION
       |setOutputHtml|
       (("create output in HTML format" LITERALS |$htmlFormat| (|off| |on|)
         |off|)
        (|break| |$htmlFormat|)
        ("where HTML output goes (enter {\\em console} or a pathname)" FILENAME
         |$htmlOutputFile| |chkOutputFileName| "console"))
       NIL)
      (|formatted| "create output in formatted style" |interpreter| FUNCTION
       |setOutputFormatted|
       (("create output via format engine" LITERALS |$formattedFormat|
         (|off| |on|) |off|)
        (|break| |$formattedFormat|)
        ("where formatted output goes (enter {\\em console} or a pathname)"
         FILENAME |$formattedOutputFile| |chkOutputFileName| "console"))
       NIL)))
    (|quit| "protected or unprotected quit" |interpreter| LITERALS
     |$quitCommandType| (|protected| |unprotected|) |unprotected|)
    (|streams| "set some options for working with streams" |interpreter| TREE
     |novar|
     ((|calculate| "specify number of elements to calculate" |interpreter|
       FUNCTION |setStreamsCalculate|
       (("number of initial stream elements you want calculated" INTEGER
         |$streamCount| (0 NIL) 10))
       NIL)
      (|showall| "display all stream elements computed" |interpreter| LITERALS
       |$streamsShowAll| (|on| |off|) |off|)))
    (|system| "set some system development variables" |development| TREE
     |novar|
     ((|functioncode| "show gen. LISP for functions when compiled"
       |development| LITERALS |$reportCompilation| (|on| |off|) |off|)
      (|optimization| "show optimized LISP code" |development| LITERALS
       |$reportOptimization| (|on| |off|) |off|)
      (|prettyprint| "prettyprint BOOT func's as they compile" |development|
       LITERALS $PRETTYPRINT (|on| |off|) |off|)))
    (|userlevel| "operation access level of system user" |interpreter| LITERALS
     |$UserLevel| (|interpreter| |compiler| |development|) |development|)))

; DEFPARAMETER($setOptionNames, [x.0 for x in $setOptions])

(DEFPARAMETER |$setOptionNames|
  ((LAMBDA (|bfVar#2| |bfVar#1| |x|)
     (LOOP
      (COND
       ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
        (RETURN (NREVERSE |bfVar#2|)))
       ('T (SETQ |bfVar#2| (CONS (ELT |x| 0) |bfVar#2|))))
      (SETQ |bfVar#1| (CDR |bfVar#1|))))
   NIL |$setOptions| NIL))

; initializeSetVariables $setOptions

(EVAL-WHEN (EVAL LOAD)
  (PROG () (RETURN (|initializeSetVariables| |$setOptions|))))


; )package "BOOT"

(IN-PACKAGE "BOOT")

; reportFunctionCompilation(op,nam,argl,body,isRecursive) ==
;   -- for an alternate definition of this function which does not allow
;   -- dynamic caching, see SLAMOLD BOOT
; --+
;   $compiledOpNameList := [nam]
;   minivectorName := makeInternalMapMinivectorName(nam)
;   body := substitute(minivectorName, "$$$", body)
;   SET(minivectorName,LIST2REFVEC $minivector)
;   argl := COPY argl     -- play it safe for optimization
;   init :=
;     not(isRecursive and $compileRecurrence and #argl = 1) => nil
;     NRTisRecurrenceRelation(nam,body,minivectorName)
;   init => compileRecurrenceRelation(op,nam,argl,body,init)
;   cacheCount:= getCacheCount op
;   cacheCount = "all" => reportFunctionCacheAll(op,nam,argl,body)
;   cacheCount = 0 or null argl =>
;     function:= [nam,['LAMBDA,[:argl,'envArg],body]]
;     compileInteractive function
;     nam
;   num :=
;     FIXP cacheCount =>
;       cacheCount < 1 =>
;         keyedSystemError("S2IM0019",[cacheCount,op])
;       cacheCount
;     keyedSystemError("S2IM0019",[cacheCount,op])
;   sayKeyedMsg("S2IX0003",[op,num])
;   auxfn := mkAuxiliaryName nam
;   g1:= GENSYM()  --argument or argument list
;   [arg,computeValue] :=
;     null argl => [nil,[auxfn]]
;     argl is [.] => [[g1, 'envArg],[auxfn,g1, 'envArg]]  --g1 is a parameter
;     [g1, ['APPLY, MKQ auxfn, g1]]          --g1 is a parameter list
;   cacheName := mkCacheName nam
;   g2:= GENSYM()  --length of cache or arg-value pair
;   g3:= GENSYM()  --value computed by calling function
;   secondPredPair:=
;     null argl => [cacheName]
;     [['SETQ,g3,['assocCircular,g1,cacheName]],['CDR,g3]]
;   thirdPredPair:=
;     null argl => ['(QUOTE T),['SETQ,cacheName,computeValue]]
;     ['(QUOTE T),
;       ['SETQ,g2,computeValue],
;         ['SETQ,g3,
;             ['CAR,['SETQ,cacheName,['predCircular,cacheName,cacheCount]]]],
;           ['RPLACA,g3,g1],
;             ['RPLACD,g3,g2],
;               g2]
;   codeBody:=
;     ['PROG,[g2,g3],['RETURN,['COND,secondPredPair,thirdPredPair]]]
;   -- cannot use envArg in next statement without redoing much
;   -- of above.
;   lamex:= ['LAMBDA, arg, codeBody]
;   mainFunction:= [nam,lamex]
;   computeFunction:= [auxfn,['LAMBDA,[:argl, 'envArg],body]]
;   compileInteractive mainFunction
;   compileInteractive computeFunction
;   cacheType:= 'function
;   cacheResetCode:= ['SETQ,cacheName,['mkCircularAlist,cacheCount]]
;   cacheCountCode:= ['countCircularAlist,cacheName,cacheCount]
;   cacheVector:=
;     mkCacheVec(op,cacheName,cacheType,cacheResetCode,cacheCountCode)
;   $e:= put(nam,'cacheInfo, cacheVector,$e)
;   eval cacheResetCode
;   SET(cacheName,mkCircularAlist cacheCount)
;   nam

(DEFUN |reportFunctionCompilation| (|op| |nam| |argl| |body| |isRecursive|)
  (PROG (|minivectorName| |init| |cacheCount| FUNCTION |num| |auxfn| |g1|
         |LETTMP#1| |arg| |computeValue| |cacheName| |g2| |g3| |secondPredPair|
         |thirdPredPair| |codeBody| |lamex| |mainFunction| |computeFunction|
         |cacheType| |cacheResetCode| |cacheCountCode| |cacheVector|)
    (RETURN
     (PROGN
      (SETQ |$compiledOpNameList| (LIST |nam|))
      (SETQ |minivectorName| (|makeInternalMapMinivectorName| |nam|))
      (SETQ |body| (|substitute| |minivectorName| '$$$ |body|))
      (SET |minivectorName| (LIST2REFVEC |$minivector|))
      (SETQ |argl| (COPY |argl|))
      (SETQ |init|
              (COND
               ((NULL
                 (AND |isRecursive| |$compileRecurrence|
                      (EQL (LENGTH |argl|) 1)))
                NIL)
               (#1='T
                (|NRTisRecurrenceRelation| |nam| |body| |minivectorName|))))
      (COND
       (|init| (|compileRecurrenceRelation| |op| |nam| |argl| |body| |init|))
       (#1#
        (PROGN
         (SETQ |cacheCount| (|getCacheCount| |op|))
         (COND
          ((EQ |cacheCount| '|all|)
           (|reportFunctionCacheAll| |op| |nam| |argl| |body|))
          ((OR (EQL |cacheCount| 0) (NULL |argl|))
           (PROGN
            (SETQ FUNCTION
                    (LIST |nam|
                          (LIST 'LAMBDA (APPEND |argl| (CONS '|envArg| NIL))
                                |body|)))
            (|compileInteractive| FUNCTION)
            |nam|))
          (#1#
           (PROGN
            (SETQ |num|
                    (COND
                     ((FIXP |cacheCount|)
                      (COND
                       ((< |cacheCount| 1)
                        (|keyedSystemError| 'S2IM0019
                         (LIST |cacheCount| |op|)))
                       (#1# |cacheCount|)))
                     (#1#
                      (|keyedSystemError| 'S2IM0019
                       (LIST |cacheCount| |op|)))))
            (|sayKeyedMsg| 'S2IX0003 (LIST |op| |num|))
            (SETQ |auxfn| (|mkAuxiliaryName| |nam|))
            (SETQ |g1| (GENSYM))
            (SETQ |LETTMP#1|
                    (COND ((NULL |argl|) (LIST NIL (LIST |auxfn|)))
                          ((AND (CONSP |argl|) (EQ (CDR |argl|) NIL))
                           (LIST (LIST |g1| '|envArg|)
                                 (LIST |auxfn| |g1| '|envArg|)))
                          (#1# (LIST |g1| (LIST 'APPLY (MKQ |auxfn|) |g1|)))))
            (SETQ |arg| (CAR |LETTMP#1|))
            (SETQ |computeValue| (CADR |LETTMP#1|))
            (SETQ |cacheName| (|mkCacheName| |nam|))
            (SETQ |g2| (GENSYM))
            (SETQ |g3| (GENSYM))
            (SETQ |secondPredPair|
                    (COND ((NULL |argl|) (LIST |cacheName|))
                          (#1#
                           (LIST
                            (LIST 'SETQ |g3|
                                  (LIST '|assocCircular| |g1| |cacheName|))
                            (LIST 'CDR |g3|)))))
            (SETQ |thirdPredPair|
                    (COND
                     ((NULL |argl|)
                      (LIST ''T (LIST 'SETQ |cacheName| |computeValue|)))
                     (#1#
                      (LIST ''T (LIST 'SETQ |g2| |computeValue|)
                            (LIST 'SETQ |g3|
                                  (LIST 'CAR
                                        (LIST 'SETQ |cacheName|
                                              (LIST '|predCircular| |cacheName|
                                                    |cacheCount|))))
                            (LIST 'RPLACA |g3| |g1|) (LIST 'RPLACD |g3| |g2|)
                            |g2|))))
            (SETQ |codeBody|
                    (LIST 'PROG (LIST |g2| |g3|)
                          (LIST 'RETURN
                                (LIST 'COND |secondPredPair|
                                      |thirdPredPair|))))
            (SETQ |lamex| (LIST 'LAMBDA |arg| |codeBody|))
            (SETQ |mainFunction| (LIST |nam| |lamex|))
            (SETQ |computeFunction|
                    (LIST |auxfn|
                          (LIST 'LAMBDA (APPEND |argl| (CONS '|envArg| NIL))
                                |body|)))
            (|compileInteractive| |mainFunction|)
            (|compileInteractive| |computeFunction|)
            (SETQ |cacheType| '|function|)
            (SETQ |cacheResetCode|
                    (LIST 'SETQ |cacheName|
                          (LIST '|mkCircularAlist| |cacheCount|)))
            (SETQ |cacheCountCode|
                    (LIST '|countCircularAlist| |cacheName| |cacheCount|))
            (SETQ |cacheVector|
                    (|mkCacheVec| |op| |cacheName| |cacheType| |cacheResetCode|
                     |cacheCountCode|))
            (SETQ |$e| (|put| |nam| '|cacheInfo| |cacheVector| |$e|))
            (|eval| |cacheResetCode|)
            (SET |cacheName| (|mkCircularAlist| |cacheCount|))
            |nam|))))))))))

; getCacheCount fn ==
;   n:= LASSOC(fn,$cacheAlist) => n
;   $cacheCount

(DEFUN |getCacheCount| (|fn|)
  (PROG (|n|)
    (RETURN
     (COND ((SETQ |n| (LASSOC |fn| |$cacheAlist|)) |n|) ('T |$cacheCount|)))))

; reportFunctionCacheAll(op,nam,argl,body) ==
;   sayKeyedMsg("S2IX0004",[op])
;   auxfn:= mkAuxiliaryName nam
;   g1:= GENSYM()  --argument or argument list
;   [arg,computeValue] :=
;     null argl => [['envArg],[auxfn, 'envArg]]
;     argl is [.] => [[g1, 'envArg],[auxfn,g1, 'envArg]]  --g1 is a parameter
;     [g1, ['APPLY, MKQ auxfn, g1]]          --g1 is a parameter list
;   if null argl then g1:=nil
;   cacheName:= mkCacheName nam
;   g2:= GENSYM()  --value computed by calling function
;   secondPredPair:= [['SETQ,g2,['HGET,cacheName,g1]],g2]
;   thirdPredPair:= ['(QUOTE T),['HPUT,cacheName,g1,computeValue]]
;   codeBody:= ['PROG,[g2],['RETURN,['COND,secondPredPair,thirdPredPair]]]
;   lamex:= ['LAMBDA, arg, codeBody]
;   mainFunction:= [nam,lamex]
;   computeFunction:= [auxfn,['LAMBDA,[:argl, 'envArg],body]]
;   compileInteractive mainFunction
;   compileInteractive computeFunction
;   cacheType:= 'hash_-table
;   cacheResetCode := ['SETQ, cacheName, ['MAKE_HASHTABLE, ''UEQUAL]]
;   cacheCountCode:= ['hashCount,cacheName]
;   cacheVector:=
;     mkCacheVec(op,cacheName,cacheType,cacheResetCode,cacheCountCode)
;   $e:= put(nam,'cacheInfo, cacheVector,$e)
;   eval cacheResetCode
;   nam

(DEFUN |reportFunctionCacheAll| (|op| |nam| |argl| |body|)
  (PROG (|auxfn| |g1| |LETTMP#1| |arg| |computeValue| |cacheName| |g2|
         |secondPredPair| |thirdPredPair| |codeBody| |lamex| |mainFunction|
         |computeFunction| |cacheType| |cacheResetCode| |cacheCountCode|
         |cacheVector|)
    (RETURN
     (PROGN
      (|sayKeyedMsg| 'S2IX0004 (LIST |op|))
      (SETQ |auxfn| (|mkAuxiliaryName| |nam|))
      (SETQ |g1| (GENSYM))
      (SETQ |LETTMP#1|
              (COND
               ((NULL |argl|) (LIST (LIST '|envArg|) (LIST |auxfn| '|envArg|)))
               ((AND (CONSP |argl|) (EQ (CDR |argl|) NIL))
                (LIST (LIST |g1| '|envArg|) (LIST |auxfn| |g1| '|envArg|)))
               ('T (LIST |g1| (LIST 'APPLY (MKQ |auxfn|) |g1|)))))
      (SETQ |arg| (CAR |LETTMP#1|))
      (SETQ |computeValue| (CADR |LETTMP#1|))
      (COND ((NULL |argl|) (SETQ |g1| NIL)))
      (SETQ |cacheName| (|mkCacheName| |nam|))
      (SETQ |g2| (GENSYM))
      (SETQ |secondPredPair|
              (LIST (LIST 'SETQ |g2| (LIST 'HGET |cacheName| |g1|)) |g2|))
      (SETQ |thirdPredPair|
              (LIST ''T (LIST 'HPUT |cacheName| |g1| |computeValue|)))
      (SETQ |codeBody|
              (LIST 'PROG (LIST |g2|)
                    (LIST 'RETURN
                          (LIST 'COND |secondPredPair| |thirdPredPair|))))
      (SETQ |lamex| (LIST 'LAMBDA |arg| |codeBody|))
      (SETQ |mainFunction| (LIST |nam| |lamex|))
      (SETQ |computeFunction|
              (LIST |auxfn|
                    (LIST 'LAMBDA (APPEND |argl| (CONS '|envArg| NIL))
                          |body|)))
      (|compileInteractive| |mainFunction|)
      (|compileInteractive| |computeFunction|)
      (SETQ |cacheType| '|hash-table|)
      (SETQ |cacheResetCode|
              (LIST 'SETQ |cacheName| (LIST 'MAKE_HASHTABLE ''UEQUAL)))
      (SETQ |cacheCountCode| (LIST '|hashCount| |cacheName|))
      (SETQ |cacheVector|
              (|mkCacheVec| |op| |cacheName| |cacheType| |cacheResetCode|
               |cacheCountCode|))
      (SETQ |$e| (|put| |nam| '|cacheInfo| |cacheVector| |$e|))
      (|eval| |cacheResetCode|)
      |nam|))))

; hashCount table ==
;   +/[ADD1 nodeCount HGET(table,key) for key in HKEYS table]

(DEFUN |hashCount| (|table|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#2| |bfVar#1| |key|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|) (PROGN (SETQ |key| (CAR |bfVar#1|)) NIL))
           (RETURN |bfVar#2|))
          ('T
           (SETQ |bfVar#2|
                   (+ |bfVar#2| (ADD1 (|nodeCount| (HGET |table| |key|)))))))
         (SETQ |bfVar#1| (CDR |bfVar#1|))))
      0 (HKEYS |table|) NIL))))

; mkCircularAlist n ==
;   l:= [[$failed,:$failed] for i in 1..n]
;   RPLACD(LASTNODE l,l)

(DEFUN |mkCircularAlist| (|n|)
  (PROG (|l|)
    (RETURN
     (PROGN
      (SETQ |l|
              ((LAMBDA (|bfVar#3| |i|)
                 (LOOP
                  (COND ((> |i| |n|) (RETURN (NREVERSE |bfVar#3|)))
                        ('T
                         (SETQ |bfVar#3|
                                 (CONS (CONS |$failed| |$failed|) |bfVar#3|))))
                  (SETQ |i| (+ |i| 1))))
               NIL 1))
      (RPLACD (LASTNODE |l|) |l|)))))

; countCircularAlist(cal,n) ==
;   +/[nodeCount x for x in cal for i in 1..n]

(DEFUN |countCircularAlist| (|cal| |n|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#5| |bfVar#4| |x| |i|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#4|) (PROGN (SETQ |x| (CAR |bfVar#4|)) NIL)
               (> |i| |n|))
           (RETURN |bfVar#5|))
          ('T (SETQ |bfVar#5| (+ |bfVar#5| (|nodeCount| |x|)))))
         (SETQ |bfVar#4| (CDR |bfVar#4|))
         (SETQ |i| (+ |i| 1))))
      0 |cal| NIL 1))))

; predCircular(al,n) ==
;   for i in 1..dec_SI n repeat al := QCDR al
;   al

(DEFUN |predCircular| (|al| |n|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#6| |i|)
         (LOOP
          (COND ((> |i| |bfVar#6|) (RETURN NIL)) ('T (SETQ |al| (QCDR |al|))))
          (SETQ |i| (+ |i| 1))))
       (|dec_SI| |n|) 1)
      |al|))))

; assocCircular(x,al) ==  --like ASSOC except that al is circular
;   forwardPointer:= al
;   val:= nil
;   until EQ(forwardPointer,al) repeat
;     EQUAL(CAAR forwardPointer,x) => return (val := first forwardPointer)
;     forwardPointer := rest forwardPointer
;   val

(DEFUN |assocCircular| (|x| |al|)
  (PROG (|forwardPointer| |val|)
    (RETURN
     (PROGN
      (SETQ |forwardPointer| |al|)
      (SETQ |val| NIL)
      ((LAMBDA (|bfVar#7|)
         (LOOP
          (COND (|bfVar#7| (RETURN NIL))
                (#1='T
                 (COND
                  ((EQUAL (CAAR |forwardPointer|) |x|)
                   (RETURN (SETQ |val| (CAR |forwardPointer|))))
                  (#1# (SETQ |forwardPointer| (CDR |forwardPointer|))))))
          (SETQ |bfVar#7| (EQ |forwardPointer| |al|))))
       NIL)
      |val|))))

; compileRecurrenceRelation(op,nam,argl,junk,[body,sharpArg,n,:initCode]) ==
;   k:= #initCode
;   extraArgumentCode :=
;     extraArguments := [x for x in argl | x ~= sharpArg] =>
;       extraArguments is [x] => x
;       ['LIST,:extraArguments]
;     nil
;   g:= GENSYM()
;   gIndex:= GENSYM()
;   gsList:= [GENSYM() for x in initCode]
;   auxfn := mkAuxiliaryName(nam)
;   $compiledOpNameList := [:$compiledOpNameList,auxfn]
;   stateNam:= GENVAR()
;   stateVar:= GENSYM()
;   stateVal:= GENSYM()
;   lastArg := INTERNL1('"#", STRINGIMAGE(inc_SI(LENGTH(argl))))
;   decomposeCode:=
;     [['LET,gIndex,['ELT,lastArg,0]],:[['LET,g,['ELT,lastArg,i]]
;       for g in gsList for i in 1..]]
;   gsRev:= REVERSE gsList
;   rotateCode:= [['LET,p,q] for p in gsRev for q in [:rest gsRev,g]]
;   advanceCode:= ['LET,gIndex,['ADD1,gIndex]]
;
;   newTripleCode := ['LIST,sharpArg,:gsList]
;   newStateCode :=
;     null extraArguments => ['SETQ,stateNam,newTripleCode]
;     ['HPUT,stateNam,extraArgumentCode,newTripleCode]
;
;   computeFunction:= [auxfn,['LAMBDA, cargl, cbody]] where
;     cargl:= [:argl,lastArg]
;     returnValue:= ['PROGN,newStateCode,first gsList]
;     cbody:=
;       endTest:=
;         ['COND, [['EQL,sharpArg,gIndex],['RETURN,returnValue]]]
;       newValueCode := ['LET, g, substitute(gIndex, sharpArg,
;         EQSUBSTLIST(gsList,rest $TriangleVariableList,body))]
;       ['PROGN,:decomposeCode,
;         ['REPEAT,['WHILE,'T],['PROGN,endTest,advanceCode,
;           newValueCode,:rotateCode]]]
;   mainFunction:= [nam,['LAMBDA, margl, mbody]] where
;     margl:= [:argl,'envArg]
;     max:= GENSYM()
;     tripleCode := ['CONS,n,['LIST,:initCode]]
;
;     -- initialSetCode initializes the global variable if necessary and
;     --  also binds "stateVar" to its current value
;     initialSetCode :=
;       initialValueCode :=
;         extraArguments => ['MAKE_HASHTABLE, ''UEQUAL]
;         tripleCode
;       cacheResetCode := ['SETQ,stateNam,initialValueCode]
;       ['COND,[['NULL,['AND,['BOUNDP,MKQ stateNam], _
;                           ['PAIRP,stateNam]]],    _
;                  ['LET,stateVar,cacheResetCode]], _
;              [''T, ['LET,stateVar,stateNam]]]
;
;     -- when there are extra arguments, initialResetCode resets "stateVar"
;     --  to the hashtable entry for the extra arguments
;     initialResetCode :=
;       null extraArguments => nil
;       [['LET,stateVar,['OR,
;          ['HGET,stateVar,extraArgumentCode],
;           ['HPUT,stateVar,extraArgumentCode,tripleCode]]]]
;
;     mbody :=
;       preset := [initialSetCode,:initialResetCode,['LET,max,['ELT,stateVar,0]]]
;       phrase1:= [['AND, ['LET, max, ['ELT, stateVar, 0]],
;                       [">=", sharpArg, max]], [auxfn,:argl,stateVar]]
;       phrase2:= [[">", sharpArg, ['SETQ, max, ["-", max, k]]],
;                   ['ELT, stateVar, ['inc_SI,
;                     ['sub_SI, k, ["-", sharpArg, max]]]]]
;       phrase3:= [[">", sharpArg, n], [auxfn, :argl, ['LIST, n, :initCode]]]
;       phrase4:= [[">", sharpArg, n - k],
;         ['ELT, ['LIST, :initCode], ['sub_SI, n, sharpArg]]]
;       phrase5:= ['(QUOTE T),['recurrenceError,MKQ op,sharpArg]]
;       ['PROGN,:preset,['COND,phrase1,phrase2,phrase3,phrase4,phrase5]]
;   sayKeyedMsg("S2IX0001",[op])
;   compileInteractive computeFunction
;   compileInteractive mainFunction
;   cacheType:= 'recurrence
;   cacheCountCode:= ['nodeCount,stateNam]
;   cacheVector:= mkCacheVec(op,stateNam,cacheType,cacheResetCode,cacheCountCode)
;   $e:= put(nam,'cacheInfo, cacheVector,$e)
;   nam

(DEFUN |compileRecurrenceRelation| (|op| |nam| |argl| |junk| |bfVar#17|)
  (PROG (|body| |sharpArg| |n| |initCode| |k| |extraArguments| |x|
         |extraArgumentCode| |g| |gIndex| |gsList| |auxfn| |stateNam|
         |stateVar| |stateVal| |lastArg| |decomposeCode| |gsRev| |rotateCode|
         |advanceCode| |newTripleCode| |newStateCode| |cargl| |returnValue|
         |endTest| |newValueCode| |cbody| |computeFunction| |margl| |max|
         |tripleCode| |initialValueCode| |cacheResetCode| |initialSetCode|
         |initialResetCode| |preset| |phrase1| |phrase2| |phrase3| |phrase4|
         |phrase5| |mbody| |mainFunction| |cacheType| |cacheCountCode|
         |cacheVector|)
    (RETURN
     (PROGN
      (SETQ |body| (CAR |bfVar#17|))
      (SETQ |sharpArg| (CADR . #1=(|bfVar#17|)))
      (SETQ |n| (CADDR . #1#))
      (SETQ |initCode| (CDDDR . #1#))
      (SETQ |k| (LENGTH |initCode|))
      (SETQ |extraArgumentCode|
              (COND
               ((SETQ |extraArguments|
                        ((LAMBDA (|bfVar#9| |bfVar#8| |x|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#8|)
                                  (PROGN (SETQ |x| (CAR |bfVar#8|)) NIL))
                              (RETURN (NREVERSE |bfVar#9|)))
                             (#2='T
                              (AND (NOT (EQUAL |x| |sharpArg|))
                                   (SETQ |bfVar#9| (CONS |x| |bfVar#9|)))))
                            (SETQ |bfVar#8| (CDR |bfVar#8|))))
                         NIL |argl| NIL))
                (COND
                 ((AND (CONSP |extraArguments|) (EQ (CDR |extraArguments|) NIL)
                       (PROGN (SETQ |x| (CAR |extraArguments|)) #2#))
                  |x|)
                 (#2# (CONS 'LIST |extraArguments|))))
               (#2# NIL)))
      (SETQ |g| (GENSYM))
      (SETQ |gIndex| (GENSYM))
      (SETQ |gsList|
              ((LAMBDA (|bfVar#11| |bfVar#10| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#10|)
                        (PROGN (SETQ |x| (CAR |bfVar#10|)) NIL))
                    (RETURN (NREVERSE |bfVar#11|)))
                   (#2# (SETQ |bfVar#11| (CONS (GENSYM) |bfVar#11|))))
                  (SETQ |bfVar#10| (CDR |bfVar#10|))))
               NIL |initCode| NIL))
      (SETQ |auxfn| (|mkAuxiliaryName| |nam|))
      (SETQ |$compiledOpNameList|
              (APPEND |$compiledOpNameList| (CONS |auxfn| NIL)))
      (SETQ |stateNam| (GENVAR))
      (SETQ |stateVar| (GENSYM))
      (SETQ |stateVal| (GENSYM))
      (SETQ |lastArg| (INTERNL1 "#" (STRINGIMAGE (|inc_SI| (LENGTH |argl|)))))
      (SETQ |decomposeCode|
              (CONS (LIST 'LET |gIndex| (LIST 'ELT |lastArg| 0))
                    ((LAMBDA (|bfVar#13| |bfVar#12| |g| |i|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#12|)
                              (PROGN (SETQ |g| (CAR |bfVar#12|)) NIL))
                          (RETURN (NREVERSE |bfVar#13|)))
                         (#2#
                          (SETQ |bfVar#13|
                                  (CONS
                                   (LIST 'LET |g| (LIST 'ELT |lastArg| |i|))
                                   |bfVar#13|))))
                        (SETQ |bfVar#12| (CDR |bfVar#12|))
                        (SETQ |i| (+ |i| 1))))
                     NIL |gsList| NIL 1)))
      (SETQ |gsRev| (REVERSE |gsList|))
      (SETQ |rotateCode|
              ((LAMBDA (|bfVar#16| |bfVar#14| |p| |bfVar#15| |q|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#14|)
                        (PROGN (SETQ |p| (CAR |bfVar#14|)) NIL)
                        (ATOM |bfVar#15|)
                        (PROGN (SETQ |q| (CAR |bfVar#15|)) NIL))
                    (RETURN (NREVERSE |bfVar#16|)))
                   (#2#
                    (SETQ |bfVar#16| (CONS (LIST 'LET |p| |q|) |bfVar#16|))))
                  (SETQ |bfVar#14| (CDR |bfVar#14|))
                  (SETQ |bfVar#15| (CDR |bfVar#15|))))
               NIL |gsRev| NIL (APPEND (CDR |gsRev|) (CONS |g| NIL)) NIL))
      (SETQ |advanceCode| (LIST 'LET |gIndex| (LIST 'ADD1 |gIndex|)))
      (SETQ |newTripleCode| (CONS 'LIST (CONS |sharpArg| |gsList|)))
      (SETQ |newStateCode|
              (COND
               ((NULL |extraArguments|)
                (LIST 'SETQ |stateNam| |newTripleCode|))
               (#2#
                (LIST 'HPUT |stateNam| |extraArgumentCode| |newTripleCode|))))
      (SETQ |cargl| (APPEND |argl| (CONS |lastArg| NIL)))
      (SETQ |returnValue| (LIST 'PROGN |newStateCode| (CAR |gsList|)))
      (SETQ |cbody|
              (PROGN
               (SETQ |endTest|
                       (LIST 'COND
                             (LIST (LIST 'EQL |sharpArg| |gIndex|)
                                   (LIST 'RETURN |returnValue|))))
               (SETQ |newValueCode|
                       (LIST 'LET |g|
                             (|substitute| |gIndex| |sharpArg|
                              (EQSUBSTLIST |gsList|
                               (CDR |$TriangleVariableList|) |body|))))
               (CONS 'PROGN
                     (APPEND |decomposeCode|
                             (CONS
                              (LIST 'REPEAT (LIST 'WHILE 'T)
                                    (CONS 'PROGN
                                          (CONS |endTest|
                                                (CONS |advanceCode|
                                                      (CONS |newValueCode|
                                                            |rotateCode|)))))
                              NIL)))))
      (SETQ |computeFunction| (LIST |auxfn| (LIST 'LAMBDA |cargl| |cbody|)))
      (SETQ |margl| (APPEND |argl| (CONS '|envArg| NIL)))
      (SETQ |max| (GENSYM))
      (SETQ |tripleCode| (LIST 'CONS |n| (CONS 'LIST |initCode|)))
      (SETQ |initialSetCode|
              (PROGN
               (SETQ |initialValueCode|
                       (COND (|extraArguments| (LIST 'MAKE_HASHTABLE ''UEQUAL))
                             (#2# |tripleCode|)))
               (SETQ |cacheResetCode|
                       (LIST 'SETQ |stateNam| |initialValueCode|))
               (LIST 'COND
                     (LIST
                      (LIST 'NULL
                            (LIST 'AND (LIST 'BOUNDP (MKQ |stateNam|))
                                  (LIST 'PAIRP |stateNam|)))
                      (LIST 'LET |stateVar| |cacheResetCode|))
                     (LIST ''T (LIST 'LET |stateVar| |stateNam|)))))
      (SETQ |initialResetCode|
              (COND ((NULL |extraArguments|) NIL)
                    (#2#
                     (LIST
                      (LIST 'LET |stateVar|
                            (LIST 'OR
                                  (LIST 'HGET |stateVar| |extraArgumentCode|)
                                  (LIST 'HPUT |stateVar| |extraArgumentCode|
                                        |tripleCode|)))))))
      (SETQ |mbody|
              (PROGN
               (SETQ |preset|
                       (CONS |initialSetCode|
                             (APPEND |initialResetCode|
                                     (CONS
                                      (LIST 'LET |max|
                                            (LIST 'ELT |stateVar| 0))
                                      NIL))))
               (SETQ |phrase1|
                       (LIST
                        (LIST 'AND (LIST 'LET |max| (LIST 'ELT |stateVar| 0))
                              (LIST '>= |sharpArg| |max|))
                        (CONS |auxfn| (APPEND |argl| (CONS |stateVar| NIL)))))
               (SETQ |phrase2|
                       (LIST
                        (LIST '> |sharpArg|
                              (LIST 'SETQ |max| (LIST '- |max| |k|)))
                        (LIST 'ELT |stateVar|
                              (LIST '|inc_SI|
                                    (LIST '|sub_SI| |k|
                                          (LIST '- |sharpArg| |max|))))))
               (SETQ |phrase3|
                       (LIST (LIST '> |sharpArg| |n|)
                             (CONS |auxfn|
                                   (APPEND |argl|
                                           (CONS
                                            (CONS 'LIST (CONS |n| |initCode|))
                                            NIL)))))
               (SETQ |phrase4|
                       (LIST (LIST '> |sharpArg| (- |n| |k|))
                             (LIST 'ELT (CONS 'LIST |initCode|)
                                   (LIST '|sub_SI| |n| |sharpArg|))))
               (SETQ |phrase5|
                       (LIST ''T
                             (LIST '|recurrenceError| (MKQ |op|) |sharpArg|)))
               (CONS 'PROGN
                     (APPEND |preset|
                             (CONS
                              (LIST 'COND |phrase1| |phrase2| |phrase3|
                                    |phrase4| |phrase5|)
                              NIL)))))
      (SETQ |mainFunction| (LIST |nam| (LIST 'LAMBDA |margl| |mbody|)))
      (|sayKeyedMsg| 'S2IX0001 (LIST |op|))
      (|compileInteractive| |computeFunction|)
      (|compileInteractive| |mainFunction|)
      (SETQ |cacheType| '|recurrence|)
      (SETQ |cacheCountCode| (LIST '|nodeCount| |stateNam|))
      (SETQ |cacheVector|
              (|mkCacheVec| |op| |stateNam| |cacheType| |cacheResetCode|
               |cacheCountCode|))
      (SETQ |$e| (|put| |nam| '|cacheInfo| |cacheVector| |$e|))
      |nam|))))

; NUMOFNODES(x) ==
;     ATOM(x) => 0
;     NUMOFNODES(first(x)) + NUMOFNODES(rest(x)) + 1

(DEFUN NUMOFNODES (|x|)
  (PROG ()
    (RETURN
     (COND ((ATOM |x|) 0)
           ('T (+ (+ (NUMOFNODES (CAR |x|)) (NUMOFNODES (CDR |x|))) 1))))))

; nodeCount x == NUMOFNODES x

(DEFUN |nodeCount| (|x|) (PROG () (RETURN (NUMOFNODES |x|))))

; recurrenceError(op,arg) == throwKeyedMsg("S2IX0002",[op,arg])

(DEFUN |recurrenceError| (|op| |arg|)
  (PROG () (RETURN (|throwKeyedMsg| 'S2IX0002 (LIST |op| |arg|)))))

; mkCacheVec(op,nam,kind,resetCode,countCode) ==
;   [op,nam,kind,resetCode,countCode]

(DEFUN |mkCacheVec| (|op| |nam| |kind| |resetCode| |countCode|)
  (PROG () (RETURN (LIST |op| |nam| |kind| |resetCode| |countCode|))))

; clearCache x ==
;   get(x,'localModemap,$e) or get(x,'mapBody,$e) =>
;     for [map,:sub] in $mapSubNameAlist repeat
;       map=x => untrace2(sub,[])
;     $e:= putHist(x,'localModemap,nil,$e)
;     $e:= putHist(x,'mapBody,nil,$e)
;     $e:= putHist(x,'localVars,nil,$e)
;     sayKeyedMsg("S2IX0007",[x])

(DEFUN |clearCache| (|x|)
  (PROG (|map| |sub|)
    (RETURN
     (COND
      ((OR (|get| |x| '|localModemap| |$e|) (|get| |x| '|mapBody| |$e|))
       (IDENTITY
        (PROGN
         ((LAMBDA (|bfVar#19| |bfVar#18|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#19|)
                   (PROGN (SETQ |bfVar#18| (CAR |bfVar#19|)) NIL))
               (RETURN NIL))
              (#1='T
               (AND (CONSP |bfVar#18|)
                    (PROGN
                     (SETQ |map| (CAR |bfVar#18|))
                     (SETQ |sub| (CDR |bfVar#18|))
                     #1#)
                    (COND
                     ((EQUAL |map| |x|) (IDENTITY (|untrace2| |sub| NIL)))))))
             (SETQ |bfVar#19| (CDR |bfVar#19|))))
          |$mapSubNameAlist| NIL)
         (SETQ |$e| (|putHist| |x| '|localModemap| NIL |$e|))
         (SETQ |$e| (|putHist| |x| '|mapBody| NIL |$e|))
         (SETQ |$e| (|putHist| |x| '|localVars| NIL |$e|))
         (|sayKeyedMsg| 'S2IX0007 (LIST |x|)))))))))

; compileInteractive fn ==
;   if $InteractiveMode then startTimingProcess 'compilation
;   if $reportCompilation then
;     sayBrightlyI bright '"Generated LISP code for function:"
;     pp fn
;   optfn :=
;      $InteractiveMode => timedOptimization fn
;      fn
;   result := compQuietly optfn
;   if $InteractiveMode then stopTimingProcess 'compilation
;   result

(DEFUN |compileInteractive| (|fn|)
  (PROG (|optfn| |result|)
    (RETURN
     (PROGN
      (COND (|$InteractiveMode| (|startTimingProcess| '|compilation|)))
      (COND
       (|$reportCompilation|
        (|sayBrightlyI| (|bright| "Generated LISP code for function:"))
        (|pp| |fn|)))
      (SETQ |optfn|
              (COND (|$InteractiveMode| (|timedOptimization| |fn|)) ('T |fn|)))
      (SETQ |result| (|compQuietly| |optfn|))
      (COND (|$InteractiveMode| (|stopTimingProcess| '|compilation|)))
      |result|))))

; clearAllSlams x ==
;   fn(x,nil) where
;     fn(thoseToClear,thoseCleared) ==
;       for x in thoseToClear | not MEMQ(x,thoseCleared) repeat
;         slamListName:= mkCacheName x
;         SET(slamListName,nil)
;         thoseCleared:= ADJOIN(x,thoseCleared)
;         someMoreToClear:=
;           setDifference(LASSOC(x,$functorDependencyAlist),[:thoseToClear,:
;             thoseCleared])
;         NCONC(thoseToClear,someMoreToClear)

(DEFUN |clearAllSlams| (|x|) (PROG () (RETURN (|clearAllSlams,fn| |x| NIL))))
(DEFUN |clearAllSlams,fn| (|thoseToClear| |thoseCleared|)
  (PROG (|slamListName| |someMoreToClear|)
    (RETURN
     ((LAMBDA (|bfVar#20| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#20|) (PROGN (SETQ |x| (CAR |bfVar#20|)) NIL))
           (RETURN NIL))
          ('T
           (AND (NULL (MEMQ |x| |thoseCleared|))
                (PROGN
                 (SETQ |slamListName| (|mkCacheName| |x|))
                 (SET |slamListName| NIL)
                 (SETQ |thoseCleared| (ADJOIN |x| |thoseCleared|))
                 (SETQ |someMoreToClear|
                         (SETDIFFERENCE (LASSOC |x| |$functorDependencyAlist|)
                                        (APPEND |thoseToClear|
                                                |thoseCleared|)))
                 (NCONC |thoseToClear| |someMoreToClear|)))))
         (SETQ |bfVar#20| (CDR |bfVar#20|))))
      |thoseToClear| NIL))))

; clearSlam(functor)==
;   id:= mkCacheName functor
;   SET(id,nil)

(DEFUN |clearSlam| (|functor|)
  (PROG (|id|)
    (RETURN (PROGN (SETQ |id| (|mkCacheName| |functor|)) (SET |id| NIL)))))

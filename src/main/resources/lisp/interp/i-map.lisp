
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($mapTarget, nil)

(DEFPARAMETER |$mapTarget| NIL)

; DEFPARAMETER($mapReturnTypes, nil)

(DEFPARAMETER |$mapReturnTypes| NIL)

; DEFPARAMETER($mapName, 'noMapName)

(DEFPARAMETER |$mapName| '|noMapName|)

; DEFPARAMETER($mapThrowCount, 0) -- times a "return" occurs in map

(DEFPARAMETER |$mapThrowCount| 0)

; DEFPARAMETER($compilingMap, NIL)

(DEFPARAMETER |$compilingMap| NIL)

; DEFPARAMETER($definingMap, NIL)

(DEFPARAMETER |$definingMap| NIL)

; makeInternalMapName(userName,numArgs,numMms,extraPart) ==
;   name := CONCAT('"*",STRINGIMAGE numArgs,'";",
;     object2String userName,'";",STRINGIMAGE numMms,'";",
;       object2String frameName first $interpreterFrameRing )
;   if extraPart then name := CONCAT(name,'";",extraPart)
;   INTERN name

(DEFUN |makeInternalMapName| (|userName| |numArgs| |numMms| |extraPart|)
  (PROG (|name|)
    (RETURN
     (PROGN
      (SETQ |name|
              (CONCAT "*" (STRINGIMAGE |numArgs|) ";"
                      (|object2String| |userName|) ";" (STRINGIMAGE |numMms|)
                      ";"
                      (|object2String|
                       (|frameName| (CAR |$interpreterFrameRing|)))))
      (COND (|extraPart| (SETQ |name| (CONCAT |name| ";" |extraPart|))))
      (INTERN |name|)))))

; isInternalMapName name ==
;   -- this only returns true or false as a "best guess"
;   (not IDENTP(name)) or (name = "*") or (name = "**") => false
;   sz := SIZE (name' := PNAME name)
;   (sz < 7) or (char("*") ~= name'.0) => false
;   null DIGITP name'.1 => false
;   null STRPOS('"_;",name',1,NIL) => false
;   -- good enough
;   true

(DEFUN |isInternalMapName| (|name|)
  (PROG (|name'| |sz|)
    (RETURN
     (COND ((OR (NULL (IDENTP |name|)) (EQ |name| '*) (EQ |name| '**)) NIL)
           (#1='T
            (PROGN
             (SETQ |sz| (SIZE (SETQ |name'| (PNAME |name|))))
             (COND
              ((OR (< |sz| 7) (NOT (EQUAL (|char| '*) (ELT |name'| 0)))) NIL)
              ((NULL (DIGITP (ELT |name'| 1))) NIL)
              ((NULL (STRPOS ";" |name'| 1 NIL)) NIL) (#1# T))))))))

; makeInternalMapMinivectorName(name) ==
;   STRINGP name =>
;     INTERN STRCONC(name,'";MV")
;   INTERN STRCONC(PNAME name,'";MV")

(DEFUN |makeInternalMapMinivectorName| (|name|)
  (PROG ()
    (RETURN
     (COND ((STRINGP |name|) (INTERN (STRCONC |name| ";MV")))
           ('T (INTERN (STRCONC (PNAME |name|) ";MV")))))))

; mkCacheName(name) == INTERNL1(STRINGIMAGE(name), '";AL")

(DEFUN |mkCacheName| (|name|)
  (PROG () (RETURN (INTERNL1 (STRINGIMAGE |name|) ";AL"))))

; mkAuxiliaryName(name) == INTERNL1(STRINGIMAGE(name), '";AUX")

(DEFUN |mkAuxiliaryName| (|name|)
  (PROG () (RETURN (INTERNL1 (STRINGIMAGE |name|) ";AUX"))))

; isMapExpr x == x is ['SPADMAP, :.]

(DEFUN |isMapExpr| (|x|)
  (PROG () (RETURN (AND (CONSP |x|) (EQ (CAR |x|) 'SPADMAP)))))

; isMap x ==
;   y := get(x,'value,$InteractiveFrame) =>
;     objVal y is ['SPADMAP, :.] => x

(DEFUN |isMap| (|x|)
  (PROG (|y| |ISTMP#1|)
    (RETURN
     (COND
      ((SETQ |y| (|get| |x| '|value| |$InteractiveFrame|))
       (IDENTITY
        (COND
         ((PROGN
           (SETQ |ISTMP#1| (|objVal| |y|))
           (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADMAP)))
          (IDENTITY |x|)))))))))

; addDefMap(['DEF,lhs,mapsig,.,rhs],pred) ==
;   -- Create a new map, add to an existing one, or define a variable
;   --   compute the dependencies for a map
;
;   -- next check is for bad forms on the lhs of the ==, such as
;   -- numbers, constants.
;   if not PAIRP lhs then
;     op := lhs
;     putHist(op,'isInterpreterRule,true,$e)
;     putHist(op,'isInterpreterFunction,false,$e)
;     lhs := [lhs]
;   else
;     -- this is a function definition. If it has been declared
;     -- previously, make sure it is Mapping.
;     op := first lhs
;     (oldMode := get(op,'mode,$e)) and oldMode isnt ['Mapping,:.] =>
;       throwKeyedMsg("S2IM0001",[op,oldMode])
;     putHist(op,'isInterpreterRule,false,$e)
;     putHist(op,'isInterpreterFunction,true,$e)
;
;   (NUMBERP(op) or op in '(true false nil % %%)) =>
;     throwKeyedMsg("S2IM0002",[lhs])
;
;   -- verify a constructor abbreviation is not used on the lhs
;   op ~= (op' := unabbrev op) => throwKeyedMsg("S2IM0003",[op,op'])
;
;   -- get the formal parameters. These should only be atomic symbols
;   -- that are not numbers.
;   parameters := [p for p in rest lhs | IDENTP(p)]
;
;   -- see if a signature has been given. if anything in mapsig is NIL,
;   -- then declaration was omitted.
;   someDecs := nil
;   allDecs := true
;   mapmode := ['Mapping]
;   $env:local := [[NIL]]
;   $genValue:local := true       --evaluate all generated code
;   for d in mapsig repeat
;     if d then
;       someDecs := true
;       d' := evaluateType unabbrev d
;       isPartialMode d' => throwKeyedMsg("S2IM0004",NIL)
; --      tree := mkAtree d'
; --      null (d' := isType tree) => throwKeyedMsg("S2IM0005",[d])
;       mapmode := [d',:mapmode]
;     else allDecs := false
;   if allDecs then
;     mapmode := nreverse mapmode
;     putHist(op,'mode,mapmode,$e)
;     sayKeyedMsg("S2IM0006",[formatOpSignature(op,rest mapmode)])
;   else if someDecs then throwKeyedMsg("S2IM0007",[op])
;
;   -- if map is declared, check that signature arg count is the
;   -- same as what is given.
;   if get(op,'mode,$e) is ['Mapping,.,:mapargs] then
;     EQCAR(rhs,'rules) =>
;       0 ~= (numargs := # rest lhs) =>
;         throwKeyedMsg("S2IM0027",[numargs,op])
;     # rest lhs ~= # mapargs => throwKeyedMsg("S2IM0008",[op])
;   --get all the user variables in the map definition.  This is a multi
;   --step process as this should not include recursive calls to the map
;   --itself, or the formal parameters
;   userVariables1 := getUserIdentifiersIn rhs
;   $freeVars: local := NIL
;   $localVars: local := NIL
;   for parm in parameters repeat mkLocalVar($mapName,parm)
;   userVariables2 := setDifference(userVariables1,findLocalVars(op,rhs))
;   userVariables3 := setDifference(userVariables2, parameters)
;   userVariables4 := REMDUP setDifference (userVariables3, [op])
;
;   --figure out the new dependencies for the new map (what it depends on)
;   newDependencies := makeNewDependencies (op, userVariables4)
;   putDependencies (op, newDependencies)
;   clearDependencies(op)
;   addMap(lhs,rhs,pred)

(DEFUN |addDefMap| (|bfVar#5| |pred|)
  (PROG (|$localVars| |$freeVars| |$genValue| |$env| |newDependencies|
         |userVariables4| |userVariables3| |userVariables2| |userVariables1|
         |numargs| |mapargs| |ISTMP#2| |ISTMP#1| |d'| |mapmode| |allDecs|
         |someDecs| |parameters| |op'| |oldMode| |op| |rhs| |mapsig| |lhs|)
    (DECLARE (SPECIAL |$localVars| |$freeVars| |$genValue| |$env|))
    (RETURN
     (PROGN
      (SETQ |lhs| (CADR . #1=(|bfVar#5|)))
      (SETQ |mapsig| (CADDR . #1#))
      (SETQ |rhs| (CAR (CDDDDR . #1#)))
      (COND
       ((NULL (CONSP |lhs|)) (SETQ |op| |lhs|)
        (|putHist| |op| '|isInterpreterRule| T |$e|)
        (|putHist| |op| '|isInterpreterFunction| NIL |$e|)
        (SETQ |lhs| (LIST |lhs|)))
       (#2='T (SETQ |op| (CAR |lhs|))
        (COND
         ((AND (SETQ |oldMode| (|get| |op| '|mode| |$e|))
               (NOT (AND (CONSP |oldMode|) (EQ (CAR |oldMode|) '|Mapping|))))
          (|throwKeyedMsg| 'S2IM0001 (LIST |op| |oldMode|)))
         (#2#
          (PROGN
           (|putHist| |op| '|isInterpreterRule| NIL |$e|)
           (|putHist| |op| '|isInterpreterFunction| T |$e|))))))
      (COND
       ((OR (NUMBERP |op|) (|member| |op| '(|true| |false| |nil| % %%)))
        (|throwKeyedMsg| 'S2IM0002 (LIST |lhs|)))
       ((NOT (EQUAL |op| (SETQ |op'| (|unabbrev| |op|))))
        (|throwKeyedMsg| 'S2IM0003 (LIST |op| |op'|)))
       (#2#
        (PROGN
         (SETQ |parameters|
                 ((LAMBDA (|bfVar#2| |bfVar#1| |p|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#1|)
                           (PROGN (SETQ |p| (CAR |bfVar#1|)) NIL))
                       (RETURN (NREVERSE |bfVar#2|)))
                      (#2#
                       (AND (IDENTP |p|)
                            (SETQ |bfVar#2| (CONS |p| |bfVar#2|)))))
                     (SETQ |bfVar#1| (CDR |bfVar#1|))))
                  NIL (CDR |lhs|) NIL))
         (SETQ |someDecs| NIL)
         (SETQ |allDecs| T)
         (SETQ |mapmode| (LIST '|Mapping|))
         (SETQ |$env| (LIST (LIST NIL)))
         (SETQ |$genValue| T)
         ((LAMBDA (|bfVar#3| |d|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#3|) (PROGN (SETQ |d| (CAR |bfVar#3|)) NIL))
               (RETURN NIL))
              (#2#
               (COND
                (|d| (SETQ |someDecs| T)
                 (SETQ |d'| (|evaluateType| (|unabbrev| |d|)))
                 (COND ((|isPartialMode| |d'|) (|throwKeyedMsg| 'S2IM0004 NIL))
                       (#2# (SETQ |mapmode| (CONS |d'| |mapmode|)))))
                (#2# (SETQ |allDecs| NIL)))))
             (SETQ |bfVar#3| (CDR |bfVar#3|))))
          |mapsig| NIL)
         (COND
          (|allDecs| (SETQ |mapmode| (NREVERSE |mapmode|))
           (|putHist| |op| '|mode| |mapmode| |$e|)
           (|sayKeyedMsg| 'S2IM0006
            (LIST (|formatOpSignature| |op| (CDR |mapmode|)))))
          (|someDecs| (|throwKeyedMsg| 'S2IM0007 (LIST |op|))))
         (COND
          ((PROGN
            (SETQ |ISTMP#1| (|get| |op| '|mode| |$e|))
            (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
                 (PROGN
                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                  (AND (CONSP |ISTMP#2|)
                       (PROGN (SETQ |mapargs| (CDR |ISTMP#2|)) #2#)))))
           (COND
            ((EQCAR |rhs| '|rules|)
             (COND
              ((NOT (EQL 0 (SETQ |numargs| (LENGTH (CDR |lhs|)))))
               (IDENTITY (|throwKeyedMsg| 'S2IM0027 (LIST |numargs| |op|))))))
            ((NOT (EQL (LENGTH (CDR |lhs|)) (LENGTH |mapargs|)))
             (|throwKeyedMsg| 'S2IM0008 (LIST |op|))))))
         (SETQ |userVariables1| (|getUserIdentifiersIn| |rhs|))
         (SETQ |$freeVars| NIL)
         (SETQ |$localVars| NIL)
         ((LAMBDA (|bfVar#4| |parm|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#4|) (PROGN (SETQ |parm| (CAR |bfVar#4|)) NIL))
               (RETURN NIL))
              (#2# (|mkLocalVar| |$mapName| |parm|)))
             (SETQ |bfVar#4| (CDR |bfVar#4|))))
          |parameters| NIL)
         (SETQ |userVariables2|
                 (SETDIFFERENCE |userVariables1| (|findLocalVars| |op| |rhs|)))
         (SETQ |userVariables3| (SETDIFFERENCE |userVariables2| |parameters|))
         (SETQ |userVariables4|
                 (REMDUP (SETDIFFERENCE |userVariables3| (LIST |op|))))
         (SETQ |newDependencies| (|makeNewDependencies| |op| |userVariables4|))
         (|putDependencies| |op| |newDependencies|)
         (|clearDependencies| |op|)
         (|addMap| |lhs| |rhs| |pred|))))))))

; addMap(lhs,rhs,pred) ==
;   [op,:argl] := lhs
;   $sl: local:= nil
;   formalArgList:= [mkFormalArg(makeArgumentIntoNumber x,s)
;     for x in argl for s in $FormalMapVariableList]
;   argList:=
;     [fn for x in formalArgList] where
;       fn ==
;         if x is ["SUCHTHAT",s,p] then (predList:= [p,:predList]; x:= s)
;         x
;   mkMapAlias(op,argl)
;   argPredList:= NREVERSE predList
;   finalPred :=
; -- handle g(a,T)==a+T confusion between pred=T and T variable
;       MKPF((pred and (pred ~= 'T) =>
;             [:argPredList, sublisNQ($sl, pred)]; argPredList), "and")
;   body := sublisNQ($sl, rhs)
;   oldMap :=
;     (obj := get(op,'value,$InteractiveFrame)) => objVal obj
;     NIL
;   newMap := augmentMap(op,argList,finalPred,body,oldMap)
;   null newMap =>
;     sayRemoveFunctionOrValue op
;     putHist(op,'alias,nil,$e)
;     ""      -- clears value--- see return from addDefMap in tree2Atree1
;   if get(op,'isInterpreterRule,$e) then type := ['RuleCalled,op]
;   else type := ['FunctionCalled,op]
;   recursive :=
;     depthOfRecursion(op,newMap) = 0 => false
;     true
;   putHist(op,'recursive,recursive,$e)
;   objNew(newMap,type)

(DEFUN |addMap| (|lhs| |rhs| |pred|)
  (PROG (|$sl| |recursive| |type| |newMap| |oldMap| |obj| |body| |finalPred|
         |argPredList| |argList| |predList| |p| |ISTMP#2| |s| |ISTMP#1|
         |formalArgList| |argl| |op|)
    (DECLARE (SPECIAL |$sl|))
    (RETURN
     (PROGN
      (SETQ |op| (CAR |lhs|))
      (SETQ |argl| (CDR |lhs|))
      (SETQ |$sl| NIL)
      (SETQ |formalArgList|
              ((LAMBDA (|bfVar#8| |bfVar#6| |x| |bfVar#7| |s|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#6|) (PROGN (SETQ |x| (CAR |bfVar#6|)) NIL)
                        (ATOM |bfVar#7|)
                        (PROGN (SETQ |s| (CAR |bfVar#7|)) NIL))
                    (RETURN (NREVERSE |bfVar#8|)))
                   (#1='T
                    (SETQ |bfVar#8|
                            (CONS
                             (|mkFormalArg| (|makeArgumentIntoNumber| |x|) |s|)
                             |bfVar#8|))))
                  (SETQ |bfVar#6| (CDR |bfVar#6|))
                  (SETQ |bfVar#7| (CDR |bfVar#7|))))
               NIL |argl| NIL |$FormalMapVariableList| NIL))
      (SETQ |argList|
              ((LAMBDA (|bfVar#10| |bfVar#9| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#9|)
                        (PROGN (SETQ |x| (CAR |bfVar#9|)) NIL))
                    (RETURN (NREVERSE |bfVar#10|)))
                   (#1#
                    (SETQ |bfVar#10|
                            (CONS
                             (PROGN
                              (COND
                               ((AND (CONSP |x|) (EQ (CAR |x|) 'SUCHTHAT)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |x|))
                                      (AND (CONSP |ISTMP#1|)
                                           (PROGN
                                            (SETQ |s| (CAR |ISTMP#1|))
                                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                            (AND (CONSP |ISTMP#2|)
                                                 (EQ (CDR |ISTMP#2|) NIL)
                                                 (PROGN
                                                  (SETQ |p| (CAR |ISTMP#2|))
                                                  #1#))))))
                                (SETQ |predList| (CONS |p| |predList|))
                                (SETQ |x| |s|)))
                              |x|)
                             |bfVar#10|))))
                  (SETQ |bfVar#9| (CDR |bfVar#9|))))
               NIL |formalArgList| NIL))
      (|mkMapAlias| |op| |argl|)
      (SETQ |argPredList| (NREVERSE |predList|))
      (SETQ |finalPred|
              (MKPF
               (COND
                ((AND |pred| (NOT (EQ |pred| 'T)))
                 (APPEND |argPredList| (CONS (|sublisNQ| |$sl| |pred|) NIL)))
                (#1# |argPredList|))
               '|and|))
      (SETQ |body| (|sublisNQ| |$sl| |rhs|))
      (SETQ |oldMap|
              (COND
               ((SETQ |obj| (|get| |op| '|value| |$InteractiveFrame|))
                (|objVal| |obj|))
               (#1# NIL)))
      (SETQ |newMap| (|augmentMap| |op| |argList| |finalPred| |body| |oldMap|))
      (COND
       ((NULL |newMap|)
        (PROGN
         (|sayRemoveFunctionOrValue| |op|)
         (|putHist| |op| '|alias| NIL |$e|)
         '||))
       (#1#
        (PROGN
         (COND
          ((|get| |op| '|isInterpreterRule| |$e|)
           (SETQ |type| (LIST '|RuleCalled| |op|)))
          (#1# (SETQ |type| (LIST '|FunctionCalled| |op|))))
         (SETQ |recursive|
                 (COND ((EQL (|depthOfRecursion| |op| |newMap|) 0) NIL)
                       (#1# T)))
         (|putHist| |op| '|recursive| |recursive| |$e|)
         (|objNew| |newMap| |type|))))))))

; augmentMap(op,args,pred,body,oldMap) ==
;   pattern:= makePattern(args,pred)
;   newMap:=deleteMap(op,pattern,oldMap)
;   body="" =>
;     if newMap=oldMap then
;       sayMSG ['"   Cannot find part of",:bright op,'"to delete."]
;     newMap  --just delete rule if body is 
;   entry:= [pattern,:body]
;   resultMap:=
;     newMap is ["SPADMAP", :tail] => ["SPADMAP", :tail, entry]
;     ["SPADMAP", entry]
;   resultMap

(DEFUN |augmentMap| (|op| |args| |pred| |body| |oldMap|)
  (PROG (|pattern| |newMap| |entry| |tail| |resultMap|)
    (RETURN
     (PROGN
      (SETQ |pattern| (|makePattern| |args| |pred|))
      (SETQ |newMap| (|deleteMap| |op| |pattern| |oldMap|))
      (COND
       ((EQ |body| '||)
        (PROGN
         (COND
          ((EQUAL |newMap| |oldMap|)
           (|sayMSG|
            (CONS "   Cannot find part of"
                  (APPEND (|bright| |op|) (CONS "to delete." NIL))))))
         |newMap|))
       (#1='T
        (PROGN
         (SETQ |entry| (CONS |pattern| |body|))
         (SETQ |resultMap|
                 (COND
                  ((AND (CONSP |newMap|) (EQ (CAR |newMap|) 'SPADMAP)
                        (PROGN (SETQ |tail| (CDR |newMap|)) #1#))
                   (CONS 'SPADMAP (APPEND |tail| (CONS |entry| NIL))))
                  (#1# (LIST 'SPADMAP |entry|))))
         |resultMap|)))))))

; deleteMap(op,pattern,map) ==
;   map is ["SPADMAP", :tail] =>
;     newMap := ['SPADMAP, :[x for x in tail | w]] where w ==
;       x is [=pattern,:replacement] => sayDroppingFunctions(op,[x])
;       true
;     null rest newMap => nil
;     newMap
;   NIL

(DEFUN |deleteMap| (|op| |pattern| |map|)
  (PROG (|tail| |replacement| |newMap|)
    (RETURN
     (COND
      ((AND (CONSP |map|) (EQ (CAR |map|) 'SPADMAP)
            (PROGN (SETQ |tail| (CDR |map|)) #1='T))
       (PROGN
        (SETQ |newMap|
                (CONS 'SPADMAP
                      ((LAMBDA (|bfVar#12| |bfVar#11| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#11|)
                                (PROGN (SETQ |x| (CAR |bfVar#11|)) NIL))
                            (RETURN (NREVERSE |bfVar#12|)))
                           (#1#
                            (AND
                             (COND
                              ((AND (CONSP |x|) (EQUAL (CAR |x|) |pattern|)
                                    (PROGN (SETQ |replacement| (CDR |x|)) #1#))
                               (|sayDroppingFunctions| |op| (LIST |x|)))
                              (#1# T))
                             (SETQ |bfVar#12| (CONS |x| |bfVar#12|)))))
                          (SETQ |bfVar#11| (CDR |bfVar#11|))))
                       NIL |tail| NIL)))
        (COND ((NULL (CDR |newMap|)) NIL) (#1# |newMap|))))
      (#1# NIL)))))

; getUserIdentifiersIn body ==
;   null body => nil
;   IDENTP body =>
;     isSharpVarWithNum body => nil
;     body="" => nil
;     [body]
;   body is ["WRAPPED",:.] => nil
;   (body is ["COLLECT",:itl,body1]) or (body is ['REPEAT,:itl,body1]) =>
;     userIds :=
;       set_sum(getUserIdentifiersInIterators itl, getUserIdentifiersIn body1)
;     set_difference(userIds, getIteratorIds itl)
;   body is [op,:l] =>
;     argIdList:= "append"/[getUserIdentifiersIn y for y in l]
;     bodyIdList :=
;       not (GETL(op,'Nud) or GETL(op,'Led) or GETL(op,'up))=>
;         NCONC(getUserIdentifiersIn op, argIdList)
;       argIdList
;     REMDUP bodyIdList

(DEFUN |getUserIdentifiersIn| (|body|)
  (PROG (|ISTMP#1| |ISTMP#2| |body1| |itl| |userIds| |op| |l| |argIdList|
         |bodyIdList|)
    (RETURN
     (COND ((NULL |body|) NIL)
           ((IDENTP |body|)
            (COND ((|isSharpVarWithNum| |body|) NIL) ((EQ |body| '||) NIL)
                  (#1='T (LIST |body|))))
           ((AND (CONSP |body|) (EQ (CAR |body|) 'WRAPPED)) NIL)
           ((OR
             (AND (CONSP |body|) (EQ (CAR |body|) 'COLLECT)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |body|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1#)
                        (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |body1| (CAR |ISTMP#2|))
                         (SETQ |itl| (CDR |ISTMP#2|))
                         #1#)
                        (PROGN (SETQ |itl| (NREVERSE |itl|)) #1#))))
             (AND (CONSP |body|) (EQ (CAR |body|) 'REPEAT)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |body|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1#)
                        (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |body1| (CAR |ISTMP#2|))
                         (SETQ |itl| (CDR |ISTMP#2|))
                         #1#)
                        (PROGN (SETQ |itl| (NREVERSE |itl|)) #1#)))))
            (PROGN
             (SETQ |userIds|
                     (|set_sum| (|getUserIdentifiersInIterators| |itl|)
                      (|getUserIdentifiersIn| |body1|)))
             (|set_difference| |userIds| (|getIteratorIds| |itl|))))
           ((AND (CONSP |body|)
                 (PROGN (SETQ |op| (CAR |body|)) (SETQ |l| (CDR |body|)) #1#))
            (PROGN
             (SETQ |argIdList|
                     ((LAMBDA (|bfVar#14| |bfVar#13| |y|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#13|)
                               (PROGN (SETQ |y| (CAR |bfVar#13|)) NIL))
                           (RETURN |bfVar#14|))
                          (#1#
                           (SETQ |bfVar#14|
                                   (APPEND |bfVar#14|
                                           (|getUserIdentifiersIn| |y|)))))
                         (SETQ |bfVar#13| (CDR |bfVar#13|))))
                      NIL |l| NIL))
             (SETQ |bodyIdList|
                     (COND
                      ((NULL
                        (OR (GETL |op| '|Nud|) (GETL |op| '|Led|)
                            (GETL |op| '|up|)))
                       (NCONC (|getUserIdentifiersIn| |op|) |argIdList|))
                      (#1# |argIdList|)))
             (REMDUP |bodyIdList|)))))))

; getUserIdentifiersInIterators itl ==
;   for x in itl repeat
;     x is ["STEP",i,:l] =>
;       varList:= [:"append"/[getUserIdentifiersIn y for y in l],:varList]
;     x is ["IN",.,y]   => varList:= [:getUserIdentifiersIn y,:varList]
;     x is ["ON",.,y]   => varList:= [:getUserIdentifiersIn y,:varList]
;     x is [op,a] and op in '(_| WHILE UNTIL) =>
;       varList:= [:getUserIdentifiersIn a,:varList]
;     keyedSystemError("S2GE0016",['"getUserIdentifiersInIterators",
;       '"unknown iterator construct"])
;   REMDUP varList

(DEFUN |getUserIdentifiersInIterators| (|itl|)
  (PROG (|ISTMP#1| |i| |l| |varList| |ISTMP#2| |y| |op| |a|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#15| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#15|) (PROGN (SETQ |x| (CAR |bfVar#15|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((AND (CONSP |x|) (EQ (CAR |x|) 'STEP)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |x|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |i| (CAR |ISTMP#1|))
                          (SETQ |l| (CDR |ISTMP#1|))
                          #1#))))
              (SETQ |varList|
                      (APPEND
                       ((LAMBDA (|bfVar#17| |bfVar#16| |y|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#16|)
                                 (PROGN (SETQ |y| (CAR |bfVar#16|)) NIL))
                             (RETURN |bfVar#17|))
                            (#1#
                             (SETQ |bfVar#17|
                                     (APPEND |bfVar#17|
                                             (|getUserIdentifiersIn| |y|)))))
                           (SETQ |bfVar#16| (CDR |bfVar#16|))))
                        NIL |l| NIL)
                       |varList|)))
             ((AND (CONSP |x|) (EQ (CAR |x|) 'IN)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |x|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1#))))))
              (SETQ |varList| (APPEND (|getUserIdentifiersIn| |y|) |varList|)))
             ((AND (CONSP |x|) (EQ (CAR |x|) 'ON)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |x|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1#))))))
              (SETQ |varList| (APPEND (|getUserIdentifiersIn| |y|) |varList|)))
             ((AND (CONSP |x|)
                   (PROGN
                    (SETQ |op| (CAR |x|))
                    (SETQ |ISTMP#1| (CDR |x|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#)))
                   (|member| |op| '(|\|| WHILE UNTIL)))
              (SETQ |varList| (APPEND (|getUserIdentifiersIn| |a|) |varList|)))
             (#1#
              (|keyedSystemError| 'S2GE0016
               (LIST "getUserIdentifiersInIterators"
                     "unknown iterator construct"))))))
          (SETQ |bfVar#15| (CDR |bfVar#15|))))
       |itl| NIL)
      (REMDUP |varList|)))))

; getIteratorIds itl ==
;   for x in itl repeat
;     x is ["STEP",i,:.] => varList:= [i,:varList]
;     x is ["IN",y,:.]   => varList:= [y,:varList]
;     x is ["ON",y,:.]   => varList:= [y,:varList]
;     nil
;   varList

(DEFUN |getIteratorIds| (|itl|)
  (PROG (|ISTMP#1| |i| |varList| |y|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#18| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#18|) (PROGN (SETQ |x| (CAR |bfVar#18|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((AND (CONSP |x|) (EQ (CAR |x|) 'STEP)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |x|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN (SETQ |i| (CAR |ISTMP#1|)) #1#))))
              (SETQ |varList| (CONS |i| |varList|)))
             ((AND (CONSP |x|) (EQ (CAR |x|) 'IN)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |x|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
              (SETQ |varList| (CONS |y| |varList|)))
             ((AND (CONSP |x|) (EQ (CAR |x|) 'ON)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |x|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
              (SETQ |varList| (CONS |y| |varList|)))
             (#1# NIL))))
          (SETQ |bfVar#18| (CDR |bfVar#18|))))
       |itl| NIL)
      |varList|))))

; makeArgumentIntoNumber x ==
;   x=$Zero => 0
;   x=$One => 1
;   atom x => x
;   x is ["-",n] and NUMBERP n => -n
;   [removeZeroOne first x,:removeZeroOne rest x]

(DEFUN |makeArgumentIntoNumber| (|x|)
  (PROG (|ISTMP#1| |n|)
    (RETURN
     (COND ((EQUAL |x| |$Zero|) 0) ((EQUAL |x| |$One|) 1) ((ATOM |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) '-)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |n| (CAR |ISTMP#1|)) #1='T)))
                 (NUMBERP |n|))
            (- |n|))
           (#1#
            (CONS (|removeZeroOne| (CAR |x|)) (|removeZeroOne| (CDR |x|))))))))

; mkMapAlias(op,argl) ==
;   u:= mkAliasList argl
;   newAlias :=
;     alias:= get(op,"alias",$e) => [(y => y; x) for x in alias for y in u]
;     u
;   $e:= putHist(op,"alias",newAlias,$e)

(DEFUN |mkMapAlias| (|op| |argl|)
  (PROG (|u| |alias| |newAlias|)
    (RETURN
     (PROGN
      (SETQ |u| (|mkAliasList| |argl|))
      (SETQ |newAlias|
              (COND
               ((SETQ |alias| (|get| |op| '|alias| |$e|))
                ((LAMBDA (|bfVar#21| |bfVar#19| |x| |bfVar#20| |y|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#19|)
                          (PROGN (SETQ |x| (CAR |bfVar#19|)) NIL)
                          (ATOM |bfVar#20|)
                          (PROGN (SETQ |y| (CAR |bfVar#20|)) NIL))
                      (RETURN (NREVERSE |bfVar#21|)))
                     (#1='T
                      (SETQ |bfVar#21|
                              (CONS (COND (|y| |y|) (#1# |x|)) |bfVar#21|))))
                    (SETQ |bfVar#19| (CDR |bfVar#19|))
                    (SETQ |bfVar#20| (CDR |bfVar#20|))))
                 NIL |alias| NIL |u| NIL))
               (#1# |u|)))
      (SETQ |$e| (|putHist| |op| '|alias| |newAlias| |$e|))))))

; mkAliasList l == fn(l,nil) where fn(l,acc) ==
;   null l => NREVERSE acc
;   not IDENTP first l or first l in acc => fn(rest l,[nil,:acc])
;   fn(rest l,[first l,:acc])

(DEFUN |mkAliasList| (|l|) (PROG () (RETURN (|mkAliasList,fn| |l| NIL))))
(DEFUN |mkAliasList,fn| (|l| |acc|)
  (PROG ()
    (RETURN
     (COND ((NULL |l|) (NREVERSE |acc|))
           ((OR (NULL (IDENTP (CAR |l|))) (|member| (CAR |l|) |acc|))
            (|mkAliasList,fn| (CDR |l|) (CONS NIL |acc|)))
           ('T (|mkAliasList,fn| (CDR |l|) (CONS (CAR |l|) |acc|)))))))

; args2Tuple args ==
;   args is [first,:rest] =>
;     null rest => first
;     ["Tuple",:args]
;   nil

(DEFUN |args2Tuple| (|args|)
  (PROG (CAR CDR)
    (RETURN
     (COND
      ((AND (CONSP |args|)
            (PROGN (SETQ CAR (CAR |args|)) (SETQ CDR (CDR |args|)) #1='T))
       (COND ((NULL CDR) CAR) (#1# (CONS '|Tuple| |args|))))
      (#1# NIL)))))

; makePattern(args,pred) ==
;   nargs:= #args
;   nargs = 1 =>
;     pred is ["=","#1",n] => n
;     addPatternPred("#1",pred)
;   u:= canMakeTuple(nargs,pred) => u
;   addPatternPred(["Tuple",:TAKE(nargs,$FormalMapVariableList)],pred)

(DEFUN |makePattern| (|args| |pred|)
  (PROG (|nargs| |ISTMP#1| |ISTMP#2| |n| |u|)
    (RETURN
     (PROGN
      (SETQ |nargs| (LENGTH |args|))
      (COND
       ((EQL |nargs| 1)
        (COND
         ((AND (CONSP |pred|) (EQ (CAR |pred|) '=)
               (PROGN
                (SETQ |ISTMP#1| (CDR |pred|))
                (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|#1|)
                     (PROGN
                      (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                      (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                           (PROGN (SETQ |n| (CAR |ISTMP#2|)) #1='T))))))
          |n|)
         (#1# (|addPatternPred| '|#1| |pred|))))
       ((SETQ |u| (|canMakeTuple| |nargs| |pred|)) |u|)
       (#1#
        (|addPatternPred|
         (CONS '|Tuple| (TAKE |nargs| |$FormalMapVariableList|)) |pred|)))))))

; addPatternPred(arg,pred) ==
;   pred=true => arg
;   ["|",arg,pred]

(DEFUN |addPatternPred| (|arg| |pred|)
  (PROG ()
    (RETURN (COND ((EQUAL |pred| T) |arg|) ('T (LIST '|\|| |arg| |pred|))))))

; canMakeTuple(nargs,pred) ==
;   pred is ["and",:l] and nargs=#l and
;     (u:= [(x is ["=",=y,a] => a; return nil)
;       for y in $FormalMapVariableList for x in orderList l]) =>
;         ["Tuple",:u]

(DEFUN |canMakeTuple| (|nargs| |pred|)
  (PROG (|l| |ISTMP#1| |ISTMP#2| |a| |u|)
    (RETURN
     (COND
      ((AND (CONSP |pred|) (EQ (CAR |pred|) '|and|)
            (PROGN (SETQ |l| (CDR |pred|)) #1='T) (EQL |nargs| (LENGTH |l|))
            (SETQ |u|
                    ((LAMBDA (|bfVar#24| |bfVar#22| |y| |bfVar#23| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#22|)
                              (PROGN (SETQ |y| (CAR |bfVar#22|)) NIL)
                              (ATOM |bfVar#23|)
                              (PROGN (SETQ |x| (CAR |bfVar#23|)) NIL))
                          (RETURN (NREVERSE |bfVar#24|)))
                         (#1#
                          (SETQ |bfVar#24|
                                  (CONS
                                   (COND
                                    ((AND (CONSP |x|) (EQ (CAR |x|) '=)
                                          (PROGN
                                           (SETQ |ISTMP#1| (CDR |x|))
                                           (AND (CONSP |ISTMP#1|)
                                                (EQUAL (CAR |ISTMP#1|) |y|)
                                                (PROGN
                                                 (SETQ |ISTMP#2|
                                                         (CDR |ISTMP#1|))
                                                 (AND (CONSP |ISTMP#2|)
                                                      (EQ (CDR |ISTMP#2|) NIL)
                                                      (PROGN
                                                       (SETQ |a|
                                                               (CAR |ISTMP#2|))
                                                       #1#))))))
                                     |a|)
                                    (#1# (RETURN NIL)))
                                   |bfVar#24|))))
                        (SETQ |bfVar#22| (CDR |bfVar#22|))
                        (SETQ |bfVar#23| (CDR |bfVar#23|))))
                     NIL |$FormalMapVariableList| NIL (|orderList| |l|) NIL)))
       (IDENTITY (CONS '|Tuple| |u|)))))))

; sayRemoveFunctionOrValue x ==
;   (obj := getValue x) and (md := objMode obj) =>
;     md = $EmptyMode =>
;       sayMessage ['"  ",:bright x,'"now has no function parts."]
;     sayMessage ['"   value for",:bright x,'"has been removed."]
;   sayMessage ['"  ",:bright x,'"has no value so this does nothing."]

(DEFUN |sayRemoveFunctionOrValue| (|x|)
  (PROG (|obj| |md|)
    (RETURN
     (COND
      ((AND (SETQ |obj| (|getValue| |x|)) (SETQ |md| (|objMode| |obj|)))
       (COND
        ((EQUAL |md| |$EmptyMode|)
         (|sayMessage|
          (CONS "  "
                (APPEND (|bright| |x|)
                        (CONS "now has no function parts." NIL)))))
        (#1='T
         (|sayMessage|
          (CONS "   value for"
                (APPEND (|bright| |x|) (CONS "has been removed." NIL)))))))
      (#1#
       (|sayMessage|
        (CONS "  "
              (APPEND (|bright| |x|)
                      (CONS "has no value so this does nothing." NIL)))))))))

; sayDroppingFunctions(op,l) ==
;   sayKeyedMsg("S2IM0017",[#l,op])
;   if $displayDroppedMap then
;     for [pattern,:replacement] in l repeat
;       displaySingleRule(op,pattern,replacement)
;   nil

(DEFUN |sayDroppingFunctions| (|op| |l|)
  (PROG (|pattern| |replacement|)
    (RETURN
     (PROGN
      (|sayKeyedMsg| 'S2IM0017 (LIST (LENGTH |l|) |op|))
      (COND
       (|$displayDroppedMap|
        ((LAMBDA (|bfVar#26| |bfVar#25|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#26|)
                  (PROGN (SETQ |bfVar#25| (CAR |bfVar#26|)) NIL))
              (RETURN NIL))
             (#1='T
              (AND (CONSP |bfVar#25|)
                   (PROGN
                    (SETQ |pattern| (CAR |bfVar#25|))
                    (SETQ |replacement| (CDR |bfVar#25|))
                    #1#)
                   (|displaySingleRule| |op| |pattern| |replacement|))))
            (SETQ |bfVar#26| (CDR |bfVar#26|))))
         |l| NIL)))
      NIL))))

; makeRuleForm(op,pattern)==
;   pattern is ["Tuple",:l] => [op,:l]
;   [op,:pattern]

(DEFUN |makeRuleForm| (|op| |pattern|)
  (PROG (|l|)
    (RETURN
     (COND
      ((AND (CONSP |pattern|) (EQ (CAR |pattern|) '|Tuple|)
            (PROGN (SETQ |l| (CDR |pattern|)) #1='T))
       (CONS |op| |l|))
      (#1# (CONS |op| |pattern|))))))

; mkFormalArg(x,s) ==
;   isConstantArgument x => ["SUCHTHAT",s,["=",s,x]]
;   isPatternArgument x => ["SUCHTHAT",s,["is",s,x]]
;   IDENTP x =>
;     y:= LASSOC(x,$sl) => ["SUCHTHAT",s,["=",s,y]]
;     $sl:= [[x,:s],:$sl]
;     s
;   ['SUCHTHAT,s,["=",s,x]]

(DEFUN |mkFormalArg| (|x| |s|)
  (PROG (|y|)
    (RETURN
     (COND ((|isConstantArgument| |x|) (LIST 'SUCHTHAT |s| (LIST '= |s| |x|)))
           ((|isPatternArgument| |x|)
            (LIST 'SUCHTHAT |s| (LIST '|is| |s| |x|)))
           ((IDENTP |x|)
            (COND
             ((SETQ |y| (LASSOC |x| |$sl|))
              (LIST 'SUCHTHAT |s| (LIST '= |s| |y|)))
             (#1='T (PROGN (SETQ |$sl| (CONS (CONS |x| |s|) |$sl|)) |s|))))
           (#1# (LIST 'SUCHTHAT |s| (LIST '= |s| |x|)))))))

; isConstantArgument x ==
;   NUMBERP x => x
;   x is ["QUOTE",.] => x

(DEFUN |isConstantArgument| (|x|)
  (PROG (|ISTMP#1|)
    (RETURN
     (COND ((NUMBERP |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
            |x|)))))

; isPatternArgument x == x is ["construct",:.]

(DEFUN |isPatternArgument| (|x|)
  (PROG () (RETURN (AND (CONSP |x|) (EQ (CAR |x|) '|construct|)))))

; makeNewDependencies (op, userVariables) ==
;   null userVariables => nil
;   --add the new dependencies
;   [[(first userVariables),op],
;     :makeNewDependencies (op, rest userVariables)]

(DEFUN |makeNewDependencies| (|op| |userVariables|)
  (PROG ()
    (RETURN
     (COND ((NULL |userVariables|) NIL)
           ('T
            (CONS (LIST (CAR |userVariables|) |op|)
                  (|makeNewDependencies| |op| (CDR |userVariables|))))))))

; putDependencies (op, dependencies) ==
;   oldDependencies := getFlag "$dependencies"
;   --remove the obsolete dependencies:  all those that applied to the
;   --old definition, but may not apply here.  If they do, they'll be
;   --in the list of new dependencies anyway
;   oldDependencies := removeObsoleteDependencies (op, oldDependencies) where
;     removeObsoleteDependencies (op, oldDep) ==
;       null oldDep => nil
;       op = rest first oldDep =>
;         removeObsoleteDependencies (op, rest oldDep)
;       [first oldDep,:removeObsoleteDependencies (op, rest oldDep)]
;   --Create the list of dependencies to output.  This will be all the
;   --old dependencies that are still applicable, and all the new ones
;   --that have just been generated.  Remember that the list of
;   --dependencies does not just include those for the map just being
;   --defined, but includes those for all maps and variables that exist
;   newDependencies := union (dependencies, oldDependencies)
;   putFlag ("$dependencies", newDependencies)

(DEFUN |putDependencies| (|op| |dependencies|)
  (PROG (|oldDependencies| |newDependencies|)
    (RETURN
     (PROGN
      (SETQ |oldDependencies| (|getFlag| '|$dependencies|))
      (SETQ |oldDependencies|
              (|putDependencies,removeObsoleteDependencies| |op|
               |oldDependencies|))
      (SETQ |newDependencies| (|union| |dependencies| |oldDependencies|))
      (|putFlag| '|$dependencies| |newDependencies|)))))
(DEFUN |putDependencies,removeObsoleteDependencies| (|op| |oldDep|)
  (PROG ()
    (RETURN
     (COND ((NULL |oldDep|) NIL)
           ((EQUAL |op| (CDR (CAR |oldDep|)))
            (|putDependencies,removeObsoleteDependencies| |op| (CDR |oldDep|)))
           ('T
            (CONS (CAR |oldDep|)
                  (|putDependencies,removeObsoleteDependencies| |op|
                   (CDR |oldDep|))))))))

; clearDependencies(x) ==
;     clearDep1(x, [], [], COPY getFlag "$dependencies")

(DEFUN |clearDependencies| (|x|)
  (PROG ()
    (RETURN (|clearDep1| |x| NIL NIL (COPY (|getFlag| '|$dependencies|))))))

; clearDep1(x,toDoList,doneList,depList) ==
;   x in doneList => nil
;   clearCache x
;   newDone:= [x,:doneList]
;   until null a repeat
;     a:= ASSQ(x,depList)
;     a =>
;       depList:= delete(a,depList)
;       toDoList:= union(toDoList,
;         setDifference(rest a, doneList))
;   toDoList is [a,:res] => clearDep1(a,res,newDone,depList)
;   'done

(DEFUN |clearDep1| (|x| |toDoList| |doneList| |depList|)
  (PROG (|newDone| |a| |res|)
    (RETURN
     (COND ((|member| |x| |doneList|) NIL)
           (#1='T
            (PROGN
             (|clearCache| |x|)
             (SETQ |newDone| (CONS |x| |doneList|))
             ((LAMBDA (|bfVar#27|)
                (LOOP
                 (COND (|bfVar#27| (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |a| (ASSQ |x| |depList|))
                         (COND
                          (|a|
                           (PROGN
                            (SETQ |depList| (|delete| |a| |depList|))
                            (SETQ |toDoList|
                                    (|union| |toDoList|
                                     (SETDIFFERENCE (CDR |a|)
                                                    |doneList|)))))))))
                 (SETQ |bfVar#27| (NULL |a|))))
              NIL)
             (COND
              ((AND (CONSP |toDoList|)
                    (PROGN
                     (SETQ |a| (CAR |toDoList|))
                     (SETQ |res| (CDR |toDoList|))
                     #1#))
               (|clearDep1| |a| |res| |newDone| |depList|))
              (#1# '|done|))))))))

; displayRule(op,rule) ==
;   null rule => nil
;   mathprint ["CONCAT", "Definition:   ", outputMapTran(op, rule)]
;   nil

(DEFUN |displayRule| (|op| |rule|)
  (PROG ()
    (RETURN
     (COND ((NULL |rule|) NIL)
           ('T
            (PROGN
             (|mathprint|
              (LIST 'CONCAT '|Definition:   | (|outputMapTran| |op| |rule|)))
             NIL))))))

; outputFormat(x,m) ==
;   -- this is largely junk and is being phased out
;   IDENTP m => x
;   m=$OutputForm or m=$EmptyMode => x
;   categoryForm?(m) => x
;   isMapExpr x => x
;   containsVars x => x
;   atom(x) and first(m) = 'List => x
;   (x is ['construct,:.]) and m = '(List (Expression)) => x
;   T:= coerceInteractive(objNewWrap(x,maximalSuperType(m)),
;     $OutputForm) or return x
;   objValUnwrap T

(DEFUN |outputFormat| (|x| |m|)
  (PROG (T$)
    (RETURN
     (COND ((IDENTP |m|) |x|)
           ((OR (EQUAL |m| |$OutputForm|) (EQUAL |m| |$EmptyMode|)) |x|)
           ((|categoryForm?| |m|) |x|) ((|isMapExpr| |x|) |x|)
           ((|containsVars| |x|) |x|)
           ((AND (ATOM |x|) (EQ (CAR |m|) '|List|)) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) '|construct|)
                 (EQUAL |m| '(|List| (|Expression|))))
            |x|)
           ('T
            (PROGN
             (SETQ T$
                     (OR
                      (|coerceInteractive|
                       (|objNewWrap| |x| (|maximalSuperType| |m|))
                       |$OutputForm|)
                      (RETURN |x|)))
             (|objValUnwrap| T$)))))))

; displaySingleRule(op, pattern, replacement) ==
;   mathprint outputMapTran(op, ['SPADMAP, [pattern, :replacement]])

(DEFUN |displaySingleRule| (|op| |pattern| |replacement|)
  (PROG ()
    (RETURN
     (|mathprint|
      (|outputMapTran| |op| (LIST 'SPADMAP (CONS |pattern| |replacement|)))))))

; simplifyMapPattern (x,alias) ==
;   for a in alias
;     for m in $FormalMapVariableList | a and not CONTAINED(a,x) repeat
;       x:= substitute(a,m,x)
;   [lhs,:rhs]:= x
;   rhs := simplifyMapConstructorRefs rhs
;   x := [lhs,:rhs]
;   lhs is ["|",y,pred] =>
;     pred:= predTran pred
;     sl:= getEqualSublis pred =>
;       y':= SUBLIS(sl,y)
;       pred:= unTrivialize SUBLIS(sl,pred) where unTrivialize x ==
;         x is [op,:l] and op in '(_and _or) =>
;           MKPF([unTrivialize y for y in l],op)
;         x is [op,a,=a] and op in '(_= is)=> true
;         x
;       rhs':= SUBLIS(sl,rhs)
;       pred=true => [y',:rhs']
;       [["PAREN",["|",y',pred]],:rhs']
;     pred=true => [y,:rhs]
;     [["PAREN",["|",y,pred]],:rhs]
;   lhs=true => ["true",:rhs]
;   x

(DEFUN |simplifyMapPattern| (|x| |alias|)
  (PROG (|lhs| |rhs| |ISTMP#1| |y| |ISTMP#2| |pred| |sl| |y'| |rhs'|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#28| |a| |bfVar#29| |m|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#28|) (PROGN (SETQ |a| (CAR |bfVar#28|)) NIL)
                (ATOM |bfVar#29|) (PROGN (SETQ |m| (CAR |bfVar#29|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND |a| (NULL (CONTAINED |a| |x|))
                 (SETQ |x| (|substitute| |a| |m| |x|)))))
          (SETQ |bfVar#28| (CDR |bfVar#28|))
          (SETQ |bfVar#29| (CDR |bfVar#29|))))
       |alias| NIL |$FormalMapVariableList| NIL)
      (SETQ |lhs| (CAR |x|))
      (SETQ |rhs| (CDR |x|))
      (SETQ |rhs| (|simplifyMapConstructorRefs| |rhs|))
      (SETQ |x| (CONS |lhs| |rhs|))
      (COND
       ((AND (CONSP |lhs|) (EQ (CAR |lhs|) '|\||)
             (PROGN
              (SETQ |ISTMP#1| (CDR |lhs|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |y| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |pred| (CAR |ISTMP#2|)) #1#))))))
        (PROGN
         (SETQ |pred| (|predTran| |pred|))
         (COND
          ((SETQ |sl| (|getEqualSublis| |pred|))
           (PROGN
            (SETQ |y'| (SUBLIS |sl| |y|))
            (SETQ |pred|
                    (|simplifyMapPattern,unTrivialize| (SUBLIS |sl| |pred|)))
            (SETQ |rhs'| (SUBLIS |sl| |rhs|))
            (COND ((EQUAL |pred| T) (CONS |y'| |rhs'|))
                  (#1# (CONS (LIST 'PAREN (LIST '|\|| |y'| |pred|)) |rhs'|)))))
          ((EQUAL |pred| T) (CONS |y| |rhs|))
          (#1# (CONS (LIST 'PAREN (LIST '|\|| |y| |pred|)) |rhs|)))))
       ((EQUAL |lhs| T) (CONS '|true| |rhs|)) (#1# |x|))))))
(DEFUN |simplifyMapPattern,unTrivialize| (|x|)
  (PROG (|op| |l| |ISTMP#1| |a| |ISTMP#2|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN (SETQ |op| (CAR |x|)) (SETQ |l| (CDR |x|)) #1='T)
            (|member| |op| '(|and| |or|)))
       (MKPF
        ((LAMBDA (|bfVar#31| |bfVar#30| |y|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#30|) (PROGN (SETQ |y| (CAR |bfVar#30|)) NIL))
              (RETURN (NREVERSE |bfVar#31|)))
             (#1#
              (SETQ |bfVar#31|
                      (CONS (|simplifyMapPattern,unTrivialize| |y|)
                            |bfVar#31|))))
            (SETQ |bfVar#30| (CDR |bfVar#30|))))
         NIL |l| NIL)
        |op|))
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (EQUAL (CAR |ISTMP#2|) |a|)))))
            (|member| |op| '(= |is|)))
       T)
      (#1# |x|)))))

; simplifyMapConstructorRefs form ==
;   -- try to linear format constructor names
;   ATOM form => form
;   [op,:args] := form
;   op in '(exit SEQ) =>
;     [op,:[simplifyMapConstructorRefs a for a in args]]
;   op in '(REPEAT) =>
;     [op,first args,:[simplifyMapConstructorRefs a for a in rest args]]
;   op in '(_: _:_: _@) =>
;     args is [obj,dom] =>
;       dom' := prefix2String dom
;       --if ATOM dom' then dom' := [dom']
;       --[op,obj,APPLY('CONCAT,dom')]
;       dom'' :=
;           ATOM dom' => dom'
;           NULL rest dom' => first dom'
;           APPLY('CONCAT, dom')
;       [op,obj, dom'']
;     form
;   form

(DEFUN |simplifyMapConstructorRefs| (|form|)
  (PROG (|op| |args| |obj| |ISTMP#1| |dom| |dom'| |dom''|)
    (RETURN
     (COND ((ATOM |form|) |form|)
           (#1='T
            (PROGN
             (SETQ |op| (CAR |form|))
             (SETQ |args| (CDR |form|))
             (COND
              ((|member| |op| '(|exit| SEQ))
               (CONS |op|
                     ((LAMBDA (|bfVar#33| |bfVar#32| |a|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#32|)
                               (PROGN (SETQ |a| (CAR |bfVar#32|)) NIL))
                           (RETURN (NREVERSE |bfVar#33|)))
                          (#1#
                           (SETQ |bfVar#33|
                                   (CONS (|simplifyMapConstructorRefs| |a|)
                                         |bfVar#33|))))
                         (SETQ |bfVar#32| (CDR |bfVar#32|))))
                      NIL |args| NIL)))
              ((|member| |op| '(REPEAT))
               (CONS |op|
                     (CONS (CAR |args|)
                           ((LAMBDA (|bfVar#35| |bfVar#34| |a|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#34|)
                                     (PROGN (SETQ |a| (CAR |bfVar#34|)) NIL))
                                 (RETURN (NREVERSE |bfVar#35|)))
                                (#1#
                                 (SETQ |bfVar#35|
                                         (CONS
                                          (|simplifyMapConstructorRefs| |a|)
                                          |bfVar#35|))))
                               (SETQ |bfVar#34| (CDR |bfVar#34|))))
                            NIL (CDR |args|) NIL))))
              ((|member| |op| '(|:| |::| @))
               (COND
                ((AND (CONSP |args|)
                      (PROGN
                       (SETQ |obj| (CAR |args|))
                       (SETQ |ISTMP#1| (CDR |args|))
                       (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                            (PROGN (SETQ |dom| (CAR |ISTMP#1|)) #1#))))
                 (PROGN
                  (SETQ |dom'| (|prefix2String| |dom|))
                  (SETQ |dom''|
                          (COND ((ATOM |dom'|) |dom'|)
                                ((NULL (CDR |dom'|)) (CAR |dom'|))
                                (#1# (APPLY 'CONCAT |dom'|))))
                  (LIST |op| |obj| |dom''|)))
                (#1# |form|)))
              (#1# |form|))))))))

; predTran x ==
;   x is ["IF",a,b,c] =>
;     c = "false" => MKPF([predTran a,predTran b],"and")
;     b = "true" => MKPF([predTran a,predTran c],"or")
;     b = "false" and c = "true" => ["not",predTran a]
;     x
;   x

(DEFUN |predTran| (|x|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |ISTMP#3| |c|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |b| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |c| (CAR |ISTMP#3|)) #1='T))))))))
       (COND
        ((EQ |c| '|false|)
         (MKPF (LIST (|predTran| |a|) (|predTran| |b|)) '|and|))
        ((EQ |b| '|true|)
         (MKPF (LIST (|predTran| |a|) (|predTran| |c|)) '|or|))
        ((AND (EQ |b| '|false|) (EQ |c| '|true|))
         (LIST '|not| (|predTran| |a|)))
        (#1# |x|)))
      (#1# |x|)))))

; getEqualSublis pred == fn(pred,nil) where fn(x,sl) ==
;   (x:= SUBLIS(sl,x)) is [op,:l] and op in '(_and _or) =>
;     for y in l repeat sl:= fn(y,sl)
;     sl
;   x is ["is",a,b] => [[a,:b],:sl]
;   x is ["=",a,b] =>
;     IDENTP a and not CONTAINED(a,b) => [[a,:b],:sl]
;     IDENTP b and not CONTAINED(b,a) => [[b,:a],:sl]
;     sl
;   sl

(DEFUN |getEqualSublis| (|pred|)
  (PROG () (RETURN (|getEqualSublis,fn| |pred| NIL))))
(DEFUN |getEqualSublis,fn| (|x| |sl|)
  (PROG (|ISTMP#1| |op| |l| |a| |ISTMP#2| |b|)
    (RETURN
     (COND
      ((AND
        (PROGN
         (SETQ |ISTMP#1| (SETQ |x| (SUBLIS |sl| |x|)))
         (AND (CONSP |ISTMP#1|)
              (PROGN
               (SETQ |op| (CAR |ISTMP#1|))
               (SETQ |l| (CDR |ISTMP#1|))
               #1='T)))
        (|member| |op| '(|and| |or|)))
       (PROGN
        ((LAMBDA (|bfVar#36| |y|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#36|) (PROGN (SETQ |y| (CAR |bfVar#36|)) NIL))
              (RETURN NIL))
             (#1# (SETQ |sl| (|getEqualSublis,fn| |y| |sl|))))
            (SETQ |bfVar#36| (CDR |bfVar#36|))))
         |l| NIL)
        |sl|))
      ((AND (CONSP |x|) (EQ (CAR |x|) '|is|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
       (CONS (CONS |a| |b|) |sl|))
      ((AND (CONSP |x|) (EQ (CAR |x|) '=)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
       (COND
        ((AND (IDENTP |a|) (NULL (CONTAINED |a| |b|)))
         (CONS (CONS |a| |b|) |sl|))
        ((AND (IDENTP |b|) (NULL (CONTAINED |b| |a|)))
         (CONS (CONS |b| |a|) |sl|))
        (#1# |sl|)))
      (#1# |sl|)))))

; mapCatchName mapname ==
;    INTERN STRCONC('"$",STRINGIMAGE mapname,'"CatchMapIdentifier$")

(DEFUN |mapCatchName| (|mapname|)
  (PROG ()
    (RETURN
     (INTERN (STRCONC "$" (STRINGIMAGE |mapname|) "CatchMapIdentifier$")))))

; analyzeMap(op,argTypes,mapDef, tar) ==
;   -- Top level entry point for map type analysis.  Sets up catch point
;   --  for interpret-code mode.
;   $compilingMap:local := true
;   $definingMap:local := true
;   $minivector     : local := nil   -- later becomes value of $minivectorName
;   $mapThrowCount  : local := 0     -- number of "return"s encountered
;   $mapReturnTypes : local := nil   -- list of types from returns
;   $repeatLabel    : local := nil   -- for loops; see upREPEAT
;   $breakCount     : local := 0     -- breaks from loops; ditto
;   $mapTarget      : local := tar
;   $interpOnly: local := NIL
;   $mapName : local := op.0
;   if get($mapName,'recursive,$e) then
;     argTypes := [f t for t in argTypes] where
;       f x ==
;         isEqualOrSubDomain(x,$Integer) => $Integer
;         x
;   mapAndArgTypes := [$mapName,:argTypes]
;   member(mapAndArgTypes,$analyzingMapList) =>
;     -- if the map is declared, return the target type
;     (getMode op) is ['Mapping,target,:.] => target
;     throwKeyedMsg("S2IM0009",
;       [$mapName,['" ", map for [map,:.] in $analyzingMapList]])
;   PUSH(mapAndArgTypes,$analyzingMapList)
;   mapDef := mapDefsWithCorrectArgCount(#argTypes, mapDef)
;   null mapDef => (POP $analyzingMapList; nil)
;
;   UNWIND_-PROTECT(x:=CATCH('mapCompiler,analyzeMap0(op,argTypes,mapDef)),
;     POP $analyzingMapList)
;   x='tryInterpOnly =>
;     opName:=getUnname op
;     fun := mkInterpFun(op,opName,argTypes)
;     if getMode op isnt ['Mapping,:sig] then
;       sig := [nil,:[nil for type in argTypes]]
;     $e:=putHist(opName,'localModemap,
;       [[['interpOnly,:sig],fun,NIL]],$e)
;   x

(DEFUN |analyzeMap| (|op| |argTypes| |mapDef| |tar|)
  (PROG (|$mapName| |$interpOnly| |$mapTarget| |$breakCount| |$repeatLabel|
         |$mapReturnTypes| |$mapThrowCount| |$minivector| |$definingMap|
         |$compilingMap| |sig| |fun| |opName| |x| |map| |target| |ISTMP#2|
         |ISTMP#1| |mapAndArgTypes|)
    (DECLARE
     (SPECIAL |$mapName| |$interpOnly| |$mapTarget| |$breakCount|
      |$repeatLabel| |$mapReturnTypes| |$mapThrowCount| |$minivector|
      |$definingMap| |$compilingMap|))
    (RETURN
     (PROGN
      (SETQ |$compilingMap| T)
      (SETQ |$definingMap| T)
      (SETQ |$minivector| NIL)
      (SETQ |$mapThrowCount| 0)
      (SETQ |$mapReturnTypes| NIL)
      (SETQ |$repeatLabel| NIL)
      (SETQ |$breakCount| 0)
      (SETQ |$mapTarget| |tar|)
      (SETQ |$interpOnly| NIL)
      (SETQ |$mapName| (ELT |op| 0))
      (COND
       ((|get| |$mapName| '|recursive| |$e|)
        (SETQ |argTypes|
                ((LAMBDA (|bfVar#38| |bfVar#37| |t|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#37|)
                          (PROGN (SETQ |t| (CAR |bfVar#37|)) NIL))
                      (RETURN (NREVERSE |bfVar#38|)))
                     (#1='T
                      (SETQ |bfVar#38|
                              (CONS (|analyzeMap,f| |t|) |bfVar#38|))))
                    (SETQ |bfVar#37| (CDR |bfVar#37|))))
                 NIL |argTypes| NIL))))
      (SETQ |mapAndArgTypes| (CONS |$mapName| |argTypes|))
      (COND
       ((|member| |mapAndArgTypes| |$analyzingMapList|)
        (COND
         ((PROGN
           (SETQ |ISTMP#1| (|getMode| |op|))
           (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
                (PROGN
                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                 (AND (CONSP |ISTMP#2|)
                      (PROGN (SETQ |target| (CAR |ISTMP#2|)) #1#)))))
          |target|)
         (#1#
          (|throwKeyedMsg| 'S2IM0009
           (LIST |$mapName|
                 ((LAMBDA (|bfVar#41| |bfVar#40| |bfVar#39|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#40|)
                           (PROGN (SETQ |bfVar#39| (CAR |bfVar#40|)) NIL))
                       (RETURN (NREVERSE |bfVar#41|)))
                      (#1#
                       (AND (CONSP |bfVar#39|)
                            (PROGN (SETQ |map| (CAR |bfVar#39|)) #1#)
                            (SETQ |bfVar#41|
                                    (APPEND
                                     (REVERSE (CONS " " (CONS |map| NIL)))
                                     |bfVar#41|)))))
                     (SETQ |bfVar#40| (CDR |bfVar#40|))))
                  NIL |$analyzingMapList| NIL))))))
       (#1#
        (PROGN
         (PUSH |mapAndArgTypes| |$analyzingMapList|)
         (SETQ |mapDef|
                 (|mapDefsWithCorrectArgCount| (LENGTH |argTypes|) |mapDef|))
         (COND ((NULL |mapDef|) (PROGN (POP |$analyzingMapList|) NIL))
               (#1#
                (PROGN
                 (UNWIND-PROTECT
                     (SETQ |x|
                             (CATCH '|mapCompiler|
                               (|analyzeMap0| |op| |argTypes| |mapDef|)))
                   (POP |$analyzingMapList|))
                 (COND
                  ((EQ |x| '|tryInterpOnly|)
                   (PROGN
                    (SETQ |opName| (|getUnname| |op|))
                    (SETQ |fun| (|mkInterpFun| |op| |opName| |argTypes|))
                    (COND
                     ((NOT
                       (PROGN
                        (SETQ |ISTMP#1| (|getMode| |op|))
                        (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
                             (PROGN (SETQ |sig| (CDR |ISTMP#1|)) #1#))))
                      (SETQ |sig|
                              (CONS NIL
                                    ((LAMBDA (|bfVar#43| |bfVar#42| |type|)
                                       (LOOP
                                        (COND
                                         ((OR (ATOM |bfVar#42|)
                                              (PROGN
                                               (SETQ |type| (CAR |bfVar#42|))
                                               NIL))
                                          (RETURN (NREVERSE |bfVar#43|)))
                                         (#1#
                                          (SETQ |bfVar#43|
                                                  (CONS NIL |bfVar#43|))))
                                        (SETQ |bfVar#42| (CDR |bfVar#42|))))
                                     NIL |argTypes| NIL)))))
                    (SETQ |$e|
                            (|putHist| |opName| '|localModemap|
                             (LIST (LIST (CONS '|interpOnly| |sig|) |fun| NIL))
                             |$e|))))
                  (#1# |x|))))))))))))
(DEFUN |analyzeMap,f| (|x|)
  (PROG ()
    (RETURN
     (COND ((|isEqualOrSubDomain| |x| |$Integer|) |$Integer|) ('T |x|)))))

; analyzeMap0(op,argTypes,mapDef) ==
;   -- Type analyze and compile a map.  Returns the target type of the map.
;   --  only called if there is no applicable compiled map
;   $MapArgumentTypeList:local:= argTypes
;   numMapArgs mapDef ~= #argTypes => nil
;   ((m:=getMode op) is ['Mapping,:sig]) or (m and (sig:=[m])) =>
;     -- op has mapping property only if user has declared the signature
;     analyzeDeclaredMap(op,argTypes,sig,mapDef,$mapList)
;   analyzeUndeclaredMap(getUnname op,argTypes,mapDef,$mapList)

(DEFUN |analyzeMap0| (|op| |argTypes| |mapDef|)
  (PROG (|$MapArgumentTypeList| |sig| |ISTMP#1| |m|)
    (DECLARE (SPECIAL |$MapArgumentTypeList|))
    (RETURN
     (PROGN
      (SETQ |$MapArgumentTypeList| |argTypes|)
      (COND ((NOT (EQL (|numMapArgs| |mapDef|) (LENGTH |argTypes|))) NIL)
            ((OR
              (PROGN
               (SETQ |ISTMP#1| (SETQ |m| (|getMode| |op|)))
               (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
                    (PROGN (SETQ |sig| (CDR |ISTMP#1|)) #1='T)))
              (AND |m| (SETQ |sig| (LIST |m|))))
             (|analyzeDeclaredMap| |op| |argTypes| |sig| |mapDef| |$mapList|))
            (#1#
             (|analyzeUndeclaredMap| (|getUnname| |op|) |argTypes| |mapDef|
              |$mapList|)))))))

; compFailure msg ==
;   -- Called when compilation fails in such a way that interpret-code
;   --  mode might be of some use.
;   not $useCoerceOrCroak =>    THROW('coerceOrCroaker, 'croaked)
;   if $reportInterpOnly then
;     sayMSG msg
;     sayMSG '"   We will attempt to interpret the code."
;   null $compilingMap => THROW('loopCompiler,'tryInterpOnly)
;   THROW('mapCompiler,'tryInterpOnly)

(DEFUN |compFailure| (|msg|)
  (PROG ()
    (RETURN
     (COND ((NULL |$useCoerceOrCroak|) (THROW '|coerceOrCroaker| '|croaked|))
           (#1='T
            (PROGN
             (COND
              (|$reportInterpOnly| (|sayMSG| |msg|)
               (|sayMSG| "   We will attempt to interpret the code.")))
             (COND
              ((NULL |$compilingMap|) (THROW '|loopCompiler| '|tryInterpOnly|))
              (#1# (THROW '|mapCompiler| '|tryInterpOnly|)))))))))

; mkInterpFun(op,opName,argTypes) ==
;   -- creates a function form to put in fun slot of interp-only
;   -- local modemaps
;   getMode op isnt ['Mapping,:sig] => nil
;   parms := [var for type in argTypes for var in $FormalMapVariableList]
;   arglCode := ['LIST,:[argCode for type in argTypes
;     for argName in parms]] where argCode ==
;       ['putValueValue,['mkAtreeNode,MKQ argName],
;         objNewCode(['wrap,argName],type)]
;   funName := GENSYM()
;   body:=['rewriteMap1,MKQ opName,arglCode,MKQ sig]
;   putMapCode(opName,body,sig,funName,parms,false)
;   genMapCode(opName,body,sig,funName,parms,false)
;   funName

(DEFUN |mkInterpFun| (|op| |opName| |argTypes|)
  (PROG (|ISTMP#1| |sig| |parms| |arglCode| |funName| |body|)
    (RETURN
     (COND
      ((NOT
        (PROGN
         (SETQ |ISTMP#1| (|getMode| |op|))
         (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
              (PROGN (SETQ |sig| (CDR |ISTMP#1|)) #1='T))))
       NIL)
      (#1#
       (PROGN
        (SETQ |parms|
                ((LAMBDA (|bfVar#46| |bfVar#44| |type| |bfVar#45| |var|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#44|)
                          (PROGN (SETQ |type| (CAR |bfVar#44|)) NIL)
                          (ATOM |bfVar#45|)
                          (PROGN (SETQ |var| (CAR |bfVar#45|)) NIL))
                      (RETURN (NREVERSE |bfVar#46|)))
                     (#1# (SETQ |bfVar#46| (CONS |var| |bfVar#46|))))
                    (SETQ |bfVar#44| (CDR |bfVar#44|))
                    (SETQ |bfVar#45| (CDR |bfVar#45|))))
                 NIL |argTypes| NIL |$FormalMapVariableList| NIL))
        (SETQ |arglCode|
                (CONS 'LIST
                      ((LAMBDA
                           (|bfVar#49| |bfVar#47| |type| |bfVar#48| |argName|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#47|)
                                (PROGN (SETQ |type| (CAR |bfVar#47|)) NIL)
                                (ATOM |bfVar#48|)
                                (PROGN (SETQ |argName| (CAR |bfVar#48|)) NIL))
                            (RETURN (NREVERSE |bfVar#49|)))
                           (#1#
                            (SETQ |bfVar#49|
                                    (CONS
                                     (LIST '|putValueValue|
                                           (LIST '|mkAtreeNode|
                                                 (MKQ |argName|))
                                           (|objNewCode|
                                            (LIST '|wrap| |argName|) |type|))
                                     |bfVar#49|))))
                          (SETQ |bfVar#47| (CDR |bfVar#47|))
                          (SETQ |bfVar#48| (CDR |bfVar#48|))))
                       NIL |argTypes| NIL |parms| NIL)))
        (SETQ |funName| (GENSYM))
        (SETQ |body|
                (LIST '|rewriteMap1| (MKQ |opName|) |arglCode| (MKQ |sig|)))
        (|putMapCode| |opName| |body| |sig| |funName| |parms| NIL)
        (|genMapCode| |opName| |body| |sig| |funName| |parms| NIL)
        |funName|))))))

; rewriteMap(op,opName,argl) ==
;   -- interpret-code handler for maps.  Recursively calls the interpreter
;   --   on the body of the map.
;   not $genValue =>
;     get(opName,'mode,$e) isnt ['Mapping,:sig] =>
;       compFailure  ['"   Cannot compile map:",:bright opName]
;     arglCode := ['LIST,:[argCode for arg in argl for argName in
;       $FormalMapVariableList]] where argCode ==
;         atype := OR(getMode arg, IFCAR(getModeSet arg))
;         ['putValueValue,['mkAtreeNode,MKQ argName],
;           objNewCode(['wrap,wrapped2Quote(objVal getValue arg)],
;                       atype)]
;     putValue(op,objNew(['rewriteMap1,MKQ opName,arglCode,MKQ sig],
;       first sig))
;     putModeSet(op, [first sig])
;   rewriteMap0(op,opName,argl)

(DEFUN |rewriteMap| (|op| |opName| |argl|)
  (PROG (|ISTMP#1| |sig| |atype| |arglCode|)
    (RETURN
     (COND
      ((NULL |$genValue|)
       (COND
        ((NOT
          (PROGN
           (SETQ |ISTMP#1| (|get| |opName| '|mode| |$e|))
           (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
                (PROGN (SETQ |sig| (CDR |ISTMP#1|)) #1='T))))
         (|compFailure| (CONS "   Cannot compile map:" (|bright| |opName|))))
        (#1#
         (PROGN
          (SETQ |arglCode|
                  (CONS 'LIST
                        ((LAMBDA
                             (|bfVar#52| |bfVar#50| |arg| |bfVar#51| |argName|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#50|)
                                  (PROGN (SETQ |arg| (CAR |bfVar#50|)) NIL)
                                  (ATOM |bfVar#51|)
                                  (PROGN
                                   (SETQ |argName| (CAR |bfVar#51|))
                                   NIL))
                              (RETURN (NREVERSE |bfVar#52|)))
                             (#1#
                              (SETQ |bfVar#52|
                                      (CONS
                                       (PROGN
                                        (SETQ |atype|
                                                (OR (|getMode| |arg|)
                                                    (IFCAR
                                                     (|getModeSet| |arg|))))
                                        (LIST '|putValueValue|
                                              (LIST '|mkAtreeNode|
                                                    (MKQ |argName|))
                                              (|objNewCode|
                                               (LIST '|wrap|
                                                     (|wrapped2Quote|
                                                      (|objVal|
                                                       (|getValue| |arg|))))
                                               |atype|)))
                                       |bfVar#52|))))
                            (SETQ |bfVar#50| (CDR |bfVar#50|))
                            (SETQ |bfVar#51| (CDR |bfVar#51|))))
                         NIL |argl| NIL |$FormalMapVariableList| NIL)))
          (|putValue| |op|
           (|objNew|
            (LIST '|rewriteMap1| (MKQ |opName|) |arglCode| (MKQ |sig|))
            (CAR |sig|)))
          (|putModeSet| |op| (LIST (CAR |sig|)))))))
      (#1# (|rewriteMap0| |op| |opName| |argl|))))))

; putBodyInEnv(opName, numArgs) ==
;   val := get(opName, 'value, $e)
;   val is [., 'SPADMAP, :bod] =>
;     $e := putHist(opName, 'mapBody, combineMapParts
;       mapDefsWithCorrectArgCount(numArgs, bod), $e)
;   'failed

(DEFUN |putBodyInEnv| (|opName| |numArgs|)
  (PROG (|val| |ISTMP#1| |bod|)
    (RETURN
     (PROGN
      (SETQ |val| (|get| |opName| '|value| |$e|))
      (COND
       ((AND (CONSP |val|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |val|))
              (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADMAP)
                   (PROGN (SETQ |bod| (CDR |ISTMP#1|)) #1='T))))
        (SETQ |$e|
                (|putHist| |opName| '|mapBody|
                 (|combineMapParts|
                  (|mapDefsWithCorrectArgCount| |numArgs| |bod|))
                 |$e|)))
       (#1# '|failed|))))))

; removeBodyFromEnv(opName) ==
;   $e := putHist(opName, 'mapBody, nil, $e)

(DEFUN |removeBodyFromEnv| (|opName|)
  (PROG () (RETURN (SETQ |$e| (|putHist| |opName| '|mapBody| NIL |$e|)))))

; rewriteMap0(op,opName,argl) ==
;   -- $genValue case of map rewriting
;   putBodyInEnv(opName, #argl)
;   if (s := get(opName,'mode,$e)) then
;     tar := CADR s
;     argTypes := CDDR s
;   else
;     tar:= nil
;     argTypes:= nil
;   get(opName,'mode,$e) is ['Mapping,tar,:argTypes]
;   $env: local := [[NIL]]
;   for arg in argl
;     for var in $FormalMapVariableList repeat
;       if argTypes then
;         t := first argTypes
;         argTypes := rest argTypes
;         val :=
;           t is ['Mapping,:.] => getValue arg
;           coerceInteractive(getValue arg,t)
;       else
;         val:= getValue arg
;       $env:=put(var,'value,val,$env)
;       if VECP arg then $env := put(var,'name,getUnname arg,$env)
;       (m := getMode arg) => $env := put(var,'mode,m,$env)
;   null (val:= interpMap(opName,tar)) =>
;     throwKeyedMsg("S2IM0010",[opName])
;   putValue(op,val)
;   removeBodyFromEnv(opName)
;   ms := putModeSet(op,[objMode val])

(DEFUN |rewriteMap0| (|op| |opName| |argl|)
  (PROG (|$env| |ms| |m| |val| |t| |ISTMP#2| |ISTMP#1| |argTypes| |tar| |s|)
    (DECLARE (SPECIAL |$env|))
    (RETURN
     (PROGN
      (|putBodyInEnv| |opName| (LENGTH |argl|))
      (COND
       ((SETQ |s| (|get| |opName| '|mode| |$e|)) (SETQ |tar| (CADR |s|))
        (SETQ |argTypes| (CDDR |s|)))
       (#1='T (SETQ |tar| NIL) (SETQ |argTypes| NIL)))
      (SETQ |ISTMP#1| (|get| |opName| '|mode| |$e|))
      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
           (PROGN
            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
            (AND (CONSP |ISTMP#2|)
                 (PROGN
                  (SETQ |tar| (CAR |ISTMP#2|))
                  (SETQ |argTypes| (CDR |ISTMP#2|))
                  #1#))))
      (SETQ |$env| (LIST (LIST NIL)))
      ((LAMBDA (|bfVar#53| |arg| |bfVar#54| |var|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#53|) (PROGN (SETQ |arg| (CAR |bfVar#53|)) NIL)
                (ATOM |bfVar#54|) (PROGN (SETQ |var| (CAR |bfVar#54|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (COND
              (|argTypes| (SETQ |t| (CAR |argTypes|))
               (SETQ |argTypes| (CDR |argTypes|))
               (SETQ |val|
                       (COND
                        ((AND (CONSP |t|) (EQ (CAR |t|) '|Mapping|))
                         (|getValue| |arg|))
                        (#1# (|coerceInteractive| (|getValue| |arg|) |t|)))))
              (#1# (SETQ |val| (|getValue| |arg|))))
             (SETQ |$env| (|put| |var| '|value| |val| |$env|))
             (COND
              ((VECP |arg|)
               (SETQ |$env| (|put| |var| '|name| (|getUnname| |arg|) |$env|))))
             (COND
              ((SETQ |m| (|getMode| |arg|))
               (SETQ |$env| (|put| |var| '|mode| |m| |$env|)))))))
          (SETQ |bfVar#53| (CDR |bfVar#53|))
          (SETQ |bfVar#54| (CDR |bfVar#54|))))
       |argl| NIL |$FormalMapVariableList| NIL)
      (COND
       ((NULL (SETQ |val| (|interpMap| |opName| |tar|)))
        (|throwKeyedMsg| 'S2IM0010 (LIST |opName|)))
       (#1#
        (PROGN
         (|putValue| |op| |val|)
         (|removeBodyFromEnv| |opName|)
         (SETQ |ms| (|putModeSet| |op| (LIST (|objMode| |val|)))))))))))

; rewriteMap1(opName,argl,sig) ==
;   -- compiled case of map rewriting
;   putBodyInEnv(opName, #argl)
;   if sig then
;       tar := first sig
;       argTypes := rest sig
;   else
;     tar:= nil
;     argTypes:= nil
;   evArgl := NIL
;   for arg in reverse argl repeat
;     v := getValue arg
;     evArgl := [objNew(objVal v, objMode v),:evArgl]
;   $env : local := [[NIL]]
;   for arg in argl for evArg in evArgl
;     for var in $FormalMapVariableList repeat
;       if argTypes then
;         t := first argTypes
;         argTypes := rest argTypes
;         val :=
;           t is ['Mapping,:.] => evArg
;           coerceInteractive(evArg,t)
;       else
;         val:= evArg
;       $env:=put(var,'value,val,$env)
;       if VECP arg then $env := put(var,'name,getUnname arg,$env)
;       (m := getMode arg) => $env := put(var,'mode,m,$env)
;   val:= interpMap(opName,tar)
;   removeBodyFromEnv(opName)
;   objValUnwrap(val)

(DEFUN |rewriteMap1| (|opName| |argl| |sig|)
  (PROG (|$env| |m| |val| |t| |v| |evArgl| |argTypes| |tar|)
    (DECLARE (SPECIAL |$env|))
    (RETURN
     (PROGN
      (|putBodyInEnv| |opName| (LENGTH |argl|))
      (COND (|sig| (SETQ |tar| (CAR |sig|)) (SETQ |argTypes| (CDR |sig|)))
            (#1='T (SETQ |tar| NIL) (SETQ |argTypes| NIL)))
      (SETQ |evArgl| NIL)
      ((LAMBDA (|bfVar#55| |arg|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#55|) (PROGN (SETQ |arg| (CAR |bfVar#55|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |v| (|getValue| |arg|))
             (SETQ |evArgl|
                     (CONS (|objNew| (|objVal| |v|) (|objMode| |v|))
                           |evArgl|)))))
          (SETQ |bfVar#55| (CDR |bfVar#55|))))
       (REVERSE |argl|) NIL)
      (SETQ |$env| (LIST (LIST NIL)))
      ((LAMBDA (|bfVar#56| |arg| |bfVar#57| |evArg| |bfVar#58| |var|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#56|) (PROGN (SETQ |arg| (CAR |bfVar#56|)) NIL)
                (ATOM |bfVar#57|) (PROGN (SETQ |evArg| (CAR |bfVar#57|)) NIL)
                (ATOM |bfVar#58|) (PROGN (SETQ |var| (CAR |bfVar#58|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (COND
              (|argTypes| (SETQ |t| (CAR |argTypes|))
               (SETQ |argTypes| (CDR |argTypes|))
               (SETQ |val|
                       (COND
                        ((AND (CONSP |t|) (EQ (CAR |t|) '|Mapping|)) |evArg|)
                        (#1# (|coerceInteractive| |evArg| |t|)))))
              (#1# (SETQ |val| |evArg|)))
             (SETQ |$env| (|put| |var| '|value| |val| |$env|))
             (COND
              ((VECP |arg|)
               (SETQ |$env| (|put| |var| '|name| (|getUnname| |arg|) |$env|))))
             (COND
              ((SETQ |m| (|getMode| |arg|))
               (SETQ |$env| (|put| |var| '|mode| |m| |$env|)))))))
          (SETQ |bfVar#56| (CDR |bfVar#56|))
          (SETQ |bfVar#57| (CDR |bfVar#57|))
          (SETQ |bfVar#58| (CDR |bfVar#58|))))
       |argl| NIL |evArgl| NIL |$FormalMapVariableList| NIL)
      (SETQ |val| (|interpMap| |opName| |tar|))
      (|removeBodyFromEnv| |opName|)
      (|objValUnwrap| |val|)))))

; interpMap(opName,tar) ==
;   -- call the interpreter recursively on map body
;   $genValue : local:= true
;   $interpMapTag : local := nil
;   $interpOnly : local := true
;   $localVars : local := NIL
;   for lvar in get(opName,'localVars,$e) repeat mkLocalVar(opName,lvar)
;   $mapName : local := opName
;   $mapTarget : local := tar
;   body:= get(opName,'mapBody,$e)
;   savedTimerStack := COPY $timedNameStack
;   catchName := mapCatchName $mapName
;   c := CATCH(catchName, interpret1(body,tar,nil))
; --  $interpMapTag and $interpMapTag ~= mapCatchName $mapName =>
; --    THROW($interpMapTag,c)
;   while savedTimerStack ~= $timedNameStack repeat
;     stopTimingProcess peekTimedName()
;   c  -- better be a triple

(DEFUN |interpMap| (|opName| |tar|)
  (PROG (|$mapTarget| |$mapName| |$localVars| |$interpOnly| |$interpMapTag|
         |$genValue| |c| |catchName| |savedTimerStack| |body|)
    (DECLARE
     (SPECIAL |$mapTarget| |$mapName| |$localVars| |$interpOnly|
      |$interpMapTag| |$genValue|))
    (RETURN
     (PROGN
      (SETQ |$genValue| T)
      (SETQ |$interpMapTag| NIL)
      (SETQ |$interpOnly| T)
      (SETQ |$localVars| NIL)
      ((LAMBDA (|bfVar#59| |lvar|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#59|) (PROGN (SETQ |lvar| (CAR |bfVar#59|)) NIL))
            (RETURN NIL))
           (#1='T (|mkLocalVar| |opName| |lvar|)))
          (SETQ |bfVar#59| (CDR |bfVar#59|))))
       (|get| |opName| '|localVars| |$e|) NIL)
      (SETQ |$mapName| |opName|)
      (SETQ |$mapTarget| |tar|)
      (SETQ |body| (|get| |opName| '|mapBody| |$e|))
      (SETQ |savedTimerStack| (COPY |$timedNameStack|))
      (SETQ |catchName| (|mapCatchName| |$mapName|))
      (SETQ |c| (CATCH |catchName| (|interpret1| |body| |tar| NIL)))
      ((LAMBDA ()
         (LOOP
          (COND ((EQUAL |savedTimerStack| |$timedNameStack|) (RETURN NIL))
                (#1# (|stopTimingProcess| (|peekTimedName|)))))))
      |c|))))

; analyzeDeclaredMap(op,argTypes,sig,mapDef,$mapList) ==
;   -- analyzes and compiles maps with declared signatures.  argTypes
;   -- is a list of types of the arguments, sig is the declared signature
;   -- mapDef is the stored form of the map body.
;   opName := getUnname op
;   $mapList:=[opName,:$mapList]
;   $mapTarget := first sig
;   (mmS:= get(opName,'localModemap,$e)) and
;     (mm:= or/[mm for (mm:=[[.,:mmSig],:.]) in mmS | mmSig=sig]) =>
;       compileCoerceMap(opName,argTypes,mm)
;   -- The declared map needs to be compiled
;   compileDeclaredMap(opName,sig,mapDef)
;   argTypes ~= rest sig =>
;     analyzeDeclaredMap(op,argTypes,sig,mapDef,$mapList)
;   first sig

(DEFUN |analyzeDeclaredMap| (|op| |argTypes| |sig| |mapDef| |$mapList|)
  (DECLARE (SPECIAL |$mapList|))
  (PROG (|opName| |mmS| |ISTMP#1| |mmSig| |mm|)
    (RETURN
     (PROGN
      (SETQ |opName| (|getUnname| |op|))
      (SETQ |$mapList| (CONS |opName| |$mapList|))
      (SETQ |$mapTarget| (CAR |sig|))
      (COND
       ((AND (SETQ |mmS| (|get| |opName| '|localModemap| |$e|))
             (SETQ |mm|
                     ((LAMBDA (|bfVar#61| |bfVar#60| |mm|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#60|)
                               (PROGN (SETQ |mm| (CAR |bfVar#60|)) NIL))
                           (RETURN |bfVar#61|))
                          (#1='T
                           (AND (CONSP |mm|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CAR |mm|))
                                 (AND (CONSP |ISTMP#1|)
                                      (PROGN
                                       (SETQ |mmSig| (CDR |ISTMP#1|))
                                       #1#)))
                                (EQUAL |mmSig| |sig|)
                                (PROGN
                                 (SETQ |bfVar#61| |mm|)
                                 (COND (|bfVar#61| (RETURN |bfVar#61|)))))))
                         (SETQ |bfVar#60| (CDR |bfVar#60|))))
                      NIL |mmS| NIL)))
        (|compileCoerceMap| |opName| |argTypes| |mm|))
       (#1#
        (PROGN
         (|compileDeclaredMap| |opName| |sig| |mapDef|)
         (COND
          ((NOT (EQUAL |argTypes| (CDR |sig|)))
           (|analyzeDeclaredMap| |op| |argTypes| |sig| |mapDef| |$mapList|))
          (#1# (CAR |sig|))))))))))

; compileDeclaredMap(op,sig,mapDef) ==
;   -- Type analyzes and compiles a map with a declared signature.
;   -- creates a local modemap and puts it into the environment
;   $localVars: local := nil
;   $freeVars: local := nil
;   $env:local:= [[NIL]]
;   parms := [var for var in $FormalMapVariableList for m in rest sig]
;   for m in rest sig for var in parms repeat
;     $env:= put(var,'mode,m,$env)
;   body:= getMapBody(op,mapDef)
;   for lvar in parms repeat mkLocalVar($mapName,lvar)
;   for lvar in getLocalVars(op,body) repeat mkLocalVar($mapName,lvar)
;   name := makeLocalModemap(op,sig)
;   val  := compileBody(body, first sig)
;   isRecursive := (depthOfRecursion(op,body) > 0)
;   putMapCode(op,objVal val,sig,name,parms,isRecursive)
;   genMapCode(op,objVal val,sig,name,parms,isRecursive)
;   first sig

(DEFUN |compileDeclaredMap| (|op| |sig| |mapDef|)
  (PROG (|$env| |$freeVars| |$localVars| |isRecursive| |val| |name| |body|
         |parms|)
    (DECLARE (SPECIAL |$env| |$freeVars| |$localVars|))
    (RETURN
     (PROGN
      (SETQ |$localVars| NIL)
      (SETQ |$freeVars| NIL)
      (SETQ |$env| (LIST (LIST NIL)))
      (SETQ |parms|
              ((LAMBDA (|bfVar#64| |bfVar#62| |var| |bfVar#63| |m|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#62|)
                        (PROGN (SETQ |var| (CAR |bfVar#62|)) NIL)
                        (ATOM |bfVar#63|)
                        (PROGN (SETQ |m| (CAR |bfVar#63|)) NIL))
                    (RETURN (NREVERSE |bfVar#64|)))
                   (#1='T (SETQ |bfVar#64| (CONS |var| |bfVar#64|))))
                  (SETQ |bfVar#62| (CDR |bfVar#62|))
                  (SETQ |bfVar#63| (CDR |bfVar#63|))))
               NIL |$FormalMapVariableList| NIL (CDR |sig|) NIL))
      ((LAMBDA (|bfVar#65| |m| |bfVar#66| |var|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#65|) (PROGN (SETQ |m| (CAR |bfVar#65|)) NIL)
                (ATOM |bfVar#66|) (PROGN (SETQ |var| (CAR |bfVar#66|)) NIL))
            (RETURN NIL))
           (#1# (SETQ |$env| (|put| |var| '|mode| |m| |$env|))))
          (SETQ |bfVar#65| (CDR |bfVar#65|))
          (SETQ |bfVar#66| (CDR |bfVar#66|))))
       (CDR |sig|) NIL |parms| NIL)
      (SETQ |body| (|getMapBody| |op| |mapDef|))
      ((LAMBDA (|bfVar#67| |lvar|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#67|) (PROGN (SETQ |lvar| (CAR |bfVar#67|)) NIL))
            (RETURN NIL))
           (#1# (|mkLocalVar| |$mapName| |lvar|)))
          (SETQ |bfVar#67| (CDR |bfVar#67|))))
       |parms| NIL)
      ((LAMBDA (|bfVar#68| |lvar|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#68|) (PROGN (SETQ |lvar| (CAR |bfVar#68|)) NIL))
            (RETURN NIL))
           (#1# (|mkLocalVar| |$mapName| |lvar|)))
          (SETQ |bfVar#68| (CDR |bfVar#68|))))
       (|getLocalVars| |op| |body|) NIL)
      (SETQ |name| (|makeLocalModemap| |op| |sig|))
      (SETQ |val| (|compileBody| |body| (CAR |sig|)))
      (SETQ |isRecursive| (< 0 (|depthOfRecursion| |op| |body|)))
      (|putMapCode| |op| (|objVal| |val|) |sig| |name| |parms| |isRecursive|)
      (|genMapCode| |op| (|objVal| |val|) |sig| |name| |parms| |isRecursive|)
      (CAR |sig|)))))

; putMapCode(op,code,sig,name,parms,isRecursive) ==
;   -- saves the generated code and some other information about the
;   -- function
;   codeInfo := VECTOR(op,code,sig,name,parms,isRecursive)
;   allCode := [codeInfo,:get(op,'generatedCode,$e)]
;   $e := putHist(op,'generatedCode,allCode,$e)
;   op

(DEFUN |putMapCode| (|op| |code| |sig| |name| |parms| |isRecursive|)
  (PROG (|codeInfo| |allCode|)
    (RETURN
     (PROGN
      (SETQ |codeInfo| (VECTOR |op| |code| |sig| |name| |parms| |isRecursive|))
      (SETQ |allCode| (CONS |codeInfo| (|get| |op| '|generatedCode| |$e|)))
      (SETQ |$e| (|putHist| |op| '|generatedCode| |allCode| |$e|))
      |op|))))

; makeLocalModemap(op,sig) ==
;   -- create a local modemap for op with sig, and put it into $e
;   if (currentMms := get(op,'localModemap,$e)) then
;     untraceMapSubNames [CADAR currentMms]
;   newName := makeInternalMapName(op,#sig-1,1+#currentMms,NIL)
;   newMm := [['local,:sig],newName,nil]
;   mms := [newMm,:currentMms]
;   $e := putHist(op,'localModemap,mms,$e)
;   newName

(DEFUN |makeLocalModemap| (|op| |sig|)
  (PROG (|currentMms| |newName| |newMm| |mms|)
    (RETURN
     (PROGN
      (COND
       ((SETQ |currentMms| (|get| |op| '|localModemap| |$e|))
        (|untraceMapSubNames| (LIST (CADAR |currentMms|)))))
      (SETQ |newName|
              (|makeInternalMapName| |op| (- (LENGTH |sig|) 1)
               (+ 1 (LENGTH |currentMms|)) NIL))
      (SETQ |newMm| (LIST (CONS '|local| |sig|) |newName| NIL))
      (SETQ |mms| (CONS |newMm| |currentMms|))
      (SETQ |$e| (|putHist| |op| '|localModemap| |mms| |$e|))
      |newName|))))

; genMapCode(op,body,sig,fnName,parms,isRecursive) ==
;   -- calls the lisp compiler on the body of a map
;   if lmm:= get(op,'localModemap,$InteractiveFrame) then
;     untraceMapSubNames [CADAR lmm]
;   op0 :=
;     (n := isSharpVarWithNum op) =>
;         STRCONC('"<argument ",object2String n,'">")
;     op
;   if get(op,'isInterpreterRule,$e) then
;     sayKeyedMsg("S2IM0014", [op0, (PAIRP sig => prefix2String first sig;
;                                    '"?")])
;   else sayKeyedMsg("S2IM0015",[op0,formatSignature sig])
;   $whereCacheList := [op,:$whereCacheList]
;
;   -- RSS: 6-21-94
;   -- The following code ensures that local variables really are local
;   -- to a function. We will unnecessarily generate preliminary LETs for
;   -- loop variables and variables that do have LET expressions, but that
;   -- can be finessed later.
;
;   locals := SETDIFFERENCE(COPY $localVars, parms)
;   if locals then
;     lets := [['LET, l, ''UNINITIALIZED__VARIABLE, op] for l in locals]
;     body := ['PROGN, :lets, body]
;
;   reportFunctionCompilation(op,fnName,parms,
;     wrapMapBodyWithCatch flattenCOND body,isRecursive)

(DEFUN |genMapCode| (|op| |body| |sig| |fnName| |parms| |isRecursive|)
  (PROG (|lmm| |n| |op0| |locals| |lets|)
    (RETURN
     (PROGN
      (COND
       ((SETQ |lmm| (|get| |op| '|localModemap| |$InteractiveFrame|))
        (|untraceMapSubNames| (LIST (CADAR |lmm|)))))
      (SETQ |op0|
              (COND
               ((SETQ |n| (|isSharpVarWithNum| |op|))
                (STRCONC "<argument " (|object2String| |n|) ">"))
               (#1='T |op|)))
      (COND
       ((|get| |op| '|isInterpreterRule| |$e|)
        (|sayKeyedMsg| 'S2IM0014
         (LIST |op0|
               (COND ((CONSP |sig|) (|prefix2String| (CAR |sig|)))
                     (#1# "?")))))
       (#1# (|sayKeyedMsg| 'S2IM0015 (LIST |op0| (|formatSignature| |sig|)))))
      (SETQ |$whereCacheList| (CONS |op| |$whereCacheList|))
      (SETQ |locals| (SETDIFFERENCE (COPY |$localVars|) |parms|))
      (COND
       (|locals|
        (SETQ |lets|
                ((LAMBDA (|bfVar#70| |bfVar#69| |l|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#69|)
                          (PROGN (SETQ |l| (CAR |bfVar#69|)) NIL))
                      (RETURN (NREVERSE |bfVar#70|)))
                     (#1#
                      (SETQ |bfVar#70|
                              (CONS
                               (LIST 'LET |l| ''UNINITIALIZED_VARIABLE |op|)
                               |bfVar#70|))))
                    (SETQ |bfVar#69| (CDR |bfVar#69|))))
                 NIL |locals| NIL))
        (SETQ |body| (CONS 'PROGN (APPEND |lets| (CONS |body| NIL))))))
      (|reportFunctionCompilation| |op| |fnName| |parms|
       (|wrapMapBodyWithCatch| (|flattenCOND| |body|)) |isRecursive|)))))

; compileBody(body,target) ==
;   -- recursively calls the interpreter on the map body
;   --  returns a triple with the LISP code for body in the value cell
;   $insideCompileBodyIfTrue: local := true
;   $genValue: local := false
;   $declaredMode:local := target
;   r := interpret1(body,target,nil)

(DEFUN |compileBody| (|body| |target|)
  (PROG (|$declaredMode| |$genValue| |$insideCompileBodyIfTrue| |r|)
    (DECLARE (SPECIAL |$declaredMode| |$genValue| |$insideCompileBodyIfTrue|))
    (RETURN
     (PROGN
      (SETQ |$insideCompileBodyIfTrue| T)
      (SETQ |$genValue| NIL)
      (SETQ |$declaredMode| |target|)
      (SETQ |r| (|interpret1| |body| |target| NIL))))))

; compileCoerceMap(op,argTypes,mm) ==
;   -- compiles call to user-declared map where the arguments need
;   --  to be coerced. mm is the modemap for the declared map.
;   $insideCompileBodyIfTrue: local := true
;   $genValue: local := false
;   [[.,:sig],imp,.]:= mm
;   parms := [var for var in $FormalMapVariableList for t in rest sig]
;   name := makeLocalModemap(op, [first sig, :argTypes])
;   argCode := [objVal(coerceInteractive(objNew(arg,t1),t2) or
;     throwKeyedMsg("S2IC0001",[arg,$mapName,t1,t2]))
;       for t1 in argTypes for t2 in rest sig for arg in parms]
;   $insideCompileBodyIfTrue := false
;   parms:= [:parms,'envArg]
;   body := ['SPADCALL,:argCode,['LIST,['function,imp]]]
;   minivectorName := makeInternalMapMinivectorName(name)
;   body := SUBST(minivectorName,"$$$",body)
;   SET(minivectorName,LIST2REFVEC $minivector)
;   compileInteractive [name,['LAMBDA,parms,body]]
;   first sig

(DEFUN |compileCoerceMap| (|op| |argTypes| |mm|)
  (PROG (|$genValue| |$insideCompileBodyIfTrue| |minivectorName| |body|
         |argCode| |name| |parms| |imp| |sig|)
    (DECLARE (SPECIAL |$genValue| |$insideCompileBodyIfTrue|))
    (RETURN
     (PROGN
      (SETQ |$insideCompileBodyIfTrue| T)
      (SETQ |$genValue| NIL)
      (SETQ |sig| (CDAR |mm|))
      (SETQ |imp| (CADR |mm|))
      (SETQ |parms|
              ((LAMBDA (|bfVar#73| |bfVar#71| |var| |bfVar#72| |t|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#71|)
                        (PROGN (SETQ |var| (CAR |bfVar#71|)) NIL)
                        (ATOM |bfVar#72|)
                        (PROGN (SETQ |t| (CAR |bfVar#72|)) NIL))
                    (RETURN (NREVERSE |bfVar#73|)))
                   (#1='T (SETQ |bfVar#73| (CONS |var| |bfVar#73|))))
                  (SETQ |bfVar#71| (CDR |bfVar#71|))
                  (SETQ |bfVar#72| (CDR |bfVar#72|))))
               NIL |$FormalMapVariableList| NIL (CDR |sig|) NIL))
      (SETQ |name| (|makeLocalModemap| |op| (CONS (CAR |sig|) |argTypes|)))
      (SETQ |argCode|
              ((LAMBDA
                   (|bfVar#77| |bfVar#74| |t1| |bfVar#75| |t2| |bfVar#76|
                    |arg|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#74|)
                        (PROGN (SETQ |t1| (CAR |bfVar#74|)) NIL)
                        (ATOM |bfVar#75|)
                        (PROGN (SETQ |t2| (CAR |bfVar#75|)) NIL)
                        (ATOM |bfVar#76|)
                        (PROGN (SETQ |arg| (CAR |bfVar#76|)) NIL))
                    (RETURN (NREVERSE |bfVar#77|)))
                   (#1#
                    (SETQ |bfVar#77|
                            (CONS
                             (|objVal|
                              (OR
                               (|coerceInteractive| (|objNew| |arg| |t1|) |t2|)
                               (|throwKeyedMsg| 'S2IC0001
                                (LIST |arg| |$mapName| |t1| |t2|))))
                             |bfVar#77|))))
                  (SETQ |bfVar#74| (CDR |bfVar#74|))
                  (SETQ |bfVar#75| (CDR |bfVar#75|))
                  (SETQ |bfVar#76| (CDR |bfVar#76|))))
               NIL |argTypes| NIL (CDR |sig|) NIL |parms| NIL))
      (SETQ |$insideCompileBodyIfTrue| NIL)
      (SETQ |parms| (APPEND |parms| (CONS '|envArg| NIL)))
      (SETQ |body|
              (CONS 'SPADCALL
                    (APPEND |argCode|
                            (CONS (LIST 'LIST (LIST '|function| |imp|)) NIL))))
      (SETQ |minivectorName| (|makeInternalMapMinivectorName| |name|))
      (SETQ |body| (SUBST |minivectorName| '$$$ |body|))
      (SET |minivectorName| (LIST2REFVEC |$minivector|))
      (|compileInteractive| (LIST |name| (LIST 'LAMBDA |parms| |body|)))
      (CAR |sig|)))))

; depthOfRecursion(opName,body) ==
;   -- returns the "depth" of recursive calls of opName in body
;   mapRecurDepth(opName, [nil], body)

(DEFUN |depthOfRecursion| (|opName| |body|)
  (PROG () (RETURN (|mapRecurDepth| |opName| (LIST NIL) |body|))))

; mapRecurDepth(opName,opList,body) ==
;   -- walks over the map body counting depth of recursive calls
;   --  expanding the bodies of maps called in body
;   atom body => 0
;   body is [op,:argl] =>
;     argc:=
;       atom argl => 0
;       argl => "MAX"/[mapRecurDepth(opName,opList,x) for x in argl]
;       0
;     op in first(opList) => argc
;     op=opName => 1 + argc
;     (obj := get(op, 'value, $e)) and objVal obj is ['SPADMAP, :mapDef] =>
;       opList.0 := [op, :first(opList)]
;       mapRecurDepth(opName, opList, getMapBody(op, mapDef))
;         + argc
;     argc
;   keyedSystemError("S2GE0016",['"mapRecurDepth",
;     '"unknown function form"])

(DEFUN |mapRecurDepth| (|opName| |opList| |body|)
  (PROG (|op| |argl| |argc| |obj| |ISTMP#1| |mapDef|)
    (RETURN
     (COND ((ATOM |body|) 0)
           ((AND (CONSP |body|)
                 (PROGN
                  (SETQ |op| (CAR |body|))
                  (SETQ |argl| (CDR |body|))
                  #1='T))
            (PROGN
             (SETQ |argc|
                     (COND ((ATOM |argl|) 0)
                           (|argl|
                            ((LAMBDA (|bfVar#79| |bfVar#78| |x|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#78|)
                                      (PROGN (SETQ |x| (CAR |bfVar#78|)) NIL))
                                  (RETURN |bfVar#79|))
                                 (#1#
                                  (SETQ |bfVar#79|
                                          (MAX |bfVar#79|
                                               (|mapRecurDepth| |opName|
                                                |opList| |x|)))))
                                (SETQ |bfVar#78| (CDR |bfVar#78|))))
                             -999999 |argl| NIL))
                           (#1# 0)))
             (COND ((|member| |op| (CAR |opList|)) |argc|)
                   ((EQUAL |op| |opName|) (+ 1 |argc|))
                   ((AND (SETQ |obj| (|get| |op| '|value| |$e|))
                         (PROGN
                          (SETQ |ISTMP#1| (|objVal| |obj|))
                          (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADMAP)
                               (PROGN (SETQ |mapDef| (CDR |ISTMP#1|)) #1#))))
                    (PROGN
                     (SETF (ELT |opList| 0) (CONS |op| (CAR |opList|)))
                     (+
                      (|mapRecurDepth| |opName| |opList|
                       (|getMapBody| |op| |mapDef|))
                      |argc|)))
                   (#1# |argc|))))
           (#1#
            (|keyedSystemError| 'S2GE0016
             (LIST "mapRecurDepth" "unknown function form")))))))

; analyzeUndeclaredMap(op,argTypes,mapDef,$mapList) ==
;   -- Computes the signature of the map named op, and compiles the body
;   $freeVars:local := NIL
;   $localVars: local := NIL
;   $env:local:= [[NIL]]
;   $mapList := [op,:$mapList]
;   parms:=[var for var in $FormalMapVariableList for m in argTypes]
;   for m in argTypes for var in parms repeat
;     put(var,'autoDeclare,'T,$env)
;     put(var,'mode,m,$env)
;   body:= getMapBody(op,mapDef)
;   for lvar in parms repeat mkLocalVar($mapName,lvar)
;   for lvar in getLocalVars(op,body) repeat mkLocalVar($mapName,lvar)
;   (n:= depthOfRecursion(op,body)) = 0 =>
;     analyzeNonRecursiveMap(op,argTypes,body,parms)
;   analyzeRecursiveMap(op,argTypes,body,parms,n)

(DEFUN |analyzeUndeclaredMap| (|op| |argTypes| |mapDef| |$mapList|)
  (DECLARE (SPECIAL |$mapList|))
  (PROG (|$env| |$localVars| |$freeVars| |n| |body| |parms|)
    (DECLARE (SPECIAL |$env| |$localVars| |$freeVars|))
    (RETURN
     (PROGN
      (SETQ |$freeVars| NIL)
      (SETQ |$localVars| NIL)
      (SETQ |$env| (LIST (LIST NIL)))
      (SETQ |$mapList| (CONS |op| |$mapList|))
      (SETQ |parms|
              ((LAMBDA (|bfVar#82| |bfVar#80| |var| |bfVar#81| |m|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#80|)
                        (PROGN (SETQ |var| (CAR |bfVar#80|)) NIL)
                        (ATOM |bfVar#81|)
                        (PROGN (SETQ |m| (CAR |bfVar#81|)) NIL))
                    (RETURN (NREVERSE |bfVar#82|)))
                   (#1='T (SETQ |bfVar#82| (CONS |var| |bfVar#82|))))
                  (SETQ |bfVar#80| (CDR |bfVar#80|))
                  (SETQ |bfVar#81| (CDR |bfVar#81|))))
               NIL |$FormalMapVariableList| NIL |argTypes| NIL))
      ((LAMBDA (|bfVar#83| |m| |bfVar#84| |var|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#83|) (PROGN (SETQ |m| (CAR |bfVar#83|)) NIL)
                (ATOM |bfVar#84|) (PROGN (SETQ |var| (CAR |bfVar#84|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (|put| |var| '|autoDeclare| 'T |$env|)
             (|put| |var| '|mode| |m| |$env|))))
          (SETQ |bfVar#83| (CDR |bfVar#83|))
          (SETQ |bfVar#84| (CDR |bfVar#84|))))
       |argTypes| NIL |parms| NIL)
      (SETQ |body| (|getMapBody| |op| |mapDef|))
      ((LAMBDA (|bfVar#85| |lvar|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#85|) (PROGN (SETQ |lvar| (CAR |bfVar#85|)) NIL))
            (RETURN NIL))
           (#1# (|mkLocalVar| |$mapName| |lvar|)))
          (SETQ |bfVar#85| (CDR |bfVar#85|))))
       |parms| NIL)
      ((LAMBDA (|bfVar#86| |lvar|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#86|) (PROGN (SETQ |lvar| (CAR |bfVar#86|)) NIL))
            (RETURN NIL))
           (#1# (|mkLocalVar| |$mapName| |lvar|)))
          (SETQ |bfVar#86| (CDR |bfVar#86|))))
       (|getLocalVars| |op| |body|) NIL)
      (COND
       ((EQL (SETQ |n| (|depthOfRecursion| |op| |body|)) 0)
        (|analyzeNonRecursiveMap| |op| |argTypes| |body| |parms|))
       (#1# (|analyzeRecursiveMap| |op| |argTypes| |body| |parms| |n|)))))))

; analyzeNonRecursiveMap(op,argTypes,body,parms) ==
;   -- analyze and compile a non-recursive map definition
;   T := compileBody(body,$mapTarget)
;   if $mapThrowCount > 0 then
;     t := objMode T
;     b := and/[(t = rt) for rt in $mapReturnTypes]
;     not b =>
;       t := resolveTypeListAny [t,:$mapReturnTypes]
;       if not $mapTarget then $mapTarget := t
;       T := compileBody(body,$mapTarget)
;   sig := [objMode T,:argTypes]
;   name:= makeLocalModemap(op,sig)
;   putMapCode(op,objVal T,sig,name,parms,false)
;   genMapCode(op,objVal T,sig,name,parms,false)
;   objMode(T)

(DEFUN |analyzeNonRecursiveMap| (|op| |argTypes| |body| |parms|)
  (PROG (T$ |t| |b| |sig| |name|)
    (RETURN
     (PROGN
      (SETQ T$ (|compileBody| |body| |$mapTarget|))
      (COND
       ((< 0 |$mapThrowCount|) (SETQ |t| (|objMode| T$))
        (SETQ |b|
                ((LAMBDA (|bfVar#88| |bfVar#87| |rt|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#87|)
                          (PROGN (SETQ |rt| (CAR |bfVar#87|)) NIL))
                      (RETURN |bfVar#88|))
                     ('T
                      (PROGN
                       (SETQ |bfVar#88| (EQUAL |t| |rt|))
                       (COND ((NOT |bfVar#88|) (RETURN NIL))))))
                    (SETQ |bfVar#87| (CDR |bfVar#87|))))
                 T |$mapReturnTypes| NIL))
        (COND
         ((NULL |b|)
          (PROGN
           (SETQ |t| (|resolveTypeListAny| (CONS |t| |$mapReturnTypes|)))
           (COND ((NULL |$mapTarget|) (SETQ |$mapTarget| |t|)))
           (SETQ T$ (|compileBody| |body| |$mapTarget|)))))))
      (SETQ |sig| (CONS (|objMode| T$) |argTypes|))
      (SETQ |name| (|makeLocalModemap| |op| |sig|))
      (|putMapCode| |op| (|objVal| T$) |sig| |name| |parms| NIL)
      (|genMapCode| |op| (|objVal| T$) |sig| |name| |parms| NIL)
      (|objMode| T$)))))

; analyzeRecursiveMap(op,argTypes,body,parms,n) ==
;   -- analyze and compile a non-recursive map definition
;   --  makes guess at signature by analyzing non-recursive part of body
;   --  then re-analyzes the entire body until the signature doesn't change
;   localMapInfo := saveDependentMapInfo(op, rest $mapList)
;   tar := CATCH('interpreter,analyzeNonRecur(op,body,$localVars))
;   for i in 0..n until not sigChanged repeat
;     sigChanged:= false
;     name := makeLocalModemap(op,sig:=[tar,:argTypes])
;     code := compileBody(body,$mapTarget)
;     objMode(code) ~= tar =>
;       sigChanged:= true
;       tar := objMode(code)
;       restoreDependentMapInfo(op, rest $mapList, localMapInfo)
;   sigChanged => throwKeyedMsg("S2IM0011",[op])
;   putMapCode(op,objVal code,sig,name,parms,true)
;   genMapCode(op,objVal code,sig,name,parms,true)
;   tar

(DEFUN |analyzeRecursiveMap| (|op| |argTypes| |body| |parms| |n|)
  (PROG (|localMapInfo| |tar| |sigChanged| |sig| |name| |code|)
    (RETURN
     (PROGN
      (SETQ |localMapInfo| (|saveDependentMapInfo| |op| (CDR |$mapList|)))
      (SETQ |tar|
              (CATCH '|interpreter|
                (|analyzeNonRecur| |op| |body| |$localVars|)))
      ((LAMBDA (|i| |bfVar#89|)
         (LOOP
          (COND ((OR (> |i| |n|) |bfVar#89|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |sigChanged| NIL)
                  (SETQ |name|
                          (|makeLocalModemap| |op|
                           (SETQ |sig| (CONS |tar| |argTypes|))))
                  (SETQ |code| (|compileBody| |body| |$mapTarget|))
                  (COND
                   ((NOT (EQUAL (|objMode| |code|) |tar|))
                    (PROGN
                     (SETQ |sigChanged| T)
                     (SETQ |tar| (|objMode| |code|))
                     (|restoreDependentMapInfo| |op| (CDR |$mapList|)
                      |localMapInfo|)))))))
          (SETQ |i| (+ |i| 1))
          (SETQ |bfVar#89| (NULL |sigChanged|))))
       0 NIL)
      (COND (|sigChanged| (|throwKeyedMsg| 'S2IM0011 (LIST |op|)))
            (#1#
             (PROGN
              (|putMapCode| |op| (|objVal| |code|) |sig| |name| |parms| T)
              (|genMapCode| |op| (|objVal| |code|) |sig| |name| |parms| T)
              |tar|)))))))

; saveDependentMapInfo(op,opList) ==
;   not (op in opList) =>
;     lmml := [[op, :get(op, 'localModemap, $e)]]
;     gcl := [[op, :get(op, 'generatedCode, $e)]]
;     for [dep1,dep2] in getFlag("$dependencies") | dep1=op repeat
;       [lmml', :gcl'] := saveDependentMapInfo(dep2, [op, :opList])
;       lmms := nconc(lmml', lmml)
;       gcl := nconc(gcl', gcl)
;     [lmms, :gcl]
;   nil

(DEFUN |saveDependentMapInfo| (|op| |opList|)
  (PROG (|lmml| |gcl| |dep1| |ISTMP#1| |dep2| |LETTMP#1| |lmml'| |gcl'| |lmms|)
    (RETURN
     (COND
      ((NULL (|member| |op| |opList|))
       (PROGN
        (SETQ |lmml| (LIST (CONS |op| (|get| |op| '|localModemap| |$e|))))
        (SETQ |gcl| (LIST (CONS |op| (|get| |op| '|generatedCode| |$e|))))
        ((LAMBDA (|bfVar#91| |bfVar#90|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#91|)
                  (PROGN (SETQ |bfVar#90| (CAR |bfVar#91|)) NIL))
              (RETURN NIL))
             (#1='T
              (AND (CONSP |bfVar#90|)
                   (PROGN
                    (SETQ |dep1| (CAR |bfVar#90|))
                    (SETQ |ISTMP#1| (CDR |bfVar#90|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |dep2| (CAR |ISTMP#1|)) #1#)))
                   (EQUAL |dep1| |op|)
                   (PROGN
                    (SETQ |LETTMP#1|
                            (|saveDependentMapInfo| |dep2|
                             (CONS |op| |opList|)))
                    (SETQ |lmml'| (CAR |LETTMP#1|))
                    (SETQ |gcl'| (CDR |LETTMP#1|))
                    (SETQ |lmms| (NCONC |lmml'| |lmml|))
                    (SETQ |gcl| (NCONC |gcl'| |gcl|))))))
            (SETQ |bfVar#91| (CDR |bfVar#91|))))
         (|getFlag| '|$dependencies|) NIL)
        (CONS |lmms| |gcl|)))
      (#1# NIL)))))

; restoreDependentMapInfo(op, opList, [lmml,:gcl]) ==
;   not (op in opList) =>
;     clearDependentMaps(op,opList)
;     for [op, :lmm] in lmml repeat
;       $e := putHist(op,'localModemap,lmm,$e)
;     for [op, :gc] in gcl repeat
;       $e := putHist(op,'generatedCode,gc,$e)

(DEFUN |restoreDependentMapInfo| (|op| |opList| |bfVar#96|)
  (PROG (|lmml| |gcl| |lmm| |gc|)
    (RETURN
     (PROGN
      (SETQ |lmml| (CAR |bfVar#96|))
      (SETQ |gcl| (CDR |bfVar#96|))
      (COND
       ((NULL (|member| |op| |opList|))
        (IDENTITY
         (PROGN
          (|clearDependentMaps| |op| |opList|)
          ((LAMBDA (|bfVar#93| |bfVar#92|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#93|)
                    (PROGN (SETQ |bfVar#92| (CAR |bfVar#93|)) NIL))
                (RETURN NIL))
               (#1='T
                (AND (CONSP |bfVar#92|)
                     (PROGN
                      (SETQ |op| (CAR |bfVar#92|))
                      (SETQ |lmm| (CDR |bfVar#92|))
                      #1#)
                     (SETQ |$e| (|putHist| |op| '|localModemap| |lmm| |$e|)))))
              (SETQ |bfVar#93| (CDR |bfVar#93|))))
           |lmml| NIL)
          ((LAMBDA (|bfVar#95| |bfVar#94|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#95|)
                    (PROGN (SETQ |bfVar#94| (CAR |bfVar#95|)) NIL))
                (RETURN NIL))
               (#1#
                (AND (CONSP |bfVar#94|)
                     (PROGN
                      (SETQ |op| (CAR |bfVar#94|))
                      (SETQ |gc| (CDR |bfVar#94|))
                      #1#)
                     (SETQ |$e| (|putHist| |op| '|generatedCode| |gc| |$e|)))))
              (SETQ |bfVar#95| (CDR |bfVar#95|))))
           |gcl| NIL)))))))))

; clearDependentMaps(op,opList) ==
;   -- clears the local modemaps of all the maps that depend on op
;   not (op in opList) =>
;     $e := putHist(op,'localModemap,nil,$e)
;     $e := putHist(op,'generatedCode,nil,$e)
;     for [dep1,dep2] in getFlag("$dependencies") | dep1=op repeat
;       clearDependentMaps(dep2,[op,:opList])

(DEFUN |clearDependentMaps| (|op| |opList|)
  (PROG (|dep1| |ISTMP#1| |dep2|)
    (RETURN
     (COND
      ((NULL (|member| |op| |opList|))
       (IDENTITY
        (PROGN
         (SETQ |$e| (|putHist| |op| '|localModemap| NIL |$e|))
         (SETQ |$e| (|putHist| |op| '|generatedCode| NIL |$e|))
         ((LAMBDA (|bfVar#98| |bfVar#97|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#98|)
                   (PROGN (SETQ |bfVar#97| (CAR |bfVar#98|)) NIL))
               (RETURN NIL))
              (#1='T
               (AND (CONSP |bfVar#97|)
                    (PROGN
                     (SETQ |dep1| (CAR |bfVar#97|))
                     (SETQ |ISTMP#1| (CDR |bfVar#97|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (PROGN (SETQ |dep2| (CAR |ISTMP#1|)) #1#)))
                    (EQUAL |dep1| |op|)
                    (|clearDependentMaps| |dep2| (CONS |op| |opList|)))))
             (SETQ |bfVar#98| (CDR |bfVar#98|))))
          (|getFlag| '|$dependencies|) NIL))))))))

; analyzeNonRecur(op,body,$localVars) ==
;   -- type analyze the non-recursive part of a map body
;   nrp := nonRecursivePart(op,body)
;   for lvar in findLocalVars(op,nrp) repeat mkLocalVar($mapName,lvar)
;   objMode(compileBody(nrp,$mapTarget))

(DEFUN |analyzeNonRecur| (|op| |body| |$localVars|)
  (DECLARE (SPECIAL |$localVars|))
  (PROG (|nrp|)
    (RETURN
     (PROGN
      (SETQ |nrp| (|nonRecursivePart| |op| |body|))
      ((LAMBDA (|bfVar#99| |lvar|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#99|) (PROGN (SETQ |lvar| (CAR |bfVar#99|)) NIL))
            (RETURN NIL))
           ('T (|mkLocalVar| |$mapName| |lvar|)))
          (SETQ |bfVar#99| (CDR |bfVar#99|))))
       (|findLocalVars| |op| |nrp|) NIL)
      (|objMode| (|compileBody| |nrp| |$mapTarget|))))))

; nonRecursivePart(opName, funBody) ==
;   -- takes funBody, which is the parse tree of the definition of
;   --  a function, and returns a list of the parts
;   --  of the function which are not recursive in the name opName
;   body:= expandRecursiveBody([opName], funBody)
;   ((nrp:=nonRecursivePart1(opName, body)) ~= 'noMapVal) => nrp
;   throwKeyedMsg("S2IM0012",[opName])

(DEFUN |nonRecursivePart| (|opName| |funBody|)
  (PROG (|body| |nrp|)
    (RETURN
     (PROGN
      (SETQ |body| (|expandRecursiveBody| (LIST |opName|) |funBody|))
      (COND
       ((NOT
         (EQ (SETQ |nrp| (|nonRecursivePart1| |opName| |body|)) '|noMapVal|))
        |nrp|)
       ('T (|throwKeyedMsg| 'S2IM0012 (LIST |opName|))))))))

; expandRecursiveBody(alreadyExpanded, body) ==
;   -- replaces calls to other maps with their bodies
;   atom body =>
;     (obj := get(body, 'value, $e)) and objVal obj is ['SPADMAP, :mapDef] and
;       ((numMapArgs mapDef) = 0) => getMapBody(body,mapDef)
;     body
;   body is [op,:argl] =>
;     not (op in alreadyExpanded) =>
;       (obj := get(op, 'value, $e)) and objVal obj is ['SPADMAP, :mapDef] =>
;         newBody:= getMapBody(op,mapDef)
;         for arg in argl for var in $FormalMapVariableList repeat
;             newBody := substitute(arg, var, newBody)
;         expandRecursiveBody([op,:alreadyExpanded],newBody)
;       [op,:[expandRecursiveBody(alreadyExpanded,arg) for arg in argl]]
;     [op,:[expandRecursiveBody(alreadyExpanded,arg) for arg in argl]]
;   keyedSystemError("S2GE0016",['"expandRecursiveBody",
;     '"unknown form of function body"])

(DEFUN |expandRecursiveBody| (|alreadyExpanded| |body|)
  (PROG (|obj| |ISTMP#1| |mapDef| |op| |argl| |newBody|)
    (RETURN
     (COND
      ((ATOM |body|)
       (COND
        ((AND (SETQ |obj| (|get| |body| '|value| |$e|))
              (PROGN
               (SETQ |ISTMP#1| (|objVal| |obj|))
               (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADMAP)
                    (PROGN (SETQ |mapDef| (CDR |ISTMP#1|)) #1='T)))
              (EQL (|numMapArgs| |mapDef|) 0))
         (|getMapBody| |body| |mapDef|))
        (#1# |body|)))
      ((AND (CONSP |body|)
            (PROGN (SETQ |op| (CAR |body|)) (SETQ |argl| (CDR |body|)) #1#))
       (COND
        ((NULL (|member| |op| |alreadyExpanded|))
         (COND
          ((AND (SETQ |obj| (|get| |op| '|value| |$e|))
                (PROGN
                 (SETQ |ISTMP#1| (|objVal| |obj|))
                 (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADMAP)
                      (PROGN (SETQ |mapDef| (CDR |ISTMP#1|)) #1#))))
           (PROGN
            (SETQ |newBody| (|getMapBody| |op| |mapDef|))
            ((LAMBDA (|bfVar#100| |arg| |bfVar#101| |var|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#100|)
                      (PROGN (SETQ |arg| (CAR |bfVar#100|)) NIL)
                      (ATOM |bfVar#101|)
                      (PROGN (SETQ |var| (CAR |bfVar#101|)) NIL))
                  (RETURN NIL))
                 (#1# (SETQ |newBody| (|substitute| |arg| |var| |newBody|))))
                (SETQ |bfVar#100| (CDR |bfVar#100|))
                (SETQ |bfVar#101| (CDR |bfVar#101|))))
             |argl| NIL |$FormalMapVariableList| NIL)
            (|expandRecursiveBody| (CONS |op| |alreadyExpanded|) |newBody|)))
          (#1#
           (CONS |op|
                 ((LAMBDA (|bfVar#103| |bfVar#102| |arg|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#102|)
                           (PROGN (SETQ |arg| (CAR |bfVar#102|)) NIL))
                       (RETURN (NREVERSE |bfVar#103|)))
                      (#1#
                       (SETQ |bfVar#103|
                               (CONS
                                (|expandRecursiveBody| |alreadyExpanded| |arg|)
                                |bfVar#103|))))
                     (SETQ |bfVar#102| (CDR |bfVar#102|))))
                  NIL |argl| NIL)))))
        (#1#
         (CONS |op|
               ((LAMBDA (|bfVar#105| |bfVar#104| |arg|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#104|)
                         (PROGN (SETQ |arg| (CAR |bfVar#104|)) NIL))
                     (RETURN (NREVERSE |bfVar#105|)))
                    (#1#
                     (SETQ |bfVar#105|
                             (CONS
                              (|expandRecursiveBody| |alreadyExpanded| |arg|)
                              |bfVar#105|))))
                   (SETQ |bfVar#104| (CDR |bfVar#104|))))
                NIL |argl| NIL)))))
      (#1#
       (|keyedSystemError| 'S2GE0016
        (LIST "expandRecursiveBody" "unknown form of function body")))))))

; nonRecursivePart1(opName, funBody) ==
;   -- returns a function body which contains only the parts of funBody
;   --  which do not call the function opName
;   funBody is ['IF,a,b,c] =>
;     nra:=nonRecursivePart1(opName,a)
;     nra = 'noMapVal => 'noMapVal
;     nrb:=nonRecursivePart1(opName,b)
;     nrc:=nonRecursivePart1(opName,c)
;     not (nrb in '(noMapVal noBranch)) => ['IF,nra,nrb,nrc]
;     not (nrc in '(noMapVal noBranch)) => ['IF,['not,nra],nrc,nrb]
;     'noMapVal
;   not containsOp(funBody,'IF) =>
;     notCalled(opName,funBody) => funBody
;     'noMapVal
;   funBody is [op,:argl] =>
;     op=opName => 'noMapVal
;     args:= [nonRecursivePart1(opName,arg) for arg in argl]
;     MEMQ('noMapVal,args) => 'noMapVal
;     [op,:args]
;   funBody

(DEFUN |nonRecursivePart1| (|opName| |funBody|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |ISTMP#3| |c| |nra| |nrb| |nrc| |op|
         |argl| |args|)
    (RETURN
     (COND
      ((AND (CONSP |funBody|) (EQ (CAR |funBody|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |funBody|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |b| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |c| (CAR |ISTMP#3|)) #1='T))))))))
       (PROGN
        (SETQ |nra| (|nonRecursivePart1| |opName| |a|))
        (COND ((EQ |nra| '|noMapVal|) '|noMapVal|)
              (#1#
               (PROGN
                (SETQ |nrb| (|nonRecursivePart1| |opName| |b|))
                (SETQ |nrc| (|nonRecursivePart1| |opName| |c|))
                (COND
                 ((NULL (|member| |nrb| '(|noMapVal| |noBranch|)))
                  (LIST 'IF |nra| |nrb| |nrc|))
                 ((NULL (|member| |nrc| '(|noMapVal| |noBranch|)))
                  (LIST 'IF (LIST '|not| |nra|) |nrc| |nrb|))
                 (#1# '|noMapVal|)))))))
      ((NULL (|containsOp| |funBody| 'IF))
       (COND ((|notCalled| |opName| |funBody|) |funBody|) (#1# '|noMapVal|)))
      ((AND (CONSP |funBody|)
            (PROGN
             (SETQ |op| (CAR |funBody|))
             (SETQ |argl| (CDR |funBody|))
             #1#))
       (COND ((EQUAL |op| |opName|) '|noMapVal|)
             (#1#
              (PROGN
               (SETQ |args|
                       ((LAMBDA (|bfVar#107| |bfVar#106| |arg|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#106|)
                                 (PROGN (SETQ |arg| (CAR |bfVar#106|)) NIL))
                             (RETURN (NREVERSE |bfVar#107|)))
                            (#1#
                             (SETQ |bfVar#107|
                                     (CONS (|nonRecursivePart1| |opName| |arg|)
                                           |bfVar#107|))))
                           (SETQ |bfVar#106| (CDR |bfVar#106|))))
                        NIL |argl| NIL))
               (COND ((MEMQ '|noMapVal| |args|) '|noMapVal|)
                     (#1# (CONS |op| |args|)))))))
      (#1# |funBody|)))))

; containsOp(body,op) ==
;   -- true IFF body contains an op statement
;   body is [ =op,:.] => true
;   body is [.,:argl] => or/[containsOp(arg,op) for arg in argl]
;   false

(DEFUN |containsOp| (|body| |op|)
  (PROG (|argl|)
    (RETURN
     (COND ((AND (CONSP |body|) (EQUAL (CAR |body|) |op|)) T)
           ((AND (CONSP |body|) (PROGN (SETQ |argl| (CDR |body|)) #1='T))
            ((LAMBDA (|bfVar#109| |bfVar#108| |arg|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#108|)
                      (PROGN (SETQ |arg| (CAR |bfVar#108|)) NIL))
                  (RETURN |bfVar#109|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#109| (|containsOp| |arg| |op|))
                   (COND (|bfVar#109| (RETURN |bfVar#109|))))))
                (SETQ |bfVar#108| (CDR |bfVar#108|))))
             NIL |argl| NIL))
           (#1# NIL)))))

; notCalled(opName,form) ==
;   -- returns true if opName is not called in the form
;   atom form => true
;   form is [op,:argl] =>
;     op=opName => false
;     and/[notCalled(opName,x) for x in argl]
;   keyedSystemError("S2GE0016",['"notCalled",
;     '"unknown form of function body"])

(DEFUN |notCalled| (|opName| |form|)
  (PROG (|op| |argl|)
    (RETURN
     (COND ((ATOM |form|) T)
           ((AND (CONSP |form|)
                 (PROGN
                  (SETQ |op| (CAR |form|))
                  (SETQ |argl| (CDR |form|))
                  #1='T))
            (COND ((EQUAL |op| |opName|) NIL)
                  (#1#
                   ((LAMBDA (|bfVar#111| |bfVar#110| |x|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#110|)
                             (PROGN (SETQ |x| (CAR |bfVar#110|)) NIL))
                         (RETURN |bfVar#111|))
                        (#1#
                         (PROGN
                          (SETQ |bfVar#111| (|notCalled| |opName| |x|))
                          (COND ((NOT |bfVar#111|) (RETURN NIL))))))
                       (SETQ |bfVar#110| (CDR |bfVar#110|))))
                    T |argl| NIL))))
           (#1#
            (|keyedSystemError| 'S2GE0016
             (LIST "notCalled" "unknown form of function body")))))))

; mapDefsWithCorrectArgCount(n, mapDef) ==
;   [def for def in mapDef | (numArgs first def) = n]

(DEFUN |mapDefsWithCorrectArgCount| (|n| |mapDef|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#113| |bfVar#112| |def|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#112|) (PROGN (SETQ |def| (CAR |bfVar#112|)) NIL))
           (RETURN (NREVERSE |bfVar#113|)))
          ('T
           (AND (EQUAL (|numArgs| (CAR |def|)) |n|)
                (SETQ |bfVar#113| (CONS |def| |bfVar#113|)))))
         (SETQ |bfVar#112| (CDR |bfVar#112|))))
      NIL |mapDef| NIL))))

; numMapArgs(mapDef is [[args,:.],:.]) ==
;   -- returns the number of arguments to the map whose body is mapDef
;   numArgs args

(DEFUN |numMapArgs| (|mapDef|)
  (PROG (|args|)
    (RETURN (PROGN (SETQ |args| (CAAR |mapDef|)) (|numArgs| |args|)))))

; numArgs args ==
;   args is ['_|,a,:.] => numArgs a
;   args is ['Tuple,:argl] => #argl
;   null args => 0
;   1

(DEFUN |numArgs| (|args|)
  (PROG (|ISTMP#1| |a| |argl|)
    (RETURN
     (COND
      ((AND (CONSP |args|) (EQ (CAR |args|) '|\||)
            (PROGN
             (SETQ |ISTMP#1| (CDR |args|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1='T))))
       (|numArgs| |a|))
      ((AND (CONSP |args|) (EQ (CAR |args|) '|Tuple|)
            (PROGN (SETQ |argl| (CDR |args|)) #1#))
       (LENGTH |argl|))
      ((NULL |args|) 0) (#1# 1)))))

; combineMapParts(mapTail) ==
;   -- transforms a piece-wise function definition into an if-then-else
;   --  statement.  Uses noBranch to indicate undefined branch
;   null mapTail => 'noMapVal
;   mapTail is [[cond,:part],:restMap] =>
;     isSharpVarWithNum cond or (cond is ['Tuple,:args] and
;       and/[isSharpVarWithNum arg for arg in args]) or (null cond) => part
;     ['IF,mkMapPred cond,part,combineMapParts restMap]
;   keyedSystemError("S2GE0016",['"combineMapParts",
;     '"unknown function form"])

(DEFUN |combineMapParts| (|mapTail|)
  (PROG (|ISTMP#1| |cond| |part| |restMap| |args|)
    (RETURN
     (COND ((NULL |mapTail|) '|noMapVal|)
           ((AND (CONSP |mapTail|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |mapTail|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |cond| (CAR |ISTMP#1|))
                        (SETQ |part| (CDR |ISTMP#1|))
                        #1='T)))
                 (PROGN (SETQ |restMap| (CDR |mapTail|)) #1#))
            (COND
             ((OR (|isSharpVarWithNum| |cond|)
                  (AND (CONSP |cond|) (EQ (CAR |cond|) '|Tuple|)
                       (PROGN (SETQ |args| (CDR |cond|)) #1#)
                       ((LAMBDA (|bfVar#115| |bfVar#114| |arg|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#114|)
                                 (PROGN (SETQ |arg| (CAR |bfVar#114|)) NIL))
                             (RETURN |bfVar#115|))
                            (#1#
                             (PROGN
                              (SETQ |bfVar#115| (|isSharpVarWithNum| |arg|))
                              (COND ((NOT |bfVar#115|) (RETURN NIL))))))
                           (SETQ |bfVar#114| (CDR |bfVar#114|))))
                        T |args| NIL))
                  (NULL |cond|))
              |part|)
             (#1#
              (LIST 'IF (|mkMapPred| |cond|) |part|
                    (|combineMapParts| |restMap|)))))
           (#1#
            (|keyedSystemError| 'S2GE0016
             (LIST "combineMapParts" "unknown function form")))))))

; mkMapPred cond ==
;   -- create the predicate on map arguments, derived from "when" clauses
;   cond is ['_|,args,pred] => mapPredTran pred
;   cond is ['Tuple,:vals] =>
;     mkValueCheck(vals,1)
;   mkValCheck(cond,1)

(DEFUN |mkMapPred| (|cond|)
  (PROG (|ISTMP#1| |args| |ISTMP#2| |pred| |vals|)
    (RETURN
     (COND
      ((AND (CONSP |cond|) (EQ (CAR |cond|) '|\||)
            (PROGN
             (SETQ |ISTMP#1| (CDR |cond|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |args| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |pred| (CAR |ISTMP#2|)) #1='T))))))
       (|mapPredTran| |pred|))
      ((AND (CONSP |cond|) (EQ (CAR |cond|) '|Tuple|)
            (PROGN (SETQ |vals| (CDR |cond|)) #1#))
       (|mkValueCheck| |vals| 1))
      (#1# (|mkValCheck| |cond| 1))))))

; mkValueCheck(vals,i) ==
;   -- creates predicate for specific value check (i.e f 1 == 1)
;   vals is [val] => mkValCheck(val,i)
;   ['and,mkValCheck(first vals,i),mkValueCheck(rest vals,i+1)]

(DEFUN |mkValueCheck| (|vals| |i|)
  (PROG (|val|)
    (RETURN
     (COND
      ((AND (CONSP |vals|) (EQ (CDR |vals|) NIL)
            (PROGN (SETQ |val| (CAR |vals|)) #1='T))
       (|mkValCheck| |val| |i|))
      (#1#
       (LIST '|and| (|mkValCheck| (CAR |vals|) |i|)
             (|mkValueCheck| (CDR |vals|) (+ |i| 1))))))))

; mkValCheck(val,i) ==
;   -- create equality check for map predicates
;   isSharpVarWithNum val => 'true
;   ['_=,mkSharpVar i,val]

(DEFUN |mkValCheck| (|val| |i|)
  (PROG ()
    (RETURN
     (COND ((|isSharpVarWithNum| |val|) '|true|)
           ('T (LIST '= (|mkSharpVar| |i|) |val|))))))

; mkSharpVar i ==
;   -- create #i
;   INTERN CONCAT('"#",STRINGIMAGE i)

(DEFUN |mkSharpVar| (|i|)
  (PROG () (RETURN (INTERN (CONCAT "#" (STRINGIMAGE |i|))))))

; mapPredTran pred ==
;   -- transforms "x in i..j" to "x>=i and x<=j"
;   pred is ["in", var, ['SEGMENT, lb]] => mkLessOrEqual(lb, var)
;   pred is ["in", var, ['SEGMENT, lb, ub]] =>
;     null ub => mkLessOrEqual(lb,var)
;     ['and,mkLessOrEqual(lb,var),mkLessOrEqual(var,ub)]
;   pred

(DEFUN |mapPredTran| (|pred|)
  (PROG (|ISTMP#1| |var| |ISTMP#2| |ISTMP#3| |ISTMP#4| |lb| |ISTMP#5| |ub|)
    (RETURN
     (COND
      ((AND (CONSP |pred|) (EQ (CAR |pred|) '|in|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |pred|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |var| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN
                         (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) 'SEGMENT)
                              (PROGN
                               (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                               (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                    (PROGN
                                     (SETQ |lb| (CAR |ISTMP#4|))
                                     #1='T))))))))))
       (|mkLessOrEqual| |lb| |var|))
      ((AND (CONSP |pred|) (EQ (CAR |pred|) '|in|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |pred|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |var| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN
                         (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) 'SEGMENT)
                              (PROGN
                               (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                               (AND (CONSP |ISTMP#4|)
                                    (PROGN
                                     (SETQ |lb| (CAR |ISTMP#4|))
                                     (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                     (AND (CONSP |ISTMP#5|)
                                          (EQ (CDR |ISTMP#5|) NIL)
                                          (PROGN
                                           (SETQ |ub| (CAR |ISTMP#5|))
                                           #1#))))))))))))
       (COND ((NULL |ub|) (|mkLessOrEqual| |lb| |var|))
             (#1#
              (LIST '|and| (|mkLessOrEqual| |lb| |var|)
                    (|mkLessOrEqual| |var| |ub|)))))
      (#1# |pred|)))))

; findLocalVars(op,form) ==
;   -- analyzes form for local and free variables, and returns the list
;   --  of locals
;   findLocalVars1(op,form)
;   $localVars

(DEFUN |findLocalVars| (|op| |form|)
  (PROG () (RETURN (PROGN (|findLocalVars1| |op| |form|) |$localVars|))))

; findLocalVars1(op,form) ==
;   -- sets the two lists $localVars and $freeVars
;   atom form =>
;     not IDENTP form or isSharpVarWithNum form => nil
;     isLocalVar(form) or isFreeVar(form) => nil
;     mkFreeVar($mapName,form)
;   form is ['local, :vars] =>
;     for x in vars repeat
;       ATOM x => mkLocalVar(op, x)
;   form is ['free, :vars] =>
;     for x in vars repeat
;       ATOM x => mkFreeVar(op, x)
;   form is ['LET,a,b] =>
;     (a is ['Tuple,:vars]) and (b is ['Tuple,:vals]) =>
;       for var in vars for val in vals repeat
;         findLocalVars1(op,['LET,var,val])
;     a is ['construct,:pat] =>
;       for var in listOfVariables pat repeat mkLocalVar(op,var)
;       findLocalVars1(op,b)
;     (atom a) or (a is ['_:,a,.]) =>
;       mkLocalVar(op,a)
;       findLocalVars1(op,b)
;     findLocalVars(op,b)
;     for x in a repeat findLocalVars1(op,x)
;   form is ['_:,a,.] =>
;     mkLocalVar(op,a)
;   form is ['is,l,pattern] =>
;     findLocalVars1(op,l)
;     for var in listOfVariables rest pattern repeat mkLocalVar(op, var)
;   form is [oper,:itrl,body] and MEMQ(oper,'(REPEAT COLLECT)) =>
;     findLocalsInLoop(op,itrl,body)
;   form is [y,:argl] =>
;     y is 'Record => nil
;     for x in argl repeat findLocalVars1(op,x)
;   keyedSystemError("S2IM0020",[op])

(DEFUN |findLocalVars1| (|op| |form|)
  (PROG (|vars| |ISTMP#1| |a| |ISTMP#2| |b| |vals| |pat| |l| |pattern| |oper|
         |body| |itrl| |y| |argl|)
    (RETURN
     (COND
      ((ATOM |form|)
       (COND ((OR (NULL (IDENTP |form|)) (|isSharpVarWithNum| |form|)) NIL)
             ((OR (|isLocalVar| |form|) (|isFreeVar| |form|)) NIL)
             (#1='T (|mkFreeVar| |$mapName| |form|))))
      ((AND (CONSP |form|) (EQ (CAR |form|) '|local|)
            (PROGN (SETQ |vars| (CDR |form|)) #1#))
       ((LAMBDA (|bfVar#116| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#116|) (PROGN (SETQ |x| (CAR |bfVar#116|)) NIL))
             (RETURN NIL))
            (#1# (COND ((ATOM |x|) (IDENTITY (|mkLocalVar| |op| |x|))))))
           (SETQ |bfVar#116| (CDR |bfVar#116|))))
        |vars| NIL))
      ((AND (CONSP |form|) (EQ (CAR |form|) '|free|)
            (PROGN (SETQ |vars| (CDR |form|)) #1#))
       ((LAMBDA (|bfVar#117| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#117|) (PROGN (SETQ |x| (CAR |bfVar#117|)) NIL))
             (RETURN NIL))
            (#1# (COND ((ATOM |x|) (IDENTITY (|mkFreeVar| |op| |x|))))))
           (SETQ |bfVar#117| (CDR |bfVar#117|))))
        |vars| NIL))
      ((AND (CONSP |form|) (EQ (CAR |form|) 'LET)
            (PROGN
             (SETQ |ISTMP#1| (CDR |form|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
       (COND
        ((AND (CONSP |a|) (EQ (CAR |a|) '|Tuple|)
              (PROGN (SETQ |vars| (CDR |a|)) #1#) (CONSP |b|)
              (EQ (CAR |b|) '|Tuple|) (PROGN (SETQ |vals| (CDR |b|)) #1#))
         ((LAMBDA (|bfVar#118| |var| |bfVar#119| |val|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#118|)
                   (PROGN (SETQ |var| (CAR |bfVar#118|)) NIL)
                   (ATOM |bfVar#119|)
                   (PROGN (SETQ |val| (CAR |bfVar#119|)) NIL))
               (RETURN NIL))
              (#1# (|findLocalVars1| |op| (LIST 'LET |var| |val|))))
             (SETQ |bfVar#118| (CDR |bfVar#118|))
             (SETQ |bfVar#119| (CDR |bfVar#119|))))
          |vars| NIL |vals| NIL))
        ((AND (CONSP |a|) (EQ (CAR |a|) '|construct|)
              (PROGN (SETQ |pat| (CDR |a|)) #1#))
         (PROGN
          ((LAMBDA (|bfVar#120| |var|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#120|)
                    (PROGN (SETQ |var| (CAR |bfVar#120|)) NIL))
                (RETURN NIL))
               (#1# (|mkLocalVar| |op| |var|)))
              (SETQ |bfVar#120| (CDR |bfVar#120|))))
           (|listOfVariables| |pat|) NIL)
          (|findLocalVars1| |op| |b|)))
        ((OR (ATOM |a|)
             (AND (CONSP |a|) (EQ (CAR |a|) '|:|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |a|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |a| (CAR |ISTMP#1|))
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)))))))
         (PROGN (|mkLocalVar| |op| |a|) (|findLocalVars1| |op| |b|)))
        (#1#
         (PROGN
          (|findLocalVars| |op| |b|)
          ((LAMBDA (|bfVar#121| |x|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#121|)
                    (PROGN (SETQ |x| (CAR |bfVar#121|)) NIL))
                (RETURN NIL))
               (#1# (|findLocalVars1| |op| |x|)))
              (SETQ |bfVar#121| (CDR |bfVar#121|))))
           |a| NIL)))))
      ((AND (CONSP |form|) (EQ (CAR |form|) '|:|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |form|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL))))))
       (|mkLocalVar| |op| |a|))
      ((AND (CONSP |form|) (EQ (CAR |form|) '|is|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |form|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |l| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |pattern| (CAR |ISTMP#2|)) #1#))))))
       (PROGN
        (|findLocalVars1| |op| |l|)
        ((LAMBDA (|bfVar#122| |var|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#122|)
                  (PROGN (SETQ |var| (CAR |bfVar#122|)) NIL))
              (RETURN NIL))
             (#1# (|mkLocalVar| |op| |var|)))
            (SETQ |bfVar#122| (CDR |bfVar#122|))))
         (|listOfVariables| (CDR |pattern|)) NIL)))
      ((AND (CONSP |form|)
            (PROGN
             (SETQ |oper| (CAR |form|))
             (SETQ |ISTMP#1| (CDR |form|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1#)
                  (CONSP |ISTMP#2|)
                  (PROGN
                   (SETQ |body| (CAR |ISTMP#2|))
                   (SETQ |itrl| (CDR |ISTMP#2|))
                   #1#)
                  (PROGN (SETQ |itrl| (NREVERSE |itrl|)) #1#)))
            (MEMQ |oper| '(REPEAT COLLECT)))
       (|findLocalsInLoop| |op| |itrl| |body|))
      ((AND (CONSP |form|)
            (PROGN (SETQ |y| (CAR |form|)) (SETQ |argl| (CDR |form|)) #1#))
       (COND ((EQ |y| '|Record|) NIL)
             (#1#
              ((LAMBDA (|bfVar#123| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#123|)
                        (PROGN (SETQ |x| (CAR |bfVar#123|)) NIL))
                    (RETURN NIL))
                   (#1# (|findLocalVars1| |op| |x|)))
                  (SETQ |bfVar#123| (CDR |bfVar#123|))))
               |argl| NIL))))
      (#1# (|keyedSystemError| 'S2IM0020 (LIST |op|)))))))

; findLocalsInLoop(op,itrl,body) ==
;   for it in itrl repeat
;     it is ['STEP,index,lower,step,:upperList] =>
;       mkLocalVar(op,index)
;       findLocalVars1(op,lower)
;       for up in upperList repeat findLocalVars1(op,up)
;     it is ['IN,index,s] =>
;       mkLocalVar(op,index) ; findLocalVars1(op,s)
;     it is ['WHILE,b] =>
;       findLocalVars1(op,b)
;     it is ['_|,pred] =>
;       findLocalVars1(op,pred)
;   findLocalVars1(op,body)
;   for it in itrl repeat
;     it is [op,b] and (op in '(UNTIL)) =>
;       findLocalVars1(op,b)

(DEFUN |findLocalsInLoop| (|op| |itrl| |body|)
  (PROG (|ISTMP#1| |index| |ISTMP#2| |lower| |ISTMP#3| |step| |upperList| |s|
         |b| |pred|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#124| |it|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#124|) (PROGN (SETQ |it| (CAR |bfVar#124|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((AND (CONSP |it|) (EQ (CAR |it|) 'STEP)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |it|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |index| (CAR |ISTMP#1|))
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|)
                               (PROGN
                                (SETQ |lower| (CAR |ISTMP#2|))
                                (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                (AND (CONSP |ISTMP#3|)
                                     (PROGN
                                      (SETQ |step| (CAR |ISTMP#3|))
                                      (SETQ |upperList| (CDR |ISTMP#3|))
                                      #1#))))))))
              (PROGN
               (|mkLocalVar| |op| |index|)
               (|findLocalVars1| |op| |lower|)
               ((LAMBDA (|bfVar#125| |up|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#125|)
                         (PROGN (SETQ |up| (CAR |bfVar#125|)) NIL))
                     (RETURN NIL))
                    (#1# (|findLocalVars1| |op| |up|)))
                   (SETQ |bfVar#125| (CDR |bfVar#125|))))
                |upperList| NIL)))
             (#1#
              (PROGN
               (COND
                ((AND (CONSP |it|) (EQ (CAR |it|) 'IN)
                      (PROGN
                       (SETQ |ISTMP#1| (CDR |it|))
                       (AND (CONSP |ISTMP#1|)
                            (PROGN
                             (SETQ |index| (CAR |ISTMP#1|))
                             (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                             (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                  (PROGN (SETQ |s| (CAR |ISTMP#2|)) #1#))))))
                 (|mkLocalVar| |op| |index|))
                (#1# (|findLocalVars1| |op| |s|)))
               (COND
                ((AND (CONSP |it|) (EQ (CAR |it|) 'WHILE)
                      (PROGN
                       (SETQ |ISTMP#1| (CDR |it|))
                       (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                            (PROGN (SETQ |b| (CAR |ISTMP#1|)) #1#))))
                 (|findLocalVars1| |op| |b|))
                ((AND (CONSP |it|) (EQ (CAR |it|) '|\||)
                      (PROGN
                       (SETQ |ISTMP#1| (CDR |it|))
                       (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                            (PROGN (SETQ |pred| (CAR |ISTMP#1|)) #1#))))
                 (|findLocalVars1| |op| |pred|))))))))
          (SETQ |bfVar#124| (CDR |bfVar#124|))))
       |itrl| NIL)
      (|findLocalVars1| |op| |body|)
      ((LAMBDA (|bfVar#126| |it|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#126|) (PROGN (SETQ |it| (CAR |bfVar#126|)) NIL))
            (RETURN NIL))
           (#1#
            (COND
             ((AND (CONSP |it|)
                   (PROGN
                    (SETQ |op| (CAR |it|))
                    (SETQ |ISTMP#1| (CDR |it|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |b| (CAR |ISTMP#1|)) #1#)))
                   (|member| |op| '(UNTIL)))
              (IDENTITY (|findLocalVars1| |op| |b|))))))
          (SETQ |bfVar#126| (CDR |bfVar#126|))))
       |itrl| NIL)))))

; isLocalVar(var) == member(var,$localVars)

(DEFUN |isLocalVar| (|var|) (PROG () (RETURN (|member| |var| |$localVars|))))

; mkLocalVar(op,var) ==
;   -- add var to the local variable list
;   isFreeVar(var) => $localVars
;   $localVars:= insert(var,$localVars)

(DEFUN |mkLocalVar| (|op| |var|)
  (PROG ()
    (RETURN
     (COND ((|isFreeVar| |var|) |$localVars|)
           ('T (SETQ |$localVars| (|insert| |var| |$localVars|)))))))

; isFreeVar(var) == member(var,$freeVars)

(DEFUN |isFreeVar| (|var|) (PROG () (RETURN (|member| |var| |$freeVars|))))

; mkFreeVar(op,var) ==
;   -- op here for symmetry with mkLocalVar
;   $freeVars:= insert(var,$freeVars)

(DEFUN |mkFreeVar| (|op| |var|)
  (PROG () (RETURN (SETQ |$freeVars| (|insert| |var| |$freeVars|)))))

; listOfVariables pat ==
;   -- return a list of the variables in pat, which is an "is" pattern
;   IDENTP pat => (pat='_. => nil ; [pat])
;   pat is ['_:,var] or pat is ['_=,var] =>
;     (var='_. => NIL ; [var])
;   PAIRP pat => REMDUP [:listOfVariables p for p in pat]
;   nil

(DEFUN |listOfVariables| (|pat|)
  (PROG (|ISTMP#1| |var|)
    (RETURN
     (COND ((IDENTP |pat|) (COND ((EQ |pat| '|.|) NIL) (#1='T (LIST |pat|))))
           ((OR
             (AND (CONSP |pat|) (EQ (CAR |pat|) '|:|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |pat|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#))))
             (AND (CONSP |pat|) (EQ (CAR |pat|) '=)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |pat|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ |var| (CAR |ISTMP#1|)) #1#)))))
            (COND ((EQ |var| '|.|) NIL) (#1# (LIST |var|))))
           ((CONSP |pat|)
            (REMDUP
             ((LAMBDA (|bfVar#128| |bfVar#127| |p|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#127|)
                       (PROGN (SETQ |p| (CAR |bfVar#127|)) NIL))
                   (RETURN (NREVERSE |bfVar#128|)))
                  (#1#
                   (SETQ |bfVar#128|
                           (APPEND (REVERSE (|listOfVariables| |p|))
                                   |bfVar#128|))))
                 (SETQ |bfVar#127| (CDR |bfVar#127|))))
              NIL |pat| NIL)))
           (#1# NIL)))))

; getMapBody(op,mapDef) ==
;   -- looks in $e for a map body; if not found it computes then stores it
;   get(op,'mapBody,$e) or
;     combineMapParts mapDef

(DEFUN |getMapBody| (|op| |mapDef|)
  (PROG ()
    (RETURN (OR (|get| |op| '|mapBody| |$e|) (|combineMapParts| |mapDef|)))))

; getLocalVars(op,body) ==
;   -- looks in $e for local vars; if not found, computes then stores them
;   get(op,'localVars,$e) or
;     $e:= putHist(op,'localVars,lv:=findLocalVars(op,body),$e)
;     lv

(DEFUN |getLocalVars| (|op| |body|)
  (PROG (|lv|)
    (RETURN
     (OR (|get| |op| '|localVars| |$e|)
         (PROGN
          (SETQ |$e|
                  (|putHist| |op| '|localVars|
                   (SETQ |lv| (|findLocalVars| |op| |body|)) |$e|))
          |lv|)))))

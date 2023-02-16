
; )package "BOOT"

(IN-PACKAGE "BOOT")

; compReduce(form,m,e) ==
;  compReduce1(form,m,e,$formalArgList)

(DEFUN |compReduce| (|form| |m| |e|)
  (PROG () (RETURN (|compReduce1| |form| |m| |e| |$formalArgList|))))

; compReduce1(form is ["REDUCE",op,.,collectForm],m,e,$formalArgList) ==
;   [collectOp,:itl,body]:= collectForm
;   if STRINGP op then op:= INTERN op
;   not MEMQ(collectOp,'(COLLECT COLLECTV COLLECTVEC)) =>
;         systemError ["illegal reduction form:",form]
;   $sideEffectsList: local := nil
;   $until: local := nil
;   $initList: local := nil
;   $endTestList: local := nil
;   itl := [([., e] := compIterator(x, e) or return "failed").(0) for x in itl]
;   itl="failed" => return nil
;   acc:= GENSYM()
;   afterFirst:= GENSYM()
;   bodyVal:= GENSYM()
;   [part1, m, e] := comp([":=", bodyVal, body], m, e) or return nil
;   [part2, ., e] := comp([":=", acc, bodyVal], m, e) or return nil
;   [part3, ., e] := comp([":=", acc, parseTran [op, acc, bodyVal]], m, e)
;                      or return nil
;   identityCode:=
;     id:= getIdentity(op,e) => u.expr where u() == comp(id,m,e) or return nil
;     ["IdentityError",MKQ op]
;   finalCode:=
;     ["PROGN",
;       ["LET",afterFirst,nil],
;        ["REPEAT",:itl,
;         ["PROGN",part1,
;           ["IF", afterFirst,part3,
;                    ["PROGN",part2,["LET",afterFirst,MKQ true]]]]],
;                     ["IF",afterFirst,acc,identityCode]]
;   if $until then
;     [untilCode,.,e]:= comp($until,$Boolean,e)
;     finalCode:= substitute(["UNTIL",untilCode],'$until,finalCode)
;   [finalCode,m,e]

(DEFUN |compReduce1| (|form| |m| |e| |$formalArgList|)
  (DECLARE (SPECIAL |$formalArgList|))
  (PROG (|$endTestList| |$initList| |$until| |$sideEffectsList| |untilCode|
         |finalCode| |identityCode| |id| |part3| |part2| |part1| |bodyVal|
         |afterFirst| |acc| |itl| |body| |LETTMP#1| |collectOp| |collectForm|
         |op|)
    (DECLARE (SPECIAL |$endTestList| |$initList| |$until| |$sideEffectsList|))
    (RETURN
     (PROGN
      (SETQ |op| (CADR . #1=(|form|)))
      (SETQ |collectForm| (CADDDR . #1#))
      (SETQ |collectOp| (CAR |collectForm|))
      (SETQ |LETTMP#1| (REVERSE (CDR |collectForm|)))
      (SETQ |body| (CAR |LETTMP#1|))
      (SETQ |itl| (NREVERSE (CDR |LETTMP#1|)))
      (COND ((STRINGP |op|) (SETQ |op| (INTERN |op|))))
      (COND
       ((NULL (MEMQ |collectOp| '(COLLECT COLLECTV COLLECTVEC)))
        (|systemError| (LIST '|illegal reduction form:| |form|)))
       (#2='T
        (PROGN
         (SETQ |$sideEffectsList| NIL)
         (SETQ |$until| NIL)
         (SETQ |$initList| NIL)
         (SETQ |$endTestList| NIL)
         (SETQ |itl|
                 ((LAMBDA (|bfVar#2| |bfVar#1| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#1|)
                           (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
                       (RETURN (NREVERSE |bfVar#2|)))
                      (#2#
                       (SETQ |bfVar#2|
                               (CONS
                                (ELT
                                 (PROGN
                                  (SETQ |LETTMP#1|
                                          (OR (|compIterator| |x| |e|)
                                              (RETURN '|failed|)))
                                  (SETQ |e| (CADR |LETTMP#1|))
                                  |LETTMP#1|)
                                 0)
                                |bfVar#2|))))
                     (SETQ |bfVar#1| (CDR |bfVar#1|))))
                  NIL |itl| NIL))
         (COND ((EQ |itl| '|failed|) (RETURN NIL))
               (#2#
                (PROGN
                 (SETQ |acc| (GENSYM))
                 (SETQ |afterFirst| (GENSYM))
                 (SETQ |bodyVal| (GENSYM))
                 (SETQ |LETTMP#1|
                         (OR (|comp| (LIST '|:=| |bodyVal| |body|) |m| |e|)
                             (RETURN NIL)))
                 (SETQ |part1| (CAR |LETTMP#1|))
                 (SETQ |m| (CADR . #3=(|LETTMP#1|)))
                 (SETQ |e| (CADDR . #3#))
                 (SETQ |LETTMP#1|
                         (OR (|comp| (LIST '|:=| |acc| |bodyVal|) |m| |e|)
                             (RETURN NIL)))
                 (SETQ |part2| (CAR |LETTMP#1|))
                 (SETQ |e| (CADDR |LETTMP#1|))
                 (SETQ |LETTMP#1|
                         (OR
                          (|comp|
                           (LIST '|:=| |acc|
                                 (|parseTran| (LIST |op| |acc| |bodyVal|)))
                           |m| |e|)
                          (RETURN NIL)))
                 (SETQ |part3| (CAR |LETTMP#1|))
                 (SETQ |e| (CADDR |LETTMP#1|))
                 (SETQ |identityCode|
                         (COND
                          ((SETQ |id| (|getIdentity| |op| |e|))
                           (CAR (OR (|comp| |id| |m| |e|) (RETURN NIL))))
                          (#2# (LIST '|IdentityError| (MKQ |op|)))))
                 (SETQ |finalCode|
                         (LIST 'PROGN (LIST 'LET |afterFirst| NIL)
                               (CONS 'REPEAT
                                     (APPEND |itl|
                                             (CONS
                                              (LIST 'PROGN |part1|
                                                    (LIST 'IF |afterFirst|
                                                          |part3|
                                                          (LIST 'PROGN |part2|
                                                                (LIST 'LET
                                                                      |afterFirst|
                                                                      (MKQ
                                                                       T)))))
                                              NIL)))
                               (LIST 'IF |afterFirst| |acc| |identityCode|)))
                 (COND
                  (|$until| (SETQ |LETTMP#1| (|comp| |$until| |$Boolean| |e|))
                   (SETQ |untilCode| (CAR |LETTMP#1|))
                   (SETQ |e| (CADDR |LETTMP#1|))
                   (SETQ |finalCode|
                           (|substitute| (LIST 'UNTIL |untilCode|) '|$until|
                            |finalCode|))))
                 (LIST |finalCode| |m| |e|)))))))))))

; $identity_list := [ _
;    ["+", ["Zero"]], _
;    ["*", ["One"]], _
;    ['gcd, ["Zero"]], _
;    ['lcm, ["One"]], _
;    ['append, ['construct]], _
;    ['union, ['construct]], _
;    ['strconc, '""], _
;    ['and, 'true], _
;    ['or, 'false]]

(EVAL-WHEN (EVAL LOAD)
  (SETQ |$identity_list|
          (LIST (LIST '+ (LIST '|Zero|)) (LIST '* (LIST '|One|))
                (LIST '|gcd| (LIST '|Zero|)) (LIST '|lcm| (LIST '|One|))
                (LIST '|append| (LIST '|construct|))
                (LIST '|union| (LIST '|construct|)) (LIST '|strconc| "")
                (LIST '|and| '|true|) (LIST '|or| '|false|))))

; getIdentity(x,e) ==
;     av := ASSQ(x, $identity_list)
;     av => av.1
;     nil

(DEFUN |getIdentity| (|x| |e|)
  (PROG (|av|)
    (RETURN
     (PROGN
      (SETQ |av| (ASSQ |x| |$identity_list|))
      (COND (|av| (ELT |av| 1)) ('T NIL))))))

; compRepeatOrCollect(form,m,e) ==
;   fn(form,[m,:$exitModeStack],[#$exitModeStack,:$leaveLevelStack],$formalArgList
;     ,e) where
;       fn(form,$exitModeStack,$leaveLevelStack,$formalArgList,e) ==
;         $iterate_tag : local := [MKQ(GENSYM())]
;         $iterate_count : local := 0
;         $until: local := nil
;         [repeatOrCollect,:itl,body]:= form
;         itl':=
;           [([x',e]:= compIterator(x,e) or return "failed"; x') for x in itl]
;         itl'="failed" => nil
;         targetMode:= first $exitModeStack
;         bodyMode:=
;           repeatOrCollect="COLLECT" =>
;             targetMode = '$EmptyMode => '$EmptyMode
;             (u:=modeIsAggregateOf('List,targetMode,e)) =>
;               CADR u
;             (u:=modeIsAggregateOf('PrimitiveArray,targetMode,e)) =>
;               repeatOrCollect:='COLLECTV
;               CADR u
;             (u:=modeIsAggregateOf('Vector,targetMode,e)) =>
;               repeatOrCollect:='COLLECTVEC
;               CADR u
;             stackMessage('"Invalid collect bodytype")
;             return nil
;             -- If we're doing a collect, and the type isn't conformable
;             -- then we've boobed. JHD 26.July.1990
;           $NoValueMode
;         [body',m',e']:=
;           -- (m1:= listOrVectorElementMode targetMode) and comp(body,m1,e) or
;             comp(body, bodyMode, e) or return nil
;         if $iterate_count > 0 then
;             body' := ['CATCH, first($iterate_tag), body']
;         if $until then
;           [untilCode,.,e']:= comp($until,$Boolean,e')
;           itl':= substitute(["UNTIL",untilCode],'$until,itl')
;         form':= [repeatOrCollect,:itl',body']
;         m'':=
;           repeatOrCollect="COLLECT" =>
;             (u := modeIsAggregateOf('List, targetMode, e)) => first u
;             ["List",m']
;           repeatOrCollect="COLLECTV" =>
;             (u := modeIsAggregateOf('PrimitiveArray, targetMode, e)) => first u
;             ["PrimitiveArray",m']
;           repeatOrCollect="COLLECTVEC" =>
;             (u := modeIsAggregateOf('Vector, targetMode, e)) => first u
;             ["Vector",m']
;           m'
;         coerceExit([form',m'',e'],targetMode)

(DEFUN |compRepeatOrCollect| (|form| |m| |e|)
  (PROG ()
    (RETURN
     (|compRepeatOrCollect,fn| |form| (CONS |m| |$exitModeStack|)
      (CONS (LENGTH |$exitModeStack|) |$leaveLevelStack|) |$formalArgList|
      |e|))))
(DEFUN |compRepeatOrCollect,fn|
       (|form| |$exitModeStack| |$leaveLevelStack| |$formalArgList| |e|)
  (DECLARE (SPECIAL |$exitModeStack| |$leaveLevelStack| |$formalArgList|))
  (PROG (|$until| |$iterate_count| |$iterate_tag| |m''| |form'| |untilCode|
         |e'| |m'| |body'| |bodyMode| |u| |targetMode| |itl'| |x'| |itl| |body|
         |LETTMP#1| |repeatOrCollect|)
    (DECLARE (SPECIAL |$until| |$iterate_count| |$iterate_tag|))
    (RETURN
     (PROGN
      (SETQ |$iterate_tag| (LIST (MKQ (GENSYM))))
      (SETQ |$iterate_count| 0)
      (SETQ |$until| NIL)
      (SETQ |repeatOrCollect| (CAR |form|))
      (SETQ |LETTMP#1| (REVERSE (CDR |form|)))
      (SETQ |body| (CAR |LETTMP#1|))
      (SETQ |itl| (NREVERSE (CDR |LETTMP#1|)))
      (SETQ |itl'|
              ((LAMBDA (|bfVar#4| |bfVar#3| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#3|)
                        (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL))
                    (RETURN (NREVERSE |bfVar#4|)))
                   (#1='T
                    (SETQ |bfVar#4|
                            (CONS
                             (PROGN
                              (SETQ |LETTMP#1|
                                      (OR (|compIterator| |x| |e|)
                                          (RETURN '|failed|)))
                              (SETQ |x'| (CAR |LETTMP#1|))
                              (SETQ |e| (CADR |LETTMP#1|))
                              |x'|)
                             |bfVar#4|))))
                  (SETQ |bfVar#3| (CDR |bfVar#3|))))
               NIL |itl| NIL))
      (COND ((EQ |itl'| '|failed|) NIL)
            (#1#
             (PROGN
              (SETQ |targetMode| (CAR |$exitModeStack|))
              (SETQ |bodyMode|
                      (COND
                       ((EQ |repeatOrCollect| 'COLLECT)
                        (COND ((EQ |targetMode| '|$EmptyMode|) '|$EmptyMode|)
                              ((SETQ |u|
                                       (|modeIsAggregateOf| '|List|
                                        |targetMode| |e|))
                               (CADR |u|))
                              ((SETQ |u|
                                       (|modeIsAggregateOf| '|PrimitiveArray|
                                        |targetMode| |e|))
                               (PROGN
                                (SETQ |repeatOrCollect| 'COLLECTV)
                                (CADR |u|)))
                              ((SETQ |u|
                                       (|modeIsAggregateOf| '|Vector|
                                        |targetMode| |e|))
                               (PROGN
                                (SETQ |repeatOrCollect| 'COLLECTVEC)
                                (CADR |u|)))
                              (#1#
                               (PROGN
                                (|stackMessage| "Invalid collect bodytype")
                                (RETURN NIL)))))
                       (#1# |$NoValueMode|)))
              (SETQ |LETTMP#1|
                      (OR (|comp| |body| |bodyMode| |e|) (RETURN NIL)))
              (SETQ |body'| (CAR |LETTMP#1|))
              (SETQ |m'| (CADR |LETTMP#1|))
              (SETQ |e'| (CADDR |LETTMP#1|))
              (COND
               ((< 0 |$iterate_count|)
                (SETQ |body'| (LIST 'CATCH (CAR |$iterate_tag|) |body'|))))
              (COND
               (|$until| (SETQ |LETTMP#1| (|comp| |$until| |$Boolean| |e'|))
                (SETQ |untilCode| (CAR |LETTMP#1|))
                (SETQ |e'| (CADDR |LETTMP#1|))
                (SETQ |itl'|
                        (|substitute| (LIST 'UNTIL |untilCode|) '|$until|
                         |itl'|))))
              (SETQ |form'|
                      (CONS |repeatOrCollect|
                            (APPEND |itl'| (CONS |body'| NIL))))
              (SETQ |m''|
                      (COND
                       ((EQ |repeatOrCollect| 'COLLECT)
                        (COND
                         ((SETQ |u|
                                  (|modeIsAggregateOf| '|List| |targetMode|
                                   |e|))
                          (CAR |u|))
                         (#1# (LIST '|List| |m'|))))
                       ((EQ |repeatOrCollect| 'COLLECTV)
                        (COND
                         ((SETQ |u|
                                  (|modeIsAggregateOf| '|PrimitiveArray|
                                   |targetMode| |e|))
                          (CAR |u|))
                         (#1# (LIST '|PrimitiveArray| |m'|))))
                       ((EQ |repeatOrCollect| 'COLLECTVEC)
                        (COND
                         ((SETQ |u|
                                  (|modeIsAggregateOf| '|Vector| |targetMode|
                                   |e|))
                          (CAR |u|))
                         (#1# (LIST '|Vector| |m'|))))
                       (#1# |m'|)))
              (|coerceExit| (LIST |form'| |m''| |e'|) |targetMode|))))))))

; listOrVectorElementMode x ==
;   x is [a,b,:.] and member(a,'(PrimitiveArray Vector List)) => b

(DEFUN |listOrVectorElementMode| (|x|)
  (PROG (|a| |ISTMP#1| |b|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |a| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |b| (CAR |ISTMP#1|)) 'T)))
            (|member| |a| '(|PrimitiveArray| |Vector| |List|)))
       (IDENTITY |b|))))))

; genLetHelper(op, arg, d, var) ==
;     form0 := [["elt", d, op], arg]
;     [":=", var, form0]

(DEFUN |genLetHelper| (|op| |arg| |d| |var|)
  (PROG (|form0|)
    (RETURN
     (PROGN
      (SETQ |form0| (LIST (LIST '|elt| |d| |op|) |arg|))
      (LIST '|:=| |var| |form0|)))))

; compInitGstep(y, ef, sf, mOver, e) ==
;     gvar := genSomeVariable()
;     [., ., e] := compMakeDeclaration([":", gvar, mOver], $EmptyMode, e)
;     form := ["SEQ", [":=", gvar, y],
;                     genLetHelper("emptyFun", gvar, mOver, ef),
;                        genLetHelper("stepFun", gvar, mOver, sf),
;                          ["exit", 1, 1]]
;     res := compSeq(form, $Integer, e)
;     res => res
;     nil

(DEFUN |compInitGstep| (|y| |ef| |sf| |mOver| |e|)
  (PROG (|gvar| |LETTMP#1| |form| |res|)
    (RETURN
     (PROGN
      (SETQ |gvar| (|genSomeVariable|))
      (SETQ |LETTMP#1|
              (|compMakeDeclaration| (LIST '|:| |gvar| |mOver|) |$EmptyMode|
               |e|))
      (SETQ |e| (CADDR |LETTMP#1|))
      (SETQ |form|
              (LIST 'SEQ (LIST '|:=| |gvar| |y|)
                    (|genLetHelper| '|emptyFun| |gvar| |mOver| |ef|)
                    (|genLetHelper| '|stepFun| |gvar| |mOver| |sf|)
                    (LIST '|exit| 1 1)))
      (SETQ |res| (|compSeq| |form| |$Integer| |e|))
      (COND (|res| |res|) ('T NIL))))))

; compIterator1(it, e) ==
;   it is ["IN",x,y] =>
;     --these two lines must be in this order, to get "for f in list f"
;     --to give  an error message if f is undefined
;     [y',m,e]:= comp(y,$EmptyMode,e) or return nil
;     $formalArgList:= [x,:$formalArgList]
;     ([mOver, mUnder] := modeIsAggregateOf("Generator", m, e)) =>
;         if null get(x,"mode",e) then
;             [.,.,e] := compMakeDeclaration([":",x,mUnder],$EmptyMode,e)
;                            or return nil
;         e:= put(x, "value", [genSomeVariable(), mUnder, e], e)
;         ef := genSomeVariable()
;         sf := genSomeVariable()
;         [y'', ., .] := compInitGstep(y, ef, sf, mOver, e) or return nil
;         res := ["GSTEP", x, ef, sf, y'']
;         SAY([res, mUnder])
;         [res, e]
;     [mOver, mUnder] :=
;       modeIsAggregateOf("List",m,e) or return
;          stackMessage ["mode: ",m," must be a list of some mode"]
;     if null get(x,"mode",e) then [.,.,e]:=
;       compMakeDeclaration([":",x,mUnder],$EmptyMode,e) or return nil
;     e:= put(x,"value",[genSomeVariable(),mUnder,e],e)
;     [y'',m'',e] := coerce([y',m,e], mOver) or return nil
;     [["IN",x,y''],e]
;   it is ["ON",x,y] =>
;     $formalArgList:= [x,:$formalArgList]
;     [y',m,e]:= comp(y,$EmptyMode,e) or return nil
;     [mOver,mUnder]:=
;       modeIsAggregateOf("List",m,e) or return
;         stackMessage ["mode: ",m," must be a list of other modes"]
;     if null get(x,"mode",e) then [.,.,e]:=
;       compMakeDeclaration([":",x,m],$EmptyMode,e) or return nil
;     e:= put(x,"value",[genSomeVariable(),m,e],e)
;     [y'',m'',e] := coerce([y',m,e], mOver) or return nil
;     [["ON",x,y''],e]
;   it is ["STEP",index,start,inc,:optFinal] =>
;     $formalArgList:= [index,:$formalArgList]
;     --if all start/inc/end compile as small integers, then loop
;     --is compiled as a small integer loop
;     final':= nil
;     (start' := comp(start, $SingleInteger, e)) and
;       (inc':= comp(inc,$NonNegativeInteger,start'.env)) and
;         (not (optFinal is [final]) or
;           (final' := comp(final, $SingleInteger, inc'.env))) =>
;             indexmode:=
;               comp(start,$NonNegativeInteger,e) =>
;                       $NonNegativeInteger
;               $SingleInteger
;             if null get(index,"mode",e) then [.,.,e]:=
;               compMakeDeclaration([":",index,indexmode],$EmptyMode,
;                 (final' => final'.env; inc'.env)) or return nil
;             e:= put(index,"value",[genSomeVariable(),indexmode,e],e)
;             if final' then optFinal:= [final'.expr]
;             [["ISTEP",index,start'.expr,inc'.expr,:optFinal],e]
;     [start,.,e]:=
;       comp(start,$Integer,e) or return
;         stackMessage ["start value of index: ",start," must be an integer"]
;     [inc,.,e]:=
;       comp(inc,$Integer,e) or return
;         stackMessage ["index increment:",inc," must be an integer"]
;     if optFinal is [final] then
;       [final,.,e]:=
;         comp(final,$Integer,e) or return
;           stackMessage ["final value of index: ",final," must be an integer"]
;       optFinal:= [final]
;     indexmode:=
;       comp(CADDR it,$NonNegativeInteger,e) => $NonNegativeInteger
;       $Integer
;     if null get(index,"mode",e) then [.,.,e]:=
;       compMakeDeclaration([":",index,indexmode],$EmptyMode,e) or return nil
;     e:= put(index,"value",[genSomeVariable(),indexmode,e],e)
;     [["STEP",index,start,inc,:optFinal],e]
;   it is ["WHILE",p] =>
;     [p',m,e]:=
;       comp(p,$Boolean,e) or return
;         stackMessage ["WHILE operand: ",p," is not Boolean valued"]
;     [["WHILE",p'],e]
;   it is ["UNTIL",p] => ($until:= p; ['$until,e])
;   it is ["|",x] =>
;     u:=
;       comp(x,$Boolean,e) or return
;         stackMessage ["SUCHTHAT operand: ",x," is not Boolean value"]
;     [["|",u.expr],u.env]
;   nil

(DEFUN |compIterator1| (|it| |e|)
  (PROG (|ISTMP#1| |x| |ISTMP#2| |y| |LETTMP#1| |y'| |m| |mOver| |mUnder| |ef|
         |sf| |y''| |res| |m''| |index| |start| |ISTMP#3| |inc| |optFinal|
         |final'| |start'| |inc'| |final| |indexmode| |p| |p'| |u|)
    (RETURN
     (COND
      ((AND (CONSP |it|) (EQ (CAR |it|) 'IN)
            (PROGN
             (SETQ |ISTMP#1| (CDR |it|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |x| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1='T))))))
       (PROGN
        (SETQ |LETTMP#1| (OR (|comp| |y| |$EmptyMode| |e|) (RETURN NIL)))
        (SETQ |y'| (CAR |LETTMP#1|))
        (SETQ |m| (CADR . #2=(|LETTMP#1|)))
        (SETQ |e| (CADDR . #2#))
        (SETQ |$formalArgList| (CONS |x| |$formalArgList|))
        (COND
         ((PROGN
           (SETQ |LETTMP#1| (|modeIsAggregateOf| '|Generator| |m| |e|))
           (SETQ |mOver| (CAR |LETTMP#1|))
           (SETQ |mUnder| (CADR |LETTMP#1|))
           |LETTMP#1|)
          (PROGN
           (COND
            ((NULL (|get| |x| '|mode| |e|))
             (SETQ |LETTMP#1|
                     (OR
                      (|compMakeDeclaration| (LIST '|:| |x| |mUnder|)
                       |$EmptyMode| |e|)
                      (RETURN NIL)))
             (SETQ |e| (CADDR |LETTMP#1|)) |LETTMP#1|))
           (SETQ |e|
                   (|put| |x| '|value| (LIST (|genSomeVariable|) |mUnder| |e|)
                    |e|))
           (SETQ |ef| (|genSomeVariable|))
           (SETQ |sf| (|genSomeVariable|))
           (SETQ |LETTMP#1|
                   (OR (|compInitGstep| |y| |ef| |sf| |mOver| |e|)
                       (RETURN NIL)))
           (SETQ |y''| (CAR |LETTMP#1|))
           (SETQ |res| (LIST 'GSTEP |x| |ef| |sf| |y''|))
           (SAY (LIST |res| |mUnder|))
           (LIST |res| |e|)))
         (#1#
          (PROGN
           (SETQ |LETTMP#1|
                   (OR (|modeIsAggregateOf| '|List| |m| |e|)
                       (RETURN
                        (|stackMessage|
                         (LIST '|mode: | |m|
                               '| must be a list of some mode|)))))
           (SETQ |mOver| (CAR |LETTMP#1|))
           (SETQ |mUnder| (CADR |LETTMP#1|))
           (COND
            ((NULL (|get| |x| '|mode| |e|))
             (SETQ |LETTMP#1|
                     (OR
                      (|compMakeDeclaration| (LIST '|:| |x| |mUnder|)
                       |$EmptyMode| |e|)
                      (RETURN NIL)))
             (SETQ |e| (CADDR |LETTMP#1|)) |LETTMP#1|))
           (SETQ |e|
                   (|put| |x| '|value| (LIST (|genSomeVariable|) |mUnder| |e|)
                    |e|))
           (SETQ |LETTMP#1|
                   (OR (|coerce| (LIST |y'| |m| |e|) |mOver|) (RETURN NIL)))
           (SETQ |y''| (CAR |LETTMP#1|))
           (SETQ |m''| (CADR . #3=(|LETTMP#1|)))
           (SETQ |e| (CADDR . #3#))
           (LIST (LIST 'IN |x| |y''|) |e|))))))
      ((AND (CONSP |it|) (EQ (CAR |it|) 'ON)
            (PROGN
             (SETQ |ISTMP#1| (CDR |it|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |x| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1#))))))
       (PROGN
        (SETQ |$formalArgList| (CONS |x| |$formalArgList|))
        (SETQ |LETTMP#1| (OR (|comp| |y| |$EmptyMode| |e|) (RETURN NIL)))
        (SETQ |y'| (CAR |LETTMP#1|))
        (SETQ |m| (CADR . #4=(|LETTMP#1|)))
        (SETQ |e| (CADDR . #4#))
        (SETQ |LETTMP#1|
                (OR (|modeIsAggregateOf| '|List| |m| |e|)
                    (RETURN
                     (|stackMessage|
                      (LIST '|mode: | |m|
                            '| must be a list of other modes|)))))
        (SETQ |mOver| (CAR |LETTMP#1|))
        (SETQ |mUnder| (CADR |LETTMP#1|))
        (COND
         ((NULL (|get| |x| '|mode| |e|))
          (SETQ |LETTMP#1|
                  (OR
                   (|compMakeDeclaration| (LIST '|:| |x| |m|) |$EmptyMode| |e|)
                   (RETURN NIL)))
          (SETQ |e| (CADDR |LETTMP#1|)) |LETTMP#1|))
        (SETQ |e| (|put| |x| '|value| (LIST (|genSomeVariable|) |m| |e|) |e|))
        (SETQ |LETTMP#1|
                (OR (|coerce| (LIST |y'| |m| |e|) |mOver|) (RETURN NIL)))
        (SETQ |y''| (CAR |LETTMP#1|))
        (SETQ |m''| (CADR . #5=(|LETTMP#1|)))
        (SETQ |e| (CADDR . #5#))
        (LIST (LIST 'ON |x| |y''|) |e|)))
      ((AND (CONSP |it|) (EQ (CAR |it|) 'STEP)
            (PROGN
             (SETQ |ISTMP#1| (CDR |it|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |index| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |start| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|)
                              (PROGN
                               (SETQ |inc| (CAR |ISTMP#3|))
                               (SETQ |optFinal| (CDR |ISTMP#3|))
                               #1#))))))))
       (PROGN
        (SETQ |$formalArgList| (CONS |index| |$formalArgList|))
        (SETQ |final'| NIL)
        (COND
         ((AND (SETQ |start'| (|comp| |start| |$SingleInteger| |e|))
               (SETQ |inc'|
                       (|comp| |inc| |$NonNegativeInteger| (CADDR |start'|)))
               (OR
                (NULL
                 (AND (CONSP |optFinal|) (EQ (CDR |optFinal|) NIL)
                      (PROGN (SETQ |final| (CAR |optFinal|)) #1#)))
                (SETQ |final'|
                        (|comp| |final| |$SingleInteger| (CADDR |inc'|)))))
          (PROGN
           (SETQ |indexmode|
                   (COND
                    ((|comp| |start| |$NonNegativeInteger| |e|)
                     |$NonNegativeInteger|)
                    (#1# |$SingleInteger|)))
           (COND
            ((NULL (|get| |index| '|mode| |e|))
             (SETQ |LETTMP#1|
                     (OR
                      (|compMakeDeclaration| (LIST '|:| |index| |indexmode|)
                       |$EmptyMode|
                       (COND (|final'| (CADDR |final'|)) (#1# (CADDR |inc'|))))
                      (RETURN NIL)))
             (SETQ |e| (CADDR |LETTMP#1|)) |LETTMP#1|))
           (SETQ |e|
                   (|put| |index| '|value|
                    (LIST (|genSomeVariable|) |indexmode| |e|) |e|))
           (COND (|final'| (SETQ |optFinal| (LIST (CAR |final'|)))))
           (LIST
            (CONS 'ISTEP
                  (CONS |index|
                        (CONS (CAR |start'|) (CONS (CAR |inc'|) |optFinal|))))
            |e|)))
         (#1#
          (PROGN
           (SETQ |LETTMP#1|
                   (OR (|comp| |start| |$Integer| |e|)
                       (RETURN
                        (|stackMessage|
                         (LIST '|start value of index: | |start|
                               '| must be an integer|)))))
           (SETQ |start| (CAR |LETTMP#1|))
           (SETQ |e| (CADDR |LETTMP#1|))
           (SETQ |LETTMP#1|
                   (OR (|comp| |inc| |$Integer| |e|)
                       (RETURN
                        (|stackMessage|
                         (LIST '|index increment:| |inc|
                               '| must be an integer|)))))
           (SETQ |inc| (CAR |LETTMP#1|))
           (SETQ |e| (CADDR |LETTMP#1|))
           (COND
            ((AND (CONSP |optFinal|) (EQ (CDR |optFinal|) NIL)
                  (PROGN (SETQ |final| (CAR |optFinal|)) #1#))
             (SETQ |LETTMP#1|
                     (OR (|comp| |final| |$Integer| |e|)
                         (RETURN
                          (|stackMessage|
                           (LIST '|final value of index: | |final|
                                 '| must be an integer|)))))
             (SETQ |final| (CAR |LETTMP#1|)) (SETQ |e| (CADDR |LETTMP#1|))
             (SETQ |optFinal| (LIST |final|))))
           (SETQ |indexmode|
                   (COND
                    ((|comp| (CADDR |it|) |$NonNegativeInteger| |e|)
                     |$NonNegativeInteger|)
                    (#1# |$Integer|)))
           (COND
            ((NULL (|get| |index| '|mode| |e|))
             (SETQ |LETTMP#1|
                     (OR
                      (|compMakeDeclaration| (LIST '|:| |index| |indexmode|)
                       |$EmptyMode| |e|)
                      (RETURN NIL)))
             (SETQ |e| (CADDR |LETTMP#1|)) |LETTMP#1|))
           (SETQ |e|
                   (|put| |index| '|value|
                    (LIST (|genSomeVariable|) |indexmode| |e|) |e|))
           (LIST
            (CONS 'STEP (CONS |index| (CONS |start| (CONS |inc| |optFinal|))))
            |e|))))))
      ((AND (CONSP |it|) (EQ (CAR |it|) 'WHILE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |it|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |p| (CAR |ISTMP#1|)) #1#))))
       (PROGN
        (SETQ |LETTMP#1|
                (OR (|comp| |p| |$Boolean| |e|)
                    (RETURN
                     (|stackMessage|
                      (LIST '|WHILE operand: | |p|
                            '| is not Boolean valued|)))))
        (SETQ |p'| (CAR |LETTMP#1|))
        (SETQ |m| (CADR . #6=(|LETTMP#1|)))
        (SETQ |e| (CADDR . #6#))
        (LIST (LIST 'WHILE |p'|) |e|)))
      ((AND (CONSP |it|) (EQ (CAR |it|) 'UNTIL)
            (PROGN
             (SETQ |ISTMP#1| (CDR |it|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |p| (CAR |ISTMP#1|)) #1#))))
       (PROGN (SETQ |$until| |p|) (LIST '|$until| |e|)))
      ((AND (CONSP |it|) (EQ (CAR |it|) '|\||)
            (PROGN
             (SETQ |ISTMP#1| (CDR |it|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |x| (CAR |ISTMP#1|)) #1#))))
       (PROGN
        (SETQ |u|
                (OR (|comp| |x| |$Boolean| |e|)
                    (RETURN
                     (|stackMessage|
                      (LIST '|SUCHTHAT operand: | |x|
                            '| is not Boolean value|)))))
        (LIST (LIST '|\|| (CAR |u|)) (CADDR |u|))))
      (#1# NIL)))))

; match_segment(i, n) ==
;     n is ['SEGMENT,a] => ['STEP,i,a,1]
;     n is ['SEGMENT, a, b] => (b => ['STEP, i, a, 1, b]; ['STEP, i, a, 1])
;     ['IN, i, n]

(DEFUN |match_segment| (|i| |n|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (COND
      ((AND (CONSP |n|) (EQ (CAR |n|) 'SEGMENT)
            (PROGN
             (SETQ |ISTMP#1| (CDR |n|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1='T))))
       (LIST 'STEP |i| |a| 1))
      ((AND (CONSP |n|) (EQ (CAR |n|) 'SEGMENT)
            (PROGN
             (SETQ |ISTMP#1| (CDR |n|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1#))))))
       (COND (|b| (LIST 'STEP |i| |a| 1 |b|)) (#1# (LIST 'STEP |i| |a| 1))))
      (#1# (LIST 'IN |i| |n|))))))

; compIterator(it, e) ==
;     it is ["INBY", i, n, inc] =>
;         u := match_segment(i, n)
;         u isnt ['STEP, i, a, 1, :r] =>
;             stackAndThrow ["   You cannot use", "%b", "by", "%d",
;                       "except for an explicitly indexed sequence."]
;         compIterator1(['STEP, i, a, inc, :r], e)
;     it is ["IN", i, n] =>
;         compIterator1(match_segment(i, n), e)
;     compIterator1(it, e)

(DEFUN |compIterator| (|it| |e|)
  (PROG (|ISTMP#1| |i| |ISTMP#2| |n| |ISTMP#3| |inc| |u| |a| |r|)
    (RETURN
     (COND
      ((AND (CONSP |it|) (EQ (CAR |it|) 'INBY)
            (PROGN
             (SETQ |ISTMP#1| (CDR |it|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |i| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |n| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |inc| (CAR |ISTMP#3|)) #1='T))))))))
       (PROGN
        (SETQ |u| (|match_segment| |i| |n|))
        (COND
         ((NOT
           (AND (CONSP |u|) (EQ (CAR |u|) 'STEP)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |u|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |i| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|)
                            (PROGN
                             (SETQ |a| (CAR |ISTMP#2|))
                             (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                             (AND (CONSP |ISTMP#3|) (EQUAL (CAR |ISTMP#3|) 1)
                                  (PROGN
                                   (SETQ |r| (CDR |ISTMP#3|))
                                   #1#)))))))))
          (|stackAndThrow|
           (LIST '|   You cannot use| '|%b| '|by| '|%d|
                 '|except for an explicitly indexed sequence.|)))
         (#1#
          (|compIterator1| (CONS 'STEP (CONS |i| (CONS |a| (CONS |inc| |r|))))
           |e|)))))
      ((AND (CONSP |it|) (EQ (CAR |it|) 'IN)
            (PROGN
             (SETQ |ISTMP#1| (CDR |it|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |i| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |n| (CAR |ISTMP#2|)) #1#))))))
       (|compIterator1| (|match_segment| |i| |n|) |e|))
      (#1# (|compIterator1| |it| |e|))))))

; modeIsAggregateOf(ListOrVector,m,e) ==
;   m is [ =ListOrVector,R] => [m,R]
; --m = '$EmptyMode => [m,m] I don't think this is correct, breaks POLY +
;   m is ["Union",:l] =>
;     mList:= [pair for m' in l | (pair:= modeIsAggregateOf(ListOrVector,m',e))]
;     1=#mList => first mList
;   name:=
;     m is [fn,:.] => fn
;     m="$" => "Rep"
;     m
;   get(name,"value",e) is [[ =ListOrVector,R],:.] => [m,R]

(DEFUN |modeIsAggregateOf| (|ListOrVector| |m| |e|)
  (PROG (|ISTMP#1| R |l| |pair| |mList| |fn| |name| |ISTMP#2| |ISTMP#3|)
    (RETURN
     (COND
      ((AND (CONSP |m|) (EQUAL (CAR |m|) |ListOrVector|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |m|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ R (CAR |ISTMP#1|)) #1='T))))
       (LIST |m| R))
      ((AND (CONSP |m|) (EQ (CAR |m|) '|Union|)
            (PROGN (SETQ |l| (CDR |m|)) #1#))
       (PROGN
        (SETQ |mList|
                ((LAMBDA (|bfVar#6| |bfVar#5| |m'|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#5|)
                          (PROGN (SETQ |m'| (CAR |bfVar#5|)) NIL))
                      (RETURN (NREVERSE |bfVar#6|)))
                     (#1#
                      (AND
                       (SETQ |pair|
                               (|modeIsAggregateOf| |ListOrVector| |m'| |e|))
                       (SETQ |bfVar#6| (CONS |pair| |bfVar#6|)))))
                    (SETQ |bfVar#5| (CDR |bfVar#5|))))
                 NIL |l| NIL))
        (COND ((EQL 1 (LENGTH |mList|)) (CAR |mList|)))))
      (#1#
       (PROGN
        (SETQ |name|
                (COND
                 ((AND (CONSP |m|) (PROGN (SETQ |fn| (CAR |m|)) #1#)) |fn|)
                 ((EQ |m| '$) '|Rep|) (#1# |m|)))
        (COND
         ((PROGN
           (SETQ |ISTMP#1| (|get| |name| '|value| |e|))
           (AND (CONSP |ISTMP#1|)
                (PROGN
                 (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                 (AND (CONSP |ISTMP#2|) (EQUAL (CAR |ISTMP#2|) |ListOrVector|)
                      (PROGN
                       (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                       (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                            (PROGN (SETQ R (CAR |ISTMP#3|)) #1#)))))))
          (LIST |m| R)))))))))

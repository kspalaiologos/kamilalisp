
; )package "BOOT"

(IN-PACKAGE "BOOT")

; oldCompilerAutoloadOnceTrigger() == nil

(DEFUN |oldCompilerAutoloadOnceTrigger| () (PROG () (RETURN NIL)))

; compAtomWithModemap(x, m, e, v) ==
;     res := nil
;     v1 := nil
;     while not res for map in v | map is [[.,target],[.,fn]] repeat
;         ATOM(fn) => "iterate"
;         not(modeEqual(m, target)) => v1 := cons(map, v1)
;         -- try exact match
;         [[md, mr], :fnsel] := map
;         compMapCond(x, md, [], fnsel, e) =>
;             res := trans_delta(genDeltaEntry([x, :map], e), target, e)
;         v1 := cons(map, v1)
;     res => res
;     v1 := NREVERSE(v1)
;     -- now try inexact
;     while not res for map in v1 repeat
;         mr := resolve(target, m)
;         not(mr) => "iterate"
;         not coerceable(mr, m, e) => "iterate"
;         [[md, mr], :fnsel] := map
;         if compMapCond(x, md, [], fnsel, e) then
;             res := trans_delta(genDeltaEntry([x, :map], e), target, e)
;             res := convert(res, m)
;     res

(DEFUN |compAtomWithModemap| (|x| |m| |e| |v|)
  (PROG (|res| |v1| |ISTMP#1| |ISTMP#2| |target| |ISTMP#3| |ISTMP#4| |ISTMP#5|
         |fn| |md| |mr| |fnsel|)
    (RETURN
     (PROGN
      (SETQ |res| NIL)
      (SETQ |v1| NIL)
      ((LAMBDA (|bfVar#1| |map|)
         (LOOP
          (COND
           ((OR |res| (ATOM |bfVar#1|)
                (PROGN (SETQ |map| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |map|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |map|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |target| (CAR |ISTMP#2|)) #1#)))))
                 (PROGN
                  (SETQ |ISTMP#3| (CDR |map|))
                  (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                       (PROGN
                        (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                        (AND (CONSP |ISTMP#4|)
                             (PROGN
                              (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                              (AND (CONSP |ISTMP#5|) (EQ (CDR |ISTMP#5|) NIL)
                                   (PROGN
                                    (SETQ |fn| (CAR |ISTMP#5|))
                                    #1#)))))))
                 (COND ((ATOM |fn|) '|iterate|)
                       ((NULL (|modeEqual| |m| |target|))
                        (SETQ |v1| (CONS |map| |v1|)))
                       (#1#
                        (PROGN
                         (SETQ |md| (CAAR . #2=(|map|)))
                         (SETQ |mr| (CADAR . #2#))
                         (SETQ |fnsel| (CDR |map|))
                         (COND
                          ((|compMapCond| |x| |md| NIL |fnsel| |e|)
                           (SETQ |res|
                                   (|trans_delta|
                                    (|genDeltaEntry| (CONS |x| |map|) |e|)
                                    |target| |e|)))
                          (#1# (SETQ |v1| (CONS |map| |v1|))))))))))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       |v| NIL)
      (COND (|res| |res|)
            (#1#
             (PROGN
              (SETQ |v1| (NREVERSE |v1|))
              ((LAMBDA (|bfVar#2| |map|)
                 (LOOP
                  (COND
                   ((OR |res| (ATOM |bfVar#2|)
                        (PROGN (SETQ |map| (CAR |bfVar#2|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (PROGN
                     (SETQ |mr| (|resolve| |target| |m|))
                     (COND ((NULL |mr|) '|iterate|)
                           ((NULL (|coerceable| |mr| |m| |e|)) '|iterate|)
                           (#1#
                            (PROGN
                             (SETQ |md| (CAAR . #3=(|map|)))
                             (SETQ |mr| (CADAR . #3#))
                             (SETQ |fnsel| (CDR |map|))
                             (COND
                              ((|compMapCond| |x| |md| NIL |fnsel| |e|)
                               (SETQ |res|
                                       (|trans_delta|
                                        (|genDeltaEntry| (CONS |x| |map|) |e|)
                                        |target| |e|))
                               (SETQ |res| (|convert| |res| |m|))))))))))
                  (SETQ |bfVar#2| (CDR |bfVar#2|))))
               |v1| NIL)
              |res|)))))))

; trans_delta(fn, target, e) ==
;     fn1 :=
;         fn is ["XLAM", :.] => [fn]
;         ["call", fn]
;     [fn1, target, e]

(DEFUN |trans_delta| (|fn| |target| |e|)
  (PROG (|fn1|)
    (RETURN
     (PROGN
      (SETQ |fn1|
              (COND ((AND (CONSP |fn|) (EQ (CAR |fn|) 'XLAM)) (LIST |fn|))
                    ('T (LIST '|call| |fn|))))
      (LIST |fn1| |target| |e|)))))

; compToApply(op,argl,m,e) ==
;   T:= compNoStacking(op,$EmptyMode,e) or return nil
;   m1:= T.mode
;   T.expr is ["QUOTE", =m1] => nil
;   compApplication(op,argl,m,T.env,T)

(DEFUN |compToApply| (|op| |argl| |m| |e|)
  (PROG (T$ |m1| |ISTMP#1| |ISTMP#2|)
    (RETURN
     (PROGN
      (SETQ T$ (OR (|compNoStacking| |op| |$EmptyMode| |e|) (RETURN NIL)))
      (SETQ |m1| (CADR T$))
      (COND
       ((PROGN
         (SETQ |ISTMP#1| (CAR T$))
         (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'QUOTE)
              (PROGN
               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
               (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                    (EQUAL (CAR |ISTMP#2|) |m1|)))))
        NIL)
       ('T (|compApplication| |op| |argl| |m| (CADDR T$) T$)))))))

; compApplication(op,argl,m,e,T) ==
;   T.mode is ['Mapping, retm, :argml] =>
;     #argl ~= #argml => nil
;     retm := resolve(m, retm)
;     retm = $Category or isCategoryForm(retm) => nil  -- not handled
;     argTl := [[.,.,e] := comp(x,m,e) or return "failed"
;               for x in argl for m in argml]
;     argTl = "failed" => nil
;     form:=
;       not (member(op,$formalArgList) or member(T.expr,$formalArgList)) and ATOM T.expr =>
;         nprefix := $prefix or BREAK()
;         [op',:[a.expr for a in argTl],"$"] where
;           op':= INTERN STRCONC(encodeItem nprefix,";",encodeItem T.expr)
;       ['call, ['applyFun, T.expr], :[a.expr for a in argTl]]
;     coerce([form, retm, e],resolve(retm,m))
;   -- If op is not 'elt' and not a mapping check if we can
;   -- use appropriate 'elt'
;   op = 'elt => nil
;   eltForm := ['elt, op, :argl]
;   comp(eltForm, m, e)

(DEFUN |compApplication| (|op| |argl| |m| |e| T$)
  (PROG (|ISTMP#1| |ISTMP#2| |retm| |argml| |LETTMP#1| |argTl| |nprefix| |op'|
         |form| |eltForm|)
    (RETURN
     (COND
      ((PROGN
        (SETQ |ISTMP#1| (CADR T$))
        (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
             (PROGN
              (SETQ |ISTMP#2| (CDR |ISTMP#1|))
              (AND (CONSP |ISTMP#2|)
                   (PROGN
                    (SETQ |retm| (CAR |ISTMP#2|))
                    (SETQ |argml| (CDR |ISTMP#2|))
                    #1='T)))))
       (COND ((NOT (EQL (LENGTH |argl|) (LENGTH |argml|))) NIL)
             (#1#
              (PROGN
               (SETQ |retm| (|resolve| |m| |retm|))
               (COND
                ((OR (EQUAL |retm| |$Category|) (|isCategoryForm| |retm|)) NIL)
                (#1#
                 (PROGN
                  (SETQ |argTl|
                          ((LAMBDA (|bfVar#5| |bfVar#3| |x| |bfVar#4| |m|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#3|)
                                    (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL)
                                    (ATOM |bfVar#4|)
                                    (PROGN (SETQ |m| (CAR |bfVar#4|)) NIL))
                                (RETURN (NREVERSE |bfVar#5|)))
                               (#1#
                                (SETQ |bfVar#5|
                                        (CONS
                                         (PROGN
                                          (SETQ |LETTMP#1|
                                                  (OR (|comp| |x| |m| |e|)
                                                      (RETURN '|failed|)))
                                          (SETQ |e| (CADDR |LETTMP#1|))
                                          |LETTMP#1|)
                                         |bfVar#5|))))
                              (SETQ |bfVar#3| (CDR |bfVar#3|))
                              (SETQ |bfVar#4| (CDR |bfVar#4|))))
                           NIL |argl| NIL |argml| NIL))
                  (COND ((EQ |argTl| '|failed|) NIL)
                        (#1#
                         (PROGN
                          (SETQ |form|
                                  (COND
                                   ((AND
                                     (NULL
                                      (OR (|member| |op| |$formalArgList|)
                                          (|member| (CAR T$)
                                           |$formalArgList|)))
                                     (ATOM (CAR T$)))
                                    (PROGN
                                     (SETQ |nprefix| (OR |$prefix| (BREAK)))
                                     (SETQ |op'|
                                             (INTERN
                                              (STRCONC (|encodeItem| |nprefix|)
                                               '|;| (|encodeItem| (CAR T$)))))
                                     (CONS |op'|
                                           (APPEND
                                            ((LAMBDA (|bfVar#7| |bfVar#6| |a|)
                                               (LOOP
                                                (COND
                                                 ((OR (ATOM |bfVar#6|)
                                                      (PROGN
                                                       (SETQ |a|
                                                               (CAR |bfVar#6|))
                                                       NIL))
                                                  (RETURN
                                                   (NREVERSE |bfVar#7|)))
                                                 (#1#
                                                  (SETQ |bfVar#7|
                                                          (CONS (CAR |a|)
                                                                |bfVar#7|))))
                                                (SETQ |bfVar#6|
                                                        (CDR |bfVar#6|))))
                                             NIL |argTl| NIL)
                                            (CONS '$ NIL)))))
                                   (#1#
                                    (CONS '|call|
                                          (CONS (LIST '|applyFun| (CAR T$))
                                                ((LAMBDA
                                                     (|bfVar#9| |bfVar#8| |a|)
                                                   (LOOP
                                                    (COND
                                                     ((OR (ATOM |bfVar#8|)
                                                          (PROGN
                                                           (SETQ |a|
                                                                   (CAR
                                                                    |bfVar#8|))
                                                           NIL))
                                                      (RETURN
                                                       (NREVERSE |bfVar#9|)))
                                                     (#1#
                                                      (SETQ |bfVar#9|
                                                              (CONS (CAR |a|)
                                                                    |bfVar#9|))))
                                                    (SETQ |bfVar#8|
                                                            (CDR |bfVar#8|))))
                                                 NIL |argTl| NIL))))))
                          (|coerce| (LIST |form| |retm| |e|)
                           (|resolve| |retm| |m|))))))))))))
      ((EQ |op| '|elt|) NIL)
      (#1#
       (PROGN
        (SETQ |eltForm| (CONS '|elt| (CONS |op| |argl|)))
        (|comp| |eltForm| |m| |e|)))))))

; compFormWithModemap(form is [op,:argl],m,e,modemap) ==
;   [map:= [.,target,:.],[pred,impl]]:= modemap
;   if isCategoryForm(target) and isFunctor op then
;     [modemap,e]:= substituteIntoFunctorModemap(argl,modemap,e) or return nil
;     [map:= [.,target,:.],:cexpr]:= modemap
;   sv:=listOfSharpVars map
;   if sv then
;      -- SAY [ "compiling ", op, " in compFormWithModemap,
;      -- mode= ",map," sharp vars=",sv]
;     for x in argl for ss in $FormalMapVariableList repeat
;       if ss in sv then
;         [map:= [.,target,:.],:cexpr]:= modemap :=SUBST(x,ss,modemap)
;         -- SAY ["new map is",map]
;   not (target':= coerceable(target,m,e)) => nil
;   [f,Tl,sl]:= compApplyModemap(form,modemap,e,nil) or return nil
;
;   --generate code; return
;   T:=
;     [x',m',e'] where
;       m':= SUBLIS(sl,map.(1))
;       x':=
;         form':= [f,:[t.expr for t in Tl]]
;         (m' = $Category or isCategoryForm(m')) and ATOM(f) => form'
;         -- try to deal with new-style Unions where we know the conditions
;         op = "elt" and f is ['XLAM,:.] and IDENTP(z := first argl) and
;           (c:=get(z,'condition,e)) and
;             c is [["case", =z, c1]] and
;               (c1 is ['_:,=(CADR argl),=m] or EQ(c1,CADR argl) ) =>
; -- first is a full tag, as placed by getInverseEnvironment
; -- second is what getSuccessEnvironment will place there
;                 ["CDR",z]
;         ["call",:form']
;       e':=
;         Tl => (last Tl).env
;         e
;   convert(T,m)

(DEFUN |compFormWithModemap| (|form| |m| |e| |modemap|)
  (PROG (|op| |argl| |map| |target| |pred| |impl| |LETTMP#1| |cexpr| |sv|
         |target'| |f| |Tl| |sl| |m'| |form'| |z| |c| |ISTMP#1| |ISTMP#2|
         |ISTMP#3| |c1| |x'| |e'| T$)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |map| (CAR . #1=(|modemap|)))
      (SETQ |target| (CADAR . #1#))
      (SETQ |pred| (CAADR . #2=(|modemap|)))
      (SETQ |impl| (CADADR . #2#))
      (COND
       ((AND (|isCategoryForm| |target|) (|isFunctor| |op|))
        (SETQ |LETTMP#1|
                (OR (|substituteIntoFunctorModemap| |argl| |modemap| |e|)
                    (RETURN NIL)))
        (SETQ |modemap| (CAR |LETTMP#1|)) (SETQ |e| (CADR |LETTMP#1|))
        (SETQ |map| (CAR . #3=(|modemap|))) (SETQ |target| (CADAR . #3#))
        (SETQ |cexpr| (CDR |modemap|)) |modemap|))
      (SETQ |sv| (|listOfSharpVars| |map|))
      (COND
       (|sv|
        ((LAMBDA (|bfVar#10| |x| |bfVar#11| |ss|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#10|) (PROGN (SETQ |x| (CAR |bfVar#10|)) NIL)
                  (ATOM |bfVar#11|) (PROGN (SETQ |ss| (CAR |bfVar#11|)) NIL))
              (RETURN NIL))
             (#4='T
              (COND
               ((|member| |ss| |sv|)
                (SETQ |modemap| (SUBST |x| |ss| |modemap|))
                (SETQ |map| (CAR . #5=(|modemap|)))
                (SETQ |target| (CADAR . #5#)) (SETQ |cexpr| (CDR |modemap|))
                |modemap|))))
            (SETQ |bfVar#10| (CDR |bfVar#10|))
            (SETQ |bfVar#11| (CDR |bfVar#11|))))
         |argl| NIL |$FormalMapVariableList| NIL)))
      (COND ((NULL (SETQ |target'| (|coerceable| |target| |m| |e|))) NIL)
            (#4#
             (PROGN
              (SETQ |LETTMP#1|
                      (OR (|compApplyModemap| |form| |modemap| |e| NIL)
                          (RETURN NIL)))
              (SETQ |f| (CAR |LETTMP#1|))
              (SETQ |Tl| (CADR . #6=(|LETTMP#1|)))
              (SETQ |sl| (CADDR . #6#))
              (SETQ |m'| (SUBLIS |sl| (ELT |map| 1)))
              (SETQ |x'|
                      (PROGN
                       (SETQ |form'|
                               (CONS |f|
                                     ((LAMBDA (|bfVar#13| |bfVar#12| |t|)
                                        (LOOP
                                         (COND
                                          ((OR (ATOM |bfVar#12|)
                                               (PROGN
                                                (SETQ |t| (CAR |bfVar#12|))
                                                NIL))
                                           (RETURN (NREVERSE |bfVar#13|)))
                                          (#4#
                                           (SETQ |bfVar#13|
                                                   (CONS (CAR |t|)
                                                         |bfVar#13|))))
                                         (SETQ |bfVar#12| (CDR |bfVar#12|))))
                                      NIL |Tl| NIL)))
                       (COND
                        ((AND
                          (OR (EQUAL |m'| |$Category|) (|isCategoryForm| |m'|))
                          (ATOM |f|))
                         |form'|)
                        ((AND (EQ |op| '|elt|) (CONSP |f|) (EQ (CAR |f|) 'XLAM)
                              (IDENTP (SETQ |z| (CAR |argl|)))
                              (SETQ |c| (|get| |z| '|condition| |e|))
                              (CONSP |c|) (EQ (CDR |c|) NIL)
                              (PROGN
                               (SETQ |ISTMP#1| (CAR |c|))
                               (AND (CONSP |ISTMP#1|)
                                    (EQ (CAR |ISTMP#1|) '|case|)
                                    (PROGN
                                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                     (AND (CONSP |ISTMP#2|)
                                          (EQUAL (CAR |ISTMP#2|) |z|)
                                          (PROGN
                                           (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                           (AND (CONSP |ISTMP#3|)
                                                (EQ (CDR |ISTMP#3|) NIL)
                                                (PROGN
                                                 (SETQ |c1| (CAR |ISTMP#3|))
                                                 #4#)))))))
                              (OR
                               (AND (CONSP |c1|) (EQ (CAR |c1|) '|:|)
                                    (PROGN
                                     (SETQ |ISTMP#1| (CDR |c1|))
                                     (AND (CONSP |ISTMP#1|)
                                          (EQUAL (CAR |ISTMP#1|) (CADR |argl|))
                                          (PROGN
                                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                           (AND (CONSP |ISTMP#2|)
                                                (EQ (CDR |ISTMP#2|) NIL)
                                                (EQUAL (CAR |ISTMP#2|)
                                                       |m|))))))
                               (EQ |c1| (CADR |argl|))))
                         (LIST 'CDR |z|))
                        (#4# (CONS '|call| |form'|)))))
              (SETQ |e'| (COND (|Tl| (CADDR (|last| |Tl|))) (#4# |e|)))
              (SETQ T$ (LIST |x'| |m'| |e'|))
              (|convert| T$ |m|))))))))

; applyMapping([op,:argl],m,e,ml) ==
;   #argl~=#ml-1 => nil
;   isCategoryForm(first ml) =>
;                                 --is op a functor?
;     pairlis:= [[v,:a] for a in argl for v in $FormalMapVariableList]
;     ml' := SUBLIS(pairlis, ml)
;     argl':=
;       [T.expr for x in argl for m' in rest ml'] where
;         T() == [.,.,e]:= comp(x,m',e) or return "failed"
;     if argl'="failed" then return nil
;     form:= [op,:argl']
;     convert([form,first ml',e],m)
;   argl':=
;     [T.expr for x in argl for m' in rest ml] where
;       T() == [.,.,e]:= comp(x,m',e) or return "failed"
;   if argl'="failed" then return nil
;   form:=
;     not member(op,$formalArgList) and ATOM op and not get(op,'value,e) =>
;       nprefix := $prefix or BREAK()
;       [op',:argl',"$"] where
;         op':= INTERN STRCONC(encodeItem nprefix,";",encodeItem op)
;     ['call,['applyFun,op],:argl']
;   pairlis:= [[v,:a] for a in argl' for v in $FormalMapVariableList]
;   convert([form,SUBLIS(pairlis,first ml),e],m)

(DEFUN |applyMapping| (|bfVar#26| |m| |e| |ml|)
  (PROG (|op| |argl| |pairlis| |ml'| |LETTMP#1| |argl'| |form| |nprefix| |op'|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |bfVar#26|))
      (SETQ |argl| (CDR |bfVar#26|))
      (COND ((NOT (EQL (LENGTH |argl|) (- (LENGTH |ml|) 1))) NIL)
            ((|isCategoryForm| (CAR |ml|))
             (PROGN
              (SETQ |pairlis|
                      ((LAMBDA (|bfVar#16| |bfVar#14| |a| |bfVar#15| |v|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#14|)
                                (PROGN (SETQ |a| (CAR |bfVar#14|)) NIL)
                                (ATOM |bfVar#15|)
                                (PROGN (SETQ |v| (CAR |bfVar#15|)) NIL))
                            (RETURN (NREVERSE |bfVar#16|)))
                           (#1='T
                            (SETQ |bfVar#16|
                                    (CONS (CONS |v| |a|) |bfVar#16|))))
                          (SETQ |bfVar#14| (CDR |bfVar#14|))
                          (SETQ |bfVar#15| (CDR |bfVar#15|))))
                       NIL |argl| NIL |$FormalMapVariableList| NIL))
              (SETQ |ml'| (SUBLIS |pairlis| |ml|))
              (SETQ |argl'|
                      ((LAMBDA (|bfVar#19| |bfVar#17| |x| |bfVar#18| |m'|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#17|)
                                (PROGN (SETQ |x| (CAR |bfVar#17|)) NIL)
                                (ATOM |bfVar#18|)
                                (PROGN (SETQ |m'| (CAR |bfVar#18|)) NIL))
                            (RETURN (NREVERSE |bfVar#19|)))
                           (#1#
                            (SETQ |bfVar#19|
                                    (CONS
                                     (CAR
                                      (PROGN
                                       (SETQ |LETTMP#1|
                                               (OR (|comp| |x| |m'| |e|)
                                                   (RETURN '|failed|)))
                                       (SETQ |e| (CADDR |LETTMP#1|))
                                       |LETTMP#1|))
                                     |bfVar#19|))))
                          (SETQ |bfVar#17| (CDR |bfVar#17|))
                          (SETQ |bfVar#18| (CDR |bfVar#18|))))
                       NIL |argl| NIL (CDR |ml'|) NIL))
              (COND ((EQ |argl'| '|failed|) (RETURN NIL)))
              (SETQ |form| (CONS |op| |argl'|))
              (|convert| (LIST |form| (CAR |ml'|) |e|) |m|)))
            (#1#
             (PROGN
              (SETQ |argl'|
                      ((LAMBDA (|bfVar#22| |bfVar#20| |x| |bfVar#21| |m'|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#20|)
                                (PROGN (SETQ |x| (CAR |bfVar#20|)) NIL)
                                (ATOM |bfVar#21|)
                                (PROGN (SETQ |m'| (CAR |bfVar#21|)) NIL))
                            (RETURN (NREVERSE |bfVar#22|)))
                           (#1#
                            (SETQ |bfVar#22|
                                    (CONS
                                     (CAR
                                      (PROGN
                                       (SETQ |LETTMP#1|
                                               (OR (|comp| |x| |m'| |e|)
                                                   (RETURN '|failed|)))
                                       (SETQ |e| (CADDR |LETTMP#1|))
                                       |LETTMP#1|))
                                     |bfVar#22|))))
                          (SETQ |bfVar#20| (CDR |bfVar#20|))
                          (SETQ |bfVar#21| (CDR |bfVar#21|))))
                       NIL |argl| NIL (CDR |ml|) NIL))
              (COND ((EQ |argl'| '|failed|) (RETURN NIL)))
              (SETQ |form|
                      (COND
                       ((AND (NULL (|member| |op| |$formalArgList|))
                             (ATOM |op|) (NULL (|get| |op| '|value| |e|)))
                        (PROGN
                         (SETQ |nprefix| (OR |$prefix| (BREAK)))
                         (SETQ |op'|
                                 (INTERN
                                  (STRCONC (|encodeItem| |nprefix|) '|;|
                                   (|encodeItem| |op|))))
                         (CONS |op'| (APPEND |argl'| (CONS '$ NIL)))))
                       (#1#
                        (CONS '|call|
                              (CONS (LIST '|applyFun| |op|) |argl'|)))))
              (SETQ |pairlis|
                      ((LAMBDA (|bfVar#25| |bfVar#23| |a| |bfVar#24| |v|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#23|)
                                (PROGN (SETQ |a| (CAR |bfVar#23|)) NIL)
                                (ATOM |bfVar#24|)
                                (PROGN (SETQ |v| (CAR |bfVar#24|)) NIL))
                            (RETURN (NREVERSE |bfVar#25|)))
                           (#1#
                            (SETQ |bfVar#25|
                                    (CONS (CONS |v| |a|) |bfVar#25|))))
                          (SETQ |bfVar#23| (CDR |bfVar#23|))
                          (SETQ |bfVar#24| (CDR |bfVar#24|))))
                       NIL |argl'| NIL |$FormalMapVariableList| NIL))
              (|convert| (LIST |form| (SUBLIS |pairlis| (CAR |ml|)) |e|)
               |m|))))))))

; compApplyModemap(form, modemap, e, sl) ==
;   $generatingCall : local := true
;   [op,:argl] := form                   --form to be compiled
;   [[mc,mr,:margl],:fnsel] := modemap   --modemap we are testing
;
;   -- e     is the current environment
;   -- sl     substitution list, nil means bottom-up, otherwise top-down
;
;   -- 0.  fail immediately if #argl=#margl
;
;   if #argl~=#margl then return nil
;
;   -- 1.  use modemap to evaluate arguments, returning failed if
;   --     not possible
;
;   lt:=
;     [[., m', e]:=
;       comp(y, g, e) or return "failed" where
;         g:= SUBLIS(sl,m) where
;             sl:= pmatchWithSl(m',m,sl) for y in argl for m in margl]
;   lt="failed" => return nil
;
;   -- 2.  coerce each argument to final domain, returning failed
;   --     if not possible
;
;   lt':= [coerce(y,d) or return "failed"
;          for y in lt for d in SUBLIS(sl,margl)]
;   lt'="failed" => return nil
;
;   -- 3.  obtain domain-specific function, if possible, and return
;
;   --$bindings is bound by compMapCond
;   [f, bindings] := compMapCond(op, mc, sl, fnsel, e) or return nil
;
; --+ can no longer trust what the modemap says for a reference into
; --+ an exterior domain (it is calculating the displacement based on view
; --+ information which is no longer valid; thus ignore this index and
; --+ store the signature instead.
;
; --$NRTflag=true and f is [op1,d,.] and NE(d,'$) and member(op1,'(ELT CONST)) =>
;   f is [op1,d,.] and member(op1,'(ELT CONST)) =>
;       [genDeltaEntry([op, :modemap], e), lt', bindings]
;   [f, lt', bindings]

(DEFUN |compApplyModemap| (|form| |modemap| |e| |sl|)
  (PROG (|$generatingCall| |ISTMP#2| |d| |ISTMP#1| |op1| |bindings| |f| |lt'|
         |lt| |m'| |LETTMP#1| |g| |fnsel| |margl| |mr| |mc| |argl| |op|)
    (DECLARE (SPECIAL |$generatingCall|))
    (RETURN
     (PROGN
      (SETQ |$generatingCall| T)
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |mc| (CAAR . #1=(|modemap|)))
      (SETQ |mr| (CADAR . #1#))
      (SETQ |margl| (CDDAR . #1#))
      (SETQ |fnsel| (CDR |modemap|))
      (COND ((NOT (EQL (LENGTH |argl|) (LENGTH |margl|))) (RETURN NIL)))
      (SETQ |lt|
              ((LAMBDA (|bfVar#29| |bfVar#27| |y| |bfVar#28| |m|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#27|)
                        (PROGN (SETQ |y| (CAR |bfVar#27|)) NIL)
                        (ATOM |bfVar#28|)
                        (PROGN (SETQ |m| (CAR |bfVar#28|)) NIL))
                    (RETURN (NREVERSE |bfVar#29|)))
                   (#2='T
                    (SETQ |bfVar#29|
                            (CONS
                             (PROGN
                              (SETQ |sl| (|pmatchWithSl| |m'| |m| |sl|))
                              (SETQ |g| (SUBLIS |sl| |m|))
                              (SETQ |LETTMP#1|
                                      (OR (|comp| |y| |g| |e|)
                                          (RETURN '|failed|)))
                              (SETQ |m'| (CADR |LETTMP#1|))
                              (SETQ |e| (CADDR |LETTMP#1|))
                              |LETTMP#1|)
                             |bfVar#29|))))
                  (SETQ |bfVar#27| (CDR |bfVar#27|))
                  (SETQ |bfVar#28| (CDR |bfVar#28|))))
               NIL |argl| NIL |margl| NIL))
      (COND ((EQ |lt| '|failed|) (RETURN NIL))
            (#2#
             (PROGN
              (SETQ |lt'|
                      ((LAMBDA (|bfVar#32| |bfVar#30| |y| |bfVar#31| |d|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#30|)
                                (PROGN (SETQ |y| (CAR |bfVar#30|)) NIL)
                                (ATOM |bfVar#31|)
                                (PROGN (SETQ |d| (CAR |bfVar#31|)) NIL))
                            (RETURN (NREVERSE |bfVar#32|)))
                           (#2#
                            (SETQ |bfVar#32|
                                    (CONS
                                     (OR (|coerce| |y| |d|) (RETURN '|failed|))
                                     |bfVar#32|))))
                          (SETQ |bfVar#30| (CDR |bfVar#30|))
                          (SETQ |bfVar#31| (CDR |bfVar#31|))))
                       NIL |lt| NIL (SUBLIS |sl| |margl|) NIL))
              (COND ((EQ |lt'| '|failed|) (RETURN NIL))
                    (#2#
                     (PROGN
                      (SETQ |LETTMP#1|
                              (OR (|compMapCond| |op| |mc| |sl| |fnsel| |e|)
                                  (RETURN NIL)))
                      (SETQ |f| (CAR |LETTMP#1|))
                      (SETQ |bindings| (CADR |LETTMP#1|))
                      (COND
                       ((AND (CONSP |f|)
                             (PROGN
                              (SETQ |op1| (CAR |f|))
                              (SETQ |ISTMP#1| (CDR |f|))
                              (AND (CONSP |ISTMP#1|)
                                   (PROGN
                                    (SETQ |d| (CAR |ISTMP#1|))
                                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                    (AND (CONSP |ISTMP#2|)
                                         (EQ (CDR |ISTMP#2|) NIL)))))
                             (|member| |op1| '(ELT CONST)))
                        (LIST (|genDeltaEntry| (CONS |op| |modemap|) |e|) |lt'|
                              |bindings|))
                       (#2# (LIST |f| |lt'| |bindings|)))))))))))))

; compMapCond(op, mc, bindings, fnsel, e) ==
;   or/[compMapCond'(u, op, mc, bindings, e) for u in fnsel]

(DEFUN |compMapCond| (|op| |mc| |bindings| |fnsel| |e|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#34| |bfVar#33| |u|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#33|) (PROGN (SETQ |u| (CAR |bfVar#33|)) NIL))
           (RETURN |bfVar#34|))
          ('T
           (PROGN
            (SETQ |bfVar#34| (|compMapCond'| |u| |op| |mc| |bindings| |e|))
            (COND (|bfVar#34| (RETURN |bfVar#34|))))))
         (SETQ |bfVar#33| (CDR |bfVar#33|))))
      NIL |fnsel| NIL))))

; compMapCond'([cexpr,fnexpr], op, dc, bindings, e) ==
;   compMapCond''(cexpr, dc, e) => compMapCondFun(fnexpr,op,dc,bindings)
;   stackMessage ["not known that",'%b,dc,'%d,"has",'%b,cexpr,'%d]

(DEFUN |compMapCond'| (|bfVar#35| |op| |dc| |bindings| |e|)
  (PROG (|cexpr| |fnexpr|)
    (RETURN
     (PROGN
      (SETQ |cexpr| (CAR |bfVar#35|))
      (SETQ |fnexpr| (CADR |bfVar#35|))
      (COND
       ((|compMapCond''| |cexpr| |dc| |e|)
        (|compMapCondFun| |fnexpr| |op| |dc| |bindings|))
       ('T
        (|stackMessage|
         (LIST '|not known that| '|%b| |dc| '|%d| '|has| '|%b| |cexpr|
               '|%d|))))))))

; compMapCond''(cexpr, dc, e) ==
;   cexpr=true => true
;   cexpr is ["AND", :l] or cexpr is ["and", :l] =>
;       and/[compMapCond''(u, dc, e) for u in l]
;   cexpr is ["OR", :l] or cexpr is ["or", :l] =>
;       or/[compMapCond''(u, dc, e) for u in l]
;   -- FIXME: This will claim that 'not u' is true when we
;   -- do not know truth value
;   cexpr is ["not",u] => not compMapCond''(u, dc, e)
;   cexpr is ["has", name, cat] =>
;         known_info_in_env(cexpr, e) => true
;         false
;         --for the time being we'll stop here - shouldn't happen so far
;         --$disregardConditionIfTrue => true
;         --stackSemanticError(("not known that",'%b,name,
;         -- '%d,"has",'%b,cat,'%d),nil)
;   BREAK()

(DEFUN |compMapCond''| (|cexpr| |dc| |e|)
  (PROG (|l| |ISTMP#1| |u| |name| |ISTMP#2| |cat|)
    (RETURN
     (COND ((EQUAL |cexpr| T) T)
           ((OR
             (AND (CONSP |cexpr|) (EQ (CAR |cexpr|) 'AND)
                  (PROGN (SETQ |l| (CDR |cexpr|)) #1='T))
             (AND (CONSP |cexpr|) (EQ (CAR |cexpr|) '|and|)
                  (PROGN (SETQ |l| (CDR |cexpr|)) #1#)))
            ((LAMBDA (|bfVar#37| |bfVar#36| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#36|)
                      (PROGN (SETQ |u| (CAR |bfVar#36|)) NIL))
                  (RETURN |bfVar#37|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#37| (|compMapCond''| |u| |dc| |e|))
                   (COND ((NOT |bfVar#37|) (RETURN NIL))))))
                (SETQ |bfVar#36| (CDR |bfVar#36|))))
             T |l| NIL))
           ((OR
             (AND (CONSP |cexpr|) (EQ (CAR |cexpr|) 'OR)
                  (PROGN (SETQ |l| (CDR |cexpr|)) #1#))
             (AND (CONSP |cexpr|) (EQ (CAR |cexpr|) '|or|)
                  (PROGN (SETQ |l| (CDR |cexpr|)) #1#)))
            ((LAMBDA (|bfVar#39| |bfVar#38| |u|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#38|)
                      (PROGN (SETQ |u| (CAR |bfVar#38|)) NIL))
                  (RETURN |bfVar#39|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#39| (|compMapCond''| |u| |dc| |e|))
                   (COND (|bfVar#39| (RETURN |bfVar#39|))))))
                (SETQ |bfVar#38| (CDR |bfVar#38|))))
             NIL |l| NIL))
           ((AND (CONSP |cexpr|) (EQ (CAR |cexpr|) '|not|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |cexpr|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |u| (CAR |ISTMP#1|)) #1#))))
            (NULL (|compMapCond''| |u| |dc| |e|)))
           ((AND (CONSP |cexpr|) (EQ (CAR |cexpr|) '|has|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |cexpr|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |name| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |cat| (CAR |ISTMP#2|)) #1#))))))
            (COND ((|known_info_in_env| |cexpr| |e|) T) (#1# NIL)))
           (#1# (BREAK))))))

; compMapCondFun(fnexpr,op,dc,bindings) == [fnexpr,bindings]

(DEFUN |compMapCondFun| (|fnexpr| |op| |dc| |bindings|)
  (PROG () (RETURN (LIST |fnexpr| |bindings|))))

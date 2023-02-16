
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($newCompCompare, false)

(DEFPARAMETER |$newCompCompare| NIL)

; compDefine(form,m,e) ==
;   result:= compDefine1(form,m,e)
;   result

(DEFUN |compDefine| (|form| |m| |e|)
  (PROG (|result|)
    (RETURN (PROGN (SETQ |result| (|compDefine1| |form| |m| |e|)) |result|))))

; compDefine1(form,m,e) ==
;   --1. decompose after macro-expanding form
;   ['DEF, lhs, signature, rhs] := form := macroExpand(form, e)
;   $insideWhereIfTrue and isMacro(form,e) and (m=$EmptyMode or m=$NoValueMode)
;      => [lhs,m,put(first lhs,'macro,rhs,e)]
;   null signature.target and not MEMQ(IFCAR rhs, $ConstructorNames) and
;     (sig:= getSignatureFromMode(lhs,e)) =>
;   -- here signature of lhs is determined by a previous declaration
;       compDefine1(['DEF, lhs, [first sig, :rest signature], rhs], m, e)
;   $insideCapsuleFunctionIfTrue =>
;       compInternalFunction(form, m, e)
;   if signature.target=$Category then $insideCategoryIfTrue:= true
;
; -- RDJ (11/83): when argument and return types are all declared,
; --  or arguments have types declared in the environment,
; --  and there is no existing modemap for this signature, add
; --  the modemap by a declaration, then strip off declarations and recurse
;   e := compDefineAddSignature(lhs,signature,e)
; -- 2. if signature list for arguments is not empty, replace ('DEF,..) by
; --       ('where,('DEF,..),..) with an empty signature list;
; --     otherwise, fill in all NILs in the signature
;   not (and/[null x for x in rest signature]) => compDefWhereClause(form,m,e)
;   signature.target=$Category =>
;       compDefineCategory(form, m, e, nil, $formalArgList)
;   isDomainForm(rhs,e) and not $insideFunctorIfTrue =>
;     if null signature.target then signature:=
;       [getTargetFromRhs(lhs,rhs,giveFormalParametersValues(rest lhs,e)),:
;           rest signature]
;     rhs:= addEmptyCapsuleIfNecessary(signature.target,rhs)
;     new_prefix := getAbbreviation(first(lhs), #(rest(lhs)))
;     compDefineFunctor(['DEF, lhs, signature, rhs], m, e,
;                       new_prefix, $formalArgList)
;   null($functorForm) => stackAndThrow ['"bad == form ",form]
;   compDefineCapsuleFunction(form, m, e, $prefix, $formalArgList)

(DEFUN |compDefine1| (|form| |m| |e|)
  (PROG (|lhs| |signature| |rhs| |sig| |new_prefix|)
    (RETURN
     (PROGN
      (SETQ |form| (|macroExpand| |form| |e|))
      (SETQ |lhs| (CADR . #1=(|form|)))
      (SETQ |signature| (CADDR . #1#))
      (SETQ |rhs| (CADDDR . #1#))
      (COND
       ((AND |$insideWhereIfTrue| (|isMacro| |form| |e|)
             (OR (EQUAL |m| |$EmptyMode|) (EQUAL |m| |$NoValueMode|)))
        (LIST |lhs| |m| (|put| (CAR |lhs|) '|macro| |rhs| |e|)))
       ((AND (NULL (CAR |signature|))
             (NULL (MEMQ (IFCAR |rhs|) |$ConstructorNames|))
             (SETQ |sig| (|getSignatureFromMode| |lhs| |e|)))
        (|compDefine1|
         (LIST 'DEF |lhs| (CONS (CAR |sig|) (CDR |signature|)) |rhs|) |m| |e|))
       (|$insideCapsuleFunctionIfTrue| (|compInternalFunction| |form| |m| |e|))
       (#2='T
        (PROGN
         (COND
          ((EQUAL (CAR |signature|) |$Category|)
           (SETQ |$insideCategoryIfTrue| T)))
         (SETQ |e| (|compDefineAddSignature| |lhs| |signature| |e|))
         (COND
          ((NULL
            ((LAMBDA (|bfVar#2| |bfVar#1| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
                  (RETURN |bfVar#2|))
                 (#2#
                  (PROGN
                   (SETQ |bfVar#2| (NULL |x|))
                   (COND ((NOT |bfVar#2|) (RETURN NIL))))))
                (SETQ |bfVar#1| (CDR |bfVar#1|))))
             T (CDR |signature|) NIL))
           (|compDefWhereClause| |form| |m| |e|))
          ((EQUAL (CAR |signature|) |$Category|)
           (|compDefineCategory| |form| |m| |e| NIL |$formalArgList|))
          ((AND (|isDomainForm| |rhs| |e|) (NULL |$insideFunctorIfTrue|))
           (PROGN
            (COND
             ((NULL (CAR |signature|))
              (SETQ |signature|
                      (CONS
                       (|getTargetFromRhs| |lhs| |rhs|
                        (|giveFormalParametersValues| (CDR |lhs|) |e|))
                       (CDR |signature|)))))
            (SETQ |rhs| (|addEmptyCapsuleIfNecessary| (CAR |signature|) |rhs|))
            (SETQ |new_prefix|
                    (|getAbbreviation| (CAR |lhs|) (LENGTH (CDR |lhs|))))
            (|compDefineFunctor| (LIST 'DEF |lhs| |signature| |rhs|) |m| |e|
             |new_prefix| |$formalArgList|)))
          ((NULL |$functorForm|)
           (|stackAndThrow| (LIST "bad == form " |form|)))
          (#2#
           (|compDefineCapsuleFunction| |form| |m| |e| |$prefix|
            |$formalArgList|))))))))))

; compDefineAddSignature([op,:argl],signature,e) ==
;   (sig:= hasFullSignature(argl,signature,e)) and
;    not assoc(['$,:sig],LASSOC('modemap,getProplist(op,e))) =>
;      declForm:=
;        [":",[op,:[[":",x,m] for x in argl for m in rest sig]],first signature]
;      [.,.,e]:= comp(declForm,$EmptyMode,e)
;      e
;   e

(DEFUN |compDefineAddSignature| (|bfVar#6| |signature| |e|)
  (PROG (|op| |argl| |sig| |declForm| |LETTMP#1|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |bfVar#6|))
      (SETQ |argl| (CDR |bfVar#6|))
      (COND
       ((AND (SETQ |sig| (|hasFullSignature| |argl| |signature| |e|))
             (NULL
              (|assoc| (CONS '$ |sig|)
               (LASSOC '|modemap| (|getProplist| |op| |e|)))))
        (PROGN
         (SETQ |declForm|
                 (LIST '|:|
                       (CONS |op|
                             ((LAMBDA (|bfVar#5| |bfVar#3| |x| |bfVar#4| |m|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#3|)
                                       (PROGN (SETQ |x| (CAR |bfVar#3|)) NIL)
                                       (ATOM |bfVar#4|)
                                       (PROGN (SETQ |m| (CAR |bfVar#4|)) NIL))
                                   (RETURN (NREVERSE |bfVar#5|)))
                                  (#1='T
                                   (SETQ |bfVar#5|
                                           (CONS (LIST '|:| |x| |m|)
                                                 |bfVar#5|))))
                                 (SETQ |bfVar#3| (CDR |bfVar#3|))
                                 (SETQ |bfVar#4| (CDR |bfVar#4|))))
                              NIL |argl| NIL (CDR |sig|) NIL))
                       (CAR |signature|)))
         (SETQ |LETTMP#1| (|comp| |declForm| |$EmptyMode| |e|))
         (SETQ |e| (CADDR |LETTMP#1|))
         |e|))
       (#1# |e|))))))

; hasFullSignature(argl,[target,:ml],e) ==
;   target =>
;     u:= [m or get(x,"mode",e) or return 'failed for x in argl for m in ml]
;     u~='failed => [target,:u]

(DEFUN |hasFullSignature| (|argl| |bfVar#10| |e|)
  (PROG (|target| |ml| |u|)
    (RETURN
     (PROGN
      (SETQ |target| (CAR |bfVar#10|))
      (SETQ |ml| (CDR |bfVar#10|))
      (COND
       (|target|
        (IDENTITY
         (PROGN
          (SETQ |u|
                  ((LAMBDA (|bfVar#9| |bfVar#7| |x| |bfVar#8| |m|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#7|)
                            (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL)
                            (ATOM |bfVar#8|)
                            (PROGN (SETQ |m| (CAR |bfVar#8|)) NIL))
                        (RETURN (NREVERSE |bfVar#9|)))
                       ('T
                        (SETQ |bfVar#9|
                                (CONS
                                 (OR |m| (|get| |x| '|mode| |e|)
                                     (RETURN '|failed|))
                                 |bfVar#9|))))
                      (SETQ |bfVar#7| (CDR |bfVar#7|))
                      (SETQ |bfVar#8| (CDR |bfVar#8|))))
                   NIL |argl| NIL |ml| NIL))
          (COND ((NOT (EQ |u| '|failed|)) (CONS |target| |u|)))))))))))

; addEmptyCapsuleIfNecessary(target,rhs) ==
;   MEMQ(IFCAR rhs, $SpecialDomainNames) => rhs
;   ['add,rhs,['CAPSULE]]

(DEFUN |addEmptyCapsuleIfNecessary| (|target| |rhs|)
  (PROG ()
    (RETURN
     (COND ((MEMQ (IFCAR |rhs|) |$SpecialDomainNames|) |rhs|)
           ('T (LIST '|add| |rhs| (LIST 'CAPSULE)))))))

; getTargetFromRhs(lhs,rhs,e) ==
;   --undeclared target mode obtained from rhs expression
;   rhs is ['CAPSULE,:.] =>
;     stackSemanticError(['"target category of ",lhs,
;       '" cannot be determined from definition"],nil)
;   rhs is ['SubDomain,D,:.] => getTargetFromRhs(lhs,D,e)
;   rhs is ['add,D,['CAPSULE,:.]] => getTargetFromRhs(lhs,D,e)
;   rhs is ['Record,:l] => ['RecordCategory,:l]
;   rhs is ['Union,:l] => ['UnionCategory,:l]
;   [.,target,.]:= compOrCroak(rhs,$EmptyMode,e)
;   target is ["Category"] =>
;       stackAndThrow(['"Only domains and packages can get mode form target",
;                      lhs])
;   target

(DEFUN |getTargetFromRhs| (|lhs| |rhs| |e|)
  (PROG (|ISTMP#1| D |ISTMP#2| |ISTMP#3| |l| |LETTMP#1| |target|)
    (RETURN
     (COND
      ((AND (CONSP |rhs|) (EQ (CAR |rhs|) 'CAPSULE))
       (|stackSemanticError|
        (LIST "target category of " |lhs|
              " cannot be determined from definition")
        NIL))
      ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|SubDomain|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |rhs|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ D (CAR |ISTMP#1|)) #1='T))))
       (|getTargetFromRhs| |lhs| D |e|))
      ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|add|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |rhs|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ D (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN
                         (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|)
                              (EQ (CAR |ISTMP#3|) 'CAPSULE))))))))
       (|getTargetFromRhs| |lhs| D |e|))
      ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|Record|)
            (PROGN (SETQ |l| (CDR |rhs|)) #1#))
       (CONS '|RecordCategory| |l|))
      ((AND (CONSP |rhs|) (EQ (CAR |rhs|) '|Union|)
            (PROGN (SETQ |l| (CDR |rhs|)) #1#))
       (CONS '|UnionCategory| |l|))
      (#1#
       (PROGN
        (SETQ |LETTMP#1| (|compOrCroak| |rhs| |$EmptyMode| |e|))
        (SETQ |target| (CADR |LETTMP#1|))
        (COND
         ((AND (CONSP |target|) (EQ (CDR |target|) NIL)
               (EQ (CAR |target|) '|Category|))
          (|stackAndThrow|
           (LIST "Only domains and packages can get mode form target" |lhs|)))
         (#1# |target|))))))))

; giveFormalParametersValues(argl,e) ==
;   for x in argl repeat
;     e:= put(x,'value,[genSomeVariable(),get(x,'mode,e),nil],e)
;   e

(DEFUN |giveFormalParametersValues| (|argl| |e|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#11| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#11|) (PROGN (SETQ |x| (CAR |bfVar#11|)) NIL))
            (RETURN NIL))
           ('T
            (SETQ |e|
                    (|put| |x| '|value|
                     (LIST (|genSomeVariable|) (|get| |x| '|mode| |e|) NIL)
                     |e|))))
          (SETQ |bfVar#11| (CDR |bfVar#11|))))
       |argl| NIL)
      |e|))))

; macroExpandInPlace(x,e) ==
;   y:= macroExpand(x,e)
;   atom x or atom y => y
;   RPLACA(x,first y)
;   RPLACD(x,rest y)
;   x

(DEFUN |macroExpandInPlace| (|x| |e|)
  (PROG (|y|)
    (RETURN
     (PROGN
      (SETQ |y| (|macroExpand| |x| |e|))
      (COND ((OR (ATOM |x|) (ATOM |y|)) |y|)
            ('T (PROGN (RPLACA |x| (CAR |y|)) (RPLACD |x| (CDR |y|)) |x|)))))))

; macroExpand(x,e) ==   --not worked out yet
;   atom x =>
;       u := get(x, 'macro, e) =>
;           null(rest(u)) =>
;               macroExpand(first u, e)
;           SAY(["u =", u])
;           userError("macro call needs arguments")
;       x
;   x is ['DEF, lhs, sig, rhs] =>
;     ['DEF, macroExpand(lhs, e), macroExpandList(sig, e), macroExpand(rhs, e)]
;   x is [op, :args] =>
;       ATOM(op) =>
;           u := get(op, 'macro, e) =>
;               margs := rest(u)
;               u := first(u)
;               null(margs) => [macroExpand(u, e), :macroExpandList(args, e)]
;               #args = #margs =>
;                   macroExpand(SUBLISLIS(args, margs, u), e)
;               userError("invalid macro call, #args ~= #margs")
;           [op, :macroExpandList(args, e)]
;       macroExpandList(x,e)
;   macroExpandList(x,e)

(DEFUN |macroExpand| (|x| |e|)
  (PROG (|u| |ISTMP#1| |lhs| |ISTMP#2| |sig| |ISTMP#3| |rhs| |op| |args|
         |margs|)
    (RETURN
     (COND
      ((ATOM |x|)
       (COND
        ((SETQ |u| (|get| |x| '|macro| |e|))
         (COND ((NULL (CDR |u|)) (|macroExpand| (CAR |u|) |e|))
               (#1='T
                (PROGN
                 (SAY (LIST '|u =| |u|))
                 (|userError| '|macro call needs arguments|)))))
        (#1# |x|)))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'DEF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |lhs| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |sig| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |rhs| (CAR |ISTMP#3|)) #1#))))))))
       (LIST 'DEF (|macroExpand| |lhs| |e|) (|macroExpandList| |sig| |e|)
             (|macroExpand| |rhs| |e|)))
      ((AND (CONSP |x|)
            (PROGN (SETQ |op| (CAR |x|)) (SETQ |args| (CDR |x|)) #1#))
       (COND
        ((ATOM |op|)
         (COND
          ((SETQ |u| (|get| |op| '|macro| |e|))
           (PROGN
            (SETQ |margs| (CDR |u|))
            (SETQ |u| (CAR |u|))
            (COND
             ((NULL |margs|)
              (CONS (|macroExpand| |u| |e|) (|macroExpandList| |args| |e|)))
             ((EQL (LENGTH |args|) (LENGTH |margs|))
              (|macroExpand| (SUBLISLIS |args| |margs| |u|) |e|))
             (#1# (|userError| '|invalid macro call, #args ~= #margs|)))))
          (#1# (CONS |op| (|macroExpandList| |args| |e|)))))
        (#1# (|macroExpandList| |x| |e|))))
      (#1# (|macroExpandList| |x| |e|))))))

; macroExpandList(l,e) ==
;   [macroExpand(x,e) for x in l]

(DEFUN |macroExpandList| (|l| |e|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#13| |bfVar#12| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#12|) (PROGN (SETQ |x| (CAR |bfVar#12|)) NIL))
           (RETURN (NREVERSE |bfVar#13|)))
          ('T (SETQ |bfVar#13| (CONS (|macroExpand| |x| |e|) |bfVar#13|))))
         (SETQ |bfVar#12| (CDR |bfVar#12|))))
      NIL |l| NIL))))

; compDefineCategory1(df is ['DEF, form, sig, body], m, e, prefix, fal) ==
;   categoryCapsule :=
; --+
;     body is ['add,cat,capsule] =>
;       body := cat
;       capsule
;     nil
;   [d, m, e] := compDefineCategory2(form, sig, body, m, e, prefix, fal)
; --+ next two lines
;   if categoryCapsule and not $bootStrapMode then [.,.,e] :=
;     $insideCategoryPackageIfTrue: local := true  --see NRTmakeSlot1
; -->
;     $categoryPredicateList: local :=
;         makeCategoryPredicates(form,$lisplibCategory)
;     compDefine1(mkCategoryPackage(form, categoryCapsule, e),
;                 $EmptyMode, e)
;   [d,m,e]

(DEFUN |compDefineCategory1| (|df| |m| |e| |prefix| |fal|)
  (PROG (|$categoryPredicateList| |$insideCategoryPackageIfTrue| |d| |LETTMP#1|
         |categoryCapsule| |capsule| |ISTMP#2| |cat| |ISTMP#1| |body| |sig|
         |form|)
    (DECLARE (SPECIAL |$categoryPredicateList| |$insideCategoryPackageIfTrue|))
    (RETURN
     (PROGN
      (SETQ |form| (CADR . #1=(|df|)))
      (SETQ |sig| (CADDR . #1#))
      (SETQ |body| (CADDDR . #1#))
      (SETQ |categoryCapsule|
              (COND
               ((AND (CONSP |body|) (EQ (CAR |body|) '|add|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |body|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |cat| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN
                                  (SETQ |capsule| (CAR |ISTMP#2|))
                                  #2='T))))))
                (PROGN (SETQ |body| |cat|) |capsule|))
               (#2# NIL)))
      (SETQ |LETTMP#1|
              (|compDefineCategory2| |form| |sig| |body| |m| |e| |prefix|
               |fal|))
      (SETQ |d| (CAR |LETTMP#1|))
      (SETQ |m| (CADR . #3=(|LETTMP#1|)))
      (SETQ |e| (CADDR . #3#))
      (COND
       ((AND |categoryCapsule| (NULL |$bootStrapMode|))
        (SETQ |LETTMP#1|
                (PROGN
                 (SETQ |$insideCategoryPackageIfTrue| T)
                 (SETQ |$categoryPredicateList|
                         (|makeCategoryPredicates| |form| |$lisplibCategory|))
                 (|compDefine1|
                  (|mkCategoryPackage| |form| |categoryCapsule| |e|)
                  |$EmptyMode| |e|)))
        (SETQ |e| (CADDR |LETTMP#1|)) |LETTMP#1|))
      (LIST |d| |m| |e|)))))

; makeCategoryPredicates(form,u) ==
;       $tvl := TAKE(#rest form,$TriangleVariableList)
;       $mvl := TAKE(#rest form,rest $FormalMapVariableList)
;       fn(u,nil) where
;         fn(u,pl) ==
;           u is ['Join,:.,a] => fn(a,pl)
;           u is ['has,:.] => insert(EQSUBSTLIST($mvl,$tvl,u),pl)
;           u is [op, :.] and MEMQ(op, ["SIGNATURE", "ATTRIBUTE"]) =>
;                -- EQ(op, 'ATTRIBUTE) => BREAK()
;                pl
;           atom u => pl
;           fnl(u,pl)
;         fnl(u,pl) ==
;           for x in u repeat pl := fn(x,pl)
;           pl

(DEFUN |makeCategoryPredicates| (|form| |u|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$tvl| (TAKE (LENGTH (CDR |form|)) |$TriangleVariableList|))
      (SETQ |$mvl| (TAKE (LENGTH (CDR |form|)) (CDR |$FormalMapVariableList|)))
      (|makeCategoryPredicates,fn| |u| NIL)))))
(DEFUN |makeCategoryPredicates,fn| (|u| |pl|)
  (PROG (|ISTMP#1| |ISTMP#2| |a| |op|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQ (CAR |u|) '|Join|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1='T)
                  (CONSP |ISTMP#2|) (PROGN (SETQ |a| (CAR |ISTMP#2|)) #1#))))
       (|makeCategoryPredicates,fn| |a| |pl|))
      ((AND (CONSP |u|) (EQ (CAR |u|) '|has|))
       (|insert| (EQSUBSTLIST |$mvl| |$tvl| |u|) |pl|))
      ((AND (CONSP |u|) (PROGN (SETQ |op| (CAR |u|)) #1#)
            (MEMQ |op| (LIST 'SIGNATURE 'ATTRIBUTE)))
       |pl|)
      ((ATOM |u|) |pl|) (#1# (|makeCategoryPredicates,fnl| |u| |pl|))))))
(DEFUN |makeCategoryPredicates,fnl| (|u| |pl|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#14| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#14|) (PROGN (SETQ |x| (CAR |bfVar#14|)) NIL))
            (RETURN NIL))
           ('T (SETQ |pl| (|makeCategoryPredicates,fn| |x| |pl|))))
          (SETQ |bfVar#14| (CDR |bfVar#14|))))
       |u| NIL)
      |pl|))))

; mkCategoryPackage(form is [op, :argl], def, e) ==
;   packageName:= INTERN(STRCONC(PNAME op,'"&"))
;   packageAbb := INTERN(STRCONC(GETDATABASE(op,'ABBREVIATION),'"-"))
;   $options:local := []
;   -- This stops the next line from becoming confused
;   abbreviationsSpad2Cmd ['domain,packageAbb,packageName]
;   -- This is a little odd, but the parser insists on calling
;   -- domains, rather than packages
;   nameForDollar := first SETDIFFERENCE('(S A B C D E F G H I),argl)
;   packageArgl := [nameForDollar,:argl]
;   capsuleDefAlist := fn(def,nil) where fn(x,oplist) ==
;     atom x => oplist
;     x is ['DEF,y,:.] => [y,:oplist]
;     fn(rest x,fn(first x,oplist))
;   catvec := eval mkEvalableCategoryForm(form, e)
;   fullCatOpList := (JoinInner([catvec])).1
;   catOpList :=
;     --note: this gets too many modemaps in general
;     --   this is cut down in NRTmakeSlot1
;     [['SIGNATURE,op1,sig] for [[op1,sig],:.] in fullCatOpList
;          --above line calls the category constructor just compiled
;         | assoc(op1,capsuleDefAlist)]
;   null catOpList => nil
;   packageCategory := ['CATEGORY,'domain,
;                      :SUBLISLIS(argl,$FormalMapVariableList,catOpList)]
;   nils:= [nil for x in argl]
;   packageSig := [packageCategory,form,:nils]
;   $categoryPredicateList := SUBST(nameForDollar,'$,$categoryPredicateList)
;   SUBST(nameForDollar,'$,
;       ['DEF, [packageName, :packageArgl], packageSig, def])

(DEFUN |mkCategoryPackage| (|form| |def| |e|)
  (PROG (|$options| |packageSig| |nils| |packageCategory| |catOpList| |sig|
         |ISTMP#2| |op1| |ISTMP#1| |fullCatOpList| |catvec| |capsuleDefAlist|
         |packageArgl| |nameForDollar| |packageAbb| |packageName| |argl| |op|)
    (DECLARE (SPECIAL |$options|))
    (RETURN
     (PROGN
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |packageName| (INTERN (STRCONC (PNAME |op|) "&")))
      (SETQ |packageAbb|
              (INTERN (STRCONC (GETDATABASE |op| 'ABBREVIATION) "-")))
      (SETQ |$options| NIL)
      (|abbreviationsSpad2Cmd| (LIST '|domain| |packageAbb| |packageName|))
      (SETQ |nameForDollar|
              (CAR (SETDIFFERENCE '(S A B C D E F G H I) |argl|)))
      (SETQ |packageArgl| (CONS |nameForDollar| |argl|))
      (SETQ |capsuleDefAlist| (|mkCategoryPackage,fn| |def| NIL))
      (SETQ |catvec| (|eval| (|mkEvalableCategoryForm| |form| |e|)))
      (SETQ |fullCatOpList| (ELT (|JoinInner| (LIST |catvec|)) 1))
      (SETQ |catOpList|
              ((LAMBDA (|bfVar#17| |bfVar#16| |bfVar#15|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#16|)
                        (PROGN (SETQ |bfVar#15| (CAR |bfVar#16|)) NIL))
                    (RETURN (NREVERSE |bfVar#17|)))
                   (#1='T
                    (AND (CONSP |bfVar#15|)
                         (PROGN
                          (SETQ |ISTMP#1| (CAR |bfVar#15|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |op1| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |sig| (CAR |ISTMP#2|))
                                      #1#)))))
                         (|assoc| |op1| |capsuleDefAlist|)
                         (SETQ |bfVar#17|
                                 (CONS (LIST 'SIGNATURE |op1| |sig|)
                                       |bfVar#17|)))))
                  (SETQ |bfVar#16| (CDR |bfVar#16|))))
               NIL |fullCatOpList| NIL))
      (COND ((NULL |catOpList|) NIL)
            (#1#
             (PROGN
              (SETQ |packageCategory|
                      (CONS 'CATEGORY
                            (CONS '|domain|
                                  (SUBLISLIS |argl| |$FormalMapVariableList|
                                   |catOpList|))))
              (SETQ |nils|
                      ((LAMBDA (|bfVar#19| |bfVar#18| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#18|)
                                (PROGN (SETQ |x| (CAR |bfVar#18|)) NIL))
                            (RETURN (NREVERSE |bfVar#19|)))
                           (#1# (SETQ |bfVar#19| (CONS NIL |bfVar#19|))))
                          (SETQ |bfVar#18| (CDR |bfVar#18|))))
                       NIL |argl| NIL))
              (SETQ |packageSig| (CONS |packageCategory| (CONS |form| |nils|)))
              (SETQ |$categoryPredicateList|
                      (SUBST |nameForDollar| '$ |$categoryPredicateList|))
              (SUBST |nameForDollar| '$
                     (LIST 'DEF (CONS |packageName| |packageArgl|) |packageSig|
                           |def|)))))))))
(DEFUN |mkCategoryPackage,fn| (|x| |oplist|)
  (PROG (|ISTMP#1| |y|)
    (RETURN
     (COND ((ATOM |x|) |oplist|)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'DEF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1='T))))
            (CONS |y| |oplist|))
           (#1#
            (|mkCategoryPackage,fn| (CDR |x|)
             (|mkCategoryPackage,fn| (CAR |x|) |oplist|)))))))

; compDefineCategory2(form, signature, body, m, e,
;   $prefix,$formalArgList) ==
;     --1. bind global variables
;     $insideCategoryIfTrue: local:= true
;     $definition : local := form
;                  --used by DomainSubstitutionFunction
;     $extraParms: local := nil
;              --Set in DomainSubstitutionFunction, used further down
; --  1.1  augment e to add declaration $: <form>
;     $op: local := nil
;     [$op, :argl] := form
;     e := addBinding("$", [['mode, :form]],e)
;
; --  2. obtain signature
;     signature':=
;         [first signature, :[getArgumentModeOrMoan(a, form, e) for a in argl]]
;     e:= giveFormalParametersValues(argl,e)
;
; --   3. replace arguments by $1,..., substitute into body,
; --     and introduce declarations into environment
;     sargl:= TAKE(# argl, $TriangleVariableList)
;     sform := [$op, :sargl]
;     $functorForm : local := sform
;     $formalArgList:= [:sargl,:$formalArgList]
;     aList:= [[a,:sa] for a in argl for sa in sargl]
;     formalBody:= SUBLIS(aList,body)
;     signature' := SUBLIS(aList,signature')
; --Begin lines for category default definitions
;     $functionStats: local:= [0,0]
;     $functorStats: local:= [0,0]
;     $addForm: local:= nil
;     $functor_cosig1 : local := [categoryForm?(t) for t in rest(signature')]
;     for x in sargl for t in rest signature' repeat
;       [.,.,e]:= compMakeDeclaration([":",x,t],m,e)
;
; --   4. compile body in environment of type declarations for arguments
;     op':= $op
;     -- following line causes cats with no with or Join to be fresh copies
;     if opOf(formalBody)~='Join and opOf(formalBody)~='mkCategory then
;            formalBody := ['Join, formalBody]
;     body:= optFunctorBody (compOrCroak(formalBody,signature'.target,e)).expr
;     if $extraParms then
;       formals:=actuals:=nil
;       for u in $extraParms repeat
;         formals := [first u, :formals]
;         actuals:=[MKQ CDR u,:actuals]
;       body := ['subst_in_cat, ['QUOTE, formals],
;                                        ['LIST, :actuals], body]
;     if argl then body:=  -- always subst for args after extraparms
;         ['subst_in_cat, ['QUOTE, sargl], ['LIST, :sargl], body]
;     -- FIXME: generate call to 'devaluate' only for domains
;     body:=
;         ['PROG1, ['LET, g:= GENSYM(), body],
;                  ['SETELT, g, 0, mkConstructor(sform)]]
;     fun := do_compile([op', ['category_functor, sargl, body]], e)
;
; --  5. give operator a 'modemap property
;     pairlis:= [[a,:v] for a in argl for v in $FormalMapVariableList]
;     parSignature:= SUBLIS(pairlis,signature')
;     parForm:= SUBLIS(pairlis,form)
;     --Equivalent to the following two lines, we hope
;     if null sargl then
;       evalAndRwriteLispForm('NILADIC,
;             ['MAKEPROP,['QUOTE,op'],'(QUOTE NILADIC),true])
;
; --   6. put modemaps into InteractiveModemapFrame
;     $lisplibCategory:= formalBody
;     if $LISPLIB then
;       $lisplibForm:= form
;       $lisplibKind:= 'category
;       modemap:= [[parForm,:parSignature],[true,op']]
;       $lisplibModemap:= modemap
;       $lisplibParents  :=
;         getParentsFor($op,$FormalMapVariableList,$lisplibCategory)
;       $lisplibAncestors := computeAncestorsOf(sform, nil)
;       $lisplibAbbreviation := constructor? $op
;       domainShell := eval [op', :MAPCAR('MKQ, sargl)]
;       augLisplibModemapsFromCategory(sform, formalBody, signature',
;                                      domainShell)
;     [fun, '(Category), e]

(DEFUN |compDefineCategory2|
       (|form| |signature| |body| |m| |e| |$prefix| |$formalArgList|)
  (DECLARE (SPECIAL |$prefix| |$formalArgList|))
  (PROG (|$functor_cosig1| |$addForm| |$functorStats| |$functionStats|
         |$functorForm| |$op| |$extraParms| |$definition|
         |$insideCategoryIfTrue| |domainShell| |modemap| |parForm|
         |parSignature| |pairlis| |fun| |g| |formals| |actuals| |op'|
         |LETTMP#1| |formalBody| |aList| |sform| |sargl| |signature'| |argl|)
    (DECLARE
     (SPECIAL |$functor_cosig1| |$addForm| |$functorStats| |$functionStats|
      |$functorForm| |$op| |$extraParms| |$definition|
      |$insideCategoryIfTrue|))
    (RETURN
     (PROGN
      (SETQ |$insideCategoryIfTrue| T)
      (SETQ |$definition| |form|)
      (SETQ |$extraParms| NIL)
      (SETQ |$op| NIL)
      (SETQ |$op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |e| (|addBinding| '$ (LIST (CONS '|mode| |form|)) |e|))
      (SETQ |signature'|
              (CONS (CAR |signature|)
                    ((LAMBDA (|bfVar#21| |bfVar#20| |a|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#20|)
                              (PROGN (SETQ |a| (CAR |bfVar#20|)) NIL))
                          (RETURN (NREVERSE |bfVar#21|)))
                         (#1='T
                          (SETQ |bfVar#21|
                                  (CONS
                                   (|getArgumentModeOrMoan| |a| |form| |e|)
                                   |bfVar#21|))))
                        (SETQ |bfVar#20| (CDR |bfVar#20|))))
                     NIL |argl| NIL)))
      (SETQ |e| (|giveFormalParametersValues| |argl| |e|))
      (SETQ |sargl| (TAKE (LENGTH |argl|) |$TriangleVariableList|))
      (SETQ |sform| (CONS |$op| |sargl|))
      (SETQ |$functorForm| |sform|)
      (SETQ |$formalArgList| (APPEND |sargl| |$formalArgList|))
      (SETQ |aList|
              ((LAMBDA (|bfVar#24| |bfVar#22| |a| |bfVar#23| |sa|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#22|)
                        (PROGN (SETQ |a| (CAR |bfVar#22|)) NIL)
                        (ATOM |bfVar#23|)
                        (PROGN (SETQ |sa| (CAR |bfVar#23|)) NIL))
                    (RETURN (NREVERSE |bfVar#24|)))
                   (#1# (SETQ |bfVar#24| (CONS (CONS |a| |sa|) |bfVar#24|))))
                  (SETQ |bfVar#22| (CDR |bfVar#22|))
                  (SETQ |bfVar#23| (CDR |bfVar#23|))))
               NIL |argl| NIL |sargl| NIL))
      (SETQ |formalBody| (SUBLIS |aList| |body|))
      (SETQ |signature'| (SUBLIS |aList| |signature'|))
      (SETQ |$functionStats| (LIST 0 0))
      (SETQ |$functorStats| (LIST 0 0))
      (SETQ |$addForm| NIL)
      (SETQ |$functor_cosig1|
              ((LAMBDA (|bfVar#26| |bfVar#25| |t|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#25|)
                        (PROGN (SETQ |t| (CAR |bfVar#25|)) NIL))
                    (RETURN (NREVERSE |bfVar#26|)))
                   (#1#
                    (SETQ |bfVar#26| (CONS (|categoryForm?| |t|) |bfVar#26|))))
                  (SETQ |bfVar#25| (CDR |bfVar#25|))))
               NIL (CDR |signature'|) NIL))
      ((LAMBDA (|bfVar#27| |x| |bfVar#28| |t|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#27|) (PROGN (SETQ |x| (CAR |bfVar#27|)) NIL)
                (ATOM |bfVar#28|) (PROGN (SETQ |t| (CAR |bfVar#28|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |LETTMP#1|
                     (|compMakeDeclaration| (LIST '|:| |x| |t|) |m| |e|))
             (SETQ |e| (CADDR |LETTMP#1|))
             |LETTMP#1|)))
          (SETQ |bfVar#27| (CDR |bfVar#27|))
          (SETQ |bfVar#28| (CDR |bfVar#28|))))
       |sargl| NIL (CDR |signature'|) NIL)
      (SETQ |op'| |$op|)
      (COND
       ((AND (NOT (EQ (|opOf| |formalBody|) '|Join|))
             (NOT (EQ (|opOf| |formalBody|) '|mkCategory|)))
        (SETQ |formalBody| (LIST '|Join| |formalBody|))))
      (SETQ |body|
              (|optFunctorBody|
               (CAR (|compOrCroak| |formalBody| (CAR |signature'|) |e|))))
      (COND
       (|$extraParms| (SETQ |formals| (SETQ |actuals| NIL))
        ((LAMBDA (|bfVar#29| |u|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#29|) (PROGN (SETQ |u| (CAR |bfVar#29|)) NIL))
              (RETURN NIL))
             (#1#
              (PROGN
               (SETQ |formals| (CONS (CAR |u|) |formals|))
               (SETQ |actuals| (CONS (MKQ (CDR |u|)) |actuals|)))))
            (SETQ |bfVar#29| (CDR |bfVar#29|))))
         |$extraParms| NIL)
        (SETQ |body|
                (LIST '|subst_in_cat| (LIST 'QUOTE |formals|)
                      (CONS 'LIST |actuals|) |body|))))
      (COND
       (|argl|
        (SETQ |body|
                (LIST '|subst_in_cat| (LIST 'QUOTE |sargl|)
                      (CONS 'LIST |sargl|) |body|))))
      (SETQ |body|
              (LIST 'PROG1 (LIST 'LET (SETQ |g| (GENSYM)) |body|)
                    (LIST 'SETELT |g| 0 (|mkConstructor| |sform|))))
      (SETQ |fun|
              (|do_compile|
               (LIST |op'| (LIST '|category_functor| |sargl| |body|)) |e|))
      (SETQ |pairlis|
              ((LAMBDA (|bfVar#32| |bfVar#30| |a| |bfVar#31| |v|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#30|)
                        (PROGN (SETQ |a| (CAR |bfVar#30|)) NIL)
                        (ATOM |bfVar#31|)
                        (PROGN (SETQ |v| (CAR |bfVar#31|)) NIL))
                    (RETURN (NREVERSE |bfVar#32|)))
                   (#1# (SETQ |bfVar#32| (CONS (CONS |a| |v|) |bfVar#32|))))
                  (SETQ |bfVar#30| (CDR |bfVar#30|))
                  (SETQ |bfVar#31| (CDR |bfVar#31|))))
               NIL |argl| NIL |$FormalMapVariableList| NIL))
      (SETQ |parSignature| (SUBLIS |pairlis| |signature'|))
      (SETQ |parForm| (SUBLIS |pairlis| |form|))
      (COND
       ((NULL |sargl|)
        (|evalAndRwriteLispForm| 'NILADIC
         (LIST 'MAKEPROP (LIST 'QUOTE |op'|) ''NILADIC T))))
      (SETQ |$lisplibCategory| |formalBody|)
      (COND
       ($LISPLIB (SETQ |$lisplibForm| |form|) (SETQ |$lisplibKind| '|category|)
        (SETQ |modemap| (LIST (CONS |parForm| |parSignature|) (LIST T |op'|)))
        (SETQ |$lisplibModemap| |modemap|)
        (SETQ |$lisplibParents|
                (|getParentsFor| |$op| |$FormalMapVariableList|
                 |$lisplibCategory|))
        (SETQ |$lisplibAncestors| (|computeAncestorsOf| |sform| NIL))
        (SETQ |$lisplibAbbreviation| (|constructor?| |$op|))
        (SETQ |domainShell| (|eval| (CONS |op'| (MAPCAR 'MKQ |sargl|))))
        (|augLisplibModemapsFromCategory| |sform| |formalBody| |signature'|
         |domainShell|)))
      (LIST |fun| '(|Category|) |e|)))))

; mkConstructor form ==
;   atom form => BREAK()
;   null rest form => ['QUOTE,[first form]]
;   ['LIST, MKQ first form, :rest(form)]

(DEFUN |mkConstructor| (|form|)
  (PROG ()
    (RETURN
     (COND ((ATOM |form|) (BREAK))
           ((NULL (CDR |form|)) (LIST 'QUOTE (LIST (CAR |form|))))
           ('T (CONS 'LIST (CONS (MKQ (CAR |form|)) (CDR |form|))))))))

; compDefineCategory(df,m,e,prefix,fal) ==
;   $lisplibCategory: local := nil
;   not $insideFunctorIfTrue and $LISPLIB =>
;     compDefineLisplib(df,m,e,prefix,fal,'compDefineCategory1)
;   compDefineCategory1(df,m,e,prefix,fal)

(DEFUN |compDefineCategory| (|df| |m| |e| |prefix| |fal|)
  (PROG (|$lisplibCategory|)
    (DECLARE (SPECIAL |$lisplibCategory|))
    (RETURN
     (PROGN
      (SETQ |$lisplibCategory| NIL)
      (COND
       ((AND (NULL |$insideFunctorIfTrue|) $LISPLIB)
        (|compDefineLisplib| |df| |m| |e| |prefix| |fal|
         '|compDefineCategory1|))
       ('T (|compDefineCategory1| |df| |m| |e| |prefix| |fal|)))))))

; compDefineFunctor(df,m,e,prefix,fal) ==
;   $domainShell: local -- holds the category of the object being compiled
;   $LISPLIB => compDefineLisplib(df,m,e,prefix,fal,'compDefineFunctor1)
;   compDefineFunctor1(df,m,e,prefix,fal)

(DEFUN |compDefineFunctor| (|df| |m| |e| |prefix| |fal|)
  (PROG (|$domainShell|)
    (DECLARE (SPECIAL |$domainShell|))
    (RETURN
     (PROGN
      (SETQ |$domainShell| NIL)
      (COND
       ($LISPLIB
        (|compDefineLisplib| |df| |m| |e| |prefix| |fal|
         '|compDefineFunctor1|))
       ('T (|compDefineFunctor1| |df| |m| |e| |prefix| |fal|)))))))

; compDefineFunctor1(df is ['DEF, form, signature, body],
;   m, e, $prefix, $formalArgList) ==
; --  1. bind global variables
;     $addForm: local := nil
;
;     $functionStats: local:= [0,0]
;     $functorStats: local:= [0,0]
;     $signature: local := nil
;     $Representation: local := nil
;          --Set in doIt, accessed in the compiler - compNoStacking
;     $functorLocalParameters: local := nil
;     $CheckVectorList: local := nil
;                   --prevents CheckVector from printing out same message twice
;     $insideFunctorIfTrue: local:= true
;     $genSDVar: local:= 0
;     originale := e
;     $op: local := nil
;     [$op,:argl]:= form
;     $formalArgList:= [:argl,:$formalArgList]
;     $pairlis := [[a,:v] for a in argl for v in $FormalMapVariableList]
;     $mutableDomain: local :=
;       -- all defaulting packages should have caching turned off
;        isCategoryPackageName $op or
;          (if BOUNDP '$mutableDomains then MEMQ($op,$mutableDomains)
;             else false )   --true if domain has mutable state
;     signature':=
;       [first signature, :[getArgumentModeOrMoan(a, form, e) for a in argl]]
;     $functorForm : local := form
;     if null first signature' then BREAK()
;     target:= first signature'
;     e := giveFormalParametersValues(argl, e)
;     [ds, ., e] := compMakeCategoryObject(target, e) or
;       sayBrightly '"   cannot produce category object:"
;       pp target
;       userError '"cannot produce category object"
; --+ copy needed since slot1 is reset; compMake.. can return a cached vector
;     base_shell := COPY_-SEQ ds
;     $domainShell := base_shell
; --+ 7 lines for $NRT follow
; -->--these globals used by NRTmakeCategoryAlist, set by NRTsetVector4Part1
;     $condAlist: local := nil
;     $uncondAlist: local := nil
; -->>-- next global initialized here, reset by NRTbuildFunctor
;     $NRTslot1PredicateList: local := nil
;        --this is used below to set $lisplibSlot1 global
;     $NRTbase: local := 6 -- equals length of $domainShell
;     $NRTaddForm: local := nil   -- see compAdd; NRTmakeSlot1
;     $NRTdeltaLength: local := 0 -- length of $NRTdeltaList
;     $NRTdeltaList: local := nil --list of misc. elts used in compiled fncts
;     -- parallel to $NRTdeltaList, list of COMP-ed forms for $NRTdeltaList
;     $NRTdeltaListComp: local := nil
;     -- the above optimizes the calls to local domains
;     $template: local:= nil --stored in the lisplib (if $NRTvec = true)
;     $functionLocations: local := nil --locations of defined functions in source
;     $functor_cosig1 : local := [categoryForm?(t) for t in rest(signature')]
;     -- generate slots for arguments first, then for $NRTaddForm in compAdd
;     for x in argl repeat NRTgetLocalIndex(x, e)
;     [., ., e] := compMakeDeclaration([":", '_$, target], m, e)
;
;
;     if $insideCategoryPackageIfTrue~= true  then
;         e := augModemapsFromCategory('_$, '_$, target, e)
;     $signature:= signature'
;     parSignature:= SUBLIS($pairlis,signature')
;     parForm:= SUBLIS($pairlis,form)
;
; --  (3.1) now make a list of the functor's local parameters; for
; --  domain D in argl,check its signature: if domain, its type is Join(A1,..,An);
; --  in this case, D is replaced by D1,..,Dn (gensyms) which are set
; --  to the A1,..,An view of D
; --+
;     $functorLocalParameters := argl
;     dollar :=
;         $insideCategoryPackageIfTrue => first(argl)
;         "$$"
;     e := makeFunctorArgumentParameters(argl, rest signature',
;                                      first signature', dollar, e)
;  -- must do above to bring categories into scope --see line 5 of genDomainView
; --  4. compile body in environment of type declarations for arguments
;     op':= $op
;     rettype:= signature'.target
;     T := compFunctorBody(body, rettype, e, base_shell)
;
;     body':= T.expr
;     lamOrSlam :=
;         $mutableDomain => 'mutable_domain_functor
;         'domain_functor
;     fun := do_compile(SUBLIS($pairlis, [op', [lamOrSlam, argl, body']]), e)
;     --The above statement stops substitutions getting in one another's way
; --+
;     operationAlist := SUBLIS($pairlis,$lisplibOperationAlist)
;     if $LISPLIB then
;       augmentLisplibModemapsFromFunctor(parForm,operationAlist,parSignature)
;     $functorStats := addStats($functorStats, $functionStats)
;     reportOnFunctorCompilation($functorStats)
;
; --  5. give operator a 'modemap property
;     if $LISPLIB then
;       modemap:= [[parForm,:parSignature],[true,op']]
;       $lisplibModemap:= modemap
;       $lisplibCategory := modemap.mmTarget
;       $lisplibParents  :=
;         getParentsFor($op,$FormalMapVariableList,$lisplibCategory)
;       $lisplibAncestors := computeAncestorsOf(form, nil)
;       $lisplibAbbreviation := constructor? $op
;     $insideFunctorIfTrue:= false
;     if $LISPLIB then
;       $lisplibKind:=
; ------->This next line prohibits changing the KIND once given
; --------kk:=GETDATABASE($op,'CONSTRUCTORKIND) => kk
;         target is ["CATEGORY",key,:.] and key~="domain" => 'package
;         'domain
;       $lisplibForm:= form
;       if null $bootStrapMode then
;         NRTslot1Info := NRTmakeSlot1Info(form, base_shell)
;         $lookupFunction: local :=
;             NRTgetLookupFunction(form, CADAR $lisplibModemap, $NRTaddForm)
;             --either lookupComplete (for forgetful guys) or lookupIncomplete
;         $byteAddress :local := 0
;         $byteVec :local := nil
;         $NRTslot1PredicateList :=
;           [simpBool x for x in $NRTslot1PredicateList]
;         output_lisp_form(['MAKEPROP, MKQ $op, ''infovec,
;                           getInfovecCode(NRTslot1Info, e)])
;       $lisplibOperationAlist:= operationAlist
;       $lisplibMissingFunctions:= $CheckVectorList
;     if null argl then
;       evalAndRwriteLispForm('NILADIC,
;             ['MAKEPROP, ['QUOTE,op'], ['QUOTE,'NILADIC], true])
;     [fun, ['Mapping, :signature'], originale]

(DEFUN |compDefineFunctor1| (|df| |m| |e| |$prefix| |$formalArgList|)
  (DECLARE (SPECIAL |$prefix| |$formalArgList|))
  (PROG (|$byteVec| |$byteAddress| |$lookupFunction| |$functor_cosig1|
         |$functionLocations| |$template| |$NRTdeltaListComp| |$NRTdeltaList|
         |$NRTdeltaLength| |$NRTaddForm| |$NRTbase| |$NRTslot1PredicateList|
         |$uncondAlist| |$condAlist| |$functorForm| |$mutableDomain| |$op|
         |$genSDVar| |$insideFunctorIfTrue| |$CheckVectorList|
         |$functorLocalParameters| |$Representation| |$signature|
         |$functorStats| |$functionStats| |$addForm| |NRTslot1Info| |key|
         |ISTMP#1| |modemap| |operationAlist| |fun| |lamOrSlam| |body'| T$
         |rettype| |op'| |dollar| |parForm| |parSignature| |base_shell| |ds|
         |LETTMP#1| |target| |signature'| |argl| |originale| |body| |signature|
         |form|)
    (DECLARE
     (SPECIAL |$byteVec| |$byteAddress| |$lookupFunction| |$functor_cosig1|
      |$functionLocations| |$template| |$NRTdeltaListComp| |$NRTdeltaList|
      |$NRTdeltaLength| |$NRTaddForm| |$NRTbase| |$NRTslot1PredicateList|
      |$uncondAlist| |$condAlist| |$functorForm| |$mutableDomain| |$op|
      |$genSDVar| |$insideFunctorIfTrue| |$CheckVectorList|
      |$functorLocalParameters| |$Representation| |$signature| |$functorStats|
      |$functionStats| |$addForm|))
    (RETURN
     (PROGN
      (SETQ |form| (CADR . #1=(|df|)))
      (SETQ |signature| (CADDR . #1#))
      (SETQ |body| (CADDDR . #1#))
      (SETQ |$addForm| NIL)
      (SETQ |$functionStats| (LIST 0 0))
      (SETQ |$functorStats| (LIST 0 0))
      (SETQ |$signature| NIL)
      (SETQ |$Representation| NIL)
      (SETQ |$functorLocalParameters| NIL)
      (SETQ |$CheckVectorList| NIL)
      (SETQ |$insideFunctorIfTrue| T)
      (SETQ |$genSDVar| 0)
      (SETQ |originale| |e|)
      (SETQ |$op| NIL)
      (SETQ |$op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |$formalArgList| (APPEND |argl| |$formalArgList|))
      (SETQ |$pairlis|
              ((LAMBDA (|bfVar#35| |bfVar#33| |a| |bfVar#34| |v|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#33|)
                        (PROGN (SETQ |a| (CAR |bfVar#33|)) NIL)
                        (ATOM |bfVar#34|)
                        (PROGN (SETQ |v| (CAR |bfVar#34|)) NIL))
                    (RETURN (NREVERSE |bfVar#35|)))
                   (#2='T (SETQ |bfVar#35| (CONS (CONS |a| |v|) |bfVar#35|))))
                  (SETQ |bfVar#33| (CDR |bfVar#33|))
                  (SETQ |bfVar#34| (CDR |bfVar#34|))))
               NIL |argl| NIL |$FormalMapVariableList| NIL))
      (SETQ |$mutableDomain|
              (OR (|isCategoryPackageName| |$op|)
                  (COND
                   ((BOUNDP '|$mutableDomains|) (MEMQ |$op| |$mutableDomains|))
                   (#2# NIL))))
      (SETQ |signature'|
              (CONS (CAR |signature|)
                    ((LAMBDA (|bfVar#37| |bfVar#36| |a|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#36|)
                              (PROGN (SETQ |a| (CAR |bfVar#36|)) NIL))
                          (RETURN (NREVERSE |bfVar#37|)))
                         (#2#
                          (SETQ |bfVar#37|
                                  (CONS
                                   (|getArgumentModeOrMoan| |a| |form| |e|)
                                   |bfVar#37|))))
                        (SETQ |bfVar#36| (CDR |bfVar#36|))))
                     NIL |argl| NIL)))
      (SETQ |$functorForm| |form|)
      (COND ((NULL (CAR |signature'|)) (BREAK)))
      (SETQ |target| (CAR |signature'|))
      (SETQ |e| (|giveFormalParametersValues| |argl| |e|))
      (SETQ |LETTMP#1|
              (OR (|compMakeCategoryObject| |target| |e|)
                  (PROGN
                   (|sayBrightly| "   cannot produce category object:")
                   (|pp| |target|)
                   (|userError| "cannot produce category object"))))
      (SETQ |ds| (CAR |LETTMP#1|))
      (SETQ |e| (CADDR |LETTMP#1|))
      (SETQ |base_shell| (COPY-SEQ |ds|))
      (SETQ |$domainShell| |base_shell|)
      (SETQ |$condAlist| NIL)
      (SETQ |$uncondAlist| NIL)
      (SETQ |$NRTslot1PredicateList| NIL)
      (SETQ |$NRTbase| 6)
      (SETQ |$NRTaddForm| NIL)
      (SETQ |$NRTdeltaLength| 0)
      (SETQ |$NRTdeltaList| NIL)
      (SETQ |$NRTdeltaListComp| NIL)
      (SETQ |$template| NIL)
      (SETQ |$functionLocations| NIL)
      (SETQ |$functor_cosig1|
              ((LAMBDA (|bfVar#39| |bfVar#38| |t|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#38|)
                        (PROGN (SETQ |t| (CAR |bfVar#38|)) NIL))
                    (RETURN (NREVERSE |bfVar#39|)))
                   (#2#
                    (SETQ |bfVar#39| (CONS (|categoryForm?| |t|) |bfVar#39|))))
                  (SETQ |bfVar#38| (CDR |bfVar#38|))))
               NIL (CDR |signature'|) NIL))
      ((LAMBDA (|bfVar#40| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#40|) (PROGN (SETQ |x| (CAR |bfVar#40|)) NIL))
            (RETURN NIL))
           (#2# (|NRTgetLocalIndex| |x| |e|)))
          (SETQ |bfVar#40| (CDR |bfVar#40|))))
       |argl| NIL)
      (SETQ |LETTMP#1| (|compMakeDeclaration| (LIST '|:| '$ |target|) |m| |e|))
      (SETQ |e| (CADDR |LETTMP#1|))
      (COND
       ((NOT (EQUAL |$insideCategoryPackageIfTrue| T))
        (SETQ |e| (|augModemapsFromCategory| '$ '$ |target| |e|))))
      (SETQ |$signature| |signature'|)
      (SETQ |parSignature| (SUBLIS |$pairlis| |signature'|))
      (SETQ |parForm| (SUBLIS |$pairlis| |form|))
      (SETQ |$functorLocalParameters| |argl|)
      (SETQ |dollar|
              (COND (|$insideCategoryPackageIfTrue| (CAR |argl|)) (#2# '$$)))
      (SETQ |e|
              (|makeFunctorArgumentParameters| |argl| (CDR |signature'|)
               (CAR |signature'|) |dollar| |e|))
      (SETQ |op'| |$op|)
      (SETQ |rettype| (CAR |signature'|))
      (SETQ T$ (|compFunctorBody| |body| |rettype| |e| |base_shell|))
      (SETQ |body'| (CAR T$))
      (SETQ |lamOrSlam|
              (COND (|$mutableDomain| '|mutable_domain_functor|)
                    (#2# '|domain_functor|)))
      (SETQ |fun|
              (|do_compile|
               (SUBLIS |$pairlis|
                       (LIST |op'| (LIST |lamOrSlam| |argl| |body'|)))
               |e|))
      (SETQ |operationAlist| (SUBLIS |$pairlis| |$lisplibOperationAlist|))
      (COND
       ($LISPLIB
        (|augmentLisplibModemapsFromFunctor| |parForm| |operationAlist|
         |parSignature|)))
      (SETQ |$functorStats| (|addStats| |$functorStats| |$functionStats|))
      (|reportOnFunctorCompilation| |$functorStats|)
      (COND
       ($LISPLIB
        (SETQ |modemap| (LIST (CONS |parForm| |parSignature|) (LIST T |op'|)))
        (SETQ |$lisplibModemap| |modemap|)
        (SETQ |$lisplibCategory| (CADAR |modemap|))
        (SETQ |$lisplibParents|
                (|getParentsFor| |$op| |$FormalMapVariableList|
                 |$lisplibCategory|))
        (SETQ |$lisplibAncestors| (|computeAncestorsOf| |form| NIL))
        (SETQ |$lisplibAbbreviation| (|constructor?| |$op|))))
      (SETQ |$insideFunctorIfTrue| NIL)
      (COND
       ($LISPLIB
        (SETQ |$lisplibKind|
                (COND
                 ((AND (CONSP |target|) (EQ (CAR |target|) 'CATEGORY)
                       (PROGN
                        (SETQ |ISTMP#1| (CDR |target|))
                        (AND (CONSP |ISTMP#1|)
                             (PROGN (SETQ |key| (CAR |ISTMP#1|)) #2#)))
                       (NOT (EQ |key| '|domain|)))
                  '|package|)
                 (#2# '|domain|)))
        (SETQ |$lisplibForm| |form|)
        (COND
         ((NULL |$bootStrapMode|)
          (SETQ |NRTslot1Info| (|NRTmakeSlot1Info| |form| |base_shell|))
          (SETQ |$lookupFunction|
                  (|NRTgetLookupFunction| |form| (CADAR |$lisplibModemap|)
                   |$NRTaddForm|))
          (SETQ |$byteAddress| 0) (SETQ |$byteVec| NIL)
          (SETQ |$NRTslot1PredicateList|
                  ((LAMBDA (|bfVar#42| |bfVar#41| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#41|)
                            (PROGN (SETQ |x| (CAR |bfVar#41|)) NIL))
                        (RETURN (NREVERSE |bfVar#42|)))
                       (#2#
                        (SETQ |bfVar#42| (CONS (|simpBool| |x|) |bfVar#42|))))
                      (SETQ |bfVar#41| (CDR |bfVar#41|))))
                   NIL |$NRTslot1PredicateList| NIL))
          (|output_lisp_form|
           (LIST 'MAKEPROP (MKQ |$op|) ''|infovec|
                 (|getInfovecCode| |NRTslot1Info| |e|)))))
        (SETQ |$lisplibOperationAlist| |operationAlist|)
        (SETQ |$lisplibMissingFunctions| |$CheckVectorList|)))
      (COND
       ((NULL |argl|)
        (|evalAndRwriteLispForm| 'NILADIC
         (LIST 'MAKEPROP (LIST 'QUOTE |op'|) (LIST 'QUOTE 'NILADIC) T))))
      (LIST |fun| (CONS '|Mapping| |signature'|) |originale|)))))

; compFunctorBody(body, m, e, base_shell) ==
;   $bootStrapMode = true =>
;     genOperationAlist(base_shell)
;     [bootStrapError($functorForm, $edit_file), m, e]
;   T:= compOrCroak(body,m,e)
;   body is [op,:.] and MEMQ(op,'(add CAPSULE)) => T
;   $NRTaddForm :=
;     body is ["SubDomain",domainForm,predicate] => domainForm
;     body
;   T

(DEFUN |compFunctorBody| (|body| |m| |e| |base_shell|)
  (PROG (T$ |op| |ISTMP#1| |domainForm| |ISTMP#2| |predicate|)
    (RETURN
     (COND
      ((EQUAL |$bootStrapMode| T)
       (PROGN
        (|genOperationAlist| |base_shell|)
        (LIST (|bootStrapError| |$functorForm| |$edit_file|) |m| |e|)))
      (#1='T
       (PROGN
        (SETQ T$ (|compOrCroak| |body| |m| |e|))
        (COND
         ((AND (CONSP |body|) (PROGN (SETQ |op| (CAR |body|)) #1#)
               (MEMQ |op| '(|add| CAPSULE)))
          T$)
         (#1#
          (PROGN
           (SETQ |$NRTaddForm|
                   (COND
                    ((AND (CONSP |body|) (EQ (CAR |body|) '|SubDomain|)
                          (PROGN
                           (SETQ |ISTMP#1| (CDR |body|))
                           (AND (CONSP |ISTMP#1|)
                                (PROGN
                                 (SETQ |domainForm| (CAR |ISTMP#1|))
                                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                 (AND (CONSP |ISTMP#2|)
                                      (EQ (CDR |ISTMP#2|) NIL)
                                      (PROGN
                                       (SETQ |predicate| (CAR |ISTMP#2|))
                                       #1#))))))
                     |domainForm|)
                    (#1# |body|)))
           T$)))))))))

; reportOnFunctorCompilation(functorStats) ==
;   displayMissingFunctions()
;   if $semanticErrorStack then sayBrightly '" "
;   displaySemanticErrors()
;   if $warningStack then sayBrightly '" "
;   displayWarnings()
;   [byteCount, elapsedSeconds] := functorStats
;   sayBrightly ['%l,:bright '"  Cumulative Statistics for Constructor",
;     $op]
;   timeString := normalizeStatAndStringify elapsedSeconds
;   sayBrightly ['"      Time:",:bright timeString,'"seconds"]
;   sayBrightly '" "
;   'done

(DEFUN |reportOnFunctorCompilation| (|functorStats|)
  (PROG (|byteCount| |elapsedSeconds| |timeString|)
    (RETURN
     (PROGN
      (|displayMissingFunctions|)
      (COND (|$semanticErrorStack| (|sayBrightly| " ")))
      (|displaySemanticErrors|)
      (COND (|$warningStack| (|sayBrightly| " ")))
      (|displayWarnings|)
      (SETQ |byteCount| (CAR |functorStats|))
      (SETQ |elapsedSeconds| (CADR |functorStats|))
      (|sayBrightly|
       (CONS '|%l|
             (APPEND (|bright| "  Cumulative Statistics for Constructor")
                     (CONS |$op| NIL))))
      (SETQ |timeString| (|normalizeStatAndStringify| |elapsedSeconds|))
      (|sayBrightly|
       (CONS "      Time:"
             (APPEND (|bright| |timeString|) (CONS "seconds" NIL))))
      (|sayBrightly| " ")
      '|done|))))

; displayMissingFunctions() ==
;   null $CheckVectorList => nil
;   loc := nil
;   exp := nil
;   for [[op,sig,:.],:pred] in $CheckVectorList  | null pred repeat
;     null member(op,$formalArgList) and
;       getmode(op,$env) is ['Mapping,:.] =>
;         loc := [[op,sig],:loc]
;     exp := [[op,sig],:exp]
;   if loc then
;     sayBrightly ['%l,:bright '"  Missing Local Functions:"]
;     for [op,sig] in loc for i in 1.. repeat
;       sayBrightly ['"      [",i,'"]",:bright op,
;         ": ",:formatUnabbreviatedSig sig]
;   if exp then
;     sayBrightly ['%l,:bright '"  Missing Exported Functions:"]
;     for [op,sig] in exp for i in 1.. repeat
;       sayBrightly ['"      [",i,'"]",:bright op,
;         ": ",:formatUnabbreviatedSig sig]

(DEFUN |displayMissingFunctions| ()
  (PROG (|pred| |sig| |ISTMP#2| |op| |ISTMP#1| |exp| |loc|)
    (RETURN
     (COND ((NULL |$CheckVectorList|) NIL)
           (#1='T
            (PROGN
             (SETQ |loc| NIL)
             (SETQ |exp| NIL)
             ((LAMBDA (|bfVar#44| |bfVar#43|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#44|)
                       (PROGN (SETQ |bfVar#43| (CAR |bfVar#44|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |bfVar#43|)
                        (PROGN
                         (SETQ |ISTMP#1| (CAR |bfVar#43|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |op| (CAR |ISTMP#1|))
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|)
                                    (PROGN
                                     (SETQ |sig| (CAR |ISTMP#2|))
                                     #1#)))))
                        (PROGN (SETQ |pred| (CDR |bfVar#43|)) #1#)
                        (NULL |pred|)
                        (COND
                         ((AND (NULL (|member| |op| |$formalArgList|))
                               (PROGN
                                (SETQ |ISTMP#1| (|getmode| |op| |$env|))
                                (AND (CONSP |ISTMP#1|)
                                     (EQ (CAR |ISTMP#1|) '|Mapping|))))
                          (SETQ |loc| (CONS (LIST |op| |sig|) |loc|)))
                         (#1# (SETQ |exp| (CONS (LIST |op| |sig|) |exp|)))))))
                 (SETQ |bfVar#44| (CDR |bfVar#44|))))
              |$CheckVectorList| NIL)
             (COND
              (|loc|
               (|sayBrightly|
                (CONS '|%l| (|bright| "  Missing Local Functions:")))
               ((LAMBDA (|bfVar#46| |bfVar#45| |i|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#46|)
                         (PROGN (SETQ |bfVar#45| (CAR |bfVar#46|)) NIL))
                     (RETURN NIL))
                    (#1#
                     (AND (CONSP |bfVar#45|)
                          (PROGN
                           (SETQ |op| (CAR |bfVar#45|))
                           (SETQ |ISTMP#1| (CDR |bfVar#45|))
                           (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                (PROGN (SETQ |sig| (CAR |ISTMP#1|)) #1#)))
                          (|sayBrightly|
                           (CONS "      ["
                                 (CONS |i|
                                       (CONS "]"
                                             (APPEND (|bright| |op|)
                                                     (CONS '|: |
                                                           (|formatUnabbreviatedSig|
                                                            |sig|))))))))))
                   (SETQ |bfVar#46| (CDR |bfVar#46|))
                   (SETQ |i| (+ |i| 1))))
                |loc| NIL 1)))
             (COND
              (|exp|
               (|sayBrightly|
                (CONS '|%l| (|bright| "  Missing Exported Functions:")))
               ((LAMBDA (|bfVar#48| |bfVar#47| |i|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#48|)
                         (PROGN (SETQ |bfVar#47| (CAR |bfVar#48|)) NIL))
                     (RETURN NIL))
                    (#1#
                     (AND (CONSP |bfVar#47|)
                          (PROGN
                           (SETQ |op| (CAR |bfVar#47|))
                           (SETQ |ISTMP#1| (CDR |bfVar#47|))
                           (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                (PROGN (SETQ |sig| (CAR |ISTMP#1|)) #1#)))
                          (|sayBrightly|
                           (CONS "      ["
                                 (CONS |i|
                                       (CONS "]"
                                             (APPEND (|bright| |op|)
                                                     (CONS '|: |
                                                           (|formatUnabbreviatedSig|
                                                            |sig|))))))))))
                   (SETQ |bfVar#48| (CDR |bfVar#48|))
                   (SETQ |i| (+ |i| 1))))
                |exp| NIL 1)))))))))

; makeFunctorArgumentParameters(argl, sigl, target, dollar, e) ==
;   $forceAdd: local:= true
;   $ConditionalOperators: local := nil
;   $tmp_e := e
;   for a in argl for s in sigl repeat fn(a, dollar,
;                                    augmentSig(s,findExtras(a,target)))
;           where
;     findExtras(a,target) ==
;       --  see if conditional information implies anything else
;       --  in the signature of a
;       target is ['Join,:l] => "union"/[findExtras(a,x) for x in l]
;       target is ['CATEGORY,.,:l] => "union"/[findExtras1(a,x) for x in l] where
;         findExtras1(a,x) ==
;           x is ['AND,:l] => "union"/[findExtras1(a,y) for y in l]
;           x is ['OR,:l] => "union"/[findExtras1(a,y) for y in l]
;           x is ['IF,c,p,q] =>
;             union(findExtrasP(a,c),
;                   union(findExtras1(a,p),findExtras1(a,q))) where
;               findExtrasP(a,x) ==
;                 x is ['AND,:l] => "union"/[findExtrasP(a,y) for y in l]
;                 x is ['OR,:l] => "union"/[findExtrasP(a,y) for y in l]
;                 x is ['has,=a,y] and y is ['SIGNATURE,:.] => [y]
;                 nil
;         nil
;     augmentSig(s,ss) ==
;        -- if we find something extra, add it to the signature
;       null ss => s
;       for u in ss repeat
;         $ConditionalOperators:=[CDR u,:$ConditionalOperators]
;       s is ['Join,:sl] =>
;         u := ASSQ('CATEGORY, ss) => BREAK()
;         ['Join,:sl,['CATEGORY,'package,:ss]]
;       ['Join,s,['CATEGORY,'package,:ss]]
;     fn(a, dollar, s) ==
;       not(ATOM(a)) => BREAK()
;       if isCategoryForm(s) then
;         s is ["Join", :catlist] => genDomainViewList(a, dollar, rest s)
;         genDomainView(a, dollar, s)
;   $tmp_e

(DEFUN |makeFunctorArgumentParameters| (|argl| |sigl| |target| |dollar| |e|)
  (PROG (|$ConditionalOperators| |$forceAdd|)
    (DECLARE (SPECIAL |$ConditionalOperators| |$forceAdd|))
    (RETURN
     (PROGN
      (SETQ |$forceAdd| T)
      (SETQ |$ConditionalOperators| NIL)
      (SETQ |$tmp_e| |e|)
      ((LAMBDA (|bfVar#49| |a| |bfVar#50| |s|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#49|) (PROGN (SETQ |a| (CAR |bfVar#49|)) NIL)
                (ATOM |bfVar#50|) (PROGN (SETQ |s| (CAR |bfVar#50|)) NIL))
            (RETURN NIL))
           ('T
            (|makeFunctorArgumentParameters,fn| |a| |dollar|
             (|makeFunctorArgumentParameters,augmentSig| |s|
              (|makeFunctorArgumentParameters,findExtras| |a| |target|)))))
          (SETQ |bfVar#49| (CDR |bfVar#49|))
          (SETQ |bfVar#50| (CDR |bfVar#50|))))
       |argl| NIL |sigl| NIL)
      |$tmp_e|))))
(DEFUN |makeFunctorArgumentParameters,findExtras| (|a| |target|)
  (PROG (|l| |ISTMP#1|)
    (RETURN
     (COND
      ((AND (CONSP |target|) (EQ (CAR |target|) '|Join|)
            (PROGN (SETQ |l| (CDR |target|)) #1='T))
       ((LAMBDA (|bfVar#52| |bfVar#51| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#51|) (PROGN (SETQ |x| (CAR |bfVar#51|)) NIL))
             (RETURN |bfVar#52|))
            (#1#
             (SETQ |bfVar#52|
                     (|union| |bfVar#52|
                      (|makeFunctorArgumentParameters,findExtras| |a| |x|)))))
           (SETQ |bfVar#51| (CDR |bfVar#51|))))
        NIL |l| NIL))
      ((AND (CONSP |target|) (EQ (CAR |target|) 'CATEGORY)
            (PROGN
             (SETQ |ISTMP#1| (CDR |target|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |l| (CDR |ISTMP#1|)) #1#))))
       ((LAMBDA (|bfVar#54| |bfVar#53| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#53|) (PROGN (SETQ |x| (CAR |bfVar#53|)) NIL))
             (RETURN |bfVar#54|))
            (#1#
             (SETQ |bfVar#54|
                     (|union| |bfVar#54|
                      (|makeFunctorArgumentParameters,findExtras1| |a| |x|)))))
           (SETQ |bfVar#53| (CDR |bfVar#53|))))
        NIL |l| NIL))))))
(DEFUN |makeFunctorArgumentParameters,augmentSig| (|s| |ss|)
  (PROG (|sl| |u|)
    (RETURN
     (COND ((NULL |ss|) |s|)
           (#1='T
            (PROGN
             ((LAMBDA (|bfVar#63| |u|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#63|)
                       (PROGN (SETQ |u| (CAR |bfVar#63|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (SETQ |$ConditionalOperators|
                           (CONS (CDR |u|) |$ConditionalOperators|))))
                 (SETQ |bfVar#63| (CDR |bfVar#63|))))
              |ss| NIL)
             (COND
              ((AND (CONSP |s|) (EQ (CAR |s|) '|Join|)
                    (PROGN (SETQ |sl| (CDR |s|)) #1#))
               (COND ((SETQ |u| (ASSQ 'CATEGORY |ss|)) (BREAK))
                     (#1#
                      (CONS '|Join|
                            (APPEND |sl|
                                    (CONS
                                     (CONS 'CATEGORY (CONS '|package| |ss|))
                                     NIL))))))
              (#1#
               (LIST '|Join| |s|
                     (CONS 'CATEGORY (CONS '|package| |ss|)))))))))))
(DEFUN |makeFunctorArgumentParameters,fn| (|a| |dollar| |s|)
  (PROG (|catlist|)
    (RETURN
     (COND ((NULL (ATOM |a|)) (BREAK))
           (#1='T
            (COND
             ((|isCategoryForm| |s|)
              (COND
               ((AND (CONSP |s|) (EQ (CAR |s|) '|Join|)
                     (PROGN (SETQ |catlist| (CDR |s|)) #1#))
                (|genDomainViewList| |a| |dollar| (CDR |s|)))
               (#1# (|genDomainView| |a| |dollar| |s|))))))))))
(DEFUN |makeFunctorArgumentParameters,findExtras1| (|a| |x|)
  (PROG (|l| |ISTMP#1| |c| |ISTMP#2| |p| |ISTMP#3| |q|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'AND) (PROGN (SETQ |l| (CDR |x|)) #1='T))
       ((LAMBDA (|bfVar#56| |bfVar#55| |y|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#55|) (PROGN (SETQ |y| (CAR |bfVar#55|)) NIL))
             (RETURN |bfVar#56|))
            (#1#
             (SETQ |bfVar#56|
                     (|union| |bfVar#56|
                      (|makeFunctorArgumentParameters,findExtras1| |a| |y|)))))
           (SETQ |bfVar#55| (CDR |bfVar#55|))))
        NIL |l| NIL))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'OR) (PROGN (SETQ |l| (CDR |x|)) #1#))
       ((LAMBDA (|bfVar#58| |bfVar#57| |y|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#57|) (PROGN (SETQ |y| (CAR |bfVar#57|)) NIL))
             (RETURN |bfVar#58|))
            (#1#
             (SETQ |bfVar#58|
                     (|union| |bfVar#58|
                      (|makeFunctorArgumentParameters,findExtras1| |a| |y|)))))
           (SETQ |bfVar#57| (CDR |bfVar#57|))))
        NIL |l| NIL))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |c| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |p| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |q| (CAR |ISTMP#3|)) #1#))))))))
       (|union| (|makeFunctorArgumentParameters,findExtrasP| |a| |c|)
        (|union| (|makeFunctorArgumentParameters,findExtras1| |a| |p|)
         (|makeFunctorArgumentParameters,findExtras1| |a| |q|))))))))
(DEFUN |makeFunctorArgumentParameters,findExtrasP| (|a| |x|)
  (PROG (|l| |ISTMP#1| |ISTMP#2| |y|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'AND) (PROGN (SETQ |l| (CDR |x|)) #1='T))
       ((LAMBDA (|bfVar#60| |bfVar#59| |y|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#59|) (PROGN (SETQ |y| (CAR |bfVar#59|)) NIL))
             (RETURN |bfVar#60|))
            (#1#
             (SETQ |bfVar#60|
                     (|union| |bfVar#60|
                      (|makeFunctorArgumentParameters,findExtrasP| |a| |y|)))))
           (SETQ |bfVar#59| (CDR |bfVar#59|))))
        NIL |l| NIL))
      ((AND (CONSP |x|) (EQ (CAR |x|) 'OR) (PROGN (SETQ |l| (CDR |x|)) #1#))
       ((LAMBDA (|bfVar#62| |bfVar#61| |y|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#61|) (PROGN (SETQ |y| (CAR |bfVar#61|)) NIL))
             (RETURN |bfVar#62|))
            (#1#
             (SETQ |bfVar#62|
                     (|union| |bfVar#62|
                      (|makeFunctorArgumentParameters,findExtrasP| |a| |y|)))))
           (SETQ |bfVar#61| (CDR |bfVar#61|))))
        NIL |l| NIL))
      ((AND (CONSP |x|) (EQ (CAR |x|) '|has|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |a|)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1#)))))
            (CONSP |y|) (EQ (CAR |y|) 'SIGNATURE))
       (LIST |y|))
      (#1# NIL)))))

; genDomainViewList(id, dollar, catlist) ==
;   null catlist => nil
;   catlist is [y] and not isCategoryForm(y) => nil
;   for c in catlist repeat
;       genDomainView(id, dollar, c)

(DEFUN |genDomainViewList| (|id| |dollar| |catlist|)
  (PROG (|y|)
    (RETURN
     (COND ((NULL |catlist|) NIL)
           ((AND (CONSP |catlist|) (EQ (CDR |catlist|) NIL)
                 (PROGN (SETQ |y| (CAR |catlist|)) #1='T)
                 (NULL (|isCategoryForm| |y|)))
            NIL)
           (#1#
            ((LAMBDA (|bfVar#64| |c|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#64|)
                      (PROGN (SETQ |c| (CAR |bfVar#64|)) NIL))
                  (RETURN NIL))
                 (#1# (|genDomainView| |id| |dollar| |c|)))
                (SETQ |bfVar#64| (CDR |bfVar#64|))))
             |catlist| NIL))))))

; genDomainView(viewName, dollar, c) ==
;   c is ['CATEGORY, ., :l] => genDomainOps(viewName, c)
;   c := substitute(dollar, "$", c)
;   $tmp_e := augModemapsFromCategory(viewName, nil, c, $tmp_e)

(DEFUN |genDomainView| (|viewName| |dollar| |c|)
  (PROG (|ISTMP#1| |l|)
    (RETURN
     (COND
      ((AND (CONSP |c|) (EQ (CAR |c|) 'CATEGORY)
            (PROGN
             (SETQ |ISTMP#1| (CDR |c|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |l| (CDR |ISTMP#1|)) #1='T))))
       (|genDomainOps| |viewName| |c|))
      (#1#
       (PROGN
        (SETQ |c| (|substitute| |dollar| '$ |c|))
        (SETQ |$tmp_e|
                (|augModemapsFromCategory| |viewName| NIL |c| |$tmp_e|))))))))

; genDomainOps(viewName, cat) ==
;   oplist := getOperationAlist(viewName, viewName, cat)
;   oplist:= substNames(viewName, viewName, oplist)
;   for [opsig,cond,:.] in oplist for i in 0.. repeat
;     if opsig in $ConditionalOperators then cond:=nil
;     [op, sig] := opsig
;     $tmp_e:= addModemap(op, viewName, sig, cond, ['ELT, viewName, i], $tmp_e)

(DEFUN |genDomainOps| (|viewName| |cat|)
  (PROG (|oplist| |opsig| |ISTMP#1| |cond| |op| |sig|)
    (RETURN
     (PROGN
      (SETQ |oplist| (|getOperationAlist| |viewName| |viewName| |cat|))
      (SETQ |oplist| (|substNames| |viewName| |viewName| |oplist|))
      ((LAMBDA (|bfVar#66| |bfVar#65| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#66|)
                (PROGN (SETQ |bfVar#65| (CAR |bfVar#66|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#65|)
                 (PROGN
                  (SETQ |opsig| (CAR |bfVar#65|))
                  (SETQ |ISTMP#1| (CDR |bfVar#65|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |cond| (CAR |ISTMP#1|)) #1#)))
                 (PROGN
                  (COND
                   ((|member| |opsig| |$ConditionalOperators|)
                    (SETQ |cond| NIL)))
                  (SETQ |op| (CAR |opsig|))
                  (SETQ |sig| (CADR |opsig|))
                  (SETQ |$tmp_e|
                          (|addModemap| |op| |viewName| |sig| |cond|
                           (LIST 'ELT |viewName| |i|) |$tmp_e|))))))
          (SETQ |bfVar#66| (CDR |bfVar#66|))
          (SETQ |i| (+ |i| 1))))
       |oplist| NIL 0)))))

; compDefWhereClause(['DEF, form, signature, body], m, e) ==
; -- form is lhs (f a1 ... an) of definition; body is rhs;
; -- signature is (t0 t1 ... tn) where t0= target type, ti=type of ai, i > 0;
;
; -- removes declarative and assignment information from form and
; -- signature, placing it in list L, replacing form by ("where",form',:L),
; -- signature by a list of NILs (signifying declarations are in e)
;   $sigAlist: local := nil
;   $predAlist: local := nil
;
; -- 1. create sigList= list of all signatures which have embedded
; --    declarations moved into global variable $sigAlist
;   sigList:=
;     [transformType(x) for a in rest form for x in rest signature]
;        where
;         transformType x ==
;           atom x => x
;           x is [":",R,Rtype] =>
;             ($sigAlist:= [[R,:transformType Rtype],:$sigAlist]; x)
;           x is ['Record,:.] => x --RDJ 8/83
;           [first x,:[transformType y for y in rest x]]
;
; -- 2. replace each argument of the form (|| x p) by x, recording
; --    the given predicate in global variable $predAlist
;   argList:=
;     [removeSuchthat a for a in rest form] where
;       removeSuchthat x ==
;         x is ["|",y,p] =>
;             BREAK()
;             ($predAlist:= [[y,:p],:$predAlist]; y)
;         x
;
;   argList2 := [a for a in argList for t in sigList | not(NULL(t))]
;   sigList2 := [t for t in sigList | not(NULL(t))]
;
; -- 3. obtain a list of parameter identifiers (x1 .. xn) ordered so that
; --       the type of xi is independent of xj if i < j
;   varList:=
;     orderByDependency(ASSOCLEFT argDepAlist,ASSOCRIGHT argDepAlist) where
;       argDepAlist:=
;         [[x,:dependencies] for [x,:y] in argSigAlist] where
;           dependencies() ==
;             union(listOfIdentifiersIn y,
;               delete(x,listOfIdentifiersIn LASSOC(x,$predAlist)))
;           argSigAlist:= [:$sigAlist,:pairList(argList2, sigList2)]
;
; -- 4. construct a WhereList which declares and/or defines the xi's in
; --    the order constructed in step 3
;   (whereList:= [addSuchthat(x,[":",x,LASSOC(x,argSigAlist)]) for x in varList])
;      where addSuchthat(x,y) == (p:= LASSOC(x,$predAlist) => ["|",y,p]; y)
;
; -- 5. compile new ('DEF,("where",form',:WhereList),:.) where
; --    all argument parameters of form' are bound/declared in WhereList
;   comp(form',m,e) where
;     form':=
;       ["where",defform,:whereList] where
;         defform:=
;           ['DEF, form'', signature', body] where
;             form'':= [first form,:argList]
;             signature':= [first signature,:[nil for x in rest signature]]

(DEFUN |compDefWhereClause| (|bfVar#86| |m| |e|)
  (PROG (|$predAlist| |$sigAlist| |form'| |defform| |signature'| |form''|
         |whereList| |varList| |argDepAlist| |y| |x| |argSigAlist| |sigList2|
         |argList2| |argList| |sigList| |body| |signature| |form|)
    (DECLARE (SPECIAL |$predAlist| |$sigAlist|))
    (RETURN
     (PROGN
      (SETQ |form| (CADR . #1=(|bfVar#86|)))
      (SETQ |signature| (CADDR . #1#))
      (SETQ |body| (CADDDR . #1#))
      (SETQ |$sigAlist| NIL)
      (SETQ |$predAlist| NIL)
      (SETQ |sigList|
              ((LAMBDA (|bfVar#69| |bfVar#67| |a| |bfVar#68| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#67|)
                        (PROGN (SETQ |a| (CAR |bfVar#67|)) NIL)
                        (ATOM |bfVar#68|)
                        (PROGN (SETQ |x| (CAR |bfVar#68|)) NIL))
                    (RETURN (NREVERSE |bfVar#69|)))
                   (#2='T
                    (SETQ |bfVar#69|
                            (CONS (|compDefWhereClause,transformType| |x|)
                                  |bfVar#69|))))
                  (SETQ |bfVar#67| (CDR |bfVar#67|))
                  (SETQ |bfVar#68| (CDR |bfVar#68|))))
               NIL (CDR |form|) NIL (CDR |signature|) NIL))
      (SETQ |argList|
              ((LAMBDA (|bfVar#73| |bfVar#72| |a|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#72|)
                        (PROGN (SETQ |a| (CAR |bfVar#72|)) NIL))
                    (RETURN (NREVERSE |bfVar#73|)))
                   (#2#
                    (SETQ |bfVar#73|
                            (CONS (|compDefWhereClause,removeSuchthat| |a|)
                                  |bfVar#73|))))
                  (SETQ |bfVar#72| (CDR |bfVar#72|))))
               NIL (CDR |form|) NIL))
      (SETQ |argList2|
              ((LAMBDA (|bfVar#76| |bfVar#74| |a| |bfVar#75| |t|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#74|)
                        (PROGN (SETQ |a| (CAR |bfVar#74|)) NIL)
                        (ATOM |bfVar#75|)
                        (PROGN (SETQ |t| (CAR |bfVar#75|)) NIL))
                    (RETURN (NREVERSE |bfVar#76|)))
                   (#2#
                    (AND (NULL (NULL |t|))
                         (SETQ |bfVar#76| (CONS |a| |bfVar#76|)))))
                  (SETQ |bfVar#74| (CDR |bfVar#74|))
                  (SETQ |bfVar#75| (CDR |bfVar#75|))))
               NIL |argList| NIL |sigList| NIL))
      (SETQ |sigList2|
              ((LAMBDA (|bfVar#78| |bfVar#77| |t|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#77|)
                        (PROGN (SETQ |t| (CAR |bfVar#77|)) NIL))
                    (RETURN (NREVERSE |bfVar#78|)))
                   (#2#
                    (AND (NULL (NULL |t|))
                         (SETQ |bfVar#78| (CONS |t| |bfVar#78|)))))
                  (SETQ |bfVar#77| (CDR |bfVar#77|))))
               NIL |sigList| NIL))
      (SETQ |argSigAlist|
              (APPEND |$sigAlist| (|pairList| |argList2| |sigList2|)))
      (SETQ |argDepAlist|
              ((LAMBDA (|bfVar#81| |bfVar#80| |bfVar#79|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#80|)
                        (PROGN (SETQ |bfVar#79| (CAR |bfVar#80|)) NIL))
                    (RETURN (NREVERSE |bfVar#81|)))
                   (#2#
                    (AND (CONSP |bfVar#79|)
                         (PROGN
                          (SETQ |x| (CAR |bfVar#79|))
                          (SETQ |y| (CDR |bfVar#79|))
                          #2#)
                         (SETQ |bfVar#81|
                                 (CONS
                                  (CONS |x|
                                        (|union| (|listOfIdentifiersIn| |y|)
                                         (|delete| |x|
                                          (|listOfIdentifiersIn|
                                           (LASSOC |x| |$predAlist|)))))
                                  |bfVar#81|)))))
                  (SETQ |bfVar#80| (CDR |bfVar#80|))))
               NIL |argSigAlist| NIL))
      (SETQ |varList|
              (|orderByDependency| (ASSOCLEFT |argDepAlist|)
               (ASSOCRIGHT |argDepAlist|)))
      (SETQ |whereList|
              ((LAMBDA (|bfVar#83| |bfVar#82| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#82|)
                        (PROGN (SETQ |x| (CAR |bfVar#82|)) NIL))
                    (RETURN (NREVERSE |bfVar#83|)))
                   (#2#
                    (SETQ |bfVar#83|
                            (CONS
                             (|compDefWhereClause,addSuchthat| |x|
                              (LIST '|:| |x| (LASSOC |x| |argSigAlist|)))
                             |bfVar#83|))))
                  (SETQ |bfVar#82| (CDR |bfVar#82|))))
               NIL |varList| NIL))
      (SETQ |form''| (CONS (CAR |form|) |argList|))
      (SETQ |signature'|
              (CONS (CAR |signature|)
                    ((LAMBDA (|bfVar#85| |bfVar#84| |x|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#84|)
                              (PROGN (SETQ |x| (CAR |bfVar#84|)) NIL))
                          (RETURN (NREVERSE |bfVar#85|)))
                         (#2# (SETQ |bfVar#85| (CONS NIL |bfVar#85|))))
                        (SETQ |bfVar#84| (CDR |bfVar#84|))))
                     NIL (CDR |signature|) NIL)))
      (SETQ |defform| (LIST 'DEF |form''| |signature'| |body|))
      (SETQ |form'| (CONS '|where| (CONS |defform| |whereList|)))
      (|comp| |form'| |m| |e|)))))
(DEFUN |compDefWhereClause,addSuchthat| (|x| |y|)
  (PROG (|p|)
    (RETURN
     (COND ((SETQ |p| (LASSOC |x| |$predAlist|)) (LIST '|\|| |y| |p|))
           ('T |y|)))))
(DEFUN |compDefWhereClause,removeSuchthat| (|x|)
  (PROG (|ISTMP#1| |y| |ISTMP#2| |p|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) '|\||)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |y| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |p| (CAR |ISTMP#2|)) #1='T))))))
       (PROGN
        (BREAK)
        (SETQ |$predAlist| (CONS (CONS |y| |p|) |$predAlist|))
        |y|))
      (#1# |x|)))))
(DEFUN |compDefWhereClause,transformType| (|x|)
  (PROG (|ISTMP#1| R |ISTMP#2| |Rtype|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) '|:|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ R (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |Rtype| (CAR |ISTMP#2|)) #1='T))))))
            (PROGN
             (SETQ |$sigAlist|
                     (CONS
                      (CONS R (|compDefWhereClause,transformType| |Rtype|))
                      |$sigAlist|))
             |x|))
           ((AND (CONSP |x|) (EQ (CAR |x|) '|Record|)) |x|)
           (#1#
            (CONS (CAR |x|)
                  ((LAMBDA (|bfVar#71| |bfVar#70| |y|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#70|)
                            (PROGN (SETQ |y| (CAR |bfVar#70|)) NIL))
                        (RETURN (NREVERSE |bfVar#71|)))
                       (#1#
                        (SETQ |bfVar#71|
                                (CONS (|compDefWhereClause,transformType| |y|)
                                      |bfVar#71|))))
                      (SETQ |bfVar#70| (CDR |bfVar#70|))))
                   NIL (CDR |x|) NIL)))))))

; orderByDependency(vl,dl) == vl

(DEFUN |orderByDependency| (|vl| |dl|) (PROG () (RETURN |vl|)))

; compInternalFunction(df is ['DEF, form, signature, body], m, e) ==
;     -- FIXME: should correctly handle import in nested functions
;     -- $CapsuleDomainsInScope : local := e
;     [op, :argl] := form
;     not(IDENTP(op)) =>
;         stackAndThrow ['"Bad name for internal function:", op]
;     nbody := ["+->", argl, body]
;     fmode := ["Mapping", :signature]
;     [., ., e'] := compMakeDeclaration([":", op, fmode], $EmptyMode, e)
;     T := compWithMappingMode(nbody, fmode, e')
;     T or return nil
;     currentProplist := getProplist(op, e)
;     finish_setq_single(T, fmode, op, nbody, currentProplist)

(DEFUN |compInternalFunction| (|df| |m| |e|)
  (PROG (|form| |signature| |body| |op| |argl| |nbody| |fmode| |LETTMP#1| |e'|
         T$ |currentProplist|)
    (RETURN
     (PROGN
      (SETQ |form| (CADR . #1=(|df|)))
      (SETQ |signature| (CADDR . #1#))
      (SETQ |body| (CADDDR . #1#))
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (COND
       ((NULL (IDENTP |op|))
        (|stackAndThrow| (LIST "Bad name for internal function:" |op|)))
       ('T
        (PROGN
         (SETQ |nbody| (LIST '+-> |argl| |body|))
         (SETQ |fmode| (CONS '|Mapping| |signature|))
         (SETQ |LETTMP#1|
                 (|compMakeDeclaration| (LIST '|:| |op| |fmode|) |$EmptyMode|
                  |e|))
         (SETQ |e'| (CADDR |LETTMP#1|))
         (SETQ T$ (|compWithMappingMode| |nbody| |fmode| |e'|))
         (OR T$ (RETURN NIL))
         (SETQ |currentProplist| (|getProplist| |op| |e|))
         (|finish_setq_single| T$ |fmode| |op| |nbody| |currentProplist|))))))))

; compDefineCapsuleFunction(df is ['DEF, form, signature, body],
;   m,oldE,$prefix,$formalArgList) ==
;     e := oldE
;     --1. bind global variables
;     $functionStats: local:= [0,0]
;     $finalEnv: local := nil
;              --used by ReplaceExitEtc to get a common environment
;     $locVarsTypes: local := []
;     $initCapsuleErrorCount: local:= #$semanticErrorStack
;     $insideCapsuleFunctionIfTrue: local:= true
;     $CapsuleModemapFrame: local:= e
;     $CapsuleDomainsInScope: local:= get("$DomainsInScope","special",e)
;     $iterate_tag : local := []
;     $returnMode:= m
;     $op: local := nil
;     [$op,:argl]:= form
;     $formalArgList:= [:argl,:$formalArgList]
;
;     --let target and local signatures help determine modes of arguments
;     argModeList:=
;       identSig:= hasSigInTargetCategory(argl,form,first signature,e) =>
;         (e:= checkAndDeclare(argl,form,identSig,e); rest identSig)
;       [getArgumentModeOrMoan(a,form,e) for a in argl]
;     signature':= [first signature,:argModeList]
;     if null identSig then  --make $op a local function
;       oldE := put($op,'mode,['Mapping,:signature'],oldE)
;
;     --obtain target type if not given
;     if null first signature' then signature':=
;       identSig => identSig
;       getSignature($op,rest signature',e) or return nil
;
;     --replace ##1,.. in signature by arguments
; --    pp signature'
; --  pp '"------after----"
; --  pp signature'
;     e:= giveFormalParametersValues(argl,e)
;
;     $signatureOfForm:= signature' --this global is bound in compCapsuleItems
;     $functionLocations := [[[$op, signature']],
;       :$functionLocations]
;     e:= addDomain(first signature',e)
;
;     --4. introduce needed domains into extendedEnv
;     for domain in signature' repeat e:= addDomain(domain,e)
;
;     --6. compile body in environment with extended environment
;     rettype := resolve(signature'.target, $returnMode)
;
;     localOrExported :=
;       null member($op,$formalArgList) and
;         getmode($op,e) is ['Mapping,:.] => 'local
;       'exported
;
;     --6a skip if compiling only certain items but not this one
;     -- could be moved closer to the top
;     formattedSig := formatUnabbreviated ['Mapping,:signature']
;     sayBrightly ['"   compiling ",localOrExported,
;       :bright $op,'": ",:formattedSig]
;
;     T := CATCH('compCapsuleBody, compOrCroak(body,rettype,e))
;            or ["",rettype,e]
; --+
;     NRTassignCapsuleFunctionSlot($op, signature', $domainShell, e)
;     if $newCompCompare=true then
;          SAY '"The old compiler generates:"
;          prTriple T
; --  A THROW to the above CATCH occurs if too many semantic errors occur
; --  see stackSemanticError
;     catchTag:= MKQ GENSYM()
;     fun:=
;       body':= replaceExitEtc(T.expr,catchTag,"TAGGEDreturn",$returnMode)
;       finalBody:= ["CATCH",catchTag,body']
;       do_compile([$op, ["LAMBDA", [:argl, '_$], finalBody]], oldE)
;     $functorStats:= addStats($functorStats,$functionStats)
;
;
; --  7. give operator a 'value property
;     [fun,['Mapping,:signature'],oldE] -- oldE:= put($op,'value,removeEnv val,e)

(DEFUN |compDefineCapsuleFunction| (|df| |m| |oldE| |$prefix| |$formalArgList|)
  (DECLARE (SPECIAL |$prefix| |$formalArgList|))
  (PROG (|$op| |$iterate_tag| |$CapsuleDomainsInScope| |$CapsuleModemapFrame|
         |$insideCapsuleFunctionIfTrue| |$initCapsuleErrorCount|
         |$locVarsTypes| |$finalEnv| |$functionStats| |fun| |finalBody| |body'|
         |catchTag| T$ |formattedSig| |localOrExported| |ISTMP#1| |rettype|
         |signature'| |argModeList| |identSig| |argl| |e| |body| |signature|
         |form|)
    (DECLARE
     (SPECIAL |$op| |$iterate_tag| |$CapsuleDomainsInScope|
      |$CapsuleModemapFrame| |$insideCapsuleFunctionIfTrue|
      |$initCapsuleErrorCount| |$locVarsTypes| |$finalEnv| |$functionStats|))
    (RETURN
     (PROGN
      (SETQ |form| (CADR . #1=(|df|)))
      (SETQ |signature| (CADDR . #1#))
      (SETQ |body| (CADDDR . #1#))
      (SETQ |e| |oldE|)
      (SETQ |$functionStats| (LIST 0 0))
      (SETQ |$finalEnv| NIL)
      (SETQ |$locVarsTypes| NIL)
      (SETQ |$initCapsuleErrorCount| (LENGTH |$semanticErrorStack|))
      (SETQ |$insideCapsuleFunctionIfTrue| T)
      (SETQ |$CapsuleModemapFrame| |e|)
      (SETQ |$CapsuleDomainsInScope| (|get| '|$DomainsInScope| '|special| |e|))
      (SETQ |$iterate_tag| NIL)
      (SETQ |$returnMode| |m|)
      (SETQ |$op| NIL)
      (SETQ |$op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |$formalArgList| (APPEND |argl| |$formalArgList|))
      (SETQ |argModeList|
              (COND
               ((SETQ |identSig|
                        (|hasSigInTargetCategory| |argl| |form|
                         (CAR |signature|) |e|))
                (PROGN
                 (SETQ |e| (|checkAndDeclare| |argl| |form| |identSig| |e|))
                 (CDR |identSig|)))
               (#2='T
                ((LAMBDA (|bfVar#88| |bfVar#87| |a|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#87|)
                          (PROGN (SETQ |a| (CAR |bfVar#87|)) NIL))
                      (RETURN (NREVERSE |bfVar#88|)))
                     (#2#
                      (SETQ |bfVar#88|
                              (CONS (|getArgumentModeOrMoan| |a| |form| |e|)
                                    |bfVar#88|))))
                    (SETQ |bfVar#87| (CDR |bfVar#87|))))
                 NIL |argl| NIL))))
      (SETQ |signature'| (CONS (CAR |signature|) |argModeList|))
      (COND
       ((NULL |identSig|)
        (SETQ |oldE|
                (|put| |$op| '|mode| (CONS '|Mapping| |signature'|) |oldE|))))
      (COND
       ((NULL (CAR |signature'|))
        (SETQ |signature'|
                (COND (|identSig| |identSig|)
                      (#2#
                       (OR (|getSignature| |$op| (CDR |signature'|) |e|)
                           (RETURN NIL)))))))
      (SETQ |e| (|giveFormalParametersValues| |argl| |e|))
      (SETQ |$signatureOfForm| |signature'|)
      (SETQ |$functionLocations|
              (CONS (LIST (LIST |$op| |signature'|)) |$functionLocations|))
      (SETQ |e| (|addDomain| (CAR |signature'|) |e|))
      ((LAMBDA (|bfVar#89| |domain|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#89|) (PROGN (SETQ |domain| (CAR |bfVar#89|)) NIL))
            (RETURN NIL))
           (#2# (SETQ |e| (|addDomain| |domain| |e|))))
          (SETQ |bfVar#89| (CDR |bfVar#89|))))
       |signature'| NIL)
      (SETQ |rettype| (|resolve| (CAR |signature'|) |$returnMode|))
      (SETQ |localOrExported|
              (COND
               ((AND (NULL (|member| |$op| |$formalArgList|))
                     (PROGN
                      (SETQ |ISTMP#1| (|getmode| |$op| |e|))
                      (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|))))
                '|local|)
               (#2# '|exported|)))
      (SETQ |formattedSig|
              (|formatUnabbreviated| (CONS '|Mapping| |signature'|)))
      (|sayBrightly|
       (CONS "   compiling "
             (CONS |localOrExported|
                   (APPEND (|bright| |$op|) (CONS ": " |formattedSig|)))))
      (SETQ T$
              (OR
               (CATCH '|compCapsuleBody| (|compOrCroak| |body| |rettype| |e|))
               (LIST '|| |rettype| |e|)))
      (|NRTassignCapsuleFunctionSlot| |$op| |signature'| |$domainShell| |e|)
      (COND
       ((EQUAL |$newCompCompare| T) (SAY "The old compiler generates:")
        (|prTriple| T$)))
      (SETQ |catchTag| (MKQ (GENSYM)))
      (SETQ |fun|
              (PROGN
               (SETQ |body'|
                       (|replaceExitEtc| (CAR T$) |catchTag| '|TAGGEDreturn|
                        |$returnMode|))
               (SETQ |finalBody| (LIST 'CATCH |catchTag| |body'|))
               (|do_compile|
                (LIST |$op|
                      (LIST 'LAMBDA (APPEND |argl| (CONS '$ NIL)) |finalBody|))
                |oldE|)))
      (SETQ |$functorStats| (|addStats| |$functorStats| |$functionStats|))
      (LIST |fun| (CONS '|Mapping| |signature'|) |oldE|)))))

; getSignatureFromMode(form,e) ==
;   getmode(opOf form,e) is ['Mapping,:signature] =>
;     #form~=#signature => stackAndThrow ["Wrong number of arguments: ",form]
;     EQSUBSTLIST(rest form,take(#rest form,$FormalMapVariableList),signature)

(DEFUN |getSignatureFromMode| (|form| |e|)
  (PROG (|ISTMP#1| |signature|)
    (RETURN
     (COND
      ((PROGN
        (SETQ |ISTMP#1| (|getmode| (|opOf| |form|) |e|))
        (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
             (PROGN (SETQ |signature| (CDR |ISTMP#1|)) #1='T)))
       (IDENTITY
        (COND
         ((NOT (EQL (LENGTH |form|) (LENGTH |signature|)))
          (|stackAndThrow| (LIST '|Wrong number of arguments: | |form|)))
         (#1#
          (EQSUBSTLIST (CDR |form|)
           (TAKE (LENGTH (CDR |form|)) |$FormalMapVariableList|)
           |signature|)))))))))

; hasSigInTargetCategory(argl,form,opsig,e) ==
;   mList:= [getArgumentMode(x,e) for x in argl]
;     --each element is a declared mode for the variable or nil if none exists
;   potentialSigList:=
;     REMDUP
;       [sig
;         for [[opName,sig,:.],:.] in $domainShell.(1) |
;           fn(opName,sig,opsig,mList,form)] where
;             fn(opName,sig,opsig,mList,form) ==
;               opName=$op and #sig=#form and (null opsig or opsig=first sig) and
;                 (and/[compareMode2Arg(x,m) for x in mList for m in rest sig])
;   c:= #potentialSigList
;   1=c => first potentialSigList
;     --accept only those signatures op right length which match declared modes
;   0=c => (#(sig:= getSignatureFromMode(form,e))=#form => sig; nil)
;   1<c =>
;     sig:= first potentialSigList
;     stackWarning ["signature of lhs not unique:",:bright sig,"chosen"]
;     sig
;   nil --this branch will force all arguments to be declared

(DEFUN |hasSigInTargetCategory| (|argl| |form| |opsig| |e|)
  (PROG (|mList| |ISTMP#1| |opName| |ISTMP#2| |sig| |potentialSigList| |c|)
    (RETURN
     (PROGN
      (SETQ |mList|
              ((LAMBDA (|bfVar#91| |bfVar#90| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#90|)
                        (PROGN (SETQ |x| (CAR |bfVar#90|)) NIL))
                    (RETURN (NREVERSE |bfVar#91|)))
                   (#1='T
                    (SETQ |bfVar#91|
                            (CONS (|getArgumentMode| |x| |e|) |bfVar#91|))))
                  (SETQ |bfVar#90| (CDR |bfVar#90|))))
               NIL |argl| NIL))
      (SETQ |potentialSigList|
              (REMDUP
               ((LAMBDA (|bfVar#94| |bfVar#93| |bfVar#92|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#93|)
                         (PROGN (SETQ |bfVar#92| (CAR |bfVar#93|)) NIL))
                     (RETURN (NREVERSE |bfVar#94|)))
                    (#1#
                     (AND (CONSP |bfVar#92|)
                          (PROGN
                           (SETQ |ISTMP#1| (CAR |bfVar#92|))
                           (AND (CONSP |ISTMP#1|)
                                (PROGN
                                 (SETQ |opName| (CAR |ISTMP#1|))
                                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                 (AND (CONSP |ISTMP#2|)
                                      (PROGN
                                       (SETQ |sig| (CAR |ISTMP#2|))
                                       #1#)))))
                          (|hasSigInTargetCategory,fn| |opName| |sig| |opsig|
                           |mList| |form|)
                          (SETQ |bfVar#94| (CONS |sig| |bfVar#94|)))))
                   (SETQ |bfVar#93| (CDR |bfVar#93|))))
                NIL (ELT |$domainShell| 1) NIL)))
      (SETQ |c| (LENGTH |potentialSigList|))
      (COND ((EQL 1 |c|) (CAR |potentialSigList|))
            ((EQL 0 |c|)
             (COND
              ((EQL (LENGTH (SETQ |sig| (|getSignatureFromMode| |form| |e|)))
                    (LENGTH |form|))
               |sig|)
              (#1# NIL)))
            ((< 1 |c|)
             (PROGN
              (SETQ |sig| (CAR |potentialSigList|))
              (|stackWarning|
               (CONS '|signature of lhs not unique:|
                     (APPEND (|bright| |sig|) (CONS '|chosen| NIL))))
              |sig|))
            (#1# NIL))))))
(DEFUN |hasSigInTargetCategory,fn| (|opName| |sig| |opsig| |mList| |form|)
  (PROG ()
    (RETURN
     (AND (EQUAL |opName| |$op|) (EQL (LENGTH |sig|) (LENGTH |form|))
          (OR (NULL |opsig|) (EQUAL |opsig| (CAR |sig|)))
          ((LAMBDA (|bfVar#97| |bfVar#95| |x| |bfVar#96| |m|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#95|) (PROGN (SETQ |x| (CAR |bfVar#95|)) NIL)
                    (ATOM |bfVar#96|) (PROGN (SETQ |m| (CAR |bfVar#96|)) NIL))
                (RETURN |bfVar#97|))
               ('T
                (PROGN
                 (SETQ |bfVar#97| (|compareMode2Arg| |x| |m|))
                 (COND ((NOT |bfVar#97|) (RETURN NIL))))))
              (SETQ |bfVar#95| (CDR |bfVar#95|))
              (SETQ |bfVar#96| (CDR |bfVar#96|))))
           T |mList| NIL (CDR |sig|) NIL)))))

; compareMode2Arg(x,m) == null x or modeEqual(x,m)

(DEFUN |compareMode2Arg| (|x| |m|)
  (PROG () (RETURN (OR (NULL |x|) (|modeEqual| |x| |m|)))))

; getArgumentModeOrMoan(x,form,e) ==
;   getArgumentMode(x,e) or
;     stackSemanticError(["argument ",x," of ",form," is not declared"],nil)

(DEFUN |getArgumentModeOrMoan| (|x| |form| |e|)
  (PROG ()
    (RETURN
     (OR (|getArgumentMode| |x| |e|)
         (|stackSemanticError|
          (LIST '|argument | |x| '| of | |form| '| is not declared|) NIL)))))

; getArgumentMode(x,e) ==
;   STRINGP x => x
;   m:= get(x,'mode,e) => m

(DEFUN |getArgumentMode| (|x| |e|)
  (PROG (|m|)
    (RETURN
     (COND ((STRINGP |x|) |x|) ((SETQ |m| (|get| |x| '|mode| |e|)) |m|)))))

; checkAndDeclare(argl,form,sig,e) ==
;
; -- arguments with declared types must agree with those in sig;
; -- those that don't get declarations put into e
;   for a in argl for m in rest sig repeat
;     m1:= getArgumentMode(a,e) =>
;       not modeEqual(m1,m) =>
;         stack:= ["   ",:bright a,'"must have type ",m,
;           '" not ",m1,'%l,:stack]
;     e:= put(a,'mode,m,e)
;   if stack then
;     sayBrightly ['"   Parameters of ",:bright first form,
;       '" are of wrong type:",'%l,:stack]
;   e

(DEFUN |checkAndDeclare| (|argl| |form| |sig| |e|)
  (PROG (|m1| |stack|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#98| |a| |bfVar#99| |m|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#98|) (PROGN (SETQ |a| (CAR |bfVar#98|)) NIL)
                (ATOM |bfVar#99|) (PROGN (SETQ |m| (CAR |bfVar#99|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((SETQ |m1| (|getArgumentMode| |a| |e|))
              (COND
               ((NULL (|modeEqual| |m1| |m|))
                (IDENTITY
                 (SETQ |stack|
                         (CONS '|   |
                               (APPEND (|bright| |a|)
                                       (CONS "must have type "
                                             (CONS |m|
                                                   (CONS " not "
                                                         (CONS |m1|
                                                               (CONS '|%l|
                                                                     |stack|))))))))))))
             (#1# (SETQ |e| (|put| |a| '|mode| |m| |e|))))))
          (SETQ |bfVar#98| (CDR |bfVar#98|))
          (SETQ |bfVar#99| (CDR |bfVar#99|))))
       |argl| NIL (CDR |sig|) NIL)
      (COND
       (|stack|
        (|sayBrightly|
         (CONS "   Parameters of "
               (APPEND (|bright| (CAR |form|))
                       (CONS " are of wrong type:" (CONS '|%l| |stack|)))))))
      |e|))))

; getSignature(op, argModeList, e) ==
;   1=#
;     (sigl:=
;       REMDUP
;         [sig for [[dc, :sig], [pred, :.]]
;            in (mmList := get(op, 'modemap, e)) | dc='_$ and
;                rest sig=argModeList and known_in_env(pred, e)]) => first sigl
;   null sigl =>
;     (u := getmode(op, e)) is ['Mapping, :sig] => sig
;     SAY '"************* USER ERROR **********"
;     SAY("available signatures for ",op,": ")
;     if null mmList
;        then SAY "    NONE"
;        else for [[dc,:sig],:.] in mmList repeat printSignature("     ",op,sig)
;     printSignature("NEED ",op,["?",:argModeList])
;     nil
;   for u in sigl repeat
;     for v in sigl | not (u=v) repeat
;       if SourceLevelSubsume(u,v) then sigl:= delete(v,sigl)
;               --before we complain about duplicate signatures, we should
;               --check that we do not have for example, a partial - as
;               --well as a total one.  SourceLevelSubsume (from CATEGORY BOOT)
;               --should do this
;   1=#sigl => first sigl
;   stackSemanticError(["duplicate signatures for ",op,": ",argModeList],nil)

(DEFUN |getSignature| (|op| |argModeList| |e|)
  (PROG (|ISTMP#1| |dc| |sig| |ISTMP#2| |ISTMP#3| |pred| |mmList| |sigl| |u|)
    (RETURN
     (COND
      ((EQL 1
            (LENGTH
             (SETQ |sigl|
                     (REMDUP
                      ((LAMBDA (|bfVar#102| |bfVar#101| |bfVar#100|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#101|)
                                (PROGN
                                 (SETQ |bfVar#100| (CAR |bfVar#101|))
                                 NIL))
                            (RETURN (NREVERSE |bfVar#102|)))
                           (#1='T
                            (AND (CONSP |bfVar#100|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CAR |bfVar#100|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |dc| (CAR |ISTMP#1|))
                                        (SETQ |sig| (CDR |ISTMP#1|))
                                        #1#)))
                                 (PROGN
                                  (SETQ |ISTMP#2| (CDR |bfVar#100|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                        (AND (CONSP |ISTMP#3|)
                                             (PROGN
                                              (SETQ |pred| (CAR |ISTMP#3|))
                                              #1#)))))
                                 (EQ |dc| '$) (EQUAL (CDR |sig|) |argModeList|)
                                 (|known_in_env| |pred| |e|)
                                 (SETQ |bfVar#102| (CONS |sig| |bfVar#102|)))))
                          (SETQ |bfVar#101| (CDR |bfVar#101|))))
                       NIL (SETQ |mmList| (|get| |op| '|modemap| |e|)) NIL)))))
       (CAR |sigl|))
      ((NULL |sigl|)
       (COND
        ((PROGN
          (SETQ |ISTMP#1| (SETQ |u| (|getmode| |op| |e|)))
          (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
               (PROGN (SETQ |sig| (CDR |ISTMP#1|)) #1#)))
         |sig|)
        (#1#
         (PROGN
          (SAY "************* USER ERROR **********")
          (SAY '|available signatures for | |op| '|: |)
          (COND ((NULL |mmList|) (SAY '|    NONE|))
                (#1#
                 ((LAMBDA (|bfVar#104| |bfVar#103|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#104|)
                           (PROGN (SETQ |bfVar#103| (CAR |bfVar#104|)) NIL))
                       (RETURN NIL))
                      (#1#
                       (AND (CONSP |bfVar#103|)
                            (PROGN
                             (SETQ |ISTMP#1| (CAR |bfVar#103|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |dc| (CAR |ISTMP#1|))
                                   (SETQ |sig| (CDR |ISTMP#1|))
                                   #1#)))
                            (|printSignature| '|     | |op| |sig|))))
                     (SETQ |bfVar#104| (CDR |bfVar#104|))))
                  |mmList| NIL)))
          (|printSignature| '|NEED | |op| (CONS '? |argModeList|))
          NIL))))
      (#1#
       (PROGN
        ((LAMBDA (|bfVar#105| |u|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#105|) (PROGN (SETQ |u| (CAR |bfVar#105|)) NIL))
              (RETURN NIL))
             (#1#
              ((LAMBDA (|bfVar#106| |v|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#106|)
                        (PROGN (SETQ |v| (CAR |bfVar#106|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (AND (NULL (EQUAL |u| |v|))
                         (COND
                          ((|SourceLevelSubsume| |u| |v|)
                           (SETQ |sigl| (|delete| |v| |sigl|)))))))
                  (SETQ |bfVar#106| (CDR |bfVar#106|))))
               |sigl| NIL)))
            (SETQ |bfVar#105| (CDR |bfVar#105|))))
         |sigl| NIL)
        (COND ((EQL 1 (LENGTH |sigl|)) (CAR |sigl|))
              (#1#
               (|stackSemanticError|
                (LIST '|duplicate signatures for | |op| '|: | |argModeList|)
                NIL)))))))))

; putInLocalDomainReferences (def := [opName,[lam,varl,body]]) ==
;   $elt: local := ($QuickCode => 'QREFELT; 'ELT)
; --+
;   NRTputInTail CDDADR def
;   def

(DEFUN |putInLocalDomainReferences| (|def|)
  (PROG (|$elt| |body| |varl| |lam| |opName|)
    (DECLARE (SPECIAL |$elt|))
    (RETURN
     (PROGN
      (SETQ |opName| (CAR |def|))
      (SETQ |lam| (CAADR . #1=(|def|)))
      (SETQ |varl| (CADADR . #1#))
      (SETQ |body| (CAR (CDDADR . #1#)))
      (SETQ |$elt| (COND (|$QuickCode| 'QREFELT) ('T 'ELT)))
      (|NRTputInTail| (CDDADR |def|))
      |def|))))

; isLocalFunction(op, e) ==
;     null member(op, $formalArgList) and
;         getmode(op, e) is ['Mapping, :.]

(DEFUN |isLocalFunction| (|op| |e|)
  (PROG (|ISTMP#1|)
    (RETURN
     (AND (NULL (|member| |op| |$formalArgList|))
          (PROGN
           (SETQ |ISTMP#1| (|getmode| |op| |e|))
           (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)))))))

; do_compile(u, e) ==
;   [op,lamExpr] := u
;   if $suffix then
;     $suffix:= $suffix+1
;     op':=
;       opexport:=nil
;       -- FIXME: Used only for side effect on opexport
;       opmodes:=
;         [sel
;           for [[DC, :sig], [., sel]] in get(op, 'modemap, e) |
;             DC='_$ and (opexport:=true) and
;              (and/[modeEqual(x,y) for x in sig for y in $signatureOfForm])]
;       isLocalFunction(op, e) =>
;         if opexport then userError ['%b,op,'%d,'" is local and exported"]
;         INTERN STRCONC(encodeItem $prefix, '";", encodeItem op)
;       encodeFunctionName(op,$functorForm,$signatureOfForm,";",$suffix)
;     u:= [op',lamExpr]
;   optimizedBody:= optimizeFunctionDef u
;   stuffToCompile:=
;     if null $insideCapsuleFunctionIfTrue
;        then optimizedBody
;        else putInLocalDomainReferences optimizedBody
;   $doNotCompileJustPrint=true => (PRETTYPRINT stuffToCompile; op')
;   result:= spadCompileOrSetq stuffToCompile
;   functionStats:=[0,elapsedTime()]
;   $functionStats:= addStats($functionStats,functionStats)
;   printStats functionStats
;   result

(DEFUN |do_compile| (|u| |e|)
  (PROG (|op| |lamExpr| |opexport| |ISTMP#1| DC |sig| |ISTMP#2| |ISTMP#3|
         |ISTMP#4| |sel| |opmodes| |op'| |optimizedBody| |stuffToCompile|
         |result| |functionStats|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |u|))
      (SETQ |lamExpr| (CADR |u|))
      (COND
       (|$suffix| (SETQ |$suffix| (+ |$suffix| 1))
        (SETQ |op'|
                (PROGN
                 (SETQ |opexport| NIL)
                 (SETQ |opmodes|
                         ((LAMBDA (|bfVar#112| |bfVar#108| |bfVar#107|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#108|)
                                   (PROGN
                                    (SETQ |bfVar#107| (CAR |bfVar#108|))
                                    NIL))
                               (RETURN (NREVERSE |bfVar#112|)))
                              (#1='T
                               (AND (CONSP |bfVar#107|)
                                    (PROGN
                                     (SETQ |ISTMP#1| (CAR |bfVar#107|))
                                     (AND (CONSP |ISTMP#1|)
                                          (PROGN
                                           (SETQ DC (CAR |ISTMP#1|))
                                           (SETQ |sig| (CDR |ISTMP#1|))
                                           #1#)))
                                    (PROGN
                                     (SETQ |ISTMP#2| (CDR |bfVar#107|))
                                     (AND (CONSP |ISTMP#2|)
                                          (EQ (CDR |ISTMP#2|) NIL)
                                          (PROGN
                                           (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                           (AND (CONSP |ISTMP#3|)
                                                (PROGN
                                                 (SETQ |ISTMP#4|
                                                         (CDR |ISTMP#3|))
                                                 (AND (CONSP |ISTMP#4|)
                                                      (EQ (CDR |ISTMP#4|) NIL)
                                                      (PROGN
                                                       (SETQ |sel|
                                                               (CAR |ISTMP#4|))
                                                       #1#)))))))
                                    (EQ DC '$) (SETQ |opexport| T)
                                    ((LAMBDA
                                         (|bfVar#111| |bfVar#109| |x|
                                          |bfVar#110| |y|)
                                       (LOOP
                                        (COND
                                         ((OR (ATOM |bfVar#109|)
                                              (PROGN
                                               (SETQ |x| (CAR |bfVar#109|))
                                               NIL)
                                              (ATOM |bfVar#110|)
                                              (PROGN
                                               (SETQ |y| (CAR |bfVar#110|))
                                               NIL))
                                          (RETURN |bfVar#111|))
                                         (#1#
                                          (PROGN
                                           (SETQ |bfVar#111|
                                                   (|modeEqual| |x| |y|))
                                           (COND
                                            ((NOT |bfVar#111|)
                                             (RETURN NIL))))))
                                        (SETQ |bfVar#109| (CDR |bfVar#109|))
                                        (SETQ |bfVar#110| (CDR |bfVar#110|))))
                                     T |sig| NIL |$signatureOfForm| NIL)
                                    (SETQ |bfVar#112|
                                            (CONS |sel| |bfVar#112|)))))
                             (SETQ |bfVar#108| (CDR |bfVar#108|))))
                          NIL (|get| |op| '|modemap| |e|) NIL))
                 (COND
                  ((|isLocalFunction| |op| |e|)
                   (PROGN
                    (COND
                     (|opexport|
                      (|userError|
                       (LIST '|%b| |op| '|%d| " is local and exported"))))
                    (INTERN
                     (STRCONC (|encodeItem| |$prefix|) ";"
                      (|encodeItem| |op|)))))
                  (#1#
                   (|encodeFunctionName| |op| |$functorForm| |$signatureOfForm|
                    '|;| |$suffix|)))))
        (SETQ |u| (LIST |op'| |lamExpr|))))
      (SETQ |optimizedBody| (|optimizeFunctionDef| |u|))
      (SETQ |stuffToCompile|
              (COND ((NULL |$insideCapsuleFunctionIfTrue|) |optimizedBody|)
                    (#1# (|putInLocalDomainReferences| |optimizedBody|))))
      (COND
       ((EQUAL |$doNotCompileJustPrint| T)
        (PROGN (PRETTYPRINT |stuffToCompile|) |op'|))
       (#1#
        (PROGN
         (SETQ |result| (|spadCompileOrSetq| |stuffToCompile|))
         (SETQ |functionStats| (LIST 0 (|elapsedTime|)))
         (SETQ |$functionStats| (|addStats| |$functionStats| |functionStats|))
         (|printStats| |functionStats|)
         |result|)))))))

; spadCompileOrSetq (form is [nam,[lam,vl,body]]) ==
;         --bizarre hack to take account of the existence of "known" functions
;         --good for performance (LISPLLIB size, BPI size, NILSEC)
;   CONTAINED("",body) => sayBrightly ['"  ",:bright nam,'" not compiled"]
;   if vl is [:vl',E] and body is [nam',: =vl'] then
;       output_lisp_form(['PUT,MKQ nam,MKQ 'SPADreplace,MKQ nam'])
;       sayBrightly ['"     ",:bright nam,'"is replaced by",:bright nam']
;   else if (ATOM body or and/[ATOM x for x in body])
;          and vl is [:vl',E] and not CONTAINED(E,body) then
;            macform := ['XLAM,vl',body]
;            output_lisp_form(['PUT,MKQ nam,MKQ 'SPADreplace,MKQ macform])
;            sayBrightly ['"     ",:bright nam,'"is replaced by",:bright body]
;   $insideCapsuleFunctionIfTrue => first COMP form
;   compileConstructor form

(DEFUN |spadCompileOrSetq| (|form|)
  (PROG (|nam| |lam| |vl| |body| |ISTMP#1| E |vl'| |nam'| |macform|)
    (RETURN
     (PROGN
      (SETQ |nam| (CAR |form|))
      (SETQ |lam| (CAADR . #1=(|form|)))
      (SETQ |vl| (CADADR . #1#))
      (SETQ |body| (CAR (CDDADR . #1#)))
      (COND
       ((CONTAINED '|| |body|)
        (|sayBrightly|
         (CONS "  " (APPEND (|bright| |nam|) (CONS " not compiled" NIL)))))
       (#2='T
        (PROGN
         (COND
          ((AND (CONSP |vl|) (PROGN (SETQ |ISTMP#1| (REVERSE |vl|)) #2#)
                (CONSP |ISTMP#1|)
                (PROGN
                 (SETQ E (CAR |ISTMP#1|))
                 (SETQ |vl'| (CDR |ISTMP#1|))
                 #2#)
                (PROGN (SETQ |vl'| (NREVERSE |vl'|)) #2#) (CONSP |body|)
                (PROGN (SETQ |nam'| (CAR |body|)) #2#)
                (EQUAL (CDR |body|) |vl'|))
           (|output_lisp_form|
            (LIST 'PUT (MKQ |nam|) (MKQ '|SPADreplace|) (MKQ |nam'|)))
           (|sayBrightly|
            (CONS "     "
                  (APPEND (|bright| |nam|)
                          (CONS "is replaced by" (|bright| |nam'|))))))
          ((AND
            (OR (ATOM |body|)
                ((LAMBDA (|bfVar#114| |bfVar#113| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#113|)
                          (PROGN (SETQ |x| (CAR |bfVar#113|)) NIL))
                      (RETURN |bfVar#114|))
                     (#2#
                      (PROGN
                       (SETQ |bfVar#114| (ATOM |x|))
                       (COND ((NOT |bfVar#114|) (RETURN NIL))))))
                    (SETQ |bfVar#113| (CDR |bfVar#113|))))
                 T |body| NIL))
            (CONSP |vl|) (PROGN (SETQ |ISTMP#1| (REVERSE |vl|)) #2#)
            (CONSP |ISTMP#1|)
            (PROGN (SETQ E (CAR |ISTMP#1|)) (SETQ |vl'| (CDR |ISTMP#1|)) #2#)
            (PROGN (SETQ |vl'| (NREVERSE |vl'|)) #2#)
            (NULL (CONTAINED E |body|)))
           (SETQ |macform| (LIST 'XLAM |vl'| |body|))
           (|output_lisp_form|
            (LIST 'PUT (MKQ |nam|) (MKQ '|SPADreplace|) (MKQ |macform|)))
           (|sayBrightly|
            (CONS "     "
                  (APPEND (|bright| |nam|)
                          (CONS "is replaced by" (|bright| |body|)))))))
         (COND (|$insideCapsuleFunctionIfTrue| (CAR (COMP |form|)))
               (#2# (|compileConstructor| |form|))))))))))

; compileConstructor form ==
;   u:= compileConstructor1 form
;   clearClams()                  --clear all CLAMmed functions
;   u

(DEFUN |compileConstructor| (|form|)
  (PROG (|u|)
    (RETURN
     (PROGN (SETQ |u| (|compileConstructor1| |form|)) (|clearClams|) |u|))))

; compileConstructor1 (form:=[fn,[key,vl,:bodyl]]) ==
; -- fn is the name of some category/domain/package constructor;
; -- we will cache all of its values on $ConstructorCache with reference
; -- counts
;   auxfn := INTERNL1(fn, '";")
;   output_lisp_form(["DECLAIM", ["NOTINLINE", auxfn]])
;   if key = 'category_functor
;       then u := compAndDefine form
;       else u := COMP form
;   clearConstructorCache fn      --clear cache for constructor
;   first u

(DEFUN |compileConstructor1| (|form|)
  (PROG (|fn| |key| |vl| |bodyl| |auxfn| |u|)
    (RETURN
     (PROGN
      (SETQ |fn| (CAR |form|))
      (SETQ |key| (CAADR . #1=(|form|)))
      (SETQ |vl| (CADADR . #1#))
      (SETQ |bodyl| (CDDADR . #1#))
      (SETQ |auxfn| (INTERNL1 |fn| ";"))
      (|output_lisp_form| (LIST 'DECLAIM (LIST 'NOTINLINE |auxfn|)))
      (COND
       ((EQ |key| '|category_functor|) (SETQ |u| (|compAndDefine| |form|)))
       ('T (SETQ |u| (COMP |form|))))
      (|clearConstructorCache| |fn|)
      (CAR |u|)))))

; constructMacro (form is [nam,[lam,vl,body]]) ==
;   not (and/[atom x for x in vl]) =>
;     stackSemanticError(["illegal parameters for macro: ",vl],nil)
;   ["XLAM",vl':= [x for x in vl | IDENTP x],body]

(DEFUN |constructMacro| (|form|)
  (PROG (|nam| |lam| |vl| |body| |vl'|)
    (RETURN
     (PROGN
      (SETQ |nam| (CAR |form|))
      (SETQ |lam| (CAADR . #1=(|form|)))
      (SETQ |vl| (CADADR . #1#))
      (SETQ |body| (CAR (CDDADR . #1#)))
      (COND
       ((NULL
         ((LAMBDA (|bfVar#116| |bfVar#115| |x|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#115|) (PROGN (SETQ |x| (CAR |bfVar#115|)) NIL))
               (RETURN |bfVar#116|))
              (#2='T
               (PROGN
                (SETQ |bfVar#116| (ATOM |x|))
                (COND ((NOT |bfVar#116|) (RETURN NIL))))))
             (SETQ |bfVar#115| (CDR |bfVar#115|))))
          T |vl| NIL))
        (|stackSemanticError| (LIST '|illegal parameters for macro: | |vl|)
         NIL))
       (#2#
        (LIST 'XLAM
              (SETQ |vl'|
                      ((LAMBDA (|bfVar#118| |bfVar#117| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#117|)
                                (PROGN (SETQ |x| (CAR |bfVar#117|)) NIL))
                            (RETURN (NREVERSE |bfVar#118|)))
                           (#2#
                            (AND (IDENTP |x|)
                                 (SETQ |bfVar#118| (CONS |x| |bfVar#118|)))))
                          (SETQ |bfVar#117| (CDR |bfVar#117|))))
                       NIL |vl| NIL))
              |body|)))))))

; uncons x ==
;   atom x => x
;   x is ["CONS",a,b] => [a,:uncons b]

(DEFUN |uncons| (|x|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'CONS)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) 'T))))))
            (CONS |a| (|uncons| |b|)))))))

; bootStrapError(functorForm,sourceFile) ==
;   ['COND, _
;     ['$bootStrapMode, _
;         ['VECTOR,mkDomainConstructor functorForm,nil,nil,nil,nil,nil]],
;     [''T, ['systemError, ['LIST, ''%b, MKQ first functorForm, ''%d, '"from", _
;       ''%b,MKQ namestring sourceFile,''%d,'"needs to be compiled"]]]]

(DEFUN |bootStrapError| (|functorForm| |sourceFile|)
  (PROG ()
    (RETURN
     (LIST 'COND
           (LIST '|$bootStrapMode|
                 (LIST 'VECTOR (|mkDomainConstructor| |functorForm|) NIL NIL
                       NIL NIL NIL))
           (LIST ''T
                 (LIST '|systemError|
                       (LIST 'LIST ''|%b| (MKQ (CAR |functorForm|)) ''|%d|
                             "from" ''|%b| (MKQ (|namestring| |sourceFile|))
                             ''|%d| "needs to be compiled")))))))

; compAdd(['add,$addForm,capsule],m,e) ==
;   addForm := $addForm
;   $bootStrapMode = true =>
;     if addForm is ["@Tuple", :.] then code := nil
;        else [code, m, e]:= comp(addForm, m, e)
;     [['COND, _
;        ['$bootStrapMode, _
;            code],_
;        [''T, ['systemError, ['LIST, ''%b, MKQ first $functorForm, ''%d,
;          '"from", ''%b, MKQ namestring($edit_file), ''%d, _
;          '"needs to be compiled"]]]],
;      m, e]
;   $addFormLhs: local:= addForm
;   if addForm is ["SubDomain", domainForm, predicate] then
; --+
;     $NRTaddForm := domainForm
;     NRTgetLocalIndex(domainForm, e)
;     --need to generate slot for add form since all $ go-get
;     --  slots will need to access it
;     [$addForm, m1, e] := compSubDomain1(domainForm, predicate, m, e)
;   else
; --+
;     $NRTaddForm := addForm
;     [$addForm, m1, e]:=
;         addForm is ["@Tuple", :.] => BREAK()
;         compOrCroak(addForm, $EmptyMode, e)
;   not(isCategoryForm(m1)) or m1 = '(Category) =>
;       userError(concat('"need domain before 'add', got", addForm,
;                        '"of type", m1))
;   compCapsule(capsule,m,e)

(DEFUN |compAdd| (|bfVar#119| |m| |e|)
  (PROG (|$addFormLhs| |$addForm| |m1| |predicate| |ISTMP#2| |domainForm|
         |ISTMP#1| |LETTMP#1| |code| |addForm| |capsule|)
    (DECLARE (SPECIAL |$addFormLhs| |$addForm|))
    (RETURN
     (PROGN
      (SETQ |$addForm| (CADR . #1=(|bfVar#119|)))
      (SETQ |capsule| (CADDR . #1#))
      (SETQ |addForm| |$addForm|)
      (COND
       ((EQUAL |$bootStrapMode| T)
        (PROGN
         (COND
          ((AND (CONSP |addForm|) (EQ (CAR |addForm|) '|@Tuple|))
           (SETQ |code| NIL))
          (#2='T (SETQ |LETTMP#1| (|comp| |addForm| |m| |e|))
           (SETQ |code| (CAR |LETTMP#1|)) (SETQ |m| (CADR . #3=(|LETTMP#1|)))
           (SETQ |e| (CADDR . #3#)) |LETTMP#1|))
         (LIST
          (LIST 'COND (LIST '|$bootStrapMode| |code|)
                (LIST ''T
                      (LIST '|systemError|
                            (LIST 'LIST ''|%b| (MKQ (CAR |$functorForm|))
                                  ''|%d| "from" ''|%b|
                                  (MKQ (|namestring| |$edit_file|)) ''|%d|
                                  "needs to be compiled"))))
          |m| |e|)))
       (#2#
        (PROGN
         (SETQ |$addFormLhs| |addForm|)
         (COND
          ((AND (CONSP |addForm|) (EQ (CAR |addForm|) '|SubDomain|)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |addForm|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |domainForm| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                            (PROGN (SETQ |predicate| (CAR |ISTMP#2|)) #2#))))))
           (SETQ |$NRTaddForm| |domainForm|)
           (|NRTgetLocalIndex| |domainForm| |e|)
           (SETQ |LETTMP#1|
                   (|compSubDomain1| |domainForm| |predicate| |m| |e|))
           (SETQ |$addForm| (CAR |LETTMP#1|))
           (SETQ |m1| (CADR . #4=(|LETTMP#1|))) (SETQ |e| (CADDR . #4#))
           |LETTMP#1|)
          (#2# (SETQ |$NRTaddForm| |addForm|)
           (SETQ |LETTMP#1|
                   (COND
                    ((AND (CONSP |addForm|) (EQ (CAR |addForm|) '|@Tuple|))
                     (BREAK))
                    (#2# (|compOrCroak| |addForm| |$EmptyMode| |e|))))
           (SETQ |$addForm| (CAR |LETTMP#1|))
           (SETQ |m1| (CADR . #5=(|LETTMP#1|))) (SETQ |e| (CADDR . #5#))
           |LETTMP#1|))
         (COND
          ((OR (NULL (|isCategoryForm| |m1|)) (EQUAL |m1| '(|Category|)))
           (|userError|
            (|concat| "need domain before 'add', got" |addForm| "of type"
             |m1|)))
          (#2# (|compCapsule| |capsule| |m| |e|))))))))))

; compTuple2Record u == ['Record,:[[":",i,x] for i in 1.. for x in rest u]]

(DEFUN |compTuple2Record| (|u|)
  (PROG ()
    (RETURN
     (CONS '|Record|
           ((LAMBDA (|bfVar#121| |i| |bfVar#120| |x|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#120|)
                     (PROGN (SETQ |x| (CAR |bfVar#120|)) NIL))
                 (RETURN (NREVERSE |bfVar#121|)))
                ('T (SETQ |bfVar#121| (CONS (LIST '|:| |i| |x|) |bfVar#121|))))
               (SETQ |i| (+ |i| 1))
               (SETQ |bfVar#120| (CDR |bfVar#120|))))
            NIL 1 (CDR |u|) NIL)))))

; compCapsule(['CAPSULE,:itemList],m,e) ==
;   $bootStrapMode = true =>
;       [bootStrapError($functorForm, $edit_file), m, e]
;   compCapsuleInner(itemList,m,addDomain('_$,e))

(DEFUN |compCapsule| (|bfVar#122| |m| |e|)
  (PROG (|itemList|)
    (RETURN
     (PROGN
      (SETQ |itemList| (CDR |bfVar#122|))
      (COND
       ((EQUAL |$bootStrapMode| T)
        (LIST (|bootStrapError| |$functorForm| |$edit_file|) |m| |e|))
       ('T (|compCapsuleInner| |itemList| |m| (|addDomain| '$ |e|))))))))

; compSubDomain(["SubDomain",domainForm,predicate],m,e) ==
;   $addFormLhs: local:= domainForm
;   $addForm: local := nil
;   $NRTaddForm := domainForm
;   [$addForm,.,e]:= compSubDomain1(domainForm,predicate,m,e)
; --+
;   compCapsule(['CAPSULE],m,e)

(DEFUN |compSubDomain| (|bfVar#123| |m| |e|)
  (PROG (|$addForm| |$addFormLhs| |LETTMP#1| |predicate| |domainForm|)
    (DECLARE (SPECIAL |$addForm| |$addFormLhs|))
    (RETURN
     (PROGN
      (SETQ |domainForm| (CADR . #1=(|bfVar#123|)))
      (SETQ |predicate| (CADDR . #1#))
      (SETQ |$addFormLhs| |domainForm|)
      (SETQ |$addForm| NIL)
      (SETQ |$NRTaddForm| |domainForm|)
      (SETQ |LETTMP#1| (|compSubDomain1| |domainForm| |predicate| |m| |e|))
      (SETQ |$addForm| (CAR |LETTMP#1|))
      (SETQ |e| (CADDR |LETTMP#1|))
      (|compCapsule| (LIST 'CAPSULE) |m| |e|)))))

; compSubDomain1(domainForm,predicate,m,e) ==
;   [.,.,e]:=
;     compMakeDeclaration([":","#1",domainForm],$EmptyMode,addDomain(domainForm,e))
;   u:=
;     compOrCroak(predicate,$Boolean,e) or
;       stackSemanticError(["predicate: ",predicate,
;         " cannot be interpreted with #1: ",domainForm],nil)
;   prefixPredicate:= lispize u.expr
;   $lisplibSuperDomain:=
;     [domainForm,predicate]
;   evalAndRwriteLispForm('evalOnLoad2,
;     ['SETQ,'$CategoryFrame,['put,op':= ['QUOTE,$op],'
;      (QUOTE SuperDomain),dF':= ['QUOTE,domainForm],['put,dF','(QUOTE SubDomain),[
;        'CONS,['QUOTE,[$op,:prefixPredicate]],['DELASC,op',['get,dF','
;          (QUOTE SubDomain),'$CategoryFrame]]],'$CategoryFrame]]])
;   [domainForm,m,e]

(DEFUN |compSubDomain1| (|domainForm| |predicate| |m| |e|)
  (PROG (|LETTMP#1| |u| |prefixPredicate| |op'| |dF'|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1|
              (|compMakeDeclaration| (LIST '|:| '|#1| |domainForm|)
               |$EmptyMode| (|addDomain| |domainForm| |e|)))
      (SETQ |e| (CADDR |LETTMP#1|))
      (SETQ |u|
              (OR (|compOrCroak| |predicate| |$Boolean| |e|)
                  (|stackSemanticError|
                   (LIST '|predicate: | |predicate|
                         '| cannot be interpreted with #1: | |domainForm|)
                   NIL)))
      (SETQ |prefixPredicate| (|lispize| (CAR |u|)))
      (SETQ |$lisplibSuperDomain| (LIST |domainForm| |predicate|))
      (|evalAndRwriteLispForm| '|evalOnLoad2|
       (LIST 'SETQ '|$CategoryFrame|
             (LIST '|put| (SETQ |op'| (LIST 'QUOTE |$op|)) ''|SuperDomain|
                   (SETQ |dF'| (LIST 'QUOTE |domainForm|))
                   (LIST '|put| |dF'| ''|SubDomain|
                         (LIST 'CONS
                               (LIST 'QUOTE (CONS |$op| |prefixPredicate|))
                               (LIST 'DELASC |op'|
                                     (LIST '|get| |dF'| ''|SubDomain|
                                           '|$CategoryFrame|)))
                         '|$CategoryFrame|))))
      (LIST |domainForm| |m| |e|)))))

; compCapsuleInner(itemList,m,e) ==
;   e:= addInformation(m,e)
;            --puts a new 'special' property of $Information
;   data:= ["PROGN",:itemList]
;       --RPLACd by compCapsuleItems and Friends
;   e:= compCapsuleItems(itemList,nil,e)
;   localParList:= $functorLocalParameters
;   code:=
;     $insideCategoryIfTrue and not $insideCategoryPackageIfTrue => BREAK()
;     processFunctor($functorForm, $signature, data, localParList, e)
;   [MKPF([code],"PROGN"),m,e]

(DEFUN |compCapsuleInner| (|itemList| |m| |e|)
  (PROG (|data| |localParList| |code|)
    (RETURN
     (PROGN
      (SETQ |e| (|addInformation| |m| |e|))
      (SETQ |data| (CONS 'PROGN |itemList|))
      (SETQ |e| (|compCapsuleItems| |itemList| NIL |e|))
      (SETQ |localParList| |$functorLocalParameters|)
      (SETQ |code|
              (COND
               ((AND |$insideCategoryIfTrue|
                     (NULL |$insideCategoryPackageIfTrue|))
                (BREAK))
               ('T
                (|processFunctor| |$functorForm| |$signature| |data|
                 |localParList| |e|))))
      (LIST (MKPF (LIST |code|) 'PROGN) |m| |e|)))))

; processFunctor(form,signature,data,localParList,e) ==
;   buildFunctor(form, signature, data, localParList, $domainShell, e)

(DEFUN |processFunctor| (|form| |signature| |data| |localParList| |e|)
  (PROG ()
    (RETURN
     (|buildFunctor| |form| |signature| |data| |localParList| |$domainShell|
      |e|))))

; compCapsuleItems(itemlist, $predl, e) ==
;   $signatureOfForm: local := nil
;   $suffix: local:= 0
;   for item in itemlist repeat e := compSingleCapsuleItem(item, $predl, e)
;   e

(DEFUN |compCapsuleItems| (|itemlist| |$predl| |e|)
  (DECLARE (SPECIAL |$predl|))
  (PROG (|$suffix| |$signatureOfForm|)
    (DECLARE (SPECIAL |$suffix| |$signatureOfForm|))
    (RETURN
     (PROGN
      (SETQ |$signatureOfForm| NIL)
      (SETQ |$suffix| 0)
      ((LAMBDA (|bfVar#124| |item|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#124|) (PROGN (SETQ |item| (CAR |bfVar#124|)) NIL))
            (RETURN NIL))
           ('T (SETQ |e| (|compSingleCapsuleItem| |item| |$predl| |e|))))
          (SETQ |bfVar#124| (CDR |bfVar#124|))))
       |itemlist| NIL)
      |e|))))

; compSingleCapsuleItem(item, $predl, e) ==
;   doIt(macroExpandInPlace(item, e), $predl, e)

(DEFUN |compSingleCapsuleItem| (|item| |$predl| |e|)
  (DECLARE (SPECIAL |$predl|))
  (PROG () (RETURN (|doIt| (|macroExpandInPlace| |item| |e|) |$predl| |e|))))

; doIt(item, $predl, e) ==
;   $GENNO: local:= 0
;   item is ['SEQ,:l,['exit,1,x]] =>
;     RPLACA(item,"PROGN")
;     RPLACA(LASTNODE item,x)
;     for it1 in rest item repeat e := compSingleCapsuleItem(it1, $predl, e)
;         --This will RPLAC as appropriate
;     e
;   isDomainForm(item, e) =>
;      -- convert naked top level domains to import
;     u:= ['import, [first item,:rest item]]
;     userError ["Use: import ", [first item,:rest item]]
;     RPLACA(item,first u)
;     RPLACD(item,rest u)
;     doIt(item, $predl, e)
;   item is [":=", lhs, rhs, :.] =>
;     not (compOrCroak(item, $EmptyMode, e) is [code, ., e]) =>
;       stackSemanticError(["cannot compile assigned value to",:bright lhs],nil)
;       e
;     not (code is ['LET,lhs',rhs',:.] and atom lhs') =>
;       code is ["PROGN",:.] =>
;          stackSemanticError(["multiple assignment ",item," not allowed"],nil)
;          e
;       RPLACA(item,first code)
;       RPLACD(item,rest code)
;       e
;     lhs:= lhs'
;     if not member(IFCAR rhs, $NonMentionableDomainNames) and
;       not MEMQ(lhs, $functorLocalParameters) then
;          $functorLocalParameters:= [:$functorLocalParameters,lhs]
;     if code is ['LET, ., rhs', :.] and isDomainForm(rhs', e) then
;       if lhs="Rep" then
;         -- FIXME: $Representation is set unconditionally, but
;         -- assignment to Rep may be conditional ...
;         $Representation := (get("Rep", 'value, e)).(0)
;            --$Representation bound by compDefineFunctor, used in compNoStacking
; --+
; --+
; --+
;     code is ['LET, :.] =>
;       RPLACA(item,($QuickCode => 'QSETREFV;'SETELT))
;       rhsCode:=
;        rhs'
;       RPLACD(item, ['$, NRTgetLocalIndex(lhs, e), rhsCode])
;       e
;     RPLACA(item,first code)
;     RPLACD(item,rest code)
;     e
;   item is [":", a, t] =>
;       [., ., e] := compOrCroak(item, $EmptyMode, e)
;       e
;   item is ['import,:doms] =>
;      for dom in doms repeat
;        sayBrightly ['"   importing ",:formatUnabbreviated dom]
;      [., ., e] := compOrCroak(item, $EmptyMode, e)
;      RPLACA(item,'PROGN)
;      RPLACD(item,NIL) -- creates a no-op
;      e
;   item is ["IF", :.] => doItIf(item, $predl, e)
;   item is ["where", b, :l] => doItWhere(item, $predl, e)
;   item is ["MDEF", :.] =>
;       [., ., e] := compOrCroak(item, $EmptyMode, e)
;       e
;   item is ['DEF,[op,:.],:.] =>
;     [., ., e] := t := compOrCroak(item, $EmptyMode, e)
;     RPLACA(item,"CodeDefine")
;         --Note that DescendCode, in CodeDefine, is looking for this
;     RPLACD(CADR item,[$signatureOfForm])
;       --This is how the signature is updated for buildFunctor to recognise
; --+
;     functionPart:= ['dispatchFunction,t.expr]
;     RPLACA(CDDR item,functionPart)
;     RPLACD(CDDR item,nil)
;     e
;   u := compOrCroak(item, $EmptyMode, e) =>
;     ([code, ., e] := u; RPLACA(item, first code); RPLACD(item, rest code))
;     e
;   true => cannotDo()

(DEFUN |doIt| (|item| |$predl| |e|)
  (DECLARE (SPECIAL |$predl|))
  (PROG ($GENNO |functionPart| |op| |b| |doms| |LETTMP#1| |t| |a| |rhsCode|
         |rhs'| |lhs'| |code| |rhs| |lhs| |u| |l| |x| |ISTMP#5| |ISTMP#4|
         |ISTMP#3| |ISTMP#2| |ISTMP#1|)
    (DECLARE (SPECIAL $GENNO))
    (RETURN
     (PROGN
      (SETQ $GENNO 0)
      (COND
       ((AND (CONSP |item|) (EQ (CAR |item|) 'SEQ)
             (PROGN
              (SETQ |ISTMP#1| (CDR |item|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1='T)
                   (CONSP |ISTMP#2|)
                   (PROGN
                    (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                    (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) '|exit|)
                         (PROGN
                          (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                          (AND (CONSP |ISTMP#4|) (EQUAL (CAR |ISTMP#4|) 1)
                               (PROGN
                                (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                (AND (CONSP |ISTMP#5|) (EQ (CDR |ISTMP#5|) NIL)
                                     (PROGN
                                      (SETQ |x| (CAR |ISTMP#5|))
                                      #1#)))))))
                   (PROGN (SETQ |l| (CDR |ISTMP#2|)) #1#)
                   (PROGN (SETQ |l| (NREVERSE |l|)) #1#))))
        (PROGN
         (RPLACA |item| 'PROGN)
         (RPLACA (LASTNODE |item|) |x|)
         ((LAMBDA (|bfVar#125| |it1|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#125|)
                   (PROGN (SETQ |it1| (CAR |bfVar#125|)) NIL))
               (RETURN NIL))
              (#1# (SETQ |e| (|compSingleCapsuleItem| |it1| |$predl| |e|))))
             (SETQ |bfVar#125| (CDR |bfVar#125|))))
          (CDR |item|) NIL)
         |e|))
       ((|isDomainForm| |item| |e|)
        (PROGN
         (SETQ |u| (LIST '|import| (CONS (CAR |item|) (CDR |item|))))
         (|userError| (LIST '|Use: import | (CONS (CAR |item|) (CDR |item|))))
         (RPLACA |item| (CAR |u|))
         (RPLACD |item| (CDR |u|))
         (|doIt| |item| |$predl| |e|)))
       ((AND (CONSP |item|) (EQ (CAR |item|) '|:=|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |item|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |lhs| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN (SETQ |rhs| (CAR |ISTMP#2|)) #1#))))))
        (COND
         ((NULL
           (PROGN
            (SETQ |ISTMP#1| (|compOrCroak| |item| |$EmptyMode| |e|))
            (AND (CONSP |ISTMP#1|)
                 (PROGN
                  (SETQ |code| (CAR |ISTMP#1|))
                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                  (AND (CONSP |ISTMP#2|)
                       (PROGN
                        (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                        (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                             (PROGN (SETQ |e| (CAR |ISTMP#3|)) #1#))))))))
          (PROGN
           (|stackSemanticError|
            (CONS '|cannot compile assigned value to| (|bright| |lhs|)) NIL)
           |e|))
         ((NULL
           (AND (CONSP |code|) (EQ (CAR |code|) 'LET)
                (PROGN
                 (SETQ |ISTMP#1| (CDR |code|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |lhs'| (CAR |ISTMP#1|))
                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                       (AND (CONSP |ISTMP#2|)
                            (PROGN (SETQ |rhs'| (CAR |ISTMP#2|)) #1#)))))
                (ATOM |lhs'|)))
          (COND
           ((AND (CONSP |code|) (EQ (CAR |code|) 'PROGN))
            (PROGN
             (|stackSemanticError|
              (LIST '|multiple assignment | |item| '| not allowed|) NIL)
             |e|))
           (#1#
            (PROGN
             (RPLACA |item| (CAR |code|))
             (RPLACD |item| (CDR |code|))
             |e|))))
         (#1#
          (PROGN
           (SETQ |lhs| |lhs'|)
           (COND
            ((AND (NULL (|member| (IFCAR |rhs|) |$NonMentionableDomainNames|))
                  (NULL (MEMQ |lhs| |$functorLocalParameters|)))
             (SETQ |$functorLocalParameters|
                     (APPEND |$functorLocalParameters| (CONS |lhs| NIL)))))
           (COND
            ((AND (CONSP |code|) (EQ (CAR |code|) 'LET)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |code|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN (SETQ |rhs'| (CAR |ISTMP#2|)) #1#)))))
                  (|isDomainForm| |rhs'| |e|))
             (COND
              ((EQ |lhs| '|Rep|)
               (SETQ |$Representation| (ELT (|get| '|Rep| '|value| |e|) 0))))))
           (COND
            ((AND (CONSP |code|) (EQ (CAR |code|) 'LET))
             (PROGN
              (RPLACA |item| (COND (|$QuickCode| 'QSETREFV) (#1# 'SETELT)))
              (SETQ |rhsCode| |rhs'|)
              (RPLACD |item|
                      (LIST '$ (|NRTgetLocalIndex| |lhs| |e|) |rhsCode|))
              |e|))
            (#1#
             (PROGN
              (RPLACA |item| (CAR |code|))
              (RPLACD |item| (CDR |code|))
              |e|)))))))
       ((AND (CONSP |item|) (EQ (CAR |item|) '|:|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |item|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |a| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |t| (CAR |ISTMP#2|)) #1#))))))
        (PROGN
         (SETQ |LETTMP#1| (|compOrCroak| |item| |$EmptyMode| |e|))
         (SETQ |e| (CADDR |LETTMP#1|))
         |e|))
       ((AND (CONSP |item|) (EQ (CAR |item|) '|import|)
             (PROGN (SETQ |doms| (CDR |item|)) #1#))
        (PROGN
         ((LAMBDA (|bfVar#126| |dom|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#126|)
                   (PROGN (SETQ |dom| (CAR |bfVar#126|)) NIL))
               (RETURN NIL))
              (#1#
               (|sayBrightly|
                (CONS "   importing " (|formatUnabbreviated| |dom|)))))
             (SETQ |bfVar#126| (CDR |bfVar#126|))))
          |doms| NIL)
         (SETQ |LETTMP#1| (|compOrCroak| |item| |$EmptyMode| |e|))
         (SETQ |e| (CADDR |LETTMP#1|))
         (RPLACA |item| 'PROGN)
         (RPLACD |item| NIL)
         |e|))
       ((AND (CONSP |item|) (EQ (CAR |item|) 'IF))
        (|doItIf| |item| |$predl| |e|))
       ((AND (CONSP |item|) (EQ (CAR |item|) '|where|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |item|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |b| (CAR |ISTMP#1|))
                    (SETQ |l| (CDR |ISTMP#1|))
                    #1#))))
        (|doItWhere| |item| |$predl| |e|))
       ((AND (CONSP |item|) (EQ (CAR |item|) 'MDEF))
        (PROGN
         (SETQ |LETTMP#1| (|compOrCroak| |item| |$EmptyMode| |e|))
         (SETQ |e| (CADDR |LETTMP#1|))
         |e|))
       ((AND (CONSP |item|) (EQ (CAR |item|) 'DEF)
             (PROGN
              (SETQ |ISTMP#1| (CDR |item|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|)
                         (PROGN (SETQ |op| (CAR |ISTMP#2|)) #1#))))))
        (PROGN
         (SETQ |t| (|compOrCroak| |item| |$EmptyMode| |e|))
         (SETQ |e| (CADDR |t|))
         (RPLACA |item| '|CodeDefine|)
         (RPLACD (CADR |item|) (LIST |$signatureOfForm|))
         (SETQ |functionPart| (LIST '|dispatchFunction| (CAR |t|)))
         (RPLACA (CDDR |item|) |functionPart|)
         (RPLACD (CDDR |item|) NIL)
         |e|))
       ((SETQ |u| (|compOrCroak| |item| |$EmptyMode| |e|))
        (PROGN
         (SETQ |code| (CAR |u|))
         (SETQ |e| (CADDR |u|))
         (RPLACA |item| (CAR |code|))
         (RPLACD |item| (CDR |code|))
         |e|))
       (T (|cannotDo|)))))))

; isMacro(x,e) ==
;   x is ['DEF, [op, :args], signature, body] and
;     null get(op,'modemap,e) and null args and null get(op,'mode,e)
;       and signature is [nil] => body

(DEFUN |isMacro| (|x| |e|)
  (PROG (|ISTMP#1| |ISTMP#2| |op| |args| |ISTMP#3| |signature| |ISTMP#4|
         |body|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) 'DEF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |op| (CAR |ISTMP#2|))
                         (SETQ |args| (CDR |ISTMP#2|))
                         #1='T)))
                  (PROGN
                   (SETQ |ISTMP#3| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#3|)
                        (PROGN
                         (SETQ |signature| (CAR |ISTMP#3|))
                         (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                         (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                              (PROGN (SETQ |body| (CAR |ISTMP#4|)) #1#)))))))
            (NULL (|get| |op| '|modemap| |e|)) (NULL |args|)
            (NULL (|get| |op| '|mode| |e|)) (CONSP |signature|)
            (EQ (CDR |signature|) NIL) (NULL (CAR |signature|)))
       (IDENTITY |body|))))))

; doItIf(item is [., p, x, y], $predl, e) ==
;     olde := e
;     [p', ., e] := comp(p, $Boolean, e) or userError ['"not a Boolean:", p]
;     if x ~= "noBranch" then
;         compSingleCapsuleItem(x, $predl, getSuccessEnvironment(p, e))
;     if y ~= "noBranch" then
;         compSingleCapsuleItem(y, $predl, getInverseEnvironment(p, olde))
;     RPLACA(item, "COND")
;     RPLACD(item, [[p', x], ['(QUOTE T), y]])
;     olde

(DEFUN |doItIf| (|item| |$predl| |e|)
  (DECLARE (SPECIAL |$predl|))
  (PROG (|p| |x| |y| |olde| |LETTMP#1| |p'|)
    (RETURN
     (PROGN
      (SETQ |p| (CADR . #1=(|item|)))
      (SETQ |x| (CADDR . #1#))
      (SETQ |y| (CADDDR . #1#))
      (SETQ |olde| |e|)
      (SETQ |LETTMP#1|
              (OR (|comp| |p| |$Boolean| |e|)
                  (|userError| (LIST "not a Boolean:" |p|))))
      (SETQ |p'| (CAR |LETTMP#1|))
      (SETQ |e| (CADDR |LETTMP#1|))
      (COND
       ((NOT (EQ |x| '|noBranch|))
        (|compSingleCapsuleItem| |x| |$predl|
         (|getSuccessEnvironment| |p| |e|))))
      (COND
       ((NOT (EQ |y| '|noBranch|))
        (|compSingleCapsuleItem| |y| |$predl|
         (|getInverseEnvironment| |p| |olde|))))
      (RPLACA |item| 'COND)
      (RPLACD |item| (LIST (LIST |p'| |x|) (LIST ''T |y|)))
      |olde|))))

; doItWhere(item is [.,form,:exprList], $predl, eInit) ==
;   $insideWhereIfTrue: local:= true
;   e:= eInit
;   u:=
;     for it1 in exprList repeat
;       e := compSingleCapsuleItem(it1, $predl, e)
;   $insideWhereIfTrue:= false
;   form1 := macroExpand(form, eBefore := e)
;   eAfter := compSingleCapsuleItem(form1, $predl, e)
;   eFinal:=
;     del:= deltaContour(eAfter, eBefore) => addContour(del, eInit)
;     eInit
;   RPLACA(item, "PROGN")
;   RPLACD(item, [["PROGN", :exprList], form1])
;   eFinal

(DEFUN |doItWhere| (|item| |$predl| |eInit|)
  (DECLARE (SPECIAL |$predl|))
  (PROG (|$insideWhereIfTrue| |eFinal| |del| |eAfter| |form1| |eBefore| |u| |e|
         |exprList| |form|)
    (DECLARE (SPECIAL |$insideWhereIfTrue|))
    (RETURN
     (PROGN
      (SETQ |form| (CADR . #1=(|item|)))
      (SETQ |exprList| (CDDR . #1#))
      (SETQ |$insideWhereIfTrue| T)
      (SETQ |e| |eInit|)
      (SETQ |u|
              ((LAMBDA (|bfVar#127| |it1|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#127|)
                        (PROGN (SETQ |it1| (CAR |bfVar#127|)) NIL))
                    (RETURN NIL))
                   (#2='T
                    (SETQ |e| (|compSingleCapsuleItem| |it1| |$predl| |e|))))
                  (SETQ |bfVar#127| (CDR |bfVar#127|))))
               |exprList| NIL))
      (SETQ |$insideWhereIfTrue| NIL)
      (SETQ |form1| (|macroExpand| |form| (SETQ |eBefore| |e|)))
      (SETQ |eAfter| (|compSingleCapsuleItem| |form1| |$predl| |e|))
      (SETQ |eFinal|
              (COND
               ((SETQ |del| (|deltaContour| |eAfter| |eBefore|))
                (|addContour| |del| |eInit|))
               (#2# |eInit|)))
      (RPLACA |item| 'PROGN)
      (RPLACD |item| (LIST (CONS 'PROGN |exprList|) |form1|))
      |eFinal|))))

; compJoin(["Join",:argl],m,e) ==
;   catList:= [(compForMode(x,$Category,e) or return 'failed).expr for x in argl]
;   catList='failed => stackSemanticError(["cannot form Join of: ",argl],nil)
;   catList':=
;     [extract for x in catList] where
;       extract() ==
;         x is ["Join", ["mkCategory",:y]] => ["mkCategory",:y]
;         isCategoryForm(x) =>
;           parameters:=
;             union("append"/[getParms(y,e) for y in rest x],parameters)
;               where getParms(y,e) ==
;                 atom y =>
;                   isDomainForm(y,e) => LIST y
;                   nil
;                 y is ['LENGTH,y'] =>
;                   BREAK()
;                   [y,y']
;                 LIST y
;           x
;         x is ["DomainSubstitutionMacro",pl,body] =>
;             parameters := union(pl, parameters)
;             body is ["Join", ["mkCategory",:y]] => ["mkCategory",:y]
;             body
;         x is ["mkCategory",:.] => x
;         atom x and getmode(x,e)=$Category => x
;         stackSemanticError(["invalid argument to Join: ",x],nil)
;         x
;   T:= [wrapDomainSub(parameters,["Join",:catList']),$Category,e]
;   convert(T,m)

(DEFUN |compJoin| (|bfVar#134| |m| |e|)
  (PROG (|argl| |catList| |ISTMP#1| |ISTMP#2| |y| |parameters| |pl| |body|
         |catList'| T$)
    (RETURN
     (PROGN
      (SETQ |argl| (CDR |bfVar#134|))
      (SETQ |catList|
              ((LAMBDA (|bfVar#129| |bfVar#128| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#128|)
                        (PROGN (SETQ |x| (CAR |bfVar#128|)) NIL))
                    (RETURN (NREVERSE |bfVar#129|)))
                   (#1='T
                    (SETQ |bfVar#129|
                            (CONS
                             (CAR
                              (OR (|compForMode| |x| |$Category| |e|)
                                  (RETURN '|failed|)))
                             |bfVar#129|))))
                  (SETQ |bfVar#128| (CDR |bfVar#128|))))
               NIL |argl| NIL))
      (COND
       ((EQ |catList| '|failed|)
        (|stackSemanticError| (LIST '|cannot form Join of: | |argl|) NIL))
       (#1#
        (PROGN
         (SETQ |catList'|
                 ((LAMBDA (|bfVar#131| |bfVar#130| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#130|)
                           (PROGN (SETQ |x| (CAR |bfVar#130|)) NIL))
                       (RETURN (NREVERSE |bfVar#131|)))
                      (#1#
                       (SETQ |bfVar#131|
                               (CONS
                                (COND
                                 ((AND (CONSP |x|) (EQ (CAR |x|) '|Join|)
                                       (PROGN
                                        (SETQ |ISTMP#1| (CDR |x|))
                                        (AND (CONSP |ISTMP#1|)
                                             (EQ (CDR |ISTMP#1|) NIL)
                                             (PROGN
                                              (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                              (AND (CONSP |ISTMP#2|)
                                                   (EQ (CAR |ISTMP#2|)
                                                       '|mkCategory|)
                                                   (PROGN
                                                    (SETQ |y| (CDR |ISTMP#2|))
                                                    #1#))))))
                                  (CONS '|mkCategory| |y|))
                                 ((|isCategoryForm| |x|)
                                  (PROGN
                                   (SETQ |parameters|
                                           (|union|
                                            ((LAMBDA
                                                 (|bfVar#133| |bfVar#132| |y|)
                                               (LOOP
                                                (COND
                                                 ((OR (ATOM |bfVar#132|)
                                                      (PROGN
                                                       (SETQ |y|
                                                               (CAR
                                                                |bfVar#132|))
                                                       NIL))
                                                  (RETURN |bfVar#133|))
                                                 (#1#
                                                  (SETQ |bfVar#133|
                                                          (APPEND |bfVar#133|
                                                                  (|compJoin,getParms|
                                                                   |y| |e|)))))
                                                (SETQ |bfVar#132|
                                                        (CDR |bfVar#132|))))
                                             NIL (CDR |x|) NIL)
                                            |parameters|))
                                   |x|))
                                 ((AND (CONSP |x|)
                                       (EQ (CAR |x|)
                                           '|DomainSubstitutionMacro|)
                                       (PROGN
                                        (SETQ |ISTMP#1| (CDR |x|))
                                        (AND (CONSP |ISTMP#1|)
                                             (PROGN
                                              (SETQ |pl| (CAR |ISTMP#1|))
                                              (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                              (AND (CONSP |ISTMP#2|)
                                                   (EQ (CDR |ISTMP#2|) NIL)
                                                   (PROGN
                                                    (SETQ |body|
                                                            (CAR |ISTMP#2|))
                                                    #1#))))))
                                  (PROGN
                                   (SETQ |parameters|
                                           (|union| |pl| |parameters|))
                                   (COND
                                    ((AND (CONSP |body|)
                                          (EQ (CAR |body|) '|Join|)
                                          (PROGN
                                           (SETQ |ISTMP#1| (CDR |body|))
                                           (AND (CONSP |ISTMP#1|)
                                                (EQ (CDR |ISTMP#1|) NIL)
                                                (PROGN
                                                 (SETQ |ISTMP#2|
                                                         (CAR |ISTMP#1|))
                                                 (AND (CONSP |ISTMP#2|)
                                                      (EQ (CAR |ISTMP#2|)
                                                          '|mkCategory|)
                                                      (PROGN
                                                       (SETQ |y|
                                                               (CDR |ISTMP#2|))
                                                       #1#))))))
                                     (CONS '|mkCategory| |y|))
                                    (#1# |body|))))
                                 ((AND (CONSP |x|)
                                       (EQ (CAR |x|) '|mkCategory|))
                                  |x|)
                                 ((AND (ATOM |x|)
                                       (EQUAL (|getmode| |x| |e|) |$Category|))
                                  |x|)
                                 (#1#
                                  (PROGN
                                   (|stackSemanticError|
                                    (LIST '|invalid argument to Join: | |x|)
                                    NIL)
                                   |x|)))
                                |bfVar#131|))))
                     (SETQ |bfVar#130| (CDR |bfVar#130|))))
                  NIL |catList| NIL))
         (SETQ T$
                 (LIST (|wrapDomainSub| |parameters| (CONS '|Join| |catList'|))
                       |$Category| |e|))
         (|convert| T$ |m|))))))))
(DEFUN |compJoin,getParms| (|y| |e|)
  (PROG (|ISTMP#1| |y'|)
    (RETURN
     (COND
      ((ATOM |y|) (COND ((|isDomainForm| |y| |e|) (LIST |y|)) (#1='T NIL)))
      ((AND (CONSP |y|) (EQ (CAR |y|) 'LENGTH)
            (PROGN
             (SETQ |ISTMP#1| (CDR |y|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |y'| (CAR |ISTMP#1|)) #1#))))
       (PROGN (BREAK) (LIST |y| |y'|)))
      (#1# (LIST |y|))))))

; compForMode(x,m,e) ==
;   $compForModeIfTrue: local:= true
;   comp(x,m,e)

(DEFUN |compForMode| (|x| |m| |e|)
  (PROG (|$compForModeIfTrue|)
    (DECLARE (SPECIAL |$compForModeIfTrue|))
    (RETURN (PROGN (SETQ |$compForModeIfTrue| T) (|comp| |x| |m| |e|)))))

; compMakeCategoryObject(c, e) ==
;   not isCategoryForm(c) => nil
;   u := mkEvalableCategoryForm(c, e) => [c_eval u, $Category, e]
;   nil

(DEFUN |compMakeCategoryObject| (|c| |e|)
  (PROG (|u|)
    (RETURN
     (COND ((NULL (|isCategoryForm| |c|)) NIL)
           ((SETQ |u| (|mkEvalableCategoryForm| |c| |e|))
            (LIST (|c_eval| |u|) |$Category| |e|))
           ('T NIL)))))

; quotifyCategoryArgument x == MKQ x

(DEFUN |quotifyCategoryArgument| (|x|) (PROG () (RETURN (MKQ |x|))))

; makeCategoryForm(c,e) ==
;   not isCategoryForm(c) => nil
;   [x,m,e]:= compOrCroak(c,$EmptyMode,e)
;   [x,e]

(DEFUN |makeCategoryForm| (|c| |e|)
  (PROG (|LETTMP#1| |x| |m|)
    (RETURN
     (COND ((NULL (|isCategoryForm| |c|)) NIL)
           ('T
            (PROGN
             (SETQ |LETTMP#1| (|compOrCroak| |c| |$EmptyMode| |e|))
             (SETQ |x| (CAR |LETTMP#1|))
             (SETQ |m| (CADR . #1=(|LETTMP#1|)))
             (SETQ |e| (CADDR . #1#))
             (LIST |x| |e|)))))))

; mk_acc() == [[], []]

(DEFUN |mk_acc| () (PROG () (RETURN (LIST NIL NIL))))

; push_at_list(ati, acc) == acc.1 := [ati, :acc.1]

(DEFUN |push_at_list| (|ati| |acc|)
  (PROG () (RETURN (SETF (ELT |acc| 1) (CONS |ati| (ELT |acc| 1))))))

; get_at_list(acc) == acc.1

(DEFUN |get_at_list| (|acc|) (PROG () (RETURN (ELT |acc| 1))))

; push_sig_list(sig, acc) == acc.0 := [sig, :acc.0]

(DEFUN |push_sig_list| (|sig| |acc|)
  (PROG () (RETURN (SETF (ELT |acc| 0) (CONS |sig| (ELT |acc| 0))))))

; get_sigs_list(acc) == acc.0

(DEFUN |get_sigs_list| (|acc|) (PROG () (RETURN (ELT |acc| 0))))

; compCategory(x,m,e) ==
;   (m:= resolve(m,["Category"]))=["Category"] and x is ['CATEGORY,
;     domainOrPackage,:l] =>
;       acc := mk_acc()
;       for x in l repeat compCategoryItem(x, nil, acc)
;       rep := mkExplicitCategoryFunction(get_sigs_list(acc), get_at_list(acc))
;     --if inside compDefineCategory, provide for category argument substitution
;       [rep,m,e]
;   systemErrorHere '"compCategory"

(DEFUN |compCategory| (|x| |m| |e|)
  (PROG (|ISTMP#1| |domainOrPackage| |l| |acc| |rep|)
    (RETURN
     (COND
      ((AND
        (EQUAL (SETQ |m| (|resolve| |m| (LIST '|Category|)))
               (LIST '|Category|))
        (CONSP |x|) (EQ (CAR |x|) 'CATEGORY)
        (PROGN
         (SETQ |ISTMP#1| (CDR |x|))
         (AND (CONSP |ISTMP#1|)
              (PROGN
               (SETQ |domainOrPackage| (CAR |ISTMP#1|))
               (SETQ |l| (CDR |ISTMP#1|))
               #1='T))))
       (PROGN
        (SETQ |acc| (|mk_acc|))
        ((LAMBDA (|bfVar#135| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#135|) (PROGN (SETQ |x| (CAR |bfVar#135|)) NIL))
              (RETURN NIL))
             (#1# (|compCategoryItem| |x| NIL |acc|)))
            (SETQ |bfVar#135| (CDR |bfVar#135|))))
         |l| NIL)
        (SETQ |rep|
                (|mkExplicitCategoryFunction| (|get_sigs_list| |acc|)
                 (|get_at_list| |acc|)))
        (LIST |rep| |m| |e|)))
      (#1# (|systemErrorHere| "compCategory"))))))

; mkExplicitCategoryFunction(sigList, atList) ==
;   ["Join",
;     ["mkCategory", ['LIST, :REVERSE sigList], ['LIST,
;       :REVERSE atList], nil, nil]]

(DEFUN |mkExplicitCategoryFunction| (|sigList| |atList|)
  (PROG ()
    (RETURN
     (LIST '|Join|
           (LIST '|mkCategory| (CONS 'LIST (REVERSE |sigList|))
                 (CONS 'LIST (REVERSE |atList|)) NIL NIL)))))

; wrapDomainSub(parameters,x) ==
;    ["DomainSubstitutionMacro",parameters,x]

(DEFUN |wrapDomainSub| (|parameters| |x|)
  (PROG () (RETURN (LIST '|DomainSubstitutionMacro| |parameters| |x|))))

; DomainSubstitutionFunction(definition, parameters,body) ==
;   --see optFunctorBody
;   if parameters then
;     (body:= Subst(definition, parameters,body)) where
;       Subst(definition, parameters,body) ==
;         ATOM body =>
;           MEMQ(body,parameters) => MKQ body
;           body
;         member(body,parameters) =>
;           g:=GENSYM()
;           $extraParms:=PUSH([g,:body],$extraParms)
;            --Used in SetVector12 to generate a substitution list
;            --bound in buildFunctor
;            --For categories, bound and used in compDefineCategory
;           MKQ g
;         first body="QUOTE" => body
;         PAIRP definition and
;             isFunctor first body and
;               first body ~= first definition
;           =>  ['QUOTE,optimize body]
;         [Subst(definition, parameters,u) for u in body]
;   not (body is ["Join",:.]) => body
;   body is ["Join", ["mkCategory", :.]] => body
;   atom definition => body
;   null rest definition => body
;            --should not bother if it will only be called once
;   name := INTERN STRCONC(IFCAR definition, ";CAT")
;   output_lisp_defparameter(name, nil)
;   body:= ["COND",[name],['(QUOTE T),['SETQ,name,body]]]
;   body

(DEFUN |DomainSubstitutionFunction| (|definition| |parameters| |body|)
  (PROG (|ISTMP#1| |ISTMP#2| |name|)
    (RETURN
     (PROGN
      (COND
       (|parameters|
        (SETQ |body|
                (|DomainSubstitutionFunction,Subst| |definition| |parameters|
                 |body|))))
      (COND ((NULL (AND (CONSP |body|) (EQ (CAR |body|) '|Join|))) |body|)
            ((AND (CONSP |body|) (EQ (CAR |body|) '|Join|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |body|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN
                         (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (EQ (CAR |ISTMP#2|) '|mkCategory|))))))
             |body|)
            ((ATOM |definition|) |body|) ((NULL (CDR |definition|)) |body|)
            ('T
             (PROGN
              (SETQ |name| (INTERN (STRCONC (IFCAR |definition|) '|;CAT|)))
              (|output_lisp_defparameter| |name| NIL)
              (SETQ |body|
                      (LIST 'COND (LIST |name|)
                            (LIST ''T (LIST 'SETQ |name| |body|))))
              |body|)))))))
(DEFUN |DomainSubstitutionFunction,Subst| (|definition| |parameters| |body|)
  (PROG (|g|)
    (RETURN
     (COND
      ((ATOM |body|)
       (COND ((MEMQ |body| |parameters|) (MKQ |body|)) (#1='T |body|)))
      ((|member| |body| |parameters|)
       (PROGN
        (SETQ |g| (GENSYM))
        (SETQ |$extraParms| (PUSH (CONS |g| |body|) |$extraParms|))
        (MKQ |g|)))
      ((EQ (CAR |body|) 'QUOTE) |body|)
      ((AND (CONSP |definition|) (|isFunctor| (CAR |body|))
            (NOT (EQUAL (CAR |body|) (CAR |definition|))))
       (LIST 'QUOTE (|optimize| |body|)))
      (#1#
       ((LAMBDA (|bfVar#137| |bfVar#136| |u|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#136|) (PROGN (SETQ |u| (CAR |bfVar#136|)) NIL))
             (RETURN (NREVERSE |bfVar#137|)))
            (#1#
             (SETQ |bfVar#137|
                     (CONS
                      (|DomainSubstitutionFunction,Subst| |definition|
                       |parameters| |u|)
                      |bfVar#137|))))
           (SETQ |bfVar#136| (CDR |bfVar#136|))))
        NIL |body| NIL))))))

; compCategoryItem(x, predl, acc) ==
;   x is nil => nil
;   --1. if x is a conditional expression, recurse; otherwise, form the predicate
;   x is ["IF",a,b,c] =>
;     predl':= [a,:predl]
;     if b ~= "noBranch" then compCategoryItem(b, predl', acc)
;     c="noBranch" => nil
;     predl':= [["not",a],:predl]
;     compCategoryItem(c, predl', acc)
;   pred:= (predl => MKPF(predl,"AND"); true)
;
;   --2. if attribute, push it and return
;   x is ["ATTRIBUTE", 'nil] => BREAK()
;   x is ["ATTRIBUTE", y] =>
;        -- should generate something else for conditional categories
;        -- BREAK()
;        push_at_list(MKQ [y, pred], acc)
;
;   --3. it may be a list, with PROGN as the CAR, and some information as the CDR
;   x is ["PROGN", :l] => for u in l repeat compCategoryItem(u, predl, acc)
;
; -- 4. otherwise, x gives a signature for a
; --    single operator name or a list of names; if a list of names,
; --    recurse
;   ["SIGNATURE",op,:sig]:= x
;   null atom op =>
;       for y in op repeat compCategoryItem(["SIGNATURE", y, :sig], predl, acc)
;
;   --4. branch on a single type or a signature with source and target
;   push_sig_list(MKQ [rest x, pred], acc)

(DEFUN |compCategoryItem| (|x| |predl| |acc|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |ISTMP#3| |c| |predl'| |pred| |y| |l| |op|
         |sig|)
    (RETURN
     (COND ((NULL |x|) NIL)
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
                                   (PROGN
                                    (SETQ |c| (CAR |ISTMP#3|))
                                    #1='T))))))))
            (PROGN
             (SETQ |predl'| (CONS |a| |predl|))
             (COND
              ((NOT (EQ |b| '|noBranch|))
               (|compCategoryItem| |b| |predl'| |acc|)))
             (COND ((EQ |c| '|noBranch|) NIL)
                   (#1#
                    (PROGN
                     (SETQ |predl'| (CONS (LIST '|not| |a|) |predl|))
                     (|compCategoryItem| |c| |predl'| |acc|))))))
           (#1#
            (PROGN
             (SETQ |pred| (COND (|predl| (MKPF |predl| 'AND)) (#1# T)))
             (COND
              ((AND (CONSP |x|) (EQ (CAR |x|) 'ATTRIBUTE)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |x|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (EQ (CAR |ISTMP#1|) '|nil|))))
               (BREAK))
              ((AND (CONSP |x|) (EQ (CAR |x|) 'ATTRIBUTE)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |x|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
               (|push_at_list| (MKQ (LIST |y| |pred|)) |acc|))
              ((AND (CONSP |x|) (EQ (CAR |x|) 'PROGN)
                    (PROGN (SETQ |l| (CDR |x|)) #1#))
               ((LAMBDA (|bfVar#138| |u|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#138|)
                         (PROGN (SETQ |u| (CAR |bfVar#138|)) NIL))
                     (RETURN NIL))
                    (#1# (|compCategoryItem| |u| |predl| |acc|)))
                   (SETQ |bfVar#138| (CDR |bfVar#138|))))
                |l| NIL))
              (#1#
               (PROGN
                (SETQ |op| (CADR . #2=(|x|)))
                (SETQ |sig| (CDDR . #2#))
                (COND
                 ((NULL (ATOM |op|))
                  ((LAMBDA (|bfVar#139| |y|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#139|)
                            (PROGN (SETQ |y| (CAR |bfVar#139|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (|compCategoryItem| (CONS 'SIGNATURE (CONS |y| |sig|))
                         |predl| |acc|)))
                      (SETQ |bfVar#139| (CDR |bfVar#139|))))
                   |op| NIL))
                 (#1#
                  (|push_sig_list| (MKQ (LIST (CDR |x|) |pred|))
                   |acc|))))))))))))

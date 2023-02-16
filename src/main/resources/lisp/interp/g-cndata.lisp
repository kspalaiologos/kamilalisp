
; )package "BOOT"

(IN-PACKAGE "BOOT")

; mkLowerCaseConTable() ==
; --Table is referenced by functions conPageFastPath and grepForAbbrev
;   $lowerCaseConTb := MAKE_HASHTABLE('EQUAL)
;   for x in allConstructors() repeat augmentLowerCaseConTable x
;   $lowerCaseConTb

(DEFUN |mkLowerCaseConTable| ()
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |$lowerCaseConTb| (MAKE_HASHTABLE 'EQUAL))
      ((LAMBDA (|bfVar#1| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           ('T (|augmentLowerCaseConTable| |x|)))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       (|allConstructors|) NIL)
      |$lowerCaseConTb|))))

; augmentLowerCaseConTable x ==
;   y:=GETDATABASE(x,'ABBREVIATION)
;   item:=[x,y,nil]
;   HPUT($lowerCaseConTb,x,item)
;   HPUT($lowerCaseConTb,DOWNCASE x,item)
;   HPUT($lowerCaseConTb,y,item)

(DEFUN |augmentLowerCaseConTable| (|x|)
  (PROG (|y| |item|)
    (RETURN
     (PROGN
      (SETQ |y| (GETDATABASE |x| 'ABBREVIATION))
      (SETQ |item| (LIST |x| |y| NIL))
      (HPUT |$lowerCaseConTb| |x| |item|)
      (HPUT |$lowerCaseConTb| (DOWNCASE |x|) |item|)
      (HPUT |$lowerCaseConTb| |y| |item|)))))

; getCDTEntry(info,isName) ==
;   not IDENTP info => NIL
;   (entry := HGET($lowerCaseConTb,info)) =>
;     [name,abb,:.] := entry
;     isName and EQ(name,info) => entry
;     not isName and EQ(abb,info) => entry
;     NIL
;   entry

(DEFUN |getCDTEntry| (|info| |isName|)
  (PROG (|entry| |name| |abb|)
    (RETURN
     (COND ((NULL (IDENTP |info|)) NIL)
           ((SETQ |entry| (HGET |$lowerCaseConTb| |info|))
            (PROGN
             (SETQ |name| (CAR |entry|))
             (SETQ |abb| (CADR |entry|))
             (COND ((AND |isName| (EQ |name| |info|)) |entry|)
                   ((AND (NULL |isName|) (EQ |abb| |info|)) |entry|)
                   (#1='T NIL))))
           (#1# |entry|)))))

; abbreviation? abb ==
;   -- if it is an abbreviation, return the corresponding name
;   GETDATABASE(abb,'CONSTRUCTOR)

(DEFUN |abbreviation?| (|abb|)
  (PROG () (RETURN (GETDATABASE |abb| 'CONSTRUCTOR))))

; constructor? name ==
;   -- if it is a constructor name, return the abbreviation
;   GETDATABASE(name,'ABBREVIATION)

(DEFUN |constructor?| (|name|)
  (PROG () (RETURN (GETDATABASE |name| 'ABBREVIATION))))

; domainForm? d ==
;   GETDATABASE(opOf d,'CONSTRUCTORKIND) = 'domain

(DEFUN |domainForm?| (|d|)
  (PROG () (RETURN (EQ (GETDATABASE (|opOf| |d|) 'CONSTRUCTORKIND) '|domain|))))

; packageForm? d ==
;   GETDATABASE(opOf d,'CONSTRUCTORKIND) = 'package

(DEFUN |packageForm?| (|d|)
  (PROG ()
    (RETURN (EQ (GETDATABASE (|opOf| |d|) 'CONSTRUCTORKIND) '|package|))))

; categoryForm? c ==
;   op := opOf c
;   MEMQ(op, $CategoryNames) => true
;   GETDATABASE(op,'CONSTRUCTORKIND) = 'category => true
;   nil

(DEFUN |categoryForm?| (|c|)
  (PROG (|op|)
    (RETURN
     (PROGN
      (SETQ |op| (|opOf| |c|))
      (COND ((MEMQ |op| |$CategoryNames|) T)
            ((EQ (GETDATABASE |op| 'CONSTRUCTORKIND) '|category|) T)
            ('T NIL))))))

; getImmediateSuperDomain(d) ==
;   IFCAR GETDATABASE(opOf d, 'SUPERDOMAIN)

(DEFUN |getImmediateSuperDomain| (|d|)
  (PROG () (RETURN (IFCAR (GETDATABASE (|opOf| |d|) 'SUPERDOMAIN)))))

; maximalSuperType d ==
;   d' := GETDATABASE(opOf d, 'SUPERDOMAIN) => maximalSuperType first d'
;   d

(DEFUN |maximalSuperType| (|d|)
  (PROG (|d'|)
    (RETURN
     (COND
      ((SETQ |d'| (GETDATABASE (|opOf| |d|) 'SUPERDOMAIN))
       (|maximalSuperType| (CAR |d'|)))
      ('T |d|)))))

; getConstructorAbbreviation op ==
;   constructor?(op) or throwKeyedMsg("S2IL0015",[op])

(DEFUN |getConstructorAbbreviation| (|op|)
  (PROG ()
    (RETURN
     (OR (|constructor?| |op|) (|throwKeyedMsg| 'S2IL0015 (LIST |op|))))))

; mkUserConstructorAbbreviation(c,a,type) ==
;   if not atom c then c := first c  --  Existing constructors will be wrapped
;   constructorAbbreviationErrorCheck(c, a, type)
;   clearClams()
;   clearConstructorCache(c)
;   installConstructor(c)
;   setAutoLoadProperty(c)

(DEFUN |mkUserConstructorAbbreviation| (|c| |a| |type|)
  (PROG ()
    (RETURN
     (PROGN
      (COND ((NULL (ATOM |c|)) (SETQ |c| (CAR |c|))))
      (|constructorAbbreviationErrorCheck| |c| |a| |type|)
      (|clearClams|)
      (|clearConstructorCache| |c|)
      (|installConstructor| |c|)
      (|setAutoLoadProperty| |c|)))))

; abbQuery(x) ==
;   abb := GETDATABASE(x,'ABBREVIATION) =>
;    sayKeyedMsg("S2IZ0001",[abb,GETDATABASE(x,'CONSTRUCTORKIND),x])
;   sayKeyedMsg("S2IZ0003",[x])

(DEFUN |abbQuery| (|x|)
  (PROG (|abb|)
    (RETURN
     (COND
      ((SETQ |abb| (GETDATABASE |x| 'ABBREVIATION))
       (|sayKeyedMsg| 'S2IZ0001
        (LIST |abb| (GETDATABASE |x| 'CONSTRUCTORKIND) |x|)))
      ('T (|sayKeyedMsg| 'S2IZ0003 (LIST |x|)))))))

; installConstructor(cname) ==
;   (entry := getCDTEntry(cname,true)) => entry
;   item := [cname,GETDATABASE(cname,'ABBREVIATION),nil]
;   if BOUNDP '$lowerCaseConTb and $lowerCaseConTb then
;     HPUT($lowerCaseConTb,cname,item)
;     HPUT($lowerCaseConTb,DOWNCASE cname,item)

(DEFUN |installConstructor| (|cname|)
  (PROG (|entry| |item|)
    (RETURN
     (COND ((SETQ |entry| (|getCDTEntry| |cname| T)) |entry|)
           ('T
            (PROGN
             (SETQ |item|
                     (LIST |cname| (GETDATABASE |cname| 'ABBREVIATION) NIL))
             (COND
              ((AND (BOUNDP '|$lowerCaseConTb|) |$lowerCaseConTb|)
               (HPUT |$lowerCaseConTb| |cname| |item|)
               (HPUT |$lowerCaseConTb| (DOWNCASE |cname|) |item|)))))))))

; constructorAbbreviationErrorCheck(c,a,typ) ==
;   siz := SIZE (s := PNAME a)
;   if typ = 'category and siz > 7
;     then throwKeyedErrorMsg('precompilation,"S2IL0021",NIL)
;   if siz > 8 then throwKeyedErrorMsg('precompilation,"S2IL0006",NIL)
;   if s ~= UPCASE s then throwKeyedMsg("S2IL0006",NIL)
;   abb := GETDATABASE(c,'ABBREVIATION)
;   name:= GETDATABASE(a,'CONSTRUCTOR)
;   type := GETDATABASE(c,'CONSTRUCTORKIND)
;   a=abb and c~=name => lisplibError(c,a,typ,abb,name,type,'duplicateAbb)
;   a=name and c~=name => lisplibError(c,a,typ,abb,name,type,'abbIsName)
;   c=name and typ~=type => lisplibError(c,a,typ,abb,name,type,'wrongType)

(DEFUN |constructorAbbreviationErrorCheck| (|c| |a| |typ|)
  (PROG (|s| |siz| |abb| |name| |type|)
    (RETURN
     (PROGN
      (SETQ |siz| (SIZE (SETQ |s| (PNAME |a|))))
      (COND
       ((AND (EQ |typ| '|category|) (< 7 |siz|))
        (|throwKeyedErrorMsg| '|precompilation| 'S2IL0021 NIL)))
      (COND
       ((< 8 |siz|) (|throwKeyedErrorMsg| '|precompilation| 'S2IL0006 NIL)))
      (COND ((NOT (EQUAL |s| (UPCASE |s|))) (|throwKeyedMsg| 'S2IL0006 NIL)))
      (SETQ |abb| (GETDATABASE |c| 'ABBREVIATION))
      (SETQ |name| (GETDATABASE |a| 'CONSTRUCTOR))
      (SETQ |type| (GETDATABASE |c| 'CONSTRUCTORKIND))
      (COND
       ((AND (EQUAL |a| |abb|) (NOT (EQUAL |c| |name|)))
        (|lisplibError| |c| |a| |typ| |abb| |name| |type| '|duplicateAbb|))
       ((AND (EQUAL |a| |name|) (NOT (EQUAL |c| |name|)))
        (|lisplibError| |c| |a| |typ| |abb| |name| |type| '|abbIsName|))
       ((AND (EQUAL |c| |name|) (NOT (EQUAL |typ| |type|)))
        (|lisplibError| |c| |a| |typ| |abb| |name| |type| '|wrongType|)))))))

; abbreviate u ==
;   u is ['Union,:arglist] =>
;     ['Union,:[abbreviate a for a in arglist]]
;   u is [op,:arglist] =>
;     abb := constructor?(op) =>
;       [abb,:condAbbrev(arglist,getPartialConstructorModemapSig(op))]
;     u
;   constructor?(u) or u

(DEFUN |abbreviate| (|u|)
  (PROG (|arglist| |op| |abb|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQ (CAR |u|) '|Union|)
            (PROGN (SETQ |arglist| (CDR |u|)) #1='T))
       (CONS '|Union|
             ((LAMBDA (|bfVar#3| |bfVar#2| |a|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#2|) (PROGN (SETQ |a| (CAR |bfVar#2|)) NIL))
                   (RETURN (NREVERSE |bfVar#3|)))
                  (#1# (SETQ |bfVar#3| (CONS (|abbreviate| |a|) |bfVar#3|))))
                 (SETQ |bfVar#2| (CDR |bfVar#2|))))
              NIL |arglist| NIL)))
      ((AND (CONSP |u|)
            (PROGN (SETQ |op| (CAR |u|)) (SETQ |arglist| (CDR |u|)) #1#))
       (COND
        ((SETQ |abb| (|constructor?| |op|))
         (CONS |abb|
               (|condAbbrev| |arglist|
                (|getPartialConstructorModemapSig| |op|))))
        (#1# |u|)))
      (#1# (OR (|constructor?| |u|) |u|))))))

; unabbrev u == unabbrev1(u,nil)

(DEFUN |unabbrev| (|u|) (PROG () (RETURN (|unabbrev1| |u| NIL))))

; unabbrevAndLoad u == unabbrev1(u,true)

(DEFUN |unabbrevAndLoad| (|u|) (PROG () (RETURN (|unabbrev1| |u| T))))

; isNameOfType x ==
;   (val := get(x,'value,$InteractiveFrame)) and
;     (domain := objMode val) and
;       domain in '((Mode) (Type) (Category)) => true
;   y := opOf unabbrev x
;   constructor? y

(DEFUN |isNameOfType| (|x|)
  (PROG (|val| |domain| |y|)
    (RETURN
     (COND
      ((AND (SETQ |val| (|get| |x| '|value| |$InteractiveFrame|))
            (SETQ |domain| (|objMode| |val|))
            (|member| |domain| '((|Mode|) (|Type|) (|Category|))))
       T)
      ('T (PROGN (SETQ |y| (|opOf| (|unabbrev| |x|))) (|constructor?| |y|)))))))

; unabbrev1(u,modeIfTrue) ==
;   atom u =>
;     modeIfTrue =>
;       d:= isDomainValuedVariable u => u
;       a := abbreviation? u =>
;         GETDATABASE(a,'NILADIC) => [a]
;         largs := ['_$EmptyMode for arg in
;           getPartialConstructorModemapSig(a)]
;         unabbrev1([u,:largs],modeIfTrue)
;       u
;     a:= abbreviation?(u) or u
;     GETDATABASE(a,'NILADIC) => [a]
;     a
;   [op,:arglist] := u
;   op = 'Join => ['Join, :[unabbrev1(x, modeIfTrue) for x in arglist]]
;   d:= isDomainValuedVariable op =>
;     throwKeyedMsg("S2IL0013",[op,d])
;   (r := unabbrevSpecialForms(op,arglist,modeIfTrue)) => r
;   (cname := abbreviation? op) or (constructor?(op) and (cname := op)) =>
;     (r := unabbrevSpecialForms(cname,arglist,modeIfTrue)) => r
;     -- ??? if modeIfTrue then loadIfNecessary cname
;     [cname,:condUnabbrev(op,arglist,
;       getPartialConstructorModemapSig(cname),modeIfTrue)]
;   u

(DEFUN |unabbrev1| (|u| |modeIfTrue|)
  (PROG (|d| |a| |largs| |op| |arglist| |r| |cname|)
    (RETURN
     (COND
      ((ATOM |u|)
       (COND
        (|modeIfTrue|
         (COND ((SETQ |d| (|isDomainValuedVariable| |u|)) |u|)
               ((SETQ |a| (|abbreviation?| |u|))
                (COND ((GETDATABASE |a| 'NILADIC) (LIST |a|))
                      (#1='T
                       (PROGN
                        (SETQ |largs|
                                ((LAMBDA (|bfVar#5| |bfVar#4| |arg|)
                                   (LOOP
                                    (COND
                                     ((OR (ATOM |bfVar#4|)
                                          (PROGN
                                           (SETQ |arg| (CAR |bfVar#4|))
                                           NIL))
                                      (RETURN (NREVERSE |bfVar#5|)))
                                     (#1#
                                      (SETQ |bfVar#5|
                                              (CONS '|$EmptyMode| |bfVar#5|))))
                                    (SETQ |bfVar#4| (CDR |bfVar#4|))))
                                 NIL (|getPartialConstructorModemapSig| |a|)
                                 NIL))
                        (|unabbrev1| (CONS |u| |largs|) |modeIfTrue|)))))
               (#1# |u|)))
        (#1#
         (PROGN
          (SETQ |a| (OR (|abbreviation?| |u|) |u|))
          (COND ((GETDATABASE |a| 'NILADIC) (LIST |a|)) (#1# |a|))))))
      (#1#
       (PROGN
        (SETQ |op| (CAR |u|))
        (SETQ |arglist| (CDR |u|))
        (COND
         ((EQ |op| '|Join|)
          (CONS '|Join|
                ((LAMBDA (|bfVar#7| |bfVar#6| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#6|)
                          (PROGN (SETQ |x| (CAR |bfVar#6|)) NIL))
                      (RETURN (NREVERSE |bfVar#7|)))
                     (#1#
                      (SETQ |bfVar#7|
                              (CONS (|unabbrev1| |x| |modeIfTrue|)
                                    |bfVar#7|))))
                    (SETQ |bfVar#6| (CDR |bfVar#6|))))
                 NIL |arglist| NIL)))
         ((SETQ |d| (|isDomainValuedVariable| |op|))
          (|throwKeyedMsg| 'S2IL0013 (LIST |op| |d|)))
         ((SETQ |r| (|unabbrevSpecialForms| |op| |arglist| |modeIfTrue|)) |r|)
         ((OR (SETQ |cname| (|abbreviation?| |op|))
              (AND (|constructor?| |op|) (SETQ |cname| |op|)))
          (COND
           ((SETQ |r| (|unabbrevSpecialForms| |cname| |arglist| |modeIfTrue|))
            |r|)
           (#1#
            (CONS |cname|
                  (|condUnabbrev| |op| |arglist|
                   (|getPartialConstructorModemapSig| |cname|)
                   |modeIfTrue|)))))
         (#1# |u|))))))))

; unabbrevSpecialForms(op,arglist,modeIfTrue) ==
;   op = 'Mapping => [op,:[unabbrev1(a,modeIfTrue) for a in arglist]]
;   op = 'Union   =>
;     [op,:[unabbrevUnionComponent(a,modeIfTrue) for a in arglist]]
;   op = 'Record =>
;     [op,:[unabbrevRecordComponent(a,modeIfTrue) for a in arglist]]
;   nil

(DEFUN |unabbrevSpecialForms| (|op| |arglist| |modeIfTrue|)
  (PROG ()
    (RETURN
     (COND
      ((EQ |op| '|Mapping|)
       (CONS |op|
             ((LAMBDA (|bfVar#9| |bfVar#8| |a|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#8|) (PROGN (SETQ |a| (CAR |bfVar#8|)) NIL))
                   (RETURN (NREVERSE |bfVar#9|)))
                  (#1='T
                   (SETQ |bfVar#9|
                           (CONS (|unabbrev1| |a| |modeIfTrue|) |bfVar#9|))))
                 (SETQ |bfVar#8| (CDR |bfVar#8|))))
              NIL |arglist| NIL)))
      ((EQ |op| '|Union|)
       (CONS |op|
             ((LAMBDA (|bfVar#11| |bfVar#10| |a|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#10|)
                       (PROGN (SETQ |a| (CAR |bfVar#10|)) NIL))
                   (RETURN (NREVERSE |bfVar#11|)))
                  (#1#
                   (SETQ |bfVar#11|
                           (CONS (|unabbrevUnionComponent| |a| |modeIfTrue|)
                                 |bfVar#11|))))
                 (SETQ |bfVar#10| (CDR |bfVar#10|))))
              NIL |arglist| NIL)))
      ((EQ |op| '|Record|)
       (CONS |op|
             ((LAMBDA (|bfVar#13| |bfVar#12| |a|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#12|)
                       (PROGN (SETQ |a| (CAR |bfVar#12|)) NIL))
                   (RETURN (NREVERSE |bfVar#13|)))
                  (#1#
                   (SETQ |bfVar#13|
                           (CONS (|unabbrevRecordComponent| |a| |modeIfTrue|)
                                 |bfVar#13|))))
                 (SETQ |bfVar#12| (CDR |bfVar#12|))))
              NIL |arglist| NIL)))
      (#1# NIL)))))

; unabbrevRecordComponent(a,modeIfTrue) ==
;   a is ["Declare",b,T] or a is [":",b,T] =>
;     [":",b,unabbrev1(T,modeIfTrue)]
;   userError "wrong format for Record type"

(DEFUN |unabbrevRecordComponent| (|a| |modeIfTrue|)
  (PROG (|ISTMP#1| |b| |ISTMP#2| T$)
    (RETURN
     (COND
      ((OR
        (AND (CONSP |a|) (EQ (CAR |a|) '|Declare|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |a|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |b| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ T$ (CAR |ISTMP#2|)) #1='T))))))
        (AND (CONSP |a|) (EQ (CAR |a|) '|:|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |a|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |b| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ T$ (CAR |ISTMP#2|)) #1#)))))))
       (LIST '|:| |b| (|unabbrev1| T$ |modeIfTrue|)))
      (#1# (|userError| '|wrong format for Record type|))))))

; unabbrevUnionComponent(a,modeIfTrue) ==
;   a is ["Declare",b,T] or a is [":",b,T] =>
;     [":",b,unabbrev1(T,modeIfTrue)]
;   unabbrev1(a, modeIfTrue)

(DEFUN |unabbrevUnionComponent| (|a| |modeIfTrue|)
  (PROG (|ISTMP#1| |b| |ISTMP#2| T$)
    (RETURN
     (COND
      ((OR
        (AND (CONSP |a|) (EQ (CAR |a|) '|Declare|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |a|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |b| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ T$ (CAR |ISTMP#2|)) #1='T))))))
        (AND (CONSP |a|) (EQ (CAR |a|) '|:|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |a|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |b| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ T$ (CAR |ISTMP#2|)) #1#)))))))
       (LIST '|:| |b| (|unabbrev1| T$ |modeIfTrue|)))
      (#1# (|unabbrev1| |a| |modeIfTrue|))))))

; condAbbrev(arglist,argtypes) ==
;   res:= nil
;   for arg in arglist for type in argtypes repeat
;     if categoryForm?(type) then arg:= abbreviate arg
;     res:=[:res,arg]
;   res

(DEFUN |condAbbrev| (|arglist| |argtypes|)
  (PROG (|res|)
    (RETURN
     (PROGN
      (SETQ |res| NIL)
      ((LAMBDA (|bfVar#14| |arg| |bfVar#15| |type|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#14|) (PROGN (SETQ |arg| (CAR |bfVar#14|)) NIL)
                (ATOM |bfVar#15|) (PROGN (SETQ |type| (CAR |bfVar#15|)) NIL))
            (RETURN NIL))
           ('T
            (PROGN
             (COND
              ((|categoryForm?| |type|) (SETQ |arg| (|abbreviate| |arg|))))
             (SETQ |res| (APPEND |res| (CONS |arg| NIL))))))
          (SETQ |bfVar#14| (CDR |bfVar#14|))
          (SETQ |bfVar#15| (CDR |bfVar#15|))))
       |arglist| NIL |argtypes| NIL)
      |res|))))

; condUnabbrev(op,arglist,argtypes,modeIfTrue) ==
;   #arglist ~= #argtypes =>
;     throwKeyedMsg("S2IL0014",[op,plural(#argtypes,'"argument"),
;       bright(#arglist)])
;   [newArg for arg in arglist for type in argtypes] where newArg ==
;     categoryForm?(type) => unabbrev1(arg,modeIfTrue)
;     arg

(DEFUN |condUnabbrev| (|op| |arglist| |argtypes| |modeIfTrue|)
  (PROG ()
    (RETURN
     (COND
      ((NOT (EQL (LENGTH |arglist|) (LENGTH |argtypes|)))
       (|throwKeyedMsg| 'S2IL0014
        (LIST |op| (|plural| (LENGTH |argtypes|) "argument")
              (|bright| (LENGTH |arglist|)))))
      (#1='T
       ((LAMBDA (|bfVar#18| |bfVar#16| |arg| |bfVar#17| |type|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#16|) (PROGN (SETQ |arg| (CAR |bfVar#16|)) NIL)
                 (ATOM |bfVar#17|) (PROGN (SETQ |type| (CAR |bfVar#17|)) NIL))
             (RETURN (NREVERSE |bfVar#18|)))
            (#1#
             (SETQ |bfVar#18|
                     (CONS
                      (COND
                       ((|categoryForm?| |type|)
                        (|unabbrev1| |arg| |modeIfTrue|))
                       (#1# |arg|))
                      |bfVar#18|))))
           (SETQ |bfVar#16| (CDR |bfVar#16|))
           (SETQ |bfVar#17| (CDR |bfVar#17|))))
        NIL |arglist| NIL |argtypes| NIL))))))
